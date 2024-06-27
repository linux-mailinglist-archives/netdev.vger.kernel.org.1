Return-Path: <netdev+bounces-107316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 704F591A8C1
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73F4B25F12
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9016198848;
	Thu, 27 Jun 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FhlIB3hO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2186198841;
	Thu, 27 Jun 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497406; cv=fail; b=U7bXggGCyvvarMxeM9At66KAXCXzpYvrlcX7xSq7h7qdeDGwFZ28qWuGS2Va/sppepJTiwFZ4n7YWxiV61fD/X4K3HwgH77/ZqRpTLOzfuG4qOr3ivCKiJP67Dff/V6jzMVYCzV98GhyUyQTpXYchdhUgqwTlY59NOjJ6EcUtXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497406; c=relaxed/simple;
	bh=r0+k8ay3p8xkvZG6uKn/yNlLIDpjFoPWRsjPGSROOgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHwfgKK0A08o1EM4k8VUwlnZA9RMf/hglU146r99oaFMieMeSVIJ77wX67wIStldUBMoLD/c4dx6RfuCGtf6PLbA0a/uKwTCm+WBnDCBhDSfu8gdvmiFtmcGZ7wWvkLOSCj0Bx/Yka6jACBpCv90sWEc5pgDA++ou+n4ZdshA48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FhlIB3hO; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGuGTXQoZu2mKV5BBQ+QBV3UIm9CSCTIYLMdyVp0vXBsNKOC8fl3fuigTgVxb6EYjS8LjIyR2Ortz4p+k41M4hBdxy24dVY7yjxrIh1pUDY5hXwqL/VN28/QK4JVNcGeqXxXNcPsmq/EFbLe/KJ5q0Gso4xJARnpBlfZR86KSFYXNPwHSBJ69ym4kZr69oR2rO3vTceNGmx4d/q1l7Fis9ASRs4LdZ+raZNb6jiSUWXi93D3Q5c9hBqNa0DLlWdf6nsI8olpQaqH6v0C0Q7nSoLviZ9huPp8vcW/gv+lt+CoPn7tfUPqBRv8sLsLH+stg/8b1UMWGF7Rk9G27s9qPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Uow+unOoR9LoyhBc8qm4AYKD6YRlLdLUOwbGapH0pU=;
 b=e2TcriOOUtbyd/j6yvx9fU3bAWu/VbZzU9duRtQ8XL8YtrBCJZtxTMFJde1rl2nGibCj4X7BBGUeJSfESB+3oUVSKAhzhDls0UHnaTegfOwR7YpmB9WzHhJzmsYxTelpvVKzPfTNWwTqLnyl92IHf772JmH54JVJyWXuB19NWD6Hcpzp6CGnkhk5tyCzUM07QP3df3Cqj7JsQe4QNVZnXE0t2uQKWfIwvVIiHyiGNPMNRWEgF+xWlobNeN9O2YruPq9r5IMo94VX7mNys8HLmxwwQoY7ssZqNlz4GDkXY0fET6VjIzTh+0quu6cRd1BJ9A7eyk17fzWIjg2UejNzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Uow+unOoR9LoyhBc8qm4AYKD6YRlLdLUOwbGapH0pU=;
 b=FhlIB3hOfaVxm25ZtLKFvXs6j2C+4rxbbmJdNna5qnu7t1+aqBWB75Ei3GpKEN4xV3IJUdCOONgjTWvQ/YGJf4tQUeFi+270s65BCI0qlxuEnOT+rMRH1jytR4g4qU+hXnv0Bcxl7wpZifk89x05o9zw1/KOVN74p2p8CT9qrry/0wnd6kocWmXSRuKigO9ggRjGb0qypOu1wqon9skCHzkQyrYeRO7DorwqoiSmU0o61wkeFmdL37HzvAJUBxdTUSQ7fP/ZTuG9SU+NK7Iz9Z5VD/9vB8P901nfL/nPK3B/pQ7Ss3EBANPqNsbSuQ2ATg5CsOqTP2h7NZvceHGxCw==
Received: from BN1PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:e1::22)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 14:09:58 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:e1:cafe::15) by BN1PR12CA0017.outlook.office365.com
 (2603:10b6:408:e1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 14:09:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:09:38 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:09:32 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
	<sdf@google.com>, <kory.maincent@bootlin.com>,
	<maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
	<przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
	<richardcochran@gmail.com>, <shayagr@amazon.com>, <paul.greenwalt@intel.com>,
	<jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mlxsw@nvidia.com>, <idosch@nvidia.com>,
	<petrm@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v8 3/9] ethtool: Add an interface for flashing transceiver modules' firmware
