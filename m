Return-Path: <netdev+bounces-266410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE+qKKbJsGk8nAIAu9opvQ
	(envelope-from <netdev+bounces-266410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:47:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2019725A7D3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19CF83056663
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DE31A3164;
	Wed, 11 Mar 2026 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hC9iKbFL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071413DDA4;
	Wed, 11 Mar 2026 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193635; cv=none; b=LSAaDF8qfXQN7GFsdnYIlJ3KGu8eXUKupwAPdabHlBZES5CFwPi/WKk8xD7a8mSnsGahSir7KRShPWtGl7q5xAAysSg1z4xqpO5or3olwJqHr3OYhtppl4rGAcBKfV+mIDdE6D3P1D2s14i/qpOi75rmPw90rrYH8tEYNU/w894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193635; c=relaxed/simple;
	bh=og1LLtXorZrs+Q+bQZo49nlyuGcPsXUkWjbetN4e8Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSqQxdr3rSM1iM162qJew2qYegoxeHOliZOzrCDzOrPlJEAtk/N4gzsk7h7LEHj8YChHNQTHYYUQv5B1i8jUqwesf14J8tksTDysyA4QtpteAJzk+22v70c6N+RgFB/nI6G/jft8+bTgE6lq06dCWfDFo4E///DiBZ0mp3ui2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hC9iKbFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C723CC19423;
	Wed, 11 Mar 2026 01:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773193635;
	bh=og1LLtXorZrs+Q+bQZo49nlyuGcPsXUkWjbetN4e8Y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hC9iKbFLOvNhBKvS7YoJYNwqhg68O/CbQNlPatn8SqrBKkGxVp5RcQvmw2PPwh/vR
	 mfPDuDbYTKiHxeVdoCym+69abXYTPJLNWRUn9hNrg43aij5TJrdIVtAgLFieEX/8h0
	 0dMgjklpi1+S4pqYoxk3WpsVTiZY0Dvzg/LFVAX3/8QBtxKDgGCfwhZ2B644nSVURf
	 mvKRcJimn4BFyZjJ/nePbYCfywjRdNUHhrveQGNt+/t6CbJMVdlQvGT7kyWCtsDMnA
	 RjjdQ3wRvSq0N3bZ2uwo5FOfUU1Ze7VWHgOtmgtiHN2SKMR+nzC6S7oUDHhfDaPNMc
	 NxYTehWIgxo3g==
Date: Tue, 10 Mar 2026 18:47:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk,
 vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com,
 cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com,
 km.kim1503@gmail.com, security@kernel.org, Victor Nogueira
 <victor@mojatatu.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot
 delete
Message-ID: <20260310184713.7e810431@kernel.org>
In-Reply-To: <20260307212058.169511-1-jhs@mojatatu.com>
References: <20260307212058.169511-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2019725A7D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266410-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,toke.dk,intel.com,networkplumber.org,nvidia.com,lists.bufferbloat.net,gmail.com,mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat,  7 Mar 2026 16:20:58 -0500 Jamal Hadi Salim wrote:
> Note: We tried a couple of different approaches that had smaller code
> footprint but were a bit fugly. The first approach was to use recursion
> on the qdisc hash table to iterate the descendants of the qdisc; however,
> the challenge here is if the graph depth is "high" - we may overflow the
> stack. The second approach was to use a breadth first search to achieve
> the same goal; the challenge here was it was a quadratic algorithm.

Lots of complexity when realistically only ingress/clsact support 
the unlocked operations. Can we not just take rtnl before the
references and not bother all the real qdiscs with this @#%$ ?
(diff just to illustrate the point not even compiled)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4829c27446e3..21b461f3323d 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2255,6 +2255,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	int err;
 	int tp_created;
 	bool rtnl_held = false;
+	bool rtnl_take = false
 	u32 flags;
 
 replay:
@@ -2290,11 +2291,17 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		}
 	}
 
+	/* Realistically only INGRESS supports unlocked ops */
+	if (parent != TC_H_INGRESS) {
+		rtnl_held = true;
+		rtnl_lock();
+	}
+
 	/* Find head of filter chain. */
 
 	err = __tcf_qdisc_find(net, &q, &parent, t->tcm_ifindex, false, extack);
 	if (err)
-		return err;
+		goto errout;
 
 	if (tcf_proto_check_kind(tca[TCA_KIND], name)) {
 		NL_SET_ERR_MSG(extack, "Specified TC filter name too long");
@@ -2306,11 +2313,12 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	 * block is shared (no qdisc found), qdisc is not unlocked, classifier
 	 * type is not specified, classifier is not unlocked.
 	 */
-	if (rtnl_held ||
+	if (rtnl_take ||
 	    (q && !(q->ops->cl_ops->flags & QDISC_CLASS_OPS_DOIT_UNLOCKED)) ||
 	    !tcf_proto_is_unlocked(name)) {
+		if (!rtnl_held)
+			rtnl_lock();
 		rtnl_held = true;
-		rtnl_lock();
 	}
 
 	err = __tcf_qdisc_cl_find(q, parent, &cl, t->tcm_ifindex, extack);
@@ -2451,17 +2459,16 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 	tcf_block_release(q, block, rtnl_held);
 
-	if (rtnl_held)
-		rtnl_unlock();
-
 	if (err == -EAGAIN) {
 		/* Take rtnl lock in case EAGAIN is caused by concurrent flush
 		 * of target chain.
 		 */
-		rtnl_held = true;
+		rtnl_take = true;
 		/* Replay the request. */
 		goto replay;
 	}
+	if (rtnl_held)
+		rtnl_unlock();
 	return err;
 
 errout_locked:

