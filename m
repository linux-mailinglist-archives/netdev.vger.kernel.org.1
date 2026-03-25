Return-Path: <netdev+bounces-271646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KlND2URxGnuvwQAu9opvQ
	(envelope-from <netdev+bounces-271646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:46:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A89233294D0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 642523176F41
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E813F7E89;
	Wed, 25 Mar 2026 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZWaqqXR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46C13FB043;
	Wed, 25 Mar 2026 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456159; cv=none; b=fMbysx0HvGuKpn0I5/0iPV+mFzKQm/b5f1gPxdV1ml2CPKWyxchAGLeomGs8xyJhE2aXYGdMb7KC77yZ4LjlzGmy6FP3fV66DcN5i+tUrteOhxj6glUBnO3lZSdm1iVR/q5Xdt+lobeaIyHkGftik2gpNnX8OuLnnzXcvy3eiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456159; c=relaxed/simple;
	bh=mignoRYRLHHjX6SoWI2N00JC2HYzX1D05cl4aW7C2tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDMLRArMe+YP24KnAsOX9lKS+4Gv5BkBos2u6dlhH6Z01MiXFWhnhUuhbl5IdBqx8uOYevgcI42WGCJjnBEB//RiKQp4nB1lgkUfr5PjqvYhA4XHLd7GQmLajqWSJxs6aH6eV8TXc7BJpx3YFlFI6MVTWsBKxLjXCHB4yMA2/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZWaqqXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF36C4CEF7;
	Wed, 25 Mar 2026 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456159;
	bh=mignoRYRLHHjX6SoWI2N00JC2HYzX1D05cl4aW7C2tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZWaqqXRtM1Zpz9+5WAz2NTimIltca+VqNPf+FXtspLv6JsN2gzoUPPiGu1l8Hj5F
	 sYs1w/+geL4GAmvsxiyCujjqRhgdKTZtNe9Gp2cMWdvkAPACTV4bv/fcu7Vf/qgKcw
	 6KUkuebGc/jBeeCfVqRygmS7ov7tBZM9VpbJW/ZDBzG+QcV4wsrWtQERCme7VVpMBx
	 p+Y0hAWOXcYe80cTdYrEhKmhTBEPHxr0asNWWRYsQLkD9HeEs8N0sNGKP2N0VFceaa
	 FOWBEPdHgtkaur44vdZmUFhODtuhwTkz+x5LM3QTzdX+HaGKhIVg9tli/fSb6b8SqH
	 WfkQXhA+7gUew==
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
Subject: [PATCH net-next v5 05/14] net: macb: rework usrio refclk selection code
Date: Wed, 25 Mar 2026 16:28:09 +0000
Message-ID: <20260325-tarantula-bullring-6ac44b39dd52@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5438; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ycgYzkRjtwYgivLvrVnZHFBsUBSJrE0ZCfPhkRXsTQU=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeE3vRe5euGKW3gUfX+YzIv2XViwN1G29t++ldIPBm ngN5XyHjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEyk6gvD/1oRd8sNOavC1lSm PZytqNT1Vk48Nue2WvXLv/VXHj4T5GT4w/snN2qiCpfscbnLIS7belgOqgm0fG2Szby2xLx87iV TBgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271646-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: A89233294D0
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
index 35b7129d7c1ee..1bdbe66b05590 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1229,6 +1229,7 @@ struct macb_usrio_config {
 	u32 refclk;
 	u32 clken;
 	u32 hdfctlen;
+	bool refclk_default_external;
 };
 
 struct macb_config {
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 859d03502666a..a436521460683 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4576,12 +4576,8 @@ static const struct net_device_ops macb_netdev_ops = {
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
 
@@ -4614,9 +4610,6 @@ static void macb_configure_caps(struct macb *bp,
 		}
 	}
 
-	if (refclk_ext)
-		bp->caps |= MACB_CAPS_USRIO_HAS_REFCLK_SOURCE;
-
 	dev_dbg(&bp->pdev->dev, "Cadence caps 0x%08x\n", bp->caps);
 }
 
@@ -4897,8 +4890,36 @@ static int macb_init_dflt(struct platform_device *pdev)
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
@@ -5503,11 +5524,21 @@ static const struct macb_usrio_config at91_default_usrio = {
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
 
@@ -5622,7 +5653,7 @@ static const struct macb_config sama7g5_gem_config = {
 		MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
-	.usrio = &sama7g5_usrio,
+	.usrio = &sama7g5_gem_usrio,
 };
 
 static const struct macb_config sama7g5_emac_config = {
@@ -5632,7 +5663,7 @@ static const struct macb_config sama7g5_emac_config = {
 		MACB_CAPS_GEM_HAS_PTP |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
-	.usrio = &sama7g5_usrio,
+	.usrio = &sama7g5_emac_usrio,
 };
 
 static const struct macb_config versal_config = {
-- 
2.53.0


