Return-Path: <netdev+bounces-145940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D69D1593
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151D6282028
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFD51BD9FE;
	Mon, 18 Nov 2024 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pcSZ1BoH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124FA1B21A0;
	Mon, 18 Nov 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948297; cv=fail; b=j5ljNcZQjnB4U8dZ2JfWxhe/G6ZkZWTqwzvwSJxHhpHtwB5jJI3vqlVuTls50NDHcWKYPotDXuSC01ADzC7hvhWTKXu/BiJJ6QSYwfqAn0WjKJJ/aRnT43b5/xQoI1/McCkSPSUrfqr+kn4c1f+qLa1GKydlawFZAT6fa9bb5Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948297; c=relaxed/simple;
	bh=c397+EhGdBS8RubIdjXdiwD9wYDg5CZLNS4bzsq4HpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru823KWyyTmPzl7WgUhwQiGf2KTrL0tPpj2R2MFv1f8cpc6UFD4SK7+zQtjnPLIFO2d3P2heTqyx+ixr6Mg5Xg8R/Y61V3T3GQN7/YtWNTcSMxrdMyZkvYUj07gfwMQCaB7MRUtcljtRynAaiOXdsQ1+a1tZWm95u9zQDlTEHPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pcSZ1BoH; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owr+Zsqg6tYdq7k2NbyThLck3AcVNcM50bCjuEGSSBCdGUNKLIiuv1hSCQsoih16wWd9ZiiO8NI+jpaQu4ZIgg+R4tV/oYq6C15BlDOi3aXqD9W4Ck6YaQnGKl+dCUX8etJtNhFBVFqZlCdgXO6eDDadt0Jo5uwri7pQmsAGnGuXzMgh5PAMmSV5pu7WHjvzKi85ApIuEL7gJYOGo13CiysPT1UN2bdiP2E/8SA3Smz21UVEMiaSCtvD2cr+rPyR4CBvC/mfpAzh1x0tXoTZXzllNPuQI+JR8RJ9XTfRJu1+boDtI6uzrD/I6j+WO2sjRevbfet9W14SyZRt0oQHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVsWLhdl7emdrhRbyOLtZDspItqRqvXsYVF45eQc2B4=;
 b=RZkjDRrTqXo/EHf6NA6vgdPsxI+a27Cq2vlMJEuHT2XrVrVqVvV6miucA6C8UCnk6UYoipnFk/AT1yaobPLEXVyrx6sbW66qwn1qVtV6VUAlXBbfXyBi2dQpauvccxUXINIOPTfsDiqXNCbApAV7N6ElnPm1WuzbRtKkLFnnjgNXXisZbCayNSWBDy6AZNz09RaMgG9yRpJcI0QQ6T+7MD/cnXTQ40Yx0agb2uX1e3uywwzM1c4cGtqnYlShlHtjJtAhLyKQXyRxLZBrNWvRcjgHd2aL3wDCPgPLfKIwmXP3icKryLFrXSzq21FsMXakvQUmOeLO9/huw2qgAOsvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVsWLhdl7emdrhRbyOLtZDspItqRqvXsYVF45eQc2B4=;
 b=pcSZ1BoHbvL9GyVb6u9b7HMauHgIqCaBtgAjtXVWku2aSFfRF8eboiCGIZbJaBCQQvfIrDL0YpkwT99LFqnyPWhhtbLi8DmOGCKF0HoBuUaLwsZ+pl2EC0d0N2GoNgfPQ9c1OgGMpH3dpVVlFNTa1EW4IKNqgd9zuzxPmc1nvMw=
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:44:49 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::8a) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:44:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:48 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:48 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:47 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 03/27] cxl: add capabilities field to cxl_dev_state and cxl_port
Date: Mon, 18 Nov 2024 16:44:10 +0000
Message-ID: <20241118164434.7551-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 8796f64b-fca8-4b52-749a-08dd07f0511f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aYPJG4ak9kFUNFt2r43OXPgZxqJAGHmhZrGWOIB80sLB3p6p8qti0lrXXH11?=
 =?us-ascii?Q?YsgwO39ixyW3TnBVj6M2gHJyqsREe4m6MPON5pLUlm0obnyQQdPDrlcE04be?=
 =?us-ascii?Q?E01k0vJ4lspnyZWGftqr+lxfksonDlR9wsUaNsQfW/NbdhkUxupiQHXelmq8?=
 =?us-ascii?Q?Kgv1NgZcbJXtpWmtJuMsqJMvAK1qddclkwIWdh+t0Pq1ScfA+hGAuUSDeSe0?=
 =?us-ascii?Q?tqEwTENU0qaGS6VhWeHPpHdSEkGEFyskrZPv17V9Ac0tY4urQeLj8wyM8HDo?=
 =?us-ascii?Q?2lUINbUwhT7EbchEtoxsfmPKYt7kOmOdF2sIhuiCI3aX0CbLh/5ISM8nLAqZ?=
 =?us-ascii?Q?eqYcZt7P9VDkVtx/eeAx/jwjWcV49m6rVUWIT2CX3XHf1c5ahU0Mvv/3tD3k?=
 =?us-ascii?Q?UT8xMv2OGXTOVk9w5VuYiEQ9Y+o0tzYo3d6NzM1kIPUdwno+dtfFAGY2yMLo?=
 =?us-ascii?Q?pRcbE/8bfgTSf2Vm4CCsGRiZGKji8EfMkIgaO8FoMln68urbmZ+n6k2gXZ47?=
 =?us-ascii?Q?JI4qpAIQsvkLvmiA463y10uT6lIU6Zjm82WCEQtTppxssZ0sq5sWMM1S+LA8?=
 =?us-ascii?Q?zc7ToYTsCnawPbEB77idb9/6wC6lg05jA4e4A/46Fcb18qT7h9XMWZLqluvH?=
 =?us-ascii?Q?I8vt6XroGnKJi2q5PDJw4DE/qcIKFhXxifUBL/2kZ+ddZJw/hWAK31mVStiX?=
 =?us-ascii?Q?XcxQcSvj3hXPgy8rkATagGVWUaHE1D4LeoKpg1II77Fyj7j4GkS3WCl47GKY?=
 =?us-ascii?Q?IHbjdpDEwZSdQONkY/DYP5ayeDLXSuptgyi+obuzUCKLC861ZM9izaho09wG?=
 =?us-ascii?Q?Rl4DR0m6M7EH84pH5EH7jgAUqRePDTC6I1PPHVzaY30IB6E3BdtH8hp3X8Ko?=
 =?us-ascii?Q?GRXPM4HfygYx2SB1p5zT7pUkCrS1kpIW2oWkOixuHOxE+YxANC2oRyRg64vl?=
 =?us-ascii?Q?xheCzMIUYdMrjVIjK06ub5X61GLqyIxUZyAT0ENa28ZKTJfzB0qD9oZNayG0?=
 =?us-ascii?Q?X7IdkY+NoWYHayoqzZgZfU6YhfEAyaAq8lpzrSxi0MMUDmBwyCxw8rjGyRBi?=
 =?us-ascii?Q?4WGW+EgJAnSS9UgHDJcQUL6aaK9q5qOKwqXSYwix8aUTEgeRS7YDNTt0PsG4?=
 =?us-ascii?Q?fZ6GhkRj3sZ/rV3+XSRn62RhzLG8t+PgsAww6jAINbxzdGtPuVgvgOrwRYWz?=
 =?us-ascii?Q?cBMU2ins4LfSfm/YKAjNOgdmDmgvW9ry0UmSLEtof8G3+dIAUPWirS3NQg5F?=
 =?us-ascii?Q?abSmhRS7rqp2HB3PEuDjV00pvkrhpbsaD6VaDREM1jpAODkccLntEbEyahj/?=
 =?us-ascii?Q?ZF2PtjOkKNZBzdR6IIyho9xh//F+VGP5XBG6bdcF1HG9Maa4Jtls04FwTaRk?=
 =?us-ascii?Q?Klz5ngJXHTsCpIjU770zMfZPmN5VgDZsV9hE8HC2s+AZIBpgMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:44:49.0258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8796f64b-fca8-4b52-749a-08dd07f0511f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435

