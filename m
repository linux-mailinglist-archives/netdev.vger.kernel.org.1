Return-Path: <netdev+bounces-221258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7D5B4FEDC
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE3A1BC0DF0
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8F350D67;
	Tue,  9 Sep 2025 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ufE4PCFr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF4350827
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426845; cv=none; b=VeE7OmCxaGLXSTOTiTHCf0iWYaLf209cICV13WFFrl9fU59TXjqRnxbmKy0sW8yrzmWeEZhZPh2/rg/5H3gRj1ZFc+LcrNH78ABQF6IlLZ4rDOHBKba2e0iloZgBjv6dT5qNljc1k+u9luTrmNWXl3l9M8jHuJV4gHx4CjDAz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426845; c=relaxed/simple;
	bh=0ebuKW8MDwrK55s7b31jUWpms25WvKtdjamtA4L/7Co=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=FUdEkLnZHJaGIO6h0/zKT7oTtuIbdpc/g5THFJx0JE1bXuEPUpxLGj5pN+VAoyWGcN3/Q9u3WEGrpYgQx23agqdh/yE4v0rDQCvsQPOoi+mPJQVWyBcQVjj/eQwOHmMwXYsI1+8V4gfMIb/60S7XhQFTp7S3RewYRQZ27sUKhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ufE4PCFr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F2aXLJR4TaUQVsF6RADRNcN7KS/xPqfY1SyKejMRYbc=; b=ufE4PCFrZDCc2Bwc2iee3Qrky5
	wzZbGCM2IGa30ejWp15WagwsSN8C9lg1UqUMQcGTMO6+s//gX0t1I65UK4OFOI/2nNWb15TTHxgJI
	Y4mdijUuKV5spVzet30uPUg5YXjRRsUEbWA5kaFJvqJOdLXVaW/rZ4Khkmtis4xL72uyMs7N1VqPP
	0eFq99eEtEerY1K/D+8UYf9kjlzHfspuuw/PiQ7qChi8JM2lWqwyVXSYfOjHGXOxeL5cQJHgvFVI3
	lIvnInaqOMYTJj026JRQMCDDBM8TjuFmnGwNf0mAikEkvmpkSPGE/krNwK6e6TqMuFQAjFXV66bvY
	lKnPudiw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44612 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uvz0A-000000008Ej-2IVu;
	Tue, 09 Sep 2025 15:07:18 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uvz09-00000004G0U-3bjz;
	Tue, 09 Sep 2025 15:07:17 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] net: ethtool: handle EOPNOTSUPP from ethtool
 get_ts_info() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uvz09-00000004G0U-3bjz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 15:07:17 +0100

Network drivers sometimes return -EOPNOTSUPP from their get_ts_info()
method, and this should not cause the reporting of PHY timestamping
information to be prohibited. Handle this error code, and also
arrange for ethtool_net_get_ts_info_by_phc() to return -EOPNOTSUPP
when the method is not implemented.

This allows e.g. PHYs connected to DSA switches which support
timestamping to report their timestamping capabilities.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/ethtool/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 4f58648a27ad..92e6a681c797 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -905,7 +905,7 @@ int ethtool_net_get_ts_info_by_phc(struct net_device *dev,
 	int err;
 
 	if (!ops->get_ts_info)
-		return -ENODEV;
+		return -EOPNOTSUPP;
 
 	/* Does ptp comes from netdev */
 	ethtool_init_tsinfo(info);
@@ -973,7 +973,7 @@ int ethtool_get_ts_info_by_phc(struct net_device *dev,
 	int err;
 
 	err = ethtool_net_get_ts_info_by_phc(dev, info, hwprov_desc);
-	if (err == -ENODEV) {
+	if (err == -ENODEV || err == -EOPNOTSUPP) {
 		struct phy_device *phy;
 
 		phy = ethtool_phy_get_ts_info_by_phc(dev, info, hwprov_desc);
-- 
2.47.3


