Return-Path: <netdev+bounces-79459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CE98795F5
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 15:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29791F22A72
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492CB7A72D;
	Tue, 12 Mar 2024 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JYV9ibE0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BC58AD4
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253324; cv=fail; b=I+Sl3dV+1gJFp+Un1WD41zTIfeYzh2PG0q84tZFmKdLBLKoc3c17R3LRjZ6XdeKNSzXPq3Q9xp1dB5cTM1kewfT+yamERrjnjebiocBHSJFaX5+OGkK0bQQTL8KuMO0VlCFCGXujVjlFeeuFsULaNZmFj5LNS/o/RWo5T56JBPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253324; c=relaxed/simple;
	bh=CoJgeR1nSimEr5bXHETLTaPDV9DpT0J4oFh8gRaUM20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bYwE+WNYObMHHUN5em8qf9Bmu0xCbQX7tEY6/hrh1Fpet7J20cTpo62104guMMKWu8gd7JxUF/0VUJhU7dtLwrKoj9azFO+wh51fz7G7RU2pk1qfppJFiwtCptwrL5cSpVlN/hCtaoOgjJMg0eVVLQ9dfgAUFEqUczrBVpKKkfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JYV9ibE0; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=disJ8Zj0XHNNDrbGncoCIh51XdJrJGOfP2CEstFr+1EbA+hjKBxr5RdGqS9p6zDDmSuVS+F/79JxC+Ga3q2kMNqD3pJ48NqV6/GEI78e9wBzAi8AzvvpNVC43hs9E/bGWTnu743j9nVz3Jed2a97nw5Cc1TE9z9WgZ8RYcJ7sMpJ4zpJyObm8M96NAHmGA0SeL3JPHuPES6a9PGOsyUxHiQ2M1t2PpBf1wAoqOQw1EJkaTOj7pD+pZ++lTj6rnmIRWvK+hggo9hhfB4Mpu6dwPQIo7x3vE0xB9ejb6ld/etJjhAQEBBjB1dFYDz28IKfIuq3+CsrVrwINhRYSZ97SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuG02a0Sg/Ky0j6Sr236zdAZZ0LJgnbFewm9ODRRBek=;
 b=bPRcrdda5o+EEQx31YPP5EJlbmB9w8Jgql3pV/FEnO1JP0rw8J6WhuCX3nL+6R23mLBDJRR2NArkLDz15M/ofPF9AVfhbIP3cFi4MJ3EIz9LzH2wie48B8Yr7emw4ZZNn0g084tp0YPZYIP3op6qsYtl86SLb5vNMUXlRKEGo0ZzauFRlNmyRTISl0BXjM+fzl73+DXja8vZv3vvwCIwNOwB/cVqTHFBqSj14CNgZ2m7OJVM+XkG3V9HptIJll09lD+IMb0wQBoXavT0GNk9Zubz59hACJqF5dZ/a2xO4h2S+bL1pCYIiK2d9RMt+ZreCZD5fZe7Wlyw7IxJRHdxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuG02a0Sg/Ky0j6Sr236zdAZZ0LJgnbFewm9ODRRBek=;
 b=JYV9ibE0feYkU1JeWSXz4khRG6gcFIXvcYTTjcADQkNNIKVqZiRQY00hyqRu5rfmW5V8HtP4hZiVClv0Rz7FoJTZxeSU6mUc+AnBabElXisVPDANGNGOHNzB8K8mJv+sSR1qtqubfn/mwGYbCe+/Cw8kwZwkFhpvzobquQTr0xjBV1sGe3pknLWYYXi49ZaIAOcDRXzHc40+QVIGbC4/dwKdGV8CXoXdA/NFK/MMK/YJiECyXOQViaeAcwkRg+Wt7nvRGPRV+MKzj8zT+Nslpghcrl8Btg7Aoxf8sBAcmMeB9VaKxvIHhbnCXbnHmopwbCx148kQURPjTpwW3bI5SA==
