Return-Path: <netdev+bounces-162601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BF2A274F3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8844F3A593D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84DA213E7E;
	Tue,  4 Feb 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cLFAtc3z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF22139D2
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681015; cv=fail; b=ucon9G7Rx60FYk3pnzwMhD3Zm4C/K21yKjmLuDteTPvTl9S4bl8+MsRb2bQ13Lrg7gb5PhPEAFCmDznUkLWtMeTIt6eMe0764vOr8Gkt1dwSIdPwHvzN9Ivkpg4U5pxux8YpW7vzhnMx5lIen0iqZ8JCwlRGDeQHzGYFVjoraxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681015; c=relaxed/simple;
	bh=B7pyZN+2NdAbKJfk4k2h13ovnUnHbn5aazVh+WQ38YU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHqM7RSC4aijVj62J0YeqywxqJHn37JC3DAX/w7Pl1LBcqk8W0qp058RKOalgHQ0bF6cW+eiJf+K8NgUt56TQbdiUMvgPS+Kubjm9ASoeAEJEGPdN9AzbvzRA1zRZtRGiDv3cdGoM/z2m6aOtXkNToJ3rZRt5nkDaAILBavZ+Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cLFAtc3z; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNpGoosfVPAFWSi+3ljlLWfishWYzIgt/oqxgGBnaaNSk0HYmPmKMLyyrRWsgd+1Vt6uxCkXXpI4K4bRyUHPfm6Fb8kv7kH1wnOpPzt8uTw0ClQP1eGZmQlF4AytlOnt0ATU4HnuZvSTK4g2ayq4T3ZzdB5M0X4kdeBhdO/g/wtq9KTRcPAzp3Z53ZYhB5lJfPivg5fLhK8pQ/zy6dcS/5w3k6Se7iht1hLYv5qDH0JjpUzX8tR0BgN8KAniercS4mOfscyYHASX8nBo7Cp8wiV0eYswZSevp+dPMVBsrYww7KZFmuQDrI4ePDyA2BnNzcTuTm5EcQsHUUm1bPwV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSB3ZX44RGhqE/G9JiWsty2dXW7IPzeITP0SRRnK16g=;
 b=a1UZMQTrZs8E9JDNpDXy8V4UMt5fjqCSvCsMCMWFOUoRU/YGCh+TlpiCefFgfXJ0fUySkgUDpx+AQLu5262Zn4bCqQKD66pyWtoNzMIE1CI8wqUDRUkN7+xK7YGvaLd9QgE37jRpGJhsvRMK9k/nSuWHtJALxNrCjc+JlB7gqNAgHb2k87S4dgR40V9QA0f08nAAer2uEowYvg6M3XuaZDsfiGNmEzWL05v/H34Z7ZzUXoldvxSWXDckD+GDcvQQCf9wCqZhcGyBBsT6s4tPpO9r+ttF5/spUSaTbQo/UVRFPQpQ151RC6dH+hJoeWzvE4GIJ4pt2zUm4+bMT7oduA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSB3ZX44RGhqE/G9JiWsty2dXW7IPzeITP0SRRnK16g=;
 b=cLFAtc3zSO1WQJOXIqlxrVXUih7h5wolsn5ft5zEItMrvZ9h632f4boD8Mi06bye8K/2Ar28+KUlASvpVt5SX0n/MKiHWlYzjDfem7ovgyHgZVFn2ApR+C2EoqNPjA9aht1obrLAWEflzXbP2Qhla/LJpLfHSyv9BNgAVXBDNYFGVuvekMZRXq3ZwzjxY7/sgSj5kBZntutlbrFWxGMOFWCozwQyudpJXUAvD1r+/oiSY8nMkufenc1yXb994dbe/IbfskTCZGuIBRQa3xjHxRFhB0IxSN3zAM0V6K84W3+pRYQQmkOruOUvvjEhgSamkhODprPb35Rcr553Gdzy8g==
Received: from DS7PR05CA0009.namprd05.prod.outlook.com (2603:10b6:5:3b9::14)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Tue, 4 Feb
 2025 14:56:49 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::40) by DS7PR05CA0009.outlook.office365.com
 (2603:10b6:5:3b9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 14:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 14:56:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 06:56:27 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 06:56:23 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/8] vxlan: Refresh FDB 'updated' time upon 'NTF_USE'
