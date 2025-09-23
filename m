Return-Path: <netdev+bounces-225577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA96B95A42
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E9E18A7F50
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E21C3218D0;
	Tue, 23 Sep 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="the/cmm+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300C83218DB
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626744; cv=none; b=cW8ZR2Jp5TCeqDv8E2UqrBZmfcAR5ApcjGmSGVeXEv2YUJqrHQxFZGDCeSOh+8QWWMhChlI11IOdkqUjPLHZROPH3/wBKOaNPWjz1pzxa1dm6TcFdCvb9+ItbpDLYFgGgBXDDL9ErkM70X0cx9MYn6q56SqpSvFMOtGFknkflso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626744; c=relaxed/simple;
	bh=nVkEoJfKiwJIMfOR1HpDpbMYukdvZbBD+FIOZ1EqwJY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QB8cMFmsMhOkFirpbop2aqMfO7dxBM5nqWP1To1DNkEtV88nz+9gUy+YmKuNIXn2iVj5FzWUz3Jb8o3PMe0aV2VPsxNsrF/MsmATGWOTLwKeK/6PIKtf6ZpwKbwmrebBFsfJ+Bp06km9zdeawmQtsaFNL51M9OBar4/8Rqbbqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=the/cmm+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/AkSn3PmATQkY4KTnXMm8OAmVPwhJx7EQAh2aTkiy+Y=; b=the/cmm+WTt9OfglCw1TUdzqQm
	lzgqjns1FNeYd+zGmfZnP2zNcV0Hxoipq+Id1EgfjModWgbUufeY+I7SwNOQCDJSCk093Ah2ur5QG
	NHADZAVfOk/l7/zCRf9uz8MO4834nemcWv3XzKkDzVPgSyHXvsGYAaLp2PgdsYnZX6QCfskCUKJD8
	vMjq8mclAQ6mMrw9STPft1j9k/rHBAt2YeelBeLeVLNN+zrEH6XVjAKVj4eQJ+ns/JZA6r30yvuc3
	EFpe7Ph/RSyp8+nXq8kJH/xiNNyMjWvasnWpMM+pxwsdPFDepXOXcDMmfccJK3Dv4PIraJ33AwlWu
	BnV7/rLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37056)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v119K-0000000077n-16Sl;
	Tue, 23 Sep 2025 12:25:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v119G-00000000662-1TA0;
	Tue, 23 Sep 2025 12:25:30 +0100
Date: Tue, 23 Sep 2025 12:25:30 +0100
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
Subject: [PATCH net-next 0/6] net: stmmac: yet more cleanups
Message-ID: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Building on the previous cleanup series, this cleans up yet more stmmac
code.

- Move stmmac_bus_clks_config() into stmmac_platform() which is where
  its onlny user is.

- Move the xpcs Clause 73 test into stmmac_init_phy(), resulting in
  simpler code in __stmmac_open().

- Move "can't attach PHY" error message into stmmac_init_phy().

We then start moving stuff out of __stmac_open() into stmmac_open()
(and correspondingly __stmmac_release() into stmmac_release()) which
is not necessary when re-initialising the interface on e.g. MTU change.

- Move initialisation of tx_lpi_timer
- Move PHY attachment/detachment
- Move PHY error message into stmmac_init_phy()

Finally, simplfy the paths in stmmac_init_phy().

 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 111 ++++++++-------------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  32 ++++++
 3 files changed, 73 insertions(+), 71 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

