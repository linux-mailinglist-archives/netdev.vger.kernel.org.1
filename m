Return-Path: <netdev+bounces-229809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D9BE0F13
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6E01A226F0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A377308F39;
	Wed, 15 Oct 2025 22:32:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1349306D52;
	Wed, 15 Oct 2025 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567578; cv=none; b=KMb+/NoVjLTDxVb1So0y0snqyNWe+w4ExNAgpqtBgig2VFeJkE+7nRq7pQUSpglPRlSmZ3Ns3Fz7EDrdq0LnPV6xLg84zlPBmTklcMGO/ROKJVa8V0vsBMIkadR24P7iVozYz4x1DUwzCmhzQuVEEIJX03Opi440YqHMbRBk3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567578; c=relaxed/simple;
	bh=Y1e50Af7RMYLivtC3BAqV/29GtuZ0+gHs/jlHeTLEYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZ14728LK1RAg1ofF8yUHgvnsOVRh6TfC6ilbrl8Mf9r52zD79txf5tpU3ikg4+1ZqFx77AanXnf0hYjUObZqKdywKEulzBsV3tS0VHTKvgei/yBP3f+dPAvP+vXFjoRXBM3AiCkddbxculhvgrreGElIUjrOzrmCI/3gUxlfCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A3B-000000006Vd-1JRV;
	Wed, 15 Oct 2025 22:32:53 +0000
Date: Wed, 15 Oct 2025 23:32:50 +0100
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
Subject: [PATCH net-next 05/11] net: dsa: lantiq_gswip: remove legacy
 configure_vlan_while_not_filtering option
Message-ID: <47dab8a8b69ebb92624b9795b723114475d3fe4e.1760566491.git.daniel@makrotopia.org>
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

This driver doesn't support dynamic VLAN filtering changes, for simplicity.
It expects that on a port, either gswip_vlan_add_unaware() or
gswip_vlan_add_aware() is called, but not both.

When !br_vlan_enabled(), the configure_vlan_while_not_filtering = false
option is exactly what will prevent calls to gswip_port_vlan_add() from
being issued by DSA.

In fact, at the time these features were submitted:
https://patchwork.ozlabs.org/project/netdev/patch/20190501204506.21579-3-hauke@hauke-m.de/
"configure_vlan_while_not_filtering = false" did not even have a name,
it was implicit behaviour. It only became legacy in commit 54a0ed0df496
("net: dsa: provide an option for drivers to always receive bridge
VLANs").

Section "Bridge VLAN filtering" of Documentation/networking/switchdev.rst
describes the exact set of rules. Notably, the PVID of the port must
follow the VLAN awareness state of the bridge port. A VLAN-unaware
bridge port should not respond to the addition of a bridge VLAN with the
PVID flag. In fact, the pvid_change() test in
tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh tests
exactly this.

The lantiq_gswip driver indeed does not respond to the addition of PVID
VLANs while VLAN-unaware in the way described above, but only because of
configure_vlan_while_not_filtering. Our purpose here is to get rid of
configure_vlan_while_not_filtering, so we must add more complex logic
which follows the VLAN awareness state and walks through the Active VLAN
table entries, to find the index of the PVID register that should be
committed to hardware on each port.

As a side-effect of now having a proper implementation to assign the
PVID all the "VLAN upper: ..." tests of the local_termination.sh self-
tests which would previously all FAIL now all PASS (or XFAIL, but
that's ok).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 49 +++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 6cbcb54a5ed0..30cff623bec0 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -547,6 +547,45 @@ static int gswip_pce_load_microcode(struct gswip_priv *priv)
 	return 0;
 }
 
+static void gswip_port_commit_pvid(struct gswip_priv *priv, int port)
+{
+	struct dsa_port *dp = dsa_to_port(priv->ds, port);
+	struct net_device *br = dsa_port_bridge_dev_get(dp);
+	int idx;
+
+	if (!dsa_port_is_user(dp))
+		return;
+
+	if (br) {
+		u16 pvid = GSWIP_VLAN_UNAWARE_PVID;
+
+		if (br_vlan_enabled(br))
+			br_vlan_get_pvid(br, &pvid);
+
+		/* VLAN-aware bridge ports with no PVID will use Active VLAN
+		 * index 0. The expectation is that this drops all untagged and
+		 * VID-0 tagged ingress traffic.
+		 */
+		idx = 0;
+		for (int i = priv->hw_info->max_ports;
+		     i < ARRAY_SIZE(priv->vlans); i++) {
+			if (priv->vlans[i].bridge == br &&
+			    priv->vlans[i].vid == pvid) {
+				idx = i;
+				break;
+			}
+		}
+	} else {
+		/* The Active VLAN table index as configured by
+		 * gswip_add_single_port_br()
+		 */
+		idx = port + 1;
+	}
+
+	/* GSWIP 2.2 (GRX300) and later program here the VID directly. */
+	gswip_switch_w(priv, idx, GSWIP_PCE_DEFPVID(port));
+}
+
 static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 				     bool vlan_filtering,
 				     struct netlink_ext_ack *extack)
@@ -581,6 +620,8 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 				  GSWIP_PCE_PCTRL_0p(port));
 	}
 
+	gswip_port_commit_pvid(priv, port);
+
 	return 0;
 }
 
@@ -677,8 +718,6 @@ static int gswip_setup(struct dsa_switch *ds)
 
 	ds->mtu_enforcement_ingress = true;
 
-	ds->configure_vlan_while_not_filtering = false;
-
 	return 0;
 }
 
@@ -819,7 +858,7 @@ static int gswip_vlan_add(struct gswip_priv *priv, struct net_device *bridge,
 		return err;
 	}
 
-	gswip_switch_w(priv, vlan_aware ? idx : 0, GSWIP_PCE_DEFPVID(port));
+	gswip_port_commit_pvid(priv, port);
 
 	return 0;
 }
@@ -874,9 +913,7 @@ static int gswip_vlan_remove(struct gswip_priv *priv,
 		}
 	}
 
-	/* GSWIP 2.2 (GRX300) and later program here the VID directly. */
-	if (pvid)
-		gswip_switch_w(priv, 0, GSWIP_PCE_DEFPVID(port));
+	gswip_port_commit_pvid(priv, port);
 
 	return 0;
 }
-- 
2.51.0

