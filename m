Return-Path: <netdev+bounces-222738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E05B55958
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F601C26DBA
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6215D2571DC;
	Fri, 12 Sep 2025 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="VD6y47JW";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="dOsDHp4T"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245212DC79D;
	Fri, 12 Sep 2025 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757716820; cv=fail; b=PVmnOhoEogmGcH9k/jQzEq5MZidr3NzVs8woMRFwI8gF5YFDXFA2zYD9ICne8aEgE3pck+j+6ElgU3l3EVLmSjGTpSFSQQnLuLZhxvZjva21bqHwl2gSRk4us1G5Qk1R8NQfk/9FLMVwWDC+1Ls4Bek38tmjskY9DlhYcc0lqF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757716820; c=relaxed/simple;
	bh=3FR8s3W4os7wdnGri489XdCIJalWC/nOXgsO14TPBG8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NlMaC9Y2Lctr95IENPa1q1vAxLi4hRaZIVydD3BrGPN/qU7ONS0N2mIxHO41ZB7iM1inpwo0zDDl28VufximTJpqONKijFfsnF4vEJKkB8KWdWY4uB/Ac+2vrg3YUo2Q87Yd78sWFCRMiEjon08Arx6Z3u4MAIyXiJ0CBs7pT4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=VD6y47JW; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=dOsDHp4T; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CGhkqo031575;
	Fri, 12 Sep 2025 17:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=jkKUlCOpIIevV4HtqDaneXFPieY
	xxR3RXFOlHIKT56w=; b=VD6y47JWSR7y3J7HrTm/cWr9Q9tg8MUQ72yR5c8AyCW
	pwk48PzWZPlGhmdYH1KJsH2lmXBNbDCZ2yG7O653+58ykaHPfHEccUeZOXmdI/ea
	ILfqEd31+vdlCFL9I8XN9jPVm+X3pCw1RNGYHJHj0mCJkgF67Kl4ijex9FA36QX4
	bv6rFMYULqNCQFKKv9ZG4KRA9W108ITsrMqfsVbAEc9s7i67KE1StFSOa7DeoiH8
	7z91HI84CzpWKv62jLodkdUw9Ddh+f3NjqqUkI/v+DtD7MplqmOYMiZD2Q589QJK
	FImxy1XflYqkSTVmWA0MXcCR41z3aV4tEyhLGJJnG4w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020092.outbound.protection.outlook.com [52.101.46.92])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 494j5xs5nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 17:39:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlQ1rHOEOW5bu9AFZPCodF1o++uxbQy5avJtABdiP9ZXDj5h9tt7IpSj22wBAaJ9Zbj7Fjfq1UGxz7AioSrPq3XqMoGLNPu4cSKyVTD5a1/uGxmJTSEZglqaW/Tz8rTsEs7sm1HNdbjdosrkrfhtcM0M9dkOK/o1kOwvzxqU52qFJ/I8xjCXbwmNedkp9CZos9PqDwuzHiyXgt4Fnj5d2nLueg6yPwfIbNNw1/qlXMheMU2h2hSEZI3EEHbiKXti1e6EvPeSKdiGgGI7j2Ku0JcmYj6THRlfPbIz1qJclKMVYwdJQmP8IYXW4Lh9cdQ4UgjkCJXZBXRLRV3WcdC/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkKUlCOpIIevV4HtqDaneXFPieYxxR3RXFOlHIKT56w=;
 b=qarboryK1N0PWhHYwwHwIEqEkpUycmu39YX/0sr9ErJExOqVQNfMEkSwTaQHfW5tYpbau+CvqgYru6UyisCCbh/0RR9y9aakFqvZbJ5r5F0nstoWlHrpfDRypu4ol2/QGMNT+pW7hQoITukvAQSa6Tmcv78CFSFkqv6BFZrHdR5gwBxYOiAnZzI1yF99xSJU7wep5/toFLnJNh1o3EL6EZhDVuyRsis3xPmwXyxrIlwMZBenyDg4uBm7H1NIunel06+DR79j/GqqZ41LB/SYWZ+J976uG9oq7sTfS21JOfGn3zGBQzMs5VFocdF5Ozz6aGeOgslBxqZAnVaJfTIFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkKUlCOpIIevV4HtqDaneXFPieYxxR3RXFOlHIKT56w=;
 b=dOsDHp4Tp6RlQ6CaIuuH7tOI+0H4n/4BIee+XSphh5NW+H6t8H0Ip7l13mkWR/5KZg6YPvvDwt9YVOzKnwpH8ykv6kF5SThnnciY7/BZVdnr06fQg/gaqZl+9nLutIlVCyOimgjJsTfgv3vSOT1cMkuYgLHvxvtZ+nYUlWFn9qsfY4NNd+hqmy52slrexVJ+eMU+t9W3iwxVkCTtC3vHXSmpprB5gL1pCKjen4XTebNkYoadw5FLSGVGTQR/Ffaa7BVbRk5DqHwepvr/Uc/yL2x47zncoVGdP4//fHi8qJn/GgETljoPvnYIihpeZWWeqDrgq4OICrE/Y/t+6G2QKQ==
