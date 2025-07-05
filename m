Return-Path: <netdev+bounces-204283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA462AF9E68
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 07:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0864481A40
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 05:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE6252910;
	Sat,  5 Jul 2025 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yb07Js06"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD922E3702;
	Sat,  5 Jul 2025 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751694931; cv=none; b=r8FJ/ry6Thes2vW0J6LXS9jjv6mSVDEWcHenM/9NqpVN0R1sd7ilZlr7RJQvTQRyBj0tYJyUIJGMeH+LTtzqK0mj70BW2kCdWEmVQHW5L6CJJWRvFLbHKMvKZ+7GkeEtM2sdKuEGQIebRdGS7oznysOzofrqi8l0Kl4b9YO0kWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751694931; c=relaxed/simple;
	bh=d7/uhSw2VSan58YiIhT9PeVIWmFDPBAlvnKCItow7NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZL6ZU4lUOxmnSwozkjZH7UJKwNrGQ13gVQAX56GmpNfbsTBYRkMHCEkPwGHgPPrfb2CW7IY7+PJFTs3cH3BQPJGxe/NtPyDOeR1NY7POLtsRhfjnJtuu71WqL3gzH3JKX8iNYH/4wVcjA5bBWFywts36hIKUCttqOoOyk5BSdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yb07Js06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8451DC4CEE7;
	Sat,  5 Jul 2025 05:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751694930;
	bh=d7/uhSw2VSan58YiIhT9PeVIWmFDPBAlvnKCItow7NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yb07Js06Vb7lum1Oippkb+vwjc7Yb8ZN+N4EDJFNSAa1fWRsH/MTwAo6pWkWPsM2g
	 In+Y/v+tLgZ08YodJMJGUFSMX+hI4psul4SIQSypaxn3wyySh3Fgq2qE7AYX6w4tXQ
	 qHjKJsL060ChX+N4h5JX8bnLVqP57WVzQjfm8W94=
Date: Sat, 5 Jul 2025 07:55:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: atm: Fix incorrect net_device lec check
Message-ID: <2025070515-deputy-fiber-6520@gregkh>
References: <20250705052805.59618-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705052805.59618-1-linma@zju.edu.cn>

