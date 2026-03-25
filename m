Return-Path: <netdev+bounces-271643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BNVIncNxGk+vgQAu9opvQ
	(envelope-from <netdev+bounces-271643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:29:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 455E4329040
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CF643036178
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EA13F7E94;
	Wed, 25 Mar 2026 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3YD66HM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65865275AE4;
	Wed, 25 Mar 2026 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456142; cv=none; b=M79V6EWIc5Maq78J4Tlah1cEufycuIV/D73L491ppaeeIXmi3lQbm+azrO880ApsQ4LcNbelM7Pzgc3cD2kIJJpK9v1S/E7lczny57YKlOh8Cs5DRJ3GERhgnG++GEMvmY+JqGIz2E08mJF96DKyK86VCzHaUM8jNTQqMqt8asw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456142; c=relaxed/simple;
	bh=sIsBFeb3KZOx+9CaK6nReqYaT2Bs7FjZ70XRq/nm1LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0+d9rAsfChi9AFB+3oGUC77VLmc7k61wwKRdTX+oMOExZFW50jWdS3KN5iLwdQQGwPDUlmV8JFVyzeb/bd0PKT8CT5DWkrIjO5lIy/AegyP+LGBAO0bDROCTIyd21rzgOSPQV78zmX567iDMGST0xv00WbvnqO1KtvtPmnx4Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3YD66HM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91272C4CEF7;
	Wed, 25 Mar 2026 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456142;
	bh=sIsBFeb3KZOx+9CaK6nReqYaT2Bs7FjZ70XRq/nm1LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3YD66HM5yTpZewBdW9bOuwy4S5lmiW9H19JeLXXBNWTnAQsIbmhQcpD/8Q0KEHwg
	 JD+Jdn5Xu3lBukFpO8ELGoRBEoMsgJPD+GK/htrX1JPbEukkHDt27gHniq5+9aUdo1
	 4Aywc/dVWGrKOC1EzpkSAcSOoW6Jo/CqGDdQ/Xj2cHgIFAcBQ2T8Pjz4/sQMaXhvtP
	 bfMHaWZzpa7qr8zOWLCaRB8tekbrV//j4359kH+JhfZsGUISGDe+xDE5xQzhpDZCEi
	 CsCvhY03pxoC8vBlSjQJiZX4gE8MW+td18kqNCMsAVf3Ws6jopZnaFpWvtJIgmtoXW
	 QLg1uwlytxXUQ==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com,
	Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next v5 02/14] net: macb: rename macb_default_usrio to at91_default_usrio as not all platforms have mii mode control in usrio
Date: Wed, 25 Mar 2026 16:28:06 +0000
Message-ID: <20260325-landowner-preformed-2922ce736337@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10230; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=CeO2TghHg4sCYeNQ+bvHpMtUsEKz3Xd7QRxVowdYzU0=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeE2TebQWnji/af7r2jcr8vT7g26Eee4qEVI9/mi/v UJx0XHhjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzE5Akjw5IHq6t5H6afy/r2 21Pe6q6n/fwrE0XaTtaH6/w+vV+qt5zhn+nyY9LJl04FebxO/Cm3tHruew/lI1N6wm7vVf1pb+n YxwMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271643-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 455E4329040
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

Calling this structure macb_default_usrio is misleading, I believe, as
it implies that it should be used if your platform has nothing special
to do in usrio. Since usrio is platform dependent, the default here is
probably for each usrio to do nothing, with the macb documentation I
have access to prescribing no standard behaviour here. We noticed that
this was problematic because on mpfs, a bit that macb_default_usrio
sets to deal with the MII mode actually changes the source for the
tsu_clk to something with how the majority of mpfs devices are actually
configured!

Rename it to at91_default_usrio, since that's where the values actually
come from for these. I have no idea if any of the other platforms that
use the default actually copied at91's usrio configuration or if they
have usrio configurations where what the driver does has no impact.

Gate touching these bits behind a capability, like the clken refclock
usrio knob, so that platforms without the MII mode stuff can avoid
running this code.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb.h      |   1 +
 drivers/net/ethernet/cadence/macb_main.c | 108 +++++++++++++----------
 2 files changed, 63 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index c69828b27dae6..32217de5e0730 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -786,6 +786,7 @@
 #define MACB_CAPS_RSC				BIT(23)
 #define MACB_CAPS_NO_LSO			BIT(24)
 #define MACB_CAPS_EEE				BIT(25)
