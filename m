Return-Path: <netdev+bounces-303543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lqOcFGDORGq31AoAu9opvQ
	(envelope-from <netdev+bounces-303543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:22:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF26EB0BA
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:22:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IZanTQ+u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303543-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303543-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9263F3014C62
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6D63A1A3C;
	Wed,  1 Jul 2026 08:22:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E139182F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:22:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894144; cv=none; b=KkSufhIPDQ9oUCCaddyfNGw+ecCheUW9YKJJDKaxMuAiBbU4LgAwRQ9rymDiJVrRhXH7rien5BmJGmLFoZUDIws+PDIp94PUU9IXfp5sZZMy+P1Iet/Vj87toFHqzZBQn5xCtBBArdn4ruKb+kbPJ0w4t5YiyIVF3hxuhwVn32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894144; c=relaxed/simple;
	bh=tdp3p9Ya6jFblHE70d3MaHnBcVV3gQV0eq40vRAZfB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VEezkg7yE54SsLX7VtzOkzq52WTAnVo33eqR456cxR6Bq+M9Y5AiI3dxulE5q6fP8qSwMuAhpIHpC3vKV5ZtL3xDZM/dmNOTaeFj6Th3kBt0cJ3IlmWzpa7s9CKj3U/Jdd7YpBMqBBlS8+yT0HcdFeqcRh0H507mr8STRD93PIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZanTQ+u; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-51c20762d21so4386051cf.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 01:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782894140; x=1783498940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXRribuTUhkxLCWsUr25B2D8LvbDNvH+aRUNvKRnVG8=;
        b=IZanTQ+ubXNN/En3JQnwbkAv3ybDxh9pP5uFCbpzgzhJVIgZm+gswO8sOb1BJk5Kn0
         z3mTU15XRLDVfsRvmzgB52MfISQ3TkYVovkExJaJVSaCIPDlK8JTHMZmXu32SCrGuoHc
         iZh1eKlQwgmvvJM9NSM09dw2u+B3CbiMtFOTyGcsIcDHQLkPYeE5f/I/h3Kkhs56pgCD
         gmrjah2/1HIMCuMWzXdijKfr8/MMXWqazIeuxUsvQhNxmGlwbBfLLNLKYEVgaxvCjeqP
         pYITfVppmROsJWmq5aJUGv5ZVOpB1ueqVaxex4Qk8T3D3cijuei6hXmyqzhZdWPqTQnj
         xCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782894140; x=1783498940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXRribuTUhkxLCWsUr25B2D8LvbDNvH+aRUNvKRnVG8=;
        b=b2bHB3zIYlTCXl778srvBaA8He6BjE4L6pZbJSP/TyhSOUhwKjdujVwMkJ651TeFlE
         yQQ6eLV4wKrSpGIKUGDXzwRnmj4+bN0qmQGbAmlgLIOCQcOreyRuONSlXQsixAoILz9n
         uiLGXGQtoqdEcY5YCpH+hlIX6XJtDNGlUt7m1fMkgunZKbAHV4Ov4BWoK8CkjBUqfbFj
         Bf19r812fVYcAd8Cz6dozOWymhVO/ysVrC/nlv91gQsMvybVOOXz/IJJKkGxqMuQzIvX
         6Ca3AeNRsH3CebN3WaSN2owLzEnlnMzfTSkfKgBAfWz+gNWavwn7klfnFfoQWOTdkdk+
         Mv+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+ezGXXGi8gozdLrnrxg+//8C1AkpIoQSSmsDLoVAn10SuMyae/W5ljebCtkwJmA/u/kp651cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIEDUrC4tpNy+3mpRJ6xmC+GMHBiEZXNs+eQEiYzt0MgeDGQpJ
	v1179MXkbR5uZrXE9XnI6tD1Cv8paE8+jvZFwT61dbbH/gfxK4/r9leb0I3ngIK9eQKKnLxC0nB
	DrooQcSzCcu3X5w==
X-Received: from qtbhe5.prod.google.com ([2002:a05:622a:6005:b0:517:8e0d:a114])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2485:b0:51c:1ec5:d0f with SMTP id d75a77b69052e-51c26b005d2mr7683211cf.40.1782894139437;
 Wed, 01 Jul 2026 01:22:19 -0700 (PDT)
Date: Wed,  1 Jul 2026 08:22:14 +0000
In-Reply-To: <20260701082214.2974946-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701082214.2974946-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701082214.2974946-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] macvlan: no longer rely on RTNL in macvlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303543-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEEF26EB0BA