Date: Thu, 27 Jun 2024 17:08:50 +0300
Message-ID: <20240627140857.1398100-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240627140857.1398100-1-danieller@nvidia.com>
References: <20240627140857.1398100-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd1563c-d5b2-4afb-3b9e-08dc96b2d3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HZudfULnnF5m/oWYjuR3jHSQfHy1X19VC0VzrVc3W/xOCLrKI+JTsFZTq5vd?=
 =?us-ascii?Q?ALePpp8SunRegN1gHDSu88GT1BSRYE42lecOdPt4kuoP3ZwtnNQduIgPYgVC?=
 =?us-ascii?Q?KvimKyljIQfwV2xugIMQWbSw10V6+bg862UAeU3ZjjiaTGMjjG/gqPYKIKlO?=
 =?us-ascii?Q?4UPhgob1SNIqNKtHlwZiQGpL7aiSEdS1vSw0Ut8+nXlL9D0Yf2FOVn+O8BgL?=
 =?us-ascii?Q?FV9aeQsJWPQ9grbmYlKcbCLfedIOJdx3snhnwGfgmU4eTSd+11goG4lg/vbk?=
 =?us-ascii?Q?x96rnaRzVKyggd/os8/+5xkDlZ8d4RgHDgIfM8TtapQD66Hg6MxzVUus4o8/?=
 =?us-ascii?Q?Ppueh90nnsIemndm+RKLtqOT/NZWrjRh62U2oD/Xmj1L9w+3yVfooWAAeUtR?=
 =?us-ascii?Q?eTPyxxTqUnCLE0jOJIq+F3GcVEY7OzB0RWI1cKrCDnRo/g5W8IVxr2hGMfa5?=
 =?us-ascii?Q?8O974aa1jaLdts8Nr1Uz0o+ncmkEGBu6TLy1tazlwTISK6BICR0ec7Up4v2u?=
 =?us-ascii?Q?5LHiie6mF7cvcVyCXBl0zHQgoi3hcmRah9Q+y9Umfr7nbIhAFCXRavkJZuFL?=
 =?us-ascii?Q?foExa6lL6npX06ipPcXfAUdvYUnaAt8nrD9X0Dcbf8nSzqM4UkIUyYAArE0Z?=
 =?us-ascii?Q?T/nERPVyV7ju8jtrJj60mBk4EjwwY/CgYenagm91XxZ9Cx96WKA51qb1N/1V?=
 =?us-ascii?Q?Ir7ISjweYq8aw5ssnSEDF20ez4CSlC0mmRXfsLn7aQ8SNlSD/bZF45yGy5nY?=
 =?us-ascii?Q?g87+gXSAOHZ7coo3Jj1oFCBt1gryLYmGMP+XDxh/1doWj6buX6JP9WfMtS1i?=
 =?us-ascii?Q?jiNjdCWz5+3L3iIG/5elPJbNFipv0z+zCb01Q2YSPsNMHYYAMEGUtqjRzJ8v?=
 =?us-ascii?Q?SkgflmWrpcTxiZv0wAZ6UJ1ApU3LKNkxtD+ZniKneeKnl5Az6iLK4+q2h7ln?=
 =?us-ascii?Q?RQO2qQVF1TUzoI0qxCs283wzhbAJYIu/rmNYWD+CH/PawXmNIMIdrFvuODW7?=
 =?us-ascii?Q?YsQa83rbXnXFURxEVzIKSjmMnme21DzRGEgMYBVJdBbgR7/K2qCfIB1li013?=
 =?us-ascii?Q?5BfYoFviv/yNHY21fncEZBPeaWDOQQezksjPOHH7oW4i2C55IHXPv0LaERse?=
 =?us-ascii?Q?ujP4/kRViaSDW/AYXJKI+kbyXnTVivKempBmATxxjfb9huHJFPVigre3C0mD?=
 =?us-ascii?Q?SnxHeIdse13tQVwWOuaykfwSTB/rvOhC4Pv644eGkKjHAQ/2HEuXrqEHsKkR?=
 =?us-ascii?Q?yQwUMCL5Ko2QdUqn6gXLyXPRFFydVdnf3uXoIliXoXGgw+zDlTwe7PP1EI4N?=
 =?us-ascii?Q?I0a23bZkBFK4PjcsByH3PrQi8vLMmbB5x/JcUpNpZ02S7uGVV8jLP4GXGSAE?=
 =?us-ascii?Q?xUN+mExW5Q+ltAZHkE5+Vz653qfX2G45b9HD9SC3Yh9wloZz1aqqFLA8+SVW?=
 =?us-ascii?Q?0JtmTtOvbt97JuZ2bcL/pXNvXlURvwdq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:09:58.1334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd1563c-d5b2-4afb-3b9e-08dc96b2d3eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148

CMIS compliant modules such as QSFP-DD might be running a firmware that
can be updated in a vendor-neutral way by exchanging messages between
the host and the module as described in section 7.3.1 of revision 5.2 of
the CMIS standard.

