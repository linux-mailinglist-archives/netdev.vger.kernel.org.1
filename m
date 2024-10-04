Return-Path: <netdev+bounces-132067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3F69904C4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BADD284577
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB53C212EFF;
	Fri,  4 Oct 2024 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUZNIy8c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BCC2101A7
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049645; cv=none; b=iq6FxOSirLTP4hZn41pZaYAxsCpCze2WXFjmD29XpQQJd6xPinqD7KTP70AT/ADWJCeAu5S3FIwhGJZuEF4XRs6+CIBJ4bjHPaH5qiOwVr9Fjc1Jj+CdWlZQ/BnnU4NYXDQtxIME2PF4eaRBaQq9L5+cqg+lhuBHqQG31TjloxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049645; c=relaxed/simple;
	bh=e1CRcsMpd5M2RcJa27XDZ1qMDqPgHbZQ7mxZ0lawOs4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mfqun9J2hselpzgDIkDgTdxUwEjueylboo1WbimGKgzY1SE+NLr5XlwxMxQ1Qs17N33VHIltGZYrr7iuF0trf9Vk9O5vA5J/4WAYo3z1AyY+gmrhvF6gESqk1E8pcaF8NQAkMwtG49hCovDnvtjdxTxXLFnRSNAK2zw0QqvKGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUZNIy8c; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e287876794aso2985687276.0
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728049643; x=1728654443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOnP393jP1F/mUC/uyT/bfXU+E03qSB5aem28E6VSU8=;
        b=VUZNIy8czBke6IPcDqfLop6p3PoRpDS3bPz0g5CkUL92OPrZDuyOaY/er690+M+oTd
         QlCmtDOG3nSGQxSi9sSsXut0/yT977JqODrjvCX1QwSnaE+kUmF7Z+A/6h7Mtxh6MAT8
         yVN5jRkQLimlfwikVM1d9AX11RbUzV9QkwHLEUunlxFj8s6YVIXF4FgjanVz2M3VBzRz
         JbKltUqG+OfQZFOtuBRJZOwzzYQsLHs2WFzwZYIk0eOuJU51bMdiOBzPCJcM065mLN3d
         W8oUklSVnGQfTzKRm3yds2eUAJZmtxQk56/pb37p1ElZvzllXGlZmN8+QA7rF5FmkxVb
         Ew+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728049643; x=1728654443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOnP393jP1F/mUC/uyT/bfXU+E03qSB5aem28E6VSU8=;
        b=Aml6IIkYXxTyKETarHMiHxrds2vehcehd23+vnS0f/bnibUNFQ1L5wYpYRKVfZ55ec
         Zcgmr9uxDpGz5VOPh4XRKql9tmrU45zwt2DOYsQiGEmFEa/e2oYE7Zcti7aR7XTcK4X3
         p29QYeGbbPslrLHCHd57j4W+f4NGcaOM0YwPkyV7/t08gMfY8025CIHoQWOdmKGvAcqf
         1X6OCzYvJGg2VAuDE2kzo2N+CoBY79J1NWt7Y0TvnbaAqv6UXLXFWY5kZ1CKEv9SbPhU
         Cl6JgmCel07JKkfbJzMZfBQiFB85FwD/CzT5BjOU+djYoX9RDiObB79LN0k7Sdducw6G
         dPHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpxlZQCg2M33L0FgCbyZz+IBmu1IQ17WfTZx/sI2vVMfcZ3uDj1dJlW+lIsett+aMeVwfbGwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGaFgqydvMYBk4tKm1gUNenQze9wnxTQ6HZ9ibh/aTzlqw/Um
	e2wNAwxNTqI/FMBhwK64NuM7WqHGHIcaw9OmvD7cXAr9waR14PpDvVAKvqsSY4W5m0ULd42zL+H
	Jr3hrGlEfTg==
X-Google-Smtp-Source: AGHT+IGT7VrT47gIJk5s+DZe0/qm2fS2qnzx2SyAUbxE+0e+EgfOvP8QC1Iw9Lmp37zfK+kJpwEnOnk2bXEHVQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a5b:c01:0:b0:e11:584c:76e2 with SMTP id
 3f1490d57ef6-e28936be41bmr6126276.2.1728049643105; Fri, 04 Oct 2024 06:47:23
 -0700 (PDT)
Date: Fri,  4 Oct 2024 13:47:17 +0000
In-Reply-To: <20241004134720.579244-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004134720.579244-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004134720.579244-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] ipv4: remove fib_devindex_hashfn()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexandre Ferrieux <alexandre.ferrieux@orange.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

fib_devindex_hashfn() converts a 32bit ifindex value to a 8bit hash.

It makes no sense doing this from fib_info_hashfn() and
fib_find_info_nh().

It is better to keep as many bits as possible to let
fib_info_hashfn_result() have better spread.

Only fib_info_devhash_bucket() needs to make this operation,
we can 'inline' trivial fib_devindex_hashfn() in it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/fib_semantics.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 1a847ba4045876c91948bcec45cb5eccc0ef1f31..1219d1b325910322dd978f3962a4cafa8e8db10b 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -322,17 +322,12 @@ static inline int nh_comp(struct fib_info *fi, struct fib_info *ofi)
 	return 0;
 }
 
-static inline unsigned int fib_devindex_hashfn(unsigned int val)
-{
-	return hash_32(val, DEVINDEX_HASHBITS);
-}
-
 static struct hlist_head *
 fib_info_devhash_bucket(const struct net_device *dev)
 {
 	u32 val = net_hash_mix(dev_net(dev)) ^ dev->ifindex;
 
-	return &fib_info_devhash[fib_devindex_hashfn(val)];
+	return &fib_info_devhash[hash_32(val, DEVINDEX_HASHBITS)];
 }
 
 static unsigned int fib_info_hashfn_1(int init_val, u8 protocol, u8 scope,
@@ -362,10 +357,10 @@ static inline unsigned int fib_info_hashfn(struct fib_info *fi)
 				fi->fib_priority);
 
 	if (fi->nh) {
-		val ^= fib_devindex_hashfn(fi->nh->id);
+		val ^= fi->nh->id;
 	} else {
 		for_nexthops(fi) {
-			val ^= fib_devindex_hashfn(nh->fib_nh_oif);
+			val ^= nh->fib_nh_oif;
 		} endfor_nexthops(fi)
 	}
 
@@ -380,7 +375,7 @@ static struct fib_info *fib_find_info_nh(struct net *net,
 	struct fib_info *fi;
 	unsigned int hash;
 
-	hash = fib_info_hashfn_1(fib_devindex_hashfn(cfg->fc_nh_id),
+	hash = fib_info_hashfn_1(cfg->fc_nh_id,
 				 cfg->fc_protocol, cfg->fc_scope,
 				 (__force u32)cfg->fc_prefsrc,
 				 cfg->fc_priority);
-- 
2.47.0.rc0.187.ge670bccf7e-goog


