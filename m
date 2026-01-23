Return-Path: <netdev+bounces-252676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCl0K3Qqc2kAswAAu9opvQ
	(envelope-from <netdev+bounces-252676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:59:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2D5721B6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 627F73022F55
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A737735CB62;
	Fri, 23 Jan 2026 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="g65kkIZb"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8953B33F8A1;
	Fri, 23 Jan 2026 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155165; cv=none; b=jkBL+pGwJ4MeyQMm0a+TYv40LNXpyRGoiAjy/PStEBF7tYsqYu1u7QYenS5pZTnREVpieGixuGExbO6A/0IoNf6qNesZQIWAuKUgiz7+xrpRnRq9u4imGRIBEXlZ4sIzgMtlsk3zS4+9Q/fw/DaOBNHXS8et9MvdXREsOon4REQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155165; c=relaxed/simple;
	bh=bHXbzE/+Yo/JNhbG2NsN6vtPGpV6kxPkRR46z0DdXrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akS/N11nSIVzsbKU/uQCkHRU/YsKaZR6OHllKrJ8QHn2scbKQosxDPaR/T6kn8br957FHCBp2+2RkrhqjdDitU7+MG/Zc4H4dEftJpt7Yuj/JKj2G61a7FCMlRpjf7b3KmTINRS6VDlfl3HxYkR8gtRxvObfy3tOCmQop9kISeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=g65kkIZb; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=g65kkIZb;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 60N7wmTo1303116
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 07:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1769155128; bh=uykuFO/98bhDIWNo7fPSo8egYnLMoJznMpVSVmQyKgo=;
	h=From:To:Cc:Subject:Date:Message-ID:References:From;
	b=g65kkIZbMbgpgquWZnY38I8LPNlsCGl9G5KddQ0yoxkD0/pdixUmsH0xec91IlVrT
	 /HYMaYo1vpMmpD0H4UlzU/vLThIEMCBQGwhuUzlbP4/71gVwJWyoP8WbcxlvsF3Bvc
	 Ry8UQubBj1n8OHPMqpbVdtYFXJyBusUWMPWprwdI=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 60N7wmnN3568556
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 08:58:48 +0100
Received: (nullmailer pid 1162109 invoked by uid 1000);
	Fri, 23 Jan 2026 07:58:48 -0000
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: netdev@vger.kernel.org
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH net-next v2 3/3] net: phy: air_en8811h: Add clk provider for an8811hb
Date: Fri, 23 Jan 2026 08:58:17 +0100
Message-ID: <20260123075817.1162068-4-bjorn@mork.no>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123075817.1162068-1-bjorn@mork.no>
References: <20260123075817.1162068-1-bjorn@mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,makrotopia.org,nxp.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	TAGGED_FROM(0.00)[bounces-252676-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mork.no:+];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mork.no:email,mork.no:dkim,mork.no:mid,init.name:url]
X-Rspamd-Queue-Id: 2C2D5721B6
X-Rspamd-Action: no action

Implement clk provider driver so we can disable the clock output when it
isn't needed. This helps to reduce EMF noise

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 drivers/net/phy/air_en8811h.c | 107 ++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index ed6a094a4185..e664cbc2f1ed 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -954,6 +954,105 @@ static int en8811h_led_hw_is_supported(struct phy_device *phydev, u8 index,
 	return 0;
 };
 
+static unsigned long an8811hb_clk_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+	u32 pbus_value;
+	int ret;
+
+	ret = air_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return (pbus_value & AN8811HB_HWTRAP2_CKO) ? 50000000 : 25000000;
+}
+
+static int an8811hb_clk_enable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	return air_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
+				       AN8811HB_CLK_DRV_CKO_MASK,
+				       AN8811HB_CLK_DRV_CKO_MASK);
+}
+
+static void an8811hb_clk_disable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	air_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
+				AN8811HB_CLK_DRV_CKO_MASK, 0);
+}
+
+static int an8811hb_clk_is_enabled(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+	u32 pbus_value;
+	int ret;
+
+	ret = air_buckpbus_reg_read(phydev, AN8811HB_CLK_DRV, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return (pbus_value & AN8811HB_CLK_DRV_CKO_MASK);
+}
+
+static int an8811hb_clk_save_context(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+
+	priv->cko_is_enabled = an8811hb_clk_is_enabled(hw);
+
+	return 0;
+}
+
+static void an8811hb_clk_restore_context(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+
+	if (!priv->cko_is_enabled)
+		an8811hb_clk_disable(hw);
+}
+
+static const struct clk_ops an8811hb_clk_ops = {
+	.recalc_rate		= an8811hb_clk_recalc_rate,
+	.enable			= an8811hb_clk_enable,
+	.disable		= an8811hb_clk_disable,
+	.is_enabled		= an8811hb_clk_is_enabled,
+	.save_context		= an8811hb_clk_save_context,
+	.restore_context	= an8811hb_clk_restore_context,
+};
+
+static int an8811hb_clk_provider_setup(struct device *dev, struct clk_hw *hw)
+{
+	struct clk_init_data init;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		return 0;
+
+	init.name = devm_kasprintf(dev, GFP_KERNEL, "%s-cko",
+				   fwnode_get_name(dev_fwnode(dev)));
+	if (!init.name)
+		return -ENOMEM;
+
+	init.ops = &an8811hb_clk_ops;
+	init.flags = 0;
+	init.num_parents = 0;
+	hw->init = &init;
+
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
 static unsigned long en8811h_clk_recalc_rate(struct clk_hw *hw,
 					     unsigned long parent)
 {
@@ -1095,6 +1194,12 @@ static int an8811hb_probe(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	priv->phydev = phydev;
+	/* Co-Clock Output */
+	ret = an8811hb_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
+	if (ret)
+		return ret;
+
 	/* Configure led gpio pins as output */
 	ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
 				      AN8811HB_GPIO_OUTPUT_345,
@@ -1520,6 +1625,8 @@ static struct phy_driver en8811h_driver[] = {
 	.get_rate_matching	= en8811h_get_rate_matching,
 	.config_aneg		= en8811h_config_aneg,
 	.read_status		= an8811hb_read_status,
+	.resume			= en8811h_resume,
+	.suspend		= en8811h_suspend,
 	.config_intr		= en8811h_clear_intr,
 	.handle_interrupt	= en8811h_handle_interrupt,
 	.led_hw_is_supported	= en8811h_led_hw_is_supported,
-- 
2.47.3


