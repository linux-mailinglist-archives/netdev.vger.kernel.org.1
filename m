Return-Path: <netdev+bounces-300589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eZD8Jiq6NGq7fgYAu9opvQ
	(envelope-from <netdev+bounces-300589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 05:40:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6A96A3AF6
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 05:40:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300589-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300589-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0323011F19
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F5D32ED34;
	Fri, 19 Jun 2026 03:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4724B28;
	Fri, 19 Jun 2026 03:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781840422; cv=none; b=UsAK9xlWkOMP+XCkz4Dp77ds88mDbmIAPlRBRd4QE60xRtD40aTpuTnPZqTpOt/Bwe0/xo77ZAnfKn74NwM9wsUpNoFtvv1wDWNzr7AuyP8Kah1IDfK0mVdklqbshOrFUBsVmCOvcR0lpqOKb9aGhYw6KBFYKDqGgdvVuI9xtUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781840422; c=relaxed/simple;
	bh=qMaEb/1jDyJe911fDcHgr8aVGZxyFXF2kI2bsFCdAyE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tzQa32ngDgAgDM7M/JpNBZUtS9n+q4muOL89Y6har10sN2YmGuu8+WCuhXpyOHFsdRg16IXfBj2p+O7m2jE3cDAj2m8XcJcRyeZOviWyhvM6+EOzoV1E9s8gysjtzYjmj9FdQsPtOzW4TbrPPIvAQxtpih4jfuMJfAn4uhkGu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1waQ5Z-0000000013b-0Wvt;
	Fri, 19 Jun 2026 03:40:17 +0000
Date: Fri, 19 Jun 2026 04:40:14 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: dsa: mxl862xx: fix use-after-free of DSA ports
 in crc_err_work
Message-ID: <5e55169926c02f2b914e5ada529d7453b943cda4.1781702256.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300589-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,makrotopia.org:email,makrotopia.org:mid,makrotopia.org:from_mime,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA6A96A3AF6

Upon an MDIO CRC error mxl862xx_crc_err_work_fn() walks the DSA ports
and closes the CPU port conduits:

	dsa_switch_for_each_cpu_port(dp, priv->ds)
		dev_close(dp->conduit);

mxl862xx_remove() unregisters the switch before cancelling this work:

	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
	cancel_delayed_work_sync(&priv->stats_work);
	dsa_unregister_switch(ds);
	mxl862xx_host_shutdown(priv);

dsa_unregister_switch() frees the dsa_port objects. If a CRC error
schedules the work during teardown it can run after the ports have been
freed and dereference freed memory.

Guard the port walk with MXL862XX_FLAG_WORK_STOPPED, which is already set
before dsa_unregister_switch(). DSA tears the ports down under
rtnl_lock(), so checking the flag under rtnl_lock() means the work either
runs before teardown and sees valid ports, or runs afterwards, observes
the flag and skips the walk. This mirrors the host_flood_work handler,
which skips torn-down ports under rtnl_lock().

Link: https://sashiko.dev/#/patchset/cover.1780968180.git.daniel%40makrotopia.org?part=2
Fixes: a319d0c8c8ce ("net: dsa: mxl862xx: add CRC for MDIO communication")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 882c5d960941..4acd216f7cc0 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -41,12 +41,13 @@ static void mxl862xx_crc_err_work_fn(struct work_struct *work)
 						  crc_err_work);
 	struct dsa_port *dp;
 
-	dev_warn(&priv->mdiodev->dev,
-		 "MDIO CRC error detected, shutting down all ports\n");
-
 	rtnl_lock();
-	dsa_switch_for_each_cpu_port(dp, priv->ds)
-		dev_close(dp->conduit);
+	if (!test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags)) {
+		dev_warn(&priv->mdiodev->dev,
+			 "MDIO CRC error detected, shutting down all ports\n");
+		dsa_switch_for_each_cpu_port(dp, priv->ds)
+			dev_close(dp->conduit);
+	}
 	rtnl_unlock();
 
 	clear_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags);
-- 
2.54.0

