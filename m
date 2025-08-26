Return-Path: <netdev+bounces-217083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0760CB37534
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD92A360DDB
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECAD2BEC53;
	Tue, 26 Aug 2025 23:06:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999741F5825;
	Tue, 26 Aug 2025 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249573; cv=none; b=mppz9b3e3dnjXoJamIcf4fRFk+ToPhvuaYzbhiqep3s4C0prSZJLUCBwpCHwVEDVBSMC9VWAaLO6xdUIoDSrNclKXBTfGs0JZpEgT/tZqK7B2NZQ+j22Lp8/VfKPGTEKjfqqIDgdFm2KW46R52O3ha+lHTYuSRMTDKaydD10KL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249573; c=relaxed/simple;
	bh=oX3xY1E4y6s9SX3K5pxVU8ohBPizhGzAIY72lQOml2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/PzrgQr1iFwjwWiiFbNWhPrdjuKs/kB9X4w1TIpqo7ckNy+nBva4i5Y3NcJGSUWstNbIYFPZLiwV+pavljydn9aKtOYNDHoEDwsuOikmKzNs8mqIS60Eo/nYwnDvZUMw7eRrvp1oGVi74vve6hnboJVvVR5G6dZCgyy0RWF1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1ur2ju-000000001t9-3nGM;
	Tue, 26 Aug 2025 23:06:07 +0000
Date: Wed, 27 Aug 2025 00:06:03 +0100
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
Subject: [PATCH net-next v2 3/6] net: dsa: lantiq_gswip: ignore SerDes modes
 in phylink_mac_config()
Message-ID: <99d62fca9651f17ed1e94ab01245867bcd775cd8.1756228750.git.daniel@makrotopia.org>
References: <cover.1756228750.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756228750.git.daniel@makrotopia.org>

We can safely ignore SerDes interface modes 1000Base-X, 2500Base-X and
SGMII in phylink_mac_config() as they are being taken care of by the
PCS.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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

