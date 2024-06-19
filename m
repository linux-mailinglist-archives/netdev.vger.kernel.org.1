Return-Path: <netdev+bounces-104848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4E390EAC1
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2EC1F24F40
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE0142E67;
	Wed, 19 Jun 2024 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N2NVawEL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD282D9F;
	Wed, 19 Jun 2024 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799482; cv=fail; b=uvYV9bqvm0PMOlDxLyyZ5z28jDVZk+A+sNi+jmpzbOxFx+YF4xuv5hDgZ/osKFq+x4r+laupYusKiYrf5lj/WyFX7jCMJC5gmEztf1hUjLq+lrzuJk0NhcL+IMOs7gG5hfDGCfbPX701+eDVfZT67GrobgJqA1fZjahxV8s8/YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799482; c=relaxed/simple;
	bh=msg26cdL4ARUcLSXWBdzRyYlTI9nwFDlcPXwA5xvLhk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gJLZmA7XEOm1nUlC0gbmsumslS+thENU8wktsJrLOKRutaI+pyasjJA5QlIalV6VQGePgkj9PHUGnwP2tPaiZFDshOsgDw9zFD/iQDobK850qMDas8rzxGqg0ySH1UvgQ8T1sTtGIw799gK8ZPL9PeshQETWnEXelBEm45bwmBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N2NVawEL; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZJenN/CcAxwtN3Ch8aMlGcXQUCob5E9I++9J71zDtLCiSWaWHCzh/vvBpeignqhq12uZlRlYJQOtJOX1ANYPtrpQyvT9Mq+Vr7ZnPKxyVCSKLV5FpQWO0lJpMAF7ZqzAp0JE4sR4DL/d1yjNR0Gsr0a9EgnhFvbGNE0WzXw/TRRKvNvvrckZMWH5R3Br+IO5vBA+gGpaFRYUxchMZGATjvOMuPdoFQgajWvJY/jE/utmbwW3zogHPU7KIO+AKLBRWPqj9hCqFrYx1qc4ckbSadoMJEjDOH+Uvv1GYtIaHDin9+z8Uw1DvT7k0FlZoU1sulH1bj5blRlsQGWdyYKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp5t0yOBbqE1Lr3P2uP9yOQDv5jfhBv8uqN9E9tyBMc=;
 b=dDgm4ccdnnHGiaA7KQCmonztOxkwdW9CkbFHyiBky6JUQkFjvl46CLXLFGff+ySDjgLhRfv2vIijv80sluVRxP/zfvDbNOtXc3RSwf1+ErOB6AEMKAIoSddfOTlcH6kZQ1EBO4TLEPvy3vevkmno1DXdCqrbQ0gXHu/KF0AN/5N9czA3PhiJe7JYGLuBA7PzCd9vTIhKPNWoFAoL/OP5kjKTptHSa3rCuTC+z8Wkx2li1/KufoMVsupDiPUNNQKOq88nK7KVSOMpW1tjY/WIBqnKVaUHvsg+LCTGqBvp/KuAm4S03bvUCsvmEL43D/dXfGXQfMSq5nJXgRj1x14MpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp5t0yOBbqE1Lr3P2uP9yOQDv5jfhBv8uqN9E9tyBMc=;
 b=N2NVawELdg+EudgduMeuC2LCzn/165hB3r19XDzC54+zU+/DIn2r7hjW61hhvSfuY3TBS6V9M3uXDTV0LPFQMquxe4E4cG+oit2fRrcZ4G+LBFNBs2t2HJkqQUKd+Kthq9i5XDRkI++EcObkVUOVdOkm9XWSpBgBVR15Liy+ZrklRbtQxjhJnMNq4EbYZsJ3GZ6Fubqu0eOXxpPIwIpmTu/9TOa1Ckjlf9WnK9QG9o5ylI0Yj3j5Jsl9KFgQkQn9z99wykZHS6L3aqCNI/CrjE3pASp5alX0WcqAuj6Dd4s25iRz+UX4Am9ZHzHc5A4UGnFDIRsrxOgs5n51XoQsAA==
