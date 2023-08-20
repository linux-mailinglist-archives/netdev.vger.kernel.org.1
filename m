Return-Path: <netdev+bounces-29170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A224781F05
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 19:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301C51C20627
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B426C33FC;
	Sun, 20 Aug 2023 17:30:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A89256D
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 17:30:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F414D3A98
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692552593; x=1724088593;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TGZDj5q2xquz/cT4jvDdccVMwmwEdQi3VYbUw/CB7lM=;
  b=D62eNbNS8NbIb2stBpUjRDaSaD6vjLovSocNPfRXaS7SnNKSjAcGwBtK
   Zt3npp5OCw/1q2HjZ7uQ82cjG4yxf+BK/zNN0mHW3bGttlWtZPDmq68Z/
   QqtkefI4lKW3wyCDYxG1RVKbJ+TGqmx5Yu4OMbzL1zMs2Rq6TWKMrFzsC
   UoABDeeR3xkNLrH5AfgHaLLUXtyApVYq4nIKxXVZSohumAXoDAfSEax4Y
   eUcN0zoMBK7Gu8VjjNvtnDaEnCwGmYfNJgXsyDnt0DoX1GkzN53+4SJUl
   XikpXDOCUh+f4t3bnkN9etnx5nEQFhdDEe9Y8TUmeDoF2TqPDC+SZwuvT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="370868530"
X-IronPort-AV: E=Sophos;i="6.01,188,1684825200"; 
   d="scan'208";a="370868530"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 10:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="879254408"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 20 Aug 2023 10:29:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 20 Aug 2023 10:29:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 20 Aug 2023 10:29:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 20 Aug 2023 10:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpIDnjZkDCA8ZfG+Asaj34S46YPN5m0+BmW7C6ZCQ5u3JgCrytyCGA6Chb4ErW9J0kazsR9Kou3f9uo3iM0wkvEI1NT7cb8tmzz4b6dj+4qp3AIlalLViJ86uM0S71Sll7H9yC7idc6S9iYjpqcshIDjq2CvSL+Iie/95Pu8ZJp9Hyq5W3nNsLBtHV6AvSgMzlVg/qZCazGeWD9YQK2LK53IJnkBWAc+nzExmOjlSnTt+1H0p48UAKjjVIikJDZ0vl9zYss1G2jyDmXtLFT2X/FC+kduoRyEWW36SuklCo85CRih8+tctYxM8SfANUleBFT2SoNy+xPnhSidqWKY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX2okpWTvZvlOwps9Wxk6ABR2m/YAouA5ZttpcutNTk=;
 b=kYPC1I22q+dYCQ4Ht66iECIqF4QiKBTluNqSzin3onotZ804ju+ErBxw2hrYQAUpJ6UcGJBuQL07n1XLe2tWfbg1NHyufyHDHBQXe32YX3BEn5plQ5t+Byn6AoqD7F4k9i+gAKNbtwylemCY7PEeJGsQD0or8w0B+c/w3atS5xI5Gy2iVmFb7WHCpeK9olEGQZJTDtL7vnxaUOHySSDfP3JItX/eVYd2dPPqWLZrvKAgpM5cBsH71Qa/gZSZfnVu5KvK+ADuPjg/IHUstcywf99pEyLnxkttEEUc088P3D1abOL4LDE7s5M1YJzg/6i4dsNwSynD91Auj8F90oQi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by PH7PR11MB6883.namprd11.prod.outlook.com (2603:10b6:510:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 17:29:49 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::7349:947:dc4c:fc8d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::7349:947:dc4c:fc8d%4]) with mapi id 15.20.6699.020; Sun, 20 Aug 2023
 17:29:48 +0000
Message-ID: <12016e19-58d7-26d0-6964-0057435e84c5@intel.com>
Date: Sun, 20 Aug 2023 10:29:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-next v2 2/9] ethtool: Add forced speed to supported
 link modes maps
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<pawel.chmielewski@intel.com>, <andrew@lunn.ch>, <aelior@marvell.com>,
	<manishc@marvell.com>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
 <ZOIm8TJz/ykcI+PR@vergenet.net>
