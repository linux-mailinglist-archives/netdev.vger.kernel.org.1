Return-Path: <netdev+bounces-214973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2796B2C60E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FBF18937D5
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D26E340D9A;
	Tue, 19 Aug 2025 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=constell8-be.20230601.gappssmtp.com header.i=@constell8-be.20230601.gappssmtp.com header.b="DljtpHWo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396E3431F1
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611142; cv=none; b=GKPnCiJVtB7joHA8r49BQkUnk1Ringm2ixN3y8TM0bquu4V9AdIJkzQW8sIMH9dWj0Rp84yXIiT/QerTfBamYTRx3SpqrqdoX7pQwp5K4YlW4ayFnphCdkcKdLO1HibwYl6bXrYH/bghOf6O6eb5QwKSyxl71u8oTABiu43c6Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611142; c=relaxed/simple;
	bh=NiA2jhEbhhkbTuB9gywR7/GYg0o8hMZ6NMCepBQS3PU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pCLyhQnPkaXODPcSyeWy0UfeVwy6Hv2Lp7nRYpfNjgGiYQyi+LL5onZY05hKsEVBEHyW/sNJpBiCUr1qfwYR920SNwXvyqj+U/WWLW6RBMVvdSNVX9Bt+jzdfAh1BFoquM0q8cNQkztn0CH5Buq7C/CymNKSX1Qlx0kmF/HaGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=constell8.be; spf=pass smtp.mailfrom=constell8.be; dkim=pass (2048-bit key) header.d=constell8-be.20230601.gappssmtp.com header.i=@constell8-be.20230601.gappssmtp.com header.b=DljtpHWo; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=constell8.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=constell8.be
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70bb007a821so42930926d6.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=constell8-be.20230601.gappssmtp.com; s=20230601; t=1755611138; x=1756215938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rN7cpsmUdJFfCPFp0ymfLjZclHMsP7QKUUEfYVhygvA=;
        b=DljtpHWoKFYyjy8Dj+pSrGolutzIDt2DakmLcnG8GcYiHn0f+WkLDoicd2xAkYA11g
         JUNvTkY9kR1kwk7ghZdl+ESIlN22EmzLUlKTbRKMHBWhRUtgHL1lTHfJJUeL6IAYWgtl
         oLBOJ79Ex9eCeFgQvX0mIBNpVbydB4GZ/6WL9UTfnwmBg6XS2DTUYonGnRpCKj94D6j6
         2PEwrncpFIBunqTVfjep7R05nrLG0MI1eVNU3ddtmlTTt/HJG2mChVvs7l02g37EZTKy
         34cL4yJIwE+7k1yaBMSDHkzGkwpfzfFGkwu3DNezy9sLRUDQ4/tL3t/2ccoYaGAHKOHD
         2r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611138; x=1756215938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rN7cpsmUdJFfCPFp0ymfLjZclHMsP7QKUUEfYVhygvA=;
        b=j5Djytzftpt2B4GZwocaCZEzmJnRAqmCUgwJhJTOEU7GDbOpsLqFYCfItxA+1wdteZ
         n8J/U5WvZV9VbBRBkyxrD65AdW9/EjhI/MXiGruPvN5wF5Lq+sgjmhfh/PA00H8iTaO9
         UebXpmre1lHviwqY9nNqh/sBjY6YbfWP5JuAJ8f+it9DG+OWWuNLATteJjStgX0XApdR
         51vZaDQadwSpHWBkC5U4Iay+qiGuj71AQo4lJoCLvkDtJxbSNilHJzPexBSGDEQISzmW
         cGTvWJ6EztxPK5fvK6BvF/RanEXGZxg/Ey1axIuzEVNu1cQggJZH6IDIXYncBkMR96Ag
         KTdw==
X-Gm-Message-State: AOJu0Ywhtp3ejUYbc/lYUsuDrhlnu8aMVGNAUYY2zqnTBCY8h2QuztD/
	moZr1+lBJqBLI09lvuXQF16C92hedGbMF1uYF0TBWPxeMXrZCT4W6cwsfglftNRjjpixdMwEY6L
	Sgby4MyBCKEzI+s/FA8ghvBYZm1LKwPHulKE1INOid0MaC+83AB9gOUt6zQ==
X-Gm-Gg: ASbGncsL5tqCLPlnay6s1s0mWHKbfWzX8p6lLQFmPLXz38os+KYrrswjaDIaDneEeYM
	RNx3AOBxOvA5mAmreON+DbCR1mEPmzp4HmgGSQe38+5A8lYev7EQ/cZrsMDXFe0JJ9fSFHPVDgz
	gMdTNCvKOZatk1LOsSbwUeCnQ06dvHpfCr5Ts38Nw0AWcOjIqxddqqgzsVqWV1MeVGtrDk/pznK
	b/iy5mw
