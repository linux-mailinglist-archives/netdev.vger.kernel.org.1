Return-Path: <netdev+bounces-40991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A247C948F
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3437B20B50
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C298125A3;
	Sat, 14 Oct 2023 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3Mj1SZJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765FA15B8;
	Sat, 14 Oct 2023 12:20:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F940AD;
	Sat, 14 Oct 2023 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697286011; x=1728822011;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qvbOoUt3dI14lweWiYOcgDGfDqkD/n8aH1iluMORqBg=;
  b=K3Mj1SZJzJcX6z8Gxrsqd51pDNZdMDF44P99Sa7pMEc6HX0ERtrH9bnT
   9pEktOq4X9Z9XEtYXDCHOFc1dsUvDOzTERU6AfxwwEEVwNeuYioF0DVkd
   NMwWh79848PyNWj1y2wSZGePlJEkv/Zhsbrisyn6SrZCL8B4J0mhnYvuy
   SHVPVZx8utIyI43J1UanyQn76OafcGRCQg+JYGtGosmHFQSpwEhHj9xsa
   gV5oHVf2xS5XhWHqdZtRpOAdWnHIzADhLgrH7i3jCbZnizwCVGErjgdKB
   AWI5Mo+jfZ6fnGl5NZQSroKqzE7aek5WWkjIe5ki2qRZlAeQwL65NQpvp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389182004"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="389182004"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 05:20:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="748660822"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="748660822"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2023 05:20:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 14 Oct 2023 05:20:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 14 Oct 2023 05:20:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 14 Oct 2023 05:20:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0vmnbIw+eKnb+/DukraH/nAgyPq8ZopKiWiaxjh/LDS/wFCXHYUIz9l6qP3AH4h234aXiOkH7XYAmhUsIKQPSxP5PaFtpiD9gTOkrSKkk0IewTxHBTufY9i33kAzZ691rS/TEx8IN9HdAcYFcsyivfoqCugUajVKrs7ipRPNe8FaLVbtP2+whvfowLsMXfYJT/hcauo4SbH6vsd6Y0B8wLAaW5AfELLc0tPW2fgAkSXGzFv7R92bVfQ3tQ7S3ZShVIyNoaCYR0pJU5yahYvXkmDJQId12Y986T58C0tfmkpaG8qtLzxEPVMhauCpeXW6yTyAqs1MJIdq1iBsFZzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8bVb5HjZ+hwYJBpFAb15EgUvMJABtde6w+lYzv8IJU=;
 b=dG75TxV/C9s7vj59UVIp/kWny2cScIF/VIg712+r/1LJ3KcOIc2W9M7/HW5FIoAGMZBda2dz+qxJCh61+bdXmPfYf8awLvMTijYujEkS/D5nyNJcTRqhclafw9B5PAAiIQl/yJhTrqdcKOUImkfkTyu0p3nB8dfs0K1E54Clk6CExSep1JwM/OdZ/bK9KONQQBKqEw18HZJx8MMDaLJ/6m4vZ7hiJzl8bA9la2cLR6eOr1j2IpBWMm35fQwefZsjjh5lZc6S728YsJ1HgwxpoqTzMHEVHmp/TkJAwtwn7VIp9MYeGXXJgLZ5n1oUDtWtQon4iDNqPE9H8LAGPFbFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by CH3PR11MB7348.namprd11.prod.outlook.com (2603:10b6:610:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Sat, 14 Oct
 2023 12:20:06 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::2329:7c5f:350:9f8%7]) with mapi id 15.20.6863.032; Sat, 14 Oct 2023
 12:20:06 +0000
Message-ID: <cf6c824a-be09-4b6c-b2a2-fb870e9f0c37@intel.com>
Date: Sat, 14 Oct 2023 06:19:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
To: <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<corbet@lwn.net>, <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<vladimir.oltean@nxp.com>, <andrew@lunn.ch>, <horms@kernel.org>,
	<mkubecek@suse.cz>, <linux-doc@vger.kernel.org>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
