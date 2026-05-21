Return-Path: <netdev+bounces-290433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNOhB7wRD2qSEgYAu9opvQ
	(envelope-from <netdev+bounces-290433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:07:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B45C5A6D62
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D60133020DE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B103D45D5;
	Thu, 21 May 2026 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDr3kU8U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5BC31E823
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369567; cv=none; b=jJ1LQSbaxEdh1H3ArDEYtOwBpFxJ9Zo8rNVCLHVvKFysgMOLaMYFItL/YMSbLBw3N6yl7qlL5MYdmd46ExIhI5H+cDW2U+EGaiguYiar3sfjHz4KcrOi3pttfMiNq8O19zOCe4Lw73yEiqBguAKm/smew62czGTLzWzn7wG5X8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369567; c=relaxed/simple;
	bh=LxX4NldNlTw/YOONXcI/8HfJpOmseVSoq/z5GYLwdYM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DJkL62kz91BYQUSGI7XEkZExvGSNXRC4Bbg2nrzNbzvtcrcL0HcUzu3z8BdW5suQooEGqC/veod2Unb1T4Z1b19jdRPhzLlRtL4P9mD7i4XTBUtFpxaL4eR5NJLAMErGwuBgBFvjuUPqLkagnLNvmcvVLQBxhHmrKI/g65VO88Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hDr3kU8U; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-914af005f4cso31386185a.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369564; x=1779974364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/Q9DIOu55feGb2d8c0tlvF++fnf/n7aUSuPojcXmOs=;
        b=hDr3kU8U2ZKuM7j49MbUR1x0V7WIEAJFqB2BVnTwuq0ifR7r0kbyL9CUoKcIqBS+lv
         fk1SyzNz7hZBoDiDBuetQ6wt/azHh2w2+m41m3kwIJg/yoLPedZOs10cAKh41EFKNHUP
         DS0BsXIRV2L3m3+yRd1ykZ+5d3BMarh2aOhhrbg6lLIzPPOYmGhs5oSDHTydvCZ2OKNc
         40jaAHmr+wd1sjc8zGbF9QfcUt70Ge1HdTodT/PZUZhmL4Rdn1S/zO9+8Gke9Tf3QIPD
         I/xeZLOAn1wKX+qwxifhbu0X9eExD4yxIQOt9vPQHE7o0xqc5eQLZNmsI19aT8V4iVLB
         ReZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369564; x=1779974364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/Q9DIOu55feGb2d8c0tlvF++fnf/n7aUSuPojcXmOs=;
        b=fm1q+/ZoSYX0GpGO6bfuogQOX8KLSsjeTOT/j/+AxmDEuqt1PgMuV41Er21z5DT+JH
         obpyhVe5EK8p6XG1ulbRunWZwghY9GcLNyxZKMsHFApMCVkpU/ztDr3F54Mei5R18Xla
         66jkCq9bVtNdN+g5eUWM6AGSsKXcNRoAdXYZVYX9vQ96llNil0Gq0hTxd9i9yKsIo+7A
         t/C44tb40g3kZTxvdMYOcS6Qt0IF+ywhfQBwKWSTkeDE90ZXCT7ndC2BftNsh6+I76tj
         uZi8mEDMPSdJLKNSrLyDY2wU+IQowo+nSACHmmdH4Ix5Mc4hhR4NHAnHaWMYBlugLt13
         gADQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AIGltItl0hOD/0oCOxBO2HHZiaP5GpEG6zaY0jYs60xNND5Nv/DrdEuVcM0HiDAP6P8myMvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL6kityY3oycfgiZHHlu1/dNSh9nUNIepB3C26HHbbBd6trDLP
	nvJgqWZ4zxJR/GEf/3D8GtIV9NUH7a+F5P91LEOoL2/d7Nth6wZ/9TUH4WKuUaRXxPl9HQCSHJj
	ZDTI/Z8tV5eZw+Q==
X-Received: from qknvj1.prod.google.com ([2002:a05:620a:7081:b0:8fd:2f89:e380])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4054:b0:8cf:c513:349c with SMTP id af79cd13be357-914a2a21924mr378963285a.9.1779369564074;
 Thu, 21 May 2026 06:19:24 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:07 +0000
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-3-edumazet@google.com>
Subject: [PATCH net-next 02/11] bridge: add bridge_flags_bit enum
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,blackwall.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290433-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8B45C5A6D62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We want to use atomic operations for lockless p->flags changes
and reads.

Add definitions for bits in addition of masks so that we can use
test_bit(), clear_bit() and set_bit() in subsequent patches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/if_bridge.h | 78 ++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index ec9ffea1e46ede3762f108f6e7085ebb1bf1d2e1..75673b8bffcb8ad6396e6a05b8af8150208fb6fe 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -36,32 +36,60 @@ struct br_ip_list {
 	struct br_ip addr;
 };
 
-#define BR_HAIRPIN_MODE		BIT(0)
-#define BR_BPDU_GUARD		BIT(1)
-#define BR_ROOT_BLOCK		BIT(2)
-#define BR_MULTICAST_FAST_LEAVE	BIT(3)
-#define BR_ADMIN_COST		BIT(4)
-#define BR_LEARNING		BIT(5)
-#define BR_FLOOD		BIT(6)
+enum bridge_flags_bit {
+	BR_HAIRPIN_MODE_BIT,
+	BR_BPDU_GUARD_BIT,
+	BR_ROOT_BLOCK_BIT,
+	BR_MULTICAST_FAST_LEAVE_BIT,
+	BR_ADMIN_COST_BIT,
+	BR_LEARNING_BIT,
+	BR_FLOOD_BIT,
+	BR_PROMISC_BIT,
+	BR_PROXYARP_BIT,
+	BR_LEARNING_SYNC_BIT,
+	BR_PROXYARP_WIFI_BIT,
+	BR_MCAST_FLOOD_BIT,
+	BR_MULTICAST_TO_UNICAST_BIT,
+	BR_VLAN_TUNNEL_BIT,
+	BR_BCAST_FLOOD_BIT,
+	BR_NEIGH_SUPPRESS_BIT,
+	BR_ISOLATED_BIT,
+	BR_MRP_AWARE_BIT,
+	BR_MRP_LOST_CONT_BIT,
+	BR_MRP_LOST_IN_CONT_BIT,
+	BR_TX_FWD_OFFLOAD_BIT,
+	BR_PORT_LOCKED_BIT,
+	BR_PORT_MAB_BIT,
+	BR_NEIGH_VLAN_SUPPRESS_BIT,
+	BR_NEIGH_FORWARD_GRAT_BIT,
+};
+
+#define BR_HAIRPIN_MODE		BIT(BR_HAIRPIN_MODE_BIT)
+#define BR_BPDU_GUARD		BIT(BR_BPDU_GUARD_BIT)
+#define BR_ROOT_BLOCK		BIT(BR_ROOT_BLOCK_BIT)
+#define BR_MULTICAST_FAST_LEAVE	BIT(BR_MULTICAST_FAST_LEAVE_BIT)
+#define BR_ADMIN_COST		BIT(BR_ADMIN_COST_BIT)
+#define BR_LEARNING		BIT(BR_LEARNING_BIT)
+#define BR_FLOOD		BIT(BR_FLOOD_BIT)
 #define BR_AUTO_MASK		(BR_FLOOD | BR_LEARNING)
-#define BR_PROMISC		BIT(7)
-#define BR_PROXYARP		BIT(8)
-#define BR_LEARNING_SYNC	BIT(9)
-#define BR_PROXYARP_WIFI	BIT(10)
-#define BR_MCAST_FLOOD		BIT(11)
-#define BR_MULTICAST_TO_UNICAST	BIT(12)
-#define BR_VLAN_TUNNEL		BIT(13)
-#define BR_BCAST_FLOOD		BIT(14)
-#define BR_NEIGH_SUPPRESS	BIT(15)
-#define BR_ISOLATED		BIT(16)
-#define BR_MRP_AWARE		BIT(17)
-#define BR_MRP_LOST_CONT	BIT(18)
-#define BR_MRP_LOST_IN_CONT	BIT(19)
-#define BR_TX_FWD_OFFLOAD	BIT(20)
-#define BR_PORT_LOCKED		BIT(21)
-#define BR_PORT_MAB		BIT(22)
-#define BR_NEIGH_VLAN_SUPPRESS	BIT(23)
-#define BR_NEIGH_FORWARD_GRAT	BIT(24)
+#define BR_PROMISC		BIT(BR_PROMISC_BIT)
+#define BR_PROXYARP		BIT(BR_PROXYARP_BIT)
+#define BR_LEARNING_SYNC	BIT(BR_LEARNING_SYNC_BIT)
+#define BR_PROXYARP_WIFI	BIT(BR_PROXYARP_WIFI_BIT)
+#define BR_MCAST_FLOOD		BIT(BR_MCAST_FLOOD_BIT)
+#define BR_MULTICAST_TO_UNICAST	BIT(BR_MULTICAST_TO_UNICAST_BIT)
+#define BR_VLAN_TUNNEL		BIT(BR_VLAN_TUNNEL_BIT)
+#define BR_BCAST_FLOOD		BIT(BR_BCAST_FLOOD_BIT)
+#define BR_NEIGH_SUPPRESS	BIT(BR_NEIGH_SUPPRESS_BIT)
+#define BR_ISOLATED		BIT(BR_ISOLATED_BIT)
+#define BR_MRP_AWARE		BIT(BR_MRP_AWARE_BIT)
+#define BR_MRP_LOST_CONT	BIT(BR_MRP_LOST_CONT_BIT)
+#define BR_MRP_LOST_IN_CONT	BIT(BR_MRP_LOST_IN_CONT_BIT)
+#define BR_TX_FWD_OFFLOAD	BIT(BR_TX_FWD_OFFLOAD_BIT)
+#define BR_PORT_LOCKED		BIT(BR_PORT_LOCKED_BIT)
+#define BR_PORT_MAB		BIT(BR_PORT_MAB_BIT)
+#define BR_NEIGH_VLAN_SUPPRESS	BIT(BR_NEIGH_VLAN_SUPPRESS_BIT)
+#define BR_NEIGH_FORWARD_GRAT	BIT(BR_NEIGH_FORWARD_GRAT_BIT)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
-- 
2.54.0.669.g59709faab0-goog


