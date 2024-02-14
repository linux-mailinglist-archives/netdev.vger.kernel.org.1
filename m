Return-Path: <netdev+bounces-71723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAEE854D52
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD941F29A4B
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689885D901;
	Wed, 14 Feb 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QYaHDMcE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9C5FDAC
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925792; cv=fail; b=HWgCy/d7immt0RM3e50mRq19qTvOWX6fmygIa8RM9iKQLu1804FO1nOvKNrR+4mbSsJDU0yMvjEamTxUJHu4v1Z3LkpchDNZZeFLZGJQ+bYHmwHjXqLo71EUUi1/nu7XhRXd3sdPa8103o7joJq7SKPSXA7Qjn7MjbDCE1G2sqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925792; c=relaxed/simple;
	bh=cgcJtInRlCFLdyPOs68sGm/s7z9A5HW5MV79AjAv3so=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sW7QXZDBRE4d1XmnWlDQPkH1PM19VDx7XEVxslZBigB0BKFmDTzi2stSh6GITyRBTyNHp7zcHAS9T2Wo3eXxfnQTlekdenHa8zATuxnoFL4w6qFm274ykUKdOQurswcjoOyfmrqKhBShMGwAwKYR8k78VNr1n0oG4bUy2E7YAwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QYaHDMcE; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/FTh4Qu1+/t67BLpAUQ3T5PtJOgbdGa0hI/tIw3G57CWcO3RmyBRNLRQPHLVP4P4sq3B3BqaG3az/sBg6+cwmw6Wf2v2du0Y+PSIR6ILLQ1KI3VjrubbiXawdrykKiUfCpHCiieXf8JFj3BU3vd8IXRqNrGiWjRdb6e1oab6AGLJ80RSWOgiDSzQTKmnlCwGXjfDVJblJjhiS6tSaSmsgcwKPZQw9TLw3OZkg2KlOmWDD3dRJNO7+Bq2bloUjFPDw+OMIKQZQ4ddSjAzvGI3Gxv/LQcQZTBOi6OICrF/a9JnN6uZj+PQ/qPGJy7TMWiWAxNEZlQ7S2EbbswpPazaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBRICyr/LE/ttgZLcK1vQNIrxz/uJFNvFNtxifyaBv8=;
 b=FS5Wxsk9hyKKZEYM9B1QsvM2mQIStHLz4XMhaCX6z8vOnyrYuQpC72yIUuFBQ9GDa+ZZdVAUGB27FZajnVldJz0KXPBKr7B+2Yb8BnGKveoT4ZCoo1P31RpenWpr433mpkoyAnmMi/tzSmYNgfAl7L0/qrCvcLGB4VeNLymKmsETWenT8AiXgjB5kXzR6pw2zc6lLqwH8xdcjatgVTR4HDSFU+mY0CPX93EroX7xv4RhJiVEnTrk6wsAYvd6i/UOZPDgYMScU1JClX7Q8VbhJOjEk+Gd5rCggZN/s7E6rOi6AV+c2b/WrdTFlHXo5CLK+m61PLySWOAZZ5DDuwLPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBRICyr/LE/ttgZLcK1vQNIrxz/uJFNvFNtxifyaBv8=;
 b=QYaHDMcECJQ4UXuyk3TlR1yAOBPhDBoX8PMGEVGjB9NyrAWPeqzISQsA1jK9G9fCzVs2miEmBgjbi1vKGOOgTSlPKUtICJk3WAeCocjYUvy6NXi4g+JSR7frNx08U3z0YDUvBYcX/C4n5y+pTPqBujdInImg+W576PZWWjeFYbU=
