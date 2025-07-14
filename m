Return-Path: <netdev+bounces-206739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998FB043E8
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6F37B259C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CB926B773;
	Mon, 14 Jul 2025 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="W0uKs72P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228026B081;
	Mon, 14 Jul 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506750; cv=fail; b=TxrB9wgmFAZB8vqho/OCNEouqil1FPPtMUkPRBUDDjDzX/F2mhJfOTk6bc6/K2YwHX+pqcpYG9IXRTOvjF7V4n8+f0yp8jvGe4Nozvop7TLJq4tUJ01axA62/5afDO6ia72SqPy2WG1mJ1Nt3I51J0+5oM5K60uWQXh6RJEyVog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506750; c=relaxed/simple;
	bh=SlfoEhJ7t04OBqArSDJhNsyk2qTRZ2jk8F/am4KDWUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HG20hvk5TsvOo96qjSaKFqNQOyhKgcRc5r6JwwRHlhlpqHlLTEuKFhuP/kX9mEsc+XG8P4VAgq5Rbtu2gzgSwtU/0iRAUfJNMPunk0Pqjb/UwrGjLST3sdrp6iRm0KHuOk2FULhsb4Ahdi524Ro9Ub0xJKPlD1CT5NV/xdDB6yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=W0uKs72P; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBCYptXlmRP67GBHzHPlTBznilyea921k1N7eHIoUKdO21kwnWnyFak55w9cio09IB4dJtTV6J1A2ohXeh+BzwyaBdTHMW48Bz6P7cV8qete1/al3C7o2YYx14HYAHGNvJ42qD4bUugXzoEpCeki3uMar9iOwWAkk9TFZyCfRi9Wkp3nr+tt9C62qHBnCDMGuWC5DnJXDQi3cCUcY+p6e7ImsXYR9IGrtJcJFiM3LUuEJXf7Y+kE9RV+oE/7ZPML8/0ttvYG1QzRJJzORN2Y0x24LDmsIYjCIZitBwWZ0nlVhzugdDAYRk3vPHXqz1prKGiewptQ/BGlhQ/qH+i1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5FDiwLkHO1KKmVPajVq99W5Cf5RExaSRYOIPPszRok=;
 b=uuXOybTwU6oushov9nhbTyg+k9L7IDAR0fwV0tixAQWgbnk2DFa0VlFYrGkA6XQWXcoopu/XOPzc+Zmo6EyvSCMxtIdGbfZ0CDSACrEIAoTv+fFfEoc0rP8oqR+z8clcSKRKcfQCclb57XO2D6laQm3jejWI3CUBF6ZBtqBhcamhAsYpLrKJkRwUM1l1ezMma24gD0UYI4MbgjqlJRYSUd3agNpjpXIwoYwHb/cpBZb3NQCNXL0X5O3RbEn85oIgimroBSVthIsJx+TPiSbT75IgJqx6A9WouuyEkpwewNIVu5vZ1vNmOCtY8Z79PqhjmBHISnJADFfG0DQZy1xKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5FDiwLkHO1KKmVPajVq99W5Cf5RExaSRYOIPPszRok=;
 b=W0uKs72PpsRRvIaoAy017qHdC4zlHdW1bpkG+oTUo7cULGHUNkyBkfhfpays+PRimNWeYZsYE0oxcX/GVH2doIQqbWA0T8zRIwuIadAJvlsAWbIs4+/Scr0iYuM9YQDiU+perBGElV9oBog/M05qXY1Nqwmoy2Ydr3ULgFVIox110QsDOew/h9z5UeJWoI/o7JUviK/a8qLMGCRxzJwx87vdm2Z/FPMSnajGh2S9V7Of7J7NFjxCtjgx2pwQF4OGawVTDBRVOiePV21+mLlr9kx4GMmT6Nx9ToWjXIF1G3JbSVMQC3K11oISAOwEi+dNQq4dm+jY5TaI0NHKR1aQuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DS7PR03MB5592.namprd03.prod.outlook.com (2603:10b6:5:2c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:25:46 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 15:25:45 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dinguyen@kernel.org,
	maxime.chevallier@bootlin.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 1/4] dt-bindings: net: altr,socfpga-stmmac: Add compatible string for Agilex5
