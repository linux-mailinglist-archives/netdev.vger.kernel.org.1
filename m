Return-Path: <netdev+bounces-63968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FE0830916
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDABB216C9
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C05210F4;
	Wed, 17 Jan 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A6zfaM6X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6020DC9
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503905; cv=fail; b=AXWnKDVGYx8+7c+wZkjwgkXCOOeV9s/FjFj1/oy95cPc3Gf3b0iPFsuBjNPeHjtWYwJ78KV0GV/qXqwXZ+pf0cpF8a3n7xEATj0Zh6It/ErZYRQXoh2pENmGiEp09B1VopgPX9l5MWFEUY5lvJ8ptMVqUC6dV5Sn9Q6XeslFxP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503905; c=relaxed/simple;
	bh=vxvK3DQ9xHAVgLTecwAbX68TJPeLHz7KhrKTW4o+7Gc=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=I+2m+5AqDSdnqN3Hi4ztnGmy7+xKTMnv3clyHmZg1MrRCdU/DjFl9WKfxEutEXI82RROA2FubDjtBM2K+tXW5JOtrsFRsw636Fr3lRbZqONyQv1rb40CgnLYh5hYP2VBocs+cZsYVZsvIshOIXL5+0skY6+mlVTVBlHk5i8A8Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A6zfaM6X; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOUHRwFU5yAqM7yhROB7VHLfsxTeiB91pJ3RqCUZuY49gTR3cGtBcT/BiPXQ3ikjqrlxy2kIqYPsmpMI23KddfGfSsjq3FabPou+wasMKujMQdKi2DCk2N4QEwt4PtAA6ZW2iLw9hoWpisJuhhYLViEJf8reov1opi0z06XpVJU+TtkTofe7h4i7KZzU8/OzoxwoumpEyT1WpdiHxw8cCDB2K6OESfJ4GDQokd75b2LkLay1vAk4O4eUMM5zThE0XKpmpiJ303qmFtfgMU6uVOEIqJWQpDQ6h1OsxOwEMe5+vOysEw0n21diivjrGvnpuIvKWQMfZFl9MLLMQkZz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RUlERDiEAzafid2a0tIsVmDxZAedMfqr6xYZ2MhonQ=;
 b=Oo/jYQSkn/GHXkbUMigvNXw9Tq+XKETWaMUiVYOL3reiSOBfQOoh78dsPr9GNlZ492obPGx4b5nsJXAdp+1zpobiswAJSwLWEbxfbZedono4FjIm//VO3XlhqndT5Yv/H0JYIrX4xk+lSRgSnoQ3bo+8iWNPKFeMhaTrp6uSRoMFdIkYtPBxmMY25T/ZR4VKNSdKZFDB+KJQ8UXVALGu8aiPdJgqAQgvZghO10TBO6P66jNnxCIY3QXpJT0aDhdR9NtOsEgvVykOVckCg1mdzxCvh+jSF+rQrSM+QVqXGSlbNa1einUBSThsx3SMpi/+Rl4Yh1K/opPr1LoxzmACkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RUlERDiEAzafid2a0tIsVmDxZAedMfqr6xYZ2MhonQ=;
 b=A6zfaM6XQsP86SjB61ZfiM52Io5w+EdvqHv7MAcsF20F5uZFebSlFwZZNUu3rw0VF3kc4xUDIGibaSLiUbECjBOXsN+xXnB8FAzae69zM/Lrr/Gr8a6w/08kX/fLtTbUoftV81/PQFoh7maOlGrr8yaLkjedriUtzDwi+DNqZi6RXNOhDhKRO8KiCEIbKWsI/u6ei+eBE2M8WjmB/cVzNpAFTf9BMAyMZC8N9xPvv9hIUk9t8Zstap3MLU05DR0+QRc278ZLQxwRgXWYOaN0cWUzzjGHPRkWmFIgvYsVCPm7uLmTEhxu+BxHw7+Jlemwce9oMoYieBEdQFd1oLx5rg==
