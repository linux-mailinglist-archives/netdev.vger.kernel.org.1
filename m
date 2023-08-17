Return-Path: <netdev+bounces-28523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E600877FB48
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA302820D1
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF6915AD8;
	Thu, 17 Aug 2023 15:55:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66814011
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:55:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFFC30E9
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTu4ysZgdMN5UwfG8FrhmoSRREJpgNSWR2cUV4Iyd8Ji8eOLAu87eWLsUSit2lsFh2zPI3m4x41iWcXhdQON4OvyGFzGW9WwT1DK77oUUWmxGLpAjS1E1FUtlVTtC7iGQRAiM4i6+O5+AoKTc03OdW6DTtlYSpmueTLGB823CnwmS7LH/iQRbO9DsaN7ZdYY+hGGt3DEmD9fhLd2s3tz0NiCDglpBuVQhQGg28MnNwmG9WPj45C/xb1VkR10IlDI9G2hLDTlkE2zDEOtpqiX3fDc2LR2kf74lYtOgPSlKoZ3x/GTzRgQtfCs9uoU25LSdhLLRR1fYq4EAT1ppiRRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWTao+kKrvy79XAaNhcfwkNu5LolfEgY3bT5KYReErI=;
 b=WMH7VY724Md4B9oFusa06vRbGp8q4Y8ebZ0lzCUoTgQTdjeO13ZWebXrl01Km3spdj1uas2NX/z+q7dxTEVhZJgxFzBNefK4wZVIcErhH8Nz6UjXCxzSDSHtL0w7Fl/03ljOVQkx5jz35yYG6U/qUXtDrXUN2Uas2lMba9qMJSg/Gv4uWXKe2WBBXpFJZbnEx4LZPy/DPyFxi0X1h65yPJbRt/EtbX2bwyNgdJxKRe9faLONqP6I3a/yIHDWMMHJhw8lAGZt2ZW/9q/4Rcdhh6AL6WkvRJnNRuP9qbO14W5hk6DJTNJvI0qyLg/uoFjVPChwLm5mTb17K06JBO2Iqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWTao+kKrvy79XAaNhcfwkNu5LolfEgY3bT5KYReErI=;
 b=WIR34/t/mJ017C2Vzy1nIFYW0b1f+h1WiYVLL8Ba0HAcER/OKKICBTaD+SWcCJr715GVxsVNVfsrgRARVLUhzm6rWbMZAtNmcLa2/4f0AaFvsIVreza1E8jti8TTqBx2kulWrLLf/KxFfscpH6llUfVmFTPFYrWWV+2kutH+YDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 15:55:25 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:55:25 +0000
