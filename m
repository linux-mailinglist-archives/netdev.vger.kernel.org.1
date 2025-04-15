Return-Path: <netdev+bounces-182845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B92A8A172
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E86A7A450A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EA92973A0;
	Tue, 15 Apr 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="pDqvfjF8";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="L4N5kmjL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465B296D0D
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728229; cv=fail; b=glunhflUXg5+5W86eqCiIsr66shPcTg1u5owLg8WzK3Yp4gbGRo6wYa0/C5gBZ0HpIddm2JgFwH50hJrHKmwZenErWyTP07cmV8zTEbhljwSbTvRFrAUc329eubzFL38ptgH+uo38INeS/FVMdhHqTCqjlKmCRZ60cDHO/Vj9Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728229; c=relaxed/simple;
	bh=zLIt/t2gDkQq0hxlE2wSqWuh3ALifCOyvZQnzoiEHls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkuSlm2X1g6YvgkDnAEacpua+CfagXT9LkjoxGUZApJHy9jRSQUxcoQiDxlxVZNhOgfQIZIKLFPVMwpssjsewfoGmnfdvsiNIH+Rgs6iu+00W4W1Fjcndz5pW3fEMJ3KrYCb2csPo27Gia3OwySNditC2C/RwckDJuzgQsQFQqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=pDqvfjF8; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=L4N5kmjL; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FE4uTS016440;
	Tue, 15 Apr 2025 09:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=RCCQj
	VvYCwfWYQd9k28saveOtHkmFPEW0NpJyDZ6eSY=; b=pDqvfjF82aZSbb/aohAQ1
	UVK3Z+QDjW5UYVuqlV0IndY8+juOuQchXHGUIdLEpp8iH5SmG4Vz80j3PJNokO/F
	R4dTd+FsAh5ndgxdPOKgfgNu8Qn0SZc5UYegw3KAjIkEk/fQscoxNxCZFqnc82Yq
	fyCZBEfT3VTwB1gXUbi8I7psEvUGy28GP7RFvgEyW+UWY+BgISVQ6yWch006nwWy
	OBNg23O4bsy2zKTw5sfeqCoAVSnB1NZ3Ot5N5x5GXGhPK07HLrfZaYkgepHd2+o4
	PDt25K0mmsMM9AVq0vUE03WNmVn9kakR40DynzJ5XyYxhm6e+4Dms1ASyKtdGIN+
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010004.outbound.protection.outlook.com [40.93.20.4])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 461rwgg32h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:43:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0SuNnH/5oD4hszoO/TVjqO0tPmCLMR3pHsF6gv7/V/d0lFP1FI3r1vQXgg9rPgFh4SbsOuRUJmxYOl+v7dLSGsoBDPSqYYGToWPTbPnmMSVRdk73KvAXpue1GG0Lg5UQHJYeA9MT+VTW3i03rBCbpOfLv01xmkPV8oGzW0uooE4JsEQ7nmlOt878fKrH8bpZb/MoqGH4uC9bLPS5LT/53Tw3GKqQIF1IIIIP30vR1mGwcMQWGvfTlwY5DuexdC4PVreZLyq5enPDXADeBMsqEVAoXNUSfML95Aw3DLVNSdKyg3mwu/DWkRc5FV5LJ6uUiB69ud+DzJYxXDU/DbdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCCQjVvYCwfWYQd9k28saveOtHkmFPEW0NpJyDZ6eSY=;
 b=iTaQ/qGIt5/r+U/ORDpyo8BvTDFU9TBxakg2K3Ju8lM6WBQSBNnC9VDjg/M1XN+rpZuMk6PgAI5W44wuG1ImMxVYqbS+dJeKW9HWwsa67MErRiUhs6c2BKvBmTMqY5O+FYLm0kEKbKu6ee04JT1G+ukhDwOAGV7kNHd5QxWcxIVWhehj0SEK8rHeQ6ZqzPTSBNvo22tVFx57niAvRvV769nRvTzMG46/ehsC6dAsFqeWAnOnieG1KbSA8XGWO4oseNX2coO09lqEinCDCs+8KkgHtQZJaRL+Dl2ck5ur5fcc2nuZuT7Yzf+27sCgvC6v77VDHeNmE94d0XEp9wRPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCCQjVvYCwfWYQd9k28saveOtHkmFPEW0NpJyDZ6eSY=;
 b=L4N5kmjLQLZn/Rze8ik+ySJI4F+glBK5O+h6wYrlvyy7M8g29S0FFpCWTC2ohLyc5L+GZcyWtUYJvA/EE9HYODSmRfnXboJcD8sIR3cJgC4mfDsrBgbxvZpqrRxZhbuzUkyMSqJuFYS+to9r8hNTbSmYlbpdv3P0uaFw9QBwCM+Dx8KUwyzPuapaeQvQQ1A4CDaOB1FUYnK8gwmLC5orDrzqHo9c6PW2ugBfRVtyJj5AqaWoHqcOn49DqWJ4Z/fgJuFk+loFq+hlmosc0dbLZRMVk+2EE4sZEP/1tNptuNnLnasM67vx4jpipxE5fQAunR7WJ+J8A46kuzd83b1D9w==
