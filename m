Return-Path: <netdev+bounces-41872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E637CC13D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A501C20D0C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EE741778;
	Tue, 17 Oct 2023 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KEzNkIGa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AAD41751
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:56:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA53D4F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9qSy5ojhxSIepDdm/aDRllxJVmT855N8q0+3Rx90lsNGOKHKKJulalZDP7jEieKPZ7Tw/gKOSz/Xo5aAF1GHGucBCqThYpHunxNOQ7//XOdL7JVgEXtltKrx0PJpUvite5fEpoOPG+3jl/iXITvn8tiIMmRe0qktioJCIZMQv0/d4XmLQLAeWDuBlWuQZ9T7JjUGM8yBmFZTtAvKxDPPGOL+R1Iu5GUtEqekJdEcXOaRer7A9bqkz1j7/2M4vEM9rBUx21cOl84dQZqGRZsAyvdXHr2uz+/Ktb67NI0HjrW7eONChd5JD8mRLOCiAoVbo4gTzHM5P1GyFBFSZB5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23Twx5DsBSOBqqZ4Ds7WvJfOmN0oawaG86rEgLV6Vr8=;
 b=SPHxA0kqyVq05YBJwtkUWRWyqY1rEABaVdMPtfWjZ3tSqjlJxsJR3jjeQmqiZTaB1LjcapLRR+SJOkHjDq3D6NEL1W6sg7F3ABcAmmCI6OdCJMMnvp20zlcIi18C8wGYaI3wajsNvOvwCvp4MDDI+EYLmQde+csV4vpOoOChYSj9SJF8cLKRGPBULDdQ5L8qYugXj+Cafe9qVZle2CQv9eHFXGflNFd+hG1ZrHSFg53gvISMC7Dgb8hqA0VPTmZCItk0wlveNev9L0wHHn1DRUgWaGSScY9hdYLXS0KMrNQIMHBapdu6rmJYtxl0vcGKbwDvcAwURPmfbKq9xxcr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23Twx5DsBSOBqqZ4Ds7WvJfOmN0oawaG86rEgLV6Vr8=;
 b=KEzNkIGa5REJAntP1dpP2cHhABljj37AsTHjoJzy7ZfIkqQZFrBlWgKjByDSda+r/LcAQglXbX37I/wmrSCYgj7W6XoUDRfBIplVDfqyM+/we9pzHFnRK10oFm937yphPwI+6tprSZcyNI8+uKYKsWk6wfHvc7AKAoCLaNt4iXwcqcXAZvLj1vGxYm+kCz/7+6fD5erAoq7zuEGQAef39yXgZX99BFWZoaM2mF9rp14E2zpWntPaL4egW7WY+AfOEyBEskIp1RaixCSOWZTLwi5NzoOi3NTdopfhgapRUFlJezgxazUjYf426uaCMDcLnLLsYrjLyixG6nfenItk5A==
Received: from MN2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:208:236::23)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 10:56:07 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::3e) by MN2PR05CA0054.outlook.office365.com
 (2603:10b6:208:236::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 10:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 10:56:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 03:55:48 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 03:55:45 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next v2 0/8] Extend flush command to support VXLAN attributes
Date: Tue, 17 Oct 2023 13:55:24 +0300
Message-ID: <20231017105532.3563683-1-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 27bf5a74-7439-42dc-47f3-08dbceffa997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SHaHwT7B79yEuEIzRbY2gmy/L5oRAGBzU/Ra7ztG3izHoaSTlKYniaxbj0/jXRIB0uzOPcH6Dp0JrL3EC1u2jVb+uBvwXeoN78pNu/Ys2EPSiC7D7VyU8SgMPWcL9N+AfXz/VWgyTEEKgXY0peI70F0gD3DexyLpnYlHTlIQ3EYTg9gbALHAKr+jesoECHylrj0TuDSMVMNnBRpxbUCfjvUERQYxgavEO2dZ03J0Y8GUmLJNI+yJWbAu+b46kVT2QU+YZM9wqdcOJoAEsb0AlBdz4cNDIDHGe9BLlPjvb6bmXlLnQ7RYGmUI39srArflNYnFSVCJz3hNJ2Bcm/Uw0JYtftWBcIZna3wywJQnB45NNpvf5a9DkQD6w3B3/xrem1LyYnZByRRpVQQUpez5aq4JdD8BpWbBR6PgWIv2fkC4bElHTWu3cHt8kSuPaTtBGn60KAEA3aI6lVcHi12GZXYmU4LU74oORi/RzMb4Tef/mhhfbnBbrSqcM+jxeZFCYDhSP0f2zCr7PyHu5fE7v/S+d6NT7iJEZ6qrPqOAjbYK/CLhJIa3PMEt9iTbXlkc10VDvjDcY0lb7Ym6QZFc44WntZlpGoMOQfMMrnFkJqAwDiqMEHIuPEPLxRFoHJeMOQSYls6NetsE8awsOp+PlY22IJRR1GDGUs7RIexgmm99kDnF5NeEuWEc9NCtnymhYnIS2iBlr7qgbRnNN5Vl/S+DVOS8F+E0Z4iw5MlnmcKSCNWoZ6lNiMA0kVjW1j0A
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(6916009)(54906003)(70206006)(70586007)(478600001)(1076003)(316002)(336012)(426003)(107886003)(66574015)(16526019)(26005)(6666004)(36756003)(8936002)(5660300002)(8676002)(2906002)(86362001)(41300700001)(4326008)(7636003)(356005)(82740400003)(36860700001)(47076005)(83380400001)(2616005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:56:05.8428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bf5a74-7439-42dc-47f3-08dbceffa997
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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

v2:
	* Print 'nhid' instead of 'id' in the error in patch #3
	* Use capital letters for 'ECMP' in man page in patch #3

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


