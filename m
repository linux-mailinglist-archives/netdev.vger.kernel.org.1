Return-Path: <netdev+bounces-198014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB8ADAD25
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5055166B4C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC882367B5;
	Mon, 16 Jun 2025 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CyKTfRYa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348D27F000
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750068991; cv=none; b=eArdQhUPKYaCoADNcJc1tMDFHgH8S1owTr6rXsV8tFqDYVUWRP+XD6weo4KWDElsBLGC9/oYx4K15HHFM63c/CQNl/SeIhJmRBgWoX01Vk2JIGwjqw1Gja6ZgQKGBzd9W8dC5Kjk/RL+6ORTeRKgukaBYi3LcObCb9h++n8eBQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750068991; c=relaxed/simple;
	bh=oSmKxpBWE0ZFZ2/Efbx9NndPqMPasuVbqmvBKGctvD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BdVh1DnWi4TQN86YHpPj86Ygz/TTzTHZYfUGqBazouIhC6a3wDivguUQSOZ+3TCEE8BUL0s7QQe/mxFUijFxgzo01oRWD25xOxOKfNCyOi6chidFF4GrsWewo9q0GMtOlA2U4kdE0BxT6h3er7U+Uw9h82eQxjYCVXH95WWGmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CyKTfRYa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MsW6i/FVXdat8G6hcJe1bvSOuA1liknIMYSMFoRhj0o=; b=CyKTfRYazV87NXZTvp12CDOLkr
	BnxmYOBb0dBlBzd+hrQk+iI68i1HLhjdTRi54AVEjk/JzOo2/JTT8lulv4O8qDCm01LV58FfY/5KZ
	g7X1HFmoq5ya4kMxpuDhJcj7bdlczCQLsfhCPhpT4QW6VdHojFcpgAsnJQdvbNQsMtSScq0HRV5Ri
	NbN2Y0iRDHjkU5867BKWF8y/oo4rzXyaDx9cfwPm0WFBydhnYdTPJroQWypeT12fJ5S4QICtPlOhz
	YoMd3QIZ+gIkkWz7Lf74Hcw+zfgov5mEJG3T7F9PIL1WmNlE+y1ii9q81yIgNtq/wzWqk2+BGs3TR
	VKg417fA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57732)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uR6t4-0003a9-0b;
	Mon, 16 Jun 2025 11:16:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uR6t1-0004k5-0S;
	Mon, 16 Jun 2025 11:16:19 +0100
Date: Mon, 16 Jun 2025 11:16:18 +0100
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
Subject: [PATCH net-next 0/3] net: stmmac: rk: more cleanups
Message-ID: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
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

Another couple of cleanups removing pointless code.

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