Received: from MN2PR15CA0058.namprd15.prod.outlook.com (2603:10b6:208:237::27)
 by DM8PR04MB7974.namprd04.prod.outlook.com (2603:10b6:8:1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.34; Tue, 15 Apr 2025 14:43:39 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::b6) by MN2PR15CA0058.outlook.office365.com
 (2603:10b6:208:237::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 14:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:43:39 +0000
Received: from cv1wpa-exmb6.ad.garmin.com (10.5.144.76) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 09:43:28 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 cv1wpa-exmb6.ad.garmin.com (10.5.144.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 15 Apr 2025 09:43:29 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Apr 2025 09:43:28 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Apr 2025 09:43:28 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel
	<idosch@nvidia.com>, <bridge@lists.linux-foundation.org>,
        Joseph Huang
	<Joseph.Huang@garmin.com>,
        Joseph Huang <joseph.huang.2024@gmail.com>
Subject: [Patch v4 iproute2-next 2/2] iplink_bridge: Add mdb_offload_fail_notification
Date: Tue, 15 Apr 2025 10:43:06 -0400
Message-ID: <20250415144306.908154-3-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415144306.908154-1-Joseph.Huang@garmin.com>
References: <20250415144306.908154-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DM8PR04MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 683fde0b-2ad4-49a1-a4d7-08dd7c2be91e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jWlA4ozj63F9oeWeqDfZ/sFQfdfrZAM3p/UrfT8RcYZb6M9AkAwr1T7J7xeP?=
 =?us-ascii?Q?Se0Y436FsQR5vrNqIZ9rYkLYfy0xxub9ubfG3HAEgAKUm12rGJWhxqgA3imU?=
 =?us-ascii?Q?vPYfFLl6PwnAGGCfP6zn57VMjlWkmN0eanVclE8+f5o5Gy35C0xGT3QdSNJZ?=
 =?us-ascii?Q?LBRhcOlcSks9Arx0TlqCoXul+/bnyCPBR8MuiXUqlxz7MKZFOY6FsGIryUTF?=
 =?us-ascii?Q?DE9oCL7pTW9FZx6hIlutuyc1k2R5IfJYgr9nuugK5WlS3ETksGEjG4wPgJ/N?=
 =?us-ascii?Q?XSYd+FxHcXgRGSKByf7szHr0FbtWZvLU5gDj/1ymjTsVHpOStoxXjrKC9zad?=
 =?us-ascii?Q?nGV3FUe6t5qnkmL7GxzYSO0RZnlUU7nmr8mSsw1nzgIcJKPHBWuJtat/H6XI?=
 =?us-ascii?Q?6BVeFAaSCH1qODkzd5BFf9/b9ejFf9wrVn5F4sOP3c3/2QwEH/I4IGKvHijV?=
 =?us-ascii?Q?MU4+Af7nRvhl6VkTlRXFWqMm0cYebpEnBH95DEdajBdyXDZGnomDkuGn2dNw?=
 =?us-ascii?Q?mt9UH8Ya4r23yTxNiSgqSHc+JIItpR98zO/DTkmIErUvArimy+h3u2YktL+d?=
 =?us-ascii?Q?HDa5RH0D60DRMFyGlkpueladRcFl/YZK9lV9QZ9zRZzdqi++gbHo9wkfka85?=
 =?us-ascii?Q?wqKsGPapL3CPMzVR/FdLAirnGR9g33wl06xbasjRXNfrbrSrRyXqgF9S/G1J?=
 =?us-ascii?Q?H2vVmf50QRJhX3oZFGvDpKaW6dmf5bLCYPSJSRJuJ/it3DjafnaWypV15bag?=
 =?us-ascii?Q?st00py0g2hzehAds873AH7E+ua4evoRDH1ru/L9+jvNgmu7Tqk4XeIWoqoYp?=
 =?us-ascii?Q?n0fNDUMKQ37YwYY73DfBwmzcvBQ2przkX2kbyliPnKHj3xe0tnoFvHq6IZky?=
 =?us-ascii?Q?IXt8OT6YnQEG9QImrAl44j9Jz+LLh7L2WA/wu2BfJPiMNDqYQfQ6EkpYf7P5?=
 =?us-ascii?Q?OyMgr5h4DvT7SDofCFjC0lgGWfJrMLR/5sGoBeUpIZ05/o5B2vnsyvYfnqaU?=
 =?us-ascii?Q?o52LpuNmy7nk2ORDH5ixlQXHjJ+he+Tgo8VcP2/CdtjOVtz5P4LKapDol9NK?=
 =?us-ascii?Q?kF3IiRIGKjy3327/kS5syVaQux67WEpu861t4HlizzXtI663c/wRVMWfKodA?=
 =?us-ascii?Q?gM+wWjOuezR4OIphicBDUWv+SB1Gpmm476696Rc4SW/a3t2NvG8/dn9NS0/8?=
 =?us-ascii?Q?htcK1OfYs8HmoZKRKSu/6iTgd5p18gs9vjHxagAqEaDCF/+3c4SC5YF7u3M6?=
 =?us-ascii?Q?pqrexeIPa+xIQlB/Kb8ND4Jwfe4j29gFQGSJHK9S8Wos5Td4A+XidtD3xE95?=
 =?us-ascii?Q?8Cot+M/FSyNFFg3vOantY9KP2ZN8tvt3h+aLD8UX5XYBwIavoGBEuAVO6NGO?=
 =?us-ascii?Q?qLMXN/d3vokzp77LvFrZv62CGZguRNzBihLrX17RjuWYcYIkpLEON6gwGoHU?=
 =?us-ascii?Q?sw8vayK9lhs46Dp3w/Jg64t2JXIyez0HYrAHnOQblCi80dX1ZJVrAQuupYJB?=
 =?us-ascii?Q?CbIx7+Hk20RkCbwzKzaKiet+k/yBi0Y//WcC?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:43:39.1453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 683fde0b-2ad4-49a1-a4d7-08dd7c2be91e
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7974
X-Proofpoint-GUID: FBKs68L3TS_WbIdlZ0Fg__U1rpodBzyA
X-Proofpoint-ORIG-GUID: FBKs68L3TS_WbIdlZ0Fg__U1rpodBzyA
X-Authority-Analysis: v=2.4 cv=Hc0UTjE8 c=1 sm=1 tr=0 ts=67fe709d cx=c_pps a=i94dX+5hBIrr0Xz7fFY0Kg==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=XaN_xNRfQhIcEuIFVvIA:9 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504150104

Add mdb_offload_fail_notification option support.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in |  9 +++++++++
 2 files changed, 28 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 1fe89551..d98bfa5a 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -62,6 +62,7 @@ static void print_explain(FILE *f)
 		"		  [ nf_call_iptables NF_CALL_IPTABLES ]\n"
 		"		  [ nf_call_ip6tables NF_CALL_IP6TABLES ]\n"
 		"		  [ nf_call_arptables NF_CALL_ARPTABLES ]\n"
+		"		  [ mdb_offload_fail_notification MDB_OFFLOAD_FAIL_NOTIFICATION ]\n"
 		"\n"
 		"Where: VLAN_PROTOCOL := { 802.1Q | 802.1ad }\n"
 	);
@@ -413,6 +414,18 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
 
 			addattr8(n, 1024, IFLA_BR_NF_CALL_ARPTABLES,
 				 nf_call_arpt);
+		} else if (strcmp(*argv, "mdb_offload_fail_notification") == 0) {
+			__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
+			__u8 mofn;
+
+			NEXT_ARG();
+			if (get_u8(&mofn, *argv, 0))
+				invarg("invalid mdb_offload_fail_notification", *argv);
+			bm.optmask |= 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
+			if (mofn)
+				bm.optval |= mofn_bit;
+			else
+				bm.optval &= ~mofn_bit;
 		} else if (matches(*argv, "help") == 0) {
 			explain();
 			return -1;
@@ -620,6 +633,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   rta_getattr_u8(tb[IFLA_BR_MCAST_SNOOPING]));
 
 	if (tb[IFLA_BR_MULTI_BOOLOPT]) {
+		__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
 		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
 		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
 		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
@@ -641,6 +655,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 				   "mst_enabled",
 				   "mst_enabled %u ",
 				   !!(bm->optval & mst_bit));
