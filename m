Return-Path: <netdev+bounces-276725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJUjM+rS1mkCJAgAu9opvQ
	(envelope-from <netdev+bounces-276725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 00:12:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 397433C44B4
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 00:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4ADB30166FE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C648D3815D9;
	Wed,  8 Apr 2026 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZgV/xed"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D15EED8;
	Wed,  8 Apr 2026 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686375; cv=none; b=cDZmVuNpYzpk9VNU0ILQxcNWv+VvDRsL/xavOMXk44lH/P5VEM5JT5PM29xL/Pl9d4N5YFaEJ4aEEbmt9ZeIeniaZDdYJGWNIIpYeYCY6++QsuxPyc4rci//w8ekTE0O3yV3C2MgbJYVyiw80oqLoGIbjoWlWwmgpBvc4JQaBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686375; c=relaxed/simple;
	bh=kpfDRdBg+JA4L4Y74DwFMPETPgg4c1leB+nWLe4qro8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kp5iTe2Q1/gIu+faZceHMQmW1rZcEz0Yj5Ayr2Yzt5emFNLwyE7SKvneKgmsscM2sf/CD0nM6uVKioa8k1pQezJx2zwtCcAfv8Kjt/TsGKyGv7zKWuo/zjTLDvJQqccOVzn68DIhkcejEWZYO9TjK2V8zH1qmnYL9FI577ueFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZgV/xed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00752C19421;
	Wed,  8 Apr 2026 22:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775686375;
	bh=kpfDRdBg+JA4L4Y74DwFMPETPgg4c1leB+nWLe4qro8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gZgV/xedtuRb2ExiLa3JSK45QmxBtDEzKiY9RgTYL3GurqSj2MrfBiXPRRLs85Ulj
	 AgSja+0dDq2xrDD2frHovX6+jBKLmzondxxyQXX7nntxwd8JoNJhWOeKs8tRygy19q
	 Jw7Bhg2TJmyY8EKnYI7yvtjzwRl6VMEczIQ7/g8y5OVygVL+8FvgQN/k6axOdXsZ6l
	 yn/UhkIWeOk6a2rGz45ENgr2yHDijeXJ0S6I+Op1pfyVSkOEJcHvBanrUUEw4jdnfq
	 elLssA1iHU2IDchLiA4QLvcLWeFqSo1g8sWSucn+K6+vkSAtTez8h41IqCUe93Tm32
	 ZD0bRLfcilC2Q==
Date: Wed, 8 Apr 2026 15:12:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v11 03/14] net: Add lease info to queue-get
 response
Message-ID: <20260408151251.72bd2482@kernel.org>
In-Reply-To: <b9a046f8-cb02-4d54-9a7e-e8213339d720@iogearbox.net>
References: <20260402231031.447597-1-daniel@iogearbox.net>
	<20260402231031.447597-4-daniel@iogearbox.net>
	<20260407204017.3fc79d1b@kernel.org>
	<b9a046f8-cb02-4d54-9a7e-e8213339d720@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276725-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 397433C44B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 11:09:34 +0200 Daniel Borkmann wrote:
> >> +void netif_put_rx_queue_lease_locked(struct net_device *orig_dev,
> >> +				     struct net_device *dev)
> >> +{
> >> +	if (orig_dev != dev)
> >> +		netdev_unlock(dev);
> >> +}  
> > 
> > Pretty sure I already complained about these ugly helpers.
> > I'll try to find the time tomorrow to come up with something better.   
> 
> Ok, sounds good. Happy to adapt if you find something better and then I'll
> work this into the series, and also integrate the things mentioned in my
> cover letter reply (netkit nl dump + additional tests).

Hi! How would you feel about something like the following on top?

--->8----------

net: remove the netif_get_rx_queue_lease_locked() helpers

The netif_get_rx_queue_lease_locked() API hides the locking
and the descend onto the leased queue. Making the code
harder to follow (at least to me). Remove the API and open
code the descend a bit. Most of the code now looks like:

 if (!leased)
     return __helper(x);

 hw_rxq = ..
 netdev_lock(hw_rxq->dev);
 ret = __helper(x);
 netdev_unlock(hw_rxq->dev);

 return ret;

