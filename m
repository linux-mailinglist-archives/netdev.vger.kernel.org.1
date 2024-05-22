Return-Path: <netdev+bounces-97609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D558CC547
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063F61F213FB
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD331F17B;
	Wed, 22 May 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUih6YZb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D651411C9;
	Wed, 22 May 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397387; cv=none; b=UrUnP1TbNKOzAnpjjafDVORgnPz6NkQidwGwq+0JZE84g9IwtCNC3Hv4QWON9q8gSUbP4yYa6TGhN8+1SQKReGp/JLqfu5leGcjZr9EdgEqXL/xpo0nBEwnInVtHZJOqndzUmjbrI6xxE2aatFR4RbBIBh/ipLv5EyGRFN1Scp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397387; c=relaxed/simple;
	bh=6wVEcOmYLA6Wiahnby9ve+l4eWI118/LV2kRtsS4oJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayLlOmpJJSRsm3oswGAyS8ToHZEV2/lN2IGQNNkdylGbZk9EurxR+DsaYCcJMYoW7Q1Gk9CKmOZ5HDBAOfj8MhvAB7pPO0feSNnZqThGBGPkgGuebpigyaEtZfxG3yLOhF99Em+XEv8uXYA3LqtgSfoZX4mHIOKzroD9eRMPKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUih6YZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3BCC2BBFC;
	Wed, 22 May 2024 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716397387;
	bh=6wVEcOmYLA6Wiahnby9ve+l4eWI118/LV2kRtsS4oJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUih6YZbr5igts2tzuYJ86YHN0pKsGLmXACuAZexXqBZ9yS5DWxkz3jewmRROywbJ
	 +jL7scAISK6Wz2Cy9Pv1HZhXrOxeGTc/ECbsPhS7B2Dt3/AIybjxxARSCFOxKmAbLR
	 sLYmWqXr5Agsg9kb9prGA6DFZ1GAgznnP55WDVgc8MM0JAVAlJl/N4qemhsyWFMeOo
	 Z8S5Vo/gc3Jxx92tZFNvPyOPbwtuY7+7Egto4CbamKE+NIBXOklx04JcbKAWDLIQ1K
	 lxR7H1SP4VDFjOn5aq05OtwApZOtAc78YkPxoA6iQHyhRt5130GdwMc96kusn4cLoL
	 0lZ0ackAcvAWA==
Date: Wed, 22 May 2024 18:03:02 +0100
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yuehaibing@huawei.com,
	larysa.zaremba@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] ila: avoid genlmsg_reply when not ila_map
 found
Message-ID: <20240522170302.GA883722@kernel.org>
References: <20240522031537.51741-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522031537.51741-1-linma@zju.edu.cn>

On Wed, May 22, 2024 at 11:15:37AM +0800, Lin Ma wrote:
> The current ila_xlat_nl_cmd_get_mapping will call genlmsg_reply even if
> not ila_map found with user provided parameters. Then an empty netlink
> message will be sent and cause a WARNING like below.
> 
> WARNING: CPU: 1 PID: 7709 at include/linux/skbuff.h:2524 __dev_queue_xmit+0x241b/0x3b60 net/core/dev.c:4171
> Modules linked in:
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:skb_assert_len include/linux/skbuff.h:2524 [inline]
> RIP: 0010:__dev_queue_xmit+0x241b/0x3b60 net/core/dev.c:4171
> RSP: 0018:ffffc9000f90f228 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000040000 RSI: ffffffff816968a8 RDI: fffff52001f21e37
> RBP: ffff8881077f2d3a R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000000 R11: 0000000000000000 R12: dffffc0000000000
> R13: 0000000000000000 R14: ffff8881077f2c90 R15: ffff8881077f2c80
> FS:  00007fb8be338700(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c00ca8a000 CR3: 0000000105e17000 CR4: 0000000000150ee0
> Call Trace:
>  <TASK>
>  dev_queue_xmit include/linux/netdevice.h:3008 [inline]
>  __netlink_deliver_tap_skb net/netlink/af_netlink.c:307 [inline]
>  __netlink_deliver_tap net/netlink/af_netlink.c:325 [inline]
>  netlink_deliver_tap+0x9e4/0xc40 net/netlink/af_netlink.c:338
>  __netlink_sendskb net/netlink/af_netlink.c:1263 [inline]
>  netlink_sendskb net/netlink/af_netlink.c:1272 [inline]
>  netlink_unicast+0x6ac/0x7f0 net/netlink/af_netlink.c:1360
>  nlmsg_unicast include/net/netlink.h:1067 [inline]
>  genlmsg_unicast include/net/genetlink.h:372 [inline]
>  genlmsg_reply include/net/genetlink.h:382 [inline]
>  ila_xlat_nl_cmd_get_mapping+0x589/0x950 net/ipv6/ila/ila_xlat.c:493
>  genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:756
>  genl_family_rcv_msg net/netlink/genetlink.c:833 [inline]
>  genl_rcv_msg+0x441/0x780 net/netlink/genetlink.c:850
>  netlink_rcv_skb+0x153/0x400 net/netlink/af_netlink.c:2540
>  genl_rcv+0x24/0x40 net/netlink/genetlink.c:861
>  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>  netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
>  netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
>  sock_sendmsg_nosec net/socket.c:714 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:734
>  ____sys_sendmsg+0x6eb/0x810 net/socket.c:2482
>  ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
>  __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fb8bd68f359
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb8be338168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fb8bd7bbf80 RCX: 00007fb8bd68f359
> RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
> RBP: 00007fb8bd6da498 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc22fb52af R14: 00007fb8be338300 R15: 0000000000022000
> 
> Do nullptr check and assign -EINVAL ret if no ila_map found.
> 
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>  net/ipv6/ila/ila_xlat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
> index 67e8c9440977..63b8fe1b8255 100644
> --- a/net/ipv6/ila/ila_xlat.c
> +++ b/net/ipv6/ila/ila_xlat.c

Hi Lin Ma,

The lines immediately above those covered by this patch are as follows:

	ret = -ESRCH;
	ila = ila_lookup_by_params(&xp, ilan);
	if (ila) {
		ret = ila_dump_info(ila,

> @@ -483,6 +483,8 @@ int ila_xlat_nl_cmd_get_mapping(struct sk_buff *skb, struct genl_info *info)
>  				    info->snd_portid,
>  				    info->snd_seq, 0, msg,
>  				    info->genlhdr->cmd);
> +	} else {
> +		ret = -EINVAL;
>  	}
>  
>  	rcu_read_unlock();

And the lines following, up to the end of the function, are:

	if (ret < 0)
		goto out_free;

	return genlmsg_reply(msg, info);

out_free:
	nlmsg_free(msg);
	return ret;

By my reading, without your patch, if ila is not found (NULL)
then ret will be -ESRCH, and genlmsg_reply will not be called.

I feel that I am missing something here.


