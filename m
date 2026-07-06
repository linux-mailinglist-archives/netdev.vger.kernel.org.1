Return-Path: <netdev+bounces-305048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id isAVCzrJS2r0aAEAu9opvQ
	(envelope-from <netdev+bounces-305048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:26:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A99712915
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:26:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hHyt4DAa;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305048-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305048-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8401431BFDE7
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D33E32A3FE;
	Mon,  6 Jul 2026 13:34:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E928D8D0
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:34:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344882; cv=none; b=jUlBuFkf/y9KhwpPGnb4mMkfoFL2m2FKNkOkegq2B8D59Nk2DEGyiojVKoRpY5bmabTBdZ++Eil40ByiqrkECbYe5JrrpDYIh6xyfcAaMgaQukZ1T3lu9n/L21+64SAOP72eykJLfevvkZqmERYj/m+e4ctDfTR36IDQPQbkf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344882; c=relaxed/simple;
	bh=26y6gawRqDoCW4GNJS32adDFRxZxyo1F2iQbuOyDW7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YihIhrrd4eO/2NhIiSJ2LBRtDOOFzXP/0UwjbJfTXsvgBEVR91T1mFxHLbzzKfIOm62md0ssf9Z/DI4vWVPDRfW4iswkjrHBU80YAcQDIEW/ynixiJa2tquYrvwwISWQunbGY2h3AtssZshZOuU8p4ZQqKHQ7v/RDi9/yipHn3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHyt4DAa; arc=none smtp.client-ip=209.85.128.178
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-804e46366d7so45083037b3.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344880; x=1783949680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P9yR1TtzFHIppXg+6b5Pa4DM3lArT/QYAqr1656DTs=;
        b=hHyt4DAaEmy/ticfJUrKWVtlyI8/2neVKa/AyRqhN6GwumS6/XKRQBdS9mltJaevhV
         jduvu99uwOKqNtVXvCXHrHDysroFKayTdorGEMIqUVxosiUgRdnGxAmjODqcrGtiO3Bp
         f07ZJjru2WmMvVFkwg2p8ack5nqowyyYoKAuJIi4L7vZOmpawICC3K2mIUxczAcmE7TZ
         6MYafXdqm0+ekSeu97cnP5XAfxBUs3xHQeF6i5fXJu9zsDtf9IcB74B6S1CYsnpPS8q2
         cIkd0pCoAUgI8KhZBbdisws3KmAnqBPTw5o0tF5DshgM8r/EBHiSbgMfRMCTg/P1tu7F
         MWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344880; x=1783949680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0P9yR1TtzFHIppXg+6b5Pa4DM3lArT/QYAqr1656DTs=;
        b=qlgbE3oa+IhLkMhMibc/qxyAd7uZK51r8d6T5jsou2w+5WtqkR8w/ngUdiw8qsAapq
         wdgTGr9wvn7dSmAN0q/s8pf2xpeJVC4a1undLsrRTvQ4fgyn72PiuxKmDotwjGd7C8bC
         cABo2C6XZxktgawdlriFwdoCQxJcHNo+OwgOaCLgZly4tPephEylbBxEwrE1USg3lJSG
         wrUWBiJmwakTDUC3vht7BxqYxHlBty0JxZTwb8C8FQyBIvWo6kTwOSMdT8crF6xFG2C2
         a0VnuW23FUfwpwJ2HHR0BglkwEBsJ4nCvGF+maUNea+bgnLgZ3pZSkWGEGe2LH88yXQy
         J0rw==
X-Gm-Message-State: AOJu0YwPDh+uuH+7kV7j4MEb/jXFaPOFPT20HYfe0UfRIaZ+t1wics3L
	Jk/aTRGn5e7DWETLw8JDCO67aHv1wbo8E0Fobn6hzNgnRp0Qy+sJ3zjVN9omCA==
X-Gm-Gg: AfdE7cmzRvrujGXC0qS4ZjGlOAEyaZidV7Ieb6mNBGZcTgiQYCPY2Orp4Yj2wmj7+Qd
	0ZSdP+asnHn4cqaj9mwAhpxgIxQNnmUfXXD07F/OkgfOQ0Ajj3R3CZgVIa3B0Yqzo1bx3k2/68w
	w9Fdnkf3t77EOS8kU3ctFbYeO6S0pMJ9IQHJ2I0mtX4zp9Nzr9vISsYFIB6GP6iEcObY/Rk5TXu
	qMMbRdS3BNEmL6cZGR/0aEJrcl9CgioaMgY7rGhYu6bGVfyFmytdt1gIFRu2iKKkxqGSdZUPaAb
	NdM/BoV0vn6ahjR8mQi302FtV3kHN86mx0N+LO2hQjaN/DE2PE8xSyCgI3BDTPt6b66SIcngTPP
	J4pp6q5OfOAcm9PubSBUWyzrfPYIIwxmFeCQ4+wraq0ky/Jm+6LPN1BN4uZCMPGfg+hw1FjYSpw
	FhvYXUCjQV1Qw7YRESC99KL8oW4+uR3P1OabsPzU3gcokEmDbmjepiBQIOEqPFe2AFumRJXF4t/
	ISxrEy3M/HdJPMK
X-Received: by 2002:a05:690c:4b05:b0:812:adec:7970 with SMTP id 00721157ae682-81be1032b61mr2321477b3.23.1783344879729;
        Mon, 06 Jul 2026 06:34:39 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b537e3asm57002827b3.34.2026.07.06.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:34:39 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 1/7] net: ethtool: add hardware pacing offload support to rings
