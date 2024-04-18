Return-Path: <netdev+bounces-89400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347028AA398
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF59B2547F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC0199EB3;
	Thu, 18 Apr 2024 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vV7bR+T7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427C8199EAA
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469944; cv=none; b=Cx7jSlSCL515YUMeKlROnG40XmJCAPLQHz4g2zwavJcBOtx4+d8n8gbUI79R/JqmT/nL3BrikUDMoiYKICY0oov3PaaQCmDMBSAotkZwHDGyKfzSQ1thK7dEcXbXG8bymHVKZ7Cc1JxI+Jhnp8bpRFvVChFcUF5TrmEeyBZopkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469944; c=relaxed/simple;
	bh=VDZOieUcpyDEH/t+Pr0QmpUi6oADY+eslJ7Li5e0SJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CFnO8SvLkqOn7GgqdjMBtPG/13lI6hIo4087JO+5GxBsa7s4ZnfZdtCuCX+xUWzpu62OGRIgtpcoX+M2bT5SaUtWEe4vKt7I1HGg/aw9gdpXp7MoMGJX9yM4nNP4qY5tx1rdKkNFQh6njqqs3/5QKr8csaQhlZSpntpVb+YOD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vV7bR+T7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61890f3180aso25656717b3.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713469942; x=1714074742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVq9F9kHzNjyGhFTT6oKSDsOUC90CKKFIrQakeiM3wM=;
        b=vV7bR+T7LuDqc9a0vdOLz8NJ8JwANB02pJVqySBRgBoGS2yDjxH4caMf0J3MogjbBu
         Cz8FjJG+8tTiMw7czORN+F15Z5Cj+XDG5Td7ZaMZ7S/b5nP5NTnjdY7MXh6rAnrqi3FH
         bmZBG53wVvj690XF4ONRK7GJYrstVCpNLolwHxJ2AGftYHT88T3oEtylZA74eB4TUfAa
         StYSJAoFjCysVEOSoaJ63kVtRFZH9bK/m4RcNOGC49IHo8AwtlFvbAypxcMOWQXBHbj3
         PBOckSwQ702Dn6wgG2cocG5h/zKzgMqXlHM9WsnzcrFYGiiUh5kkOXJ15sL8wnVrXE9I
         gaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469942; x=1714074742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVq9F9kHzNjyGhFTT6oKSDsOUC90CKKFIrQakeiM3wM=;
        b=FR0v6TpkgUh4umsSFAW1GLJBCuBhA/c+1PbWqk6rFWwJSBwUOZKf+Oxruv5k1e4HSO
         muU+XKczLUx/56QLScNsxriQfGSE0MEz8GYTfygF0+yExZtcQicAc1G25B3Iezv6Tv0H
         qgBhO9VF5R4b4PIw4zp2BtfS3+a+ZxjsIZX0TTqh+ZZ1Y+nx1cTIYZ/TAfQXEQLqI+MA
         D80IugkRJxx7L7MuPpS0ieWPgZ7dUsmvP1f2FO5m3AjPcyOGPBcqSPUCBxlCOQ752rT7
         QjY2Lfg4vaBsu3FdWRz83v7DtBhIPmXu3f6psbFX9BHbYF1KeryDbpHOaR0JeOZaeu33
         lYDQ==
X-Gm-Message-State: AOJu0YwTx54UQrRm6a5+ESxGcRh4st06Jtn1XqR13u9i6CMNBfQmRokk
	XKw4ZQvM2vQY70cXyxbvmI88Cauv1y02v8nRkjEkG+RCL6PMUM0+OH+yoYn+gqnfuGwts1ZgNSU
	lA9xGJodaWFrn2Kqjj3FQxx1hiqMogHyNoyMuydZ2FoHZR2AUv67Q+LAoctKsvG31/Y/dO2C5OI
	lCo+v5spjQTQdphrynmZttZRC60Ps+g7tcjtI1ndLUkeA=
X-Google-Smtp-Source: AGHT+IGYMptObfYfddez9gNLgoWxhf8RHjzl4Y5YOS1Sry1gFL5zF9KdoHdIuRJzBXPZR2NUhbpFeEHW9gl1bA==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a0d:ccce:0:b0:61b:1346:3cd5 with SMTP id
 o197-20020a0dccce000000b0061b13463cd5mr797946ywd.9.1713469942068; Thu, 18 Apr
 2024 12:52:22 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:51:53 +0000
In-Reply-To: <20240418195159.3461151-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418195159.3461151-4-shailend@google.com>
Subject: [RFC PATCH net-next 3/9] gve: Add adminq funcs to add/remove a single
 Rx queue
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

This allows for implementing future ndo hooks that act on a single
queue.

Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 79 ++++++++++++++------
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 2 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b2b619aa2310..1b066c92d812 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -630,14 +630,15 @@ int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_que
 	return gve_adminq_kick_and_wait(priv);
 }
 
