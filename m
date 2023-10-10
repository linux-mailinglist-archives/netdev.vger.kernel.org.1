Return-Path: <netdev+bounces-39616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F37C0204
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1829281789
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE62FE2E;
	Tue, 10 Oct 2023 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zwu+c0Bd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A52FE04
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:53:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FF18E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEuPEZ33fSB8mpuxxgPG6HALWr+F14zCtAWbJbkTmf6Yq83aj7xOW9pt6l2gOplZ1vqzaZ9elWrppP09Uvad5OhW9n9gEVkfSn+4zjmGt8O1x6ctZyVBS8Wd1SneFwmeogpAhYCZpzDlGB9jn93DOWYftvZ4vBolTHvwbx+h/Vtn7BY84rKAjNTvh99/Rjfvd5ZswLNda4x4S1gUEXAYjdstXTAvsGKcWIgAhB/e4mj22n6ClWE8YOE/s5soUBNUJnV6TWOO3M66w9xEDLzYtMtSLHOdvOaXaPceJ7EykkT6Wdqfu+x8gcNnehJ9oJjqvwA54Kx5M3qGmibfOrWXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHqm8d8MZmRUzPVqYs2aH9pvlq+pTTmhwmErYc0gIpE=;
 b=mE5yMUaKSFjV/LvA1cNgc+M6GaEUZ8amiODg8tTySlpqPBtyNv+ckzsBlxrZQy9vosARs60EKfCUYlpvQoGzj7mDsn69sRRnF/daWgDjBlnTHWA5sdGVUkduhX1S/jvtnUo7bJlZRNx9YIYVONcVP7+oRWtV7NDC00Al+blMkRHBxdlk9R/Kxh4M7kl/08cPBAjJTKyhre9iBBygJJ2cbleE5MR89ilXLR+X7+klzgbggiIWZKAwsCH/e8EqI8kS3On45+pto5xb9MsjCU1mwrPcHcOyNiQomWWiOkNZ6POoffb4r4JCHLA1PRLcnZVaCbaBXOiIiYC4RP2TsnJHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHqm8d8MZmRUzPVqYs2aH9pvlq+pTTmhwmErYc0gIpE=;
 b=zwu+c0BdK0NZPHHvndqh5SxmW6fgDk8mlsO3MAYGZF6XsDiXJqZWzgdw17GGKR34S8zYB8MxVIfBEF1m4tiWibMr3m15xFa2Jj2au7RJbuxFsNEmo8JiNFfOCZvVL19mz9FPkowmyik9hjw7XqVGlY69xFtOdWzAGNf2rYoDW5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Tue, 10 Oct 2023 16:53:47 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e31c:de3c:af9d:cd2c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e31c:de3c:af9d:cd2c%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:53:46 +0000
Message-ID: <0bd5eb16-6670-4f3c-b193-f83807a25bd5@amd.com>
Date: Tue, 10 Oct 2023 09:53:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 3/8] pds_core: devlink health: use retained
 error fmsg API
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Michael Chan <michael.chan@broadcom.com>,
 Edwin Peer <edwin.peer@broadcom.com>, Cai Huoqing <cai.huoqing@linux.dev>,
 Luo bin <luobin9@huawei.com>, George Cherian <george.cherian@marvell.com>,
 Danielle Ratson <danieller@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>
