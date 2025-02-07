Return-Path: <netdev+bounces-164112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6619CA2CA3C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC343A1D7C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEE8194AD1;
	Fri,  7 Feb 2025 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NxcP/sma"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FFC1922E0
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949710; cv=fail; b=WDhvTYhtiK8nxxRYcg2te+AdmX2ZEAh1jSkucQczYS5GqbLuF9krDbzXYJiytVc+ND6CJHAzn1oMSx8YjCRXbthxKeb0OYO4pymUvKwXgAjPNS78F2GnHRqAyxpNhGT1m7AHbECsNsE/JZUWovi+h20smNpty12AVNCS2mWTElo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949710; c=relaxed/simple;
	bh=G5tcKb9GzXpj/nCBHGVUsM5K4ABvpr/d1gUlLBmRF6A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UBgXBXCRbjrfiIo40RIbT9Hjd0nO8+Z3Gn33uK9Aig9DHouSfRvBBJixr+ewgp2RvOsfrDADkWJiTHIAuoIUcy0IqjPDVV9+mVCpNwDV8KUItNS+R0FTBp9aTd7/S8prn4BNOuw3Xre5BFnifRB7uR6rrwjUkO660ZtgL3EWZ6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NxcP/sma; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mxe9rqoRyX+N6Qcs8oG1qqmjUHMh/BVOAVM36bQ7VzEslonoAbz+zh2OLpFU1QPMzC/OSJcnFHXHbZlpD8YedSr6XzXzcUVTWKOBhm8VKlT1WTWeNv2M5U88G197uQroMSl2eW7zX+MyHgZhjjm4hOACbobD9vOlfxdHRTWxxlkHbQqSDTQUfmRpKGFcIlv3D9M6LgAm8aJrjDe7L43ObpNuq4EZpnFbhTj2Vi2UnA5NqXElpJR+Zr+tyHlHZs5AOKBhYzul/n+HuVAA3pSBFOLianXf55GNNrn1HoJT1sTkpmWC5Qm4Ru0v6N/S1wMdAuhF1Mkc1tkAlQpbwO8Qrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z6T9Qcv9pmtf9rW6q1ib+hhrxLY/zyr4FRFSwLZoMM=;
 b=bQHkK6aumr2xHatkXdtAVaOs0Vn9H141Fj/j3dTawIK3tc1Pbcra7oZR+D9q3nFBJ7HRdkogSitrDVO4xiIodjHPJ8zFehAX5EpLZ1DvQD2Bx1usU/lgXgoOc7M5EIIzpTmwcEzCW26YB9iZb3fxyCT9+YtGMlXj5Df2TbVBQzBJJkrl9IhwXGjnwZmsZeF9ZlelhImVVRLu9ZmTBdNHo3Hf6jYvcIcHGqxeXjmzn1TdpKcqgD91t44C1nMnWfs41X87+x1QbhyuYUpN/+XsZ9F87/iawzjPTQvB8dB8aGYrLju6ptUQbRkEYzEmvpaZmzsd5HZegQenrCg5d9SV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z6T9Qcv9pmtf9rW6q1ib+hhrxLY/zyr4FRFSwLZoMM=;
 b=NxcP/sma++eJ41QHxs25+mJC/aMSy5cxGM2VyNRJtFtG0S9Ph6Z5tcasL9GkiOwIgH+HLT8vW5rUm20TcHGDaPIL2ooOdLiuH1pz69CcjdB/jKsZdLVYdjE+zUlk3l3xU8dRqaHtWfp152X2CSQo4YxHJ+qr/iYO8knrBRsvOxCHG1R0bauf+Y4mN20gohUcwt/Kmo2tjzvcFs6UkRvyQpm62siLi4kEwtFHYyA97BsyKjGFUV67cVTdy4qMhZvda+rPuaquQseCz4JnqL4nPHio5RtXCBSENQK/YPFfsamK4wFHzv9nZAqwifc5vaiTQ3XQ5eOHKLZxVYpLYNaRkg==
