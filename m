Return-Path: <netdev+bounces-222184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0EB53603
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA67D1B203F7
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2A326A1BE;
	Thu, 11 Sep 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bY2Z5efy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BFC34164F
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601802; cv=none; b=YffC8ATsv/sAAqJYWNMue+ETdt2JYuLLD27ObSrbWqnx5OyLcpKpyHIBOjJyv6zCAD06Z4txWQVSSrELS2AE5Re6NLcBOXqVO0V+mKVDVFSGVGaNjhktNzMRw4gzoCRikbmlJJ8UXSHsHQRNdzF8ijUcxN9ntpCmg7fspgrI67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601802; c=relaxed/simple;
	bh=Rft91jJnOO12qJV8wnWgSdUpkz+3VO62acnp2/r+eZY=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=tsRHPFkOX/fU/Qmfx2xJzd3BreybUJEdL8Z3JdDoSshAkzrEQblVyAPNSP09b/LfHZQcLpf8tLq+bvW7sAE9AYn1AH2V1zgwe/H7s+F8j+wqDIINdVNvIBqeupEELvadrMrVEzxIC9K2Vqvy6ypy+P4MeSM6orlUHCOi1c424Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bY2Z5efy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I+xGih9jPn+BRxNv2iB2kjv+BHRoQDNSbZQx9OEqWK4=; b=bY2Z5efyVoW0R2dsiXqGiumBfC
	TNACPC3ytmnARsy7pKNjUhc/RigBGfA2zGWZg50jnswJKfRGwe9kseTKou50Vz97Kl6XYTlSxGdqx
	sttgf8me2dLvPJDh8zevUy+LkLv8vIZABpzmnbCSvgK+90sXzXSFMNNHJmzNt/OwN7+vmqZ1eNU7a
	QM3g+MjXK/HkSNEJ05+wjudqbiP16OQEfSwaIhNJOlTbGQ8/83rA2CsObkyKxkjRsd90XFkoLFhhP
	M/kdsrwkgWsZ9QIaCrtJc2SJyK148jeRXXF/nY3cAmAC2zEW7mQAnySbOlNTvnu/36aKoxzCx3eoj
	HNelvA6A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51450 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uwiW4-000000003DH-1zz2;
	Thu, 11 Sep 2025 15:43:16 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uwiW3-00000004jRF-3CnC;
	Thu, 11 Sep 2025 15:43:15 +0100
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
Message-Id: <E1uwiW3-00000004jRF-3CnC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 11 Sep 2025 15:43:15 +0100

Network drivers sometimes return -EOPNOTSUPP from their get_ts_info()
method, and this should not cause the reporting of PHY timestamping
information to be prohibited. Handle this error code, and also
arrange for ethtool_net_get_ts_info_by_phc() to return -EOPNOTSUPP
when the method is not implemented.

This allows e.g. PHYs connected to DSA switches which support
timestamping to report their timestamping capabilities.

Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
--
v2: add Fixes: tag
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


