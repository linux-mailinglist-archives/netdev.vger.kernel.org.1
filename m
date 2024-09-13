Return-Path: <netdev+bounces-128030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C5A977852
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 07:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1402A1F24ED9
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B48154C0B;
	Fri, 13 Sep 2024 05:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ay6AyKrr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA013DBBE
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 05:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205359; cv=none; b=LD5MplGVUTy9MLjZ6/p/qCxq03zoRqqUJkHpVdu6uOt05WvwRjM+6K3m1KKclCTxetinCxwjIhPQWbCYQUrouNkh+sRjsbkLaG5kN1P+rk6px7sBC0PBOv8SfAv0FUQobGqagG1wFuS6yYqE32pwDfsR5Apwzr1yLLHvIJgdC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205359; c=relaxed/simple;
	bh=i36nHJhb+mhDmDs01qhl/g2V+MnDbh/PB5LLTGEmjjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdhfySXiMOPbaje9tfvdI+MD17H6hzU80pIerNaxozvoz/Bwpjng0qK0eB13zzESugafux+BpyykgOMpWRARfLWT3guMf3HFtltAGta+DUYWIfJ1yeBShNZxY+xHtbl92cx/tZxBUo8xKycjiT6CqAzBVol/R/HAES9dpr5ouRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ay6AyKrr; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4CC853F5D0
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 05:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726205354;
	bh=92EUoJwt2ZKp3oSoR5M3LANKfaxuxOgoiksADA9lWMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ay6AyKrrjthjgywzVhx5eTEQIDv0zzZGqWLJWLp7pTN0cATxyDO9FB60GyMCbZi0N
	 Ub83JdQxB41yleEjpJsDIwg5+Tm9i/T9bnk+2Mdymj87Qz7SH512S9cNCR6EN6E9D7
	 cWaDb9eWWnvbbqsfkhD1d675ww5kh9ht3SvGLwh1ztBE7AaGU7tSulVXYztR0BQF6b
	 pQLNl9BADv7+54B5UDGg4q1TR5FHsGANQiGFTIvdRlXFLuPOEO+z/+a1iac6/WSzsV
	 XlMH4+8JCwsMdCdb5deT7nPFnMWjvx09J4GB0zhRAcIGDPetqMCNakNkyd7Ws4B7fr
	 UUf1fNd8CUqbA==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374b9a8512dso918132f8f.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 22:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726205354; x=1726810154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92EUoJwt2ZKp3oSoR5M3LANKfaxuxOgoiksADA9lWMs=;
        b=ErI3G5AYav4x+5TDw1bZSq9V//NADbU50GGbJQtP0lBcx/G96SUDmrKvEfkHz/gbhp
         hlRXvw2oIFpopDwkYu+K3ZGjP9ZHGg8FrX+WBgUhgksMJXQv3KHNLH7UAsbx6KJZP+Yk
         nWR/XP6PnrN5B90hCs89Y8Z72cPvWaZdWULhjQeuy3LSgRusR+k27czgIka1d5EuqgGw
         QEVQmyj84Jd3cNonIsT5644C7WC3Ub+gXOPP+pZS+i9ju62YXPJqNljuIpujyPnX2NhE
         NM3RfV5rbs0Xfr8gT3ZHOjNcCcXLU+2lbKr9AYYDXzULfu/MCinm1nUS1wZQdq0fzseK
         yvjA==
X-Forwarded-Encrypted: i=1; AJvYcCXgOao+vEoi5l70eboxSyvTgg4XCt9CoXpCceqmGhwMkoclvX0YToTDKjH/89bYtCgapNJUHzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1G9655imUMTXh8dxdIzPLHp20h8h7C34Ne1EefAqN7qap/Bx
	TpVzXNPWmEycex1uXGHfOH9PYcj2hgEvMBP19+lRfg5dP0BPBcq8cai0FdmY7G9tDGIXurY9sRw
	/xqDHWoz5uUCytRfxyFhzv2WP4p3gwt1BfEoxrh7yd5rGiD2+VdTb0ytw1qm8ugA7T34s1vJRpZ
	OJlK69c2EwAkyhMd7EiOW25j0AeoDazwCuEO7dgNBxs11R
X-Received: by 2002:adf:ea8c:0:b0:368:7583:54c7 with SMTP id ffacd0b85a97d-378c2cd3e6amr3032838f8f.8.1726205353578;
        Thu, 12 Sep 2024 22:29:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdN3cAll1VnF+OmHHfLoPIQAn1sEZeR0CywSLH2y7sFK7SeicuSGTGtbo+RErLvXZpwARUZU/wmhaxPrC79q8=
X-Received: by 2002:adf:ea8c:0:b0:368:7583:54c7 with SMTP id
 ffacd0b85a97d-378c2cd3e6amr3032824f8f.8.1726205352890; Thu, 12 Sep 2024
 22:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071702.221128-1-en-wei.wu@canonical.com>
 <20240912113518.5941b0cf@gmx.net> <CANn89iK31kn7QRcFydsH79Pm_FNUkJXdft=x81jvKD90Z5Y0xg@mail.gmail.com>