From: Alejandro Lucero <alucerop@amd.com>

Type2 devices have some Type3 functionalities as optional like an mbox
or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
implements.

Add a new field to cxl_dev_state for keeping device capabilities as discovered
during initialization. Add same field to cxl_port as registers discovery
is also used during port initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/port.c | 11 +++++++----
 drivers/cxl/core/regs.c | 21 ++++++++++++++-------
 drivers/cxl/cxl.h       |  9 ++++++---
 drivers/cxl/cxlmem.h    |  2 ++
 drivers/cxl/pci.c       | 10 ++++++----
 include/cxl/cxl.h       | 30 ++++++++++++++++++++++++++++++
 6 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index af92c67bc954..5bc8490a199c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -749,7 +749,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 }
 
 static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
-			       resource_size_t component_reg_phys)
+			       resource_size_t component_reg_phys, unsigned long *caps)
 {
 	*map = (struct cxl_register_map) {
 		.host = host,
@@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
 	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
 	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 
 static int cxl_port_setup_regs(struct cxl_port *port,
@@ -772,7 +772,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 	if (dev_is_platform(port->uport_dev))
 		return 0;
 	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
-				   component_reg_phys);
+				   component_reg_phys, port->capabilities);
 }
 
 static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
@@ -789,7 +789,8 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	 * NULL.
 	 */
 	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
