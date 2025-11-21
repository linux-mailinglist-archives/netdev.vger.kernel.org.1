Return-Path: <netdev+bounces-240792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 30948C7A8C1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54E703877A0
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A434F257;
	Fri, 21 Nov 2025 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PQcqcWGJ"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012070.outbound.protection.outlook.com [40.107.200.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E434EF00
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738268; cv=fail; b=Al7cmtZv00dpZGLoT4pOWGmI+QOfSY/SgB8O/TL3p+RQvsDdF+eo7jWzxsaqern8H81ZDtld6Qgp+KGJLdHxfZ4WtfIHXdkHaxBEiUhXYGsUmy3AM1+yiKFeEmpLPUnN/LMRRu4BM0D4BCd5bT8NmHwuWtjsomqjA4+k+3zxpEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738268; c=relaxed/simple;
	bh=G6L5xPlq4Pv+u47pxjbHZ/uChL+mSoVaWKK0Mbaornk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gwBPx1KWN3yNMsynEsGSRXO3ToVWk4nawZzZDIkON0QG70vEg58EVzAR1In15knauM3cMgrNSXKtTJ7cj+CnWI5flgiB765Xd2V/EGxxaJqEHrLN75KzQk0s3XiV0qYxMZ71NwrnPC8WNFkTv7mV6VR6zPhTOZbdMGVn3kLOBnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PQcqcWGJ; arc=fail smtp.client-ip=40.107.200.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN9n1Sso1U36cBdWreA++JqEvrDNpdirk0bErFCH+Xkyq1DycuzLIQgDr9qsTYTwnsFK0oII3JXpKZiFma3HbjCKy4WdiaHTsNxYk202gIaSHAcRpUd6p4kvJe+IGLzDLkMfjDe6Ogw+lOGE65VwMIdx1KB69DQUxaep5c4LzBgYlKukViv9nZWP8JZFHrnbVmjbvq4VWDMjuFFDQcXHsAvHNsBmz4KNl/Ot40YJ/fl9GsK9LsCjnYh6HA5ErHXz0A5TG6laSA/kW73lPOcc6LBr2wkqxffkXCMkge2SYOUMSJiw3k7ATa6pUq8dUgZ3tCX/O99yBkFzC15ySUF8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYZ7mzJWi85icCspnLoOPGdSrZ4Iz5Islaqd4Eei08s=;
 b=koG2eNfUdcW/C9nH9+v3srT1Y2ymSGNVi4xCk2WcV5/6/QMd1DH6ONSi+aKHnc8Wzh2npfPOf1KzKCE6PoyyszSG1BlnyajRQ7EUc/ywKbRXP26upUbfd5XicabsWAKvWzjXjH7SM9FLPnxHu8gbcMVKWcA4j7nXXbmwekiBuxExJ2A6tMFaU8ZuR75/e9LtTvtwsEnA/qeB+70X0elp5LXRZnZF9TDWBqdPpJklZgAfY6jbZqkKIp2gnajQEI+6NqvK5Kon6uLe/kB6+u2DebdwGv6hHAenVvBiePsP9YW/siKFbWpZgt7Jdntu8bOtT52d/xNQrJpF3kB9SHzqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYZ7mzJWi85icCspnLoOPGdSrZ4Iz5Islaqd4Eei08s=;
 b=PQcqcWGJyL6KRapa6QDMMwRVJwo8dfjELQZ/k1ECXrg6w1weX5OhuqyWi4GNjn8SRPPgumg+nM+Ny9IqZhjaNojU2NJGkjXdtZkS35lCAmZqZL8Cp5cp1qmy9uBvIBVzrEDbVHRPmkOEc0RPaKp2zJZNPn2wpxtfvC/Rf8Rcl02H8+2nvBiSqlL8Ankz0tYx1SaiNZ8ZcZotMLaKle2urG+hl5O2JJefVAL5ZmhdARAirT5ZhDaxENjh9iEIWHVkQXiiHfQ/eD81XoJjJ/bllYcDZqn/Tz2ozgdxzkXfWorPbO3AH1kHvXcLiaNQ0STo5xovp2G+CTsKcu4ybeSCLg==
