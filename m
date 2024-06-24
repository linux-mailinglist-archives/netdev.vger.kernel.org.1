Return-Path: <netdev+bounces-106220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A88B9155DF
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4131C21FD3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA661A00CF;
	Mon, 24 Jun 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rxC4mDHe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C119FA8D;
	Mon, 24 Jun 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251571; cv=fail; b=nw71eW5ElQ4Lv9nW6J74rzDknK+so94jN8uP+BCmcAnpOkQkLUGcG93pnEu7y06aeXr7TzGT49+0Y1A4FwnGc5Es+dKrPxVR0XayIeuJxFtE+o5v5+kozBSvBKEgaAHiR5CFQQ0IPPaQt36L86gtXnjtzZfZhd+4vLnAyLb51+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251571; c=relaxed/simple;
	bh=Qhl5SazJUMtzhRvoqlWvqA36Uebdj7gOCmuL8zpy0WU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n+Fi/hsvBXayKVkx4iYT27UloazWsNU3ZCNqy/nqjb34Hbm4Wkj1GWuvx1N7+hhjO1GPtnV7FySBRn2AgLjspVysuwIVSziOlOBexOxrs1PFnL1zk96pmnkh9cC9iFhk9nE41yiI7rlD79Kgh4br+W6klM54GliyKW4ipOtQw8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rxC4mDHe; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y33Bfa2iS0IRsh/QVFayWKhpyraBZrZ02Y2YrV+WKdroz8X/FtTcDWaq1MiipQdTrp9k1G4KlSpoKlE2xRHAaR2d1qsxOikLBtsBC4vjmc/ktDJuNtUjmTZCgx+VbtGpRKu/qvz4ME8O8sRkaVnKhpkonqTiInK6vxSioBzTr0vAG44pBgyylzO4+rUgwAMeVHeZ6jG7bIZ4x5TV8jdnrI1TS3w1rBTQOhNDuM0r3g00BjozuYbd7cym95q6ZUfghkZwKM4PAq5IohWtiZLzr34zLgH5qS0cSiabjcVScQw2Kbh4CM6KvWUU+f9noc3RlsP/efOFgUHbGW1sa/0m+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pd2o9Is6u91ZzKBdcN+5SSM6KX3Ldhe5gY8amWpIjp0=;
 b=n724Qamc9tc+FOf3+tCttPoRisJWzIKbKmEvd6luYZc63FrwIcARMdkwdw9CsJNwRgdtxroaSuOpG7uchqDqfTUrFx6rA/ifKcswLrNKqjUP3pyl73RZ2Ri9yINW3k6CFqBcCNwFEXg1/orMgRU/naK57oSdxQGiW/bfj27+7gmFZMAuk5F/LWvrUquxHeTAqvMgpO4//ruljOZKWha1XUygKzqzVr9q0aL8heG48lqxq5uQwglrBgFdjTxM+XVKRL23RfM0UW/JhjCTnMbLMLNrdUOyS/LzNE7EfyUY/s2am0AESoNSnuMps3m1FFLnEgNK456p3ZYCHFaTCSR9Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd2o9Is6u91ZzKBdcN+5SSM6KX3Ldhe5gY8amWpIjp0=;
 b=rxC4mDHeUrGkOZLkljKRUkev+0Zl1q7rOqWsYDreoD08abpFystIArihvJgdgQj78LqQLPuwVrttphsY0xFQfLVe4ISjInnBFzLpkFd6BHkKAIpJP40wSixFLRdiUxH1g1q2xTHJwo67eOZKCoEQjkPmIpqK2q2x+0KpG4/tOj6FHnNe2ioI3yXI4DpN8Yj7oed8EjWAkdcLkdgj9mya7J5c1sIDteR8k7K73r1nYDwrbIsJHydTUCtXZjkin+18PgcCxu049BI66cStPmrfdDhnj7qmX4p9ojkfLqWTbSdKCKfQk0q62MFhfVqPYX0STca4bnMJekZwKMlUNEcOoA==