Received: from DM6PR18CA0018.namprd18.prod.outlook.com (2603:10b6:5:15b::31)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Wed, 14 Feb
 2024 15:49:47 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::89) by DM6PR18CA0018.outlook.office365.com
 (2603:10b6:5:15b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 15:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 15:49:46 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 09:49:43 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: [PATCH v5 net-next 3/5] amd-xgbe: add support for new XPCS routines
Date: Wed, 14 Feb 2024 21:18:40 +0530
Message-ID: <20240214154842.3577628-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 49690358-cb14-43e9-96a4-08dc2d74920f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EgrrSEa5g3DY4wRBPUM99xDwEOmkW/L1C5luV856QIIfBxINaseQkwxaCOms6tQskTcyHVlQhr8JLAftbOz4zry7qwpUD1Yeqkr55NBnpoI/PZydGkBDJnDfXfskAdV1KaGlkRs/2p9pnqz0uugUprMIheYh/A+A6CSk3HDnFR56fn77ZYNK24+2ldJLipUz1ZTxSETASkNpppJSXpxuw+WHH+HmJ5WoII7r50wcort+P9PXcpI+uzhGXwPNQfwEO7GXg8VlwJyeSYLKG2+saHcTVrSfJCIkc0yKglqiTUuUH+9TAnjd+RyrLGBM0xwD8aLt6Wnq+oZMUuUXfDBbOYO5KL8Qlld1l76SafdLKllvdk3ZrW1h8uQHivF0RhrG5TVjB7dFiZB20SSZQ4eY/ZViAoIhX8PLXJxoFK8wPQVMtIKISP6lAZL29qd0c+zTiVptDjs4DJYAuuE+njsKSYsQns3pXJBI/92BPo4EumzoZI4BWz7a/W8B2Ycmongdpn0Z1virDOKQF3HU2FvqTlFj/iaCTtSgoG1+5gwv+BU93fC/X8B/wychKSaqDOlOfd3GYzmwcjZoMijTlE25eA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(230473577357003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(66899024)(30864003)(4326008)(5660300002)(8676002)(2906002)(41300700001)(8936002)(81166007)(86362001)(356005)(83380400001)(82740400003)(70206006)(1076003)(26005)(36756003)(70586007)(478600001)(426003)(54906003)(6916009)(7696005)(336012)(316002)(16526019)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:49:46.8937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49690358-cb14-43e9-96a4-08dc2d74920f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

Add the necessary support to enable Crater ethernet device. Since the
BAR1 address cannot be used to access the XPCS registers on Crater, use
the smn functions.

Some of the ethernet add-in-cards have dual PHY but share a single MDIO
line (between the ports). In such cases, link inconsistencies are
noticed during the heavy traffic and during reboot stress tests. Using
smn calls helps avoid such race conditions.

Suggested-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c |  61 ++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-smn.h | 139 +++++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h     |   6 +
 3 files changed, 206 insertions(+)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 197da2993471..0c7ef15860a9 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -123,6 +123,7 @@
 
 #include "xgbe.h"
 #include "xgbe-common.h"
+#include "xgbe-smn.h"
 
 static inline unsigned int xgbe_get_max_frame(struct xgbe_prv_data *pdata)
 {
@@ -1175,6 +1176,60 @@ static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
 	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
 }
 
+static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
+				 int mmd_reg)
+{
+	unsigned int mmd_address, index, offset;
+	unsigned long flags;
+	int mmd_data;
+
+	mmd_address = get_mmd_address(pdata, mmd_reg);
+
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
+
+	spin_lock_irqsave(&pdata->xpcs_lock, flags);
+	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
+	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
+				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+
+	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
+
+	return mmd_data;
+}
+
+static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
+				   int mmd_reg, int mmd_data)
+{
+	unsigned int pci_mmd_data, hi_mask, lo_mask;
+	unsigned int mmd_address, index, offset;
+	unsigned long flags;
+
+	mmd_address = get_mmd_address(pdata, mmd_reg);
+
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
+
+	spin_lock_irqsave(&pdata->xpcs_lock, flags);
+	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	amd_smn_read(0, pdata->smn_base + offset, &pci_mmd_data);
+
+	if (offset % 4) {
+		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data);
+		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
+	} else {
+		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK,
+				     FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data));
+		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+	}
+
+	pci_mmd_data = hi_mask | lo_mask;
+
+	amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
+	amd_smn_write(0, (pdata->smn_base + offset), pci_mmd_data);
+
+	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
+}
+
 static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 				 int mmd_reg)
 {
@@ -1269,6 +1324,9 @@ static int xgbe_read_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
+
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
 	}
 }
 
