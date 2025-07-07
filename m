Return-Path: <netdev+bounces-204656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D735DAFBA36
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32A517DC2E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B4E263899;
	Mon,  7 Jul 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWyzuVLQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684021B4F09
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910962; cv=none; b=reV/GIFXlnHdZXt6j3+487FMHPTCpyIPijBbLDEQIYKuBt5EhZdOM6SZKGqkjwxEEdsSlDvRkqN2hUH6wpVv9phYkYtH1kEla0qaY+h7rKiOM8IAF6EWOFaoECVWbk4lAw1ewoHjsxHCRn92KSYA8deO3aHvfkO7Yhd27wdCgXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910962; c=relaxed/simple;
	bh=vVIc41gik9SVwhmAAI4bLBDXrNxmon2C6F1Prz4QFwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ORUmfe0mCZv4SSINdBQLrQtMa2Gq1LcB9ZeEZrpxJKKwC/pCzmXPBRKOY41bk0wh7Tp429vHD7g/aiiYR5xXKCN9n162XrURKYmI5npyFVZesPi5QEo1P1Vv55nwcKv+WimLfqjUayoqcGcWRz+xysb9PfALL16S1EkE2hGwF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWyzuVLQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235e1d70d67so29802805ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751910960; x=1752515760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PksTskkF7rBf7EDPYnUdjBZbUZnXVQyEOs1jfXyDuSU=;
        b=MWyzuVLQy5q3IvSw5KyeP0eER5alqOq9Yz6I8AYYAKoKyre8b0pGVzn8sM4ZUwFXY3
         a8Ood/+vZqvN9Yzo53SaLOC5Af7/3vFTtKxm6RbXtjr6OTdKgWigvqcF6vPPMYJfGV4O
         A/XYploj/yPPE/X3O789l3MLLemm4e6Py21QFdexR4PAOPul82fSWSfyV8u3NR9RreEA
         IezqsRRVhFEB9Dfcq7Z23hFbTlFB2OEy4ijEbGXl1BEtiYIYxyKzKLYQQHDb6btIxQbg
         fGPKsTlFCwXl1p0x3XTc579PstCHFOdIA3GtwPWfEQCXxPLEArPaEq5LQtw+CuOvpwtx
         s7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751910960; x=1752515760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PksTskkF7rBf7EDPYnUdjBZbUZnXVQyEOs1jfXyDuSU=;
        b=ns5cXn4MXPgI3y9cexlyEuaKy+B6RkGVPstquryYXh7gO5oULZjwY1YUh1dy23+a1C
         izq8JAchcLRlLMvL08BXW5ox//9Nu97p0GDIB/zGctLhSrtkcyu3hI0yQRMkfTpt5a2J
         sctDA45qO91BEQdKsTu3Ht6Ekn9lG+uQN1k5bcdT9YIhAbdrdVDBRYPNgkHx+K2m1XwJ
         7Xlrk9yDqdUE2ydP++R8IzR3HApijZHBJgxHJ6N7RFf9BPGwvqjwSL7KLDlrHO+BZQpT
         mRYM1nhXYGwtWEUsFKPE1fVqJu/U6o6QEAGHjIL2HDsrF4BVBe0DWS5imz6yQuE977zA
         NMcg==
X-Forwarded-Encrypted: i=1; AJvYcCXExR0VU1a/rvLK3Dx1fUmJcXd69rtrEm+gjCsC/7kstBOYWWX+mt0lOAl0opx5o2W1LwaaMLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiJ59HeD7qRZmfzH9B0ajM53W3lf9prWbwdkEN/zyHiI843zS
	Jlzirk7201gJFz5VpUTV7J3oDzxDELcorRTOIbqb33db5QvxkhkdHipigOlUa9PZIbTFonMct+t
	KSmwhUA==
X-Google-Smtp-Source: AGHT+IGjoxuR7J9bZtEWt8qmP1ZiwKO8mmW0f980FXR0GimHGf7SuYCbHMqquUwAkQDFj9sQEueqivHvzgQ=
X-Received: from pgh12.prod.google.com ([2002:a05:6a02:4e0c:b0:b2f:4c1b:e1a0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d50d:b0:237:ec18:ead7
 with SMTP id d9443c01a7336-23c87542792mr214269855ad.24.1751910959676; Mon, 07
 Jul 2025 10:55:59 -0700 (PDT)
Date: Mon,  7 Jul 2025 17:55:58 +0000
In-Reply-To: <20250705052805.59618-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250705052805.59618-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707175558.3137384-1-kuniyu@google.com>
Subject: Re: [PATCH net v4] net: atm: Fix incorrect net_device lec check
From: Kuniyuki Iwashima <kuniyu@google.com>
To: linma@zju.edu.cn
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Lin Ma <linma@zju.edu.cn>
Date: Sat,  5 Jul 2025 13:28:05 +0800
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

20 is assigned to Serial Line.

Given all the recent commits are odd bug fixes and there are more bugs
(e.g. firing netdev watchdog infinitely, lack of netns_immutable, etc),
I'm leaning towards removing lec and mpc completely.  I don't think it's
still used nowadays.


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

