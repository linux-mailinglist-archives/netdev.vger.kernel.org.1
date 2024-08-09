Return-Path: <netdev+bounces-117179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F28394CFBD
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835961C20B75
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9ED19147D;
	Fri,  9 Aug 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nzvd/IuM"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD9155CA5;
	Fri,  9 Aug 2024 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204988; cv=fail; b=VrOnTBgW4UR4JzcPpruYevFY03UKkJvJ3EY9nwsrygwwwEyvpLneeKZdQn5k+xAYu0OvqcnlL1nipVL4qzZ7mAaKOQIJYqfFqV1FxllweqiLt0UtAJq1bKmw5NL6rThMjmFBPjYfPTtDTpfOTCY40V5YYDXDTBGCynWbuuaa2L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204988; c=relaxed/simple;
	bh=qac2YFFHpNE+19jrm1kbQhFgO3vnpATEBH1XIFUQFEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nIO6pJR0oPk03g+dsj5kprZz/R46WN45SE7Y//ZxpfZa347BSujJCo6xQ99Pcxr92kAVEceIfPRS/uxZd2FuhhVlsWaZ0uAQaqexfBbjOmQnuGJeZ2jI2we7fCvoYz7DECZrKnslWe6yOjP9NHP7ccdOxpgDoYGnXXF6J+ZK9ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nzvd/IuM; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OA0oU0w8ptqtHF5kDmjk2t/CVRxZbjd1eIjak3P0HNqGvxPZvrIh6I5dXymBQ53ASujBCgDAjMzCTYUPna33oBHfe6h7C8bhSDdkFLihDpG5yOWtwbPZaW/RW6eN/l2w9mI8PLzhJiSfaXRJbevpVMUnRzwhtcUCvmh68u31C/0NtQs4dLEdA0Pc7EE2u3GfMiEpydctOpIE6ClIm29F9bVPHAR/hRsdHX1R7JvBIX9kYHli7fnKevVZbry7H5ur1Vkf0PHMUAglWiwa88QIYh7Ac/e6a/wO33MJH4Gd97kEbU2orJueSwtTY/wtUt6R0dEYhYFyj7RYpIIpIbwKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVuyW0uDW+b/7+h+fdPzXZErgVI6Ueo5JUnCuSiymIo=;
 b=VIRLubFlXYxNgJgKTbODOniLXBwTpSZhi+6RnQGjI8cVPt/c6ZaAtUvjrPEYKBJpluLs1Cz8xnp/znF7oF7AAQpZjo3jsVDyOML71xfN9dymI8jMJfsdmsjt60U66syfj/UKqj4noi8BmMMFw4VyuM0Rfa1wg6qu7OdMRAnQ+gBXikP1XPhjdxh5XenmxxTkcybphkAJj1xhbofvLAxXPdIj1PtGVUma0BtA2OyVwd5dDkWKhl7YgYRmFSlZm+qFvNfE8+LjSjy1vkhcFrCaHhpi+TkMYQF+5B9BaH7vS1WPxWuPA/F41bQWGozZ5521dombi/8IM31DmqHgO1y6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVuyW0uDW+b/7+h+fdPzXZErgVI6Ueo5JUnCuSiymIo=;
 b=Nzvd/IuMPor97nk6+506ez3R4tzvZSzMMluPOSryxwdhxrhcrOnAkTDSqAwT6c2Qq3wGkyDQZn3oxEr4OCiUEpbu7RHpzXpEbZIKAFqf5pKnMxYVx33wEqCjQHCRrqIRNOv54nfdbli0q63aRfLLCi3FqyS2wDFiHENzpyYH/TINoRVj2AzTrQ3jlIetSVmReYIIv6qNr3Romq6bBFh/qSZrbTbnZdAgR2rjAn3dwid9CuYgIhhEyDTEsU+EBBxMN3fVCVrEw6fJ9NhnRbrfPoIKnNb2GSL5D6tbero8Gm341uVARSIHLtWHx0nmzgcoOlJ3CEt/QZXVLN5eEudK9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by DU4PR04MB10888.eurprd04.prod.outlook.com (2603:10a6:10:585::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 12:03:03 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%4]) with mapi id 15.20.7849.013; Fri, 9 Aug 2024
 12:03:03 +0000
Date: Fri, 9 Aug 2024 15:03:00 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: using
 unevaluatedProperties
