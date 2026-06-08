Return-Path: <netdev+bounces-296594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d67rCsLNJmpDkwIAu9opvQ
	(envelope-from <netdev+bounces-296594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:12:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE160656FC2
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:12:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=rDVqYFsE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296594-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296594-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4349330347F4
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13393D0C12;
	Mon,  8 Jun 2026 14:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A563CE0AE;
	Mon,  8 Jun 2026 14:10:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927827; cv=none; b=A0nR9K+Yg1i143dP3skz4T1l2mtN3PfzH7zqV500tRzr1KtooC0dLxz0yuyDtBaI7Uxkx9cludJMvYrcsksvSVzQWvRi4dbgezbI+hftD1DGwCsjyxjlZRWrtuSBC0eFiJo0FtXcDtvVijfWCnYj9ADjVebeFqYh7ysUwhwL0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927827; c=relaxed/simple;
	bh=EwijWD23hDssNIEkbyfh+Uz89hya5rVeY91Tem7LUME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dteT7bCj8MLgDFGddVGmQUSahMXA5pFxZSbJlqX0fCZFufJ+ZAtuTFuTYalEVV+3nZ2bfiNzDvIMpvNbJABEzXlW/5dhRHYyEYTvri3+vnrgNlLZi001v6l90mQzHOtr9j/s3BdXYuLKvIPirc1sN715KUXGeqw3tvaPnUP4qFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rDVqYFsE; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E914C4E4164C;
	Mon,  8 Jun 2026 14:10:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B505B5FFB7;
	Mon,  8 Jun 2026 14:10:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54E1E106A2971;
	Mon,  8 Jun 2026 16:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780927823; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tgNlGLqd4G7S3qN72u1yK4SQbSRdoynLTaxb/x8vdb4=;
	b=rDVqYFsEW4Pz7lmw/4jjU1d8YR+nxeNwGkHq2NMuRbJevF7uNbhZc4Mz5UyxYOyKzwPuhz
	QQ8u2uKh2NKidJ6SnMdCc5gO9BDZIWdLZfQ7jIHaYw08z9AAyEFw4MnyZrfV1Uz9dwf9vD
	xT1+DTZZcyz0p/ckL41gUgzo7A2lpbWcxOvPPlmbd5zdjV5lqXfGF56Cgui39g7Sx/gWsp
	VUBQMzY1m103a5/yF5uwSDPftUjVvVrk1YSl+fGSWeOBkuxvZhJpMzVXn5MKRzxx3FjIrC
	X0J/RVn8EQz91mk+nrnHl50E7HPu1rkea2oZahuYAKSwhWiDHZoc1lg9AqZHhg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 16:10:07 +0200
Subject: [PATCH net-next v2 04/10] net: dsa: microchip: wrap the MAC
 configuration checks in a function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-clean-ksz-3rd-v2-4-6e61b7be23c4@bootlin.com>
References: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
In-Reply-To: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296594-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:tristram.ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE160656FC2

The common .mac_config() implementation checks some conditions before
doing any register access. As this common implementation is about to be
split in the upcoming patch, these checks would lead to code
duplication.

Wrap all the checks in a need_config() function that returns true when
the driver really need to access the switch registers to configure the
MAC.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 30 +++++++++++++++++++++---------
 drivers/net/dsa/microchip/ksz_common.h |  1 +
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 5fb151fbf4f3..f29287922843 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3211,9 +3211,8 @@ phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit)
 	return interface;
 }
 
-void ksz_phylink_mac_config(struct phylink_config *config,
-			    unsigned int mode,
-			    const struct phylink_link_state *state)
+bool ksz_phylink_need_config(struct phylink_config *config,
+			     unsigned int mode)
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct ksz_device *dev = dp->ds->priv;
@@ -3221,21 +3220,34 @@ void ksz_phylink_mac_config(struct phylink_config *config,
 
 	/* Internal PHYs */
 	if (dev->info->internal_phy[port])
-		return;
+		return false;
 
 	/* No need to configure XMII control register when using SGMII. */
 	if (ksz_is_sgmii_port(dev, port))
-		return;
+		return false;
 
 	if (phylink_autoneg_inband(mode)) {
 		dev_err(dev->dev, "In-band AN not supported!\n");
-		return;
+		return false;
 	}
 
-	ksz_set_xmii(dev, port, state->interface);
+	return true;
+}
 
-	if (dev->dev_ops->setup_rgmii_delay)
-		dev->dev_ops->setup_rgmii_delay(dev, port);
+void ksz_phylink_mac_config(struct phylink_config *config,
+			    unsigned int mode,
+			    const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+	int port = dp->index;
+
+	if (ksz_phylink_need_config(config, mode)) {
+		ksz_set_xmii(dev, port, state->interface);
+
+		if (dev->dev_ops->setup_rgmii_delay)
+			dev->dev_ops->setup_rgmii_delay(dev, port);
+	}
 }
 
 bool ksz_get_gbit(struct ksz_device *dev, int port)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 804912fdd2db..c377bd3e5542 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -468,6 +468,7 @@ void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
 void ksz_phylink_mac_disable_tx_lpi(struct phylink_config *config);
 int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
 				  u32 timer, bool tx_clock_stop);
+bool ksz_phylink_need_config(struct phylink_config *config, unsigned int mode);
 void ksz_phylink_mac_config(struct phylink_config *config,
 			    unsigned int mode,
 			    const struct phylink_link_state *state);

-- 
2.54.0


