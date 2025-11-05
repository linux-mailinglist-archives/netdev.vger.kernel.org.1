Return-Path: <netdev+bounces-235735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2898C3460E
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 09:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D941189E5BA
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7BF2877E3;
	Wed,  5 Nov 2025 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdR4RGF9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816072459DD
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329750; cv=none; b=gD2PlbCa6WZYFYDP8HWAZnDGlLnU5N+03wiCM39SQok/2ZQZ98J5boVM/HyJWYsFHEzoq6TezOcwmUWfZNxNQfAx2y4PkSFgmat6VjhkPnwN9KJAUA2HdiAGrlroVd8UAH69ti5eDG3CLG2AC+S/OLutfocTndbGR3EuqW9nKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329750; c=relaxed/simple;
	bh=Im/jbFW1PXu0DyD1OsaZtf76+zTzKi9bRkHMucf1rck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzZbjyX4uLCf/RfgtRLq3d/2tzn82SJ+FBQ1XT2+dNINQN9+vvAAqxCKplMq27y7hLuWyvn2JEBr4FvHAsjWlVUp7s5fzcFLv+hX6jFEmGGIstTBgXUTBkRok3SkAVTHgvWa1AfRZqNMqzakbKKiP5isyWlMcGEEwJnf50KJm2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdR4RGF9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762329747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ad3uiUpFv6Lo0Ng/XdnYT78e+HaMv60E5R89kEybRmM=;
	b=fdR4RGF9pvtSGjDqdrcoD/fJ6xDkQkUzOCe4a0Ts37Y4NKSoA//tELjfsT5J7HHfB9i8ZT
	J2IHuU+vsmp1umMdDs/LvELXg83sgkcm+vgKd+EPjiHZBWcAYkxl3Mv994NLm+egcce5bp
	fIsqlvOE7jI+ZPatjJsFlhVJ3XTFtrY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-3ijyQgS6N9GqiK0tXUBx1w-1; Wed,
 05 Nov 2025 03:02:24 -0500
X-MC-Unique: 3ijyQgS6N9GqiK0tXUBx1w-1
X-Mimecast-MFC-AGG-ID: 3ijyQgS6N9GqiK0tXUBx1w_1762329743
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A24C1956095;
	Wed,  5 Nov 2025 08:02:23 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 902881800451;
	Wed,  5 Nov 2025 08:02:19 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()
Date: Wed,  5 Nov 2025 16:01:42 +0800
Message-ID: <20251105080151.1115698-2-lulu@redhat.com>
In-Reply-To: <20251105080151.1115698-1-lulu@redhat.com>
References: <20251105080151.1115698-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Improve MAC address handling in mlx5_vdpa_set_attr() to ensure
that old MAC entries are properly removed from the MPFS table
before adding a new one. The new MAC address is then added to
both the MPFS and VLAN tables.

Warnings are issued if deleting or adding a MAC entry fails, but
the function continues to execute in order to keep the configuration
as consistent as possible with the hardware state.

This change fixes an issue where the updated MAC address would not
take effect until the qemu was rebooted

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index e38aa3a335fc..4bc39cb76268 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -4067,10 +4067,26 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
 	down_write(&ndev->reslock);
 	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
 		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
-		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
-		if (!err)
+		if (!is_zero_ether_addr(ndev->config.mac)) {
+			if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
+				mlx5_vdpa_warn(mvdev,"failed to delete old MAC %pM from MPFS table\n",
+					ndev->config.mac);
+			}
+		}
+		err = mlx5_mpfs_add_mac(pfmdev, (u8 *)add_config->net.mac);
+		if (!err) {
+			mac_vlan_del(ndev, config->mac, 0, false);
 			ether_addr_copy(config->mac, add_config->net.mac);
+		} else {
+			mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM to MPFS table\n",
+				(u8 *)add_config->net.mac);
+			up_write(&ndev->reslock);
+			return err;
+		}
 	}
+	if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
+		mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM to vlan table\n",
+			       (u8 *)add_config->net.mac);
 
 	up_write(&ndev->reslock);
 	return err;
-- 
2.45.0


