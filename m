Return-Path: <netdev+bounces-106294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348A915AE0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 02:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716D228371E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 00:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5981CABF;
	Tue, 25 Jun 2024 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AnVBiaJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD51B810
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274369; cv=none; b=GlxqRBbvM1AUNUoI6vKjlU52UEwXlhfi1r8kVQSvN2m9jT7kcMEYt/qesAKrqYSsLSiPh3aijnQCVt4PesoO3VD69yU1p5NzqV2O5VZZIiEgv3sItSfEvepYTBy+Ep616QctfZy2w+/ZTfotbk4qdz02Fu5hnqkGELUwIPZPAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274369; c=relaxed/simple;
	bh=dBFYNm3aTpfSE70tpdSGiRHDYMDNY4AIIGsI5dhoMug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VjIey0LiaISv1dWYld9awITa56VaDo1XI4PooXgGV92akiRrPlpJlQoe7ILZXHAwnRYY3In/SLgy1B94HhPt1DbnxlM+B2iUTYw/UIVfkB0ZUYRb07RICzNY3aY+vY6juanSfLN71Xo7rCbqHGEKcsQNx3FxxV4TvyucXHdn0xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AnVBiaJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-646f73e4354so300177b3.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 17:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719274366; x=1719879166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JcbUqcqSFTY8MiKwhftJynNGEQrcRkI83waCED0rT6w=;
        b=3AnVBiaJvf5iJA8XY6RhI+8ovoRe+kinf/xxp7v0id2fVgQpos289grd/zALNZ5F4H
         MXb51DqzrNdQN9tLxkAj7ydV4kgV0am5E85QroFaszypRJvz8t9RK7RhY5mZOFkhgHBf
         v59fTmANS3EPezl8tIZgH/wBmviUrlebCPy43CwL++GRY1KoWhDnE1KVUI+tt7iw8y86
         Ea0Nfw9C3Ozv/sDCiSwIDaRxNEuU3emHYld5/oxP4eM26HSq9426gwE8dXHYBAMx/YD+
         0pxBqYnU4w1VTpVc6jZFBroD0E4MgO2yDwId3N+ld0Xm1YGgLTKjE+XOcEasxA7aNXhL
         ocDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274366; x=1719879166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcbUqcqSFTY8MiKwhftJynNGEQrcRkI83waCED0rT6w=;
        b=Rse6nExYeoX2VbEl30CE6EqdS3rRe3Mgo4DG+Q+Xl2LoNnVXU9lP2vLWvsveGEWIJn
         G2bRfgW2ilNkR6jJQThOBxT/0eeKelq5d/q/H3ZeqtzDIN7vHv4HP70FYMQ2pW9+Sfi0
         db3s4bNfJndR+u3h/RefLS9QUsft6eL1kNlC2CLkW5B3YZVL0NTdBDpp7yh/z1I7TA2b
         r/H5mo6XzHs8hLwLkcip4D+rWYDagdpXmhkPHnghhwG6teEXACtUsR8EVjuQj8F5kfVf
         WbgzzGMDzm+GE6IMJmrMBLYKCwUqnJhstGytlbbY8ThQqEptZh52QjksskB9Wr4M3Zod
         quqA==
X-Gm-Message-State: AOJu0YzhdY7gtl6r6AeFoKzm8SelosWKvY7S/z/hc+vWstSumSODXZs+
	WmnBL+0Hjl1nksvib1guxaNMEr3NahSOWB6gBkXkOXvJPnqz3J+twUd7QLxz0OBmZOm2ikyiUQc
	UIggzxFnzbSrH4Oa6n8NRpff1gW4AQS94ZU8KQ0uw/7Kr3/60JjVOqebiSzZH0nk1g7feCawUXu
	88hXE3na95H2u2wg+udJ4fp6kLBumCObxk3gYc4qfnNVY/rd+p
X-Google-Smtp-Source: AGHT+IGLGs+mndXJNNjfqgUsYFkifin+WSZeitoYiQtTyuKOmq5pGKfCSSKNwtTBkSKdhKpmnAm5g3ExzWi12bg=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:6902:1146:b0:e02:c619:732 with SMTP
 id 3f1490d57ef6-e0301098e9emr16713276.8.1719274366091; Mon, 24 Jun 2024
 17:12:46 -0700 (PDT)
