Return-Path: <netdev+bounces-239905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC18FC6DDF3
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2625D4E48B1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C4F343D93;
	Wed, 19 Nov 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QXf1hG3l"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7DD3358AB;
	Wed, 19 Nov 2025 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546393; cv=fail; b=fFL5vwJZY2mQ5e7BSuUS+jOgrh09dWbp+1S5ljczJAHJAsJgJs8xj4zKg6f234Jv5X9UlOWAoeElPpU/l6Xh1Wr+J7/nUKVywG6UAXlil3KHIMjA7hGXOeH/EQDa0uv+D94/hxnhgNaoksQ6w6vGYZdgN3CwnpgaSvdaCahlBCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546393; c=relaxed/simple;
	bh=IfWmkwur2G5BaKRB/83aC62d+RpY2zKY4CYb8v620Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DkAAO4GOMBsNl7JdnmIR6g/eMq1XX/ldMYPd/29JW58uj630YP00UWoDhZdaj7+DFdNoy01CnTNfwvynfhpmvXlVu5V9WLTeJc+To/QngHFaqGTpqnYSwsxaHGFw9fCZMOL1TEZwHl7cyqDdD5gNwGhoKw24a0uDJbije+xJkfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QXf1hG3l; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIMjiwpV8S/phMfleZrr/7wIFhd5oRTFpsbgS0OSbZyAUiAEj6GJ0RGSEeGpY+Ov+Ch0bEIeDvFo+Apv2iI9rmpst6ZbAFxxFMPn9C/EC92lxzOEYePi2aB+v/7ubEi/0wPSqTQfXrL9XZz9KTOG2MGn0fQ1s7bL41on65440MytL4I124GGtwBdxhjJZTcWZVpnF4SGlGSV9eOJPCVzmuz3wsSzOySyyi4Ksd8JXUnIPx7QVjkLb8q4QmaVsKw2RoFp+oywsKi377OLDg25sdCe43yNG9cGY9yFxBym/ztJum07z2BTZX9mxsIleEVErRGxEHLegCXKy5j71WrcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df8XFfE76eEo4qA10N4cvk3U/vOXeZqvrzwdrRpQkkA=;
 b=STYPHwoISWnqBhOd+MrxaSfrDDKjaQ7/n54Pk8VdfATlx9E3LDkIgECzlk0qTYD8X9pvpUiqk5SH4CRd2oAIaEOssF7CTBy0HPfyQKsYTrwhfxMKckXriYnh7VMwrjJcnrkfHX+bOr8bJtRl6+DUXPzZPfgSdUarEDoSLrcZUflDVUetvyr+5Cr3A1Bnj82RSt+/UbTXRi2j0h4bvJfFaBo6im3F5K6IuUOYdXQSeDI7mUZTzMhZqWhBH7Mp++Dt35Bph69CvnCnrad2BdxgvHbSOmZjSwwN2+PlRFvM2Jc88ucUO7KuffbIsokYgWCbH+VKzDwH3UAeWsLm9dgCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df8XFfE76eEo4qA10N4cvk3U/vOXeZqvrzwdrRpQkkA=;
 b=QXf1hG3lrRMj+mM85SbCP1yM18WNcaC4NwaanVt9Z1mtxWpARokG1Y15fuiYiyr8Js1JHjFKuNkT7gPZufLwzsliQxrD3/attnTegtYJcMIwzeFF+u3TS4iFJwfZ11T7VLqLKCtbM9zrYlZVjMHbR9MLE1f+YH4s78g4iFGUf3G+ZJEt2/EhrsFhGhdP81W4pu6X7zGSh7CWLQSO/wo4XcfeX47agJSpLzy5tzVBjXXK11Aq33VIIBGdYyD0Sqi219CYgYdEuI9mNuS4PeAsJSrv3moLXAC8/vUxJXJvEUIbMRwCBsWnAQ64p4a7lri7/Rs0lAeEvEhC/K1dNhWyyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 09:59:47 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:59:46 +0000
Date: Wed, 19 Nov 2025 11:59:42 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <20251119095942.bu64kg6whi4gtnwe@skbuf>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118164130.4e107c93@kernel.org>
 <20251118164130.4e107c93@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118164130.4e107c93@kernel.org>
 <20251118164130.4e107c93@kernel.org>
