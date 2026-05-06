Return-Path: <netdev+bounces-284637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAudAPqU+mnqPwMAu9opvQ
	(envelope-from <netdev+bounces-284637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:10:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 092274D5290
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B67E8301A908
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF32264C7;
	Wed,  6 May 2026 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soslab.tu-darmstadt.de header.i=@soslab.tu-darmstadt.de header.b="Jj+1HVRm"
X-Original-To: netdev@vger.kernel.org
Received: from b2682.mx.srv.dfn.de (b2682.mx.srv.dfn.de [194.95.235.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC25C2FF;
	Wed,  6 May 2026 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.235.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029810; cv=none; b=O4V0wbPindy1qd8F3sD7kIxRUIPO2yVAOZBOmy/C8ylHVzWSgzgIfHZGv9QoS/+SVQuEgGdUgPGkLP3ovB8uIvL6rmVKC/frp7caU7vO0MBWvFvmx0mEsf5IULLA8h/WkSNHfMYFvoIf7ayy7sUH4EguPYS+G6b6hX8tdx7/KeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029810; c=relaxed/simple;
	bh=KRBLQQniWdVBGFlggN0DOG8w40a6ggoj4/AvXMfCcMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sF3+mzpm4glv28+RO6Gt6ywhfXPcItmBXFfnX1veF1YrkoioKkjkzXZT9e8pj2OaFIeHIE44tXxtkrY7MjJiImQ+LbR7yvbO6dHsqv19n1PrAUUZJ5rYnaKyXY6znSH1veoLEfIpLPcOtcop/hONuU/6DqXm7lN+e8RkPLMsk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soslab.tu-darmstadt.de; spf=pass smtp.mailfrom=soslab.tu-darmstadt.de; dkim=pass (1024-bit key) header.d=soslab.tu-darmstadt.de header.i=@soslab.tu-darmstadt.de header.b=Jj+1HVRm; arc=none smtp.client-ip=194.95.235.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soslab.tu-darmstadt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soslab.tu-darmstadt.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	soslab.tu-darmstadt.de; h=content-transfer-encoding:mime-version
	:message-id:date:date:subject:subject:from:from:received; s=s1;
	 t=1778029459; x=1779843860; bh=KRBLQQniWdVBGFlggN0DOG8w40a6ggoj
	4/AvXMfCcMc=; b=Jj+1HVRm8vZmN5SI4kGnjBjN6m4vGjZU9EIG5XmKkQQXzX/G
	S3nvcnku+i9FDEqCFlFOV8qBQzW2Ha6AYAYjfJrRTwHgl8GzY4lU7xtzMf8qFrJE
	8OSlDg6NpNpSjhFjwJTf4jFVIbhMBxuqK225hFpp3YU1d0NM5PHw78d2p5M=
Received: from mail-relay152.hrz.tu-darmstadt.de (mail-relay152.hrz.tu-darmstadt.de [130.83.252.152])
	by b2682.mx.srv.dfn.de (Postfix) with ESMTPS id BCAC63A0112;
	Wed,  6 May 2026 03:04:16 +0200 (CEST)
Received: from smtp.tu-darmstadt.de (mail-relay238.hrz.tu-darmstadt.de [130.83.156.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mail-relay238.hrz.tu-darmstadt.de", Issuer "GEANT TLS RSA 1" (not verified))
	by mail-relay152.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4g9HG70TbSz442D;
	Wed,  6 May 2026 03:04:15 +0200 (CEST)
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
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Markus Baier <Markus.Baier@soslab.tu-darmstadt.de>
Subject: [PATCH net] net: usb: asix: ax88772: replace usbnet_link_change() with queue_work() and usbnet_unlink_rx_urbs()
Date: Wed,  6 May 2026 03:03:44 +0200
Message-ID: <20260506010344.184636-1-Markus.Baier@soslab.tu-darmstadt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Header-TUDa: <X1qhTH9GVSVqlQq3atM0WKFwVN9uDwkBY9TBSEJJNbxcGN2t4lQ1ds1dJw5lITIP7ddAtyOj9zJBY2o2FpFo1I2i6zXYZmJS54q5.1778029456>
X-TUDa-Umlauf: 1
X-Rspamd-Queue-Id: 092274D5290
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-darmstadt.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[soslab.tu-darmstadt.de:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,soslab.tu-darmstadt.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284637-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-darmstadt.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Commit 36bdc0e815b4 ("net: usb: asix: ax88772: re-add usbnet_link_change()
in phylink callbacks") restored the link-change notification that was
lost during the phylink migration, by calling usbnet_link_change() from
the phylink mac_link_up() / mac_link_down() callbacks.

While this fixed the original symptom (RX URB submission not being
initiated after link up), usbnet_link_change() also calls
netif_carrier_off() on link-down, which is redundant in a phylink-based
driver because phylink manages the carrier state itself.

Replace the usbnet_link_change() calls with the minimal operations:

  - In ax88772_mac_link_up(), schedule dev->bh_work directly via
    queue_work(system_bh_wq, &dev->bh_work). This is the same
    mechanism usbnet_open() uses to schedule the bottom-half
    that submits RX URBs.

  - In ax88772_mac_link_down(), call usbnet_unlink_rx_urbs() to
    return any in-flight RX URBs to the host controller.
    This releases USB bandwidth and avoids keeping unused buffers
    queued while the link is down. This is the symmetric
    counterpart to scheduling new RX URBs on link up.

Tested with the Apple A1277 USB Ethernet Adapter (05ac:1402,
AX88772A based) on a Banana Pro (Allwinner A20).

Fixes: 36bdc0e815b4 ("net: usb: asix: ax88772: re-add usbnet_link_change() in phylink callbacks")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Markus Baier <Markus.Baier@soslab.tu-darmstadt.de>
---

Transparency notice: The English formulation of this commit message
was prepared with AI assistance. The actual system testing and
verification of the issue were performed manually without AI
involvement.

This is a follow-up to commit 36bdc0e815b4 (just applied to net.git).
While that patch correctly restored the missing RX URB submission,
I realized during further analysis that usbnet_link_change() carries
side effects (notably calling netif_carrier_off() on link-down) that
are redundant in a phylink-based driver. After studying how
usbnet_open() handles the same task (direct queue_work() call), this
minimal approach better matches the existing usbnet patterns.

I am sending this now rather than waiting, because the previous patch
just landed and I would like the cleanup to be considered before it
propagates further into stable kernels via the Fixes: tag.

 drivers/net/usb/asix_devices.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 293ef80c4e30..4230ff611c4b 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -756,7 +756,11 @@ static void ax88772_mac_link_down(struct phylink_config *config,
 	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
 
 	asix_write_medium_mode(dev, 0, 0);
-	usbnet_link_change(dev, false, false);
+
+	/* Phylink will call netif_carrier_off(), but we should explicitly
+	 * stop RX URBs to save USB bandwidth.
+	 */
+	usbnet_unlink_rx_urbs(dev);
 }
 
 static void ax88772_mac_link_up(struct phylink_config *config,
@@ -787,7 +791,11 @@ static void ax88772_mac_link_up(struct phylink_config *config,
 		m |= AX_MEDIUM_RFC;
 
 	asix_write_medium_mode(dev, m, 0);
-	usbnet_link_change(dev, true, false);
+
+	/* Phylink will call netif_carrier_on(), but we need to explicitly
+	 * kick off RX URB submission in usbnet.
+	 */
+	queue_work(system_bh_wq, &dev->bh_work);
 }
 
 static const struct phylink_mac_ops ax88772_phylink_mac_ops = {
-- 
2.52.0


