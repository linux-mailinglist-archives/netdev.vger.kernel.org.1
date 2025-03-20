Return-Path: <netdev+bounces-176607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B08A6B138
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306BF19C36CB
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 22:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FBA22A4FC;
	Thu, 20 Mar 2025 22:44:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5F22A4E5;
	Thu, 20 Mar 2025 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510687; cv=none; b=N5SiexihVTQ7wtL1RYvWWlh/gQ9gKncUYiVXtV2URKEy0fK8pM/aNY+ECtlpVgb/oI95uFaGWzRJRKUiRP9C0BetsbBkaoyLeDhfZDZouB6bU5eYiHQjBFMIUYDvaCIKF57XrXknTsaNXqAUmZOtb6ZcdLIE7/VUu6qGw+Z6SJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510687; c=relaxed/simple;
	bh=81W+fRdC1ccZbYs88xxJfmhU+006b6KJS+29d3+FUM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWDg9H8Yr3bstWe1Z2ALS42324Nm0Vy2As85OmNGDsmRkBCVuYrihmwRXd+dPpTVhzxHCBIzqFJYhIVe/hc3nGGB2RcfIwEfHipMtJ5QbOh+TUU1wmywmviRppTCW12uJnhXu3STGPONbEsukQhvzOpU885aUfxQdOYxM6mXnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43948021a45so10831785e9.1;
        Thu, 20 Mar 2025 15:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510684; x=1743115484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8Go2A9K/0sa4Ok8A3HNxc/VLWrtBUpGE6Rv5fEk69U=;
        b=dPumryMp92/MXEfUXv3632RjC6B8jyv91NLUrvrl1qPWexV4qlCXRHa3uCO6/HEj6e
         opnWeO64cbnPfiK9pC4tsB0rslpRuFMN6Q7vb41IRYuY+mOGXx/TIDi4Gyunt7oX01PM
         wH6HNSOhgUjbtnue5cFb1B2h/wg5km5FhfC999+m2GyrkBz4cBYHYO3DNvDrrYU45X0X
         O0QOimZ9vCwt1BWFuKAiR8oUoE1tfVgWA0pH3gRP2GBaltz1KIa2rz/p6Sl/cww/VUf4
         OrGIkBPntyrUdfISPK/x8jytLE9gHAyWDtn6lGXI3tAb+BP6hiYzUs7HLsr5DERrouuZ
         XmOg==
X-Forwarded-Encrypted: i=1; AJvYcCXWMKm4GYtyG7SywNLPGW0C4t0S/owYoAV3SPhXZq0FgS3ydQnN8XVi9M/QXjK9brf27xZ69Y7j22A1f2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0ffOm7DeG9DF1rLmoBNmP6yOPswWnCVR4hyDvLtBSdCjFTTi
	jPzZCI73Qdsp4viek7m1+Y0aGqIlmUg9qG9UyfUgKf3gyXnSaLTbEvZVKxI4
X-Gm-Gg: ASbGncsSRyOh7cGI7UB/y7uOpjw++dBgRQPXw5Q43w5cn5/mgarfxdagxgZens0biug
	uyjgwrqfT/R7XvqaE15sWA6Vl4pHh4rrrt/AuyW6vb9NYGWl/SgBsUUsZ1PLxT7VLJdLBOV1mg4
	1yOUmcsOdz8pN6Yjmy5YcizrN7hQoI9tMShydhH9E5d7FKXjbyq7CYQg7dcTIybsiBGuDrfC6um
	fPFBtc3urV7/fvloALW3ZT+HF3MNG4d4ZaJksELr/Zjz1G8GRBd+9x8zIJXgXedmZwtihfzhNMJ
	Hf7hN2PdqdRknA8k4x2s5OZrmq5jy8Iy7etUlsNbkCeIfQsOLKdUYBzJJo5iWnn3+g5HvGpviMF
	V+ihqyMg=
X-Google-Smtp-Source: AGHT+IH9z/Ufr9GSKlFGp9wTMcIjmzn+VkGQIRZdhq3lJFSjiuvPgv3WMgtMOmTxIVkvQ1BM9FrwhQ==
X-Received: by 2002:a05:600c:1989:b0:43c:ebc4:36a5 with SMTP id 5b1f17b1804b1-43d509e9dd0mr7675245e9.7.1742510683300;
        Thu, 20 Mar 2025 15:44:43 -0700 (PDT)
Received: from im-t490s.redhat.com (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbcfaasm9490115e9.35.2025.03.20.15.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:44:42 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next] net: openvswitch: fix kernel-doc warnings in internal headers
Date: Thu, 20 Mar 2025 23:42:07 +0100
Message-ID: <20250320224431.252489-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some field descriptions were missing, some were not very accurate.
Not touching the uAPI header or .c files for now.

Formatting of those comments isn't great in general, but at least
they are not missing anything now.

