Return-Path: <netdev+bounces-207785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5B9B088E7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDB43B9931
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DBF288514;
	Thu, 17 Jul 2025 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fiJx30+s"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012061.outbound.protection.outlook.com [52.101.71.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1419235C17;
	Thu, 17 Jul 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743156; cv=fail; b=O3O7riSrSIgstMhTrXz8HHAyy9HU+r4Fl/4K6a5c/IYyT93mMHJjxb0Jilpd2YzXpJwBS3GtsnBePc+Yidj5K5yNP9HrdXKMTNCDDKMGgCdPk1/L+NcdD5Om197mhEoOis2SfXVAQoqqgW797vWKEp01u08LyPCB3/dk/mkBU/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743156; c=relaxed/simple;
	bh=WnrKxwijfiapAriwK41dqq3Ohkcm6dB8PnqnOhr+KEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iiFqJD5BFHiDcLtrhAu8BNcwB3Ugp+lD62xe8loXIfUVFdp1/S16ZK1NS2LSJVjK+M+1aGiZef7N3uPaYbfnEPPKkJtNHSgVKhllpqwjHabFZqmTKOngUNwqT/oMnVooJ5nGxZjNbJk7lCtLudn5SxmfCeYrIV83KjdiYCxziwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fiJx30+s; arc=fail smtp.client-ip=52.101.71.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAv/9hJ4uQNo5YluPKMAA6x3rQ+s+cF47u1KVe5QzKnohqpuLuEF/mUwbByngU9i0xbR0CL4YjSjVHaF5+hqs7aIxwb35FeZ1acS6OPzPX5IMi/Okym63kflt5xF5/UpkUgYaLA56y1BL6Um19uFNNJEpj4wxUDsVoI/8+COjzY+iq8vfT8hJ1oVLGZ+GdipUyB0AcIbqUh9uulucCd4S132ctRUhvfv/zIiDi8/CZ9brjHm+WsG46tQGUynIOBHAwSRqJi+ah/zWDNyNTmn+kmKc53Qak3SCklu8f+Jv73kilf9jkh1g9ZhqJPo5ydGPvLMmRF8P9fRGdyuNxJHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q5z483hDT5+a+8mYxpLghn98rGIXxWFAcHAvmHyNwQ=;
 b=VqzzjJY1h9mVdDM58sF61L32mP7KfG/OnLHLYyyWzfAHnHtw5MVx8BxjIvGc9A/X3OVV0QbmUx6puI4Nv7ORFwcWEHA3D1Un7NXW0pZUndl976CFLqhpGN/v00IJ64aYKNLO+56OyNVrXstWPDSxkxrL9eBcLAXoJYACks93lW70PsocSAYrd9GCW22mCXNnIWRnt3B9A379EQG2UNm7fYWfXiw1hJGR4/XUASzLiqdmJgq4GzLRYyaoZRpeXVECn5d6jpKBxMb78yRNF0Nt/7XZ5Nj7i+ncJLDwxUnCbRdy6+sbst8CibRk5PuN/WcaBiRLQklBFl2mGU+3YOXNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q5z483hDT5+a+8mYxpLghn98rGIXxWFAcHAvmHyNwQ=;
 b=fiJx30+sYshrN9pK9feTWtcxpMVhqL155+b8tfcRzVdTl5O2UE37Snq+AKsFJKyYRhyFBHWXr4Pa5mu4guA2HM1+ZvYnV+RACyBRxkdFQcozyEdkIGwOTr0+t9h0GB49yko9xIJY+L7KbrnvUyArUMd6fzuEPuxei4Gu2tM8UqA+xCHpDiN4f4g5ngiKoRaf1ehGi754L348SripVTFZb3YSKo5cTntJq2qfNWWOMD3AfDbONBZZcDL+tab+v4DZIDmlW2JImhm4v0ZWDUwCyAkZy3tv1mx5CYSOXlf/DPUS0ZcSBTagolRmcBd5GyOpI7QRwRulgiJrbQWOBxfbaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DU2PR04MB9065.eurprd04.prod.outlook.com (2603:10a6:10:2f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 09:05:50 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 09:05:50 +0000
Date: Thu, 17 Jul 2025 12:05:47 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	Frank Li <frank.li@nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <20250717090547.f5c46ehp5rzey26b@skbuf>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-2-wei.fang@nxp.com>
 <20250717-furry-hummingbird-of-growth-4f5f1d@kuoka>
 <PAXPR04MB8510F642E509E915B85062318851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510F642E509E915B85062318851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR06CA0191.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::48) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DU2PR04MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b150caf-53aa-4741-75aa-08ddc511205a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jiqy+REV8jFABrD1gRmKR98bzPMrx4YhVMG8WvwwiIeKcS+xiraknAyxp3u8?=
 =?us-ascii?Q?seikPJTC2WX5d7DMCBA6c+62kaVK9eboTQ5h06mD3cvgjRUEMv6W30xKJ8I4?=
 =?us-ascii?Q?ThSYFG9YdIQCE4dJesFQd+xqPOxsxotouycLObRK95dXW6egsLHsEK48WTrv?=
 =?us-ascii?Q?dbGD4b2OHehpHlBoa/TXYTjx1ROCu25vSR+VVnCvP3NZjBdP2GU8lS0yFxu4?=
 =?us-ascii?Q?aN1HzEmF6Vd8SwTRdAL7XZrAJNb29M8OriaxcT6SE2aOh4WjFqmv2RkPuxsG?=
 =?us-ascii?Q?DhenbzAeZyHc/3+OdEoqYJ5R5dEbVjpVX1Sw3wd9K8W+PO3s3uljqk0lk1w3?=
 =?us-ascii?Q?f0I+U5GwOO2W+vpWf/3bVAN0+dRIwWfI3eLkcEKE8SXNNw5M0t4EaWbRbyBZ?=
 =?us-ascii?Q?NhOBzCGVWdGJUI5cz5GeXNQPkD/Fv7r3LARN9T7V8w1+TEPKJSVUWr3tnTjP?=
 =?us-ascii?Q?NCI7wbkvJLUYVJyQ9SWRiX9jywZYb0mQGH9xD2uDrp1im18AfM6y0OHgw6cK?=
 =?us-ascii?Q?gPOpq7wp2Suzi96vdhEkUy+7uuIDgmZ7NCXQmsicrbsdYigPy/THshJaq76j?=
 =?us-ascii?Q?0NsL8ioYaIDSWLpnA4lvJQN76eb626+Q+U69V03nY4YmDECVRyRxm1jeIxzH?=
 =?us-ascii?Q?zkX6KH4ggDJUNTFcgGzwFwe2JhOyTPhhEwwysqBi7lxwH2uaVLJwG6tSTKAz?=
 =?us-ascii?Q?rhA+PBZbE9ubG9RP4MolVjft7ADg5Q+B+oTK6Of2Vl2aQ3kasvlmKWnIqxkB?=
 =?us-ascii?Q?GaXBq95B8Gu4yzaa9BOHsFwZ8y5eAm82B33TDp/qo7vQ2gEbWSR7aUXL1FWb?=
 =?us-ascii?Q?UzdZGfDC/owSTU19UdQMibZ0+fcBIDsTdx68XXqGGpuH9sDgsBeHVEDKxKoS?=
 =?us-ascii?Q?5MKvf4Q0WVgXXUTBPktkpGm/u2AFrTA9nesxElY3E/+h4hIPdm7yVb3YUxk1?=
 =?us-ascii?Q?c0tzmPAO/qa2zNcXs4Sr8Ilp8ImEg4Ll9t4f2qELh3yERiU/mzZzPKwaNCSl?=
 =?us-ascii?Q?EPL4OsQ0+PewQ4dCXrdR1EQInWtvBPBfASsfgtkC05239+bxrO9ctYx1++6U?=
 =?us-ascii?Q?fddgLoGGJFCSzrIHVZz+y8ZNT3UkDvTWiYZPFuvTnLLfcPi1EvNsP5u9Ndas?=
 =?us-ascii?Q?ebhV7c854Z2jQckJrX9/Zk+N7ZnGrhrXez3XxZKDmZ/UQhraIWc45XfxLe9o?=
 =?us-ascii?Q?oFFiwIGN+3CD8YgacqzYmxh0PCEHwCvFvsUjkdrPaQPvkBE9vIYc6XD5NBjV?=
 =?us-ascii?Q?pvRbqwGVl6X3kGTuDOjg+wFXZ2jZ1L4Mx7fMusVLv5NMyf34IpJxDDcw7QOQ?=
 =?us-ascii?Q?UdkehZfOECOwuy2gTy7KtJsKN0urxUbW6Ot0cX9vNTA+sbnbMToW6I/E+gzH?=
 =?us-ascii?Q?FvuJmIok52n5QNkq6fFIyJjlwPRtUCApLss58ZH3UxRJDXc4eR1cuxmBUXrj?=
 =?us-ascii?Q?NrVPEXlypKw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gpJADPyyED/e4YjZG5Xi6NLLHcdNa2n/SXACF50i8dWylAWMtgVIr1Cfi6KT?=
 =?us-ascii?Q?/B31Gd19D8UMFCWa27RQ3ImGeWoC7jD7gKDaC4GEf9MdS/DzaCLVZa9DFgi+?=
 =?us-ascii?Q?Dfpm1F1q16Z19bPOn2l5oFimNGCWP9gA9dwtMy5f2iNusRspi6Dx97cCcf2g?=
 =?us-ascii?Q?niJKpoUgMaQAj1cj/1JXzu8u00MiTGdVo7XllaUT2wbruKqDNmwGjxS0PI2D?=
 =?us-ascii?Q?C0P6AHp9ENWiYdtgP6ARdrFAf3BQZn9110Z/UXqRBq4KYet2e31d+xKAmdXF?=
 =?us-ascii?Q?wSQcGZkm9aTYoCtlMuS7RRMXbQiBftiS2e0SFDrWF0ntmsz/lOF/kxOg55cd?=
 =?us-ascii?Q?ZTlUQydRxRD0otN5vK2OIiWg8nDCDZK4cayDrUzxRKdMaAOKHmrbnFSlJfVy?=
 =?us-ascii?Q?p3QyE7S+Suj0ksUdrXXsglIVfbwDDbTj3Qps9CvjvJRnzdxvw9Wa4kZB8eiv?=
 =?us-ascii?Q?zZBYjm8lsttQ7ClrFXLOmvA3APCLjEze1qMIwfaby5PUklpyuqsrYsKfH3Kw?=
 =?us-ascii?Q?qk/xonrTLdncyCKUnOKkVOPEMedEwCEjadao9/+Qr9O32xsJA5+4RPv1c9FT?=
 =?us-ascii?Q?IPGjbYZ4jEETy//7yk0ow4XoNskgE2D411wnQKMFW1Qz0KMNfC6EHFXDOOPR?=
 =?us-ascii?Q?5lnwMpRVLyZ08RLkiSbkNptbVn/pfdiwQzKpo095YYgpCZzB4iepwYpITilv?=
 =?us-ascii?Q?IFKk5NxNPLQ3oyf6j1WJ6K4k9viLdkA4yL1yD59hcB1HF0NuegjjWbjlJYVk?=
 =?us-ascii?Q?/6MEilJcr2VvHFp0sTPg5SQM9D8b3sAMQ2MpW0klblnmPAYJxyHbbAaI06po?=
 =?us-ascii?Q?yUfixZ6d10bgo/ihhYW/p4tkjwGLbeConaIO2KB7M7+DfZn5hZhwxI+J7qgx?=
 =?us-ascii?Q?SlqOPZogAklcJe8METAeuRDMAL+IPqAcoTJ/x8oYEtZdFLKqUHazRfNkrc9p?=
 =?us-ascii?Q?8rmqzNDk7OdY8DbuZzW4MIWTw4QIUSouL/inVxJgyFakJLcflP1PnWmYPXlr?=
 =?us-ascii?Q?Z5tOIf71XaWB3xHvwpZukEhJS5iEW7iSSAHphvg4vUppkRR9w0Dbifw0Kw/w?=
 =?us-ascii?Q?9o1Ui3uDoB2r3Epl6JoVZu72nF4Z/IIoqUaWT4G9W91OdcUFWKOOJ2+7ZhS0?=
 =?us-ascii?Q?ErncXSzwIa9d+blK0ycpyiP/fcZe1kChSC24A78TjEWCxz2yziV4XEJGCrOa?=
 =?us-ascii?Q?lRUhbyYzd/yUTuvMl+FuTfKrTrXYFYDFeDt0c8TAOiDN84/cdlBM0ShhzZKz?=
 =?us-ascii?Q?HYWN8z4vPciOae3/yrHKY+Bl0UIPP+tZD0cqTIH8Yict35o31+/k+gWBjOhi?=
 =?us-ascii?Q?1bJVV3sr9tOhEIQCTayAZ3KsyXPxXVj9vzYF2Dcj0goy6FQrJN/CTX3/jWJr?=
 =?us-ascii?Q?3Om+O1sxvn+DCLfP8JNYTkOlyvimpv/uQC7ebN6TADyHwcpCH2yvTRDsLltD?=
 =?us-ascii?Q?fjHwx+jPdkNOgpR1Xbl9nyIXfslqvrKuSzuiuufHdkdOnUA4ZUHXSh5DJk9b?=
 =?us-ascii?Q?F3ZjbRsX+opDjNPF8U+jI7VOXiiTUdBE169NB+YIYDeTN4vCH0SpOo+lTgrt?=
 =?us-ascii?Q?degnDAVnpPoJ0XOKfGkYroVDY7NvfKlaoOO1pHGCFqg4u49d07fBxWaDRv4Y?=
 =?us-ascii?Q?sHf+M807EoL7saqOc5amNr3TUGGtLa9KCZ9+HeYIayZHRn08YGCF15NSUE2q?=
 =?us-ascii?Q?9enlZA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b150caf-53aa-4741-75aa-08ddc511205a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 09:05:50.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+Hr5mrYDqIzdtz7qFKBotTW6eYRqEOJ3TC0WC7kr5dRQp0yCit+XlIY/5OzNDnIPtQT/pDkOc7Vb8r216pc0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9065