Message-ID: <atte34qydgedr665phxwgp3uoyka3vvowuet6rk2fki7upev4m@edphw77cpdbj>
References: <20240802205733.2841570-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802205733.2841570-1-Frank.Li@nxp.com>
X-ClientProxiedBy: AM4PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:205:1::36) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|DU4PR04MB10888:EE_
X-MS-Office365-Filtering-Correlation-Id: f66ba062-cdd7-46ca-c8fd-08dcb86b38c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t5fTJAdmwe4AgvduvLjTk+QFslgNOOYmDB2BPARBcX32VA4H6diA4u4HSEEK?=
 =?us-ascii?Q?xcQh+ppXP8Z++l/N9h0zQBMDKmNgfJT+YKTh0jhexi2Ooi+ApI3aJQUX4D1H?=
 =?us-ascii?Q?jwEYy+FwO9QTo7dKOjVFTxUTLT10YXPvGJBa5oNxWz7pHdXTqtcbOGyP9a0J?=
 =?us-ascii?Q?e3vyHJFOsUkvNfHiQlpdhqji2Nwbl4I1k5HedzagloxwRX8xpA6AlRmXp43t?=
 =?us-ascii?Q?IKdQF+7UcqHU63JvXthUY9tCs52Q4hCZkAbtR6f3pUcTUiOO64iUwxE31h5Z?=
 =?us-ascii?Q?pt4kevxruvZOgFbEtfYb2IMx4l4rykW2Uk3roGU/SgkyiEJkxcD5Kn2CmI2H?=
 =?us-ascii?Q?9iuIACVTDr8WAw9KgdwpEKqZmJC1Awhcp+8xHVjcJyaK/8lf9HfInRo0rQ0Y?=
 =?us-ascii?Q?7R6XM6U2o0VxblwN6JjkbExx4iXCEHLcvxZT5TY9aULfkkbizuDHKGCFHC82?=
 =?us-ascii?Q?jSzw/SxMvNFNqf7PlygLJn0kJrDMAJo07/+r+oGKbEjZTQjbolXn9AVlWv/r?=
 =?us-ascii?Q?z/WXm+5ay7HLZxsRgGXgvqxutpPeg7LbuxEks+5myo8M7BgpR7wXPcQi7TjI?=
 =?us-ascii?Q?iHynWTr+fzzUtIe59xBWZzCtQFDLOBVev9UZAo4GgCmtJi55s4+9BfKxAexd?=
 =?us-ascii?Q?kxlrkfdP793V8erXHPIy2q4ObsFl+VFjyUNqr/kZiA3Cx04/OpahZ1leoqqC?=
 =?us-ascii?Q?rTRS0wl715urY028+XGA8be10pNDwK9tfu7QtJeG/pXWAwfo/pFLXEoXwtFn?=
 =?us-ascii?Q?LSfme/wQWeUpwn0bRs2lbk/Fx9eNWGCS167Jlui2slt1oPyYylpDCeo3Bm8a?=
 =?us-ascii?Q?JSFbjPhqZ2xUc1jdxcotQwMWEYRHLvbN8gSlmWdv5uixuKe0zoW6TpuiYF6Y?=
 =?us-ascii?Q?mE8tC/HzOw+rTW/NYRfcH/DgdQc8pDg4WdfrtCfX0DGpt82TeJV/eS17e/Ul?=
 =?us-ascii?Q?+m99mgJ42M88qKkolXwsAv3TyaXShFbHybmqX8zd6CVaShYBVIBgdTiTR+yV?=
 =?us-ascii?Q?qNZk4BrEAFXOnCtOqTzPBEjXLdgehCucI9n9l7Z1rPb1RqxCYfjyvHCJzln5?=
 =?us-ascii?Q?bFK8OVAYplaAOCRAu3BmUNMXR7BCMcKYXwGZyAD1uucG0AKnk3kl0F5C0S/j?=
 =?us-ascii?Q?o2DUILAPbEDz3DhdAcum+ABo4y0H6t59eRXqzaQxaDQamnDv640s+Vudk8OB?=
 =?us-ascii?Q?dpjnFdOCp53mYvzC7AZWVKc92ty6PeX+QAuyAjl0ua5AK/YWU3IUWKU0M6NI?=
 =?us-ascii?Q?a0vKIxBcvw10vOS2Ob2qHIsSqxXEDh0+VceNDrv99X0xJ9dxx1n/Bi9SXc9m?=
 =?us-ascii?Q?NdM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qV7nA7kPiJpw83N/rkJNNRFt91P214t+XIoJlzvqLo7ujT0mRNrxDhSRqrHy?=
 =?us-ascii?Q?uAw+2jugzyROTOuEsmaKYNvZyRjvw/7EXvyxVm2QknZWl/XCT1doTsTudB0T?=
 =?us-ascii?Q?G6i3mycWWyiwfp+ZW4zsUHcvooRY+oWAG0clcqX8xcP8SLRzsot4XRDIoBPh?=
 =?us-ascii?Q?DHBbwyHJas7fXCuXFwGPACqE1CLWgS9bTTnJfZ+rgS+hSV1xYCartllze91+?=
 =?us-ascii?Q?tFbA9aIJKtO/95fPiofWPXzsAUqXLefOqRkqiCwVBjHHe8/VZ6UWtqsAP0Wr?=
 =?us-ascii?Q?SwDhi0MuxmOAp6oYBHwdlEpzFu5bXARfzlc2OMNAU0cPn6mabp7nfsRxgoQ2?=
 =?us-ascii?Q?0q6VLV884nWxfEhDyr5WlNwMHnOAUDBfmGmX9BSvPuINxiu37yrqa5zONepa?=
 =?us-ascii?Q?nYMJX3FIEE4gV3b/ajnBsHx0pByd7UvD/S/VJjKcTjAy9ukzo8vFQJRkTWo+?=
 =?us-ascii?Q?TAPU84r+tKQgRhvbs0/g8In0gzQAdvROm8aVuof9MP31t/4A/Ms2z+ScxGzV?=
 =?us-ascii?Q?b9dM7vJ9wyIJylO/mbwXavsuorvWu25nV0srhufNnX03xze6Hblej1fSJAdA?=
 =?us-ascii?Q?sDNBYpvihELxqdw49fK/tKKKsVs5u40CVtpI6X5/H+Ex99ENKP6VypQuta8m?=
 =?us-ascii?Q?9wkgu6rXqjwffrYlzJ6+xRSUcFp8LpfpV8EodE6dE6WgK7uE1WEST+gtNCk9?=
 =?us-ascii?Q?gVi+KUQKbo9z2zCfA/fAcmhtZ6mDFbDmzTlO/h8VrDrNVnSigv50k4W7z2zy?=
 =?us-ascii?Q?Q9WTAUZEnbTRNQ0UmcAmOSDSu79JlbbcZKZmU3djJDxfquk51btvD2460elL?=
 =?us-ascii?Q?DzSiV7Hwg9puRL6WHpnihhrlNa6FsQLP/Tc2PL7uRbuk0MnSW6aaXfP7gDKt?=
 =?us-ascii?Q?gkTVDG3fQHNECL5d7/zqydymIYUzpKVrE64jk/Xweutnrr+ZMx/NHwSJvyVg?=
 =?us-ascii?Q?ZWotUtj5HKFpxF4zWR5uull1bthvrSIVMfvWP4zu0rTBKLI1MAnwlHx3/ilH?=
 =?us-ascii?Q?YvTVXYKa44MVX2st7Gp7V9yKqM9zi9/qIpoxL5BO7qeHyDd6rzS1PCQPvYS4?=
 =?us-ascii?Q?7Pwaq4VnwyapaGP47wWuTZeTK+fjiFXAPjoBTFXbS4f6W7LOGHgZuJhs5zKJ?=
 =?us-ascii?Q?b77Q8/JMC/Xg4XBSr6Y6rXBy4xFvHgmr/NsLyVOeKb8Pl+qYgp0ACNJ/wHEV?=
 =?us-ascii?Q?JQa9xysYlKSiztx/7zw6xeRl+p37tpx4ca1mxLCrLBNzJfJxkfVJapIwr5y+?=
 =?us-ascii?Q?pD7WArU82SarDxEVYs6Jehz+7LBRik3HLCg/F8nPHAUpbMmldQSnIHdVo5p/?=
 =?us-ascii?Q?oDOrRJUdDtn5Yg4s6/3P1+afNQ67lAuTlmI4EgmpqwS8RkezjMcj1K7bCrSl?=
 =?us-ascii?Q?gBvsLgLRuJNW2mEeodLxvHst6oaQwAf/5ijoYG4EyE6kLqCDpotfBmb6PkeG?=
 =?us-ascii?Q?4JyYq6neaTcVYp9e/qOsnKsIkW02ldA+5qPvuTlGeISBuKBMCDwaUK9Wnsot?=
 =?us-ascii?Q?a4x8vFhWvn1mdv78Wg6VkGviheMNJ9XaidCwvcxE+5OUQdxLMvlBJnE3Ep4v?=
 =?us-ascii?Q?PNXtBYbjaz4NJKShnJrlaRSgdcFJgYlfockE8xyP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66ba062-cdd7-46ca-c8fd-08dcb86b38c1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 12:03:03.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +B+LCLvtPJFFpcABrB+jQJXvJ0vbPyVWlt0pQr8CsO5vJNk6LENo/pXLoA68vkD+IGffX1jFF35FCn/Kqg1IEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10888

On Fri, Aug 02, 2024 at 04:57:33PM -0400, Frank Li wrote:
> Replace additionalProperties with unevaluatedProperties because it have
> allOf: $ref: ethernet-controller.yaml#.
> 
> Fixed below CHECK_DTBS warnings:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb:
>    fsl-mc@80c000000: dpmacs:ethernet@11: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks!