X-Google-Smtp-Source: AGHT+IE7Q/AR9R+Jd497QGXdFg/1UWRP+CR932U6YYRP12ZMx+yQ1KCUqhmVFaWajlio8nIjQDFIzfQrnOQoH9c7q3I=
X-Received: by 2002:ad4:574c:0:b0:70d:6df4:1b0a with SMTP id
 6a1803df08f44-70d6df41e7cmr13423546d6.56.1755611138196; Tue, 19 Aug 2025
 06:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bartel Eerdekens <bartel.eerdekens@constell8.be>
Date: Tue, 19 Aug 2025 15:45:01 +0200
X-Gm-Features: Ac12FXwG4_l7Re7v7eTG0agV4UNRzY8uMOWOc12m5FWSnZxqlr-JG_uP6kyhOmU
Message-ID: <CABRLg09mnZSvoXUJEJyvXNpBq76UsWtP8rTcKk98GkK68P1CVA@mail.gmail.com>
Subject: mediatek ethernet driver: 4MB buffer allocation
To: netdev@vger.kernel.org
Cc: nbd@nbd.name, Sean Wang <sean.wang@mediatek.com>, lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I recently upstepped from kernel 6.1 to 6.12 for my MT7621-based
device and suddenly observed a kernel memory allocation error.
I am using a MT621DAT (so, MT7621AT + 128MB embedded RAM), with quite
a heavy build (buildroot + systemd build) , so my memory usage is
already quite high.
But anyway, the 4MB allocation that is happening, seems like a very
high amount of continuous memory that is required?

The error log:

[ 3011.709726] systemd-network: page allocation failure: order:10,
mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=3D(null)
[ 3011.725868] CPU: 3 UID: 101 PID: 4191 Comm: systemd-network Not
tainted 6.12.39 #8
[ 3011.725931] Hardware name: MT7621DAT
[ 3011.725948] Stack : 00000001 8009888c 00000001 00000004 00000001
83c41750 83c417c4 00000000
[ 3011.726039]         01000000 80097b10 00000000 00000000 00000000
00000001 83c41770 814c8000
[ 3011.726099]         00000000 00000000 80a493d8 83c41620 ffffefff
00000000 80b0c00c 000001ef
[ 3011.726155]         00000000 000001f1 80b0c038 fffffff9 00000001
00000000 80a493d8 00000001
[ 3011.726211]         00000001 80b04574 00000000 00000400 00000003
fffc7fb3 0000000c 80cd000c
[ 3011.726269]         ...
[ 3011.726284] Call Trace:
[ 3011.726291] [<80008430>] show_stack+0x28/0xf0
[ 3011.726352] [<8091ce10>] dump_stack_lvl+0x70/0xb0
[ 3011.726387] [<801e3e6c>] warn_alloc+0xb8/0x148
[ 3011.726439] [<801e406c>] __alloc_pages_noprof+0x170/0xd04
[ 3011.726466] [<801e9ba4>] ___kmalloc_large_node+0x64/0xf8
[ 3011.726496] [<801ee0a0>] __kmalloc_noprof+0x22c/0x3c0
[ 3011.726520] [<805d93d4>] mtk_open+0xb20/0xcb8
[ 3011.726542] [<806dfe48>] __dev_open+0xd8/0x198
[ 3011.726569] [<806e0338>] __dev_change_flags+0x1c0/0x208
[ 3011.726591] [<806e03a4>] dev_change_flags+0x24/0x70
[ 3011.726610] [<806f4aa4>] do_setlink+0x2d4/0x102c
[ 3011.726638] [<806f58d4>] rtnl_setlink+0xd8/0x154
[ 3011.726658] [<806f2890>] rtnetlink_rcv_msg+0x350/0x47c
[ 3011.726679] [<80746eb0>] netlink_rcv_skb+0x94/0x130
[ 3011.726711] [<80746578>] netlink_unicast+0x284/0x448
[ 3011.726733] [<807469d0>] netlink_sendmsg+0x294/0x460
[ 3011.726755] [<806a76c4>] __sys_sendto+0xbc/0x120
[ 3011.726792] [<800138cc>] syscall_common+0x34/0x58
[ 3011.726828]
[ 3011.726842] Mem-Info:
[ 3011.878151] active_anon:51 inactive_anon:2644 isolated_anon:0
[ 3011.878151]  active_file:2379 inactive_file:4276 isolated_file:32
[ 3011.878151]  unevictable:0 dirty:135 writeback:0
[ 3011.878151]  slab_reclaimable:680 slab_unreclaimable:4961
[ 3011.878151]  mapped:3287 shmem:553 pagetables:142
[ 3011.878151]  sec_pagetables:0 bounce:0
[ 3011.878151]  kernel_misc_reclaimable:0
[ 3011.878151]  free:11393 free_pcp:103 free_cma:0
[ 3011.916762] Node 0 active_anon:204kB inactive_anon:10828kB
active_file:9516kB inactive_file:17132kB unevictable:0kB
isolated(anon):0kB isolated(file):128kB mapped:13344kB dirty:540kB
writeback:0kB shmem:2212kB writeback_tmp:0kB kernel_stack:984kB
pagetables:568kB sec_pagetables:0kB all_unreclaimable? no
[ 3011.916846] Normal free:45132kB boost:0kB min:1360kB low:1700kB
high:2040kB reserved_highatomic:0KB active_anon:204kB
inactive_anon:10740kB active_file:9584kB inactive_file:17168kB
unevictable:0kB writepending:524kB present:131072kB managed:117500kB
mlocked:0kB bounce:0kB free_pcp:520kB local_pcp:0kB free_cma:0kB
[ 3011.916904] lowmem_reserve[]: 0 0 0
[ 3011.916957] Normal: 145*4kB (UE) 155*8kB (UME) 238*16kB (UME)
231*32kB (UME) 106*64kB (UME) 51*128kB (UME) 27*256kB (M) 15*512kB (M)
2*1024kB (M) 1*2048kB (M) 0*4096kB =3D 45020kB
[ 3011.917229] 7274 total pagecache pages
[ 3011.917247] 0 pages in swap cache
[ 3011.917260] Free swap  =3D 0kB
[ 3011.917272] Total swap =3D 0kB
[ 3011.917284] 32768 pages RAM
[ 3011.917296] 0 pages HighMem/MovableOnly
[ 3011.917309] 3393 pages reserved

