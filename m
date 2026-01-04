Return-Path: <netdev+bounces-246798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF4ACF1362
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC603025FBD
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474830FC27;
	Sun,  4 Jan 2026 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKXWqbD9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559662777FD
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552111; cv=none; b=YhMtn6P7i91p2zCegwujcH8NAhBS7lg1R7x5prDYOKTH8Y+77aD2L1cm4EDGax+OKs2HaG191A/grg01KKtSK6NCM8S4xXZIANFAaPJmrL7HFn+4X53ps4ElHTSZ6FDCMpRpEWV5hybXNXC++Ec52iyIwIbJ2IqSZIQa8ONG598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552111; c=relaxed/simple;
	bh=ptkTe+cYKKYMyCNyu+hE6VVzhConXnPLG7fL2BaD9jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxDoi5/x+y2LXvDhFzvzTqcZlShbxz6Hg/FXvPyDrvESi/RY8hUsPHQbF0ra2JAa7tMY14ddQRm/3PQOnDMAMQ/Ust6PrWLWdpKczkhDBhIfmGh9N82F7/qt0TSB2GOlWPAWNAZH6CivavRAZ/MS2LUTtEcEtCiR6/qzk3D6wLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKXWqbD9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c2af7d09533so6045139a12.1
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 10:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767552108; x=1768156908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+RTp3NdTDs9G43jfmTa4TiJRQPqbtzKxkq+h8ATOJA=;
        b=nKXWqbD94BMqeS6Lss1jvxhGjc/1ETi6piBtQWfElFYVOMIHli48EtS0UOD+DOjZto
         Pf2r8PuFvGbupMDso+P/dSr49EKXst5VygAgbWhFlyDBet4eCqDHMpBWOwUEGfD0FEsY
         29wLbr260PAVm6nq+vyC8P4G5PCkXyk+D4uUYl415ObM4nA8pI4oIIbsUE5RH1nvxkIz
         lKBouysm8L/dYx/v26xkfKc4xuExnbT6i5eXJ2lDRuEkl7u7tZhg8lYSdiN5rZzuWcbk
         LFbs3ak69/2FXg0/Mphvy+1+pwQoAT6vhxMDJnth8zJ7yX9WMO7VxwDfctgOj6Wyv1ki
         FvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767552108; x=1768156908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t+RTp3NdTDs9G43jfmTa4TiJRQPqbtzKxkq+h8ATOJA=;
        b=UGvAChS2PgOg1CZP4Y5CvLDbAZwZgkaqT6hbzJJIMn8kiGUK/7J99+C1Ty4DZgyheq
         KGMpDGt6OILrkIpCduyy8+3qgYwxsb1wXiPTMptGcL8ovfcxVGJjQpTaeVdjNgSS10md
         aIaoRhqfx5nSvAwolD87L5+5HTd/KQ5Uncoq5kMdcAaBxNi3A1rzOO1Xk9bVlFmGKAzS
         89zxfT3AiiUJKCZgZJymdO5OH0kZ91nY48AY5dSaS6Ubaa9B6PhlrnHwz+M3ANm4rSJx
         Ek4IXv30Sd0VnBpkr1AIYP0xSqGhGr9y4ixyv5equ/VjcLvZ3Q1E29tYXOfcRA+xawxq
         70tg==
X-Gm-Message-State: AOJu0YxwsT1rEf+13EKoDiOoBcFoFDF38+DSfB2eC6XfF17OGkp0v6sT
	kKocZqxERVT/sbIwNPlqRuYySJvyqSXza9aMee8XM7uIFjBcXmoB8mPI
X-Gm-Gg: AY/fxX5+tEMoRhCpZ+foR1yGlcxa9XQqzbxs1d7/NITQDFFpbUPQmcsfiSMV70cmxng
	yKx/NXMNj+WQ7GeMqEo7ZWCAdzWn23fkBldvdwfJ9exff7QNIgSFXIMTzOMjXwLh/ssdFlVSH5T
	/6lqfbdriO3QCUmAKDpFWTo0jUEhkGROJyWgGp0Y05YXYpyw0BJj0LSNAizR5A2o4WYHQdmpoHU
	mZKbzjf4fPhwtSUbTgS4UITF+QtxY9fGX7PRah3PpvXLy8pfZwIh7TQrtt9ohl00V2vIFxxtewY
	tlDmILRtyTuxc/K49xyNqS/7BBKiZLO4sQ6AvQXyV9CD9YzKrh7chjVlosCzG1CyuJVZwSe1i1G
	57hauPfn54trMVHA6Hk4DlvhMzUuitXm4tiOowziINALJztiLqVsZMx1if0l/NqQ/ZuNHtsr+HD
	yj/WWRienn6ntroWpm
