Return-Path: <netdev+bounces-102656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35701904155
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DFDB25868
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 16:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C35A5F47D;
	Tue, 11 Jun 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lBEkchoZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE95BAFC;
	Tue, 11 Jun 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123337; cv=fail; b=bZM9Nmy6K5gh96pq8oQB0cwjBCIDYvIqT5NHTAnLrkoeQf3Izo0b+33SB3lIsbK7O3FJAAed06Um2lzspLVsq6AFKsETwEwLM4GAgLnfk/ZJACXY8SG2VDT5CJBPGGmfWZUBUFO5r+uMWPL1t/zKJ4Wpqu9lE2lBxxK39tMcaCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123337; c=relaxed/simple;
	bh=JkXez2qJZvQa49DEDAn0mAxBd0XqLq3AT+iQ1SqxX0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+6JFfzsTDj/xgDQeB6w+70TxCldORicbD8Shc6Nop1cFCG2fW5j46RjWrN18016bq5MNpmJSUpZ9h65DF3TcLYc+aI++9DqDpIppNgTYUpFCafs1ZrZGHDPav6E+VhVnSA5EeDUsqd3HDnvQ3hqV/zUnyKcU7S7l/3tfSc/QWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lBEkchoZ; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPcHxDzWfV8aKVxkUc692QpVQYoqfs6hL1cXqm5SmV6IpcZOZpYyN/Xe2kZUQMH69LbXzWphOrRO4pIWtKyyU9g6h1VDVpkO9iWM+vmIsbtk3IeawiNgwP9K3CMp6ZwNwaZ+W90rRMVBgrMKXsy7VknKLBgMri/lHwkDRjX+YaflUv0jMvYZnLuL89uxki48W2ar2EWxbrr+HUUrLghkYmvqL8rrjG/m6xpxgCAXIZT2GPKg8opMeavkD06T7dDVlfMxT2tzkhTanYd7+Xq2tDw9nkhuh6Or+3BLnEuFU5+gq9EBhdygGI9U+jZ73otdQfSYpKYD3JkYG/FiDVB5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65IL+f5STpJuNlS+ntBsjZ4BhYTF37B+zPjZiTWIns0=;
 b=NdXoCgvWpSUXYaG4k2GIsiH8gjm5QAXRZfS9Fkv6Vgigsu1J/hMahWI7DRM5YPcMKOW2EVfd0/ff8+vuG2px2jtiE8RfWz2e6trPDWvsQqj4qrxsOHTHm1vHIo3qyOaeXgcQFsoDAevuubLWXn4q6ryKMtLHpsY2zXSt4wPSRVHV3/ftYbryzMqsypLWtTZIREMqGJPGAq9Lk/n8gGUffAWKUpk0+in2/7vdBE6RycQuEz78bf/MGfDMTYdvpxhthJWgk+ax5Idd9UfKqKM55Hp3FrzjqP0tP8rHfwd84/QuiAvHI/I3MTvsGc9nXVYnhnGh1sTIO1evzpWKhgyjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65IL+f5STpJuNlS+ntBsjZ4BhYTF37B+zPjZiTWIns0=;
 b=lBEkchoZhcEGlMLFdLXcNO8HKDGVPyhoE1mlcxdNhV8exWe+mf/p+fuqwuDeW0XjE1isRk2fEDZYCJHmpoMznhFbuBHEUKq+E0lAhIUowlmsCgxyIAqUrb+kh1X8HtasJtXyG2YUXlIPbsMQXUvkG5lO+nob1CdbsKCw/c/xLOc=
Received: from SA9PR13CA0141.namprd13.prod.outlook.com (2603:10b6:806:27::26)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:28:53 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::f) by SA9PR13CA0141.outlook.office365.com
 (2603:10b6:806:27::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:28:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:28:51 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Jun 2024 11:28:47 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v5 4/4] dt-bindings: net: cdns,macb: Deprecate magic-packet property
