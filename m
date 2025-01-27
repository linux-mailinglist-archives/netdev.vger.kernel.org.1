Return-Path: <netdev+bounces-161052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93935A1CFD0
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 04:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DACE27A06F9
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 03:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA260B8A;
	Mon, 27 Jan 2025 03:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Eo1cVRcp"
X-Original-To: netdev@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020080.outbound.protection.outlook.com [52.101.196.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9513C17;
	Mon, 27 Jan 2025 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737949297; cv=fail; b=ciZ4yg6C9X0DpRNasPxFKURI8t2opeS6ONV+rrJoYhZxSyQ66SY+aWZcb/RVOA2D4dd+AbOumzSnML6apNW32dxIAeFOqVi/9HQTy52rEr9AOhtu6YKxz2Yo/vemgpAcNYDfNWW2Wo3TufOXUIHLShGmQmGqmEumZhyqtrs12nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737949297; c=relaxed/simple;
	bh=yYG5T4N8xL6dOemeuqrfGtG8e7+CyCF69kdoKngrLqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BoBseiLoQXUJxdaP7aOvDW650EMupJGRD7UClxA1LJjVmY7IiBDxs7OABTeuwuygC1LzHFjnWPGCyqbcco4MYK6o5fPJQ+PQct5dgmqj/VIrPdBEwbuLuuKe/r6Mpo82eX6Aq//wdvk7akGY87KZYdlsB0P3KXy5GguLITXP2uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Eo1cVRcp; arc=fail smtp.client-ip=52.101.196.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vztpLv2MTKIsQ3NvMVo79lVVJQh54m0O065OiFTJi4ILaJEQ2A7LUA1Kq049r/RMzX+aA1GZUcyArNV+45X7+FfuO3Am7UCb+bD9Ui9TiQQlYHrKfVVdznYLYqqfJmwFCyC9vkL017TsCMOBIBLcxUcKdKz4pUi5AGMcIhLRPYA1PCuy01xntIvnCS9Jk1AawOCqRYF2wDo3CaSDcjdr7MvCNuOnzL8sjhSw//+aiu2LU7JPJRI2irtPg2NAOMoZKvu7LxHGp7BR9ldNvYOIJ1rY/FRMuEgNHvTPuLLFZ+Czm4QvJgODvSDDCHJkesdXcEoWT29RDxbmmel5CyDfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DuwqAObJ1JQDn+ZnSHLPhRMshriJmihFwqd2GXtRN0=;
 b=wTeZGQtEAukshNhWaU6mhnXMKL8bGZ0otORlKfutdFYOSv7m7jZWYrrnpYXFFyH0uc5Ht/GPcI2V2BjManCkTANf5eUMSUo2/qPWPlPEfpbPhwZqvWexSgQ4Y2+emOXeHaWmfTKgyVU6vdB/LdF75rWa9wAnFWTL2uEa8HjnthyahBrvY5ZrsD68zyLX8yZGOdW7pfr0GdBFCgagn+MPp84rroA4X4MbUGg1uHUcAQe+bm1I2C1EwVVhIjDX7dhnDUltvCQMOsdS+0uoS7TGDJZRrUVxzKvKodhbJwGSBpQ8XZBeVjHeW8NoWS8PqlgQL4toiGTq/p9PeKYopBs5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DuwqAObJ1JQDn+ZnSHLPhRMshriJmihFwqd2GXtRN0=;
 b=Eo1cVRcpkSyhRQahh2kV7xlTroswHTSZYkv0GhFPU0avbr4OPzEx7L53+amCsBWnQuHPH1Sztn+Zm91cUXKSXKkoSyXPzAAcUc/WhRO/fOWOmDh+4jVAu+aJk/k8c/4VJjFwxf0A9BhZFZd6zNY+bJbDMNLT5VsWzphtXauXyEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB3019.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:180::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 27 Jan
 2025 03:41:32 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 03:41:32 +0000
Date: Mon, 27 Jan 2025 11:41:14 +0800
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com
Subject: Re: [PATCH v9 5/8] rust: time: Add wrapper for fsleep() function
Message-ID: <20250127114114.72ef4340@eugeo>
In-Reply-To: <20250125101854.112261-6-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
	<20250125101854.112261-6-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0094.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB3019:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a9c57b-418b-439b-7e1c-08dd3e847d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VRRqUcPR6Wr/V3uGTXtWQ86AeXCxeqLeEkZmQOtz0iCXAbJ1Iuu6ilYEg3oX?=
 =?us-ascii?Q?pmZoAQ0iau9aX6g358Yd/KuJqsrDL7RX7+UizNptGIrQ04QeSwl75RL4ZhzS?=
 =?us-ascii?Q?pB9+oCDiuBp4/tb6BSOKO/5095qW5dqUNdT7PI4KLWq0ryGKpX+BHtYXanQw?=
 =?us-ascii?Q?NyHJDCxZ4Dgi69GchimW1FrOI+y+SqQzVRmL11bCpMMW4avK7o6QX+nE+pAH?=
 =?us-ascii?Q?r/39q+tDEDzDp34+3SAA6ZNd2zBD5CVIMHwBRmiIbFgl0A4bGL02TX0L7SJT?=
 =?us-ascii?Q?BK0tRkjk90DcF8OdaY8l1eNG2ak6/myaiWWWPWIkHtKE2MkQ0o4MJkCkB7bc?=
 =?us-ascii?Q?mjQgogyPcAUTnLEe7XRO1klXW8eaf31kVGOzYg9ngc4qczGRoYzRpcsI8XP2?=
 =?us-ascii?Q?oAq8RBAZvgWcFHiWkpBF9lcOaYShiEf7rvwIJ1DwoN2ah0MSgvz92dwH7txl?=
 =?us-ascii?Q?GnPnOPUjWYhxXy5F+dRMCZGjaiRYJ1PfqaAVLyivAQ3x51Lk8wdwfH0kXayA?=
 =?us-ascii?Q?UYWdw3UknMWENXzk3LCxKBc3lAm8d5h9Pi5BCyXqAW4XTNGvFMU9sYDJdRaF?=
 =?us-ascii?Q?lHkhcPLWuOvlRSAwNLQCu8bdCeHK4KGu74zkIbtA0VAdkLDeTq2HQhJURc6a?=
 =?us-ascii?Q?8l9JRQiTklj28KQUpok+AKVj+UAhKddMDsDzYwX2a1hUfF/SPIYHzR01ivUF?=
 =?us-ascii?Q?vFuxobfXGYwJEZ+jv+1Je4o6UaDTlsaItrnF4CIaQwLvAuVbxF2N8B0W6lsw?=
 =?us-ascii?Q?XZPY0pSNXJZxvV1MGM+kpRyWYnAhSJXEli2qQTDEcPd+UrrpOI1YzM/cLVE7?=
 =?us-ascii?Q?Mbqub6ESa8ToMQaw2QxiGDCO81q3mCa2ENoAUftqyidv4eEu9UGEQTH5mOB8?=
 =?us-ascii?Q?DINX7qw4cRV/cjpMMkTFo/K/GSFtMVu52wcaqDguaNn5PUW2kE2k+XO8nV/e?=
 =?us-ascii?Q?tL2Pvs4wPwrSt6LNBG1kTv1PkWg2ZIe2+Mc1VbkGJxii42YZQQRsuQqHRsqR?=
 =?us-ascii?Q?xxUog53l24zsPmayKBub5aYooRgu+hXNtx3DPG/ENP7fcW9DqIF7rSIG3rHk?=
 =?us-ascii?Q?425dKwqJsBstK3wwCLC91wfT8U6EtA6Y/jUoGapZGd/4BsKxM2+eYX9hSEYI?=
 =?us-ascii?Q?mTDYXhb3JQ+Op6unROBZY7ps5aV4LpDZA3NN1D11MOBVBqvUXuI0aG0cgcW/?=
 =?us-ascii?Q?jKMcJRxq35PvfLVXmVL4tSssuE826hib62DJ0Q2VhUqVu/f4BjQb6vAyHiLC?=
 =?us-ascii?Q?1+x1o+Vk2oPdeDBF/uu90ybY99qf92nUV8W4g7bFBEoqXE5TbFHSgbOXdsaT?=
 =?us-ascii?Q?Sqt9Dg9ZCffvQWcdtVkx+gig?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1BsxrXWP84e2gIBBR6mO33VF2sciq5zYmp413H2WB93ka105L7uIzIkYK20I?=
 =?us-ascii?Q?WOjmpAsQexjlW9vGKXlfcrifXsZXMvZd5cYffPFOB+rOP+4V6jelK2kYuwL7?=
 =?us-ascii?Q?UtZgVb1LY9TLhNUnhJ4sbJyZG3gv83eewxowpWqGrDapKUFfrAZ4BCFXjvCC?=
 =?us-ascii?Q?iYTD4g1/yUjWN7TntjnLfHVjEaA+JwsCL6O567OnqjeiXtgpE6Fq5SYHlLmF?=
 =?us-ascii?Q?KRQP+oHTKiMCEsTyDRq8efNkxPm6q2W94YpTwqP4xZzb/Jv0/VaP1Hs2jOZz?=
 =?us-ascii?Q?o5Mz2d5PWqXLQdtcEdXOxLDzy/afonFyIPaobtUQcowaMOLjKTFMPHCFMjBv?=
 =?us-ascii?Q?vNXZWMkaDJun+Xxqv8y+XdME1F3+pXIbXhIjB8B4HbLgTyq22lZ1sB7TH9G0?=
 =?us-ascii?Q?A0iTJ/k3Ons9zOXawkGxc7f5vTfsZbd8MGflM+X1QSnf2aI8u+Voq7PQNwfo?=
 =?us-ascii?Q?gGjXaMneugwnUiH3u5isMniJH09m/pLpqCzWjKHZ3FkAnHB52eoxyjNW7kk+?=
 =?us-ascii?Q?0VgJxD2lOgMetRXzaHuujGsEB49jdadxnW5GYj/nndHqNdqgiE8CjM/KxnBw?=
 =?us-ascii?Q?Bkemcg2jjvn0ve+u5lgt03CmcX4ri9iAtj2xFzXSKFnBOlCzTkwLii4hjsTP?=
 =?us-ascii?Q?J32QN3Ube90lsqIAFjStqhSYuQYlQQ4fX01ca60FJ6yS3L9PxXneI37fmqM6?=
 =?us-ascii?Q?nAKWz7EOkYY0cCvKtRahZgqC6T5259MzGp+nlLqUC0T4xtIUy2jMCQApgrxz?=
 =?us-ascii?Q?vXwEiAe2S5AgoC8zUsTae8puK0CtPPUJx0AHXY1z7yYM8uvk68hza3PAg6sa?=
 =?us-ascii?Q?gX4WZ3LxTHzaA6hhzBckp2Ya6IzdBhMkVAQ7GQu/0/vFwGZcithEXVkFQ5MV?=
 =?us-ascii?Q?77toJc96IxEHtZ54f2sYdbLv0slKKhHsMPuMXA5Os42NYCuRy563kaQlw6+x?=
 =?us-ascii?Q?ZwYH2ilsfCkY21RGKLmf+Vsu2lIDYg7iHo1e/IVsrk/UMM84/TL45xUr2h0o?=
 =?us-ascii?Q?tly5P0+Ued/zaurAZkSmN07ADMfLe5RPhzdKrpiMZQYDueIQMUJcy5Z0G6XV?=
 =?us-ascii?Q?9Kl+K2LtAcOy1N+iapp6qpTQ8FPGZcB6ZNvwDtd8Zik+ZGvHAT65jbGPIAPv?=
 =?us-ascii?Q?BtiuYJL4tWqyf//XdzXVF+mV0I/fNVLB2YRD4QL8Q9FGb94lmDKVP4NMvF/p?=
 =?us-ascii?Q?Ot7cEXSmedlSazm2T263xZjVKu74uE4J78GoXjHSQo8wwxJNMEPwD8X+2Xwu?=
 =?us-ascii?Q?M/79AVp86SGUs6r1nFHfxkvv5xo2QSFV/5+HzqgP3Boc2znTBQKVU2jn7Glg?=
 =?us-ascii?Q?bhOc/h9pMqv6p3AMEa2Kk+cLu9LUR/Nhrgx1nHBJC4DO1kfjnIP+103IRNWX?=
 =?us-ascii?Q?dZ5gcOj02iq127QhnLmitRS7TJjuag3fhnIWItN2taVVzbwHm+ZtbjubOxeO?=
 =?us-ascii?Q?UGFP2zQj72NR5CYcHht46fSSDMj8lsRyiYcsZJWUj+2yYZEu0ThSBO5aRClE?=
 =?us-ascii?Q?rqVnOi7xjQ5NiBEVA5zr4/wN+NxXES7NPTRFYMxHGS2h40TC2ubEJm0X1fZI?=
 =?us-ascii?Q?4HP6mm9EpLHe4A8ZlYIEppxRBRobao7ZmZ1vkmillW6U/PBuCj3KdpSna6dU?=
 =?us-ascii?Q?kmYBAGG0/fKKmp4RAHq63GwL5rNMTVu8bATBjVEpQzGr?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a9c57b-418b-439b-7e1c-08dd3e847d2a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 03:41:32.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VA7ljDjp1gyPhe+Hw6ZAqWO4PZkvDXHyOEotnnNUBUWrMrBD82/KzyfHSYaKO1IlpSY9ELpfr+eqd3AO9nGqcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3019

On Sat, 25 Jan 2025 19:18:50 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Add a wrapper for fsleep(), flexible sleep functions in
> include/linux/delay.h which typically deals with hardware delays.
> 
> The kernel supports several sleep functions to handle various lengths
> of delay. This adds fsleep(), automatically chooses the best sleep
> method based on a duration.
> 
> sleep functions including fsleep() belongs to TIMERS, not
> TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
> abstraction for TIMEKEEPING. To make Rust abstractions match the C
> side, add rust/kernel/time/delay.rs for this wrapper.
> 
> fsleep() can only be used in a nonatomic context. This requirement is
> not checked by these abstractions, but it is intended that klint [1]
> or a similar tool will be used to check it in the future.
> 
> Link: https://rust-for-linux.com/klint [1]
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers/helpers.c    |  1 +
>  rust/helpers/time.c       |  8 +++++++
>  rust/kernel/time.rs       |  2 ++
>  rust/kernel/time/delay.rs | 49 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+)
>  create mode 100644 rust/helpers/time.c
>  create mode 100644 rust/kernel/time/delay.rs
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index dcf827a61b52..d16aeda7a558 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -26,6 +26,7 @@
>  #include "slab.c"
>  #include "spinlock.c"
>  #include "task.c"
> +#include "time.c"
>  #include "uaccess.c"
>  #include "vmalloc.c"
>  #include "wait.c"
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> new file mode 100644
> index 000000000000..7ae64ad8141d
> --- /dev/null
> +++ b/rust/helpers/time.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/delay.h>
> +
> +void rust_helper_fsleep(unsigned long usecs)
> +{
> +	fsleep(usecs);
> +}
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index d64a05a4f4d1..eeb0f6a7e5d4 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -24,6 +24,8 @@
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>  
> +pub mod delay;
> +
>  /// The number of nanoseconds per microsecond.
>  pub const NSEC_PER_USEC: i64 = bindings::NSEC_PER_USEC as i64;
>  
> diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
> new file mode 100644
> index 000000000000..02b8731433c7
> --- /dev/null
> +++ b/rust/kernel/time/delay.rs
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Delay and sleep primitives.
> +//!
> +//! This module contains the kernel APIs related to delay and sleep that
> +//! have been ported or wrapped for usage by Rust code in the kernel.
> +//!
> +//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
> +
> +use super::Delta;
> +use crate::ffi::c_ulong;
> +
> +/// Sleeps for a given duration at least.
> +///
> +/// Equivalent to the C side [`fsleep()`], flexible sleep function,
> +/// which automatically chooses the best sleep method based on a duration.
> +///
> +/// `delta` must be within `[0, i32::MAX]` microseconds;
> +/// otherwise, it is erroneous behavior. That is, it is considered a bug
> +/// to call this function with an out-of-range value, in which case the function
> +/// will sleep for at least the maximum value in the range and may warn
> +/// in the future.
> +///
> +/// The behavior above differs from the C side [`fsleep()`] for which out-of-range
> +/// values mean "infinite timeout" instead.
> +///
> +/// This function can only be used in a nonatomic context.
> +///
> +/// [`fsleep`]: https://docs.kernel.org/timers/delay_sleep_functions.html#c.fsleep
> +pub fn fsleep(delta: Delta) {
> +    // The maximum value is set to `i32::MAX` microseconds to prevent integer
> +    // overflow inside fsleep, which could lead to unintentional infinite sleep.
> +    const MAX_DELTA: Delta = Delta::from_micros(i32::MAX as i64);
> +
> +    let delta = if (Delta::ZERO..=MAX_DELTA).contains(&delta) {
> +        delta
> +    } else {
> +        // TODO: Add WARN_ONCE() when it's supported.
> +        MAX_DELTA
> +    };
> +
> +    // SAFETY: It is always safe to call `fsleep()` with any duration.
> +    unsafe {
> +        // Convert the duration to microseconds and round up to preserve
> +        // the guarantee; `fsleep()` sleeps for at least the provided duration,
> +        // but that it may sleep for longer under some circumstances.
> +        bindings::fsleep(delta.as_micros_ceil() as c_ulong)
> +    }
> +}


