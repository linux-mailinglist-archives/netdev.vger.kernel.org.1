Return-Path: <netdev+bounces-110556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2544F92D0E5
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF73B1F24592
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABD319066D;
	Wed, 10 Jul 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kGZv9rQh"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C818FDC4;
	Wed, 10 Jul 2024 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611764; cv=none; b=P4zS3KnxZCs6Mjy/XRi3XXO10vedC8dLrr/5YlYjjLCpbnnAnDC6fJYm6J0FGg7Z0nwb3IHX8q8T/qGi0PTlbjd6CGoqlEdEy9Lox1fS69lqvMfTiGFtqWLFVx3svfylZlHxcjNt1xJIXeeCYbNMfjNPpN4Pfx3J69lhNPAIXj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611764; c=relaxed/simple;
	bh=saEXLfnetRqCX2p7vcE7tLJrTm/XEutrHu/3Vi+j1LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvfyfxjBTWKeU59uqhx0gyT8EY8Vu+b4pV4EE0hj64Sns2qpbkXzFlBTIHdnJjICtQsPtN0JAlpWFdPb5pvy0GWNYWXm/AkszoixuCQodUKPuWWHt26z+a4AltbNIQ+JwDr/FBSrTIxIXAc6enOcsL4VVcpfypwKXvlqCEbasa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kGZv9rQh; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A67E22000B;
	Wed, 10 Jul 2024 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720611760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2sYuS1K5dZ6Aq1gTipTywOPx8OLUbg/5RfC3uwk7QY=;
	b=kGZv9rQhhRxifG7dXUGbdb/2EgcZe1jBSv0ftotxh+GQMGFXYoMhofwqa3tSXeKJ1VUb+9
	BZL2L8POD0smXnGvpTYJmqWgZtxmyETUlNy/W2GHTP1xS4k+gFGATx46EysUU0tq2rbWuE
	RqZBret80qrTsEdq5xOziZC+erMr5EfG92KS6AjWgca+qbfx1UK9Cmog6XHBXd6VtCnm8W
	as9Q8Ad3ahCGCQ6Abo+iMb4/fLZX2Pm/2k5RAc89vqOJvN6ZVoxKMHlLRJ2TAKUMhsxGye
	ltn+F/66ufIE94nADVSSVLos0jVyssuFUNLu/K2TicZ/ztEkhYjP89vcjnm2xg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 2/2] net: ethtool: pse-pd: Fix possible null-deref
Date: Wed, 10 Jul 2024 13:42:31 +0200
Message-Id: <20240710114232.257190-2-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710114232.257190-1-kory.maincent@bootlin.com>
References: <20240710114232.257190-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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


