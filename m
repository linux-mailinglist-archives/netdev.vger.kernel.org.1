Return-Path: <netdev+bounces-122968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D1F9634E7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2801F1F25B23
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC25E1ACE0F;
	Wed, 28 Aug 2024 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj/KVSpq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F69167D97;
	Wed, 28 Aug 2024 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884776; cv=none; b=Xip3U6Jfh92gzQubCUtV18H6MeMORaJqn0q8SgcHSmfYHSA0G/gxqB4oIHJx9zcb/aHWXQPLftMMROsf6Lyh0Z1OQPxuxgMCVvLu38koqAmsZ8fDVM63UVAARuoDYuj+bPkTp+iMocWTrzSCVBZaVmyX5Edx8o1P6W9r46ugcsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884776; c=relaxed/simple;
	bh=hL2g5+R0+3D5kT9xlN2Xjv3XOgKXmXgNUB0snbS2Taw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCck6VdxwXCTQF3zOqVWQ28x6VEwbvWTxkWQaL5bc+T3u7GQIgbuwKXeKZMseI21E85og51o8h8nAkecke4S/w9URg/6GFF1XL52sP5UOH9mdFYvaArNPgisy0BL799uMaSqZAOZ8D5QC/Ep62EIz/3ePeRHQyKMWSKWfmPGkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nj/KVSpq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cd9d408040so5093084a12.0;
        Wed, 28 Aug 2024 15:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724884774; x=1725489574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K6o6BkECnkuOK1GQcvdQnquYXfbPomsdFXCEgc7ouEs=;
        b=Nj/KVSpqvPI7QrFs1NByPNEtHXDVNyPPJ/4wGRoFt33yXiXJmrDzGNWXZ3r+Z00Thb
         VuDOVT3FymrT34WwVhQOkMl8znTPGyDzdRBW692vHRgdRCxPHXMS8fYdUpKlvZYc3G7D
         FxAN3PkvhQgYGhppFo9b7wve8QibYuyKmjBSHQhVFabxpwMLz8Jgbrvwg+0xkMD8B6vv
         /83O4XG6//eB0X3E7RMlZxnJYnRu4PlW93yI1x521I7WJqxHu6eZkQSdmwvYtiARfvnU
         zhTuA0d5KINLwd8AoiZ1q7TLoD5N53UarFZCc1XN8QcSTO1YRYKEeVdwN2VH4lkw6lua
         D7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724884774; x=1725489574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6o6BkECnkuOK1GQcvdQnquYXfbPomsdFXCEgc7ouEs=;
        b=YyFUUENHalkk1ovxDLcy4MdDfkw8EltluCgapyqcH1tobLKUW5wdnDrkjSMtrEzHrs
         Bn7jZtu73E54o5vqoSB7Qz2J+KUQqXJQL8wFg2MaIXsg5zLgFlVT9w5K2F+sh8XYh1oq
         bHmEj+EMWeip/HD7t7FCD+VwsSC8C+YGXn4n8VYzFDPI/T4o9WqhwzTeF8f3m07dcfeo
         6UKXftPie0m/DsfFHGp2qZV+ykpjjGF1CC15E4kAG/yt9Osa1Q4VxpBcryH7H5NvQs0n
         7u3m4P2U1b16AW2TiMTpXl4pclcJ3I0BsVY777TOA8ye8f8bLW6Utt9HFNSjsll1f2U1
         rBNw==
X-Forwarded-Encrypted: i=1; AJvYcCWMYEOaiBNRyR09VryzYTgym+O/cji9Cpp/5mU9GbKFPzLxjmd0OIrB7ccOeFY+ED6NnqKzIf21ME17QLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6zsQ4kHBfHmiGecrCfgCx7yjxUwu0Ye1pgE4humRyzesZ/sS
	X94Fets6jmYwtRdVmGNq47PQGbE93VoQ/DprLAlFuPNAoVV8bYiZ5QCvkA==
X-Google-Smtp-Source: AGHT+IE/t0N3dQ+MYjZL/yaqZfC6inixztvtHv53X2Sz2GBCAcRdjqmOEKXar/5MmRzjFg71LbZQbQ==
X-Received: by 2002:a17:90a:cf13:b0:2cf:def1:d1eb with SMTP id 98e67ed59e1d1-2d85617babfmr867340a91.8.1724884774092;
        Wed, 28 Aug 2024 15:39:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445fbf0dsm2538845a91.19.2024.08.28.15.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 15:39:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCHv2 net-next] net: ag71xx: update FIFO bits and descriptions
Date: Wed, 28 Aug 2024 15:38:47 -0700
Message-ID: <20240828223931.153610-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Taken from QCA SDK. No functional difference as same bits get applied.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: forgot to send to netdev
 drivers/net/ethernet/atheros/ag71xx.c | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index db2a8ade6205..692dbded8211 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -149,11 +149,11 @@
 #define FIFO_CFG4_MC		BIT(8)	/* Multicast Packet */
 #define FIFO_CFG4_BC		BIT(9)	/* Broadcast Packet */
 #define FIFO_CFG4_DR		BIT(10)	/* Dribble */
