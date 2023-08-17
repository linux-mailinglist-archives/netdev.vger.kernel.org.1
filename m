Return-Path: <netdev+bounces-28590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC4777FF7A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BC21C214F2
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB551AA79;
	Thu, 17 Aug 2023 21:05:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C4F19890
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:04:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0C43595
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692306298; x=1723842298;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dRGJKjLn8haWFxO2XRqotwjEB8/qCgtscZElXJxWvfw=;
  b=MVc1j/M2ozW/L/tNxvA/d0IRnqvje8FlB5qlxTu0yTFuqh1jlK7SnC+e
   ff7me8xZKByflY16oFcUW7eX4eMEhyA4WldhDS3XW1ietb9QL6bIAnhv5
   ZqFmuhn96AgXJWHiTcGP2VASjBJel/GL2+rVAJllJE+s0I2bQjIBmTh0p
   MzheIbWvetYHFGiQawilCz5RlyvPHGOjK2QkupVHRgQPK9TIkBFf1O68V
   7IzQOhGp7H53iWw1qSp83Gfki4TC+PTzjVm16LT8QSv3BrugdJpq4aw8c
   2P6xu0qSDWhQZz2QABzpnXQr2BttG++o010pOaby8AKXg0CdXX4DBgKyU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376686743"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="376686743"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:04:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="908573342"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="908573342"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2023 14:04:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 14:04:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 14:04:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 14:04:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 14:04:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PogO3xSJp+2MymlzODYwbklu7g61LK+oYNbtygSpzAK+zZ29U8LSDPAnRonafbVlNJD9iiDFQrr90xY99GqPsjIoO34hzLHDvwW/3UBnHAZL6aDFgl5fN4J2WYQhpRr+gkzlw9dzUpbQ9riQUuk4UbkO/cnzTOCvQedv94AIe93RrC9X95F0I+uix4W95lSEOnpxgxY9Y7FWm3WUbvL4j5Q87NMXk4IeCP8w8p/A+kue6B10VVYzJV1Zuk34E7qyQRIsxbX//xl5Mqp3xfmJZCLhrtk7LFkQy5RruPbYSxcM2auI2ww4LOeRy4i7XwGGJKlPhshLI6JfEPtmR8+R5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q13kZO1AjE4IeQAKCGFWn4O2U6+oM2yX0YmgCI7sCYQ=;
 b=EwCeaHm1g7zbKQ2b2oVmcICsQG8j2lREshWOHT4BiGjHDjeZ9BAkii81YtrNmmNjQESHaCPeVkzHZxT6qR/cPGdFZxglumpuiiCwz2s5Makc0zdTs70Z/mYKld6b7CRYbuc33NFwwaYgMkCH/J9FAGWJtpSRlxevFbZ2KZWGdtHdlaHkvBZEuLPYye0fFmznFfnIFkNwgMPTij63+zpshcN9+zWDVd/I7dlatzp0WowMXG35CHNL0IhyqhpjgmAsAMn6wy+R5e8Ev/SRy6ud5t/UE+x5pCtJ9MWuy0Dfz9pYeVXCwjKsyDl37uGG4Z3UKuuPsuOh6Ns99rSJvAsV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CY8PR11MB6914.namprd11.prod.outlook.com (2603:10b6:930:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 21:04:54 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::91f3:3879:b47d:a1c3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::91f3:3879:b47d:a1c3%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 21:04:53 +0000
Message-ID: <6fe694f8-9e5f-f1cb-848a-64ae11b324d9@intel.com>
Date: Thu, 17 Aug 2023 14:04:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 04/14] ice: refactor ice_vf_lib to make functions
 static
