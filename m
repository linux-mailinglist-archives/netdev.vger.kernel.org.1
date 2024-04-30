Return-Path: <netdev+bounces-92639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3D8B82ED
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E1D1C2112B
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB181C0DF0;
	Tue, 30 Apr 2024 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3g51WJGf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA981C0DE0
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518881; cv=none; b=Sq2/7dF7Eh+wfg6d4+h9QnBTg6J25o2lKJA56uEFdG6/PooOCKNezYhJTX3ms39Bc2WtkDhOKNT905+bD+6xHIOWKjPUgkxCGs5B0UVNgQahehMy//b8vvuTYn2293bNeeIzDAYflpn7e1HlxjlLK6jBIv7eCDY5uZWThY5GDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518881; c=relaxed/simple;
	bh=t+qKrNnLF+bPrbrbobIxv7gRNUfNlahiEGqwRfBYFY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oK7d/IFhLe3GHWdDQSh9f6+pgHG4qwkyYUf7UbibSGUv4TJbDaCHX1obj564kboF42jyT5QuHrnZxKi0jzEi2Rc0lhZpMSAZI2h2uxu2vwWH8Aa6BJJ7YbT6Pw5GmgYtgq8g9A8reEd+OUxhBjSyisa8lc+C753QxQnQbQJIk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3g51WJGf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de610854b8bso3267500276.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714518879; x=1715123679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jaQd9yUHbjUVdVlM5GQAUnpdTn+qzNs0u4bWWW7TDhc=;
        b=3g51WJGfLPZgevrMVsIfEa/my5iToBQ1Spjmqm+blA5toWMqypsIBJ1yET7i1r6Wfz
         Fxu4CiUps2ovPfYu5h6KJqVdiS6usDNNvn8qLbhuUaklvXQK9elxmqXD9QGDR80eOdmb
         DrWALiBL503sL788OGzioo3WwN+ylzTXZMMhnFLim1OegS1I8edcmviB5E2HW/L9rXEW
         QpjIb6jCbdHtVLeDxAxqqjfMSuFMPFgVLWPs8vjcT1EpjPIUmVRHzs7hJLybI9lzOVMk
         3IrBfZlhhU2IrWYLuwHPiTseSeBWsG1qLKS0/ktmaMCNBVSc0YhDZTmrub7zKsAeFFNX
         aN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518879; x=1715123679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaQd9yUHbjUVdVlM5GQAUnpdTn+qzNs0u4bWWW7TDhc=;
        b=oQSW/3tmjjIWiSJmxvU1YHydh1xjAallfNz0FhIq3Ckc8PayfM9lgwbct1LrGEUYBT
         +sKMdV35sefVV6q6AZn76+kAK3J8f1l59iBRtN7LuIXchykzwQF53qfhw1TvEfRw/OPj
         XSde6b+J2mWIP/yLbR70or7FmUPIFz8NJUBVoohT02YUUss6w0i6ZA6mrvl1i3EJL0sR
         DQWIM9ml6p9HFK6HcBGICIn1lDT9nIG/6jZ+REZ1Fi/WrwZi8hKV0SY3OeqbIug6V6fs
         +TCQg+M2Pb468YZu29I0kyGAkFv6/w8jyXc3APPo4sIMFw16LGoniL7yQmKts3NAPRxv
         MZdQ==
X-Gm-Message-State: AOJu0YwVU+1GwFghLqQe3OzqLUvWcR0Zd/QPrCGGfKYUW2IY7cCIkfhH
	liY6WtUFUcpgc5aoK8GVp1GWz3+rrdfEBiaee+yHRAwbPSVi1aOFkUhYj237Kdl89GoE9sudsps
	TwepnGzmunI+2gzOuiHx6GhT9YMAuXcLzKYdwSrl36QGUr6nscTjxDHsY4bfgBS2M3hKxoh54rP
	Vnyvms1ZK0wXkchSYmwdTcCXx6sQE2+TYjMfxc8bMubOk=
X-Google-Smtp-Source: AGHT+IGtAKAyFLT2BZJH21BqkvaG53Y37b8BLA5I/0NI/Q0il0x0nty6QIMUw2Y69bjkE2YEWjQAP301KmARvQ==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:727:b0:de5:60b6:fb9 with SMTP id
 l7-20020a056902072700b00de560b60fb9mr150041ybt.1.1714518878829; Tue, 30 Apr
 2024 16:14:38 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:12 +0000
In-Reply-To: <20240430231420.699177-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430231420.699177-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430231420.699177-4-shailend@google.com>
Subject: [PATCH net-next 03/10] gve: Add adminq funcs to add/remove a single
 Rx queue
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

This allows for implementing future ndo hooks that act on a single
queue.

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
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
2.45.0.rc0.197.gbae5840b3b-goog


