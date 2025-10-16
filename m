Return-Path: <netdev+bounces-229898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B08BE1F8D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFD619A86A1
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA927E066;
	Thu, 16 Oct 2025 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="McaEguxb"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CED218599
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600680; cv=fail; b=KznmJ0IjOSQL5isEe1UXl2/4FL/RlJtnsbpdBUU7drHn5OS/70tlx9aIfTaw6K1k/emNnRxffaNaihjdHpUvH3FjvTkursSamcTfZJYsHxQp6EDp3Bx4Cff/W5YEHcQZPElKvgwAT+Sy2Wq37oThDP4UGbLDynZ2ZrW8s/+jjEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600680; c=relaxed/simple;
	bh=4YBYkHT/mra5ZS4xJp+iMEUUT9XqHCP0XJ+cLwHfXVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UPVuASdiGitndQJZ93IrHu2dXUQ2jVrdSOrPDJFy4IQoqc8jDwosyZ5YCvjAmnJgPsgkwfecmsWR3VMphAuAHWuMraQV6VYry6Sr89s8mMy3SHzTParOYAkQ1/S0qIY3VNfqorBbb15rVCRBa0e13drfuSJD/1xhuNwC9s2dCCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=McaEguxb; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7KJK1012923;
	Thu, 16 Oct 2025 09:44:07 +0200
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013062.outbound.protection.outlook.com [52.101.83.62])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49r26jc0va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 09:44:07 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbvFcRvwrUGX2YQXxr6RQHSRWAN+Rm28OCtqFJuaHWPJZWtM7AoIP5h2VpWdnJof8175rQEybEutjyOGGUHH8oshufj7lTAF604UlZgrGYgAm6/9SjBvzSorh2njQs58t+C3VAbLzQAsM2Bi5wrrve/LbZtUftExoZfprVhQuObr7GfkBeQ5jWwCbSWYzsHOL2hfDuYu9Y7N8AVzUafeizsZL80AIMDG483Tu8FeBDQiU5E6mvmwmg19BhZtcm/USpbTKKsS8Zu7eLIYGNDy5kJ1kU6vAkiG88p2ytGEv2ytd3OZhIotJZpw36/FJnpGIEDHUTUidhvMZdqP9fRcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT9C3eMb+YIYJ7m13+qT+vIgzaMP+9LQbPf0ELdJ08g=;
 b=QaegkI6SYlRqfHeJ7FI0UsRTLNrCP9wdfQL8B1VLBiOxmFCmaIrczXzOn19kcjel+eHNgTlLDrmBliYnrJFae/2SFYIsPxE4MfW3DKybN06tubxcyQHnhLJkcbR1Y/FHL5Woj09udEbCD1b4bQ5hTSya46xsfiK0ULqLwjz6e93fq7u+39rLPytxMUs0NY2cgRdiICEEg7aWLJsaeVLvlrX8qtI4YO3c564yz1OJDdWMsjkOFQHD4bgqTJYmGKu8ywhzN5NAiCrwcnyhB2/b3jwW2EkxfLLlIeyjW49ufaKZRECCb6Poynw5OrGVDLc1An38Pa0H5KV8S/7PR87Y1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.41) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT9C3eMb+YIYJ7m13+qT+vIgzaMP+9LQbPf0ELdJ08g=;
 b=McaEguxbnM2wiKP4PlK6e0VV5eK3BDf51hNse52XSUVNNHuXvJv9zz55Dl8h+Q6iu1TA9BLxvRlWD/UQFCiP9lJ0XJWNdDfTdiRI/m697p34n4FDf/u6/8uVOz3AHcU3k/DKaCS6YxSfzpS9EoQ20nnVGfIHZHqPYslyVOR84QAdX/Ub+VRNicY9QgYuP5LPBN8k9hBftFuXq0Anzj8MB3ASmgfqsyCiSlza+hihaZ9tJ2SFhmqLG5zEByoShS4gpS+g2JqTmT2K3Zbi0wla6MocpcMa1DxGH4+/HYqjkupjMwchzbghT40w+QCNrjM22bW1hMirF88p0Q+DhvYZEA==
