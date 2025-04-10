Return-Path: <netdev+bounces-181353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD3A84A0E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587DC1B834C2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675B29008C;
	Thu, 10 Apr 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv+LCZN4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37C28153D;
	Thu, 10 Apr 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302659; cv=none; b=Chm7o5M2U/LkPj6ZJcPEOoaxoisCPP8/VBS8o8pP37Y6Oucm/oB3EIwsRMmIHkHS3kNkpQNoGBDsrSgQ0zUYMKtslfkOg4zryMK2ymwGTV61Sh203PcoGnsVx2dhGjLcHMb327yKeGpbbyp27SacBEGYTizigFUmh2guucP0CBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302659; c=relaxed/simple;
	bh=/w9OecnK4FmVNhCpOp6jS3YnQjKpvghNjowiKk7u+uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXf288FF8k/e5s/JzmxYBKpTsxotad9SAxYmWLrENlRdbAim3xsuezpEozX/UEbgSvPtyr4oQR8IbZDc/W0ml08SV+c0cZd0mRn4idG5HxoGTOLmsZFhOPbfUxIWb5EyiXylf3wAKSaxkoVExakItNh+fr2rvj2bKWeGaaIb8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv+LCZN4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so11703015e9.2;
        Thu, 10 Apr 2025 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744302656; x=1744907456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2YZc1LaMVkn7aFFV6kzKwyOO/D0/i0GDUriI0k11XQ=;
        b=Rv+LCZN4jEBCAi4AkGqkjGJsLqvfrTuW9EJUZyVta3GuUG5NKPMr+91L9cM9L+HAia
         +8Pu/WwSHq8Jobqb35EvjFJWB+gEsoah87x35J9r1+I3ciswjCtFLUD2EXut59ike/h1
         7rEI6lmhhuWSFEYEDeu4nm9NJstuP6LP9UpTlASw0WB/QhMnYM2lGr78XdsvyVl9qVa+
         2tKQVZfyly7sjE1Cywvr3UDu8nUkp/fYzYusX+jHe+wagnXP5BtPFg2WAJRqjNnqLFiL
         f2Rm32Ds91QTVuHb9yBMy382O1hxEeScjVWru3nVPcfUGc8DtZcr6vaW1oSpOuihDUB2
         N+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744302656; x=1744907456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2YZc1LaMVkn7aFFV6kzKwyOO/D0/i0GDUriI0k11XQ=;
        b=em8zSLUxrMib+DcZ2bTOvlc6k6E+YMfTwNJcN4H5W31GljjTIpOLIIKL0qeHiHi9Or
         CQZfvzpDWMu8UNQLgedk++LWIKVjh7uh1EjuADumoCwo4NNz1FM/phVDJT+vJOtBwfGA
         k9ok3EGCIK/zbdRU/xHaHGSxVBceuaBnwdTV0z7/ZnFfZxWIR+cwNVrds3DP6bVX9slX
         YT31uD+S6VZxXyby1Ik6GMY+j8ib+8w3tx6JG2YaDwki2eGQtG/0uuKPk29Ucpg2+6+i
         iUGJQgRIa/eoruPNB6c3LaLcUhl6Q4AGoqCW63ONrl8Z8vGZvt6BdOb8gmv7/aShEb/0
         YJkw==
X-Forwarded-Encrypted: i=1; AJvYcCUchi1irihWoo+0IOB2+b6bYaTlLHJIQslEDeSsBdvQ5Wis29p4gDOdwpuZnK+PvkA6VmWkL+JI@vger.kernel.org, AJvYcCW5MbNfrlAZiCQFwawC+Ok/80kPKS0Q5CEpxp5CCCIBTn6cWAE1+E0KatNq2M7ziGDyk8eXBEd8f3bPZi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdbD3Xp7ZassrXd8fdWrGNUyn8nCV0xZJB7Wm5sU7VPQLkYx1U
	siyHXGdQwafL6CNg3bPR8EEeCamUfbZzMUnfgxnQLOWPEtwGTiiu
