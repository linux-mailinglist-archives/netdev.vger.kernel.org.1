Return-Path: <netdev+bounces-274044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAbAEGn3zGl9YQYAu9opvQ
	(envelope-from <netdev+bounces-274044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:46:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1EA378BD1
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87142306E3F6
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1073F2114;
	Wed,  1 Apr 2026 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tv6wqF4s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f202.google.com (mail-vk1-f202.google.com [209.85.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE23E51E9
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039895; cv=none; b=fuKKvqaWyjTriwZNMZSkeXn+6p9yl+/WEqU3PQnBfOmSMWMncrv6nvIBgy1BYr6oim8VyPzDvW2WZbVtk1b0e224b6TEeMSzNme4D8+u3jEOSDeOkV4lw0Sr5hJPDilecQk8v1NR/+o371tVf5Y1ghK8AzB+DIV6Nqr3Yavk5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039895; c=relaxed/simple;
	bh=UEo1OxQQp9qEwVklr5nj37H8J6+EvQSh4aOHHxh78BQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tvA5nCaVjgOz9Hc3eGNxs2xwAcjSVZv4yI3iOxxsTC3nUH2iyD51EdP7q64kvgs+sOnwUKcUp4MSDW6G1yr+piV78YPvdv1B9Dh53uBtN64wbfYB8SdJRR/f/bqWw1PHrkMehSk5XUAwWSjCDRQYWT//YUqDJkc8gOOeUi/bp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tv6wqF4s; arc=none smtp.client-ip=209.85.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vk1-f202.google.com with SMTP id 71dfb90a1353d-56ce17e1f56so4783459e0c.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775039893; x=1775644693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0Hyewzxu67CUXeMaFrVLjvccJ0qkwYSNWXMKp/M5s8=;
        b=Tv6wqF4s9F9LapA+AcUVUPK1rHZ1/ks41wEp7ODrNq3FWyS/EX5EeJIqiJgd82k/HN
         lf5fHpbQddhvpZn1BIXTwI+oa0SmsN/D6y+8F7tw9+t3yqGh2D4f/x518aE1wrD7fZP6
         wu7xuO36eT6UpoRHPazh8awrqVj918Ox88gGgVtzftaEvzciwz4B9EUjYkGmgwkpl4LI
         I61Rr9U1qMrmjEkR8eFNq3N/YHIa5VrRBbfihZa3ZIWldEuAPbTqpFqI30zA9Cie6Qzi
         PP7mBs/hajJ/OHjl++B2jYZ/6jMTV7bzbZadiMm6KaJSwYHG0Q13cDdkjFsfQIT6hpQe
         NrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775039893; x=1775644693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0Hyewzxu67CUXeMaFrVLjvccJ0qkwYSNWXMKp/M5s8=;
        b=MTzUszp09tEb0tL0+8tfZhPFl/0OJMQf3E2wqnL1KiidgK79+4R5MaPsQ8t8O4UA6o
         7ZXRDjTlkSJtCDlP8xSFwrsdemh46KnMmmWu7MQCvAo3kFe6UU9/YxRZlO/eBTWIfrqw
         L4F8SbjjcBsxe/zARmK2p9HTVL000Ov+GdBSsi+011XjNaJJzyiir8RcJi5FKe4Z+EHa
         LkRA8I6gcmLmH1y60G28752FB1aeYtmLDVt3FI04PN9lG7bbZsQmDWVNcSQWBCIULHfk
         7IOXGsB5avPpqJtjf3/jkjeZOp/NbgIqId2NlGw7Ij9p0g8QdLSbtkWmp/mcVb/NaawB
         l1mA==
X-Forwarded-Encrypted: i=1; AJvYcCV7TSB8M/I8V4pYoz4QMZixdVH5bITze+3Ma6wuUFquYFLU7yfnL3oK4s6oqx4MJY1qF4c+ZK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztTfVd8piYN7+GnS8TeoFR+nhRMr4eNMndNswtqqLg655h5U8s
	kmcok5GA12TIKQoj3IFAhDDVr55Bo9qLzwmbX3VeuqvNC0C6PwiQVObcuJack86oUCls6BvJYEQ
	P+VgcdXyXH1iNYw==
X-Received: from uagh30.prod.google.com ([2002:a05:6130:11e:b0:953:9a8e:2199])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:5e97:b0:602:7a74:fbbe with SMTP id ada2fe7eead31-60567e492femr895456137.9.1775039893400;
 Wed, 01 Apr 2026 03:38:13 -0700 (PDT)
Date: Wed,  1 Apr 2026 10:38:08 +0000
In-Reply-To: <20260401103809.3038139-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401103809.3038139-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401103809.3038139-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] macvlan: annotate data-races around port->bc_queue_len_used
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274044-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF1EA378BD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

port->bc_queue_len_used is read and written locklessly,
add READ_ONCE()/WRITE_ONCE() annotations.

While WRITE_ONCE() in macvlan_fill_info() is not yet needed,
it is a prereq for future RTNL avoidance.

Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/macvlan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index ea22909cb09de43fbf26b16144430b4d6687de3e..bbb5c32541f996fdf97caa19d2c6d99e5c994a3d 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -356,6 +356,7 @@ static void macvlan_broadcast_enqueue(struct macvlan_port *port,
 				      const struct macvlan_dev *src,
 				      struct sk_buff *skb)
 {
+	u32 bc_queue_len_used = READ_ONCE(port->bc_queue_len_used);
 	struct sk_buff *nskb;
 	int err = -ENOMEM;
 
@@ -366,7 +367,7 @@ static void macvlan_broadcast_enqueue(struct macvlan_port *port,
 	MACVLAN_SKB_CB(nskb)->src = src;
 
 	spin_lock(&port->bc_queue.lock);
-	if (skb_queue_len(&port->bc_queue) < port->bc_queue_len_used) {
+	if (skb_queue_len(&port->bc_queue) < bc_queue_len_used) {
 		if (src)
 			dev_hold(src->dev);
 		__skb_queue_tail(&port->bc_queue, nskb);
@@ -1731,7 +1732,8 @@ static int macvlan_fill_info(struct sk_buff *skb,
 	}
 	if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN, vlan->bc_queue_len_req))
 		goto nla_put_failure;
-	if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN_USED, port->bc_queue_len_used))
+	if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN_USED,
+			READ_ONCE(port->bc_queue_len_used)))
 		goto nla_put_failure;
 	if (port->bc_cutoff != 1 &&
 	    nla_put_s32(skb, IFLA_MACVLAN_BC_CUTOFF, port->bc_cutoff))
@@ -1791,7 +1793,7 @@ static void update_port_bc_queue_len(struct macvlan_port *port)
 		if (vlan->bc_queue_len_req > max_bc_queue_len_req)
 			max_bc_queue_len_req = vlan->bc_queue_len_req;
 	}
-	port->bc_queue_len_used = max_bc_queue_len_req;
+	WRITE_ONCE(port->bc_queue_len_used, max_bc_queue_len_req);
 }
 
 static int macvlan_device_event(struct notifier_block *unused,
-- 
2.53.0.1118.gaef5881109-goog


