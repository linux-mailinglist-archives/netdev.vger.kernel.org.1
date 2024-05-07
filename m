Return-Path: <netdev+bounces-94300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631AC8BF0BB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 01:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09700280F22
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 23:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BDB86255;
	Tue,  7 May 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxyJ8Fzq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5229585C70
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122834; cv=none; b=QWyMunsqdpS3LiZ2RZ1vVbcKifoO1kTxQ6W6TSrL0BqTBZNRHRqAQ4OXIivWfMsLBwu1oivcrJ0aRlfk0SgezUH2lK7xz7r0Jv/jXgjMnX2o2DB3Fy/+6pm5QtdM2EjdF2E07VbYfE+QfJSg0wE4CYS3JsAcjwvaomDTYPDzDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122834; c=relaxed/simple;
	bh=4GCwDhq0fPItr6iYwK0LdmqEMJVYlgfpwBJg6tQSq7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oV/f4833pP5YXXhVaD+SEk26+ZfYNe0ndO2sNhvbKfOub/A3tnnmdARHUK5RraXTk0oCxmWUOZQsXSPqCXMumKyIwF2liLGfEIcbtliCnfsHz5IaeUGqbrbc/lH/BEWzbnGfgTYL3mHvzMRtXGQnApd9vseZ8ydGjvyAjHd/DA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OxyJ8Fzq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61c9e36888bso67934167b3.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 16:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715122832; x=1715727632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ErWdw272D2abXD7knyfrLRMhZXYPy233zUsfO32sbtE=;
        b=OxyJ8FzqKY5riQ9pEU7EsEVZjoOcO7KEhP/cRbmegkxxGqxA32vUhMc7XDtyCprOu4
         mZB4hRYYUjXKI74ZYJEoCVZtqrz3CH/35MSux2JJJgFHEzHxmBUzluxrRAD8Yah0PA+m
         itoq/0s7RmxhJK4xPUHzCqIlzcF0ZJ6TIOZEJyOxKY7WsaLE9uQyPB7d5u3IPjwdG7p6
         Pbx45qx2KlkkXUqi88iXDag3UHDy0d67ce/ckVpL9z1BLEx2bLkvLbUs4GQ97wy5snw8
         jZ2YGhL8VfhkmBUggcRUg94KI4MUR0bgaljgkY2IieFiQuHg62lgADwVOzuuv7oupsjw
         KlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715122832; x=1715727632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErWdw272D2abXD7knyfrLRMhZXYPy233zUsfO32sbtE=;
        b=ldVLF83OGx6bTmzqQKmnn517SW/lXxDx9M7No8NynzR9YjmWuEcbOoi2U5y/yc9Czg
         /4mmt1/uNL7jBQmeLxG74tsOzOMS+idJIUyqHtpLwY204gXbgIRqQo46Kr+w9iRbY5fP
         KUQjDw4+1f93/1aoLCGJqoH6nCWZyXttf/MT9LRUigqTNzGcmrlOAyxnbApDfPudINrV
         qdCADNRhTR5KnRBMbXMLDte/6yQSTM9Lu64JcRZk0MlqNJ06IAagyRAXQDB9EE0MJgg4
         njMDahXjKHQOMUgG+gNEd3qS0Y4bwIioxkp1+HQrogd0xJzUB5d5GFHdM4IDrH6XN6lb
         1FfQ==
X-Gm-Message-State: AOJu0YzqUMy4qdVpHZE0SXLFvl2xzv051pRarmDDHeKb4b6dSqc2xukb
	CrCvHYkGfQ4GkSIACBNlAp8OS1SLl6IoZAiMJ6LkXzusEBwzQBC1gHWjU/QV4tMH51RPfUBo+fV
	pfJjrd9BPRYt6vwtIwAfV7+ftDxBOIr/Kx2ALzrqwmSwAxaOddueQs/I9zB2fQwG9IeSs9nNKLn
	YdV/dc8AZVwj9Is1JTwAG6+Oz1+eGSXg0rYLlOV6cKANqp159x
X-Google-Smtp-Source: AGHT+IEggfQhoLsdVcLfNYlFhswJseZ60oKy2nS2WXx4mrxJPjXzGjrzNT06tYAu70qlMFjDc+7qBXDMHdN3Af4=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a0d:cb09:0:b0:61b:982:4da0 with SMTP id
 00721157ae682-6208582b694mr2513617b3.0.1715122831995; Tue, 07 May 2024
 16:00:31 -0700 (PDT)