Add a pair of new ethtool messages that allow:

* User space to trigger firmware update of transceiver modules

* The kernel to notify user space about the progress of the process

The user interface is designed to be asynchronous in order to avoid
RTNL being held for too long and to allow several modules to be
updated simultaneously. The interface is designed with CMIS compliant
modules in mind, but kept generic enough to accommodate future use
cases, if these arise.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Notes:
    v6:
    	* Add paragraph in .rst file.
    
    v5:
    	* Modify tools/net/ynl/Makefile.deps so the ynl file will
    	  include the ethtool.h changes.
    	* u64>uint for 'total' and 'done' attrs.
    	* Translate the enum from ethtool_netlink.h to YAML.
    
    v4:
    	* s/is composed from/consists of/.

 Documentation/netlink/specs/ethtool.yaml     | 55 +++++++++++++++
 Documentation/networking/ethtool-netlink.rst | 70 ++++++++++++++++++++
 include/uapi/linux/ethtool.h                 | 18 +++++
 include/uapi/linux/ethtool_netlink.h         | 19 ++++++
 tools/net/ynl/Makefile.deps                  |  3 +-
 5 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6c2ab3d1c22f..05bc0065d439 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -20,6 +20,10 @@ definitions:
     name: header-flags
     type: flags
     entries: [ compact-bitsets, omit-reply, stats ]
+  -
+    name: module-fw-flash-status
+    type: enum
+    entries: [ started, in_progress, completed, error ]
 
 attribute-sets:
   -
@@ -1004,6 +1008,32 @@ attribute-sets:
       -
         name: burst-tmr
         type: u32
+  -
+    name: module-fw-flash
+    attributes:
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: file-name
+        type: string
+      -
+        name: password
+        type: u32
+      -
+        name: status
+        type: u32
+        enum: module-fw-flash-status
+      -
+        name: status-msg
+        type: string
+      -
+        name: done
+        type: uint
+      -
+        name: total
+        type: uint
 
 operations:
   enum-model: directional
@@ -1761,3 +1791,28 @@ operations:
       name: mm-ntf
       doc: Notification for change in MAC Merge configuration.
       notify: mm-get
+    -
+      name: module-fw-flash-act
+      doc: Flash transceiver module firmware.
+
+      attribute-set: module-fw-flash
+
+      do:
+        request:
+          attributes:
+            - header
+            - file-name
+            - password
+    -
+      name: module-fw-flash-ntf
+      doc: Notification for firmware flashing progress and status.
+
+      attribute-set: module-fw-flash
+
+      event:
+        attributes:
+          - header
+          - status
+          - status-msg
+          - done
+          - total
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 7ec08e903bab..bfe2eda8580d 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -228,6 +228,7 @@ Userspace to kernel:
   ``ETHTOOL_MSG_PLCA_GET_STATUS``       get PLCA RS status
   ``ETHTOOL_MSG_MM_GET``                get MAC merge layer state
   ``ETHTOOL_MSG_MM_SET``                set MAC merge layer parameters
+  ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``   flash transceiver module firmware
   ===================================== =================================
 
 Kernel to userspace:
@@ -274,6 +275,7 @@ Kernel to userspace:
   ``ETHTOOL_MSG_PLCA_GET_STATUS_REPLY``    PLCA RS status
   ``ETHTOOL_MSG_PLCA_NTF``                 PLCA RS parameters
   ``ETHTOOL_MSG_MM_GET_REPLY``             MAC merge layer status
+  ``ETHTOOL_MSG_MODULE_FW_FLASH_NTF``      transceiver module flash updates
   ======================================== =================================
 
 ``GET`` requests are sent by userspace applications to retrieve device
@@ -2041,6 +2043,73 @@ The attributes are propagated to the driver through the following structure:
 .. kernel-doc:: include/linux/ethtool.h
     :identifiers: ethtool_mm_cfg
 
