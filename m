Return-Path: <netdev+bounces-305055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BR3kB9i6S2pPZQEAu9opvQ
	(envelope-from <netdev+bounces-305055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FDD711EDD
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:25:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GKdFCNzi;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305055-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305055-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C02A0303D133
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BE2370D5C;
	Mon,  6 Jul 2026 13:40:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E10328B7B
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:40:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345233; cv=none; b=KHZu0xDvrbU21+4X3bn6jMjKa9g3/iYvY8iRYJFAPsRQRspUHZgFbQcP1PhIYPTorcytMZEgl89hL/TPe3VRKPqFrxFeEOnsYGCHMavNjA46WoLh0z3IV3992CEnfqTigP3sRhDPhsnftck3xyRS/Cdct9lmBLN8g3SAVcb5xN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345233; c=relaxed/simple;
	bh=+4SXSM6yY0foXoy2DcWC6lU9mIxKfAfanIt8hKWwRMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Unv2w2NL9QX9FWDHVlesUcSUO6UVo1JG7bvPFMz/K4kyklIjgpbII4GEvEDcqttmlc7r5qyxnm6Q8mdS/jw8uzeDCnajzbtZKagg5EiBf9Vk9UlHBGeNaGeSgC3ohUe2U0t2R1nFOq56IaalC3J3ka/h2mfz9qV2ekUb9GW79t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKdFCNzi; arc=none smtp.client-ip=209.85.217.50
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-735f73287e2so1745930137.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783345231; x=1783950031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/ealltnK2UkTfUFcJ8pVE/x72F7G9jhIV7KaN7FoGM=;
        b=GKdFCNziFwHCbX7gE8RvMe+GrPgSsrWy7ttsp/52uWflAV5nAEo/vtsOplT65TlFQP
         oa0eAN53+vQ+bpZ2t6fEtt99MceIZO3a05/RJgGO3XToSLnYUdfiAtcWwhnnrfSaoNeP
         wa3JnQTuzNb6+u9WuYFTRbd5z6UDeQISvGbJ0G9b5c1POY19+PZUI4sY9/Wwo2hmtYJd
         o8afA83RoIcUCOfnZsJIoW9reXYrW6e5R/jH071pcasHCj03rYbMMpQlOzalDZHDLnwH
         28m/RgObCvjNReTBGY+Tf6l6G6lxgienwD/8V3uxVDC5kvyCX4TydyaTjH1///+W8GjM
         QiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345231; x=1783950031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/ealltnK2UkTfUFcJ8pVE/x72F7G9jhIV7KaN7FoGM=;
        b=csoD9zqHu/0Qrxa8QA9H+K8AjaBCNvPNDBeBqupNPXc8+7LehBsxKSiRmfLluTcCht
         VmC5tGR+v3LEHfUm79if2HvtQZaRQ/2f/fksXNAzuieTpQDCmT+22xUEeJbX+UhTXEO5
         UdT49TPtXeFHUxruFhXh9tlNi1+IfOqjHG48weZWGvzWSAJn3xlVf8eO6lobb0P8UWEr
         B5tUpJ9limIuGd5tRxokz3GEDuCYQQxtOw+nmNCuiUJV3ONDEUjPeIfLWnrkcfkTz3dt
         WDzzHaPVdZKKzclHDZFXe7fMa4GNNKBnudSAX/yZmC03zgAoRB2WuJfDSx2yJnDGyAHD
         Caaw==
X-Gm-Message-State: AOJu0YxlOuiCAdfXrhBqgjvlSF2Glgaypsyr/K4z5YPZcP4KwG0heGDI
	yuNbVMDYwTmSMccKNWf2afAA6NjfaRQZDd6n+Ru0x8EXtD31FG87eXwBvIfxPg==
X-Gm-Gg: AfdE7cmyT9Yo5HunUFIkfRIRQuxvAulz4A/65XrR3fFZQVJYjJOPmdGcuZ+o/S3GrCE
	i1+2N0kjHme3Z3+igbCRgraz+AEDfhOsYgVJan11Fc55gXSK5mVv0PuU88mh6fEwNaDrau/42tC
	h0XTYBt6teU5jTOzMcaj7hHytdfLblmP6iL7YmR4lsNaumXeEyDjV/hRBktlLoj26tdHNCR/UiY
	oI1mGOGfZr+2HnOrnJxU2kLnSORlUPO6sH9cYTS5UVNjsrqO0VJRVUp8xiYd4ZSrHRBU1HSncw1
	GGFsnwC2B6UYAU8q+7u5TC08hEnz2ZgYphTdKrG+tPznWZ1/NQD6c+tSUO50ndgTP93cip48j24
	lyAPNZz5QB0DCAQ26MAUZsc2tmqK7tK2d9J1BCKaWBRQuhw7rbT/B1onEFtelRg4JEYbHyO9LHe
	sFS7/AQVXa1MGj8SgKGsj3J2l4BaYjFvoI5j6FzI7EsL4ANw/NohNEXeFW43QCfZRKm7zlXGSo0
	jLd7kmFT2vzD4FK
X-Received: by 2002:a05:690c:2789:b0:80d:926c:ea45 with SMTP id 00721157ae682-81be203dc72mr2314387b3.31.1783344881128;
        Mon, 06 Jul 2026 06:34:41 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b537e3asm57002827b3.34.2026.07.06.06.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:34:40 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Joshua A Hay <joshua.a.hay@intel.com>
Subject: [PATCH net-next 3/7] idpf: support pacing offload
Date: Mon,  6 Jul 2026 09:34:05 -0400
Message-ID: <20260706133433.3142805-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
References: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-305055-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew@lunn.ch,m:willemb@google.com,m:anthony.l.nguyen@intel.com,m:joshua.a.hay@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12FDD711EDD

From: Willem de Bruijn <willemb@google.com>

If skb->tstamp is in the future, program this future delivery txtime
in the transmit descriptor.

TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
the FQ offload_horizon is configured.

But device support for pacing offload must be more robust. It can also
be reached through SO_TXTIME.

Bound check txtime. Only packets with timestamp between now and the
horizon (max_pacing_offload_horizon) are offloaded.

Support only in splitq mode, where tx and tx completion queues are
separate and so completions can be returned out of order.

Assume that the NIC clock is PTP synchronized to CLOCK_TAI. This
can later be refined, e.g., to a custom CLOCK_AUX.

Disable if in netpoll. It does not need the feature, and the ktime
functions are not safe to call in this context.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Joshua A Hay <joshua.a.hay@intel.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Sashiko, ignore pre-existing issues.

Sashiko, ignore that idpf_tx_splitq_set_txtime may have a benign race
by calling ktime_mono_to_any twice to get TAI to REALTIME offset.
---
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  3 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  5 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 63 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index bb99d9e7c65d..5ddf347927dc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1801,7 +1801,8 @@ static void idpf_get_ts_stats(struct net_device *netdev,
 static const struct ethtool_ops idpf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
-	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
+	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+				  ETHTOOL_RING_USE_PACING_OFFLOAD_HORIZON,
 	.get_msglevel		= idpf_get_msglevel,
 	.set_msglevel		= idpf_set_msglevel,
 	.get_link		= ethtool_op_get_link,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..de4170c2aa3b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -888,6 +888,11 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = vport->max_mtu;
 
+	if (idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model) &&
+	    !idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
+			    VIRTCHNL2_CAP_SPLITQ_QSCHED))
+		netdev->max_pacing_offload_horizon = 128000;
+
 	dflt_features = NETIF_F_SG	|
 			NETIF_F_HIGHDMA;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 7f9056404f64..3de0c4ec54f6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2023 Intel Corporation */
 
