Return-Path: <netdev+bounces-208146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 662FAB0A3C0
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 14:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9993756862E
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3362BEC24;
	Fri, 18 Jul 2025 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jxlFhBkZ"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E821B9C6;
	Fri, 18 Jul 2025 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752840073; cv=fail; b=l5fKdzmTFylzK18K2LBCOq8UOhflLA1yIhdkM/3O3wI1FFDJSr88verHEbzJrTlxk+DGh2YZAWwDGqSQQT47fQDLV9fxPBLoChT5+MVQEyfcqR3ad0jT67ROE7jG6IATsjUo0PE5QbcqZruAK0EqMfb+kBRl5oQoK4bosHRePyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752840073; c=relaxed/simple;
	bh=zF2cYnsTLWdxBUz47HuZiDCtAFUVhnnzuSadZ0GBW/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YpUAXOz06+Iot3SchT6uadNINFLl2k2rb/X+/pzMtYNots8pTQOwa0EO+ZQVdcmwu7TmIkLihTGCAlSWqOEIwqSZDZSxttA3V5yIitH893qrb1z8yUYl+Ool/6CvRX0KG7jETBmIM59eje0h941f14LOd1y/yOswXqpkHRfRbtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jxlFhBkZ; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGFjlVFY/RMy3gdENlhS9W6a8TxJ6u5Af8+SHkL6465Ph5kTpl9Adon2fx0HJQIxXLRNVovtH9NIAwl0rts6kjUdi6XZwCaJCK7LjuHXFkQB8w/GVjW9W5z5TVfLsDv+jEBjEynCb+uukJtmJGf5egmXZwoWYy/2N2qr6EKlFI8g/NN5o2SElK+lSXJSQKOjPugjID9L7d7Oo039+ABugBvciJlYgbFuqkwLuOg1TEiZGMvpS8My01V+qi8memZZEEtmgtkWTMqe5ksDv3rWzsGeRaQo8gMClEuAp5xxeIBIZ3gYBx+ZTd53x2JOk76Ah9e7BMz/hj13ALU9vUZVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1D2vUi+jIZbyTmTHfJgVwpilGDjkY/ynuD7Kh7kbQE=;
 b=o4cFusrHuC/xPOLwRLvZiZxuOwNgEEFcSX39mZzn3Fym/etN87qJ8l4opYju/DuRqFXvP4Y78MDE0sKQhWrfcIXqWJxIOykfUV+BGk+YjkPvMFDO1ze7g9YossoI8CBUxgjIqwOxKZJRbj7PDIZFBkr5OQsiu4DpBoyOOZqwY35iKb9M9bT+QPzcaHU/GGtZD3smxILjOzHKrFIJ626b/DQBDC5Gmc8C7UupSFSSGgJUsuWQEcdNTgtbi4jL3oKzDS6eEcKdYmm5iGphziKo4AwO38soziU5of6sgQde4n9wH/kQGKe4VW6+KZkJlun+boexUEFnb7pt+BLZYrthlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1D2vUi+jIZbyTmTHfJgVwpilGDjkY/ynuD7Kh7kbQE=;
 b=jxlFhBkZORVHFakzEGqgzBFeqU1mzn7eQqT0M0CdOKBMLylbjuun2ebIo/gEVE3MwdMomzBSiAtLczJ7TSjd46Up+6enAddiRHuhej7H6UfRnIroUuiHV7hUYQSq7mujoQYiyBeGIKQ3vy083NGEyjlhWpXcH3TxLLWAdtxdtrxAWBggZ3tQ2IUxEOzgb7xfIulP2ltHJYRspVLjOCNcbfb4w6+KrTFT+H2wsxPIDdsP06BhlFlhckDUacuJTlsSzVVQXAMIbZBbrlBxKxppamYSltyjbC+CGVF9RVBLKtRQ0xifGkDPLyMq/uLA+vE+03onYVYGuQbxVOETtlPXgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB8031.eurprd04.prod.outlook.com (2603:10a6:102:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Fri, 18 Jul
 2025 12:01:09 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%5]) with mapi id 15.20.8943.027; Fri, 18 Jul 2025
 12:01:08 +0000
