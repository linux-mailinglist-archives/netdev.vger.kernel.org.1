Return-Path: <netdev+bounces-270089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOysAUjIvWkrBgMAu9opvQ
	(envelope-from <netdev+bounces-270089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:20:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7C52E1B5F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F05CA301DD8F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBB2387369;
	Fri, 20 Mar 2026 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="myBo7FEz"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA02D8DC3;
	Fri, 20 Mar 2026 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045129; cv=none; b=AfY+3XC4lyT6AzddG3QTl8rFxVOpt2MRCsiTlg/3PKYuY638+J7o+V9NZkktIEFgBoLJZsJbOYSyOSW6O0xXKFV6ZXqSXpR/QD52sk0nM507ZFQf07pluXr8e3iEnSYiaKMTvjo84ic3eWmEBYhcYJZ5TCUPTLKWi2jbe5ICiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045129; c=relaxed/simple;
	bh=QsXsVkDtDLUwbQXGo9PB1X7MIClUMrzSTV1jSkUiBo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R34iADWiZTLLYksQ/0Q0ZuaEmkuaut1mabMTP+f/K5rgL+YokUHa/RoSzBdPmCJ3g9Lb1E8dz9PhEP271JeZjuKOngjNVqvrhO6rHtrzjIIkaS+dyQsPBDcGqe4Ql8AsI5YbmhKtu3cmocYaSZ4QFEIcYgHAgRN6FPiAK8mJGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=myBo7FEz; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=x9m7vS01pD3CgOvMdFkqYIDyszzmILWbph86qLbyOzc=; b=myBo7FEz73j88FZnVDkW75F7ry
	YujbpVCBPYVdSa6CgnPkL+F+zJ7y8k7+87dE49R8a+3ci6iwHA1DPmxkqMM4YYOFk8RTCOlSAhGG3
	gBJx+Hu78rwyMkyJ9FOY4MmLRgSUW/yCGpf8Wu15omfJJc/a9bGUNcjVO9qg4J4Q0XyJmMGvAEMOA
	bV1C9f7FAF+Ieo9fXCPGIPibgWEZ+OAQaJSs53ATDZ8w0t+zMO6W1N6OO5PE0c9sOzPjphgFy7zYa
	FSYfoihLV1WgnP2RBBMlvB+PvF5KDt+EIcYAoI+Ul2+g/dmzC6WNvFjlWESwge3HN6qTo2t0zPAnW
	YL+5VO4Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w3iAp-000H13-28;
	Fri, 20 Mar 2026 23:18:31 +0100
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
Subject: [PATCH net-next v9 13/14] netkit: Add xsk support for af_xdp applications
Date: Fri, 20 Mar 2026 23:18:13 +0100
Message-ID: <20260320221814.236775-14-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320221814.236775-1-daniel@iogearbox.net>
References: <20260320221814.236775-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27946/Fri Mar 20 07:24:31 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270089-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,blackwall.org:email,davidwei.uk:email,lpc.events:url]
X-Rspamd-Queue-Id: 6E7C52E1B5F
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
 drivers/net/netkit.c | 77 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 018734c9897b..d7bb0ceb0db1 100644
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
@@ -235,6 +236,77 @@ static void netkit_get_stats(struct net_device *dev,
 	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
 }
 
+static bool netkit_xsk_supported_at_phys(const struct net_device *dev)
+{
+	if (!dev->netdev_ops->ndo_bpf ||
+	    !dev->netdev_ops->ndo_xdp_xmit ||
+	    !dev->netdev_ops->ndo_xsk_wakeup)
+		return false;
+	if ((dev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK)
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
+		memcpy(&xdp_lower, xdp, sizeof(xdp_lower));
+		xdp_lower.xsk.queue_id = get_netdev_rx_queue_index(rxq->lease);
+		break;
+	case XDP_SETUP_PROG:
+		return -EPERM;
+	default:
+		return -EINVAL;
+	}
+
+	netdev_lock(phys);
+	if (!dev_get_min_mp_channel_count(phys))
+		ret = phys->netdev_ops->ndo_bpf(phys, &xdp_lower);
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
+	if (!rxq_lease)
+		return -EOPNOTSUPP;
+
+	phys = rxq_lease->dev;
+	if (!netkit_xsk_supported_at_phys(phys))
+		return -EOPNOTSUPP;
+
+	return phys->netdev_ops->ndo_xsk_wakeup(phys,
+			get_netdev_rx_queue_index(rxq_lease), flags);
+}
+
 static int netkit_init(struct net_device *dev)
 {
 	netdev_lockdep_set_classes(dev);
@@ -255,6 +327,8 @@ static const struct net_device_ops netkit_netdev_ops = {
 	.ndo_get_peer_dev	= netkit_peer_dev,
 	.ndo_get_stats64	= netkit_get_stats,
 	.ndo_uninit		= netkit_uninit,
+	.ndo_bpf		= netkit_xsk,
+	.ndo_xsk_wakeup		= netkit_xsk_wakeup,
 	.ndo_features_check	= passthru_features_check,
 };
 
@@ -390,10 +464,11 @@ static void netkit_setup(struct net_device *dev)
 	dev->hw_enc_features = netkit_features;
 	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
 	dev->vlan_features = dev->features & ~netkit_features_hw_vlan;
-
 	dev->needs_free_netdev = true;
 
 	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
+	xdp_set_features_flag(dev, NETDEV_XDP_ACT_XSK);
 }
 
 static struct net *netkit_get_link_net(const struct net_device *dev)
-- 
2.43.0


