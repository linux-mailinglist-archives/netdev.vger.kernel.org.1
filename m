Return-Path: <netdev+bounces-189793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C656CAB3C99
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C2719E0714
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217023C8A3;
	Mon, 12 May 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HrVr4V1x"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810A23C514
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747064667; cv=fail; b=Zq8FkAPtrDVXH422U/8cMrJMA4JIfelAG6xYeXIMygeOl5C5Av6T9ONgJO2Fsrof1zTXyV4Lg+7SPEoyWmjmsHg1aAmKFiYskzIKQn8lT16fZkGtHDYf72V/aq46TpidxWG8siDHO/pDLiQuinFWkiB7fY43Pr27qQOze8t5onU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747064667; c=relaxed/simple;
	bh=vOuZpC5GIuOjyvl7mUhkqqdoRAxT086Av2y+WKboj+A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oR6P93aOz7cBx5qdiOTh3Qw33fQlfnTs0JEbQxELlnnE5q7byeCBrsWdqG2cICthX27qy1qmNJQi0gmht5+j1uleZGlSlyie1k9gOG38uNb01kCRBpeyspHkoFfi4wtIBrYSmx/JFXfzDy9Smr8OeyB+sM2XH6zcbptx0/g74B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HrVr4V1x; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Erd7UyOleMbgTva6DXFMSzyalAfgJZmTSf2MIDjCFO81VF+rUeWAdEfWd+bK2F+hHD+eMslGFYJ3rsYeQ/2l5OuN9Ze2asumATpCHZoKThxy06kOeMbbKVQGxN+k2FzQK9qLVhbcRhOeTtt15iLu0h4k7094HPKZhbMjChXgml42z3vApxDqZPklwllRIk1gYU5SG6Mb4Q4MNlDOtNPEff7glD80DkU/40AGyn2yjWEkVKTZAgOWK2UwfNKwthHti5JyVYA25DzerLIXJF7hde7t0aNDeLGrU0bb3kD0qV+AlLpld/GiNkI/unjfIrMbq+fJ9TqKGiHG0tcsSKzAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zcvk8AJ8ZJwdOZoSCjgTjvmH0CFmtap8fyXWNNA+SUc=;
 b=GfNIjCbAwbAmA6NSeTpiwamgyuEQlQhyuu6GF6obn3t4CaDux0+4gjKb+EgZ9C+mjz9VB2CdbzSZIpCqW19nYrGwxhZroRb0sBqa6eRgBroomgxUiFRzMgruvjkOQWLxoLRVSP9w/CN2FRXRuxF98eGhdGtW7fAYHp7qpB3Ui+RaAHUKcIxDG8rD4o9c5ScaDumtEcS1/55tZvkTJbgvk/8+wcUaUjGgcEPrmrmtNgcRgQ5Iu99QPYS4qAU7eOh4E+hR+3o+e8G6YDp2qV4G2Ks5UZUTTM6+NTayN4i9EC6wSqIgyfPY/B1XEaCgstaCD4AYzX56cdfr+lP89A4/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zcvk8AJ8ZJwdOZoSCjgTjvmH0CFmtap8fyXWNNA+SUc=;
 b=HrVr4V1xFsamFws2bGkDyPQiM8hOdlzna9YM6eU1ksRMssVD/0//WV0l0BJnAl5gWcUxmFpP+D3/NLcKCxz6yRBx01AaL4YiWVvUMScWgRN0yPeTyUdV2h3w83UQtP11oL6za4VrTahkQHGjKGxSVFsh1ZMmgKnsVLhvfd7tdjS/apSP0gUDXSdKn740XNh7L3P4MhXW4WVVZsJydfkLI0Vl+Ba4x351eDSwmF0d6kJWCD64/MLXcY4T4jmvag4BXr/CnnAnZrDGu0g2imHUixs6hwIJajYjsYFDVKjzfXvMWAFPEVaw1APke+gXPel3pr0uvGsFsBlAkOcD1afx9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAWPR04MB10005.eurprd04.prod.outlook.com (2603:10a6:102:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 15:44:21 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:44:21 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next] net: mlxsw: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Mon, 12 May 2025 18:44:11 +0300
