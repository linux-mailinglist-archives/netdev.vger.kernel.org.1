Return-Path: <netdev+bounces-51735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CE17FBE81
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292EB28243A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F31E4B0;
	Tue, 28 Nov 2023 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hA3GszS/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D09D2
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnR7EggSx6AJH99dELtVpAkON/+onBwOIw6Nkaa5eefPrM6Y/SatKaFIj1wccK65ldxRQ6+H3GkTxYLnWsTyjCbtKQhDYladoxGvUIr82NY2Ps+dYG6hILiYbiHVAQ/lyn8rFtkFiulbY4he0Xj5V9JJDFMlqbu1ngsi3Y8ld6zZtlWxy386Z2uQhH0x0qsfAE0NbZYa0/dvRdOJub/Wwp3ZU5Mvb+rj22pC06cqgtX+b2QQjacavIzRHT1w4lGGdYnjXd/0o6E35AMowRo8mtdYC6kKGs7hj61jhB9yPf28vB1pZBMk4fm/JI4OH8Uuylk6LqUhgpEf519RZCvi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju0ubOBYLNK6gNrvzXLJTfz7R6d4L21GomCpThvgzeQ=;
 b=QsBWxTyoXzWh2AD53xVnFnRhLFz312G/0jsurHRnDVhAq5hfZRGSMvE3pdUY8pEIQtSRHhYa/rKrIyOMj7bDLyXLbta5Z2nFDxZA3m0bz2c+01FGFb10SWQQDm/iCYVCD9hvnKslQAnFW6wwgdCo5K0mXGUDHY3cYARqH28kP9gbqsiRCpvQjxdyENj+b/v+c3PN5Rq998Wm636WvTbZTXj3g2L2AG4VJrc5zPMA1nyhD951tGlqXzwjcb6s3/B5OYSJEAkQYCBPoERLKthdycki/y/PtxcDIIrBknSEc3PJLCN3Rv7AainUyCyDQhnfzbmgnPy66vi0fJo1Xz8ygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju0ubOBYLNK6gNrvzXLJTfz7R6d4L21GomCpThvgzeQ=;
 b=hA3GszS/OINv8leyh3kgP9x+NfobqxdEtUVOUdJpe56vi4Ssfn6FVW9ndcJhW8prBdLA3kit3+r2MKRfFCFgu4QeTUOIt/yBl966clhAOQb3YuKTMSQc/evDnRqkfWTMozZgYCfSPL4eetSLyW0YB9e48WufEm4+t5V0usFUGjAJrml+E6oYo4J9fuyAQCcuPREwNvAZYbFgVk/yf3medQJtVJPkLDGAPJCt+nx8OjGvWg8bTTkvP6wdChIFosKdFOcor8zPlQxct7Zm5dGzm/NM0tFN2lvWFpRQn3xGRSZOjtXsp0GOApCoKkZhBDzYut1ctAPoyBH+E+JvsLVHtA==
Received: from SJ0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:33a::12)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 15:51:21 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::52) by SJ0PR03CA0007.outlook.office365.com
 (2603:10b6:a03:33a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:07 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:05 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 00/17] mlxsw: Support CFF flood mode