Received: from CH5P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::29)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 15:17:32 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::ca) by CH5P222CA0018.outlook.office365.com
 (2603:10b6:610:1ee::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.12 via Frontend Transport; Fri,
 21 Nov 2025 15:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 15:17:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 07:17:14 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 21 Nov 2025 07:17:09 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>, Jianbo Liu
	<jianbol@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [RFC PATCH ipsec 0/2] Fix bonding IPSec races
Date: Fri, 21 Nov 2025 17:16:42 +0200
Message-ID: <20251121151644.1797728-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a75e43f-f254-4703-6f23-08de291117bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6bmpyaBYhvbTsBIpK8nGzw7I8MIxE4iGkVqlgAHV2Vy0sG1aAuwenXrQW3+J?=
 =?us-ascii?Q?q4omXJtpFsDyEMH0QCx/P7Oipjpy1K1XoKrogccOVYq+AedofSQX4oimtu7p?=
 =?us-ascii?Q?B+aYUN0SsQ+WBCDudHR+S3Emxgq2Ckeq+d3jg6OIZIWvVvgWpo3DoKo2YcwY?=
 =?us-ascii?Q?p9l7F7MynL1i6phBjchbvvKhZThkji8uE1vtOytuLsr6W3MOQGsemospmzPV?=
 =?us-ascii?Q?8WcaQ9UEERAOBzdvO0E4AJ6k5kVdY24YtX+CK21DG7LebxMQJ1rS/tgj8ACg?=
 =?us-ascii?Q?6S7DLHLoyzMv0q8lxqZ3r1nFmSdo9qvRQPhQwxQbrOrfT8fi4VkjRIaz0dIy?=
 =?us-ascii?Q?9OgKqwE6/4VPvb+gq49EFJxaiMXUiRUJXBee6lELVnNYvUXk1PsjOjwQZBti?=
 =?us-ascii?Q?ysKt8UhQezDf6wGhfOdaY/6ZxzfaPknyoeWgkJ8SnhjIW5nqccwvUyootOcK?=
 =?us-ascii?Q?TOu5ay104SvAeRbabM3W5wagan8wtiEfuqPuom7TqAXCuo4MMtOL80sdCBNe?=
 =?us-ascii?Q?CggX5hiqgey5faO7R4ESXFLRweC+fC8KjxZ4x6dxw/0BlV1xGnYj1SoEsFgX?=
 =?us-ascii?Q?AAb3ogDJcf6oeiw+8Wb6mXNU3hFuqGfwfR/HzivQlclQ1T6XmqmTdQGWf0zJ?=
 =?us-ascii?Q?u1Cq8QhVJOR94TctqqVqJ46Uj5r+cIn15Fg7+m2UNN4z+shi8Y/KW611S4IL?=
 =?us-ascii?Q?grTIpvwROBW9vV2efIf+pZSg9wZyCCHxNIsQ93ms2nNrOO8SplMr5oLwHKDI?=
 =?us-ascii?Q?euHsAAa5LQ0XttSm+nTpRRYkhqe+yllyZHPsLug75u8W6+9baKqI3ItpjxhI?=
 =?us-ascii?Q?Hx0JAJwxrBem1F9WVgiJBbp93JwRborC0nKX9DpLNWE2CKWTABBsg51AssGp?=
 =?us-ascii?Q?2O5Nlx0InOvpPs6lPL9ADvM+MCwU6Wsp6wlRdF08lGmx/yMpGdnJCYgYJ92+?=
 =?us-ascii?Q?h3N0s7v0FmzNYM1zjoNn10lOBzfPNpeqS4yvtDgi0lzheS7D5KKZJBST4YBI?=
 =?us-ascii?Q?ApSBvE8chguWAjtQUhkyrIpE0ijJISqRWwDqjoKreASFSrDQ26hNDxisPlCg?=
 =?us-ascii?Q?3oY8efjCJGLpoPHE9N35AswdiJ4//QROSWOeb7OYrr7u/GFZVWOXbRKc/De4?=
 =?us-ascii?Q?pHlgVDkSWz6a5ICTWUipvC+8oXBRNgDSAfIPU6kRetqSl69PfMiyUV8KFRz1?=
 =?us-ascii?Q?D0CINndI92sn1UkE3Nz6vyMtXBCkU79j/B7LY6lVR2Jp5LKF+R2PtZW3o6FG?=
 =?us-ascii?Q?e7iBEGcjT2vOYcBjMvJO3OOnS6NHdNCXZsL/Q3jYaBJi8X5r/VfUpOJ+4YET?=
 =?us-ascii?Q?yVPNXW3wu1qbDGzyDiR7De3qmeiHYXHJHbfuquT5n3j1Ds+eRKS3MhuNjWWe?=
 =?us-ascii?Q?zKb/JSmjKNNm+Xenp/suebxEaWQxeYkRLp8jWk+cqk41xnhliaF/QffFtv+j?=
 =?us-ascii?Q?p84AmllaLSWVhOlOCC5qKfReon/GOc2vlWVHkiLZDYSj7GkW22EV4LDXQFWc?=
 =?us-ascii?Q?2TjPMa/zg4FWr4Sp/cfURk5uj3jU89sgztI0leAgq3Y9hovMttpR5aAlF3pg?=
 =?us-ascii?Q?tmu7G0nZqopeJTz7sdjhCD+sAsA2fPYdrQdrZcuc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:17:32.1143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a75e43f-f254-4703-6f23-08de291117bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209

These patches are an alternate proposed fix to the bonding IPSec races
which could result in unencrypted IPSec packets on the wire.
I'm sending them as RFC based on the discussion with Sabrina on the
primary approach [1].

[1] https://lore.kernel.org/netdev/20251113104310.1243150-1-cratiu@nvidia.com/T/#u

Cosmin Ratiu (2):
  xfrm: Add explicit offload_handle to some xfrm callbacks
  bonding: Maintain offloaded xfrm on all devices

 Documentation/networking/xfrm_device.rst      |  13 +-
 drivers/net/bonding/bond_main.c               | 284 ++++++++++--------
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  20 +-
 .../inline_crypto/ch_ipsec/chcr_ipsec.c       |  25 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  47 +--
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  18 +-
 .../marvell/octeontx2/nic/cn10k_ipsec.c       |  13 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  26 +-
 .../net/ethernet/netronome/nfp/crypto/ipsec.c |  10 +-
 drivers/net/netdevsim/ipsec.c                 |   8 +-
 include/linux/netdevice.h                     |   7 +-
 include/net/bonding.h                         |  22 +-
 net/xfrm/xfrm_device.c                        |   3 +-
 net/xfrm/xfrm_state.c                         |   7 +-
 14 files changed, 295 insertions(+), 208 deletions(-)

-- 
2.45.0


