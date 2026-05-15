Return-Path: <netdev+bounces-288289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK41LhwUB2ourgIAu9opvQ
	(envelope-from <netdev+bounces-288289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:39:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EC554FBC4
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFC8831E27B4
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754A447ECD4;
	Fri, 15 May 2026 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="zl/Q4W04"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BFD145B11
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845862; cv=none; b=gzsoK+T41Ou6O2OJx9iU9iBpkhgVuvK/vinktEM2WZZwyVCVtYJK+3ZUSR6tCuimOrEEHFKNoAbsJMYb4aXbyn+nO88GK3XJXsRH+uu7ZsfXOmUXVsuyDahqeINUSPdOdPTYo+jdr6LowxQT1t2dSEE8lFWpy6LcAwni+fZz63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845862; c=relaxed/simple;
	bh=zgdW6+r+x1rBS1+WVhWuLw6rj90vBCLZ2HVd/YgdLbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdBgI+urRBkgmdKW2BeSQDB3TBE9TajJnVBTVbnc2F2T6Sr6qxqb59Fe2Q51ytfInT5GvR3vku901uvMIvCN9yaQdO9x5E8emfD6GPYKhu9lTy7EsgGBRUxWgO7NZ0KAdnqWAIrKPhbFR4yRFepYBsCRcnJS9QZfsys4hc+fNxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=zl/Q4W04; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8721851e2so10096020e87.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 04:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1778845859; x=1779450659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCJHKBX1/2/0XhVxv+J3PvII+iORt4DXAiiPbyzOSnM=;
        b=zl/Q4W04j1/UkkcrkxdxzzSB8aX9a8qKDWaYumJ3CXiUoHHOfihCEARVUMrjr0gBPZ
         M0EnG8jPYLAASuRN9R9wrICcxJlVcKhkQiLufcoZDlEtOl0LyIl3+mnLCl10kIDoBHtr
         c2Rcq9aCq17t9gXHuiI510xuExXgmPn8TYCCkY1p+n8mGE9c7YKBgvLrDngMH75zuiwc
         NUbjhBhP5xLqM3abw+8g1NMU4aAdWLLR9ggGkT5kK0IZ5nij4o3q5Rg7P5EsdG8FWim6
         Wcs/nX+9Sn5+dOZwFAtAVjJ2u+PlO9z1kZmUJtrlHTEY5gQkydg1Kj9wSmjZWIQmLcUo
         I2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778845859; x=1779450659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rCJHKBX1/2/0XhVxv+J3PvII+iORt4DXAiiPbyzOSnM=;
        b=OOhWCdzNFHB6BpqbU94/PTO6yP4IQu1IxPhd9CNV8vgg8X/Xe7Q4jdFvMncpihm0Yo
         yYlWIjOsIydHm8IO7Vz+YZfaUBuh0R3+PKovJrSvOrAgGtvzCdkZjHN6ANmWHWyIbWNZ
         apudwwRlA1drvPYT9bkN5SZyKbnznbhBOJprEOdZHXP2c/DpDR3Jqmfku9d51YpwKxsy
         Cw25AeGFvq9rE5G8ArEYw9DNzWvkRyKmCoBnDQR49Tm4+gIkOgqUdwA4LXsDXfUfVQJn
         ad2MGuGetpSVDL0xKBB4ME9quPSA6fJgb+0zScOaa1TuZ7JGEE5ZdUxe2f3JpImVIoyR
         2MAA==
X-Forwarded-Encrypted: i=1; AFNElJ+f2fdmvm2YGS/VmtvtAGLn9F5rWO7GDYDQ9skTWd6dYLLtA3h2dsZggbts25Zy5+pqUDrMvNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZ8XMYSzHLM+ThEyBu1FsaaE08TT5Aid3fO8s6lVoRECLOFi6
	urs1XYocXCqvqOOp+GAbulnFXQhJVaq93aEhMx6NlhfoI6tX9qq3VtYdUMv/dZT+f38=
X-Gm-Gg: Acq92OFQA4xyzg7ruGSV0JVt4/rTmtAYMzw85Ib+CILH4YWTSAVcg84yulwu1PnWlMN
	alXLQ2poBSKYU3eJw3V3bZJleANUYvl5t5g7sHgw/dmYpLCbG6S565DAzQNV1iltRsLZnId7GDJ
	HhLOmZ+Hl+ck9MMYctojRlERcgBjUIwLQOOtI/CFmCT/aTk/7MTHE0MifU2Z0XOoUDaYuA2Off4
	G9PPVJcg0smANpDovc4q/Ss2XU6LoUZPCHdOksagww7qChN3v+JjhfL1ja5+h8tDwNeyHv8ojrc
	KBBXIhufUI4oSmvAB92BTXdV3C2zGtQUoyAj/mwJHRJh7dRp+k8GCU9WTxUBYtFcCF3/fQHL2cr
	D5oFmNLCXPAmtOt7SgBA7b7h/Cxwc1/30i8SY6CYyG06cyn7NVCuYjOyul0+5k3EEYpT3JOgS6S
	tB+uwHtR5ToHW1rlV2e89LT0YqvefZhQVeadkLaGqm5IgoZiavWqNUkLyoG2LMa9D/MWKqXUMb5
	nVD4HthHC/fndIkAacjQg==
X-Received: by 2002:a05:6512:2393:b0:5a8:9511:b906 with SMTP id 2adb3069b0e04-5aa0e769bc1mr1119872e87.33.1778845859201;
        Fri, 15 May 2026 04:50:59 -0700 (PDT)
Received: from fedora (d-zg2-146.globalnet.hr. [213.149.37.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc0ccsm1278617e87.41.2026.05.15.04.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:50:58 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
X-Google-Original-From: Robert Marko <robimarko@gmail.com>
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
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next v2 2/2] net: pse-pd: pd692x0: support disabling disable ports GPIO
Date: Fri, 15 May 2026 13:50:01 +0200
Message-ID: <20260515115050.691119-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515115050.691119-1-robimarko@gmail.com>
References: <20260515115050.691119-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8EC554FBC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-288289-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sartura.hr:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Robert Marko <robert.marko@sartura.hr>

Microchip PSE controllers have a dedicated disable ports input that like it
name says disables PoE on all ports.

So lets support parsing that GPIO and using the GPIO flags to set it to
output high by default and enable PoE on all ports during probe.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Use GPIOD_OUT_LOW by default so that DTS reflects the real active state

 drivers/net/pse-pd/pd692x0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 4a3c852780f5..6c5c5a26bbaa 100644
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


