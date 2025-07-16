Return-Path: <netdev+bounces-207627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96538B08050
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15A0A45A46
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF682EE616;
	Wed, 16 Jul 2025 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCIXRuL4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62572EF2B8
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703960; cv=none; b=NwbrnUiypO9QZwHgkotizuYMSQMA+uhYNWKpttK2nl+Uy2uvURYmrrPjQ62lwOPjCOOEkwkpXntI8dFj1MynQJpALQvFTNbyXzkLzMjjLyK0IwugPoZVibJpm5OLYmXbUhRlkLAJCHHWLA/Fb0Js1Gyy24Fd4deQkPJI0zVIp7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703960; c=relaxed/simple;
	bh=O2eFRX2PM9qcJ8DHeodjfWx0Ao4GB6ibsHfL1BfVQ1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fNibfHWNHZ4THzLohBC8Pw6o6PxC6tAI2mUoIgsaUIn/rKk4zxXUlPzTN5Dzy7yULlpT1z+ATt3QANhZAot6jBfZJzBpcsDEpV2Ap2RFs5Dbp3tW+UergbRkrEfNaFziVw97lfL+uRP1ULcXgi1WHZyKp9I92rX2vmgjoUh4Fho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCIXRuL4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso369514a91.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703958; x=1753308758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WouOL06zypIyscV7Po8l0Mp9SU8V41KvkiVkKW3KFN0=;
        b=OCIXRuL4GFVJLQWdI9aom1L1z7omoqZOmtxvu+A5NTEk+klzJCId3emFmSxY3UrG7p
         qJjTaGpsVOVsJ0VQKuivOyUXV8cri9ltbZAp2gOd2HYyWtFP5zPHM5vhgZXEK0CAfdk/
         y+eA3NB4DNn1yQneb36EogGRGiSfJTj1BnDJXNCVQ21uePFTIsKgPirbqXGe6ilrXMTQ
         SQvbBkGbmQTbgLgLyYYSPiCbyVdCxvocZgsnl/2MjEkJiS2j+imhDLJufdTKd6ECWAvd
         29vPIgoRXHtKFz3Mi2ecsR+sWhKFDDRPZmDEZITFpSddeuVMquWjtIYO4dRRQpkcHY2N
         D6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703958; x=1753308758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WouOL06zypIyscV7Po8l0Mp9SU8V41KvkiVkKW3KFN0=;
        b=Tkty5ik78Tql4DZE7wvi19bE94x5JeHb4xkDrgKWAPi1RZuV4ZC0WM/5I2Jgj3MbFP
         0GG6dAX14vuasB21UlXpP2gPZ5u/ArUfVFcXZnEsTNnPpm0JsjzPLzAxMIOwXlr2sAtD
         umBU9DBpvFsNXVJNE4Gp5YzRBKICXZ3b4YUDsVDqTK9CxogyydTc0ejg2eqkcc1SEYxc
         3iwQ6d5oMHtpwIfb/7bicfMjz8zWsVae/wntWwoC79q04dj2zjmrMoyX0q7fKZL8EitI
         bzDDCMrTlOOLmNx2oobI/h6flh9Cy7tur+BIIAbAoFIK7+VXV4TsyLyYBjIBkgFXTDtG
         nP5g==
X-Forwarded-Encrypted: i=1; AJvYcCW1fD6uJmE4vXR7/q5jrMkUuUPRueCcxLx3cu40fBSb8FuAHLE1DEshjpX8sXfZuwyZYBklT6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqLVdjAnEaFWKhQugLxsFrOWaMnoU0x4n6D47yacXg8h+QdrcD
	aA0+/3Sv89aul2//yt3VhPjmUNgtjYVPQFONr+x4kLj38VxaLF67zZ8ZtqvqT7xPKSPj4fmZP+I
	ltsEweQ==
X-Google-Smtp-Source: AGHT+IHLNJPLHwOBW41OsvVPxkWLmCBrlD/yFE+RK05TeCNmGcC5Mag0JPdVtUOMJ7wNfYtZ9Lh60ho8YqM=
X-Received: from pjbpv12.prod.google.com ([2002:a17:90b:3c8c:b0:312:15b:e5d1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c8:b0:315:b07a:ac12
 with SMTP id 98e67ed59e1d1-31c9e6f71b8mr7164279a91.14.1752703958287; Wed, 16
 Jul 2025 15:12:38 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:15 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-11-kuniyu@google.com>
Subject: [PATCH v3 net-next 10/15] neighbour: Drop read_lock_bh(&tbl->lock) in pneigh_dump_table().
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
 net/core/neighbour.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 017f41792332b..c7e0611219710 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2808,14 +2808,12 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	if (filter->dev_idx || filter->master_idx)
 		flags |= NLM_F_DUMP_FILTERED;
 
-	read_lock_bh(&tbl->lock);
-
 	for (h = s_h; h <= PNEIGH_HASHMASK; h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = rcu_dereference_protected(tbl->phash_buckets[h], 1), idx = 0;
+		for (n = rcu_dereference(tbl->phash_buckets[h]), idx = 0;
 		     n;
-		     n = rcu_dereference_protected(n->next, 1)) {
+		     n = rcu_dereference(n->next)) {
 			if (idx < s_idx || pneigh_net(n) != net)
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -2824,16 +2822,13 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
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


