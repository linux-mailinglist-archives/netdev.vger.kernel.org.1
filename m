Return-Path: <netdev+bounces-218295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1D7B3BCDC
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E16C16A5DB
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1618531AF21;
	Fri, 29 Aug 2025 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=club1.fr header.i=@club1.fr header.b="AcRbtO+T"
X-Original-To: netdev@vger.kernel.org
Received: from mail.club1.fr (87-91-4-64.abo.bbox.fr [87.91.4.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D61EE7DD
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.91.4.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475566; cv=none; b=VZRktpTi6HipZIPLA4VIT8fxiVhrvulsGekG+MpcbRwXCyOgubGQWjiUTkJwy4PUqNr9invRbvpHR8pIwTmZm4D6hHOSlAty2mALgJHriv/Qs9/6Ck/QSNmJm4TXittks9kMXliy6b03PbUY/P9UP5JI5bTSDf7bdXmS+y4RxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475566; c=relaxed/simple;
	bh=XTSqeWEC/mfkT3J/rYSl7NpbbUiyfVXt3ynyg/0b9Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jRQ8tPj0pfzLdpb22QsZCd7MJvVh+ng8tFsMguf7tmw50FqWlbX0JVVIMFfcOIpeRK5YLm/q/QDks9xZsVM7i/80S408streXiFyshQ8JVOTvQAiS/LWnY/q2fDeZKXXrADLzDVBzFBLGpJ5VBh3DfGxOYk8XmecPlqMnuFHCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=club1.fr; spf=pass smtp.mailfrom=club1.fr; dkim=pass (2048-bit key) header.d=club1.fr header.i=@club1.fr header.b=AcRbtO+T; arc=none smtp.client-ip=87.91.4.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=club1.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=club1.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=club1.fr; s=default;
	t=1756475066; bh=XTSqeWEC/mfkT3J/rYSl7NpbbUiyfVXt3ynyg/0b9Kw=;
	h=Date:From:To:Cc:From;
	b=AcRbtO+TztSZU4R/MpFS/Pbr8SjAGigpJ1g2E7/BevJ31FmY8pCsvywQYbr6Uc0ge
	 4/aH/UJ4LXyCSyKMdNdoM5bltanRCvWM5+CqzojCsiU3in2Lmm2Rqjubq7SOvNLTpi
	 Y+JkKqUGr6ZKVHzzsrdEXHIWCyMv5XNpfQnE5PBkrJ4gARYSHMvm+UiZJMC8+5rOmz
	 JmGFuMdJhfbf5QfK3my3XXkPxA+/7O2p4/1uvEAjFzguJ436T6sJuHTZSLaif9u4T+
	 udt/O5pyKr6CYgcCdgzuonsK6cX8Qun5wwUl2iEdrdV7kBgpVCPqoIFkC7tSnWvgTe
	 5/Y55QRUQm4gw==
Received: from poste8964.lip6.fr (unknown [IPv6:2001:660:3302:2826:89e1:9537:a78d:c8e3])
	by mail.club1.fr (Postfix) with ESMTPSA id 53F7343A9C;
	Fri, 29 Aug 2025 15:44:26 +0200 (CEST)
Date: Fri, 29 Aug 2025 15:44:24 +0200
From: Nicolas Peugnet <nicolas@club1.fr>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [RFC PATCH] net/sched: make drr play nicely with non-work-conserving
 qdiscs
Message-ID: <aLGuuBQPpOqZWJuD@poste8964.lip6.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, this is my first time trying to contribute to Linux, so I will
probably make a lot of mistakes, apologies in advance.

I wanted to use a classful qdisc to set multiple netem qdiscs on an
iterface with different parameters and filters to classify packets.

Among all classful qdiscs, PRIO is the only one until now that plays
nicely with inner non-work-conserving qdiscs, but it is limited to 16
bands/classes and it has some level of integrated priorisation logic.
DRR on the other hand is the closest qdisc we have to a fully generic
classful qdisc without any integrated logic, but it currently does not
work correctly with non-work-conserving qdiscs.

This patch allows DRR to play nicely with inner non-work-conserving
qdiscs. Instead of returning NULL when the current active class returns
NULL (i.e. its qdisc is non-work-conserving), we iterate over each
active classes once until we find one ready to dequeue. This allows not
to delay the following queues if the first one is slower.

Of course, the complexity is not O(1) any more, as we potentially
iterate once over each active class. But this will only happen if the
inner qdiscs are non-work-conserving, a use-case that was previously not
working correctly anyway.

The documentation of tc-drr(8) will have to be updated to reflect this
change, explaning that non-work-conserving qdiscs are supported but that
the complexity is not O(1) in this case.

This is a proof of concept, it may most likely be optimized by using
list_bulk_move_tail() only once we find a class ready to dequeue instead
of calling list_move_tail() on each iteration.

This is a Request For Comments, as I would like to know if other people
would be interested by such a change and if the implementation make at
least a bit of sense to anyone else than me.

Signed-off-by: Nicolas Peugnet <nicolas@club1.fr>
---
 net/sched/sch_drr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 9b6d79bd8737..8078bdf88150 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -373,6 +373,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 {
 	struct drr_sched *q = qdisc_priv(sch);
+	struct list_head *first;
 	struct drr_class *cl;
 	struct sk_buff *skb;
 	unsigned int len;
@@ -380,11 +381,15 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 	if (list_empty(&q->active))
 		goto out;
 	while (1) {
-		cl = list_first_entry(&q->active, struct drr_class, alist);
-		skb = cl->qdisc->ops->peek(cl->qdisc);
-		if (skb == NULL) {
-			qdisc_warn_nonwc(__func__, cl->qdisc);
-			goto out;
+		first = q->active.next;
+		while (1) {
+			cl = list_first_entry(&q->active, struct drr_class, alist);
+			skb = cl->qdisc->ops->peek(cl->qdisc);
+			if (skb != NULL)
+				break;
+			list_move_tail(&cl->alist, &q->active);
+			if (q->active.next == first)
+				goto out;
 		}
 
 		len = qdisc_pkt_len(skb);
-- 
2.39.5


