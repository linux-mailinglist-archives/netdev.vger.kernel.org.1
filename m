Return-Path: <netdev+bounces-100938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F6F8FC8FA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF425284D66
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B87A192B60;
	Wed,  5 Jun 2024 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CWJ/CNP2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD54191469;
	Wed,  5 Jun 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583132; cv=fail; b=q0WsxGp7E0eDcFGTMAu7J93HgfH4QOZPSjlPaHXK9d/dmxBvMsW2szpkIJu2s0N2Rdh1twFK3NaGmN3TS30354Da91KcPVC2ZPb++ax2wO1xKmChOsIuqfjTMmC7tPdGYOZg6MwILGSkufUX2Pb10tvufZXb1GP23qiMBU3qxzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583132; c=relaxed/simple;
	bh=CCqU4x7mkGbjoQREGgzs3KrteUuL9K18B7m7Y3uM4a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1SipAhgVYCiWFX6F4WgW6lxSto54yvDZ7faqV7UEkM/xB8tldcf59gfWGIhTxmFa1XmZF05RvY5yZ8aCY9i/qoWyITljSLyIpaz0QhYikuQo6ZuOMn15SLZFaHmQhUEv0kU5DWOYObb9fq+kC/TndMolUnRyCsO/fOIVoCrOoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CWJ/CNP2; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aww4p7uAHQO9LhPkHIKjX0c8O1l8ttdSKroDpiLAMKTdZpdu5yc9Dm36NF4ollc6Y7HQy1Nfx2iWYCkFAHghhu1UpPyo6KoGUcon0B12mZ0qC7fA1dhQdXgyB+wKVBPphIJtv3tfictKhzKzeVEsVWKuHq2iU9xhBDocoebxc9SKPQigRzB6O+eNGjRf1cRftDNclnoe6IAD9MKOHFBvlDw6UC3JXbMtL8HJBaTzQ2NdfSweFDknF9PLnaTqHKD7RepYaIQheuau6csMgiunh3ulkVMa65XVFNxvD20GRVumSKuSyv82OxyBSj61DYozQaxqdP2OGZp1WrDScv4rBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIAsN17kimib3Rc9Nt+u8IPzDOrqWVvYFyH6eUCXZkc=;
 b=gR/Ol1nsuxscL3ZQ6bW7vMnA53J5zzlXiMgBPp9uXjlyS0XCvLDJbwUBQzeV/UG5Lb1qSZc7vy2mUudSp5Wqb1z3cN3DMOtgjhHxZc5tNZj9zDwK3tUwU+hJ/hhjS+BNAI8fhF/wZn3w8ZG3JfiPdV3ywtBwk5uhjWH5s5HiC6tbT7vMz9gvhkmBUKqr+JkLXfZtLYuWEw3N54P99vdx+3Qc7gF4tnyN5UINQx6hEjaoiRR048TzlTOtcyQ7yTxog8zf9rTtr8BKnplZzSfCkZwjPmD5s1X1ub0oRJlN6swhA/yM2kcYbM936nkAMk26hPKBmT3omZR0PsDy7VILaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIAsN17kimib3Rc9Nt+u8IPzDOrqWVvYFyH6eUCXZkc=;
 b=CWJ/CNP2rNCQ1eKM9dR601oM910G+NBLUJR8J2PnI4g30+MdiO1aZ3ZqhDicVgPvymdAeZMdwlEVnCWgzNh2pwRByK4oup8nVvu0t0Yc1G3HRvON2ceHa4AeUhAyd3GqKD2EQpLpeM5DpKeWYEShWiFyYO8/9sG5PfbnHMIyhYg=
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 10:25:26 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:54:cafe::47) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.17 via Frontend
 Transport; Wed, 5 Jun 2024 10:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:25:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:25:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:25:24 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:25:20 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v3 4/4] dt-bindings: net: cdns,macb: Deprecate magic-packet property
