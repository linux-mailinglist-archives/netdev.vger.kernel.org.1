Return-Path: <netdev+bounces-85341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 620D889A53E
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 21:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860231C20E9C
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80C6173353;
	Fri,  5 Apr 2024 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k115wlmf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16840173354
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346693; cv=none; b=dSDYW8NrKD+NbINw+VRHjNEbRhOBBiLrOOHMB/bitODezryXA9g+5PSVxpCavGIk8aMjFtqpg4bfEyHVVKgZeYpy4eJ2nt6TjQTPKA8VFPPbsQzxH45dSYO8VI+SRo005ukQWOOgK819361yGIYDi4TQXJzwLfmUlQ7ZIE2/bco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346693; c=relaxed/simple;
	bh=VYrfrtQMnr7SvlUX3uUavwQYUeEP+/CPRtN5/mtYdZw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLY4Nfp+bJtLcujWIpjONW58TqO94zFtOgUnzz/Zg4QEOLVb42l4NJ/uKug6CiwjMzu4tK9d+3T8ezIiP4Wfdr9HvFPAKu9YgfC/Lb5WFDA+zgogaQdISgSUCwrRWD0eZAvA52WIDurVsQ6UpTW3AVBKIftu5ixhr+bLu4nT7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k115wlmf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712346693; x=1743882693;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYrfrtQMnr7SvlUX3uUavwQYUeEP+/CPRtN5/mtYdZw=;
  b=k115wlmfQjlE8lQHkpxSbht06/JlSxmdokndluB5Z+Gzs1qljgqaRfJy
   jtuDTGVPEsyIMm9P9DEPFzffPWSk/DFPCav2XNGi+kWEY+iChSzrYPxvO
   ISc/NRaUTooob4CDAnPkHa0IF4hgFfzkHOnULFwdjryU57DpP9OSBmmM6
   48+NH7vA70sFeON/MuiwjJ70vOAwY0MZUJGZTVnVDCtyiDRXtkX0+umxP
   4ZTB+JtKGn1tqcrKc3QjH0nhmUGfdKSpJmXg/cUILse/CJHu5W4Aig2cF
   a+fa6hPQ4f7llrYcUf/b6gQB6oEP3sTDnH08z4c52MxDEuvSuqQ032CAY
   Q==;
X-CSE-ConnectionGUID: wyrh5zMCRG2ZnaOpYX79mQ==
X-CSE-MsgGUID: ec7UHl5MQ06g3X2E7Kw81w==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7817639"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7817639"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 12:51:32 -0700
X-CSE-ConnectionGUID: fsXxWCO6QDS2GMW8BWplHQ==
X-CSE-MsgGUID: nNyAc9cISbKh8fJPr57Q0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19700651"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orviesa006.jf.intel.com with ESMTP; 05 Apr 2024 12:51:32 -0700
Subject: [net-next,
 RFC PATCH 2/5] netdev-genl: Add netlink framework functions for
 queue-set NAPI
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: edumazet@google.com, pabeni@redhat.com, ast@kernel.org, sdf@google.com,
 lorenzo@kernel.org, tariqt@nvidia.com, daniel@iogearbox.net,
 anthony.l.nguyen@intel.com, lucien.xin@gmail.com, hawk@kernel.org,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 05 Apr 2024 13:09:38 -0700
Message-ID: <171234777883.5075.17163018772262453896.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
References: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Implement the netdev netlink framework functions for associating
a queue with NAPI ID.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 include/linux/netdevice.h |    7 +++
 net/core/netdev-genl.c    |  117 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 108 insertions(+), 16 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0c198620ac93..70df1cec4a60 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1351,6 +1351,10 @@ struct netdev_net_notifier {
  *			   struct kernel_hwtstamp_config *kernel_config,
  *			   struct netlink_ext_ack *extack);
  *	Change the hardware timestamping parameters for NIC device.
