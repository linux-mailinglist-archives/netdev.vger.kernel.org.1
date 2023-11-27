Return-Path: <netdev+bounces-51364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AF77FA55E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19E01C20A16
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2980347AD;
	Mon, 27 Nov 2023 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQjzjKeQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C57BF
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701100556; x=1732636556;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=oM6qmCF8PR4W2dmdjK8j5e8t8NowYBbhU5v4jIopq/Y=;
  b=SQjzjKeQrRWCBBgEwiRdEfpU9a+XTFp1y88EqDNQlUSTB4bH+ROcLgcS
   CiMFGpY3rhXpZ3BR68SbNkLfCWYk6siIEX3+VyBQnkOXETxGiSMFvD2za
   jg/FIidQvS9hqybTMEX7QhONEFmlSsqXZ97by4c8jCKngpBN+sx/jnbR6
   A5LwtLhNNF9dbPhXm1aih3UehFELhb++ZhW+czasByuiAo5Cy88Fu6JTe
   4WYt0Vj8+K+g7mDRdRNX1M3ublq0CUpPfXI4+bNZETlq67mIY6h2iJpXO
   LRAaN5DmO99hjqRpNsYzYtpPYRHpCkw7EjfpmU8sfAmJOX637rm56KphF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372103364"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="372103364"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 07:46:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="912125611"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="912125611"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 07:46:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 07:46:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 07:46:26 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 07:46:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbJ64aGWovZ5VlfWPK+L9xAhvMg6MTzNiAZZWjhJVjg4A6mvCC6jq+R1G0HOX3r6cWUgnqytQt62v6pqg2dzbNOJlF5IaofP+7LjRee2m67L7U9dEIdsEGXpuloUV/BYep0hj6x5083qfTVhCjm+UvNldddqmZ+nVTTkAtoRykYl4YnW7IBFl0/sOQvdq1fgnFdulopVDiOdkZKXGnX1PtyOnuiT599ou33GouXs2a8TVbtK9a2mOrVcHiAXEaoBk4gIOUhKu2T1bfmQfIGKi5UXM+ipWhsU9px0gMVvQajrpX0+Asqo7E7jfnkbLZ0LRn9F+1o1BoHRN5OSEGyVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DSoczAlBRNzGTPQylqDTwEXwCoiz3u6toFjp/59U7U=;
 b=lJmdlMoOWhW1FZt+dih6YXtAMfVYzxsUJmEMKRJqauyEvuDtWFShAS4cEfxxq2vUteBDnz2XW7m4nMcTR79XUQzs9FEMFU2InjVOUjoasaarz09dZEvJ19bMo4QZjFOjO3dAww3qtCC2VnvIy7FYdOjqhAPZ5VFO3QSt9JdwcmtNfE3AoFu/dcLxgCKr8PGHqaY9pWU5VobEmY48LGY0xBd8+jWqH92CK49xKC51EulLH46iNfgIz9WUPKC3YR6smKC5kUq7Aa/XQeAToh3wN2qrMd2mYNkU1EnRCm5VQ9cDvGuVgpDILvznbnG8MPyYCEUS7LfP7uuB5nKbNCh/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 15:46:24 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 15:46:24 +0000
