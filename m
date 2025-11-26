Return-Path: <netdev+bounces-241754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5272C87F18
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DDEA4E338F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811E130DD1E;
	Wed, 26 Nov 2025 03:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlD8ethr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA93090FE
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127398; cv=none; b=blwPgl/ymgpD1WP3SnvQZ57rCsG1F1OZhPHVEsBUkxvlgUjW/VGEGu9jiRWryzCCqEYoRxK83cEqVm8+PjzTARmoiiuLJ0S4/yp0xS4X86w3zOKYoztwUGGQdNn2mWZsazmkN2hsjvHD0d7uMuhlga3WODAT9cJPgy3VzwBTfnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127398; c=relaxed/simple;
	bh=dOf7qfXHRNZJOMOrKx1sGTADnVJFHULFBlel+U5IZ4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g0mG+YbGGJpND10etArardVRm5cJc1PtB/R0U5zFLtgWrlOzJN3+Iv65/TVLveWsKjD7lfvM1JaT+vuzVQp4StoqLBQMgazTmtn0zhJUXpCJGlsOC27qCpRVrsb0SQ8AmGzQCyKWFFbpqqYoM5uqQBp71d7XIAelFblxLv8oeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlD8ethr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29ba9249e9dso20194355ad.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 19:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764127396; x=1764732196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqwxFOFaWASs/Xf76QGmoOwqnyRGPueL7GFTlFdlntY=;
        b=nlD8ethr2T7qB9ck/wWEkDzeC9xHJ55CQluBI1Q7hj2lj6lLJ1kIR04YG+nBOomTCI
         M4bH75emPqGmDM7rA+qPrx0gPMyVtIRhntJ51hnQUhIYu9tFgWn5pADUbR7nQx9x3BrD
         4cTKP4D/Y1fHvUXC9C5iKcmWrt41XRARpVRJU3rhltx0tPZNDp+JppgsaCtqBUGqAr2I
         FefKXWLfQe+junj3p0Q5Q1IIqqNDHxs60hyg70RAx4tHFYPX1m5GX3EbeFI111Oo9FYA
         aWkITzgwjMmuYJM7BxIS5VbR4GkCrc7jf8MiHWcG4xIFIMfEbsrNkslqOzWLZJELM87F
         dE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764127396; x=1764732196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqwxFOFaWASs/Xf76QGmoOwqnyRGPueL7GFTlFdlntY=;
        b=ksyl7Aivj/m0g4w3pPRDggvHgYHo036N0BuzWRwR2H9TE8c4lMhTBP5uLKgkjHtSkS
         JvEbM/louvj18rkAmon35R1zfysanMUmZ/TISTEFt1iuLCwMTl0pKrfiTUSCMq0S2OLB
         ctTnA3RzpNvV1QPTkrp7z485pcdWFvlKRVeFMDm2mmLufppMyg5y5p7ZCGMePfavoizZ
         jssaLVnjx2MhxstVRqyLSTpt+YmXCoyMZpIHRPSne2OGgFwIr2p/kO+OQz3zce8EUQEs
         YJ41CQEgFtBM3Fh8uKaijEqwEWuKVDvzbAFsrA6DIVTwgi8UMJkE6OjKPFLNl/CnK9Cn
         nIrg==
X-Gm-Message-State: AOJu0Yz1ONd+pDmGZdQqzBBzwLd6gX7xOotgmxY9cALm3n8a1CrjpVrF
	Tb0BaQCq7A3UrXblI08wOu7r93ywU+892Jr/oawa9HJBuJk6kew/f0GSJTgnXRlxLo4=
X-Gm-Gg: ASbGncvwtZDq0btT7FdIBK390ZroAIa5Pjak65ae/o0J1yl7l8f4k075BBrAfRvUhsg
	Kuzh/zJlVL+UaBGrUW2FRPUB55sAgcFKpfVXl9vH4q0im5GS3rML088itlyDqem/gR0HLNdHicF
	1KiE4E+axSoWsj3xsPNNOCsKamf/yc9Aae13TP/S4yrWTEoJtzQUPG1ncF+c1sgHtD178ttA4yQ
	vC33QbM1wQnxKk3P5lLgwQpU2MItV0W6Mo8N8DOpDnu7SF0BjbaX0oIGCdmtgVhzJ9Eml2M1XRK
	Mhd2yRnXh0ypKTbswqMN92cESWKxbuU8kRsFnPtSH70UHR8zq6ZV2iytLd2CjrtorRjZP8TOYwP
	0Eka4eIYJFqgyI/idoA3jONt8sInIgPWhQIY3ijb2hpbga2NmlSIEHnHc42HWBVsQiNNt6txQZc
	sHnvT6sLhPlMZxDY+BpI1PhpT0B7s+nkD7ze0=
