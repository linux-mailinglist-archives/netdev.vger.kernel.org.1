Return-Path: <netdev+bounces-284835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO5PFec/+2nTYQMAu9opvQ
	(envelope-from <netdev+bounces-284835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:19:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9424DAE0E
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9D2A300274E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4C14657CC;
	Wed,  6 May 2026 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3oARnPBY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8C466B5D
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073308; cv=none; b=lf6KyXm0YU2CmCxRJFe5SQZE6CvcNkbfaYJDdIqrMB6fn3XjLQUho3oKpeQxpmDV+XoxGDQ2L6hePz3gmv4aiyMpqLCQkCkuELzgFJysXz3e/ZmFqBLXTukTRx6oUH8v53yXLFqxCfaLC6MLrtAW7aXgCl/C4v9TuBMy+4WFSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073308; c=relaxed/simple;
	bh=uhlvBHBEsSJPAcugSTKHQXub6ODMuHhfUaUGppSSoXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeZvpsd3MxWTcP0IptGi7FOnjAv3jTbTsvml9Tk5Fo5/fdBwg1QfNtPBA9h5Vv3tsG+bdKmI3VZcS6jFtXojA1cEPNu3loGvO7Ir6AqHZRhssqOT+7T4cn/fuhV8orkbQo1uc08sQPkK7/4JoyyZBHNvbYv2+w84A/vCpE5tL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3oARnPBY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U1Sjflo8J81hRRHhJZ+A7NOVh8ubvCNRRZyjAypgCLc=; b=3oARnPBY70bmjXzO8SDZqgK1xo
	dkYh5iDr+LIRAKAQfEHwORcqfhMePoDlaEqFAd49bZ5e3kjo7ghg838OfMGY8FDPZIW9YT7WNrGr6
	xFJAItrj5WjGc5FBXeCwEUicpSndXT79V2wIkgpSBB/3iC1d8G0I9wM0W24OSNUc1nfI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKc5h-001dmr-1o; Wed, 06 May 2026 15:15:05 +0200
Date: Wed, 6 May 2026 15:15:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Message-ID: <62b15f5f-c9db-4443-b0ee-ac7044459c08@lunn.ch>
References: <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
 <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
X-Rspamd-Queue-Id: AA9424DAE0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-284835-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> [    2.339481] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): can't attach PHY to usb-001:003, error -EINVAL

static int lan78xx_phy_init(struct lan78xx_net *dev)
{
...

       ret = phylink_connect_phy(dev->phylink, phydev);
        if (ret) {
                netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",
                           dev->mdiobus->id, ERR_PTR(ret));
                goto phylink_uninit;
        }

This is the error message we see.

phylink_uninit:
        lan78xx_phy_uninit(dev);

        return ret;
}

and

static void lan78xx_phy_uninit(struct lan78xx_net *dev)
{
        if (dev->phylink) {
                phylink_disconnect_phy(dev->phylink);
                phylink_destroy(dev->phylink);
                dev->phylink = NULL;
        }
}

We see the error message because phylink_connect_phy() failed. If
connect failed, you should not call disconnect.

The general pattern in Linux is that you undo what went correctly at
the end of the function.

Please try this patch.

       Andrew

From ea55645b23092a0de7aa3ab0eaf7bcb73a7fb0e1 Mon Sep 17 00:00:00 2001
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 6 May 2026 08:10:29 -0500
Subject: [PATCH] net: usb: lan78xx: Fix cleanup in lan78xx_phy_init

If phylink_connect_phy() fails, phylink_disconnect() should not be
called. Rather than use lan78xx_phy_uninit() which does too much, add
the cleanup at the end of the function and only undo what was
successfully done.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/lan78xx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index bcf293ea1bd3..9cfc122d76ef 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2842,7 +2842,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 	ret = lan78xx_mac_prepare_for_phy(dev);
 	if (ret < 0)
-		goto phylink_uninit;
+		goto destroy_phylink;
 
 	/* If no PHY is found, set up a fixed link. It is very specific to
 	 * the LAN7801 and is used in special cases like EVB-KSZ9897-1 where
@@ -2852,7 +2852,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	if (!phydev) {
 		ret = lan78xx_set_fixed_link(dev);
 		if (ret < 0)
-			goto phylink_uninit;
+			goto destroy_phylink;
 
 		/* No PHY found, so set up a fixed link and return early.
 		 * No need to configure PHY IRQ or attach to phylink.
@@ -2871,17 +2871,19 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	if (ret) {
 		netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",
 			   dev->mdiobus->id, ERR_PTR(ret));
-		goto phylink_uninit;
+		goto destroy_phylink;
 	}
 
 	ret = lan78xx_configure_leds_from_dt(dev, phydev);
 	if (ret < 0)
-		goto phylink_uninit;
+		goto disconnect_phylink;
 
 	return 0;
 
-phylink_uninit:
-	lan78xx_phy_uninit(dev);
+disconnect_phylink:
+	phylink_disconnect_phy(dev->phylink);
+destroy_phylink:
+	phylink_destroy(dev->phylink);
 
 	return ret;
 }
-- 
2.53.0


