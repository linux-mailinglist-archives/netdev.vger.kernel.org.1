Return-Path: <netdev+bounces-42826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7797D0429
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 23:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B46B21207
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDECA3E00B;
	Thu, 19 Oct 2023 21:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YTo0huSL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633B3E003
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 21:47:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB15106
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 14:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoD9x42QHjyxxRYuyP7bJ9blBJ+eGMcCTSMrT84ryNkvtU70vXt6I2gmNEiH3MrFNChLfWkgc9onUuRKgyLBTH0XMol4ys2Gy5xgvrKy5CVUvO3JpSC1ti8mQpbNK35AUoFfcsmxDagXSkUxV1XQyjCg29ub5QNahaQJI4rOYL5KUqU0inpKKwpDgjB7RRJ4f/SVL+suEvo58mVSdhjh+EIxmjg4B7D4zegEvUt8MYM0RBWz/SWUzuwQ8QWdPebgVS7NvYABnAa/dRzHqzdfvt1gDK6hmtJxWexGbZJHzDloRAE8Y2r5BPkuWGVzmEEX2XUoSzL/1yBJlT+lCeCIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E4IuWWCHVFn4Fvqk/hfJbDzICD8zg/jmckaiJL5SMM=;
 b=VgeIz9AjIzNF1LqHouxKMFaRlKxw1L4bUxVT5Jx+khEjlQNoh8Xk2QMRCh5+mkRCRvz7huAW3XoPCWQ1u4JvG7+3sZEguSv5pqP5SdD1B7+GExJD1QqV7EQdG50ENeX0E3MzdWib14ti+oL/bzWXB1aqsXZa0EwH7NWSlsY+iHhr/G39jd26ul8X1fGakqCKDJ/3/omRt2gpnvZeri7amzPTx0grJ14TUBSeAZ5UhaKDEmZN88SV0V4jOBjmZc32mZTHHbAeMAT/NfjyDz9mtyJPamVgfpSc6LAKV3DBFPvVk1NZdCawHjpOXC5mmccnbC2nG70vB+jXvHHNaLVsgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E4IuWWCHVFn4Fvqk/hfJbDzICD8zg/jmckaiJL5SMM=;
 b=YTo0huSLRI2lG+X8QHDOTHdx2iieg/pb5wpUxA7wRXMMpvM8wJ1ONlPsJoPqOBt11TJPbb3O0L/9XcvSw7XOmITXb9VQzQY1Gx0RdxaDSiCMf5s/DMXMEZ7NVo78LMwONoIXeYNadMsbY19bZ6zNtJDr0QD3YEOFv6YTVg1J7dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 21:47:15 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::a13:336d:96a5:b7bf]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::a13:336d:96a5:b7bf%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 21:47:15 +0000
Message-ID: <6852eb10-ff39-44d2-ba0f-cb77f1a9aaf8@amd.com>
Date: Thu, 19 Oct 2023 16:47:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] amd-xgbe: Add support for AMD Crater
 ethernet device
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
 Sudheesh Mavila <sudheesh.mavila@amd.com>
