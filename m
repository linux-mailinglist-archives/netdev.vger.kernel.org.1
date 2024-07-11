Return-Path: <netdev+bounces-110859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCDE92EA08
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11D61C217BE
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE331662FA;
	Thu, 11 Jul 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GJvh9JWt"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5215FCFB;
	Thu, 11 Jul 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706158; cv=none; b=p2/M874uPX4qtNzCI1HtZbFq9g61HF7pCvhN7UBU8fBohX/Mf9nQ5hAkiVYDGe/+wAo+3n0tGwoRAV3ohe46EHiYOVfgok6n+NReMs5oX9iItk+vzboMn9DfELxd9Rm9qq4WedMLav+wrRS4H4063VePb/uVz+kK5gPogrySwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706158; c=relaxed/simple;
	bh=G4X0oC8pcsd+zN1erd0h6HCHhQkIQJkVQ1WK4rudAeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PyhFqeKy/g0WhL4aV0BgS84VQ8fnHVuszvBPk5Zb9VpkrwO3XS0AGah5G8VHcR5n7VXeAx0oMWiQqC2SIk4GKs31M2g6sLq92hg7T98QM3+301uQc1/6P1bbVu0nYxLThJX3ubS6oE+vIhaDb2aMm+0ljbX39tsiMrPVHmo6jLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GJvh9JWt; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04DF4C0006;
	Thu, 11 Jul 2024 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720706154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1/i67l0rh6zcxHO4vrNIsKxwOBneQPuzJf+8OC7dNo=;
	b=GJvh9JWtbOWDSRS7IzhXyHD6LqFMck+M7eyTFKNd8HJAriAbS7xT3KlrnpeoeoTeAiXbA5
	gy5VRlt0xrIOC2rx17TO89hNMWzwpeYuc1IWGeOvp0l5RU+3P8xNQ31bOusHRfOKZQ75gT
	uj+oTJCZ7KK019tTMQH703/I4rrQ4msxyFWxljld+vVkl95prjf+ebixb70Fw4BlKvUgnJ
	zoxZu5AKlkCiacAW0ctKwcCnD/P9Zgx2MLFJwkGyNKrYIolv5G3240nansHFRpWcFOKp0S
	6doMcsFpBTffA2gPyvn9QKjJymo4iMl4NMaRL2mS96wa76RlgHcKIN3HSsHZ3w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 11 Jul 2024 15:55:19 +0200
Subject: [PATCH net v3 2/2] net: ethtool: pse-pd: Fix possible null-deref
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-fix_pse_pd_deref-v3-2-edd78fc4fe42@bootlin.com>
References: <20240711-fix_pse_pd_deref-v3-0-edd78fc4fe42@bootlin.com>
In-Reply-To: <20240711-fix_pse_pd_deref-v3-0-edd78fc4fe42@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Fix a possible null dereference when a PSE supports both c33 and PoDL, but
only one of the netlink attributes is specified. The c33 or PoDL PSE
capabilities are already validated in the ethnl_set_pse_validate() call.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20240705184116.13d8235a@kernel.org/
Fixes: 4d18e3ddf427 ("net: ethtool: pse-pd: Expand pse commands with the PSE PoE interface")
---
 net/ethtool/pse-pd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 982995ff1628..776ac96cdadc 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -178,9 +178,9 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	phydev = dev->phydev;
 	/* These values are already validated by the ethnl_pse_set_policy */
-	if (pse_has_podl(phydev->psec))
+	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL])
 		config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
-	if (pse_has_c33(phydev->psec))
+	if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL])
 		config.c33_admin_control = nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]);
 
 	/* Return errno directly - PSE has no notification

-- 
2.34.1


