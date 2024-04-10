Return-Path: <netdev+bounces-86746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D508A0257
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56781F23A06
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E71836EF;
	Wed, 10 Apr 2024 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HFvtkUL/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2112.outbound.protection.outlook.com [40.107.101.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D51E877
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785751; cv=fail; b=T2svRDfYhOAa6t50UL98AHaukD4l0yb4dMPzdTsfShafJte5nadXvTsgU0RGoa9YzMDhJSVEZQsRoMjuxRRwEyo2EJ5z9cQCrtoaPCdVLiVbHw44rhFBW+dnUOi9RuyNMklg4Av3Ve762XuPryqWw/QR8vnNzoAglKcMIUkXGzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785751; c=relaxed/simple;
	bh=JSAcyN54v8tJDltb78el0S9oRNOZVig2x1Kvmo7kK2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sPSptaAOIrAIgZ0sKi7nEPI2oeAjoqngr5A8Uo3fc7A25XbhB5PYFN25CwM9Jq6+OBnNRbcFIvYLwMQIxjsGdrkNneOj5yXVfs7csrKXTZaW/RMEAv2TYE6raPwRGF2zRtHrAIuL+IHKS855y7F8p04DDKd0oIBJ1LQ1yjTUuM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HFvtkUL/; arc=fail smtp.client-ip=40.107.101.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6SSgIiDZcxyvUJaEGBRGm4BzQKqoeTWs7kJcKyG6WBaullTVSBlpmEIYhjFkHRKIiDUpz1Irb1rwyfijwg/cybcIv/yHeutQsq81HeQ33Eugoj0FyFOuht5MRUMAmpdd5XWNUXwsKJlfYqAzltwI/zIFFRg+deq/uxgV3aiUESJsf0BVTrr8Sc7fDjjGFPixBIQxmdYmrqmJ0GSHSVCd14pYCRneNFtUMO+93YeMJj2gy2EQ6V4Q8/l12GPtt0xxx9LG8VAMqIvAI5kTvJaWtmtlNL8Yi8muu7ciTIf1szdGrexvgveXS+e2oksmOGLTXQkUoZp5mcmVopkpGFLkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE0u/t7QNSR126NPhuncFnYS4xFQ1YM2rWPHMrgaFsY=;
 b=AuOzMdvJi9zbEGTz1KV3O4XD83YXKSj/dGr0P6p+lZPDz32LfhnN13Z6mUiRg1l6/Z8OQ0Bdl4RzDK9hqEt2l+w8pWN1hOwEhdi/Xmkio1p6O7P2NvXRIOTUi1Jmju5zblicqO8Lh6j0DondGBF7zb6XpYO35akbIIeYzk0HOir6E/rtlks3vD3gmCzHvBGGkgYY2yXwg4yiR31Tv0ZQRkEu0I2yKHYQnEpNWOubX7hNYL9jFgYBpaEXL/kfDKQlemiA/syaUdQ4530Sdfi+X8NCE2xM0iJ0QPTFXscTs0tYu3wZ2F8YEs4Ex6EkF4iaoYyG0rpNUjmSH/Kc4LCUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE0u/t7QNSR126NPhuncFnYS4xFQ1YM2rWPHMrgaFsY=;
 b=HFvtkUL/92dpQPsZKsR/bZ2iKr8+UYIHImr/2BUZT5OohIXPTMRfsdXVACjIyfjRl99FM276JZIpcyr5dSoTp63V5aHd8xbq2NHCOFAKg2PSqzbYOO5NY/BUKGR/oYXqGTqguCzKOHCDFQd9bVnXGFPjBQyZ7fDYvjHmJcwXR74=
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Wed, 10 Apr 2024 21:49:07 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::11ac:76e:24ce:4cb1]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::11ac:76e:24ce:4cb1%4]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 21:49:07 +0000
Message-ID: <eb4f8216-a25d-4622-a9df-de3c7b4558dd@amd.com>
Date: Wed, 10 Apr 2024 14:49:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 1/4] net: ena: Fix potential sign extension issue
To: darinzon@amazon.com, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
 Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
 <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>,
 "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
 "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
 <ofirt@amazon.com>, Netanel Belgazal <netanel@annapurnalabs.com>,
 Sameeh Jubran <sameehj@amazon.com>
