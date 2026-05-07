Return-Path: <netdev+bounces-285240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKYBJO1t/GkQQAAAu9opvQ
	(envelope-from <netdev+bounces-285240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:48:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 522754E7013
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE24130433A7
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B5B3EC2DC;
	Thu,  7 May 2026 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="BoqWa86M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E93E95B3
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150862; cv=none; b=FBDbNdwMj9g4AJP9L1C24a8R7nJq8b3372cAr0PMnfYUCLVEm2HrBifuFcucPvgIc8+Ffo1568v1M6jsJrrtayrF3WEfMMLekf2hj6fvmmJOw/fduMMHct3TK4f25Ttfp8ZGIqWPN0YPCpa0puj+sw7gS67J3vup3uX2sjprCiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150862; c=relaxed/simple;
	bh=g1dqMkM9FRqcISzpWaPgbTkXATG4HTONa0v3S7F2LNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdNhjWp8XcgUYpYFY/ZdGlnk0gQE5W0hsgaXd9wgrzF3cWEiqAkX95Chtx9z2CPsFHBlZS4mmKjQCBRRq0sG7d6uxCTfAVMSj/tD8SozuQ3tx7LB0KgaKM9uzjUzGvrDRwgcY1V/XxgfllKPbbQaYFYGrNpTSR2vHuUBfqopS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=BoqWa86M; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ee1054627bso1484897eec.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1778150860; x=1778755660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlFEH9FI6VHpMC6EQEPKMetpez97tZuXzygZrJOEYRA=;
        b=BoqWa86Mn3L8HNuz6fhkKPviuUMgu70Z3ra/nlKsmqVXigVYczqeQKLzSSeSUfJs4t
         k6akYX3cuMeagxA4PmwmvICjVa7JybWpLFhWkYMoMJz/j55ZB6JtKLQXnlQmO2rkQ0dG
         858wcumaOxRgGvSTUVqtFjvS3IGBYHC99rdV2OBI0C6wVsri7oz15bMik6Z9LPJUpjW5
         Arugwd9g8LHLUz/KlsYhONNv3txaa3SMcD8z4v51F/p/5BYhKElme5Roz6AjZeVqKj2S
         JpRc+d4sR2wX64G8CuRb4mQinDb3V7IZl8tJigpNnHNTnkNdPy+QPkfMIroNIVaPncsK
         4J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778150860; x=1778755660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qlFEH9FI6VHpMC6EQEPKMetpez97tZuXzygZrJOEYRA=;
        b=pFmRAxRLR9sgsg0XkS11WmnUuRIetPcxvdIB+m9lUNx7Otdz2nkDeWLl/xkDatAtjO
         qahRvbYXbddKi48x8YUkDxI8xcut/TaQ8UecL8JgAZ1LP5l8Id/zpCaMKIu7Q8PvyY2m
         HmeVwjK4YbaTlUdD/AK2eMk8QoLlROzGYzDIRMhqX9VSo2hQOr54WuFSKXktClRo7lEk
         UiXdk4u2Y/SA3zkJCvOxTtlxUN9QQbnbqgfbNB/yHV33w/f303YHprvYokI9ecgxq2zx
         9rcb4OtzgqUZaQdmJRuNDoLHEcvJZjqKq8ZAhkU5aRVponB4gu/724o2gu5NkKUOLY6g
         GOoA==
X-Forwarded-Encrypted: i=1; AFNElJ+xK2YqFIjpcVcGcRVzZ23anG+bnF7/otdpp3dCQB7Q8fYqMvag8h8skw4ZSeQm6xG0jNSkMZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKi8mSMIvJKPLudAOYPC9FrGU89d9neonKetRHwke30juQsFwr
	084jzm0PXu1h3VfP+HtvhX9/vlXvVpdhLC5a8tcs+8L/G0JUiM6AHF/ljkLKrl03Bxw=
X-Gm-Gg: AeBDietz3A52D7LFtgSyKmf9EhS132gDIvAItagNIMMvoGJsq4fA7BBtJojADVSY36L
	kn4AOh0J366xy0OEXkU9g862iLmoBqtcYhwS677kTMd7UrkTr6nz92ykpmCgFBfh0BT1bkFGXIu
	5p4Ik6fx0DebJNu6fxpIEy8B5rGNmWtQZd5xgH0+SAApgTL/OkggMhr3nGQbtooQa6aTlVxfFni
	dW+VVkzeo+jAObGthmP7zF/6w0xeCTOwCuzzMNrV99C/wcSm0YQxSNm4VZTDx3tmwVpVKcOlu+Q
	2FP8TgZdbldjhQ2xEelKBPO3bituAcZOcpqxag7PtX7OZMSRUvYLs87IAjiXefy0fUmEOXhfWij
	q63rDdgygka0YOChBq4b8fpPtRwQIWWcf8ZZr2nJ/LGnqYav0bnH8x6qZaGkYcwKwl7bFQtjtry
	a+0PL7A7CVQEX8WKliYoUPKz1aD1YqLy+dF7ps7MtS/uvE0RC1JbVcP3wPORiszwwwZEfUB4lrg
	0tjfxRvlup3dmJWtOWFeAsnZaTU/yV0HmZgUG/iyqOXBHaw/HPl9MKt9p4TEg==
X-Received: by 2002:a05:7300:cc1b:b0:2be:9c19:b34b with SMTP id 5a478bee46e88-2f6e1e316edmr1167138eec.4.1778150859870;
        Thu, 07 May 2026 03:47:39 -0700 (PDT)
Received: from fedora (cpe-109-60-83-79.zg3.cable.xnet.hr. [109.60.83.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56cec5d8asm7040271eec.3.2026.05.07.03.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:47:39 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next 2/2] net: pse-pd: pd692x0: support disabling disable ports GPIO
Date: Thu,  7 May 2026 12:46:55 +0200
Message-ID: <20260507104720.262641-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507104720.262641-1-robert.marko@sartura.hr>
References: <20260507104720.262641-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 522754E7013
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285240-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[sartura.hr:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Microchip PSE controllers have a dedicated disable ports input that like it
name says disables PoE on all ports.

So lets support parsing that GPIO and using the GPIO flags to set it to
output high by default and enable PoE on all ports during probe.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/pse-pd/pd692x0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 44cf9f97be67..670656abd16f 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -1781,6 +1782,7 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 	static const char * const regulators[] = { "vdd", "vdda" };
 	struct pd692x0_msg msg, buf = {0}, zero = {0};
 	struct device *dev = &client->dev;
+	struct gpio_desc *disable_ports;
 	struct pd692x0_msg_ver ver;
 	struct pd692x0_priv *priv;
 	struct fw_upload *fwl;
@@ -1808,6 +1810,11 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
 	priv->client = client;
 	i2c_set_clientdata(client, priv);
 
+	disable_ports = devm_gpiod_get_optional(dev, "disable-ports", GPIOD_OUT_HIGH);
+	if (IS_ERR(disable_ports))
+		return dev_err_probe(&client->dev, PTR_ERR(disable_ports),
+				     "Failed to get disable ports GPIO\n");
+
 	ret = i2c_master_recv(client, (u8 *)&buf, sizeof(buf));
 	if (ret != sizeof(buf)) {
 		dev_err(dev, "Failed to get device status\n");
-- 
2.54.0


