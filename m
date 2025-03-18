Return-Path: <netdev+bounces-175923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF52A67FEC
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219FE880C40
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAC82080D2;
	Tue, 18 Mar 2025 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="Ylzrvv0F";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="VmcxwjYR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A642066D9;
	Tue, 18 Mar 2025 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337848; cv=fail; b=WZfeePDbpj/4HxdVHSkf46YD/X9PWTOnWhTBOUaJLMdTqNF2LffUeFTtLWghx1taY2C/1jpK/l+Z8deZFt0PQTtICjJNU+VtyY1ldDaGy2T1thGXyDGgnRjOmH/003rYoiWoRBdLcO/WkP3LGVHwr0siWFyLfocLrOh9XGyMrfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337848; c=relaxed/simple;
	bh=qVvlIy3gt5qIWwbG9pMmu+sJFlbVvjC6QSvPsCRjLo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dp02zcgq/spAQovRDqkvf0nujshk3sjPOljEQhaTpSW5lVsENLjz8669ex/B+gcegzAYVFB1Te7Y0E5gkAdqvTaB9W34x1noh0wIUrKSnW47WzJWNiTEDNWEnUvRm3hcM9lSDJRM7cL1UfgvAI3fGjusBpWzZ9o/EZ+kxD/khO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=Ylzrvv0F; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=VmcxwjYR; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IKVt5x031941;
	Tue, 18 Mar 2025 17:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=84w2c
	TQ7JJPzhD/fMEmhAKKNTDYvSOMiud1QX8A/RLU=; b=Ylzrvv0F0+1JI8M/l7Ocd
	WnX1AEsjE0G/uXyaX21rZOuObiwzBOBq9aOYTmcfKrHbxYRIKnlyTG9LzE9R/5BX
	rHrrIAjp4CXic6WqpFHJU2Bvh/IHdmyFUQDTEHm92BAw40HfeWDlPv3/m38jWadI
	FPu1TFgqvACpJAsoVhRKYDmginmtUBkMdB6Iz6T+5s15FW2nJJtL/t6dVTgHJsCq
	ib6XBBzVWeZLCWrttU9gf1WAqUNNfcB4rhSE2QfonW/OJPb5NzDkIsEuqvj0q6bf
	qSI31RHBY9Ynggq6+t0wIz3VdtM4N4Lw+jFtdx49XhPSRp5T72SG3k8RlNQsV2fe
	Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45ffxt05rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 17:43:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nott43bv/nqX7L611ocg5iASGSgwJR4Rkv39TLXVNWj7LimqbwlZaUn+USeEMfk+1/8O+DEhBxvGv07ANWpBCgi7Kd40SqBO8XNwcS1u7efmO+mox+zusYx1DV1XrNNaEG2NZt+y9rdxddFF9WDZPgDFzeBhpQirRDOJkii2yvX2pJM1EU5nFqe1iS5mUV6wOnN7k8lM3Aiv3xG943Fs8Ob7fXPR0UBFTzP8lhI057NY8uLZDmqogJv02XrMASlZ2zIk+ChmbepBYmL0JTPiP0Rmqle6qdiBodEvLnOr7S0ADnuXyPRvBcITGORW3diwZafgAlPvBYwf4w8aK2igeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84w2cTQ7JJPzhD/fMEmhAKKNTDYvSOMiud1QX8A/RLU=;
 b=n6CwOBAt+LTE1eh5Q7sueuSG1hUCYBpBN2ncWbb3iSl/0kpbf24peKf5hxur0rhAt+zCv4okJrCuQSxEU9chviupnOlKCQjApey6EUdzzSQ7cawh/Br4al6wwZuCzwSOpBNqD3lhFAMN/zl+F7MeEHFxMTtB61Hub7H+4HDt/+kxHfzZs+irxm7UzCYQ0CFLfLFrpWzHp7LzmueY5ELiBKamITa4tQpSXM9vpgNvQY6z1buIR16f24lpoU+nnYZ35FDc9yweaWLg1YC9MRwYagUBMWzsC8x32BRdi6PK6ODOubIfe+gvOjASr1PkVTHAtzulPX1Gwu2gtSrJMDDIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84w2cTQ7JJPzhD/fMEmhAKKNTDYvSOMiud1QX8A/RLU=;
 b=VmcxwjYRLRFDU9FiyJh4+be8RyLDv43IzjZv8/6tBAtsJc0l2fGUREJ/1+i+2IzOm1ZYV1JgfXJL6OT32RCfQs5BOxdlJOSRit4Lvwg6cl7sEBO2QOHMBDhvrJB9MTmSf8607E583FTlejxmXf1PiAJj8w6VC0DrYw2KrHQhkxuO2W+Pz5k6Y3VrUlZqhtKPBcytMWv06Iq0uuak7X0Cg+uilYvpGr/W1XHw9A6D2WMk6PmotxVtAxMkx9diLLx+ZaUrjdhWI12iXwvzqcQNeG4YL+HHVgYwb7c/mE6kpWY4hVt6bf/eiB1o+ZhS0HE+QCg9fdgeftV8YsUMvZMy6w==
