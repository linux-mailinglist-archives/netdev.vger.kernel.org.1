Return-Path: <netdev+bounces-289475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PPNNh9uDGpKhgUAu9opvQ
	(envelope-from <netdev+bounces-289475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:05:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E87580371
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A74F305AE30
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9193ED3D3;
	Tue, 19 May 2026 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="bv4sxd4r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F922FC881
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199278; cv=none; b=lG2e3s4GOSF4NGRDgOHlteiAiQCO9bfd5O30bvvsippCDc8Vdi5XJFH/l3DphbjlQpkA6gD1PATz9bAec+nopWN6uJcqazbUGPE+CevXVRmJlw4G+T6kA5Vow92xJpMnwFfn7m9X35jpCe+7D/kr+YZtqLWz0KA2xbuuCO3ELNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199278; c=relaxed/simple;
	bh=Unbfd+jMuUVdbtRMYUn9CMrCJcN79/joicb4mz1QtVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dCoKWQDxJjUi5a0mdswhpMCdbqyPjd7dlbKbhQwaOsZ8ThWvkUEGoIQhV6eZFtDCW/wCWUXwx/S/tv1I7CURiFLOxVfQKgPnrLmAGry5YoxGxNQNNSTsb5JPgpalCmcIQb81KRnU+PDIokPs9DbXqwq1mJXj/l+9Jba2lMzr5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=bv4sxd4r; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so932361f8f.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779199275; x=1779804075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6V0npOlv/pb1pXj0+v8WQf0cSg92bgbaYxRXmYzFU0=;
        b=bv4sxd4rsJkTK7N0ubnrvFRxlVJ85FE+SSu+jz8irJKMsFSRKBC+sar3HWOUBDBqsq
         HCGj/2aPydbuOXjU5QrZCV97ALlUpwah6Pg/76pUrt4oGqv8z0L1dZ60fpuBmDmg92p5
         +qaztR7AeJ6jYf8sO5oNfRJXoOfV04u1Rieifyqgex3x04BM3aPVTDELziaKjQ2O0j7u
         btyXBDAtDdFZSRewa7R3tgdaA57AtH1/IAHTYY9Hx5nB9Stwx4HksYKvyzWjmEW1GP7g
         wxuaCBX8bL0W0XhL1QY5mvAPAUbvVQ596fNY1PzXbyjrAmJXGi/LzyVXmFkWRWN+Fhvl
         Metg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199275; x=1779804075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6V0npOlv/pb1pXj0+v8WQf0cSg92bgbaYxRXmYzFU0=;
        b=YbxJEK6DqFxs763kqZpCmmr89BcMGBAAE6lv0cElRjglVE1NWJ6AILeD7jio1lWco6
         s9Wl3E36b3NI15XnaG9aM+UbDt16w0+dy8FvwUBkl+M90bhPLHSuohqJIUsb51xMcqTs
         bRz9ZNKLw7XlnmDcgAHd7Nk/Umo12wRVJetOb3zgBBEh1YFVq0xq1K/zXZH6rLbBmZo6
         7+RFE5a4eLSOMu/69O52rtV/fkbRJTe8QeRiDl5KbyXbqf8g7vZUta2eJ174D3WpN1fV
         L3bw1JmWKYh35PA7NhyPguK7zvvpSWw96c+/IbOlbwJsDYS2Yj79s7iaahih6E5RwVBD
         Y0Eg==
X-Forwarded-Encrypted: i=1; AFNElJ9JbQPk+hTy1WP3Z7OeHwsljTWgkJ/k2PPrVtmrHxRuaLCQvkJpap030XB61SESizUbqeCU96A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzJd0hL6zhCYAJAlzGBflF40tbJLSnt1dtICk42QTNTjAmXTH
	V4tDIg2NLjglT5D4FI+R1Jw1cU4kCWQ9GDSjRVTo4XVLwlet1q37P7sMf8xg4IU1XQQ=
X-Gm-Gg: Acq92OHMzfQm6XtzXv9fNygK8XuBA7W6u517JpMfqPjz6IbixzVa6He7rp20UOqPK9B
	V/y2wkVJ2D/UyHw2J1s3XNq1pg8omWFFDuGuFhbHbsTp4U5qLKEweICkbOc8RCzwnhHF98ETPEC
	syF5kYy895U8Nqv+2nSRVbiG3mV+PD00WfUKWSwQpmQZXMSkbSv6+kg0MXbBzra3fhkDuxzLBa/
	8Tnfqyf26kNFq7SKULnN9oL2Vyc8pEjAX4nEveYT2L2nWQGHeHc4pscKUNCwWp37v9s62tBi9O2
	d9hfgdJg+/j9/bKHouX7yXByX5h9l22szlVSZfTApiwZ+rL4HJ+HR7nrDE7rrdk3wa92wNtgT43
	X6r0ynVp4gdbMQJ6p0RewGJ/UoDjSK04Wh5gWlUfafcVWno4OI7KgTWLP2o/g2OFL9hVpD0jJI8
	Uh6JIiFWBwL/sqwe+tl1cAq/gk2IeV2Fj8CJ0wcfM8M0iM9BQTPwr2cSSJPFCFO5s9SavMtMBDT
	nFtcfilzq2GHL3l9vqiJTI8rQ==
X-Received: by 2002:a05:6000:186c:b0:44a:247e:67b1 with SMTP id ffacd0b85a97d-45e5c35e40amr31881085f8f.5.1779199274455;
        Tue, 19 May 2026 07:01:14 -0700 (PDT)
Received: from localhost (p200300f65f47db048a8dfcf61053817f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8a8d:fcf6:1053:817f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da0a178adsm48461563f8f.18.2026.05.19.07.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:01:13 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] net: pse-pd: Use named initializers for arrays of i2c_device_data
Date: Tue, 19 May 2026 16:01:01 +0200
Message-ID: <20260519140101.1584946-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5192; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Unbfd+jMuUVdbtRMYUn9CMrCJcN79/joicb4mz1QtVk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDG0ewcHQT5DffG5Eg6fy1z4TZi+R4rnoEDhWo xvM9vwuA06JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagxtHgAKCRCPgPtYfRL+ TvVcB/0QT6bP47k1eZUYJ00NbxGEls4QW7QmMlOonh8h6dGDUDOFHKAvrMBqDANFkfgrYzbmvs3 QTNQlqYMCefFMtsl+SejqGqtaHDsG2rc2OvjZvc/N0yobelPOWdSfPr198Kd9HRAxtrej5r0oG0 wDagpnXX8GyPXiNlk7XuBOfPU6EdsiiAJq5wWMOyfeGZanvuHvR8lVfCQw4BI9ioiEkDGhLfdJE EAotOUNcEscyU/FYUl07ZVjPozmJehxTP0TDzyTbHJH7qx95AzbxJO3ZpG4tKxMapkCBMlzlv+O xEAwLEbKTdhUk5n+kxZWwMER31aoNQ325rJqSJPbcvF5qZSc
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289475-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lwn.net:url]
X-Rspamd-Queue-Id: 80E87580371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

