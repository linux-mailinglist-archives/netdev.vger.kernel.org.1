Return-Path: <netdev+bounces-27159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C85877A8F8
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFD5280CD0
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB628BF4;
	Sun, 13 Aug 2023 16:09:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750F8825
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D85FC433C8;
	Sun, 13 Aug 2023 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691942942;
	bh=ue/Ai6RKwL0lcSy2kuBTBjDoCsGd2bPg7HDVZMm4BPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hp/ZiysZVeKJWDfvjRnAUwVtmc01PYznLO9oBJPA7kT1Fv5xWVWMUs4LgtSrjBXM4
	 mig5LpOtdfUiG2SQIFxHslrTfzPCXbGMgaWIp9o5McowG0Q9DPyxGWJtE4OnAW9bSE
	 c5pUc7A8Zw+0Bp70g3JzZU8c+p1lFjElCZlBfFWqiRRdQ0hwah59wahXoZ2HacqzQc
	 BurHPZ/tMd9Dge+K2yq+ac2KAgG0mChdwfYGOZGEiE0HQ9FVrlJuztSWZOVzlqXi2x
	 SjY2NLI6fRBHq9+JHbSZ+LkInV40sSSg2E26VqlUMNbW6caKMsSWyZnwf3Az3mEszy
	 LQ3khRFgi3rjw==
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
Subject: [PATCH AUTOSEL 5.15 29/31] rbd: harden get_lock_owner_info() a bit
Date: Sun, 13 Aug 2023 12:06:02 -0400
Message-Id: <20230813160605.1080385-29-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
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
index 189e2f74b9147..1d2ba739fb268 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3864,10 +3864,9 @@ static struct ceph_locker *get_lock_owner_info(struct rbd_device *rbd_dev)
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
@@ -3888,18 +3887,28 @@ static struct ceph_locker *get_lock_owner_info(struct rbd_device *rbd_dev)
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
index 57d043b382ed0..9bf085ddbe51f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1144,6 +1144,7 @@ bool ceph_addr_is_blank(const struct ceph_entity_addr *addr)
 		return true;
 	}
 }
+EXPORT_SYMBOL(ceph_addr_is_blank);
 
 int ceph_addr_port(const struct ceph_entity_addr *addr)
 {
-- 
2.40.1