Cc: Brett Creeley <brett.creeley@amd.com>,
 Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin <ayal@mellanox.com>,
 Leon Romanovsky <leon@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20231010104318.3571791-1-przemyslaw.kitszel@intel.com>
 <20231010104318.3571791-4-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231010104318.3571791-4-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:510:23d::13) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 301621f5-3e2b-4c92-0dda-08dbc9b1781a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5/fu5iUW+zcB+qMiiYquRT7DfEP+PA48hvmhPF8zMCNX2fMDET0YPXsUeKJpTaKtQzmnWZvz3miCXzfGqj65q/qLYGJnpTNAsyOhQEONJCqTWglEH+dTr+oiltS6re2RkMR7ivDss7LRRcC1oE9KKkYCofGvWzTHQdGNoJsS1lyWLocQeYKo95HqDsQU9uXy/dIPOEZH5Z8cVT7wrTs3jYeZp8j7Dafq05TjdycUCr/1DGpqVZrqKSqyY3sB3gADxDvwjC8wo8D+Dn4oR8GmaSCIwixDFOa/DVyMmHl4IiWv+FpVecl+cZe+mjutGOZX/GeyHrFojpUlotDvHEL8UT8x23dDrffT/zSQ+SdVTeu0+MPRhD2kj397Pp3XLeXWp+LP3hKdwk0htM1emUC+qlWIOCX04cvm5urT1fSixLT65Ew7CVt7e5/GR8M4Sbs3M+lbIWjkuW+sBEqRF85rookBnlcTn+ySaG51y7Cgi8pGPg0bprZnHnjPbiJ/mjuohdx5YppHO70+M2rDCtB0KDddksKxtAtNAeduIThTQm3pNa2oatk7YSWSVU9upV5O14TXnbN56ZOZUoJ0P2yAB9NdJY6uU3vvkSTkx60jMus4jBFa3r2fnPIw8DK4bXIpRXFIUH+OETltM5m2z1+IErNGHshuXdmxL6MsRR8JhL0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(6506007)(2616005)(53546011)(6666004)(6512007)(921005)(38100700002)(86362001)(31696002)(36756003)(316002)(83380400001)(2906002)(7416002)(6486002)(41300700001)(478600001)(8676002)(4326008)(66946007)(8936002)(26005)(66556008)(5660300002)(110136005)(66476007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjdSSUtIc0dUcHhRTjRYN2hrZUhHWGg0Ukx3WC9NNmM5QWtSNjhLbjJ3bmRr?=
 =?utf-8?B?b1BTTDlZcGhDZjdpT1BCeStESmN0emo1ZjZDbGFpRkFIbVRTeXZ6YlJCdTBY?=
 =?utf-8?B?NG5GNzFJZkxvUDdENEJweHYzd0tWVmh2STNFYko1QlR2cmlDL212N0xIbm1n?=
 =?utf-8?B?SnV2QTZ0cmI3L3lGZ291ZnJKV0pqbUF0SVlKSGFtZUlGclQyNDljTWZCUGpl?=
 =?utf-8?B?bEdsNHZyOC9FS01jdm5JbEt2OWFGVHhrc1NnUjdCallYaW04aUgyZXhRYXg4?=
 =?utf-8?B?dW9jUG9lb1NiY241VmpvRWpxeVJSL1ZnUDJSZXB5Y1AyR2k5SG96M21HVXh4?=
 =?utf-8?B?OFNXNXRzOW5NQldyWGxBTjhRYmxTamFpVHMzQlF3dHBybysxWXBRVGhXK3Rt?=
 =?utf-8?B?S0VkQ0xLV01jUHpURGtmNzkvTllaUGhJTVRUYXZCcnZSMTBKbDk4dTAzOU00?=
 =?utf-8?B?OUNSOHByRndsdkVhSGd6WlZMZHI0OEJjZzlUWThTNmprck9JcXR3REVMNUhj?=
 =?utf-8?B?ejVTSk9SVWlnZ1B2KzlYcWdESHFQMDZJSGpFd0tOcFU0Y251TzNRVUh0VTI1?=
 =?utf-8?B?aTZPMjJ3T05JNU1BcDk2Q2VVUy92RFRacXhrRkZjNHdsUzVTNEN1MTUremhU?=
 =?utf-8?B?NlpwTDNGTE05cmZudmFvdzZBTTZGMktRK3IvTXJyOCt2R1QrVkhzelFoSS81?=
 =?utf-8?B?a2JzR1JGMStBR3ExbWQzYy83czFScmZyVUFhK29vQy9lcVRveXZ2WG44U3Zo?=
 =?utf-8?B?MzRyS2wzZnZMMlM4Z2w1V2VJb0JYRlh0QUZsSmFkZlk5MWVNeXdQZHVxcGRM?=
 =?utf-8?B?MFZhalVNWXMxN3NNNm41bWJuUDJ6ZGJ2MmpjU1B2WWFpVlpmeUQ1Ync5NmRy?=
 =?utf-8?B?dEZJUVVMMGVjQjlFSEltNnVsOHI4YXByamw4V05OU3AwYUZLaEw4SFNyY3V1?=
 =?utf-8?B?a2VlUEk3b05KNkZrYi9tYXJFTXRPL0ZoNk1DSVUrUXBRVll6bmNkNVczM0xJ?=
 =?utf-8?B?UFJUQ285Q1FkQmQ2UDZNUUJuUU1tTmZrMDdXMjM5MUJYci9TNFRWS2NtR1pL?=
 =?utf-8?B?SEZzZkI5NG91V1BDOGNUNVhBZFloN2FrQ0FvQ1E1ck1ZcFFJejhwbHUvTldI?=
 =?utf-8?B?aVlIY2N0UFY0OUlRWGVGS3JjOGlDV3JDcEdBZnViWXlRYjhLbmpabitFSCtp?=
 =?utf-8?B?L0hhOC9lSDJPS1BTWTJhRUhkczN1b1NPMS9yVnhRYmRSNVoyL3BLVVVsRlRq?=
 =?utf-8?B?b1NRUlV5UHB0YTZpVzJRbUlGekMxZXlYcGovUUZCdTNKQVVraktQOEUwQnNm?=
 =?utf-8?B?c3ZoT0ZOUjhHa2g0ZVVoN3RlM3NVQkhCSStxT2ZVM253WXRsVlZ6UFVwbk1B?=
 =?utf-8?B?VndnSkpoVHBHbFF1alFHS1NSUEppQWxSRHpuVmtyT3JETnpkNGt3V2FqOWpB?=
 =?utf-8?B?K2ZOTytQSlZ2Sm5CL3lqUGpyV3Z6M0ZscjlETWpjN1VaUllsL1dHeVBiTHhM?=
 =?utf-8?B?TGpBREtJQ0JSNnBLK0xvSk5nSXJnM2EramphY2hkdmdrTXRiOURVK0lpT2RC?=
 =?utf-8?B?alplRXhyTVZVR2FhNGd5emlmdWQwRFB1UFFpSi9UdHg5Z3FsdE9oejZ5aWtW?=
 =?utf-8?B?aUZYZjEzTVlBcmJTWW5aaGZmMEgwKytLVVlYaUZCd1R2UXdYZ2srYlBMMFdI?=
 =?utf-8?B?N2c3SFN4cjExYjNvdnk2cnU3MXZSSlVUUUM0aWdQaE9mREtveHdXL1VrSG5B?=
 =?utf-8?B?VVJpVE1wWlFGajQzakwwQnpxMkR5akVDT1E1cEt0MXFRRG0rU25oemVsQW5D?=
 =?utf-8?B?NTFNOTE2YUQxT3pmVWZpbU1hQUZUZC9JVk5HZjIvWWl6N2NuMmJDb0x6dGVQ?=
 =?utf-8?B?dVVHUFR6NkVucEFTamQ2MVozbXVKa2JjSVBwelBzbHFXRHp3UWpWY2R0ZW1U?=
 =?utf-8?B?cFBUbXpVaER0aVg1bmM1emZhQWZaazc3Vld3ZFpTZW1ick83bkJWVVNxSzlt?=
 =?utf-8?B?NkVaaXh5aUxyQlNNZjJWVmtHZ2ZPTmFwWC9Fby9aOFhoM01xNzV5dUFiSkVV?=
 =?utf-8?B?MUZadWFQa011NU9la0JSRkhjY2hlcEFzYXlNaUkwZGJvaWIzdXRUV2RsVHBB?=
 =?utf-8?Q?v9yuwB8mJP7YZNsGRQcss59j+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301621f5-3e2b-4c92-0dda-08dbc9b1781a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:53:46.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eWV1YZQBqaz4IV6uBTzTVJWUK/0O50+R1GMhvhBthuFfJ1qgpGlfkCep9NC5o3d/a9CNsWjeeq1m/Fp+9W2/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/2023 3:43 AM, Przemek Kitszel wrote:
> 
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-57 (-57)
> ---
>   drivers/net/ethernet/amd/pds_core/devlink.c | 27 ++++++---------------
>   1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
> index d9607033bbf2..fcb407bdb25e 100644
> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
> @@ -154,33 +154,20 @@ int pdsc_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
>                                struct netlink_ext_ack *extack)
>   {
>          struct pdsc *pdsc = devlink_health_reporter_priv(reporter);
> -       int err;
> 
>          mutex_lock(&pdsc->config_lock);
> -
>          if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
> -               err = devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
> +               devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
>          else if (!pdsc_is_fw_good(pdsc))
> -               err = devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
> +               devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
>          else
> -               err = devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
> -
> +               devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
>          mutex_unlock(&pdsc->config_lock);
> 
> -       if (err)
> -               return err;
> -
> -       err = devlink_fmsg_u32_pair_put(fmsg, "State",
> -                                       pdsc->fw_status &
> -                                               ~PDS_CORE_FW_STS_F_GENERATION);
> -       if (err)
> -               return err;
> -
> -       err = devlink_fmsg_u32_pair_put(fmsg, "Generation",
> -                                       pdsc->fw_generation >> 4);
> -       if (err)
> -               return err;
> -
> +       devlink_fmsg_u32_pair_put(fmsg, "State",
> +                                 pdsc->fw_status & ~PDS_CORE_FW_STS_F_GENERATION);
> +       devlink_fmsg_u32_pair_put(fmsg, "Generation", pdsc->fw_generation >> 4);
>          return devlink_fmsg_u32_pair_put(fmsg, "Recoveries",
>                                           pdsc->fw_recoveries);
> +

Please don't add an extra blank line here.

>   }

Generally, I like this cleanup.  I did have a similar question about 
return values as Jiri's comment - how would this do with some code 
checkers that might complain about ignoring all those return values?

Going to full void functions would fix that.  You can add some temporary 
"scaffolding" code, an intermediate layer to help in the driver 
conversion, which would then get removed at the end once all the drivers 
are converted.

This do_something/check_error/do_something/check_err pattern happens in 
other APIs in the kernel - see the devlink_info_* APIs, for example: do 
you foresee changing other interfaces in a similar way?

sln

> --
> 2.40.1
> 

