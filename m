Return-Path: <netdev+bounces-161796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FAFA241A7
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3991F3A9D35
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9E61F12F8;
	Fri, 31 Jan 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDKMyycY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432C1F0E53
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343628; cv=none; b=L0GaiGQ+T64+MklKTwHeiFH6q2a6F9MZQ8li3kfcKTNggjTAPoAvCC9+E1RkwJfFP/lZ/n+U91pBpJueXEolyOe3T+es5yHeLm/EaHJ+wI5TsrHirzbAN3lqFMwozVSIckndrRx2bBs5M5h0fYOJsnraJMR5N7sJwFtKPmsglJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343628; c=relaxed/simple;
	bh=WrgSmefKZZtGaR9c7VaRDiNUgIQ8CEN8Su1E5uigtaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kiq/qTnu7aDv/F4TpgbJqh2Ta9gOXn5TbUBDDlMq5LP39/gJRtNwFDUQ3en/xnBj89TPxZ5Zsk3NoZQBI6mR7i+pM01lODgB0vmEVCZ4qpmghLDbEdpkwN9xirsApnB9nBiLqsSv11n3rbJxtpiiCtr/g44eIrzeUkafquX54CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDKMyycY; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7bcdb02f43cso223501085a.3
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343626; x=1738948426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2rNmoqFDkK9atKW31Y32Mv1I9ttJUk1eN8TNCRUjqMI=;
        b=vDKMyycYzZXCIYU/GMIGOZ9kwVXYcSt07Nv9MUHuZaWQKVwdJ8jql5vpmGWQcwfPqR
         9FEB4ANLdx0qNmbkU6M8jwQWz0OjrVLPGjnAV0PnAmbvSA7/o64CVjSco3on7IhlAXxZ
         odyPg6vAaQz9nHmAj6HRuF/FjQxy09UXj1dVWmJgTp+OjR2WchCSkLeqUUmIHC9u//bI
         Jaf2m2IjuwENfh2cpAjcRjsu2APOcB/nkwkTmTN6khP+gBxD9OgyugpHXI+CWu1NhTJr
         //uAwhTVeL9XDCgx1J0lB+Q/mjm6FzdSb/oSP3oo2bBwbu8ivAxwfM/bQyjuDrZbX4TY
         TmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343626; x=1738948426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rNmoqFDkK9atKW31Y32Mv1I9ttJUk1eN8TNCRUjqMI=;
        b=HKTdPrACuTaI55LAS+7uXDzb7SYKgwZ4UbsgI8H/H+n00fe7u/TFDtMofo41+ibv9S
         Uz5ytQuRSlh8PjJg1eGFDaSjQMYf/YO96DEYckhJajZeVw0m+C7wGHBjSivSkhkwif6h
         inhWCqmUf4dThCEeJh7Fu87HW3cs4G+DD5NOLr8QPSYvxdjKd/6KSybSSt/pDC/ABRbA
         bNDbGMrmVMprMt1QFLZUxCJgusP3GvCJUlUOdO+sdygGuMIGBjpeuETDsm73ElmNjLqo
         1H1RxVQn6W4lebRaif1eMSTNy2tD+oEj3L2zND9EjOBtlwLKDWYbaQ7ZRNDq1T2nSjy4
         WfGg==
X-Gm-Message-State: AOJu0YxFi+7cjd7saRhpt9PoVaKYV7T5a9iL6x2GrbxFZORhUOitYBJS
	Etjovpgla4GLp7fFd0RVygG2PQ8v7wXxBg2vyqoxHQ4Jc8f6VQ6zYWbITYMGaaBf3Y01fWBrnLM
	StqB2Wy752g==
X-Google-Smtp-Source: AGHT+IGp+Ze2fkOCq70QGW3Y/6olD2pu5D7F0xqENqj1F75+6YtZxoDbnbBpRU2T8di4wjQuQU/37iPEZ9lKMA==
X-Received: from qkpi14.prod.google.com ([2002:a05:620a:27ce:b0:7b6:d089:f8d4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2988:b0:7b6:d1f6:3df with SMTP id af79cd13be357-7bffcce5870mr1952551285a.21.1738343625804;
 Fri, 31 Jan 2025 09:13:45 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:23 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-6-edumazet@google.com>
Subject: [PATCH net 05/16] ipv4: use RCU protection in rt_is_expired()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

rt_is_expired() must use RCU protection to make
sure the net structure it reads does not disappear.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/route.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 74c074f45758be5ae78a87edb31837481cc40278..e959327c0ba8979ce5c7ca8c46ae41068824edc6 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -390,7 +390,13 @@ static inline int ip_rt_proc_init(void)
 
 static inline bool rt_is_expired(const struct rtable *rth)
 {
-	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev));
+	bool res;
+
+	rcu_read_lock();
+	res = rth->rt_genid != rt_genid_ipv4(dev_net_rcu(rth->dst.dev));
+	rcu_read_unlock();
+
+	return res;
 }
 
 void rt_cache_flush(struct net *net)
-- 
2.48.1.362.g079036d154-goog