Date: Tue, 25 Jun 2024 00:12:30 +0000
In-Reply-To: <20240625001232.1476315-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625001232.1476315-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625001232.1476315-5-ziweixiao@google.com>
Subject: [PATCH net-next v3 4/5] gve: Add flow steering adminq commands
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

Add new adminq commands for the driver to configure and query flow rules
that are stored in the device. Flow steering rules are assigned with a
location that determines the relative order of the rules.

Flow rules can run up to an order of millions. In such cases, storing
a full copy of the rules in the driver to prepare for the ethtool query
is infeasible while querying them from the device is better. That needs
to be optimized too so that we don't send a lot of adminq commands. The
solution here is to store a limited number of rules/rule ids in the
driver in a cache. Use dma_pool to allocate 4k bytes which lets device
write at most 46 flow rules(4096/88) or 1024 rule ids(4096/4) at a time.

For configuring flow rules, there are 3 sub-commands:
- ADD which adds a rule at the location supplied
- DEL which deletes the rule at the location supplied
- RESET which clears all currently active rules in the device

For querying flow rules, there are also 3 sub-commands:
- QUERY_RULES corresponds to ETHTOOL_GRXCLSRULE. It fills the rules in
  the allocated cache after querying the device
- QUERY_RULES_IDS corresponds to ETHTOOL_GRXCLSRLALL. It fills the
  rule_ids in the allocated cache after querying the device
- QUERY_RULES_STATS corresponds to ETHTOOL_GRXCLSRLCNT. It queries the
  device's current flow rule number and the supported max flow rule
  limit

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
Changes in v2:
	- Update the commit message to use imperative mood 
	- Remove the variable comments of num_flow_rules and struct
	  gve_query_flow_rules_descriptor since their names are already
	  self-describing
	- Remove the __maybe_unused attribute for
	  gve_adminq_execute_extended_cmd since it's no longer unused
	  from this patch
	- Add a new struct gve_adminq_queried_flow_rule to store the
	  queried rule from the device instead of using gve_flow_rule
	- Remove the unused variable of descriptor_end
	- Remove the check for whether the total length is smaller than
	  the allocated memory length. Instead, add the check for
	  whether the queried results length match with the expected
	  length
	- Update the variable names of the struct
	  gve_adminq_flow_rule_cfg_opcode to be more self-descriptive

 drivers/net/ethernet/google/gve/gve.h         |  43 ++++++
 drivers/net/ethernet/google/gve/gve_adminq.c  | 139 +++++++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |  80 ++++++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
 drivers/net/ethernet/google/gve/gve_main.c    |  51 ++++++-
 5 files changed, 314 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 58213c15e084..b9e9dd958f3c 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -60,6 +60,11 @@
 
 #define GVE_DEFAULT_RX_BUFFER_OFFSET 2048
 
+#define GVE_FLOW_RULES_CACHE_SIZE \
+	(GVE_ADMINQ_BUFFER_SIZE / sizeof(struct gve_adminq_queried_flow_rule))
+#define GVE_FLOW_RULE_IDS_CACHE_SIZE \
+	(GVE_ADMINQ_BUFFER_SIZE / sizeof(((struct gve_adminq_queried_flow_rule *)0)->location))
+
 #define GVE_XDP_ACTIONS 5
 
 #define GVE_GQ_TX_MIN_PKT_DESC_BYTES 182
@@ -678,6 +683,39 @@ enum gve_queue_format {
 	GVE_DQO_QPL_FORMAT		= 0x4,
 };
 
+struct gve_flow_spec {
+	__be32 src_ip[4];
+	__be32 dst_ip[4];
+	union {
+		struct {
+			__be16 src_port;
+			__be16 dst_port;
+		};
+		__be32 spi;
+	};
+	union {
+		u8 tos;
+		u8 tclass;
+	};
+};
+
+struct gve_flow_rule {
+	u32 location;
+	u16 flow_type;
+	u16 action;
+	struct gve_flow_spec key;
+	struct gve_flow_spec mask;
+};
+
+struct gve_flow_rules_cache {
+	bool rules_cache_synced; /* False if the driver's rules_cache is outdated */
+	struct gve_adminq_queried_flow_rule *rules_cache;
+	__be32 *rule_ids_cache;
+	/* The total number of queried rules that stored in the caches */
+	u32 rules_cache_num;
+	u32 rule_ids_cache_num;
+};
+
 struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
