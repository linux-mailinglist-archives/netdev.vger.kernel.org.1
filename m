Return-Path: <netdev+bounces-302772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 425UKLm1QmooAAoAu9opvQ
	(envelope-from <netdev+bounces-302772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:13:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DFB6DDF12
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:13:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GTD6YRyV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302772-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302772-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EAC43005325
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3482F381AEC;
	Mon, 29 Jun 2026 18:12:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D2382298
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:12:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756759; cv=none; b=OH3nfIROkbfvdnMeM28IoasboeG+PTYbOLwpjhKnpqDxCCq1/E+axQJ8PI9RDr/DLK5AL7XlOaf3BY0gHqErjjBZMlBB2kdLx51i0bY6/akYsV5T+RygIhLH9M7Y1wNA4su5AiHWDQgEpCKLNcF+PflbwkcwYMgFKZhv7pc05Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756759; c=relaxed/simple;
	bh=kII0sZHq33DGFP712DBUR0nD0GEFirk6KAT8gqKE+Dw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BbepifRrVCAitfc6j8uhc7RCz08LQbgd8wipYNENF3joMYNCuDPOHP/lBuMFS5zb8aqoRYRr2FAI0vFYfi3i91Zv5Qn253qaXz+URolatNXdfFx4SMH+uEPpsNz1zrX1umEXpx7tIzX1bF8lvpL+KZsxn2HiobVjRAy4yksZx3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTD6YRyV; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bbcd40642so2061255a91.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756757; x=1783361557; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=86sb8GR19KqWdZVdhvBmx/FnORVBb2WIZUnnM+E+avQ=;
        b=GTD6YRyVwrerQRXPh2/UuOhyi8YdLip9WUHw0fPBgwJQ3DgjEAQsgZtmeVPUvfCYnX
         aBSFG2DPyRX1P+v9iGqyyprJvI6LuaOS+N6YgFBzSZuJjyCwc5/4wmBuuNAk0IR03XCT
         khp21138AqKyfDppwtTH6gCKEZ/pptC/ONSrDpf3ohc8wSPIDLw/zu/4UKYliUqUhjUA
         +lCqp09PCY3C48pHFHelu85HO1SAWuxW1HUld9JkC3dJmAiiLJdqP+ibAFOjqdmHsOcV
         eyW4QKTJ08LUaFzc/CEDPo5yMFhzKzSxMfiSJ9G5p5rINNrFFAtoD7X/S8EfgHJuAl/R
         KPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756757; x=1783361557;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=86sb8GR19KqWdZVdhvBmx/FnORVBb2WIZUnnM+E+avQ=;
        b=IYtVqHlRgnvym9Rd6/ncPGt5qNx4uxH9F+zISzEfrVdm0fdCj+k5uogACluJ+oYlZR
         6EPRVM1Ll/is9qmbFzRDeNjYMHUDpRWPl71UdDiKokfW5YGWk5llTvC6Jr47knSFuXwE
         cYuz8jDJY0OtwVnsIHWWtLwC7ILxkzL2em8BeDibYFRtHp6Ze9PwdFkz8lt9YirODM0u
         P9d0r6fNrTz67PiRA5sfynLU8PMEYi+nM7coXEs2zo9K7FC7X1+W0+kIZ4V5BQE69aBr
         DkJIfKUfKjCwFHK86UTUpqjpETxduYDaK5uuK1vkDrElj2ezLbPxwR8a9BDxoUJaFrl3
         SBRA==
X-Forwarded-Encrypted: i=1; AHgh+RpVKOjoaianm9R3HXV0LEtw7DsHqP7xzyQQoNu7d2qd38SiNzKm5TAJjpyO+D5YcsHPk9hv+JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJKvhZpbyykchFpk/ucxsBjJGCObsXj8gyu4mZWBSESmRHBmx
	ohMEA/i9vuXEEl9/5m2/Do5s7eV5MM+HALtSgdm/sQhgVMGtDlRefntXJP6m4PzCJJGp1XodXvf
	ZYGk8HA==
X-Received: from pjbgb11.prod.google.com ([2002:a17:90b:60b:b0:37f:5f6f:df0f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55c6:b0:37f:c239:10f5
 with SMTP id 98e67ed59e1d1-38052538a89mr339590a91.12.1782756756863; Mon, 29
 Jun 2026 11:12:36 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:11:01 +0000
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629181226.1929658-10-kuniyu@google.com>
Subject: [PATCH v1 net-next 09/10] net: fib_rules: Only hold RTNL for the
 first IPv4 RTM_NEWRULE.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302772-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86DFB6DDF12

Now, RTM_DELRULE no longer needs RTNL, and the only RTNL dependant
in RTM_NEWRULE is fib_unmerge(), which is called for the first
IPv4 rule.

Let's add fib_rules_ops.need_rtnl() and hold RTNL only for the
first IPv4 rule.

Tested:
The script below creates 1K rules in parallel in 4K netns, and
it got 20x/30x faster for IPv4/IPv6.

  #!/bin/bash
  N=4096
  F=rules.txt

  for i in $(seq $N); do ip netns add ns-$i; done
  printf 'rule add from all table %d\n' {1..1024} > $F

  for v in 4 6; do
  	echo "=== IPv${v} ==="
  	time { for i in $(seq $N); do nsenter \
  	--net=/var/run/netns/ns-$i ip -$v -batch $F & done; wait; }
  done

  for i in $(seq $N); do ip netns del ns-$i; done
  rm -f $F

Without this series:

  # ./test.sh
  === IPv4 ===

  real	0m22.752s
  user	0m7.834s
  sys	92m46.721s
  === IPv6 ===

  real	0m35.181s
  user	0m8.635s
  sys	142m30.479s

With this series:

  # ./test.sh
  === IPv4 ===

  real	0m0.918s
  user	0m5.675s
  sys	2m7.024s
  === IPv6 ===

  real	0m1.214s
  user	0m7.917s
  sys	4m19.489s

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/fib_rules.h |  1 +
 net/core/fib_rules.c    | 15 ++++++---------
 net/ipv4/fib_rules.c    |  6 ++++++
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index 7636ef4da5ad..c6b94790fa81 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -93,6 +93,7 @@ struct fib_rules_ops {
 	/* Called after modifications to the rules set, must flush
 	 * the route cache if one exists. */
 	void			(*flush_cache)(struct fib_rules_ops *ops);
+	bool			(*need_rtnl)(struct net *net);
 
 	int			nlgroup;
 	struct list_head	rules_list;
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 2b652dd83241..22e5e5e1a9c4 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -881,6 +881,7 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct nlattr *tb[FRA_MAX + 1];
 	bool user_priority = false;
 	struct fib_rule_hdr *frh;
+	bool unlock_rtnl = false;
 
 	frh = nlmsg_payload(nlh, sizeof(*frh));
 	if (!frh) {
@@ -906,8 +907,10 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto errout;
 
-	if (!rtnl_held)
+	if (!rtnl_held && ops->need_rtnl && ops->need_rtnl(net)) {
+		unlock_rtnl = true;
 		rtnl_net_lock(net);
+	}
 	mutex_lock(&ops->lock);
 
 	err = fib_nl2rule_locked(rule, ops, tb, extack);
@@ -978,7 +981,7 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 	fib_rule_get(rule);
 
 	mutex_unlock(&ops->lock);
-	if (!rtnl_held)
+	if (unlock_rtnl)
 		rtnl_net_unlock(net);
 
 	notify_rule_change(RTM_NEWRULE, rule, ops, nlh, NETLINK_CB(skb).portid);
@@ -989,7 +992,7 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 
 errout_free:
 	mutex_unlock(&ops->lock);
-	if (!rtnl_held)
+	if (unlock_rtnl)
 		rtnl_net_unlock(net);
 	kfree(rule);
 errout:
@@ -1038,8 +1041,6 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto errout;
 
-	if (!rtnl_held)
-		rtnl_net_lock(net);
 	mutex_lock(&ops->lock);
 
 	err = fib_nl2rule_locked(nlrule, ops, tb, extack);
@@ -1096,8 +1097,6 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 	call_fib_rule_notifiers(net, FIB_EVENT_RULE_DEL, rule, ops, NULL);
 
 	mutex_unlock(&ops->lock);
-	if (!rtnl_held)
-		rtnl_net_unlock(net);
 
 	notify_rule_change(RTM_DELRULE, rule, ops, nlh, NETLINK_CB(skb).portid);
 	fib_rule_put(rule);
@@ -1108,8 +1107,6 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 
 errout_free:
 	mutex_unlock(&ops->lock);
-	if (!rtnl_held)
-		rtnl_net_unlock(net);
 	kfree(nlrule);
 errout:
 	rules_ops_put(ops);
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 16d202246a36..4edb0dca7be8 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -460,6 +460,11 @@ static void fib4_rule_flush_cache(struct fib_rules_ops *ops)
 	rt_cache_flush(ops->fro_net);
 }
 
+static bool fib4_rule_need_rtnl(struct net *net)
+{
+	return !net->ipv4.fib_has_custom_rules;
+}
+
 static const struct fib_rules_ops __net_initconst fib4_rules_ops_template = {
 	.family		= AF_INET,
 	.rule_size	= sizeof(struct fib4_rule),
@@ -473,6 +478,7 @@ static const struct fib_rules_ops __net_initconst fib4_rules_ops_template = {
 	.fill		= fib4_rule_fill,
 	.nlmsg_payload	= fib4_rule_nlmsg_payload,
 	.flush_cache	= fib4_rule_flush_cache,
+	.need_rtnl	= fib4_rule_need_rtnl,
 	.nlgroup	= RTNLGRP_IPV4_RULE,
 	.owner		= THIS_MODULE,
 };
-- 
2.55.0.rc0.799.gd6f94ed593-goog


