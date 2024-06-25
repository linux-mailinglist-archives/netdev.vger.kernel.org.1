Return-Path: <netdev+bounces-106295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A21B915AE2
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 02:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6CDB21481
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 00:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153C8632;
	Tue, 25 Jun 2024 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J56psy8c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E4200A3
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274372; cv=none; b=rGpvmDAhdOI0tQSEtJJ8Vk1DnYMadbLkqmWIWKSWhKVwkf4STk7PhgH/oiGKW53Eui+agBPrkXWB5eHlrLHQ62W/zDtI4ERiglu225D5qC3nXyVYqUGgqPl3uoegUcoh2e8IbSYTB4QD2c5ktavsgIJTtVDXu1AQ05UPduaJUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274372; c=relaxed/simple;
	bh=9t0h0OxQg9bTeZugwg1D6UGU3M55+U7I3KvRGIVeSSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CyUoKzIT2VdHoLGwbX2R5CpUP7mNj9MszEuuGMlvRrn0ZOwNRC+Kev5woP8TnocZoc0kjcHlGzXhqBNo9gs31rqXn5Q5y7991c+UJXq3IwzW8d4MR9x7L/HUiVpGF6os+B45oAcfAHC8ROqGGZQt13yZFIE01bgdqJJZs635GA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J56psy8c; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f3c5f5bf7so94416447b3.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 17:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719274369; x=1719879169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wC7nbRF1HEl+YR6JNnJW8Q8vbxko8/k0ZxGQkZdpATY=;
        b=J56psy8cdq/dOOaAgdj9khDc91QddJgV0+LPVUQj/+dxPmyJ4o/JBWgHSIJvym9SxE
         3Kb4oqixxfZ/sI2+w+02PIkB98X2slivLxiB8t++7niLo5r9HtVKHaRendLqEukOGLRK
         AntgEWRTGp41C8EYaprgHWzM270kxxIKkotGb+7kc9xdJUL4emt9vEIUVZ2GLk4E17pP
         VWtnSPCq4UTdC2tG02e0tJd+0rDV0RTRCS0cnnZieWo7xcOKh60nqhZisvTawAvOP3o8
         lIgOV+bpds8VAmc7qAMwyFOHWKngB1dZZLBjiWAjA6zESa8BcqAm85ilj9ov8INYBZPd
         sboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274369; x=1719879169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wC7nbRF1HEl+YR6JNnJW8Q8vbxko8/k0ZxGQkZdpATY=;
        b=sPWlWU7l3UiqIQ2yxqBJKn5iOkfr3D+Zqoz5L8Edb2BCuPw1Gz1Uv/MeGt59EiJL5U
         aMQzSSj1Ks5D+zqhDpKsAcwxnIfZ9LJ6DjuesczuyaJw6l035mgnaECCGzezmqF1TEjr
         A5VPb574qjYHdgEsGpfcfJdqtii8J3fCk9zuv6zqLKRVkkiosmw07MU8ZJKmUyXWR40a
         /vGdgcM1AZKIOKDR91MH5db7TOdXkAzXHP90R1LLZMr1E/eSURvOEdPvffvSY8nx5xqR
         tF4U1rMcStTCW/ZTjgu04d+VuajtuEP/gbHH6d1hrnquyb0KjHIOd5fCxSZZWPWYFSoT
         O0Iw==
X-Gm-Message-State: AOJu0YxUIR4up96owDwD6XyIJKPFJ10xBP91nYiJuZyJKzTcTuitG0cy
	GSwqRjNi71rKY63sDwBzL9cI+MYSIOYx+vfCKF4mLyOkGJi8Y61oT2zp1j/WzeuDltCjG6wSDZC
	MSkSuoGVbBmkd3GiC6uHHdSFDx0Zb58jfk5KDokhyRL5GecCRB1OVGrw0BwtYwX64JmNwuGjpns
	yU5rzo8i9WW33D18GspNDkrqXNn/n1Ov9kFsiJaZdYntcOZIe4
