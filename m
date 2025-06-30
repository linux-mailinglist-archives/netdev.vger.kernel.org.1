Return-Path: <netdev+bounces-202362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5AFAED8D9
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8389C1715D0
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A86247282;
	Mon, 30 Jun 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7KBS8LE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A23246BB5
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751276149; cv=none; b=N1Syaf1rtILhFhYlvG2m9VF3Ov0NeryJma+vkHySUh0uNEUbvm9m7WJ3auLmxM449JzOL/JLzkQ5EDTD77rfVhLPkwKvjxuMka9tsRiYyjw2Gob8PYnqul8wpesFMZNQ7nytorMbhEPhBSsbii05wpT8/L5LYoirSeZPKmvq9F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751276149; c=relaxed/simple;
	bh=85id3KV4i9fmWAQMiUdL0HhBTfbvyoo2J9um7Szlqno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mHAu+ovexOSdG77gLTJ/Fl/6RtvBU516sRRCdI1YPj+zdEZrMbc/Q4MTzfCZHPhz8cpRhwc/7mS9FHpwB6ZaYAjyQH5CkdQ4vue6+N96GrAgYafOSwslhBKiLSNcwPXhBndvmOebTHDabOIcVta/58yIg5KBWJKyvR8e4JtioPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X7KBS8LE; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fb0e344e3eso20523136d6.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751276147; x=1751880947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pJJWytHmieTNPG3lO9Msjfe12+U9V4hu7S5r6KlNVo=;
        b=X7KBS8LEk8PFUzWwc/IjO+ljP+Uy+qBcbEqV4rZJdfWN+zxVqIbrJhclFGdImZzwu+
         rYunqFPEUlJ+yeezeWjZ2d4H9Y1xWNZ663B312gV9KcYZz9ERYScOBNLF6o7D8PEl9Gq
         mR7sKYBjzqCLSWJka6kntackjG/iuDLT1uDcQqAOReXFR3Xplo91qbsHSxzStgAtSEd3
         X1oTxtoP+UidBh8gUYeduQhEGvvtNZWR3HxfqcT3E9cNy0WE6HyLC46T+6aonfPrLb2I
         agbjP2fB/ZaYSPsMoPrboGFxb2boByR3mQTWpfQq3VUng9MXHTG83gUBrW2JzxsUi9Nw
         /s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751276147; x=1751880947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pJJWytHmieTNPG3lO9Msjfe12+U9V4hu7S5r6KlNVo=;
        b=fa3EN5p3pdFXYqj4y2K0dfrvaHt+eHdHaOQgZ9ABY6DfNiyO0ufZ6Zx2gER/dZ7bFz
         ekT0KDOynez2ZbYLXIlK8n7kf2r82L5KkgNTuayA/9EwGQUPokdAHqNnrIAcjNfFhUhu
         mGi/YoIJLefNjOcp0vhaBh/LawVwnfUUrb0fRUJmHscMFlRba+1H7vqiCBT8T4jz8w/T
         AETRSqocBWVTuaNn4H8yOj5IwHuf+djApQ6GgTPhdV6uZSRS3Kfjm4k9EdRPbbmdaiDu
         F3MyTgL7CUANn1y7FLIc/QmcouZ4yfpTR3S/yyImbHxbXzG2AyTII59eYrO/kFAap3dq
         mPdA==
X-Forwarded-Encrypted: i=1; AJvYcCWGUlrokplMlrEG23n36x8ywC6/PiurTSxAlAEmYrfC9xUpKXxrzHX77P6SVuRyefNzMePuWMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWZngeFLYddELucJlPs/7owPQgrnOWo3obFiFTVfcT61P3CYz
	4+SlAlJJO5h5qCO0mhiubkCrlvNvb2paWqEMtZmBvYpN0d49vhtw8zrjuZRVFQsZ1oKP3kd7sov
	TZpfqDNOPHLeoAQ==
X-Google-Smtp-Source: AGHT+IGt9SS7jjlYup/mLlL2RvRZOpddcdkNgmGmzsRMYhIODfY/1Q9QR67X5xyw2parkAH1LGiJF/ZWpRGtKw==
X-Received: from qvc21.prod.google.com ([2002:a05:6214:8115:b0:6fd:76e2:e3b5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:cac:b0:6fa:cc39:9f with SMTP id 6a1803df08f44-7000233d01cmr196360596d6.32.1751276146777;
 Mon, 30 Jun 2025 02:35:46 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:35:38 +0000
In-Reply-To: <20250630093540.3052835-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630093540.3052835-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630093540.3052835-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] net: move net_cookie into net_aligned_data
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using per-cpu data for net->net_cookie generation is overkill,
because even busy hosts do not create hundreds of netns per second.

Make sure to put net_cookie in a private cache line to avoid
potential false sharing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/aligned_data.h | 2 ++
 net/core/net_namespace.c   | 8 ++------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/net/aligned_data.h b/include/net/aligned_data.h
index cf3329d7c2272ec4424e89352626800cbc282663..5c7badf71f043a2bbc871b0063c9a2d2a4ffbfcb 100644
--- a/include/net/aligned_data.h
+++ b/include/net/aligned_data.h
@@ -2,6 +2,7 @@
 #ifndef _NET_ALIGNED_DATA_H
 #define _NET_ALIGNED_DATA_H
 
+#include <linux/atomic.h>
 #include <linux/types.h>
 
 /* Structure holding cacheline aligned fields on SMP builds.
@@ -9,6 +10,7 @@
  * attribute to ensure no accidental false sharing can happen.
  */
 struct net_aligned_data {
+	atomic64_t	net_cookie ____cacheline_aligned_in_smp;
 };
 
 extern struct net_aligned_data net_aligned_data;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index d0f607507ee8d0b6d31f11a49421b5f0a985bd3b..e68d208b200dd4be76fc08af73054b3d1dea834c 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -19,9 +19,9 @@
 #include <linux/net_namespace.h>
 #include <linux/sched/task.h>
 #include <linux/uidgid.h>
-#include <linux/cookie.h>
 #include <linux/proc_fs.h>
 
+#include <net/aligned_data.h>
 #include <net/sock.h>
 #include <net/netlink.h>
 #include <net/net_namespace.h>
@@ -64,8 +64,6 @@ DECLARE_RWSEM(pernet_ops_rwsem);
 
 static unsigned int max_gen_ptrs = INITIAL_NET_GEN_PTRS;
 
-DEFINE_COOKIE(net_cookie);
-
 static struct net_generic *net_alloc_generic(void)
 {
 	unsigned int gen_ptrs = READ_ONCE(max_gen_ptrs);
@@ -434,9 +432,7 @@ static __net_init int setup_net(struct net *net)
 	LIST_HEAD(net_exit_list);
 	int error = 0;
 
-	preempt_disable();
-	net->net_cookie = gen_cookie_next(&net_cookie);
-	preempt_enable();
+	net->net_cookie = atomic64_inc_return(&net_aligned_data.net_cookie);
 
 	list_for_each_entry(ops, &pernet_list, list) {
 		error = ops_init(ops, net);
-- 
2.50.0.727.gbf7dc18ff4-goog


