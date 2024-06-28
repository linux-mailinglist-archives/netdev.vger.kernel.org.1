Return-Path: <netdev+bounces-107827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51F591C771
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B01B281513
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CEE78274;
	Fri, 28 Jun 2024 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqC1h73C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967824D8BC
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607313; cv=none; b=aNUZWoEUeT+rX2EXrRQKUIyQJhXfq0ReB7fZJ1G2zhdofw6lK7rPF6+Dv3q1sdDWx0tCaMrEBwg7zxRXuG0OQkUZezrq2HdXIKU07ldTfDOp850ZPI2hBGb7TvesRhDqPUnDKlzONlyo+Irh3DfgssIy9KdL4WKrvm9eGSMu3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607313; c=relaxed/simple;
	bh=yvlJGpmkq6SE8rHhOxbZvQucvTD6lmIKy9O9tlCptCs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YdxaQ+emGVj8dVHUx9p5DGH8N6iZqT4yfXzouLWlz60tycSN5nFq599LyqplWTxYptWci/Bz+rNh4E6PSK0euh3edKtEEA5FzrPBJF6eAjwHqcTnkHIe3c40SkdemPyumjeidT6Ri4KHFix6QPnsUMwUkduvScKd9TMH8IfmD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rushilg.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqC1h73C; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rushilg.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035d85f403so1632063276.0
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 13:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719607310; x=1720212110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LE+4sjNDuMNsmkssn4vFOgLQCz5GqU0MfzEqsLC7zjc=;
        b=bqC1h73Ca9ayFSfl9IG/0LbPPhMddGzLEe4UZ9qtdwOJYiRNyGLuX3exkOBIxvYIyu
         Ilt4hr7e0uBfVRNXfLv96WV6znAfO0l2CorqKc/7PHmOqSKguoC/cK4EFiSRtSEpD/QW
         O0GGIrENiYxJmf6ZSgKI8KlvnemdIuVZTi7SFSgpF8PW032MusRdTBckLcl1wMxOq16h
         sbUYLIMXrSVqe0cQtRZvTNsXGczdU4WftHYwQEZSh0L3Wptf6mHTwHdDjzGDUFF9jP6m
         iz+1RGjXonX/OFMRVKTXnjog4MnsA5i0rkcrt8WL/mro2aF2C/lmN1vcql6AXdePQQQW
         MxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719607310; x=1720212110;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LE+4sjNDuMNsmkssn4vFOgLQCz5GqU0MfzEqsLC7zjc=;
        b=P5aS4OkMbx0RmVD8mZ6U7kxnvNMzYJtZ+mH4HUXYeadsgRgyp/X5GEDj/Ae6cN9Www
         /XwXOLLUzJjJdwA/Ybu6aFtNiwRKh//T9Qxwm2JuLa6gZINLvmHP9InMxz1SfqPiEtFj
         4cl3nj7dysF/ZhhKHEfMJ46th+RUJaltEy+2ULKdbIpc69XnBuJLqzKYnXFhlB7byZzC
         Nj5Z/PwmLhKVB8UjC26tHsV/pLQ5AsbavQdTpqoptm/NsrN/wNa6MtzBpx++U+w12PFs
         SMfuD61FZUypjOyWVPyMipCLJO9MnWOAGd/HtGHXhaRy1l8MdEPfKj9ad5/IkeEdV36u
         gXcw==
X-Gm-Message-State: AOJu0YwmYUEmch0WRFdKrrHpE/tIUxf/Wn4XqSMZOzivgmyG+056av2a
	5ulr9aL+uBHUPNrBkrvTEEsddwCmO2sY/5nfvHegdeqOmO3/0FNjk3kEW3nCb35gREW4wOzQYyE
	ZOnJxrOhzKMK8pi25WcW3KJ2bbnoBA7AwPUvuBVdhPiTlHZSOq24uRO3Ue83A6Mp25PPDSdo7yd
	l2z2a6gWbkUyBKa7e1RjzVR0Yu5VtYhCwh4RIHCw==