X-Google-Smtp-Source: AGHT+IGGQYFCPYeeNyTaHLIldauXC+I98zwCyKDIAzlLJnlrKbR+jBaSzCruMDHzoEs6DiwBNoaq4UbOIDNF9e8=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:690c:f0b:b0:62c:f623:3a4e with SMTP
 id 00721157ae682-642933ce65bmr267177b3.0.1719274368611; Mon, 24 Jun 2024
 17:12:48 -0700 (PDT)
Date: Tue, 25 Jun 2024 00:12:31 +0000
In-Reply-To: <20240625001232.1476315-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625001232.1476315-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625001232.1476315-6-ziweixiao@google.com>
Subject: [PATCH net-next v3 5/5] gve: Add flow steering ethtool support
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

Implement the ethtool commands that can be used to configure and query
flow-steering rules.

A large part of this change consists of translating the ethtool
representation of 'ntuples' to our internal gve_flow_rule and vice-versa
in the new created gve_flow_rule.c

Considering the possible large amount of flow rules, the driver doesn't
store all the rules locally. When the user runs 'ethtool -n <nic>' to
check the registered rules, the driver will send adminq command to
query a limited amount of rules/rule ids(that filled in a 4096 bytes dma
memory) at a time as a cache for the ethtool queries. The adminq query
commands will be repeated for several times until the ethtool has
queried all the needed rules.

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
Changes in v3:
	- Remove the codes which drop the rtnl lock for flow steering
	  ethtool commands, and also remove the related commit message.

	  Because the dropping rtnl lock part is used for improve the
	  efficiency of adding rules for multiple nics at the same time,
	  keeping the rtnl lock itself doesn't impact the functionality of
	  flow steering feature. Also, since there is ongoing work for
	  reducing the dependency of the rtnl lock for the dev_ethtool
	  (https://lore.kernel.org/netdev/20240620114711.777046-1-edumazet@google.com/),
	  it can add an ethtool ops to declare the intention of dropping the
	  rtnl lock for flow steering ethtool operations once that change is
	  ready in the future.

Changes in v2:
	- Fix the sparse warning of be16_to_cpu by switching to use the
	  new added structure gve_adminq_queried_flow_rule from the
	  previous patch to do the be16_to_cpu operations
	- Use kvfree instead of kfree for the rule allocated by kvzalloc
	- Delete the check that disallows rx queue count changing when
	  there are rules alive because it already has a check in
	  net/ethtool/channels.c that ensures rx queue count change to
	  be failed if requested channel counts are too low for existing
	  ntuple filter settings

 drivers/net/ethernet/google/gve/Makefile      |   2 +-
 drivers/net/ethernet/google/gve/gve.h         |   8 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |  67 +++-
 .../net/ethernet/google/gve/gve_flow_rule.c   | 298 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_main.c    |  32 +-
 5 files changed, 398 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_flow_rule.c

diff --git a/drivers/net/ethernet/google/gve/Makefile b/drivers/net/ethernet/google/gve/Makefile
index b9a6be76531b..9ed07080b38a 100644
--- a/drivers/net/ethernet/google/gve/Makefile
+++ b/drivers/net/ethernet/google/gve/Makefile
@@ -1,4 +1,4 @@
 # Makefile for the Google virtual Ethernet (gve) driver
 
 obj-$(CONFIG_GVE) += gve.o
-gve-objs := gve_main.o gve_tx.o gve_tx_dqo.o gve_rx.o gve_rx_dqo.o gve_ethtool.o gve_adminq.o gve_utils.o
+gve-objs := gve_main.o gve_tx.o gve_tx_dqo.o gve_rx.o gve_rx_dqo.o gve_ethtool.o gve_adminq.o gve_utils.o gve_flow_rule.o
diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index b9e9dd958f3c..84ac004d3953 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MIT)
  * Google virtual Ethernet (gve) driver
  *
- * Copyright (C) 2015-2021 Google, Inc.
+ * Copyright (C) 2015-2024 Google LLC
  */
 
 #ifndef _GVE_H_
