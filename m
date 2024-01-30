Return-Path: <netdev+bounces-66923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EAD841837
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017521F23485
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ACE2C868;
	Tue, 30 Jan 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tIXVnz5Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF4434CEA
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577400; cv=fail; b=i/ZYyPp1PYaGXvMeCnseqvA2K53+hJIKAeMT6DvVVU+oJbMLCMCR3z3GitDCqstikP1tK90T3hu+XuavP7yLcr84mhn9gTGQw+U915xBa/r5FnT4l1p++GLv4Tz9fEmYhwRBD011wogj8vvpPi6POJ9fkhehLZW/la90bVkPmks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577400; c=relaxed/simple;
	bh=A64nwfjTqn6j4gA0gSUweycBNT8gn92NQqOQR/7yFkw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EYVFW/LULAzQkJzLd38NdJDgI6mAgH4qF953bofKCb3EcwovmTrgqFlJBse+9wTbH+ypceH98tCQfzFiHsAE/Ah74s5YWvAeT9udnfqjLeG3kFb9iV/+anVPlTR42XMVFx7ytoASs0JBvbb+X6cwMqvMW/FkJBMHBIdXH5x+Wus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tIXVnz5Y; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7ynQwlBspLjpAiBB4KdzoU1GwA5ggrhbzQqba0CHd7Q7HwM3/rLZDKE0Q2nVWZiMOoco7hF8F9OUPChMFL/3snnh7OWwYJ8onBV0MUzdKHEPjFOSbtlDjtycpJFEQk5oPMJRioqaUYN9hq0GZu3XYg3q5sjkanW5Rx5SVoQHMzmGiwJoyR+/fqthMR6osGpqo1qz5OeJ7ac81CDhp/TU3KWqS0FQyVj7YOXqOcRnRWcWXCcjjjY1p+vH7ycBByZ8YcJJELhe4A0DlJ+9XSUzb1gm4Z7mq6/jaySUwAfZutAMR48OpTZjqlOf7gNkoTxOtf4TT1oOiG9inz1By9JsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwAw0oOb/JGa2c5kgWQnrvtZ3wTx/Ur+e5qmk84X7oQ=;
 b=lReHzoaAMdz3WLcCPVIEbL6h9rlq8a7Vj9tsPp/oPuneOja9YjaHTIB+QU44gWhKSTvKNTEM4xQ5uq13IEWAuzBxhRlkcd7nwtoBHZM/jGJSklF1+Al/tP68aZ5hbiuND7y6KFyFseqnyMWoduhJwozE+sk7WFMJNkm8r6JdGjHOXMfHn6CDHx5/sPSUv3DKk8bEUzcq8nxaHNHcV1K7qwvCkq/HTLYGZldrJ+zXaGN5WqNPhLN4ZftSHBvEENJHtBUWuATGIud/hMjXLbR33rnIQbcQb4fmBG+LAc+5VzWW0Dq9s5t6fKNo+7GIqHmzx/hkUN5ErW7uEBdr6N+rtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwAw0oOb/JGa2c5kgWQnrvtZ3wTx/Ur+e5qmk84X7oQ=;
 b=tIXVnz5Y+ipwmCRi/+7nivAASHhyd9YCby/H4fq23JluBeBw7lWijVT9PLx9UdFhpK3NhVG3lUPaWIJkxYuwf2R9PSx9ANn6l/rZBdhb1LU07jogShiMRAuQB0oLopaT2VSFSDYl0Wa3PSQNVgit2VBvK7fTjsLII2cXZhGnIdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 01:16:33 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 01:16:33 +0000
