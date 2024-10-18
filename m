Return-Path: <netdev+bounces-136801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7039A3269
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6C41C22210
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002C813D26B;
	Fri, 18 Oct 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QWYoqSp7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B3356742
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729217429; cv=fail; b=A5q9/Qp8g2pHgmEKMJqUk34Ms4SAe+BivUdT1f/C53neNKg0sRNhBJ6y6Nal921W0Osc9cxlWH7mqwAa7ew7FjKp6SN6CdK7NTrnQ4IW2zXNtJlbG0YYQhr+Bxu0lJe71lqWHINMxJwm1znKD7S8tKh5eZ02JZ5E+rJL119SVZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729217429; c=relaxed/simple;
	bh=GN/JKA1fmLFn6m/50AFnp1Q7T6AyYAk9QOjGSvIAY/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IEx4LZpLLTvrRxah1hH4gVrA8xMSSjXPtt6QVjpChfWKbxHWxOouR5/CwiPDN6UzIz4vtGRZEQs8N7WwLGGUMF2chTObzQi5XDdqO5WPdqmlHGJqjHPv5QpOu9pA6D2qppPKW9NhY5CWVDoznXK0uolZExAsb1x/OfuG6xBjL8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QWYoqSp7; arc=fail smtp.client-ip=40.107.249.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSQvQ+snTZhOJZouPJ7bLEzKwlgpIrXLuPfjZ3eYB+ZDPRIUn/twW5zW+hbZsFSL4BvmOM2e2M2MQdqPaF1gYu7oYcyQnkATFx6KVuY5YeBZxeh0R1/oQ2zRRstPLMP9yfJWzefif+l4DX0cq+MZjCGifUhDnQfF1vioViOdTJ8EVORhdaPWhCfVnem7iP2iWVYR54nvGdK5Ea5qxbQwV5Ek3wcr2JCr5pUr7xLJ3dKwim7MZamniEbDbHOzIKdUlSjWwP9AHDlwaSm4Dhs9X0ZGDdH80CjMkcfUM8CyAfuLrTnjJ11rVDN4LMRK6oVfORqVh6BSg3/FU9PCA46S6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF7UIu3YyjZf4h3RuFiz4VtvRr53JetmaZvnDIM9rL8=;
 b=q/lH7T0wlXjq2MixwNXJ8kxM2Kp36qacW5M3Ac0Mf2z28+W24qX0wHJj9aX7GEmWBUEKyhpKIV29zjAjjygsCO/4qwNqMWsRskXWB6FRYK/N2KvNcUvkPk7VjWcBAww+Fbev/DnUuanSinqF6svmdWYBH1i/H0qNNTgygjmOU/i+RjQKYmm3ZMhiM7JaOm7XKd+pi8BUlPLoYgrYIP7o9Q3oTfxG/UsfE/lNvBUafHK0Tw5ceJ5XcH3f8rt53fymnGksXWvd/qunTGrkhnlIc6q2zwc1JDIEHllY2R5TvfyGYOT4sTTVgVvV8FylL6m/xMDwBgJST2vVmZ+t86BBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF7UIu3YyjZf4h3RuFiz4VtvRr53JetmaZvnDIM9rL8=;
 b=QWYoqSp7RIp3Z5437EGgFtNnOQXdAoyrFVyvnGtQomtfHgaDchpmqiUq00L01H6DJThwYOhFeY890FgTtAwcqAFGlYLqJtZ+vnsk5PvyjWuGgO+pUtkdUlRA5aXgqkpcFaRf4lYLT+gQH9V602pvjdF8Y7uBGGCpR+FekZ22s0vgihUOVHOzXl1wmDIw53w2HjL8DKdC/l/2W8UQ1GtcAY6GqCzNWla1w6l6/VGTls7WMRWsdC8yyeCx0lHvTL72iutuLrHqcpyVKo5TbHZWnzjZgCMw321pyU/MJmVHGBYuIptH1JNBp1/A3GwagQH++Wx/j8OjTlOHCcstOMmwJA==
Received: from DB8PR04CA0006.eurprd04.prod.outlook.com (2603:10a6:10:110::16)
 by AS1PR07MB8480.eurprd07.prod.outlook.com (2603:10a6:20b:4dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 02:10:24 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::38) by DB8PR04CA0006.outlook.office365.com
 (2603:10a6:10:110::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Fri, 18 Oct 2024 02:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:10:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2ABFQ008653;
	Fri, 18 Oct 2024 02:10:11 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 0/1] DualPI2 patch
