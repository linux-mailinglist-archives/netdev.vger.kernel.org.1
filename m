Return-Path: <netdev+bounces-269124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJYMOFPXumkXcgIAu9opvQ
	(envelope-from <netdev+bounces-269124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:48:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A742BF953
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60843303D3B5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75BC3F65F0;
	Wed, 18 Mar 2026 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkn7TpiM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8353F1E89C;
	Wed, 18 Mar 2026 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851893; cv=none; b=PyelcbXEZf0KkmwaFkJpBVSmyrnsF4S8WDvulh9uCdTFOdh7dzhs4R+lG7FHM7H2vBJ0hn0sFhB5NB68k+v1DQ3exAwtH8dWQ70RtgeTFsBBDVFuOv25twSuk+tNzoeJ7uAADJ7R3ca4cuqeDgMuqAtGuoPzC0CWBQpbItI7nKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851893; c=relaxed/simple;
	bh=d+MyLOiuyfRC+NF64EIUpcY9qyHiXTVHxjTblw4Yz08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv25/6WFCfPvuRdb8u+H4c6pMYLy05cD2FRXHBtaZsLnEwrYg1DGTQylF/UIyivf49m8WIc1SKr/bOyZWBJwxho+itJ19F3xPId+vcFPt3t0dEnaX6nC40ctt7QkcnliUI/HCuGk6fJJjFZE/G8Cy/LczLknxaJ0lY4T/ymmQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkn7TpiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2B9C19421;
	Wed, 18 Mar 2026 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773851893;
	bh=d+MyLOiuyfRC+NF64EIUpcY9qyHiXTVHxjTblw4Yz08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkn7TpiMaIaZ+pYbCX/aj3GoQOkJbxIDRMWdK8jZWd2tmzSIKxFKRf/WUeg/qzNL9
	 ZfEh3ddIuvqicK5qekRI0XmL3QtZCUd4WJBGQkJbwiCxdtrgY2WMSgYeT4bNXb63Us
	 IX2owusTSjn6RhjEv3cYmaRXOgNjiAbu4XQ0ALlVo49KvHidjKbPX3LzLp//14ngEP
	 C0D57H/kbnr4Kd9s7X+Q0d9t2EkATNAl1FJvGGSiVeLIscsNJMWSNj1gHcgZvoPYM/
	 LsAx9j2eqwVFj9SkcxuiBKICJ/dsNdlCYp2JK77zxFK9USaGmObYzjxwgpSqj0YfEl
	 C5wy0opPY1pPQ==
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
	Ryan.Wanner@microchip.com
Subject: [PATCH net-next v4 04/13] net: macb: rework usrio refclk selection code
Date: Wed, 18 Mar 2026 16:37:35 +0000
Message-ID: <20260318-legal-bottling-12622a38d98a@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318-surpass-puzzle-f94b46aa8808@spud>
References: <20260318-surpass-puzzle-f94b46aa8808@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5400; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=2bAmm8yzB8brPeFan+juq3/KVYptD7voFpcvqp+7QWc=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJm7rlzMza4sM2s6/0w2Z17Axdk/TR7bCn3VL1Bw3FuWk P3iIfvPjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkQgHD//p75xsXJHbNNNt1 1XjW3MZ/TH2zJTeGNOZJ3la7t1FQr4Thf8khrSmNV6ZH6GreK1Kfsy7JWcVmg6abxh5f9uWT/y8 O4gMA
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
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269124-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.971];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85A742BF953
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

The USRIO based refclk selection code abuses a capability flag to set
the refclk to an external source based on match data/compatible on
sama7g5-emac and use an internal source for the gmac.

Ryan previously added a property in an attempt to decouple the refclk
source from the compatible, because this is not fixed by compatible
and there's variance based on the choices made by board designers.

Originally when Ryan added it, he removed the capability flag entirely
from match data, but this changed the default for the sama7g5-emac and
the removal had to be reverted for these devices. Because these devices
default to an external refclk, and the current property is only capable
of communicating external refclks, there's no way to make the
sama7g5-emac use an internal refclk.

Additionally, this property has no limiting based on compatible, and
if used on a platform with an external refclk that is not controlled
by USRIO the capability would be erroneously set. Because of the reuse
of the at91_default_usrio struct by non-at91 devices, this could cause
the refclk bit to be set in error, on a system where the refclk is
externally provided without usrio settings being required.

