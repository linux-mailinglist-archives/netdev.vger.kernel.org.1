Return-Path: <netdev+bounces-30061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DA1785C21
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D504D1C20C0D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875BEC2FE;
	Wed, 23 Aug 2023 15:30:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E6AD42
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 15:30:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353F9CF1
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692804644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BiPg1CR7QhpEos1y8wjGxBQSx510OyL+G2I/cKhPLW8=;
	b=iHxolWmF+UtVDlyY+iqY2RXRHaoQ+oScrFUJBRqwyHByNy2gUlUX47Y2cTpqZXFR/aRFT+
	7cR8dWFa+ZEzfuQfNQB420RzeogspNFwF5iPUUqYpe7r8WfkxaAjIHqxKLUhxnfOjl4dJY
	So44IvyjVPJfIZWuNSceunjo93zmpW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-8NWu1HKwP7-2Q0-vJASG5Q-1; Wed, 23 Aug 2023 11:30:40 -0400
X-MC-Unique: 8NWu1HKwP7-2Q0-vJASG5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25F0B85D083;
	Wed, 23 Aug 2023 15:30:38 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 15181C15BAE;
	Wed, 23 Aug 2023 15:30:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com,
	eric.auger@redhat.com,
	elic@nvidia.com,
	mail@anirudhrb.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH] vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE
Date: Wed, 23 Aug 2023 17:30:32 +0200
Message-ID: <20230823153032.239304-1-eric.auger@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb
entries") Forbade vhost iotlb msg with null size to prevent entries
with size = start = 0 and last = ULONG_MAX to end up in the iotlb.

Then commit 95932ab2ea07 ("vhost: allow batching hint without size")
only applied the check for VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE
message types to fix a regression observed with batching hit.

Still, the introduction of that check introduced a regression for
some users attempting to invalidate the whole ULONG_MAX range by
setting the size to 0. This is the case with qemu/smmuv3/vhost
integration which does not work anymore. It Looks safe to partially
revert the original commit and allow VHOST_IOTLB_INVALIDATE messages
with null size. vhost_iotlb_del_range() will compute a correct end
iova. Same for vhost_vdpa_iotlb_unmap().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entries")
---
 drivers/vhost/vhost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c71d573f1c94..e0c181ad17e3 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1458,9 +1458,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 		goto done;
 	}
 
-	if ((msg.type == VHOST_IOTLB_UPDATE ||
-	     msg.type == VHOST_IOTLB_INVALIDATE) &&
-	     msg.size == 0) {
+	if (msg.type == VHOST_IOTLB_UPDATE && msg.size == 0) {
 		ret = -EINVAL;
 		goto done;
 	}
-- 
2.41.0


