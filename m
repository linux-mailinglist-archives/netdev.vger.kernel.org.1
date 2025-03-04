Return-Path: <netdev+bounces-171522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC36A4D527
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 08:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981923ADC3F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF0D1FECB7;
	Tue,  4 Mar 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AbTNk+0G"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2065.outbound.protection.outlook.com [40.107.247.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B251FECA1;
	Tue,  4 Mar 2025 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074021; cv=fail; b=qA3oX0FAK69CXt9jssjqNXqo22bV7HM7LFEgvlIh89JQ9O3o9WBxF0oXk72ewR0H3Z5/ICLyUORO+JOZvxsAfi4h6yxT37UkFPvOrXDjStimqozEr86vOp8g01PwNATQdORH8QnWqx1izpI3VmCeh04jlte++O8QFwNUOPNDjxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074021; c=relaxed/simple;
	bh=FCIGavlohMJh9Ceuk/ftt3fUJY/22NS00scPpiuIGP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pnbi2MMUD9edNqvE6PlrTjpXmUfnVw5gW8Acf6XFh/dgoKlutCObbOuCWme4yjik9zhyfbpz1ly89xLP8cCJXm4p/R1Az3Rs/d8TogpWVH8suxnRORc1oUHg4O2m3Vr4r2FnE9GzpLyno2PxVMmNWtRsA/0J9HZqqohRBRNS4Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AbTNk+0G; arc=fail smtp.client-ip=40.107.247.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMBH9w3RU1Qmmyjj5EwIC5VuTdO0hqfYbK+OxH36gl65t+bIp+XCH9WwQLAhtkkFCBjIqcQTaJwS87IRu/LHlQEBVs6uhPzD01+JsjeSRnAiBaFlLMx46exaVCEaJ/VoSIQovMSN/4d/fylAmT7Z176AMp/GyZzNjxnOS0WBw8uwmKmidq7itrrpgFsweurKQDTSNRFLn2ZKLIMp8F2bZWbPc3BNkSWqdAD77RJPmE5laHJlNFX7rBGHqM3jpUTykco6zgRXnBi5d1LAN52qxn78czjp93K3f3wn9E/ydi1wmxuZCyGBKfGU1jNDsIzOUG+7UIkPCCnrPQ4hRiBb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVom9LDIhX23btcpGNSVRM13wz0Urd0TO/BlD5e6M1c=;
 b=AyvJhBgcsVoqa90awAIqzzf2IN+/7MjLcbSggsi4FTA49ie+2EnoQa2S1uWJHBfWK4VDgsLqXzh9H+mCaAeEPDiGYLlQAOIhFDjQb3bExiBfPzbHRdZ5cWceeto47Lh0F+kM8KQJi9dov06H/mMMdjd5UWUY3FhzZfTX1uwrcCvP4ZaiWMXWMCC3SwnWBNecCeyc8VCfGaMheJy/AP7zz8D3Ne8+xKIctCYNDxm7q7O2fMmTOGwiPmLAYNCYgNDQck6EMfTRFG87S4e6zUEgN9wM/D9eiRy4Y48cwYO4i/9txLFKxe6xZ66uOc85UUdXN38X3oIaz/WQAsxuHOem/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVom9LDIhX23btcpGNSVRM13wz0Urd0TO/BlD5e6M1c=;
 b=AbTNk+0G+y/syYwNT4EvNEcUyBFGDfjhwo6WOe5CMWzRDdFH80bxgFiZeXUQpZ2dD6A/L3hUi5jA/mz5/hobliNHsNxmDimqWqOLaELQtjRaVlkSoCXzviIrvE+4DijTrVOk+XsgoPDv1iJXWi5FYMB9oOEoYPj90W5w/EnZLK500v0OC6QpcLAKf9d49RQkKJbx+Vz6Nj6AzUcrBC/bxKhT1lad9ZaE8LxRVj4LCArRXfP15pEX8Pq11aQUCWnMmYnCSW+IYrEyxH/bhZ5xKDBVnP6+7ff5Z4rToi/gZxddnhhAygfiEQOlnqVXd1H6MwvhkAmvg9XefvW+WUhOnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 07:40:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Tue, 4 Mar 2025
 07:40:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 13/13] MAINTAINERS: add new file ntmp.h to ENETC driver