Message-ID: <edbd7dd4-9382-5708-efad-88737dcebb19@intel.com>
Date: Mon, 27 Nov 2023 16:46:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [ethtool PATCH] netlink: fix -Walloc-size
Content-Language: en-US
To: Sam James <sam@gentoo.org>, <netdev@vger.kernel.org>
References: <20231124230810.1656050-1-sam@gentoo.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231124230810.1656050-1-sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CH3PR11MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: b812bee5-6ae2-4962-09f7-08dbef60027c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odOw5T129ZLMt+1fVakronMhUJ/KnNNMXLJZYFGI7EuKSZ31xgwk2oBljjkHKH5WrXtC1oh2CNDI2DdvdGupaaIDwBYskqygo0YBlqnA0afMr1nHBY1mdW+9ekdRnvjudESYycQjpSaZoKRflZgW/9B1kh4CbpD/solIheV0WR3aNnIlpjI3d9QxIW1tKRj0U3IxPSFhWrYyAotuuFFrx+ze612fhdDM+EVudZf/gZ0JMmHNBDSZKLtfkXAENkW5uPyMIxAuGluai/qrBNJk+qgAZEQbCDrSuYs6DWOAwo2BqJ8Bsm0aE2J8p5fG2MHzcO7L/rl6uYagTHZHkisUIsZxlWzwd3Gp1ru/DGxh73SHIs9+fKjyHHJtY+9aPoSm//Qs2vRxKnXMZYdWC9rJk64nGn0RJuBTrMecyepg4wW4HAxWlq63GqO2MOnkrgCKGlYZGxI3AkbUKvNuSlNl7ETHPQxIHSUY31Fk+x8AwHktl4NxvhEyD90/A9NaKBcInyzabuZlP3WIdARFr7hfCIdbcJ/071nkImi9Y6TptIGIwtGA3P5cPzVNpcFjpHCbEJwfRjlUJZLnhs2CXuBPhmWavyMfpSdsQLGRhsgxUesCwSbZGhvmIrevI0LI8unapqz3axIWdVq/K8svjuK0SkMxHc6oZs42px4gVmBUAdz8P/NlPZtaeEjMOYRzJLiA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(31696002)(86362001)(82960400001)(38100700002)(36756003)(478600001)(6486002)(66556008)(66476007)(316002)(66946007)(26005)(6506007)(6666004)(2616005)(53546011)(6512007)(5660300002)(2906002)(41300700001)(8936002)(8676002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXo4RzM5K1ZORUlQdk1CQkpMYVYvcHZJN2xpdVZaL0pzNHRuOUVhYVg1WXpC?=
 =?utf-8?B?TklBUmQwTy9yK3BOVGRTTGc5cXNndjJOYUhZRUlQRHR4ZmpLMkhwWFU3U3JT?=
 =?utf-8?B?OG5MTXNJVnNjeUNneHdNc0R1ZkJQNlA5SjFsN3daRk9GZnp0LzBGTW1BZ0g0?=
 =?utf-8?B?dVRaT0FhR2FWM0MrdXNzUzZrMDl6QTA1NHZac0hrR3VaOWd5aDVnL1VZSmhv?=
 =?utf-8?B?a29LTUtCU2dCM1h2dm5rc1huWjI2Q0N6ZU0wNW02dFQ2SVZram56aHdmTUpp?=
 =?utf-8?B?YnlKdWgyd0RzWVArTGVsVW9ZVTRpdUtsdTdUSFNMS2hwQWZrQzNaL25hTll6?=
 =?utf-8?B?SXZtcGdkYU1iakczZHFPbzJoOU9pdHZYb05ZTDV2TDl3VUg5S09xNzcxbHlw?=
 =?utf-8?B?bGhpMkhCZ0hpVFRhY05rV0RMV20rQS9vNUY1Y01QT1RJa01SS09EOEdZOGJR?=
 =?utf-8?B?ZENUZjNoZ29Bbmw4NHBEN215UTg4MHpXUHI1NUwrT2hsSWpyWDNpa0RwckVX?=
 =?utf-8?B?TzB3Q2pYTU5mdmsvS0hOMzg5MDR4d0tQNlpyMEZMV3lpUytrM2Q0Q0lmM0NK?=
 =?utf-8?B?SGxyR29KRndRdWxYRXo1a0M4UXlDMkhQcjBvUXdaZnhsU1VsaXJnOXQxRUp6?=
 =?utf-8?B?YWY1MkxNQjcxRzdZY0s1NENNR0hKZndCeDk3Vmc3SGxSb0JXZFNVbFVnaWhK?=
 =?utf-8?B?M0lTS0FKdWNjRlcwVmNRU0FKYVh1MTE4TXZJQWdZMGlKMnVkUVZPSDRVUGVx?=
 =?utf-8?B?T0w2cm1UcmUvQWFpOTFTMmdFNUtodk96NXE4YlNDMlFOZm1UaEZsUzViSkZE?=
 =?utf-8?B?YUp1bDhvM1hCSEdQSEpBTVF4aFpTenZkWUJmK1pQeFpsdys2QVRlVmNJRlVj?=
 =?utf-8?B?NG1HYURHdmU1OVY4Vkx2Tll3M2MveHNxK0hUbmI4aU1UYXJpOHQxWFhTTHRZ?=
 =?utf-8?B?WWZ0VjBidTZkS3E1MkF5WjBiRHh3ZElSMmpCMGswMnhaMWttRmNoMnBydmIx?=
 =?utf-8?B?eHlLZ2ZkaktUZ2NLUnE2cHN2Wlh1S3U4bHFIeExMNHBuS2ZucWU2RzVMektq?=
 =?utf-8?B?UVovRkh4U0tQTldJc09vZStKQVh1Q2NqdjlMR3I3a0J4NFJIYzdJYnFDSUZQ?=
 =?utf-8?B?QjUwWTA1cExOOEVqVnNXV0IwZkxvd2RZcGIrVHBHTE9HNGZqTlRPOGtrT0RH?=
 =?utf-8?B?Q2luY3FkbjZlQjVyZXpMUDFGbHAxYi9YN2lsTWNsSHZNcEJtR3JuMW1Uc0dE?=
 =?utf-8?B?aFYxSmJuSUFacTcrM01WMWluSGp3UkEzRlBUU3JkbVprZmdSZUVNZjR6MzFJ?=
 =?utf-8?B?WlpvNTIrZlV4TDhEU2dzNWV3dkpOSkEzNlZtZVJaTzlWZEE2elQ3RE82VjMy?=
 =?utf-8?B?bDlkRThwblZ4WHdKSktacVc4ZWxEWnpQV3ZLbWxpNGRDaUVGeE5qSUhyUUJN?=
 =?utf-8?B?TktjbG9HYWdSZy9ZbXhDM1piaWFQMDRoNjdrQWYxTDBmNTZpTkZlVzBrakh3?=
 =?utf-8?B?M2xoZ25nc3Ivdmo3c05zbDlCYWxhOHVCbHVCRE5MeURlSWdueFY4Si9mV2M0?=
 =?utf-8?B?em1LY3V1K3Z0eUY4THg0SUVmRjljVDNqQkpaVlF0RjhudE5OWWVwNXppSHYx?=
 =?utf-8?B?WmczdloySVZkdE1SZ3FHMUFuYzVhYkhyRGVaYXp5aDM2OGZra2RMY1JCNzdu?=
 =?utf-8?B?cjJMbFBCaHNOUTAzL0hkWXh4eFJhaDBtTXhHSkROU3RLbThHVGphVnpwWUpT?=
 =?utf-8?B?cFFld2I1SFRGWVBldDArUGZkaHJzYXdNU0JzZTIraUFEUHo3cXd0bmFMcXU2?=
 =?utf-8?B?YmF1a2lEQk5nek4vcERFdXJBUkdIbVRFOEdIaHFiQVpYZEpPVSs5NE0xZHV1?=
 =?utf-8?B?NFZXdTN1MnVKZWU3TjlWVDhUUWg1cUVHTlFxQU5aeTZVUXc0d21aejVlQmd5?=
 =?utf-8?B?QXVPODZGNGdpTzhEQ3JWM0VSV0pIdUVXKzFPNEtLRmdBNVNyWmdRRVp6TWlj?=
 =?utf-8?B?aXRxSUxNNFdSTWpCWHYyQ0lCalM2d09ZR3k3eGpxTDRtTTBjS3NMbXVtcGRW?=
 =?utf-8?B?VTVad09YQjVObFJpeUxuNXIxRUx0bWZHR08xaXg2dkR3TWVnV3l5UnVVaGxP?=
 =?utf-8?B?TlNmVmNDcmR6a2oxV1N1Z213L1NpamxsWS9mUmxvdS9WYSs5bmxnMmlyNWV4?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b812bee5-6ae2-4962-09f7-08dbef60027c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 15:46:24.3201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /P5usjhsHN4g/0ywZIa8T8lvxyNKEIfQmjR34261pjTXa7VEZMYM7JIiTsBfLMxjzCitSWjgbtvzLl5MSylIYvJGM35sTb0DZuIPHa19lhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7795
