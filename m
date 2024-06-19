Return-Path: <netdev+bounces-104816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD8890E84A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9E028440F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC3824B2;
	Wed, 19 Jun 2024 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="lEeqdc6V"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2170.outbound.protection.outlook.com [40.92.62.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250FB77F0B;
	Wed, 19 Jun 2024 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792650; cv=fail; b=qO+kojQeKDO5dAmFiy7cacv3K2JYQFOz87KcoDgZtyEOK6hrkFZ8SeEqNG5qDOpoPuAtfYq8y+DH2fNOEfHO+8qDgXNwYb7vc9l+FP8NDe7NMxqpNSnfuwoxytM8/hAB8TpB54QjqN86H1Veb/5DOEo3oss/a/l45JKL8SZxDlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792650; c=relaxed/simple;
	bh=FB+RwikCDM90CmBbeSKDFEONJbjGX53eIV7ZlFM76Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mfmwruu1rZFEjF9okDqci14HrpJHdIdQGmGmaj32Gu/gerEjrAnucyATY5qeXs9Lrdn+tyzHCSUPWcm8u3lo7N9vmCzwJyR3it8wOfdolfMeL3LHUgoexPbSrL4gbqH3Bw7FTqCNjI3+QZPgo6yDqTTnEmR1uGKgxrR/w6U1qsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=lEeqdc6V; arc=fail smtp.client-ip=40.92.62.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7ymeknlNh9n4ezMPAK3iB1xeQsaGUVxmsvTEWjRSBj/06Z7Wf/1YzelhzPeLXVUF2xmc6WDgkJZboMWFdKdGCKIlSlAQLvX9PxhlfSq2N2G+VWebeds5dOtAdJvxLP4G8Cozt8CZSVucee2AMdCHbVzS+fT8i+M6c8fT7yH9VU/Ox7fv07pxsQIXkhg5kYTySPuFxNoEOSJ8UEp5RrXVRy07Jd52Ev1AjG+F1TMBbBmsgiOm43Jdu6HhI7ESI1MalbCjtF2gFdJPmstq8BwkCDU56/MY5BMrDMR6NE4rwgVRDAg1eSJr0expHC+jVyR9QpEqYyW/ZYgZO8ttIV7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKmIK3V1mKadhgiOUtmQI9YtAGcTrv8xYmVnkn7Sv4w=;
 b=JKhm4BjAhrIXUI5ta1KDPucgWdUgr72Iw6AzrWZqtV9UV4rVdwUDtabv1ESzxzaf9q0eaBc3eyq72JvZe6p0R+LjatFbIOwV/n4f2R7yU8HEbKDiKQ1SndK/mKWKi4X3ccGTfl65AzBTDI5bXHaTzYgwZ1BMtKwnXACeahrt1HoEa2LdMjgsA0/gb0884MmEvMNrwVO/Nso12iRDrGSMwFoUynat148UZvA3pRxluNY1p8s88XWpLeiU7efi01rMTOl3cj4/l1zxqO8VGr2+IU0VktweXzlEKURzZygACEqSHq813JtjtC3hDEE8D41BCfVDppNm/vRSEvI7nyZ5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKmIK3V1mKadhgiOUtmQI9YtAGcTrv8xYmVnkn7Sv4w=;
 b=lEeqdc6VcW/4d+wTWJMH2UIZtzuoxNKuj3VwBS3DvaoiV9p8JEqKmdvkF3CO+EcBOinYaFkFtqfKKbk0exTufZF8NpW6CW5QgY2TkuwAnRkQDufqFU1hcO14yAVeFAarIe+pifO8xRAYPV+JPl6z8MY1NB59y9LDOHah0cLBXcPrgaK/j/WffAWypF83RlI2DFAA0wEnlNb/MtD9LPDHSS1nwmcJCb3iydX1F1qK1b5uSgxm86RWQ1lc0XcWJz8xGqaKs3AoztFFB3PvClUtKiwTwKJRLW5C4+17uZfgUxftMR41bPXzkAp1hrYOPnN110QCoNq0MR+amA7IHrdr6g==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 SY6P282MB3991.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1da::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 10:24:02 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 10:24:02 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: ryazanov.s.a@gmail.com,
	Vanillan Wang <songjinjian@hotmail.com>
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com
Subject: Re: [net-next v1] net: wwan: t7xx: Add debug port
Date: Wed, 19 Jun 2024 18:23:40 +0800
Message-ID:
 <SYBP282MB3528E219E1B7A579EE58A2B1BBCF2@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9f934dc7-bfd6-4f3f-a52c-a33f7a662cae@gmail.com>
References: <9f934dc7-bfd6-4f3f-a52c-a33f7a662cae@gmail.com>
Precedence: bulk
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ucemGbQ3PF/uJf2rom3mWg87qjNvwAe9]
X-ClientProxiedBy: SG2PR02CA0116.apcprd02.prod.outlook.com
 (2603:1096:4:92::32) To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240619102340.5308-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|SY6P282MB3991:EE_
