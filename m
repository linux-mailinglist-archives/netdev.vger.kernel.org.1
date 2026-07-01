Return-Path: <netdev+bounces-303672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B376MAEXRWo/6woAu9opvQ
	(envelope-from <netdev+bounces-303672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:32:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B378D6EE279
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:32:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=nZSV11Da;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303672-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303672-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 697B03015D3A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E0481253;
	Wed,  1 Jul 2026 13:27:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B0481679;
	Wed,  1 Jul 2026 13:27:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912462; cv=none; b=PjIGxV8E4zZgs5g56Ih4h5UmuiVQL5dTHzW83rk0NUUdF/QkVfnOK4HgFeq3Ry/rHypHa3PUoXz3yVj9KCw/7n95cTClA1tJQBECQgMrkmh3+XhNqI54uQC9pgJi7kZfnsTW/gsOYqaNNc4/lvMyY3S5hsB8XY0CQE0oAaXwtkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912462; c=relaxed/simple;
	bh=C+o61CAmX107GBf5vY0Yt3iENLf44W7I7URoD7BL5as=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ok8kPwKuCT8a8KJgg/u0gto+1IcfcnKDpbkIa6SbGY+m8aZAdFNy3jTcHVhK9xxKV6HNx2fHiygBLaEJQ1i9/WcjnoXA2LBghenQT+76qkPDtU6Qam4slzFv7zQyP2oWNmgg14Pm62pjpDI/icuScokEABPPP0juMw+Lpyh/6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nZSV11Da; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ewyn5gjCgYFURI5j5CHOcig6uffiIY5gjA7yf3lwQYc=;
	b=nZSV11DaLd1ueo9JRl7nKTYlwuLGsDYKov7wjcuf/ehiiu3JpIItoV+qWa4fY36CMSaGznTDY
	ACDPu0fAq1cAEwLyyZdvZesTxKg3G2ROAazcx6ZtmP9gwNA1QqHeRezpdGLLScOJczplvucrQle
	uCp4+ejtuDDv3jcFhHqaDzo=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gr0VY4kX9z1T4gK;
	Wed,  1 Jul 2026 21:00:21 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E18240584;
	Wed,  1 Jul 2026 21:09:12 +0800 (CST)
Received: from
 deployment-s00611957-4ii0-20260331111539-78d5c5cfbb-9s2bv.default.svc.cluster.local
 (7.197.8.232) by kwepemo500018.china.huawei.com (7.202.195.199) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 1 Jul
 2026 21:09:12 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH RFC net-next] net: hns3: add VF representor for tc flower queue selection
Date: Wed, 1 Jul 2026 21:08:06 +0800
Message-ID: <20260701130806.695180-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303672-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shaojijie@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B378D6EE279

Background

The hns3 driver supports configuring FD (Flow Director) rules via
ethtool to specify queue mapping or drop actions for traffic received
by the PF. ethtool also supports specifying a vf parameter to
configure the same rules for VF traffic (ethtool -U eth0 flow-type
tcp4 vf 1 queue 3).

The community recommends using tc flower to replace ethtool ntuple/rss
flow configuration. tc flower already supports FD rule configuration
on the PF side, but there is currently no mechanism to configure
equivalent rules for VF traffic through tc flower.

The hns3 FD engine is a TCAM-based match+action engine, not a
switching or forwarding engine. It matches packets by the DST_VPORT
tuple (vport_id) in TCAM key metadata, with actions being queue
selection or packet drop. FD rules are configured by the PF driver
and sent to firmware. Since firmware has visibility into all PF and
VF vport resources, the PF can configure queue selection and drop
rules on behalf of VFs.

Motivation

We would like to add tc flower support for configuring queue selection
and drop rules on VF traffic in the hns3 driver. We investigated
several approaches:

Approach A (REDIRECT + QUEUE_MAPPING dual action):
  Configure tc flower on the PF netdev, using FLOW_ACTION_REDIRECT to
  specify the VF device and FLOW_ACTION_RX_QUEUE_MAPPING for the queue.
  However, REDIRECT semantically means "redirect the packet to another
  device" (forwarding), while the hns3 FD engine does not forward
  packets -- it only matches packets and selects a queue or drops them.
  The semantics do not align.

Approach B (MARK encoding vf_id):
  Use FLOW_ACTION_MARK high bits to encode the VF ID and
  QUEUE_MAPPING for the queue number. But MARK is designed for packet
  marking for downstream processing. Encoding driver-internal
  parameters in it is a semantic abuse with no community precedent.

Approach C (VF Representor):
  Create a representor net_device for each VF. TC flower rules are
  configured on the representor, whose identity implicitly encodes
  the VF. This approach has clear semantics -- "configure a rule for
  VF1" means operating on VF1's representor -- and has precedent
  in other drivers. Considering code complexity, semantic correctness,
  and alignment with community conventions, we chose Approach C.

This RFC patch presents our initial implementation to gather feedback
on whether this approach is reasonable and what improvements are needed.

Approach

Introduce VF representor net_devices to provide tc flower capability
equivalent to ethtool "flow-type ... vf N queue M".

The PF creates one representor net_device (e.g. eno2_rep0) per VF at
SRIOV enable time, serving as the tc flower rule configuration handle.
The representor is NOT a switch port and does NOT participate in
datapath forwarding -- its ndo_start_xmit simply drops packets.

When a tc flower rule is configured on the representor, the PF driver
automatically extracts the corresponding VF vport from the
representor's cb_priv (struct hclge_vf_rep) and sets DST_VPORT in
the TCAM key to that VF's vport_id, so the FD engine only matches
packets destined for that VF.

Implementation

- Extract hclge_add_cls_flower_common() from hclge_add_cls_flower(),
  accepting a struct hclge_vport pointer to derive vport_id and
  num_tqps, shared by both PF and VF representor paths.

- Set rule->vf_id to vport->vport_id (0 for PF, hardware-assigned
  vport_id for VF) for TCAM DST_VPORT matching and FD counter
  differentiation.

- Queue ID is validated against the VF's actual queue count
  (vport->nic.kinfo.num_tqps).

- VF representor does NOT support implicit TC selection via classid
  (HCLGE_FD_ACTION_SELECT_TC). Only explicit actions are supported:
  - FLOW_ACTION_RX_QUEUE_MAPPING: queue selection
  - FLOW_ACTION_DROP: packet drop

- VF representor creation failure does not roll back SRIOV. The VF
  datapath works independently and is not affected.

- ndo_get_phys_port_name returns "pfNvfM" for user-space
  identification.

This is an RFC patch for early review. It has been through basic
verification but is not intended for formal submission. Further
review and testing are required.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/Makefile  |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   2 +
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  16 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_fd.c |  48 +++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_fd.h |   7 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        |   2 +
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   6 +
 .../hisilicon/hns3/hns3pf/hclge_vf_rep.c      | 159 ++++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_vf_rep.h      |  21 +++
 9 files changed, 251 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_vf_rep.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_vf_rep.h

diff --git a/drivers/net/ethernet/hisilicon/hns3/Makefile b/drivers/net/ethernet/hisilicon/hns3/Makefile
index 5785d4c5709e..6fd83c959495 100644
--- a/drivers/net/ethernet/hisilicon/hns3/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/Makefile
@@ -24,6 +24,6 @@ hclgevf-objs = hns3vf/hclgevf_main.o hns3vf/hclgevf_mbx.o  hns3vf/hclgevf_devlin
 obj-$(CONFIG_HNS3_HCLGE) += hclge.o hclge-common.o
 hclge-objs = hns3pf/hclge_main.o hns3pf/hclge_mdio.o hns3pf/hclge_tm.o hns3pf/hclge_regs.o \
 		hns3pf/hclge_mbx.o hns3pf/hclge_err.o  hns3pf/hclge_debugfs.o hns3pf/hclge_ptp.o hns3pf/hclge_devlink.o \
