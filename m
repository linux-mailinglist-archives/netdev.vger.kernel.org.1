Return-Path: <netdev+bounces-58325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E481815E2C
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 09:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB7AB21787
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F1B1C20;
	Sun, 17 Dec 2023 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XlnOFSgA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF21FBB
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY8a4sQ+s6vZ1yhsJjCWQA7KX1QA+W0ls0kcFJAG5WY0zUYy6dxqdYaJ7Ej4T6Hw32LVHd86oU3b6ey42GgsAt8fQb0dYm44sFYmUBfUt2Q4yFxdtwkdhZ8col7PRnPiF9IHcujdLyYDS+VC+2fCWSXts9ZTlv2ILtyu39uvZGjsHWk56cPnQVp27seY7CKX9YvugxX8JB4hrkUk2vctSVlL8sjzvoQ2B8zYjrtNX+X3oFvbrbyoQjutyBaY2icZ/cENqgYguhJ3pT68pfef42FBcEmHnGk1ljO5zthDDN7L/Ld8dcjSjfojUjuGCfSSpBfSGbXONFNqxiOUv2Z4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAhH2crXMB986PhnDKSMftnuRp09mnSaX9pmG+RZHpk=;
 b=PACANXKbZKfZHiX5oZe1asViZ6Dskbm7FMBqZjPDK/cEvAch6kFXRlHu7jlFCId8ypgPY3GMq2uqwDCboyukmsV3trheW0ldzxIW13SycF9eLWeezSi0SAbn2qVn1KElXR5sRtrx1U0o8riftrhNnzJE4/OXQxCu1Q0DH98JNk2DVDotUIJHTrUJUFnNQuS+VMdsCZeWQKe+l97w/HYZfTyQuR+Z/3wOuMz2JMULfSIii79hdiHmL9wb3FfetDOEuB6X4yHI3vw4fWHHaBxMrLZ24oKVkvsMFoN+S91ZxUk4U6FS48k2BkcXkfto1VYCJs/yQh+Chzdhkvk7Yezgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAhH2crXMB986PhnDKSMftnuRp09mnSaX9pmG+RZHpk=;
 b=XlnOFSgAKBFsB/TPDJPVv/v555xGBQgqJlejmV01r0JDrNVlzj2My0jXYMq5rzsPc+5qtzMxnhb1JHqQ6hintItLmRJh+4Lcdwxo4UTfcff9ieYCIqRyx6CA1NOCnUVDBoC3MdMcRKMb1rb3HBk+o9+9Qh1MXYYJYKu1so769zwxaYawOa5ri/YVDqgXd5ZZ6MLQROhFbJTlddXVy/uDYWJ9G8l+QD+IeQ7mE4Cnofsw9eBFRYHRHfVqNxgHTZ96vJzSvyCMGARIXMsWfhrW7wB62A/g8W09xH7YXvNBi/gqp4QmtpZNWdpU4ZWKukobpVntVTlwPwHWAd8iJm5dzA==
Received: from MN2PR17CA0029.namprd17.prod.outlook.com (2603:10b6:208:15e::42)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 08:33:32 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::7c) by MN2PR17CA0029.outlook.office365.com
 (2603:10b6:208:15e::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36 via Frontend
 Transport; Sun, 17 Dec 2023 08:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 08:33:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 17 Dec
 2023 00:33:18 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 17 Dec 2023 00:33:15 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/9] Add MDB bulk deletion support
