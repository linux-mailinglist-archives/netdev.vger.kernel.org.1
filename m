Return-Path: <netdev+bounces-150706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AA59EB338
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B9F162312
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44201B2190;
	Tue, 10 Dec 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="clLNwCGf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E401AA1FD
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840812; cv=none; b=WLP9ZWhXE6SbJM9OXRJGdUk0T9yWxB6KDpLsyVWqnS8OER0SSpKFXaT2MFioqZmwrRsFRYglFnEuHDMbyiS+7xj+hdGvd6neu4FZaI3gOx5lKAwd52AMjNg0TmbN+7RfTfQTqbD21QwvfVNNG0ty+fjaJO7uZAXIbMVtimN3JDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840812; c=relaxed/simple;
	bh=kSiA94ParQtd16g2J/Kqqgn323ohU2UmPfI21Z+U53g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Ig/TVSUVUUSqkVzO4U+DN31oa4/S78kAUvAV3sd++nV4kS4DNUQtYM8mByNDLPW65ER3bd8pTudPGC5P+hkHnZxL0bRQkD3tWwYfHvbYwOYH7RAECYQynxVyWfCxNCJvcXlo8U9GgMS4eSzwRe4Q57NGIxbUoTV4Oky39PVVUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=clLNwCGf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G8t1xaI1/GugJIK8OBprVbaU/A8jM/gJsPmAeiSAzxc=; b=clLNwCGfyp0oG0TR9gNUeWxtyk
	O/sqKL9Nnwn2JsaJYTOVv5Yi4rQFnRjbCtmhmqV3H81dEzXZ+98JQOq/qhYPsUz0bF2esFejz50Kh
	ofsUKa13GTz84FEsBZMo8XaPRlcR2Ujh2ikHIHsfccfIpMqAdT5f3CawMAxTvMoQrq5XXooasDBki
	zw/2An9fRPKKn8ZJliJ3JEc01rqy7AmnIhwMcXKCIMWKAHTRaz4yte7Z+PBrn/jRMgjBCQGVxtvh6
	dHZMojHN9cDWx3X4VXNph+cuIjANb3hdxSUTBgssE6ucCd/G2r2egpJ2TjmdueEc4fLEgvDli2qrD
	atJzBSYw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57170 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL1CI-0002ZH-2C;
	Tue, 10 Dec 2024 14:26:47 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL1CH-006cne-6W; Tue, 10 Dec 2024 14:26:45 +0000
In-Reply-To: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
References: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH RFC net-next 7/7] net: dsa: remove get_mac_eee() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL1CH-006cne-6W@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:26:45 +0000

The get_mac_eee() is no longer called by the core DSA code, nor are
there any implementations of this method. Remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/net/dsa.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 4aeedb296d67..9640d5c67f56 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -991,8 +991,6 @@ struct dsa_switch_ops {
 	bool	(*support_eee)(struct dsa_switch *ds, int port);
 	int	(*set_mac_eee)(struct dsa_switch *ds, int port,
 			       struct ethtool_keee *e);
-	int	(*get_mac_eee)(struct dsa_switch *ds, int port,
-			       struct ethtool_keee *e);
 
 	/* EEPROM access */
 	int	(*get_eeprom_len)(struct dsa_switch *ds);
-- 
2.30.2


