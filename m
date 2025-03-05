Return-Path: <netdev+bounces-172194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A091CA50C88
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 21:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD4A1881F85
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 20:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CED8253B4E;
	Wed,  5 Mar 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="KwXmiWuE";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="Apa034+w"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642FD255E20;
	Wed,  5 Mar 2025 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206551; cv=fail; b=ToxYS2pRN1F0/z3jPGs/Oi3t7MBGjQ7CBYWssNwQ/qlLzT4lFfzKhrZOcqFeKn+0ozkQqYjpByfNj1rjtjt16T51M3pYhiphYqLTm7+Pfr/rGB6p9+B4KguY0D0TLdaqqfVRfe2iF4MczaNnRvH0CZ0d97SMJ4T9eqCmIKcKUcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206551; c=relaxed/simple;
	bh=3FJoO7RwPY8zzem/9amIPLmCwFz2ki9kv8SPXphSFXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQeoHjq7VkKtSEr47qJENYZz2jaQx89wtkEXJn6waYee181jHza+RmqU13R/kwmLHHzgNUbRgwfY7YzTIZ+tNG84+bO9lgA6I8C8FGC7mQNNp+NpWBtuj3WPpbfqVV9mDrk4oxkzUcplB1VaLYTtb/vkQbbp7Ul43uCAoCb0grg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=KwXmiWuE; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=Apa034+w; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IHEpv021287;
	Wed, 5 Mar 2025 14:28:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=n55kS
	dJl4CzuIEZx96lk6jVMa2PXPjDYqTCmJjyBw4U=; b=KwXmiWuEQ1WLQ7gWoFMao
	k1swErVLCPdL8ocHSe8zd+LtCdRQLU3ECA7btkhZ5j1FMNRWvuf3qiJWOCzlMF3s
	yQoLupXkFfSjoz6OVF5gOApV5lQIT2wULHLFJOQ9iHM0vozi9shyIEohR1VmhS1n
	8aMj6elnwxsCTiF1YHIOnZjyGKX6YpMYvZx6DBzmsgEW0awPj4E5gUscPypl5yRM
	Lgd52qHGZ+aMYa7pITeOtOOaHWWjPpgd1iecXFtuP98tBFMKcB9XaHkJy8z6HU+8
	PFF0A77fRjR84dSY6ezgYiN+lMMXMbn1sEEqqtOTzwkLroXKUFRLFkARK4TOZtuY
	g==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.11])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 456nes95um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 14:28:44 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjK03FnqPaQMyJLyBmpGurcwPFS6Xbe+wwOfRTq92wab+MJ+YgKqFMqRzJm5nG3xdjqUiFp5gzVkTM/7QN/E9c4IN+jMatzNC3Kosa48LICOKeDpEuctqUkOw1T1vmJ/OQ7au4QsA29M0xhns2JsLRvVacXvJzfMis+diF9AFCJOS0YFICjMN52L1IZMvAKChXS2IfDjur4UPKqROY8ZeqzXMXGgFX52mBm83rhzmdXwQHAN/fuAvGhynBtIPDL/K6kP2nmu8LikmBDFwCEgB1TevfRtkuR6SXnK3dKLdsNl4tGHNPX6K7EzX0CP1HgH5OVJMJBWu3C7C8DooMToiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n55kSdJl4CzuIEZx96lk6jVMa2PXPjDYqTCmJjyBw4U=;
 b=H4NGZtH/h+Fe1oyfNGhhCyPMycW2uWj+exZ/REHjO7jd4wSLcclsvvK+m07Vwi7vko948HauQ3PmRPAXe39V22P2n7JIjuDTKRDVVdJom/qipNgfycP9syTlV9BNnHXrJJEV8MTPr9B8RDsx+/AmoO93o79/sUNHsuyrO0Cs0xqv+Q7IE/GDrrOXYrh/8Ecfr98U8i9/bT6c/sJ6VYm2QVijSY8oS1GAv13IxlKi86a05qz2MMrG5UbrjWggbsB1HYQb0QEs2Rbb2+yFND1Cn8UZNKSJHwG7obNTCwuKb3OExEzFotSRG6qTwmfwIlXazTv5mSOA1fn43Wlc3KWsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n55kSdJl4CzuIEZx96lk6jVMa2PXPjDYqTCmJjyBw4U=;
 b=Apa034+wp5o0gjpD1I/YZKe4I2ZDvHIPG5l3i4++bm8Z9qU4jVuoaMTPDjc3yrThfI/vMAz02nzPgXF3krHo7CSgWbzRVGBuUN53sW4W6slzYd/aykH9BKsYpmb2JucQ9SGWowp3oE/+7muy6ulJBjLRnMc29U8jedqjmCguTUqNFrXxes2HGwjSmErUE7yfHnIwzadE/f6FlRcuGA+YMUR+2h91Hvi8r9HtlFqLMZLKOv8xdg4moo/kB4G/Q0SvSUcbe3sKOf5FVKeQYoaeR66FfbEjY++AObzPEiqmypTMP/XKhsu2T+ZaO6WVbSZsXifunxZB3fw05P5qnRtIJA==
