Return-Path: <netdev+bounces-250975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59941D39E13
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 06:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEF38303D697
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 05:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1DA2561A7;
	Mon, 19 Jan 2026 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCPuWIdh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F72550D5
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 05:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768802111; cv=none; b=e/9+/tJOfXxg+8aaxBL4qxBEr0QXXe588jlZJtAiRFv+qlQX1l5i9gkbV2f2xEbyQKPgSwEY6taxHUOV8phI66fDkrJaef7C0i+p8uaTdlYMI1AHkN/Rnfd1eSXC8u3JSIfsPr0UvJVcXR56br8Siun/CaQJIe/LYYJBuqOc2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768802111; c=relaxed/simple;
	bh=tu5SYZ4sBijOnmwN3BXLwTM84gyNVhByLrMaj3fLiQs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY4/CLwfzZrgf98r7GZU1eR1EUYhhgZTTDVX93uGqB43XUx+ss+uSYuXhrVn2qYsj4wFZewOUgDwVN2CLlyhoTdgN8va8E/OtBYP748s6DqGxViG/pPtecPJLcK6EOWp3B7M2iyWr0vsQeEXRV3Qf22o924j7SBxQzRZYZ1HvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCPuWIdh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768802103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34z1K+d6LyulR8yKYD3uyl4l7F9JoQvdVoW4oBdiuc0=;
	b=eCPuWIdhOlSBS1E3brcgGDM5eRsE2oburCOOVhHIZ8Re5c3P2tOnlY01iZhtr7cpiIBjyt
	AjVjcnk2aS87rhCTYuaVSDVSkAQr/4qk2Rv+AFJ9w20wPU0pPnZnxs6RRRvKt7jIoEBBs4
	bT5xPQhS7yvoJkUVlBC8kPRWqfn4W7k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-zNVt6Qv2NmmOORsJmHAdMw-1; Mon,
 19 Jan 2026 00:55:00 -0500
X-MC-Unique: zNVt6Qv2NmmOORsJmHAdMw-1
X-Mimecast-MFC-AGG-ID: zNVt6Qv2NmmOORsJmHAdMw_1768802099
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AD1B1800378;
	Mon, 19 Jan 2026 05:54:59 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.143])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7293719560A7;
	Mon, 19 Jan 2026 05:54:55 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v3 1/3] vdpa/mlx5: update mlx_features with driver state check
Date: Mon, 19 Jan 2026 13:53:51 +0800
Message-ID: <20260119055447.229772-2-lulu@redhat.com>
In-Reply-To: <20260119055447.229772-1-lulu@redhat.com>
References: <20260119055447.229772-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
feature bit is properly set only when the device is not yet in
the DRIVER_OK (running) state.

This makes the MAC address visible in the output of:

 vdpa dev config show -jp

when the device is created without an initial MAC address.

Signed-off-by: Cindy Lu <lulu@redhat.com>

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ddaa1366704b..6e42bae7c9a1 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -4049,7 +4049,7 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	struct mlx5_vdpa_dev *mvdev;
 	struct mlx5_vdpa_net *ndev;
 	struct mlx5_core_dev *mdev;
-	int err = -EOPNOTSUPP;
+	int err = 0;
 
 	mvdev = to_mvdev(dev);
 	ndev = to_mlx5_vdpa_ndev(mvdev);
@@ -4057,13 +4057,22 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	config = &ndev->config;
 
 	down_write(&ndev->reslock);
-	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+
+	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+			ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
+		} else {
+			mlx5_vdpa_warn(mvdev, "device running, skip updating MAC\n");
+			err = -EBUSY;
+			goto out;
+		}
 		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
 		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
 		if (!err)
 			ether_addr_copy(config->mac, add_config->net.mac);
 	}
 
+out:
 	up_write(&ndev->reslock);
 	return err;
 }
-- 
2.51.0


