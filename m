Return-Path: <netdev+bounces-166087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DA0A347EF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB233188CCDA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BDE1FF60F;
	Thu, 13 Feb 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ+ZEX6d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA919ADA4;
	Thu, 13 Feb 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460906; cv=none; b=JXA8G+vL7uRJi+aYiBOZxtlKCUTR+f0fiAo0fXAaFjI5/1h/vrXnCrSs4G+xBgi1Rke7m+wocuw/uTkS3t43BDU4AJd3CV1ZGW7rg9OUflYWlkGyqu/fGOmefIsN/wWk8Sv1l7xmz+lYj09exy4gc1Cmd+3+tLBVSc4uRgp0MHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460906; c=relaxed/simple;
	bh=AhjglNReMh607BlyjRNHV+zEVyRap39omDdEs9Q1guw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkhCloN7I5Bo9C9kK/ePzpnQ8WWYAtVLnZqaKBXLmH5ZR3HZkGFylBlWWCBKQofF8fmPnXVlKTFwCwEihPmp5WeunObktT1DsIAltB4J0dXzvRg1V1iNHI6qQhKn25EwjAJzd70M/PamDf72ErSnd1EvqFIoBpfV3VLEDMaEBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ+ZEX6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C4BC4CEE4;
	Thu, 13 Feb 2025 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739460906;
	bh=AhjglNReMh607BlyjRNHV+zEVyRap39omDdEs9Q1guw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IZ+ZEX6dKY1KfwxzwCwFN8ay2FH1HY3FbHN6qg6sLZf99XrCukFbIibPTNmuLKf2K
	 Jx0ioe43ILMPMXO+SCB2+eFKKhmYtCppHi/bMjBEAnI2SiMftjftXHzf7gcXo7uL2A
	 FBkyu9ZzxPqvRvcc5SqW20vrpERPi3wejV+oUHn8vHbGY3ivISpuoKH42TboD2rYZO
	 kL9Nt1hurUOjao4lZmXFl6Ljod1AxjhqtGjYda/jMZyyqYq+9x0EdLnVRFkO8PRBXE
	 2AaoWYz6f4iErsH/Zz3oDwaMLxKXjubRzmUW8xb1TDY/4wyB42doizAZzy4khflR/G
	 /+1qJ8ZvrUw3w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 13 Feb 2025 16:34:26 +0100
Subject: [PATCH net-next v4 07/16] net: dsa: mt7530: Enable Rx sptag for
 EN7581 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-airoha-en7581-flowtable-offload-v4-7-b69ca16d74db@kernel.org>
References: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
In-Reply-To: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
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
index 9fd44e55d51963318ed5cfa3175af9faa77236e4..5b2fa9c0375b6fe7ced7fefc4cc16326d9deb7cf 100644
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


