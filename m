Return-Path: <netdev+bounces-148570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29559E2364
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAF6168118
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF01F76CD;
	Tue,  3 Dec 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qCiXREat"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887191F76CA
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239876; cv=none; b=g9wHcMtK7wo6/yp+bmGUu+dTEceirpRRT2DB+auTipV+jte68Nzqm84VtutM150YSWp7qwhhMaiXkoMB4yrgp2Ka3XctS/o4ON5C+E51hvvUgy78WFtloPpTNqeUjLMQzPE05k+MUlIMk7FOIto1up1QtiqBK9shddn1+ZYI/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239876; c=relaxed/simple;
	bh=ggOAYLrx6dRRXre16Ap/6FbtuWpULhqcvCyGdrWifuM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JIw3X3kuk7ZudNLvlaAgSq2Wtioi3OeSGr/ISQp1Wyi1m9mcJPyYaOUoF8liJtT94RYV82SMx8a8sQGxGcvCDCZ5ZP8Bez3ceDV6Qd9bCZ3TcyvSsTpdb+mYCLkjmyECPpo/vOgz4GdFbuvLgPUop/pLV9OPHvZ5gcpYUo57P2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qCiXREat; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HSme3fNnUgavlqamh3mJ19u/nSxv+0I/LQtWvlO12Bo=; b=qCiXREat8PWVvuvcIPW4coH+aR
	UK67+22StdGkjfpHX9NhPwExsbC1uAqHyCP2RAS50gyYLzhFz365LThYCoHaLIS4Bra/lh1YMzQoY
	wjT5W39x3yMIP9DTDt063U2y10aon+s3knxpO2XReD33+BVhi6ZyUDNK7NwP5xkPewv+R3Aw/SSlQ
	BQTB7NwkeUcA6gmMoGQ9GZ5mxeZEGns+C1wSBlPDnSuHNtkTyVlxLiBOtRbFE/fX8ijVwxN0kpy6G
	tho7czNZS3qgHDSZj+tupCHgqQjtjErYNewql/PGN3O8XhIHLltESFy+NU6ZL/BP5uGFIylkyjnRQ
	Qr6Yra8A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59288 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUrk-00028H-2l;
	Tue, 03 Dec 2024 15:31:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUrj-006IU6-ON; Tue, 03 Dec 2024 15:31:07 +0000
In-Reply-To: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
References: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 05/13] net: phy: bcm84881: implement
 phy_inband_caps() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tIUrj-006IU6-ON@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:31:07 +0000

BCM84881 has no support for inband signalling, so this is a trivial
implementation that returns no support for inband.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/bcm84881.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index 97da3aee4942..47405bded677 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -235,11 +235,21 @@ static int bcm84881_read_status(struct phy_device *phydev)
 	return genphy_c45_read_mdix(phydev);
 }
 
+/* The Broadcom BCM84881 in the Methode DM7052 is unable to provide a SGMII
+ * or 802.3z control word, so inband will not work.
+ */
+static unsigned int bcm84881_inband_caps(struct phy_device *phydev,
+					 phy_interface_t interface)
+{
+	return LINK_INBAND_DISABLE;
+}
+
 static struct phy_driver bcm84881_drivers[] = {
 	{
 		.phy_id		= 0xae025150,
 		.phy_id_mask	= 0xfffffff0,
 		.name		= "Broadcom BCM84881",
+		.inband_caps	= bcm84881_inband_caps,
 		.config_init	= bcm84881_config_init,
 		.probe		= bcm84881_probe,
 		.get_features	= bcm84881_get_features,
-- 
2.30.2


