Return-Path: <netdev+bounces-54646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18216807BA6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 23:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F5E2823F8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E16518657;
	Wed,  6 Dec 2023 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGAjPjPt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74219A
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 14:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701902848; x=1733438848;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xis0GJBMc0dd+xys2SGjuydBLfOFavfg75EhQ+Ge/ME=;
  b=KGAjPjPtdsepT1GLAl6on+yWZopGOVxDrfV2Hmn9PgZUArTlbwgoqAhr
   8ZDWagKtbiQ9pMWiLG/e8Zj3M7RfLo76UQzBtgaYGg+ZLnVKiDp5Fpae7
   qWRQpC85XEW6PYKAJ1n09yixbotaGvThrO4QBEvAy016oehcH06CMAGWC
   4Bkmp4PwC49+4cWkjkiV8w32f26+cFYGAmhdr2GxKMsIKQTDe6CXZsL0P
   oRCmIqFK63dxExyvQi3Nsut9adXDciblmFWKFclGTNiwWHlBrFP4yT+qS
   sWIo8ioNNoreP/tdPZjFyrVpG92ZJULDwI53Fchx7nqQ78J9C5qSTS+xT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="458464343"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="458464343"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 14:47:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="889501991"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="889501991"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 14:47:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 14:47:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 14:47:27 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 14:47:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WegKK9SGO5S5Zix3IGFn/sZQiRJfGa6qh5dJyF2sQc0+32mOv06Valc3LqkHQM+pnk26xb/bXxYIOh/A5WASrChDE7oSWZzjupT6RIYX8Ew+/PwKjVvwq09AosmcUb2Tvp9Mg3rrZB0oDvaAf19P/oj1OcsRH26liRGGbczoKI6bWAZ521VM4mk1ZWYW8DhQuTnVWtfNIUUYKkcpjt0SCTgUpj84TkBrN3jMyP1mGlOPlNoJSizneI4j2QfSgLmrWx0LUC55615uB8auMwQ1m+OTx9iVHCGfdIAnMK3fKbwNWOqKEasY/KrKoDbzw+945J6v2vjs1R/Sy3p4WD+UQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5UGwosoABDpcCfxfTByi8XcAo705IOi+HpAnTgQ340=;
 b=JGUCn/O61zD4QJP1BT08I4HIqs/vA9+GjaPj/2bHISfxSFuNKpVAVg6jpsVdCRsF1JMVrAq1n3P8zADAMaF+4b5RnWpEijO/pYObT2B6e+JHbPsSGBMSOz9YaPPGykaxFhKrv/HPAzQFs30u3dpbftsp3BKAJNVsASrDfwhJTT6hXLXTbm2jOHZSDv/TrStpriWPyAFmTguOMpM2WymoQb+nKzfaW4UNS8r7jD44Qd+0zgXWKf29ajjTW4lamcqqEG0J8p1w1GgmOuydmnnCp63fCTCwBW3ZYBRc3fBhWlTygCsV0TIJR81lQfPuqsICkLMIZya0sKhUcskbz8HsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by SJ1PR11MB6226.namprd11.prod.outlook.com (2603:10b6:a03:45b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 22:47:25 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b73b:45a5:d8d8:65d8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b73b:45a5:d8d8:65d8%7]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 22:47:25 +0000