X-Gm-Gg: ASbGncuq0Ec7EyYKypAHnBj79wQN8KDJXH7TXIqDAQ58+RdyG/Do4uF0gzD3TOJklJQ
	8cx027X/J6URWaDsKbg3nQR9eZG+q8AK80nkNlK8Z2tCFctokmiINlOPBI4DBbAtkP+Ym2CNHl1
	Wgz/ht/fZ25jJoRGyP7IvCU/uSwHos2CLIz/GTT629/9juFzkHNCJqb2zMdhPA3AavrGhcRS4AK
	gIPgUN8bB4NCwq6wEYhAzbH8iQ/46saA1MJbGUw+ndHHLXXuLvji7fCrzvtVRj5PhpRDxDpIwi7
	mtbV3NvozzpjrJcRWBhQ9CTh1J9yB750AFXNQtYQUw5+kd1UhAmyqxZgXitsCPsp9vu7mQaODEA
	mX0edCuN8xg==
X-Google-Smtp-Source: AGHT+IHVp+FavjYbgAfIwEPvJkscRMse+kNVdLuitvwX+OUB4oudwxYscfeW6fHR/DYQRCY2BecERA==
X-Received: by 2002:a05:600c:510f:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-43f2ff9bf72mr24084135e9.22.1744302655492;
        Thu, 10 Apr 2025 09:30:55 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39d893f0a75sm5374033f8f.62.2025.04.10.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:30:55 -0700 (PDT)
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
Subject: [net-next PATCH 2/6] net: dsa: mt7530: move pkt size and rx err MIB counter to rmon stats API
Date: Thu, 10 Apr 2025 18:30:10 +0200
Message-ID: <20250410163022.3695-3-ansuelsmth@gmail.com>
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

Drop custom handling of packet size and RX error MIB counter and handle
them in the standard .get_rmon_stats API