Date: Mon, 14 Jul 2025 08:25:25 -0700
Message-ID: <20250714152528.311398-2-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714152528.311398-1-matthew.gerlach@altera.com>
References: <20250714152528.311398-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::14) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DS7PR03MB5592:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d4b3e7-d11c-4501-4317-08ddc2eab3e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GnqGYGgjjmvo5kMOr+Ndn4lyiqSH5io3lpxSuxZ34p1OZRn7UdLhtFVmXvdW?=
 =?us-ascii?Q?Tcf7IMOf/Ox+PnkCsyumcgtZyLr3vu8QBIe7PotJ63y0Pza02W5RTR8SfS3B?=
 =?us-ascii?Q?iJtzlIaLxDCsELiGH9P5cLXamjuiNlp0hTgrTiqzACrIC7+TCQ6sh+t17VqA?=
 =?us-ascii?Q?E+VP58sRpNFvPJzSOpVTpQ0S+bUA7ltDFbMZgZakrVpfO+o4p8hAj6cycpHx?=
 =?us-ascii?Q?KFT0i6it75ldXAR45kxR1+XLXZ6mqu6aMUrkRHxbMFzfcFEZMcbPY2MopGdA?=
 =?us-ascii?Q?OwxIgotkso29Weh8C5RsbXwMazecbVa4BNHgPuNuXFdbF6nyDo5+emWOFCRh?=
 =?us-ascii?Q?+vTaqN+ZY7Fqn7wkU/fJ19QMTzwajq7YHtUWoqk+VtREIBv/H1uYte6HMRwN?=
 =?us-ascii?Q?zrFiEYTsh8/Z10indDwgseu2gOzKnfnedhUU5HQ92/Fl/Kb0x8wI4loVQhS+?=
 =?us-ascii?Q?XZYbq7JdXNBXaGzXSb9a23c9ywE54gJL+isNhsiUhczMnaklGybHwlU2LiGE?=
 =?us-ascii?Q?yjKbSyKv4b3+DVeN5wtjIeMMAwhybvMn1fxWGi6ViQUnVHsdbtWUvOngncqC?=
 =?us-ascii?Q?uh0nsPIyqpl7Rv1GGnRlHm863puIEIWrbdahgsS8yxAQAStN4nos32YYnRqV?=
 =?us-ascii?Q?clSLkqPdppUYmpIz8r8IpE6WjEV0vrirmzVro47Kax9ynvwgNY/Q4he3+9iJ?=
 =?us-ascii?Q?0E1fTcsxsiskqbrma4Zlqh/VGdOfgUefwt3vXxNom7VSx4O9K/51wiRW+hMp?=
 =?us-ascii?Q?LHllCKY11YbN8reNBgt3mT7hbPZLpH99FVUDBgagw2SpJp2Cf5WvqRGFAjAI?=
 =?us-ascii?Q?3znj9E2UOdqm+J8srxQvbeqyUGjJp+S0MAckfGGGP0rPrydQXsp+B8c/FLnA?=
 =?us-ascii?Q?DMpdTIrMjP13fUjL0xjsL5MaFTvUyXiQEcOrZfYk23qIOqLj+D11DxZudedv?=
 =?us-ascii?Q?Nsyij2JVR23KCc2E1L3r1XFU+FcqE26W/uQIrcsBT2lQfohtdQp0yCPIqhDO?=
 =?us-ascii?Q?Fru+NoLnbztOdsyjjioYaIvq/Y2w2o3WG2C73r2W+9C9tiODCbKkC1qjao2R?=
 =?us-ascii?Q?duPS1C/AiGPVe1LjJy4RQC9xcbJ8zpBd9Gpul5ifHGvgmomKnRdmrHN3mvbG?=
 =?us-ascii?Q?S4OAiFtUQjnlYTSxBR9pilhh3DxrItCJS/yaCblfYJ1w/I/rzUsmL/akn/kj?=
 =?us-ascii?Q?XFiuUubBsK5VZ8rZ9Ndr86aZ8+4rdA0b8B97hNsHIObklvIXZZeTHAju0vuW?=
 =?us-ascii?Q?snCf2VJ5+I8qEJR9cd/JZzaf4xeYB20g9rQPSomaGX3bcuJ2yyv/X0iuRZgZ?=
 =?us-ascii?Q?nADoI5PweE/vsgNAEwjjcnap5f7U2gvJVkvhOZznHFUDrP0ZS6NaBfULHFIw?=
 =?us-ascii?Q?BxNETF9lxeNQkMsyY/Ql0ViMDrtqGk115vzxqhJRMIQe7/2olzsnbFbO7wND?=
 =?us-ascii?Q?nyYTWCIDjvUzHzJay+1fM5MyEQeDQFJej2mQ82nCxbvENBr2QUNyBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k9pRU86U08fFn2H0xJCCDz0paVP/5Fi/ikOltvhLG9QHjKVZ80StY1kZrChp?=
 =?us-ascii?Q?KzazUY5X2AQDBt2ypiu2HeoL/iI0ouepfAb5zVPSOhUJmNa7qGypbbKp1TFW?=
 =?us-ascii?Q?l8+jBc0OF5CPTazg2UOv4BUpEIMQMTb9f/jDNGrnBLSLSbjEeYa+Hdnc2dJU?=
 =?us-ascii?Q?WTdqUszQFNk90p7ZmUadl8ISjscwICF5gspFn2y3omzAGrdsf4MBiU9D1MPE?=
 =?us-ascii?Q?sKfzWxzW9avS5VM+C5z6S1uSX6UMyiNC3yxZ57vpRRIyA1Pa9a00mIKgifXY?=
 =?us-ascii?Q?yt2rl1FlcElgmJ66ifhFO7V7QgM/IJTLwxWlg41mLZ6Egifr9qdaZ86w1eGR?=
 =?us-ascii?Q?FvZXLo1seiGcmikCTRAwaJ+TzeRzFrWje58+GdBobsftz+RaZs98jrRWLjOj?=
 =?us-ascii?Q?ZxfNB2iQV/uZY/N2tnexjNno53YQED+4OeJywGwSdI/H0JoOPXE8YEjTLTEi?=
 =?us-ascii?Q?yF2pSDBQBO6CzVWwYgHla6dVwsZbPa8kPwBnZ/aDzuq3bgVxpLU0ygugxzuP?=
 =?us-ascii?Q?n9lGzJ/QKJffRdYBTnvimH7xJ6Om55J7G+V8m7+7CewPxsbqBRVZlMgUuJtL?=
 =?us-ascii?Q?jFnIdaj9XLdCLjiVeVt0uidtHPrNAjnn1HiL4wdOSEBSirXFoRHA3NWNrRm1?=
 =?us-ascii?Q?HFz1R+0U6g8/zww0oaOUYBYNRkWYCvfsXycZ5OdvMI6+juEOFJGyYnHWr3aO?=
 =?us-ascii?Q?YuqpEXMyzdGuIHYveIVVSY8/8A5uWjs6Oczp9FDkiR8iYjcS2KmVOEkZg6nc?=
 =?us-ascii?Q?/F1BO+4vggjkgKmftfChgTPHktI9h5fHqjd41gBXFDak0w8cf8ZA2o6PweBZ?=
 =?us-ascii?Q?TgQf/4LcR4ZiLp4Cm/CX0TrgFpiBeCoW/jAdhUV9fn/Z8SPtvJ3P2E5M0QMi?=
 =?us-ascii?Q?VxzDLdysghTM/aRvhD6hv3KvXGgaFJhDrvFsqxOAGBjqlEZTHPws2s63abZx?=
 =?us-ascii?Q?1gMJ2iN6mofKxttsOWtPH3goTmw46INX9AfDvZAxQYg0Pbr+KhKn9R8F66nL?=
 =?us-ascii?Q?1WQa6zov8vuIPvbzbSnoTyv6qSha2oPlSftmKK1oyg37tKOfeS/h8wMrHdTk?=
 =?us-ascii?Q?B/YhVgM+YjcabxZrDMgOtYCsPyhweJ1T8BUaRMORJjOmmYAM5DuzTEwWI4ev?=
 =?us-ascii?Q?7ISefRI+EetklluWfdbKj7/9c9ngcW5oMy7NsrIlmSiDBmXjLbSZWSGyHII4?=
 =?us-ascii?Q?NVPMgT5hBHZVM6wNlNWd+rE5AFgJ939JVXRxtMeLDY+f1J7b3aLJpczCGd5a?=
 =?us-ascii?Q?bnoZc7bv/SboPVKEySgLhyssTgKGB6npZ/F+2ghuW/P7QsvU0+7pSHZyq2zU?=
 =?us-ascii?Q?/l7r5liCR+bwBJNQHN3qZwfPgu4pzKfNSVFvFKHZT1xQFBofxr5SmbgNY5CG?=
 =?us-ascii?Q?vWaG1lhHBmCQOQ2ytWHyeJ4VSSomu8cegd1kpKTdvI8w3uCCYZkM1GOVnuBp?=
 =?us-ascii?Q?auc53IWiI6a47gcvd3LdyjNa4pE8nOPjUgvwZy1nDOR9dw9u+38iCDooqcol?=
 =?us-ascii?Q?RPQsyarGsLQY4oyA/qrm7gQI9uE3NLkxDCfR01oht9URk8eRJp4Dd9b7mFDf?=
 =?us-ascii?Q?AqN8el0EiDx8gYWuEBmhtsrmhgsInDFj+KJQm1spTDyRlPjeHX82WUYfz115?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d4b3e7-d11c-4501-4317-08ddc2eab3e6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:25:45.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLEyIdYnoeZGo+DILH3w63r3A/HHZbJ2KK1+2SRh/Ur+8GcWG2QufWBVw77azFzYaokCikuNQzX4Zt2cDDqO0muu9xTtvoZuwQjrALe+whY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5592

Add compatible string for the Altera Agilex5 variant of the Synopsys DWC
XGMAC IP version 2.10.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml     | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index ec34daff2aa0..6d5c31c891de 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -11,8 +11,8 @@ maintainers:
 
 description:
   This binding describes the Altera SOCFPGA SoC implementation of the
-  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
-  of chips.
+  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, Agilex5 and Agilex7
+  families of chips.
   # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
   # does not validate against net/snps,dwmac.yaml.
 
@@ -23,6 +23,7 @@ select:
         enum:
           - altr,socfpga-stmmac
           - altr,socfpga-stmmac-a10-s10
+          - altr,socfpga-stmmac-agilex5
 
   required:
     - compatible
@@ -42,6 +43,10 @@ properties:
           - const: altr,socfpga-stmmac-a10-s10
           - const: snps,dwmac-3.74a
           - const: snps,dwmac
+      - items:
+          - const: altr,socfpga-stmmac-agilex5
+          - const: snps,dwxgmac-2.10
+          - const: snps,dwxgmac
 
   clocks:
     minItems: 1
-- 
2.49.0