In-Reply-To: <CANn89iK31kn7QRcFydsH79Pm_FNUkJXdft=x81jvKD90Z5Y0xg@mail.gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Fri, 13 Sep 2024 13:29:01 +0800
Message-ID: <CAMqyJG1W1ER0Q_poS7HQhsogxr1cBo2inRmyz_y5zxPoMtRhrA@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: Eric Dumazet <edumazet@google.com>
Cc: Peter Seiderer <ps.report@gmx.net>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Could you try the following patch, and compile your test kernel with
> CONFIG_DEBUG_NET=3Dy ?
[  323.870221] ------------[ cut here ]------------
[  323.870226] WARNING: CPU: 2 PID: 26 at include/linux/skbuff.h:2904
__netif_receive_skb_core.constprop.0+0x201/0x39d0
[  323.870369] CPU: 2 UID: 0 PID: 26 Comm: ksoftirqd/2 Not tainted
6.11.0-rc6-c763c4339688+ #12
[  323.870372] Hardware name: Dell Inc. Latitude 5340/0SG010, BIOS
1.15.0 07/15/2024
[  323.870373] RIP: 0010:__netif_receive_skb_core.constprop.0+0x201/0x39d0
[  323.870376] Code: 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0
7c 08 84 d2 0f 85 b4 24 00 00 41 0f b7 87 ba 00 00 00 29 c3 66 83 f8
ff 75 04 <0f> 0b 31 db 48 b8 00 00 00 00 00 fc ff df 49 8d 7f 78 48 89
fa 48
[  323.870378] RSP: 0018:ffffc90000377838 EFLAGS: 00010246
[  323.870380] RAX: 000000000000ffff RBX: 00000000ffff0061 RCX: ffff88876cf=
48090
[  323.870381] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8881756=
b2e7a
[  323.870382] RBP: ffffc90000377a88 R08: ffff88876cf48184 R09: 00000000000=
00000
[  323.870383] R10: 0000000000000000 R11: 1ffff1102ead65b9 R12: ffff8881756=
b2dc0
[  323.870384] R13: ffffc90000377b20 R14: ffff8881635ca000 R15: ffff8881756=
b2dc0
[  323.870385] FS:  0000000000000000(0000) GS:ffff88876cf00000(0000)
knlGS:0000000000000000
[  323.870387] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  323.870388] CR2: 0000769acfa9d080 CR3: 0000000712498000 CR4: 0000000000f=
50ef0
[  323.870389] PKRU: 55555554
[  323.870390] Call Trace:
[  323.870391]  <TASK>
[  323.870393]  ? show_regs+0x71/0x90
[  323.870397]  ? __warn+0xce/0x270
[  323.870399]  ? __netif_receive_skb_core.constprop.0+0x201/0x39d0
[  323.870401]  ? report_bug+0x2ad/0x300
[  323.870404]  ? handle_bug+0x46/0x90
[  323.870407]  ? exc_invalid_op+0x19/0x50
[  323.870409]  ? asm_exc_invalid_op+0x1b/0x20
[  323.870413]  ? __netif_receive_skb_core.constprop.0+0x201/0x39d0
[  323.870415]  ? intel_iommu_iotlb_sync_map+0x1a/0x30
[  323.870418]  ? iommu_map+0xab/0x140
[  323.870421]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[  323.870423]  ? iommu_dma_map_page+0x159/0x720
[  323.870425]  ? dma_map_page_attrs+0x568/0xdc0
[  323.870427]  ? __kasan_slab_alloc+0x9d/0xa0
[  323.870430]  ? __pfx_dma_map_page_attrs+0x10/0x10
[  323.870431]  ? __kasan_check_write+0x14/0x30
[  323.870434]  ? __build_skb_around+0x23a/0x350
[  323.870437]  __netif_receive_skb_one_core+0xb4/0x1d0
[  323.870439]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  323.870441]  ? __kasan_check_write+0x14/0x30
[  323.870443]  ? _raw_spin_lock_irq+0x8b/0x100
[  323.870445]  __netif_receive_skb+0x21/0x160
[  323.870447]  process_backlog+0x1c0/0x590
[  323.870449]  __napi_poll+0xab/0x560
[  323.870451]  net_rx_action+0x53e/0xd10
[  323.870453]  ? __pfx_net_rx_action+0x10/0x10
[  323.870455]  ? __pfx_wake_up_var+0x10/0x10
[  323.870457]  ? tasklet_action_common.constprop.0+0x22c/0x670
[  323.870461]  handle_softirqs+0x18f/0x5d0
[  323.870463]  ? __pfx_run_ksoftirqd+0x10/0x10
[  323.870465]  run_ksoftirqd+0x3c/0x60
[  323.870467]  smpboot_thread_fn+0x2f3/0x700
[  323.870470]  kthread+0x2b5/0x390
[  323.870472]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  323.870474]  ? __pfx_kthread+0x10/0x10
[  323.870476]  ret_from_fork+0x43/0x90
[  323.870478]  ? __pfx_kthread+0x10/0x10
[  323.870480]  ret_from_fork_asm+0x1a/0x30
[  323.870483]  </TASK>
[  323.870484] ---[ end trace 0000000000000000 ]---
[  350.300485] Initializing XFRM netlink socket
[  351.586993] ------------[ cut here ]------------
[  351.586999] WARNING: CPU: 2 PID: 26 at include/linux/skbuff.h:2904
dev_gro_receive+0x172c/0x2860
[  351.587141] CPU: 2 UID: 0 PID: 26 Comm: ksoftirqd/2 Tainted: G
  W          6.11.0-rc6-c763c4339688+ #12
