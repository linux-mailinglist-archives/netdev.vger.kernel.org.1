Return-Path: <netdev+bounces-223712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5523B5A354
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 22:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0836188981A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932872F5A34;
	Tue, 16 Sep 2025 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="P1Mtrppw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE45220F29
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054899; cv=none; b=D4//0WuRipKlgZ6O27oSbzdLM1wThGn6ZuIlGDAaryH8vaW5L8ViRTyrDB42du4JBi6zlHDrEc7orXSsaw0KTb9auTbzQZWP5jWZvIcpVy/Ba9PGgeKObL/n9zMYVqCVUlPObCJoVC6b9hLIhqXwJKaxJZ/rl+TF95CHHLrQhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054899; c=relaxed/simple;
	bh=wC/XKIne/FFPsk1LWvRzNg00cV5y8rIesXlV47Tifmw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=pZx2oOgXGVvYZf5Z0+epqdRTEZBQnZp/g7OgtsUlfs0QZMjNnFuR2yeMYETZIj1mlaj4ICKhl06okfk7gLQNUuvo8y1Cz9+rNcWELNp7uIMcPxIqowEoSS9gTmSSVFSX+Dl5cCht0jUv+S4RK2IT3gw7CqRodpgcQhEtL4UQlYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=P1Mtrppw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o2FW1LwikUFX7Iza14GzLVZ2EUI8Q6mAqDNM66cGoVg=; b=P1MtrppwVIKueftVN8qudNjoVG
	zHhZC95VVBBbek9eGZMwvddGZust+px+2twMqoLtoD3tbGBTpcULVmpO9pelP3s3vyOY/4NGIlgE2
	/hULQdyRglgVbfOJA6VwNj4wFGyElmDvYKBglXX5Fv04YYCd57fEoWHLUxv/fqN5apqrd2J8uSQuA
	8hfV/lX3hUP3nvSjeUqRWqoB03Mnn+7G8c/2n5R65XYpEcTgdN0r/oYYR8leRCMnVFb29Ju4hwC90
	ELehRWPot0slPp7vfpP7KPohFxf0Bgq5AZtrKz77bsXX1W1WJhRpBJsdmHZswlPbMEffWY1xHkg6q
	HjRnm1xA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37106 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uycO6-00000000685-1dhS;
	Tue, 16 Sep 2025 21:34:54 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uycO5-00000005xb0-2JbY;
	Tue, 16 Sep 2025 21:34:53 +0100
In-Reply-To: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
References: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 2/5] net: dsa: mv88e6xxx: remove unused TAI
 definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uycO5-00000005xb0-2JbY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 16 Sep 2025 21:34:53 +0100

Remove the TAI definitions that the code never uses.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/ptp.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 24c942d484be..d66db82d53e1 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -33,25 +33,6 @@
 /* Offset 0x01: Timestamp Clock Period (ps) */
 #define MV88E6XXX_TAI_CLOCK_PERIOD		0x01
 
-/* Offset 0x02/0x03: Trigger Generation Amount */
-#define MV88E6XXX_TAI_TRIG_GEN_AMOUNT_LO	0x02
-#define MV88E6XXX_TAI_TRIG_GEN_AMOUNT_HI	0x03
-
-/* Offset 0x04: Clock Compensation */
-#define MV88E6XXX_TAI_TRIG_CLOCK_COMP		0x04
-
-/* Offset 0x05: Trigger Configuration */
-#define MV88E6XXX_TAI_TRIG_CFG			0x05
-
-/* Offset 0x06: Ingress Rate Limiter Clock Generation Amount */
-#define MV88E6XXX_TAI_IRL_AMOUNT		0x06
-
-/* Offset 0x07: Ingress Rate Limiter Compensation */
-#define MV88E6XXX_TAI_IRL_COMP			0x07
-
-/* Offset 0x08: Ingress Rate Limiter Compensation */
-#define MV88E6XXX_TAI_IRL_COMP_PS		0x08
-
 /* Offset 0x09: Event Status */
 #define MV88E6352_TAI_EVENT_STATUS		0x09
 #define MV88E6352_TAI_EVENT_STATUS_ERROR	0x0200
@@ -63,13 +44,6 @@
 #define MV88E6352_TAI_TIME_LO			0x0e
 #define MV88E6352_TAI_TIME_HI			0x0f
 
-/* Offset 0x10/0x11: Trig Generation Time */
-#define MV88E6XXX_TAI_TRIG_TIME_LO		0x10
-#define MV88E6XXX_TAI_TRIG_TIME_HI		0x11
-
-/* Offset 0x12: Lock Status */
-#define MV88E6XXX_TAI_LOCK_STATUS		0x12
-
 /* Offset 0x00: Ether Type */
 #define MV88E6XXX_PTP_GC_ETYPE			0x00
 
-- 
2.47.3


