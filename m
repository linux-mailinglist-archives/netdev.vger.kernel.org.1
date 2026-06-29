Return-Path: <netdev+bounces-302771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 83z6LSC2Qmo6AAoAu9opvQ
	(envelope-from <netdev+bounces-302771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:14:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC566DDF35
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:14:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=mC4ebhDB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302771-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302771-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27585305A22F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33338380FDE;
	Mon, 29 Jun 2026 18:12:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EDB37D13D
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:12:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756758; cv=none; b=Xnd847SPmohqocqGnH1nF501Cd7U0bWYyx9a+2FA7axGU6xEYpW3VolrzlF4bN0oUGwS/jMN/2n51IdAlMVUVCZOs93SK+VPLXKaUwiG70sMtBZCLJgm4ZGRgLelS4A6YtFQwDWznxQrra5jU7RZQDH0mdDUAI72ha7hvGy9qks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756758; c=relaxed/simple;
	bh=SbF9Bz3/iid4dv38AEpVPxNZPMRz8smJpqjnMbXvTRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BBy1rBO6CUyqOOphQ3Avgj9lGqF5ic8aCokMLkcw+j9/bGxzITdrtBjElEmXGScEUMHlWbj7W4LjXMsXb2QPU8m8ABJyC6FyUmlXDPynCVVHyHgP7CCiaVRLxWlcEErvhU7tJmFIcxem7CV+uHn5zCSilZgnLkT0WGiu0RfV61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mC4ebhDB; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88fc985a65so1739080a12.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756756; x=1783361556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zgwLKdAJtBUSoDlSvgZOwOtb79Hh0Q1Nl5BJXU7m2ps=;
        b=mC4ebhDBxieVkboQjq68ab4ntXrr2tzBXIMVDENqQOe2SN8/6qiKUCiT0rHc5DlUjc
         2ZMhBx1JurcnL3AybV2JZliMqb5t21yTlTCIrCXYoG2bUw8FLVKBq6bRmDXFxdGE42hU
         +cK8gtRnR9g+XpmicrEJQtM9WTF0Z5Tb/HOQ8XuiIp+iLn3aD01mYlBDZWpo5fzvLFSy
         WIAiY96d1L7ksFd/Ta+s6hG1uAzbi3x+iHLs84BbWn1v+/kH5Z7khZgGNCZG8pWfHY6e
         AXhTl46ZKwywPV9cVcS5W9YgRChds7NpyHPkFilptzQ4OcEpk6d15aadnc55cLMtLgal
         IoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756756; x=1783361556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgwLKdAJtBUSoDlSvgZOwOtb79Hh0Q1Nl5BJXU7m2ps=;
        b=goHTxoFuh/lljn6cI8pIGx7m2RsNV6R96MQUfUc1ZZGFPBiUZyNN1p81CD8ep9oX6J
         06pZWrndmZ9/i2oEQb4UVnRf/BJiRtH1H2xsFXFogd8ZTRkeGJvvfPKSpi+vjM4Wqac4
         mqpXtNYHximEaDLWIy8U6X834XL5LWMbmoZSoHaBhzD8blavmbLNokKxI/8Dfnvj4lZz
         YU9SsWjtu3MQrqoKHtz8vDSD5D+BsY03LbqkU+hzLa6Aef/asDXyKPTZXq8N9pOKCf+6
         9L2UEomrCFqWxL1npj27tZ06EtmkwWzuBfSa0zmYHEpUdyTlqkeUd0So6+oUtARw9N/r
         DlZw==
X-Forwarded-Encrypted: i=1; AFNElJ/TXop14IDTm2ZU8axAKppyiYeQEkPHcFfJ5rE3pXqPxr+vbF+bcNIsrOk/G3U7zfhTZvcANqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQ8oGRYH2XiUtfoqFg+pGjCN8vBJuDMbRjahmdmDRTqA29kCO
	usdwjdeII5ckuhxkksDyFHo1vRsVMcwxXzJbsaegTfrOASWMXdHxu9bJ0vp+4757/KqWM8x/c2a
	R0EwVSA==
X-Received: from pgum11.prod.google.com ([2002:a65:6a0b:0:b0:c91:7774:1541])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:618e:b0:3b4:9168:d9e6
 with SMTP id adf61e73a8af0-3bfc527e4afmr503113637.37.1782756756101; Mon, 29
 Jun 2026 11:12:36 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:11:00 +0000
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629181226.1929658-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 08/10] net: fib_rules: Use dev_get_by_name_rcu().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302771-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1AC566DDF35

