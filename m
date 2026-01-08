Return-Path: <netdev+bounces-248085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4096D03399
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 15:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4361E30FE318
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08946BBEF;
	Thu,  8 Jan 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HemLxOc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6765468BBD
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879419; cv=none; b=qsUoQ3/R5WIz66/njO8LdR9eOBUm330MCb38bif2lmlyrj+X4oSxcZUsUhfOiqjNa0HFwErjK+kSoOhO3XWFcTrj9xYw/M65cGuTyi6bgIq8xWw6TjDxd9Dqs5RPgjVFw2dIHiQtrg5bP/TapFXhANuCuj6m8V+HTgXT51jRDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879419; c=relaxed/simple;
	bh=70la4h6ovUa/QMYQ7a11tH+NWBKh6VekFoLr40Sjxmc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rp41Kwkfzttk9bi+VZH3B6aDUJVxAkLcSfr3UGSebUJVvn8LfQ3p3dt9/Y5HD+J32vfKuh8w3xQrRfzF3+zFApT05h2EYNn9dlQUwM6DdCgcQBamhEJ+52vommF4ulVnx8VgIBCSlCCYY0IxjLp1ns+iKLbb1nUYyuYwu3/1380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HemLxOc6; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8888447ffebso80064086d6.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 05:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767879416; x=1768484216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7AGCvHbq1UmxMADF5TvdyQczicdBjzxKaZGSfPhxY60=;
        b=HemLxOc6iIm0galixntiqPstLAY05p41qO1VXHg8nttyMYIAjIgS95idb2BurIShNp
         Dq3Ic2v99iadfP2D47XMU124675o3wxgHUYiXBPXDxB8eBnLhiE9rDX9JGENQsfrFWYz
         EnjkozhDUJDSY4/CSxShh6tNv7pGm/9QvjtGKrpaSwEefgnLVzRyICBIJlQXkhT+Z/77
         ilvTVpXSkJAD+4wXGclQzQeXqCkww2mzek0ve6HkdiiiFGgq0LkEyQPnJZyiXtBDcAae
         iD6k5NW/gespEJ1htcjlVmZAW83aouIQPVIqAtqVJjW2ZrONcGOHYaAp12HG000LBxNe
         7cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767879416; x=1768484216;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AGCvHbq1UmxMADF5TvdyQczicdBjzxKaZGSfPhxY60=;
        b=LvwGvuWo+JEz5wQP+jlQKvSQqyHHs2R6HhW8IQIP72NmUzrv/O7L4AKFJYfxL1uOot
         BCCQQfcO9jZZVic7A+PUH8bVAuGlSIvIeadRbWskUm4/I5Le6yMcSRB9vNZ8JU9y+9pR
         lDrKjP1tsD6yyHNnL2fgV/q5Yii1wP0kqfSJdRqnamkPWNrAgO2OKwfOZrx/j8HljU+2
         gt9+FRLULhJPun/s7YAY733xbiWUTAjWR5uBdDXQwD48LV6nP0l3XV4BCVI5Kf13aP1D
         1lPxo/ajoiQiX8OqdlLxEDFRW01YgusI4VbvMMbUeBngw4WUwR/LCTRUFvH5yilVJw5m
         RsKg==
X-Forwarded-Encrypted: i=1; AJvYcCWvMINl8lYaQ080Dj+YcfXhtUS7prPJrQ23HAXSaz1lVWpM0OdKVsoW/hDv8NZpnIF9kIUkEug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOKhfNBkbcDyil+LaZXOQDJVpPC9qoA//sCQgfKbVcp5tdkLL
	8hYYCkW76KjcoXL8QHXOqUVSw/8Bt8Z/J6auYyc0wG3PQFF3QXw1ZO+VKqdbZex+eEMbYt5BedI
	Sp1Eitm/bSxK3Sg==
X-Google-Smtp-Source: AGHT+IG6ZIrSnagFS7ddBVe+LOieYOWZ30MHB9QuSGOxvlAkCuwtyuUYB1mdCD+YEe9IL4U+ihBAjVbmQdwd8w==
X-Received: from qvbnc4.prod.google.com ([2002:a05:6214:2dc4:b0:88a:37b0:9b69])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:d0f:b0:88a:2f7f:e936 with SMTP id 6a1803df08f44-89084185816mr96005656d6.2.1767879416429;
 Thu, 08 Jan 2026 05:36:56 -0800 (PST)