Date: Sun, 17 Dec 2023 10:32:35 +0200
Message-ID: <20231217083244.4076193-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2ab15b-ad57-4dd4-481e-08dbfedada97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UujYOhCQ195anodfX2qOQJcXZagpudrJdMIWlWUCHzJZCG+YHSEhyMbuBwgIi+ufnZfRj4fZ8iaNoazL9Jwg6cRwNzYZKSnOdeMGSVowabeQG1hyNiGwUC7j9OkD3ILKHaSPFUtOkpPuQ5PYoksiCVAEvzHDJjXOLHL8wQaNIbSwYNISoTvLkyiQD4j6XsCWqOaZudKiOOeNbiKACPGidZ4uOhHQNLBk331zosfRBa7Q4JoOq6wmx8sy2Sf5B+Q1VaSTFCDNPl0sB7hixOkidST/H/KF7/dipNm9xB4NuH6I6Yb9nuNCgVWOGC8GXhsEfGHGR0nnr37ddzSMglKKiyoP2Vt/8yaR1hH64jhmPN1wTm95+YEGS5dLBxtfFfxfyTqhyBlPvsuzgUvewAgsAvUXCYTKAIobaYPUsUZnO1CQWDFrF/V9T9dFdOR4xZzXh4lAwzxOQp388yp9H8l9coIhQsQ4MbplUXdWj+CgrT0lyCaHDuLOyygI20GQKz4pzfX2A2ld3DDrkJPSCcTzLKK05QvrTaOhxrmUweI/ENwnuh86k2SovCOkfcPyepsfQg0fGW80DBa3j32oFop0Fp9KpFGKsKpcZdXiHg+/mUslgkI/aL3KcnDtvNKua2nO1BqyB5mYocgpAQEaHTqgzUnocx42ktSiNyAdyjyLh6azP3t6MA8ikJosfvCWIT9z49Ymax9qr/pXqMRDWLkXdiJ2OOPhsRKUCNF67hNiDsHK2nbK/2zkToTClXZkh/L7OkdjsCXIH5VDU361Rsi2qus6RO2fngQhnhsvRcRLO4E=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(336012)(83380400001)(26005)(16526019)(426003)(1076003)(2616005)(107886003)(36860700001)(47076005)(5660300002)(4326008)(41300700001)(2906002)(966005)(6666004)(478600001)(110136005)(316002)(54906003)(8936002)(8676002)(70206006)(70586007)(36756003)(86362001)(82740400003)(7636003)(356005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 08:33:32.4855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2ab15b-ad57-4dd4-481e-08dbfedada97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

This patchset adds MDB bulk deletion support, allowing user space to
request the deletion of matching entries instead of dumping the entire
MDB and issuing a separate deletion request for each matching entry.
Support is added in both the bridge and VXLAN drivers in a similar
fashion to the existing FDB bulk deletion support.

The parameters according to which bulk deletion can be performed are
similar to the FDB ones, namely: Destination port, VLAN ID, state (e.g.,
"permanent"), routing protocol, source / destination VNI, destination IP
and UDP port. Flushing based on flags (e.g., "offload", "fast_leave",
"added_by_star_ex", "blocked") is not currently supported, but can be
added in the future, if a use case arises.

Patch #1 adds a new uAPI attribute to allow specifying the state mask
according to which bulk deletion will be performed, if any.

Patch #2 adds a new policy according to which bulk deletion requests
(with 'NLM_F_BULK' flag set) will be parsed.

Patches #3-#4 add a new NDO for MDB bulk deletion and invoke it from the
rtnetlink code when a bulk deletion request is made.

Patches #5-#6 implement the MDB bulk deletion NDO in the bridge and
VXLAN drivers, respectively.

Patch #7 allows user space to issue MDB bulk deletion requests by no
longer rejecting the 'NLM_F_BULK' flag when it is set in 'RTM_DELMDB'
requests.

Patches #8-#9 add selftests for both drivers, for both good and bad
flows.

iproute2 changes can be found here [1].

https://github.com/idosch/iproute2/tree/submit/mdb_flush_v1

Ido Schimmel (9):
  bridge: add MDB state mask uAPI attribute
  rtnetlink: bridge: Use a different policy for MDB bulk delete
  net: Add MDB bulk deletion device operation
  rtnetlink: bridge: Invoke MDB bulk deletion when needed
  bridge: mdb: Add MDB bulk deletion support
  vxlan: mdb: Add MDB bulk deletion support
  rtnetlink: bridge: Enable MDB bulk deletion
  selftests: bridge_mdb: Add MDB bulk deletion test
  selftests: vxlan_mdb: Add MDB bulk deletion test

 drivers/net/vxlan/vxlan_core.c                |   1 +
 drivers/net/vxlan/vxlan_mdb.c                 | 174 ++++++++++++---
 drivers/net/vxlan/vxlan_private.h             |   2 +
 include/linux/netdevice.h                     |   6 +
 include/uapi/linux/if_bridge.h                |   1 +
 net/bridge/br_device.c                        |   1 +
 net/bridge/br_mdb.c                           | 133 ++++++++++++
 net/bridge/br_private.h                       |   8 +
 net/core/rtnetlink.c                          |  62 +++++-
 .../selftests/net/forwarding/bridge_mdb.sh    | 191 ++++++++++++++++-
 tools/testing/selftests/net/test_vxlan_mdb.sh | 201 +++++++++++++++++-
 11 files changed, 749 insertions(+), 31 deletions(-)

-- 
2.40.1