As observed, a block of 4096kB of continuous memory is being allocated
(order: 10), which is not available at that time (fragmented).

The error happens in mtk_open and more specifically in the mtk_init_fq_dma =
call.
There this [1] kcalloc memory allocation happens to allocate a buffer
for eth->scratch_head .

This part of the code was changed last year [2] where the original
single kcalloc was wrapped in a for-loop. The patch was fetched from
the upstream mediatek repo [3].
Now this for loop runs, for the MT7621, just one time, but with a high
amount of requested memory, resolving in a call: eth->scratch_head[0]
=3D kcalloc(2048, 2048, GFP_KERNEL);
As MTK_DMA_SIZE(2K) =3D 2048 for MT7621.

The old code only allocated 512kB, as: eth->scratch_head =3D
kcalloc(cnt, MTK_QDMA_PAGE_SIZE, GFP_KERNEL);
where cnt =3D #define MTK_DMA_SIZE 256 , and size was: #define
MTK_QDMA_PAGE_SIZE 2048


My interpretation of the change is that it is intended to split up the
fq_dma_size into chunks of MTK_FQ_DMA_LENGTH.
In that case, only 1 element of size 2048 should have been allocated.
Am I correct in this assumption?


I traced some kcalloc calls in the mtk_eth_soc.c code to pinpoint
where this big allocation happens, and this was the output of that
manual tracing:

Allocating 2048 =C3=97 16 =3D 32768 bytes <-- `dma_alloc_coherent` for
scratch_ring [mtk_init_fq_dma]
Allocating 2048 =C3=97 2048 =3D 4194304 bytes <-- `kcalloc` for scratch_hea=
d
[mtk_init_fq_dma]
Allocating TX 2048 =C3=97 28 =3D 57344 bytes <-- `dma_alloc_coherent` [mtk_=
tx_alloc]
Allocating RX 512 =C3=97 4 =3D 2048 bytes <-- `dma_alloc_coherent` for
MTK_RX_FLAGS_QDMA [mtk_rx_alloc]
Allocating RX 512 =C3=97 4 =3D 2048 bytes <-- `dma_alloc_coherent` for
MTK_RX_FLAGS_NORMAL [mtk_rx_alloc]

I found a bug report for this from 2021 [4], but it was posted in the
wrong project. This got me to a reproducible test-case scenario to
trigger the memory allocation failure:

ip link set down eth0
ip link del dev br0

nice -n -10 stress --vm 1 --vm-bytes 10000000 &
nice -n -10 stress --vm 1 --vm-bytes 50000000 &

Wait for a few seconds, and then run:

killall stress
systemctl restart systemd-networkd
(Or /etc/init.d/network restart if you are running init.d , I am using syst=
emd).

The above trace is logged and the failure of bringing up the eth0 device:

[   51.912288] mt7530-mdio mdio-bus:1f lan3: failed to open conduit eth0
[   51.920335] mt7530-mdio mdio-bus:1f lan5: failed to open conduit eth0
[   51.928359] mt7530-mdio mdio-bus:1f lan2: failed to open conduit eth0
[   51.936288] mt7530-mdio mdio-bus:1f lan1: failed to open conduit eth0
[   51.943893] mt7530-mdio mdio-bus:1f lan4: failed to open conduit eth0


Any maintainer that can help clarify this memory allocation?

Thanks a lot.

[1] https://github.com/torvalds/linux/blob/v6.12/drivers/net/ethernet/media=
tek/mtk_eth_soc.c#L1162
[2] https://github.com/torvalds/linux/commit/c57e558194430d10d5e5f4acd8a865=
5b68dade13
[3] https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-fe=
eds/+/ba89e7797868ba793e1bf2a468bbae68ab8d311a
[4] https://github.com/openwrt/mt76/issues/592


Kind regards.
Bartel

