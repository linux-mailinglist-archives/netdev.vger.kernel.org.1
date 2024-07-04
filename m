Return-Path: <netdev+bounces-109286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D9D927B06
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 18:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C207B24AD7
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7708D1B29C5;
	Thu,  4 Jul 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dsKP2OzQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEC1B29B4;
	Thu,  4 Jul 2024 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720109877; cv=fail; b=smVMs6lFGMMO7COyDe2V9VZP4TuA8xiA/tWmEup2gfYSW7BWKlXOUYOgLSdQF8n8OW7RpHhHf9eXcSg/AEkDDNsWaWzA0JhVy5h99+LMLCvWSMtmJIQGFUSV7CgFbuFgxy5uFUxtBnF3W/MgFTsVfMAovlrczZxiuJm0n1479eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720109877; c=relaxed/simple;
	bh=yFP0aoioOHOEe81chi1I8HC8Ag5Zqm6gaT/fxQ9JvYU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N8lU+HqBVsFbkzfyEBlnZTeekDiZ4XvPwb/8hCsgul5HloTQwcIueoPwVWUYKq8PmfKu7UwZ43UQrokGWggskFwW0befSy/7yk9FfgEEDJf/xeomw0eohLx1YO52BTHXLVr2VtlB4sxrgIuSZbXC/4db5A/dKQY5/yEC25sWlOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dsKP2OzQ; arc=fail smtp.client-ip=40.107.104.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnvZbDjg0ZMFi/oWeqJa+WibZd3xWmQNgvTjTyYqBfN9BzhzJGmIBTrrE+UXJ6J9wXOdZjRuKe9vrT8jZKGheFOo+hlIYHzT0+D26n4Xy33GGEe/Xl5wxY08A8ZLfdMhwDfZkvLfkA1ziyyGK5onsBSpvujnoFtDgfx4Jou8DITj15T+mND7+oQb4n4cLlojfPYENiimjckwCEV0mgJftB7xUqFyqVCvN8y+BrkBdJLzNrNysEVaEsvRxDsntRQFIQab66a9WbdIM/BtXMPKfm984Zy2/eqE3gDOklnibY0zCNdG/CZlzFsCPtU579A32bjywkD6u9SjPWXZptZcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnuNTh+mH+DQ09RuRYp154mCzb3VrSVqeIUP5VxzeI4=;
 b=Wd/qr+/RH6hPlCZ0UJe67VY9q2Lxy0rMUS46ig7o+gVCTnmmYwN2W3fL6bATbGRugDuG5wK07bVOT9mR4B/w8DLJvaK2KWw0TN4qpbNmJdJC1/UU8ES+d8Wcg+HQh+bBgv4m8lr+VupOn4HIJQ1Bp3ns3LC4VjYE8rN5LuSQBmNTEAH6MrOGq0UT080ip81NAMlQ7ViRC5xZnlUJ/4FJJQNfB5ZPiSiefsVUTsCfBvoqGqyxlermKixYs8UGOOVTTsaGyvJp/CXvFiDUwh4GOg65CsmySCG+fmCj8eoM63s9xGbQ+9rhvplI35Lt0+S9gcWCIV6XsBv1IA47eOWjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnuNTh+mH+DQ09RuRYp154mCzb3VrSVqeIUP5VxzeI4=;
 b=dsKP2OzQkmH+cB61AxhGN70qmJF/HoOE/NNhfoblS9O3g44zY9OPbFvZYOVPDc58pjgmfHwv+AjWXtT5NyTGzVKIUmy7MOiKE3TN8kqDGfb3RYekUqdTEO4+KZXyUrov00nqeukzfujykLKQaEE2jsFTtFfICONe+e6jKNFl4vU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7992.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Thu, 4 Jul
 2024 16:17:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 16:17:49 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org (open list:FREESCALE QORIQ DPAA FMAN DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/2] dt-bindings: net: fsl,fman: allow dma-coherence property