References: <20240410091358.16289-1-darinzon@amazon.com>
 <20240410091358.16289-2-darinzon@amazon.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240410091358.16289-2-darinzon@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH3PEPF000040A2.namprd05.prod.outlook.com
 (2603:10b6:518:1::56) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA0PR12MB4495:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VzYSas20uCdF7Dr/P5ojuKTRy8KdmgKz7MxwYQug4gCTlg1ofP/d67v/EXnCiUEYisCNuVz9OgvGX/1GNgnReQTT8rVgT8oDues7hyfnfRfNf+ZnGJ6hpeRIwld0JHJ6waQNNZk331LYYlhEBtBhMuwBScozCoGmuC7QMchxpVqkTyQRZpZadrNPBL/HIfUl7otGVemqGB81tdH9Z87QXaLOXQjVDtTbfk2kAWXNGTEpy0edhmlMw7zMV7D/eTDTNxn97BoVe8AdmJ0TAXCie2Q4mWG20HY2P9ashyZp9Y0QuoM1EFsetB4ud80HbwJ1B/TfDyCuAWCzY4ss/VHBgfBlj5zcNN2Go/+F7SFSqIWIbO9rp8+JyrfuWoB9wo23ZL1FCO2O806RtPiG84Xat1cafRboSq9dAaOliypLZFUIKvLDG1QrgHWN9vUQgE/Yn1TiX2opttcJSrt78MdDBZ6nqnNz5JBiH4HH3MG7ZQAmO8OVzFBp2sQABqzwMJzU0F+Z3xxGUHRzKRyFGznm4reNnbx2dMPUbpYGfQrN2Iu97JByasR8F5gK/D1AAt7UJuxxyLmmcpxYr0UslJFh6k70L4zQET630VdeUtTLu53lp2AnYLmq5GJJyA7OgBDgLY1P98VDlVgGAbaNMADmcX2gSCvX3WmT5B0be+6mtqs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2pwZzFRbFpJQjRvRXJ2SXViVHRlMEI4anc2L0VQR2JGTXZXM1hSalltanR3?=
 =?utf-8?B?M3NBckU2ck5pQXhTRVR1M0lkNDkzZWlOSjhHdHV3OGQ1TG8xWXZhcHpRSVVN?=
 =?utf-8?B?ZkFMWDlUOTBqdEJ0WEtsTkR5dWUrZXFhMHdsU3RhZkppbjMyL21Sc09Pd08v?=
 =?utf-8?B?OFMvYWNxWU5oY1ErcFNCMFNXd09zWjljT0FGaDFYbjNhQkw5SG0xREJESjBr?=
 =?utf-8?B?Yzh4R25QUDhUMHpVdVJmVVZpNC9HTDN4K3l6SzJJOXlRYkhJQ1hRTmN5M0Nr?=
 =?utf-8?B?NXQrMzRMRk9qdDVmN2RqYXNnL0p0aS8rYmxSRyticjlhZHh0VkZ0b2VyVTVX?=
 =?utf-8?B?UWw1QWR3c29MMzBqVWdyejhMMTRhdTBYdzd6ajRZaTduNTltV0tBUFZZT3cx?=
 =?utf-8?B?TEEvWjRwSVNmOWV6Snd0VGtJamFSRkVhWVFNMklmSDdPd2c5ckFEK2JRSkg1?=
 =?utf-8?B?U0NOb3p6VTBabmtYdWJIakVaOVdsWm1iR0hXeWd5cjlyUXJhV3VsUndhUThW?=
 =?utf-8?B?aktPOFV3enhFL0FPektjSmNDSnZuU1cvL0Rwbnk3UjNKckhtVmkrbTdJYkN1?=
 =?utf-8?B?THhGZDRSMVpMV0pwRTJYQnNuVzY0cUdxOFlSeDhKaGtUUk9PTkRJZlNZWGlS?=
 =?utf-8?B?TDBKdHY2enFtamVFVDdSQ2c3MU9nZkZEbUF1NElIcG9NTWxGOVB6VVd0Tnlv?=
 =?utf-8?B?Q05aVm9keGdkLzQxQ1JaWnpLSTBmR1Z0NGFVZzRGT3k2dDZ6OFlBeWcxSW1t?=
 =?utf-8?B?YU5TYnpTOWwxUktrcHlmeHV6elBJU01uUm9KdGxJMVhPYlN4UUg5YktYbTV4?=
 =?utf-8?B?dTc1a3RONFNoQWE1SlpUcXV4VmtwdUIwUnJ6eS9HTks3SzBrT3g0cnRwU1M2?=
 =?utf-8?B?bXAzeHUyUkpkMWh1OFV2bXVqdzRBWXZpTjhuK3YwMzYxNlBxNHRVM2RoQnRp?=
 =?utf-8?B?NU40dGhxRW1BMWZjMVJkLzM5WEZSUllqRk9mMEZxa3pTUG84d29sWkF4MFdD?=
 =?utf-8?B?OWhZR1RPU1R1N3pNbXdMVzVsY2EyZHFUcGpzL0tpOW85L1N1RVI2cjNaVUM5?=
 =?utf-8?B?UTNtejQ0cjNyWGcrRmRpMGZ5d2VCbFVQRjNzNXUvakN3YzhCNldNRmNBOXdt?=
 =?utf-8?B?ZU0rMDlQdWNhWld6WFd2WWF4aktsdWJ6cnBGOXlubTRHNlV5cXl3M004UjVC?=
 =?utf-8?B?UHZhaWs5MFE5WFF4dDZmWFFCSityQWhyM2tkQ2dNVlJKRVBvQ25aUlZpaUdU?=
 =?utf-8?B?SmcvNnZJaFR5MWIrSlJvUTR2SmpVMGlNWkZkdEtHaVlhU0g5di9GN3RXZkUw?=
 =?utf-8?B?azB6Z2U0SEpYeEtndTl3ZTZiclpYUDFlL3o0Sy9tSDNDcjRDMUxaTXRGMVRz?=
 =?utf-8?B?N0V6eFdwcnFwVWNLVGZmd1JqaGRuMk41dis4OFVwSDlIZlpFbjlUd1dVL0Z0?=
 =?utf-8?B?d2Z0d0t4ZEpGMm9PMnJQMlN5UUxtWjBaRnRIUmhyTHNJcmxXdlVmanhObUJs?=
 =?utf-8?B?dkQrcWZ2bWQ5LzZsem9hdDRyK28xOWtFdXUzbmVkT1ZYYlN4UHJuMENHU0xR?=
 =?utf-8?B?TEVVbnN6MTJtK081N1Y2SWJUNUpiR0Jzb3h0NTJNS0w3aHVKVi8wUlU2ZGUz?=
 =?utf-8?B?T21rckxPeGpzc081OTBWcnBOUm5qZWlEc0V2bmNwY0w4Z2oycHh3SnhpR3ds?=
 =?utf-8?B?WVdVSnR3UnBZRlZ2eW1lV0hsZWRpWnJnaUhwcHB5NlBDTG5tYVRPaCsxdnpX?=
 =?utf-8?B?VG11bmlwMVJrMVQ0cTB5VHVHUGdYSlJ5QjVnNXJpbzEzenJBRHpSL3lkQ0NS?=
 =?utf-8?B?dkJWN3YxVVhpbmtUZFBmRFFoaGNwVkJKb095elQrSlpleFREWTRFMnZaU0NP?=
 =?utf-8?B?ckxFaE5WMU1QYmZrUHBZYXhyZjJjeU44ZWRBcWpYZHh2VWRsTEdZa0tJdUNY?=
 =?utf-8?B?T3d2VGE1SmU2Rk4xOU5IeHp1VGZ4OXZkVjZ1empqVWwxZjdTd3ZUakVaSHpj?=
 =?utf-8?B?SFdJRW5zd0VESUVLZTUzUWltbkNnNXJ1alkybUw1Sk5CMFBVby8wOFpZM3pD?=
 =?utf-8?B?eng3bmxDd0RGLzN4aUNTWlNXV0JNU3dienZnM1FJbE9naWpMd1ZwL0dkaUpq?=
 =?utf-8?Q?lrmOEFD/F0eAzJiRRDOjimG2H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25e76bc-0aba-4f40-278a-08dc59a80c11
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:49:07.3612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRBZxZZApl7w3LdeP5XAPD6oEiVfCVYMTiI37N85kFffU4EULMvqe7xFY1YqO+a2LQQVwf0UR5YMny0CYFkm6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