Message-ID: <20250512154411.848614-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:802:16::24) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAWPR04MB10005:EE_
X-MS-Office365-Filtering-Correlation-Id: 6442d574-35a7-4c25-b604-08dd916bdce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0C09xjLci/h8tPps4hlO705KbLlNSrLYq0gaZlBovlykrj9HZLFBbWxSM9vw?=
 =?us-ascii?Q?AWfJ0HH08TKKvVTd5DISL5Y+3sxnpvzm/ivnP5wNXZ5VYCi1ajgYcP8HDKpz?=
 =?us-ascii?Q?0pctDvST9UwY0XlsWD8AKgeB7l/zC/ImFLcMmeG4MLMTKamIbUbLlPvWkmlw?=
 =?us-ascii?Q?un6mqHmm1lst3OBpFwpE5MwRfDJKmEmKejRsFmLWEIQRsKyLdtQrMm3L3pHC?=
 =?us-ascii?Q?I80H0nWHMDBrEcYWWWnjeQWNGuWa16Y92aR1UkJsWlzIBE9fBR5GZB7kHgMy?=
 =?us-ascii?Q?SV0oB5wm7OS0N7YS++/GscF0qc/k+lo3Tkw1MdotRHhXKOVVC8Mo1+ONe++T?=
 =?us-ascii?Q?F0edPV7pIIzuGWdsPpJyiExYEEWGRIWQu2nw9ym1PgT3WNpxesuMGsLL2fei?=
 =?us-ascii?Q?zmivNZkATMyLR7dgmJ2C0aBqxrmpeoq3SXVgnoQhY2TrV87nbrtcR9yXTVhj?=
 =?us-ascii?Q?8ZrK5g9/859kjF4UF37yJNXElN2kctxZzug27NFa00XnBJHfKKCJTQQ2kF4p?=
 =?us-ascii?Q?h7zOv/WL0RaJiDwarzRaI/bxehby37YjonQyuku5Mt9nqPcVtp9yYCtDJ7IS?=
 =?us-ascii?Q?Y+gU7TJwKgJQkhjOQ1JU8+aiPgLTUbgqg0Hx+So2Y6ZAGhZ7KHiAkfTrNjpS?=
 =?us-ascii?Q?rSrEEAIIFaQTthzINmVS/+CqJHTx/bFxeoIvTle4QtmbnpqsMNNfahx0SFiE?=
 =?us-ascii?Q?ABw1NMkS9c6nKzV2s5Kcx9HojYOnsm3zahfWDvoAelLP1I6P8ljuNzlf3JJQ?=
 =?us-ascii?Q?d4tMX69unv2CgFQpamv52Nt6kWenxUhAdVAbg7RUImucVK1ss1qnia3agUME?=
 =?us-ascii?Q?F+iDB96HR3Iejvj7ECqFxpCmEoPPdysQu9nAJtrV80HVFpNa8p36T0WDYnNC?=
 =?us-ascii?Q?wtyXT4trnEd7Uq/zo1/YAty7mjMfJjm2bI+hXETTP07UhrA/ozlG8qfdJV8H?=
 =?us-ascii?Q?YTB7wvMzA224gOGaDK4OPEeN2BKU6xOdmP/WfTo60jIS4dOqojHfw0N5g5yB?=
 =?us-ascii?Q?ex04pGAQ/95lyrnOFMRVVsucSnQ/RSUwtRX0iRZYTJ8REee0/tnqjuestsgX?=
 =?us-ascii?Q?edn6mixx03hJ1su7LoAjdbLXDk+tPcFIfOcimoU+GcwYndbi2uCAPccGve53?=
 =?us-ascii?Q?9VliezdhLAymNWDarkPhton1Dnsgdl3rg7eiELunw2+exx7fPK1wk8qlviJt?=
 =?us-ascii?Q?uMyvmFnscZNiugeb53x65241Y4JZnmRO3O/7OqTXwM33pEFHmQ61xBODjdyC?=
 =?us-ascii?Q?TzdBUETqkWMzoXsFyvLAfg8Y4nKAneA16v/o6dBTdet2hgJWgK7dzJicyLAc?=
 =?us-ascii?Q?vdc2JIXiQN1u+nRfcQz2e9DSvbMCprJ5l8o3LjeAnUtINnqE0zFUXPAy9CSi?=
 =?us-ascii?Q?hmRXOoh67WiaUl4feARkDbqc9a0ae49/UScHDJzGdJt5ThOTu8X7DRH5JNQB?=
 =?us-ascii?Q?dO/wA6rKZXMd23HzVxGkeitqQB/Wuh4FtYSRuLpivdZ7rjEpXxB7eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZ0u26X+fZccp8vx8VctK3p1V8KHzS5M16tLGAHrnWidZ2AfZs5FxALZ1pBG?=
 =?us-ascii?Q?Bx0F8GXiatIRd43iLwRdFgQGhIz3G0yntVAhVD0lJQOzExVMB/EX9tOAJ5Zd?=
 =?us-ascii?Q?np/Lno4M/U/z9v39ViMSGV4uzdJkYevr8SCe6NqYBBcj//CDFwO/cik97mvo?=
 =?us-ascii?Q?c50KnieBFexPYJxcBZhlNcZ0ZkgyPjWmEUUfixzVPsk25XV9uoavqAkgFm/x?=
 =?us-ascii?Q?iljHODJCAvKEyvjcW/BQ6E6cEM7A/isV4KpqCKb0paENQHrnmjSHlXPo0D7/?=
 =?us-ascii?Q?rhm6WWogW+Yfi+giQz0cJ05ZbgP9u6f8aHz18mgZhzVIudztVUwZsugH/mXQ?=
 =?us-ascii?Q?GXW0Omu5S4pRgrmJGAGt8m3Q7S4vEJ5df2W7U2nMUCZ44r5PcWXfiRH4J1zG?=
 =?us-ascii?Q?6c04cR/b5Fn+P1NsWyFl+ExC6ANmb59FCQO/KUD9LEW5vMKGkpZVL/vlhppB?=
 =?us-ascii?Q?DPFk5Ig0foSxFaxDQsOMnj12oUtZ3fQjgDx5IoIckuzDwh1pRpejtiUAhVCC?=
 =?us-ascii?Q?7mUP6lpyr4clpM+c6d3Qv1/04uBCDpvxbVQHVx6S5/iIwWpx9zMzGBeYXV4t?=
 =?us-ascii?Q?9fCVjMFEC8F7ReLN5QNrlOikIo90dwPyCqQiYjk3P0BrTIzB+G6zsGtW2J8p?=
 =?us-ascii?Q?B1tsHDN6JGyOhSLHfQaza78BpIZ07biPsCXulOXFYu9bUTMthIgUmdqPV07N?=
 =?us-ascii?Q?uW/zk9GTE7brkfw3SWHUf8PH9FlTU5TNjzYeqxEPHVNslNJdlZL+QwkZzHuJ?=
 =?us-ascii?Q?q0R870fwsmRO4vZR+Kq69Yl530JgNyw0xEqQeXfiZpIe/RTKM7vMZ8Mc170y?=
 =?us-ascii?Q?qIYKVCgLzgmHlpjIKSy0WFw2Qvs7AHlTswROtWJuH9u8X1NFywvHH6c4dEYy?=
 =?us-ascii?Q?QPAfkhtHgyeomBrD+sLa2s3LoCoppDbX+7eg74676BFRqMCIbOZsfQyljhjX?=
 =?us-ascii?Q?P1YywYNHOtZbRK0V3DWYI75vU6G0HwEGVj6QYTO/gZZamycanwPI/mAgnd8r?=
 =?us-ascii?Q?tTaD6dvjpThbCAoKEUBQYOPPsUG6ZzF5ji5hQjVzZd49BscorR1nm4YK9EHI?=
 =?us-ascii?Q?fZlyjnctszTaZl+0k7oE6l+NElrK4KKZ4BGGREwvuppViv2ja6ZIgo1MHxau?=
 =?us-ascii?Q?22TR5bO9lL/gA8bEd6NzjHbtpMJSIzGv2BeCd2ojs9DgcWMs+s6eMXiMQwta?=
 =?us-ascii?Q?D8u9mbuQQ4FIZurtobFBPLl/12fQLa/l5M3AZYLXAotu3VWl/QVqsoKH9jCO?=
 =?us-ascii?Q?V8621VSBnyhUiF2T3foK5zE6lLslsYqwFr7HitT1I0fuxnl+QlONlR/eQU2W?=
 =?us-ascii?Q?pWBrtQbhCDW2mf7bIB8Uj2C3nPRakNdDBbliUoK8o56ZhMVBGDBt84aSz9mT?=
 =?us-ascii?Q?fWNAzIpYPoCeY1qP6cyP0POGjSxcRnleqZTCmEnzh2ozNLmCqNccFRc4wWJm?=
 =?us-ascii?Q?RBxsOLp6zRRyzK53aNyIPMRA3iaArRbKGMB5zRDkB6nw7+JWTLq39+4pt4DI?=
 =?us-ascii?Q?h3MqNTHzAGkHCvNuupQGLnXVtlSj4spcC4KJxOY0UXmmLT6cWO97sytstR6/?=
 =?us-ascii?Q?3FKPOqXDgx4eP6P9Uds7fvy4bk0OuHlDZJ0GYMcXtNX3NZ0LjfZR5MYjUPX7?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6442d574-35a7-4c25-b604-08dd916bdce3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:44:21.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rqn7jGT9Dg9m+g6vSSsH1oUmC6WN28wtM2NKGZJA7+wLi0HwDtYy+HpZwlAkJA7Ohxkx12DM7STPlO/rQgGugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10005

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6. It is
time to convert the mlxsw driver to the new API, so that the
ndo_eth_ioctl() path can be removed completely.