We will no longer hold RTNL for RTM_NEWRULE and RMT_DELRULE
except for the first IPv4 RTM_NEWRULE.

Let's covnert __dev_get_by_name() in fib_nl2rule_rtnl() to
dev_get_by_name_rcu() and rename it to fib_nl2rule_locked().

Note that dev_get_by_name_rcu() must be called inside ops->lock
to serialise fib_rules_event() by __dev_change_net_namespace().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/fib_rules.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 5eef5d6ace82..2b652dd83241 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -734,10 +734,10 @@ static int fib_nl2rule(struct net *net, struct nlmsghdr *nlh,
 	return err;
 }
 
-static int fib_nl2rule_rtnl(struct fib_rule *nlrule,
-			    struct fib_rules_ops *ops,
-			    struct nlattr *tb[],
-			    struct netlink_ext_ack *extack)
+static int fib_nl2rule_locked(struct fib_rule *nlrule,
+			      struct fib_rules_ops *ops,
+			      struct nlattr *tb[],
+			      struct netlink_ext_ack *extack)
 {
 	if (!tb[FRA_PRIORITY])
 		nlrule->pref = fib_default_rule_pref(ops);
@@ -748,12 +748,14 @@ static int fib_nl2rule_rtnl(struct fib_rule *nlrule,
 		return -EINVAL;
 	}
 
+	rcu_read_lock();
+
 	if (tb[FRA_IIFNAME]) {
 		struct net_device *dev;
 
-		dev = __dev_get_by_name(nlrule->fr_net, nlrule->iifname);
+		dev = dev_get_by_name_rcu(nlrule->fr_net, nlrule->iifname);
 		if (dev) {
-			nlrule->iifindex = dev->ifindex;
+			nlrule->iifindex = READ_ONCE(dev->ifindex);
 			nlrule->iif_is_l3_master = netif_is_l3_master(dev);
 		}
 	}
@@ -761,13 +763,15 @@ static int fib_nl2rule_rtnl(struct fib_rule *nlrule,
 	if (tb[FRA_OIFNAME]) {
 		struct net_device *dev;
 
-		dev = __dev_get_by_name(nlrule->fr_net, nlrule->oifname);
+		dev = dev_get_by_name_rcu(nlrule->fr_net, nlrule->oifname);
 		if (dev) {
-			nlrule->oifindex = dev->ifindex;
+			nlrule->oifindex = READ_ONCE(dev->ifindex);
 			nlrule->oif_is_l3_master = netif_is_l3_master(dev);
 		}
 	}
 
+	rcu_read_unlock();
+
 	return 0;
 }
 
@@ -906,7 +910,7 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 		rtnl_net_lock(net);
 	mutex_lock(&ops->lock);
 
-	err = fib_nl2rule_rtnl(rule, ops, tb, extack);
+	err = fib_nl2rule_locked(rule, ops, tb, extack);
 	if (err)
 		goto errout_free;
 
@@ -1038,7 +1042,7 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 		rtnl_net_lock(net);
 	mutex_lock(&ops->lock);
 
-	err = fib_nl2rule_rtnl(nlrule, ops, tb, extack);
+	err = fib_nl2rule_locked(nlrule, ops, tb, extack);
 	if (err)
 		goto errout_free;
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


