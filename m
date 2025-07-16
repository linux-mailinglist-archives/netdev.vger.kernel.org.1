Return-Path: <netdev+bounces-207626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B55B0804F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1791C283BC
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B22EF641;
	Wed, 16 Jul 2025 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wejVHSuL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA392EF28D
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703960; cv=none; b=rnTDJAr1XWuNTJHwCxtgGXFMZVFsjleOEX6Jqaxc5jduzsrfqLFhpELJQCqT0i2Xwr4Kaa8qq6LvQMhreVGip6Ijle7Fy1LYX/CkhPLfTj2bC0AVoTdPqoEnMDSB23T4KxfVQ18SN0ImWkGmMn+m/d4CdlU3noGa8RiYaHDCRl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703960; c=relaxed/simple;
	bh=CmQhBCaKg05H6yz9olLvm1E8zRh7HKWPeJ54wMIHwSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ROiWLSi3su0jYrKZ/gRr8iDU/csSTAlX4dKWw8Jb1NtKhx9DgdxDD2uIAyDswlDVMg4qh8h63SxvBq7K2YDTn24+ZacmexL2bisqZ6m8uvwJv83CEjkXqucyb3ugBQi4wOkweoIZdjQ5x/VwhSIeFPwbhkkjb/BpEk99Poz9Ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wejVHSuL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234f1acc707so2495605ad.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703957; x=1753308757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxyovor/tsFNbBH/ChOGErQTb/xPbbdzDFR0fFQA3fI=;
        b=wejVHSuLEFAZs9A8o6tKayw051FqOzfpqUx+pQSTc6f+kUfODJEQHkQEqksEtTnCeW
         C8yjJPubgPGmrGxvlys//pI/5UcsUBT4e3OvpxNeevg0nUVZ+ALSPkkDjfxEaAFZ+IKf
         /DKPlmfYFIfgpgQJQfqXphLpC95SAa9I/YBspZw/mq13/FIXyfnjsNhnirap4+N/+M4M
         cWfcR3SjIgp7ptJ4gAmkf+t51vhynzpf0Qm/SWCbVNCLAr0t9CkrpNi349NrBDgiRQ4e
         PNCGR9g2Y5QqinedlUMwOdI7Fcs8UCBE4asAgPz2a3/cQIczpboqx02TN/VDCHtuLwxr
         gZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703957; x=1753308757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxyovor/tsFNbBH/ChOGErQTb/xPbbdzDFR0fFQA3fI=;
        b=gmI8mkaT3RpIc9ij3crKFo1Q8Vvfe83N/YzJooA+iR0fvgUgCKRvWtfdYcEXJR1v2i
         hpEUia6HKx1npagFEutFVYSR+ebADhRLlP9LtDnTAx7pihUv4Y+S0gWj/vEenMRit0gb
         Pix6scTM73leZayYvC5IJdXtXXojMRqB6Atnj7T/yc9KPvAgH3gFuPgoaXYGzv3LZDd1
         PGlBmDcuw1YsIm2+hjX2T1gQkpyKcOQ1uet7ncPgbnPAdS8lswsmtW2Fq2+6pKiVvIJ1
         6V96/GEcTRewKEHp0BwNJ9mzBT0EzEdoTX4/FAQyFEqRHHNeM+2KxL8vFDskMzqEiQPj
         qWcw==
X-Forwarded-Encrypted: i=1; AJvYcCWS/EOWrk+iewV9mrY0fyGR5YjEQWDQHAHtH0ChORGzyIvNuacrYJTI2eDiTl/6MH8Y06FD+DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6D3WaBkXvci4mSuPHPvq9sYyNg76kE1BFe0zRU5FNlFL01yT
	XWY15S5oqYmXzeWGNmvNvzD4LY52RhcPZVkqp/UPOQl47UdhMPtYzQO2fwtFy3EaacBMVIpZ0Tg
	c0SRnGw==
X-Google-Smtp-Source: AGHT+IHs5OKs2C9CyiR7QFvDR0AfnTwZ8lQ8ZPdyI9yi2EWUgAPa0p8rO7kYY2XFr/7etsSMFnNdXnzCUYg=
X-Received: from pjbpt1.prod.google.com ([2002:a17:90b:3d01:b0:311:ff32:a85d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15ce:b0:23d:fa76:5c3b
 with SMTP id d9443c01a7336-23e256d7899mr59603945ad.22.1752703956841; Wed, 16
 Jul 2025 15:12:36 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:14 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-10-kuniyu@google.com>
Subject: [PATCH v3 net-next 09/15] neighbour: Convert RTM_GETNEIGH to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Only __dev_get_by_index() is the RTNL dependant in neigh_get().

Let's replace it with dev_get_by_index_rcu() and convert RTM_GETNEIGH
to RCU.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Rename err label to err_unlock
---
 net/core/neighbour.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index f58b534a706a6..017f41792332b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3049,27 +3049,29 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (!skb)
 		return -ENOBUFS;
 
+	rcu_read_lock();
+
 	tbl = neigh_find_table(ndm->ndm_family);
 	if (!tbl) {
 		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
 		err = -EAFNOSUPPORT;
-		goto err_free_skb;
+		goto err_unlock;
 	}
 
 	if (nla_len(tb[NDA_DST]) != (int)tbl->key_len) {
 		NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
 		err = -EINVAL;
-		goto err_free_skb;
+		goto err_unlock;
 	}
 
 	dst = nla_data(tb[NDA_DST]);
 
 	if (ndm->ndm_ifindex) {
-		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
+		dev = dev_get_by_index_rcu(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
 			err = -ENODEV;
-			goto err_free_skb;
+			goto err_unlock;
 		}
 	}
 
@@ -3080,28 +3082,31 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		if (!pn) {
 			NL_SET_ERR_MSG(extack, "Proxy neighbour entry not found");
 			err = -ENOENT;
-			goto err_free_skb;
+			goto err_unlock;
 		}
 
 		err = pneigh_fill_info(skb, pn, pid, seq, RTM_NEWNEIGH, 0, tbl);
 		if (err)
-			goto err_free_skb;
+			goto err_unlock;
 	} else {
 		neigh = neigh_lookup(tbl, dst, dev);
 		if (!neigh) {
 			NL_SET_ERR_MSG(extack, "Neighbour entry not found");
 			err = -ENOENT;
-			goto err_free_skb;
+			goto err_unlock;
 		}
 
 		err = neigh_fill_info(skb, neigh, pid, seq, RTM_NEWNEIGH, 0);
 		neigh_release(neigh);
 		if (err)
-			goto err_free_skb;
+			goto err_unlock;
 	}
 
+	rcu_read_unlock();
+
 	return rtnl_unicast(skb, net, pid);
-err_free_skb:
+err_unlock:
+	rcu_read_unlock();
 	kfree_skb(skb);
 	return err;
 }
@@ -3904,7 +3909,7 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
 	{.msgtype = RTM_NEWNEIGH, .doit = neigh_add},
 	{.msgtype = RTM_DELNEIGH, .doit = neigh_delete},
 	{.msgtype = RTM_GETNEIGH, .doit = neigh_get, .dumpit = neigh_dump_info,
-	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info},
 	{.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set},
 };
-- 
2.50.0.727.gbf7dc18ff4-goog


