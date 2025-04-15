Return-Path: <netdev+bounces-182789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BF5A89E97
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D07188CC48
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851027FD4D;
	Tue, 15 Apr 2025 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IpoMe21j"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C72957C7
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721507; cv=none; b=E1TzDj68cnR+ssXc11tCBm5Iz+v2cgLLfe+bX1BR45gdnjxZ0raIcsA93d95gR3gDfuAo+MR80RzMOR7gHyBPv2OAimmlrQ348cQWtMYElBEqEMoB9l0LRD5HSM3S/xI/Vs6hFW/EQRVCHAb7uFdT35CWzAW6x0lErDWVoOZO8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721507; c=relaxed/simple;
	bh=6+XNT1oBwf2sSkw6/czEQ0TLhxpdT7r413sa8eZYGeM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M2NWsqCw4wUHNH2zH9kSssnWfHJOmMBk9NgJ6ohoEjfKZvwb23oKlFr2QdpHsTFGP3Ui9YQ4OcFkKs4jsrvGzI3F2ZSS0d3s/zsGQSUZ3CRmXOhu9GieGtL7HCRRSjaqxQBzaxPc0e5tAF1NLDaoKQScrJbcaE+h9eYasyPfqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IpoMe21j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DJelH3MXeuw+QhgIUBgXCxj63HuDy6jNjoA6xLDiFtY=; b=IpoMe21jYVhJpimOHsXYMa1CF3
	XHXMrm+vLy33Vb6lHekeOYPP6VH4bJFr6txvj63QglTwI3Ifq8dsNqSRMEGKMJDLa7RbrL4mI3yTA
	HPACRuylJqGHTUqb8RhlgqFJHdp71mSwAqNAVAJvqgUarnRE8qsqWO3XHGXWpQPUmHpYusLCFt/IF
	50BMTwR9Z6cVxXYm+HAKLaXDZchnTG9Rgtr47xJWtFESmQcTDUrIj0ppZd3+L9W3a4zACdP5u6/md
	3/Oj+K+j/wmYjZQgytD9qvBISGett6JnZKTTQse9f1tEDeCKv8EM8X+1kKloCGmJ1V4wb59mHgxkC
	RgkxXHIA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59424)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4flE-0008AB-2Y;
	Tue, 15 Apr 2025 13:51:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4fl9-0000Nk-1L;
	Tue, 15 Apr 2025 13:51:27 +0100
Date: Tue, 15 Apr 2025 13:51:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH net-next 0/3] net: stmmac: sunxi cleanups
Message-ID: <Z_5WT_jOBgubjWQg@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series cleans up the sunxi (sun7i) code in two ways:

1. it converts to use the new set_clk_tx_rate() method, even though
   we don't use clk_tx_i. In doing so, I reformat the function to
   read better, but with no changes to the code.

2. convert from stmmac_dvr_probe() to stmmac_pltfr_probe(), and then
   to its devm variant, which allows code simplification.

 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 58 +++++++++--------------
 1 file changed, 22 insertions(+), 36 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

