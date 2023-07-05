Return-Path: <netdev+bounces-15504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADA77481B5
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 12:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7696F280FE4
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 10:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A5E53AD;
	Wed,  5 Jul 2023 10:04:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E36FA1
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 10:04:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE91723
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688551484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hwC5y47T6/UzpMniXD0dlaNgSU/p+1EVDrFsA80r7Q=;
	b=DWV1f0gyz8qiVcQxzTdtltwuXh6PE0w9M+rYbDjd2grZ4FyEcQ2wLckBrdvpZ7nbhvABPV
	tv8SP9xHO4u+TKP9D+NxQz+uK0IZB+DWrck8m0Wljj0Wa1TQZeo7HN2AIRnKqiB7aSjkIp
	3uZI1k/WVQx8SpDqZ2TIbcdocSCD43c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-cO98A2tqP06Uvdywyz-xNQ-1; Wed, 05 Jul 2023 06:04:43 -0400
X-MC-Unique: cO98A2tqP06Uvdywyz-xNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D85BF1C172AB;
	Wed,  5 Jul 2023 10:04:42 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 813FE4021523;
	Wed,  5 Jul 2023 10:04:40 +0000 (UTC)
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
Subject: [PATCH v3 3/3] vduse: Temporarily disable control queue features
Date: Wed,  5 Jul 2023 12:04:30 +0200
Message-ID: <20230705100430.61927-4-maxime.coquelin@redhat.com>
In-Reply-To: <20230705100430.61927-1-maxime.coquelin@redhat.com>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Virtio-net driver control queue implementation is not safe
when used with VDUSE. If the VDUSE application does not
reply to control queue messages, it currently ends up
hanging the kernel thread sending this command.

Some work is on-going to make the control queue
implementation robust with VDUSE. Until it is completed,
let's filter out control virtqueue and features that depend
on it by keeping only features known to be supported.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1271c9796517..7345071db0a8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -46,6 +46,30 @@
 
 #define IRQ_UNBOUND -1
 
+#define VDUSE_NET_VALID_FEATURES_MASK           \
+	(BIT_ULL(VIRTIO_NET_F_CSUM) |           \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |     \
+	 BIT_ULL(VIRTIO_NET_F_MTU) |            \
+	 BIT_ULL(VIRTIO_NET_F_MAC) |            \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |     \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |     \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |      \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_ECN) |       \
+	 BIT_ULL(VIRTIO_NET_F_HOST_UFO) |       \
+	 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |      \
+	 BIT_ULL(VIRTIO_NET_F_STATUS) |         \
+	 BIT_ULL(VIRTIO_NET_F_HOST_USO) |       \
+	 BIT_ULL(VIRTIO_F_ANY_LAYOUT) |         \
+	 BIT_ULL(VIRTIO_RING_F_INDIRECT_DESC) | \
+	 BIT_ULL(VIRTIO_F_EVENT_IDX) |          \
+	 BIT_ULL(VIRTIO_F_VERSION_1) |          \
+	 BIT_ULL(VIRTIO_F_IOMMU_PLATFORM) |     \
+	 BIT_ULL(VIRTIO_F_RING_PACKED) |        \
+	 BIT_ULL(VIRTIO_F_IN_ORDER))
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -1778,6 +1802,16 @@ static struct attribute *vduse_dev_attrs[] = {
 
 ATTRIBUTE_GROUPS(vduse_dev);
 
+static void vduse_dev_features_filter(struct vduse_dev_config *config)
+{
+	/*
+	 * Temporarily filter out virtio-net's control virtqueue and features
+	 * that depend on it while CVQ is being made more robust for VDUSE.
+	 */
+	if (config->device_id == VIRTIO_ID_NET)
+		config->features &= VDUSE_NET_VALID_FEATURES_MASK;
+}
+
 static int vduse_create_dev(struct vduse_dev_config *config,
 			    void *config_buf, u64 api_version)
 {
@@ -1793,6 +1827,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	if (!dev)
 		goto err;
 
+	vduse_dev_features_filter(config);
+
 	dev->api_version = api_version;
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
-- 
2.41.0


