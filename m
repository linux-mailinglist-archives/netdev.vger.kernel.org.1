Return-Path: <netdev+bounces-56454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4405F80EEE0
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB42428154B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E275EE74;
	Tue, 12 Dec 2023 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KEezSX1m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0007CD3
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 06:33:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCePYs6dUwKQUOmlFZhWnRWrevntCIJUeibvcR8dMPC1ExQkLOuTtMigtWl/oOSH2v41XW740y7ZLgU39ewvXX9GqNoKyoKsKVyHqDhd1Tq0JYB5RALmWoqREXz1LrFAxRqmWr37llw4FhVgog+yLkaitvpWQX9g3lXRsRZpooTSke5+NOumcdJ5XKAo9wNLP+8nO47Zz/TsDoOMr41Xv/C8dBd+o8mBYVJCX1yZJOPY0/6RYJKfroXSF++LZBFyH/LSbUD5LN41is9U0ioE6Vh9rdTu38B/mG+50lYbSetA59kUZ+iQgo9Ur+29bYmQCju6HlCsDRZ/znL1ypKRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U1TaMN/A2Gv/b+IYHavwvymdf5dJ/ngPGsYniXud4k=;
 b=LQdfx8Hyj/uC2KJhp+x9slRN3vFiiuoEz1FtYnJSSThxWMy/ge2a79qzljC4l4KHUEA34mOQw0ueEjVbbCSHXxArtGbkeeMZMMCbYCzK/X/UnCv4moiUcYWr5MF9oo4eaipXFLlW03NogHRghHHjCYYV+QLgjsx5BIQzCR5T84h5+hdZl/xRclrNQIZwxW27Ih9qjH+ZfR63Um33CfuWZqsewqkAkeewGSJ9jVTvqDYgjEn85vSBhlww4cgUIMdKcxAPc6mreWeWNuB7iCHfzEASlv+KGJSGacqLjTxKoGQwr+2Y6yXCYb+gsGl3b0Hwnr9iaGfeJt7BohvDhcsT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U1TaMN/A2Gv/b+IYHavwvymdf5dJ/ngPGsYniXud4k=;
 b=KEezSX1mP7U77ojRUZBEFf9jUsVENJJRyab3gbpK01x+bbaezueV0NNwlH5ff/R93WmT+e7B/dwQagIDrPEblSDP9wTwT5PZbAlCvV759/TXKivToO0apYS7QwS1D8wFbm4dnhFEnRy++1z8+eKQFIexnpxkjf0Gof+a28v3HBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 14:33:10 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 14:33:10 +0000
