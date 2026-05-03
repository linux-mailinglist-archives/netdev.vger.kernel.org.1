Return-Path: <netdev+bounces-283591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBVAGFE192nQdQIAu9opvQ
	(envelope-from <netdev+bounces-283591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:45:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 099754B5561
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D433300360B
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 11:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA4D224FA;
	Sun,  3 May 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5PWdkne"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501BB40DFA3
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777808719; cv=none; b=J9NFjkIZPrQxzTZtYs4vNrAIMjfiDckgMYnZhCpKCbOYqky9rx8gYojcoXRCoCLt0ldVbtVWezeFDoYSyTQx02G9rbsROhI9NO17DOCx8iUKiDMk/douZr0N00mzhFQ87EdyK2kHMGRmdhR+0R9o+zU53JKZZjfeRFaV5oWe190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777808719; c=relaxed/simple;
	bh=F/1AOHhORGCKhrvGjcUKSG2ImXeKfYH7GMrIpaI0l/M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FtzfACZppClvjUSh8dbgy+k8ylrXdvXwzN/wH9HnE00FOeLxOFlEvSdKm5CxnT5DsUWgFbIReEw63+wXq3SDMWuH53b/+/qsT0+/9bawYDQST16oWRIW5tArzd7bOHSZe3/LGO2Tdd1Lu20NsDLnEe4xUNLGnzYg3L6knutvaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5PWdkne; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d8ed08aa4so113583431cf.3
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777808717; x=1778413517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mwuLGjkyxBaVr6rJ7EpSKstYmcqsoTA6akcP7MmFMVk=;
        b=N5PWdknerOX/j3ZAnvA5sSmDuH3dTcy3M7rDrGsDca7oyDgemErjFMtMCd7GHZfQW0
         ARMed8RJj7G5T7x2Af1hdE86LfsxGm3rVcfjcE9zWVfERaBv6cQjvvk9cZea+Tq6AHbo
         3j94B8FBqWFzlxabSMPSu+ZYb+4WhLBNa4/gldSvKfkdui6HGCiSZrVK6IFDZ2Rx2ii3
         tKaTqkOnqReycPc3XnpPhjcauXCwiB2Yv5F71s3IWeylklu9dZNYdH6YSBrkddgIOV/0
         bbGpvuzvo9Pd0P/rlNwpbcraXV+KadkCVQ1E3NbbQQ9RsScoiGkU5XE8HMgrUeeDBcwA
         k81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777808717; x=1778413517;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwuLGjkyxBaVr6rJ7EpSKstYmcqsoTA6akcP7MmFMVk=;
        b=ASYdG9ZcvRqCEQGSFO8Etppesub2I8em4Tto4PfHgsW+aZfjKt1JpIh9R+3Ul8qci7
         AU2E+VuA5K8RFsyEPbObpeMNUullDcpOXo/slDtOohu+rcGPaWJV1Zp6926Im0GKOy2F
         XB3Nte/yGd5rfzfDyfB6Eri7HC8QSD7deUHEhb2BkwxDMgjQ2dj3jpuzg7bvJ6a/zQUR
         przS8uAUtWvLnYVWdkh5tE7ie23I9Bs9oFWMS5wiIqMglLS/dssyJe/YRY5a9BupVF9k
         ellIZ8YDlpL0KR8N+QxyQpma6nCIjjFlgZqtbv+ut5CpL1XX7yt5GjfRaAZefG6D/BwQ
         mJig==
X-Forwarded-Encrypted: i=1; AFNElJ91FFt74i/AstTY/MM/qMH3ASzjjcQ4kcGvDDynqlK+Czk6blBfSdFQQkCNArBTnOZ1//CvG48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyBVKqFqIqOmZXaUlfoLhqhChjYkeQtUerhWa605NuGGZGF4V
	OeB5A4IGSKsZSwpas4jGqeTk7PboU3fe5KukZgyZ2VcKX8gbaA0TMADDTGIp6XkfjqGV0+pYkyS
	DbYM07oq49IqVjg==
X-Received: from qtbfu3.prod.google.com ([2002:a05:622a:5d83:b0:50e:62a8:855])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1649:b0:509:1ffc:c538 with SMTP id d75a77b69052e-5104be11636mr93380611cf.19.1777808717100;
 Sun, 03 May 2026 04:45:17 -0700 (PDT)
Date: Sun,  3 May 2026 11:45:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503114515.2460477-1-edumazet@google.com>
Subject: [PATCH net-next] net/sched: speedup tc_dump_qdisc() when tcm_handle
 is provided
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 099754B5561
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283591-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

"tc qdisc show ... handle xxx" filtering can be done by the kernel.

A followup patch can do the same for tcm_parent.

iproute2/tc needs a small companion patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index dd0edc9bd4610ec865fc97a81f801a7da020667b..6f7847c5536f16e6754954f0a606581e17257361 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -979,13 +979,17 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 	return -EMSGSIZE;
 }
 
