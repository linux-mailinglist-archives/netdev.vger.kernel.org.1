Return-Path: <netdev+bounces-162543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC0DA27336
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A6B1676F2
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60D521B910;
	Tue,  4 Feb 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xWHbvPW+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93A21B1BE
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675467; cv=none; b=f+q5XIG0Trydjup8fTvIllC/TdANowebRzCcHzrfFM20nKxrcjsFVdpHwkiscCuPgPDtf0Xyyo1xO9fLqVENAmrFKI4gfzX+/VLWSeAUWmbRs12fp/OKZRfkDi9jhnBVpRSwOlKcKxY9BTe3P9RWG6dvDvuzCamPJcB7OOb2IHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675467; c=relaxed/simple;
	bh=jfXrtiekqSdBzc9WrJkYrmWZSnEXJCmjaPG8o816zt0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MLWKCd+Nf0YBk7eAa08kv24BgWHL1Td2HhIGq0pjfN+7ljcE3KL80wW+oCHzfQCzAXPoaJhIW8slRQa6vLb976HzdWE67GllZvwuhgNzGHbHHqoedjg/q0cuaBblMU1HcHBZvAyjmToUDicNHIAfwfizyO3U8Tkcnj01CAFfUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xWHbvPW+; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e42cf312a3so3304686d6.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675465; x=1739280265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9656pNZqulCpkfv4AnFRSPaAwvAjb8S6ozBL9altlw=;
        b=xWHbvPW+Mf5K/23shb47v+kwL9gbK0d8nC91yzJVJ4VXSKx1EU4wHSFWvCLUTJuTCn
         STSaNmtswdPgK2jifJ4xA8LEEcMbkj2ZUxR0ytiqPCBw+uWKoAV/1plYMyMVEJIfz8Le
         w47SWygNuWI9qOwJxdiCP6nFtIBSffATxmfi54QAIffapLVAmDPrrFDE5BRc/2VaqVha
         bDoU+CxJjpvIBsWxITrO9HVWWHNPRCnW9JFW6qVzW0SzsdY9vofTTAtX0uVqTNn3Zhbl
         /i2FEdcqxuJFn3rIh+pRyO+yYib624VDOw5ptUHDBU3ZusBCH02brmYbUqy8rC7jqX1S
         gNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675465; x=1739280265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9656pNZqulCpkfv4AnFRSPaAwvAjb8S6ozBL9altlw=;
        b=S/UPvg9dxXME48CBZMKhj2Jn/9tMU76rpLzjLRnjAwQ4Zu3qTZ/lxunrdXB4gx3X71
         9Do6xHRUZ4syQUCp0wzdiKwqSN8RM1+LKGjPDQACiO5wWUG0KCLfsoDtPgrbbvYmXEGf
         nAAOYXHxV23ltu4vH4GlDDmmDvcA7A6FOPeSYqhreUBjH8Dpr2LOHwcfQ/vDkHAvcMMn
         Re5Th3d+n9gOzXTZ8VL63c1ntdcm4BPDyFbmXMRLxse4LWGTPVzwwx1kGCtdT/KL5+Bz
         v/lK9R/1jdtnJsuWUfW6730gmt5TpoCeE8QeHTOGTDozbpdr1vBJo1k4fddn5lCMc2Oe
         qE0Q==
X-Gm-Message-State: AOJu0Yy6Tfwzh7WZ9H3xgJ6z7FzXLro0brnDVvTZuqkVrzVWJfDmrRh4
	5Fq4ZlA+IpSJsrnPRw4LlzLgeQhTAEXWytv6Zv2s2dUV8R1HfVpZRSWQShxKExSWnMfkdGwRwd8
	JZtsZUbmzFw==
X-Google-Smtp-Source: AGHT+IE9DxoYINUB5LxWDhoyYSiSjLKTM/4XABG6y+ibwIZnr8am5AvXEfVF9wgs7RKafEaLzGxEwxJi64prhQ==
X-Received: from qvbmy3.prod.google.com ([2002:a05:6214:2e43:b0:6d8:eaf4:9e3c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5b8b:0:b0:6d8:e679:547c with SMTP id 6a1803df08f44-6e243c63ec6mr335533416d6.29.1738675465132;
 Tue, 04 Feb 2025 05:24:25 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:56 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-16-edumazet@google.com>
Subject: [PATCH v3 net 15/16] flow_dissector: use rcu protection to fetch dev_net()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__skb_flow_dissect() can be called from arbitrary contexts.

It must extend its rcu protection section to include
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