+ *
+ * int (*ndo_queue_set_napi)(struct net_device *dev, u32 q_idx, u32 q_type,
+ *			     struct napi_struct *napi);
+ *	Change the NAPI instance associated with the queue.
  */
 struct net_device_ops {
 	int			(*ndo_init)(struct net_device *dev);
@@ -1596,6 +1600,9 @@ struct net_device_ops {
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config,
 						    struct netlink_ext_ack *extack);
+	int			(*ndo_queue_set_napi)(struct net_device *dev,
+						      u32 q_idx, u32 q_type,
+						      struct napi_struct *napi);
 };
 
 /**
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index d5b2e90e5709..6b3d3165d76e 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -288,12 +288,29 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+/* must be called under rtnl_lock() */
+static struct napi_struct *
+napi_get_by_queue(struct net_device *netdev, u32 q_idx, u32 q_type)
+{
+	struct netdev_rx_queue *rxq;
+	struct netdev_queue *txq;
+
+	switch (q_type) {
+	case NETDEV_QUEUE_TYPE_RX:
+		rxq = __netif_get_rx_queue(netdev, q_idx);
+		return rxq->napi;
+	case NETDEV_QUEUE_TYPE_TX:
+		txq = netdev_get_tx_queue(netdev, q_idx);
+		return txq->napi;
+	}
+	return NULL;
+}
+
 static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
 {
-	struct netdev_rx_queue *rxq;
-	struct netdev_queue *txq;
+	struct napi_struct *napi;
 	void *hdr;
 
 	hdr = genlmsg_iput(rsp, info);
@@ -305,19 +322,9 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
 		goto nla_put_failure;
 
-	switch (q_type) {
-	case NETDEV_QUEUE_TYPE_RX:
-		rxq = __netif_get_rx_queue(netdev, q_idx);
-		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
-					     rxq->napi->napi_id))
-			goto nla_put_failure;
-		break;
-	case NETDEV_QUEUE_TYPE_TX:
-		txq = netdev_get_tx_queue(netdev, q_idx);
-		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
-					     txq->napi->napi_id))
-			goto nla_put_failure;
-	}
+	napi = napi_get_by_queue(netdev, q_idx, q_type);
+	if (napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID, napi->napi_id))
+		goto nla_put_failure;
 
 	genlmsg_end(rsp, hdr);
 
@@ -674,9 +681,87 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
+static int
+netdev_nl_queue_set_napi(struct sk_buff *rsp, struct net_device *netdev,
+			 u32 q_idx, u32 q_type, u32 napi_id,
+			 const struct genl_info *info)
+{
+	struct napi_struct *napi, *old_napi;
+	int err;
+
+	if (!(netdev->flags & IFF_UP))
+		return 0;
+
+	err = netdev_nl_queue_validate(netdev, q_idx, q_type);
+	if (err)
+		return err;
+
+	old_napi = napi_get_by_queue(netdev, q_idx, q_type);
+	if (old_napi && old_napi->napi_id == napi_id)
+		return 0;
+
+	napi = napi_by_id(napi_id);
+	if (!napi)
+		return -EINVAL;
+
+	err = netdev->netdev_ops->ndo_queue_set_napi(netdev, q_idx, q_type, napi);
+
+	return err;
+}
+
 int netdev_nl_queue_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	u32 q_id, q_type, ifindex;
+	struct net_device *netdev;
+	struct sk_buff *rsp;
+	u32 napi_id = 0;
+	int err = 0;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
+		return -EINVAL;
+
+	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_ID]);
+	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]);
+	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
+
+	if (info->attrs[NETDEV_A_QUEUE_NAPI_ID]) {
+		napi_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_NAPI_ID]);
+		if (napi_id < MIN_NAPI_ID)
+			return -EINVAL;
+	}
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	rtnl_lock();
+
+	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
+	if (netdev) {
+		if (!napi_id)
+			GENL_SET_ERR_MSG(info, "No queue parameters changed\n");
+		else
+			err = netdev_nl_queue_set_napi(rsp, netdev, q_id,
+						       q_type, napi_id, info);
+		if (!err)
+			err = netdev_nl_queue_fill_one(rsp, netdev, q_id,
+						       q_type, info);
+	} else {
+		err = -ENODEV;
+	}
+
+	rtnl_unlock();
+
+	if (err)
+		goto err_free_msg;
+
+	return genlmsg_reply(rsp, info);
+
+err_free_msg:
+	nlmsg_free(rsp);
+	return err;
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,


