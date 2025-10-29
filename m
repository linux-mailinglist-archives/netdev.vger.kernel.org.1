Return-Path: <netdev+bounces-233704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7B7C1775B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25358355B79
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCFD1E50E;
	Wed, 29 Oct 2025 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rfUpoI6y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27AA11CAF
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696234; cv=none; b=kTQNKnky/n12vglYs03bPd3KrEIBYU12B9Z5IYZITH9XOJOn3D59UsNHWP2/KnCfFk99IqszPlmJqNEiL8MyqRQQspMGyDtNBk1Ps8qZ/Ew2NqCKTjYhluIGc1XYGzXFu8iR+tRm/mcT4w8+xHIbmrfsaIH2IMHCMIDB488s+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696234; c=relaxed/simple;
	bh=yEeo7kTKd0SzR3QMoXgeDwoIHLT1ST3scgf3Kl9bGeI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PDCFwugAmLE39Y0ZqiNSIdTCHajq4uog23CpC7rehqNHMAuDC3m0KSUKMB03yjXm0uBb+DxC+5Ph42mDRNJmNpL8kqyVbehGviw3KVjhyABPqqRLwRIAZNB7pNW64AbX3dm//uAPAG0iVn3Ge7Ntl0XjJJfEaAHsvdtdRHRu0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rfUpoI6y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S5vzd0Jaj6VAF2WEn3/n39Izw4RyCcWn4YeDfe2RhsE=; b=rfUpoI6yiT9hLvLuKG2HkiCvpt
	x/OnG1UYZr3Zj1gJw2GysISE5BYkW+OatHVBWjiMkxgldxHtRWGiZ0MBq53stLup/1zfcijVRhbH+
	RvfmSp71nqn3Ehc5Dex3BV5WaR0rZ8dOwp8BYv2BKWzNfUqz3MyV77bOUp9NnAO12TL/mZ42jGYUA
	Bh8+uqJd63oUIU2V8tJRcqiR5GgGbo+/6zQeyAcjGxz3tJU95vVQZoZkinK6xDHgZLISiXtxntpfv
	4IQVqv0B4IRdZaj3/pdS4OHgiMkXfDLtQ6CT6Hm7F1hNgbDfT1EWONRw549S0kR4j7Up30tp7rxfl
	jUDyoTkg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44818 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vDtfC-000000003iK-2Xhz;
	Wed, 29 Oct 2025 00:03:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vDtfB-0000000CCCR-25rr;
	Wed, 29 Oct 2025 00:03:41 +0000
In-Reply-To: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
References: <aQFZVSGJuv8-_DIo@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next v3 7/8] net: stmmac: use != rather than ^ for
 comparing dev_id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vDtfB-0000000CCCR-25rr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 Oct 2025 00:03:41 +0000

Use the more usual not-equals rather than exclusive-or operator when
comparing the dev_id in stmmac_hwif_find().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 892cef79c4d1..e1f99b9d9d7f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -314,7 +314,7 @@ stmmac_hwif_find(enum dwmac_core_type core_type, u8 snpsver, u8 dev_id)
 		if (snpsver < entry->min_id)
 			continue;
 		if (core_type == DWMAC_CORE_XGMAC &&
-		    (dev_id ^ entry->dev_id))
+		    dev_id != entry->dev_id)
 			continue;
 
 		return entry;
-- 
2.47.3