Received: from BY3PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:39b::12)
 by SJ0PR04MB7711.namprd04.prod.outlook.com (2603:10b6:a03:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 22:39:42 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::68) by BY3PR05CA0037.outlook.office365.com
 (2603:10b6:a03:39b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 22:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 22:39:42 +0000
Received: from KC3WPA-EXSE02.ad.garmin.com (10.65.32.85) by cv1wpa-edge1
 (10.60.4.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 17:39:39 -0500
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 KC3WPA-EXSE02.ad.garmin.com (10.65.32.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 12 Sep 2025 17:39:41 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Fri, 12 Sep 2025 17:39:41 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Fri, 12 Sep 2025 17:39:40 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "Ido
 Schimmel" <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
        "Stanislav
 Fomichev" <sdf@fomichev.me>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        "Ahmed
 Zaki" <ahmed.zaki@intel.com>,
        Alexander Lobakin
	<aleksander.lobakin@intel.com>,
        <linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>
Subject: [PATCH net] net: bridge: Trigger host query on v6 addr valid
Date: Fri, 12 Sep 2025 18:39:30 -0400
Message-ID: <20250912223937.1363559-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SJ0PR04MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: b76ab022-bce8-4922-1046-08ddf24d443d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fm/2a8fVCLfV6ECumTGUJfYGvwef/6D0B8S5J6AeeEZGHmKe8A16dQdttPJc?=
 =?us-ascii?Q?Wv9rtyQea5GQpke0zzIypiJDU6iGL64fE6DqFSSl4Wb35arPmRW6zHZTyGJ0?=
 =?us-ascii?Q?XThVyVT5RpaVKN+cifLMpLcZMyRT+evdDpRqXJedyNKuSlAG4GPWNC9PAZGF?=
 =?us-ascii?Q?gqW9kGyoxXQkQZyAPVSklES9JhzPQXnfy439vnFHLQyxXwr8UaISbyvHyv9r?=
 =?us-ascii?Q?Oi+hX5CgMAW2XWqBfoFyWXL9LoxT+pkycGQtOodeELpxRymIHNtGjzca5wQL?=
 =?us-ascii?Q?lsGjfEmi6k5YhygEU6O7GzGnKXz/h+35WSp4mz7OSQGHVVV8Gy2lQf51dahI?=
 =?us-ascii?Q?EP1r3RA30Qe7pqVGwvF5+eW9dJhOkI9oi1gMSIhm02jGB7SNeT1+IuO8x2aq?=
 =?us-ascii?Q?pwZXjuHv0P3utwtE5JqmHdJIPzAuIggOs3djxOQJ7zBaBCj1kQzhRZ6Boifz?=
 =?us-ascii?Q?wicR8FqjeHDVoejnjKT+HuivUmsK1tip3Cc1RTFpaKm1ZObkIeaI/q0WJulo?=
 =?us-ascii?Q?X+BlbxaZw5e0MK9yeqT+CIct7dlSv1QGuo+vH0e995WOm4srPVTREV8M1O64?=
 =?us-ascii?Q?wVN0CvkjPkdmlkAu0pDLzZfKcPd7enGkiw71m+j1xa0ZDA6IoudaVQQRjqOa?=
 =?us-ascii?Q?0MJP/iy/hYkmDkjoWq/fSdFnIa+poCgRCdSTf0DDVcIqGKlSBEhttZTz9hCR?=
 =?us-ascii?Q?KYTeeoSj6ckGOObo8v/1kttkmTwKwFuJiGbC3EB+brFh23BJdcGuT1K1YT9w?=
 =?us-ascii?Q?axdMT9m52yq9wpzgdESdDblpVSs6S6uMy9KeNg508N9nUDkbBScVHUxVQc3d?=
 =?us-ascii?Q?4s3LTIR6sh1L6GlbPg49U4GAHdnY3AQ10G+//qiK1EMCkPc9pgNAsYu/MmFs?=
 =?us-ascii?Q?l3NQK2ay7w5OuTdpEOJ+fxIFxEkVQ6K7SEumCV4EOvRa1vLQV0s/nUsF7z6M?=
 =?us-ascii?Q?aZmw70hP6IkhjW/d6wIaA8iV8hvC5B2SQhXI2SIASBaRpuhia4ToEJgJnolx?=
 =?us-ascii?Q?wzH/FQ5V5MMHh6GoQlhz5qoUsPNjrQCM5gbopPRHqnObnWMyhyCLoYp7MUnK?=
 =?us-ascii?Q?PM5A+aMP6onaWszrQnuB+xXSRV7dsLtSC2y7LGUII0b/Nqzu57xYe8RumqD3?=
 =?us-ascii?Q?lEHQWYPwccay28odtLsuwhW5jXfKHM+hOelCUPXBVJnNouWbaWc1RiC16HD4?=
 =?us-ascii?Q?QBEpt0Btb8TOIZ3qY2xyVwGf4Izqx2G0MQPP+5m/WvgId+yC8OZh2H6bc3lG?=
 =?us-ascii?Q?/UJKrh8LdEfP3ETzdsCGu50UlM1ShP2Poz7P2j9NvXiX7DFCqO8tKl9CMO6q?=
 =?us-ascii?Q?Oqz5TmXpGjc/DcbzjSnd8lPIZt9Q9RabCOjeP3DfNiURa5o/LXVnCnO2z4rW?=
 =?us-ascii?Q?IamW518NqcShS65djVaPgpctoSeZ4tL2YX8+vFtPO04Ns3Qxa2f8npkQpWuO?=
 =?us-ascii?Q?ezsWEiMGYGfyje46r8fktZqsZH8O5LqQww9NRXpprpjmPnWDFVvV/dbFM4D3?=
 =?us-ascii?Q?wUNSC5xne5Pz49PvLezuCjNYwIJxmB7prFaS?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 22:39:42.6222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b76ab022-bce8-4922-1046-08ddf24d443d
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7711
X-Proofpoint-GUID: Sek-XDWhuYst1ssaBW66CzSH9rI0x4T2
X-Proofpoint-ORIG-GUID: Sek-XDWhuYst1ssaBW66CzSH9rI0x4T2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDEwMyBTYWx0ZWRfX5UrdFrs4Pmbz Hgmn/zGjUDYvBHbmaV+CZvWCLnIyef7Ny7/ZgTPSRhFymnIF+DVYs0UiTwkiFLpI3iFCN9BnYtL Y+WGl0abyiW3IgW5vGClAjicdg7Ez0q8s1NAANejVhoJYCFe9xiC+27pZ3DfOJz7munUEK3qHWT
 PAYwibBS/3EjV5h0rMBlIqEBSyhdl41tKaRP/0Is2Cvc+rvDIAMfBA+ILQHWtaAQ+aeoCaCEc2F LpQ6cu0//jtsSTwpaiUcdCnkU1bZfCPUsi9T91zTmehhl9WU19wHauCZ3bWLsaPBboruBaYq/pn hJn0uPm2wUxiXbIvlc3KqC059xD1qxWpfdG44tY6sL/2p6f4CxTdkACRTM4xH/hn2Emv+6bs1hw
 NVMA7cKYA6T9XP463QSpV3BtnEY7ow==
X-Authority-Analysis: v=2.4 cv=QMpoRhLL c=1 sm=1 tr=0 ts=68c4a132 cx=c_pps a=meR/QeV8iCWl+DfqWzMGRQ==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=yJojWOMRYYMA:10 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=H2BlT3W3kKjHlJytyQQA:9 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 classifier=typeunknown authscore=0 authtc=
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2507300000 definitions=main-2509120103

Trigger the bridge to (re)start sending out Queries to the Host once
IPv6 address becomes valid.

In current implementation, once the bridge (interface) is brought up,
the bridge will start trying to send v4 and v6 Queries to the Host
immediately. However, at that time most likely the IPv6 address of
the bridge interface is not valid yet, and thus the send (actually
the alloc) operation will fail. So the first v6 Startup Query is
always missed.

This caused a ripple effect on the timing of Querier Election. In
current implementation, :: always wins the election. In order for
the "real" election to take place, the bridge would have to first
select itself (this happens when a v6 Query is successfully sent
to the Host), and then do the real address comparison when the next
Query is received. In worst cast scenario, the bridge would have to
wait for [Startup Query Interval] seconds (for the second Query to
be sent to the Host) plus [Query Interval] seconds (for the real
Querier to send the next Query) before it can recognize the real
Querier.

This patch adds a new notification NETDEV_NEWADDR when IPv6 address
becomes valid. When the bridge receives the notification, it will
restart the Startup Queries (much like how the bridge handles port
NETDEV_CHANGE events today).

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 include/linux/netdevice.h |  1 +
 net/bridge/br.c           |  5 +++++
 net/bridge/br_multicast.c | 16 ++++++++++++++++
 net/bridge/br_private.h   |  1 +
 net/core/dev.c            | 10 +++++-----
 net/ipv6/addrconf.c       |  3 +++
 6 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3a3b761abfb..27297e46e064 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3129,6 +3129,7 @@ enum netdev_cmd {
        NETDEV_REGISTER,
        NETDEV_UNREGISTER,
        NETDEV_CHANGEMTU,       /* notify after mtu change happened */
+       NETDEV_NEWADDR,
        NETDEV_CHANGEADDR,      /* notify after the address change */
        NETDEV_PRE_CHANGEADDR,  /* notify before the address change */
        NETDEV_GOING_DOWN,
diff --git a/net/bridge/br.c b/net/bridge/br.c
index c683baa3847f..6f66965e8075 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -49,6 +49,11 @@ static int br_device_event(struct notifier_block *unused=
, unsigned long event, v

                        return NOTIFY_DONE;
                }
+
+               if (event =3D=3D NETDEV_NEWADDR) {
+                       br_multicast_enable_host(netdev_priv(dev));
+                       return NOTIFY_DONE;
+               }
        }

        if (is_vlan_dev(dev)) {
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 8ce145938b02..5a138c5731f5 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2076,6 +2076,22 @@ static void br_multicast_enable(struct bridge_mcast_=
own_query *query)
                mod_timer(&query->timer, jiffies);
 }

+void br_multicast_enable_host(struct net_bridge *br)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+       spin_lock_bh(&br->multicast_lock);
+
+       if (!br_opt_get(br, BROPT_MULTICAST_ENABLED) ||
+           !netif_running(br->dev))
+               goto out;
+
+       br_multicast_enable(&br->multicast_ctx.ip6_own_query);
+
+out:
+       spin_unlock_bh(&br->multicast_lock);
+#endif
+}
+
 static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *p=
mctx)
 {
        struct net_bridge *br =3D pmctx->port->br;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 8de0904b9627..16864286dc0d 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -967,6 +967,7 @@ br_mdb_entry_skb_get(struct net_bridge_mcast *brmctx, s=
truct sk_buff *skb,
                     u16 vid);
 int br_multicast_add_port(struct net_bridge_port *port);
 void br_multicast_del_port(struct net_bridge_port *port);
+void br_multicast_enable_host(struct net_bridge *br);
 void br_multicast_enable_port(struct net_bridge_port *port);
 void br_multicast_disable_port(struct net_bridge_port *port);
 void br_multicast_init(struct net_bridge *br);
diff --git a/net/core/dev.c b/net/core/dev.c
index 93a25d87b86b..70a9f379f003 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1843,11 +1843,11 @@ const char *netdev_cmd_to_name(enum netdev_cmd cmd)
                return "NETDEV_" __stringify(val);
        switch (cmd) {
        N(UP) N(DOWN) N(REBOOT) N(CHANGE) N(REGISTER) N(UNREGISTER)
-       N(CHANGEMTU) N(CHANGEADDR) N(GOING_DOWN) N(CHANGENAME) N(FEAT_CHANG=
E)
-       N(BONDING_FAILOVER) N(PRE_UP) N(PRE_TYPE_CHANGE) N(POST_TYPE_CHANGE=
)
-       N(POST_INIT) N(PRE_UNINIT) N(RELEASE) N(NOTIFY_PEERS) N(JOIN)
-       N(CHANGEUPPER) N(RESEND_IGMP) N(PRECHANGEMTU) N(CHANGEINFODATA)
-       N(BONDING_INFO) N(PRECHANGEUPPER) N(CHANGELOWERSTATE)
+       N(CHANGEMTU) N(NEWADDR) N(CHANGEADDR) N(GOING_DOWN) N(CHANGENAME)
+       N(FEAT_CHANGE) N(BONDING_FAILOVER) N(PRE_UP) N(PRE_TYPE_CHANGE)
+       N(POST_TYPE_CHANGE) N(POST_INIT) N(PRE_UNINIT) N(RELEASE)
+       N(NOTIFY_PEERS) N(JOIN) N(CHANGEUPPER) N(RESEND_IGMP) N(PRECHANGEMT=
U)
+       N(CHANGEINFODATA) N(BONDING_INFO) N(PRECHANGEUPPER) N(CHANGELOWERST=
ATE)
        N(UDP_TUNNEL_PUSH_INFO) N(UDP_TUNNEL_DROP_INFO) N(CHANGE_TX_QUEUE_L=
EN)
        N(CVLAN_FILTER_PUSH_INFO) N(CVLAN_FILTER_DROP_INFO)
        N(SVLAN_FILTER_PUSH_INFO) N(SVLAN_FILTER_DROP_INFO)
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f17a5dd4789f..785952377d69 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6292,6 +6292,9 @@ static void __ipv6_ifa_notify(int event, struct inet6=
_ifaddr *ifp)
                        addrconf_prefix_route(&ifp->peer_addr, 128,
                                              ifp->rt_priority, ifp->idev->=
dev,
                                              0, 0, GFP_ATOMIC);
+
+               call_netdevice_notifiers(NETDEV_NEWADDR, ifp->idev->dev);
+
                break;
        case RTM_DELADDR:
                if (ifp->idev->cnf.forwarding)
--
2.50.1


________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.