Received: from SJ0PR13CA0042.namprd13.prod.outlook.com (2603:10b6:a03:2c2::17)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 12:17:56 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::87) by SJ0PR13CA0042.outlook.office365.com
 (2603:10b6:a03:2c2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 12:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 12:17:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 05:17:46 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 05:17:40 -0700
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
Subject: [PATCH net-next v6 0/9] Add ability to flash modules' firmware
Date: Wed, 19 Jun 2024 15:17:18 +0300
Message-ID: <20240619121727.3643161-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 45409194-fbb6-461c-b44a-08dc9059da1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|82310400023|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rwdW+oFNg2IA/D5rxcmLtNUELQ+SSGoPSzgZYczuni+XLDehaKnnM3yAJ5ua?=
 =?us-ascii?Q?mXfQ9ADdyepwldCngIfB33BaWto7pzrpM1C9kmHTNtpZs12u+9eo7eZbiJcJ?=
 =?us-ascii?Q?iBJJ0D9n1vaZAF1smLwFWNFCVm0OFKpzJu833eahitNn0IocHvBeYKsAUvd0?=
 =?us-ascii?Q?Z4HtGKg6HGLzYyntMMV7iBZ9ah4FHDSqfn3EnWtXy2ZgFudX8m1eo/BpJIwi?=
 =?us-ascii?Q?Ru47I40XEH9xR5hYAra86xajKk67VCH2HGGFNHbeQTbsnICumCvmjwsITH9i?=
 =?us-ascii?Q?4jL7jyZcMPe8mX+6oSAgPUUlN2vf3rcH6SAkfqszOV/sgUIVMlmmn6vyEs25?=
 =?us-ascii?Q?Pgj6OQjTRjbrZll1MtvNKf/3hUXfDyja4lhQrp7Xdc4BZxxpEl5im1omDbrc?=
 =?us-ascii?Q?C+oOIN2aKaZKJgclaVbPeAvjbBO6WmfW1qNRB6Ug2GEv3eQ2w7yi12nl2rbL?=
 =?us-ascii?Q?Dc1be+xRNLxKK+KCZg6gcdMzX9lxN/nqK/hbHaiAFNS2k/wh9dFAIuwcgxOS?=
 =?us-ascii?Q?xRs70DGqVbZHC1oH+JWt5NElhqTyPFyG8RhsEUvBRpoidG6HLy6jsEfvEXiT?=
 =?us-ascii?Q?owH+86q5/PBMgQ1x1FTt0wOnc72EElMhd04eW9z2UyTbebrUXJPY4BTq9BCJ?=
 =?us-ascii?Q?BT9uV7kpHT2NCerRfRS20WrfT52z0qgFG/nPPReOh39ZOspzoFDjB+WU9/ta?=
 =?us-ascii?Q?qrKE6HG/6r+oyy7xu2NcgcjOJb4XGCGJnicBb9TIvDW51LP3+5fyRyvF5pLe?=
 =?us-ascii?Q?7ynfxX/AmQmWBiGzOU5A+DeeUd2WsHiW3HOKIITAwqqfl9JKOdgSpFmmYTwu?=
 =?us-ascii?Q?2lYac8luruw4T1VbsQhnslJ5KXaj7qZi+Tu/VxbWY1o6NJWqZlz0UqyvVhQe?=
 =?us-ascii?Q?W17CJoz7fAI3FWc1Xt038d+ivuj+VXgdTLnfCAPF+OaBa/ZsTg9EpqMFM6N2?=
 =?us-ascii?Q?1bkx18EMfKycANetPKvCmZ5wPnpsK088o6HYMkEoBXuZZ1VTh20f2jeWTUBC?=
 =?us-ascii?Q?Wb+IP5f5Eig4Sm/YIpn2m/xC/a5/oFcklZb8ndK1GcoUcTArTyLSeEy7v4/a?=
 =?us-ascii?Q?+r1CjTCHDYycaUdOJjjWd3S2D49s2A9px51XncGqUHLhCWK6suLOmpOHgAMg?=
 =?us-ascii?Q?MBTKOMd+UzfL+MD1V1XTjrQ0U+zVjyeHb5fSCRGRSmqn0QjRly48rj5D2ygA?=
 =?us-ascii?Q?lYBOU8FxlveX1+EuUYWlstPy819hbHKeAzN0q3f2CQ81ZuB6iVn3iVSJdsjN?=
 =?us-ascii?Q?KOG+KOQck+sb5+2JWqnuWFH8mDSVSfGjNx4begpIdU595v2fd2A+mvW/zOmw?=
 =?us-ascii?Q?LA/kD8OpfmyCeKgCWAEW+JDGMzK9IF/B2iellIXdel9Hm1UihQrJDXSngY38?=
 =?us-ascii?Q?kaO4jPjKmsxATPCL62kLTUN3Q6362xYb9aXdXdxX1tPMM/xcjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(82310400023)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 12:17:56.5389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45409194-fbb6-461c-b44a-08dc9059da1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804

CMIS compliant modules such as QSFP-DD might be running a firmware that
can be updated in a vendor-neutral way by exchanging messages between
the host and the module as described in section 7.2.2 of revision
4.0 of the CMIS standard.

According to the CMIS standard, the firmware update process is done
using a CDB commands sequence.

CDB (Command Data Block Message Communication) reads and writes are
performed on memory map pages 9Fh-AFh according to the CMIS standard,
section 8.12 of revision 4.0.

Add a pair of new ethtool messages that allow:

* User space to trigger firmware update of transceiver modules

* The kernel to notify user space about the progress of the process

The user interface is designed to be asynchronous in order to avoid RTNL
being held for too long and to allow several modules to be updated
simultaneously. The interface is designed with CMIS compliant modules in
mind, but kept generic enough to accommodate future use cases, if these
arise.

The kernel interface that will implement the firmware update using CDB
command will include 2 layers that will be added under ethtool:

* The upper layer that will be triggered from the module layer, is
 cmis_ fw_update.
* The lower one is cmis_cdb.

In the future there might be more operations to implement using CDB
commands. Therefore, the idea is to keep the cmis_cdb interface clean and
the cmis_fw_update specific to the cdb commands handling it.

The communication between the kernel and the driver will be done using
two ethtool operations that enable reading and writing the transceiver
module EEPROM.
The operation ethtool_ops::get_module_eeprom_by_page, that is already
implemented, will be used for reading from the EEPROM the CDB reply,
e.g. reading module setting, state, etc.
The operation ethtool_ops::set_module_eeprom_by_page, that is added in
the current patchset, will be used for writing to the EEPROM the CDB
command such as start firmware image, run firmware image, etc.

Therefore in order for a driver to implement module flashing, that
driver needs to implement the two functions mentioned above.

Patchset overview:
Patch #1-#2: Implement the EEPROM writing in mlxsw.
Patch #3: Define the interface between the kernel and user space.
Patch #4: Add ability to notify the flashing firmware progress.
Patch #5: Veto operations during flashing.
Patch #6: Add extended compliance codes.
Patch #7: Add the cdb layer.
Patch #8: Add the fw_update layer.
Patch #9: Add ability to flash transceiver modules' firmware.

v6:
	* Squash some of the last patch to patch #5 and patch #9.
	Patch #3:
		* Add paragraph in .rst file.
	Patch #4:
		* Reserve '1' more place on SKB for NUL terminator in
		  the error message string.
		* Add more prints on error flow, re-write the printing
		  function and add ethnl_module_fw_flash_ntf_put_err().
		* Change the communication method so notification will be
		  sent in unicast instead of multicast.
		* Add new 'struct ethnl_module_fw_flash_ntf_params' that holds
		  the relevant info for unicast communication and use it to
		  send notification to the specific socket.
		* s/nla_put_u64_64bit/nla_put_uint/
	Patch #7:
		* In ethtool_cmis_cdb_init(), Use 'const' for the 'params'
		  parameter.
	Patch #8:
		* Add a list field to struct ethtool_module_fw_flash for
		  module_fw_flash_work_list that will be presented in the next
		  patch.
		* Move ethtool_cmis_fw_update() cleaning to a new function that
		  will be represented in the next patch.
		* Move some of the fields in struct ethtool_module_fw_flash to
		  a separate struct, so ethtool_cmis_fw_update() will get only
		  the relevant parameters for it.
		* Edit the relevant functions to get the relevant params for
		  them.
		* s/CMIS_MODULE_READY_MAX_DURATION_USEC/CMIS_MODULE_READY_MAX_DURATION_MSEC
	Patch #9:
		* Add a paragraph in the commit message.
		* Rename labels in module_flash_fw_schedule().
		* Add info to genl_sk_priv_*() and implement the relevant
		  callbacks, in order to handle properly a scenario of closing
		  the socket from user space before the work item was ended.
		* Add a list the holds all the ethtool_module_fw_flash struct
		  that corresponds to the in progress work items.
		* Add a new enum for the socket types.
		* Use both above to identify a flashing socket, add it to the
		  list and when closing socket affect only the flashing type.
		* Create a new function that will get the work item instead of
		  ethtool_cmis_fw_update().
		* Edit the relevant functions to get the relevant params for
		  them.
		* The new function will call the old ethtool_cmis_fw_update(),
		  and do the cleaning, so the existence of the list should be
		  completely isolated in module.c.

Danielle Ratson (7):
  ethtool: Add an interface for flashing transceiver modules' firmware
  ethtool: Add flashing transceiver modules' firmware notifications
    ability
  ethtool: Veto some operations during firmware flashing process
  net: sfp: Add more extended compliance codes
  ethtool: cmis_cdb: Add a layer for supporting CDB commands
  ethtool: cmis_fw_update: add a layer for supporting firmware update
    using CDB
  ethtool: Add ability to flash transceiver modules' firmware

Ido Schimmel (2):
  ethtool: Add ethtool operation to write to a transceiver module EEPROM
  mlxsw: Implement ethtool operation to write to a transceiver module
    EEPROM

 Documentation/netlink/specs/ethtool.yaml      |  55 ++
 Documentation/networking/ethtool-netlink.rst  |  70 +++
 .../net/ethernet/mellanox/mlxsw/core_env.c    |  57 ++
 .../net/ethernet/mellanox/mlxsw/core_env.h    |   6 +
 drivers/net/ethernet/mellanox/mlxsw/minimal.c |  15 +
 .../mellanox/mlxsw/spectrum_ethtool.c         |  15 +
 include/linux/ethtool.h                       |  20 +-
 include/linux/netdevice.h                     |   4 +-
 include/linux/sfp.h                           |   6 +
 include/uapi/linux/ethtool.h                  |  18 +
 include/uapi/linux/ethtool_netlink.h          |  19 +
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/cmis.h                            | 124 ++++
 net/ethtool/cmis_cdb.c                        | 581 ++++++++++++++++++
 net/ethtool/cmis_fw_update.c                  | 399 ++++++++++++
 net/ethtool/eeprom.c                          |   6 +
 net/ethtool/ioctl.c                           |  12 +
 net/ethtool/module.c                          | 392 ++++++++++++
 net/ethtool/module_fw.h                       |  75 +++
 net/ethtool/netlink.c                         |  55 ++
 net/ethtool/netlink.h                         |  16 +
 tools/net/ynl/Makefile.deps                   |   3 +-
 22 files changed, 1939 insertions(+), 11 deletions(-)
 create mode 100644 net/ethtool/cmis.h
 create mode 100644 net/ethtool/cmis_cdb.c
 create mode 100644 net/ethtool/cmis_fw_update.c
 create mode 100644 net/ethtool/module_fw.h

-- 
2.45.0


