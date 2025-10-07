Return-Path: <netdev+bounces-228127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0616FBC2237
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 18:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AC174E6D00
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8A2E7BA3;
	Tue,  7 Oct 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGx0fPcf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DE2DFF0D
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855239; cv=none; b=kVghFu7yt85pSqF7ykeu/fNO/uzWQzwGcXWCVBObAdFtiuFlJ2876abGTmnQOJzj5ZtW4YXlps/8OPid3wCQ0n47BF1E94FxUNfN00rlhV4+WcRg5K2i5wA3fFDf1uUwCevduZAQ6nUEokQ/94ya3DWCQXxsz6TUGjSc4029BQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855239; c=relaxed/simple;
	bh=JIgWctAFQC/F7Apkqcmm3f6xuPWq8ceTwAcPackVwFM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Hu2W8aXAN784HjY32R+Z3VMe7M9wLSs1/xgJhp5BNm/xWu6/NuveKGzrPqAGNdswg3csqFEtP0B0msRqJdyJbdL0cAdgNELlVkZDeHpxnb8ffb+VuCycBNfLNu1f8GR1IqCR1EZ6m2aidjVRXtRWhdWU+L+84rZNigEZMPZcQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGx0fPcf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso3933572f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759855236; x=1760460036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZIa5AUWBOOYm7eCsrLzpvRYFEWDGK9XqIfPtpRGRpM=;
        b=WGx0fPcf7Ybj2cionzHk8bm5RW8hKJ+hjp4GvXjDJTVk68DzsDbtZgXOMWy/AVw5sG
         RQYAWqyJSgGRvm7TPwr1vaLGdbxUdDqDML7t4OSrCy8JP9UxYbCvQ5qcIPinrxRnnL4T
         hNFh/qWBvNCXOChZrZ7LmJGAhOQcBDlm1xUHFFaLg/ZSMwod9C71yCADeLv2X+zN0Fmf
         4pTNbHqiMAo+350pw6dJcx0xpanTUDuXT1K/I5Yz3BLyxbZd4KPkMcQY9oPIjXl6W/B2
         CrBEJwFbucW+EpTwG2sNDOACffAW7gv2Mb1C6X8hcOpbVt2OL+T4aLtei1i5vskFNcY4
         oaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855236; x=1760460036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZIa5AUWBOOYm7eCsrLzpvRYFEWDGK9XqIfPtpRGRpM=;
        b=bzaKpOGVVlMl5ZpSQERiD9GJRtzHXloyS9xSCgB8AmAHwS8toZ/2HwYbWS+j2JmM9f
         2DKYhdcZUKqCk9EM7P8owfJVJ9GXUcz5uac1iRB+YiMf95N9JNk+soHibbbzdtd/VioB
         xBpEcuMoXuViSdCncSAf5Ae9zT8bAzCKnXihYWK7bHG2lq+yIAoabHU6U6oGcV+VS977
         IzQYGAnYX8ZqN86Z2U7hcPa6PS05DSEBQdcMSNsRw21s3N1T5JLwBL8gCwEFzxcOWZlE
         IER9DuKNGlftvvKFkqkyNX2LmlFql/D4YYPDp1ZqN6sYmKTVAqxNBo7TpkSZ8rv0tmBm
         JpuA==
X-Gm-Message-State: AOJu0Yzfy4gXDHjQ0NNqYsDGIGsOnAeMqFhW/DGkGYy3LGJvrnFoQ898
	wq/HM1+cx25X7eVkmTBGU7VG6YR8MVEsdShispZafEAwe/3DV9kgsbOmcCN2qvHzLUuwaRDFCdE
	kuprtXcB4YWsiyR7aKnELtsfLcuuqJXWce8Xp
X-Gm-Gg: ASbGncuRLjbnbQlv0NX5RzU0gaUgQm56NSSVxZyCueE6HEuk7XmNEGrDO07QWXzOXnI
	XmuKCspmXihqEcPfXm/zFlDMThyytuVL5PNme693zlZShCYaIIgeXGVTNYCBE/gsYNUEj4ki+Am
	DGuNIn1x7uPwUdmXAQCPrxAcSxrHuvxp14q+TWMo6BnObN+eQ4AcSwtPooIKBzcpGC9mpWhVoSL
	R8fT+f2zQau26OfE3TondMoz97d2AXgUKFe5jD8aas2vvWhncEO9c6Bo2eWCGyB
