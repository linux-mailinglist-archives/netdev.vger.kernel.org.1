Return-Path: <netdev+bounces-283240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GsxONzZ9GmfFQIAu9opvQ
	(envelope-from <netdev+bounces-283240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:50:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D804AE2FD
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E9BA3010382
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7668F413244;
	Fri,  1 May 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soslab.tu-darmstadt.de header.i=@soslab.tu-darmstadt.de header.b="Qzc8N4Qc"
X-Original-To: netdev@vger.kernel.org
Received: from c2682.mx.srv.dfn.de (c2682.mx.srv.dfn.de [194.95.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD753FBEA4;
	Fri,  1 May 2026 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654218; cv=none; b=YwwDjVbaQDzbGauRVF6xPNcAsBBPdjIplXOpMuQetv+AMuTLaN/Fn3sJWxyyzGoFWJET4iIJZUZsMcc8H4z/AsKP8NVRG461jlSsO2j1yG3kmZivczgHBUGTgUPqvETD5VKIsOoVSwdtKBB6kmGtXUw6/vdxMvP9EgnVR69w10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654218; c=relaxed/simple;
	bh=7GvWlYJ66GEsKXxb5c+BB1NizN+kBkLoRH4YlKVEf9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDEpT08/ipQvontHj/FL6N/SpdQsEUfl6L6E2IIJJnLXho68QPQaYAG8S/aSa4ZypB9BycK1YtegGGlBla5Q6tKJTHkNqOIjmy8pPwqOtsd/Zqi3TUlvi6WYs1f09v9KdbAhJJdol2jn1oMKut3pq654gOEDmd6pSYXQqUkBozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soslab.tu-darmstadt.de; spf=pass smtp.mailfrom=soslab.tu-darmstadt.de; dkim=pass (1024-bit key) header.d=soslab.tu-darmstadt.de header.i=@soslab.tu-darmstadt.de header.b=Qzc8N4Qc; arc=none smtp.client-ip=194.95.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soslab.tu-darmstadt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soslab.tu-darmstadt.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	soslab.tu-darmstadt.de; h=content-transfer-encoding:mime-version
	:message-id:date:date:subject:subject:from:from:received; s=s1;
	 t=1777653596; x=1779467997; bh=7GvWlYJ66GEsKXxb5c+BB1NizN+kBkLo
	RH4YlKVEf9M=; b=Qzc8N4Qc0Xxdm5YkvPaWLZ7jvevJXkG0bONxEbqblwRjn0MU
	wPXiJo8xPYOSXT0w6OJvjAgGaNo/jSWclBtzZEPldi/6LmkkA4yhU9apk7VCajya
	G3MoALID5y0KsBbVrG2HTNHAyRsSYzu6c8PZdzaek0CaRfue+38nP6GZlKM=
Received: from mail-relay150.hrz.tu-darmstadt.de (mailout.hrz.tu-darmstadt.de [130.83.252.150])
	by c2682.mx.srv.dfn.de (Postfix) with ESMTPS id 4D511438;
	Fri,  1 May 2026 18:39:54 +0200 (CEST)
Received: from smtp.tu-darmstadt.de (mail-relay158.hrz.tu-darmstadt.de [IPv6:2001:41b8:83f:1611::158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mail-relay158.hrz.tu-darmstadt.de", Issuer "GEANT TLS RSA 1" (not verified))
	by mail-relay150.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4g6cG04RMVz43Vv;
	Fri,  1 May 2026 18:39:52 +0200 (CEST)
From: Markus Baier <Markus.Baier@soslab.tu-darmstadt.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Baier <Markus.Baier@soslab.tu-darmstadt.de>
Subject: [PATCH net] net: usb: asix: ax88772: re-add usbnet_link_change() in phylink callbacks
Date: Fri,  1 May 2026 18:39:41 +0200
Message-ID: <20260501163941.107668-1-Markus.Baier@soslab.tu-darmstadt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Header-TUDa: <oLVU8RZcsZEyAQfzRmgEF3b1uXjKJR8xr9rjOseZUALhHMCE0j7fB4s3GsGmqsRPyzo3qQyFCncAZxJRB4qZR58VDy64pXzojSOaT.1777653593>
X-TUDa-Umlauf: 1
X-Rspamd-Queue-Id: 41D804AE2FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-darmstadt.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[soslab.tu-darmstadt.de:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,soslab.tu-darmstadt.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283240-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Baier@soslab.tu-darmstadt.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[soslab.tu-darmstadt.de:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Commit e0bffe3e6894 ("net: asix: ax88772: migrate to phylink") replaced
the asix_adjust_link() PHY callback with phylink's mac_link_up() and
mac_link_down() handlers, but did not carry over the usbnet_link_change()
notification that commit 805206e66fab ("net: asix: fix "can't send until
first packet is send" issue") had added.

As a result, the original symptom returns: when the link comes up,
usbnet is never notified, so the RX URB submission stays dormant until
some other event (e.g. a transmitted packet triggering the status
endpoint interrupt) wakes it up.

This is reproducible with the Apple A1277 USB Ethernet Adapter
(05ac:1402, AX88772A based) on a Banana Pro using a static IPv4
configuration. After bringing the interface up, no incoming packets are
received until the first outgoing frame triggers usbnet's RX path.

Restore the link change notification, gated on a carrier transition so
the call remains idempotent if the status endpoint also reports the
change later.

Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Markus Baier <Markus.Baier@soslab.tu-darmstadt.de>
---

Transparency notice: The English formulation of this bug report was
prepared with AI assistance. The actual system testing and verification
of the issue were performed manually without AI involvement.
The bug was originally located via git bisect between v5.13 (good)
and v5.14 (first bad), pointing to commit e532a096be0e ("net: usb: asix:
ax88772: add phylib support"). Commit 805206e66fab later fixed this in
v5.19, but commit e0bffe3e6894 (phylink migration in v6.x) re-introduced
the same symptom by replacing the asix_adjust_link() callback path
without porting the usbnet_link_change() call to the new phylink
mac_link_up/down handlers.

First Tested on Linux 6.18.18-gentoo with Apple A1277 USB Ethernet Adapter
(05ac:1402, AX88772A based) on a Banana Pro (Allwinner A20).
Later on Linux 7.1.0-rc1 with identical hardware setup.

 drivers/net/usb/asix_devices.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index df0bcfedddbc..293ef80c4e30 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -756,6 +756,7 @@ static void ax88772_mac_link_down(struct phylink_config *config,
 	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
 
 	asix_write_medium_mode(dev, 0, 0);
+	usbnet_link_change(dev, false, false);
 }
 
 static void ax88772_mac_link_up(struct phylink_config *config,
@@ -786,6 +787,7 @@ static void ax88772_mac_link_up(struct phylink_config *config,
 		m |= AX_MEDIUM_RFC;
 
 	asix_write_medium_mode(dev, m, 0);
+	usbnet_link_change(dev, true, false);
 }
 
 static const struct phylink_mac_ops ax88772_phylink_mac_ops = {
-- 
2.52.0


