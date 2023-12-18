Return-Path: <netdev+bounces-58692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F03D817DDE
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA42B23850
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 23:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94AE768E4;
	Mon, 18 Dec 2023 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGF0JZTP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950F7608B
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702940806; x=1734476806;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4phDGFKHBjOv0Z+JQUJFYyExfDr9JbmFq/aRyI6RPFU=;
  b=JGF0JZTPZ26jN6Y/oGpidPI12eL+MPp4Fd5aKgvfw1eWc9SOKJ3wUYmo
   0JVjWgQ7anPg2i0HImJ+yD+HIbA16oTS7IrSVo1Oiz9WmFnRQxL6G7HNM
   utWCQxhqprsrnndfay7WJzDtx2XLwr3+ckIm8r9gRq6caY7iloLL5rhIt
   fXxXLIwsKvleqf/gqOKyarqPwd+KiPymnSYf8hhgpmHAGCCc38Yc8Pizf
   DdCLKtrlYjXVQ7uoLnMcsrdjKWf+mPN0QiVvERYNYBlMti8ODUdtFODfv
   LLNjm3TaLqCW2BbfoGReV3MDLMg919INTEyJfzvqicaWnhdTFgc+mNg3l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2673123"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2673123"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 15:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="17366926"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 15:06:44 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 15:06:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 15:06:44 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 15:06:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBzt5bmz+AauvPmiWDgn77lY9vFcQtxOaeWkqL7KL/99kr4894BN5S5GhR3z1QylcrxJ//OzWznWWoMdC1dYF7N50/0G4QcWaLXuC3XOcTnDxd9ogw+dUnsqtIuEVLfGeETbzB12vQrenm9sXGZrp9k9OBFvKUsUcbw4Ii8MjgiNioWE/RtPgpsaOpzv20CSq8weACMab54Vu9cK6MI5c3NYV7RXF23qqCz1s10GsYdGHUFbggUtUHRjI2/ZsxEBNNTNTEnLgaDTlY6xFCtSES4ZzUDa+gf6Zg0NE0vp1s4dn776zg7rJyUxMH5coXWlKB/BMT1KZZTzG9CdVQxE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWAzucvsoI/mFvyUPoFlYINWvxEpu+t7dw4v3rzZC3A=;
 b=dnSScc0rnNVop06JknHiiYGWVzzJHPT0UMtziGf6XvPUlkg4JRLL/XbVFJfwM8fB07Db3HgOVRPKfhb3RBGzC1THsVz3srKj5D/tNnKxmU+y1tLxksv6sMCcvE6B4OJ42px360EFNlvBJKovkmfL2aokwPRUz7zH+NCjmtwo1up/7dQ0inXAz23nuGMuTjj2vRMFav0SLxSvCsGH2Ls/+ReX4gmk3JG1OL9LBD0jIsE1bjGWlWjv76Kg1Kt9sHtx53bEh9DWW4zGwP1oQA3NYPHpJ6y41VDAyZttyMp44cnQ1+pjgisQMC4zlGSLcD+1ffh1743G4zQgSHyMoyEw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CH3PR11MB7770.namprd11.prod.outlook.com (2603:10b6:610:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 23:06:41 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 23:06:41 +0000
Message-ID: <3ddf5201-5434-edc3-129d-113c1f6ee332@intel.com>
Date: Mon, 18 Dec 2023 15:06:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-next v2] ice: Reset VF on Tx MDD event
Content-Language: en-US
To: Pawel Chmielewski <pawel.chmielewski@intel.com>, Michal Schmidt
	<mschmidt@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<pmenzel@molgen.mpg.de>, <lukasz.czapnik@intel.com>, Liang-Min Wang
	<liang-min.wang@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
