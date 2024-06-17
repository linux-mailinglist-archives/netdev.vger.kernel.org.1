Return-Path: <netdev+bounces-103936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E74E290A677
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692501F247B5
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEF5190494;
	Mon, 17 Jun 2024 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="joTUHrPn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673D190479;
	Mon, 17 Jun 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607882; cv=fail; b=b0/OcBUMWkOvM8qUwGutEAEMFbD9yfqw++fHNAtlWmnXCyBDrhz2UvqViQgOz7XmC0zcmaMh8Jc4WplOHhiICM07o26eeh/OnifrS9XqPZ9TMZwCzSWyAiLmFDhxGnSK62g2+oZTPLKEBpv4HJ04Ggctnlp0nvKqWHfuzTNsZBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607882; c=relaxed/simple;
	bh=JkXez2qJZvQa49DEDAn0mAxBd0XqLq3AT+iQ1SqxX0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3bEtazcZ8pcHQw0rU061bDApxFqpAS0FOEYu25Q5qXJMODiVL83gmHp7w7WovUA/5B/zTmiYVeqxAQFoON/Bpid3syHyXiGrfp1ndzmoHwchrHDS/eMQmApas6Ocyil/vnWyFMnW1MzHPCI1SY8/bn994HgR4zBclXpj+ILvyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=joTUHrPn; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT3iq9LsKlZjdVA35OKW6GuiHa8JjXY5I1/gPehR71T/GKIGKSX2IGPAPXIDuhffDJ8Tlhxf+nVKdmxE8T3Zwcd1yN65ndZELs8Xaghn3f7eWLd+VyAngwyEf8GJcW5kEJZ1W8fACO+UOTu9DiLiW0IqFRb32dpbmzjXqJHVLZ9hlhhspu0HCKiTF9peohLEZ0zPOu4JVchLDxvTQXjouJ6FnC9UO9E4HeQwmdWqGEVrWPyf+0MIFG9HXpBKFMgHpr2Z0KMcOTpxdLXnsm9eagRHARitfv9zSKRfcplfpdoVPIjXQIJOc0aRZ0gm5sq/dSVAwT9sZWl17aPjFPrLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65IL+f5STpJuNlS+ntBsjZ4BhYTF37B+zPjZiTWIns0=;
 b=fmXZnjBR6QL1My6WEngle2weiKAWU3gU53RSBANexoLsoqPTT+w9n/+p8Ccl1kOQY43JDIV8wM8pIXF7KlPGSjDjmmtgXAlLEXm7J0SCir4tjeZnhuErd0Atz2bgv730AhYs27khvNXduZG+18+xQTXnR5s0zaPe6axJefp3xdSwGiVnB3BmJiM2n/P8o+ukh/K1akvkgAz28K7XQ7f2AY25uHKommfDi2Gpfvo7FhV/1NzREHjwFJxGwIWIZlTLWaJcQHjm+JOM7oZxxBnfo7hJi9J3KBAJVF1rC71n3/SeGp8Z7llIY5lmyCmzvKdzJIsGM8oDopo4juUyPloMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65IL+f5STpJuNlS+ntBsjZ4BhYTF37B+zPjZiTWIns0=;
 b=joTUHrPniO7eUHWgiwe8MryWjZa0qIodHqamyiHQwxrGuz9KffNwYdOaVDJ54MPaRUiEyydxtoyp6wD+riaf6aKZA7xCxXRbHMn8R1fzoDG+C6M48zFvDItQG/hHLUcfybBbFpxzgjxkSkMm9VYOYIYTjeCGmIpLONmPhIFzAZc=
Received: from DM6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:5:190::49)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:04:38 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::72) by DM6PR11CA0036.outlook.office365.com
 (2603:10b6:5:190::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 07:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:04:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 02:04:36 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Jun 2024 02:04:32 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v6 4/4] dt-bindings: net: cdns,macb: Deprecate magic-packet property
