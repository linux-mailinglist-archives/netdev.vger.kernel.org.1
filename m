Return-Path: <netdev+bounces-179217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E206A7B275
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BBA178BCB
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75071AC44D;
	Thu,  3 Apr 2025 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="pUit0k7M";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="PkQhS004"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B52E62B7;
	Thu,  3 Apr 2025 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743723942; cv=fail; b=l9fSm6ZVEnTZa7pX4u5k38uWoBgyHdPWidTabm/zMaJa4h9T33oQGV88hiY09/xh/0dtdfctvxSudAgu6UFOf8P8k1GBZIp2WqhDFXu/Owa7JNQG2L1b4Uzb60LRG1/+WMdhUz50w73uABzFzYk/SV78weGDtXQ/er1IYev9rXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743723942; c=relaxed/simple;
	bh=54QcAFksLh0hWDl4X5KEUrD5IS9R8kuV0wdwi7uRkXQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ORc1+XcKwkg3sSwqhmvkKcgxLjeAoTpmSypxD363Yzz2lt4bPbHtu0ZAN2KJftBuSq1OtDQDNXmi/9uQ99bawiSSRzahoFe4WFZLpgxp7rmB+v4PYyfHARIiaER8ueKP56xV94gj7bc0frV27Fv37TSKm2EdhOxnIxSdz76csqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=pUit0k7M; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=PkQhS004; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533NVQGt016913;
	Thu, 3 Apr 2025 18:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=nM7kR9eWu+hZSsBtsQIEv0NJ71F
	te3zT3VyKlMws3uM=; b=pUit0k7MpWfV8y7Qkff/Jj0JXoSDWlCucKy67oaxjPo
	RxbpQKq8VVOOpdAxoFoHGkMZEAmJf03g1mYDUYu00sI3c2cktVDYdl6MtHq63Qx+
	FzZpWSqgjOlWRKyo1xladntN8p6ERjTiCBAtyidDY+tfaZ71HIcxPom7nkRjaeyy
	0eQwWQ+X2V50GBkR7i81LTL6jgR8/i0hMeKbbFbDoGfjw8RRrcmoSn41iVWeSoik
	c2y6dtD073AgByzDo+aIwe30YHkiOxRswCm68JZ/SEqcAX6J/2gW0xm5CgpIKvtB
	6uFCxgGJ9kOSpnOZyzZfxe1f8UKHdygA98fMcmxzbxA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45ssgwhbu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 18:45:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BY0gy7soTQjpfrJSfB1mtF6pDoX83I5RjVz5D3jcrDAmzKdj5gfJ5efdyip/84meVdeyGnq3jqPIm/vsNJP+8opqQAbuKN4P+02s5BvuKE5BPziFPwhfpm/fnQXqy9BpKlbiWIkwgrskqbuhfxI00Unn87B6mLy+B24DQnMVTa3xE/GueioNTrq+6xYNzI0olY+4Omu6dmktXpu9OWqkmLQezQc7yUP9/A4AfvmwHnTqeAQMLmHu5s9GBrqHUb3Mt/aN1Ljj7R9g/jxBWhGQPhtBfcCE7LCZOo6QRCATQAc2yT2boJZ00op5WEWnp85aMKxndcLYnd2rjgb9bBWEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM7kR9eWu+hZSsBtsQIEv0NJ71Fte3zT3VyKlMws3uM=;
 b=HZtW6gqk6IAv0hQIxamxytXY3H8gUH70A3r4WIiYVq+cyiXF0EUYDz3XDIe3gEci4MZL4Q2AVU0KJXVq9ybzXmJvcNx/gOeNgAq5/DZwtPMSTVD14DbHp5ftsoCay+OpZp5SiV4CcmdAUERYBg95lBIS5cCd+6zmkHNcuZe+CU8NRB56GCw6Mz+iQeC7N+9TUekmPCGCg8F9sxgWwzw54Py/FLshkQ9bQvO4CzZy4hDYAW8aFz8eYeLlSPcYp9E8tFhEs9Bb6KI1jdD7siYOBoUB24CIiPxfX7+NxDb019IcC9siR90QdZ7+eewZohoqftlyc2vYN9AqVFIaiAv3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM7kR9eWu+hZSsBtsQIEv0NJ71Fte3zT3VyKlMws3uM=;
 b=PkQhS00490uN85O/ogKXcuOEfNhEZXHbi6eCtIaRXOIy9WjS+jVj3vZKEvH1zNr9oMObbpRHDQnJ9FmODq0in66ktlwMTTg+ezfB4OqvfVvOdgq+mwtIN6oqg9V7xC8fMIjhhgZo5unwhKJTZkfp1AwPoFvxjxf+//YkY0vagmEj7zSD120F68WAZ1KFRBkkj2lBsmdNILCTG9eadtzvzsebY15m/DnYFApyb3YCDlMZtFyADkvda2s6N6lqGd2NW4kxpxwnBAECoTT/X20FzGqgjSYco3Svqi+Ie5Qc1Eh3ORaas/KVFEyp0Mg94oAfCh/PYUJXTfcoRsvRtVKd7A==
