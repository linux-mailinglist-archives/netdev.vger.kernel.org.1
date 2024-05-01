Return-Path: <netdev+bounces-92854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BC58B9254
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EAB2824FF
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0608E16ABF3;
	Wed,  1 May 2024 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXLJeZNW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5766916ABCE
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605964; cv=none; b=DOCBq3Ehu7b5yVwi7zuZflw4f0PRylnG5iMgcl6HBtJD6yJ5R6eJZfsRA4VOvjEgnnnp1BAbuTZOUcDTVrYboSVmLgGAzx/q1PpJBSCZbVHDjEiNzgQkr2S0UFTQs+3SjOKH7uzzgVJVhQCuQx/t9NEWTWTAJ6wT1rqFW3GdWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605964; c=relaxed/simple;
	bh=25lUAmj31UZCXn/MJf1dSFdnTzHm03fKdZ45toY82aI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fgkr4069ojzCIoF6Ulry2pzpYeYihm5Nk04+5v+ZUA3YT+ydcLxq/6UzV3PmrS6lRfRGckKMEOBacmlwGEYm43FRFdixyBNL3tWll4LfNpg/xeN+myM8Wulvwd2845AQETPTxShRMT6xSpb87qdoaUKZCtaPcv3o5tukFx/kE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXLJeZNW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso14289445276.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605962; x=1715210762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5IvwWkf3rTYHyQrCshDp0mGjo5tPZngfKUqXHSa0RE=;
        b=IXLJeZNWu40w8lBB2LfaKX1QJbzfkGXqQ1THSRJRUQqjk1cUV4am28G+78s48nA9ET
         shcGj85h++jFIzOf5dleFrBQlTX+PORs0Gifrd8+S6/pL5H77Guk3l/W81ooITxOLpDN
         ZmJ6iZLF+gUoM/orwRW8jEus7cdjyQxPfxwfJVbr6nyC58EHht2ZOAZWPO9W9Ls9RSu7
         9kEnTJ6rUXFUfqgoqC1igtATbkSRPGXpyrhcv1p40buuaP7Bi6C3HdiT6umKtTg3Sxnq
         D2fIEbqB9OoKLmgPs51X78AqCtRA25Jj4dswwPpjYVHhh5DykWSAPeELSD2z3Dfa+BPy
         hmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605962; x=1715210762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5IvwWkf3rTYHyQrCshDp0mGjo5tPZngfKUqXHSa0RE=;
        b=naafMxAqIRQFnXih5w5gjPKQGEB+X16gHtMGfTiRQ4ttovoXT2eWRX9b4gVSFZXN/z
         8M7Jv7NHLlFW6vMo3hpBcPFxLBeEk6FrxEY82sScmemegsBUElMjIXYbidziYNjagvf0
         tJ2A92gf9uNiT1kLIwKFwjyvuV4hF+Gau6/jCXpxoF85ix6EMNjMBAvpIulsvpMMnl70
         213uKJu7HekPKNp0S/jE2PpkkvljqAqrVKEdhVv5xPcXfjrHCmHgwU6hVYKIBVvMJhWR
         jGNyOHVbP068JJEVSgoGcq5D+ZfL4KLiHQHxz/k8AuxyjwDumTIp1Dy3uZu8a+YceZu2
         8naA==
X-Gm-Message-State: AOJu0YwP6CZPc4MR23cjfcXNjyaTwBUmu9BRg5pVbCf6GRQhYufX66A4
	xY0h2IJmwDJm00f9fid2nGcDM3F5oHyeZng06vcQ1d06wnK5FR9ncQjULqHrVDsJwD9ZgxlWYc4
	rsmCHEEKYFoBUo0w9z/oTpte0DwUBps57LnuVMCSsG2FPFFnaxyytsqsXMM+jH8sQYTVEzwtSRL
	aKebN8qCf8QFR30mTehnU8XDkaZ1JNAyanw+1qo+xpRgE=
X-Google-Smtp-Source: AGHT+IEzwHEC4agK+Tt9zNP3YB8mAX+TBRK+z6kXnglFCXfyYUTas1GltjyOTsK6OCrSF9R4NxwJvqw8DcxtHQ==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:1004:b0:de5:1ea2:fc6f with SMTP
 id w4-20020a056902100400b00de51ea2fc6fmr424990ybt.6.1714605962108; Wed, 01
 May 2024 16:26:02 -0700 (PDT)
Date: Wed,  1 May 2024 23:25:42 +0000
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501232549.1327174-4-shailend@google.com>
Subject: [PATCH net-next v2 03/10] gve: Add adminq funcs to add/remove a
 single Rx queue
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com, 
	willemb@google.com, ziweixiao@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

This allows for implementing future ndo hooks that act on a single
queue.

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 79 +++++++++++++-------
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 2 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b2b619aa2310..3df8243680d9 100644
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
 
@@ -662,25 +663,40 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
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
+
+static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
+{
+	union gve_adminq_command cmd;
 
+	gve_adminq_get_create_rx_queue_cmd(priv, &cmd, queue_index);
 	return gve_adminq_issue_cmd(priv, &cmd);
 }
 
+/* Unlike gve_adminq_create_rx_queue, this actually rings the doorbell */
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
@@ -727,22 +743,31 @@ int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_qu
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
-	int err;
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.opcode = cpu_to_be32(GVE_ADMINQ_DESTROY_RX_QUEUE);
-	cmd.destroy_rx_queue = (struct gve_adminq_destroy_rx_queue) {
-		.queue_id = cpu_to_be32(queue_index),
-	};
+	gve_adminq_make_destroy_rx_queue_cmd(&cmd, queue_index);
+	return gve_adminq_issue_cmd(priv, &cmd);
+}
 
-	err = gve_adminq_issue_cmd(priv, &cmd);
-	if (err)
-		return err;
+/* Unlike gve_adminq_destroy_rx_queue, this actually rings the doorbell */
+int gve_adminq_destroy_single_rx_queue(struct gve_priv *priv, u32 queue_index)
+{
+	union gve_adminq_command cmd;
 
-	return 0;
+	gve_adminq_make_destroy_rx_queue_cmd(&cmd, queue_index);
+	return gve_adminq_execute_cmd(priv, &cmd);
 }
 
 int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
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
2.45.0.rc0.197.gbae5840b3b-goog


