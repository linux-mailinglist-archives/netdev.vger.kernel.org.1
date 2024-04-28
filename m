Return-Path: <netdev+bounces-92008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C6F8B4C45
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA341B20E3A
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FF2548F8;
	Sun, 28 Apr 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OSGqotOb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAEC53E28
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714315872; cv=none; b=ivxbCc6aIiRsd95ssqx1c9gv3iBpC2loC4MEimgrygx7qADPHhqzq9HypaVdqNlOpTK7t+A2FSsrowiX81RifqCKib9HBxYdNIkTbXyfySpn+M7vhnWajN/3QSH2hkTysykgGuEh/dPO8tHSy49rFvGdI6Y4LT+JP5VuOZjc4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714315872; c=relaxed/simple;
	bh=B1fYSxGmY6v7GvLr+qlADrNUpQoByYEROo8/l6Qxydw=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=ReLOaZUg88iIXmcB7MSTvjUUdxPscFMztOQ0NWV/9G7sF61h6q+8VCUDnOmmLp54PidKFkvozkBrzqMt+2wl420s1XEHpSfn/ZUbRgiZLSsE2LD0z+gmgV4ntDWK+d3qYvt+/x0vLMRkOdxIX8CvyWwtUblxjMtknKlVuvG4IpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OSGqotOb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZIKerauIPl9plpm1cqiooQkRjSzlJKwXTdvJIyLpCqA=; b=OSGqotObviaMT2zVJXrEIxf71U
	mh90XMliFhu5g94dXdaO7rCXZ/Nacwa+Xkz0KSg3q1nP/T4tF/33SqmjyMXiAzoBwCbj59F76RHRA
	TjoUTjcehakwNfGuHHWPpmXfnGF9yEnhVUPCsB2r7nOPInP0BiGqdlwh6oYM/TWfy0hTn5KLE0Q/n
	Co7/lpSBgNqHa6wc3C+BZy0fPoAarIjpK0plfMVbUwyMqtXvXdQB0CAZ3+BfYfvpTl6O8CQClVmWm
	id+W/VhuCrS62lh2WvWKllsKrMKUteoq4Ecmo9MwnQRYnNzSNmlIfzxh0kwtJ6leVb57WfWJOBn60
	Q0HoA5QQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47944 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s15ro-0002FQ-24;
	Sun, 28 Apr 2024 15:51:00 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s15rq-00AHye-22; Sun, 28 Apr 2024 15:51:02 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: phylink: add debug print for empty
 posssible_interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s15rq-00AHye-22@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 28 Apr 2024 15:51:02 +0100

Add a debugging print in phylink_validate_phy() when we detect that the
PHY has not supplied a possible_interfaces bitmap.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0e692a3bcf1a..b7e5c669dc8e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1838,6 +1838,9 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 					     interfaces);
 	}
 
+	phylink_dbg(pl, "PHY %s doesn't supply possible interfaces\n",
+		    phydev_name(phy));
+
 	/* Check whether we would use rate matching for the proposed interface
 	 * mode.
 	 */
-- 
2.30.2


