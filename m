Return-Path: <netdev+bounces-27155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E5077A893
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43FB280FFE
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B728BF4;
	Sun, 13 Aug 2023 16:03:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54268825
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C400BC433D9;
	Sun, 13 Aug 2023 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691942634;
	bh=81YxcRtyYGyQL2hXiJHSKYGrwzqRyPcgscTDx1euzB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q8t/9n8JDjRA8LjdLY1JXhJrwhGqZiNggBftR5MIGONe2v8B2Rj4xUu4567VjDYh+
	 r1qWcPBDNqcXdldN4aPItZx38dzBnQLdzFLG9dr2htgArYstSRugTQ3ECeXZTw+ZDF
	 LyTK32gWo4p52EZUzdzfEJgJXAl+mrPUzng3WYx9i1wYvO/UOSjWAPDPmIHAwZEym9
	 Qq88zPeUH24myoXoXhhpS7xWvSYQRHWGQWPb5StR7qmFyhcYcQlKx7+TEKc0GcOa0w
	 9S3XKSEpczCOR5/pn2JsCQFC2xwGb5NUohlEWWfKj8upjwTI7+9l+aoAw0wetz5D4z
	 TRP9U8Q5dGeQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Sasha Levin <sashal@kernel.org>,
	axboe@kernel.dk,
	xiubli@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 43/47] rbd: harden get_lock_owner_info() a bit
Date: Sun, 13 Aug 2023 11:59:38 -0400
Message-Id: <20230813160006.1073695-43-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit 8ff2c64c9765446c3cef804fb99da04916603e27 ]

- we want the exclusive lock type, so test for it directly
- use sscanf() to actually parse the lock cookie and avoid admitting
  invalid handles
- bail if locker has a blank address

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rbd.c  | 21 +++++++++++++++------
 net/ceph/messenger.c |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 523a903d6ae5f..2615ab99eb9aa 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3863,10 +3863,9 @@ static struct ceph_locker *get_lock_owner_info(struct rbd_device *rbd_dev)
 	u32 num_lockers;
 	u8 lock_type;
 	char *lock_tag;
+	u64 handle;
 	int ret;
 
-	dout("%s rbd_dev %p\n", __func__, rbd_dev);
-
 	ret = ceph_cls_lock_info(osdc, &rbd_dev->header_oid,
 				 &rbd_dev->header_oloc, RBD_LOCK_NAME,
 				 &lock_type, &lock_tag, &lockers, &num_lockers);
@@ -3887,18 +3886,28 @@ static struct ceph_locker *get_lock_owner_info(struct rbd_device *rbd_dev)
 		goto err_busy;
 	}
 
-	if (lock_type == CEPH_CLS_LOCK_SHARED) {
-		rbd_warn(rbd_dev, "shared lock type detected");
+	if (lock_type != CEPH_CLS_LOCK_EXCLUSIVE) {
+		rbd_warn(rbd_dev, "incompatible lock type detected");
 		goto err_busy;
 	}
 
 	WARN_ON(num_lockers != 1);
-	if (strncmp(lockers[0].id.cookie, RBD_LOCK_COOKIE_PREFIX,
-		    strlen(RBD_LOCK_COOKIE_PREFIX))) {
+	ret = sscanf(lockers[0].id.cookie, RBD_LOCK_COOKIE_PREFIX " %llu",
+		     &handle);
+	if (ret != 1) {
 		rbd_warn(rbd_dev, "locked by external mechanism, cookie %s",
 			 lockers[0].id.cookie);
 		goto err_busy;
 	}
+	if (ceph_addr_is_blank(&lockers[0].info.addr)) {
+		rbd_warn(rbd_dev, "locker has a blank address");
+		goto err_busy;
+	}
+
+	dout("%s rbd_dev %p got locker %s%llu@%pISpc/%u handle %llu\n",
+	     __func__, rbd_dev, ENTITY_NAME(lockers[0].id.name),
+	     &lockers[0].info.addr.in_addr,
+	     le32_to_cpu(lockers[0].info.addr.nonce), handle);
 
 out:
 	kfree(lock_tag);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index dfa237fbd5a32..09feb3f1fcaa3 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1118,6 +1118,7 @@ bool ceph_addr_is_blank(const struct ceph_entity_addr *addr)
 		return true;
 	}
 }
+EXPORT_SYMBOL(ceph_addr_is_blank);
 
 int ceph_addr_port(const struct ceph_entity_addr *addr)
 {
-- 
2.40.1


