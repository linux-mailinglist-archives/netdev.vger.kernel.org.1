Return-Path: <netdev+bounces-239927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 119A3C6E15B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07BFC4E98E0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0A4346A1C;
	Wed, 19 Nov 2025 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VTcLn7Ak"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4A346780;
	Wed, 19 Nov 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549338; cv=fail; b=T6wao8EP9NrCvY4Qgn2sHdfeoqHeEbYWJkWWrcWdvBYC4bpbqLH+B/Y3RHGENabyhPTUv5/eiOgnCvqr317UqvYw6HdCkwykFWpSfXP63NjnXNbPiTJOQ3rno0Wb3DdDbkEQFxBgHaO+SRxkwqZaFeqYjKieg/vRCsHzdRID1ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549338; c=relaxed/simple;
	bh=JXc/zB2ABsdoG+Pygyh0z7FPWlluJAhv1obi6AVmVEg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Glbca+SoS0T1dk8/sPNaNLqcZGWI5M9qVKwNo+FzKh7rsNE2ArIjZ0xiHcp19TlVylU6khYD1CC9gFwTI3BdOEt0/3wMg2qWz4OtK1J3huzoHxjmcrbwCPOMH0GlyzMRv3O3302Ht9C6Ps43e4/IlizzWuQMNUA4vk8sDzZAeMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VTcLn7Ak; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCSaP2zsbYcyNj2CsZo2+JOSU8fBctm+KC4xx4NlsgUzPq7WZNQMMmljOfNdG+lZm6CdM1TC4VWlrHBaYV/yM8u/QOjFMoqx0vPrBH1+nSczJ9xE/bpoFDEZkBYUQ709pzsqirV1GyIv7j+c6y7bTJrYFGsvkLdVsetVOhA0N2WN0GeTkss5I5bK5waQgBD3eZXmeaddCvZu0vOEsPdn2x6drBjvlqh4FXREgoJ3soMvd9sxrH6QaZ5QsdXnZzDI9fyvla9rGI12om/FYJKS7fLDLf43EFiufTUy6x8YWi/nVL2RU37BkGeK577aqsMzi7XTXZO/r2LqX3zSxP5dBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmHIS4UAyE+/iEPlqA0tdbJkF3e/6z1VrrqfvNKNXUM=;
 b=xdeNpTTs5gL0DHJRYEx43zcygAZBIjt0EGURLnXIqYfPp2H4wRrRD5RMjgi4+hveXe5Vyp2ALJbnNfZxIaX+Mo6wFnqZ9ENVwOFdx/up4PqbpIu7b9/l1VbSi8Ot3sbym0gT03OzLg6fDEO9nE68aX95jLTc3iRGcyG/e+Uon09wZ54c0goYknz2QeDPJdRr8MU/cGlCF6rZMlJ534+7MKB+tKHRwBj4Zn7L+dN/pvoi2NgzEpoecMzwtENWUU8jFjoPmJgv0jryso7KUTXkRTaN4cdCluuDAkfj4K7sMO9Js5ZmWe9Fqp3Nix3vgicD4Neg5oNL/e2ZVBQkq+r2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmHIS4UAyE+/iEPlqA0tdbJkF3e/6z1VrrqfvNKNXUM=;
 b=VTcLn7AkqXQ2h7T99b1u6y0BFMe8HDMkc59KdGc/nTlYebrREAA655Rf4mZn+77Wmh+MqsQLe1RCMH7a2ZRHy6RYAFnzyxEjIKKb1DuuQogWNA4HkxI3PIS4c15upTDNXKtSEr0LfckICmV5T+cb+JDkTzCA/oSZSP/fRsbaFir6DkZNx0dahTlwVbGsgr7Mb0EWDHZNOILOSPWTjRwOPDvXASvFHo7/ZGoqQpDKtXbm3TCLqZo3Za00/xD9n33Vn0hTGYaCYjgOF5nxn3g+7GXAIZY3NF0ahjPnpfX4iEc1jf5rjbjcOxWYic6UcmW5e7Sa5xcWP4zZgG+wjcC0vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:48:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:48:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: aziz.sellami@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 0/3] net: enetc: add port MDIO support for both i.MX94 and i.MX95
