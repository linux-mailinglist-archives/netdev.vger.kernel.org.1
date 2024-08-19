Return-Path: <netdev+bounces-119933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED679578C7
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C621C23666
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 23:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A47F15D5DA;
	Mon, 19 Aug 2024 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="Ge6JjYpp";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="EhUOzy79"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD6B657;
	Mon, 19 Aug 2024 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724111613; cv=fail; b=TbimtNrfbVOjT35SCZ80/IU1p1EAhnL6fwVzbOBjV3R2PY1asAY3DaVyA7NlB6lxF4ExPo2YLHlfCbsVZsnThnXRAOvOVR/7pMQpkiWdudLWm8QNOxIZkIjJLVHcp84jNOanMzeakmq+W4y8sjW+2X+9Y1cAA7JKN3C1xr8IPE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724111613; c=relaxed/simple;
	bh=8d8LvUkN1h+nDpyc8NAZEMZr9iZBzh9E+dvSqsULAmg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTJnfPONdhL2DK9eLeake3oUsbHGfx+R8rcWKeatzdFkBIvYVG/ou+SclcCwga9giBYExf0GgXm3QCuuJFtHn5o6wyEmvpJIwK4kCaXfEujr7IRjFzm3Uam0t/MRtKURAzJlbFX8BUAO11+Cw3l38cLpQBMCSeUukRb7M2H1WFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=Ge6JjYpp; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=EhUOzy79; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JNp5BZ001925;
	Mon, 19 Aug 2024 18:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=X3t9PCGGB6CJq+Lis8bVhiPkSuG
	cXXLIckuRQjIaZ04=; b=Ge6JjYppiLTqO4eRQcL8bOUyQZhEROUNDUVstAyL9OE
	SwGZPi2z+UlA324/onHnW0YxxLroaISb0i2qjAEooqTkpLzi1vu//LEkdktTsl+C
	IT550E7QUfPLo7fq1TqvWQFMMZt1TjwYhKW8zzD8I33Q5bj5k8b1UyTqT0JF4BY8
	XeLBBN1I8m4Yw8TaU0Vv99Jmbw0EPup+VkmaGd3SNNQetb6Go5J0UQWmhLMX7QoA
	/icuSKnnp8chbw+9Ad9YOgGlYHMg5hwUaMt7vf0xnxLJMv2h3Nyvg6liOdci81g8
	GruNV9yquiWjnuxNHJwfnBExPBxuIilZSUSxdgE/NXg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011027.outbound.protection.outlook.com [40.93.13.27])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 4149940qmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 18:53:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPtYlXYe2srDl+vz8rb/yj6g3hMs79iNeanacfN25gDL1rT/3YnKLNfoMLLmgeAON3EFDOGJDJiHt6zYJOV88sV7gOq5gq1rDMSpHZfsZr4LekJ2y1SYnVKfznVPnnBXJqnSI+w6qgVj9tZtYuFv8gOkIVwwHbuusLEalSVJub04rirpzxQMoBgop+EoOvFAOmHH1sjhIWODlnu4mCZV72qqgbV50v82sD8FUnSIuJgLrrxz6uw1a65zW9t2K2ENLP6TLu2pIYUaTyACBh/y1hqVKjUlXZAi7mklWhEvhqnjUs1Qj+TKrXgVMuA7E0Rg5UY1bjVWWtrx5P6Hv7iuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3t9PCGGB6CJq+Lis8bVhiPkSuGcXXLIckuRQjIaZ04=;
 b=DBvl6kDk0sANWptNYkZD6mCrSdaP8Ih7DjUu+M7zjaatypWVmRRsK1aa5O4dBFvpmiVfv/S2GwPUJ6ykIHdhRweHxWUyIYdDo1fXoQOYA/Lj7trvG1EsowsFvDRNlKYizgypGDWfKMB7w/16UmyO+FC2G/EjYjBUthFMOfBsMBZ5Ygz+Da6mQ7RT1cQJ+6Ob6UWTI2k6G+s6SMIycXkipSbcfR/tpwZobEi9TVd5z/TxGzgy7RgAJRy7GkbMDKNbI1BFzJMED1hbo25c1d19yMWZodOwCNP0mLb/Gr0VENYhWmFnYrUvgTIt9PbUaTbqA3Z8fQ0+793/CyBXW9v7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3t9PCGGB6CJq+Lis8bVhiPkSuGcXXLIckuRQjIaZ04=;
 b=EhUOzy79NN2L8Q2SxdSLffdXNz+nft7YQUfTJaEhQsUt8PBafKfG1fOvGivsC86V2LwLRsFYhSzygh9jQwxkO5XS1raLyHP7YSCnSG9aoIH+0SDrvoX4z8DNBjPwHvi+dXa/I1YPC800nMs/ILEItBEEiveGxmGsFC/1fuv55DmXSFJuJHkMHpBJJ+uVYV2jlhP6jrv1gea2h1p90IHoUwWqn97L17dOkO8Nvgs3ykD/lVrz/JWaYtZH0xHNh/6l79HF8wog+EepiuZHJCECKCK2QfV2MdXd/IYn7XxfLupZZG5ThSFjvzVlcc/9lMXe5A4cOJfnETaqe9A6macPqw==
