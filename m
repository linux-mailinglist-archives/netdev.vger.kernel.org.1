Return-Path: <netdev+bounces-107314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4C91A8B9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2777D1F273F9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A39197558;
	Thu, 27 Jun 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hSw85+bB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88064196D98;
	Thu, 27 Jun 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497391; cv=fail; b=Vm5TV79NFUqANC6GWywhUNr2xLf93tOCWxFnLtdWqWgKxvch6m5/RcyTtA4Zq4UFdEBceJfm248Yeb6sPJgwx/ybjHAzBa2Axw62p9OUGKv8ulpVbvoDAihMeBsKZRq7ejAlPwqkbanfgRq6z2VQY3bdFtX6UnAjT2ZFlzRf6UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497391; c=relaxed/simple;
	bh=tw/JyddXiOVBTrXCuWTn1nioac5ekXMPvE2he6BsqAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q2O+Gijp2xGHTi7i/Rji32OPiWMXJR4xUe/ZN0v03p3hhkoDf2OoWMXF0WGU1n482F/bij/pRYOvO2FSppgBeijyvHcHMcvnzt6t06OMxdY0Qxehisao8WJEFh4sCM7bDcDp4VWUQeRmkXh8y8TvpcIKI65LupGz+r2CjSYMzU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hSw85+bB; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrHAU/wg6tZZAoUqTHrPeJcPUCB4MdWi4m9L2suezo+uV4gFoOvpEJmJzBndskEHFS8t+frIWs/02AQNO54VK9JtvCxsvl/ka3T30xeOdMNHyJdQK0IcQlECM9BCvDbZWMH0/dfJKb6FYOobZQW3EOWYablYnH9FdvQZ8Mx0pHgo3FnsY/0chU9jxbgcsnKp5LYO5A6D1sBjU7RhVol3thKQzOgPKhCEJolkCfWj/DTLW+C9EjBitRYHMVGX4LCaFk67mpWPcg0gniIQOCB0Tn5EujjC+ZvNSB3wTWNhS2r8vlPf6DPIbYCChgnLAogzEaYPbQcFGgwxt7agdIVP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF6KMX32w+b4jFmZRWAG+XLjVedrHmsYp3EVwddu2cY=;
 b=TPBktEs81I9S9MfJEXTP/IKZ2Qdpg5AjiUrm82d8j2yAx/sHuFeNMrK3XDxt6Oy6A0uZ44q5hpNnCXVqQanW0ddlruBcsMnRqIb+UCzjQ7lbKSbpEcIKW/khAsYEek3tB1s0RRmnQe0HdIbEOYig9EkKTzGhZrvwnf1o57ZUbdUE6xv0WuXAtmuDc5Tjk0qbXqfLvdiwxH9MNmeOPaeVJcSX3xiI73/coSBRoo7C2TVSRcfvXEI9UfWmjWTwOfNP/T3KfghQyji1YjWGMtfTQC7U5DNmEAdiE9t7FcF0oX1mTZIE9VaWZl8u+JIwRLfUb1Jid640Gl0cJ3gdonnS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF6KMX32w+b4jFmZRWAG+XLjVedrHmsYp3EVwddu2cY=;
 b=hSw85+bBp9Kf+4MkU1z1oqMXftXW2wf43o7hkQbUdU0oiLc12VCifTQz03YFCo+hqYr5GWDoS8EBFjkSHUAXaqcpfC8hDXIBuCDjI9zu9A11LGmNtK23cxBRxVhmNSrwZTaH7IKFKo5qRKHn7X2t1kHmof3fmu0TPOFYCxKJ7hZU6WJJ3YBtjjaxR9KdmFjDqBC6VBI4NWSFcgGkoYYkbW5kpBcDm2z5vwCcT1nlduTlkD+rk88gkaco0yHe/fxGgIDYgkIKFmXuZ8+1SCONqiVLzDeOxApCo/kQPT6d5sbtN0NXzdBtrRwDz7Kd132Iw7Dq+NmibcWcje2yPt8VEA==
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Thu, 27 Jun
 2024 14:09:43 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::e0) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 14:09:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:09:20 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:09:14 -0700
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
Subject: [PATCH net-next v8 0/9] Add ability to flash modules' firmware
Date: Thu, 27 Jun 2024 17:08:47 +0300
Message-ID: <20240627140857.1398100-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: ff45a5f2-d3af-4e5d-70fa-08dc96b2cad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aC426+TjiygBWrt3A2oBbAV37Em29EguLzUxz0mk6L686MG3df5sJkB1j2iR?=
 =?us-ascii?Q?t3HBigLHewxol63o6F5EMs4wLrISQeEmTY3N+pfKB4t1rzbEkc0NaRNlB/bI?=
 =?us-ascii?Q?ekdH+JdPzurIcms4BVWGoPULVuT4hTkii5uo1/3TiwuN8BV+jnG+ZkGdJLF4?=
 =?us-ascii?Q?7dmx0DvnvmdlywAdJ0yHoFwe6iRiURj5cDNaj29SV1t3A5eWj5L7IuyD+gQn?=
 =?us-ascii?Q?NlbbbBv+/QJWkV7+qJ6cvl1InM2Z4HG2rp8f50Fz7MebG2agKs8B8ufcdNzQ?=
 =?us-ascii?Q?v9BSVotRqLkQwbAXKdWHGwdla87Itk0SGcjkffH3lFR+ec33B4RK+QPlamgW?=
 =?us-ascii?Q?5afBSPwKbindp5hTxwxHv6CIWwb0wU1XPDP0TCOpa6IJ7wY+7Nb/LUAkyRYf?=
 =?us-ascii?Q?RM/Krbvbu7IOheCPjb0phV/LzMw/TSOHMQfvorTT+jp40AUaFBpaysxnzOWF?=
 =?us-ascii?Q?rNKtAIkKaAbSvXzSRH7pA58dZkMz5p4LkV/3tNPE5q1waUcJA912gXN9NDD/?=
 =?us-ascii?Q?XY5BXrubfPLJtGskv+fmcroz9ajcZ4I7UvSRjrmUeeUX0zZiqhGTzKcx9h+v?=
 =?us-ascii?Q?eoBR13FXhweYbmN4Cckr72jkPHtWz2x0fVAZd81wRkch/i+sVRzK6OZhkly5?=
 =?us-ascii?Q?WN4TmXflBmbaYqqg+n/aZ+Jn1uEZ1pmotbSi+0KH1DnM7+Mv6JN/cYYJ6Nvd?=
 =?us-ascii?Q?ujJ5RuQD5jlwfUYY1AFSROzb9qPIlsCDjyUbAXI7ERLr/hOJ1NMxEpEUHXBW?=
 =?us-ascii?Q?F0oiyePpOk1zZqz5EZiPZWmkFaaAbk2oGV2jPHojudb0wixmjAFaaKr8nH9t?=
 =?us-ascii?Q?vL6WAUb5VdA5AMSZU+fMvm2ze9DM4UF/mM5LH4SALrM7r1uEFW20+FpVPT+y?=
 =?us-ascii?Q?kuEEBA7DGJ3olieyPoBZCGcxKgmIGmfZi4NdddQdBkpx82hN925U/ila7/JQ?=
 =?us-ascii?Q?kw1F8vkvsHSQBDeHS+02Y61RT1HL3+91SVyEtEJOuOpDYYSY3lrnYpAjOWrP?=
 =?us-ascii?Q?COowd5+vL9dV/B/P05P7zqKkYI9KIEbgIdBJHU1RvUixdRYUc+rOtifLB9KX?=
 =?us-ascii?Q?Xf3cx7Lf0wofh2Hy2wbXkek39kBWRnchnevkgACI+xDHG7hVyIHeeB4nijfH?=
 =?us-ascii?Q?I9SE9W7LAVSivIzUlCPJ9IQOGuV6ruOx4Dg4ssiEvGdXhi7RLPv4rBoDk0V/?=
 =?us-ascii?Q?gLy16ECHw8/MNCLB88eaFM4zi84wq0GWmHsGc5eWt83BkpXBmVBCE5a8SaOA?=
 =?us-ascii?Q?MQdNOOzqlQtjTC6cv5poMMKFqane1ROF0CLZuCpKZqUqp52y5StzzIF7LYxq?=
 =?us-ascii?Q?xm8I4u3eIGo5iwLmgkLnhPmN5TzMsZhsgbnARRsrEPn92AOMZnZh5XgkmOYD?=
 =?us-ascii?Q?9MF1m8Mbcetmi731YaYx7qsjmO7m6MSAf5oH7SIO26dJThPayBiSiNGSISyf?=
 =?us-ascii?Q?thk26pK/81hjjahWabhHo825TaHdn6GA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:09:42.8780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff45a5f2-d3af-4e5d-70fa-08dc96b2cad3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721

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

