Return-Path: <netdev+bounces-41706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364297CBBE1
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BBE1C20A7C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9982815AE7;
	Tue, 17 Oct 2023 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nq+Rk/bD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1159413AF8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:03:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E36483
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/dXsqZp6nHbLEOsyRRvPmBjdtVkssQhRpBUXJDybqs5kFU2c8t2OARdWsmv1FO1rSZTVmcnzfHAtPHtsIcIz/7RuoKTv/R9nweKlSo5wYvbpOVfY8HtOD0jndS7n4cthomhnidEL7KH8u3Uka4s/NLbAQRlaOXGwse2Ry1kSrGoXcw+ONMdEJPV9axEylbGB/IUbidVbkTSeE5IdISe9i89yeCW3C50K1hyT1VpMzFq4abEDSfn+zrq4p+fDLUkmihwcFNneHwP4u/r7L/km4dz5QuOlAki689gn8oRAIzhTbDBC6zemxHGa1x5vlSrY/mt0GfNwTWFbZyPfZ+TTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjjTRwBTSuQJh8HNPF2Q+oIKxNs12ZpVc5+KHJQzT7Y=;
 b=maK4JpIVPWForfiDOC69vPfaDOy/7LTvOp7jm5P+BJjSyh6nBQUJFHM85eVfEgI4el18AAGk7Nhjlgu6A/FWv3GTuX/4jiHBgsB4CZ5v3XKHZ6LfX/g1NYlVPeBDKQ5X+dFIxlET1t7jUzNVH6CKMLsuSrS7JINvBRKW77q0dcvP2D0kxS5jU8ryRXhtjdPGSOq/QzWVIEFi8svaqWnxSsDyTa+EIuHO83WrHVlT2pWcW3k1fURskhe1Mb505ItCqo678IhxoaQyMXpknHvcBEMoiGmf5MEM48S9trJKChrewxfDo0ewQOj7K/yAvYQ2yBmQV25EbMeRw3HLuF9j7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjjTRwBTSuQJh8HNPF2Q+oIKxNs12ZpVc5+KHJQzT7Y=;
 b=nq+Rk/bDI61Q70W5MksWWWmCyrj/w16l3tVu9/BLB/CIGiC16Nut6gA24hDzBi9wtiuQV1reeNWEwiVvNTentMPokREhgcBSN18JJ2GrhlDfNuTfDsLjYh2lrL5KIOW21Od4FZmklERT8/4qmQxOLzh40/92wHi1JWSERRwHyv1vlasgMjIC7yO1nQbczygjKdaP2NCkiem1JY+3OadxjFw+VzjeYy/bg9MrqSg5Cecd66ulpf0gXP/qdNSbp7I9tzBEUkCVsMBnoGgtoKdqVL8wVeIuxh9qb+6YUxuj5HPIsLmGYEqzwK7vQtXgw8HT90ek3BeDfJJCX+yjtREAjQ==
Received: from MW2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:907:1::27)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 07:03:01 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::f3) by MW2PR16CA0050.outlook.office365.com
 (2603:10b6:907:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 07:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.22 via Frontend Transport; Tue, 17 Oct 2023 07:03:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:02:43 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:02:40 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next 0/8] Extend flush command to support VXLAN attributes
Date: Tue, 17 Oct 2023 10:02:19 +0300
Message-ID: <20231017070227.3560105-1-amcohen@nvidia.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e53e546-813d-45b8-3d68-08dbcedf1a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xgye+Df5avT9JYmTiB4azkKzy/8e6ohLjC6PoDxNjW23RJ6Xoo4kH1JTdVcuPVZp3Gg2lJahjVwgf+2dcaGVqk8h/0V2ufGW2LkyKHO3mVjKwkcSGIOaXCCDOhYaxbINtUwwRcXN+1kMf/j7AcyGFuYlgn0rh+cTFWNUpkohB9fyLfmR2AILu35tTEQzMrymXVNgKEGBjH4XpauCxh3KkIGKkjbKqqvWe4O/Rgu2kokicyR1WZ8k4DUU0pnclhXMWHS3M8EysHAgZjCXH2NrzAsS2Sb14BhPBkX+3O7V9htiHTTqqrmtap+SFUcT1iL+GPQtLXm7LK26jqfB3AYFLEOEHLalGpYKRDJA+xfck6p1L9ArvZVJciV/PiCN6f1t2lTKWkDpM3iruxSloR+OJfkDwMoNQnlJ0RIKIzGmb1zrXAoNX+iL9O/Svwi8RWgF9lUBoOdTeiOOxXdwOOYEyDvS1Ro2NZuily3wg8AwgUZrK0HK7ELOFJ1yc2uToNZ/DcdZUcSREmot6C1cMQLV6a7raN7bFaYAkMWgAgM2sB53jh/tzphJwbE10x2QLq5b3wVLEeWfbqd5DJUakQLNxgYRTGtKKazuXMTvdvZQSMKziy5WZbHP9hy+GF4uq1AtFezP/1bmECcLuX5yBvg1hbKBM6J694p6O3mT1osv91leaM9gqGwGlfyUYDFcOfKQF7invdYHl5El2VYZmi84qVHjU8i9fqbcgowpRb06uKbEflIT9co8YxhZOAcaqaRq
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40460700003)(66574015)(1076003)(426003)(336012)(26005)(107886003)(16526019)(6666004)(2616005)(36860700001)(83380400001)(41300700001)(5660300002)(8676002)(4326008)(2906002)(8936002)(478600001)(70586007)(54906003)(70206006)(6916009)(316002)(356005)(7636003)(82740400003)(86362001)(40480700001)(36756003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:03:01.1008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e53e546-813d-45b8-3d68-08dbcedf1a04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The merge commit f84e3f8cced9 ("Merge branch 'bridge-fdb-flush' into next")
added support for fdb flushing.

The kernel was extended to support flush for VXLAN device, so the
"bridge fdb flush" command should support new attributes.

Add support for flushing FDB entries based on the following:
* Source VNI
* Nexthop ID
* Destination VNI
* Destination Port
* Destination IP
* 'router' flag

With this set, flush works with attributes which are relevant for VXLAN
FDBs, for example:

$ bridge fdb flush dev vx10 vni 5000 dst 192.2.2.1
< flush all vx10 entries with VNI 5000 and destination IP 192.2.2.1 >

There are examples for each attribute in the respective commit messages.

Patch set overview:
Patch #1 prepares the code for adding support for 'port' keyword
Patches #2-#7 add support for new keywords in flush command
Patch #8 adds a note in man page

Amit Cohen (8):
  bridge: fdb: rename some variables to contain 'brport'
  bridge: fdb: support match on source VNI in flush command
  bridge: fdb: support match on nexthop ID in flush command
  bridge: fdb: support match on destination VNI in flush command
  bridge: fdb: support match on destination port in flush command
  bridge: fdb: support match on destination IP in flush command
  bridge: fdb: support match on [no]router flag in flush command
  man: bridge: add a note about using 'master' and 'self' with flush

 bridge/fdb.c      | 88 ++++++++++++++++++++++++++++++++++++++++-------
 man/man8/bridge.8 | 53 +++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 14 deletions(-)

-- 
2.41.0