Of course if we have more code paths that need the wrapping
we may need to revisit. For now, IMHO, having to know what
netif_get_rx_queue_lease_locked() does is not worth the 20LoC
it saves.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_rx_queue.h |  5 ---
 net/core/dev.h                |  1 +
 net/core/netdev-genl.c        | 59 +++++++++++++++++----------
 net/core/netdev_queues.c      | 14 ++++---
 net/core/netdev_rx_queue.c    | 48 +++++++---------------
 net/xdp/xsk.c                 | 77 ++++++++++++++++++++++-------------
 6 files changed, 111 insertions(+), 93 deletions(-)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 7e98c679ea84..9415a94d333d 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -76,11 +76,6 @@ struct netdev_rx_queue *
 __netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq,
 			   enum netif_lease_dir dir);
 
-struct netdev_rx_queue *
-netif_get_rx_queue_lease_locked(struct net_device **dev, unsigned int *rxq);
-void netif_put_rx_queue_lease_locked(struct net_device *orig_dev,
-				     struct net_device *dev);
-
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
 void netdev_rx_queue_lease(struct netdev_rx_queue *rxq_dst,
 			   struct netdev_rx_queue *rxq_src);
diff --git a/net/core/dev.h b/net/core/dev.h
index 95edb2d4eff8..376bac4a82da 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -101,6 +101,7 @@ int netdev_queue_config_validate(struct net_device *dev, int rxq_idx,
 
 bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx);
 bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx);
