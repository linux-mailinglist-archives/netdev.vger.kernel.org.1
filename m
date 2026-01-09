Return-Path: <netdev+bounces-248303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45038D06AFD
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1175300D81B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D921A9B24;
	Fri,  9 Jan 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USf3qNTu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED61C3C08
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 01:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920965; cv=none; b=Z7wZSU2Wgh73W1Pv92CnANyFvADEuIWiBKVy19O8/J2sVLnDMQSLmaJlj+X7H6ONFcEgnuS35Sz9PtCZtyxtnAyv03B7mvqNllxpRzSYbiBbra5mUes50UeJI40JwNnkiw7WteR8dPfncUEfh9JGsEwVTB8NA1k/wtV14E+xPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920965; c=relaxed/simple;
	bh=usyBlb+b/TEj0pW6zQBAZ4j6OzObyz0EBAXKM2c0Vss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlktRyFmoOsZrBCcapVVvzNSMFBKgyvpKY6LMcV914asiEY/GrV74W5sr1CEXSnSvoOR1NoHFsnFAbWJE9/Z8YEQM3gnAM7raAeCH7tk4fMT1puHdYQfXqGktChSeIp2qfOpQY7HQkSo1qHHRIGWvUKEZfw6BafiGxLbbYVQlKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USf3qNTu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43260a5a096so2589643f8f.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 17:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767920962; x=1768525762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbZ8+rlZ2XM6qoOuKVKOlDkNcCRWWQmyXjdZtMNax68=;
        b=USf3qNTubic8ii1FdPzi15NTtS1aYazwi86JtMiRJaLn/+7nOipKhHRmZrYI59fvkh
         T6NtrU3Zf8EWZ3GINfQiP6m0AQWrM5gBPJxKDH+DtSoufHoO8yYN0XF7HPHRnTP5GsQ3
         ID2Do4tTslUK6tenpOsXwVyxY0qR3O/4I3WzHCcZQpEoL29S7yhdhs9itFB8R9xwIX1C
         Xrynen6xFGeIgj1kc1ja3pHRU7Yaa0QKon3+niJuCYSJATaaSO87XrxXxHlvdg3ClBju
         MSdOsIIF+XjpMYHBXjaHjMrnTNNKEy34USoDuLRO78IzU4X1LeNgPL3OdRFfOXDsHW7T
         12sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920962; x=1768525762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qbZ8+rlZ2XM6qoOuKVKOlDkNcCRWWQmyXjdZtMNax68=;
        b=qp33oKtLmOhJ45LfndIWzuvFFgsgjPcbpBy5M5k1VdOV72gAItYJVAZfV85131tQfl
         EbYDzwTf/ILNIkYMd0KMyioaDX8sMxkz53+UJ1zMOnYPrY2d3ico7im/EMbdJeZx3VN2
         V8AjEB3gpSleXkzv94zjgSYpMrH+QMMIfxiueEADs0RjZaL2jWd1vUNvS5pkWPDV9zjo
         vhTujqfAHS+w9FaSrlet/ctbbTY3ToAlRs4zJ9Oj82rV+O790RNyMaUZ9XJ2OqoCzpGe
         ld1MW/QD8K6Wz8SIx57Wd1+65eOr2C1fDni6csZZ/XNHomtvvIv2u3WaRzsN/xiv9pFz
         x3gg==
X-Forwarded-Encrypted: i=1; AJvYcCX3DcmrP5a8Ky5BHG/yps/l1YoTQhEXDzBrx+n9Y/yldOIy0PqBvRoEHW+7OToN5PzM38QN6XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuqB/uxI8W4dTDEXyOEkNcvweKNcrtHCZZpVonQ3xd19Wo2Bj
	j3JvolWmsKAxqTpXnOkdjxwjQkbJQ2ZC1RRACyleS9OL+cm98qJofpO/
X-Gm-Gg: AY/fxX6QlvKZtS91zbecb2HJNEJo9QaaMCBkfHRncuzxH5rPK85Rd2TtXcol0gwpEhv
	4enaFoXEP3wf59nED8MkozoZb1sSb8Gp4Q5K1nehc/iLaObVep5DPZqp3UJq8FRK840/UIJMnRs
	a6oDqM9tE6t3k4x9oZimZsEEPEUHS+S5jQ0R+FU1I26j5O5UNBw4WXXdanuBqd5M9KWPHWKTIk0
	84FaUICRt43UKGn7KH3rYWS7AJ/EC0yEr7SDX/m/vdE1HBGyZ5tbluyYpqzM/3ZJhKMI5VdBvb/
	rADh2NLj1/5jjUbC5HZR5vp4oD/4BjCl1hXmKk3qV1hpmVbfWzvhCz9KfuFaa/cTTjDcrESInP6
	3nYe/oIn9ufeTWNk0lE46+zyMHPw/ZOVGuzD24jm6MrQw5kU+ovWNTqFytA5aEJDiKSc/Wkojnt
	2udL8MSvfRIQ==
