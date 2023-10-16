Return-Path: <netdev+bounces-41315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7127CA902
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D15B1C208B2
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD31C2772A;
	Mon, 16 Oct 2023 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NdPkxITK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D95DE541
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:13:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009B69B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKMzADvaz9iNYCip+OTg21FD/URtLswfD9iXxQ8bbltWW4G/XCqTE8xWxcQoGTzmTm92b3Loy0AS7clcZrVyP9llAXl3YeRR8X8ybhpCmus2YHZteOkBDKEJLuCCyUbsuGFlMtCAf/wTm28cN1JxkIGpblzqFjlGmhpQO1JDPp8Z4mK4EhBYMCBtukICUWlz3bj9sTXaFj5LouNR6CBIwTRG/3FfVQgbnMmqvMqLuCvEejINiqDhSJC3cKNa9dqHxvs+NaCWtvytBwJ9ZD0NZQvlMqnfL4HtaUc/1TZzLFzPeOtr2OfrrO0OIx4BMF3TLUVO4tHHzlaxD1WW4Qde5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HG6S/YlM6B7fuZkFixTgTYjJvq49oyFb/MCWinGwDBk=;
 b=bf9xtXvR+RDAltXmQFbyj9Iou2o7wLC+bt04eMjsj1KSX+1Qq6n9zkHMVzund2GTAn897ws+KuTDDYLabdszgVZqGw96/Fr3HZ/biDznguK2KqGZxplzL0Bf5S+mN5TcOxPx6uuK+PAR/SAWsfDVN2qiOtQtOZMAngIsVmgFbR4CEiL7mYsojolHhmp2Iv6ITlxUdu8qphIa5GMBEUHQIe/RNPcjruYVyZLmRUHjeZAHNHk7yL8zoaKLYKPws3LEuK01dMiTh/WfNgCxqvGe4vlIxVsdlGG+M8DB1o6pFVDwEDHR87LWoH2FTv6PCUlJYFebMMkbweHcNwPK8CVV+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG6S/YlM6B7fuZkFixTgTYjJvq49oyFb/MCWinGwDBk=;
 b=NdPkxITKt8NUWtUExG3b5oYT9ArpjhdBZSsL+Zp9jwZnRX2RkNmIrTGDs0uBOjCb5wdDZM7vcfd4dH658LmL7SOVWkMzND1Esl0rigizVEf/h3kixMtenQxwdQh3Nu4LBuK46lP/YT8ixdsAg0vFSgRssPSYGxuVsIW5JnZcSoodg07KMr6sOZQXfezrbAh0VibqThzNC6iw3kUY3vhn/bIhFgzGa52NrfTOsvDlg5hcadYX9bYBpl52RT9P4LDbuMlSUfNmFIuEPuBf8Ww8mQdX/7GEJquuOZ224Oxl9UT7dCtMWtJOIUvzfXEiizN2fWfId0mOEGlc0oN3TMk4Ug==
Received: from MW4PR04CA0363.namprd04.prod.outlook.com (2603:10b6:303:81::8)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 13:13:53 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::59) by MW4PR04CA0363.outlook.office365.com
 (2603:10b6:303:81::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Mon, 16 Oct 2023 13:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 13:13:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 06:13:34 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 06:13:31 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 00/13] Add MDB get support
Date: Mon, 16 Oct 2023 16:12:46 +0300
Message-ID: <20231016131259.3302298-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: f4afc674-5eed-42c7-c93c-08dbce49bea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5OjSFICk/6ofewewS19hN8ADB5JKryM5I8CRaisFIwbQgH9V5RvGEc9H0Xa5sTfnrKtt1d+giSLz1yekblMlAJS69sfyJXnkGO6ov9l22yU5xqZvNN6etAwJZbSdRtCQIgBBC7r6iFV5Igi4kzUU94zF0Hy+ig1Nnvrb+vOLbfBUIo3/fvDThrXEsxbCyXn+F1gA94TC9MoKabl1gCNTnYR76bGhAqanC1X3jiJ9EATVFowWHy/WLXfl+ZKxvqmvUulQRPZ45BMYMz8qmSACp0bEfxCdKNXyyg0SIxW4EF7Ggqi6qt8BOMTW2n79OECxulLS3WzW7GvArk5ggy1of7SYFVS6/AyepT19nZatHS3QvH7gW8mMfohy42QZDexOTKjk3/le/jOblVRssrjFjd+fpRMXeOhJtNYHXd+6ZtkMKuVkEGabO9/Vg0jnvLZlkt28bQD7COZDGD+1jF+7NwvRtQvZr607nkomo7JV/Aj7r6hE4Fpun3xpUnEdi3TYvRz4iTt9iwxMQ4Z+fh9TrM+P7TDlzP5sC1dkuWa3OO+jEm5WIsUd3+hIteXuc1iMKgyOGTKlZphxrf8jKmPZS9l8ouSHHV7/khLupZH1MhS6vsvBn5Rh7sSNT5NaqfLOsfG+0D/MVMsGV6UGxtUOsVgINOMo1HvXDIpQANfmiglG1O+OF5LV/7v29fHZ6Bqkyc4EPa8N/9vL7Wx/XtzeuHj6azQTGZmYkdCoe07tg795SwPxEssw96q5n1j0wwIedNtbk7U8PsKTVDAfnq3zc60fuuU56Ec060URiKzd504=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(5660300002)(40460700003)(6666004)(2906002)(1076003)(26005)(36756003)(107886003)(2616005)(426003)(336012)(83380400001)(16526019)(7636003)(82740400003)(356005)(86362001)(36860700001)(47076005)(966005)(41300700001)(316002)(54906003)(110136005)(70586007)(70206006)(8676002)(4326008)(8936002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:13:52.8030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4afc674-5eed-42c7-c93c-08dbce49bea6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 include/uapi/linux/if_bridge.h                |   8 +
 net/bridge/br_device.c                        |   3 +-
 net/bridge/br_input.c                         |   2 +-
 net/bridge/br_mdb.c                           | 180 ++++++++++++++++-
 net/bridge/br_multicast.c                     |   5 +-
 net/bridge/br_private.h                       |  19 +-
 net/core/rtnetlink.c                          |  89 ++++++++-
 .../selftests/net/forwarding/bridge_mdb.sh    | 184 +++++++----------
 tools/testing/selftests/net/test_vxlan_mdb.sh | 108 +++++-----
 13 files changed, 594 insertions(+), 199 deletions(-)

-- 
2.40.1


