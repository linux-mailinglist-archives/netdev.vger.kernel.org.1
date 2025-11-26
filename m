Return-Path: <netdev+bounces-242026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF2DC8BB69
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA75F4EA3A1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1BB346763;
	Wed, 26 Nov 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ap1BGSV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F22345CD3
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186653; cv=none; b=cROXhUKzLZkOcurmX1Nuq5z3AZ8uUuTlLySU/vLRDCpyk9cz1e7f/+YIh292ABIjPwv0JbhNyUbIb7gk9/BrLgeqWllts1wMErxyzgDoRbCfBxDpxIO2vj/Ck5udJuneiWBNerzTvfxzJYTS4c/qtKUVZeVicd8jBfRj0iZrF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186653; c=relaxed/simple;
	bh=ViMa2JXl8dBSFb/J919nGFZxyOT8I+T4Ov0qvqphhOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okz8Cx36DqpD48Xlo+YrbfAr1/LVxh8eaZxDPgoLGkw/ihqt1hl3Yu2gAaf1VfZbUY5MPEXZKjwpMe+TWsRAJBGqP7YezJOre4pwW5seh+Ift1miiz/S9AvQiA173ifJsgX908nA+A14p2fywoAaM25lcD6e3Tsx9mrnEtRJnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ap1BGSV6; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8b2148ca40eso12948485a.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186649; x=1764791449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96B5g/vrBTqWhs3NOZYa0sQuyQICh5qAauRERgmK3aE=;
        b=gvVqDHgtnpdHrHVxs4wrYg5Ks3kbP6fu5jmV7MvBxHlgMqJ8wWGbwpIoRcOH6/Ly6b
         PStFGzwmWEmpWcbuI0fZKmnxbgvC9yKQjoJN9m624Fyjydux8Lj54b/FBGpHIQXRhSpq
         hExLK+Hivv6AN40Imbxxz1qjWFZXyfW4vaCy4WvmZZ7/YlAGW4BAPkfilneJYxD/DRWG
         I+p3YPDWcEreivYZPNYqTpnAJ7vN4GfZlBDJaukzhflMjVs5CHBrs67iJPQESV9hEywV
         xK0Wtd9dQX2Vpqm5acox/mhrYv3qJOpNtMkxD6qhkA9iLRuaKJ9RUfW4EaMx57BtlHTr
         NXJQ==
X-Gm-Message-State: AOJu0YyKSF9Nx8SzkxNSQ2MHJ2ulB5e3TugRXmGvplNi+d/eSTfc5FMT
	IsKXfgwZC3eynCbXtW3kifzAZtRSUgTaSBcwXTu4XxUtIkYNbBlzM39z/z44T+fqHljyNd+d651
	6q+9yRgxWE4eDaHVVhLAVRTlisQuH4N9naLFFs4C9pBbV7tLFjiFYFur7jhAf2gnpeLA5zPmgvG
	KDUWCr5u5NXRQgPi0bS83nvv6e+J3COVc+rdItt670z2lMMx/nFtGDYv8YKa/lRrRBO4kF0EnlG
	nZMb2lLZM5kf4Zl5msi
X-Gm-Gg: ASbGncvS9O8Gp0t1jP1n2Dsotpkrb0ABsNln6qVu7xovMpfLA4f4HVyqeyyI54V78dz
	BPwArUNaZVTiRTwPpKpzZPzmbdmy69rl9KpOs+Hq9MEDanQ99D72AFBcbYHg4ljYOKZAzd8kaT/
	KPQQK8Pa7P/hEWqKabfNvpvkWy0qnlI1o3QZtnwpebYHoLry7rtSetBvuhuZexMjgqQ+KDnQa1n
	3SZhabqXp4lUgiHNoEsSn+Kjw20U/x22El1DW2pu5MqvatX9XTRIZ3dfqamnJtlA+SJRGhrgIMH
	pXFQTWOVyIZTfMebOV/gK/CLC/obLQ1t7BKKWFiVbHsHVSUoMBnL5elKl78afQR05fJ3uCa+Qst
	pEhd1YlVkxeqGZ5GXuNYvWsg0a78HJCfJFTvVElYRPSdt2ODZ+VuqYDLdJygntTvFQVjOuDk2c9
	rKpuu/aD0TIaQAOnulzkOQ2nxcG7ms012Ivsihhi46jm7o/9LO+PY=
X-Google-Smtp-Source: AGHT+IGGZZrn64ayC+q7wN3MaHNp0dYBwmNqArWolUcLlTsKafFv3lCyZTMadgzqBJ/Qr/15zR3S4CP/FCm+
X-Received: by 2002:a05:620a:4623:b0:8b1:ed55:e4f0 with SMTP id af79cd13be357-8b33d22542cmr2870455485a.39.1764186649394;
        Wed, 26 Nov 2025 11:50:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8b32959f60bsm201822385a.6.2025.11.26.11.50.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:50:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2982b47ce35so1057215ad.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764186648; x=1764791448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96B5g/vrBTqWhs3NOZYa0sQuyQICh5qAauRERgmK3aE=;
        b=ap1BGSV6n4G92Axg8eyUeiYTNaHWCQQNqi02sSLM76OwXN+2zpaiE54kqoHuz+FdSL
         Ml6nVm3El/t0v2OKTIDfkgBu/1RQTTbv693Oosd8ouGXY4sZ4ZhFSFU8riZwJ2asp0pM
         1X8vygN57+TmzLH3pcbFrmUwPx9c6DRv0z4k4=
X-Received: by 2002:a17:903:1904:b0:298:616b:b2d with SMTP id d9443c01a7336-29b6c6b1bf9mr173250885ad.51.1764186647552;
        Wed, 26 Nov 2025 11:50:47 -0800 (PST)
X-Received: by 2002:a17:903:1904:b0:298:616b:b2d with SMTP id d9443c01a7336-29b6c6b1bf9mr173250595ad.51.1764186646995;
        Wed, 26 Nov 2025 11:50:46 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e638sm206782375ad.58.2025.11.26.11.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:50:46 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v3, net-next 10/12] bng_en: Add initial support for ethtool stats display
Date: Thu, 27 Nov 2025 01:19:29 +0530
Message-ID: <20251126194931.455830-11-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patch adds support for displaying ethtool statistics.
Currently, only the display functionality is implemented.

All stat counters remain at 0, as support for updating the
counters will be added in subsequent patches.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 612 ++++++++++++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 143 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   3 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 186 +++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  94 ++-
 5 files changed, 1028 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
index b985799051b..a82271492d7 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -32,6 +32,374 @@ static int bnge_nway_reset(struct net_device *dev)
 }
 
 
