Return-Path: <netdev+bounces-136123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32D09A0645
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809371F25E3E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40B20694A;
	Wed, 16 Oct 2024 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ISazPGXp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4720604C
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072721; cv=none; b=jWbbO3jrmRGidIKYDiIdHtjlH9t9Aw6pbPp2cnu1+pF0e4Un+p6VeIcIRtnMfb5fY3s2YLqidx/lheLtpxqpWf0fS4JRgb12Cc1IPb0Juwhh8Wz6dNF3qJFFQcScP7vmqoDyk59lu/fSQ1QE/E+vrEnNdMg4iL/4daOoo2J6DJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072721; c=relaxed/simple;
	bh=3mPTj3+0lPiRrJo64ljzJXoAPoj05NdE0sE5sy60C0Y=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GvY0/o/fSA+PQKI82UGTYhNiAuR5rIlhEmq/o+ozqlmI7u+ojyUkIp8l4XuDhGcyleIMzAGhX9bxPZcUvtfVeuYLlspC1l273l/T4KFq5G4h8duokcWKU4FfDAUVCahGkuaImLwAy1X3m0r724bavFd63QIN+wWADvOkIjwZmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ISazPGXp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jsu6yN0Veso/FpjcpusCT9cULiigOwNv6QBsOdMq/5Q=; b=ISazPGXpSrTlDsAiNBpMu348PE
	8X0I5+rwLR7kM6bBkL/McmkKESDiw07hwZkCefeX1styywZIKdBNI7MyQc89ep/18tBPFdkUZ06lN
	/v2EwcwvFYBp/9L70TYZE9162w7CIBN9LwuUJLmGmdJmTx+Lvk5ypouVM4hr5eKJEM74jM/+3tiPm
	Qqr2PLtG1yJMhlV3oHQOwWwUjw3OARe5l8psxjrRpVsUbhk641qQURgxur1bEZ9DJ2wfvAbSB2Xhy
	nHwZndimIR8kY5mP/j0kx24KMNBnc4AE8bLnKgFB+mnzI0H6tRxN+7H+pUl1gSSC2YVncIvoHXAoG
	zCzngw+A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48576 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1t10na-0004ru-21;
	Wed, 16 Oct 2024 10:58:35 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1t10na-000AWc-M6; Wed, 16 Oct 2024 10:58:34 +0100
In-Reply-To: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
References: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 3/5] net: phylink: allow mac_select_pcs() to
 remove a PCS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1t10na-000AWc-M6@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 16 Oct 2024 10:58:34 +0100

phylink has historically not permitted a PCS to be removed. An attempt
to permit this with phylink_set_pcs() resulted in comments indicating
that there was no need for this. This behaviour has been propagated
forward to the mac_select_pcs() approach as it was believed from these
comments that changing this would be NAK'd.

However, with mac_select_pcs(), it takes more code and thus complexity
to maintain this behaviour, which can - and in this case has - resulted
in a bug. If mac_select_pcs() returns NULL for a particular interface
type, but there is already a PCS in-use, then we skip the pcs_validate()
method, but continue using the old PCS. Also, it wouldn't be expected
behaviour by implementers of mac_select_pcs().

Allow this by removing this old unnecessary restriction.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 24a3144e870a..aa1139efc7e4 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1184,7 +1184,7 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 			return;
 		}
 
-		pcs_changed = pcs && pl->pcs != pcs;
+		pcs_changed = pl->pcs != pcs;
 	}
 
 	phylink_pcs_poll_stop(pl);
-- 
2.30.2


