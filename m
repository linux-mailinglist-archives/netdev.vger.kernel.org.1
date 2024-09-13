Return-Path: <netdev+bounces-128037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB9977916
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4537B20F31
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 07:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30E318A6D6;
	Fri, 13 Sep 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEUH6I66"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB017142E9F
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211068; cv=none; b=N6fSjzU+iUwMSZeGB+n5CIDx4Rpi1eA5znY9amgMKyTOPjZnSs+qzIh6M/e2TmlzvxNqjd4YR0tDeopiKEkcCPtd81ENV6iuwcF42E/3HE5opC2vQSo5EVdiKK5oXV9zBg+/D0bmy6atrnq+r1z32QSr/svpnNLMK9JdfeHOxlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211068; c=relaxed/simple;
	bh=m/TOhyo0qKcdGuE7mAMClBcuUU734KCqRwHn/Mlgx/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssKgJep1pqPzYeR2vB6psC9aTDoyVfxh1LNgmcHaxliO6LFDzpHzAHGPn8YJJtPZ0831a48/M9jDKqytOXthu6G/U4Iezm6f8jMwSLWDOoTvoBHBS+HqUMER37O2Awr3FKEvAX87DwmBl+2/loB3ev+u2YScAjfoH10oBYR5hZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eEUH6I66; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9018103214so244746366b.3
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 00:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726211065; x=1726815865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3fiUxlmnWbOkPAF/rcX2d12DUilbuUA9cQJiukPHxA=;
        b=eEUH6I66uaHIaHVEh1kgtUjzHFlBRK95eR9aHMsCXkeZ35WlZyGAVkEfi3C9A+Znn7
         vxnEKx2fcwGiSYDthcW7e8nmL5G9EhW2EySC1FSUg+04o642Xdm3HDGLUYOMVd3xLJcr
         tn3WF+MbGAEgkXQ0BbDOreLkVMrk2m6cKS74EQ4yoDab8HxB5uFNyyxGHFcxEllOOSz/
         ePgeQ53L4rOu4lQOFp0ZmSG29IHDAYrmet9oK4UefM50EPzCtDgpRpCGQy3ZrvkYWOya
         hOK+OpeV3zCQwsNAD/6gyV/uuX/93UGkkmrdtJzYyCzzHd5EfC0PrRSYPPtMfsIZkUrG
         6XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726211065; x=1726815865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3fiUxlmnWbOkPAF/rcX2d12DUilbuUA9cQJiukPHxA=;
        b=ees3tcQX+Y6e6TefKxjZE30Y12y6/cxjLrFb+n/yo0zW03cXx9ROlqkvy4Mk9NnYZ0
         NycXURWXaWC+UePMU3LybUv6/TYn/AORA62w5NIhNG5CZJoizU61nUfd3OqO8dtPl7FU
         yNKPDGpeUFDVb6Dv4Vkdb5aIXmrLIaBQP8EiwMbyQRDwUmdZECw1S2s2VrrOvbj6BPyX
         FkPhMxTd0pFZ/flEoeEIvyEW6ftviVFQY8UDJm0YTzFok9h7UOIWRhtdd0HVz4vzjryo
         uCV9AOijCRH31gBQKm5e1y/IALZqe5+2K6tJPZPzQYnpolLzqGTqGhdNnja7a3y/iidw
         Ld2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVAwsZpCB5r2WbrA+Mx4fsAyeZLdPM3qlly5cx1QsG/ZUlt+dlEW5mkULdGugIohyGMSiL8U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLjMwaReY2vyX8vRda8dqdapLlYSz/axY2OaDjxnKbfxvLIDJh
	eTemTO2KKiaXh2jmf+q+IMpuLjGP5pzMsDcaog+05+ebfMVLePGklqUxNEQWrtbLK6wZU6gJes6
	d5ySYq4084LyvsXY6KB6BhoLSAGiLIPeW218A
X-Google-Smtp-Source: AGHT+IFfIkdMeP+q1BiNxdtlpV7FksQb6qKgBhZ9q6gP8JrzL/nQOkgybAHK4q4dlI29lKF1+RA035HOh1/2y/q5QdQ=
X-Received: by 2002:a17:907:f1c6:b0:a86:a30f:4aef with SMTP id
 a640c23a62f3a-a9029446fdbmr463847166b.22.1726211064188; Fri, 13 Sep 2024
 00:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071702.221128-1-en-wei.wu@canonical.com>
 <20240912113518.5941b0cf@gmx.net> <CANn89iK31kn7QRcFydsH79Pm_FNUkJXdft=x81jvKD90Z5Y0xg@mail.gmail.com>
 <CAMqyJG1W1ER0Q_poS7HQhsogxr1cBo2inRmyz_y5zxPoMtRhrA@mail.gmail.com>
