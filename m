Return-Path: <netdev+bounces-206714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3173BB04274
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293A91884B15
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395F2594BD;
	Mon, 14 Jul 2025 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="TOQu8sF9";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="bDdSFSlo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB111255F2D;
	Mon, 14 Jul 2025 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505320; cv=fail; b=lW2fw85LBhJAjd3lezIoyeNqqtNgXU9mWrbvQsxskUPOByrIyPqUCjNzx5hjofbJj7uikVh1XEYIVbdSmCJfJrwcgnMsu6SL2xjCwl+fsfwNX1FjjZp69Wfubu5Z5Xr7tHjpVItYXEdrLoD7T5jWJngI4n+V1rKHUAC3kXYvLa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505320; c=relaxed/simple;
	bh=NkdtTR1Y5E9H28htmSECqehG/lPdujQdjSQ0IrG6lgE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rcwPjsYe1uMeUvuXTgQWtDT1XTUW+yVHygtyoFIGMoGsxAE81kvcazFvRqnBHK1F+9OQVELW6KZ8k+GrJ4LxCL6wJUqpkVQCvg4Xwkm3/jXkYEylC2M/vLO2zujU7ejAYkpVMhGvil3ZPtKdN7p170xTd+0fthRUu1Gl2y3g0Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=TOQu8sF9; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=bDdSFSlo; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220294.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EATlnl026131;
	Mon, 14 Jul 2025 10:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=H2l1DKMayCK0EobaM/izTI9B1LV
	VjiglliaTGn15QMk=; b=TOQu8sF908InGCLxd/2bgrcItp5uAyn8uwIr1l0AkiU
	bAHijSWDJmHFyMdRGRNfDM1168k16unC65RzyJWOnTxszCZe22oV+LB6Z6U9BSBA
	QibUNVq4y1Cw9MkJQIclpuhjDfvPmSCMyIY0CDUoHO3rxptnevuDB3Sb8Yae7/n7
	YVF5CTxVAarZPpiVaO/FWiN+p7eSJIDOGmAwB0FDaVz1NAU3dRABIseeHzXMxZ3C
	6qq4QCHdf3iIZP/IL0S+Gs0tLANDhOcfiOrcLH1fCXYT+6w4IcS0VW12WsX8/lAD
	7VjhAm6JwLSGemN6qhdIgZSDdFZTzeYqmv1r+dragdg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020114.outbound.protection.outlook.com [52.101.56.114])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 47w06cghtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 10:01:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzaTDKmbfzousBVhpN06wYpiwF+GHKvDAEovA0w9zz9zsuyvo2wnwWJIhqbNfi+cbRE7p6EFawCbOrgOIhirp7Is83TTKRzE7A+xS7KcVG4PJgoAINUzp2NWnf6bkiFCBMBWad6GZjUMASyjidCAaa1weag0RWa5qmpxhfuKlziMhKkjerYzgIu0gKGcAvayxtFa2iwhnlJ41s3hjGOUCmdspN7sYb6eMDhwZPc8j/L9qhmGHTLGA8DDjvDqLVPp65cepe7sVF948Pc6fTuRZuFukZoMD1OeqWwXH0ex+PX6BsJ/D8IrkqZhXpK+IqjQXRueHSmmUN8QJSgRABvj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2l1DKMayCK0EobaM/izTI9B1LVVjiglliaTGn15QMk=;
 b=yj2SzlzMKjTmezMNt6nnP3l5o7IXcPYqoIa7vQyQ0vevae28xwbl9YZsh6yFBbGToh2H8qL0VRboYqxzwIr62uBa+pG9tRweJVFDn65TC4cLkNex0asYwnGE9ZxTn/753aCBw2LnVujwrcK5M4nUQlzWzUrJUE/MmPhJ236GLa8KW4HE2BqBNdFWaGIvc2KEaMvBwrbtZsKk1/lRPScMZLb5YRdDAUPirV/SoJRVNoXrikhijEGeOMMg/0TmHZPw+f66MRal+tWtQapHkIJzVHxQjHXzo74mGqlWnb92YiQwoLGO4dFJQIpJCeR6+XGvvnv3NfCbCBikqEpy6iuR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2l1DKMayCK0EobaM/izTI9B1LVVjiglliaTGn15QMk=;
 b=bDdSFSloWlDdH7Gzg+TCrRlvRrzS3wUK8oGIGYiuARsY7T+wd9nolqbu4u/HHxYyWCUeD93B6eMxJHV0DzT3LHoOBt5KM3AR7xu8BR3qWQXmuhYBaJ+QioRwhEdvkrXCRhod46M85QQgEPseObPbXE4vyy2e0ZJc3LMaKda+pzLTp4LGpgynU2uIEzomXukkE3pTX3wAwSlrQhEVWgF7gbp8I3UNFteMHBlYnuQVazfZKTIKJbqLvf0DmvyJ0B9qB56L6PhABHj2qVl1DfYRDfFFrUOzloDAen3t52TnToRudi2RN6wyiPkWbm0BKnaAXoYZy9QccKk686ecv4QEhA==