v8:
	Patch #7:
	* In the ethtool_cmis_wait_for_cond() evaluate the condition once more
	  to decide if the error code should be -ETIMEDOUT or something else.
	* s/netdev_err/netdev_err_once.

v7:
	Patch #4:
		* Return -ENOMEM instead of PTR_ERR(attr) on
		  ethnl_module_fw_flash_ntf_put_err().
	Patch #9:
		* Fix Warning for not unlocking the spin_lock in the error flow
          	  on module_flash_fw_work_list_add().
		* Avoid the fall-through on ethnl_sock_priv_destroy().

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
 Documentation/networking/ethtool-netlink.rst  |  70 ++
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
 net/ethtool/cmis_cdb.c                        | 602 ++++++++++++++++++
 net/ethtool/cmis_fw_update.c                  | 399 ++++++++++++
 net/ethtool/eeprom.c                          |   6 +
 net/ethtool/ioctl.c                           |  12 +
 net/ethtool/module.c                          | 394 ++++++++++++
 net/ethtool/module_fw.h                       |  75 +++
 net/ethtool/netlink.c                         |  56 ++
 net/ethtool/netlink.h                         |  16 +
 tools/net/ynl/Makefile.deps                   |   3 +-
 22 files changed, 1963 insertions(+), 11 deletions(-)
 create mode 100644 net/ethtool/cmis.h
 create mode 100644 net/ethtool/cmis_cdb.c
 create mode 100644 net/ethtool/cmis_fw_update.c
 create mode 100644 net/ethtool/module_fw.h

-- 
2.45.0