X-Google-Smtp-Source: AGHT+IGGsnCf3v9xSE6dajS0GJRiYR4mCwpeZMattW0HGw73H7VDQZE1c6Gr+lx1hLdD6VF+98sSag==
X-Received: by 2002:a17:902:cf4b:b0:295:6d30:e268 with SMTP id d9443c01a7336-29b6c6e9538mr187863195ad.59.1764127395895;
        Tue, 25 Nov 2025 19:23:15 -0800 (PST)
Received: from gmail.com ([183.56.183.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a547483sm861544a91.4.2025.11.25.19.23.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Nov 2025 19:23:15 -0800 (PST)
From: jiefeng.z.zhang@gmail.com
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	grundler@chromium.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	irusskikh@marvell.com,
	Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
Subject: [PATCH net v5] net: atlantic: fix fragment overflow handling in RX path
Date: Wed, 26 Nov 2025 11:22:49 +0800
Message-Id: <20251126032249.69358-1-jiefeng.z.zhang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>

The atlantic driver can receive packets with more than MAX_SKB_FRAGS (17)
fragments when handling large multi-descriptor packets. This causes an
out-of-bounds write in skb_add_rx_frag_netmem() leading to kernel panic.

The issue occurs because the driver doesn't check the total number of
fragments before calling skb_add_rx_frag(). When a packet requires more
than MAX_SKB_FRAGS fragments, the fragment index exceeds the array bounds.

Fix by assuming there will be an extra frag if buff->len > AQ_CFG_RX_HDR_SIZE,
then all fragments are accounted for. And reusing the existing check to
prevent the overflow earlier in the code path.

This crash occurred in production with an Aquantia AQC113 10G NIC.

Stack trace from production environment:
```
RIP: 0010:skb_add_rx_frag_netmem+0x29/0xd0
Code: 90 f3 0f 1e fa 0f 1f 44 00 00 48 89 f8 41 89
ca 48 89 d7 48 63 ce 8b 90 c0 00 00 00 48 c1 e1 04 48 01 ca 48 03 90
c8 00 00 00 <48> 89 7a 30 44 89 52 3c 44 89 42 38 40 f6 c7 01 75 74 48
89 fa 83
RSP: 0018:ffffa9bec02a8d50 EFLAGS: 00010287
RAX: ffff925b22e80a00 RBX: ffff925ad38d2700 RCX:
fffffffe0a0c8000
RDX: ffff9258ea95bac0 RSI: ffff925ae0a0c800 RDI:
0000000000037a40
RBP: 0000000000000024 R08: 0000000000000000 R09:
0000000000000021
R10: 0000000000000848 R11: 0000000000000000 R12:
ffffa9bec02a8e24
R13: ffff925ad8615570 R14: 0000000000000000 R15:
ffff925b22e80a00
FS: 0000000000000000(0000)
GS:ffff925e47880000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff9258ea95baf0 CR3: 0000000166022004 CR4:
0000000000f72ef0
PKRU: 55555554
Call Trace:
<IRQ>
aq_ring_rx_clean+0x175/0xe60 [atlantic]
? aq_ring_rx_clean+0x14d/0xe60 [atlantic]
? aq_ring_tx_clean+0xdf/0x190 [atlantic]
? kmem_cache_free+0x348/0x450
? aq_vec_poll+0x81/0x1d0 [atlantic]
? __napi_poll+0x28/0x1c0
? net_rx_action+0x337/0x420
```

Fixes: 6aecbba12b5c ("net: atlantic: add check for MAX_SKB_FRAGS")
Changes in v4:
- Add Fixes: tag to satisfy patch validation requirements.

Changes in v3:
- Fix by assuming there will be an extra frag if buff->len > AQ_CFG_RX_HDR_SIZE,
  then all fragments are accounted for.

Signed-off-by: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index f21de0c21e52..d23d23bed39f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -547,6 +547,11 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 
 		if (!buff->is_eop) {
 			unsigned int frag_cnt = 0U;
+
+			/* There will be an extra fragment */
+			if (buff->len > AQ_CFG_RX_HDR_SIZE)
+				frag_cnt++;
+
 			buff_ = buff;
 			do {
 				bool is_rsc_completed = true;
-- 
2.39.5