Add READ_ONCE()/WRITE_ONCE() annotations on vlan->mode, vlan->flags,
vlan->bc_queue_len_req and port->bc_cutoff.

Fill IFLA_MACVLAN_MACADDR_DATA nested attribute and compute
on the fly the precise number of elements we put in it,
to fill an accurate IFLA_MACVLAN_MACADDR_COUNT attribute
as some user space applications could depend on its value
and the attributes order.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/macvlan.c | 71 +++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 8b69cc9b70f98d7991110f5eda76d58d5d96fa81..9a4bc99dbf53b5f2cd6345f0af899f56fdb3a46b 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -171,7 +171,7 @@ static int macvlan_hash_add_source(struct macvlan_dev *vlan,
 	RCU_INIT_POINTER(entry->vlan, vlan);
 	h = &port->vlan_source_hash[macvlan_eth_hash(addr)];
 	hlist_add_head_rcu(&entry->hlist, h);
-	vlan->macaddr_count++;
+	WRITE_ONCE(vlan->macaddr_count, vlan->macaddr_count + 1);
 
 	return 0;
 }
@@ -402,7 +402,7 @@ static void macvlan_flush_sources(struct macvlan_port *port,
 		if (rcu_access_pointer(entry->vlan) == vlan)
 			macvlan_hash_del_source(entry);
 
-	vlan->macaddr_count = 0;
+	WRITE_ONCE(vlan->macaddr_count, 0);
 }
 
 static void macvlan_forward_source_one(struct sk_buff *skb,
@@ -874,7 +874,7 @@ static void update_port_bc_cutoff(struct macvlan_dev *vlan, int cutoff)
 	if (vlan->port->bc_cutoff == cutoff)
 		return;
 
-	vlan->port->bc_cutoff = cutoff;
+	WRITE_ONCE(vlan->port->bc_cutoff, cutoff);
 	macvlan_recompute_bc_filter(vlan);
 }
 