X-MS-Office365-Filtering-Correlation-Id: a467297a-c7ab-43e9-e7d1-08dc9049f04e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|440099025|3412199022|2406899036|1710799023;
X-Microsoft-Antispam-Message-Info:
	KwGsrji5tatnoPF8iCa+4GmRqco2UpemrQWdkpEE7m4V0FrRA/gF1lzNhGPX7qeYn2WYIfTiWEluJYBOoZI9cr3LBA0GU7Jnf4OS7bHIvLku9QZmsw+1Ys+wZ4SKD3VXFfb1neR3qDdeZsVPAi5zbVNKkVJ+6cIgtNjg+Z45BA07xWiw1TnWMbmmH/aQIXWWkGrsjOm+p7IdLCTpK2H6d8Xb2Ne6nnwyH8T1FzNxKbHzIH98zQ4pOtqrlVQwAl/Df1JPXXDHmmhGN+kZlAh2uKICgDhYXWbraQxUsdGp4D4AIz8uvwTfSKY3uvVlhXhzSGgJ/WGvL528HqQhy4QT5nsZM9KJS026ub9uZFu1BG3r2Zxksl1Z6jPUzwWAKRR6t9pQFu9V3wcbBiZXMTo1yXdB2l2ddpSm7E6jagBSRq2TNelvVJ0xJDQbqiZUbj5XwT3yx6JZi366lo78bMW8pCPMmLGLl8Tik4ca0qqVyKPviuj5nqlP89I6mXG9p/TSyUhIY2M8PiWB2GK3sY/JYB4eqJN49SFUohiKCXkGhkHmNWJ9bx9Kmgt4fPM0mEvNw0vgMDBGw7dZSDHWkDZTNKe308xApe5nyhUGW0R+cIftkDDiZufy9Y7MicPd3dF4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H3srS8oA0wY7YHFbOO9MvSwPSttbBIoUID6z7txy5vDwurMpsa52i+AZeF3p?=
 =?us-ascii?Q?KxXCgEnbxm5z87qfXqLnx8Cr1qJAhEol4BihExN4L7/Eh5lzkJOcPcv60knB?=
 =?us-ascii?Q?25HE3DNWBG3AMgP4LpFE4ipCJN5wfwdSgzO3tPq3jVeUOoFdZ8kwgndsQIdN?=
 =?us-ascii?Q?zcdptKMOStx/FPX+NYSGimJ4Q3hd2yHP1b9hD9t/ZWseZe+AXexiHQ8/Ts4U?=
 =?us-ascii?Q?0LUdS9Q9lM4tGyPvAMm6GDyuXQkXkn/ycvaKmbL5BHi93NuZi314sDeR6rkN?=
 =?us-ascii?Q?YzglxGzaeqo00Oulwfg8bmhSx/pzm9i98bhMIjOUsYA0P3W+VktfOECku6JV?=
 =?us-ascii?Q?DEfSQjobUmUT5X3OTDFLbwmONVEDcgsuDVIM0mCQch7FIfx3Evk4z+EZfVEP?=
 =?us-ascii?Q?eiZ11P0Hyg4VfCcwOeuuRLWYBm/yYrhLXwIEPVUhxDIO9LG1zRkMdbgvYHza?=
 =?us-ascii?Q?ho1XnCcI/96yehyE68HJoThFZ4pGg7UwR/c0B6PPVRD+g9xJSzpxN87qArKF?=
 =?us-ascii?Q?o4tny11B9bO3Dl2aOUnZxOIoBrVKdZhs5jfZ/UPaYsbXpVqd8okGCFk9q/TZ?=
 =?us-ascii?Q?ZplAYQEmg3iXCy88T2CU2w1AfU2VyO73ZI6gP6k0hIx+oMWVpth4iJAWKz5Q?=
 =?us-ascii?Q?PkQyI+03FKjd9kCx+5GJxxFTlxCWx/7RfcZVT81MpDFcLcQdJ8RZqP6ObtN/?=
 =?us-ascii?Q?IabduZKkkVdDoQYwaKWaqN2Cv81US8d1ww4qBNicflm+OxkhQ912TTnkHhHi?=
 =?us-ascii?Q?d2slvCy2wrNHpyRidAAgvrYk8KPI6eALpHkplPrxktcwMZGc+fxGzX8byREv?=
 =?us-ascii?Q?QtyfDSeSMg+T0zdqOWnaBseZcTj+5UjCG/XiK5kqxjSk72xpZ3aL/pgIOTZN?=
 =?us-ascii?Q?sOPPjOxpZb/FGu14srrsEbDQpYBLa3jVu/+mYRa/YYYRjr5YIXYkVAJt2aoU?=
 =?us-ascii?Q?uqSMiJrPs1e+bw+4zCQnUi32JdLOEPeJKNe6RVr4MG3KGpGXtEdUiVdNVp7u?=
 =?us-ascii?Q?DdEy0XqPSqsNRqWGa8y/1bVtdIUQsw2lFjzoDKyvYmSUc5QTiaWWeKs3Khpn?=
 =?us-ascii?Q?6dIPiCH990JFAHlvcF5VzntQYt6S0BPD0yEWf0xBD45kWhRo9zoYZMzzoHap?=
 =?us-ascii?Q?lsCXwoz15YQvdRZUaZpNLCn84Bfa8HG0Mt0ENeqCMoxlA8TPwe4XedNv2O9o?=
 =?us-ascii?Q?FyZkOTNqE4QkTpmFSUpvFlWDQWT+gdoh35lkx+aNwcGEuKFZWOSKK7I6NNvp?=
 =?us-ascii?Q?SKANoFaPAag27aqPLSgF?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a467297a-c7ab-43e9-e7d1-08dc9049f04e
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 10:24:02.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3991

I think I need add an ADB(Android Debug Bridge) port and a MIPC port
(debug for antenna tuner and noise profile) to WWAN. 

Jinjian,
Best Regards.

