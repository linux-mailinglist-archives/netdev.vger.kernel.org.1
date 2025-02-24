Return-Path: <netdev+bounces-169043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8AA42548
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEC74461DB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8A24397B;
	Mon, 24 Feb 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WSlwxJPC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C62571CE
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408448; cv=none; b=dBdCMCVvvjZWG9MvVjYgeYn8OxaxDae5pzsweXaJwd92SASbC/+0eCRCLnojxw2bOWrskJjYJHRKSrq9OjXjSmptTE3I4vHCZ10AC/uT4uen56HFm3XBBOZxHLG2oUb2rSYXgXXmLAE0sTDx9jmxyWyhm7U86vNhqpDSfCpiWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408448; c=relaxed/simple;
	bh=uvva7VVgcYQdPwehDEq5K7SEH/IFmwJPm2IdZ7+Q0Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hOCjYxp55Yx8dXRB1NjyF22g/mYqIYQty1V6Zb1gV2+XD9JxM9h0FpqP7zuVxhGfpXnCzhdw9hDKiA6wh6olnVRC9ZS0xyIAZHYI8PRQ6xJsBEpHecUwLbJvIdnndoyWtYXajINE9obO7T8PkunXC+NxVfSWps1Hx0rdIwfWHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WSlwxJPC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w2VjUmcUhwo45yKsnIYQyEKNRQ2c98rmF9aT5Omixdg=; b=WSlwxJPCmcu4xnkbsWzbiG3zY8
	tpIG3DO/dieoFK3cV1Ezwd1BJzFNXU/QeefmhPr49N0cBr39Lz4tS7d7318pOjagRGZcPXKUqzsRh
	zkhvuYecu6EVNhPDBbDyd+ThG2zoFW9dluANMurm7yi2tq5stBJegn1KqMPWdl/UFA+tBL6u773Rl
	quUupuZLXIoK3GKSK4XqiEcARcQ50fp379TJSf0zrUD7IVaUB6LjTpLzTmkxLagsx2EaQta59Dd9e
	QketBhXljhkl3AP0rubZ6EmuYKBZvHAxMhdEXJ5+I2vOPN1/6LJSXvuy8obXirPQIe1clAsh8zthE
	ecoLa1tg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47930)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmZjr-0006fT-39;
	Mon, 24 Feb 2025 14:47:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmZjo-00055d-35;
	Mon, 24 Feb 2025 14:47:16 +0000
Date: Mon, 24 Feb 2025 14:47:16 +0000
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
Subject: [PATCH net-next v2 0/2] net: stmmac: dwc-qos: clean up clock
 initialisation
Message-ID: <Z7yGdNuX2mYph8X8@shell.armlinux.org.uk>
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

My single v1 patch has become two patches as a result of the build
error, as it appears this code uses "data" differently from others.

The first patch brings some consistency with other drivers, naming
local variables that refer to struct plat_stmmacenet_data as
"plat_dat", as is used elsewhere in this driver.

The second patch is the v1 patch updated for this with the build error
fixed.

 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 52 ++++++++++++----------
 1 file changed, 28 insertions(+), 24 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

