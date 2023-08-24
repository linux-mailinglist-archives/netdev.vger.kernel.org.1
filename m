Return-Path: <netdev+bounces-30286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D89786C1E
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7171C20DDE
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12062D533;
	Thu, 24 Aug 2023 09:37:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653ED524
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:37:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63961172D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692869851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uZHW7/YdobFQu4b8Ky8EljlQfqzf6RTBcoIhE6B2qYY=;
	b=busTArwmquthbFPkzK9KWCjYfLQbSa9zDF0xNGqONH6w/X6Aa50SJnGXYuLXHzsbaXKSdd
	EFFNYvkDVVZaRhNIO53o8PANHMs/vVP91UXWfGzbVsd+lrTjq8yNuD85+D/9bMGtGjIZfD
	SKKqJd//YFnb7vQicQtrHOwKDyvqKDk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-gOjt71FkNzGmanITnBlIvw-1; Thu, 24 Aug 2023 05:37:28 -0400
X-MC-Unique: gOjt71FkNzGmanITnBlIvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 859D8101A528;
	Thu, 24 Aug 2023 09:37:27 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60C4B6B2B2;
	Thu, 24 Aug 2023 09:37:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com,
	eric.auger@redhat.com,
	elic@nvidia.com,
	mail@anirudhrb.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	kvmarm@lists.linux.dev
Cc: stable@vger.kernel.org
Subject: [PATCH v2] vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE
Date: Thu, 24 Aug 2023 11:37:22 +0200
Message-ID: <20230824093722.249291-1-eric.auger@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
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
Cc: stable@vger.kernel.org # v5.17+
Acked-by: Jason Wang <jasowang@redhat.com>

---
v1 -> v2:
- Added Cc stable and Jason's Acked-by
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


