Return-Path: <netdev+bounces-253405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOniHKY5d2mMdQEAu9opvQ
	(envelope-from <netdev+bounces-253405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:53:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0B3863D1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE87305DEF9
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C3530171C;
	Mon, 26 Jan 2026 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EU9QyLxl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FEF32BF22
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420965; cv=none; b=mvnOMH7J6XfReoTDUNd6Am/jmdjHHNlP/FbyAoIGx6ReqIp424oxiZ1cywnxJtnjy88m4n30ciEZHbvePOHsu8OsCwaqRHCEfKAh6rjJyBvMPTjNi7YUd7p4hv6impL7NepMcMNiWjFv6CSO+XMyVOGQrZTZaWhLS2z3ghV7jME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420965; c=relaxed/simple;
	bh=SCfbIDBZ0i8ji2Il2O+CBn4hTNVv8fyBRR1E4OC8jIk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjERW/1CXKjb0sjTqciXX1vfKYhCZhEsQDsiesXhv2Gpn6t6R1Vve7yPhexRccU+HchCqvWLLPrZ9ySiyCfG6w821gzTSCWL24diDSPJlbA2W1qeQDeG5ka+jwsvQfKn76zf1cun4OZdUNgO1hGR8WlTgiSTpiAgyhvvVl44jug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EU9QyLxl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769420961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95rlxJBn2msZ3au3wfm2bXPdC8+xLSko1wIOaCjjM/M=;
	b=EU9QyLxl5HpJxaMAzBl3zFFTJQh4KwwPyNeXviQL8adn8Mxs+It0hQUJjp0jgNBCTGY9cd
	QHHQevG1ysIYhdYW/F0wT6eubu+J/o8v++cMw0GMMb3xI8VMhth9nlFbqz53UFwbAj9Lwp
	h24ui/dAvPoSpy0rU6j8DdT9KG8TFbc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-Wi9pjlujN9a4MFgG7eoDRA-1; Mon,
 26 Jan 2026 04:49:08 -0500
X-MC-Unique: Wi9pjlujN9a4MFgG7eoDRA-1
X-Mimecast-MFC-AGG-ID: Wi9pjlujN9a4MFgG7eoDRA_1769420947
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E5BA1944EA8;
	Mon, 26 Jan 2026 09:49:07 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F19618001D5;
	Mon, 26 Jan 2026 09:49:01 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 2/3] vdpa/mlx5: reuse common function for MAC address updates
Date: Mon, 26 Jan 2026 17:45:37 +0800
Message-ID: <20260126094848.9601-3-lulu@redhat.com>
In-Reply-To: <20260126094848.9601-1-lulu@redhat.com>
References: <20260126094848.9601-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lulu@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253405-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: CF0B3863D1
X-Rspamd-Action: no action

Factor out MAC address update logic and reuse it from handle_ctrl_mac().

This ensures that old MAC entries are removed from the MPFS table
before adding a new one and that the forwarding rules are updated
accordingly. If updating the flow table fails, the original MAC and
rules are restored as much as possible to keep the software and
hardware state consistent.

Signed-off-by: Cindy Lu <lulu@redhat.com>

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 131 ++++++++++++++++--------------
 1 file changed, 71 insertions(+), 60 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 6e42bae7c9a1..78a4b80d1ce2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2125,86 +2125,97 @@ static void teardown_steering(struct mlx5_vdpa_net *ndev)
 	mlx5_destroy_flow_table(ndev->rxft);
 }
 
-static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
+static int mlx5_vdpa_change_mac(struct mlx5_vdpa_net *ndev,
+				struct mlx5_core_dev *pfmdev,
+				const u8 *new_mac)
 {
-	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
-	struct mlx5_control_vq *cvq = &mvdev->cvq;
-	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
-	struct mlx5_core_dev *pfmdev;
-	size_t read;
-	u8 mac[ETH_ALEN], mac_back[ETH_ALEN];
+	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
+	u8 old_mac[ETH_ALEN];
 
-	pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
-	switch (cmd) {
-	case VIRTIO_NET_CTRL_MAC_ADDR_SET:
-		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)mac, ETH_ALEN);
-		if (read != ETH_ALEN)
-			break;
+	if (is_zero_ether_addr(new_mac))
+		return -EINVAL;
 
-		if (!memcmp(ndev->config.mac, mac, 6)) {
-			status = VIRTIO_NET_OK;
-			break;
+	if (!is_zero_ether_addr(ndev->config.mac)) {
+		if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
+			mlx5_vdpa_warn(mvdev, "failed to delete old MAC %pM from MPFS table\n",
+				       ndev->config.mac);
+			return -EIO;
 		}
+	}
 
