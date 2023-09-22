Return-Path: <netdev+bounces-35787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D37AB110
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 13:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DD766282C69
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7922F1F953;
	Fri, 22 Sep 2023 11:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E9182B3
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:41:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A97FB
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695382899; x=1726918899;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3TwPvEZZxsJAXnyj86TXICcjg6T7eI+oVIeipOdeQHU=;
  b=aQBvJD1ZT5Ik3pWrextZCi+tFut2xAz6jRxp05g4GyJnvk/lZx/hmd/x
   QPaSw8KldadpNSWQwmyBRsX32z/GikDBvSHyOswWvPEoIUmbQgGhbAWNl
   riQ+n9n6fZn6YuZdwDfoSgqDeY6VK8DiEQ9qsatOTTHdF5n/SLY60lTI+
   HszhlKgoxN8xonaL42FL6UvdZFgEgbj+/n9b5eLGn3rsnFL/FNsjY0GDS
   rQjoKjj0ChO3I/G232/c86NGxEyJgA7H6TP1A+QX8ULqhv6KoIIBwzHBM
   4fzwDhUlXC0+rCWH6vK9aTos/gdd4gAUa3BxUnbsiuBaSJ8qHDdoSUgVg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="378095551"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="378095551"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 04:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="782636887"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="782636887"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 04:41:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 04:41:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 04:41:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 04:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gevBc9P8EM+SBrcmzB3TbUAMYpJxgxYLtRL0EGMRg3O2GcNUNbFXgw4HcRXDnQtS18kZj0HgE9xFgZBtiZoVm2Gc378UNZfkhh0ZC6ek6fbSpFhx7PQmcNHufDS1bVRQE8lHik+KgieOM5hjUWcCcpOhUH7pHDDOg+ripOPrHt46RL16nbm3SesilVlcZkrNEUxUujRJYxlkxMcccqQWVPs5WcngUGxEbJob1ceyP5EsBz9AZCHH2X95TrFUwuLlcxP0SRk7gxjz91qNv2DXKd3LIHjNfFTZ//OjMAwU6rzEiBNUf/3/2aqvLGiBL33T+0opBIAI5e9/L0ozpZmo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czLKOwRZVjrSilmMKHcSJRgPnqrNNGG/zymCyO1h2cM=;
 b=Fyx1WHoE3Rwpu8+kf+btP1sfAneAAEb7RuQjRm5fjqBcPt3aHDnVPSuk0Ytfmk2354zwPePKeT/UsLiG+kX5PCBXz5k5bT4z3dG/cRqzcvYo9lIL36kJAZ9UaIyy/5/m5IVMnahXG3Yv0jMoBLl5jILxOXUafoeNX7HXX7wDb8A0rRrtAVWyw7IQLUsZA8sX9kAU1x/r+gR8fsuBKXG8mKoMK/c/ml27WWljwkvqZzpZW3Cq89qDBYjuBYulZr3dg1CfvjVG7Ai5LHPWr26XlGvIb8hHytF4R7yX/L78J3xJ7ZWTn6722a4fWA8diCsM3yZbEfJMrOr4FY7cBaBYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH7PR11MB6554.namprd11.prod.outlook.com (2603:10b6:510:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 11:41:36 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 11:41:36 +0000
Message-ID: <7215d40b-813d-d2a6-ec62-790344831642@intel.com>
Date: Fri, 22 Sep 2023 13:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 net-next 0/3] net: use DEV_STATS_xxx() helpers in
 virtio_net and l2tp_eth
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <simon.horman@corigine.com>, <netdev@vger.kernel.org>,
	<eric.dumazet@gmail.com>
