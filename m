Return-Path: <netdev+bounces-164454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D586A2DD5C
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 13:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C56B1886E5F
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D591DC996;
	Sun,  9 Feb 2025 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX3rKGxu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52D1D61B5;
	Sun,  9 Feb 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739102980; cv=none; b=j3oo97sIsuLLKsZ0eXUGYh8HBrvWPaPuLoxuEz2mb9QizrgkhO56mTfS9MaEdzP05r2ThCROB20Z+D/i7N2VE8se0Mvx3l8E3OZo70o4DgVWYyShELW4KppGHn5X+KdqfeVuzR0jOoVDCH/VfMbXgrUQAsW+ISYXRPqBUqyVnkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739102980; c=relaxed/simple;
	bh=C1aFaWCNYf7kg2GH5A7lQw7Iuw2I/SkqM+nxoGYrGqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhJDjspxSJ63QRzUX2eQMQ+nn+F7XJ56+X/hJW6WFCLuGsn4nLAfNz1DL0g7td8pr3afAefkBfhIvvI8BtUSXTLQ3zuW7szfSwxOVUBVSi4uCoAsWnfzw8z1ea39zITSojgxKXi9crEvc8iQ70FLvPBeAix1XXy2c0k6fHcSHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX3rKGxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12472C4CEE2;
	Sun,  9 Feb 2025 12:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739102979;
	bh=C1aFaWCNYf7kg2GH5A7lQw7Iuw2I/SkqM+nxoGYrGqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LX3rKGxuCVWzZ1YUV1qDWtoC178FikIiMBYdF8qT8YZuuOhiuYqLIUCZuSED5nhHS
	 vtpi1ymnaA3Gw+oY9FAdBOY9Q5Gu85n9aZPaLqcXXQyUj9VVFcpstB+znrUbhQunDE
	 ujYCZAWcA6yNNqaCK/hBT/q6yFQaizTJ1T6+zEDim6XIo9UaaRD/1/YEn8kKaDgYgQ
	 bP1eev5felglHWDj3yFHpmydkiPgjm5GNPSx57CDMgFh00KEUe3wKHFNiXTFe66Ung
	 eASpq+LlddmDATDdO98jnl4OmCRFzqoQMqIrNWcCJ6Zo1iTFLi8rqjqFeenTtfxr8p
	 dvvsXoPFaxrCQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 09 Feb 2025 13:09:00 +0100
Subject: [PATCH net-next v3 07/16] net: dsa: mt7530: Enable Rx sptag for
 EN7581 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-airoha-en7581-flowtable-offload-v3-7-dba60e755563@kernel.org>
References: <20250209-airoha-en7581-flowtable-offload-v3-0-dba60e755563@kernel.org>
In-Reply-To: <20250209-airoha-en7581-flowtable-offload-v3-0-dba60e755563@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

Packet Processor Engine (PPE) module used for hw acceleration on EN7581
mac block, in order to properly parse packets, requires DSA untagged
packets on TX side and read DSA tag from DMA descriptor on RX side.
For this reason, enable RX Special Tag (SPTAG) for EN7581 SoC.
This is a preliminary patch to enable netfilter flowtable hw offloading
on EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/dsa/mt7530.c | 5 +++++
 drivers/net/dsa/mt7530.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 1c83af805209cae40c56138fa8f72261e396f58c..eec8ba9d68088f1dbb2a774a32d3d60af1a9784c 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2586,6 +2586,11 @@ mt7531_setup_common(struct dsa_switch *ds)
 	/* Allow mirroring frames received on the local port (monitor port). */
 	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
 
+	/* Enable Special Tag for rx frames */
+	if (priv->id == ID_EN7581)
+		mt7530_write(priv, MT753X_CPORT_SPTAG_CFG,
+			     CPORT_SW2FE_STAG_EN | CPORT_FE2SW_STAG_EN);
+
 	/* Flush the FDB table */
 	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
 	if (ret < 0)
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 448200689f492dcb73ef056d7284090c1c662e67..349d72a35771f35d478244ab29be1801b3466a5f 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -627,6 +627,10 @@ enum mt7531_xtal_fsel {
 #define  MT7531_GPIO12_RG_RXD3_MASK	GENMASK(19, 16)
 #define  MT7531_EXT_P_MDIO_12		(2 << 16)
 
+#define MT753X_CPORT_SPTAG_CFG		0x7c10
+#define  CPORT_SW2FE_STAG_EN		BIT(1)
+#define  CPORT_FE2SW_STAG_EN		BIT(0)
+
 /* Registers for LED GPIO control (MT7530 only)
  * All registers follow this pattern:
  * [ 2: 0]  port 0

-- 
2.48.1


