Return-Path: <netdev+bounces-32490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41872797EEA
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 01:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6732817AD
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 23:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A614296;
	Thu,  7 Sep 2023 23:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81614294
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 23:02:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBED3CF3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 16:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zokx/VU556Zti0FdPDI+Ktg4KKi/hznrzlHrDo06oW8LX/7ZfmOBJnXCsapLuYb9b36EfsqYwRRTet2kgxoS90Zzl3zDEo0civNZf2QFy5kdCId2VHSjE/sMbJjzpAo5KVWN+dti+ZbUU5/wEOwCP1FpuIU8Pq3ZdMm9CAxwasoHnrJ419FZRG25jM+ARnJuZcbIj/TrvS55OHTks76p4Vvz0xdAlroOOkeCGzTz2dhJ8Yc0gehGvqXHxcja3L+fwlwpcXg1A2hV4xzSnsaRMHtOz8Q0C4UJSdwTUGn6+oKiodjSbMuYuQiIJ9EUk+dYAU69v8Gh8vgi8TnUBDgawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nJqGfjaSFm/kmP5MlA7Y1xw8FqIycMk7c8sSa9vw88=;
 b=DgTKv6XRi6rKQZkBZ4FvBQAVUdwq6lcSZoqhTlblNmeR5zPphONes4h8+Zocmua/sTo/3WLAtW4AgZagyRUgHtkMaaRVdhs8WueNWAxelPkQ7El1uj0YPYV08sLmey1wdthx0yxq5h65DE/O+Czc47G3BlTKLbVv13SkYuf2fYOWum26gB7UZQ7sdhUXudhMek65bQ/oZwyE276Sr8c85M5OIXoxiuKgJQ7TIUPlnr3mcq/uw4skKlNUD7OacjTXryWMV+emIRfm4UbRPHl7E7dXFodNFvwzrmooP1W4Istn1o53BS4lbyuVY/UCfGWjKmPEzFWWcMBgCa1SRY6ARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nJqGfjaSFm/kmP5MlA7Y1xw8FqIycMk7c8sSa9vw88=;
 b=Lwk13P6myPc0WildK8oWWT6NNCQrgMKWQBhClFVjFesImyOgKFP3RxeHopVl4RXrbUEBiNcQ1YKmxthuXTIPfDc/Rc2i2EboPFuYK3TvdHBL7/MVG1Uhz05KI9y9Roy/k61IJA14NQHX68fba36uB73JkyDocbp2e2NNSumwHXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Thu, 7 Sep 2023 23:02:06 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 23:02:06 +0000
Message-ID: <71c187a5-337c-46e9-8d88-35d288795fc8@amd.com>
Date: Thu, 7 Sep 2023 16:02:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: consume device_features parameter
To: Si-Wei Liu <si-wei.liu@oracle.com>, dsahern@kernel.org,
 stephen@networkplumber.org
Cc: allen.hubbe@amd.com, drivers@pensando.io, jasowang@redhat.com,
 mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org
