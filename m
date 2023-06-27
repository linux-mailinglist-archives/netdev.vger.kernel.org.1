Return-Path: <netdev+bounces-14235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF56773FB35
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 13:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9954D281062
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F31617ACC;
	Tue, 27 Jun 2023 11:37:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EBE17AAB
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 11:37:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA99026B7
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 04:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687865848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8uI9NITXhdIkfxIh/YGGZnndpIynq2QI9XP50PGOk8=;
	b=JuSF3WmxLz7lhAimun51C0IfTJZPne1q7B5fpzfgTfwrxKKBHpiVK/tupIqLo0olX2v0Xu
	96Cm9mCHcc1IuRokYbeFCqs38ylBdcVqKcgf6QpQ9b3U8idUwrhW4enXlDD0RZP6feGc51
	NzbpPWG/+1TmlxOkNVXXNxQWoFdnNGM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-6Rwe48HYN8aT70oaGUc4YA-1; Tue, 27 Jun 2023 07:37:24 -0400
X-MC-Unique: 6Rwe48HYN8aT70oaGUc4YA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 472F13C0FC8D;
	Tue, 27 Jun 2023 11:37:24 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0A63F5CD0;
	Tue, 27 Jun 2023 11:37:21 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: xieyongji@bytedance.com,
	jasowang@redhat.com,
	mst@redhat.com,
	david.marchand@redhat.com,
	lulu@redhat.com
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v1 2/2] vduse: enable Virtio-net device type
Date: Tue, 27 Jun 2023 13:36:52 +0200
Message-ID: <20230627113652.65283-3-maxime.coquelin@redhat.com>
In-Reply-To: <20230627113652.65283-1-maxime.coquelin@redhat.com>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds Virtio-net device type to the supported
devices types. Initialization fails if the device does
not support VIRTIO_F_VERSION_1 feature, in order to
guarantee the configuration space is read-only.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index c1c2f4c711ae..89088fa27026 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -142,6 +142,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
 
 static u32 allowed_device_id[] = {
 	VIRTIO_ID_BLOCK,
+	VIRTIO_ID_NET,
 };
 
 static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
@@ -1668,6 +1669,10 @@ static bool features_is_valid(struct vduse_dev_config *config)
 			(config->features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE)))
 		return false;
 
+	if ((config->device_id == VIRTIO_ID_NET) &&
+			!(config->features & (1ULL << VIRTIO_F_VERSION_1)))
+		return false;
+
 	return true;
 }
 
@@ -2023,6 +2028,7 @@ static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtdev_ops = {
 
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
+	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
 
-- 
2.41.0


