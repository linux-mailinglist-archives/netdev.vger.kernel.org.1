Return-Path: <netdev+bounces-229805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDD2BE0F10
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B2434FD41A
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055130C34D;
	Wed, 15 Oct 2025 22:32:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC230C341;
	Wed, 15 Oct 2025 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567534; cv=none; b=kqGHU92EInosh5yo+PzLJrC2P5r1fS8+UBzBofoA0sDV78jOV/ZIwJ7O9zuZJtCAOlHaOfvwdlMGxgeBn1GOyyBJIzlth3KN8DuGfIIDcLkihEa2VtnWMbPkuye+3O3PYxSunvwSk2onBtNtM7F/FMlTqN+hVArPl0qprKQiDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567534; c=relaxed/simple;
	bh=i4MtLydCOkah6LEWx1Hc9n1iNqvBqkn1EqVksiJBB5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc5yr+3rWUIsulpNdkSCxyzrizv/W4QhAr5cBqMEyRVd+5mHHSdX1OsOoq3OWba9UlhyOsay8Ldu15htgliBoyG2uj+ayybLLqOOBPXZpPRaQt6qJDLa6ejfeLGSMfMoj9oh2LX7F2M/K6Z/wbzz1oeEe5c9MtrYfSC7LnzMiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A2S-000000006UK-3f4Q;
	Wed, 15 Oct 2025 22:32:08 +0000
Date: Wed, 15 Oct 2025 23:32:05 +0100
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
Subject: [PATCH net-next 01/11] net: dsa: lantiq_gswip: support bridge FDB
 entries on the CPU port
Message-ID: <ed9d847c0356f0fec81422bdad9ebdcc6a59da79.1760566491.git.daniel@makrotopia.org>
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

Currently, the driver takes the bridge from dsa_port_bridge_dev_get(),
which only works for user ports. This is why it has to ignore FDB
entries installed on the CPU port.

Commit c26933639b54 ("net: dsa: request drivers to perform FDB
isolation") introduced the possibility of getting the originating bridge
from the passed dsa_db argument, so let's do that instead. This way, we
can act on the local FDB entries coming from the bridge.

Note that we do not expect FDB events for the DSA_DB_PORT database,
because this driver doesn't fulfill the dsa_switch_supports_uc_filtering()
requirements. So we can just return -EOPNOTSUPP and expect it will never
be triggered.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 2169c0814a48..91755a5972fa 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -1140,9 +1140,9 @@ static void gswip_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 }
 
 static int gswip_port_fdb(struct dsa_switch *ds, int port,
-			  const unsigned char *addr, u16 vid, bool add)
+			  struct net_device *bridge, const unsigned char *addr,
+			  u16 vid, bool add)
 {
-	struct net_device *bridge = dsa_port_bridge_dev_get(dsa_to_port(ds, port));
 	struct gswip_priv *priv = ds->priv;
 	struct gswip_pce_table_entry mac_bridge = {0,};
 	unsigned int max_ports = priv->hw_info->max_ports;
@@ -1150,10 +1150,6 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
 	int i;
 	int err;
 
-	/* Operation not supported on the CPU port, don't throw errors */
-	if (!bridge)
-		return 0;
-
 	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
 		if (priv->vlans[i].bridge == bridge) {
 			fid = priv->vlans[i].fid;
@@ -1188,14 +1184,20 @@ static int gswip_port_fdb_add(struct dsa_switch *ds, int port,
 			      const unsigned char *addr, u16 vid,
 			      struct dsa_db db)
 {
-	return gswip_port_fdb(ds, port, addr, vid, true);
+	if (db.type != DSA_DB_BRIDGE)
+		return -EOPNOTSUPP;
+
+	return gswip_port_fdb(ds, port, db.bridge.dev, addr, vid, true);
 }
 
 static int gswip_port_fdb_del(struct dsa_switch *ds, int port,
 			      const unsigned char *addr, u16 vid,
 			      struct dsa_db db)
 {
-	return gswip_port_fdb(ds, port, addr, vid, false);
+	if (db.type != DSA_DB_BRIDGE)
+		return -EOPNOTSUPP;
+
+	return gswip_port_fdb(ds, port, db.bridge.dev, addr, vid, false);
 }
 
 static int gswip_port_fdb_dump(struct dsa_switch *ds, int port,
-- 
2.51.0