References: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
 <b4eeb1b9-1e65-3ef5-1a19-ecd0b14d29e9@oracle.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <b4eeb1b9-1e65-3ef5-1a19-ecd0b14d29e9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: bee4d1ed-43c4-4eb0-75bc-08dbaff674ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4dW24+3jv43Ggwc0AiY5MHGVsMBt6yt8ikI5vfW4IN7gTcQ//pB1phVlI7zCr6B8xC8kCghT36HzFQ4Rsth5bl3YxkuSp+pcWwbrKaHodSGPQKPet/+X+oUpnv9sW7CA0rt0AmS+p2dFyoVyIGhKB4R6BOJZ4LOMpoh+c0MBFlRXJnAPJ/ONQU/O9bcZQ0oYjNWl70vh7H9Z0uZpt0ezm4s4sTLm+14xZ/ZzErEZFLfie8kgdnxCCU/VefFWmwEtKIFJVl3bCRs+9lW0NNS7IKUl1Eo6WeqxlreSEDwKbUx+sbjG10kqnuLmO5ZPvTOL0695vxLHHDkOvOuini73GtKUCNst7t06t7FvN5TvnKRDR20cL4VikEdEwxv/vm1Y2atYdsZVWT+rV8JzIqxPQaAX6HOtNGBhGWKs6UPC/03n9LT97w9mrdX+KBRsT82WjTQOoQkvm6dndwOwV+53R6/uzRuA29p+1XQMgw0hfvF055LPf8mxbgj2w6nSJaputq/RjILKvOnh1o+EDvs9k+2AdB7B9KNUKpr/xfIpX3xyTJgP4Tm81/q9QQcLIRPI+485RlimdyfgwrQX2QJg2tPwHiSYOTsQaylJalUDsnYbzTJl/TxGFmyRTMFyitd/XU0FplSHvYsFm1U5Gr7Npg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(186009)(1800799009)(451199024)(6486002)(6506007)(53546011)(966005)(478600001)(2616005)(26005)(2906002)(66946007)(316002)(41300700001)(66556008)(66476007)(8936002)(5660300002)(4326008)(8676002)(6512007)(31696002)(36756003)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnhaOFJBaTlsZHV0KzBGS3orNmkrSnFXTkIyT1M5d3VyVXZ5aVk1UkxmZjBj?=
 =?utf-8?B?RDVIcEFKT0swWWRrYUp2RnUwSkNWNWJJeDZ4bmtlR0oxdHdOYWI1WC9McHY1?=
 =?utf-8?B?RmtjLzhqUFpZc3lvSUZOQWg0am9BVE5SS0Qzd01memxkaXY1dWlUeTBPaEdx?=
 =?utf-8?B?ZG5aRGtLMGRGTjNyd2ZyWG10LzczMlNOakg0a2QzZGhURXNRT3hONGxOLzIy?=
 =?utf-8?B?WC9Ka0ZrUmR2WmR6dUhhQWxXVVpZbm9tZWE3elFTdVJqS0RuTmlzYW0zNVNt?=
 =?utf-8?B?UlZ1S0FhdnBYb0IrMnY1QXpYQVZOQUpOUzk3aFN0SDBXbVlwb2pEdENTVFU4?=
 =?utf-8?B?WFk3dnBPZWtqaGM3UnpocUNxaDNsa3p2S3lranhGa1JCWUVCbG1wbmJwb3Bl?=
 =?utf-8?B?eWlTTFk5SExzd3NOa0p3OGpKZ1ovdGdCNmtlb2tQcVFPSWxhZkE0aTNIUGlB?=
 =?utf-8?B?ek1XTFhXMTc2VXdHRzVqQWpYbktzRVk0Mk9wbitqaHV6cW1wTlBqbTRXVldJ?=
 =?utf-8?B?LzNqbW9tUjF0VkJ3bXVNUzFTZjBOb3dtYk1ZRXM4NWNlVXZvU3F4KzAwcnZK?=
 =?utf-8?B?NVZwQzNadHRmb2xneUo3c1BXQ0JBci92WWNGU2tZUkJYaG9YY0U2ODgraUpG?=
 =?utf-8?B?Nk5qK2RpUVNTb1hDVUJpb2J6OVY0dGE4ZVhGaHFmVFZyWWZna09jTVZQWTEz?=
 =?utf-8?B?MmNuQlJHaG5yM3VmVk43aXk3NUk4MWcwNkZIWktwaUFKbFlZK1pmSnlOd1ZU?=
 =?utf-8?B?L2Z5d3Bpb01MeUZqdjRGc0FWY3Z0dmdQWCtoQTZzVHU2THlJNzhEeWUzYk9W?=
 =?utf-8?B?ODhhRnNtMGV2aXRrdEVrcEJ6aW43VmZPVlhTRFdlbFJOaUdpb3M5NGJ5R1pT?=
 =?utf-8?B?L0pCNnUwRW5DR2w4bHpFTlM4cXptcWpiMGhRc1FaTVRmVk1vcDIyNWdHWE8v?=
 =?utf-8?B?RVNpVlcwN2lwUnJuUFRGQkpxMEJLWlhmNTBjaXNuanpaSjF5WWxHNzErazNY?=
 =?utf-8?B?OFNoVk5ZeExsSXdxc0lGZDdkYXhTQ3dOdk8zdDI5dzFYNTdSV3NraktydlpH?=
 =?utf-8?B?cm1lU3dXWHIxbG9YcVVtNEpxSTU4U3ZNL3RpQnFNUDh5ZzgzS1d1RzJwbjd3?=
 =?utf-8?B?dndBNkNuY25iRXNoY3NzQWFETVZJVGpkb2Erd0M5YmF1d0tocmJqcmFsTnlL?=
 =?utf-8?B?WGlESm1EZW9LT21kTkxKSTN2d3VCK0lNMmZVcmtoazJLQ3FYUlE0cGptNndJ?=
 =?utf-8?B?SGJ1c1BQVHJ6Q2RkajZkTnNXUDkwcnEvbWdnQzFRdUg3Q3ZydE5VWGtSMVNt?=
 =?utf-8?B?cys0dEp2TFNxbzlOSTloQ095TVM5SVpIT3ppanRsejF1TStvSVpnR0JDc2tX?=
 =?utf-8?B?cFJqZUVJd0tDV1hST09keVp3L1RtNU5SMXRrOTlOVlMrQ1R6cUc1VWpEeVUr?=
 =?utf-8?B?S1F6aXU3SG9OQU5MekdFTFFNc3B6blB2Y1F2QnFjWXhYOTNsclYwNDFFRkQ2?=
 =?utf-8?B?MFdURDlkZE4vL25ZNFZpSXdvNXplSkZuMlJnVDdKRXBHVEZ3Vm5sWEV6b1pi?=
 =?utf-8?B?TkRDTm1uWnpXMW1iTU5hZ2xwTWVyUm5qUHRjZVhGSTVYaEc3UnJwUjVsNndC?=
 =?utf-8?B?RS9BM0VIb0tXUEczWHBXN1RmQVphenlvZHZvVGlNSXRaaDRFN3RjWlJZYWZ5?=
 =?utf-8?B?VFVUR0tUcWM3TG1qdmNubEVTV1RXcEpvZ2NkMWpKWGx3a3BkWFl6OURIVG42?=
 =?utf-8?B?aW9qQ3VpYXJ6aE15YmZyWjVsTkRBT1p0SUFKKzlOdk16UlN3VzhhVDZMcjRC?=
 =?utf-8?B?RDk0bVFxREhjQmdYcE91a2xkS3k5dUwrR09KUkJyWDRoL2lxb0VoWkY0emht?=
 =?utf-8?B?SHRqeFdHVUdJOGV0S0poUnBWaWtaSlp5ZzV5YmZxbUtKbVdIVmtJbWtWTXZN?=
 =?utf-8?B?MmhWWkw5OGZoMWROcHFCNUtQUVRQNzdodEw4ekhCV1VpWlNUVUVscE91TlBO?=
 =?utf-8?B?YjBJcldILy9TM2czUlVFeVFRMG1Xam55K0Y1RFNsb01YYWx4OFVRTnAvTmZP?=
 =?utf-8?B?SjJYZjMrNzEra21aVURYYlE4VVIxdmozdzdHbWZDZ1VuZmxMSlRFMEhZeFVM?=
 =?utf-8?Q?Bi05LR0PQHtjzJy9cI27uTNkO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee4d1ed-43c4-4eb0-75bc-08dbaff674ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 23:02:06.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQqZxwyVLwLwVCn8PJnfrchfgqx0QOwiMqGGDqiN8+i4S/1pOfhzzICWoht3W98hZttmOFgThPbvtXArGHHhGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/7/2023 1:41 PM, Si-Wei Liu wrote:
