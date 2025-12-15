Return-Path: <netdev+bounces-244852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDE8CBFDDC
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 22:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4BD83011EC3
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB8730DEA1;
	Mon, 15 Dec 2025 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dkA2cjkB"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02615E97;
	Mon, 15 Dec 2025 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765832888; cv=fail; b=kAOBDzWQsEg8Xql//2+G/zSdQGs4wLkKyTpE35UXZmjmAuLWOgBviguJDjOJVpZu+XmyWlwd8wof0KgpUbGs5hQArB7SbxzJv4naPJwfKfFnyGug4ajeg/p0G0h0sEVD8bhDcX+FF0y/fKFA1BQjvuzB9wTMRyuD/ioV9XBj4s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765832888; c=relaxed/simple;
	bh=y/2hz5Ilrl0nJy/IPrlKbTPY261TunebZQZnz3w6VPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=InOQQ/oXJQxGTzC/qQg24UjLSm+KT6gA14dqfv+7ia7gETmLosievWsytlJo4UKcUr+wJzqFcsEGzOaoh1zE1o7L4lwl4TyiE7CXhAVWK+Sh9PM9ry59Cw6WvQ32kDCvIqmEje2Wfz2d3bYo4pHNTUcZgSGFBqy4zcj8n4NTMg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dkA2cjkB; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbMMrPeJTZPglVlzGgKes8VRrUJvIQvnB0E8W62d8dtNu5/e6OoDJHaApLMHF1p0NGaJ/Duynb21wtWWbx5ecLoJoHgGg/nn0MghE/r6rLg04zbWvXiLH+sM6q/0pDmrjiF7AwwSeIimjEoMNsaXEOKKRLHmihGE9hxKaUUrgPu+q1q5GrfEhaKiBJgo6WWNkJKx4bHTxS26xHUEY6rhBzTu1w082W52esnSdmCof75K/p+KhVC38NIHFLSJOOocHAN3Rsr3zONyqueXAJFJpVJbdQl8CwblzoeYpmIXqLJG01waOkJzs6//F5c454BpMlt1wRkwg2giSghoZcvelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2F8Qqq1NhrA769BZctpSiEEgSkjdMEqKG3dt6WqsZM=;
 b=m2oE6f8nuovGwimKu68WB6PIaI8cnq2RVjH01RI3unLw4foM/VnZXdgZsr5YftFMBFiOB6NxTh3Tnad/PkjXHQ+LEi2kUTu6y+dCXohQckSOTpYxCM5knOlvDcaS0vlzD6hqhN6dWvpIzTw3upIvE0U3wt6D8/zVDyodBuGdJ58fAdOdmvL2TlF4ubpXtpjbL9aHuTvGK7PRtzO+GXOqKOau+vUD/EXEdb4P1YGnuYJu2q/3sdVmeue6Tzq/QGLJIIhtIBlUgt9h2b/W8YJu7dmJrwdbhck+aykZxz0bp4uYz51nlAgFPRO/CWS9sq3r7yBEhTsYaXlDlZnhuHiMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2F8Qqq1NhrA769BZctpSiEEgSkjdMEqKG3dt6WqsZM=;
 b=dkA2cjkB4joc6EMS+QLwzCB5dBAgJ3/Ji1i8AeYSbKbzKk9lXi8CavdnewWinNWXn5elcBzs2Axyse2BqSCzotJVTBBUX3j8FRmPd3RXUgjAAZkBUc9uy5yNI0B8NTku4QI4Km3gFIvITvw7p6aMv99LjJRUut7z81t84uPvkEwjI4/s3p/hWrwwi20nCtaqxr3pIksE27+X2kcRtg9VatoX8zOqPq+mzIW8T985Smli+vgnlcCueWO7PSnD+NnIhnSJH67/BowwShpBac6VmYr4wKMasINdQFXSCxhpMa1aLPYNP/ieO4bdqF3/ArS/ueJL64NZEqz44PWY27wIgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9473.eurprd04.prod.outlook.com (2603:10a6:10:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 21:07:59 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 21:07:59 +0000
Date: Mon, 15 Dec 2025 16:07:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chester Lin <chester62515@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: Re: [PATCH v2 0/4] s32g: Use a syscon for GPR
Message-ID: <aUB4pFEwmMBzW52T@lizhi-Precision-Tower-5810>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
 <aUAvwRmIZBC0W6ql@lizhi-Precision-Tower-5810>
 <aUBUkuLf7NHtLSl1@stanley.mountain>
 <aUBha2/xiZsIF/o5@lizhi-Precision-Tower-5810>
 <aUBrV2_Iv4oTPkC4@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUBrV2_Iv4oTPkC4@stanley.mountain>
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 331def00-d5eb-42e0-a85f-08de3c1e06c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BWZSou2gouEjkIuMPU98GuoPbIPiogYBQcL1/NR8zA7JBLt2XIc3G/jxc0IB?=
 =?us-ascii?Q?xd0CjD40Tf+LmS07Rokzl8ijCrGcSONjWQmLj6fEzwAGNC+0ln0MECj0wPW+?=
 =?us-ascii?Q?Dx4sn6TRCES8SDPCNLF/V+rrxQFAejdxsaTenMsoEs7Q8anSLx97KmTJMe0f?=
 =?us-ascii?Q?yzG/GRB9WEjCgUiBbbbHm+8RYVItzGLgY2MW6bXtYK1JRq3WmyM+nFINq5V0?=
 =?us-ascii?Q?F03USByskPv5qzB2cpbUd6wP7o+tQJE0GToexvwUXLzMYlq2OKBREIF5D6rt?=
 =?us-ascii?Q?2xTID8HHNuJXFSgLPmTkB0+UNox6LwmgsbIpbNdgP5QVb3gtNWLgtB41b5Ik?=
 =?us-ascii?Q?L8+GAYIlitt44+bKgBjlG9E4g65cK3wxOyaMEKOJV2sv7lHQc3TRzjvTmWPD?=
 =?us-ascii?Q?S/yLogyXtCW0X1NuAY4UH+D+AZ8SHWtJTyEWGVrCvsLJiYpa+8YiavRmERWd?=
 =?us-ascii?Q?XM7gj7BBiAvcWI5BWHpDc0tPAmT/LYSg6k0vwyoyNtAfOEdy9PwYSDAdIEF4?=
 =?us-ascii?Q?NrpEOFgh9cS44T5cdKHpoHyUSRtwH264EZ/diLRkA2lAcw1Lt97SM5SdvywA?=
 =?us-ascii?Q?rihffzVZnQh4CZdH/32XoaVry+FRvmzjvIrFPTsvo0k87pqKozX5aD7DMy5A?=
 =?us-ascii?Q?YSEgtivQcUgmNQ/sS+uqp61oVz4029RgkJaEYevCAOecBYxDxeXvU/f4/Hvo?=
 =?us-ascii?Q?+4Xr0vJKlK6oiSljzIm3giFv7RlBI3dn5QyIqK3VcIgORSoGr8/tUFSz94Sb?=
 =?us-ascii?Q?WUmBTSUZRLhLENDg6h8A/Fs4YU2q4MX7JC4ZjnnJcSae9ehj2yXt8rcup9OE?=
 =?us-ascii?Q?hrJGhGEUvw3zIwlQkHrcL+SVmgk+RBAGDfm3edf3GPezYOog3WBjESitz3Kn?=
 =?us-ascii?Q?VDigt9+/DT6T1tt8G7+JJQYODp/WDHMXWcwuXuduP5VsM6LPfzc59dghDiM4?=
 =?us-ascii?Q?K5ZCq55dcORmU7SqHG3IfYSTQlJS1fCXNLyBsPr6QoDzPH1EtGfVnlgP1sXq?=
 =?us-ascii?Q?od2i1Wk7hR1gPzjA9sKNt7EWrok5osVbeN/tD1BQg1YBTYWJh4k1ELmCqFM6?=
 =?us-ascii?Q?uCzXhiCB1Hc+NuCpYzg2W3RqP3pG9QKGh6eosZZKJk6GpYokpG1cvagX+hWr?=
 =?us-ascii?Q?bK8yxoXG9AW2Z7LMX+3SYvX27knkx9zY3IYmNXhKc4FfxHWgh10ED1umm9GJ?=
 =?us-ascii?Q?zpuWFqpV5CKEfqSMM1uwKjFm+ayKEMnXHWEORk+vw6ffnHmqjWua/frUlY13?=
 =?us-ascii?Q?FJ5XFUjRimH8baUmZLwr5/H6QhfSKPsldloeW4S/mQWue6UZVI0VhtKuJL0e?=
 =?us-ascii?Q?i3imYXnuRagAVy+l78cv6zQGWxlyfJqRBE94M/SF9cxIra/obsbMq5bXzett?=
 =?us-ascii?Q?XJMP0ZoiG9bVBciSeQ6+32uyABSEroJwAfsYQfnYX4UdbUnYCKLOF+j6Zzrr?=
 =?us-ascii?Q?HrHUG42f+Vm193RiVvLJgDST9bYdXXxpZpz5e4EeXX0hBSSayG5Km5mgAczq?=
 =?us-ascii?Q?S/6faEYQ61+lIfshP1l/SkQ/a2u+3aO/a4Gd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fOi/3Q3YZNj0anBIRr33nX7Zgq7DigqEwR9xdqDwqm1f0Q50CCG0bDhsAZE7?=
 =?us-ascii?Q?BCGIfjK6Gg4xZ7F8UfPqDmF+z7GLhDpEyec4SLgC05hiI2sWdyJeDDtW8D4Q?=
 =?us-ascii?Q?ktaROKq3ZUUCYrERc/DFjWoPtAStEN9AMRku95gkWTKQu5B4LIJnszQHSh7b?=
 =?us-ascii?Q?REk6cNhuPZhWNX7yoL5ymsFK9Iyum4TaKiBnbtJGnqQfZLQpsB9+yMxt1roY?=
 =?us-ascii?Q?AVab0tWBp6CRpibI8AarphSTKE+vsFB0L434Dnul+Ra+IfJy7EwtBqhsP052?=
 =?us-ascii?Q?ORYNp+oZKDKYrufDsQmfKi37J1LRrMYVaANrxsn0RXQMC5VjojkAeZiAlr0+?=
 =?us-ascii?Q?Ye3s6xL0UxFKQ/Gw27EJGIIRWOA3F+PjLoHv+NF9zX10KHZWcTgQo3UJ6Krh?=
 =?us-ascii?Q?I8Te1/67dOSAQMP7hdDSVo0YddeshyLMz5K2V0H8J10iBM6SJpjpn34iTwDU?=
 =?us-ascii?Q?RBKBu00HP7NtszirJgePur5OIp6TMmvg27+usFg49w9myigeFjh9Fs53Bzm3?=
 =?us-ascii?Q?CUbMZ4By35zP/4NAXXnrFFxjrTb5bGxiwmYGR8A+fXjK4zJ60t9fV/PT/dNy?=
 =?us-ascii?Q?wfLQ7IOb/Bd1uIDTqtJY+P0vjNWq01l2TAtqL/xwCZ8HroMhu2laI8y2+Zjo?=
 =?us-ascii?Q?1HfDDHOmQThjXkMvsZ6KWRDFsGi+Awr4hYClt/Id7QjuCURM5U4OUydCraTS?=
 =?us-ascii?Q?LYObJvjAdPjXus/PIShpxxXc6NpFk+Ju2uwvK/eCVz2laz3ZpOKLqGy2lKpx?=
 =?us-ascii?Q?vZtWDV0gBlfnUneCZ5HmNjbr/6DbsGJ5quDuuzifSxTjJmQ60OqeibU3gQBR?=
 =?us-ascii?Q?Z1gZY/FsHqMOkeIwnfHK82JXMfcHLBbXe9fn00Xfy52Qu8ZGk7TW6K8fXS7d?=
 =?us-ascii?Q?6d4EjYvM0uXrr3v4ln+Oec3SHe1eC3+pJT2lvUXcI8pTt2dSeVWtmUbQloGT?=
 =?us-ascii?Q?CdFdaS1g8mtH5Xjpj3PgAZjEmoQZLJFeJTaYrjjj9spr8nOOegkmkeLDqAbg?=
 =?us-ascii?Q?pph24Vo995Q7e9F3JjW28QED6gk4sGALn28hq92ViERXsVEsu0nt4Uuh1vDk?=
 =?us-ascii?Q?wNSXnvv7oc175/44Dh/EpsLGDyKk6NNfGqPk5GDYfuYnkdp8sKpnph1371Gj?=
 =?us-ascii?Q?xoGv/FaNnE96rjn2tWQHi51TgzJ5SI3yOC69WuDXs8dQAXUHwjipTri+Q7ex?=
 =?us-ascii?Q?NYCnUIVV1EhUEUpXl+jLxpNYKx9S3WbxwPcYKc0hrLcGk7jw5t3Onr+RAxS+?=
 =?us-ascii?Q?crU8I+vnPSGyRnvSheKE1/TsIN1EOwd0ByysD69od1wz2j4DryQvm+/HOUlC?=
 =?us-ascii?Q?nxCO31YiMwpiO7R11INRpInh8DHxOfeDHXP6HzIuSY4eTrsatKo7kA/NJPgU?=
 =?us-ascii?Q?YxCzRZ/T7xcOdSLUKGWti7cyIqZtpJQCDZ82SaopcHF+q+2d6dQGa78sB8wB?=
 =?us-ascii?Q?FSaiMlNY5jqAR5+fkoEr5n++xehoSzo1aJNgkSu0Wb+ohYmiWN5qmS0Yr7ex?=
 =?us-ascii?Q?lge1vaAtdU7ZdRZxgTRcF5WlPlF4HZjlrVdSc1S/Ko/a28SHEg2QQJ57vIh5?=
 =?us-ascii?Q?54KguwT5Ikjg4/CRy43l3YAYPjnrAF0EL0FN7vUZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331def00-d5eb-42e0-a85f-08de3c1e06c4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 21:07:59.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJsV7eqyufSl+hkcZBNmYh7+3XuTrT1CepXB7ENFF3zbOjSHei6k/ytRflZ+2rJC7bGNCy8evZXJTcB0vDG3fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9473

On Mon, Dec 15, 2025 at 11:11:03PM +0300, Dan Carpenter wrote:
> On Mon, Dec 15, 2025 at 02:28:43PM -0500, Frank Li wrote:
> > On Mon, Dec 15, 2025 at 09:33:54PM +0300, Dan Carpenter wrote:
> > > On Mon, Dec 15, 2025 at 10:56:49AM -0500, Frank Li wrote:
> > > > On Mon, Dec 15, 2025 at 05:41:43PM +0300, Dan Carpenter wrote:
> > > > > The s32g devices have a GPR register region which holds a number of
> > > > > miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
> > > > > anything from there and we just add a line to the device tree to
> > > > > access that GMAC_0_CTRL_STS register:
> > > > >
> > > > >                         reg = <0x4033c000 0x2000>, /* gmac IP */
> > > > >                               <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> > > > >
> > > > > We still have to maintain backwards compatibility to this format,
> > > > > of course, but it would be better to access these through a syscon.
> > > > > First of all, putting all the registers together is more organized
> > > > > and shows how the hardware actually is implemented.  Secondly, in
> > > > > some versions of this chipset those registers can only be accessed
> > > > > via SCMI, if the registers aren't grouped together each driver will
> > > > > have to create a whole lot of if then statements to access it via
> > > > > IOMEM or via SCMI,
> > > >
> > > > Does SCMI work as regmap? syscon look likes simple, but missed abstract
> > > > in overall.
> > > >
> > >
> > > The SCMI part of this is pretty complicated and needs discussion.  It
> > > might be that it requires a vendor extension.  Right now, the out of
> > > tree code uses a nvmem vendor extension but that probably won't get
> > > merged upstream.
> > >
> > > But in theory, it's fairly simple, you can write a regmap driver and
> > > register it as a syscon and everything that was accessing nxp,phy-sel
> > > accesses the same register but over SCMI.
> >
> > nxp,phy-sel is not standard API. Driver access raw register value. such
> > as write 1 to offset 0x100.
> >
> > After change to SCMI, which may mapped to difference command. Even change
> > to other SOC, value and offset also need be changed. It is not standilzed
> > as what you expected.
>
> We're writing to an offset in a syscon.  Right now the device tree
> says that the syscon is an MMIO syscon.  But for SCMI devices we
> would point the phandle to a custom syscon.  The phandle and the offset
> would stay the same, but how the syscon is implemented would change.

Your SCMI syscon driver will convert some private hard code to some
function, such previous example's '1' as SEL_RGMII. It is hard maintained
in long term.

>
> >
> > >
> > > > You still use regmap by use MMIO. /* GMAC_0_CTRL_STS */
> > > >
> > > > regmap = devm_regmap_init_mmio(dev, sts_offset, &regmap_config);
> > > >
> > >
> > > You can use have an MMIO syscon, or you can create a custom driver
> > > and register it as a syscon using of_syscon_register_regmap().
> >
> > My means is that it is not necessary to create nxp,phy-sel, especially
> > there already have <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
> >
>
> Right now the out of tree dwmac-s32cc.c driver does something like
> this:
>
>     89          if (gmac->use_nvmem) {
>     90                  ret = write_nvmem_cell(gmac->dev, "gmac_phy_intf_sel", intf_sel);
>     91                  if (ret)
>     92                          return ret;
>     93          } else {
>     94                  writel(intf_sel, gmac->ctrl_sts);
>     95          }
>
> Which is quite complicated, but with a syscon, then it's just:
>
> 	regmap_write(gmac->sts_regmap, gmac->sts_offset, S32_PHY_INTF_SEL_RGMII);
>
> Even without SCMI, the hardware has all these registers grouped together
> it just feels cleaner to group them together in the device tree as well.

Why not implement standard phy interface,
phy_set_mode_ext(PHY_MODE_ETHERNET, RGMII);

For example:  drivers/pci/controller/dwc/pci-imx6.c

In legency platform, it use syscon to set some registers. It becomes mess
when more platform added.  And it becomes hard to convert because avoid
break compatibltiy now.

It doesn't become worse since new platforms switched to use standard
inteface, (phy, reset ...).

Frank

>
> regards,
> dan carpenter
>

