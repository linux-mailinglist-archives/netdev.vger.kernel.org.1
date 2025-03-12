Return-Path: <netdev+bounces-174104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20246A5D80C
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742B23B67A7
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43A22FF58;
	Wed, 12 Mar 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkD5KzVR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7852343B6
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767779; cv=none; b=okOk1C4k75x2gFaFwkr/n9M34uOGjeQMUvBSldl+LUep0E0uiiL/4/mnXEItQkVJmCpFo2iyrMkiK5oUWJ0LxY4XkHTnRSrZqbDViLL1HYAu+5lkuJ1Ws36Pt7hr+NuA0BMtP1BSXAm0AnmdqFdrL3B4GKoF9/z+Kq/oYm8BAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767779; c=relaxed/simple;
	bh=UJXjm9vBldSi/hkafYg4lNkNrzlwe+skns3EdVAb39k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nHOToOPixXiJ9FIDDl/2o7i2RTF1gPwUIug3WZ+VTdouMkfoJkaRDwYNCJd929GhPG5CM7ka7AOiqo+I+lBivLb7cUL5GCvV5sB7swNTaTnXLsX7DzYasIMzmQCQRhWk4She66263JIwLakrnyIHQ2kd7uPMC5xAWzQMJ2Gv6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkD5KzVR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6feeba593dbso47097627b3.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741767776; x=1742372576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5qizVoYkkXYdXPhYIH3fTpdhCWLQ3ifBsJyZHmBAXM=;
        b=kkD5KzVRJwTlHSVZHxsTymb4cShPTDACxUtaxuzYGHVOgzyxWum8yKFf+F2fAWZsQH
         guLJcnGkrM9aqrp/XTecbGR39H5jlkCfMijOSFy34kudtrTPHUeaCDeeK1VXu1Hv+wA5
         Ew5XkBMvdro2DuY9ukZ9UqSYB5ykyETWCE0lkj+JJruL5Eof0vMw1QVdUEJbZRbLJTme
         RhXIWvyxb5QiIv3rUGc4Ry9S6VK/++VMCbmOXfhcl4CvILSwNTz4USQKEiOIyyJSX0EB
         7ufFBPSfebyRpcGdXTJXGcn0p3g3OicSpYRgQ/HNZYXP/OIUwqOX7btkL1FEmC3mXj1M
         FWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741767776; x=1742372576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5qizVoYkkXYdXPhYIH3fTpdhCWLQ3ifBsJyZHmBAXM=;
        b=IrK7Kpm9sjw7oUK2fLiEztVHiSrwm8kz/685rkBAPVSYulbdjpa+agzCeIicAUuaXM
         4RIxAbPjCLwfvLo7AlvP/yN0/l37BREdbxPnm/JzSptrW+BBbDv64j11B0JmIyaGEZ7Y
         2XpPHiQkIVGyiYbTgmg8zuWo5oHlryUJtjiOLcYswveSxCz/qDdatmwLK74HJKE8j/GX
         gd5GfzuMPWs2J3jip7XiVDnSkMnSvOGoyiF3awqwWO5Cxmsb97mJZ0DXqPsnesMawkOV
         WyBeDFpgU6dUx7hJaZ8JNsd7vgCPnfWHX17817i45FC7FucEJ+gRXXFmq+qgM4qJynT9
         g2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1v5C93syW8rveblxbfMdqS2yjVHfDExJ0Tp1juU6FH0pXrnbyCdAbVTd/aIyVHbIxkW9n0V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAm+pJ2b+7npqWYJjUDe5+C7NqIdRRWSswIIi1VNvtzUI4TZ3
	CmB7j400uu0RV7SiYeFpy/9lnAE0JUVj3ClhMMYe4bhHoGWeba6lqO8Phywm6HYwi7U7NaLHV+1
	sJZf5hV1TQg==
X-Google-Smtp-Source: AGHT+IGyIubh0iAzSs3NwGk/fYqbEmFvuhp6O48ZFwoBbcDOq03Lcp3sDKdOkgTsq3aR0Nny6rJZgdAqNZa7Bg==
X-Received: from ybux13.prod.google.com ([2002:a05:6902:138d:b0:e60:d88c:4485])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:2702:b0:e54:9cb1:21a6 with SMTP id 3f1490d57ef6-e635c145920mr24881301276.11.1741767776607;
 Wed, 12 Mar 2025 01:22:56 -0700 (PDT)
Date: Wed, 12 Mar 2025 08:22:48 +0000
In-Reply-To: <20250312082250.1803501-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250312082250.1803501-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312082250.1803501-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] ipv4: frags: remove ipq_put()
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