Date: Mon,  6 Jul 2026 09:34:03 -0400
Message-ID: <20260706133433.3142805-2-willemdebruijn.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-305048-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew@lunn.ch,m:willemb@google.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85A99712915

From: Willem de Bruijn <willemb@google.com>

Add two ethtool rings operations:

- get pacing offload horizon: active and max
- set pacing offload horizon: active

Replace u64 max_pacing_offload_horizon with u32 active and max fields.
This occupies the same original 8 bytes. Reduce precision from nsec to
usec, which is sufficient.

Update the FQ scheduler to test against the active limit instead of
max. It is the administrator responsibility to set the active limit
before installing FQ.

Assisted-by: Gemini:gemini-3
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/netlink/specs/ethtool.yaml      |  6 ++++
 .../networking/net_cachelines/net_device.rst  |  3 +-
 include/linux/ethtool.h                       |  6 ++++
 include/linux/netdevice.h                     |  6 ++--
 .../uapi/linux/ethtool_netlink_generated.h    |  2 ++
 net/core/rtnetlink.c                          |  2 +-
 net/ethtool/common.c                          |  3 ++
 net/ethtool/netlink.h                         |  2 +-
 net/ethtool/rings.c                           | 30 +++++++++++++++++--
 net/sched/sch_fq.c                            |  3 +-
 10 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5dd4d1b5d94b..48f43dda2e6e 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -448,6 +448,12 @@ attribute-sets:
       -
         name: hds-thresh-max
         type: u32
