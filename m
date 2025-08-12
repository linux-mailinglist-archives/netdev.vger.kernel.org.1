Return-Path: <netdev+bounces-212967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD34B22AD1
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E67174FF3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3682EBB89;
	Tue, 12 Aug 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Coj8Sc6E"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8A2C08C1;
	Tue, 12 Aug 2025 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009407; cv=fail; b=WixS+7Ijlktu2DKIQY7sz49b07ZGkHHvXtiQT+EpJMVVmcv2T6vMnKsCWPwOUoNt3trojz00ZPfNBgq2Gw2PPLheHpmXWdSuCwCAwaJKW/tRHgmMd46zCYVC1UeaZIucMwJ8AXwE8D2XXYYskyRe9RCN4tloC7VmHvxL8dCyM5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009407; c=relaxed/simple;
	bh=c0V+R4oTKCG1MVh18FaKevGgM+b0/6CypzakAzIvOTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KH6TztoiLcNOhnMD//rxazKUgISNpZSKflTFUgZFe3i4hIIqgROu30WRRIiXapdHzroHAbNSaTij5BUoQfTG0iSJW/DDbhMrT/MSm8h44XT+EIQed/7r4xTR+DkR6Z1waGMDgjReZUNigJWRPbNiQRlwlaaS2HvDUjK3DxjCn54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Coj8Sc6E; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K07wfdWRVrZ0T0YegTSKU/KVnecfhKvIatK7U19j8Ci6/xX7dO8VofrWFaDLzdQjX+qdi/6k/TfFTfpicsE6vNrUqVNKroQ8w0yBrDzadlVMd742WeywKsoIRn5pPNt2VCaOkod9FRQI2CZp1l7gZCMWCOvbKkvUlbE/BRkD+nykseaN+z1zimLeGd4RxbfFzo9fCazCiL8sGzzJd/lUW/2tFw5j8uJdKlHlCqGIAOadysqtI7D9i6jvRAdIPFyJSmNxhwTETLPLsp/+n5aaCoXPwSpQnNEOSqHhSa8KLAGYqoZ85FCx0cNkouLfDROGgjNgz8kotiQWc+s3i2E35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+y9RTYuY9+HJ1OQMrtQ/8NDGx8/hPbs4VVFG12uRxyw=;
 b=IqzGXilPSDY5TLMmuBPdGguKvsrS3hg8/wdGDhouK+10cjMWOb6f12PSaYrb8yNGeQTTp3CZ1X/k0mTdnvv2cE6OzeG/bW5hDQ/AmTJyz6ZuQijPbrAeCz773+MYbvsjwa2KXuFALmLdMVNHpvFvXcpD2ocY+20A4Iu0JX6jqg2IeQXC8tKIacZZMQQ/T/ENaPNfAjEdwmdIDkSgts4MtwkLkWAdhR4qLaownnn4evaMiti9IsD5yX5n8c/HJqjojJSRi+Qss249fYKZO73QIpa5YxvOWa6XvgoYAonhG77Lhn8OqTIMP9bbOThDhA24g3CVAsddj2IA45MYfOpMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y9RTYuY9+HJ1OQMrtQ/8NDGx8/hPbs4VVFG12uRxyw=;
 b=Coj8Sc6Ed1ljfRXIkTGy5VrpoUrHJMDqfTcIR69BQCE1/Y/a3vv3YKKIxgeA0OCXGhYjZEZtLXsso8FPR8nsWIXelncvRV3FLP6LTGhkn8GwDf+8gpuhlAZvPM3H6Fv6IIyqrXunmMI6xya4121ng8mazRd7GAdqCowAi3mllod8L8KMfiljSe6XpjUA9wv68X8uE1izh4AvWVnpiAd836s4qidxeSLok0fL/FRDly+Jhe/IYFNw9iwf7+6VwVJzTZHe8sEDhiMaAdHFzmIse1NqCB2Sw/nmWJ8lFbi9SljZoRNvlaS1+DqKbhRmhH+VmfdWtkrNzJip/Fm1UbzzgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 14:36:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 14:36:42 +0000
