Return-Path: <netdev+bounces-225110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4256EB8E7BA
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 23:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3B7173C90
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 21:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B81F2D8DA6;
	Sun, 21 Sep 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP1CopkP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68802D062A
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491784; cv=none; b=GFETrp/6t8ekazBgWbUCrThPrefGvOyzu/voAqCRuztOHHVvg6ooa1dnIEKSDD0MUFPMXXZRR6g/cxE9msVKkNq1SEtAqzZFMN87eLUQ0LEjaQ54LAEPLsBCMiafbjiS4EfvO6fBIJb9VuP67z8FjG2au5ibPmdLFWk3vT6WnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491784; c=relaxed/simple;
	bh=4+rg/Gz1eysCw1FZDc5FEYkSkFXM3WUQDHMPBqpsv/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZ4Qz/K5FZheADfeRMzMHC2OHQmGpYQY8xw5PRH1rDMxDC103+mdNCjH8tRsH7PJ/rq3P6n7LLN2/3rJIelHAJasZO8X+2yV1dK6CmMGgvWL3LwCsrSnyyiM43pKG4Dx27bHmSHhMHvl2H8EgHeY2qqFH8JrXwIjJI0OFcopzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP1CopkP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4694ac46ae0so22214505e9.0
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491780; x=1759096580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+8+LQrrI546X3g2e/jgKl85KVqcdJ2/SBcOSdSAmgA=;
        b=CP1CopkPOxlL+HqMMiQkmm6c1UJFDrWB1zMUX6zdco/mtkXB4gC+g74ghnpWEDiy3O
         zIf8SJRwWD+luG5oD8t1tYZtdMaXOxZG45LFBYHAtaYhfV2vZdIO6PCObtp4njyxZn7t
         Cbq3VUXCDedFBZOPiGcl6BDG5huyCfZlo8+t5v7MF9s3FzY0ZNYDxx3oedCAGzMC+hv8
         /YKYGGDzdZgHlO1LQI8YI8gqXuZGeH0Q3yNrJycPpBgpTe8MAzBdE8J0u3uh2CXkiZro
         2XPWs/lxYjZ8YQHvuohUtrpXyQOIModWciDC0zN0+ib+H8Mj5ZaE1VuzbN89pJ8jTsjh
         HqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491780; x=1759096580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+8+LQrrI546X3g2e/jgKl85KVqcdJ2/SBcOSdSAmgA=;
        b=WkKoi/hOsKNQeaQjdxDXHqV1FH80pIbGcna7RPVvybo8LD9teFPodJXymGubE7i+wx
         wT8hYYrDjA3Es/oA8VE21HbudPQnaP/UewVkk7I7PonwBoXVisrf8i7BVRcvDSZnqQRK
         KbCw7t3CrLuaS4IYaUllqr2g2h7WDQDUNwxJEICL9xsUXOWe4Y8mQw42BBfZz2oM+iQU
         dKrlqYvNUQ9P3rIYYFV7Anj6Xc5s5CnYgdZ8fZiAQHl7OyKcm7ZmkcnBVr71m3zCf5oA
         BXoduRnI8CzPjZi7U72Lc5MmWlDgc6rsXFL88u3J5N0/9tlyrOsFMTeFXxrgMCWyChfI
         OOFA==
X-Gm-Message-State: AOJu0YynRtWMplRq249znaxAetlOUJ2nslviqa0r4jQJkMQAphskxS1V
	IxipEf119I6odrbh1cQRni7Mslk4LHpuku43ImZ7K+N/l85cjqeIXylS
X-Gm-Gg: ASbGnctZBHfxldTYto29qNa3LL3Ck+zvsLei8KggzoNfUgk5Q9Ox0BQIV+u8tzNznQd
	oVR7roPXULf2OIl6ob0btF0x3gKUOFnKKdGCiqbF5t0i5AYWvCPF/AUZF/6yzuUXOU39NcUeNBX
	Sr7wIFlGWDswZHiV1sMJSJY9JFAM80F2Dc2Sn3uImWYwMv/eC/yQTWEa+6hFcnyHHiyX7R6dvp6
	N7P3Z3M6Q7NQWEe3wL+piWZH9A/F5qOVYL0wZHuGzns/5MYmOcxmEpqnQ6ouVMJlmQCBec4HtOl
	3q0bQS/QR3p8LplZqWTB+lIKWmQg9QgeA9/fPnd5SrWHcH6iOQxYSRP6zNOQ7ZL35XOu6p2MLzp
	CYz4eU0VMh+JxqO8F2SM6uuAuyb0=
X-Google-Smtp-Source: AGHT+IEBttx6jQXzVxq2WSXXtU/eAlw1v+5DR7n3HJLoxuKnKWQJNg4GwSVXaN3tKB84Jri6tJMxyg==
X-Received: by 2002:a05:600c:5251:b0:45b:9291:320d with SMTP id 5b1f17b1804b1-467f0b4fa71mr105315625e9.31.1758491779543;
        Sun, 21 Sep 2025 14:56:19 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm5873427f8f.57.2025.09.21.14.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:56:18 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 21 Sep 2025 22:55:42 +0100
Subject: [PATCH net-next v2 2/6] netconsole: convert 'enabled' flag to enum
 for clearer state management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-netcons-retrigger-v2-2-a0e84006237f@gmail.com>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
In-Reply-To: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758491774; l=8957;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=4+rg/Gz1eysCw1FZDc5FEYkSkFXM3WUQDHMPBqpsv/g=;
 b=CTuwGCtcP5yj/y0aPhAw49lJGI5ReykRrzo5RrQU0ICkoIiOdR4/h7iBEZ2aAxkxOjQQBB3rz
 s29oWhhbI6DCNvyOkcDAG6X6Y9Fseik8h4xAb0R4ZRohgx8sbdWoUJm
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patch refactors the netconsole driver's target enabled state from a
simple boolean to an explicit enum (`target_state`).

