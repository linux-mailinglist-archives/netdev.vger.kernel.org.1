Return-Path: <netdev+bounces-192354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C24ABF91B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0139E2747
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E724B1FFC5D;
	Wed, 21 May 2025 15:22:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06431E47A5
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840949; cv=none; b=sCv82qvjjmM1kSU0wZDWbIlTHRZHNe7NKL3ETtRFSytikr3lSk0tntjm2HYpr5qb5DJQrA3Gxws51p135/OJDq4u1Sw5mmUlmJWrg2ZcKPP0WV+xY8lh7bpXXbl7omssKboRz+E3xWCaUhrp9AR0jKQJnD75zZs7rfOX4jPlptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840949; c=relaxed/simple;
	bh=US6Qn/YPFfEQVJh/yquwxVsdo6yHequvshtAvfNQRnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SdutMK20xVlWXP+WavxAiZ/DTNdeIC5k95GVAb7G+AUHvVx/GykD99fgJnUcFz45ssgLMSd+afJRnrLsjaOIZBy0uzyz52IU2fyhmi3GeMN9MF8os2mSVKQYkMHoTYiQOiEKRgTtWFYE7xnGxcTFtLDJqHQxAttz2x/E3brlpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b2Zsk0B0Bz3fC;
	Wed, 21 May 2025 17:22:18 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b2Zsh2wFGz8KK;
	Wed, 21 May 2025 17:22:16 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Wed, 21 May 2025 17:21:59 +0200
Subject: [PATCH net] net: stmmac: platform: guarantee uniqueness of bus_id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-stmmac-mdio-bus_id-v1-1-918a3c11bf2c@cherry.de>
X-B4-Tracking: v=1; b=H4sIAJbvLWgC/x3MQQqEMAxA0atI1gZsO1L0KiKDtlGzaJWmI4J49
 yku3+L/G4QSk0Bf3ZDoZOE9Fqi6ArdNcSVkXwy60W3TaoWSQ5gcBs87zj/5skejzGw/ztrOGCj
 hkWjh650OECnD+Dx/ttnzIGkAAAA=
X-Change-ID: 20250521-stmmac-mdio-bus_id-313b74c77933
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

bus_id is currently derived from the ethernetX alias. If one is missing
for the device, 0 is used. If ethernet0 points to another stmmac device
or if there are 2+ stmmac devices without an ethernet alias, then bus_id
will be 0 for all of those.

This is an issue because the bus_id is used to generate the mdio bus id
(new_bus->id in drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
stmmac_mdio_register) and this needs to be unique.

This allows to avoid needing to define ethernet aliases for devices with
multiple stmmac controllers (such as the Rockchip RK3588) for multiple
stmmac devices to probe properly.

Obviously, the bus_id isn't guaranteed to be stable across reboots if no
alias is set for the device but that is easily fixed by simply adding an
alias if this is desired.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Unsure if I should cc stable since people who encountered that issue for
sure had to add an ethernet alias to make things work with their DT so
shouldn't be too much of an actual issue?
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index c73eff6a56b87a3783c91b2ffbf5807a27df303f..15205a47cafc276442c3759a36d115d8da1fe51d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -430,6 +430,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	struct device_node *np = pdev->dev.of_node;
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_dma_cfg *dma_cfg;
+	static int bus_id = -ENODEV;
 	int phy_mode;
 	void *ret;
 	int rc;
@@ -465,8 +466,14 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	of_property_read_u32(np, "max-speed", &plat->max_speed);
 
 	plat->bus_id = of_alias_get_id(np, "ethernet");
-	if (plat->bus_id < 0)
-		plat->bus_id = 0;
+	if (plat->bus_id < 0) {
+		if (bus_id < 0)
+			bus_id = of_alias_get_highest_id("ethernet");
+		/* No ethernet alias found, init at -1 so first bus_id is 0 */
+		if (bus_id < 0)
+			bus_id = -1;
+		plat->bus_id = ++bus_id;
+	}
 
 	/* Default to phy auto-detection */
 	plat->phy_addr = -1;

---
base-commit: 4a95bc121ccdaee04c4d72f84dbfa6b880a514b6
change-id: 20250521-stmmac-mdio-bus_id-313b74c77933

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


