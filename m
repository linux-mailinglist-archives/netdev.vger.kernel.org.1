Return-Path: <netdev+bounces-282010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK6LEojs8GmBbAEAu9opvQ
	(envelope-from <netdev+bounces-282010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:21:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF800489CFF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE84F30C256B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2960537BE94;
	Tue, 28 Apr 2026 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx568fe8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3E379EE0
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395860; cv=none; b=DY2/SNZgiK80U5FWBOT7ppCcxch0u5K9f2K1ZhsRgJsuxKqMsCUuPB5r5OUsEQpo9RIDCjL4sPZk4PdvQC04YFce7gwHcJ1s3Tlw7s7hlF+cy85LKIKP2LapSoZjAv3U+PkJKNLSuaugB+vNS0laorn+5Kjh6Jpo1l3UtgCKdbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395860; c=relaxed/simple;
	bh=wkTkUGn5w0x298A5D/1ipkya6hboovyUVKNvgO/cYYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GGs8RwlUk4pboyfy2GhuzX3BxtOiWFoxU95en7FWGJmTBNQDc/BUTur39nDP0cVgTBdNQbP5xDG+Om75xGS9hq8hMwp64aaGoZREHd6O9PKrCUllcIZcy3LIO6/Z2uhnArjx3i8ISzTneyGeGll+egoHqDjwghHye8rVtlKwUIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mx568fe8; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-6545a37ea2dso12846275d50.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777395858; x=1778000658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUbU5K6FT0AKJdqvw/ptsAYButAjGg0L1SpY29bEPPY=;
        b=Mx568fe8SLm5RcvaFQYksWNcYQOh+7MFcHbqGgghhnu2Lsy2WdCLRSIIpqGoHWjVyx
         lf2kQohVJVSiJQ86nW30SfIjWrE7LCXpAzjRmzPgUtyRA8pmr9qDtiMs72Ayl6JZYhQY
         1P8nq/hRKWcexm2Er4zqGCNgxaJOvAesgRenhtzec9XQSWaZWxMS3jzkiDQlo5LYPN22
         6O+VTjLp26m8xHPJTdyTNk+sdaH4WJ6bZKIlHUlfp+fQ4f+YEzWkAcCka3QoPC+TKlI3
         HVLkdBKo6sdgVj2cb057e37qGRaI4aXZoQbp72yCuoScmEbBM9J2TPQ0M2px0jd2xI5E
         7E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777395858; x=1778000658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUbU5K6FT0AKJdqvw/ptsAYButAjGg0L1SpY29bEPPY=;
        b=g4bT6gghNwYS2+VEZ5U7ZMJFsskaM//gsQ1dXfVLXWQY+rJQFQef6P7gdb7V/retQL
         lh06l9dOxHDamBPbgTOQ6uvHomxrNP/GgAMOj6uPuzN/crApUKNsM2Qhuoa5+rNPiexS
         hkHQkaPBYgDcMm8N21wunAAkM7Vw2J4neZCpVjEi13nc3zfAq8TJcALb6E4jjRkAtm/+
         WMRWDl0dS63J8p3z/S07j98E/ru+V+k2O7KbYVazpVxQ2lISair10r8urG2zv+OU//d/
         i87Ww2tNs/lG2iV2PAFSy4TPbEk5ZQW3c6Z+KWO7PU71jEAUT/KbZi+Jr7dMe7dt1Lul
         2BPA==
X-Forwarded-Encrypted: i=1; AFNElJ9ANFZow6zBWHkhd3zBCqWYUFVEfkVpugJiiVgCBp8IUgIhL5Ff5vzQpqqlNk1RfFJ4t0GJGOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqZB0ID+JBBEnbg7pQwmKYNX7k2fhE1OmdZwqoyvSnLKOsZCx
	HcboJBDqie3XtQlJ1LeMfTv98KVYK7bJydtjQVOMDOExLCH8w3fWC9jMvXHW5GdpzV0WENOM3IV
	qId4b9Z+/Do4/Pw==
X-Received: from yxtt28.prod.google.com ([2002:a05:690e:425c:b0:650:1566:cb5e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:4802:b0:653:f51:90b1 with SMTP id 956f58d0204a3-65beed7b720mr2733227d50.24.1777395857454;
 Tue, 28 Apr 2026 10:04:17 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:04:11 +0000
In-Reply-To: <20260428170414.250566-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428170414.250566-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428170414.250566-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] net/sched: propagate tc_fill_tclass() error
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EF800489CFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282010-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