+static const char * const bnge_ring_rx_stats_str[] = {
+	"rx_ucast_packets",
+	"rx_mcast_packets",
+	"rx_bcast_packets",
+	"rx_discards",
+	"rx_errors",
+	"rx_ucast_bytes",
+	"rx_mcast_bytes",
+	"rx_bcast_bytes",
+};
+
+static const char * const bnge_ring_tx_stats_str[] = {
+	"tx_ucast_packets",
+	"tx_mcast_packets",
+	"tx_bcast_packets",
+	"tx_errors",
+	"tx_discards",
+	"tx_ucast_bytes",
+	"tx_mcast_bytes",
+	"tx_bcast_bytes",
+};
+
+static const char * const bnge_ring_tpa_stats_str[] = {
+	"tpa_packets",
+	"tpa_bytes",
+	"tpa_events",
+	"tpa_aborts",
+};
+
+static const char * const bnge_ring_tpa2_stats_str[] = {
+	"rx_tpa_eligible_pkt",
+	"rx_tpa_eligible_bytes",
+	"rx_tpa_pkt",
+	"rx_tpa_bytes",
+	"rx_tpa_errors",
+	"rx_tpa_events",
+};
+
+static const char * const bnge_rx_sw_stats_str[] = {
+	"rx_l4_csum_errors",
+	"rx_resets",
+	"rx_buf_errors",
+};
+
+#define BNGE_RX_STATS_ENTRY(counter)	\
+	{ BNGE_RX_STATS_OFFSET(counter), __stringify(counter) }
+
+#define BNGE_TX_STATS_ENTRY(counter)	\
+	{ BNGE_TX_STATS_OFFSET(counter), __stringify(counter) }
+
+#define BNGE_RX_STATS_EXT_ENTRY(counter)	\
+	{ BNGE_RX_STATS_EXT_OFFSET(counter), __stringify(counter) }
+
+#define BNGE_TX_STATS_EXT_ENTRY(counter)	\
+	{ BNGE_TX_STATS_EXT_OFFSET(counter), __stringify(counter) }
+
+#define BNGE_RX_STATS_EXT_PFC_ENTRY(n)				\
+	BNGE_RX_STATS_EXT_ENTRY(pfc_pri##n##_rx_duration_us),	\
+	BNGE_RX_STATS_EXT_ENTRY(pfc_pri##n##_rx_transitions)
+
+#define BNGE_TX_STATS_EXT_PFC_ENTRY(n)				\
+	BNGE_TX_STATS_EXT_ENTRY(pfc_pri##n##_tx_duration_us),	\
+	BNGE_TX_STATS_EXT_ENTRY(pfc_pri##n##_tx_transitions)
+
+#define BNGE_RX_STATS_EXT_PFC_ENTRIES				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(0),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(1),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(2),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(3),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(4),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(5),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(6),				\
+	BNGE_RX_STATS_EXT_PFC_ENTRY(7)
+
+#define BNGE_TX_STATS_EXT_PFC_ENTRIES				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(0),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(1),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(2),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(3),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(4),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(5),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(6),				\
+	BNGE_TX_STATS_EXT_PFC_ENTRY(7)
+
+#define BNGE_RX_STATS_EXT_COS_ENTRY(n)				\
+	BNGE_RX_STATS_EXT_ENTRY(rx_bytes_cos##n),		\
+	BNGE_RX_STATS_EXT_ENTRY(rx_packets_cos##n)
+
+#define BNGE_TX_STATS_EXT_COS_ENTRY(n)				\
+	BNGE_TX_STATS_EXT_ENTRY(tx_bytes_cos##n),		\
+	BNGE_TX_STATS_EXT_ENTRY(tx_packets_cos##n)
+
+#define BNGE_RX_STATS_EXT_COS_ENTRIES				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(0),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(1),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(2),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(3),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(4),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(5),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(6),				\
+	BNGE_RX_STATS_EXT_COS_ENTRY(7)				\
+
+#define BNGE_TX_STATS_EXT_COS_ENTRIES				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(0),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(1),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(2),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(3),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(4),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(5),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(6),				\
+	BNGE_TX_STATS_EXT_COS_ENTRY(7)				\
+
+#define BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(n)			\
+	BNGE_RX_STATS_EXT_ENTRY(rx_discard_bytes_cos##n),	\
+	BNGE_RX_STATS_EXT_ENTRY(rx_discard_packets_cos##n)
+
+#define BNGE_RX_STATS_EXT_DISCARD_COS_ENTRIES				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(0),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(1),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(2),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(3),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(4),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(5),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(6),				\
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRY(7)
+
+#define BNGE_RX_STATS_PRI_ENTRY(counter, n)		\
+	{ BNGE_RX_STATS_EXT_OFFSET(counter##_cos0),	\
+	  __stringify(counter##_pri##n) }
+
+#define BNGE_TX_STATS_PRI_ENTRY(counter, n)		\
+	{ BNGE_TX_STATS_EXT_OFFSET(counter##_cos0),	\
+	  __stringify(counter##_pri##n) }
+
+#define BNGE_RX_STATS_PRI_ENTRIES(counter)		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 0),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 1),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 2),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 3),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 4),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 5),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 6),		\
+	BNGE_RX_STATS_PRI_ENTRY(counter, 7)
+
+#define BNGE_TX_STATS_PRI_ENTRIES(counter)		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 0),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 1),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 2),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 3),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 4),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 5),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 6),		\
+	BNGE_TX_STATS_PRI_ENTRY(counter, 7)
+
+enum {
+	RX_TOTAL_DISCARDS,
+	TX_TOTAL_DISCARDS,
+	RX_NETPOLL_DISCARDS,
+};
+
+static const char *const bnge_ring_err_stats_arr[] = {
+	"rx_total_l4_csum_errors",
+	"rx_total_resets",
+	"rx_total_buf_errors",
+	"rx_total_oom_discards",
+	"rx_total_netpoll_discards",
+	"rx_total_ring_discards",
+	"tx_total_resets",
+	"tx_total_ring_discards",
+};
+
+#define NUM_RING_RX_SW_STATS		ARRAY_SIZE(bnge_rx_sw_stats_str)
+#define NUM_RING_RX_HW_STATS		ARRAY_SIZE(bnge_ring_rx_stats_str)
+#define NUM_RING_TX_HW_STATS		ARRAY_SIZE(bnge_ring_tx_stats_str)
+
+static const struct {
+	long offset;
+	char string[ETH_GSTRING_LEN];
+} bnge_tx_port_stats_ext_arr[] = {
+	BNGE_TX_STATS_EXT_COS_ENTRIES,
+	BNGE_TX_STATS_EXT_PFC_ENTRIES,
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_rx_bytes_pri_arr[] = {
+	BNGE_RX_STATS_PRI_ENTRIES(rx_bytes),
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_rx_pkts_pri_arr[] = {
+	BNGE_RX_STATS_PRI_ENTRIES(rx_packets),
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_tx_bytes_pri_arr[] = {
+	BNGE_TX_STATS_PRI_ENTRIES(tx_bytes),
+};
+
+static const struct {
+	long base_off;
+	char string[ETH_GSTRING_LEN];
+} bnge_tx_pkts_pri_arr[] = {
+	BNGE_TX_STATS_PRI_ENTRIES(tx_packets),
+};
+
+static const struct {
+	long offset;
+	char string[ETH_GSTRING_LEN];
+} bnge_port_stats_arr[] = {
+	BNGE_RX_STATS_ENTRY(rx_64b_frames),
+	BNGE_RX_STATS_ENTRY(rx_65b_127b_frames),
+	BNGE_RX_STATS_ENTRY(rx_128b_255b_frames),
+	BNGE_RX_STATS_ENTRY(rx_256b_511b_frames),
+	BNGE_RX_STATS_ENTRY(rx_512b_1023b_frames),
+	BNGE_RX_STATS_ENTRY(rx_1024b_1518b_frames),
+	BNGE_RX_STATS_ENTRY(rx_good_vlan_frames),
+	BNGE_RX_STATS_ENTRY(rx_1519b_2047b_frames),
+	BNGE_RX_STATS_ENTRY(rx_2048b_4095b_frames),
+	BNGE_RX_STATS_ENTRY(rx_4096b_9216b_frames),
+	BNGE_RX_STATS_ENTRY(rx_9217b_16383b_frames),
+	BNGE_RX_STATS_ENTRY(rx_total_frames),
+	BNGE_RX_STATS_ENTRY(rx_ucast_frames),
+	BNGE_RX_STATS_ENTRY(rx_mcast_frames),
+	BNGE_RX_STATS_ENTRY(rx_bcast_frames),
+	BNGE_RX_STATS_ENTRY(rx_fcs_err_frames),
+	BNGE_RX_STATS_ENTRY(rx_ctrl_frames),
+	BNGE_RX_STATS_ENTRY(rx_pause_frames),
+	BNGE_RX_STATS_ENTRY(rx_pfc_frames),
+	BNGE_RX_STATS_ENTRY(rx_align_err_frames),
+	BNGE_RX_STATS_ENTRY(rx_ovrsz_frames),
+	BNGE_RX_STATS_ENTRY(rx_jbr_frames),
+	BNGE_RX_STATS_ENTRY(rx_mtu_err_frames),
+	BNGE_RX_STATS_ENTRY(rx_tagged_frames),
+	BNGE_RX_STATS_ENTRY(rx_double_tagged_frames),
+	BNGE_RX_STATS_ENTRY(rx_good_frames),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri0),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri1),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri2),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri3),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri4),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri5),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri6),
+	BNGE_RX_STATS_ENTRY(rx_pfc_ena_frames_pri7),
+	BNGE_RX_STATS_ENTRY(rx_undrsz_frames),
+	BNGE_RX_STATS_ENTRY(rx_eee_lpi_events),
+	BNGE_RX_STATS_ENTRY(rx_eee_lpi_duration),
+	BNGE_RX_STATS_ENTRY(rx_bytes),
+	BNGE_RX_STATS_ENTRY(rx_runt_bytes),
+	BNGE_RX_STATS_ENTRY(rx_runt_frames),
+	BNGE_RX_STATS_ENTRY(rx_stat_discard),
+	BNGE_RX_STATS_ENTRY(rx_stat_err),
+
+	BNGE_TX_STATS_ENTRY(tx_64b_frames),
+	BNGE_TX_STATS_ENTRY(tx_65b_127b_frames),
+	BNGE_TX_STATS_ENTRY(tx_128b_255b_frames),
+	BNGE_TX_STATS_ENTRY(tx_256b_511b_frames),
+	BNGE_TX_STATS_ENTRY(tx_512b_1023b_frames),
+	BNGE_TX_STATS_ENTRY(tx_1024b_1518b_frames),
+	BNGE_TX_STATS_ENTRY(tx_good_vlan_frames),
+	BNGE_TX_STATS_ENTRY(tx_1519b_2047b_frames),
+	BNGE_TX_STATS_ENTRY(tx_2048b_4095b_frames),
+	BNGE_TX_STATS_ENTRY(tx_4096b_9216b_frames),
+	BNGE_TX_STATS_ENTRY(tx_9217b_16383b_frames),
+	BNGE_TX_STATS_ENTRY(tx_good_frames),
+	BNGE_TX_STATS_ENTRY(tx_total_frames),
+	BNGE_TX_STATS_ENTRY(tx_ucast_frames),
+	BNGE_TX_STATS_ENTRY(tx_mcast_frames),
+	BNGE_TX_STATS_ENTRY(tx_bcast_frames),
+	BNGE_TX_STATS_ENTRY(tx_pause_frames),
+	BNGE_TX_STATS_ENTRY(tx_pfc_frames),
+	BNGE_TX_STATS_ENTRY(tx_jabber_frames),
+	BNGE_TX_STATS_ENTRY(tx_fcs_err_frames),
+	BNGE_TX_STATS_ENTRY(tx_err),
+	BNGE_TX_STATS_ENTRY(tx_fifo_underruns),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri0),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri1),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri2),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri3),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri4),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri5),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri6),
+	BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri7),
+	BNGE_TX_STATS_ENTRY(tx_eee_lpi_events),
+	BNGE_TX_STATS_ENTRY(tx_eee_lpi_duration),
+	BNGE_TX_STATS_ENTRY(tx_total_collisions),
+	BNGE_TX_STATS_ENTRY(tx_bytes),
+	BNGE_TX_STATS_ENTRY(tx_xthol_frames),
+	BNGE_TX_STATS_ENTRY(tx_stat_discard),
+	BNGE_TX_STATS_ENTRY(tx_stat_error),
+};
+
+static const struct {
+	long offset;
+	char string[ETH_GSTRING_LEN];
+} bnge_port_stats_ext_arr[] = {
+	BNGE_RX_STATS_EXT_ENTRY(link_down_events),
+	BNGE_RX_STATS_EXT_ENTRY(continuous_pause_events),
+	BNGE_RX_STATS_EXT_ENTRY(resume_pause_events),
+	BNGE_RX_STATS_EXT_ENTRY(continuous_roce_pause_events),
+	BNGE_RX_STATS_EXT_ENTRY(resume_roce_pause_events),
+	BNGE_RX_STATS_EXT_COS_ENTRIES,
+	BNGE_RX_STATS_EXT_PFC_ENTRIES,
+	BNGE_RX_STATS_EXT_ENTRY(rx_bits),
+	BNGE_RX_STATS_EXT_ENTRY(rx_buffer_passed_threshold),
+	BNGE_RX_STATS_EXT_ENTRY(rx_pcs_symbol_err),
+	BNGE_RX_STATS_EXT_ENTRY(rx_corrected_bits),
+	BNGE_RX_STATS_EXT_DISCARD_COS_ENTRIES,
+	BNGE_RX_STATS_EXT_ENTRY(rx_fec_corrected_blocks),
+	BNGE_RX_STATS_EXT_ENTRY(rx_fec_uncorrectable_blocks),
+	BNGE_RX_STATS_EXT_ENTRY(rx_filter_miss),
+};
+
+static int bnge_get_num_tpa_ring_stats(struct bnge_dev *bd)
+{
+	if (BNGE_SUPPORTS_TPA(bd))
+		return BNGE_NUM_TPA_RING_STATS;
+	return 0;
+}
+
+#define BNGE_NUM_RING_ERR_STATS	ARRAY_SIZE(bnge_ring_err_stats_arr)
+#define BNGE_NUM_PORT_STATS ARRAY_SIZE(bnge_port_stats_arr)
+#define BNGE_NUM_STATS_PRI			\
+	(ARRAY_SIZE(bnge_rx_bytes_pri_arr) +	\
+	 ARRAY_SIZE(bnge_rx_pkts_pri_arr) +	\
+	 ARRAY_SIZE(bnge_tx_bytes_pri_arr) +	\
+	 ARRAY_SIZE(bnge_tx_pkts_pri_arr))
+
+static int bnge_get_num_ring_stats(struct bnge_dev *bd)
+{
+	int rx, tx;
+
+	rx = NUM_RING_RX_HW_STATS + NUM_RING_RX_SW_STATS +
+	     bnge_get_num_tpa_ring_stats(bd);
+	tx = NUM_RING_TX_HW_STATS;
+	return rx * bd->rx_nr_rings +
+	       tx * bd->tx_nr_rings_per_tc;
+}
+
+static int bnge_get_num_stats(struct bnge_net *bn)
+{
+	int num_stats = bnge_get_num_ring_stats(bn->bd);
+	int len;
+
+	num_stats += BNGE_NUM_RING_ERR_STATS;
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS)
+		num_stats += BNGE_NUM_PORT_STATS;
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		len = min_t(int, bn->fw_rx_stats_ext_size,
+			    ARRAY_SIZE(bnge_port_stats_ext_arr));
+		num_stats += len;
+		len = min_t(int, bn->fw_tx_stats_ext_size,
+			    ARRAY_SIZE(bnge_tx_port_stats_ext_arr));
+		num_stats += len;
+		if (bn->pri2cos_valid)
+			num_stats += BNGE_NUM_STATS_PRI;
+	}
+
+	return num_stats;
+}
+
 static void bnge_get_drvinfo(struct net_device *dev,
 			     struct ethtool_drvinfo *info)
 {
@@ -41,6 +409,247 @@ static void bnge_get_drvinfo(struct net_device *dev,
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
 	strscpy(info->fw_version, bd->fw_ver_str, sizeof(info->fw_version));
 	strscpy(info->bus_info, pci_name(bd->pdev), sizeof(info->bus_info));
+	info->n_stats = bnge_get_num_stats(bn);
+}
+
+static int bnge_get_sset_count(struct net_device *dev, int sset)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+
+	switch (sset) {
+	case ETH_SS_STATS:
+		return bnge_get_num_stats(bn);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static bool is_rx_ring(struct bnge_dev *bd, u16 ring_num)
+{
+	return ring_num < bd->rx_nr_rings;
+}
+
+static bool is_tx_ring(struct bnge_dev *bd, u16 ring_num)
+{
+	u16 tx_base = 0;
+
+	if (!(bd->flags & BNGE_EN_SHARED_CHNL))
+		tx_base = bd->rx_nr_rings;
+
+	if (ring_num >= tx_base && ring_num < (tx_base + bd->tx_nr_rings))
+		return true;
+	return false;
+}
+
+static void bnge_get_ethtool_stats(struct net_device *dev,
+				   struct ethtool_stats *stats, u64 *buf)
+{
+	struct bnge_total_ring_err_stats ring_err_stats = {0};
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	u64 *curr, *prev;
+	u32 tpa_stats;
+	u32 i, j = 0;
+
+	if (!bn->bnapi) {
+		j += bnge_get_num_ring_stats(bd);
+		goto skip_ring_stats;
+	}
+
+	tpa_stats = bnge_get_num_tpa_ring_stats(bd);
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+		u64 *sw_stats = nqr->stats.sw_stats;
+		u64 *sw;
+		int k;
+
+		if (is_rx_ring(bd, i)) {
+			for (k = 0; k < NUM_RING_RX_HW_STATS; j++, k++)
+				buf[j] = sw_stats[k];
+		}
+		if (is_tx_ring(bd, i)) {
+			k = NUM_RING_RX_HW_STATS;
+			for (; k < NUM_RING_RX_HW_STATS + NUM_RING_TX_HW_STATS;
+			       j++, k++)
+				buf[j] = sw_stats[k];
+		}
+		if (!tpa_stats || !is_rx_ring(bd, i))
+			goto skip_tpa_ring_stats;
+
+		k = NUM_RING_RX_HW_STATS + NUM_RING_TX_HW_STATS;
+		for (; k < NUM_RING_RX_HW_STATS + NUM_RING_TX_HW_STATS +
+			   tpa_stats; j++, k++)
+			buf[j] = sw_stats[k];
+
+skip_tpa_ring_stats:
+		sw = (u64 *)&nqr->sw_stats->rx;
+		if (is_rx_ring(bd, i)) {
+			for (k = 0; k < NUM_RING_RX_SW_STATS; j++, k++)
+				buf[j] = sw[k];
+		}
+	}
+
+	bnge_get_ring_err_stats(bn, &ring_err_stats);
+
+skip_ring_stats:
+	curr = &ring_err_stats.rx_total_l4_csum_errors;
+	prev = &bn->ring_err_stats_prev.rx_total_l4_csum_errors;
+	for (i = 0; i < BNGE_NUM_RING_ERR_STATS; i++, j++, curr++, prev++)
+		buf[j] = *curr + *prev;
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		u64 *port_stats = bn->port_stats.sw_stats;
+
+		for (i = 0; i < BNGE_NUM_PORT_STATS; i++, j++)
+			buf[j] = *(port_stats + bnge_port_stats_arr[i].offset);
+	}
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		u64 *rx_port_stats_ext = bn->rx_port_stats_ext.sw_stats;
+		u64 *tx_port_stats_ext = bn->tx_port_stats_ext.sw_stats;
+		u32 len;
+
+		len = min_t(u32, bn->fw_rx_stats_ext_size,
+			    ARRAY_SIZE(bnge_port_stats_ext_arr));
+		for (i = 0; i < len; i++, j++) {
+			buf[j] = *(rx_port_stats_ext +
+				   bnge_port_stats_ext_arr[i].offset);
+		}
+		len = min_t(u32, bn->fw_tx_stats_ext_size,
+			    ARRAY_SIZE(bnge_tx_port_stats_ext_arr));
+		for (i = 0; i < len; i++, j++) {
+			buf[j] = *(tx_port_stats_ext +
+				   bnge_tx_port_stats_ext_arr[i].offset);
+		}
+		if (bn->pri2cos_valid) {
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_rx_bytes_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(rx_port_stats_ext + n);
+			}
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_rx_pkts_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(rx_port_stats_ext + n);
+			}
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_tx_bytes_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(tx_port_stats_ext + n);
+			}
+			for (i = 0; i < 8; i++, j++) {
+				long n = bnge_tx_pkts_pri_arr[i].base_off +
+					 bn->pri2cos_idx[i];
+
+				buf[j] = *(tx_port_stats_ext + n);
+			}
+		}
+	}
+}
+
+static void bnge_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	u32 i, j, num_str;
+	const char *str;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < bd->nq_nr_rings; i++) {
+			if (is_rx_ring(bd, i))
+				for (j = 0; j < NUM_RING_RX_HW_STATS; j++) {
+					str = bnge_ring_rx_stats_str[j];
+					ethtool_sprintf(&buf, "[%d]: %s", i,
+							str);
+				}
+			if (is_tx_ring(bd, i))
+				for (j = 0; j < NUM_RING_TX_HW_STATS; j++) {
+					str = bnge_ring_tx_stats_str[j];
+					ethtool_sprintf(&buf, "[%d]: %s", i,
+							str);
+				}
+			num_str = bnge_get_num_tpa_ring_stats(bd);
+			if (!num_str || !is_rx_ring(bd, i))
+				goto skip_tpa_stats;
+
+			if (bd->max_tpa_v2)
+				for (j = 0; j < num_str; j++) {
+					str = bnge_ring_tpa2_stats_str[j];
+					ethtool_sprintf(&buf, "[%d]: %s", i,
+							str);
+				}
+			else
+				for (j = 0; j < num_str; j++) {
+					str = bnge_ring_tpa_stats_str[j];
+					ethtool_sprintf(&buf, "[%d]: %s", i,
+							str);
+				}
+skip_tpa_stats:
+			if (is_rx_ring(bd, i))
+				for (j = 0; j < NUM_RING_RX_SW_STATS; j++) {
+					str = bnge_rx_sw_stats_str[j];
+					ethtool_sprintf(&buf, "[%d]: %s", i,
+							str);
+				}
+		}
+		for (i = 0; i < BNGE_NUM_RING_ERR_STATS; i++)
+			ethtool_puts(&buf, bnge_ring_err_stats_arr[i]);
+
+		if (bn->flags & BNGE_FLAG_PORT_STATS)
+			for (i = 0; i < BNGE_NUM_PORT_STATS; i++) {
+				str = bnge_port_stats_arr[i].string;
+				ethtool_puts(&buf, str);
+			}
+
+		if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+			u32 len;
+
+			len = min_t(u32, bn->fw_rx_stats_ext_size,
+				    ARRAY_SIZE(bnge_port_stats_ext_arr));
+			for (i = 0; i < len; i++) {
+				str = bnge_port_stats_ext_arr[i].string;
+				ethtool_puts(&buf, str);
+			}
+
+			len = min_t(u32, bn->fw_tx_stats_ext_size,
+				    ARRAY_SIZE(bnge_tx_port_stats_ext_arr));
+			for (i = 0; i < len; i++) {
+				str = bnge_tx_port_stats_ext_arr[i].string;
+				ethtool_puts(&buf, str);
+			}
+
+			if (bn->pri2cos_valid) {
+				for (i = 0; i < 8; i++) {
+					str = bnge_rx_bytes_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+
+				for (i = 0; i < 8; i++) {
+					str = bnge_rx_pkts_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+
+				for (i = 0; i < 8; i++) {
+					str = bnge_tx_bytes_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+
+				for (i = 0; i < 8; i++) {
+					str = bnge_tx_pkts_pri_arr[i].string;
+					ethtool_puts(&buf, str);
+				}
+			}
+		}
+		break;
+	default:
+		netdev_err(bd->netdev, "%s invalid request %x\n",
+			   __func__, stringset);
+		break;
+	}
 }
 
 static const struct ethtool_ops bnge_ethtool_ops = {
@@ -50,6 +659,9 @@ static const struct ethtool_ops bnge_ethtool_ops = {
 	.get_drvinfo		= bnge_get_drvinfo,
 	.get_link		= bnge_get_link,
 	.nway_reset		= bnge_nway_reset,
+	.get_sset_count		= bnge_get_sset_count,
+	.get_strings		= bnge_get_strings,
+	.get_ethtool_stats	= bnge_get_ethtool_stats,
 };
 
 void bnge_set_ethtool_ops(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index d7eb9c7ed6d..b4c37bb4260 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -14,6 +14,7 @@
 #include "bnge_hwrm_lib.h"
 #include "bnge_rmem.h"
 #include "bnge_resc.h"
+#include "bnge_netdev.h"
 #include "bnge_link.h"
 
 int bnge_hwrm_ver_get(struct bnge_dev *bd)
@@ -596,6 +597,10 @@ int bnge_hwrm_func_qcaps(struct bnge_dev *bd)
 		bd->flags |= BNGE_EN_ROCE_V1;
 	if (flags & FUNC_QCAPS_RESP_FLAGS_ROCE_V2_SUPPORTED)
 		bd->flags |= BNGE_EN_ROCE_V2;
+	if (flags & FUNC_QCAPS_RESP_FLAGS_EXT_STATS_SUPPORTED)
+		bd->fw_cap |= BNGE_FW_CAP_EXT_STATS_SUPPORTED;
+	if (flags & FUNC_QCAPS_RESP_FLAGS_PCIE_STATS_SUPPORTED)
+		bd->fw_cap |= BNGE_FW_CAP_PCIE_STATS_SUPPORTED;
 
 	pf->fw_fid = le16_to_cpu(resp->fid);
 	pf->port_id = le16_to_cpu(resp->port_id);
@@ -1438,3 +1443,141 @@ int bnge_hwrm_vnic_set_tpa(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
 
 	return bnge_hwrm_req_send(bd, req);
 }
+
+int bnge_hwrm_func_qstat_ext(struct bnge_dev *bd, struct bnge_stats_mem *stats)
+{
+	struct hwrm_func_qstats_ext_output *resp;
+	struct hwrm_func_qstats_ext_input *req;
+	__le64 *hw_masks;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_QSTATS_EXT);
+	if (rc)
+		return rc;
+
+	req->fid = cpu_to_le16(0xffff);
+	req->flags = FUNC_QSTATS_EXT_REQ_FLAGS_COUNTER_MASK;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc) {
+		hw_masks = &resp->rx_ucast_pkts;
+		bnge_copy_hw_masks(stats->hw_masks, hw_masks, stats->len / 8);
+	}
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_port_qstats_ext(struct bnge_dev *bd, u8 flags)
+{
+	struct hwrm_queue_pri2cos_qcfg_output *resp_qc;
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct hwrm_queue_pri2cos_qcfg_input *req_qc;
+	struct hwrm_port_qstats_ext_output *resp_qs;
+	struct hwrm_port_qstats_ext_input *req_qs;
+	struct bnge_pf_info *pf = &bd->pf;
+	u32 tx_stat_size;
+	int rc;
+
+	if (!(bn->flags & BNGE_FLAG_PORT_STATS_EXT))
+		return 0;
+
+	if (flags && !(bd->fw_cap & BNGE_FW_CAP_EXT_HW_STATS_SUPPORTED))
+		return -EOPNOTSUPP;
+
+	rc = bnge_hwrm_req_init(bd, req_qs, HWRM_PORT_QSTATS_EXT);
+	if (rc)
+		return rc;
+
+	req_qs->flags = flags;
+	req_qs->port_id = cpu_to_le16(pf->port_id);
+	req_qs->rx_stat_size = cpu_to_le16(sizeof(struct rx_port_stats_ext));
+	req_qs->rx_stat_host_addr =
+		cpu_to_le64(bn->rx_port_stats_ext.hw_stats_map);
+	tx_stat_size = bn->tx_port_stats_ext.hw_stats ?
+		       sizeof(struct tx_port_stats_ext) : 0;
+	req_qs->tx_stat_size = cpu_to_le16(tx_stat_size);
+	req_qs->tx_stat_host_addr =
+		cpu_to_le64(bn->tx_port_stats_ext.hw_stats_map);
+	resp_qs = bnge_hwrm_req_hold(bd, req_qs);
+	rc = bnge_hwrm_req_send(bd, req_qs);
+	if (!rc) {
+		bn->fw_rx_stats_ext_size =
+			le16_to_cpu(resp_qs->rx_stat_size) / 8;
+		bn->fw_tx_stats_ext_size = tx_stat_size ?
+			le16_to_cpu(resp_qs->tx_stat_size) / 8 : 0;
+	} else {
+		bn->fw_rx_stats_ext_size = 0;
+		bn->fw_tx_stats_ext_size = 0;
+	}
+	bnge_hwrm_req_drop(bd, req_qs);
+
+	if (flags)
+		return rc;
+
+	if (bn->fw_tx_stats_ext_size <=
+	    offsetof(struct tx_port_stats_ext, pfc_pri0_tx_duration_us) / 8) {
+		bn->pri2cos_valid = 0;
+		return rc;
+	}
+
+	rc = bnge_hwrm_req_init(bd, req_qc, HWRM_QUEUE_PRI2COS_QCFG);
+	if (rc)
+		return rc;
+
+	req_qc->flags = cpu_to_le32(QUEUE_PRI2COS_QCFG_REQ_FLAGS_IVLAN);
+
+	resp_qc = bnge_hwrm_req_hold(bd, req_qc);
+	rc = bnge_hwrm_req_send(bd, req_qc);
+	if (!rc) {
+		u8 *pri2cos;
+		int i, j;
+
+		pri2cos = &resp_qc->pri0_cos_queue_id;
+		for (i = 0; i < 8; i++) {
+			u8 queue_id = pri2cos[i];
+			u8 queue_idx;
+
+			/* Per port queue IDs start from 0, 10, 20, etc */
+			queue_idx = queue_id % 10;
+			if (queue_idx > BNGE_MAX_QUEUE) {
+				bn->pri2cos_valid = false;
+				bnge_hwrm_req_drop(bd, req_qc);
+				return rc;
+			}
+			for (j = 0; j < bd->max_q; j++) {
+				if (bd->q_ids[j] == queue_id)
+					bn->pri2cos_idx[i] = queue_idx;
+			}
+		}
+		bn->pri2cos_valid = true;
+	}
+	bnge_hwrm_req_drop(bd, req_qc);
+
+	return rc;
+}
+
+int bnge_hwrm_port_qstats(struct bnge_dev *bd, u8 flags)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct hwrm_port_qstats_input *req;
+	struct bnge_pf_info *pf = &bd->pf;
+	int rc;
+
+	if (!(bn->flags & BNGE_FLAG_PORT_STATS))
+		return 0;
+
+	if (flags && !(bd->fw_cap & BNGE_FW_CAP_EXT_HW_STATS_SUPPORTED))
+		return -EOPNOTSUPP;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_QSTATS);
+	if (rc)
+		return rc;
+
+	req->flags = flags;
+	req->port_id = cpu_to_le16(pf->port_id);
+	req->tx_stat_host_addr = cpu_to_le64(bn->port_stats.hw_stats_map +
+					     BNGE_TX_PORT_STATS_BYTE_OFFSET);
+	req->rx_stat_host_addr = cpu_to_le64(bn->port_stats.hw_stats_map);
+	return bnge_hwrm_req_send(bd, req);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index f947ca66111..d43ccd4c7b3 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -61,4 +61,7 @@ int bnge_hwrm_set_link_setting(struct bnge_net *bn, bool set_pause);
 int bnge_hwrm_set_pause(struct bnge_net *bn);
 int bnge_hwrm_vnic_set_tpa(struct bnge_dev *bd, struct bnge_vnic_info *vnic,
 			   u32 tpa_flags);
