Return-Path: <netdev+bounces-262237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMJxFuRpo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:19:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B68891C9719
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 558E6307339A
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0267E3D4109;
	Sat, 28 Feb 2026 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcxAFUQY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABEC3D413D
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317091; cv=none; b=A4tIhOqm1riQqEXPk5BlUSXjwhT5gmjoc/AvjwpSKVYCcPdsT01GtasTlviI0zc/0H571NCP27NIAO7Di1gc9UE2X/+qzgSrtu5Bm77/2HaNpYQYE+YK3S63cXHX7Bn+5oSnbhnUJ453gTdb92s8+xAGn+tdHZ8aDCgCfoCv1s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317091; c=relaxed/simple;
	bh=/sYz6Qa8y4VRFFDmV7lKHqBd9/K/XwopFBJDonKR5As=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IImvkJned8vsbEyNn74+BPZPRd7QLknBbhgurp0QjvWpoakHBxkCLHXuhsfCRsYMg3WuP5pl46LMw6Y6/D33e63JtejS52PI/sHsT8KER5Pq0BQcysnt7js2mEjRwBqZ8fD8B9snsH0WtJyoxhq2Ru7bA1MRZzwddr0eIMb1fqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JcxAFUQY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ab0b2e804cso29630295ad.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317090; x=1772921890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIMwfQGmexEev8GJ28YhfmS6vK7GLe46FYq3+TzSnwU=;
        b=JcxAFUQYt3fcNCTmQ+5fmnJoT6c0WqaC/lMOmxJ20vIbgq6L2P+POuaSdFlAItGLc+
         QlQM6SfNqN1dfHHzjxDsCPQqdg0AD82rczSGKZ6+Zpd68U5AsYuBR95pIlyqiXhEJJOj
         FSpNHUE8JrgzyoJ+XSj9i7peJuJPH50bJ7LTlgnWw8A/ARpmmASG4BCEPg1WjTYkeIBl
         E4OKGg5Q1jOLrKyeGcAk+dQFw97HJTaa5xUA8wHj3gjK600rdyZqaCB+9t7J3lXIfVOH
         ydcK0qRTFrRJnSu51TY8I3RDyFAXNrj5vEbAe6hIFkvRtgczQ5xhsRbno6dGlhpdwqjG
         xjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317090; x=1772921890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIMwfQGmexEev8GJ28YhfmS6vK7GLe46FYq3+TzSnwU=;
        b=wphITcBsSc9ymDKmpJFfk0FOim3klj5xCUfgTwXiw3aOWNXR7t2F9uNl+eMSpyLtml
         JaSEApsTyBrVnoD8A7qUmAUHAGUrXbZfXD1QxBKnE8h6rnapFS6/YBsEwbQm8popUySg
         B+e+nQEtsl95WPrqsT+NZuT7CF5XkuAB1QH2Dk52JRbkkWzw27pRIJ5X90HePWSxVx/Q
         qtjpM57vTh942e7XlRPo0L95uA3vwY0NdbQWPQloDOcAJdix6FOpZTGBUD461OjYZ8RV
         qzpLBHhh+S/7OBEzYjKmZ/otu1+2AghElj44816oKegNU7g438ZjENUIJAT8enDUbN6n
         3A7w==
X-Forwarded-Encrypted: i=1; AJvYcCXdmhEr7c0yiNAjFxyBUGZQ7Ktq3GvESi/Ca9N5/AHVGlLz0mIJwHzw7KFFpUIKdjo4KuEc9DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJ3F59YOpqzYoFnIRt/cqni6pbfFcuNp0toAXh+ufTHCpvcDA
	EosE3SiJlK8l4cJ7P/I6ip/K1wFoYfjj8+8hAaZAxFf5+bQgtPsccRMZ2nUKRaVbYsTxRmCn9DK
	L2fvlkA==
X-Received: from plbko3.prod.google.com ([2002:a17:903:7c3:b0:2a0:81d1:64f4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e743:b0:2a0:ba6d:d101
 with SMTP id d9443c01a7336-2ae2e40b84emr62954645ad.21.1772317090030; Sat, 28
 Feb 2026 14:18:10 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:22 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-5-kuniyu@google.com>
Subject: [PATCH v3 net-next 04/15] ipmr: Use MAXVIFS in mroute_msgsize().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262237-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B68891C9719
X-Rspamd-Action: no action

mroute_msgsize() calculates skb size needed for ipmr_fill_mroute().

The size differs based on mrt->maxvif.

We will drop RTNL for ipmr_rtm_getroute() and mrt->maxvif may
change under RCU.

To avoid -EMSGSIZE, let's calculate the size with the maximum
value of mrt->maxvif, MAXVIFS.

struct rtnexthop is 8 bytes and MAXVIFS is 32, so the maximum delta
is 256 bytes, which is small enough.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ipmr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index eecc79a835d1..9f2dd726affb 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2510,7 +2510,7 @@ static int _ipmr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 				cmd, flags);
 }
 
-static size_t mroute_msgsize(bool unresolved, int maxvif)
+static size_t mroute_msgsize(bool unresolved)
 {
 	size_t len =
 		NLMSG_ALIGN(sizeof(struct rtmsg))
@@ -2523,7 +2523,7 @@ static size_t mroute_msgsize(bool unresolved, int maxvif)
 		len = len
 		      + nla_total_size(4)	/* RTA_IIF */
 		      + nla_total_size(0)	/* RTA_MULTIPATH */
-		      + maxvif * NLA_ALIGN(sizeof(struct rtnexthop))
+		      + MAXVIFS * NLA_ALIGN(sizeof(struct rtnexthop))
 						/* RTA_MFC_STATS */
 		      + nla_total_size_64bit(sizeof(struct rta_mfc_stats))
 		;
@@ -2538,8 +2538,7 @@ static void mroute_netlink_event(struct mr_table *mrt, struct mfc_cache *mfc,
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(mroute_msgsize(mfc->_c.mfc_parent >= MAXVIFS,
-				       mrt->maxvif),
+	skb = nlmsg_new(mroute_msgsize(mfc->_c.mfc_parent >= MAXVIFS),
 			GFP_ATOMIC);
 	if (!skb)
 		goto errout;
@@ -2711,7 +2710,7 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		goto errout_free;
 	}
 
-	skb = nlmsg_new(mroute_msgsize(false, mrt->maxvif), GFP_KERNEL);
+	skb = nlmsg_new(mroute_msgsize(false), GFP_KERNEL);
 	if (!skb) {
 		err = -ENOBUFS;
 		goto errout_free;
-- 
2.53.0.473.g4a7958ca14-goog