References: <20230921085218.954120-1-edumazet@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230921085218.954120-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::10) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH7PR11MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ee8e2f-e7fc-4b0f-efc7-08dbbb60e029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQI8LD+qLbj7PNklmt6gc9LNWvYS7bGpEXJS1qEqMgTL9aaYPzg0vTilJpw/mlI22UnDnqeELtpnQFBbnGSJQD8E1JvMi6nWynZq0ximo92lvA8MJuA38GPRLZJy7WJKFWKr3ZLcK6Aey2eogVZLbT9t14wSoqTTNK9he4PQryRZdIChOdtgwZPI5kI7Lyvv8WKPt3Y70s2NB7daWb5EmrA2rgUjXhXhCWEGxrSPkzSmFMCtxUcDTcca+/HoDPOWQ0hhvErwwEu/NU0uLucNrcBCl6cryZiAo6DQrIxHPUk5T0jmA4wqzb4JviLXo03ypDF6bTe+ADBwmh0oEvOQ8Lfzkaq9n1diwYP82yb8sMAL2z79PuYnOGDLV4JL+nfssWWuWlqUdFzx4caYY4uGJqeSz7SuEQXL/Rp40kJn/BEgoL0NzpckdwiHuweBSPUVGp9FHT/FcZOnOGW4u9tWUqWVnyELpCr4w1Lbu+DHUAi32AvjYNdI+q5Q+Anw+Qu7B0Ex7YHPDQygozn6o9OLhg7/t9MGOFkQGdDKWQBUGXMYnUfj1cerdi8ObhW3zLNT9ac2ZKt5FeQ+kxPTZFocwbdQrHG7NzpkhEp64LPqcsZsCTUQ4iyznUgUNvoHwagh9lM/XbefsW/n3rXRFDF47ozF7ioBwRLVN2eF/Nfk9wA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(186009)(1800799009)(451199024)(31686004)(6666004)(6506007)(6486002)(83380400001)(53546011)(82960400001)(2906002)(86362001)(38100700002)(36756003)(478600001)(31696002)(2616005)(26005)(4744005)(66476007)(5660300002)(8936002)(66946007)(6512007)(8676002)(66556008)(110136005)(4326008)(41300700001)(316002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lmSUJPV1Y4SnZxWEFFU3Qvd1lPZThUcERNbzZXUk5Uczl4NlBoYkZ3RnBQ?=
 =?utf-8?B?L1p4NnhZRW5oRlhhcW91RlJXeG1HbHVQdSsvNlMwN1RURTQvV21vMFU0T0Vx?=
 =?utf-8?B?M1ljdXRWcGdwREp5dlA5U1hZcEhiRU9zL2FxR0UwTUlGeUpXWHAzTy9vVmhF?=
 =?utf-8?B?dnF5Nm9jd2VOVXoreHgzN2t4Zm05eEVtcDdDeFNTeVk3Q2ZnNEQ1eGlDRE1p?=
 =?utf-8?B?UkUvMXNWVkU5WTg0YWd2M0x6WDlGYWhmc21oNVZ3a2dxVFNTNHVYbUJsU0Fw?=
 =?utf-8?B?RHBkNUtEeG5UZlcrNHFiQVBPQXkxM0plcW5rWlM2ZkRvQks2T0ZCWlJBcmJK?=
 =?utf-8?B?OUZYQXRlZFZYRU9remova0pMSzc5cmNnZ2x6Yldzc0xCaW9IYkxDSG9zUzU5?=
 =?utf-8?B?YXh6bHNadkJIUWJvYzRaUHdNNFBYOU9jZ3BiaFdxYWptRWFVMWNtTVpyVlVB?=
 =?utf-8?B?VU1GNWRGZFk3YUVhZE0xL2hRVjdBOEVSdktwRkZPMENDTmtlclhVNnN5WlFs?=
 =?utf-8?B?c1dZeVlRQ0ZzS1orQnIreVBNb1N6TFZWdHFvb1kwMzB1RGNNZkZ5dGdFaGdJ?=
 =?utf-8?B?NkcwVzJiQ2ozdUIyeTh6ZkFrZGdhRDQ2U0M2c1BXTk11Qm00a2dST09mb0ZH?=
 =?utf-8?B?dUNZUEpVTTlnYnZhdlM0Zzl5c29FWUgwTndqZDBTaFhrTjdVOFBDR05zbnJm?=
 =?utf-8?B?Q1FYNmw0c0FYdDZxWXp6anFBM3VjWUdWd3RxdGNTUUZXU0N6NGxSSjJYRVox?=
 =?utf-8?B?RjYrZVpLYTc4ZDI5dkkwQ0tmUHpFTndhbUY0RnZIdmtHcVprRkt2cjhUYTBj?=
 =?utf-8?B?WTZuUXlIcXB3SEhjenhUeW16cGowNkpwZzZYdEUvT2JCejNvZVBVMEh6eTF0?=
 =?utf-8?B?VzA0Q1hYY0lURE4weWVpWEdUSXZKR2tsTkZ1bnN1SCtyWG9CV3NDa21MTWpy?=
 =?utf-8?B?NEo2NWQrcll6N2NXNkFqMkZrZHVzaFJuNHJxR1lGQTFNWng3NGFKc3V6SmtP?=
 =?utf-8?B?Zm1NZlVYRmlWT1BiTFBGR3puVnJCclVRanlXUngxNjg0OUh1dllGelNXZHBO?=
 =?utf-8?B?TmJxWVcyYUl2MG9oSUhWRnJkZDVqa3VFeld2M05IdklRTE1kRmtpTklRR0Zp?=
 =?utf-8?B?bG5lMGcveDBYZ1N1ZktERDIrTjNPTE9UYmFuV2pUTUpGOWxTRHlYQitpckNj?=
 =?utf-8?B?a0t0bm01emJQOTVQcEQ0Tk0vSld5ZDNqczlURVd4Y1hXd2xmOGZpNm9QM0pl?=
 =?utf-8?B?alJOeTFKb0hpSjZyMVJzWGxNTWJzcDgzMmc2Vm9GUEtBd1p1MXJsaWxoNk9D?=
 =?utf-8?B?d3hXV3BWc3BKNmRiZVlWQUttRWRqUHNmVytEcVBQUHF2ekcwS1VTQ1NYb1Q0?=
 =?utf-8?B?UC9PUFRMZ2NrU3lPV3hkRis5czgvb0Y3aWZxdHpEajN6cUYvTVhQOTRZcnNQ?=
 =?utf-8?B?TkpSa0R5czFxZlJQYUR4d1VDQ1BKK1dXbURVejF3QnNZUmdaTkI0cHA2MGF6?=
 =?utf-8?B?VGZITjZjeUdxc1o4bHlXaDlvY08ybzFGemNOZERmd2ovU0pGWFB2U0hzYmJX?=
 =?utf-8?B?N1BjMlIzd3lkWjJTRmtKbzdYRFVrTkF3UzM4eTJjOFl3VVg2clNrN2tIWGpI?=
 =?utf-8?B?N0pSUVBlaTRJK1l3TllrV2dLaDh3c2MvUEFtV3RtSythU1dIVXFIb2VBMVAx?=
 =?utf-8?B?Z3VoYTZZU2k4YkMwdnN1NWdsQTYyTDFoOFUwNFAyTy9sU21BQjRQTWYvcXdO?=
 =?utf-8?B?YjRIeE9VRTFDWnQvV2FhazRhL1hhYmhNRU52NUkwalE5Slo4ZVgvempxYTRx?=
 =?utf-8?B?ZW9PUnY5bFlETytOMmlmbGZaMm5QY0NETFRTcXcwZU4rajFGdXpZR1lEYzZM?=
 =?utf-8?B?SnhXdFhkWmpNZStReENNUGF1YlBSbEFaMzE4dEFCUlpGVnk2MEhZc1NJK3lB?=
 =?utf-8?B?RkhjT2N6cmp5VVRZM3h4Tm5Kd1pwNll6NnpDY05heWVYdDR6eWpKVmE0QVBH?=
 =?utf-8?B?WnVpMEpJVkl4bnJvanJYMGFLYUR3ZG5SQjNNdWtFQk9kcnZZVUN3STRmVlh6?=
 =?utf-8?B?aGJlakJaRE85VlF1K3J4bVpVQ0p0SXZhWmh5cEllNHMwT1F6MFRaVklGZWNK?=
 =?utf-8?B?UzZZdU1ac2ovdE1LWTFXOHYramUycGFkaUNZTlRnTDBkNDAvbTU4c0FzSlZy?=
 =?utf-8?Q?5J3utxQOd9vjIiEPA7uqZTQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ee8e2f-e7fc-4b0f-efc7-08dbbb60e029
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 11:41:35.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N88bkovqxEa9pSzapacXocBcc12PclSLvjJ1NlhD0i4LqYDztSOFZY008zv0igxZd9hDUlUHkPzCAoSheCoHMYIg0G0XlGsepmx886Tc8tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6554
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/21/23 10:52, Eric Dumazet wrote:
> Inspired by another (minor) KCSAN syzbot report.
> Both virtio_net and l2tp_eth can use DEV_STATS_xxx() helpers.
> 
> v2: removed unused @priv variable (Simon, kernel build bot)
> 
> Eric Dumazet (3):
>    net: add DEV_STATS_READ() helper
>    virtio_net: avoid data-races on dev->stats fields
>    net: l2tp_eth: use generic dev->stats fields
> 
>   drivers/net/macsec.c      |  6 +++---
>   drivers/net/virtio_net.c  | 30 +++++++++++++++---------------
>   include/linux/netdevice.h |  1 +
>   net/l2tp/l2tp_eth.c       | 34 ++++++++++++----------------------
>   4 files changed, 31 insertions(+), 40 deletions(-)
> 

Nice read,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

