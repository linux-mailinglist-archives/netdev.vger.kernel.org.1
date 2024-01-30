Return-Path: <netdev+bounces-66924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E45841838
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFE41C2156A
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172C360AE;
	Tue, 30 Jan 2024 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S7vCA3wa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19A34CEA
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577404; cv=fail; b=uY49qweCSf/on+9RWyijRoy+MPW2KEVpXLXRhE+eVKJp/njUbclGANXyKcOR3J3ofeaCCoWUXVIjo12aL6cqIpOSB9lJYM6B7itfZ6z2/AN6hi++pLLjhdosBb1gNWygoQH+amRPxtTRtZBvXYs5MEebsC+nPjo23VAR9GfM+XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577404; c=relaxed/simple;
	bh=YslXoxROcu5ZszwQdcEiV9sHfAW0pZKa+3P73742si8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dBSfP8ax/icAXSH451yQFWCbIi7dHb+Jz3pOAkuEuZGOW158jUrXQvIH+Hy3eXodiS9//QHxTdfYSizspn8CPRZpHiBstOQL61atwQUIJfa06/W2I3JL6bYVtfKFURzL3eT8VrCAQDCcW635FQ8/Kd8BRsyJvj6DwsLLd4Qzh1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S7vCA3wa; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFzJMYz1QjiJ72Khf91u+Q1Qk/nwlfX7F88m07/QiBTg7tKbJERImeB53DMNhtIBKdaG+0mnhxB5adBeaN9lhtFTt6XfsgsGjeXyHGP4wA4iJqlzJeMPCG15oJqCxRW0ODTWgyb8d6ioMRg6m1DjJJgmsTfrppeQrlYJxVBr9aEp3/f1NO7ZAqnGuUXjzRx1JasBz9bzBzY+r8gD+F72E5S/BKUtAwen+cGdaX6o5LEym9cm1PE/kfM96FEW9b1ej5KtWlM/D2e4UATdiXcGhuWfxtlem7M+LlPf1vrNGjJfns71ctPfGW8Jt/3iDj3y0KF+LPL+s8idvg5dGcHc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hw2qIckM3Cxwlb1tb44lUGMISkMKs0gHcT2w/BaAGCM=;
 b=P0vNUaXWSKT2WNPj5Ww9RyPVWB9JsRNtJ0fxPay3SLEUj8ftZf3yuSV71EZACrv6p4JkexMk3L9Lksk3FiZby8ig20YGuPK3DxjhFbwHq3iUTMsMaQv9LOP/V/Ul5jImgGI+E0PM5DIhQ82hSeOIoWalrDRqlh/7IfeZSbEbr9DouAFIylg4nHaNEdiC+W5wiRjNnb5ih104wawbmIgw/dzNqldA5TrwoHDBzvRNnvD+6ue3oMjTndK2L1JC2TWZU+/I3X+xPZNMSbP3niZP0xGYlpuvHxHy8P626B3E9cZKH66EHzkLF4L5bT4YHqFAkeilh75II/ghMccuJaIy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw2qIckM3Cxwlb1tb44lUGMISkMKs0gHcT2w/BaAGCM=;
 b=S7vCA3wauqNSPySSUOUigiDK6p390swvW6fOYbQcshtkToRTVIv7oy9En0PvQWDJ9MqRp1rZWlVxhBZh1O6LAbrKhuq/xqNnW/f5IIGQtD4yoevM1j1F+bAn5Dmd7SsjFzofmOpTK6fGeCA/PMUDQxC8x0K6TY4SWEFE3yCwUaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 01:16:40 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 01:16:40 +0000
Message-ID: <8752f5ea-9e9d-4884-b472-445c711c7bf0@amd.com>
Date: Mon, 29 Jan 2024 17:16:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 10/11] net: ena: handle
 ena_calc_io_queue_size() possible errors
