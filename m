Return-Path: <netdev+bounces-131969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60F09900D6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0583D1C23C43
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BF014E2DA;
	Fri,  4 Oct 2024 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wc6uvFeC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A214F9D7
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037304; cv=none; b=aWIwub2kuUQQbWQwo5eilAvtRqihG7JFI85NnaIPDEjVVAssoz5kyKYIgib9j0kkxpsZ6xQWIBzompzV5cUB1lw+e0QupznitkZN6ha0rpW7iN1KnlhLCD3a0GR37gN0LnGChRMxzTj9UBo5Eqyno54T1mMHiDvD59K26vEQs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037304; c=relaxed/simple;
	bh=kFg5ZJmjXTijQFSiEhwwEM8CpSjvLbF1eUEkt7s+/aE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=N39mZVeg9uOAy2jYRrIWF808VFwV1Gs9ROZCSUr58wNlSX38PBPY1tNl2kyWbV01XRnYx7V0f5noKTYeRF84mn8wQZ2l5ziKLrQGgKNQeUfOG2OY0lf94M0KpamidOKMaB6Z7gVIbGSGAIIlzJrEcK88J+aHvRgSmWwI+9QoETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wc6uvFeC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=btihpCL0vUh1N7+vGVV6qF1UsDzMDCL36GJO4Y2gy+Y=; b=wc6uvFeCMjSi9nKAvG9zyLmnnd
	/II+7rH8cSHKbjwufJqlw6rsxakwSrS9ApcP9Ua5y78fjLI90z9TDNVfTjXRk80o1uMOyOo1Vbf5a
	ZatVuK48pu0iCJFWJXn1WTOJ9TAGkgCR3+XNxkEFhhWdAaL5KVv2GGNWsxmEzFn4fmKYXcKqs2jDT
	0FX2WCZaoIgdW0XQKZ1dv2BFr4cOF2qqn6iYgy2uj0UYoXOcvQftlSufFSJ1Uz40nidJK/ycPYM90
	Y57hnv1qDrqeoEE5I4Yrn+/NXTtiDe1izFaOZDNN1sG3KPqmpvSiHrWeK2dA8IkErn5AtSJ6fGBJh
	K2hzJvEg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45040 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1swfRB-0001iW-2E;
	Fri, 04 Oct 2024 11:21:29 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1swfR9-006Dfs-Ee; Fri, 04 Oct 2024 11:21:27 +0100
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
Subject: [PATCH net-next 10/13] net: pcs: xpcs: convert to use
 read_poll_timeout()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1swfR9-006Dfs-Ee@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 04 Oct 2024 11:21:27 +0100

Convert the xpcs driver to use read_poll_timeout() when waiting for
reset to complete, rather than open-coding this.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 5ac8262ac264..06a495135418 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -220,18 +220,15 @@ static int xpcs_modify_vpcs(struct dw_xpcs *xpcs, int reg, u16 mask, u16 val)
 
 static int xpcs_poll_reset(struct dw_xpcs *xpcs, int dev)
 {
-	/* Poll until the reset bit clears (50ms per retry == 0.6 sec) */
-	unsigned int retries = 12;
-	int ret;
+	int ret, val;
 
-	do {
-		msleep(50);
-		ret = xpcs_read(xpcs, dev, MDIO_CTRL1);
-		if (ret < 0)
-			return ret;
-	} while (ret & MDIO_CTRL1_RESET && --retries);
+	ret = read_poll_timeout(xpcs_read, val,
+				val < 0 || !(val & MDIO_CTRL1_RESET),
+				50000, 600000, true, xpcs, dev, MDIO_CTRL1);
+	if (val < 0)
+		ret = val;
 
-	return (ret & MDIO_CTRL1_RESET) ? -ETIMEDOUT : 0;
+	return ret;
 }
 
 static int xpcs_soft_reset(struct dw_xpcs *xpcs,
-- 
2.30.2


