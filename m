Return-Path: <netdev+bounces-180350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D6A81091
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6115D3BFAC7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25261229B0E;
	Tue,  8 Apr 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="h77Ix/f8";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="ISAfMs/F"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CDD1E9B16;
	Tue,  8 Apr 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126928; cv=fail; b=H598wo6f0tgfbdqZYPpeUzozl+bOHM8THXb+uDJ7vtx0L+8vPCFhZDw5RMgLFeYFZhjiSoHkbKDJCKoU1Enqo6yX6TawCyjPCez3GMy9vxpP8J/Ti9S7V/zYcXscuBqXfmFrPJnkUbIWNs0LnvAbA0En68yTJoKEnt3uZQLAqXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126928; c=relaxed/simple;
	bh=y04xyaLRJu6VYj94ytWDrz2ogC6ENunkKCZNclrC3HU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sA8yJZf5dOqzJotdkn3vfdIvHHzh9Hfz/soDqvyC7XfpkYaHv5cbo94U1ELNfZecyVEmamQAgmC0VilveZbkhPuynuiVokuaD5UNbK7KswrNJXRtswAJiM925x/j0OiPCDj8AHPuZ/Ue8m16jGpHoHrttji9/kV0TcFDyvDtJkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=h77Ix/f8; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=ISAfMs/F; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220294.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538FOSl0014875;
	Tue, 8 Apr 2025 10:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=qoxJKgRa0dr7pYIiP98QkveS9x5
	7FaxEb3HzrQlzOZ4=; b=h77Ix/f8FaQRt//K8+gishoOZ/KjZf16op6cWNcKQDX
	EMso1Wx1qMNKEC1EcNKV0sUxP9wxlnYJYb7mb7REWblFzqNd2KEpP9ZZkJC34KkN
	UEyDDBwiMoQI3UqtoIfGQOFJiU4L02Ngj6MOUpvr2+YOByfMTzUBzZUAXsPaHW2Y
	pgFebP+1QGDq1YmL5VBD+5XiwdqmbuuzcI8EIRlWnwuSEcmwyhD1zUtVkD21KsHU
	9FW9SoIu6S6PctYrw0fafRv+eu2+tfq3QDMBVAP8OZASgXkLrcna8Gs9vknY/baU
	iRS6X2BrxGZZAfOBQpJ4yKjckXhCRxw7ByXkH/5PRDw==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010000.outbound.protection.outlook.com [40.93.13.0])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45w22hrmqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 10:41:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIMqrZP6r3i4qwa+li4hiOk9yl/f+QlseN5JghMVMSAHbk1ky0Tyzl0KKxDNVCAoHrULGW++Pwg50VNVWBih7CtMXy+/IEpFLkoA0VExJuLxH0WMiPc4PZo8KKfWoqLYbDauMBbrrLtt+WO4Y2MsleUT6yLn6QLbAdSCQVIoLbuhOyUkpL2vPJScWD0UbS9LY3gpiyNcbrCv+C8zcBS9ZERvMat8TDB6CPD69M6/9vkSmmzAwbCI5666pVhdJfobx103UXts/chcGADxcJ6DW4RtOg5zZ4NCGFA5eh6zRtwmQyYyuzN8AM+Fd1CKRj2/qUkhzymb+YZXBsoKvy6imw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoxJKgRa0dr7pYIiP98QkveS9x57FaxEb3HzrQlzOZ4=;
 b=j/0Bk0XRJ351ByBgZuqIlKieNFaxQHWv//XOtzG5AUhhqCA7M2au5AM4FCJYlnWwf3/RaLnlMsjNmZhsl1KARibroeCtIL19PpjRTfKJZAwrVnM0IVy3fbXhXtQBS2fVE4+3Tvu7VWRlNMARhGx+NNUco/LQpbIaEQfEHtMz8gATldEAL5dY/DP/v6g1jE3WCW450+RQtPJ0P+yFL0fIv+YyeRs5pGKTAZ3/fwzFRhHjdWlt2KUDaVOkCKrZmM+Yc9irjzwM5+wTgFDzl90cWwvSqjilcTU3YHpMcoNF0k2flls2w/FKFrX1iPLZKUth5+je+UD7AeHEPjURtLbgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoxJKgRa0dr7pYIiP98QkveS9x57FaxEb3HzrQlzOZ4=;
 b=ISAfMs/FyNNNESlB6LwQf7ZWN4YDUmbcLaYKcElb0FySYPLHL8jWHOfUPfh1x0eGTqSwmf9V0252mslue7MKUQKHZoSyRqVJ5hLYqnpZPsMzc1OhEMFvlwh0W9uT6uCJywNu7e5SjOd1tTORff94VBcwciiy8F5o2wrbG1fojNZvTVuTwBrXxEtVuRglAAQ4krGnp8vevgAQCAKL8ttM/v+g3UuUt+vyFrNFU/femqsDVQMeCIdppO5OpFffAC1ypsGtA+a3pBOOxrcaX+yn/xhYbEDTWdxR2D0Yf9wL9iz4wR/wkeG+bSOLsX4m4MWOq9zdHkj6oMohAq6m0TrC5Q==
