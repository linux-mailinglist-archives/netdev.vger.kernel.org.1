Return-Path: <netdev+bounces-52733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D945C7FFFDB
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4DA1C20FE4
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9980B163;
	Fri,  1 Dec 2023 00:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Aywsc5gn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B2B10F3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:05:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvxFg99ZGYvF/WM58t7u+j0PfZRu+g90DEPkdm2idy8BnPgGvQJn30levWMuNaq0w/jp2qwAqOtQdT6kzeFAQwp9asXcJ0C3neFClGZcru+FM6UHJCdhFtuUJWymlQUZk6kGU90G9vYSaxPpjycUdXUOIQEQIIi/zEa8L9YtA86WzrERUeq6ZTZU9Ibs/pJHPFXz3Z9ktttOARi6RupZKSIoyJTukMiFyrbRuLESdrPsXSxvWFHqZOPoLNRvTWp/432vPJfPuF9yHcBshx1Nadx2BfEbyx07GdWLu0ihOqfzQEmJwk0an/Z2CB3/NtD9O0heCM/6ZA6PKSq4QzEWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbMYeAo1/R+rqEvx/QWVhubdE0Qp5Z30vspGWRI9FQQ=;
 b=BHK8Ebjyxf6Lnjc1UQXwMdxP8paV7RN8GvMpMRxlzOolteY+lLUmFrCOt9PUAHZZL96ng1bQzklFQYq4PHjuw4Hdyn0IkZY4J0G1vSyR/XWdKeY12UEiyKsXDm1jQPklcuN9w4FJZv3dKidBq1X58VE7IVRq7f9W2l04OsJDJwLyPTzr22Gq9DJjHt9V80lrWat+tgyrVC+HOdhQ5hxFeCkPaSTtVVUwHD9f3qlTXU9biglp2unLgjndAPbC56Wz/T9y4BUTQzMiUQC6xonACRc3btxxCUbQ/V3EowucCswWlNNd6Pc/CUZiKRU0d7KcccVjwW4iXA+dUll+8Fx8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbMYeAo1/R+rqEvx/QWVhubdE0Qp5Z30vspGWRI9FQQ=;
 b=Aywsc5gnTfZZoCRlXoOsElTOaDgaUxUA7TPNHL1TsbG1ktqMEf8Sus+wvRvTyWU6XJ1AY8fmPiJQu6hCz3y5zynYIeBtrBXn7XR06yKER6LK8gFPJrZ6bPNjcNTHuoCN/mf7qN2PELTAdVs5n20fN/Y43g+kJNa9h0zYoMzb3nw=
Received: from CY5PR18CA0037.namprd18.prod.outlook.com (2603:10b6:930:13::20)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 00:05:41 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::7f) by CY5PR18CA0037.outlook.office365.com
 (2603:10b6:930:13::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:05:41 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:05:39 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 2/7] ionic: Use cached VF attributes