X-Google-Smtp-Source: AGHT+IG8wOXGdN+1KB7koQFlC6vDAHIRJ5WQJBK2dXsap0oDJmxHTvY2fSydA9gf7LLcg6ZOWGCY0S9NAFWbAecSf6o=
X-Received: by 2002:a05:6000:603:b0:3ee:147a:9df with SMTP id
 ffacd0b85a97d-4256719d346mr12342806f8f.39.1759855235410; Tue, 07 Oct 2025
 09:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 7 Oct 2025 17:40:09 +0100
X-Gm-Features: AS18NWBIf2fXr2RjS6_L7Cazile23MJwqXAMXwmxsHiUVNGvIXaFc5oCU5DDKcM
Message-ID: <CA+V-a8tWytDVmsk-PK23e4gChXH0pMDR9cKc_xEO4WXpNtr3eA@mail.gmail.com>
Subject: CPU stalls with CONFIG_PREEMPT_RT enabled on next-20251006 (Renesas
 RZ/G2L & RZ/G3E)
To: netdev <netdev@vger.kernel.org>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

With CONFIG_PREEMPT_RT enabled, I=E2=80=99m observing CPU stalls from the R=
x
path on two different drivers across Renesas platforms.

The first case is on the RZ/G3E SoC using the STMMAC driver:
-----x-----x------x------x------x------x------x------x------x------x------x=
------x------x
[  173.505971] rcu: INFO: rcu_preempt self-detected stall on CPU
[  173.506014] rcu: 0-....: (2 GPs behind)
idle=3Dde74/1/0x4000000000000000 softirq=3D0/0 fqs=3D2178 rcuc=3D5257
jiffies(starved)
[  173.506077] rcu: (t=3D5250 jiffies g=3D2757 q=3D79 ncpus=3D4)
[  173.506118] CPU: 0 UID: 0 PID: 290 Comm: irq/107-eth0 Not tainted
6.17.0-next-20251006-00001-gaef898d60052 #19 PREEMPT_RT
[  173.506163] Hardware name: Renesas SMARC EVK version 2 based on
r9a09g047e57 (DT)
[  173.506182] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  173.506217] pc : rt_spin_lock+0x40/0x190
[  173.506280] lr : stmmac_tx_clean.constprop.0+0x80/0x7a8
[  173.506323] sp : ffff800082883a40
[  173.506338] x29: ffff800082883a60 x28: ffff0000c1eb0a80 x27: ffff8000828=
83c18
[  173.506397] x26: ffff80007a330000 x25: ffff800082883c00 x24: ffff8000817=
3a000
[  173.506447] x23: 00000000ffff8479 x22: 0000000000000003 x21: 00000000000=
00003
[  173.506497] x20: ffff0000c1eb8580 x19: ffff0000c1eb8580 x18: 00000000000=
00001
[  173.506545] x17: ffff0000c004f800 x16: 0000000000000bfe x15: 00000000000=
00000
[  173.506593] x14: 0000767bd1d30308 x13: 00000000000003f8 x12: 00000000000=
00000
[  173.506641] x11: 0000000000000000 x10: 0000000000000000 x9 : 00000000000=
013c0
[  173.506687] x8 : ffff800082883c88 x7 : 0000000000000000 x6 : 00000000000=
00000
[  173.506734] x5 : 0000000000000480 x4 : ffff0000c1eb0000 x3 : ffff8000828=
83b67
[  173.506781] x2 : ffff0000c1eb8598 x1 : ffff0000c1f21140 x0 : 00000000000=
00000
[  173.506829] Call trace:
[  173.506843]  rt_spin_lock+0x40/0x190 (P)
[  173.506905]  stmmac_tx_clean.constprop.0+0x80/0x7a8
[  173.506948]  stmmac_napi_poll_tx+0x6c/0x154
[  173.506989]  __napi_poll.constprop.0+0x38/0x188
[  173.507041]  net_rx_action+0x118/0x264
[  173.507088]  handle_softirqs.isra.0+0xe4/0x1ec
[  173.507149]  __local_bh_enable_ip+0xc4/0x128
[  173.507186]  irq_forced_thread_fn+0x48/0x60
[  173.507240]  irq_thread+0x188/0x31c
[  173.507292]  kthread+0x12c/0x210
[  173.507337]  ret_from_fork+0x10/0x20