X-Google-Smtp-Source: AGHT+IFZQmpSIFx2Il32vLa/mwl+HOWcs6sUb2tqUxeGLLhMadkql0ja2OjK+pzs3xrh5XNomPf7/g==
X-Received: by 2002:a5d:5850:0:b0:430:fcda:452d with SMTP id ffacd0b85a97d-432c3790c68mr9834411f8f.22.1767920961819;
        Thu, 08 Jan 2026 17:09:21 -0800 (PST)
Received: from rsa-laptop ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm19698214f8f.15.2026.01.08.17.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:09:20 -0800 (PST)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH v5 7/7] net: wwan: hwsim: support NMEA port emulation
Date: Fri,  9 Jan 2026 03:09:09 +0200
Message-ID: <20260109010909.4216-8-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support NMEA port emulation for the WWAN core GNSS port testing purpose.
Emulator produces pair of GGA + RMC sentences every second what should
be enough to fool gpsd into believing it is working with a NMEA GNSS
receiver.

If the GNSS system is enabled then one NMEA port will be created
automatically for the simulated WWAN device. Manual NMEA port creation
is not supported at the moment.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes:
* RFCv2->RFCv5: became 7/7 (was 6/6)
---
 drivers/net/wwan/wwan_hwsim.c | 128 +++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index 20277ba88433..5b5af2c9a63d 100644
