Return-Path: <netdev+bounces-21790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9C0764BE0
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1AA1C21588
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15A411189;
	Thu, 27 Jul 2023 08:14:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A3C8C4
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:14:53 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB97EFF
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:14:35 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so167842b3a.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445332; x=1691050132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TzzNXWnGUC4v0Im6lZC1fetjV0NX81rj7dQA53Eb1w=;
        b=fVbo4B1Sn0AGX1nNJK0Eo1gukSsful8PC6Tpi9R2ay4P+tk9frdioPsIm2s6rPxi46
         ++BpYvSQrpfhaqWc0rmuBFjQPz0zzH5N+AGXb67rsChsvEkjfu687Mjmoln0lCJnbS1t
         S6gxfZ/pYInNuKorknrCkgDtrsNJQ+5b+KQpVkQdCPQpNRB6D3agySMM3uM99/xhPotu
         rAoYyPnK20sDnc7vY5XomSSW5p6ngHpl0qbTjtgeFdhf5V6H8EL0+GE/5QBEhSY2aRe8
         CqIfoMbQ3ZACqieIYGVBf+Lq9zLueZGm5ISvf4EF/2FFF37Zi67sB1q+1Y4ZesHEzWZS
         zb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445332; x=1691050132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TzzNXWnGUC4v0Im6lZC1fetjV0NX81rj7dQA53Eb1w=;
        b=WjGBXgiG/W7OqpUUsmeli2iG3zgLgDnNsXrf1OSg9p4lM4n21GAs5zOakY28ZdBQeW
         xpvNIFiFdp125J5PZ6lhQZ22GLRwNmVe1s7R9T3EigK3t5/41OLZHbJu3KgqB6m8gLuu
         yc1jQdXcjIkUu84ygi+xuOExTvFqabSIB3YkFvR6ZAjebc0IpWRUA3aDsLU9NgKKpF0U
         dpEl9RCu5NlAqNltezlY5ZbCAN0UXM5dEPllTmCZWStmL0d0pLNEokdYAcwPPFBsW5ez
         uzOIeLZeFbqS8UPs7cdiA/0Da8HnAlhyUPEZeA5p0PoQidFjboJ+xAY9mrbXvBWupHxK
         NDiw==
X-Gm-Message-State: ABy/qLbiKJUPeJ45DmTB/FTre5L8oSq75VMAqp3u1mqKUxTMPZG27y/W
	KRwxbPpUzD1HbeNk7YUwUTegeA==
X-Google-Smtp-Source: APBJJlFfoYzSpk6JWYRi+8IvWqqU5f15Mb/GG4zvV09auI3h1+KA8DLVYcizqJGa8aoS7uGFfDYCtA==
X-Received: by 2002:a05:6a00:488e:b0:677:bb4c:c321 with SMTP id dk14-20020a056a00488e00b00677bb4cc321mr4639246pfb.0.1690445332713;
        Thu, 27 Jul 2023 01:08:52 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:08:52 -0700 (PDT)
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
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 15/49] nfs: dynamically allocate the nfs-acl shrinker
Date: Thu, 27 Jul 2023 16:04:28 +0800
Message-Id: <20230727080502.77895-16-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use new APIs to dynamically allocate the nfs-acl shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/nfs/super.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 2284f749d892..072d82e1be06 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -129,11 +129,7 @@ static void nfs_ssc_unregister_ops(void)
 }
 #endif /* CONFIG_NFS_V4_2 */
 
-static struct shrinker acl_shrinker = {
-	.count_objects	= nfs_access_cache_count,
-	.scan_objects	= nfs_access_cache_scan,
-	.seeks		= DEFAULT_SEEKS,
-};
+static struct shrinker *acl_shrinker;
 
 /*
  * Register the NFS filesystems
@@ -153,9 +149,17 @@ int __init register_nfs_fs(void)
 	ret = nfs_register_sysctl();
 	if (ret < 0)
 		goto error_2;
-	ret = register_shrinker(&acl_shrinker, "nfs-acl");
-	if (ret < 0)
+
+	acl_shrinker = shrinker_alloc(0, "nfs-acl");
+	if (!acl_shrinker)
 		goto error_3;
+
+	acl_shrinker->count_objects = nfs_access_cache_count;
+	acl_shrinker->scan_objects = nfs_access_cache_scan;
+	acl_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(acl_shrinker);
+
 #ifdef CONFIG_NFS_V4_2
 	nfs_ssc_register_ops();
 #endif
@@ -175,7 +179,7 @@ int __init register_nfs_fs(void)
  */
 void __exit unregister_nfs_fs(void)
 {
-	unregister_shrinker(&acl_shrinker);
+	shrinker_free(acl_shrinker);
 	nfs_unregister_sysctl();
 	unregister_nfs4_fs();
 #ifdef CONFIG_NFS_V4_2
-- 
2.30.2


