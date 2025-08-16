Return-Path: <netdev+bounces-214332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D9DB29058
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A381C88805
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5E1215198;
	Sat, 16 Aug 2025 19:52:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40321F1315;
	Sat, 16 Aug 2025 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755373950; cv=none; b=noNjGNuLLpDrJFFbpMyq9t3EXpVB72XkForClCjd6NPk0kjigEEa5dEmUDuM4w5yTyf+u3Ars2T2XyYRZjFAUh5f1SEmm33ZbOfMKSSU9Fq9I1mtCTNZWwFKI1G9yPC1/qU7AI1EdOVlGwAXl8QqFnHJM6I8CLfmcVvDVYZyVQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755373950; c=relaxed/simple;
	bh=bP9WpsHLj6g9JJjYdrfuPKUkE5S8jbrm0BocZJsoU0o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cU+Lbkb5qfGFfecn8tSB21/xPwIfCsRdCgBQv7acJtIKlgT0kAPyHePORsVB4t2/vYrfd+DMQcxFpnwHmZOBhvsGJOSRatJq3JIUekL1BSPswCx8c06mlHBScYE+EAfLyfpCPA/JI7H/AyuwBMxdTuZvYRcDWoOn5o/e8noiX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMww-000000006yq-2sSL;
	Sat, 16 Aug 2025 19:52:22 +0000
Date: Sat, 16 Aug 2025 20:52:19 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH RFC net-next 07/23] net: dsa: lantiq_gswip: make DSA tag
 protocol model-specific
Message-ID: <aKDhcyFMKB_Cp0wF@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

While the older Lantiq / Intel which are currently supported all use
the DSA_TAG_GSWIP tagging protocol, newer MaxLinear GSW1xx modules use
another 8-byte tagging protocol. Move the tag protocol information to
struct gswip_hw_info to make it possible for new models to specify
a different tagging protocol.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 6 +++++-
 drivers/net/dsa/lantiq_gswip.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 355b8eb8ab9b..a66466bac1a8 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -660,7 +660,9 @@ static enum dsa_tag_protocol gswip_get_tag_protocol(struct dsa_switch *ds,
 						    int port,
 						    enum dsa_tag_protocol mp)
 {
-	return DSA_TAG_PROTO_GSWIP;
+	struct gswip_priv *priv = ds->priv;
+
+	return priv->hw_info->tag_protocol;
 }
 
 static int gswip_vlan_active_create(struct gswip_priv *priv,
@@ -2013,6 +2015,7 @@ static const struct gswip_hw_info gswip_xrx200 = {
 	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
+	.tag_protocol = DSA_TAG_PROTO_GSWIP,
 };
 
 static const struct gswip_hw_info gswip_xrx300 = {
@@ -2023,6 +2026,7 @@ static const struct gswip_hw_info gswip_xrx300 = {
 	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
+	.tag_protocol = DSA_TAG_PROTO_GSWIP,
 };
 
 static const struct of_device_id gswip_of_match[] = {
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index e1384b22bafa..c68848fb1c2d 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -229,6 +229,7 @@ struct gswip_hw_info {
 	unsigned int sgmii_ports;
 	const struct gswip_pce_microcode (*pce_microcode)[];
 	size_t pce_microcode_size;
+	enum dsa_tag_protocol tag_protocol;
 	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
 				 struct phylink_config *config);
 };
-- 
2.50.1