> 
> Hi David,
> 
> Why this patch doesn't get picked in the last 4 months? Maybe the
> subject is not clear, but this is an iproute2 patch. Would it be
> possible to merge at your earliest convenience?
> 
> PS, adding my R-b to the patch.

Maybe I aimed this at the wrong person?  I see that Stephen just 
announced the latest iproute2
https://lore.kernel.org/netdev/20230906093918.394a1b1d@hermes.local/

I probably also should have made sure that "iproute2" was in the subject 
prefix.

Hi Stephen, perhaps you can help with this?

Thanks,
sln


> 
> Thanks,
> -Siwei
> 
> 
> On Sat, May 13, 2023 at 12:42 AM Shannon Nelson <shannon.nelson@amd.com>
> wrote:
>  >
>  > From: Allen Hubbe <allen.hubbe@amd.com>
>  >
>  > Consume the parameter to device_features when parsing command line
>  > options.  Otherwise the parameter may be used again as an option name.
>  >
>  >  # vdpa dev add ... device_features 0xdeadbeef mac 00:11:22:33:44:55
>  >  Unknown option "0xdeadbeef"
>  >
>  > Fixes: a4442ce58ebb ("vdpa: allow provisioning device features")
>  > Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>  > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> 
>  > ---
>  >  vdpa/vdpa.c | 2 ++
>  >  1 file changed, 2 insertions(+)
>  >
>  > diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
>  > index 27647d73d498..8a2fca8647b6 100644
>  > --- a/vdpa/vdpa.c
>  > +++ b/vdpa/vdpa.c
>  > @@ -353,6 +353,8 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int
> argc, char **argv,
>  > &opts->device_features);
>  >                         if (err)
>  >                                 return err;
>  > +
>  > +                       NEXT_ARG_FWD();
>  >                         o_found |= VDPA_OPT_VDEV_FEATURES;
>  >                 } else {
>  >                         fprintf(stderr, "Unknown option \"%s\"\n",
> *argv);
>  > --
>  > 2.17.1
>  >
> 