The UAPI is still ioctl-only, but it's best to remove the "ioctl"
mentions from the driver in case a netlink variant appears.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 63 +++++--------------
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  7 ++-
 .../ethernet/mellanox/mlxsw/spectrum_ptp.c    | 30 ++++-----
 .../ethernet/mellanox/mlxsw/spectrum_ptp.h    | 20 +++---
 4 files changed, 48 insertions(+), 72 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 3080ea032e7f..618957d65663 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1159,63 +1159,31 @@ static int mlxsw_sp_set_features(struct net_device *dev,
 	return 0;
 }
 
-static int mlxsw_sp_port_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
-				      struct ifreq *ifr)
+static int mlxsw_sp_port_hwtstamp_set(struct net_device *dev,
+				      struct kernel_hwtstamp_config *config,
+				      struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
-	int err;
-
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	err = mlxsw_sp_port->mlxsw_sp->ptp_ops->hwtstamp_set(mlxsw_sp_port,
-							     &config);
-	if (err)
-		return err;
-
-	if (copy_to_user(ifr->ifr_data, &config, sizeof(config)))
-		return -EFAULT;
+	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
 
-	return 0;
+	return mlxsw_sp_port->mlxsw_sp->ptp_ops->hwtstamp_set(mlxsw_sp_port,
+							      config, extack);
 }
 
