Return-Path: <netdev+bounces-235063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3578EC2BA89
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 13:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E1B14F5D8D
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 12:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59A308F33;
	Mon,  3 Nov 2025 12:19:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1F430AD1A;
	Mon,  3 Nov 2025 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172396; cv=none; b=SciCU4EL/WI9oxjzQFEOnYBfIdsc6g0ge6JFdyUpieyH5/yp8Fx+Z+1JjFKlIfT8LjYLOR0lsXDf+BCoGq+ZWaS5tZYfwD0bb7FkKy6UC93RHYlecWcDccDGuSTo/LLmwah09zR4s7uFpegbrUI9zX4RbyEPC+dnXSwjykA8VDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172396; c=relaxed/simple;
	bh=r7rVdAO60XSmCTvWDx/5/jtg1dyCCJln835EG1xNKNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUYMzOG/gXUmIIp9BvEJ76c6k/ukFYMNIMHIqirwhbJ9J+Yblhbys1ygcYWTxIqFyMVBLr2j4il/5EJh0FUiz2dBKiU821ErYZuOHlNHnzw+KUno+fU5aBcit6uODz1aQLwbF0dyjKqod2sxik9bSdE7RuUTd7k9p+mEcvh3fbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vFtXK-000000000q6-3Icp;
	Mon, 03 Nov 2025 12:19:50 +0000
Date: Mon, 3 Nov 2025 12:19:47 +0000
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
Subject: [PATCH net-next v7 07/12] net: dsa: lantiq_gswip: add vendor
 property to setup MII refclk output
Message-ID: <947d14970f74f760e4a60c777aabee64e7e4f356.1762170107.git.daniel@makrotopia.org>
References: <cover.1762170107.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762170107.git.daniel@makrotopia.org>

Read boolean Device Tree property "maxlinear,rmii-refclk-out" and switch
the RMII reference clock to be a clock output rather than an input if it
is set.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
v7: no changes

v6: no changes

v5: no changes

v4: set GSWIP_MII_CFG_RMII_CLK bit in RMII case inside the switch
    statement instead of a (wrong) if-clause just below

v3: no changes

v2: no changes

since RFC: no changes

 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index fdfc265b4c73..7b3debd45b91 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -1402,6 +1402,8 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		miicfg |= GSWIP_MII_CFG_MODE_RMIIM;
+		if (of_property_read_bool(dp->dn, "maxlinear,rmii-refclk-out"))
+			miicfg |= GSWIP_MII_CFG_RMII_CLK;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-- 
2.51.2