Before:
  $ ./scripts/kernel-doc -none -Wall net/openvswitch/*.h 2>&1 | wc -l
  16

After:
  $ ./scripts/kernel-doc -none -Wall net/openvswitch/*.h 2>&1 | wc -l
  0

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/datapath.h | 20 ++++++++++++++------
 net/openvswitch/vport.h    |  9 +++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 9ca6231ea647..384ca77f4e79 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -29,8 +29,8 @@
  * datapath.
  * @n_hit: Number of received packets for which a matching flow was found in
  * the flow table.
- * @n_miss: Number of received packets that had no matching flow in the flow
- * table.  The sum of @n_hit and @n_miss is the number of packets that have
+ * @n_missed: Number of received packets that had no matching flow in the flow
+ * table.  The sum of @n_hit and @n_missed is the number of packets that have
  * been received by the datapath.
  * @n_lost: Number of received packets that had no matching flow in the flow
  * table that could not be sent to userspace (normally due to an overflow in
@@ -40,6 +40,7 @@
  *   up per packet.
  * @n_cache_hit: The number of received packets that had their mask found using
  * the mask cache.
+ * @syncp: Synchronization point for 64bit counters.
  */
 struct dp_stats_percpu {
 	u64 n_hit;
@@ -74,8 +75,10 @@ struct dp_nlsk_pids {
  * ovs_mutex and RCU.
  * @stats_percpu: Per-CPU datapath statistics.
  * @net: Reference to net namespace.
- * @max_headroom: the maximum headroom of all vports in this datapath; it will
+ * @user_features: Bitmap of enabled %OVS_DP_F_* features.
+ * @max_headroom: The maximum headroom of all vports in this datapath; it will
  * be used by all the internal vports in this dp.
+ * @meter_tbl: Meter table.
  * @upcall_portids: RCU protected 'struct dp_nlsk_pids'.
  *
  * Context: See the comment on locking at the top of datapath.c for additional
@@ -128,10 +131,13 @@ struct ovs_skb_cb {
 #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
 
 /**
- * struct dp_upcall - metadata to include with a packet to send to userspace
+ * struct dp_upcall_info - metadata to include with a packet sent to userspace
  * @cmd: One of %OVS_PACKET_CMD_*.
  * @userdata: If nonnull, its variable-length value is passed to userspace as
  * %OVS_PACKET_ATTR_USERDATA.
+ * @actions: If nonnull, its variable-length value is passed to userspace as
+ * %OVS_PACKET_ATTR_ACTIONS.
+ * @actions_len: The length of the @actions.
  * @portid: Netlink portid to which packet should be sent.  If @portid is 0
  * then no packet is sent and the packet is accounted in the datapath's @n_lost
  * counter.
@@ -152,6 +158,10 @@ struct dp_upcall_info {
  * struct ovs_net - Per net-namespace data for ovs.
  * @dps: List of datapaths to enable dumping them all out.
  * Protected by genl_mutex.
+ * @dp_notify_work: A work notifier to handle port unregistering.
+ * @masks_rebalance: A work to periodically optimize flow table caches.
+ * @ct_limit_info: A hash table of conntrack zone connection limits.
+ * @xt_label: Whether connlables are configured for the network or not.
  */
 struct ovs_net {
 	struct list_head dps;
@@ -160,8 +170,6 @@ struct ovs_net {
 #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
 	struct ovs_ct_limit_info *ct_limit_info;
 #endif
-
-	/* Module reference for configuring conntrack. */
 	bool xt_label;
 };
 
diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
index 3e71ca8ad8a7..9f67b9dd49f9 100644
--- a/net/openvswitch/vport.h
+++ b/net/openvswitch/vport.h
@@ -97,6 +97,8 @@ struct vport {
  * @desired_ifindex: New vport's ifindex.
  * @dp: New vport's datapath.
  * @port_no: New vport's port number.
+ * @upcall_portids: %OVS_VPORT_ATTR_UPCALL_PID attribute from Netlink message,
+ * %NULL if none was supplied.
  */
 struct vport_parms {
 	const char *name;
@@ -125,6 +127,8 @@ struct vport_parms {
  * have any configuration.
  * @send: Send a packet on the device.
  * zero for dropped packets or negative for error.
+ * @owner: Module that implements this vport type.
+ * @list: List entry in the global list of vport types.
  */
 struct vport_ops {
 	enum ovs_vport_type type;
@@ -144,6 +148,7 @@ struct vport_ops {
 /**
  * struct vport_upcall_stats_percpu - per-cpu packet upcall statistics for
  * a given vport.
+ * @syncp:     Synchronization point for 64bit counters.
  * @n_success: Number of packets that upcall to userspace succeed.
  * @n_fail:    Number of packets that upcall to userspace failed.
  */
@@ -164,6 +169,8 @@ void ovs_vport_free(struct vport *);
  *
  * @vport: vport to access
  *
+ * Returns: A void pointer to a private data allocated in the @vport.
+ *
  * If a nonzero size was passed in priv_size of vport_alloc() a private data
  * area was allocated on creation.  This allows that area to be accessed and
  * used for any purpose needed by the vport implementer.
@@ -178,6 +185,8 @@ static inline void *vport_priv(const struct vport *vport)
  *
  * @priv: Start of private data area.
  *
+ * Returns: A reference to a vport structure that contains @priv.
+ *
  * It is sometimes useful to translate from a pointer to the private data
  * area to the vport, such as in the case where the private data pointer is
  * the result of a hash table lookup.  @priv must point to the start of the
-- 
2.47.0


