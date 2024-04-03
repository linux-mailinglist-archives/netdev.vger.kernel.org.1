Return-Path: <netdev+bounces-84437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D85896EF9
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9691C2106D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D7A4F613;
	Wed,  3 Apr 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JS03Y9jT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0374DA13
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147958; cv=none; b=Ta2/WmglN87SUA+ML1ssiOuwlX5Xb05013FrFUTFwgeVFRko6v8S11O399bdXGhzEhspIQDs6WAvOyDBXWtrJu2jvcm2JqwCno5CE0dJ38TvqJ3cIMbCcMIVbc0SWnTy9ZNC1j2u9hrTNzSRRoUzGz8FBC+XFK26onhJjGAJeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147958; c=relaxed/simple;
	bh=ZT/Ew9TqmFnIoGGZgKg6w0oDYH+NJMEZe2upUo/KRX4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SCSIhHIzytD4/oBOg9yfxUY1GWykUl8XH3VDNMFtE51pGDugILbTLNNNY2G6hQTlRy6JdNmwuF7aAoQyHQfCISN/UCo/snHIRTMjM9e0AkYhhsBAUJWx74sPOtDU9lSeJgz+oXgiLoESgQxs/YnpFbaI5IRZkwOiDri1puo5Gj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JS03Y9jT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd944567b6cso8409597276.2
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712147955; x=1712752755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rvyHdTMFX05Vxha9e3lD5K3hoVgydGefmuKw7Cncp5s=;
        b=JS03Y9jTUgcIBxC9LjJr+pailx09p+A7lgM0PXmaeDKdkGD/baOUPrUwKi/6sKQk3q
         6SPHLzFXWhfBqSic6GfEQG1UYn1EV3M+P+oINdZYZN+gxEns2wWJx+hBOQfbkXsNiK89
         GjEu8lT0ic1PqhDgXX6qjKUmIIpRSHQkQ9ZWr7NFYMCdUDTF09bTkxqPzZDZL15KiWOz
         pYpjrL9iJgEsxTWaF4IPcFV/x7DISWzMczKdnyfd4RV0Re+l8tHa50e4lgtERWW7gx1Z
         1UJEUuV7jzLs5llJsijYwIFvU0TTpKaVl8q1qtvI2TsazEj0lH60EEcnH66LYLKWOmNx
         nB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712147955; x=1712752755;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvyHdTMFX05Vxha9e3lD5K3hoVgydGefmuKw7Cncp5s=;
        b=OZ/YM3411KEZW+YB4DIDacYTr5BDHQDKGoNRwOAMxUKIkIk8z1wyzXBS9irTlUNpdH
         hz1IAIaN48R38KC4rL5U0m8bLOv4/V5ttHnzg0GpzQawBaMevtSJYpY7v4bJJWIruENd
         rHKSAY06JDJ0pTpFRt55MGaRbfZ7qaL0aXQQHcrmuEzyIgDGsYF+KrnB6ccrrBrn0Isr
         xWnC7dqEYmjBYYLuXvhX07TLaauixN3sQBxqW0B5iV93NvNLd2w2ZnFR4FHnrE9XAZ4R
         mcmvmYlIuSYHThh4vwRDfcX3w1decT1y81LPA+CDa2cYaQYdgz/qHW7qBWS5sG569aIr
         jRSw==
X-Gm-Message-State: AOJu0Yyd+DrIcAoIts2kM92RevNvfyv9ZDB3hYRJoV/WYP4h2Kj5cE4Y
	34916+m79r9zgYjRASDFeJpE3eOMlv7BvvZPgUAs/YJp8ER7vbezpv1qLfQx0zpHZ/e4NKkZ0eT
	GBhUEIAdKjw==
X-Google-Smtp-Source: AGHT+IHJy+z7nJgPb695V0zhYv4iiXKkVcLNv9Zv2+3digzOYm6Vi4DruP9oQ9OwP64iPfTzeE6xfvLOIfTvrw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2083:b0:dcb:fb69:eadc with SMTP
 id di3-20020a056902208300b00dcbfb69eadcmr1203861ybb.6.1712147955485; Wed, 03
 Apr 2024 05:39:15 -0700 (PDT)
