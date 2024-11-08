Return-Path: <netdev+bounces-143338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D659C217D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE719B26058
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B212CDA5;
	Fri,  8 Nov 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w2RDNjH2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CC192D97
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081715; cv=none; b=iCU4Hgk7pR+PyIJNfk81FtZVcgi2OtBip3eJPWWn4VHfDaJN6oFY+8nGeUjeR8dFsA2fBfwUOGtgPgAXHYoDzMtHTjBYIMrXi1eEJOG7tLjMTTUyXeIVnU6IkS2Qzc9Sp1JZtr7btHQqgLktOzyxiX1C42uc1uWnchRTMRQu/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081715; c=relaxed/simple;
	bh=c3IpJ8VLxHxHOxP51+ncFhrxjtID1JCjTjChhmgJA44=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=BUFLjqvTcodyuyHFKb558K02d/SvyUtThAiSq+ViM0dnb9SQ48imHr6h44wNnhK0y4p2daX6DgKsra4qnEqgPqYtm7pMAo0C/Z+ms38ycDKq3wbOe3ZZiOPEutRk+mox1ina12pAftdLY4et1eyi+6HoLLgBQVItUnVoxFUJ0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w2RDNjH2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CP3SEjZw+v8mnTM4rmEL4bvAAKffwmdtGagp8ebDSAk=; b=w2RDNjH2GK60gaH3RtC3qrO4pP
	Xnv/jNuZUFQvNwkpcIiMqcgZR34cCfjd5kNAScEfYooRnJnAbXSt+IMmQfoxpux0dZPXwbEzVcnt1
	ad3U6TlfsG05VjSGrSEtKpq28IbtcQnG2QpqfJlAMBueRPQ2Qt58VbVbwXDlIzFV4OJi2a6jeLH1b
	IFmtmZL3OdkrbAIq+Ztr1slc3kWhLTZaWZ9Km1EZ+cLEX7EqW6mOtkIrcVpg9VRAeeZh0ZGfpOb8y
	SKM8MGx2uvXRpmGv/rYNEAoXW3tO/NB7HR0NkuhoVf7UvypqYNmApVIDR4DddsO6MOQ9O68iXeI1Y
	iwA+fPQg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60872 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t9RQj-0005a0-1p;
	Fri, 08 Nov 2024 16:01:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t9RQk-002Fen-1A; Fri, 08 Nov 2024 16:01:50 +0000
In-Reply-To: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
References: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/5] net: phylink: move MLO_AN_FIXED resolve handling
 to if() statement
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t9RQk-002Fen-1A@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Nov 2024 16:01:50 +0000

The switch() statement doesn't sit very well with the preceeding if()
statements, and results in excessive indentation that spoils code
readability. Begin cleaning this up by converting the MLO_AN_FIXED case
to an if() statement.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 65e81ef2225d..bb20ae5674e5 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1463,6 +1463,9 @@ static void phylink_resolve(struct work_struct *w)
 	} else if (pl->mac_link_dropped) {
 		link_state.link = false;
 		retrigger = true;
+	} else if (pl->cur_link_an_mode == MLO_AN_FIXED) {
+		phylink_get_fixed_state(pl, &link_state);
+		mac_config = link_state.link;
 	} else {
 		switch (pl->cur_link_an_mode) {
 		case MLO_AN_PHY:
@@ -1470,11 +1473,6 @@ static void phylink_resolve(struct work_struct *w)
 			mac_config = link_state.link;
 			break;
 
-		case MLO_AN_FIXED:
-			phylink_get_fixed_state(pl, &link_state);
-			mac_config = link_state.link;
-			break;
-
 		case MLO_AN_INBAND:
 			phylink_mac_pcs_get_state(pl, &link_state);
 
-- 
2.30.2


