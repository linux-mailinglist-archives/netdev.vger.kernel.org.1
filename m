Return-Path: <netdev+bounces-43690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63C87D440D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 02:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664ACB20D02
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B102A15CB;
	Tue, 24 Oct 2023 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MU+rZlia"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA263B6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:31:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B663693
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 17:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698107499; x=1729643499;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aqdl66HWbrrkqk7B04bmyYLxOz124vObncXPwjK0j24=;
  b=MU+rZlia3NyhoYqg7/tAGBur2RRlY49OnsXujc1kbHLNQ59Ia+77Ng4A
   IN7gNzoeE95jQRLxFyXv0e+Kr9O/EQE9YiroNDvb0gbVfs4h7G01jYjvY
   rlkvKDX6un27I40PKSuYPegq5em4evBz6wXFJ2G6GqrtWibYzgyeHAt+5
   X1ve16rm1VCEBPv9WJfmGEwLO1Iq3VvUR9X/uSiuGE6bRzgRl/D+zePuJ
   wXcNQwFLPJAPOXuV83GtK9lmONDDP1NbfychulGS2lMZT9vZSY5rAEmCj
   kX9CwMcp5Xp8hQOfgOAzjwByY9Vq0E++8E27oxSsG6sTKEiFRW+TGCf4G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386765475"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386765475"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 17:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708098495"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="708098495"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 17:31:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 17:31:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 17:31:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 17:31:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTFvSHagMYzi70itH4v24GSvpmR7HS5rC7Xwgdh9OJ3+e6OPeJGdpr6PqkoaYSbdX+g7tv5SqkotMt+TlRKFB8pMiymWkNcSwCjne99ALts5pLjBB/6/04Da6zSmvjL3j9gBPv+HtyyRzPwEJ0uBEnkC3PVTaPTTy16QH2Ufl4/Eiyquw8g+PZms2JYjZfeaSJeV8gLXvvbFKWRsBTv7XoGQjsoMvjJM03K3rA6Mw9b4KrHMhYaU/ON/85B6TLEwQTYeWkhhTmX/yQzA+HhnWiGgPU3Nb7EODfeufDBHzHcT2845aBrlM8AI3EI9UN3GQUPt9/vA/Q+crEO/0yQ+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBp5tz8d5ldcdOdkNEiAL7cHkKcTwkabRf7c7SLKhdY=;
 b=f6BhpvrOhb191pU50DHKUbX817/fbDIZ8w7+VDGskWpAv5H5XDYPLdUw8teKoOBMTzEKL1TrvlymiiQ2zLjkelMgOXVT6Wo+paBHzrXF7DlvLEWacLhbIX9hUW1b7rQ0T2JIsZPQxJGcL14E1hrxOWaIaAPny/IpRj5KEPQyg46Ton1rcmR+vtio41UuYL0svUWXG5XzfR4ES7RCVKTsfNCG1AVSKFsx8gqHn772IvZzNZfyL2guEs2ObqJzsS3wDqEUK7EjWmtKEAb9gjaJ68lhpL2/XXKtYo7IzpkYkopKEjL6oDydrASazCA4LhpBCjbM7CVVJZqf71TVz1LkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 00:31:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 00:31:36 +0000
Message-ID: <28ab31a4-b576-4f08-a522-54756c6bda9c@intel.com>
Date: Mon, 23 Oct 2023 17:31:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tsnep: Fix tsnep_request_irq() format-overflow
 warning
