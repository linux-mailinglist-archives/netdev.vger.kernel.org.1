Return-Path: <netdev+bounces-216725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D8FB3500C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0138F5E2B5B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4969460DCF;
	Tue, 26 Aug 2025 00:12:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0779F2;
	Tue, 26 Aug 2025 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167153; cv=none; b=nVJHcMVyhbYjZemkX3S8wyrVkWG8xRJBOKcUw76sjZB78coI/rMcETx0uErucPp4X/zlwhp5vPJALFVbkrflu+nGBzJfKX7kr2Si2aH7KN1fSsT4M8tciF0oZGgNfuAOUoPn+gNDZwP1BgQilTz+jKtFT63fpE3eOgRrH5zENj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167153; c=relaxed/simple;
	bh=Ch2CNd/1F5stQg+EOkYaSVKSA6ga8d366HCcrTjLPL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgtiYPhxephi608s3oEG9pYA/a0OmUqYdXjQuO7Jr1HPg9eLqjAjGwQ6e8FJXnL6rGS1ZNkecAjQeW78dvWGeZaub6ACZfPfSra8aSenJr6s1V/7kVWgzmUBF/xEvw3occlI9dBMb7u5N8RyF1XjucYUJe4gvtD2SY4H36uv77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uqhIZ-000000005jy-10Sv;
	Tue, 26 Aug 2025 00:12:27 +0000
Date: Tue, 26 Aug 2025 01:12:23 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCH net-next 3/6] net: dsa: lantiq_gswip: ignore SerDes modes in
 phylink_mac_config()
Message-ID: <374cb3a2d857cd6c197d4eabbd4af5cfb0c96935.1756163848.git.daniel@makrotopia.org>
References: <cover.1756163848.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756163848.git.daniel@makrotopia.org>

We can safely ignore SerDes interface modes 1000Base-X, 2500Base-X and
SGMII in phylink_mac_config() as they are being taken care of by the
PCS.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 4822812bba27..7ffaa6481271 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
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
2.50.1

