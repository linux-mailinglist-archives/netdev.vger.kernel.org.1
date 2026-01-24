Return-Path: <netdev+bounces-253052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCEtBu19dGne6AAAu9opvQ
	(envelope-from <netdev+bounces-253052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:08:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 873027CF37
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0E2D3009FAF
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 08:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE96C26ED33;
	Sat, 24 Jan 2026 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1LefqPs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E2A21CA13
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769242088; cv=none; b=hcipQJuJI1fDi7FnC9niTxb+YAH2sNHFqHBqrgEbJLvED6q9soPO2M2NmWezduaNUXEOH0EjoTC2Ek6I+rqxS/l5ivXEFWqMGp6nBqiK6mK7qyi0MplkQ1zoCCKXGejDix1Ey7GIGrWxj0IVAEmGYC+kxOimO80oDmJ6SgFBA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769242088; c=relaxed/simple;
	bh=mlN9zkh9M3tZt5lOx2N1rJAxHiAi5K7DEEmHZYCmjS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQobw+HB//rLQdd9+SNIyW27ak1dFxdI0TyKWda4KCin7ft/GuOJSrvH2le9Vbop1XI747VakLEm2sQbNxcZ0pmJRGogOnDQumek8TPEZJyq6eVytZKGQOLujfIids63kUw3xIn2Bii3ytqpvDI9P4KdTx5y5Y5qdu+nZlItI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1LefqPs; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so5182784eec.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769242087; x=1769846887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxFsfTf/n8/5lnAFGn+tLoUnsynlfYu93KTb4EE0l88=;
        b=X1LefqPsPeK+XaoKW9/ngCzIzGaeXJ5RndGyNbgGj7pk9CeADoM2b1RDgnQ292GXax
         qhKF0qQZCkRMvWw0YKV9btqA9OCsFCPB36Bwn5LBnba9Hqru03czYM+/pxowLq/jQ6kn
         cSiv937Am6Pw3hBzTdgd5LbEWbaSYpUY7AUUp2udrU0/5YwtShH65C4+Z7iKqld3ZDnn
         3MfCLOcjkBhjcPhkM538w9nwd0gc/OFcXe5HkV/EzjPo0O1el3lgLiJBAi0zHH/eysL7
         NLuMpAIkZJTHACVuL/ONdW7FudCJ6QzF8G9JUs8gN7njYkM6+yHBXWbNwpa7JGDtwfC4
         C6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769242087; x=1769846887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxFsfTf/n8/5lnAFGn+tLoUnsynlfYu93KTb4EE0l88=;
        b=iLrjDoKfLY9sVDnDAHL2th5KO8BxjuCm0KC6TZGERQBFIH0pbtWErfBimTdqXWosFo
         q4bNorBD1TRQRx0GCvsXlRlOdSySSLEe2nVxZxzPHoNDn1aVXhWaa9b5DvgBMCNX0d+d
         KyFU0OHmcH1Lwec9w7vpbMcohMLl91+4g5ZQlEljx7u3pMzRDeHR3IAI+aiDO+7c8Bvs
         pgMCFnIJ2yyfV3/Tubc0eWXmB5J5dAbT4jhrY2eQd/ONbL4G2SExWrlWoYjbhgORa62q
         WU7uvnLdXJMn4uwRHIGK2cJlG/9M8ypKvY4qMBSW6PJOQq2f5IH3CyJXLdz75iZF45Z2
         eI4Q==
X-Gm-Message-State: AOJu0YxcYjp5FQRBqrB3l4qgdIP/9wL5UH3xlFcIxWQzDrypTXaNQJSa
	zg9skQhmLZWzoIzGHX//DOaCdYQL0TL2EwY+82dxdl0lN0UqTXsijCYrjQuxIXKT
X-Gm-Gg: AZuq6aIK32xfQ55lPaUatv8EGFLSrwLuEfm1MyUEtEeIfcn+3k6Ud+FXLJsFpAKukes
	17sRdXA73l4NjkRugYrYSAAqc0egZZU1eBEoh+nQYuEZ5bia9x2lpZywTTqs378OtngdiHz7I+5
	elq0ngls7VClfWqpq1dGdImD4QgHcdkQyeZPpxpxX5WQPboJ3HX9MyRimRmkhIbDwksg60J4q7k
	7fh/FySThCZAyP7b293vPpbyzDWGfqOa6S1uRcRziTMSpkT+oiuaKQSEOoRMoNdMhDJrb+vnwgY
	v7T04gcKYR8MR8s5c4GtSg13AE2tmd1zenHd6ts0fLaC5KAEU8jnOOlAzX67x1DvMCma1PStxjB
	wK/katictJnIDe2lS62coZId5EnfC42LCebZIxeFbtj31lN5J6ttyBbVHu+J6tM6RtF44VvriP0
	Z1VP+xwjvnqmmvQIbRvjRRQqrjqfFB+BWJZ974EABR2yGw0U9TtDqJcld3YI0Umu5ukKKel1993
	o8/KnHttEuKvpCj0/lLdzrD+HROGl7RyBhNrIClPqrOxOR4RPjZrZ7gBhmbjHDizzvFVeA48sk5
	4xWT
X-Received: by 2002:a05:7300:e613:b0:2b7:20c6:36cb with SMTP id 5a478bee46e88-2b739bc033cmr3268834eec.34.1769242086553;
        Sat, 24 Jan 2026 00:08:06 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90d13esm8155986c88.2.2026.01.24.00.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 00:08:06 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: usb: smsc95xx: use phy_do_ioctl_running function
Date: Sat, 24 Jan 2026 00:07:51 -0800
Message-ID: <20260124080751.78488-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,shawell.net,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253052-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 873027CF37
X-Rspamd-Action: no action

The smsc95xx_ioctl function behaves identically to the
phy_do_ioctl_running function. Remove it and use the
phy_do_ioctl_running function directly instead.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/smsc95xx.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index de733e0488bf..c65402d850c9 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -854,14 +854,6 @@ static const struct ethtool_ops smsc95xx_ethtool_ops = {
 	.set_pauseparam	= smsc95xx_set_pauseparam,
 };
 
-static int smsc95xx_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
-{
-	if (!netif_running(netdev))
-		return -EINVAL;
-
-	return phy_mii_ioctl(netdev->phydev, rq, cmd);
-}
-
 static void smsc95xx_init_mac_address(struct usbnet *dev)
 {
 	u8 addr[ETH_ALEN];
@@ -1139,7 +1131,7 @@ static const struct net_device_ops smsc95xx_netdev_ops = {
 	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_mac_address 	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_eth_ioctl		= smsc95xx_ioctl,
+	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_rx_mode	= smsc95xx_set_multicast,
 	.ndo_set_features	= smsc95xx_set_features,
 };
-- 
2.43.0


