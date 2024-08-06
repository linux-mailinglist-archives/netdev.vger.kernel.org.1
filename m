Return-Path: <netdev+bounces-116054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B5C948DC6
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72231C218E1
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8871C3785;
	Tue,  6 Aug 2024 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mHZob7x8"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E813B2AC;
	Tue,  6 Aug 2024 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944191; cv=fail; b=PBze22+tEMjhrBb+VKE/s+l0fV7sd+JOiMAf5t9b8TvXmw20pDfXR2NKmpXc/UuFR7LX/7G+YiAxQ0JtF2j/Xg2punsqjqqnJlp4IJQ3hFlHT0Mv6dwkoO2X93ERriTD97AXf9XNWc23kSdiipHNmFK6O/TYoU7LUG6riSumRQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944191; c=relaxed/simple;
	bh=VOzWBDiwkshFIwsqfj9yTNMkX2gVTlTV88unDLFVpyk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bjC33OjmyzvLEnQrZIPon1msTLlntjh/zS5qgy8xWFpmyCIRP7UIGf2rM0K6/X6ECFeb/kMSAzT7ATOv60XgbfBcimyu8R7S5GMBg2m4dpIgA/rXvxfDy/s0Y8Kl96a/SO8MgUeJiLqW4Bl4VN5h6e3TpOkpLbM4JLW2E9kKaEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mHZob7x8; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s36zgR6YyeA1nXaFSNd1NdXjfzCYq3oqvfYpuPuVQvi3RVj02pf1tKgyht1LiIq1qffIWIqwdaGFKBzAXGfPF0GSe7kwsRQZWodqxvRdDs2NgCEvRReKi2YEZjB19Y9OB2fVBzKLQ11Trz+/6BMGyoY0KACsvgDAQaUgJCkPK8MxN725AiiRsZn4hdDNUBuK6drZvNY+PTaEvgcHSX8CBaHJh5w3VwgBXbVB5yrQd379GyH41EOdSqrxABjmI5n4pGhIVbGqHfR9pMcu3I5Hc9n9wNEFJqUahx9laBbIRF9YgSpQzWNg8nsVMDw3uzxM4ZMoz0v6wU+xe6s7/2UzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJQiac1Xwa8HVgomNWqxvg8r3q89VX8DOy4gmIIuANQ=;
 b=iipBVRmIlrDJKPVdztVJQd2+HwKZI3t+E5kAZbZxVyhSMCp667T5xYgX/lAi7Yz1qJMQtxDhnlv0gtKaZYck+tlXt3IFQTcTlg6UchYGI3I6aLnkGhTa920MrzzQNE9dyIBULR/QQaJAW7r+IKTI2bjq4mUfwUvw3x9Efbb0CuNQdqWHwbQsRhZX9zoh2rns2xOZFUOCicTWuRcQAaCBx/2vnsfgQBGmP1dmDHmpZT/Gw5pbSi0v9zRFBlC40eJXpuVRbEXpVd8Zce9ibZamZa65fJGtlsiHHe2aWn2LruibObTy0DJ2VJvnK8flcwtmQNisw8OHfvU4RXInVEI1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJQiac1Xwa8HVgomNWqxvg8r3q89VX8DOy4gmIIuANQ=;
 b=mHZob7x88qW4eduD/5bjLoLMHOMso7/TXaSjIA6INmLNCJ2+cIB4cbBCrqjrtwHRJ/mc18Y1vXelM6wK/UytmC4kipkN+ViiNwB/N5lquwZSC6FJ5iX4CFD5seZ7gkPsKXMl6i1Mb6cemeRW+yW/ExT5uU8xfasph96iKoxrn0TueI+xh/+t0VWyPq4HXoQzpd0tX5CLFz+TkiuTzIRDnvKA/WHto2ny2lmWT33sZAYME3MVquNKmVrqe4X0YK6Ih+9zYmUsBzie72DNUBQP6gOUyPmUfe5ENehQqm0vBqVP3uBZRbTxafx8PdN5WPkY8dI6ZAIyVnw5ScSV+qFLxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AM9PR04MB8779.eurprd04.prod.outlook.com (2603:10a6:20b:40a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 11:36:26 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%5]) with mapi id 15.20.7828.021; Tue, 6 Aug 2024
 11:36:26 +0000
