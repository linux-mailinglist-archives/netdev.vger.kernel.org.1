Return-Path: <netdev+bounces-32124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C2792D67
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2ED1C20999
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2E8D52E;
	Tue,  5 Sep 2023 18:32:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE92F3B
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 18:32:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::605])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2581A4
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDF27/i/O4ngYFES0w2LULzgeNBxOalnIITHVimxeZMc/+Ukc7sAZHPA5MiacWCOgJvLQGJ/mt4jsbN4b3QGybY2c2mYQEuz+HD4VilrIgSmW+22+IffKqQXZEc5XTSibM9FTxE8k+GQPGbMe4o2UI/zVHGQqmJQu8ryHsWpM/iGFgbat+v1OqxDzrggoNjG+Qb24dFFjoGpdEiZ9W21Tn4mGR+xP1kMEwPt0Rf0AeRB5xYi/kPTdInnQCAIWi3UrwoziR7c+5NZ5AbQG6qsVf7KQ82Bzmrmus/7YqFnFOK8RbIqE8MR4iHOSAttuUgflFZeZdjodRvdd60wIGgqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuR5V0tGwZ8DT7bg/21BYJRBiA2bbUppZ0/GkRhsUQg=;
 b=EDdgVJh7LWufEQwQqumWpT/xLzdxccA1QqdS6/EwE2RqKB4IWAv4jTYIrzwU+yugJ1FDJ+oYnNCWvWkZHf9lG1jplFqfdPwd0zmMrXnLqJUzWkn6wXSC59R/ber6pJTvD32CfSuakkIpSKsmFDdq/xkN71gSfoKUnBZNvekzkAQPL0+E14V8qUZElzZYaN9MGAZOZq7U3FKeMoydoBqdxPK8yVvljpf0XtnmZrFLPojjHi2nAt/YXn7a6YhCT53evYarZs5el2In0t0baC2WiYrWMvIec2rqmU3zNP4eUOOalGJjJjI717yFbvv772r2rjHxNLHK788jh/KuyvBR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuR5V0tGwZ8DT7bg/21BYJRBiA2bbUppZ0/GkRhsUQg=;
 b=WIjSA0qfXX2Z4th70XQJ9/oCWYympGIhpDgricd0W/G1CN0YMCCZ1QzGWXwBhQ1jVkYjHqjMmDq2l8QfPdMFpzMpwv3A67Iulx72TCA8ZuUt5Y9onTFKXjtx+3EMvQByQE51HCRNoGjUxzDdaKON/mAIVLN3NT7VgLticbnu8NI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Tue, 5 Sep 2023 18:29:28 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:29:28 +0000
