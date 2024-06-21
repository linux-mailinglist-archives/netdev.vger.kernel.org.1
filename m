Return-Path: <netdev+bounces-105775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4120912C0E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 19:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469301F21D47
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03FD16A959;
	Fri, 21 Jun 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NXJiy4cA"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1441D16728E;
	Fri, 21 Jun 2024 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989218; cv=fail; b=ar63AUOIe5EwQMTDcjZ5pURNdalTweHGbZ0yW3Labxz1hmm9QjubR12dQde8EWAblfrOq2wpWPueEQPVJuUKNrYXCUV91HWA4W+3/54ZLKYTndXhusdsDAk/mPiGt6AKN1MDn5ykluuX3mauNTlp0G4XVy7o0KqxtL/MSkki5mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989218; c=relaxed/simple;
	bh=4oEJ6r4170VGZ311I7STtncPj4JRKLaCpJpC9zyU7JY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VHKQ71f2tyD41dmV/ea4PG7+Kgp1pSpvxhH07ldNRlm333JC1u42HfLC7TUmrTztjmLUlqco7OoU8W4S77H02eLTVMyW/V7gGK80XN2C6xR22D70OINNSoawHc30ilMzyQbSyov4gNcgBKeJuW2n8gfbDJNQ5KB3Qz3bO9KjqP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NXJiy4cA; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6EkqR2n7X9URWqh3k78spuPSAicN3xNtT74gDPJ54om6BoO2V19Hn4OdZyJ5duR4IbHu0aqu6i/1/9Dz725576Pss5hjVkcv3XHuQp5XxwqzUuoc6PG8B5ZAK5kFxRDeqVbbtUFOkleMQO45Gdy3U6EY3cH6pQa4HM9lWIMW2w0W+zWt4aKNsqXW5z1BcxwOjGBaIptapRvrj94EAZHOI3PGRdGgD5kS3Qqt+f5seIcrjePYQlbAFUp+nV+pNgXQNh2B5mNo/F4CJ04nW29bUfJW6GCjy8ClONzVevWt0RaW6oHavZ/8rJiL0s+6BqmMXWtBko1VkFbXUNSw3Yfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GscmWzlfmPKFmVgzNHRyYP1VXn5H0FHzNccifnu3E7Q=;
 b=lXSgSfswhr+opSVhAlbjHRUP+rruRot3pQntJr+rtT4CcoKONAWS5Lf53Z/xGH6DBqKgE2kh2Wcf4phkwSf/f4Ei4a9V2h0lmEbQ4HluYH3y3n14dsguzVc+9elWOGxroWZc1arJokXXLADD6XNXZ0cYa08GluuOUqrMyjbxSqqSYSLj3U42EvH6PxbRliFAKOI4sDm+Q8MhU0q9kSI+6BQQ7Z/EzGtDN+1it0OQipenPyrM7w3jAAVI+hX2FdKmT9Bp0AqjM+CEtlTEpkWebsMbxFguLo327srh/PSn0G7SgCKerbH51KFkU1xZWkAe2HwouhmGuHnB0otUmwl7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GscmWzlfmPKFmVgzNHRyYP1VXn5H0FHzNccifnu3E7Q=;
 b=NXJiy4cAvjm2QYx38uI1V39V0Me98+kCL3oN1rTUpf+1B+ESnsbAeU0HXGN4nLFHpV9w43oRb71gEXP/b4APdYC/dgLMjfK587Fy8Bbbivx6tclt+LepOAAxbApgV3rhwwlaZTuHze89mWUFZAHLQpmsn3g3vW49K4o8HusmXVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7847.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 17:00:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 17:00:14 +0000
