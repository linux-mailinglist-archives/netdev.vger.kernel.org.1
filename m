Return-Path: <netdev+bounces-125123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBEA96BF68
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EEC1F22DE2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286631DB936;
	Wed,  4 Sep 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exJWR1V2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B941DB559
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458305; cv=none; b=oJM8OFhzYdJrN3SWZmlbvBwiCxSoxLHo/Y5Lhom+CZAScIXBXfo3af+lqMGJ7jGK90xkSuCWxqLrJgLnodwCY/14uE2qVgINBiKXpKUELD+FqbaXUTXZDJvLzXLYW09683lJ5AZWleJC6Gz6IYBH73Rojf/2a/RL9ZVHTEzQVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458305; c=relaxed/simple;
	bh=65HphdJil7PEMXnmDsd5tVt1dZH7eh7T+B4oj4bsz9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3D1Zm87p3J9dXJvJkDpf/GQ7xUC8K0DOFFNnzCVHTJ19/k9BAaUH4LJWIa/6snJN3BOC0DZeivh0qpx7ZltlIau5ioMJiu67bs+g03At/kj5a5xXkqbR8HoD6L8CiUaqtjpmH6gm3P+ThVOPjmg8+Dii4qoRQCNxDCoreetr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=exJWR1V2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725458302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZWPBTQAseqbj6CljSE3t3EASAGD40EJVV+Nbj5jVCQ=;
	b=exJWR1V26x8d4KITd+Cyi6+LNba7WfqxxIdpK1KN6KXvwfug5Ubj9s+eAmlC0W5MPiHm/l
	qiifBt67cDV2CVTTBMTcn2coSYdKUlXb15MMoH31ahGzb+K0z1utjrtmD/1HKHK4MtwkgE
	MUguPkgp+92eEclnITVgjXqtRa4lI50=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-xKrhF59MNSqMrJluZwexYQ-1; Wed,
 04 Sep 2024 09:58:18 -0400
X-MC-Unique: xKrhF59MNSqMrJluZwexYQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F0401955F2E;
	Wed,  4 Sep 2024 13:58:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 791A719560AA;
	Wed,  4 Sep 2024 13:58:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com
Subject: [PATCH v6 net-next 14/15] iavf: Add net_shaper_ops support
Date: Wed,  4 Sep 2024 15:53:46 +0200
Message-ID: <f95f1e851e8e40bbd9cd382e42f72e12998a122c.1725457317.git.pabeni@redhat.com>
In-Reply-To: <cover.1725457317.git.pabeni@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

Implement net_shaper_ops support for IAVF. This enables configuration
of rate limiting on per queue basis. Customer intends to enforce
bandwidth limit on Tx traffic steered to the queue by configuring
rate limits on the queue.

To set rate limiting for a queue, update shaper object of given queues
in driver and send VIRTCHNL_OP_CONFIG_QUEUE_BW to PF to update HW
configuration.

Deleting shaper configured for queue is nothing but configuring shaper
with bw_max 0. The PF restores the default rate limiting config
when bw_max is zero.

Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
---
v5 -> v6:
 - adapted to new API
 - dropped scope-related checks (moved into the core)

v4 -> v5:
 - fix kdoc
---
 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |   3 +
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 110 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |   2 +
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  65 +++++++++++
 5 files changed, 181 insertions(+)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 0375c7448a57..20bc40eec487 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -258,6 +258,7 @@ config I40E_DCB
 config IAVF
 	tristate
 	select LIBIE
+	select NET_SHAPER
 
 config I40EVF
 	tristate "Intel(R) Ethernet Adaptive Virtual Function support"
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 48cd1d06761c..a84bdbfbb0f7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -34,6 +34,7 @@
 #include <net/tc_act/tc_gact.h>
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_act/tc_skbedit.h>
+#include <net/net_shaper.h>
 
 #include "iavf_type.h"
 #include <linux/avf/virtchnl.h>
