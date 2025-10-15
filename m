Return-Path: <netdev+bounces-229815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1321CBE0F67
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3719C508AFB
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CDC30E85A;
	Wed, 15 Oct 2025 22:34:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38D30BB84;
	Wed, 15 Oct 2025 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567649; cv=none; b=GMJluY+RrMxmW0xkVmAc8XRCDASZvUqMSLJWNdftI7VK0PSe+S+RCkpOxhrY2q7kcdPkOXEXSdKDIhPo02EXc/CFHbOvufBceo9t4Rg7XrdqM4zyt9w6DigPNd7tMCBqmIibHQ3IxhnKJ+N7JG7KDFDFnbmRE/vxlDbBWv5B3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567649; c=relaxed/simple;
	bh=f3ZXJTPXaLUSOHR0DUO+dULY39lV+saUqdm+RMnvqdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOdH4S4hI+WadpgJFu870QxKTx7kOTZwjzOJSclyt3VrdPzLZ9+m9PDcpcUY0qjMWM1fAuk9glkzLA8pOXv1fo241HEKljNXPpFHUJDjE967/gVMCCDhhr98x/6Oj87cg6G503HS3Xd9Flwuk/U+E6hmZCK+4rvCQdn1IAUpp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A4K-000000006Xf-310e;
	Wed, 15 Oct 2025 22:34:04 +0000
Date: Wed, 15 Oct 2025 23:34:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
Subject: [PATCH net-next 11/11] net: dsa: lantiq_gswip: treat VID 0 like the
 PVID
Message-ID: <b220ac149922839a261b754202c05df5bb253c98.1760566491.git.daniel@makrotopia.org>
References: <cover.1760566491.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760566491.git.daniel@makrotopia.org>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Documentation/networking/switchdev.rst says that VLAN-aware bridges must
treat packets tagged with VID 0 the same as untagged. It appears from
the documentation that setting the GSWIP_PCE_VCTRL_VID0 flag (which this
driver already had defined) might achieve this.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 1ff0932dae31..25f6b46957a0 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -603,7 +603,7 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 		gswip_switch_mask(priv,
 				  GSWIP_PCE_VCTRL_VSR,
 				  GSWIP_PCE_VCTRL_UVR | GSWIP_PCE_VCTRL_VIMR |
-				  GSWIP_PCE_VCTRL_VEMR,
+				  GSWIP_PCE_VCTRL_VEMR | GSWIP_PCE_VCTRL_VID0,
 				  GSWIP_PCE_VCTRL(port));
 		gswip_switch_mask(priv, GSWIP_PCE_PCTRL_0_TVM, 0,
 				  GSWIP_PCE_PCTRL_0p(port));
@@ -611,7 +611,7 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 		/* Use port based VLAN */
 		gswip_switch_mask(priv,
 				  GSWIP_PCE_VCTRL_UVR | GSWIP_PCE_VCTRL_VIMR |
-				  GSWIP_PCE_VCTRL_VEMR,
+				  GSWIP_PCE_VCTRL_VEMR | GSWIP_PCE_VCTRL_VID0,
 				  GSWIP_PCE_VCTRL_VSR,
 				  GSWIP_PCE_VCTRL(port));
 		gswip_switch_mask(priv, 0, GSWIP_PCE_PCTRL_0_TVM,
-- 
2.51.0