-static int mlxsw_sp_port_hwtstamp_get(struct mlxsw_sp_port *mlxsw_sp_port,
-				      struct ifreq *ifr)
+static int mlxsw_sp_port_hwtstamp_get(struct net_device *dev,
+				      struct kernel_hwtstamp_config *config)
 {
-	struct hwtstamp_config config;
-	int err;
-
-	err = mlxsw_sp_port->mlxsw_sp->ptp_ops->hwtstamp_get(mlxsw_sp_port,
-							     &config);
-	if (err)
-		return err;
-
-	if (copy_to_user(ifr->ifr_data, &config, sizeof(config)))
-		return -EFAULT;
+	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
 
-	return 0;
+	return mlxsw_sp_port->mlxsw_sp->ptp_ops->hwtstamp_get(mlxsw_sp_port,
+							      config);
 }
 
 static inline void mlxsw_sp_port_ptp_clear(struct mlxsw_sp_port *mlxsw_sp_port)
 {
-	struct hwtstamp_config config = {0};
-
-	mlxsw_sp_port->mlxsw_sp->ptp_ops->hwtstamp_set(mlxsw_sp_port, &config);
-}
-
-static int
-mlxsw_sp_port_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
-{
-	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
+	struct kernel_hwtstamp_config config = {};
 
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return mlxsw_sp_port_hwtstamp_set(mlxsw_sp_port, ifr);
-	case SIOCGHWTSTAMP:
-		return mlxsw_sp_port_hwtstamp_get(mlxsw_sp_port, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
+	mlxsw_sp_port->mlxsw_sp->ptp_ops->hwtstamp_set(mlxsw_sp_port, &config,
+						       NULL);
 }
 
 static const struct net_device_ops mlxsw_sp_port_netdev_ops = {
@@ -1232,7 +1200,8 @@ static const struct net_device_ops mlxsw_sp_port_netdev_ops = {
 	.ndo_vlan_rx_add_vid	= mlxsw_sp_port_add_vid,
 	.ndo_vlan_rx_kill_vid	= mlxsw_sp_port_kill_vid,
 	.ndo_set_features	= mlxsw_sp_set_features,
-	.ndo_eth_ioctl		= mlxsw_sp_port_ioctl,
+	.ndo_hwtstamp_get	= mlxsw_sp_port_hwtstamp_get,
+	.ndo_hwtstamp_set	= mlxsw_sp_port_hwtstamp_set,
 };
 
 static int
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 37cd1d002b3b..b03ff9e044f9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -233,9 +233,10 @@ struct mlxsw_sp_ptp_ops {
 			    u16 local_port);
 
 	int (*hwtstamp_get)(struct mlxsw_sp_port *mlxsw_sp_port,
-			    struct hwtstamp_config *config);
+			    struct kernel_hwtstamp_config *config);
 	int (*hwtstamp_set)(struct mlxsw_sp_port *mlxsw_sp_port,
-			    struct hwtstamp_config *config);
+			    struct kernel_hwtstamp_config *config,
+			    struct netlink_ext_ack *extack);
 	void (*shaper_work)(struct work_struct *work);
 	int (*get_ts_info)(struct mlxsw_sp *mlxsw_sp,
 			   struct kernel_ethtool_ts_info *info);