References: <20231102155149.2574209-1-pawel.chmielewski@intel.com>
 <CADEbmW03axMX30oiEG0iNLLiGYaTi6pqx9qdrLsR7DSC-x-fyw@mail.gmail.com>
 <ZXsyfFHcFnaqeWe+@baltimore>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <ZXsyfFHcFnaqeWe+@baltimore>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:303:83::30) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CH3PR11MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a8be64-f58a-43fc-4f22-08dc001dfecb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FN8IKjNpqtNfPjaxe7ldKy2fvdwyW65o/IpU1se9kK2o1U0e7qT2TdsjfuWfTCDjeBjpGNjbzaF1aP/28gltuMQh1Ny1WWcCcOiZZaj4wSvlYY3jEhwx5xp3NV66DJ8/Cnex5MVHM4QlSftrE62YCz2Oim96cLhBON1dw9cIUoAXOTPd750gv8ob2fUXEwB//7+sb8Wm97v8d7VOIQ8xxx/FMknebA4WDy3NgJ4TDslerhK7oL5qgAj6TpnuE3YAZeLDoZYo5BsK+02GeS3sFRxyFQ6SwvI+KfPsWg46cBCxHxXvQ+0wqjKEfwmLKga+4I0HDEU58kxuOJ0oc9kYHSFH3PbFhAWuAzQXKuq/eiZjUznHD1lNgAdn3IcSfqXrSFA7UwlFC4pFwTfm+QwujINm2I4Ss2DmvIjNv6Onz4LOu9yySzfgScyPo5h+Xr8VrRhnXQxygyRM8tjVhb5CPTaG4+/dxubjKxTK0Ge9DBUZanchmkVT7suuPeCVTvJ9ublK6Jvia5B99HD+KTLtA9iWzQuI6xamcdlieApexLsY8pCLyJREOucg9K/mMj53NUNI3EdQTtSuH0m75ak6iEHV+zZ2meT142ooPLDlHrv+Ed7x2s+B8l88oe5IuJw9ZgP9YunOX2XC2fp0tRr4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(82960400001)(36756003)(38100700002)(2906002)(41300700001)(31696002)(86362001)(31686004)(83380400001)(6666004)(4326008)(8676002)(8936002)(6486002)(2616005)(478600001)(110136005)(66476007)(316002)(54906003)(66556008)(66946007)(6506007)(53546011)(5660300002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHltUFFWZGloTUd5SHlYc1BXTHkzSTRiejB5dU1TeFY4N0l3c0U2d0h1Vjg2?=
 =?utf-8?B?dnlGdHNxVE8zMnVqNmx6OW9UcytXMVFrbndrbVdwZjBnWFd2emV3eUREKzlW?=
 =?utf-8?B?SGg3L2R1RGVvS0JYc21tUk9MMDgwR3poWmVhR2hYMHoyYTBYamJZQkljaUVh?=
 =?utf-8?B?VXNpbkx6cHBrRlpjN1FNL2hUdXU4bUFHZzd2RjE0TUxuOHh1bU40U0hpVnM1?=
 =?utf-8?B?RU0xRDVnTHZib1dsVWRsVVpiNjdCRVUzU1hpQTlqRkcrcDBiOGlrOTNUMkNi?=
 =?utf-8?B?RDVpZTNFcE9oUTZZVElXbXdreGt2R09PVDZ2Z0lDd2RERkZoN2NGcXQ3bUtT?=
 =?utf-8?B?d3l0OUIyVEJQN3FlS0syU0doaFBtNC8wY1diNFVpa2RMNVFoOURXcnVVMHpH?=
 =?utf-8?B?d0c5K0huOE9LUjdFRTFkRVY2S3A1bGtVdEU1ZkpObkdiVEIyOWNpbWZzNlBF?=
 =?utf-8?B?MHpPVUtsOG5KMDRPeXVUUjdTRnp0cnZ5aW9PZHFVbXBmcWUrR215cFUwU0xP?=
 =?utf-8?B?OWoyMWo1NnFzZmNneDFVYUlENHRXc3hnRUhKT0JxcFlRSDRSTmdlTW8wbU1z?=
 =?utf-8?B?NGFvVDV2UWVaWnhJWU9SdEwwaENQVmpPVzhOM3pCVG5RQ3hwOUthVTUrVEtJ?=
 =?utf-8?B?SzBWRXBRMlBiYk5CMXdPNW5XNFZWN0F6K1JOME9pdllXazF2cWlRTFJXb3Ny?=
 =?utf-8?B?ZThIN3IzQUpsSjNSVUs3R09FZmdkQTQ3aW4xNGtwam8xNHMzbitrMERZS0tW?=
 =?utf-8?B?WkpZK3dyUHJDS1Jsd0NUeUEvUHMzQ01oQzZpbEVOZTJkQjZwaVN4QU5nUkI1?=
 =?utf-8?B?V1JYdUFJSG5XUnZHU3V0MitrdnNNY1ZXYlkxTUg5ejY3V0JUcmRiYVZuNEUy?=
 =?utf-8?B?bVA1U0s3MWNWN0x0ZjJVLzFtUkl3dDI5bytWMGNZMHZobjFybTBsUlZzcEpY?=
 =?utf-8?B?U3czb2xVNytlY3dENXgvb0hIeFhOUjJDUHBYckg0UDlCUmIxZUNHaCtzcjha?=
 =?utf-8?B?cytTejNzSytLRW9YK1hZT2lLTHJyRXN6WjJ2V2xDTVVtUHBTeG1USEcreXNZ?=
 =?utf-8?B?RGE3Z3RkQlYyMUtweGptbnBodWcyNHVENzEyNHFId3U1ZFFBYXVVVUhqWFdk?=
 =?utf-8?B?YmdUTXUzQ0tqcjllMlAvR2FJZHVLS2VxK3FEU0xtR1h5d2gwK0FiaHVaU0VT?=
 =?utf-8?B?aTR1QUQyL0c3Z0RSaE9zR1dKUm5ubHZ1cEJvRnEyRlJOSkYyaldVTTgwNTkz?=
 =?utf-8?B?bXloMDNMc1BmZXJzdVA2R2dOdGFTUmVKelBMNW1UV29JaHVSdG9IOHYxeVd3?=
 =?utf-8?B?S0xNTUM4UFZyNVhZemMvN3YvRGttSUpqSWtYV2NBUFRhaGdIN0lLSHhkUDFT?=
 =?utf-8?B?VmJJNUNvaWZjY2ZrMzFoM1dZOHVYOFV5OFBDaGoyZnlkTno3ZWM5a0RwUmZr?=
 =?utf-8?B?cEFXV0U0RGJKVEZvcGJUakc3WUp5Y0w1emVzWnZTOGhHNXBSM2NSZ2xUaFpQ?=
 =?utf-8?B?d3pmN0NXTS91R3dEOC9rcDZCdEhVWDlleWRXSTdiWmwvSHgxM1RlR3RFb0VR?=
 =?utf-8?B?ZW92YTBEZkdyNkp4UWp2VDZQalo3NU5wS25ZaW9nS2NDQ2pYQzVoZmJScE4x?=
 =?utf-8?B?NzVlRW91QUxnWlAyYnJKbGovNjU3R2VhWVpReG9jNUFkU0tmV2VCWlVaSE1I?=
 =?utf-8?B?anlxRjU5b01vUnBZUG1HNFh3WERpc2lxa1JBWFFWaDVoQXpCckNSZi9Tc3E2?=
 =?utf-8?B?MGpqeUlTNENmTk50Rm50VEhwK0FIbnVwUnhmZTZvR3JZQXlVem9YN3ZjVXJW?=
 =?utf-8?B?Mld3RmFlbHR6Wm9XZ3lFeWFELzFVQTllTW1uclkvR0xKd3RNMTJNRkR0bFBL?=
 =?utf-8?B?OEkxZnFnNHJXVU9hU3RZMGVCNnB2Q0dlK0JPME05QklGa3J5QmJVR0ZZQUlT?=
 =?utf-8?B?VE5TZUhZTGp1MVNNTHB1bUdlTU54WEdiblUwMzViczhxWXFYM0l0WXpVMzg0?=
 =?utf-8?B?bEg1Y0s2WEg3WGJGZmhJbnpuV2Z3alBkOGtjTzBWWitRWDdtRWhuUG0wZFo2?=
 =?utf-8?B?QWRiOGI0R0hxRTRqblNSMTJzdzdxelJlOGY0eGdqVGJlZ3crRWozUWZMK2Iv?=
 =?utf-8?B?SGV3ZHdiL2ZZUWVXMmh4TlVzVmlEUXpGeWt2L1lCNDRwbjRKcmVZQWdVZ0RU?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a8be64-f58a-43fc-4f22-08dc001dfecb
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 23:06:41.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHibsqDDYSm5CWnBDnHsIqehjne+7lKEFW3U2xqkupUlZ6H8lPbZadhXkTcnt3w1O/EFjiHF48i6zCfD1VUMOMWPShsos3rxg7v7uPmdLIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7770
X-OriginatorOrg: intel.com



On 12/14/2023 8:51 AM, Pawel Chmielewski wrote:
> On Thu, Dec 14, 2023 at 09:37:32AM +0100, Michal Schmidt wrote:
>> On Thu, Nov 2, 2023 at 4:56 PM Pawel Chmielewski
>> <pawel.chmielewski@intel.com> wrote:
>>> From: Liang-Min Wang <liang-min.wang@intel.com>

...

>>> When Malicious Driver Detection event occurs, perform graceful VF reset
>>> to quickly bring VF back to operational state. Add a log message to
>>> notify about the cause of the reset.
>>
>> Sorry for bringing this up so late, but I have just now realized this:
>> Wasn't freezing of the queue originally the intended behavior, as a
>> penalty for being malicious?
>> Shouldn't these resets at least be guarded by ICE_FLAG_MDD_AUTO_RESET_VF?
>>
>> Michal
> 
> In some cases, the MDD can be caused also by a regular software error
> (like the one mentioned in commit message), and not the actual malicious
> action. There was decision to change the default behavior to avoid denial
> of service.

Michal brings up some valid questions. I'd like to clarify the 
expectations between how the two should work together before moving 
forward with this.

Thanks,
Tony

