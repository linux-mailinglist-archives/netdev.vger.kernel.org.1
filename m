Return-Path: <netdev+bounces-207618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762E4B08047
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2414E4577
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46012EE5FF;
	Wed, 16 Jul 2025 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBR+NA+z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4B2ED171
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703947; cv=none; b=I7I9tK5vTZOqpIyn6/XSNIyNOYjv7bw+PyoqZG3kibPMQp8+MOTClLsYlj4lCODP/CsjtmMx25ynEi5GkVmvrMljITv7RuOmORxWuG+Ase+2014IpvLCc6ODp650k3JbggIyFx0tTqsdyAA7NZOe+IQ+67kQvvtp3gc094Ir5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703947; c=relaxed/simple;
	bh=0L1evTIaJraSeij/toLLcKXXu8VJa5U0teQWC/9ctVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7nCGEfZxkDv7LVZIFvTWY00d2ASZ9rbZlUSv6FLJ928B9iPMWJuFb7gdLfUd8CLIQpEITqfgq3ilhPa/U+HCIsFBphjP9bm83r8Us/ujtEdw0ich48XnrkQThqz+RzZzCWzdcgQn5E6wVctVHX6PV5h2E/IC6bwQgo+wEcMlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBR+NA+z; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31215090074so506106a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703945; x=1753308745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/k4FGasWMpdb+58LWn4mD/hHpem5o0uAHtteuq4pUg=;
        b=NBR+NA+zCHyVr42CYauSp8zug8A6ERAKcCDMgaSf4PI/pxMgWBjUsaa3gyP15x3WMP
         LMpQRFohxdMnHajeTIZItB86haTe7Wp/Ip6Nsb+Lz+AjwvXZQme09cTLiZTf4Zctld7y
         XD+U+JnKl6deL1KIHVAXXu73iRpEUObjL2i3zY8HDyaHyNmvN3590KqW2eQdoE9MNBnN
         AIlyhdvpGfztQU80KKbeaynpW44sYJt5+wr0tvsDsqylCbx/o7TV281mczLyLOBFvuH5
         k3jgVZUhdEE6mxmEr/c2iCzS9Cr+COBL/RQyFh6SDc9lv6lIrr8EKQ76wBEH6MDtV5lD
         +PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703945; x=1753308745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/k4FGasWMpdb+58LWn4mD/hHpem5o0uAHtteuq4pUg=;
        b=aciyUkUNNBEP4YLCKOOpp1Q1H2csgl7V9y0JsRbBBar4oCgEHGeU9xwC7kDdIULy66
         jSqgjGLzRtfoRSoO8nDmnQbzj/WgInRPWWAOZSReisRSHAfNF10E9U0zHqL/bHpIPR1h
         FAI90RXyyyDD4mVRmwxrR+V7Iu2MpYPUtyDqTco1NxSvQwpz+z3e70urgQnGhwuNgY+s
         VsBTyXbSer9MBXRUPS0P5Mm4sjssHtmMzSbdlFfO5md1y5SziyovYFjysBJHseStQlL1
         hVS9qwK9J+a7JQGxM5LXZ7iX6P8966J6RSUqUF3MFu/zy2QTPy4mnLggXiZuF/KXskJq
         Wh9A==
X-Forwarded-Encrypted: i=1; AJvYcCWjEesaPLOdY3mD+Q/TDtWSkwcXNVSd+S/Q6tIuKqnK9BXDfe+EGNVbu3bz0t8f5ZQaSKmbncI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyb8XMcPoSy2CTQkGcD7oXr+AEq/3H9fxPCSTVCD4BCaHUrvU/
	tiffPhi/UT8V0TCANXd4Egt1e75L2RvwpEvW73p/FypDH3GgbbhNSCkox3W1dOHcWztWFdOyiC0
	GeSVNQw==