-		hns3pf/hclge_fd.o
+		hns3pf/hclge_fd.o hns3pf/hclge_vf_rep.o
 
 hclge-$(CONFIG_HNS3_DCB) += hns3pf/hclge_dcb.o
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index a8798eecd9fb..d2c1c73617a4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -796,6 +796,8 @@ struct hnae3_ae_ops {
 	int (*get_link_diagnosis_info)(struct hnae3_handle *handle,
 				       u32 *status_code);
 	void (*clean_vf_config)(struct hnae3_ae_dev *ae_dev, int num_vfs);
+	int (*create_vf_reps)(struct hnae3_ae_dev *ae_dev, int num_vfs);
+	void (*destroy_vf_reps)(struct hnae3_ae_dev *ae_dev);
 	int (*get_dscp_prio)(struct hnae3_handle *handle, u8 dscp,
 			     u8 *tc_map_mode, u8 *priority);
 	void (*get_wol)(struct hnae3_handle *handle,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 6ecb32e28e79..f393e9f81fa6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3211,6 +3211,7 @@ static void hns3_remove(struct pci_dev *pdev)
  **/
 static int hns3_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
+	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
 	int ret;
 
 	if (!(hns3_is_phys_func(pdev) && IS_ENABLED(CONFIG_PCI_IOV))) {
@@ -3220,13 +3221,24 @@ static int hns3_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 
 	if (num_vfs) {
 		ret = pci_enable_sriov(pdev, num_vfs);
-		if (ret)
+		if (ret) {
 			dev_err(&pdev->dev, "SRIOV enable failed %d\n", ret);
-		else
+		} else {
+			if (ae_dev->ops->create_vf_reps) {
+				ret = ae_dev->ops->create_vf_reps(ae_dev,
+								  num_vfs);
+				if (ret)
+					dev_warn(&pdev->dev,
+						"failed to create VF representors: %d\n",
+						ret);
+			}
 			return num_vfs;
+		}
 	} else if (!pci_vfs_assigned(pdev)) {
 		int num_vfs_pre = pci_num_vf(pdev);
 
+		if (ae_dev->ops->destroy_vf_reps)
+			ae_dev->ops->destroy_vf_reps(ae_dev);
 		pci_disable_sriov(pdev);
 		hns3_clean_vf_config(pdev, num_vfs_pre);
 	} else {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.c
index 2fccb0a870b5..8cd9a1a8eff1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.c
@@ -6,6 +6,7 @@
 #include <net/vxlan.h>
 #include "hclge_fd.h"
 #include "hclge_main.h"
+#include "hclge_vf_rep.h"
 
 static const struct key_info meta_data_key_info[] = {
 	{ PACKET_TYPE_ID, 6 },
@@ -2285,6 +2286,7 @@ static int hclge_get_cls_key_ip_tos(const struct flow_rule *flow,
 }
 
 static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
+				      struct hclge_vport *vport,
 				      struct flow_cls_offload *cls_flower,
 				      struct hclge_fd_rule *rule)
 {
@@ -2292,10 +2294,17 @@ static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
 	struct netlink_ext_ack *extack = cls_flower->common.extack;
 	struct hnae3_handle *handle = &hdev->vport[0].nic;
 	struct flow_action *action = &flow->action;
+	u16 num_tqps = vport->nic.kinfo.num_tqps;
 	struct flow_action_entry *act;
 	int tc;
 
 	if (!flow_action_has_entries(&flow->action)) {
+		if (vport != &hdev->vport[0]) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "VF does not support select TC action");
+			return -EOPNOTSUPP;
+		}
+
 		tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
 		if (tc < 0 || tc > hdev->tc_max) {
 			NL_SET_ERR_MSG_FMT_MOD(extack,
@@ -2311,11 +2320,10 @@ static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
 	act = &action->entries[0];
 	switch (act->id) {
 	case FLOW_ACTION_RX_QUEUE_MAPPING:
-		if (act->rx_queue >= handle->kinfo.num_tqps) {
+		if (act->rx_queue >= num_tqps) {
 			NL_SET_ERR_MSG_FMT_MOD(extack,
 					       "queue id (%u) should be less than %u",
-					       act->rx_queue,
-					       handle->kinfo.num_tqps);
+					       act->rx_queue, num_tqps);
 			return -EINVAL;
 		}
 
@@ -2423,12 +2431,11 @@ static int hclge_check_cls_flower(struct hclge_dev *hdev,
 	return 0;
 }
 
-int hclge_add_cls_flower(struct hnae3_handle *handle,
-			 struct flow_cls_offload *cls_flower)
+static int hclge_add_cls_flower_common(struct hclge_dev *hdev,
+				       struct hclge_vport *vport,
+				       struct flow_cls_offload *cls_flower)
 {
 	struct netlink_ext_ack *extack = cls_flower->common.extack;
-	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
 	struct hclge_fd_rule *rule;
 	int ret;
 
@@ -2451,14 +2458,14 @@ int hclge_add_cls_flower(struct hnae3_handle *handle,
 		return ret;
 	}
 
-	ret = hclge_get_tc_flower_action(hdev, cls_flower, rule);
+	ret = hclge_get_tc_flower_action(hdev, vport, cls_flower, rule);
 	if (ret) {
 		kfree(rule);
 		return ret;
 	}
 
 	rule->location = cls_flower->common.prio - 1;
-	rule->vf_id = 0;
+	rule->vf_id = vport->vport_id;
 	rule->cls_flower.cookie = cls_flower->cookie;
 	rule->rule_type = HCLGE_FD_TC_FLOWER_ACTIVE;
 
@@ -2469,6 +2476,21 @@ int hclge_add_cls_flower(struct hnae3_handle *handle,
 	return ret;
 }
 
+int hclge_add_cls_flower(struct hnae3_handle *handle,
+			 struct flow_cls_offload *cls_flower)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+
+	return hclge_add_cls_flower_common(vport->back, vport, cls_flower);
+}
+
+int hclge_add_cls_flower_vf(struct hclge_vf_rep *vf_rep,
+			    struct flow_cls_offload *cls_flower)
+{
+	return hclge_add_cls_flower_common(vf_rep->hdev, vf_rep->vport,
+					   cls_flower);
+}
+
 static struct hclge_fd_rule *hclge_find_cls_flower(struct hclge_dev *hdev,
 						   unsigned long cookie)
 {
@@ -2522,6 +2544,14 @@ int hclge_del_cls_flower(struct hnae3_handle *handle,
 	return 0;
 }
 
+int hclge_del_cls_flower_vf(struct hclge_vf_rep *vf_rep,
+			    struct flow_cls_offload *cls_flower)
+{
+	struct hclge_dev *hdev = vf_rep->hdev;
+
+	return hclge_del_cls_flower(&hdev->vport[0].nic, cls_flower);
+}
+
 static void hclge_sync_fd_list(struct hclge_dev *hdev, struct hlist_head *hlist)
 {
 	struct hclge_fd_rule *rule;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.h
index 2f66cc9c3c65..200d81ce12c8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.h
@@ -6,6 +6,8 @@
 
 struct hnae3_handle;
 struct hclge_dev;
+struct hclge_vf_rep;
+struct flow_cls_offload;
 
 int hclge_init_fd_config(struct hclge_dev *hdev);
 int hclge_add_fd_entry(struct hnae3_handle *handle, struct ethtool_rxnfc *cmd);
@@ -26,6 +28,11 @@ int hclge_add_cls_flower(struct hnae3_handle *handle,
 int hclge_del_cls_flower(struct hnae3_handle *handle,
 			 struct flow_cls_offload *cls_flower);
 bool hclge_is_cls_flower_active(struct hnae3_handle *handle);
+
+int hclge_add_cls_flower_vf(struct hclge_vf_rep *vf_rep,
+			    struct flow_cls_offload *cls_flower);
+int hclge_del_cls_flower_vf(struct hclge_vf_rep *vf_rep,
+			    struct flow_cls_offload *cls_flower);
 int hclge_clear_arfs_rules(struct hclge_dev *hdev);
 void hclge_sync_fd_table(struct hclge_dev *hdev);
 void hclge_rfs_filter_expire(struct hclge_dev *hdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index fc8587c80813..5f88187f1ca8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -10534,6 +10534,8 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.get_ts_info = hclge_ptp_get_ts_info,
 	.get_link_diagnosis_info = hclge_get_link_diagnosis_info,
 	.clean_vf_config = hclge_clean_vport_config,
+	.create_vf_reps = hclge_create_vf_reps,
+	.destroy_vf_reps = hclge_destroy_vf_reps,
 	.get_dscp_prio = hclge_get_dscp_prio,
 	.get_wol = hclge_get_wol,
 	.set_wol = hclge_set_wol,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 7419481422c3..4f11b9c38e69 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -17,6 +17,9 @@
 #include "hnae3.h"
 #include "hclge_comm_rss.h"
 #include "hclge_comm_tqp_stats.h"
+#include "hclge_vf_rep.h"
+
+struct hclge_vf_rep;
 
 #define HCLGE_MOD_VERSION "1.0"
 #define HCLGE_DRIVER_NAME "hclge"
@@ -935,6 +938,9 @@ struct hclge_dev {
 	bool cur_promisc;
 	int num_alloc_vfs;	/* Actual number of VFs allocated */
 
+	struct hclge_vf_rep	**vf_reps;
+	u16			num_vf_reps;
+
 	struct hclge_comm_tqp *htqp;
 	struct hclge_vport *vport;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_vf_rep.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_vf_rep.c
new file mode 100644
index 000000000000..c51336040d6f
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_vf_rep.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2026 Hisilicon Limited.
+
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <net/flow_offload.h>
+
+#include "hclge_main.h"
+#include "hclge_vf_rep.h"
+#include "hclge_fd.h"
+
+static netdev_tx_t hclge_vf_rep_xmit(struct sk_buff *skb,
+				     struct net_device *dev)
+{
+	dev_kfree_skb_any(skb);
+	dev->stats.tx_dropped++;
+	return NETDEV_TX_OK;
+}
+
+static int hclge_vf_rep_get_phys_port_name(struct net_device *dev,
+					    char *buf, size_t len)
+{
+	struct hclge_vf_rep *vf_rep = netdev_priv(dev);
+	struct hclge_dev *hdev = vf_rep->hdev;
+	int rc;
+
+	rc = snprintf(buf, len, "pf%uvf%u", PCI_FUNC(hdev->pdev->devfn),
+		      vf_rep->vport->vport_id - 1);
+	if (rc >= len)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int hclge_vf_rep_setup_tc_block_cb(enum tc_setup_type type,
+					   void *type_data, void *cb_priv)
+{
+	struct flow_cls_offload *cls_flower = type_data;
+	struct hclge_vf_rep *vf_rep = cb_priv;
+
+	if (!tc_cls_can_offload_and_chain0(vf_rep->netdev, type_data))
+		return -EOPNOTSUPP;
+
+	switch (type) {
+	case TC_SETUP_CLSFLOWER:
+		switch (cls_flower->command) {
+		case FLOW_CLS_REPLACE:
+			return hclge_add_cls_flower_vf(vf_rep, cls_flower);
+		case FLOW_CLS_DESTROY:
+			return hclge_del_cls_flower_vf(vf_rep, cls_flower);
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static LIST_HEAD(hclge_vf_rep_block_cb_list);
+
+static int hclge_vf_rep_setup_tc(struct net_device *dev,
+				 enum tc_setup_type type, void *type_data)
+{
+	struct hclge_vf_rep *vf_rep = netdev_priv(dev);
+
+	switch (type) {
+	case TC_SETUP_BLOCK:
+		return flow_block_cb_setup_simple(type_data,
+						  &hclge_vf_rep_block_cb_list,
+						  hclge_vf_rep_setup_tc_block_cb,
+						  vf_rep, vf_rep, true);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct net_device_ops hclge_vf_rep_netdev_ops = {
+	.ndo_start_xmit		= hclge_vf_rep_xmit,
+	.ndo_get_phys_port_name	= hclge_vf_rep_get_phys_port_name,
+	.ndo_setup_tc			= hclge_vf_rep_setup_tc,
+};
+
+static void hclge_vf_rep_net_setup(struct net_device *ndev)
+{
+	ndev->netdev_ops = &hclge_vf_rep_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->features |= NETIF_F_HW_TC;
+}
+
+int hclge_create_vf_reps(struct hnae3_ae_dev *ae_dev, int num_vfs)
+{
+	struct hclge_dev *hdev = ae_dev->priv;
+	struct hclge_vf_rep *vf_rep;
+	struct net_device *ndev;
+	char name[IFNAMSIZ];
+	int ret, i;
+
+	if (!num_vfs)
+		return 0;
+
+	hdev->vf_reps = kcalloc(num_vfs, sizeof(struct hclge_vf_rep *),
+				GFP_KERNEL);
+	if (!hdev->vf_reps)
+		return -ENOMEM;
+
+	for (i = 0; i < num_vfs; i++) {
+		snprintf(name, IFNAMSIZ, "%s_rep%d",
+			 hdev->vport[0].nic.netdev->name, i);
+		ndev = alloc_netdev(sizeof(struct hclge_vf_rep), name,
+				    NET_NAME_UNKNOWN, ether_setup);
+		if (!ndev) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		hclge_vf_rep_net_setup(ndev);
+
+		vf_rep = netdev_priv(ndev);
+		vf_rep->hdev = hdev;
+		vf_rep->vport = &hdev->vport[i + HCLGE_VF_VPORT_START_NUM];
+		vf_rep->netdev = ndev;
+
+		ret = register_netdev(ndev);
+		if (ret) {
+			free_netdev(ndev);
+			goto err;
+		}
+
+		hdev->vf_reps[i] = vf_rep;
+	}
+
+	hdev->num_vf_reps = num_vfs;
+	return 0;
+
+err:
+	while (i--)
+		unregister_netdev(hdev->vf_reps[i]->netdev);
+	kfree(hdev->vf_reps);
+	hdev->vf_reps = NULL;
+	return ret;
+}
+
+void hclge_destroy_vf_reps(struct hnae3_ae_dev *ae_dev)
+{
+	struct hclge_dev *hdev = ae_dev->priv;
+	int i;
+
+	if (!hdev->vf_reps)
+		return;
+
+	for (i = 0; i < hdev->num_vf_reps; i++) {
+		if (hdev->vf_reps[i])
+			unregister_netdev(hdev->vf_reps[i]->netdev);
+	}
+
+	kfree(hdev->vf_reps);
+	hdev->vf_reps = NULL;
+	hdev->num_vf_reps = 0;
+}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_vf_rep.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_vf_rep.h
new file mode 100644
index 000000000000..fb2080ae627b
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_vf_rep.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2026 Hisilicon Limited. */
+
+#ifndef __HCLGE_VF_REP_H
+#define __HCLGE_VF_REP_H
+
+struct hnae3_ae_dev;
+struct hclge_dev;
+struct hclge_vport;
+struct net_device;
+
+struct hclge_vf_rep {
+	struct hclge_dev	*hdev;
+	struct hclge_vport	*vport;
+	struct net_device	*netdev;
+};
+
+int hclge_create_vf_reps(struct hnae3_ae_dev *ae_dev, int num_vfs);
+void hclge_destroy_vf_reps(struct hnae3_ae_dev *ae_dev);
+
+#endif

base-commit: 1c664ec4b9ea827b609d296921ed5bad8a40a158
-- 
2.33.0