@@ -351,7 +352,7 @@ struct mlxsw_sp_port {
 	struct mlxsw_sp_flow_block *eg_flow_block;
 	struct {
 		struct delayed_work shaper_dw;
-		struct hwtstamp_config hwtstamp_config;
+		struct kernel_hwtstamp_config hwtstamp_config;
 		u16 ing_types;
 		u16 egr_types;
 		struct mlxsw_sp_ptp_port_stats stats;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index ca8b9d18fbb9..e8182dd76c7d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -46,7 +46,7 @@ struct mlxsw_sp2_ptp_state {
 	refcount_t ptp_port_enabled_ref; /* Number of ports with time stamping
 					  * enabled.
 					  */
-	struct hwtstamp_config config;
+	struct kernel_hwtstamp_config config;
 	struct mutex lock; /* Protects 'config' and HW configuration. */
 };
 
@@ -1083,14 +1083,14 @@ void mlxsw_sp1_ptp_fini(struct mlxsw_sp_ptp_state *ptp_state_common)
 }
 
 int mlxsw_sp1_ptp_hwtstamp_get(struct mlxsw_sp_port *mlxsw_sp_port,
-			       struct hwtstamp_config *config)
+			       struct kernel_hwtstamp_config *config)
 {
 	*config = mlxsw_sp_port->ptp.hwtstamp_config;
 	return 0;
 }
 
 static int