X-Google-Smtp-Source: AGHT+IHA0ev2gta61AYJxZbmbdotrrUXGxqt/I/skW9flopREc2ZepOeO9Z6zBqNbbj8d/tqUWKsUo5bzcs=
X-Received: from pjvf13.prod.google.com ([2002:a17:90a:da8d:b0:312:fb53:41c0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:270b:b0:312:e8ed:763
 with SMTP id 98e67ed59e1d1-31c9f42412cmr5131256a91.22.1752703945568; Wed, 16
 Jul 2025 15:12:25 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:06 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 01/15] neighbour: Make neigh_valid_get_req()
 return ndmsg.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_get() passes 4 local variable pointers to neigh_valid_get_req().

If it returns a pointer of struct ndmsg, we do not need to pass two
of them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Return ERR_PTR() direclty instead of goto in neigh_valid_get_req().
---
 net/core/neighbour.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 43a5dcbb5f9c7..eb074d602ed08 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2910,10 +2910,9 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
-static int neigh_valid_get_req(const struct nlmsghdr *nlh,
-			       struct neigh_table **tbl,
-			       void **dst, int *dev_idx, u8 *ndm_flags,
-			       struct netlink_ext_ack *extack)
+static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
+					 struct neigh_table **tbl, void **dst,
+					 struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[NDA_MAX + 1];
 	struct ndmsg *ndm;
@@ -2922,31 +2921,29 @@ static int neigh_valid_get_req(const struct nlmsghdr *nlh,
 	ndm = nlmsg_payload(nlh, sizeof(*ndm));
 	if (!ndm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for neighbor get request");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (ndm->ndm_pad1  || ndm->ndm_pad2  || ndm->ndm_state ||
 	    ndm->ndm_type) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for neighbor get request");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (ndm->ndm_flags & ~NTF_PROXY) {
 		NL_SET_ERR_MSG(extack, "Invalid flags in header for neighbor get request");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	err = nlmsg_parse_deprecated_strict(nlh, sizeof(struct ndmsg), tb,
 					    NDA_MAX, nda_policy, extack);
 	if (err < 0)
-		return err;
+		return ERR_PTR(err);
 
-	*ndm_flags = ndm->ndm_flags;
-	*dev_idx = ndm->ndm_ifindex;
 	*tbl = neigh_find_table(ndm->ndm_family);
-	if (*tbl == NULL) {
+	if (!*tbl) {
 		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
-		return -EAFNOSUPPORT;
+		return ERR_PTR(-EAFNOSUPPORT);
 	}
 
 	for (i = 0; i <= NDA_MAX; ++i) {
@@ -2957,17 +2954,17 @@ static int neigh_valid_get_req(const struct nlmsghdr *nlh,
 		case NDA_DST:
 			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
 				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
-				return -EINVAL;
+				return ERR_PTR(-EINVAL);
 			}
 			*dst = nla_data(tb[i]);
 			break;
 		default:
 			NL_SET_ERR_MSG(extack, "Unsupported attribute in neighbor get request");
-			return -EINVAL;
+			return ERR_PTR(-EINVAL);
 		}
 	}
 
-	return 0;
+	return ndm;
 }
 
 static inline size_t neigh_nlmsg_size(void)
@@ -3038,18 +3035,16 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	struct net_device *dev = NULL;
 	struct neigh_table *tbl = NULL;
 	struct neighbour *neigh;
+	struct ndmsg *ndm;
 	void *dst = NULL;
-	u8 ndm_flags = 0;
-	int dev_idx = 0;
 	int err;
 
-	err = neigh_valid_get_req(nlh, &tbl, &dst, &dev_idx, &ndm_flags,
-				  extack);
-	if (err < 0)
-		return err;
+	ndm = neigh_valid_get_req(nlh, &tbl, &dst, extack);
+	if (IS_ERR(ndm))
+		return PTR_ERR(ndm);
 
-	if (dev_idx) {
-		dev = __dev_get_by_index(net, dev_idx);
+	if (ndm->ndm_ifindex) {
+		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
 			return -ENODEV;
@@ -3061,7 +3056,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
-	if (ndm_flags & NTF_PROXY) {
+	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
 		pn = pneigh_lookup(tbl, net, dst, dev, 0);
-- 
2.50.0.727.gbf7dc18ff4-goog