-#define FIFO_CFG4_LE		BIT(11)	/* Long Event */
-#define FIFO_CFG4_CF		BIT(12)	/* Control Frame */
-#define FIFO_CFG4_PF		BIT(13)	/* Pause Frame */
-#define FIFO_CFG4_UO		BIT(14)	/* Unsupported Opcode */
-#define FIFO_CFG4_VT		BIT(15)	/* VLAN tag detected */
+#define FIFO_CFG4_CF		BIT(11)	/* Control Frame */
+#define FIFO_CFG4_PF		BIT(12)	/* Pause Frame */
+#define FIFO_CFG4_UO		BIT(13)	/* Unsupported Opcode */
+#define FIFO_CFG4_VT		BIT(14)	/* VLAN tag detected */
+#define FIFO_CFG4_LE		BIT(15)	/* Long Event */
 #define FIFO_CFG4_FT		BIT(16)	/* Frame Truncated */
 #define FIFO_CFG4_UC		BIT(17)	/* Unicast Packet */
 #define FIFO_CFG4_INIT	(FIFO_CFG4_DE | FIFO_CFG4_DV | FIFO_CFG4_FC | \
@@ -168,28 +168,28 @@
 #define FIFO_CFG5_DV		BIT(1)	/* RX_DV Event */
 #define FIFO_CFG5_FC		BIT(2)	/* False Carrier */
 #define FIFO_CFG5_CE		BIT(3)	/* Code Error */
-#define FIFO_CFG5_LM		BIT(4)	/* Length Mismatch */
-#define FIFO_CFG5_LO		BIT(5)	/* Length Out of Range */
-#define FIFO_CFG5_OK		BIT(6)	/* Packet is OK */
-#define FIFO_CFG5_MC		BIT(7)	/* Multicast Packet */
-#define FIFO_CFG5_BC		BIT(8)	/* Broadcast Packet */
-#define FIFO_CFG5_DR		BIT(9)	/* Dribble */
-#define FIFO_CFG5_CF		BIT(10)	/* Control Frame */
-#define FIFO_CFG5_PF		BIT(11)	/* Pause Frame */
-#define FIFO_CFG5_UO		BIT(12)	/* Unsupported Opcode */
-#define FIFO_CFG5_VT		BIT(13)	/* VLAN tag detected */
-#define FIFO_CFG5_LE		BIT(14)	/* Long Event */
-#define FIFO_CFG5_FT		BIT(15)	/* Frame Truncated */
-#define FIFO_CFG5_16		BIT(16)	/* unknown */
-#define FIFO_CFG5_17		BIT(17)	/* unknown */
+#define FIFO_CFG5_CR		BIT(4)  /* CRC error */
+#define FIFO_CFG5_LM		BIT(5)	/* Length Mismatch */
+#define FIFO_CFG5_LO		BIT(6)	/* Length Out of Range */
+#define FIFO_CFG5_OK		BIT(7)	/* Packet is OK */
+#define FIFO_CFG5_MC		BIT(8)	/* Multicast Packet */
+#define FIFO_CFG5_BC		BIT(9)	/* Broadcast Packet */
+#define FIFO_CFG5_DR		BIT(10)	/* Dribble */
+#define FIFO_CFG5_CF		BIT(11)	/* Control Frame */
+#define FIFO_CFG5_PF		BIT(12)	/* Pause Frame */
+#define FIFO_CFG5_UO		BIT(13)	/* Unsupported Opcode */
+#define FIFO_CFG5_VT		BIT(14)	/* VLAN tag detected */
+#define FIFO_CFG5_LE		BIT(15)	/* Long Event */
+#define FIFO_CFG5_FT		BIT(16)	/* Frame Truncated */
+#define FIFO_CFG5_UC		BIT(17)	/* Unicast Packet */
 #define FIFO_CFG5_SF		BIT(18)	/* Short Frame */
 #define FIFO_CFG5_BM		BIT(19)	/* Byte Mode */
 #define FIFO_CFG5_INIT	(FIFO_CFG5_DE | FIFO_CFG5_DV | FIFO_CFG5_FC | \
-			 FIFO_CFG5_CE | FIFO_CFG5_LO | FIFO_CFG5_OK | \
-			 FIFO_CFG5_MC | FIFO_CFG5_BC | FIFO_CFG5_DR | \
-			 FIFO_CFG5_CF | FIFO_CFG5_PF | FIFO_CFG5_VT | \
-			 FIFO_CFG5_LE | FIFO_CFG5_FT | FIFO_CFG5_16 | \
-			 FIFO_CFG5_17 | FIFO_CFG5_SF)
+			 FIFO_CFG5_CE | FIFO_CFG5_LM | FIFO_CFG5_L0 | \
+			 FIFO_CFG5_OK | FIFO_CFG5_MC | FIFO_CFG5_BC | \
+			 FIFO_CFG5_DR | FIFO_CFG5_CF | FIFO_CFG5_UO | \
+			 FIFO_CFG5_VT | FIFO_CFG5_LE | FIFO_CFG5_FT | \
+			 FIFO_CFG5_UC | FIFO_CFG5_SF)
 
 #define AG71XX_REG_TX_CTRL	0x0180
 #define TX_CTRL_TXE		BIT(0)	/* Tx Enable */
-- 
2.46.0