@@ -744,6 +782,8 @@ struct gve_priv {
 	u32 adminq_report_link_speed_cnt;
 	u32 adminq_get_ptype_map_cnt;
 	u32 adminq_verify_driver_compatibility_cnt;
+	u32 adminq_query_flow_rules_cnt;
+	u32 adminq_cfg_flow_rule_cnt;
 
 	/* Global stats */
 	u32 interface_up_cnt; /* count of times interface turned up since last reset */
@@ -788,6 +828,9 @@ struct gve_priv {
 	bool header_split_enabled; /* True if the header split is enabled by the user */
 
 	u32 max_flow_rules;
+	u32 num_flow_rules;
+
+	struct gve_flow_rules_cache flow_rules_cache;
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 088f543f0ba8..c5bbc1b7524e 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -287,6 +287,8 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
 	priv->adminq_report_stats_cnt = 0;
 	priv->adminq_report_link_speed_cnt = 0;
 	priv->adminq_get_ptype_map_cnt = 0;
+	priv->adminq_query_flow_rules_cnt = 0;
+	priv->adminq_cfg_flow_rule_cnt = 0;
 
 	/* Setup Admin queue with the device */
 	if (priv->pdev->revision < 0x1) {
@@ -526,6 +528,12 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	case GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY:
 		priv->adminq_verify_driver_compatibility_cnt++;
 		break;
+	case GVE_ADMINQ_QUERY_FLOW_RULES:
+		priv->adminq_query_flow_rules_cnt++;
+		break;
+	case GVE_ADMINQ_CONFIGURE_FLOW_RULE:
+		priv->adminq_cfg_flow_rule_cnt++;
+		break;
 	default:
 		dev_err(&priv->pdev->dev, "unknown AQ command opcode %d\n", opcode);
 	}
@@ -558,8 +566,8 @@ static int gve_adminq_execute_cmd(struct gve_priv *priv,
 	return err;
 }
 
-static int __maybe_unused gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opcode,
-							  size_t cmd_size, void *cmd_orig)
+static int gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opcode,
+					   size_t cmd_size, void *cmd_orig)
 {
 	union gve_adminq_command cmd;
 	dma_addr_t inner_cmd_bus;
@@ -1190,3 +1198,130 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 			  ptype_map_bus);
 	return err;
 }
