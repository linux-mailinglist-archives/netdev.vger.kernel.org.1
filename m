Return-Path: <netdev+bounces-117879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8697694FA8F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 02:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1EF1F226C5
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5120237E;
	Tue, 13 Aug 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T9aiC5j0"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013001.outbound.protection.outlook.com [52.101.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E11319A;
	Tue, 13 Aug 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723507832; cv=fail; b=IN0YIY/8lG+D+Ezlaztnyg993bhjtoq8pR+fEwBfevyLWw6jiIq5saVzajm95x4NIsshKfGO/If8GWDrXZKuwPxcjRlKDoDVvidTM7vo1rtakfd7WYuGbinhpFniYWWelgMtv09RVJgizYvwI3ePF86+fRKyr+6G5Wqq3/NIYMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723507832; c=relaxed/simple;
	bh=KimRDbFina9NS47bPxJAN70Y2/PHYl+0hNKiUDWFSWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qlnxpCVO/WdcVWmLFyhUvOsh5/1EsxEHAoQdGylVl7qqAEq5eZxcoK/DgWeoHGwTRBuTRFCxhtXetCSYfyma8DGsi4L1ygg86qp0SsQ6PdQOPr7dfh2kVu4JT4oaJ6PAkaKcpS4nBxUgqHWccQdZvt4KxX1DhM14ITlIl1T+iow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T9aiC5j0; arc=fail smtp.client-ip=52.101.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3Bxoa2f+mKTGMqlerEYGNHWUIPad0OWY6XwVPBd8lS2XtKyKfpIJ0v+4qqLicRI54kmJ6XSa7sB29eSrPuiQ3OcZU5KrRXr0KVUqe+b4AKqr0ZBFX8BFgLjdUgdga/BibmC3d/mgXRCq0z8lLrR37Ui+VCyd97dOEk1QZYYF69jM4HdpZ31KSk5EwoYjdBCAg5pvb6Lb3cGmFqV/vXsTCrqFmq5yLuYObiN0SrL3InF0ISwY4b3wi7nQegUKDoILbHv+XwYd52GRISud8xpRAWdia/jgABghgc/CtRnF1T9OXHCX2vrvw1/mWrI+rLrDpcbgXAMo9IDq3TL+YF0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLZNGYGRmT3G4BOCjGYUszqo6jg9Kaen5CRN0TSN864=;
 b=n3Oujb3GNV8tHeBR9hTbwngqkALd6HXZfveOhC1BuULKG0jPphGUfyTXqEl7wi7og8d6FtOKBfdqnNKI9YL47cRHVWLvE67MqfJ9xFpERo7Iv8nNgdjsade63WcFZ7tJWqPVp1ZVTUwICpc5Wa1jPI/jSWo2Xr9xsmJsVPvIb3ri+gz4SzycPBZ1lY3BmppQcRuvZ89FfAYy5Tfadj1998PhHc5n7tw0MFgftKpjzJd62LxQCMZSc1V0iSN2eUWo5HRBodJX1zlv7twtKji0wHl7MRiiWsF/Qnz5+Q8ysGVQxLXIDCDCqKsS1Cd7uKisotEIy9ON0aHd4hVYcHRW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLZNGYGRmT3G4BOCjGYUszqo6jg9Kaen5CRN0TSN864=;
 b=T9aiC5j0hpEtERC0QaVXQQpCX38FMZ4uccgYYwIVRhoNdy9TwiddQLv+FrywGmCj6oaczK0w7b1L9UHEdr8uNYVZghfCcbV+TWcz+ICs6kS34RTxc8dgZe9sN617Lg0h8nkLt8NNl3rXzg+aRMimgSS0SqpqfJj2ifIDyGJZFLyu+p85ESZu3Gov7b1qO00I08AMksi3LMOvTMVoOADfpLpGMQlrCLz8TJDNyXoC/yrAZpw1TvtFAJHuGt7nMGXLbrffLyxcuCOUfeqTIQG2lYtadBGAv37A4bSUTVRrEV3ubiz5MR4BGQwNX1pcraPxjdq2dcm/EvOU0bWjSg0qiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7957.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 00:10:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 00:10:26 +0000
