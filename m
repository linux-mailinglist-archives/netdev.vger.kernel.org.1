Return-Path: <netdev+bounces-181355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C8A84A11
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFEE189D914
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99A8290097;
	Thu, 10 Apr 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4icWOTB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1EE29009A;
	Thu, 10 Apr 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302661; cv=none; b=YUdAD+mAHWkc5i4ljGWsbrjA/pzwVhVVMzs8a0J3urbuCUcKOAmpHZ1JOOd/Sn3iHln4kqLD39LX31J8Rn4nhtTVWh+2Pes9Xd7FTU1AU3mWgzMWruqCWu+Wm0hgn3/QT5m86B+rH1EdKbk1DMQSGCIu35SZ4FpPF+Q+ojkWd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302661; c=relaxed/simple;
	bh=gx6Q6oSyb2WLahet4+BtWnvgdencHUlb8TGnpv3WD60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YURU7cfxGt2RyHWVYrqsrNHRp7L9sq5ZZJDECejs3sHqYzxwZwYbYlsEOT15ky2LqeHWdLw03kow6Vp2H22n1gmZj/65uIFm8LvxBM4eP8NtMlSAcFMR3M8ENLkoFRmRDTif/UdKmvWF+d5onaSowJpFmnAlQ0lxIE3RL/yKuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4icWOTB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe574976so8147935e9.1;
        Thu, 10 Apr 2025 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744302658; x=1744907458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+t0ThrIYIg8kRh+6KjbsFKWZobuMu8npO6bHx5WsaE=;
        b=S4icWOTBK+A1e1jphhrTBgccvt9JyVg6ZdE+VT9e7mx2HbLZ8SfldacjuVWaylKjnv
         U8Z97SfJQIsROGMdOTSEmodX0cC8wJP6tZIsepwTqSe40KRjJkwEMAm0RBiPCOm0kmwd
         bMhCSvFZB4iGYKBC6gNtqeCfxug6WQsZeWwbMG9hArluyaxz3ysLEVsJZymU4TP5JEaq
         lGOmY6W+R1FQYyr91k7HoP7koxSl3SN5kbszwa5gwzHgxC+PYyYL47BY2EuoJGn3JVH2
         YLWhIlsHFZFghiRpKas8Ebw3S7UxEjhLdBf+Qppgl4LMBuIh7buP6ohgzaPvcpu5/N83
         sGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744302658; x=1744907458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+t0ThrIYIg8kRh+6KjbsFKWZobuMu8npO6bHx5WsaE=;
        b=rtQ8nCcDiL74F7KP5JOzF+z+uaez+9ryuf1TW77YqUoS0De7l+gIG0GdPLjRH5z6iZ
         YTWWI1MiAcNmhy1clfBmvaNaaTj9GqV37jnIcQ5mOCwhIzvI2xFlrNTgcDcMH1z2ahre
         VdV7ZdrcDhIciQoLxNL7K6CWUbZS+XISNhiQ2wEjwT4tbJFLOEpmo/qaKAxGYHAqy0fp
         0iJT9fNSzN2BojgjLOlYDIyKFxqPG8Gm++O2WY+SDRBkFF7B01WsdCG8MPoCACWUK9cy
         Swsv8aENWPvE73PvE/RD7SGgoD1a6sRpcRLD07RS3ReGgszPSuUUi7uQhTDpxh5voF9r
         mFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnJxSopnzcqWWajN/0kARJJz2JZbJyGtCtz3X1t4zVSW5gnxaS1iVGHOOV6DTVzntL+MZrwGpB@vger.kernel.org, AJvYcCX9qNKYD3Arigg3nxmQjjUqnzpgvhUpYAB1h6hqKqopbZY1FDselXQ2Di0Spm4DKAzIGZbqgD4yaSt/Gs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ02highZ6TI7dEDBWWzZWw3MugdU7BeoLDaFZ2kxtrK7uoVlE
	ekDzmliyH77xWoB2a7iTBbQJB1tpNx6jBlkLyy9r/Sn63kswqdfm
X-Gm-Gg: ASbGnct9QfRub+brbQW3WnYhMAewaYHsBbz6HzzPaHQ09h8Z/0Snej31e8egzXTxujT
	RGAIVeckTWxkiwc0HhbBDzPmtQakqA9BAsHeOAMbZW+0+Dz+G6ja715ArTZP+7sLBa5LYu161Qw
	QOZkdCGIhf6gR1xKe44obEPROUFTpROkvoK05gfDhfvD4VtDlOaDkQpxZ8OyZ+OugPEB6pCNTqH
	7n9SNf2egBcKrdB23yqo30pMmV2doSNXpRIyWDQ/8xkyogNqGV48fHK4HB7CVlv91DOEXEC+fr2
	weG+OSWHiYwUulk4yfWg+j2+H9HRfIRAS5ruHV6IFSWstYT4FOlkxV0Gp++BDESygoFSA4h8bdh
	K2lhm1rF5wg==
