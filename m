Return-Path: <netdev+bounces-200857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20A1AE71AC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622AD189C6FF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE225BEF4;
	Tue, 24 Jun 2025 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeVGX2RY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0225A2C7
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801153; cv=none; b=egZ2X6PfV7xkZgE0rY5B+c+RNCQhEFtPe4Nsskn5lurSMg0DzAktHktwVWNbRB7G1jKeFhZnHSDS/7/K53Zu/7ocLJdK/cN2+xtUYHQyjy8xJnpHr+2MVy2u3mdj9oFFm9vW11VPDq5vpNtwTcoKHiTfmGk/wTvAcStxh3XuDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801153; c=relaxed/simple;
	bh=CgZCOWJzoboSdbFccnDUwDzTCcpXbW2R4rrPPqeEGcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzfGbpbZNx7HfpQPOBRlxA3/k13pBX9nZ3XWZzdHMHiT9SVlhBmgsQpI4hTQKxlJXfoprIJ5phhlA6/oAbVskjfKReqMwjaTblcQtzLwmpRcfabL+Ml85NV8gZzVmtEAPn6ihT2msQgFWhP/i/2GNDUsfJbLdmUL1VIWFankP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeVGX2RY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a51481a598so3007879f8f.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801149; x=1751405949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ot2YLvwsYZUdjC/DQ1FHq1lpVzEQCsYJ0adj0Bnxag=;
        b=AeVGX2RYFgcYDEg1To86ZQdE7XQqowAh5E9JM5OpEWDw95LfAmzUYUTd5Xa6xQn/Tw
         rfKf0neWzsH0IRFwfqDl8c2k4KwThOeQLZ98ZxCU/Z08VbmOJdhVd2jnFrO39GlgjuLJ
         1Y8KjeCYRXbF/kZTBoeyz+GJm5qWn7Rxkra3X3uXK31bm7F4SC0yyKbxCCzNRku7XH5n
         7M/ztDHKb1KvqbtEtadEeuEZJtD3MuQg1bFF0Og4DuMV8KUQ2ZBrLvC6rq+wV8G+ddSu
         Pa+Z+POjBoDW/kSrpJ7FNHLL9EIPmxI+/gmMxHEq3ZtNIFcyQz+XtVCcUnmNyc4QsoW8
         Mf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801149; x=1751405949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ot2YLvwsYZUdjC/DQ1FHq1lpVzEQCsYJ0adj0Bnxag=;
        b=Bxmv+2BqVcfOTKc8HBHnKMGVDK2/eKvRqqX5dRuuvcRScpP5eY1gc44Aym0XevWvJu
         bluyee+EtRGffY2dHJWFi0zcrq2XezTtPlcBC6rDKst29mL+M/5jh81RU6ddnDJgfIq3
         MHI1siOcyXL9LhQXSwCU9HKmKiLs9pLjTswjzkPEmcQ72kwwi297DMivJ5E3MwpsKakL
         tl4KIFI7G8V3Vkgk49GJN+gXu99l0K0vIVzou1tM0DEfS9IkaxhNrDoyRrGUYirEgSBm
         7/7/TmdCUsr6RR+NWEIckpO3xl4E8q+2eckQkIFwcPtNUlKKSmjYEOw4vU9qfLGANx5z
         c9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXIWoDgakxbpipGCpXhL7brmWGWGOlTr1lieORuySfHWmRlPn2AtekiQP8N+aClQmnxSMYS6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGWPGenmbC1386vBzZQ6P0YbMliMo4O+orVm+hzfGnDuQ9EoY
	pYIY+cKfjBk4vrccgSdmYTTgoqISpmTRGwKEdPARfDSd8FhTrwdOh4wH
X-Gm-Gg: ASbGncvUf13YaR7dsv7RJjesNjJpfH/atIetUbrFzschCut0HF9iULfQzIWxAD5IpA3
	qQe2CMmqbS4ymi/A6fFgx4zoyWMxbq9ZQ6dAP0d92Xl5UnRFHQ/33pwUR9VrEOajBPTaV3t79WG
	In/j1lNuJdRd+H8CCc5hcU/WJjISur0K4RpPI/y6D0gPc6+WjV+yIEPW+yyARdEwkEAVZd3Shnf
	PD2uhboQPaE1W3/rBmz/BIf71uXHUV4yuHKYZGd+XK7AOKsGJ+YSchqUnFNq8jTWpJ16UsVZTdK
	FYMsOsVxuTs3cQuaO1sjzVUCbRTP7Qr+w0jm+obp2xW8tjc/xMDKw9+fwgwt6o/C0ui+DQB6guQ
	3
X-Google-Smtp-Source: AGHT+IGjfANIJit6SXGlkIz3eyb2RCIVS0Opk8Up6xSpG4Wr7BpcWckVcGNIL1wAi+xXstc/cDAUHA==
X-Received: by 2002:a05:6000:41f2:b0:3a4:ddd6:427f with SMTP id ffacd0b85a97d-3a6ed66a4c1mr236767f8f.35.1750801149339;
        Tue, 24 Jun 2025 14:39:09 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234c9c7sm851415e9.10.2025.06.24.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:39:08 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 6/6] net: wwan: hwsim: support NMEA port emulation
Date: Wed, 25 Jun 2025 00:38:01 +0300
Message-ID: <20250624213801.31702-7-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
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
2.49.0