Date: Wed, 19 Nov 2025 18:25:54 +0800
Message-Id: <20251119102557.1041881-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff85be4-d2fb-4a4e-dc60-08de275938e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jm+9G5IltVfZsWIOVf3fdeGdYiLSgfMN9LtZmwgdfCUGSLERpqxXVK1mJX9k?=
 =?us-ascii?Q?wLxjEmy4lodfT1QphDIX4XQutgNh7jTzWceq37zq9jSa8xhEtVdlgSBnxWd8?=
 =?us-ascii?Q?ti+ektDc65LEMcu70GL5VgqDLi//5/fnZ/FWmFTk6GulMgbUoBc/VAKDNEOT?=
 =?us-ascii?Q?MBc40jpixsCa7hg3ApZ6U1QtkDr4DLIESo0sVaisgUuUCkh61KwhanrDsm1f?=
 =?us-ascii?Q?Pz8h4ngvg1Fvnv9fu0jkwgIULdCO0oiDSk2/fAHbFYg1bx7rv/DCmswU24t3?=
 =?us-ascii?Q?D8bIKCCMadp8RNz7EQUP4w8GCptJRj7GtxROUY9npvJ9679gpMOG1liZk8Cn?=
 =?us-ascii?Q?8TlfOSrOGvl2I3Nrroz7yiBxmxb9/oi24FBEc3zGaFvWYMa81f8GQ70uuu8Z?=
 =?us-ascii?Q?iy4jP/ksuNxJKC8KPFFoQcI+bvt/CZ+AJbb+KAFIzBlnJZuZxQ4R11tkVrWc?=
 =?us-ascii?Q?wR7VM3uryKdyAhnRHujCUazT8EzXn3Udp0h+AAgMzcim84olgyCzvZcsI8/F?=
 =?us-ascii?Q?Xl2ZRqOYXP+vuc/NNLz6KcqU1XYjS5/oXMtuYb5qKgk8S3JCGnuJLRRZcIE0?=
 =?us-ascii?Q?+rYnNHtEPwDR9yljkzYM+7V6y674gaOzHsZMegrbJ5SL8vyrWw/JJIVLL0bQ?=
 =?us-ascii?Q?Zgb2cJLiti5NdvUFv7il5TWE+nbg+4sPPTLkIc2hyU6WaUEOsSUjpww8Ck00?=
 =?us-ascii?Q?10peje74l7RBSy75E8h3P7jHx7eJIbsXAO/AxJbvKh3jM4IfymRi6jomcmnD?=
 =?us-ascii?Q?lMEK16i9qNPKJhu/+HOU727lXmWee9mtdlcxr/OsPKIHrzmtr8cCOKH0kfuL?=
 =?us-ascii?Q?afcCG9iQNaX07zZJ2ggETUSDU4bDV1fSMw7Gur6hdlGk/516N9yV8O8d3um3?=
 =?us-ascii?Q?au6lxfYGS3hXJTMcrsP3mSWCk5doA6M9lhrLAm+SJtYR5puBjpXtrjIJe1hr?=
 =?us-ascii?Q?eRGbOa2WGqyGtpmOzE6X2tr3CpfFihRGGtkp1sXJHSWrLonBmz2MpA1ovmD0?=
 =?us-ascii?Q?T+Fk3d1bO23T9WJS67qzY8EcDznvTelQooVisIVvP125rhCux3DlQ4Yid3bg?=
 =?us-ascii?Q?boIhBVgqwTr9bv6GRqnSU+bmbjOLyWTEmfSQreMpLOCqPsJkFDMw+KJ3zT8f?=
 =?us-ascii?Q?Sp3/qnHNpIz4+hdUs6nvznM6TFP9aKQEyeo1u0IHxaya2+X3hbRRojlmjYkn?=
 =?us-ascii?Q?Cbf+m1ESh8JKGdidLK+D4WnQ97jMZxbK8SunEgBqcXKnZPLiJyNX3qrWlZoQ?=
 =?us-ascii?Q?zJTn2iauFUr4jzZavxXXqScNM257mnjVSP7qbZvZaQnHNM95Ul4NyVvXrWeh?=
 =?us-ascii?Q?8OOi2wSGtj/7sR1liHDycrJeRC582P1Hy3XbX59cy4k/X5dbZ3EyWNMHic5C?=
 =?us-ascii?Q?vKuehjILLudUZfMRDqyRreHbC8oNg4mXau8bUUK4bgUOoKC45lpYfzWGQ5GD?=
 =?us-ascii?Q?vuWUSukZn60dcb13p112wkosZhCNhDVNoAbaS+V1/JdvOwSoUduA+t+NKWF0?=
 =?us-ascii?Q?B/oPDCd+CU8wb/YamjKb/RPHQKV7lp3M0VPXPbvPU+5FN+cqzm46iFrNKQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xboe+7KCGs7osT7vFpC56KcayKZ3Wmhcs4IPrTNWe2CHSCIX8bR5fo8D3Sd3?=
 =?us-ascii?Q?P2e2AtdcRVECkwnU08WUnyft/bwR5EcXhxbp3aaSYpJKIZOH9naH08eAnLR5?=
 =?us-ascii?Q?bdzJmQvhrOgGRhyPDwxtORT+7ywDSW9hRWEfQiw3cG1+1lsIAu2LOUGyhrq5?=
 =?us-ascii?Q?k7CfljPJE+TylApYZ/cU8gUiP+Zl2OraAYfss28xpg0cby2l1j3LmvX1TYev?=
 =?us-ascii?Q?OFccY31PM4OHxRfY7r14DjvEb5hIE/RpgETsvGQZ0Ma7Shzth/viwiE5vu5a?=
 =?us-ascii?Q?1zBE7Jp52GwnydG/ksjRvpTrs/x0rOH955H1Thh7KfCNMsmpkrI5qPZBA9oz?=
 =?us-ascii?Q?3+tMbzdFdukyNux5U2Dtmv0YmPD3vA1ne0mAXximI6M8XZt3bmGHeT5Mg/Zr?=
 =?us-ascii?Q?cMDoJSFx/KAI+nY9r0GjimjKaMJcNAbo/RDG+WQx+pulhSY+x+FeoW/fZ19g?=
 =?us-ascii?Q?kIoq0X8WBeHlxbHS42ZPRCUgo2ii/qnF/gqn6vMpByLDPOUkCyRDuRoE7Aar?=
 =?us-ascii?Q?kq3d46ilweXiDbEWnSs9qIauX+nyp5gI8QrEs/nemZRUV+xm+LjnBQjVBwqE?=
 =?us-ascii?Q?YpIRygk5l2xogVakO1Z00oNWFavTokFqoQLVWPUWC4CNCMmeD9jxq7OOq45H?=
 =?us-ascii?Q?F/4TouD6Z3hn0ShJbfg5v4W14gs8/9kXyCNID7UtRZlkHCga1mMdu/cQrKAE?=
 =?us-ascii?Q?2EfDuZSsbtp6znT2Jn0H7MDC9RsLbg7o+tdp/3YTc40ffqWyL3+pO5lNragY?=
 =?us-ascii?Q?3ACyQxyh0XgGt6jyuCFmzuoh0DtbYAW8RC+PQ9bO9QePtvZdDMxhKE95s4ls?=
 =?us-ascii?Q?HhzOTD3RdTxs2aiN7UXZ+7LQ14+ia7jzi3FrhdTg0fDuHvKhu19/exHI8Ucg?=
 =?us-ascii?Q?qmHvjAP90E6tCck0Z7o2cUh6dMjucR7oNL3jDAz3njrCBn81cxUD/ldccOVf?=
 =?us-ascii?Q?NWAIK3VhZKRFS+WqFnbf7/n3Q5yCwUtj8bf12Cvc6RTLrFSmiWMIRp2pKpxY?=
 =?us-ascii?Q?aaAI+2Wcp76ma/OgE4fc0ZkfKaM2DDx+qB+fQSmnQsp843qoIfEMX9AWlrFy?=
 =?us-ascii?Q?2Y4DdRTEc17TReCtTeaX4hckdZPNns5BiR2qnIPCQK15O4wGi3eJdXywEysG?=
 =?us-ascii?Q?jcOeZQtc1SuCIb/nr5OUoyJC5WC2iWLENAl0+Q8GOPxcQbY1G8w/dvZ9gPFt?=
 =?us-ascii?Q?3fr0npt+RNBYm3oV6TFGibx7hbukvbFxZrqlN4rOCBiya9jzcPo32wMQDThI?=
 =?us-ascii?Q?Lw8NA1YqcCfe6cqwkTzWgGWpsJuvV1lsXX++i3Onv0FIh3Vrn3vTB8AOhRvx?=
 =?us-ascii?Q?CWIdAHbWb1DyMEzLas/Ov/LijO36f+N0kZJuY1Ukbvg3t7dZO4K9hLGKaPkr?=
 =?us-ascii?Q?h4bRzyW83ttPNZO4mdzHn/ccq4AAc4gWpsszoYBJTVH0wyen1AuLOkP0Ngh0?=
 =?us-ascii?Q?rtwdY0ghMn+p6m4MTNTXw3LH27aWFPmBB9SlA8mM34QDlIF/tOU6YV+LOsaa?=
 =?us-ascii?Q?rjAn9ZwAQ8SqB0PPVZgN8ByyJ0K69B+ozzrnUbI+9gPMoNs4WM1JmlBE/ENP?=
 =?us-ascii?Q?wCFU2YdXxFu+xrxv6uCIrFV8EmbW5RGu7s7MhLNL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff85be4-d2fb-4a4e-dc60-08de275938e8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:48:49.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXnQKdxAnTMn2ygHQccbGRhx/tI0G6HdGBPJ9NqHeNk2mt3lTZpT0VGIXQSOeLlwg3Wd2O+SR3Ns6VWPwNgP2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628

