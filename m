Return-Path: <netdev+bounces-42553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF35C7CF525
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E3C1C20B3F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9C2182C1;
	Thu, 19 Oct 2023 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q+Cho/mI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957A21862D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:27:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1810FFA
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLNAE9BrAvlP7XH7f3sLe5lddBBOBqKZDANa4cTBn7neZ7FYtrvSdYFagNf0FcSNdL6438bNd/V3jR+c/ftVrkqwX94gmoiMcXHjQfJuSo0H0R1jyFH/4L22rqoouERjqhaUqRRIc4A/EZsOulZKB+BeRTbxOSjdBB2k7dwEI/SOIQd1mY5AAeaapDlJlHq35i0UsjggBkF63hND1WQcC+hWPq+Y7BLgojQL3UzJ60QfnHtGvcVvu91yowawrnE4AfhMZaOs/mwXqmhkCyOezMr/U3VL+hCPzpas1corBm/VQeCDUdCn5RTfgHD8jE8e18suBAAPQP1ZNZpdSlOaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/JnKZ5DXIiPhaeQZr3xJV8V2khF1uwk6SdmXBAWD7o=;
 b=g5KlF8OZyiPVLlKoUFzFUk10tGAK/4+5jz+1W88ZeT8eNTfHe1E+oW7UbJvQAT67R0kWfeyv46D9hez//f9UiUVWLCAGLYIT98DZLnKTIDxF7/MyY/SIxtffLs+pZIYzSJlgFafzJ2XVq8I1Fzki3iIuGrV1t+dsI+ezWB+dF+ZjJDBZMG0hccHqwhxXLVlDLlx8QxYymDIE4X0iVzD/iRiWHYVVG3cczbT5DLDQHOOKZBCHxvUFwNJixiAOjzX61NN1xiB21IP46PrJDAQ2b5UU7ACLxr+0Q68OIeVfqH2+i2vNsMoVdltnAmatTQaTpSM2OHVboLl47bIq18So1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/JnKZ5DXIiPhaeQZr3xJV8V2khF1uwk6SdmXBAWD7o=;
 b=q+Cho/mI5X2DTi1ed+ruyLROBtvSx50J436vPg5BWHz3zwsG4Li3qmrb07Ka/J7f0cMVDDBNwLd9/ezUmpbep5qIXL7GQOOl0RqGXE2TAalX1qUUvc+kiCCpmayXKjdpN/1PnqHnfgTardhVCInXnOUhGJKmRjUMq59p/uL1GhqFin9pkTHT7skpk4bIxEwEycisA03lpIvY901QZlNcDbpSvgcrhH2SnXjyEGNMLYT7s/HLByIvVTy+UBThZn7ID1c9vSveciR2dcEULLCYajHqVAF+oOumi3nAOEirMlesSv4UF2/2SEqxBM5BniL1yjMQpwjogrmsUn7p/9OVAA==
Received: from PH0PR07CA0101.namprd07.prod.outlook.com (2603:10b6:510:4::16)
 by LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 19 Oct
 2023 10:27:51 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::a) by PH0PR07CA0101.outlook.office365.com
 (2603:10b6:510:4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 10:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 10:27:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:27:37 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:27:34 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 00/11] mlxsw: Move allocation of LAG table to the driver
Date: Thu, 19 Oct 2023 12:27:09 +0200
Message-ID: <cover.1697710282.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 0377b41a-9451-4d24-abc8-08dbd08e0bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X9ioCeH27lFfYtnR7FzeMMXETy6oMZxNYLpAyjEsbVdg9/aDEoq2XcXyEVtgITPzTUL9PgktvMFlBAuEi65dyRBGyjubwRc6bqL4lN4Y04LotiKEmADjYb9JolotM3yTFSjhrn21vgik3KBYDUs3KncGIJiNuHtSB1TDkd+jMimJsghqYZQa8Eo48caFIJ9TW6V+GwH9M5A/2YwgP/upko1Z4LyOGI9IocWIx7JmAsivFldNrMzVZ9P8NDyU6dCqQNrvSF3rpWSVuTTvf21Va3WohuLN/bGFow08mmOLhap/T6G5XSpibhhDIhWwLrF38r9bNnBs3LB+Dw7c8HqPxnaGngBS01zMtf4tc8cNeQgU4Llcgw1q9lB3x21P83HdlrWMMELuyxSfgwnvYlxN3MHMvMYZDXFvnbJpAkgN8aYPp2XJwE7uYwEr6SKnhBwrWVcU8U4TjJNWxv8OtdzGixA92GQ5ekfCAux1jQCM6ni2T/+wlPD1FvD8hWxFHhTxsYWmGwP8Dja78wH3ZG4dMqaXfTUhSoskQly24LLdatSimGQOSFrhUTOyA2MZ1KZdURPsdbl9tNWcxmkpsbTsYbSh9ONTGFTBTPb241oYoOVz409hZDho+WCh+43TntGUI8wR0B9HsZg/UQHfe0YnD1ojgDqiF3q38b2ODsOCLqhJHfbV/aWXBlIszB0Gptvuih+lf5EUKpMf6ZklSq+RYkeA5Gt4WcFohE/sJEruy9dA2P4WsNk+Jw1xAs4zlDtA
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(47076005)(2906002)(36860700001)(86362001)(36756003)(40480700001)(7636003)(82740400003)(356005)(70586007)(107886003)(110136005)(316002)(2616005)(70206006)(26005)(8936002)(426003)(41300700001)(7696005)(16526019)(54906003)(6666004)(478600001)(83380400001)(5660300002)(8676002)(336012)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:27:50.1974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0377b41a-9451-4d24-abc8-08dbd08e0bb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156