References: <20231018144450.2061125-1-Raju.Rangoju@amd.com>
 <20231018144450.2061125-3-Raju.Rangoju@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231018144450.2061125-3-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0127.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::17) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf1090e-c5dd-4df9-ce52-08dbd0ecf553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3wVki5I/lPnso7ARGV+ooW7UTkExUFjqF2uDKhtEBLQcMETpXggC3rDlDq5Zuaktb144Hy3G4UAQoSGsem4MKEboO3oqKHiL8A5YJ/Tsx6Vu111pGkov2quQkNnHsouUr7yQyue3YPo7cY+0fKzoh7aUdN5cnakCNff0YKST2XKqiV69c1X6RZ2ztBc9RAwoC0dq4RpTpj7bI75Vy12j+FhMyDNZbQKSybO4tD0Gv1BQz/eL6amuCF3WDIwyC5cY5aimC/cJ73MjsBY/cArTjmMEYe7s/+XE/QEfIe81WZmZTFXGTiBWgeTxgvRKXA3M+tUSU5jG1eKBxLKydEcu3sKuipyyfCgbA1JaMyYD+0Q4IVSmqNJ3J1lLQS+BFM6/nrj3Wha3ooqp3E+Itpgec6BX6rnzNacp6PxO3z3DpKPLwvxBfAByh9A42lZrZ8WSLLlDqnQ52+vf1GVAeRbHz1FxLj6ohMTEC4t8qjbAz17OOmDX74hhhShnr7tp3njmJtLAjQM7VYRFsOoDl7ncebJsZ2bOgpGy5TWtd+mWrBTn3TOsPcmer1KFqul9U/gEsvlR6ivkwJrvPLsqdo3WFe5p0qZgHMnuD1mZ+nEwjOWjUjXQj5zNAWVqVb/UdY5XU1iakJzej4On3itRgDxRcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2616005)(66946007)(316002)(66556008)(66476007)(26005)(478600001)(6666004)(6512007)(53546011)(6486002)(6506007)(36756003)(5660300002)(41300700001)(31696002)(2906002)(86362001)(83380400001)(38100700002)(31686004)(4326008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUh2MVgvQlg4a3Bab3h2SjJqcDRMd1kvR2ZFbzBmcW5MUWRxdjZwdlBtZ2pR?=
 =?utf-8?B?L0xkNGNoeFJIK3JQTUFGMnZpamlsMng4Yjk2TG1hcnZxcHluY2pKZmwrYmlZ?=
 =?utf-8?B?V0xWN3BUS0JJNHI2enZZTXczUzVNU20wNmpRYTdJd1N2MXFBVHlvdHJOK0Jj?=
 =?utf-8?B?Z3ZkcG5oeGdySDhPUFhJMTlzcG9RL2tmNkthOWpMcXNKb0RLZWd5dC9qb01T?=
 =?utf-8?B?YUxKZHZvK01neG5tT203SkpKTnlOem9pdGFEd0FoS2lLZWNSMVEwQWJ4WmNQ?=
 =?utf-8?B?cTVKcWxjZ1h5YTVNOU45U3lQUElWb0FsN3lncHFCcTNjdVdjY1dBNVlvN0Jr?=
 =?utf-8?B?UERFblllaTVXbG9yUnpUMUhwSWNQVUZZMmVHeWFSZDBqNkdxczY0YmdhNzJZ?=
 =?utf-8?B?QTY2c09maXkrVGtkZG53blNLMEZZZVZpOCtieTVsam5TeUFwT3UvUkZrSS95?=
 =?utf-8?B?NVRvZTdaOENQenBJbkxZR0k5Q0RRZUNHK3R6L1FIM21xR2k5d3ZlRGVQbkk5?=
 =?utf-8?B?S0szRTBIWTVOM3ZvNVRGbGVrZFIzZHBWaUI4Wk5vWHVXbzhzeTU4NmltR3NX?=
 =?utf-8?B?cmJvdUdEcEUyYWloTFNTTlRwd0RmRW8zMmk1V0NBc00yNTRNNnlBT3U5RHJV?=
 =?utf-8?B?emlXVlh2R1BoaHlKZlI2S21Zbi9ENUJuYU1mc3hxOGFXSndRQnVaWWV0SFhW?=
 =?utf-8?B?V2lyTXBPUEE0Y1VpaDBCSnhKVG03Mlg5NUZMbkNIdmZZakprdTR5ZDBzVVNE?=
 =?utf-8?B?MmF1K2NwandJUmRvU1B1SzNsSUFZT2dMMVJOTlBqZ2p0dndraVV5clRRK3ln?=
 =?utf-8?B?R3dsVGI4Zk1KbFdnUVJheVdHRk5WUEJTbTRLenhDdFV0WVMxODV6RGZEbHdu?=
 =?utf-8?B?TUNLcWZXbStXQ1dYaDBmdFczR3Y1dktnRlFOVmRHM1NSeWZ6YjQ0RHRzU1A5?=
 =?utf-8?B?ZngzZDR0QS90aGpqb1h3NGE4bjJMMlVmS28xT29XVFdEV3Q2dGlMNWwyaGdr?=
 =?utf-8?B?Z1BqRDU3dmt2eE9aN0dyWHp0SU01MzY1S1dhOC94cGNLQ3NCcnd0SURjUXly?=
 =?utf-8?B?aDkvTTZRYUxxdjhZdGNlYVNoWlpMSEFpSThXNERZSWRnY3R2RkVFUHY3cmI0?=
 =?utf-8?B?cHRQSTRiMUFjNWZGdEltSmMzVUxINStKZjRZd09ZbGlFOTl6Y01PTDhwODBH?=
 =?utf-8?B?VXZKcjVSeU9XMUtlQWorQkRMdHJRWTZGcFBWMFhnNFQ3OHJ5MlhodEw0QkZx?=
 =?utf-8?B?a3ZlQzJwWFljYmw5UG9CbmpyOFdUQ0hiSGptYkhISG9MTnNCeFZWNGJCQ3BI?=
 =?utf-8?B?ZWFxajB3MGxWZTB0R3pFK2k5RjJ1WHNFS3doTEhXTENWRCtGRlJKTHRIVEhq?=
 =?utf-8?B?MHNWdVZ5TmFvK0QzbWtUOEFXNmZCL0IyWU1YZ2VONlMybVpiUWJuOU1hemdy?=
 =?utf-8?B?aXN5ZDZ5WHhzd1hNYis2c2VHbTdxYjBwcXpmSUNETVpseEFKbkp4K0J5cGlr?=
 =?utf-8?B?SVB2N1B5a2t1MGJPT1lwSjBCYVd2NmVzWGlqcmhlbTEyck9HTFFrRHlxTGFK?=
 =?utf-8?B?dUlyQTlZZllNdHAzSXNJWEM5dEtORC9VbVBEdGdKdGVRd0p5cVVLQWhPYkt4?=
 =?utf-8?B?Q1FZUlh4VTdtNmlGYlNMUThpRWs5TjE0NU9SWC9DUVJoMGpCblphZHhnbkVZ?=
 =?utf-8?B?YzJwQ09GR1Y5TXhJaXVZN2EvK0E5eXJwN0hWamhVa3NsUkVqZXg0aTViNVdU?=
 =?utf-8?B?YTllYUpMb2NsM2puNVY5SzFOTHc5WE4zTFhOQ3cyRndxZWlmVjJDZ1hKQWlF?=
 =?utf-8?B?UURCbTlvT3JqNDlIMUZrb0srOUNyWXhHb1dONVh3UUJCRC9EdWNBZWdyQ1ZE?=
 =?utf-8?B?N09IWkp3ZytNZWhNZHlvREd6MFNuWXdwWTM5SWh0RzFMUkpqZHllMnlkeUNr?=
 =?utf-8?B?Y1h5SktoL2R5d3FQUk15MGhwMEcva3VYcjJYTDY3TEgrRmhNb2Z4SGdLWDlY?=
 =?utf-8?B?eTUycnBLcXJsdE02R2NCd1JOb0gxSmY4aG1aUG5uWngzNHUzZnhIMEVweHlm?=
 =?utf-8?B?cEdKSVlTL00yYk5ZREgzb2ZjWVl5ZFEwZmNHTElpcXJjeFh1THhQMHNRWUlS?=
 =?utf-8?Q?jHtsXrZch6Q7OFosWzMThGZkF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf1090e-c5dd-4df9-ce52-08dbd0ecf553
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 21:47:15.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAfn1rhyLeUpTi3m+hnTaRtGCEPfbx58P3vUEwhNqRCWpVREiSbL4yXLabqm8wBPcdG2NYbEcboVFjA+DgW5aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196

On 10/18/23 09:44, Raju Rangoju wrote:
> The AMD Crater device has new window settings for the XPCS access, add
> support to adopt to the new window settings. There is a hardware bug
> where in the BAR1 registers cannot be accessed directly. As a fallback
> mechanism, access these PCS registers through indirect access via SMN. >
> Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 ++++
>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 33 +++++++++++++++++----
>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 32 +++++++++++++++-----
>   drivers/net/ethernet/amd/xgbe/xgbe.h        |  6 ++++
>   4 files changed, 63 insertions(+), 13 deletions(-)
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
> +
> +#define PCS_RN_SMN_BASE_ADDR		0x11E00000
> +#define PCS_RN_PORT_ADDR_SIZE		0x100000
>   
>   /* PCS register entry bit positions and sizes */
>   #define PCS_V2_WINDOW_DEF_OFFSET_INDEX	6
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index f393228d41c7..da8ec218282f 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -1176,8 +1176,17 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>   	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>   
>   	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> -	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> -	mmd_data = XPCS16_IOREAD(pdata, offset);
> +	if (pdata->vdata->is_crater) {

This feels like it should be a new xgbe_read_mmd_regs_v3() and devices 
with the this bug should have a new XGBE_XPCS_ACCESS_V3 type for 
pdata->vdata->xpcs_access.

Feel free to write a pre-patch, too, that creates helper functions to 
calculate the mmd_address for v1/2/3 and the index/offset for v2/3 types.

> +		amd_smn_write(0,
> +			      (pdata->xphy_base + pdata->xpcs_window_sel_reg),

No need for the parentheses here and all the parameters can be on one line 
now that there is a 100 character line limit.

> +			      index);
> +		amd_smn_read(0, pdata->xphy_base + offset, &mmd_data);
> +		mmd_data = (offset % ALIGNMENT_VAL) ?
> +			   ((mmd_data >> 16) & 0xffff) : (mmd_data & 0xffff);
> +	} else {
> +		XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> +		mmd_data = XPCS16_IOREAD(pdata, offset);
> +	}
>   	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>   
>   	return mmd_data;
> @@ -1186,8 +1195,8 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>   static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>   				   int mmd_reg, int mmd_data)
>   {
> +	unsigned int mmd_address, index, offset, crtr_mmd_data;
>   	unsigned long flags;
> -	unsigned int mmd_address, index, offset;
>   
>   	if (mmd_reg & XGBE_ADDR_C45)
>   		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
> @@ -1208,8 +1217,22 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>   	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>   
>   	spin_lock_irqsave(&pdata->xpcs_lock, flags);
> -	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> -	XPCS16_IOWRITE(pdata, offset, mmd_data);
> +	if (pdata->vdata->is_crater) {
> +		amd_smn_write(0, (pdata->xphy_base + pdata->xpcs_window_sel_reg), index);

No parentheses needed on "(pdata->xphy_base + pdata->xpcs_window_sel_reg)"

> +		amd_smn_read(0, pdata->xphy_base + offset, &crtr_mmd_data);
> +		if (offset % ALIGNMENT_VAL) {
> +			crtr_mmd_data &= ~GENMASK(31, 16);
> +			crtr_mmd_data |=  (mmd_data << 16);
> +		} else {
> +			crtr_mmd_data &= ~GENMASK(15, 0);
> +			crtr_mmd_data |=  (mmd_data);
> +		}
> +		amd_smn_write(0, (pdata->xphy_base + pdata->xpcs_window_sel_reg), index);

Ditto on the parentheses here...

> +		amd_smn_write(0, (pdata->xphy_base + offset), crtr_mmd_data);

and here.

> +	} else {
> +		XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
> +		XPCS16_IOWRITE(pdata, offset, mmd_data);
> +	}

Ditto here, having a v3 function will make this much cleaner.

>   	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>   }
>   
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> index a17359d43b45..90ad520d3c29 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
> @@ -279,15 +279,21 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
>   		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
>   	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
> -		   (rdev->device == 0x14b5)) {
> -		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
> -		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
> -
> -		/* Yellow Carp devices do not need cdr workaround */
> +		   ((rdev->device == 0x14b5) || (rdev->device == 0x1630))) {

At this point it might make sense to move to a switch statement for each 
device.

> +		/* Yellow Carp and Crater devices
> +		 * do not need cdr workaround and RRC

Please use the full width available for comments.

> +		 */
>   		pdata->vdata->an_cdr_workaround = 0;
> -
> -		/* Yellow Carp devices do not need rrc */
>   		pdata->vdata->enable_rrc = 0;
> +
> +		if (rdev->device == 0x1630) {
> +			pdata->xpcs_window_def_reg = PCS_V2_RN_WINDOW_DEF;
> +			pdata->xpcs_window_sel_reg = PCS_V2_RN_WINDOW_SELECT;
> +			pdata->vdata->is_crater = true;
> +		} else {
> +			pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
> +			pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
> +		}
>   	} else {
>   		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
>   		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
> @@ -295,7 +301,17 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	pci_dev_put(rdev);
>   
>   	/* Configure the PCS indirect addressing support */
> -	reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
> +	if (pdata->vdata->is_crater) {
> +		reg = XP_IOREAD(pdata, XP_PROP_0);
> +		pdata->xphy_base = PCS_RN_SMN_BASE_ADDR +
> +				   (PCS_RN_PORT_ADDR_SIZE *
> +				    XP_GET_BITS(reg, XP_PROP_0, PORT_ID));
> +		if (netif_msg_probe(pdata))
> +			dev_dbg(dev, "xphy_base = %#08x\n", pdata->xphy_base);
> +		amd_smn_read(0, pdata->xphy_base + (pdata->xpcs_window_def_reg), &reg);

No need for the parentheses around "(pdata->xpcs_window_def_reg)"

> +	} else {
> +		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
> +	}
>   	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
>   	pdata->xpcs_window <<= 6;
>   	pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index ad136ed493ed..a161fac35643 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -133,6 +133,7 @@
>   #include <linux/dcache.h>
>   #include <linux/ethtool.h>
>   #include <linux/list.h>
> +#include <asm/amd_nb.h>

Why is this needed in this header?

Also, this is buildable for arm64 only, so you'll need to protect the use 
of this include with a "#ifdef CONFIG_X86" when you put it in the proper 
file(s).

>   
>   #define XGBE_DRV_NAME		"amd-xgbe"
>   #define XGBE_DRV_DESC		"AMD 10 Gigabit Ethernet Driver"
> @@ -305,6 +306,9 @@
>   /* MDIO port types */
>   #define XGMAC_MAX_C22_PORT		3
>   
> + /* offset alignment */
> +#define ALIGNMENT_VAL			4

This is a bit generic, how about something that describes what this is a 
bit more.

> +
>   /* Link mode bit operations */
>   #define XGBE_ZERO_SUP(_ls)		\
>   	ethtool_link_ksettings_zero_link_mode((_ls), supported)
> @@ -1046,6 +1050,7 @@ struct xgbe_version_data {
>   	unsigned int rx_desc_prefetch;
>   	unsigned int an_cdr_workaround;
>   	unsigned int enable_rrc;
> +	bool is_crater;

Probably better to name this "use_smn" or such vs is_crater.

>   };
>   
>   struct xgbe_prv_data {
> @@ -1056,6 +1061,7 @@ struct xgbe_prv_data {
>   	struct device *dev;
>   	struct platform_device *phy_platdev;
>   	struct device *phy_dev;
> +	unsigned int xphy_base;

And then probably better to name this smn_base.

Thanks,
Tom

>   
>   	/* Version related data */
>   	struct xgbe_version_data *vdata;