Date: Wed, 5 Jun 2024 15:54:57 +0530
Message-ID: <20240605102457.4050539-5-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fd454d-af37-48ce-c411-08dc8549d0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|7416005|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4GRFIQZ9DPPBpfKD5HWHvCoetFiKz0rSlM32IzOsvK/Es3FwX/4t2yt4tgaF?=
 =?us-ascii?Q?nscy8qvoNIUMLcaYiFdLXoo7zBIJNKkL/wkykC1ZJ/uJFiYwadp++RxrlNMC?=
 =?us-ascii?Q?Dq5K3reeT7bBCL0T94c0jeOcPYjDDUcad0Dt6W4kpBkijZnnpoHELrcHcr0r?=
 =?us-ascii?Q?vwHdq3p4qkHuyGYITDE1BVy988R202+TeXe13oYXk4Nc0jvqdxqBUKrDef19?=
 =?us-ascii?Q?XFQ8UK+g7pwlVdB5FnglznJUj5fBrFxdLtQuXJhqRD8QU4b4Ia9e/gSRAEvQ?=
 =?us-ascii?Q?ZO4U2Zqh16Q0CL162+E8oxd97WoaMV43h9weofTsSx+Ha3RTcaVzRgrf0QrS?=
 =?us-ascii?Q?mMSeKI+89uCTPKYqt0VVIcHQw7EHnROzHxu44ct7HSvLmggTFaGZPxA6p6Nm?=
 =?us-ascii?Q?WmtG4sr56Br89zo+uJnbAjg6xEw62FRWOf8PFjRUPXPbXUkl/MFU5yG/2SnE?=
 =?us-ascii?Q?+wjjMHA+y/Uee7W9bhzbafNKlBCQq6B5TMi30mb9k66cdIb+k+stfV9MnmwV?=
 =?us-ascii?Q?vmTkciINUdq1Lih3OTmCVTjGA+pIO9AqUpSOIrLgMP1lRJZAThiO3spZsP5s?=
 =?us-ascii?Q?9KxGsxe10exUu8bpvbLEAJg0rzHgqrVmrCbSVKj3+UGgtUkahN9CL3W1nRVS?=
 =?us-ascii?Q?ZXl5Tg2Iy/TnFs4iX3js1jYYAaTwRdy8+zIZv/4axa1Ak4BoyAM8Pnl2xLRi?=
 =?us-ascii?Q?PHSmXnQ3eGdhgW0nqeFdQTtsmiy5QE2skhLV81RjsyGuwM1GWAfwiL2xbL6z?=
 =?us-ascii?Q?BFzaEtMQyX809WaaM0F+Kg7IOhEUlSwpCULGRNxFo3r8zZDNVj4dnAZMa2O4?=
 =?us-ascii?Q?5duwdXB66z3IRroveelgyhzZ/ywiRH6G0QNIAA+hw1ScqI9/X4p2qmPuULpm?=
 =?us-ascii?Q?nMk2uWb/Uw88FxZzncXXsCRBshWOHUVGsYGgts+eYdDSgVsf0qEdWctNX0Hn?=
 =?us-ascii?Q?DA/BhFG5KHpj4EmN7G+wLTrNzBy5PI99NfBrciJkCJE9FrJiavO9mlzExCvm?=
 =?us-ascii?Q?jqE8zyP9PrbBsY/PX7Owb4MxkXRtPT1NYkuwzeu/6bj1eZkYJkZUcWpubmiF?=
 =?us-ascii?Q?yW3Klwi3seUCuyzQK7kT8eqm8rWjbGgo2NcAtnuNWA3LAOyze8R/PsmqeudV?=
 =?us-ascii?Q?WzHDAh+zESP8aUj/8JIvqOQmZXRYm/kBJBAFm92HlGu7+2j13s295qZRxvDM?=
 =?us-ascii?Q?TVMKGdsoL2ls3egLJSmAQlColGiK+TVS2ucRaNzFv/y5XSsBaEQKfiyuckoE?=
 =?us-ascii?Q?WpTHCjdyZsa7QGUIaoGsNraxtoSfiOoEY/DV+jGLLOl4XV8YmCx9fSE+1gpC?=
 =?us-ascii?Q?zvGJKefcPtOI5/UDIbr4eGLg2V+e6c/5zighYHP73A/gug6o8DplV6/r20n+?=
 =?us-ascii?Q?lfrXr2eqQ28x7X3769wGbZSs2E7EFxXlynXjRQsQcB4PUGOfS4bQcMS1B64H?=
 =?us-ascii?Q?5C+FWGOLKdk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(7416005)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:25:26.0231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fd454d-af37-48ce-c411-08dc8549d0c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045

WOL modes such as magic-packet should be an OS policy.
By default, advertise supported modes and use ethtool to activate
the required mode.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
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