-				 component_reg_phys);
+				 component_reg_phys,
+				 dport->port->capabilities);
 	dport->reg_map.host = host;
 	return rc;
 }
@@ -851,6 +852,8 @@ static int cxl_port_add(struct cxl_port *port,
 		port->reg_map = cxlds->reg_map;
 		port->reg_map.host = &port->dev;
 		cxlmd->endpoint = port;
+		bitmap_copy(port->capabilities, cxlds->capabilities,
+			    CXL_MAX_CAPS);
 	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
 		if (rc)
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e1082e749c69..8287ec45b018 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <pmu.h>
@@ -36,7 +37,8 @@
  * Probe for component register information and return it in map object.
  */
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map)
+			      struct cxl_component_reg_map *map,
+			      unsigned long *caps)
 {
 	int cap, cap_count;
 	u32 cap_array;
@@ -84,6 +86,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 			rmap = &map->hdm_decoder;
+			*caps |= BIT(CXL_DEV_CAP_HDM);
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
@@ -91,6 +94,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 				offset);
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
+			*caps |= BIT(CXL_DEV_CAP_RAS);
 			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
@@ -117,7 +121,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
  * Probe for device register information and return it in map object.
  */
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map)
+			   struct cxl_device_reg_map *map, unsigned long *caps)
 {
 	int cap, cap_count;
 	u64 cap_array;
@@ -146,10 +150,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
 			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
 			rmap = &map->status;
+			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
 			rmap = &map->mbox;
+			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
@@ -157,6 +163,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
 			rmap = &map->memdev;
+			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
 			break;
 		default:
 			if (cap_id >= 0x8000)
@@ -421,7 +428,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
@@ -431,12 +438,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
-		cxl_probe_component_regs(host, base, comp_map);
+		cxl_probe_component_regs(host, base, comp_map, caps);
 		dev_dbg(host, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
-		cxl_probe_device_regs(host, base, dev_map);
+		cxl_probe_device_regs(host, base, dev_map, caps);
 		if (!dev_map->status.valid || !dev_map->mbox.valid ||
 		    !dev_map->memdev.valid) {
 			dev_err(host, "registers not found: %s%s%s\n",
@@ -455,7 +462,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	return 0;
 }
 
-int cxl_setup_regs(struct cxl_register_map *map)
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	int rc;
 
@@ -463,7 +470,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
 	if (rc)
 		return rc;
 
-	rc = cxl_probe_regs(map);
+	rc = cxl_probe_regs(map, caps);
 	cxl_unmap_regblock(map);
 
 	return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a2be05fd7aa2..e5f918be6fe4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -4,6 +4,7 @@
 #ifndef __CXL_H__
 #define __CXL_H__
 
+#include <cxl/cxl.h>
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
 #include <linux/notifier.h>
@@ -284,9 +285,9 @@ struct cxl_register_map {
 };
 
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map);
+			      struct cxl_component_reg_map *map, unsigned long *caps);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map);
+			   struct cxl_device_reg_map *map, unsigned long *caps);
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
@@ -300,7 +301,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, int index);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
 struct cxl_dport;
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
@@ -600,6 +601,7 @@ struct cxl_dax_region {
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
+ * @capabilities: those capabilities as defined in device mapped registers
  */
 struct cxl_port {
 	struct device dev;
@@ -623,6 +625,7 @@ struct cxl_port {
 	} cdat;
 	bool cdat_available;
 	long pci_latency;
+	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
 };
 
 /**
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..4c1c53c29544 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -428,6 +428,7 @@ struct cxl_dpa_perf {
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
  * @cxl_mbox: CXL mailbox context
+ * @capabilities: those capabilities as defined in device mapped registers
  */
 struct cxl_dev_state {
 	struct device *dev;
@@ -443,6 +444,7 @@ struct cxl_dev_state {
 	u64 serial;
 	enum cxl_devtype type;
 	struct cxl_mailbox cxl_mbox;
+	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
 };
 
 static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0b910ef52db7..528d4ca79fd1 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -504,7 +504,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 }
 
 static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
+			      struct cxl_register_map *map,
+			      unsigned long *caps)
 {
 	int rc;
 
@@ -521,7 +522,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	if (rc)
 		return rc;
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
@@ -848,7 +849,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxl_set_dvsec(cxlds, dvsec);
 
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				cxlds->capabilities);
 	if (rc)
 		return rc;
 