Message-ID: <0dca661a-26d6-425c-a3c3-1b4ae94b3b47@amd.com>
Date: Tue, 12 Dec 2023 08:33:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/3] amd-xgbe: reorganize the code of XPCS
 access
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20231212053723.443772-1-Raju.Rangoju@amd.com>
 <20231212053723.443772-2-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231212053723.443772-2-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:8:2b::24) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BY5PR12MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d1709b-7942-419d-e945-08dbfb1f4332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lU3zBQEAqBG5v/9HUNMbmmEynbx8sT7YC62SytXCMIadgQdlXy0grRwSgCTbVGNkfPO5Je4XPHgHyfpLmal6GowVAeNPRlTmg1bfDcyY3Z6Ek+v2jCBRe5W2UvO3KcdHOWU3TsB9xR5cMFKXOod8fMxFbjTENmMNzXULtuGU5DdtOzcHZ/IvA9R9B2u9eUJU18ExUZZLUQwKG1ScTdmtUqSjvWu7vhU1D1fvyowW6LJKbDe2cTbg66a2jqY1EMnxBLGdfVsT9eW/5g82ihlFf/uvVdjOhqsRMsyz765rQlpYV+5lqry+5ZnfMUmN9xg8m9+JT8AUHIxPolS3hyCqTSN//jsjKaUh0JCGBs3Na6u81uh1HF3DrpXWOkKPIlq0B3sdX/kZJMHGEZavUwjJOO+Vkn6BN0bjIpd/nJnZeG9ma5jMB9XwNAa6zMKLm+yiXYe8ZdYUWKqRn78MqAtJ5bEQF4VxWKsu70xo7lULn3SEltaOhsARgmTftOKWj3ZjSIl00pIAmqTumrdG6YOkV7dkTSyGQtysLe6fu6JjMhM1Ycw3olsaA+EaPrmOH9i13dIuayOWHFj9Hv0O01g/MANQt5sf9qBTuFZM1j4VS4wbAXR6u4nMLwSI1mY6PTEkiAjqCjM6pdCQUF93jy3nRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6512007)(6506007)(53546011)(2616005)(38100700002)(4326008)(5660300002)(8676002)(8936002)(41300700001)(2906002)(6486002)(6666004)(478600001)(316002)(66476007)(66946007)(66556008)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk1GbklVblNEeGFFN25MOVdjK2NGRE9CUEhqdUVFdFIrdGY3b0tPcDA1a1Y2?=
 =?utf-8?B?cDY0UXhGbVo0bXZZMG9sK2szMEpSbEx0M28xVGF0dytkdjRYZ3BFZU4rYm5q?=
 =?utf-8?B?V05LRnpOdHRBYytSMzZ5OHdhRVYyK0prempyMXNyVFZiRElvYm8yZzZDc1hh?=
 =?utf-8?B?aTVQZ0RJRkdKZTREYVMwbVJob3FoRFkrR3BoY2VQZDVKSjczU2ptQmljRTVq?=
 =?utf-8?B?OFVRQ01zVFYwU0p5dm13ZHZwWVhiMFVIMElzVjNncWQzZHJmK3hvMmx4eW1i?=
 =?utf-8?B?d1pVd1JTYmFuZ3NJaWRTVkxGRDNDU0RKYXR5Sjc4aWZESEdVL1RzSFgzdTBw?=
 =?utf-8?B?OXlrUDZ0MXFhanI3WmMyZ2RIWkZYUUE1M05lVFp6L2lGTjNCQXY1b1kvTDlJ?=
 =?utf-8?B?RnlPQjRjUHJKaDQxTEUxNzFPZXQzRk5IeWhpbEVPTURvQUdlYjJVNTlNTXNy?=
 =?utf-8?B?WThHUEJxT1FnWVhaUXpCNHVIbGtnYlNKMFIrMmhwNVN0eDNjNVpOb3cvcWZm?=
 =?utf-8?B?QUYzRThvL0lrNWkvRWtKNzNJRFArZXNWL1pibjJINnVsek9CSU1sYXV5Rks5?=
 =?utf-8?B?VHE5VXlBV1RvanN3RjlGeDN1Y0xWendoVVVQQ0N5YUwzUXR0Sjl4Z1lmYi8v?=
 =?utf-8?B?aDVjQytxRlQ3blpjbGNyclI4dlVsUWRkRk9VVVR4c3dYTnpWeVA3VXNSV1k0?=
 =?utf-8?B?TlU5TXNNWGIySU1MNmYrZmRYZUNGTjhDRWt0VHlEL0Z6cHlzYUo5L0JQQ1Jj?=
 =?utf-8?B?YWVUTUpZV25yK0t4cXJNZzM0VGx5MW8rWmJPOGdNMjI0dzJNbExDeEJlcGpk?=
 =?utf-8?B?d0MwaTYyVEZiWHVSRjJKUXJDSk0xL3pDMWJVRCs1cWZtTzRyZzBibWdQY0Fn?=
 =?utf-8?B?cjhZRWRrMFdMWGpzejNhVFdCei84TWZuMnZEcU90Z0tGUTZJOXN5VlI5MSs5?=
 =?utf-8?B?VGJzMytVYy92WVpZNnp4aHFwNVcrUGkxQXhaZlVXdjB6RkZvczgzTzlGRmdS?=
 =?utf-8?B?Z0dxcGNua3BqdW9jUTZCakltSFJFR0VSdjNubCtWSTlLemdMVndwTkZSVnJ1?=
 =?utf-8?B?Q2Z6eW1RQ3RiMFdWdE1VMWxjdGdsazUzZDZKM0pWOEc4TnpJYWtQWXR6Tjhp?=
 =?utf-8?B?NlVwRnIvbnp6dGk1YmIxT2kyYWI2NEgzcnBRWXh3ZW1wc3ZadDVtMjJFYVNH?=
 =?utf-8?B?QWt2Q2kvTDlwSW0vZXgzWUhpQUlMcERJUkJubUtiRm9STTA3VDBUODV6TUt3?=
 =?utf-8?B?ZktZdm9Od1JuR3llOEY3YmNOQ1pEOGRTNXZoM3JDeTUxZDdNUDZ5WlFJT2I0?=
 =?utf-8?B?ZU0weThlVGFlODZYL0ZrTjF1NjdTRTVXWkxVTzRWWkFieEQwMkowaHNhTDRj?=
 =?utf-8?B?Yklucm5LTEN5WGF4TWpOSGVSRkg4SFBvZEVtejIwcWYrMTdsRi9uVk5rUllt?=
 =?utf-8?B?WnVsQnhHTkI4dFh4azhIaWZhNDJCMGk4OHNYWHNncElnU1JSYlRlUDdpNndj?=
 =?utf-8?B?NHJoT3hDbndjRmozUEYxUE9aVkwrVGZOd2FsN1pDamF2UXA0byt4YzdsSWpp?=
 =?utf-8?B?UHRpZmYvejB1NHdLSk14WTN3b2hTcTlsbEF1U0NUNXpwOGxaKzdMaHNUVzUx?=
 =?utf-8?B?bEVBdWdCNHF4aEMxakxFS0ZrTkJ3VWI0THgxMW85ZW9ncU5xcjgxMElucDQx?=
 =?utf-8?B?Q29NTSsyOFVBVkszUk1tL2JvOUxaTGVOZGgrMjRFSHpsL0dTcStyR1E3ckF5?=
 =?utf-8?B?dmZwYkROcGNKanZJTk54L1dzd2tBZ1R2K2d5YlpXMXhlZ2ZmdDBVb1JmaUZa?=
 =?utf-8?B?eGJTNE5NZWtIdlNUR3ZtNTQrYVMzek9oZnJFTlk3M2ZnbTFvcUVlaXh3WGw0?=
 =?utf-8?B?S241YnA1NFdIZmJ5TlFvM3BnbUlYVWkzMS9VSmFWSTBQTUdpN0J3UjA2Wllv?=
 =?utf-8?B?K1NOdmpva0taK0x6Y0pUb3F3d1VFNmMwWS9JdG5DdElGREwwamdiaGJjb3hG?=
 =?utf-8?B?Z2R6UGdyUTlKY3REU0FiNEg3QTQ2dnV1WXh3UFlWbXJrQ0ZzOGtSdmVJY05h?=
 =?utf-8?B?YzB0Uk83a3hCMjJXR0d0VHJXbGdydmxENkx1SDJkUEtUZ2Yxc0E0ZDlSaWRJ?=
 =?utf-8?Q?j3MM4lSuTHT807fUlDCHk1OrW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d1709b-7942-419d-e945-08dbfb1f4332
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:33:09.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crMOSE5iMfBiZxCE68aryvTrhL0lcCUiLZ/rX+vA7cIvjKWDKQAuYIEE/CydSXeNDmmfgs1+gURb0FK6yR3hHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920

