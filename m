Return-Path: <netdev+bounces-296261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MrNjNrCiJWqzJwIAu9opvQ
	(envelope-from <netdev+bounces-296261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 18:56:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A4E65104A
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 18:56:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sartura.hr header.s=sartura header.b=usK1+uiL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296261-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296261-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=sartura.hr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C27B5300251F
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15030EF90;
	Sun,  7 Jun 2026 16:56:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3092F8EAE
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 16:56:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780851371; cv=none; b=n6liRd6DdknEmmlLr/8TRY/LOOHewjUBQQUuF3flOcsK7BLT7h06wK2xNO+xS06hTu9gc/SOe9LDLzN1CBySxD4MNCGhaFmHYiXfjrixLHE3AwMmhMx9c70LpKWIQG9BY6dUUuf5HSg5Ts2aO33Y32UlJH6Tr3SlD0l1MarChcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780851371; c=relaxed/simple;
	bh=RKgDcDPNfLY94yo6BB9eMCgx4LrUtIzIBcqu+7gcGaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHUlNwI1/eUyfqfJiXMoOyVThvbTuRN5/K7NtQW4o14sxNmIrKFKdhkvNYIyhiIoDC/6cihhI5TsgU2CQ+xtyOoB03W1OtJtigTrmlJM80VnfwN25fa90i6QrMKGr5HmIDL2B3ai/GwipmdnAdGP/JQvAQfvJpy6gVhrWyM+79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=usK1+uiL; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso40997805e9.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1780851369; x=1781456169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb6+zlsavv1nSrFH8SGOlJzElOa9/FGNdN9bgvlBisE=;
        b=usK1+uiLqh+3OoBXej03mryHh4bxi/A243MUnxN3g9yXxPYCG0axgIMXnJZoL9msaS
         htbhHuudE+AbiC1UlErX9d9Vn4xzC5qQMDwvpsXsG1nwXl6CRU4NnF1klMJ3P7h/Qxrq
         dJwxgSlqxbyRlGejO6O+HjHvujn261mSacy8kb+OtF7SNhwkQ72vaOdcBEewG9MonMPR
         we2Aki1GxYr0BJvVGBCP6Q7FIEbu69AN4Ux/SoBz/RxIyIuK5NPSONqjM80yrfG21Zom
         AA2yuTnuLGmJciWpsTTQ22XzEN0pCqPpUm2+JxUyfG3lo3veH7remfBtxvzG5c32NxGg
         ZKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780851369; x=1781456169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jb6+zlsavv1nSrFH8SGOlJzElOa9/FGNdN9bgvlBisE=;
        b=FJXab0nKgluvcK7NdIdMK76bVZb/s+F17bbBG44q4V7iP6bbHiI9AyiNP7fG77mVoC
         32Jo3as9tCDxAG/WUOr8OZVjcBAUKeKsV5We6qQecPOU5GeaMEsCPJbzSffxdfOKgVf+
         c80Z1MdAtp+fz9z/h/Im5FnVJ+UvSDR24gaj5eXF7HKfwFnnSHsROeYARlCTUd2BbwPv
         DiFe02AxA14Rs0h8bmRQJFmkrBWbkOdcPxmAVaMOhmiJXn/RVMGmBV9kkGVwPyRDYVji
         ln7Q+3fUVNa2MTnXLSVndC/gAtRJgja77CnFKqiuvnzEUaJFyv4WAzoxARoxmGSoYntz
         +UBg==
X-Forwarded-Encrypted: i=1; AFNElJ9uu0hiihjQooUKKw94b4JVlx75+73WacxWQh7t43IjtcXRxswHuGWbV1UxHhxEwSXLtCaFCZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4/qpmFjgn7/+5LbEBdaJnkFC/uOujq+RgskCTiXTz7KNESXpw
	MXHMMRTTwMAZdya4JVGMS9QAV3MbmNQD2X+dkLbtL2wmUimMp9E08anv/WTSeIiICgs=
X-Gm-Gg: Acq92OH+wWx4aq4FUhfNJRcoXOs5bSDwvCaEL8ykK4CDalp4St2SSUtK7o+RayQ+L5v
	dmYqi8vg9a1/oL/rUPjRxMrb8nNfnqXkcaX796FpJDoMx4SdTsP9V7ra53NIlWMo/uE4eZwc1Bp
	+pR3LlPUX9FvOWR8OvxEY0viCjf9q1wrVktP67PxZHoikTKCNnxHTc6j1yT9osv9JCyVbI9tW2u
	JG9Cmp2LEYgwxxUlXaZTqIxon7PRF2jT06mKvElRq4cHbmbkZjarLzIikbbTcfO6L1qkS+jeE/F
	XO22TmCjQB7LMmyiW4QVIBV6iOuofmfDY/S/fZGwi7ItwI9HywxhoA0zBbqmwSmOvGuQD/bu+jM
	5fUQ5beUqy+UDNMqCVYyBxiOpdoYfvkJf110H/w1nyzHw8tpGwDz+lEweLTpj/kIGWCqKgNrzaf
	nTq/k1sG6zqii6Wdq3mbnJTPqTcZF0norJ/nEgaovRcxd6i+0tj537gSmworOZZ3AQRGTxbG/7k
	CKhFQpgMIZGGLWw+dbOr/6OjdNhZYti8ThELMLI+DDoHYKQh1tLapJL7CRFxlCqJ2p/XV/mNcHO
	BKPfGw==
X-Received: by 2002:a05:600c:4f90:b0:490:3890:605b with SMTP id 5b1f17b1804b1-490c260f448mr210709255e9.31.1780851368991;
        Sun, 07 Jun 2026 09:56:08 -0700 (PDT)
Received: from threadripper-fedora-workstation (d-zg2-253.globalnet.hr. [213.149.37.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm283230325e9.4.2026.06.07.09.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 09:56:08 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next v3 2/2] net: pse-pd: pd692x0: support disabling disable ports GPIO
Date: Sun,  7 Jun 2026 18:55:36 +0200
Message-ID: <20260607165600.1260210-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607165600.1260210-1-robert.marko@sartura.hr>
References: <20260607165600.1260210-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-296261-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel.machon@microchip.com,m:luka.perkov@sartura.hr,m:robert.marko@sartura.hr,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sartura.hr:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sartura.hr:mid,sartura.hr:dkim,sartura.hr:from_mime,sartura.hr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8A4E65104A

Microchip PSE controllers have a dedicated disable ports input that like it
name says disables PoE on all ports.

So lets support parsing that GPIO and using the GPIO flags to set it low
by default and enable PoE on all ports during probe.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
* Update commit message to reflect the logic level change, and make Sashiko
happy
* Pick up Acked-by from Oleksij

Changes in v2:
* Use GPIOD_OUT_LOW by default so that DTS reflects the real active state

 drivers/net/pse-pd/pd692x0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 49b1527829ad..cb377d5ba7af 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -1757,6 +1758,7 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 	static const char * const regulators[] = { "vdd", "vdda" };
 	struct pd692x0_msg msg, buf = {0}, zero = {0};
 	struct device *dev = &client->dev;
+	struct gpio_desc *disable_ports;
 	struct pd692x0_msg_ver ver;
 	struct pd692x0_priv *priv;
 	struct fw_upload *fwl;
@@ -1780,6 +1782,11 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 	priv->client = client;
 	i2c_set_clientdata(client, priv);
 
+	disable_ports = devm_gpiod_get_optional(dev, "disable-ports", GPIOD_OUT_LOW);
+	if (IS_ERR(disable_ports))
+		return dev_err_probe(&client->dev, PTR_ERR(disable_ports),
+				     "Failed to get disable ports GPIO\n");
+
 	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
 	if (ret != sizeof(buf)) {
 		dev_err(dev, "Failed to get device status\n");
-- 
2.54.0