The NETC IP has one external master MDIO interface (eMDIO) for managing
external PHYs, all ENETC ports share this eMDIO. The EMDIO function and
the ENETC port MDIO are the virtual ports of this eMDIO, ENETC can use
these virtual ports to access their PHYs. The difference is that EMDIO
function is a 'global port', it can access all the PHYs on the eMDIO, so
it provides a means for different software modules to share a single set
of MDIO signals to access their PHYs.

The ENETC port MDIO can only access its own external PHY. Furthermore,
its PHY address must be set to its corresponding LaBCR register in IERB
module, which is is a 64 KB size page containing registers that are used
for pre-boot initialization for all NETC PCIe functions. And this IERB
is owned by the host OS and it will be locked after the initialization,
so it cannot be configured at running time any more. The port MDIO can
only work properly when the PHY address accessed by it matches the value
of its corresponding LaBCR[MDIO_PHYAD_PRTAD]. Otherwise, the MDIO access
by the port MDIO will not take effect.

Note that the same PHY is either controlled by port MDIO or by the EMDIO
function. The netc-blk-ctrl driver will only set the PHY address in the
LaBCR register corresponding to the ENETC when the ENETC node contains
an mdio child node, and the ENETC driver will only create the port MDIO
bus then. An example in DTS is as follows, the EMDIO function will not\
access this PHY.