--- a/drivers/net/wwan/wwan_hwsim.c
+++ b/drivers/net/wwan/wwan_hwsim.c
@@ -2,7 +2,7 @@
 /*
  * WWAN device simulator for WWAN framework testing.
  *
- * Copyright (c) 2021, Sergey Ryazanov <ryazanov.s.a@gmail.com>
+ * Copyright (c) 2021, 2025, Sergey Ryazanov <ryazanov.s.a@gmail.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -12,8 +12,10 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/spinlock.h>
+#include <linux/time.h>
 #include <linux/list.h>
 #include <linux/skbuff.h>
+#include <linux/timer.h>
 #include <linux/netdevice.h>
 #include <linux/wwan.h>
 #include <linux/debugfs.h>
@@ -65,6 +67,9 @@ struct wwan_hwsim_port {
 				AT_PARSER_SKIP_LINE,
 			} pstate;
 		} at_emul;
+		struct {
+			struct timer_list timer;
+		} nmea_emul;
 	};
 };
 
@@ -193,6 +198,108 @@ static const struct wwan_port_ops wwan_hwsim_at_emul_port_ops = {
 	.tx = wwan_hwsim_at_emul_tx,
 };
 
+#if IS_ENABLED(CONFIG_GNSS)
+#define NMEA_MAX_LEN		82	/* Max sentence length */
+#define NMEA_TRAIL_LEN		5	/* '*' + Checksum + <CR><LF> */
+#define NMEA_MAX_DATA_LEN	(NMEA_MAX_LEN - NMEA_TRAIL_LEN)
+
+static __printf(2, 3)
+void wwan_hwsim_nmea_skb_push_sentence(struct sk_buff *skb,
+				       const char *fmt, ...)
+{
+	unsigned char *s, *p;
+	va_list ap;
+	u8 cs = 0;
+	int len;
+
+	s = skb_put(skb, NMEA_MAX_LEN + 1);	/* +'\0' */
+	if (!s)
+		return;
+
+	va_start(ap, fmt);
+	len = vsnprintf(s, NMEA_MAX_DATA_LEN + 1, fmt, ap);
+	va_end(ap);
+	if (WARN_ON_ONCE(len > NMEA_MAX_DATA_LEN))/* No space for trailer */
+		return;
+
+	for (p = s + 1; *p != '\0'; ++p)/* Skip leading '$' or '!' */
+		cs ^= *p;
+	p += snprintf(p, 5 + 1, "*%02X\r\n", cs);
+
+	len = (p - s) - (NMEA_MAX_LEN + 1);	/* exp. vs real length diff */
+	skb->tail += len;			/* Adjust tail to real length */
+	skb->len += len;
+}
+
+static void wwan_hwsim_nmea_emul_timer(struct timer_list *t)
+{
+	/* 43.74754722298909 N 11.25759835922875 E in DMM format */
+	static const unsigned int coord[4 * 2] = { 43, 44, 8528, 0,
+						   11, 15, 4559, 0 };
+	struct wwan_hwsim_port *port = from_timer(port, t, nmea_emul.timer);
+	struct sk_buff *skb;
+	struct tm tm;
+
+	time64_to_tm(ktime_get_real_seconds(), 0, &tm);
+
+	mod_timer(&port->nmea_emul.timer, jiffies + HZ);	/* 1 second */
+
+	skb = alloc_skb(NMEA_MAX_LEN * 2, GFP_KERNEL);	/* GGA + RMC */
+	if (!skb)
+		return;
+
+	wwan_hwsim_nmea_skb_push_sentence(skb,
+					  "$GPGGA,%02u%02u%02u.000,%02u%02u.%04u,%c,%03u%02u.%04u,%c,1,7,1.03,176.2,M,55.2,M,,",
+					  tm.tm_hour, tm.tm_min, tm.tm_sec,
+					  coord[0], coord[1], coord[2],
+					  coord[3] ? 'S' : 'N',
+					  coord[4], coord[5], coord[6],
+					  coord[7] ? 'W' : 'E');
+
+	wwan_hwsim_nmea_skb_push_sentence(skb,
+					  "$GPRMC,%02u%02u%02u.000,A,%02u%02u.%04u,%c,%03u%02u.%04u,%c,0.02,31.66,%02u%02u%02u,,,A",
+					  tm.tm_hour, tm.tm_min, tm.tm_sec,
+					  coord[0], coord[1], coord[2],
+					  coord[3] ? 'S' : 'N',
+					  coord[4], coord[5], coord[6],
+					  coord[7] ? 'W' : 'E',
+					  tm.tm_mday, tm.tm_mon + 1,
+					  (unsigned int)tm.tm_year - 100);
+
+	wwan_port_rx(port->wwan, skb);
+}
+
+static int wwan_hwsim_nmea_emul_start(struct wwan_port *wport)
+{
+	struct wwan_hwsim_port *port = wwan_port_get_drvdata(wport);
+
+	timer_setup(&port->nmea_emul.timer, wwan_hwsim_nmea_emul_timer, 0);
+	wwan_hwsim_nmea_emul_timer(&port->nmea_emul.timer);
+
+	return 0;
+}
+
+static void wwan_hwsim_nmea_emul_stop(struct wwan_port *wport)
+{
+	struct wwan_hwsim_port *port = wwan_port_get_drvdata(wport);
+
+	timer_delete_sync(&port->nmea_emul.timer);
+}
+
+static int wwan_hwsim_nmea_emul_tx(struct wwan_port *wport, struct sk_buff *in)
+{
+	consume_skb(in);
+
+	return 0;
+}
+
+static const struct wwan_port_ops wwan_hwsim_nmea_emul_port_ops = {
+	.start = wwan_hwsim_nmea_emul_start,
+	.stop = wwan_hwsim_nmea_emul_stop,
+	.tx = wwan_hwsim_nmea_emul_tx,
+};
+#endif
+
 static struct wwan_hwsim_port *wwan_hwsim_port_new(struct wwan_hwsim_dev *dev,
 						   enum wwan_port_type type)
 {
@@ -203,6 +310,10 @@ static struct wwan_hwsim_port *wwan_hwsim_port_new(struct wwan_hwsim_dev *dev,
 
 	if (type == WWAN_PORT_AT)
 		ops = &wwan_hwsim_at_emul_port_ops;
+#if IS_ENABLED(CONFIG_GNSS)
+	else if (type == WWAN_PORT_NMEA)
+		ops = &wwan_hwsim_nmea_emul_port_ops;
+#endif
 	else
 		return ERR_PTR(-EINVAL);
 
@@ -478,9 +589,10 @@ static int __init wwan_hwsim_init_devs(void)
 		list_add_tail(&dev->list, &wwan_hwsim_devs);
 		spin_unlock(&wwan_hwsim_devs_lock);
 
-		/* Create a couple of ports per each device to accelerate
+		/* Create a few various ports per each device to accelerate
 		 * the simulator readiness time.
 		 */
+
 		for (j = 0; j < 2; ++j) {
 			port = wwan_hwsim_port_new(dev, WWAN_PORT_AT);
 			if (IS_ERR(port))
@@ -490,6 +602,18 @@ static int __init wwan_hwsim_init_devs(void)
 			list_add_tail(&port->list, &dev->ports);
 			spin_unlock(&dev->ports_lock);
 		}
+
+#if IS_ENABLED(CONFIG_GNSS)
+		port = wwan_hwsim_port_new(dev, WWAN_PORT_NMEA);
+		if (IS_ERR(port)) {
+			dev_warn(&dev->dev, "failed to create initial NMEA port: %d\n",
+				 (int)PTR_ERR(port));
+		} else {
+			spin_lock(&dev->ports_lock);
+			list_add_tail(&port->list, &dev->ports);
+			spin_unlock(&dev->ports_lock);
+		}
+#endif
 	}
 
 	return 0;
-- 
2.52.0


