Return-Path: <netdev+bounces-282607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CLoH9DA8mnktwEAu9opvQ
	(envelope-from <netdev+bounces-282607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:39:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F172249C698
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 083783067764
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C2129B8D3;
	Thu, 30 Apr 2026 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jegVDQX8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430E2D3A7C
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516597; cv=none; b=tzIlCl4bu5CpEWSjDiFHgpBR6NzJ0FCarr2hHH2c6L6YmSxG+RLpRybY+xL0qUFyB7V5OAAR3ETKC7cTnuCdBeQU4rR+4euYknhIhbzQNkeGSuQOs6q04ZxjANALSWdC95Z+QHByBtyvlKSdNXFZ3TYmLcP1dMxBc0zIk0FLpJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516597; c=relaxed/simple;
	bh=kes0em7KyX+X3+uZDSg3HhTceol1YIQZO3ck8kUl+LE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nusJ8SuFfmbUBpgLWwOOpcLHTvOzKbHQ3IBVPKgRAUrDbkxM6X9IbTRowsi6i54rhjr8c8eP7FkCWuRIFGua7okkV7IA5F2F289YtgxlAtn+pbWAPeYVz1MyG+g7/44Ib4JIQv/LgCI+hD226A7a/+AJd+B+c0nBOBMLDhT4CEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jegVDQX8; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50d8e8c47a3so10275301cf.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 19:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777516595; x=1778121395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5wYTC/igEJZBfhCSA0wZFYeJ+noLTZl1EqWhi8CQxs=;
        b=jegVDQX8uwMuOWJ641FyUYX+BR72qAexpHt8/ddcJfT1YiprN/bDf30fYtIp42q4gl
         rbWPXxEnYO+qgjYaFn1YdQen00NrQZ9PF0b3wKcKYI1iQrBa11v95g2Mhsl6PqrTIv62
         W5ynFsDnbYURJU3FuUIMptkKJTblQydyv64DDF2HhTJ/nEDH1vPIHa4wgm1onPYM5YKJ
         +8QqgVTMvt3Lr4W7E8fzHcaSYKpmgLn8AxndBRNpXBHYVxuU8BOTh3ev8PEiizEoC7Wd
         LajJiuz9OpO1EVj+hQaTsMnAahKrm4uwTZSC+xTxZQ/XuziX2MGNNU7PLlDkxEoZ4QPX
         MZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777516595; x=1778121395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5wYTC/igEJZBfhCSA0wZFYeJ+noLTZl1EqWhi8CQxs=;
        b=Jee0F6+A0cMwKlwlWzJDaYfnQ9ePWcdt6OfF+0DgBFiKv8zmVnwn1qXs2r560f1Jq/
         u1bn7Jmz/yw4+heDkRrVaLdWAQhSVbqjQozhMOo7uydt62KaRpxh16ev+sOuNiieiuvV
         X8TO6X6za94IfdRss8SL+lTo8FldvKn3EbRmTRw2wU+92G2qC++J2K9slUlHnCF9aRBH
         ce6tmAMJrDlijmTr6flAFjAs6taS6Zk4W4ok2D8AD1xfVh5T1RTyBxbaohjFMpLXqBYo
         CfWBS9X4b02fXGdVqlssiErSpexNQyvwwImPPOMfA23zUCZtyoQf9scDYCn5+rFXW2Is
         dHQw==
X-Forwarded-Encrypted: i=1; AFNElJ9B8f2l9yKyHDXQ187DN4oM3cBf8RZq3STUuVjT90OGFq7RCELfYN2Dj6TNhOq1nLWYYHCLoJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Wjxk9XGXNWWFaxSEHmJLSo3XXBXbg5Vy50doaZBcZzDP0x/b
	KG+ImsCARxXkQCBGcm59sMdLv7eNwRubu/tKsOULVUexjRq7yDvxWCFeOQ7GRpcx1vDUnZo99Tf
	4x1jI+dpDWM2ytQ==
X-Received: from qtbcn9.prod.google.com ([2002:a05:622a:2489:b0:50f:b53f:6972])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7fcf:0:b0:50f:b604:6eb4 with SMTP id d75a77b69052e-5102add74d1mr15155481cf.35.1777516594889;
 Wed, 29 Apr 2026 19:36:34 -0700 (PDT)
Date: Thu, 30 Apr 2026 02:36:27 +0000
In-Reply-To: <20260430023628.3216283-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430023628.3216283-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430023628.3216283-4-edumazet@google.com>
Subject: [PATCH v3 net-next 3/4] net/sched: switch tc_dump_qdisc() to for_each_netdev_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F172249C698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282607-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Use for_each_netdev_dump() instead of for_each_netdev().

This is more scalable, and will ease RCU conversion.

This also offer better behavior when other threads
are adding or deleting netevices concurrently.

This enables dumping qdiscs for a single device
at user space request in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v3: removed s_ifindex (Jakub)

 net/sched/sch_api.c | 60 +++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 029e0f87ea9c61cc757432a07a6af92c90c551ef..cf3d01dd6b268741a6e4674954940e09dff139a4 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1877,18 +1877,17 @@ static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 
 static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct net *net = sock_net(skb->sk);
-	int idx, q_idx;
-	int s_idx, s_q_idx;
-	struct net_device *dev;
 	const struct nlmsghdr *nlh = cb->nlh;
+	struct net *net = sock_net(skb->sk);
 	struct nlattr *tca[TCA_MAX + 1];
+	struct {
+		unsigned long ifindex;
+		int q_idx;
+	} *ctx = (void *)cb->ctx;
+	struct net_device *dev;
+	int s_q_idx, q_idx;
 	int err;
 
-	s_idx = cb->args[0];
-	s_q_idx = q_idx = cb->args[1];
-
-	idx = 0;
 	ASSERT_RTNL();
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(struct tcmsg), tca, TCA_MAX,
@@ -1896,42 +1895,39 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 	if (err < 0)
 		return err;
 
-	for_each_netdev(net, dev) {
+	s_q_idx = ctx->q_idx;
+
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
 		struct netdev_queue *dev_queue;
+		struct Qdisc *q;
 
-		if (idx < s_idx)
-			goto cont;
-		if (idx > s_idx)
-			s_q_idx = 0;
 		q_idx = 0;
 
 		netdev_lock_ops(dev);
-		if (tc_dump_qdisc_root(rtnl_dereference(dev->qdisc),
-				       skb, cb, &q_idx, s_q_idx,
-				       true, tca[TCA_DUMP_INVISIBLE]) < 0) {
-			netdev_unlock_ops(dev);
-			goto done;
-		}
+		q = rtnl_dereference(dev->qdisc);
+		err = tc_dump_qdisc_root(q, skb, cb, &q_idx, s_q_idx,
+					 true, tca[TCA_DUMP_INVISIBLE]);
+		if (err < 0)
+			goto error_unlock;
 
 		dev_queue = dev_ingress_queue(dev);
-		if (dev_queue &&
-		    tc_dump_qdisc_root(rtnl_dereference(dev_queue->qdisc_sleeping),
-				       skb, cb, &q_idx, s_q_idx, false,
-				       tca[TCA_DUMP_INVISIBLE]) < 0) {
-			netdev_unlock_ops(dev);
-			goto done;
+		if (dev_queue) {
+			q = rtnl_dereference(dev_queue->qdisc_sleeping);
+			err = tc_dump_qdisc_root(q, skb, cb, &q_idx, s_q_idx,
+						 false, tca[TCA_DUMP_INVISIBLE]);
+			if (err < 0)
+				goto error_unlock;
 		}
 		netdev_unlock_ops(dev);
-
-cont:
-		idx++;
+		s_q_idx = 0;
 	}
+	return skb->len;
 
-done:
-	cb->args[0] = idx;
-	cb->args[1] = q_idx;
+error_unlock:
+	netdev_unlock_ops(dev);
+	ctx->q_idx = q_idx;
 
-	return skb->len;
+	return err;
 }
 
 
-- 
2.54.0.545.g6539524ca2-goog


