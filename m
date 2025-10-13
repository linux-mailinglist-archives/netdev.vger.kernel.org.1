Return-Path: <netdev+bounces-228807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E961BD3F3F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B64B18863D9
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3830C35C;
	Mon, 13 Oct 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCSNwkhy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897030505B
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367263; cv=none; b=F4KpADgpScLn3g3u12tZv7rTw/Il/E0BB4U2Nwv1vyE/muyyAifri35L0ZqhbFtnfYtw0POVovfGTM7rvjnqT9SIB4KUONMNHOb0b96vL+rbprYvN5njyGRU+JL1Vg8EUN3CQ0fV2YF9aWzdDVNZyKjqJCqd89TZuoApgeoCJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367263; c=relaxed/simple;
	bh=6TDEsZ/d+ZchQ+YUtQq30RN8kN900flDr/OsMOpvjtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t1Re6zOGBzywJRVhs5X98dAxa03EZW2svxtQSN/6+vh5rpnFNAR5cllFKNBuT+McmdxgUGFKep2T/tjjIYtcAtJxxGNWVLJDYu3bfFOGR6K8933txg8t57XuYaKOZ654qFU9jPHInHUyE/J2FbBFylHeOrHyf4PqaoGwIjrlulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HCSNwkhy; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-81a8065daf4so131371936d6.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760367260; x=1760972060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAJC/elBYbN9mFiyODP7E7f/su0W1hYJfJY8so7cXa0=;
        b=HCSNwkhySu4NXg2SXjv35yukQGdALQvMFZuhawTrUm1hfIXdBIII22LGAdTqKYxb1p
         u0qkf9QDFLiGfplaJyml2+EFLn8G43uhWwbL5RPJH2lm+EEAT7Zh2W9eQxDLdI4rXSTQ
         qvTPeAjMLnKkuA2GhrlsE0X2g6Mq9oKQOYGM1dysoB9ujuVdL65/Pk9lq1jxxzEuk/34
         OtD+/TcUYtvLv+eMkfCJek8lWNhFBeDtsF313S0McgpCJO9m98vdW7q+72SwqpwempRj
         wNgR/Us85PZX5524AczolOyBrY5XdM+1PSj2e9IoWVgiP9x9ft0wPc8565cdoCd4/nEJ
         PTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367260; x=1760972060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAJC/elBYbN9mFiyODP7E7f/su0W1hYJfJY8so7cXa0=;
        b=txJROSfRllyviE+DV4hIakcKye69KaTQw1YL9j79a4ThXiTrPZ0pY4Mg90n5CQfY3i
         LT3iHunYFqWK4a1PMbGXslugpItrAPCM5Ublckh2/rI6YI667qpc2usKOPObDAsknyxC
         nJfKo/KRi51T9yrhkFN0KeXI+16ay1pavu4CTz2q6Ixz/3pi1mTKsx1Jzr+nnPfDhzCu
         nwH7dtl6zGABq+jV/T9vlTc9DAIOiXI8PpEaLEFLqN/FLg7XLGkNFByYOHEBMbJXbPkJ
         BvO/4hgeE1gDkBFC/aW5w86fMSgkArtg7JIRFBS6w2uA3gtzIgLuBW51TDA2A0pD7NBi
         Ni0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpXcSEKOf7GWYVdHxYevlpxXlaiHX+lRNYELr/Yrlwzhgl8L3PTvEkzF5fl8EG4JqcwpA2bkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmRF95PwCGkX9qZVkNbD/h6OuAyLfHvfiez7ZYKd+G1lKKVQs
	8z67/tlWb2OArDNAEzB5bqLEi595+AK5v4pPo9hhAx+24zIx1E+m21yz2ELpLWqPZFP4YA82lK1
	HMGZa28iHozyK2g==
X-Google-Smtp-Source: AGHT+IGF97zkY8g1nSw7MH5pA88MkNTr6JSO3YWACqv8LK/WR5NZr4Slb0242tRrtc8jhwav9W4Be03StI32bg==
X-Received: from qtko17.prod.google.com ([2002:a05:622a:1391:b0:4b7:a698:dea7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4814:b0:4b5:dc7c:a6ef with SMTP id d75a77b69052e-4e6ead57ffcmr294427571cf.50.1760367260310;
 Mon, 13 Oct 2025 07:54:20 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:54:12 +0000
In-Reply-To: <20251013145416.829707-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013145416.829707-2-edumazet@google.com>
Subject: [PATCH v1 net-next 1/5] net: add add indirect call wrapper in skb_release_head_state()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While stress testing UDP senders on a host with expensive indirect
calls, I found cpus processing TX completions where showing
a very high cost (20%) in sock_wfree() due to
CONFIG_MITIGATION_RETPOLINE=y.

Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..692e3a70e75ed14786a67d72bc2ebc0282eee2be 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1136,7 +1136,16 @@ void skb_release_head_state(struct sk_buff *skb)
 	skb_dst_drop(skb);
 	if (skb->destructor) {
 		DEBUG_NET_WARN_ON_ONCE(in_hardirq());
-		skb->destructor(skb);
+#ifdef CONFIG_INET
+		INDIRECT_CALL_3(skb->destructor,
+				tcp_wfree, __sock_wfree, sock_wfree,
+				skb);
+#else
+		INDIRECT_CALL_1(skb->destructor,
+				sock_wfree,
+				skb);
+
+#endif
 	}
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	nf_conntrack_put(skb_nfct(skb));
-- 
2.51.0.740.g6adb054d12-goog