X-Google-Smtp-Source: AGHT+IFY5aV83GlIg+n7ieI6jdJYgPToMMFEdF0UZ8l6w8maxikCyARfM8V5dWLEqlrZ22qBBqnhFw==
X-Received: by 2002:a05:600c:190e:b0:43b:cb12:ba6d with SMTP id 5b1f17b1804b1-43f2d798f69mr35478345e9.3.1744302658070;
        Thu, 10 Apr 2025 09:30:58 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39d893f0a75sm5374033f8f.62.2025.04.10.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:30:57 -0700 (PDT)
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
Subject: [net-next PATCH 4/6] net: dsa: mt7530: move pkt stats and err MIB counter to eth_mac stats API
Date: Thu, 10 Apr 2025 18:30:12 +0200
Message-ID: <20250410163022.3695-5-ansuelsmth@gmail.com>
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

Drop custom handling of TX/RX packet stats and error MIB counter and handle
them in the standard .get_eth_mac_stats API

The MIB entry are dropped from the custom MIB table and converted to
a define providing only the MIB offset.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/mt7530.c | 70 ++++++++++++++++++++++++++++++++--------
 drivers/net/dsa/mt7530.h | 14 ++++++++
 2 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index f183a604355e..2202c657930e 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -34,24 +34,10 @@ static struct mt753x_pcs *pcs_to_mt753x_pcs(struct phylink_pcs *pcs)
 static const struct mt7530_mib_desc mt7530_mib[] = {
 	MIB_DESC(1, 0x00, "TxDrop"),
 	MIB_DESC(1, 0x04, "TxCrcErr"),
-	MIB_DESC(1, 0x08, "TxUnicast"),
-	MIB_DESC(1, 0x0c, "TxMulticast"),
-	MIB_DESC(1, 0x10, "TxBroadcast"),
 	MIB_DESC(1, 0x14, "TxCollision"),
-	MIB_DESC(1, 0x18, "TxSingleCollision"),
-	MIB_DESC(1, 0x1c, "TxMultipleCollision"),
-	MIB_DESC(1, 0x20, "TxDeferred"),
-	MIB_DESC(1, 0x24, "TxLateCollision"),
-	MIB_DESC(1, 0x28, "TxExcessiveCollistion"),
-	MIB_DESC(2, 0x48, "TxBytes"),
 	MIB_DESC(1, 0x60, "RxDrop"),
 	MIB_DESC(1, 0x64, "RxFiltering"),
-	MIB_DESC(1, 0x68, "RxUnicast"),
-	MIB_DESC(1, 0x6c, "RxMulticast"),
-	MIB_DESC(1, 0x70, "RxBroadcast"),
-	MIB_DESC(1, 0x74, "RxAlignErr"),
 	MIB_DESC(1, 0x78, "RxCrcErr"),
-	MIB_DESC(2, 0xa8, "RxBytes"),
 	MIB_DESC(1, 0xb0, "RxCtrlDrop"),
 	MIB_DESC(1, 0xb4, "RxIngressDrop"),
 	MIB_DESC(1, 0xb8, "RxArlDrop"),
@@ -811,6 +797,61 @@ mt7530_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	return ARRAY_SIZE(mt7530_mib);
 }
 
