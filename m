Return-Path: <netdev+bounces-172981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C034CA56B0D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C50B7A5664
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63B41898EA;
	Fri,  7 Mar 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C873pfH3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2040.outbound.protection.outlook.com [40.107.103.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1382E3361
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359760; cv=fail; b=S3g69Oq5c3AYAMdCjw92lx9PRZG9ilZGfuC/2YKM8QmiTLjSaPWQkTjUcsFEiP9sEG1Np5zO42h32k85d/gYX1inOv+BeKwU6H7YICNWqFlxvGXoVMLKdM7Vz5bzFzYvCV1SocmhcH9uAFD9ROGAzp9pO9iRfQsnoP0IZP6yzA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359760; c=relaxed/simple;
	bh=H5xcVpVZ0PF4cwDrO80crKiZaFMkbIiM1b0ow3jyWZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KFFykQKOQB8Gl/VtdnbqRGZsbCletdiqhQofZ2/bUuRFR33Ti+80By9oC47EG0EbVZgLRZltJGd6Rk5RNwlapgVMZqKCdlZyq9KhugFBl+Zoygim2OR6RcXA68YTDmDmyVCa2wIOMA3iorC3iZH4QRbZZ7rpLfqxUM8MF092J9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C873pfH3; arc=fail smtp.client-ip=40.107.103.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIB0p1UAgYqNkg7b3gl6VJE+/0SQLmscdU3ajrBzIKdJgr/vhyHLknH3pMsL7dqMaHZxCdxXdRgr3e0iKehPKHAPzvrURumbNglRbKkWj8f4ZvOb17hYigcdeugNeWUX2H5vnm//Ajxv0bMRPg8cOcyn80ARBmUi/XYWWgcqaSc714cD9Tc6GDRvrsMcJbEgB9zosYbBUjZF0ZVv9zENfi3lZFaSHIqqjJu0hTl+iBXjl2I3hcEcwtetKi6KPTbQYywbV2x7sp+ztP9CfE+v2rAmVkSnutNPxZ8xDcLBlZrpD8aB9QEKrYuRwbS9aPQL0y+zFwPtjsUBffd+CmXydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTLdSDYRo2k3p9h3JiKuwNuo0RxTDFcoFGXRSl02GqM=;
 b=dIr0Qyj6klBBSnSP8VGfYhRcPd0wxFkKw+/pDuhF9yhTDXDCyDSBWCv8b87720wwSDZvpZSN6sVvNfhpGSZY2QHGXdcu21rIl6pd7ZmaCWhY6cTLBVrWshcja5LLTxkv/LTPGLiAptWIc7t27HytHW89SHnLV68e73Idq9yG9DgOm8PtXPpRPP4XePAV8TsuXKulT8JEYQwuw3AwyZ4CRNAvqJDm9VQtsK/kWlol4WgSRwSd91n5H6j4hTC55YfZrUlAvfLaiqmow+7zEi/gIjKTRJ8mm0iHaj3vHEPa8r8vDq1nKNpeFiUza8Y/vz1Odb8y3EdRluRtVzIgENuj9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTLdSDYRo2k3p9h3JiKuwNuo0RxTDFcoFGXRSl02GqM=;
 b=C873pfH3DLpP1yZxa8s3XrlCSdv50XzyztnBrY4HBw6cE9vltszKk7CZ8IPsy8wrksNVQKIvKb8r17InQOQehkkYBIfpz5UkeKcQzgA2Y51sQTrbG9zemdOcoveLbYZrt3yJDu1np4qOHVaWSQCf15sl5J7XVHYaaDIi/0HQ+Py3EQ4RvWYsu+kdnyD17uK9Eef5tDkez9BUS9JWJN2sUikmthoPfEiCePIV79jNfP2zJqQ0nVuD0RDE2eTqyZFw77QRvFKc/29Hi+OqbYMM2gJz4t+6l4UJaKT5tA1pEoZtBMWlRT7ucHTBpjiQF4lWc6zBMdfuJUU4PzHmIc2snA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 15:02:35 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 15:02:34 +0000
Date: Fri, 7 Mar 2025 17:02:31 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3] igc: Change Tx mode for MQPRIO offloading
Message-ID: <20250307150231.pc3dl4aavb2vdp7i@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-igc_mqprio_tx_mode-v3-1-0efce85e6ae0@linutronix.de>
X-ClientProxiedBy: VI1PR08CA0213.eurprd08.prod.outlook.com
 (2603:10a6:802:15::22) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 34deeb6e-6b8f-49a4-4a8d-08dd5d891795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CqgQbafC9on6x1Mt8CYgBmafhLhJ1URCLV59rPRtwfdfz07otTsh/3LY7EnM?=
 =?us-ascii?Q?Xgu6CBskpBscQoVcMzdyHoKhOMsVGMWIpEi63R+1FEHv8FFyFGUcIG6puIVy?=
 =?us-ascii?Q?N1Z+9cIsr08Ul5M14EUGb5HqyNbSYlecti47Ws4NmcRkL0E7K5om5yX2rzTv?=
 =?us-ascii?Q?MH1Dn2D6W6FYWb9/fvkeQgvgHc2rtUwcWoTI+G6geqhcFNKUhefXIwEcMlfT?=
 =?us-ascii?Q?JT3wl7AuP71V3nYpuAVOd57yqwGT20VpP+L+VFIjcDwoc6/5NSEUXf7/62VA?=
 =?us-ascii?Q?Zb6nAIchc8U6k9Tz0ReJozif0HRvRJKvuheZl6xPzjTu2MP4VwhswIsaHH+g?=
 =?us-ascii?Q?/AYASiRCBX3rWvnAY745qDF60grJIWmn+isQNgj21bJfXUk/ZHZc1W95IKZZ?=
 =?us-ascii?Q?Gffp9e6Bhd3ObAMa3zcf4RQ2l/AKZ0VHQ/aecCpFFg5yrg5+JeeNFJu1iNLr?=
 =?us-ascii?Q?orClEoIJkQFZkK3LUJw2Fs6xZUupdRdEls6Rid6m+XHC+b51u6iCxz2iz+z8?=
 =?us-ascii?Q?ncnMLGBS+8rLRSFBsYnnLpiYPLV3MXhnNyqcj/Pjp3tMWWnSKwN5U0JlpOFB?=
 =?us-ascii?Q?t9UvtGteJN0k6JOZH1SNI0nH5bZ3lzwhP2HRTFJhKBoA6H2H0UafgJTToVwt?=
 =?us-ascii?Q?WpLxpUptW31xUSCloxAioHXGeZCb9J272qMnYigt0fId5pO7r+aglNRze76b?=
 =?us-ascii?Q?y3lNGN8jQg3w9UXg9kxnIrwMtIWSAj+rjhCURW33QJkPvM5X6p/dCUZmcykg?=
 =?us-ascii?Q?py5HuzM4sXmvaBa7P7CQx71C99ekUjFtbhonvmNn0ISauXouYpuK1tm5uzu7?=
 =?us-ascii?Q?quGZkdsOtICVdc2kSixe65ijjXDH2zP/StHfwcYpwPwE7whPNLTgiRslgjSJ?=
 =?us-ascii?Q?ie1eAXFDUMajZijueTAIU0lEyjlQYyMWeycwGI2awKK307t8nIo6M47tSYbM?=
 =?us-ascii?Q?HrGOe6f0IRucXSTK/Lw8ucoWi6j7L4cl6aZS8DR0vF3ag18dyGSvIynEm1qT?=
 =?us-ascii?Q?YC/SEdDCQcDNnCMMDLtkH6d+5ncFXsO/avvsISA+pWewGBPYSOEA80pUF43V?=
 =?us-ascii?Q?SOI/NFzp1C2rpM/WFvoeKI7QKpsw1VZy01nxScAAKuzCsgHRsbuVjxKnQMIz?=
 =?us-ascii?Q?RSpG7A105zrftg0jh79ZPee5hexX6eLqvm1N3i2zfUpKyRzPAyA+OFt7oqjM?=
 =?us-ascii?Q?IMFxn3IWjN9kyOYBQUCXVEhxX07KcSKkDcibNL9EnXB5bvxd7D12yAvgYZ4q?=
 =?us-ascii?Q?ckFC7rM/1GfW8+X8jrGFOL/0mKe+337JUrY3YQfMBIl8f0ZsLwhZY5bTiUk6?=
 =?us-ascii?Q?LvnFqjim5DGFrehrwzdik0ZbcGBU6pmo32OHaoyq5WpnQtGkLOIgn+AaVnhV?=
 =?us-ascii?Q?z+EJQ6hx5d8W4/9mL9LXN5YBUk38?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xkAd86NURwTkm4PToKQLeMBQxA8VhR1vP3cXhVRvZVhHsQnhgcxOoNGsG+lw?=
 =?us-ascii?Q?rftmS6AiyP1ozTdLNKbXuRNs5cRiDYJ7SSYTT5A/uAhvmVMdc+gXPaRJ+RHs?=
 =?us-ascii?Q?8V8RgqXhtpZsdza343zVB/jgluUO3AsMPNMfoskKwHEVoEjZm4rnOml4+lVl?=
 =?us-ascii?Q?82+wS9rR7487XY0qycJCk6z1A/Wy1psCoiCWcipaEfmziX+bT6zMThV7amqT?=
 =?us-ascii?Q?XpqptO3JougsGmHtRQhV6MkSgVjkFbXpq2pWkQvojyzKviz9VPD9AaSeeSbG?=
 =?us-ascii?Q?PYn6WHGXkU56S2WnXgoS9E9vDHmYzw0y0BA6aoMhMQ2uaLaGo97xIXPe7WZp?=
 =?us-ascii?Q?Ac6/rIN3zCC0YBsZ0ScS5Lgp4WiZBhj0fRxzVipFWaaMEygrWfJozoa8c+hf?=
 =?us-ascii?Q?HLzFZF52WKQ0pLC8h1hE9MpL9zAPgxG8NY1Mo8PGHkHRTBL9q4stczcnRkHV?=
 =?us-ascii?Q?COJZuGRa3ETZ+EpSj9IFRgvGkMeuZaeglc12wQlHe3Iq7TVmgzZ26Qxfhmcu?=
 =?us-ascii?Q?0IFtIoW2x6QygEJwzve2IRn+CRHsbDxyEywSsf8FDYxSS3KHytADQDpN2+Xs?=
 =?us-ascii?Q?fefsnzx9HT4ghI6RePI9B/3cX0zTqqbl/m7jjZSvvZ8/eXyAfu93fJKICcGP?=
 =?us-ascii?Q?3nKNTvsB3i5Afbje8AZiiaXx9r7upUH3u7b4ifoEoJtPNuENhpX7WsqK3usJ?=
 =?us-ascii?Q?La4sx2gIWgGM4WvIweQNxy/yzw7YtjlHiTSRetIwjODbZp/OgBz5SN2oZ0Dw?=
 =?us-ascii?Q?QO+D0npA40NeA0gWO0lj0HQXliozRQ6/VvBnSB/slSj1Ht2XT9XJuZr9YrWq?=
 =?us-ascii?Q?3XGjwN2tjHO5441i6l7+GRyoa/2kyaTtx6fCSHwi3K3Cs4enAQEW+/QYQ9/S?=
 =?us-ascii?Q?SFYyuYJIOsTOv7c4kk+H+uBqzbTu97VrQvwdjbIM7e+UYWqHayx2K0vpP6m+?=
 =?us-ascii?Q?JjCcBjS3D/58sbBqfClPJFXF5s5y0oZMjvlMPExw+V4UpvW/T5bdtth4NYbA?=
 =?us-ascii?Q?kpt37i2KpfiiM7LG4hruV1QC5egA7nmtIryFgdezZaVseGmGmIn2uO0xbZ90?=
 =?us-ascii?Q?cB/pIQ+hAyoBw913itmAfnJT1KIh2vJdGSF4uwVUbsHpvPy2eY7llbQKjWuY?=
 =?us-ascii?Q?CG92or99xBD1PUd7VaYHbITtuaXX4+DErMJW/0ITjR952GuIGOvTkI/UxRuj?=
 =?us-ascii?Q?gTVCNotYQCnd457qM4ZC0VDsVZfI8GhYK3gNo8PlKMfmrPXYfu+Q4J/OaA1Q?=
 =?us-ascii?Q?XUjRCHMnyvMbK5/ZefY1Hdnu8IOWoMnUPW5K/ybUDD1TSl41dxEcSWeMkeKN?=
 =?us-ascii?Q?SH2i+ZSucqu1XU/UDP+ibLHZx1MiUXeKs1gwN078cKAPCbKkXHEvRK4RrFAa?=
 =?us-ascii?Q?1GYVhhGh0P6EI8QvURIYBdvK8E3ssR0dNCHoJwrSNLMNUZEqKAPBlDj6QgRy?=
 =?us-ascii?Q?YjjW6zcCaf1cHL5B4nMyjZ4hSeXPhvJpVq/ste51ye2+rFrPtr43MRjTYVrh?=
 =?us-ascii?Q?+6shUh/eAR3CoXozVcHum97ZzCS1bjHAdAe4WxY+ajQytJDdY8LPLYWCpJCz?=
 =?us-ascii?Q?kPGraX+R0aahPpztQJWyVwiZ6qqRBIdmS/VLzINVyVHZvRybrVZCqxGo8T8b?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34deeb6e-6b8f-49a4-4a8d-08dd5d891795
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:02:34.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RT1tJmMfdyh3TgVIXhwS9oqPOkGZH+U0cWIUw9ZSdqTNZDPIB2ksbTBIQSe+/JnIHQzsWMCkDOiTOAL6ddgWig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

On Mon, Mar 03, 2025 at 10:16:33AM +0100, Kurt Kanzenbach wrote:
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index cd1d7b6c1782352094f6867a31b6958c929bbbf4..16d85bdf55a7e9c412c47acf727bca6bc7154c61 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -388,11 +388,9 @@ extern char igc_driver_name[];
>  #define IGC_FLAG_RX_LEGACY		BIT(16)
>  #define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
>  #define IGC_FLAG_TSN_QAV_ENABLED	BIT(18)
> -#define IGC_FLAG_TSN_LEGACY_ENABLED	BIT(19)
>  
>  #define IGC_FLAG_TSN_ANY_ENABLED				\
> -	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED |	\
> -	 IGC_FLAG_TSN_LEGACY_ENABLED)
> +	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED)

How do you and Faizal plan to serialize your changes on these flags?
You delete IGC_FLAG_TSN_LEGACY_ENABLED and he adds
IGC_FLAG_TSN_PREEMPT_ENABLED.