@@ -1170,6 +1170,12 @@ int gve_adjust_config(struct gve_priv *priv,
 int gve_adjust_queues(struct gve_priv *priv,
 		      struct gve_queue_config new_rx_config,
 		      struct gve_queue_config new_tx_config);
+/* flow steering rule */
+int gve_get_flow_rule_entry(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
+int gve_get_flow_rule_ids(struct gve_priv *priv, struct ethtool_rxnfc *cmd, u32 *rule_locs);
+int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
+int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd);
+int gve_flow_rules_reset(struct gve_priv *priv);
 /* report stats handling */
 void gve_handle_report_stats(struct gve_priv *priv);
 /* exported by ethtool.c */
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index ffaa878d67bc..3480ff5c7ed6 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /* Google virtual Ethernet (gve) driver
  *
- * Copyright (C) 2015-2021 Google, Inc.
+ * Copyright (C) 2015-2024 Google LLC
  */
 
 #include <linux/rtnetlink.h>
@@ -775,6 +775,69 @@ static int gve_set_coalesce(struct net_device *netdev,
 	return 0;
 }
 
+static int gve_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+	int err = 0;
+
+	if (!(netdev->features & NETIF_F_NTUPLE))
+		return -EOPNOTSUPP;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		err = gve_add_flow_rule(priv, cmd);
+		break;
+	case ETHTOOL_SRXCLSRLDEL:
+		err = gve_del_flow_rule(priv, cmd);
+		break;
+	case ETHTOOL_SRXFH:
+		err = -EOPNOTSUPP;
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd, u32 *rule_locs)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+	int err = 0;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_GRXRINGS:
+		cmd->data = priv->rx_cfg.num_queues;
+		break;
+	case ETHTOOL_GRXCLSRLCNT:
+		if (!priv->max_flow_rules)
+			return -EOPNOTSUPP;
+
+		err = gve_adminq_query_flow_rules(priv, GVE_FLOW_RULE_QUERY_STATS, 0);
+		if (err)
+			return err;
+
+		cmd->rule_cnt = priv->num_flow_rules;
+		cmd->data = priv->max_flow_rules;
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		err = gve_get_flow_rule_entry(priv, cmd);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		err = gve_get_flow_rule_ids(priv, cmd, (u32 *)rule_locs);
+		break;
+	case ETHTOOL_GRXFH:
+		err = -EOPNOTSUPP;
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
@@ -786,6 +849,8 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.get_msglevel = gve_get_msglevel,
 	.set_channels = gve_set_channels,
 	.get_channels = gve_get_channels,
+	.set_rxnfc = gve_set_rxnfc,
+	.get_rxnfc = gve_get_rxnfc,
 	.get_link = ethtool_op_get_link,
 	.get_coalesce = gve_get_coalesce,
 	.set_coalesce = gve_set_coalesce,
