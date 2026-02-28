Return-Path: <netdev+bounces-262115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ITQB3bSomnA5wQAu9opvQ
	(envelope-from <netdev+bounces-262115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:33:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0551C291E
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F87E30847CC
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7C43C04D;
	Sat, 28 Feb 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UGVn/RK0"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA643C048;
	Sat, 28 Feb 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772278339; cv=fail; b=l+adHhKLYIMJ/To822ziUhxvD0AxpGJKOC4JdJCHR5rZ4rWnJjlEi5r1k7pDrnAq/gcWNo+xx7777Di4OqNCDicQbobHoouwE9M+5Q1qKGXfoeGfhguj3kFTLEy8AaG0JndVLa8fXF2Z7wy9g73tBEuIltuBtPrmAI9PQA2Ip+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772278339; c=relaxed/simple;
	bh=EleUlzjLoeRpbhm6lUV86I9eteTueLvwqd5T9HrQUmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTjfgY7vun4rm4kJ5DHHhWXlh6ZfkE/BpEPH7acR5nBRr1Tgu2DAZr73iJs/F2PPGq/8MWvDX15BBXZir7yBGYzSnnFAvj3Db6JooVGhQYX/l3lfbQDlcGIN1Ee95An4JZVcIpzamuM5TxUuDyOe6okSnX9D8lZnfWi45HfkV0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UGVn/RK0; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=resaYEzBzvh+FqDHZJVA/1rPr6BykHIU7OMKkxHWBIHwA8DNC+J+eC+UV8vv+sjZKyoWg2yNb1VR3snKyw0RGDf2lQxY/L+1anGfx9efqRt82365qmsX0lDG4lUt3TLwaBqywC58C3wpXcf1JUnwHVnWwJmDFQr8Hhxm3cfepZOnPnVOBd2wNla6LwVhsAe5GRuehOcrbBbV067fStCF04aHtMqxGINAdHNE/Nm23YaLHZtS4eXRvziwzn8/WwlOLpDQrRmmTwUGbINmxky2iDUnNTHKhn0s2+BHgc8fC074FbKUzojIsCXCBZ0B30GFBxwbBOPtZn1NCtJ7xTwnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NecDxDW2+KlFt3y2eG8Gf1PUq/8JxfMru1S4VheYteU=;
 b=gM6EYh4WOrZFfmmuUJH/uJXDhWKq3dMk5PUv9Hi0Vwn4EP5R509djnSTsYeJFa9yVhQFgk2AlfDFXonY5aReCP0nXYFDmGx6PsEO/YI/v0GS2yRELlFLPgEXcKoE89OsTIdb0rOEP7Hp7ljbJqq7FZMdq6eG4gY7SBsJWQl5urQGAIBT8TrAtZUNzt4+4Tz5vtQ8zfVZJY/8lFZtlmcR2ik5CSVD3G+Fr09RhUY3dwfpV2A0AtCgF2fiSMQiWrgkOaefvxIOIsT5uxupNB+ToGs7OWfQRn9yXiJc16qC7Ewkqx/OeqWbWMNMwFsk5f7d2Aw2WMEqt0ZFap6VIWaDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NecDxDW2+KlFt3y2eG8Gf1PUq/8JxfMru1S4VheYteU=;
 b=UGVn/RK0GfRKfmZPRXn0MCfGx3JN+pu0wVgwtRrnbDA3G7Q+jCVFvaxdfD37lrujVAHKzEhWMwFTIQ0PpK+iUfOo/6lY5aop/X9fPl8hPpENrXYBNWLi+Nk4EAAeCVZq2IdyF3uxVIFePrR3PautNF3T2g6w9rNmWWJ+nc0hyms=
Received: from PH3PEPF000040A3.namprd05.prod.outlook.com (2603:10b6:518:1::57)
 by BN0PR10MB4919.namprd10.prod.outlook.com (2603:10b6:408:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 11:32:15 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH3PEPF000040A3.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.15 via Frontend Transport; Sat,
 28 Feb 2026 11:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 11:32:14 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 28 Feb
 2026 05:32:14 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 28 Feb
 2026 05:32:14 -0600
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 28 Feb 2026 05:32:14 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61SBWEEK315424;
	Sat, 28 Feb 2026 05:32:14 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 61SBWC9X005196;
	Sat, 28 Feb 2026 05:32:13 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>,
	<danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [PATCH v2 2/2] arm64: defconfig: Enable DP83TG720 PHY driver
Date: Sat, 28 Feb 2026 17:02:03 +0530
Message-ID: <20260228113203.498839-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228113203.498839-1-m-malladi@ti.com>
References: <20260228113203.498839-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|BN0PR10MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: e83f298a-a2c8-44e4-7a1f-08de76bd05a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|34020700016|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	NPUXtdGhzQ5vZUWSYaEYX3Ko0tWVrfxYzBT8Rd/jpoUEdL/FNInu6tktMEEdNbZXswBBM3Xy2wTPgakzOT8U558tFAgToDh/URv5lKJE8HxGPsm3JcZ5f+PHQdLgZZOLQXSwFvOOzN5j/B//O+EuhVzoaYTIJsyp9sF/jWCxQAZeWTGzUh5oq9hRH7qz5wh2hHIggkZoSyt6TNFSiym9KW7kZqYZX6MD/ZLauqEzafOu3CXOcH236BUxkAmqwpW/l5OEyditizXULA/VSMoh4DH2sPdqigYE5AgcB43spBuiQlNbiNuaR6YlJQ/5p0uWoRnrEBaE1+TjkfWH5oUzEUi2KyW0AVtmqwcmILehAjKFm5/xS4F+2dOsL1k+eWyz3CP1JtntQaY17HDjPZ20eScM/PU1z3/56v3X1SffW8uicMRfACAzo5FCFJgY9hnnQfrCKqTay36HhftW15kBPg1k9TYrDmf7geccR1Nf3ljB8WXKDxCilorrYMdoDwGtUGY8k8fkrGA8Kl89bsvru7Xgxkj7M75se0Mo0qJN9EZV9CMtUifWh56K1ldInoRHuvP4EB6j8QUctY8TfpDhgo2MAQiycRsbEMt+D7bdRW7pUh8Vg+1UZKW2JDntHMRUH4s6rqqQEybceKfopnGCwJIpipHptJD40DitS51KECCEo4lwoe+AavgY8KKsFyM4hrDbBAAsV/g18KFg31b75s0F7NKptefvzeKk4UqckCHg1WP3nLKSg6kIJYfeKsrsPu4KM99kfU4v597fnoaQKw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(34020700016)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CcLWSpOiyal5W4ji7RInVcz/CgkLkEPy4Wy29nBo3Qh7MWPXXBiksMGNScCJiSTLbsIDkDw/ac6Zw1Vt5ZZMMUG90kZUMoqLodcZCXdV8DxhnUF6gSi27oOgj3piYxyCWwlcEeyCAA94YRXxdmPeIRtxAKUctxTK/Rym7Jk3OSvf/RRoOzlt2NZ4ptjLptdc6umlaGgLDLiVKtPBTPV8bdHChE7AKbpyzGmQrl0wy6ontpENz/HO0g/ZeeLft3ZtWLy8K521u4+cxTaU5o6n+yLZcrdEWgOIozA4NDcwYGpF38Mgk3vqrBuY1PtHi7zqIyezPircpQdeZczy9o06OI6WfENMHB/z7HzW3m5UkMo8BQpfDzPoNOXM8SNgCwfZuGLB6tSLI7saWu+Xpb3eqdg9MNx5Z4IZOjj1ItiACLJy7XYYqvWpzQ2RsKrWoFld
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 11:32:14.7895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e83f298a-a2c8-44e4-7a1f-08de76bd05a5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4919
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262115-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,ti.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 7E0551C291E
X-Rspamd-Action: no action

Enable DP83TG720 PHY driver as a module to support TI's DP83TG720
1000BASE-T1 Automotive Ethernet PHY. This is required for the
DP83TG720-IND-SPE-EVM daughter card used with AM642 EVM ICSSG0
interface.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v1: https://lore.kernel.org/all/20260226185448.2167189-1-m-malladi@ti.com/
v2-v1:
- Post this patch along with corresponding DTS patch as suggested by
  Krzysztof Kozlowski <krzk@kernel.org>

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


