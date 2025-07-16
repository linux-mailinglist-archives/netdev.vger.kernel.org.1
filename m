Return-Path: <netdev+bounces-207513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DFDB07A1F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB1118827ED
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2332641F9;
	Wed, 16 Jul 2025 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="JJv1Drvg";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="Bc0fXQAf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885852045B7;
	Wed, 16 Jul 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680248; cv=fail; b=gPeJACvvRq2sl/Tsu9aTEuddW1oURs1odFYmBMjRMiltUi5SQRIl5Xb+vs/PG19X9MUPdAzYW1XBsBvCSiXX5bhFks8BC6D0vlhgGbR0ny8ba1F+i+HA2AmY9+negDD8DkORGcJE7JSeFpNy/l9U0HQD9/2Xo4Ua8wslexZKhZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680248; c=relaxed/simple;
	bh=CD4GQWBIQl/TMmSR076wCfzOJnQ2Sge+izjbiNjPPms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qDep63d86K068T/qjG0lkng+f0ww/F8s4Qh7ak0JnqjCkM7akWDrfdIu2uWea/wdFDi6P9shHKdkqQhE55AXpmUfoemOeLxQo2gG6lNJCuGV/XRd8f3fB1uNGKTWhdDBOB9ZHimYqaTcTO3I/sZDzVRBjktdANPVPnRbzKHohng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=JJv1Drvg; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=Bc0fXQAf; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDYdrh011775;
	Wed, 16 Jul 2025 10:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=9o07GlgU9fBL8vxCIs8bKK+HhN6
	rBf9whs89car8qEE=; b=JJv1DrvgxXNV4ZjMVmJ2HOPvpP+aMgapUfJUH0Fy37t
	CuULwSgi4RjiF4iE1OGqVobarNc4Lx0tg2ph55daeFnCoOyAyUpu64UnldSERbu7
	sw17dXFX3E0Fxb6MpuC8jbJn9ijzn38DwWV/lYu1g+DYDRaW82rHPBaQU9ERpuev
	sU8PQuU5bHV0rezVuyXHdZMpwAwiHJjNsLGKYSLbjI0N7ePFakGiJiTzo1/pA28+
	pngtzWmVW43pLiRxoPQJvX6+rJpeYsK3PyaaY8diPXQM+H6je5mtXl/tZslHbKHC
	Xc16JQkZsJg7Ki0gvBUDc8g7pzEPTg+lBIx3A1adMow==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2105.outbound.protection.outlook.com [40.107.95.105])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 47xd3109t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 10:36:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE+iAXUfy3qxBpoOviur7UpL1ZBuiwcoquiNrPCQBsYkLg0X95AE/CJuEA32Qf71vQUqygOf9MGHFDuyYQWBG2pkx8Szyf9QejwY1ZxiTcwMmpPDRjvWwxOg2jiyeEXPOvBJXMc1Mi99RYH1veOprcmDh+WzO8FCA5xnRdL6+XQNbbUFrhRswAgiTB9gyWuuJm1rrWhCN1+2+/Hgwibo3fZyFJWeFLmJiqi6xOWQ0qIt8Uz0RHJqyYlpQ/Ciqw2udH2KMlhsF2O8yWkytd3U5jtq0OgxM5p4/bjd2n0089tbA8szkjAMEgocUVcIjZM/EQPUHRaPs9T8/sqUR0HKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o07GlgU9fBL8vxCIs8bKK+HhN6rBf9whs89car8qEE=;
 b=ryO60i7/+7XoWLrCjTzxADl2QlljM34bydDz7e+9cJZV92qNJVMVXcM+34nuCbPos9xtwsdEs6xQ4a+PRlEWOiSQDaCVIVuWEzCCI2dbttr+2Qw2rN5SgKAhcW6fw9lPd6uvClRwjEOtL62mRsMzOeKAWI2Hm2ePkbGY9PBC8XSc1qoDxm/aHuyi6jKFnelach/osJtVVFq+978/STE8nBZbs99Uh7ajFJFzFKFRNjDDxTDVBCdtoO5Vi18EBsLsCRuovxCOG1dSEvv0jrN5DSMRS+g599OSocC62hByNwfXM/SZBHemP58aGDgywBYn7jH01i3X6D5kj6BmtY5rMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o07GlgU9fBL8vxCIs8bKK+HhN6rBf9whs89car8qEE=;
 b=Bc0fXQAfOV8CXKd+YihBdpNraTU+h1MfrC7tT+EziGYmRqnfFRvBq7Wk2YL0u1G0NPYMUuD+MwfCCWNBL2VO3H3JHB/Ql5YRNlKi5XUsBtgRX9Yk9TooMlHiyLirKmFDyLlbZlrMQz2ccp18WWoa7zkDoNdOIODmqy7yLctW7CbirjAAnnPoRvX3wSit5h9Er01/9vOubsUH8u8z2nFho0nW8Psi3oL6ewuLIlwPhVy4x6jjnjiIE/2ckIANBf4f0y4NkyD7e15Hlv40n0blt33oUMVyuEBA/Cj3b3SZR7ejtn7473gMoUUEd69KPCIVunKMwhUbyX4rteK+gNLSqA==
