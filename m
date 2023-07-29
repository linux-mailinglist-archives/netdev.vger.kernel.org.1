Return-Path: <netdev+bounces-22482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D476799B
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB99282890
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF7A392;
	Sat, 29 Jul 2023 00:32:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3AB1388
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:32:32 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8308EE48
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690590750; x=1722126750;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nncBB3t31kM6LU5KqTMFn19BzefFMgkNXWv8PCy0hhA=;
  b=JRR+Hd73R5UnTST5bsOKPjUk2JxGC5u++Sud0kBVa9pwrwZI39tQ0CVH
   T8ygdPRXtBluR9gQF8BKIfroLAKUnub1UQBYaFVn+RV+mOrrvILQ4jPNU
   lIYn+IOCX9Hbyczj9EdiaP8sl3v3ZPXRSuEQqDeu/TKeROxuO4M2ee8J0
   pD3xkMVhwnqJujJZckcAdS/yXkFOaP4KykWzp7Lnxi7Bhr8/JL88DhANU
   D+bjgbg3ZKcimGJ1xcBCMlFt6TcZTlruE7pFOVpDUNVUYS7qo5zXuEqIT
   XXJdkfYEzWlhZ+ANcQ3hMTKmM/zNIzX8+Kswa/wpPdBC2oxM1lNR+l//z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358742135"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="358742135"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:32:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="851403869"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851403869"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 17:32:30 -0700
Subject: [net-next PATCH v1 5/9] netdev-genl: Add netlink framework
 functions for napi
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 28 Jul 2023 17:47:17 -0700
Message-ID: <169059163779.3736.7602272507688648566.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement the netdev netlink framework functions for
napi support. The netdev structure tracks all the napi
instances and napi fields. The napi instances and associated
queue[s] can be retrieved this way.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 net/core/netdev-genl.c |  253 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+), 2 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index e35cfa3cd173..ca3ed6eb457b 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -8,6 +8,20 @@
 
 #include "netdev-genl-gen.h"
 
+struct netdev_nl_dump_ctx {
+	int dev_entry_hash;
+	int dev_entry_idx;
+	int napi_idx;
+};
+
+static inline struct netdev_nl_dump_ctx *
+netdev_dump_ctx(struct netlink_callback *cb)
+{
+	NL_ASSERT_DUMP_CTX_FITS(struct netdev_nl_dump_ctx);
+
+	return (struct netdev_nl_dump_ctx *)cb->ctx;
+}
+
 static int
 netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
 		   u32 portid, u32 seq, int flags, u32 cmd)
