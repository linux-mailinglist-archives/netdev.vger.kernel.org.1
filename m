Return-Path: <netdev+bounces-114324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF2B9421CB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8068D1F25944
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA21917C7;
	Tue, 30 Jul 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BilMGc90"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1818E036
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372135; cv=none; b=Ik7gFRndgDVVtHhBQfh3mZ52Gly1pc1AwuWDdXdxbtOHhCTQyMLlLagMrbKQfoQKEbxK9mNggTJs9BU/IrJgJMNQuhDarTlosZqbomVXwGY5AzBeoRnYA5DTC7I97WclHAw2nKPzKzoOnD74eKtvJi3VvpiBky1NVvJ7hAuMkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372135; c=relaxed/simple;
	bh=RbzSgmgBBI8YzJU/YPdTaqv2lwrzNnCLPsPZiL+2Pd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv721L5kzAoBk8W0B8PPVyZmlbxx95QVzZYtjW6Xm+jF0aSXLx3IQrC8lg6uR6CujuphNYj9awprfJJal2F9xYIqL5z8X9wfw3KGOUKf0QY3hq0Efof+4CSAwG+KABJfg5q4RdWB7tB2hYO+ElZpUOAbLpnetrZludv/Uf4e8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BilMGc90; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722372132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTjvhZQfnXYSVRbGUu7SN6OhlrkRDVnZLAEQiAJ0WzQ=;
	b=BilMGc90B8dGjLDJLCOt7lgTNqH0TVNpSXnhhn6qaYi0qwTw1WmFo3Cp74pGqaQNhDSGjg
	G2wkFUOL51D7foWnp3us1ijfPqgRCiDdnzfzmFaPtHPXfm0TYyg4foacA+8/pHfnNUmrVl
	giahOwIGTquVkCypuMCKkqXwJSYq508=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-3_o-Pcb_MJaiRo4uUrxjyg-1; Tue,
 30 Jul 2024 16:42:06 -0400
X-MC-Unique: 3_o-Pcb_MJaiRo4uUrxjyg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEF441955D57;
	Tue, 30 Jul 2024 20:42:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 796E03000193;
	Tue, 30 Jul 2024 20:42:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH v3 12/12] iavf: add support to exchange qos capabilities
Date: Tue, 30 Jul 2024 22:39:55 +0200
Message-ID: <5cab5266ed8dd1f8df6dbebb8dfcec086ae8b61a.1722357745.git.pabeni@redhat.com>
In-Reply-To: <cover.1722357745.git.pabeni@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