+#define MACB_CAPS_USRIO_HAS_MII			BIT(26)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a48160da6e672..05a2df6e3e41d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4884,13 +4884,15 @@ static int macb_init_dflt(struct platform_device *pdev)
 
 	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED)) {
 		val = 0;
-		if (phy_interface_mode_is_rgmii(bp->phy_interface))
-			val = bp->usrio->rgmii;
-		else if (bp->phy_interface == PHY_INTERFACE_MODE_RMII &&
-			 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
-			val = bp->usrio->rmii;
-		else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
-			val = bp->usrio->mii;
+		if (bp->caps & MACB_CAPS_USRIO_HAS_MII) {
+			if (phy_interface_mode_is_rgmii(bp->phy_interface))
+				val = bp->usrio->rgmii;
+			else if (bp->phy_interface == PHY_INTERFACE_MODE_RMII &&
+				 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
+				val = bp->usrio->rmii;
+			else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
+				val = bp->usrio->mii;
+		}
 
 		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
 			val |= bp->usrio->refclk;
@@ -4917,13 +4919,6 @@ static int macb_init(struct platform_device *pdev,
 		return macb_init_dflt(pdev);
 }
 
-static const struct macb_usrio_config macb_default_usrio = {
-	.mii = MACB_BIT(MII),
-	.rmii = MACB_BIT(RMII),
-	.rgmii = GEM_BIT(RGMII),
-	.refclk = MACB_BIT(CLKEN),
-};
-
 #if defined(CONFIG_OF)
 /* 1518 rounded up */
 #define AT91ETHER_MAX_RBUFF_SZ	0x600
@@ -5498,6 +5493,13 @@ static int eyeq5_init(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct macb_usrio_config at91_default_usrio = {
+	.mii = MACB_BIT(MII),
+	.rmii = MACB_BIT(RMII),
+	.rgmii = GEM_BIT(RGMII),
+	.refclk = MACB_BIT(CLKEN),
+};
+
 static const struct macb_usrio_config sama7g5_usrio = {
 	.mii = 0,
 	.rmii = 1,
@@ -5508,85 +5510,95 @@ static const struct macb_usrio_config sama7g5_usrio = {
 
 static const struct macb_config fu540_c000_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.clk_init = fu540_c000_clk_init,
 	.init = fu540_c000_init,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config at91sam9260_config = {
-	.caps = MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
-	.usrio = &macb_default_usrio,
+	.caps = MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
+		MACB_CAPS_USRIO_HAS_MII,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config sama5d3macb_config = {
 	.caps = MACB_CAPS_SG_DISABLED |
-		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
-	.usrio = &macb_default_usrio,
+		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
+		MACB_CAPS_USRIO_HAS_MII,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config pc302gem_config = {
-	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE,
+	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config sama5d2_config = {
-	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
+	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config sama5d29_config = {
-	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_GEM_HAS_PTP,
+	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config sama5d3_config = {
 	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE |
-		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
+		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config sama5d4_config = {
-	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
+	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 4,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config emac_config = {
-	.caps = MACB_CAPS_NEEDS_RSTONUBR | MACB_CAPS_MACB_IS_EMAC,
+	.caps = MACB_CAPS_NEEDS_RSTONUBR | MACB_CAPS_MACB_IS_EMAC |
+		MACB_CAPS_USRIO_HAS_MII,
 	.clk_init = at91ether_clk_init,
 	.init = at91ether_init,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config np4_config = {
 	.caps = MACB_CAPS_USRIO_DISABLED,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config zynqmp_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH,
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config zynq_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF |
-		MACB_CAPS_NEEDS_RSTONUBR,
+		MACB_CAPS_NEEDS_RSTONUBR |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config mpfs_config = {
@@ -5595,7 +5607,7 @@ static const struct macb_config mpfs_config = {
 		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 	.max_tx_length = 4040, /* Cadence Erratum 1686 */
 	.jumbo_max_len = 4040,
 };
@@ -5603,7 +5615,8 @@ static const struct macb_config mpfs_config = {
 static const struct macb_config sama7g5_gem_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
-		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.usrio = &sama7g5_usrio,
 };
@@ -5611,7 +5624,8 @@ static const struct macb_config sama7g5_gem_config = {
 static const struct macb_config sama7g5_emac_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
 		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.usrio = &sama7g5_usrio,
 };
@@ -5620,11 +5634,12 @@ static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
 		MACB_CAPS_NEED_TSUCLK | MACB_CAPS_QUEUE_DISABLE |
-		MACB_CAPS_QBV,
+		MACB_CAPS_QBV |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config eyeq5_config = {
@@ -5634,16 +5649,17 @@ static const struct macb_config eyeq5_config = {
 	.dma_burst_length = 16,
 	.init = eyeq5_init,
 	.jumbo_max_len = 10240,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config raspberrypi_rp1_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP |
-		MACB_CAPS_EEE,
+		MACB_CAPS_EEE |
+		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 	.jumbo_max_len = 10240,
 };
 
@@ -5691,7 +5707,7 @@ static const struct macb_config default_gem_config = {
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
-	.usrio = &macb_default_usrio,
+	.usrio = &at91_default_usrio,
 	.jumbo_max_len = 10240,
 };
 
-- 
2.53.0