Date: Tue, 6 Aug 2024 14:36:22 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jon Hunter <jonathanh@nvidia.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Brad Griffis <bgriffis@nvidia.com>
Subject: Re: [RESEND PATCH net-next v3 2/4] net: phy: aquantia: wait for FW
 reset before checking the vendor ID
Message-ID: <20240806113622.g5ixwcwiw3vpidc3@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqjNQW5HhTUgCc5x@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1P195CA0064.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::17) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AM9PR04MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 140accc2-8d12-4e6c-f298-08dcb60c0166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JBpK3EeiBKMLMAzNHEXtxVKcFzmp6HE2bbTQI3eH4mXBfRXam2Fz+9xzlJyg?=
 =?us-ascii?Q?I2ovQ36aXpfEFDQ6crvyqXnMHY+5OAsGvlcs6bXM4R3icoa1L+89h1vkyyy2?=
 =?us-ascii?Q?k+QU1do2BLjVmuZvTJDGelexk6UXwzaI2HvxtPPDPuS+w0/hDUAqeM2JxeHb?=
 =?us-ascii?Q?uoE5bjTaq/CTplUMls+8CC6XWvpbkBrv+imyBmVyN4a4Q8heDacPWFJz6JQC?=
 =?us-ascii?Q?GQGsc3LjlqWWTep0Kmzflqh/+YiRIy33STfy6lmlThbN9QZlkB9Qbja+9EsQ?=
 =?us-ascii?Q?0E02IgkkQQ2oqmrHOii+f3iAPo3KnoCc/brq5E79YW0XsrxTzmRVbaY7Spqs?=
 =?us-ascii?Q?8X+0mDeQVW06UXKctoz+i0uWOgD8O6AIAw/SDbeJzvVtq9O3p01Lruxeznsc?=
 =?us-ascii?Q?ejNh/nP3P3WRAxM4Sbq1t/fAt1XKknoykzwwC3Xe2PCf8RKl65ZArIqdxRuR?=
 =?us-ascii?Q?bh5Z+ueqkpdgOVf2gR72gbaMn3fmSU79V5OYz1PSoNdzu+C2GdehMNHi5PGO?=
 =?us-ascii?Q?V6FeDxD15/71dBOzWnitC8/XciTY+GwW02oTwdPa+N9gIoOpZN4FQfdONbOd?=
 =?us-ascii?Q?uIOMlDjTHq6i+IjXIDsQWwQsalSICe3Aa9C/2m1o00Fq3uWwwTIFFAhw3/sV?=
 =?us-ascii?Q?FLatNHVwDTQ9QgO+5dJIKZ7srH7LyO9jUlBFXfgumd22dPcSuQ61qbTc3Qpd?=
 =?us-ascii?Q?TsDuRrm77ER/6EjxKB7m2YffTDFg9UBQbGexrU3z3Nn7/q/8V/ygxvhckTZs?=
 =?us-ascii?Q?dJX4L+mDvU195FJhOA7nPBhPwjoT9fDaf+HYOeCfIp/hf51R3yqtHBWgIrHX?=
 =?us-ascii?Q?HtlHcrlzbm5Bgt+hEoXbuKc6e9wJb2N3iyUJGkuTZYPV2aLJrdJu8jA3SwpR?=
 =?us-ascii?Q?u0LhzC/r3TsGP1YPQndqlvWVlV1omIRshYEgHIxnGJhDQu49/NtimUDZQuVo?=
 =?us-ascii?Q?ZKWh1n/rt4pPAITHAfaYu/QGhNbVWb7Kd8gmsMRDiyf2m0luVbaaWsGP8WkP?=
 =?us-ascii?Q?lJdRgTqvjmyi3FUvlaiO32v/yImmk4eU0KnXsYqbCMUqpzwNsoiIBFneM1jz?=
 =?us-ascii?Q?UhpvAlOStVIYVdnkcwbWuW+nB3tMA+eEAZiECkYQNmk1fkag7ugNGh5OwXf4?=
 =?us-ascii?Q?PsidZaIQYktGqGGi9hdzGq1rjjbus6fEwlqji+4fmSHfkGyuNsruaxQe7thE?=
 =?us-ascii?Q?/8mzcPrtCgkxycNVMgLfDzFsHPa2YtLdXNGu69LndXX08q7VhL106qKRq/Ql?=
 =?us-ascii?Q?DKo/IJ1eS71ITtjVhPIBZS6W0vaCZKBkQUXNA132QJrYYgKIW/1njX9h7sQx?=
 =?us-ascii?Q?p22IiEimp+mf0lf1xJLvhatqpMxPeGsbDVDXbe3PRJzDuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hH5WbK3ZoNzGxvhklC9Rg29Yl4qXokCBVf4IsHxpr8kQgNYNu7rdN7Iexx5+?=
 =?us-ascii?Q?ID9lNfS8I5+6hKtYNYhFS2U47vB26enPOP0D579tZHhPKAqg3JVqnL+berEM?=
 =?us-ascii?Q?RQF79w540IeV1jNUeZ+7ishIsjOkfa9+s/yddhZBlOA+qsVyWDzhhjBw69TP?=
 =?us-ascii?Q?FJH/zO/MZA9FahsefxfHsh8fiS+7uwzoYXTPyj6EANxS1OoLTu3mj4NHUucA?=
 =?us-ascii?Q?5gvnuVChP3rXpOKC+0+nAu5P2KX6/dZPB5qGOq0Xga67PY8VRWmaTvXmc/Nb?=
 =?us-ascii?Q?4S11U3BTIo4kQJB9j5ReZvHvoYFxbaA6aAIiGl0PRl4pz5/J51n5tdxhQxRW?=
 =?us-ascii?Q?VgN5BfcuHVUcL3VpBfmkFN6sHjcQFYLThM8QmsIRykJTJwzxxYbZzwTBkg36?=
 =?us-ascii?Q?JUACF+8voHLg7qPsS/HYEyo85At4YDatrcokRlcdnbfZLLxGUrp64T8HET0s?=
 =?us-ascii?Q?eFxEffGvRHb1rOVc7wyMpDNhESrhnjhs7hyNTNvzxSl2gludz/CnFLElBF9P?=
 =?us-ascii?Q?eQqvXpE7s2wmxIvhTvT2L9PCyYNauOr1aWDPoMdwyI++yOpKkxv96REp54aM?=
 =?us-ascii?Q?FkvW8CCeUqmuNgRFtEqxmygA9bAwmAc0aYsf40RYqDnRlA6F/ypDHWhsOZSz?=
 =?us-ascii?Q?/w40Fs7kxHsEi9wnlfStc3kCJxlFvFfGBTIQNrJPbAGTfCOsFqGEV6tQz18f?=
 =?us-ascii?Q?EWAo6NTlA/4Ek1/fGgzhOCDyBbc//zBvcTGbfJhVLspSVXRsGNU3gh9yo8pV?=
 =?us-ascii?Q?ebKvlNUkIDGiwfRhF6XMYNEP6SPXVJ7JXMvEfYQzNTkI7QEITt60j9Drwxlo?=
 =?us-ascii?Q?1Ng6mUcjxu9omQAOK0j0zh62q9Jbh/Le0U1Acxpp85R8y1ya5/tDdoiq6IMT?=
 =?us-ascii?Q?FzuZHba4l4FaTGuqe71Hs59/zYuyLyXHRH7qINJEf/KoptzA+NsxWKlKYjRX?=
 =?us-ascii?Q?HZ+u2jJ4qSd2y/7raz6M+kFCk99UpQtN1OUkduCaHLyzzqTkxGD5m8JRdYyC?=
 =?us-ascii?Q?KuFzNJozWa7Iww/wJsTcC2z58Lt2LQhHsV99eNuHwaNov+bs2T5YCyfp5SIO?=
 =?us-ascii?Q?/Iu5LLF5IKG5bDhZ4gmQ4dm6gYuyQnpY5h1tflzv9tpBPvipcpAW311BF/i1?=
 =?us-ascii?Q?hycdF/9SoL1bvCJdo/ut4DUWxx0IddwIXggHyT9kgKXClkX7MkvdPZmB42j6?=
 =?us-ascii?Q?PZeTQTn9d8nj6+D4ChaIVZ/7Vf1PeHBTxwSUM0ydnPPs0AY0MYxAocnHcCi5?=
 =?us-ascii?Q?o92d+/V7XrEZtDBfkWf+SdDfmDN06ZETorDjJSeOZZZkkbv4hxlgtnPgHDug?=
 =?us-ascii?Q?2jNVfQtnupL91J8kU898QOLsolO0LK2rYdBvNnXj44ld9jlYfSB0Sx0GEITi?=
 =?us-ascii?Q?uIjaLPlP/44/6ySsF4Cz+d5AtMx+0aBvTvF8iP40XNUZSAosN9KWS4Ahiobt?=
 =?us-ascii?Q?Hl7ipyRgQVRLLhBDsahBkO4ikuGFRQOHD5Ml4X5YzmYjWXL6PCVj2irk/UAP?=
 =?us-ascii?Q?3S4+wSXsGH9mESBaM+u/SLWalEKTIgpFBlqqd7GQKuaPIBWrn6lD/u/2D6XR?=
 =?us-ascii?Q?qO9P66rP0+SIHB45TvgfPNBUV79xJW0hhG6mXLr3PSMzgIqt/9lkeZFtL7kV?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140accc2-8d12-4e6c-f298-08dcb60c0166
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 11:36:26.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xwXo0F0aw3q0L4SF3/VoVmGBrCz68KqeQIj1IrGnyhzH32of1tUys3PCTLmq03wK/M39rptg/HzRgOLg7jY3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8779

