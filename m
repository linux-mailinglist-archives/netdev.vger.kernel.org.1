Return-Path: <netdev+bounces-14725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3916B7435A7
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 09:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61C2280FBC
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 07:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60068489;
	Fri, 30 Jun 2023 07:18:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66EA20F1
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 07:18:45 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A6E19B1
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 00:18:44 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55acbe0c7e4so141744a12.0
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 00:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688109524; x=1690701524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OV/Y5xqm+7PwvGeib3ieImmzTjfAZSgJTchMupF5Dyw=;
        b=NjLXhOBYJiLrac1g5cB8ma3o3e4N0OONpcYpK8m2pOAvYQ/Bz3DWSMzCpVRURU4O0D
         W2eyBHv6eeKfm4H/JLTtAaMaffmZ6lpzUG1MhMbw8m7IfeQWNxjLUv4nUxmA13uWIpiU
         UXjlwz/rrbK84ZLXfvSJyxFXBxQwrTMcLWcE39jMGyURywPYkoZNJVf3WtNFd5DdFe4a
         yDeD7Bo/x+gM0h04IUwOz47AqO6rm3zWOtaP9rnBj8OsLOImDY3XWeUkgyRJr6PxXuq9
         v6+S+GwVEfs9kJFO+3o7mXvMcUmRESifAK9/HS3fSikoCUaiMrnmrNTvsFfglOtbamhT
         Mn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688109524; x=1690701524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OV/Y5xqm+7PwvGeib3ieImmzTjfAZSgJTchMupF5Dyw=;
        b=D/xsxBV1kNHhvHXV4vGcPLq0TN6+E/nV9BK6J1/8WndJdsnu8wcef/rfW87sbkQ59X
         fjpNju99t1oV+trPphsXTnNqjcCA4LupHO3zIc8sZD1ws+rMGiPAbtdbW8u+lpQsjfnk
         8eWyNMRSFR65mzWj756XBO9veMO6PWLfEWEd+EPflz90CeY9QL3onzPlMODemZm9US1g
         843GUfCXSXuvWI3LzjErN4wFgwc1iKmzFO8VY9c1tnhWekat7V7h1PL8liU2WFcFn5tl
         YmCtgtimWd8gCEnb7A/dOJKoSC70tqjvkxFiZvg27BmEumnz4q167wJlk8188ao6ZMLC
         hoAg==
X-Gm-Message-State: ABy/qLZwQr5LuWJqRdT2FfQcIgceE4O5Gt3cdRSH5ZDKq9hIfmUNrTa/
	xt3cEXqr0oKAzjcaKpNYEps=
X-Google-Smtp-Source: APBJJlGvhQB3wy5b2U1MXNi8Rn6jU9QNLZ8mu1H+IySHqik/VvL/yDmRjOSQX63nKpNyouDtZX091g==
X-Received: by 2002:a17:903:13c4:b0:1b3:d8ac:8db3 with SMTP id kd4-20020a17090313c400b001b3d8ac8db3mr1444806plb.6.1688109523671;
        Fri, 30 Jun 2023 00:18:43 -0700 (PDT)
Received: from mi.mioffice.cn ([43.224.245.253])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001b7fd4de08bsm8362473pld.129.2023.06.30.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 00:18:42 -0700 (PDT)
From: Jian Wen <wenjianhn@gmail.com>
X-Google-Original-From: Jian Wen <wenjian1@xiaomi.com>
To: edumazet@google.com,
	davem@davemloft.net
Cc: Jian Wen <wenjian1@xiaomi.com>,
	netdev@vger.kernel.org,
	wenjianhn@gmail.com
Subject: [PATCH net-next] tcp: add a scheduling point in established_get_first()
Date: Fri, 30 Jun 2023 15:18:27 +0800
Message-Id: <20230630071827.2078604-1-wenjian1@xiaomi.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kubernetes[1] is going to stick with /proc/net/tcp for a while.

This commit reduces the scheduling latency introduced by established_get_first(),
similar to commit acffb584cda7 ("net: diag: add a scheduling point in inet_diag_dump_icsk()").

In our environment, the scheduling latency affects:
1. the performance of latency-sensitive services like Redis
2. the delay of synchronize_net() that is called with RTNL is locked
   12 times when Dockerd is deleting a container

[1] https://github.com/google/cadvisor/blob/v0.47.2/container/libcontainer/handler.go#L130

Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
---
 net/ipv4/tcp_ipv4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fd365de4d5ff..3271848e9c9a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -57,6 +57,7 @@
 #include <linux/init.h>
 #include <linux/times.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 
 #include <net/net_namespace.h>
 #include <net/icmp.h>
@@ -2456,6 +2457,7 @@ static void *established_get_first(struct seq_file *seq)
 				return sk;
 		}
 		spin_unlock_bh(lock);
+		cond_resched();
 	}
 
 	return NULL;
-- 
2.25.1