+bool netif_is_queue_leasee(const struct net_device *dev);
 
 void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
 			      const struct pp_memory_provider_params *p);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 056460d01940..b8f6076d8007 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -395,8 +395,7 @@ netdev_nl_queue_fill_lease(struct sk_buff *rsp, struct net_device *netdev,
 	struct netdev_rx_queue *rxq;
 	struct net *net, *peer_net;
 
-	rxq = __netif_get_rx_queue_lease(&netdev, &q_idx,
-					 NETIF_PHYS_TO_VIRT);
+	rxq = __netif_get_rx_queue_lease(&netdev, &q_idx, NETIF_PHYS_TO_VIRT);
 	if (!rxq || orig_netdev == netdev)
 		return 0;
 
@@ -436,13 +435,45 @@ netdev_nl_queue_fill_lease(struct sk_buff *rsp, struct net_device *netdev,
 	return -ENOMEM;
 }
 
+static int
+__netdev_nl_queue_fill_mp(struct sk_buff *rsp, struct netdev_rx_queue *rxq)
+{
+	struct pp_memory_provider_params *params = &rxq->mp_params;
+
+	if (params->mp_ops &&
+	    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
+		return -EMSGSIZE;
+
+#ifdef CONFIG_XDP_SOCKETS
+	if (rxq->pool)
+		if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
+			return -EMSGSIZE;
+#endif
+	return 0;
+}
+
+static int
+netdev_nl_queue_fill_mp(struct sk_buff *rsp, struct net_device *netdev,
+			struct netdev_rx_queue *rxq)
+{
+	struct netdev_rx_queue *hw_rxq;
+	int ret;
+
+	hw_rxq = rxq->lease;
+	if (!hw_rxq || !netif_is_queue_leasee(netdev))
+		return __netdev_nl_queue_fill_mp(rsp, rxq);
+
+	netdev_lock(hw_rxq->dev);
+	ret = __netdev_nl_queue_fill_mp(rsp, hw_rxq);
+	netdev_unlock(hw_rxq->dev);
+	return ret;
+}
+
 static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
 {
-	struct pp_memory_provider_params *params;
-	struct net_device *orig_netdev = netdev;
-	struct netdev_rx_queue *rxq, *rxq_lease;
+	struct netdev_rx_queue *rxq;
 	struct netdev_queue *txq;
 	void *hdr;
 
@@ -462,20 +493,8 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			goto nla_put_failure;
 		if (netdev_nl_queue_fill_lease(rsp, netdev, q_idx, q_type))
 			goto nla_put_failure;
-
-		rxq_lease = netif_get_rx_queue_lease_locked(&netdev, &q_idx);
-		if (rxq_lease)
-			rxq = rxq_lease;
-		params = &rxq->mp_params;
-		if (params->mp_ops &&
-		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
-			goto nla_put_failure_lease;
-#ifdef CONFIG_XDP_SOCKETS
-		if (rxq->pool)
-			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
-				goto nla_put_failure_lease;
-#endif
-		netif_put_rx_queue_lease_locked(orig_netdev, netdev);
+		if (netdev_nl_queue_fill_mp(rsp, netdev, rxq))
+			goto nla_put_failure;
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
@@ -493,8 +512,6 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 
 	return 0;
 
-nla_put_failure_lease:
-	netif_put_rx_queue_lease_locked(orig_netdev, netdev);
 nla_put_failure:
 	genlmsg_cancel(rsp, hdr);
 	return -EMSGSIZE;
diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index 265161e12a9c..5597af86591b 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -37,18 +37,22 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev,
 					unsigned int idx,
 					enum netdev_queue_type type)
 {
-	struct net_device *orig_dev = dev;
+	struct netdev_rx_queue *hw_rxq;
 	struct device *dma_dev;
 
 	/* Only RX side supports queue leasing today. */
 	if (type != NETDEV_QUEUE_TYPE_RX || !netif_rxq_is_leased(dev, idx))
 		return __netdev_queue_get_dma_dev(dev, idx);
-
-	if (!netif_get_rx_queue_lease_locked(&dev, &idx))
+	if (!netif_is_queue_leasee(dev))
 		return NULL;
 
-	dma_dev = __netdev_queue_get_dma_dev(dev, idx);
-	netif_put_rx_queue_lease_locked(orig_dev, dev);
+	hw_rxq = __netif_get_rx_queue(dev, idx)->lease;
+
+	netdev_lock(hw_rxq->dev);
+	idx = get_netdev_rx_queue_index(hw_rxq);
+	dma_dev = __netdev_queue_get_dma_dev(hw_rxq->dev, idx);
+	netdev_unlock(hw_rxq->dev);
+
 	return dma_dev;
 }
 
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 1d6e7e47bf0a..53cea4460768 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -57,6 +57,11 @@ static bool netif_lease_dir_ok(const struct net_device *dev,
 	return false;
 }
 
+bool netif_is_queue_leasee(const struct net_device *dev)
+{
+	return netif_lease_dir_ok(dev, NETIF_VIRT_TO_PHYS);
+}
+
 struct netdev_rx_queue *
 __netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq_idx,
 			   enum netif_lease_dir dir)
@@ -74,29 +79,6 @@ __netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq_idx,
 	return rxq;
 }
 
-struct netdev_rx_queue *
-netif_get_rx_queue_lease_locked(struct net_device **dev, unsigned int *rxq_idx)
-{
-	struct net_device *orig_dev = *dev;
-	struct netdev_rx_queue *rxq;
-
-	/* Locking order is always from the virtual to the physical device
-	 * see netdev_nl_queue_create_doit().
-	 */
-	netdev_ops_assert_locked(orig_dev);
-	rxq = __netif_get_rx_queue_lease(dev, rxq_idx, NETIF_VIRT_TO_PHYS);
-	if (rxq && orig_dev != *dev)
-		netdev_lock(*dev);
-	return rxq;
-}
-
-void netif_put_rx_queue_lease_locked(struct net_device *orig_dev,
-				     struct net_device *dev)
-{
-	if (orig_dev != dev)
-		netdev_unlock(dev);
-}
-
 /* See also page_pool_is_unreadable() */
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx)
 {
@@ -261,7 +243,6 @@ int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      const struct pp_memory_provider_params *p,
 		      struct netlink_ext_ack *extack)
 {
-	struct net_device *orig_dev = dev;
 	int ret;
 
 	if (!netdev_need_ops_lock(dev))
@@ -276,19 +257,18 @@ int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	if (!netif_rxq_is_leased(dev, rxq_idx))
 		return __netif_mp_open_rxq(dev, rxq_idx, p, extack);
 
-	if (!netif_get_rx_queue_lease_locked(&dev, &rxq_idx)) {
+	if (!__netif_get_rx_queue_lease(&dev, &rxq_idx, NETIF_VIRT_TO_PHYS)) {
 		NL_SET_ERR_MSG(extack, "rx queue leased to a virtual netdev");
 		return -EBUSY;
 	}
 	if (!dev->dev.parent) {
 		NL_SET_ERR_MSG(extack, "rx queue belongs to a virtual netdev");
-		ret = -EOPNOTSUPP;
-		goto out;
+		return -EOPNOTSUPP;
 	}
 
+	netdev_lock(dev);
 	ret = __netif_mp_open_rxq(dev, rxq_idx, p, extack);
-out:
-	netif_put_rx_queue_lease_locked(orig_dev, dev);
+	netdev_unlock(dev);
 	return ret;
 }
 
@@ -323,18 +303,18 @@ static void __netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 void netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			const struct pp_memory_provider_params *old_p)
 {
-	struct net_device *orig_dev = dev;
-
 	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
 		return;
 	if (!netif_rxq_is_leased(dev, ifq_idx))
 		return __netif_mp_close_rxq(dev, ifq_idx, old_p);
 
-	if (WARN_ON_ONCE(!netif_get_rx_queue_lease_locked(&dev, &ifq_idx)))
+	if (!__netif_get_rx_queue_lease(&dev, &ifq_idx, NETIF_VIRT_TO_PHYS)) {
+		WARN_ON_ONCE(1);
 		return;
-
+	}
+	netdev_lock(dev);
 	__netif_mp_close_rxq(dev, ifq_idx, old_p);
-	netif_put_rx_queue_lease_locked(orig_dev, dev);
+	netdev_unlock(dev);
 }
 
 void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index fe1c7899455e..616cd7b42502 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -31,6 +31,8 @@
 #include <net/netdev_rx_queue.h>
 #include <net/xdp.h>
 