X-Google-Smtp-Source: AGHT+IFeCH2fxj2iNPNd24HzOMEZ3/WIBr9S4OsnEz1Z6L1lXZtwLJdUG0jHNH7JwKq9Z5zar2up4BB6y4ED
X-Received: from wrushilg.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2168])
 (user=rushilg job=sendgmr) by 2002:a05:6902:2d45:b0:e03:6555:b605 with SMTP
 id 3f1490d57ef6-e036555b8b7mr2016276.13.1719607309963; Fri, 28 Jun 2024
 13:41:49 -0700 (PDT)
Date: Fri, 28 Jun 2024 20:41:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628204139.458075-1-rushilg@google.com>
Subject: [PATCH net-next] gve: Add retry logic for recoverable adminq errors
From: Rushil Gupta <rushilg@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, willemb@google.com, 
	hramamurthy@google.com, Rushil Gupta <rushilg@google.com>, 
	Shailend Chand <shailend@google.com>, Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

An adminq command is retried if it fails with an ETIME error code
which translates to the deadline exceeded error for the device.
The create and destroy adminq commands are now managed via a common
method. This method keeps track of return codes for each queue and retries
the commands for the queues that failed with ETIME.
Other adminq commands that do not require queue level granularity are
simply retried in gve_adminq_execute_cmd.

Signed-off-by: Rushil Gupta <rushilg@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Reviewed-by: Shailend Chand <shailend@google.com>
Reviewed-by: Ziwei Xiao <ziweixiao@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 197 ++++++++++++-------
 drivers/net/ethernet/google/gve/gve_adminq.h |   5 +
 2 files changed, 129 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index c5bbc1b7524e..74c61b90ea45 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -12,7 +12,7 @@
 
 #define GVE_MAX_ADMINQ_RELEASE_CHECK	500
 #define GVE_ADMINQ_SLEEP_LEN		20
-#define GVE_MAX_ADMINQ_EVENT_COUNTER_CHECK	100
+#define GVE_MAX_ADMINQ_EVENT_COUNTER_CHECK	1000
 
 #define GVE_DEVICE_OPTION_ERROR_FMT "%s option error:\n" \
 "Expected: length=%d, feature_mask=%x.\n" \
@@ -415,14 +415,17 @@ static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
 /* Flushes all AQ commands currently queued and waits for them to complete.
  * If there are failures, it will return the first error.
  */