+MODULE_FW_FLASH_ACT
+===================
+
+Flashes transceiver module firmware.
+
+Request contents:
+
+  =======================================  ======  ===========================
+  ``ETHTOOL_A_MODULE_FW_FLASH_HEADER``     nested  request header
+  ``ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME``  string  firmware image file name
+  ``ETHTOOL_A_MODULE_FW_FLASH_PASSWORD``   u32     transceiver module password
+  =======================================  ======  ===========================
+
+The firmware update process consists of three logical steps:
+
+1. Downloading a firmware image to the transceiver module and validating it.
+2. Running the firmware image.
+3. Committing the firmware image so that it is run upon reset.
+
+When flash command is given, those three steps are taken in that order.
+
+This message merely schedules the update process and returns immediately
+without blocking. The process then runs asynchronously.
+Since it can take several minutes to complete, during the update process
+notifications are emitted from the kernel to user space updating it about
+the status and progress.
+
+The ``ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME`` attribute encodes the firmware
+image file name. The firmware image is downloaded to the transceiver module,
+validated, run and committed.
+
+The optional ``ETHTOOL_A_MODULE_FW_FLASH_PASSWORD`` attribute encodes a password
+that might be required as part of the transceiver module firmware update
+process.
+
+The firmware update process can take several minutes to complete. Therefore,
+during the update process notifications are emitted from the kernel to user
+space updating it about the status and progress.
+
+
+
+Notification contents:
+
+ +---------------------------------------------------+--------+----------------+
+ | ``ETHTOOL_A_MODULE_FW_FLASH_HEADER``              | nested | reply header   |
+ +---------------------------------------------------+--------+----------------+
+ | ``ETHTOOL_A_MODULE_FW_FLASH_STATUS``              | u32    | status         |
+ +---------------------------------------------------+--------+----------------+
+ | ``ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG``          | string | status message |
+ +---------------------------------------------------+--------+----------------+
+ | ``ETHTOOL_A_MODULE_FW_FLASH_DONE``                | uint   | progress       |
+ +---------------------------------------------------+--------+----------------+
+ | ``ETHTOOL_A_MODULE_FW_FLASH_TOTAL``               | uint   | total          |
+ +---------------------------------------------------+--------+----------------+
+
+The ``ETHTOOL_A_MODULE_FW_FLASH_STATUS`` attribute encodes the current status
+of the firmware update process. Possible values are:
+
+.. kernel-doc:: include/uapi/linux/ethtool.h
+    :identifiers: ethtool_module_fw_flash_status
+
+The ``ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG`` attribute encodes a status message
+string.
+
+The ``ETHTOOL_A_MODULE_FW_FLASH_DONE`` and ``ETHTOOL_A_MODULE_FW_FLASH_TOTAL``
+attributes encode the completed and total amount of work, respectively.
+
 Request translation
 ===================
 
@@ -2147,4 +2216,5 @@ are netlink only.
   n/a                                 ``ETHTOOL_MSG_PLCA_GET_STATUS``
   n/a                                 ``ETHTOOL_MSG_MM_GET``
   n/a                                 ``ETHTOOL_MSG_MM_SET``
+  n/a                                 ``ETHTOOL_MSG_MODULE_FW_FLASH_ACT``
   =================================== =====================================
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 8733a3117902..e011384c915c 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -877,6 +877,24 @@ enum ethtool_mm_verify_status {
 	ETHTOOL_MM_VERIFY_STATUS_DISABLED,
 };
 
+/**
+ * enum ethtool_module_fw_flash_status - plug-in module firmware flashing status
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED: The firmware flashing process has
+ *	started.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS: The firmware flashing process
+ *	is in progress.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED: The firmware flashing process was
+ *	completed successfully.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR: The firmware flashing process was
+ *	stopped due to an error.
+ */
+enum ethtool_module_fw_flash_status {
+	ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED = 1,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR,
+};
+
 /**
  * struct ethtool_gstrings - string set for data tagging
  * @cmd: Command number = %ETHTOOL_GSTRINGS
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index d15856c7e001..840dabdc9d88 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -57,6 +57,7 @@ enum {
 	ETHTOOL_MSG_PLCA_GET_STATUS,
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
+	ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -109,6 +110,7 @@ enum {
 	ETHTOOL_MSG_PLCA_NTF,
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
+	ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -1018,6 +1020,23 @@ enum {
 	ETHTOOL_A_MM_MAX = (__ETHTOOL_A_MM_CNT - 1)
 };
 
+/* MODULE_FW_FLASH */
+
+enum {
+	ETHTOOL_A_MODULE_FW_FLASH_UNSPEC,
+	ETHTOOL_A_MODULE_FW_FLASH_HEADER,		/* nest - _A_HEADER_* */
+	ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME,		/* string */
+	ETHTOOL_A_MODULE_FW_FLASH_PASSWORD,		/* u32 */
+	ETHTOOL_A_MODULE_FW_FLASH_STATUS,		/* u32 */
+	ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,		/* string */
+	ETHTOOL_A_MODULE_FW_FLASH_DONE,			/* uint */
+	ETHTOOL_A_MODULE_FW_FLASH_TOTAL,		/* uint */
+
+	/* add new constants above here */
+	__ETHTOOL_A_MODULE_FW_FLASH_CNT,
+	ETHTOOL_A_MODULE_FW_FLASH_MAX = (__ETHTOOL_A_MODULE_FW_FLASH_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index f4e8eb79c1b8..dbdca32a1c61 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -16,7 +16,8 @@ get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
 
 CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
 CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
-CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
+CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
+		$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
 CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
 CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
-- 
2.45.0


