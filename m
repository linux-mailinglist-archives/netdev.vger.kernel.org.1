Return-Path: <netdev+bounces-149339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3169E52CF
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDA2188348C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88C1D9A5E;
	Thu,  5 Dec 2024 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VhHtZhCf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738F1D63F6
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395344; cv=none; b=AMUmlbeOzEobsAq6zXLbEEw8N7YPoVEIWjSHmWbiLw0xo4l7knCb6WB3raxond2iJpQAY0QLCK2beoZHLqnwqeyLM0tFefGj7BD6Y3A3rvNLWFGcd06lCN3bF+NpGLG19tMaSSQ6gxn6dt5p9X935BIwXErJRMwou90/KaXV3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395344; c=relaxed/simple;
	bh=If5CEiscpSSnerTj3HQG3qiYgzKduwSAoFYNnnNGzFY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=OIHAdu9puDe9JvLRizqvEftcrHScnUIYip1aJlpjMOSutavZQW01u0IB57GF4DI1SKtNG70POs3/dDXYnf7phu8Mkfm8byPLYWmoRu4aDkKcfeKQ6fuDYtFTSj2DzM6p8UyHsYNPmwQUwFfNwP0H1I9+sTdqgtFWDJ+c3GiGnoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VhHtZhCf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4mVAStoeww+80tjg0oRnlyJatdgjJTLndYhYks6cvcI=; b=VhHtZhCf/ysX5zBquWa3mUU0sa
	lapdAJnu1c6sR/g7uv1/E6x/lUf7EsOC6uA1w53+L+q71NXLEx0C7ltAE13Isr/VvFd1NGJEwDHHF
	Rq5G2d/P40UU55c8rryFNSJlMQLUyGSGxLJji7JBD1mHiBMuF1lRmedn6CG1eN1FhYMNNTkQc7VGf
	Fsjb1MDa8PCRthkaX70pYYzacQz5jXtclByYxzEVIcLDU8ZSFvcVza1uKxAV1O//eniJ9yB22ov2+
	2K61b9ZCeldZCvSqe577X1MFhd9+t/U1SvUosiabfI8vg5bzCsa7bLJUjfNV+jqed2mlbu1ar21fu
	ou6a0xQw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57676 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tJ9JJ-0004a7-14;
	Thu, 05 Dec 2024 10:42:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tJ9JH-006LIz-SO; Thu, 05 Dec 2024 10:42:15 +0000
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
Subject: [PATCH net-next 4/4] net: phy: update phy_ethtool_get_eee()
 documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tJ9JH-006LIz-SO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 05 Dec 2024 10:42:15 +0000

Update the phy_ethtool_get_eee() documentation to make it clear that
all members of struct ethtool_keee are written by this function.

keee.supported, keee.advertised, keee.lp_advertised and keee.eee_active
are all written by genphy_c45_ethtool_get_eee().

keee.tx_lpi_timer, keee.tx_lpi_enabled and keee.eee_enabled are all
written by eeecfg_to_eee().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4cf344254237..e4b04cdaa995 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1701,8 +1701,8 @@ EXPORT_SYMBOL(phy_get_eee_err);
  * @phydev: target phy_device struct
  * @data: ethtool_keee data
  *
- * Description: reports the Supported/Advertisement/LP Advertisement
- * capabilities, etc.
+ * Description: get the current EEE settings, filling in all members of
+ * @data.
  */
 int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data)
 {
-- 
2.30.2