-static int gve_adminq_kick_and_wait(struct gve_priv *priv)
+static int gve_adminq_kick_and_wait(struct gve_priv *priv, int ret_cnt, int *ret_codes)
 {
 	int tail, head;
-	int i;
+	int i, j;
 
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
 	head = priv->adminq_prod_cnt;
 
+	if ((head - tail) > ret_cnt)
+		return -EINVAL;
+
 	gve_adminq_kick_cmd(priv, head);
 	if (!gve_adminq_wait_for_cmd(priv, head)) {
 		dev_err(&priv->pdev->dev, "AQ commands timed out, need to reset AQ\n");
@@ -430,16 +433,13 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
 		return -ENOTRECOVERABLE;
 	}
 
-	for (i = tail; i < head; i++) {
+	for (i = tail, j = 0; i < head; i++, j++) {
 		union gve_adminq_command *cmd;
-		u32 status, err;
+		u32 status;
 
 		cmd = &priv->adminq[i & priv->adminq_mask];
 		status = be32_to_cpu(READ_ONCE(cmd->status));
-		err = gve_adminq_parse_err(priv, status);
-		if (err)
-			// Return the first error if we failed.
-			return err;
+		ret_codes[j] = gve_adminq_parse_err(priv, status);
 	}
 
 	return 0;
@@ -458,24 +458,8 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
 
 	// Check if next command will overflow the buffer.
-	if (((priv->adminq_prod_cnt + 1) & priv->adminq_mask) ==
-	    (tail & priv->adminq_mask)) {
-		int err;
-
-		// Flush existing commands to make room.
-		err = gve_adminq_kick_and_wait(priv);
-		if (err)
-			return err;
-
-		// Retry.
-		tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
-		if (((priv->adminq_prod_cnt + 1) & priv->adminq_mask) ==
-		    (tail & priv->adminq_mask)) {
-			// This should never happen. We just flushed the
-			// command queue so there should be enough space.
-			return -ENOMEM;
-		}
-	}
+	if ((priv->adminq_prod_cnt - tail) > priv->adminq_mask)
+		return -ENOMEM;
 
 	cmd = &priv->adminq[priv->adminq_prod_cnt & priv->adminq_mask];
 	priv->adminq_prod_cnt++;
@@ -544,8 +528,9 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 static int gve_adminq_execute_cmd(struct gve_priv *priv,
 				  union gve_adminq_command *cmd_orig)
 {
+	int retry_cnt = 0;
 	u32 tail, head;
-	int err;
+	int err, ret;
 
 	mutex_lock(&priv->adminq_lock);
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
@@ -555,15 +540,21 @@ static int gve_adminq_execute_cmd(struct gve_priv *priv,
 		goto out;
 	}
 
-	err = gve_adminq_issue_cmd(priv, cmd_orig);
-	if (err)
-		goto out;
+	do {
+		err = gve_adminq_issue_cmd(priv, cmd_orig);
+		if (err)
+			goto out;
 
-	err = gve_adminq_kick_and_wait(priv);
+		err = gve_adminq_kick_and_wait(priv, 1, &ret);
+		if (err)
+			goto out;
+	} while (ret == -ETIME && ++retry_cnt < GVE_ADMINQ_RETRY_COUNT);
 
 out:
 	mutex_unlock(&priv->adminq_lock);
-	return err;
+	if (err)
+		return err;
+	return ret;
 }
 
 static int gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opcode,
@@ -638,6 +629,98 @@ int gve_adminq_deconfigure_device_resources(struct gve_priv *priv)
 	return gve_adminq_execute_cmd(priv, &cmd);
 }
 
+typedef int (gve_adminq_queue_cmd) (struct gve_priv *priv, u32 queue_index);
+
+static int gve_adminq_manage_queues(struct gve_priv *priv,
+				    gve_adminq_queue_cmd *cmd,
+				    u32 start_id, u32 num_queues)
+{
+	u32 cmd_idx, queue_idx, ret_code_idx;
+	int queue_done = -1;
+	int *queues_waiting;
+	int retry_cnt = 0;
+	int retry_needed;
+	int *ret_codes;
+	int *commands;
+	int err;
+	int ret;
+
+	queues_waiting = kvcalloc(num_queues, sizeof(int), GFP_KERNEL);
+	if (!queues_waiting)
+		return -ENOMEM;
+	ret_codes = kvcalloc(num_queues, sizeof(int), GFP_KERNEL);
+	if (!ret_codes) {
+		err = -ENOMEM;
+		goto free_with_queues_waiting;
+	}
+	commands = kvcalloc(num_queues, sizeof(int), GFP_KERNEL);
+	if (!commands) {
+		err = -ENOMEM;
+		goto free_with_ret_codes;
+	}
+
+	for (queue_idx = 0; queue_idx < num_queues; queue_idx++)
+		queues_waiting[queue_idx] = start_id + queue_idx;
+	do {
+		retry_needed = 0;
+		queue_idx = 0;
+		while (queue_idx < num_queues) {
+			cmd_idx = 0;
+			while (queue_idx < num_queues) {
+				if (queues_waiting[queue_idx] != queue_done) {
+					err = cmd(priv, queues_waiting[queue_idx]);
+					if (err == -ENOMEM)
+						break;
+					if (err)
+						goto free_with_commands;
+					commands[cmd_idx++] = queue_idx;
+				}
+				queue_idx++;
+			}
+
+			if (queue_idx < num_queues)
+				dev_dbg(&priv->pdev->dev,
+					"Issued %d of %d batched commands\n",
+					queue_idx, num_queues);
+
+			err = gve_adminq_kick_and_wait(priv, cmd_idx, ret_codes);
+			if (err)
+				goto free_with_commands;
+
+			for (ret_code_idx = 0; ret_code_idx < cmd_idx; ret_code_idx++) {
+				if (ret_codes[ret_code_idx] == 0) {
+					queues_waiting[commands[ret_code_idx]] = queue_done;
+				} else if (ret_codes[ret_code_idx] != -ETIME) {
+					ret = ret_codes[ret_code_idx];
+					goto free_with_commands;
+				} else {
+					retry_needed++;
+				}
+			}
+
+			if (retry_needed)
+				dev_dbg(&priv->pdev->dev,
+					"Issued %d batched commands, %d needed a retry\n",
+					cmd_idx, retry_needed);
+		}
+	} while (retry_needed && ++retry_cnt < GVE_ADMINQ_RETRY_COUNT);
+
+	ret = retry_needed ? -ETIME : 0;
+
+free_with_commands:
+	kvfree(commands);
+	commands = NULL;
+free_with_ret_codes:
+	kvfree(ret_codes);
+	ret_codes = NULL;
+free_with_queues_waiting:
+	kvfree(queues_waiting);
+	queues_waiting = NULL;
+	if (err)
+		return err;
+	return ret;
+}
+
 static int gve_adminq_create_tx_queue(struct gve_priv *priv, u32 queue_index)
 {
 	struct gve_tx_ring *tx = &priv->tx[queue_index];
@@ -678,16 +761,8 @@ static int gve_adminq_create_tx_queue(struct gve_priv *priv, u32 queue_index)
 
 int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues)
 {
-	int err;
-	int i;
-
-	for (i = start_id; i < start_id + num_queues; i++) {
-		err = gve_adminq_create_tx_queue(priv, i);
-		if (err)
-			return err;
-	}
-
-	return gve_adminq_kick_and_wait(priv);
+	return gve_adminq_manage_queues(priv, &gve_adminq_create_tx_queue,
+					start_id, num_queues);
 }
 
 static void gve_adminq_get_create_rx_queue_cmd(struct gve_priv *priv,
@@ -759,16 +834,8 @@ int gve_adminq_create_single_rx_queue(struct gve_priv *priv, u32 queue_index)
 
 int gve_adminq_create_rx_queues(struct gve_priv *priv, u32 num_queues)
 {
-	int err;
-	int i;
-
-	for (i = 0; i < num_queues; i++) {
-		err = gve_adminq_create_rx_queue(priv, i);
-		if (err)
-			return err;
-	}
-
-	return gve_adminq_kick_and_wait(priv);
+	return gve_adminq_manage_queues(priv, &gve_adminq_create_rx_queue,
+					0, num_queues);
 }
 
 static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queue_index)
@@ -791,16 +858,8 @@ static int gve_adminq_destroy_tx_queue(struct gve_priv *priv, u32 queue_index)
 
 int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues)
 {
-	int err;
-	int i;
-
-	for (i = start_id; i < start_id + num_queues; i++) {
-		err = gve_adminq_destroy_tx_queue(priv, i);
-		if (err)
-			return err;
-	}
-
-	return gve_adminq_kick_and_wait(priv);
+	return gve_adminq_manage_queues(priv, &gve_adminq_destroy_tx_queue,
+					start_id, num_queues);
 }
 
 static void gve_adminq_make_destroy_rx_queue_cmd(union gve_adminq_command *cmd,
@@ -832,16 +891,8 @@ int gve_adminq_destroy_single_rx_queue(struct gve_priv *priv, u32 queue_index)
 
 int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 {
-	int err;
-	int i;
-
-	for (i = 0; i < num_queues; i++) {
-		err = gve_adminq_destroy_rx_queue(priv, i);
-		if (err)
-			return err;
-	}
-
-	return gve_adminq_kick_and_wait(priv);
+	return gve_adminq_manage_queues(priv, &gve_adminq_destroy_rx_queue,
+					0, num_queues);
 }
 
 static void gve_set_default_desc_cnt(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index ed1370c9b197..96e98f65273c 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -62,6 +62,11 @@ enum gve_adminq_statuses {
 	GVE_ADMINQ_COMMAND_ERROR_UNKNOWN_ERROR		= 0xFFFFFFFF,
 };
 
+/* AdminQ commands (that aren't batched) will be retried if they encounter
+ * an recoverable error.
+ */
+#define GVE_ADMINQ_RETRY_COUNT 3
+
 #define GVE_ADMINQ_DEVICE_DESCRIPTOR_VERSION 1
 
 /* All AdminQ command structs should be naturally packed. The static_assert
-- 
2.45.2.803.g4e1b14247a-goog