-static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
+static void gve_adminq_get_create_rx_queue_cmd(struct gve_priv *priv,
+					       union gve_adminq_command *cmd,
+					       u32 queue_index)
 {
 	struct gve_rx_ring *rx = &priv->rx[queue_index];
-	union gve_adminq_command cmd;
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.opcode = cpu_to_be32(GVE_ADMINQ_CREATE_RX_QUEUE);
-	cmd.create_rx_queue = (struct gve_adminq_create_rx_queue) {
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->opcode = cpu_to_be32(GVE_ADMINQ_CREATE_RX_QUEUE);
+	cmd->create_rx_queue = (struct gve_adminq_create_rx_queue) {
 		.queue_id = cpu_to_be32(queue_index),
 		.ntfy_id = cpu_to_be32(rx->ntfy_id),
 		.queue_resources_addr = cpu_to_be64(rx->q_resources_bus),
@@ -648,13 +649,13 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 		u32 qpl_id = priv->queue_format == GVE_GQI_RDA_FORMAT ?
 			GVE_RAW_ADDRESSING_QPL_ID : rx->data.qpl->id;
 
-		cmd.create_rx_queue.rx_desc_ring_addr =
+		cmd->create_rx_queue.rx_desc_ring_addr =
 			cpu_to_be64(rx->desc.bus),
-		cmd.create_rx_queue.rx_data_ring_addr =
+		cmd->create_rx_queue.rx_data_ring_addr =
 			cpu_to_be64(rx->data.data_bus),
-		cmd.create_rx_queue.index = cpu_to_be32(queue_index);
-		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
-		cmd.create_rx_queue.packet_buffer_size = cpu_to_be16(rx->packet_buffer_size);
+		cmd->create_rx_queue.index = cpu_to_be32(queue_index);
+		cmd->create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
+		cmd->create_rx_queue.packet_buffer_size = cpu_to_be16(rx->packet_buffer_size);
 	} else {
 		u32 qpl_id = 0;
 
@@ -662,25 +663,39 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 			qpl_id = GVE_RAW_ADDRESSING_QPL_ID;
 		else
 			qpl_id = rx->dqo.qpl->id;
-		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
-		cmd.create_rx_queue.rx_desc_ring_addr =
+		cmd->create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
+		cmd->create_rx_queue.rx_desc_ring_addr =
 			cpu_to_be64(rx->dqo.complq.bus);
-		cmd.create_rx_queue.rx_data_ring_addr =
+		cmd->create_rx_queue.rx_data_ring_addr =
 			cpu_to_be64(rx->dqo.bufq.bus);
-		cmd.create_rx_queue.packet_buffer_size =
+		cmd->create_rx_queue.packet_buffer_size =
 			cpu_to_be16(priv->data_buffer_size_dqo);
-		cmd.create_rx_queue.rx_buff_ring_size =
+		cmd->create_rx_queue.rx_buff_ring_size =
 			cpu_to_be16(priv->rx_desc_cnt);
-		cmd.create_rx_queue.enable_rsc =
+		cmd->create_rx_queue.enable_rsc =
 			!!(priv->dev->features & NETIF_F_LRO);
 		if (priv->header_split_enabled)
-			cmd.create_rx_queue.header_buffer_size =
+			cmd->create_rx_queue.header_buffer_size =
 				cpu_to_be16(priv->header_buf_size);
 	}
+}
 
+static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
+{
+	union gve_adminq_command cmd;
+
+	gve_adminq_get_create_rx_queue_cmd(priv, &cmd, queue_index);
 	return gve_adminq_issue_cmd(priv, &cmd);
 }
 
+int gve_adminq_create_single_rx_queue(struct gve_priv *priv, u32 queue_index)
+{
+	union gve_adminq_command cmd;
+
+	gve_adminq_get_create_rx_queue_cmd(priv, &cmd, queue_index);
+	return gve_adminq_execute_cmd(priv, &cmd);
+}
+
 int gve_adminq_create_rx_queues(struct gve_priv *priv, u32 num_queues)
 {
 	int err;
@@ -727,17 +742,22 @@ int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_qu
 	return gve_adminq_kick_and_wait(priv);
 }
 
+static void gve_adminq_make_destroy_rx_queue_cmd(union gve_adminq_command *cmd,
+						 u32 queue_index)
+{
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->opcode = cpu_to_be32(GVE_ADMINQ_DESTROY_RX_QUEUE);
+	cmd->destroy_rx_queue = (struct gve_adminq_destroy_rx_queue) {
+		.queue_id = cpu_to_be32(queue_index),
+	};
+}
+
 static int gve_adminq_destroy_rx_queue(struct gve_priv *priv, u32 queue_index)
 {
 	union gve_adminq_command cmd;
 	int err;
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.opcode = cpu_to_be32(GVE_ADMINQ_DESTROY_RX_QUEUE);
-	cmd.destroy_rx_queue = (struct gve_adminq_destroy_rx_queue) {
-		.queue_id = cpu_to_be32(queue_index),
-	};
-
+	gve_adminq_make_destroy_rx_queue_cmd(&cmd, queue_index);
 	err = gve_adminq_issue_cmd(priv, &cmd);
 	if (err)
 		return err;
@@ -745,6 +765,19 @@ static int gve_adminq_destroy_rx_queue(struct gve_priv *priv, u32 queue_index)
 	return 0;
 }
 
+int gve_adminq_destroy_single_rx_queue(struct gve_priv *priv, u32 queue_index)
+{
+	union gve_adminq_command cmd;
+	int err;
+
+	gve_adminq_make_destroy_rx_queue_cmd(&cmd, queue_index);
+	err = gve_adminq_execute_cmd(priv, &cmd);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 {
 	int err;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index beedf2353847..e64f0dbe744d 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -451,7 +451,9 @@ int gve_adminq_configure_device_resources(struct gve_priv *priv,
 int gve_adminq_deconfigure_device_resources(struct gve_priv *priv);
 int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues);
 int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues);
+int gve_adminq_create_single_rx_queue(struct gve_priv *priv, u32 queue_index);
 int gve_adminq_create_rx_queues(struct gve_priv *priv, u32 num_queues);
+int gve_adminq_destroy_single_rx_queue(struct gve_priv *priv, u32 queue_index);
 int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 queue_id);
 int gve_adminq_register_page_list(struct gve_priv *priv,
 				  struct gve_queue_page_list *qpl);
-- 
2.44.0.769.g3c40516874-goog