Date: Fri, 18 Jul 2025 15:01:05 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>
Cc: Wei Fang <wei.fang@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
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
Subject: Re: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Message-ID: <20250718120105.b42gyo7ywj42fcw4@skbuf>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-3-wei.fang@nxp.com>
 <20250717-sceptical-quoll-of-protection-9c2104@kuoka>
 <PAXPR04MB8510EB38C3DCF5713C6AC5C48851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717-masterful-uppish-impala-b1d256@kuoka>
 <PAXPR04MB85109FE64C4FCAD6D46895428851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <af75073c-4ce8-44c1-9e48-b22902373e81@kernel.org>
 <PAXPR04MB8510426F58E3065B22943D8C8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250718-enchanted-cornflower-llama-f7baea@kuoka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-enchanted-cornflower-llama-f7baea@kuoka>
X-ClientProxiedBy: VI1PR06CA0198.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: ab42d7a7-e836-4490-70b9-08ddc5f2c815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|19092799006|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jmkhs+MX1uQiVJmqYyuH0f989ApqAIShv0jWflILfJA3IqZcQrelM6xiMHsG?=
 =?us-ascii?Q?S21GIEKiaY8b8Q0csvD6EVufDwTFim/vgi2/88SLkkUaIp26kI0RDhAnMJQw?=
 =?us-ascii?Q?nQWEKj17JF76PqbjsMtTahQuOwGMHzBwnuX6wfMoE1kSLHGQAwrNs7FCRt3D?=
 =?us-ascii?Q?1/PZn496lSy3NH8EPmZzuGgokG/aUvXC3o+HCJKJu8V0b2Tu127qtRMqXcgQ?=
 =?us-ascii?Q?JOqhlv4sB7sIIv2QfFuc5XatRwo8mDyL70wv3zfD3xwyewJVSbmE8VQe5bES?=
 =?us-ascii?Q?+VcDK5Jmt2w3pdYsgX6sKQ9/Byz9MTEl3fO6h4MeiJba4vuobK9U/kBttyV8?=
 =?us-ascii?Q?4+Un9O1Q8tC1P2xhGgtcnZ1fTlqoFW3tCgdD6Wj99HUD5mgzfB2r7yTAz2Md?=
 =?us-ascii?Q?qVAHCae09vO+ub3oCOcKE+IQQFS2Ij0hMYXUB9eGDjBF45DI+dAcKHavA+lX?=
 =?us-ascii?Q?vUVVFJ/Z8NYtZcpIRLoX9Fu83sBxa/66XAs3VJH4a8vSlH1ZkmEH6CyKhJ9q?=
 =?us-ascii?Q?9/6vXzVJkYlG6El7DAUJAol+4l4mNgu7s6DAHEVYE3Pv5r48XTeNS6PGjsQ2?=
 =?us-ascii?Q?TKB+PuGs6PgPRPiCICmv4hfc7ylXvz91ZeYBFuYSPDpw2uu/buxiMW19LjRA?=
 =?us-ascii?Q?fZxXG3pNZN3AdH4S3JKuKvBwEU7x4VbsONs9hHC6pbgkPRnsmgpr3zzyVHet?=
 =?us-ascii?Q?gqy5EksA2UCoZu6wcTINYmuXO3Nq6zsFJjtX8qy658oiWBBDt8/z5qv6ksts?=
 =?us-ascii?Q?mcyb7WFMNc4powlVkhpD2zb6hoX5FD6EM++LtuW/RAYLH7AMnIGZ3uhTlCpk?=
 =?us-ascii?Q?+2XUZu3GS5Zl+kyFduhx9g5GyLogq7DtdCmzRWEMThsJi5VsVlKvHAoTo9q2?=
 =?us-ascii?Q?SKW4+2Bx3LkigKrFAMhGuCXhRSDtDSNf/VlEoXIJU99l+Z7VtYkDkU4npOQp?=
 =?us-ascii?Q?dMdd63qIqUYENah311XaVmHdtQH6vZv+kj2SJWDy3qNGB76q17p8vm/EyitZ?=
 =?us-ascii?Q?XVB9jAiyMwTI+zQKGrvPgSAqKl9EicwSfIepMisRts1WUrUtVxZH69cUaidI?=
 =?us-ascii?Q?7WbVsw0PdIXXnQUwsT17rM8gI8esyVuWb01DdTElcTNcqPi4lZQXqSM+3O8l?=
 =?us-ascii?Q?qkn0I1nv7tu+eLeCvVJuUvhpIrUkQceLgXy9ijSUHhd/ok4uxliFF6qM/FKJ?=
 =?us-ascii?Q?yx4jEx5UqB33d4UelcEDN9K6P6nYmnUkDeRpsIeTofnQ/jeBTzAdcMD9K8wG?=
 =?us-ascii?Q?49os4DC2KurBmvYamp++IaBGQZeGR7fxp87QexizEc5Ai44GUjoemotJxn+o?=
 =?us-ascii?Q?ssH3P4/2Rh99VDDpY++60Px2VkwiF8Q3+SHKN6rROFbBMWuXqcH0eZCUdrPk?=
 =?us-ascii?Q?NACW6wHl1FWbHPOhvQBPH8n7AHnPHrl3/iUrrBtn+7n92PsnS5Xco4RsI0r7?=
 =?us-ascii?Q?1TWwZM2/T68=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(19092799006)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MhCUDB957yNSDWquS0iDRXuCxBb5Ab3uwfBwkhAhtjdJpYc/v0Ay9xVHcjFr?=
 =?us-ascii?Q?ZDAAYXg/VZHa2fCllMSrwQDsFIPlHbG+gP5kIKooV2FWXJrt33IgmgxPPsbH?=
 =?us-ascii?Q?zlH7c6SDOL7ZWvM09hCHvXMAI0IeCCU4kETj9a21LS+woXnHQzww+U+73Lri?=
 =?us-ascii?Q?jjxSNRE/4t17cIUYJk1KnoDM/XdHac9R4Ux6LY9BAyWdYm10vu/oWZ5JEqFG?=
 =?us-ascii?Q?vD/SjgkGB6ouhsBB1wlqoAhHa58n3aMlCDle1EMTXGYF/+gCYyoW75ANrNOC?=
 =?us-ascii?Q?JOwCOyxvw+0+Vl4SfajyP3fzwmqoBE80AVGxi23x5c8alW6xyDVdoczoWBY3?=
 =?us-ascii?Q?RuwG5whkaDu38p8Ag188uUHF945kU9yqm+ud+Cz9im02TiAKkIp0qnsA6onC?=
 =?us-ascii?Q?oviRbqS5dX5PT8Mhyh20b+5+L6/wJgzkKEfVThn1VeG8DGPPu0OGIvzGY+jX?=
 =?us-ascii?Q?vnvErTH3czK7Kka5elIah3ngdEh2P4q6XZMABDOsn1Kzghk+xUT3G6vBF6XD?=
 =?us-ascii?Q?4xu4SVlJuVrFUS8HKXlja90RjzVtMvhGpOi7lcoCkmHbN89392Efqka8nMor?=
 =?us-ascii?Q?HYzwEqWH6w9Gj/DharRjqsngtPqh1H4i8vdoD7JVG3U3yanZCZ29dxC/dUZ1?=
 =?us-ascii?Q?eqeSNHsvJ5O9c2dxCwDzaem4Vs6HGfJ2sJZ3sZOKjZtUCEUR4EoxTe8Z6vIO?=
 =?us-ascii?Q?CyXLdyZSktesrUcey3rLmYwx4dWf7/+LQV95+z0PnQ0UCeYsflFvne9vGz2l?=
 =?us-ascii?Q?8qR0f+Dg/Ta6U8YVpsTOAY/bb318hoZxBQp+c643Npub/iWOm52stEi9+Cn3?=
 =?us-ascii?Q?7d8XkWO1YtYbf3zgW8YYwrEJJ+X1hr56dICozb5eNsS9oTE3/ozbgsu0240W?=
 =?us-ascii?Q?VpuHwKTMjmIEQqGV+V2AnfWy2f3Z3kGutC4JPDD3MdSEO1WYfvxOsqngwYj8?=
 =?us-ascii?Q?Bky313LFHXZYnnQ4llDeSJmO0Dc4mBAZgjN7f/F5T8VhV18A9wAVCeCi1scz?=
 =?us-ascii?Q?5Lr++WwMZZTjCqZ/3t++sLfRFgXIMaieKQ9NY5NM+Liw1cf8tEt/CLJwZ5c/?=
 =?us-ascii?Q?13hSW8PqAzQsOQH9tp0nZQnbXa2rCErEE89Urr+ITHMx5oYnlN1M9BpDVnsB?=
 =?us-ascii?Q?wwAOcYQHi+qCK1gDmdpPRWyTnXiWhgzlCGjbfz1HgZzHkl1GepAZAJrcEFPD?=
 =?us-ascii?Q?MmPkEFoPUekP12W70DozBGQATkPHjOZbpA7vENE+gSuBhp2TZMxiEM3W9PqW?=
 =?us-ascii?Q?RA9f34J62q2koJl07BYHGbBG7D6wXeRP+qLP6mhKUtd8SiYzx/eQYfrqGhXc?=
 =?us-ascii?Q?PRaDpqS+/fTddyVP6mucHVo9DqlylCCJPbDQBb3ckilNyrTRW02dGR2QubhY?=
 =?us-ascii?Q?Z3xEIO8Z3pGMshhTxELCWNyNfrkCfr+T+AUo3XD79UVmpssU53ppI4VPOCsk?=
 =?us-ascii?Q?Jtf9MIjONFU4aGU2vem2fpgRgvsMlJ8xV77wclon59/oguOhgCUGx09Azbti?=
 =?us-ascii?Q?lVV5p/r1/sHFazLkPT9FculoFunGjFqt85K0l0oRrO57QwLlNvJaPEqE7tOZ?=
 =?us-ascii?Q?X6Srnj6C0xnd3i8WQuri2d/qsgnK/YMlVxJdQ7+u6AfWdY01NTg8vO2f/khz?=
 =?us-ascii?Q?Pt9w7Fet7ZCdhQI4RlRZkuijneElOGyooQe7eqjOjol3+qniOqy8b0L2uKEw?=
 =?us-ascii?Q?hDcAkg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab42d7a7-e836-4490-70b9-08ddc5f2c815
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:01:08.8578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6pzMWz3n2zhSzyYehkYed+FJviZB0jkltgiVmUGiu24PvxGfP1XzXxaOwtspECLQ+2RT27LJwKN/kU7YdOSjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8031

