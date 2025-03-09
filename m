Return-Path: <netdev+bounces-173347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA453A58646
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DDD16AD5D
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC561EF396;
	Sun,  9 Mar 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ES6v9rQZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD91EF372
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541520; cv=none; b=JsBSp8wfkqrd+1Zcj5BgnRDEjVDJ5vD8oMRjyOZRA9prgeH2QqcX1dnlfMleSxKnrkjDIYBQXIyxUbycWQ2044H3zhg2Vuomk217OmqWuEQqRuKuc8Wg8Lpje07osJEGUOXCAJ5jm0w3ozxvLPE8GAhni5CMutxsy1mNT6xyU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541520; c=relaxed/simple;
	bh=UJXjm9vBldSi/hkafYg4lNkNrzlwe+skns3EdVAb39k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b0Qk3udRnruWaxBhGX5F17UaluOxkkFShq97S/VzvADMB4a51T0aoNTn+o2O0Hl/hw/KzXCzTzRxVI5ZKB2xEw408W12/UFF51y/tp52+Qjy7HYL+vjC1zHMzVwpCo+LY0qZ0/8SjIY1vzcTDX8V4eD5AcGmndMJ/RZx7PHsNzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ES6v9rQZ; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e8ed78717eso58553056d6.2
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741541517; x=1742146317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5qizVoYkkXYdXPhYIH3fTpdhCWLQ3ifBsJyZHmBAXM=;
        b=ES6v9rQZNVF+HM7P+Ru8s3pM9aS6gonlCyc/LPvIe/Ti6fkN/YS2jp+V6RP6ssBG/b
         vGPFKjl9/863lKGWDofz3MnKoaS7BL5T5q4hcl7etAFCXdETxuA670Ky00yiXw87Bl5f
         6tPLFHYlvB7f3qy7eJ4h8Ain/4D9ZUY9azn0mvXQLRZ02VuKVr2cQz2OIZ5ib6ZYfUNh
         iySzfzwODFu6ECrL3vOzijZsDfbPVgNGa4nQfi34ypdG/UyTQ0EsMXTuzwvcgUxw9e9m
         HMeDmOebjbdADkN/DVZAkaLukQX9n/COEzIz8Cx6Y+WSfi6N7gQcTOEP/Ga21aaNOY06
         PUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541517; x=1742146317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5qizVoYkkXYdXPhYIH3fTpdhCWLQ3ifBsJyZHmBAXM=;
        b=XwhFYrFOTqUmVxVnws/XLm93JRKo54DmKbhA2MLEHmZAj739vLUcyRfJKk1idWjuZC
         fU+uOvLFuO9hVfrRFrsmgqmRQ+4E8tbQyEfAplPRdvQbKJoKLvzNkNQ5HY+Y2YevyHDn
         Hdm6io+gZPagKu9jaZkU7gc00uzx4u9jPIOIizOvAEmAS60Q9BkhEQCjCVJ+J5ZmGD5z
         NSDfp15LgvnUow15gcDdj16HmnStjQ3C3wf9mBF53wM8h5CNdEoLLOGAdFU2+GhvCVYY
         sgom7np1Tm2jtSeBerRIo2VN++CAGK5864tlrEJDQUlM+CzFaqfCODRmHPa4WlIvyjqR
         827g==
X-Forwarded-Encrypted: i=1; AJvYcCVSn7MRTcz5yfafSOGyfFhXEWh4G1H0xQbo3N/9wtQ4cwOnsf533ZKbkQj754gsnQvj1OmiHPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2RwGlAgfIvTafdhQEaQ7oFDahTEMEUJxMpsKzAZyeX7mZJtEW
	UYXfx/b8WWLZAWYQ0gRZYtFISVk8x8yztbN+stoQLIox4GhfShVMpYQDbBLU69qP4x8lxqXyK1/
	mr7Ns3OllFg==
X-Google-Smtp-Source: AGHT+IGAUW8lQSP6wTR5890bjqs3GDy3BkFOmhyt6WoHhn32Wvl6hPB6aQLHuV8JSDVejCQb/q6SFYUInBXVYA==
X-Received: from qvbmb8.prod.google.com ([2002:a05:6214:5508:b0:6e8:9457:6d8e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:ca6:b0:6e8:feae:929c with SMTP id 6a1803df08f44-6e90060945dmr144250546d6.21.1741541517190;
 Sun, 09 Mar 2025 10:31:57 -0700 (PDT)
Date: Sun,  9 Mar 2025 17:31:49 +0000
In-Reply-To: <20250309173151.2863314-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250309173151.2863314-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250309173151.2863314-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] ipv4: frags: remove ipq_put()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace ipq_put() with inet_frag_putn()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_fragment.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 474a26191c89802b7a71212968d89ad2085ae476..ee953be49b34dd63443e5621e7c2f2b61cf7d914 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -107,14 +107,6 @@ static void ip4_frag_free(struct inet_frag_queue *q)
 		inet_putpeer(qp->peer);
 }
 
-
-/* Destruction primitives. */
-
-static void ipq_put(struct ipq *ipq)
-{
-	inet_frag_putn(&ipq->q, 1);
-}
-
 /* Kill ipq entry. It is not destroyed immediately,
  * because caller (and someone more) holds reference count.
  */
@@ -143,6 +135,7 @@ static void ip_expire(struct timer_list *t)
 	struct sk_buff *head = NULL;
 	struct net *net;
 	struct ipq *qp;
+	int refs = 1;
 
 	qp = container_of(frag, struct ipq, q);
 	net = qp->q.fqdir->net;
@@ -202,7 +195,7 @@ static void ip_expire(struct timer_list *t)
 out_rcu_unlock:
 	rcu_read_unlock();
 	kfree_skb_reason(head, reason);
-	ipq_put(qp);
+	inet_frag_putn(&qp->q, refs);
 }
 
 /* Find the correct entry in the "incomplete datagrams" queue for
@@ -498,14 +491,14 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 	/* Lookup (or create) queue header */
 	qp = ip_find(net, ip_hdr(skb), user, vif);
 	if (qp) {
-		int ret;
+		int ret, refs = 1;
 
 		spin_lock(&qp->q.lock);
 
 		ret = ip_frag_queue(qp, skb);
 
 		spin_unlock(&qp->q.lock);
-		ipq_put(qp);
+		inet_frag_putn(&qp->q, refs);
 		return ret;
 	}
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


