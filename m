Return-Path: <netdev+bounces-228375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DADBC932F
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 15:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D04DC4E12DF
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15A12E6CB3;
	Thu,  9 Oct 2025 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="IgxlFQ1f"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886124634F
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015252; cv=fail; b=Eiu9OvA8xQIAirJ0SjiL70/HTJKybRj66PjEbpgj+4t/EZ+FyqtYyy13fKF2t12noxoFccSzX2Aq3NW/ZX/S07PjqCzQV44lF0XvDm8di59V8Z0WhAyTTe8p/kJ7MrQe0iQCcQsHv7aCaHsd18oCbEYWWS7AYrzOCW1QAxQqToU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015252; c=relaxed/simple;
	bh=hoGhb+KAHmEK5k8eX5a36vWroiGVUBziY7QSRdZETo0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=svvaiatKSV2DT4LyEgLqsj6BBQE7HDok+Zoo0vrNRHB6EJ3pjKMg+BYtkhoE745GWzKeeLPqG3ncI114GKp+9+n4aaCmKAtPrb5wW/6rSv9RRCiwfDyp0be8LsrwMdEP/TgKLX9PqOjTlVb6c80OahTW8gswMyGWjt9DMvfzg/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=IgxlFQ1f; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBbtk/8+JQCr1wVvU62nnHhipu+8/CVfPsBN/FsJX2kkWKFmcmlGRvMLD/UvVBIxBxTnWMgk9PBjWryXWBYmmCI+UPMaiprq+HcmsuEcLboJKxAv/5M8IkxSv8mnbJZB+Nkei5sgV3w/vSQu01wbYQxFsBaP5+DrvmyCr1nrs8k8DkSKPARz8Ao18P/r2M6lO2XoTiZSqQbIYE3Ux6nmzaXIY8mCoqgHrIUUu9YoLj9BFFZ6n/Ap/oZ4IRMRCMdR1a1k7EG5KtXa2qD0yJYPnEX/kNcoHtc0BIg5AkPDJcVLlT4Zua6RHjfK6/i9iOnBs6ou0GfA51SS6de8Y+bM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGdGkIBtyqLTmEji2UF7HCQM7xBM3UWRd4Ok8WMHec4=;
 b=s2GsdR9+KRiBcbtSPrgbJXM0lN2T7BqX27K8uhHM09RJzYOBNmerlGeK6frcHbk2tNxRnvOUhkowKZzjBmzRoI39mjwOta2UD45ARHjqU73wgTkd1x2oGL0jtkLLie6HIMITCZTmY/5EZDDwd70S1wnvUbTsIFVqEFUe8noCrGRqY4naDQMcC8Rx/AbwH3nr7NX7yumfoJOtb79E2OfczdfDZQykEWTm6khGLXvDYajwmt23ASyOCqJv8FNtp1ZMK3tRCYG6mtFp9b6u+teLdor53VEsnas3JWMKPEAJc/+prwHxDpal4xZgPDnGQyAm2pBJaIYn1kIMIaLXBdxMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGdGkIBtyqLTmEji2UF7HCQM7xBM3UWRd4Ok8WMHec4=;
 b=IgxlFQ1fJptjnH04CTw1RqORhkJ5VEV5y+6WCANgvnqk7vp/8CU0blxan1rtU7+dltrZ+oAqp6+ufyURz7w6A8lpSYj9nvkHT4eBWjilN5MEue9E9zPjJ78YVoio47JU0UyChYbsvOVr7vBmlxQegJyC9sDudhPkiHH1czrg/hA=
Received: from DU7P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::12)
 by AM9PR02MB6916.eurprd02.prod.outlook.com (2603:10a6:20b:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 13:07:27 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::6c) by DU7P195CA0029.outlook.office365.com
 (2603:10a6:10:54d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 13:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 13:07:27 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Thu, 9 Oct
 2025 15:07:26 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v3 0/1] net: phy: bcm54811: Fix GMII/MII/MII-Lite selection
