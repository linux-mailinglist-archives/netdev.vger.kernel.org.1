Return-Path: <netdev+bounces-106222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFD19155E6
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2910D1F25308
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5931A01D3;
	Mon, 24 Jun 2024 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hJQZX1xQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9191A01C4;
	Mon, 24 Jun 2024 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251583; cv=fail; b=aYppBUf3Ph+BaPC5sfEiCtk1PeVq9gB73jQZweCZjHky2Y9v+v7DKlbFydtIx/nBy3SE8GuOsemMn/wKdXGUzeEuP1Mlr0GM8zMtPjgOVGiZSD3yRFOP5PdANvRoUKKVU5GNwi9EKMMwxDg/ZUn4oSJyyFbB3gYQwVPsltjLpJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251583; c=relaxed/simple;
	bh=/9auGPgHc348Aag4gLWWS9stNitcDk8YzaKsBPsVq8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEfA0qXvQ3LRu66Y2Li/TmKv1FsBB4SfPNmc38dWUln297jvSDh9OnUDSKUfQgxrlpT7D4IhtcbLddXCgajT96urfvZCPUFzlpqHfYxpNnE8qDrd+wNRMLbeuYi7AlDU1jYEgUOenOFvG+C4pFNaqGFXqt3QdvCXuQ+L03Z7844=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hJQZX1xQ; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhIQk8fVKuxDn34l03Y16L/1iDElsLd8TZrAygIg9hn4dAjylIlOkNFWrNmVvAGR2Q9Ua6uY53BenIE6Hl7TjNiqjAUyHXGjQTOxZRy+W7mWim7Dd6qAG/bP0hScbzKgFYRyi7ygbiJHk5x1fhRn1ssHnQb1i6ps0+HY9rKvYkKak04DQGLeY/hG6cI2wfaqrEGIRHyjc9rcE8nvO1G4YUQtY0Mp1IIL6MptMOPeBzm2PoKPKMBqRf7gRKikiymYmCgMkVM5h3E0RRIbnaPTC7tieE5k/6b7hTcNkUf0q2XJXZIjbQNKuRsAKRX5ZT0xQF/Oy3ZyMCCOQxCrnDvnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50crNkk2tUbJ26WNWwrar1INxg6W3LhnEN5u5oLgdIE=;
 b=cGagshBxfoZW6FIz9GwB2+ezfrJtY44cRVUZHOc0JEHPnTPYMMc4uJ7GT1LzFs3Q8k2lGwdXZ//AVbNE5/38ki5ZG/+/4uGtE54ZTmJPF1Q0iPCNnl317AmzqHoQJ09S5duJ8tILll+qJ9/0+yiFO/bl/iFMRz+uXZ2Yq1VJnZdGeI1o1rgAXeyAOTWk7gNW5j2f32K7e+v7p+sgr7FWnIH6opw2AEpCdgmjGw9fAtmQtNMvqrv9ozdmwTbiuOccYtxT/Qh8pKPeavqV8OPrU9GfZZ4NiSvGwNesg1NGKXeiiyIoi94p5jbB+arRtiX5VFIGqBbWvaPVWEAD145OeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50crNkk2tUbJ26WNWwrar1INxg6W3LhnEN5u5oLgdIE=;
 b=hJQZX1xQy9qAzCpmPNR7Ktk319oJTMgKk2cUIIuxkafqgiN1vra5+Utk713QGjrqqjotcReVvcoz5oTnuj9fV1cc3VqvSJHe/df3pAcqblOxNazdU7x5lw8pgfdqGhk8wLihOn5NsizXCD80pCPP+p7vEloDPj+VZLcn0neiAwrGOQnmAR6ZnwQ8ilZsqlr0JcLCCoaUAzn7phwqJhuzV6vT34ogaKCFBHqhSDiIqzHkzvdykY47pfnnDQlRcJi4Vi8QxNQdzyrldYGi83n5Z7mXzIir+cqmEHrHppg5S72ktmHFw6cbeWgEFOFUs6nt4oPGfdLP/oFKuHnFlN8bLw==