During driver initialization VF determines QOS capability is allowed
by PF and receives QOS parameters. After which quanta size for queues
is configured which is not configurable and is set to 1KB currently.

Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        | 10 ++
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 46 +++++++++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 92 ++++++++++++++++++-
 3 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index f5d1142ea427..dd9cca067360 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -250,6 +250,9 @@ struct iavf_cloud_filter {
 #define IAVF_RESET_WAIT_DETECTED_COUNT 500
 #define IAVF_RESET_WAIT_COMPLETE_COUNT 2000
 
+#define IAVF_MAX_QOS_TC_NUM		8
+#define IAVF_DEFAULT_QUANTA_SIZE	1024
+
 /* board specific private data structure */
 struct iavf_adapter {
 	struct workqueue_struct *wq;
@@ -337,6 +340,8 @@ struct iavf_adapter {
 #define IAVF_FLAG_AQ_ENABLE_STAG_VLAN_INSERTION		BIT_ULL(37)
 #define IAVF_FLAG_AQ_DISABLE_STAG_VLAN_INSERTION	BIT_ULL(38)
 #define IAVF_FLAG_AQ_CONFIGURE_QUEUES_BW		BIT_ULL(39)
+#define IAVF_FLAG_AQ_CFG_QUEUES_QUANTA_SIZE		BIT_ULL(40)
+#define IAVF_FLAG_AQ_GET_QOS_CAPS			BIT_ULL(41)
 
 	/* flags for processing extended capability messages during
 	 * __IAVF_INIT_EXTENDED_CAPS. Each capability exchange requires
@@ -407,6 +412,8 @@ struct iavf_adapter {
 			       VIRTCHNL_VF_OFFLOAD_FDIR_PF)
 #define ADV_RSS_SUPPORT(_a) ((_a)->vf_res->vf_cap_flags & \
 			     VIRTCHNL_VF_OFFLOAD_ADV_RSS_PF)
+#define QOS_ALLOWED(_a) ((_a)->vf_res->vf_cap_flags & \
+			 VIRTCHNL_VF_OFFLOAD_QOS)
 	struct virtchnl_vf_resource *vf_res; /* incl. all VSIs */
 	struct virtchnl_vsi_resource *vsi_res; /* our LAN VSI */
 	struct virtchnl_version_info pf_version;
@@ -415,6 +422,7 @@ struct iavf_adapter {
 	struct virtchnl_vlan_caps vlan_v2_caps;
 	u16 msg_enable;
 	struct iavf_eth_stats current_stats;
+	struct virtchnl_qos_cap_list *qos_caps;
 	struct iavf_vsi vsi;
 	u32 aq_wait_count;
 	/* RSS stuff */
@@ -554,6 +562,8 @@ int iavf_config_rss(struct iavf_adapter *adapter);
 int iavf_lan_add_device(struct iavf_adapter *adapter);
 int iavf_lan_del_device(struct iavf_adapter *adapter);
 void iavf_cfg_queues_bw(struct iavf_adapter *adapter);
+void iavf_cfg_queues_quanta_size(struct iavf_adapter *adapter);
+void iavf_get_qos_caps(struct iavf_adapter *adapter);
 void iavf_enable_channels(struct iavf_adapter *adapter);
 void iavf_disable_channels(struct iavf_adapter *adapter);
 void iavf_add_cloud_filter(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 3a5ae0cd31c7..0ee128477d59 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2090,6 +2090,16 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		return 0;
 	}
 
+	if (adapter->aq_required & IAVF_FLAG_AQ_GET_QOS_CAPS) {
+		iavf_get_qos_caps(adapter);
+		return 0;
+	}
+
+	if (adapter->aq_required & IAVF_FLAG_AQ_CFG_QUEUES_QUANTA_SIZE) {
+		iavf_cfg_queues_quanta_size(adapter);
+		return 0;
+	}
+
 	if (adapter->aq_required & IAVF_FLAG_AQ_CONFIGURE_QUEUES) {
 		iavf_configure_queues(adapter);
 		return 0;
@@ -2675,6 +2685,9 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
 		/* request initial VLAN offload settings */
 		iavf_set_vlan_offload_features(adapter, 0, netdev->features);
 
+	if (QOS_ALLOWED(adapter))
+		adapter->aq_required |= IAVF_FLAG_AQ_GET_QOS_CAPS;
+
 	iavf_schedule_finish_config(adapter);
 	return;
 
@@ -4809,7 +4822,27 @@ iavf_verify_shaper_info(struct net_device *dev,
 			const struct net_shaper_info *shaper,
 			struct netlink_ext_ack *extack)
 {
-	return iavf_verify_handle(dev, shaper->handle, extack);
+	struct iavf_adapter *adapter = netdev_priv(dev);
+	enum net_shaper_scope scope;
+	int ret, qid;
+	u64 vf_max;
+
+	ret = iavf_verify_handle(dev, shaper->handle, extack);
+	if (ret)
+		return ret;
+
+	scope = net_shaper_handle_scope(shaper->handle);
+	qid = net_shaper_handle_id(shaper->handle);
+
+	if (scope == NET_SHAPER_SCOPE_QUEUE) {
+		vf_max = adapter->qos_caps->cap[0].shaper.peak;
+		if (vf_max && shaper->bw_max > vf_max) {
+			NL_SET_ERR_MSG_FMT(extack, "Max rate (%llu) of queue %d can't exceed max TX rate of VF (%llu kbps)",
+					   shaper->bw_max, qid,
+					   vf_max);
+		}
+	}
+	return 0;
 }
 
 /**
@@ -5073,7 +5106,7 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct net_device *netdev;
 	struct iavf_adapter *adapter = NULL;
 	struct iavf_hw *hw = NULL;
-	int err;
+	int err, len;
 
 	err = pci_enable_device(pdev);
 	if (err)
@@ -5141,6 +5174,13 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->bus.func = PCI_FUNC(pdev->devfn);
 	hw->bus.bus_id = pdev->bus->number;
 
+	len = struct_size(adapter->qos_caps, cap, IAVF_MAX_QOS_TC_NUM);
+	adapter->qos_caps = kzalloc(len, GFP_KERNEL);
+	if (!adapter->qos_caps) {
+		err = -ENOMEM;
+		goto err_alloc_qos_cap;
+	}
+
 	/* set up the locks for the AQ, do this only once in probe
 	 * and destroy them only once in remove
 	 */
@@ -5179,6 +5219,8 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Initialization goes on in the work. Do not add more of it below. */
 	return 0;
 
+err_alloc_qos_cap:
+	iounmap(hw->hw_addr);
 err_ioremap:
 	destroy_workqueue(adapter->wq);
 err_alloc_wq:
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index c0611608d332..2f1be42ebd58 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -150,7 +150,8 @@ int iavf_send_vf_config_msg(struct iavf_adapter *adapter)
 	       VIRTCHNL_VF_OFFLOAD_USO |
 	       VIRTCHNL_VF_OFFLOAD_FDIR_PF |
 	       VIRTCHNL_VF_OFFLOAD_ADV_RSS_PF |
-	       VIRTCHNL_VF_CAP_ADV_LINK_SPEED;
+	       VIRTCHNL_VF_CAP_ADV_LINK_SPEED |
+	       VIRTCHNL_VF_OFFLOAD_QOS;
 
 	adapter->current_op = VIRTCHNL_OP_GET_VF_RESOURCES;
 	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_CONFIG;
@@ -1506,6 +1507,76 @@ iavf_set_adapter_link_speed_from_vpe(struct iavf_adapter *adapter,
 		adapter->link_speed = vpe->event_data.link_event.link_speed;
 }
 
+/**
+ * iavf_get_qos_caps - get qos caps support
+ * @adapter: iavf adapter struct instance
+ *
+ * This function requests PF for Supported QoS Caps.
+ */
+void iavf_get_qos_caps(struct iavf_adapter *adapter)
+{
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(&adapter->pdev->dev,
+			"Cannot get qos caps, command %d pending\n",
+			adapter->current_op);
+		return;
+	}
+
+	adapter->current_op = VIRTCHNL_OP_GET_QOS_CAPS;
+	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_QOS_CAPS;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_QOS_CAPS, NULL, 0);
+}
+
+/**
+ * iavf_set_quanta_size - set quanta size of queue chunk
+ * @adapter: iavf adapter struct instance
+ * @quanta_size: quanta size in bytes
+ * @queue_index: starting index of queue chunk
+ * @num_queues: number of queues in the queue chunk
+ *
+ * This function requests PF to set quanta size of queue chunk
+ * starting at queue_index.
+ */
+static void
+iavf_set_quanta_size(struct iavf_adapter *adapter, u16 quanta_size,
+		     u16 queue_index, u16 num_queues)
+{
+	struct virtchnl_quanta_cfg quanta_cfg;
+
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(&adapter->pdev->dev,
+			"Cannot set queue quanta size, command %d pending\n",
+			adapter->current_op);
+		return;
+	}
+
+	adapter->current_op = VIRTCHNL_OP_CONFIG_QUANTA;
+	quanta_cfg.quanta_size = quanta_size;
+	quanta_cfg.queue_select.type = VIRTCHNL_QUEUE_TYPE_TX;
+	quanta_cfg.queue_select.start_queue_id = queue_index;
+	quanta_cfg.queue_select.num_queues = num_queues;
+	adapter->aq_required &= ~IAVF_FLAG_AQ_CFG_QUEUES_QUANTA_SIZE;
+	iavf_send_pf_msg(adapter, VIRTCHNL_OP_CONFIG_QUANTA,
+			 (u8 *)&quanta_cfg, sizeof(quanta_cfg));
+}
+
+/**
+ * iavf_cfg_queues_quanta_size - configure quanta size of queues
+ * @adapter: adapter structure
+ *
+ * Request that the PF configure quanta size of allocated queues.
+ **/
+void iavf_cfg_queues_quanta_size(struct iavf_adapter *adapter)
+{
+	int quanta_size = IAVF_DEFAULT_QUANTA_SIZE;
+
+	/* Set Queue Quanta Size to default */
+	iavf_set_quanta_size(adapter, quanta_size, 0,
+			     adapter->num_active_queues);
+}
+
 /**
  * iavf_cfg_queues_bw - configure bandwidth of allocated queues
  * @adapter: iavf adapter structure instance
@@ -2280,6 +2351,14 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 					VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC;
 
 			break;
+		case VIRTCHNL_OP_GET_QOS_CAPS:
+			dev_warn(&adapter->pdev->dev, "Failed to Get Qos CAPs, error %s\n",
+				 iavf_stat_str(&adapter->hw, v_retval));
+			break;
+		case VIRTCHNL_OP_CONFIG_QUANTA:
+			dev_warn(&adapter->pdev->dev, "Failed to Config Quanta, error %s\n",
+				 iavf_stat_str(&adapter->hw, v_retval));
+			break;
 		case VIRTCHNL_OP_CONFIG_QUEUE_BW:
 			dev_warn(&adapter->pdev->dev, "Failed to Config Queue BW, error %s\n",
 				 iavf_stat_str(&adapter->hw, v_retval));
@@ -2618,6 +2697,17 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		if (!v_retval)
 			iavf_netdev_features_vlan_strip_set(netdev, false);
 		break;
+	case VIRTCHNL_OP_GET_QOS_CAPS: {
+		u16 len = struct_size(adapter->qos_caps, cap,
+				      IAVF_MAX_QOS_TC_NUM);
+
+		memcpy(adapter->qos_caps, msg, min(msglen, len));
+
+		adapter->aq_required |= IAVF_FLAG_AQ_CFG_QUEUES_QUANTA_SIZE;
+		}
+		break;
+	case VIRTCHNL_OP_CONFIG_QUANTA:
+		break;
 	case VIRTCHNL_OP_CONFIG_QUEUE_BW: {
 		int i;
 		/* shaper configuration is successful for all queues */
-- 
2.45.2


