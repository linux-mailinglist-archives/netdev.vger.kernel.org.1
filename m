Return-Path: <netdev+bounces-180352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A6A81087
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D961B63F90
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A75722D4CE;
	Tue,  8 Apr 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="SC5m6j0a";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="cgdbqCoI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1122B8AC;
	Tue,  8 Apr 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126933; cv=fail; b=pVCKt43igWuUl1xsMEV1N2VrJNa8+dKg99N+dnTwwx/+g9fbx0vmK/gqFwDFjtXg99hy99wJcpiU0IvEmwWGmxJULzbQy/p2HC1d7MaHh8+DmGvAIeam1D41asF90d8jYSLFDd+uRYzZRyDlE4NH5B3OiTA2xcnwiZgcF/+YqM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126933; c=relaxed/simple;
	bh=RpqFxKkKGZdOrrYJWruSzuIVF7iebLUhnnnuE8FX3OM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUwnuXaWXOvRjP7xgdbtbVxYEmbW60Hcn035qUKyrp4eV0PNttilDbAXD2c+SktoRUZU/b91HR+KZT86xyi/Sdz+yOOSh48eMuT5ikznJroIyTYXCuGorLbvxZRhAybFs0Ri6pR0VVj9Nb95rp7bXV75XhDkMplRxMv1Ge8Sgds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=SC5m6j0a; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=cgdbqCoI; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220294.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538FP4Oj015286;
	Tue, 8 Apr 2025 10:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=iOno2
	KeS17/kb2NdqfsXsrQHj1MoyCme0ya9xcNBmdY=; b=SC5m6j0al682TKLWBjJ6C
	ZnGNj2IBfmoT8LAbqjbIlJjKeBynOKklB8f6PA5KbNRGW+RSFLkl+aEieNG6qXaS
	S3NSDBPJ7F5AaurpWmx9gwBSmeXZrzh/9Ts6S4R7sAC6yjRptKQW/f4i5/9tMV2D
	25ZEQj/7/rbOtvTE4ZhsBaVAerRg2thUvlnTRqr21pRqsc+RzYhW38wcJAj3/Lod
	jktfAvKsFXnv1Gr+94PVJQS2bBCwpsTDxUL+2+Cir4Hu3yfQhef/DDr+vksDYaCr
	a1TOJRygy85sSIfZ+cG7ulz/bWgzFO8uaFOeKFjCWDVWge1EOznfNMbVdWt7LHK3
	A==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45w22hrmrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 10:41:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qfqyj3rFtqdyKJbzw13/MfMCOsfVynDM4EaXnca1UR37fw/tu0TY6LOt6nV8halBAiTBf28WcxuYkGeTGXF1CDL4lKPpNV3LPQrCMeyFGFBMYlhdwc26B++rWwyQfnzOmnHtmt7B+cnrXo6CnLeJW96P9pLBiU9xFDwrdDh2qNWuE9KAlTH3UipheOp0OK3t/tP2Z52PIaj6yoOLAnV8DYLs7LlxC+m8x9WGqwwUqw+rzS5ogiffD9fTa34iuyMhhDEgqfr4gqkcmRGHyegk8qXf7Q5jkyuFc7IhDyop0sEhIX8glenZ6zxdQHzcs8h8CPWQRBB17B/yEx8QgM/Jnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOno2KeS17/kb2NdqfsXsrQHj1MoyCme0ya9xcNBmdY=;
 b=mK+/8nrBCl+admFIe+WZTWnKdUMWjSQphDoIspnBuV96moLbBq89qgFHZMZpxLSheF4Q4KINkWhloRJK4npG5ZcU053igg+JtYHkC8c0tkEKohbg+kDJzjDBN7JfyX8MvC26lxq5IcvOHXUBqQL0GdYhewV59q7lX0KRM0AKxcRwD3XojH0Y5VXP8sWYlxHchkv9jnd3keIbZA5W1NNrZgL6QXKtD9y0MOy32zYtd62TyB4AkNbGhwL4zReCvC4+XEVRASdvNfV3VEvObMFul/Kmja7ektkppu8S9hP0Ofcest+i9jNlJEZH9kvhOQYvnFVN3IwxlJ+XY1hAWGUIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOno2KeS17/kb2NdqfsXsrQHj1MoyCme0ya9xcNBmdY=;
 b=cgdbqCoIkQw2GY/RcpwWn2GMfdx/+I4/4m5xHYB35B+RGi5ccV2BWsqm/3X9HjdLry05yAPs8MiE7zVAL1gBoxeV045GxYRNGCy8v3q3kX+dr5DYwJ+Drvi55AqNo3amQ/LiSbBl0vc+gIrPZ5Apa99z7Aagjns6Xve2+sQ4dHjaRgkTecaGBV32G/hf1ZXmNYjWGFacyUSK36kKRYUzVfcuTWIUv3Gxe1NDBGTntILFTc2keRv3LbfzvIYU/ki6v+Di9Zhnp74bsCnNNWf7zY5+bffAMyeNQu/+O4sR2mbVtzAUtbsp98ycb63q/A+S34ijV//dpTu1hypZDUZuvA==