X-ClientProxiedBy: VI1PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::27) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a532286-ff8c-42c9-ff10-08de27525e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lIuh5bC3nFoCVbUZJRSe1mzj6DvocFnYOCEtk7wW81ejUJ42M0ak7HGOQVmb?=
 =?us-ascii?Q?qOKtVl1Y5+L2H5DTDrbdp9GX2wHGgg1R30ZQLVm7S7uMOeTzqyDYj4F4lHMe?=
 =?us-ascii?Q?UiMeFk8F8SV3McpNAZ0haM4W0B/Kr1yfwt+Dh1+SNKIq9JIGmgTOi8U+tnqJ?=
 =?us-ascii?Q?rPbLS23IQXK7gmVaKMQF9ZTs0f3sZwsFxx/SYCW41JbixAu7tKT9Io+GJwbY?=
 =?us-ascii?Q?DVZh/gEFKxsso72EoIjz7RSskMi8DiBe35/5k7VVDfb/NKv1gguIVw+PNXzF?=
 =?us-ascii?Q?5jNB7j+KpYlTNz/D+BlFRRXF/32cf9tQ03yibJ5Z7198r20zzJxqROpqzWJ0?=
 =?us-ascii?Q?a8MYAh9Ps+LmRmVapWa9zUpyU5ru+BwzdxETbgoyVD85RjwmQGDwS/bBU1bX?=
 =?us-ascii?Q?1aR1aDrsT+MsU1azr3rxB9GAiAN78mmLQ+HU8rvNXLCLmWV+fII0/On1OslR?=
 =?us-ascii?Q?o5ivYACBAC2A4rCTCa+I8j2f7vdcMzYK7eVnJt4YYFWa14udlBkDh+D+mcFm?=
 =?us-ascii?Q?cEztgRhlTqUUbTqtRnBggoGQJ9JwTjZ/N+HKwl6EmD5Jr3J0PjBxDIofXIzx?=
 =?us-ascii?Q?zb/3jpwMi0EDNpAwqGKzn7BpdRRvcL9CHRQa23pBtDW5WxURZU+rFmFNePJl?=
 =?us-ascii?Q?xNQ9tdwu9bcWxNyRftMUsIlsjgJ4cbeIdNB/Mpcd5zqGDs+AkwPCUi01As/P?=
 =?us-ascii?Q?3zMsgpt3f9Z7vXXc0Nw4rkdy7bXVheYAioi/rey1HmgC3n2gawszUjtWMp+1?=
 =?us-ascii?Q?f139K0eCzhPTCw1S9vWV3VM4100xn1GAoDQglfDFOnQPqmjim3tAUG5+q4t4?=
 =?us-ascii?Q?M6V/ymTevoXMZHE0WvUD+6OIAf87jfPkwzsQDq7uQZ9onfR5JBfbSXQaBUkk?=
 =?us-ascii?Q?F8xTDjHuqwxJiaXQS32ZJCeISMimwdZqUT427exeHwd2fydzrgMB+DpRHlOo?=
 =?us-ascii?Q?nqr+pd8KqU9P+hEGvWQF5L9fBV+uJAVs1YO8/Fh2BQYOAYesIbRxeAznsl4G?=
 =?us-ascii?Q?zPy/4Egk22XIqCG+YYjpNMiqK+/gk2E868TmMvCrlcy5bDuASBQeoNqyWz9c?=
 =?us-ascii?Q?6pU8MsglZ1kVgkC65/4yKaFMVVVzaMWvTrKRc3iJNnKQZPSIH38/IszBrlNt?=
 =?us-ascii?Q?cIHiHJXK/e94QnJxynO+ayGg+e21rek8/L8EN/0p1x+JTKnmlYmcs3K3b3ou?=
 =?us-ascii?Q?WoU7LgXCP2f4ZMo967Pk+9Ywk0tZOvvhZ4cPLkVqlDMXAIRdop0yyXoq5PeW?=
 =?us-ascii?Q?kqy8PBp6j1Stbq9PENPS/De8S3OL2jM4SKZx79L4un7TwXQt0RhhQi/hj3tK?=
 =?us-ascii?Q?LdJErtNUQOIvzU+eaG5Sw/Q48nG+zav2milblYayTWmjhx91TlN3HzvQFziM?=
 =?us-ascii?Q?NE4BEwlrN9ShOx43LUpMZss6IkzwzbqMo/QjobaMn3RHh4LxNSz34EOsAfmB?=
 =?us-ascii?Q?0tf/gDr1BZ0fBDMt7GtwBPnKKytPSL27?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/hOzF5bWY1p7FXb2D0OBKjMnEWCgl1u5BwgkF9U/uGePoBYNExxKyehRm71w?=
 =?us-ascii?Q?EChyZ504WTJYpTmz88JDAodMm2NvtOlCg3VCMbotrmK3jDGavBabAYzryFOx?=
 =?us-ascii?Q?yzA0lgau+1x+8lSB8HMr7BtgIoIWW1XLfXRTBS/51cLJ1zyd9JqFzYoDICUU?=
 =?us-ascii?Q?vJFJEdBAkB5N2OM6olwbV75HTX9FqD3sYsWdhCnxH0lX7RDLJEKx3CWBSt+Z?=
 =?us-ascii?Q?d1tRM1ua+JR7/Ai2B8E4EGgCVfr9XwlcAtHkkV76R8FXcX8634ZVyd//6A+u?=
 =?us-ascii?Q?UbueKoyblJVP5yPTV4Br5k1kvAFnmD6kt8LaLKktsjNXzSkOiDr8BSWUdvH3?=
 =?us-ascii?Q?Clk4hgl85j6/V5I1A6ABg13FxyyUEWqPMaipJzGc3AJGXohrwKJ9GDqWtroJ?=
 =?us-ascii?Q?921BM6VOe3dsKatRzVotYZGe0u8Phug1aB3kzfezcopGcSApfzfK8JuBhyu3?=
 =?us-ascii?Q?Dw8jM/xiXNCBf7VeKEAzMTAkKG5iX7S/2R60j3AfgeK52zn8JqtppuP/TKRZ?=
 =?us-ascii?Q?ayS52udi22lMCGkiqKIT4shrNVcXlyjJnIatDGynI2gK4oM5Vr60qj52vqRf?=
 =?us-ascii?Q?Ni/+GXtaIcSBYxvEZijFEJgpsKUugowZCWQxbhHNMHHvt9EtSYCIV2bjIZPp?=
 =?us-ascii?Q?C9XMoSjeG3Kp+EE4Txa863KhWv6lUOIBDsNsn2H8wfKszg71RD7LVmct+Yzf?=
 =?us-ascii?Q?m5HxRYc+0m0Vnx9PyALp7vK9+IQzSw2kpX9k5NkhXjxpUXlnDbjte8kvLopA?=
 =?us-ascii?Q?iYckllIYtBeYrc9BT+qj/pabe0v1u0td7CUbxiuDVhlWlV+1D3ThFiaxi2iO?=
 =?us-ascii?Q?ak26j9CXOFOQX6ugyaMqc6O2UuQU20a62xA3WPdbehbER9eEAiZLcjDyddN6?=
 =?us-ascii?Q?MoPZuev4JqVfuW2GwjVnP6d2SWzzH6yOm5R2tz/KT5JQPt7QzoHL1FZp5lCB?=
 =?us-ascii?Q?HoMwxfX4RA4iJ4lcVKmaDH7rAYCbOW7lwJwEjJpofxY+CVbNYjdFAEMvXruE?=
 =?us-ascii?Q?QeHADCtoAWpLlYt189prruG3H9pJrZopls8dfZppGi7y3qoNP/sB92D5K6TP?=
 =?us-ascii?Q?h7NVS5dMaj1rZwg2wRbSNajG7SJ0+en94E0t8nwn4M67O0HJ3x9kVrXHdRji?=
 =?us-ascii?Q?lDjA8fyvdqVxi1nK/mj3LPpA/WEVMDJKx1OcCWePav8mfVhH4BiX8y5Bq2am?=
 =?us-ascii?Q?CyEWPpPOgauVlxaxyBXf+h8nro48AUxrBg8hSpD/Z8AJ02tiD7DqMmqBbVhz?=
 =?us-ascii?Q?PW5+vGR6cIKHQT8nDa2WnI499TDTI0RNAXLxPYVIOvH4ooR0LgrZIfSvCB0e?=
 =?us-ascii?Q?lL3oB23oe5w0evX8udJby4221YcS4iebtFvgGSC35K/s7sn08QgTSKTcGd7C?=
 =?us-ascii?Q?VkY/Aq5ZpgFpvBdLMfK50jhvKqnR2LkXGX4HLWHad6XANnu8KCWJzKTiJOB5?=
 =?us-ascii?Q?FH7NCHzYzqzJOFaRWkOXsFd2khaVs6bcYCBV4EIPo+rUdR/d/0N7NLeP1YVK?=
 =?us-ascii?Q?nbj+YbssaDPnlE2aEyePRqBWRTpmqFz3VpEoSbNSwkNw9wYqHigAcbx+V3gv?=
 =?us-ascii?Q?Q/YvGsyn/qPnRXqEHfipHfC6+OmDU9mhtH1ON3SHARyim33ngwlPjzsljqyf?=
 =?us-ascii?Q?dlT9K3f2lscgfIkR+C+MPL3jUmOWrzgE7e+eJvQ9PCv99qsSJscJslgoA82B?=
 =?us-ascii?Q?Oj0LFA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a532286-ff8c-42c9-ff10-08de27525e7d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:59:46.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgfCPvAgKJbMYEQM+I8GXOnN40la0a9VxZiKQ16bTJtixA7zS/6ELKpQTgCicaku19fqvXTvCdGRqOzSSrI9jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940

On Tue, Nov 18, 2025 at 04:41:30PM -0800, Jakub Kicinski wrote:
> On Tue, 18 Nov 2025 21:05:29 +0200 Vladimir Oltean wrote:
> > +static bool sja1105_child_node_exists(struct device_node *node,
> > +				      const char *name,
> > +				      const struct resource *res)
> > +{
> > +	struct device_node *child = of_get_child_by_name(node, name);
> > +	u32 reg[2];
> > +
> > +	for_each_child_of_node(node, child) {
> > +		if (!of_node_name_eq(child, name))
> > +			continue;
> > +
> > +		if (of_property_read_u32_array(child, "reg", reg, ARRAY_SIZE(reg)))
> > +			continue;
> > +
> > +		if (reg[0] == res->start && reg[1] == resource_size(res))
> > +			return true;
> 
> coccicheck says you're likely leaking the reference on the child here

Ok, one item added to the change list for v2.

Why is cocci-check.sh part of the "contest" test suite that runs on
remote executors? This test didn't run when I tested this series locally
with ingest_mdir.py.

> > +	}
> > +
> > +	return false;
> > +}
> -- 
> pw-bot: cr

