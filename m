Return-Path: <netdev+bounces-266487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOW9IAoAsWn1pgIAu9opvQ
	(envelope-from <netdev+bounces-266487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:39:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F0625C7D0
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71AF33035491
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9C732572F;
	Wed, 11 Mar 2026 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nCjZf/JC"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8712334C1F;
	Wed, 11 Mar 2026 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773207556; cv=fail; b=EPRoIw8Cwe5kr7TtHPy/vHO2N3naw/TorNxYKNu3PsRmIVoYyCbKFgMVyTivyNaJmdUK2zXL7Dk4suVFSWi53uYBjiSkeZ3IdRaTSA2ZOUx3LxP1lSXeSbCOeVB1hgzLgAMc8UrqOpfm6ZuNmplpxgDf/+r4ECLUhyebiEe9+qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773207556; c=relaxed/simple;
	bh=Zd2uYa7Zq0viPxyrIqa25xV+nz+tl+wW3Dm2JcV3J9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6b/MOVri8MGo8eTMsLZ2xz7rgWvBZ3fMgidB3FzTBhOqbRFivt/hqUgMqnKKLRzGBAmYKPvb4HXj0VZauy6S/5gZ/13pyNGtcg5HopKQsC70YoplGQJKzXr1QLYhGYUsyZlXk7R9wHqIPfgQB5388yzHZIFwn0eljJ4LR+8xH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nCjZf/JC; arc=fail smtp.client-ip=52.101.85.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooU1M/voGQBlZltkD+Zle6kl7HJoknkixMAfHen2BchnvduNuyTtae19URlF75fqagUZODBm2bqaubZ0YR7GyNQhQeuDFwzHVOLeJJgpbWTIUFjl26JYoOrZGQCa0Ex5u0hljqs1BCnKJYXXOSdIbagoom0xfj/H5+8j1XoPbYsjXxHLJEsyFr3m2Gd+J30c+aZdJK0IljyYUqxTcAHilqbMrAq4nVWW4Vg3QbG4yb3KWa5sDm8ybnjhRjspUpQoPl/8guZxKfhlOJW9egQkt16zYwcXKgRk0Dc60otlxrP5UqiOMGF79pJiI9cR4Rss3DPxb8XNtEh/GJxxxtIsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iof9wozdCNF9iBqOefC+tDROYRV+4AnTEkj1JUAX+M=;
 b=FscGalabgDotkgSeUfO7z0gi0lFQVJc3U4ywMBfytMt+zke4wjc+ejg8i9Ppd+ZRnJXyy3ZpNLto2swCwnmLP8CQkIEcwmsJf4nG/StHYTJuNeU34diM+t8T/MbPvWBnh9sR0uJVmbu3GzMUV1puhlZaYppO348CvD+BO9ArkWPWYtUsBBMUGEvZqLFsUXO+cgeCfOO/y2pKH+VM67PAclZvJpMx6qD7chUninxXct33/2CkxLHfvdAxA6o2yiMiwKjTyXNNSKet2dGfHy4/P3TcEKrNNXzOkLg4fbzzLKvwg4+3qMueMFK5ojdghTOv+ym/sySH3132FiYKXOdYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iof9wozdCNF9iBqOefC+tDROYRV+4AnTEkj1JUAX+M=;
 b=nCjZf/JCt1OEPC2m1SHTmD82njpDk6m1z8Tx/eGOqmsIe4WX1gZppJZqfu3Cej/KX0z23BsXgoecLFOAs2XdgbdVko2R16uqD+W2jARs/oggJeCM3RpfLYVzCVcKiVH2msJkbuiUVGLYQvWfDEU5eYAzPgbxCfw3djLV0/2KIBw=
Received: from SN7PR18CA0024.namprd18.prod.outlook.com (2603:10b6:806:f3::33)
 by CH0PR10MB7411.namprd10.prod.outlook.com (2603:10b6:610:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 05:39:11 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::e2) by SN7PR18CA0024.outlook.office365.com
 (2603:10b6:806:f3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 05:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 05:39:10 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 00:39:09 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 00:39:09 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 00:39:09 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62B5d9IT4179498;
	Wed, 11 Mar 2026 00:39:09 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 62B5d83e028470;
	Wed, 11 Mar 2026 00:39:08 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	<danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [PATCH v3 2/2] arm64: defconfig: Enable DP83TG720 PHY driver
Date: Wed, 11 Mar 2026 11:08:52 +0530
Message-ID: <20260311053852.1034244-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311053852.1034244-1-m-malladi@ti.com>
References: <20260311053852.1034244-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH0PR10MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 968dec0a-da3a-47bc-dc72-08de7f30855b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CGrCvlMjWfmElSEin+nHDxS1HnT0vaVV5DHyUmo2RGpQgoNjxK7U6/ffrqXoFvCLdtEGCCObC2LKFR5VGdri02KsgRjqx3/9em4Pdq2kFlce571RiqnJafD6ludI3h92KRFtaW/YuO7uiCJ9mC63qmrA27Hjc34V1NvZrzbRYYS4mjEa9jgKZZO0GcsGLEHQjHnr7h7pXo1Cnd6nn9PwlO5Zjwt9rd+IEyb0T2eQq9zc6BU2fq2V0D/PS/JiYOzVp362ne3ODEoB7pPty/QfZgK3J4/mbZ7zPKedZTutnmEH0FaKaYFeIeCE5+WLpfIy3U5DXnhIDpDdg7cRbyqOmTmTFW8T9x6bxq47FSDyouSA8XDwEqfoP6jNOhdwFsmzPSapEla52XnERHYsy8ShYM9LvDw65huXtZZPrmBsnMubL3ggWSJbIPRbnKUTy13IjIYPxbzXsSiz+R98Eht+OckUPbL92VfPGb/pRLF1nXO8+VsMyV1M6NrzxOSAusT3RbCq8GhPb99tfapTOZxjR6TAJ4USfBADY3Vf7PhhKEbm6X30c/bx7qDEK5GZlq9Mb7eG1RSqXc9Zs1vlPZEcLzZbqj3F3PdqlhlFnqvwhR5lN/Jf0MgCESrnlmvbOlf0PO8guxlvG/SLgBSUOpkpM0EiABmMPJZJKlZCB1kw+KzniemL1tG/SV9kCcsDNqRmjpyYUVSzZ6pF8PExDXFuoHcqd6Pf4Et2BbJG/rvNIBqmXG30W5xXKTdDTB0Axcn3apIZW2IUXG9XoS2/zyb+pg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kyki4ls+QZnFbMXjeDpqJZSb+jKf8aOI+FxA9WO0f2WheQnHrSzTsyV+EeGCln8cJUZkNKjgMP+bMR8XQ5BHRdWuCJBAWKkk6ZVMpZNEZHPFduPJ0P1yqkqsXJhNIztNLMzlXnFA/sMF6/OQFVjhynIkIerVYkUwESFaw7+y49eXDmt7gm9DdXJIpCqCEbzV6GDib5G0jg/soDm//aLNo8jHyrAX1IRQK1C5ffCOi+EPDapoZQx+Pb/XdGskSaQcZUBtc8EmYucX5SjrQBHvjkHhwCaTzva6zl0tpwfcF87SEJ7uVRLikHJQPyDQMOyBeWNazVoReNA+0HLYBr/JSOnhbzHJeCtVLWaCX9ghGmbccljK/s7NEV/rHCMezA++YIdPmmA6kRtsogj7wFEkt+U9kHSDPZfZMFnJDfhO0UAf9has7HSOfgMk7ErJSkng
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 05:39:10.4976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 968dec0a-da3a-47bc-dc72-08de7f30855b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7411
X-Rspamd-Queue-Id: 26F0625C7D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266487-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Enable DP83TG720 PHY driver as a module to support TI's DP83TG720
1000BASE-T1 Automotive Ethernet PHY. This is required for the
DP83TG720-IND-SPE-EVM daughter card used with AM642 EVM ICSSG0
interface.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b67d5b1fc45b..3b88df2ca5e1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -420,6 +420,7 @@ CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_DP83867_PHY=y
 CONFIG_DP83869_PHY=m
+CONFIG_DP83TG720_PHY=m
 CONFIG_DP83TD510_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_XILINX_GMII2RGMII=m
-- 
2.43.0