While touching all these arrays, unify usage of whitespace in the list
terminator.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the mentioned change to i2c_device_id is the following:

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	index 23ff24080dfd..aebd3a5e90af 100644
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -477,7 +477,11 @@ struct rpmsg_device_id {

	 struct i2c_device_id {
		char name[I2C_NAME_SIZE];
	-	kernel_ulong_t driver_data;	/* Data private to the driver */
	+	union {
	+		/* Data private to the driver */
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };

	 /* pci_epf */

and this requires that .driver_data is assigned via a named initializer
for static data. This requirement isn't a bad one because named
initializers are also much better readable than list initializers.

The union added to struct i2c_device_id enables further cleanups like:

	diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
	index 0123ca8157a8..dfb0b07500a7 100644
	--- a/drivers/regulator/ad5398.c
	+++ b/drivers/regulator/ad5398.c
	@@ -207,8 +207,8 @@ struct ad5398_current_data_format {
	 static const struct ad5398_current_data_format df_10_4_120 = {10, 4, 0, 120000};

	 static const struct i2c_device_id ad5398_id[] = {
	-	{ .name = "ad5398", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	-	{ .name = "ad5821", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	+	{ .name = "ad5398", .driver_data_ptr = &df_10_4_120 },
	+	{ .name = "ad5821", .driver_data_ptr = &df_10_4_120 },
	 	{ }
	 };
	 MODULE_DEVICE_TABLE(i2c, ad5398_id);
	@@ -219,8 +219,7 @@ static int ad5398_probe(struct i2c_client *client)
	 	struct regulator_init_data *init_data = dev_get_platdata(&client->dev);
	 	struct regulator_config config = { };
	 	struct ad5398_chip_info *chip;
	-	const struct ad5398_current_data_format *df =
	-	                (struct ad5398_current_data_format *)id->driver_data;
	+	const struct ad5398_current_data_format *df = id->driver_data;

	 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
	 	if (!chip)

that are an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that. (I didn't find a pse-pd driver that benefits, so
this is "only" a regulator driver example.)

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

Best regards
Uwe

[1] https://cheri-alliance.org/discover-cheri/
    https://lwn.net/Articles/1037974/

 drivers/net/pse-pd/pd692x0.c  | 2 +-
 drivers/net/pse-pd/si3474.c   | 4 ++--
 drivers/net/pse-pd/tps23881.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 4a3c852780f5..49b1527829ad 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -1853,7 +1853,7 @@ static void pd692x0_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id pd692x0_id[] = {
-	{ PD692X0_PSE_NAME },
+	{ .name = PD692X0_PSE_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pd692x0_id);
diff --git a/drivers/net/pse-pd/si3474.c b/drivers/net/pse-pd/si3474.c
index aa07ffbce54d..1845b9c51cf7 100644
--- a/drivers/net/pse-pd/si3474.c
+++ b/drivers/net/pse-pd/si3474.c
@@ -550,8 +550,8 @@ static int si3474_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id si3474_id[] = {
-	{ "si3474" },
-	{}
+	{ .name = "si3474" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si3474_id);
 
diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index d40cb35a2547..49d6389da067 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -1528,8 +1528,8 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps23881_id[] = {
-	{ "tps23881", .driver_data = (kernel_ulong_t)&tps23881_info[TPS23881] },
-	{ "tps23881b", .driver_data = (kernel_ulong_t)&tps23881_info[TPS23881B] },
+	{ .name = "tps23881", .driver_data = (kernel_ulong_t)&tps23881_info[TPS23881] },
+	{ .name = "tps23881b", .driver_data = (kernel_ulong_t)&tps23881_info[TPS23881B] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tps23881_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


