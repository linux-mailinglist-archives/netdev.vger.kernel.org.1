Return-Path: <netdev+bounces-70176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BD684DF86
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDA82893D3
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98F6EB4D;
	Thu,  8 Feb 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjeVER1b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2F86DD07
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391011; cv=none; b=Vhydavp3zfXhk37tzDfyF5Rlrtd6NOxjpkuCNB6eBYxOuDFBTXrI1WQzdJQddN370xR1VioZL4OJdKEkyOZOSMTse/2H2dAeXtxUYKvZX/89PGmz28o1uWcepSYepRUVizq0bcNLjFMnVatQd0NsQRM6TMvRsUpPCMCEsHZOjWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391011; c=relaxed/simple;
	bh=r8ZYW3Rs3MiAzsJ4L/3/9ecJJDEkvN8B1tc/IdQ9uz0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d+QS8Adn5nCWbKNLEMPUrbMw95QUey9E1D8ailwwWvnX69aB7nSSHSITTvRRrCS7iYVhLc/9fljLLJqTisQg4op1r2t4g1GbsTwsrh5ouwr1LGqiQx91k/Cqb+lkuj1DytXZFFTHwPWGfMRuMsaE76Yjn4+08BlkEZXyxY8V1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjeVER1b; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso1024155276.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 03:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707391009; x=1707995809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc5YgK7GXN8DRY5LrBnuYTzTOxzNC1mLjrSzYg9HA/U=;
        b=tjeVER1bWzuWxbCdE3lSYQTJ/oU5dlaxVKGAs42rH/y88fsAcZqmxx4JMx8ofH3qzj
         vAg1xRnU1CYLGAbBL/L33ZbBDWdxgU50Jnkl4etrsnRXCghAVrjTn2wnJnWMAzh9tjZA
         THy1oQ3/bI/AqC/z0wOLFcBxR9aVgbHUuYmLmig/4t1/F9JvtcMUB3vBmkVvj1HIAtNP
         cMoceXhy9jY3C3jhxD+LyLm99hC4lNqt/xmq9npMeiI7FsY7vPMrZdbeIYxunn3yZg+f
         SRBUHT5ghBp0x6fhzdmCOMZUqrzMeaecHWtAeZaLlD2N+jkCd5NFoJ6q7Mx2rGH7+t/G
         PubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707391009; x=1707995809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc5YgK7GXN8DRY5LrBnuYTzTOxzNC1mLjrSzYg9HA/U=;
        b=ZtD/0y3AqjxbrsCfdARvyAzommwdRyjyctUzRqWDKKd3/D7MC/VOmALaK4Mgta9XIg
         1ctGNje5UT5WxYYz3cGEHCL7RU0Sp/eqO3HlXCBGtaALQ0+O6rB9q1my6aK39Ta780f8
         RAa9iFk+lhYPKnHO1shRJ7eM1EBOhAsKuX8etOf795w4WIE+YetfuJ6mz1JNFqg3eiNn
         rE4pYCF9R/Fd5d5RSvumo2MESkZRSwscnTwrYRt0RVhdc1p/g1C4hIZMPBoW7kE5LNM1
         6RdLcxL6b1My7QP3LirxuDesonbgzCYFdpzjBAgIK8iNYX09R9+QfNBMLQMeJCm3YXW2
         QInw==
X-Gm-Message-State: AOJu0YySaz2nQHubCEr6j8yFjI8RqTzeT8Qm16CQVbX18jlC0dpZZjUr
	918FgLMMNSHad6SknwZ7qOZJ6qepJJ4rBYhRn4il/yfo5o+j2wCkZ5uFFX301QMGSw7b4ogAY8R
	oZ6/Rx/KZNQ==
X-Google-Smtp-Source: AGHT+IGn0b4TXQJdGWFjuP/ppyu7OHaeoONOto2BaKy4YN0HPUfSM3EgcuaMQDkqvM5TjG1SknqZmT41iBBztg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100b:b0:dc6:e884:2342 with SMTP
 id w11-20020a056902100b00b00dc6e8842342mr608611ybt.5.1707391009174; Thu, 08
 Feb 2024 03:16:49 -0800 (PST)
Date: Thu,  8 Feb 2024 11:16:43 +0000
In-Reply-To: <20240208111646.535705-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208111646.535705-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208111646.535705-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] ip6mr: use exit_batch_rtnl method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using exit_batch_rtnl method instead of exit_batch avoids
one rtnl_lock()/rtnl_unlock() pair in netns dismantle.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6mr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 9782c180fee646ab0fad7f0f911254b4b3a592c4..ed2cf29bc9d1bcddbf325860769138ce970f7f18 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1353,20 +1353,19 @@ static void __net_exit ip6mr_net_exit(struct net *net)
 	ip6mr_notifier_exit(net);
 }
 
-static void __net_exit ip6mr_net_exit_batch(struct list_head *net_list)
+static void __net_exit ip6mr_net_exit_batch_rtnl(struct list_head *net_list,
+						 struct list_head *dev_to_kill)
 {
 	struct net *net;
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list)
 		ip6mr_rules_exit(net);
-	rtnl_unlock();
 }
 
 static struct pernet_operations ip6mr_net_ops = {
 	.init = ip6mr_net_init,
 	.exit = ip6mr_net_exit,
-	.exit_batch = ip6mr_net_exit_batch,
+	.exit_batch_rtnl = ip6mr_net_exit_batch_rtnl,
 };
 
 int __init ip6_mr_init(void)
-- 
2.43.0.594.gd9cf4e227d-goog


