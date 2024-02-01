Return-Path: <netdev+bounces-68181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B034284605E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BE21F224E9
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1825E82C9B;
	Thu,  1 Feb 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZiO3B91"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C0127B42
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813374; cv=none; b=p8AQS8WBREyocXcXR8IresQYsFkgYE0ztiWTXmJuU2IdDhdidK9HKgjTkvwWruBmE0NN0vX6MLiPGv+hOMBbxiFjA0bmwC4hCDmP6b/X0Tx2TPKL120K1PGZlssvtIr2F0jNNSuo+HlxB4SRsZzAUHu/UsLH7ACe7kTZpp4NGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813374; c=relaxed/simple;
	bh=JFxWnHvX2a5wrpXIUyZJQ6nv38E7exfKrGbxtzoJZSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwqRsWxeq2xhxZgldXCXLYapXVIWV8DNxwPD2StNP2WIxjPF7EUwzWbG0EQxcnh2QMlY4WoODt2NY4L+0wSIe38FqTH9LnjHaTEEQhioH+eTq7rOJT6lTKg+60Cj5T5sq0JZXqAuCpbpyGi6ivF9SVR9wE3Jn+s99AIADnSTl0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZiO3B91; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706813368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/6zW3Rul1yFaUI/7rYudRAxby+rk2HzxLexWFGOSB3I=;
	b=FZiO3B91EubDhjkMDs9jce2bxSQg6jiu+IpNJb8P15A5EOAYprUal+iLRIxzGArAAQMZ5R
	Q2/kTrqrHSR6NwDkzYYfUqDWKvh0atJMijBcEuTRanQUddyhLbbEa8697D6KDswHkX0+dH
	EJJeB/mkdCv2a6mV9AN0Pk/TXpguNRM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-W6H9-gY3NFKWP5UG54AogQ-1; Thu, 01 Feb 2024 13:49:26 -0500
X-MC-Unique: W6H9-gY3NFKWP5UG54AogQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40ef6441d1aso1520745e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 10:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813365; x=1707418165;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6zW3Rul1yFaUI/7rYudRAxby+rk2HzxLexWFGOSB3I=;
        b=LFQ2YSPf8W9i744a4RRTZsMllJRhGZ1pO2hYKPxpmahDAwKaf5DVgrdo6GNKIYoi4Z
         6VM6COiQlDhS6d6hB8SSGYXfmXhQjRHbTOtM1fP//11EJRucQEU84Z/7Xbm9+8drRcJp
         CWO5kxirUQ25vqxFShnRoq4OxuhiBlXCzsK9AgdkD41UpzKIg8w5fvhC8AKLEaqx5ptP
         HZpIA2VyCW749AgXc4XlpYntJ2HupUuIDcXbFVtptP6Ksj4H/pYft9FCOmRmfYc8PZI2
         PiiEYSQGFyRMUtG0xEltf7YYw8B/o3JFcaWS71K/owsvpOqaFJiWaXFx72RNt7tuWb39
         ktzA==
X-Gm-Message-State: AOJu0YwrFxibFmnt1I3b/2eiHFnCbKRApQuMo/tfkc5k1UZPcI51syCD
	vM9GmqTVtWBu5XxBWeFcH7+TDHwatU4z/Q4OXyer4tvf/QJ9t5391cr/DYBCkZFerCuie/TFyoo
	f6/ddA+CtMBIMySe3dW3H/YXHCjSmz91uB2YQLiT00XXOT7kccnjLeQ==
X-Received: by 2002:a05:600c:500a:b0:40f:c2fa:67e1 with SMTP id n10-20020a05600c500a00b0040fc2fa67e1mr809048wmr.1.1706813365349;
        Thu, 01 Feb 2024 10:49:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVcLPilZ3a60W/aEj1dZgXLYB4Ex9KMwm8CxSClYwcYdHLU5UJYzkFUbhfThVIvQqrQSaICA==
X-Received: by 2002:a05:600c:500a:b0:40f:c2fa:67e1 with SMTP id n10-20020a05600c500a00b0040fc2fa67e1mr809034wmr.1.1706813364913;
        Thu, 01 Feb 2024 10:49:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXv97/0RAIWYbhcHLf68G/kbEPk6c2rGRxRgBskpsTo9hMqjjiX3EiU760FtkTIpVVHkEdP7FPFlSjdtG7qM6PC3mW3oOuh9SI2MiOCpATplDVYC4QNQylfSOdyKI52rAA+0xJt4nne6ksEcPpAiGNI4KYByCes/hCOuSCGYdEkBspSsjLF62jBckEyU/FvpNvBeYRpWSAshFM=
Received: from gerbillo.redhat.com (146-241-238-90.dyn.eolo.it. [146.241.238.90])
        by smtp.gmail.com with ESMTPSA id az6-20020a05600c600600b0040ef04987e7sm381135wmb.16.2024.02.01.10.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:49:24 -0800 (PST)
