Return-Path: <netdev+bounces-253335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC9eOpIId2lGawEAu9opvQ
	(envelope-from <netdev+bounces-253335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:24:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A25847B1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B39D3003D28
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F22749DC;
	Mon, 26 Jan 2026 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j911KJ+r"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD926E6F2;
	Mon, 26 Jan 2026 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408591; cv=none; b=pYWdIQqWzntGU0JrCIgeXJ+6L0M2CRifT5q4nWc7ziYD5ahJXUQRco1eRPGOxG3dhoDU2FG4tIpOLT7H4s9oiUemHz8Ppzhbr17P2tB7WGgMz5CWp8ffDvnOAdAevDlCT6/EA7+ajvB3QLNEE3Dfam17xoXFvoUOmcP99NAvgQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408591; c=relaxed/simple;
	bh=k+9zgKdscAS0i3Q5Ir1PyubQOmVQ01K2q0GhaHTSN98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CkBGRNS2NDvH8cShZuetE5bQizRp//OTgnkjUAIG/Tphz7fbZWd7wQH11XHkVRr4JBp3wH+mwMM+rOk5W0CoEljux5rp6g0Wtbq1N28DUWkok8YfEcs/eg11O0kTKiFJHyLRhd3HuTVSBTOZ7nnGc73vU5I+f7pGcscKvqaJ/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j911KJ+r; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5A
	SRYvNpxHtdZVYbddQecIZROSUeBgiAfVatEchJ5ak=; b=j911KJ+rGG0Ei+Uu5q
	5b2dF9yqSDZU0ZE2gkuyreBBII+9cyaG6PhzHkZ0fNg3QzuZD6z2uXzNGOtqrBM4
	xqu/g1j7e8w5waHWak93fCu5jmgwQ5Ku5eC8E/Nii9vnesyepcauxypXYakZTw7L
	r8oA9h5Srm4R0pZJLUe93hGJs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHzzkJCHdpL7kRIg--.5216S9;
	Mon, 26 Jan 2026 14:22:17 +0800 (CST)
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
	linux-kernel@vger.kernel.org,
	slark_xiao@163.com
Subject: [net-next v8 7/8] net: wwan: hwsim: support NMEA port emulation
Date: Mon, 26 Jan 2026 14:21:57 +0800
Message-Id: <20260126062158.308598-8-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260126062158.308598-1-slark_xiao@163.com>
References: <20260126062158.308598-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHzzkJCHdpL7kRIg--.5216S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrWUJr4UKFy5AFyfWFyrtFb_yoWxJF4Dpa
	1qgasxKrWUAw47Wry3GFsxJFWYq3WkWry0v34fWryYvr1xtry5XFWvkr90vrW5GFZ7uFy3
	urs5tw13Z397CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRkWrXUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvxlApGl3CBkIXAAA3Z
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253335-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slark_xiao@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90A25847B1
X-Rspamd-Action: no action

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

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
 drivers/net/wwan/wwan_hwsim.c | 128 +++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index 11d15dc39041..8541bd58e831 100644
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
+	skb = alloc_skb(NMEA_MAX_LEN * 2 + 2, GFP_ATOMIC);	/* GGA + RMC */
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


