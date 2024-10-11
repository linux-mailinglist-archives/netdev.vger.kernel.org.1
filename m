Return-Path: <netdev+bounces-134701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8499AE14
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A9A1B226D1
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473C41D151F;
	Fri, 11 Oct 2024 21:34:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647191D173D;
	Fri, 11 Oct 2024 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682479; cv=none; b=Fc9ko1NNFsXsDUEmJ9wxFk38p4QGfAW2H4nCdzYFKzWyRHu8va1AJZovfMj8GymdTGRTufywteNL62aMH8DIp8mH52azTDTl7mvJV+XyASUiIp7JsXDOk6ZvGcaf7KEX9S9BFyAjYM3X6MlLFNK6tggaT9upe/gYXo+RraeS0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682479; c=relaxed/simple;
	bh=/xIeRigBFDdbAiZ5s/l2ZePK8XbS9PN7iQsvp1ErRDM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=epOeKuiVyRACVq/6xlh6WoAQK7gRXolIXyQGsgZS7vqfpp9iaLtgqeLtXmjaDP7FFWvoKkY+fjLfDBcxJxHpOQiqyJW8ceSYGj5Fr51tliNrmYGq6xYlntfeeU35e84jffoyXTaAy23uaSaJ9LoP/M0+9TUQMVg508+0TXGhI7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1szNH8-000000001kA-2TvV;
	Fri, 11 Oct 2024 21:34:18 +0000
Date: Fri, 11 Oct 2024 22:33:52 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: aquantia: fix return value check in
 aqr107_config_mdi()
Message-ID: <3c469f3b62fe458f19dc28e005968d73392f9fa3.1728682260.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

of_property_read_u32() returns -EINVAL in case the property cannot be
found rather than -ENOENT. Fix the check to not abort probing in case
of the property being missing.

Fixes: a2e1ba275eae ("net: phy: aquantia: allow forcing order of MDI pairs")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/all/114b4c03-5d16-42ed-945d-cf78eabea12b@nvidia.com/
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 4fe757cd7dc7..49fd21d1b3c9 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -513,7 +513,7 @@ static int aqr107_config_mdi(struct phy_device *phydev)
 	ret = of_property_read_u32(np, "marvell,mdi-cfg-order", &mdi_conf);
 
 	/* Do nothing in case property "marvell,mdi-cfg-order" is not present */
-	if (ret == -ENOENT)
+	if (ret == -EINVAL)
 		return 0;
 
 	if (ret)
-- 
2.47.0


