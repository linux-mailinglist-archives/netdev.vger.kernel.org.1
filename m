Return-Path: <netdev+bounces-274760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DekJPf5zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:21:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E522C38F276
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5798D31115C2
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16453FE366;
	Thu,  2 Apr 2026 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="KyOBLQe+"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40333EF678;
	Thu,  2 Apr 2026 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171467; cv=none; b=hslYLWBRO/x4eY0CBuhYh/hHoAqpHGrkgPW++C9VvNp/nTP1KhPVTQPqs/EjzuDy2V0If1GoN0UrzTj1mo9yhme1vdEEewLGqSjBFjZLpjHvz4nMO9aI/X4F0aLxiL/mmFQySnphxhFfku76pVEf6ymc2e201H9mqklNFrQXbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171467; c=relaxed/simple;
	bh=A0k6D5pmzfHiA0YiiKxu/g7pg9r3TMcsyLuKDKF97Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxF1h5Zs6lyTqCqWX1l0phIoryTkXLgEJydgEkIX3srAZMFGHe9NKeVy77EuQ0ixA1O+QgW1XzdhBEYEkxqwKJUktvPSVR1P0hCVJHMI67QkKMubSIYgDBx7dSC/vkQUC4RonyjjnTDNQweqTqz7vEhyQ/oHlDiTE5PUuFhi8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=KyOBLQe+; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=vSWNL4ZsdVyxy7lJUvZZ8boDIZ/iMqlQ5pgxpJkU0a0=; b=KyOBLQe+DH5GLv+Fw0zDZHIFLq
	GPj4MJUhaRCJv2R0UHQ2pPSJFCL1NYfkU9zA38KVES9ZmUCdIeO0z5tzc3khCOtp5AFYZx1Ksydsy
	8EEr0Blg3/vf5ghEXbmzDk4MUwJRkTdHQvm5bEs4UA4RTgvUEdWOAN+IBNaoJXJSA15ojhAcY8dA8
	dPZ3/miqD9Vfcv/MWLHYZ5gGmJ1/zueZ5OnXOlHrsp6o6AS4zWTk1jSQYEOVPSxZN97GaaR6sGkOY
	KFydSyQlP1Ax9JQ3mfVA1wBLctFcw1vP0GO4l1HGvia6s/HTAJTPpp40864dlNWqgr3okpv09VRhX
	wQjmjeAw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w8RBY-0000o0-0T;
	Fri, 03 Apr 2026 01:10:48 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v11 13/14] netkit: Add xsk support for af_xdp applications
Date: Fri,  3 Apr 2026 01:10:30 +0200
Message-ID: <20260402231031.447597-14-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402231031.447597-1-daniel@iogearbox.net>
References: <20260402231031.447597-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27959/Thu Apr  2 08:25:45 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274760-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ebpf.io:url,blackwall.org:email,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,davidwei.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lpc.events:url]
X-Rspamd-Queue-Id: E522C38F276
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable support for AF_XDP applications to operate on a netkit device.
The goal is that AF_XDP applications can natively consume AF_XDP
from network namespaces. The use-case from Cilium side is to support
Kubernetes KubeVirt VMs through QEMU's AF_XDP backend. KubeVirt is a
virtual machine management add-on for Kubernetes which aims to provide
a common ground for virtualization. KubeVirt spawns the VMs inside
Kubernetes Pods which reside in their own network namespace just like
regular Pods.

Raw QEMU AF_XDP backend example with eth0 being a physical device with
16 queues where netkit is bound to the last queue (for multi-queue RSS
context can be used if supported by the driver):

  # ethtool -X eth0 start 0 equal 15
  # ethtool -X eth0 start 15 equal 1 context new
  # ethtool --config-ntuple eth0 flow-type ether \
            src 00:00:00:00:00:00 \
            src-mask ff:ff:ff:ff:ff:ff \
            dst $mac dst-mask 00:00:00:00:00:00 \
            proto 0 proto-mask 0xffff action 15
  [ ... setup BPF/XDP prog on eth0 to steer into shared xsk map ... ]
  # ip netns add foo
  # ip link add numrxqueues 2 nk type netkit single
  # ynl --family netdev --output-json --do queue-create \
        --json "{"ifindex": $(ifindex nk), "type": "rx", \
                 "lease": { "ifindex": $(ifindex eth0), \
                            "queue": { "type": "rx", "id": 15 } } }"
  {'id': 1}
  # ip link set nk netns foo
  # ip netns exec foo ip link set lo up
  # ip netns exec foo ip link set nk up
  # ip netns exec foo qemu-system-x86_64 \
          -kernel $kernel \
          -drive file=${image_name},index=0,media=disk,format=raw \
          -append "root=/dev/sda rw console=ttyS0" \
          -cpu host \
          -m $memory \
          -enable-kvm \
          -device virtio-net-pci,netdev=net0,mac=$mac \
          -netdev af-xdp,ifname=nk,id=net0,mode=native,queues=1,start-queue=1,inhibit=on,map-path=$dir/xsks_map \
          -nographic

We have tested the above against a dual-port Nvidia ConnectX-6 (mlx5)
100G NIC with successful network connectivity out of QEMU. An earlier
iteration of this work was presented at LSF/MM/BPF [0] and more
recently at LPC [1].

