Return-Path: <netdev+bounces-49334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B807F1C56
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C83B210CD
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699393067C;
	Mon, 20 Nov 2023 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jxa92r5i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9845792
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:27:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpfbvE9o3dCzmZnDAONya0Atj1Z6e1e5tueA0KpEh680SxLGR+sJ9N3FfQPkyHgsZSJUpseeaD2mAz80g9a0ZY8yp7G93qNCfJ0+QOTKunyBBsfWxqgRpTl1DE3IyOXLr3I8Ig5sFU3jakugxFs7LbixzaMY29KSbI1Zi6RsVNqKhv9bnXUB4YoWYEt7C47dv0+pukvOYivXf067CsJ+YjPhQZxOYgoaTlBTgT9WtXHuf1lv6iE2IAk37SeNll2mN2eLCP/HddICR/FoQuXrxcRx7ZOTiSeMccCenJtPKXQKCagqaig7AK+8PSQifLxosshoFxWDRxeC8fY1pLWPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBhohRwzrHPiuolHkJhlK8s7RfmIXE3GRDTupRG7RoA=;
 b=gJUPQJL3+Ee4KLmCbryCmNK69rKjgNalGPf9wltytAQtm/tsJ4GMapCPksEp33uYEs0/BTu44PII+x2S9Iw7y/eqvkMgWwtST6w93qggulwzfD4l8v12KVHUA2DOSW9jZis+NefbzQKs6ryj0qgOw986SYowYoGxwj///SHaFu2J3WX3MWz3aQEveDFDsuNKMQ1RxewacbEqgbQ4CWwE2ftlUY3U/r7/LWfSbjHuctEmetCwkxPJZC0/JD9fmRwWwEsSwXRMqMrzSSZTmERP1DspfTnSKNyMkMgIoIKpvxaOHC+w8WrElQQXGXEG21EVv0c0cGqjppRAk8B3JVEq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBhohRwzrHPiuolHkJhlK8s7RfmIXE3GRDTupRG7RoA=;
 b=Jxa92r5iZbjaRkowqu9CoE3mP6/HXugl+3TdSPnPcreFSb8vLKiN1gJUm3E1HjbOQFy2peDkcL3tXkqro8vkzylo+jAEsRJm3HgfNVFCTFgUlZvipT9hnMKn2Zrg7AfRG0mk+KYqlOfOvw8JXZZJjwEkuCBjTY7xlpJdQluf+19iHRSKU3bGNkkMH1dK9wRi4UhF2ElR2izxKuWuZk2/UUddSBeUThTMQ/Tyj6Z6E84qk0qNtS9p9B2xnylK/Xss5I/rlvpCyVTBi0XXtV1tmnMkriNZr3p13vU2WGupeopg1mCd8WT3CyioXpjlAYChzD10p7zLGYh7m4j1Wn7roA==
Received: from DM6PR06CA0034.namprd06.prod.outlook.com (2603:10b6:5:120::47)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 18:27:41 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:120:cafe::57) by DM6PR06CA0034.outlook.office365.com
 (2603:10b6:5:120::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 18:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:27:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:26 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:23 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 00/14] mlxsw: Preparations for support of CFF flood mode
