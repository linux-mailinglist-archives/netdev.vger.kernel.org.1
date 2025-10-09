Return-Path: <netdev+bounces-228369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B5DBC9153
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 14:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36703A5D40
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9082E2DDD;
	Thu,  9 Oct 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TFuKlaw4"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601E25A642
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013678; cv=fail; b=B7mwtv1rf6xmGXhvKmEgNN5WyJVTITyBxCJ0Xq+6na+I9q8HT3xwzw/8tHtG62Ng6OoAA31tQ8jJ3YUTNhbbmkNMCUxN6WCroLvcztL2RpYLBd+b5rdxNEjm4E+UaWq0kipBUQDrfqsJkIlKb18QVEBF0pt9yxotfVlYFPjhmd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013678; c=relaxed/simple;
	bh=Gr2ovPwhoUkpP/jvaxan/eXy0V7OjcYXRtAynOUN5Vw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZfIaBZQwtIFo41B6BLg4k3lkArFxThB/RihqMp2v+WI1Fhz1tSKUfpjIdAbxcyX5K3e8kHcV1kMh4Fz7h7oLNB+U2d1BZ2j9hPzDLP6X5WddT9hsyoA0jSZhWevkRmCsvuqvHIdlTfM5NyJjXorLOKHnEhBH2qJnw7aUaC9jb0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TFuKlaw4; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWmQLx1fox80R6Jr3A9e548PCctijIiKs3ry3j/j0K9BkUvaT3hGWrNd61z8cmuAcH6A5Y8Lcg63lTiPLwshNq01ComjzMBHWC/2i+9iBbOrjX19fMElPYh+Fu6AlnnUehabXcvys+FtWy1jByRX5LIufPiOAiVnOZNL59iGI/LLLpcXJZwh4AOJZvHIc//OMsMSFYXe5IBo+HAIvSYANNjz0xBf7dJX3kKmY9B7/d7PhVb1aOR4DJs+lJD7MT5P8OLoaHZOs5ZJn3VPi+ilMQy1sBRivmLC5lHpcMSXhFhGNqce5Mr1AytoNjuYIEnpPGcVUb67Vvbd1u7ulom9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NPhltkPoBVqMkinqCezUWR8tPjc1R9NEHqH296cLks=;
 b=bWAN9XZ3jgWo1GY6fcWV9Z8y59NpepP4vuoQTpJKRVQeu66vwbB6d4ZYoJwFfTbQVdsUvo1d6xmiun0k+BN+anzH6cCoYpSn3SWZBupLjOL8sK+gdnGipfsfk/Jkht8eR5FV5EPphaxs+xGjSnu5GVLYXnrA2jBCr6lnRMClHP8YpjcmgiW55JP8dxBVi/00HjL+/jo1hC8+GplvzaAWUZY9IK6I+cSS6iByF7aws8x52bRvV/ruPMws/8eDZpbJeO9vviy7r4f2JP+oNB18tYVFdmgpbOLjUcS4zYkhMA0FjmtxtiX5Utc8S57M08JYNdRuZII59yOqmeBXgI74hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NPhltkPoBVqMkinqCezUWR8tPjc1R9NEHqH296cLks=;
 b=TFuKlaw4YbHLxpzOrgtaeTLH4z6cF/G1tGwv8b7qslakASH9MbO2tYc67ApfFPweFA/n/iOxeP75oMMVccDA9oN62z1nnL5PdX7u1iu5b5z1hr8A921MUhfxRiRz+xyhet5fC20zo4rI+iiOBbX09ymMFSexIJRVQb2Vv3lBn+I=
Received: from AS9PR05CA0326.eurprd05.prod.outlook.com (2603:10a6:20b:491::23)
 by PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 12:41:12 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:491:cafe::ae) by AS9PR05CA0326.outlook.office365.com
 (2603:10a6:20b:491::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 12:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 12:41:12 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Thu, 9 Oct
 2025 14:41:11 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 0/1] net: phy: bcm54811: Fix GMII/MII/MII-Lite selection