Date: Wed,  3 Apr 2024 12:39:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403123913.4173904-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: remove RTNL protection from ip6addrlbl_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

No longer hold RTNL while calling ip6addrlbl_dump()
("ip addrlabel show")

ip6addrlbl_dump() was already mostly relying on RCU anyway.

Add READ_ONCE()/WRITE_ONCE() annotations around
net->ipv6.ip6addrlbl_table.seq

Also change return value for a completed dump,
so that NLMSG_DONE can be appended to current skb,
saving one recvmsg() system call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrlabel.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrlabel.c b/net/ipv6/addrlabel.c
index 17ac45aa7194ce9c148ed95e14dd575d17feeb98..961e853543b64cd2060ef693ae3ad32a44780aa1 100644
--- a/net/ipv6/addrlabel.c
+++ b/net/ipv6/addrlabel.c
@@ -234,7 +234,8 @@ static int __ip6addrlbl_add(struct net *net, struct ip6addrlbl_entry *newp,
 		hlist_add_head_rcu(&newp->list, &net->ipv6.ip6addrlbl_table.head);
 out:
 	if (!ret)
-		net->ipv6.ip6addrlbl_table.seq++;
+		WRITE_ONCE(net->ipv6.ip6addrlbl_table.seq,
+			   net->ipv6.ip6addrlbl_table.seq + 1);
 	return ret;
 }
 
@@ -445,7 +446,7 @@ static void ip6addrlbl_putmsg(struct nlmsghdr *nlh,
 };
 
 static int ip6addrlbl_fill(struct sk_buff *skb,
-			   struct ip6addrlbl_entry *p,
+			   const struct ip6addrlbl_entry *p,
 			   u32 lseq,
 			   u32 portid, u32 seq, int event,
 			   unsigned int flags)
@@ -498,7 +499,7 @@ static int ip6addrlbl_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net *net = sock_net(skb->sk);
 	struct ip6addrlbl_entry *p;
 	int idx = 0, s_idx = cb->args[0];
-	int err;
+	int err = 0;
 
 	if (cb->strict_check) {
 		err = ip6addrlbl_valid_dump_req(nlh, cb->extack);
@@ -510,7 +511,7 @@ static int ip6addrlbl_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	hlist_for_each_entry_rcu(p, &net->ipv6.ip6addrlbl_table.head, list) {
 		if (idx >= s_idx) {
 			err = ip6addrlbl_fill(skb, p,
-					      net->ipv6.ip6addrlbl_table.seq,
+					      READ_ONCE(net->ipv6.ip6addrlbl_table.seq),
 					      NETLINK_CB(cb->skb).portid,
 					      nlh->nlmsg_seq,
 					      RTM_NEWADDRLABEL,
@@ -522,7 +523,7 @@ static int ip6addrlbl_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	rcu_read_unlock();
 	cb->args[0] = idx;
-	return skb->len;
+	return err;
 }
 
 static inline int ip6addrlbl_msgsize(void)
@@ -614,7 +615,7 @@ static int ip6addrlbl_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
 	rcu_read_lock();
 	p = __ipv6_addr_label(net, addr, ipv6_addr_type(addr), ifal->ifal_index);
-	lseq = net->ipv6.ip6addrlbl_table.seq;
+	lseq = READ_ONCE(net->ipv6.ip6addrlbl_table.seq);
 	if (p)
 		err = ip6addrlbl_fill(skb, p, lseq,
 				      NETLINK_CB(in_skb).portid,
@@ -647,6 +648,7 @@ int __init ipv6_addr_label_rtnl_register(void)
 		return ret;
 	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETADDRLABEL,
 				   ip6addrlbl_get,
-				   ip6addrlbl_dump, RTNL_FLAG_DOIT_UNLOCKED);
+				   ip6addrlbl_dump, RTNL_FLAG_DOIT_UNLOCKED |
+						    RTNL_FLAG_DUMP_UNLOCKED);
 	return ret;
 }
-- 
2.44.0.478.gd926399ef9-goog