Date: Tue, 28 Nov 2023 16:50:33 +0100
Message-ID: <cover.1701183891.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BN9PR12MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a6a45a-7a34-41ea-5232-08dbf029ddfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hjOw5CBGPQv9uqirT29y5/NQNmAZ8xfx/ZbjO4vf6St8dEeABq8LWmxpyDDxMONLux/0Xt1ZB4MigP89emUHKYN9VQQmAJmMlIEsA8k8JBPqALetrdffAOoANnyTKfLlJqNazGZNNDUY1hE9i7+4mec98+ZQYkyuwb6nzniAGbkzNgVf0bWFZWxOuucRTltNdnktmcSyZF9YHJC2jSjWAyV7YAc+YNJy/NmERIIu7ufJr/MPT5JzyV7jwIsR0UeWctItjOgdpNDCyJ3zn+pri+BB42TShaRHLkrkRpLa0Vo1aIwaT9sCgQzTk0CxaACuAigYGgalD/QfwSciEHMm9uO2NwOgxyNrddmOTavXShOyJox+Etn6iA08VhI/gnQHmgGqZ0oxlnUr7ms3NRoF6idi2xEk1IrMjRSqG2zciB3Vr10Pmi5sURjm9NFP8lu04CJuL6XWFBYxVlsic44vHCSqThhOLT8BE3HVeNhFqdGspToKROkGzWcmKwR/I0ZdqtoCaKtUtSJloIE6T1IZdP+FDzMZ3mYoL0bn3a8NpOKZT9waR6VIUoUUuwkF3f2wrkGXF8o9dw8rn0QCsIqC5Va7ssvdcAU83ldy9tfoAfKbjxA7chy0h8IDvMuRhhK+TUsJQddVvPbCjp3LTpfzlwYKgs62LEV/ElZ5NrvnWimM9blTJYVhPnQNGQWus7w3f5M7tJJEmde2dEf2xEVBJH6wiF7jZ6n7Z5P6W9+SXDGKh9Hr6bn53Urb1V4AAWY5
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(478600001)(40460700003)(36756003)(6666004)(86362001)(110136005)(54906003)(316002)(70206006)(70586007)(4326008)(8676002)(8936002)(2906002)(47076005)(356005)(7636003)(83380400001)(82740400003)(36860700001)(41300700001)(40480700001)(5660300002)(2616005)(66574015)(426003)(16526019)(336012)(26005)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:21.0745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a6a45a-7a34-41ea-5232-08dbf029ddfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244

The registers to configure to initialize a flood table differ between the
controlled and CFF flood modes. In therefore needs to be an op. Add it,
hook up the current init to the existing families, and invoke the op.

PGT is an in-HW table that maps addresses to sets of ports. Then when some
HW process needs a set of ports as an argument, instead of embedding the
actual set in the dynamic configuration, what gets configured is the
address referencing the set. The HW then works with the appropriate PGT
entry.

Among other allocations, the PGT currently contains two large blocks for
bridge flooding: one for 802.1q and one for 802.1d. Within each of these
blocks are three tables, for unknown-unicast, multicast and broadcast
flooding:

      . . . |    802.1q    |    802.1d    | . . .
            | UC | MC | BC | UC | MC | BC |
             \______ _____/ \_____ ______/
                    v             v
                   FID flood vectors

Thus each FID (which corresponds to an 802.1d bridge or one VLAN in an
802.1q bridge) uses three flood vectors spread across a fairly large region
of PGT.

This way of organizing the flood table (called "controlled") is not very
flexible. E.g. to decrease a bridge scale and store more IP MC vectors, one
would need to completely rewrite the bridge PGT blocks, or resort to hacks
such as storing individual MC flood vectors into unused part of the bridge
table.

In order to address these shortcomings, Spectrum-2 and above support what
is called CFF flood mode, for Compressed FID Flooding. In CFF flood mode,
each FID has a little table of its own, with three entries adjacent to each
other, one for unknown-UC, one for MC, one for BC. This allows for a much
more fine-grained approach to PGT management, where bits of it are
allocated on demand.

      . . . | FID | FID | FID | FID | FID | . . .
            |U|M|B|U|M|B|U|M|B|U|M|B|U|M|B|
             \_____________ _____________/
                           v
                   FID flood vectors

Besides the FID table organization, the CFF flood mode also impacts Router
Subport (RSP) table. This table contains flood vectors for rFIDs, which are
FIDs that reference front panel ports or LAGs. The RSP table contains two
entries per front panel port and LAG, one for unknown-UC traffic, and one
for everything else. Currently, the FW allocates and manages the table in
its own part of PGT. rFIDs are marked with flood_rsp bit and managed
specially. In CFF mode, rFIDs are managed as all other FIDs. The driver
therefore has to allocate and maintain the flood vectors. Like with bridge
FIDs, this is more work, but increases flexibility of the system.

The FW currently supports both the controlled and CFF flood modes. To shed
complexity, in the future it should only support CFF flood mode. Hence this
patchset, which adds CFF flood mode support to mlxsw.


Since mlxsw needs to maintain both the controlled mode as well as CFF mode
support, we will keep the layout as compatible as possible. The bridge
tables will stay in the same overall shape, just their inner organization
will change from flood mode -> FID to FID -> flood mode. Likewise will RSP
be kept as a contiguous block of PGT memory, as was the case when the FW
maintained it.

- The way FIDs get configured under the CFF flood mode differs from the
  currently used controlled mode. The simple approach of having several
  globally visible arrays for spectrum.c to statically choose from no
  longer works.

  Patch #1 thus privatizes all FID initialization and finalization logic,
  and exposes it as ops instead.

