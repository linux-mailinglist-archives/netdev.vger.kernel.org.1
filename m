Return-Path: <netdev+bounces-143123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132679C1368
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A361F236CB
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC71BD9FB;
	Fri,  8 Nov 2024 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R57QeacQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB21EC0
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027777; cv=none; b=WEbmOztxffcT8WbtbeJEk5UTQqq0bxlakLmDbI/hRRxdFq8GgEwI6kICr7Kqx8AO4UKlLcgbVEgYJQ+1QAbX+MEhMwI0Dhe2+E64CO3nLwAvLcrbb71m7AdGyc59yfrvxueVdsQN4ibFloTsUaESYzMm7BGbt0h6ff/U4BCNyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027777; c=relaxed/simple;
	bh=2OZRCx61sQHAFAXdvLON086QS03dsE6saKCPhFO1i78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uHpNx9QQWv64keysmAEnJddznRrprPp6QnBJIeKuikY1VGAgrn8/1LahBy2JMhjAMv7iqUnxoNy5CdZ+nqk7ai6MeaBueg7R4Y3RABcJ4s4aWhv8jBedhx2LgFUCGonxrSqwQCuvwNFXRogolOIlNbqC/b8v0t3Yot1M4PadYYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R57QeacQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFE3C4CECC;
	Fri,  8 Nov 2024 01:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731027776;
	bh=2OZRCx61sQHAFAXdvLON086QS03dsE6saKCPhFO1i78=;
	h=From:To:Cc:Subject:Date:From;
	b=R57QeacQUb7lBZBONORty9I7jvrr5S9W4CGNgJyMRzNbvpC443hCObBZ1OILdO0pY
	 mUv/XzVFY3xrQvSv5YPsNYDPCcq3ee+bRgXe5WM8P09TSCCxuFr48Z1hvdS0eJWaem
	 PKECgsCMfzHWLnWF6veo/V8aPGA5EFiMWEzyH/pB6NRuZq8hhZKicZyLEMip0L0ecP
	 LnEEsVoCXOijqzUp4Lq4JEfoWgrSuLNYgDkzTece6nVt+Cl66oLIVmrS7D/G/6ODK7
	 hvokaWgElK1c1vHK9ZwupcE/bIMnr4z3SBxAYwUs/+cbJxb7D9mO5nDz50CMatzGRy
	 MSc/PhYObKFww==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net-next v2] net: sched: cls_api: improve the error message for ID allocation failure
Date: Thu,  7 Nov 2024 17:02:54 -0800
Message-ID: <20241108010254.2995438-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We run into an exhaustion problem with the kernel-allocated filter IDs.
Our allocation problem can be fixed on the user space side,
but the error message in this case was quite misleading:

  "Filter with specified priority/protocol not found" (EINVAL)

Specifically when we can't allocate a _new_ ID because filter with
lowest ID already _exists_, saying "filter not found", is confusing.

Kernel allocates IDs in range of 0xc0000 -> 0x8000, giving out ID one
lower than lowest existing in that range. The error message makes sense
when tcf_chain_tp_find() gets called for GET and DEL but for NEW we
need to provide more specific error messages for all three cases:

 - user wants the ID to be auto-allocated but filter with ID 0x8000
   already exists

 - filter already exists and can be replaced, but user asked
   for a protocol change

 - filter doesn't exist

Caller of tcf_chain_tp_insert_unique() doesn't set extack today,
so don't bother plumbing it in.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1 was sent a while back, I realized this is sitting in my tree
I think I just forgot to send v2.

v2:
 - don't add the extack if we don't find the filter during NEW
v1: https://lore.kernel.org/20240912215306.2060709-1-kuba@kernel.org

CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
---
 net/sched/cls_api.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 2a7d856cc334..5c8d39b6b107 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1933,7 +1933,8 @@ static void tcf_chain_tp_remove(struct tcf_chain *chain,
 static struct tcf_proto *tcf_chain_tp_find(struct tcf_chain *chain,
 					   struct tcf_chain_info *chain_info,
 					   u32 protocol, u32 prio,
-					   bool prio_allocate);
+					   bool prio_allocate,
+					   struct netlink_ext_ack *extack);
 
 /* Try to insert new proto.
  * If proto with specified priority already exists, free new proto
@@ -1957,8 +1958,7 @@ static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain *chain,
 		return ERR_PTR(-EAGAIN);
 	}
 
-	tp = tcf_chain_tp_find(chain, &chain_info,
-			       protocol, prio, false);
+	tp = tcf_chain_tp_find(chain, &chain_info, protocol, prio, false, NULL);
 	if (!tp)
 		err = tcf_chain_tp_insert(chain, &chain_info, tp_new);
 	mutex_unlock(&chain->filter_chain_lock);
@@ -2018,7 +2018,8 @@ static void tcf_chain_tp_delete_empty(struct tcf_chain *chain,
 static struct tcf_proto *tcf_chain_tp_find(struct tcf_chain *chain,
 					   struct tcf_chain_info *chain_info,
 					   u32 protocol, u32 prio,
-					   bool prio_allocate)
+					   bool prio_allocate,
+					   struct netlink_ext_ack *extack)
 {
 	struct tcf_proto **pprev;
 	struct tcf_proto *tp;
@@ -2029,9 +2030,14 @@ static struct tcf_proto *tcf_chain_tp_find(struct tcf_chain *chain,
 	     pprev = &tp->next) {
 		if (tp->prio >= prio) {
 			if (tp->prio == prio) {
-				if (prio_allocate ||
-				    (tp->protocol != protocol && protocol))
+				if (prio_allocate) {
+					NL_SET_ERR_MSG(extack, "Lowest ID from auto-alloc range already in use");
+					return ERR_PTR(-ENOSPC);
+				}
+				if (tp->protocol != protocol && protocol) {
+					NL_SET_ERR_MSG(extack, "Protocol mismatch for filter with specified priority");
 					return ERR_PTR(-EINVAL);
+				}
 			} else {
 				tp = NULL;
 			}
@@ -2312,9 +2318,8 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 	mutex_lock(&chain->filter_chain_lock);
 	tp = tcf_chain_tp_find(chain, &chain_info, protocol,
-			       prio, prio_allocate);
+			       prio, prio_allocate, extack);
 	if (IS_ERR(tp)) {
-		NL_SET_ERR_MSG(extack, "Filter with specified priority/protocol not found");
 		err = PTR_ERR(tp);
 		goto errout_locked;
 	}
@@ -2539,10 +2544,13 @@ static int tc_del_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 	mutex_lock(&chain->filter_chain_lock);
 	tp = tcf_chain_tp_find(chain, &chain_info, protocol,
-			       prio, false);
-	if (!tp || IS_ERR(tp)) {
+			       prio, false, extack);
+	if (!tp) {
+		err = -ENOENT;
 		NL_SET_ERR_MSG(extack, "Filter with specified priority/protocol not found");
-		err = tp ? PTR_ERR(tp) : -ENOENT;
+		goto errout_locked;
+	} else if (IS_ERR(tp)) {
+		err = PTR_ERR(tp);
 		goto errout_locked;
 	} else if (tca[TCA_KIND] && nla_strcmp(tca[TCA_KIND], tp->ops->kind)) {
 		NL_SET_ERR_MSG(extack, "Specified filter kind does not match existing one");
@@ -2679,11 +2687,14 @@ static int tc_get_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 	mutex_lock(&chain->filter_chain_lock);
 	tp = tcf_chain_tp_find(chain, &chain_info, protocol,
-			       prio, false);
+			       prio, false, extack);
 	mutex_unlock(&chain->filter_chain_lock);
-	if (!tp || IS_ERR(tp)) {
+	if (!tp) {
+		err = -ENOENT;
 		NL_SET_ERR_MSG(extack, "Filter with specified priority/protocol not found");
-		err = tp ? PTR_ERR(tp) : -ENOENT;
+		goto errout;
+	} else if (IS_ERR(tp)) {
+		err = PTR_ERR(tp);
 		goto errout;
 	} else if (tca[TCA_KIND] && nla_strcmp(tca[TCA_KIND], tp->ops->kind)) {
 		NL_SET_ERR_MSG(extack, "Specified filter kind does not match existing one");
-- 
2.47.0


