Return-Path: <netdev+bounces-89089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AAE8A96BD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79931F21575
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA515B10E;
	Thu, 18 Apr 2024 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcnvo+UV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000715B55D
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433971; cv=none; b=pnTGJE+xNxkgRJ8RUy7uegft3zL3F1LHJiGKcrcIUwHLJrEVFXJRQDEsvGZKF6s1gjGDYQJt2ZU7rZMnJXqp2uNMzeCETJMA5lLZOjtyE+I376DP8Mw1vJHcMtHMISZaJGaqPdvD8zsWB91T5qWgoqhZRFUtI5fYqKJ5SUazZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433971; c=relaxed/simple;
	bh=PHG0S+PgfckD+46VpRSfZNFsxIzvXN6efdD4TqW4u/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QrMm8x09Wsa3coqOzZCTqkeic7N06qSH99lGvrUJhQaKgiNg4QzfhoIVGhB6dsHexuuYxSorUM/wLibol3AZ+hTp6iZWYnTpTSx5P/q5R42DicEWAj8mnrc2oyZh+2Jb7T+FU1XP2Z29ecIU+xXTsvAr0D1vxNG4VazZNQUu+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcnvo+UV; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-69649f1894dso14082606d6.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713433968; x=1714038768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QggYsr0OgwPCyZGOwQMXRWuz9w4GPqjFwk6jl8w0FcA=;
        b=dcnvo+UVmNByghgW/mmR5ty8EzbKwq/1lrVFOJbditazf7PSFadTa7IvcOA9aldG9C
         Y9Na2UN9T3cNbTouVbykot+PyzTpZK0EVYAxZWqAEmICjnHUP+nrNfEjlgEpYj7Iuq2B
         1Gba4XDnAtz/jYnr2ycKpPbvGIs9zIx56k7BCqWvT5dsdJ95EpUaLwImNxEOj9H5Z5nY
         l3ZDt90Ep0/g6JP0Nd5vzTMM57G9KtRNsw5CHsHUDIDFthjN4S344kZmwp59CfOjbGhK
         NtPeLp26wLcaqc3f4qn7UmCmBSL7D8MULbr0eV9l75cjCppm/j2Yp7ADxhI831HhtYsO
         +4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433968; x=1714038768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QggYsr0OgwPCyZGOwQMXRWuz9w4GPqjFwk6jl8w0FcA=;
        b=eMewJT+T6njyqAi7/11BIYOKT/7u13/sPtL+m32jrpLUfanSHyqh9UVqnCMQQn0rIU
         /4Axx4gzV7jB5/RjZwGBw5U9GieHcszJ7W1AvbmyN9OI0mY/GfgEazmjsTInJlqYVHiR
         jYymxV1JW5+Z3wv8gysxSUJuFZl0r+xROX4wHifJ6Z66h04vFSKlpmbX5CAnMPZ8LxFS
         iOjcDfpNU73acWLTF6sLXJ8/6LYHytwoz/12JPUfAkExGsaC2VZVnvgUGhujr3OYvU8G
         j1tE74lB6T1WFmmycpFUk8v3Yq419MznEbaQei32oG7FxmxUTqBA8RT4VHnIVX5Jxh8I
         mwiQ==
X-Gm-Message-State: AOJu0YzqVXo34lV3Og7vqrIi04XutStWSJ8nO4yf8njjNuAdruC3kqvf
	Ylk55n+sV4c47nCDa5xhDGoixRlJZXX9O6HkhbOK6UKXvJiS1goWalGXtOosaxQS/ojNFejQQDH
	aW8rUmD58Qg==
X-Google-Smtp-Source: AGHT+IHDDurKGpqV4tnYfiqSxJXxDrtm8Pw1aqcSQMpuqUzQJyfPvoeoRxB5hOUJPRyaohf9NQJ4tkboziAyoA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:27c2:b0:69f:bd88:2d88 with SMTP
 id ge2-20020a05621427c200b0069fbd882d88mr33761qvb.13.1713433968533; Thu, 18
 Apr 2024 02:52:48 -0700 (PDT)
Date: Thu, 18 Apr 2024 09:51:06 +0000
In-Reply-To: <20240418095106.3680616-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418095106.3680616-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418095106.3680616-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] neighbour: no longer hold RTNL in neigh_dump_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

neigh_dump_table() is already relying on RCU protection.

pneigh_dump_table() is using its own protection (tbl->lock)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/neighbour.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 2f9efc89e94e0f6d9e1491019583babb7bae77c7..13f2629091ef9ecd70a83f047a146c0990f308d9 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2721,7 +2721,6 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	if (filter->dev_idx || filter->master_idx)
 		flags |= NLM_F_DUMP_FILTERED;
 
-	rcu_read_lock();
 	nht = rcu_dereference(tbl->nht);
 
 	for (h = s_h; h < (1 << nht->hash_shift); h++) {
@@ -2745,7 +2744,6 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 		}
 	}
 out:
-	rcu_read_unlock();
 	cb->args[1] = h;
 	cb->args[2] = idx;
 	return err;
@@ -2879,8 +2877,9 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 
 	s_t = cb->args[0];
 
+	rcu_read_lock();
 	for (t = 0; t < NEIGH_NR_TABLES; t++) {
-		tbl = rcu_dereference_rtnl(neigh_tables[t]);
+		tbl = rcu_dereference(neigh_tables[t]);
 
 		if (!tbl)
 			continue;
@@ -2896,6 +2895,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		if (err < 0)
 			break;
 	}
+	rcu_read_unlock();
 
 	cb->args[0] = t;
 	return err;
@@ -3892,7 +3892,8 @@ static int __init neigh_init(void)
 {
 	rtnl_register(PF_UNSPEC, RTM_NEWNEIGH, neigh_add, NULL, 0);
 	rtnl_register(PF_UNSPEC, RTM_DELNEIGH, neigh_delete, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETNEIGH, neigh_get, neigh_dump_info, 0);
+	rtnl_register(PF_UNSPEC, RTM_GETNEIGH, neigh_get, neigh_dump_info,
+		      RTNL_FLAG_DUMP_UNLOCKED);
 
 	rtnl_register(PF_UNSPEC, RTM_GETNEIGHTBL, NULL, neightbl_dump_info,
 		      0);
-- 
2.44.0.683.g7961c838ac-goog