+
+static int
+gve_adminq_configure_flow_rule(struct gve_priv *priv,
+			       struct gve_adminq_configure_flow_rule *flow_rule_cmd)
+{
+	int err = gve_adminq_execute_extended_cmd(priv,
+			GVE_ADMINQ_CONFIGURE_FLOW_RULE,
+			sizeof(struct gve_adminq_configure_flow_rule),
+			flow_rule_cmd);
+
+	if (err) {
+		dev_err(&priv->pdev->dev, "Timeout to configure the flow rule, trigger reset");
+		gve_reset(priv, true);
+	} else {
+		priv->flow_rules_cache.rules_cache_synced = false;
+	}
+
+	return err;
+}
+
+int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_flow_rule *rule, u32 loc)
+{
+	struct gve_adminq_configure_flow_rule flow_rule_cmd = {
+		.opcode = cpu_to_be16(GVE_FLOW_RULE_CFG_ADD),
+		.location = cpu_to_be32(loc),
+		.rule = *rule,
+	};
+
+	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
+}
+
+int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc)
+{
+	struct gve_adminq_configure_flow_rule flow_rule_cmd = {
+		.opcode = cpu_to_be16(GVE_FLOW_RULE_CFG_DEL),
+		.location = cpu_to_be32(loc),
+	};
+
+	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
+}
+
+int gve_adminq_reset_flow_rules(struct gve_priv *priv)
+{
+	struct gve_adminq_configure_flow_rule flow_rule_cmd = {
+		.opcode = cpu_to_be16(GVE_FLOW_RULE_CFG_RESET),
+	};
+
+	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
+}
+
+/* In the dma memory that the driver allocated for the device to query the flow rules, the device
+ * will first write it with a struct of gve_query_flow_rules_descriptor. Next to it, the device
+ * will write an array of rules or rule ids with the count that specified in the descriptor.
+ * For GVE_FLOW_RULE_QUERY_STATS, the device will only write the descriptor.
+ */
+static int gve_adminq_process_flow_rules_query(struct gve_priv *priv, u16 query_opcode,
+					       struct gve_query_flow_rules_descriptor *descriptor)
+{
+	struct gve_flow_rules_cache *flow_rules_cache = &priv->flow_rules_cache;
+	u32 num_queried_rules, total_memory_len, rule_info_len;
+	void *rule_info;
+
+	total_memory_len = be32_to_cpu(descriptor->total_length);
+	num_queried_rules = be32_to_cpu(descriptor->num_queried_rules);
+	rule_info = (void *)(descriptor + 1);
+
+	switch (query_opcode) {
+	case GVE_FLOW_RULE_QUERY_RULES:
+		rule_info_len = num_queried_rules * sizeof(*flow_rules_cache->rules_cache);
+		if (sizeof(*descriptor) + rule_info_len != total_memory_len) {
+			dev_err(&priv->dev->dev, "flow rules query is out of memory.\n");
+			return -ENOMEM;
+		}
+
+		memcpy(flow_rules_cache->rules_cache, rule_info, rule_info_len);
+		flow_rules_cache->rules_cache_num = num_queried_rules;
+		break;
+	case GVE_FLOW_RULE_QUERY_IDS:
+		rule_info_len = num_queried_rules * sizeof(*flow_rules_cache->rule_ids_cache);
+		if (sizeof(*descriptor) + rule_info_len != total_memory_len) {
+			dev_err(&priv->dev->dev, "flow rule ids query is out of memory.\n");
+			return -ENOMEM;
+		}
+
+		memcpy(flow_rules_cache->rule_ids_cache, rule_info, rule_info_len);
+		flow_rules_cache->rule_ids_cache_num = num_queried_rules;
+		break;
+	case GVE_FLOW_RULE_QUERY_STATS:
+		priv->num_flow_rules = be32_to_cpu(descriptor->num_flow_rules);
+		priv->max_flow_rules = be32_to_cpu(descriptor->max_flow_rules);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	return  0;
+}
+
+int gve_adminq_query_flow_rules(struct gve_priv *priv, u16 query_opcode, u32 starting_loc)
+{
+	struct gve_query_flow_rules_descriptor *descriptor;
+	union gve_adminq_command cmd;
+	dma_addr_t descriptor_bus;
+	int err = 0;
+
+	memset(&cmd, 0, sizeof(cmd));
+	descriptor = dma_pool_alloc(priv->adminq_pool, GFP_KERNEL, &descriptor_bus);
+	if (!descriptor)
+		return -ENOMEM;
+
+	cmd.opcode = cpu_to_be32(GVE_ADMINQ_QUERY_FLOW_RULES);
+	cmd.query_flow_rules = (struct gve_adminq_query_flow_rules) {
+		.opcode = cpu_to_be16(query_opcode),
+		.starting_rule_id = cpu_to_be32(starting_loc),
+		.available_length = cpu_to_be64(GVE_ADMINQ_BUFFER_SIZE),
+		.rule_descriptor_addr = cpu_to_be64(descriptor_bus),
+	};
+	err = gve_adminq_execute_cmd(priv, &cmd);
+	if (err)
+		goto out;
+
+	err = gve_adminq_process_flow_rules_query(priv, query_opcode, descriptor);
+
+out:
+	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
+	return err;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index e64a0e72e781..ed1370c9b197 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -25,11 +25,21 @@ enum gve_adminq_opcodes {
 	GVE_ADMINQ_REPORT_LINK_SPEED		= 0xD,
 	GVE_ADMINQ_GET_PTYPE_MAP		= 0xE,
 	GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY	= 0xF,
+	GVE_ADMINQ_QUERY_FLOW_RULES		= 0x10,
 
 	/* For commands that are larger than 56 bytes */
 	GVE_ADMINQ_EXTENDED_COMMAND		= 0xFF,
 };
 
+/* The normal adminq command is restricted to be 56 bytes at maximum. For the
+ * longer adminq command, it is wrapped by GVE_ADMINQ_EXTENDED_COMMAND with
+ * inner opcode of gve_adminq_extended_cmd_opcodes specified. The inner command
+ * is written in the dma memory allocated by GVE_ADMINQ_EXTENDED_COMMAND.
+ */
+enum gve_adminq_extended_cmd_opcodes {
+	GVE_ADMINQ_CONFIGURE_FLOW_RULE	= 0x101,
+};
+
 /* Admin queue status codes */
 enum gve_adminq_statuses {
 	GVE_ADMINQ_COMMAND_UNSET			= 0x0,
@@ -434,6 +444,71 @@ struct gve_adminq_get_ptype_map {
 	__be64 ptype_map_addr;
 };
 
+/* Flow-steering related definitions */
+enum gve_adminq_flow_rule_cfg_opcode {
+	GVE_FLOW_RULE_CFG_ADD	= 0,
+	GVE_FLOW_RULE_CFG_DEL	= 1,
+	GVE_FLOW_RULE_CFG_RESET	= 2,
+};
+
+enum gve_adminq_flow_rule_query_opcode {
+	GVE_FLOW_RULE_QUERY_RULES	= 0,
+	GVE_FLOW_RULE_QUERY_IDS		= 1,
+	GVE_FLOW_RULE_QUERY_STATS	= 2,
+};
+
+enum gve_adminq_flow_type {
+	GVE_FLOW_TYPE_TCPV4,
+	GVE_FLOW_TYPE_UDPV4,
+	GVE_FLOW_TYPE_SCTPV4,
+	GVE_FLOW_TYPE_AHV4,
+	GVE_FLOW_TYPE_ESPV4,
+	GVE_FLOW_TYPE_TCPV6,
+	GVE_FLOW_TYPE_UDPV6,
+	GVE_FLOW_TYPE_SCTPV6,
+	GVE_FLOW_TYPE_AHV6,
+	GVE_FLOW_TYPE_ESPV6,
+};
+
+/* Flow-steering command */
+struct gve_adminq_flow_rule {
+	__be16 flow_type;
+	__be16 action; /* RX queue id */
+	struct gve_flow_spec key;
+	struct gve_flow_spec mask;
+};
+
+struct gve_adminq_configure_flow_rule {
+	__be16 opcode;
+	u8 padding[2];
+	struct gve_adminq_flow_rule rule;
+	__be32 location;
+};
+
+static_assert(sizeof(struct gve_adminq_configure_flow_rule) == 92);
+
+struct gve_query_flow_rules_descriptor {
+	__be32 num_flow_rules;
+	__be32 max_flow_rules;
+	__be32 num_queried_rules;
+	__be32 total_length;
+};
+
+struct gve_adminq_queried_flow_rule {
+	__be32 location;
+	struct gve_adminq_flow_rule flow_rule;
+};
+
+struct gve_adminq_query_flow_rules {
+	__be16 opcode;
+	u8 padding[2];
+	__be32 starting_rule_id;
+	__be64 available_length; /* The dma memory length that the driver allocated */
+	__be64 rule_descriptor_addr; /* The dma memory address */
+};
+
+static_assert(sizeof(struct gve_adminq_query_flow_rules) == 24);
+
 union gve_adminq_command {
 	struct {
 		__be32 opcode;
@@ -454,6 +529,7 @@ union gve_adminq_command {
 			struct gve_adminq_get_ptype_map get_ptype_map;
 			struct gve_adminq_verify_driver_compatibility
 						verify_driver_compatibility;
+			struct gve_adminq_query_flow_rules query_flow_rules;
 			struct gve_adminq_extended_command extended_command;
 		};
 	};
@@ -488,6 +564,10 @@ int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
 					   u64 driver_info_len,
 					   dma_addr_t driver_info_addr);
 int gve_adminq_report_link_speed(struct gve_priv *priv);
+int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_flow_rule *rule, u32 loc);
+int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
+int gve_adminq_reset_flow_rules(struct gve_priv *priv);
+int gve_adminq_query_flow_rules(struct gve_priv *priv, u16 query_opcode, u32 starting_loc);
 
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index fe1741d482b4..ffaa878d67bc 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -74,7 +74,8 @@ static const char gve_gstrings_adminq_stats[][ETH_GSTRING_LEN] = {
 	"adminq_create_tx_queue_cnt", "adminq_create_rx_queue_cnt",
 	"adminq_destroy_tx_queue_cnt", "adminq_destroy_rx_queue_cnt",
 	"adminq_dcfg_device_resources_cnt", "adminq_set_driver_parameter_cnt",
-	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt", "adminq_get_ptype_map_cnt"
+	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt", "adminq_get_ptype_map_cnt",
+	"adminq_query_flow_rules", "adminq_cfg_flow_rule",
 };
 
 static const char gve_gstrings_priv_flags[][ETH_GSTRING_LEN] = {
@@ -450,6 +451,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = priv->adminq_report_stats_cnt;
 	data[i++] = priv->adminq_report_link_speed_cnt;
 	data[i++] = priv->adminq_get_ptype_map_cnt;
+	data[i++] = priv->adminq_query_flow_rules_cnt;
+	data[i++] = priv->adminq_cfg_flow_rule_cnt;
 }
 
 static void gve_get_channels(struct net_device *netdev,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index cabf7d4bcecb..fc142856e189 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -141,6 +141,49 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 	}
 }
 
+static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
+{
+	struct gve_flow_rules_cache *flow_rules_cache = &priv->flow_rules_cache;
+	int err = 0;
+
+	if (!priv->max_flow_rules)
+		return 0;
+
+	flow_rules_cache->rules_cache =
+		kvcalloc(GVE_FLOW_RULES_CACHE_SIZE, sizeof(*flow_rules_cache->rules_cache),
+			 GFP_KERNEL);
+	if (!flow_rules_cache->rules_cache) {
+		dev_err(&priv->pdev->dev, "Cannot alloc flow rules cache\n");
+		return -ENOMEM;
+	}
+
+	flow_rules_cache->rule_ids_cache =
+		kvcalloc(GVE_FLOW_RULE_IDS_CACHE_SIZE, sizeof(*flow_rules_cache->rule_ids_cache),
+			 GFP_KERNEL);
+	if (!flow_rules_cache->rule_ids_cache) {
+		dev_err(&priv->pdev->dev, "Cannot alloc flow rule ids cache\n");
+		err = -ENOMEM;
+		goto free_rules_cache;
+	}
+
+	return 0;
+
+free_rules_cache:
+	kvfree(flow_rules_cache->rules_cache);
+	flow_rules_cache->rules_cache = NULL;
+	return err;
+}
+
+static void gve_free_flow_rule_caches(struct gve_priv *priv)
+{
+	struct gve_flow_rules_cache *flow_rules_cache = &priv->flow_rules_cache;
+
+	kvfree(flow_rules_cache->rule_ids_cache);
+	flow_rules_cache->rule_ids_cache = NULL;
+	kvfree(flow_rules_cache->rules_cache);
+	flow_rules_cache->rules_cache = NULL;
+}
+
 static int gve_alloc_counter_array(struct gve_priv *priv)
 {
 	priv->counter_array =
@@ -521,9 +564,12 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 {
 	int err;
 
-	err = gve_alloc_counter_array(priv);
+	err = gve_alloc_flow_rule_caches(priv);
 	if (err)
 		return err;
+	err = gve_alloc_counter_array(priv);
+	if (err)
+		goto abort_with_flow_rule_caches;
 	err = gve_alloc_notify_blocks(priv);
 	if (err)
 		goto abort_with_counter;
@@ -575,6 +621,8 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 	gve_free_notify_blocks(priv);
 abort_with_counter:
 	gve_free_counter_array(priv);
+abort_with_flow_rule_caches:
+	gve_free_flow_rule_caches(priv);
 
 	return err;
 }
@@ -606,6 +654,7 @@ static void gve_teardown_device_resources(struct gve_priv *priv)
 	kvfree(priv->ptype_lut_dqo);
 	priv->ptype_lut_dqo = NULL;
 
+	gve_free_flow_rule_caches(priv);
 	gve_free_counter_array(priv);
 	gve_free_notify_blocks(priv);
 	gve_free_stats_report(priv);
-- 
2.45.2.741.gdbec12cfda-goog