On Fri, Jul 18, 2025 at 09:46:14AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Jul 17, 2025 at 10:26:28AM +0000, Wei Fang wrote:
> > > > timestamper:	provides control node reference and
> > > > 			the port channel within the IP core
> > > >
> > > > The "timestamper" property lives in a phy node and links a time
> > > > stamping channel from the controller device to that phy's MII bus.
> > > >
> > > > But for NETC, we only need the node parameter, and this property is
> > > > added to the MAC node.
> > > 
> > > I think we do not understand each other. I ask if this is the
> > > timestamper and you explain about arguments of the phandle. The
> > > arguments are not relevant.
> > > 
> > > What is this purpose/role/function of the timer device?
> > 
> > The timer device provides PHC with nanosecond resolution, so the
> > ptp_netc driver provides interfaces to adjust the PHC, and this PHC
> > is used by the ENETC device, so that the ENECT can capture the
> > timestamp of the packets.
> > 
> > > 
> > > What is the purpose of this new property in the binding here?
> > > 
> > 
> > This property is to allow the ENETC to find the timer device that is
> > physically bound to it. so that ENETC can perform PTP synchronization
> > with other network devices.
> 
> 
> Looks exactly how existing timestamper property is described.
> 
> If this is not timestamper then probably someone with better domain
> knowledge should explain it clearly, so I will understand why it is not
> timestamper and what is the timestamper property. Then you should think
> if you need new generic binding for it, IOW, whether this is typical
> problem you solve here or not, and add such binding if needed.
> 
> Maybe there is another property describing a time provider in the
> kernel or dtschema. Please look for it. This all looks like you are
> implementing typical use case in non-typical, but vendor-like, way.
> 
> Best regards,
> Krzysztof

An MII timestamper and a PTP clock (as integrated in a MAC or a PHY) are
similar but have some notable differences.

A timestamper is an external device with a free-running counter, which
sniffs the MII bus between the MAC and the PHY, and provides timestamps
when the first octet of a packet hits the wire.

A PTP clock is also a high precision counter, which can be free-running
or it can be precisely adjusted. It does not have packet timestamping
capabilities itself, instead the Ethernet MAC can snapshot this counter
when it places the first octet of a packet on the MII bus. PTP clocks
frequently have other auxiliary functions, like emitting external
signals based on the internal time, or snapshotting external signals.

The timestamper is not required to have these functions. In fact, I am
looking at ptp_ines.c, the only non-PHY MII timestamper supported by the
kernel, and I am noting the fact that it does not call ptp_clock_register()
at all, presumably because it has no controllable PTP clock to speak of.

That being said, my understanding is based on analyzing the public code
available to me, and I do not have practical experience with MII bus
snooping devices, so if Richard could chime in, it would be great.

I am also in favor of using the "ptp-timer" phandle to describe the link
between the MAC and the internal PTP clock that will be snapshot when
taking packet timestamps. The fman-dtsec.yaml schema also uses it for an
identical purpose.

