Return-Path: <netdev+bounces-281324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFTFKfRj72mHAwEAu9opvQ
	(envelope-from <netdev+bounces-281324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:26:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8E947359E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EACE63009880
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B183C870E;
	Mon, 27 Apr 2026 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlVVG4QW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FB3BB9FC
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296362; cv=none; b=qcrlTsrbmVkRogIZb1oAyfNbnPeNQ4jgsU6rZBYqd8xiJqahx3wvK6cuIYYdf1KO80eGecvt/g6bvk0++23Zg/L77yvBHOPZyvbcqC+7etFCEwa1iF3ABHzkaX+lPysIi9fhpsgETp0xgTuvjqI2PCc1BpZh3i+SGT2K/CC3Lao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296362; c=relaxed/simple;
	bh=wkTkUGn5w0x298A5D/1ipkya6hboovyUVKNvgO/cYYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B0YaqX8vBlw2kLYayQhMJ6jl2DS/vwRNPmh9sgpZAH3QmePB//6n2v8BKqZ5yhDzv1MxJ+Zzv+d1S2JtkmoQc4IHJyanqmSNjIwtxXKXsoq2SZ9rx+mn0CHSh8HTHqyw374jrfOWJE3yNLQMpFjjbZdaumbshqa2e7kL4yEHKWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QlVVG4QW; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50fb6d713ddso116930891cf.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777296359; x=1777901159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUbU5K6FT0AKJdqvw/ptsAYButAjGg0L1SpY29bEPPY=;
        b=QlVVG4QWDwU/gM/TYeN4ozOr/zsNf4JIkwBTlxxEfOKHMBNkBiX+mB/CPigOpOKncC
         BfrMlf8RwZhZTwO76prRXhR2RBkDrOkMPHeAFRXQdaMDP4m+o7euD2XANp2MWCNKETQG
         3OUSTiKXeU2fT2ahrnzB72wwzKoxmeX4zBEliW7058SNcp5nrhj4SFaAiVrDtGyrn1Wc
         pWxWvl3o5PcVRVqU4oJYlBhZoemNEWusPLEOAsxKpIppRxB0cLs376MeTpjVlir0Wl2p
         ICUeNoKWjVjotjHAc5WPo3daIt2Ah4Yr4AWoJ3Aav1wlG0WrwcXAS2hmVcgzDO8VsvMf
         WF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777296359; x=1777901159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUbU5K6FT0AKJdqvw/ptsAYButAjGg0L1SpY29bEPPY=;
        b=MsBavV1x33iLs5iiAjhXyAljbdc+QqvWDw6WkuQT2iB+xAZ8OWMPSrIt4eV2KXs0Tn
         6FoZfz2OlXS0yDIlvWLhjtq44HCt1mti2tUiDzoLLGQygqBew2/tmQ9Wty2z0iUVj9aR
         yTm0ss7/BlAjO3dTm1MEWvCtTIeX3FZor78J7t2VrZ8kwSt4f+n+87xleq2Fx3/N88lx
         7YHJK4loK+Q7E8VIN+1AyO/PAZjPN6qR4rgqA6cpTT8mneEDIS5LrrAo2iTyQvGYijqr
         qph+U3wNBdRLo08grK13jG5WXU8nOOAjQgCqfj0+vNRruP/6q8LqVMjbA1zAZxb8nlz0
         /tGg==
X-Forwarded-Encrypted: i=1; AFNElJ8XXnd2QPys6E/lng+OjYU83ikZ1efrOv5kaO8nyNbbwwqZjbNt4yIasQ9u6f9kvPsNhq0ZgGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjiAtm+SMz2MLdp585vzWFspdtr98XoYsJoqw4LQ5SxkfqQCUm
	9YNVvSuJ6Bq8O50O6srayxD13E05gSz3F7dtK4/nZjuLOBXZ3ZMF0E+ciZXdsh+Xq1wcpC2dYsK
	YJfNf8WVXl3Ahwg==
X-Received: from qtbmd11.prod.google.com ([2002:a05:622a:468b:b0:50e:5ea2:deec])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4d2:b0:50f:be4f:465a with SMTP id d75a77b69052e-50fbe4f4947mr346035781cf.50.1777296359225;
 Mon, 27 Apr 2026 06:25:59 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:25:52 +0000
In-Reply-To: <20260427132555.1791636-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427132555.1791636-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427132555.1791636-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] net/sched: propagate tc_fill_tclass() error
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8E8E947359E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281324-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Change tc_fill_tclass() to return -EMSGSIZE when skb is too small.

Change its caller to propagate this error (instead of -EINVAL)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_api.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index ed869a5ffc7377b7c19e66ae5fc9788e709488da..32ccd4672083aa19340520155aeba6d8b6ff546c 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1987,15 +1987,16 @@ static int tc_fill_tclass(struct sk_buff *skb, struct Qdisc *q,
 out_nlmsg_trim:
 nla_put_failure:
 	nlmsg_trim(skb, b);
-	return -1;
+	return -EMSGSIZE;
 }
 
 static int tclass_notify(struct net *net, struct sk_buff *oskb,
 			 struct nlmsghdr *n, struct Qdisc *q,
 			 unsigned long cl, int event, struct netlink_ext_ack *extack)
 {
-	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
+	struct sk_buff *skb;
+	int ret;
 
 	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
 		return 0;
@@ -2004,9 +2005,10 @@ static int tclass_notify(struct net *net, struct sk_buff *oskb,
 	if (!skb)
 		return -ENOBUFS;
 
-	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, event, extack) < 0) {
+	ret = tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, event, extack);
+	if (ret < 0) {
 		kfree_skb(skb);
-		return -EINVAL;
+		return ret;
 	}
 
 	return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
@@ -2017,17 +2019,19 @@ static int tclass_get_notify(struct net *net, struct sk_buff *oskb,
 			     struct nlmsghdr *n, struct Qdisc *q,
 			     unsigned long cl, struct netlink_ext_ack *extack)
 {
-	struct sk_buff *skb;
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
+	struct sk_buff *skb;
+	int ret;
 
 	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
-	if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0, RTM_NEWTCLASS,
-			   extack) < 0) {
+	ret = tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
+			     RTM_NEWTCLASS, extack);
+	if (ret < 0) {
 		kfree_skb(skb);
-		return -EINVAL;
+		return ret;
 	}
 
 	return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
@@ -2041,7 +2045,7 @@ static int tclass_del_notify(struct net *net,
 			     struct netlink_ext_ack *extack)
 {
 	u32 portid = oskb ? NETLINK_CB(oskb).portid : 0;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	int err = 0;
 
 	if (!cops->delete)
@@ -2052,13 +2056,12 @@ static int tclass_del_notify(struct net *net,
 		if (!skb)
 			return -ENOBUFS;
 
-		if (tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
-				   RTM_DELTCLASS, extack) < 0) {
+		err = tc_fill_tclass(skb, q, cl, portid, n->nlmsg_seq, 0,
+				     RTM_DELTCLASS, extack);
+		if (err < 0) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return err;
 		}
-	} else {
-		skb = NULL;
 	}
 
 	err = cops->delete(q, cl, extack);
-- 
2.54.0.545.g6539524ca2-goog


