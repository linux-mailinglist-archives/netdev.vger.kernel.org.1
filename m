Return-Path: <netdev+bounces-110259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B192BABD
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960A228EABB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8F31586C7;
	Tue,  9 Jul 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I2eUBOlJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F288382;
	Tue,  9 Jul 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530728; cv=none; b=X4sbUH4wG2hw2QSVeBcbpho7eaPq+Ro5vZRSFvF7f5fM3PiBb0tN00c1oW/QiD7JfyjHFoLffTzaFf/E9BHVd3iC1XyHwAtMs7maOpeeK1Rb0pMzzw4U/JSzZLkp0Fk/saQfKUUNsY/MydpmEHmlLnrBIgWHN5wqQ4hQhzmCIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530728; c=relaxed/simple;
	bh=thBkZ1mHy4Pkp0neqh0/O7X2R309OPf6o6UZIvmb0aI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=krRAqpwkVD6f0rsuJwXE7YGkH+CTa631qQNKo4wqXuftDXeSDuVLAJCoN5PV0QBVFIQ3GxgoPTDaThNGk62V6da12TO6H6vO65JL8APzsT+67uJiR4BePLVHs2H86SfoK2Of5jxw/HQ/AzrISN3zCaHAa/TNVDTTvjnJ+f0xyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I2eUBOlJ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F08024000C;
	Tue,  9 Jul 2024 13:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720530724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w1TLE5iJaCkQatSU9cim5/UCRFLh7MH6AU0ztK2G10U=;
	b=I2eUBOlJKJq/qx4CGXSMH1aGTrhXcmtKI6vJ6evPDUhXzkNzum0Yb8sS8TUc5wA6fOnErj
	hbi/ugGV+w7W+domFCw+nqBy9+EFGpCahqhUvHLuQwIP65FLEJCvmPdwF9Zsy804aQIONh
	L9SX362WlmJFHM3ayDVaRKxXwkgFta6bNUIIlDNFaFJ3vsuQ0KVr13sRrfdjrNYyxy4LDW
	4F+RcB3nKyiwT5JJ8Uex/L1DxCy3e/uN5RbYvh7zSBNfWkpe1BERAje917DJsx48ZXK7lm
	2ldAmgTG5QgZpps47uLWzX6DsE13aqTP/GknK2rhx7bcPeKfPsw8VDRhk+riDg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: ethtool: pse-pd: Fix possible null-deref
Date: Tue,  9 Jul 2024 15:12:01 +0200
Message-Id: <20240709131201.166421-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
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
index 2c981d443f27..9dc70eb50039 100644
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
 
 	/* Return errno directly - PSE has no notification */
-- 
2.34.1