Received: from CH2PR14CA0033.namprd14.prod.outlook.com (2603:10b6:610:56::13)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 17:35:05 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::bf) by CH2PR14CA0033.outlook.office365.com
 (2603:10b6:610:56::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 17:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 17:35:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Feb 2025
 09:34:45 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 7 Feb
 2025 09:34:41 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>
Subject: [PATCH net-next 0/4] vxlan: Join / leave MC group when reconfigured
Date: Fri, 7 Feb 2025 18:34:20 +0100
Message-ID: <cover.1738949252.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: e2105211-9a9b-4c23-e9ba-08dd479dc1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4bjYJtiq2VzHt2hw2br64ZDtyYw2pnXEHps2UTi18NdQZf9Ve/M/CwwZjfb5?=
 =?us-ascii?Q?jvxmVWfWDa7zZEUexSGeUr2tCQlxhey8wntTb7SgH6xQd0t2etQUK9Qfqb4o?=
 =?us-ascii?Q?xV/t+crdmQkf4rrl7OQ7+h/5ML+FxeaqATE+yPrXduxWQkIaKCo8D0ruQcAf?=
 =?us-ascii?Q?Fi9HNDo+u40yjWHCXWoNVy47d7eW9BCyuGwgjVD+50X/97JbWQjQIJY+Xd72?=
 =?us-ascii?Q?/dzG7K0hU2CC7fC59Oqf84zth9xld86lFItYn2ZXIWPczrBiSkr9qSkuY4eJ?=
 =?us-ascii?Q?HquojDBB1cJgylJO6Pu3Ng6PV+E68VE8kbdlZYqS3ZUPXYwHmCz6T1b0ka/d?=
 =?us-ascii?Q?y0GqHOiPK6B51olX78oYcCqiNnb5xZhoNtb3k7f/OLlSwza+xCp7YeKPwJPh?=
 =?us-ascii?Q?VkCQCyVJ+iJChCMrNXzwupsx5DWTmhglAK2hc1Nq9xY3LMOcQtoRztChAbRT?=
 =?us-ascii?Q?asAfNYm+8mZoqRVfzF1nSv6LthTgYosP3joBziF+cxITtXIsnX7GXEvMJInO?=
 =?us-ascii?Q?AqsOy+OrfB2ZsAdXM+XW8ufsjusXOM4IEo2gVw4pDMPslETVPUqfpODHF4I6?=
 =?us-ascii?Q?CRCOKWilfKf3SzUzzQhUs9IUx06qe7I7amki2h2R1powm1fNw3FwU8i8P9nm?=
 =?us-ascii?Q?EdubswNBrU8FXL+DPkgPjDL5Kn/1oz9vvttxHPSSxHK24qOuSyEgNJAYlNzC?=
 =?us-ascii?Q?ySItmWsiBuDYQ5kHP07/hA2BgDb1cj+CMeZa8E3mcKDtbZdnWEkFP50zqqRy?=
 =?us-ascii?Q?0iw2+5QIzNqygWvh6Swl9CdN6nMMG7QtWlf1L7d5HzmfprWtxmLKZkyARcwU?=
 =?us-ascii?Q?fhtitL/LtCLNc8Qs1qrJi/QpKbHtksh+rANCROgKmC4SX0uiNAu0LYk/CfgH?=
 =?us-ascii?Q?n7WIaYT4XSIdjZcI7eLeN+DSdDnz91gcLwN+rJ8dG3BVlL+/wG3EJLSdxVYt?=
 =?us-ascii?Q?7z0G/1eGgeXh1iANpsP9hWwcXnuj0piEoJfPkGHqZAIetiwaGT97pmjY+K8O?=
 =?us-ascii?Q?M4XlA2A4I15heS+Z9dbzc6owI/uFMv9H6fu1AK2AFMFs+vFcT3BMG67R0rMS?=
 =?us-ascii?Q?3PU+Wl12opPXUPoZ/sItfN1yYPx9GlllErNSuLOFfkzQmSX4QLBQrOcbTBIY?=
 =?us-ascii?Q?qdeSHKl7kEDMgyZdE+l1IgbqgtjlJkEksdPLrNJpQGvE8lXKiqwv2xj7R9NF?=
 =?us-ascii?Q?i5M2SLSQPjo4IP74UdqDQJWijaZfrz9pbjrdc3wsFUR/bqQ/Kzi9DyaJMikT?=
 =?us-ascii?Q?HAledf8lrn3vUDoVeJhwljy6VBeY2YqSBGP2V0ZRYDeXPDs2/4AHyuLWw5cB?=
 =?us-ascii?Q?TSEcguX3xkG/f1UOZKslUUmaG4T7u2h7Xmoi9jYssN4hptNr4guqmBuutGR5?=
 =?us-ascii?Q?el5Y7SGPx+6doHH4CVAqXvmquTMur4xiwfe0J3BjinachtPdqs1BIOHh5C7E?=
 =?us-ascii?Q?odNsRN6kGvGAjI73UnHaKT1tULaxUIdgFVLcbIZwRUVt3OaWhu4zqKwML5nc?=
 =?us-ascii?Q?UYYoLpqMiSy6NO4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 17:35:04.1916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2105211-9a9b-4c23-e9ba-08dd479dc1ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372

When a vxlan netdevice is brought up, if its default remote is a multicast
address, the device joins the indicated group.

Therefore when the multicast remote address changes, the device should
leave the current group and subscribe to the new one. Similarly when the
interface used for endpoint communication is changed in a situation when
multicast remote is configured. This is currently not done.

Both vxlan_igmp_join() and vxlan_igmp_leave() can however fail. So it is
possible that with such fix, the netdevice will end up in an inconsistent
situation where the old group is not joined anymore, but joining the
new group fails. Should we join the new group first, and leave the old one
second, we might end up in the opposite situation, where both groups are
joined. Undoing any of this during rollback is going to be similarly
problematic.

One solution would be to just forbid the change when the netdevice is up.
However in vnifilter mode, changing the group address is allowed, and these
problems are simply ignored (see vxlan_vni_update_group()):

 # ip link add name br up type bridge vlan_filtering 1
 # ip link add vx1 up master br type vxlan external vnifilter local 192.0.2.1 dev lo dstport 4789
 # bridge vni add dev vx1 vni 200 group 224.0.0.1
 # tcpdump -i lo &
 # bridge vni add dev vx1 vni 200 group 224.0.0.2
 18:55:46.523438 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
 18:55:46.943447 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
 # bridge vni
 dev               vni                group/remote
 vx1               200                224.0.0.2

Having two different modes of operation for conceptually the same interface
is silly, so in this patchset, just do what the vnifilter code does and
deal with the errors by crossing fingers real hard.

Petr Machata (4):
  vxlan: Join / leave MC group after remote changes
  selftests: forwarding: lib: Move require_command to net, generalize
  selftests: test_vxlan_fdb_changelink: Convert to lib.sh
  selftests: test_vxlan_fdb_changelink: Add a test for MC remote change

 drivers/net/vxlan/vxlan_core.c                |  15 +++
 tools/testing/selftests/net/forwarding/lib.sh |  10 --
 tools/testing/selftests/net/lib.sh            |  19 +++
 .../net/test_vxlan_fdb_changelink.sh          | 111 ++++++++++++++++--
 4 files changed, 132 insertions(+), 23 deletions(-)

-- 
2.47.0