Content-Language: en-US
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
 <ofirt@amazon.com>, "Koler, Nati" <nkolder@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
 <20240129085531.15608-11-darinzon@amazon.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240129085531.15608-11-darinzon@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:907:1::30) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe9b397-c3d8-4665-250b-08dc21311cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mhgGzUPplmxLd/gsaNUXGoyrz3t6926WPOCFBnttrSAqXl2mKel1OfsnKhMeNglOY5i2GKU8+bW2yD/FLlkGB/OP0f/mhDfXYPVT3Q/c2AQvNJMhjMNH3k9TA/CX0dhmaV3cEcyyoANJKMt9xPE5FzzsNH7PlAgYFtN4nDk9yiiBGoyYyX2PEyyxJaZmDB5RVJyoLWHur3A5cIoZRYKrq81eCdT4OEkUzqtHUa/W9ccZGotrrH/AMqxs2tzlaPnVpgboqP18Yd5sjTPQ7PyMW3JVq7SsYEVABAMrqcsFEPvJl6hyJygnUvLQ4aCGdIQ6bylYbN9ygPZky0NF3yRLh2eSRxiCgvgtoCH+f3pSdKWtLpRV8KcIyIhQOv454ZOXhixCsi/Y0yOuz+pEGAHz5qEiLiL2En1C8f1xdMxz8xF0xy0ft6k1U5zfjA/cWRlaKS7HFfauiZU7Xg5+kCgHEUdDimLLW5kJ1ezRuTUD0jUuF0HjmHVJRJFDlKytVCEgW2uBZhlOvaD18tcMnMRvNs2vwFnNGfSvHS45hI8uFDOs4SRfkprjhJDA3BUq4FjC7U+F0Tadz/Hjy3G7i/TYQRIYrnr3C1mMwH9aaRgYck0+EBp10yZ37JvBFC6ZxLzl8/SBq3DVUeyJ4mDTkw1Ovg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(31696002)(86362001)(41300700001)(38100700002)(6666004)(53546011)(6506007)(4326008)(110136005)(8676002)(316002)(478600001)(8936002)(6512007)(66946007)(6486002)(66476007)(54906003)(66556008)(7416002)(5660300002)(83380400001)(2906002)(26005)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anhXdURNUUxIMVZtRkhHd1ZLa1RkMXYvOEEvNjVoZWJoKzFPdzBGb3RMRUVY?=
 =?utf-8?B?RmxQdXVxaDFmTU5JbnREN3J4UXJuT1NLV292eitjcE84djBaN1Z0ZG9JSFNL?=
 =?utf-8?B?M3lmbnJqV3pJTERzVjhaQTYxWUdNaHUvSE5veE5nMDhBeUJRY3ZDWm5KdnYw?=
 =?utf-8?B?NTlidERhZnlrdk1nM0tXZ3VNbUdZb3RVQURndDcwQUhKeDJrUDdpc1M5Rk1J?=
 =?utf-8?B?dkNpc0ZTRmlSMFBpbk9DakxVTERuNG91SWp3V0dOK29WbEUwWE14RzRYZ2t0?=
 =?utf-8?B?MGRWTGhRQUh5YkhXQmNhcFJPSVgrR3pOWStRNjhZOGRuUDNxek0rNWdSWnNG?=
 =?utf-8?B?WTVSQ3gvYVg0ZVVTOXU3Q3RJMmdHak1ndWNwYUwwZzFHTVVRT3gxQlFRTUV4?=
 =?utf-8?B?aEZlekRJOVM2Q09hOVVnNnFQVVNTWmordmJkZ1ljOGNVRjFhRjRHZjIvWUVv?=
 =?utf-8?B?a0VVa1Q0dkdBS2ZqTmgzblhJZDZ6UUlkTHRCZW1YaVVZZjRUS3JIVnpObDRO?=
 =?utf-8?B?TUl3eXlidWh3NkUySWhCTDR0NzZwVFhJd0hrVEhwajh4c3hsU0pBYU4yNHhG?=
 =?utf-8?B?cU9XSU5kbStWSHo1TmZDSVNmWERXVUNsdlFyazdwWm92cmtqdU5MQjBCTms3?=
 =?utf-8?B?SXFBeFVoUzJIdU0wK2g4a1g5TlpBRk5GZUlJYXFUYXhqc2lXRVhUQk10Y1JR?=
 =?utf-8?B?WTM0d21rRmtzSmJVNkJHVmhPU1pZY3pMaTBWYWY5TGw5UmhnSk9MejYwNWZS?=
 =?utf-8?B?dUxKYmt3WlR1NEc4Ri92TDRtbTdkOThnWERzZUV2T3FVZjdCaFVMeTZlSzhw?=
 =?utf-8?B?ME1HbVZkMkV6QTRNZkpGaTZNK2hPWXZuOHo1bHNScS8yRzJqRlRPeDZMVElH?=
 =?utf-8?B?TkgvTWZGZHdTZThmUFlMSHpKR3lWc2JMd1QwQS9ENWdNcUJ3elg5WUEzZ3VE?=
 =?utf-8?B?dmhMQzY5dHJkenliWFAwUkNOUDVNVytBL2hzVGNzQU53cS9iNys1WkRSQURX?=
 =?utf-8?B?d01ub1lyLzVaeGhDbG9MVmZxVFJLZ1YrNG8wZ201d0c4LzArVkc0OHB3ckJo?=
 =?utf-8?B?YzBMVzh5aHhmOWxaelBNTnpUTUJKL2FrZFl3ZUVGS0VmYjVqajl2eklNaDRH?=
 =?utf-8?B?WDNENEVmN1ZwVEEwUkE0YVdQVmlqUWVLdndnVFJWUG4vWE9RS1RsWC9BNTd6?=
 =?utf-8?B?VXZ0MHVnbEh6WjI1RDFWanlIcnhwQVpMMnZ3TEtBenlIdEpvRk4vWUc5V01s?=
 =?utf-8?B?akNvcmZBVCtnbzlqRWJmNEZ6Ymc5OG1VdFQvRnBZWWViNzZSZ1UvdUhta1gx?=
 =?utf-8?B?TllZdmZwdTg1T0h4cFF3ZzF6eERndWIyT3lvczEvbllobFRDdzZhY25xVmVJ?=
 =?utf-8?B?SHpsY0xyUDV0czRybGhkdmczZ2ZGZGZZWnkvcXJvWTRFVjF0Y3ZmcjJqZFEw?=
 =?utf-8?B?YjJ3ZmptQ0VwdjJDbklkcnBRdE5uKythbXdTc1pQODZMMHgxVENCQjdVejNr?=
 =?utf-8?B?MXJzbFEwWXdTWks3KzFHUlhmNUFSV0trQ0NDMWJyQlp3OHJZVTdpVVdnZTEx?=
 =?utf-8?B?dlFTVWNPYWJSckFncnYxTkpuaFo4VkxrcjBMM0M0WU82YzNPZWdXVS9yWTlT?=
 =?utf-8?B?NUV3eXJ1RDJZVmJuenlwYjFrRW92OFJOMFkrRkczUHNpOWlKdkFvUzRTTkd5?=
 =?utf-8?B?M3BkYXNQZXA1bUxTR0lXQnZjTUlXQ3FCbno3UnZiS1VlVnZzOWFZOTZ0aTU0?=
 =?utf-8?B?dlluakx3ZU5MZGdlajN0TitFRlVtODAxWENxWTRYNjBGOTJwa3E3ZmMyallD?=
 =?utf-8?B?S2lsWlhGUkpGVU5hTWZwVjh1dG1RWkhRaTRDSktaU2psZ0Yzd1RSVENHampX?=
 =?utf-8?B?UlRVZVd2NXJsWDdqbFV2NHZLemtjYXZPU2VJNVBKWEVSTnI2aVZGbkVUek9K?=
 =?utf-8?B?d09UV0JFQVFoVjVLTlJzYW1QZWZFMkVnN0xXWFVjOUxZRGRlK0g1ejNlUjJ4?=
 =?utf-8?B?UnJvcFgrSGpJMGJqd2V3YjdsZ2xjTGM1Sm5xL1A0WnQ5SHFoQzI3azFGV2w2?=
 =?utf-8?B?WmNYay90eURoTFd0emg0Mjg0VWQ0dk1YckZmM293MVRBaEhoNHh0Qkl2MFhG?=
 =?utf-8?Q?2fG609cPvEu5n1xmYBXofBRIx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe9b397-c3d8-4665-250b-08dc21311cc0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:16:40.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoKzte9LOhk6xTNDk9azkWB8NIf+fmZnkE66sLXp5N+FbdwJt4k4y8euxCb5dL1GDbZ7dP862cmu68LNBnnpww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839

