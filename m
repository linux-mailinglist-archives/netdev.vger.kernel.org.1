Return-Path: <netdev+bounces-196316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F577AD4371
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92813189D137
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51D9264FB2;
	Tue, 10 Jun 2025 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sima.ai header.i=@sima.ai header.b="DxzJaouo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FA2620F1
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749585858; cv=none; b=EoHg6z8bwbcLZqhzz9588bmgLG3FcdxCWBtzbOg8d090Jz3REv8WP4EgbLwUlk4n3Sd9vHVFGqM9uXkUTfoTGG0smlxy+CfibNHxIfPeti6mg7DPefiEP8gxBmZJw7pJ5D4ue1TuuroKHOCyS02fBBh11JNo2TF0Ye+nq2uqTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749585858; c=relaxed/simple;
	bh=cP23wtFMvKOpdUnof+BSPUV5OQaMXrVObxebToJ9P+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KaNgtFaH3TdXwxFFdcjKOtxdOMzurNIOk3z6+rcm3dntJC680DKulGKd9+/9UdOcgoizxeV3PO4eTDlEDqav8IhwaZnc6STODPH75FGmbconkbs4lVLBt/Gs7m3CXEnsfkdWZakg569pHchiUlL/SgLWmjz1k5fN9e3LeMHj6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sima.ai; spf=pass smtp.mailfrom=sima.ai; dkim=pass (2048-bit key) header.d=sima.ai header.i=@sima.ai header.b=DxzJaouo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sima.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sima.ai
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234ae2bf851so8228855ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sima.ai; s=google; t=1749585856; x=1750190656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SLBrHn1lo0nb3pErG+htfOLCGfPDjEh1wfPdZMI4yH4=;
        b=DxzJaouoC0p+ArLVOixO3GHQwYFwTy4pz6kdhb6n3F/oTB5WB7QniE+7Fz9mfvJbZ+
         1UKNJvzOHhuJ1lMlqGWWbIRYSESRC/FHsawSuBD2uuLYwyfJa26oY/ohC6ARmRkmhI2g
         JcySKdZGqreeAeWsj3RsS4uhuk/RUWP/I02yXFHXbEu5jTpB5M+5COJ3vtFmOh+99Uvx
         6Xfejq3C/6vp8JpksUBFWm9RjbfyBUEgVPxpJ+kWi7wnNe3U1gKNkcDW7a6Oc9CuvQuX
         z6Ooe5qobd9tMSTxe0iJ1H0VsSN+eNX4KMfAgps3liPgnSTCWGVFz9Rs37DcF0C+b9/E
         jdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749585856; x=1750190656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLBrHn1lo0nb3pErG+htfOLCGfPDjEh1wfPdZMI4yH4=;
        b=ax50Kzf5y9zyVASjYvuOlpweMTFepFCKQjbOsYZc6CVrDIC+yKIXt7W8cy8Ek8kZ3a
         cyKrwUy53uN0xRgOOlkdBn2HVLiM9V/FBmBP1RZKWdoGaCfmkk0d1tlT41QcSM/06W+o
         SF8sdEy7VLf1GfYEtIxDn21A27aXR6NZJqL17BeZLec3tUfNBTn4HNwiXKirbagaFGro
         QE1xBT55cjq9MA0GKxie0UD9iUcTZBqNhSYlZe1trEr0pzxtTYkIL7wre0RNrygL6mi1
         2NsEEdSh17ysTlwh2hhwMPFpeJcWPEO3+hE3lssx1egPO0QVv8OZX+zKDWe/XbRcXuq2
         qgfw==
X-Forwarded-Encrypted: i=1; AJvYcCUzMwM3FqL5U2q++m3p4fo0uZ0AbX4MM0otk+5gZJfajEjZ5dN30KdA6GSV0LqHK6JlXd9xpZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Vb1xlN8rJyqWoD9MDti6AOhTTBzRyXA+woZ3XykoE2X/bPcJ
	hL1PnyE+cNkJ36pt0UMibXbXvT8LFEVFlRJ7SB/fBzVkLNtE91gU7xJJzZHDhYrVGDen2EYBOjo
	ZmkxXTwU=
X-Gm-Gg: ASbGnct6z7ISwNO3aZ2UML6/jZ6KJk5SxMT09z0Gfb6DUVDLmALUmwJkQQJMIiH/7vf
	vLlssiDLO8myd0ldp2H9eTIpGdrJJxJKGv1kapoUUX8iQUKiDiBkFPL8P5IG4hSPNVAKw3jLOoN
	FdZewtpPocGvX9QRd/qmdIRRUKaNMkckROE/P6dqdlpi2pxKFGn/Xds5RPYWUK7K+F6l+h+jjJr
	FZL7V0Mj6bmE6sL+D7Zm4X71rPBkaxBL5z1O4M0z9cey9xrbxqWm74bXsl1M/srI0W9dttFSeLQ
	RGS2Fcy3fxqKSO/ZolYlJTPz9adgkbWH86qioLlQJ2HUF95FJCjK2+sfqFYEc9UtIFg5ucTjR8k
	lw+tiBpp8ihw8B8w=
X-Google-Smtp-Source: AGHT+IER+o3LTU2puTUgTzx5nfZBbOjCThFzTKIlbQejci+9CZwNjpKLs8gAK20uD5mbsirIIc3WyA==
X-Received: by 2002:a17:902:e806:b0:234:d7b2:2abe with SMTP id d9443c01a7336-23641ac62fcmr3095555ad.7.1749585856133;
        Tue, 10 Jun 2025 13:04:16 -0700 (PDT)
Received: from nikunj-kela-u22.eng.sima.ai ([205.234.21.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349ffc151sm7629818a91.48.2025.06.10.13.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 13:04:15 -0700 (PDT)
From: Nikunj Kela <nikunj.kela@sima.ai>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: rmk+kernel@armlinux.org.uk,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	romain.gantois@bootlin.com,
	inochiama@gmail.com,
	l.rubusch@gmail.com,
	quentin.schulz@cherry.de,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nikunj Kela <nikunj.kela@sima.ai>
Subject: [PATCH] net: stmmac: extend use of snps,multicast-filter-bins property to xgmac
Date: Tue, 10 Jun 2025 13:04:11 -0700
Message-Id: <20250610200411.3751943-1-nikunj.kela@sima.ai>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hash based multicast filtering is an optional feature. Currently,
driver overrides the value of multicast_filter_bins based on the hash
table size. If the feature is not supported, hash table size reads 0
however the value of multicast_filter_bins remains set to default
HASH_TABLE_SIZE which is incorrect. Let's extend the use of the property
snps,multicast-filter-bins to xgmac so it can be set to 0 via devicetree
to indicate multicast filtering is not supported.

Signed-off-by: Nikunj Kela <nikunj.kela@sima.ai>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index b80c1efdb323..4164b3a580d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -579,6 +579,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->pmt = 1;
 		if (of_property_read_bool(np, "snps,tso"))
 			plat->flags |= STMMAC_FLAG_TSO_EN;
+		of_property_read_u32(np, "snps,multicast-filter-bins",
+				     &plat->multicast_filter_bins);
 	}
 
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
-- 
2.34.1


