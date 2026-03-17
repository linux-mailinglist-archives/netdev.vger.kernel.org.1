Return-Path: <netdev+bounces-268577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHtbFSE9uWkowQEAu9opvQ
	(envelope-from <netdev+bounces-268577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:38:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 784112A8FD6
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7B13049169
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93CB34DCD1;
	Tue, 17 Mar 2026 11:36:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6634A3A2
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747365; cv=none; b=g8CzfD5aM668Sd3eTNYAHhyD2H5JDJr9TFVig2lQZCqKdPNrBiZff/UqbXWz0iB7KquujTPBQ7krGFTZRYZ/dPtCcimfIYSu8zMD7lQnvR+b63lEYXJ0Me7Alv1nZGsyNtLBY9Me22BEJGxm1RdYfk25/g/an4WXDwrguhiBx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747365; c=relaxed/simple;
	bh=O93yltRG3CkyZGubYRJthm+WDgRR4JhOkoUy8EcZyps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RmNHMtO0qlBv4n2ez8ajOWJB2AJTuOfLhVph2cx+yG857yrPAivzi/WDanJ1W8atMUrGlncvDsTGD6kSz29uuBojiQ3CIWaPwq0gzGUY2vrcNOyQnsKzRcTFNkyHLo+qEOymPnE/fIl9CjGUQ3gQW47yRoTp/IO4P+iVmL0RBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZqdl6TtGz1YQpmJ;
	Tue, 17 Mar 2026 19:35:39 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZqdj073Nz1YQpmJ;
	Tue, 17 Mar 2026 19:35:37 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 9126B30004F8;
	Tue, 17 Mar 2026 19:34:15 +0800 (CST)
Received: from SZ-4DN1M34.Hygon.cn (172.28.22.30) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 17 Mar
 2026 19:35:35 +0800
From: Di Zhu <zhud@hygon.cn>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <netdev@vger.kernel.org>,
	<virtualization@lists.linux.dev>
CC: <zhud@hygon.cn>, <lijing@hygon.cn>, <yingzhiwei@hygon.cn>
Subject: [PATCH net v3] virtio-net: enable NETIF_F_GRO_HW only if GRO-related offloads are supported
Date: Tue, 17 Mar 2026 19:34:33 +0800
Message-ID: <20260317113433.927022-1-zhud@hygon.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[hygon.cn : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268577-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[zhud@hygon.cn,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.879];
	RCVD_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hygon.cn:email,hygon.cn:mid]
X-Rspamd-Queue-Id: 784112A8FD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
allows control over offload support, but the offloads that can be
controlled may have nothing to do with GRO (e.g., if neither GUEST_TSO4
nor GUEST_TSO6 is supported).

In such a setup, reporting NETIF_F_GRO_HW as available for the device
is too optimistic and misleading to the user.

Improve the situation by masking off NETIF_F_GRO_HW unless the device
possesses actual GRO-related offload capabilities. Out of an abundance
of caution, this does not change the current behaviour for hardware with
just v6 or just v4 GRO: current interfaces do not allow distinguishing
between v6/v4 GRO, so we can't expose them to userspace precisely.

Fixes: dbcf24d15388 ("virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO")
Signed-off-by: Di Zhu <zhud@hygon.cn>
---
/* v3 */
  -Update Fixes tag to dbcf24d15388
  -Refine commit message using Maintainer's "too optimistic" 
    phrasing to clarify the risk of misleading configurations.

/* v2 */
  -make the modified logic clearer
---
 drivers/net/virtio_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d6a9c6a5a2..b233c99925e9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
 		dev->features |= NETIF_F_GRO_HW;
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
-		dev->hw_features |= NETIF_F_GRO_HW;
 
 	dev->vlan_features = dev->features;
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
@@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
+	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
+		dev->hw_features |= NETIF_F_GRO_HW;
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
-- 
2.34.1