Date: Thu, 30 Nov 2023 16:05:14 -0800
Message-ID: <20231201000519.13363-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231201000519.13363-1-shannon.nelson@amd.com>
References: <20231201000519.13363-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: d75636a1-e4e6-44e0-ec16-08dbf201419a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IUe2xUBzi4w6m3CPk/yVGDe5IDMx4Zw/p+/V5Rwpp6wXfTxoXfitHRBRdWKpmPtFcfGNsk+PsyJ3/NhoY3cOjnAY+J6YOiKHfxFuKzQEovIxnIoKeHFQGVQfuuQp29z3r4+nLNAf3PxjYWJ7/X+qngAceRV/ELZBMnNBmwTRlZlgy3L1QbZNhEhvUkAIccem+WeQBoXgDAkJbGl21dTjVnNtNt0g+w5Ll/k8M9PEzA6sL46gBEo0Wt7bLYJBXeBMrCbqiux8kR5GIF+o5c2kiMcA8EcLBtyfcagsSYMX/ktf/Rl9ejIrzqm75q4QP5dlznXOfmHo/VgDmOC1ISqnELjgR+6l57Sz8cbm/tggc8uZhwuh+EUdBoWn3NkvtWx7vEilq1mijz//EsvzVlRyi4vqzSttNtJCQX3USchTAf5NLND/8AMKNv4tFdhsczAvgO2MqDkNEkSXhWIT2MAL9emzCW9gleao1FmtCbehODhvOxg5SCHGjJPpsjuXjYYsLSTmBsKai8ZnVhEQLAWZT/5UQllshsbvKyN+LKTl5mwwv9zai2tAp1+wRdboQge5seh1hBICw22NzMpxGPBjIqihYL2rC/c4QgruqiTeFzXKnsdD1arjgiI4J0kn7ufj4+aJ6RDbe98QFBhfF8Q/8dxi7MB2W0v14smDjCyy7nZTTaesLOGooKfnctH8Prwtji4xlzHpeYuwrg537BwJntM4JXfZZju0A1NcypIosngbea+YeG0oOL3PfBnQIk0J5ZlAC7F/EpN+13a/EDU0Mg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(5660300002)(40460700003)(478600001)(26005)(36756003)(1076003)(426003)(16526019)(36860700001)(81166007)(41300700001)(356005)(336012)(2616005)(83380400001)(86362001)(47076005)(82740400003)(2906002)(6666004)(40480700001)(44832011)(110136005)(70586007)(70206006)(316002)(54906003)(4326008)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:05:41.1680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d75636a1-e4e6-44e0-ec16-08dbf201419a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406

From: Brett Creeley <brett.creeley@amd.com>

Each time a VF attribute is set via iproute a call to get the VF
configuration is also made. This is currently problematic because for
each VF configuration call there are multiple commands sent to the
device. Unfortunately, this doesn't scale well. Fix this by reporting
the cached VF attributes.

The original change to query the device for getting the VF attributes
was made to remain consistent with device set VF attributes. However,
after further investigation there is no need to query the device.

Fixes: f16f5be31009 ("ionic: Query FW when getting VF info via ndo_get_vf_config")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h   |  2 -
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 40 --------
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  3 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 93 ++-----------------
 .../net/ethernet/pensando/ionic/ionic_main.c  | 22 -----
 5 files changed, 11 insertions(+), 149 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 2453a40f6ee8..9ffef2e06885 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -91,6 +91,4 @@ int ionic_port_identify(struct ionic *ionic);
 int ionic_port_init(struct ionic *ionic);
 int ionic_port_reset(struct ionic *ionic);
 
-const char *ionic_vf_attr_to_str(enum ionic_vf_attr attr);
-
 #endif /* _IONIC_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index c06576f43916..bb9245d933e4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -469,46 +469,6 @@ int ionic_set_vf_config(struct ionic *ionic, int vf,
 	return err;
 }
 