enetc_port0 {
        phy-handle = <&ethphy0>;
        phy-mode = "rgmii-id";

        mdio {
                #address-cells = <1>;
                #size-cells = <0>;

                ethphy0: ethernet-phy@1 {
                        reg = <1>;
                };
        };
};

If users want to use EMDIO funtion to manage the PHY, they only need to
place the PHY node in the emdio node. The same PHY must not be placed
simultaneously within the ENETC node. An example in DTS to use EMDIO
is as below.

netc_emdio {
        ethphy0: ethernet-phy@1 {
                reg = <1>;
        };

        ethphy2: ethernet-phy@8 {
                reg = <8>;
        };
};

In the host OS, when there are multiple ENETCs, they can all access their
PHYs using their own port MDIO, or they can all access their PHYs using
the EMDIO function, or they can partially use port MDIO and partially use
the EMDIO function.

Another typical use case of port MDIO is the Jailhouse usage. An ENETC is
assigned to a guest OS. The EMDIO function will be unavailable in the
guest OS because EMDIO is controlled by the host OS. Therefore, the ENETC
can use its port MDIO to manage its external PHY in this situation. In
this use case, the host OS's root dtb will disable the ENETC node, so the
host OS's ENETC driver will not probe the ENETC and its PHY.

In addition, this series also adds the internal MDIO bus support, each
ENETC has an internal MDIO interface for managing on-die PHY (PCS) if it
has PCS layer.

---
v3 changes:
1. Change the subject, improve the commit message and cover letter
2. Get the PHY address from mdio node not from the phy-handle, so that
only the ENETC node contains the mdio child node, its PHY address will
be set to LaBCR register in IERB module
3. Add netc_get_emdio_phy_mask() to get PHY address mask from the EMDIO
mode, the same PHY address is not allowed to appear in both the ENETC
node and the EMDIO node at the same time, ensuring that the EMDIO bus
and port MDIO bus are mutually exclusive.
4. Add some error logs
v2 link: https://lore.kernel.org/imx/20251105043344.677592-1-wei.fang@nxp.com/
v2 changes:
Improve the commit message.
v1 link: https://lore.kernel.org/imx/20251030091538.581541-1-wei.fang@nxp.com/
---

Wei Fang (3):
  net: enetc: set the external PHY address in IERB for port MDIO usage
  net: enetc: set external PHY address in IERB for i.MX94 ENETC
  net: enetc: update the base address of port MDIO registers for ENETC
    v4

 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   6 +
 .../freescale/enetc/enetc_pf_common.c         |  14 +-
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 198 +++++++++++++++++-
 3 files changed, 215 insertions(+), 3 deletions(-)

-- 
2.34.1


