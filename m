Return-Path: <netdev+bounces-68130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DC6845E2E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CBB1C27907
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6125916088A;
	Thu,  1 Feb 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f92ZKjCR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B4E160892
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807399; cv=none; b=EQRKOAhkWfdHeo8IL/D8n3SSoI7cdumahouTw74Q3Rg1HkXZMe6v+lAo1WGgM0wOKFNdlZUrrgJs3NdtLeJzxTcFz9SrVpWxZJ0/nACQVrU3ZxOg3CDxRjf0+RzZOExB/C17uZ4ZU6wJiiTHdk1wz6APzUmVgrUVbtWl9B5sCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807399; c=relaxed/simple;
	bh=XTQX//FbLejVAJ/UrzG6/F1227q3/59vUO2Ojo0SXzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W9I/BESdjFPv18ZrT+mrnauq3gujd+ZGwGDmAa5dRwmiYYMJP+aA11CKcyklDLjYQhR4rMQNEztFOZZF33L7GNJWNp2frhGNw4bsWiU/hkTN6sRyTw1qnjzp3wAK3652A8idEp8N8fdLMQVqqBGKjdYX06fX9/uEvufoYubk+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f92ZKjCR; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-785448c774fso100998385a.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807392; x=1707412192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVgCkJckaiYEnFkIIAWazyhBNwd6HMYFKCOo6OjV8E8=;
        b=f92ZKjCRnDbzC2VpOKcfhpsoNDfD+RyawxVfM8JYUuZ3PqWbjyZ44eIChHa4E0kd0j
         rbMPnmNiJZhHmex+ULt1ylIMb/3sHxE9UTZ8JaZ5ETC6p+VMLhglJyqAN46kKaTkE+B3
         3/MC6j2KMEjVtM9LowJsWqUa3AhkX5X05eFsGUp6XwAktvawRA8m1O6UaevWZLUxha2q
         OBPLHpxvJEW/6jztGkBZZLTRdX2isdGqSBb3UbvUtTj2q0WdnM2iFPLUgkbu14KCFYio
         vtZrfBeOW1rINgQeoNVzn0TPzkwqqgxDj4vMoe/S5gf4I4XLmBzimnPUaeNPiFqnALTY
         lpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807392; x=1707412192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVgCkJckaiYEnFkIIAWazyhBNwd6HMYFKCOo6OjV8E8=;
        b=jYws64ohrAPGMeAYwx3LXe58YPdH2wfHNugkchHnx3Owb+j58QcipN1utWFMG2Yn1A
         4PpuBGGbB9phwb8qK7Jrq9TPT93p48nKuzhl9bXR5aFt3qpYxajaM5voUmKL0vJzElk9
         b951LMZbJgka/Kv+Vb2t8q0atq2LoQ1KFNP7tnOSQuj/Js1YcLAvU05Fpnr0ByngPC9S
         2FimcRq39lpiKFHUR2ai9zG3pBkfTLHeOTDe+PLZfRpkhrCQ+9Lo3BVIyHKU06yQjFbN
         DIe/NakygbQqtKL2cTJVWLE5JYmZq6XOkyGUFB2PaR9k0QTPSUxgLqJiSVW5lw5vK1Mh
         F5XA==
X-Gm-Message-State: AOJu0Yx26j8oqJT3mE2qqEpC6UdnkotsLNSFio7Sw0kOYYSVVrG+jr3u
	pKABt6DL+o0ExmEnd/4gQ2OKfj6A3QHconSxMffodiJLpTPAxFdLG47keoXBSANWHVBU7UMIic0
	8EaHgAid/hw==
X-Google-Smtp-Source: AGHT+IElU1Rfwu4xZGlFhcaHJ7mVMUKL/Bpq9V00Q1mF6buH6knzEw80qy4n2YhaKHL7NOXUezjNqlMDciQ6yA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:3c98:b0:785:4378:3a13 with SMTP
 id tp24-20020a05620a3c9800b0078543783a13mr81748qkn.9.1706807392054; Thu, 01
 Feb 2024 09:09:52 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:31 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-11-edumazet@google.com>
Subject: [PATCH net-next 10/16] ip6_gre: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_gre.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 070d87abf7c0284aa23043391aab080534e144a7..428f03e9da45ac323aa357b5a9d299fb7f3d3a5b 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1632,21 +1632,19 @@ static int __net_init ip6gre_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit ip6gre_exit_batch_net(struct list_head *net_list)
+static void __net_exit ip6gre_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list)
-		ip6gre_destroy_tunnels(net, &list);
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		ip6gre_destroy_tunnels(net, dev_to_kill);
 }
 
 static struct pernet_operations ip6gre_net_ops = {
 	.init = ip6gre_init_net,
-	.exit_batch = ip6gre_exit_batch_net,
+	.exit_batch_rtnl = ip6gre_exit_batch_rtnl,
 	.id   = &ip6gre_net_id,
 	.size = sizeof(struct ip6gre_net),
 };
-- 
2.43.0.429.g432eaa2c6b-goog