The second case is on the RZ/G2L SoC using the RAVB driver:
-----x-----x------x------x------x------x------x------x------x------x------x=
------x------x
[   70.821322] rcu: INFO: rcu_preempt self-detected stall on CPU
[   70.821351] rcu: 0-....: (4970 ticks this GP)
idle=3De2c4/1/0x4000000000000000 softirq=3D0/0 fqs=3D2622 rcuc=3D5112
jiffies(starved)
[   70.821366] rcu: (t=3D5250 jiffies g=3D6729 q=3D98 ncpus=3D2)
[   70.821382] CPU: 0 UID: 0 PID: 101 Comm: irq/45-11c20000 Not
tainted 6.17.0-next-20251006-00001-gaef898d60052 #19 PREEMPT_RT
[   70.821392] Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
[   70.821397] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   70.821404] pc : rt_spin_trylock+0x44/0xd8
[   70.821426] lr : try_charge_memcg+0xd0/0x7a0
[   70.821442] sp : ffff8000820cb3e0
[   70.821445] x29: ffff8000820cb430 x28: 0000000000000001 x27: 00000000000=
00800
[   70.821459] x26: 0000000000000000 x25: ffff00000bda1140 x24: ffff8000818=
5f3e0
[   70.821469] x23: 0000000000000040 x22: ffff00000cc7e800 x21: ffff8000816=
7e600
[   70.821479] x20: 0000000000000820 x19: 0000000000000002 x18: 00000000000=
00000
[   70.821489] x17: ffff000009c3e580 x16: 00000000000003f6 x15: 00000000000=
0000c
[   70.821498] x14: 0000000000000000 x13: 0000000000000014 x12: ffff00000bd=
ba800
[   70.821508] x11: ffff00000bda8000 x10: 0000000000005114 x9 : 00000000000=
00000
[   70.821517] x8 : ffff8000820cb588 x7 : 0000000000000000 x6 : 00000000000=
00000
[   70.821526] x5 : 0000000000000000 x4 : ffff00000bda1140 x3 : ffff00007dd=
da618
[   70.821536] x2 : ffff00000bda1140 x1 : ffff00000bda1140 x0 : 00000000000=
00001
[   70.821546] Call trace:
[   70.821550]  rt_spin_trylock+0x44/0xd8 (P)
[   70.821564]  mem_cgroup_sk_charge+0x2c/0x80
[   70.821572]  __sk_mem_raise_allocated+0x1cc/0x380
[   70.821584]  __sk_mem_schedule+0x3c/0x60
[   70.821592]  tcp_try_rmem_schedule+0x88/0x48c
[   70.821603]  tcp_data_queue+0x2b0/0xe1c
[   70.821611]  tcp_rcv_established+0x3bc/0xba0
[   70.821619]  tcp_v4_do_rcv+0x1ec/0x2b8
[   70.821630]  tcp_v4_rcv+0x954/0xf20
[   70.821640]  ip_protocol_deliver_rcu+0x38/0x1a0
[   70.821648]  ip_local_deliver_finish+0x90/0x120
[   70.821654]  ip_local_deliver+0x7c/0x124
[   70.821661]  ip_rcv+0x74/0x128
[   70.821667]  __netif_receive_skb_core.constprop.0+0x928/0x11b0
[   70.821679]  __netif_receive_skb_list_core+0xe8/0x210
[   70.821688]  netif_receive_skb_list_internal+0x1dc/0x2d0
[   70.821697]  napi_complete_done+0x80/0x1bc
[   70.821705]  ravb_poll+0x170/0x1e4
[   70.821715]  __napi_poll.constprop.0+0x38/0x188
[   70.821723]  net_rx_action+0x118/0x264
[   70.821732]  handle_softirqs.isra.0+0xe4/0x1ec
[   70.821746]  __local_bh_enable_ip+0xc4/0x128
[   70.821753]  irq_forced_thread_fn+0x48/0x60
[   70.821765]  irq_thread+0x188/0x31c
[   70.821775]  kthread+0x12c/0x210
[   70.821785]  ret_from_fork+0x10/0x20


Has anyone else observed similar stalls with PREEMPT_RT enabled on
recent next kernels? I=E2=80=99m trying to determine whether this is primar=
ily
a core/RT scheduling issue or something driver-specific.

Any insights or suggestions would be appreciated.

Cheers,
Prabhakar

