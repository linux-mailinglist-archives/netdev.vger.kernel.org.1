Return-Path: <netdev+bounces-236190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36B9C39ADC
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE483BBA20
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDBA3093AE;
	Thu,  6 Nov 2025 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BLuqw6uV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073062FB616
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419372; cv=none; b=JsSyxNHfnZedbGTV0awnAfuOeMjI8LMzpxP1gASRB4DELoUuqstFHMb6N5wTZwb1Bv/3I8dTiAva6A/sCmym7KNFO58M6EePWHlQQhUOyv022nrJyKqXcf8sCMbB5q0Osy0zCZgT355Dov8QsadwMaZNIITuJ+svzzEg8f6KmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419372; c=relaxed/simple;
	bh=rtNfa5atuyqx5VieRmXYmqNBLh9gi6sLYoBx/huGnwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o2Q9yRD+vf5Z4DkmZZsZgsVCZOAT625Zuv0PlPCYTE5tjnpxuxCBBulR9HOKM1g9B91AWcSyGbv8ckEUHtFcsO6WMjGDMvNhPoMAcva5kjcXFusgF8PZo9rpq5dccj9upulUSfF71XlG6JjA0F8oSkjA2/6jVkwHqn4NxXX9EeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BLuqw6uV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lrxCokjkJ6fTXIXnxlneNHLsLi1qKTxMMtfg4QSt57I=; b=BLuqw6uV56c8CdShAuoJaVnqWA
	sWXyMjW+IWjZz7DfX5FnUt9EEE5Y7lmq+R34mrMofiqZSem+Kg7UZTn8ZSrZgQK/MWJJXGczHxd2o
	YWZ7bMIwfVy1br90DIegN0EfFcG3vYg1IHA+6iMhFaaTeCgaHMCBFduNQ0XZ8JoJGjobDy2CbQMh9
	2/059E6JZE8aR48vplbta5ZrTn5ob/pMeE4F4NBCXOXwisKRV3mVp5U0zN014h9gStKi8jWRg9tnt
	fbHx7curmhAlWegLCYye0m/gSxeaUUl6nvhJ+ayFU2zYjMdd5OIJONBNNEeHYsTVSSS7BbVFe3xP+
	MJbS/b+A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50478)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGvmi-000000004We-0pZS;
	Thu, 06 Nov 2025 08:56:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGvmf-000000006WQ-0BLg;
	Thu, 06 Nov 2025 08:55:57 +0000
Date: Thu, 6 Nov 2025 08:55:56 +0000
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
Subject: [PATCH net-next v2 00/11] net: stmmac: ingenic: convert to
 set_phy_intf_sel()
Message-ID: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 05, 2025 at 01:25:54PM +0000, Russell King (Oracle) wrote:
Convert ingenic to use the new ->set_phy_intf_sel() method that was
recently introduced in net-next.

This is the largest of the conversions, as there is scope for cleanups
along with the conversion.

v2: fix build warnings in patch 9 by rearranging the code

 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    | 165 ++++++---------------
 1 file changed, 45 insertions(+), 120 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

