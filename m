Return-Path: <netdev+bounces-207619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C37B08048
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DA11C27F8A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE62EE60D;
	Wed, 16 Jul 2025 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ww70ICY6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533692EE5F9
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703948; cv=none; b=Cx+gZBbvS/XaDbAZ4KSBEnc5fTrYy83lVEdEX1E/lgN11rVWGvrehSDkBQqwhXG6DcjwCXIUd9wZiMs/5t76uy5EVr9ces0CLAZeN0ehWL+nDTiFCu7eZSnzrpEv1clgCysViwIbYxLXNeqciuQc4L0ZlqAR/XM7UjWzaxEgZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703948; c=relaxed/simple;
	bh=gly7PFl1IO59zgJ5YrKjvGVNEwd1w1ddrN1efA30lG4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hfKOZVIwP9voO4tWFqwpYRrfwbybx2q0+hzu4q03TvlaTUqn0fYM8bkfLYMnWOyMJy15kG1fIOP8yLmeer0ziSugMFrqi9hvNxKT/4J3UElv2w+//TQpladxflfWXT6QAdfVkMj/WcRw7ABZ6+cmfQVrn/xUbvC2qzyzSpKsS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ww70ICY6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31215090074so506121a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703947; x=1753308747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwUvVODYfo8f7XBkARVIlzSdApADXKtAhhSRrmTaYcE=;
        b=Ww70ICY6mU2EC76Ynp+3HIGPQBistHf/PKB86wVvZzU87BIQkB0E+V6Ou0J3f6CHqj
         oexCzd4MlnykOlsJZ/tujxtHXx75HAb0JGl2tNjRu05//3JNWljj5+y7r/INw4La5SNh
         v2NUIRhfiYrh2Lhrs8l7MKevK4MB0QSBwWfoUgFLIwNFv7ECCeuZBT+8m3+NQKvZ/Q6D
         fhwNKEUTdkcshWUfu0+Apj2YU9qSqvjNbr1KKwnAN7Cr9kE1lC2Xu0NArLcA5jqnf6/T
         PYpXbWXGQ1e8F0r0NcQOuwnYaiaHWd6yPxh61RbGkoEECkrX1qEnmvMb1zqroLlEfBRW
         t1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703947; x=1753308747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwUvVODYfo8f7XBkARVIlzSdApADXKtAhhSRrmTaYcE=;
        b=e+ULNCqMNqt3e/916I7dLvatuC0wCJiDpmoG9ugdfkkLSyiVcCVvT5V+oBFRtTIsAU
         VzAGGE6/euwyfH34JbypQIEm7Ck5OkHjRvjUotLlblHNXELEzIZ/KMBWoC6LREbdEN7Y
         10CL2ty1NCgLTFkOA0arV6uv43rVRHKMz3euvAnHuD32Wnh81MoUptLQlQbGrl0L74jz
         aC+DQwLIj9shJ4O3neXi/qCby1PgmK6ujln+IIgbEaZ24d+tcV+J2Tf6MiBuHLA0t9Xy
         1/4KABX4p9LzvCgwdJFvYY32K9IaHv+VqY9ouEplxhes8PeelpY1UsU1+BrnuRZ5h+r8
         8gUA==
X-Forwarded-Encrypted: i=1; AJvYcCV19O1LoXIkt8/8pA33DPMytRWdXpcw2fBKw6fut8EMacaxDGCaG6tvaADPYmatsUkGJ0aATME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDweQ983babfHHLjXxwA7L8rMefXNMWcKrWxA/sK5c28LS5wD
	LH+NVK1ul9gY2o9/PYN2+PMh5veUx9Gl+JbpCYF/MdaR0E9wy47GDAtbavEAfhDqLJIhnOuvsMM
	p4ZVlmg==
X-Google-Smtp-Source: AGHT+IFHXixNtH8/xSSEPSLizyLq+Uylwyo71ct0gHhw6EHZceAGny9Lc7tLBA7VQpWTq/KU6MEH9wneh7Y=
X-Received: from pjbqd6.prod.google.com ([2002:a17:90b:3cc6:b0:311:eb65:e269])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224c:b0:31c:260e:55e9
 with SMTP id 98e67ed59e1d1-31c9f436cf9mr5772308a91.24.1752703946769; Wed, 16
 Jul 2025 15:12:26 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:07 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 02/15] neighbour: Move two validations from
 neigh_get() to neigh_valid_get_req().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will remove RTNL for neigh_get() and run it under RCU instead.

neigh_get() returns -EINVAL in the following cases:

  * NDA_DST is not specified
  * Both ndm->ndm_ifindex and NTF_PROXY are not specified

These validations do not require RCU.

Let's move them to neigh_valid_get_req().

While at it, the extack string for the first case is replaced with
NL_SET_ERR_ATTR_MISS().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Use NL_SET_ERR_ATTR_MISS() for NDA_DST
---
 net/core/neighbour.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index eb074d602ed08..babedf5e68c44 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2935,6 +2935,11 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (!(ndm->ndm_flags & NTF_PROXY) && !ndm->ndm_ifindex) {
+		NL_SET_ERR_MSG(extack, "No device specified");
+		return ERR_PTR(-EINVAL);
+	}
+
 	err = nlmsg_parse_deprecated_strict(nlh, sizeof(struct ndmsg), tb,
 					    NDA_MAX, nda_policy, extack);
 	if (err < 0)
@@ -2947,11 +2952,13 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 	}
 
 	for (i = 0; i <= NDA_MAX; ++i) {
-		if (!tb[i])
-			continue;
-
 		switch (i) {
 		case NDA_DST:
+			if (!tb[i]) {
+				NL_SET_ERR_ATTR_MISS(extack, NULL, NDA_DST);
+				return ERR_PTR(-EINVAL);
+			}
+
 			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
 				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
 				return ERR_PTR(-EINVAL);
@@ -2959,6 +2966,9 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 			*dst = nla_data(tb[i]);
 			break;
 		default:
+			if (!tb[i])
+				continue;
+
 			NL_SET_ERR_MSG(extack, "Unsupported attribute in neighbor get request");
 			return ERR_PTR(-EINVAL);
 		}
@@ -3051,11 +3061,6 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	if (!dst) {
-		NL_SET_ERR_MSG(extack, "Network address not specified");
-		return -EINVAL;
-	}
-
 	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
@@ -3068,11 +3073,6 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 					nlh->nlmsg_seq, tbl);
 	}
 
-	if (!dev) {
-		NL_SET_ERR_MSG(extack, "No device specified");
-		return -EINVAL;
-	}
-
 	neigh = neigh_lookup(tbl, dst, dev);
 	if (!neigh) {
 		NL_SET_ERR_MSG(extack, "Neighbour entry not found");
-- 
2.50.0.727.gbf7dc18ff4-goog


