Return-Path: <netdev+bounces-162121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54A1A25D12
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2060E169442
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE55A212F94;
	Mon,  3 Feb 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYhukk/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367CC21323B
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593072; cv=none; b=Egrhj19tgmJbb3h7qUbG6+/aFtPAcAATQiZV2TyVggcyf9Tf9cNT+GNUdHb8C0Spg81OcATm0Ph6Hd+eXkXs/4KHtPfPD+C/dKCvQpeMFNlJYiWE/hBrGb3bCxLi/8cv5rD4jdzlWhtrJ8oh8doD80rF4xdcMMt9f/pKr5vMKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593072; c=relaxed/simple;
	bh=61JFgdUJmDeeiN7N16KSRF1ODvG6bk9e92yKxXiKpG4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eaC3baatUhgrZTmNzwPtNW4kJFwHEqrKTA+C3FEZKnd9yyI8WBGp83ATJ1Uh5my+Oh5ULweJzINhT1Y1zWq9oMQ/1CkIAYyX3FWekOOyF43FA5EghxCQjw5QaXRNleGMJ4R0VztrhDL59A7sQZYfx/xMY42NNiYslE3ElWZZF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYhukk/u; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d8f6b89dcdso80269776d6.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593070; x=1739197870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBI7ETjPQaZc4LNnxDqzKU2PtlRuMJYL7UoYXTXXF3w=;
        b=IYhukk/uxvWdm/v0Srzn1bXkni6+uaVsQpr4m2Th25xFjBGEkxz7TLH6CKWHoYuoA5
         86DlRxTZgZ/4Lpdfo3TguXR+a0Giv3IKs3bHVB4qoOPkRgDnDc2+If+U2C7XMy6xDAP5
         MP1dru9imF3DzdwFxtREhWd9dnMwUeRo7cQkvJ6sZTEXZAktsPcSdidEUvrImZ0a2sMR
         L57tZFxFozHbu9DVjhnDeeV+4Ekwci+/Tj+iK3v314rji3YtswaF450XJ/roUR/i2ADC
         ZvFPg6syMZKWZwjXEt9ioceDSJrH/sgm9PwEtyxyBUcmHQYkth8U1iIKOQ1hvmcRlQuf
         nUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593070; x=1739197870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBI7ETjPQaZc4LNnxDqzKU2PtlRuMJYL7UoYXTXXF3w=;
        b=FYbjBSsj4o0MPKUTpD92PhHiqsEENonh+wkYOb0OhMUeCf3OTBy/NYB4kKmYiCnBPt
         EMYPw5U0xdLsJtiH0AtZW/Ki9dJdeCUma1ldICYv2pDWAU/WCcqn0OvX6bJi5FIve7Kb
         xqpOIMAgQKnpRYDkkxUgppQfyoh1wlvOM3wzvMv39YAVmjrgqJb6pe7rADAXWQOxMr8X
         xmFdNHa4Hra9LMpe3DjCmgGqam9f2L25FOm3u/5qRIcJm0fRstO8eAcd6DHuH1Dx/QT5
         UjZvrMlNKwr+K0/LRz3ZmDMn9gTNto3W4m3yun9NTnlYJJGGK76LDf3SMHFlHdFXa3Uv
         e+IA==
X-Gm-Message-State: AOJu0Yy5fwCNVXHWG34S2LnSTRbrfhSc73n+0yGjEvLcLAY+YxlOOlH3
	b3L7WAr7Lqh06B8EqLPaAOmBh+5CtdEkCKCkXc4GShxUuX94jbygH1wO6gt219Uoboz0yTK+eEk
	j+cepjlYs0Q==
X-Google-Smtp-Source: AGHT+IEUnGr38fjvZMrnke5JrAC8BKwHX7rPMgt8yW2Fe9BtbLB+TM0v42IiAbEK+P1aaatpgjO2MaTJ/BrG/A==
X-Received: from qvboh10.prod.google.com ([2002:a05:6214:438a:b0:6d4:16f0:f91f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4893:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e243c7bafemr346634596d6.38.1738593070023;
 Mon, 03 Feb 2025 06:31:10 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:45 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-16-edumazet@google.com>
Subject: [PATCH v2 net 15/16] flow_dissector: use rcu protection to fetch dev_net()
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

Fixes: 9b52e3f267a6 ("flow_dissector: handle no-skb use case")flow_dissect")
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


