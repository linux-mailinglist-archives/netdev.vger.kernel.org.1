Return-Path: <netdev+bounces-229811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF677BE0F22
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F0B1A22FD7
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8530B52B;
	Wed, 15 Oct 2025 22:33:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFB2727F5;
	Wed, 15 Oct 2025 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567613; cv=none; b=TXQ7ruYhROuZRKVgbzb9UZutbLDKVEWkEhqVrPfO7tnrZNCyNq378yXl8vBJp5spzsZoAoxruHnlaYr1D1aQubiI0jWD3yHfEt3UVZPFuiBBqoMNhTu7ebtPqwogxxqFW3ENXJ5ZUSIEvJb/etG/3TygIenG2DPGQfW2xmIBAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567613; c=relaxed/simple;
	bh=JH2NJd4eSOR+np8+3szqii0tcMn3rn0h5zf22tg0u68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvoRd8iRtnOIJIiKlX/x4T/Yvt/NcCg/q5MH7G7RMnCODksCshMZttnGjsC4HrqamPny9nmbPjd7Rjm8uVKaPXfJVuCCwqRyjbXdiHxzuf2xaupzp2llw/VcOMGq1oNqNB5qvCR0QTmI7lmAWZbQMVIEEcy1I6dDsRXetHUSKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A3k-000000006WR-2rNM;
	Wed, 15 Oct 2025 22:33:28 +0000
Date: Wed, 15 Oct 2025 23:33:25 +0100
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
Subject: [PATCH net-next 07/11] net: dsa: lantiq_gswip: disallow changes to
 privately set up VID 0
Message-ID: <9f68340c34b5312c3b8c6c7ecf3cfce574a3f65d.1760566491.git.daniel@makrotopia.org>
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

User space can force the altering of VID 0 as it was privately set up by
this driver.

For example, when the port joins a VLAN-aware bridge,
dsa_user_manage_vlan_filtering() will set NETIF_F_HW_VLAN_CTAG_FILTER.
If the port is subsequently brought up and CONFIG_VLAN_8021Q is enabled,
the vlan_vid0_add() function will want to make sure we are capable of
accepting packets tagged with VID 0.

Generally, DSA/switchdev drivers want to suppress that bit of help from
the 8021q layer, and handle VID 0 filters themselves. The 8021q layer
might actually be even detrimential, because VLANs added through
vlan_vid_add() pass through dsa_user_vlan_rx_add_vid(), which is
documented as this:

	/* This API only allows programming tagged, non-PVID VIDs */
	.flags = 0,

so it will force VID 0 to be reconfigured as egress-tagged, non-PVID.
Whereas the driver configures it as PVID and egress-untagged, the exact
opposite.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 58fdd54094d6..26e963840f3b 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -1000,6 +1000,9 @@ static int gswip_port_vlan_add(struct dsa_switch *ds, int port,
 	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
 	int err;
 
+	if (vlan->vid == GSWIP_VLAN_UNAWARE_PVID)
+		return 0;
+
 	err = gswip_port_vlan_prepare(ds, port, vlan, extack);
 	if (err)
 		return err;
@@ -1023,6 +1026,9 @@ static int gswip_port_vlan_del(struct dsa_switch *ds, int port,
 	struct gswip_priv *priv = ds->priv;
 	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
 
+	if (vlan->vid == GSWIP_VLAN_UNAWARE_PVID)
+		return 0;
+
 	/* We have to receive all packets on the CPU port and should not
 	 * do any VLAN filtering here. This is also called with bridge
 	 * NULL and then we do not know for which bridge to configure
-- 
2.51.0

