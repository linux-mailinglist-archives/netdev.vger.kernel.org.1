Return-Path: <netdev+bounces-229812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DCCBE0F1F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C2A540E5C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C48308F0C;
	Wed, 15 Oct 2025 22:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9EC2727F5;
	Wed, 15 Oct 2025 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567621; cv=none; b=A5pkIfibX8I0Png/oPr1J9rJlWFLjGOZlD0i0xXozwOisV32LyUO5YnJ3fZf130IC3pR5yYpt3+VU69jP50RCqGQ/LBMlTKt/5R/vy203853eKfawToQsGiPe5LnMtWsHQmGVY+Jl9z3UhWBym9Kl9+7Qf58pxnv6P8YmNFPEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567621; c=relaxed/simple;
	bh=Tv2jDXVJeFkxrlKV4Om3KHslkHp7oFfNMbd5MAfa0gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9MTQV4xrsVtTrklciHaPywabG6+mRw5OMza6BmdXT/OX/2AFbIrso2+KLmD5Pzjjhsbp0kzqrneYNdnCL8I49Lgh+a820RvAmYG97v2XoaXpuXagrl5qiMkEGJT3tiPEelwz2CeEQtQ5MeO4OTgGYmcbgj+kC/uubz2PJj26nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A3t-000000006Wp-0Xq6;
	Wed, 15 Oct 2025 22:33:37 +0000
Date: Wed, 15 Oct 2025 23:33:33 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
Subject: [PATCH net-next 08/11] net: dsa: lantiq_gswip: remove vlan_aware and
 pvid arguments from gswip_vlan_remove()
Message-ID: <c63f89ca19269ef6c8bf00a62cacc739164b4441.1760566491.git.daniel@makrotopia.org>
References: <cover.1760566491.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760566491.git.daniel@makrotopia.org>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

"bool pvid" is unused since commit "net: dsa: lantiq_gswip: remove
legacy configure_vlan_while_not_filtering option".

"bool vlan_aware" shouldn't have a role in finding the bridge VLAN.
It should be identified by VID regardless of VLAN-aware or VLAN-unaware.
The driver sets up VID 0 for the VLAN-unaware PVID.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 26e963840f3b..d9a7a004f9eb 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -857,7 +857,7 @@ static int gswip_vlan_add(struct gswip_priv *priv, struct net_device *bridge,
 
 static int gswip_vlan_remove(struct gswip_priv *priv,
 			     struct net_device *bridge, int port,
-			     u16 vid, bool pvid, bool vlan_aware)
+			     u16 vid)
 {
 	struct gswip_pce_table_entry vlan_mapping = {0,};
 	unsigned int max_ports = priv->hw_info->max_ports;
@@ -868,7 +868,7 @@ static int gswip_vlan_remove(struct gswip_priv *priv,
 	/* Check if there is already a page for this bridge */
 	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
 		if (priv->vlans[i].bridge == bridge &&
-		    (!vlan_aware || priv->vlans[i].vid == vid)) {
+		    priv->vlans[i].vid == vid) {
 			idx = i;
 			break;
 		}
@@ -941,7 +941,7 @@ static void gswip_port_bridge_leave(struct dsa_switch *ds, int port,
 	 * the VLAN-unaware PVID created for this bridge.
 	 */
 	gswip_add_single_port_br(priv, port, true);
-	gswip_vlan_remove(priv, br, port, GSWIP_VLAN_UNAWARE_PVID, true, false);
+	gswip_vlan_remove(priv, br, port, GSWIP_VLAN_UNAWARE_PVID);
 }
 
 static int gswip_port_vlan_prepare(struct dsa_switch *ds, int port,
@@ -1024,7 +1024,6 @@ static int gswip_port_vlan_del(struct dsa_switch *ds, int port,
 {
 	struct net_device *bridge = dsa_port_bridge_dev_get(dsa_to_port(ds, port));
 	struct gswip_priv *priv = ds->priv;
-	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
 
 	if (vlan->vid == GSWIP_VLAN_UNAWARE_PVID)
 		return 0;
@@ -1037,7 +1036,7 @@ static int gswip_port_vlan_del(struct dsa_switch *ds, int port,
 	if (dsa_is_cpu_port(ds, port))
 		return 0;
 
-	return gswip_vlan_remove(priv, bridge, port, vlan->vid, pvid, true);
+	return gswip_vlan_remove(priv, bridge, port, vlan->vid);
 }
 
 static void gswip_port_fast_age(struct dsa_switch *ds, int port)
-- 
2.51.0

