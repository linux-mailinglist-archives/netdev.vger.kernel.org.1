Return-Path: <netdev+bounces-150591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109FF9EAD19
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B7B28C65D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F773215764;
	Tue, 10 Dec 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nghzPLE5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85123DE9D
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824029; cv=fail; b=bKcjdIR1uZFh4qtYj5Deh0AWwTGk+Dq1WmbQJBUQAFgd4YK+tUdRr7I1EhUig1WocNutQ/pPpX9LheXlynlzAYmUeQiPBmQEAQEKV0dy+ShfMBCkTq8JGbw8aQTlYbi3rzFmlTdCkRBaETg1CdUuGdhAVtVT2wpO78+av7VqDd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824029; c=relaxed/simple;
	bh=ZLj0Idj/MXHM3WjyffYFBrn4FNM8Hf3elbcg/ZwXweQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YAX54xn1fRzrIb9lbFmCXX5CMpq4tIhIvU7+ZvjOLibxQlMbp73iW2+9tz2cnwqLFTJXQH1H/u3bUuNt/NBM2dA4sB53M1q+Zky/UobQZqtRm3ISt2bruWlp6FX8a0YSQgzLdV7PO4nDInjX7AE+E97k5bK/qItCAk4C0PSIGmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nghzPLE5; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ud2CViYBjtpO85jN0Tv7Udb3ZXgY356L+ItccximwkRSqXbh5g8Rd1i8aspf1PT8S9YuEDJfengMxUs6lAUyIWYxErZ3AW4Jfzvc59C9jMx2wHkLirDn1GOqPz9JBoV5lz6TDkNn7rt64NJx7BlzLOET41xK5iCdZwFAqosbHFI1HRlFGgUdOCIF7GZvZtRrDh5uQCPkF5arsiC3JsskUhSlY17XpJwYw+0r1tHH5PrQSfWfSn+nVfpBYK3gxvxj94gqO/crZl0oktwRuCtmdsC/W+0aeEOtDMXn8BR36vFzYQkJVrjkgFOGmFOvChaQzunLPQ2krgfoZFk3u9obWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBgNKWYQVAsZUe/8159aTQXIED5YPMHSMgDBOdhTsT8=;
 b=rG5GbhKmkUuEGkgdVt0igCmBbQZJPbqCFdrosPkQwwNKabLkevEcYho/vV5SH/rHwtSXOPi303SvSFbmiAod38ZCVZBwcu9il8tkR4trXokxeC99e8Vy/msKpLoWqt5jFFoSDMLkFjodAtXHE1ahUr8mQgTTktV2D7PODS1PZg0xlKQBDAgd4R6vPbLe2RBIwfDuBhG2mXwyfE9vrAv3QD3HFySCkEKYTGsdE7bzTYC0BaAOO770O5RPXtgBAZ0qNzIX5wV9QmbP0rlNhgx/m4MNQxD61eB93ISO1oYBsR+zr64rAQ5eRyG1nnamfrGfxZEU3s+nI3GyyjsAM/Wueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBgNKWYQVAsZUe/8159aTQXIED5YPMHSMgDBOdhTsT8=;
 b=nghzPLE5JYsTKtZ+h3TtnrwqC9F2X8LC1dJFrQF/mOlvEFifM5Cth7qmTAXsjLfPTRzUWdZ7Hg3SgMOS3AHAH8C4BkTDvLD5rKxGS3fx2mkB13WdEvymzeaYhvayCPq3v/WFHn0NzkiE4zHDiBWVukyK79mrgEXhbEjno4B+wZCVnUQTds67kf0Ogss8mVJylYMh4+lY6DJRunERV94kKCFnu4Mmhbyck/bsNbBwzFT7OBDAxsvTWgVUH3qUeB9RI7cgcwbyCRmp26AMKzWR5fgWNhnNZLyH5IxSAkUHJtFtNhnySoa+bjDh8yM2iz/RYp8Fsy/n1OqheBqDqqY3zA==
Received: from DS7PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:3b8::35)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 09:47:02 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::5a) by DS7PR03CA0030.outlook.office365.com
 (2603:10b6:5:3b8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 09:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 09:47:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Dec
 2024 01:46:48 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Dec
 2024 01:46:43 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Vladyslav Mykhaliuk <vmykhaliuk@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next] mlxsw: spectrum_flower: Do not allow mixing sample and mirror actions
