Return-Path: <netdev+bounces-277581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GxtLTdp2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:18:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 514873DCD24
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B065B305865C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63953AF677;
	Fri, 10 Apr 2026 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKzpK4PW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D563B0AC2
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855862; cv=none; b=Oe8LBr4rJatJm3vlaS+isM/CTAhMOYeBz7VntdmJMiKyFYPfO5ECVm6jDMtnjEqdf4mcpJbtBrsXbBD9MMc0qLrv0ZM1UrUAvUbxlqR0zetjzSqH318geBU3MLpVt8Bt9jgbw9VBqk7m5O8n8zVx7K/mXnb/G2KCKpOfto2uH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855862; c=relaxed/simple;
	bh=WuWdR6IInU3e6QvkbIiIbPtAjPON4DLLr7yA/g7NPwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H7QgMVfbNQwHqqS+AnxqNTWB8oQPrX/FZr36GuDAP1rKEhvyFXslhg/il2Wc+DWLA736rZYAoZwb5V1c/URrs0rilx3YxRRxrwb18HUe8SmT8+pOsoxdIBfFm2S46AMN1/L83hm4DwF5bGMsmawSTgTcF30M7G/K/wl+Sfzi1As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKzpK4PW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24a00d12cso24580715ad.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855861; x=1776460661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnG5Bw5JDOJWW1r1TsrbKJx/9qkZ/mmYpnYxcLRvs3I=;
        b=vKzpK4PWElrqRd30DomCgUoGAKCh4Ln42EmpFQbtydynT9KC2bL5JgI8j9REjJY8++
         5iHWN9mhMBEoT6xGh36RtkxcleqTEmLOR3OGMhNXGrTcmXOvL6jH65fdcwWGOtf7Wqr3
         BIQPTqXd+iPWZokfPXXv5QxmAt0lgKxJnNR/h0gfUjgRQJnxDW2Z8oUJVCbU6jx/JWMW
         7x/ezIP+zoKfGEzAM60vD+eWYHOsKkxuX/O0ofd/MA+ixJc8wG7lub5+IwFOlMdaGTLG
         H0fcn6RVB82zH8pMjRMUNS7dX33YC61YpBwS5/S7zFvJTDxgCJb4vH2oRgN3yuWW6SIz
         D9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855861; x=1776460661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnG5Bw5JDOJWW1r1TsrbKJx/9qkZ/mmYpnYxcLRvs3I=;
        b=c3pFY+vX2zeCwlzvv4AMVaG3iAa2rWtKVGYIAk8ww14HBNNZU847fwrN3HUSqxshRi
         UbJDvr7bQ7AeidIUBCgOJ9KE1Lvss//oNSSr+BEseEbqB2ZV+Tx7Y/5bnIK66hqHtjWb
         TfDlVsbZ/eNnyQTLtv6AtI8wxK2HjlwDP08NKBbz4hXexCAya7JihwRgn1ggXcPeuXhm
         Y/4zdKGbKsuCHHp0Y12+TiXLxpKjip/tHjnWoXrCKGWkUgsGfmm7tX4ZwVTlxTGB11iF
         cjAzvJOqMRBIrkasjlrbvVl9gdmeQ4mACykGaMYjycclSWIwFgrTejPnhcmnDyoRcx6t
         fFFg==
X-Forwarded-Encrypted: i=1; AJvYcCUjsD4c9qgFwrnIWzJWx1JGXIIUJHbfv9KCblOLLBF2hw4tCiQlNIz+2f0ssAydUqztnxBRbMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAv1+WTOFszsp0nJQlnTToL6NQBK2wa9ecNQEBPLw3EQhokZwl
	dy0XuC2UwHnU96pdCALPdL2iC15mg82L8NL9gnIc0RjYgC2tDKnKzsRMuzxjWiSgArPh8s6ziit
	s94cSVw==
X-Received: from pgbcp10.prod.google.com ([2002:a05:6a02:400a:b0:c79:165b:33b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9153:b0:39f:21a8:1e1d
 with SMTP id adf61e73a8af0-39fe3c65d84mr5754126637.10.1775855860665; Fri, 10
 Apr 2026 14:17:40 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:17:01 +0000
In-Reply-To: <20260410211726.1668756-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410211726.1668756-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 05/15] ip6mr: Convert ip6mr_rtm_getroute() to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277581-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 514873DCD24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip6mr_rtm_getroute() calls __ip6mr_get_table(), ip6mr_cache_find(),
and ip6mr_fill_mroute().

Once created, struct mr_table is not freed until netns dismantle,
so it's safe under RCU.

ip6mr_cache_find() iterates mrt->mfc_hash with rhl_for_each_entry_rcu().
struct mr_mfc is freed with call_rcu(), so this is also safe under
RCU.

ip6mr_fill_mroute() calls mr_fill_mroute(), which properly uses
RCU helpers.

Let's call them under RCU and register ip6mr_rtm_getroute() with
RTNL_FLAG_DOIT_UNLOCKED.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 5356957bfe94..0054db00fadf 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1388,7 +1388,8 @@ static struct pernet_operations ip6mr_net_ops = {
 static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] __initconst_or_module = {
 	{.owner = THIS_MODULE, .protocol = RTNL_FAMILY_IP6MR,
 	 .msgtype = RTM_GETROUTE,
-	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute},
+	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
 };
 
 int __init ip6_mr_init(void)
@@ -2712,6 +2713,8 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		grp = nla_get_in6_addr(tb[RTA_DST]);
 	tableid = nla_get_u32_default(tb[RTA_TABLE], 0);
 
+	rcu_read_lock();
+
 	mrt = __ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
@@ -2719,10 +2722,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		goto err;
 	}
 
-	/* entries are added/deleted only under RTNL */
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &src, &grp);
-	rcu_read_unlock();
 	if (!cache) {
 		NL_SET_ERR_MSG_MOD(extack, "MR cache entry not found");
 		err = -ENOENT;
@@ -2734,9 +2734,12 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto err;
 
+	rcu_read_unlock();
+
 	return rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
 
 err:
+	rcu_read_unlock();
 	kfree_skb(skb);
 	return err;
 }
-- 
2.53.0.1213.gd9a14994de-goog


