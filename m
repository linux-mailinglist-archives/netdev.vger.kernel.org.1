Return-Path: <netdev+bounces-163093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E9A29548
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF833168451
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F319D1D8E07;
	Wed,  5 Feb 2025 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1/Q4FOLS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f201.google.com (mail-vk1-f201.google.com [209.85.221.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1781D86C6
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770693; cv=none; b=U3ASKSAnAl/Sf9azXNsnKg0WpYq1Ztxjw9fSEm1+zRFjB147Wp6jjKR0F9BuBYJnBOD/kpNC/92mK2IAgIKtf+tOknHq08rglrM75SDPsO8a6YyzI0kfLa9Oib3dWcrI5McsNsAsdkcMrwyHepP+c69iefpOkwaTI+2F3vfgFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770693; c=relaxed/simple;
	bh=lloKHtDl/tPsHuM5V2tqfCv3EJggBESTK/ainZtC6ZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MiyFG6g81Ux8H8X58/J8QodzycLPhpur+WS3y/cPB82c4ZhEodDbP7wTkPItE8wjPTNeneP71oBfEubKz8F2hQOxFP4BhbhKUr68RJfgaIV+NSnlN+DUDevZ0BEg1uRRzyCL59oi98NpHpgNbrgPbFjNA/A22ukzRnn5d+9+2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1/Q4FOLS; arc=none smtp.client-ip=209.85.221.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vk1-f201.google.com with SMTP id 71dfb90a1353d-5174d5ad373so1460610e0c.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770691; x=1739375491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+6z75ZBLIdNGYoGaeip7gqrPtogtnUcuG9JIWxEt9s=;
        b=1/Q4FOLSEKteFftbEtbGypI3feXVfcjIIA2ZRb3B8EcTHkrTIAbCiqUctVRdD2Flxf
         eGYNl6Acuxaqj22VJVNCXbCv0MH8WIZl0fSpZMmfzBW8Vhb8LbCv7SLEszsnic7CVxAA
         D/REw17mJYHHcPaExGIBSQz8ZgEwEFah3TgjXqUJ/P0ZVtI34+Ek2q6DjK9ses7V3kTC
         1eBE9HCHCHOY+tI9uZer+VeFgpwoq2UPTj05yqdwCJ5URIh9e4VEGnUsQNKJXEJynAUF
         EroUxOEiGPxec1Olj+OHSvKfMs0z9Mu1qVijHWLu/QczjgdOInabnMdMrCEr/FRD6Qoh
         kG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770691; x=1739375491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+6z75ZBLIdNGYoGaeip7gqrPtogtnUcuG9JIWxEt9s=;
        b=jXluaZrXSdERnmKJlcppiY7cXyoRj8/EDKXfeHpHlVcnzUG3v6KHIpOEsyWQcBcAZ4
         Myujin7E6ZpA083+tlpUJ+jER80mPIwqzErDcy1m/P5sds9b32AkGfblPWzjkvwHPkEJ
         WwuDxPNNpg2Bq8Y3vIvqdoApvQYCQxqGZQeqIyEZFwJhiqYTC57FF0wM9qVkrTE5CrD6
         HrKjU1IDakW7aKMRJnnHdnq1sgvfd2x/cgJXcO6Ew9bCGeawQyR4G9x7vl3IroBRs0vC
         TQ5tAi+LIIKfpQiH8tkCbVNEb70e2WL6gXOVcKzw6/OUD1hCWlcXYhrncgls9pQOdQJx
         /nqw==
X-Gm-Message-State: AOJu0YwmjQWgl2J9/rOUZcZF5ZNxLjDU+1yFeZjFI4YXP4K/33pK6WcE
	bLewSI4canXxp2zXAUOMzNamJ4pw+05B+xwZBk313lLaxxhQijwdNsl7SnZyUsnqV7Ha0Sb54x9
	rgHaF14cB4A==
X-Google-Smtp-Source: AGHT+IHx8b7c5rUKa2+cCXQnilAczzNxas3R2E8mhxf9yJ0O+bnvNXQtWOTUN8pUAE9VLywW12m2eHC37zC7rA==
X-Received: from vsbdd1.prod.google.com ([2002:a05:6102:5681:b0:4b6:3e49:b1b3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:2c11:b0:4b4:e5c6:4c66 with SMTP id ada2fe7eead31-4ba478b45c5mr2335037137.6.1738770691220;
 Wed, 05 Feb 2025 07:51:31 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:15 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-8-edumazet@google.com>
Subject: [PATCH v4 net 07/12] ipv4: use RCU protection in __ip_rt_update_pmtu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__ip_rt_update_pmtu() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: 2fbc6e89b2f1 ("ipv4: Update exception handling for multipath routes via same device")
Fixes: 1de6b15a434c ("Namespaceify min_pmtu sysctl")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/route.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e959327c0ba8979ce5c7ca8c46ae41068824edc6..753704f75b2c65d79c9c4dc19a329de5cdbd8514 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1008,9 +1008,9 @@ out:	kfree_skb_reason(skb, reason);
 static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 {
 	struct dst_entry *dst = &rt->dst;
-	struct net *net = dev_net(dst->dev);
 	struct fib_result res;
 	bool lock = false;
+	struct net *net;
 	u32 old_mtu;
 
 	if (ip_mtu_locked(dst))
@@ -1020,6 +1020,8 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 	if (old_mtu < mtu)
 		return;
 
+	rcu_read_lock();
+	net = dev_net_rcu(dst->dev);
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
@@ -1027,9 +1029,8 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 
 	if (rt->rt_pmtu == mtu && !lock &&
 	    time_before(jiffies, dst->expires - net->ipv4.ip_rt_mtu_expires / 2))
-		return;
+		goto out;
 
-	rcu_read_lock();
 	if (fib_lookup(net, fl4, &res, 0) == 0) {
 		struct fib_nh_common *nhc;
 
@@ -1043,14 +1044,14 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 				update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
 						      jiffies + net->ipv4.ip_rt_mtu_expires);
 			}
-			rcu_read_unlock();
-			return;
+			goto out;
 		}
 #endif /* CONFIG_IP_ROUTE_MULTIPATH */
 		nhc = FIB_RES_NHC(res);
 		update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
 				      jiffies + net->ipv4.ip_rt_mtu_expires);
 	}
+out:
 	rcu_read_unlock();
 }
 
-- 
2.48.1.362.g079036d154-goog