@@ -861,7 +863,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
-				&cxlds->reg_map);
+				&cxlds->reg_map, cxlds->capabilities);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 	else if (!cxlds->reg_map.component_map.ras.valid)
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 19e5d883557a..dcc9ec8a0aec 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -12,6 +12,36 @@ enum cxl_resource {
 	CXL_RES_PMEM,
 };
 
+/* Capabilities as defined for:
+ *
+ *	Component Registers (Table 8-22 CXL 3.1 specification)
+ *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
+ */
+
+enum cxl_dev_cap {
+	/* capabilities from Component Registers */
+	CXL_DEV_CAP_RAS,
+	CXL_DEV_CAP_SEC,
+	CXL_DEV_CAP_LINK,
+	CXL_DEV_CAP_HDM,
+	CXL_DEV_CAP_SEC_EXT,
+	CXL_DEV_CAP_IDE,
+	CXL_DEV_CAP_SNOOP_FILTER,
+	CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
+	CXL_DEV_CAP_CACHEMEM_EXT,
+	CXL_DEV_CAP_BI_ROUTE_TABLE,
+	CXL_DEV_CAP_BI_DECODER,
+	CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
+	CXL_DEV_CAP_CACHEID_DECODER,
+	CXL_DEV_CAP_HDM_EXT,
+	CXL_DEV_CAP_METADATA_EXT,
+	/* capabilities from Device Registers */
+	CXL_DEV_CAP_DEV_STATUS,
+	CXL_DEV_CAP_MAILBOX_PRIMARY,
+	CXL_DEV_CAP_MEMDEV,
+	CXL_MAX_CAPS = 32
+};
+
 struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
 
 void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
-- 
2.17.1


