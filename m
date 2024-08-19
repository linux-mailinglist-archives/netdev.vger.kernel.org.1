Return-Path: <netdev+bounces-119676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8303F956908
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEA41F22815
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0BD15B12B;
	Mon, 19 Aug 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fse6Isco"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765302209F
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065814; cv=none; b=ef3HAb0dX0H87+C+0LjwVkxWrqjI6OJV9eNYOQLl0nB+EXssxDeAIRNLOmd6zN6B+zCNgSxdIW52KZUPR8j56/roWkEHPftfCJlUbplcLLEuvBZj5GXpPjC8Awr1UsxcpNAmghC/VhAds1vTjP/6QVzTyPnK9JBOiS9utITLMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065814; c=relaxed/simple;
	bh=hRlfP4Eb88D8IgNcliWrTMZtueZ9Wxlg1wLUE+yG/qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RXdbm9FH1oPL839XmIaQgRy+DDLfcjcXl7cUUWSNNmTqNjKIGaESKW80iKhDo64s4M/OlwhHv9/nDi4RDqPDK5nIiGBmUMvCQ4qApmLI6u+pGtm977QF+8Rpirv97skcrge+sT67xtkd9Mx8uTNR8sV1SNgaGSDUxOMXpJgl0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fse6Isco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702C9C4AF0C;
	Mon, 19 Aug 2024 11:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724065813;
	bh=hRlfP4Eb88D8IgNcliWrTMZtueZ9Wxlg1wLUE+yG/qs=;
	h=From:Date:Subject:To:Cc:From;
	b=fse6Iscoa6Y+WAZDq1+OL18a97PafMlO/bNnJz5KwKgpzMj04Ftd93IN8nk0M5152
	 KuckX0h6cQQaVO3BVm12uTtGZ7UGkW7gOJ8SX0YKp8ohfeZAnasHnB+QdykoVTSuyv
	 bQYe+idGS3bDXpycj1HFtr4ghNaxyONjA7O+5PLi+wcc6NTV8Zjt7l96X++IiMA15J
	 QUHNI8sp9nfHmWr3UlDaKMskgLUwx0ZxX4QlL/FDXlSXOzzco03nyFdcpkAHs5mCuq
	 tLAaBKCcCBZMriE+fMJl/D8SQM8btuV5oTDpF+s8gdHbr2S4nepZIoYoSWSX1uv/Oa
	 EqJwQCgV8Mjdw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 19 Aug 2024 13:10:09 +0200
Subject: [PATCH net-next] net: airoha: configure hw mac address according
 to the port id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-airoha-eth-wan-mac-addr-v1-1-e8d7c13b3182@kernel.org>
X-B4-Tracking: v=1; b=H4sIABAow2YC/0WNQQ6CMBBFr0Jm7SRtQSxcxbAY6NR2YcEB0YRwd
 xtYuHwv+e9vMLNEnqEtNhBe4xzHlEFfChgCpQdjdJnBKFMpqxukKGMg5CXghxI+aUByTlBVddm
 b3tmGCPJ6Evbxe5Tv3cnCr3c+WE7577fFUb+pK/pRsEatsZ88Ulk17AdlnbftaqDb9x/j83/Ps
 AAAAA==
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

---
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 33 +++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 1fb46db0c1e9..4914565c2fac 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -67,6 +67,10 @@
 #define FE_RST_GDM3_MBI_ARB_MASK	BIT(2)
 #define FE_RST_CORE_MASK		BIT(0)
 
+#define REG_FE_WAN_MAC_H		0x0030
+#define REG_FE_WAN_MAC_LMIN		0x0034
+#define REG_FE_WAN_MAC_LMAX		0x0038
+
 #define REG_FE_LAN_MAC_H		0x0040
 #define REG_FE_LAN_MAC_LMIN		0x0044
 #define REG_FE_LAN_MAC_LMAX		0x0048
@@ -900,16 +904,31 @@ static void airoha_qdma_irq_disable(struct airoha_qdma *qdma, int index,
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
+	bool is_lan_port = airhoa_is_lan_gdm_port(port);
+	struct airoha_eth *eth = port->qdma->eth;
+	u32 val, reg;
 
 	val = (addr[0] << 16) | (addr[1] << 8) | addr[2];
-	airoha_fe_wr(eth, REG_FE_LAN_MAC_H, val);
+	reg = is_lan_port ? REG_FE_LAN_MAC_H : REG_FE_WAN_MAC_H;
+	airoha_fe_wr(eth, reg, val);
 
 	val = (addr[3] << 16) | (addr[4] << 8) | addr[5];
-	airoha_fe_wr(eth, REG_FE_LAN_MAC_LMIN, val);
-	airoha_fe_wr(eth, REG_FE_LAN_MAC_LMAX, val);
+	reg = is_lan_port ? REG_FE_LAN_MAC_LMIN : REG_FE_WAN_MAC_LMIN;
+	airoha_fe_wr(eth, reg, val);
+
+	reg = is_lan_port ? REG_FE_LAN_MAC_LMAX : REG_FE_WAN_MAC_LMAX;
+	airoha_fe_wr(eth, reg, val);
 }
 
 static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
@@ -2340,7 +2359,7 @@ static int airoha_dev_set_macaddr(struct net_device *dev, void *p)
 	if (err)
 		return err;
 
-	airoha_set_macaddr(port->qdma->eth, dev->dev_addr);
+	airoha_set_macaddr(port, dev->dev_addr);
 
 	return 0;
 }
@@ -2349,7 +2368,7 @@ static int airoha_dev_init(struct net_device *dev)
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