Message-ID: <9259d368c091b071d16bd1969240f4e9dffe92fb.camel@redhat.com>
Subject: Re: [PATCH net] netdevsim: avoid potential loop in
 nsim_dev_trap_report_work()
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, syzbot
	 <syzkaller@googlegroups.com>, Jiri Pirko <jiri@nvidia.com>
Date: Thu, 01 Feb 2024 19:49:23 +0100
In-Reply-To: <20240201175324.3752746-1-edumazet@google.com>
References: <20240201175324.3752746-1-edumazet@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 17:53 +0000, Eric Dumazet wrote:
> Many syzbot reports include the following trace [1]
>=20
> If nsim_dev_trap_report_work() can not grab the mutex,
> it should rearm itself at least one jiffie later.
>=20
> [1]
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 32383 Comm: kworker/0:2 Not tainted 6.8.0-rc2-syzkaller-00031=
-g861c0981648f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/17/2023
> Workqueue: events nsim_dev_trap_report_work
>  RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:89 [inline]
>  RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
>  RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
>  RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
>  RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
>  RIP: 0010:kasan_check_range+0x101/0x190 mm/kasan/generic.c:189
> Code: 07 49 39 d1 75 0a 45 3a 11 b8 01 00 00 00 7c 0b 44 89 c2 e8 21 ed f=
f ff 83 f0 01 5b 5d 41 5c c3 48 85 d2 74 4f 48 01 ea eb 09 <48> 83 c0 01 48=
 39 d0 74 41 80 38 00 74 f2 eb b6 41 bc 08 00 00 00
> RSP: 0018:ffffc90012dcf998 EFLAGS: 00000046
> RAX: fffffbfff258af1e RBX: fffffbfff258af1f RCX: ffffffff8168eda3
> RDX: fffffbfff258af1f RSI: 0000000000000004 RDI: ffffffff92c578f0
> RBP: fffffbfff258af1e R08: 0000000000000000 R09: fffffbfff258af1e
> R10: ffffffff92c578f3 R11: ffffffff8acbcbc0 R12: 0000000000000002
> R13: ffff88806db38400 R14: 1ffff920025b9f42 R15: ffffffff92c578e8
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c00994e078 CR3: 000000002c250000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>   instrument_atomic_read include/linux/instrumented.h:68 [inline]
>   atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
>   queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
>   debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
>   do_raw_spin_unlock+0x53/0x230 kernel/locking/spinlock_debug.c:141
>   __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:150 [inli=
ne]
>   _raw_spin_unlock_irqrestore+0x22/0x70 kernel/locking/spinlock.c:194
>   debug_object_activate+0x349/0x540 lib/debugobjects.c:726
>   debug_work_activate kernel/workqueue.c:578 [inline]
>   insert_work+0x30/0x230 kernel/workqueue.c:1650
>   __queue_work+0x62e/0x11d0 kernel/workqueue.c:1802
>   __queue_delayed_work+0x1bf/0x270 kernel/workqueue.c:1953
>   queue_delayed_work_on+0x106/0x130 kernel/workqueue.c:1989
>   queue_delayed_work include/linux/workqueue.h:563 [inline]
>   schedule_delayed_work include/linux/workqueue.h:677 [inline]
>   nsim_dev_trap_report_work+0x9c0/0xc80 drivers/net/netdevsim/dev.c:842
>   process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
>   process_scheduled_works kernel/workqueue.c:2706 [inline]
>   worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
>   kthread+0x2c6/0x3a0 kernel/kthread.c:388
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
>=20
> Fixes: 012ec02ae441 ("netdevsim: convert driver to use unlocked devlink A=
PI during init/fini")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/netdevsim/dev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index b4d3b9cde8bd685202f135cf9c845d1be76ef428..92a7a36b93ac0cc1b02a551b9=
74fb390254ac484 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -835,14 +835,14 @@ static void nsim_dev_trap_report_work(struct work_s=
truct *work)
>  				      trap_report_dw.work);
>  	nsim_dev =3D nsim_trap_data->nsim_dev;
> =20
> -	/* For each running port and enabled packet trap, generate a UDP
> -	 * packet with a random 5-tuple and report it.
> -	 */
>  	if (!devl_trylock(priv_to_devlink(nsim_dev))) {
> -		schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw, 0);
> +		schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw, 1);

The patch LGTM, thanks!

I'm wondering if we have a similar problem in
devlink_rel_nested_in_notify_work():

	if (!devl_trylock(devlink)) {
		devlink_put(devlink);
		goto reschedule_work;
	}

	//...
reschedule_work:
	schedule_work(&rel->nested_in.notify_work);

And possibly adding 1ms delay there could be problematic?

Cheers,

Paolo


