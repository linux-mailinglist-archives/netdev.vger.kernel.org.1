Return-Path: <netdev+bounces-44221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9437D7239
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 19:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BE0281A3B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A17230CE3;
	Wed, 25 Oct 2023 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Or0fQL9v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D441A29F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 17:23:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE10012F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698254625; x=1729790625;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ag2ifGVtU0zW4Y2mEdBcqv42du2pzGiahZzsR2noD8Y=;
  b=Or0fQL9vb0q5gkCPEmEqNRkq8yseG8hH5HypEV/+ebtY92QUaFEXhYo0
   sviJT5uQHGKJEOQY3V3kcbB/fOjpkI/bJoKM0Ot2aPRAJKCd8MLzHzbdY
   feAuuZ/s72nslSf4geXslo6GcHn7iVbv6IpavZnbeZB4Ep8lKaJYPWnCC
   qF04eiArcjWNuoOKtFWZyf35/XJIeB6oB0+IsMWHow32IxfkobNv0Aq0a
   ozA1L9r2ETNBocT+gZX/Zys4Bo3W8v2kOebb4BQJMqVrups0533JhnuBf
   0oSJLYT6dDLwWOsF2l06SlUPbAjaydpTHmyy9FrHGEPhowtguDC6Xp2FF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="384568077"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="384568077"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 10:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="875574357"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="875574357"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 10:23:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 10:23:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 10:23:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 10:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEg4iIYJJQo31sU6qzzFMVznaxxiJJtXmSlHxPqtPhsMAqdn+UqinyYPyyzvlGfDle5tNAnM3kRCxy0LUDSoLkLXzJ1G02AUrYesGmd8EREgmr+mpk1We0rT1HNHYpGhRCJysCtl3/gBCYbvawq45SVWkGEOg22mfpVmOqDrGRqtbJXI5wMkM2ATOTUtiJKB9Gz5IUGY4AG3t5MFWsY+O6zenlG0CRBby6FgarM3C27JALUTkN+X1zG03m1e06tbAjonb9KcqR3Gw4uyltz2CFlUzqPD4XzSgNjNrqu6GxUEnhUq/78HtgNq+5h1HglYnSluLXG6jTai4yK90K6VoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBCzmUjShqwhWrawrDkjBmGL9CNhz7kwk5uAX1YNA+4=;
 b=PRBMMufsgX38cOAJfLn/dRAUe25zHXm7b6Ck7eHAqN3SPP2aVKUb+2Kmq1B9J3ho/ApMwHTlDHf9/J5u5XoNzqU3pk0WMXMPCZ+ax3tRX111050JAs3qyO1GCpgqf1r/m5vCwzsIqeHMENszdUPjfsgNtu/yVk8kxrK5pZgjnLFg/+5vHLHAraOGZUOZtMBTsV0C1+GxVlY7GjxZrX7p6iXH6O6kTY96QBllGGsrGcLZjAvoKU6dIdKMzA+E5Fy2MfCJGFwBK2M+7b57gD6iBCpogoV5U2b4elKnR2RwGrZXmL8JmkRgUWpVsBhSNJ/PxLbA59niheRE/02ZavOHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 17:23:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 17:23:42 +0000
Message-ID: <f0107627-5dce-4b31-b448-847c47b1bf04@intel.com>
Date: Wed, 25 Oct 2023 10:23:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/9] iavf: in iavf_down, disable queues when
 removing the driver
