Return-Path: <netdev+bounces-13819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6273D178
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 16:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DC2280F0F
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144E563C2;
	Sun, 25 Jun 2023 14:29:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081CB63BD
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 14:29:20 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2D9D3
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 07:29:19 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b74b37fbe0so73340a34.1
        for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687703359; x=1690295359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGKSvilmZgPJXmejRM2lBTN0K9/2tgMZGylX16m+j6g=;
        b=eG2+tYqWkPkRCKS2RqWlEWAPeVeLRLXmJgJx4B9MSOk2J+FsmkJeEiMFUA6KvpbbCr
         89LyphI33da0F/giPdABa5kExZR8OYAsgy2vh6TTPohdM7/mDDY59lwOBYhzfAZGp30D
         05pvyoXfP1v6weRD8GBJFn77jPCHxgvEBe4tRKrmVB99zADfpEQj9rgiQSB4nWZARxBJ
         iugI3imnns3+ApJ9CMskLtS5DWhnJubAU58LcP/z9QP9bpnq/Uer7js5m5TVx2r4pZLD
         9dBPFp5TTAK7U6Hbyi7hFev30VCCcg47CUJ0RupDMTD90mAWngVaaxqxkRgiGVjgjUqd
         gIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687703359; x=1690295359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGKSvilmZgPJXmejRM2lBTN0K9/2tgMZGylX16m+j6g=;
        b=dEXMk5hPwErRhqEmZFolPTo4qP31t3UKSLJE3Zkt1uwWH8Su9qNUBgaaX2tEwB4eAu
         cgRyGj0v3+Ihm90cZpg4cszRPLbDnjWI39PSM5hqvYOBOdb1czEcSkWQ9yx4j+h2zAYR
         LejyIla4Hn+AVVF2rXNYAx4G3W4nwbIdQ+nonIE9sXOGkfnaF3TilgmhjBataAumwtgA
         sgHARPAnmfiAfp2rAvBC7MkDyBIkmmC3deEA4/ESs+cmAU3UBe0WlU21lxFKXCMh81G0
         1+Y7d5fLPezzmMGXH3LuUNmE2DsAzGZmHuYwuk6PnpyTZjLFUPOwEaV4blUNFIKeGCQJ
         +m7g==
X-Gm-Message-State: AC+VfDxYO05BM4MC8daKNTmARS1WXb5REBIAgVuhYN5f0Icyau9Pdvbo
	goW00YjSndzCd1G2u6c12yiGFg==
X-Google-Smtp-Source: ACHHUZ5ORDdc7sTEUz6Kzs7YToDfn6ptrUe/hYZt5RefjV2u7D3+JoGbfaDk2v3JXbuijopR6K45tQ==
X-Received: by 2002:a05:6808:3098:b0:398:55ff:1fb8 with SMTP id bl24-20020a056808309800b0039855ff1fb8mr33372212oib.37.1687703358696;
        Sun, 25 Jun 2023 07:29:18 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0025ef39c0f87sm2980744pjh.0.2023.06.25.07.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 07:29:18 -0700 (PDT)
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
	Abel Wu <wuyun.abel@bytedance.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Breno Leitao <leitao@debian.org>,
	David Howells <dhowells@redhat.com>,
	Jason Xing <kernelxing@tencent.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG))
Subject: [PATCH net-next 1/2] net-memcg: Scopify the indicators of sockmem pressure
Date: Sun, 25 Jun 2023 22:28:10 +0800
Message-Id: <20230625142820.47185-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
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
index 222d7370134c..9b1b536b4ec9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1743,8 +1743,8 @@ void mem_cgroup_sk_alloc(struct sock *sk);
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


