Return-Path: <netdev+bounces-120444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D2D959622
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 09:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D291C213DC
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 07:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD5419ABA6;
	Wed, 21 Aug 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAXrAUoQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522619ABA1
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225465; cv=none; b=qKPR+RPug5L1R/S10RBOGO4fh2IQwsEytBBauQmkPIiQDTU6jCDupO4GFcb9Pb+0OK+4/b67IBKK/5sR2Q5DGi24QaposiZGESjkTo2kStYWqGY9Kl7QYtkE3ydV33zHraZcdVIhvGW3Oymve6vYwIS1Ly7mvyhXPYf3WLh0mWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225465; c=relaxed/simple;
	bh=e7dYysvJxqrEQeB1fTSrqO1cw5Vz4LQ15wNULOJH7fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T/COsw+2VlZQkKHIX9aPNJB8I4FFy822raDiF1o0mEHa0WMAv4I7tvnHeZwatL2JGE6C7Am02bVH9nzmcvUE0Uf9c5KOSJBP4PClyhsoIvFa831yynSBS/ybTRyhRXCAGDinJ0YS5cHz9PpsyRewDQMDuM8V2b3k1NspvcY4WFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAXrAUoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF817C32786;
	Wed, 21 Aug 2024 07:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724225464;
	bh=e7dYysvJxqrEQeB1fTSrqO1cw5Vz4LQ15wNULOJH7fE=;
	h=From:Date:Subject:To:Cc:From;
	b=EAXrAUoQ78LnnKL4hp34i4yntiyRZRR/d/q18wj5Eu/WOGDwUGyMgMYyuIvOILAAQ
	 Tkyjx0nHrMj6wm+ekLS9KRpNGbQRlF3iRdwjaxq2GwMMo0bD7MHcQb/1h4LhJdmBWG
	 L6d0jo7DWKhKnewDuujJGZmmR2qjC8OiH2Cs4FYGdgyF8NVS3g4zpzQpmv+4TsrlxX
	 gfw/SdhoSEeFs7KwV9R0njuF9SVfMOUGglv16iDlpjUh2cXCAB0l2RwitlaZ6BFZSy
	 9q9sH1Hv2WHAwaCtiklX9nUz2oxr6N5FyU4hyv+9PUCf5levsuTH1Gsp+UJvBTuPp2
	 PHafTF2b/QxAA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 21 Aug 2024 09:30:14 +0200
Subject: [PATCH net-next v2] net: airoha: configure hw mac address
 according to the port id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-airoha-eth-wan-mac-addr-v2-1-8706d0cd6cd5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIWXxWYC/4WOwQ6CMBBEf4X07Jq2IBRP/ofxsNAtNCrVBVFj+
 HcLHDx6fJPMm/mInthTL/bJRzCNvvehi6A3iahb7BoCbyMLLXUmjSoBPYcWgYYWntjBFWtAaxl
 klqeVrqwpEUVs35icfy3m42llpvsjDgxr+PPHudleyB24wJCDUlDdHGCaleRqaawz+1GLWdP6f
 gj8Xv6OavH8vTYqUEDGFrVKq1QZfTgTd3TZBm7EaZqmL/MzGjUGAQAA
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 lorenzo.bianconi83@gmail.com, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.0

GDM1 port on EN7581 SoC is connected to the lan dsa switch.
GDM{2,3,4} can be used as wan port connected to an external
phy module. Configure hw mac address registers according to the port id.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- improve code readability adding reg offset for {LAN,WAN}_LMIN and
  {LAN,WAN}_LMAX regs
- fix signed-off-by tag
- Link to v1: https://lore.kernel.org/r/20240819-airoha-eth-wan-mac-addr-v1-1-e8d7c13b3182@kernel.org
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 32 +++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 1fb46db0c1e9..0c012efca3b0 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -67,9 +67,11 @@
 #define FE_RST_GDM3_MBI_ARB_MASK	BIT(2)
 #define FE_RST_CORE_MASK		BIT(0)
 
+#define REG_FE_WAN_MAC_H		0x0030
 #define REG_FE_LAN_MAC_H		0x0040
-#define REG_FE_LAN_MAC_LMIN		0x0044
-#define REG_FE_LAN_MAC_LMAX		0x0048
+
+#define REG_FE_MAC_LMIN(_n)		((_n) + 0x04)
+#define REG_FE_MAC_LMAX(_n)		((_n) + 0x08)
 
 #define REG_FE_CDM1_OQ_MAP0		0x0050
 #define REG_FE_CDM1_OQ_MAP1		0x0054
@@ -900,16 +902,28 @@ static void airoha_qdma_irq_disable(struct airoha_qdma *qdma, int index,
 	airoha_qdma_set_irqmask(qdma, index, mask, 0);
 }
 
-static void airoha_set_macaddr(struct airoha_eth *eth, const u8 *addr)
+static bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
 {
-	u32 val;
+	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
+	 * GDM{2,3,4} can be used as wan port connected to an external
+	 * phy module.
+	 */
+	return port->id == 1;
+}
+
+static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
+{
+	struct airoha_eth *eth = port->qdma->eth;
+	u32 val, reg;
 
+	reg = airhoa_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
+					   : REG_FE_WAN_MAC_H;
 	val = (addr[0] << 16) | (addr[1] << 8) | addr[2];
-	airoha_fe_wr(eth, REG_FE_LAN_MAC_H, val);
+	airoha_fe_wr(eth, reg, val);
 
 	val = (addr[3] << 16) | (addr[4] << 8) | addr[5];
-	airoha_fe_wr(eth, REG_FE_LAN_MAC_LMIN, val);
-	airoha_fe_wr(eth, REG_FE_LAN_MAC_LMAX, val);
+	airoha_fe_wr(eth, REG_FE_MAC_LMIN(reg), val);
+	airoha_fe_wr(eth, REG_FE_MAC_LMAX(reg), val);
 }
 
 static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
@@ -2340,7 +2354,7 @@ static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
 	if (err)
 		return err;
 
-	airoha_set_macaddr(port->qdma->eth, dev->dev_addr);
+	airoha_set_macaddr(port, dev->dev_addr);
 
 	return 0;
 }
@@ -2349,7 +2363,7 @@ static int airoha_dev_init(struct net_device *dev)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
 
-	airoha_set_macaddr(port->qdma->eth, dev->dev_addr);
+	airoha_set_macaddr(port, dev->dev_addr);
 
 	return 0;
 }

---
base-commit: a99ef548bba01435f19137cf1670861be1c1ee4b
change-id: 20240819-airoha-eth-wan-mac-addr-0463b2bd89aa
prerequisite-change-id: 20240705-for-6-11-bpf-a349efc08df8:v2

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


