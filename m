Return-Path: <netdev+bounces-127967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65469773E5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F230285E77
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD811C230A;
	Thu, 12 Sep 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvlEuMEP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FFA5F
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177989; cv=none; b=hcorxBhP+E74M989gAwQ/nk2wrSEfgS1Fa9vPGTcsyqqBOlPh0oQn58f2WHFvsI1Vb4bTxdx5Gjo8yXBmYMW2khKzBzJRJh5UdCc+IMtNVsYdr+yOtFzWTrkRb0OwzFiee+2+GSZuLyjGC86a6TD9fM7yfyoVWqMJs1dEcdB6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177989; c=relaxed/simple;
	bh=M02Yp/++Q6/PamqLiLH8hwVR7m4vnsgGb1d97TzsVqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNaM67tHDPIl920eL2pMEXhRzhYeBylVn7sQHx51naoVe/U8A6Moq95LHscO/5tkmYBswxwDjrLRtpVdHFgP7+ZF5NHWT5r0TPTMIsCbHai029CcI+eymCy4D5cDepe/mrxwvkq8iquaBxEcC30smAs49Xzfae35JGE0lyT+1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvlEuMEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A23BC4CEC3;
	Thu, 12 Sep 2024 21:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726177988;
	bh=M02Yp/++Q6/PamqLiLH8hwVR7m4vnsgGb1d97TzsVqg=;
	h=From:To:Cc:Subject:Date:From;
	b=JvlEuMEPjjB9b31nhcgcJxAOvxwKcPOhRqD50LMyqGLOEoEKtAP9kKKgq+TkgzjO4
	 TZPjCEWq1xg7eeXBEPfQyRmvcTvSTTRKpppc7LrshTCmxdmZUyX5LkHAAVuBGfzLKh
	 dQdjjYykXgxbcJ1rRqMBKpJQqx0qvWyiOE+Y5Fj6XcV0FiSSI7tzdf4JML2rLgtOxF
	 esu9lmBSUQMYEA4LZKDh4eX7BSZjyUO84wDIzcKdxRie92/250KasSl7JQNoWVkr1W
	 IA0lhInWX4ke+LMjHkzXcev+Enh1R1F/fgJ9HaorVwI3xvxD+yrbwesMiaLDwOIMMg
	 KbCPPqSYFH8Zw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net-next] net: sched: cls_api: improve the error message for ID allocation failure
Date: Thu, 12 Sep 2024 14:53:06 -0700
Message-ID: <20240912215306.2060709-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
---
 net/sched/cls_api.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 17d97bbe890f..a2e5c7975dda 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1932,7 +1932,8 @@ static void tcf_chain_tp_remove(struct tcf_chain *chain,
 static struct tcf_proto *tcf_chain_tp_find(struct tcf_chain *chain,
 					   struct tcf_chain_info *chain_info,
 					   u32 protocol, u32 prio,
-					   bool prio_allocate);
+					   bool prio_allocate,
+					   struct netlink_ext_ack *extack);
 
 /* Try to insert new proto.
  * If proto with specified priority already exists, free new proto
@@ -1957,7 +1958,7 @@ static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain *chain,
 	}
 
 	tp = tcf_chain_tp_find(chain, &chain_info,
-			       protocol, prio, false);
+			       protocol, prio, false, NULL);
 	if (!tp)
 		err = tcf_chain_tp_insert(chain, &chain_info, tp_new);
 	mutex_unlock(&chain->filter_chain_lock);
@@ -2017,7 +2018,8 @@ static void tcf_chain_tp_delete_empty(struct tcf_chain *chain,
 static struct tcf_proto *tcf_chain_tp_find(struct tcf_chain *chain,
 					   struct tcf_chain_info *chain_info,
 					   u32 protocol, u32 prio,
-					   bool prio_allocate)
+					   bool prio_allocate,
+					   struct netlink_ext_ack *extack)
 {
 	struct tcf_proto **pprev;
 	struct tcf_proto *tp;
@@ -2028,9 +2030,14 @@ static struct tcf_proto *tcf_chain_tp_find(struct tcf_chain *chain,
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
@@ -2043,6 +2050,7 @@ static struct tcf_proto *tcf_chain_tp_find(struct tcf_chain *chain,
 		tcf_proto_get(tp);
 	} else {
 		chain_info->next = NULL;
+		NL_SET_ERR_MSG(extack, "Filter with specified priority/protocol not found");
 	}
 	return tp;
 }
@@ -2311,9 +2319,8 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 	mutex_lock(&chain->filter_chain_lock);
 	tp = tcf_chain_tp_find(chain, &chain_info, protocol,
-			       prio, prio_allocate);
+			       prio, prio_allocate, extack);
 	if (IS_ERR(tp)) {
-		NL_SET_ERR_MSG(extack, "Filter with specified priority/protocol not found");
 		err = PTR_ERR(tp);
 		goto errout_locked;
 	}
@@ -2538,9 +2545,8 @@ static int tc_del_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 	mutex_lock(&chain->filter_chain_lock);
 	tp = tcf_chain_tp_find(chain, &chain_info, protocol,
-			       prio, false);
+			       prio, false, extack);
 	if (!tp || IS_ERR(tp)) {
-		NL_SET_ERR_MSG(extack, "Filter with specified priority/protocol not found");
 		err = tp ? PTR_ERR(tp) : -ENOENT;
 		goto errout_locked;
 	} else if (tca[TCA_KIND] && nla_strcmp(tca[TCA_KIND], tp->ops->kind)) {
@@ -2678,10 +2684,9 @@ static int tc_get_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 	mutex_lock(&chain->filter_chain_lock);
 	tp = tcf_chain_tp_find(chain, &chain_info, protocol,
-			       prio, false);
+			       prio, false, extack);
 	mutex_unlock(&chain->filter_chain_lock);
 	if (!tp || IS_ERR(tp)) {
-		NL_SET_ERR_MSG(extack, "Filter with specified priority/protocol not found");
 		err = tp ? PTR_ERR(tp) : -ENOENT;
 		goto errout;
 	} else if (tca[TCA_KIND] && nla_strcmp(tca[TCA_KIND], tp->ops->kind)) {
-- 
2.46.0


