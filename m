Return-Path: <netdev+bounces-274849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOc5L0Ilz2notAYAu9opvQ
	(envelope-from <netdev+bounces-274849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:26:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AFE3905E5
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02A29301AA5B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B606283FEF;
	Fri,  3 Apr 2026 02:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBzhwHD5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D9221F20
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183087; cv=none; b=oRgRXPrLt8SUdNTznP6cyUui/S2ziRsKgb43jhi8T/BGstmxlF48IgHv96uziXmn66qfHspyvNt2QoSH6Xy/aZF7YaCbPVhHb0qE80zTTzuqqZC8v4ELDvMx11SnVd6xKSgKp6KyKVN2YXJRaL//R3eKL5xScevDCJ9grp5Glzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183087; c=relaxed/simple;
	bh=qH9ZVbntPa1yOPR/SHkNxnXtjFglOR0zCRigoU2a0QA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kn9z99frXE73GwlWseHjj4NvEKahtcNP2JjWPbv45ukr/P5Ah6UlfCEw60NiKahQpvJrVETZp1IZlj6TJZ+tuN6VF2hMfCZZTybi2TqAzNtrbdMoGj8P59isv8c48XjGmXDAopCD4w0RCiEny7xO5PvWXJaI5sqrWZ0A7IWWiXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VBzhwHD5; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cd7de0e161so379449385a.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 19:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775183085; x=1775787885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UAdQlv0G7HIM6EoWFFTYSUi62qL0O79B/IGrB2C5wJ8=;
        b=VBzhwHD5+1CGD5Nb+h9rvBAvrdmKD/1dOxgW0pdb1TWw00u+eimUth1a6zNvKtP4GQ
         Qv7URyqrOsvQHVUV6BNJOIFNMlP1l/7wha0A3spPn1IAW94MYUufQdKlaHGTbR827o+6
         9erHwKxZxwCG9AKUYF9eeioieB2gOve+TWj3KWlDfNDDyG/RATU+eQlWL6D70YIcKwSn
         jvaIbVoq8Hbu7E/oL9DOK2gfXdJNFzsUaAEpSGCoj0iRfJpOtSMAN84hH7nNMxfA3yWN
         z7TzOJ2kp212nqU1OEC3hUp465M9cTm/DvKeDmALZ9wPeccsQHFpQJLavdRSd5LBc8Oy
         Q/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775183085; x=1775787885;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAdQlv0G7HIM6EoWFFTYSUi62qL0O79B/IGrB2C5wJ8=;
        b=d/Uz+GXZdkzTk2Q33gsG7fnxL01s+syjafDvTLtPpMXRIC0h2/VEG9e/lXF/Ytak6Z
         qxHETgCcZfzUlU82mlUuQfu/6B2XpoTnCg6G1j9VA6fdsHX2VsXnMo8q+RQ7CMg2Itpl
         z5I3e4Eft6jkoOpBQObUSqAfrq9yWcHmT5kwFhViZmhc13xyFfNV2wd7xjiB9oN87rvV
         ktavce/D0+1YSoHa1C5PosQoseOvTXDDcZ5u8lCIK2Mv39yuRLeVNAWcenqXhBEfyMms
         jY4qZeBJGpn7VUJIQU7p/kFH76j4dLRdqRhO6t2uGceGvtDPkWH48IxrdX9SRRMX5CeX
         wQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1GSKdS5YVOh826tAV0nM/1VzusVm/0ouXdDw0rTaqPoq/OlHY9aPpzr/q5ppwFcfCA+P3dmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ciaLk0Z97j7+m408Yu/65GqNn7URvySM+SmIMzL3vH+HOgKq
	nKlFXMP9MM42ZsoNAf1N6SXYznXC5b8FtXyOfq5efxFqnXbpbwCISRZA4US2D05g82OAPms36i9
	5ZuEBO9J0ZvX33A==
X-Received: from qkba12.prod.google.com ([2002:a05:620a:a38c:b0:8cf:c124:567c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1793:b0:8ca:2a02:dfd5 with SMTP id af79cd13be357-8d41cd9995cmr225011685a.30.1775183084751;
 Thu, 02 Apr 2026 19:24:44 -0700 (PDT)
Date: Fri,  3 Apr 2026 02:24:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403022443.3480770-1-edumazet@google.com>
Subject: [PATCH net-next] net: dropreason: add SKB_DROP_REASON_{BROAD,MULTI}CAST_BACKLOG
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lunn.ch,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274849-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24AFE3905E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipvlan and macvlan use queues to process broadcast or multicast packets
from a work queue.

Under attack these queues can drop packets.

Add BROADCAST_BACKLOG drop_reason for macvlan broadcast queue.

Add MULTICAST_BACKLOG drop_reason for ipvlan multicast queue.

Also change ipvlan_rcv_frame() to use SKB_DROP_REASON_DEV_READY
when the device is not UP.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ipvlan/ipvlan_core.c |  4 ++--
 drivers/net/macvlan.c            |  2 +-
 include/net/dropreason-core.h    | 12 ++++++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 68fdb42068d0060c67d751b869a059e8cb1b6bd1..162e08200012ef272d9b1aee09ab54e724c9bc71 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -337,7 +337,7 @@ static int ipvlan_rcv_frame(struct ipvl_addr *addr, struct sk_buff **pskb,
 	 */
 	if (local) {
 		if (unlikely(!(dev->flags & IFF_UP))) {
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 			goto out;
 		}
 
@@ -596,7 +596,7 @@ static void ipvlan_multicast_enqueue(struct ipvl_port *port,
 	} else {
 		spin_unlock(&port->backlog.lock);
 		dev_core_stats_rx_dropped_inc(skb->dev);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_MULTICAST_BACKLOG);
 	}
 }
 
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 54c514acacc5e24fcdb88904f41fd1d29b1e34d0..6c9f6fe3b5c08ae86a79af790fdbc6699aebf435 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -386,7 +386,7 @@ static void macvlan_broadcast_enqueue(struct macvlan_port *port,
 	return;
 
 free_nskb:
-	kfree_skb(nskb);
+	kfree_skb_reason(nskb, SKB_DROP_REASON_BROADCAST_BACKLOG);
 err:
 	dev_core_stats_rx_dropped_inc(skb->dev);
 }
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index de61dd5dbfd9dc7d91d22d79a510d42fb69eb60a..e81e7ae8b3271ba1a947104339bbc9e440f189f5 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -69,6 +69,8 @@
 	FN(QDISC_DROP)			\
 	FN(QDISC_BURST_DROP)		\
 	FN(CPU_BACKLOG)			\
+	FN(BROADCAST_BACKLOG)		\
+	FN(MULTICAST_BACKLOG)		\
 	FN(XDP)				\
 	FN(TC_INGRESS)			\
 	FN(UNHANDLED_PROTO)		\
@@ -382,6 +384,16 @@ enum skb_drop_reason {
 	 * netdev_max_backlog in net.rst) or RPS flow limit
 	 */
 	SKB_DROP_REASON_CPU_BACKLOG,
+	/**
+	 * @SKB_DROP_REASON_BROADCAST_BACKLOG: failed to enqueue the skb
+	 * to macvlan broadcast queue.
+	 */
+	SKB_DROP_REASON_BROADCAST_BACKLOG,
+	/**
+	 * @SKB_DROP_REASON_MULTICAST_BACKLOG: failed to enqueue the skb
+	 * to ipvlan multicast queue.
+	 */
+	SKB_DROP_REASON_MULTICAST_BACKLOG,
 	/** @SKB_DROP_REASON_XDP: dropped by XDP in input path */
 	SKB_DROP_REASON_XDP,
 	/** @SKB_DROP_REASON_TC_INGRESS: dropped in TC ingress HOOK */
-- 
2.53.0.1213.gd9a14994de-goog


