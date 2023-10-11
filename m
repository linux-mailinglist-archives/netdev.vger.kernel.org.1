Return-Path: <netdev+bounces-40180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A287C6113
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099DE2823F9
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7469E2B749;
	Wed, 11 Oct 2023 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaOyFoQ7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3402B741
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:28:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28D0A9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697066927; x=1728602927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eyfKXHobGDSX8hNylTABfbRA/6+KKUj712uk8mmf97c=;
  b=iaOyFoQ7iT8/rjE1AhORmsAZrhBBADclvxkUGklHMm3oyVhLYUmKhqOW
   B9ozXxR3fQVrctc5E0mL3HVK3N6e0+Y0KgyDiy59TzMfz2fibde0yuDSL
   pIEZT4qLHn5Ycz9S6N8grZp8A/JZgMH5rPM+CIKT/iJ+Owvo19Xe8yVkn
   XNKveYHNQ6FgneLmU+3XLoQO+5uxgUoQFtudUa0y+RZbHcsPgIHpXWqor
   Wxan7LaerFTZbeGLbSSKexidcviqHUTCDbe81T2Cn9XnbgBCXk0kZA1p8
   zZsLmgucX/oYtj0E6cH39sIAJbwCDvlJPpWTXNaCAqxLq/uEJXwoJ4NbU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="382034809"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="382034809"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="730678743"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="730678743"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 16:28:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 16:28:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 16:28:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 16:28:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 16:28:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKb/wB/BaoMWcWUf5AhPODckmQLMbcq/hfhx1PhpB1A6/Md/6HWGYyWtPmIcDbMzCTNM/ESEmqAOeYWh6HN1m9EDez2svfkde4HcGzaBxDIBMfbNUJyTs2SwjLvs4377mTGerwQ4OiqlYuY5VLA26AC1OlKsdw7SDm+RUQtvl0qTPlCwA8BTy9JQqZm+q/1Hy1puDMDY/joGD6sVpfN05JEaahL2MZKsWO5ZLMK37EDeehgdDU8ImEufPSQMxQp+x4HtqSwWTepJyOsThYF/FokfWx+EPgAP5O8L8r8GalXR89Nj5B1Bkg5jI5NGZsybSHeEZVWYG+L5hF3ADK9FHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDHc1ETHFYps/Cb9R5MrDGgPIonJwOQNfhS4RaXmWZo=;
 b=K6V4inTL2i6Pbo5qrAfZGEgA8Rv8pyHkbM+9ObFpgDGEpEHWBVkAe+1ZMQJEhf6LCFBwK49rbbrCcSggPyrJpRfTHPxIXtyWxsfQjEbiCaZEbtkXn2tjveY2klZH1fLSVL+DkLOVJfkWuLOZpTR7shfEkH5U9vctPbcF6SnBT0uZycEG7hmL7emoJvzbjk2rhYCjuP6CHgsQtZp38efKywpXAkp1eh8Ta1g620RsHOV+6YCY8tVZBpNsSm0VWWWSF3DgPrzAHjT4AUeGa/4UR14NZ188oyRwT2MrAY6RmWuWjx4AeGqYiu/Kp2aQepTV1aokZDr78E7fQ+CGdMfMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.44; Wed, 11 Oct 2023 23:28:41 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741%3]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 23:28:40 +0000