Date: Tue, 10 Dec 2024 10:45:37 +0100
Message-ID: <d6c979914e8706dbe1dedbaf29ffffb0b8d71166.1733822570.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6474f0-266c-49cd-fc16-08dd18ff9922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bkf1i3kse8PyUkuECNqUfN/C6xAfuMxpCLzJX4Yy3153EjvBxQyJc/ekLNzd?=
 =?us-ascii?Q?PDKdQ2ysCJswBtlNhmcCvCo495lyw4gVzOw4LjgVMxTZVgP+NdXvTxCD2q27?=
 =?us-ascii?Q?YPF0crEmKPbnnbr9W0g5TLb6LVsYcZrsEEXXfq3+BYomW3llOd4pfoMhcn6D?=
 =?us-ascii?Q?UqWFXAtXYek/ZL+b2aLDvJXnJ3lhgB5RQ1hy9hZX9ovTV6nGrbcEahJea2E4?=
 =?us-ascii?Q?3LhPkfk9GYF/Ss3sS6C/Og7KKeC4pjrdPtsVcqSIOz9vKbu7ZTh4aEii0Ddc?=
 =?us-ascii?Q?XDiSdE0R5TJ2P0Tfb542tx8gSH8i9NLLK9sX4zux0Axo4U1N6H+1ns9N9U0C?=
 =?us-ascii?Q?gV+9LCxwyuSQjAxARFz3XKoJWj14PLmyZC+oJV1z09N/sbosLtTL7VJggYzc?=
 =?us-ascii?Q?SIl9mL1Dsxia+o5dRiutXAA9BGcNHRMsSBt6ME3P9mRdTYTXDQg1sPzdq9EA?=
 =?us-ascii?Q?37Cdjtq2zaGnuG6nTzOfX1boV/05W66cByK+0A4zAPaj6tvaq6JV7acnzrx5?=
 =?us-ascii?Q?DpU/bHUftPc2kKPJd2LFxCG9YNWfU2K0xbc5fDZ4yQ9CWj7jPqcxHAzaS+Bg?=
 =?us-ascii?Q?q9lfNFyux9tTrIfoC+j+5/mHCZ3dA3YpNc+796zT2pXMctwe5KMgZzj67IaR?=
 =?us-ascii?Q?OuiL5MJX/P2S6pz8jifJGscPzS259/HXMJcOt7lu2S8th7kc+gJ2vk2FgXS/?=
 =?us-ascii?Q?PjOiN+cPBZwKa84HsRQ5YNPamnmNU2cEi35j+oC+kc6ns8wueec2vc6EnK1C?=
 =?us-ascii?Q?Ris50HsbZ7waAeP2EQsrF4U+391kFXX3tXPQQKri7edSjnrgz5BUKni0iSrB?=
 =?us-ascii?Q?ZkHmuEE6fwRTp+lJMx3ZgL+IpksvQ8ZY0klyFAzfyDbhXJU19ienlMMs48BY?=
 =?us-ascii?Q?IpHlgwHdQl18X3IN7cd88P2LxMt0YpjfWm77a7BpPTevv+KepjcSaydgilN5?=
 =?us-ascii?Q?EeKqJ0DPTrz8gE70o8a9433IF2ZG4Czya/yXU84C/jllbPSCqZ7ZpY9GzEny?=
 =?us-ascii?Q?M5Kf/NI7jEG9SQnmprY6iSADApvhRpxzhF67N24GFD9wBZm6Ozx4C8B3qHJw?=
 =?us-ascii?Q?PccYMwihSxwTPSdhaksZM7HtJX2+igEvpX6Lc2hU2rhn0bTVYrE2Rz68Awd3?=
 =?us-ascii?Q?JWpmCxhgcVud6+uucaiKG9q/Ipek8ypjN8kDBrWMpOTFf+r830LUI7hSHQv4?=
 =?us-ascii?Q?P13lXJFIpddwfuA/bfazsy/tlqH8eXkl7bL4cnfsH3Pu3PTRsFESMNUNDk9r?=
 =?us-ascii?Q?eeUrVJ13b2xZjALxFqbTB1bFQ24DhSA1hbNzjDzRnORczvYMNVIDfWp449Xo?=
 =?us-ascii?Q?GtGhjpVnC/Zy57edZeXz8A9W99yFY/vIqCEXP0gfAgp6xb+b72B62RwrGSTh?=
 =?us-ascii?Q?PDwPYmORDnDZgoHUh0RnmbyNt4b0CvJg1hVhLqWo0EV4B0bjI5zUa9Bz1pEe?=
 =?us-ascii?Q?YNzmxAhB/xSvfb5naXTrPWVOaI+kozXA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:47:02.0006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6474f0-266c-49cd-fc16-08dd18ff9922
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060

From: Ido Schimmel <idosch@nvidia.com>

The device does not support multiple mirror actions per rule and the
driver rejects such configuration:

 # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw action mirred egress mirror dev swp2 action mirred egress mirror dev swp3
 Error: mlxsw_spectrum: Multiple mirror actions per rule are not supported.
 We have an error talking to the kernel

Internally, the sample action is implemented by the device by mirroring
to the CPU port. Therefore, mixing sample and mirror actions in a single
rule does not work correctly and results in the last action effect.

Solve by rejecting such misconfiguration:

 # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw action mirred egress mirror dev swp2 action sample rate 100 group 1
 Error: mlxsw_spectrum: Sample action after mirror action is not supported.
 We have an error talking to the kernel

 # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw action sample rate 100 group 1 action mirred egress mirror dev swp2
 Error: mlxsw_spectrum: Mirror action after sample action is not supported.
 We have an error talking to the kernel

Reported-by: Vladyslav Mykhaliuk <vmykhaliuk@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index f07955b5439f..6a4a81c63451 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -192,6 +192,11 @@ static int mlxsw_sp_flower_parse_actions(struct mlxsw_sp *mlxsw_sp,
 				return -EOPNOTSUPP;
 			}
 
+			if (sample_act_count) {
+				NL_SET_ERR_MSG_MOD(extack, "Mirror action after sample action is not supported");
+				return -EOPNOTSUPP;
+			}
+
 			err = mlxsw_sp_acl_rulei_act_mirror(mlxsw_sp, rulei,
 							    block, out_dev,
 							    extack);
@@ -265,6 +270,11 @@ static int mlxsw_sp_flower_parse_actions(struct mlxsw_sp *mlxsw_sp,
 				return -EOPNOTSUPP;
 			}
 
+			if (mirror_act_count) {
+				NL_SET_ERR_MSG_MOD(extack, "Sample action after mirror action is not supported");
+				return -EOPNOTSUPP;
+			}
+
 			err = mlxsw_sp_acl_rulei_act_sample(mlxsw_sp, rulei,
 							    block,
 							    act->sample.psample_group,
-- 
2.47.0


