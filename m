Return-Path: <netdev+bounces-47954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E3F7EC15D
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBEE1C2090F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EA7168BB;
	Wed, 15 Nov 2023 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NtOWzfnu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF304171A3
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 11:39:22 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C870BCC
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 03:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gQNUZP8yVS8Jh5fvWhjYIVJRa8z0OIF7ANw6PcWCdYs=; b=NtOWzfnuhmQ6TkvRI0a02QlJjU
	Vc6nEQ8YWGz41fUSP3MucyJ6aC8NMKpTRQ7MSAQfXBJyVXaSGMsxpmTGT0psaEzuFhwzzwOL9dxc8
	uZh8beTuaiKogW/FGHGCsPFlkpra9oi3xthq6HI+d4BF9ZpENIksC78ZqgO55BcFplVs9/tSBzbuS
	0fyvP59MVTeX0V+uvINFbPEzJDt6NONtxu9E34gAFqUsgsyLr5K7HVthTK00dckmDDhSuOMVxPyN6
	os8PD0a0Ib0CTRavkYa0LYMoszoXWYDM0QnuY1+BloBZcvnC5SLvjRD30X9RO3umdicS7NRTSZlkV
	kTsYX43Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46202 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r3EEm-0000aA-1k;
	Wed, 15 Nov 2023 11:39:16 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r3EEo-00CfC6-Ez; Wed, 15 Nov 2023 11:39:18 +0000
In-Reply-To: <ZVSt2e9Z5swJNf+7@shell.armlinux.org.uk>
References: <ZVSt2e9Z5swJNf+7@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/3] net: linkmode: add linkmode_fill() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r3EEo-00CfC6-Ez@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Nov 2023 11:39:18 +0000

Add a linkmode_fill() helper, which will allow us to convert phylink's
open coded bitmap_fill() operations.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/linkmode.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index 7303b4bc2ce0..287f590ed56b 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -10,6 +10,11 @@ static inline void linkmode_zero(unsigned long *dst)
 	bitmap_zero(dst, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
+static inline void linkmode_fill(unsigned long *dst)
+{
+	bitmap_fill(dst, __ETHTOOL_LINK_MODE_MASK_NBITS);
+}
+
 static inline void linkmode_copy(unsigned long *dst, const unsigned long *src)
 {
 	bitmap_copy(dst, src, __ETHTOOL_LINK_MODE_MASK_NBITS);
-- 
2.30.2