Date: Tue, 12 Aug 2025 10:36:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <aJtRbhlX3nGQOOki@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-2-wei.fang@nxp.com>
X-ClientProxiedBy: PH7P221CA0063.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 751e0484-2d2d-4c56-f60b-08ddd9ada75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fhkfiBCNqGNNNAi2eY74ag91PCYW9XLRDJ5D94bKZsWDLsJLweT1CnqZwUJv?=
 =?us-ascii?Q?pmzlAvfC6QFa8l/9JIT6w2DvPNc2nmFvDpBh1CNlSldaJvxnxbBDjDbXo0fX?=
 =?us-ascii?Q?/0IF2ZOykfdvwuBRij1K9yz+xZ99xNrE0fA+HhKZaT6bKKKxAQJt3dQQbdy/?=
 =?us-ascii?Q?QsUf0kr5SkOyXsVlFB9HzqtqZEkemVDrayULGHlNXWkfPxO7Hv6dDmpRL7qI?=
 =?us-ascii?Q?pOdUOJPa9WYPSGQiC90m6ty3fSqiNMLlKjM+exY0Q6Q7HkY6ljzOvUYIjzLk?=
 =?us-ascii?Q?52UvDLhoqvx0fbBEUQfnZYxRBxzGgL71CTS5zIG/19gnMM4vV825y4TLo6im?=
 =?us-ascii?Q?eLZbuH8Ecq08gwTagb5M/K6uyLT3yAOSIiSqnS9hvf9Otj1sN4X4AWOp8GJ3?=
 =?us-ascii?Q?t7aX2I5bnDp5UyrH83kKRtwTUTbG8a2FracDNWtDMYSSdrTXP7L0oMMLWPkY?=
 =?us-ascii?Q?jZxKCXPGkrb4wWvaE0wREyKxvGxu+8gpK0it9BROJAffZeqwdCN3BvW48AjO?=
 =?us-ascii?Q?BI2Xo+F+zvAmTWZLm5L9Z9WQqiwGSNTrgX3W8J/FotfaVPHgL7ed19LbokJz?=
 =?us-ascii?Q?a8bN/dBGEqgXG/mp8/nltyvaDafYsetNwx1TJi0NgCwN4bZq4TAxEIFG9abX?=
 =?us-ascii?Q?IIkCcSj90kPatiaRVbg7FcBwgqVuzw87Kl21yBxFqXvNWCXGUZrda/6h1+yR?=
 =?us-ascii?Q?mwSFGTvuRPcKYp9JcxCLDaSskWr4Lv7WbrxTBJx43zYSG2SqVCTmqPHcMUXm?=
 =?us-ascii?Q?D3Zhsf2WC37kRf3PHukhFOE+1ZWaRgUS87zx05pMQfqNXNrGseaYCPWbm/WM?=
 =?us-ascii?Q?pMPH3JVTzmO42Ds+aWf0QJMmo/bSgK87WhaJz8udSBBe+Ps27EqKsfUVETLb?=
 =?us-ascii?Q?uBzVaf34SIP2l7Szro2lP6edFswkUoKQB9PhiuBItSiS+RcYH2yOVD5Wh2JP?=
 =?us-ascii?Q?upJapOB1YulJEnvlgQ5OXWriJJ9bEA5xE41Y2aRVSgWEUrV+A2YGFW5vijRG?=
 =?us-ascii?Q?cblD9aioYCYrVHFS51qEvby9bZOEbzD0WI6uRNjhHbx1bfviPbOt5LZrf9/+?=
 =?us-ascii?Q?495AE550nY7bVW7aYl6//1oYDgrgn1as8iYrYKNhNoLx+gkNVpDfrrlenzmM?=
 =?us-ascii?Q?x/xsN+qyfp53RXVTXP3MvAMwUWJdGCUk2l3mltzBJdp5NdkYGRqp+uiOQk6G?=
 =?us-ascii?Q?ejk5coxaGWeiK8NJW5QjFSlqQcVAeEkLDlnYX9ar12PyLd6EXHX+mjTBQoLK?=
 =?us-ascii?Q?ZNA7e9JW91RzxD14Ds0DirXcglx7aC9259MN+Kw2MkNjb3m22zQ3ByFpxnIg?=
 =?us-ascii?Q?TcXwvJNc8MvGifH/rK6xenQM7aGKms9nFUvuZ1Ww05TErj/mX7m/ukNpw6cB?=
 =?us-ascii?Q?Skx0gaL/FRyBZDdR2z2Jfnnrrt7mFl2yBvoQCcQyGTlWL6J0Ub8qifg2rpLu?=
 =?us-ascii?Q?C/qjKeetqir3aec0WVHZ3mZxX2ZwzwwX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KDQu3fvkE3seZWV43W6d0AK+0c0Atku21X9LWC6sfOqQVCLg5yBpeZGLNv9j?=
 =?us-ascii?Q?vlpwFQOFatFqTntzTZOcqv7kDGonheTzhEXQhN1XLs6YIboqweqM5Z/VzDMQ?=
 =?us-ascii?Q?YT7tHb1SP9R8edE3d0LbLzmyaWLpbnm30X78ExVh4f2FOsDgH9620f1MQn5d?=
 =?us-ascii?Q?7LT8U7G+RoOCBvnJKAOwDvK1nsXE5MbRbQtn2af4iftH2buhX42XDL8K0tkb?=
 =?us-ascii?Q?npt59P+Ng2yaKKT+eU7NZwso7R4kKGm/MGZbjS9E2B9AbwX2mO1K00F8Dc7+?=
 =?us-ascii?Q?OInTgahr3tQq/1coi9qnxR3kjkzhf62viGhaXqNYpSeCNFEwV+TdBBNWOd8d?=
 =?us-ascii?Q?/PRKIIl083B0ZPBKNyQEHk//SqMEPPnpd9KxdDQnu1Urh58Z1MFtmd4rMYXN?=
 =?us-ascii?Q?GokWpk9lavPnKO//2EnJn2biZBnKup8SenyxsLBCIKxzk0GzRoAsokoBK3El?=
 =?us-ascii?Q?sQaTIg/zVPJGZufNQuTDbx/xiFEAlCqKY6tgH/BpyVnh5AVt1eR55FD7Imba?=
 =?us-ascii?Q?Hjc2ff2F7rbCKXTiLicRJg6JMLiQ+7o8eeffvBfVpn7v7s0cibPIvRmBhhRO?=
 =?us-ascii?Q?RHiUsH7QneIqKL2Dhht5sdnFGo9OyfOY+1500jWr/q5mG7bZw6KK1B5DjChc?=
 =?us-ascii?Q?UJJhIleH4W4XqtY1qH7XHifpNRCR79ir+K6glZkOIxicLCYP006bGytObSaR?=
 =?us-ascii?Q?dk5kMDl7Jrt2FIB3hWZSWA1tG/fzeIVDqjkGScGR0VVIK882Te572TLT74AX?=
 =?us-ascii?Q?g+p5WDEbN+M9wvHh1NsYVxKQguIMdfOFysaK7oV9jsGMbmdS6BGdN5GiO9Ng?=
 =?us-ascii?Q?AIOnf5iJ+bKQJTjU1CTlrCuV+1qroxp3/Dqdj9hd8FK4e4qfgm5GD2HlpVJK?=
 =?us-ascii?Q?HN9tzvtO9ScueG/AfQ4DEYd58f8rjTLnGr60Y5w8o/GveAuBp0D+3W21RaCU?=
 =?us-ascii?Q?qDIDI/gCgn65XCb/wX+z63x1fcvV5ASN43bHhmk49QnXcMBkZIZS7T/Ll5ZA?=
 =?us-ascii?Q?MB2C5tTrCmcAkVmR//du7dJM3iprL39OuxzRQCRbw8vlCM+d3N1Qju0KcnD4?=
 =?us-ascii?Q?dMXbUvHkJ6TkCbMemr4WO+wyoYUdotR49f+hcrvJwI5FZ42u+YL3grHjAPQX?=
 =?us-ascii?Q?04ONPQsG2RkRObw3wZ+hv2+H2RUPIQRoDFk4PwB+bqfiPfafrIYkx5gkepTa?=
 =?us-ascii?Q?Ws4DdQR7BC8QPp+/23fVgAtkk+uEIqZEhRSihA6d1o8ZZOP46Kf7IHPPlzil?=
 =?us-ascii?Q?E3838+htqsen7tunFEaBsPdfUepGhv+6qGIVxADGzwCw2ldMe5G4NA7R0Abb?=
 =?us-ascii?Q?wvpbJZSdKEAd2WOtn3jUarlzdg41bOH3/Y44Ih47SXP/PlMc6mM0SFR0xMQc?=
 =?us-ascii?Q?PSRPIRftL/DFigwiiNwpBhUtLD8RZ56tkNxpv3nPbLnKjjpPUzbm7PiMYYfW?=
 =?us-ascii?Q?sG1ryP1iRXRpwsKgHcVSeMRl88Q+U1sLBJuDjzsVR+RvAz4sKGk6yGZd+2QC?=
 =?us-ascii?Q?f68AuaJTej1gjdYGohCtQRdYAie04X2R/huhTouDQbaAKHF6Kh1syybTyfnD?=
 =?us-ascii?Q?rC9Txlsc+W8cIAG8Z4s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751e0484-2d2d-4c56-f60b-08ddd9ada75e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:36:41.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hi57IZrkYxYDlZNE5SGR4HJcISj9qztk1XuT/T5IoI3bCDfwlrpVfifPf0ZKkl3Bs+MHDZh9pHROkF04fDW2hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9436

