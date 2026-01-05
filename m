Return-Path: <netdev+bounces-246974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E18CF2F5F
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 11:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BA4D302081C
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77391315D28;
	Mon,  5 Jan 2026 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gnj05H0I"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACE3161B2;
	Mon,  5 Jan 2026 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608500; cv=none; b=mDZ7Z/3cWhunLsd2407axXng/Fcp0ukvxCnUTzranNclnu7OLCxDCX3M5pXosy8T1hlMsRyip58hsceRA6kl4zYESBHwsERZaHyjukIftOdjl6u6agsqrRAl6K+D3jfTQH3Bf9Fj15l370qh/DpOzuX1vBzq/rNJKad6frb57mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608500; c=relaxed/simple;
	bh=hJb2PfqzOI9tHMOZ4VhGa1KJ5pcdFKMsblP79Oj7SMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmLHRcSFbsevVozKSzVaTyZR+Dbpx1HWZncINrUw4WNCQygscFiqQGKE8PRW17YujAPhATQC6RTC8cgkfYPY8Z+hZqHKRuyEiqsgdOB2jaDagOL0c8vHQZXx70O25F/Mm2xCCj9An2FHxHJUGcKK0hJVHi1XPpyhpIKfSr/VpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gnj05H0I; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Eh
	TKEMdihrRmGhc2+GnqMu/SEAiNyVgMgt/1+m5A8zE=; b=gnj05H0IVkOvh0T2if
	sDvQ7DwIt+sZxvAdTv/Fr3z8jfmGSU7p5SP5bl9c9jJ/Al/j1Kiigybu4iuxbCtS
	e1JCT8V7vlIt9/CAMzRAZmNC6fXpuBTX0ofc99vd1co3fAA800YoQBncMAwp6BHT
	8y1XU/DADXbPF2zP1aeF5ZOKw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnrxNrkFtpVWA8KQ--.198S8;
	Mon, 05 Jan 2026 18:20:59 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next v4 6/8] net: wwan: hwsim: support NMEA port emulation
Date: Mon,  5 Jan 2026 18:20:16 +0800
Message-Id: <20260105102018.62731-7-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260105102018.62731-1-slark_xiao@163.com>
References: <20260105102018.62731-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnrxNrkFtpVWA8KQ--.198S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrWUJr4UKFy5AFykJFW8WFg_yoWxJr15pa
	1qgasxKrWUJw47W343GFsxJFWYqF1kWry0v34rWryYyr1xtry5XFWvkr90vrW5Gr97uFy3
	urs5tw13Z397CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJl1PUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvwt322lbkIu44gAA3r

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

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
index 11d15dc39041..e4b1bbff9af2 100644
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
+	struct wwan_hwsim_port *port = timer_container_of(port, t, nmea_emul.timer);
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
2.25.1