-		if (is_zero_ether_addr(mac))
-			break;
+	if (mlx5_mpfs_add_mac(pfmdev, (u8 *)new_mac)) {
+		mlx5_vdpa_warn(mvdev, "failed to insert new MAC %pM into MPFS table\n",
+			       new_mac);
+		return -EIO;
+	}
 
-		if (!is_zero_ether_addr(ndev->config.mac)) {
-			if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
-				mlx5_vdpa_warn(mvdev, "failed to delete old MAC %pM from MPFS table\n",
-					       ndev->config.mac);
-				break;
-			}
-		}
+	/* backup the original mac address so that if failed to add the forward rules
+	 * we could restore it
+	 */
+	ether_addr_copy(old_mac, ndev->config.mac);
 
-		if (mlx5_mpfs_add_mac(pfmdev, mac)) {
-			mlx5_vdpa_warn(mvdev, "failed to insert new MAC %pM into MPFS table\n",
-				       mac);
-			break;
-		}
+	ether_addr_copy(ndev->config.mac, new_mac);
 
-		/* backup the original mac address so that if failed to add the forward rules
-		 * we could restore it
-		 */
-		memcpy(mac_back, ndev->config.mac, ETH_ALEN);
+	/* Need recreate the flow table entry, so that the packet could forward back
+	 */
+	mac_vlan_del(ndev, old_mac, 0, false);
 
-		memcpy(ndev->config.mac, mac, ETH_ALEN);
+	if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
+		mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
 
-		/* Need recreate the flow table entry, so that the packet could forward back
+		/* Although it hardly run here, we still need double check */
+		if (is_zero_ether_addr(old_mac)) {
+			mlx5_vdpa_warn(mvdev, "restore mac failed: Original MAC is zero\n");
+			return -EIO;
+		}
+
+		/* Try to restore original mac address to MFPS table, and try to restore
+		 * the forward rule entry.
 		 */
-		mac_vlan_del(ndev, mac_back, 0, false);
+		if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
+			mlx5_vdpa_warn(mvdev, "restore mac failed: delete MAC %pM from MPFS table failed\n",
+				       ndev->config.mac);
+		}
 
-		if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
-			mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
+		if (mlx5_mpfs_add_mac(pfmdev, old_mac)) {
+			mlx5_vdpa_warn(mvdev, "restore mac failed: insert old MAC %pM into MPFS table failed\n",
+				       old_mac);
+		}
 
-			/* Although it hardly run here, we still need double check */
-			if (is_zero_ether_addr(mac_back)) {
-				mlx5_vdpa_warn(mvdev, "restore mac failed: Original MAC is zero\n");
-				break;
-			}
+		ether_addr_copy(ndev->config.mac, old_mac);
 
-			/* Try to restore original mac address to MFPS table, and try to restore
-			 * the forward rule entry.
-			 */
-			if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
-				mlx5_vdpa_warn(mvdev, "restore mac failed: delete MAC %pM from MPFS table failed\n",
-					       ndev->config.mac);
-			}
+		if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
+			mlx5_vdpa_warn(mvdev, "restore forward rules failed: insert forward rules failed\n");
 
-			if (mlx5_mpfs_add_mac(pfmdev, mac_back)) {
-				mlx5_vdpa_warn(mvdev, "restore mac failed: insert old MAC %pM into MPFS table failed\n",
-					       mac_back);
-			}
+		return -EIO;
+	}
 
-			memcpy(ndev->config.mac, mac_back, ETH_ALEN);
+	return 0;
+}
 
-			if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
-				mlx5_vdpa_warn(mvdev, "restore forward rules failed: insert forward rules failed\n");
+static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
+{
+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct mlx5_control_vq *cvq = &mvdev->cvq;
+	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
+	struct mlx5_core_dev *pfmdev;
+	size_t read;
+	u8 mac[ETH_ALEN];
 
+	pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
+	switch (cmd) {
+	case VIRTIO_NET_CTRL_MAC_ADDR_SET:
+		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov,
+					     (void *)mac, ETH_ALEN);
+		if (read != ETH_ALEN)
 			break;
-		}
 
-		status = VIRTIO_NET_OK;
+		if (!memcmp(ndev->config.mac, mac, 6)) {
+			status = VIRTIO_NET_OK;
+			break;
+		}
+		status = mlx5_vdpa_change_mac(ndev, pfmdev, mac) ? VIRTIO_NET_ERR :
+								       VIRTIO_NET_OK;
 		break;
 
 	default:
-- 
2.51.0