Date: Fri, 18 Oct 2024 04:10:03 +0200
Message-Id: <20241018021004.39258-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|AS1PR07MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 5270a24c-f129-43b3-ff40-08dcef1a06c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXg4dWFsOG9raHJLL1JORnpieVZYQlZvdGRaNzRtUmdXRmp5QUFXKzJTcTUr?=
 =?utf-8?B?ZWF3cVprSXVucmRLUzlqUUtGRFZNNG9UaGRlM0lCRmVLNVo3RUFMNm9rSUpl?=
 =?utf-8?B?NmQ2Z050VklCdmw3WG9NbTN5ai9vU3JiU0JUdDJvUStCamQyUmhmcHNLNXVD?=
 =?utf-8?B?M2NwMUJEOElIZ0l3VzZGUlhlbWF3TmZMaFpwclRINGJYTTVjOVFGUkxuRlUx?=
 =?utf-8?B?WU5ZZ3dkRGtlbmRaZVY5SzFkMGVOcW0zaHNSVEJZNDgrZ21tWmVjZzdBUUds?=
 =?utf-8?B?c1lidDZoajFjT20wbHI0R05sTUpFSHRwNlZpWTM3Y1JqQmp6WSs3MlErZ1cy?=
 =?utf-8?B?SUJHdldUN0RxZ1FZd1gxS21WOU9RTzFSV0ZodDhpYjFXU1RNZ3dzNzBlV3lm?=
 =?utf-8?B?SW9HeDUrOWp0ZDdGNWJjcVF4SzNpQTR1S0VuZnJwRE9QQkU5YndPM3ZwU0Rn?=
 =?utf-8?B?UXZNRzdKWE15aXppa1VQb0k3dlpsV3ZQQXN5VU1iT1ByRkZOTXNOTW9pQkE5?=
 =?utf-8?B?SldvMlNVVHRaMUlLMmNBd2lYWTdGNU1pRHZNbXl3dWk3OXo1b0JENjRFNEU3?=
 =?utf-8?B?aTZTT1pJcVV4Y2JqYWlGZU13QTZNTEhjREtpZ1hGKys3eE00ckVYNGdVMzBH?=
 =?utf-8?B?MUlDNFhCZTBwWC9LZ3lJUjVBWEZHT2d0TnA2SXVOUzk3cFB1WGZlelljZnBS?=
 =?utf-8?B?VGVIZzhTU3hERUoxdk9BOUtnOXRHVFY3YksyRGRwSUpkYXd5eHREeTdmSE1j?=
 =?utf-8?B?NkVyYWVnT1ZIQXNqbFZNaUczUTZFejZIS1hLcE1QQitETHExL3ppNWJZMDNo?=
 =?utf-8?B?dEdGOFU0NkdkT0FkdXRaM3hKS2o1V3dqKzBtclNDS1pSaFBtUExsUEV5NXph?=
 =?utf-8?B?Y24vT2NSd0gwZmV0c2lSQUU1N1dYN0hOMldtTmRnS3lxWGtmZ1VvNE13cks5?=
 =?utf-8?B?SU5kbWg2VktBOFVzSFJBNGNJOFV5TXNDUktxbkp1ZFZNeVRRb2pxNHlZbmh5?=
 =?utf-8?B?WFBGSjY1WG1TWlppWm9Pa1A1RTA4T0tsdkUxMnRCZFljU29RS09CSHMrSnRF?=
 =?utf-8?B?a0laMzI0Z1BYbm9XV1BJTk1yRVdqdy9ySzRyZmo1VzNGTHRmcHVJcTRxblBs?=
 =?utf-8?B?cUZueDNmZ0VzakNSRmhIRXprZlVjV0JLTWFwQWVRNWZxbVRGbVUyTG05UERC?=
 =?utf-8?B?U1ZuSTE4MW85UTB0a1lJQ2p1dE5jV05XbVd2Y2g1VFhYYmFsTHYzM1NnWFh4?=
 =?utf-8?B?VDFvcWVPaHk2TnZRRnRFdnd2cmpmRFUrTjNyNTlzejVtbStJbjZjYkNNUXRP?=
 =?utf-8?B?dUc4Rm5YcnJLN3huRGZyOHBvczdtWFExUEhwaXk1L3AybExzb003VkdVTElF?=
 =?utf-8?B?SGE5Sms4dVN3WXg0ZFhBV2U1WXpSM2J0dWhNYzdybkEwamZqbE1MK0xvYnRs?=
 =?utf-8?B?MnVhQ0ZPMHRscERybGcxRnB6M1NtYmxCYmRlaDY0WTM2dXBWNURHVGtzWW1N?=
 =?utf-8?B?Qlg0R3hHczZUM01aSkVPaXVtb2l5STBMTUptZ1NlLzdqNy9yM3UzTDl6MjF0?=
 =?utf-8?B?SFJuU280R1N3M0FhQUVKT2lqRm9uV3kyNzhWSFlHVHdSTlVoWlFuRWVuWVB4?=
 =?utf-8?B?b1NMVnRXRnE5Ukl4dE1qZ2hXcEN1MTMyR25BcHVNY2NNRHA3dHlMKzIzVTcx?=
 =?utf-8?B?UGpEMXdkcVZnWHVhdEZONTlObk9pSDhreERtdTdaSVdiT1N2V1NhbjhTVlZE?=
 =?utf-8?B?MFA0aVJndFp5d1hRQXl0NmtMNDJrczdLWlMyZjFTRTBKQ1RFNVJ5UGVuejc5?=
 =?utf-8?B?ZWpVVlJsU0YxK0RVaGpVbms2U0ppM2IwOTZ6MzNZMU93NEV1RzQ5eXBQa2lB?=
 =?utf-8?B?RVRuRmdzMUl2YVZUQW03aGYrNUtMdEE4N0dLY1Q2RjRSYnVueG5VZ0VqSWVZ?=
 =?utf-8?Q?n3FCNY1wK4o=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:10:24.0163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5270a24c-f129-43b3-ff40-08dcef1a06c7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8480

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the below patch for DualPI2 
(IETF RFC9332 https://datatracker.ietf.org/doc/html/rfc9332).

Koen De Schepper (1):
  sched: Add dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml |  108 +++
 include/linux/netdevice.h           |    1 +
 include/uapi/linux/pkt_sched.h      |   34 +
 net/sched/Kconfig                   |   20 +
 net/sched/Makefile                  |    1 +
 net/sched/sch_dualpi2.c             | 1045 +++++++++++++++++++++++++++
 6 files changed, 1209 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c

-- 
2.34.1