@@ -336,6 +337,7 @@ struct iavf_adapter {
 #define IAVF_FLAG_AQ_DISABLE_CTAG_VLAN_INSERTION	BIT_ULL(36)
 #define IAVF_FLAG_AQ_ENABLE_STAG_VLAN_INSERTION		BIT_ULL(37)
 #define IAVF_FLAG_AQ_DISABLE_STAG_VLAN_INSERTION	BIT_ULL(38)
+#define IAVF_FLAG_AQ_CONFIGURE_QUEUES_BW		BIT_ULL(39)
 
 	/* flags for processing extended capability messages during
 	 * __IAVF_INIT_EXTENDED_CAPS. Each capability exchange requires
@@ -581,6 +583,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 int iavf_config_rss(struct iavf_adapter *adapter);
 int iavf_lan_add_device(struct iavf_adapter *adapter);
 int iavf_lan_del_device(struct iavf_adapter *adapter);
+void iavf_cfg_queues_bw(struct iavf_adapter *adapter);
 void iavf_enable_channels(struct iavf_adapter *adapter);
 void iavf_disable_channels(struct iavf_adapter *adapter);
 void iavf_add_cloud_filter(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index f782402cd789..532c4b8f3fa0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2085,6 +2085,11 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		return 0;
 	}
 
+	if (adapter->aq_required & IAVF_FLAG_AQ_CONFIGURE_QUEUES_BW) {
+		iavf_cfg_queues_bw(adapter);
+		return 0;
+	}
+
 	if (adapter->aq_required & IAVF_FLAG_AQ_CONFIGURE_QUEUES) {
 		iavf_configure_queues(adapter);
 		return 0;
@@ -2918,6 +2923,30 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 	dev_info(&adapter->pdev->dev, "Reset task did not complete, VF disabled\n");
 }
 
+/**
+ * iavf_reconfig_qs_bw - Call-back task to handle hardware reset
+ * @adapter: board private structure
+ *
+ * After a reset, the shaper parameters of queues need to be replayed again.
+ * Since the net_shaper object inside TX rings persists across reset,
+ * set the update flag for all queues so that the virtchnl message is triggered
+ * for all queues.
+ **/
+static void iavf_reconfig_qs_bw(struct iavf_adapter *adapter)
+{
+	int i, num = 0;
+
+	for (i = 0; i < adapter->num_active_queues; i++)
+		if (adapter->tx_rings[i].q_shaper.bw_min ||
+		    adapter->tx_rings[i].q_shaper.bw_max) {
+			adapter->tx_rings[i].q_shaper_update = true;
+			num++;
+		}
+
+	if (num)
+		adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_QUEUES_BW;
+}
+
 /**
  * iavf_reset_task - Call-back task to handle hardware reset
  * @work: pointer to work_struct
@@ -3124,6 +3153,8 @@ static void iavf_reset_task(struct work_struct *work)
 		iavf_up_complete(adapter);
 
 		iavf_irq_enable(adapter, true);
+
+		iavf_reconfig_qs_bw(adapter);
 	} else {
 		iavf_change_state(adapter, __IAVF_DOWN);
 		wake_up(&adapter->down_waitqueue);
@@ -4893,6 +4924,84 @@ static netdev_features_t iavf_fix_features(struct net_device *netdev,
 	return iavf_fix_strip_features(adapter, features);
 }
 
+static int iavf_verify_handle(struct net_shaper_binding *binding,
+			      const struct net_shaper_handle *handle,
+			      struct netlink_ext_ack *extack)
+{
+	struct iavf_adapter *adapter = netdev_priv(binding->netdev);
+	int qid = handle->id;
+
+	if (qid >= adapter->num_active_queues) {
+		NL_SET_ERR_MSG_FMT(extack, "Invalid shaper handle, queued id %d max %d",
+				   qid, adapter->num_active_queues);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int
+iavf_shaper_set(struct net_shaper_binding *binding,
+		const struct net_shaper *shaper,
+		struct netlink_ext_ack *extack)
+{
+	struct iavf_adapter *adapter = netdev_priv(binding->netdev);
+	const struct net_shaper_handle *handle = &shaper->handle;
+	struct iavf_ring *tx_ring;
+	int ret = 0;
+
+	ret = iavf_verify_handle(binding, &shaper->handle, extack);
+	if (ret)
+		return ret;
+
+	tx_ring = &adapter->tx_rings[handle->id];
+
+	tx_ring->q_shaper.bw_min = div_u64(shaper->bw_min, 1000);
+	tx_ring->q_shaper.bw_max = div_u64(shaper->bw_max, 1000);
+	tx_ring->q_shaper_update = true;
+
+	adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_QUEUES_BW;
+	return 0;
+}
+
+static int iavf_shaper_del(struct net_shaper_binding *binding,
+			   const struct net_shaper_handle *handle,
+			   struct netlink_ext_ack *extack)
+{
+	struct iavf_adapter *adapter = netdev_priv(binding->netdev);
+	struct iavf_ring *tx_ring;
+	int ret;
+
+	ret = iavf_verify_handle(binding, handle, extack);
+	if (ret < 0)
+		return ret;
+
+	tx_ring = &adapter->tx_rings[handle->id];
+	tx_ring->q_shaper.bw_min = 0;
+	tx_ring->q_shaper.bw_max = 0;
+	tx_ring->q_shaper_update = true;
+
+	adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_QUEUES_BW;
+	return 0;
+}
+
+static void iavf_shaper_cap(struct net_shaper_binding *binding,
+			    enum net_shaper_scope scope,
+			    unsigned long *flags)
+{
+	if (scope != NET_SHAPER_SCOPE_QUEUE)
+		return;
+
+	*flags = BIT(NET_SHAPER_A_CAPS_SUPPORT_BW_MIN) |
+		 BIT(NET_SHAPER_A_CAPS_SUPPORT_BW_MAX) |
+		 BIT(NET_SHAPER_A_CAPS_SUPPORT_METRIC_BPS);
+}
+
+static const struct net_shaper_ops iavf_shaper_ops = {
+	.set = iavf_shaper_set,
+	.delete = iavf_shaper_del,
+	.capabilities = iavf_shaper_cap,
+};
+
 static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_open		= iavf_open,
 	.ndo_stop		= iavf_close,
@@ -4908,6 +5017,7 @@ static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_fix_features	= iavf_fix_features,
 	.ndo_set_features	= iavf_set_features,
 	.ndo_setup_tc		= iavf_setup_tc,
+	.net_shaper_ops		= &iavf_shaper_ops,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index d7b5587aeb8e..f97c702c0802 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -296,6 +296,8 @@ struct iavf_ring {
 					 */
 
 	u32 rx_buf_len;
+	struct net_shaper q_shaper;
+	bool q_shaper_update;
 } ____cacheline_internodealigned_in_smp;
 
 #define IAVF_ITR_ADAPTIVE_MIN_INC	0x0002
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 7e810b65380c..64ddd0e66c0d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1507,6 +1507,60 @@ iavf_set_adapter_link_speed_from_vpe(struct iavf_adapter *adapter,
 		adapter->link_speed = vpe->event_data.link_event.link_speed;
 }
 