@@ -120,14 +134,249 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int
+netdev_nl_napi_fill_one(struct sk_buff *msg, struct napi_struct *napi)
+{
+	struct netdev_rx_queue *rx_queue, *rxq;
+	struct netdev_queue *tx_queue, *txq;
+	unsigned int rx_qid, tx_qid;
+	struct nlattr *napi_info;
+
+	napi_info = nla_nest_start(msg, NETDEV_A_NAPI_NAPI_INFO);
+	if (!napi_info)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(msg, NETDEV_A_NAPI_INFO_ENTRY_NAPI_ID, napi->napi_id))
+		goto nla_put_failure;
+
+	list_for_each_entry_safe(rx_queue, rxq, &napi->napi_rxq_list, q_list) {
+		rx_qid = get_netdev_rx_queue_index(rx_queue);
+		if (nla_put_u32(msg, NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES, rx_qid))
+			goto nla_put_failure;
+	}
+
+	list_for_each_entry_safe(tx_queue, txq, &napi->napi_txq_list, q_list) {
+		tx_qid = get_netdev_queue_index(tx_queue);
+		if (nla_put_u32(msg, NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES, tx_qid))
+			goto nla_put_failure;
+	}
+
+	nla_nest_end(msg, napi_info);
+	return 0;
+nla_put_failure:
+	nla_nest_cancel(msg, napi_info);
+	return -EMSGSIZE;
+}
+
+static int
+netdev_nl_napi_fill(struct net_device *netdev, struct sk_buff *msg, int *start)
+{
+	struct napi_struct *napi, *n;
+	int i = 0;
+
+	list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list) {
+		if (i < *start) {
+			i++;
+			continue;
+		}
+		if (netdev_nl_napi_fill_one(msg, napi))
+			return -EMSGSIZE;
+		*start = ++i;
+	}
+	return 0;
+}
+
+static int
+netdev_nl_napi_prepare_fill(struct net_device *netdev, u32 portid, u32 seq,
+			    int flags, u32 cmd)
+{
+	struct nlmsghdr *nlh;
+	struct sk_buff *skb;
+	bool last = false;
+	int index = 0;
+	void *hdr;
+	int err;
+
+	while (!last) {
+		int tmp_index = index;
+
+		skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+		if (!skb)
+			return -ENOMEM;
+
+		hdr = genlmsg_put(skb, portid, seq, &netdev_nl_family,
+				  flags | NLM_F_MULTI, cmd);
+		if (!hdr) {
+			err = -EMSGSIZE;
+			goto nla_put_failure;
+		}
+		err = netdev_nl_napi_fill(netdev, skb, &index);
+		if (!err)
+			last = true;
+		else if (err != -EMSGSIZE || tmp_index == index)
+			goto nla_put_failure;
+
+		genlmsg_end(skb, hdr);
+		err = genlmsg_unicast(dev_net(netdev), skb, portid);
+		if (err)
+			return err;
+	}
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+	nlh = nlmsg_put(skb, portid, seq, NLMSG_DONE, 0, flags | NLM_F_MULTI);
+	if (!nlh) {
+		err = -EMSGSIZE;
+		goto nla_put_failure;
+	}
+
+	return genlmsg_unicast(dev_net(netdev), skb, portid);
+
+nla_put_failure:
+	nlmsg_free(skb);
+	return err;
+}
+
+static int
+netdev_nl_napi_info_fill(struct net_device *netdev, u32 portid, u32 seq,
+			 int flags, u32 cmd)
+{
+	struct sk_buff *skb;
+	void *hdr;
+	int err;
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(skb, portid, seq, &netdev_nl_family, flags, cmd);
+	if (!hdr) {
+		err = -EMSGSIZE;
+		goto err_free_msg;
+	}
+	if (nla_put_u32(skb, NETDEV_A_NAPI_IFINDEX, netdev->ifindex)) {
+		genlmsg_cancel(skb, hdr);
+		err = -EINVAL;
+		goto err_free_msg;
+	}
+
+	genlmsg_end(skb, hdr);
+
+	err = genlmsg_unicast(dev_net(netdev), skb, portid);
+	if (err)
+		return err;
+
+	return netdev_nl_napi_prepare_fill(netdev, portid, seq, flags, cmd);
+
+err_free_msg:
+	nlmsg_free(skb);
+	return err;
+}
+
 int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_device *netdev;
+	u32 ifindex;
+	int err;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_IFINDEX))
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[NETDEV_A_NAPI_IFINDEX]);
+
+	rtnl_lock();
+
+	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
+	if (netdev)
+		err = netdev_nl_napi_info_fill(netdev, info->snd_portid,
+					       info->snd_seq, 0, info->genlhdr->cmd);
+	else
+		err = -ENODEV;
+
+	rtnl_unlock();
+
+	return err;
+}
+
+static int
+netdev_nl_napi_dump_entry(struct net_device *netdev, struct sk_buff *rsp,
+			  struct netlink_callback *cb, int *start)
+{
+	int index = *start;
+	int tmp_index = index;
+	void *hdr;
+	int err;
+
+	hdr = genlmsg_put(rsp, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &netdev_nl_family, NLM_F_MULTI, NETDEV_CMD_NAPI_GET);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, netdev->ifindex))
+		goto nla_put_failure;
+
+	err =  netdev_nl_napi_fill(netdev, rsp, &index);
+	if (err && (err != -EMSGSIZE || tmp_index == index))
+		goto nla_put_failure;
+
+	*start = index;
+	genlmsg_end(rsp, hdr);
+
+	return err;
+
+nla_put_failure:
+	genlmsg_cancel(rsp, hdr);
+	return -EINVAL;
 }
 
 int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
+	struct net *net = sock_net(skb->sk);
+	struct net_device *netdev;
+	int idx = 0, s_idx, n_idx;
+	int h, s_h;
+	int err;
+
+	s_h = ctx->dev_entry_hash;
+	s_idx = ctx->dev_entry_idx;
+	n_idx = ctx->napi_idx;
+
+	rtnl_lock();
+
+	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
+		struct hlist_head *head;
+
+		idx = 0;
+		head = &net->dev_index_head[h];
+		hlist_for_each_entry(netdev, head, index_hlist) {
+			if (idx < s_idx)
+				goto cont;
+			err = netdev_nl_napi_dump_entry(netdev, skb, cb, &n_idx);
+			if (err == -EMSGSIZE)
+				goto out;
+			n_idx = 0;
+			if (err < 0)
+				break;
+cont:
+			idx++;
+		}
+	}
+
+	rtnl_unlock();
+
+	return err;
+
+out:
+	rtnl_unlock();
+
+	ctx->dev_entry_idx = idx;
+	ctx->dev_entry_hash = h;
+	ctx->napi_idx = n_idx;
+	cb->seq = net->dev_base_seq;
+
+	return skb->len;
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,


