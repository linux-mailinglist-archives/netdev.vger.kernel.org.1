Return-Path: <netdev+bounces-149337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6CC9E52BB
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5869F2826DA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70906206F2E;
	Thu,  5 Dec 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CI/AzBuO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364DB1D9595
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395333; cv=none; b=hh4xm+L55j07hf7qAvZ2aXwsQCo1WsyT4d1u0rbdQVvwMNGQuVycDsGgtMZJwqfSwnPnVwXK5wfBjdpGTL/tUgqEqoG76pBbBki0VIcHkswka7kYwV+H2t6nDR0bNZQzzhKb1QSZ0NwNN7gFRN6BenvVIbTC7A9obBgvwOoDqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395333; c=relaxed/simple;
	bh=R/qrYV9kZf2UteVW2o8IyFtTzUcfSr8/H9X4KQ6+5bQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ixH+6CcWq0LGF2umWjtnqF7dPqqjNDYCTDJjGt2ee+ev5uGDam+Al0ufvmp0J74mga5KsPxTp3iPi9GOytDxJ83O8ENent7QoEk71N0zczOfOvaBUguI3lSKgU1S4Y1MjpqkzVp/0QteeuWjQVUT+1BsuELRW0vYEhrzNVgSKAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CI/AzBuO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pQ1MXfPXQhanrVcmJnPAK+U2MoO2zVEDG8Tfvkbzfc8=; b=CI/AzBuObEyXSWCLSBAyTY8x6M
	sEGmN68l0cikEcc5YOC0AV138pzDAx5AdL9Bbrm98dYgMnQbnTLupCC7KrpYpaNQcfX6PyniRVg64
	KJW3EaqZl8Y0lj53lBl8ydRnmA293KzeORqX1IfLfKYN0AwomgWv6mHxVO+MWWi5iKU+jn/ekvpkA
	Yp/gI0R3fx0KmrdrRKg2dvDY48eQr0NndqJh8JufJARydQLLp6K8ctB0NMbHnDVGTGp+EngRXaVOn
	MDPWewGdIg2ErVenu0D6hpgKwoZhZvAECnhWpUkZRnwmU6aSUIRlVWwsflMcT57DYUQPB0Xg/Qeof
	ihnmnBvA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46320 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tJ9J8-0004Zg-2V;
	Thu, 05 Dec 2024 10:42:07 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tJ9J7-006LIn-Jr; Thu, 05 Dec 2024 10:42:05 +0000
In-Reply-To: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
References: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/4] net: phy: avoid genphy_c45_ethtool_get_eee()
 setting eee_enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tJ9J7-006LIn-Jr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 05 Dec 2024 10:42:05 +0000

genphy_c45_ethtool_get_eee() is only called from phy_ethtool_get_eee(),
which then calls eeecfg_to_eee(). eeecfg_to_eee() will overwrite
keee.eee_enabled, so there's no point setting keee.eee_enabled in
genphy_c45_ethtool_get_eee(). Remove this assignment.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy-c45.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 944ae98ad110..d162f78bc68d 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1521,15 +1521,13 @@ EXPORT_SYMBOL(genphy_c45_eee_is_active);
 int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data)
 {
-	bool is_enabled;
 	int ret;
 
 	ret = genphy_c45_eee_is_active(phydev, data->advertised,
-				       data->lp_advertised, &is_enabled);
+				       data->lp_advertised, NULL);
 	if (ret < 0)
 		return ret;
 
-	data->eee_enabled = is_enabled;
 	data->eee_active = phydev->eee_active;
 	linkmode_copy(data->supported, phydev->supported_eee);
 
-- 
2.30.2


