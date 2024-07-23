Return-Path: <netdev+bounces-112501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBD993994A
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 07:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481EF28137B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 05:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE55B13D276;
	Tue, 23 Jul 2024 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSz56Y3d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B413D248
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721713280; cv=none; b=ef0vU8fVtn+xB68NvWdedrDZBKlkArWvy/MsJDLOBlkfyYM9RWrs56SZTPa/jr9jW6oQzqeHKz5RZ1KE2leeaNbrOom563WTu7iuyanW8XfgQPaYBvobYm3zq+9qjtyYYio5GoGWC9UcE63LSSw9D9s9mJKclVipU7dW9x0yuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721713280; c=relaxed/simple;
	bh=OMwNOAtJvsd0+twVHML6ucU5QKPKP/EwP66DMB9APFc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk6ceMMCeRYo9CqXYEjwB/HwftIct+CqnJXPPw8/8iZBJiFaLMPgplDsWiAEIQIR32oG0+45HLRc/LLXXJKrBiCPEa7hB1OE5ULyvaJ6tmcyoV+ikAUXPnT1bdvjqZy0XtfWs2+p6WKHVEuAW9fPsywIVWNzy+Rb6GFE2FHGK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSz56Y3d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721713278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2K3zitWeVcx5T7++A29JVh/X9keC+khHnixxAAEE2KY=;
	b=KSz56Y3d3jo/ZB1fxvqGodkWa0WJwpyDnOGF5FbMrAfrEXZikeIELYXmmAC18P2ITSjwnq
	Zxb/q9+WbrggS0O8xsZL9D4lGi4beR4bGUuWettZzP+1QeesMWFXgmdZp5y5izWNctwvsG
	7aADVqKp/+PX6FxoeNlx6c9tulnMAQ8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-M94j3RUYM3O5J7d38KKZDQ-1; Tue,
 23 Jul 2024 01:41:15 -0400
X-MC-Unique: M94j3RUYM3O5J7d38KKZDQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F10B919560AD;
	Tue, 23 Jul 2024 05:41:13 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9F2C1955F40;
	Tue, 23 Jul 2024 05:41:08 +0000 (UTC)
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
Subject: [PATH v5 3/3] vdpa/mlx5: Add the support of set mac address
Date: Tue, 23 Jul 2024 13:39:22 +0800
Message-ID: <20240723054047.1059994-4-lulu@redhat.com>
In-Reply-To: <20240723054047.1059994-1-lulu@redhat.com>
References: <20240723054047.1059994-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add the function to support setting the MAC address.
For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
to set the mac address

Tested in ConnectX-6 Dx device

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ecfc16151d61..7fce952d650f 100644
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
+		if (0 == err)
+			memcpy(config->mac, add_config->net.mac, ETH_ALEN);
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