-static bool tc_qdisc_dump_ignore(struct Qdisc *q, bool dump_invisible)
+static bool tc_qdisc_dump_ignore(struct Qdisc *q, bool dump_invisible,
+				 const struct tcmsg *tcm)
 {
 	if (q->flags & TCQ_F_BUILTIN)
 		return true;
 	if ((q->flags & TCQ_F_INVISIBLE) && !dump_invisible)
 		return true;
-
+	if (tcm) {
+		if (tcm->tcm_handle && tcm->tcm_handle != q->handle)
+			return true;
+	}
 	return false;
 }
 
@@ -1000,7 +1004,7 @@ static int qdisc_get_notify(struct net *net, struct sk_buff *oskb,
 	if (!skb)
 		return -ENOBUFS;
 
-	if (!tc_qdisc_dump_ignore(q, false)) {
+	if (!tc_qdisc_dump_ignore(q, false, NULL)) {
 		if (tc_fill_qdisc(skb, q, clid, portid, n->nlmsg_seq, 0,
 				  RTM_NEWQDISC, extack) < 0)
 			goto err_out;
@@ -1030,12 +1034,12 @@ static int qdisc_notify(struct net *net, struct sk_buff *oskb,
 	if (!skb)
 		return -ENOBUFS;
 
-	if (old && !tc_qdisc_dump_ignore(old, false)) {
+	if (old && !tc_qdisc_dump_ignore(old, false, NULL)) {
 		if (tc_fill_qdisc(skb, old, clid, portid, n->nlmsg_seq,
 				  0, RTM_DELQDISC, extack) < 0)
 			goto err_out;
 	}
-	if (new && !tc_qdisc_dump_ignore(new, false)) {
+	if (new && !tc_qdisc_dump_ignore(new, false, NULL)) {
 		if (tc_fill_qdisc(skb, new, clid, portid, n->nlmsg_seq,
 				  old ? NLM_F_REPLACE : 0, RTM_NEWQDISC, extack) < 0)
 			goto err_out;
@@ -1825,21 +1829,24 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 			      int *q_idx_p, int s_q_idx, bool recur,
 			      bool dump_invisible)
 {
+	const struct nlmsghdr *nlh = cb->nlh;
 	int ret = 0, q_idx = *q_idx_p;
+	const struct tcmsg *tcm;
 	struct Qdisc *q;
 	int b;
 
 	if (!root)
 		return 0;
 
+	tcm = nlmsg_data(nlh);
 	q = root;
 	if (q_idx < s_q_idx) {
 		q_idx++;
 	} else {
-		if (!tc_qdisc_dump_ignore(q, dump_invisible))
+		if (!tc_qdisc_dump_ignore(q, dump_invisible, tcm))
 		    ret = tc_fill_qdisc(skb, q, q->parent,
 					NETLINK_CB(cb->skb).portid,
-					cb->nlh->nlmsg_seq, NLM_F_MULTI,
+					nlh->nlmsg_seq, NLM_F_MULTI,
 					RTM_NEWQDISC, NULL);
 		if (ret < 0)
 			goto out;
@@ -1860,10 +1867,10 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 			q_idx++;
 			continue;
 		}
-		if (!tc_qdisc_dump_ignore(q, dump_invisible))
+		if (!tc_qdisc_dump_ignore(q, dump_invisible, tcm))
 			ret = tc_fill_qdisc(skb, q, q->parent,
 					    NETLINK_CB(cb->skb).portid,
-					    cb->nlh->nlmsg_seq, NLM_F_MULTI,
+					    nlh->nlmsg_seq, NLM_F_MULTI,
 					    RTM_NEWQDISC, NULL);
 		if (ret < 0)
 			goto out;
@@ -2341,7 +2348,7 @@ static int tc_dump_tclass_qdisc(struct Qdisc *q, struct sk_buff *skb,
 {
 	struct qdisc_dump_args arg;
 
-	if (tc_qdisc_dump_ignore(q, false) ||
+	if (tc_qdisc_dump_ignore(q, false, NULL) ||
 	    *t_p < s_t || !q->ops->cl_ops ||
 	    (tcm->tcm_parent &&
 	     TC_H_MAJ(tcm->tcm_parent) != q->handle)) {
-- 
2.54.0.545.g6539524ca2-goog


