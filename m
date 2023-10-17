Return-Path: <netdev+bounces-42056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106DA7CCE4A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFD22819CD
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 20:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE64A43105;
	Tue, 17 Oct 2023 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+l9ne/8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A232E3F9
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 20:39:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A71592
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697575140; x=1729111140;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nPnJUTqoLJErGckhDs+EE61Ay5iwsXlIneKul5yQE2U=;
  b=m+l9ne/8aRiNBzfD8bh/6VUJnvus88f1hQN6fuTLF0i+my6yCKL089G2
   uzDX5A0YDBJ69noCpbsaF+pKp1ba2Hno+VWQgyMmhIwEfvWj++fPZgScf
   vp6modfON1sbCDHEzmixmpm780h2ALfOSacNw1hz0MI8MkuwvIOCo8qsu
   WCXy+rQMwHgHfwCUvxfoRQDqaioq17QI/sIoFLPtgy5J+3sl8oTznjg/t
   26IIPKrsAyfCoc5+qm1Zzx1hZQ5vcTXVSlJipuQnwSZREc3VfSbsHdQGw
   EeqNlAuk05cKiKgrPHxv0KiKDOkBuoEifTNqCkk5Erw0cBqruDy4xqV2o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="416970013"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="416970013"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="791326507"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="791326507"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 13:38:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 13:38:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 13:38:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 13:38:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 13:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHl1UdLXHF52nMvp5Sj8bMWqDFB7B34PFi8bRatFs/zFhujEcujhtQOjiyhxXN3ymbdKy8aLUooEep7Lni1dPKM/FJ4xuKLe3QEaDQ3b1no9jTInEGpF//50kAtPcw8g72Z1pA53s2WYqG7/ZjbnHBSgeenCvOh1c83yqDhwExmQb1AaCBujR/ns51GxHFvqyMgwuNh0/GBpYdnK4UCGC4nfEpya1hGNZIrBvE9/22pCd8Uk1uRqiU/S/1E8+65a3B+7okeJc04Ee7vJcX8UPu4cf863yoa3W4isurZNDkclSDuVTDkKheWpy9QT12cn8Q4uH2g2ssgehCuVqXNeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TU7g8pylq7V+u3HKy7ZxHQNoVT9VOWAJGEYR/ZTinGE=;
 b=FqJR5Mdecy26RAXtnDIKAGk7QhZwyPAc5LGagGqyb4ZNDf6S5SUeGvxajShP5b9BLnndI2PcZtCBn9/wT0XMJHMR4YxZjjW87O8pyM+Umm4RYM3koy3gnLsrJ91jlTxiv7b/8KdZfILYSvuNjE5aa1Rv/ZwtqbLuzn06kLrLv7EQELFX0CZg135n0wG09OflbefAYwiPkSXeO9BQZG6P9PnNJguufXl7WmMroXMokr+WdrKhNFlxXvVJ9cUcy0I19+epvAz1tOgB0As7aTgdECkh+KCw+Z8bU/ASdfmUB8n3eFXTwSixRmAIgZArsSeMeTuEa8XmcrjySO+NWEsdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by BN0PR11MB5695.namprd11.prod.outlook.com (2603:10b6:408:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 20:38:54 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6c8b:a948:87:796a]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6c8b:a948:87:796a%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 20:38:54 +0000