+#include "../core/dev.h"
+
 #include "xsk_queue.h"
 #include "xdp_umem.h"
 #include "xsk.h"
@@ -117,20 +119,42 @@ struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
 }
 EXPORT_SYMBOL(xsk_get_pool_from_qid);
 
+static void __xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
+{
+	if (queue_id < dev->num_rx_queues)
+		dev->_rx[queue_id].pool = NULL;
+	if (queue_id < dev->num_tx_queues)
+		dev->_tx[queue_id].pool = NULL;
+}
+
 void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
 {
-	struct net_device *orig_dev = dev;
-	unsigned int id = queue_id;
+	struct netdev_rx_queue *hw_rxq;
 
-	if (id < dev->real_num_rx_queues)
-		WARN_ON_ONCE(!netif_get_rx_queue_lease_locked(&dev, &id));
+	if (!netif_rxq_is_leased(dev, queue_id))
+		return __xsk_clear_pool_at_qid(dev, queue_id);
+	WARN_ON_ONCE(!netif_is_queue_leasee(dev));
 
-	if (id < dev->num_rx_queues)
-		dev->_rx[id].pool = NULL;
-	if (id < dev->num_tx_queues)
-		dev->_tx[id].pool = NULL;
+	hw_rxq = __netif_get_rx_queue(dev, queue_id)->lease;
 
-	netif_put_rx_queue_lease_locked(orig_dev, dev);
+	netdev_lock(hw_rxq->dev);
+	queue_id = get_netdev_rx_queue_index(hw_rxq);
+	__xsk_clear_pool_at_qid(hw_rxq->dev, queue_id);
+	netdev_unlock(hw_rxq->dev);
+}
+
+static int __xsk_reg_pool_at_qid(struct net_device *dev,
+				 struct xsk_buff_pool *pool, u16 queue_id)
+{
+	if (xsk_get_pool_from_qid(dev, queue_id))
+		return -EBUSY;
+
+	if (queue_id < dev->real_num_rx_queues)
+		dev->_rx[queue_id].pool = pool;
+	if (queue_id < dev->real_num_tx_queues)
+		dev->_tx[queue_id].pool = pool;
+
+	return 0;
 }
 
 /* The buffer pool is stored both in the _rx struct and the _tx struct as we do
@@ -140,29 +164,26 @@ void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
 int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 			u16 queue_id)
 {
-	struct net_device *orig_dev = dev;
-	unsigned int id = queue_id;
-	int ret = 0;
+	struct netdev_rx_queue *hw_rxq;
+	int ret;
 
-	if (id >= max(dev->real_num_rx_queues,
-		      dev->real_num_tx_queues))
+	if (queue_id >= max(dev->real_num_rx_queues,
+			    dev->real_num_tx_queues))
 		return -EINVAL;
 
-	if (id < dev->real_num_rx_queues) {
-		if (!netif_get_rx_queue_lease_locked(&dev, &id))
-			return -EBUSY;
-		if (xsk_get_pool_from_qid(dev, id)) {
-			ret = -EBUSY;
-			goto out;
-		}
-	}
+	if (queue_id >= dev->real_num_rx_queues ||
+	    !netif_rxq_is_leased(dev, queue_id))
+		return __xsk_reg_pool_at_qid(dev, pool, queue_id);
+	if (!netif_is_queue_leasee(dev))
+		return -EBUSY;
+
+	hw_rxq = __netif_get_rx_queue(dev, queue_id)->lease;
+
+	netdev_lock(hw_rxq->dev);
+	queue_id = get_netdev_rx_queue_index(hw_rxq);
+	ret = __xsk_reg_pool_at_qid(hw_rxq->dev, pool, queue_id);
+	netdev_unlock(hw_rxq->dev);
 
-	if (id < dev->real_num_rx_queues)
-		dev->_rx[id].pool = pool;
-	if (id < dev->real_num_tx_queues)
-		dev->_tx[id].pool = pool;
-out:
-	netif_put_rx_queue_lease_locked(orig_dev, dev);
 	return ret;
 }
 
-- 
2.53.0


