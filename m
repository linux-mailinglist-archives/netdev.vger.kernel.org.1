Return-Path: <netdev+bounces-52705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5657FFD20
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 21:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECEEB20FD0
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 20:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CBB4A998;
	Thu, 30 Nov 2023 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmAqq2cA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7F810E3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 12:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701377638; x=1732913638;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KUSBQkvVaBL30T3tibSt99uKt6pB9h2GkIBxUJ3S86E=;
  b=RmAqq2cA+0KtGBs7D0Ug3KbWz4PLa7vwK7s2GuuXBn38Rt/yeurDWMqc
   DhW5QRNJ+mH9TA61jpf7CYcMXOhgRahqs9/j9cQLL2kL/QlJFAZtsteNb
   I06RVDQG3gDpxnwntOkakkuhMKHB2wQX9scy6Umc1sxrgA5VemgeWddyj
   fpNEUgjD0rI0IIVneEx8ddm7D2qZ9oPZ94rUY78z3R643YtJNdrMNRHWo
   AD7ptJAypA1hX2Nfr2reZBLE3Me0onvW85JAP6siwdlsmBIimNbzhvYcP
   NLunUPLmPPYYm53YfVxwkYfNZoiHr9hHbfKxJLq1LHqneuUOkzA7PtVcL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="6623838"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="6623838"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 12:53:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="839931700"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="839931700"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 12:53:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 12:53:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 12:53:56 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 12:53:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 12:53:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXA8CZ3540jw37/UXCAK92JEnb7MrvrJzpPs7KnOAv9qtPlnuMMBTRycHGMNxdlKnRe1nv7nQCr+4SmQbAvk9xt+wLb7XYu3jRkCV5SG2PTvF8gbD5C/dlelW+X2+EkGqggreh98OOW+mAMriY5OS/8CCl4w+NyNct3Rpw0xbSwJxqtEwmoOWfDXx/6ayMhs4YGLhOhpzReWtI68JmKNdRpbUTVYLjVYY0W3jlOy9k2YRcWnYk5q1XXRXK4G7hc7wqZpGFXCcEzBMpjMs0LcAj3mIOlwnQQLNXEvdZUeUPrFhnFmpcOYUZO9Hq2HvxQX8Rm+I8Ft6ozNngjY8mdg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esF+BWFkPhZq7PS0p7zgpncffSSL/w3eM9GVI6dSDTQ=;
 b=Dy4eTN9WsEbKEqnHSGYA4worsCozFSnFhLRJYMyljfWggZsZd/bMMymdYuRUDibO1skqyDXbwrrtBtipkdbDUx5lapuxJfr8I/ED+gOqc7XcgAU08lzqOf3Tl+EZyfhYzWOS5+mvFksTCfphG/CCEcssbCiwNp3gLiRK4UULi2FvF2+mMf2yWqZ1GqDO1i5YNYeQURBTM6MFhTGinMh2NMmblQXzSkqhgWaz8Z0MLMk94SWtjqOTwQEldMJoBDySwtXfoMTnOC2Q2YkwEI0IsaoZxLg2U4tiJ5aeJ/yZ3C7q1fcW9CTwDN3hkW9bmcCgyy8oKGKWRL95GI/FuC4aBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 20:53:54 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 20:53:54 +0000
Message-ID: <d4d8769b-a96b-42c6-9d76-92174eb638a1@intel.com>
Date: Thu, 30 Nov 2023 12:53:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v10 11/11] eth: bnxt: link NAPI instances to
 queues and IRQs
Content-Language: en-US
To: Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ast@kernel.org>, <sdf@google.com>,
	<lorenzo@kernel.org>, <tariqt@nvidia.com>, <daniel@iogearbox.net>,
	<anthony.l.nguyen@intel.com>, <lucien.xin@gmail.com>,
	<sridhar.samudrala@intel.com>, Andrew Gospodarek <gospo@broadcom.com>