For getting to a first starting point to connect all things with
KubeVirt, bind mounting the xsk map from Cilium into the VM launcher
Pod which acts as a regular Kubernetes Pod while not perfect, is not
a big problem given its out of reach from the application sitting
inside the VM (and some of the control plane aspects are baked in
the launcher Pod already), so the isolation barrier is still the VM.
Eventually the goal is to have a XDP/XSK redirect extension where
there is no need to have the xsk map, and the BPF program can just
derive the target xsk through the queue where traffic was received
on.

The exposure through netkit is because Cilium should not act as a
proxy handing out xsk sockets. Existing applications expect a netdev
from kernel side and should not need to rewrite just to implement
against a CNI's protocol. Also, all the memory should not be accounted
against Cilium but rather the application Pod itself which is consuming
AF_XDP. Further, on up/downgrades we expect the data plane to being
completely decoupled from the control plane; if Cilium would own the
sockets that would be disruptive. Another use-case which opens up and
is regularly asked from users would be to have DPDK applications on
top of AF_XDP in regular Kubernetes Pods.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
Link: https://lpc.events/event/19/contributions/2275/ [1]
---
 drivers/net/netkit.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 1ec21aef348f..5619209329d5 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -12,6 +12,7 @@
 #include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
+#include <net/xdp_sock_drv.h>
 #include <net/netkit.h>
 #include <net/dst.h>
 #include <net/tcx.h>
@@ -236,6 +237,86 @@ static void netkit_get_stats(struct net_device *dev,
 	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
 }
 
+static bool netkit_xsk_supported_at_phys(const struct net_device *dev)
+{
+	if (!dev->netdev_ops->ndo_bpf ||
+	    !dev->netdev_ops->ndo_xdp_xmit ||
+	    !dev->netdev_ops->ndo_xsk_wakeup)
+		return false;
+	return true;
+}
+
+static int netkit_xsk(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	struct netkit *nk = netkit_priv(dev);
+	struct netdev_bpf xdp_lower;
+	struct netdev_rx_queue *rxq;
+	struct net_device *phys;
+	bool create = false;
+	int ret = -EBUSY;
+
+	switch (xdp->command) {
+	case XDP_SETUP_XSK_POOL:
+		if (nk->pair == NETKIT_DEVICE_PAIR)
+			return -EOPNOTSUPP;
+		if (xdp->xsk.queue_id >= dev->real_num_rx_queues)
+			return -EINVAL;
+
+		rxq = __netif_get_rx_queue(dev, xdp->xsk.queue_id);
+		if (!rxq->lease)
+			return -EOPNOTSUPP;
+
+		phys = rxq->lease->dev;
+		if (!netkit_xsk_supported_at_phys(phys))
+			return -EOPNOTSUPP;
+
+		create = xdp->xsk.pool;
+		memcpy(&xdp_lower, xdp, sizeof(xdp_lower));
+		xdp_lower.xsk.queue_id = get_netdev_rx_queue_index(rxq->lease);
+		break;
+	case XDP_SETUP_PROG:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
+
+	netdev_lock(phys);
+	if (create &&
+	    (phys->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+	if (!create || !dev_get_min_mp_channel_count(phys))
+		ret = phys->netdev_ops->ndo_bpf(phys, &xdp_lower);
+out:
+	netdev_unlock(phys);
+	return ret;
+}
+
+static int netkit_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
+{
+	struct netdev_rx_queue *rxq, *rxq_lease;
+	struct net_device *phys;
+
+	if (queue_id >= dev->real_num_rx_queues)
+		return -EINVAL;
+
+	rxq = __netif_get_rx_queue(dev, queue_id);
+	rxq_lease = READ_ONCE(rxq->lease);
+	if (unlikely(!rxq_lease))
+		return -EOPNOTSUPP;
+
+	/* netkit_xsk already validated full xsk support, hence it's
+	 * fine to call into ndo_xsk_wakeup right away given this
+	 * was a prerequisite to get here in the first place. The
+	 * phys xsk support cannot change without tearing down the
+	 * device (which clears the lease first).
+	 */
+	phys = rxq_lease->dev;
+	return phys->netdev_ops->ndo_xsk_wakeup(phys,
+			get_netdev_rx_queue_index(rxq_lease), flags);
+}
+
 static int netkit_init(struct net_device *dev)
 {
 	netdev_lockdep_set_classes(dev);
@@ -256,6 +337,8 @@ static const struct net_device_ops netkit_netdev_ops = {
 	.ndo_get_peer_dev	= netkit_peer_dev,
 	.ndo_get_stats64	= netkit_get_stats,
 	.ndo_uninit		= netkit_uninit,
+	.ndo_bpf		= netkit_xsk,
+	.ndo_xsk_wakeup		= netkit_xsk_wakeup,
 	.ndo_features_check	= passthru_features_check,
 };
 
@@ -569,6 +652,9 @@ static int netkit_new_link(struct net_device *dev,
 	nk->headroom = headroom;
 	bpf_mprog_bundle_init(&nk->bundle);
 
+	if (pair == NETKIT_DEVICE_SINGLE)
+		xdp_set_features_flag(dev, NETDEV_XDP_ACT_XSK);
+
 	err = register_netdevice(dev);
 	if (err < 0)
 		goto err_configure_peer;
-- 
2.43.0


