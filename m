Return-Path: <netdev+bounces-131965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7829900CD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4530F282CA1
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1EB14D2A3;
	Fri,  4 Oct 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1sCY9fr2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0014D283
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037285; cv=none; b=Uu9D4gJzQoq8hg5V49dPxaeSCSHNP4J8uXnCIkirjld7SgS113DT7ksldzoDCX3/McUDwT0NL8atyGlx6lSCLYLaaUG6vVjh3GN+nPNBeKA6QiWPxVo6TVL39vysHq3AnL/q70q+dVaDyGsRhuhmuWb6zGWf7ZA3+GZJhjZ3Ux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037285; c=relaxed/simple;
	bh=rXxLs8dfDGQ1OqFwUzdp3lPjLiB6OjQ1z17QtfvHAf8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=niNG4AAXdO1qp8fL87sRM5+nlimOi/sVuq+FCelPPig20VzGJ05IgydKalAm0mpHl3/wDJvcM3MpgB5xMO8Hz0/v05UpmPNLzGKoFc/h5Fjva6knUk38ckT6PIe+Crilv1mEBSgA+fkDTNS/Vf/8Fs+lJufunbKHrx6MfOOngh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1sCY9fr2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JdN02JEb+tV7QDm6Q8MbssW9U6Xz9qi2FLRLvr513dc=; b=1sCY9fr2Dd7h5Z/z9PaVHnNwtG
	auhvQJWU29UYysgfCUGKIpJ8/oF4iRq92x9t3MX/iUg3PWow21LDI/2pqAYWmCRPV+CK8aqAlEhlw
	QmQpAdvJnn3Xejn68vK0gDXMpDCOd0F0ne52fMfe1tMfn0b2Cz7Ju0PusISG2Dl2/4C7Nij91LZrg
	MlDl1aXs044Gru3nlWg+aubV6fAtQV0qBW3CuPr4BF30Wjj06ozxVt34X2ySGWQlrx4fRQ8n3QmYS
	ll22eXvH6xUTXA5h0AvcL3djaHNJMAw45GnE/m+uRsjlV0mcuC4m9ptuTLTeuxuFWEllZzoWQBB4S
	1exB5ZJw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35166 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1swfQq-0001h6-2O;
	Fri, 04 Oct 2024 11:21:08 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1swfQo-006DfU-U7; Fri, 04 Oct 2024 11:21:06 +0100
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 06/13] net: pcs: xpcs: rename xpcs_get_id()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1swfQo-006DfU-U7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 04 Oct 2024 11:21:06 +0100

Rename xpcs_get_id() to xpcs_read_id() which more closely reflects
the purpose of this function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index a7f6d56183a7..db3f50f195ab 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1190,7 +1190,7 @@ static void xpcs_an_restart(struct phylink_pcs *pcs)
 	}
 }
 
-static int xpcs_get_id(struct dw_xpcs *xpcs)
+static int xpcs_read_ids(struct dw_xpcs *xpcs)
 {
 	int ret;
 	u32 id;
@@ -1405,7 +1405,7 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 		xpcs->info = *info;
 	}
 
-	ret = xpcs_get_id(xpcs);
+	ret = xpcs_read_ids(xpcs);
 	if (ret < 0)
 		return ret;
 
-- 
2.30.2


