Return-Path: <netdev+bounces-192894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8F5AC18BC
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764B84E342D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF512D1F74;
	Thu, 22 May 2025 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8bPp18p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307A2D193A
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958266; cv=none; b=YIF+xIXXidouGpyGoFSge6dfxsxYFU7//Ei7WcJekM6OzpqEeIQKHHZr/mj9hmSSiCdagx6m4Utb2zURkWFlqhrAH/E77egEkyK4HRhUMqQiWhnzhqJi6wPwuwOw5u5m7P+X6pZ/gTEbjoQlls9uml2V8hhkXa9j4cFYDjbfSDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958266; c=relaxed/simple;
	bh=qt90dNzGxg9DPkAmUlCuy3Xdty+pLbICXYrCaTjXO+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q2MLWna6mbeTiroG7rHuXvkrRIUoutiD4jDC32qfDk9jwTUyBUnvwzMIzXWXaleCUT+xM3bQhlEM4Ur0Yq6urDdQ+W7SNwDkSb9w2FE9l/aRl0W6OFxO6+HDD7OznD/rbDjE/5t/hHlIO1jpQVp0Gd6jwsvs/Fy54gXpwyFXNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8bPp18p; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-740adfc7babso7145351b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747958264; x=1748563064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RHgOpvqvGX2+R7Cv6qDiOLDKhDyhCnfeTXds2LJq2o=;
        b=j8bPp18pxK3XaG56mojLDz7ImZPsG8hkYkmv+SGWgcStxNjQ8GKdQsacOuN5Y4i0r5
         7zzgiRcDO4oaWtRZNVP3oibTgmxSo3qesrlKRWnH0e6uTmLLkQ7qjeO66nro66ba5dGv
         8TRfKxagLfSIJCrVl08U/g0s0N/c+bh3RXO7xR0QK0WbOgxWMKPrSbUuy0DRHvoZzt2E
         Jzjgmp5ZTajQ9dPLNXFKt3YdjwTAS5iDLChov4NJnyOvdaYDuavxPU65yVnK5g1S+eXW
         zK510JySwj6Ri6xxktQkra8BC7WM2UQaCZVNKGPTP6ewNd+4gdzJ6KLrqNt8PEGCGGxS
         e8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747958264; x=1748563064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RHgOpvqvGX2+R7Cv6qDiOLDKhDyhCnfeTXds2LJq2o=;
        b=tO53l9uCfOOud0z4A0EHwcCOnWuPoPj5CgG3zdH3fgFvh3UsIX6h53Ckjl5/mW2l/Y
         nslmN4mqDNX2m/YbqYaGzWsaVlFwolHnMNNUFsP0XZ+qGR5N8r62ylbcH1ZoDD5lSFjY
         nfKGx4blCU63M/36fk/YDkQsh1M8pFqSk3cFG33XFs7R//8L4nchnZ6FkqNZlRaU6l6Q
         LNl7LFEk09OFKICu4w8d4vKmSHYBr6icb4TUcXZWe+y8a9X8PcZL1tOi3w9DK8lmBwhD
         PwyiEIdu/Wb+h1czLms3OHwhwlpyJ7WGdafPj6pwTd15mHweYIq+cLmIPeUp4Puq2wsp
         JXhw==
X-Gm-Message-State: AOJu0YxTceIdJjEyvY9DWHtOlhBLUAv99O14TnE11CMGI8TNsn3rCDUv
	Zq3AzcqoFNy4dkgjf2h64z63Y9zJ7zjKtyoW0tJwpcBexGa2W0I3EmQuK0qknnNcOQ2nsCZkZFi
	dT8w3FtNI1JkedL/fZ4PtJFhXSw/u+yNBcCuEqCsR762lCi/DLcXGtVcKiT/spU3oprtktFynfW
	F51v/G3G46Sf59NatzZNN5+NAwncoBkoiSiEpaSwFBWo6Opq2x4+MSjLguMJugRjg=