diff --git a/drivers/net/ethernet/google/gve/gve_flow_rule.c b/drivers/net/ethernet/google/gve/gve_flow_rule.c
new file mode 100644
index 000000000000..0bb8cd1876a3
--- /dev/null
+++ b/drivers/net/ethernet/google/gve/gve_flow_rule.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Google virtual Ethernet (gve) driver
+ *
+ * Copyright (C) 2015-2024 Google LLC
+ */
+
+#include "gve.h"
+#include "gve_adminq.h"
+
+static
+int gve_fill_ethtool_flow_spec(struct ethtool_rx_flow_spec *fsp,
+			       struct gve_adminq_queried_flow_rule *rule)
+{
+	struct gve_adminq_flow_rule *flow_rule = &rule->flow_rule;
+	static const u16 flow_type_lut[] = {
+		[GVE_FLOW_TYPE_TCPV4]	= TCP_V4_FLOW,
+		[GVE_FLOW_TYPE_UDPV4]	= UDP_V4_FLOW,
+		[GVE_FLOW_TYPE_SCTPV4]	= SCTP_V4_FLOW,
+		[GVE_FLOW_TYPE_AHV4]	= AH_V4_FLOW,
+		[GVE_FLOW_TYPE_ESPV4]	= ESP_V4_FLOW,
+		[GVE_FLOW_TYPE_TCPV6]	= TCP_V6_FLOW,
+		[GVE_FLOW_TYPE_UDPV6]	= UDP_V6_FLOW,
+		[GVE_FLOW_TYPE_SCTPV6]	= SCTP_V6_FLOW,
+		[GVE_FLOW_TYPE_AHV6]	= AH_V6_FLOW,
+		[GVE_FLOW_TYPE_ESPV6]	= ESP_V6_FLOW,
+	};
+
+	if (be16_to_cpu(flow_rule->flow_type) >= ARRAY_SIZE(flow_type_lut))
+		return -EINVAL;
+
+	fsp->flow_type = flow_type_lut[be16_to_cpu(flow_rule->flow_type)];
+
+	memset(&fsp->h_u, 0, sizeof(fsp->h_u));
+	memset(&fsp->h_ext, 0, sizeof(fsp->h_ext));
+	memset(&fsp->m_u, 0, sizeof(fsp->m_u));
+	memset(&fsp->m_ext, 0, sizeof(fsp->m_ext));
+
+	switch (fsp->flow_type) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+		fsp->h_u.tcp_ip4_spec.ip4src = flow_rule->key.src_ip[0];
+		fsp->h_u.tcp_ip4_spec.ip4dst = flow_rule->key.dst_ip[0];
+		fsp->h_u.tcp_ip4_spec.psrc = flow_rule->key.src_port;
+		fsp->h_u.tcp_ip4_spec.pdst = flow_rule->key.dst_port;
+		fsp->h_u.tcp_ip4_spec.tos = flow_rule->key.tos;
+		fsp->m_u.tcp_ip4_spec.ip4src = flow_rule->mask.src_ip[0];
+		fsp->m_u.tcp_ip4_spec.ip4dst = flow_rule->mask.dst_ip[0];
+		fsp->m_u.tcp_ip4_spec.psrc = flow_rule->mask.src_port;
+		fsp->m_u.tcp_ip4_spec.pdst = flow_rule->mask.dst_port;
+		fsp->m_u.tcp_ip4_spec.tos = flow_rule->mask.tos;
+		break;
+	case AH_V4_FLOW:
+	case ESP_V4_FLOW:
+		fsp->h_u.ah_ip4_spec.ip4src = flow_rule->key.src_ip[0];
+		fsp->h_u.ah_ip4_spec.ip4dst = flow_rule->key.dst_ip[0];
+		fsp->h_u.ah_ip4_spec.spi = flow_rule->key.spi;
+		fsp->h_u.ah_ip4_spec.tos = flow_rule->key.tos;
+		fsp->m_u.ah_ip4_spec.ip4src = flow_rule->mask.src_ip[0];
+		fsp->m_u.ah_ip4_spec.ip4dst = flow_rule->mask.dst_ip[0];
+		fsp->m_u.ah_ip4_spec.spi = flow_rule->mask.spi;
+		fsp->m_u.ah_ip4_spec.tos = flow_rule->mask.tos;
+		break;
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+		memcpy(fsp->h_u.tcp_ip6_spec.ip6src, &flow_rule->key.src_ip,
+		       sizeof(struct in6_addr));
+		memcpy(fsp->h_u.tcp_ip6_spec.ip6dst, &flow_rule->key.dst_ip,
+		       sizeof(struct in6_addr));
+		fsp->h_u.tcp_ip6_spec.psrc = flow_rule->key.src_port;
+		fsp->h_u.tcp_ip6_spec.pdst = flow_rule->key.dst_port;
+		fsp->h_u.tcp_ip6_spec.tclass = flow_rule->key.tclass;
+		memcpy(fsp->m_u.tcp_ip6_spec.ip6src, &flow_rule->mask.src_ip,
+		       sizeof(struct in6_addr));
+		memcpy(fsp->m_u.tcp_ip6_spec.ip6dst, &flow_rule->mask.dst_ip,
+		       sizeof(struct in6_addr));
+		fsp->m_u.tcp_ip6_spec.psrc = flow_rule->mask.src_port;
+		fsp->m_u.tcp_ip6_spec.pdst = flow_rule->mask.dst_port;
+		fsp->m_u.tcp_ip6_spec.tclass = flow_rule->mask.tclass;
+		break;
+	case AH_V6_FLOW:
+	case ESP_V6_FLOW:
+		memcpy(fsp->h_u.ah_ip6_spec.ip6src, &flow_rule->key.src_ip,
+		       sizeof(struct in6_addr));
+		memcpy(fsp->h_u.ah_ip6_spec.ip6dst, &flow_rule->key.dst_ip,
+		       sizeof(struct in6_addr));
+		fsp->h_u.ah_ip6_spec.spi = flow_rule->key.spi;
+		fsp->h_u.ah_ip6_spec.tclass = flow_rule->key.tclass;
+		memcpy(fsp->m_u.ah_ip6_spec.ip6src, &flow_rule->mask.src_ip,
+		       sizeof(struct in6_addr));
+		memcpy(fsp->m_u.ah_ip6_spec.ip6dst, &flow_rule->mask.dst_ip,
+		       sizeof(struct in6_addr));
+		fsp->m_u.ah_ip6_spec.spi = flow_rule->mask.spi;
+		fsp->m_u.ah_ip6_spec.tclass = flow_rule->mask.tclass;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	fsp->ring_cookie = be16_to_cpu(flow_rule->action);
+
+	return 0;
+}
+
+static int gve_generate_flow_rule(struct gve_priv *priv, struct ethtool_rx_flow_spec *fsp,
+				  struct gve_adminq_flow_rule *rule)
+{
+	static const u16 flow_type_lut[] = {
+		[TCP_V4_FLOW]	= GVE_FLOW_TYPE_TCPV4,
+		[UDP_V4_FLOW]	= GVE_FLOW_TYPE_UDPV4,
+		[SCTP_V4_FLOW]	= GVE_FLOW_TYPE_SCTPV4,
+		[AH_V4_FLOW]	= GVE_FLOW_TYPE_AHV4,
+		[ESP_V4_FLOW]	= GVE_FLOW_TYPE_ESPV4,
+		[TCP_V6_FLOW]	= GVE_FLOW_TYPE_TCPV6,
+		[UDP_V6_FLOW]	= GVE_FLOW_TYPE_UDPV6,
+		[SCTP_V6_FLOW]	= GVE_FLOW_TYPE_SCTPV6,
+		[AH_V6_FLOW]	= GVE_FLOW_TYPE_AHV6,
+		[ESP_V6_FLOW]	= GVE_FLOW_TYPE_ESPV6,
+	};
+	u32 flow_type;
+
+	if (fsp->ring_cookie == RX_CLS_FLOW_DISC)
+		return -EOPNOTSUPP;
+
+	if (fsp->ring_cookie >= priv->rx_cfg.num_queues)
+		return -EINVAL;
+
+	rule->action = cpu_to_be16(fsp->ring_cookie);
+
+	flow_type = fsp->flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
+	if (!flow_type || flow_type >= ARRAY_SIZE(flow_type_lut))
+		return -EINVAL;
+
+	rule->flow_type = cpu_to_be16(flow_type_lut[flow_type]);
+
+	switch (flow_type) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+		rule->key.src_ip[0] = fsp->h_u.tcp_ip4_spec.ip4src;
+		rule->key.dst_ip[0] = fsp->h_u.tcp_ip4_spec.ip4dst;
+		rule->key.src_port = fsp->h_u.tcp_ip4_spec.psrc;
+		rule->key.dst_port = fsp->h_u.tcp_ip4_spec.pdst;
+		rule->mask.src_ip[0] = fsp->m_u.tcp_ip4_spec.ip4src;
+		rule->mask.dst_ip[0] = fsp->m_u.tcp_ip4_spec.ip4dst;
+		rule->mask.src_port = fsp->m_u.tcp_ip4_spec.psrc;
+		rule->mask.dst_port = fsp->m_u.tcp_ip4_spec.pdst;
+		break;
+	case AH_V4_FLOW:
+	case ESP_V4_FLOW:
+		rule->key.src_ip[0] = fsp->h_u.tcp_ip4_spec.ip4src;
+		rule->key.dst_ip[0] = fsp->h_u.tcp_ip4_spec.ip4dst;
+		rule->key.spi = fsp->h_u.ah_ip4_spec.spi;
+		rule->mask.src_ip[0] = fsp->m_u.tcp_ip4_spec.ip4src;
+		rule->mask.dst_ip[0] = fsp->m_u.tcp_ip4_spec.ip4dst;
+		rule->mask.spi = fsp->m_u.ah_ip4_spec.spi;
+		break;
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+		memcpy(&rule->key.src_ip, fsp->h_u.tcp_ip6_spec.ip6src,
+		       sizeof(struct in6_addr));
+		memcpy(&rule->key.dst_ip, fsp->h_u.tcp_ip6_spec.ip6dst,
+		       sizeof(struct in6_addr));
+		rule->key.src_port = fsp->h_u.tcp_ip6_spec.psrc;
+		rule->key.dst_port = fsp->h_u.tcp_ip6_spec.pdst;
+		memcpy(&rule->mask.src_ip, fsp->m_u.tcp_ip6_spec.ip6src,
+		       sizeof(struct in6_addr));
+		memcpy(&rule->mask.dst_ip, fsp->m_u.tcp_ip6_spec.ip6dst,
+		       sizeof(struct in6_addr));
+		rule->mask.src_port = fsp->m_u.tcp_ip6_spec.psrc;
+		rule->mask.dst_port = fsp->m_u.tcp_ip6_spec.pdst;
+		break;
+	case AH_V6_FLOW:
+	case ESP_V6_FLOW:
+		memcpy(&rule->key.src_ip, fsp->h_u.usr_ip6_spec.ip6src,
+		       sizeof(struct in6_addr));
+		memcpy(&rule->key.dst_ip, fsp->h_u.usr_ip6_spec.ip6dst,
+		       sizeof(struct in6_addr));
+		rule->key.spi = fsp->h_u.ah_ip6_spec.spi;
+		memcpy(&rule->mask.src_ip, fsp->m_u.usr_ip6_spec.ip6src,
+		       sizeof(struct in6_addr));
+		memcpy(&rule->mask.dst_ip, fsp->m_u.usr_ip6_spec.ip6dst,
+		       sizeof(struct in6_addr));
+		rule->key.spi = fsp->h_u.ah_ip6_spec.spi;
+		break;
+	default:
+		/* not doing un-parsed flow types */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int gve_get_flow_rule_entry(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
+{
+	struct gve_adminq_queried_flow_rule *rules_cache = priv->flow_rules_cache.rules_cache;
+	struct ethtool_rx_flow_spec *fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
+	u32 *cache_num = &priv->flow_rules_cache.rules_cache_num;
+	struct gve_adminq_queried_flow_rule *rule = NULL;
+	int err = 0;
+	u32 i;
+
+	if (!priv->max_flow_rules)
+		return -EOPNOTSUPP;
+
+	if (!priv->flow_rules_cache.rules_cache_synced ||
+	    fsp->location < be32_to_cpu(rules_cache[0].location) ||
+	    fsp->location > be32_to_cpu(rules_cache[*cache_num - 1].location)) {
+		err = gve_adminq_query_flow_rules(priv, GVE_FLOW_RULE_QUERY_RULES, fsp->location);
+		if (err)
+			return err;
+
+		priv->flow_rules_cache.rules_cache_synced = true;
+	}
+
+	for (i = 0; i < *cache_num; i++) {
+		if (fsp->location == be32_to_cpu(rules_cache[i].location)) {
+			rule = &rules_cache[i];
+			break;
+		}
+	}
+
+	if (!rule)
+		return -EINVAL;
+
+	err = gve_fill_ethtool_flow_spec(fsp, rule);
+
+	return err;
+}
+
+int gve_get_flow_rule_ids(struct gve_priv *priv, struct ethtool_rxnfc *cmd, u32 *rule_locs)
+{
+	__be32 *rule_ids_cache = priv->flow_rules_cache.rule_ids_cache;
+	u32 *cache_num = &priv->flow_rules_cache.rule_ids_cache_num;
+	u32 starting_rule_id = 0;
+	u32 i = 0, j = 0;
+	int err = 0;
+
+	if (!priv->max_flow_rules)
+		return -EOPNOTSUPP;
+
+	do {
+		err = gve_adminq_query_flow_rules(priv, GVE_FLOW_RULE_QUERY_IDS,
+						  starting_rule_id);
+		if (err)
+			return err;
+
+		for (i = 0; i < *cache_num; i++) {
+			if (j >= cmd->rule_cnt)
+				return -EMSGSIZE;
+
+			rule_locs[j++] = be32_to_cpu(rule_ids_cache[i]);
+			starting_rule_id = be32_to_cpu(rule_ids_cache[i]) + 1;
+		}
+	} while (*cache_num != 0);
+	cmd->data = priv->max_flow_rules;
+
+	return err;
+}
+
+int gve_add_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fsp = &cmd->fs;
+	struct gve_adminq_flow_rule *rule = NULL;
+	int err;
+
+	if (!priv->max_flow_rules)
+		return -EOPNOTSUPP;
+
+	rule = kvzalloc(sizeof(*rule), GFP_KERNEL);
+	if (!rule)
+		return -ENOMEM;
+
+	err = gve_generate_flow_rule(priv, fsp, rule);
+	if (err)
+		goto out;
+
+	err = gve_adminq_add_flow_rule(priv, rule, fsp->location);
+
+out:
+	kvfree(rule);
+	if (err)
+		dev_err(&priv->pdev->dev, "Failed to add the flow rule: %u", fsp->location);
+
+	return err;
+}
+
+int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
+{
+	struct ethtool_rx_flow_spec *fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
+
+	if (!priv->max_flow_rules)
+		return -EOPNOTSUPP;
+
+	return gve_adminq_del_flow_rule(priv, fsp->location);
+}
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index fc142856e189..9744b426940e 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /* Google virtual Ethernet (gve) driver
  *
- * Copyright (C) 2015-2021 Google, Inc.
+ * Copyright (C) 2015-2024 Google LLC
  */
 
 #include <linux/bpf.h>
@@ -635,6 +635,12 @@ static void gve_teardown_device_resources(struct gve_priv *priv)
 
 	/* Tell device its resources are being freed */
 	if (gve_get_device_resources_ok(priv)) {
+		err = gve_flow_rules_reset(priv);
+		if (err) {
+			dev_err(&priv->pdev->dev,
+				"Failed to reset flow rules: err=%d\n", err);
+			gve_trigger_reset(priv);
+		}
 		/* detach the stats report */
 		err = gve_adminq_report_stats(priv, 0, 0x0, GVE_STATS_REPORT_TIMER_PERIOD);
 		if (err) {
@@ -1779,6 +1785,14 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+int gve_flow_rules_reset(struct gve_priv *priv)
+{
+	if (!priv->max_flow_rules)
+		return 0;
+
+	return gve_adminq_reset_flow_rules(priv);
+}
+
 int gve_adjust_config(struct gve_priv *priv,
 		      struct gve_tx_alloc_rings_cfg *tx_alloc_cfg,
 		      struct gve_rx_alloc_rings_cfg *rx_alloc_cfg)
@@ -2052,15 +2066,21 @@ static int gve_set_features(struct net_device *netdev,
 		netdev->features ^= NETIF_F_LRO;
 		if (netif_carrier_ok(netdev)) {
 			err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
-			if (err) {
-				/* Revert the change on error. */
-				netdev->features = orig_features;
-				return err;
-			}
+			if (err)
+				goto revert_features;
 		}
 	}
+	if ((netdev->features & NETIF_F_NTUPLE) && !(features & NETIF_F_NTUPLE)) {
+		err = gve_flow_rules_reset(priv);
+		if (err)
+			goto revert_features;
+	}
 
 	return 0;
+
+revert_features:
+	netdev->features = orig_features;
+	return err;
 }
 
 static const struct net_device_ops gve_netdev_ops = {
-- 
2.45.2.741.gdbec12cfda-goog


