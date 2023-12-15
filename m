Return-Path: <netdev+bounces-57699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3751813E88
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 01:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6FA1F21312
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 00:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C296170;
	Fri, 15 Dec 2023 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oGGDL0sn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2CC624
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geR2qmCCiXnuyPlLkDwzm2yHyqkrmX/lqrnZ6W8OhPQCJzURVZf/+6Qp31nEM+HBX/by6w+86R7ghWG8iwD0K0Xy4stLaKwQPjUo4RlW8rXW1bcApn/nk9tXSON2QsDf3BfERz0quMer5dEL37qm5ApopUSx4Qi/LPngE11iSzLmRaNnmFCtEpdMlZZJaFKYAaxJk+V+xBhTksZ9SwNFxux2Yhi/WprF23o2inNB4bDAdJRPxje+UARQ/2r1rwYcCi7quJa8lxYSuUpGCIhe8IH3nY+jCGLThOFt0A79rI1byQSYNNb4n+PCvvU5CzaYubvK7YVTMUI+GK6PFpUksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCM9B6THdJ0n1/sjvvP7TXWuMIcgrt9orhew8vkoBAs=;
 b=lTV2bN28VB9mpBEEDT59wUsNdUfy7kwoeT9EHvvoWaFE5KqLk7GRJChsRB2A50nextBZaFqUlTQ3Fecb+W2lsDOOheOrUxAB+A4g94CRpS/n0jm6ekEA7V4f30hi6xJsR4S3kqp0cJTF3PwfoZasN+g7+JzR0TIv/ceBDKhy6Q8FfDzO/8D2pl4lSXQbCZG8qlIN1Ls1JlpRSH74sQBUlOhWyEDJZRdez5wLka/iDHcBucpgjLmQjW2qxFOaLl+3MuyhedpBjqlBQlW84K6SvyRIw0WXEhUGN76MglJHeB2+xS6Uoqu/X1pRttrQtcPm/svkUFIEYgzc0L46vFjTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCM9B6THdJ0n1/sjvvP7TXWuMIcgrt9orhew8vkoBAs=;
 b=oGGDL0snx6aJyFbumn+i4rCSuj8lYg2z5H31XIEYUNLnMydfDNXlbrHlvlVW2M6s22QSOqmWlDENuJ+V4exoAoCoSWsmoBSELIxGCik8nd7S481/ZAZdLRcSQJGHKpm0NC50x1Yqbki1F6gLR6oDeEO3F4BpVkVtL02ix0LPnEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 00:05:52 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 00:05:51 +0000
Message-ID: <71eded85-49bf-4f9d-a604-7b8129aa19ba@amd.com>
Date: Thu, 14 Dec 2023 16:05:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] sfc: add debugfs node for filter table
 contents
