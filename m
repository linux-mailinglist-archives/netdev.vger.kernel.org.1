Return-Path: <netdev+bounces-273105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE2SEtk9ymnD6gUAu9opvQ
	(envelope-from <netdev+bounces-273105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:09:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4619357DD6
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F168B30809B0
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E63B2FFB;
	Mon, 30 Mar 2026 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHXjhEmZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92251399011;
	Mon, 30 Mar 2026 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861361; cv=none; b=KjEwpHnEQEUljA0xkVFrFjXMvVpXojITGMy/491L/ewr9/1Ox/jweadif42+Xr//zYtPoME+Vfdp/JiShPlmyXj9qdUwKLfiNU5hkf5mP7V1F4EQm5ZBKP+jIL5wkNbtt2qlg9Dx3QwJxIHX7eWStMyeVW8gUt6BjQfT9lv7c6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861361; c=relaxed/simple;
	bh=qRDiLQ7/Xx7OWinJo708eydLzcr8WmKcb0zRtIsdSO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEgMZLE3t4o6o7Lbrrtbqmm2NSqnNEJrY2ZqVbyep4suWuxRiUuUeIdBicE+S6QgIymEBWC0ZaZolNbbOoF1KN2gUpRxzzhV9jy9ushGqp4A3CzSJEYTJ3bhDpebxiiVzFycD552qzQFfKLzCJTSX42OHJAYDrLCVbU4teC/67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHXjhEmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7CBC2BCF5;
	Mon, 30 Mar 2026 09:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774861361;
	bh=qRDiLQ7/Xx7OWinJo708eydLzcr8WmKcb0zRtIsdSO8=;
	h=From:To:Cc:Subject:Date:From;
	b=hHXjhEmZZxDEryQivP7+OwcpVMgA5oBn8cpG9Bk9N/iLWFqC8zyStSkdTZlsQ2vCn
	 IxAj6WpNay1JuUaYnqoFTx0Y1YmO7Ua83XblC+OekvpKYGNJ1OAWLXJMeOeZu4+Tic
	 4xZcS4VgIttR4bxu6P0NboTqUUSc1QDXis720VsDg/XMJWm+ha69coHzaxhvmpuJjl
	 BzVJgMZtVvq2EcsJyokY9ejZ5CHZniuEqaZEeYII/D9v5ERHFw8GrSSB23jc+7fQx4
	 t/qFv0qPFG2Yu+V0ybZoYwTQxZLVy4JkDZolzC2cepGKGLa4Z9GPaJJU58fMc4hUti
	 LOGv6tSOyhEaQ==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	kernel test robot <lkp@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH net-next v1] net: macb: fix use of at91_default_usrio without CONFIG_OF
Date: Mon, 30 Mar 2026 10:02:00 +0100
Message-ID: <20260330-overture-cactus-c8eb7b9cbecc@spud>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3605; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=A1BubFgGNTU8Lrl5NTMqEeZD7ZkkVzsO+2Mw4LraCwo=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJmnbLheGWkVLNMQ2R+3+ewm89UXxPTfW7DuWbrdcmX3F 57IqzrLOkpZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRU7sZ/udrS7FEZQZeS9Hv PHfuk+fWm+ez5/xsuLnms3Ze3O4NTD8Z/sf1HliytJTxU16fzcXye71ax980ddhvuTbzSmrY3LX 22jwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273105-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4619357DD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

If CONFIG_OF is not enabled, at91_default_usrio is used undeclared in
gem_default_config. Rather than move the struct around, take the
opportunity to rename gem_default_config, as the only compatible it is
ever used for is "cdns,macb" - not "cdns,gem" at all! With that done,
remove the use of default_gem_config as a fallback in probe, as every
device has a specific set of match data.

It pains me a little to leave at91_default_usrio in match data used by
"cdns,macb", but this is probably required to avoid regressing anyone.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603280028.wQjUrIvv-lkp@intel.com/
Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
Closes: https://lore.kernel.org/all/06a701dcc014$86def5b0$949ce110$@trustnetic.com/
Fixes: a17871778ee28 ("net: macb: rename macb_default_usrio to at91_default_usrio as not all platforms have mii mode control in usrio")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
lkp also reported this over the weekend, but against the dev copy in my
tree. I had thought that CONFIG_OF was standard off on x86, but I guess
it isn't, given lkp didn't catch it until randconfigs.

CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: netdev@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
---
 drivers/net/ethernet/cadence/macb_main.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 12e2b2f4aaf88..4f70e4fcf4606 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5716,9 +5716,18 @@ static const struct macb_config pic64hpsc_config = {
 	.jumbo_max_len = 16383,
 };
 
+static const struct macb_config macb_macb_config = {
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
+		MACB_CAPS_JUMBO |
+		MACB_CAPS_GEM_HAS_PTP,
+	.dma_burst_length = 16,
+	.usrio = &at91_default_usrio,
+	.jumbo_max_len = 10240,
+};
+
 static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "cdns,at91sam9260-macb", .data = &at91sam9260_config },
-	{ .compatible = "cdns,macb" },
+	{ .compatible = "cdns,macb", .data = &macb_macb_config},
 	{ .compatible = "cdns,np4-macb", .data = &np4_config },
 	{ .compatible = "cdns,pc302-gem", .data = &pc302gem_config },
 	{ .compatible = "cdns,gem", .data = &pc302gem_config },
@@ -5747,15 +5756,6 @@ static const struct of_device_id macb_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, macb_dt_ids);
 #endif /* CONFIG_OF */
 
-static const struct macb_config default_gem_config = {
-	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
-		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
-	.dma_burst_length = 16,
-	.usrio = &at91_default_usrio,
-	.jumbo_max_len = 10240,
-};
-
 static int macb_probe(struct platform_device *pdev)
 {
 	struct clk *pclk, *hclk = NULL, *tx_clk = NULL, *rx_clk = NULL;
@@ -5778,7 +5778,7 @@ static int macb_probe(struct platform_device *pdev)
 
 	macb_config = of_device_get_match_data(&pdev->dev);
 	if (!macb_config)
-		macb_config = &default_gem_config;
+		return -EINVAL;
 
 	err = macb_clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk, &tsu_clk,
 			    macb_config);
-- 
2.53.0


