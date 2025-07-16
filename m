Return-Path: <netdev+bounces-207625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA96B0804E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8335A1C28735
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7162EE613;
	Wed, 16 Jul 2025 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDTk+Cuy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2954B2EF2B5
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703959; cv=none; b=ufwKkNPTehcavU9HOvEwWSseqNhV9PzCoJdd3b2KNg09eWqzXcLo8CzBCMCyT4CaGMhC70TLep6a6982HGoOtBYJlR3hRoX4p3HIg596sT8AJMLWQI3jvgo4WAkXn7eNE5e+p/aVxuGjiu57BlaIGBAnFnugHXddJDG1qbEG+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703959; c=relaxed/simple;
	bh=FrbxlyWV7EEv5CsvqO9RSnNArD7Jt0juhPhbOJ1DiGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G34JGkYCl8TGSobSMGUcZPKgFtVP7f2H/ZNHjyqoFEJkjxP8y4tYJxXiMTse6ZLPIgG6cczzJ2sgqnOUdkXtjWM/OG4RFR/2P7VwFtqSE9DxdtT96f1wRjc/MfVVBUCgyCLAxA0t3Lq2kDKq2N1Vh53Wzee449YXOpraqpC3y4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDTk+Cuy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso567965a91.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703955; x=1753308755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FA1M6NnFdpJu2PYNQPSgQWuPrH1Xac3SqVQzSg4YemU=;
        b=TDTk+CuyiLfBiDxL5ugN5MQQrBksz8o8idB8IoDiVrwgE3WBy1CnU+K2xWGowIPbeM
         T+Y6A9HtvnKpc/xn4rLrs7+CiurZ9LxOuQgm6dIT4DfR+SAEKvDzVkMOQr3dZE8T40TJ
         PnDqYhB/ysI3uxxKe/HBA6GDco8qDfL31WpFq+ezMCcILheU9SB2dA9xlD6CmW2jZRLz
         YXeX9C8UMkh+03CCruzSqCUk7vdO3ncdqMr5R+cGGsOVTZvgGuINYVjAorxpQdI5FI2O
         8kwNnsIID6zz9GNfIe2FHNAhKmiei0gn0Aj+6Nvlz47yH2oGR8dcmXKXSkiCfvtREWNO
         3/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703955; x=1753308755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FA1M6NnFdpJu2PYNQPSgQWuPrH1Xac3SqVQzSg4YemU=;
        b=OiWWYZabuDQEox/Y2ZYxw8jKDHATBHVZQ1OLu9IyDAKY2RXDw2jZtOhxSsECooQhxu
         RgXd9e46R5kJom+KgCbkCKVrcRTArawYwqbiFRB0mx1DzLvMUCPMYCiYs4ChWovrlDik
         Jupdiehe6Mrsz4+G3HoCEZ6qWFMoW9B8sdTcrOdWHzCyyrRcHu68YHR09dCDrXaewubq
         7CD+CNzFeiffM5Ev3kiSf7CN/WlYOYC+aJ3ke3rfwLJ3R/brk6fFSrTABAMlzt1n2vAU
         29YGJvaBNJCBy5iEQQJly3BsEff9DoAZZOtXybBr3L/VwA0V7rHSoofDlG/aeXhkWiqH
         HVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3D3D8hYsCHsk+6PAgdq7qbh7p2syM5A1VDicaeaXg8LjOqlzycwdOTzLl7VsefSCuenKmUIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DqAiUKpOG793TxewVFjq01mhU6qzt3dELO7vSU47cLOXoCeM
	wYfAhZN3fZ6j5Nq+GCB9SZTRBqkMYz0MiGe2IEWZAS2KBUNXS0QHr/WqLnFmQKhV9tXTiEvcqD4
	Jr1B9Og==
X-Google-Smtp-Source: AGHT+IE8yj1z6WwEg2jjKidY9rs71Kf7ZxH4Tgi+D/Ttz/OqSpTMOtJW432YJYm77cDB+ZCiOPAoxic6xpo=
X-Received: from pjbqd16.prod.google.com ([2002:a17:90b:3cd0:b0:31c:15e1:d04])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3852:b0:311:f99e:7f4b
 with SMTP id 98e67ed59e1d1-31c9f47ce80mr5945641a91.28.1752703955416; Wed, 16
 Jul 2025 15:12:35 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:13 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-9-kuniyu@google.com>
Subject: [PATCH v3 net-next 08/15] neighbour: Annotate access to struct pneigh_entry.{flags,protocol}.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will convert pneigh readers to RCU, and its flags and protocol
will be read locklessly.

Let's annotate the access to the two fields.

Note that all access to pn->permanent is under RTNL (neigh_add()
and pneigh_ifdown_and_unlock()), so WRITE_ONCE() and READ_ONCE()
are not needed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Cache pn->protocol in pneigh_fill_info()
---
 net/core/neighbour.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index f5690e5904cba..f58b534a706a6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2044,10 +2044,10 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = -ENOBUFS;
 		pn = pneigh_create(tbl, net, dst, dev);
 		if (pn) {
-			pn->flags = ndm_flags;
+			WRITE_ONCE(pn->flags, ndm_flags);
 			pn->permanent = !!(ndm->ndm_state & NUD_PERMANENT);
 			if (protocol)
-				pn->protocol = protocol;
+				WRITE_ONCE(pn->protocol, protocol);
 			err = 0;
 		}
 		goto out;
@@ -2678,13 +2678,15 @@ static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 	u32 neigh_flags, neigh_flags_ext;
 	struct nlmsghdr *nlh;
 	struct ndmsg *ndm;
+	u8 protocol;
 
 	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*ndm), flags);
 	if (nlh == NULL)
 		return -EMSGSIZE;
 
-	neigh_flags_ext = pn->flags >> NTF_EXT_SHIFT;
-	neigh_flags     = pn->flags & NTF_OLD_MASK;
+	neigh_flags = READ_ONCE(pn->flags);
+	neigh_flags_ext = neigh_flags >> NTF_EXT_SHIFT;
+	neigh_flags &= NTF_OLD_MASK;
 
 	ndm = nlmsg_data(nlh);
 	ndm->ndm_family	 = tbl->family;
@@ -2698,7 +2700,8 @@ static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 	if (nla_put(skb, NDA_DST, tbl->key_len, pn->key))
 		goto nla_put_failure;
 
-	if (pn->protocol && nla_put_u8(skb, NDA_PROTOCOL, pn->protocol))
+	protocol = READ_ONCE(pn->protocol);
+	if (protocol && nla_put_u8(skb, NDA_PROTOCOL, protocol))
 		goto nla_put_failure;
 	if (neigh_flags_ext && nla_put_u32(skb, NDA_FLAGS_EXT, neigh_flags_ext))
 		goto nla_put_failure;
-- 
2.50.0.727.gbf7dc18ff4-goog


