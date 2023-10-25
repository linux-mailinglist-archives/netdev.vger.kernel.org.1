Return-Path: <netdev+bounces-44159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C1A7D6B91
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1D61C20C84
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87D821351;
	Wed, 25 Oct 2023 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e8DrkNgS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C327EF1
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:31:13 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A9CC
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AigWstFHjCJQHDYnbV/f7RhFgY5Vb+UtTWfCVvNbubgDk5R8Z2D8Oh6OFKZj2IgYqEPeSXRUFTXMpTzIit/6zmGYoMTMlGK/cXO63yPB9YjkZRNJ169cRV6FNpKHWVczSccHwXU1W0ty3XFB2ThI0JoebeHJCAw+4IF4nwAjfVwxw35iJIpHglcN6JAdTcyIJwfsdwbJq/v4EH7iM/d9d3RQPCE94PIW+LMER65XmHYSsFMw8krJ8OSBT1jetghcmQdGU8fIKDAIXIyE8b2w6rIq4aY7abgllFom0xdCiyB69bsxKFWqq4AYdJGA2N88ggg8DtlaCHCNLgUg6zCBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TadKRB8UEYv9tZCxLyvhTgb1bm5Lzot5MqKfQkgfIuk=;
 b=Fh7DDQk3dKu4CQS7en9kNCwhd/SsGdSGjMyudceykSE/7nz7Y05TzbHN9eciZR5HwpjMfboT0tLv1IYdGZvy7ORCB89rX7ij/Rr8aoMY73Lkd+Dnv5geVo8yoz3mF3Pct6ZVM9BhF5vqhA7FaPRQL3qY8lwiNyco0Oq2VnnXQ8LUJ1UAQZ8ekfyPjr8tFn61jb7xkKA2QVmJs3kws9TYKCr5W9uthNYrkfvOl62kK+DaM1fHLRjFVmtT+phDoK50P8bO1OOHnQMGpNYYZebazxvCqLL3PfxZrUf7/6uDyGYxbgpwy3phq9Z9T8/E3wdTyv7jk3zshHHutJiL4tdRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TadKRB8UEYv9tZCxLyvhTgb1bm5Lzot5MqKfQkgfIuk=;
 b=e8DrkNgSuMeR69NZ3STuJhEi9cWQCXs6Xi1CEZWSROfF3NPd3TDgStPZO6h916kICk46dyXWp57XGWopaPUz0Db1bvaMUf7HiEcs43wcBNUknQvipmzdLcTHQM9OenHUmHClf7cTI9GUiJdHcI8zr7oTzWD6Le2L8CC1dprzY+HxydDRXKL7vpDvI9ivVqBSl+dQOKutIwe6lENPB3so9Wn6o4e6XPuO7qoLwWrrfDwtXOxoJLMu6HcgVMsKyhbTi3gCwTu6eyC5ALM3UOP7lvLdVE/7CYMDBn14pqsqwCziADZfqh1XdFiRN3kLI9HWpQQheDy3UnrybEflUep4EQ==
Received: from CH0PR07CA0027.namprd07.prod.outlook.com (2603:10b6:610:32::32)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 12:31:10 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::7a) by CH0PR07CA0027.outlook.office365.com
 (2603:10b6:610:32::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:31:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:30:55 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:30:52 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 00/13] Add MDB get support