Change the new capability flag so that it actually represents the
hardware being capable of controlling the refclk source via USRIO,
and move the selection of default behaviour into the macb_usrio_config
struct provided as part of match data.
Modify the devicetree code to support a new property,
"cdns,refclk-source" which will support devices with either default,
retaining support for "cdns,refclk-external" for compatibility reasons.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 55 ++++++++++++++++++------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index baf48f02d7e27..9cd565cb87e4c 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1214,6 +1214,7 @@ struct macb_usrio_config {
 	u32 refclk;
 	u32 clken;
 	u32 hdfctlen;
+	bool refclk_default_external;
 };
 
 struct macb_config {
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d908850c59498..1f9e46cf7e1cb 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4318,12 +4318,8 @@ static const struct net_device_ops macb_netdev_ops = {
 static void macb_configure_caps(struct macb *bp,
 				const struct macb_config *dt_conf)
 {
-	struct device_node *np = bp->pdev->dev.of_node;
-	bool refclk_ext;
 	u32 dcfg;
 
-	refclk_ext = of_property_read_bool(np, "cdns,refclk-ext");
-
 	if (dt_conf)
 		bp->caps = dt_conf->caps;
 
@@ -4356,9 +4352,6 @@ static void macb_configure_caps(struct macb *bp,
 		}
 	}
 
-	if (refclk_ext)
-		bp->caps |= MACB_CAPS_USRIO_HAS_REFCLK_SOURCE;
-
 	dev_dbg(&bp->pdev->dev, "Cadence caps 0x%08x\n", bp->caps);
 }
 
@@ -4626,8 +4619,36 @@ static int macb_init(struct platform_device *pdev)
 		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
 			val |= bp->usrio->clken;
 
-		if (bp->caps & MACB_CAPS_USRIO_HAS_REFCLK_SOURCE)
-			val |= bp->usrio->refclk;
+		if (bp->caps & MACB_CAPS_USRIO_HAS_REFCLK_SOURCE) {
+			const char *prop;
+			bool refclk_ext;
+			int ret;
+
+			/* Default to whatever was set in the match data for
+			 * this device. There's two properties for refclk
+			 * control, but the boolean one is deprecated so is
+			 * a lower priority to check, no device should have
+			 * both.
+			 */
+			refclk_ext = bp->usrio->refclk_default_external;
+
+			ret = of_property_read_string(pdev->dev.of_node,
+						      "cdns,refclk-source", &prop);
+			if (!ret) {
+				if (!strcmp(prop, "external"))
+					refclk_ext = true;
+				else
+					refclk_ext = false;
+			} else {
+				ret = of_property_read_bool(pdev->dev.of_node,
+							    "cdns,refclk-ext");
+				if (ret)
+					refclk_ext = true;
+			}
+
+			if (refclk_ext)
+				val |= bp->usrio->refclk;
+		}
 
 		macb_or_gem_writel(bp, USRIO, val);
 	}
@@ -5223,11 +5244,21 @@ static const struct macb_usrio_config at91_default_usrio = {
 	.clken = MACB_BIT(CLKEN),
 };
 
-static const struct macb_usrio_config sama7g5_usrio = {
+static const struct macb_usrio_config sama7g5_gem_usrio = {
 	.mii = 0,
 	.rmii = 1,
 	.rgmii = 2,
 	.refclk = BIT(2),
+	.refclk_default_external = false,
+	.hdfctlen = BIT(6),
+};
+
+static const struct macb_usrio_config sama7g5_emac_usrio = {
+	.mii = 0,
+	.rmii = 1,
+	.rgmii = 2,
+	.refclk = BIT(2),
+	.refclk_default_external = true,
 	.hdfctlen = BIT(6),
 };
 
@@ -5364,7 +5395,7 @@ static const struct macb_config sama7g5_gem_config = {
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &sama7g5_usrio,
+	.usrio = &sama7g5_gem_usrio,
 };
 
 static const struct macb_config sama7g5_emac_config = {
@@ -5376,7 +5407,7 @@ static const struct macb_config sama7g5_emac_config = {
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &sama7g5_usrio,
+	.usrio = &sama7g5_emac_usrio,
 };
 
 static const struct macb_config versal_config = {
-- 
2.51.0