Hi Russell,

On Tue, Jul 30, 2024 at 12:23:45PM +0100, Russell King (Oracle) wrote:
> > If it times out, then it would appear that with the above code we don't
> > attempt to load the firmware by any other means?
> 
> I'm also wondering about aqr_wait_reset_complete(). It uses
> phy_read_mmd_poll_timeout(), which prints an error message if it times
> out (which means no firmware has been loaded.) If we're then going on to
> attempt to load firmware, the error is not an error at all. So, I think
> while phy_read_poll_timeout() is nice and convenient, we need something
> like:
> 
> #define phy_read_poll_timeout_quiet(phydev, regnum, val, cond, sleep_us, \
>                                     timeout_us, sleep_before_read) \
> ({ \
>         int __ret, __val; \
>         __ret = read_poll_timeout(__val = phy_read, val, \
>                                   __val < 0 || (cond), \
>                 sleep_us, timeout_us, sleep_before_read, phydev, regnum); \
>         if (__val < 0) \
>                 __ret = __val; \
>         __ret; \
> })
> 
> #define phy_read_poll_timeout(phydev, regnum, val, cond, sleep_us, \
>                                 timeout_us, sleep_before_read) \
> ({ \
>         int __ret = phy_read_poll_timeout_quiet(phydev, regnum, val, cond, \
> 						sleep_us, timeout_us, \
> 						sleep_before_read); \
>         if (__ret) \
>                 phydev_err(phydev, "%s failed: %d\n", __func__, __ret); \
>         __ret; \
> })
> 
> and aqr_wait_reset_complete() needs to use phy_read_poll_timeout_quiet().

I agree that aqr_wait_reset_complete() shouldn't have built-in prints in it,
as long as failures are also expected. Maybe an alternative option would
be for aqr_wait_reset_complete() to manually roll a call to read_poll_timeout(),
considering how it would be nice for _actual_ errors (not -ETIMEDOUT)
from phy_read_mmd() to still be logged.

But it seems strange that the driver has to time out on a 2 second poll,
and then it's still not sure why VEND1_GLOBAL_FW_ID still reads 0?
Is it because there's no firmware, or because there is, but it hasn't
waited for long enough?

I haven't followed the development of AQR firmware loading. Isn't there
a faster and more reliable way of determining whether there is firmware
in the first place? It could give the driver a 2 second boot-time speedup,
plus more confidence.