Received: from PH8PR21CA0002.namprd21.prod.outlook.com (2603:10b6:510:2ce::16)
 by PH0PR04MB8323.namprd04.prod.outlook.com (2603:10b6:510:da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 23:45:06 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:510:2ce:cafe::68) by PH8PR21CA0002.outlook.office365.com
 (2603:10b6:510:2ce::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.6 via Frontend Transport; Thu, 3
 Apr 2025 23:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.2 via Frontend Transport; Thu, 3 Apr 2025 23:45:06 +0000
Received: from OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) by cv1wpa-edge1
 (10.60.4.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Apr 2025
 18:44:59 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 18:45:02 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 18:45:01 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Apr 2025 18:45:00 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu
	<roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bridge@lists.linux.dev>
Subject: [Patch v2 net-next 0/3] Add support for mdb offload failure notification
Date: Thu, 3 Apr 2025 19:44:02 -0400
Message-ID: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|PH0PR04MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 02582396-9b63-4375-c0e8-08dd73099018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G1yu93TzM5tG3fsQkFnFrw+oSGLQnfegv2g61sX4Iab3CEwdsF8df4BgKkd/?=
 =?us-ascii?Q?NxxSg0p2QfGxCseylxFnMmQgZA2zWus6BHkIifQDJNocqOIf1Vam7IhUMvVP?=
 =?us-ascii?Q?MgBXiinRd0+AWbVvOYDUxuusw++cSqF/rhV1Teitmwh7tEmaEEBSzaN0i3et?=
 =?us-ascii?Q?KNme3V4dv0wD04z0Eqkviagi/BQwWvvgfEhRwUDNp3N+xObOraChzSaVb1y5?=
 =?us-ascii?Q?GB+dzl8OU6Cxe9hhPgPrxYiypnSwqj6hzlD5Zc9BDaBvbSCG3KJCU/aUc3dI?=
 =?us-ascii?Q?+qM/MKhS7EaqItvNgOPEpC5FUfXdeIcqhvR+IF26xpLZxhntSbeYNBr8Cm3+?=
 =?us-ascii?Q?5Uisujl1Uq/rqCuNkwG2jek2a9nnaL4jjKbkPktnJtx6kGRDM/qtG7001xwW?=
 =?us-ascii?Q?o8ynYUPQC5pEiHd+zzlkwwlAN4ZqI/xCueE4zR5pRHtar7FCVyMUQDUgZavE?=
 =?us-ascii?Q?HLNGz4KW9pJUc7JaotUX47w9hqMyxksLRdY5+43JcTMGPy2BtcWJkJxohPH1?=
 =?us-ascii?Q?0wYdeTkkoJceCru+DVfbvlF16hW6/VCxezpSCHRVaxtPpUk8tF5yQWEuWUod?=
 =?us-ascii?Q?ahwT1FrL+ggFkyOAI0oy+c1rvbzep4DQv4xu9tOq+ZN/7dl/FQKGeHgt1/+B?=
 =?us-ascii?Q?iEpNWGmUZDavtLPDGp7A6zq6F3R6FneEUkYgFxdCkZVTFU3OGTqZDxEbOZ1R?=
 =?us-ascii?Q?AXJNF5o96KWamYQJtDGGeY6Minkwcih6xkoYK+l7YduBbqFP/5VPZgjZ97xW?=
 =?us-ascii?Q?XDw7nPsSwI2SGJ0RIr/bc53iqGNVqauJUK/Pt959pP4Y5KhHVCoBLEAC5AVg?=
 =?us-ascii?Q?v1g2DPS53IMDA+eDzUA0hTVjeNTqOm2O2fYgDnsBJhkwmZLz9E8togrL372V?=
 =?us-ascii?Q?sOmouruViwRtOlq28Rshm4xZ5sh+ReTXaX6p8urJR1tvUBGAWk72UsTmEhXI?=
 =?us-ascii?Q?e65zF+h5yNx6cg+qE1iZLdkWDiDrkB+iOx2ju6byrGjk1dxuKyzwXhJwmHcF?=
 =?us-ascii?Q?PWzvd2HD72/duG6Ml24j8OUAsjJhTWP3SsSyigHpHExzgDb0SrPR/iUilGOW?=
 =?us-ascii?Q?KsV1/VRiTfZWtM8g+4/J5HCMIV8yzHdFIvLCZIaOGuKh1x3Zq3HM0euNprOq?=
 =?us-ascii?Q?m4XAJBNJu+E8KcRWdkPs3ABN8Istikjzx8lcWRmp3HdXCA2tW/zBWlR6ODJl?=
 =?us-ascii?Q?p/vHCiyBbq391s4pzSKsoxxuttpCxJqFQmGnsyHbhWodcMAgQG1CkYf3CV7z?=
 =?us-ascii?Q?YURmTv2KiVpHp3lhhmwz15wvWxzBUrOqRdNFuwHqzcQLanKDuV8r3QIShCFR?=
 =?us-ascii?Q?DZYf2CO+4OaA9DOn8E/zEv1Q6OeNHdc99CewHc+/tRXqbJr1LW8SbBaSR5/G?=
 =?us-ascii?Q?ZnKPfyloSK1lH0hdDPygVgaM7PAFO/BATjXnxMqVRa4GQlLVsdlmhFi7rdM9?=
 =?us-ascii?Q?Wl2PwWW+Wu6r6JQDsqgDWS7J0zsRW6/i709GXO8dau8V0TPT0VVSKD7DkSPM?=
 =?us-ascii?Q?3epbqARGFCT4d+U=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:45:06.4330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02582396-9b63-4375-c0e8-08dd73099018
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8323
X-Authority-Analysis: v=2.4 cv=OcqYDgTY c=1 sm=1 tr=0 ts=67ef1d88 cx=c_pps a=v3ez6FdVe4RSF1xj2bRqRw==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=nms5tGoDfQjFp_ETsZIA:9 cc=ntf
X-Proofpoint-GUID: Piw2x3GElwDxfURN8Lx_SDMtKt_BNwV1
X-Proofpoint-ORIG-GUID: Piw2x3GElwDxfURN8Lx_SDMtKt_BNwV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_10,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=893 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504030126

Currently the bridge does not provide real-time feedback to user space
on whether or not an attempt to offload an mdb entry was successful.

This patch set adds support to notify user space about failed offload
attempts, and is controlled by a new knob mdb_offload_fail_notification.

A break-down of the patches in the series:

Patch 1 adds offload failed flag to indicate that the offload attempt
has failed. The flag is reflected in netlink mdb entry flags.

Patch 2 adds the new bridge bool option mdb_offload_fail_notification.

Patch 3 notifies user space when the result is known, controlled by
mdb_offload_fail_notification setting.

Joseph Huang (3):
  net: bridge: mcast: Add offload failed mdb flag
  net: bridge: Add offload_fail_notification bopt
  net: bridge: mcast: Notify on mdb offload failure

 include/uapi/linux/if_bridge.h | 10 ++++++----
 net/bridge/br.c                |  5 +++++
 net/bridge/br_mdb.c            | 28 +++++++++++++++++++++++-----
 net/bridge/br_private.h        | 30 +++++++++++++++++++++++++-----
 net/bridge/br_switchdev.c      | 11 ++++++-----
 5 files changed, 65 insertions(+), 19 deletions(-)

---
v1: https://lore.kernel.org/netdev/20250318224255.143683-1-Joseph.Huang@garmin.com/
    iproute2 link:
    https://lore.kernel.org/netdev/20250318225026.145501-1-Joseph.Huang@garmin.com/
v2: Add br_multicast_pg_set_offload_flags helper to set offload flags
    Change multi-valued option mdb_notify_on_flag_change to bool option
    mdb_offload_fail_notification
    Change _br_mdb_notify to __br_mdb_notify
    Drop all #ifdef CONFIG_NET_SWITCHDEV
    Add br_mdb_should_notify helper and reorganize code in
    br_switch_mdb_complete
-- 
2.49.0