Received: from PH0PR07CA0038.namprd07.prod.outlook.com (2603:10b6:510:e::13)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 17:52:42 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::d1) by PH0PR07CA0038.outlook.office365.com
 (2603:10b6:510:e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 17:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 17:52:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 10:52:21 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 10:52:15 -0700
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
Subject: [PATCH net-next v7 0/9] Add ability to flash modules' firmware
Date: Mon, 24 Jun 2024 20:51:50 +0300
Message-ID: <20240624175201.130522-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f6e547-c09b-41cc-eacf-08dc94767213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010|7416011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V5ziRChRq+5OBzD4jdsYya+URA0s9xw9SAlXMBiDn0q2QNFAdIbZ9uBGv1y5?=
 =?us-ascii?Q?t5UQXCwdMiQEm/PAubqQ5i390vxkLzpWZkPk0a7v6ZIdgLbD/LgFfrzeq7jw?=
 =?us-ascii?Q?DjYM5yB9JxFYY25rhqVVkbqKhv6+93OOPEfWSACik9huJgL41kThpOsVD0iK?=
 =?us-ascii?Q?LVX68BBhBnK/hJzTWhfdPmkciHLR9XmMxxLmpFc6fhGJn1eVQoNl2ZIaaYnc?=
 =?us-ascii?Q?wL6oP7owdy28KRtlUjQi0j4MWSpu3fRHQnpVZiX6V8z0G2UD1j5jDwhRu3tI?=
 =?us-ascii?Q?aMqiHqG7lnAKLLf4Wc2p69znFuElr+0EQb1XBQW1M+jBsAWU4gKbs/QPSacc?=
 =?us-ascii?Q?X/lx0yIog897HO9mkuKhXQQ8bpePxjvvgttyhcuNatl+edsSOjD7+49iyr53?=
 =?us-ascii?Q?4zpWf7kaLIaSrfgNiOeFpenqYi1JBm4NoeSy1iCqzKHt/rHhecYWOe8+avcM?=
 =?us-ascii?Q?jwe+hpUhsceWFdSeCqqyZDPaaDtHgvxTgj/1RBvGpLHHiRQStm5XvqSlZYOd?=
 =?us-ascii?Q?Vip7GzuGLyBc9ZmQ/AzH3Bm8Uy/2IyR9nSNqro1lio19dJKWITmRq1Zg8JGO?=
 =?us-ascii?Q?6LMpIHAm7vhiJRjzKYtCjtg1fSACffimd0Eg1zJZQzMGHkvvR0aWq/hvUGLL?=
 =?us-ascii?Q?Ya1H8WPH8r8zK0t8e0ulK7FLiwnr/HX0Egqta21o/vRNchviJMmLTmAOmILI?=
 =?us-ascii?Q?+6eiCm0MJo29+vMPupoUuF0QLB5JkQfwamsZQzloP423EvnU+77ecJx5r1VZ?=
 =?us-ascii?Q?RYizYa2Zt8SgkK21UBXUitvzjdo1SPFi91UARE+rrFjH5LkS3jmjGhG4/Ixj?=
 =?us-ascii?Q?pFCdB0Fdh/2TEPOLjPUSgxVF1SikhV6E1CNfe9MI8mKSC/S+jzEGYLn/62H3?=
 =?us-ascii?Q?qOyV30jwP9EGcMbhFFaLTKDkL3DdmT8c+AQRpARrtLn8poVaUJg8y4P9W6n/?=
 =?us-ascii?Q?fdU2Nw3fYBca1WEsW0kQgmcQ4u0SdSiZGBAl07w6lCzLMMZxq7l6mhQdCj4q?=
 =?us-ascii?Q?DQjrbS8A9SXFgUmNtIjbyaQm8VJFlf6PqHYshhluXZFQUWgVhxk0knGl+B2p?=
 =?us-ascii?Q?XaJ4rMqOFaew1LgGdDyKJbjRVXdWt40KGqhZ9i2vzPyKMn/R//TspJ7wlNom?=
 =?us-ascii?Q?M+mRER5Q+00lKtIEDE1BelP4Rrx0MTO/5WTy4aS4+br1EmGLrTG5Rb2U9D9a?=
 =?us-ascii?Q?aLgYrJhC30fibmmXYbaWiHNwQDwzq6XPBlFEQSWNQXieMM1fOVqCI5+oR6tV?=
 =?us-ascii?Q?5Nhp8XbGG6kHv//uWfm/G5EFCR0dZdY4Leuuq4/0wHC2x52be63lO5bDjtwD?=
 =?us-ascii?Q?tZBSksHN0b3PXjbxBn2aVSHuxkNjXeUZwyZ8Jk+g8PuHpc0+G4Or+feAgD45?=
 =?us-ascii?Q?xSNxk1yFLI15S8qB+lUIan4fm3h9baJcFwaByh09MSwCZrxHNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010)(7416011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:52:41.9946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f6e547-c09b-41cc-eacf-08dc94767213
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821

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
 net/ethtool/module.c                          | 394 ++++++++++++
 net/ethtool/module_fw.h                       |  75 +++
 net/ethtool/netlink.c                         |  56 ++
 net/ethtool/netlink.h                         |  16 +
 tools/net/ynl/Makefile.deps                   |   3 +-
 22 files changed, 1942 insertions(+), 11 deletions(-)
 create mode 100644 net/ethtool/cmis.h
 create mode 100644 net/ethtool/cmis_cdb.c
 create mode 100644 net/ethtool/cmis_fw_update.c
 create mode 100644 net/ethtool/module_fw.h

-- 
2.45.0


