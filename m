Return-Path: <netdev+bounces-215100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0399DB2D1AF
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58F816AB50
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F92773F0;
	Wed, 20 Aug 2025 01:55:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA12773D0;
	Wed, 20 Aug 2025 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755654936; cv=none; b=E2gTZ0IDc1QuEjzIY2+ERRhR4r2U8ZCwcQd9uN3frPAKtSot8994VZhe+42j8CSGQVqbbM2jeV4XvyYimEz8/Tvo3rGrSjy9seoXcCfZYixSR6REWS3Mg7efP7r5WOlgURwVTaPTTlm9LIZJjfBZO2IJqhVLqLQEYKNk4ztYNtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755654936; c=relaxed/simple;
	bh=Z5e406gAp4jZgmxAv49+4a5DsR0SX6/O3rUOlDZVJ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjNLTbMkUO7qPQzCYxIwF+neLfDgRXefAfUXlyQoNQJzgHx17Fl+94c3jS0Hv4kErdmVLc7g91xzgPddQP0gL9Cr9C2w6xnwM4dhqG0GrBVY/N9NinaSh3RIwyxkwEKIy7hmje88oZSG194tC8Iy6S6iGUdmPZPIHRU6aGT/tw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoY30-000000006E8-2RDJ;
	Wed, 20 Aug 2025 01:55:30 +0000
Date: Wed, 20 Aug 2025 02:55:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
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
Subject: [PATCH net-next v3 6/8] net: dsa: lantiq_gswip: make DSA tag
 protocol model-specific
Message-ID: <cc6a679ccf0e6dabf6c6ff51d4369b564db72fea.1755654392.git.daniel@makrotopia.org>
References: <cover.1755654392.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755654392.git.daniel@makrotopia.org>

While the older Lantiq / Intel which are currently supported all use
the DSA_TAG_GSWIP tagging protocol, newer MaxLinear GSW1xx modules use
another 8-byte tagging protocol. Move the tag protocol information to
struct gswip_hw_info to make it possible for new models to specify
a different tagging protocol.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v3: no changes
v2: no changes

 drivers/net/dsa/lantiq_gswip.c | 6 +++++-
 drivers/net/dsa/lantiq_gswip.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 1ce9ef425082..f8a43c351649 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -659,7 +659,9 @@ static enum dsa_tag_protocol gswip_get_tag_protocol(struct dsa_switch *ds,
 						    int port,
 						    enum dsa_tag_protocol mp)
 {
-	return DSA_TAG_PROTO_GSWIP;
+	struct gswip_priv *priv = ds->priv;
+
+	return priv->hw_info->tag_protocol;
 }
 
 static int gswip_vlan_active_create(struct gswip_priv *priv,
@@ -2003,6 +2005,7 @@ static const struct gswip_hw_info gswip_xrx200 = {
 	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
+	.tag_protocol = DSA_TAG_PROTO_GSWIP,
 };
 
 static const struct gswip_hw_info gswip_xrx300 = {
@@ -2012,6 +2015,7 @@ static const struct gswip_hw_info gswip_xrx300 = {
 	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
+	.tag_protocol = DSA_TAG_PROTO_GSWIP,
 };
 
 static const struct of_device_id gswip_of_match[] = {
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 3c60f14673a7..0b7b6db4eab9 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -226,6 +226,7 @@ struct gswip_hw_info {
 	unsigned int mii_ports;
 	const struct gswip_pce_microcode (*pce_microcode)[];
 	size_t pce_microcode_size;
+	enum dsa_tag_protocol tag_protocol;
 	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
 				 struct phylink_config *config);
 };
-- 
2.50.1