@@ -1282,6 +1340,9 @@ static void xgbe_write_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
+
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
 	}
 }
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-smn.h b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
new file mode 100644
index 000000000000..a1fb499b8637
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
@@ -0,0 +1,139 @@
+/*
+ * AMD 10Gb Ethernet driver
+ *
+ * This file is available to you under your choice of the following two
+ * licenses:
+ *
+ * License 1: GPLv2
+ *
+ * Copyright (c) 2024 Advanced Micro Devices, Inc.
+ *
+ * This file is free software; you may copy, redistribute and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * This file incorporates work covered by the following copyright and
+ * permission notice:
+ *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
+ *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
+ *     Inc. unless otherwise expressly agreed to in writing between Synopsys
+ *     and you.
+ *
+ *     The Software IS NOT an item of Licensed Software or Licensed Product
+ *     under any End User Software License Agreement or Agreement for Licensed
+ *     Product with Synopsys or any supplement thereto.  Permission is hereby
+ *     granted, free of charge, to any person obtaining a copy of this software
+ *     annotated with this license and the Software, to deal in the Software
+ *     without restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
+ *     of the Software, and to permit persons to whom the Software is furnished
+ *     to do so, subject to the following conditions:
+ *
+ *     The above copyright notice and this permission notice shall be included
+ *     in all copies or substantial portions of the Software.
+ *
+ *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
+ *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
+ *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+ *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
+ *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ *     THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *
+ * License 2: Modified BSD
+ *
+ * Copyright (c) 2024 Advanced Micro Devices, Inc.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Advanced Micro Devices, Inc. nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * This file incorporates work covered by the following copyright and
+ * permission notice:
+ *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
+ *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
+ *     Inc. unless otherwise expressly agreed to in writing between Synopsys
+ *     and you.
+ *
+ *     The Software IS NOT an item of Licensed Software or Licensed Product
+ *     under any End User Software License Agreement or Agreement for Licensed
+ *     Product with Synopsys or any supplement thereto.  Permission is hereby
+ *     granted, free of charge, to any person obtaining a copy of this software
+ *     annotated with this license and the Software, to deal in the Software
+ *     without restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
+ *     of the Software, and to permit persons to whom the Software is furnished
+ *     to do so, subject to the following conditions:
+ *
+ *     The above copyright notice and this permission notice shall be included
+ *     in all copies or substantial portions of the Software.
+ *
+ *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
+ *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
+ *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+ *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
+ *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ *     THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *     Author: Raju Rangoju <Raju.Rangoju@amd.com>
+ */
+
+#ifndef __SMN_H__
+#define __SMN_H__
+
+#ifdef CONFIG_AMD_NB
+
+#include <asm/amd_nb.h>
+
+#else
+
+static inline int amd_smn_write(u16 node, u32 address, u32 value)
+{
+	return -ENODEV;
+}
+
+static inline int amd_smn_read(u16 node, u32 address, u32 *value)
+{
+	return -ENODEV;
+}
+
+#endif
+#endif
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index eda909235d48..60882a46fe50 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -351,6 +351,10 @@
 #define XGBE_RV_PCI_DEVICE_ID	0x15d0
 #define XGBE_YC_PCI_DEVICE_ID	0x14b5
 
+ /* Generic low and high masks */
+#define XGBE_GEN_HI_MASK	GENMASK(31, 16)
+#define XGBE_GEN_LO_MASK	GENMASK(15, 0)
+
 struct xgbe_prv_data;
 
 struct xgbe_packet_data {
@@ -569,6 +573,7 @@ enum xgbe_speed {
 enum xgbe_xpcs_access {
 	XGBE_XPCS_ACCESS_V1 = 0,
 	XGBE_XPCS_ACCESS_V2,
+	XGBE_XPCS_ACCESS_V3,
 };
 
 enum xgbe_an_mode {
@@ -1060,6 +1065,7 @@ struct xgbe_prv_data {
 	struct device *dev;
 	struct platform_device *phy_platdev;
 	struct device *phy_dev;
+	unsigned int smn_base;
 
 	/* Version related data */
 	struct xgbe_version_data *vdata;
-- 
2.34.1