Message-ID: <1e08c82c-d9a4-4d39-a4cc-3cd007e4242f@intel.com>
Date: Wed, 11 Oct 2023 16:28:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <sridhar.samudrala@intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
 <169658368330.3683.15290860406267268970.stgit@anambiarhost.jf.intel.com>
 <20231010191239.0a8205d1@kernel.org>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231010191239.0a8205d1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14)
 To IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f37d333-927e-43c7-cc0a-08dbcab1ccde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJkkRVrYzEj1OEGtYoNuw8yZu6IcYEe8Y9jrhoAmpQwNhyiSW0eiyvXobPavcx5B1bdeSKd858Oz/b6JhuihCHtuSwU3FjDokGQQUQ9I/m8gC7xbMAP9OpE1b6sNnHuDaOKpBB606N/s/IX4ZbhjemF22j/m6/Mz5cNTUU/zBLXYSNQn+/eQtT3x033cOTPhZ/2dDcrBS2J4IoNNlnAeT1r2UtNOOHKEVuTsX8/mXg8jg03CwV6ySO/jdxdUj2EQ3wtNzJypylIQoegXYQLz9iGAc4HW2pqfqDY2zOgwgQO3FmktB0Lp/icVf58P4hR6rF072+Igy86eB5qdfm+sZ0uHaGdRydCR3FgABMWnOq7Htx4+mCPnvQuYr1FYIMYF2uOkMJ8nbRsgsinkV5+V0qQeIbDMS2QCmVpTJJaBUSvjTZkJjefXbF9vaXeanEZsd6QhVD0061FuZJ8/xpsj9S0p1Ysp/jq/4W79iyFffUe3UihSLHIJ6+5CXdN03mN2NiRQfVRNnQ8lZWTb4XVjjAhw/zpLLOc1xj5eS85dhhQbDYCw3xeYc0dKs4QavPLsKRZ6PIfEV+lYUJxuUFzC91SbYB+khCizvB+5liJ25zkxzNpirur23fQsyP0h7R0lSPr61Wv20+uhdk6tMpQzJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(107886003)(36756003)(31696002)(478600001)(6486002)(86362001)(6666004)(53546011)(6512007)(6506007)(41300700001)(66946007)(5660300002)(2616005)(38100700002)(6916009)(66476007)(66556008)(316002)(82960400001)(4744005)(2906002)(8936002)(8676002)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjAyT3lyd2JXNHJPdUJLcUwrNEF4YTd6SE5laVFPWE9BMVVDdzUyVnJTdlNO?=
 =?utf-8?B?SnZmMXNzenlabFIxL0NheWVhbFpOSGNaMW8xQ1ROTFpBekZndEJMakVSaTRy?=
 =?utf-8?B?Y3JqeExLOHoxQndjbnZUVThab2lVc2VsNHJBeWJsQ2k3SUZWRzY4YkVxZmY4?=
 =?utf-8?B?djJKeGxueGlRZVFnU2QxaFgrMTdIc0xlaGZvVkFKcmovMG5xUk5jV2dTVURR?=
 =?utf-8?B?YW80dDNCREhTRFpkSXFhT3ZJQ1JGRTBtU3lMRlVyNVhDdlByZUxQL29nUU8w?=
 =?utf-8?B?WTRuUmJpcXFHZXRVNk45b0YvejRNUEszUnlxUk5HT3FEVSt4WXRwanJqTFRj?=
 =?utf-8?B?M0R6Z1JNVlZkRDlEYVNjVDFVSGtSOWlhbEl2MWhOeGgyVCtFWENOUlBnV2xm?=
 =?utf-8?B?aFprQkRtKzlvVlpGZXBya1lZSmlzS0VuOGI4UkNrOEUxcXF3djgreXlCVlF0?=
 =?utf-8?B?OWJkSWdmbmVKY1ROdXRGY1ZzbURBMmx3c1FmdzNCcStYd3AxYURaeVRSSHB6?=
 =?utf-8?B?VysxaWFDL1NLYTQrZWJhQ2xoUHRSMkZPQmNPRG9laFMwRCtOeCs0VXN6K0hJ?=
 =?utf-8?B?OWdYSzR3ZXZ0aTNvd0FRZFdTTmVGUHRnTmtlZlRLcWdHOXRxMVArWUViRnY0?=
 =?utf-8?B?YjlXZW1IakpPdFp3bU9TTFVqRjBGRllvSGtPWHZVRjh0ek16ZzE2aUFhN1RJ?=
 =?utf-8?B?bjYycHNmYmtON3dvcEx0Y2UxeUtDUVNyRW9MVHRXd0poWlNtR2RwK0NxWEtO?=
 =?utf-8?B?eURkRjVEUFh3OUt4eFhMM1Fab1U4ZGFTRWNyRVlZSUZuUTFqN2p3U3RiU1Zx?=
 =?utf-8?B?bk9KZjYwM0lSb2JmTE5uVitKMStqM2R5KzBwdlc1TjZJbzJMUFVrQXAyZGNQ?=
 =?utf-8?B?bUw2SnRxaWxBZEx6U1lhbnc3MzFMNGpRdmFBVU42UE4xODFmcWNKVy91Z0tE?=
 =?utf-8?B?QXJXdkcrS2RkT1lGRGVGRkVaem0wKzYxWWk3VWVXS0I4dXRyK2p0WGtsK2Fj?=
 =?utf-8?B?ZWhEeHl2YWxxRzUxMjJyUmg5enNuaUZ2Zms3ZkNzVEVxOGNpVlJWbjJZdVZ1?=
 =?utf-8?B?enRxQmJHZElWVWQyNHVoSFRleWlBakhLK3hvTE9JVVdUZlhGQURkcWZic0Zs?=
 =?utf-8?B?M0I2a3BtRzQ3MkJsUzlsMVA2MmtTWXRGZlRPTWJjRlgzZE9MYXg2V1JsUWhZ?=
 =?utf-8?B?ME52MHpPdTJoaGhEbEdlcGxjaysyeVI4RXoxbnhpQi83UytiV2xpdWdNOGNq?=
 =?utf-8?B?RENWYW8wa0Y3MVlkOFYvVC9XbG1EMWZlL0lKKzZNbTQydTVPanFPaEVXMlV6?=
 =?utf-8?B?MXd1TzM3ajFSNjhJYWJxUnRhQTNMRGhucXBVL0hwU0ZJc1ZqSkFvUmdlS3lF?=
 =?utf-8?B?RDhiQ0QvckhuQ2F1bklkZmdsYVhNQmVVRmovWGMyOW1lNm9ZYWgvbkMwclZD?=
 =?utf-8?B?QWtqZ0djY21sbkVGSHRhaTJudDZHQlNTVUNyVHV4WHBLQmFMYmRFbzlLUldO?=
 =?utf-8?B?VEhPbkk3cFEzdkVEbmF2MUdCTTl3YmJoYjdjdk9pZHZrNStaTVpZQ1NSZjY2?=
 =?utf-8?B?YTZ3bFFoYTlzSitja2E5R0JWYStIaEQ2UisyY1hCMjVPM3AyVTFwTmI2QUlI?=
 =?utf-8?B?SmY5K2RsLzNTQk5ERzJISGNLSHU4OENacjROMXBCZmV0TFF6V25lTzBqQ1Rr?=
 =?utf-8?B?OWk2SVozRS9xYlFuQVIwZkdSRkMrSm1SSWJNdzBWTlBzcFJQTE5LTXhGODBV?=
 =?utf-8?B?UU8xbkpzMElMQWZIa1MrUFp6SmZEKzlZNTRMelRROWxIbjl1TjlyblZmVjRM?=
 =?utf-8?B?WGpyTysrV0RYdW4vcUJGSVRzdnRtRUhaZlFlYVZBZHhpSDZ4S01ZUHhzdEov?=
 =?utf-8?B?Z3hTUFZjbmtxbFZQTm1JRXBNUmorNzdEb3FKRlp5Y3ZSaTNwL214aEVQZnpP?=
 =?utf-8?B?NTFhcHYyQlkvVzZzRTdDa1NVR3VBZDdKd2Zub2ZUWlB2NXJLNVMzeGN1Rmtv?=
 =?utf-8?B?cmhOQ3U5Q0QwSHltQWJOL1hDODZUa2F6TGNZeGpzbXRKbmZoYnY1WlVDaGt5?=
 =?utf-8?B?MHFZRklXbFBHN05panNERW5nR2JKbVZYOVhnb2UvUlRSTlhnWEVZcXFrdm1V?=
 =?utf-8?B?eWNHWHNFVVNSZHJnWkwyekhTUFdtcUFOTU1rY2MzMEJOTHZueW54UFo5a0k2?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f37d333-927e-43c7-cc0a-08dbcab1ccde
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:28:40.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZSiaM75WNA8SU6aN6p/35HXIIxc2bcPvLi/yLSBdg0FNcMBSKLYfIFmk/wfP0/8DwkkSk9QN3YzwN5ZddIEME24SmlsPTTYp+ZgHqjvWqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/2023 7:12 PM, Jakub Kicinski wrote:
> On Fri, 06 Oct 2023 02:14:43 -0700 Amritha Nambiar wrote:
>> Add support in netlink spec(netdev.yaml) for queue information.
>> Add code generated from the spec.
>>
>> Note: The "queue-type" attribute currently takes values 0 and 1
>> for rx and tx queue type respectively. I haven't figured out the
>> ynl library changes to support string user input ("rx" and "tx")
>> to enum value conversion in the generated C code.
> 
> Let's leave the maxrate out of this version entirely, please.
> Otherwise looks good.

Okay, will remove maxrate in v5.