Message-ID: <b4e44b37-8a0a-491d-a248-0b50f6668e17@amd.com>
Date: Mon, 29 Jan 2024 17:16:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 05/11] net: ena: Remove CQ tail pointer update
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
 <20240129085531.15608-6-darinzon@amazon.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240129085531.15608-6-darinzon@amazon.com>
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
X-MS-Office365-Filtering-Correlation-Id: 16bb04c1-0319-4077-bdfe-08dc2131189a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y7IrbeXzZuYSYoFzcIKSJfb5zS72MVeNowNGW9mSMKoX7l2+lrsUYwfmpGZ/4JCT9HnElgVQaUOrnf94kFNl21YMm3DR8Q0AQOKMfQfc6PwxR4okLPrQFYobXFLhCo1pvB4TRrQFnwE81LKXfPkRPVHAo5QbHoJ6Xiv+aSMOalH9QFEypSZlIkKqaRAGPjS07GOEpzJEfYR9YSYO425kUgWFhwQ5iLpi24bcc1ltqEhbjqJBW63pY6A+f6YIiCSpHw+U6gJOvSOKQfIBh8nkWQqf2D17ze1VC9hkt7/W9CtoABjuRmat18YQUMMKLr4iksABaHkr5l7mRdU0GjQvHXoc9umd2ELYTV5XantNUV/4jum/yQ2JYF5N9tvXBz6a+4tS1l0ZdDLChRcmRwOtbIBqC+GTzXGfjtouYNsOYcpfx4jSBIsSiwyU+KieS0YCS+5dOXi1IxRBkbYWpWWbDoSbgDIV60chevHcu7K6HNFGwaXTeRlvNAf2yD3eWU58e2GKAyvZdDE70CeQlvwwhyjyOUHPQDiCovU8f8wAEzKveJRgPt3LxKcmbKDaJlk6IMHnc4FJSXsJ7SbqDsHYn8hhtpAEaTl44LSOHjpj79CzTHRASIOgsANEEWqB/wfaEl13c3ds2s34rDC+McVWAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(31696002)(86362001)(41300700001)(38100700002)(6666004)(53546011)(6506007)(4326008)(110136005)(8676002)(316002)(478600001)(8936002)(6512007)(66946007)(6486002)(66476007)(54906003)(66556008)(7416002)(5660300002)(15650500001)(83380400001)(2906002)(26005)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MS8zaHNienhLeEFtbDJuU2xRWmVVeVBPdVYrSFlPUExKUHo1MEFEbW1QTjFm?=
 =?utf-8?B?Y1V5eEZLYmMrUE9EMlFSVTVwdzFUclZ4RFF3a3RlTWVqUjlDMkZRSkROcGZW?=
 =?utf-8?B?M3N3cTE2MlQ2TTFNYXZTRW8raUp3K3JjQ1NiaU5ueko3cXpnSE5SZUg2VEc0?=
 =?utf-8?B?VFBIWjJuVWhRNlhRWG1IUmROZVdOZW1McXZXUVNManNFbU44NnFTUE5XSGs2?=
 =?utf-8?B?T3plMXBRdFBwY3lBOGh5c3pwRGpPRzJrQVNwdTREWkl4ek4wT3JLZk40UGY2?=
 =?utf-8?B?cDlvYXJjWG1wMVhJKzhMeHRRZXB0dDA5WjRvVmZ6RE4zb0FEZWdWRTNXeE5C?=
 =?utf-8?B?OEYvUlFsN2JmQ2pnRDJtY2hPZHRGY1dJNXhVRlo2cHNlbHgrK29UeGMwSE9D?=
 =?utf-8?B?UGdZUGF3S0krK1l2S1RJZTdyNDdhdDg0c1gwTjV4NExpcDZiWmpOWHRxZVdm?=
 =?utf-8?B?Rlh6WkoxcTF3aDdTSUp1ejJ6djVkNno1M1JIc2xGRGM1eHhlQUZiUDJDMEF5?=
 =?utf-8?B?STQ3emplWmdYTmxta3dIdEdzN0hkbTIyYkhhRFBPV3h3RjZGVkVobDNueTky?=
 =?utf-8?B?N0tRTjV6eUNkREFNcXNIYk9hb3JQK3VRK2dUWUhTRjd4TlU4VUhkOVlEaW1k?=
 =?utf-8?B?NG13K2Ftc2Zsa2xjUHFpVitacmVZY25SZWZFaDdhQ0Fxdjh3UkZaeGMrazUr?=
 =?utf-8?B?NDFrNkY2UjJHVmRIQndTY241alJTR25XQkNDTmVNblpBK0tBSndZVE1VS1Q2?=
 =?utf-8?B?am9XcjNxUzFzQ2poVG9peFpncjhHdEQrY0FkemdKWERaK3d1SDM1QnJDbWpH?=
 =?utf-8?B?aVpuRnRYTFpnQWRJQmlRZ1gzRkRGRFN5bytSZGVHemZ2UFhaKzNnbDFPMm9O?=
 =?utf-8?B?WjdsT3VoSjg5ZGhodE9kZUZCR2VycFA4UnRLU2FVTkdiTlpzekJ5OEhtdjl5?=
 =?utf-8?B?RHdSMXl3c3A5dkp0YWkwRlZ6aVRROHJ2VC9LWWJ1L2NSTTZzaThqM2hZUjV6?=
 =?utf-8?B?U1VNc2p0OCs2a2I0Y0FtQnJlazFGeDQ3SUFKcTNlZWR6bDB3ZHNZS1ZTSWo5?=
 =?utf-8?B?TTZ6MXhwdjJscVZLdjJBaWRHRm1KdjhHeVpYMXdwRXp1RWdiWU41bHpVbk1x?=
 =?utf-8?B?UUF1SmxsVm5NOGpFN0dWQmxQN0dXMytoNktlWm5NbDNnTlNMVG5FZVF4ampp?=
 =?utf-8?B?RHdMbU5HNlFueFUwZHR3M3Y3cnUyekNkUHY3Q0YxTnpWVUZZUFkrVVdPYUh4?=
 =?utf-8?B?dVk5dDBVM1BvbVIxQ1RGVXA4eU1wck9RUU9nbzNvdEZLOGFZMzJLdTh5QzRs?=
 =?utf-8?B?cTJkWnB5YkEyVWMwQk0xUUd6SlkrUWkwM21SU2c4c1lRQjZuSlBTRWhDMUZa?=
 =?utf-8?B?YzlVc3RpQjQ4d0I3S1lTUkdWK3liNklCZ0FGcDJGT3pEZDVBUUdXcURjRGRt?=
 =?utf-8?B?R3ZIUG45a2MySVdEdTlMS1REa1VZeHlCdHNBTy81YjA3dDBLQzhnSUNYMjVk?=
 =?utf-8?B?LzY2S1ppRkxpNEZ4dkx4QnVwU2tkV3lFdUNJVDUvNXhYdCtxLzcycHppR0FL?=
 =?utf-8?B?QmN1d1NtY21vSk84SW45L21mQnRzRjlJVm1lKzkvZWJCeTZHTWF1TnowMkk5?=
 =?utf-8?B?T3paeXQwaEZmeVY5NDBnbmpBeloyeGh2TUQ0bkZibzcxcG9MNTFyaUJzMXpU?=
 =?utf-8?B?eHgyOGRiclU1WUIyelBVZFR0VlF6WUxSK3RwWmVjYkovVW5Jak11eUV3SFVB?=
 =?utf-8?B?enp4UjEwQmNxWlc0MFM4ZFZkeVU3Nzg5alRleHA0VERvS0tQc3haQ1J5cTZm?=
 =?utf-8?B?Mm5kNUNnZS9OYUQ4R0IvQnRtb3ZuOVcwWlB0YWVHTUhBbWYzaXZOaHU5SXZB?=
 =?utf-8?B?dFBNVjF0TCtBMldIenFHWkRYTTYzaW0xbzlmY1ZBa2NIcEIvL0o2Mitob09w?=
 =?utf-8?B?aFBjWk1kRENVTkhneE4zUUY5V01KMWFPWkRWWVRRbUNTYnJ3a0Y2R2hzcVor?=
 =?utf-8?B?bHVsbXpidlR1azhKY0ZPc3lWRTlGL2lSazQ5Q00vR051a3JkS0V0c0NzejZL?=
 =?utf-8?B?Wk5YQVhJdWU1M2dFaVFyNEZQK0ZJQ0tTbHJjR2U1ZkJSeDVoc09XZUFMb25X?=
 =?utf-8?Q?A9+6m6gisUxha68GNm9xZ84yc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bb04c1-0319-4077-bdfe-08dc2131189a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:16:33.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnBQVBjcLJ7/9ts5gjSRoX/9bYZJ0Ww4qn5m6yMibVIWflQkNOM7tzc+UBwTNiBXT20BOG5VFBJlHL4bi2GK0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839

