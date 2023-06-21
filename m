Return-Path: <netdev+bounces-12799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1757D738FAA
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E541C20445
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A319E61;
	Wed, 21 Jun 2023 19:09:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB2846D
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:09:16 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227091710
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687374555; x=1718910555;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6lVc0QjG8tKK63l0d9oGQyE+4tdxwjqN5MBtX0YKGe0=;
  b=ZrMQkJFVdX7Y7H7dWwjj64W+7D60T59nZFHtE3etWGuoJOxPy8InhYMH
   UTuXatWDZcPr7RGq4lEXYCPbr9Rk2dRbIut+AceerpQh8wJB8J8TKJ6VF
   LCE3MmL1K5YponV7I7PQLISTleirXiEKRWQB048Igs9GqDh5TpyBjI4Ta
   Um0H+LZCrYR1rtgGBJAmlIWWn+lZelMoHDH/SLnN6XQQEsUHd5iLF2wgS
   ynl+dcRK7E4cCm7H/O3UDJIyUfpcDdVXsS7NUmcu7lNwtjJZKlFeJBRZm
   uUMDEzoijwEPVWmOJIOpp6oVxT/fZK1yrqYYBm83Q8D00FS2uO8Ym8bwv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="389858620"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="389858620"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 12:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="664775089"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="664775089"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2023 12:09:13 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 12:09:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 12:09:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 12:09:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LevV5i++sqGWfp5QUhZtNvDzG8hG4qnKHKOca8GImiIcORyZdaW0QZ2bV/ZiHtyNqof6D8p8U6zz2IpEvOS1eTYWvuDHg9IAQHr5CkkVTVJVyhJbOr5/npdn/bhyRtAsUFpZk3mkt6C2WvT1boXnbWXXgcY1bD3Lz0zik3PxqUKPk9quxO+hocwoL8q5YuHp3Y3oQ5UvjiiYKR3tteQOVbnu9ahBk0ZgugLYRUFKkFnhpsYdP+xFwaLAqusuvh1SXTlmuKyvreJVeVo0OdqWDKwgl7f2vjfskp5XPZ+3WCYkoX8dRxRyLYL6U4IbaFSV9eHJZJFxMsB6Vx4hWtOs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StJ/P5Z63ttk/c8uzb59aOh8qF98YELcxgusfT75fTU=;
 b=BnivBZbrcSu9CgKqPJnQecr9rlNa3IZuN9KjnO+541yLphI57sfw4ScN/k29PSvMCQCzsPI8Ue0D/xyKn/ob1smpuMEFXmiWDX3zAX4iPPzdDr7wa+/yNUjx1qYWiBGvwOAnM/hBfvw3kmzl5UHAf81UDeooH7OsO2nsl+FtEYaoj7Dhty+ExO7j0BBNKreX6L25yU1wlAVFgSM6hrRx5B75VeqQeru9YA2pxq1oac2IIHJ3V0ooTuXIWXA0nQkJeH4QB2bEYxOd1fAzbCGxa2QQbdJA/QNPsul3wHhP6Obf6c5Aoo/pC1FWLZhaBUC4bBizbswqCVfS2FY2gCiw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2599.namprd11.prod.outlook.com (2603:10b6:a02:c6::20)
 by DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 19:09:11 +0000
Received: from BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::ab9d:1251:6349:37ce]) by BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::ab9d:1251:6349:37ce%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 19:09:11 +0000
Message-ID: <9528682b-93bb-2797-6bd5-0f40710d306c@intel.com>
Date: Wed, 21 Jun 2023 12:09:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Subject: Re: [PATCH net-next v2 12/15] idpf: add RX splitq napi poll support
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Alan Brady <alan.brady@intel.com>,
	<emil.s.tantilov@intel.com>, <jesse.brandeburg@intel.com>,
	<sridhar.samudrala@intel.com>, <shiraz.saleem@intel.com>,
	<sindhu.devale@intel.com>, <willemb@google.com>, <decot@google.com>,
	<andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>, Joshua Hay <joshua.a.hay@intel.com>, "Madhu
 Chittim" <madhu.chittim@intel.com>, Phani Burra <phani.r.burra@intel.com>
References: <20230614171428.1504179-1-anthony.l.nguyen@intel.com>
 <20230614171428.1504179-13-anthony.l.nguyen@intel.com>
 <20230617000101.191ea52c@kernel.org>