X-Google-Smtp-Source: AGHT+IFMuCVlsFe1kseuL5dPtOTNNWDFpVumoupMOKsHQInpoZYU6KBwicqyFW5lEXU05JGzdkhjEPaa9gC4qMbY6A==
X-Received: from pfwz12.prod.google.com ([2002:a05:6a00:1d8c:b0:732:858a:729f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2302:b0:740:b5f9:90b4 with SMTP id d2e1a72fcca58-745ed8f5bfemr1136249b3a.17.1747958263786;
 Thu, 22 May 2025 16:57:43 -0700 (PDT)
Date: Thu, 22 May 2025 23:57:31 +0000
In-Reply-To: <20250522235737.1925605-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235737.1925605-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235737.1925605-3-hramamurthy@google.com>
Subject: [PATCH net-next v3 2/8] gve: Add adminq command to report nic timestamp
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org, 
	Jeff Rogers <jefrogers@google.com>
Content-Type: text/plain; charset="UTF-8"

From: John Fraker <jfraker@google.com>

Add an adminq command to read NIC's hardware clock. The driver
allocates dma memory and passes that dma memory address to the device.
The device then writes the clock to the given address.

Signed-off-by: Jeff Rogers <jefrogers@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  1 +
 drivers/net/ethernet/google/gve/gve_adminq.c  | 20 +++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h  | 17 ++++++++++++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  3 ++-
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index e9b2c1394b1f..cf6947731a9b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -813,6 +813,7 @@ struct gve_priv {
 	u32 adminq_set_driver_parameter_cnt;
 	u32 adminq_report_stats_cnt;
 	u32 adminq_report_link_speed_cnt;
+	u32 adminq_report_nic_timestamp_cnt;
 	u32 adminq_get_ptype_map_cnt;
 	u32 adminq_verify_driver_compatibility_cnt;
 	u32 adminq_query_flow_rules_cnt;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index ae20d2f7e6e1..f57913a673b4 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -326,6 +326,7 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
 	priv->adminq_set_driver_parameter_cnt = 0;
 	priv->adminq_report_stats_cnt = 0;
 	priv->adminq_report_link_speed_cnt = 0;
+	priv->adminq_report_nic_timestamp_cnt = 0;
 	priv->adminq_get_ptype_map_cnt = 0;
 	priv->adminq_query_flow_rules_cnt = 0;
 	priv->adminq_cfg_flow_rule_cnt = 0;
@@ -564,6 +565,9 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	case GVE_ADMINQ_REPORT_LINK_SPEED:
 		priv->adminq_report_link_speed_cnt++;
 		break;
+	case GVE_ADMINQ_REPORT_NIC_TIMESTAMP:
+		priv->adminq_report_nic_timestamp_cnt++;
+		break;
 	case GVE_ADMINQ_GET_PTYPE_MAP:
 		priv->adminq_get_ptype_map_cnt++;
 		break;
@@ -1229,6 +1233,22 @@ int gve_adminq_report_link_speed(struct gve_priv *priv)
 	return err;
 }
 
+int gve_adminq_report_nic_ts(struct gve_priv *priv,
+			     dma_addr_t nic_ts_report_addr)
+{
+	union gve_adminq_command cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.opcode = cpu_to_be32(GVE_ADMINQ_REPORT_NIC_TIMESTAMP);
+	cmd.report_nic_ts = (struct gve_adminq_report_nic_ts) {
+		.nic_ts_report_len =
+			cpu_to_be64(sizeof(struct gve_nic_ts_report)),
+		.nic_ts_report_addr = cpu_to_be64(nic_ts_report_addr),
+	};
+
+	return gve_adminq_execute_cmd(priv, &cmd);
+}
+
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut)
 {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 42466ee640f1..9360b84536d5 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -27,6 +27,7 @@ enum gve_adminq_opcodes {
 	GVE_ADMINQ_GET_PTYPE_MAP		= 0xE,
 	GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY	= 0xF,
 	GVE_ADMINQ_QUERY_FLOW_RULES		= 0x10,
+	GVE_ADMINQ_REPORT_NIC_TIMESTAMP		= 0x11,
 	GVE_ADMINQ_QUERY_RSS			= 0x12,
 
 	/* For commands that are larger than 56 bytes */
@@ -401,6 +402,19 @@ struct gve_adminq_report_link_speed {
 
 static_assert(sizeof(struct gve_adminq_report_link_speed) == 8);
 
+struct gve_adminq_report_nic_ts {
+	__be64 nic_ts_report_len;
+	__be64 nic_ts_report_addr;
+};
+
+static_assert(sizeof(struct gve_adminq_report_nic_ts) == 16);
+
+struct gve_nic_ts_report {
+	__be64 nic_timestamp; /* NIC clock in nanoseconds */
+	__be64 reserved1;
+	__be64 reserved2;
+};
+
 struct stats {
 	__be32 stat_name;
 	__be32 queue_id;
@@ -594,6 +608,7 @@ union gve_adminq_command {
 			struct gve_adminq_query_flow_rules query_flow_rules;
 			struct gve_adminq_configure_rss configure_rss;
 			struct gve_adminq_query_rss query_rss;
+			struct gve_adminq_report_nic_ts report_nic_ts;
 			struct gve_adminq_extended_command extended_command;
 		};
 	};
@@ -633,6 +648,8 @@ int gve_adminq_reset_flow_rules(struct gve_priv *priv);
 int gve_adminq_query_flow_rules(struct gve_priv *priv, u16 query_opcode, u32 starting_loc);
 int gve_adminq_configure_rss(struct gve_priv *priv, struct ethtool_rxfh_param *rxfh);
 int gve_adminq_query_rss_config(struct gve_priv *priv, struct ethtool_rxfh_param *rxfh);
+int gve_adminq_report_nic_ts(struct gve_priv *priv,
+			     dma_addr_t nic_ts_report_addr);
 
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 3c1da0cf3f61..d0628e25a82d 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -76,7 +76,7 @@ static const char gve_gstrings_adminq_stats[][ETH_GSTRING_LEN] __nonstring_array
 	"adminq_dcfg_device_resources_cnt", "adminq_set_driver_parameter_cnt",
 	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt", "adminq_get_ptype_map_cnt",
 	"adminq_query_flow_rules", "adminq_cfg_flow_rule", "adminq_cfg_rss_cnt",
-	"adminq_query_rss_cnt",
+	"adminq_query_rss_cnt", "adminq_report_nic_timestamp_cnt",
 };
 
 static const char gve_gstrings_priv_flags[][ETH_GSTRING_LEN] = {
@@ -456,6 +456,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = priv->adminq_cfg_flow_rule_cnt;
 	data[i++] = priv->adminq_cfg_rss_cnt;
 	data[i++] = priv->adminq_query_rss_cnt;
+	data[i++] = priv->adminq_report_nic_timestamp_cnt;
 }
 
 static void gve_get_channels(struct net_device *netdev,
-- 
2.49.0.1143.g0be31eac6b-goog


