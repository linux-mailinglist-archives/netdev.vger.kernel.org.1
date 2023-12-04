Return-Path: <netdev+bounces-53666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6888040C5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C62281370
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F058364B8;
	Mon,  4 Dec 2023 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TZtAyZqe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB710A9
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 13:10:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMrsOD9T5E7vKueFf4Dvdsrca5P2KKq8f/dljXVJ5vOBShGysDbM22EkffJLpc0wQLgJlDt+ofNwOTsAstY/l+PqDxuE/2AdZ6R6TexwIBFlzTaEzP438bE82IanjC+hPXv0ssD6t0XyAfPIrUZ0Usx7br/YNVO4E90Sg2VttPydqsM1OHoAczhGh+1msHr2f0Kzb5/X8hrcG+gvrWTioxv+2ksKkZCD9zJ+Cnk5useVdpLtU+Zo7+LMbEcMNukA1w6VAax0F/BWYX7LQZxCk/PYpj4LG0UZ0w+oZOOz4JCQL4eov2Sxtnldk6wbJ+E2QBoRbeqGR4CV8+LC2xq2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEIaGqqr+6Ro+gaiF/nKTRkXBYJIxdk7GPifBtA0YKo=;
 b=ZL7ggd5YEentmqulAbZJKBb5dfwhLfiX+nwMT9uwlPTzTDfDwqkSisO4+qcry6H8iVTuTzFld/RZ5VhpCtqQxn31doEODPUX96vzXI00U8Yz6xUyPYY/SNdE16drFYfe+tk1P/k97iVDlQpKVXl7YjKGvuj3M7OGNjuVbMLcXKIGLyVmFfEhfGP5oU2FGC1zzkw4ffwWjS9pZiVg7dXcdkYD3qqubB/cALElafDEZbV6sWbOc8HtPdePKuFscbSupfvGJWknqD7WqflKBf3g0zeWfQfCo8xJaslnB5iewZPBK9nv5dneoe1aLdn+mSFq/2W37CLvkpyuwmDInP/vGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEIaGqqr+6Ro+gaiF/nKTRkXBYJIxdk7GPifBtA0YKo=;
 b=TZtAyZqeqjX3VqnGhc/mtZ8eN3ZipnTpjSAflpMOGLa6wU36XJHsZsEKk4nh3ztiDTOtA50cS0buSHPunkRkP5AOvmdJvPg3o6oNpMUHyYUmpJvkXtCOe8E8cuJyfMlo/tWbQOc23nulQWgW8OFRk9eNDFoNnNezdxOj02GBXJk=
Received: from MW4PR03CA0008.namprd03.prod.outlook.com (2603:10b6:303:8f::13)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Mon, 4 Dec
 2023 21:10:01 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::a0) by MW4PR03CA0008.outlook.office365.com
 (2603:10b6:303:8f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32 via Frontend
 Transport; Mon, 4 Dec 2023 21:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 21:10:00 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 15:09:58 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <f.fainelli@gmail.com>, <brett.creeley@amd.com>, <drivers@pensando.io>,
	Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 1/5] ionic: Use cached VF attributes
Date: Mon, 4 Dec 2023 13:09:32 -0800
Message-ID: <20231204210936.16587-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204210936.16587-1-shannon.nelson@amd.com>
References: <20231204210936.16587-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ba9335-614d-4b7e-75d9-08dbf50d60b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O5VOr6Ks8C+Nm6FkuT0YsJJOMFytRgeEHSzubc/U+V5a7nBbCjpyY+4tyrPMjqcvH4oRFRhiWEQl4t0abbyJvcTmyYG7zGr/iLshOELWJd7PPIkC0XCEkY7vM+gMJ3VDIoGTKASKkNSmxMNa9O7KMslVM0CObMbgtDW5mPIUIPRiBdxU1xYxLJvr5Di0yb4ppG+ou3xs9z7Y0v4g7CBKjvPgV3B71duBtNnejqZdr14A7GPEKgExGXSRFIJUsoEoGx5dZ88U+j0ZlnDml2LtAFxishUJnEA+x0RoZK1PKXp3SPJpB1eXMn0Jjh3uiWgGpqmOpvUZUhcegq3LXPl1jZpy1LNtin8VZnukZ0Q5+NON5klNYk2fBi6Zu2op4+rAPF/pwz3lb/bPriYeP7R9lFSKHedjZe+5oqtweolU5+2dq9sssxM9smO3Em/SjZj3Ten1AySJjKGY6LbNTzw3bj7+Q8bUUDO2n3//RkAQVvZ4yCTwRJbkTrWFbv8+Y987NNAzG7tqdpVQIr29awo7N+cJ4t6a6SDOwGGiAiBCgyHJ6pJHcoHta992e1nFPPfBgP6beJhMt7X/SIyVgrir7armFndCIaQ6tm/qzy5Gl/I9kN1Wg+5U4n04xQvZD8iPFZIvFnQsKEUn3q0XqEkU6/Dd2W/xeArNS4htRXboNZYmkrBCJNkx97+PaqlX4uWFw49ZwdybifHLX6LuvWADc1pFby/2xq6FoS1pED2W3JwXmmI+ISNoBhmXVYHmxX89vEHo7EuEgMtl4snOviewIg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(5660300002)(44832011)(40460700003)(86362001)(4326008)(2906002)(8936002)(8676002)(41300700001)(2616005)(36756003)(6666004)(40480700001)(426003)(1076003)(81166007)(356005)(82740400003)(83380400001)(16526019)(26005)(478600001)(336012)(47076005)(36860700001)(110136005)(316002)(54906003)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:10:00.6885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ba9335-614d-4b7e-75d9-08dbf50d60b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739

From: Brett Creeley <brett.creeley@amd.com>

Each time a VF attribute is set via iproute a call to get the VF
configuration is also made. This is currently problematic because for
each VF configuration call there are multiple commands sent to the
device. Unfortunately, this doesn't scale well. Fix this by reporting
the cached VF attributes.

The original change to query the device for getting the VF attributes
    f16f5be31009 ("ionic: Query FW when getting VF info via ndo_get_vf_config")
was made to remain consistent with device set VF attributes. However,
after further investigation there is no need to query the device.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
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
index 1dbc3cb50b1d..19edcb42d9fd 100644
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


