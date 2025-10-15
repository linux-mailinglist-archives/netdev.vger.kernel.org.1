Return-Path: <netdev+bounces-229807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94B1BE0F0A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832B93B01EC
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D297F30BB83;
	Wed, 15 Oct 2025 22:32:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AF308F1E;
	Wed, 15 Oct 2025 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567558; cv=none; b=mfU5Ytdy6JhwEHYsCFo/gRe+itCqDTu7sJzBeUFVS070nGO8jvVx34V3w+4vFsWr46eM3tFJZ1VmL0IGX++f4JUXtAwS1jsgep9UW4K4ESVFrpquIOpUhspCFCA3/Ap1v2yBJroUPzH/pO9IVof4kSR9SaNF5YxQ0n/JS87ZXcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567558; c=relaxed/simple;
	bh=50jMK7HPDX4QlUAOSngHbbnQ2ea6CfN56CWfStl4I4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpjwcSy10DzppqQoA9Xc8dDMaU1niPqlQocjpEJa29+K8ARmkFkG13bfjFQeJbrGj4QOsDZecvZgk1WT5JuORi13MCskXhimQ6qfda+DA1IRZVsKExgJS6V6k8VJoH7CTuIZTc8n4PeSuB4cEZi0PC8Fvj6CBRhoYnV6c5sB+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1v9A2r-000000006V1-48qk;
	Wed, 15 Oct 2025 22:32:34 +0000
Date: Wed, 15 Oct 2025 23:32:30 +0100
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
Subject: [PATCH net-next 03/11] net: dsa: lantiq_gswip: remove duplicate
 assignment to vlan_mapping.val[0]
Message-ID: <039ecb48e038cea856a9a6230ad1543db2bc382d.1760566491.git.daniel@makrotopia.org>
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

When idx == -1 in gswip_vlan_add(), we set vlan_mapping.val[0] = vid,
even though we do the exact same thing again outside the if/else block.

Remove the duplicate assignment.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/lantiq_gswip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 9526317443a1..e41d67ea89c5 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -848,8 +848,6 @@ static int gswip_vlan_add_aware(struct gswip_priv *priv,
 
 		vlan_mapping.index = idx;
 		vlan_mapping.table = GSWIP_TABLE_VLAN_MAPPING;
-		/* VLAN ID byte, maps to the VLAN ID of vlan active table */
-		vlan_mapping.val[0] = vid;
 	} else {
 		/* Read the existing VLAN mapping entry from the switch */
 		vlan_mapping.index = idx;
@@ -862,6 +860,7 @@ static int gswip_vlan_add_aware(struct gswip_priv *priv,
 		}
 	}
 
+	/* VLAN ID byte, maps to the VLAN ID of vlan active table */
 	vlan_mapping.val[0] = vid;
 	/* Update the VLAN mapping entry and write it to the switch */
 	vlan_mapping.val[1] |= cpu_ports;
-- 
2.51.0

