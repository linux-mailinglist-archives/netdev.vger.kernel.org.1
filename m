Return-Path: <netdev+bounces-181356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F404BA84A15
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365777B551A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C66E290BD5;
	Thu, 10 Apr 2025 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SupIhBar"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290941EF37B;
	Thu, 10 Apr 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302662; cv=none; b=i1vTHPEkX/8GT+dRNcaZgzkBd9bvYW8o5thZdl/JpEI0Vc+qfUyLcAa86mjLVM1WOY/HVP82+dzwUc0BAf908KbkcrSxrNB2+oEodLfolxpncezqrQCNqLCMC+c5ulKaLQoRZaoQ6wYgGvQ4m216NN3xOfKPqULuM8VjYXTdAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302662; c=relaxed/simple;
	bh=39VSe38U38tIemBNqloIsd9qRjjxnIoDR52dX6RadPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5B/jpT3p37fICp+7iDY8qQbHrQ5K4XklYmlRzWn63DYhByH/8F3qD07E6XRGaLmxtGNzZstuluTteUIFYdDE3D7Yct4eUviYpIVWNuW2geeiHphq87jBw5Se5WOSA00ZH3A631+7LlS/gPl1S71x/hx97uWDnPFvQs7tpCiTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SupIhBar; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0618746bso8203385e9.2;
        Thu, 10 Apr 2025 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744302659; x=1744907459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5wCdgkj1tLGVgRC6kEKRulIXxRtilUymkai9Lqmc7k=;
        b=SupIhBaruGhgIT0R0BnHHLZ/96DU80yBiTimcK0xwa4WrW95JHOHYRx/y5s37Igd9t
         Tnlr9ZljRA8nQWSjCAVItuzg13xGciOKRtTXZPz8YLs5H3TB7dv0tbqsG0UWXw5GxM5r
         8SZTvB1MMSS3sRLL7Pz0Gvh8LR2KThME/uhdth+qDgTA7gSfQreAexsoInDDfhW63OxA
         p/vSgLSaJWuksUFNHvXOA/jqOhPcc5zc/UNpvu4FRD88+e3wHadh3dOOjCtiOCtrvCqA
         dwWnrQVfPRVXWFK6C7jbhPueABlejsxC8DYnO4vx3iKSQZK7bTiAsSYZ8an0Gqg6DhIa
         y/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744302659; x=1744907459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5wCdgkj1tLGVgRC6kEKRulIXxRtilUymkai9Lqmc7k=;
        b=pY+eW8a6oVwPXmKtnC4Y5+UcvVMSYPjLRQDoflenlFcjwnNHHGpcscRIqf96LO60vX
         oONeOou12IYb0XIJ2sF1J5/2deyo/Y8B5N4rbUoqD1Ic19EmfpmQZoKw7S9bw1h+FtQA
         1bW9WIxXrSB9LnMRfi3QMOPdJp47IdeMihr8h/dqCNpJtY6JGEGrUA20TABj8OJIvlbg
         7H8NcgPMmASi5U6QgbuyB/LdHe78AKfbvbBbQ1WsqwZFA4DXCa1d9yrTXSx94GmrVUZ7
         JoZanPXvqhq9AHYLwI1kbjTXHu5fX7MGlgXkGeXBkeSsGrwgzzLvuGgq2uywOBwS5R/4
         W0aA==
X-Forwarded-Encrypted: i=1; AJvYcCXmHs86mqXoXMJYlBntWBz+sxnb0LVRHusv5mMSyPQ55uajMyxSGaEyhksF/v10L/2SQafVxIjN@vger.kernel.org, AJvYcCXpVKAj86oiq7JzoSRaKvbLBKU6GtYc5NLU6OiKXCTi0wz+rOaZY/EbcPkUzB7dSYH8lAGR5uyPu/MgQlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr86MAp1O3P9eX7cq1cC3qa6AemVZ7FZd/N0TND0U4ygY5WQP6
	TrG6cxzkr9FdInOOhbpiJOxyo2ultvbdSJvR6Ws6mLKP7c0LFbqG
X-Gm-Gg: ASbGncvYN/DPwYuW1E/ACHkm5lG5o6PeoWyegtJG+YxeOFXV7B1Bgj184J6DNQ9Wyau
	WOzK7EhnuJzrap1LtkY8G0LGbr8dfjZn6Cxv8Obhsc4Qal5Qq06SQTW4CygZLlHmw1MToVWWZcj
	hlo9frWzgNJ9e/evg1RiiLZf3OxrOZjSfmr2/Ng0lHr5oQrd5natIYGI4ZhFGD7oDn9x3Ls5/jo
	tqGjl9ZiSdRLILe4hPXcphvv5igpahuVvLMwZKbqIkESBa8zluBNeNKKoTOZFOKnhx82wvG40+7
	anOfFVSYj+wQGcytg/Pi2pfADF5FtaeiRPxnEEs8RwX7FrsMFtIu7LJ8H2nAJJf5OyM2WKbBk/k
	syT2lqzR0Fg==
X-Google-Smtp-Source: AGHT+IFWV+rbSMlqhfkoULEzkNSZq5SXSEPgsO8dHqya+MOqyfnGDk6SISRU5Fy2AR50TnIhmQMcUg==
X-Received: by 2002:a5d:64cd:0:b0:390:fc83:a070 with SMTP id ffacd0b85a97d-39d8f2254d1mr2958848f8f.0.1744302659288;
        Thu, 10 Apr 2025 09:30:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39d893f0a75sm5374033f8f.62.2025.04.10.09.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:30:58 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 5/6] net: dsa: mt7530: move remaining MIB counter to define
