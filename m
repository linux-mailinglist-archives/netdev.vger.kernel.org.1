Return-Path: <netdev+bounces-104852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B34290EACE
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894A828131E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9B14E2F4;
	Wed, 19 Jun 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gIlyJkim"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF814D2A3;
	Wed, 19 Jun 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799503; cv=fail; b=O68/qbtY6ZWLxMZWgUUfsM+JhHKu8OphL9IXuWDwji6WT48DhIS27dZvFrpeowg3hzErJDk4Ld7jNN/v8KLVUXoW/u9lInHqOa/lCgdnLINpxdQIo95TgWJkgLUIOH9LYzeLKPo4KjnyHh8oJHjTPcRAbkdpL+ovDpDQ9p5BIQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799503; c=relaxed/simple;
	bh=/9auGPgHc348Aag4gLWWS9stNitcDk8YzaKsBPsVq8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWT2o7vL+Ur6ifLVZXKGNP1ebiNrNtp/kV41r3zcC18yJ2MXzCkeYJ7/bQs0X4pP2T9pwEO5HxmRv3/qgqRDiYliYoIsNL4BxDn6h5o3+jftpXMBZa9EifksHyV/GWehDkPhhyJyaDQ43j4R+nHbCrgGazSuyXRZmNq1v882HW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gIlyJkim; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnjXtRk8bRQByyjy3NKQ6vLbWo4G3fPb5os8Xe6x6bs4qaxOmn/nho3YWemEi5w0ulOvNqKKlu5zHDMq2SOGvVP+hqsqK1nQsPjBFUV16yKVb4d+mVKGXSr8eSgzjfYw7X+sWSXmDoA6L9+4f0cwmOyYPS0TvCTyIKqzFi3uE2BAu7xsP2PzZDsWl2gYQ+Bhsnak/VBi6W2hf0rxlth+9cx9HtG6Eat2aBiGX+ef/IfqM/ozHYbalFCmdN0NUl1BM7IbyoUVCaT8SVZWw8C4i4Q0e/1FYRV6XYXXLdjK1f+jb/J6QabbI8SeSXN9xMRMdGxz6KZq+De+AyQIub66Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50crNkk2tUbJ26WNWwrar1INxg6W3LhnEN5u5oLgdIE=;
 b=UFAuIDRFh4sWDBxrkmRgh/q+4VmTz/2DMRJmTd8f02yoJpeEXgkDlq/awH+uI2qOS38WeF8FJcQoAtPgfcU6LH95KblC0o+FwIshEUaOKApWkE/yt2U17QcW4TOy8iiZy1W0OYZH0BCvF7SV94sK2e4suAqC9NOue8Eza+UHaVocVX1LHwAI5X+9nGKxf8PopAT+NKzZZ0qf/jdxuDdyyugeE9RLdi8fvxZqW0DX9RbJ+DyJ6pOU8OD+KIQSI5yp7MplUxjONpgvqVCQ94KM/Xa8vmSb7aMsbdu/o76SLYnNHaOmSPHd1iBNOrzwF8njPcS6reexQn74ZMfvvtMo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50crNkk2tUbJ26WNWwrar1INxg6W3LhnEN5u5oLgdIE=;
 b=gIlyJkimYcN6qHFD7lVWYa3nEgwcxbBHA6Zny0aY8h+wmurbT584BJEGkWXL2XGtk4sTRRZYCAJRlHgWwvGgeNJqAvXVlbju09JuusPNm9UCpqHZRUmZfzBtys3Ku98Xh+BOtfPxGT85seUgfVfzmX7sbr8vdZlG/vLpvIB+bUakmomQtsKmnLGyZ2PlDa6YDPLz26grOKtwgpVdWfGuD7uN/FJ8l6Sm4McB3mO14DiYnlFubiEnfWtogab69E0s+wiohQCCEZeUBGAVuapIxdaxLFNTaXZQTVeXFNO7ptUEjr4cDNcnp2Ns6hNHmkCrvsFpk62YXYVSXhTKCPPbSw==
