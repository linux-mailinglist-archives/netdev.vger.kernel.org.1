Return-Path: <netdev+bounces-94306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4278BF0EF
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 01:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F675B23DDB
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 23:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A1613A265;
	Tue,  7 May 2024 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yR5iEoHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE5139CFF
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122848; cv=none; b=IuBHxNKfR/w1uNq7wjz24HCsxhJBRhkj9DYzmYd/o+mPgYXdgMwj5RQmzA1RBSBr4bNJPo6WyiGMCuPQNG79spMF4FCGP5L7CVuRYfFXLF0xT6oNuJr0i90WTftCfDjz8euhgPMayTG6eph+pS/2be9XZ8+VziXUeI+2bOGWsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122848; c=relaxed/simple;
	bh=VJuGsdKOFSnR7yBmRXM9ZcoqmipHayyWCd2FXVdFIWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U0eXbTD8orhMPMBW8fi8MXeiolZmfvv/A98kCGqeKpgTwaSliPtYwmCuKPSRHPpVpH1d7lGUIdx3k8EwiBLrHCPwhNpJ+RnWSY62dqQdS1S4m9VSArxivnvdOTSaau2pcD9ORvjszNOlz4aFOXD5pbtREJEhQqKKtzKIljbevcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yR5iEoHd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be23bb01aso85013077b3.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 16:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715122844; x=1715727644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdBwK00+cUoOYOBMlsXTnW4ybuvzE5bAMQxEnP1MIVo=;
        b=yR5iEoHd2UVJUTTpBnN82kt3GYrfQrewZqc7oUh38/xi8wXDledVSLzvUV9umg8JL5
         m4Zc6NyMkWEbqPqR4GmFTYzauL1Klu7uAkr1c19DUGoPHR5WHzEOHQqGEtxZd0pZD5RM
         2jexlbceyPyoKMGTOxapKSq5/wv01avCg+acu8AYOdx8dhOnU0MtNkF+4QG75rO1IoON
         tuHo8LqCglWKwVhzFKTB9LeRhEYWboWFxvlGLMoUSqObwfJw+haD6fHlXOhe2TsRLVt+
         65n6n74Zo2XcmJZJp/QEENrfCENxerdzqe0arlHSn3UyQyoZw70hMynn/IUeXxTUmXE2
         G1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715122844; x=1715727644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdBwK00+cUoOYOBMlsXTnW4ybuvzE5bAMQxEnP1MIVo=;
        b=e1s/qbLEA+fjed8o1vEZrQwpD5rWgxDZJyho4m15snpYayAEVZquxEdkRH8Fi3Ordm
         wnpvIpio/V0tJ86UHYXN5phjwL7fNe1VduOG1GsVJJtEJ5uEd9UhU+JzNEuqMRuPaUDB
         puDWQ1YkEFESFPB9euiE7p4OeXnijR7SVwd6gOuBQo7wJCgbShRIKOh9CFBg5NXYxbsc
         53hNnbWCUIP+8BjQEBvI4+9TPrJAZ1jM0DbuLpwZnFl5AwLnynTxBRBetKGv6UTTvpnT
         Pv1Cs1cp85OXfu4y+vLDQCPdVOL17TaJU2MSXf6HGA/Al5HeVR84Hnj78ecQ2aTsabu5
         KDgg==
X-Gm-Message-State: AOJu0YyF7gJ8R89j3/YVxogtjqYcWZ0KDZgx32blGzDMwGtsTxU33h4k
	clyZWvomVmZI/zRft72uNYDerawT9ua+xcvCe5WpztExyHiSENovafc96/Cahp4LGekaHs7h1KQ
	lBIEc+XvoHXGb9aVAyr12myfnqxlyvnRvBjC6pBaqDxhqBIwilcz/jp6jarHy7BWhOeQ/vhBd+d
	63IT3aPGwjgWc1VcokYo2EKNNzZi/g67/uEUboNFw0pm5J46Id
X-Google-Smtp-Source: AGHT+IEkRaFSj8NdmdvkaiQD562Zu5UVcyLLv01EspnNh3ZQpNGrqyyKuTxF7U0rANgCfYQ7UNMXE/YgdyfWeVA=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:6902:18c1:b0:de4:77ab:5fea with SMTP
 id 3f1490d57ef6-debb9d6d8d6mr320623276.2.1715122843703; Tue, 07 May 2024
 16:00:43 -0700 (PDT)