Received: from CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::29)
 by SA6PR04MB9472.namprd04.prod.outlook.com (2603:10b6:806:439::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 23:53:11 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::c5) by CH0P220CA0014.outlook.office365.com
 (2603:10b6:610:ef::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Mon, 19 Aug 2024 23:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 23:53:11 +0000
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by cv1wpa-edge1
 (10.60.4.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 19 Aug
 2024 18:53:04 -0500
Received: from kc3wpa-exmb4.ad.garmin.com (10.65.32.84) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 19 Aug 2024 18:53:06 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.84) with Microsoft SMTP Server id 15.2.1258.34 via Frontend
 Transport; Mon, 19 Aug 2024 18:53:05 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net 1/1] net: dsa: mv88e6xxx: Fix out-of-bound access
Date: Mon, 19 Aug 2024 19:52:50 -0400
Message-ID: <20240819235251.1331763-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SA6PR04MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d280996-e724-4f82-8a12-08dcc0aa1537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CY6TmJw9/6t7hXNDBTmqMOHWupu74j2f4UbQsS7/MAiz1ZYpbZwseFltAV8f?=
 =?us-ascii?Q?JY00XAhtsHny0PkoW54cfJIy+W4PihWyhBFpMVQj3FpdC8Lu5K5q1uItHLmB?=
 =?us-ascii?Q?0cZ+hhreK6hCVXdAEzzhc6bjEmH6L7DmB3WKBTQQyDuphHYYhbPYvZw3pNzW?=
 =?us-ascii?Q?VCiQeNro68vTJGcUxypfS3WbXTMq4KchmKu7rEjmdL6+7+PirrVo25f4KJ1O?=
 =?us-ascii?Q?OfkeHUxf3L8mYKSQmwKuAPCH9qmEO9KT49Tp0fKoh1Y2Wvr39V2gIUhzbAjF?=
 =?us-ascii?Q?yy2BM3OtkRMc60hV+mH0+sy8obUhTdsRfsIc2EVr1nXGwmTdm9mMoYamEngD?=
 =?us-ascii?Q?3YykTucZ3SflY4BbGZnR/NTn1hGdZpiOxDV/AJobsRvDOjq2A8QEeH6+19Tz?=
 =?us-ascii?Q?sq4PIfJxd3OxeSYQmFpAhTiPBScgfFkmk2EiJFlY+zmYo6Ll6ZXR89Htjrzf?=
 =?us-ascii?Q?Xb9EX/187JybzFX6WLf8U1dmzMrUuK4Gat7QuA5zoleRCXii1/sSf11PeH+t?=
 =?us-ascii?Q?hfCS7yAvkQbB0O+pnU9gnZKWIdpZdK5gWY4Sg+aYsN6IfvfbkQ167jFc+wLr?=
 =?us-ascii?Q?lm6QOHL3h6aeaa9IuysvMQFxSetnuO5vePPSP0PYp3HMqBWK3rNeYDGa0kJV?=
 =?us-ascii?Q?m+VRWz5krk0Y9Exwy/wBHX0fpaxArH3sMb4CUtIQjYC6BaYwXMFqfaWMPnrV?=
 =?us-ascii?Q?XzRjlt5r+g5CDV4Kd/kGLyXtASbf7ZOWzQeHV01AjA0O2mC0FRzNG8rWHPkD?=
 =?us-ascii?Q?rtbsZ7HjD37Z5q2dHjaxjpgKR5dmkqg4Ky8wNct3yCIgXlstLvjDqBatTNZC?=
 =?us-ascii?Q?XytsuibPU0DrNqrjMw0VUUxVcAcfE2hv9IAqPMTHRheH2dFy0fkxGORAzoJv?=
 =?us-ascii?Q?V7fKWZcteuQwb2/MjDfpJIX4lZrxobB5ZeBrBCJjGR7ty15JIKHJx7C4uV/f?=
 =?us-ascii?Q?Zvk4eIrSl84GBU/55HU4tPO23QfikuFUBt0zSR8VZe2s5CeHsvSmjf+hxEDb?=
 =?us-ascii?Q?ROZVNhO7x+i9VC01HVnltY5TDEdytL/J0fqOawAqWR4mCmZ4bl4cMN4bbL/6?=
 =?us-ascii?Q?/0VHm/ALrtXPtHXno6JLnbsW5JfKmOP9TbfusZ/hwK4T4a3TiaWrhZdKnvUg?=
 =?us-ascii?Q?/oQKZvgw2WAS/EDJ4EetVuoFD+PWv6vt/094b5gLU+u1q2Pm39xCcBS1nv65?=
 =?us-ascii?Q?ZQF1vll+Kuz7FZFUdVpMILOWESQuaEfROcluNU0pKmMewtWOz+m/kCrtxTqV?=
 =?us-ascii?Q?g+zTk1DWJmwRmm2S6MCovXnqwaQdvjlBLK4yDvpACE2N5w1QRsxrX4Jf8lK6?=
 =?us-ascii?Q?rVGM5/NhYJ350UQKIgU7tLDQoV6ppbcFeHaOleoLCemQLv85nT1Evp0v//D3?=
 =?us-ascii?Q?dNJlFCSt+KWkiKqpKBo+nCU3HT7o9f4GwuJ5W87qkLA9FLYFgBUforfYwnsZ?=
 =?us-ascii?Q?SYtbjowLHRbVHbcjXS6EuEeTM305urL2?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 23:53:11.1764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d280996-e724-4f82-8a12-08dcc0aa1537
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9472
X-Proofpoint-GUID: LwpjtU0QSEdwwQcagUNPdfOTEbJny_0H
X-Proofpoint-ORIG-GUID: LwpjtU0QSEdwwQcagUNPdfOTEbJny_0H
X-Authority-Analysis: v=2.4 cv=UcoDS7SN c=1 sm=1 tr=0 ts=66c3dae9 cx=c_pps a=U0KzkmEawxegXmCr7eTojA==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=yoJbH4e0A30A:10 a=FS7-D2N0u7gA:10 a=ShUJUk9rLtwA:10 a=NbHB2C0EAAAA:8
 a=VwQbUJbxAAAA:8 a=PTDLi0RsCyGZMGRiyFwA:9 a=AjGcO6oz07-iQ99wixmX:22 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=814
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408190161

If an ATU violation was caused by a CPU Load operation, the SPID could
be larger than DSA_MAX_PORTS (the size of mv88e6xxx_chip.ports[] array).

Fixes: 75c05a74e745 ("net: dsa: mv88e6xxx: Fix counting of ATU violations")
Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
v1: https://lore.kernel.org/lkml/20240819222641.1292308-1-Joseph.Huang@garmin.com/
v2: Use ARRAY_SIZE instead of hard-coded SPID value.
---
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index ce3b3690c3c0..c47f068f56b3 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -457,7 +457,8 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 		trace_mv88e6xxx_atu_full_violation(chip->dev, spid,
 						   entry.portvec, entry.mac,
 						   fid);
-		chip->ports[spid].atu_full_violation++;
+		if (spid < ARRAY_SIZE(chip->ports))
+			chip->ports[spid].atu_full_violation++;
 	}
 
 	return IRQ_HANDLED;
-- 
2.17.1


