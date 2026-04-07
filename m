Return-Path: <netdev+bounces-276033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC7pHSIf1Wnr0wcAu9opvQ
	(envelope-from <netdev+bounces-276033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:13:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76E3B0BB6
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D5C1301F314
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E1535B64B;
	Tue,  7 Apr 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpZiy1Xi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B335B136
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574434; cv=none; b=ABQ53pcCmXzdfbQxcagcykPaP3M++OATRfBWHjv9duVPkpoSUU9ZMyn59TO25vnzcfVnQX51Cs04L2g4whKzNJJL7Q215whRjjRS3zFRjgyJ0Ak9q19ITJCEHKVHiZcUDDcSVmqirfU7PkrWyiW46CD3+Xh+xVl3wqLBlwwdHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574434; c=relaxed/simple;
	bh=gdER/6OULvsHn8TjbdvmJd78aZW+yw6qSfBk0jPd4Ek=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Iq5YNzG20psUuQOuISkPEbrZ8NJytRLUVh8hx3eC9MPa0zOiA0njZXuJu7bKwLjNFET8El2pO8HMD4MVVkSuf/Jz1fmTgwwN1ccfL+IvfRPkmnii2gJjOSO5VwhFhiR8SDdWZRqzzqxo6CqD5/zm3Mr/72IRKzqgT4WFwgcQthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpZiy1Xi; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8d654ade33aso605895185a.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775574432; x=1776179232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CvMBNPwZyqJfkJ+zvD6khbqwEeZoD6/qBzLltGAppBk=;
        b=tpZiy1XiX9Z6jHDNydZWutiMhEQZJWtzjwtHfZHMK+XWLYeYhrmqCjgqqSntL8y9GA
         bBgpsrfcZc69exp/GUu9zP6IYPLpICiGOVPSoptfhTu5rNq3lCRafh6IKOK9rh+2CtOx
         Rs6qWISY4gY6dVC6W+4xyPrcYwrG6oIaaXRUt9pxFBdOYpjHxIIKAUaKmpg6JSbVtMzZ
         RwCSZ/k5uq1+9H0sLxWTe+JOEnTojFcLemsX+7BUT37+/q7HWHJZ5mF3tcILZynUJk50
         AQKoZ8TY2HaThzua13qZE1ggEXQXHfBDZZwb8zwaZzLLtVh+Qs/MWkr+dWCHd6vI0wrt
         N36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775574432; x=1776179232;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvMBNPwZyqJfkJ+zvD6khbqwEeZoD6/qBzLltGAppBk=;
        b=B5V/kIgoZEkMs0VFMUdyjwIoiNBPmz9VtG0eHYmPDMb1jCjqEXkeW+qDQJsvLJzJwF
         kqD+i9mPnO74ZPnOd2S08z609zMIQ2Ckt2s8M+IiwIhakHb/kFDqVz6/z4QcMvdKe511
         AUty5YR2BkezUV+GklhRSpvq1jz8D2cuvaNvWs58P51esKmj/2BmTPE1doNRcuHKzS8n
         UWUpNzeHigaXpfbHgVEPspDTDkmrR3RJzwqvE8mBH0lkx5J5sp0ls7j9oPqaOiyEtJ6K
         p1jPEiExjQUt+RowqGa4yNL5kvLwGPHxFDcvCS+Tgh7KTii+18W3BO+hJ421DnslFHwg
         BaBA==
X-Forwarded-Encrypted: i=1; AJvYcCVjHdTVRkzj+eQutF2DT0i7MfJvV9sIQMrFhMKYjaGMbHSuyVBetOIeX9W1nAiJ4aqMqSTSUb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdiwuqBMe9lVKF9pm3FV31stdwez8l+z5Bj9j/0nyJfZFRs4B
	MpHbug2/innsbAjdHOgu+/mX6sbmEWAeUzd8NzP0Ha8IE/8JYCdGGHxqo5blhUZsStouxK3Ng80
	5zsr+qAd+nChgVg==
X-Received: from qkll4.prod.google.com ([2002:a05:620a:2104:b0:8d3:a833:677f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:459f:b0:8d8:ed00:5a91 with SMTP id af79cd13be357-8d8ed006106mr753830985a.22.1775574432006;
 Tue, 07 Apr 2026 08:07:12 -0700 (PDT)
Date: Tue,  7 Apr 2026 15:07:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407150710.1640747-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net: dropreason: add MACVLAN_BROADCAST_BACKLOG
 and IPVLAN_MULTICAST_BACKLOG
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Joe Damato <joe@dama.to>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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
	FREEMAIL_CC(0.00)[kernel.org,dama.to,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276033-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF76E3B0BB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipvlan and macvlan use queues to process broadcast/multicast packets
from a work queue.

Under attack these queues can drop packets.

Add MACVLAN_BROADCAST_BACKLOG drop_reason for macvlan broadcast queue.

Add IPVLAN_MULTICAST_BACKLOG drop_reason for ipvlan multicast queue.

Use different reasons as some deployments use both ipvlan and macvlan.

Also change ipvlan_rcv_frame() to use SKB_DROP_REASON_DEV_READY
when the device is not UP.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ipvlan/ipvlan_core.c |  4 ++--
 drivers/net/macvlan.c            |  2 +-
 include/net/dropreason-core.h    | 12 ++++++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 68fdb42068d0060c67d751b869a059e8cb1b6bd1..5131d722c476eaa6149c114bcfc7267ea31d7242 100644
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
+		kfree_skb_reason(skb, SKB_DROP_REASON_IPVLAN_MULTICAST_BACKLOG);
 	}
 }
 
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 54c514acacc5e24fcdb88904f41fd1d29b1e34d0..9f90c598649d548ee12b0a9806c825f96a4a4d63 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -386,7 +386,7 @@ static void macvlan_broadcast_enqueue(struct macvlan_port *port,
 	return;
 
 free_nskb:
-	kfree_skb(nskb);
+	kfree_skb_reason(nskb, SKB_DROP_REASON_MACVLAN_BROADCAST_BACKLOG);
 err:
 	dev_core_stats_rx_dropped_inc(skb->dev);
 }
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index de61dd5dbfd9dc7d91d22d79a510d42fb69eb60a..5ad4a34b527486d3302238634f5a1a0af26db3db 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -69,6 +69,8 @@
 	FN(QDISC_DROP)			\
 	FN(QDISC_BURST_DROP)		\
 	FN(CPU_BACKLOG)			\
+	FN(MACVLAN_BROADCAST_BACKLOG)		\
+	FN(IPVLAN_MULTICAST_BACKLOG)		\
 	FN(XDP)				\
 	FN(TC_INGRESS)			\
 	FN(UNHANDLED_PROTO)		\
@@ -382,6 +384,16 @@ enum skb_drop_reason {
 	 * netdev_max_backlog in net.rst) or RPS flow limit
 	 */
 	SKB_DROP_REASON_CPU_BACKLOG,
+	/**
+	 * @SKB_DROP_REASON_MACVLAN_BROADCAST_BACKLOG: failed to enqueue the skb
+	 * to macvlan broadcast queue.
+	 */
+	SKB_DROP_REASON_MACVLAN_BROADCAST_BACKLOG,
+	/**
+	 * @SKB_DROP_REASON_IPVLAN_MULTICAST_BACKLOG: failed to enqueue the skb
+	 * to ipvlan multicast queue.
+	 */
+	SKB_DROP_REASON_IPVLAN_MULTICAST_BACKLOG,
 	/** @SKB_DROP_REASON_XDP: dropped by XDP in input path */
 	SKB_DROP_REASON_XDP,
 	/** @SKB_DROP_REASON_TC_INGRESS: dropped in TC ingress HOOK */
-- 
2.53.0.1213.gd9a14994de-goog


