Return-Path: <netdev+bounces-150233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F3E9E98A6
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80771886511
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA01ACED7;
	Mon,  9 Dec 2024 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qkg7Pq9f"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E56335946
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754206; cv=none; b=SzhMvxZ3eBbRTTFKODzTV93h2KDz4z7VzFpJWSavfIeENJeHhhL/b5yXNdA5Optpx6j6nYctAjjFdURQRuqUfq9qOcmwCzRnCynfCdN1aSX5UCGpQhZ/suKs7Im4824ZgEGiVpu+rAUqG+tj13c3uNQGl8qXsIIAHlqw9U2wdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754206; c=relaxed/simple;
	bh=evL1OQos5EuPDX/rUaBZj5SIFXLeAgYT/3PPMQsNIIQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=E8gPZqfkGfrkc+xmniZxLpDXJ0978Ffyumi6Pf7JoDE1/xEI9d2GLHPtk5GTN7Ps9siSgfhtm8J+8hT/I4l0s52tvXADRK7H7QMawu4PRbaFBZb1GUsmIbAkeMsgLtq5M9vyRRs0Kq/AJAYWDTqZXAaIdHeYjsBiCqBFqaXOsno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qkg7Pq9f; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4+/h+G+UZmcLpKhAAeUc1gCUmuIP7h4zUAThZbIDIwU=; b=Qkg7Pq9fgs3KH9M648DYjiTrb1
	zFHM0ky3BFhGlXmpG+aakRxVWoXspdaY9/BEIFt0GhW8t8L5vbkIZ3RPbMEGcwQ1wUFXl6UAXnPFU
	7XulnadRE1BMCPLcDg8GZpR3BHQHyEnbIwEg/JzwiPGR/yZhwCa0BHRXiTF5lBC2XkvNy8eL/kf30
	p1/KEGq3fr2ln2ih4K8OvwmSODWpltftIdePLc5P5H950i/PNWaxD6oA7u009SJTdiB0p2/TMKZv5
	J0oA9cl7B9ENl0C099nl6Ery7aI8hTUpeefIcttkETCZUPiuypsxVghWmeqHG1yP5s+/dDLNo4qiK
	wbu5/J9g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39376 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tKefP-0000wF-1U;
	Mon, 09 Dec 2024 14:23:19 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tKefO-006SMM-3S; Mon, 09 Dec 2024 14:23:18 +0000
In-Reply-To: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 01/10] net: mdio: add definition for clock stop
 capable bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tKefO-006SMM-3S@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 09 Dec 2024 14:23:18 +0000

Add a definition for the clock stop capable bit in the PCS MMD. This
bit indicates whether the MAC is able to stop the transmit xMII clock
while it is signalling LPI.

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


