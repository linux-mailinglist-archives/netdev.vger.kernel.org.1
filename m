Return-Path: <netdev+bounces-246214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07084CE61C0
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 08:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 064E930145A4
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 07:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15132F617D;
	Mon, 29 Dec 2025 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLgzVd0x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F272F5A05
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766992592; cv=none; b=al+5Bp4uYYjCH4g1vUS3m50I/5YuMv2dvlet52K+ot8lselafvRjXhuNI77dtAdDYpaLxnoIvlN/CoQ48Q2XsQYtB568ua5gp4x9e9nhGOkYwg/FNJQya3nbIQFDuelnG/lRBHMrx28TOoOZ5MJxoxHAsbufzUnFkJ6aTML/1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766992592; c=relaxed/simple;
	bh=1cFctMofE0d09YFj8piu0vfejh4bWe9o28r0XxQQY88=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F4FlcNgXDvzzzWWcoSf3ZS7r0TM4WlPfk7njGOsQKlvvx5kACWLL2m2BqghqhjOgE43CZpw/l+tDiL3a0yoAklUf4sd0bLvfJhXJM0IX91M7orR7RWIEjvHGCu9v88/SBJn2wtZIDjiMmFOkBws2en8Bh42Iwtb8Gl+vb9n0Iuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLgzVd0x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766992587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EVRsk3wGIfrNz5gAyseD2eNNhitz+sduJn4sfdlifFo=;
	b=RLgzVd0x5wkiTghlStqKKXKxLCV7QzbFlFqdxZLYglWL5fT7ZOsU8YQ3r16wY/nktPUjK6
	V7j81nUtmkMJstFdhT7qvxiAQEgcnvDbn311HYwyu97Pei6AYeqby37kQ4hxAMVRKk6VNa
	seI4+h+yF9f5kvQrYnYMwWNR0u67M6I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-94_ih8waOK6Ol6khz2zhxA-1; Mon,
 29 Dec 2025 02:16:23 -0500
X-MC-Unique: 94_ih8waOK6Ol6khz2zhxA-1
X-Mimecast-MFC-AGG-ID: 94_ih8waOK6Ol6khz2zhxA_1766992582
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 156B91956095;
	Mon, 29 Dec 2025 07:16:22 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B70019560B2;
	Mon, 29 Dec 2025 07:16:17 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	dtatulea@nvidia.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/3] vdpa/mlx5: update mlx_features with driver state check
Date: Mon, 29 Dec 2025 15:16:12 +0800
Message-ID: <20251229071614.779621-1-lulu@redhat.com>
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
2.45.0