Date: Tue, 11 Jun 2024 21:58:27 +0530
Message-ID: <20240611162827.887162-5-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611162827.887162-1-vineeth.karumanchi@amd.com>
References: <20240611162827.887162-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|BL1PR12MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 869111a0-ff71-49ce-d952-08dc8a3394f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|82310400018|36860700005|376006|7416006|1800799016|921012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lKDscHOsLCwh3Xb+pDI9Yv2Wim9Ptk16qyxImwY25px4SqR3kO4RRv1TysZ7?=
 =?us-ascii?Q?7O4d02rkY20l3dyydyFTSpHKcQjCMDTvBfudQ3ueiCQMwYIT09RPPm3mHM/6?=
 =?us-ascii?Q?PJWi+kW9hlhvPMV/fqydpOoRA3AIElg/Y85wLlMZdbxgmAhLxoOhbN7roSD8?=
 =?us-ascii?Q?0n5/+QMTVLiZaGSsqLaR/x4ZbHUlRx1paWErG4RTJNteuenBtihmrHTEuhYT?=
 =?us-ascii?Q?E90GkjrGTDJpl2MF/HjAnf3Gks1rx09v+UKjoRtmu3Z8whEPLCA70+/MOjWX?=
 =?us-ascii?Q?xWirNIjRvN3RKTF3NNWWgu+yDSswCOHC/NomsmuU4jIbUeCQozNQsUxFJNaj?=
 =?us-ascii?Q?bqFhsnr8aOsFSWL1ipP+6X1heWN6czQ1vNbwezU1ManMdmvNW9zST/YPX6aH?=
 =?us-ascii?Q?lbfvf458klsV0um5GJf8ZcB2HHonlzloBGzPBpQ95E0psZyb7dVtXFEk0cpl?=
 =?us-ascii?Q?EkZgCp39+A1QDRdqR+EeZrUy7mn66ARcKzkN3F02jWYMKlJ1Sbh2ib+VGs/y?=
 =?us-ascii?Q?iLsx5sP0mHMFWcMFOgsuFNyf/vYQnwfJgIAkqNRNfIfv/42bQQsnvX6uw4TG?=
 =?us-ascii?Q?mLMT4lAeX6FHzLnFrVmaDseSGlXD7sS7052KJRhvAfPkhZK0EzSP1nN8WX8a?=
 =?us-ascii?Q?IfY+cevkhCV/2BlL1+WPx58anMPTV1klhRc8H/6vcLkFKNF6zb0cPwjT+1mT?=
 =?us-ascii?Q?bHTYpHFF5Dc+x/UyVyrGfwyjoGbqMkndza11b20ekVTIhRDb6TmW80Nwp6I+?=
 =?us-ascii?Q?tWgCGEiGduVGouTpHPAPTNIzDzg09lD9eOn3VldauAxaa222D17dG0XOH6ay?=
 =?us-ascii?Q?89A8gzfiDx6N5ZIcUQYPmoch4/9WLwgIBm5+oRNguRnU6fdb9XRnynXFF756?=
 =?us-ascii?Q?l+ixRX0sg4pZikYT5y6DYan3qw0tAXkhRvO2UAaSO6nLnKrqKyHJHHDImGVo?=
 =?us-ascii?Q?5kfXhUsrSFGvRO38LBSKzy9TZQwnclIn3IiAqcQscYt2g+MuX7uJ4B16t3mY?=
 =?us-ascii?Q?CkGXdGUx3FtAtaOJQ0ZBeMehDEoSeAfzZCj/RaI6SCv+U4sepjGHVMdeV4ia?=
 =?us-ascii?Q?dHlJWhLNoVU1vFh7yusIBV1MgF8hRtkosbwJk/tWk1yDxaJ572j3ULRDiYOw?=
 =?us-ascii?Q?3+Xe6HZgQJ2ahEQsiB8oXV4HtmDITuRA96b6RmuX2FsdsLjpq4HLC8+d3q6v?=
 =?us-ascii?Q?xc5VdKkEM34LPPJfdwbGVXyqvEJ3s92mSYugPkoBHDFN68Z6X4cqikemVFp0?=
 =?us-ascii?Q?6Q9c712BeirkEW//hHqhgcUC7WoQ1smJ73/nmSulk2684lZ6a19ax1+TKaWl?=
 =?us-ascii?Q?O/EiTfGeEYvdQOwIg6xMQ1JDPQyXBoDE/ePvvGsBNekJwY5vfqtnIrzDDgxJ?=
 =?us-ascii?Q?zHiQ4x+0fbUy0gwEzW6XqfAqVgv+sutnXajsrBAZyeTJHEuNKcLgx0AaTMkE?=
 =?us-ascii?Q?xNVsZZd6b2I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(82310400018)(36860700005)(376006)(7416006)(1800799016)(921012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:28:52.5819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869111a0-ff71-49ce-d952-08dc8a3394f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899

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