Received: from BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::17)
 by BY5PR04MB6455.namprd04.prod.outlook.com (2603:10b6:a03:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 15:41:32 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::f3) by BL1P221CA0021.outlook.office365.com
 (2603:10b6:208:2c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Tue,
 8 Apr 2025 15:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.0 via Frontend Transport; Tue, 8 Apr 2025 15:41:31 +0000
Received: from OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 10:41:27 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Apr 2025 10:41:28 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Apr 2025 10:41:28 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Apr 2025 10:41:27 -0500
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
Subject: [Patch v4 net-next 0/3] Add support for mdb offload failure notification
Date: Tue, 8 Apr 2025 11:41:08 -0400
Message-ID: <20250408154116.3032467-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|BY5PR04MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b50816-99fd-42dd-7fc7-08dd76b3d5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWfeD84IgyWfcZent6tLy3vj0qdqdE95/eueV3NZ+FfmOmkSTZE7IEx5ZAuK?=
 =?us-ascii?Q?bKiZPbyr6FXHj7c30CEAQuUF/Fin9Gnmjby1s3Q3I9FhazoIZgiZNbb0Ujcw?=
 =?us-ascii?Q?7YHC8cBEsIde3Qfi3Yqu/s1LCjl0Iug06780L8ScmzMd/+R6Mf48I4Jwfdwk?=
 =?us-ascii?Q?8rQZ+YAmaU5+Jqx/dyX0wqEbJp5sTXiia60vuCg4GH8M3toG8QHwlEjCZPZG?=
 =?us-ascii?Q?UJqnFKawX5zDhBy6GNFotns6mxGWkf2SQSRLIUqECD011Yp4Ac3xVwuvWBV3?=
 =?us-ascii?Q?awthXzdplmExtikdL8KxQdC0smovenGTnLNk1UyBIQCFz4nTHjyEUOBVc5/3?=
 =?us-ascii?Q?mUnxHSeWJ8RwBpBjO4KQslmJg+SwfeLtSvPao/ZIEgG/Ef7nABnyDmiO42+o?=
 =?us-ascii?Q?IxEAfjehiAXD35Tlv48i+f7FVaFw1FvVwuhyzW+EF4T/ia9f9D/v4rbdnRew?=
 =?us-ascii?Q?KeBee612wGNd2zsaqDRxMTe/Qy1gQAfyVA1G7giU72kqhyUEnYjvUBrM2cKh?=
 =?us-ascii?Q?BPxASdyY1fULE4LsABxXZHNba7oyif1J74V1dvAU5dnx3XogC8dDmGPo3fvO?=
 =?us-ascii?Q?SQalyMYcqp8VebKqsM7n9oh/ZS96F7cCH5xwQleA1rJlkZk5nwDxoE2/1Nuu?=
 =?us-ascii?Q?6y0zfWK14fXbnoTOiy/1rCWKgwdzfJyif+OnWDZQPti83XNMAGZJZuYjsnK2?=
 =?us-ascii?Q?qxHQqhVx15uUFe8aoQjIjUOX/CNMoI8O2JUp+DwALQTMKOIpdc3HhnUOZa3t?=
 =?us-ascii?Q?bNu1FoeyptwaEd5EDsQJJTQ+IgsYjJ2KUoXLeYCQBL2qUGVL1bfxOn0ooFR0?=
 =?us-ascii?Q?TiWek8b2u91nFPuudNG5ONL/7A30pMxmDuuodhbblj3XHimxYkGe1ZZOyJqZ?=
 =?us-ascii?Q?nm15PuEqhewTW1R7TqwrnVnPJqElerJhJw2I99pHz+9JqzCcmLs6/6viQGo3?=
 =?us-ascii?Q?EauEvjM4ZE195GJp5dNjiqBE/xbI4Xuwc13lA1CeX92SbZyTdaezISNmiDAG?=
 =?us-ascii?Q?EyT++8tWCDR4ALq80OIv/NF7YAxdxJfn/KBSuAM1Mt9hYqxVqZBYCGc9buAH?=
 =?us-ascii?Q?fcMb5oqxQyw0Ho/Wt5bySK8On2ki+2xvRTvI8o8ushs3W+GDhCHlF+hGKKuX?=
 =?us-ascii?Q?M2Y282E0GhuVhgpVnMBRB0yVg1KvepM1/S0JWGegIG4fXP34ujjcwupR2+RY?=
 =?us-ascii?Q?KfK0Hbiqg81aRqBLOkkTntR+U7GjNUch4OEjw3bWfRKyFW3UHaV6/DuoB6LI?=
 =?us-ascii?Q?5JmSEjB544wT4UQMQDDLMVBLQAvMUPduIqz341kky3MpLLH+DyYYVLdi1nAW?=
 =?us-ascii?Q?3UrMfrfXmpWAzNNeVoaCUvXhf+y3UczOe0bUVAt0ODy7KkHVYh1o6vXa3inY?=
 =?us-ascii?Q?r/1Lh1k+QQeSe6hBF6t11ssgSZHQ8RYna42LrIbAQZzLu51DxAAurbQpKLQj?=
 =?us-ascii?Q?YSSKcAUQGf1D4A6HSHOcSUPcb/YF337LDJ3erzDdFN+gv3eB/fA5ZpBh6XS0?=
 =?us-ascii?Q?8QLJosBpzCLLX+k=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:41:31.1471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b50816-99fd-42dd-7fc7-08dd76b3d5b0
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6455
X-Proofpoint-ORIG-GUID: swVA3tlPmWz_Md3o3WldVcoxmZseFsow
X-Authority-Analysis: v=2.4 cv=dqrbC0g4 c=1 sm=1 tr=0 ts=67f543af cx=c_pps a=TrQpY+9r/vRMYizkUk6pNg==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=tssK5cnJvUZjZf1PWA0A:9 cc=ntf
X-Proofpoint-GUID: swVA3tlPmWz_Md3o3WldVcoxmZseFsow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=837
 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502280000 definitions=main-2504080108

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
 net/bridge/br_switchdev.c      | 13 +++++++++----
 5 files changed, 68 insertions(+), 18 deletions(-)

---
v1: https://lore.kernel.org/netdev/20250318224255.143683-1-Joseph.Huang@garmin.com/
    iproute2 link:
    https://lore.kernel.org/netdev/20250318225026.145501-1-Joseph.Huang@garmin.com/
v2: https://lore.kernel.org/netdev/20250403234412.1531714-1-Joseph.Huang@garmin.com/
    iproute2 link:
    https://lore.kernel.org/netdev/20250403235452.1534269-1-Joseph.Huang@garmin.com/
    Add br_multicast_pg_set_offload_flags helper to set offload flags
    Change multi-valued option mdb_notify_on_flag_change to bool option
    mdb_offload_fail_notification
    Change _br_mdb_notify to __br_mdb_notify
    Drop all #ifdef CONFIG_NET_SWITCHDEV
    Add br_mdb_should_notify helper and reorganize code in
    br_switch_mdb_complete
v3: https://lore.kernel.org/netdev/20250404212940.1837879-1-Joseph.Huang@garmin.com/
    iproute2 link:
    https://lore.kernel.org/netdev/20250403235452.1534269-1-Joseph.Huang@garmin.com/
    Patch 1/3 Do not set offload flags when switchdev returns -EOPNOTSUPP
v4: No change (re-post due to merge window open)
-- 
2.49.0