+#include <linux/netpoll.h>
+
 #include "idpf.h"
 #include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
@@ -2408,9 +2410,13 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 				    struct idpf_tx_splitq_params *params,
 				    u16 td_cmd, u16 size)
 {
-	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
 	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
+
+	desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
+	desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
+	desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
 }
 
 /**
@@ -3011,6 +3017,57 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
 }
 
+static void idpf_tx_splitq_set_txtime(const struct idpf_tx_queue *tx_q,
+				      const struct sk_buff *skb,
+				      struct idpf_tx_splitq_params *tx_params)
+{
+	const int ts_gran_pow2 = 9;
+	u64 ts, now;
+
+	/* Skip if netpoll: not needed and not safe to call ktime helpers */
+	if (netpoll_tx_running(skb->dev))
+		return;
+
+	switch (skb->tstamp_type) {
+	case SKB_CLOCK_REALTIME:
+		ts = ktime_to_ns(ktime_add(skb->tstamp,
+					   ktime_mono_to_any(0, TK_OFFS_TAI) -
+					   ktime_mono_to_any(0, TK_OFFS_REAL)));
+		break;
+	case SKB_CLOCK_MONOTONIC:
+		ts = ktime_to_ns(ktime_mono_to_any(skb->tstamp, TK_OFFS_TAI));
+		break;
+	case SKB_CLOCK_TAI:
+		ts = ktime_to_ns(skb->tstamp);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	now = ktime_get_clocktai_ns();
+	if (ts < now)
+		return;
+
+	/* beyond offload horizon? set overflow bit only */
+	if (ts > now + ((u64)skb->dev->pacing_offload_horizon * NSEC_PER_USEC)) {
+		tx_params->offload.desc_ts[2] = 1 << 7;
+		return;
+	}
+
+	ts >>= ts_gran_pow2;
+
+	tx_params->offload.desc_ts[0] = ts & 0xff;
+	tx_params->offload.desc_ts[1] = (ts >> 8) & 0xff;
+	tx_params->offload.desc_ts[2] = ((ts >> 16) & 0x7f);
+
+	/* 0 is valid 24b timestamp, but also means field unset.
+	 * Add 512 ns (ts_gran_pow2) to avoid this case
+	 */
+	if ((ts & 0x7fffff) == 0)
+		tx_params->offload.desc_ts[0] = 1;
+}
+
 /**
  * idpf_tx_splitq_frame - Sends buffer on Tx ring using flex descriptors
  * @skb: send buffer
@@ -3097,6 +3154,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
+
+		if (skb->tstamp && skb->dev->pacing_offload_horizon)
+			idpf_tx_splitq_set_txtime(tx_q, skb, &tx_params);
+
 		/* Set the RE bit to periodically "clean" the descriptor ring.
 		 * MIN_GAP is set to MIN_RING size to ensure it will be set at
 		 * least once each time around the ring.
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..865408b57b0d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -161,6 +161,7 @@ union idpf_tx_flex_desc {
  * @tso_segs: Number of segments to be sent
  * @tso_hdr_len: Length of headers to be duplicated
  * @td_cmd: Command field to be inserted into descriptor
+ * @desc_ts: Flow scheduling offload timestamp
  */
 struct idpf_tx_offload_params {
 	u32 tx_flags;
@@ -174,6 +175,7 @@ struct idpf_tx_offload_params {
 	u16 tso_hdr_len;
 
 	u16 td_cmd;
+	u8 desc_ts[3];
 };
 
 /**
-- 
2.55.0.795.g602f6c329a-goog


