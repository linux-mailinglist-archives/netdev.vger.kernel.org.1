Return-Path: <netdev+bounces-271642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MISHMskPxGl8vwQAu9opvQ
	(envelope-from <netdev+bounces-271642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:39:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5563292F4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25893315568B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE0C3F65F5;
	Wed, 25 Mar 2026 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhjsYCkm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C127313545;
	Wed, 25 Mar 2026 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456136; cv=none; b=HjL4Xr4tCJZhxEhXzhKN0rWAGwmsUdJYb8jx6RHCUz1BpJY/iX8gDkBw43zYMou99RBS/9+off0AdQ+w72AUSvy5zW2qKNKt9rDW5I24aXiw3kCu1oKZ9k7UBywx+hY4GasdTsgh6eezhBQ81Tue3nZ5fgYJ0wCpHBjNaCCJcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456136; c=relaxed/simple;
	bh=/GOCQoMgSCnMdAsfootrNAXNB36Qw+5kApOdsouWTrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjAQ69HhZo6omhVRRRfrZOHNfglNfCkER32CjQguIkyedHVzieMIbfZG6wyOuTKqnkvq6zlnNiD9m86gRAkKDAoufamqSIrjfbm5O1cTb6hDmeKEo22VWELr6smTqAaK9xJcOl2zxReXM+thCJDozKBerdP2/6al8Pi19I7YNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhjsYCkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B359EC19423;
	Wed, 25 Mar 2026 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456136;
	bh=/GOCQoMgSCnMdAsfootrNAXNB36Qw+5kApOdsouWTrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhjsYCkmXPLXlS5hIkSmVNAP9VL07zgHD3Zvx6um6gLb2T2EbGKWBzhhpiCdDkwVH
	 CNs2Ur2EP9voDypZrBSYCRQ6CFQQAdpJvPSVxamUi/yL5mcEI0BFoHdmdRXwdSB+cs
	 KuZu840UFgZhQqrjUl/EKSqeUYRVNYCiyg7LdYmIDmeEqhA/WJ5xlx8l/v62l73tad
	 Hka8/Ac9LcvCV7kEKxQ8H02tV1euEgPYX451LKp9Uu2syurqtOLP0OVoOuiLvk3DjA
	 56mhXsAm+NYKqfnYtDZnOCJDa72GqgVIOaQOYQHcbAnqIcrQHxJRcuH1+CbQHITQ7p
	 RG+WSwXdWHw8A==
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
Subject: [PATCH net-next v5 01/14] Revert "net: macb: Clean up the .usrio settings in macb_config instances"
Date: Wed, 25 Mar 2026 16:28:05 +0000
Message-ID: <20260325-rundown-unrushed-dd82c9f5c56c@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5036; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=wNAu33LueieiL9BYBWizySOKUamk9hJkFHlIq4AwGik=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeE0M1P3X3Lq4yPVBftIztQarf4oTjyQv+SL0ovecz eJJfG+dO0pZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjARPmVGhuvZOTemRWg/+3KW y/zZ35tNDjWPLmVvfDbhlaBPiezMpwmMDB2zt82KDGoImPDn8fx3/Kn9ixYdb9Z+EzRNpX1HgYP GRC4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271642-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B5563292F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

Commit 0ae998c4efd69 ("net: macb: Clean up the .usrio settings in
macb_config instances") was a misguided attempt to clean up the driver
that actually just propagated problematic code. The default for usrio is
actually no usrio, and already there are issues with people using the
problematically named "macb_default_usrio" on platforms where the usrio
does not have this so-called default behaviour. usrio is platform
specific and using the default at91 usrio settings should be opt-in
only. Revert the "cleanup" patch.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1cb49252abf5a..a48160da6e672 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5513,31 +5513,37 @@ static const struct macb_config fu540_c000_config = {
 	.clk_init = fu540_c000_clk_init,
 	.init = fu540_c000_init,
 	.jumbo_max_len = 10240,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config at91sam9260_config = {
 	.caps = MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d3macb_config = {
 	.caps = MACB_CAPS_SG_DISABLED |
 		MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config pc302gem_config = {
 	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE,
 	.dma_burst_length = 16,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d2_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
 	.dma_burst_length = 16,
 	.jumbo_max_len = 10240,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d29_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d3_config = {
@@ -5545,21 +5551,25 @@ static const struct macb_config sama5d3_config = {
 		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_JUMBO,
 	.dma_burst_length = 16,
 	.jumbo_max_len = 10240,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config sama5d4_config = {
 	.caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
 	.dma_burst_length = 4,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config emac_config = {
 	.caps = MACB_CAPS_NEEDS_RSTONUBR | MACB_CAPS_MACB_IS_EMAC,
 	.clk_init = at91ether_clk_init,
 	.init = at91ether_init,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config np4_config = {
 	.caps = MACB_CAPS_USRIO_DISABLED,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config zynqmp_config = {
@@ -5569,12 +5579,14 @@ static const struct macb_config zynqmp_config = {
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
 	.jumbo_max_len = 10240,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config zynq_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF |
 		MACB_CAPS_NEEDS_RSTONUBR,
 	.dma_burst_length = 16,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config mpfs_config = {
@@ -5583,6 +5595,7 @@ static const struct macb_config mpfs_config = {
 		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
+	.usrio = &macb_default_usrio,
 	.max_tx_length = 4040, /* Cadence Erratum 1686 */
 	.jumbo_max_len = 4040,
 };
@@ -5611,6 +5624,7 @@ static const struct macb_config versal_config = {
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
 	.jumbo_max_len = 10240,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config eyeq5_config = {
@@ -5620,6 +5634,7 @@ static const struct macb_config eyeq5_config = {
 	.dma_burst_length = 16,
 	.init = eyeq5_init,
 	.jumbo_max_len = 10240,
+	.usrio = &macb_default_usrio,
 };
 
 static const struct macb_config raspberrypi_rp1_config = {
@@ -5628,6 +5643,7 @@ static const struct macb_config raspberrypi_rp1_config = {
 		MACB_CAPS_GEM_HAS_PTP |
 		MACB_CAPS_EEE,
 	.dma_burst_length = 16,
+	.usrio = &macb_default_usrio,
 	.jumbo_max_len = 10240,
 };
 
@@ -5675,6 +5691,7 @@ static const struct macb_config default_gem_config = {
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP,
 	.dma_burst_length = 16,
+	.usrio = &macb_default_usrio,
 	.jumbo_max_len = 10240,
 };
 
@@ -5761,7 +5778,7 @@ static int macb_probe(struct platform_device *pdev)
 	bp->wol = 0;
 	device_set_wakeup_capable(&pdev->dev, 1);
 
-	bp->usrio = macb_config->usrio ? : &macb_default_usrio;
+	bp->usrio = macb_config->usrio;
 
 	/* By default we set to partial store and forward mode for zynqmp.
 	 * Disable if not set in devicetree.
-- 
2.53.0


