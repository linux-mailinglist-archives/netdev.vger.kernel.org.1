Return-Path: <netdev+bounces-216729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E562B35019
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0EB5E344E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC0E76025;
	Tue, 26 Aug 2025 00:14:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD31548C;
	Tue, 26 Aug 2025 00:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167280; cv=none; b=Zf15xYvlF28l67Kau1DRHXo/UQ9/ty7MlbXSj6vh6b92Jupuv4pVvInjVH1ACiOlijMYmNIG5GONAfYA82bCYGZZslb5n9dDi1Nuy5zjiu7guA6r1gnnQ8bjm47Img7hKWk0DRJBUT3RxRyCd81W6/KE+ZA5Q4bBToK8XubgfIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167280; c=relaxed/simple;
	bh=g2Jor9gdO4xlgzu+PI6RpUpT7XXBCn3bnQszbdoVMmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOpndznNgph5hBnPHOPc10zdyMYYWaPelHmZ3nXyAu2tvtQyfL82CD82hPZ4U/VPOURCOdqPRACX+m175zdr6VzzdY/BnVL7HG6mwmvxyVhOVtb3QbEwHTnGWKnOCecKrso24P9MXOADYFYjr51O3uLm3EIcrXa/WWoyJzlpIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uqhKc-000000005m0-0SkW;
	Tue, 26 Aug 2025 00:14:34 +0000
Date: Tue, 26 Aug 2025 01:14:30 +0100
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
Subject: [PATCH net-next 5/6] net: dsa: lantiq_gswip: support standard MDIO
 node name
Message-ID: <6f4b14df1eef78c09481784555a911b7505d1943.1756163848.git.daniel@makrotopia.org>
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

Instead of matching against the child node's compatible string also
support locating the node of the device tree node of the MDIO bus
in the standard way by referencing the node name ("mdio").

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq_gswip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index f9b03fb5f57b..23b68047f3c4 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -286,6 +286,9 @@ static int gswip_mdio(struct gswip_priv *priv)
 	int err = 0;
 
 	mdio_np = of_get_compatible_child(switch_np, "lantiq,xrx200-mdio");
+	if (!mdio_np)
+		mdio_np = of_get_child_by_name(switch_np, "mdio");
+
 	if (!of_device_is_available(mdio_np))
 		goto out_put_node;
 
-- 
2.50.1

