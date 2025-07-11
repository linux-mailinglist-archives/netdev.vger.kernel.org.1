Return-Path: <netdev+bounces-206244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E951B0244F
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA8A7AF287
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002385FDA7;
	Fri, 11 Jul 2025 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RByzESUX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827BB2F3C18
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261026; cv=none; b=FpiWnB6RRxha0QdgaJqaGABa/iRLK4pHOM7b/o7Xkh6mI01iWPRWWReuul3v3fHBf8rb7tz3xVIcRDCf5p0Ue7sisgqo369lhGAadE4evnZFzAaaHD1TOI8/Tpf/UnLKFE9zS9GKSnTxwK5Wkx/UMlsF/mrbdEfm7h8GwCTIcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261026; c=relaxed/simple;
	bh=JwSEfumaOfW3To0OyQ2Wbf6eOB7q5mcr5A294aX1/8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cDrFTm0MQ/6WFCTp/9gg3WCxl/SBJXgXii5MlA0RzT5Rnsis44/WR01GbB49AfkliK++o5jhhTbgYRH4SJ3kRvYt98c0HOZatUAiorKmjA00/5lFI/tv+60Q/2gThtug1XK/wkfJho9dTMOmKMmNN19yo4IvfLjIGrOUFk7FG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RByzESUX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748cf01de06so3664416b3a.3
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261025; x=1752865825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUl5d/bzGzSLj/eSdqWPRwCXwkpLsp2JAZMV+3OVpmU=;
        b=RByzESUXDfH7dsRpP5xEjBDzmnhyhgmFB1QbC/OlNV/7Nx+gfJVH25VfBoj52J9029
         jnyqJdFkoTiK08Ay+UCX3e/4FuvgPwNNIGYrqhkq7lPcU1QTwMGdJ7h4B+wx00GoDQfD
         lHXEKAKt0MZLGwf9EGAzDmbuXmcIygg6yxKANIeDJQc6otHicwqd4Ct1xp5ywkb0/wPi
         ixHuC2XbCe9nNBPKDxfZV3/7y89DohfGzVmxz4N6u6SDH3XuSVDZBW4KguVvfglafpJS
         ximMNw02JjBuEHvnQhL5biIPzvcXICJKBlY4sxj2KZWBDBgZyMWPgaKCp21NvNCAiUSJ
         +zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261025; x=1752865825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUl5d/bzGzSLj/eSdqWPRwCXwkpLsp2JAZMV+3OVpmU=;
        b=mauzo9ydu9+ohivl4Ir56rGkHBGtIIVAGm9kKln6T7bNb1KQkZBw96kAHoX7QXz9tS
         LjsgWdlVp88+PUbdoiGITQEtI5R3+ko8YW3ezkF2u9dKpCp0TmQzzyUjX7jnbNc50MCl
         XT/1B8WlbINysp6ZQQljCcox96evTCuhWttSP0e3Nr0WidjLmfsVPtvyvofQt4rFmdJE
         p5hkfuBpDb9ammODHvzDNVVMQ3E2GKndxGNSZEeyL/vOMY3sr6imbQnhXZ4ouUP54x1p
         UQsMIiL/bucXm9mIxjyRYLWKvyfTWYmAy5LGnbvTPrCthpj9bHPlkATdvaPiCX+c6dBv
         ++qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6qBcJq82Nitg2ce++mZJY3MuLmbBTggJ4HAylS4oaFOsTxL+LWKPNqdStjsF8KjaIhWv47rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJjXgP4cz5Zy/nHk9d/cuNLvY1rr5IKum9kTnxAquJPfT+rt51
	aehV76dVu2t2hcPDdRNq2u3R8EjiFovgIz/kqtSNeuYExgex8thueO+nlmUQtCKIktr2V46erI0
	/f7alPw==
X-Google-Smtp-Source: AGHT+IG5Eijt9KgtsEeeGZKKakYsNM1Bl0GS5opw6SyteNZ4MCzidK9XEoWRgqKAJoPsKc69nTPLAFOYT8w=
X-Received: from pgkm13.prod.google.com ([2002:a63:ed4d:0:b0:b31:d727:24a4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:c217:b0:231:acae:1983
 with SMTP id adf61e73a8af0-231acae1e66mr3961709637.3.1752261024844; Fri, 11
 Jul 2025 12:10:24 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:14 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-10-kuniyu@google.com>
Subject: [PATCH v1 net-next 09/14] neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_dump_table().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now pneigh_entry is guaranteed to be alive during the
RCU critical section even without holding tbl->lock.

Let's drop read_lock_bh(&tbl->lock) and use rcu_dereference()
to iterate tbl->phash_buckets[] in pneigh_dump_table()

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index c5bd52dfd3e5b..e8ca84e2ddf30 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2801,12 +2801,11 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	if (filter->dev_idx || filter->master_idx)
 		flags |= NLM_F_DUMP_FILTERED;
 
-	read_lock_bh(&tbl->lock);
-
 	for (h = s_h; h <= PNEIGH_HASHMASK; h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = tbl->phash_buckets[h], idx = 0; n; n = n->next) {
+		for (n = rcu_dereference(tbl->phash_buckets[h]), idx = 0; n;
+		     n = rcu_dereference(n->next)) {
 			if (idx < s_idx || pneigh_net(n) != net)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -2815,16 +2814,13 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			err = pneigh_fill_info(skb, n, NETLINK_CB(cb->skb).portid,
 					       cb->nlh->nlmsg_seq,
 					       RTM_NEWNEIGH, flags, tbl);
-			if (err < 0) {
-				read_unlock_bh(&tbl->lock);
+			if (err < 0)
 				goto out;
-			}
 		next:
 			idx++;
 		}
 	}
 
-	read_unlock_bh(&tbl->lock);
 out:
 	cb->args[3] = h;
 	cb->args[4] = idx;
-- 
2.50.0.727.gbf7dc18ff4-goog


