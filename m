Return-Path: <netdev+bounces-106292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C4915ADC
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 02:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996791C21513
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 00:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0312B82;
	Tue, 25 Jun 2024 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MN7vWTj5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D87F9FE
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274363; cv=none; b=hLn/0nfsrU7Au3MY+GkKe00Svwce2zfb8jBdUZw+WI1mgRNMxk81Mp7I5q10i4xeKWoqKs3KPh13Ukna6NVZLHTeTdhCkC2/mV246r7Dk3g0rXUi1D3qGgjgyNfOsmPOM517mbWaRoQX9P4ycrh4aCoEWvHXgbE1O5u4mf4fGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274363; c=relaxed/simple;
	bh=Y061ARsTcLL64UeCL1OpNBWRzTIabPLT+H5igaWLknE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJAz0zCKcyyazqH7teRdQMlukPEWxuw0rDnIO1tZyrPSIu07eZ3L+UsrhqKzMdcdBAuA3Sv20wx1DE653BVW3BJFaP4YxyVbdxGlZzeMS4Hjc8R/I6VLIGJBl0YEMgJFtFIrvo4atF/0eo6EiW8SUm23QDBoRA4CERdOv1kNe5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MN7vWTj5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02bb412435so10417267276.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719274361; x=1719879161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7FM3/xX6Lc4btkBtIt2Q6DBER/DvgUWk0QFpD3KO0k=;
        b=MN7vWTj5djDy0K13s5GRRl7px6vrYQOwCAaZLRhk05Cl0ATvKz+SBBJXkWoXK/O5tY
         cTMB3k2NBSBMDfFhkZALCai5yNFM7zH7vRHnJuKjz9wx1DexoF5pN1UJ5qmdRopS5kT7
         NMRXFFh6Yk8r0P5bMt37nfaXvms3MzWp5cL1j2z0zhNlq7EeAR6YAvqMgQNiM87kvpKF
         bl81ihaX3bYJ7L+VW8n/1jBDgqlcnG9KLYFPF/+t5QD8lV6DioMgfLIC95rzX2JT6Kzr
         zIHk8leaQqAeObJ6AmHoGVA6yd9p+oldGk3K2k6GqGJh0zGwNdpM0trlaLmfn6CMT7eA
         4DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274361; x=1719879161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7FM3/xX6Lc4btkBtIt2Q6DBER/DvgUWk0QFpD3KO0k=;
        b=Sfs+7Z0sHb2JTmgBANxif14kg47ixUw739PQ9OGm6YHxUeKu2sdc6XqiZW5sljOKbP
         xrdZFwIcWod5TfDt1/pn156mqT94fSNa5Hc2GTveCz6zL8EegU5j45miewFm4y7KbbI5
         JdsbXogirMUNkbFh9hylb+JyxmOu8cqPad2FJ8NFGqwn+A4qz7Od7250dlwCtUBJEVXH
         XxEuainDcj8d+kVKC5YrOav6rMOoSeJrlhhuuuNSOdBOmE5cpCL7LuStEI2sGwGxYHE7
         4fB49pjxUoj+3QlLCpWO3fymzy/mhTJIKfCmhZZtIVkMvITI0K3gJictsgl0MegK/Khc
         vP2A==
X-Gm-Message-State: AOJu0YzOtv6KsP1OdvjCari90Xbd9/xO+MAomLY/ZRsjWvcXNc5NzPFC
	MoMA2ltYOZWol6qAFn8+qqZaX9K5Ww+/I+pkgAPUIme3UVYJvFwbvB3SW3QlieNWwmwAnYEP5qH
	VkSAdqZphpReUU8wyOh/tJFyMVRJBS0VjwU3/liV6zNc37+DN2NFs9ZXvXXqU4vlrHEuTiD2cQe
	tzd0P+lj1Zt3GVmpk3nXrFglElsrs5+t/p0782doMOcHhnoxIJ
X-Google-Smtp-Source: AGHT+IEpq5OYP+j22Kxkcqn+Xur49FuZ1HbNefYyLI+mw9H3zRmeAteMxjS18l883dp69g8XtKiI+FrTMIqjPlw=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:6902:c02:b0:dff:36b3:5c27 with SMTP
 id 3f1490d57ef6-e0303fd6cf4mr174201276.3.1719274360582; Mon, 24 Jun 2024
 17:12:40 -0700 (PDT)
Date: Tue, 25 Jun 2024 00:12:28 +0000
In-Reply-To: <20240625001232.1476315-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625001232.1476315-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625001232.1476315-3-ziweixiao@google.com>
Subject: [PATCH net-next v3 2/5] gve: Add adminq extended command
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

The adminq command is limited to 64 bytes per entry and it's 56 bytes
for the command itself at maximum. To support larger commands, we need
to dma_alloc a separate memory to put the command in that memory and
send the dma memory address instead of the actual command.

Introduce an extended adminq command to wrap the real command with the
inner opcode and the allocated dma memory address specified. Once the
device receives it, it can get the real command from the given dma
memory address. As designed with the device, all the extended commands
will use inner opcode larger than 0xFF.

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
Changes in v2:
	- Update the commit message to use imperative mood 
	- Add the __maybe_unused attribute for the unused function of
	  gve_adminq_execute_extended_cmd

 drivers/net/ethernet/google/gve/gve_adminq.c | 31 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h | 12 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 2e0c1eb87b11..5b54ce369eb2 100644
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
 
+static int __maybe_unused gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opcode,
+							  size_t cmd_size, void *cmd_orig)
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
2.45.2.741.gdbec12cfda-goog