To: Jakub Kicinski <kuba@kernel.org>, Michal Schmidt <mschmidt@redhat.com>
CC: <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, "Wojciech
 Drewek" <wojciech.drewek@intel.com>, Rafal Romanowski
	<rafal.romanowski@intel.com>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
 <20231023230826.531858-6-jacob.e.keller@intel.com>
 <20231024164234.46e9bb5f@kernel.org>
 <CADEbmW0qw1L=Q-nb5+Cnuxm=h4RcdRKWx1Q1TgtiZdEaUWmFeg@mail.gmail.com>
 <20231025092516.3c08dfce@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231025092516.3c08dfce@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc16a78-31d2-4e3e-f57b-08dbd57f22c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ME8WKWFhZGWSuoVEGAla0swEb9lc5wRvnvedoybl5QX9MJpYUZvDrSWqP/L0+fcOrbvjRwT9C3gHuiKTvBJjhNb19XYQHHvucvO8nB/foGflyc+To3W/JXXLEuT5b390hdsMMDiO8iAVd8/gU7P+cua/L0GVo7YGZrd3XWBHpGJ38jrzaRMnAu6kqxD5/oc8YLD/ImVVYNyARi0s9Fy7SBTSPTv74b4b7CzZCOge+4Q5noEcOAqxjomCyoXb51g0auMCddKNP2YmQ05tTLCFmiyE213kxudUvTNuxCAFcs9VEBdNBrlYwyVVWmPooaHcia4paVRTLcyvkgJWvFepoPk4AA6OqKo4K3H4R0Yx6UJTxP2puY2ZBeDLgEXOvL8bKA+w9G60pZ4AJe0vsvBQ6NL/sVY8Xdm/8yI+V3m8f0gKDU47+otH5rG3YS57ssu2Vwy1cdiwAj3XNrpIuFUse4+BXVglEw4suIM3YTcvW2MZJPhtG/uFIKRbc/AeJDDLdqyWCEaGlGaVtwKrFzfz2/zHpH759mBZJ1iAKy6LN+/7M+tq4n+haGvYp0pop3zJb9PaAjGDAyUFmCeEezDIEyRHYI3sSNGaeK4ccHAndfTTfDBefO59kRxdpISqXa/KrXz+1zSLzi6imnN6L2mqPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(86362001)(31686004)(478600001)(31696002)(36756003)(6512007)(110136005)(66476007)(54906003)(82960400001)(66556008)(107886003)(316002)(2616005)(26005)(6486002)(66946007)(8676002)(38100700002)(4326008)(8936002)(5660300002)(41300700001)(53546011)(6506007)(2906002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE1EMGQ4TEFSbDlSMzFNZ1VGNDVHdG9IOUdLRjc5TUxJb2RmZzhvbC9wQmE3?=
 =?utf-8?B?bmNiYzBsa2dGNGxtMHRDczlYaXRFUEZRL25iN2dGdk9CMDZkSjVJK0NsN3dh?=
 =?utf-8?B?dC9KdjJSTU9kYXcvU3RQK0dFNWl3cEpvQWswcFBTa0Z0dExsbEZ6STJwZ0hZ?=
 =?utf-8?B?T3QwaWVJeVJ0dXRuSW83L0RSSlEvOHBlbks0c1hBUEMrUGxpeGVwNTBCZGU1?=
 =?utf-8?B?eWJsb2QrMVVBYUxlbzJpMUpJQ3NsQ2ZKeUxUTUxLZDVtZS9HQ1V0eTU3QVVN?=
 =?utf-8?B?Y1JpUm4vU0V3RHQwWGtDT1FrcG9ycjl4VU14YXJIOTBMQ3kzV2Nac0hDNUNv?=
 =?utf-8?B?WFhLdUJraGhPMUs1em53TXF6SHRIcXpxa25ia0FNbGZxRnhnYXVpMUNsTXVr?=
 =?utf-8?B?YjJmNjQwUUhRaVNOZmltQ25SbndRQ0pUUm5vbHRLczFGSit3Q0dJM3dPREt3?=
 =?utf-8?B?Q1NYWEkvR2UzU216aHNhWkZsSFFheXlqOWZtUjlwS1drdlNISTh1WUZVSXdK?=
 =?utf-8?B?RkFWMHhBZWJ5RHN0STE0VWQrNDZzeHhjd1ZkWEFLNEhaZWhjdjg5M0FXTkNk?=
 =?utf-8?B?TDZvRTR0NmxRMjYrcTdFZ3NaUThwR0NVVGpvKzBJNjJ3dlZzanJrVWhjaENy?=
 =?utf-8?B?dDYzVmlONFdJZGVhSVpRMFBDZ2xSTWtpMUJjdFd5NC9uMFUxWWduNFl1ejhG?=
 =?utf-8?B?ZFMwbWRkd21ibStwTzAyMzcyQVF0VEVUazM0S0RsdC9HN3dzcVZWampOU0FE?=
 =?utf-8?B?clNKR1I2aHliYkp0dWhRQlNiYmdDRmlRMHdacG1NbWdSR3pCS3ozWU5jem9M?=
 =?utf-8?B?RVluTTYrUjlNYVVmUzJXUzFRS21FM3B4VE92L2J3N0lZTmRvY1U5Sk9OZ2Vk?=
 =?utf-8?B?RngxREhvVjdHWDdObkhhaFhTeC9sWHNLUWJYQkM2bU12SElkN3I4Y3JGOU9y?=
 =?utf-8?B?bklySVZ3RzZHTjRyZGFGNCtBN1dtc3RpdVlOREczNEFXWXorN3lXQkJkcTlJ?=
 =?utf-8?B?UnRmSjBsMHVwazlBMTU3Z29YeUJhckN2bnpvdjBmUXlETHJFdFYwNVZFQTVE?=
 =?utf-8?B?MllTTnB4YXNmK3dhYlloUGdCSmlFekJRTHBBdlRHMXkwelh5UkNBWGlOeTBw?=
 =?utf-8?B?NHFTdFpnZStGUmpwUjdOdE1RTVVJMXZ1TllKNXFPdDVhTGxXclpJMDZZY3VL?=
 =?utf-8?B?VHZ2aDRGakJES1BIaTZpa294TENHVmIxT1RPZndSUkVXZFNtOXhvMGJWTnhK?=
 =?utf-8?B?NUhvRzNHTUVhOE5BZWJTQmRranYyS2VBTVF2NWt6aytjWU1sNGtyOGFrVEFj?=
 =?utf-8?B?NTJOM1pwL3N1NDViNk9KeWFKSEpudjRkYmxvNjZUMzYwbXA4dEVUNzRZd3lh?=
 =?utf-8?B?MTdCaER4VU91bnFiQ0xoZGtnTWFjR1JLY0FHQ1d2QzRoeVBlMlZQQlQ1YXhn?=
 =?utf-8?B?aEpwaVF6OFZOaHlma1VSaXRDZjFqa0xiUDQzS1BFMkhsMW1LNHJVcVhkK014?=
 =?utf-8?B?bnYvSFR5N2RuSktSWmgrSCtRUXZEbjQrekpFRHdUc1J5NExkNDVPUURrQWcy?=
 =?utf-8?B?NUZzZkt3WXNkTjN6R1o5dHJPZzdnL0xwVkJTVWM5NnZ0ck9CWE1BL2d6Rmhp?=
 =?utf-8?B?UXlrTEV4cS9TK2tDK2xqZUVRckI3NGE3dE1NS29TL2drS3oxb3NqS1ZESFMw?=
 =?utf-8?B?dnNRYmNOV3RjelNFMzNDL2lnV3J0WUJCUGY2a24zZzZzL2FOeHU5RDJDb25v?=
 =?utf-8?B?S0JKM21ZeDRML3dua1V4bVppd2pweDdqT1JPYUtyUHNTbTgrYi9ySXJOOFFH?=
 =?utf-8?B?WGE1S0o5WDhtbmpiR3ZieXpnRmRXV0NzNWhJNk44dFIzdXBmUU55SVVlZlND?=
 =?utf-8?B?Tm15eTVGZWFrdWw5RTA0TjVpbTc5TlNOTTdGelBsdnA2UitieXJxSnpWaTBt?=
 =?utf-8?B?cjFNL0hYOGk3UHZOajV2WElEMHc4MWk5QnpNaXRvTXJKcVVrTXhXcjVNdVRG?=
 =?utf-8?B?bHdTMTVBWXROUjRoSHpKbDB1TjROU3l4NVZTSjlvclpGVEswUmZqTDJ3VWhU?=
 =?utf-8?B?SXgyNkx1WlVmbFN3WjkvU292K3NCeDRPS3pKT2RkRkRzWlVlU1pUbG9Ecmph?=
 =?utf-8?B?NDU4clp5ZkZ0NUM3ZU44eUJtQ3VJVnhxWmVHVXgrWG9Ub09FOVRoRWxuWjFH?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc16a78-31d2-4e3e-f57b-08dbd57f22c9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:23:42.5898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pB1JltYFZC8KY0fkaDUI0I2UxstXTWWYQeeSTOO7BonRRvy/VSZ2RRIOUBbe8+Pk/uQ2mkILO9iNOgDPt8u3H0x12XWniLVBgV83c+20upI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-OriginatorOrg: intel.com



On 10/25/2023 9:25 AM, Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 17:24:59 +0200 Michal Schmidt wrote:
>>> This looks like a 6.6 regression, why send it for net-next?  
>>
>> Hi Jakub,
>> At first I thought I had a dependency on the preceding patch in the
>> series, but after rethinking and retesting it, it's actually fine to
>> put this patch in net.git.
>> Can you please do that, or will you require resending?
> 
> I'd prefer if Jake could resend just the fix for net, after re-testing
> that it indeed works right. I'll make sure that it makes tomorrow's PR
> from net, in case the net-next stuff would conflict.
> 

Will do, thanks.

