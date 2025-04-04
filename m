Return-Path: <netdev+bounces-179401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F78CA7C5CE
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D33189F0EB
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61FC1A5BBB;
	Fri,  4 Apr 2025 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="UskW8Pr6";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="r7rXnmLD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7588182BC
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743803626; cv=fail; b=e2XFWnggBprRVI9Boz/Bx5zzn+sQLfHzqVG9V9IWQy3Vx3It4Ly/uWWDRW8La4R5fcT2vHhYhtIZ+fgemVAQl9bxtrO2fjui/Y57tvASe40Cru1YCITPRJwFoifa+mqHHxJtbLbvGdNMw3A7CDz4U6htExnMqQTQMM5Rsz31ycg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743803626; c=relaxed/simple;
	bh=VG5peIQ7STH7OgiNc30YSJxyShVE/DGLdxQ3w3MS92w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p7mu3RpC3ohIozuoDfXOlpwzTTzpOvJ+7V0b2+wPZq8rVDWnh1Qus7xRaF+mGy8SklKxNecPA5MjjIlir8kN1OoxpNswXHyXxM9uuahcrz4V1UMpnA+/dPkATDXiN9dgI4Lb5MewSDbbz1er8fz3nyccp35FBciclTkbmzMoh3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=UskW8Pr6; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=r7rXnmLD; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534JXDFi023931;
	Fri, 4 Apr 2025 16:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=wJX6dz+zGEr39sKIWfNXkUuC70Z
	rLS5TgvXOsBErNoA=; b=UskW8Pr6VxWRl0gh+OcClPzYi20S1u6Drs+E7G6lkIq
	y76m2FusXjdp1BPBn3PwwhNj5r39MbohLuFnVMBIkh/sWVX1WzOdJcAJCO/Q6+8f
	GuEK9ddVB01slDMzeFLBXRS/mBI8hRJ6E0bGmS3ECaIUC2/Vximk9NHcTX4FvwLQ
	L7izeICxITflywu7EJ5686CT674W1LKzjS3gCKy4LidIWGcfhBguhDafvWmoiCL6
	dJgW8gR4U7zwa0NEUqahPvuUMdZKPOAFj8Osftw27aFvZXJGb6HbiHKYZpQB8xrY
	o27uJazNwLY4eIxyPoUv6awZ8XcjXpK4vnkBVDxGMiA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012038.outbound.protection.outlook.com [40.93.6.38])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45tkkc8cjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 16:53:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+vWc5FifFm0H2xjfc34wHus2sUiizWg+DOlahXJpZGlK6yAY9rlsiIg+EhWnt9ugbR8I95RR9iWYPthrLUotd8znSbNr507j5CEuxjOZoIgcUCQvg4wQf6QGtubIFmWxp/NbcinQkUpbmYN2t832XeIYPtIpj2YJKZw2j8rBGF99ME1VXuCfqfbZ3JURtyhK11RuEYeESU4N4VapAY6SZlNjjjYCX/S6DOXchFMRjd2oU/4QegVuwJBcppAcKJLP1dOGlnEgTwovDYuL4oHgDbW4BjrVpac+ValMa9wN0ig8c3fq9PqUy294P0QQU4eHcYMy8RJdF5U6DRoB4dpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJX6dz+zGEr39sKIWfNXkUuC70ZrLS5TgvXOsBErNoA=;
 b=INY71ZOO+tel5nIuWOtPSlGlJoVPd9DPwuQvFSynfW/KrDaTFrcxhUZyLIt9/AmzFGwWpUlK9kSspivk6RVfSDmu3OAvIouFMKFTgbGzwOePofSftWnVAo9JVVrlwWsTFJ4bZCC/Jt322WUd97rklO+zm6pilccoSZugfNIWio8QWzra8nA+1QSkEG/1pBYJyDZ0Mrw96kpr4oZPa3tTni2PVZyLk/PLWMHX72qDNOjuykRZ3K6a4ZFKg21RPUji+BOFZIj1dS3Kn36goX63xvrd4OR46ADPa1/sfo7y/pkq7qblycpVU6CASyWGCEkFU0ut4kDpnvYfu0TxgDFOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJX6dz+zGEr39sKIWfNXkUuC70ZrLS5TgvXOsBErNoA=;
 b=r7rXnmLDqzcJU9iGvygmwb2HsoDPsJceCQXXR3ElQXyhijdwtSJc64bvrKn3qVK5QtH+ZP1KOMfwjKruMDdH5g9/NS4oS+I3oMUHfQyZtnLHIdRFW+Q4VO2+Y4I7tAT5P7KYypKoBr0x7WdPkCc5h29wLZ+CFSMJI2wEm81RhYWHh8FPKVZh5eoIpsHN5m7Ho6Nuj5HZcnGNIT6WIGQ32tyoqHfWmT9jvCs7HbORCLHcBW0jR2deYP0Ss5nFauNO2l4kWzU3uqs/YHNo7oKlfRtKXMhumecdh3rCkExbcRQGY2rHmzy5Q/lhrkn5Aa2GclXDOwiTy8dLmp8YWLPWdw==
