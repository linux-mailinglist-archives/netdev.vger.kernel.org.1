Return-Path: <netdev+bounces-179577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DEAA7DB3A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A973ADA56
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B6D233D88;
	Mon,  7 Apr 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TpHI747h"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EF22CBFA;
	Mon,  7 Apr 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021789; cv=fail; b=cjmC30NfH4PFPHBWKAJHmFnetS+Yf+Jy49Ni3gtCLIc4icSsXuMi9Y5Og63o+QFaEfVHkyisAHEs6YJRGnbjyqyDOX24fIQIymVffSrLSKxAVpHCgj2DLli0IzMSAj+LrhX+rwSWAjRLZRQFnbZwtopsBpQ6gwU7swtxXJS1uZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021789; c=relaxed/simple;
	bh=ZVVaBQDUjnnkv+vBV0yrvDJWHUg188n+YBEoY9j5E7s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dmSZT9VcKLjciMdqH6tKm6tjYLOXuyQdkoOemaVXqWkTCcdpGlu+MJJnT7/kSm54F2t0JvDhVenCbWQEW0/X6nL3BG9hnmH5daEYx4tdZi5HuogLC2jDqjR9sSgKivMzGWOqfZ5DKMKtFbsQv1X7UKqQjcHp1Td2+e7R/oueRzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TpHI747h; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHD1AHc21+7QhREjopnPsubydHcmkq0WUPMvQ6KzWnrIkFzsfIEUDyL2VRZ1MFcjdqsYE9Pe2wrDU2hxeJf2VI+e31ySuFKqe4U9FUadikjJ1NwEAqvma115viId6d9alqpWCI0+qZcNdwoza7JHjHHTT82t4B5DmdrdJTGdra5KgEjkF3KPISogFlbhgNidHvn75T9qqF2Hh9zBgvRgTV9b3ZstQYeKQJlaHrzFeHLIbCuLFhy0dJjOirDCbfYJr8d4ffx5MhikZ276jPksa+ipKbnogKSK+TFbifcChfSkwYJgCpmgkoMjge/hxP8brVXvZjSkbV1NDpa2G+ZltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idRrlMBZ0F/zHSeOPnEjvaEPl54B5ETKBYpuxqB7lQg=;
 b=TvZk1ogbtRr+67xnne52q/OmFkjYzq2PajQcsMRCc5rJliri8IN6pZ+/gAE6maIF8+QFEUG1Y9oXSe4to+dAttzcuiPIJ3rJbEpJWBcRR8N00HUsQ6s5KnfXovQebx9AKMiGq8x6Ds7zoaStxb+uDVfCJdmjQbBI+r5y3VqAXZwd9omEO604VitdFTBjvKslsxeEzRZ6WMoqAm4NmZ0ZlfYCenDB4g+kLW5jO2VF4bSpEOdcl1iMkN7L2l4C+jc75uT+5XIvzE5Z0EegEPLAn7Hf9lzY0qDwmJ0vEJhbUwL0P4SvuTyjqMTuffdjU5PsS1SIfRMW10zmsMVoKYyUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idRrlMBZ0F/zHSeOPnEjvaEPl54B5ETKBYpuxqB7lQg=;
 b=TpHI747h2aIqI5h/hoWddfuBGN74Om/Y+4AgK5KLS6t56OkV15uuZeF7jeSEMo1XijSWTCbnk2cmlZ0QAkoWguZWyb0nmKsY1JjLxKdaCJ4kZakur8VbMZbXR4kGtGbcOfgHZClSruyG5j2dHqxWiHI450oDZFSw+1RH5t08a38=
Received: from BN9PR03CA0380.namprd03.prod.outlook.com (2603:10b6:408:f7::25)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 10:29:35 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::40) by BN9PR03CA0380.outlook.office365.com
 (2603:10b6:408:f7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 10:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Mon, 7 Apr 2025 10:29:35 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 05:29:31 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net] amd-xgbe: Convert to SPDX identifier
