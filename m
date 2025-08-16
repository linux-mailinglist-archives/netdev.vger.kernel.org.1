Return-Path: <netdev+bounces-214348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D56BB29080
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 22:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE683AB4F8
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A59225416;
	Sat, 16 Aug 2025 19:57:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E3F218ADD;
	Sat, 16 Aug 2025 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374251; cv=none; b=tQhZoR+jMPIAFRylNta2cBq7leFJHXDeSzEsRvpu4qokfBXpxjI8h4skPER+lvRH5BM3T/ycdvguFmFd1W3kkdwgulbEfaNTG9FE1bYveGWciOCVqKeyrjq1V+ldD0SIjwvOCOu8FL/elTXYjzwKDYN3g+QTnWYthzBqpTh7SmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374251; c=relaxed/simple;
	bh=oSbnVDNLUyXGhDX/whoU5oan2zpFNLhNGA6wYdMjaLU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fMwVBThOXEz4+zLPABdcDNHgsizU+cd6zlWJbPIaOPq3zJnuUDTIokTYhWk2US1BOabtPYCdQ49M+1mybGdmrVgcQk4eyCkv9tyLG5qfFioFk4o0KLZ33ZLf/WfWmb73+6gzXcbWSwU5jOlJjPa2X8GoDUgtH/JAqf+/ugz+LcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unN1p-000000007A4-0Cv5;
	Sat, 16 Aug 2025 19:57:25 +0000
Date: Sat, 16 Aug 2025 20:57:21 +0100
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
Subject: [PATCH RFC net-next 23/23] net: dsa: lantiq_gswip: ignore SerDes
 modes in phylink_mac_config()
Message-ID: <aKDioaSiVwLRV0De@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We can safely ignore SerDes interface modes 1000Base-X, 2500Base-X and
SGMII in phylink_mac_config() as they are being taken care of by the
PCS.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip_common.c b/drivers/net/dsa/lantiq_gswip_common.c
index ff785ebc8847..7453802a8b8f 100644
--- a/drivers/net/dsa/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq_gswip_common.c
@@ -1476,6 +1476,10 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
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
2.50.1

