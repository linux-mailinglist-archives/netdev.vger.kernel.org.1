Return-Path: <netdev+bounces-233715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D3C177FE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6904B4EF1AA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED57232395;
	Wed, 29 Oct 2025 00:17:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702222367D5;
	Wed, 29 Oct 2025 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697040; cv=none; b=FfG38dlsIhhKmKNLOGqn2pnvo1EkhW67gS4Ju7nvfDvdYkKKrXCGGkHsRy8vKO9AdsJ0oDyc1QDuavP1f030k8d6GsNb6zLzUUH+DNMmpKuUFTecYxOkg9aY5wBueGvq0T9Otrpsm4BiroLfVY3Cv4Zoqh78sKLJcylIhXVZ9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697040; c=relaxed/simple;
	bh=jlVsC/SEErUuM0DBqDYBUonaN5FNOnzgjsI9wQbNyFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXEz5LqnKhJh9gtn+QLqIwr9ICQWHZRNNHRaWJ0dTqD3gEDXOVSsitvqkF6v1NBA7wmpJwRGxj4+/wyuHPWYH0hit/b440Lvyax3WFhjqkAMnC6YdbwmNqQCRrZma6XgQqcUfRYM+g4Em2j9olew9pNMbZnk9cPQK4i9/zYvKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDtsI-000000004Ac-0bhx;
	Wed, 29 Oct 2025 00:17:14 +0000
Date: Wed, 29 Oct 2025 00:17:10 +0000
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
Subject: [PATCH net-next v4 04/12] net: dsa: lantiq_gswip: set link
 parameters also for CPU port
Message-ID: <65dd9db5336704ae7fd51d8869f8a69d2f0e96d3.1761693288.git.daniel@makrotopia.org>
References: <cover.1761693288.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761693288.git.daniel@makrotopia.org>

On standalone switch ICs the link parameters of the CPU port need to
be setup just like user ports. The destinction in the driver to not
carry out link parameter setup for the CPU port does make sense for
in-SoC switches on which the CPU port is internally connected to the
SoC's Ethernet MAC.
Set link parameters also for the CPU port unless it is an internal
interface. Note that the internal TP PHYs anyway cannot be used as
CPU ports, hence it doesn't matter that they are now also covered by
that condition.

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
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
2.51.1