Date: Tue, 4 Feb 2025 16:55:45 +0200
Message-ID: <20250204145549.1216254-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204145549.1216254-1-idosch@nvidia.com>
References: <20250204145549.1216254-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 19589a1d-684f-4714-318a-08dd452c270d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eTEtGIG5L14YKvyixCj4bM3VYnnIyoQitnr/7yiQ+TRxqaN4ykAn+W3tVANy?=
 =?us-ascii?Q?AuLB2U39heXHac3pvOpjT/61ZPfWEi/myeSFplIZyaUjnqv/Qab6PqHSk/5+?=
 =?us-ascii?Q?oQwYz83MKj4Uv7YsfsakJG4IMRZXidkoSo0EAf6DVu18Ea5ilwXDPPon9lMu?=
 =?us-ascii?Q?uHsxv6ad2aXFt4HG82iC9/TOhsfd71KstoFINIVVjpoMZbcWQi72oeGVYNX/?=
 =?us-ascii?Q?4XvYRYWuUykhYDQD9p4ThzhSuSdeA0+TtZZ+PzBy9moyQFYLXZ96QGAEezxa?=
 =?us-ascii?Q?D1bMMXdDW23mJcgviuEZQPWBZ6+Tuw7cO5kr+dFYbdhtjcJmWylq5d9JS40U?=
 =?us-ascii?Q?Kc2youaneWYmxzKeJWWQD0ewgvSHIPNS22vc5ByT74YqqaIx/yZfJE8RpPwe?=
 =?us-ascii?Q?RD4ElXCFn3nNBEp1ySvg2WroqcEP6wRXyYEP0Sk37r8nknhChMFD1W0td2bo?=
 =?us-ascii?Q?SMbd+cGJLV4AbmRNyjQRr/Ezn+1flfE3pQPgnZVbfzX26vTivUdqyElGVoWr?=
 =?us-ascii?Q?OyCG1TooOSB8dGaAOjYUerv3cGvigCyW6i4Bq0LpEmdNR/HDkN9NwNxAHrfZ?=
 =?us-ascii?Q?sWnzq3YjDR26D6jVOoZHTlosf9fUs9nDO9rkfU1ZcPWGocB+f7z+veUO0XWS?=
 =?us-ascii?Q?kSlx+4kkBLTSF9x+Hldd8mT8UZPxwktNiu2LQaxCb5Lrtk8NhVhlBGAeWws1?=
 =?us-ascii?Q?s0aQ22BLh6RsOKHOSO1NnElH3iPnFDurEVTS88jhHAe+3JPqosla5GUzLi3T?=
 =?us-ascii?Q?5PctFpf/Dvja9lm8eWrLQaLGL29BvS3+8JqnAsEShhXbIYGWP9zK+MvZLeTX?=
 =?us-ascii?Q?ALgahiLuP6HiSE7+/f31D6Mb5uIL0mDS8p6ZqmX4AsXLC59v2fvx3tlZ9ilB?=
 =?us-ascii?Q?K31mVTMXmu/1C3A0SqYKeDWcpOuHvn8twcJhiNpDZUR3azLNUP7+lDZJgvEN?=
 =?us-ascii?Q?XdEUaU2YGCsFHK0KxM91AlvAQ7ecGDRZ31KyaaWxCN/KvSAzBDzt2SG8v24k?=
 =?us-ascii?Q?/oZIJh+UDqK+SN5ans2pn6VPs9ZA7QuclpKljPLt36oRf5s7L2+0YAUUvapk?=
 =?us-ascii?Q?1gM0OejrzfyhGe9FkLd7WLdsk4hzwFpCLqcfuNlvrc3i2vGFX2NGcdt4CFXM?=
 =?us-ascii?Q?9iAzV1CBokN/LqqF2jltisgoNb+4iEOxIA/YXoJC35cUu7hWkx3BfTOzWcyh?=
 =?us-ascii?Q?uS0Q00OhJLVqjCMTmH4BhAGmn9Jgy6Two+6wC+UtI2H2WnbfG3SJgBF7SRVa?=
 =?us-ascii?Q?Hp30tjvA01YzwcwzdBfm2CBRPALDXuzGVklP/130TAdlKaUZL9LtArQhDuua?=
 =?us-ascii?Q?87YASiWowUFGd1izp/L6NpV4F/pPC5B0spT/VFQFWbrbo4sI0grC5hrDiPC+?=
 =?us-ascii?Q?AIjAKy54e3wGblnrsCsr0n3pl/s0G3XFWf9soAd3Eh8+N1K4wRGZanz1wtbu?=
 =?us-ascii?Q?5MB+beD2iGOxGzCn6iXKkBRbxm86aoop5/9PkObHJIkMkBzrtM/kog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 14:56:49.1438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19589a1d-684f-4714-318a-08dd452c270d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026

The 'NTF_USE' flag can be used by user space to refresh FDB entries so
that they will not age out. Currently, the VXLAN driver implements it by
refreshing the 'used' field in the FDB entry as this is the field
according to which FDB entries are aged out.

Subsequent patches will switch the VXLAN driver to age out entries based
on the 'updated' field. Prepare for this change by refreshing the
'updated' field upon 'NTF_USE'. This is consistent with the bridge
driver's FDB:

 # ip link add name br1 up type bridge
 # ip link add name swp1 master br1 up type dummy
 # bridge fdb add 00:11:22:33:44:55 dev swp1 master dynamic vlan 1
 # sleep 10
 # bridge fdb replace 00:11:22:33:44:55 dev swp1 master dynamic vlan 1
 # bridge -s -j fdb get 00:11:22:33:44:55 br br1 vlan 1 | jq '.[]["updated"]'
 10
 # sleep 10
 # bridge fdb replace 00:11:22:33:44:55 dev swp1 master use dynamic vlan 1
 # bridge -s -j fdb get 00:11:22:33:44:55 br br1 vlan 1 | jq '.[]["updated"]'
 0

Before:

 # ip link add name vx1 up type vxlan id 10010 dstport 4789
 # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
 # sleep 10
 # bridge fdb replace 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
 # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
 10
 # sleep 10
 # bridge fdb replace 00:11:22:33:44:55 dev vx1 self use dynamic dst 198.51.100.1
 # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
 20

After:

 # ip link add name vx1 up type vxlan id 10010 dstport 4789
 # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
 # sleep 10
 # bridge fdb replace 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
 # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
 10
 # sleep 10
 # bridge fdb replace 00:11:22:33:44:55 dev vx1 self use dynamic dst 198.51.100.1
 # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
 0

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 36cb06a56aca..c73138647110 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1051,8 +1051,10 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		notify |= rc;
 	}
 
-	if (ndm_flags & NTF_USE)
+	if (ndm_flags & NTF_USE) {
 		WRITE_ONCE(f->used, jiffies);
+		WRITE_ONCE(f->updated, jiffies);
+	}
 
 	if (notify) {
 		if (rd == NULL)
-- 
2.48.1