Date: Mon, 12 Aug 2024 20:10:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: mdio: Add negative patten match
 for child node
Message-ID: <ZrqkagQ/8o+WvvTt@lizhi-Precision-Tower-5810>
References: <20240812031114.3798487-1-Frank.Li@nxp.com>
 <20240812223611.GA2346223-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812223611.GA2346223-robh@kernel.org>
X-ClientProxiedBy: BYAPR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:a03:100::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 113c7f73-1f5b-481c-008b-08dcbb2c558d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pTsuKIZi603lncKOBgCqV91BR5/t7D4lEx0K+34aL33W3E6vaUKyVkrVYFms?=
 =?us-ascii?Q?QTIMG4w0TxvqdbomgcFl2KcR2juwaj7vhcD8OrewriOZMaGFciSV4HR8naqX?=
 =?us-ascii?Q?/0aa5nv7ejgCORv0GxqIVbNYHk/EPpmRXLilFalkquLMVE7jmadV+Xyzy9Gn?=
 =?us-ascii?Q?U1qpKjYI9tWzShLJnGVa9f3kdsLbi6yubvfAbvr7TCkjv7+2TlAkd5X/i84U?=
 =?us-ascii?Q?6olYkC+8cttwWNJiL7ogkhI1/04tUYB5bcOQePqYfMehh7701TPGsFdk4qie?=
 =?us-ascii?Q?WiyWkO6K7E5iHSDtskzWZA9tBTrwFC44kDg/bXOVc2fvmqt43ZXJyr51PMMN?=
 =?us-ascii?Q?TLtUAIC3+lUeGzR/4626tWVo5yLKh7lmf83MOY5L2kz0o8eX8/ut+5swkp8j?=
 =?us-ascii?Q?VlvQxxgjXuFrcKN1qI6qfJ2PHcD606Z5UYQOlHTBrXkymSiG8oL400xiOCcA?=
 =?us-ascii?Q?IGNOU27s9IY51kDDFmC0Gl153/4XYpNNwfej+6bpM8GY+pmQHlaCaNH8TiHk?=
 =?us-ascii?Q?hE52b0tQ/ONP4nPxM0FQ5J9ISUQRHdhXjGxLoHxEEZrDrWADdNyo04Euu0XZ?=
 =?us-ascii?Q?/MUjIEiMgDZUZZxnzY4bnyBPAXFQmUfvr9xZtlv5r0dttqa0VSvSZJD/Vmmd?=
 =?us-ascii?Q?BnXq2R9z/hKInLErt90MPLfuFZyXTxFW9S/rdvKPatrYXtvWPx97829Te0tI?=
 =?us-ascii?Q?dR56jUmhwTZDEOUlyGkI6+FXiqczYrTISUdlMLRISsdq6tsnuUbiKOkv0IdQ?=
 =?us-ascii?Q?3MGxAhJtrkv+ncE0RQHdUvOPaDXkWn+3InK66KcmGk6ccRT11tUID1zbcSXK?=
 =?us-ascii?Q?6NssGYF8Ddaq2OpRpfJ1NkQ8J9YVek0t4RcKm1g5eS0XOb9HhI7lahLRrwVH?=
 =?us-ascii?Q?BvnJcTM9irmi+ZPTiznZ3W5suU3OeG//bP9dd15CRI7toOoVGXZz9CuKAImw?=
 =?us-ascii?Q?V3qrrLzZDd1WQTIi9Z+hvxbq521X8PCoKb31gWejPWsnFuRYXBnkNhvs2hq3?=
 =?us-ascii?Q?Xlg9fUa1BdmVc1QKcXayA24RpZq8ybHx+rIRaazrUTsyVImANRlOEmFqGxB+?=
 =?us-ascii?Q?wKGv1dlCjBVMgQSvWiFcJ6jdNgi/R6/9IlEfMLdYijapAajio4eCEoAmKtBx?=
 =?us-ascii?Q?svUJSn8JfrhygoWWYr1VM7DPowNkSOPCMgp+qZfsdGJ5PthKMb/9wKaCMOpv?=
 =?us-ascii?Q?meLnX/c1jCJl1R+cGP3NwXfF+UzQt2R5AT4GFfEGndFVNccmdtCw0jPcGiHE?=
 =?us-ascii?Q?yqazAlSDjU8y+WK5XOPwgd8ChMaP98Lr3gTEN7KJ27IvVXjTqDAs7589T+Fd?=
 =?us-ascii?Q?G2uMSGLOhFvUBoCw/XrT7EzW+GwdAnS8MqzRsL/7f1VJ5DqqW66xXn3no2/4?=
 =?us-ascii?Q?BpqDR5j1Os2MXdu5bj0TWkeyklDsbaQatDV3rEf+udEcuJKCUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HsLMkV3Nqx60CRbbStz87suXGwn4bUN0O4shRq0TwK3R0n0nRhTUyJMgHbyi?=
 =?us-ascii?Q?zvS+0rcL4AA3SlakSrnjIQjPd1hBKee9Xjxw6FyFCCU1Mwl5kidL6Lof0u4G?=
 =?us-ascii?Q?KAKjzcsZDYgXa4Fs/ohCGwHKrmVQYCzTq96PMQkCkmdUqTQ33LInyrdVfeFd?=
 =?us-ascii?Q?iLiSG0BQ2tBPQPWeqQq3jtNeIy65v2hgfsh8GQRdqaNSNShsFS05Ffj64rOo?=
 =?us-ascii?Q?4nEQbWSwc2NAq0sI0AtwbW7QPj1t1nMg5iwjba7avhqniwnelMFVMlb4nnnW?=
 =?us-ascii?Q?GFhd8uLfdj0ALLsKPEdzQF+IeI0ifdEhtBSV62NowSIA+Lk7lhCIkrzRfwwx?=
 =?us-ascii?Q?cq0O5tyvP00qUjLfZ75ppeFkPBSEIoNwlJ4tnfznh2tQDGB/zEfFBwTJtgB1?=
 =?us-ascii?Q?Hgg9zzUaWRdMQ96zDQGnziKTOZa5Hnii/nrG51zEmC8M1ynb5StNOGjVdE35?=
 =?us-ascii?Q?QBStcbjg2XJB0FUwkilOWpyQUnT0Y4jcSlI+qw6E16tPmxexs56MkkPqE26g?=
 =?us-ascii?Q?63oBZHgqtgrD4WAeW0d3kGtiaFv8ONkdspu7woKHkVUJVSoLalvVw61HJC+h?=
 =?us-ascii?Q?2HfepA/ln1VXAlRK5sy85CcwGqpt8r3p/BCVCJ22+XKnhUcItx96qFOGtRZ5?=
 =?us-ascii?Q?AHuiGApwOdno//HT/i/yxH0MtdGNXbPBjnGGrgJyzTlyYUIZjTHqOvc3wEol?=
 =?us-ascii?Q?0m0DLReEBTo3FXWDdwSJmILx6UUZZ9u5meZOrzT980IpXJ0g2IOBtBDDL6m2?=
 =?us-ascii?Q?toVPNvDmhIDuCpFkLHAXC4AVRPhuiJAx1gvrknbObpEHq7DzZTZkBoBMzhbx?=
 =?us-ascii?Q?M8gCsTyoDi+/u5Dw94Z0uxH9VP950nw2yMxkySkbMJ1wh6UAGiujhJwsuiaq?=
 =?us-ascii?Q?1zRKD9uopN8duKyRoYQ2EDLrW0IhKw+fsVXR3Ou1Jyut+OwvDM06sgwtqRJm?=
 =?us-ascii?Q?CIfAuXww1Ip1irdNFByeBcD2k4RShsfLCqMqm7RkkNKG0E8/M3bKfhDpfCOP?=
 =?us-ascii?Q?Q3NOuQuqk+nn26yjGpQzXoCfiH7tNvI5D9tl5e08hIp6QcKaXFliFedzXN/o?=
 =?us-ascii?Q?9aUYdxPDkDmj02RCGor5tuWhR54mAYQZlJbomJPtz/M/EEWXG8UdxySWNJoR?=
 =?us-ascii?Q?UcjAE2zLBSkXKPg1MTkfDVz06xYfX4x5O4LXjUD1TuE+YA1gGIqh7Oma/Bka?=
 =?us-ascii?Q?x05GYY0AcR5vRau/+hVXbJhUYgyoEV+ZJOkLFLuRncasgIjGv1bTqZ+1l1a2?=
 =?us-ascii?Q?pHv4/uauVL5GJaFef69xMl0SN/SrbOsychJz5qNVk6u9lQ0CqAQ+yTOk+VLM?=
 =?us-ascii?Q?IMDNCLumLxVLEXVvXAuUSPbeHKii7IvYmPIcyU9GPHvcRGzRfFsfATDf6JhQ?=
 =?us-ascii?Q?b+aqSjYy9gehp91XdYLIgiY+ESIfy8hfnBjIhsJPfA2tFfYov6x80lwwM7Vx?=
 =?us-ascii?Q?r2OzVHkaBM633qhiQc3asoPkxBiGYrw4Gg9EnXf5k3zAwGJyp8AiDvDWoygQ?=
 =?us-ascii?Q?yFxIgewimlLE+grVgPvn/xysOV019Mg6IkcKId1/uz7wHwRMCHnNtoHIyecP?=
 =?us-ascii?Q?agxDnG0o3OfFrkob1gA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113c7f73-1f5b-481c-008b-08dcbb2c558d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 00:10:26.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvKwGUHtfRlFgmwIBZV5ivFOXNnEO489Wl2H4PF4qA/HVPpkyF+M+aQeZQ1bueQnGQr0raht6VqUsFGyc3PdZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7957