PGT is an in-HW table that maps addresses to sets of ports. Then when some
HW process needs a set of ports as an argument, instead of embedding the
actual set in the dynamic configuration, what gets configured is the
address referencing the set. The HW then works with the appropriate PGT
entry.

Within the PGT is placed a LAG table. That is a contiguous block of PGT
memory where each entry describes which ports are members of the
corresponding LAG port.

The PGT is split to two parts: one managed by the FW, and one managed by
the driver. Historically, the FW part included also the LAG table, referred
to as FW LAG mode. Giving the responsibility for placement of the LAG table
to the driver, referred to as SW LAG mode, makes the whole system more
flexible. The FW currently supports both FW and SW LAG modes. To shed
complexity, the FW should in the future only support SW LAG mode.

Hence this patchset, where support for placement of LAG is added to mlxsw.

There are FW versions out there that do not support SW LAG mode, and on
Spectrum-1 in particular, there is no plan to support it at all. mlxsw will
therefore have to support both modes of operation.

Another aspect is that at least on Spectrum-1, there are FW versions out
there that claim to support driver-placed LAG table, but then reject or
ignore configurations enabling the same. The driver thus has to have a say
in whether an attempt to configure SW LAG mode should even be done.

The feature is therefore expressed in terms of "does the driver prefer SW
LAG mode?", and "what LAG mode the PCI module managed to configure the FW
with". This is unlike current flood mode configuration, where the driver
can give a strict value, and that's what gets configured. But it gives a
chance to the driver to determine whether LAG mode should be enabled at
all.

The "does the driver prefer SW LAG mode?" bit is expressed as a boolean
lag_mode_prefer_sw. The reason for this is largely another feature that
will be introduced in a follow-up patchset: support for CFF flood mode. The
driver currently requires that the FW be configured with what is called
controlled flood mode. But on capable systems, CFF would be preferred. So
there are two values in flight: the preferred flood mode, and the fallback.
This could be expressed with an array of flood modes ordered by preference,
but that looks like an overkill in comparison. This flag/value model is
then reused for LAG mode as well, except the fallback value is absent and
implied to be FW, because there are no other values to choose from.

The patchset progresses as follows:

- Patches #1 to #5 adjust reg.h and cmd.h with new register fields,
  constants and remarks.

- Patches #6 and #7 add the ability to request SW LAG mode and to query the
  LAG mode that was actually negotiated. This is where the abovementioned
  lag_mode_prefer_sw flag is added.

- Patches #7 to #9 generalize PGT allocations to make it possible to
  allocate the LAG table, which is done in patch #10.

- In patch #11, toggle lag_mode_prefer_sw on Spectrum-2 and above, which
  makes the newly-added code live.

Petr Machata (11):
  mlxsw: reg: Drop SGCR.llb
  mlxsw: reg: Add SGCR.lag_lookup_pgt_base
  mlxsw: cmd: Fix omissions in CONFIG_PROFILE field names in comments
  mlxsw: cmd: Add CONFIG_PROFILE.{set_, }lag_mode
  mlxsw: cmd: Add QUERY_FW.lag_mode_support
  mlxsw: core, pci: Add plumbing related to LAG mode
  mlxsw: pci: Permit toggling LAG mode
  mlxsw: spectrum_fid: Allocate PGT for the whole FID family in one go
  mlxsw: spectrum_pgt: Generalize PGT allocation
  mlxsw: spectrum: Allocate LAG table when in SW LAG mode
  mlxsw: spectrum: Set SW LAG mode on Spectrum>1

 drivers/net/ethernet/mellanox/mlxsw/cmd.h     | 43 +++++++--
 drivers/net/ethernet/mellanox/mlxsw/core.c    |  7 ++
 drivers/net/ethernet/mellanox/mlxsw/core.h    |  4 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 28 +++++-
 drivers/net/ethernet/mellanox/mlxsw/reg.h     | 14 +--
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 95 ++++++++++++++++---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  3 +-
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 69 +++++++-------
 .../ethernet/mellanox/mlxsw/spectrum_pgt.c    | 20 +---
 9 files changed, 202 insertions(+), 81 deletions(-)

-- 
2.41.0


