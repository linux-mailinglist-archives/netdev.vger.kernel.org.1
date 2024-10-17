Return-Path: <netdev+bounces-136565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E1B9A2180
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EF528931C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E5F1DA113;
	Thu, 17 Oct 2024 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pEV95E5W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA61D3647
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165995; cv=none; b=oPj82wYhKFrtJb6b23eCYCqrNVMh3/DqqNZzIxobCECB2uBZhdxFEUSS9pIBXwEQyLSL/yR93SV/Ff6ek5NXRJ671XCRBP+WR8K3WsIL9RfwTnv8JMg53fyWGeSlNnqoF295f41iJBAqMM6kFNw1EunBbLOmWXLv/5FabPy82DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165995; c=relaxed/simple;
	bh=QaXTDL/x2BiaZXOv6kW1i5Mdtl5vC7K//yip5z6+Hkg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Rmzk4dJY2WPmhvkDEsIXx+VVJnOogEiAre6nOVC4pG/PTTW0GULzgrSR1S+wCKjbKKwf+RKvXy43DbO1C8WiLErUIlF0uyPFQqXXRT4w7V5sXseYIla84fd3tuIO3Pofvsbgj9Ra2HIcjYO+W11ApTFieBRFMYTcLOCdIT+YW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pEV95E5W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XEFcEKZY7Ie7CSKsWvGpMF/K9g5xtBfE5FLM83qpORw=; b=pEV95E5WFxoy52RAPTcTMGKqu9
	Q2pr9ibKmF9/YBrIDGogCht2i2ew4EVe53b98sxN3Q/7prj+HkrvraLt/Kkk2DMPncR9qNIfBHXro
	5w5c6IfblHnTpR5MikCyy8VNjwzGHjSPmwr5QJoBxDXTVTXfUXBhuu7q0zpHyJNDpF9M3H/JwQeqK
	7vXOpvSEKVS+640DhW6l7yoEvj7ti/FnRfDZMAbAV7wJNxwVlMqfyQFn9jFcGosTmFWjd7Vy9ElYR
	ThUx8xgYYkWSWFGMQCYbUS1QxT34Z2Dd9l/0ZIkfxYXMeOXLUxY1wnhTPq/T3kRSt6BDaNzyd59/Q
	F9i7fHcg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40522 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t1P3x-0006Va-07;
	Thu, 17 Oct 2024 12:53:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t1P3x-000EKX-1w; Thu, 17 Oct 2024 12:53:05 +0100
In-Reply-To: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
References: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 6/7] net: pcs: xpcs: rename xpcs_config_usxgmii()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t1P3x-000EKX-1w@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 17 Oct 2024 12:53:05 +0100

xpcs_config_usxgmii() is only called from the xpcs_link_up() method, so
let's name it similarly to the SGMII and 1000BASEX functions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 6cc658f8366c..89ceedc0f18b 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -311,7 +311,7 @@ static int xpcs_read_fault_c73(struct dw_xpcs *xpcs,
 	return 0;
 }
 
-static void xpcs_config_usxgmii(struct dw_xpcs *xpcs, int speed)
+static void xpcs_link_up_usxgmii(struct dw_xpcs *xpcs, int speed)
 {
 	int ret, speed_sel;
 
@@ -1141,7 +1141,7 @@ static void xpcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
 
 	if (interface == PHY_INTERFACE_MODE_USXGMII)
-		return xpcs_config_usxgmii(xpcs, speed);
+		return xpcs_link_up_usxgmii(xpcs, speed);
 
 	if (interface == PHY_INTERFACE_MODE_SGMII ||
 	    interface == PHY_INTERFACE_MODE_1000BASEX)
-- 
2.30.2


