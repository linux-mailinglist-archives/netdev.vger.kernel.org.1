Return-Path: <netdev+bounces-158637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0211DA12CD4
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F0D164729
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BA1D90B3;
	Wed, 15 Jan 2025 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xCN7L5XJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE171D88D3
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973775; cv=none; b=h0cUgAWrqXKdMwy3qvI/0Ay57j2T0zDSEDxxKZiHEkZIG8TUK995kGj1VqF3NBDzHESI5yfhYMiuaQd35gwrImZH56BZsCtatJEZ62hQ+BM3bJ0MZmWETWzJyM6I2mX7r9bxHz2uDFmpVhfzx5ToApceg8qQq/sEa16sHr2MWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973775; c=relaxed/simple;
	bh=WLFmhNR+bELIaIwLyubleNx4vpW3xHsEL1hCy9cvIpU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=QevQROj3KtmsUKdSbh+Og19v01HA7QPGkWiLDRfFiP0L+Eq3ttt+rcgHLae3svZK3tXJ8EjFuoQdSnMAsKjIziQGUzbUtzIRVaEq6PRH878SH4pF/JOjg9vPjMaJZfdV2c/mtlSY68O2PRbCaUY4QYokCxwW427tYtruZy3bvhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xCN7L5XJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yqNVbj3MVpY+7D9FsZ5FX3gjtvbIvX8GZPT80w1IszY=; b=xCN7L5XJ6uub0u6KMFY1SWhBIs
	6s8VwiAooMvZHkNqlFBdKZ71XEWRVPTcsP55BGfBn+BDYCf70+KgiCCDUmfl0fVzFNFXgztKlGhZJ
	UrHRHSDnFjnaL9kWsba1jiGRAdn7r+aco9UuY6UlwlCiWq7WlqZ/8KrPebvHS3NiPLHO+gFd9Nfqy
	aEg+4akv1FVWcCTX3QljcAAEiS8EMTI24I++dScnsFKGz3/MjxIN4+iI5nxUz+7zK8aNzN56BL2Uk
	3A0dM0CdhphEnLuwhKau1R0sXIb85KDpEHbRv9JTbsLUi6h074G7kuBrqXQJ3rTuxIEy9b6hGKT94
	2yXQhmEg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59884 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tYADu-0001iD-0k;
	Wed, 15 Jan 2025 20:42:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tYADb-0014PV-6T; Wed, 15 Jan 2025 20:42:27 +0000
In-Reply-To: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 1/9] net: mdio: add definition for clock stop capable
 bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tYADb-0014PV-6T@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Jan 2025 20:42:27 +0000

Add a definition for the clock stop capable bit in the PCS MMD. This
bit indicates whether the MAC is able to stop the transmit xMII clock
while it is signalling LPI.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/uapi/linux/mdio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index f0d3f268240d..6975f182b22c 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -125,6 +125,7 @@
 #define MDIO_STAT1_LPOWERABLE		0x0002	/* Low-power ability */
 #define MDIO_STAT1_LSTATUS		BMSR_LSTATUS
 #define MDIO_STAT1_FAULT		0x0080	/* Fault */
+#define MDIO_PCS_STAT1_CLKSTOP_CAP	0x0040
 #define MDIO_AN_STAT1_LPABLE		0x0001	/* Link partner AN ability */
 #define MDIO_AN_STAT1_ABLE		BMSR_ANEGCAPABLE
 #define MDIO_AN_STAT1_RFAULT		BMSR_RFAULT
-- 
2.30.2