Message-ID: <6372d2fd-e998-4664-848d-539d592a516c@amd.com>
Date: Tue, 5 Sep 2023 11:29:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] i40e: fix potential memory leaks in i40e_remove()
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: Andrii Staikov <andrii.staikov@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20230905180521.887861-1-anthony.l.nguyen@intel.com>
 <20230905180521.887861-2-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20230905180521.887861-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 10608b76-72d9-46c4-091b-08dbae3e09e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pH3JaZoPcMfPjGTpa9wuemu7SAx2iYpn8Ta+7oBKWwNhYwrGSPZ8RFwsrvfdk8PDd+q5De7N1tX8Hal1BomGXB9+s/QV3hK61KYqSCOFHRScTmpKmptQVLaKB6q/ikx4IpnmjCypyTNGQR1J0TeGL5Z7r9d7nDQL8wNofkjBVuumJFBB+Tx/+0XjNMHI9jh0EpBWlksrW8lPmtwlrqi/IbgIdCkUDFTGTPPABg/f7+YxpLjoVvutnwvQcezshWPL2az0zT7z63NtY/O3rQvz5/DkF8u3ErVoEFdsyVPoREhRKNne+Z3j9j/wZfqUbwH9cwBrvSp3gV/mj6nB2IDlT9dC3LAb4UJDW2Eov/z/2+dk4LLzAF2gXHmJ9O4Cn2OCF8YuoBm1aGoEonF3Yhos14shskdWudt2z3cxjlib3PxnT+aWPiWJ1iuzxnOaDsTUQqGbinuYhvMzjhENOEU+AYXdW5gEXFOH1w4OXyt8KrbtqcJ+aGffhCgbIQy0SG98zTklErScvPE7Xdi4Uz+GwmoP+pOF5YnrOdDjUtHfuQoz+CvdCRa6PzY+codVUVpXQxDlwnJ6Pi4WQjly+bVCDOlgYrhHkvvlBVfgcuzijyPSnhyBOvBYF7XHT147hYKrY8K2BGTZfQaOhWF8Z9l0yA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(1800799009)(451199024)(186009)(66476007)(5660300002)(8936002)(54906003)(41300700001)(66556008)(316002)(66946007)(2906002)(31686004)(6666004)(26005)(6506007)(4326008)(6512007)(2616005)(8676002)(478600001)(83380400001)(6486002)(53546011)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1BGdU5IazhhQ01PY0VZeEZhbzExN3h3QitEK0hWZFZ4YzJUc3JCSlFLZzF0?=
 =?utf-8?B?SzZqSFdidllmUEc4dzJKNHE0NWd4ZURTNU93eW9PeFlHR1RJNy9sbkZ0cTBo?=
 =?utf-8?B?Rk1oWk1Qelo2Q2dQSkJRTm9WYVd1NW9POXkyQ0VZcFdXNEs0RVBIRWxnZWxU?=
 =?utf-8?B?QVVHVTU1Mk9xOUhpeXJLTGMwaWYvZGlPUitMVlM4UVM4dm1LYkljZVJENjBz?=
 =?utf-8?B?YVFRKzA3NTN0T2R0dUFGakhDZFdnbEFjZ09NZWlMbFlmSHdCRXVOYllxanBv?=
 =?utf-8?B?UGZrc01sSEEvdEIyOTJzR01MbXNXK2xwZEtzRXFNOGdzUGYrTVhWdmtrbEdu?=
 =?utf-8?B?L2t0K3pSZlVCZ2pFVXRRcUZ2b21qR2poVGg1WXFzRUtKMVdxUHVxdFNmcmV0?=
 =?utf-8?B?MVlqbDB1Nnp1TU9KejAwelJMTVhkS3VsaFIxOVRSN3laZjdTOEwxeUtWZUto?=
 =?utf-8?B?NU83TmxRa3AzVWsyRGc0VHJicXpsSGM4ME9CbkE0MkQzcjhqMEhnL2w0b1ZB?=
 =?utf-8?B?K0F1THVDelAxaXdDOFd6U3RMdkMyVXVpTS9sVVBpN0hJc2xtNXQwbll5aGRE?=
 =?utf-8?B?NHFPY0pJSVpNZS9rWnhTQnRESm9UTkhSbmpNT0NVQ3ZxeWFVTllJT2pnRSta?=
 =?utf-8?B?WHVycFVRRHJPOWk2dVZLQ0E0UDBVNDZlQkNIdk5wWXdHbzhVOXJETDdaYXl0?=
 =?utf-8?B?VmpzYTNndTlhaUJ1S3RzbkM5V1FhNXpCbGYvaGhQMmZqZ1pKZHUzTVozUGsy?=
 =?utf-8?B?VVZYMWx4UFExOTc3bFgzcG9MS1lCdXg0RHhoSHVLclc1TGszd2lWVHpacG9u?=
 =?utf-8?B?ZEpLZEtDM0xTb1JDMXd1N1JyYkYvME9iRCs3emJWQzZjRTV2K29VUHNlUEZz?=
 =?utf-8?B?Q3EvL3VrMkVkZGVSRTQydExxczVkT2F3dFEySGhOTnRmd1dTRHdPdytLOUg4?=
 =?utf-8?B?czN3dVdzYndJVWQzNUVHQkx5T3UzK0NLVERJWEhTRjh0Z3dDc0hmMHRFNlhu?=
 =?utf-8?B?bHhQRkVjTjlCNVFNd0pVMjI4Z2VJb3NtbHBYbVVEZ0RhVnF3R3ZUZTlTVnBn?=
 =?utf-8?B?NTU2aUNFQzJGQWNqcmkxNjV6L2EybnpjR1VMTHhvbDlXWUFtT0xtaXpEUEhn?=
 =?utf-8?B?UmZ6aUtMcmU2Wlk0VkVRWFlVY3dmOVVkUkJuYlIzaWhLTWNZaG92dS9vUW5H?=
 =?utf-8?B?MjVsSno0WVEzZUsweE1ZanV5Z1h6T01Yckt5eGQ5dWNTdnF4dDR2T3IrMmNv?=
 =?utf-8?B?T0UvS0JZV2hjajVhMU9kUm1veU0zMjZXZVpMYVFpMzltSlRvQ083SitvWlZP?=
 =?utf-8?B?TjhnancwSytPaXRjZStjY1lPVjZ5cE04c1RpeFhPaC8wTVJWWXJHSGFGb3FL?=
 =?utf-8?B?aGlEYUtLb0tNdnJDQStENHM0YlFTbFFITmFYQ1dXcHNtUHhxWm9iQjhoaTJh?=
 =?utf-8?B?ZFpReUtFTSs4Tjkzd1B4N1EwaktGSDJHMVhtT3dKeU83dG5GNTFYWE85RFRL?=
 =?utf-8?B?TkxjTHB1S3lkSHhIbTVOalFPVmxrYldVTzZRWm42bnR5TFVJOWRLcUlIVVB4?=
 =?utf-8?B?cHZ4KzZUaENrZm1RYmdUL3RtVTFqN2dTbWhWQXIyMWJqZllwd0NFTmJwZmRH?=
 =?utf-8?B?MFBvVWlWV0t5ajU5V2s3VWJzYnYyVWhNcDJySU1EbThHbjFaQ24vdlIxYStC?=
 =?utf-8?B?L1FOTGwzVWxqVCtyUFJQUEVQTWJmNFMwZlZ3YlRoN2dLSzExQ2ZKZTZIT2U0?=
 =?utf-8?B?UzAxZEhGNG5zTW9qYy9vVk0rMTY5SThUblZLbGV2eDE5YXhoM1VhRXNrVVFP?=
 =?utf-8?B?Q3pLaUJCTVNiaTk2OHU2NFllZmVBelVmMVE0RWh1MXdWTDFQYVMwb2UvdzBx?=
 =?utf-8?B?blpHcFZvRjVzNUl1dm01UVphQnp5R243dVc5VGswVnNZaFQ4K0tDd1FMZGZ3?=
 =?utf-8?B?L2IydDFOeFF3OTByMnRsTGdWSTgyZUtMOGNnZVllTUhnY0lJNExqYlp6a1JG?=
 =?utf-8?B?eFdhNDlsZVd1S1BiZ0hFc1VpRFVUVDVaRnRkLzFmV1VMR1d5OHJoUDZZR01q?=
 =?utf-8?B?WTl4RW54aUtwZEplbzVjYy9mNHRvNU45STQrdHdjMFA2MWJoMHo3S3ljbE1k?=
 =?utf-8?Q?9+qTRd5ue0GXehb+eKhZ5+HTs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10608b76-72d9-46c4-091b-08dbae3e09e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:29:28.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTEA9H1+SACoxsdctkpNgFD81LFuA0hai4DruxS3goEtmkQrewwOZIhEqoUoI81OWTRGnpBn38RCznUoEpGAtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/5/2023 11:05 AM, Tony Nguyen wrote:
> 
> From: Andrii Staikov <andrii.staikov@intel.com>
> 
> Instead of freeing memory of a single VSI, make sure
> the memory for all VSIs is cleared before releasing VSIs.
> Add releasing of their resources in a loop with the iteration
> number equal to the number of allocated VSIs.
> 
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index de7fd43dc11c..059db43f8643 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -16323,8 +16323,14 @@ static void i40e_remove(struct pci_dev *pdev)
>          /* Now we can shutdown the PF's VSI, just before we kill

Since we're looping over multiple VSIs, this comment should be updated 
to be plural.

>           * adminq and hmc.
>           */
> -       if (pf->vsi[pf->lan_vsi])
> -               i40e_vsi_release(pf->vsi[pf->lan_vsi]);
> +       for (i = pf->num_alloc_vsi; i--;)
> +               if (pf->vsi[i]) {
> +                       i40e_vsi_close(pf->vsi[i]);
> +                       i40e_vsi_free_q_vectors(pf->vsi[i]);
> +                       i40e_vsi_release(pf->vsi[i]);
> +                       kfree(pf->vsi[i]);
> +                       pf->vsi[i] = NULL;
> +               }

Looping over all the VSIs makes some sense now that there are multiple 
VSIs being used by the PF, but why all the extra calls?  It seems to me 
that i40e_vsi_release() already takes care of all this except for the 
"pf->vsi[i] = NULL".

sln

> 
>          i40e_cloud_filter_exit(pf);
> 
> --
> 2.38.1
> 

