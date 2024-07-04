Return-Path: <netdev+bounces-109198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCE692751F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF5C1C24193
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4FF1AC420;
	Thu,  4 Jul 2024 11:27:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A2E1AC22A
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092429; cv=none; b=t+e0NgBrkA8pdqnu4Likl7sxihlclpcYla6Q3gn8SQWxTJKP98OxLNzO+Z+R2iw6cHM3fRpS3CBeuOBP4vy/ZPYdDnCGamSCcZbxfdEgEumj2/vno95a1Bthw83YEWE5obI7YKbTtyGJX46VF2o+cHzbycqnpa6yAhSfB4SKmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092429; c=relaxed/simple;
	bh=vmZNQFIybosTwNS6y//7jK6Y0gPPx4WGbZWsvixdLjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEMTKtnEu2xXVXiCvFVtDZJd8oh//Sp+Su0pLepLoRzAF8HXHbf2uv7Y+tt2DphJDU/17wkH+OYn6200e1GCatcS+Pg1rcNdQJXHStD9MFp+Kta2sxtVjkYHCl57uM3xCJ1i3ObVJLVxlYAt5PNnVHjVNkBzEeU7ngixL4rEvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sPKcA-0008UX-PE; Thu, 04 Jul 2024 13:27:02 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	jhs@mojatatu.com
Subject: [PATCH net-next v2] act_ct: prepare for stolen verdict coming from conntrack and nat engine
Date: Thu,  4 Jul 2024 13:29:20 +0200
Message-ID: <20240704112925.10975-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At this time, conntrack either returns NF_ACCEPT or NF_DROP.
To improve debuging it would be nice to be able to replace NF_DROP verdict
with NF_DROP_REASON() helper,

This helper releases the skb instantly (so drop_monitor can pinpoint
exact location) and returns NF_STOLEN.

Prepare call sites to deal with this before introducing such changes
in conntrack and nat core.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 No changes, v1 errounously targetted 'net' tree.

 net/sched/act_ct.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 2a96d9c1db65..a6b7c514a181 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -944,6 +944,8 @@ static int tcf_ct_act_nat(struct sk_buff *skb,
 		action |= BIT(NF_NAT_MANIP_DST);
 
 	err = nf_ct_nat(skb, ct, ctinfo, &action, range, commit);
+	if (err != NF_ACCEPT)
+		return err & NF_VERDICT_MASK;
 
 	if (action & BIT(NF_NAT_MANIP_SRC))
 		tc_skb_cb(skb)->post_ct_snat = 1;
@@ -1035,7 +1037,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		state.pf = family;
 		err = nf_conntrack_in(skb, &state);
 		if (err != NF_ACCEPT)
-			goto out_push;
+			goto nf_error;
 	}
 
 do_nat:
@@ -1047,7 +1049,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 
 	err = tcf_ct_act_nat(skb, ct, ctinfo, p->ct_action, &p->range, commit);
 	if (err != NF_ACCEPT)
-		goto drop;
+		goto nf_error;
 
 	if (!nf_ct_is_confirmed(ct) && commit && p->helper && !nfct_help(ct)) {
 		err = __nf_ct_try_assign_helper(ct, p->tmpl, GFP_ATOMIC);
@@ -1061,8 +1063,9 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	}
 
 	if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helper) : commit) {
-		if (nf_ct_helper(skb, ct, ctinfo, family) != NF_ACCEPT)
-			goto drop;
+		err = nf_ct_helper(skb, ct, ctinfo, family);
+		if (err != NF_ACCEPT)
+			goto nf_error;
 	}
 
 	if (commit) {
@@ -1075,8 +1078,9 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		/* This will take care of sending queued events
 		 * even if the connection is already confirmed.
 		 */
-		if (nf_conntrack_confirm(skb) != NF_ACCEPT)
-			goto drop;
+		err = nf_conntrack_confirm(skb);
+		if (err != NF_ACCEPT)
+			goto nf_error;
 	}
 
 	if (!skip_add)
@@ -1100,6 +1104,21 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 drop:
 	tcf_action_inc_drop_qstats(&c->common);
 	return TC_ACT_SHOT;
+
+nf_error:
+	/* some verdicts store extra data in upper bits, such
+	 * as errno or queue number.
+	 */
+	switch (err & NF_VERDICT_MASK) {
+	case NF_DROP:
+		goto drop;
+	case NF_STOLEN:
+		tcf_action_inc_drop_qstats(&c->common);
+		return TC_ACT_CONSUMED;
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		goto drop;
+	}
 }
 
 static const struct nla_policy ct_policy[TCA_CT_MAX + 1] = {
-- 
2.44.2