From: "Greenwalt, Paul" <paul.greenwalt@intel.com>
In-Reply-To: <ZOIm8TJz/ykcI+PR@vergenet.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:303:89::6) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5140:EE_|PH7PR11MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f997f59-c8b6-42e7-1101-08dba1a30dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8u7PH2kmjFzq/pT+ASuF2rOIGi49L54OU6gdnmWNlp2zuGnIaO/HF9u+ICCcM1D9j0GH9q5O4/XZg+STgZ6FLDN03kUXleSLcLxVwTlfLFU4hOZUpf66YkOuKfb4VdfTW7xuMXptEHJvC/A16RGgNdn6oMfJBn9/6xWvbuwhv1ze2fXUM6ZTHRD/ayESqwmd5+59sNNIG80AvIskwZNBB6q+1MCXU1l1fQG+vASkNMGmXm7o2LyIyDxy1l/SW1R+siFxhvH3f4OKIHKN2SELoBCE57c+nNuU8aHJ7KMUwawmOsG8MDNtyX4lcT8KsvD2iVnqK4mC7Opw1n2yXFkS4nKEunnNJp6/R+ERdcG1P8wyn5ASNql4FBaYHBKuGjkELQH8TusZR4JyN4gWvJI4YWbCrUztFfzxIJbvF3w0DSO7W331d8zINQin21IRo4NyNpHu2lsY54tzdMZDcvXrFDCyarRMhbKF1OszbKEqRTeXGIt92XOUuvKAgMzBHx1uDERURXw5MRzs2nOIkZSC/XWChoaYX3mUQr5CxuAACTm0YQqlE2QTo+m6MVS/7Ou6/Ep7v3t81UHUBt0OKu8fHfIXfx/gKhD1Po4fqMxwpIfz7tg3ENwVPbjtBRTUKqK1iXQcK/ZERUWnTh5kk+OxbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(66476007)(6916009)(66556008)(66946007)(316002)(6512007)(82960400001)(8676002)(8936002)(2616005)(4326008)(41300700001)(36756003)(478600001)(38100700002)(53546011)(6506007)(6486002)(45080400002)(2906002)(83380400001)(86362001)(31696002)(31686004)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3g0UWdvQVRxbVJyUysxUzVXd3NZV0YrUHdpUmRvOUJnUGxwejRPTHlzbDJw?=
 =?utf-8?B?T1MzM3NOSW45dUlHdUVYQWo3eVdLZUk1c3IyQ2NqaGZpSEIxVHBKaTRoZnRL?=
 =?utf-8?B?R0ovZm5oRSt5YXVFdkx0eSt1RVpib2VzdVBVMDhxdTE2N3FKeTlNSnlKakN2?=
 =?utf-8?B?V29CMVpuUnpIWDltL0NKaHJxQW1UOVFOQVhIT2RiZjRaY3laT3h0YXVFWDVM?=
 =?utf-8?B?WG9HNDRyVzhPYk5aS0VoRmZzbzA0enJIaktmZjBmM04xMmtmcnpzTTU1bW0x?=
 =?utf-8?B?UklxWlkyeTdmRklCYVNrZjUyQ3NPRTZITi9zanBMd2RQVGMzRW9SOUNHbldr?=
 =?utf-8?B?emdUUVY3NlV0KzI5WlRTT1hUY1k3NWxxa2RIWGZBanMvcHNNV1d0L1NPQjFm?=
 =?utf-8?B?dHhYVy82NDVUTDd3bTdCMzhOMmZ1SXRKeGt3SkpLMlM5SUY0MTQvTlZnVEMv?=
 =?utf-8?B?VzI1UzU4eVRaTGZ4RHdPc29hQjk4YTZYQytmdEMzNFJMTTNwbDE2ZlBGaWNT?=
 =?utf-8?B?WmUxNFc4TnhabXFad2x1V2NXTklNbCtFWXZvWENodUlubUtoL0JLMVQ1YklU?=
 =?utf-8?B?NVl1M0J6NlQrbUlIbFZlZnBoeS93VTAxRkhTdHptdWlUTVhMWlFNckZYQlhV?=
 =?utf-8?B?c3dSbzJXOUtKdnJVK21xVUtmZ3N6U0tQeE5pbmtoM3VPMWlBeUlZSHNqTlUr?=
 =?utf-8?B?RExLZVBLUnFKdnc0WmJURUhjTDVJYVFuY1hrdWk3dThQWGRPMXZlajYxV0Vz?=
 =?utf-8?B?dlllc1lKa2xrY0JqTFBYdEg5OWhuNk9DZDRlL0tnUkxmMWViNld3OTB2Q0NB?=
 =?utf-8?B?WVFHNHF2YU5VejRVSHI4YXlKYW9QY2FzMHZBdjlKOTFKTWlIK09UV3FDb3B0?=
 =?utf-8?B?N2tSQ1NLRTAySkRWTDRxNGpFZDcvUk5lZy90V1JxM2pVZ0Z2NzdYZ1cwU0k0?=
 =?utf-8?B?YXpxbTJJcWFoT0poY2hENk14bkhUZmp4OGFoSk5LVCtnM2Y5d04xamJlNnov?=
 =?utf-8?B?cFY4TEN5Z0FOV3dGVzZSWjE3UnpSaWt0N3FNZGdOZGN2Q0k1cmtBQmk1UUNt?=
 =?utf-8?B?UWJiVVRLR0xhUGJuNDZRQXVzaE9JOTZtMU1iYjVXLzdNb0x1S29LQ08vTVhh?=
 =?utf-8?B?bGNDUmpZdElRZ2Y0TzNDRGxPVTVYTU9oazh0OENhNnZzOHFVTVdmaFlkYWVl?=
 =?utf-8?B?bnBRUGVhbEdVVkZ3NVYvMjdheTI5OXA3WG8rVXhJUTYyYXlxa2wwelA3M2hK?=
 =?utf-8?B?MjNkL3QzWlllN1dsRHhtd083R2hWVVk4OVArWjVFWUVhSWdKd3FhaitISTdK?=
 =?utf-8?B?azJ6MzBvM1h4aEcxS1dJMW1ISlJCMFpOS2lDZ214ekVGM0ZpdmV0R0lVS1l0?=
 =?utf-8?B?T3ZtZHZ2ZEsrSVJJZm9GZWRwVTVZVVlWYWNiSkNxeFdzU1JleEs3d1NHRjE0?=
 =?utf-8?B?YVJ5cjJYeWVSKy8rMlFPVUNrbVdKTSthN0FoTUtFYkUzbG5PS0M1RTBOUFYx?=
 =?utf-8?B?MGdCbW9pWFNPMkgvRUYybU9kSGoxZ2xOcCtRTmVxL0tVWGN6UmNRR1V6YmRl?=
 =?utf-8?B?Z01qNlNQM0E0SVJpSjBTalZaaSt4djA3WFYyRE1sMC82eENSTndjcmxXbndx?=
 =?utf-8?B?STM3ZFVXbnFnWURCMzJGeXNUYm1hUGFuTnBCSkdrVkNxam1zL21ZeEZhRyt2?=
 =?utf-8?B?aUFqTGNzQjRyZXpaTzMzckhkalJVSzlnbUthUFpCaTlLWlJDckZ5dms2TjdL?=
 =?utf-8?B?bzROK21QTkFYc2dDR1o4Y2N1NjNjOW1QWUd1NUNqNHI2eUQ1b0lDckpSYkl6?=
 =?utf-8?B?RDd3V0xQYkdOWUNpYTcxcE02M05nSlpBUkhieWxLV1pZQXZOK2FwZXc3d2RU?=
 =?utf-8?B?emVDNTI4dTN6Y2dJcWFGQnRUSCtxZDdvWVd6enFCbTNjallSc2FEaW9TcE91?=
 =?utf-8?B?dms1NGhuS2JCTkZGVDBqWGFEOEVBWEMxRHJTYWsxeUwyVldnK293NS9TNjI5?=
 =?utf-8?B?b3RuUkZuTVYyaXQxS3dyRitpcTkzOHZwS1BJWldSOWVGNWxBUEhkSnJIaDNa?=
 =?utf-8?B?ekpvdU1PaGU4b0VzOHhGUUJMSlpoRW55SWQrZll3SmdLY3FQcGdmUnZKQWh2?=
 =?utf-8?B?Njl2MXlDRkpVbHNzQitacHZnMGR5RUlNKzdmNHpmMjVUZ0IvOFRkR0cwV0dM?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f997f59-c8b6-42e7-1101-08dba1a30dd4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 17:29:48.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIkrXYMXn78eQQquA7JiOhW2b1aK7R06F/zKRaUEKsucyEVxpqEyijth7vUgpFZj2XGdiiNa1lZcKWXmWg1tM+dDBKHK5kx/vXnzpuSe5bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6883
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/20/2023 7:45 AM, Simon Horman wrote:
> On Sat, Aug 19, 2023 at 02:39:41AM -0700, Paul Greenwalt wrote:
>> The need to map Ethtool forced speeds to  Ethtool supported link modes is
>> common among drivers. To support this move the supported link modes maps
>> implementation from the qede driver. This is an efficient solution
>> introduced in commit 1d4e4ecccb11 ("qede: populate supported link modes
>> maps on module init") for qede driver.
>>
>> ethtool_forced_speed_maps_init() should be called during driver init
>> with an array of struct ethtool_forced_speed_map to populate the
>> mapping. The macro ETHTOOL_FORCED_SPEED_MAP is a helper to initialized
>> the struct ethtool_forced_speed_map.
>>
>> The qede driver was compile tested only.
>>
>> Suggested-by: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
>> ---
>> v2: move qede Ethtool speed to link modes mapping to be shared by other
>> drivers (Andrew)
> 
> Hi Paul,
> 
> thanks for your efforts in adding a mechanism to share code.
> It's a great step in the right direction.
> 
> Perhaps I am on the wrong track here, but it seems to me that the approach
> you have taken, which is to move the definitions of the symbols into a
> header file, is, perhaps, not the best. For one thing it will end up with
> duplicate definitions of the symbols - one for each object in which they
> are included.
> 
> For another, and this more a symtom than an actual problem,
> a (W=1) build now complains about symbols that are defined but not used.
> 
> ./include/linux/ethtool.h:1190:18: warning: 'ethtool_forced_speed_800000' defined but not used [-Wunused-const-variable=]  1190 | static const u32 ethtool_forced_speed_800000[] __initconst = {
> ...
> 
> I suspect a better approach is to leave the symbol definitions in
> a .c file, one that is linked in such a way that it is available
> to code that uses it - be it modules or built-in. And to make
> declarations of those symbols available via a header file.

Simon, thanks for for your suggestion and I apologize the warning wasn't
caught.

