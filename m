Return-Path: <netdev+bounces-56484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E207880F11B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E401F210A4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A17E76DAB;
	Tue, 12 Dec 2023 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="43JsCCCD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ED395
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 07:32:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlrNrY16apWaywvdBmpIEhjq+7QfCD+eVuQf+PcXUX6EFseIRvk6AdUHK1MqOlkeH9WV2BvaeJ6HTOo4IfrxUzCWUrhhvTASAgqGX+YkKxHLL7GcnFjMf4TDAd5cnOPrtVwXCBsErNSvK5RbgfrBFTKBLZBQpQFO47bbCS2DjH6VKaj1qNMRxq28vWawL1W47L2IopZeXl6dsg81O3WEr/AQX2X/bKOPaA+5LRhik8y2xbFZnr7SGA3q83p8ATWFPUnqR/5WCQw/5kERsZV+SxjqsfSe+Xuhg4s12SPuYUc8RqzqTUCUIsHvkIAtenBLDS/TnExue3AA/DsV7fzkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meWXbYALqIzvSZMtt35dLAmdlyomf4Flu7WTDwSlNSE=;
 b=bH1kGmxUEAFVOJEI0Ra6Ru7GHNmiBq7gClewr+Wq/Kd0i6S/OSzIiXGvtKNUnbdmb84sB7p9y/k8iwKT9jFQDQucNx63DwD/AAhT8IM21xI8Vy9SDvvW8eU4tFLL1Zh8ftMmkhX8zLakyd2GUw/JA2JxDlsJDo7+K+O+ZljKybvSQXyLQbjEO+KcGKkGtOhpep2DuIRGxPAKhlMKNHbBGNXABgUzEPcUZTUk2F3BLKvNp1efhDLp1lsf8yrM0HmlUry7gih96X8eNCMo38e1D87zNx0e2/XN/Core52VQNFWxhDMx4gyEN+jdy4KBA/aFUyb1Mg8cEBt8BuJ0e9kkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meWXbYALqIzvSZMtt35dLAmdlyomf4Flu7WTDwSlNSE=;
 b=43JsCCCD7T3NSDvHAUhfBZPr0pQq+XQKYgYXVc5hMbpSCXYiabNJtngGEiSPyP2ACD6+ff+/D/IATO0qrX7cXBfvWivQeG+xC+dBjGntQi5MBvf++uFl0g22fHgp/kry6CkVk/pYo49gH4j9JsVQxR6KBf6HXI2Rulwgj3quW8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 15:32:17 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 15:32:17 +0000
Message-ID: <3067eb09-7277-4fb2-8c79-dcb2d500e15b@amd.com>
Date: Tue, 12 Dec 2023 09:32:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/3] amd-xgbe: add support for Crater ethernet
 device
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
 Sudheesh Mavila <sudheesh.mavila@amd.com>