Content-Language: en-US
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <0cf27cb7a42cc81c8d360b5812690e636a100244.1702314695.git.ecree.xilinx@gmail.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <0cf27cb7a42cc81c8d360b5812690e636a100244.1702314695.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:302:1::37) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: d117400d-af91-4304-f6fa-08dbfd0199a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JLf91c/FitVvNtBnIQCKVKKrGYe6TpmwMr7s6BHkYyJk5sZB32saS7IJN+IViFv1d+9l5XFswc0AzdFTpYmTzoEh7O+TjxdYUuMH2LtckvcipUG/9lTg6X1/zsDFOuX6qVYrFY03LLUay8I5DfvpOC7ufB28AoWdYgn0tdlvr9BEMlF6aZSOnregmU5Bigv99n6O1CEu+sbUuc3VovL8o0RIf7i/YjX+2qnUj7kZ8hgZFQkrQFkcbyFjS4qYATKUgOlEq9rJywBTvzD3OpI+/0QIZpjEGxdUBnXJnaewB/mytyV1+f7PKlv5rGZ/9Wiw/E8h61c5G9ZlqpwQGQySeCsurm/22IRSbfI1YLFqbHsfHyXeaoZyF3GLO2Nk2gQWeUo35lnDYbsR3mxNWCUe4iKdI0E5i1b5rIrs6rnw4GIh0lIud4Il+XgUsnP9ZtdbqxTKua8Gcq4v2vAwnUorQyKmhqukjthWHgN5UDlk5rr2GSDcyifzj9MZ3xQrxcy9sOOl9pBfr0Te5iLKSu0QOVK2iy5bko8hf9HBx6g3MSCnVyeu19XqxMDpEExhVlngb+oe1CdN4WIdP0odGK43XgG0t5VfuP7McTKOAVDczU6uSn1xaBIAe7LJhDOEyTbYKuOejzcM6YHw5083Ou5eFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(8936002)(8676002)(26005)(4326008)(5660300002)(83380400001)(86362001)(6506007)(53546011)(2906002)(6486002)(38100700002)(31696002)(36756003)(478600001)(41300700001)(31686004)(66946007)(66556008)(66476007)(54906003)(6512007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlBYRlRwcGZYTjdVcUFDRWVmVlVUN2pRa3drU0JkR2d0cjJGcGhtNWdSelQz?=
 =?utf-8?B?MnNOcHo3dmk3KzVjNW1FTlZTd3NaRDJZQWNodHlDdkxEV2ZYYXZuRG0vdlhs?=
 =?utf-8?B?VVZkejVEaFF4N2NxakNBV0VTcE1OR0JUYngwSC9vQjU4V1VKNDF5c0xqa2Z1?=
 =?utf-8?B?ajJLT3JlTXRPRmpUNEF1OFRTaytkSU5GNnBMeEZiQWpiWUtqcGdTSHpZVkNa?=
 =?utf-8?B?Z0srT08zVWN4WnZ3bUprbTVyaWxBZ3pqSmtBdGR3LzlvNG5kUEx2WWViQUV4?=
 =?utf-8?B?dVQ3L1ZoUmdtWUNjOXRTSGxkaFl6Y0xmbkdLbzVFUkNmQVRsSW53blRmazNY?=
 =?utf-8?B?bnVwaXJVMEdRQjJLMHd6L1BUVzNhcGhnMFNCU3Q1UlVTQmt5VWZKeHRRKzR0?=
 =?utf-8?B?RmJFUDdzUzRtR2FFbHFHeFJPQ0l0ZXRFcjZGNnh1RlFOYnZxbzVnZ0hmeHRQ?=
 =?utf-8?B?Vy9yNldwVHJabmFtbnpXcUVZMFhPeGJ2QWl4ZnhhVVNVTVRIa0VkRHpwSmdj?=
 =?utf-8?B?dUh0MlRndDFjOEZYZ0xCeVRmZmNaOGd1TnRGTDJEU1BHQWc4WVNqbHR6UFRD?=
 =?utf-8?B?WnY4T1ZiVnlaa1owOUZKbVBEWTBmMHNjTkVlQzhvVzUvUWs4QnUrYU81dGNi?=
 =?utf-8?B?SnV2RDJDS0RvOS9PZy9vNmdYZXJzVThvTEg0TzNQNFZHS1lWbUFvRWN5a0Vh?=
 =?utf-8?B?U3A0NGwvOFZZbmN3clJSdm5pWmRsTzVuOWd2cVdaL2NRV0x3YWtldjB0UW5K?=
 =?utf-8?B?Q2E3OFdwem5HMTU2Q21GSXZuRWpGQ1VkRW01Q0FVMWtrclVlUGkwellPVDJm?=
 =?utf-8?B?SU1iZlJ1M3I1TEdaVUMySUhaaHJ0RGEzUjhBMERGWUZPc0c5bUJqaXJSSkd5?=
 =?utf-8?B?QVE2OGtNRDNlMHQwcUlPbHFKYjNYRk5ZN3U0YjBTeGQ3d21vam9QL1d6RTc1?=
 =?utf-8?B?a29Yb3F2QzhXU1I2UmZ1NllGVWZTL3NqMlR5RGM0blEwa3JrS0JtRmtBZUVl?=
 =?utf-8?B?NWhqb1JxZUdha2V4eUhFL2diRjN2MHNYdnJWd2gwUE5veWdxcmlGL0pwUnZ3?=
 =?utf-8?B?dm00TWwyTzJ3YXBjcUlnOVY4eEpTUzVnK09TWkFWOXUxVWEwNFZrN094QmlR?=
 =?utf-8?B?S1Z3SEtLRlBTa3AwZllRblJDUHFRcmZtZ1pYYTZtRDhIZ1BkSHdWV2VRVmdX?=
 =?utf-8?B?alFQaU1uM2xRaEYzdHpENzJmMzlpNXBpQnZpRFpMQ3NTSEVJYndZK29RYi82?=
 =?utf-8?B?QXFvR01yOHpqMmU0UDcreG9ucGlkQ1JwNkFyekRlbVVYL3Q3djBSb1d1L1VH?=
 =?utf-8?B?b0lVclJ5cFNBUVJib01VS3dQUUhrSGpUTTJiaXJ0QmxJK0FrWkxnQVJXS2J2?=
 =?utf-8?B?bTNTcjlTeVo5K0dGbDVvclFWUEUwYm4rQVRTWUJDOXpFUjFYd0R4dUVyWkpW?=
 =?utf-8?B?SFlHUzhPNW10eGFXejhzelkrYXdCVDFISDg2eWRLRGFjQXpPS1V0QVI2ZnRZ?=
 =?utf-8?B?eHpKMzNoaWcxUEpqMmtGejB6MlV4VE9JTnU3bTdFR1ptbkdkUzBOL1RLZUI2?=
 =?utf-8?B?K2hEYmhQa0FBT0tTa2FROVJvS3hiV3g1VjJpR1VVbm05T29QbzYxcVE5ZGZ6?=
 =?utf-8?B?eHdwaGxqOEVVYzN0TkZxWjBHOWI5ZkIzZkpOZnZrK0h5KzBPUmp2RVNGVXRn?=
 =?utf-8?B?bmxMVjlXQk5hVlR1UDJLa2p1VXExSVNNSU5CZkpLT2NoSWpMVU0rdFFnMENB?=
 =?utf-8?B?ZHZ3bXpWSnoyVFQvQ1FSQUc3TFptL21hd2Y0VlUwRHIyWHVscFR0K3BkUmND?=
 =?utf-8?B?a05NbHl1dHhEUDUxQ0xNM0kwK08xcFVPbCtNOWcxNWdtTmM1aFNCSERtRnBY?=
 =?utf-8?B?dG1QRmhITmhCMldEaUQrdFVhUEhnTFovQUczRERTWmFEc3hOZmV4eHRkM016?=
 =?utf-8?B?d1JBRU9tQU9VRGJDcVJpTlYxNzRzY3ZWWm1yVndzbmI2ZVVRMVBNcXFRMEtz?=
 =?utf-8?B?MDlnWlZHSkNFYUZkRWR1a2NLakl2c0xXYnhTNTE2ZXpybGE3Rk9TQXNCSmVX?=
 =?utf-8?B?UVZTRzJSS1lhZEJwMFZSNlA3TzBYTG9CYnZtUXUyNXpYZWZVOFM0RTZHdDlF?=
 =?utf-8?Q?ESAHKxGydy0o6Y6KnNYeZFS5i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d117400d-af91-4304-f6fa-08dbfd0199a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 00:05:51.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHxqBLM4cvgJpyuyZjoWftSeAUM1drpbfaEJTDRbu/7wtZp4EEim/8u6nxMVRHcQh/ZYRHnjffjPeiqDDuiQcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

On 12/11/2023 9:18 AM, edward.cree@amd.com wrote:
> 
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Expose the filter table entries.
> 
> Reviewed-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>   drivers/net/ethernet/sfc/debugfs.c      | 117 +++++++++++++++++++++++-
>   drivers/net/ethernet/sfc/debugfs.h      |  45 +++++++++
>   drivers/net/ethernet/sfc/mcdi_filters.c |  39 ++++++++
>   3 files changed, 197 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/debugfs.c b/drivers/net/ethernet/sfc/debugfs.c
> index 549ff1ee273e..e67b0fc927fe 100644
> --- a/drivers/net/ethernet/sfc/debugfs.c
> +++ b/drivers/net/ethernet/sfc/debugfs.c
> @@ -9,10 +9,6 @@
>    */
> 
>   #include "debugfs.h"
> -#include <linux/module.h>
> -#include <linux/debugfs.h>
> -#include <linux/dcache.h>
> -#include <linux/seq_file.h>

Can you leave these out of the original patch and not have to remove 
them here?

> 
>   /* Maximum length for a name component or symlink target */
>   #define EFX_DEBUGFS_NAME_LEN 32
> @@ -428,3 +424,116 @@ void efx_fini_debugfs(void)
>          efx_debug_cards = NULL;
>          efx_debug_root = NULL;
>   }
> +
> +/**
> + * efx_debugfs_print_filter - format a filter spec for display
> + * @s: buffer to write result into
> + * @l: length of buffer @s
> + * @spec: filter specification
> + */
> +void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec)
> +{
> +       u32 ip[4];
> +       int p = snprintf(s, l, "match=%#x,pri=%d,flags=%#x,q=%d",
> +                        spec->match_flags, spec->priority, spec->flags,
> +                        spec->dmaq_id);
> +
> +       if (spec->vport_id)
> +               p += snprintf(s + p, l - p, ",vport=%#x", spec->vport_id);
> +
> +       if (spec->flags & EFX_FILTER_FLAG_RX_RSS)
> +               p += snprintf(s + p, l - p, ",rss=%#x", spec->rss_context);
> +
> +       if (spec->match_flags & EFX_FILTER_MATCH_OUTER_VID)
> +               p += snprintf(s + p, l - p,
> +                             ",ovid=%d", ntohs(spec->outer_vid));
> +       if (spec->match_flags & EFX_FILTER_MATCH_INNER_VID)
> +               p += snprintf(s + p, l - p,
> +                             ",ivid=%d", ntohs(spec->inner_vid));
> +       if (spec->match_flags & EFX_FILTER_MATCH_ENCAP_TYPE)
> +               p += snprintf(s + p, l - p,
> +                             ",encap=%d", spec->encap_type);
> +       if (spec->match_flags & EFX_FILTER_MATCH_LOC_MAC)
> +               p += snprintf(s + p, l - p,
> +                             ",lmac=%02x:%02x:%02x:%02x:%02x:%02x",
> +                             spec->loc_mac[0], spec->loc_mac[1],
> +                             spec->loc_mac[2], spec->loc_mac[3],
> +                             spec->loc_mac[4], spec->loc_mac[5]);
> +       if (spec->match_flags & EFX_FILTER_MATCH_REM_MAC)
> +               p += snprintf(s + p, l - p,
> +                             ",rmac=%02x:%02x:%02x:%02x:%02x:%02x",
> +                             spec->rem_mac[0], spec->rem_mac[1],
> +                             spec->rem_mac[2], spec->rem_mac[3],
> +                             spec->rem_mac[4], spec->rem_mac[5]);
> +       if (spec->match_flags & EFX_FILTER_MATCH_ETHER_TYPE)
> +               p += snprintf(s + p, l - p,
> +                             ",ether=%#x", ntohs(spec->ether_type));
> +       if (spec->match_flags & EFX_FILTER_MATCH_IP_PROTO)
> +               p += snprintf(s + p, l - p,
> +                             ",ippr=%#x", spec->ip_proto);
> +       if (spec->match_flags & EFX_FILTER_MATCH_LOC_HOST) {
> +               if (ntohs(spec->ether_type) == ETH_P_IP) {
> +                       ip[0] = (__force u32) spec->loc_host[0];
> +                       p += snprintf(s + p, l - p,
> +                                     ",lip=%d.%d.%d.%d",
> +                                     ip[0] & 0xff,
> +                                     (ip[0] >> 8) & 0xff,
> +                                     (ip[0] >> 16) & 0xff,
> +                                     (ip[0] >> 24) & 0xff);
> +               } else if (ntohs(spec->ether_type) == ETH_P_IPV6) {
> +                       ip[0] = (__force u32) spec->loc_host[0];
> +                       ip[1] = (__force u32) spec->loc_host[1];
> +                       ip[2] = (__force u32) spec->loc_host[2];
> +                       ip[3] = (__force u32) spec->loc_host[3];
> +                       p += snprintf(s + p, l - p,
> +                                     ",lip=%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
> +                                     ip[0] & 0xffff,
> +                                     (ip[0] >> 16) & 0xffff,
> +                                     ip[1] & 0xffff,
> +                                     (ip[1] >> 16) & 0xffff,
> +                                     ip[2] & 0xffff,
> +                                     (ip[2] >> 16) & 0xffff,
> +                                     ip[3] & 0xffff,
> +                                     (ip[3] >> 16) & 0xffff);
> +               } else {
> +                       p += snprintf(s + p, l - p, ",lip=?");
> +               }
> +       }
> +       if (spec->match_flags & EFX_FILTER_MATCH_REM_HOST) {
> +               if (ntohs(spec->ether_type) == ETH_P_IP) {
> +                       ip[0] = (__force u32) spec->rem_host[0];
> +                       p += snprintf(s + p, l - p,
> +                                     ",rip=%d.%d.%d.%d",
> +                                     ip[0] & 0xff,
> +                                     (ip[0] >> 8) & 0xff,
> +                                     (ip[0] >> 16) & 0xff,
> +                                     (ip[0] >> 24) & 0xff);
> +               } else if (ntohs(spec->ether_type) == ETH_P_IPV6) {
> +                       ip[0] = (__force u32) spec->rem_host[0];
> +                       ip[1] = (__force u32) spec->rem_host[1];
> +                       ip[2] = (__force u32) spec->rem_host[2];
> +                       ip[3] = (__force u32) spec->rem_host[3];
> +                       p += snprintf(s + p, l - p,
> +                                     ",rip=%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
> +                                     ip[0] & 0xffff,
> +                                     (ip[0] >> 16) & 0xffff,
> +                                     ip[1] & 0xffff,
> +                                     (ip[1] >> 16) & 0xffff,
> +                                     ip[2] & 0xffff,
> +                                     (ip[2] >> 16) & 0xffff,
> +                                     ip[3] & 0xffff,
> +                                     (ip[3] >> 16) & 0xffff);
> +               } else {
> +                       p += snprintf(s + p, l - p, ",rip=?");
> +               }

Since you have this code more than once, it might be a candidate for a 
utility function, if one doesn't already exist somewhere in the kernel 
already.

> +       }
> +       if (spec->match_flags & EFX_FILTER_MATCH_LOC_PORT)
> +               p += snprintf(s + p, l - p,
> +                             ",lport=%d", ntohs(spec->loc_port));
> +       if (spec->match_flags & EFX_FILTER_MATCH_REM_PORT)
> +               p += snprintf(s + p, l - p,
> +                             ",rport=%d", ntohs(spec->rem_port));
> +       if (spec->match_flags & EFX_FILTER_MATCH_LOC_MAC_IG)
> +               p += snprintf(s + p, l - p, ",%s",
> +                             spec->loc_mac[0] ? "mc" : "uc");
> +}
> diff --git a/drivers/net/ethernet/sfc/debugfs.h b/drivers/net/ethernet/sfc/debugfs.h
> index 7a96f3798cbd..f50b4bf33a6b 100644
> --- a/drivers/net/ethernet/sfc/debugfs.h
> +++ b/drivers/net/ethernet/sfc/debugfs.h
> @@ -10,6 +10,10 @@
> 
>   #ifndef EFX_DEBUGFS_H
>   #define EFX_DEBUGFS_H
> +#include <linux/module.h>
> +#include <linux/debugfs.h>
> +#include <linux/dcache.h>
> +#include <linux/seq_file.h>
>   #include "net_driver.h"
> 
>   #ifdef CONFIG_DEBUG_FS
> @@ -63,6 +67,45 @@ void efx_fini_debugfs_nic(struct efx_nic *efx);
>   int efx_init_debugfs(void);
>   void efx_fini_debugfs(void);
> 
> +void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec);
> +
> +/* Generate operations for a debugfs node with a custom reader function.
> + * The reader should have signature int (*)(struct seq_file *s, void *data)
> + * where data is the pointer passed to EFX_DEBUGFS_CREATE_RAW.
> + */
> +#define EFX_DEBUGFS_RAW_PARAMETER(_reader)                                    \
> +                                                                              \
> +static int efx_debugfs_##_reader##_read(struct seq_file *s, void *d)          \
> +{                                                                             \
> +       return _reader(s, s->private);                                         \
> +}                                                                             \
> +                                                                              \
> +static int efx_debugfs_##_reader##_open(struct inode *inode, struct file *f)   \
> +{                                                                             \
> +       return single_open(f, efx_debugfs_##_reader##_read, inode->i_private); \
> +}                                                                             \
> +                                                                              \
> +static const struct file_operations efx_debugfs_##_reader##_ops = {           \
> +       .owner = THIS_MODULE,                                                  \
> +       .open = efx_debugfs_##_reader##_open,                                  \
> +       .release = single_release,                                             \
> +       .read = seq_read,                                                      \
> +       .llseek = seq_lseek,                                                   \
> +};                                                                            \
> +                                                                              \
> +static void efx_debugfs_create_##_reader(const char *name, umode_t mode,       \
> +                                        struct dentry *parent, void *data)    \
> +{                                                                             \
> +       debugfs_create_file(name, mode, parent, data,                          \
> +                           &efx_debugfs_##_reader##_ops);                     \
> +}
> +
> +/* Instantiate a debugfs node with a custom reader function.  The operations
> + * must have been generated with EFX_DEBUGFS_RAW_PARAMETER(_reader).
> + */
> +#define EFX_DEBUGFS_CREATE_RAW(_name, _mode, _parent, _data, _reader)         \
> +               efx_debugfs_create_##_reader(_name, _mode, _parent, _data)
> +
>   #else /* CONFIG_DEBUG_FS */
> 
>   static inline void efx_fini_debugfs_netdev(struct net_device *net_dev) {}
> @@ -99,6 +142,8 @@ static inline int efx_init_debugfs(void)
>   }
>   static inline void efx_fini_debugfs(void) {}
> 
> +void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec) {}
> +
>   #endif /* CONFIG_DEBUG_FS */
> 
>   #endif /* EFX_DEBUGFS_H */
> diff --git a/drivers/net/ethernet/sfc/mcdi_filters.c b/drivers/net/ethernet/sfc/mcdi_filters.c
> index a4ab45082c8f..465226c3e8c7 100644
> --- a/drivers/net/ethernet/sfc/mcdi_filters.c
> +++ b/drivers/net/ethernet/sfc/mcdi_filters.c
> @@ -13,6 +13,7 @@
>   #include "mcdi.h"
>   #include "nic.h"
>   #include "rx_common.h"
> +#include "debugfs.h"
> 
>   /* The maximum size of a shared RSS context */
>   /* TODO: this should really be from the mcdi protocol export */
> @@ -1173,6 +1174,42 @@ s32 efx_mcdi_filter_get_rx_ids(struct efx_nic *efx,
>          return count;
>   }
> 
> +static int efx_debugfs_read_filter_list(struct seq_file *file, void *data)
> +{
> +       struct efx_mcdi_filter_table *table;
> +       struct efx_nic *efx = data;
> +       int i;
> +
> +       down_read(&efx->filter_sem);
> +       table = efx->filter_state;
> +       if (!table || !table->entry) {
> +               up_read(&efx->filter_sem);
> +               return -ENETDOWN;
> +       }
> +
> +       /* deliberately don't lock the table->lock, so that we can
> +        * still dump the table even if we hang mid-operation.
> +        */
> +       for (i = 0; i < EFX_MCDI_FILTER_TBL_ROWS; ++i) {
> +               struct efx_filter_spec *spec =
> +                       efx_mcdi_filter_entry_spec(table, i);
> +               char filter[256];
> +
> +               if (spec) {
> +                       efx_debugfs_print_filter(filter, sizeof(filter), spec);
> +
> +                       seq_printf(file, "%d[%#04llx],%#x = %s\n",
> +                                  i, table->entry[i].handle & 0xffff,
> +                                  efx_mcdi_filter_entry_flags(table, i),
> +                                  filter);
> +               }
> +       }
> +
> +       up_read(&efx->filter_sem);
> +       return 0;
> +}
> +EFX_DEBUGFS_RAW_PARAMETER(efx_debugfs_read_filter_list);
> +
>   static int efx_mcdi_filter_match_flags_from_mcdi(bool encap, u32 mcdi_flags)
>   {
>          int match_flags = 0;
> @@ -1360,6 +1397,8 @@ int efx_mcdi_filter_table_probe(struct efx_nic *efx, bool multicast_chaining)
>                              &table->mc_overflow);
>          debugfs_create_bool("mc_chaining", 0444, table->debug_dir,
>                              &table->mc_chaining);
> +       EFX_DEBUGFS_CREATE_RAW("entries", 0444, table->debug_dir, efx,
> +                              efx_debugfs_read_filter_list);
>   #endif
> 
>          efx->filter_state = table;
> 