-mlxsw_sp1_ptp_get_message_types(const struct hwtstamp_config *config,
+mlxsw_sp1_ptp_get_message_types(const struct kernel_hwtstamp_config *config,
 				u16 *p_ing_types, u16 *p_egr_types,
 				enum hwtstamp_rx_filters *p_rx_filter)
 {
@@ -1246,7 +1246,8 @@ void mlxsw_sp1_ptp_shaper_work(struct work_struct *work)
 }
 
 int mlxsw_sp1_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
-			       struct hwtstamp_config *config)
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack)
 {
 	enum hwtstamp_rx_filters rx_filter;
 	u16 ing_types;
@@ -1270,7 +1271,7 @@ int mlxsw_sp1_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	if (err)
 		return err;
 
-	/* Notify the ioctl caller what we are actually timestamping. */
+	/* Notify the caller what we are actually timestamping. */
 	config->rx_filter = rx_filter;
 
 	return 0;
@@ -1451,7 +1452,7 @@ void mlxsw_sp2_ptp_transmitted(struct mlxsw_sp *mlxsw_sp,
 }
 
 int mlxsw_sp2_ptp_hwtstamp_get(struct mlxsw_sp_port *mlxsw_sp_port,
-			       struct hwtstamp_config *config)
+			       struct kernel_hwtstamp_config *config)
 {
 	struct mlxsw_sp2_ptp_state *ptp_state;
 
@@ -1465,7 +1466,7 @@ int mlxsw_sp2_ptp_hwtstamp_get(struct mlxsw_sp_port *mlxsw_sp_port,
 }
 
 static int
-mlxsw_sp2_ptp_get_message_types(const struct hwtstamp_config *config,
+mlxsw_sp2_ptp_get_message_types(const struct kernel_hwtstamp_config *config,
 				u16 *p_ing_types, u16 *p_egr_types,
 				enum hwtstamp_rx_filters *p_rx_filter)
 {
@@ -1542,7 +1543,7 @@ static int mlxsw_sp2_ptp_mtpcpc_set(struct mlxsw_sp *mlxsw_sp, bool ptp_trap_en,
 
 static int mlxsw_sp2_ptp_enable(struct mlxsw_sp *mlxsw_sp, u16 ing_types,
 				u16 egr_types,
-				struct hwtstamp_config new_config)
+				struct kernel_hwtstamp_config new_config)
 {
 	struct mlxsw_sp2_ptp_state *ptp_state = mlxsw_sp2_ptp_state(mlxsw_sp);
 	int err;
@@ -1556,7 +1557,7 @@ static int mlxsw_sp2_ptp_enable(struct mlxsw_sp *mlxsw_sp, u16 ing_types,
 }
 
 static int mlxsw_sp2_ptp_disable(struct mlxsw_sp *mlxsw_sp,
-				 struct hwtstamp_config new_config)
+				 struct kernel_hwtstamp_config new_config)
 {
 	struct mlxsw_sp2_ptp_state *ptp_state = mlxsw_sp2_ptp_state(mlxsw_sp);
 	int err;
@@ -1571,7 +1572,7 @@ static int mlxsw_sp2_ptp_disable(struct mlxsw_sp *mlxsw_sp,
 
 static int mlxsw_sp2_ptp_configure_port(struct mlxsw_sp_port *mlxsw_sp_port,
 					u16 ing_types, u16 egr_types,
-					struct hwtstamp_config new_config)
+					struct kernel_hwtstamp_config new_config)
 {
 	struct mlxsw_sp2_ptp_state *ptp_state;
 	int err;
@@ -1592,7 +1593,7 @@ static int mlxsw_sp2_ptp_configure_port(struct mlxsw_sp_port *mlxsw_sp_port,
 }
 
 static int mlxsw_sp2_ptp_deconfigure_port(struct mlxsw_sp_port *mlxsw_sp_port,
-					  struct hwtstamp_config new_config)
+					  struct kernel_hwtstamp_config new_config)
 {
 	struct mlxsw_sp2_ptp_state *ptp_state;
 	int err;
@@ -1614,11 +1615,12 @@ static int mlxsw_sp2_ptp_deconfigure_port(struct mlxsw_sp_port *mlxsw_sp_port,
 }
 
 int mlxsw_sp2_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
-			       struct hwtstamp_config *config)
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack)
 {
+	struct kernel_hwtstamp_config new_config;
 	struct mlxsw_sp2_ptp_state *ptp_state;
 	enum hwtstamp_rx_filters rx_filter;
-	struct hwtstamp_config new_config;
 	u16 new_ing_types, new_egr_types;
 	bool ptp_enabled;
 	int err;
@@ -1652,7 +1654,7 @@ int mlxsw_sp2_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	mlxsw_sp_port->ptp.ing_types = new_ing_types;
 	mlxsw_sp_port->ptp.egr_types = new_egr_types;
 
-	/* Notify the ioctl caller what we are actually timestamping. */
+	/* Notify the caller what we are actually timestamping. */
 	config->rx_filter = rx_filter;
 	mutex_unlock(&ptp_state->lock);
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
index 102db9060135..df37f1470830 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.h
@@ -34,10 +34,11 @@ void mlxsw_sp1_ptp_got_timestamp(struct mlxsw_sp *mlxsw_sp, bool ingress,
 				 u64 timestamp);
 
 int mlxsw_sp1_ptp_hwtstamp_get(struct mlxsw_sp_port *mlxsw_sp_port,
-			       struct hwtstamp_config *config);
+			       struct kernel_hwtstamp_config *config);
 
 int mlxsw_sp1_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
-			       struct hwtstamp_config *config);
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack);
 
 void mlxsw_sp1_ptp_shaper_work(struct work_struct *work);
 
@@ -65,10 +66,11 @@ void mlxsw_sp2_ptp_transmitted(struct mlxsw_sp *mlxsw_sp,
 			       struct sk_buff *skb, u16 local_port);
 
 int mlxsw_sp2_ptp_hwtstamp_get(struct mlxsw_sp_port *mlxsw_sp_port,
-			       struct hwtstamp_config *config);
+			       struct kernel_hwtstamp_config *config);
 
 int mlxsw_sp2_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