+int bnge_hwrm_port_qstats(struct bnge_dev *bd, u8 flags);
+int bnge_hwrm_port_qstats_ext(struct bnge_dev *bd, u8 flags);
+int bnge_hwrm_func_qstat_ext(struct bnge_dev *bd, struct bnge_stats_mem *stats);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 82bbc370700..f9d7f90a825 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -41,6 +41,10 @@ static void bnge_free_stats_mem(struct bnge_net *bn,
 {
 	struct bnge_dev *bd = bn->bd;
 
+	kfree(stats->hw_masks);
+	stats->hw_masks = NULL;
+	kfree(stats->sw_stats);
+	stats->sw_stats = NULL;
 	if (stats->hw_stats) {
 		dma_free_coherent(bd->dev, stats->len, stats->hw_stats,
 				  stats->hw_stats_map);
@@ -49,7 +53,7 @@ static void bnge_free_stats_mem(struct bnge_net *bn,
 }
 
 static int bnge_alloc_stats_mem(struct bnge_net *bn,
-				struct bnge_stats_mem *stats)
+				struct bnge_stats_mem *stats, bool alloc_masks)
 {
 	struct bnge_dev *bd = bn->bd;
 
@@ -58,7 +62,20 @@ static int bnge_alloc_stats_mem(struct bnge_net *bn,
 	if (!stats->hw_stats)
 		return -ENOMEM;
 
+	stats->sw_stats = kzalloc(stats->len, GFP_KERNEL);
+	if (!stats->sw_stats)
+		goto stats_mem_err;
+
+	if (alloc_masks) {
+		stats->hw_masks = kzalloc(stats->len, GFP_KERNEL);
+		if (!stats->hw_masks)
+			goto stats_mem_err;
+	}
 	return 0;
+
+stats_mem_err:
+	bnge_free_stats_mem(bn, stats);
+	return -ENOMEM;
 }
 
 static void bnge_free_ring_stats(struct bnge_net *bn)
@@ -74,9 +91,107 @@ static void bnge_free_ring_stats(struct bnge_net *bn)
 		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
 
 		bnge_free_stats_mem(bn, &nqr->stats);
+
+		kfree(nqr->sw_stats);
+		nqr->sw_stats = NULL;
+	}
+}
+
+static void bnge_fill_masks(u64 *mask_arr, u64 mask, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		mask_arr[i] = mask;
+}
+
+void bnge_copy_hw_masks(u64 *mask_arr, __le64 *hw_mask_arr, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		mask_arr[i] = le64_to_cpu(hw_mask_arr[i]);
+}
+
+static void bnge_init_stats(struct bnge_net *bn)
+{
+	struct bnge_napi *bnapi = bn->bnapi[0];
+	struct bnge_nq_ring_info *nqr;
+	struct bnge_stats_mem *stats;
+	struct bnge_dev *bd = bn->bd;
+	__le64 *rx_stats, *tx_stats;
+	int rc, rx_count, tx_count;
+	u64 *rx_masks, *tx_masks;
+	u8 flags;
+
+	nqr = &bnapi->nq_ring;
+	stats = &nqr->stats;
+	rc = bnge_hwrm_func_qstat_ext(bd, stats);
+	if (rc) {
+		u64 mask = (1ULL << 48) - 1;
+
+		bnge_fill_masks(stats->hw_masks, mask, stats->len / 8);
+	}
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		stats = &bn->port_stats;
+		rx_stats = stats->hw_stats;
+		rx_masks = stats->hw_masks;
+		rx_count = sizeof(struct rx_port_stats) / 8;
+		tx_stats = rx_stats + BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		tx_masks = rx_masks + BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		tx_count = sizeof(struct tx_port_stats) / 8;
+
+		flags = PORT_QSTATS_REQ_FLAGS_COUNTER_MASK;
+		rc = bnge_hwrm_port_qstats(bd, flags);
+		if (rc) {
+			u64 mask = (1ULL << 40) - 1;
+
+			bnge_fill_masks(rx_masks, mask, rx_count);
+			bnge_fill_masks(tx_masks, mask, tx_count);
+		} else {
+			bnge_copy_hw_masks(rx_masks, rx_stats, rx_count);
+			bnge_copy_hw_masks(tx_masks, tx_stats, tx_count);
+			bnge_hwrm_port_qstats(bd, 0);
+		}
+	}
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		stats = &bn->rx_port_stats_ext;
+		rx_stats = stats->hw_stats;
+		rx_masks = stats->hw_masks;
+		rx_count = sizeof(struct rx_port_stats_ext) / 8;
+		stats = &bn->tx_port_stats_ext;
+		tx_stats = stats->hw_stats;
+		tx_masks = stats->hw_masks;
+		tx_count = sizeof(struct tx_port_stats_ext) / 8;
+
+		flags = PORT_QSTATS_EXT_REQ_FLAGS_COUNTER_MASK;
+		rc = bnge_hwrm_port_qstats_ext(bd, flags);
+		if (rc) {
+			u64 mask = (1ULL << 40) - 1;
+
+			bnge_fill_masks(rx_masks, mask, rx_count);
+			if (tx_stats)
+				bnge_fill_masks(tx_masks, mask, tx_count);
+		} else {
+			bnge_copy_hw_masks(rx_masks, rx_stats, rx_count);
+			if (tx_stats)
+				bnge_copy_hw_masks(tx_masks, tx_stats,
+						   tx_count);
+			bnge_hwrm_port_qstats_ext(bd, 0);
+		}
 	}
 }
 
