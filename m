Return-Path: <netdev+bounces-288817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEQoM/Z3Cmo61wQAu9opvQ
	(envelope-from <netdev+bounces-288817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:22:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD21565071
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B040C3014135
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 02:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1525931F988;
	Mon, 18 May 2026 02:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E640234994;
	Mon, 18 May 2026 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779070917; cv=none; b=G5lmDCUGOH+Z9IDbSHhLq3ZX0wFtanooW0HZXTAlwdvDeBTajdrK3loyE9QAlkRT5xeUkNXnkVj5fZY3k27KojGtshxW9Ma63IJqxCCYpRLlUiJTDc8+ayulGYw7JVMwz7cHO4y1wzq8HsjAo5llHVF5S5bz4qSSWsgLLmDcyRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779070917; c=relaxed/simple;
	bh=zte3WS9ofAs45TfcZYNgT028cQZX2sZoY2LLiVffqSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYuTUGntAoNp1oqNSLQLdUNu4damb6TLJK0ifJyy2jYwLJHl2R83pEXj7xEbm3soDd2QHt4QsCUSC86OpT0H7NClwr6YBiCv8f7m7oTQlEhkl/GEKLZ0eYzR94qh4qrVsbHXDKl6rCdjoTs+y7MxjT+Yemw/hH32uS9vsXMjhTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app2 (Coremail) with SMTP id TQJkCgA3TaCydwpqsUoaAA--.47399S2;
	Mon, 18 May 2026 10:21:40 +0800 (CST)
From: lizhi2@eswincomputing.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net v2 3/5] net: stmmac: eswin: clear TXD and RXD delay registers during initialization
Date: Mon, 18 May 2026 10:21:37 +0800
Message-ID: <20260518022137.464-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260518021919.404-1-lizhi2@eswincomputing.com>
References: <20260518021919.404-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgA3TaCydwpqsUoaAA--.47399S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy5KF1UZr1fGFWUtF1kXwb_yoW5Xw47pF
	WkAFy5Xrn2qryxKanIvFnYgryFyan7Ka1Sk34SkFnI9FyYkry5Ka4jva4YkF1UJrWUAFy3
	t3yUAF1xuF13CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNSdgDUUUU
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Rspamd-Queue-Id: 3AD21565071
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288817-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eswincomputing.com:email,eswincomputing.com:mid]
X-Rspamd-Action: no action

From: Zhi Li <lizhi2@eswincomputing.com>

Clear the TXD and RXD delay control registers during EIC7700 DWMAC
initialization.

These registers may retain values programmed by the bootloader. If left
unchanged, residual delays can alter the effective RGMII timing seen by
the MAC and override the configuration described by the device tree.

This may violate the expected RGMII timing model and can cause link
instability or prevent the Ethernet controller from operating correctly.

Explicitly clearing these registers ensures that the MAC delay settings
are determined solely by the kernel configuration.

The corresponding register offsets are optional, and the registers are
only cleared when the offsets are provided in the device tree.

Fixes: ea77dbbdbc4e ("net: stmmac: add Eswin EIC7700 glue driver")
Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
index 63001c4acdb7..541b279f08a1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
@@ -46,7 +46,11 @@ struct eic7700_qos_priv {
 	u32 eth_axi_lp_ctrl_offset;
 	u32 eth_phy_ctrl_offset;
 	u32 eth_clk_offset;
+	u32 eth_txd_offset;
+	u32 eth_rxd_offset;
 	u32 eth_clk_dly_param;
+	bool has_txd_offset;
+	bool has_rxd_offset;
 };
 
 static int eic7700_clks_config(void *priv, bool enabled)
@@ -84,6 +88,12 @@ static int eic7700_dwmac_init(struct device *dev, void *priv)
 	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_axi_lp_ctrl_offset,
 		     EIC7700_ETH_CSYSREQ_VAL);
 
+	if (dwc->has_txd_offset)
+		regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_txd_offset, 0);
+
+	if (dwc->has_rxd_offset)
+		regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_rxd_offset, 0);
+
 	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_clk_offset,
 		     dwc->eth_clk_dly_param);
 
@@ -190,6 +200,18 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "can't get eth_clk_offset\n");
 
+	ret = of_property_read_u32_index(pdev->dev.of_node,
+					 "eswin,hsp-sp-csr",
+					 4, &dwc_priv->eth_txd_offset);
+	if (!ret)
+		dwc_priv->has_txd_offset = true;
+
+	ret = of_property_read_u32_index(pdev->dev.of_node,
+					 "eswin,hsp-sp-csr",
+					 5, &dwc_priv->eth_rxd_offset);
+	if (!ret)
+		dwc_priv->has_rxd_offset = true;
+
 	plat_dat->num_clks = ARRAY_SIZE(eic7700_clk_names);
 	plat_dat->clks = devm_kcalloc(&pdev->dev,
 				      plat_dat->num_clks,
-- 
2.25.1