Received: from AS4P192CA0038.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::7)
 by GV1PR10MB8607.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 07:44:05 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:658:cafe::3e) by AS4P192CA0038.outlook.office365.com
 (2603:10a6:20b:658::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 07:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.41)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.41; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.41) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 07:44:04 +0000
Received: from EQNDAG1NODE4.st.com (10.75.129.133) by smtpO365.st.com
 (10.250.44.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 16 Oct
 2025 09:47:18 +0200
Received: from [10.48.87.185] (10.48.87.185) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 16 Oct
 2025 09:44:02 +0200
Message-ID: <f9c7b80b-b750-4eaa-b528-7028e8d8295a@foss.st.com>
Date: Thu, 16 Oct 2025 09:44:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH net-next 3/5] net: stmmac: avoid PHY speed
 change when configuring MTU
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
 <E1v945T-0000000AmeV-2BvU@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <E1v945T-0000000AmeV-2BvU@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|GV1PR10MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0c7c97-37e4-4c5e-326e-08de0c87c7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzhYY0ZOb3dGUmwxQVd1UElzYmhldDlSUGRKOFlybTAvMVRFTnMvYTNWd0FB?=
 =?utf-8?B?RHdsSlRvTDVkZCszM3E2MU1HTFk5OXBIbzJVRmRIZjRxeUVmMFIyQXRBUFMx?=
 =?utf-8?B?c1gwamtQUUwrLytWVTVaQk5vbU9BN0k3SS9vQzJ5czV0T2tHQkVCZForRUxZ?=
 =?utf-8?B?eFdHbllhaHRGdEJvTmI3dWlCOTBxOWd3blFiaXA5ai9CaDhDcnhoL3BJV1Z3?=
 =?utf-8?B?WTJ1NlN6WE5MRFdYUTl2dlBuM3NYRVI0WENWNjhvVTA5S3A0YmdIZ3hpNDNC?=
 =?utf-8?B?OFJkWkt2Tjh5a3lvUkNzOERZOTlYT3dXVXg5Q1gxRnZ1cW9tNmxpOEtjY3ll?=
 =?utf-8?B?VjZ2ZFBOUXlpWUVja3J3eW1BWkpPZkdKUFdCb3Irb0JpN2xuNEVBU3hweXpn?=
 =?utf-8?B?VkNsVjNPbWNXeFpvVHdqdE5rT0MwVHdRSjJEREkzeFgwQ09qcGxFRnlGeFEr?=
 =?utf-8?B?bnhUbzIxSnh3ZGJPK1QrUmkyVkgxTEljTTllWFQ5dkdxZVhsVlc5UTAwWkJQ?=
 =?utf-8?B?L0Q2SUliS0lROHc2dVhHcWo5N1kzNkFHYzFLMlBjZGlNbENQaVNjZU82bGFL?=
 =?utf-8?B?Zzg1TW15V3QrNlZQcit2SEt3a2ZrTzJDQ3loUVpTWXJuTEhWVStYRkZpMUdW?=
 =?utf-8?B?SFo0cVZPV3VrSE0va1ppamVWU21SNk1aNzIyeDExVHoyRndmLzdpTlY0Q2J0?=
 =?utf-8?B?TE5QMFJ6Wkh3dUJEcmVlTlp0RnVWY294Q3NEMHV3Zld2QWdCcnJjTjZBaW13?=
 =?utf-8?B?Q1ZYWVAydXB0Q3dUVUtpVTJCcVltbWQ2Y3A4QllOaVpBVXZhZG1kUUYvZTJl?=
 =?utf-8?B?SVpwN2NqNHlTREVybjRSRXhLbGN4SWsvRGswRDA2U1dnb1c0TUVEK29IVDZj?=
 =?utf-8?B?d0MwV0dFY2lvK2pFUVJOYTFoeFhCRGVhRFl6anF6UzZKZVJOMVJIVUx1V0xY?=
 =?utf-8?B?RjJGTXFZMUVJNUp5Y2dIazdGQXZUWFNOU3Nqa0hQQlB1Q2lLMHRSUFBybkJ2?=
 =?utf-8?B?cGh0aGd3UXlXTU8wRmVnVysvQ2wrN0pqWVhLRWpsTHNjcUJtQ0NEY1BlS21P?=
 =?utf-8?B?RSt6RG1jR0NySGxmaXNLVVprNGdLekNFWU9wVjdWWmpTeWJCOFRnZWZlanhV?=
 =?utf-8?B?Y2wvOUEwQmpodlg3aTgxTXpGa2tmamw1Ry9WTHFqZENDTCtJcU5DQ2RZcEVv?=
 =?utf-8?B?NVE1UGNWN2R3dUxZQmIyUitSYm5vS2g5dmNLZThiOWtWSzhVbXh3TnlTSnN0?=
 =?utf-8?B?Lzc1VVdzZ0R1U3VJek5Lbm01SkJIVjViQ1JFZFh4dW5qYzMwK1NJL2tpRlFa?=
 =?utf-8?B?VG1jY1lLRUFkcnM3eFFQNG9FMFJPcThDY085N3BydzRyTmNCa3JzdmZwd3JS?=
 =?utf-8?B?cmduK1BhV2xiTVdONUwrN01pVlVEVmtFZytEUElSNU0yekw0Mm9UbVdzcjJU?=
 =?utf-8?B?K1JRY1Zpd1N4TjVlZGJocndLY2FrQjZKZTU3YkxsT2dHak04dmNMOS9nS3Nu?=
 =?utf-8?B?YlU1YmN2NlFDdHVXZkZGV2swK2I1ZlIrMjVQY0N0R1BYNk5mTU9pTndxZnd4?=
 =?utf-8?B?dWY4Ky8yM2NLdmd1VWlNc05ObFpFOHk1b1VzNWlSTVJ0VmpIbStsRlBPYjd1?=
 =?utf-8?B?dFAzemZFalhscit3NDYyaG1LQUx4dmYzRTJEMFg1a3NsekZPMFNWR0dFTHlt?=
 =?utf-8?B?RU9Vd2ZNU2JmN0NFdHpETndha21NN1FxU3Z1akcxajFqeGdrcTV6Sk5HRHlY?=
 =?utf-8?B?RDJEMlVGUE9mQ2pVNy9ablNMZzF3eGtRa0V1bXJsT2Z4TUVIdEliaytYMTdl?=
 =?utf-8?B?UlRyY1V4eEZ4MWtZSHc1VWs2cjA4aXZINXYvUGQycWxqSS9HRlV4MURVUnJW?=
 =?utf-8?B?ZVpvMDFib2lEYTRlemF4VTVTaS9IOEphTDEyZVFFL1UyUHQxUmhBUWo0WDFi?=
 =?utf-8?B?R2dFR0h1VGcxQjhJRWgzajRCKzhTbThHaHpvY2h1TGhLbmgrUkVBd3BibVBn?=
 =?utf-8?B?U2Ztb0VPMU9TbnZ0TUxwakZvbktaUEVFYkJwcldEUG4yN1UwTDEzQ3NXTERP?=
 =?utf-8?B?VTdYU3BrOG83Q0pDMGhOYlRoelFKV2YvZzVQaER4aC83bkxQbi9DVVBTYk5X?=
 =?utf-8?Q?cI2E=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.41;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 07:44:04.5145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0c7c97-37e4-4c5e-326e-08de0c87c7db
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.41];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8607
X-Proofpoint-ORIG-GUID: 3j2KzDff5f3YQCXCgUKyJh72qBsjHvBZ
X-Proofpoint-GUID: 3j2KzDff5f3YQCXCgUKyJh72qBsjHvBZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDAwMiBTYWx0ZWRfXzXEq5hQxJOmF
 3syK8bM2XHIjHlaj7AlbKJsODrlqjEFkeDCrOTmOE3uQ7DRHbrwugg73zMzdQ2RfOyb4FxLJv1X
 /sV2SGNbJxOElefxhH9edEVi9silCcLUKrVGG+zH0hGpo0Y1u2RAxsX5hK1XIIecsjLP8tr4Fku
 PUbxpzilasqtG1y8Rfk2I03pDBTPMprrwkqbfjb9Eh85nRwn3ldb18ysnDn64u7evBsSn1QMe/g
 MM3T9XJ4GlVNAppumPZ5fxUbqe2D+g7P4qvp5YJU2z7KhNk8sEd4agTlxgD4vAQtvSQMJpEEIGK
 cXcwENVoUSmCDxxo1ecFUvQlQJtLrZBRT+X5uHOHC+JoojZZy+P+7kYqvU2yq8XIjVp8KRFEveN
 Wy5ggUIEg1I2oFrSj+gFG6lJaiqPAw==