On 12/11/23 23:37, Raju Rangoju wrote:
> The xgbe_{read/write}_mmd_regs_v* functions have common code which can
> be moved to helper functions. Also, the xgbe_pci_probe() needs
> reorganization.
> 
> Add new helper functions to calculate the mmd_address for v1/v2 of xpcs
> access. And, convert if/else statements in xgbe_pci_probe() to switch
> case. This helps code look cleaner.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 43 ++++++++++++------------
>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 18 +++++++---
>   2 files changed, 34 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index f393228d41c7..6cd003c24a64 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -1150,6 +1150,21 @@ static int xgbe_set_gpio(struct xgbe_prv_data *pdata, unsigned int gpio)
>   	return 0;
>   }
>   
> +static unsigned int get_mmd_address(struct xgbe_prv_data *pdata, int mmd_reg)
> +{
> +	return (mmd_reg & XGBE_ADDR_C45) ?
> +		mmd_reg & ~XGBE_ADDR_C45 :
> +		(pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +}
> +
> +static unsigned int get_index_offset(struct xgbe_prv_data *pdata, unsigned int mmd_address,
> +				     unsigned int *index)

Just my opinion, but this looks confusing to me by updating index and returning
offset. And the name is confusing, too. I think it would read better as:

static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata, unsigned int mmd_address,
				     unsigned int *index, unsigned int *offset)
{
	mmd_address <<= 1;
	*index = mmd_address & ~pdata->xpcs_window_mask;
	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
}