+/**
+ * iavf_cfg_queues_bw - configure bandwidth of allocated queues
+ * @adapter: iavf adapter structure instance
+ *
+ * This function requests PF to configure queue bandwidth of allocated queues
+ */
+void iavf_cfg_queues_bw(struct iavf_adapter *adapter)
+{
+	struct virtchnl_queues_bw_cfg *qs_bw_cfg;
+	struct net_shaper *q_shaper;
+	int qs_to_update = 0;
+	int i, inx = 0;
+	size_t len;
+
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(&adapter->pdev->dev,
+			"Cannot set tc queue bw, command %d pending\n",
+			adapter->current_op);
+		return;
+	}
+
+	for (i = 0; i < adapter->num_active_queues; i++) {
+		if (adapter->tx_rings[i].q_shaper_update)
+			qs_to_update++;
+	}
+	len = struct_size(qs_bw_cfg, cfg, qs_to_update);
+	qs_bw_cfg = kzalloc(len, GFP_KERNEL);
+	if (!qs_bw_cfg)
+		return;
+
+	qs_bw_cfg->vsi_id = adapter->vsi.id;
+	qs_bw_cfg->num_queues = qs_to_update;
+
+	for (i = 0; i < adapter->num_active_queues; i++) {
+		struct iavf_ring *tx_ring = &adapter->tx_rings[i];
+
+		q_shaper = &tx_ring->q_shaper;
+		if (tx_ring->q_shaper_update) {
+			qs_bw_cfg->cfg[inx].queue_id = i;
+			qs_bw_cfg->cfg[inx].shaper.peak = q_shaper->bw_max;
+			qs_bw_cfg->cfg[inx].shaper.committed = q_shaper->bw_min;
+			qs_bw_cfg->cfg[inx].tc = 0;
+			inx++;
+		}
+	}
+
+	adapter->current_op = VIRTCHNL_OP_CONFIG_QUEUE_BW;
+	adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES_BW;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_QUEUE_BW,
+			 (u8 *)qs_bw_cfg, len);
+	kfree(qs_bw_cfg);
+}
+
 /**
  * iavf_enable_channels
  * @adapter: adapter structure
@@ -2227,6 +2281,10 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 					VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC;
 
 			break;
+		case VIRTCHNL_OP_CONFIG_QUEUE_BW:
+			dev_warn(&adapter->pdev->dev, "Failed to Config Queue BW, error %s\n",
+				 iavf_stat_str(&adapter->hw, v_retval));
+			break;
 		default:
 			dev_err(&adapter->pdev->dev, "PF returned error %d (%s) to our request %d\n",
 				v_retval, iavf_stat_str(&adapter->hw, v_retval),
@@ -2569,6 +2627,13 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		if (!v_retval)
 			iavf_netdev_features_vlan_strip_set(netdev, false);
 		break;
+	case VIRTCHNL_OP_CONFIG_QUEUE_BW: {
+		int i;
+		/* shaper configuration is successful for all queues */
+		for (i = 0; i < adapter->num_active_queues; i++)
+			adapter->tx_rings[i].q_shaper_update = false;
+	}
+		break;
 	default:
 		if (adapter->current_op && (v_opcode != adapter->current_op))
 			dev_warn(&adapter->pdev->dev, "Expected response %d from PF, received %d\n",
-- 
2.45.2


