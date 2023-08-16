Return-Path: <netdev+bounces-27985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A0E77DD02
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7B2281853
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A7D539;
	Wed, 16 Aug 2023 09:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9233AD307
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:12:51 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692351FC1
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:12:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc6535027aso53239515ad.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692177169; x=1692781969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+F832O1MonV9zoGUjcIJejeSoQ3hJAaI+0iai7pqbdQ=;
        b=aEecXckP7vra0nLZVh5J+v5iJFeL/deIsacfTqmIgWMZS6GxfQjrtgRD8ZGxvNfCNC
         6DDeY2goYhxglbyQ5f8RsbzcqNM7LhY+Rr8ylnQ+2n/biG2KA/ifYVWuPYmKoAn3KRWi
         1S67/08oO069TudRASY8IVn9wcaphqGkR5Zl+fVKQV+nm2tzW7SAadL5B9qdZnpTTNgL
         zla6SQLwoq1VHY5KzIzRgqlvHfMZac4/gmEqMgSeBWnpzRnqVZChf59cJT9yWXIqVaiH
         1JGaGL4dtVH5a4dvl8++or/vRWjYpP/DESEYTC4q93GQyL1273HnCKbJ1nmJRFXtekSA
         lSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692177169; x=1692781969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+F832O1MonV9zoGUjcIJejeSoQ3hJAaI+0iai7pqbdQ=;
        b=cOrroRsSboy7vvvRsqnHccUcaW7d0Dx1bhD4R6bWH3HwNQe3YFo1cDHudQmg7oH0Pm
         /oQvVgQl08coiqGfW8DEYB1CAIJQdidwhcUvkQnU/qAW81vQq4a5XXrK/UY+BzEjMhXo
         qv3o73u9lI42CWZ1HxpdW2oDoHrq97SCbOoC38zLH3irmDGdYDi26aepYlzlrf/l3l9i
         wO9NhSvsW6aB0FMMbAaxEF6l/jlDeae/REelutDmThEDo2wMaji8hIdkYSEd2frH5wJz
         nwYNrCwEmcd6LUqJm45xlPwzeEq3Eid8/pjGPLvN1XSEYD7NqHLcP3R3NaXChtKwO+9j
         coHA==
X-Gm-Message-State: AOJu0YybXd89MawWNz5C8FeCsZRY4Rwbkfg+EJcjIkBO9sE581+qNryK
	Ka6SXpFwbiqiP5jbCHPOkzPecg==
X-Google-Smtp-Source: AGHT+IEL7B3gvo5NUfmmMlhYVZKdjtMYjohsMWpe+dAqaLbYkRSrdkxGQXA7IZtLQaHOjdUeOW4orQ==
X-Received: by 2002:a17:902:da8b:b0:1b5:64a4:be8b with SMTP id j11-20020a170902da8b00b001b564a4be8bmr1633362plx.35.1692177168892;
        Wed, 16 Aug 2023 02:12:48 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id g14-20020a170902868e00b001bc2831e1a9sm12574066plo.90.2023.08.16.02.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 02:12:48 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Shakeel Butt <shakeelb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>,
	Jason Xing <kernelxing@tencent.com>,
	Glauber Costa <glommer@parallels.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtsu.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] sock: Fix misuse of sk_under_memory_pressure()
Date: Wed, 16 Aug 2023 17:12:22 +0800
Message-Id: <20230816091226.1542-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The status of global socket memory pressure is updated when:

  a) __sk_mem_raise_allocated():

	enter: sk_memory_allocated(sk) >  sysctl_mem[1]
	leave: sk_memory_allocated(sk) <= sysctl_mem[0]

  b) __sk_mem_reduce_allocated():

	leave: sk_under_memory_pressure(sk) &&
		sk_memory_allocated(sk) < sysctl_mem[0]

So the conditions of leaving global pressure are inconstant, which
may lead to the situation that one pressured net-memcg prevents the
global pressure from being cleared when there is indeed no global
pressure, thus the global constrains are still in effect unexpectedly
on the other sockets.

This patch fixes this by ignoring the net-memcg's pressure when
deciding whether should leave global memory pressure.

Fixes: e1aab161e013 ("socket: initial cgroup code.")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/net/sock.h | 6 ++++++
 net/core/sock.c    | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 2eb916d1ff64..e3d987b2ef12 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1420,6 +1420,12 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 	return sk->sk_prot->memory_pressure != NULL;
 }
 
+static inline bool sk_under_global_memory_pressure(const struct sock *sk)
+{
+	return sk->sk_prot->memory_pressure &&
+		!!*sk->sk_prot->memory_pressure;
+}
+
 static inline bool sk_under_memory_pressure(const struct sock *sk)
 {
 	if (!sk->sk_prot->memory_pressure)
diff --git a/net/core/sock.c b/net/core/sock.c
index 732fc37a4771..c9cffb7acbea 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3159,7 +3159,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
 
-	if (sk_under_memory_pressure(sk) &&
+	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
 }
-- 
2.37.3