Message-ID: <bef1ce9b-25f0-4466-9669-5ea0397f2582@intel.com>
Date: Wed, 6 Dec 2023 15:47:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ethtool: raw packet filtering
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <mkubecek@suse.cz>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
References: <459ef75b-69dc-4baa-b7e4-6393b0b358ce@intel.com>
 <20231206081605.0fad0f58@kernel.org>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20231206081605.0fad0f58@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0030.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::35) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|SJ1PR11MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b4f7e7-7209-4b22-4280-08dbf6ad50df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6DweoFFb7lOXgBMnDfgTHGsCurxrvgEZFoBOh1PA8m44TyvslT4YaJuMSQTczvZuqRCeK/JmlWtyQe1DRIA4FiYYlpYZcsxaVx34+5U68WCCEVmZ5j1hOT7MYidTP0PTP8m1cgPk03KUJthF/7c9n8UU+2EvzxRpbOgQIExAKQWjiexx9AVIk8asIeUbNIPg7xOdw2SH65DHRz3omtZ8Xr2Ar3IER+RObgEit04AmvbYyky+107VIQ4L3Hjgjv/idpW28TpcNP3wVm721BwYBvKVNxHxD78nCzeaauwZy0B5xY7tLfT5pNAc7v7a/8vrkoMsVRY4l3794d3WMq/B89wVAzrJRs0LuxTHOb9HH7ORj3kN0W+kEOQXww0Wi2K6B5BrKyLpBcMhhWTY68P7MLTjfXMTr3NJ4XZpa8sZ96UVuliiyyk7gLcNN/ighOHMJa7i2toXtP1tlXkkdMIVXM42pISrfhMWIb7T41wAAV1H/JAoS3wh2HP/8U9+IhlwtaJ9UFlW5DPVSHEtnfh4uPvzjgyWQjx5aJJu03HA2qMuMoOoPTj4jf0aFmKSyf90cja85uQmgIiZePwMZBQRyXKp2Mszy8VA2E+MMrDrdXuq2y8OFdutfrq2YZYnFn5zKfMI10qnByCXCxrYV6Q3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6666004)(107886003)(6512007)(2616005)(6506007)(53546011)(26005)(316002)(66946007)(66556008)(66476007)(54906003)(6916009)(5660300002)(2906002)(4326008)(31686004)(86362001)(8676002)(8936002)(36756003)(44832011)(41300700001)(38100700002)(31696002)(82960400001)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b29Uc2twU09KbDMvV25jdTZ6aHlMcUpjQUhYbmRPaTlaODNCekVyV3FmQm84?=
 =?utf-8?B?SkQ5V2Q5WWVZQWh4Smd5cWVkYk5URGdjUlk1cnE3Q3ppd1Q5NEhjMHlUYUpE?=
 =?utf-8?B?WE5CUDVDY0hNVHE1TmdtbWpLTDhMZENDaGJIRHVzQnRGZmFBdDRNMEdUOXhu?=
 =?utf-8?B?STUwd1owWTNjUmRDUmNCMzRrNkRBOVdyUTFmNDZOMEYvWjBQRWlwVlhmNnM5?=
 =?utf-8?B?eTBldVVhTnprSEVhcVRIY0t2RG5ZMTVtaFlyK1UzVG80MjFVQ083Ti9SclVD?=
 =?utf-8?B?c3ljTHhEMXIwc3N0aW9zVnAzNHdZQ1JXd2c4Q0dMTGZDZE1ad1lybUdmZGhM?=
 =?utf-8?B?V09wdFo5YU82Z3RuWm9kS0ovTnNXVlB2aVU0anRFUUsyWEp2Y0ZRYVZ3bHFR?=
 =?utf-8?B?MzdKWGNpb3hKVGxlYzA5d2FvQ05HRlVWSmxCTVdXU01DeHZDOC9hRVJGOHN1?=
 =?utf-8?B?a1E3VDFzYmZBWVByLzRHbW9xaWNkN21pVnBvVEJnSHFZNjh5MDFpYnI1T0R5?=
 =?utf-8?B?L2tTV2NNdXpsNnlHUmpnKzY3a1ZreTE2d3pxU3daemw2N2wyb3AyUkxRZ0x0?=
 =?utf-8?B?VUlUdDJhRmtua3FlUTVFRUNXYkROSEQ1Q2liVzVGbHY4alFueS8yWTVJeDZ2?=
 =?utf-8?B?WkVLYTZVc1FHRGZtVHg2TmtQMHB4YlF1WDNhU1hNZEF1MFk0c29MWEJ6NnJM?=
 =?utf-8?B?V3JBL3hQMU5YSXBMVHdaL3FpYmJlWjI2MUVRcVVFUzBUVDVSWkR3eSt1alhE?=
 =?utf-8?B?UCtjMnNlZGtCWlZuMzQycFVrM0RpRXhsME5QbnV2cHlYVk1NMnE4OGUzaHdv?=
 =?utf-8?B?SlA3dnJnRUVGdGxhTDBnT1VQa3pHL1JmQmcrWnJ5QmhUTmlOZGptNFE3SHFM?=
 =?utf-8?B?NEQyWWd5Slp1NmZjY3IzRlV3d1NpbzBTdzZoTm5BdUQ0SFRISDBZWGVTNlhB?=
 =?utf-8?B?dktDQmRiRDdWUmZNSjk0K1dVWDBoakJablN3MENtSWdWKzV5aVhLOUlUMlR4?=
 =?utf-8?B?NVNuUUJMNlc3NWllN25MQWZSNEtpU0p0VG14aEc4MGFuZWZ5dGhwOTNUREVE?=
 =?utf-8?B?TG5xb244RkE5Z0JUbVFNUENhNndJcW5vZ2xVVjM2NU11Wmk5a1lUQTQyRzBv?=
 =?utf-8?B?SGE5UEkzR3BjTnByQjNnK29XR2lXNmhYQnBkTHlGbExPRjBtanBhZ0xYNXMx?=
 =?utf-8?B?UWZRbkIxZXppTThqcjFtRWg3MDBuVVVDRjJEUHlNVGpPMDRzcXRaeURvWjZm?=
 =?utf-8?B?WUtMVy9maFRaWm10eEJTNFcxUGZQckx4YjFpejg0ajdYemVkL2I4cW85aGZV?=
 =?utf-8?B?L1U1RFJjei9vREtrS2pkMmFqajNyMm9Sem8zVVRtOEF4ZkFvbnZNTDU5Z2VR?=
 =?utf-8?B?YnBHSEdreUZZVUZJWjMxOHFMWWFWS21vdFdjMkVwTnNIVWcvRXd3RGJpaGVZ?=
 =?utf-8?B?OWRrMGRrV3htSlJZbHRrQTNhcEVQRkJqbmxOZFdVeHZxaTZ2U2dqWDhpN1N4?=
 =?utf-8?B?elRUb29xa1o4Z1dLckwveElFNzRxUDUxUFpNL2hiZk1xVzRJakVZaWdCOStL?=
 =?utf-8?B?RmFDTGg0WEhRVmFIRUhtSkx1ZTRXb1dsMkFEYzRaREpMTXZkRkNhOFE4ZWtj?=
 =?utf-8?B?enlpdGJYY3huSStYUHVFZkZyU3YxYkl1RGdvSXRWL0lKZlBNWnhXVXhCS3Vy?=
 =?utf-8?B?UDdpWndNQmMrblorLzRqL3B5OXkxTmdCcktMMThIbVZWNHB6QWVLZURwUlE3?=
 =?utf-8?B?OG5FeVdwaTNBNWc3ai9CUlRFRDlLTVBoVzRScko4S0ZVcjFDMDg4WWJqVU9D?=
 =?utf-8?B?MjBzdDcxOGhXL2ZkNExTVER5M0szL0VHUVhEWmpFcHVQWXJORDJJR0kwcktB?=
 =?utf-8?B?MWFxSlNROHNjdUZTNWZyMDEzaEJnUTN0dHVKY3RyR0diRlZOckl1SmZtaVpO?=
 =?utf-8?B?RURSWlpZcG5HNzN4Qkk5Q3h2OUdGQXdtVkhmWWsyR1dSVVhOY0pWWFAwWmpw?=
 =?utf-8?B?TWhNK2lXekZ3eXB4cGtieVZVeWwrWGdaQW5NYWRId2k0QkN6dTlSdHdxa09j?=
 =?utf-8?B?WnNPZHg5QnIyWDl2S2MxVUF2WURBelQ1M1FYbmlEWGtOaGdGNkFGVW5rWDBI?=
 =?utf-8?Q?PyltY//5zry8vNsvK5OUaEfUk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b4f7e7-7209-4b22-4280-08dbf6ad50df
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 22:47:25.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZNeLmBdV1O0EHGRw/NUid/xc4WCH4XK8uFp2FjKfOcx1CarIipkXLH6A6ZjYiCl7WBqUL47KlfrHWKHjht3AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6226
X-OriginatorOrg: intel.com



