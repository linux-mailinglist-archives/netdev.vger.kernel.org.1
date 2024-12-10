Return-Path: <netdev+bounces-150704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74EC9EB334
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476901886B73
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D21AF0A3;
	Tue, 10 Dec 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0LAdcsn6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88F1AE01F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840803; cv=none; b=KKBAkaz8OdBZoMPdLUSLBZSdYzC9p1A0WsRia9rM2eQrYCZLTzkt26QEC4Sb7OpPzW1mK7lYAh6twXmw0sWZf7oR0q8srF+KNf3bg/x2Ljpus8ELkXkkD6++eNYm2n8KYce7K3+TYfnnxqfm5iRFEZgaqWOQH1BzVqqxXrb4LYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840803; c=relaxed/simple;
	bh=DNTQ3ShBoCjk8va+MLNGtNI47YmEdkuV5fB1VcYuoHI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=nPbf/t5tAFkOiDKbrW6LEW565inGu0obYw46JbcB+5OpkQ7ntkOUjMlbKBcUTX/+xxf8KX/2/sNRc8d11rz1O/lf3Y1T0ZeLSi3WipTlaDNHhbGvXBNbSg8J0mWJhqCus3pDydu2Z8z0m3roq+JcYKB+oe3U89aJz6UxN3MU6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0LAdcsn6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LZwopWdr1tHwFB7ck8nb8zB5YRGvsSmHjucSGkcKBg4=; b=0LAdcsn6YNHPX2L7YqP2LHh58R
	BKl1mTvt6Sl6eHut4OMKRw96eAhg2kOZeDeBfs6x7RwoAJ5BLqLNEd79+ihA1yLzxYLNTOl2D0EyM
	7aHm5lUy9E2483O89JmsVxg0nqzAQZ7LIp6PJn0yxdQ8/sty5L2f8JLlsUM3xAvorNJm7KU78DLuj
	kbLpgMxVrxbYkBK5llNCrUh1YhbLlHRmSsx1eo23mbe2Y/gYQBkO3SBif5nkG6tttrz4cXm43jjeD
	U/YE23/TfucB5mp9B5EXQyuYFNvFEFxgwNOoPdvtaS6oC64MUXlsuKb4iCy8qb2veoc/ufiFMzKaU
	HiWEev8g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35634 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tL1C8-0002YU-1P;
	Tue, 10 Dec 2024 14:26:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tL1C6-006cnS-Vc; Tue, 10 Dec 2024 14:26:35 +0000
In-Reply-To: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
References: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH RFC net-next 5/7] net: dsa: mv88e6xxx: remove
 mv88e6xxx_get_mac_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tL1C6-006cnS-Vc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 14:26:34 +0000

mv88e6xxx_get_mac_eee() is no longer called by the core DSA code.
Remove it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 1d78974ea2a3..ddb70047098f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1522,13 +1522,6 @@ static void mv88e6xxx_get_regs(struct dsa_switch *ds, int port,
 	mv88e6xxx_reg_unlock(chip);
 }
 
-static int mv88e6xxx_get_mac_eee(struct dsa_switch *ds, int port,
-				 struct ethtool_keee *e)
-{
-	/* Nothing to do on the port's MAC */
-	return 0;
-}
-
 static int mv88e6xxx_set_mac_eee(struct dsa_switch *ds, int port,
 				 struct ethtool_keee *e)
 {
@@ -7075,7 +7068,6 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_max_mtu		= mv88e6xxx_get_max_mtu,
 	.port_change_mtu	= mv88e6xxx_change_mtu,
 	.support_eee		= dsa_supports_eee,
-	.get_mac_eee		= mv88e6xxx_get_mac_eee,
 	.set_mac_eee		= mv88e6xxx_set_mac_eee,
 	.get_eeprom_len		= mv88e6xxx_get_eeprom_len,
 	.get_eeprom		= mv88e6xxx_get_eeprom,
-- 
2.30.2


