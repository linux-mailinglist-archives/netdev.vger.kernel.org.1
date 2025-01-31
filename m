Return-Path: <netdev+bounces-161806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35162A241B4
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7033A9ED4
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109761F12E7;
	Fri, 31 Jan 2025 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pudoRze/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689FF1F2C26
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343644; cv=none; b=gBzXkCqOX42J45tkfnIgAuOiecFte8IX4fWih/O3Sa7tv/UEaZkiBxJrgPINEBRcbz7bp67bbeO4vX7vdwj3J3QUUeiJLu7p+7YGZ2v++rxr4UBLAd96ZigCvjmmMTghINsRDnTk1KewTIGzSR+MWq2lZ/dzvykW4ZcdX24+g4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343644; c=relaxed/simple;
	bh=z/Gd/AyBzACxdLrO82JAxmDUrQMb4RAwi7zjP4LPEbg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qT+FPR8vNXYz/XumzAclv+DkOJcU+d1Bjzbe+nS9qQ3coDBHArCwL5AX5rCE42mV7U95d81Me3zGILqynUZqybf1eHGvZ5dacr/ccvxiWAfoxU1isplIMAn84WYipTj39kxoQ9aCwE1lLbaeTVsDdYsJV7vCnjAUZMjyWd97cZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pudoRze/; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-467b5861766so42755141cf.2
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343641; x=1738948441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBfobVX0dwL0vKD9sn/rDO4moLPZx2lQR4FzHvX8FCo=;
        b=pudoRze/yxn2EyILvFWZYQagymzZ4Tva8L/Z5wK7Z5w5ouzP/dHB75ncZ3ZsH/9fqT
         oeRZMGjLGkO9CsewqwBRb/oLHJblTrkxpZhrYUSqJHYMyJE1nE3M7R/jgbUxTakYi2Hk
         bkmD1/OM5chv2hy34niWcb59zucIm9DCzU8LM7dgTxXmfMdKshQWcF1lStRNuYMxlNJf
         vSkVpM2iJwus7oJJckg0OaH0kBfQ7bGQqwdJrMiU/PFwmmQFB/i2Lejgb3Kuv8ycC1C0
         /rwt7coLU0fuUm5LnYnlmlHahATM+VO19uf3mr4SG1XPFdrDHUUyGlz8Uc+fDoHcw2rl
         KB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343641; x=1738948441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBfobVX0dwL0vKD9sn/rDO4moLPZx2lQR4FzHvX8FCo=;
        b=cjaW/zZkAzjhMhVDuCj9jNGqYzBhyBMR7ZOrsAo/zRB/O744AOr8nnzZ3K89CMYiU9
         Qj09KPE03MolYJ6FM6YhgGd/wi09aOaLra8MzuL42AKHzfnildyxkeeJZI7p4ApwVfqB
         t9A4soZRk6iI7MSFYxbvdfr2GqEx74RcM0YI0W6SB13FE7cmD9jiVdeJj6JsKKy+Mdgh
         tQAKPj+lm7BJOSKrduzGsiwYTfTXl1X+2Z/H/XvwU5WnOBXeNfsjnSh8KSVSJTcKA9tz
         J6V8wEoBKv/fovpGI3PlpwTDaCegLrDc2RncDRItd0Q4yBE0556G4ZfeiLzJCgdTAUfb
         NoPg==
X-Gm-Message-State: AOJu0YzU1wWxOj+r/MDGx9Rh1Etg+LjvGWr6sd9K2rmAbtndkKp+F+er
	VuR5bM+o4ZOSm5TYbacamMLMVMIzs5FBYC2snZs4TShCmsNdSSLijK9dEQHy94ZwTYA8Aguao0C
	z2uVkidwjBQ==
X-Google-Smtp-Source: AGHT+IGZfUd0OVY+AINu8eDSPR0yo+hDcTYFywZq7XGHO48zKKytSl4RyK9sEqPRxaAydbXQLI0fZsupG88NMw==
X-Received: from qtbfc11.prod.google.com ([2002:a05:622a:488b:b0:46f:dea3:63b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d13:0:b0:467:677a:74d with SMTP id d75a77b69052e-46fd0acc386mr150235951cf.25.1738343641405;
 Fri, 31 Jan 2025 09:14:01 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:33 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-16-edumazet@google.com>
Subject: [PATCH net 15/16] flow_dissector: use rcu protection to fetch dev_net()
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

Fixes: 3cbf4ffba5ee ("net: plumb network namespace into __skb_flow_dissect")
Signed-off-by: Eric Dumazet <edumazet@google.com>
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