On 1/29/2024 12:55 AM, darinzon@amazon.com wrote:
> 
> From: David Arinzon <darinzon@amazon.com>
> 
> The functionality was added to allow the drivers to create an
> SQ and CQ of different sizes.
> When the RX/TX SQ and CQ have the same size, such update isn't
> necessary as the device can safely assume it doesn't override
> unprocessed completions. However, if the SQ is larger than the CQ,
> the device might "have" more completions it wants to update about
> than there's room in the CQ.
> 
> There's no support for different SQ and CQ sizes, therefore,
> removing the API and its usage.
> 
> '____cacheline_aligned' compiler attribute was added to
> 'struct ena_com_io_cq' to ensure that the removal of the
> 'cq_head_db_reg' field doesn't change the cache-line layout
> of this struct.
> 
> Signed-off-by: Shay Agroskin <shayagr@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>
> ---
>   drivers/net/ethernet/amazon/ena/ena_com.c     |  5 ----
>   drivers/net/ethernet/amazon/ena/ena_com.h     |  5 +---
>   drivers/net/ethernet/amazon/ena/ena_eth_com.h | 24 -------------------
>   drivers/net/ethernet/amazon/ena/ena_netdev.c  |  5 +---
>   drivers/net/ethernet/amazon/ena/ena_xdp.c     |  1 -
>   5 files changed, 2 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> index 9a8a43b..675ee72 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> @@ -1427,11 +1427,6 @@ int ena_com_create_io_cq(struct ena_com_dev *ena_dev,
>          io_cq->unmask_reg = (u32 __iomem *)((uintptr_t)ena_dev->reg_bar +
>                  cmd_completion.cq_interrupt_unmask_register_offset);
> 
> -       if (cmd_completion.cq_head_db_register_offset)
> -               io_cq->cq_head_db_reg =
> -                       (u32 __iomem *)((uintptr_t)ena_dev->reg_bar +
> -                       cmd_completion.cq_head_db_register_offset);
> -
>          if (cmd_completion.numa_node_register_offset)
>                  io_cq->numa_node_cfg_reg =
>                          (u32 __iomem *)((uintptr_t)ena_dev->reg_bar +
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
> index f3176fc..8f90c3c 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.h
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.h
> @@ -109,8 +109,6 @@ struct ena_com_io_cq {
>          /* Interrupt unmask register */
>          u32 __iomem *unmask_reg;
> 
> -       /* The completion queue head doorbell register */
> -       u32 __iomem *cq_head_db_reg;

You'll want to remove one of the surrounding blank lines as well so as 
to not end up with multiple blanks in a row.

sln

> 
>          /* numa configuration register (for TPH) */
>          u32 __iomem *numa_node_cfg_reg;
> @@ -118,7 +116,7 @@ struct ena_com_io_cq {
>          /* The value to write to the above register to unmask
>           * the interrupt of this queue
>           */
> -       u32 msix_vector;
> +       u32 msix_vector ____cacheline_aligned;
> 
>          enum queue_direction direction;
> 
> @@ -134,7 +132,6 @@ struct ena_com_io_cq {
>          /* Device queue index */
>          u16 idx;
>          u16 head;
> -       u16 last_head_update;
>          u8 phase;
>          u8 cdesc_entry_size_in_bytes;
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.h b/drivers/net/ethernet/amazon/ena/ena_eth_com.h
> index 372b259..4d65d82 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_eth_com.h
> +++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.h
> @@ -8,8 +8,6 @@
> 
>   #include "ena_com.h"
> 
> -/* head update threshold in units of (queue size / ENA_COMP_HEAD_THRESH) */
> -#define ENA_COMP_HEAD_THRESH 4
>   /* we allow 2 DMA descriptors per LLQ entry */
>   #define ENA_LLQ_ENTRY_DESC_CHUNK_SIZE  (2 * sizeof(struct ena_eth_io_tx_desc))
>   #define ENA_LLQ_HEADER         (128UL - ENA_LLQ_ENTRY_DESC_CHUNK_SIZE)
> @@ -172,28 +170,6 @@ static inline int ena_com_write_sq_doorbell(struct ena_com_io_sq *io_sq)
>          return 0;
>   }
> 
> -static inline int ena_com_update_dev_comp_head(struct ena_com_io_cq *io_cq)
> -{
> -       u16 unreported_comp, head;
> -       bool need_update;
> -
> -       if (unlikely(io_cq->cq_head_db_reg)) {
> -               head = io_cq->head;
> -               unreported_comp = head - io_cq->last_head_update;
> -               need_update = unreported_comp > (io_cq->q_depth / ENA_COMP_HEAD_THRESH);
> -
> -               if (unlikely(need_update)) {
> -                       netdev_dbg(ena_com_io_cq_to_ena_dev(io_cq)->net_device,
> -                                  "Write completion queue doorbell for queue %d: head: %d\n",
> -                                  io_cq->qid, head);
> -                       writel(head, io_cq->cq_head_db_reg);
> -                       io_cq->last_head_update = head;
> -               }
> -       }
> -
> -       return 0;
> -}
> -
>   static inline void ena_com_update_numa_node(struct ena_com_io_cq *io_cq,
>                                              u8 numa_node)
>   {
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 0b7f94f..cd75e5a 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -856,7 +856,6 @@ static int ena_clean_tx_irq(struct ena_ring *tx_ring, u32 budget)
> 
>          tx_ring->next_to_clean = next_to_clean;
>          ena_com_comp_ack(tx_ring->ena_com_io_sq, total_done);
> -       ena_com_update_dev_comp_head(tx_ring->ena_com_io_cq);
> 
>          netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
> 
> @@ -1303,10 +1302,8 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
>                        ENA_RX_REFILL_THRESH_PACKET);
> 
>          /* Optimization, try to batch new rx buffers */
> -       if (refill_required > refill_threshold) {
> -               ena_com_update_dev_comp_head(rx_ring->ena_com_io_cq);
> +       if (refill_required > refill_threshold)
>                  ena_refill_rx_bufs(rx_ring, refill_required);
> -       }
> 
>          if (xdp_flags & ENA_XDP_REDIRECT)
>                  xdp_do_flush();
> diff --git a/drivers/net/ethernet/amazon/ena/ena_xdp.c b/drivers/net/ethernet/amazon/ena/ena_xdp.c
> index fc1c4ef..337c435 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_xdp.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_xdp.c
> @@ -412,7 +412,6 @@ static int ena_clean_xdp_irq(struct ena_ring *tx_ring, u32 budget)
> 
>          tx_ring->next_to_clean = next_to_clean;
>          ena_com_comp_ack(tx_ring->ena_com_io_sq, total_done);
> -       ena_com_update_dev_comp_head(tx_ring->ena_com_io_cq);
> 
>          netif_dbg(tx_ring->adapter, tx_done, tx_ring->netdev,
>                    "tx_poll: q %d done. total pkts: %d\n",
> --
> 2.40.1
> 
> 