Received: from SJ0PR13CA0065.namprd13.prod.outlook.com (2603:10b6:a03:2c4::10)
 by SA3PR04MB8978.namprd04.prod.outlook.com (2603:10b6:806:382::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 15:36:45 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::8a) by SJ0PR13CA0065.outlook.office365.com
 (2603:10b6:a03:2c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 15:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 15:36:45 +0000
Received: from kc3wpa-exmb6.ad.garmin.com (10.65.32.86) by cv1wpa-edge1
 (10.60.4.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 10:36:29 -0500
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 kc3wpa-exmb6.ad.garmin.com (10.65.32.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.26; Wed, 16 Jul 2025 10:36:30 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Jul 2025 10:36:29 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 16 Jul 2025 10:36:29 -0500
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
        Florian Fainelli <f.fainelli@gmail.com>,
        "Tobias Waldekranz" <tobias@waldekranz.com>, <bridge@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 net] net: bridge: Do not offload IGMP/MLD messages
Date: Wed, 16 Jul 2025 11:35:50 -0400
Message-ID: <20250716153551.1830255-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SA3PR04MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fb5436-9a5c-472f-625c-08ddc47e9219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9u/w+ot2LJh2GyC8wUNFoCpa84SfnI8ntBeJFYstApkUNrkVGzK3A6OMGio7?=
 =?us-ascii?Q?HAXB8dkEpxC/cNrzFfcUgGCzV4lPpA4/elbzKEMYDlRn+mXgtwND/ZT2gYPo?=
 =?us-ascii?Q?JzAPmkJQtrMM5BoUQBi/z/Ng5rkS8DJ5n6CKyiUy8+Y2RR0E8+/ZD+yqbyrS?=
 =?us-ascii?Q?3kbqYBo/OZ4gW62DCCLwfsg/v1RcC40XMmJr3YvOxwndkhaIVdAM2DGCqBOW?=
 =?us-ascii?Q?hTjY+CDI6NxeTP+K7WQxdfwCs6BHBk1IbFwRFOjyim1tRcsV+hvlhkjnoHFN?=
 =?us-ascii?Q?5dqbq1vRAoYnnuyMy8mnKHGrtE5+Wmr+elYEPj0k5YJxXBpFbT3ROsVD3i7F?=
 =?us-ascii?Q?dG8dVZx/G6aX+UXACdKuqVHbyZBrae8csdExjNQAXFuupwipTXG1tUpWWP8k?=
 =?us-ascii?Q?dz66A5m1PCuGewckIYMnuNR+V8ms652x2gAPL0FrbrgceyIqmUZVGvJMlu5a?=
 =?us-ascii?Q?JSmLlphdbo3IpP9hnKuFxc/EXhnNtl37AiH6R0G+TX1gIqhg1NXU+OZGKD/3?=
 =?us-ascii?Q?mBz+O1wh+8oQm6XuWx7t5DqfMxaIGfnm8bNq9c730gbWNNHEcFMQwBTrFgep?=
 =?us-ascii?Q?j06gTAeqLlqRQk3YCIq/EORXZHyt9+UWvSywDAE2tHSMNfhsYVY9ZYL/FSOM?=
 =?us-ascii?Q?5fclJbo7oBf+WfWLCvQ6UIRqYKmvA8WNS+RbdW64FNRSDAIgRb2fju5TEh21?=
 =?us-ascii?Q?Nu0SxlGg1Pk+Btauxebkunt12kS0fuL7b52DpXye77eCRxr0qDCyaG9AQIVm?=
 =?us-ascii?Q?dn08zCi+HF99yjsnLeU0L05lr+hEYOFb+cDiLDpFW9qWjpJ0kWJPZix0MAfw?=
 =?us-ascii?Q?wnSbhia7cq2B6vpVRY03IAxyONnKLXysPVshE3MZ+UkrCl4/BZ0ZoadEGiD5?=
 =?us-ascii?Q?96gN29VJ0qH8GgpJWyTYYzSWeEotBN3frDb3ZX4xsob/7NjWuIDoqBgmjesN?=
 =?us-ascii?Q?2nJYZUyM+eZRddn+ThUzNr99sm4JxTWOGHAJaKbILOqzXrscmISdyBqR7uO4?=
 =?us-ascii?Q?QZxEbdI5vEKX0g62dF3Mzs3tByi0cT57/LFpfSlh6PiUAGgIujExrYpvs6QR?=
 =?us-ascii?Q?63H3WwGM3Ds4Ic9xXIN92mUlmA9NxGP7ZfEjOZzAl6bfEsdlpSZTf64TGZnC?=
 =?us-ascii?Q?IHg5gLDYoiOS9iUXD2Tj6AwZr+2Ya+TTD1sPuDbVkDuDLNFG0rv5Vc/V5OnX?=
 =?us-ascii?Q?bSk0m7BwnyDdHwjVOTTLjzBcjB3KEtu6JvlJJA/frnG5IK0WarY7yoO5PEdA?=
 =?us-ascii?Q?l+R9ftUhLNKOtnEE/AnaQrENW9k2wfZshkEWcYCs2OIimj67sDJgo1fhd/ge?=
 =?us-ascii?Q?Jb4OhCNkRni+qFdM44kJvEyrTwEkb1iFEKAu60wnDwyG5rM0+o/d4RDADA67?=
 =?us-ascii?Q?GOn900pSMk/cM+8x0LWcZ+/Pu8ntdqILGezCHiFBLuFQbGMgL6N016GEHg3r?=
 =?us-ascii?Q?MthCHgl/ezbY0byVBbHH5ilfSexTwOijVKxOE1HKNSQj2mXrxd4VR1jj36hJ?=
 =?us-ascii?Q?6j+zn1OkE1vDsfftfrZAJKUhPck7lPY5PgTtWGFylqWgVXJvMFPQns84uA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 15:36:45.0920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fb5436-9a5c-472f-625c-08ddc47e9219
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8978
X-Authority-Analysis: v=2.4 cv=PoeTbxM3 c=1 sm=1 tr=0 ts=6877c711 cx=c_pps a=9OTTZpjfxByIXFTGz5ZA5w==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Wb1JkmetP80A:10 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=x3fvyDcQ3smC9DqSbicA:9 cc=ntf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE0MCBTYWx0ZWRfX/jFitJYbm89j EFcxOxq0gGOXnDdZl9bQ4hqeIoPGS61s3QWDBbWJl1S8kt+fCz5NhllwExmoZbw086ViT+2OPdx 94+yR06TLpZK4gMCnvuMYmTnwsuzhgLk4GjdOS88r4HezN7i+8d5N4dRtvMcH7cjtkvEsY+F6Zu
 U/DHAUxsD7pMGIwrJgj2Wi7XKn/fckny1EC/qHlqvRF56S0GWglcqXWSkGtOU7FaNn9IB3cWlu3 UJoMtcTaSE7gZFM9UP7aew7JmKY6253K88/nyHbmsEEoziuQbBQ3szbSOjihlNKtxq8awzK6QGn bsgtiKEb+ZwnxJf4Jy1uFWDmBBS9J6jg1xYjdH98qKJTifRFlcNObyuAZIXasV/5GkwA4XzlJY7
 DiINN9IUZHU66p+iTpPygbp7KKf42UKZRzRDeGe8kcsJkgOBp0IHFXuujRR+VZBrcHFCJLkD
X-Proofpoint-ORIG-GUID: 5RiXqAS83qfe3Trzu2lmQGk-W3v9RLHp
X-Proofpoint-GUID: 5RiXqAS83qfe3Trzu2lmQGk-W3v9RLHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507160140

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
v2: https://lore.kernel.org/netdev/20250714150101.1168368-1-Joseph.Huang@garmin.com/
    Updated commit message.
v3: Return early if it's an IGMP/MLD packet.
---
 net/bridge/br_switchdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 95d7355a0407..9a910cf0256e 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -17,6 +17,9 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
 	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
 		return false;
 
+	if (br_multicast_igmp_type(skb))
+		return false;
+
 	return (p->flags & BR_TX_FWD_OFFLOAD) &&
 	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
 }
-- 
2.50.1


