Return-Path: <netdev+bounces-229814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4769BE0F61
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B186560414
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11CB30E824;
	Wed, 15 Oct 2025 22:33:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216CE30CD9F;
	Wed, 15 Oct 2025 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567638; cv=none; b=QhPHC0sKf+wS9ojI7/QRnnMrmq4No4zBnfkf36v0Rh7v02Km2+jjXKhtT0CqGD0nIOR2fun2vqFZT+6ncPudXMgLBdsLYMkhnZCoLrASPdoS5Wj874+RGk3qExYtJR+KIRToE3RMoRpAziNp3TUG6N/Ttctoj4RXKKapYdsJ7SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567638; c=relaxed/simple;
	bh=hI6zhUaPUnSyYaYYUOCoj1r0gchkEgn6E8nlapACsZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpIcI+uIM5DKtgVoaQopikXnY5/ulaYkXfSW++fe/1v9rKxOeP1VdQUKOt+4HzMWIvQFFuz5S4CBtTtk0nM8RnePjn5+35eBZAc6XNC3OfB8PshbxTCqk7SPSiwmnRwh+uQ7iDh9e6+sV+MDXFh1KaujTRBQT30jUdraMg7xSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A49-000000006XG-38pp;
	Wed, 15 Oct 2025 22:33:53 +0000
Date: Wed, 15 Oct 2025 23:33:50 +0100
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
Subject: [PATCH net-next 10/11] net: dsa: lantiq_gswip: drop untagged on
 VLAN-aware bridge ports with no PVID
Message-ID: <787aa807d00b726d75db2a40add215c8b8ba7466.1760566491.git.daniel@makrotopia.org>
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

Implement the required functionality, as written in
Documentation/networking/switchdev.rst section "Bridge VLAN filtering",
by using the "VLAN Ingress Tag Rule" feature of the switch.

The bit field definitions for this were found while browsing the Intel
dual BSD/GPLv2 licensed drivers for this switch IP.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 6 ++++++
 drivers/net/dsa/lantiq/lantiq_gswip.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index cfdeb8148500..1ff0932dae31 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -551,6 +551,7 @@ static void gswip_port_commit_pvid(struct gswip_priv *priv, int port)
 {
 	struct dsa_port *dp = dsa_to_port(priv->ds, port);
 	struct net_device *br = dsa_port_bridge_dev_get(dp);
+	u32 vinr;
 	int idx;
 
 	if (!dsa_port_is_user(dp))
@@ -582,6 +583,11 @@ static void gswip_port_commit_pvid(struct gswip_priv *priv, int port)
 		idx = port + 1;
 	}
 
+	vinr = idx ? GSWIP_PCE_VCTRL_VINR_ALL : GSWIP_PCE_VCTRL_VINR_TAGGED;
+	gswip_switch_mask(priv, GSWIP_PCE_VCTRL_VINR,
+			  FIELD_PREP(GSWIP_PCE_VCTRL_VINR, vinr),
+			  GSWIP_PCE_VCTRL(port));
+
 	/* GSWIP 2.2 (GRX300) and later program here the VID directly. */
 	gswip_switch_w(priv, idx, GSWIP_PCE_DEFPVID(port));
 }
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 4590a1a7dbd9..69c8d2deff2d 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -159,6 +159,10 @@
 #define  GSWIP_PCE_PCTRL_0_PSTATE_MASK	GENMASK(2, 0)
 #define GSWIP_PCE_VCTRL(p)		(0x485 + ((p) * 0xA))
 #define  GSWIP_PCE_VCTRL_UVR		BIT(0)	/* Unknown VLAN Rule */
+#define  GSWIP_PCE_VCTRL_VINR		GENMASK(2, 1) /* VLAN Ingress Tag Rule */
+#define  GSWIP_PCE_VCTRL_VINR_ALL	0 /* Admit tagged and untagged packets */
+#define  GSWIP_PCE_VCTRL_VINR_TAGGED	1 /* Admit only tagged packets */
+#define  GSWIP_PCE_VCTRL_VINR_UNTAGGED	2 /* Admit only untagged packets */
 #define  GSWIP_PCE_VCTRL_VIMR		BIT(3)	/* VLAN Ingress Member violation rule */
 #define  GSWIP_PCE_VCTRL_VEMR		BIT(4)	/* VLAN Egress Member violation rule */
 #define  GSWIP_PCE_VCTRL_VSR		BIT(5)	/* VLAN Security */
-- 
2.51.0

