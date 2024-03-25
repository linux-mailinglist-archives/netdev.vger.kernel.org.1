Return-Path: <netdev+bounces-81717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C9D88AE5F
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40041C60911
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6515782C96;
	Mon, 25 Mar 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r0U44Zwe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C05C62A02
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390375; cv=fail; b=P/R61eBHQ4riPAIxMDBXYWku4ujojbZit4pvotJ/gK27/CexbmDSfX09oHWfQmCego48femgj+HNpEgUyENPwRATeD7itDauIHAcynS2eoQOWGZEptJqDTcYyslE6rpFg9eIiplFnkXLyoz4eAR/b3yKSb3348GNWrjHNGQeXoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390375; c=relaxed/simple;
	bh=k+aW61C1TPw1Zt/EdnceE5rKuyrr0TuiMujgfkLgKpY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VSye6hFYr2XxGOQAhSnqLYTSJa281pwb54AmJnHdN4E34VMjxmqxdSNqHoMQ7z0z85Sd7TDwLp9J2Zx/D6UL9d6r8wfp7VAJegI1w9Ob7+NhJ3MP8YlvA3qG2eg9TnFYW1pWbLJQMYTXYvKEDEgY/dQdLlKOdRqNeqKTOxhAcy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r0U44Zwe; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIQ3dk3V9+nWDeUwn0KMS7uQJdRBWAhj/t0ee75x/0hgPmKYrCyJPG9dINwLVlZvCxz1mllPJy10QiDDg8OSa4YYqTqSGDlIpM++LsDju+BUadN66VE41jLzS9q7mw8iRDRVb2mGSH5tzn3Rf6BGfT+I7Gglb88D9IrrERxVKcwCwXiZNm+riSzYsz8zdTeETnh4/v+nXJPYI/UzoOTYpDDdrpNCklNK+tFMuH3XUpwDYsD/GO6Sh9JsKhjpvsWF1qWOI6oPgNwkW84saKezuV40SkcyUMSSxiTWS/nmJL5+kkxndWXulHKK8VPL1d3sBMOrL/D/XyeB8dq13gX7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIeCD4mNPPw6yyRpMUkwu3UdvOtFDoTrEfHwy+WmzmU=;
 b=eoh4i480Bkx+0fn5lwx4PovZsyYKE3RMgBxh6+XHcJYfW9tj54QYVw5sXyPu2E2DwVKGbtTwgTWtQCZ0aiiwd8AXqvK/F0uwhKfwf3NOM9tfUZ8CScZrR9VemN3vILHa1AXxL5fp8TyAzcSqdYp9o6Gtj9P+w+BgjzXZViucSxmUXdm6dcolz3zYk57ZJ+NHBnU+njIZfjb5jQXbtBDznSagJHcfOhETaE5S5JT6SuT9HQsiFbx940/wJM4rYL8TbvxdDOH3rTvC8DQYiVa96DLdOcA0l/cx+F8jzqsjB+mSf+nIUZcI9UMtdWUfnD1VNN/mAjM9exHq2+qegqWVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIeCD4mNPPw6yyRpMUkwu3UdvOtFDoTrEfHwy+WmzmU=;
 b=r0U44ZweKY0B945mmF21Nf7k/aW5zImzremQLmyVR98fQ2r0ZxW30dctlE5v1yeqVQx5xsgCnYkzD8jE6+ESGwt6Ei7f++XAAaGMN0Tl1hUNudjpTs07VrAlMeajlzFTQbXmhtGH7sB1oBedVgmQh24FPgLMc/lU40OVkNc1nqT8uLGAmC/eljt5DR9xxlRsmrzLU4s1ZQlSsQSuCIQVk20Yw/XcAREHu8RPUQo+MY9bQYDCO1FjOprA49wi0XK9fa+BkOZVAuHM+NYT2EI+XXe7e3Ifbvi0pUHKGh4SvlkGv86PY/zdjn2Z9NlWyG30mxsiB3LXlRn93Q09aFfWeg==
Received: from CH2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:610:52::38)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 18:12:50 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::e4) by CH2PR04CA0028.outlook.office365.com
 (2603:10b6:610:52::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 18:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 18:12:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 11:12:31 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 11:12:31 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Mon, 25
 Mar 2024 11:12:30 -0700
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <bodong@nvidia.com>, <jiri@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, William Tu <witu@nvidia.com>
Subject: [PATCH net-next v3] Documentation: Add documentation for eswitch attribute
Date: Mon, 25 Mar 2024 11:12:28 -0700
Message-ID: <20240325181228.6244-1-witu@nvidia.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b2e571-70ca-448a-8b90-08dc4cf72ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RaAv+ALnMpMy92yf4e0Yk8Xa+gLow1T0lDQRoAJa4D6E6MC65GDuxD9KPCibn4Hszyi9xlu6gX1/mrC2xptcCmQ7AjOuiBYQBHyanvEoqMbcjO4rjxjC0rr4AjjGDwkZWlP9196uqbvcFuVOr82h75AqEB7SgAV1+e/7/08CLDmTh8eCwYAq/6/VAet+KZpJznk3aYpLFhD86kPRnGkYyOnmLIHKoBLhssVwLVFUdVb3DUhN1RqzyS6Sd7yJ+ZqGivsnx+hILhEmxubbK9moJybG5a+tldmMTJdTpuN2aslVmh309JPyrWWEYK6t+aRr+zaUIS+PBAZu86k2seWpNy8NWnlkyvv/M/1PtpfizO9dIDKL0WzPEjI91Odeke/ADv8DZlTcaVJAEYE8zjOOmbiRu6/cOU1mX2OCDf09ybaT+Cpm6+K4CZUgjOrXFXwm2WnOPbYs4mUCQBh0PhN/6jA6zB9PlJAUEmfR5k7hpIZXlZMF6iA+pNnpmTAd3gDAgBRmZvXfWalbfuX6IQba3NaPnj/QtMWPPOQl7axxPC7jYUm43LyF/5f3yBXn8dgEl6coch4JjgjWCwL8zRASryOTx3+D7n9Xw63Wnr/VrnPPsF2KygsQ19SOMZZImhVuOPPA/6p+6XGYvrI7JlK/UE0mUH+k20WFKGSfwykGg7/WR1S4X189E3cQYBvzlmr3TVMbCB+D8eKW8E989H3BDLGhNIHpAYCPRznSmt0kE1yFNGvAiFKr6xB7DB5da4FV
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 18:12:50.4060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b2e571-70ca-448a-8b90-08dc4cf72ecd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

Provide devlink documentation for three eswitch attributes:
mode, inline-mode, and encap-mode.

Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v3: add Reviewed-by from Jakub 
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
2.37.1 (Apple Git-137.1)