Date: Thu, 9 Oct 2025 15:06:55 +0200
Message-ID: <20251009130656.1308237-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|AM9PR02MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f88c53-af02-4e33-0ff9-08de0734cbff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmVjTmJ1aEU3a1J0R3BYQndmWHkxalhja3pRNGVwcnBsaWxydGVTVTB4Rlds?=
 =?utf-8?B?ZUlzSzlRYWNrWVFYanFVcmEySWRDSzZzeXZoWVN1MG51Rml3dU92VWxyVnlq?=
 =?utf-8?B?L3pDVWhpMm5GaW9PV3VRUC9obTlLMHJLb0tQR2Y5N0tBRlhaMmZaN3RvY3dy?=
 =?utf-8?B?eDhDVkF2a24rYnBLbE93MFFJZitSZmVYbXJaaXc0bFBPeTg0YWo1ZjBzM2Fw?=
 =?utf-8?B?R2twRE84ZmRQVEhxY2RjMzZSUlJtRnd1MExEN1lNMlIwMkR3VjlrWXFpOXIw?=
 =?utf-8?B?RlROQWpmR0h1eUlkc3lZaWRkZnVuZU1XVDRuQWd2TUEvd1c0UXk2clJuQ0Ns?=
 =?utf-8?B?WkVrV1pqWWZNNmNPWUJEZTZ2K25CNmV2Zm1FemxESmwrUGdWMlg2TTc2ZUZM?=
 =?utf-8?B?SGwzc25uOElyNHdGQ2JHOXUzVXUxQnBsT1BocDFOTCt5NVVRczNFelJtYkdG?=
 =?utf-8?B?VWVJRHNjYWo4Ylh4dS9uSUZPeWlDdDFZTzFHRDZpZmRwMDZoWGtCcFkwQ0tC?=
 =?utf-8?B?R0FuQXB2azNVWVRpTGRpQ0g3Nm5yMUpSSVJZcWlLNUpEZW1wUWlFSm8vZWVy?=
 =?utf-8?B?TlVqdHN1R044L0tocWJBZ1VkbTI5QjhtejJOTnlUSE1rYy8xbkFsMEFESkJr?=
 =?utf-8?B?QWNzMTFvZlNTcDEwM2IxdGZUUzhBd0dSZ1g1cURIdThXc1BIejhMR0J0S1Bx?=
 =?utf-8?B?bHNtdXg2Q3c3bHhZaE1ya0hnMUVjUmgzVEsvT0pUUXZNT3dQRThhcEpqd3pW?=
 =?utf-8?B?OVhBMXVkS0lydHRoU1M5aFhLSkwxNmhjTmVidVhJa3BTSWNFTlJsc09Ka3ow?=
 =?utf-8?B?aVkyTnhTaG9PSUlSakpwby9MSitZOVlGRDloMis0MXZYNEdGbWpuNTlrUjU4?=
 =?utf-8?B?a1hHNlpqVkxaNVlyUU44Nm12ZEw4M05NajE4QVlZSTZERkF2QjRSYU5Sem5Q?=
 =?utf-8?B?SEJpKzV6cDUrNDJxaHJRc2NVLzg5MmM3ZlZCUHEycGE2TmQ3ZVRud0NwbEJl?=
 =?utf-8?B?Skc3ajZ0cnJkbHhSMk1neWN5SDhDNU9EVWUxNW4zSXRpdG9DU2o5SVFQd3pu?=
 =?utf-8?B?a0ZHN1dUeWZnbytNd1VKejVjWVl6QmNockw2ZDBKM2lEanBEMGJiS3FVemho?=
 =?utf-8?B?V1gyazRIclhIN3VCV2IyU3JFdWY1K2ZUYmlLVGp1QTdpSVpBTjJreEp3THB6?=
 =?utf-8?B?ZGY1R2RaY1hkVHJQK2V4bjdDK1EvUWhPTWUveEdOMFN5K3BYVlcvK0JZaGp4?=
 =?utf-8?B?a1YrZmQ1WkNkRi84TTFYYVR4RnRhaG4zL0R3M01MbXl6SnhBdkZ0NVFUMGpi?=
 =?utf-8?B?dWZoMGhYMVR2MDZzMjVpZzQzOXFRT1hBY0lHeW1VR1htSkhsRkVNaXE4WmZx?=
 =?utf-8?B?bWhpNDY2MzFXdE5WcENRSU51Ulo1cEduUjZ4VTdRQUhUaUpXQ3ArTWZRQ3Jj?=
 =?utf-8?B?Z1dxWUNrc2hsUWVXSDlzaU5qSzhFZ083Tlo4bjY0R28zUDNvUElSNjFacGlt?=
 =?utf-8?B?RnA1R3NyOU05Mk1NdGthYWg2WUZmR1BWR2grOTVBZDdSQW0vOTFidmtpUE5a?=
 =?utf-8?B?WUJobmJvTmRhNlBUMHJNdDNsODU0ZjRVWUxPc3VTbEFlb0JCSGlpOFlCU0ZP?=
 =?utf-8?B?NjJVRHg5ekFjOWZYUGYwT0ZFT3FlU1lXZjFCbkRMd3I0a3dOemJHNm5lZmZ2?=
 =?utf-8?B?MElaVkpqUkcyYTNoU1NRNTl3RGdHb2MyRVdsRzRNaThxaTB2ait2M1h6dGpu?=
 =?utf-8?B?ODNEUFlLenBZaitYTWY4SVlEMlRsSHVaTVZWWFFpdFpnRGpVWDU4M3g3ZUtU?=
 =?utf-8?B?eHRlWGxGc0FzVWdRUmt3bTJGdGExZDU5S3dEenV0ZzhOQnVEWXNnbE9Sc3RL?=
 =?utf-8?B?c3psTThpVGg5Q0lLYTZVZFY1RmRyNUdqVHFDZ3F3cWxuWjhrUGJqK2w0ZWZi?=
 =?utf-8?B?b3llOUViQ3lLRkNIQ2Z4bU1VSzQ3Y3F0elRySlBnc0pMb2hqaGVmQklxaXdk?=
 =?utf-8?B?N0tCT2pSa3NmRnZYeXh0dEdJclBiVlNSalRYNDdJckZITlJhN21kUmdYN29G?=
 =?utf-8?B?VXViTytwNlRVRWZwcmRscUxRTjBmbUY0R3dRQTRZcTd3RHI4OXFLeW8vYlZ4?=
 =?utf-8?Q?4MGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 13:07:27.4815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f88c53-af02-4e33-0ff9-08de0734cbff
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6916

Software RGMII - GMII/MII/MII-Lite selection.

The bcm54811 PHY needs this bit to be configured in addition to hardware
strapping of the PHY chip to desired mode.

This configuration step got lost during the refining of previous patch.

Changes in v2:
  - Applied reviewers' comments
  - Not setting RGMII RXD to RXC Skew in non-RGMII mode 

Changes in v3:
  - Specified target tree name
  
Kamil Horák - 2N (1):
  net: phy: bcm54811: Fix GMII/MII/MII-Lite selection

 drivers/net/phy/broadcom.c | 20 +++++++++++++++++++-
 include/linux/brcmphy.h    |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.39.5


