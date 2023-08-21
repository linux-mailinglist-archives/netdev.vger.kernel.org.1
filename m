Return-Path: <netdev+bounces-29357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D31D782CEE
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7671C20917
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E05C79FB;
	Mon, 21 Aug 2023 15:08:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726C8460
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 15:08:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8778CE2
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 08:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIzjjDmsCKzHsM+8wxYHk2HtrPMWt4Ihfwe/JpPadflZc3zxUL5xPsbOhZKTWinvNNiEaxR1LXtVANBmZUqr37YmLpco+rqjrHZv8/rEmTaNGTGjGRVLT116Jrh5C5eej5Po2BMzxJohOpRiOR7bIupk6oBIdsIkFZiWnkd1rapfPDdRc6XBwXZcK1oGTp3N6unYxoaKU4KUHMDxVL1GRSDPNVJoGwOfVBxuFh8XzLIyUl+u1otlv9Br8EKl5gtWy0oZ1QVevKclsSHuPAbysTLdSn0eQNR94d+R/IrLmFNMIlzE8E6Dn3DLLUvHoEGYW6rSM8E7XLp8SEL62FzLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c06KY26Gidy306yiF25w3Qoly7qhwYdeEZnY/2/FjOs=;
 b=cJwM0ZNfZ6j9S7NdOyArMA7twQjTX363VcoG9NKyMeHE4YvX0QI+RabhuNsBiFoRPu7TrF4I6NmVXow3d7PtGjnaPRXyZZcH0B37cn7fid8QqwgU7zoPUCk1cm7HXYnLvlmaPCiUqyg0IX7RqqGd57JHncZJ5JvOx+oK/4hZ+K8S0Xxc3HLfcxQ0yYeLEdANr5Cxf5waI5vBw2uTVuC9R3kTh57f7S0UpRkoaiYA5MpxVAR8xM1NI+7vJZ4WideVda0SafxFL7zEiZf3vwGyia/ejZNLSI2IZ4Mov5SVJ4dw5yjPW4JQnv3WK4oObCP0ujgsX0ZdTXWQRxaB3qkAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c06KY26Gidy306yiF25w3Qoly7qhwYdeEZnY/2/FjOs=;
 b=jMTgtXC9cC/yBnfG9udpLMws8hSArzdE3YO0o3SBUhU9MipJqy62kqUruxpfydVyITfvcJOTsc9DR5zJz2+Z9Bvi1dRnUcGLMJ5Xy22t06a4VESMDxFFXI6FNvE5MrvYs8NR9TGJXCwnIGLpudgWVA/1LpGaa6coxTwF1cwHxbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CH2PR12MB4874.namprd12.prod.outlook.com (2603:10b6:610:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 15:08:35 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::ee63:b5d6:340c:63b2]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::ee63:b5d6:340c:63b2%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 15:08:35 +0000
