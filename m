Return-Path: <netdev+bounces-219945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B336B43D36
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAD71C80BD5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D11E3002DA;
	Thu,  4 Sep 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fSTEino5"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDFB3043B8;
	Thu,  4 Sep 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992620; cv=fail; b=ETMBcGBshyBzWIphsmtYpubwngHSIKdTPtxvdUP/WhevYzJSUt7Q16evzF2aL0g8jWKwbN+rF5vie2YYaVslXzw5wgQnvd3xXmY3pXnLTdTedoeDy2jeBmNp5Se6U7N0FDdNe9tkN0uWWtuoWFssDmy0+/5XJZcCO9WeL+Xz6is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992620; c=relaxed/simple;
	bh=gWDjPUJO09f6Fk/tzXjMP4dWrlh6+zny4VzKpc2knTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z6r1cRThmvNQAzl4S72KNAysj+LCHW3wvt1GDqV0Ui37y+ZddRThO0I1JHNE8DNPDcMa0Mfb0FpDTHwx2pwowh6hPfHWXC1DoHyzelkclXBkE8NiDubbt0MCYv4l5Q+pf5BRwi15TNakBknhA1pQcU6prr7Kq6Zn/f4vc8LuHrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fSTEino5; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZ9QJnn7s+Q7SLpq3KWcswo9eV/1e6D5vQoWBO9fQ+VYEqPD8kSy4ynSgwxLO4quVmwQE4cFV3DgP2lUPCKGgnb0/7xwFaK4VYkOQnhJJsvsgiLS7MTEwQM3NGig0UaeuwpkhjiVY/Q43zHsOFgPy8rRYbKDeQ9zLS/9BrfItmmxYlZDaU3o75Vq25NcSJydqfut28Kf3M1rX+gnupbWBM+FBVb2h106GmUo0WGcNDuPjfgJeGMDi8bSS9uTGFp/EuCdbBqcfu4DAV8YD21V+nZBthLlchg+sgLuJLLL/pi3e12TPBy/Ul85c+poM+yY2OoV4IvHktQ0Bvg9fnmB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=744Pl3YGjT3+KS4INDUJBQ16/QubJkApW30ZZQIosQ4=;
 b=N2hvDPnp03COlMDOxQ7T21xm9JyIPl+qTq3HrjiL8QdnKDZ3xGeQ1vnAh42nnFUJFf3qBcn5S2Fb58TUyVbT+4PhX6b8D5vwPMSGN80GxaGrxYdR/WzvagTbcxtSbV1Fa31q5G9VBGv5pSwXwn7wjX3JjdePV/MTPCIQTK5zQ+v1CDaWj28hnzGbjJVEi4tcGS4kit7DkXhu1XrX1gM79D+EQ9rPohoHenX2q+I8lFNP83ZXUloc9yZWm4m1QEHPl7PavHgOa94PJucFc2MO3IT+tbbmOeGIxBCS+wPAbBK4kbW/ARUaJi+1USG5H40wgzk3NXh+8RaoQqmsnh+h+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=744Pl3YGjT3+KS4INDUJBQ16/QubJkApW30ZZQIosQ4=;
 b=fSTEino5KtMSAeqk2G5W/+/pSI1vwN26zkPg1+VTy2uS9cIs+s20/nZFbQxSfUa+0XkeBVzToi539KssH23qoAnikpQPP6vgx5mslyklhtDLd8m9/T8RlvDwzmp+oWdxC8maxUY+JvL813BeVIEmjdSd6fSJqZuotOhxUoqJtkrE4ciQtsLuemULaDWwG6J3Zgv51PNs0IQO7NvuL6vClDkJrJ/r+7NXdQgKo0iO9vpwoxYd7IQrWQQI+VSsqjYFAFq61jsGAgpbLlDCjRGE28aqBdTwe3alGxpmKaInpFc3kECWAHQCkWdOPxz9T77UJ0NWVfsa8K3eTmJtNB0WFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS1PR04MB9359.eurprd04.prod.outlook.com (2603:10a6:20b:4db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 13:30:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 13:30:14 +0000
Date: Thu, 4 Sep 2025 16:30:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiaoning.wang@nxp.com, Frank.Li@nxp.com, yangbo.lu@nxp.com,
	christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 1/3] ptp: add debugfs interfaces to loop back
 the periodic output signal
Message-ID: <20250904133011.asqvsucdmuktazc4@skbuf>
References: <20250903083749.1388583-1-wei.fang@nxp.com>
 <20250903083749.1388583-1-wei.fang@nxp.com>
 <20250903083749.1388583-2-wei.fang@nxp.com>
 <20250903083749.1388583-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903083749.1388583-2-wei.fang@nxp.com>
 <20250903083749.1388583-2-wei.fang@nxp.com>