Date: Thu,  8 Jan 2026 13:36:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108133651.1130486-1-edumazet@google.com>
Subject: [PATCH] macvlan: fix possible UAF in macvlan_forward_source()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Add RCU protection on (struct macvlan_source_entry)->vlan.

Whenever macvlan_hash_del_source() is called, we must clear
entry->vlan pointer before RCU grace period starts.

This allows macvlan_forward_source() to skip over
entries queued for freeing.

Note that macvlan_dev are already RCU protected, as they
are embedded in a standard netdev (netdev_priv(ndev)).

Fixes: 79cf79abce71 ("macvlan: add source mode")
Reported-by: syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com
https://lore.kernel.org/netdev/695fb1e8.050a0220.1c677c.039f.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/macvlan.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 7966545512cfeab3914374675bafa3847e5d7ae1..b4df7e184791d0fe0a60c17522b91b2766847b37 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -59,7 +59,7 @@ struct macvlan_port {
 
 struct macvlan_source_entry {
 	struct hlist_node	hlist;
-	struct macvlan_dev	*vlan;
+	struct macvlan_dev __rcu *vlan;
 	unsigned char		addr[6+2] __aligned(sizeof(u16));
 	struct rcu_head		rcu;
 };
@@ -146,7 +146,7 @@ static struct macvlan_source_entry *macvlan_hash_lookup_source(
 
 	hlist_for_each_entry_rcu(entry, h, hlist, lockdep_rtnl_is_held()) {
 		if (ether_addr_equal_64bits(entry->addr, addr) &&
-		    entry->vlan == vlan)
+		    rcu_access_pointer(entry->vlan) == vlan)
 			return entry;
 	}
 	return NULL;
@@ -168,7 +168,7 @@ static int macvlan_hash_add_source(struct macvlan_dev *vlan,
 		return -ENOMEM;
 
 	ether_addr_copy(entry->addr, addr);
-	entry->vlan = vlan;
+	RCU_INIT_POINTER(entry->vlan, vlan);
 	h = &port->vlan_source_hash[macvlan_eth_hash(addr)];
 	hlist_add_head_rcu(&entry->hlist, h);
 	vlan->macaddr_count++;
@@ -187,6 +187,7 @@ static void macvlan_hash_add(struct macvlan_dev *vlan)
 
 static void macvlan_hash_del_source(struct macvlan_source_entry *entry)
 {
+	RCU_INIT_POINTER(entry->vlan, NULL);
 	hlist_del_rcu(&entry->hlist);
 	kfree_rcu(entry, rcu);
 }
@@ -390,7 +391,7 @@ static void macvlan_flush_sources(struct macvlan_port *port,
 	int i;
 
 	hash_for_each_safe(port->vlan_source_hash, i, next, entry, hlist)
-		if (entry->vlan == vlan)
+		if (rcu_access_pointer(entry->vlan) == vlan)
 			macvlan_hash_del_source(entry);
 
 	vlan->macaddr_count = 0;
@@ -433,9 +434,14 @@ static bool macvlan_forward_source(struct sk_buff *skb,
 
 	hlist_for_each_entry_rcu(entry, h, hlist) {
 		if (ether_addr_equal_64bits(entry->addr, addr)) {
-			if (entry->vlan->flags & MACVLAN_FLAG_NODST)
+			struct macvlan_dev *vlan = rcu_dereference(entry->vlan);
+
+			if (!vlan)
+				continue;
+
+			if (vlan->flags & MACVLAN_FLAG_NODST)
 				consume = true;
-			macvlan_forward_source_one(skb, entry->vlan);
+			macvlan_forward_source_one(skb, vlan);
 		}
 	}
 
@@ -1680,7 +1686,7 @@ static int macvlan_fill_info_macaddr(struct sk_buff *skb,
 	struct macvlan_source_entry *entry;
 
 	hlist_for_each_entry_rcu(entry, h, hlist, lockdep_rtnl_is_held()) {
-		if (entry->vlan != vlan)
+		if (rcu_access_pointer(entry->vlan) != vlan)
 			continue;
 		if (nla_put(skb, IFLA_MACVLAN_MACADDR, ETH_ALEN, entry->addr))
 			return 1;
-- 
2.52.0.351.gbe84eed79e-goog