-			       struct hwtstamp_config *config);
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack);
 
 int mlxsw_sp2_ptp_get_ts_info(struct mlxsw_sp *mlxsw_sp,
 			      struct kernel_ethtool_ts_info *info);
@@ -117,14 +119,15 @@ mlxsw_sp1_ptp_got_timestamp(struct mlxsw_sp *mlxsw_sp, bool ingress,
 
 static inline int
 mlxsw_sp1_ptp_hwtstamp_get(struct mlxsw_sp_port *mlxsw_sp_port,
-			   struct hwtstamp_config *config)
+			   struct kernel_hwtstamp_config *config)
 {
 	return -EOPNOTSUPP;
 }
 
 static inline int
 mlxsw_sp1_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
-			   struct hwtstamp_config *config)
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
@@ -181,14 +184,15 @@ static inline void mlxsw_sp2_ptp_transmitted(struct mlxsw_sp *mlxsw_sp,
 
 static inline int
 mlxsw_sp2_ptp_hwtstamp_get(struct mlxsw_sp_port *mlxsw_sp_port,
-			   struct hwtstamp_config *config)
+			   struct kernel_hwtstamp_config *config)
 {
 	return -EOPNOTSUPP;
 }
 
 static inline int
 mlxsw_sp2_ptp_hwtstamp_set(struct mlxsw_sp_port *mlxsw_sp_port,
-			   struct hwtstamp_config *config)
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.43.0