References: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
 <170130410439.5198.5369308046781025813.stgit@anambiarhost.jf.intel.com>
 <CACKFLi=if7dtWvvOnKPwxn-hmfzGMCMzfSacNhOQm=GvfJThQQ@mail.gmail.com>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <CACKFLi=if7dtWvvOnKPwxn-hmfzGMCMzfSacNhOQm=GvfJThQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:303:2b::35) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CH3PR11MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: dce53ad0-e877-428f-cad6-08dbf1e676a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chZyITx9Li/8X8pfLkVxz9PhgppIILmUnppWT5NGP1yPiUGCrhub0kwB+StwD/QC9DVwwNBRYOS2xOTgxg3qp96VlfQzVP4psyS1pykrKLeT8asaMzO3z5QC7sMoRKI74V/R1iHc9Ob05sU0fTHVx0Rcv9/x7VaLy7PcgyOrdgamAIaoEF1PbcpQFkEUwMCGH5BM57Fxi7cQWbqW9iCsebZ/bs6anfaZSE3LT1LZls1zVGp1U1ZpwWH7Ncp0Yk4gjJEMBPF82/A8wq6+gHLbdExqtlZ8aHJyMjqY7JoLOtltZUlLMqn/6GGqe2B4u6g5gdsKbB3HfpVHry1KUqCNNoGSSmrp0DKubRBNm+4UNLCSdbs55uxxWOhEdgRQOAlFDVcKXdIILBtQ1FONsE9+3lrXfrqbDElSKW6+1Q+QUXZ5xVF2wlf5bXsVMybBXquTHP+g5tVqG/PL8VKr/MZPawnoUjghpF/XP5vTDM60m+Shscgbt5l3u+q+d+b6aokHlDEecKE2MRJT7uysYziZnuLgN7NX4kPfj7KYvu59BP4C15FrrJJE1iQjnBJbxLMidR/ee9DEf/PF67MCapPYDxkUvB+H2UMpZrpMZM0H5dVQPnRO1ZjfWW78PYtwrRF9OyHLEE+uGaeASLebwIAmHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(6506007)(26005)(6666004)(53546011)(6512007)(2616005)(83380400001)(4326008)(478600001)(7416002)(5660300002)(8676002)(8936002)(41300700001)(6486002)(2906002)(66556008)(316002)(66476007)(6916009)(66946007)(31696002)(36756003)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1drbVVpRWpUZ0tKMXpkWmNyOWVOYUJuRmlza3R3ak9qUDhhSnRaeU1SWitZ?=
 =?utf-8?B?RTBpMlNVb2hFK05Ta3puQ0hEaGxyYXRzaGdBNEswN29kdnBHbVRubGxDME82?=
 =?utf-8?B?UEp2cytPaUtoZ3VRUVdzZkdVdlJ1STVqT2NmOWg2dDh4TVpVd3YzYyszSndr?=
 =?utf-8?B?ZnJPaHIzZEljSEFqUEtYZkJOZnRzK0xZaEtnNC9DeTNqOHVPRzdSb2Z4MG9Q?=
 =?utf-8?B?U014aGVqcXFGMSsvNmRsbzNBQjR2KytjUm5hM21qb25INEd1bkZHblVlNU9x?=
 =?utf-8?B?VmdHTFB1enl3c0pFTDIrMmJJMW9oRW95bXVpN0JYNXlrVUlnclAybTcySnBu?=
 =?utf-8?B?Y1FhVTdweUxIamxMalluNGpnTlpITUhWNEphQUNRYUNBczdjU3ZCVGgvVUs0?=
 =?utf-8?B?Nm9TMkpKckl6Q2VFMkxBakgxZWcvSXZEYy9QN0o4K0daQ2dNMkZpS3pDM29w?=
 =?utf-8?B?VmNKRHlGRm8wR29UQ1JHVVJpdWhUbTFkYzZ2V0JGSTRpamxpSnc2SzRVVnBI?=
 =?utf-8?B?cGgyVDdXN0ZvbU1kK1A4Q1QvYkNlZ2l6WUEwaUozQUNhK1c3bFRQQzlVM2dC?=
 =?utf-8?B?Zjc4UmZDZFYzVUhzUS90ZU1kU3lnSFAvK1NOV3BTTGxXQXNNRjdpN1pXL1pw?=
 =?utf-8?B?a1FNK0JoK3lBckxxck5jK0I3WEpJMmpBZ3JXUXZ3RFoxUHdFUWFjbkZicEpN?=
 =?utf-8?B?NGZGdm45b25jbGd0L3lISnBudmJYMVpvZ1Q2V2cyUXFLL1lBdnBRaUo2SEI4?=
 =?utf-8?B?dWpxWWNYUDBaSWhKZ3BTcGFJcVoyWXpWdzNkWVNEdnQwV3dKZmhDRmRHSjVS?=
 =?utf-8?B?OUVCdUdqNFNpV2lLVEpXQU11bysvVGprWVVQUzh5V3o2WVAxWStMOFlaMkN6?=
 =?utf-8?B?OXpXT2dod2NEWTNqQjdxY0d0QUdUd1dPaVZHbENGdDFRMk11SGRnMDMzbCtv?=
 =?utf-8?B?KzBYaWtwLy95WjErcFlXQWpsNFI2Ri9mUzRKamg4TG0zTFpjSWtzcTVEUHAz?=
 =?utf-8?B?dkFCUWVhYlJSbHkrc0U1STdlZGFnb1ZVQ2VCMS93RmdrMFVNR2IxNmRaTVlu?=
 =?utf-8?B?cDBudzhNRngra2MyRU9xZmZldDRkdFdaRHlrR1RpSW9qTGYzS0J4R3Q4MkVn?=
 =?utf-8?B?dFN0TmNVREh0ZkFON3hXZ0pqRnVKUE1jUWFOZGpUYkdRUU5KMHdodTdaWUg4?=
 =?utf-8?B?OHRTZmZJdEowRGtBbEUvalc4UDFhMExzL2QyV0hCdnN6aHozbFhteUQxWGx2?=
 =?utf-8?B?NWQ0QllycjhIYS9TK2pDSTFMT0JFU0ZTc0p3aFk2OFd3Unp1WEN6b3dVM0hz?=
 =?utf-8?B?bnFFSnRsc0N0MVZPVXFyU3FoWXlyYUFHcDg2eGpPem0xYXhTSVQ3SGR5Z0gy?=
 =?utf-8?B?YU9KZ1RNREMwTWY0cGdqZkY4YmJoYmJGSHV2bmc5a2k2dHdRZHBMVitJM05n?=
 =?utf-8?B?aXBhajJ2czZBT040dFBLQzkzUDhuZDNxTVUxb1BtVEthaStkODRyTDZ2U0ho?=
 =?utf-8?B?dmhVSmtxYnJEcFFoVGZMMkhFMFlybjhvMHkvVXY1V0FibGtqRUFQckl0SWly?=
 =?utf-8?B?SlprV3h2RVdkMEhoYk5qNmlJZExMcGJQNzV0d3ZOaEN0WmJXWEloQ3MxRXdQ?=
 =?utf-8?B?dEJMbGlsSUMzL0ZlSnMxQmRRK2o3dUVXRGFkRTVERThXR3RXc1hLeTkzNUJB?=
 =?utf-8?B?czJvU0pNTjFhMVZEN00xVnRZYXkvSkp3UEZlV2ZldXkrU1YwcXZuNVlqaTBa?=
 =?utf-8?B?SFhkZVc4SjFCWmhCYlR6TG9JaUlLdTg4OUREbi8yTTN5M1FKcFV3VUZ1K0Vs?=
 =?utf-8?B?a3hrM3dnRzRDRUJVTExRWWRiaUtVb0Z1dmhBeURWSVEwVUs0cFgvOTZiaHJ4?=
 =?utf-8?B?RW5LeGU4UEtweU4wc3QxeTBlVXFULzg0S2VPQmdCanNtcElSRzBHQVpGL1Uv?=
 =?utf-8?B?Y3Nta29DRTNCQVUvaEM2a2ZNaTNrQzVKWVhVN25rZWU4MzJFVWV0bjR6aUxu?=
 =?utf-8?B?YzdsWG5VR0VuOTQrcXFYYnVpQllyQUZoL2ZOcEtiNG5rbE5sVHdEVERHNTJu?=
 =?utf-8?B?UDFNeGR0U3VEZXdRL3RCNlBLcUdPaW9yL3pRclkrd0Z0YmpqMmlFYzl2cnBX?=
 =?utf-8?B?Z2lKd2V3L2xqY0JvK0VweklDSDFnZXpSZkZ0cndYWE1EemtPckJ0Z0t2TWdu?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dce53ad0-e877-428f-cad6-08dbf1e676a6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 20:53:54.0324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSNEjHCCml+0rJ753LXYFzd/SMMdHUWwMUhQ/0mkA3MD3QV/h0PIK2jJmRFHypb/kbCttrBW4nI7ZIPcvDZl8/ZQ2EtSB835Ff5WSmICt6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8383
