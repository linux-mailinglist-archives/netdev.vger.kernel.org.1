Return-Path: <netdev+bounces-198015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF450ADAD27
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A704A3A4DD3
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DBC275864;
	Mon, 16 Jun 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AKc6cc55"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15727F000
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750068999; cv=none; b=pXNtvAIBsBVjFgUimM7T7N4Bje3WVC+MRABfdSdU72P7IJQ1zfmYLM3ihOIS5WDmTix3Mj84Gst9TFLcZxuxXWZ8VcBXVaCML1Cjxz/pkotyrCyzNTxJ86xNMYzOSU/JXMkbkcFaAbq4bdamTyDpTcNXlWhgceMfd+BnUaB1Gg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750068999; c=relaxed/simple;
	bh=5TYO8TcF0IP8Dj2YbZVv96MOLW7/43spBkBSbIyCJ84=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pUaCv78MDCzHuEx0dLVY5mL+e0vHFeK/tRd+5wH6XLkskXzghuts598qTPFe0GHFh5jLmt03iRbJ3F28nP9X+zSW5fsOciqgyVSOWdSGS5NiRmn7E+QWTAF7Zs69eZh1WQ53Oz+JN5qpu+/MI0YV7X9J1MdEN5XEsOulmxi8IjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AKc6cc55; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sBrVJ1k5VPvOvKcaq/E5y2Tzud4Q8rsO6WAeUhiA9B0=; b=AKc6cc55yswjjryG8G4MMvK34b
	eWl0lmldUhPFHjvMHkyUeUpxV1owbxZMPEC6pMJB7zCK0NMN4IHkrg5rWgAAtiAsP/i+onAsGcDkN
	k4wvlGSK8XdsMWHPz8JgpokwtotT+msJohfhaNGsyL4Jq7o7vk8Cu6ZdDSCzo53rfC4O1zulylu/2
	HIqCIjXUSdIfYJMvE5iI6Vgl5nAg4K8k/Ym1MLLUdorg18CCO1S8GHzBp7Qkoa5a9gFPT9OY6uNdL
	4ndFwOxvIn9lqSbRx5zg2eiK5KA5DjL9FdPfTuy1asKiNV0xayi4tgPkCtWT8B1vs/hqbkJxJZdKK
	DAcgQuJQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52678 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uR6tD-0003aS-21;
	Mon, 16 Jun 2025 11:16:31 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uR6sZ-004Ktt-9y; Mon, 16 Jun 2025 11:15:51 +0100
In-Reply-To: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
References: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/3] net: stmmac: rk: fix code formmating issue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uR6sZ-004Ktt-9y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 16 Jun 2025 11:15:51 +0100

Fix a code formatting issue introduced in the previous series, no
space after , before "int".

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 18ae12df4a85..5865a17d5fe8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -904,7 +904,7 @@ static const struct rk_reg_speed_data rk3528_gmac1_reg_speed_data = {
 };
 
 static int rk3528_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface,int speed)
+			    phy_interface_t interface, int speed)
 {
 	const struct rk_reg_speed_data *rsd;
 	unsigned int reg;
-- 
2.30.2


