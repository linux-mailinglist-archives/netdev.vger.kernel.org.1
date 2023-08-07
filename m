Return-Path: <netdev+bounces-24906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C177214C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9835E1C20AB0
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB87DDAA;
	Mon,  7 Aug 2023 11:19:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C984FBFE
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 11:19:46 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCFA448D
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 04:19:21 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so362091a12.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 04:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691406791; x=1692011591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urGrhHBCGKwKuhIkQmOHRuysXuy1mToQA+AaHWoY6PY=;
        b=gvEcin7S0wJ5rW0wtj9WnWp/4gO3FOqyEc5Qy3KVjjCOMIdl063r7goatTKMU5K63u
         IABDDkTZbyMiPq/rwoG72XrgfLWlV6/YJwymkZtRfBVcrDOzJOk+V88T6EEEXGW6nfh0
         le0xVwnZY7As0nXjZy+hSjIWRCXvYGRHiEKZrDZnQb7QflVpjM7uq/81aSxj3traKDGt
         VXa/baYLLxxBhWBawSSBHT4dMsZ/NRoyUnn0XTD8JWz4/O0ULe9Suh4wohOUxiotc5cA
         +kJEwQbIJfS1Vrk1T3/Loi8TKjO+pow/TrGBcBE2xp4OSLxBFU0bCUPycoGAdA8SsoOk
         yeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406791; x=1692011591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urGrhHBCGKwKuhIkQmOHRuysXuy1mToQA+AaHWoY6PY=;
        b=lhca4HtFMoXD48biX0hcF8V0L4chYTQP0b6q+w9+WgDODGNMne085gTMBG907/bC8m
         uTRq2zz4hOF7ms5a8uTAUQuxDaJUrc4SU15ce4kWG7G6rIDUwO447sg7A1eRNAN2APop
         f2CoQSuYeI2Cfqj6V8VLHDuPeewLeysANX6TP4kdSwZKAZgiK9vtRdyHVDOOM440brPD
         osSdPGXowdInIpIATHGn5Qlfc47x1XOz1bF/xyELeaJeyhTEfFBfvQx5EWndANRKbbyz
         GGCWw/w5O4tCWJrD9QJOLxCeVeVHmE7F/2RSbMcLZTLd9hKbRVx6A3sU0FrE6cWy8MIm
         f8LQ==
X-Gm-Message-State: ABy/qLZ1zzYVEzoXcL226meufbluczUWEHN6mK9G4QHCITHL3wjeTxfU
	bwbZsaaIoYuHyi4rPd3zh9aFfQ==
X-Google-Smtp-Source: APBJJlGG9fl/KZM7Wu/aB3nA3qPBXzAgCls0ii/X4UboFM2rQSd7zbDq190u8vBbdPOZ8QFUsdy1lw==
X-Received: by 2002:a17:90a:faf:b0:268:abc:83d5 with SMTP id 44-20020a17090a0faf00b002680abc83d5mr23478200pjz.4.1691406791204;
        Mon, 07 Aug 2023 04:13:11 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:13:10 -0700 (PDT)
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
	muchun.song@linux.dev,
	simon.horman@corigine.com,
	dlemoal@kernel.org
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
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 15/48] nfsd: dynamically allocate the nfsd-filecache shrinker
Date: Mon,  7 Aug 2023 19:09:03 +0800
Message-Id: <20230807110936.21819-16-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use new APIs to dynamically allocate the nfsd-filecache shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/nfsd/filecache.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ee9c923192e0..9c62b4502539 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -521,11 +521,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	return ret;
 }
 
-static struct shrinker	nfsd_file_shrinker = {
-	.scan_objects = nfsd_file_lru_scan,
-	.count_objects = nfsd_file_lru_count,
-	.seeks = 1,
-};
+static struct shrinker *nfsd_file_shrinker;
 
 /**
  * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
@@ -746,12 +742,19 @@ nfsd_file_cache_init(void)
 		goto out_err;
 	}
 
-	ret = register_shrinker(&nfsd_file_shrinker, "nfsd-filecache");
-	if (ret) {
-		pr_err("nfsd: failed to register nfsd_file_shrinker: %d\n", ret);
+	nfsd_file_shrinker = shrinker_alloc(0, "nfsd-filecache");
+	if (!nfsd_file_shrinker) {
+		ret = -ENOMEM;
+		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
 		goto out_lru;
 	}
 
+	nfsd_file_shrinker->count_objects = nfsd_file_lru_count;
+	nfsd_file_shrinker->scan_objects = nfsd_file_lru_scan;
+	nfsd_file_shrinker->seeks = 1;
+
+	shrinker_register(nfsd_file_shrinker);
+
 	ret = lease_register_notifier(&nfsd_file_lease_notifier);
 	if (ret) {
 		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
@@ -774,7 +777,7 @@ nfsd_file_cache_init(void)
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
 out_shrinker:
-	unregister_shrinker(&nfsd_file_shrinker);
+	shrinker_free(nfsd_file_shrinker);
 out_lru:
 	list_lru_destroy(&nfsd_file_lru);
 out_err:
@@ -891,7 +894,7 @@ nfsd_file_cache_shutdown(void)
 		return;
 
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
-	unregister_shrinker(&nfsd_file_shrinker);
+	shrinker_free(nfsd_file_shrinker);
 	/*
 	 * make sure all callers of nfsd_file_lru_cb are done before
 	 * calling nfsd_file_cache_purge
-- 
2.30.2


