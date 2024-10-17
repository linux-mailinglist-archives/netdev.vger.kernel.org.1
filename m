Return-Path: <netdev+bounces-136561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE029A2178
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5264A28933A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E281DCB3A;
	Thu, 17 Oct 2024 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zc+JYEi+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404B1DB956
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165975; cv=none; b=kVj++tG0x7YJVvvINwXYb1FgJlQYFi76qrD3XxdEV0Ur9sNR0wb6BJdoZdj2ubWMpNJC/xS/hvxMXEZCscMPWMmV7BBgLu9jzjNWbSU0mlLqqaoNc1E3ruhvuRnbw4ZZ1L1bUjseaLPB04DtmV7Ey9R7P4rGgWgO66Qo0X24T0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165975; c=relaxed/simple;
	bh=TL49y/TR5+EYAOIxfkdBWRzy+e1WY9PzLKRCQzGM5EQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=c1QHo5hycHX7NeFBToMezzQeAH1TDI/1tsdCsad7jSgpA2836HIK1IJwKUc19CFa3U1wYCbWtWHboSy+r35BVlH9jQ5u41cUGap2xRiLLJRsEawLvdKYw/CkfMWQ4AvPouSiJHdrTxNTCxWYjh66ieOXCu2BfYA2AXAOwuJB6jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zc+JYEi+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=805ShzfSqoaYD3ydJf7H6BNZ145Fu0Juhpo7gfaE7+c=; b=zc+JYEi++gFzR/yFw+wvBE8swT
	PiKRsu1Khi/fL/fl2Kj5F0OaXw7xQe4W3vAEyxV8vmR0rJPJR5lfYH445KnRpVhJAKyP+fJSQl3nS
	g1IokeBG7gC3KOL37t6NPrPWwdNO8bTsXU23Q5AjaLAvCq1YeTGTGdrhSD3Za2dvR36mpZUDUq6Y2
	aWzBa5Rv61/kRda3wpojVP4plLC2A1hrnBGEsWLhD35e52K/ixi4WEr73Vhffy/0YZDGqIRCdMhYa
	xt61ceZkvGBhpEIFQLtoTNDab+32N0t3Pf1lXvaWbMQjCEZjIwE/5zonxIaxldd/yNTVrYmn/UTWr
	k4x9bXug==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37942 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t1P3c-0006Uk-1s;
	Thu, 17 Oct 2024 12:52:45 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t1P3c-000EK3-J7; Thu, 17 Oct 2024 12:52:44 +0100
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
Subject: [PATCH net-next 2/7] net: pcs: xpcs: remove switch() in
 xpcs_link_up_1000basex()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t1P3c-000EK3-J7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 17 Oct 2024 12:52:44 +0100

Remove an unnecessary switch() statement in xpcs_link_up_1000basex().
The only value this switch statement is interested in is SPEED_1000,
all other values lead to an error. Replace this with a simple if()
statement.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index a5e2d93db285..183df8f8c50f 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1127,18 +1127,13 @@ static void xpcs_link_up_1000basex(struct dw_xpcs *xpcs, unsigned int neg_mode,
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 		return;
 
-	switch (speed) {
-	case SPEED_1000:
-		val = BMCR_SPEED1000;
-		break;
-	case SPEED_100:
-	case SPEED_10:
-	default:
-		dev_err(&xpcs->mdiodev->dev, "%s: speed = %d\n",
+	if (speed != SPEED_1000) {
+		dev_err(&xpcs->mdiodev->dev, "%s: speed %dMbps not supported\n",
 			__func__, speed);
 		return;
 	}
 
+	val = BMCR_SPEED1000;
 	if (duplex == DUPLEX_FULL)
 		val |= BMCR_FULLDPLX;
 	else
-- 
2.30.2


