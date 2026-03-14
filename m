Return-Path: <netdev+bounces-267875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ5GCUf4tWlj7wAAu9opvQ
	(envelope-from <netdev+bounces-267875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:07:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8E328F9C1
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC84E3025732
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 00:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F1E571;
	Sun, 15 Mar 2026 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="jRyrJJdE"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B68F49;
	Sun, 15 Mar 2026 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533247; cv=none; b=m+7K+N9pE0mDzKGRlJ6s4eWTYLx1oZyiKuZ1PBgFFUNise12mF6NE01FJFBCYg9nVWJlJHOyT++9tcmoAixdEdP/HHZ71EMQZtMlXvVY6MO5XIi0yRW4OzzHOIPIO6u0F+fQbUYzhs5k3m79gRgRua6yCW5fn4h6e3/LP475RfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533247; c=relaxed/simple;
	bh=JjA6pojnoM+Iv5bhk1cKoBfStTT3cRrx54QoCRXKnno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/eCtRObscSev9fPlMxA1Dx8bIrkRQfqXXCkQuzK53OuavSABaK7qRh0jIbWxeKaMGFoKptoUOr7lxJZTSfRILrkN9GgDAQ1MNLCqKpcFAmPeDL4ZuH/WjWO2B1lKmPq5GP1jKRcPr5fivnkSei8v8f7KePxtX0EN9+cJ0ZaSQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=jRyrJJdE; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 1BF52E840EA;
	Sun, 15 Mar 2026 01:00:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1773532840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SL7OAj90xF/ZqaIJX0boOrXHuc0BelOCYCyK/KJ68B4=;
	b=jRyrJJdEu22cyobBBdTwvzpHu94NmA5Ab/fT+ZVArcl8ZTGCIMSO4/lk3FFcaHWXkWRqwS
	DyUWlcGf0SUL2XgqhRhNipJ0gCD8yBOUHq21iJRxPJrFNiBEj2E5cWuttz3chsdqr1NA2P
	IMwR7+AZyFJHv1ZZvqw2xzJZdqVgSJpyy8L7jaUvqFCXYeZx34JyGEhSddmXf0lC/U0eu/
	oHGgdz7GHi3PszE065X+oJtM5Y1GkWzX6KqOtgC+w3FEwAlB+EdLz/L1Ek7a+mGUX987M3
	8EQmMc+pgF/a+eAcDVfU2WrXU70KGd2VTp8o2kDw2n2DdLVYLxNBLvTMoTp2RA==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id oxgus_yQ6ymR; Sun, 15 Mar 2026 01:00:40 +0100 (CET)
Received: from p14sgen5.fritz.box (p57843ab9.dip0.t-ipconnect.de [87.132.58.185])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 15 Mar 2026 01:00:39 +0100 (CET)
From: Carlo Szelinsky <github@szelinsky.de>
To: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH] net: pse-pd: add LED trigger support
Date: Sun, 15 Mar 2026 00:59:16 +0100
Message-ID: <20260314235916.2391678-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267875-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid]
X-Rspamd-Queue-Id: 2B8E328F9C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add LED trigger registration and polling into the PSE core subsystem.
Per-PI "delivering" and "enabled" triggers are registered for each PSE
controller, with a configurable poll interval via the DT property
"led-poll-interval-ms".

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 123 ++++++++++++++++++++++++++++++++++
 include/linux/pse-pd/pse.h    |  23 +++++++
 2 files changed, 146 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 3beaaaeec9e1..589a9b403916 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -15,6 +15,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/rtnetlink.h>
 #include <net/net_trackers.h>
+#include <linux/leds.h>
 
 #define PSE_PW_D_LIMIT INT_MAX
 
@@ -1030,6 +1031,122 @@ static void pse_send_ntf_worker(struct work_struct *work)
 	}
 }
 