X-Authority-Analysis: v=2.4 cv=X5Vf6WTe c=1 sm=1 tr=0 ts=68f0a247 cx=c_pps
 a=RtmOKfXeDbbZjWwzFrWVdg==:117 a=k+92ZC+kR50ztVuylSZIGA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PHq6YzTAAAAA:8 a=8b9GpE9nAAAA:8
 a=uuTVUBEUzNTrpuX2M1cA:9 a=QEXdDO2ut3YA:10 a=ZKzU8r6zoKMcqsNulkmm:22
 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120002



On 10/15/25 18:10, Russell King (Oracle) wrote:
> There is no need to do the speed-down, speed-up dance when changing
> the MTU as there is little power saving that can be gained from such
> a brief interval between these, and the autonegotiation they cause
> takes much longer.
> 
> Move the calls to phylink_speed_up() and phylink_speed_down() into
> stmmac_open() and stmmac_release() respectively, reducing the work
> done in the __-variants of these functions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

> ---
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3728afa701c6..500cfd19e6b5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3963,8 +3963,6 @@ static int __stmmac_open(struct net_device *dev,
>   	stmmac_init_coalesce(priv);
>   
>   	phylink_start(priv->phylink);
> -	/* We may have called phylink_speed_down before */
> -	phylink_speed_up(priv->phylink);
>   
>   	ret = stmmac_request_irq(dev);
>   	if (ret)
> @@ -4015,6 +4013,9 @@ static int stmmac_open(struct net_device *dev)
>   
>   	kfree(dma_conf);
>   
> +	/* We may have called phylink_speed_down before */
> +	phylink_speed_up(priv->phylink);
> +
>   	return ret;
>   
>   err_disconnect_phy:
> @@ -4032,13 +4033,6 @@ static void __stmmac_release(struct net_device *dev)
>   	struct stmmac_priv *priv = netdev_priv(dev);
>   	u32 chan;
>   
> -	/* If the PHY or MAC has WoL enabled, then the PHY will not be
> -	 * suspended when phylink_stop() is called below. Set the PHY
> -	 * to its slowest speed to save power.
> -	 */
> -	if (device_may_wakeup(priv->device))
> -		phylink_speed_down(priv->phylink, false);
> -
>   	/* Stop and disconnect the PHY */
>   	phylink_stop(priv->phylink);
>   
> @@ -4078,6 +4072,13 @@ static int stmmac_release(struct net_device *dev)
>   {
>   	struct stmmac_priv *priv = netdev_priv(dev);
>   
> +	/* If the PHY or MAC has WoL enabled, then the PHY will not be
> +	 * suspended when phylink_stop() is called below. Set the PHY
> +	 * to its slowest speed to save power.
> +	 */
> +	if (device_may_wakeup(priv->device))
> +		phylink_speed_down(priv->phylink, false);
> +
>   	__stmmac_release(dev);
>   
>   	phylink_disconnect_phy(priv->phylink);