Date: Wed, 25 Oct 2023 15:30:07 +0300
Message-ID: <20231025123020.788710-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: b744a73f-40cc-407c-32d5-08dbd55644d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vOEDX+e/2m68q/7mvXAfOQO7ZMz3CU1DFp/oc7OG3bvgvJc9QE3ceD3WuSb5SvTwe7YR9PmrPdQXwip/Iv6CO9sFvYIiGfNLltI0zWGesMna3bFyOggfHjcez6j2KpOjLniPxOIpqP8LGKeqNBaKPgu6FFpv/hnTbklINVNRwacHFaHJadutrxO8aVl+B397nzd45CYaVCn6KeUg8Z+foyi5jnTP6TCWB1uuiYJwX12MVMF9TwAHHm0jtH/ULpGb+8MmbdYGdqor+IN66GO2EaCq8rEqDQesUo14kX3WfrMWYk4jqdq6oTDNnxp4tIoii+UXOFUJ6HCVaswHXNZu+yjPVmyh/hr7B+Rg6EVS4b6eP2xnpupH32V2ekuKzbvM8FBhbTvdbFlkuwifENNiUxP6VTX9tE2Pm3cVZctt/C8ygroZt7vPa1sEcxiYhr+1EkTSwdtapQhyxNkrCZt52xZyk+o2lnQg6/pj1VRdYROj/Blx9utb/2KPGeKBOWOuwRhnbihuvEwDyXC/tUJw8iqHxA+zh1C0p4RQkbp4aTaBj0EBzUPhEo40tzEwb5qfuuMHUDR7okKeLeU9K7LaGM2jEnjCwlvEDx7H7WIiQXXdjEkutHcOY/dcLPJOQyPvjr5wxTFcns4rxekVGyI+mnJ9+1isAlEgYqBc/i9zmlBs6nVJewYwac+94SvveokBXsmgoWMGEhX16WcSy3PY8hQJ5jqtWGp5pSLxCog44207+hOPCksLuPrIpR1P7YJ9Dx+StZjRxiNufNowQKugaZE/MR/6QzUtqeNwj1yBHGg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(86362001)(47076005)(2906002)(966005)(5660300002)(8936002)(8676002)(36756003)(4326008)(41300700001)(36860700001)(83380400001)(40460700003)(356005)(336012)(7636003)(110136005)(70586007)(316002)(70206006)(54906003)(107886003)(1076003)(40480700001)(2616005)(426003)(82740400003)(26005)(16526019)(478600001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:10.0090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b744a73f-40cc-407c-32d5-08dbd55644d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270

This patchset adds MDB get support, allowing user space to request a
single MDB entry to be retrieved instead of dumping the entire MDB.
Support is added in both the bridge and VXLAN drivers.

Patches #1-#6 are small preparations in both drivers.

Patches #7-#8 add the required uAPI attributes for the new functionality
and the MDB get net device operation (NDO), respectively.

Patches #9-#10 implement the MDB get NDO in both drivers.

Patch #11 registers a handler for RTM_GETMDB messages in rtnetlink core.
The handler derives the net device from the ifindex specified in the
ancillary header and invokes its MDB get NDO.

Patches #12-#13 add selftests by converting tests that use MDB dump with
grep to the new MDB get functionality.

iproute2 changes can be found here [1].

v2:
* Patch #7: Add a comment to describe attributes structure.
* Patch #9: Add a comment above spin_lock_bh().

[1] https://github.com/idosch/iproute2/tree/submit/mdb_get_v1

Ido Schimmel (13):
  bridge: mcast: Dump MDB entries even when snooping is disabled
  bridge: mcast: Account for missing attributes
  bridge: mcast: Factor out a helper for PG entry size calculation
  bridge: mcast: Rename MDB entry get function
  vxlan: mdb: Adjust function arguments
  vxlan: mdb: Factor out a helper for remote entry size calculation
  bridge: add MDB get uAPI attributes
  net: Add MDB get device operation
  bridge: mcast: Add MDB get support
  vxlan: mdb: Add MDB get support
  rtnetlink: Add MDB get support
  selftests: bridge_mdb: Use MDB get instead of dump
  selftests: vxlan_mdb: Use MDB get instead of dump

 drivers/net/vxlan/vxlan_core.c                |   1 +
 drivers/net/vxlan/vxlan_mdb.c                 | 188 ++++++++++++++++--
 drivers/net/vxlan/vxlan_private.h             |   2 +
 include/linux/netdevice.h                     |   4 +
 include/uapi/linux/if_bridge.h                |  18 ++
 net/bridge/br_device.c                        |   3 +-
 net/bridge/br_input.c                         |   2 +-
 net/bridge/br_mdb.c                           | 184 ++++++++++++++++-
 net/bridge/br_multicast.c                     |   5 +-
 net/bridge/br_private.h                       |  19 +-
 net/core/rtnetlink.c                          |  89 ++++++++-
 .../selftests/net/forwarding/bridge_mdb.sh    | 184 +++++++----------
 tools/testing/selftests/net/test_vxlan_mdb.sh | 108 +++++-----
 13 files changed, 608 insertions(+), 199 deletions(-)

-- 
2.40.1