-int ionic_dev_cmd_vf_getattr(struct ionic *ionic, int vf, u8 attr,
-			     struct ionic_vf_getattr_comp *comp)
-{
-	union ionic_dev_cmd cmd = {
-		.vf_getattr.opcode = IONIC_CMD_VF_GETATTR,
-		.vf_getattr.attr = attr,
-		.vf_getattr.vf_index = cpu_to_le16(vf),
-	};
-	int err;
-
-	if (vf >= ionic->num_vfs)
-		return -EINVAL;
-
-	switch (attr) {
-	case IONIC_VF_ATTR_SPOOFCHK:
-	case IONIC_VF_ATTR_TRUST:
-	case IONIC_VF_ATTR_LINKSTATE:
-	case IONIC_VF_ATTR_MAC:
-	case IONIC_VF_ATTR_VLAN:
-	case IONIC_VF_ATTR_RATE:
-		break;
-	case IONIC_VF_ATTR_STATSADDR:
-	default:
-		return -EINVAL;
-	}
-
-	mutex_lock(&ionic->dev_cmd_lock);
-	ionic_dev_cmd_go(&ionic->idev, &cmd);
-	err = ionic_dev_cmd_wait_nomsg(ionic, DEVCMD_TIMEOUT);
-	memcpy_fromio(comp, &ionic->idev.dev_cmd_regs->comp.vf_getattr,
-		      sizeof(*comp));
-	mutex_unlock(&ionic->dev_cmd_lock);
-
-	if (err && comp->status != IONIC_RC_ENOSUPP)
-		ionic_dev_cmd_dev_err_print(ionic, cmd.vf_getattr.opcode,
-					    comp->status, err);
-
-	return err;
-}
-
 void ionic_vf_start(struct ionic *ionic)
 {
 	union ionic_dev_cmd cmd = {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 9b5463040075..745a3292be92 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -341,8 +341,7 @@ void ionic_dev_cmd_port_pause(struct ionic_dev *idev, u8 pause_type);
 
 int ionic_set_vf_config(struct ionic *ionic, int vf,
 			struct ionic_vf_setattr_cmd *vfc);
-int ionic_dev_cmd_vf_getattr(struct ionic *ionic, int vf, u8 attr,
-			     struct ionic_vf_getattr_comp *comp);
+
 void ionic_dev_cmd_queue_identify(struct ionic_dev *idev,
 				  u16 lif_type, u8 qtype, u8 qver);
 void ionic_vf_start(struct ionic *ionic);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index edc14730ce88..afb77e2d04c5 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -2332,82 +2332,11 @@ static int ionic_eth_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd
 	}
 }
 
-static int ionic_get_fw_vf_config(struct ionic *ionic, int vf, struct ionic_vf *vfdata)
-{
-	struct ionic_vf_getattr_comp comp = { 0 };
-	int err;
-	u8 attr;
-
-	attr = IONIC_VF_ATTR_VLAN;
-	err = ionic_dev_cmd_vf_getattr(ionic, vf, attr, &comp);
-	if (err && comp.status != IONIC_RC_ENOSUPP)
-		goto err_out;
-	if (!err)
-		vfdata->vlanid = comp.vlanid;
-
-	attr = IONIC_VF_ATTR_SPOOFCHK;
-	err = ionic_dev_cmd_vf_getattr(ionic, vf, attr, &comp);
-	if (err && comp.status != IONIC_RC_ENOSUPP)
-		goto err_out;
-	if (!err)
-		vfdata->spoofchk = comp.spoofchk;
-
-	attr = IONIC_VF_ATTR_LINKSTATE;
-	err = ionic_dev_cmd_vf_getattr(ionic, vf, attr, &comp);
-	if (err && comp.status != IONIC_RC_ENOSUPP)
-		goto err_out;
-	if (!err) {
-		switch (comp.linkstate) {
-		case IONIC_VF_LINK_STATUS_UP:
-			vfdata->linkstate = IFLA_VF_LINK_STATE_ENABLE;
-			break;
-		case IONIC_VF_LINK_STATUS_DOWN:
-			vfdata->linkstate = IFLA_VF_LINK_STATE_DISABLE;
-			break;
-		case IONIC_VF_LINK_STATUS_AUTO:
-			vfdata->linkstate = IFLA_VF_LINK_STATE_AUTO;
-			break;
-		default:
-			dev_warn(ionic->dev, "Unexpected link state %u\n", comp.linkstate);
-			break;
-		}
-	}
-
-	attr = IONIC_VF_ATTR_RATE;
-	err = ionic_dev_cmd_vf_getattr(ionic, vf, attr, &comp);
-	if (err && comp.status != IONIC_RC_ENOSUPP)
-		goto err_out;
-	if (!err)
-		vfdata->maxrate = comp.maxrate;
-
-	attr = IONIC_VF_ATTR_TRUST;
-	err = ionic_dev_cmd_vf_getattr(ionic, vf, attr, &comp);
-	if (err && comp.status != IONIC_RC_ENOSUPP)
-		goto err_out;
-	if (!err)
-		vfdata->trusted = comp.trust;
-
-	attr = IONIC_VF_ATTR_MAC;
-	err = ionic_dev_cmd_vf_getattr(ionic, vf, attr, &comp);
-	if (err && comp.status != IONIC_RC_ENOSUPP)
-		goto err_out;
-	if (!err)
-		ether_addr_copy(vfdata->macaddr, comp.macaddr);
-
-err_out:
-	if (err)
-		dev_err(ionic->dev, "Failed to get %s for VF %d\n",
-			ionic_vf_attr_to_str(attr), vf);
-
-	return err;
-}
-
 static int ionic_get_vf_config(struct net_device *netdev,
 			       int vf, struct ifla_vf_info *ivf)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
 	struct ionic *ionic = lif->ionic;