Date: Thu, 10 Apr 2025 18:30:13 +0200
Message-ID: <20250410163022.3695-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410163022.3695-1-ansuelsmth@gmail.com>
References: <20250410163022.3695-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For consistency with the other MIB counter, move also the remaining MIB
counter to define and update the custom MIB table.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/mt7530.c | 18 +++++++++---------
 drivers/net/dsa/mt7530.h |  9 +++++++++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2202c657930e..fdceefb2083c 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -32,15 +32,15 @@ static struct mt753x_pcs *pcs_to_mt753x_pcs(struct phylink_pcs *pcs)
 
 /* String, offset, and register size in bytes if different from 4 bytes */
 static const struct mt7530_mib_desc mt7530_mib[] = {
-	MIB_DESC(1, 0x00, "TxDrop"),
-	MIB_DESC(1, 0x04, "TxCrcErr"),
-	MIB_DESC(1, 0x14, "TxCollision"),
-	MIB_DESC(1, 0x60, "RxDrop"),
-	MIB_DESC(1, 0x64, "RxFiltering"),
-	MIB_DESC(1, 0x78, "RxCrcErr"),
-	MIB_DESC(1, 0xb0, "RxCtrlDrop"),
-	MIB_DESC(1, 0xb4, "RxIngressDrop"),
-	MIB_DESC(1, 0xb8, "RxArlDrop"),
+	MIB_DESC(1, MT7530_PORT_MIB_TX_DROP, "TxDrop"),
+	MIB_DESC(1, MT7530_PORT_MIB_TX_CRC_ERR, "TxCrcErr"),
+	MIB_DESC(1, MT7530_PORT_MIB_TX_COLLISION, "TxCollision"),
+	MIB_DESC(1, MT7530_PORT_MIB_RX_DROP, "RxDrop"),
+	MIB_DESC(1, MT7530_PORT_MIB_RX_FILTERING, "RxFiltering"),
+	MIB_DESC(1, MT7530_PORT_MIB_RX_CRC_ERR, "RxCrcErr"),
+	MIB_DESC(1, MT7530_PORT_MIB_RX_CTRL_DROP, "RxCtrlDrop"),
+	MIB_DESC(1, MT7530_PORT_MIB_RX_INGRESS_DROP, "RxIngressDrop"),
+	MIB_DESC(1, MT7530_PORT_MIB_RX_ARL_DROP, "RxArlDrop"),
 };
 
 static void
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 0cc999fa1380..d4b838a055ad 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -424,9 +424,12 @@ enum mt7530_vlan_port_acc_frm {
 /* Register for MIB */
 #define MT7530_PORT_MIB_COUNTER(x)	(0x4000 + (x) * 0x100)
 /* Each define is an offset of MT7530_PORT_MIB_COUNTER */
+#define   MT7530_PORT_MIB_TX_DROP	0x00
+#define   MT7530_PORT_MIB_TX_CRC_ERR	0x04
 #define   MT7530_PORT_MIB_TX_UNICAST	0x08
 #define   MT7530_PORT_MIB_TX_MULTICAST	0x0c
 #define   MT7530_PORT_MIB_TX_BROADCAST	0x10
+#define   MT7530_PORT_MIB_TX_COLLISION	0x14
 #define   MT7530_PORT_MIB_TX_SINGLE_COLLISION 0x18
 #define   MT7530_PORT_MIB_TX_MULTIPLE_COLLISION 0x1c
 #define   MT7530_PORT_MIB_TX_DEFERRED	0x20
@@ -440,10 +443,13 @@ enum mt7530_vlan_port_acc_frm {
 #define   MT7530_PORT_MIB_TX_PKT_SZ_512_TO_1023 0x40
 #define   MT7530_PORT_MIB_TX_PKT_SZ_1024_TO_MAX 0x44
 #define   MT7530_PORT_MIB_TX_BYTES	0x48 /* 64 bytes */
+#define   MT7530_PORT_MIB_RX_DROP	0x60
+#define   MT7530_PORT_MIB_RX_FILTERING	0x64
 #define   MT7530_PORT_MIB_RX_UNICAST	0x68
 #define   MT7530_PORT_MIB_RX_MULTICAST	0x6c
 #define   MT7530_PORT_MIB_RX_BROADCAST	0x70
 #define   MT7530_PORT_MIB_RX_ALIGN_ERR	0x74
+#define   MT7530_PORT_MIB_RX_CRC_ERR	0x78
 #define   MT7530_PORT_MIB_RX_UNDER_SIZE_ERR 0x7c
 #define   MT7530_PORT_MIB_RX_FRAG_ERR	0x80
 #define   MT7530_PORT_MIB_RX_OVER_SZ_ERR 0x84
@@ -456,6 +462,9 @@ enum mt7530_vlan_port_acc_frm {
 #define   MT7530_PORT_MIB_RX_PKT_SZ_512_TO_1023 0xa0
 #define   MT7530_PORT_MIB_RX_PKT_SZ_1024_TO_MAX 0xa4
 #define   MT7530_PORT_MIB_RX_BYTES	0xa8 /* 64 bytes */
+#define   MT7530_PORT_MIB_RX_CTRL_DROP	0xb0
+#define   MT7530_PORT_MIB_RX_INGRESS_DROP 0xb4
+#define   MT7530_PORT_MIB_RX_ARL_DROP	0xb8
 #define MT7530_MIB_CCR			0x4fe0
 #define  CCR_MIB_ENABLE			BIT(31)
 #define  CCR_RX_OCT_CNT_GOOD		BIT(7)
-- 
2.48.1