Received: from SJ0PR03CA0134.namprd03.prod.outlook.com (2603:10b6:a03:33c::19)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 17:52:55 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::69) by SJ0PR03CA0134.outlook.office365.com
 (2603:10b6:a03:33c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 17:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 17:52:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 10:52:39 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 10:52:33 -0700
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
Subject: [PATCH net-next v7 3/9] ethtool: Add an interface for flashing transceiver modules' firmware
Date: Mon, 24 Jun 2024 20:51:53 +0300
Message-ID: <20240624175201.130522-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624175201.130522-1-danieller@nvidia.com>
References: <20240624175201.130522-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8d15e7-f54b-4837-2958-08dc947679dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|82310400023|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZSPB1WkyuwVn/S3EjwFn8daB93hvYAAzrnt22FSQCvLPa8gObR4JI5qUhO01?=
 =?us-ascii?Q?ePyPZty5+Da2pHUsLf9FzjCC6QAgrg/UkNJnw4x8P2P2sO+zUpmgomPs4F0T?=
 =?us-ascii?Q?k+NKWGSwQhioPM7BcvgzkEAA+MumP9XbcveS13oKJDTUwT77AOSh9+b902vE?=
 =?us-ascii?Q?90lS0V2N9hSpakm2/gJGBd6SOTXc9PBgRLRCC6+Yx+alY2eN6M+8lPFO1uHM?=
 =?us-ascii?Q?28YwjtU84niY+UlcHyaz+D7xymLMEWdk6vuuBV1WruqaHNSxOhZnXT6/buqc?=
 =?us-ascii?Q?+9emuTE0hj+g81FEn75XkYhUn4o57HuErUM/nbKKqb6WibJgDF28Cd9Lqm47?=
 =?us-ascii?Q?JbsXoCYppDrsfD/LOWB+cCQW/ilRko9KswPwAYaSqKUHCsdd5wx9r+lvngUd?=
 =?us-ascii?Q?V2W9N+7XMlHwWLa3Tl6NN6Qn4vZ1U8MtwIDGfcDN7wNGEHoqq9dEHIY7oNj/?=
 =?us-ascii?Q?qNsIlSEYI0pC+zm8g+/UwXBhrPpkdfyTT72OlryIqMiDCOpEZbpKo+V0g6m9?=
 =?us-ascii?Q?0K8GgX2aAsLLn1Ch+vnwcXi9dFhwLxBKlcJWhDVGPBR8pnvmVQ5nI/s0hIUP?=
 =?us-ascii?Q?UQ3wid8P5JEP876bpVhm5qbaFjeKJrfy27YZPvP4PVfBtKFLOBLTTuliCFKR?=
 =?us-ascii?Q?wOggEqpkhSARghLvMozG98UHIf0flJQcqr17PkYCAUvp+xZtyApAdU+3Dr8L?=
 =?us-ascii?Q?i3v3cuJUqG0EFWCSXvceH83TMJEqBC5JcIB4KsiY+X/1CNldXMqfyFY0H7/Y?=
 =?us-ascii?Q?8ftfR7eYY7C9S5d6eDbEHhDPxXigAHb7SRVEiDktkaWjWNrn3br5ybbHCye2?=
 =?us-ascii?Q?8esdEABJf6QW+Qxtcezyc/hzVMGWQWYhTQmVK68mG1q3A+I+zyDs7tgJNX/+?=
 =?us-ascii?Q?H1ORoWEJnsFMzI6HMTMUtlIFuoen5EkQaUa9ChqKo4rcpEGPZB6TvftTgPnT?=
 =?us-ascii?Q?2G+lhSXfJkVWqRu2viYgCzSW+hd2AfSSkvskbxT2gPi3ikJueiL7kj6MvkDB?=
 =?us-ascii?Q?+5xqPz4np4VPW3VZuXh2bo2Fy2OTbqZEMM0i+f76HljWuLoJYgQDXMfe+GXl?=
 =?us-ascii?Q?o+tl4j+lMzi3HA/LCFaKvcMQSB0Q87hq6shXLlgLyGgIHETC95+VcYrAfTmq?=
 =?us-ascii?Q?VefzAEzsnA0uJTJsTeOIaHJdpzgBvCt51ywT5kccYynciuKMDa2ig6gW+qkt?=
 =?us-ascii?Q?2Zd2NKt7TkZv/lQfDK2l32XVykVWYFS2zpFgJVuW9G3HI3KmzPBLnbWONYKa?=
 =?us-ascii?Q?pGjZEYwZbp+Shn3bGh1eUQ7PWVzCzWt6TuanUVyqDYRibmdcDuqgQfaHBDge?=
 =?us-ascii?Q?Nm323KV32KFSdGeHML9snpXzRrmjmLN1D+F4iMSaNWFcq7XYqakVTd/kL2Hd?=
 =?us-ascii?Q?tdAYn+5tdhRJC2fl30iUCOS0Gk7bnRvf0UmkyjYEdO9sv23RNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(82310400023)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:52:55.0041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8d15e7-f54b-4837-2958-08dc947679dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367

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
index 00dc61358be8..43c5f21e6096 100644
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
@@ -975,6 +979,32 @@ attribute-sets:
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
@@ -1730,3 +1760,28 @@ operations:
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
index 160bfb0ae8ba..b73082d2bd52 100644
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
@@ -2033,6 +2035,73 @@ The attributes are propagated to the driver through the following structure:
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
 
@@ -2139,4 +2208,5 @@ are netlink only.
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
index b49b804b9495..3748f018b985 100644
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
@@ -996,6 +998,23 @@ enum {
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