+      -
+        name: pacing-offload-horizon
+        type: u32
+      -
+        name: pacing-offload-horizon-max
+        type: u32
 
   -
     name: mm-stat
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 512f6d6fa3d8..3b9ce1c6e105 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -183,7 +183,8 @@ struct devlink_port*                devlink_port
 struct dpll_pin*                    dpll_pin
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
-u64                                 max_pacing_offload_horizon
+u32                                 pacing_offload_horizon
+u32                                 max_pacing_offload_horizon
 struct_napi_config*                 napi_config
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 5d491a98265e..5759be3fcd7f 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -85,6 +85,8 @@ enum {
  * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
  * @hds_thresh: Packet size threshold for header data split (HDS)
  * @hds_thresh_max: Maximum supported setting for @hds_threshold
+ * @pacing_offload_horizon: pacing offload horizon value in usec.
+ * @max_pacing_offload_horizon: max pacing offload horizon value in usec.
  *
  */
 struct kernel_ethtool_ringparam {
@@ -97,6 +99,8 @@ struct kernel_ethtool_ringparam {
 	u32	tx_push_buf_max_len;
 	u32	hds_thresh;
 	u32	hds_thresh_max;
+	u32	pacing_offload_horizon;
+	u32	max_pacing_offload_horizon;
 };
 
 /**
@@ -108,6 +112,7 @@ struct kernel_ethtool_ringparam {
  * @ETHTOOL_RING_USE_TX_PUSH_BUF_LEN: capture for setting tx_push_buf_len
  * @ETHTOOL_RING_USE_TCP_DATA_SPLIT: capture for setting tcp_data_split
  * @ETHTOOL_RING_USE_HDS_THRS: capture for setting header-data-split-thresh
+ * @ETHTOOL_RING_USE_PACING_OFFLOAD_HORIZON: capture for setting pacing offload horizon
  */
 enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_RX_BUF_LEN		= BIT(0),
@@ -117,6 +122,7 @@ enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_TX_PUSH_BUF_LEN	= BIT(4),
 	ETHTOOL_RING_USE_TCP_DATA_SPLIT		= BIT(5),
 	ETHTOOL_RING_USE_HDS_THRS		= BIT(6),
+	ETHTOOL_RING_USE_PACING_OFFLOAD_HORIZON	= BIT(7),
 };
 
 #define __ETH_RSS_HASH_BIT(bit)	((u32)1 << (bit))
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b5..cf777a58b328 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2127,7 +2127,8 @@ enum netdev_reg_state {
  *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
  *		   where the clock is recovered.
  *
- *	@max_pacing_offload_horizon: max EDT offload horizon in nsec.
+ *	@pacing_offload_horizon: active pacing offload horizon in usec.
+ *	@max_pacing_offload_horizon: max pacing offload horizon in usec.
  *	@napi_config: An array of napi_config structures containing per-NAPI
  *		      settings.
  *	@num_napi_configs:	number of allocated NAPI config structs,
@@ -2547,7 +2548,8 @@ struct net_device {
 	/** @irq_moder: dim parameters used if IS_ENABLED(CONFIG_DIMLIB). */
 	struct dim_irq_moder	*irq_moder;
 
-	u64			max_pacing_offload_horizon;
+	u32			pacing_offload_horizon;
+	u32			max_pacing_offload_horizon;
 	struct napi_config	*napi_config;
 	u32			num_napi_configs;
 	u32			napi_defer_hard_irqs;
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 8134baf7860f..6f1a2fa36157 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -193,6 +193,8 @@ enum {
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
 	ETHTOOL_A_RINGS_HDS_THRESH,
 	ETHTOOL_A_RINGS_HDS_THRESH_MAX,
+	ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON,
+	ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON_MAX,
 
 	__ETHTOOL_A_RINGS_CNT,
 	ETHTOOL_A_RINGS_MAX = (__ETHTOOL_A_RINGS_CNT - 1)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 12aa3aa1688b..efcb219561ea 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2124,7 +2124,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	    nla_put_u32(skb, IFLA_TSO_MAX_SEGS,
 			READ_ONCE(dev->tso_max_segs)) ||
 	    nla_put_uint(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
-			 READ_ONCE(dev->max_pacing_offload_horizon)) ||
+			 (u64)READ_ONCE(dev->max_pacing_offload_horizon) * NSEC_PER_USEC) ||
 #ifdef CONFIG_RPS
 	    nla_put_u32(skb, IFLA_NUM_RX_QUEUES,
 			READ_ONCE(dev->num_rx_queues)) ||
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 23db40618fed..5c2323aaa02b 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -954,6 +954,9 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 	/* Driver gives us current state, we want to return current config */
 	kparam->tcp_data_split = dev->cfg->hds_config;
 	kparam->hds_thresh = dev->cfg->hds_thresh;
+
+	kparam->pacing_offload_horizon = dev->pacing_offload_horizon;
+	kparam->max_pacing_offload_horizon = dev->max_pacing_offload_horizon;
 }
 
 static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 4ca2eca2e94b..fb0d99fd8cfd 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -466,7 +466,7 @@ extern const struct nla_policy ethnl_features_set_policy[ETHTOOL_A_FEATURES_WANT
 extern const struct nla_policy ethnl_privflags_get_policy[ETHTOOL_A_PRIVFLAGS_HEADER + 1];
 extern const struct nla_policy ethnl_privflags_set_policy[ETHTOOL_A_PRIVFLAGS_FLAGS + 1];
 extern const struct nla_policy ethnl_rings_get_policy[ETHTOOL_A_RINGS_HEADER + 1];
-extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_HDS_THRESH_MAX + 1];
+extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON_MAX + 1];
 extern const struct nla_policy ethnl_channels_get_policy[ETHTOOL_A_CHANNELS_HEADER + 1];
 extern const struct nla_policy ethnl_channels_set_policy[ETHTOOL_A_CHANNELS_COMBINED_COUNT + 1];
 extern const struct nla_policy ethnl_coalesce_get_policy[ETHTOOL_A_COALESCE_HEADER + 1];
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 9054c89c5d7b..3ff0cb57d03c 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -42,6 +42,8 @@ static int rings_prepare_data(const struct ethnl_req_info *req_base,
 
 	data->kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
 	data->kernel_ringparam.hds_thresh = dev->cfg->hds_thresh;
+	data->kernel_ringparam.pacing_offload_horizon = dev->pacing_offload_horizon;
+	data->kernel_ringparam.max_pacing_offload_horizon = dev->max_pacing_offload_horizon;
 
 	dev->ethtool_ops->get_ringparam(dev, &data->ringparam,
 					&data->kernel_ringparam, info->extack);
@@ -69,7 +71,9 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_HDS_THRESH */
-	       nla_total_size(sizeof(u32));	/* _RINGS_HDS_THRESH_MAX*/
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_HDS_THRESH_MAX*/
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_PACING_OFFLOAD_HORIZON */
+	       nla_total_size(sizeof(u32));	/* _RINGS_PACING_OFFLOAD_HORIZON_MAX */
 }
 
 static int rings_fill_reply(struct sk_buff *skb,
@@ -121,7 +125,12 @@ static int rings_fill_reply(struct sk_buff *skb,
 	     (nla_put_u32(skb, ETHTOOL_A_RINGS_HDS_THRESH,
 			  kr->hds_thresh) ||
 	      nla_put_u32(skb, ETHTOOL_A_RINGS_HDS_THRESH_MAX,
-			  kr->hds_thresh_max))))
+			  kr->hds_thresh_max))) ||
+	    ((supported_ring_params & ETHTOOL_RING_USE_PACING_OFFLOAD_HORIZON) &&
+	     (nla_put_u32(skb, ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON,
+			  kr->pacing_offload_horizon) ||
+	      nla_put_u32(skb, ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON_MAX,
+			  kr->max_pacing_offload_horizon))))
 		return -EMSGSIZE;
 
 	return 0;
