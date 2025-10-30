Return-Path: <netdev+bounces-234374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252AC1FD3E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF4D189AC5E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7523F288A2;
	Thu, 30 Oct 2025 11:29:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324D355818;
	Thu, 30 Oct 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823790; cv=none; b=Uz2qJrQFG+k99qIwaQCbavh3brWOhoV2zxPH7hs1u9bKhnVGw4rH9Ctqk+I3yqU61nXGuKu8q0BtWS+nyEt1fYvQGPql4FddjnoJOAlOQVUU+oipf8/Ttugwlv56J7FzjzMdD0ewEXxr+H3zcV3bfSc65iDmORVpaFpSEssFlyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823790; c=relaxed/simple;
	bh=76jv8h5tRCoGD5+Lmysvmd3kcpPDiBDZaefRR6BPTSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDmj/XP8kjHR+uUqKg1pJ2AG/am9CIftMlbEe6tmD8YCZn8XfVRYA6npvXcWfxVnzZAnh0a9oSQjU99o2Vdr9PT4A43guj4LFGscm51GCXcU6D9MWjqO9t4k4RscOnemD183uEspQeY6PZOxq1r7WzCobjpG7ex9msYeDfRXsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEQqe-000000005Fb-0eki;
	Thu, 30 Oct 2025 11:29:44 +0000
Date: Thu, 30 Oct 2025 11:29:40 +0000
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
Subject: [PATCH net-next v5 09/12] net: dsa: lantiq_gswip: add vendor
 property to setup MII refclk output
Message-ID: <b3bb1aa9b5561406168314c41784996feb1e56e0.1761823194.git.daniel@makrotopia.org>
References: <cover.1761823194.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761823194.git.daniel@makrotopia.org>

Read boolean Device Tree property "maxlinear,rmii-refclk-out" and switch
the RMII reference clock to be a clock output rather than an input if it
is set.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
v4: set GSWIP_MII_CFG_RMII_CLK bit in RMII case inside the switch
    statement instead of a (wrong) if-clause just below

 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index f6846060fa18..6a4a09ebdd33 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -1433,6 +1433,8 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
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