References: <20231212053723.443772-1-Raju.Rangoju@amd.com>
 <20231212053723.443772-3-Raju.Rangoju@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231212053723.443772-3-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0091.namprd12.prod.outlook.com
 (2603:10b6:802:21::26) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: d62fef83-578b-4256-4531-08dbfb278627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MxDLdPJ8iXNRzhiEkVWhJTNWvqRY9JBeA3mTNp7t8zg4fX9gMzKEAp7LbbFwHTBjK671BVCF1/xFrSdjh00wTJ8M7RBNgq00iWh+tX/43nKUtJBklAQ+vWC324d7+WUkw10L2kJo0uEMtRsGiUUhxqp1dKe2FTw5qJziDynEJkbqJsmTsOcc9wfS4f39mNBPXl6I8JCcD/X2sE7XhTMT7MGDN5BNflazlc4qhTpN1EPyg11kus7qY5u7GgHmwHSxoqOtoQ318m7ZOu6lntLYLXvNWNo2tL2DgOLSA5cueifQBUQR8OaYlDUdFIooyLvP4XmyIZ2vS84o1Q/V945gtrjZUxVvMITjUSheVdVivOuhYB+/eAJtReIDur2nvvWRMrrxWE/U4Sad2L1762gZsJn7ijxrU7GI+jHlqLGLuUUeGtjulIa8B3FatW40bLnphmmVF87mDIeep5P9mYP/AXra9Blvoc+vC5gQw8sXcVOW4ngYscIQXY5dggq1mJSvdf8rhh3jJGopiAvUkGyOMnFaOtb5ktxi/zutoEX9JlZuNC5Um01uhIwvlLWChGKr+wGvh0SEYOyv1nDKZOyrgJu+YsQ5XF8/C494iwIMpuLgyZF95ol55Pazx7KJ8pjYUG0w2BnEtdzRNiFNyclvIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8936002)(4326008)(8676002)(2906002)(31686004)(316002)(5660300002)(66476007)(66556008)(66946007)(478600001)(6486002)(26005)(36756003)(6506007)(6512007)(53546011)(41300700001)(2616005)(83380400001)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU9TMEd6cjFvU2puVWh2MWpUZUxXSWMvT1hnMWNSVkVSM2sySDh6U24vL0ty?=
 =?utf-8?B?aFpZWlVoSE1mN3lMSHgwYnBIb21OS21ZUFQvZ2JiQWNFR0dqWm0xL2FxUDRN?=
 =?utf-8?B?L2ZzdTRoa0p0UXVOa1VYOFFBSjZtaXc1TFJPOUJJSlVVeHdKNnIzeEpJTENL?=
 =?utf-8?B?THp5OGo1TW1zS2hDYklIYzhNaEdQZEtIeXpWR1A1eFhBZks4bGwzUmFuaTho?=
 =?utf-8?B?TGx5Zi9EdTVLdlcvVTVYZzVtRTJiV1d0bUFWSzB1Z2I3YjBLOGowd04zOGxm?=
 =?utf-8?B?cWwxd2YrclV5OSsyYjBqRjA5QTQ2d1NLVlhWd3hVOVNYelpUVWpUWkkvWVY4?=
 =?utf-8?B?amYrelZTZHRPSmRrSHBiazZBT29KTkZoaVQvZmJoYjRUZS9RVS96TmlGYmRK?=
 =?utf-8?B?bzJSQXI3ZFo1MDZyOFZWNkhsdlFmYkpKcDF2N0Z1eDNrcmljNndZR0ZJNDhZ?=
 =?utf-8?B?SnB1NjByQmV2dXJtWnc4TnFGT3Ixbk5IYXFuR0JpRDBoL2lYKzZuUVlzZDZj?=
 =?utf-8?B?Y1l4NUgvcUZWTlVYY0V2U2VsNTMzQzd3NFJ2dnlNU1c1SnFqdnNvWHduM0p4?=
 =?utf-8?B?Y1R4UmMrU1ZsQkdJQXRSZjBzYThCaHR0TkZoQ2ZBbDlRajZCQU1nMTRyUGYx?=
 =?utf-8?B?cS9nTDFUTjNyOGROaXJwR1VZSVhYQ0w4cnBjVWtnRkZ5WEpVMXJ0cm1NS29V?=
 =?utf-8?B?L3NDcEJEQU52SmkxaExyRU1QeHNsL3lIMjl0YVlRMmRmbkI0MlA0Z2dsNjNy?=
 =?utf-8?B?QkVicC9sSjJOMjVaMlI1ZkpUb08xYWt1WE82Q0VHYUg2UjBkTHE2dlVaZFNW?=
 =?utf-8?B?bFJBVmMwYVVKZG5zQXI3WnBUZ3pyZEwzNVVIaklHanM0TlExczlsRE56T1Bx?=
 =?utf-8?B?NzVUZzB1QW9GWHFjME5HWGY5NTMvbmRrdVIweEg2Tk8xWEhpSWEyb1E2RzVh?=
 =?utf-8?B?Tk9oWWpOeUREVFhkNUhacEozdGd5T2x6UjlLYlBwMkZUcG4rdEk1S1gyaEhE?=
 =?utf-8?B?U0svMENmZXZGdndsRTQ2aWdaTi9iVEJBc25CYktKbzlrYndNSFMxWGpYYWxI?=
 =?utf-8?B?NU5jT1lYUEY2MXdXWGRqL3ZibVI0Ni85dlFZcmhleWN0eVhqZHRvT3F5eEU3?=
 =?utf-8?B?ZFdDSVF4Qnd2T1JoYXY3ZGhDb2FFemtDaDRla0xRUW8ybzg2MlY5RTdORjlS?=
 =?utf-8?B?aTdWanJuWnJzMTkzU0dqS0RQNnkyQWgwWHFBL3c5N0x3cnFmQ1pvTzdlaGM2?=
 =?utf-8?B?VEozSHFrUnREKzhIYkk1YU4zNTQrN2xqcndzUlAva0hQL2RWdXhWV1o2U0Fv?=
 =?utf-8?B?d2FKalJqOGM4ZWNvdnY2enJDZ244QUpFdytYNFV2U3Z0U3padnZscUV5WFVZ?=
 =?utf-8?B?Nkx1VXE5MkJOaXF0NzVoM1BqYW9yMXkxdXQ1eTJPNURFOWJXK2NUUlhqdzFE?=
 =?utf-8?B?cWxTbGx1VTBmUWIzbnZ4Qnl1WWM4UUZEVlhWZlNmYk5jWlcrOGVmc09KMW9h?=
 =?utf-8?B?cE50eWdiMFpnNHRaTzZpS1YwMU5yQjA2ZDI2c2NTcFFHVCt1blkzUzAwaEpZ?=
 =?utf-8?B?VGRpanpRK1lmQ29OQytVSi95Y201MXprNnRrNWlXaVdhUzR1R0ZjYTNCeFVz?=
 =?utf-8?B?SHh5RFc4YUxyVmVGMTQycVYyWXJYVWhQRGFaelVUTzkyL1dUMFdrYTYwUVpR?=
 =?utf-8?B?VDNRSVdRdG5LSW1QOHo1bWhyMkgzMVNxa1kvQUhSaklQaE8vY2VVcEJQRjRD?=
 =?utf-8?B?NzlyS3JrUHlpWXhDcDBLb05VWkhzaDVPVzZBRmsxaHB5UUNPVXNibVF4TnpQ?=
 =?utf-8?B?Sno1VmlyY0NXRExVREtUUDRablpQako1cERYN3ZSZ1ZkSG5Hd2tFeVVqV3RH?=
 =?utf-8?B?ZGwvaUpEZFRsSmY0YWJUSWQ5T2tyUSs5T3hzOUxNY2RDd3VXdFhkYWtxbUlt?=
 =?utf-8?B?dFp1U29rSENHWkZQNDlFaGdIK056YjZLVWw1UlNCSDAzQWhsNW9HR3NIV3d2?=
 =?utf-8?B?RWJwN3Y2bmZCN2RCejJIUGphd1pRYVdweXVnN3dJKy9HYVZOcnY2TEJ6U1ZG?=
 =?utf-8?B?QnpkQ0FwQmFkN1FJTndPZkIwYXlMdXFKelVjazhsSEJMTVRTa2hUQlErREJS?=
 =?utf-8?Q?nQZlbc27QSCzYMkDd9Ho+qwQl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62fef83-578b-4256-4531-08dbfb278627
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 15:32:17.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1CdIeEBk9YIolBkbU61KXnu0C2SCTJYr182Amvim4sV/hwcctlUpWtG5QU7DlYO9GZpa3Rn/CyDxfbE5w6GKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358