Received: from MN2PR06CA0021.namprd06.prod.outlook.com (2603:10b6:208:23d::26)
 by CH2PR04MB7046.namprd04.prod.outlook.com (2603:10b6:610:96::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Fri, 4 Apr
 2025 21:53:36 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::98) by MN2PR06CA0021.outlook.office365.com
 (2603:10b6:208:23d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.27 via Frontend Transport; Fri,
 4 Apr 2025 21:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Fri, 4 Apr 2025 21:53:35 +0000
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by cv1wpa-edge1
 (10.60.4.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Apr 2025
 16:53:33 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 4 Apr 2025 16:53:35 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Apr 2025 16:53:34 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Apr 2025 16:53:34 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, <bridge@lists.linux-foundation.org>,
        Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>
Subject: [RFC v3 iproute2-next 0/2] Add mdb offload failure notification
Date: Fri, 4 Apr 2025 17:53:26 -0400
Message-ID: <20250404215328.1843239-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|CH2PR04MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb32f11-09e5-4eef-259e-08dd73c32672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZDkYUVk/w3ZUpndTNZpF6NnluMIjfBtvajh1i0fvh1nS/wlqJF3C+UzXzXj?=
 =?us-ascii?Q?zVssKzgdDI1xqqNMWEgpj2w06IogdDT5zu01saPEE6G2euo5yZQZs0jOQ0FB?=
 =?us-ascii?Q?k+5By5cfpy+0OU4++1BjSiQZFFQaKIguoSuewGYKQzyR3AIwTCP1qNstXHQ+?=
 =?us-ascii?Q?z76dpOBnd1Vkm3Yx1TYrOfxCLq1eNYyBmDP0xJ2oKUtFxPOuV1JVOfXNh8pm?=
 =?us-ascii?Q?KrODac3QJaPFGIo39AoQ7OYkz5zbYWKR7hd/sJjZFZ7yNLwBw5uYPVBRTwpY?=
 =?us-ascii?Q?XRgiJ1Mzi3zQAs4NwplDTaRo8zqMoMBE3kHwkGRlGMM/dhK68ftmUlxLTyvQ?=
 =?us-ascii?Q?EcX2efufeODs7XMM2ltpxLVOnFcaqLlMQoL00r+XF5sWGhXM2Pa8R5bfJKup?=
 =?us-ascii?Q?JidHA7M18TvSfCN5VaY0lkJbZJrB5ZohEXMyHeW60dNoJUQ6qz+LI4LYt5p3?=
 =?us-ascii?Q?Wpb6/iRJc37uk4ToRf5MXc63Vic8HSvxSTrhYqMYtpCwy8YVYOo6l+a+yQbK?=
 =?us-ascii?Q?Qdmiwlli4Zdl2If5r4hkTauiLp2ogra7mHSOlulJFX/lU5/qLIdCV5SrW8tF?=
 =?us-ascii?Q?l8mbMKSZiYmMlooDr0tEFfDphRduCBt6tU4qOmGHKUWjxJvbFYewND9+uUaZ?=
 =?us-ascii?Q?TaRg67aZxeEl7+kshQJ+r7ND44i5ZhSCOj5aJAzVEoLO+7CkZYUjTmDjnSm7?=
 =?us-ascii?Q?8okzUBIoPdK74f9LqTeYK0LKduojDkvMMToxq8s+NUKxor/W4zq7tutGkP3Y?=
 =?us-ascii?Q?IRsPC2Rag6pxNxGfpzGLlyYAWf9w1eXC9Dje98KXAyIHZzYj0EChk3uHwaVF?=
 =?us-ascii?Q?wD4raRcO7j6ylxXqkvjeIybMmX1CJc2GV1Icojm8jbFQHTnMp5gtLHX+hjk1?=
 =?us-ascii?Q?dd37EGPoPpTxSoBLRwRL1UZzhKH6ftR4RdQmhY3vj3oSXiraL55xaDGl64HA?=
 =?us-ascii?Q?GRgrdAy4/qqWxrSUaSPZgh9HrePWZZA9wf0zfpn1/7214F3/168fzTtDw0oV?=
 =?us-ascii?Q?p11pUfnJqPpAuR9mgQUhHrpFiz/ISfnBSe5V6dkkrGe94Fz8WjAWTyzXcZlS?=
 =?us-ascii?Q?7o7193UhxtTcyVkVMVu4VwgYsViE8M1I1zAgOjN3bZs5rGOpA54NZk439jK5?=
 =?us-ascii?Q?LV+qqbFNd4KvEdFy+PxGnPTPpEsLJEcSVEA6xWT1dX1BMJE4ud9M9mzlyLqC?=
 =?us-ascii?Q?8eFhZ9l2xSwty5Jxe/9hcwYIzXwE/mT3oSsT4pWDTDgHQpG13cf6QcJftTRC?=
 =?us-ascii?Q?44nnm71rQKeDNbeMxRBH5Z8kGbQ0vhRIlDEGxnqThSDrNdfL5yps4jiXJxjU?=
 =?us-ascii?Q?N7g7Yh5JPCYu2AaNc2vscShTnj9Om1tbupyi0EfhiIolUWa+tRDI0t5i7wvT?=
 =?us-ascii?Q?VfG90/QsO1NFV1/XG2vnez3OxjEPvnlc1RMbbubwzKrs2x7G2u1GVgGebn/k?=
 =?us-ascii?Q?HJj5jS8/c/DMT7iErSIiGUGXmQFky/JC6ya08lMP7UfNuT2BS8zkvtJSGe4L?=
 =?us-ascii?Q?36kdu3RCQPsOvJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 21:53:35.6216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb32f11-09e5-4eef-259e-08dd73c32672
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7046
X-Proofpoint-GUID: FDE_D1x0XRVnkAAbaNl3SmYax9Apo5Je
X-Proofpoint-ORIG-GUID: FDE_D1x0XRVnkAAbaNl3SmYax9Apo5Je
X-Authority-Analysis: v=2.4 cv=drnbC0g4 c=1 sm=1 tr=0 ts=67f054e2 cx=c_pps a=BX/OqAvQ3O7aab6wCuJmTQ==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=WMi_1PGcEJAheBDhYWEA:9 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_09,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=702 priorityscore=1501 malwarescore=0
 mlxscore=0 clxscore=1031 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504040151

Add support to handle mdb offload failure notifications.

The link to kernel changes:
https://lore.kernel.org/netdev/20250404212940.1837879-1-Joseph.Huang@garmin.com/

Joseph Huang (2):
  bridge: mdb: Support offload failed flag
  iplink_bridge: Add mdb_offload_fail_notification

 bridge/mdb.c          |  2 ++
 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in |  7 +++++++
 3 files changed, 28 insertions(+)

---
v1: https://lore.kernel.org/netdev/20250318225026.145501-1-Joseph.Huang@garmin.com/
v2: https://lore.kernel.org/netdev/20250403235452.1534269-1-Joseph.Huang@garmin.com/
    Change multi-valued option mdb_notify_on_flag_change to bool option
    mdb_offload_fail_notification
v3: Patch 2/2 Use strcmp instead of matches

-- 
2.49.0


