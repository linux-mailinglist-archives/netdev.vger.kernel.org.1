Return-Path: <netdev+bounces-16838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797CF74EF2F
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 14:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99191C20E0E
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D25182B1;
	Tue, 11 Jul 2023 12:42:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55195168AA
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 12:42:23 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9020EB0
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 05:42:21 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3733838b3a.3
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689079341; x=1691671341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmg9w9P3JYlTE5YF/tdSGmQe9gMk9DKIlFnuajmtraM=;
        b=MQ5ty+Ms9xq2Gf8tT1u5KINp7LbCz3vSzcp6PPkar1PjXy2UOGDAONbcJWbI+E3Z1E
         ikZ8U8ait2Sr5BYSdZ0mnqv3UujdxGaHwIDateSlAtRLzEgup9mGA8YcL/qo1k0FBGy/
         FtozdxhzC6z10cVS8YU1HM4+O48pgEHDp5kJRIJNhHnzy5o1QbbQV3vpzByt9eoJCZRF
         j8KrPcF99ChxD4ntqNGXPWk8MUCnNrtMqO4RYfasM8ZE8cbOScyeoYS5plADx8+31TVK
         GOG7vI2PVHSpTcdBFa0p7rhtBHE39/Z0gT8Ap6MdmyXF7tQb0/Zbshyqv+rLDj6qHTCL
         oBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689079341; x=1691671341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmg9w9P3JYlTE5YF/tdSGmQe9gMk9DKIlFnuajmtraM=;
        b=Jlf9WE1j3b34Bsh8SD745CqhHosGYsQkyGrbARMNyGrLag+21V0EcldvKvGPx0cafR
         qcWWcHC5k7W/s7JLXuqYio4Er5Imv/q26OhodYUPN+QXR4uBH120wDvF9JAsXViRBcpK
         ZIH+/uHdxd4arz7glTPY0JELT6dSv7+KqgrL5I/E/DgCAjZEBNPHfuofTkqvk4SKDhK5
         FXlusloITsHtEssOOsqSIQ6G9UjDbXNc802bGwR7+Zs2pkO3ZEXed7lZR3d2oYCjO29c
         XGlCtVQSM0quBUU/LQdouBxGEt/kv7hrvTW+i7lhjuS3V9Iqfv9qtVRRG2WqYn7hqssx
         K14Q==
X-Gm-Message-State: ABy/qLbbG4CdONf3tKGpPD2K+4sem6HsXfd5mDMaqOnk2mkx3Vn5v7Ok
	ik7FwmMIUK7woTr0n9KCledMuQ==
X-Google-Smtp-Source: APBJJlHySXBwiacKDORZhjNJUBjRrtdwMto4+SpJ1LfQJNYde55u+zkHIULuNxcqHK6dl79az4tI4A==
X-Received: by 2002:a05:6a20:3948:b0:127:8833:cce3 with SMTP id r8-20020a056a20394800b001278833cce3mr15034530pzg.8.1689079341001;
        Tue, 11 Jul 2023 05:42:21 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d27-20020a63735b000000b0055c0508780asm1512222pgn.73.2023.07.11.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:42:20 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Ahern <dsahern@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yu Zhao <yuzhao@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Breno Leitao <leitao@debian.org>,
	David Howells <dhowells@redhat.com>,
	Jason Xing <kernelxing@tencent.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG))
Subject: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators of sockmem pressure
Date: Tue, 11 Jul 2023 20:41:43 +0800
Message-Id: <20230711124157.97169-1-wuyun.abel@bytedance.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now there are two indicators of socket memory pressure sit inside
struct mem_cgroup, socket_pressure and tcpmem_pressure.

When in legacy mode aka. cgroupv1, the socket memory is charged
into a separate counter memcg->tcpmem rather than ->memory, so
the reclaim pressure of the memcg has nothing to do with socket's
pressure at all. While for default mode, the ->tcpmem is simply
not used.

So {socket,tcpmem}_pressure are only used in default/legacy mode
respectively. This patch fixes the pieces of code that make mixed
use of both.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/vmpressure.c            | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..5860c7f316b9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1727,8 +1727,8 @@ void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_pressure)
-		return true;
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return !!memcg->tcpmem_pressure;
 	do {
 		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
 			return true;
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index b52644771cc4..22c6689d9302 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -244,6 +244,14 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 	if (mem_cgroup_disabled())
 		return;
 
+	/*
+	 * The in-kernel users only care about the reclaim efficiency
+	 * for this @memcg rather than the whole subtree, and there
+	 * isn't and won't be any in-kernel user in a legacy cgroup.
+	 */
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !tree)
+		return;
+
 	vmpr = memcg_to_vmpressure(memcg);
 
 	/*
-- 
2.37.3