Date: Tue,  7 May 2024 22:59:42 +0000
In-Reply-To: <20240507225945.1408516-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507225945.1408516-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507225945.1408516-3-ziweixiao@google.com>
Subject: [PATCH net-next 2/5] gve: Add adminq extended command
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, rushilg@google.com, 
	ziweixiao@google.com, jfraker@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

The adminq command is limited to 64 bytes per entry and it's 56 bytes
for the command itself at maximum. To support larger commands, we need
to dma_alloc a separate memory to put the command in that memory and
send the dma memory address instead of the actual command.

This change introduces an extended adminq command to wrap the real
command with the inner opcode and the allocated dma memory address
specified. Once the device receives it, it can get the real command from
the given dma memory address. As designed with the device, all the
extended commands will use inner opcode larger than 0xFF.

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 31 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h | 12 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 2c3ec5c3b114..514641b3ccc7 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -461,6 +461,8 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 
 	memcpy(cmd, cmd_orig, sizeof(*cmd_orig));
 	opcode = be32_to_cpu(READ_ONCE(cmd->opcode));
+	if (opcode == GVE_ADMINQ_EXTENDED_COMMAND)
+		opcode = be32_to_cpu(cmd->extended_command.inner_opcode);
 
 	switch (opcode) {
 	case GVE_ADMINQ_DESCRIBE_DEVICE:
@@ -537,6 +539,35 @@ static int gve_adminq_execute_cmd(struct gve_priv *priv,
 	return err;
 }
 
+static int gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opcode,
+					   size_t cmd_size, void *cmd_orig)
+{
+	union gve_adminq_command cmd;
+	dma_addr_t inner_cmd_bus;
+	void *inner_cmd;
+	int err;
+
+	inner_cmd = dma_alloc_coherent(&priv->pdev->dev, cmd_size,
+				       &inner_cmd_bus, GFP_KERNEL);
+	if (!inner_cmd)
+		return -ENOMEM;
+
+	memcpy(inner_cmd, cmd_orig, cmd_size);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.opcode = cpu_to_be32(GVE_ADMINQ_EXTENDED_COMMAND);
+	cmd.extended_command = (struct gve_adminq_extended_command) {
+		.inner_opcode = cpu_to_be32(opcode),
+		.inner_length = cpu_to_be32(cmd_size),
+		.inner_command_addr = cpu_to_be64(inner_cmd_bus),
+	};
+
+	err = gve_adminq_execute_cmd(priv, &cmd);
+
+	dma_free_coherent(&priv->pdev->dev, cmd_size, inner_cmd, inner_cmd_bus);
+	return err;
+}
+
 /* The device specifies that the management vector can either be the first irq
  * or the last irq. ntfy_blk_msix_base_idx indicates the first irq assigned to
  * the ntfy blks. It if is 0 then the management vector is last, if it is 1 then
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index e64f0dbe744d..e0370ace8397 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -25,6 +25,9 @@ enum gve_adminq_opcodes {
 	GVE_ADMINQ_REPORT_LINK_SPEED		= 0xD,
 	GVE_ADMINQ_GET_PTYPE_MAP		= 0xE,
 	GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY	= 0xF,
+
+	/* For commands that are larger than 56 bytes */
+	GVE_ADMINQ_EXTENDED_COMMAND		= 0xFF,
 };
 
 /* Admin queue status codes */
@@ -208,6 +211,14 @@ enum gve_driver_capbility {
 #define GVE_DRIVER_CAPABILITY_FLAGS3 0x0
 #define GVE_DRIVER_CAPABILITY_FLAGS4 0x0
 
+struct gve_adminq_extended_command {
+	__be32 inner_opcode;
+	__be32 inner_length;
+	__be64 inner_command_addr;
+};
+
+static_assert(sizeof(struct gve_adminq_extended_command) == 16);
+
 struct gve_driver_info {
 	u8 os_type;	/* 0x01 = Linux */
 	u8 driver_major;
@@ -432,6 +443,7 @@ union gve_adminq_command {
 			struct gve_adminq_get_ptype_map get_ptype_map;
 			struct gve_adminq_verify_driver_compatibility
 						verify_driver_compatibility;
+			struct gve_adminq_extended_command extended_command;
 		};
 	};
 	u8 reserved[64];
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