On Tue, Aug 12, 2025 at 05:46:20PM +0800, Wei Fang wrote:
> NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
> Integrated Endpoint (RCiEP), the Timer is one of its functions which
> provides current time with nanosecond resolution, precise periodic
> pulse, pulse on timeout (alarm), and time capture on external pulse
> support. And also supports time synchronization as required for IEEE
> 1588 and IEEE 802.1AS-2020. So add device tree binding doc for the
> PTP clock based on NETC Timer.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>


Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> ---
> v2 changes:
> 1. Refine the subject and the commit message
> 2. Remove "nxp,pps-channel"
> 3. Add description to "clocks" and "clock-names"
> v3 changes:
> 1. Remove the "system" clock from clock-names
> ---
>  .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
>
> diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> new file mode 100644
> index 000000000000..60fb2513fd76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP NETC V4 Timer PTP clock
> +
> +description:
> +  NETC V4 Timer provides current time with nanosecond resolution, precise
> +  periodic pulse, pulse on timeout (alarm), and time capture on external
> +  pulse support. And it supports time synchronization as required for
> +  IEEE 1588 and IEEE 802.1AS-2020.
> +
> +maintainers:
> +  - Wei Fang <wei.fang@nxp.com>
> +  - Clark Wang <xiaoning.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1131,ee02
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      The reference clock of NETC Timer, if not present, indicates that
> +      the system clock of NETC IP is selected as the reference clock.
> +
> +  clock-names:
> +    description:
> +      The "ccm_timer" means the reference clock comes from CCM of SoC.
> +      The "ext_1588" means the reference clock comes from external IO
> +      pins.
> +    enum:
> +      - ccm_timer
> +      - ext_1588
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-device.yaml
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        ethernet@18,0 {
> +            compatible = "pci1131,ee02";
> +            reg = <0x00c000 0 0 0 0>;
> +            clocks = <&scmi_clk 18>;
> +            clock-names = "ccm_timer";
> +        };
> +    };
> --
> 2.34.1
>