From: Frank Li <Frank.Li@nxp.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: net: fman: remove ptp-timer from required list
Date: Fri, 21 Jun 2024 13:00:00 -0400
Message-Id: <20240621170000.2289596-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 8404b5e1-cb61-4d5b-02dd-08dc92139e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gkPBQHyaLOd8PMXP/qtB0Mox9/8mfqp9rca3IWMFrYIDzIZq1vxQhJFpZBkW?=
 =?us-ascii?Q?9saN2UjHDogC0lwMptlbjKDNqU7sfSnYuNT0u6ClUgXinpeB6QkaAZdieGnN?=
 =?us-ascii?Q?SIT/Wc4s2PL2zIigV7Pe1TJ0mfP3veJ3Zsl257LAys4iSQuXkzAVPUl/NNXg?=
 =?us-ascii?Q?iWzCMbdjGEQahEOt9i7hn2O+H0yUR63o54+AdD4gZfThOaE5918wVgbjU2dp?=
 =?us-ascii?Q?lZWIY+0AHCk8Hhyhx6TAZrcOaMgDkDiw2vUjXlGYgC1K1mr1M21iit1z+C/P?=
 =?us-ascii?Q?1MuTFHh6d2/rV3UEL+7hWxY50w68812LhSHO2MRrwUK9J/g4291srJa4d6Yq?=
 =?us-ascii?Q?+EqUcFQa7KqdnLA91fIbyK1oqw6+GVN8nmiPdsEf5KFtmhMQ88yjXkAMCmWt?=
 =?us-ascii?Q?BqdmuCovQNSPKQHZzjefj7yrFGTnPurRtTGa/Rtf2Abh/PazqDqTFyzEJ+9/?=
 =?us-ascii?Q?WdCyD334jz3IC5Nyz5PJApOP00O7OjPy61Yqy42dCEo8kzyCRR1gv57VeNFn?=
 =?us-ascii?Q?72yen8YQf1HWFEPLhtUeE/BhFogJcCkNzel2XAdhYhSDm1Vqj1OmE2plUzLd?=
 =?us-ascii?Q?9UUA+abLHRNGGKDnR2nyN0DJxZAE7dL4xZj8xKIi2wJ10rZgAS+ivGWw0ygh?=
 =?us-ascii?Q?XNOQ+hcQBuP80tZihp1P3rpqvTlIc8u5oE9hmTrlAfyJT+G+k7hSHEs4kiJF?=
 =?us-ascii?Q?aQr2kan6aWY94PL+uBZ3OSK4aRTNO6b+Kg4Syf9JwBOqVu86kymKog09LbGk?=
 =?us-ascii?Q?Sg1ZHIja+ykJp+4ticKC3JtrmFB7FQ1E28IgCtGr/PF4gsiAi0xViOIBXUWT?=
 =?us-ascii?Q?ydY37abhIlCFtomsH90ilrkPcnpRRuOHCUka2n2cw6zHOYOv01Misq4nnU4f?=
 =?us-ascii?Q?FrwwS83l7NHQHMqdVc8UNj5fR+ACVg3tv02tbRvkFkaoWLw+kQ5aYcbPSquy?=
 =?us-ascii?Q?tcsc4b1hoDz3bw4DAQJ1LmoU5dATSHfFc4OethstaoNy+eHyu/A9Px4+96HN?=
 =?us-ascii?Q?0fx8e3IycM3+0l0Ap5VTEYCAOodWvKgmLpq+NfNNcjtcSRjuKSDnL9JZGeDW?=
 =?us-ascii?Q?A61vaBQUfRQVP2pPqTT9/b3Yi4AfigpYriaRvQ9Q97DDCCaLK9ci9oILwqlG?=
 =?us-ascii?Q?DKnkAaLEEbzQo2XU9QWURKA+6xNm1G+Qyuy90hF7kp5zc8G4dqMIDwXTgJ6b?=
 =?us-ascii?Q?SJZrnjZdaCLLf+eNJqfNlhL6FeturU4SnhRnWLFndp61jX1uvd62qkYgqwZt?=
 =?us-ascii?Q?nvL5/Wb2BuvtrtyjNx7blCJ2nwnSi65O0fPcf/a6n7e9w02PO2OIYTxiJvo2?=
 =?us-ascii?Q?6trauqj8Bwo/AfnON3kLsVcaZu5QLumpCUZgIzR8bYtkRI71ZRXgGiwDKJxX?=
 =?us-ascii?Q?tMmSbriygoTtd89Tsgm1VRhV+uep?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GtsYa/hjqTnTF/4/m1OluFHzZ7jL3YWlQkPu80uYOXMNnWR71HShmPn4yhHn?=
 =?us-ascii?Q?WiDbAdtpyL7KS79twvR24k9X2+xW/wMCTlTH4caPiJV+owGZ55h2IlOeki/W?=
 =?us-ascii?Q?w/wXAdqIDoc7Rel7/GLdbHEUHkbCrT5hS7/PaBE7GMxSMcMls++ueS851aNU?=
 =?us-ascii?Q?Jk6gy3Z7WNzOA+DwSRE2VcVotkm6/qbqXjKT8DXBgzcuUD89PUFZOZRyI0cx?=
 =?us-ascii?Q?vmJ6xZwvxcf4IFAPrUxRoum7Ilvzfm3vq0VnHH8yxMfgjEGDWLdX2QBlOz+R?=
 =?us-ascii?Q?WatTilFuWLHl7UuX5W+JUkenv9SHsEL/Q3NLZeaQSWjyuNhvSo+1lOPP2EFW?=
 =?us-ascii?Q?PLf86Poisa+QXKk2KzvdEPGzBpUQk9NcxIuhXiaU+V3Qfb6gacKavRFgfG3V?=
 =?us-ascii?Q?YcxRS3m0I/LNYZEACaOy/YVE99s8UXDjftEHKsjDfbzvVPmJaFeuH7acIWDi?=
 =?us-ascii?Q?kqMvKbhBmTeXdNjZC3Td3Np7pp582eZu9lDETv2vVUnAhv1Kvq+4wZgcDKUk?=
 =?us-ascii?Q?cnqo0cqL9n/uue9BBHcokSlWkGjUt6ZS+kauxqA/SZ+eo6eVuatbxYFBX+Ip?=
 =?us-ascii?Q?8jOYlAM5DzvozKgvQeVUWpEyj+dxJZCSTYZh6XBGfMEB6ZpldrcyedovVbAz?=
 =?us-ascii?Q?6YeaVxAkj9tLxRpUwZk/xRvMDGGDbegz+ht0zAIupCrtX3wzqeAmi5rk+6g+?=
 =?us-ascii?Q?vO/W36Rx5rsQpbSnSoTogyAd8mff/L71EUmKP+9h3JFb4ezGYclCHUQ63g0P?=
 =?us-ascii?Q?vnZg1QCK1i7o7Ut3cqu7cjHRqzkEzPDUeevZ9C8j3cUV9fPfbtEQfvEdkHzN?=
 =?us-ascii?Q?3GlLFvfzG+3Srr7lPDBn1jXVAk4S7YGB6Gj8rI7bfFG+nDPdmBvcyDSbNezg?=
 =?us-ascii?Q?kVExexFr/lPBYD8uoX/zbTQqvNG0E38Go3vgJ2BI2xKxPr9B7/cIxP1sW/3q?=
 =?us-ascii?Q?m0+yi78/I9o8C4DN+cJQ9U4a6BxN+TKqBw1OLK4CaHXXvnX81t3SAd/zMabV?=
 =?us-ascii?Q?Wdx7HGZGH13tLJAvTZGsnlMzal/vOLLlT0ovRcrtvUmA2EdT24P+dh46DKPo?=
 =?us-ascii?Q?JIdnULOncvVPMwNB94Q5SXp5AduM+sq76RVMFujTf5rb3duUTxM8LC2W6yaw?=
 =?us-ascii?Q?B56wWifV2N1DIHYrUoyQLw3oUWXpgb+CAbIaUZjAddy4jGA3lnR9cln8/MYL?=
 =?us-ascii?Q?mSviuJV2UQ3d7/QidGfO+wtr4Yfh43VC2W4bH+Jq165+i2JpjQkm3z74Gix7?=
 =?us-ascii?Q?2W1H5gE01rGPtQX9cm1P5KIFGADXykBZJt8cRiXQOH9TKHEG/em8NpRayR0A?=
 =?us-ascii?Q?fhD7JLkx6HwI0bYG02X/K46clpWC0w52Xmk7fWOp/yBtjAYL7Jz2ym0JBgXu?=
 =?us-ascii?Q?oG1/q47QrCknNT8j6lXyK98a/kZXa7hL08Bq2IqSizhsK7pdzmGZSak20iak?=
 =?us-ascii?Q?5EG4SQNE1BuhgvnIJHXHe1DuHLBLWEiTpEfgc/C18/L0vK+/88LEQOWn3opS?=
 =?us-ascii?Q?9eVzTDcFYnlKSPe++x8GtYyC3w1dw0I/K4BOoiCm/fQf+Ufeb04oudBONdSK?=
 =?us-ascii?Q?vdJ/trR9N6FIU+x32CkR20V7jOnRLSt1/JaW2sXf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8404b5e1-cb61-4d5b-02dd-08dc92139e8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 17:00:14.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgwzuDzlfNjbeLzLEJPYyDkYk1shoFVhqOG78iQd/BKJoM+armlLfI2Tg5xAfXcChXJc5XHGpFkSWOM9E/qsMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7847

IEEE1588(ptp) is optional feature for network. Remove it from required
list to fix below CHECK_DTBS warning.
arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: ethernet@f0000: 'ptp-timer' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
index c80c880a9dab4..60aaf30d68edf 100644
--- a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
@@ -128,7 +128,6 @@ required:
   - cell-index
   - reg
   - fsl,fman-ports
-  - ptp-timer
 
 dependencies:
   pcs-handle-names:
-- 
2.34.1


