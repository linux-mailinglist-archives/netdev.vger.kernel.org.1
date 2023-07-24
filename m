Return-Path: <netdev+bounces-20317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA80975F0C2
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C111C20AC0
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0874D8C03;
	Mon, 24 Jul 2023 09:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83F9470
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:50:24 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178784C24
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:50:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b7dfb95761so5878505ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192158; x=1690796958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVIFplaZ76DyAQXZ2ZJxr5973JfmLiF6XogxT7JwM8U=;
        b=g/oklpIKNGh+0wS+n9EMTX7klc8jS620o9fzwPGIqpCBu8mbiUf3GVaJFWI9cq4kyt
         IcHzy4DXpXrqHW9rKUwTo/qnz3ci8+g869gbq1SHjojy2v6sITGFJ6jCBwntHLmpVCFL
         BxlLRGgDhGT5pteYElzIqAQYNjUlDrhrzHvMMVeuk6mD5iB/3/39xp+zm1XNO6yWMu+0
         nnfy+u33I9S+Zpuf8vfrp2IBvebCHcozlkxEMdcu6inA/NJIaH4grbbwn36wCiHGJxl9
         XjhaC2ZZMe6xC4wfMSYebjh3I/a6dIvPCN3tI9BZtHhq23lIbjcutVI19WQEcGj42Ona
         01KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192158; x=1690796958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVIFplaZ76DyAQXZ2ZJxr5973JfmLiF6XogxT7JwM8U=;
        b=egwnSfsWMRrhvBIXLe/kheyg+H6CxbWXnUWHorHVVcqQAwR91dYnqDShEOMeKQY072
         Q5qB3om3NVXaQ1C2MGDUP0mTKyTVtJeZbwGUYpsZr9a1wY/81S7JiWuYG2rVxz3eUcvP
         XIyVu1tf/6MO9VCWctZINjgCr8Nsel/6eR+8bsaI8d7UBjV3CSIR9ORb4kBu4KVUTBAU
         4k5rXtOKGFTxooiEe/4Yh0aDnCup6puQs03rhd5D2HiHXzG5iwqFOXb+BXLdqNQ4ZNAn
         p/g5T+InHgq37OuXNDLQuZlulH/oVSx6mcXvFHQxaYI2Qk9edqw6frZOYBHLjUpB0J8o
         iLYg==
X-Gm-Message-State: ABy/qLadfHgqZN3IBb3BvMTo6ZEmQlKSM+8IT3SennNmQI+mkwpIk+26
	Rk3lfQV5G27UZPSeEnKXakVBgQ==
X-Google-Smtp-Source: APBJJlFR9Ju5Vfb3AHUJ7jWuLYrfbcu6xuKCy8KktQCx0EpABVN8oHS8r350MQ/TdmOpiBIOkTrovA==
X-Received: by 2002:a17:902:d484:b0:1b8:a27d:f591 with SMTP id c4-20020a170902d48400b001b8a27df591mr12261184plg.5.1690192158548;
        Mon, 24 Jul 2023 02:49:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:49:18 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	tkhai@ya.ru,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	djwong@kernel.org,
	brauner@kernel.org,
	paulmck@kernel.org,
	tytso@mit.edu,
	steven.price@arm.com,
	cel@kernel.org,
	senozhatsky@chromium.org,
	yujie.liu@intel.com,
	gregkh@linuxfoundation.org,
	muchun.song@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-erofs@lists.ozlabs.org,
	linux-f2fs-devel@lists.sourceforge.net,
	cluster-devel@redhat.com,
	linux-nfs@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	dm-devel@redhat.com,
	linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 21/47] mm: workingset: dynamically allocate the mm-shadow shrinker
Date: Mon, 24 Jul 2023 17:43:28 +0800
Message-Id: <20230724094354.90817-22-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use new APIs to dynamically allocate the mm-shadow shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/workingset.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 4686ae363000..4bc85f739b13 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -762,12 +762,7 @@ static unsigned long scan_shadow_nodes(struct shrinker *shrinker,
 					NULL);
 }
 
-static struct shrinker workingset_shadow_shrinker = {
-	.count_objects = count_shadow_nodes,
-	.scan_objects = scan_shadow_nodes,
-	.seeks = 0, /* ->count reports only fully expendable nodes */
-	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
-};
+static struct shrinker *workingset_shadow_shrinker;
 
 /*
  * Our list_lru->lock is IRQ-safe as it nests inside the IRQ-safe
@@ -779,7 +774,7 @@ static int __init workingset_init(void)
 {
 	unsigned int timestamp_bits;
 	unsigned int max_order;
-	int ret;
+	int ret = -ENOMEM;
 
 	BUILD_BUG_ON(BITS_PER_LONG < EVICTION_SHIFT);
 	/*
@@ -796,17 +791,24 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = prealloc_shrinker(&workingset_shadow_shrinker, "mm-shadow");
-	if (ret)
+	workingset_shadow_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
+						    SHRINKER_MEMCG_AWARE,
+						    "mm-shadow");
+	if (!workingset_shadow_shrinker)
 		goto err;
+
 	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key,
-			      &workingset_shadow_shrinker);
+			      workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
-	register_shrinker_prepared(&workingset_shadow_shrinker);
+
+	workingset_shadow_shrinker->count_objects = count_shadow_nodes;
+	workingset_shadow_shrinker->scan_objects = scan_shadow_nodes;
+
+	shrinker_register(workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	free_prealloced_shrinker(&workingset_shadow_shrinker);
+	shrinker_free_non_registered(workingset_shadow_shrinker);
 err:
 	return ret;
 }
-- 
2.30.2