X-ClientProxiedBy: BE1P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS1PR04MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: d7caff2b-b05d-47f5-266c-08ddebb72e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cc9xdiRs47iEUyT5inCXnIxwsqISmo/gFHbjTkHYTra13PQda90J7wleqHbp?=
 =?us-ascii?Q?fMfGlY2kOOrcnYd31pbNU1v+4f3sSCA4aD6UZvson9JYEiODuKsuQJYxzXV+?=
 =?us-ascii?Q?pXvVx9Pd4u6Rr/C8zk3y3ivl1rs4WPKWqn7+8pXnSmJ2uxe4qNfh6xVLTOSD?=
 =?us-ascii?Q?cThHFwMP4V4AZ15j3zbns2GN8CjYFoo6XMEkItHwkZUKWv7NifrKcl3qGcM/?=
 =?us-ascii?Q?bveKOB0ZcdsT7s0lkRXV2hUwtxEmZ5YaqLPgOJpiLDNnrFwM45yU5i1dTZnR?=
 =?us-ascii?Q?vms3tL99HO9fHOcukbxQwPQtAGBl7O57J1xN9pfxiJMeAVAzqa43Ah4jLnXd?=
 =?us-ascii?Q?aAUz8qAQB1/r3XMVMfuAyEGSW9EfTtPMODhBB22U8yG7cQoTnKA32W1ORBFw?=
 =?us-ascii?Q?5VMblN5VQlaIAHCGESDhT5k0EH2YrxOCB9ruEnaUEAf2ySzmzm5bk03hRV29?=
 =?us-ascii?Q?m49D8DnSWtC1NUt3uGByT2ybGUcpDcle5C8D4/ftB7zYe9JHLMdRQw/68MOf?=
 =?us-ascii?Q?X+zzaehCmjv1e5cf3Ml3awLi7mvaI2Y4fQ8UbS9NrcWwFvKkzflHXoO8XaT6?=
 =?us-ascii?Q?epdkFcPv+gBW77M3zy1QBhk+GE2E0lduB2Q4Tv2d/IXfwQ2bLDXYvdWtPTpt?=
 =?us-ascii?Q?NEFqXSaNZt4I6adkYAJNJwmRFngoe5DKCtCL9UvP4iylrK3lMmigHqEC904G?=
 =?us-ascii?Q?P8uETrMSEBPkhraqs1XILsgWYAa/DDUCPnkkLOz2a0JzwYQGTQxrJCpTVusu?=
 =?us-ascii?Q?+jvrZpuAKB+QbWC55rcdz4DuLDNMPylwYokN/SZmBeEGml4j1qe7h22ULvQH?=
 =?us-ascii?Q?VZtycYM6v8AbV0KMwcsmSvLCrOjfri+YH4Jlrphk2ewe8EY7gw5bf/MwkGRn?=
 =?us-ascii?Q?pZnego64VYAgHvJiSSKCB2bxaP3i2idD2tW1pn56PWCd0MOsc0xORNHeH0hp?=
 =?us-ascii?Q?xvNkEo0rtahsr5CFAo+byI5B5g02wFYM2nbQl+oyLGW/XQuEfbQzfU/WTkIh?=
 =?us-ascii?Q?ChaSTco+j8ddnocKKh+93SOFqwLCRLoLeM08q8NxqeIoB0TmxBTBRCRELjFe?=
 =?us-ascii?Q?5xpuPZ7do5vPZoBAqiYKIkEkUJyGA1EQBSstOKpwJD+aO4LjI2W38bQf7Fga?=
 =?us-ascii?Q?hnLH9fv8YE5I51Dy/QTMf6UTcYcgmoVyfNaItsJ8Jfw7hGhAyPM6+SVrXRpu?=
 =?us-ascii?Q?UUHkeNwVN8oW5JNj2MW0k/AA2PU943l3z0Tx04zjBv2MF4znF6KVTljHE82i?=
 =?us-ascii?Q?nndyQv/PyOlois3fSZe3Kn4yG62F4LcMaIYpl7FOFgA+ttWD//G2uBfUEJz7?=
 =?us-ascii?Q?o6ozDtL8aS7BP/r6HNKP4tX0ZDq1P8rN2NnSlekw3EfUtE7R/cxFTpl+aUeR?=
 =?us-ascii?Q?Al8tOwgKJ93iVHgmK1wTTzqKram68qqbNTVyekcTOPq/edgTsebhS3A3aXty?=
 =?us-ascii?Q?v29+ArYwBOA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzVm3MSBqL1+cfSu5rp0W8FBeF6tYmx8V840eOp1ouijSeKHdaDEfNJkb1h9?=
 =?us-ascii?Q?KP6mctX2lfe49rLajDerpzn8vu0PqDvh5aB/r5MMWQeFeSwOcn1dsz4S+Iac?=
 =?us-ascii?Q?wBs3GQdaO7LdOzTvSWguO0E8jxmndR/MM2WKbCroIdr4MUdFWueHUYcU+gaH?=
 =?us-ascii?Q?JJZV0frSE0HvQ3xwjzKoZLg6zncesIDFy8qZDGdgCBwzI+p8di1AbgQHerdG?=
 =?us-ascii?Q?0OMWmtdfAazS2/EEDkzofLdmwSwFSyn3g4aY+CL1pkYTM9gLbNGBYL6+66b4?=
 =?us-ascii?Q?C5DdC7KlEnDYHt2s/Dlbd3z5rJqik6JrEl9dNhLgXEb7xzwjXhrn2vv/rx57?=
 =?us-ascii?Q?n1WqK9uQCbEXVfiVW90iJv1Bz5P9OH2UW82C5fK8JlWBUYiXTmEC5iiUlma8?=
 =?us-ascii?Q?Yc2VlC6gwjYGGREQY0T6jKkb+i7IAJXllSsX4/jLRzsB3kFD0f0bfr2SzaU4?=
 =?us-ascii?Q?Q0BKK+6+n+lxgNMfURsx2xLqfo04tgNAisqOjviKNQt/yecrIO/gPV/71vfM?=
 =?us-ascii?Q?YeLbsUxq20QyodhoIB0y8dcLRNOCE4Nwjq3McQVaYhM5HkuNAelOYY/PLMpZ?=
 =?us-ascii?Q?sfMHNOPnaQ8B2Cg99/ZsGhWJgRTlNl+oOigY10oizGgvvtKMgAb9mtfb/wZ4?=
 =?us-ascii?Q?pIgPGEe1R0E/N4TnaQx1tN8nOaqG7s8hwYLzLT3c+nNaMqql2ZN8JO9YJhA1?=
 =?us-ascii?Q?H9xx6jH1lHTYHS0tE0tiBtx+KHEAG4JArb7edoRV5g8BbzWt/3KGL5FjpRDI?=
 =?us-ascii?Q?gUiNF+iQQzHFuCA2QQmGNiLMpkL6YLbdBsL3l0nfIGA3+JwjDJCMa8vcdSgZ?=
 =?us-ascii?Q?FC89oTpdGCQiTzgW4+WAUMG+3sKUe33YuhYKoH1IMTo8RI4SJ20l0SY4HMwc?=
 =?us-ascii?Q?XPortXpp3I5jEuz1vb0YtzCtFTdBgJsde+00WGfhrbdHuuUk2tbBuJ6h09ax?=
 =?us-ascii?Q?c1KSbo4aVc0vym+7XJT/8e6ELNDC0xVQ9B5uFdvGwnOQSNDC7idqnRthwhfc?=
 =?us-ascii?Q?O/poOkDcIG36st5VsY/JFaha+e0Jx7DIuJs3Y6NkdSK8+ngnNJiJ3w/lc4eR?=
 =?us-ascii?Q?LpEJEgckC/SXKdCdLK33ruDiG8NVc8fcieVN/9C0lArFKwt6AXjgsD6eUZwX?=
 =?us-ascii?Q?Mz5elkcH4wWzrLMGYv6ZH5Z/MMtnSQ/tqFqilo+CIiSXMfFNdvAfOtb9uP84?=
 =?us-ascii?Q?2uM5PLdJz1L2wzXaFggxcOhwlQAPBf7j06HVBgdoxQSP3DJRywadMN10eIWM?=
 =?us-ascii?Q?WL9nCgE4mXwYwdaKvYjbxYFX/MpGHK53pm5x4/Xt0X9APfZ3YWuIQwA4+yvC?=
 =?us-ascii?Q?I6ztn7N5c5nx0swNOgy864vTab6OUMrl8T17PrSTlxfNuvLvA72vTq+YMWOt?=
 =?us-ascii?Q?/SEZqvwJDfzyGv8zTbbvlqFI+Eb1SNfA4FXQ3RK26RjYtBRR1FSTT7u5aF0g?=
 =?us-ascii?Q?IWYRU8o/Qn45YSszID/8bGPrE1Ot33N3sf2ml8bLprQaYpzS5G7CWXIWiJT6?=
 =?us-ascii?Q?L1rCXNDESUvrAiJaiFXmzab+qYjnMcCGyFUlwzW9J77CYhn8GVis200+Nb/z?=
 =?us-ascii?Q?89iyZJYIL/QSObi7xDkZi4A/U8ZLbyGsRKLECCsrwSKhdRXULs7e5zGZ7lgM?=
 =?us-ascii?Q?oduvpucGCki3/WXrQRrWz4f/gdFn5m+x27AH8YBJXBSv8fd4U65aBWo3l/HK?=
 =?us-ascii?Q?NxRxTQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7caff2b-b05d-47f5-266c-08ddebb72e06
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:30:14.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: af4F75cDbD6C8/A1e+ZAjQ+GoNeBAHjPIQM+Ee6E2jc+/3eM+84bp6ZGBAyggps4SkLEvAajQWmot335jaiK0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9359

On Wed, Sep 03, 2025 at 04:37:47PM +0800, Wei Fang wrote:
> +	buf[len] = '\0';
> +	cnt = sscanf(buf, "%u %d", &index, &enable);
> +	if (cnt != 2)
> +		return -EINVAL;
> +
> +	if (index >= ops->n_per_lp)
> +		return -EINVAL;
> +
> +	err = ops->perout_loopback(ops, index, enable ? 1 : 0);

Why not just reject other 'enable' values than 1 or 0? You make it
impossible for other values like '2' to be used in the future, if they
are currently treated the same as '1'.

Also, signed 'enable' doesn't make much sense.

> +	if (err)
> +		return err;
> +
> +	return count;
> +}

