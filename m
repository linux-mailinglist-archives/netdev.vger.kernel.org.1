Return-Path: <netdev+bounces-163095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF518A2954A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403433A865A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904691DB15B;
	Wed,  5 Feb 2025 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="008YTxKZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9A18FDDB
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770696; cv=none; b=TKfwiem5bugMcSTfmWa4JJd3sf1aSq9bEzRMPLVGZXJJv3R47Fu+SoclpFE1X4LUSRXT0P6BH+fj5YWclf7VwUbneneq8f/TNgQ6b71agjEJjf0vTLXKXeADUNvxm1W0iSbSAv70Fqj60bu9oVrGGRbPP3CSEL1NZoKXm279amI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770696; c=relaxed/simple;
	bh=Xc8ff5ueAC8bLQ/pO9eiqyPVl+q6SognJLrujsKU+d4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QeNWZTAPAPgv38+WYiz1pMjYMjfVDgunAi9h6mJqHnLLHcwwrbntNtS2tieXzgJs371RxNfK/8CNC/eVfJUCsU9Vznsap1yPmEv4vLu2fhYPap3ygvHRL3J/5jU7EbDS4GXNCIBOo9xnYeSeeHQFO7LDW4yC3ASOx/WwRbZH6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=008YTxKZ; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4679aeb21e6so113415321cf.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770693; x=1739375493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIxXoaa9w3rNZaVQW+3hpdC1hH2TURbw45AnZmrH++Y=;
        b=008YTxKZ6yeKKea7LLsAfeP/WAHThw0CIt41MhkI25678NU12O2dTj/bm2rPk1yyHh
         msKwm9AM70WahshgflvQbEPTE27EWYEbeuXSmzILk9dDLtxkaT+iVuLIpbY4Iq1QH6F+
         2o2pQxNxhQ6dhU1QeZswap2Khb8OpCPvhVxwKwrJ/Z8ttPhzw2tht9mYGXMxS+COiu6b
         0Aev93FdB0AoFJbBMxDGof5YKMprYj0jzXExR4N9D60vGZjMP2caKsX0Iux2vn2RENsB
         1zHLUuO+QncTl+HtIhcfX/BqWn2ENy7KXsRFNmpAVNSyKw5qhq1HrrUVTiJMv+d/+3xf
         1LbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770694; x=1739375494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIxXoaa9w3rNZaVQW+3hpdC1hH2TURbw45AnZmrH++Y=;
        b=ebszkAyN7udgonrc08x2Huvi5MtYzsuvtVv46NCLbBaxTh8a5gIt7XAasRDP5mmTR3
         D/TIYbhf0gEYadEK09h3C9RZkIfkQh7sRs8wJ/6O0zxrNd12kGSNRec/adY5RYtuzbL2
         l2C0+LCwrphDX+rwFkLamZcrBiyHDRSOEt/BAjI7qppXlcvCzU6l0oTFlGU2shQWyMym
         WwuYhwjlJssBpJoxioQl1WG0Op8cbrOkkEIRcQWdThgFbAxacHwWHNLzt0KoyuI8sWq7
         itmjA30X36C4o8Uz1buB6pGJw5Y0RjbE+eagDlQIYU+WrZCro38xA+L2iY/CsTp5TEe/
         fYCg==
X-Gm-Message-State: AOJu0YwG6NxCXh4r70OrHI6vCwul/cMDivnvyBJy5dobslc4NLL6Ql3X
	1KNiIwjdCQTBGpxIH8hwzRojQd0KU6Qx00iLYlTHbF8TdvgeuHzg22m15ecAFPyVD/mWG7PDsIi
	b25QXVi6j6Q==
X-Google-Smtp-Source: AGHT+IEGaHN+W+Q/8Nzoe8mWsOMS3YbZPpeCQ6gFrx0eWkOMT7eZBVee7HUjNo+BZmXdGx4Wq+y8u2GUZElI/g==
X-Received: from qtbhj10.prod.google.com ([2002:a05:622a:620a:b0:46f:c959:9b05])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5989:b0:46d:d8be:d2c1 with SMTP id d75a77b69052e-47028009d11mr45322631cf.0.1738770693739;
 Wed, 05 Feb 2025 07:51:33 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:17 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-10-edumazet@google.com>
Subject: [PATCH v4 net 09/12] flow_dissector: use RCU protection to fetch dev_net()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__skb_flow_dissect() can be called from arbitrary contexts.

It must extend its RCU protection section to include
the call to dev_net(), which can become dev_net_rcu().

This makes sure the net structure can not disappear under us.

Fixes: 9b52e3f267a6 ("flow_dissector: handle no-skb use case")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/flow_dissector.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0e638a37aa0961de6281deeed227b3e7ef70e546..5db41bf2ed93e0df721c216ca4557dad16aa5f83 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1108,10 +1108,12 @@ bool __skb_flow_dissect(const struct net *net,
 					      FLOW_DISSECTOR_KEY_BASIC,
 					      target_container);
 
+	rcu_read_lock();
+
 	if (skb) {
 		if (!net) {
 			if (skb->dev)
-				net = dev_net(skb->dev);
+				net = dev_net_rcu(skb->dev);
 			else if (skb->sk)
 				net = sock_net(skb->sk);
 		}
@@ -1122,7 +1124,6 @@ bool __skb_flow_dissect(const struct net *net,
 		enum netns_bpf_attach_type type = NETNS_BPF_FLOW_DISSECTOR;
 		struct bpf_prog_array *run_array;
 
-		rcu_read_lock();
 		run_array = rcu_dereference(init_net.bpf.run_array[type]);
 		if (!run_array)
 			run_array = rcu_dereference(net->bpf.run_array[type]);
@@ -1150,17 +1151,17 @@ bool __skb_flow_dissect(const struct net *net,
 			prog = READ_ONCE(run_array->items[0].prog);
 			result = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
 						  hlen, flags);
-			if (result == BPF_FLOW_DISSECTOR_CONTINUE)
-				goto dissect_continue;
-			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
-						 target_container);
-			rcu_read_unlock();
-			return result == BPF_OK;
+			if (result != BPF_FLOW_DISSECTOR_CONTINUE) {
+				__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
+							 target_container);
+				rcu_read_unlock();
+				return result == BPF_OK;
+			}
 		}
-dissect_continue:
-		rcu_read_unlock();
 	}
 
+	rcu_read_unlock();
+
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		struct ethhdr *eth = eth_hdr(skb);
-- 
2.48.1.362.g079036d154-goog