Or break this into two functions:

static unsigned int get_pcs_index(struct xgbe_prv_data *pdata, unsigned int mmd_address)
{
	return (mmd_address << 1) & ~pdata->xpcs_window_mask;
}

static unsigned int get_pcs_offset(struct xgbe_prv_data *pdata, unsigned int mmd_address)
{
	return pdata->xpcs_window + ((mmd_address << 1) & pdata->xpcs_window_mask);
}

> +{
> +	mmd_address <<= 1;
> +	*index = mmd_address & ~pdata->xpcs_window_mask;
> +	return pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
> +}
> +
>   static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>   				 int mmd_reg)
>   {
> @@ -1157,10 +1172,7 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>   	unsigned int mmd_address, index, offset;
>   	int mmd_data;
>   
> -	if (mmd_reg & XGBE_ADDR_C45)
> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
> -	else
> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>   
>   	/* The PCS registers are accessed using mmio. The underlying
>   	 * management interface uses indirect addressing to access the MMD
> @@ -1171,9 +1183,7 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>   	 * register offsets must therefore be adjusted by left shifting the
>   	 * offset 1 bit and reading 16 bits of data.
>   	 */
> -	mmd_address <<= 1;
> -	index = mmd_address & ~pdata->xpcs_window_mask;
> -	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
> +	offset = get_index_offset(pdata, mmd_address, &index);

The comment above this code should be moved into the new helper and then
removed here and below.

>   
>   	spin_lock_irqsave(&pdata->xpcs_lock, flags);
>   	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> @@ -1189,10 +1199,7 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>   	unsigned long flags;
>   	unsigned int mmd_address, index, offset;
>   
> -	if (mmd_reg & XGBE_ADDR_C45)
> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
> -	else
> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>   
>   	/* The PCS registers are accessed using mmio. The underlying
>   	 * management interface uses indirect addressing to access the MMD
> @@ -1203,9 +1210,7 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>   	 * register offsets must therefore be adjusted by left shifting the
>   	 * offset 1 bit and writing 16 bits of data.
>   	 */
> -	mmd_address <<= 1;
> -	index = mmd_address & ~pdata->xpcs_window_mask;
> -	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
> +	offset = get_index_offset(pdata, mmd_address, &index);
>   
>   	spin_lock_irqsave(&pdata->xpcs_lock, flags);
>   	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> @@ -1220,10 +1225,7 @@ static int xgbe_read_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
>   	unsigned int mmd_address;
>   	int mmd_data;
>   
> -	if (mmd_reg & XGBE_ADDR_C45)
> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
> -	else
> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>   
>   	/* The PCS registers are accessed using mmio. The underlying APB3
>   	 * management interface uses indirect addressing to access the MMD
> @@ -1248,10 +1250,7 @@ static void xgbe_write_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
>   	unsigned int mmd_address;
>   	unsigned long flags;
>   
> -	if (mmd_reg & XGBE_ADDR_C45)
> -		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
> -	else
> -		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>   
>   	/* The PCS registers are accessed using mmio. The underlying APB3
>   	 * management interface uses indirect addressing to access the MMD
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> index f409d7bd1f1e..8b0c1e450b7e 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> @@ -274,12 +274,18 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	/* Set the PCS indirect addressing definition registers */
>   	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> -	if (rdev &&
> -	    (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 0x15d0)) {
> +
> +	if (!(rdev && rdev->vendor == PCI_VENDOR_ID_AMD)) {
> +		ret = -ENODEV;
> +		goto err_pci_enable;
> +	}

This is different behavior compared to today. Today, everything would
default to the final "else" statement. With this patch you have a
possibility of failing probe now.

Thanks,
Tom

> +
> +	switch (rdev->device) {
> +	case 0x15d0:
>   		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
>   		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
> -	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
> -		   (rdev->device == 0x14b5)) {
> +		break;
> +	case 0x14b5:
>   		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
>   		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
>   
> @@ -288,9 +294,11 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   		/* Yellow Carp devices do not need rrc */
>   		pdata->vdata->enable_rrc = 0;
> -	} else {
> +		break;
> +	default:
>   		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
>   		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
> +		break;
>   	}
>   	pci_dev_put(rdev);
>   