Message-ID: <410d85bd-4bc4-00d8-c720-c9158c03bffd@amd.com>
Date: Mon, 21 Aug 2023 08:08:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] ionic: Remove unused declarations
Content-Language: en-US
To: Yue Haibing <yuehaibing@huawei.com>, shannon.nelson@amd.com,
 brett.creeley@amd.com, drivers@pensando.io, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20230821134717.51936-1-yuehaibing@huawei.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20230821134717.51936-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CH2PR12MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: 532d639c-8c4b-40cf-6d8b-08dba2587d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jVmV306cseao35aZop8ccNyQEltvC09gxbJ+BCGoyQn4Spi5YGAlTfFUJfhe48B8PK4W+UEt+IUqQ2IDq9CVHORGu2caFXeEg5OgaqXaqNF8ajDvexqIqMsbdTYtxZIslrWvznQkW30+ux0hSNjQqBKpvL0/kc0eAR+MjYhou/fnVLL0uJSyROwAFRgL5J33a5O3YmzLNJ/kgoLlTe0muHgj+/y/KyZReeFu83J4kR1dzcUp9+wZCFThROXAh9yuBKL1QsGNhTVZa7XgGmooi5bbHNrNd/gIywFAlf7CBqUWrsR+tZHmilQ5X8h2wgsijuVC4TlteQjn/oQv7qjX0bCJDxJ6/2CfUHMb/o9dOvRspuCI9HlqR0EWHWdzJ4ONXVntH/PC2Fu0uc98Y3AhmMDOiog1NtqtATL4LYZtX8pgK57EWkuxjYBeHCfrexRKIVbLmvcU5NK5lB1XrSL3sPmVU2+DyeXBAgAQOGGLjefTOqTU39cZJVv+nOVTU43mD/1DetGaWJys1h8/s/1esANU6eyAkNT/9eTNmiBzAn9BvBogSTUrBq/AeXhxgApDTQdrPild8fIcALeMOuxBqXTGRf3ZM7KayPkWyfP7lYSwKWBR7mCeAg7cA/mgd5MnXCT78JVbTf5ee94n6U4RDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(53546011)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(66946007)(316002)(6512007)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXR2ejlkb2d2bG56b2x0Zkc0MzRFRzlqSUJDTXp4ZGI1WXF5WU4rTjNqNEFB?=
 =?utf-8?B?eFBwWURJdlA3enRjcW9nZFFYSHd6RTZXVWx3TjA2RVVnUjFUcWNZazdMRWtO?=
 =?utf-8?B?OGNRZXBpNnlPeUZMMFVMWlFVS1VDc1I3R3NKWnV1Q3hXZUtDUWhrcmNCSmZ0?=
 =?utf-8?B?QWhHdUMrWjN5eTNRZVFrY2tlSVUrN1k2ZVlnbk54T2ZXa1BraUdCS1dFaW41?=
 =?utf-8?B?NGdTN2d0dkNxMTJONW1meXYzRnppaE91c1RNNk5hdVA4ZzhpdHplcjVVS2FR?=
 =?utf-8?B?NEJseDRIbkFhQVNCdEpjODZka1VOUHNCUUJRR0tXZThyeE02bDR3S0IrQjVM?=
 =?utf-8?B?ck5iOWJFdzB0UmRzR0hXb1NabE5SMzJlNW9TVjBpdlFSbk9PK2FPTGxNQnNS?=
 =?utf-8?B?WDVSOUh0elU5b3czQVlKV0ZVcW9OOW1SZ3NqeFBSS0QzdUZVZDFoL0hSWmFI?=
 =?utf-8?B?aUJtK25KREhzOGhXZVJ2U0xab1JoOUpObEZCbksrSUxDSFFYY2YxU2RweFNZ?=
 =?utf-8?B?UmFYbjFLT2RESzdGUnovaTVhRkhEY2U4OEMyNFNsWHdySmIrSjFBUzBIWjlM?=
 =?utf-8?B?SzFtYit2bE4rRE80cFZRdGs3TjZ0ODJmNTg3SDdEaHo2QUNpK2wrWEw2dnVF?=
 =?utf-8?B?SkVYTnFFNmF1bUtGT2lTYk5zTFNrWWt4T3doVGhvM094ZEY2WHJYZHdWNTVQ?=
 =?utf-8?B?M3laSG1DNjFHTUdNaGtxOXljRzdvMEN3VUxwSWlHQ05DNFpKQjU5R0JCNTJz?=
 =?utf-8?B?R25zRHpab2phdnhFekx5WFhlc3ZGMndrK2xWL3k5aENjZU41cVl6MFRaVnQr?=
 =?utf-8?B?SXZtb0xQTmM5cXZEUGF1bFVjbFloY2t4WWFWZEtMZUdWeVFVU0pjYTQwZGY0?=
 =?utf-8?B?Umo4ZHBDWGR5WVlEK2JIc0MxWUkxOUVFUGU0ckY0UVJEQnNhU1BycVpGaDU5?=
 =?utf-8?B?RTVEUjk0RTFQYlVaelNxa21KRDJqUXpmelZNeUU0OHRSUDV5SmJZbGN5Qjlw?=
 =?utf-8?B?OFg4SDJOekdoakplV0ZQVjZHV2M2UFUvdThidDdrblNVTVFxVFJyVjMvNlpW?=
 =?utf-8?B?aXlvSHJuY05ldHRIRTZIUWVzQjNSU1paOC8vaEhuakRKS3l3VStjc1ViNUhy?=
 =?utf-8?B?Sjd0NTZSMW03MitYdHNrcGx1QTJWb1pZaE5yeHR5Qk1MVFZNR2RrTExOSHlp?=
 =?utf-8?B?YXNSMktLaDNrUDlEVHk2bWFYY2xFV3NNdG5CdnNEVjB6eUJSekp4TTdSbVBF?=
 =?utf-8?B?U2pCaHI3c1dINU1CYWJlN2xBNUNaQmh0M1pSdXV6c0lnSVlCQkFrQ25ZS0c2?=
 =?utf-8?B?ZWpsNGQrTUFmMnZKYkdqT1BzeXdaUjNWbzdtVHZiQS80anBvNGRoSGhvRE5u?=
 =?utf-8?B?YmF5ZVFNTDlTSm5zWFZIVnVpZENGMjZaemlOQWhzTlllNGdvY2xaTUdYV1E2?=
 =?utf-8?B?SGpzTnAvVWFrQWh1UWNuRHZyWXJURjV3UGdER1NzV01QYjdVaEs0bzNUMGF5?=
 =?utf-8?B?MlNIQUtGWnVTYlUxcitMaFY4cEMxM0xhYzFYK3pDd3BEeHlJTk54ZU00WHZF?=
 =?utf-8?B?NVloUmlzMVlTVEF1ZSs5WEZPdkh5bEVKQm5LZzJDNmFzZEdYV2R5VlR3Yk80?=
 =?utf-8?B?bGJIeXpVMG9objBBakM0RkcrcDloZm4waTVvWDZFQzVtU3R2c29LK0NOc1J3?=
 =?utf-8?B?WlhuMnpndk94T0taWnBiTmcxWWI3VmJDYmszVkRMZ1g3TGkreWdSOVBlYjJO?=
 =?utf-8?B?QkFtYmhBdHRjRi9ySXdmbXVXVzd6TldjTWdsYlN5RkJ4dVR5K2V3aXZWVit5?=
 =?utf-8?B?TXU1bG5WQnl5Y0xrTVBEOHNhVnJ5eGpDck52SlFGTmRvbVAwZlg5VEZoSVUw?=
 =?utf-8?B?QzI0OVJXRjFKOS95cW5Lbm52aXAzQWtJeEFuaU9TQjBNamhQd1NDRGJsVVlP?=
 =?utf-8?B?Z2FrMStBWXNNZWljQlpqbGlrV0FTS3dldUdYTk5BMmNmQ0JOZmNLdnptZjZL?=
 =?utf-8?B?KzBvK2V6a0hnVDRjaDF6blowcnNEcm14VTZTRzVKbE5yTjBqd041bCtOZnRv?=
 =?utf-8?B?Y3MyTHdoZ2Y2Nm1rTXpxdFNyK0JCVTZGWFhDQVFPc05DZGE0YWdlbGpaK0NZ?=
 =?utf-8?Q?TZTKHNYomakOmuPNWlWK8naQG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532d639c-8c4b-40cf-6d8b-08dba2587d6c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:08:34.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6AhFCJ69maQZTcPgk4ITuaAsne4m4UP2pjpnPpPuLiEYDqlZLQmEVJywuI1GX73fnLsEp0fZhmmYHG/76ik6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4874
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/21/2023 6:47 AM, Yue Haibing wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Commit fbfb8031533c ("ionic: Add hardware init and device commands")
> declared but never implemented ionic_q_rewind()/ionic_set_dma_mask().
> Commit 969f84394604 ("ionic: sync the filters in the work task")
> declared but never implemented ionic_rx_filters_need_sync().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic.h           | 1 -
>   drivers/net/ethernet/pensando/ionic/ionic_dev.h       | 1 -
>   drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h | 1 -
>   3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
> index 602f4d45d529..2453a40f6ee8 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic.h
> @@ -81,7 +81,6 @@ int ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_wait);
>   int ionic_dev_cmd_wait_nomsg(struct ionic *ionic, unsigned long max_wait);
>   void ionic_dev_cmd_dev_err_print(struct ionic *ionic, u8 opcode, u8 status,
>                                   int err);
> -int ionic_set_dma_mask(struct ionic *ionic);
>   int ionic_setup(struct ionic *ionic);
> 
>   int ionic_identify(struct ionic *ionic);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> index 0bea208bfba2..6aac98bcb9f4 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
> @@ -376,7 +376,6 @@ void ionic_q_cmb_map(struct ionic_queue *q, void __iomem *base, dma_addr_t base_
>   void ionic_q_sg_map(struct ionic_queue *q, void *base, dma_addr_t base_pa);
>   void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, ionic_desc_cb cb,
>                    void *cb_arg);
> -void ionic_q_rewind(struct ionic_queue *q, struct ionic_desc_info *start);
>   void ionic_q_service(struct ionic_queue *q, struct ionic_cq_info *cq_info,
>                       unsigned int stop_index);
>   int ionic_heartbeat_check(struct ionic *ionic);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
> index 87b2666f248b..ee9e99cd1b5e 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.h
> @@ -43,7 +43,6 @@ struct ionic_rx_filter *ionic_rx_filter_by_addr(struct ionic_lif *lif, const u8
>   struct ionic_rx_filter *ionic_rx_filter_rxsteer(struct ionic_lif *lif);
>   void ionic_rx_filter_sync(struct ionic_lif *lif);
>   int ionic_lif_list_addr(struct ionic_lif *lif, const u8 *addr, bool mode);
> -int ionic_rx_filters_need_sync(struct ionic_lif *lif);
>   int ionic_lif_vlan_add(struct ionic_lif *lif, const u16 vid);
>   int ionic_lif_vlan_del(struct ionic_lif *lif, const u16 vid);
> 
> --
> 2.34.1
> 

LGTM! Thanks for the cleanup.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