X-Google-Smtp-Source: AGHT+IHdUEJsTG/UrAL6MmlJo25SvRp6Mo+4LEbJxkUmHg7eX0xVPdbQb18yA46SWxrsvVBwDIDCxA==
X-Received: by 2002:a05:7022:910:b0:11b:82b8:40ae with SMTP id a92af1059eb24-121722b5005mr40323883c88.18.1767552108263;
        Sun, 04 Jan 2026 10:41:48 -0800 (PST)
Received: from [192.168.15.94] ([179.181.255.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm170975553c88.13.2026.01.04.10.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 10:41:47 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 04 Jan 2026 18:41:12 +0000
Subject: [PATCH net-next v9 2/6] netconsole: convert 'enabled' flag to enum
 for clearer state management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260104-netcons-retrigger-v9-2-38aa643d2283@gmail.com>
References: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
In-Reply-To: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767552086; l=8948;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=ptkTe+cYKKYMyCNyu+hE6VVzhConXnPLG7fL2BaD9jQ=;
 b=d5eyZpJDzq8vHKwVepc4DHhoMhYmLnIbooQK58MeiAippIYEVKH6pgrOvzGqukKC/xiXJMImh
 sxzrxhkAs3iAMu1FQFO/ChRCXUZZTGzSM8j7e/Pq8q7hsQCUQLHWU4j
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patch refactors the netconsole driver's target enabled state from a
simple boolean to an explicit enum (`target_state`).

This allow the states to be expanded to a new state in the upcoming
change.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 52 ++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e2ec09f238a0..b21ecea60d52 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -135,12 +135,12 @@ enum target_state {
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
@@ -170,7 +170,7 @@ struct netconsole_target {
 	u32			msgcounter;
 #endif
 	struct netconsole_target_stats stats;
-	bool			enabled;
+	enum target_state	state;
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
@@ -262,6 +262,7 @@ static struct netconsole_target *alloc_and_init(void)
 	nt->np.local_port = 6665;
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
+	nt->state = STATE_DISABLED;
 
 	return nt;
 }
@@ -280,7 +281,7 @@ static void netconsole_process_cleanups_core(void)
 	mutex_lock(&target_cleanup_list_lock);
 	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list) {
 		/* all entries in the cleanup_list needs to be disabled */
-		WARN_ON_ONCE(nt->enabled);
+		WARN_ON_ONCE(nt->state == STATE_ENABLED);
 		do_netpoll_cleanup(&nt->np);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
@@ -403,7 +404,7 @@ static void trim_newline(char *s, size_t maxlen)
 
 static ssize_t enabled_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", to_target(item)->enabled);
+	return sysfs_emit(buf, "%d\n", to_target(item)->state == STATE_ENABLED);
 }
 
 static ssize_t extended_show(struct config_item *item, char *buf)
@@ -570,8 +571,8 @@ static ssize_t enabled_store(struct config_item *item,
 		const char *buf, size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
+	bool enabled, current_enabled;
 	unsigned long flags;
-	bool enabled;
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
@@ -580,9 +581,10 @@ static ssize_t enabled_store(struct config_item *item,
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
 
@@ -615,16 +617,16 @@ static ssize_t enabled_store(struct config_item *item,
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
@@ -653,7 +655,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		ret = -EINVAL;
@@ -680,7 +682,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED)  {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		ret = -EINVAL;
@@ -704,7 +706,7 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 	struct netconsole_target *nt = to_target(item);
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		mutex_unlock(&dynamic_netconsole_mutex);
@@ -725,7 +727,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -747,7 +749,7 @@ static ssize_t remote_port_store(struct config_item *item,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -770,7 +772,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -795,7 +797,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -830,7 +832,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -1326,7 +1328,7 @@ static void drop_netconsole_target(struct config_group *group,
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
@@ -1725,7 +1727,8 @@ static void write_ext_msg(struct console *con, const char *msg,
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list)
-		if (nt->extended && nt->enabled && netif_running(nt->np.dev))
+		if (nt->extended && nt->state == STATE_ENABLED &&
+		    netif_running(nt->np.dev))
 			send_ext_msg_udp(nt, msg, len);
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
@@ -1745,7 +1748,8 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
+		if (!nt->extended && nt->state == STATE_ENABLED &&
+		    netif_running(nt->np.dev)) {
 			/*
 			 * We nest this inside the for-each-target loop above
 			 * so that we're able to get as much logging out to
@@ -1901,7 +1905,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 			 */
 			goto fail;
 	} else {
-		nt->enabled = true;
+		nt->state = STATE_ENABLED;
 	}
 	populate_configfs_item(nt, cmdline_count);
 

-- 
2.52.0


