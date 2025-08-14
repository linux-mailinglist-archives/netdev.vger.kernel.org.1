Return-Path: <netdev+bounces-213822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF392B26F57
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87390A01D94
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 18:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2B224B01;
	Thu, 14 Aug 2025 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qqo+pwFZ"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A861EEA55;
	Thu, 14 Aug 2025 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197423; cv=fail; b=bTqGBPlANeR1FLomLfYOpUM7ZnF6pRTNyvir1vAfSL5yHoALFWttQG5CkFiBk+HwrdPN6t1VxujPEZYQvYlp7RXnQmng6l4oWH3/NMZh1ZMlYi2/atxasqznkSTwnHbgsNox4fvKPEMgmlRWZ/StmZfqwS1bx9n5018SGPaPkbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197423; c=relaxed/simple;
	bh=Ae1kOGyO9K7DtXBC1LKlWHv8ziwYdwnWgTjm9L9Nzrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FvaxWQPVNaNYGfnLXYZKejPtlCWwCvtG4f/Cw5/8Ic6R669cmgMBNG1N2gzBDmVl2FPfkBPf9mE1/sskSJ0bEXSVbTTSl1fZWnMx6+oKyfXUOam5SO7j1hIG0vPkfOhwIHMdK5IZ/zqTO/du4l+WMDenJWgiUE6U/u1CCxVVIco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qqo+pwFZ; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr1bBqA5m5OzDneljxm16MrhyNquJ8w+oApW/k5MX+6luNeqxsjrPl/K8LftpfPD96kyZF3e4JI9KJ3QkFnpTIHIcFxIswIy3ubKFo1nJrvbaAaJdxpNKFDYBeZ7ghApQ+MroS/V0vzNR16JAtoHlAfaOcECudD4feOjuITIQkQ6k3mfh7IhMWPqu0VIuiUasIerI+kASy5syMpqqIqMZoautFaNa7M2K+gkagAfhcExqSpT9IrFYHC16z51BCDBQ3KoF+0gUzBhgSojnecYTBdkNsQhsfEfgBX66xO3G2J4gTP76omIfASOSID/Zh7cksbhhrC6Qy2vL5D9uzHqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diw+xqiQaFHHhce5G9v7s1sHIs4or+Qtv0dMN2VX2G4=;
 b=m7Ov8BgSsvYrFszSUOE3rGLYovKGl7Nw3+h6LzsW+POppeddwmYr2Xsz+PPC0gpKodmkS6WM0hto4/Y+5fdODFbCdEItUSafec2ufHPCkhXR7iF+Fq37j942Y4sYa3BBQDcuQ7OkPDkHi71q3X3YFZH9oncvMnUQ+a5gme9fsoGpeKdAFrwM/RQmeGTN/+BpQTyOSJ4nStCBiSuygNOSBgTj1cuSf9N4jFe7jFmYQgpiiZfnSv52bDrGX/6cCUZLl2xeUIiGnDqspCx+i8Tp0Z1hY42IrMBKnb5j4ypauMca4Yb7weMGh+IyA6e6KePPKKmYoRzchOqXSr9J4wytIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diw+xqiQaFHHhce5G9v7s1sHIs4or+Qtv0dMN2VX2G4=;
 b=Qqo+pwFZNZBmmkbiKr9rtQWhTQKR1XDLftSw2MzmJjvdYXwZFElbIJmrNOTj4GpB5P2xC8HdylbIkpqVpfZP0OBD/m2IykeQCWlyK2Aov1TnnJDoYd/BnXM0oUht41XPGsTLt8HN16Cnp85sx1vRmq6ZfguZ9J+OfqA6+whqTmrT9ObdT18mvUG9/vN61YAY1ySFM3JaRXWaPrlhCx/Z7P/5lqC6WpzD3rqpmas1S+W3czssAvPXkGWcbT/2StBgw+z+Jcr5iua0rz4x6DvvYxKQSuibV5XZOkkaGF7WoB2KNVakoHRD+4CEUHnqdvr5DGvWE+pJ17QZjjtA7Dvbjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7049.eurprd04.prod.outlook.com (2603:10a6:10:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 18:50:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:50:17 +0000
Date: Thu, 14 Aug 2025 14:50:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <aJ4v4D71OAaV3ZXy@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-2-wei.fang@nxp.com>
 <20250814-hospitable-hyrax-of-health-21eef3@kuoka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-hospitable-hyrax-of-health-21eef3@kuoka>
X-ClientProxiedBy: PH7P221CA0073.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 1627154d-d48f-4583-fcaa-08dddb636954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IhqeBD5nvqdDXwrkCT36IBeyT/2NHi4ewQwPPrf+UizOhBKnEdx04EhvndOG?=
 =?us-ascii?Q?UFu5699d4y7AfO33bRXhVZ7eM48UDksscmc+SQ3lNHOy5Zncf3E8GW6dzATB?=
 =?us-ascii?Q?ttUScDYPSC3kukmulzdC46RDKIH7Aou1YLs62f7MQ9qF3naCwQ8yCrX8NtO4?=
 =?us-ascii?Q?B/LFDpUqp/SaJfIgF7D2rBYynYiLeSkcw0yJsZ+wr7X3on4F00ARVffu9gsM?=
 =?us-ascii?Q?B0erQW0vAlUxs+XXVplRIXPZWmmW0kJ+qQaHnuJJy6Up76ke0wlCWMSXGF7H?=
 =?us-ascii?Q?k/LJm5t2QK9Q0qKqT6fFUcPw7UbarIQJNT2otgCNMmYSuQlD7kqOkGc5opnY?=
 =?us-ascii?Q?S1Wxx7N41yIdxN1pzAEXP1f5BDkxzijFIV4uPF1cpd79TfgooBfKaDN2EGxW?=
 =?us-ascii?Q?QLVcJ+6YUUaz89m2BXtF9JsJJF8nlBzWhBhdnUvvWVgoEGhBNtePCsW9JW5L?=
 =?us-ascii?Q?ePXvYkDm5LmzyR0HSPuaUPMvT7V6oYaUWgZtzNz4NKxvwBqLuW1uAo+uKeWA?=
 =?us-ascii?Q?TZT3Uk+bboObDybbqvE49KZPYx0ofrHL0LvUeiLtyKlg4ywCdt5CCE7afPGR?=
 =?us-ascii?Q?aalPXwRdKHxBS197b57Vp0VvQKqpZ7erMAAeuywpldNF/KRhdf4nWMtV0apo?=
 =?us-ascii?Q?MCxd65/hIgA6NrpYNEFgn/8JtAvBAzArL1yHIbuNnJIf7a083B1dDMdaCa3w?=
 =?us-ascii?Q?ABVGZLVD8XTGvYp1HMuBMdE0b92Ex8HzBm6xaALbHLc4918o5AbJYgJ1ifQw?=
 =?us-ascii?Q?3Q9HQvJ5LG1nsUt8P+qfVrg2OKxPC/1HXdh6b4OovtAHyIHNs4CtWI0k206i?=
 =?us-ascii?Q?KLwdS35sz7DXNAEWr3Y8qlULqVdXYgDwjOFA1yOwFP+vexNQclLRV3Zh8EOH?=
 =?us-ascii?Q?7rWJ0E/jGmr4BESMoQwaaJmJX5gCViHxXtJyYLy4kkAEvCwe3EDbeYZiHHq7?=
 =?us-ascii?Q?M+BwlcZSjIywENiBcNGDuo050EsJHcBMpMX4Nha4IG4ugvZQKAIb8cQTEhNa?=
 =?us-ascii?Q?t7kZOUbgXOkxI9lB5nGqIOVpFg4VDRYs7NgAgzGia9z0Q7CHE+fVE3YviTXZ?=
 =?us-ascii?Q?0NJ5BOVTxRNlDb5orToqViDyjeIjdS5pVMHZVM5pZPlgF0XJXGQj29MbNcK0?=
 =?us-ascii?Q?wLSQjGU4Ea6TCvsqMjQy4M8l4Nvsyo3AW9krN2703oxFl2UZZwbmGjB1FAzx?=
 =?us-ascii?Q?hDX/PH5Jp7e55AN8UyEjo06Uh+ixf1wiidB7r5TqGIHoouDEyaeHQS9X/Xb+?=
 =?us-ascii?Q?ieh0UDM4yPiiGL9QVjNADURXD4Y/U4iUEizc9qfCJOSfJpUF6Q9p2XrpjIyd?=
 =?us-ascii?Q?ghwC1CVvpOtL4ZTHzRFVVNJzhY1oJb3rp78pfJO9QeE20TkHOPwMIbKxVPBm?=
 =?us-ascii?Q?rAYbuWX7kJ99LKNrGrUEKoAAIV3twu+Et3DWsQnvDzUWlp8RHhY0+s+EDVpE?=
 =?us-ascii?Q?AiXE4nZcRqwvtgUpzPlrkx4X9r/Ym7eU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CNto/8SKTOwle5ciisoQAZn4cgFAaZeUDg8Zbwvp9ODZkALV3sHEvJ+9WcfH?=
 =?us-ascii?Q?iLqJBkQmPy3XY1YX15zZp9k98DKgGH1fn8HryBk1kf/WWeLNTrho6jLhEwCc?=
 =?us-ascii?Q?cJzHxv0pP4gJWrdV7HAyxNMijWBorE4jW+1CDfIznMg1zdFpIF48wPjY1eQC?=
 =?us-ascii?Q?XWYlCnTwGk7kHmBW/TbXs5y15NAGv6r9Nj3PO7EjEmm93skqNXrSNTb/OB5W?=
 =?us-ascii?Q?M/WvO+jLWXJir6sb8X/LgI51t2RLdMXEntcBsEyzRO5+YHzc1KBvxgKyXCNu?=
 =?us-ascii?Q?kgLGd61L7RxdW8NNmkSBkpIXlfsVtHZaS6Q/7TP8EhCTsj/OxHEFtSV2T3d/?=
 =?us-ascii?Q?EMnbFTd1R7Wm7Baqpt/Cg4lGucczojvk410agMiiyVkKflY/Ae1QygkhG6Z6?=
 =?us-ascii?Q?XqCtn1uxbjgclYqdM1WlSL/OYmxEmmlfOXFqs4cLBwHpzysQ7L59Xb9keR0M?=
 =?us-ascii?Q?7dlpWgJFCD8/Q4T+uSH69i1l49RFtRVamArN1t+QvUPnX2XkzK1kvVUnVFBi?=
 =?us-ascii?Q?PvQqKHncfe12FSwrtAQoWxeJxtLRzFKCV4vRtUmSGYY7emX+ZhL/cld1r1gL?=
 =?us-ascii?Q?vfwJlBcJRy4WPb6xkgCT2ft7vUcnqbb+urUyXFPzCzGmbhQYT1VECVWlSln7?=
 =?us-ascii?Q?/XMTbkzhUAgM076L2cfst2ctGqEHVx/toV7aeZ8m+Mkgt4HkUFH1dXGp2oaw?=
 =?us-ascii?Q?GbBPmQ+b4FDrWW7g9WSEBxlIj3c4PP+84fE43FU3OsBYyDouEWjwB2wxpWRz?=
 =?us-ascii?Q?pQHUmku/qkt034Ys1dwRNQyl5NdvM1Ul6FQUErMvLwW8E4M1mXtHu8EiUkdk?=
 =?us-ascii?Q?MwDR7GJT5ucEcxtxdMZ4Fw8lw4ODHPweGuN+rRK/5o/gldBJCEfQH1HAG/NB?=
 =?us-ascii?Q?FH4H93QoGeeGqFBaROg8SNe0Yju/Nsj1dOqRorGHETywOjhAvZejJsp0Dz3l?=
 =?us-ascii?Q?jgwKxy0sxdTiwZbf3NVn80hc8wigI0PFItjSBxw0HQATsKhqpTb6oZxKJQvQ?=
 =?us-ascii?Q?hndtXxEiqlyTGhhyepMZBhjazPOVvnwHegES3Hj0oL8EpDJDlRjD51SvFOFB?=
 =?us-ascii?Q?YliXxlseoUAQ31ivLqu1+e5Ly5ua8zvGTUGOnkJfDSSZKRvaGgo1nU02/knB?=
 =?us-ascii?Q?Sgp9ZDqUovMjIseds1qeq+MN89X+cAmhlO5mLH9vUQtrbclj3FEVR8Cnex8n?=
 =?us-ascii?Q?grFc7/2f4Kghzo9gX2fEKWk8w89YvbMPus6Dkb+DHQMGJYLYGk3rfLCMxyxz?=
 =?us-ascii?Q?RxJcKXoxxIu105jdpOw/cxQGfa6w/0m1oZ8ZGshrf7ynmfG0FFX06Uy17QSh?=
 =?us-ascii?Q?PiaOjZaRXhfABgwNGEk1TnDqOPHuATjafOGr43rIQRBeTKx5BoxQIBYdRsZW?=
 =?us-ascii?Q?CRGSKb4MSNfDsfXZdMUpCRd3tzw/OlO0mWnoInm/U2QNM6btQ55cc6tT6mnd?=
 =?us-ascii?Q?4ACBgZwqos/Qm5G9noZzg2Vw+O83tUEJNxvQzrITvEoz67tDlV/vaY/9HvQ9?=
 =?us-ascii?Q?UAfWiGJ0dM20oq2KmpbRyxrWZyhlghtvLRIsN0ycDN/FyltVaqY9/f8eJJOv?=
 =?us-ascii?Q?gLXUzwn1x4eEZDalB3YVcl42zqWmLoAlTFCLUC7c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1627154d-d48f-4583-fcaa-08dddb636954
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 18:50:17.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzyOZWc0A8Fvl+tIOCMqMtQiABGa+KXFT0d0wtQBYTh5ZSTbDSrkncvv04PxJBTcyRXsOHQezL0T304UrIUlow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7049

On Thu, Aug 14, 2025 at 10:25:14AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Aug 12, 2025 at 05:46:20PM +0800, Wei Fang wrote:
> > NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
> > Integrated Endpoint (RCiEP), the Timer is one of its functions which
> > provides current time with nanosecond resolution, precise periodic
> > pulse, pulse on timeout (alarm), and time capture on external pulse
> > support. And also supports time synchronization as required for IEEE
> > 1588 and IEEE 802.1AS-2020. So add device tree binding doc for the
> > PTP clock based on NETC Timer.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > ---
> > v2 changes:
> > 1. Refine the subject and the commit message
> > 2. Remove "nxp,pps-channel"
> > 3. Add description to "clocks" and "clock-names"
> > v3 changes:
> > 1. Remove the "system" clock from clock-names
> > ---
> >  .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> > new file mode 100644
> > index 000000000000..60fb2513fd76
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> > @@ -0,0 +1,63 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP NETC V4 Timer PTP clock
> > +
> > +description:
> > +  NETC V4 Timer provides current time with nanosecond resolution, precise
> > +  periodic pulse, pulse on timeout (alarm), and time capture on external
> > +  pulse support. And it supports time synchronization as required for
> > +  IEEE 1588 and IEEE 802.1AS-2020.
> > +
> > +maintainers:
> > +  - Wei Fang <wei.fang@nxp.com>
> > +  - Clark Wang <xiaoning.wang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - pci1131,ee02
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      The reference clock of NETC Timer, if not present, indicates that
> > +      the system clock of NETC IP is selected as the reference clock.
> > +
> > +  clock-names:
> > +    description:
> > +      The "ccm_timer" means the reference clock comes from CCM of SoC.
> > +      The "ext_1588" means the reference clock comes from external IO
> > +      pins.
> > +    enum:
> > +      - ccm_timer
>
> You should name here how the input pin is called, not the source. Pin is
> "ref"?
>
> > +      - ext_1588
>
> This should be just "ext"? We probably talked about this, but this feels
> like you describe one input in different ways.
>
> You will get the same questions in the future, if commit msg does not
> reflect previous talks.
>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-device.yaml
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    pcie {
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +
> > +        ethernet@18,0 {
>
> That's rather timer or ptp-timer or your binding is incorrect. Please
> describe COMPLETE device in your binding.

Krzysztof:

	I have question about "COMPLETE" here. For some MFD/syscon, I know
need descript all children nodes to make MFD/syscon complete.

	But here it is PCIe device.

pcie_4ca00000: pcie@4ca00000 {
	compatible = "pci-host-ecam-generic";
	...

	enetc_port0: ethernet@0,0 {
        	compatible = "fsl,imx95-enetc", "...";
		...

	ptp-timer@18,0 {
		compatible = "pci1131,ee02";
	}
};

	parent "pci-host-ecam-generic" is common pci binding, each children
is indepentant part.

	I am not sure how to decript COMPLETE device for PCI devices.

	Of course, we make complete example here, which include ptp-timer's
consumer nodes.

Frank

>
> > +            compatible = "pci1131,ee02";
> > +            reg = <0x00c000 0 0 0 0>;
>
> Best regards,
> Krzysztof
>

