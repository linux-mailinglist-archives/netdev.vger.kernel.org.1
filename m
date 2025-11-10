Return-Path: <netdev+bounces-237197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B15EDC47468
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E4684E1752
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E0730E858;
	Mon, 10 Nov 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Bg7eIF/n"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A0D2BB13
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785766; cv=none; b=q2bAhh9qGHxSpJoL7fd2aeNBgrGlWmfYfYx6bNj2E+ziwqmHMWkWrI/bCvtVdyFoRWfh0IcQxFwxsp468nuLR0ACPnLGWqybl1aqL26C+KyBJR7Em2yzvaL8kb+byFd5JIPi2yVyMqP+bUpwZulr0zOC149giv8QGavzDpxLF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785766; c=relaxed/simple;
	bh=feNA2ULHUjxcckqctgKXIHUIGcz+GcG7syZAaaK7EFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nLR+pY6/8VY3jOxpZO8tL0d3ee2wS9Ty6EtM9QuX9JwzUX6DKiKuhZdqmaLF8d360P2iSDT8FiEz4J3jjljKNflLImDN+Is9JfVZfWDdqcmdJjkmOhMjobIKONYo9pFjEiiYaL4dyJuxXmZiS1+7KiotEH8dX610qRfgLxisXJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Bg7eIF/n; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pTHTnt47dLnvjBSkUPSimpdVNbseAt9gYfCc7cGjwZM=; b=Bg7eIF/nhX4f25nLvWrbk05hXu
	19ZiIrw2v7uwrhAks3/yHKlyo4RfB5fVVRH5snm1fNTylSIqs32z1Q1PzQy1ED4RdFgyuftQScOjR
	Wv8McRxhFq7arVI56mIh1XPaiMOnSMZ68dyPivUOo7jvsNZzgMva9PeT0qq6+41kNS/wSZ0lWI6q3
	lg9KQn7EqjUKzfEk5YIODMbWh2RTJNPh0UTe4mAG7kVu1JlLAr1Jv1JrlD+i8dT08UlVdRRHCrRH/
	ktUJjjJ3/jaDmas8otejsFlS3sWqFkCab2tW2JNXdQb+AqsYk5Lxum9+M4PR5PRmZxy2/7G/8G8Uj
	Aw3Kplrg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55342)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vIT6F-000000001Dg-1Zxp;
	Mon, 10 Nov 2025 14:42:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vIT6A-0000000023w-4AxZ;
	Mon, 10 Nov 2025 14:42:27 +0000
Date: Mon, 10 Nov 2025 14:42:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 0/3] net: stmmac: convert meson8b to use
 stmmac_get_phy_intf_sel()
Message-ID: <aRH50uVDX4_9O5ZU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This series splits out meson8b from the previous 16 patch series
as that now has r-b tags.

This series converts meson8b to use stmmac_get_phy_intf_sel(). This
driver is not converted to the set_phy_intf_sel() method as it is
unclear whether there are ordering dependencies that would prevent
it. I would appreciate the driver author looking in to whether this
conversion is possible.

Technically v2, since these changes were posted as part of the 16
patch series. No changes other than r-b tags added.

 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 30 ++++++++--------------
 1 file changed, 10 insertions(+), 20 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