References: <20231010200437.9794-1-ahmed.zaki@intel.com>
 <20231010200437.9794-2-ahmed.zaki@intel.com>
 <CAF=yD-+=3=MqqsHESPsgD0yCQSCA9qBe1mB1OVhSYuB_GhZK6g@mail.gmail.com>
 <8d205051-d04c-42ff-a2c5-98fcd8545ecb@intel.com>
 <CAF=yD-J=6atRuyhx+a9dvYkr3_Ydzqwwp0Pd1HkFsgNzzk01DQ@mail.gmail.com>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <CAF=yD-J=6atRuyhx+a9dvYkr3_Ydzqwwp0Pd1HkFsgNzzk01DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::39) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|CH3PR11MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 5218fad3-1c8e-4752-57b7-08dbccafe676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xu8utO6vABe+I/6fx4T2RDzgkGpBCG0v0IAmIy7f4e6bXfksYsdZDNBJPDXSAm1h+e+Y9ymEXEmuqxdmhGJYPi+O3zDsqRFalbRlHahwu3N7JBtD9MgPjirAvoIznhCBOk+C2SJmasiAbnzZn0Q4zHq9P+aK4Rrf5AzorH9w/ZN4rLP6gFATwGmeI5eeDgYX6TgFsTnZU5OYj4UyPVpLVhtl/kh8Vj9EM3gk0B17RpsA0TK1fEWDYZJfPsyYE9sLz2GaxqSDJyRkmq3n9iOZ1/ZGptAb7ZBLgK5T2cJ3Fcap6B88pCd7smAZ0fZB1q980qWJzMYKIyyyTCUMv2QEPCQeGQSJ8mrv4XQctsnxvXvsWj4vs9t2C4QpV7IX8f6BFczvHbuVa4dRDn167NpCdZuDj5ZGi1sO9OoZvRDJ9os1iXX+Id8PkicM6WSstmrAzPcuTCukbjpG3MSZK3HJLI9YPjX7PLp3TIwGigGTTRLF5rQvpN8nDN5SOOb6yZeq1q1UkDyxp0NvjSaYxpz637vAc0ETAIWub8zADEJY16ZlI9GXX33oPye9uVk9oA1D7qv8sBMhcfkNjv7WTVhXiA+8lSK65EipJeBXqROMAQM8NgT2A14+ZfzrPP4NWBCL/muqbMYO7Jhv1QZiQpJKpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(44832011)(8676002)(8936002)(4326008)(41300700001)(5660300002)(2906002)(7416002)(4001150100001)(86362001)(31696002)(36756003)(82960400001)(38100700002)(83380400001)(2616005)(26005)(316002)(6916009)(478600001)(66476007)(66946007)(66556008)(54906003)(31686004)(6666004)(6486002)(6512007)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmZJZGhOdHZxbGh0dktUNlFmZjkydVlUaUNBTEhRdHdzWjRBdHp5Q3NXSlNo?=
 =?utf-8?B?aU1SamhLVXREdjc0QjFyV0VVTWxad21YcUlmNXMyOGRZTTNqdW01QjF6SWFz?=
 =?utf-8?B?WVhlMGFGTXlyeUM3S0d4RTYxZEI4WmdZRnNsaUtJSlJ6QzZMSXorcGhmTFFK?=
 =?utf-8?B?enBscUU2SE1tSUpZZmErR3hQL0w2a0xsRmRZQlh2NldtaDczbU5NNTdiM0Nz?=
 =?utf-8?B?ckpCMmZkTnVLVlRRWi9FRklrNnU0UE96NUQ3VjZmUjFRWVgydXhqZCtvb214?=
 =?utf-8?B?OWJoWnZvVFJXcm1Lc1o5RFJOaDBULytqMk5ndEdoWUVBYU91WHVtTUZpZmp5?=
 =?utf-8?B?OW9DYXNEWi8xNXY1dkswY0dSRWFTeEdPOEEvWVUyNDRSc29BK0NtUkIzMFRx?=
 =?utf-8?B?MDlnOTEvZ1E4Z0g4ZkJsRlFSeXFqeERUbHY2b0xHZVRpWGNXbWtCWGNrZXNN?=
 =?utf-8?B?aExmSkpIcGY4NXowTU95UUFMSE1qWWthM05WU2pmaGErdEdOK0c4dHJZM3pZ?=
 =?utf-8?B?c1hBYjJRTS9nQ2xLcGJLVkNhbWZCOUZMNUFENmVZN0JZbm8vWE55OHFIbGFx?=
 =?utf-8?B?KzFtS0RHZFVkamNKWE53Y2tXRnlMVTJ0ZkZ0anZjTEIzeXNSeXVTbHlXUk5P?=
 =?utf-8?B?MlhraG8yanp2OEpNMzl6d0k1WlhFZm5FaXNZQmVVSE8zZmNyM1NpV2lmYmJq?=
 =?utf-8?B?Z0tTZmFhMGRJL2IvakNyUVBTb0lTOGhFK2F5bDNuS0QrS3dsWHZkZ01WM2FJ?=
 =?utf-8?B?anVQY0JTMkJaY29JcnRlRkpKd25vYUdFdWhRcWZXRyt5RkVCc3VveFZNanZM?=
 =?utf-8?B?MEs1YVEzcTJCTTlRMDcwTmh1SlpEVEFqNFh0UENrR3RDVU1KZ0VEdFNRODlj?=
 =?utf-8?B?L3hxWUdYZTc5aFNYTTlXem9YbHhuU2pXa3BvbHVhL01xa2ZwMEh6RFdaV0lF?=
 =?utf-8?B?YUZyRUpOVWF0cVpzSDdjd0xndEFCbXo2RW9PWHRXVDZlMTFId0dtb0swZU5T?=
 =?utf-8?B?dnR5Z2I1NGp4aDJvS3ZQOFg2aWp6dkhzd0RwZVg5TnJwZEEwdXpqV0JnSFg4?=
 =?utf-8?B?Q0JHMElEYzJzMzN6Tk42T3lOaFlNQWxienpCNlQzR29kdHhoVDRJNkN3UjlQ?=
 =?utf-8?B?d0xNbGp6VzNJZU9aQ0c0YWQwWGFCN2h2bHBoSmNpTU1GcnY3ZS85Z25vOTIr?=
 =?utf-8?B?SVZPNFk2bFc3UnhFYS9XRSs2WjM3VWxWNTBmejd6T2VxWC9teHo4TWh6bEhF?=
 =?utf-8?B?WFUyb1BCcGNBZXBRMGdIMXp2cTY2NUhQUzJoV0JzMlVteHNQSlBoazcrR2Zt?=
 =?utf-8?B?U1h6RDQwcTd5V3p2dGlEVUFINXh4bFh3QUdZalVFaGdJTzVaQjd5ZEtOSnBx?=
 =?utf-8?B?anNuU0ZFNEdHVk5HajNUZ1Q4dFZzK3NHdjZTRGY4b2NkdGRGaGY3ZEdSbjVj?=
 =?utf-8?B?aGE0Yk9Ra0Rsck5zdHU1VEc1cUVJZEdMdmtwWVc1Q1BDR3lVTTEyOU5oVHpJ?=
 =?utf-8?B?RFNudllTM0RkTUpxWGVUUFZNWG9nVkNGeXdvSkV1SkV3a2xyNGJsWTBKUzZC?=
 =?utf-8?B?UXo2Ry9HWms3TU5aT25lRGtkTFZXSklZVGJ0R2xId25oQng2K2JZNGo4eFN3?=
 =?utf-8?B?Zk9hMmxUdHVDbmZIcVMrZURicUtpL1g2ZXpHakVEbkx5RThTdU5iNS95M2x2?=
 =?utf-8?B?Z1g0Ymo2a2sxSDRBRnBqMy8xaFh1Ympmdmd6SmNXWElVZkRjS0JTb01UYmFJ?=
 =?utf-8?B?c1FYck0vbHg2ckNvUjNDYmw0YTNTQ3pla0htdVNKL3B1OEZUc0NEZ0ZiQzI0?=
 =?utf-8?B?MEFpTTRJUGFCZG05OVNlK3ZoeWZnaE9SWkNLVVhxd2xEd3p6aXFFUmQyS2Vj?=
 =?utf-8?B?K3FySDc3VDdrMFdRYnhNZjhXL1FQaFN0SHNOUTJrNTFUcGhnN1JkSUYvS2ll?=
 =?utf-8?B?ZG1sZkl4YTJpWmIvMFVZVHhrWWl0VGxQd0Y0UjlQaTdQVlNWN3FTandKcDdN?=
 =?utf-8?B?djlHNkdxckFmWk5Dd0FuWFRmQmJOMGVnMlhCdURkcFNmSlREQzdFckpGYm5C?=
 =?utf-8?B?UXppUVFlOU53dkZmc29xdXdMdlpsR0hQZEpSci9UWWY3RCtXRFI5ZTloUEpF?=
 =?utf-8?Q?8lbcjc2ApzTByHfoo51kUS95M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5218fad3-1c8e-4752-57b7-08dbccafe676
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 12:20:06.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+SyCGdF+0iMEZbpL3iSpYEAOaSyhX+Ef2HdNr8dohqkizP0TbDEweTKGxIDehBGt0+QOinieScsk17h1twKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7348
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023-10-11 16:45, Willem de Bruijn wrote:
> On Tue, Oct 10, 2023 at 5:34 PM Ahmed Zaki <ahmed.zaki@intel.com> wrote:
>>
>>
>> On 2023-10-10 14:40, Willem de Bruijn wrote:
>>
>> On Tue, Oct 10, 2023 at 4:05 PM Ahmed Zaki <ahmed.zaki@intel.com> wrote:
>>
>> Symmetric RSS hash functions are beneficial in applications that monitor
>> both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
>> Getting all traffic of the same flow on the same RX queue results in
>> higher CPU cache efficiency.
>>
>> A NIC that supports "symmetric-xor" can achieve this RSS hash symmetry
>> by XORing the source and destination fields and pass the values to the
>> RSS hash algorithm.
>>
>> Only fields that has counterparts in the other direction can be
>> accepted; IP src/dst and L4 src/dst ports.
>>
>> The user may request RSS hash symmetry for a specific flow type, via:
>>
>>      # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric-xor
>>
>> or turn symmetry off (asymmetric) by:
>>
>>      # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
>>
>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
>> ---
>>   Documentation/networking/scaling.rst |  6 ++++++
>>   include/uapi/linux/ethtool.h         | 17 +++++++++--------
>>   net/ethtool/ioctl.c                  | 11 +++++++++++
>>   3 files changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
>> index 92c9fb46d6a2..64f3d7566407 100644
>> --- a/Documentation/networking/scaling.rst
>> +++ b/Documentation/networking/scaling.rst
>> @@ -44,6 +44,12 @@ by masking out the low order seven bits of the computed hash for the
>>   packet (usually a Toeplitz hash), taking this number as a key into the
>>   indirection table and reading the corresponding value.
>>
>> +Some NICs support symmetric RSS hashing where, if the IP (source address,
>> +destination address) and TCP/UDP (source port, destination port) tuples
>> +are swapped, the computed hash is the same. This is beneficial in some
>> +applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and need
>> +both directions of the flow to land on the same Rx queue (and CPU).
>> +
>>
>> Maybe add a short ethtool example?
>>
>> Same example as in commit message is OK?
>>
>> AFAIK, the "ethtool" patch has to be sent after this series is accepted. So I am not 100% sure of how the ethtool side will look like, but I can add the line above to Doc.
> 
> Good point. Then let's not if the API is not final yet.
>>
>>
>>   Some advanced NICs allow steering packets to queues based on
>>   programmable filters. For example, webserver bound TCP port 80 packets
>>   can be directed to their own receive queue. Such “n-tuple” filters can
>> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
>> index f7fba0dc87e5..b9ee667ad7e5 100644
>> --- a/include/uapi/linux/ethtool.h
>> +++ b/include/uapi/linux/ethtool.h
>> @@ -2018,14 +2018,15 @@ static inline int ethtool_validate_duplex(__u8 duplex)
>>   #define        FLOW_RSS        0x20000000
>>
>>   /* L3-L4 network traffic flow hash options */
>> -#define        RXH_L2DA        (1 << 1)
>> -#define        RXH_VLAN        (1 << 2)
>> -#define        RXH_L3_PROTO    (1 << 3)
>> -#define        RXH_IP_SRC      (1 << 4)
>> -#define        RXH_IP_DST      (1 << 5)
>> -#define        RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP/SCTP */
>> -#define        RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP/SCTP */
>> -#define        RXH_DISCARD     (1 << 31)
>> +#define        RXH_L2DA                (1 << 1)
>> +#define        RXH_VLAN                (1 << 2)
>> +#define        RXH_L3_PROTO            (1 << 3)
>> +#define        RXH_IP_SRC              (1 << 4)
>> +#define        RXH_IP_DST              (1 << 5)
>> +#define        RXH_L4_B_0_1            (1 << 6) /* src port in case of TCP/UDP/SCTP */
>> +#define        RXH_L4_B_2_3            (1 << 7) /* dst port in case of TCP/UDP/SCTP */
>> +#define        RXH_SYMMETRIC_XOR       (1 << 30)
>> +#define        RXH_DISCARD             (1 << 31)
>>
>> Are these indentation changes intentional?
>>
>>
>> Yes, for alignment ("RXH_SYMMETRIC_XOR" is too long).
> 
> I think it's preferable to not touch other lines. Among others, that
> messes up git blame. But it's subjective. Follow your preference if no
> one else chimes in.

Jakub,

Sorry for late reply, I was off for few days.

I'd like to keep this version, I don't see any other comments that needs 
to be addressed. Can you accept this or need a v4/rebase ?

Ahmed

