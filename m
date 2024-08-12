Return-Path: <netdev+bounces-117621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2734594E949
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32AB1F243D1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132A16C84D;
	Mon, 12 Aug 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG0bjKo8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6516B39A;
	Mon, 12 Aug 2024 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453635; cv=none; b=rysmBTklhlZN10FeBGge8k4k0U+K5WH/QpeIDdKXvcO+7M3c/amC9iRuzr4cIh/MpscBzNoC4zbC15FfXNg55rUoINdwGXhM6mrcDbtU+51TEjX3bSVQGLtyLP067pWIXVDQ5t6aRv5dL/fZ4PyZFpw+VjxTXjvXfVjbweJgbo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453635; c=relaxed/simple;
	bh=3xzkQpRdJW5ritYBA77n0R4J9VBAnnrxCxLGCtkyTSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2ce0SEpFwnm9OOwnBusRJIrPeXkvPCmbwea4ndjvlg50zjsr3tt5Jvzvateu0xM/Zh9ul1AkXubX3EhXmQUpqOlstCpUbi7H7SwAmgMiJk52XpVO2KPhD3043XoE12E8XjpnQ/cm7x280SYVlE+vjaoBHak6KwHNF1TfMy3+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TG0bjKo8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa086b077so357725166b.0;
        Mon, 12 Aug 2024 02:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723453632; x=1724058432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xu5ei+WeKMB1ugZ/0HFgyqZDv7eZM8KwgWsYvwxkaj8=;
        b=TG0bjKo8h/+oo5uY27GBKO4rQM6pjSITl+M9n93ywGa6a/cDkrk4knsGFXECr+j/0O
         InicVA8rpYzn6F9yspm+anM8W9efcraG6DtqZKAwSZz9bbvrDuxdBUafzGygMu7pTXBB
         93esEQYCIVORivh26u0LU46HTndedm44UW3JGmEBhnIKfNdR+dEnbGvStBm1Tkrw6LOF
         nEWZZLZDJ3hg7VyGJi0b9PHB+vJMp85nKwLRP5pQuxXRNrUFblE3KLWI6ACJ7ld0jcDY
         tiSIKzFzPlwfBBtVy8xkU+IDNvssmYXarw9xUKAnL7RhS5TIrMyKSLSsATKkchS8J2Jn
         /KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453632; x=1724058432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xu5ei+WeKMB1ugZ/0HFgyqZDv7eZM8KwgWsYvwxkaj8=;
        b=HYD09YfoHxiLKhUbH3Tgzs5hpSaNBPLtGrM8FvNDXbslQLIlyxcPTS4aL7DaDGC3g5
         zfUTmVDcc9cg74Vy3aarIddP2OaCzB5BGkSX76H0XTNz/5aOTqlcfWw11o1u9IKVoTlL
         EehQjQGYQEijfZenEkG1BkLqoskGRvtXV6R52bTuHILfq38BOUPvAUUYAcKnmEZVaGTg
         ZFV2RJnnzJQRbcLAiRLflY63iiWTy2tg0YjwegfoK3VsjfJqZnJE3UM0dGRG2K3VWveJ
         J3J72knc4Xe8BLcnxCYqES3iAZ3up6twCaJMa5EBL16MgL6Lsa08DrM+PNftRugxdn7j
         mMpw==
X-Forwarded-Encrypted: i=1; AJvYcCV8IEO2bl0Qlf/FauKaSZrOR8M6i9h5JJzPIDR3m99K0BEN1cy22Wa8G03Bbevu70gjj+/vVzq2wJrg44Td5mL9Kep5VV3AI1LOvdA/F6HwiTw6okZ/2b5cBYaYZBusNskt2JYV
X-Gm-Message-State: AOJu0YyoMYbd3yegydr3I2oaJbYGJPyWX45Ygfq9PFDi//PC5ldjaPpL
	BRUqgkZdDelw/yPj3DZBHMRNuK6IU23mGtn1EYCTxY2oUrifk/NP
X-Google-Smtp-Source: AGHT+IFtyfr93btSOunBPQWY4ea21EnjGnxGFf0hrJY8KdZM0n2j0FjBHM3/y++llhXsiXZLRbbFCw==
X-Received: by 2002:a17:906:d25a:b0:a7a:9a78:4b5a with SMTP id a640c23a62f3a-a80aa6600f1mr599087866b.52.1723453631959;
        Mon, 12 Aug 2024 02:07:11 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb21314esm212265166b.152.2024.08.12.02.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 02:07:11 -0700 (PDT)
From: vtpieter@gmail.com
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/1] net: macb: increase max_mtu for oversized frames
Date: Mon, 12 Aug 2024 11:06:55 +0200
Message-ID: <20240812090657.583821-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Increase max_mtu from 1500 to 1518 bytes when not configured for jumbo
frames. Use 1536 as a starting point as documented in macb.h for
oversized (big) frames, which is the configuration applied in case
jumbo frames capability is not configured; ref. macb_main.c.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 95e8742dce1d..c46fce4a9175 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5119,12 +5119,12 @@ static int macb_probe(struct platform_device *pdev)
 		goto err_out_free_netdev;
 	}
 
-	/* MTU range: 68 - 1500 or 10240 */
+	/* MTU range: 68 - 1518 or 10240 */
 	dev->min_mtu = GEM_MTU_MIN_SIZE;
 	if ((bp->caps & MACB_CAPS_JUMBO) && bp->jumbo_max_len)
 		dev->max_mtu = bp->jumbo_max_len - ETH_HLEN - ETH_FCS_LEN;
 	else
-		dev->max_mtu = ETH_DATA_LEN;
+		dev->max_mtu = 1536 - ETH_HLEN - ETH_FCS_LEN;
 
 	if (bp->caps & MACB_CAPS_BD_RD_PREFETCH) {
 		val = GEM_BFEXT(RXBD_RDBUFF, gem_readl(bp, DCFG10));

base-commit: c4e82c025b3f2561823b4ba7c5f112a2005f442b
-- 
2.43.0


