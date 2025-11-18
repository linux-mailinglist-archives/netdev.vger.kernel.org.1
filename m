Return-Path: <netdev+bounces-239475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF705C68ACE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA4E94E2C0D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D5632D0ED;
	Tue, 18 Nov 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wXCPvy19"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276232C948
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460023; cv=none; b=JtIta/P8nfJpy9BTXrqEpfDTX28PXRVsWYXe2oQ9HQBEMAfsSpURVk4sCbNAkt2UMntpBgC+2l8QVA5QuFegetShm7YiIb2Q8tSVCogGkjjG9mrRU4AcuC+c8HK3r2Nnn4+yAw1ko7DOwO4kzl3slrW+h8BMqomXCIeawHqu6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460023; c=relaxed/simple;
	bh=F5eld1SwlnW+fDQKB6EHEtFsROTcF1ZCGkSoBmicXQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=poZJ9NjQmTbLbQNkIeymfPOOk+kmQy7HQ4cjtzVB+x2PBAeRBkNkEP5j1GKJf7Z1cgtD1TCgH+ELTzszkk3v13k8kSg/8/FUDNi4Gt3f/0pMwuBYo83/9oodkZPbvup2gygB4q7gG3GI2oXXvQNK1pqKc4DqQ8le4Arto2T7lqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wXCPvy19; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZHtYuYxvWqbVVfivkjXN2yF2dYFsIpwehTqtsa5taOc=; b=wXCPvy19LVshAa4rOzm6Eu7c1v
	qKbcCfAZparxO4aSBWG29gShzC+P/5T4Q5+lretIYqoY/yxPCvZkOJHEsYSLlK222UF32OuBywoGh
	5Vn7vci+LECxTe2mBJUez4eJCCGeWO2kUQncKX3r5B4af0Nq/PZ6mEuJPZxJv/h1gyJH/dvocVZ2g
	rc6saTB8D36f9EGU6z6pMRXoUd+xDdPoEw7LIleLcq7elOknljK/NanH3DNY8kwLP08jUNq24vbyP
	rL1qTRuY6F5LpDaT50ZqDiXgciGGtVI+HWzx6qrrClJrBLlAl6pMFXbc7miGBgEbClkYAAHlrapjQ
	nQiKBsVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39436)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLIVQ-0000000031R-44Py;
	Tue, 18 Nov 2025 10:00:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLIVN-000000002Mv-0OUs;
	Tue, 18 Nov 2025 10:00:09 +0000
Date: Tue, 18 Nov 2025 10:00:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/2] net: stmmac: sanitise stmmac_is_jumbo_frm()
Message-ID: <aRxDqJSWxOdOaRt4@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

stmmac_is_jumbo_frm() takes skb->len, which is unsigned int, but the
parameter is passed as an "int" and then tested using signed
comparisons. This can cause bugs. Change the parameter to be unsigned.

Also arrange for it to return a bool.

 drivers/net/ethernet/stmicro/stmmac/chain_mode.c  | 9 ++++-----
 drivers/net/ethernet/stmicro/stmmac/hwif.h        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c   | 9 ++-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 4 files changed, 10 insertions(+), 16 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