-	struct ionic_vf vfdata = { 0 };
 	int ret = 0;
 
 	if (!netif_device_present(netdev))
@@ -2418,18 +2347,16 @@ static int ionic_get_vf_config(struct net_device *netdev,
 	if (vf >= pci_num_vf(ionic->pdev) || !ionic->vfs) {
 		ret = -EINVAL;
 	} else {
-		ivf->vf = vf;
-		ivf->qos = 0;
-
-		ret = ionic_get_fw_vf_config(ionic, vf, &vfdata);
-		if (!ret) {
-			ivf->vlan         = le16_to_cpu(vfdata.vlanid);
-			ivf->spoofchk     = vfdata.spoofchk;
-			ivf->linkstate    = vfdata.linkstate;
-			ivf->max_tx_rate  = le32_to_cpu(vfdata.maxrate);
-			ivf->trusted      = vfdata.trusted;
-			ether_addr_copy(ivf->mac, vfdata.macaddr);
-		}
+		struct ionic_vf *vfdata = &ionic->vfs[vf];
+
+		ivf->vf		  = vf;
+		ivf->qos	  = 0;
+		ivf->vlan         = le16_to_cpu(vfdata->vlanid);
+		ivf->spoofchk     = vfdata->spoofchk;
+		ivf->linkstate    = vfdata->linkstate;
+		ivf->max_tx_rate  = le32_to_cpu(vfdata->maxrate);
+		ivf->trusted      = vfdata->trusted;
+		ether_addr_copy(ivf->mac, vfdata->macaddr);
 	}
 
 	up_read(&ionic->vf_op_lock);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 835577392178..8d15f9203bd5 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -188,28 +188,6 @@ static const char *ionic_opcode_to_str(enum ionic_cmd_opcode opcode)
 	}
 }
 
-const char *ionic_vf_attr_to_str(enum ionic_vf_attr attr)
-{
-	switch (attr) {
-	case IONIC_VF_ATTR_SPOOFCHK:
-		return "IONIC_VF_ATTR_SPOOFCHK";
-	case IONIC_VF_ATTR_TRUST:
-		return "IONIC_VF_ATTR_TRUST";
-	case IONIC_VF_ATTR_LINKSTATE:
-		return "IONIC_VF_ATTR_LINKSTATE";
-	case IONIC_VF_ATTR_MAC:
-		return "IONIC_VF_ATTR_MAC";
-	case IONIC_VF_ATTR_VLAN:
-		return "IONIC_VF_ATTR_VLAN";
-	case IONIC_VF_ATTR_RATE:
-		return "IONIC_VF_ATTR_RATE";
-	case IONIC_VF_ATTR_STATSADDR:
-		return "IONIC_VF_ATTR_STATSADDR";
-	default:
-		return "IONIC_VF_ATTR_UNKNOWN";
-	}
-}
-
 static void ionic_adminq_flush(struct ionic_lif *lif)
 {
 	struct ionic_desc_info *desc_info;
-- 
2.17.1