Received: from BN8PR03CA0015.namprd03.prod.outlook.com (2603:10b6:408:94::28)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 12:18:17 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::c0) by BN8PR03CA0015.outlook.office365.com
 (2603:10b6:408:94::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 12:18:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 12:18:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 05:18:04 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 05:17:58 -0700
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
Subject: [PATCH net-next v6 3/9] ethtool: Add an interface for flashing transceiver modules' firmware
Date: Wed, 19 Jun 2024 15:17:21 +0300
Message-ID: <20240619121727.3643161-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619121727.3643161-1-danieller@nvidia.com>
References: <20240619121727.3643161-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: d405f612-1c2e-4b99-9b83-08dc9059e673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|36860700010|7416011|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WmNE66vUh7pObubxFK3W7jCubI1Ru0pfBilT5/h+UjQHg0GCZRErr1G9lUzM?=
 =?us-ascii?Q?eTgUM72ELPaSxFd9q18GTxYZFRgs89zU2qvpiZ1M5Sv6W0ZzvM1VdVgjYwhL?=
 =?us-ascii?Q?w0qB/fXgUWdTUEClEpUfmHXDylY9sXfR0md9Bb/Symzm2olg+TaB55O/UQwS?=
 =?us-ascii?Q?wa9SfJkuopjPzyiaCiYkk9ONTcktvFHsf5PlMxOWj/2x5A/n0LmDe/kVWeOx?=
 =?us-ascii?Q?m3KCqfV3iBVngeSQo/nB9ucbOC1vREXptUmYvpk3W/O+w0S86BeOIBItwOYw?=
 =?us-ascii?Q?DW2O1LM+QLVu7d3nKyO/VAZepfxt0Pfk9Ufl47+vkcpenGaO3ptFMjiLM5if?=
 =?us-ascii?Q?Dcu4EGq8SiSltObEPntHcYUNJsqQSh1pKguq+2PD+w0sHoChylGxJF1oA7P2?=
 =?us-ascii?Q?TPChUrIwrUA29fPuZ9j687Eyuc6nMhwd0H/iAPtHVRVdqHh7vJyhQ0AIfryT?=
 =?us-ascii?Q?QM4yrHiPvfpBohqHochuMcurUH8zLJmFYHnIBSPIeEk4Gt6W6taHhPowqR+1?=
 =?us-ascii?Q?OpdHOrFIvwND/pypvzEV5ahUTqqyU+i+sELox9jzYLLLaOy4UlIZhH8m67VD?=
 =?us-ascii?Q?eRUcfvi0a798R7DCD6N6gejwW1/Z8k12eAA3ekhzK2sR+qjjL9ZIcb6OQbCY?=
 =?us-ascii?Q?Lfkk3OQTQg2jeBQU2MugHtLAeCDDJLyZ3CO8gko5fqf2VqdCDA0Eog6py7Vi?=
 =?us-ascii?Q?ZcAwzCvvWAF9Q39OGTIN7SDdx65il5LKJ0QjMx6gZgwnMkiVuD0gycpEMxaU?=
 =?us-ascii?Q?pc2Sd7Pr2ysqjvwygTRiG1FLgiDIdZ52c8Oxjn/kXN/twFbnCDLoWUWoh5sp?=
 =?us-ascii?Q?Yu7uFLJBDPQnyeAy6aQK08EdwjupJMbydsA9aZr9OLMZQ9jxwjlA+lKfa8Uu?=
 =?us-ascii?Q?jOFoHWDVMaGp/mDtrVw/Hzvxvqf/Sbh+rQ1Zk6kG7QpSGQCbWveReQJll3UH?=
 =?us-ascii?Q?yY2NuE91WwNDe94MoXvVtxFdUBuApNvVhGR6yKeazX/MvWdcMQ9PaXwjVcF+?=
 =?us-ascii?Q?8DmtXBgGFE0mh1dU29QsmTa9DXo2CD3p6hBvZHNPEOBU64DuM2J2PBkOygnE?=
 =?us-ascii?Q?esNyuvambae4M0JRX98LS2W5PxX1k0F+HO7L31oohtoBBSBZDvQaWdh38KCX?=
 =?us-ascii?Q?Q8W0OZHPeKuPnmCQjwiO0E1XRKQZkZT2bJU9wHnWnvTXY4QEoQmepyIALevO?=
 =?us-ascii?Q?J8PrszLWhk96O/lJTvS8gnsX0Incxo62EikbVlt8e2BMVTed7JAQhtqPTDYU?=
 =?us-ascii?Q?evnSUxqkTKo7ZjAe08ki2uGmIx8tKDUewIhMuI+XRxCaiqYDVgn6pI6LAvsX?=
 =?us-ascii?Q?apU8sdv82MPX9Wttlk2bPPkf6Li5ErHR9RzXOAllrIY7UGFhfUkCPgf70DBs?=
 =?us-ascii?Q?mnZJ/PgAIJiiJJ4/Fu+519MQ7Z6L5J6odtQnTXQI46Ds4OoqQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(36860700010)(7416011)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 12:18:17.0718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d405f612-1c2e-4b99-9b83-08dc9059e673
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810

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