Received: from PH0PR07CA0066.namprd07.prod.outlook.com (2603:10b6:510:f::11)
 by DM6PR04MB6891.namprd04.prod.outlook.com (2603:10b6:5:248::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 22:43:35 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:510:f:cafe::35) by PH0PR07CA0066.outlook.office365.com
 (2603:10b6:510:f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 22:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.3 via Frontend Transport; Tue, 18 Mar 2025 22:43:35 +0000
Received: from KC3WPA-EXMB5.ad.garmin.com (10.65.32.85) by cv1wpa-edge1
 (10.60.4.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 17:43:27 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 KC3WPA-EXMB5.ad.garmin.com (10.65.32.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.32; Tue, 18 Mar 2025 17:43:29 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Mar 2025 17:43:28 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Mar 2025 17:43:28 -0500
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
Subject: [Patch net-next 1/3] net: bridge: mcast: Add offload failed mdb flag
Date: Tue, 18 Mar 2025 18:42:46 -0400
Message-ID: <20250318224255.143683-2-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318224255.143683-1-Joseph.Huang@garmin.com>
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM6PR04MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 998e4a5d-d6dd-4f59-f1d0-08dd666e5150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RGECi4hyNU/bOpmVsVwB9r3MySpR5Fzwd7YZx+BJwsbKI2wuIZphgrYLqVxa?=
 =?us-ascii?Q?BNIxAJL9YRD00siDEhcrhmiQcok6uUEiiIiio/PUkIDZgqGTtcFL63tR7jFb?=
 =?us-ascii?Q?ZzidS9whhAsBvXM7MAF7EaT4C4Yc83EW+bwmxF2ROwlQoM3Vl8jKlxZyrUUl?=
 =?us-ascii?Q?6WT/I1YkDaXE4Iknc1mG2q1CoOvPy3RjE2TQcMHvZArTvTDIuUy+QkmqXy90?=
 =?us-ascii?Q?N54qHugUHdoz9w8O36PMVQgfUwtcmN8rZLjjQ0VnwJwuTp/WuWu7Yh5aohKa?=
 =?us-ascii?Q?NmPRxaW0RYzCz3M6m3VuUI7jhNIVRuNSONmwvR3P6ZRTygg0JjgT6hXOWeuF?=
 =?us-ascii?Q?UgXcWRZcuzes9RMedg1xyNJxonYozh6umNbUx6AbQW2py9O6SCW0DOeNdSj8?=
 =?us-ascii?Q?frlRamgoNvmOey7NHVBq3zTqPdii3vEZIBem4CaF8Fyb905Lz8Yo4CHRkzpv?=
 =?us-ascii?Q?EW6wWPTE4+pqfCFLgFIGB9emhuZcpDP8/YjQ5/JsJh8V33Xv9/APrkFwFr2E?=
 =?us-ascii?Q?6dbupHp156ZbdRNJ/Z9J3q9+s3TnyItL5IEg6Rco1vGOtnH9/Ofu6XfNmVlv?=
 =?us-ascii?Q?xEvYCHnTF5b3KYGyDHTiPxunrLbCFYnViU70TJmQEICEATpMtgZSNzmMyCzY?=
 =?us-ascii?Q?N7RatVs8iQSzpAmiwa3NjZQlTyFxB+joLCQwWXSjfvE42YLhjw461JK2LYMc?=
 =?us-ascii?Q?BD+i6WmsfxMzU8Dmy8P94bE7y9i5em3BZnw7b53dN3RElzhuaer94XtylAn0?=
 =?us-ascii?Q?yZ2EnPNqMedraUPsUj2kGB4yRAH8uDfULCDEFmORw5kttwLoqG7fPDsqpfbH?=
 =?us-ascii?Q?Z1aZI/bgtcyJ0GylSBRLzYLm7A8Lycii57yvzmKS0ZyrIhWywk4gR5JaxDxo?=
 =?us-ascii?Q?4TDJIpwCjAuMqDCmkM3upkfa4wjOufHAddnRYgSDl+LnV/8pEXhL6mhVnVN+?=
 =?us-ascii?Q?CzxSBFoTHPyKSOFEfCuhsQHRHde17kHM3vtF14Np+5i16ULsRetSg+MMOYTW?=
 =?us-ascii?Q?Q9KCl9MSN9ZbcWHse4jI0jIcsCBpcmfDw2Sehzomi0Iply7J9TnOG5LBqre0?=
 =?us-ascii?Q?QccVfwxzTqVBSfxfdV6B4T5vLI3kzkAc/O2nRSHqgsvgLSTcbUYsVpkvtryx?=
 =?us-ascii?Q?wK2/0G6uQO3ad88YYG/MgTipp+Yg0Jwy555dCH/SScB/irT2St8s7KuGb8xW?=
 =?us-ascii?Q?Di28i7TYxegQT0ABBvqf66Tb0KseKVPFj4mxII5kzw8Uxi2t/N+P7In5BGXR?=
 =?us-ascii?Q?ECRaU/af3YrqdX3jxUFnpnpePhtOu8iYPFoo3fv+susCdpNrMPivDG7lzwa5?=
 =?us-ascii?Q?Zf1C/38XQVJoPdqo2G9rwqDqpCz68EMCwNpqdSiibM4TbohwxyHqccch0CPi?=
 =?us-ascii?Q?M/h56u/nI3R8egw2EIsDKxfLwkHVJ0G9MAMQ7riCt2PJ3E94v0tR/K/elu6D?=
 =?us-ascii?Q?sKV7vH8SO1QiM0mMWYNTIRsiXrtcMfo9/0mmtaswI7TjpSpdro8pgJOtKEC5?=
 =?us-ascii?Q?qGP7GqoL8u+20RQ=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 22:43:35.1610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998e4a5d-d6dd-4f59-f1d0-08dd666e5150
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6891
X-Proofpoint-ORIG-GUID: 60XSZGn1u9sF_NUY6YrtmXOcmt6Ma3Ff
X-Proofpoint-GUID: 60XSZGn1u9sF_NUY6YrtmXOcmt6Ma3Ff
X-Authority-Analysis: v=2.4 cv=VogjA/2n c=1 sm=1 tr=0 ts=67d9f719 cx=c_pps a=AwHzoy/LmQvuowsjLxKu5A==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=fs3JY7tD4Cos_Bw3ZwUA:9 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=977 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503180165

Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
that an attempt to offload the MDB entry to switchdev has failed.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 include/uapi/linux/if_bridge.h |  9 +++++----
 net/bridge/br_mdb.c            |  2 ++
 net/bridge/br_private.h        | 11 ++++++-----
 net/bridge/br_switchdev.c      | 10 +++++-----
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index a5b743a2f775..f2a6de424f3f 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -699,10 +699,11 @@ struct br_mdb_entry {
 #define MDB_TEMPORARY 0
 #define MDB_PERMANENT 1
 	__u8 state;
-#define MDB_FLAGS_OFFLOAD	(1 << 0)
-#define MDB_FLAGS_FAST_LEAVE	(1 << 1)
-#define MDB_FLAGS_STAR_EXCL	(1 << 2)
-#define MDB_FLAGS_BLOCKED	(1 << 3)
+#define MDB_FLAGS_OFFLOAD		(1 << 0)
+#define MDB_FLAGS_FAST_LEAVE		(1 << 1)
+#define MDB_FLAGS_STAR_EXCL		(1 << 2)
+#define MDB_FLAGS_BLOCKED		(1 << 3)
+#define MDB_FLAGS_OFFLOAD_FAILED	(1 << 4)
 	__u8 flags;
 	__u16 vid;
 	struct {
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 1a52a0bca086..0639691cd19b 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -144,6 +144,8 @@ static void __mdb_entry_fill_flags(struct br_mdb_entry *e, unsigned char flags)
 		e->flags |= MDB_FLAGS_STAR_EXCL;
 	if (flags & MDB_PG_FLAGS_BLOCKED)
 		e->flags |= MDB_FLAGS_BLOCKED;
+	if (flags & MDB_PG_FLAGS_OFFLOAD_FAILED)
+		e->flags |= MDB_FLAGS_OFFLOAD_FAILED;
 }
 
 static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1054b8a88edc..cd6b4e91e7d6 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -306,11 +306,12 @@ struct net_bridge_fdb_flush_desc {
 	u16				vlan_id;
 };
 
-#define MDB_PG_FLAGS_PERMANENT	BIT(0)
-#define MDB_PG_FLAGS_OFFLOAD	BIT(1)
-#define MDB_PG_FLAGS_FAST_LEAVE	BIT(2)
-#define MDB_PG_FLAGS_STAR_EXCL	BIT(3)
-#define MDB_PG_FLAGS_BLOCKED	BIT(4)
+#define MDB_PG_FLAGS_PERMANENT		BIT(0)
+#define MDB_PG_FLAGS_OFFLOAD		BIT(1)
+#define MDB_PG_FLAGS_FAST_LEAVE		BIT(2)
+#define MDB_PG_FLAGS_STAR_EXCL		BIT(3)
+#define MDB_PG_FLAGS_BLOCKED		BIT(4)
+#define MDB_PG_FLAGS_OFFLOAD_FAILED	BIT(5)
 
 #define PG_SRC_ENT_LIMIT	32
 
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 7b41ee8740cb..68dccc2ff7b1 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -505,9 +505,6 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	struct net_bridge_port *port = data->port;
 	struct net_bridge *br = port->br;
 
-	if (err)
-		goto err;
-
 	spin_lock_bh(&br->multicast_lock);
 	mp = br_mdb_ip_get(br, &data->ip);
 	if (!mp)
@@ -516,11 +513,14 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	     pp = &p->next) {
 		if (p->key.port != port)
 			continue;
-		p->flags |= MDB_PG_FLAGS_OFFLOAD;
+
+		if (err)
+			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
+		else
+			p->flags |= MDB_PG_FLAGS_OFFLOAD;
 	}
 out:
 	spin_unlock_bh(&br->multicast_lock);
-err:
 	kfree(priv);
 }
 
-- 
2.49.0