@@ -144,6 +153,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_RX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]	= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_HDS_THRESH]		= { .type = NLA_U32 },
+	[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON]	= { .type = NLA_U32 },
 };
 
 static int
@@ -177,6 +187,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
 		return -EOPNOTSUPP;
 	}
 
+	if (tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON] &&
+	    !(ops->supported_ring_params & ETHTOOL_RING_USE_PACING_OFFLOAD_HORIZON)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON],
+				    "setting pacing offload horizon is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
 	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
@@ -246,6 +264,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 			 tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
 	ethnl_update_u32(&kernel_ringparam.hds_thresh,
 			 tb[ETHTOOL_A_RINGS_HDS_THRESH], &mod);
+	ethnl_update_u32(&kernel_ringparam.pacing_offload_horizon,
+			 tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON], &mod);
 	if (!mod)
 		return 0;
 
@@ -281,6 +301,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		err_attr = tb[ETHTOOL_A_RINGS_TX];
 	else if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max)
 		err_attr = tb[ETHTOOL_A_RINGS_HDS_THRESH];
+	else if (kernel_ringparam.pacing_offload_horizon >
+		 kernel_ringparam.max_pacing_offload_horizon)
+		err_attr = tb[ETHTOOL_A_RINGS_PACING_OFFLOAD_HORIZON];
 	else
 		err_attr = NULL;
 	if (err_attr) {
@@ -302,6 +325,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
+	if (!ret)
+		dev->pacing_offload_horizon = kernel_ringparam.pacing_offload_horizon;
+
 	return ret < 0 ? ret : 1;
 }
 
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cae082a9847..d4cc8bc9fa06 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1179,7 +1179,8 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		u64 offload_horizon = (u64)NSEC_PER_USEC *
 				      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
 
-		if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
+		if (offload_horizon <=
+		    (u64)qdisc_dev(sch)->pacing_offload_horizon * NSEC_PER_USEC) {
 			WRITE_ONCE(q->offload_horizon, offload_horizon);
 		} else {
 			NL_SET_ERR_MSG_MOD(extack, "invalid offload_horizon");
-- 
2.55.0.795.g602f6c329a-goog