On Mon, Aug 12, 2024 at 04:36:11PM -0600, Rob Herring wrote:
> On Sun, Aug 11, 2024 at 11:11:14PM -0400, Frank Li wrote:
> > mdio.yaml wrong parser mdio controller's address instead phy's address when
> > mdio-mux exist.
> >
> > For example:
> > mdio-mux-emi1@54 {
> > 	compatible = "mdio-mux-mmioreg", "mdio-mux";
> >
> >         mdio@20 {
> > 		reg = <0x20>;
> > 		       ^^^ This is mdio controller register
> >
> > 		ethernet-phy@2 {
> > 			reg = <0x2>;
> >                               ^^^ This phy's address
> > 		};
> > 	};
> > };
> >
> > Only phy's address is limited to 31 because MDIO bus defination.
> >
> > But CHECK_DTBS report below warning:
> >
> > arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
> > 	mdio@20:reg:0:0: 32 is greater than the maximum of 31
> >
> > The reason is that "mdio@20" match "patternProperties: '@[0-9a-f]+$'" in
> > mdio.yaml.
> >
> > Change to '^(?!mdio@).*@[0-9a-f]+$' to avoid match parent's mdio
> > controller's address.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/net/mdio.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
> > index a266ade918ca7..a7def3eb4674d 100644
> > --- a/Documentation/devicetree/bindings/net/mdio.yaml
> > +++ b/Documentation/devicetree/bindings/net/mdio.yaml
> > @@ -59,7 +59,7 @@ properties:
> >      type: boolean
> >
> >  patternProperties:
> > -  '@[0-9a-f]+$':
> > +  '^(?!mdio@).*@[0-9a-f]+$':
>
> This is at the wrong spot. The problem is up a level where the $nodename
> matched mdio-mux-emi1@54.
>
> I think what we want for the $nodename pattern is:
>
> '^mdio(-(bus|external))?(@.+|-([0-9]+))$'
>
> There's lots of pinctrl nodes named 'mdio...' we need to avoid and we
> aren't currently.
>
> I'd prefer not to support 'mdio-external', but there's already 1
> documented case. I think the only node name fix we'd need with this is
> 'mdio-gpio' which should be just 'mdio' or 'mdio-N' like all other
> bitbanged implementations.

--- a/Documentation/devicetree/bindings/net/mdio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio.yaml
@@ -19,7 +19,7 @@ description:

 properties:
   $nodename:
-    pattern: "^mdio(@.*)?"
+    pattern: '^mdio(-(bus|external))?(@.+|-([0-9]+))$'

You are right. Above patch can work.

Frank

>
> Rob