On 1/29/2024 12:55 AM, darinzon@amazon.com wrote:
> 
> From: David Arinzon <darinzon@amazon.com>
> 
> Fail queue size calculation when the device returns maximum
> TX/RX queue sizes that are smaller than the allowed minimum.
> 
> Signed-off-by: Osama Abboud <osamaabb@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>
> ---
>   drivers/net/ethernet/amazon/ena/ena_netdev.c | 24 +++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 8d99904..ca56dff 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -2899,8 +2899,8 @@ static const struct net_device_ops ena_netdev_ops = {
>          .ndo_xdp_xmit           = ena_xdp_xmit,
>   };
> 
> -static void ena_calc_io_queue_size(struct ena_adapter *adapter,
> -                                  struct ena_com_dev_get_features_ctx *get_feat_ctx)
> +static int ena_calc_io_queue_size(struct ena_adapter *adapter,
> +                                 struct ena_com_dev_get_features_ctx *get_feat_ctx)
>   {
>          struct ena_admin_feature_llq_desc *llq = &get_feat_ctx->llq;
>          struct ena_com_dev *ena_dev = adapter->ena_dev;
> @@ -2959,6 +2959,18 @@ static void ena_calc_io_queue_size(struct ena_adapter *adapter,
>          max_tx_queue_size = rounddown_pow_of_two(max_tx_queue_size);
>          max_rx_queue_size = rounddown_pow_of_two(max_rx_queue_size);
> 
> +       if (max_tx_queue_size < ENA_MIN_RING_SIZE) {
> +               netdev_err(adapter->netdev, "Device max TX queue size: %d < minimum: %d\n",
> +                          max_tx_queue_size, ENA_MIN_RING_SIZE);
> +               return -EFAULT;
> +       }
> +
> +       if (max_rx_queue_size < ENA_MIN_RING_SIZE) {
> +               netdev_err(adapter->netdev, "Device max RX queue size: %d < minimum: %d\n",
> +                          max_rx_queue_size, ENA_MIN_RING_SIZE);
> +               return -EFAULT;

Maybe EINVAL for these two?

sln

> +       }
> +
>          /* When forcing large headers, we multiply the entry size by 2, and therefore divide
>           * the queue size by 2, leaving the amount of memory used by the queues unchanged.
>           */
> @@ -2989,6 +3001,8 @@ static void ena_calc_io_queue_size(struct ena_adapter *adapter,
>          adapter->max_rx_ring_size = max_rx_queue_size;
>          adapter->requested_tx_ring_size = tx_queue_size;
>          adapter->requested_rx_ring_size = rx_queue_size;
> +
> +       return 0;
>   }
> 
>   static int ena_device_validate_params(struct ena_adapter *adapter,
> @@ -3190,11 +3204,15 @@ static int ena_device_init(struct ena_adapter *adapter, struct pci_dev *pdev,
>                  goto err_admin_init;
>          }
> 
> -       ena_calc_io_queue_size(adapter, get_feat_ctx);
> +       rc = ena_calc_io_queue_size(adapter, get_feat_ctx);
> +       if (unlikely(rc))
> +               goto err_admin_init;
> 
>          return 0;
> 
>   err_admin_init:
> +       ena_com_abort_admin_commands(ena_dev);
> +       ena_com_wait_for_abort_completion(ena_dev);
>          ena_com_delete_host_info(ena_dev);
>          ena_com_admin_destroy(ena_dev);
>   err_mmio_read_less:
> --
> 2.40.1
> 
> 

