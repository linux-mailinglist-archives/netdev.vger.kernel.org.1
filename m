Return-Path: <netdev+bounces-36061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AB57ACDD2
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 04:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id DF1021C20860
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 02:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FFFEA9;
	Mon, 25 Sep 2023 02:05:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18010F8
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 02:05:40 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A87C6;
	Sun, 24 Sep 2023 19:05:38 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59e88a28b98so81466257b3.1;
        Sun, 24 Sep 2023 19:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695607537; x=1696212337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl7WIkiSe4Zaq2jneMkE5sjlyOmEq/BXI+Yuo8w6qpI=;
        b=lRhDeWns/GH3kj1BIlPy/pkN28VoOLBbzXPEV/OR13sj5n7FUPF+XRcra+BtD7iQT3
         WGxS9X4GVfqR5pcjR1UV+1WDviSzIPBC4+gw9ZvQRILUVd3VAPQlGjtOkJCyZHhbhW8H
         vLmke/6hkBRuIxyAd3aL+GcmsU3NR08+fTQ55tFOWXEMjtHJcn2fqk4mHNn2M2oS871l
         WoISSz88Gi+CZV3mnV32gXadNB7yCloDFP/V2wUGeQ/dBlLQs70HHxVjteQrr9Yem9Y7
         LWl4ux4TEKFXKjueFUys5NuSZ3iuHkg8YFPp3Fgm+FN+1bt1nE9R+23Ap4o2idGsDHyu
         Ummw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695607537; x=1696212337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pl7WIkiSe4Zaq2jneMkE5sjlyOmEq/BXI+Yuo8w6qpI=;
        b=XL+fId42YNSDQBnQUBje0Jh0lCMlyeOn01ZjDKqNoFTlnrDfSGSLTcImxv4b7nV+ms
         Ik/NsrfV0fcdq/EWrmOSDAsQu+LA3qD/51nYit7FaDV6hhziflBAtbwqMG2487LLBImz
         alx0Fq6aQMPPZquFZBbv1/YjdcEOQrBQ05sivBQvKJxQpHitfcOm72gfVYZexnQEhX+B
         qo9sKf5xNxbPdA4SGctLlZeA0rltJW9JtGBISI1iO9aJeUPE9NxM8J9xOM9MERW1yLz5
         AudvzZO46m5ttusnfsBHBjo23TEx5PBLv+r/tynWBA7U7pUm180+mb8qsI54Euqao7wG
         HtWQ==
X-Gm-Message-State: AOJu0YzeDQKSfXg5DckaglxGpEC84LYtSex3AV9lDOLkUKdyt39RqcDs
	bt/0tILMnxIkMhkRR0PzwE9tizkriDM=
X-Google-Smtp-Source: AGHT+IHZUE2RLaOIC8oHQElyrgZslaVjBNUUZZYSjLlbplvxcmxc9RmbkTE7mdselw6XFPW1qFeQqQ==
X-Received: by 2002:a81:988b:0:b0:59f:6212:e174 with SMTP id p133-20020a81988b000000b0059f6212e174mr2053672ywg.12.1695607537192;
        Sun, 24 Sep 2023 19:05:37 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id n185-20020a8172c2000000b0059c01bcc363sm2179591ywc.49.2023.09.24.19.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:05:36 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Tariq Toukan <ttoukan.linux@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 2/4] Revert "sched/topology: Introduce for_each_numa_hop_mask()"
Date: Sun, 24 Sep 2023 19:05:26 -0700
Message-Id: <20230925020528.777578-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925020528.777578-1-yury.norov@gmail.com>
References: <20230925020528.777578-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that the only user of for_each_numa_hop_mask() is switched to using
cpumask_local_spread(), for_each_numa_hop_mask() is a dead code. Thus,
revert commit 06ac01721f7d ("sched/topology: Introduce
for_each_numa_hop_mask()").

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/topology.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index fea32377f7c7..344c2362755a 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -261,22 +261,4 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
 }
 #endif	/* CONFIG_NUMA */
 
-/**
- * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
- *                          from a given node.
- * @mask: the iteration variable.
- * @node: the NUMA node to start the search from.
- *
- * Requires rcu_lock to be held.
- *
- * Yields cpu_online_mask for @node == NUMA_NO_NODE.
- */
-#define for_each_numa_hop_mask(mask, node)				       \
-	for (unsigned int __hops = 0;					       \
-	     mask = (node != NUMA_NO_NODE || __hops) ?			       \
-		     sched_numa_hop_mask(node, __hops) :		       \
-		     cpu_online_mask,					       \
-	     !IS_ERR_OR_NULL(mask);					       \
-	     __hops++)
-
 #endif /* _LINUX_TOPOLOGY_H */
-- 
2.39.2


