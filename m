Return-Path: <netdev+bounces-203826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F087AF75CE
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBF44E6C58
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081D42222B4;
	Thu,  3 Jul 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GkLk8fVp"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023E295DA9;
	Thu,  3 Jul 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549701; cv=fail; b=mRzAzZa+Q8b9AGH7t8+nfvQWsma0P1JVOoZYvVzsCvHSFsfCqodPGdzlYvAu22X9qHGE0Stna+AD96SPZb9n7GlQ+UncvZvK7YNm0aEHcnQsQP2MGYcCAbhqtd60hBScvKqfxibfakiX/65k0ntzQX0rmnoGSyF6+I8UEBg3+e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549701; c=relaxed/simple;
	bh=haU5CHY14aE2xh3RsSkWXCWeP/Tf8tyLWpHWfUZW3IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AU3/wqdiIB0OAV0L8rbWMD/wktXj6OKC6Qsp8ISnnCF9DfI4HIUgwxawLUqSwc+pOGHgXaQcCxEhEKWeusCGnv2eYtN1bOYOF59JXyKTqBJv8Ga7xFacHlmLiu1UE8uP3SKSsFqof5JFgvPzuC4a0WGlvbGIeescO+qyZ/zWrTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GkLk8fVp; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDYfaga8X3AQ5eLbjE6WbPMlrgA4BP9oq/3I0cOWkADQXw2A2EE217ySFT5IPt4FTDT0BcNl14ETJ4g/K9VKebYhUf4iZbHI6uZ+Bv8NBsRNhil02EITa1Ut4jiH8SNPYK3IDKqCirH0Z1ZaprlpfyL9cTYMHTdFRq/HHgedBQcwWklHos0yTsesZerU2HO1OiDCsTDp1e6rH3fiAveyPJr1Thp8qG63EN9YeZnbMxVtD4BbgiKGbj92n2qIWqKS6OmoJZlzkO5qEkTJQLtHTI/9nyIB+XBVr4+N+kMwomPlW/qHxtCkAvlIxFXZYADCk3flaQYZBH/dzXbI5O0B+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoIQjxIPTPjyizk2YRmFaBAKkrTHVVibNIhNp7mhWd4=;
 b=xdxHO9SuUHGBey9/a5G/lAP2kh9+cErTAjSppvbQuaP8DX81+fhIH6/KQ8EaOUdemph+MdfWZZqC0uuCTeQZrQ+LoVnrwV1ty8WEF8kMQdAVqrESyp0lFcbT2FT4kLfupPoR9lipxIpGeE+eC10P9wTM3wmdxEGN4ucX8wxywitlevySr/QO33eSjnsOl29vvbp0MnYRT2Wnk4InKyUsgfPnutqqwSTTJmE11qHfH8/Yt6ZLuMWVv95ZzQb0v9B4ovUugZTjIdREj5HFs53NyBRhK2Ua/HVXWrCajWWbSOGx8O5oy0lqQ0lYLP48m7DylyNcMkLPyNyeZbgCu8VZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoIQjxIPTPjyizk2YRmFaBAKkrTHVVibNIhNp7mhWd4=;
 b=GkLk8fVp6NyUq+fSFChcLvgku9rWEt/U0lAnrFqt/k4YjDPYxYF4TWUHs1CNM1Vqv05EH2n5l79xSKxtU0tJz48XMKd9Pfywk2YlzkcVq0kZZA5r8xypYuaNcDYt81jygwYi2ILZdRT0scBwyu0Ch+vo9gOd8vjXKk61UUQ+c+BlNRAAPC9CufNWdjWDPt4tctjtN8cpC0kbQVbCvdIQvMWAU5PX/qOdQT68gBEgITlNIXbD9uDvLMIkHGHZ3bwd9qI8dJ06WsAi3nsC/pG/UAroAaSuG463eET6N6Q/PwrjvI0Gvykke9w+epnJD8aNE+jf0xNaWICT0eZmkC3gBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8600.eurprd04.prod.outlook.com (2603:10a6:10:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 13:34:56 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 13:34:56 +0000
Date: Thu, 3 Jul 2025 16:34:50 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ptp: remove unnecessary mutex lock in
 ptp_clock_unregister()
Message-ID: <20250703133450.kaoncopz3i2ileug@skbuf>
References: <20250703055340.55158-1-aha310510@gmail.com>
 <20250703055340.55158-1-aha310510@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703055340.55158-1-aha310510@gmail.com>
 <20250703055340.55158-1-aha310510@gmail.com>
X-ClientProxiedBy: VI1PR09CA0138.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::22) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 38216377-a02b-4efc-cf22-08ddba36665d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1NHERNDsAMozpfC6F+lkrvdkv7GD40t5gIpR7ISCSddAWYrKN9iBgfNq8UuM?=
 =?us-ascii?Q?EMeddjNu7NY3YtpGs97Gqfp2I6XPCNQmXD4iwCPvpNW17cWw4WtLW2boOuia?=
 =?us-ascii?Q?dll6Un3y9EpiwMB6uy7BcoNiTAc8qj//MeHkYjniZVieWXPYCl4jksood/ZO?=
 =?us-ascii?Q?6u1vq0K4tWyxgSxxuypEzNcKNJahwY/KUfa1xTY8ISsvZ1od/s1ZWhd886VK?=
 =?us-ascii?Q?Ec1/ghj9f1t+5XXVPNsDPMlmh57cg3tzdIcAOil59D4/knM6tCogBwix/Wu9?=
 =?us-ascii?Q?1FexxTqZVGkJkZwpd3VLgDkFXs39edYkRwD4YfPXRJ8ejfONOmTkXpRGwAkp?=
 =?us-ascii?Q?DrQDr5u3mjC11NrmoIkgpKHaZpvI2s83d0n76k0OTgvspHLpnKErHLy8ZiFX?=
 =?us-ascii?Q?dVYpMUVklg5tFa1M8RMvrTWjRYbWyXW34Zo7BPACPoekHjjfTtMvIWdN19ZU?=
 =?us-ascii?Q?elC8kNhqn6SXTIro1Pil85iIMEDTa2nMkrR7zGaow9NM3CXH2hbsIPpIqxfY?=
 =?us-ascii?Q?NcmRY73SrtE3/mmA3yiBcyd3EuoEwpUWa1EwuyhTrqavBCkuX/QcMqVMbW/k?=
 =?us-ascii?Q?7ckH6copNgJm3ZCrP7cFMrZtfdCCGgq9HZGnTcZ9So0bRCIXm8sbgsMYh7j9?=
 =?us-ascii?Q?KguFyVZN0zkfU18OaV08IUH4WS+JsurDQ8aipfMuCaL+tHDLOmaJhr7/D//w?=
 =?us-ascii?Q?4AXHKaURo40/nl+fedsQ6WQg395vjqU4Qe7Eu4XRrH3gBQJDy/rgtSa2Gnzt?=
 =?us-ascii?Q?TQe9Yv+uZdvibNUS65UF8sMZg8s2reoVtIYSxyKJdJEoDDliX9g2o8IxCzzh?=
 =?us-ascii?Q?RCwPRBMJE0e7jdIoDx88N0K3S4JOHsyCvZa52CWSBs/6YqUxOCT3NY+t4nfj?=
 =?us-ascii?Q?IIRGwVDv75s3ndQhxzFI7ALx/xbSzp0i/pS1lEvgBRVK30Q6C4yk7JfCh4q5?=
 =?us-ascii?Q?zxtmKPjKyiwjDoQrLooS2j22ePik9ydvf1kP0YoapFFegZO4vnVBzAbrk1AW?=
 =?us-ascii?Q?CNg1tLm5ruyqy3oPqVfs3ADnmjaLnLr7opheH4t2fRH+Gng+7wHXwr80jJXx?=
 =?us-ascii?Q?+ZYuGCQ2ZBjPl/cv6/rfpirTBxyXtJ6fq8oH86L3yP1xiwMwQtxLxnGxyNmK?=
 =?us-ascii?Q?d7ox7Beerd0s1cnKYK9L/clf2ujeQ57fyvlXNUkE1hHpXCOCqfj7kBiXulra?=
 =?us-ascii?Q?pS8Jkos/yGQalfT256la8SipY5Tu4AS1GJYcVxV1i1w/Jbd14NYtKiVMEQm+?=
 =?us-ascii?Q?ZaUiAGNYDIo2VWec3mSkAOjoWzbvb1z7h7YCAmK2g1AVk9KhfMCqpeYEAwxA?=
 =?us-ascii?Q?zlpqX4SnJcL+GtY6DDT9LeOpgaGrHT3EFiKxptF322zuY6iD1AqgQbmRyUcs?=
 =?us-ascii?Q?vmhKwkwPph6Wf0AzQY/8OlUcOOqFKmDz97O2V4jwAldsTMKadQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RiFrzf4Bx/lXSE1vbS7Devih96amdZ4PZVhUmuLksx4OTqC7q2/v2gguxXHm?=
 =?us-ascii?Q?xw52euVPbNcTAUmfsKSjjwS9FKa0oMhEk9XdwN2oSpFiIxD9qW5vi+igaz/u?=
 =?us-ascii?Q?m84Cq2NsoywBR0tWzGBKHnFUc1UM6ZkN3c2XsAsWpjiD3KcQXlDHhD9aS0hA?=
 =?us-ascii?Q?V2DfSpj1r1q32qqzB3RdOjACDuhyrtILlYFiaUyTQYQ5PKdrh0pzjCvTCgee?=
 =?us-ascii?Q?K+N5q8gjU1gj/tw0hO3mKblNYVe7aJH0IqQ6fNhpVJPjVE5SS01/luwIaM6P?=
 =?us-ascii?Q?MlEATZpj8KTkNJGLaBIXdzZF2oHq9voZhY2CYklqbTMwTH+jkhhSJvSmwVgI?=
 =?us-ascii?Q?4XoL4iuY1N8URX18LgcMLO7AeBnxzjB65mLLJJ2iWs9cfPM2ZylagkNmj/br?=
 =?us-ascii?Q?luP4F+LXNWhqtiU71s8DLlEknd6DYFxzkkn9CwfJakBDiHdGcWANoMhaCw87?=
 =?us-ascii?Q?raohNwHeeJrkR88GnXJ9ZahBqexY1gmwN/On10FAXbKsfiiD2cW6lQTMPu0K?=
 =?us-ascii?Q?cY1JeuKsMEEm1t1NGXA3Jmrw0mUM+61F3tUb4+6VnuA+WyyiEnqPIYG70Ez4?=
 =?us-ascii?Q?UmRFeLprcOeYQUyKG6m12gRDe90qYB2cbzXeJx7CDC68s1Me/iztcBlATptC?=
 =?us-ascii?Q?8NjzBJc55WfqZ8+HBlp6wBXj+qdxOsJiP6jkGriQitI5VvBwKc9wDKvoSvXz?=
 =?us-ascii?Q?VYXzMMprKJ/uNGYEPSNsGYwEhZ0sT6YjE4a8ZshHhKaq+riOFCgnWO/7sqeD?=
 =?us-ascii?Q?GifRQ7qxmKTjpIt/wdt/b45d8G0L75IG5jGIIgdM+Lo/RnlVgOKZ+e+X8JGe?=
 =?us-ascii?Q?ffrElJk8g9sXnWfzsWnOFR9zIy+eiBdETqsQ2yMXeEYkxbtwFlmzdFI57fx2?=
 =?us-ascii?Q?vMXwcK7v2gQaDT8PtDzgHoWq7r7DHrIu+OESfvIRgkwOiExM1vqiB7XNJVis?=
 =?us-ascii?Q?WkjHLysun0Asr4UkoQXbN8SczDH6+omT05qvbYx7L/dv93LfgZxqlNpc3tPH?=
 =?us-ascii?Q?JqhY4DC5ss642/LodIr38nSoYg0ik+z3XGDnClaUnDqFG+eRXnkbI+/pw/6Z?=
 =?us-ascii?Q?xxHr205ZGxpP0e07Ti+KpHURlvp/2mTTcW8mZvHRbcdzvQa61QCVIOzW/bXi?=
 =?us-ascii?Q?TBvbcbvPhG896NgFSnJFxhy0Oia3Fj6Xy9D2EPfFonTHSJr61bQ/IVbOKMMF?=
 =?us-ascii?Q?o4gZSnB580tI4ou6BS5vH/6cJ4+hJBExXtpRYBpZtaPtbz0ZeZcARL+xmIPC?=
 =?us-ascii?Q?W2Bi1JfxnGC5T+fq80rc7vuoLQfVvfAGyiuszP+fnuFLdgTXzNl9rlvm8wGy?=
 =?us-ascii?Q?VgHHw+Jx5tfelXF2C/z5qoWZYF4QOwltsN53jkmYkny5L6UAKZwDC+SXyNkC?=
 =?us-ascii?Q?5WGrxLQgSgLbwZPDefG9dZF+YzSo9BVgnwWke2bj1q3hqEVwUcd0VzQwyL/5?=
 =?us-ascii?Q?hvdRFRERaJShgbRpq/7vayPSAjIZLrGChdAqzCZwn77vi7dwpMYHIxQ+2kMn?=
 =?us-ascii?Q?OKYnlwbw9HKPyPoYEJe4B4P6jaAJ8VI/ISGo2og3+B2DhaFcDVXBE5JAZQ6z?=
 =?us-ascii?Q?u9jxnMCvVCl+QzNT3a1OMJFMzhkaZgQgx3JFBh7SaW/y2F9BU6D2LwzHbv1f?=
 =?us-ascii?Q?J55FhduNWSfc95/R6doVGNr70uctu2I1Y9FJFeJvZvGDyRMvqM6UJogByo4B?=
 =?us-ascii?Q?7kUErg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38216377-a02b-4efc-cf22-08ddba36665d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 13:34:56.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vJRyvsY5gzA/zjvzs5VbkKWF23vzzCFZpMG25M0QautDToDfaKuCXOkLfVqYO3ZHFyh/kxY7n1w10/acufn3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8600

On Thu, Jul 03, 2025 at 02:53:40PM +0900, Jeongjun Park wrote:
> ptp_clock_unregister() is called by ptp core and several drivers that
> require ptp clock feature. And in this function, ptp_vclock_in_use()
> is called to check if ptp virtual clock is in use, and
> ptp->is_virtual_clock, ptp->n_vclocks are checked.
> 
> It is true that you should always check ptp->is_virtual_clock to see if
> you are using ptp virtual clock, but you do not necessarily need to
> check ptp->n_vclocks.
> 
> ptp->n_vclocks is a feature need by ptp sysfs or some ptp cores, so in
> most cases, except for these callers, it is not necessary to check.
> 
> The problem is that ptp_clock_unregister() checks ptp->n_vclocks even
> when called by a driver other than the ptp core, and acquires
> ptp->n_vclocks_mux to avoid concurrency issues when checking.
> 
> I think this logic is inefficient,

Can you present a single metric by which you qualify this logic as
inefficient?

> so I think it would be appropriate to modify the caller function that
> must check ptp->n_vclocks to check ptp->n_vclocks in advance before
> calling ptp_clock_unregister().

And which are the call sites of ptp_clock_unregister() which should
check ptp->n_vclocks in advance, in your proposal?

