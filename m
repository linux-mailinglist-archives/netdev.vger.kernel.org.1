Return-Path: <netdev+bounces-36259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FBB7AEAF9
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 13:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B1C92281A99
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E422E266AB;
	Tue, 26 Sep 2023 11:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88C107B9
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 11:00:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9F210C
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 04:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695726020; x=1727262020;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YXvL2cBDx03YBBAyrHDKNQKXY+drZuToj8bqiOubLzg=;
  b=P1Mo2o22/OtKNApQVVxH2Rgd+cYlRqlQsKiry+3ESZcNznfJ6jHc/pDy
   sLlNizQPB5IlvTOHnLZfmDd/vBZtoEOYTSUnpYHZzaFkEJaMe5Nk+B8Eu
   RG4Ofi8YHkcYqJV5SyPm+H7kWrLSlPi2cZx66WyxtNW0YoWE0fFPYH1VG
   i+4dsSSJLftSbJOTF224y3+86fpzIXkDCljX4oe2C74EPUA5nEHXAebHD
   VGhYq6+jmyIwp8qBLp6GDtPkRwqm6/kkkLKk9DaQzVUgKuZacvX8LhtRA
   SV8i1HZJyc0Xo2tb1UVQeWuhEkckbqJT8T9pp0vvEpK/Pkx6f/PA0FNwI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="448037856"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="448037856"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 04:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698429269"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698429269"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 04:00:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 04:00:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 04:00:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 04:00:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 04:00:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTQYHQPGtC0SzziazsBmoXZKsA70M/OOmw0YC/r8g6GoBt3bj3qWvqO+7fTdsERB82grCOV+XGtzyHnsEe36NlEyZMPDZ732UZutokH9YBAmgQFikkvgeZOnraN/VkGIDyChrmFP1y9vljM2E9W2lnrtYvaCFpMC1YPOo70SleAMM01FT6JC9ibMnaOEEIpLmJ/5uB76URZRyDqQcs9usDhGl2PiuA8D218MEa88tA6v2Cfwe0sgBGSCoodU+8aOTfTw7y4IJshtq6cyWlAwq5UyrXfWNr15HKU1qaIKRS9fCns79kArEJKDRv67GcwsVK3Hi7uxzFxV2Ve1pNGgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6Cd4MdmuIgBMDdHNnpF17H6+mCI2LeEzmVktjS++ok=;
 b=XBLWPZfb1jXmQptBonHTMSMXYYk0Lq6f6GUI6BacBCFwDcQXhh8k0pV2TXvic8Dt3oGut7pbrRNUeWo+uwqrP/Y/VmqnnfEasHIvn+Xoxxa2srcaQyRkxVeEc27NXH5TIMkGXIwPjEZtFg0Crv3GmfXbL9ONEbKBQKtMizECVLjk9EpU+6rbieoHPkvBUS4yP8LVC4ZOrI+tdZpp3C6Ise2eE96jHWPCSAe3KHavxWIVfXjkYSeIMtuS+dHX4bA9R2SUQkbbDgw2Pxxrzn+Hgt3OHdtMrE3eC1h9wTRc/DScJt9s2GMfomfXaEuIOnsEr4QWqfev4MOZnw1nK0EEuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB6725.namprd11.prod.outlook.com (2603:10b6:806:267::18)
 by DM4PR11MB6334.namprd11.prod.outlook.com (2603:10b6:8:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 11:00:14 +0000
Received: from SN7PR11MB6725.namprd11.prod.outlook.com
 ([fe80::a06f:fff0:8cf5:7606]) by SN7PR11MB6725.namprd11.prod.outlook.com
 ([fe80::a06f:fff0:8cf5:7606%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 11:00:14 +0000
Message-ID: <d7bb8b96-f347-45d5-81af-4b7b422908c8@intel.com>
Date: Tue, 26 Sep 2023 14:00:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] [iwl-net] Revert "igc: set TP bit in
 'supported' and 'advertising' fields of ethtool_link_ksettings"
Content-Language: en-US
From: "Neftin, Sasha" <sasha.neftin@intel.com>
To: Prasad Koya <prasad@arista.com>, Andrew Lunn <andrew@lunn.ch>
CC: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "lifshits, Vitaly"
	<vitaly.lifshits@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<jesse.brandeburg@intel.com>, <edumazet@google.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>
References: <20230922163804.7DDBA2440449@us122.sjc.aristanetworks.com>
 <40c11058-5065-41f0-bf09-2784b291c41b@intel.com>
 <04bc5392-24da-49dc-a240-27e8c69c7e06@lunn.ch>
 <CAKh1g55zm4jcwB34Qch=yAdLwLyPcQD0NbgZtUeS=shiRkd_vw@mail.gmail.com>
 <f59f9386-8c65-4e56-b77a-82366e2d2821@intel.com>
In-Reply-To: <f59f9386-8c65-4e56-b77a-82366e2d2821@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::19) To SN7PR11MB6725.namprd11.prod.outlook.com
 (2603:10b6:806:267::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB6725:EE_|DM4PR11MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f7dcc5-371e-4ac6-f6c9-08dbbe7fc2bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0OUfg5N5TXiza8p356kzpoxXXuQnrhyuiscQsURE5qCzZrGKLdnN/oOQ9USmvxjX7MddIc/crkxEQrhshK5FQ3AbP3pbWBFLqiTU5AWKQsdsjq5gLrqqSBV8ntpinZF33sFEuW3YPFIrfoYxKp69AAixbSueLXoANdOmbxvMCoT5IWN8i/skLYhVzxe9DhDSoQ9pG1J+c6SFaS/MhOt0P+dOJWmAhSoNWy8xTRo8qsqpBY9rS7Ef26X1tIUnZqbJZkltRIQFrA3UFuMBH/Rx6ZScDHx2qXPRIMT/K0or9bSGBqFugZWQoREO5y+tjkqdLDnuBuTMAMafA6Wg/hAeDZAMZPXbF71qjB5cJH4yUcEhOHNPI4BiqnZDa0yQU98n1mO8L3LkP6tcLAAlp50pJbR4qXXFxzEBc2oV9wcP0K+yZXO/td8lChGJ94IAJp7bkH8dvc44ghSMWMmRVOPwJIWw4PHVnulDXARz+/DYlMapRfmQEM7XHZe4ccodOJp7Qe0npWafbfu8OyJq4xeZYjU63BgwW4RhtJgv7PHTrLVJ7aJf1x8PsQqsIjeWVJfRLikGpyMX3NEG/hDuBLGo3DhWQNsM1wuXInl4D6jkG/FHf4V01AarletgNuJ2mjt9NrTEYFpSfDVuzhhdkvtHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6725.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(31686004)(53546011)(6506007)(6486002)(478600001)(6666004)(966005)(19627235002)(38100700002)(31696002)(82960400001)(2906002)(41300700001)(83380400001)(2616005)(6512007)(26005)(36756003)(86362001)(110136005)(66476007)(316002)(5660300002)(66946007)(54906003)(66556008)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ris0UlNZV2oxK0ljVmhVeFc5QWFOd3lITlBYaGY1QzNvQVUrYUdWME1QRFlo?=
 =?utf-8?B?N0tQaDRMaE1xTVczZkF5SjRqMXRBVloySGNQeVpkVDJ2WlRWeUlPVk9BaWlF?=
 =?utf-8?B?Qm1zSk0vWi9ndWRuYWEwbGwzTHhrWktmRDIwTlJJQnNEMjJzR1VtZFNCM3Fv?=
 =?utf-8?B?b0VHeE1QQzM0Y0dLYUFMWms3UDJWajNEZG1zbzM4SThySWtnZEdhR2tUSVlH?=
 =?utf-8?B?UG9oNGJGNnV3bHRLZGRZbGpsYjBpN0VXVWtDc3RxTDl2MDNPNjZncGNQelhw?=
 =?utf-8?B?bW4vSG5kUVlxTjJHdnZ1UGk1L25YanM3Z2ZCeEZTUHVqVHVXR3RXYWg4Qk1D?=
 =?utf-8?B?SXRnY05PaHFKRGRJL1Irb0lHV2ZGbkJJc3NpMTdLZ3F3Tm14clVQb2NSYndL?=
 =?utf-8?B?VWZpTEZhTDRURzA5ZlVjcVRtN1ZLVUo5WUNSdmVTU3JmaHhTUk9vcDFMUFNw?=
 =?utf-8?B?cmUwRnVscVdwQ29EZFVVRllOV2NHaWZmbVN1clhVRGI4MUg4dWo2MEowQTd5?=
 =?utf-8?B?d1BTaTNHUmg3bWIrUytJVnZVL2JUVENLMjVSTWVubEhlYkFOY1gwdDlkZC9W?=
 =?utf-8?B?L3AzTklYWEdNaWE0VVA3WXlMYitRMUFVL3RlM2c2b1hrMkJUUVdOdEh3UkVK?=
 =?utf-8?B?Q0Z0QlpBVXYybVl1a1c0ZXpnNzhoeVBTSndweGJsSXQwVUVTV0JpSUVsbHdV?=
 =?utf-8?B?cHdva3lRU0duSFJDM29uSmIzWjkvTUVSNUpJSUhoRTJ2cGloTkdCcU5oZ1or?=
 =?utf-8?B?K1l0Q0l0eWt3cUpEdEdBTEExL0pPNkx6MjFKMUtIeGxYdUVUTXE4WFUySUlD?=
 =?utf-8?B?UUhKTHM2MUpLVkNzNnAxK01JYTNmN1kwQlFhMTdTNVV6QSt5cFJRdTEzSkE1?=
 =?utf-8?B?RWhUdzlXZlhTMFBTcmwxdkhOMU9UdzczNkx2eXlSRzdGME9neHVLSXpIWis1?=
 =?utf-8?B?S0lCeDc0VVpGc3Q5ZFY4ZVBEWUQ0OWNvelJ1K282a0hPZUJwcGdlSTJXQ2Q2?=
 =?utf-8?B?TmhBSVN2cVR6eEI5OEJObG1zRGdTVWJxeVdWSjI0Z2lMR1Flanppcml4YXlr?=
 =?utf-8?B?M2pjdDJHK3RQK2R6eTIzdXpvTHJXYVJKN0MvZGplMlhsMkd4a0RubUNJNTlw?=
 =?utf-8?B?b3hZK3REbU9PRjBCUlZ2SkZ3bHJxMTJIekVseW5iNEpGWkFrbGdtOVZ0MlFi?=
 =?utf-8?B?ckZqbSsrZ0ZZak9wM21uU1JRQ25WNHhKRzZFZGJxMWZzODh5Vy8vTzRyRXVY?=
 =?utf-8?B?eWsvVmtROCtrRVdPZEZ6TWJRY2JlN1NGQVRqNnZiK2NnbTZRK0wxUmZ0dVdF?=
 =?utf-8?B?Umd1N2JjVU5LQWVQMmVqdzlabTljNm1XVjJkeGh0NEpucStPL1pyWWl5QWxv?=
 =?utf-8?B?bndMMW94aGwwajNjTVNRNjRYUFpKYXM3em1YdTdic1o2T252aTJMZWVPWXZO?=
 =?utf-8?B?UkZCUTFrajZiK3dZRGVjd3dPUnBLTFQvOWFoQUt5UmxyZ3hWRlRaYm1ReFJk?=
 =?utf-8?B?TnI3MzJSME95S21kd0wrMXpGVmlVdmZiMWR6RCszWmhPSEFyNWhxZGNQV1Rq?=
 =?utf-8?B?N0FBMTBZaWIrSVB1SGZTT0NFb1NXMzhFNG4zREh3S0lGWE1QY0tWVG5XT0Yw?=
 =?utf-8?B?S2NLTVhySTdRZDkzOFpLTVo2WDR2YmVhWVNpSWtWTyttc1psSExEaTZ4T3lq?=
 =?utf-8?B?LzFtdmZUcFV5SHVyWkpIQkptcGhkN1FMQXNCWEloZUZJR3hQQkRIbEpEQVBX?=
 =?utf-8?B?ZkhENHNiMWRCcDFIZ2kxbmdkVDB5Wk5aWWRBRWFsYjlUZVlwRUlyQTZ4Z0Jp?=
 =?utf-8?B?Ni9EZmJSM24vZjN5dmw2cnhBc094dU1MRGZmNDJOazhsKzZqaWxpUFdEQlBm?=
 =?utf-8?B?ZXl2cjFKT3FGYnY0UC9ta09ucDU1eUk3Tk1helZnaW5xdGxtUXhkdTBobnZW?=
 =?utf-8?B?MmtDN1ZZMjRGSHZDV0hFSnh2NmNranhiRmZkeVdNNlpZczhRUkFTKzRNbFZJ?=
 =?utf-8?B?SXZhZkhva0ZvNnlyandMaFhUTTNNUXdnOFZHMGZjaFd3ZXNuaWJzQjFJKy93?=
 =?utf-8?B?SGZnemorOEtWOE9MSVlpWnhxSm9nZXZCc1ZJVGEyakprQVFOdWMwc2Z1VTRj?=
 =?utf-8?B?dDZuWXorNHU4SHdsMjYwYy9YK0VjRGVEUUZpL3JjVWpUZmt3QytCYlNXRUwv?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f7dcc5-371e-4ac6-f6c9-08dbbe7fc2bd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6725.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 11:00:14.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iEhFb469+YXscwYbcZmda3LLtJ3dYgjjKqIvNL6tGFU86kb/ZLNaNVEaRgfLVWE/5PSnKliR0vasnkyv3EQgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/09/2023 8:23, Neftin, Sasha wrote:
> On 25/09/2023 22:40, Prasad Koya wrote:
>> Hi,
>>
>> Here is the ethtool output before and after changing the speed with 
>> the commit 9ac3fc2f42e5ffa1e927dcbffb71b15fa81459e2:
>>
>> -bash-4.2# ethtool ma1
>> Settings for ma1:
>>          Supported ports: [ TP ]
>>          Supported link modes:   10baseT/Half 10baseT/Full
>>                                  100baseT/Half 100baseT/Full
>>                                  1000baseT/Full
>>                                  2500baseT/Full
>>          Supported pause frame use: Symmetric
>>          Supports auto-negotiation: Yes
>>          Supported FEC modes: Not reported
>>          Advertised link modes:  10baseT/Half 10baseT/Full
>>                                  100baseT/Half 100baseT/Full
>>                                  1000baseT/Full
>>                                  2500baseT/Full
>>          Advertised pause frame use: Symmetric
>>          Advertised auto-negotiation: Yes
>>          Advertised FEC modes: Not reported
>>          Speed: 1000Mb/s
>>          Duplex: Full
>>          Auto-negotiation: on
>>          Port: Twisted Pair
>>          PHYAD: 0
>>          Transceiver: internal
>>          MDI-X: off (auto)
>>          Supports Wake-on: pumbg
>>          Wake-on: d
>>          Current message level: 0x00000007 (7)
>>                                 drv probe link
>>          Link detected: yes
>> -bash-4.2#
>> -bash-4.2# ethtool  -s ma1 speed 100 duplex full autoneg on
>> -bash-4.2#
>> -bash-4.2# ethtool ma1
>> Settings for ma1:
>>          Supported ports: [ TP ]
>>          Supported link modes:   10baseT/Half 10baseT/Full
>>                                  100baseT/Half 100baseT/Full
>>                                  1000baseT/Full
>>                                  2500baseT/Full
>>          Supported pause frame use: Symmetric
>>          Supports auto-negotiation: Yes
>>          Supported FEC modes: Not reported
>>          Advertised link modes:  100baseT/Full
>>                                  2500baseT/Full
>>          Advertised pause frame use: Symmetric
>>          Advertised auto-negotiation: Yes
>>          Advertised FEC modes: Not reported
>>          Speed: 100Mb/s
>>          Duplex: Full
>>          Auto-negotiation: on
>>          Port: Twisted Pair
>>          PHYAD: 0
>>          Transceiver: internal
>>          MDI-X: off (auto)
>>          Supports Wake-on: pumbg
>>          Wake-on: d
>>          Current message level: 0x00000007 (7)
>>                                 drv probe link
>>          Link detected: yes
>> -bash-4.2#
>>
>> With the patch reverted:
>>
>> -bash-4.2# ethtool -s ma1 speed 100 duplex full autoneg on
>> -bash-4.2#
>> -bash-4.2# ethtool ma1
>> Settings for ma1:
>>          Supported ports: [ TP ]
>>          Supported link modes:   10baseT/Half 10baseT/Full
>>                                  100baseT/Half 100baseT/Full
>>                                  1000baseT/Full
>>                                  2500baseT/Full
>>          Supported pause frame use: Symmetric
>>          Supports auto-negotiation: Yes
>>          Supported FEC modes: Not reported
>>          Advertised link modes:  100baseT/Full
>>          Advertised pause frame use: Symmetric
>>          Advertised auto-negotiation: Yes
>>          Advertised FEC modes: Not reported
>>          Speed: 100Mb/s
>>          Duplex: Full
>>          Port: Twisted Pair
>>          PHYAD: 0
>>          Transceiver: internal
>>          Auto-negotiation: on
>>          MDI-X: off (auto)
>>          Supports Wake-on: pumbg
>>          Wake-on: d
>>          Current message level: 0x00000007 (7)
>>                                 drv probe link
>>          Link detected: yes
>> -bash-4.2#
>>
>> with the patch enabled:
>> ==================
>>
>> Default 'advertising' field is: 0x8000000020ef
>> ie., 10Mbps_half, 10Mbps_full, 100Mbps_half, 100Mbps_full, 
>> 1000Mbps_full, Autoneg, TP, Pause and 2500Mbps_full bits set.
>>
>> and 'hw->phy.autoneg_advertised' is 0xaf
>>
>> During "ethtool -s ma1 speed 100 duplex full autoneg on"
>>
>> ethtool sends 'advertising' as 0x20c8 ie., 100Mbps_full, Autoneg, TP, 
>> Pause bits set which are correct.
>>
>> However, to reset the link with new 'advertising' bits, code takes 
>> this path:
>>
>> [  255.073847]  igc_setup_copper_link+0x73c/0x750
>> [  255.073851]  igc_setup_link+0x4a/0x170
>> [  255.073852]  igc_init_hw_base+0x98/0x100
>> [  255.073855]  igc_reset+0x69/0xe0
>> [  255.073857]  igc_down+0x22b/0x230
>> [  255.073859]  igc_ethtool_set_link_ksettings+0x25f/0x270
>> [  255.073863]  ethtool_set_link_ksettings+0xa9/0x140
>> [  255.073866]  dev_ethtool+0x1236/0x2570
>>
>> igc_setup_copper_link() calls igc_copper_link_autoneg(). 
>> igc_copper_link_autoneg() changes phy->autoneg_advertised
>>
>>      phy->autoneg_advertised &= phy->autoneg_mask;
>>
>> and autoneg_mask is IGC_ALL_SPEED_DUPLEX_2500 which is 0xaf:
>>
>> /* 1Gbps and 2.5Gbps half duplex is not supported, nor spec-compliant. */
>> #define ADVERTISE_10_HALF       0x0001
>> #define ADVERTISE_10_FULL       0x0002
>> #define ADVERTISE_100_HALF      0x0004
>> #define ADVERTISE_100_FULL      0x0008
>> #define ADVERTISE_1000_HALF     0x0010 /* Not used, just FYI */
>> #define ADVERTISE_1000_FULL     0x0020
>> #define ADVERTISE_2500_HALF     0x0040 /* Not used, just FYI */
>> #define ADVERTISE_2500_FULL     0x0080
>>
>> #define IGC_ALL_SPEED_DUPLEX_2500 ( \
>>      ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
>>      ADVERTISE_100_FULL | ADVERTISE_1000_FULL | ADVERTISE_2500_FULL)
>>
>> so 0x20c8 & 0xaf becomes 0x88 ie., the TP bit (bit 7 
>> of ethtool_link_mode_bit_indices) in 0x20c8 got interpreted as 
>> ADVERTISE_2500_FULL. so after igc_reset(), hw->phy.autoneg_advertised 
>> is 0x88. Post that, 'ethtool <interface>' reports 2500Mbps can also be 
>> advertised.
>>
>> @@ -445,9 +451,19 @@ static s32 igc_copper_link_autoneg(struct igc_hw 
>> *hw)
>>          u16 phy_ctrl;
>>          s32 ret_val;
>>
>>          /* Perform some bounds checking on the autoneg advertisement
>>           * parameter.
>>           */
>> +       if (!(phy->autoneg_advertised & ADVERTISED_2500baseX_Full))
>> +               phy->autoneg_advertised &= ~ADVERTISE_2500_FULL;
>> +       if ((phy->autoneg_advertised & ADVERTISED_2500baseX_Full))
>> +               phy->autoneg_advertised |= ADVERTISE_2500_FULL;
>> +
> 
> It will introduce more ambiguity. ADVERTISED_2500baseX_Full (is bit 15), 
> 2500 Base-X is a different type not supported by i225/6 parts. i225/6 
> parts support 2500baseT_Full_BIT (bit 47 in new structure).
> Look, ethtool used (same as igb) ethtool_convert_link_mode_to_legacy_u32 
> method, but there is no option for 2500baseT_Full_BIT. (since i225 only 
> copper mode, the TP advertisement was omitted intentionally in an 
> original code, I thought).
> 
>>          phy->autoneg_advertised &= phy->autoneg_mask;
>>
>> I see phy->autoneg_advertised modified similarly 
>> in igc_phy_setup_autoneg() as well.
>>
>> Above diff works for:
>>
>> ethtool -s <intf> speed 10/100/1000 duplex full autoneg on
>> or
>> ethtool -s <intf> advertise 0x3f (0x03 or 0x0f etc)
>>
>> but I haven't tested on a 2500 Mbps link. ADVERTISE_2500_FULL is there 
>> only for igc.
>>
>> Thanks
>> Prasad
>>
>>
>> On Sun, Sep 24, 2023 at 7:51 AM Andrew Lunn <andrew@lunn.ch 
>> <mailto:andrew@lunn.ch>> wrote:
>>
>>     On Sun, Sep 24, 2023 at 10:09:17AM +0300, Neftin, Sasha wrote:
>>      > On 22/09/2023 19:38, Prasad Koya wrote:
>>      > > This reverts commit 9ac3fc2f42e5ffa1e927dcbffb71b15fa81459e2.
>>      > >
>>      > > After the command "ethtool -s enps0 speed 100 duplex full
>>     autoneg on",
>>      > > i.e., advertise only 100Mbps speed to the peer, "ethtool enps0"
>>     shows
>>      > > advertised speeds as 100Mbps and 2500Mbps. Same behavior is seen
>>      > > when changing the speed to 10Mbps or 1000Mbps.
>>      > >
>>      > > This applies to I225/226 parts, which only supports copper mode.
>>      > > Reverting to original till the ambiguity is resolved.
>>      > >
>>      > > Fixes: 9ac3fc2f42e5 ("igc: set TP bit in 'supported' and
>>      > > 'advertising' fields of ethtool_link_ksettings")
>>      > > Signed-off-by: Prasad Koya <prasad@arista.com
>>     <mailto:prasad@arista.com>>
>>      >
>>      > Acked-by: Sasha Neftin <sasha.neftin@intel.com
>>     <mailto:sasha.neftin@intel.com>>
>>      >
>>      > > ---
>>      > >   drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 --
>>      > >   1 file changed, 2 deletions(-)
>>      > >
>>      > > diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>>     b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>>      > > index 93bce729be76..0e2cb00622d1 100644
>>      > > --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>>      > > +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>>      > > @@ -1708,8 +1708,6 @@ static int
>>     igc_ethtool_get_link_ksettings(struct net_device *netdev,
>>      > >     /* twisted pair */
>>      > >     cmd->base.port = PORT_TP;
>>      > >     cmd->base.phy_address = hw->phy.addr;
>>      > > -   ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
>>      > > -   ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
>>
>>     This looks very odd. Please can you confirm this revert really does
>>     make ethtool report the correct advertisement when it has been 
>> limited
>>     to 100Mbps. Because looking at this patch, i have no idea how this is
>>     going wrong.
> 
> Andrew, yes, I can confirm. (revert works).
> We need a process fix, but it will be a different patch. Also, I prefer 
> not to leave upstream code with a regression.
> 
> ethtool_convert_link_mode_to_legacy_u32 have no option to work with 
> 2500baseT_Full_BIT (47 > 32). Need to use a new structure for 
> auto-negotiation advertisement, mask... (not u16). We need to think how 
> to fix it right.
> 
Colleagues, let us check the option not to use the 
'ethtool_convert_link_mode_to_legacy_u32' method. Looks like we can 
suggest another solution and not process the revert.

>>
>>              Andrew
>>
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


