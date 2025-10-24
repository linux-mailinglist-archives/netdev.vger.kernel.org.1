Return-Path: <netdev+bounces-232633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD2C0773F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38B3A4E67BC
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F23033F8DC;
	Fri, 24 Oct 2025 17:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11504264F9C;
	Fri, 24 Oct 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325448; cv=none; b=hBq86HdQX4fuw3sdfmYPyxWUPfozg7t5+mmcYBtKLVdYN0foyeLyfBZh6WIzexPEcftW4rJogA7R2GHncb4VqHrXtl17P4K2MYeblg8dGk1lykU+NwYve9quoUXN18Sa7fq+cqpzOnjabzd5kMIh67vD49sdEH9TxyWGPuspDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325448; c=relaxed/simple;
	bh=u6mVY8aer2Gy4dYbRxVwlel60zaxdWJHiv7QUuVuoL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sg/cn/AD0urk60EPVAsiFo/bypcLCgbseYtZGgBSzfxvRdvvIqYK9Z0SXajqyma0zFnK5BWinAMBeL/kHDHFKtDwuyLmK8PkajBqQpWLvQ4ygA6op/ArcRDAEQK7d322uBzAfhzHA86jEsNSLKtEFQGb4dy/82dTp7aQSyE8D/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vCLCr-0000000069P-2Unt;
	Fri, 24 Oct 2025 17:04:01 +0000
Date: Fri, 24 Oct 2025 18:03:50 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
Subject: [PATCH net-next 09/13] net: dsa: lantiq_gswip: add vendor property
 to setup MII refclk output
Message-ID: <968a687879640746bc20e14e7a7d6f6b9da936da.1761324950.git.daniel@makrotopia.org>
References: <cover.1761324950.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761324950.git.daniel@makrotopia.org>

Read boolean Device Tree property "maxlinear,rmii-refclk-out" and switch
the RMII reference clock to be a clock output rather than an input if it
is set.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index d5a13a7ee1c1..8ffd61693f3a 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -1441,6 +1441,10 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
 		return;
 	}
 
+	if (of_property_read_bool(dp->dn, "maxlinear,rmii-refclk-out") &&
+	    !(miicfg & GSWIP_MII_CFG_MODE_RGMII))
+		miicfg |= GSWIP_MII_CFG_RMII_CLK;
+
 	gswip_mii_mask_cfg(priv,
 			   GSWIP_MII_CFG_MODE_MASK | GSWIP_MII_CFG_RMII_CLK |
 			   GSWIP_MII_CFG_RGMII_IBS | GSWIP_MII_CFG_LDCLKDIS,
-- 
2.51.0

