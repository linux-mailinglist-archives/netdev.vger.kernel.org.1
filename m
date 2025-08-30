Return-Path: <netdev+bounces-218447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59DEB3C772
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904963B0396
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74E32475C8;
	Sat, 30 Aug 2025 02:33:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E66A33B;
	Sat, 30 Aug 2025 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521237; cv=none; b=EYh/fPynYInJgdSgGHk7CRTFHQHUq+wt5Gx4XNc0GfEE0TIeYHbJYRmiQtOPQIjFxgI8N+rZcoXIOsq20dSiEPCFNcFNAu1NCBgwp9ToDC9BHFYso7tUTPDxzeHB8NSNElfL+6GIFfU3dnQoPd/5rlIdjvhuxUgD+a2H//1hGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521237; c=relaxed/simple;
	bh=FDDrR98CHZx73ts/IpEf492WeJIXZC0Efjy1lq2mZC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeGG1BT+7cbpepVAF8JVMuLxmakTARJRD/LymBFLBSldYfb21/mBNo9PbSo32+Y+xosK1mZiyXQoQYbSB5mDXNmZeb8ud2xmIBvXsw+405xY43vQTQURWb8PhB0oDOJRvf6msfQyvy/d1B4SvQ4yYV7HHRvIvCb4ETXVH+8qKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1usBPb-000000005wR-2oG6;
	Sat, 30 Aug 2025 02:33:51 +0000
Date: Sat, 30 Aug 2025 03:33:48 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
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
Subject: [PATCH net-next v4 3/6] net: dsa: lantiq_gswip: ignore SerDes modes
 in phylink_mac_config()
Message-ID: <dcb066d6a02e6340314b5ff4f73937757a4f8eb3.1756520811.git.daniel@makrotopia.org>
References: <cover.1756520811.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756520811.git.daniel@makrotopia.org>

We can safely ignore SerDes interface modes 1000Base-X, 2500Base-X and
SGMII in phylink_mac_config() as they are being taken care of by the PCS
and the SGMII port anyway doesn't have MII_CFG and MII_PCDU registers
and hence gswip_phylink_mac_config() is already a no-op apart from
outputing a misleading error message.

Return early in case of SerDes interface modes to avoid printing that
error message.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Hauke Mehrtens <hauke@hauke-m.de>
---
v4: no changes
v3: improve commit message
v2: no changes

 drivers/net/dsa/lantiq/lantiq_gswip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index acb6996356e9..3e2a54569828 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -1444,6 +1444,10 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
 	miicfg |= GSWIP_MII_CFG_LDCLKDIS;
 
 	switch (state->interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return;
 	case PHY_INTERFACE_MODE_MII:
 	case PHY_INTERFACE_MODE_INTERNAL:
 		miicfg |= GSWIP_MII_CFG_MODE_MIIM;
-- 
2.51.0