Date: Tue,  7 May 2024 22:59:45 +0000
In-Reply-To: <20240507225945.1408516-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507225945.1408516-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507225945.1408516-6-ziweixiao@google.com>
Subject: [PATCH net-next 5/5] gve: Add flow steering ethtool support
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, rushilg@google.com, 
	ziweixiao@google.com, jfraker@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

Implement the ethtool commands that can be used to configure and query
flow-steering rules. For these ethtool commands, the driver will
temporarily drop the rtnl lock to reduce the latency for the flow
steering commands on separate NICs. It will then be protected by the new
added adminq lock.

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
 drivers/net/ethernet/google/gve/Makefile      |   2 +-
 drivers/net/ethernet/google/gve/gve.h         |   8 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |  86 ++++-
 .../net/ethernet/google/gve/gve_flow_rule.c   | 296 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_main.c    |  32 +-
 5 files changed, 415 insertions(+), 9 deletions(-)
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
index 355ae797eacf..8565f1df9c50 100644
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
@@ -1169,6 +1169,12 @@ int gve_adjust_config(struct gve_priv *priv,
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
index 02cee7e0e229..27166bde5fa0 100644
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
@@ -503,6 +503,12 @@ static int gve_set_channels(struct net_device *netdev,
 		return -EINVAL;
 	}
 
+	if (old_settings.rx_count != new_rx && priv->num_flow_rules) {
+		dev_err(&priv->pdev->dev,
+			"Changing number of RX queues is disabled when flow rules are active");
+		return -EBUSY;
+	}
+
 	if (!netif_carrier_ok(netdev)) {
 		priv->tx_cfg.num_queues = new_tx;
 		priv->rx_cfg.num_queues = new_rx;
@@ -783,6 +789,82 @@ static int gve_set_coalesce(struct net_device *netdev,
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
+	dev_hold(netdev);
+	rtnl_unlock();
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
+	rtnl_lock();
+	dev_put(netdev);
+	return err;
+}
+
+static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd, u32 *rule_locs)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+	int err = 0;
+
+	dev_hold(netdev);
+	rtnl_unlock();
+
+	switch (cmd->cmd) {
+	case ETHTOOL_GRXRINGS:
+		cmd->data = priv->rx_cfg.num_queues;
+		break;
+	case ETHTOOL_GRXCLSRLCNT:
+		if (!priv->max_flow_rules) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+
+		err = gve_adminq_query_flow_rules(priv, GVE_FLOW_RULE_QUERY_STATS, 0);
+		if (err)
+			goto out;
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
+out:
+	rtnl_lock();
+	dev_put(netdev);
+	return err;
+}
+
 const struct ethtool_ops gve_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
@@ -794,6 +876,8 @@ const struct ethtool_ops gve_ethtool_ops = {
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
index 000000000000..1cafd520f2db
--- /dev/null
+++ b/drivers/net/ethernet/google/gve/gve_flow_rule.c
@@ -0,0 +1,296 @@
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
+int gve_fill_ethtool_flow_spec(struct ethtool_rx_flow_spec *fsp, struct gve_flow_rule *rule)
+{
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
+	if (be16_to_cpu(rule->flow_type) >= ARRAY_SIZE(flow_type_lut))
+		return -EINVAL;
+
+	fsp->flow_type = flow_type_lut[be16_to_cpu(rule->flow_type)];
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
+		fsp->h_u.tcp_ip4_spec.ip4src = rule->key.src_ip[0];
+		fsp->h_u.tcp_ip4_spec.ip4dst = rule->key.dst_ip[0];
+		fsp->h_u.tcp_ip4_spec.psrc = rule->key.src_port;
+		fsp->h_u.tcp_ip4_spec.pdst = rule->key.dst_port;
+		fsp->h_u.tcp_ip4_spec.tos = rule->key.tos;
+		fsp->m_u.tcp_ip4_spec.ip4src = rule->mask.src_ip[0];
+		fsp->m_u.tcp_ip4_spec.ip4dst = rule->mask.dst_ip[0];
+		fsp->m_u.tcp_ip4_spec.psrc = rule->mask.src_port;
+		fsp->m_u.tcp_ip4_spec.pdst = rule->mask.dst_port;
+		fsp->m_u.tcp_ip4_spec.tos = rule->mask.tos;
+		break;
+	case AH_V4_FLOW:
+	case ESP_V4_FLOW:
+		fsp->h_u.ah_ip4_spec.ip4src = rule->key.src_ip[0];
+		fsp->h_u.ah_ip4_spec.ip4dst = rule->key.dst_ip[0];
+		fsp->h_u.ah_ip4_spec.spi = rule->key.spi;
+		fsp->h_u.ah_ip4_spec.tos = rule->key.tos;
+		fsp->m_u.ah_ip4_spec.ip4src = rule->mask.src_ip[0];
+		fsp->m_u.ah_ip4_spec.ip4dst = rule->mask.dst_ip[0];
+		fsp->m_u.ah_ip4_spec.spi = rule->mask.spi;
+		fsp->m_u.ah_ip4_spec.tos = rule->mask.tos;
+		break;
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+		memcpy(fsp->h_u.tcp_ip6_spec.ip6src, &rule->key.src_ip,
+		       sizeof(struct in6_addr));
+		memcpy(fsp->h_u.tcp_ip6_spec.ip6dst, &rule->key.dst_ip,
+		       sizeof(struct in6_addr));
+		fsp->h_u.tcp_ip6_spec.psrc = rule->key.src_port;
+		fsp->h_u.tcp_ip6_spec.pdst = rule->key.dst_port;
+		fsp->h_u.tcp_ip6_spec.tclass = rule->key.tclass;
+		memcpy(fsp->m_u.tcp_ip6_spec.ip6src, &rule->mask.src_ip,
+		       sizeof(struct in6_addr));
+		memcpy(fsp->m_u.tcp_ip6_spec.ip6dst, &rule->mask.dst_ip,
+		       sizeof(struct in6_addr));
+		fsp->m_u.tcp_ip6_spec.psrc = rule->mask.src_port;
+		fsp->m_u.tcp_ip6_spec.pdst = rule->mask.dst_port;
+		fsp->m_u.tcp_ip6_spec.tclass = rule->mask.tclass;
+		break;
+	case AH_V6_FLOW:
+	case ESP_V6_FLOW:
+		memcpy(fsp->h_u.ah_ip6_spec.ip6src, &rule->key.src_ip,
+		       sizeof(struct in6_addr));
+		memcpy(fsp->h_u.ah_ip6_spec.ip6dst, &rule->key.dst_ip,
+		       sizeof(struct in6_addr));
+		fsp->h_u.ah_ip6_spec.spi = rule->key.spi;
+		fsp->h_u.ah_ip6_spec.tclass = rule->key.tclass;
+		memcpy(fsp->m_u.ah_ip6_spec.ip6src, &rule->mask.src_ip,
+		       sizeof(struct in6_addr));
+		memcpy(fsp->m_u.ah_ip6_spec.ip6dst, &rule->mask.dst_ip,
+		       sizeof(struct in6_addr));
+		fsp->m_u.ah_ip6_spec.spi = rule->mask.spi;
+		fsp->m_u.ah_ip6_spec.tclass = rule->mask.tclass;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	fsp->ring_cookie = be16_to_cpu(rule->action);
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
+	struct ethtool_rx_flow_spec *fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
+	struct gve_flow_rule *rules_cache = priv->flow_rules_cache.rules_cache;
+	u32 *cache_num = &priv->flow_rules_cache.rules_cache_num;
+	struct gve_flow_rule *rule = NULL;
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
+	u32 *rule_ids_cache = priv->flow_rules_cache.rule_ids_cache;
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
+	kfree(rule);
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
index eb435ccbe98e..ac38453327c3 100644
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
@@ -638,6 +638,12 @@ static void gve_teardown_device_resources(struct gve_priv *priv)
 
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
@@ -1782,6 +1788,14 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
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
@@ -2055,15 +2069,21 @@ static int gve_set_features(struct net_device *netdev,
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
2.45.0.rc1.225.g2a3ae87e7f-goog


