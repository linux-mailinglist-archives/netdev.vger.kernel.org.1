Return-Path: <netdev+bounces-12798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA255738FA5
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0114D1C20F39
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FA019E5C;
	Wed, 21 Jun 2023 19:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D619E45
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:08:12 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81079171C
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687374491; x=1718910491;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DJXEhOCno3segIIGUh+KORQilLWior8Aleh7wOqs2uA=;
  b=hi9t1o75Wug/HqYY1tpJS9LbOrivkHbZLOBDGlck/AysJs3/dJfERXGZ
   FHGLmRt5N8aIzC1dX1Gb7EfdH9G+COPaAEIV6xsvtrrwXN3CBgLEGIrZv
   jBLUwPPJA4ozQ1BbzL16MvNJGdwSbDyjc3cCePxd/NFNlHmwAe8NWAw/N
   kiB+UIY1oICj9LzquQ0tLVXy/5CabJNS9yoZOehSxXTyNag4YpevquMep
   gX/ec8ZmsK2VXbXJoWLm4Ck++IBf+Zi/zIzY085JatVBM51kZEgppLRBg
   QF/elLhHeqwNZOcF7tjNEJaXL+RJ3QfQiPDhUAXcsIeFmzjUBXpUT2kqA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="389858051"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="389858051"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 12:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="664774813"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="664774813"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2023 12:08:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 12:08:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 12:08:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 12:08:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 12:08:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHPEat5PkFVN/f+JU6FSYG6Z9fhBE4MjgwMB/KEneiL77EkSTUFuoN0ClNiR+Krtxun5hD2KYsAbUA+7vy6VR8cDE9quXotWYaSQMLbWtnkayHfZbtF4YQErlHn9+wB7tIbH3nywVIXfSFNo8OE0DBwDEg2e8Na0z6ewMmfoJkFpnUGc1obKtIcacVj1esUvm01z4IF0V9SnEOXi5sMdvb8zqqjQ4tgxxv4wszuHErl6bEYqu2j8+lH/VTn8aU/S/KDgS/KBdKe+lTTzM+8+kJWUjmJ57RYiDjG9oNP5Pea74W+8gTG7SKXB1K73yWjXU6EBVszCuYLiYDoGjFxF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s0Tv4XdZh+RaDF3fZmkfmNtTDUxjpC22EhGKiBUJxs=;
 b=X6I4E46DB8412XA3MKh+L8hwC0rthuOkqmaWq1/3QrBng/3xqUQkdGUuLVJoeIJEdLhxrjKuJ5U0MbWUuFuO/zorPu3rAj4W7KtVs5G3IBbxY4/ODmyrz8oKFtAfbAvB60leWjFaRWQlHqLtXeh0ZSFri75RgT01e4ba+aiRSi8N1MmlH75B2josn5h3t0spndqGm2JUFRK5qcWoljhHnMs9KJIvnPFagnrS5VB0RUmm72bgKhyiI5ZqAX/4UzZbiL4TxMMgQzTbfmoi067vKGYxhl4dUaw/ACi4E4HE3IEtIcWL1nAY3IMJYWG6ysoj3Qty4ubTVwU6pMOanG0XNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2599.namprd11.prod.outlook.com (2603:10b6:a02:c6::20)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Wed, 21 Jun
 2023 19:08:00 +0000
Received: from BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::ab9d:1251:6349:37ce]) by BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::ab9d:1251:6349:37ce%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 19:08:00 +0000
Message-ID: <35e24b1a-00ab-84a0-db66-e0a11dfdfd29@intel.com>
Date: Wed, 21 Jun 2023 12:07:56 -0700
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
 <20230616235500.2806449d@kernel.org>
