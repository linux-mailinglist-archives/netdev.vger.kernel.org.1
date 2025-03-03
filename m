Return-Path: <netdev+bounces-171273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC617A4C533
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8480A166BA5
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA8423C385;
	Mon,  3 Mar 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Nfi38gvF"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2060.outbound.protection.outlook.com [40.92.52.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089B216E39;
	Mon,  3 Mar 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015508; cv=fail; b=C4l3rKcPkMkFFw65QIc6aqWzIdBknEdgkRrG853rVadacsSV1Mj8cx94brMUm/DXj2L5JlYAorXH9hO0bckhFLuaOlMipKIWArhSU9K+aFImQ2b1cigf607E4iF/da+YKbCKl43H0zTK3kuvlxxohajHobhb+txDcAG2RV8cAW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015508; c=relaxed/simple;
	bh=Nmc9K2GeQBMltDoFoTfx9zfy5ZfgDspY7Jgccqz7b/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aScUHM2B2fooR3YzqwiAuxRa0rFqStNw7AEvR58TZZEPct2ZDDbbUAQiQWxCywouA2TzKFyq8Stmrs+94RVbHpL+kbfH6vm2GaJ9g9Ktjv9eaAQlDIWp/l5lhni0maenWTn9teUEoSxYbZIJqRFjGx9cpx4u0sUl80kTORTvIN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Nfi38gvF; arc=fail smtp.client-ip=40.92.52.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEnSh2mL1Q9jq+gkhwEZlYKGn80zF8o+uTZLf9SXadsPdMDOEW7oHZN3tIaCH+jR+dY3k3GHDuai14f7E9szYv3tryqRrs46a/Cp2JyWFhAcN5jRzb5q9IjqxquHCYSbbu70Jq6SalUzQhM+fktR3kP538AJmoiXROapMCMJ5vuUNTQp2BJh6k2bwU5ahNlYEaMz4Ls/XMybTaTk1HbglHweX3Yy3IKVsRPYFEK24UcdSM3LSq/BAP6X3lnVkFptYooVWUYdtpzLPejgWO1FGb72XzvCG+QsDf4cyz+nLEiQn3GI+NSp78CPxuiGZXiVRduUfRHa/Y5/RFKLZMl2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Eso3N08nPCUhdhH3bplJHbOHdl80A1CVNDGUXxcRUg=;
 b=QwRj0iR3vMtR0vJ7Bre/nS5aN5ske7BTY0m/yW4PtKSbeNoMzmAd5led2ZN5oL3EfoxzUVXgOotSafxLG2A9u0P+rloSueGGMWx+7tWzP99ixOXc23ju70D43Av+nqPEv9m4uj96bqAcutjK5EsVUkoLDEIcxmo9bghSiXKZ56iocannOfBlCgyc13gp/ff7qtRFIxbUGRoYoOvBfuoAuDH3A1kbB9DqmQ1wfTafXZVmlHGY5PsBpjRTIxDgdxcvGV38gisuzx8qjZ/pHAoG+l31bASUDs54JCvdl7/lSOjd1Zqo9PSLKSPoq4VHmkxh+qMju12+I5JeDYzYV9HTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Eso3N08nPCUhdhH3bplJHbOHdl80A1CVNDGUXxcRUg=;
 b=Nfi38gvFWU/hbvmiRCTR8G8HLGAE6NIKwId/Qj1YDtJeweU/ThAjkrY9E6pXVOyvA+yE94yKqMYclHxAUQHWT0ARpWcC9kSuloli2YhMArXMk5Nfdc8inilbLn52bkQ8e4gH3VOB6bZ98+cQFVFmHcmG5vKgJ20E9SNgA5lG8jEdHvsUCpxBg5RINZizZwF3cdzXvUMYn3eORYNaiJFTi0Ja3/Y9uxsSDNo5n5cT+svuORFavg1ZNUYSYJDEQ1i4qGDlnOV9UrWM2ZQ8sidEnxTCxeWU+h3J0syIDdrj9kh+3jkW0kTPX//z2hT2A1zFGClIuP/vn3nfYIBqc+jAOA==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by JH0PR01MB5560.apcprd01.prod.exchangelabs.com
 (2603:1096:990:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 15:25:00 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:25:00 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: andrew@lunn.ch
Cc: olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rmk+kernel@armlinux.org.uk,
	javier.carrasco.cruz@gmail.com,
	hzyitc@outlook.com,
	john@phrozen.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: net: dsa: qca8k: add internal-PHY-to-PHY CPU link example
Date: Mon,  3 Mar 2025 23:24:35 +0800
Message-ID:
 <TYZPR01MB5556D90A3778BDF7AB9A7030C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <TYZPR01MB555632DC209AA69996309B58C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB555632DC209AA69996309B58C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0094.apcprd01.prod.exchangelabs.com
 (2603:1096:990:58::19) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20250303152435.6717-2-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|JH0PR01MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f89c399-115f-4607-22c3-08dd5a679028
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|15080799006|8060799006|461199028|440099028|3412199025|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ysw0tdN9l7z/EWPNkVr/3BJ7BJbA45LV5s1snJjDTN3+y0ZuBk3Hn5N9e7So?=
 =?us-ascii?Q?k7qsexocTnMoJupw0/NSZFhj1VkBsukhFMtVCGJdKHP7HPAd3CqwxYlaET1n?=
 =?us-ascii?Q?FJr9KQ864DyOzv0rUJi1EfLH+3/X5Xf/bgPn46wD2ZEkbZ818Bju1UFrMcvG?=
 =?us-ascii?Q?3b3bUO/Stj89h+anMum94yBd6jM053IbrmIQ6TninOPbgvWKwPIPpFYGP4aJ?=
 =?us-ascii?Q?8tDEH/CVVDdl6aFTHXkwsCROfx22MSjfCKEjaAFF6Rz4FhVVtPN+DK+R4S5m?=
 =?us-ascii?Q?I7KwJPlvV90iHd2R31KsfUvmWyzgkl+r8aEoZDBFsJcfSLiRxMBM7QUkCzCc?=
 =?us-ascii?Q?dxDnSkpVIy8Bn8+JLxvWONwaPEp4TqUoGFsQVkrr6G7wTHXLfsEmWMLsCUUY?=
 =?us-ascii?Q?PeSKafErICHpktO6wEPwTDSgUDjmHI4mf+iA2UJdbU6i0jA9TAPIM3KkX3Z9?=
 =?us-ascii?Q?e6k8DImrVZbpWWQZ9BVTEC2kzeCRXXUCKSLmT2CjxJPudH3rSVClpAMUyMXi?=
 =?us-ascii?Q?Z/YE+MM9g5r7rO8a33iQRbMVbVkfL3q291J2UA18CJUAFxPpXWJ8lQRTfZE5?=
 =?us-ascii?Q?Ho55K+VVvHBV1b7892ZAIGKkjgrK2ozvsroU1DkCrPssIOkrW1lDPgaB+/xm?=
 =?us-ascii?Q?HWR6XwlZKV2NfCJSLpJ+MsaNS8FIywS+0XH57ocjXXG75DSLGVqkGnkFoF4H?=
 =?us-ascii?Q?8mdBQmw9X/015RsXsCqhKb3NZ/l66kbvamqdUeVryqsycwUB96RFZ3eSHKwZ?=
 =?us-ascii?Q?SdAJQz2xX6yT324ipTQnB/asuKSU0dGbxkIdb/b8DIOx2OcjqyjvQ/4X5ftm?=
 =?us-ascii?Q?f2iGRUpYl4SzfRCnZDyPRWf4a0M+oIUgZedfi0rTS2A6Ny5z0MEELq5zEYzI?=
 =?us-ascii?Q?s6Z7TK9YXgUUIvhmircFiR83rv2jfo9L04KCF2vt3QQAGwQtWJBRqr1qvla+?=
 =?us-ascii?Q?3zQ1ZK/llqph61lUMEFHknYHU4T4wbqp+b77GS1pENzJHOPYtUiOi9xsPneT?=
 =?us-ascii?Q?sNJDn2200kwUTyD+a4mY/PlstEv2ZtjXnyeyctBe0iL958JimaHA4svWaMej?=
 =?us-ascii?Q?tlFAdd4MJuDgMM/AQSuqecp+L8Ih0ngcxIYAYN0/j26KLnxrqog=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WSYK/2XaqwSEW1k6/Y1CkavpK8S4cywBeGE+kJajmwJu5S3rpqKwsKSytPqQ?=
 =?us-ascii?Q?wACYHejfxa9I2f/LcAd7FdhtW0XzAnAYFmvAUafMn8Xa2plZ0whif7/l4jbF?=
 =?us-ascii?Q?dOJMKFR1lx5s44Tot96FQBSXVuR5Kck8sd9CH0yaE6ggsAedu7wAP/bUsLCC?=
 =?us-ascii?Q?RfPAXE7XkIND9KQFfKBxclzlnxbL9qndeNpgm6jpgnjO5cNswSTRETW7JW9v?=
 =?us-ascii?Q?GKu0Np2HhQL5uCsr4fkGkhey6WTFDybL8t+8dUKhPrmyEgB8eIw6F/nOWEIu?=
 =?us-ascii?Q?jG4EIssg2v2cbbRIl7pN8eXyp0Xb7Wib3OzxmCA8EcNj5vb+8Eflnjq8j2a/?=
 =?us-ascii?Q?5TS1OvfjeoVBLJarum/bao8dhCa0/zundGuF8kdgj66305zdW/O7Z8ovyMio?=
 =?us-ascii?Q?IST8qYZjhzs9xmxPPp1ICqDdEVB0FTMdc98aco1GtOMgWVv2YE4aQUA6iz/8?=
 =?us-ascii?Q?GWp1p10D0CED1MxB0rADwdVcYG/0c0EULk8Xlm2Q+0+bzD/RPd6wB0iekvrt?=
 =?us-ascii?Q?7jDahkmN/ieKfdUVAOVJVXDosVjDkRD1XHJE1Lf/ZpkyExiPMm1GPFs/nCcD?=
 =?us-ascii?Q?AzJ0pFSEs3Wi3l94EGBGPaZt/Ip4E3/8Dr4pMbVXgBQjldBZqSu8VBHYF5AD?=
 =?us-ascii?Q?8WCqPoKjPp4zVIgVloeWCwUcek6RB27h1lteAERl2u7btDAIjdF2mDBz1CBF?=
 =?us-ascii?Q?0O0Z33u0B+efBHDrtBiCgmxHIa7feiAKYZjivORPVJndRAGX/8VeaXXk54ID?=
 =?us-ascii?Q?btTiAO+t9evBhyzeQ/GeZXSTX6eftZcQ8Oe8JJuFPpbINQFcFVPiV1X4ynuC?=
 =?us-ascii?Q?KeVlpk9YRZqyyD61kjy1YPhF2e+e7+gkHDPQnZzcNjM7goRBilHj1/bcvhzv?=
 =?us-ascii?Q?KDdVsW1IqgTwlYzsThxBO949vZDc2Mxl+jZo0aNcvCN9uhr45pYJ7B69tTPc?=
 =?us-ascii?Q?gbqxiK70YGqGeCSmxaS0lqK4y4b5pfnrkAP6tFEpc9FkJ9eL2ApIQxxU2m09?=
 =?us-ascii?Q?JlLt4xPz+LCTAENQah4j6STbju1/nmSTKYJzQCCUzC7j34G320J2QdtJx+EX?=
 =?us-ascii?Q?GoOR+Tidz+2laltADEqqc2UPG4bqcR7g4CvBmEej2vHEZW8hdsQn4Q5loD/T?=
 =?us-ascii?Q?FcCxQuVNk8EzKhO7RbIVgdfHaU61aAlTq7BJHG7qCjhZjd3HDnzLqbpY8x2Y?=
 =?us-ascii?Q?KLL05yjoT/tGSpbAaZs/AHwD41pxGjanQZF7urCn/gNSUVirO4G+K3rrA9Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f89c399-115f-4607-22c3-08dd5a679028
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:25:00.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5560

Current example use external PHY. With the previous patch, internal PHY
is also supported.

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 Documentation/devicetree/bindings/net/dsa/qca8k.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
index 167398ab253a..a71dc38d6bab 100644
--- a/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/qca8k.yaml
@@ -185,8 +185,10 @@ examples:
                 };
 
                 port@4 {
+                    /* PHY-to-PHY CPU link */
                     reg = <4>;
-                    label = "lan4";
+                    ethernet = <&gmac2>;
+                    phy-mode = "gmii";
                     phy-handle = <&external_phy_port4>;
                 };
 
@@ -266,8 +268,9 @@ examples:
                 };
 
                 port@4 {
+                    /* PHY-to-PHY CPU link */
                     reg = <4>;
-                    label = "lan4";
+                    ethernet = <&gmac2>;
                     phy-mode = "internal";
                     phy-handle = <&internal_phy_port4>;
                 };
-- 
2.40.1