+		if (bm->optmask & mofn_bit)
+			print_uint(PRINT_ANY,
+				   "mdb_offload_fail_notification",
+				   "mdb_offload_fail_notification %u ",
+				   !!(bm->optval & mofn_bit));
 	}
 
 	if (tb[IFLA_BR_MCAST_ROUTER])
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index efb62481..eea80920 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1753,6 +1753,8 @@ the following additional arguments are supported:
 .BI nf_call_ip6tables " NF_CALL_IP6TABLES "
 ] [
 .BI nf_call_arptables " NF_CALL_ARPTABLES "
+] [
+.BI mdb_offload_fail_notification " MDB_OFFLOAD_FAIL_NOTIFICATION "
 ]
 
 .in +8
@@ -1977,6 +1979,13 @@ or disable
 .RI ( NF_CALL_ARPTABLES " == 0) "
 arptables hooks on the bridge.
 
+.BI mdb_offload_fail_notification " MDB_OFFLOAD_FAIL_NOTIFICATION "
+- turn mdb offload fail notification on
+.RI ( MDB_OFFLOAD_FAIL_NOTIFICATION " > 0) "
+or off
+.RI ( MDB_OFFLOAD_FAIL_NOTIFICATION " == 0). "
+Default is
+.BR 0 .
 
 .in -8
 
-- 
2.49.0