To: Leon Romanovsky <leon@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Jan Sokolowski
	<jan.sokolowski@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
 <20230816204736.1325132-5-anthony.l.nguyen@intel.com>
 <20230817113424.GM22185@unreal>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20230817113424.GM22185@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:303:86::18) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CY8PR11MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b0e0e8-7cfc-4c86-7271-08db9f659a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2AWTq+ugeE4vOnKqnadozq/3lU6LD/TUI51vOJyBM2A/23EzW4E96mfooknYixYHamI6NP5uAClt8G6PVj62UwZmj+2ne5G9kiSkVQKiGNcwAPVyid6vaU4cIX3CL4t6WhGVZekJBh0f7iEJJ8G4vx45L411+dCahepvgZGo8ezTjbIH2/KzlUOeOwZWQcEpR4avQ2afTzRh0UnfOpEVWXTZQqis/PzajH+4c9r7i0nzIERPn0tyQw3M1K27yYxVzBnAFr+SCwS4ZjYD72xVooi09VP0WI2nfthjXUGIOgo7sC03ua2qswgQH12PXt8FloRk6FTqBm6/feD7TXV91+d3QOt4KDggHOQpX7TG4Iah8yAU61mvz4Ls0WfIeh5eyNAdTSmbil4qBXev3lh0DI1WJ2wPKnCcZ/oOgEzQAm1iT0f6d6pW7DczxuFoFxqzYojusxiKAP8Rf69yen4wajajUWyJnxhQ4vJP7i+moCf9WqCtV0FxjRoJ8s2a2GnIu+8oyh4n/Z3ktTp8iVFWnKelvClNMnslNTT8pHKIKDOps3bn9SuEUFWl8cwYznBSpORlHOsdFVeFYoNs52E116AvYPi6NatiiN+Ewa+w4AeOiUIx0m7icS34UpBEoApp6DIVBBYL4kEDfQepBUq6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199024)(186009)(1800799009)(36756003)(86362001)(31696002)(31686004)(83380400001)(8936002)(5660300002)(8676002)(4326008)(4744005)(2906002)(41300700001)(26005)(6666004)(6506007)(53546011)(2616005)(107886003)(6512007)(6486002)(478600001)(82960400001)(66476007)(38100700002)(316002)(6916009)(66946007)(66556008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRWcTNTZFE4SmpUZ1pYWUFJbzF4R1JiWGNkZWZwOG9uNk1DdUh0QUNmd3Fu?=
 =?utf-8?B?NngwNFFhUjgxNFU5TzlkWEE4Tk1RR1VnT202OVcwVGRiUHVZYTFURG9CYjBi?=
 =?utf-8?B?SUxXaHRzK1E1QjROVCtkVkpEc2prZVBqTGNlendRdEtVL2xtdzFOcWZudFhw?=
 =?utf-8?B?TnpHdlU5a2VjQ0dvU0JLWXQ1ZFRUdzYzV21QcEtPTjkyTlNwK0hhRVZkK1Y2?=
 =?utf-8?B?NkFwVFhWSkF1S2dTOW5sYjhZMkwxRmZIcnZxWDdWME1GN2ZUVnRWUUtzZnhR?=
 =?utf-8?B?Uk5KMkYwZ0piSHlkdTBsK1ZnL1dPVlF2djc4aGh0UzByUGdiQVJ0aVJ3ZjBY?=
 =?utf-8?B?K1VoQm82TGhDVVhRdjhGZXM2NnY1UzhVbm05eTRsVzFsVlV1UTNCT1RSR3Iw?=
 =?utf-8?B?cmtCOHQxbWNsZk1Ld2IyOWJHMUVWOGFkY05rc0ZESHNndFl0eldmVitpRG5Y?=
 =?utf-8?B?cjJRTzZzZ2ZiNkpqTG9lZ0xNa1Rvb2d2RXlXQUJyQXlldFBjaFEzc0QwekVx?=
 =?utf-8?B?M2NSdnphcTVBWGdNTjZYS0J4ZHYyR2hyMEEzWlR3QWw3VVpBTlRQRlhDMFd3?=
 =?utf-8?B?cGY0ekMzR0xBZHRXeFlEcjl6N0NYME92TEd0V3hTNVFLeElCZmtSNnlDcWdF?=
 =?utf-8?B?WW10MC9ob20wbjc4cVc2ZmIyazRqQVF2SzEvVjBHZjllNWNydll5MHlVa1lX?=
 =?utf-8?B?ZGdHN0wyNE5CRjZVZ2I0ZlB5MFlmK0NtcXZEU3JaSjRZRm0vTkYzRmx3eGkr?=
 =?utf-8?B?cWdvdG5vZE00VENHdVkwY3NrRnpjZzNxU3F1VHZJZXUxaTN1MWt6T3hhMHpt?=
 =?utf-8?B?MTV5bFBDelJlS2xSV2F2MnZmRmFDZGowa1lBb3E4N252RDNSWTl2elVwWWJW?=
 =?utf-8?B?TTFKOXZtS21PblRkZDRvbXBGZzlmbStRQldVSmthaDhmNUlQMXVzdXV1NFhh?=
 =?utf-8?B?NS8zWGV0MStyRUU3UlhsRkovZUpwa2NuVVNqNG8wQ0RibW1hYU1RQ1ZxZlZH?=
 =?utf-8?B?c3JVNE5qbmo5WklNb1RaV1doQW1HL20vbW10NjFxVXlxVjk4dW5iaEFWN0I4?=
 =?utf-8?B?NFIrYVJVeVZJcFVKcEFZTTJjU2d2UFY1SERaU0RsbmhoNnVsZllwTTdRQXpr?=
 =?utf-8?B?Smg3cUwvakh2QjJuTVZRSXQ0RCtHTW42S2d5L1JlMjFXL0ZDWXBQNmljSmNw?=
 =?utf-8?B?cHJzdVBSRC96UkVQTU14NzRwT0thRDJDMWtyV0d0VUpZR1lIdHRVS203L2Zi?=
 =?utf-8?B?WU9EbGRHVGdZaWZLVFZiSmhuWXZza3FIQXI5S2N2YkpvNm1TRHlVRzR5STRQ?=
 =?utf-8?B?QUV1UnQ1SXVRZDNZOENBYTFSUUI0dTgxSmhtRVdpUCsrWjhSSU94cUFJbC9O?=
 =?utf-8?B?S0g5OC9QTFVpZ25iTXpzUUtoS3o5MTFDbE8yNTJsaHNTdW1WYmoreWNHYkJG?=
 =?utf-8?B?V1c5MWU2RFFDS0JINEJ2WlBPTkJwaWc2STdWSkNlcjNGTndXTmhMY2NzdVZQ?=
 =?utf-8?B?SkFKaUlTTkN4NmFtTzN6czU0ZExSOTVWMWduTVI2YjcyN2pIWEtIWTZrdmFh?=
 =?utf-8?B?dStoWlM5aUZOZzhNVW9zVUlhOXpZVmpiNW4zTFZZWW5qeG1PSndoUHNTbERw?=
 =?utf-8?B?RUNhblR2L2hTdkY3eE84NFlMYzFta1ZhOXJ4Qm8ya2FqU3VZTU85Yzc1WWpD?=
 =?utf-8?B?V3VxcTdaZVhEMXZ4U3lQTVkvWUxRVmEwY1dBWEExZEJJK0M4dnhFSEV2WHFE?=
 =?utf-8?B?V0t4c1JkSXBMNHJUbVFIbVFIbndmSVB0MUNpOG9SUGJmYy95U3dQZXFQZnVk?=
 =?utf-8?B?YkZjZ3hJL0NVMUllQWl0VTN2OGtPa3I0TC9sbGxhTWt4UjVmNFZhcVJIZ2p6?=
 =?utf-8?B?SlZtWVNBVlEvQUU3YUxWSlV4VVMyVHdKZHVja2wxMjU1RWpMQUg0cklzMGV0?=
 =?utf-8?B?NktlTi9RbjZVZlU1cDVjNXdxRnBaODNDSU1NYTFWclJrWXJmOHdGSDMxN2o5?=
 =?utf-8?B?STU4L2t5dkZQaU1WYUN3ZXdBSDNjQ3ZmRnpGaVVuQ2hWWkZYR201c3NZQU9C?=
 =?utf-8?B?RG5UWHZabFFyVEtVNzI1QStLMTlXK0RjOEdPc3Y4ZS9vSVJjTHdoUitIbEs2?=
 =?utf-8?B?cDlCK3NYM1lQYXlNSVkvKzlZeVljVm9vQWdnT3cvY2ZCVU1CV3d1blU3cjFx?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b0e0e8-7cfc-4c86-7271-08db9f659a89
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 21:04:53.8318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gl03LFqQqoQiKEukG3lG9Ex+5akbCcyBfnq1+b/BKMKfEciCajX3h/DTU1UlwQMMrMmjIeYwrOSynSh6NZ4F98gYGiPrpqfZmjH63a2Zpnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6914
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/17/2023 4:34 AM, Leon Romanovsky wrote:

...

>> +/**
>> + * ice_vf_set_host_trust_cfg - set trust setting based on pre-reset value
>> + * @vf: VF to configure trust setting for
>> + */
>> +static void ice_vf_set_host_trust_cfg(struct ice_vf *vf)
>> +{
>> +	if (vf->trusted)
>> +		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
>> +	else
>> +		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
>> +}
> 
> assign_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps, vf->trusted);

Thanks for the review Leon. I'll add this change on as an additional 
patch into this series so that this one can stick to being static and 
reorders only.

-Tony