On Sat, Jul 05, 2025 at 01:28:05PM +0800, Lin Ma wrote:
> There are two sites in atm mpoa code that believe the fetched object
> net_device is of lec type. However, both of them do just name checking
> to ensure that the device name starts with "lec" pattern string.
> 
> That is, malicious user can hijack this by creating another device
> starting with that pattern, thereby causing type confusion. For example,
> create a *team* interface with lecX name, bind that interface and send
> messages will get a crash like below:
> 
> [   18.450000] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> [   18.452366] BUG: unable to handle page fault for address: ffff888005702a70
> [   18.454253] #PF: supervisor instruction fetch in kernel mode
> [   18.455058] #PF: error_code(0x0011) - permissions violation
> [   18.455366] PGD 3801067 P4D 3801067 PUD 3802067 PMD 80000000056000e3
> [   18.455725] Oops: 0011 [#1] PREEMPT SMP PTI
> [   18.455966] CPU: 0 PID: 130 Comm: trigger Not tainted 6.1.90 #7
> [   18.456921] RIP: 0010:0xffff888005702a70
> [   18.457151] Code: .....
> [   18.458168] RSP: 0018:ffffc90000677bf8 EFLAGS: 00010286
> [   18.458461] RAX: ffff888005702a70 RBX: ffff888005702000 RCX: 000000000000001b
> [   18.458850] RDX: ffffc90000677c10 RSI: ffff88800565e0a8 RDI: ffff888005702000
> [   18.459248] RBP: ffffc90000677c68 R08: 0000000000000000 R09: 0000000000000000
> [   18.459644] R10: 0000000000000000 R11: ffff888005702a70 R12: ffff88800556c000
> [   18.460033] R13: ffff888005964900 R14: ffff8880054b4000 R15: ffff8880054b5000
> [   18.460425] FS:  0000785e61b5a740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [   18.460872] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   18.461183] CR2: ffff888005702a70 CR3: 00000000054c2000 CR4: 00000000000006f0
> [   18.461580] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   18.461974] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   18.462368] Call Trace:
> [   18.462518]  <TASK>
> [   18.462645]  ? __die_body+0x64/0xb0
> [   18.462856]  ? page_fault_oops+0x353/0x3e0
> [   18.463092]  ? exc_page_fault+0xaf/0xd0
> [   18.463322]  ? asm_exc_page_fault+0x22/0x30
> [   18.463589]  ? msg_from_mpoad+0x431/0x9d0
> [   18.463820]  ? vcc_sendmsg+0x165/0x3b0
> [   18.464031]  vcc_sendmsg+0x20a/0x3b0
> [   18.464238]  ? wake_bit_function+0x80/0x80
> [   18.464511]  __sys_sendto+0x38c/0x3a0
> [   18.464729]  ? percpu_counter_add_batch+0x87/0xb0
> [   18.465002]  __x64_sys_sendto+0x22/0x30
> [   18.465219]  do_syscall_64+0x6c/0xa0
> [   18.465465]  ? preempt_count_add+0x54/0xb0
> [   18.465697]  ? up_read+0x37/0x80
> [   18.465883]  ? do_user_addr_fault+0x25e/0x5b0
> [   18.466126]  ? exit_to_user_mode_prepare+0x12/0xb0
> [   18.466435]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   18.466727] RIP: 0033:0x785e61be4407
> [   18.467948] RSP: 002b:00007ffe61ae2150 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
> [   18.468368] RAX: ffffffffffffffda RBX: 0000785e61b5a740 RCX: 0000785e61be4407
> [   18.468758] RDX: 000000000000019c RSI: 00007ffe61ae21c0 RDI: 0000000000000003
> [   18.469149] RBP: 00007ffe61ae2370 R08: 0000000000000000 R09: 0000000000000000
> [   18.469542] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> [   18.469936] R13: 00007ffe61ae2498 R14: 0000785e61d74000 R15: 000057bddcbabd98
> 
> Correctly validating the net_device object has several methods. For
> example, function xgbe_netdev_event() checks `netdev_ops` field,
> function clip_device_event() checks `type` field. Considering the
> related variable `lec_netdev_ops` is not defined in the same file, so
> introduce another type value `ARPHRD_ATM_LANE` for a simple and correct
> check.
> 
> By the way, this bug dates back to pre-git history (2.3.15), hence use
> the first reference for tracking.
> 
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> ---
> V3 -> V4: Fix the linking issue reported by intel kernel test robot.
>           see details in https://lore.kernel.org/oe-kbuild-all/202507050831.2GTrUnFN-lkp@intel.com/
>           As pointed out by Simon <horms@kernel.org>, not using netdev_ops
>           for check in this case
> 
>  include/uapi/linux/if_arp.h | 1 +
>  net/atm/lec.c               | 1 +
>  net/atm/mpc.c               | 5 ++++-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
> index 4783af9fe520..d61ee711a495 100644
> --- a/include/uapi/linux/if_arp.h
> +++ b/include/uapi/linux/if_arp.h
> @@ -38,6 +38,7 @@
>  #define	ARPHRD_APPLETLK	8		/* APPLEtalk			*/
>  #define ARPHRD_DLCI	15		/* Frame Relay DLCI		*/
>  #define ARPHRD_ATM	19		/* ATM 				*/
> +#define ARPHRD_ATM_LANE	20		/* ATM LAN Emulation		*/
>  #define ARPHRD_METRICOM	23		/* Metricom STRIP (new IANA id)	*/
>  #define	ARPHRD_IEEE1394	24		/* IEEE 1394 IPv4 - RFC 2734	*/
>  #define ARPHRD_EUI64	27		/* EUI-64                       */
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index 73078306504c..dd82a9f203cc 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -745,6 +745,7 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
>  			return -ENOMEM;
>  		dev_lec[i]->netdev_ops = &lec_netdev_ops;
>  		dev_lec[i]->max_mtu = 18190;
> +		dev_lec[i]->type = ARPHRD_ATM_LANE;
>  		snprintf(dev_lec[i]->name, IFNAMSIZ, "lec%d", i);
>  		if (register_netdev(dev_lec[i])) {
>  			free_netdev(dev_lec[i]);
> diff --git a/net/atm/mpc.c b/net/atm/mpc.c
> index 583c27131b7d..4170453bbfd8 100644
> --- a/net/atm/mpc.c
> +++ b/net/atm/mpc.c
> @@ -275,6 +275,9 @@ static struct net_device *find_lec_by_itfnum(int itf)
>  	sprintf(name, "lec%d", itf);
>  	dev = dev_get_by_name(&init_net, name);
>  
> +	if (!dev || dev->type != ARPHRD_ATM_LANE)
> +		return NULL;
> +
>  	return dev;
>  }
>  
> @@ -1006,7 +1009,7 @@ static int mpoa_event_listener(struct notifier_block *mpoa_notifier,
>  	if (!net_eq(dev_net(dev), &init_net))
>  		return NOTIFY_DONE;
>  
> -	if (strncmp(dev->name, "lec", 3))
> +	if (dev->type != ARPHRD_ATM_LANE)
>  		return NOTIFY_DONE; /* we are only interested in lec:s */
>  
>  	switch (event) {
> -- 
> 2.17.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