On Thu, Jul 17, 2025 at 11:30:14AM +0300, Wei Fang wrote:
> > On Wed, Jul 16, 2025 at 03:30:58PM +0800, Wei Fang wrote:
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - pci1131,ee02
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +    description:
> > > +      The reference clock of NETC Timer, if not present, indicates that
> > > +      the system clock of NETC IP is selected as the reference clock.
> > 
> > If not present...
> > 
> > > +
> > > +  clock-names:
> > 
> > ... this also is not present...
> > 
> > > +    description:
> > > +      NETC Timer has three reference clock sources, set TMR_CTRL[CK_SEL]
> > > +      by parsing clock name to select one of them as the reference clock.
> > > +      The "system" means that the system clock of NETC IP is used as the
> > > +      reference clock.
> > > +      The "ccm_timer" means another clock from CCM as the reference clock.
> > > +      The "ext_1588" means the reference clock comes from external IO pins.
> > > +    enum:
> > > +      - system
> > 
> > So what does system mean?
> > 
> 
> "system" is the system clock of the NETC subsystem, we can explicitly specify
> this clock as the PTP reference clock of the Timer in the DT node. Or do not
> add clock properties to the DT node, it implicitly indicates that the reference
> clock of the Timer is the "system" clock.

It's unusual to name the clock after the source rather than after the
destination. When "clock-names" takes any of the above 3 values, it's
still the same single IP clock, just taken from 3 different sources.

I see you need to update TMR_CTRL[CK_SEL] depending on where the IP
clock is sourced from. You use the "clock-names" for that. Whereas the
very similar ptp-qoriq uses a separate "fsl,cksel" property. Was that
not an acceptable solution, do we need a new way of achieving the same
thing?

Also, why are "clocks" and "clock-names" not required properties? The
Linux implementation fails probing if they are absent.

