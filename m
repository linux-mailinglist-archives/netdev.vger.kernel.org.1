Return-Path: <netdev+bounces-41336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A47CA956
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E181F28130C
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527F27EEC;
	Mon, 16 Oct 2023 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dstMeNX/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9F26E16
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:28:56 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9914ED
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:28:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5c91bec75so28502355ad.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697462934; x=1698067734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5edFP5IbqRycra4JwAwr7sw7tdQ8rYxAUGEg4gbH5I=;
        b=dstMeNX/S/U6Zd5Z5IPb0P7sTdufE7lqsNm4s0QGvorWjKRX+UM52EXsnpN2UGO/b3
         LlSHHASLlXtv8pxbvajKcPypiKB6305coJDK69Ijde8n4H8TpM+Dx5SY7J3MHCWtZeeP
         40y4+KDWwCQ/+5TMdHkGjAc6BBWjKnKT7MnGU9GLBvLtFjJP453yt8iNF9VgJiJGdTUR
         IrLc1ACoH8gvqsUID+DU9u1ZY73dUmSwPA+qf1mThnFJTdRwI68wn/7hUJiBaGpEOLQm
         wuBqSYziHI6U/cn6sXobsz/ktXu29X8MviMMhN2VzDflqFmLF+0M6d4NgFPdl52R6dw+
         i3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697462934; x=1698067734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5edFP5IbqRycra4JwAwr7sw7tdQ8rYxAUGEg4gbH5I=;
        b=vd4l0j01bn+fwW8wksAlKkl9u4Ev4vIVxSY8eyr8vCZsakLclavQy1ANnwh72HEJPx
         9lPnHM2jt/OlZSyd9pWfM1d8xz7azBPlAbP3m1pVjVKx70CvBdh5qlX44rHOk0bWYWPZ
         UrRUBbSgEs52LK6eUyh0ELW0tAmE09VqAZN2jaLcfVZKBTegM5i9q9dK1fH6Zju4r4/k
         hRHTU+ydkwc0Kv0Be3OROzf/zc+oJVUk8b99FRguBEkWRWsqaZMIigcpGhABlNeRkTC4
         Bs0Dxq48u/4c/I5QslGxeqXDZ+Wpi2EjWmztTZpNr895rMFWxmlItehG2MktjoKyktcn
         kWAA==
X-Gm-Message-State: AOJu0YzSuGcvsfSX/PbOxt0TNZZPNuJNGywpL+vUPj/grDL80I7jFjk7
	0mqQ1KnTBh8s1YTaIHo0Owb0hA==
X-Google-Smtp-Source: AGHT+IH0QjFU/M3nL9sQ7GpGqT0tk+CeTm1zv1UcyqYWSvsDzutF7dTumssneT1g+Jcbaao72hKBCQ==
X-Received: by 2002:a17:902:c94f:b0:1c3:8464:cabd with SMTP id i15-20020a170902c94f00b001c38464cabdmr36959730pla.12.1697462934153;
        Mon, 16 Oct 2023 06:28:54 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001c737950e4dsm8476287plk.2.2023.10.16.06.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:28:53 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shakeel Butt <shakeelb@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net-next v2 3/3] sock: Fix improper heuristic on raising memory
Date: Mon, 16 Oct 2023 21:28:12 +0800
Message-Id: <20231016132812.63703-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231016132812.63703-1-wuyun.abel@bytedance.com>
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Before sockets became aware of net-memcg's memory pressure since
commit e1aab161e013 ("socket: initial cgroup code."), the memory
usage would be granted to raise if below average even when under
protocol's pressure. This provides fairness among the sockets of
same protocol.

That commit changes this because the heuristic will also be
effective when only memcg is under pressure which makes no sense.
Fix this by reverting to the behavior before that commit.

After this fix, __sk_mem_raise_allocated() no longer considers
memcg's pressure. As memcgs are isolated from each other w.r.t.
memory accounting, consuming one's budget won't affect others.
So except the places where buffer sizes are needed to be tuned,
allow workloads to use the memory they are provisioned.

Fixes: e1aab161e013 ("socket: initial cgroup code.")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
v2:
  - Ignore memcg pressure when raising memory allocated.
---
 net/core/sock.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9f969e3c2ddf..1d28e3e87970 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3035,7 +3035,13 @@ EXPORT_SYMBOL(sk_wait_data);
  *	@amt: pages to allocate
  *	@kind: allocation type
  *
- *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc
+ *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc.
+ *
+ *	Unlike the globally shared limits among the sockets under same protocol,
+ *	consuming the budget of a memcg won't have direct effect on other ones.
+ *	So be optimistic about memcg's tolerance, and leave the callers to decide
+ *	whether or not to raise allocated through sk_under_memory_pressure() or
+ *	its variants.
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
@@ -3093,7 +3099,11 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (sk_has_memory_pressure(sk)) {
 		u64 alloc;
 
-		if (!sk_under_memory_pressure(sk))
+		/* The following 'average' heuristic is within the
+		 * scope of global accounting, so it only makes
+		 * sense for global memory pressure.
+		 */
+		if (!sk_under_global_memory_pressure(sk))
 			return 1;
 
 		/* Try to be fair among all the sockets under global
-- 
2.37.3