+static void bnge_free_port_stats(struct bnge_net *bn)
+{
+	bn->flags &= ~BNGE_FLAG_PORT_STATS;
+	bn->flags &= ~BNGE_FLAG_PORT_STATS_EXT;
+
+	bnge_free_stats_mem(bn, &bn->port_stats);
+	bnge_free_stats_mem(bn, &bn->rx_port_stats_ext);
+	bnge_free_stats_mem(bn, &bn->tx_port_stats_ext);
+}
+
 static int bnge_alloc_ring_stats(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -89,13 +204,48 @@ static int bnge_alloc_ring_stats(struct bnge_net *bn)
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
 
+		nqr->sw_stats = kzalloc(sizeof(*nqr->sw_stats), GFP_KERNEL);
+		if (!nqr->sw_stats) {
+			rc = -ENOMEM;
+			goto err_free_ring_stats;
+		}
+
 		nqr->stats.len = size;
-		rc = bnge_alloc_stats_mem(bn, &nqr->stats);
+		rc = bnge_alloc_stats_mem(bn, &nqr->stats, !i);
 		if (rc)
 			goto err_free_ring_stats;
 
 		nqr->hw_stats_ctx_id = INVALID_STATS_CTX_ID;
 	}
+
+	if (!bn->port_stats.hw_stats) {
+		bn->port_stats.len = BNGE_PORT_STATS_SIZE;
+		rc = bnge_alloc_stats_mem(bn, &bn->port_stats, true);
+		if (rc)
+			goto err_free_ring_stats;
+
+		bn->flags |= BNGE_FLAG_PORT_STATS;
+	}
+
+	if (!(bd->fw_cap & BNGE_FW_CAP_EXT_STATS_SUPPORTED))
+		return 0;
+
+	if (!bn->rx_port_stats_ext.hw_stats) {
+		bn->rx_port_stats_ext.len = sizeof(struct rx_port_stats_ext);
+		/* Extended stats are optional */
+		rc = bnge_alloc_stats_mem(bn, &bn->rx_port_stats_ext, true);
+		if (!rc)
+			return 0;
+	}
+
+	if (!bn->tx_port_stats_ext.hw_stats) {
+		bn->tx_port_stats_ext.len = sizeof(struct tx_port_stats_ext);
+		/* Extended stats are optional */
+		rc = bnge_alloc_stats_mem(bn, &bn->tx_port_stats_ext, true);
+		if (!rc)
+			return 0;
+	}
+	bn->flags |= BNGE_FLAG_PORT_STATS_EXT;
 	return 0;
 
 err_free_ring_stats:
