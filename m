Return-Path: <netdev+bounces-163091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DECFA29546
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A5D1885230
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326921A8F63;
	Wed,  5 Feb 2025 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fx0TAyZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66219F121
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770691; cv=none; b=Q+iBdWNQTSa47wmu8bAiQBfgdpdRNzfusF291g9g4JVW2ymk96D0fUPhbRtTaTupzVyUdSEXgjUERPmrjrKDnVodk0foCwOZigXC1847h80iSfIWwoGcyg8OucsbO+JSuATDI6DA7ndRJhdGlVnoBNsIQKXj6VAibl/w9I7efTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770691; c=relaxed/simple;
	bh=wBUlXxqCOHC5mb4l82j/huFvC/81SsSroryG3eWs92Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BKDHsqNRX39swuQ7xEjMFqRxwKIXiKMO7m0+5R//OsSYHoA5wtPIscvt7Rkq8L2dU+Vcp9znk8Yg6v0/e0eVC25gdECcg1ASbFxw67bt9Nze3kayC++oChfdpxlXNJuyE7Y6onPVJPdtFs1VYicscyoxfD5KpMIUU4yxDRtwznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fx0TAyZg; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e43050c8d0so20876766d6.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770688; x=1739375488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0DPhFcYIwCjlPd5Kix9DbDaw6MNxiwJUB+YXQT63GU=;
        b=Fx0TAyZgbmv3bbyLnREjHYCV21mOd2YUsKf47XyHCXW3BVNoLQfkmiKcLru0DYX04X
         TvJyeqc6FGQmRKfG0/HIfqIEU9jqiGf69401zhSG38G25jMAqvhDzT22OzbEi3GyYMwu
         9nGlMy+9OK6IxTnjA7HPsDgYWGcsFflou1H3IiWiZQ6YcTL6dC6qTa/RG9js3YhxpaPB
         5aO4msnJ0KW4gcSyh5078m8C/mvTRJPfKAIECS6EpYaO6V2MdwCwB91PrLSp773/1ORR
         tg88jixM+Atmj3aYzcMiiNGsQ9C5NogwV55b+iMVfUESsghHZLyCsFWn9YpNySkGXrFr
         VqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770688; x=1739375488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0DPhFcYIwCjlPd5Kix9DbDaw6MNxiwJUB+YXQT63GU=;
        b=ek8p91bIQzywp6ziEPj0pGP5/N/JKQlakV6XdDw2XuWI//q0x0bYsms/eqGWSUIzNt
         vyU+42CzZZfj9MbUV7QM553F/+OQrDZZLJnjKOXCQQ8Qw9lZ5oHBwe06Fv9xcAeBe9de
         58PKJnYgqmQNjuReFvfErWe8RdlFSQlYpBXnCuHmRLK57zpkSFIBNoRYQ/nrpe7KgQom
         M0XNoy8mb3WSixKohmTSY3b2z9ZF/vNtGhCffpi5qPmO6kTAluppyMN33fqOw4tM0eeo
         z93YMSg+22+wBe6fYF7uvikoDn9DHBHDv1T0PoVHbLRp2KIzCCiN3YdSM1SrRNuLr6/S
         wrjg==
X-Gm-Message-State: AOJu0Yw+3FDyRTZkJBvmgeVFP+Z2M3BzsAIt6Res3AUTOOygLt9IMKFH
	/m6nQgXBw2paPWzWLe4Xxi7hMW5NwqO07ggp0PL5kWUqIp2n1Jq8JxlfMkuEoKjYpkp156vcgkz
	5Bb6rY1PqxA==
X-Google-Smtp-Source: AGHT+IE0+sLvaMrnxAg8/P8TmgBBh7jPDtZrtr0M41PhkgTXsLXjVDzxLnGlQE/xc2G0TNQgg1Ck2aomCZx5LQ==
X-Received: from qvbnw3.prod.google.com ([2002:a05:6214:3a03:b0:6dd:d16:e8ab])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5085:b0:6dd:d317:e0aa with SMTP id 6a1803df08f44-6e42fb0aa0fmr44982636d6.8.1738770688459;
 Wed, 05 Feb 2025 07:51:28 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:13 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-6-edumazet@google.com>
Subject: [PATCH v4 net 05/12] ipv4: use RCU protection in rt_is_expired()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

rt_is_expired() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: e84f84f27647 ("netns: place rt_genid into struct net")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


