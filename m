Return-Path: <netdev+bounces-197675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD8AD98E7
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EAE4A070C
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DB714F90;
	Sat, 14 Jun 2025 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ja98yR24"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D468F58
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749859685; cv=none; b=SNGAqidsgLBt3ksftOuH9OVsymGdpqTPdVRs0tVTY6CxQePiiY1nO4vpbCxUU1IRA85mM2S+iqr/ageFO2l+8/TiuL0osJCzCt+XdVtpdWhi5cbd8OqwxTP07SrhBDoxy+6XgKuw1lzRos3mYNYQGXyTWUjOxi4pAmB4LOdyylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749859685; c=relaxed/simple;
	bh=XIJIUaDJgPSbCeOnMVn1vrfeqwODaajknW8FUVvJoNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hHHEqr3y1sjbvKIgveu2v25y8PAio1/c7jV6j4kbzikPbpyrHdpeZXWcw2NXFxokeJ5yqO31XEyz5CcV0nRiwsh7IlIN+rWu0FZJ9penb0S+P5SSE6vTbVIceeSPLaripQsKhh3/1KZ9TbxULwNxh8D+QcdX8hU/PUBCdZaII/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ja98yR24; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748475d2a79so1893551b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749859682; x=1750464482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBPRpnc2h4x7Im3EOyFPjzyzqimwB1+8048ZYxeRcjo=;
        b=Ja98yR24NQ/vac0qUCBYezwFzNyjkVhbl5DMQBG5u6XuxKyJzZu4KWhD6DuwJCVC/Q
         srZkBc4OzsvtZpJeuE9L2OpK3g2/cgB9DFqBMCrt9HFd8kcDTD36WBtx1r79OQDqAjv3
         NsPP04lNrYuiUAigIuz6D22kxwbGUMG57hp7LqMUm7R/GlAOoXmdOi3L4oeOktJ5sm/M
         CVkGjWSH4KUSauv/Ocxo3R2Qc8+EUcKNqQAOTQu1T/p5xnLtYfpk5hfDXhhZZYj1tHf7
         VZsRGauEy9OLWbgzX1TS9otfQmjWwyv+WwToUicxnitNFdeVklZzZKMlnJHwUJNT0y47
         EqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749859682; x=1750464482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBPRpnc2h4x7Im3EOyFPjzyzqimwB1+8048ZYxeRcjo=;
        b=pqdiki5MoZfPbFjLhZR6nQY91svOGgy79KoEWA2ZJKz+gDS6jWkL9hgNrkOomfgnt0
         DMT+Ei+zoBzSknautCwsUpRs3UypOOS1AMAHMVa/hMcTLo2uXWCbYIm1L64zwl3D2R6Q
         GeU0fEMXH1iIYQbarRwO03+ltEQFyRaTZm3oARYi0rsKdSUQmBpws5PCr5YMKgimUmJg
         QrZkdkXYOhEUlqoA1fDNcD+40hiXhOvbChdJvqhT12meRBtF78unf8VFTzN5w1kfESi0
         u8UNWzcI0ForaUvnpmI0OWipHnGYVvLPDyGGGKjGVh0f54eUHoyVqUVrvjscH8j4FpDb
         4csw==
X-Gm-Message-State: AOJu0YyjXoSQ8N8ddpSHHfHmaUJSCVaDqJj/l/+hCEM2Nvf2dNcnkZAL
	Tc0OWFjPRqWOdlzou0tT7gLUbBamLb8BICDXbORom7FyNdi9iSu/S3/oE+fWZz9QZhuK+Xhw/KE
	VESAvpGs4QumoQByc6VpPol7t/bicETFUJk+BuC2Z0dt5nzxi5urUbKN8R+1rbEhciRzp7yC6PV
	Qc5np1MQPbxOmBmz3wLojxTlcXnqB1V4qqoSlB2eb3iBa0FkiA1nLn3obuQYJbcfo=
X-Google-Smtp-Source: AGHT+IF06pXPX9ePngFqLO6uSZaAh/zowL719POVkd57+2cgGQLCP9hIZbWoJ1b3zIPzNVJK3mOKKd/HFbtS6tptMw==
X-Received: from pfkq15.prod.google.com ([2002:a05:6a00:84f:b0:748:55b9:ffbe])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:cca:b0:732:a24:7354 with SMTP id d2e1a72fcca58-7489cdff4c0mr1644678b3a.4.1749859682529;
 Fri, 13 Jun 2025 17:08:02 -0700 (PDT)
Date: Sat, 14 Jun 2025 00:07:48 +0000
In-Reply-To: <20250614000754.164827-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250614000754.164827-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614000754.164827-3-hramamurthy@google.com>
Subject: [PATCH net-next v5 2/8] gve: Add adminq command to report nic timestamp
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
 Changes in v4:
 - add two more reserved fields in gve_nic_ts_report, anticipating
   upcoming use, to align size expectations with the device from the
   start (team internal review, Shachar Raindel)
---
 drivers/net/ethernet/google/gve/gve.h         |  1 +
 drivers/net/ethernet/google/gve/gve_adminq.c  | 20 +++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h  | 19 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  3 ++-
 4 files changed, 42 insertions(+), 1 deletion(-)

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
index 42466ee640f1..f9f19e135790 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -27,6 +27,7 @@ enum gve_adminq_opcodes {
 	GVE_ADMINQ_GET_PTYPE_MAP		= 0xE,
 	GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY	= 0xF,
 	GVE_ADMINQ_QUERY_FLOW_RULES		= 0x10,
+	GVE_ADMINQ_REPORT_NIC_TIMESTAMP		= 0x11,
 	GVE_ADMINQ_QUERY_RSS			= 0x12,
 
 	/* For commands that are larger than 56 bytes */
@@ -401,6 +402,21 @@ struct gve_adminq_report_link_speed {
 
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
+	__be64 reserved3;
+	__be64 reserved4;
+};
+
 struct stats {
 	__be32 stat_name;
 	__be32 queue_id;
@@ -594,6 +610,7 @@ union gve_adminq_command {
 			struct gve_adminq_query_flow_rules query_flow_rules;
 			struct gve_adminq_configure_rss configure_rss;
 			struct gve_adminq_query_rss query_rss;
+			struct gve_adminq_report_nic_ts report_nic_ts;
 			struct gve_adminq_extended_command extended_command;
 		};
 	};
@@ -633,6 +650,8 @@ int gve_adminq_reset_flow_rules(struct gve_priv *priv);
 int gve_adminq_query_flow_rules(struct gve_priv *priv, u16 query_opcode, u32 starting_loc);
 int gve_adminq_configure_rss(struct gve_priv *priv, struct ethtool_rxfh_param *rxfh);
 int gve_adminq_query_rss_config(struct gve_priv *priv, struct ethtool_rxfh_param *rxfh);
+int gve_adminq_report_nic_ts(struct gve_priv *priv,
+			     dma_addr_t nic_ts_report_addr);
 
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index a6d0089ecd7b..6ecbcee4ec13 100644
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
2.50.0.rc1.591.g9c95f17f64-goog


