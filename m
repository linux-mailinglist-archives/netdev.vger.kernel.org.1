Return-Path: <netdev+bounces-257890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNKtGVZPiWm66QQAu9opvQ
	(envelope-from <netdev+bounces-257890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 04:07:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A457A10B547
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 04:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 997943005650
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 03:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71FE2ECD37;
	Mon,  9 Feb 2026 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju/b4sNK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8412D6E72
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606419; cv=none; b=qNn98SGVyXv+liXriMBOnlKI2N70b92bNL2rebPLkJyDfLnurVcsM+CThM6ji2DT8X2dqqLMR+BTichuXdU/AEqMwL+cU0H54IybTKmbjlW1oxIzfYGsuMALww8/xdUzT9Aq0Amtfp+RL4VF+ZzsV8nxEQhejp29gkRIIHEJzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606419; c=relaxed/simple;
	bh=sP88QMBkB5WFeA9rGvVYUSHloFGHJ5YYBpExVoA4Bog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tv/WPHX4OpHLi83fKXuQBtTG85R1TV3jn1WAdv209LDCwDg6a+tC6e8tHHu3wgUaFgPeACgaWAuyGqTDuwlP5DeOlFCBus3vpobrU0z5doCe4zCF0w0C2wTd8mXLVkXHJduh9uHIMDPNijfa27cJM7RFv5t1YMXZn9PrFFfu6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju/b4sNK; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b81ebac5d6so4456660eec.1
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 19:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770606419; x=1771211219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DaqSbH53nnDwnuyvIsMb4KYjYHN14JziBMff4wFVy4A=;
        b=ju/b4sNKOHFeRqvDZz1eyICuNipmykToep7K2WAHrLoLGEAdRqwM3g0j2s7rzpuH5i
         kBTJpFmuAhdbozITH9CZyUS99lY6czz0KfMW57yLkPXTdiIFSwA56dYP17d5LwgwVJl1
         QKSjPHECxjNKkpICroom699XEKp9nmXoQc6VFlfdGhA0Ohh4ZXN1H9kyn06sy8shlKPC
         d9ipJkELzSbzeS5thFis+JqCqlEZSF3CbPuXK6g3Kp05/oNtmrW7T6JogEeLCZHcV4WO
         1JyU/aSXHVYj0WYfDEre9EEAei8Npi+xQrYuDs/W6T3l7+8GVpYOx1NnaPMT/uVg46d+
         EF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770606419; x=1771211219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaqSbH53nnDwnuyvIsMb4KYjYHN14JziBMff4wFVy4A=;
        b=m9u8mJ0IC2xy8QaHSfo+e3Jf3+/C4SUI5KZoPdaNBkXWAKj6U7Tw41c5lcWQsXdJTO
         GdWuFWybTF9QSI7Q6n66eZNVDeQFgShyNrUnMvr+USmGfH5z73LCWKK6UUDRlYO8+Emn
         Q49YLQ/W6NDRcGFGLLs/pg+pK4J+fOGp2O891VIF/aUrogC0oX6gx0jtpRCHfM5vX+WF
         tUtJUGES2giWIuX0rZVpzB1DlsWYk2INlu3MY7BCKxzyPQrLXvEYWGyt5pre71GtHdg6
         TIVBdY0elKGmsQ79uU6qpYxXZxr7WhIPBbYxzXyE1PDzp8emeyKG4mWiQ1y1wVRp6qd3
         Wsvg==
X-Gm-Message-State: AOJu0YzX9UNBKZlGTozX6LqD+ko1D9vYleBDJlHuMi4mr48iGgaZKgYS
	4zyLa7wcWLDLfBlOz1TLntHDZYFSSw8ouoKmdmSaZFaTwye1tw10GcQ174+t4IB4
X-Gm-Gg: AZuq6aJJoQnNuxlLfbPX6r3aDVWaVam1Cdjud5SnsKJhqq03d27cN8Gf0/QyXhQ4sBt
	dDRGnsLzFPtQloBNdpeK2OmhTjXNUCjSmU3x+DI5VPAIP6QinYmP+5cRa1/RnrI9y4Z2kAf/Job
	3Y2MMe3L8Y7NOpvu9jvwua+ksiA8DMpHz1lJIpjfbGaFM0iOUUU30JueZ1nrkAsv6tle6+d4+ki
	cBWp5Pzd85n296LMk+bcTVldz2NAL8tUqFyaOtiyNn61VkLeNRWRaPWy8XJI3LtEaOcs+ucZpgK
	bE2Xg0yKEZbgiiAI+NHPEu6X2Qxbp9+4/QoWNIDyWU2pYRZJ/f9yx/aoZ5GjfDb6dfQZr0+Bk6t
	c1kloAnCQGvsbr9UFjX8np3uhbdfWoq52LVom7AnE3YlnBAuYsCNbrugt5I37ZrT0f46FrCIc/p
	cO+WHaVU8UwQV4pYTwJHKrpKhz1wcacf3Njb5TffTOn1UigiyTxdqaarn4ON+qjL67vmkEq08tO
	/+I20iog2UQ9ll4atx1Hh1vvZ7aFLEMm4+mJbrjsg2zDzg2rWaHVm+TTlgwGY3C8i/Bi4KnPLEk
	H5ZTtxUx
X-Received: by 2002:a05:7300:a494:b0:2ae:5e93:b6d with SMTP id 5a478bee46e88-2b856a3bcacmr4289843eec.38.1770606418649;
        Sun, 08 Feb 2026 19:06:58 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-120.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c6a574sm6640177eec.26.2026.02.08.19.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 19:06:58 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: arcnet: com20020: remove misleading references to multicast
Date: Sun,  8 Feb 2026 19:06:48 -0800
Message-ID: <20260209030649.54779-1-enelsonmoore@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257890-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A457A10B547
X-Rspamd-Action: no action

ARCnet does not support multicast, only unicast and broadcast. In spite
of this, the com20020 driver contains several references to multicast
in a comment and a function name, including a FIXME that it should be
implemented. Adjust the comment to make the lack of multicast support
clear and rename com20020_set_mc_list to com20020_set_rx_mode.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/com20020.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index b8526805ffac..f2fa26626a06 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -56,7 +56,7 @@ static void com20020_copy_to_card(struct net_device *dev, int bufnum,
 				  int offset, void *buf, int count);
 static void com20020_copy_from_card(struct net_device *dev, int bufnum,
 				    int offset, void *buf, int count);
-static void com20020_set_mc_list(struct net_device *dev);
+static void com20020_set_rx_mode(struct net_device *dev);
 static void com20020_close(struct net_device *);
 
 static void com20020_copy_from_card(struct net_device *dev, int bufnum,
@@ -194,7 +194,7 @@ const struct net_device_ops com20020_netdev_ops = {
 	.ndo_start_xmit = arcnet_send_packet,
 	.ndo_tx_timeout = arcnet_timeout,
 	.ndo_set_mac_address = com20020_set_hwaddr,
-	.ndo_set_rx_mode = com20020_set_mc_list,
+	.ndo_set_rx_mode = com20020_set_rx_mode,
 };
 
 /* Set up the struct net_device associated with this card.  Called after
@@ -362,14 +362,8 @@ static void com20020_close(struct net_device *dev)
 	arcnet_outb(lp->config, ioaddr, COM20020_REG_W_CONFIG);
 }
 
-/* Set or clear the multicast filter for this adaptor.
- * num_addrs == -1    Promiscuous mode, receive all packets
- * num_addrs == 0       Normal mode, clear multicast list
- * num_addrs > 0        Multicast mode, receive normal and MC packets, and do
- *                      best-effort filtering.
- *      FIXME - do multicast stuff, not just promiscuous.
- */
-static void com20020_set_mc_list(struct net_device *dev)
+/* ARCnet does not support multicast, only unicast and broadcast */
+static void com20020_set_rx_mode(struct net_device *dev)
 {
 	struct arcnet_local *lp = netdev_priv(dev);
 	int ioaddr = dev->base_addr;
-- 
2.43.0