X-OriginatorOrg: intel.com

On 11/25/23 00:08, Sam James wrote:
> GCC 14 introduces a new -Walloc-size included in -Wextra which gives:

Nice :)

> ```
> netlink/strset.c: In function ‘get_perdev_by_ifindex’:
> netlink/strset.c:121:16: warning: allocation of insufficient size ‘1’ for type ‘struct perdev_strings’ with size ‘648’ [-Walloc-size]
>    121 |         perdev = calloc(sizeof(*perdev), 1);
>        |                ^
> ```
> 
> The calloc prototype is:
> ```
> void *calloc(size_t nmemb, size_t size);
> ```
> 
> So, just swap the number of members and size arguments to match the prototype, as
> we're initialising 1 struct of size `sizeof(*perdev)`. GCC then sees we're not
> doing anything wrong. This is consistent with other use in the codebase too.
> 
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
>   netlink/strset.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/netlink/strset.c b/netlink/strset.c
> index fbc9c17..949d597 100644
> --- a/netlink/strset.c
> +++ b/netlink/strset.c
> @@ -118,7 +118,7 @@ static struct perdev_strings *get_perdev_by_ifindex(int ifindex)
>   		return perdev;
>   
>   	/* not found, allocate and insert into list */
> -	perdev = calloc(sizeof(*perdev), 1);
> +	perdev = calloc(1, sizeof(*perdev));
>   	if (!perdev)
>   		return NULL;
>   	perdev->ifindex = ifindex;

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


