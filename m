Return-Path: <netdev+bounces-39759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFC97C456C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51E1281689
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1F32C92;
	Tue, 10 Oct 2023 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8GKklRk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ABB315B3
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:26:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7702F94
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696980380; x=1728516380;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bPi+C6gVLNO4nqlVqk5RY/wgZKK87n9nzHZQYmyiaLA=;
  b=A8GKklRku0QHR4LR1qZyDocYys0yHD0pu9K/v6doLrtBjLzxgHUPJSla
   GRMrJHWTsqVmaQBD9CKbMhI08L+BUVaCMGfBlqUOnjbN1Ls9iWB9IRwND
   XY4fqCy4TjdCArXkbjnXJQiSn/x19fCw5CjoBMla5WpAyYddr14+T4bvp
   dzGRZIqt0N480sr3KoPqzU4GMTXqXv+uuLjGBOY8AgEl3TwYThaNpi9zC
   CxUfBx5SKDuhmi7NafXSsQWqTIIW98N+ex2ur1c96tbcSU1tamyRIq7Aq
   5gYhsxZZ1JEsFLU/U6PUowoxDsychsGU4zdPpu1lWP4/y2J9qKeZtJ4Hh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="470801587"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="470801587"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 16:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1084989878"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1084989878"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 16:26:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 16:26:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 16:26:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 16:26:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 16:26:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH95PNLWoqxsgke8b53BUxXb/rNJffujm4062fMKsYZ9ID31bx5mOQfwVlpwFKJ6lya8tsX2W5/1fyX8+MjZmSRloiTskrjSh0RjWPOOVlL2qs3RuejcLpj9PEfppmbQLqVTaRJI/HMO8Hejqm5MupCNlozQ9KQnYlf7H6awaBwllQ0B+AVc5iwtsXd+JGHgMiKJBOlEBdHlNbt9pJEfjEGesb23AsdXH9bAip9nlft03yhndSoauLtZrlO6TLymfx/38p6i+ddHyChKQPajdyU08qojDLfOFAQeXkHRvqVb38hebqvn1fW5s+K5k9Q+CFtOz08k0O8uYdDTCxU+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S67jd6uKi/AguxT2TyGa1CgbJ8HkAA/7Fw6QinAB22Y=;
 b=irairTC9q2oPod98h99CbwGdM9veyt7Bx+4Kn2oBRg5N5BQgxqn3UuK9IGvP7US2MOJM3z0HZis098wa8Zje4V+HVn6EBdB5i9AKHjs9Cx3EVYNWlxOwmy4OF/KL8Y1IF4A58GYbRCNs3730Mjt3lKeSozyBwBsEHTwKPr3a5uLm97nlqNsNUOf/r0xm/ECezwTLUlXkpN/XpBtmL+hrdXQEa//z2TiwArLkZGlQSDI3pxW4KMSwpMhqqoWSTQYMTaDvptmDwl9Rhs9OLHcIKX4/VjmI5eiiez84tZt871dhhf3gx89r0wQ3LkZ0eVoXWQgtgG/rTHRBeD1sN2/IIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by SN7PR11MB7538.namprd11.prod.outlook.com (2603:10b6:806:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 23:26:17 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::bf37:874f:313d:b7e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::bf37:874f:313d:b7e2%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 23:26:17 +0000