Received: from DM6PR07CA0062.namprd07.prod.outlook.com (2603:10b6:5:74::39) by
 PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 15:04:59 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::d7) by DM6PR07CA0062.outlook.office365.com
 (2603:10b6:5:74::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 15:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 15:04:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 07:04:46 -0800
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 17 Jan 2024 07:04:40 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	"Jiri Pirko" <jiri@resnulli.us>, <mlxsw@nvidia.com>
Subject: [PATCH net 0/6] mlxsw: Miscellaneous fixes
Date: Wed, 17 Jan 2024 16:04:15 +0100
Message-ID: <cover.1705502064.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3f5737-e3d2-4109-ee3c-08dc176dabb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RtcrUKJXvaHv4DysSwb5O1WgJU2Np8ga09wjG9REmQuIfiLwAI77bYRSDGP21C9zlAgfy91a2OFDNH8G6UBlEzyQ8SCoY+6mL80Kv/HNhz0wX3zdlzi0XC2dgYBTtEfv7f5wpqwYwqkVsd3RavTRRuvqp6++WlWC5HnVoYQgqYzkPwGlOvu+2ai+9nweRKKFtqK3n7+BtJLzSNyv53C+gkN0jdM/++TbcBkUDkzLEUhuQEvEqj8QSjCJytH1EpXL91UqiRX2NyIrYlKFNAy9Bnr7DT+xE4E+B5MywD4Ql3ECoPKI9wK4sklsdCpLVq5ZIce0xAqcb2F5TRaYb3hA2aECNWPG2Kq9iaFrPx63li9r24NINQj6i3aU6tOaiFRpGkzPMqD98NCR25rVhKvf8g4oT1jV7vSCuQbjE+pKWjPf4XFKboDq9lgxOGMWXqUld+sNK+pvAJX204bxlv8LLYQKEMNkalCKIrDog/a88Zr2DrScIt1dfPBaLX2n+v3i6xlPLza03CEyrbN4u03hHmw0hrIy0vm1Ic2dBiTETLf/+IjZMTNDPgrqMHT1xFzO5t0OFYLl/2mHrVrN9DeUmuOp8vLg4Qx3AUbCUrxIkeSRqnB+i4dj4jVupqZL12OGdvuqEbpw1YUNaXacA3g00cc2DyP3C3MeVizsYwK705Yy9HNHVE9O8TQxhAoY9J1OigXxji/p/6j9hw1eloKpDBQOfbUOroQH2zZdbXO9y8lK7MbY3Uii/BMthbIdp6q4
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(70586007)(70206006)(7696005)(107886003)(2616005)(26005)(426003)(336012)(36756003)(6666004)(16526019)(82740400003)(86362001)(36860700001)(7636003)(356005)(66574015)(83380400001)(47076005)(41300700001)(478600001)(4326008)(40480700001)(40460700003)(5660300002)(2906002)(54906003)(110136005)(8676002)(316002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:04:57.8506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3f5737-e3d2-4109-ee3c-08dc176dabb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

This patchset is a bric-a-brac of fixes for bugs impacting mlxsw.

- Patches #1 and #2 fix issues in ACL handling error paths.
- Patch #3 fixes stack corruption in ACL code that a recent FW update
  has uncovered.

- Patch #4 fixes an issue in handling of IPIP next hops.

- Patch #5 fixes a typo in a the qos_pfc selftest
- Patch #6 fixes the same selftest to work with 8-lane ports.

Amit Cohen (3):
  mlxsw: spectrum_acl_erp: Fix error flow of pool allocation failure
  selftests: mlxsw: qos_pfc: Remove wrong description
  selftests: mlxsw: qos_pfc: Adjust the test to support 8 lanes

Ido Schimmel (2):
  mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference in error path
  mlxsw: spectrum_acl_tcam: Fix stack corruption

Petr Machata (1):
  mlxsw: spectrum_router: Register netdevice notifier before nexthop

 .../mellanox/mlxsw/spectrum_acl_erp.c         |   8 +-
 .../mellanox/mlxsw/spectrum_acl_tcam.c        |   6 +-
 .../ethernet/mellanox/mlxsw/spectrum_router.c |  24 ++--
 .../selftests/drivers/net/mlxsw/qos_pfc.sh    |  19 +++-
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh | 106 +++++++++++++++++-
 5 files changed, 143 insertions(+), 20 deletions(-)

-- 
2.42.0