[  351.587144] Tainted: [W]=3DWARN
[  351.587145] Hardware name: Dell Inc. Latitude 5340/0SG010, BIOS
1.15.0 07/15/2024
[  351.587147] RIP: 0010:dev_gro_receive+0x172c/0x2860
[  351.587149] Code: 07 83 c2 01 38 ca 7c 08 84 c9 0f 85 d2 09 00 00
8d 14 c5 00 00 00 00 41 0f b6 45 46 83 e0 c7 09 d0 41 88 45 46 e9 ee
f9 ff ff <0f> 0b 45 31 f6 e9 64 f7 ff ff 45 31 e4 81 e3 c0 00 00 00 41
0f 95
[  351.587151] RSP: 0018:ffffc90000377aa8 EFLAGS: 00010246
[  351.587153] RAX: ffff888128d72840 RBX: ffffffff95a0d9c0 RCX: 00000000000=
00000
[  351.587154] RDX: 000000000000ffff RSI: ffff88876cf52418 RDI: ffff8881588=
0ad3a
[  351.587155] RBP: ffffc90000377b48 R08: 0000000000000000 R09: 00000000000=
00000
[  351.587156] R10: 1ffff110ed9ea481 R11: 0000000000000000 R12: ffffffff95a=
0d9d0
[  351.587157] R13: ffff88815880ac80 R14: 00000000ffff008d R15: ffff8881588=
0acb8
[  351.587159] FS:  0000000000000000(0000) GS:ffff88876cf00000(0000)
knlGS:0000000000000000
[  351.587160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  351.587161] CR2: 000078e9ea9e25b0 CR3: 0000000712498000 CR4: 0000000000f=
50ef0
[  351.587163] PKRU: 55555554
[  351.587163] Call Trace:
[  351.587164]  <TASK>
[  351.587167]  ? show_regs+0x71/0x90
[  351.587171]  ? __warn+0xce/0x270
[  351.587173]  ? dev_gro_receive+0x172c/0x2860
[  351.587175]  ? report_bug+0x2ad/0x300
[  351.587178]  ? handle_bug+0x46/0x90
[  351.587181]  ? exc_invalid_op+0x19/0x50
[  351.587182]  ? asm_exc_invalid_op+0x1b/0x20
[  351.587187]  ? dev_gro_receive+0x172c/0x2860
[  351.587188]  ? dev_gro_receive+0xcdd/0x2860
[  351.587190]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  351.587192]  ? __mutex_lock.constprop.0+0x150/0x1180
[  351.587195]  napi_gro_receive+0x3a2/0x900
[  351.587197]  gro_cell_poll+0xe5/0x1d0
[  351.587200]  __napi_poll+0xab/0x560
[  351.587202]  net_rx_action+0x53e/0xd10
[  351.587204]  ? __pfx_net_rx_action+0x10/0x10
[  351.587206]  ? __pfx_wake_up_var+0x10/0x10
[  351.587209]  ? tasklet_action_common.constprop.0+0x22c/0x670
[  351.587212]  handle_softirqs+0x18f/0x5d0
[  351.587214]  ? __pfx_run_ksoftirqd+0x10/0x10
[  351.587216]  run_ksoftirqd+0x3c/0x60
[  351.587218]  smpboot_thread_fn+0x2f3/0x700
[  351.587220]  kthread+0x2b5/0x390
[  351.587223]  ? __pfx_smpboot_thread_fn+0x10/0x10
[  351.587224]  ? __pfx_kthread+0x10/0x10
[  351.587226]  ret_from_fork+0x43/0x90
[  351.587229]  ? __pfx_kthread+0x10/0x10
[  351.587231]  ret_from_fork_asm+0x1a/0x30
[  351.587234]  </TASK>
[  351.587235] ---[ end trace 0000000000000000 ]---

Seems like the __netif_receive_skb_core() and dev_gro_receive() are
the places where it calls skb_reset_mac_len() with skb->mac_header =3D
~0U.

On Thu, 12 Sept 2024 at 18:54, Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Sep 12, 2024 at 11:35=E2=80=AFAM Peter Seiderer <ps.report@gmx.ne=
t> wrote:
> >
>
> > Same change (and request for more debugging) already suggested in 2023,=
 see [1]...
> >
> > Regards,
> > Peter
> >
> > [1] https://lore.kernel.org/netdev/d1cf5a66-03e1-44b8-929d-ac123b1bbd7b=
@sylv.io/T/
>
> Indeed !
> Nice to see some consistency among us :)