The MIB entry are dropped from the custom MIB table and converted to
a define providing only the MIB offset.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/mt7530.c | 71 +++++++++++++++++++++++++++++++---------
 drivers/net/dsa/mt7530.h | 17 ++++++++++
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 85a040853194..54a6ddc380e9 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -44,12 +44,6 @@ static const struct mt7530_mib_desc mt7530_mib[] = {
 	MIB_DESC(1, 0x24, "TxLateCollision"),
 	MIB_DESC(1, 0x28, "TxExcessiveCollistion"),
 	MIB_DESC(1, 0x2c, "TxPause"),
-	MIB_DESC(1, 0x30, "TxPktSz64"),
-	MIB_DESC(1, 0x34, "TxPktSz65To127"),
-	MIB_DESC(1, 0x38, "TxPktSz128To255"),
-	MIB_DESC(1, 0x3c, "TxPktSz256To511"),
-	MIB_DESC(1, 0x40, "TxPktSz512To1023"),
-	MIB_DESC(1, 0x44, "Tx1024ToMax"),
 	MIB_DESC(2, 0x48, "TxBytes"),
 	MIB_DESC(1, 0x60, "RxDrop"),
 	MIB_DESC(1, 0x64, "RxFiltering"),
@@ -58,17 +52,7 @@ static const struct mt7530_mib_desc mt7530_mib[] = {
 	MIB_DESC(1, 0x70, "RxBroadcast"),
 	MIB_DESC(1, 0x74, "RxAlignErr"),
 	MIB_DESC(1, 0x78, "RxCrcErr"),
-	MIB_DESC(1, 0x7c, "RxUnderSizeErr"),
-	MIB_DESC(1, 0x80, "RxFragErr"),
-	MIB_DESC(1, 0x84, "RxOverSzErr"),
-	MIB_DESC(1, 0x88, "RxJabberErr"),
 	MIB_DESC(1, 0x8c, "RxPause"),
-	MIB_DESC(1, 0x90, "RxPktSz64"),
-	MIB_DESC(1, 0x94, "RxPktSz65To127"),
-	MIB_DESC(1, 0x98, "RxPktSz128To255"),
-	MIB_DESC(1, 0x9c, "RxPktSz256To511"),
-	MIB_DESC(1, 0xa0, "RxPktSz512To1023"),
-	MIB_DESC(1, 0xa4, "RxPktSz1024ToMax"),
 	MIB_DESC(2, 0xa8, "RxBytes"),
 	MIB_DESC(1, 0xb0, "RxCtrlDrop"),
 	MIB_DESC(1, 0xb4, "RxIngressDrop"),
@@ -829,6 +813,60 @@ mt7530_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	return ARRAY_SIZE(mt7530_mib);
 }
 
+static const struct ethtool_rmon_hist_range mt7530_rmon_ranges[] = {
+	{ 0, 64 },
+	{ 65, 127 },
+	{ 128, 255 },
+	{ 256, 511 },
+	{ 512, 1023 },
+	{ 1024, MT7530_MAX_MTU },
+	{}
+};
+
+static void mt7530_get_rmon_stats(struct dsa_switch *ds, int port,
+				  struct ethtool_rmon_stats *rmon_stats,
+				  const struct ethtool_rmon_hist_range **ranges)
+{
+	struct mt7530_priv *priv = ds->priv;
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_UNDER_SIZE_ERR, 1,
+			       &rmon_stats->undersize_pkts);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_OVER_SZ_ERR, 1,
+			       &rmon_stats->oversize_pkts);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_FRAG_ERR, 1,
+			       &rmon_stats->fragments);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_JABBER_ERR, 1,
+			       &rmon_stats->jabbers);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_64, 1,
+			       &rmon_stats->hist[0]);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_65_TO_127, 1,
+			       &rmon_stats->hist[1]);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_128_TO_255, 1,
+			       &rmon_stats->hist[2]);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_256_TO_511, 1,
+			       &rmon_stats->hist[3]);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_512_TO_1023, 1,
+			       &rmon_stats->hist[4]);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_PKT_SZ_1024_TO_MAX, 1,
+			       &rmon_stats->hist[5]);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_64, 1,
+			       &rmon_stats->hist_tx[0]);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_65_TO_127, 1,
+			       &rmon_stats->hist_tx[1]);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_128_TO_255, 1,
+			       &rmon_stats->hist_tx[2]);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_256_TO_511, 1,
+			       &rmon_stats->hist_tx[3]);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_512_TO_1023, 1,
+			       &rmon_stats->hist_tx[4]);
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_PKT_SZ_1024_TO_MAX, 1,
+			       &rmon_stats->hist_tx[5]);
+
+	*ranges = mt7530_rmon_ranges;
+}
+
 static int
 mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 {
@@ -3115,6 +3153,7 @@ const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_strings		= mt7530_get_strings,
 	.get_ethtool_stats	= mt7530_get_ethtool_stats,
 	.get_sset_count		= mt7530_get_sset_count,
+	.get_rmon_stats		= mt7530_get_rmon_stats,
 	.set_ageing_time	= mt7530_set_ageing_time,
 	.port_enable		= mt7530_port_enable,
 	.port_disable		= mt7530_port_disable,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index c3ea403d7acf..9bc90d1678f7 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -423,6 +423,23 @@ enum mt7530_vlan_port_acc_frm {
 
 /* Register for MIB */
 #define MT7530_PORT_MIB_COUNTER(x)	(0x4000 + (x) * 0x100)
+/* Each define is an offset of MT7530_PORT_MIB_COUNTER */
+#define   MT7530_PORT_MIB_TX_PKT_SZ_64	0x30
+#define   MT7530_PORT_MIB_TX_PKT_SZ_65_TO_127 0x34
+#define   MT7530_PORT_MIB_TX_PKT_SZ_128_TO_255 0x38
+#define   MT7530_PORT_MIB_TX_PKT_SZ_256_TO_511 0x3c
+#define   MT7530_PORT_MIB_TX_PKT_SZ_512_TO_1023 0x40
+#define   MT7530_PORT_MIB_TX_PKT_SZ_1024_TO_MAX 0x44
+#define   MT7530_PORT_MIB_RX_UNDER_SIZE_ERR 0x7c
+#define   MT7530_PORT_MIB_RX_FRAG_ERR	0x80
+#define   MT7530_PORT_MIB_RX_OVER_SZ_ERR 0x84
+#define   MT7530_PORT_MIB_RX_JABBER_ERR	0x88
+#define   MT7530_PORT_MIB_RX_PKT_SZ_64	0x90
+#define   MT7530_PORT_MIB_RX_PKT_SZ_65_TO_127 0x94
+#define   MT7530_PORT_MIB_RX_PKT_SZ_128_TO_255 0x98
+#define   MT7530_PORT_MIB_RX_PKT_SZ_256_TO_511 0x9c
+#define   MT7530_PORT_MIB_RX_PKT_SZ_512_TO_1023 0xa0
+#define   MT7530_PORT_MIB_RX_PKT_SZ_1024_TO_MAX 0xa4
 #define MT7530_MIB_CCR			0x4fe0
 #define  CCR_MIB_ENABLE			BIT(31)
 #define  CCR_RX_OCT_CNT_GOOD		BIT(7)
-- 
2.48.1