Message-ID: <835b8308-c2b1-097b-8b1c-e020647b5a33@intel.com>
Date: Tue, 10 Oct 2023 16:26:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 2/5] ice: configure FW logging
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <jacob.e.keller@intel.com>,
	<vaishnavi.tipireddy@intel.com>, <horms@kernel.org>, <leon@kernel.org>, Pucha
 Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20231005170110.3221306-1-anthony.l.nguyen@intel.com>
 <20231005170110.3221306-3-anthony.l.nguyen@intel.com>
 <20231006170206.297687e2@kernel.org>
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20231006170206.297687e2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::44) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|SN7PR11MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 311725c8-30c6-4650-3b14-08dbc9e84d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uT5AaR/TpkSUAA19/OOsZKIx2vfGPj/bUJ86PyEMTkkM3laPQhIuUBBnaRGc6does2eZKYegBlrgyi79aHSrgq7Ew+yTP06WJUkIm7xK+ddFMl10z4PGggJK9qfCW1NDPuhetnU99HtlzoeimU85hT0w1ZNtUlcQb5SDm5Y1P+hi7k0anYZmAR2sNVGDTkBZKT31MFy+aJyB7pJpi+de7/UFC0vfRGaE4UaSeEzG9xT17PcYmiPfLeKgYFCuQ7avNZYHEHpJdkSamKQ2fhO4qmNgeqgG8KTuiN6hfVLtsyPO/zD6wDC3NQ+Xlgac1aF0ATzCsuLvtvZNRJGtYFt7EPxSCpe12rEy9iWQ9Msk7s+vUuu4Y0+HPSUvwDMmhUWlL5XyZpl6nxwb9d+ZG9189ktJSlAgP0njFOnT5J85z6dUHcipIl7V3/GhZGo9YGJsjCTIrRsF4QeqAHg/U/h3Noy25wGyQvKRuArTwax76OHpHtXo1dSPMWWfOri3+BNJ4GdC25LoPrq+NS/xJ4c+z/umAcSrEvSASvIp1o+jmok76CrftdwaeQig7VXyLulGJaa9Vlv09lTK0QFJmqWGsCa6Hok/KRBvsYWe73xV2qxAoURfjfbLh0R/Db/64OKrov08IMweDBaFmvgbwH9Rtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(5660300002)(53546011)(26005)(2616005)(107886003)(8936002)(6512007)(8676002)(38100700002)(6506007)(2906002)(478600001)(4326008)(66946007)(66556008)(66476007)(110136005)(6486002)(316002)(41300700001)(6636002)(31696002)(82960400001)(86362001)(36756003)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a01MNndmdmhTaDd2M0ZON3p2VkFwdHNhbnlYYnY1bzZBaXhFZDNDT2ZaQnVV?=
 =?utf-8?B?cFN2REVscEdDalhsL2UzZEJzZjVRdXJ6RThvZFJXd3BTOCsrZndaOU5FTE0w?=
 =?utf-8?B?WTVXeXZTN29TdDR2aU5hTnY1aG4yMWkyd0svbWFYQzk5NlFZK2hYNGozUkFM?=
 =?utf-8?B?eUpJWjFURnVUN3AycHJiNnQ0WWdoVmJCQWpTMWY3Kzl4M3hhV0pwMkVIQWFP?=
 =?utf-8?B?YkIxL05OckduOU8reE0waHE3VnRmZis4eFlTZlI5aGoxeE9CSjNkSG1wOFF5?=
 =?utf-8?B?blNLS3dSakRBcXFrTWlZVCt5WHdlamVYWWVVTWNHMytFZGNNUXV4SVFJVUR5?=
 =?utf-8?B?M1JqTEZ2STNtZFdLTk96MWZkSnpDUkhGVlV3OUR0dldnRCtPdnZwYm9SUU9K?=
 =?utf-8?B?NGRDSkFUQ0poVHBBcDVna1Bvc3cwMXJ3SUxJRm9ZNE9kU1R0eHRTVURsaTdO?=
 =?utf-8?B?QmNHRVliR0NtS1RXOWROYW8zS1JlK3l5N2lTSU5yS1Q5WXNFanBaSnA0N3B4?=
 =?utf-8?B?NU9kVVJ4YUVkdTAyRU55Ukc1WVhwWWZPT2F4ZDdDRTc3OHNVZm5abGZwN1E0?=
 =?utf-8?B?WFdkQkg4THlvQXhRamdjUmRjR1dTV0E1MlhuWVNBU1o2aEJiejJ4QzFQUGRy?=
 =?utf-8?B?TjdsZTdVU0haVXJCWXlwNmtEbVNndnhyWURha2hkVHZoRnYyVVlTdWhDa2o1?=
 =?utf-8?B?dzJ5VmIxT1BPSjRrSWhxa3MyNUd4S2ZLR2xNRFVzSUhzYWMwMDljSFlaaG03?=
 =?utf-8?B?dWJNNFdneGE4WjlIU3ZVakVaeS9KNlBDYWtmOTNOUTRxeWo4YnY4RFhpK0RQ?=
 =?utf-8?B?cFBuM0NCOTFxMmsweFU3MVE5M1FtNFlXb3B5cmUwZjhKM2FmNnVSR0xSZ2Iv?=
 =?utf-8?B?d08yRFJmbkpkZ2tNMzNhY0JiTnAwdm9SZ25CSld2UUhBYmVzT0tRRnpPTW95?=
 =?utf-8?B?QmlZTm5ycXBXbjZYTWkwT09oUnZ2LzB3MFRDZ2ZoSmpKZWdteVFzdDhMcmJz?=
 =?utf-8?B?aURpUlJ5amdGOE0vSE5sRVZPL01PRjBmVzhjYm5uZW80RndPcHltR1prSVNX?=
 =?utf-8?B?RVdSeFJuNW9FMjhGN1FlVkIxOCtYVkc1NDYyMXlVWG1jVmFwdHloaGZJQ1R1?=
 =?utf-8?B?emUvM1E1b2w3eUtXMWt1bG1mUGdTNmI3QnQyUDQzRHFvaTRBcFhUSW5mWit3?=
 =?utf-8?B?NmNUWE5paGNyRlJvQ2VvVzg4Y2dEamZxWVBNekFqUDFKUWFyQThRRFg2LzJV?=
 =?utf-8?B?VXRFWG5hOGhoM3BRTlhleGhGSS92eXFrM0RzMXA4bG5JVFEvNVhnYXlQYUNp?=
 =?utf-8?B?UmE1MFlMYWNrNmU3VVNvWlFxTFlnUjdmVDA5aXFQK2NqSTd1K1lKd3lxNGZL?=
 =?utf-8?B?bzhBT29qQk83dmdPMVpNOWlBeXdsVklocjdwL1BxVmJCeUo2ZkZUOEZkeWJx?=
 =?utf-8?B?ZVJKTGxSSFhvQlhMZ0w5V2ZaNFFCZlB2MXZZWUF0aGJ6R3dTYVNtRVFLYnlZ?=
 =?utf-8?B?UmEwK1JJVjVOWi9aYjdidFBLUzMzU21qbGlVMnIvNnhieTFsQXRESnRvR0E5?=
 =?utf-8?B?a1BpQkpYdk1UL3VkU0NHdFNRRitET2syQlI0a0NweU91bDI1L0NJb1Nqd0dR?=
 =?utf-8?B?OEt4STJmeVMxczVZQTk1am5QT1pwYWRJREJmZ2tFUDhsMTZmNVkyV0E5KzJY?=
 =?utf-8?B?LzJvc3NkU0NMVDVqalBXN2MzWmFhemhmb3pJYmFFcEpBS3J2NW0zb3dyTkw0?=
 =?utf-8?B?czNHenBxdUZQOXZkMnBlRGtmNVB1YUZtZ3ZlWjFLQTgxVUcvWXZ6c1BybHFz?=
 =?utf-8?B?RVRjbXJoeFl0NkY5SDNWNGNDVWx0VHRObUNZNmFJWWNUaGpUZHIrRE5LUjBX?=
 =?utf-8?B?STM1YUhmcWs4MkcyWWxhcFRSV2Ewa083RE9zdzh6SldOVFI1c0pkZUN4aDhY?=
 =?utf-8?B?T2xzNGVNZWs3NnY4OVFqclBvaFpidFd2S0tPWjg0cCtlN28rNmtXemZZMW03?=
 =?utf-8?B?elpaM3l0eFdJRzVrdnFvQ2Q4cjFCQVFTYk0vNDRyVHN2SnFGNDc2UVN0R2Fj?=
 =?utf-8?B?cWhqSWM5N3RSZ0RuOGJGNGNzSHFQRXYzNnlHVFlMZ0owcTg2VGtjL3dRZ095?=
 =?utf-8?B?VlFGRmtvcUxFYTVZWFhyR29EVGU1L2NGV0FwbHk2S1JFM29vUkg4UXZZM25S?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 311725c8-30c6-4650-3b14-08dbc9e84d7d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:26:17.3477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZLhWt+11a5NKgvThHUMMxOdLyrKrZ3D7KKey87eac5JIhHb2M/ahcrRSDK1vinqgEKtdfSJI1HQSnknIHB/P+GRHz7qaLac4A2Td6wfWsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7538
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/6/2023 5:02 PM, Jakub Kicinski wrote:
> On Thu,  5 Oct 2023 10:01:07 -0700 Tony Nguyen wrote:
>> +static ssize_t ice_debugfs_parse_cmd_line(const char __user *src, size_t len,
>> +					  char ***argv, int *argc)
>> +{
>> +	char *cmd_buf, *cmd_buf_tmp;
>> +
>> +	cmd_buf = memdup_user(src, len + 1);
> 
> memdup() with len + 1 is quite suspicious, the buffer has length
> of len you shouldn't copy more than that
> 

Yeah, you're right. I'll double check that... IIRC there was a reason I 
did it; for some reason I think it had to do with the CRLF from the user 
input, but that may have been an issue in a previous iteration.

>> +	if (IS_ERR(cmd_buf))
>> +		return PTR_ERR(cmd_buf);
>> +	cmd_buf[len] = '\0';
>> +
>> +	/* the cmd_buf has a newline at the end of the command so
>> +	 * remove it
>> +	 */
>> +	cmd_buf_tmp = strchr(cmd_buf, '\n');
>> +	if (cmd_buf_tmp) {
>> +		*cmd_buf_tmp = '\0';
>> +		len = (size_t)cmd_buf_tmp - (size_t)cmd_buf + 1;
>> +	}
>> +
>> +	*argv = argv_split(GFP_KERNEL, cmd_buf, argc);
>> +	if (!*argv)
>> +		return -ENOMEM;
>> +
>> +	kfree(cmd_buf);
>> +	return 0;
> 
>> +static ssize_t
>> +ice_debugfs_module_write(struct file *filp, const char __user *buf,
>> +			 size_t count, loff_t *ppos)
>> +{
>> +	struct ice_pf *pf = filp->private_data;
>> +	struct device *dev = ice_pf_to_dev(pf);
>> +	ssize_t ret;
>> +	char **argv;
>> +	int argc;
>> +
>> +	/* don't allow commands if the FW doesn't support it */
>> +	if (!ice_fwlog_supported(&pf->hw))
>> +		return -EOPNOTSUPP;
>> +
>> +	/* don't allow partial writes */
>> +	if (*ppos != 0)
>> +		return 0;
>> +
>> +	ret = ice_debugfs_parse_cmd_line(buf, count, &argv, &argc);
>> +	if (ret)
>> +		goto err_copy_from_user;
>> +
>> +	if (argc == 2) {
>> +		int module, log_level;
>> +
>> +		module = sysfs_match_string(ice_fwlog_module_string, argv[0]);
>> +		if (module < 0) {
>> +			dev_info(dev, "unknown module '%s'\n", argv[0]);
>> +			ret = -EINVAL;
>> +			goto module_write_error;
>> +		}
>> +
>> +		log_level = sysfs_match_string(ice_fwlog_level_string, argv[1]);
>> +		if (log_level < 0) {
>> +			dev_info(dev, "unknown log level '%s'\n", argv[1]);
>> +			ret = -EINVAL;
>> +			goto module_write_error;
>> +		}
> 
> The parsing looks pretty over-engineered.
> 
> You can group the entries into structs like this:
> 
> struct something {
> 	const char *name;
> 	size_t sz;
> 	enum whatever value;
> };
> #define FILL_IN_STH(thing) \
> 	{ .name = thing, sz = sizeof(thing) - 1, value = ICE_..##thing,}
> 
> struct something[] = {
>    FILL_IN_STH(ALL),
>    FILL_IN_STH(MNG),
>    ...
> };
> 
> but with nicer names
> 
> Then just:
> 
> for entry in array(..) {
>    if !strncmp(input, entry->name, entry->sz) {
>      str += entry->sz + 1
>      found = entry;
>      break
>    }
> }
> 

I'm probably missing something here, but I don't know if this will do 
what I need or not. What I have is a user passing a module name and a 
log level and I'm trying to match those strings and create integer 
values from them so I can configure the FW log for that module. I'm not 
seeing how the above gets me there...

I was trying to not use strncmp and instead use the built in kernel 
string matching functions so that's how I ended up with the code I have

>> +static ssize_t ice_debugfs_resolution_read(struct file *filp,
>> +					   char __user *buffer, size_t count,
>> +					   loff_t *ppos)
>> +{
>> +	struct ice_pf *pf = filp->private_data;
>> +	struct ice_hw *hw = &pf->hw;
>> +	char buff[32] = {};
>> +	int status;
>> +
>> +	/* don't allow commands if the FW doesn't support it */
>> +	if (!ice_fwlog_supported(&pf->hw))
>> +		return -EOPNOTSUPP;
>> +
>> +	snprintf(buff, sizeof(buff), "%d\n",
>> +		 hw->fwlog_cfg.log_resolution);
>> +
>> +	status = simple_read_from_buffer(buffer, count, ppos, buff,
>> +					 strlen(buff));
>> +
>> +	return status;
>> +}
> 
>> +static ssize_t
>> +ice_debugfs_resolution_write(struct file *filp, const char __user *buf,
>> +			     size_t count, loff_t *ppos)
>> +{
>> +	struct ice_pf *pf = filp->private_data;
>> +	struct device *dev = ice_pf_to_dev(pf);
>> +	struct ice_hw *hw = &pf->hw;
>> +	ssize_t ret;
>> +	char **argv;
>> +	int argc;
>> +
>> +	/* don't allow commands if the FW doesn't support it */
>> +	if (!ice_fwlog_supported(hw))
>> +		return -EOPNOTSUPP;
>> +
>> +	/* don't allow partial writes */
>> +	if (*ppos != 0)
>> +		return 0;
>> +
>> +	ret = ice_debugfs_parse_cmd_line(buf, count, &argv, &argc);
>> +	if (ret)
>> +		goto err_copy_from_user;
> 
> And for the simple params can you try to reuse existing debugfs
> helpers? They can already read and write scalars, all you need
> is to inject yourself on the write path to update the config
> in the device.

I would use existing debugfs helpers, but the ones that exist look like 
they are really set up for variables you want to read only. We need to 
do some validation on the input when the user is writing and I don't see 
how we could do that with the existing debugfs_create_* helpers. I've 
looked through the kernel code at uses of debugfs_create_* and couldn't 
find one that was setting up a writable file, but I could have missed it.

If you can point me to some code that does what you want then I'm happy 
to try it, I just couldn't find anything.

