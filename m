Return-Path: <netdev+bounces-161362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E3BA20D68
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B843165248
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174181D5AD8;
	Tue, 28 Jan 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YBne8JSn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7AF1A287E
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079196; cv=none; b=Hw6DUNAoHXPp8TPZQmf+ZnshOrrq621yos0okvlJNztluIOjKELW0wqG2Vwz0nMREP+Zxm+sTbWC5wusYbaiv9lo+8tg1RGQGBrVi26Fm0RRzmzkEsnQGGrFS7uth2Oyeg9bl3vdg1D0ojBEA76x3Qpx9I7JJ1xwzkn/2J3B9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079196; c=relaxed/simple;
	bh=Dd+E5PDpOgbpT8KNpmucjOx66ZieUOtYpV9uaCRsH2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UUtpdM6R4mBbCD+rJK7FLC5GPX9JGNx6NF9A9usyu6lePc9znroUsuOLpD1pc4l+Y9RiJhoZE13cfZXSsPbdj+bDDRpm8Tuitn/YhNU+KpwbulqMJaVmZfjJAOURNw23CtVoAyCn0nWX7L7SmiA3Tkw9lrQVU2MiqKSqyYCuqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YBne8JSn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q1N7qzwT6+40rnFu9DeSjSQxLuS7bQdCcDSHTwobr1Y=; b=YBne8JSnNFEQ5vmyGtxUZjf/O9
	eoak2EnTVv8J9FenJUtjEDH0bbpLkrjKyGmcj/R2Az2BaoOsIdQnBf7y5hgzlDgBrkzHNzLSn7TYG
	omjEd4P5tkGiyQn8j5pLqd2HPZcHLajM95Albzv94vT0poxLvnb8b7ceCl//7vUa/fPnJVvGTRWt3
	ABQQWZOilVMz6fPK2WitGRaOxGw7LZXrl1SJ5hC4tVkaOFtMDQCZr53xYAsQrjIgH09hUdrBJrjfB
	cFL0WFjJf4cfC0975yK97Ub/xuk5Vg0sHNCBhHHW2gewqyluLH1ptcPkosyj6REAwxg0UVXMjMLOq
	I+MdaAUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58040)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tcnnB-0007ST-24;
	Tue, 28 Jan 2025 15:46:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tcnn7-0002lc-00;
	Tue, 28 Jan 2025 15:46:17 +0000
Date: Tue, 28 Jan 2025 15:46:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 00/22] net: stmmac/xpcs: further EEE work
Message-ID: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
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

This series is a preview of the further work I wish to merge during
the next cycle for EEE in stmmac and XPCS drivers.

The first 14 patches target stmmac's EEE implementation, which I believe
to be buggy such that it does not disable LPI signalling immediately
when ethtool settings change, but instead in effect waits until the
next packet is sent. This is a relatively minor bug, so isn't high
priority.

However, what the first set of patches are doing is continuing the
cleanup of the stmmac implementation and making things consistent and
readable.

The following patches are aimed at eliminating the xpcs_config_eee()
direct call between stmmac's EEE code and XPCS, and present a way to
do this. Sadly, it doesn't reduce the number of direct calls between
these two drivers as we need to implement a new call to configure the
"mult_fract" parameter in the XPCS EEE control registers, which is
supposed to be derived from the speed of an EEE-specific clock.

However, I remain unconvinced whether it is necessary to enable and
disable the EEE controls at the XPCS with LPI being enabled/disabled
at the MAC. Could many or all of these settings be configured as part
of the creation of the driver instance instead?

Without knowing that, the only real way to clean this up is the one
I've taken - which is the principle of preserving the existing
behaviour.

Sadly, the entire series doesn't lead to a great reduction in LOC,
however, the initial 14 stmmac patches leads to a reduction of 71
LOC.

My plan is to send the first 14 patches shortly after net-next opens.

 drivers/net/ethernet/stmicro/stmmac/common.h       |  14 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |  13 +--
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  30 ++---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |  12 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  96 +++++++---------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   9 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  49 ++++----
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  21 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 126 +++++++--------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   2 +
 drivers/net/pcs/pcs-xpcs.c                         |  89 ++++++++++-----
 drivers/net/pcs/pcs-xpcs.h                         |   1 +
 drivers/net/phy/phylink.c                          |  25 +++-
 include/linux/pcs/pcs-xpcs.h                       |   3 +-
 include/linux/phylink.h                            |  22 ++++
 15 files changed, 253 insertions(+), 259 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