Message-ID: <0d054523-f724-1c49-a942-0a51f413c3a6@intel.com>
Date: Tue, 17 Oct 2023 13:38:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 2/5] ice: configure FW logging
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<jacob.e.keller@intel.com>, <vaishnavi.tipireddy@intel.com>,
	<horms@kernel.org>, <leon@kernel.org>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20231005170110.3221306-1-anthony.l.nguyen@intel.com>
 <20231005170110.3221306-3-anthony.l.nguyen@intel.com>
 <20231006170206.297687e2@kernel.org>
 <835b8308-c2b1-097b-8b1c-e020647b5a33@intel.com>
 <20231010190110.4181ce87@kernel.org>
 <a810ade6-b847-28fa-6225-5f551a561940@intel.com>
 <20231012164033.1069fb4b@kernel.org>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20231012164033.1069fb4b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|BN0PR11MB5695:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a8b43b-a132-41e5-bc44-08dbcf511469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCujRinL5LnhkZnM66wJxDZT3CKZzgzUtLvGoomXkHTyoP+sQmO2yFXTdNb71OELzX//stoQoSNxCcs/td8Op7qjUEMzuef7EWN2IISs+MyyECUV7NauT/cn2TvQLYiNsedbVY8DFLcDZmEQGJQc04/8NjfjDuAhlszCH14iBrr+/M0H3Us1j3AkqUCUIBWX9sMRHB/mm71Ibj9EvXcFayuLsMs9GhF02gA47wO/wfuA9j/mudrl6s406Uk4VjK4Ic37YGATpXIo9qohK3o87R09Lh+zq9byBHHQz6nW50BYKUbP8FjKJXNBiGfwXkhoCGM/Yx04u4Nx2eI6qRztv5VeH+48KzpnnUvHLwHd/Mxzf5S78F1e+3og6u42zG8CzPn7lBWs5a3V9kyJSLZeSZ0tpva417QFxPofjz/A5ntMp1ttIw1Fi0uriZLGgWMW2qLPpvFZE+x6zKL05nMqrqVXiMpr/H1OCh/cEE6hN/+HgUnFoK00VhU0T+pgNLW+oVXfETvr8d6bIk5hf+StbUat5+LTm5vm1G5JeNC5hsOesxaoWfbMG98ROj7Y/WVxzFLLh2e/N/+sLx311t4WMmDeFD8ZlBIorygQg/eS19AQmmNNveGpQEfIEH5xfX+VvirQuraxwqPQKmpOwGLmpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31686004)(6506007)(6512007)(2906002)(4744005)(5660300002)(4326008)(8936002)(8676002)(41300700001)(54906003)(66476007)(66946007)(66556008)(6916009)(316002)(6486002)(478600001)(53546011)(107886003)(2616005)(26005)(38100700002)(36756003)(82960400001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VlQ1gvdkxZR29qdjNOVkJRa2UranlWNzZweVExTmNRV0FmeTZuL0RrN0pj?=
 =?utf-8?B?MitQcUxtdjJhVEdFb0JlSWpsRkkxWGNzT0FYa2lZcjV3Y29nWDR6R2F3VmRo?=
 =?utf-8?B?Z2piaytZY2lyakdaK2xScWdvajRmeEpBUDJXb1U5R1RNSFN3UHI4Zit5bmFX?=
 =?utf-8?B?NmtFdmlYanEvN0FiWXlNRlNrM3ZLOGVsOEFUZEQ1OVFkSzVsMjkzbzZKNDVH?=
 =?utf-8?B?TUVhbml6ZnBMTmMrVHd1NHg5aThSN3lGQ1doV2pKUW5hU2lHVCtUSkRFVFYz?=
 =?utf-8?B?Rk00R3luU0lNRzlDYmJzKzRBcTVhMzZzM0FDc3lYb0pXNlM5d0hvNno5T2VM?=
 =?utf-8?B?dGoxTmk5THNweTNMOFdHT1ZpNGo2dkxSRDRSSzMzUityU0hmQVQyL3plNUVL?=
 =?utf-8?B?QWJxcXBIUDgvTmtwc25lNjhyc2xua1JPYkFLZWNoNXpDZmRWQ1F4Vy9Xdjlx?=
 =?utf-8?B?dEVuRGRmdS9KOWRpMW1saEx3azRha1BpSkxBdFpmNUdPSGJKN0JiOFdBbjVN?=
 =?utf-8?B?YVZDVnFMNHJ3MGVmc28wUWJFbGY2dDQ5UTFGdmZmQ3VkUXZwRmhTYnpGWlIv?=
 =?utf-8?B?eHVDVnJoajh1dG45YVBnNU1EZjBOa3JOOVl4NnVwdG5MTlVWVXk4aytsL0py?=
 =?utf-8?B?RTZQaSs0a0tUNUpmR2swR3FheENBeVZXeDlpQzZaTXpVcmY2ZEd2RnliTU9C?=
 =?utf-8?B?RlpHV3JNNFhhNFV5RHNTZmE5WlM3dW0rQWJUQlJjVm9GSElUaktOMmFBalMw?=
 =?utf-8?B?a3l2MFlVS1EyWXU0QS8xM0tIaFRpK1lTRWUrditKRTRwSVhhQmlEUzJaU29j?=
 =?utf-8?B?YVI4ZWEyUDJMclFSK3hvWGdjWXFDS1hFRWpZcHIzdzJ3OG5vNURObHRxRlAy?=
 =?utf-8?B?akVVbU0zcHlkM0VCN1B1bXZUVlNXeTRyWWtyc3BOQWJZVkZDaDFKeDlsRUlx?=
 =?utf-8?B?cENBcCsrcUZLdlNncEtwUVVSdnltZlZNT3M4aGJMNUlJWVllTWk5QUszMW5H?=
 =?utf-8?B?dkZDR1d0YzRrMTk1N0lwbWFad0s0cGtEUDlhNzF3RUZxSE9QUmMxTmpjV0xF?=
 =?utf-8?B?TSs0RWNvYkltOGtPNkRITVNPc2hYUTd2dEs4SG1ZM3JxaExMNzRlOHdYakJm?=
 =?utf-8?B?cXkyb3lOT3NNRUkrMzZlbEJJTVJHd2VBWC9ZZk9RTjdER3B2N2F2YmZGemQ1?=
 =?utf-8?B?RURRanAyb2NlWkVMNjRYNHhITzZmclFhQ1h6QWNFdjNkMGpkSFFWaWFBZGVW?=
 =?utf-8?B?UmJiU21UWUk0cHl5SWFGVDhNdGpESzFlTlBlMnpzb2tYVVpkU1hDckRxUFhz?=
 =?utf-8?B?OFF3bytaaktvVml6ZmoxUXRNZTdwdEN3YnF6OTc1ZmlzVkZmbDA3WGU1NmY1?=
 =?utf-8?B?elNrd0FnSmpyZGFHYldXWGM3N2dYMkZpckJScnFUY2l5MDI1MU1ZMEZWeE54?=
 =?utf-8?B?SWNYWnZtRjZrWGMyVjBSRE9yenloU1ljdWk3TVJIcjVLak9ReWFyWGg0MEJt?=
 =?utf-8?B?c1hhOXIvTFRxUFFsUlZWeitBT3NyK2dBS0FUTlpvL09zbnZrNjZrL1hmSlZK?=
 =?utf-8?B?cmNnWlpEdFEvT2ZMTndsVWhXbE02bFIwS3FFUFk5SjVIZi90UmltMjlrVU5v?=
 =?utf-8?B?b0pGSk9BQ2lYdUtmNDhBSWRjckExVGtWOXJxek9YWEtvdnB2ZXVjTjhIbUha?=
 =?utf-8?B?TTRXaFpQMVczSVhXMWdJZ0oxOFlHUkxMZjNqK0hBVEFHSnJSUkt4MURWeTZw?=
 =?utf-8?B?Yy9qNFRWYVNVaThJUHlUWE96QUZVdmZwc241ZVBSVDJ0TCt0UVZQVUlEakRm?=
 =?utf-8?B?dlFZTkkzZnErYUx5aXBWQ2ttdEZ0ZXEwN0VuMVkydERjUVNxeGh5b1dMV2d6?=
 =?utf-8?B?SURURDNILzdiTDBIRHlGME04MzVnVldydW9XQlhUZHJtWHREOGs3KzVhb24x?=
 =?utf-8?B?ZkVDamRyNVRwclVDK1FLemZXcnJsQWx5enY5ajE4Z2VMelZxaHk0U1VPTWZB?=
 =?utf-8?B?bzd6NC9xV2lwZENuaEI3SHAvR0NTSkdlS1RrZ200b3RYdVdrOCtPMjFFTUk0?=
 =?utf-8?B?cVBScXBjSjdYeFFjcWZwbVp2SzJoYXRNcHpRYWhwOWNNTEpCUGNHL29jTWtj?=
 =?utf-8?B?bjZZeDUzcDgrbmUzbDZMWmlYMWpnUDNwSkJwZWlFMXQwMFdmR2FnNGJKZ3Bn?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a8b43b-a132-41e5-bc44-08dbcf511469
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 20:38:54.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hb9z2yBSrbtbCJg4Us+kBl5CIR5TLZksUdGxcCC1CTYX1Zay73iDGCVOYGpZVocQAcRlerul3csw+6vLgh9KFVt0+Xkej7D7cRWrxIpTR80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/12/2023 4:40 PM, Jakub Kicinski wrote:
> On Wed, 11 Oct 2023 17:40:04 -0700 Paul M Stillwell Jr wrote:
>> OK, so what if we changed the code to create a new debugfs file entry
>> for each module and used the dentry for ther file to know what file is
>> being written to. Then we would only need to parse the log level. Would
>> that be acceptable?
> 
> Yes, even better!
> 

Cool, I'll work on this along with the other changes we discussed.

>> My confusion is around what makes the cmdline parsing harder to follow.
>> Obviously for me it's easy :) so I am trying to understand your point of
>> view.
> 
> Dunno how to explain it other than "took me more than 10min to
> understand this code and I only had 10min" :)  Reviewers have
> their own angle when evaluation code which doesn't always align
> with the author's..

No problem, I appreciate your feedback. Hopefully the new patches are 
easier to follow. I'll also try to keep your 10 minute rule in mind :)