@@ -868,6 +1018,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_nq_arrays(bn);
 	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
+	bnge_free_port_stats(bn);
 	bnge_free_vnics(bn);
 	kfree(bn->tx_ring_map);
 	bn->tx_ring_map = NULL;
@@ -959,6 +1110,8 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	if (rc)
 		goto err_free_core;
 
+	bnge_init_stats(bn);
+
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
 		goto err_free_core;
@@ -2581,6 +2734,35 @@ static int bnge_close(struct net_device *dev)
 	return 0;
 }
 
+static void bnge_get_one_ring_err_stats(struct bnge_dev *bd,
+					struct bnge_total_ring_err_stats *stats,
+					struct bnge_nq_ring_info *nqr)
+{
+	struct bnge_sw_stats *sw_stats = nqr->sw_stats;
+	u64 *hw_stats = nqr->stats.sw_stats;
+
+	stats->rx_total_l4_csum_errors += sw_stats->rx.rx_l4_csum_errors;
+	stats->rx_total_resets += sw_stats->rx.rx_resets;
+	stats->rx_total_buf_errors += sw_stats->rx.rx_buf_errors;
+	stats->rx_total_oom_discards += sw_stats->rx.rx_oom_discards;
+	stats->rx_total_netpoll_discards += sw_stats->rx.rx_netpoll_discards;
+	stats->rx_total_ring_discards +=
+		BNGE_GET_RING_STATS64(hw_stats, rx_discard_pkts);
+	stats->tx_total_resets += sw_stats->tx.tx_resets;
+	stats->tx_total_ring_discards +=
+		BNGE_GET_RING_STATS64(hw_stats, tx_discard_pkts);
+}
+
+void bnge_get_ring_err_stats(struct bnge_net *bn,
+			     struct bnge_total_ring_err_stats *stats)
+{
+	int i;
+
+	for (i = 0; i < bn->bd->nq_nr_rings; i++)
+		bnge_get_one_ring_err_stats(bn->bd, stats,
+					    &bn->bnapi[i]->nq_ring);
+}
+
 static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 41e3ca671a7..d7713bd57c6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -225,6 +225,72 @@ struct bnge_tpa_info {
 #define BNGE_NQ_HDL_IDX(hdl)	((hdl) & BNGE_NQ_HDL_IDX_MASK)
 #define BNGE_NQ_HDL_TYPE(hdl)	(((hdl) & BNGE_NQ_HDL_TYPE_MASK) >>	\
 				 BNGE_NQ_HDL_TYPE_SHIFT)
