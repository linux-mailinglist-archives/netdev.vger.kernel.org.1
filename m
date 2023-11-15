Return-Path: <netdev+bounces-47977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BF77EC219
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E78B20C2C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC741A5A2;
	Wed, 15 Nov 2023 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g9L9/uVW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC018AEB
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:20:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166B2C7
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:20:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS4QhJTqF6nuRT1fvPBaDr2/tGFLpqvFDZga+nAWXcJOwpvQQUoCdqhBd920GJ/ZZnblm4C15S7leQ86ae5RR8W5zdB3P4jJ++hxeODa/tgYjd4lIPq1UKWFknN+qo/K6AvgjXTj5oZnEwRcIo5vfPfyb4aHeurCtRMUKXjYrc6hZGRkuoKYhk1QeRotfmWzmFQhbRh8yAQdvmEiMVjqdkham9fPfEAb0Gjg0Cq6q88rmj117JgSAPEBKq9qLAAMZXK23zhp5jjWbcyJekvkl1KdzYMMkeP9IRQJc8i6H4Oz+t6k+pNEcKv9k0f6zNGJSOBWstXlUKl7xeiJT+iOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXROg6HCYsGqW3cdg2DYryEvkDs3xBMlpVFkFnXNNaU=;
 b=ROZ9oGCz0RF2Y6BzGdfiRlEzaLwnj9zWxVrU26A8bXfQ1UmgI2mM6TUwh8GS5zchtORyJXjYIN9GbNpfUOuzrNZ3cf7OH0Vn8YB23Sy7/m6+OCHOq8qn/DlwekfQG62nziW1gqvOZ1BTAZXx+Gb+U0JoKEY7gL7wIk6PGee9k7YygVS8mk1phLoPMXhoF9sjtlXrFQjLFqJ7vwcjOiDL4iyfrsXU8qDQF5Vx/I0zdjoya9MA5oBbXiTth4eO0I5I26Pa932Ss8gStuYZ+7Z5d5JLwkCY9mNj+tDnDbP79lmO9kk9E8890227WIWOCCIVHAS5Oco54W3sHOdajhYObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXROg6HCYsGqW3cdg2DYryEvkDs3xBMlpVFkFnXNNaU=;
 b=g9L9/uVWI7mLItlIY5+3q4MgMqVlwytjPdxZxSBIJAJmzW37BHtbRgV9FELMOLbdjJbiQSW6T8ugRdJcSeo+2NVa3SfeWXVGPz3vn9o3W8zIjIv/yye8Him4WekitL+ExI+20ibVZew1fhGU7ImrEdZyscwXZQK+vb0WVEWb+fCRHQRyXjCeM5drPaLXkbUigl4bMGUOGyGodysV4NPVYaxUo/EacSLdURt1G6xLuwWotjtyk9qYo9nvqJYD1/ak8HP5yFmk+HUpCSbgiNHVv+pRFRKTvmhwBMpd1xJMiQkf9UpE2aLyNDJ6Q3IHqVgr4cV6abNO2QG/+UC3WoCq9g==
Received: from BL1PR13CA0301.namprd13.prod.outlook.com (2603:10b6:208:2c1::6)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 12:20:02 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::7b) by BL1PR13CA0301.outlook.office365.com
 (2603:10b6:208:2c1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 12:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:20:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:47 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:45 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: [PATCH net-next 08/14] PCI: Add debug print for device ready delay
Date: Wed, 15 Nov 2023 13:17:17 +0100
Message-ID: <63fca173195f5a9d3a2b78da700650a29cf80f96.1700047319.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700047319.git.petrm@nvidia.com>
References: <cover.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|PH0PR12MB5434:EE_
X-MS-Office365-Filtering-Correlation-Id: 732c6a9d-c492-44c2-8fe9-08dbe5d5316a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qOx/qLnMwKZxz9cgEoQXBP7TjmJObFQRu7ajWBZgAf9AHa4djUWNJPmZhgSJlSb6CSXtCnVtLZMsXtIZB+p7NtnQDWXrifGR6xmroooooHOwtWUhuw3twkRq8O/FVkxRMB7qLG3+zJDZ29YqmNZ/Hhl37jv1DoEkdZq9Va44HRpX3/LNKVZ+XfcXxlirgCURhDUXBe/hj2wBiVwRy6QtvB+ShZdto8RlUSpu+BhRbQBl0AAkbD8SzGhRqzrBaI7Y1FIL/mq86mwUi2gOrb4yqnDD9vmGkFf1KR3X6s7gLNl1M4EB2ZXflwjYswHDQp3PbP/f/CyShWM0WfR5vIoHDQo0sBhsG0chZ4Tk1aBFVh2+JV9nVrdzkjptckmuvZo4nuN0qmAD0tkzJrKpOuoWwgYnId9pHp520kiBBj9af92h/+Fifp2PKy5F/iiE9kyDIR7XjPO0P6NVcDJnDi5sJ9Cr1CookVkCTvUvVYCznhLaqMmSm5tYQVUz3VcFSTUjl45ek0SlDFbCCkZoBN4SAKFdihnnA1K/cuBDAeqHyOUa/ppqYm5srWcfXuZCs5u4yeDXxIKXgDHVaaTNI3jwRVBtyj7CL5cXFSW4cKCOIwEui2dNhE/YG4SGqi6Lsfv2bxkuI35rwExf8dENyy3Ou2rGs86wyfT2VE68umtrjuu94pr7ZTgsulLrdlQEuKrgX0aWo1wWxO3kz+V+ICE+rwkHVT+vCMHEzQDRVjJNb41W/KMFEo2UbFs/Otwfw+xt
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(40470700004)(36756003)(83380400001)(82740400003)(2616005)(40460700003)(336012)(2906002)(426003)(16526019)(26005)(41300700001)(36860700001)(356005)(7636003)(47076005)(86362001)(70586007)(110136005)(70206006)(8936002)(54906003)(8676002)(316002)(4326008)(478600001)(6666004)(5660300002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:20:02.0731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732c6a9d-c492-44c2-8fe9-08dbe5d5316a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434

From: Ido Schimmel <idosch@nvidia.com>

Currently, the time it took a PCI device to become ready after reset is
only printed if it was longer than 1000ms ('PCI_RESET_WAIT'). However,
for debugging purposes it is useful to know this time even if it was
shorter. For example, with the device I am working on, hardware
engineers asked to verify that it becomes ready on the first try (no
delay).

To that end, add a debug level print that can be enabled using dynamic
debug. Example:

 # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
 # dmesg -c | grep ready
 # echo "file drivers/pci/pci.c +p" > /sys/kernel/debug/dynamic_debug/control
 # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
 # dmesg -c | grep ready
 [  396.060335] mlxsw_spectrum4 0000:01:00.0: ready 0ms after bus reset
 # echo "file drivers/pci/pci.c -p" > /sys/kernel/debug/dynamic_debug/control
 # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
 # dmesg -c | grep ready

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 55bc3576a985..69d20d585f88 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1219,6 +1219,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	if (delay > PCI_RESET_WAIT)
 		pci_info(dev, "ready %dms after %s\n", delay - 1,
 			 reset_type);
+	else
+		pci_dbg(dev, "ready %dms after %s\n", delay - 1,
+			reset_type);
 
 	return 0;
 }
-- 
2.41.0


