Return-Path: <netdev+bounces-254924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPjXCmHfe2ljJAIAu9opvQ
	(envelope-from <netdev+bounces-254924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:29:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D12B54EA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 591303032758
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587836BCC2;
	Thu, 29 Jan 2026 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="R7B/vUXx"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783FB36A030;
	Thu, 29 Jan 2026 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725736; cv=none; b=YZkGN0sQtCFzbafI4QCpfdR+9Yb8fUvwmVzc1RpwQmh8J+2BxcU+HQ8JeQ0CZwjsLpp7qFSy7HS/E+pkXsGt3mKDsMQc4Z3auFaGcnDH68sIMHLuojatJVtjb89iVn6pibTsz1/3cLAhXABt4NJGCq8H2fxMlrMWWwbzYlgYdEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725736; c=relaxed/simple;
	bh=eX7ctvUWCMIs4ntGXYSJAdE/AMDfgjF+XD+meSCJ/dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa+lhHyEZhA/lQ/JTArJDSRjpuoHrRumILBAhPYTvk9IM+FoNfQfCpNpl7400hVhmQtsz+dQcSvLobIhHWHT1MeYop/H+jWIp7lBY3v2lPnaWl9ZnfdPH9HlOKesa4ZZkANrtcwX4MTUbcO22qdJSvb37BHhxyHdkhFJPcWZWjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=R7B/vUXx; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pFl0cvMwMPbXG0gDv+TstYvJsLM44WeRBnGzNoWdOuU=; b=R7B/vUXx+6TcPpOCbf+jOWvSTO
	vLXFMsFuveHPEtRpqUcbax7hF5b8twxYSFQO97cuoqNPYTspWqEZv7vcdmYsfMQYR7lLhvWuf9how
	TQ+bNh+Z96S2ZSjsHfmhH7MlkxtCaHZsyDMcP0gVA+roxANefC6oR9dApszap6j2/oOF+l8o4/+6A
	kISXuUvs3teGVnCOOCKekA6q6SlgrutIMxvN8RQPCIqt7AQWdcEfEMY/ijAdt82a2SopHlbfngfDq
	XIbZvziCzm7dWS5VVrYVNeZD0fPFv4LvLmgJnXUzN2TUB0frL/so8Mwy3dCseE/e5Jd64Z+z2zrOJ
	v5ED+0AQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vlaV9-0008of-21;
	Thu, 29 Jan 2026 23:28:35 +0100
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
Subject: [PATCH net-next v8 03/16] net: Add lease info to queue-get response
Date: Thu, 29 Jan 2026 23:28:17 +0100
Message-ID: <20260129222830.439687-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129222830.439687-1-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27896/Thu Jan 29 08:24:11 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254924-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email,iogearbox.net:dkim,iogearbox.net:mid,blackwall.org:email,fomichev.me:email,none:email]
X-Rspamd-Queue-Id: 85D12B54EA
X-Rspamd-Action: no action

Populate nested lease info to the queue-get response that returns the
ifindex, queue id with type and optionally netns id if the device
resides in a different netns.

Example with ynl client:

  # ip a
  [...]
  4: enp10s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 xdp/id:24 qdisc mq state UP group default qlen 1000
    link/ether e8:eb:d3:a3:43:f6 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.2/24 scope global enp10s0f0np0
       valid_lft forever preferred_lft forever
    inet6 fe80::eaeb:d3ff:fea3:43f6/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
  [...]

  # ethtool -i enp10s0f0np0
  driver: mlx5_core
  [...]

  # ./pyynl/cli.py \
      --spec ~/netlink/specs/netdev.yaml \
      --do queue-get \
      --json '{"ifindex": 4, "id": 15, "type": "rx"}'
  {'id': 15,
   'ifindex': 4,
   'lease': {'ifindex': 8, 'netns-id': 0, 'queue': {'id': 1, 'type': 'rx'}},
   'napi-id': 8227,
   'type': 'rx',
   'xsk': {}}

  # ip netns list
  foo (id: 0)

  # ip netns exec foo ip a
  [...]
  8: nk@NONE: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
      inet6 fe80::200:ff:fe00:0/64 scope link proto kernel_ll
         valid_lft forever preferred_lft forever
  [...]

  # ip netns exec foo ethtool -i nk
  driver: netkit
  [...]

  # ip netns exec foo ls /sys/class/net/nk/queues/
  rx-0  rx-1  tx-0

  # ip netns exec foo ./pyynl/cli.py \
      --spec ~/netlink/specs/netdev.yaml \
      --do queue-get \
      --json '{"ifindex": 8, "id": 1, "type": "rx"}'
  {'id': 1, 'ifindex': 8, 'type': 'rx'}