Date: Mon, 7 Apr 2025 15:59:13 +0530
Message-ID: <20250407102913.3063691-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: d57a90df-7684-44d9-127a-08dd75bf17b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sp6+wX/O38lLVh4q0sMwGkOdrBzUtCiSykv88g7mrBeSn7m9y/VsYg+erT71?=
 =?us-ascii?Q?KQdN/C51BYoBPUatJoxHKKhvS1EJZwW+LxbPJ0w1AEOScT9e8gSOgRCHSVZR?=
 =?us-ascii?Q?0TYoAFGlzpFyB3Gy3x7c+KYAmWtYMdatm/yRsyUDyejxODC5kF1vhWxrUtN5?=
 =?us-ascii?Q?I8bK9tP1uOjKm/ClmvN92AiBvAwLoMTyQls3lxEZbctcTaU8xZqQN40+lctu?=
 =?us-ascii?Q?8Bycb3eBPI1XeVTyueTdfUEgmof/wtI04aHFn0+AHFPaVkCvkVaqPP+9QJcx?=
 =?us-ascii?Q?Qr36sJk9w74ylMjuPXZvEA4MrBgNjRiSzrBABMQV6N1pzV8ogBYafzCsbJMl?=
 =?us-ascii?Q?JT3NBJLO1GlAHwkcvOg3vLYUun4PYpack6AyXQ7tvYXswYyrMv39C6B6lXLE?=
 =?us-ascii?Q?WZo248apEyJigYF5p1/m5hWl+U5UE3Qw7GlBGb0cMAbdpNJreGEGlVwocItk?=
 =?us-ascii?Q?6ogWjlkWhoCDdRIO0ukM47D210ZWMhYV0l7e+6f3VKO4WDgsoZThbz9RX+Qy?=
 =?us-ascii?Q?VcmvDnMsLgekeeIj3FgOvpU6vNK43xLzYarfYyL4aiVE8Klnsk6drk6oCWP8?=
 =?us-ascii?Q?/B/uekwl+pDJkafF0/BkZzynhfL9E2wbFAqYorPa1pR4ysnircuEn6HCHxn0?=
 =?us-ascii?Q?CjretF+lvvnlcA6ObsQbXR8sNfT9y3ytP5pW6HMOahBPGG2ClASljSOf4zZa?=
 =?us-ascii?Q?CY6MIopYCy5ZUqLLrj/cxr6f2OhcOhUTzIWqhOxOm30Islfh1+WspDOOsHyw?=
 =?us-ascii?Q?9VDI/9J9QH/7uxVYHiIQICxajdIMNGzfhJakLcvJS89Sm4X7GvWuq4qg9tCE?=
 =?us-ascii?Q?ah2pDDCx3cuYxfP3q4FJcLbO8BtpB5bK+sqRPh81EMzns6Za/4TkZtMYBanV?=
 =?us-ascii?Q?cuzKqPOuKb4E2brmqXJcVAzqZOi//z92mdjsR8SinHm/y9pFvocEUdDib3Dv?=
 =?us-ascii?Q?eHqsMKkYEFwqRBVGhU8T8UG3Uz/XnY2MR8vikuq8WlFiVCvcOd2rqPvSGlo8?=
 =?us-ascii?Q?Y82DBTb1see0WtPfHNuhjSkTK2BeXqDAh9w7qooFnFGo7Avxh4ogUArYVFMZ?=
 =?us-ascii?Q?otcHA3E2S6sG4qCiOrmgEOK2PWdCKOX+CtDbVfC/On7eLcZF5mZg72/aSgM3?=
 =?us-ascii?Q?VjIy02+CnpoNlYYl3RJgtLP9aYaRnQ5NYoUbC05LTKzo/JuvEKkkl/aS4klv?=
 =?us-ascii?Q?QWklXsMxNsoxHkCCv5Kp6mI9YdxE9YYgqQTe13j+ouCzCu6j40nGW6pD/zPx?=
 =?us-ascii?Q?MFVaPImKKHrvDzzGeltQ8iePqp+N6Gfu0jEqcBdcUrYwABSXMU+XHys5X13q?=
 =?us-ascii?Q?t17G/3JNlg0SKw8ldouQxKj+Tb1+luPrPLXBUpOsvjTZnorjZ+mWDzNlyOhb?=
 =?us-ascii?Q?E5HyJs/k4mDqWuokNlTzzlbgbTziqiNRr7yKZ7dQfzrVsxk2yFM52UKizJ7N?=
 =?us-ascii?Q?rJbUhgDFtvw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 10:29:35.2663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d57a90df-7684-44d9-127a-08dd75bf17b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052