@@ -1427,7 +1427,7 @@ static int macvlan_changelink_sources(struct macvlan_dev *vlan, u32 mode,
 		entry = macvlan_hash_lookup_source(vlan, addr);
 		if (entry) {
 			macvlan_hash_del_source(entry);
-			vlan->macaddr_count--;
+			WRITE_ONCE(vlan->macaddr_count, vlan->macaddr_count - 1);
 		}
 	} else if (mode == MACVLAN_MACADDR_FLUSH) {
 		macvlan_flush_sources(vlan->port, vlan);
@@ -1653,7 +1653,8 @@ static int macvlan_changelink(struct net_device *dev,
 	}
 
 	if (data && data[IFLA_MACVLAN_BC_QUEUE_LEN]) {
-		vlan->bc_queue_len_req = nla_get_u32(data[IFLA_MACVLAN_BC_QUEUE_LEN]);
+		WRITE_ONCE(vlan->bc_queue_len_req,
+			   nla_get_u32(data[IFLA_MACVLAN_BC_QUEUE_LEN]));
 		update_port_bc_queue_len(vlan->port);
 	}
 
@@ -1676,10 +1677,12 @@ static int macvlan_changelink(struct net_device *dev,
 
 static size_t macvlan_get_size_mac(const struct macvlan_dev *vlan)
 {
-	if (vlan->macaddr_count == 0)
+	unsigned int macaddr_count = READ_ONCE(vlan->macaddr_count);
+
+	if (!macaddr_count)
 		return 0;
 	return nla_total_size(0) /* IFLA_MACVLAN_MACADDR_DATA */
-		+ vlan->macaddr_count * nla_total_size(sizeof(u8) * ETH_ALEN);
+		+ macaddr_count * nla_total_size(sizeof(u8) * ETH_ALEN);
 }
 
 static size_t macvlan_get_size(const struct net_device *dev)
@@ -1702,53 +1705,75 @@ static int macvlan_fill_info_macaddr(struct sk_buff *skb,
 				     const int i)
 {
 	struct hlist_head *h = &vlan->port->vlan_source_hash[i];
-	struct macvlan_source_entry *entry;
+	const struct macvlan_source_entry *entry;
+	int cnt = 0;
 
-	hlist_for_each_entry_rcu(entry, h, hlist, lockdep_rtnl_is_held()) {
+	hlist_for_each_entry_rcu(entry, h, hlist) {
 		if (rcu_access_pointer(entry->vlan) != vlan)
 			continue;
 		if (nla_put(skb, IFLA_MACVLAN_MACADDR, ETH_ALEN, entry->addr))
-			return 1;
+			return -EMSGSIZE;
+		cnt++;
 	}
-	return 0;
+	return cnt;
 }
 
 static int macvlan_fill_info(struct sk_buff *skb,
 				const struct net_device *dev)
 {
-	struct macvlan_dev *vlan = netdev_priv(dev);
+	const struct macvlan_dev *vlan = netdev_priv(dev);
 	struct macvlan_port *port = vlan->port;
-	int i;
-	struct nlattr *nest;
+	unsigned int macaddr_count = 0;
+	struct nlattr *nest, *attr;
+	int bc_cutoff, cnt, i;
 
-	if (nla_put_u32(skb, IFLA_MACVLAN_MODE, vlan->mode))
+	rcu_read_lock();
+	if (nla_put_u32(skb, IFLA_MACVLAN_MODE, READ_ONCE(vlan->mode)))
 		goto nla_put_failure;
-	if (nla_put_u16(skb, IFLA_MACVLAN_FLAGS, vlan->flags))
+
+	if (nla_put_u16(skb, IFLA_MACVLAN_FLAGS, READ_ONCE(vlan->flags)))
 		goto nla_put_failure;
-	if (nla_put_u32(skb, IFLA_MACVLAN_MACADDR_COUNT, vlan->macaddr_count))
+
+	attr = nla_reserve(skb, IFLA_MACVLAN_MACADDR_COUNT, sizeof(u32));
+	if (!attr)
 		goto nla_put_failure;
-	if (vlan->macaddr_count > 0) {
+
+	if (READ_ONCE(vlan->macaddr_count) > 0) {
 		nest = nla_nest_start_noflag(skb, IFLA_MACVLAN_MACADDR_DATA);
 		if (nest == NULL)
 			goto nla_put_failure;
 
 		for (i = 0; i < MACVLAN_HASH_SIZE; i++) {
-			if (macvlan_fill_info_macaddr(skb, vlan, i))
+			cnt = macvlan_fill_info_macaddr(skb, vlan, i);
+			if (cnt < 0)
 				goto nla_put_failure;
+			macaddr_count += cnt;
 		}
-		nla_nest_end(skb, nest);
+		if (!macaddr_count)
+			nla_nest_cancel(skb, nest);
+		else if (nla_nest_end_safe(skb, nest) < 0)
+			goto nla_put_failure;
 	}
-	if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN, vlan->bc_queue_len_req))
+	*(u32 *)nla_data(attr) = macaddr_count;
+
+	if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN,
+			READ_ONCE(vlan->bc_queue_len_req)))
 		goto nla_put_failure;
+
 	if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN_USED,
 			READ_ONCE(port->bc_queue_len_used)))
 		goto nla_put_failure;
-	if (port->bc_cutoff != 1 &&
-	    nla_put_s32(skb, IFLA_MACVLAN_BC_CUTOFF, port->bc_cutoff))
+
+	bc_cutoff = READ_ONCE(port->bc_cutoff);
+	if (bc_cutoff != 1 &&
+	    nla_put_s32(skb, IFLA_MACVLAN_BC_CUTOFF, bc_cutoff))
 		goto nla_put_failure;
+
+	rcu_read_unlock();
 	return 0;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