Received: from CY5P221CA0123.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::18)
 by PH0PR04MB7254.namprd04.prod.outlook.com (2603:10b6:510:1b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 15:41:46 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::c5) by CY5P221CA0123.outlook.office365.com
 (2603:10b6:930:1f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Tue,
 8 Apr 2025 15:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 15:41:46 +0000
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by cv1wpa-edge1
 (10.60.4.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 10:41:32 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 kc3wpa-exmb3.ad.garmin.com (10.65.32.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Tue, 8 Apr 2025 10:41:33 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Apr 2025 10:41:33 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Apr 2025 10:41:32 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
        Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bridge@lists.linux.dev>
Subject: [Patch v4 net-next 1/3] net: bridge: mcast: Add offload failed mdb flag
Date: Tue, 8 Apr 2025 11:41:09 -0400
Message-ID: <20250408154116.3032467-2-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408154116.3032467-1-Joseph.Huang@garmin.com>
References: <20250408154116.3032467-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|PH0PR04MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: a03027b7-a297-4e37-261f-08dd76b3dee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1WqMjj0t65baRz4SbsEQLKL8uCMjExMowVZwj38hSQEGSeJrvJzt6rxgJpFL?=
 =?us-ascii?Q?o9BYvxeyAxPoD0llpGWzjPVeSoNPSFAp5MLOr3zPD8O2vjI/8j/M2fI6V45U?=
 =?us-ascii?Q?TAdtc7i05edaVMTeLL5gt2MqUyc+vyC0Cz4gT4n/ofNUNZXfbV32E4hrgEPq?=
 =?us-ascii?Q?8tXxFq9QqerYFXExAAZTV637taF5dUzbpC8yOiwdWE+RtcM+k9JWi6GBOCe/?=
 =?us-ascii?Q?xOZjOT3M01JrxfnosPAR6Q1pn0wka5nAwaDuPnDR+guJQejJ5xlZmc/odOXR?=
 =?us-ascii?Q?6Q3nM3njiQyLOx+gM2vbYc0v94MZGuN92k86RFlMy11jMwrS0wqCkotwfMiz?=
 =?us-ascii?Q?F0qnsXVYGzM2uMueXZC1xhlvIKeJe3cHrsOTKMDKi0+En0oYAHJIg4yjGjTz?=
 =?us-ascii?Q?R8Z7FGyQckb4GCSN8TO2DoYKPzgBLMfX9SRNLMlAapCF6myHLbMY1fNwbfDT?=
 =?us-ascii?Q?uLg881JRnLaRgTx/n8q+8xP9YBH+KXFdUMWiy0kP18WcnUuXDJOE7rMNSdZc?=
 =?us-ascii?Q?K5eaD5AazKhNKyksaeZgt9FGnobAC9dhtUMT0qDp85moR4zix1xk4n6193HQ?=
 =?us-ascii?Q?Zz+o7OxnY/oOn7UDPqogSIHUR19J15J5rGWwU/I1yUHybOPqskTTWxsH6TeW?=
 =?us-ascii?Q?0lo9KPULEY3O2cui4QINxaURL10tnenWspslvgjjJBFxPakyqO46AEf/f+wr?=
 =?us-ascii?Q?MPG+JiDVdqj9DWIItTi0/YynkTDqLq9ZKqeYWDRC+tw0/iIcna493uda/vzg?=
 =?us-ascii?Q?UMsb3IUkLze20KTEmgfixT56OUfOlaE7E/2Z0SM5GbDGh+tWOCL0/+RmXDyb?=
 =?us-ascii?Q?bUlfzRSM8dHtZf31F3m6Gu522Q7zAr4FV98oZdj+BsctipzwyrRv6drkw3VA?=
 =?us-ascii?Q?8NFXY/i3yuriIZGmbDDaRKy7rFgGnxHXfbgQa4sHmoDmZGkUbH0YZTDT5Pl/?=
 =?us-ascii?Q?E4jgN+h4hgnPAvo4T+fFpCrJqn1og99YQSorXylSrnnuRsNxC/EoPI/LiU6T?=
 =?us-ascii?Q?OEf4jkEPQbERz1R80CNgvEtA0NEK2tahEBLIb41yZDKArc/aWIwii9CP/FlT?=
 =?us-ascii?Q?5YjUEyMtDgixGx+OIePOwB4stGcNLnKhSz9hmYq+FoSrcaGVSETvrLE+Sezh?=
 =?us-ascii?Q?HhOZCnU9Nz0izKMpA+U2shgPatiacKYslwbcrarixQyrS/6Y/pmmsY+JBFcV?=
 =?us-ascii?Q?RHK5H7Lta8u7kr5mahre7p9/apEABwTXa/jCkk1fbgk/RXJVDB6aRW9lgMrX?=
 =?us-ascii?Q?xi46Rnn6N4q3VuYT4Ws+O5C1HY1QE/qT0dyIjaM7mWReXj4a2US0cGzqPVzm?=
 =?us-ascii?Q?NLGPgRuEashBfrZWPmsQM8HS4WHlwjsVYxJDbdmGwCRPNW2DR3hBGrTLsPK4?=
 =?us-ascii?Q?42fX0uCtm/MMgIGMqicS6O2FcYtna9rkluXkhB0JkMjrNrxEh4Fk+mhXz65g?=
 =?us-ascii?Q?6FtWlYko3BPt9Qn8LXwK8oxjj6q4Ewvhsf9qjJY2rFt1OG+LuT3LviGfixIZ?=
 =?us-ascii?Q?ipOnCJvc5yWme+s=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:41:46.5371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03027b7-a297-4e37-261f-08dd76b3dee0
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7254
X-Proofpoint-ORIG-GUID: 9I0z8VBV8aTVhhD-OaW1iRKWwiyP21Rz
X-Authority-Analysis: v=2.4 cv=dqrbC0g4 c=1 sm=1 tr=0 ts=67f543bd cx=c_pps a=di3315gfm3qlniCp1Rh91A==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=vr0dFHqqAAAA:8 a=nTqqLMH9PYxWBGmw_pQA:9 a=P4ufCv4SAa-DfooDzxyN:22 cc=ntf
X-Proofpoint-GUID: 9I0z8VBV8aTVhhD-OaW1iRKWwiyP21Rz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=845
 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502280000 definitions=main-2504080108

Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
that an attempt to offload the MDB entry to switchdev has failed.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/if_bridge.h |  9 +++++----
 net/bridge/br_mdb.c            |  2 ++
 net/bridge/br_private.h        | 20 +++++++++++++++-----
 net/bridge/br_switchdev.c      |  9 +++++----
 4 files changed, 27 insertions(+), 13 deletions(-)

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
index 1054b8a88edc..5f9d6075017e 100644
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
 
@@ -1343,6 +1344,15 @@ br_multicast_ctx_matches_vlan_snooping(const struct net_bridge_mcast *brmctx)
 
 	return !!(vlan_snooping_enabled == br_multicast_ctx_is_vlan(brmctx));
 }
+
+static inline void
+br_multicast_set_pg_offload_flags(struct net_bridge_port_group *p,
+				  bool offloaded)
+{
+	p->flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
+	p->flags |= (offloaded ? MDB_PG_FLAGS_OFFLOAD :
+		MDB_PG_FLAGS_OFFLOAD_FAILED);
+}
 #else
 static inline int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 				   struct net_bridge_mcast_port **pmctx,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 7b41ee8740cb..57e1863edf93 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -505,8 +505,8 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	struct net_bridge_port *port = data->port;
 	struct net_bridge *br = port->br;
 
-	if (err)
-		goto err;
+	if (err == -EOPNOTSUPP)
+		goto notsupp;
 
 	spin_lock_bh(&br->multicast_lock);
 	mp = br_mdb_ip_get(br, &data->ip);
@@ -516,11 +516,12 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	     pp = &p->next) {
 		if (p->key.port != port)
 			continue;
-		p->flags |= MDB_PG_FLAGS_OFFLOAD;
+
+		br_multicast_set_pg_offload_flags(p, !err);
 	}
 out:
 	spin_unlock_bh(&br->multicast_lock);
-err:
+notsupp:
 	kfree(priv);
 }
 
-- 
2.49.0