Use SPDX-License-Identifier accross all the files of the xgbe driver to
ensure compliance with Linux kernel standards, thus removing the
boiler-plate template license text.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h   | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-dcb.c      | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c  | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c     | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c      | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-main.c     | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c     | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c      | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v1.c   | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c   | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c      | 117 +-----------------
 drivers/net/ethernet/amd/xgbe/xgbe.h          | 117 +-----------------
 16 files changed, 64 insertions(+), 1808 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 3b70f6737633..e3d33f5b9642 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #ifndef __XGBE_COMMON_H__
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c b/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c
index c68ace804e37..1474df5544fa 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dcb.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/netdevice.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c b/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c
index b35808d3d07f..d9157c4acde9 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/debugfs.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
index 230726d7b74f..7dba849bcd6b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include "xgbe.h"
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index f393228d41c7..b51a3666dddb 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/phy.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index d84a310dfcd4..0697eed1cb72 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 4431ab1c18b3..be0d2c7d08dc 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/spinlock.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c b/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
index 7a833894f52a..d40011e8ddf2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
index 0e8698928e4d..4ebdd123c435 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 07f4f3418d01..71449edbb76d 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index c636999a6a84..3e9f31256dce 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v1.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v1.c
index d16eae415f72..2e6b8ffe785c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v1.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v1.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 268399dfcf22..7a4dfa4e19c7 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
index 4365bd62942c..47d53e59ccf6 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/module.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
index 7051bd7cf6dc..978c4dd01fa0 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #include <linux/clk.h>
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index d85386cac8d1..e5f5104342aa 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1,117 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
 /*
- * AMD 10Gb Ethernet driver
- *
- * This file is available to you under your choice of the following two
- * licenses:
- *
- * License 1: GPLv2
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- *
- * This file is free software; you may copy, redistribute and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or (at
- * your option) any later version.
- *
- * This file is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
- *
- *
- * License 2: Modified BSD
- *
- * Copyright (c) 2014-2016 Advanced Micro Devices, Inc.
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Advanced Micro Devices, Inc. nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * This file incorporates work covered by the following copyright and
- * permission notice:
- *     The Synopsys DWC ETHER XGMAC Software Driver and documentation
- *     (hereinafter "Software") is an unsupported proprietary work of Synopsys,
- *     Inc. unless otherwise expressly agreed to in writing between Synopsys
- *     and you.
- *
- *     The Software IS NOT an item of Licensed Software or Licensed Product
- *     under any End User Software License Agreement or Agreement for Licensed
- *     Product with Synopsys or any supplement thereto.  Permission is hereby
- *     granted, free of charge, to any person obtaining a copy of this software
- *     annotated with this license and the Software, to deal in the Software
- *     without restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or sell copies
- *     of the Software, and to permit persons to whom the Software is furnished
- *     to do so, subject to the following conditions:
- *
- *     The above copyright notice and this permission notice shall be included
- *     in all copies or substantial portions of the Software.
- *
- *     THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS"
- *     BASIS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
- *     TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
- *     PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS
- *     BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- *     THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
  */
 
 #ifndef __XGBE_H__
-- 
2.34.1