Date: Thu, 9 Oct 2025 14:40:50 +0200
Message-ID: <20251009124051.1291261-1-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000043:EE_|PAXPR02MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 51705719-06ac-4335-338a-08de0731211a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2FIcDZ0Y0c1M1VQTjNxOVBPV09jbjdvT2NnNmYvUEpkV1FLRERvUjFTSlJz?=
 =?utf-8?B?Q0djcWFCTmMrYkJiTTJKUG43cnQwOW5CT2NBVzQrdGtHaDVBTVNCK01PR3lH?=
 =?utf-8?B?Z2cveGJEYnZPS2FDa1pPeE5hRmVsWHdkaXdQaVdPR1VOaE1sUEdkaVFJeHVi?=
 =?utf-8?B?UzVPM214aU1lU3NVUkNYVERhSGZkQUVYOUU5VTh2VHd3TW0vMnhFam5tR3dX?=
 =?utf-8?B?Nk1pcWdzdEZGWFZXQ0Eza2I0aXdjVjE4OEZjZThwSzNHTUhrdGJ4S1NtVEl6?=
 =?utf-8?B?TEl6TStzZ25TTy9OVm1hNUE5OWRjUTVEV05ualdGbE9xZDRWU0c5NjRnTEU5?=
 =?utf-8?B?M3QwUWZGZ3RTTFBMc0FKZW03U1F1MldDS2NnaU5QbW1KTm42dDNJZUt4RWU3?=
 =?utf-8?B?dE8zbVBhNmo2a080cEJHdnE5SllVTGl1Q3Jnc3krOFd5Y3IzUmgvUzZxbUs4?=
 =?utf-8?B?VjZWNEZjUnBmeGxsU0R4STRvNzlrR1ErNldaRTExczR4UUlNMFdMWEQvODNS?=
 =?utf-8?B?SHpRNWFxSDdDeFVTa09aTm43aFZwUG5TVGFNb0xxZldXTHdXREpRSGNkNDUy?=
 =?utf-8?B?WnZoY2VNM2xrWU1ZMzBseDFwMG9CU0pERzI5MXJtUXhJRDZpR01qMUwrRlJY?=
 =?utf-8?B?OTRWTE9zdEl5ODdDY2dzV1A4M3ErdWZBSzBPMENJWWt2aEpWQXZ4UHdFSDJq?=
 =?utf-8?B?TDd2dmhvVW9kbG5lSDl1OGpsOFBFV3I2eGowSDVEZ3o5YU9HTGFBdHo0MEd3?=
 =?utf-8?B?QnhCR1pySDBUS3RkVkUxSy8wNGdLWDB2UE5FV3ZSRnRzajh4cVBKNjQrdU1w?=
 =?utf-8?B?TURuN2JIcHhRU05YUTZ6cENSMDhYSDlIT0F3Wlg5d0VIYkM1cVBJN3NSZWVv?=
 =?utf-8?B?TEhMelpHL2hzUmMxU3gzVGpURkZlZ05UbkZLcXpSTVdDZGNlcnE2QlhZazVJ?=
 =?utf-8?B?c1VFOVdWVnd1S2dER1diRklFc2U2akk2cGk0S0xjazQ5c0lhTVd4VjNqL3ox?=
 =?utf-8?B?Qk9yMWNDQUNXUlIrQjNCbWsvdS9ZNUZERGFEcVh1TUtTNVdKdmRXSzNuMHFG?=
 =?utf-8?B?ZkxxMDZMcjZuTW9vUnE1M1ZLTkt0MnlQRmhOZkdBbWR2MW9aL09WdnJSNFR3?=
 =?utf-8?B?UElSRk1XUUJuVkE1ak1ob1BJWFlJQ3ovTmxobTdEbUdIMTJtNjBzUWdsNXlG?=
 =?utf-8?B?WmJkVnowd2M4TExrYUpDcGRxVzNkS0t6S3JONnljSk5Dd293SDVSaTQ4WUI4?=
 =?utf-8?B?K3FOb3VnZk5ZbWQyR3pOa2hEQm5PVVJoQ0dEYU0vZksxY3NaYmVLemk1YWVV?=
 =?utf-8?B?RzlEUGdZTEhqNG9sR3d0bG1ZZlpBVHpXNVZrMHNyWE1WNkp2UTFSaWZVZkxx?=
 =?utf-8?B?REdXSW1wVDFFS1ZtTWtZUGxXQVVqbVdXNWk3a0FZSjRJYWdEWHdqbzU1L2k3?=
 =?utf-8?B?V2tBWTlOZElGaWhwMjNIeXd2MmtwTWx0QXg5QU00cURHV3JtUDNoV2FJdUtP?=
 =?utf-8?B?ZkxNTy9ERXNidFNQalRPc3BrL2tVYVI5Qzk3RS9jOWwvU1VTMkJCckJoRzJQ?=
 =?utf-8?B?R0d4MDBFS1p4THZMVE9oeis0cjc1VWZkaEN1Q0lCUjkyZnMwTUZhUTJUSmg3?=
 =?utf-8?B?dHBUNjFrUktjZHFTL0hodkxseXhvdGJobWhDU0dYL1JuYkR4c2NjSmVNK253?=
 =?utf-8?B?K0d1NWhqZFpVaGNibno2bEJ4d1czTjhneWVCUEx5NllodHpsUDVVdFhCSmFl?=
 =?utf-8?B?ODNJSVhMdDFFMmswc3ZsbzFYbm56OTg2YnFoU28yV1FvSmZsZ2prSmRmdHRa?=
 =?utf-8?B?L20vOUZCVWU4ZVE2NU96QXBTRkQ1TmdQNnE4dWVpSmVaMERCTWxnVktTUWti?=
 =?utf-8?B?UWtDNlhLWjNjTEtrVXVXaW1nSVVUMUs2ZFV4Q0FSd2JRYTJFbjV2U2p0dXkx?=
 =?utf-8?B?L2lpUTd0T2oyTkphaWM1ZzhwQVppYWNrcFAzdWJUV2t3MFB5dk80T1ZWait6?=
 =?utf-8?B?VTU1Vm91dUJqdWRTWGdKUExCUm1XME8rTlAvUVAxcC91YTRXelFtc1FFM2pv?=
 =?utf-8?B?amg1c0JIaGFrRS9lUWIrK3poeXZMV3JOOTBPci80aWJmeXg4alMwU1ZWZGxh?=
 =?utf-8?Q?OJT8=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(19092799006);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 12:41:12.2907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51705719-06ac-4335-338a-08de0731211a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7310

Software RGMII - GMII/MII/MII-Lite selection.

The bcm54811 PHY needs this bit to be configured in addition to hardware
strapping of the PHY chip to desired mode.

This configuration step got lost during the refining of previous patch.

Changes in v2:
  - Applied reviewers' comments
  - Not setting RGMII RXD to RXC Skew in non-RGMII mode 

Kamil Horák - 2N (1):
  net: phy: bcm54811: Fix GMII/MII/MII-Lite selection

 drivers/net/phy/broadcom.c | 20 +++++++++++++++++++-
 include/linux/brcmphy.h    |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.39.5