Content-Language: en-US
In-Reply-To: <20230617000101.191ea52c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To BYAPR11MB2599.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2599:EE_|DS0PR11MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d7a151-9c01-432a-6599-08db728afeb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saBJRteQ0MfQ7EwRp3qZrZKtTByHmEEojQlBtLlrQFY01sHDMx9AOSUSq7qZc4n+LROnPyAkwB5jCVzyJEKrWQEPuUnIVP+Eiszmpi7xZhQ94p4m6OrlPDOyCXhvsLhCdsmHQPTrCbMk9oFTXjEwd4iU4c2Ck6AWKkZ2t39cGd5CMnFSeb9za3od4e17q85H7ITq6pGtgpklVKZJBFc1Hax93kWv3g9xsk4oz0UIZbUyxP7OixFXVTwYFaY0pnJEG3NSpBtSP87ubSwf6cJHLQCaYLantjC0av1rTP2/Ux+eE64TdlKyNks8b0757mTDD2rvm+Rli/UYfTYFb6vepcd9T57YS0/eWjM82ngCa94Y2p1ZXnPByKeZOYgnDGS4cZSd2Fj4m0lCCRzmwDtHAxvVfppC6n1aqByt08nhjNPtF0JuOQF6QXGELbQV10XKa2UxPyhumUZ5HY2cAg2VgyPVLPIRMStNFaO3AHkaMbS8y93JB+7qgI9cKAk4yztkA+eOEI+AS4bDzBMFITU40YuuRN3aoN4bd1jUVbEAMu2NYZ7tV5JqhuEfxHiLRjm3j0mTjuXdFq5C30bW6crTnfWcVPlOC96WGCeKK5GqzDr/p/FEyNXQS75gtG8ROlrp1Djq2hpqmuUWNXNmzz5oTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(31686004)(36756003)(66476007)(5660300002)(7416002)(41300700001)(38100700002)(8936002)(66556008)(86362001)(8676002)(4326008)(6636002)(316002)(82960400001)(31696002)(66946007)(6486002)(107886003)(26005)(6512007)(2616005)(6506007)(53546011)(186003)(2906002)(6666004)(478600001)(110136005)(83380400001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1JlVUtwSE9CZTJyRU9tRU16c2M3aWZTbXdGdERncTZEZkdsYThvT213bFpV?=
 =?utf-8?B?TDBiQjBVdlp4KzRBenZyamFyUlh5RWszVThucnpyNEYvcXpUMVFCNFhTUlJI?=
 =?utf-8?B?UmtJajljM2RZSmhHb002MTVRVFVnSVJrR2xWK00ydXFJZFBwOFBuc0ZnaFh0?=
 =?utf-8?B?T0d4dURqQmtKVXIySnpsbTZrdTdIbmw3dE5LV0twUWdPS1pPQXZnT3Jub1NQ?=
 =?utf-8?B?a1NJYUpmeEF5WWZGNXdwMWlFL0VlV1o5UTFFQWtwenFYRmJTSlp1LzQvRlBw?=
 =?utf-8?B?QlIzWHhVSFFBYlVBd3k4Nno3RVZrd3cxTkU5U1dSY1FaUnB5aDFRUndSRTl3?=
 =?utf-8?B?alRVbFBoR2FFeVJPdXdhampiaDZMcGpyNFBRQUo5bEVMTDVpNzRWNll6REZi?=
 =?utf-8?B?U0ptYkFQaVMxME0rcFMzcEJ4bU1ZeXhEQnBraGpLdmtGSWlYTFZDZ3pURTFr?=
 =?utf-8?B?MmQyUStpMHJVemFxKytzZkcyN0hrN3ZNcnkxQ29Ca3ViL0puWkkycCtyWEdn?=
 =?utf-8?B?UnlkSU1ZYVJNaFZFOG9tN3E2ZU9TMkFERklLKzZhdmNYOFJObWQwUHhOR0RM?=
 =?utf-8?B?UzkwOTdTMG5MVzNPcGtxUGVwNnZmaHpxT0dWYW9VMENLOWdCMnJVR2FnTUtP?=
 =?utf-8?B?R2wyYnhnNXZmclZHM0ZJU2M2M3ExTFVFZSsyeTZhcXNtUm96OUdaNGMxWG5Y?=
 =?utf-8?B?dk5wVW1OeXpxNnlOUUozRHd4STZQWVRvaU0yYWJyK1R0eUJGT24wd2pJZFg1?=
 =?utf-8?B?UGltbG5YdHFkY3dCa1NiTHlsMjQvcTZyWU1RRDd3bDBuQkk1NDRhQjF6SHlU?=
 =?utf-8?B?Kzlib2R4SXNtREc1V1UxbzRvN2JwNGtuaXRmeEFiWkQ1amViNURmcnNINlZF?=
 =?utf-8?B?SllaQmV4ZUdkWmlWb0tCYVJ1RmU4bUxyN1ZFMVM1Y01lQVZqVUFaSkV4U1M1?=
 =?utf-8?B?S3JuU3FDaDNDQTJlMDlvMWZmZzVFMzZCQU41QlJrK1ZCeXB3YjVYVitEZzJX?=
 =?utf-8?B?M1prTklUTUxtaUVEWU44V3dDYVo4MjRjYUtFRGM0cFcvUWlQaVV4OVhSaVMv?=
 =?utf-8?B?R2tNK3ZYRjdsRStubXh4T1U1Z1NjT1UycnJvTXJiV0FjKzNGWE53bU9lUWho?=
 =?utf-8?B?c3hteTRYcEtNT3JTa2J4eWdoMlZzZzNYQ2xXaE1RQ0hVc1dqaDdaellqaE4w?=
 =?utf-8?B?UHNpdy94V1RhMHAxUVU0blFLWDFiYkxvNWZwOEhXdU1iRTVBQ25sZndyeUJM?=
 =?utf-8?B?OFhoeW9rbXhwaDRuZ1JHVUcwU3IvYmptQzlQRERVYzRJTEhYRTgyMHpoNkZT?=
 =?utf-8?B?ajh6NCs0TjVsaDVmOHM1a1lGejJTYlVhZFlhQWxwZG9wY1ZsUmc2VVF0a0ti?=
 =?utf-8?B?RFFnYk8rV0ZzYjB6OGRFaGdSTGFmQzNpd1hDUFAySTNVVTBxY3MxdkdSWEVD?=
 =?utf-8?B?T1Z5S0Z3cEJhMi8yd0dJSisrTnJEZzRSUnBRRnExRkpGL3pVUm0zb1JsRUps?=
 =?utf-8?B?Wm9SUHgrU3BXSDdQZENJRXlKL2YzZTFibWVsSGovVUw0Q3RYSEdyWnZncXB6?=
 =?utf-8?B?Wmc0cFRTSFp0R3lJcDgySDNLc0xEcHRYWU40dE8yWWtTNnlBZ3VpY2tTNEdV?=
 =?utf-8?B?Y0RJZVhIWUxSaFQ2anVhdU16V255dkU3UnFHWVRjZm9SaFN2dHFFeE9EcDEw?=
 =?utf-8?B?d1Jsb1VVdi9LUk1acTFUVmFCc2g2aGVHNnJZZys3YWRDZEdiSjBXVnp1dXRn?=
 =?utf-8?B?ZFpQaFQreldGakFaMG9kWE4vdFZSZmVNZnc5bGRuelloZWRaRG5HUWxzaG5t?=
 =?utf-8?B?WGY5R3RHb2ZZbHRnU2ZmZHQ3VVNiSEhScFVRTXN2Z1BqWERWQzJ4ZkQ5OHoy?=
 =?utf-8?B?UUM2Sy9lYUV3M0RtNGpPT0J6RE9TOW1DNWZlaWdQTEUwY2JVblNaY2JTS0Jq?=
 =?utf-8?B?bUZOYlh5cDNmQm55QWxmZVFCajhSUFFrb1hNUVIvYitLNlpPbGxmRHFqOHV1?=
 =?utf-8?B?bkRlZDExVENqUzFublhicGY1NGNCTWkxOU5GR21mY1hjZjVtY3J4YzFNUlNG?=
 =?utf-8?B?Vzg4cTdZUG1VVnNTSTA3UXFpKzBVYkcwRDhweFBtWUFSZlg1RmZPL2dHSHhK?=
 =?utf-8?B?bG90aEFNVC9JUFRKNCtYMVpybXlUb3JPYTFJYVlSV1AzYkEzbWFZc1Myd0NE?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d7a151-9c01-432a-6599-08db728afeb4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:09:11.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ko+7bcqr+lJQtF1uhCTEMXDRhAyXeF+5ewiiGIOhPqTbt6kZdW4oVSl0e+MVOQGSkNirulBhEBRRoFa1e3yxnXh2ibUKp9Ked0eugHXP7GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8205
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/17/2023 12:01 AM, Jakub Kicinski wrote:
> On Wed, 14 Jun 2023 10:14:25 -0700 Tony Nguyen wrote:
>> +static bool idpf_rx_can_reuse_page(struct idpf_rx_buf *rx_buf)
>> +{
>> +	unsigned int last_offset = PAGE_SIZE - rx_buf->buf_size;
>> +	struct idpf_page_info *pinfo;
>> +	unsigned int pagecnt_bias;
>> +	struct page *page;
>> +
>> +	pinfo = &rx_buf->page_info[rx_buf->page_indx];
>> +	pagecnt_bias = pinfo->pagecnt_bias;
>> +	page = pinfo->page;
>> +
>> +	if (unlikely(!dev_page_is_reusable(page)))
>> +		return false;
>> +
>> +	if (PAGE_SIZE < 8192) {
>> +		/* For 2K buffers, we can reuse the page if we are the
>> +		 * owner. For 4K buffers, we can reuse the page if there are
>> +		 * no other others.
>> +		 */
>> +		if (unlikely((page_count(page) - pagecnt_bias) >
>> +			     pinfo->reuse_bias))
>> +			return false;
>> +	} else if (pinfo->page_offset > last_offset) {
>> +		return false;
>> +	}
>> +
>> +	/* If we have drained the page fragment pool we need to update
>> +	 * the pagecnt_bias and page count so that we fully restock the
>> +	 * number of references the driver holds.
>> +	 */
>> +	if (unlikely(pagecnt_bias == 1)) {
>> +		page_ref_add(page, USHRT_MAX - 1);
>> +		pinfo->pagecnt_bias = USHRT_MAX;
>> +	}
>> +
>> +	return true;
>> +}
> 
> If you want to do local recycling you must use the page pool first,
> and then share the analysis of how much and why the recycling helps.

We are working on refactoring all the Intel drivers to use the page pool 
API in a unified way and our plan is to update IDPF driver as well, as 
part of that effort.

Thanks,
Pavan

