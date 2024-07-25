Return-Path: <netdev+bounces-112893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B293BA30
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 03:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62087B21BC0
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CF5182C9;
	Thu, 25 Jul 2024 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ts0UWYFh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04E17722
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871170; cv=none; b=O4zdRnGbdf+q8ySsDwwR4Yj1uKT848PUnVamXa6lX98bMQEWFKKO+9ksjrzc4ocT6g67uFshCerOJqL5RRrd+BSu1CZzC0o+HTjMPl0cwvXeHqm7atUXFUrT6O2KrKh2qa7hMfmhCH3W/y3EO3ojQ+R1ZWqzeml55sARSCXKQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871170; c=relaxed/simple;
	bh=aQT2ZjdHncAQA3F9k5tupIS/QkiNkv6HyFsjQ5yQFgg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJ/t7v2bM/l/nKtkQw2r+SvRD2fXhZpXvMacVKocHq7gZvzWfnr05oj37Ehu6X+JuN2emSF0ivLHJuY4pB0qBQix2/uYI6z5mFqMk318jrL1rqTeaB8WCYoUIkOVcr5Je+A/w6xhis9kSylrL2HTJmHZVqxVr3XjDdZSqSLU0JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ts0UWYFh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721871168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyzxTagTU4yj7oHgWRzHQbbpQVmDDWL4VI+84EdA2Xw=;
	b=Ts0UWYFhjntKkzPMpY9onba8lwbSVpobr2VG+6ihYwo4etJwNbTqTC9V8dIN5S3/J+zD5L
	3kWPImLeoRa7lUxNPfyMwmeav7Nh8AKi1sz7eK7KMoMmTpL0fBRbD/VuVZ6zOKmXX5h05z
	ee4OOm36d3ZrRhLqrIpDWGI3tiNezlc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-_ayhg8jcOCazEdAX-TLUFQ-1; Wed,
 24 Jul 2024 21:32:45 -0400
X-MC-Unique: _ayhg8jcOCazEdAX-TLUFQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7D191955F3D;
	Thu, 25 Jul 2024 01:32:43 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.141])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD4021955D45;
	Thu, 25 Jul 2024 01:32:38 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATH v6 3/3] vdpa/mlx5: Add the support of set mac address
Date: Thu, 25 Jul 2024 09:31:04 +0800
Message-ID: <20240725013217.1124704-4-lulu@redhat.com>
In-Reply-To: <20240725013217.1124704-1-lulu@redhat.com>
References: <20240725013217.1124704-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add the function to support setting the MAC address.
For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
to set the mac address

Tested in ConnectX-6 Dx device

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ecfc16151d61..d7e5e30e9ef4 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3785,10 +3785,38 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	destroy_workqueue(wq);
 	mgtdev->ndev = NULL;
 }
+static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
+			      struct vdpa_device *dev,
+			      const struct vdpa_dev_set_config *add_config)
+{
+	struct virtio_net_config *config;
+	struct mlx5_core_dev *pfmdev;
+	struct mlx5_vdpa_dev *mvdev;
+	struct mlx5_vdpa_net *ndev;
+	struct mlx5_core_dev *mdev;
+	int err = -EINVAL;
+
+	mvdev = to_mvdev(dev);
+	ndev = to_mlx5_vdpa_ndev(mvdev);
+	mdev = mvdev->mdev;
+	config = &ndev->config;
+
+	down_write(&ndev->reslock);
+	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
+		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
+		if (!err)
+			ether_addr_copy(config->mac, add_config->net.mac);
+	}
+
+	up_write(&ndev->reslock);
+	return err;
+}
 
 static const struct vdpa_mgmtdev_ops mdev_ops = {
 	.dev_add = mlx5_vdpa_dev_add,
 	.dev_del = mlx5_vdpa_dev_del,
+	.dev_set_attr = mlx5_vdpa_set_attr,
 };
 
 static struct virtio_device_id id_table[] = {
-- 
2.45.0