+#if IS_ENABLED(CONFIG_LEDS_TRIGGERS)
+static void pse_led_poll_work(struct work_struct *work)
+{
+	struct pse_controller_dev *pcdev =
+		container_of(work, struct pse_controller_dev,
+			     led_poll_work.work);
+	int i;
+
+	mutex_lock(&pcdev->lock);
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		struct pse_pi_led_triggers *trigs = &pcdev->pi_led_trigs[i];
+		struct pse_pw_status pw_status = {};
+		struct pse_admin_state admin_state = {};
+		bool delivering, enabled;
+
+		if (!pcdev->pi[i].rdev)
+			continue;
+
+		if (pcdev->ops->pi_get_pw_status(pcdev, i, &pw_status))
+			continue;
+		if (pcdev->ops->pi_get_admin_state(pcdev, i, &admin_state))
+			continue;
+
+		delivering = pw_status.c33_pw_status ==
+			ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
+		enabled = admin_state.c33_admin_state ==
+			ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
+
+		if (trigs->last_delivering != delivering) {
+			trigs->last_delivering = delivering;
+			led_trigger_event(&trigs->delivering,
+					  delivering ? LED_FULL : LED_OFF);
+		}
+
+		if (trigs->last_enabled != enabled) {
+			trigs->last_enabled = enabled;
+			led_trigger_event(&trigs->enabled,
+					  enabled ? LED_FULL : LED_OFF);
+		}
+	}
+	mutex_unlock(&pcdev->lock);
+
+	schedule_delayed_work(&pcdev->led_poll_work,
+			      msecs_to_jiffies(pcdev->led_poll_interval_ms));
+}
+
+static int pse_led_triggers_register(struct pse_controller_dev *pcdev)
+{
+	struct device *dev = pcdev->dev;
+	const char *node_name;
+	int i, ret;
+
+	node_name = dev->of_node ? dev->of_node->name : dev_name(dev);
+
+	of_property_read_u32(dev->of_node, "led-poll-interval-ms",
+			     &pcdev->led_poll_interval_ms);
+	if (!pcdev->led_poll_interval_ms)
+		pcdev->led_poll_interval_ms = 500;
+
+	pcdev->pi_led_trigs = devm_kcalloc(dev, pcdev->nr_lines,
+					   sizeof(*pcdev->pi_led_trigs),
+					   GFP_KERNEL);
+	if (!pcdev->pi_led_trigs)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&pcdev->led_poll_work, pse_led_poll_work);
+
+	for (i = 0; i < pcdev->nr_lines; i++) {
+		struct pse_pi_led_triggers *trigs = &pcdev->pi_led_trigs[i];
+
+		if (!pcdev->pi[i].rdev)
+			continue;
+
+		trigs->delivering.name = devm_kasprintf(dev, GFP_KERNEL,
+							"%s:port%d:delivering",
+							node_name, i);
+		if (!trigs->delivering.name)
+			return -ENOMEM;
+
+		ret = devm_led_trigger_register(dev, &trigs->delivering);
+		if (ret)
+			return ret;
+
+		trigs->enabled.name = devm_kasprintf(dev, GFP_KERNEL,
+						     "%s:port%d:enabled",
+						     node_name, i);
+		if (!trigs->enabled.name)
+			return -ENOMEM;
+
+		ret = devm_led_trigger_register(dev, &trigs->enabled);
+		if (ret)
+			return ret;
+	}
+
+	schedule_delayed_work(&pcdev->led_poll_work,
+			      msecs_to_jiffies(pcdev->led_poll_interval_ms));
+
+	return 0;
+}
+
+static void pse_led_triggers_cancel(struct pse_controller_dev *pcdev)
+{
+	if (pcdev->pi_led_trigs)
+		cancel_delayed_work_sync(&pcdev->led_poll_work);
+}
+#else
+static int pse_led_triggers_register(struct pse_controller_dev *pcdev)
+{
+	return 0;
+}
+
+static void pse_led_triggers_cancel(struct pse_controller_dev *pcdev)
+{
+}
+#endif /* CONFIG_LEDS_TRIGGERS */
+
 /**
  * pse_controller_register - register a PSE controller device
  * @pcdev: a pointer to the initialized PSE controller device
@@ -1104,6 +1221,11 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
 
+	ret = pse_led_triggers_register(pcdev);
+	if (ret)
+		dev_warn(pcdev->dev, "Failed to register LED triggers: %d\n",
+			 ret);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
@@ -1114,6 +1236,7 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
+	pse_led_triggers_cancel(pcdev);
 	pse_flush_pw_ds(pcdev);
 	pse_release_pis(pcdev);
 	if (pcdev->irq)
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 4e5696cfade7..9e5d0123223e 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -11,6 +11,7 @@
 #include <uapi/linux/ethtool.h>
 #include <uapi/linux/ethtool_netlink_generated.h>
 #include <linux/regulator/driver.h>
+#include <linux/leds.h>
 
 /* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
 #define MAX_PI_CURRENT 1920000
@@ -266,6 +267,23 @@ struct pse_pi {
 	int pw_allocated_mW;
 };
 
+#if IS_ENABLED(CONFIG_LEDS_TRIGGERS)
+/**
+ * struct pse_pi_led_triggers - LED trigger state for a PSE PI
+ *
+ * @delivering: LED trigger for power delivering state
+ * @enabled: LED trigger for admin enabled state
+ * @last_delivering: cached delivering state for change detection
+ * @last_enabled: cached enabled state for change detection
+ */
+struct pse_pi_led_triggers {
+	struct led_trigger delivering;
+	struct led_trigger enabled;
+	bool last_delivering;
+	bool last_enabled;
+};
+#endif
+
 /**
  * struct pse_ntf - PSE notification element
  *
@@ -317,6 +335,11 @@ struct pse_controller_dev {
 	struct work_struct ntf_work;
 	DECLARE_KFIFO_PTR(ntf_fifo, struct pse_ntf);
 	spinlock_t ntf_fifo_lock; /* Protect @ntf_fifo writer */
+#if IS_ENABLED(CONFIG_LEDS_TRIGGERS)
+	struct pse_pi_led_triggers *pi_led_trigs;
+	struct delayed_work led_poll_work;
+	unsigned int led_poll_interval_ms;
+#endif
 };
 
 /**
-- 
2.43.0