Content-Language: en-US
In-Reply-To: <20230616235500.2806449d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::11) To BYAPR11MB2599.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2599:EE_|SA3PR11MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcffdfa-cd9f-4784-4aed-08db728ad46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oE/F6/vZc/y9W6lvi2dpRuoOzL/YLzFMjTjJ7aBG1ykTDNGQsDXgl8vgdhEUr5nkdTcyn67oZnirQs8ykL61idKb4Nd6j2iZP0+TxZQUwetys7E5N0W40znAYFdcwvFH43p7Xp/hPHDLN4NKqcxhukqe5Zc50t6UpOlftInyQil0A15l+db/bOZFvZVvnDSd8xcOsVTxpX0Z6D2ugmC+rWvIym6k59s4yIsPBd+ebAwgLPnBv72qTfPjDasAsYANZneyjiCKagpknKKrBYgLEuXBALndZYNyUzeaqbKWFt5NCFmc5AAWoDzN5MGhbM1nut5ayPjDEbD/zpukeGNv1YecqG6OicNOaPrOrdGveEUTKsOX9RljINmWUYnqQYIMX4FXIt7IKskPsMlxfmt5XnSn940e1KikpVkn02/QvQDzY4aLXyxQzL4HhRYhAVhImV3tM4Mlye3Q5hBqq+BQ5NqSvvMC7wXFdhyOK8O4kpbZdqvWq+9EsfQN9que3Vw74yHdDPSyK2RHsAHMKpclYUkcBgpXwk80ja5wJWI9qyFtUe2GzDfBDh9LeeLactkABs3VfdabfvBNBY6Xh0WMG4iGJsP9I9TGBMcPCsLFVYQUAjlmABSWmHHcEqaUR8RWqyR9aLibVpCs1XsoxGUdTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(316002)(186003)(478600001)(6486002)(31686004)(5660300002)(8676002)(8936002)(41300700001)(107886003)(54906003)(4326008)(6506007)(7416002)(6636002)(6666004)(66946007)(66476007)(26005)(53546011)(66556008)(6512007)(110136005)(2616005)(4744005)(2906002)(83380400001)(38100700002)(82960400001)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akJWSEN1Y295Y2RIbjhBazRNM1MyaFYzZkVKMTFIdWZvdzBsK3ZKOUxqd0Fx?=
 =?utf-8?B?Mml5VUl2b2dTT2NydlhhbUdZTEZGMlFtU3NXYm9LeDMyb0NuYjZOSEYyRXJy?=
 =?utf-8?B?dWZqRFZlUVFNZ05FSnFOVHNoczNYM3VQN1h1c2s3QVEzZkhYVjBtRGxZQzJM?=
 =?utf-8?B?RUVGV09UWDN6VWRCZUVaOGhDZnRad1JaNCttOU9LeXpTVjFuR2ttWHN5a3VJ?=
 =?utf-8?B?cEZlTlJSMGxZbkJJS3NUUUhkcUIxWlgvR3o5QkZOQk1TVXI1RjRSVzJuSTVn?=
 =?utf-8?B?azVDN1VwSm0vNFB6eFVYdTlRODNSeU9OVHQ4ZUhvK0VVYmtkWVpwbEdKc3FR?=
 =?utf-8?B?KzNVV3BtZDg2R0dUaDUxdk5UUXlyOWR0VUFKNFFLMERnaUpINHV4aHppcnlq?=
 =?utf-8?B?dGMwM3hiWWhOL3hLck83MXA2d293WFZkbEtsN1JBT1h4UXRzRkZrZ2pRdFpV?=
 =?utf-8?B?YitPV0hkMFd5WmJsTktBeW5oVitCQXI1VTFOKyt2UVQ5cnNtcFoyMXVHc1lY?=
 =?utf-8?B?eUZZQlp2N1hzRDRTQ3REUGdoeDRrQmUrUmdJYnc2ZFlUMTduZkRrZDF4dUF2?=
 =?utf-8?B?azFISm45NW8zaUgvZE9NOEd4d3hOYlBwaWZzdTV2UzZSMWhVd0c0RkhSTFZP?=
 =?utf-8?B?Y1U0SkR6VmNoMS9XTkRhZFd5a2xNc2Q4RkhMR0ZUWlV2Z3NwZGt1WEdNaEJl?=
 =?utf-8?B?U29GelNKR0NTcTdtNk5aa21vbmc2UlczZDJYc05kTy9rcHpHcDNkcHhpdzNm?=
 =?utf-8?B?eGk5OFdHMjJzUkc3c3pvTlBPdW13cHVmMUhnejA5MVA4Z0w0dW1zVXkrMHR2?=
 =?utf-8?B?dEJXN0pleG5nWHUrY3Q4cFlIQmZpVHBWN0pLNzdROWhGcDRlcVlDc0VEZ1Yv?=
 =?utf-8?B?cnhuVER6SGRIdFFsMVdWSHNYdE9NR1BuQkt3U2tXZ2xXRm11dDJBZW5oL0g3?=
 =?utf-8?B?cVIxMDFhL2M4UGNDcEl5eHluNFN1YVRjSkwvQW5ZaitlalVMTHJLNDdSOWhM?=
 =?utf-8?B?VXA0VjlxNTNFNjREZm9abUo1d3owNkVkVVdNdlhFNzdhS2ZKTFp3VFlMS0NU?=
 =?utf-8?B?S3pEcHJOSkdVZUZubUozazlPQkI4QTdCeDNaeElHYU5QYmpnYXZ2bS8vSFFG?=
 =?utf-8?B?S3JVeEZFQVJ4L3E1UHgwY0NDTkNVVVQzK24wSFNkcVFhZGoxdXBxQnVYRXJo?=
 =?utf-8?B?ZVNkN3NHVVlTZUZsaEhWYldtbFpTL0lxa0k1cjh3bEx4UmhwR2RYNExJdDBu?=
 =?utf-8?B?TFZZMVZ5eVRqZ1pyYXhMdkhFT0c5NmRYUkdLMDVueHdTVUFZdlZBalI4czBB?=
 =?utf-8?B?YmxabUlOOEg1V0pSZGVsNXJvZ0pzeEhRWjNQdWVETU90bUIzZm1kU0pubDBN?=
 =?utf-8?B?aW5DQitXZDlOM2xzdmxTeUZmb0IzMm4vbGRsTkJpWDhXaDJlSUJjV3dkUnl3?=
 =?utf-8?B?MGhRMGRqQkRjNmpMTGdSZ0tuemN3ZXhFTC9hSzl6dTdMejlqU2dMekhmTzRL?=
 =?utf-8?B?VmZPNWR0NC9EY29NcnF4ajJVZEp4MVYxTVhydEJoSERlVXB2amptYzd4eGVn?=
 =?utf-8?B?ZENJSFRNYmlSVVU0em9yM0M4SzY3NVl5dUpPV09tRWpDOUltZlRQQnJMTkpt?=
 =?utf-8?B?Q3JvbFlIc1E5K3pYZXhCTEpvWkM1Qi92aWt5ZDZvcDVQTjRybkhqZTRFUXdN?=
 =?utf-8?B?bEgrOGdkMkxIRVFxYlRGc21yQWZtUlhEYXFqOXNuclAzWnoxUVBjUDVYOUg2?=
 =?utf-8?B?YTY4Yk1oNW5SdnlMOGpJNnJYb3hON0xqNWRlNTYwdUU4ZUYzNTUxY3IxeXdq?=
 =?utf-8?B?ZkpwdUc1VEhmK0duY3RhanJ0ZllSVTNLdGx2NDhMVkZhWGpzQXpqeDl3TUhK?=
 =?utf-8?B?N3pCL0VsS3F5eFkrZW96NUZ2cHV2N0JGSG5qczZDSHdiM0pPRWw4dk12eWlm?=
 =?utf-8?B?K3ptRlBKZDRrQWhkYk0zZGprU0lveEtIbUZ0b0NES0dVdVZPditmSWl4VXBP?=
 =?utf-8?B?cG9UY04rT0k1SytESHgzWTJGRXhEaldzL3A4SjhRMW5nQk82b1R1R1BTMG94?=
 =?utf-8?B?cU14QzYwNXlodnN3Vld2OEpnN2UrYm9YTlV4aVdKUEZrYS9QQ2VQWlFXU1Br?=
 =?utf-8?B?dnltZUhFSzdLTzl1SEYrWktHNmdpZ2ZmaGQ1ZVR5RlRnbDNnV213cnhmMFFr?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcffdfa-cd9f-4784-4aed-08db728ad46f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:08:00.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUdhs5UIq3tVVInkmLOxINAcOhyhlw8e9te9RVsTxrRne9etcUPl6WyhkwM6pYBp84gTo49BoxvySxN69YNBYo/ZLGZCTrW8zM4fkivy+1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/16/2023 11:55 PM, Jakub Kicinski wrote:
> On Wed, 14 Jun 2023 10:14:25 -0700 Tony Nguyen wrote:
>> +	skb = __napi_alloc_skb(&rxq->q_vector->napi, IDPF_RX_HDR_SIZE,
>> +			       GFP_ATOMIC | __GFP_NOWARN);
> 
> Why are you trying to pass __GFP_NOWARN in?

I don't think it is required. Will remove it.

Thanks,
Pavan

