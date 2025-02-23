Return-Path: <netdev+bounces-168865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5937A411F5
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 22:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B32216D4CF
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 21:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0901D89F8;
	Sun, 23 Feb 2025 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4Na0tuW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FB15CD74
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740346958; cv=none; b=Y+rgFgy87oG+qfMCyVogwEJ+5Tc8LU7tH1eRZV6nKxLLeEj+GS1vNl1c15UtVPR6c1Tho0H9GxBkiUnXMy8bDnvg2qHWXWpRqIv6HUNrGbIbgyKF4IuQW2ymZFVZ8ZoN6TM0oWgajvkAsNZCFj1tyS+FlrloQApv57NS2X8slNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740346958; c=relaxed/simple;
	bh=rEvHbnYKQpBFwll1WQWsbq5WuRmWSbEgzW/UYZIQF1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxWpppyyJdR++lwXbX7azK6zbMO99RLuswqPIfn3ZxplnUKCP75/4oNl2w6HStAVYn3BSKD0QcP87BQtoxQE75fYZJoVV/FXynx1ZZdMPIwc+cTtznIFnHL47gy2kkHtPM41fufVQFuIKxv/K5lgM0FyiK/94wGEBRxN3eJKokY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4Na0tuW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740346954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sWra216s7GikupBJEjQdynGKBgHn4da1PZUV8LXeWos=;
	b=R4Na0tuWn2xlmeHVBXNVYxn6hslqT9mxyxNFb0U6YpSf9AdgwkT/9llFUTMOQ2NNIPbOgA
	prb0YgUjtXqiFTwkiWhKNz0+mKZtJZlLS45Wv7yiNK3CKOrJpruicLLTtM6hTtR54rLGwC
	X9KzUikaR+c1JfKDl8C76snGBlrUHag=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-g2pqr3nrPUeP_ibdwb7X8w-1; Sun,
 23 Feb 2025 16:42:31 -0500
X-MC-Unique: g2pqr3nrPUeP_ibdwb7X8w-1
X-Mimecast-MFC-AGG-ID: g2pqr3nrPUeP_ibdwb7X8w_1740346950
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93B9B19373DC;
	Sun, 23 Feb 2025 21:42:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.47.238.26])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 653FA1956094;
	Sun, 23 Feb 2025 21:42:27 +0000 (UTC)
From: Mohammad Heib <mheib@redhat.com>
To: netdev@vger.kernel.org,
	benve@cisco.com,
	satishkh@cisco.com
Cc: Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net] enic: Avoid removing IPv6 address when updating rings size.
Date: Sun, 23 Feb 2025 23:42:03 +0200
Message-ID: <20250223214203.2159676-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Currently, the enic driver calls the dev_close function to temporarily
shut down the device before updating the device rings. This call
triggers a NETDEV_DOWN event, which is sent to the network stack via the
network notifier.

When the IPv6 stack receives such an event, it removes the IPv6
addresses from the affected device, keeping only the permanent
addresses. This behavior is inconsistent with other network drivers and
can lead to traffic loss, requiring reconfiguration of IPv6 addresses
after every ring update.

To avoid this behavior, this patch temporarily sets the interface config
`keep_addr_on_down` to 1 before closing the device during the rings
update, and restores the original value of `keep_addr_on_down` after
updating the device rings, this will prevent the ipv6 stack from
removing the current ipv6 addresses during the rings update.

Fixes: ed519b7488a4 ("enic: Add support for 'ethtool -g/-G'")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index d607b4f0542c..0860233ebac6 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/ethtool.h>
 #include <linux/net_tstamp.h>
+#include <net/addrconf.h>
 
 #include "enic_res.h"
 #include "enic.h"
@@ -235,10 +236,12 @@ static int enic_set_ringparam(struct net_device *netdev,
 {
 	struct enic *enic = netdev_priv(netdev);
 	struct vnic_enet_config *c = &enic->config;
+	struct inet6_dev *idev = NULL;
 	int running = netif_running(netdev);
 	unsigned int rx_pending;
 	unsigned int tx_pending;
 	int err = 0;
+	__s32 old_keep_addr_on_down = 0;
 
 	if (ring->rx_mini_max_pending || ring->rx_mini_pending) {
 		netdev_info(netdev,
@@ -266,8 +269,25 @@ static int enic_set_ringparam(struct net_device *netdev,
 			    ENIC_MAX_WQ_DESCS);
 		return -EINVAL;
 	}
-	if (running)
+	if (running) {
+		/* Temporarily store the old value of keep_addr_on_down for this specific
+		 * device and set it to 1. This ensures that the IPv6 stack call triggered
+		 * by the dev_close function in the next line will not remove the IPv6
+		 * addresses. The keep_addr_on_down value will be restored to its original
+		 * value before calling dev_open, ensuring that this temporary change does
+		 * not affect any future device changes.
+		 *
+		 * The rtnl lock was already acquired in the caller of this function,
+		 * so it is safe to call the function below.
+		 */
+		idev = __in6_dev_get(netdev);
+		if (idev) {
+			old_keep_addr_on_down = idev->cnf.keep_addr_on_down;
+			idev->cnf.keep_addr_on_down = 1;
+		}
 		dev_close(netdev);
+	}
+
 	c->rq_desc_count =
 		ring->rx_pending & 0xffffffe0; /* must be aligned to groups of 32 */
 	c->wq_desc_count =
@@ -282,6 +302,9 @@ static int enic_set_ringparam(struct net_device *netdev,
 	}
 	enic_init_vnic_resources(enic);
 	if (running) {
+		if (idev)
+			idev->cnf.keep_addr_on_down = old_keep_addr_on_down;
+
 		err = dev_open(netdev, NULL);
 		if (err)
 			goto err_out;
@@ -290,6 +313,8 @@ static int enic_set_ringparam(struct net_device *netdev,
 err_out:
 	c->rq_desc_count = rx_pending;
 	c->wq_desc_count = tx_pending;
+	if (idev)
+		idev->cnf.keep_addr_on_down = old_keep_addr_on_down;
 	return err;
 }
 
-- 
2.48.1