- Patch #2 renames the ops that are specific to the controlled mode, to
  make room in the namespace for the CFF variants.

  Patch #3 extracts a helper to compute flood table base out of
  mlxsw_sp_fid_flood_table_mid().

- The op fid_setup configured fid_offset, i.e. the number of this FID
  within its family. For rFIDs in CFF mode, to determine this number, the
  driver will need to do fallible queries.

  Thus in patch #4, make the FID setup operation fallible as well.

- Flood mode initialization routine differs between the controlled and CFF
  flood modes. The controlled mode needs to configure flood table layout,
  which the CFF mode does not need to do.

  In patch #5, move mlxsw_sp_fid_flood_table_init() up so that the
  following patch can make use of it.

  In patch #6, add an op to be invoked per table (if defined).

- The current way of determining PGT allocation size depends on the number
  of FIDs and number of flood tables. RFIDs however have PGT footprint
  depending not on number of FIDs, but on number of ports and LAGs, because
  which ports an rFID should flood to does not depend on the FID itself,
  but on the port or LAG that it references.

  Therefore in patch #7, add FID family ops for determining PGT allocation
  size.

- As elaborated above, layout of PGT will differ between controlled and CFF
  flood modes. In CFF mode, it will further differ between rFIDs and other
  FIDs (as described at previous patch). The way to pack the SFMR register
  to configure a FID will likewise differ from controlled to CFF.

  Thus in patches #8 and #9 add FID family ops to determine PGT base
  address for a FID and to pack SFMR.

- Patches #10 and #11 add more bits for RSP support. In patch #10, add a
  new traffic type enumerator, for non-UC traffic. This is a combination of
  BC and MC traffic, but the way that mlxsw maps these mnemonic names to
  actual traffic type configurations requires that we have a new name to
  describe this class of traffic.

  Patch #11 then adds hooks necessary for RSP table maintenance. As ports
  come and go, and join and leave LAGs, it is necessary to update flood
  vectors that the rFIDs use. These new hooks will make that possible.

- Patches #12, #13 and #14 introduce flood profiles. These have been
  implicit so far, but the way that CFF flood mode works with profile IDs
  requires that we make them explicit.

  Thus in patch #12, introduce flood profile objects as a set of flood
  tables that FID families then refer to. The FID code currently only
  uses a single flood profile.

  In patch #13, add a flood profile ID to flood profile objects.

  In patch #14, when in CFF mode, configure SFFP according to the existing
  flood profiles (or the one that exists as of that point).

- Patches #15 and #16 add code to implement, respectively, bridge FIDs and
  RSP FIDs in CFF mode.

- In patch #17, toggle flood_mode_prefer_cff on Spectrum-2 and above, which
  makes the newly-added code live.

Petr Machata (17):
  mlxsw: spectrum_fid: Privatize FID families
  mlxsw: spectrum_fid: Rename FID ops, families, arrays
  mlxsw: spectrum_fid: Split a helper out of
    mlxsw_sp_fid_flood_table_mid()
  mlxsw: spectrum_fid: Make mlxsw_sp_fid_ops.setup return an int
  mlxsw: spectrum_fid: Move mlxsw_sp_fid_flood_table_init() up
  mlxsw: spectrum_fid: Add an op for flood table initialization
  mlxsw: spectrum_fid: Add an op to get PGT allocation size
  mlxsw: spectrum_fid: Add an op to get PGT address of a FID
  mlxsw: spectrum_fid: Add an op for packing SFMR
  mlxsw: spectrum_fid: Add a not-UC packet type
  mlxsw: spectrum_fid: Add hooks for RSP table maintenance
  mlxsw: spectrum_fid: Add an object to keep flood profiles
  mlxsw: spectrum_fid: Add profile_id to flood profile
  mlxsw: spectrum_fid: Initialize flood profiles in CFF mode
  mlxsw: spectrum_fid: Add a family for bridge FIDs in CFF flood mode
  mlxsw: spectrum_fid: Add support for rFID family in CFF flood mode
  mlxsw: spectrum: Use CFF mode where available

 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  28 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  17 +-
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 792 +++++++++++++++---
 3 files changed, 727 insertions(+), 110 deletions(-)

-- 
2.41.0