On 12/11/23 23:37, Raju Rangoju wrote:
> Add the necessary support to enable Crater ethernet device. Since the
> BAR1 address cannot be used to access the XPCS registers on Crater, use
> the pci_{read/write}_config_dword calls. Also, include the new pci device
> id 0x1641 to register Crater device with PCIe.
> 
> Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 ++
>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 93 +++++++++++++++++++++
>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 35 +++++++-
>   drivers/net/ethernet/amd/xgbe/xgbe.h        |  6 ++
>   4 files changed, 137 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> index 3b70f6737633..e1f70f0528ef 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> @@ -900,6 +900,11 @@
>   #define PCS_V2_RV_WINDOW_SELECT		0x1064
>   #define PCS_V2_YC_WINDOW_DEF		0x18060
>   #define PCS_V2_YC_WINDOW_SELECT		0x18064
> +#define PCS_V2_RN_WINDOW_DEF		0xF8078
> +#define PCS_V2_RN_WINDOW_SELECT		0xF807c

Should this be PCS_V3_ (here and below) ??

> +
> +#define PCS_RN_SMN_BASE_ADDR		0x11E00000
> +#define PCS_RN_PORT_ADDR_SIZE		0x100000

All hex characters should be consistent and in lower case.

>   
>   /* PCS register entry bit positions and sizes */
>   #define PCS_V2_WINDOW_DEF_OFFSET_INDEX	6
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index 6cd003c24a64..a9eb2ffa9f73 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -120,6 +120,7 @@
>   #include <linux/bitrev.h>
>   #include <linux/crc32.h>
>   #include <linux/crc32poly.h>
> +#include <linux/pci.h>
>   
>   #include "xgbe.h"
>   #include "xgbe-common.h"
> @@ -1165,6 +1166,92 @@ static unsigned int get_index_offset(struct xgbe_prv_data *pdata, unsigned int m
>   	return pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>   }
>   
> +static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
> +				 int mmd_reg)
> +{
> +	unsigned int mmd_address, index, offset;
> +	struct pci_dev *rdev;
> +	unsigned long flags;
> +	int mmd_data;
> +
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (!rdev)
> +		return 0;
> +
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
> +
> +	/* The PCS registers are accessed using mmio. The underlying
> +	 * management interface uses indirect addressing to access the MMD
> +	 * register sets. This requires accessing of the PCS register in two
> +	 * phases, an address phase and a data phase.
> +	 *
> +	 * The mmio interface is based on 16-bit offsets and values. All
> +	 * register offsets must therefore be adjusted by left shifting the
> +	 * offset 1 bit and reading 16 bits of data.
> +	 */
> +	offset = get_index_offset(pdata, mmd_address, &index);
> +
> +	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> +	pci_write_config_dword(rdev, 0x64, index);
> +	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
> +	pci_read_config_dword(rdev, 0x64, &mmd_data);
> +	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
> +				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
> +	pci_dev_put(rdev);
> +
> +	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
> +
> +	return mmd_data;
> +}
> +
> +static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
> +				   int mmd_reg, int mmd_data)
> +{
> +	unsigned int mmd_address, index, offset, ctr_mmd_data;
> +	struct pci_dev *rdev;
> +	unsigned long flags;
> +
> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> +	if (!rdev)
> +		return;
> +
> +	mmd_address = get_mmd_address(pdata, mmd_reg);
> +
> +	/* The PCS registers are accessed using mmio. The underlying
> +	 * management interface uses indirect addressing to access the MMD
> +	 * register sets. This requires accessing of the PCS register in two
> +	 * phases, an address phase and a data phase.
> +	 *
> +	 * The mmio interface is based on 16-bit offsets and values. All
> +	 * register offsets must therefore be adjusted by left shifting the
> +	 * offset 1 bit and writing 16 bits of data.
> +	 */
> +	offset = get_index_offset(pdata, mmd_address, &index);
> +
> +	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> +	pci_write_config_dword(rdev, 0x64, index);
> +	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
> +	pci_read_config_dword(rdev, 0x64, &ctr_mmd_data);
> +	if (offset % 4) {
> +		ctr_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data) |
> +			       FIELD_GET(XGBE_GEN_LO_MASK, ctr_mmd_data);
> +	} else {
> +		ctr_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK,
> +					  FIELD_GET(XGBE_GEN_HI_MASK, ctr_mmd_data)) |
> +			       FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
> +	}