On 2023-12-06 09:16, Jakub Kicinski wrote:
> On Tue, 5 Dec 2023 11:23:34 -0700 Ahmed Zaki wrote:
>> We are planning to send a patch series that enables raw packet filtering
>> for ice and iavf. However, ethtool currently allows raw filtering on
>> only 8 bytes via "user-def":
>>
>>     # ethtool -N eth0 flow-type user-def N [m N] action N
>>
>>
>> We are seeking the community's opinion on how to extend the ntuple
>> interface to allow for up to 512 bytes of raw packet filtering. The
>> direct approach is:
>>
>>     # ethtool -N eth0 flow-type raw-fltr N [m N] action N
>>
>> where N would be allowed to be 512 bytes. Would that be acceptable? Any
>> concerns regarding netlink or other user-space/kernel comm?
> 
> We need more info about the use case and what this will achieve.
> Asking if you can extend uAPI is like asking if you can walk in
> the street. Sometimes you can sometimes you can't. All depends
> on context, so start with the context, please.

Sure. The main use case is to be able to filter on any standard or 
proprietary protocol headers, tunneled or not, using the ntuple API. 
ethtool allows this only for the basic TCP/UDP/SCTP/ah/esp and IPv4/6. 
Filtering on any other protocol or stack of protocols will require 
ethtool and core changes. Raw filtering on the first 512 bytes of the 
packet will allow anyone to do such filtering without these changes.

To be clear, I am not advocating for bypassing Kernel parsing, but there 
are so many combinations of protocols and tunneling methods that it is 
very hard to add them all in ethtool.

As an example, if we want to direct flows carrying GTPU traffic 
originating from <Inner IP> and tunneled on a given VxLan at a given 
<Outer IP>:

<Outer IP> : <Outer UDP> : <VXLAN VID> : <ETH> : <Inner IP> : <GTPU>

to a specific RSS queue.

BR,
Ahmed

