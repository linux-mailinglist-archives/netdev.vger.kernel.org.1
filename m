Return-Path: <netdev+bounces-77877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DE88734E9
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6214C1C2149F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464BA605BC;
	Wed,  6 Mar 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qjbgz0Gd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D79605C1
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722316; cv=none; b=jfCTyoqHwLhEIjZ6uKouMH0T2jqIEABGkCR6p40IOfiuJFfViqAU3qlzIHYUwt35YGg/q8XHkAeJOHyCxqSZp6xL/MOwtGR7QnQ52JAj+I2Xm9y5mdAG5kq0jsO+ZipC9vehMhHEIP9+7stYdSe/BdWtX8bL0iTb5kr3Crxkk60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722316; c=relaxed/simple;
	bh=Ai5XUeYWY7m5UdE8ivmlng10MvcLCg5V3NRUBRP8jE8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=ncO9WsbcB5UwU64jfoI4xi8B6MIFXqnmMOkoZXPkU6yCrzBY4eH0TZK4saDa/9icxYRsq4flMpZNKAh9rYF289K5ocyJJvAhHPp7F6x3tK+oD3QnXgPdL0OOX27Ht3gNk1rWzNjbforPCkfQKgzGQ5DDgfVK94kxKbQsZh125wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qjbgz0Gd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iMxq7wGaQtNUNJ3btHRHcTEf22rhn6zJsm0bjGykuVY=; b=Qjbgz0GdEj5lJnk34EJSoZVZuT
	EeVB+EQmx9KsIrmfw93iuAJyzOaQsL4UrcEtORp5xsDxifmZteNAZFt3WOQ90Z9GYs3/wG41HckPc
	Olm49PaEk26+7RMBj5y1uLOq5940FOP8gomd2YfUTiyE+nh4ETOnHSNoirxn3a1kywQ1Eb2j0YKHd
	w1vpLkOSaLxXZLwAgdGr9wZzfcjzF5tdPGqjar2CAWYCaWwXhyBaT6BnLj3jFc27LK9qxEx90qxQg
	tDlz0ohnAdaNzIe7AFMrayVIOGxx5efoxdwFNBKbuSdcQLQZ4Ji08FrS0AQuAEJtQkPoeQWxtrMpX
	N6SjYXXA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33028 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rhosE-0008FN-1w;
	Wed, 06 Mar 2024 10:51:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rhosE-003yuc-FM; Wed, 06 Mar 2024 10:51:46 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: mv88e6xxx: update 88e6185 PCS driver to
 use neg_mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rhosE-003yuc-FM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 06 Mar 2024 10:51:46 +0000

Update the Marvell 88e6185 PCS driver to use neg_mode rather than the
mode argument to match the other updated PCS drivers.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/pcs-6185.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/pcs-6185.c b/drivers/net/dsa/mv88e6xxx/pcs-6185.c
index 4d677f836807..5a27d047a38e 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-6185.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-6185.c
@@ -95,7 +95,7 @@ static void mv88e6185_pcs_get_state(struct phylink_pcs *pcs,
 	}
 }
 
-static int mv88e6185_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
+static int mv88e6185_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				phy_interface_t interface,
 				const unsigned long *advertising,
 				bool permit_pause_to_mac)
@@ -137,6 +137,7 @@ static int mv88e6185_pcs_init(struct mv88e6xxx_chip *chip, int port)
 	mpcs->chip = chip;
 	mpcs->port = port;
 	mpcs->phylink_pcs.ops = &mv88e6185_phylink_pcs_ops;
+	mpcs->phylink_pcs.neg_mode = true;
 
 	irq = mv88e6xxx_serdes_irq_mapping(chip, port);
 	if (irq) {
-- 
2.30.2