On 4/10/2024 2:13 AM, darinzon@amazon.com wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: David Arinzon <darinzon@amazon.com>
> 
> Small unsigned types are promoted to larger signed types in
> the case of multiplication, the result of which may overflow.
> In case the result of such a multiplication has its MSB
> turned on, it will be sign extended with '1's.
> This changes the multiplication result.
> 
> Code example of the phenomenon:
> -------------------------------
> u16 x, y;
> size_t z1, z2;
> 
> x = y = 0xffff;
> printk("x=%x y=%x\n",x,y);
> 
> z1 = x*y;
> z2 = (size_t)x*y;
> 
> printk("z1=%lx z2=%lx\n", z1, z2);
> 
> Output:
> -------
> x=ffff y=ffff
> z1=fffffffffffe0001 z2=fffe0001
> 
> The expected result of ffff*ffff is fffe0001, and without the
> explicit casting to avoid the unwanted sign extension we got
> fffffffffffe0001.
> 
> This commit adds an explicit casting to avoid the sign extension
> issue.
> 
> Fixes: 689b2bdaaa14 ("net: ena: add functions for handling Low Latency Queues in ena_com")
> Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
>   drivers/net/ethernet/amazon/ena/ena_com.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> index 9e9e4a03..2d8a66ea 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> @@ -351,7 +351,7 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
>                          ENA_COM_BOUNCE_BUFFER_CNTRL_CNT;
>                  io_sq->bounce_buf_ctrl.next_to_use = 0;
> 
> -               size = io_sq->bounce_buf_ctrl.buffer_size *
> +               size = (size_t)io_sq->bounce_buf_ctrl.buffer_size *
>                          io_sq->bounce_buf_ctrl.buffers_num;
> 
>                  dev_node = dev_to_node(ena_dev->dmadev);
> --
> 2.40.1
> 
> 

