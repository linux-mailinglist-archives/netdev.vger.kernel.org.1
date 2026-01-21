Return-Path: <netdev+bounces-252056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO2oD3VJcWn2fgAAu9opvQ
	(envelope-from <netdev+bounces-252056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:47:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C345E3FF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E859478BE52
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A063C1981;
	Wed, 21 Jan 2026 21:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E22773D3;
	Wed, 21 Jan 2026 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029991; cv=none; b=NQHKQiduIydUwML5FuI2EDtvczOPH+tOjBlYeAWriORisLJo8wZmLfvV6kcDoGXvp5F7P982phRX+elcuSVI5aUL+ac8nTzZdPJoXTjDpsGbf4r2VVtNdQgqCVhu98W/ylI1p0Six8kmCindjqrTtoyx+/1kIjVPEEWQl+BjxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029991; c=relaxed/simple;
	bh=rTBdgbSR21dbK7W1PBFG2/WELIE+BRCOHhtTd/t/ma4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q6GcFmmHE/smoe/8db1G97hmY0aQixag+c6rSUwI9l6ubiljjE2fx9DnFQt8bsPujYqbqJW7yF0Vz5/YJ4EGYWRQTntd0pc1BwgPMuBmr1IbBapdr7DQ0z3wPq1oygvT0TA8ogWVytRLDK7IrKMOhi4MXhJDtq5kEd59neXbmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vifVb-000000004n1-1z2f;
	Wed, 21 Jan 2026 21:12:59 +0000
Date: Wed, 21 Jan 2026 21:12:56 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH RFC net-next] net: phy: add (*register_phy)() hook to struct
 mii_bus
Message-ID: <34ac2837b01f53ace02c613a57a03a74d9a056b0.1769029647.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [1.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-252056-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gmx.de];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,makrotopia.org:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E8C345E3FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some MDIO busses require to program PHY polling registers depending on
the PHY type. RealTek switch SoCs are the most prominent example of a
DSA switch which doesn't allow to program MAC speed, duplex and
flow-control settings without using PHY polling to do so.

Hence there is a need to inform the MDIO bus driver that a PHY has been
registered on the bus, as otherwise the bus driver will have to reinvent
and duplicate all the bus scanning logic for Clause-22 and Clause-45
PHYs.

Provide a simple hook in struct mii_bus which is called right after a
PHY has been registered on the bus.

Alternative ways which would allow to do the same things without
having to change any kernel code would of course be very welcome.

Link: https://github.com/openwrt/openwrt/pull/21515#discussion_r2714069716
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/phy_device.c | 8 ++++++++
 include/linux/phy.h          | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f624218bf3664..97c7b69f7031b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1130,8 +1130,16 @@ int phy_device_register(struct phy_device *phydev)
 		goto out;
 	}
 
+	if (phydev->mdio.bus->register_phy) {
+		err = phydev->mdio.bus->register_phy(phydev);
+		if (err)
+			goto register_hook_err;
+	}
+
 	return 0;
 
+ register_hook_err:
+	device_del(&phydev->mdio.dev);
  out:
 	/* Assert the reset signal */
 	phy_device_reset(phydev, 1);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5972f19af16da..1d38e27d20389 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -377,6 +377,9 @@ struct mii_bus {
 	/** @reset: Perform a reset of the bus */
 	int (*reset)(struct mii_bus *bus);
 
+	/** @register_phy: Called for each PHY detected on the bus */
+	int (*register_phy)(struct phy_device *phydev);
+
 	/** @stats: Statistic counters per device on the bus */
 	struct mdio_bus_stats stats[PHY_MAX_ADDR];
 
-- 
2.52.0