Note that the caller of netdev_nl_queue_fill_one() holds the netdevice
lock. For the queue-get we do not lock both devices. When queues get
{un,}leased, both devices are locked, thus if __netif_get_rx_queue_peer()
returns true, the lease pointer points to a valid device. The netns-id
is fetched via peernet2id_alloc() similarly as done in OVS.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/netdev_rx_queue.h | 10 ++++++++
 net/core/netdev-genl.c        | 36 ++++++++++++++++++++++++++++
 net/core/netdev_rx_queue.c    | 45 +++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 967bec9b3c6a..589192f67d97 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -65,4 +65,14 @@ void netdev_rx_queue_lease(struct netdev_rx_queue *rxq_dst,
 			   struct netdev_rx_queue *rxq_src);
 void netdev_rx_queue_unlease(struct netdev_rx_queue *rxq_dst,
 			     struct netdev_rx_queue *rxq_src);
+bool netif_rx_queue_lease_get_owner(struct net_device **dev, unsigned int *rxq);
+
+enum netif_lease_dir {
+	NETIF_VIRT_TO_PHYS,
+	NETIF_PHYS_TO_VIRT,
+};
+
+struct netdev_rx_queue *
+__netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq,
+			   enum netif_lease_dir dir);
 #endif /* _LINUX_NETDEV_RX_QUEUE_H */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a0b4a9197b91..7d073894ca74 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -391,8 +391,11 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
 {
 	struct pp_memory_provider_params *params;
+	struct net_device *orig_netdev = netdev;
+	struct nlattr *nest_lease, *nest_queue;
 	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
+	u32 lease_q_idx = q_idx;
 	void *hdr;
 
 	hdr = genlmsg_iput(rsp, info);
@@ -410,6 +413,37 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		if (nla_put_napi_id(rsp, rxq->napi))
 			goto nla_put_failure;
 
+		if (netif_rx_queue_lease_get_owner(&netdev, &lease_q_idx)) {
+			struct net *net, *peer_net;
+
+			nest_lease = nla_nest_start(rsp, NETDEV_A_QUEUE_LEASE);
+			if (!nest_lease)
+				goto nla_put_failure;
+			nest_queue = nla_nest_start(rsp, NETDEV_A_LEASE_QUEUE);
+			if (!nest_queue)
+				goto nla_put_failure;
+			if (nla_put_u32(rsp, NETDEV_A_QUEUE_ID, lease_q_idx))
+				goto nla_put_failure;
+			if (nla_put_u32(rsp, NETDEV_A_QUEUE_TYPE, q_type))
+				goto nla_put_failure;
+			nla_nest_end(rsp, nest_queue);
+			if (nla_put_u32(rsp, NETDEV_A_LEASE_IFINDEX,
+					READ_ONCE(netdev->ifindex)))
+				goto nla_put_failure;
+			rcu_read_lock();
+			peer_net = dev_net_rcu(netdev);
+			net = dev_net_rcu(orig_netdev);
+			if (!net_eq(net, peer_net)) {
+				s32 id = peernet2id_alloc(net, peer_net, GFP_ATOMIC);
+
+				if (nla_put_s32(rsp, NETDEV_A_LEASE_NETNS_ID, id))
+					goto nla_put_failure_unlock;
+			}
+			rcu_read_unlock();
+			nla_nest_end(rsp, nest_lease);
+			netdev = orig_netdev;
+		}
+
 		params = &rxq->mp_params;
 		if (params->mp_ops &&
 		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
@@ -437,6 +471,8 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 
 	return 0;
 
+nla_put_failure_unlock:
+	rcu_read_unlock();
 nla_put_failure:
 	genlmsg_cancel(rsp, hdr);
 	return -EMSGSIZE;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index a1f23c2c96d4..7319de3ced2b 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -41,6 +41,51 @@ bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx)
 	return false;
 }
 
+static bool netif_lease_dir_ok(const struct net_device *dev,
+			       enum netif_lease_dir dir)
+{
+	if (dir == NETIF_VIRT_TO_PHYS && !dev->dev.parent)
+		return true;
+	if (dir == NETIF_PHYS_TO_VIRT && dev->dev.parent)
+		return true;
+	return false;
+}
+
+struct netdev_rx_queue *
+__netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq_idx,
+			   enum netif_lease_dir dir)
+{
+	struct net_device *orig_dev = *dev;
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(orig_dev, *rxq_idx);
+
+	if (rxq->lease) {
+		if (!netif_lease_dir_ok(orig_dev, dir))
+			return NULL;
+		rxq = rxq->lease;
+		*rxq_idx = get_netdev_rx_queue_index(rxq);
+		*dev = rxq->dev;
+	}
+	return rxq;
+}
+
+bool netif_rx_queue_lease_get_owner(struct net_device **dev,
+				    unsigned int *rxq_idx)
+{
+	struct net_device *orig_dev = *dev;
+	struct netdev_rx_queue *rxq;
+
+	/* The physical device needs to be locked. If there is indeed a lease,
+	 * then the virtual device holds a reference on the physical device
+	 * and the lease stays active until the virtual device is torn down.
+	 * When queues get {un,}leased both devices are always locked.
+	 */
+	netdev_ops_assert_locked(orig_dev);
+	rxq = __netif_get_rx_queue_lease(dev, rxq_idx, NETIF_PHYS_TO_VIRT);
+	if (rxq && orig_dev != *dev)
+		return true;
+	return false;
+}
+
 /* See also page_pool_is_unreadable() */
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx)
 {
-- 
2.43.0