This allow the states to be expanded to a new state in the upcoming
change.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 52 ++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b5e6a9fdc3155196d1fd7e81def584360ecbc3d2..688ed670b37b56ab4a03d43fb3de94ca0e6a8360 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -132,12 +132,12 @@ enum target_state {
  * @sysdata_fields:	Sysdata features enabled.
  * @msgcounter:	Message sent counter.
  * @stats:	Packet send stats for the target. Used for debugging.
- * @enabled:	On / off knob to enable / disable target.
+ * @state:	State of the target.
  *		Visible from userspace (read-write).
  *		We maintain a strict 1:1 correspondence between this and
  *		whether the corresponding netpoll is active or inactive.
  *		Also, other parameters of a target may be modified at
- *		runtime only when it is disabled (enabled == 0).
+ *		runtime only when it is disabled (state == STATE_DISABLED).
  * @extended:	Denotes whether console is extended or not.
  * @release:	Denotes whether kernel release version should be prepended
  *		to the message. Depends on extended console.
@@ -165,7 +165,7 @@ struct netconsole_target {
 	u32			msgcounter;
 #endif
 	struct netconsole_target_stats stats;
-	bool			enabled;
+	enum target_state	state;
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
@@ -257,6 +257,7 @@ static struct netconsole_target *alloc_and_init(void)
 	nt->np.local_port = 6665;
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
+	nt->state = STATE_DISABLED;
 
 	return nt;
 }
@@ -275,7 +276,7 @@ static void netconsole_process_cleanups_core(void)
 	mutex_lock(&target_cleanup_list_lock);
 	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list) {
 		/* all entries in the cleanup_list needs to be disabled */
-		WARN_ON_ONCE(nt->enabled);
+		WARN_ON_ONCE(nt->state == STATE_ENABLED);
 		do_netpoll_cleanup(&nt->np);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
@@ -398,7 +399,7 @@ static void trim_newline(char *s, size_t maxlen)
 
 static ssize_t enabled_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", to_target(item)->enabled);
+	return sysfs_emit(buf, "%d\n", to_target(item)->state == STATE_ENABLED);
 }
 
 static ssize_t extended_show(struct config_item *item, char *buf)
@@ -565,8 +566,8 @@ static ssize_t enabled_store(struct config_item *item,
 		const char *buf, size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
+	bool enabled, current_enabled;
 	unsigned long flags;
-	bool enabled;
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
@@ -575,9 +576,10 @@ static ssize_t enabled_store(struct config_item *item,
 		goto out_unlock;
 
 	ret = -EINVAL;
-	if (enabled == nt->enabled) {
+	current_enabled = nt->state == STATE_ENABLED;
+	if (enabled == current_enabled) {
 		pr_info("network logging has already %s\n",
-			nt->enabled ? "started" : "stopped");
+			current_enabled ? "started" : "stopped");
 		goto out_unlock;
 	}
 
@@ -610,16 +612,16 @@ static ssize_t enabled_store(struct config_item *item,
 		if (ret)
 			goto out_unlock;
 
-		nt->enabled = true;
+		nt->state = STATE_ENABLED;
 		pr_info("network logging started\n");
 	} else {	/* false */
 		/* We need to disable the netconsole before cleaning it up
 		 * otherwise we might end up in write_msg() with
-		 * nt->np.dev == NULL and nt->enabled == true
+		 * nt->np.dev == NULL and nt->state == STATE_ENABLED
 		 */
 		mutex_lock(&target_cleanup_list_lock);
 		spin_lock_irqsave(&target_list_lock, flags);
-		nt->enabled = false;
+		nt->state = STATE_DISABLED;
 		/* Remove the target from the list, while holding
 		 * target_list_lock
 		 */
@@ -648,7 +650,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		ret = -EINVAL;
@@ -675,7 +677,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED)  {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		ret = -EINVAL;
@@ -699,7 +701,7 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 	struct netconsole_target *nt = to_target(item);
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		mutex_unlock(&dynamic_netconsole_mutex);
@@ -720,7 +722,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -742,7 +744,7 @@ static ssize_t remote_port_store(struct config_item *item,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -765,7 +767,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -790,7 +792,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -839,7 +841,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -1315,7 +1317,7 @@ static void drop_netconsole_target(struct config_group *group,
 	 * The target may have never been enabled, or was manually disabled
 	 * before being removed so netpoll may have already been cleaned up.
 	 */
-	if (nt->enabled)
+	if (nt->state == STATE_ENABLED)
 		netpoll_cleanup(&nt->np);
 
 	config_item_put(&nt->group.cg_item);
@@ -1444,7 +1446,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
 			case NETDEV_UNREGISTER:
-				nt->enabled = false;
+				nt->state = STATE_DISABLED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
 			}
@@ -1711,7 +1713,8 @@ static void write_ext_msg(struct console *con, const char *msg,
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list)
-		if (nt->extended && nt->enabled && netif_running(nt->np.dev))
+		if (nt->extended && nt->state == STATE_ENABLED &&
+		    netif_running(nt->np.dev))
 			send_ext_msg_udp(nt, msg, len);
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
@@ -1731,7 +1734,8 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
+		if (!nt->extended && nt->state == STATE_ENABLED &&
+		    netif_running(nt->np.dev)) {
 			/*
 			 * We nest this inside the for-each-target loop above
 			 * so that we're able to get as much logging out to
@@ -1887,7 +1891,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 			 */
 			goto fail;
 	} else {
-		nt->enabled = true;
+		nt->state = STATE_ENABLED;
 	}
 	populate_configfs_item(nt, cmdline_count);
 

-- 
2.51.0