Date: Mon, 20 Nov 2023 19:25:17 +0100
Message-ID: <cover.1700503643.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 06956be1-7ee2-48c7-c5f2-08dbe9f66187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VGUKd2HmFgf+zTRC4vLm/m0oC8NDahEpxM4BhpAPsiz0hULdme7jsRj0LCS8dEDGHjUjg354NU24mfIS+51O92Fev1KnNCt48iyMGsu2AQBnYqB6QDH9oYFoBFJV+LYQ0mcJm0Sx/Hs58fgNa5kexB2gXO8wQLoHUPE/PsHI0yZkdrH0uPn2QuDOs1CIKgoCbk2ZcfYD6l8g9vWoNWsF1npaTE6xRFn+fQd/WYduTY9UiKbqZdPWwxcg87s5Qf9zPSOX/H/NGEN9IhmmtkFmYRIinSgA3J4C+YniLrN0YamVfMrhCfBaDo01Uo8V3ryEDN9EJSEp2KWnXBSndqJZGaX4XxrZc6tKfOKPu37T7VGuDwysVfudbyhexHymtDbsQ4Y5TwkDasiUsB5PGkXTOl6gynt5lT2oJfhrdel9wFM2mUwDiGuN61eoSgdzPU9ibC+4/dTwJu3h3oMTCiF8I7PiGCNoMEG6ck17A99NU0Yh+D7rTaKIR459BozvcPDGYeEDZcbAlGZmbSCxpkRknNh8h1kaCrXE4sYzK0xk5JMoHk/n4cofV2TrQhLYjtVWBv8os7uvWf9KQQwUycVf13uGgqB4gfguVyhCl2DBsi99D7OXJMoYMsSppd4TGdVuNo2e1ys5jYEKluE0T5Xhwcf5c/Bb8hy2B0EQ9mn+lutqxfMUfdsy2KRNHUfWavxbkog/aSXcdWWabDV0T25JCC7z1hOFTe9SU+RvuRdNDsw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(16526019)(26005)(66574015)(336012)(83380400001)(107886003)(6666004)(2616005)(47076005)(478600001)(8676002)(5660300002)(41300700001)(4326008)(8936002)(2906002)(426003)(86362001)(316002)(110136005)(70206006)(70586007)(54906003)(36756003)(356005)(82740400003)(7636003)(36860700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:27:40.9009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06956be1-7ee2-48c7-c5f2-08dbe9f66187
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294

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
patchset, which is the first in series of two to add CFF flood mode support
to mlxsw.


There are FW versions out there that do not support CFF flood mode, and on
Spectrum-1 in particular, there is no plan to support it at all. mlxsw will
therefore have to support both controlled flood mode as well as CFF.

Another aspect is that at least on Spectrum-1, there are FW versions out
there that claim to support CFF flood mode, but then reject or ignore
configurations enabling the same. The driver thus has to have a say in
whether an attempt to configure CFF flood mode should even be made.

Much like with the LAG mode, the feature is therefore expressed in terms of
"does the driver prefer CFF flood mode?", and "what flood mode the PCI
module managed to configure the FW with". This gives to the driver a chance
to determine whether CFF flood mode configuration should be attempted.


In this patchset, we lay the ground with new definitions, registers and
their fields, and some minor code shaping. The next patchset will be more
focused on introducing necessary abstractions and implementation.

- Patches #1 and #2 add CFF-related items to the command interface.

- Patch #3 adds a new resource, for maximum number of flood profiles
  supported. (A flood profile is a mapping between traffic type and offset
  in the per-FID flood vector table.)

- Patches #4 to #8 adjust reg.h. The SFFP register is added, which is used
  for configuring the abovementioned traffic-type-to-offset mapping. The
  SFMR, register, which serves for FID configuration, is extended with
  fields specific to CFF mode. And other minor adjustments.

- Patches #9 and #10 add the plumbing for CFF mode: a way to request that
  CFF flood mode be configured, and a way to query the flood mode that was
  actually configured.

- Patch #11 removes dead code.

- Patches #12 and #13 add helpers that the next patchset will make use of.
  Patch #14 moves RIF setup ahead so that FID code can make use of it.

Petr Machata (14):
  mlxsw: cmd: Add cmd_mbox.query_fw.cff_support
  mlxsw: cmd: Add MLXSW_CMD_MBOX_CONFIG_PROFILE_FLOOD_MODE_CFF
  mlxsw: resources: Add max_cap_nve_flood_prf
  mlxsw: reg: Add Switch FID Flooding Profiles Register
  mlxsw: reg: Mark SFGC & some SFMR fields as reserved in CFF mode
  mlxsw: reg: Drop unnecessary writes from mlxsw_reg_sfmr_pack()
  mlxsw: reg: Extract flood-mode specific part of mlxsw_reg_sfmr_pack()
  mlxsw: reg: Add to SFMR register the fields related to CFF flood mode
  mlxsw: core, pci: Add plumbing related to CFF mode
  mlxsw: pci: Permit enabling CFF mode
  mlxsw: spectrum_fid: Drop unnecessary conditions
  mlxsw: spectrum_fid: Extract SFMR packing into a helper
  mlxsw: spectrum_router: Add a helper to get subport number from a RIF
  mlxsw: spectrum_router: Call RIF setup before obtaining FID

 drivers/net/ethernet/mellanox/mlxsw/cmd.h     | 11 +++
 drivers/net/ethernet/mellanox/mlxsw/core.c    |  7 ++
 drivers/net/ethernet/mellanox/mlxsw/core.h    |  9 +++
 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 27 ++++++-
 drivers/net/ethernet/mellanox/mlxsw/reg.h     | 78 +++++++++++++++++--
 .../net/ethernet/mellanox/mlxsw/resources.h   |  2 +
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 +
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 46 ++++++-----
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 20 ++++-
 9 files changed, 170 insertions(+), 32 deletions(-)

-- 
2.41.0


