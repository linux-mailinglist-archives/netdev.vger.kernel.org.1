Return-Path: <netdev+bounces-175196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D69A6443A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF5A1893AFF
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB3321ADB2;
	Mon, 17 Mar 2025 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u49L/rRV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2021A444;
	Mon, 17 Mar 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197724; cv=none; b=t3Rw+ln7JYT32rzGbyruXbSPqbnb+tQhRmTe1/LmTuGE19fGYe9NnqC/iyw0i8utXgpUROkZ4xyHB57Qac4DFCYmLuLwcDsVUL+oFF/3rYerK2ZXMxdVLlY4OfqMTQ+Uwoz5hH449H8GNBEiiLm0bM98cS3KpAamlwNK2IhZyjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197724; c=relaxed/simple;
	bh=rdEdLgOwIlSAaD557Xc1drJHlvmYw0czoLvq4tWvqdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UJN6IXUuqyb4rfB8QnnhmrFm1N6qo98oHTPY4t6krgA6Jdsy3fvNglAH0GYRnab+aPA6OW7OxdXKMizwJkunJgL/2p3Hi5XLP+HN/vKlEUQfkFzV9mjp6y49VRUPu26LoIjwC0LQLuZwcHqj8lAwCi0zyR4IJMn7H8ZupLlx4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u49L/rRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30220C4CEE3;
	Mon, 17 Mar 2025 07:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742197723;
	bh=rdEdLgOwIlSAaD557Xc1drJHlvmYw0czoLvq4tWvqdc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=u49L/rRVP8r/K8dg6FPXj+Mqs5fvDJ/TZhPNZQVSXUR7Ojk49bnxd5RhYGVfzTLeR
	 SsTlVaHkb9ToWl6z/oM4idb1ZLYTd7gBZJ5jFxIfEv4V47nnjNAkM+y7GcI05Meyek
	 ZDqbUfjlYFFG4EHmHNxGjysW4NWFs0V9Lug2QJXypXvfR7vl6+aAt9us8icZJLN3r0
	 cjf0XmT5U678fCsdytr9DhcmwYuyPinI5GNkO+0jqv4BUHnSPLLzQb7SXbZBi5ndDH
	 f4hOhhcZ/aMmvt3uhrJm864gvOmuC7NgLZUVLwG8YQ1UeuchmmZB74bgRznmG3ztKM
	 LlsoKW0cmlc3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F413C35FF3;
	Mon, 17 Mar 2025 07:48:43 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 17 Mar 2025 08:48:34 +0100
Subject: [PATCH v2] net: phy: dp83822: fix transmit amplitude if
 CONFIG_OF_MDIO not defined
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-dp83822-fix-transceiver-mdio-v2-1-fb09454099a4@liebherr.com>
X-B4-Tracking: v=1; b=H4sIANHT12cC/33NTQrCMBCG4avIrB1JUvrnyntIF2kytQO2KZMSl
 NK7G4trl+/H8MwGkYQpwvW0gVDiyGHOYc4ncKOdH4Tsc4NRplSFqtEvTdEYgwO/cBU7R0ecSHD
 yHNCSqQfyjaraFjKxCOW7g793uUeOa5D38S3p7/qDtfkPJ40a675qtSpcaXt1ezL1I4lcXJig2
 /f9A/ihkyvLAAAA
X-Change-ID: 20250307-dp83822-fix-transceiver-mdio-ae27fed80699
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742197722; l=1728;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=FhqMIOb8gc2Jav0LaFqqWUr8RHshzd6zjF1Tsp9SwHE=;
 b=ifMh5cTdVqfJsVw55g9MZH0HPHvMRRp5+iHIXIUZ/jcdHC6dyZVBGvJ9B5a5X41RZd4NGGkZe
 AzYUzbWKdTCC6/280VSUMVon22/UGMuBCGlB7wudQFvdpHIck4lur7p
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

When CONFIG_OF_MDIO is not defined the index for selecting the transmit
amplitude voltage for 100BASE-TX is set to 0, but it should be -1, if there
is no need to modify the transmit amplitude voltage. Move initialization of
the index from dp83822_of_init to dp8382x_probe.

Fixes: 4f3735e82d8a ("net: phy: dp83822: Add support for changing the transmit amplitude voltage")
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v2:
- Drop tx_amplitude_100base_tx_index_modify
- Init tx_amplitude_100base_tx_index in dp8382x_probe
- Link to v1: https://lore.kernel.org/r/20250312-dp83822-fix-transceiver-mdio-v1-1-7b69103c5ab0@liebherr.com
---
 drivers/net/phy/dp83822.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 3662f3905d5ade8ad933608fcaeabb714a588418..14f36154963841dff98be5af4dfbd2760325c13d 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -833,7 +833,6 @@ static int dp83822_of_init(struct phy_device *phydev)
 		dp83822->set_gpio2_clk_out = true;
 	}
 
-	dp83822->tx_amplitude_100base_tx_index = -1;
 	ret = phy_get_tx_amplitude_gain(phydev, dev,
 					ETHTOOL_LINK_MODE_100baseT_Full_BIT,
 					&val);
@@ -931,6 +930,7 @@ static int dp8382x_probe(struct phy_device *phydev)
 	if (!dp83822)
 		return -ENOMEM;
 
+	dp83822->tx_amplitude_100base_tx_index = -1;
 	phydev->priv = dp83822;
 
 	return 0;

---
base-commit: bfc6c67ec2d64d0ca4e5cc3e1ac84298a10b8d62
change-id: 20250307-dp83822-fix-transceiver-mdio-ae27fed80699

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



