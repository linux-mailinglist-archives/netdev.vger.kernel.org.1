Return-Path: <netdev+bounces-183195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B42CA8B563
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45E21899544
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827C421B9D8;
	Wed, 16 Apr 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fqDJ91iq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED42260C
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795921; cv=none; b=Ou3rOhnlB+yqFw/IaSxtChVVZvi63cCYf9ow0M740KOoKT7W5hgm7k2GPOemMzW7VK4Z+o3LxlJuOEZ3eG9aT6grQf+y+wGT7aQ7B/baRhVzp49Tgd2J+d6+TyKJoFvUk8tjPdLm92fED/NJ546s5pSPRHRcQBMOsv2M/VTfjhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795921; c=relaxed/simple;
	bh=5paRVicrWd71oiRR5Cc8caylxl2j+fSDbbeYtNvIGlE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kz1cqWyCDQrUwFUTTdrZY89/A/gP/+X4nNUsVbeQZkTcNJ+BOMqn9JtVu/77lxU3wUWKlRFEdtPx0FFKb1jVZKWtfrGPoQw4WaOe6ez0gLkGUJgCFnqH/y184jSMWz/oIBTCsbdEfQckm8Bf1Y0vS9ujenkzzGnO1l8ILIWl7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fqDJ91iq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xHYaOtwx99ZZgi8ahq47uLXju4A9RCSm3k3c98E5wYI=; b=fqDJ91iq7sXU6lG5+Xaf6CZH6A
	xRTvrrlxNWtyH0c+78YyIh/ZgKdsGwXDqxKcb62dNl3rpa2u4PVOMq44XrMNxeDq0BAS5sewyupBv
	QJHCLn6hJC3+UWthihjjaKMeue6noJDORmBJEoYkQo5gaZiKl88jLHNh6oEq8x2rqjKtc2HIaLMQx
	Fw8oHP5hUrolWoM1aZJxm78UJTsWTRa/vbdH4bDsazspygcmU3wajRCkaRZ+afPLHv9QHgdRmjVBE
	1uDMeXdD34KCS1xv4qsQDw19plgleDEDZC+VGKwlGbTHuUANj80pifhtN258zEqqhaMqf3gbmTonP
	k+uTnleQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58106)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4z7V-0000yH-0c;
	Wed, 16 Apr 2025 10:31:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4z7Q-0001Hh-0x;
	Wed, 16 Apr 2025 10:31:44 +0100
Date: Wed, 16 Apr 2025 10:31:44 +0100
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
Subject: [PATCH net-next v2 0/5] net: stmmac: socfpga: fix init ordering and
 cleanups
Message-ID: <Z_95AM64tt_4ri1j@shell.armlinux.org.uk>
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

This series fixes the init ordering of the socfpga probe function.
The standard rule is to do all setup before publishing any device,
and socfpga violates that. I can see no reason for this, but these
patches have not been tested on hardware.

Address this by moving the initialisation of dwmac->stmmac_rst
along with all the other dwmac initialisers - there's no reason
for this to be late as plat_dat->stmmac_rst has already been
populated.

Next, replace the call to ops->set_phy_mode() with an init function
socfpga_dwmac_init() which will then be linked in to plat_dat->init.

Then, add this to plat_dat->init, and switch to stmmac_pltfr_pm_ops
from the private ops. The runtime suspend/resume socfpga implementations
are identical to the platform ones, but misses the noirq versions
which this will add.

Before we swap the order of socfpga_dwmac_init() and
stmmac_dvr_probe(), we need to change the way the interface is
obtained, as that uses driver data and the struct net_device which
haven't been initialised. Save a pointer to plat_dat in the socfpga
private data, and use that to get the interface mode. We can then swap
the order of the init and probe functions.

Finally, convert to devm_stmmac_pltfr_probe() by moving the call
to ops->set_phy_mode() into an init function appropriately populating
plat_dat->init.

v2: fix oops when calling set_phy_mode() early.

 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 79 +++++-----------------
 1 file changed, 16 insertions(+), 63 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

