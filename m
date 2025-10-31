Return-Path: <netdev+bounces-234737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEF6C26B36
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E7D407456
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB72F6924;
	Fri, 31 Oct 2025 19:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5982F90EA;
	Fri, 31 Oct 2025 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938412; cv=none; b=UubHAUt2T73Ry7cMbnxGJUllx/V5HrtFMNU5Th7pnOHZOjDbECrsipPEZB8F09LhH5zmS93st58Q8MWh8bSmgFX3eqxshVHTN/LIC8RUMr5mm44mSdvwe/2tWzNuTWwFVNatR2HwOyvcPhJ581ranlSKBRSy+21wrPMsJ9tWnhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938412; c=relaxed/simple;
	bh=eCuYskWBeNuMIu1R61XI9NFaBsiGLE8aK86Um0gm0VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX33Cfu31XvZ83bNg1ZuaDCNUUpsEy9zTTru1p7UB9o+Tu/YrlG541SqzTM1hL1q5qN4U4/dk4meF8lh5gq7dYW4JAN/2jZX3JOHca6z0q80Wo2Ll6vubuY6P+Gh/0vsf48m9jNPi4SCd1Qz1b5mhyaGoLRatYKKZOVAjehzpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEufO-000000005sW-0K2x;
	Fri, 31 Oct 2025 19:20:06 +0000
Date: Fri, 31 Oct 2025 19:20:02 +0000
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
Subject: [PATCH net-next v6 04/12] net: dsa: lantiq_gswip: set link
 parameters also for CPU port
Message-ID: <5b05419f10f31f2e18b2fa62a9c9d5de68335c99.1761938079.git.daniel@makrotopia.org>
References: <cover.1761938079.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761938079.git.daniel@makrotopia.org>

On standalone switch ICs the link parameters of the CPU port need to
be setup just like user ports. The destinction in the driver to not
carry out link parameter setup for the CPU port does make sense for
in-SoC switches on which the CPU port is internally connected to the
SoC's Ethernet MAC.
Set link parameters also for the CPU port unless it is an internal
interface. Note that the internal TP PHYs anyway cannot be used as
CPU ports, hence it doesn't matter that they are now also covered by
that condition.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v4: improve commit message

 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index 092187603dea..0ac87eb23bb5 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -1459,7 +1459,7 @@ static void gswip_phylink_mac_link_up(struct phylink_config *config,
 	struct gswip_priv *priv = dp->ds->priv;
 	int port = dp->index;
 
-	if (!dsa_port_is_cpu(dp)) {
+	if (!dsa_port_is_cpu(dp) || interface != PHY_INTERFACE_MODE_INTERNAL) {
 		gswip_port_set_link(priv, port, true);
 		gswip_port_set_speed(priv, port, speed, interface);
 		gswip_port_set_duplex(priv, port, duplex);
-- 
2.51.2

