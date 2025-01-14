Return-Path: <netdev+bounces-158177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41A9A10CB1
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D60C162DAB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BA0154C07;
	Tue, 14 Jan 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="anwoCySP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6C23245F
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873452; cv=none; b=BYiUOela0LQyX4HE/YJqsac71YgPVopYMruZJQdzOTdvo2cI4gNZl8YKe/SgNgVO2ktr60ZpJoCvt06E5uH9zU6+ATdsF+4oGyr55KCGvitZf4Mx+jfG4SAgPR0cNG4VTfl64a05kkcuTj4q3ga53G+9QkOrbFnqx8c7hgh2sBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873452; c=relaxed/simple;
	bh=c//8c9Rn/BwVdKN9yrybEMccYb6yHbqF5KP/8CL84rU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a0NxyarfWMy6jxqQWZSNbOWpFxtn5uyoI3p6iJhxBwIY9pkSUqUDNxCjQNtP5jC/muBn8U5gNiMHxPxZeVI1Khc1QRPkzciBmlGopCNiawKuiAQ3NC1R/czGvwUKPdZCdR1zW5E9FHAIfQPrvg5vKpqnRtAJqE9NVajp4eWeqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=anwoCySP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N/0MoCwSjIluFzrpZyeIyCMO4vW7SmK4ZHEjfyecgdQ=; b=anwoCySPDsYTLhIEj+EZzX2KLJ
	obAMdFUepx9gfKOl/WHEnuSBrBdcRbuNUUCeAcALtXQqOyo+LTQ7tRHD0LdhEQYOwhGERiVNj+rvP
	jRL36/m4iXZANsiVWuDIhAAhVAymbyQk0UGV7NZiFg5yvSIZJvsOb/MEYCbIeEoofao8OL5/6j/NN
	mu59LP/B8tg8VMareV6h24+tWtjCaLTc8JElfYIj8zlZ7+P6ZCS6Nz0yfvu9Y2D7YMNs4C5lRevOD
	1ruWM3MayxkMcBDzNBITuwKeN4pfPPmOTBq4Z2hVD7wOuy3h3ibEl/QTmA1jjTA0yfM3/FeXQD8HD
	7YzwUxIQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36284)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tXk7l-0008Nc-1I;
	Tue, 14 Jan 2025 16:50:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tXk7h-0005FA-2u;
	Tue, 14 Jan 2025 16:50:37 +0000
Date: Tue, 14 Jan 2025 16:50:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	bcm-kernel-feedback-list@broadcom.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/3] net: bcm: asp2: fix fallout from phylib EEE
 changes
Message-ID: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
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

This series addresses the fallout from the phylib changes in the
Broadcom ASP2 driver.

The first patch uses phylib's copy of the LPI timer setting, which
means the driver no longer has to track this. It will be set in
hardware each time the adjust_link function is called when the link
is up, and will be read at initialisation time to set the current
value.

The second patch removes the driver's storage of tx_lpi_enabled,
which has become redundant since phylib managed EEE was merged. The
driver does nothing with this flag other than storing it.

The last patch converts the driver to use phylib's enable_tx_lpi
flag rather than trying to maintain its own copy.

 drivers/net/ethernet/broadcom/asp2/bcmasp.h        |  3 --
 .../net/ethernet/broadcom/asp2/bcmasp_ethtool.c    | 39 ----------------------
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   | 22 +++++++-----
 3 files changed, 14 insertions(+), 50 deletions(-)
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