Message-ID: <f85a351b-e86b-4d08-9a9d-3fdf24961f66@amd.com>
Date: Thu, 17 Aug 2023 08:55:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] pds_core: remove redundant pci_clear_master()
To: Yu Liao <liaoyu15@huawei.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, leon@kernel.org
Cc: liwei391@huawei.com
References: <20230817025709.2023553-1-liaoyu15@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20230817025709.2023553-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: aa217be5-8481-4470-81ae-08db9f3a5ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3+p6Inpi516LQoijIf+UMOzrMw4yvPTj87bEgoJrAs114I9M3bE6P7PAqQhxRrTbbxgGNRhWEdc88A6hZwE0Hyv7br7v2X7UkBKBEYNzI6+7sz54kzANAPwa9fWxZy9Rcyaygl0c8RqpjykBn9/Oo44bQVweCAxYrXWvX3oMk/yEND5bwe3X515vWqirhIbg5Vh6dMTESExQgNbQTyGjHXc3A37JnAEveN5itLTys5woIVu13KsOiCWKxdVBPQw4e1Qk68TdQIecJ+EyOgmmG1mgq0tfsDNkVYbWUWudQ9lXZ9+nKV1noQIA0JT8YsM7Bd64lNw1dY6WMcTkbm8+feEJ8l1knL9vMWiT3ykJPRuyIS+V+lbIPHwiOyUSGEps6Kh33SCDloEbACIHy9xq68TgKbsBGZ1M2W/2J3mW2T5KH06FfLjk1DM0MlvInDFRcCKAUK4JmAIU5eUtOr3G5YmPZsoHfhVJfN+CEweBvE3jEcOD6uA5cE1hb5LeM5XagYgp2meGHJn0qoMoIpxdGeU/0X/67OizelAOOA5Hodv3ZvtxWQ+chUB9sh7M0wmb5J8m1lcfGW4jB2YcHyb03l575up1ZF9ic1v/vdJrzxr5iOzA7XuFI6/gAfken55Ih523I1doVLEoGqKH6dkB8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199024)(186009)(1800799009)(316002)(66946007)(66476007)(66556008)(31686004)(5660300002)(41300700001)(38100700002)(8676002)(8936002)(4326008)(26005)(2906002)(31696002)(83380400001)(478600001)(86362001)(53546011)(6512007)(6666004)(36756003)(6506007)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajR4VDdpM1oyTk54Y1kxMGZ4eGJnNlFqZHRVOXV1ZlFDSmd4Q0VoalhBRlpu?=
 =?utf-8?B?YytoN2pTQWdiTXVFc29TQUpHYzlkUGRkN1NGbXFpYWo2THIxamlBb3h6RSsy?=
 =?utf-8?B?OGh1QUlCY0FXOFUxa1ZMODZMNjBuditYcXFJdk5kWHNUK1UxYlNvUkJsYlJ5?=
 =?utf-8?B?MnpDc2FhT3lXcURkUVQ0UHdTOEl1UVpDZUc2Y0ZleFRKWnVMZjRvc0tid3hs?=
 =?utf-8?B?QTh1UG1IQkgxdnNVNG9OLzRKRllIVE5rMW1uV1Ftdm91SFdXeGgzTytyeEth?=
 =?utf-8?B?aWlpTEdPZUxwZ0kzMjgxOStrWUV2ZE5zUXd3dFVRV3lHVnpoTVZJOEdyemJ6?=
 =?utf-8?B?RzBmczZJRHFyMEtnczZxaWNaUGM2bFpUY0ZNRFZ4OG85TUl2ZGQ2RncyUHEv?=
 =?utf-8?B?akRPSUs0VEhtNGgyRE8vMnRCdTZRcGtuYkdES01NcWpDRzFyekhKMWtIbFc1?=
 =?utf-8?B?bzdBU3VMRWg2RjRJWVhWbC9GT1NMRHB5bEorZERsTlQveGdLVDB1a0FCcHBU?=
 =?utf-8?B?NEtxQVY5OWw1ekUzMkZRTlFHVytyaHdSVlN1ZXAxbzFDREplWUpTMGhtQTF2?=
 =?utf-8?B?T25lNUczbFNiSGpVODZNRjF0SmVxSkp1aWpNWlFXT1dkeVdTN2w1TFl3OEpL?=
 =?utf-8?B?Y0NkWWxjMVJ0Wk5aUUg0MWhSVFFpaEtwb0k1bEJNZ1o3ZnJYdks4QWp6eEhO?=
 =?utf-8?B?RDJGT2hMKytlbDlJK0FCNStqMFdnbXR4ajVmY2ZzUXRMVHlvOU96Mk15OXhu?=
 =?utf-8?B?YUhTSkQ0eGZnSldBR25vaUlIcEExOWJFbEpNemNJeFdPNTJaQ29KdW90a2lm?=
 =?utf-8?B?OWFIdm5uTGZVSDJPajNwUXRHVXlJanAxYTFkVDFVUDc3YTE0MGY0UGFZV29T?=
 =?utf-8?B?SWtJWjd3RWY0R3Q0eitjVVkzOE9LdHdpUklrTWpYN21UY2hEdDE0U0pweHhK?=
 =?utf-8?B?Z3VKS3ZGUHJiTkwxc0djV3k5UlZ1amxFTjY2RjlGT0hZT2ljcEU4WmJaTkJh?=
 =?utf-8?B?V0lTcHNsUjJOd29TdlZUZytlc2pWcFJ3NWxsUE10NzhadmRTa1FkNjg0M3dz?=
 =?utf-8?B?U3JVM2NJVEYvU0ExWHRVZ0M4MFY0c2Rtcm5VSFFPdTdpVmNPOXYwazZhQkFa?=
 =?utf-8?B?dVRHQTFGTXRtRDdUVUlxZWduUDIxUUN3YVBxT0k1Qkt2WGRlMHhBOVBXT1Zw?=
 =?utf-8?B?aGZHUFlpYzBrU2pSRUs5c01mb1hoRHdwK1lDUENNdnFDYnZUU09rOGN1QVFK?=
 =?utf-8?B?MjRJcDg1Tk5rVERMdFl5TXdRbHJNRG9RWEdSMnRKZHUxRlhaUVdrVG1BbGZO?=
 =?utf-8?B?aEdHOHdXeVlaUVJUczZIcC9pMWI4V0J6ZHQwUitBMW9JRGU5UkZTV3ErUDg2?=
 =?utf-8?B?eUtwL053OVRDN1dSakNCaVUyMGF5dnZSeEUrVnRDVHcvTTNXYTNTS2RYT2Rl?=
 =?utf-8?B?Z2VlMHR0Zk10YjgwRFhjVXdwN1VHRmJ4cGZzTjNTTVpRTVF6MGlzUlF4QWhy?=
 =?utf-8?B?NHYvWFAwS1dQRzRza0lzUUxwL2h3UnVsY21Ic3lKOHIwN0tqaFVjWmtlUk9Y?=
 =?utf-8?B?Ny9LQ21yR2tjbmdueCtzQ2RrVFlJbS84MEMxeGVRbU5qVE5EZGxuanNTMU9n?=
 =?utf-8?B?aHBNbnRJYUdtOHBKWTZzVDhYV0g3R0tHWDNRZHQ3cVg0R3hiaVRFMFpuVFh2?=
 =?utf-8?B?V1lSMW94N0JNb01yaUZUdVluMmNOT3lUc2pFbTNsamJSdHMzaXVZZG8wQ3dn?=
 =?utf-8?B?STdDeld0MUtSZlVZRzV3bDZHaDNoV1hxY2RLdklucTZlK2xzUzN1N1dYdGlC?=
 =?utf-8?B?b3B2aHhVSndpTDYxVU4razk3TFlYVTFGYkpjT3hpcU85TWxDUjNwUzNlclRI?=
 =?utf-8?B?blVTSWFhdU5yRkFSRkRYd0Q5S3U4YnEzWE1acWtpSHRLenUvT0M4THBIMFYw?=
 =?utf-8?B?SzhJUU5vdVkrV1pwTEo1MGp0S0FNSU83Q2oydTAzazRFaFJiNi9ZWDljQkJF?=
 =?utf-8?B?MytUaFo5UnFMczJiZng1dXFiMTN4SFZvTFdRUDRmeUhhalZiNWpMSHpVdG95?=
 =?utf-8?B?UGd1MUR1cENMdEg1c1QvbGdvcS9oc3NXVE1Gb1VjR3pGOGVmaE5tSjhiSVRx?=
 =?utf-8?Q?WP9P0/as5iOMvPHE7XMPXJE6U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa217be5-8481-4470-81ae-08db9f3a5ec4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:55:25.2068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zmz2YKZbfTWjxRdkYSSNApxTIRww+Rl5gOab8ebUi0WWG6NiUdd3vmFYsYx+MbcXqD0zFyLqYuFdd0fzq8xQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/16/2023 7:57 PM, Yu Liao wrote:
> 
> do_pci_disable_device() disable PCI bus-mastering as following:
> static void do_pci_disable_device(struct pci_dev *dev)
> {
>                  u16 pci_command;
> 
>                  pci_read_config_word(dev, PCI_COMMAND, &pci_command);
>                  if (pci_command & PCI_COMMAND_MASTER) {
>                                  pci_command &= ~PCI_COMMAND_MASTER;
>                                  pci_write_config_word(dev, PCI_COMMAND, pci_command);
>                  }
> 
>                  pcibios_disable_device(dev);
> }
> And pci_disable_device() sets dev->is_busmaster to 0.
> 
> pci_enable_device() is called only once before calling to
> pci_disable_device() and such pci_clear_master() is not needed. So remove
> redundant pci_clear_master().
> 
> Also rename goto label 'err_out_clear_master' to 'err_out_disable_device'.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

Acked-by: Shannon Nelson <shannon.nelson@amd.com>


> ---
> v1 -> v2:
> - add explanation why pci_disable_device() disables PCI bus-mastering
> - rename goto label 'err_out_clear_master' to 'err_out_disable_device'
> ---
>   drivers/net/ethernet/amd/pds_core/main.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 672757932246..3a45bf474a19 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -367,14 +367,13 @@ static int pdsc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>                  err = pdsc_init_vf(pdsc);
>          if (err) {
>                  dev_err(dev, "Cannot init device: %pe\n", ERR_PTR(err));
> -               goto err_out_clear_master;
> +               goto err_out_disable_device;
>          }
> 
>          clear_bit(PDSC_S_INITING_DRIVER, &pdsc->state);
>          return 0;
> 
> -err_out_clear_master:
> -       pci_clear_master(pdev);
> +err_out_disable_device:
>          pci_disable_device(pdev);
>   err_out_free_ida:
>          ida_free(&pdsc_ida, pdsc->uid);
> @@ -439,7 +438,6 @@ static void pdsc_remove(struct pci_dev *pdev)
>                  pci_release_regions(pdev);
>          }
> 
> -       pci_clear_master(pdev);
>          pci_disable_device(pdev);
> 
>          ida_free(&pdsc_ida, pdsc->uid);
> --
> 2.25.1
> 