+static void mt7530_get_eth_mac_stats(struct dsa_switch *ds, int port,
+				     struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct mt7530_priv *priv = ds->priv;
+
+	/* MIB counter doesn't provide a FramesTransmittedOK but instead
+	 * provide stats for Unicast, Broadcast and Multicast frames separately.
+	 * To simulate a global frame counter, read Unicast and addition Multicast
+	 * and Broadcast later
+	 */
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_UNICAST, 1,
+			       &mac_stats->FramesTransmittedOK);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_SINGLE_COLLISION, 1,
+			       &mac_stats->SingleCollisionFrames);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_MULTIPLE_COLLISION, 1,
+			       &mac_stats->MultipleCollisionFrames);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_UNICAST, 1,
+			       &mac_stats->FramesReceivedOK);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_BYTES, 2,
+			       &mac_stats->OctetsTransmittedOK);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_ALIGN_ERR, 1,
+			       &mac_stats->AlignmentErrors);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_DEFERRED, 1,
+			       &mac_stats->FramesWithDeferredXmissions);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_LATE_COLLISION, 1,
+			       &mac_stats->LateCollisions);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_EXCESSIVE_COLLISION, 1,
+			       &mac_stats->FramesAbortedDueToXSColls);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_BYTES, 2,
+			       &mac_stats->OctetsReceivedOK);
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_MULTICAST, 1,
+			       &mac_stats->MulticastFramesXmittedOK);
+	mac_stats->FramesTransmittedOK += mac_stats->MulticastFramesXmittedOK;
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_TX_BROADCAST, 1,
+			       &mac_stats->BroadcastFramesXmittedOK);
+	mac_stats->FramesTransmittedOK += mac_stats->BroadcastFramesXmittedOK;
+
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_MULTICAST, 1,
+			       &mac_stats->MulticastFramesReceivedOK);
+	mac_stats->FramesReceivedOK += mac_stats->MulticastFramesReceivedOK;
+	mt7530_read_port_stats(priv, port, MT7530_PORT_MIB_RX_BROADCAST, 1,
+			       &mac_stats->BroadcastFramesReceivedOK);
+	mac_stats->FramesReceivedOK += mac_stats->BroadcastFramesReceivedOK;
+}
+
 static const struct ethtool_rmon_hist_range mt7530_rmon_ranges[] = {
 	{ 0, 64 },
 	{ 65, 127 },
@@ -3163,6 +3204,7 @@ const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_strings		= mt7530_get_strings,
 	.get_ethtool_stats	= mt7530_get_ethtool_stats,
 	.get_sset_count		= mt7530_get_sset_count,
+	.get_eth_mac_stats	= mt7530_get_eth_mac_stats,
 	.get_rmon_stats		= mt7530_get_rmon_stats,
 	.get_eth_ctrl_stats	= mt7530_get_eth_ctrl_stats,
 	.set_ageing_time	= mt7530_set_ageing_time,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index a651ad29b750..0cc999fa1380 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -424,6 +424,14 @@ enum mt7530_vlan_port_acc_frm {
 /* Register for MIB */
 #define MT7530_PORT_MIB_COUNTER(x)	(0x4000 + (x) * 0x100)
 /* Each define is an offset of MT7530_PORT_MIB_COUNTER */
+#define   MT7530_PORT_MIB_TX_UNICAST	0x08
+#define   MT7530_PORT_MIB_TX_MULTICAST	0x0c
+#define   MT7530_PORT_MIB_TX_BROADCAST	0x10
+#define   MT7530_PORT_MIB_TX_SINGLE_COLLISION 0x18
+#define   MT7530_PORT_MIB_TX_MULTIPLE_COLLISION 0x1c
+#define   MT7530_PORT_MIB_TX_DEFERRED	0x20
+#define   MT7530_PORT_MIB_TX_LATE_COLLISION 0x24
+#define   MT7530_PORT_MIB_TX_EXCESSIVE_COLLISION 0x28
 #define   MT7530_PORT_MIB_TX_PAUSE	0x2c
 #define   MT7530_PORT_MIB_TX_PKT_SZ_64	0x30
 #define   MT7530_PORT_MIB_TX_PKT_SZ_65_TO_127 0x34
@@ -431,6 +439,11 @@ enum mt7530_vlan_port_acc_frm {
 #define   MT7530_PORT_MIB_TX_PKT_SZ_256_TO_511 0x3c
 #define   MT7530_PORT_MIB_TX_PKT_SZ_512_TO_1023 0x40
 #define   MT7530_PORT_MIB_TX_PKT_SZ_1024_TO_MAX 0x44
+#define   MT7530_PORT_MIB_TX_BYTES	0x48 /* 64 bytes */
+#define   MT7530_PORT_MIB_RX_UNICAST	0x68
+#define   MT7530_PORT_MIB_RX_MULTICAST	0x6c
+#define   MT7530_PORT_MIB_RX_BROADCAST	0x70
+#define   MT7530_PORT_MIB_RX_ALIGN_ERR	0x74
 #define   MT7530_PORT_MIB_RX_UNDER_SIZE_ERR 0x7c
 #define   MT7530_PORT_MIB_RX_FRAG_ERR	0x80
 #define   MT7530_PORT_MIB_RX_OVER_SZ_ERR 0x84
@@ -442,6 +455,7 @@ enum mt7530_vlan_port_acc_frm {
 #define   MT7530_PORT_MIB_RX_PKT_SZ_256_TO_511 0x9c
 #define   MT7530_PORT_MIB_RX_PKT_SZ_512_TO_1023 0xa0
 #define   MT7530_PORT_MIB_RX_PKT_SZ_1024_TO_MAX 0xa4
+#define   MT7530_PORT_MIB_RX_BYTES	0xa8 /* 64 bytes */
 #define MT7530_MIB_CCR			0x4fe0
 #define  CCR_MIB_ENABLE			BIT(31)
 #define  CCR_RX_OCT_CNT_GOOD		BIT(7)
-- 
2.48.1