Date: Mon, 17 Jun 2024 12:34:13 +0530
Message-ID: <20240617070413.2291511-5-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
References: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: e83b49b3-0e5f-4d2f-8e0e-08dc8e9bc054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gp3GcLOKeJ0vOBXLz4M25TUxAk6ggdr2/U9hcRfgMewkXqK5LrB1DF5mS6yn?=
 =?us-ascii?Q?RlZCRYibojSJKIF7yX8Yz//fgXpj55mdeOQp7R69kgQGT9KRXaBsUdBDyZLh?=
 =?us-ascii?Q?6cdDvmu7lJIl+d1Mcm9uKs58xBqhE6SxHG48df9DZZD+IJ2AZa9/0UQAdW3A?=
 =?us-ascii?Q?CVWmoJ2s02EE/AIFSWDtuThdmDXlN/emy9p8upevgRDoPnkiIzq/AiobGEIo?=
 =?us-ascii?Q?WHhQPxxeA9vrTMMt9oBLj9slqfiCgnUFYVSAzYMKs0Tt18MpS5ACkfQmSxs8?=
 =?us-ascii?Q?FC0rkbv+S7DT0/MEY8EWq867kSvO5/hsuyZuq6OpaF3oVXoxLAeETWWD6y4O?=
 =?us-ascii?Q?kd085FbaONzc77Q8/1UWcaB3rsDBxrt7vVFySjaEEX0zn4ARtrKtyWXXHHYT?=
 =?us-ascii?Q?OR6DkLCUBiycefeS0RCnRaS10dD+gkznH4Op7Xx5F64F07niHmqKVaxaB2dO?=
 =?us-ascii?Q?Q/cYcFzKZ/RDkAkcwuLcipAPtpOHC3Ofnzu8a8PQ/LYO6PoCX9L4+Zzp1Leh?=
 =?us-ascii?Q?jdOX4Ll+lVsp4HdPUkNS4ZRQGtadWj7CaV8JJHyY+lYoQD7teBjaqGzCOGj+?=
 =?us-ascii?Q?SiecphxWeK10d927kCWFg68iTvzykzJ8qIP7t9sm3u4QsAS2bVfEp7kMjH/M?=
 =?us-ascii?Q?KmI1v3ieVdTD8p5o3dQM6ciLmXeW1ayE9O5BS0SFM38pZkkqwWsxTO80gajx?=
 =?us-ascii?Q?X6gHWXITf/xe1FG8+fKKnuPlzpSQJW7iWPrbj0QZOm2KfXAL8Qmm/GLVrQkl?=
 =?us-ascii?Q?pM8vjpV+9KO31g0qJ/YCH1dIw/f1Pn6/vr+IXML+0rSwhJxgcPnjUW8PbooV?=
 =?us-ascii?Q?OIzFp/NkiGJIovCvnKdjAh62XECBR6uQA6DhkEaMJyAx00rwnI88N4y7/Umg?=
 =?us-ascii?Q?y8KmypGvnFdufVd4Bjopo3Qn7mrDAKCEZbCL15bbmiEY/HhnDimLcNoUBusf?=
 =?us-ascii?Q?Jl6Nvj1HSbzRNgN8SOcLTbkmVCEm+WuuGlgbjfYOvTWdadNEKSgpuM0CfDlw?=
 =?us-ascii?Q?MMZZF8Igd7S+oePzsrxFqkb1JBAdPIZkR98IApRs+gmlGDzSFDdNwIh6t2DF?=
 =?us-ascii?Q?ZilxtIby2w9RtNwrSpEDCnYfLUZSEKsB+zzYQ01WIj2/LtGoBAbKs/lZYWn1?=
 =?us-ascii?Q?7N+EOtv79r1DOcrF4CjqREpuTfJ8A9CBhSJb5sMx83UHDUwsy1xBW5ppdVpW?=
 =?us-ascii?Q?sDVEVi5WdWPXhhU1SNt/6rBlNnVzyHFmwWan2CZkjJxCc1hAZp0vq9PIZxsP?=
 =?us-ascii?Q?tgGAkcfxwMAPf1lK6v7xLdC1dHW3bzuRDmm0mXMiJEzNN/h0v2LRbc9d9+Pe?=
 =?us-ascii?Q?p0MO+Nf2mkoEnh7tE9c2DXZ+mnWxu4f1cteVsSZoYJs2xsM8udRTYGiJQZCi?=
 =?us-ascii?Q?mgp0JRDeKZvHZwowAyrhkr5Z9faIqzD92aVFYQqiUWjkf+YXK/vHSDcnzlC9?=
 =?us-ascii?Q?tcOCoLXzHyU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:04:37.6515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e83b49b3-0e5f-4d2f-8e0e-08dc8e9bc054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787

WOL modes such as magic-packet should be an OS policy.
By default, advertise supported modes and use ethtool to activate
the required mode.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 2c71e2cf3a2f..3c30dd23cd4e 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -146,6 +146,7 @@ patternProperties:
 
       magic-packet:
         type: boolean
+        deprecated: true
         description:
           Indicates that the hardware supports waking up via magic packet.
 
-- 
2.34.1


