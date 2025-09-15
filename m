Return-Path: <netdev+bounces-223057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56B5B57C54
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE981A23899
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A358F306D3D;
	Mon, 15 Sep 2025 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="apOhknQ2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADA930CD94
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941592; cv=none; b=a/xPoy+G6mCgloAlu53gNHf6lwdeYDU69nktzEo+Pigff0fLNdDa1Xq3l3Rq8SuQAKAQLW1sURrAipsNh0Mu5LZF0+NJHCoRutfW/tZUwQs/tsXkqeSc1gydgspw7gLQVFR7qlQeBqeBCI5NyDrBdgsVYu6VI1qfnNmAVIHyY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941592; c=relaxed/simple;
	bh=P3FFz5ciBDqYG/KNNwETe0EVXVEK/iL9JmYCbfkOBog=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=a1WaxxnolDJT1wr570tzOCQYlIOiTPajWUxNYBMhvZtifjn4kXrT1wlrKJii3v0yCfu27fFvlN39JwOJnLGkL4LZFojwTwkvravUw1ASxlq2jmPHUMeemKSJ6Jj4Qq136VUMtwPwekTDGAxe+PvEnJCE+dgCcVea0bk4abQI3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=apOhknQ2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W2mR25p3Vzle6Sjxkugk0QuJFBJ+kODBYMWj90dbXos=; b=apOhknQ2XlDXrbDVI9qBS+cjZ/
	HaicaKiOp4+/nZ+rHHrHk4hJmLKhqPjCKzGuzEVIhBquBWGPIFHxmZVLpqlNlU5WMhiTNMnu85ACh
	2XIbdFCR6zUnQWf0ZeIKFwGJK4bu2ij4MOSaEhKbMDx/ySw8qcveegoGmO4wT98RKkIXIIO9KSCCd
	wu5aWvSZvkav7nb6C+uNHKH1jOEwtJJzKpQymitUqea7JF0+Ir2HlhERAAo7Dn3Or75CgHeLpKGiz
	gwmg6HAmunsuE3DZgqqplu0FrYV3P3A++s8uKnZowQLXkFWgFZ9UBUL0KshKn9hThubG12z82Taqt
	FaR3URFg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37536 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uy8uY-000000000E8-1tWZ;
	Mon, 15 Sep 2025 14:06:26 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uy8uX-00000005cFH-33oY;
	Mon, 15 Sep 2025 14:06:25 +0100
In-Reply-To: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 3/5] net: dsa: mv88e6xxx: remove duplicated register
 definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uy8uX-00000005cFH-33oY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 15 Sep 2025 14:06:25 +0100

There are two identical MV88E6XXX_PTP_GC_ETYPE definitions in ptp.h,
and MV88E6XXX_PTP_ETHERTYPE in hwtstamp.h which all refer to the
exact same register. As the code that accesses this register is in
hwtstamp.c, use the hwtstamp.h definition, and remove the
unnecessary duplicated definition in ptp.h

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 2 +-
 drivers/net/dsa/mv88e6xxx/ptp.h      | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index f663799b0b3b..6e6472a3b75a 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -570,7 +570,7 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 	}
 
 	/* Set the ethertype of L2 PTP messages */
-	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_GC_ETYPE, ETH_P_1588);
+	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_ETHERTYPE, ETH_P_1588);
 	if (err)
 		return err;
 
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 3e0296303d61..60c00a15d466 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -45,13 +45,7 @@
 #define MV88E6352_TAI_TIME_LO			0x0e
 #define MV88E6352_TAI_TIME_HI			0x0f
 
-/* Offset 0x00: Ether Type */
-#define MV88E6XXX_PTP_GC_ETYPE			0x00
-
 /* 6165 Global Control Registers */
-/* Offset 0x00: Ether Type */
-#define MV88E6XXX_PTP_GC_ETYPE			0x00
-
 /* Offset 0x01: Message ID */
 #define MV88E6XXX_PTP_GC_MESSAGE_ID		0x01
 
-- 
2.47.3


