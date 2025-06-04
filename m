Return-Path: <netdev+bounces-195060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F4EACDB28
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523FF1881CB9
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2C1E5B65;
	Wed,  4 Jun 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQMdVrEl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C884628C849
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029972; cv=none; b=RiCkTAfxh8vVblurv+vionp/ojB7WNNw6Zh6r58hXpvS3vS3j8nH0uEAOpewHH1N17h6an+QO2/C+jVjwNEuRZFJpju4sAPKrHB1wEDJoXgOTUgJfx78CC0ngEbr8yL2oRPK8wf8t7YIiE8ATeCdWCFuXI3z20I982dKYfvauM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029972; c=relaxed/simple;
	bh=S/nU51ezINmKqUymi1Yi9xBxJD4pe4GuUB97QEpwcgk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JzkaT1iYa9xOnlTO4BZGH5bnpPuxsJwhZcCXxLXAvzupnI3jBws9vNYx7uUUNuX3s/QhRWfeLXdk+5cg754ndBTzgEP78OnynH9EjSWV69t2rCBSI7k2XYnKZAW/bCwaYxZMBlWLGzFlfV5nVYoMXpMdPcfdnO4IvoZLCpuqi1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQMdVrEl; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d21fc72219so931185a.1
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749029969; x=1749634769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cU6MEzVc6Kwm7vKkLxi7hg8K/p9attCEoppYME40tQI=;
        b=bQMdVrEl0vTzE6rIpu/GjPxXkhIOBeyPF97qO67KbY76IKho0Kcr4N76YAsyY2IMIq
         vsSY8LHw7mWuTH58sZhjMYnp44gpEMV4TYKhIz5x6NfFk3pScnu1KKDfcpua9qoTj0xY
         eYXrqC9s7d4BV1TZvmFKNxNbnNGn0LfpC0cyEiE51OAtDm4EuJ9PfiqhAwGyCucb3Q76
         gq76IxXPb+DG1TxoWBR16VJOv6NCPJIrPf8R0K1dteiQ9tk0z5z52wRi1ozRQ8hd7Mel
         5jFdctkEGq4vuw7NtK/GTR7UQ5zzVCdm7+X3EYV1MLb9x9+zFleUz+vNQGuoRyO1gq57
         A6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749029969; x=1749634769;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cU6MEzVc6Kwm7vKkLxi7hg8K/p9attCEoppYME40tQI=;
        b=WBgW+NnLWmtNZ3sxIDZutsgvrlJa9VFRZ92L0I9keQcCAjmt+DT4m+V86XukLv2an3
         jiRfDLyDByCZAv+rXOLDOaXDK7bs6vF09lNJ6igaNpTeBpSjKnG0I2kJ0lJOe19srA66
         /rC+iBKD6FzZ2dUaWXwBfjRn/S0s68mdZ+EuDUhKpq0VJVylGRLK99gSm7L0lrZ0Mf9g
         HauDKvcVgcJTvBZRrYDhJMOxbVlM+o/iw/2Kuuh/BNNBt5QckunImSBgBwSHeht5DNMc
         nEzfOYypCBxHvI1mAR/W14e/Gri9HKaPgsdLYoWUsp+VeQNeCOucEDkihOrjEfgBtnQH
         ekww==
X-Forwarded-Encrypted: i=1; AJvYcCUCL2h2lTWip6nutCh8aMAVy2wdFrr2vZwsXgWLEp2pCEA3qY2RLtUOQoK0jhDEQe17G92bjFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw119fHS0e1NH5f8cM8KAJ1+diVPKAhuWr5NJA6FzGTyiFdJ384
	PViSzi2KQjDLeoRTx/28oYs/bQfZkhZkL69xlP9B9Wqoy6Cq1AVZ+kNN/pvs8EIMppVyuy7eMMw
	yftssscWTYlXrzQ==
X-Google-Smtp-Source: AGHT+IHfGBZI/hFZOH3mo6BUOtKM1/AYAsDk6SO8NHCv9v1bx+72C8jpRRxmUO/EI3a9jshIo0wRmTOL6GFRFQ==
X-Received: from qkcc9.prod.google.com ([2002:ae9:e209:0:b0:7d0:9bd4:d3b0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:40cc:b0:7ca:df2c:e112 with SMTP id af79cd13be357-7d2198cc90bmr369472385a.45.1749029969617;
 Wed, 04 Jun 2025 02:39:29 -0700 (PDT)
Date: Wed,  4 Jun 2025 09:39:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604093928.1323333-1-edumazet@google.com>
Subject: [PATCH net] net: annotate data-races around cleanup_net_task
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

from_cleanup_net() reads cleanup_net_task locklessly.

Add READ_ONCE()/WRITE_ONCE() annotations to avoid
a potential KCSAN warning, even if the race is harmless.

Fixes: 0734d7c3d93c ("net: expedite synchronize_net() for cleanup_net()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c           | 2 +-
 net/core/net_namespace.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a388f459a3666e3d186fb38d1eebd7cd33eb6979..be97c440ecd5f993344ae08d76c0b5216c4d296a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10499,7 +10499,7 @@ static void dev_index_release(struct net *net, int ifindex)
 static bool from_cleanup_net(void)
 {
 #ifdef CONFIG_NET_NS
-	return current == cleanup_net_task;
+	return current == READ_ONCE(cleanup_net_task);
 #else
 	return false;
 #endif
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 42ee7fce3d95b5a2756d6a3780edba070f01ddb6..ae54f26709ca242567e5d62d7b5dcc7f6303da57 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -654,7 +654,7 @@ static void cleanup_net(struct work_struct *work)
 	struct net *net, *tmp, *last;
 	LIST_HEAD(net_exit_list);
 
-	cleanup_net_task = current;
+	WRITE_ONCE(cleanup_net_task, current);
 
 	/* Atomically snapshot the list of namespaces to cleanup */
 	net_kill_list = llist_del_all(&cleanup_list);
@@ -704,7 +704,7 @@ static void cleanup_net(struct work_struct *work)
 		put_user_ns(net->user_ns);
 		net_passive_dec(net);
 	}
-	cleanup_net_task = NULL;
+	WRITE_ONCE(cleanup_net_task, NULL);
 }
 
 /**
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


