Return-Path: <netdev+bounces-179754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB3A7E72A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3CD4206D7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B85A211462;
	Mon,  7 Apr 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6oSbjFq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833E210180
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043775; cv=none; b=sIdcBVto82w5epldXfmYwQAsYWX2aRi/6MRx/g85+jEMxuv0cr80lOwhlLqoDfcV0oUoazTvzFtNKzTGPD1o5EtCcTCyi5xtbgn3FhRZIldWmM6lKrpx4p5qkQsFxodDLwNvKx1TgtMzo0DLL1uZ2/LrdzyF2mEPDKNafqSKIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043775; c=relaxed/simple;
	bh=xuggRy6mQhlUtplVAufQParhzjZOhU465k1NjyDCC/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q5zIdXMi6ZZ1yYP9ufoFLmOQymWF3/1rNSWOCXEfjdUMrxc2HNA0Q7ydgrP8OvqiquFsBTY7QRWLjHKBFQJ2TWDXIGUB/88oH2ZpKlohkd4dcrcpgo6cavSdWUpKfdnI5wk1mBn6sCNZ+W0mNsaEt61v7b8fAf3co7JboRCHmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6oSbjFq; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-86d04803fafso902385241.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744043772; x=1744648572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvgAsfC3Lgg7mbd7CPHYn/q8k/e5QNtnMft9HSuqvag=;
        b=B6oSbjFqUz5+oGhOKVX1a/emM7gV0L7YWBx7NoaaW+qQITzXX/YBPRseYn1aV08hJO
         2f5eb5SYboZTm5s6/KQHT3B8379TeN6Y1O929AqkbNLTc0S4KHwJ6nQm0F4Rwkf3W9BM
         IUes0jSmfEA7zLr/ADdEHGV4SOqKWIS8WmwRXVIptBHDwgRMzvZ5/D3eSnEeK3T3XbG4
         Ydp1jbg9iHLRqlNMyBkLOiZ/wwtbeLHfj+fSUNFCwWM3BFU58bxpIkm54iPxMZLFNXGt
         6fo346EQVyqn+PHqliPIyDqdp8r/jo67ie802OZtQoQdJqh4U6L7tSVwP65whyX4F5IO
         H1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043772; x=1744648572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvgAsfC3Lgg7mbd7CPHYn/q8k/e5QNtnMft9HSuqvag=;
        b=i99xbgCtVgEDHhNHCaLBtcrHT7bbkKm4O63do02K6A0rLCNjmM2p5bYnsGmpY9owm/
         DoRBFY5kookauilmHGakS+yfyVhDVUuYnZuP1uuvvTEZb2Ovzk0w/lTYS9mbTxjEsfOk
         JTB6nFiSOQhG4qpHBaKPgAiA3wPNms6wY+O9MTf/IV7E2W8C9upOPJa83DSWYTxMBwY4
         BfChfZ42G2TfOStkb1Dx8Tu/um1moPFe0qljdS8W7mcCJCakjgG0iWzvFLnhc8HazIEl
         kVKTRzJMGpJErUXPTNNjh7XIroEi92UikRKArauKFoU5K3uvWAN3VpU03CvqvZZMQxZ9
         YO5A==
X-Forwarded-Encrypted: i=1; AJvYcCWSMlEzfCoYgHb20mbwkTYkC7jgI1Q4OQH5M/9/2ZrHMSv3uwTJ4nnZGu435aaHlI/nkdz/eto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKvtHkbjENTo2Mqd3tD2NqnYW0IkkUIlK9FlOnplyb96LCD9Ht
	8gMk4hbfwIJ5xxIV1pCTGcdh7GvHqHG9z20VwwLcF2//NWnY1gjlejasZfXIW/f94Diyj+e58cx
	xQx4CY/JtRg==
X-Google-Smtp-Source: AGHT+IFIe3AePcNRepfbiONFdWW4h/CX3OP9E5cRWAPj/2v2cVS/Sq6Y7njl7OOVkcnYMEPadJeT5iE9gRCN6A==
X-Received: from vsvf35.prod.google.com ([2002:a05:6102:1523:b0:4c2:f06a:6e57])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:941:b0:4c4:e409:5f9e with SMTP id ada2fe7eead31-4c86362753cmr6540898137.2.1744043772386;
 Mon, 07 Apr 2025 09:36:12 -0700 (PDT)
Date: Mon,  7 Apr 2025 16:36:02 +0000
In-Reply-To: <20250407163602.170356-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407163602.170356-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407163602.170356-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] net: rps: remove kfree_rcu_mightsleep() use
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an rcu_head to sd_flow_limit and rps_sock_flow_table structs
to use the more conventional and predictable k[v]free_rcu().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rps.h          | 5 +++--
 net/core/dev.h             | 1 +
 net/core/sysctl_net_core.c | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index e358e9711f27..507f4aa5d39b 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -57,9 +57,10 @@ struct rps_dev_flow_table {
  * meaning we use 32-6=26 bits for the hash.
  */
 struct rps_sock_flow_table {
-	u32	mask;
+	struct rcu_head	rcu;
+	u32		mask;
 
-	u32	ents[] ____cacheline_aligned_in_smp;
+	u32		ents[] ____cacheline_aligned_in_smp;
 };
 #define	RPS_SOCK_FLOW_TABLE_SIZE(_num) (offsetof(struct rps_sock_flow_table, ents[_num]))
 
diff --git a/net/core/dev.h b/net/core/dev.h
index e855e1cb43fd..710abc05ebdb 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -15,6 +15,7 @@ struct cpumask;
 /* Random bits of netdevice that don't need to be exposed */
 #define FLOW_LIMIT_HISTORY	(1 << 7)  /* must be ^2 and !overflow buckets */
 struct sd_flow_limit {
+	struct rcu_head		rcu;
 	unsigned int		count;
 	u8			log_buckets;
 	unsigned int		history_head;
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 5cfe76ede523..5dbb2c6f371d 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -201,7 +201,7 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 			if (orig_sock_table) {
 				static_branch_dec(&rps_needed);
 				static_branch_dec(&rfs_needed);
-				kvfree_rcu_mightsleep(orig_sock_table);
+				kvfree_rcu(orig_sock_table, rcu);
 			}
 		}
 	}
@@ -239,7 +239,7 @@ static int flow_limit_cpu_sysctl(const struct ctl_table *table, int write,
 				     lockdep_is_held(&flow_limit_update_mutex));
 			if (cur && !cpumask_test_cpu(i, mask)) {
 				RCU_INIT_POINTER(sd->flow_limit, NULL);
-				kfree_rcu_mightsleep(cur);
+				kfree_rcu(cur, rcu);
 			} else if (!cur && cpumask_test_cpu(i, mask)) {
 				cur = kzalloc_node(len, GFP_KERNEL,
 						   cpu_to_node(i));
-- 
2.49.0.504.g3bcea36a83-goog