Content-Language: en-US
To: Gerhard Engleder <gerhard@engleder-embedded.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, kernel test robot <lkp@intel.com>
References: <20231023183856.58373-1-gerhard@engleder-embedded.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231023183856.58373-1-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:303:2b::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 8865194e-74e3-48e7-8a08-08dbd42894ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhY6DIk7mQzIwtcqOGavmmLSyPK8UEhLlpY4VxWh8IuBZc63uksPBIr/REAyz0L3t9YlMEQNlcDjs7mLQBwvEbX6oX4xvtQkii12hOoPfKweqWZJPD8sTLpgHIIYZcoTNl3FXzTkYF1jzKCtYujG58pFlfRYVQIkRaXlzJjqB5c7Px/XrAlE8Vf7FaaRGdQ4I3A9WVrywzN546rhJE2gqBWgYWUGuAhHb718fb9rQh/kgVjlaerOk9PVlvIy3aeWvmFC08b5ttOgKXi5Xt7DjRo/jELMTjMvK3mIDf7rc4U7HHq2GE/Vv5Sb/KlNK2/3nHbH/UGmeolGL/t/rI4OHhXikTgNm9KxQCL9w60FtMW3ygMh5eM503khyy+cv+wvWzxCgwHpG0XYGsegsFHYLBotbMh0Yprpfq9o5QZJ8/9Ym9NDmaZkq5FgCADJSlyFuPqK7H5HiKKx3Ec1jLk77kOERqcLQREpBX+JaJZDDr+t2uKIgkzFnHvU/PpYIvSVZfjL7SAqlOkPqhy/KgHeA0XNo8it3+3vhVMOViIm5C1pQU4vUlPOEoLAAZP32VScnrvwLZ9b682bEcqVtwy1uD5oAht989biUo0SYZZDxEUcW01J5GdAwQRSMN6UVWNNdZeILAUxx4Qq0LgPrdnIvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(2906002)(38100700002)(66476007)(2616005)(66946007)(316002)(82960400001)(66556008)(6506007)(107886003)(26005)(478600001)(6486002)(53546011)(6512007)(83380400001)(86362001)(36756003)(31696002)(5660300002)(4326008)(8676002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEl4dTZJQVQzcVhZWUNOeTZaOUdSSGt3bzZkL3huSTBGazA2WXFWSzBDTm1a?=
 =?utf-8?B?azhqZ0RYVFFzUXh4VE5LaWpoQ2plL3EvNzJQaHpPcXNEeFN4TXBGenM2Y0NM?=
 =?utf-8?B?aXpRZjNGclZRR1lVdTJJWW9DbUVpbkVJSUcxSnNxNU0yZ2EzYnV0b09wekJL?=
 =?utf-8?B?bGZ4eStCS3VMQ1BPR21iN2x1bnczT3B5bTcwbGIyY2toOVJ6UGl6QktYd2dt?=
 =?utf-8?B?eGNtT3BTYXY2TUFHSEk1MlNkdjR2TDR4Q3FCNlF6bVNKMHduMTZqaVR4T0cw?=
 =?utf-8?B?QUxsSjRYRzRPdlJVdUlESlFPRkhiYW9XZlVnN3BvZ01RdXJRV3c5elZGeUds?=
 =?utf-8?B?T3RNcWZKQm1HSGR5bWpmc2pRVnNsLzlMYXZpNE81TDN2cE5sd3ROTDJ2OHdn?=
 =?utf-8?B?MjZvWVk2TWtJbWlCLzdGdVM5YVNpblZ5NG1IRk9yZTMvdGJ1YXhsNXVYZEVT?=
 =?utf-8?B?UlJIWGZxSmtMaVROVmVRNWZhZDl5K0wzL1VSTnBIMEpwL0FKeW5KcGN6MWp1?=
 =?utf-8?B?Z3U4MUJYSU13MHFIN0V6RHZ0UUJPQ2YwS1hhNThoNTN6SXl4Wml1WVhGa2Rt?=
 =?utf-8?B?SldMdFNGQWdzUnVtMG1UUTRlWWVxZWZVbktyYmN1NnF2SlQ2UXhLZzBxN3Fv?=
 =?utf-8?B?ZlRyOXdNUjN4SHpZMmF6bGZ5MGxjVjZsYnB4TVJTa1BIRWg0cU9vU1U4a1Zl?=
 =?utf-8?B?MG1EWFVENmdNaGxLcGlnb1pvOVpDclZ3d0hJQnJFQUNwWktZMTJTNk0wVnc0?=
 =?utf-8?B?UVpEVFBPbk9uNEVNNnBPK0I1NkFIMis3c2daZlVoU09WSGZjeUsrQXlGSXFB?=
 =?utf-8?B?QnBQQWVPZzN4SFNZT2hFMGNjZjMxdmZHM2xWOEUzRndvbW1DMTA3cWF1MS9r?=
 =?utf-8?B?SXhnd0ZTeVBYYzJQcHR5ZW5TWXEyUS9SNDNBa09UVlFKc0wxSTlxUFlYNW9n?=
 =?utf-8?B?bHJsSnU0bC84T3B1NUsxN2p0MEtOSnQvYnFJd1czSVBNb1JBeUZzdkM2MDR1?=
 =?utf-8?B?TlFLN2U1a2VYL2tpaHdMU1NRRFNuVnY5aDBLZ3EwSnJQT2xCeFo3YmRzcDZq?=
 =?utf-8?B?eXExSzFsNEd5cFBBbkhlZVJDM3ZJSTRKOUNmWUNLVE5FSkdxRmRvajJ2eHVP?=
 =?utf-8?B?dGQ0RFpkZ2IrUUFhcTZTUEExbEloUVgxdnd0anpBd0RFcHBKN1c4cEc3SDh6?=
 =?utf-8?B?QjhtcFl2WGtZUkJiU1pISFpSNE5aSVdGUTdhbXdNOEY0RHdRL2RWL1pSVkVk?=
 =?utf-8?B?Q2RaVWVDYmw2K3pBNFdWM3ZVWjk5UlZ6SDEwYjAzZXFTSC8wdloyU3Y3WTVV?=
 =?utf-8?B?eUpLUkw3cU9OZzlaNHBpUjdrb3RCOGJwTzZMSXdUUTZzWWJFTjdURk1kTnUw?=
 =?utf-8?B?UWxEV21qS0Y4K1NMdytwSGYyUDQydGZYRUd1d0swQ1NIUjBSaVlvem93aFF4?=
 =?utf-8?B?aTk5SXdEMUFNWFo2a1lIQlA0dHFEc1V6Si9YeFBPbW9WcW9ibTNXakczY2Qz?=
 =?utf-8?B?ZFY5UEE3a1FEUzNUU05wNTAwd3hpa1ZoU1Y4VkxNNThWS0pQejJaQWJmU090?=
 =?utf-8?B?UWRkK1pmdHg1Q2FNSmdKZDlHOHFTKzFpeFZ2cFNGRG9ZNklSMGRuM3ZUY0x6?=
 =?utf-8?B?RWw5ZjdzNVhBS1psbW9KT3F4WDVnQXlidnhQZmp4QXVMdEZ5T2Vnd2ZCV3U2?=
 =?utf-8?B?YmN1TFB4LzMySHhOeDd6MXJtSk9YQy9JUXJaNzJpY3NCZ3NGalVTVzh5cnh6?=
 =?utf-8?B?c0NkbjJvN1Y1citYeXRXazFRQTIvWjJZZ0w4UFNaRFIybEdiUnZ3TDkrbURx?=
 =?utf-8?B?R0lHWDdsVk5uQlNTWExEMkt1YWZlc3BSQVFIWEVFWFNNUnlabGl5VDRaZGIr?=
 =?utf-8?B?WVJkeEFJYjZ0Z1R5VTdkL3grbkhTeU1keHQrZEFMZDVSay9yZ0VuaXQ4K2NM?=
 =?utf-8?B?RkVvaVBwTnZPV3g5T1VsOHF6Ly93c3ZDbEExOEhkSDdJMXE2bjgwcG1tbDMz?=
 =?utf-8?B?czJYODUweDFzSG5QdlFGL0hlT1pmU1M1M0oxeUdMVUtYcmd3UzE2L3A5K1g3?=
 =?utf-8?B?VzdlTVFNdTBRQXkrSVJESnN0ZWh4ZkdyNlFtY3R4SzJZM3VONFpMOTdqVW5o?=
 =?utf-8?B?TDRSSHVKQVY5MCtMeXljM0xQblpmYW9RZnZua0R4OU5IejNDRURoeFUxR2lm?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8865194e-74e3-48e7-8a08-08dbd42894ef
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 00:31:36.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUPeRbiFcztdW38ugK+oeilfzSFPZ0Oy9VoRK8J7ShyTkFjwMeXjjDDZyt1qYOiawUWzfML+O0f2gx+pLASpyBIhnUR6qDUYjXfIwOu3KyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6527
X-OriginatorOrg: intel.com



On 10/23/2023 11:38 AM, Gerhard Engleder wrote:
> Compiler warns about a possible format-overflow in tsnep_request_irq():
> drivers/net/ethernet/engleder/tsnep_main.c:884:55: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
>                          sprintf(queue->name, "%s-rx-%d", name,
>                                                        ^
> drivers/net/ethernet/engleder/tsnep_main.c:881:55: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
>                          sprintf(queue->name, "%s-tx-%d", name,
>                                                        ^
> drivers/net/ethernet/engleder/tsnep_main.c:878:49: warning: '-txrx-' directive writing 6 bytes into a region of size between 5 and 25 [-Wformat-overflow=]
>                          sprintf(queue->name, "%s-txrx-%d", name,
>                                                  ^~~~~~
> 
> Actually overflow cannot happen. Name is limited to IFNAMSIZ, because
> netdev_name() is called during ndo_open(). queue_index is single char,
> because less than 10 queues are supported.
> 
> Fix warning with snprintf(). Additionally increase buffer to 32 bytes,
> because those 7 additional bytes were unused anyway.
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