Braces aren't necessary.

Also, just curious, what is the "ctr" prefix meant to imply here?


> +
> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
> +	pci_write_config_dword(rdev, 0x64, index);
> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + offset));
> +	pci_write_config_dword(rdev, 0x64, ctr_mmd_data);
> +	pci_dev_put(rdev);
> +
> +	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
> +}
> +
>   static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>   				 int mmd_reg)
>   {
> @@ -1274,6 +1361,9 @@ static int xgbe_read_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
>   	case XGBE_XPCS_ACCESS_V1:
>   		return xgbe_read_mmd_regs_v1(pdata, prtad, mmd_reg);
>   
> +	case XGBE_XPCS_ACCESS_V3:
> +		return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
> +
>   	case XGBE_XPCS_ACCESS_V2:
>   	default:
>   		return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
> @@ -1287,6 +1377,9 @@ static void xgbe_write_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
>   	case XGBE_XPCS_ACCESS_V1:
>   		return xgbe_write_mmd_regs_v1(pdata, prtad, mmd_reg, mmd_data);
>   
> +	case XGBE_XPCS_ACCESS_V3:
> +		return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
> +
>   	case XGBE_XPCS_ACCESS_V2:
>   	default:
>   		return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> index 8b0c1e450b7e..db3e8aac3339 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> @@ -295,15 +295,28 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		/* Yellow Carp devices do not need rrc */
>   		pdata->vdata->enable_rrc = 0;
>   		break;
> +	case 0x1630:

What PCI ID is this, it doesn't match the 0x1641 added below?

Thanks,
Tom

> +		pdata->xpcs_window_def_reg = PCS_V2_RN_WINDOW_DEF;
> +		pdata->xpcs_window_sel_reg = PCS_V2_RN_WINDOW_SELECT;
> +		break;
>   	default:
>   		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
>   		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
>   		break;
>   	}
> -	pci_dev_put(rdev);
>   
>   	/* Configure the PCS indirect addressing support */
> -	reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
> +	if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
> +		reg = XP_IOREAD(pdata, XP_PROP_0);
> +		pdata->xphy_base = PCS_RN_SMN_BASE_ADDR +
> +				   (PCS_RN_PORT_ADDR_SIZE * XP_GET_BITS(reg, XP_PROP_0, PORT_ID));
> +		pci_write_config_dword(rdev, 0x60, pdata->xphy_base + (pdata->xpcs_window_def_reg));
> +		pci_read_config_dword(rdev, 0x64, &reg);
> +	} else {
> +		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
> +	}
> +	pci_dev_put(rdev);
> +
>   	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
>   	pdata->xpcs_window <<= 6;
>   	pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
> @@ -481,6 +494,22 @@ static int __maybe_unused xgbe_pci_resume(struct device *dev)
>   	return ret;
>   }
>   
> +static struct xgbe_version_data xgbe_v3 = {
> +	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
> +	.xpcs_access			= XGBE_XPCS_ACCESS_V3,
> +	.mmc_64bit			= 1,
> +	.tx_max_fifo_size		= 65536,
> +	.rx_max_fifo_size		= 65536,
> +	.tx_tstamp_workaround		= 1,
> +	.ecc_support			= 1,
> +	.i2c_support			= 1,
> +	.irq_reissue_support		= 1,
> +	.tx_desc_prefetch		= 5,
> +	.rx_desc_prefetch		= 5,
> +	.an_cdr_workaround		= 0,
> +	.enable_rrc			= 0,
> +};
> +
>   static struct xgbe_version_data xgbe_v2a = {
>   	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
>   	.xpcs_access			= XGBE_XPCS_ACCESS_V2,
> @@ -518,6 +547,8 @@ static const struct pci_device_id xgbe_pci_table[] = {
>   	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
>   	{ PCI_VDEVICE(AMD, 0x1459),
>   	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
> +	{ PCI_VDEVICE(AMD, 0x1641),
> +	  .driver_data = (kernel_ulong_t)&xgbe_v3 },
>   	/* Last entry must be zero */
>   	{ 0, }
>   };
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index ad136ed493ed..dbb1faaf6185 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -347,6 +347,10 @@
>   		    (_src)->link_modes._sname,		\
>   		    __ETHTOOL_LINK_MODE_MASK_NBITS)
>   
> +/* Generic low and high masks */
> +#define XGBE_GEN_HI_MASK	GENMASK(31, 16)
> +#define XGBE_GEN_LO_MASK	GENMASK(15, 0)
> +
>   struct xgbe_prv_data;
>   
>   struct xgbe_packet_data {
> @@ -565,6 +569,7 @@ enum xgbe_speed {
>   enum xgbe_xpcs_access {
>   	XGBE_XPCS_ACCESS_V1 = 0,
>   	XGBE_XPCS_ACCESS_V2,
> +	XGBE_XPCS_ACCESS_V3,
>   };
>   
>   enum xgbe_an_mode {
> @@ -1056,6 +1061,7 @@ struct xgbe_prv_data {
>   	struct device *dev;
>   	struct platform_device *phy_platdev;
>   	struct device *phy_dev;
> +	unsigned int xphy_base;
>   
>   	/* Version related data */
>   	struct xgbe_version_data *vdata;