Received: from DS7PR03CA0332.namprd03.prod.outlook.com (2603:10b6:8:55::19) by
 SA6PR04MB9172.namprd04.prod.outlook.com (2603:10b6:806:413::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Mon, 14 Jul 2025 15:01:19 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::7e) by DS7PR03CA0332.outlook.office365.com
 (2603:10b6:8:55::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Mon,
 14 Jul 2025 15:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 15:01:19 +0000
Received: from kc3wpa-exmb7.ad.garmin.com (10.65.32.87) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 10:01:11 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 kc3wpa-exmb7.ad.garmin.com (10.65.32.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 14 Jul 2025 10:01:12 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 10:01:11 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 14 Jul 2025 10:01:11 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "Ido Schimmel" <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Vladimir
 Oltean <vladimir.oltean@nxp.com>,
        Tobias Waldekranz <tobias@waldekranz.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>, <bridge@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net] net: bridge: Do not offload IGMP/MLD messages
Date: Mon, 14 Jul 2025 11:01:00 -0400
Message-ID: <20250714150101.1168368-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SA6PR04MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc78ef6-e0d2-4792-0302-08ddc2e74a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KihUBlLOv3HNEz0oHaslhjSj+p/0QrA/35uz6fcekTWvn3+DfCHSGVK9QcyO?=
 =?us-ascii?Q?2w0ajX3h26nNmoBf/izRrubPF/l9QhWDqOs0cLU7H3pefhXZxPBnSPbgdwM2?=
 =?us-ascii?Q?bGWsmBxni65dnTJzBX17ZvcxaGaQSwcQqVbcyypMNOZ0qPk8gPM+l6mi7rjR?=
 =?us-ascii?Q?2MImhLSR+hySwGJCUuhWLG3C6nVv/ssZvZCApZPEJtrpLcxYj0U5qsBUq/7A?=
 =?us-ascii?Q?P9TbdCUG5y6rrqE8vGZiz8uIGEU7a/avEgMoVa7Y8kCBsITRt7U7T4NxGo6Y?=
 =?us-ascii?Q?CQUojtcthruhRA5iIPcKXlJAcwH8voEnpd5BpzOVmOLvs6oYdaLfcWat1CU6?=
 =?us-ascii?Q?F7Se/P/8an0HI5S+xnkH+MxNZm01iWZ7J2Qw5l5cEi0d75I4gmWlp1k0fm69?=
 =?us-ascii?Q?DbF6P/CwniyZ+SeKwsRoaNtJzeNQJgSF1dui/bnPLKSySjoGdiVqphp6a9RR?=
 =?us-ascii?Q?XoGs7JJoswN+RLAd39bh/zJrGnxmupDDXj9SkMKTvdVmF1rrpF+8ob+dEVVL?=
 =?us-ascii?Q?jVUE2ipo79i/U9weq3Txc0LpoJkJ2N2J9xMNtH8Ck3ipZ21ksdzMmM0kKq6j?=
 =?us-ascii?Q?Yp8B9Y9F7xe/eBPHVrAgoIv2yZ7nYjpLCTItVWqvHPrsP4oUjZbQfQZLAkf5?=
 =?us-ascii?Q?LlqMVzYXeZT22fMxb+jbfFwDO7EXALhbxQU4LCodLOoIw7Hu0+OG1nozHU0g?=
 =?us-ascii?Q?a+bozAZbCp/6u3XTwbqeaFFYsuIHpBXBEkBiYyu9G4sgwrazlY1ySdLW6kyQ?=
 =?us-ascii?Q?VJLuVXwRff3uGRRQdnxn2oRih6qWy/zVDLljnR+Yg3nkyTp0y/L4oRtGROwz?=
 =?us-ascii?Q?DEraDxhT4Zmm+V3x0wrKShY2IzEVmRtdeNM09Ta5o5EGFGjoPcMD75pT7AS1?=
 =?us-ascii?Q?too/WkKeN+0Vsud8denjAFnkyz+io5mUzf/P9vjBYGsCNjXHMVC9WhyQtCvo?=
 =?us-ascii?Q?JqbJxqqIgKzs9Y/P7hLfy4dbDxsGhzHrZNYZ3vRmjYUFngrR188tAZpcbI4v?=
 =?us-ascii?Q?C32pb3nX+opYFyYBwGwTuGjmqxoTualKkP40oR1WODDOix2JyEVUZRGOwXy2?=
 =?us-ascii?Q?gmKvKdkZIv7t61ZPAg5SYH/vyObYccFggcIqptxkpVkNzVhvAAavcTfBq7pA?=
 =?us-ascii?Q?TL9QyGLMWH5/uZUVMuv9R3qjkAhjZjO7VkDRpORqVP6c8td7Qtru4+XypZvm?=
 =?us-ascii?Q?wGCIU/sM9brLJ4sX8PVhigAq7kq51Exw3SnZbuiFKYd6ts01nBtYoVEdxBdD?=
 =?us-ascii?Q?IVbMJZaqEYHZdVT79HjpauezKxpn+hQwey38nHCsdxvQJpBxWwa6EUOWFXmc?=
 =?us-ascii?Q?6tTC9MoeDRmOwKofB5u8NwuPdHWsWdDoOxvONdbCIuseSVS4b7xWuYHfs0Si?=
 =?us-ascii?Q?xzvScrGfTaSSgBvnpLiMNmrpBCTUu5qGPiD/XLn4Y/qxofsDyx2Sm+PCC/ja?=
 =?us-ascii?Q?NHMwFXmJh73PYdv6oQcTFbw/DohNVSqjfrwA1RozXL+m3A2kvWhWZjmsctEt?=
 =?us-ascii?Q?JMa/zJpsEs2rJmLsae7izhtYXqHN0zSLiZWznqmU4KKCnVcj7uhKcd/PJw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:01:19.1352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc78ef6-e0d2-4792-0302-08ddc2e74a14
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9172
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4OCBTYWx0ZWRfX838CKCwy/udF iTl5VvZt91+EnVdaSg4Bhvcf+EutHnecQvO/f899Y/1lwHwOAjULfVwTleSGIK8Vj40zfbK5WdQ d80anmsM2QuG5PuvxBNcaF51JFQkw8O0mqHawP9jOURRiWYWfbqEZr22qGP5pKdQWzut+NAojU5
 ivlwFrErGPWwWTRmt8m0PZbve2ruJ/x5iCtGpxcs0PpmHBnFvhwGp5WzVOcP8SibKRh0ilkPOt3 YTrlXEfLjtD53AsHgeXfgRFKn+qliPVBp9qEy4Z8SNj9mQnrBWjF6RsKIKSrjCJAbRg5ldMvE5w aj1byQBDy2S3gfuCych9X6SrbU/NNlBPP+bQ5OjcsF+g3DX+yzHANyiatwpWbTauQFowd/r8BY7
 hA+o9kLOXo+CbGvajm1Th9Gdkf9IQI2xAMvhHKp796NkWwhMkTPDWf5L7aJpe0LDF+btODw6
X-Proofpoint-ORIG-GUID: 2vUtdPBWgKB_X3iZqhjMYovEdJGZlHxO
X-Authority-Analysis: v=2.4 cv=YokPR5YX c=1 sm=1 tr=0 ts=68751bc4 cx=c_pps a=+29CLaFxg23VDaVrfDag4g==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Wb1JkmetP80A:10 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=qtsO8U4T1x2-kSsTHH0A:9 cc=ntf
X-Proofpoint-GUID: 2vUtdPBWgKB_X3iZqhjMYovEdJGZlHxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc=notification route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507140088

Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
being unintentionally flooded to Hosts. Instead, let the bridge decide
where to send these IGMP/MLD messages.

Consider the case where the local host is sending out reports in response
to a remote querier like the following:

       mcast-listener-process (IP_ADD_MEMBERSHIP)
          \
          br0
         /   \
      swp1   swp2
        |     |
  QUERIER     SOME-OTHER-HOST

In the above setup, br0 will want to br_forward() reports for
mcast-listener-process's group(s) via swp1 to QUERIER; but since the
source hwdom is 0, the report is eligible for tx offloading, and is
flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
well. (Example and illustration provided by Tobias.)

Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
v1: https://lore.kernel.org/netdev/20250701193639.836027-1-Joseph.Huang@garmin.com/
v2: Updated commit message.
---
 net/bridge/br_switchdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 95d7355a0407..757c34bf5931 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -18,7 +18,8 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
 		return false;
 
 	return (p->flags & BR_TX_FWD_OFFLOAD) &&
-	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
+	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom) &&
+	       !br_multicast_igmp_type(skb);
 }
 
 bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
-- 
2.49.0