Date: Tue,  4 Mar 2025 15:22:01 +0800
Message-Id: <20250304072201.1332603-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304072201.1332603-1-wei.fang@nxp.com>
References: <20250304072201.1332603-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 8029b367-4680-43f7-0729-08dd5aefceb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Kx2rTkLe8Ldk5ezz1ChDbaM7LMyBxpxSZ+HkHbugGS2zX0uGgehJ4f0UIPu?=
 =?us-ascii?Q?CHpLsO1ARwW3mJrdvaUS6F6Ssasl7ir/QIEX9/EZ53SiQH7yLOAlTi1DwIEQ?=
 =?us-ascii?Q?ev3o9EzzwlEIJEqoKA0gwmpsjPTnU29YiJJgeqH4eHQCppOHjpwyjqCp9aXn?=
 =?us-ascii?Q?rKfraYXb43bgGE5dhmzmSSQ6wUsYFbt3WJ2+b1n84ewJFPwfnK4dB98jwe8r?=
 =?us-ascii?Q?bS2tEvDiS44GjyCVIW14/WDbhqq6oFcAOI7MjsLCVog88/CYZKaLRk4DFRKi?=
 =?us-ascii?Q?cq+xCfxRnLrnIcU8veh8bcz8xgMGnQcCMh6lRGaPo14V8cQntP48TbbTgIpM?=
 =?us-ascii?Q?pn48bf4GqWlrDKlOzSggZx+4xMcRnN0z3/r+GgakRATn9X8CWgYs+PYX+PdV?=
 =?us-ascii?Q?dWQ3tYWdJkZRW1Ukj3wGqRBpUS+Ri3HomKEb+cqxr22/hmWcCrtRexcs3Ka+?=
 =?us-ascii?Q?Tix1wA1tMIjw0kYYbXp8dfH3ZLCi1oAnd9DuTr6yr4UtJisKM4Vuv8iEEjf7?=
 =?us-ascii?Q?h3bFKgkHzRzYSyk4K/PFXrXy3Syz5lNHux19IEp3c9+VUVJLXIHveqr1pee+?=
 =?us-ascii?Q?jP3eMeuNmgrIn1cbBCoZez/1kzBnIwBc10nvdC64I39O2CVtS7RlZjN+yo4+?=
 =?us-ascii?Q?4/umx032y8W6tEJXFRT99TwxTwmGJMmTnqdtV/nMYD4+4r2eH/eRbQVC3xjJ?=
 =?us-ascii?Q?WRO2MYLeKm1v5yDHLxjPFP4rTrsK5tUE7CHGiFY/zGYEzxvt0HM6cM0aqpmK?=
 =?us-ascii?Q?APd8rSqGtKRBMOwiKQ0UoRJlIjlMC9ISkJujDSJJlqvqcGDYC0+ZoSKxqM/Q?=
 =?us-ascii?Q?B7+5BX2hb8Z12V+ipBL6dttosBEs0NK8cnU/4udPJ6nqIMzQGppDpCt9gsfl?=
 =?us-ascii?Q?6NID7DuGzAC0kiQ8PrHnU8GeuN5wTVyjgGLBkbDWc2QcSjNt1ra+gJPjmntO?=
 =?us-ascii?Q?XqTLup7QqRTfHCSfSfQ/zOOFgDW1qIG4tT0bYSsZQzgidK8/lxS8NI6xqqyn?=
 =?us-ascii?Q?9Spq6zXCnhHWQT1f5DQps5yidfhL8i+sIdxYST+dULvZ/FDUC047WiXe7yi8?=
 =?us-ascii?Q?/t46hzVUwTdIpBRhPjRuTD2f1SkSmKlN4BorX22mfK55G8ID2KyBQsvgELh5?=
 =?us-ascii?Q?CSYV71xshwqVp7TDCoEwYo+/e0PD48+4XIME3MCE9IirqyxdkbBbIo9QC19k?=
 =?us-ascii?Q?Deewwn0tFgr5pU/z6IP3PSBq2Z0Vt/V9UTkFRAhGVAEVUdlnfjKK7cnnT9a3?=
 =?us-ascii?Q?BGzv88I33IdVLOlZwncTDv07g4vdkDVgfHF4wtzioihQUbZHWGKg/9pLKBfC?=
 =?us-ascii?Q?YWS/FUtldE1cgJ4/gCQ3j73TG93jkU7M3yPXujqyt0VxPAAgten+tvpyeJKN?=
 =?us-ascii?Q?QMRIhQP9D4cdpJCvIGptDL0wiOowDy1qc/IcNpaNr71o88pAmarwM3dy+bMC?=
 =?us-ascii?Q?wbEeLLo4NNzcpGUKBJj61CzKN+jgF+kQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k5/OMcL6UVWtglTS7c9stgBUeeRTD6MHQhZB/Qk/51jPlvDNlzRMp49dlWhJ?=
 =?us-ascii?Q?KPbWkyT1ROWD2DZwAlE0EGcEJZF43d3QZuF3LE1UgRuNPtubEN2nxcQKHKtU?=
 =?us-ascii?Q?GXpJuxp8H5cqZaQ1oipFw6mx9Fodf7vYnIfTCN0h8ab7Ef3pLnerEESWatmm?=
 =?us-ascii?Q?S91UeGdV6Va+opzMds4tKq7QXtJr/iYJHkII3Ecf+hz2uKfRjDv8R8Lo9YEZ?=
 =?us-ascii?Q?yqKU7/3ECRpur3TyqSwKzaa217QR6WnpynYWbLbGilnqeVhxmj4iNmiYSk72?=
 =?us-ascii?Q?+qBlJFRzrRwkmQ0tGJJxgmB9qSqYpKYe/Ncx/Zlg95ZfE2Mj5JkuWXXEWtq4?=
 =?us-ascii?Q?ow9dpQMPhVlznaB/1dCfjFENgjupqrno7A1p4apYvWJ3EaB7dD/Kx/0BvPva?=
 =?us-ascii?Q?gIWCBtdLDNbbilllVFO8tdw6Rk3kwsO4UX4OXIvXpUVTNit/MmrLGPxNdGOT?=
 =?us-ascii?Q?rzUNLjqJ0stVmgtPDqvuT0V84DtwYegpTiECMi4txClXuf5mj1z4xody9o/V?=
 =?us-ascii?Q?sLvWd9jAVo/bfTXz0xNEXH4a6aedOvD/Km474IuWljy2GFfnKLG1NXRBagcj?=
 =?us-ascii?Q?eRdfnuZSruUztiEKrvG7HxO0ijn3MqiTthUu0fawJZNuwjbcKkX+GqWM0z5K?=
 =?us-ascii?Q?adQEmtJaZIjKcTs8dm/GHHKQN8dPz/7PbnUs2y9ro4rk8p2V8dSsH5UCXu18?=
 =?us-ascii?Q?KwuIuMmZ+xSb+lPiV33hw5ZESFcPk8XrTmAB71SZDIjEARt9M+iUD5wpPwqN?=
 =?us-ascii?Q?fWcfvAqQ9Pe1m6YZ4DI/sdY+Dcv+sd8Od5vShWExJLbR0/CmU1aTgxe7I6R/?=
 =?us-ascii?Q?HVnXERo+B9YC1HcYEffeeAnXX8WMqUizvlAWdUWVO6VwP7k9VIEb59p9NBZA?=
 =?us-ascii?Q?3JjF6kynupa5rvn9QOqjOAmXWpGppcT+vv6dq4WqhMHJ05gppzQfUSbTzM8m?=
 =?us-ascii?Q?i1qCmqpLTZN/KVynbnLz/kpJ1dCN99XAYf9HapfiG8GajQCRXtSgO9s8pUv/?=
 =?us-ascii?Q?mk1Z7WSOvwe1zacfQm56H9tEZyRKk3Pfk62Wa/IiooEavSn3reCFLSAVYBHJ?=
 =?us-ascii?Q?jdxoZbf1kEi38CsV58Sy0p19lMol/ucEVczQqYQzWLaXboB40RK/Ylj4gPsa?=
 =?us-ascii?Q?B1SK/zZU9tz6h3WpY4qxYAVX9/YmdBi8FhvHVEAPdnJ0gXIrwF9VK6nf9U4X?=
 =?us-ascii?Q?AyKYG3/Z+uM8g2rK44XtjqunCBE9ISw+wErLvkjBVaGt+8S4fclk3jk5nAS2?=
 =?us-ascii?Q?k6GnIFlTUb8pQ+3Phz5V/BbbG2DrDn75RDFM1LOZSsVbSTKKFVStaqzsk7/5?=
 =?us-ascii?Q?dA4Xi0wzP4rCQssa22YAZVc/hhlhAeA+ZVn6wIVajRlf8kphnWY6PUxagANh?=
 =?us-ascii?Q?wiwKycg2JxoS80ZMBVOMxYUNiwlbk50pGL+Kajrxl0IUWYUOThBpAml0Jadj?=
 =?us-ascii?Q?wRTV3c0nNCysyePMvBjNEDveV0CXpiui5feBgjdWSJkRLFhwJCY+RhenhOku?=
 =?us-ascii?Q?33KZPXOiNgyexpkE9dD+n7yGDyNoNaa8lrZEIB2HMsNI0AguhhJf8aiKUZ1B?=
 =?us-ascii?Q?Vt/zYGd60wHWWAbArQTU28VBr2otP0vg5qA9OyX+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8029b367-4680-43f7-0729-08dd5aefceb6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:40:17.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsrEinn3INbfoiLTNa4R0iy0vlIZ7lE5xEyLqk7sKb64RQEae4IAUZXa4nfvpI1le7TZ9KweTvcZT6Byb6avJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

Add new file ntmp.h. to ENETC driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7078199fcebf..e259b659eadb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9174,6 +9174,7 @@ F:	Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 F:	drivers/net/ethernet/freescale/enetc/
 F:	include/linux/fsl/enetc_mdio.h
 F:	include/linux/fsl/netc_global.h
+F:	include/linux/fsl/ntmp.h
 
 FREESCALE eTSEC ETHERNET DRIVER (GIANFAR)
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
-- 
2.34.1


