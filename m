Return-Path: <netdev+bounces-291263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO99GkoKFGrVJAcAu9opvQ
	(envelope-from <netdev+bounces-291263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:37:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E085C7DCE
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0BB4302ACDE
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA63E3D9F;
	Mon, 25 May 2026 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eTvBVQs8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC633E3C48
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698155; cv=none; b=ptn/5sZkaiwnnFVXAJY4q2mInSXHNDEQ0I+TjwlFDlAzYtHV0Suz+R8IpFs9DCZvdqfjNtW4hjRVrY9BH1QPFqUq011x/oRIHYywQWYrcjHnEm9nFT+8XhHYiKdaS6pbDuFnnK+GlBdNiQ7tvvvugnsx4DyuROKyGJAuwEpnWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698155; c=relaxed/simple;
	bh=+QQmJxwAkL+9ePK0TgQyDU235BpaQXkrKV86rfOnpEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kF+NseaXqgGgCS+SdagdUMo0BoAJKmogcsqJkbD9eg1BocIpxcc8BWpXQVakUCkxWmNOb3QhRruuZooo3vBlJ4AlEeQTyY5UbBkPzqQ4Ko0kQ6MieKNI1CwV1ys7ZJHDWYDAlzvyxoPH4GaCZSQofZdgwCwl8RaKDWa10Q8NmIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eTvBVQs8; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50faf575af4so244045201cf.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779698153; x=1780302953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wX9ZXWiWjb2/jWLmM8f9e4aFNUYKdLOW34yz0jjyNBc=;
        b=eTvBVQs8uK3zEddJL3quIGvqD2JBZNUKDx/60z6wFJyRH0meY1yJ2s6IdqgX1htZ4n
         6Z7zIruV1uMYEWeu+KBYbppwObu3kXWNycBocaqzl8fCN1tamideMfi7j6Hw2HbQbTQ5
         d23u5QqJ/ZzClEbfgFPSDQduTujaMaoi5XPAtskodvcDj0yaZ39hoclSrlRHiVMR8OzI
         i5fn0rMErgV/0ybnB+DNXD60w2/iqwmXuLsRzWiu7Y3wKThvy1NkErgRyg1NecV2eEz/
         Zocc3o1iOklkc1HAgNSqHnn8weKCTNfJh3jCrBmHxyW6oEzcLcyTfAM2yUOv+5wQnh5+
         0+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698153; x=1780302953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wX9ZXWiWjb2/jWLmM8f9e4aFNUYKdLOW34yz0jjyNBc=;
        b=stU8WXwS4wQdDbllt41umO0tgC+SVktG5X9jzKBsn16PlxUzuCgZ9OnyTz4PvBx4DI
         AylB2sGzAk8S4NkwXEbWALW4C3dDL5uGEOMxgLRBtzllH4Prba8qKbBT27d9Y+9SrSdw
         dL/9H/TXfXjBy+v9NQ4ecy0KOAmtPQMM3JlpTSe/8Ld2zYhr07Os1K9c5+qykBR+qYHq
         Lfa4MpwqK/nC0q7aF1V7q6v9OmCj9dDRhZhnS/ApTAzj7F5O3kS17l1HOHlsnzTLpbWz
         8LEPfqjNIcJZ6guc7V/Uf6cpqqYlAaVtGXn5lOK9S7ss723ygV6aO9a1eGFXcEzIMDWg
         OP1w==
X-Forwarded-Encrypted: i=1; AFNElJ8TpTS6f0J4gEzgTghK0O6n1C97QqR5/zNVqIjzAEYDmxUqBdRK701NwuuJu4gphs93xAV+r5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2JxEVaQtn53VNDq5bSxQJuIMNTuRQTc3FPtqrHPH5jWGFeOTN
	Bp+NdeUQ6UdKHAVkLzzX87HuqSpoUInzsFWxNDiNAa3zZ9Uftz7hjHtVadsRe3q7HpqkbbZTiYV
	FJFZ4jO0e515ciA==
X-Received: from qtbkj21.prod.google.com ([2002:a05:622a:7795:b0:513:11d:4a39])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f8a:0:b0:516:dff5:68c4 with SMTP id d75a77b69052e-516dff56be8mr146863561cf.7.1779698152448;
 Mon, 25 May 2026 01:35:52 -0700 (PDT)
Date: Mon, 25 May 2026 08:35:42 +0000
In-Reply-To: <20260525083542.1565964-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525083542.1565964-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525083542.1565964-6-edumazet@google.com>
Subject: [PATCH v5 net-next 5/5] rtnetlink: add RTEXT_FILTER_NAME_ONLY support
 to rtnl_dump_ifinfo()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291263-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.938];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 21E085C7DCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When user requests RTEXT_FILTER_NAME_ONLY flag, we limit the dump
parts to:

 - struct nlmsghdr
 - IFLA_IFNAME
 - IFLA_PROP_LIST (alternate names)

- This saves space in the dump, pushing more devices per system call.
- This can be done without acquiring RTNL.

I still have a medium term goal to avoid RTNL in rtnl_dump_ifinfo()
regardless of RTEXT_FILTER_NAME_ONLY being used.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 0a59036d5f933c5b2f123a47e059036d2a555911..652dd008955a90691403de9a54d8693d64ea7799 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2499,6 +2499,7 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	int ops_srcu_index;
 	int master_idx = 0;
 	int netnsid = -1;
+	bool need_rtnl;
 	int err, i;
 
 	err = rtnl_valid_dump_ifinfo_req(nlh, cb->strict_check, tb, extack);
@@ -2548,6 +2549,12 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 
 walk_entries:
 	err = 0;
+	need_rtnl = !(ext_filter_mask & RTEXT_FILTER_NAME_ONLY);
+	if (need_rtnl)
+		rtnl_lock();
+	else
+		rcu_read_lock();
+
 	for_each_netdev_dump(tgt_net, dev, ctx->ifindex) {
 		if (link_dump_filtered(dev, master_idx, kind_ops))
 			continue;
@@ -2559,11 +2566,13 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 		if (err < 0)
 			break;
 	}
-
-
-	cb->seq = tgt_net->dev_base_seq;
+	cb->seq = READ_ONCE(tgt_net->dev_base_seq);
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 
+	if (need_rtnl)
+		rtnl_unlock();
+	else
+		rcu_read_unlock();
 out:
 
 	if (kind_ops)
@@ -7159,7 +7168,9 @@ static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst =
 	 .flags = RTNL_FLAG_DOIT_PERNET_WIP},
 	{.msgtype = RTM_GETLINK, .doit = rtnl_getlink,
 	 .dumpit = rtnl_dump_ifinfo,
-	 .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE | RTNL_FLAG_DOIT_UNLOCKED},
+	 .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE |
+		  RTNL_FLAG_DOIT_UNLOCKED |
+		  RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype = RTM_SETLINK, .doit = rtnl_setlink,
 	 .flags = RTNL_FLAG_DOIT_PERNET_WIP},
 	{.msgtype = RTM_GETADDR, .dumpit = rtnl_dump_all},
-- 
2.54.0.746.g67dd491aae-goog