X-OriginatorOrg: intel.com

On 11/29/2023 9:52 PM, Michael Chan wrote:
> On Wed, Nov 29, 2023 at 4:11 PM Amritha Nambiar
> <amritha.nambiar@intel.com> wrote:
>>
>> From: Jakub Kicinski <kuba@kernel.org>
>>
>> Make bnxt compatible with the newly added netlink queue GET APIs.
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> ---
>>   drivers/net/ethernet/broadcom/bnxt/bnxt.c |   12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> index e35e7e02538c..08793e24e0ee 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -3845,6 +3845,9 @@ static int bnxt_init_one_rx_ring(struct bnxt *bp, int ring_nr)
>>          ring = &rxr->rx_ring_struct;
>>          bnxt_init_rxbd_pages(ring, type);
>>
>> +       netif_queue_set_napi(bp->dev, ring_nr, NETDEV_QUEUE_TYPE_RX,
>> +                            &rxr->bnapi->napi);
>> +
>>          if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
>>                  bpf_prog_add(bp->xdp_prog, 1);
>>                  rxr->xdp_prog = bp->xdp_prog;
>> @@ -3921,6 +3924,9 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
>>                  struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
>>
>>                  ring->fw_ring_id = INVALID_HW_RING_ID;
>> +
>> +               netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX,
>> +                                    &txr->bnapi->napi);
> 
> This will include the XDP TX rings that are internal to the driver.  I
> think we need to exclude these XDP rings and do something like this:
> 
> if (i > bp->tx_nr_rings_xdp)
>          netif_queue_set_napi(bp->dev, i - bp->tx_nr_rings_xdp,
>                               NETDEV_QUEUE_TYPE_TX, &txr->bnapi->napi);
> 

Okay, will wait for Jakub's response as well. I can make this change in 
the next version (after waiting for other comments on the rest of the 
series), but I may not be able to test this on bnxt.

>>          }
>>
>>          return 0;
>> @@ -9754,6 +9760,7 @@ static int bnxt_request_irq(struct bnxt *bp)
>>                  if (rc)
>>                          break;
>>
>> +               netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
>>                  irq->requested = 1;
>>
>>                  if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
>> @@ -9781,6 +9788,11 @@ static void bnxt_del_napi(struct bnxt *bp)
>>          if (!bp->bnapi)
>>                  return;
>>
>> +       for (i = 0; i < bp->rx_nr_rings; i++)
>> +               netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
>> +       for (i = 0; i < bp->tx_nr_rings; i++)
> 
> Similarly,
> 
> for (i = 0; i < bp->tx_nr_rings - bp->tx_nr_rings_xdp; i++)
> 
>> +               netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX, NULL);
>> +
>>          for (i = 0; i < bp->cp_nr_rings; i++) {
>>                  struct bnxt_napi *bnapi = bp->bnapi[i];
>>
>>