Date: Thu,  4 Jul 2024 12:17:30 -0400
Message-Id: <20240704161731.572537-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 69551b5b-e75f-4c06-a655-08dc9c44d8ef
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?9QHxCha9/LvYdiowCxFXJDXI0G6ImnHpV+N4CEak16kolr7BBTqzxciY0Ysw?=
 =?us-ascii?Q?kALAvCqdv/My9Y8heGBViXevVcQ6oT5uYBfHB/sJoiMtTgEiI+4SUySftFt1?=
 =?us-ascii?Q?Ub2bMP4zK+vNlicnASu/BdvToGyWcpMducGjsp7+Ge+V6v6PFCngH5EImyQF?=
 =?us-ascii?Q?1pjBKQfC8l2m7KfZLiufVcsqWwuUkWgxDsRCDzOYshMI7tTYsKDUoBLKt/+A?=
 =?us-ascii?Q?90+OQMZ3LG9UBQaaVeZrGVpd40/P4OKj1aVJn3YFMDyUzfzyVKqyj74BfTYj?=
 =?us-ascii?Q?fr4LeUDhPe2/JGIn6YTIpwdRUcAsGvZg01sqEBoHQ84WynFhJXw9fBzzl1j4?=
 =?us-ascii?Q?JD94OFZuVtgJ0A2GzOAMlf22nv8H7Q4s2qVOuXi5VyxyG0PnBAMd/o1z8Yt6?=
 =?us-ascii?Q?lnD5pV/+BeA4ED2QsgJiso0uoCiWMa3A7XgeMfWUWvdi9A3q14t1GmCNEsEU?=
 =?us-ascii?Q?9yaMlN709OJGANvD13ZnQLTaXlg5ZQ/V1PlN38NMNRehIMrLqBdDzkGEp5px?=
 =?us-ascii?Q?pqBAhZntW345eIgqJ+Mdh5WgH0ZEFmM+x+WsAWslwEmdPkB03LkMr1o8brlw?=
 =?us-ascii?Q?yP9lmw/dydRoGmrjvHT3omVOoly6dhJu3Hb4NgK159X4wVbdZxVOs8NaMJnk?=
 =?us-ascii?Q?RKuiSuTpkQizG4RPNDHb6CIV60MK9fZjrmmj5h+UJY+UAfk2X/ENLcF5Jqgv?=
 =?us-ascii?Q?iF1c4p21BxHWJHfTnLSvn9oxITijWAw5GArhw5TY40dEWxANnE2lZMiFPBLU?=
 =?us-ascii?Q?zbvjzsTyVmP9rgSdivTrUL/uN400eVyuuGSgBK9QTfJFq+fuA0gmTZgiImmj?=
 =?us-ascii?Q?AM2CnKsR+/Mljc9yweJmW4MEATvrH3TaKItHg0EwDavLaChcf3Aa3jUt8bck?=
 =?us-ascii?Q?3OGRpRH4HPKX6tu9IFbg5V405RZfzoOkAOuOAAkctJyb4V/hCM5KBJZ5yyBj?=
 =?us-ascii?Q?XuzYA6g0cbPbAqGhLizEMEm7+v/7HE+nhCTDmuC5iJaBcdjPwBaX2cLhBN0l?=
 =?us-ascii?Q?3EwtRr//XvUqbGObz9e4058Y0w7lyWeHsM3RE1cPDICAbkj8RaBUhWPnsE8n?=
 =?us-ascii?Q?eKWrh62twkhB6qL3vNgXprF2/dk/sryuhrNkjQ4dc2ypNxeMWnsBF4+0XMCK?=
 =?us-ascii?Q?WP0zwTyL6SvZA9gpTO5goyWvlV1OVxkCmdkrLPLVLV3/OTe15GlqdNENzdN2?=
 =?us-ascii?Q?DbzVAhg9gz7m3QoenwMHsppKqAs4lA4cHxcvzQqqF6Go9x7PZrg3VzrMSqGm?=
 =?us-ascii?Q?PzP03k6zfUySSaPf9GWFG79VpgrkNIZuF32b3oPQIHjmyb0blC9nsP/JzEJt?=
 =?us-ascii?Q?ou8abvqywtoAfnus+jhxB6fl6oZ9x300Wuocsvdp+wUxfRGqbekY+Lg5Hf0x?=
 =?us-ascii?Q?NYKq5RAs/cVOEOPHNgee+vt1Jywh?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?u9/T3XD4t8sxL1URGPF/RX1grEvAXtar6liKWnEUEbKzaNZ7exeISBNkVx91?=
 =?us-ascii?Q?R9uIiKuA20UQ38NPN1jfi4KgHez+5yacGV7kYkoaQJSZMYFXVcEFCQgSVK+0?=
 =?us-ascii?Q?GErXJTZERFvkUN4dRaLKaFIq0ELHm03CyrL/Cr/n6ZUtOMSEGlY9eRxXD7Ak?=
 =?us-ascii?Q?VR83jVQ3T8ef1cB2wxk8E1VcY+U29jywnyizuxXKU3YJ56wR3YovYKKAk805?=
 =?us-ascii?Q?PZpu+C/iajCQSkkE+GGYSrSeYc4qHmkTdmfLRKsv/1Rn94+uojV5yPdYLkVs?=
 =?us-ascii?Q?gzXJlG6Ci3mRl5Ggoz3aTfHfGPCoyy3ZWRQhnToaAFzM8hF/KE7vobOnMSJt?=
 =?us-ascii?Q?wz+Ab8aBbgeaKmC93i+4CF2yX2/cJOSm6W7g7pjoHt4jn+zzWFWkBVY6jOtn?=
 =?us-ascii?Q?CLFanoelsVThIcaRHqCXDItG4uWTel0tmUPMtIoRS4vLY7r9K1IS6gPvsF9m?=
 =?us-ascii?Q?ZQtwKBbXA4yhZHPudbnHW03+IwNoKqfZtCl34EL04Me0yP4ievcelJoOpWtO?=
 =?us-ascii?Q?eEaIjrolGUxRn8ea4vTWAuW6kfytIX+mNkFqgxV1a9Z7onS/XfaHFjRA0tZM?=
 =?us-ascii?Q?uVEWfsQtzXxxzhiMeDE+WDFJySp9JqjkbZ7WUzcgTVl5cl7C2knv4onba1Lc?=
 =?us-ascii?Q?C1byEgBoK3nKER4pttCLTVhQbSOo4imyWsUxIvCSCJQ7FNXrqmyh621aDldK?=
 =?us-ascii?Q?gByRiTWYWrYQQ5BlZKh83Zk7ee9X1++pTZPaXGuHuWdw78rw2Ep1O71mtj/D?=
 =?us-ascii?Q?3egE4oju1DdSViGgc4LhS+IP0040/vW4as7/9kn8pD2IwSfIzj5hOU7/VHHz?=
 =?us-ascii?Q?zFVKL9xV184r9kBzTeK716E07ULde1zXXNCYS1iN3DEal4V751TpmQlc1GgX?=
 =?us-ascii?Q?0oyrUFV75b569RY0VMgmpHVAPyQRWUnk5rlwyAEwyxOcvrVNsDmDADEkfK23?=
 =?us-ascii?Q?n50VkvTEfzUv2pl20r5BpZih+BbRbWO6GTvNQYWSB9Qi+sc5bRPBwZKfk4lq?=
 =?us-ascii?Q?FJzLFATUw9cf0YUsH1w6vfcafjP9I7FFX4gXqDdAP9pF4Cfxk+M8NhfRVkg2?=
 =?us-ascii?Q?gfxaE4qTrgwUPson0LRl8e13gVPsdytapYm+zRl/kEEFhcOPOQTLvqUFB4Ci?=
 =?us-ascii?Q?9b/VfH08zh63IrznOofZ1mKWionhCeDV8YUdoc2BceD0L+18LnLv0wYc7mtO?=
 =?us-ascii?Q?Z9XR+2uiZqubXr2HsY3vDrZudZM6EtkfV8tX7fto+FEidbdz/MSkO9CtoM1l?=
 =?us-ascii?Q?hftgVDedp6QpmHany/Wi5G0cobkW2WuCfcCwAw6vpX0yBWnEB6/W2J9GetqA?=
 =?us-ascii?Q?Eas+bw38U8MjFEHMoInScHInle6BwfrdD0cPykebq2jDkPQmUSEB8LikWSaq?=
 =?us-ascii?Q?dIEirhjzh5W+w4QjSQ9M+BOe6ex9ZVwPtJSeP6t/DlpUtjesXiBW8unBs+ly?=
 =?us-ascii?Q?RukH12k6O86eFnZgtNzNl7acWFyc18qxxEF8npShLn490kF4qvfq+p6x/WTQ?=
 =?us-ascii?Q?cUybGJhqmZ01w90pwvp/fWi08mH34WqHkB9ysItSZNUcD/H3Mm884RwbdEZ7?=
 =?us-ascii?Q?JyzZzLm3e/jhf0BohctW3Se2y2yzYQPsqBSMbM6h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69551b5b-e75f-4c06-a655-08dc9c44d8ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 16:17:49.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/+nsJCx/OTKQrNMl4GVXWaqVh21gJIAhtKvwD3FdLMYoybyhtFIIaX6GIChC0/ciB6vfGd6ec7yOJXnfv5chg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7992

Add dma-coherent property to fix below warning.
arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: fman@1a00000: 'dma-coherent', 'ptimer-handle' do not match any of the regexes: '^ethernet@[a-f0-9]+$', '^mdio@[a-f0-9]+$', '^muram@[a-f0-9]+$', '^phc@[a-f0-9]+$', '^port@[a-f0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/fsl,fman.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- Fix missed one rob's comments about 'dma-coherent property' in commit
message.
Change from v1 to v2
- Fix paste wrong warning mesg.
---
 Documentation/devicetree/bindings/net/fsl,fman.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fman.yaml b/Documentation/devicetree/bindings/net/fsl,fman.yaml
index 7908f67413dea..f0261861f3cb2 100644
--- a/Documentation/devicetree/bindings/net/fsl,fman.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fman.yaml
@@ -78,6 +78,8 @@ properties:
       - description: The first element is associated with the event interrupts.
       - description: the second element is associated with the error interrupts.
 
+  dma-coherent: true
+
   fsl,qman-channel-range:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
-- 
2.34.1