Received: from BN6PR17CA0039.namprd17.prod.outlook.com (2603:10b6:405:75::28)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 14:21:59 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:405:75:cafe::b6) by BN6PR17CA0039.outlook.office365.com
 (2603:10b6:405:75::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Tue, 12 Mar 2024 14:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 14:21:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Mar
 2024 07:21:43 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 12 Mar
 2024 07:21:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 12
 Mar 2024 07:21:41 -0700
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <kuba@kernel.org>,
	<witu@nvidia.com>
Subject: [PATCH v2 net-next] Documentation: Add documentation for eswitch attribute
Date: Tue, 12 Mar 2024 16:20:55 +0200
Message-ID: <20240312142055.70610-1-witu@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d93476b-6c59-4f9a-7b6e-08dc429fc773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+GuoKD4A5h9TKKtfMFvHq5rMZRcQNww+JywPJmFcY9CPqK7F75Nyc/dN5zyQYPHJn8jviknZOb+Q9641e0JLWLJZYyB4S1bJMqPbaGpavNzEqoaqiH+iynVp4t1UcUQNVjvrea+n9P2KA53c5ir/+iVUjBWrapPKzcHisn25/YLFBBbqGqP11RZSll/LCp4Xli5u2UjFuALxNMJQF3VSkxTK2r5BqL4Sie17vtcaf29VUAGxaCT7kVLEe+7YOhS9g8MUI+FSMdGD/JA7ozG/NfspN5dKia+ENuXZgivExFEPISUT+M5kB+YAySKnDIQyEaKiIazWWE7nKlkuTXvtlfjddiuqvfVuWIuBRU8QIUpaJhzynpi5MvZBD4ChKEDzJo0fXizchMe+ab6OVkbf9SAoNZPhLCAj2EFkYRn3TMk3r6hDjhsjgji7IvVg08GFJ5uBoRTSWegHh90Ew2mW13Sq3YkfFm7JZtiG+rMszmeDd5qnMEFUtxxfuBkDmbF7bD5RNZC7LNfHsY16IiBdcQ9UOHbDxaUMNvwPXh38klvDqcH+e4ain+smHUdNg+LoVlVmXjPfK6D5BW9gO9K9sfS8UhJCp0Cltf3YW4kwAKqDUXJEoByrK97Dw158oWlrquHSscYfTqrbX7tujhenPkC45Tfr79MuJhxS+GDxSs4iXXBc6vCt1HKkz2Ubc1M8/4baVbrUIZb1xKgz9xgItU8rMaloXaFu72/VuU+RGHMxbGoOjCdhTWIlUl77IIy0
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 14:21:59.1047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d93476b-6c59-4f9a-7b6e-08dc429fc773
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465

Provide devlink documentation for three eswitch attributes:
mode, inline-mode, and encap-mode.

Signed-off-by: William Tu <witu@nvidia.com>
---
v2: feedback from Jakub
- add link to switchdev and representor
- emphasize "mode"
- document that inline-mode and encap-mode can be use either with
  legacy or switchdev mode
---
 .../devlink/devlink-eswitch-attr.rst          | 76 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 Documentation/networking/representors.rst     |  1 +
 3 files changed, 78 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-eswitch-attr.rst

diff --git a/Documentation/networking/devlink/devlink-eswitch-attr.rst b/Documentation/networking/devlink/devlink-eswitch-attr.rst
new file mode 100644
index 000000000000..08bb39ab1528
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-eswitch-attr.rst
@@ -0,0 +1,76 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Devlink E-Switch Attribute
+==========================
+
+Devlink E-Switch supports two modes of operation: legacy and switchdev.
+Legacy mode operates based on traditional MAC/VLAN steering rules. Switching
+decisions are made based on MAC addresses, VLANs, etc. There is limited ability
+to offload switching rules to hardware.
+
+On the other hand, switchdev mode allows for more advanced offloading
+capabilities of the E-Switch to hardware. In switchdev mode, more switching
+rules and logic can be offloaded to the hardware switch ASIC. It enables
+representor netdevices that represent the slow path of virtual functions (VFs)
+or scalable-functions (SFs) of the device. See more information about
+:ref:`Documentation/networking/switchdev.rst <switchdev>` and
+:ref:`Documentation/networking/representors.rst <representors>`.
+
+In addition, the devlink E-Switch also comes with other attributes listed
+in the following section.
+
+Attributes Description
+======================
+
+The following is a list of E-Switch attributes.
+
+.. list-table:: E-Switch attributes
+   :widths: 8 5 45
+
+   * - Name
+     - Type
+     - Description
+   * - ``mode``
+     - enum
+     - The mode of the device. The mode can be one of the following:
+
+       * ``legacy`` operates based on traditional MAC/VLAN steering
+         rules.
+       * ``switchdev`` allows for more advanced offloading capabilities of
+         the E-Switch to hardware.
+   * - ``inline-mode``
+     - enum
+     - Some HWs need the VF driver to put part of the packet
+       headers on the TX descriptor so the e-switch can do proper
+       matching and steering. Support for both switchdev mode and legacy mode.
+
+       * ``none`` none.
+       * ``link`` L2 mode.
+       * ``network`` L3 mode.
+       * ``transport`` L4 mode.
+   * - ``encap-mode``
+     - enum
+     - The encapsulation mode of the device. Support for both switchdev mode
+       and legacy mode. The mode can be one of the following:
+
+       * ``none`` Disable encapsulation support.
+       * ``basic`` Enable encapsulation support.
+
+Example Usage
+=============
+
+.. code:: shell
+
+    # enable switchdev mode
+    $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev
+
+    # set inline-mode and encap-mode
+    $ devlink dev eswitch set pci/0000:08:00.0 inline-mode none encap-mode basic
+
+    # display devlink device eswitch attributes
+    $ devlink dev eswitch show pci/0000:08:00.0
+      pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic
+
+    # enable encap-mode with legacy mode
+    $ devlink dev eswitch set pci/0000:08:00.0 mode legacy inline-mode none encap-mode basic
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index e14d7a701b72..948c8c44e233 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -67,6 +67,7 @@ general.
    devlink-selftests
    devlink-trap
    devlink-linecard
+   devlink-eswitch-attr
 
 Driver-specific documentation
 -----------------------------
diff --git a/Documentation/networking/representors.rst b/Documentation/networking/representors.rst
index decb39c19b9e..5e23386f6968 100644
--- a/Documentation/networking/representors.rst
+++ b/Documentation/networking/representors.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. _representors:
 
 =============================
 Network Function Representors
-- 
2.38.1


