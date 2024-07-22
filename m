Return-Path: <netdev+bounces-112354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E8993871D
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 03:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EF228129A
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 01:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1538C1A;
	Mon, 22 Jul 2024 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JND6bYfq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9315AF6
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610419; cv=none; b=jiYWHAVyK/eahsAgzxhcMRbM7SIngoulFXMEMqcGZQQJA4vhMa2ZWvK+FfHsPKdfXRBG0TRqZ5/MH3zmG1q5ojnhdlSm/qOwnii0/fNwGME1aEsbVQ7os3IzZd7cYrHw92Jj2Y+mMtxnAAP5mmxbGZ2G1GaBn9uTkKz0iz9Y7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610419; c=relaxed/simple;
	bh=gXbWIq+gxkTzT3zch5PQ/lEQzgZ4K6uVJ8NO5W4Cj6g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGRso2K+9Sbgw6rKF8YKchdu1yyrbt+SyjBK0MmqYctyFO0YCqfwfAU3h/NIQ2wGtPMjPpukcxs7XfokrskIEqp+gySz1F9JYOhbzyFWiFTZS0IWxI4aa3zU5M8D7CD7/MUkNd8SXPcft6bJ/PjXUr08GwvwPadVFc7Bir6eZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JND6bYfq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721610417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4jF6VLeOGDtL4UWMcNA9VQvzb5OUV9kjKDeZZWn4yk=;
	b=JND6bYfqnjU68MY3zeSXWbtHWZfVR4Xt7HzGbpwsp66fvRT2ZRcDZBzdoHC0AHtOSGdNp9
	WbYQp0pAajlrW4LHWHi0S3NEpIzTlnAFuUPnSn4pZEIAidKlXREsXoCxWri2oHViAG8q/A
	vQUkbWvAbFikOr0JbRDSpctuiYUrCdU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-8veGnTEQMDyOHd8Y2cAJZw-1; Sun,
 21 Jul 2024 21:06:53 -0400
X-MC-Unique: 8veGnTEQMDyOHd8Y2cAJZw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79FC219560AD;
	Mon, 22 Jul 2024 01:06:52 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C69A195605A;
	Mon, 22 Jul 2024 01:06:47 +0000 (UTC)
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
Subject: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
Date: Mon, 22 Jul 2024 09:05:20 +0800
Message-ID: <20240722010625.1016854-4-lulu@redhat.com>
In-Reply-To: <20240722010625.1016854-1-lulu@redhat.com>
References: <20240722010625.1016854-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add the function to support setting the MAC address.
For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
to set the mac address

Tested in ConnectX-6 Dx device

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ecfc16151d61..415b527a9c72 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	destroy_workqueue(wq);
 	mgtdev->ndev = NULL;
 }
+static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
+			      struct vdpa_device *dev,
+			      const struct vdpa_dev_set_config *add_config)
+{
+	struct mlx5_vdpa_dev *mvdev;
+	struct mlx5_vdpa_net *ndev;
+	struct mlx5_core_dev *mdev;
+	struct virtio_net_config *config;
+	struct mlx5_core_dev *pfmdev;
+	int err = -EOPNOTSUPP;
+
+	mvdev = to_mvdev(dev);
+	ndev = to_mlx5_vdpa_ndev(mvdev);
+	mdev = mvdev->mdev;
+	config = &ndev->config;
+
+	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
+		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
+		if (!err)
+			memcpy(config->mac, add_config->net.mac, ETH_ALEN);
+	}
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