In-Reply-To: <CAMqyJG1W1ER0Q_poS7HQhsogxr1cBo2inRmyz_y5zxPoMtRhrA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 09:04:09 +0200
Message-ID: <CANn89iJ+ijDsTebhKeviXYyB=NQxP2=srpZ99Jf677+xTe7wqg@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: En-Wei WU <en-wei.wu@canonical.com>
Cc: Peter Seiderer <ps.report@gmx.net>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 7:29=E2=80=AFAM En-Wei WU <en-wei.wu@canonical.com>=
 wrote:
>
> > Could you try the following patch, and compile your test kernel with
> > CONFIG_DEBUG_NET=3Dy ?
> [  323.870221] ------------[ cut here ]------------
> [  323.870226] WARNING: CPU: 2 PID: 26 at include/linux/skbuff.h:2904
> __netif_receive_skb_core.constprop.0+0x201/0x39d0
> [  323.870369] CPU: 2 UID: 0 PID: 26 Comm: ksoftirqd/2 Not tainted
> 6.11.0-rc6-c763c4339688+ #12
> [  323.870372] Hardware name: Dell Inc. Latitude 5340/0SG010, BIOS
> 1.15.0 07/15/2024
> [  323.870373] RIP: 0010:__netif_receive_skb_core.constprop.0+0x201/0x39d=
0
> [  323.870376] Code: 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0
> 7c 08 84 d2 0f 85 b4 24 00 00 41 0f b7 87 ba 00 00 00 29 c3 66 83 f8
> ff 75 04 <0f> 0b 31 db 48 b8 00 00 00 00 00 fc ff df 49 8d 7f 78 48 89
> fa 48
> [  323.870378] RSP: 0018:ffffc90000377838 EFLAGS: 00010246
> [  323.870380] RAX: 000000000000ffff RBX: 00000000ffff0061 RCX: ffff88876=
cf48090
> [  323.870381] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88817=
56b2e7a
> [  323.870382] RBP: ffffc90000377a88 R08: ffff88876cf48184 R09: 000000000=
0000000
> [  323.870383] R10: 0000000000000000 R11: 1ffff1102ead65b9 R12: ffff88817=
56b2dc0
> [  323.870384] R13: ffffc90000377b20 R14: ffff8881635ca000 R15: ffff88817=
56b2dc0
> [  323.870385] FS:  0000000000000000(0000) GS:ffff88876cf00000(0000)
> knlGS:0000000000000000
> [  323.870387] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  323.870388] CR2: 0000769acfa9d080 CR3: 0000000712498000 CR4: 000000000=
0f50ef0
> [  323.870389] PKRU: 55555554
> [  323.870390] Call Trace:
> [  323.870391]  <TASK>
> [  323.870393]  ? show_regs+0x71/0x90
> [  323.870397]  ? __warn+0xce/0x270
> [  323.870399]  ? __netif_receive_skb_core.constprop.0+0x201/0x39d0
> [  323.870401]  ? report_bug+0x2ad/0x300
> [  323.870404]  ? handle_bug+0x46/0x90
> [  323.870407]  ? exc_invalid_op+0x19/0x50
> [  323.870409]  ? asm_exc_invalid_op+0x1b/0x20
> [  323.870413]  ? __netif_receive_skb_core.constprop.0+0x201/0x39d0
> [  323.870415]  ? intel_iommu_iotlb_sync_map+0x1a/0x30
> [  323.870418]  ? iommu_map+0xab/0x140
> [  323.870421]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
> [  323.870423]  ? iommu_dma_map_page+0x159/0x720
> [  323.870425]  ? dma_map_page_attrs+0x568/0xdc0
> [  323.870427]  ? __kasan_slab_alloc+0x9d/0xa0
> [  323.870430]  ? __pfx_dma_map_page_attrs+0x10/0x10
> [  323.870431]  ? __kasan_check_write+0x14/0x30
> [  323.870434]  ? __build_skb_around+0x23a/0x350
> [  323.870437]  __netif_receive_skb_one_core+0xb4/0x1d0
> [  323.870439]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
> [  323.870441]  ? __kasan_check_write+0x14/0x30
> [  323.870443]  ? _raw_spin_lock_irq+0x8b/0x100
> [  323.870445]  __netif_receive_skb+0x21/0x160
> [  323.870447]  process_backlog+0x1c0/0x590
> [  323.870449]  __napi_poll+0xab/0x560
> [  323.870451]  net_rx_action+0x53e/0xd10
> [  323.870453]  ? __pfx_net_rx_action+0x10/0x10
> [  323.870455]  ? __pfx_wake_up_var+0x10/0x10
> [  323.870457]  ? tasklet_action_common.constprop.0+0x22c/0x670
> [  323.870461]  handle_softirqs+0x18f/0x5d0
> [  323.870463]  ? __pfx_run_ksoftirqd+0x10/0x10
> [  323.870465]  run_ksoftirqd+0x3c/0x60
> [  323.870467]  smpboot_thread_fn+0x2f3/0x700
> [  323.870470]  kthread+0x2b5/0x390
> [  323.870472]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [  323.870474]  ? __pfx_kthread+0x10/0x10
> [  323.870476]  ret_from_fork+0x43/0x90
> [  323.870478]  ? __pfx_kthread+0x10/0x10
> [  323.870480]  ret_from_fork_asm+0x1a/0x30
> [  323.870483]  </TASK>
> [  323.870484] ---[ end trace 0000000000000000 ]---
> [  350.300485] Initializing XFRM netlink socket
> [  351.586993] ------------[ cut here ]------------
> [  351.586999] WARNING: CPU: 2 PID: 26 at include/linux/skbuff.h:2904
> dev_gro_receive+0x172c/0x2860
> [  351.587141] CPU: 2 UID: 0 PID: 26 Comm: ksoftirqd/2 Tainted: G
>   W          6.11.0-rc6-c763c4339688+ #12
> [  351.587144] Tainted: [W]=3DWARN
> [  351.587145] Hardware name: Dell Inc. Latitude 5340/0SG010, BIOS
> 1.15.0 07/15/2024
> [  351.587147] RIP: 0010:dev_gro_receive+0x172c/0x2860
> [  351.587149] Code: 07 83 c2 01 38 ca 7c 08 84 c9 0f 85 d2 09 00 00
> 8d 14 c5 00 00 00 00 41 0f b6 45 46 83 e0 c7 09 d0 41 88 45 46 e9 ee
> f9 ff ff <0f> 0b 45 31 f6 e9 64 f7 ff ff 45 31 e4 81 e3 c0 00 00 00 41
> 0f 95
> [  351.587151] RSP: 0018:ffffc90000377aa8 EFLAGS: 00010246
> [  351.587153] RAX: ffff888128d72840 RBX: ffffffff95a0d9c0 RCX: 000000000=
0000000
> [  351.587154] RDX: 000000000000ffff RSI: ffff88876cf52418 RDI: ffff88815=
880ad3a
> [  351.587155] RBP: ffffc90000377b48 R08: 0000000000000000 R09: 000000000=
0000000
> [  351.587156] R10: 1ffff110ed9ea481 R11: 0000000000000000 R12: ffffffff9=
5a0d9d0
> [  351.587157] R13: ffff88815880ac80 R14: 00000000ffff008d R15: ffff88815=
880acb8
> [  351.587159] FS:  0000000000000000(0000) GS:ffff88876cf00000(0000)
> knlGS:0000000000000000
> [  351.587160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  351.587161] CR2: 000078e9ea9e25b0 CR3: 0000000712498000 CR4: 000000000=
0f50ef0
> [  351.587163] PKRU: 55555554
> [  351.587163] Call Trace:
> [  351.587164]  <TASK>
> [  351.587167]  ? show_regs+0x71/0x90
> [  351.587171]  ? __warn+0xce/0x270
> [  351.587173]  ? dev_gro_receive+0x172c/0x2860
> [  351.587175]  ? report_bug+0x2ad/0x300
> [  351.587178]  ? handle_bug+0x46/0x90
> [  351.587181]  ? exc_invalid_op+0x19/0x50
> [  351.587182]  ? asm_exc_invalid_op+0x1b/0x20
> [  351.587187]  ? dev_gro_receive+0x172c/0x2860
> [  351.587188]  ? dev_gro_receive+0xcdd/0x2860
> [  351.587190]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
> [  351.587192]  ? __mutex_lock.constprop.0+0x150/0x1180
> [  351.587195]  napi_gro_receive+0x3a2/0x900
> [  351.587197]  gro_cell_poll+0xe5/0x1d0
> [  351.587200]  __napi_poll+0xab/0x560
> [  351.587202]  net_rx_action+0x53e/0xd10
> [  351.587204]  ? __pfx_net_rx_action+0x10/0x10
> [  351.587206]  ? __pfx_wake_up_var+0x10/0x10
> [  351.587209]  ? tasklet_action_common.constprop.0+0x22c/0x670
> [  351.587212]  handle_softirqs+0x18f/0x5d0
> [  351.587214]  ? __pfx_run_ksoftirqd+0x10/0x10
> [  351.587216]  run_ksoftirqd+0x3c/0x60
> [  351.587218]  smpboot_thread_fn+0x2f3/0x700
> [  351.587220]  kthread+0x2b5/0x390
> [  351.587223]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [  351.587224]  ? __pfx_kthread+0x10/0x10
> [  351.587226]  ret_from_fork+0x43/0x90
> [  351.587229]  ? __pfx_kthread+0x10/0x10
> [  351.587231]  ret_from_fork_asm+0x1a/0x30
> [  351.587234]  </TASK>
> [  351.587235] ---[ end trace 0000000000000000 ]---
>
> Seems like the __netif_receive_skb_core() and dev_gro_receive() are
> the places where it calls skb_reset_mac_len() with skb->mac_header =3D
> ~0U.

Ouch, let me take a look.