Received: from CH5P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::25)
 by BY1PR04MB9563.namprd04.prod.outlook.com (2603:10b6:a03:5af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 20:28:36 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::d5) by CH5P220CA0018.outlook.office365.com
 (2603:10b6:610:1ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 20:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:28:35 +0000
Received: from kc3wpa-exmb4.ad.garmin.com (10.65.32.84) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 14:28:33 -0600
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 kc3wpa-exmb4.ad.garmin.com (10.65.32.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Wed, 5 Mar 2025 14:28:35 -0600
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 14:28:34 -0600
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 5 Mar 2025 14:28:33 -0600
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net 1/1] net: dsa: mv88e6xxx: Verify after ATU Load ops
Date: Wed, 5 Mar 2025 15:28:27 -0500
Message-ID: <20250305202828.3545731-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304235352.3259613-1-Joseph.Huang@garmin.com>
References: <20250304235352.3259613-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|BY1PR04MB9563:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d6e17e-479b-4b05-355f-08dd5c244e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oZVdS9+Jqhr8wlONrNRauNLuBbGLYKB66/9yUh1cbo3/xxqoNdTMRY3Q8Hn3?=
 =?us-ascii?Q?y6w2grXlSc8/WrBGc46OcJYySZb6iIgCNglV2wXodagbqoVKUPz/Gb9OsePP?=
 =?us-ascii?Q?ewKfzjb98wYp3I4jyNq4XDGGXhSWu1xhIjaZNM+6zySjTA77eAc+cTBD7cJx?=
 =?us-ascii?Q?pfMk5yh74dbzX+LK1U+vbljrcLKbbF32MGosCI0ZeOLSumOaGZcyl9I/VaNC?=
 =?us-ascii?Q?DYW8a+7XAG8bRc/ILtPa78rVOBLIArSHvPCttLJ6jim11yAgf3iL6bXEPPpe?=
 =?us-ascii?Q?D2YttnC5ClL57sQ8Xy5QCGg6pjEtv8Q+/1U1KkeZTau0Do3zKUvoP6JHA9Lw?=
 =?us-ascii?Q?DvzBwrlpMSgbqLb+uBugagvZIOCatS8U/TtOm2A6/RTQU6eIBqjKnzsYhU3j?=
 =?us-ascii?Q?4piZSK4iIeOJjQnOT2cocwEkagvteW2QHnE+0uoiznzDOEBbbJG+Loi/+URV?=
 =?us-ascii?Q?ns9zW+42oJx8xhffqLgT7fHIAp0MaT6dC/Ed+uEEuD0XGdrskVXAeldMNuXB?=
 =?us-ascii?Q?iM9gOfdbBmUfQolnW9DAonqUF+m0fanjYf8jApWS3FJDI0qNfTWREh7ZwDqX?=
 =?us-ascii?Q?q26KxjMW+x4Olmah0SBwOhX5SDKsp3t5MSm88Q4zRxuOf/FVUUQAL586J82b?=
 =?us-ascii?Q?Q9HxmJ1iDy3WKFf6TBhWujNKJM8fPKwpYpGOnNPXpMNzil55lHCDDQv2HuDG?=
 =?us-ascii?Q?/f6WY4eAZlyAuGG31i311Q8jy5iSzc922Xu4GVVZC0bKHIPMi7HF+h7sshJw?=
 =?us-ascii?Q?Wyiwqf/bsQvcIySFrcXHAxuIAMY8O80hS+yptZLeNJSnwPP+U7SwfniOiPyN?=
 =?us-ascii?Q?j7wmBhLNfY441jJkrfDxXCmTh7nnuMfFMCBscFqC2Jd3+zlj2PHyLFEL8YLb?=
 =?us-ascii?Q?llMjjrIm9mztnOBXxWK7C4H7bLDPcrwq62qEAdCsH1uwHicYgcWGty+g14By?=
 =?us-ascii?Q?zLjVMrQP6m/B5wOyOQ55Le+WWqqtw5ZG6lziSMgJaTwKoWVuoJZN1H/Ab/aU?=
 =?us-ascii?Q?zxtU2WPk2CIS4SyfJ2V06gVCBK12NYAoGKAidrWAlyE31kgjT50CoLMvqXrh?=
 =?us-ascii?Q?hcDDewLytoHduq3581Mn2V9YmSrE2SUt/D1EHsDOzds9jgvqP1PrDnyM6G0M?=
 =?us-ascii?Q?E1gpnZwt9OTfiN6qKm9wSVBkHZlzF8IMzy84Bc2RfPEqnIOX/Sm3G2Szw/1h?=
 =?us-ascii?Q?rLJ7le1XHDu1l4flmxZ/MlgzYHhyCK7V8o3PExoU+lK5G0Gw14hi9HQQAmib?=
 =?us-ascii?Q?vlsB66j5z3L3wWI5bld0weYlmC6GOazySRPF/goPeAqqQglc14tcRP7TtkFc?=
 =?us-ascii?Q?2WClVW1mSil3pM9zyBmZizfe1QxUUp7nqqKto32G10XVXOZo7+y2xt+yj9kG?=
 =?us-ascii?Q?3IWKjdgUonnEDCZe2xbA5nYwBxGUYkiB5/EqH4UIBS3DJHg/3mOaNaw26rp8?=
 =?us-ascii?Q?opuWUcnSOqIm5gINTjkbyQUfdi1xwXCN4rjjdb5E+eQ/o0hbIyloUU07HDUs?=
 =?us-ascii?Q?N7a9oi31MEiH5z4=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:28:35.8431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d6e17e-479b-4b05-355f-08dd5c244e59
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB9563
X-Authority-Analysis: v=2.4 cv=XZdzzJ55 c=1 sm=1 tr=0 ts=67c8b3fc cx=c_pps a=XJbScVYJ+YTk0JuXi+vtpg==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10
 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=mfjfP0T1MaGNimHTBpYA:9 a=VYcpXjmDHnEIALPoEwzu:22 cc=ntf
X-Proofpoint-ORIG-GUID: yrQorQMOdrJZzFURgcu8CO_0gR9kR1Hq
X-Proofpoint-GUID: yrQorQMOdrJZzFURgcu8CO_0gR9kR1Hq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=752 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503050156

ATU Load operations could fail silently if there's not enough space
on the device to hold the new entry. When this happens, the symptom
depends on the unknown flood settings. If unknown multicast flood is
disabled, the multicast packets are dropped when the ATU table is
full. If unknown multicast flood is enabled, the multicast packets
will be flooded to all ports. Either way, IGMP snooping is broken
when the ATU Load operation fails silently.

Do a Read-After-Write verification after each fdb/mdb add operation
to make sure that the operation was really successful, and return
-ENOSPC otherwise.

Fixes: defb05b9b9b4 ("net: dsa: mv88e6xxx: Add support for fdb_add, fdb_del, and fdb_getnext")
Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
V1: https://lore.kernel.org/lkml/20250304235352.3259613-1-Joseph.Huang@garmin.com/
V2: Add helper function to check the existence of an entry and only
    call it in mv88e6xxx_port_fdb/mdb_add().
---
 drivers/net/dsa/mv88e6xxx/chip.c | 59 ++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 68d1e891752b..1a2b51598275 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2208,13 +2208,11 @@ mv88e6xxx_port_vlan_prepare(struct dsa_switch *ds, int port,
 	return err;
 }
 
-static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
-					const unsigned char *addr, u16 vid,
-					u8 state)
+static int mv88e6xxx_port_db_get(struct mv88e6xxx_chip *chip,
+				 const unsigned char *addr, u16 vid,
+				 u16 *fid, struct mv88e6xxx_atu_entry *entry)
 {
-	struct mv88e6xxx_atu_entry entry;
 	struct mv88e6xxx_vtu_entry vlan;
-	u16 fid;
 	int err;
 
 	/* Ports have two private address databases: one for when the port is
@@ -2225,7 +2223,7 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 	 * VLAN ID into the port's database used for VLAN-unaware bridging.
 	 */
 	if (vid == 0) {
-		fid = MV88E6XXX_FID_BRIDGED;
+		*fid = MV88E6XXX_FID_BRIDGED;
 	} else {
 		err = mv88e6xxx_vtu_get(chip, vid, &vlan);
 		if (err)
@@ -2235,14 +2233,39 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 		if (!vlan.valid)
 			return -EOPNOTSUPP;
 
-		fid = vlan.fid;
+		*fid = vlan.fid;
 	}
 
-	entry.state = 0;
-	ether_addr_copy(entry.mac, addr);
-	eth_addr_dec(entry.mac);
+	entry->state = 0;
+	ether_addr_copy(entry->mac, addr);
+	eth_addr_dec(entry->mac);
+
+	return mv88e6xxx_g1_atu_getnext(chip, *fid, entry);
+}
+
+static bool mv88e6xxx_port_db_find(struct mv88e6xxx_chip *chip,
+				   const unsigned char *addr, u16 vid)
+{
+	struct mv88e6xxx_atu_entry entry;
+	u16 fid;
+	int err;
 
-	err = mv88e6xxx_g1_atu_getnext(chip, fid, &entry);
+	err = mv88e6xxx_port_db_get(chip, addr, vid, &fid, &entry);
+	if (err)
+		return false;
+
+	return entry.state && ether_addr_equal(entry.mac, addr);
+}
+
+static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
+					const unsigned char *addr, u16 vid,
+					u8 state)
+{
+	struct mv88e6xxx_atu_entry entry;
+	u16 fid;
+	int err;
+
+	err = mv88e6xxx_port_db_get(chip, addr, vid, &fid, &entry);
 	if (err)
 		return err;
 
@@ -2847,6 +2870,13 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
 	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
 					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
 	mv88e6xxx_reg_unlock(chip);
+	if (err)
+		return err;
+
+	mv88e6xxx_reg_lock(chip);
+	if (!mv88e6xxx_port_db_find(chip, addr, vid))
+		err = -ENOSPC;
+	mv88e6xxx_reg_unlock(chip);
 
 	return err;
 }
@@ -6615,6 +6645,13 @@ static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
 					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
 	mv88e6xxx_reg_unlock(chip);
+	if (err)
+		return err;
+
+	mv88e6xxx_reg_lock(chip);
+	if (!mv88e6xxx_port_db_find(chip, mdb->addr, mdb->vid))
+		err = -ENOSPC;
+	mv88e6xxx_reg_unlock(chip);
 
 	return err;
 }
-- 
2.48.1