+#define BNGE_GET_RING_STATS64(sw, counter)		\
+	(*((sw) + offsetof(struct ctx_hw_stats, counter) / 8))
+
+#define BNGE_GET_RX_PORT_STATS64(sw, counter)		\
+	(*((sw) + offsetof(struct rx_port_stats, counter) / 8))
+
+#define BNGE_GET_TX_PORT_STATS64(sw, counter)		\
+	(*((sw) + offsetof(struct tx_port_stats, counter) / 8))
+
+#define BNGE_PORT_STATS_SIZE				\
+	(sizeof(struct rx_port_stats) + sizeof(struct tx_port_stats) + 1024)
+
+#define BNGE_TX_PORT_STATS_BYTE_OFFSET			\
+	(sizeof(struct rx_port_stats) + 512)
+
+#define BNGE_RX_STATS_OFFSET(counter)			\
+	(offsetof(struct rx_port_stats, counter) / 8)
+
+#define BNGE_TX_STATS_OFFSET(counter)			\
+	((offsetof(struct tx_port_stats, counter) +	\
+	  BNGE_TX_PORT_STATS_BYTE_OFFSET) / 8)
+
+#define BNGE_RX_STATS_EXT_OFFSET(counter)		\
+	(offsetof(struct rx_port_stats_ext, counter) / 8)
+
+#define BNGE_RX_STATS_EXT_NUM_LEGACY                   \
+	BNGE_RX_STATS_EXT_OFFSET(rx_fec_corrected_blocks)
+
+#define BNGE_TX_STATS_EXT_OFFSET(counter)		\
+	(offsetof(struct tx_port_stats_ext, counter) / 8)
+
+struct bnge_total_ring_err_stats {
+	u64			rx_total_l4_csum_errors;
+	u64			rx_total_resets;
+	u64			rx_total_buf_errors;
+	u64			rx_total_oom_discards;
+	u64			rx_total_netpoll_discards;
+	u64			rx_total_ring_discards;
+	u64			tx_total_resets;
+	u64			tx_total_ring_discards;
+};
+
+struct bnge_rx_sw_stats {
+	u64			rx_l4_csum_errors;
+	u64			rx_resets;
+	u64			rx_buf_errors;
+	u64			rx_oom_discards;
+	u64			rx_netpoll_discards;
+};
+
+struct bnge_tx_sw_stats {
+	u64			tx_resets;
+};
+
+struct bnge_stats_mem {
+	u64		*sw_stats;
+	u64		*hw_masks;
+	void		*hw_stats;
+	dma_addr_t	hw_stats_map;
+	int		len;
+};
+
+struct bnge_sw_stats {
+	struct bnge_rx_sw_stats rx;
+	struct bnge_tx_sw_stats tx;
+};
 
 struct bnge_net {
 	struct bnge_dev		*bd;
@@ -292,6 +358,22 @@ struct bnge_net {
 	__be16			vxlan_port;
 	__be16			nge_port;
 	__be16			vxlan_gpe_port;
+
+	u64			flags;
+#define BNGE_FLAG_PORT_STATS		0x1
+#define BNGE_FLAG_PORT_STATS_EXT	0x2
+
+	struct bnge_total_ring_err_stats ring_err_stats_prev;
+
+	struct bnge_stats_mem	port_stats;
+	struct bnge_stats_mem	rx_port_stats_ext;
+	struct bnge_stats_mem	tx_port_stats_ext;
+	u16			fw_rx_stats_ext_size;
+	u16			fw_tx_stats_ext_size;
+
+	u8			pri2cos_idx[8];
+	u8			pri2cos_valid;
+
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -357,14 +439,6 @@ void bnge_set_ring_params(struct bnge_dev *bd);
 	bnge_writeq(bd, (db)->db_key64 | DBR_TYPE_NQ_ARM |	\
 		    DB_RING_IDX(db, idx), (db)->doorbell)
 
-struct bnge_stats_mem {
-	u64		*sw_stats;
-	u64		*hw_masks;
-	void		*hw_stats;
-	dma_addr_t	hw_stats_map;
-	int		len;
-};
-
 struct nqe_cn {
 	__le16	type;
 	#define NQ_CN_TYPE_MASK			0x3fUL
@@ -408,6 +482,7 @@ struct bnge_nq_ring_info {
 	struct bnge_db_info	nq_db;
 
 	struct bnge_stats_mem	stats;
+	struct bnge_sw_stats	*sw_stats;
 	u32			hw_stats_ctx_id;
 	u8			has_more_work:1;
 
@@ -568,4 +643,7 @@ u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
 			 struct bnge_rx_ring_info *rxr, gfp_t gfp);
 int bnge_alloc_rx_netmem(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
 			 u16 prod, gfp_t gfp);
+void bnge_get_ring_err_stats(struct bnge_net *bn,
+			     struct bnge_total_ring_err_stats *stats);
+void bnge_copy_hw_masks(u64 *mask_arr, __le64 *hw_mask_arr, int count);
 #endif /* _BNGE_NETDEV_H_ */
-- 
2.47.3


