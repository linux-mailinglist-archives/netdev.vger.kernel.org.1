Return-Path: <netdev+bounces-29433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A07833CA
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B776280F4F
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B12A1172C;
	Mon, 21 Aug 2023 20:41:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE66FA8
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:41:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757AA1713
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692650484; x=1724186484;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j8ntnQHK4UrbZ6w1AeyUrJSRkx0Jvh8coS4a7gk3/Uk=;
  b=gKkIcExsA6kJwqLHI2IeA15N3EGFr2k7TKVjlO8r1kE7YQjOM0/0yXVI
   wlmhP2ptkAWxg3zDsxf3Jji7idbzvxBBnKQKUoZDHKZryZnNKu80cbsEY
   GTi+98JuRzfWl0iQsRpNvhhCeZo7oJYGs1npQuNubsbL7zCyv/m/B2Xv9
   Exv16DhV8z2gJ4A6ghfRRMMqi5Mhk7YlIDI1dPM5tKQJYq8onrcWxbiLk
   1LtVaIsclgSiiqPHemiZr4ZrA0opLlqMKgc8wPySot4iwKDIP/XS8lXSU
   trwdVTzAv/bC7J6qIm+rHvIcFe+/IByqUUTZDbxoGUuUa2yL7lGrDX3Go
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="371126943"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="371126943"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 13:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850316507"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="850316507"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2023 13:41:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 13:41:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 13:41:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 13:41:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 13:41:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePI3xbZCyrM2HIlNm8Y41t6sqqknJx9aS2CbHTvCiZeBoASu7MIr4AnJFM8Agvp+7Q7v6FXMp0Op0d1IYQZEQm2eG/JgHWJZ0cfhnmTM8eyq2O0ieNbk31FRBNzggO3WDQ5dsB+nAckTmcGB7ui+ii6ZY6+nHeqWoeiDiAp+GKq/9ikGLH3DczQaUL5j0p9tfOvSAuLLwQKjawB+z8IQl7ny+Sp2662UFAP2Egcb2xCWSd9A+FiQvFjA1zkBFiOs9nhdq6kfF9ZPMIR5+PnHHdKA631yMhNr3gU1hM+3m8nT+ZTB6COH3nGFDjDBlp4lyoS0gl1GkUh43D7sDuZzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk1I11CkiCrHsNLD5DkrVzdKhzbYdIVL2g/YjHen63w=;
 b=BQMfqPkQqGkGaoJ0fvgCW6XOgTzO/mNz/BONWK566vRNfEQtwqCZHzFnb64rilXCr1iK57IAUdno4lnYjevjckFyPaqUTLKXeRDNziTfjTv3tcRWxJtuI3Ffc3D6o4t1CS17IWJDRmYXsS6KrMn+8MFxYSJZNPJCJU3V4PzzkW3fiOaJcSsYFddH14OKuCEzDM8PWqn4qhs/97Nd8uQKPV+e6qWEnAI8PUZCCOm0NIP63wp7TrqPNcMwbnY7/h0tANWz3CxLnKBONgWSuEpSG2UjutBFFNEmK5TMbh9Akdq2US8gU2GSyHgrNSxeJjF1QxsAAyY7oWLrhqceBa8nkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2599.namprd11.prod.outlook.com (2603:10b6:a02:c6::20)
 by BN0PR11MB5694.namprd11.prod.outlook.com (2603:10b6:408:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 20:41:19 +0000
Received: from BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::7167:18b4:ee0:8f0f]) by BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::7167:18b4:ee0:8f0f%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:41:19 +0000
Message-ID: <b12c2182-484f-249f-1fd6-8cc8fafb1c6a@intel.com>
Date: Mon, 21 Aug 2023 13:41:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v5 14/15] idpf: add ethtool callbacks
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Alan Brady <alan.brady@intel.com>,
	<emil.s.tantilov@intel.com>, <jesse.brandeburg@intel.com>,
	<sridhar.samudrala@intel.com>, <shiraz.saleem@intel.com>,
	<sindhu.devale@intel.com>, <willemb@google.com>, <decot@google.com>,
	<andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>, Alice Michael <alice.michael@intel.com>, Joshua
 Hay <joshua.a.hay@intel.com>, Phani Burra <phani.r.burra@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
 <20230816004305.216136-15-anthony.l.nguyen@intel.com>
 <20230818115824.446d1ea7@kernel.org>
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <20230818115824.446d1ea7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:303:b4::28) To BYAPR11MB2599.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2599:EE_|BN0PR11MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: bcffcd44-c5df-4081-cc4e-08dba286f94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFgZ6UyFu150mGDrQ4J7MuEh66CawwpMcrcdyfJb9FQ/O/iDDeS2jlj+DohrrKHK9Mq03lsPwHhV/eOgfGavDGjPEbpcHE9nVK4UZCmC7uRHU/fWMYNg1QpCKQbHInXnp827WJby4OHyKJadGxcZSftW5rVjrZIH/5mJ+JAhw57BuMNJbBiyMX8Zc3YKVGbyN+tQl2yVtJspuykbW/RhdSE/eATpFeoLpSTr8o8RnWS6HXwxdSkY0otbBwweVum+fuys8H/K+bdsWH/EylAlQ+KEZ5VeCz9w2Bvrx/ghaWIa8t89rvzvTsrpTK5T4t527nhC8hm6aqo8R+NBF/8pjwD2/nuYhaFGdKMW7UBmpnolnFXcZE3aSpG5nUPa6+JUgQbIXwFVvO9SfoOApcO1F+w/sezJM9sYZhi5pB8DE5MZg0YcEVD2e0zFdJsJZrIeNzPP9eygDs8tK5iMrO3xSpa6k2Ip/muDfnPcUTGJfZ0AcUoVLhuXz3pD/kQqe96vhbULdB6xEF8RAfRI2NyWPwTxazvQlHRW/c19NVxrsPH0x1munrq2hQKXbB83rgfFDqysj2Nl899Xtr+avbL+/lihlQahUHmRZ8fmk/enDwd+6D6iwUMXt4fgDi5n8xDaUXgqCJjejf49+VrPMqB59w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(54906003)(6636002)(66476007)(66556008)(316002)(66946007)(6512007)(82960400001)(110136005)(8676002)(8936002)(2616005)(107886003)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(7416002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnJJc2t3enJnM21ncGZlNkUybnlNUVVKWGJFbm5JS2E4VVJTZmU5MnNpYVJh?=
 =?utf-8?B?eHJ3VUNZR2dIdS9RNlhQRkpFcm5QelhxYW02enZTc2J3RElSeTlIQmtwUU1t?=
 =?utf-8?B?THl5TkNFRXdWcWpOdjlZVVROK3FuMG9VTlBjTzBYdUZyYnpHa1ZpSWNnYm9y?=
 =?utf-8?B?NklHYkxOTlZoTWQrRWs1anhETzlUZTc2TkdZbTR0ditSbDN0a1JZL0tHKy94?=
 =?utf-8?B?UjhJSjVWV3RnbkZyOWZQbll4OWZIODE2N2cxdWJ3aFUwTUR3VzZ3aXBDS0pn?=
 =?utf-8?B?elJ3Yi9ycVpKcElwa1JIdlNqbWZvQnM2Ky9qTFg5Y1J2RTI2R1l6bFRDWC8r?=
 =?utf-8?B?WDRpRm9WejNPdktvWWdYU3ptVzNBLzJwZU1iVHNqbzVOQjhZUXZLMWhTZHFZ?=
 =?utf-8?B?TGhJcXJrbzNLSmxUc3dnL1NVMFBqRnFsTW1LT2RBQjlsYlM5aEFvQjdaNnRm?=
 =?utf-8?B?UlhONEx2YVY1MS9tVEdsZkNvcFV1cE94RjZqd3BSczlLM0c0R0pBQmNGcklm?=
 =?utf-8?B?U2xCSnlmeTR1b0pabS9SS05kbUJ3UDhuS3hFNTBTdWpEN0pkSkk3TmR0WkNH?=
 =?utf-8?B?Z2lqeE9qZ2k0MWdEZ3QzT0JISDY5ZkFVVFlLSDYyMkowTXZ2L0JpSWx0cjA4?=
 =?utf-8?B?NmpQMm5jUjAvUnpzZUR2QTlCMm5xTys3eThrT2p1aUdmTUpldEZCcFVlbUxE?=
 =?utf-8?B?NjYwWlUwZFpuVUJKa2cwOGYyRGVKdXdzcjdPNWFpTTZjNHVMdHQzWC81MEtM?=
 =?utf-8?B?RHBVb0NRNzJveERmZU1uWllpYWlIWFBFa01zTS9yMCsxQm9uLzdOajd2bGE0?=
 =?utf-8?B?ZlViakF3R2psUkRSSnBIbjhMY0pCZUREbnpCL0V5RGdtZnRZdWZHeExVYkVT?=
 =?utf-8?B?TGZxTkwySjhEZ0laZWVveVB0d2F2a09Hb1ZqdTFWQjhhREN6a1hWTlg4dGtX?=
 =?utf-8?B?SDFWYWRHNUFPYS9EMHl6UlBmUitoYStiSkJkYXF4aTZ4eXZ0QktVTVFHdi9y?=
 =?utf-8?B?NDlmS2VDUDdVRzliZ3lWUkI4dTJUVnhVVDBva212RVZtdzVoS0t1dVdRRmFP?=
 =?utf-8?B?clFQb0RVcmE0WlRjUW5HVnQwR3gzbG9jcGd3MGRiOWMxdlBqL1FTcFJxWi9F?=
 =?utf-8?B?VkJXdFlQbm0yMTRCNHVSSHJ5bXcwUmdPMHp6WDZ5aTV0ZWZKdUhyRExqQ0lF?=
 =?utf-8?B?dWVlSi9CazNTRXFadHpSSDZNVE04VEUvYmVVa0xoY21JSG1PNFhDYWVyN1NH?=
 =?utf-8?B?T3VwV3p3akxKSCtuZDV4aDJSaXhveCtBanJQeFVWVU1uQkdRWUprcnRHclcy?=
 =?utf-8?B?dUczVmxaYmd0S3R6MU9ycUcwdS9BQUR1QUFBeldhV1EzTlJJb2QyUURxWW1u?=
 =?utf-8?B?dG1IN1ZYdXhKRjlCeGxFcmJIdnhJRi9zMUZOQUNpQ0l5WlZwRjNtaUJZVVhj?=
 =?utf-8?B?ditQVWJnRGNNa3VtbVNVTlBMRW5QYjRxOC91ZFJkdEttRlNoRkxnbE5TajZL?=
 =?utf-8?B?NER1dXdrR2p6d21ybFB5MW43QlVhZGlqck54NDVCTEJKcTVBeS8xVkQva1h2?=
 =?utf-8?B?S1B6alozbHRiRmRCbHRiYkI5akNOVWNSb1BzWDdFa1BzWjMzd1RmNTR6NFJs?=
 =?utf-8?B?VW5BTEtwWEZSSGl1MVd2TlR0WnpQL1dhcmcvbTgrd0NGS05RK3JCL0kyenVR?=
 =?utf-8?B?K2RWemU1Y0dFMWFTa041eS83TUxxYmZlKzhrWFFoRVNwSFJ6UFRpVXdwN001?=
 =?utf-8?B?b0twT3M5Q0tXZVNMS2RhYWNwWndiR25lK1ovUWRhRDd5MmEyREFaUS9RalMr?=
 =?utf-8?B?SXB2RVJGdzZPMTRmNGlLOG91a3c0eENVM3UxVFlzaVllR2owcU1WOHNYcEx4?=
 =?utf-8?B?L0ovVWlLSGFSYzAvN2pqcC9hVGkxNGE4Z2pMdE8wSnJod0lyVE1uVkJhWDBt?=
 =?utf-8?B?QmxvYkJ2ZDNnU2lxcTlUQzAvOFNvUG1xanBaZkxJTGlCaDRiT0dSZzlHanhv?=
 =?utf-8?B?dVZpbGdaY2s5RGZtL0RvM2dJOHg0eU9YRFVwUDNUWld2SnJzS1N6RTAvZkZl?=
 =?utf-8?B?clBOeWlsVGUwRDVSeG5ERVFnU01ra3VENEp4cG9ab0hjSStaQnlITHB6Yzdo?=
 =?utf-8?B?QkNkck9TUE5takFrSW84RG5iM1lxeHRCcy9rZDljVjkzNGlVeE50bFNzSHpZ?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcffcd44-c5df-4081-cc4e-08dba286f94b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:41:19.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHImg7yhKJS1IL1c0jCbErQgS5F+yGA3lLWoq8hCmP5jcz/yaqfUKb71GuFr0FGUOkT2nkYpxHeYwLOJK+Hw89dCn4bfOXRr3pzDC6Ou06A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/2023 11:58 AM, Jakub Kicinski wrote:
> On Tue, 15 Aug 2023 17:43:04 -0700 Tony Nguyen wrote:
>> +static u32 idpf_get_rxfh_indir_size(struct net_device *netdev)
>> +{
>> +	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
>> +	struct idpf_vport_user_config_data *user_config;
>> +
>> +	if (!vport)
>> +		return -EINVAL;
> 
> defensive programming? how do we have a netdev and no vport?
> 

During a hardware reset, the control plane will reinitialize its vport 
configuration along with the hardware resources which in turn requires 
the driver to reallocate the vports as well. For this reason the vports 
will be freed, but the netdev will be preserved.


>> +	if (!idpf_is_cap_ena_all(vport->adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS)) {
>> +		dev_err(&vport->adapter->pdev->dev, "RSS is not supported on this device\n");
>> +
>> +		return -EOPNOTSUPP;
> 
> Let's drop these prints, EOPNOTSUPP is enough.
> Some random system info gathering daemon will run this get and
> pollute logs with errors for no good reason.
>

Make sense, will remove them.
>> +	}
>> +
>> +	user_config = &vport->adapter->vport_config[vport->idx]->user_config;
>> +
>> +	return user_config->rss_data.rss_lut_size;
>> +}
> 
>> +/**
>> + * idpf_set_channels: set the new channel count
>> + * @netdev: network interface device structure
>> + * @ch: channel information structure
>> + *
>> + * Negotiate a new number of channels with CP. Returns 0 on success, negative
>> + * on failure.
>> + */
>> +static int idpf_set_channels(struct net_device *netdev,
>> +			     struct ethtool_channels *ch)
>> +{
>> +	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
>> +	struct idpf_vport_config *vport_config;
>> +	u16 combined, num_txq, num_rxq;
>> +	unsigned int num_req_tx_q;
>> +	unsigned int num_req_rx_q;
>> +	struct device *dev;
>> +	int err;
>> +	u16 idx;
>> +
>> +	if (!vport)
>> +		return -EINVAL;
>> +
>> +	idx = vport->idx;
>> +	vport_config = vport->adapter->vport_config[idx];
>> +
>> +	num_txq = vport_config->user_config.num_req_tx_qs;
>> +	num_rxq = vport_config->user_config.num_req_rx_qs;
>> +
>> +	combined = min(num_txq, num_rxq);
>> +
>> +	/* these checks are for cases where user didn't specify a particular
>> +	 * value on cmd line but we get non-zero value anyway via
>> +	 * get_channels(); look at ethtool.c in ethtool repository (the user
>> +	 * space part), particularly, do_schannels() routine
>> +	 */
>> +	if (ch->combined_count == combined)
>> +		ch->combined_count = 0;
>> +	if (ch->combined_count && ch->rx_count == num_rxq - combined)
>> +		ch->rx_count = 0;
>> +	if (ch->combined_count && ch->tx_count == num_txq - combined)
>> +		ch->tx_count = 0;
>> +
>> +	dev = &vport->adapter->pdev->dev;
>> +	if (!(ch->combined_count || (ch->rx_count && ch->tx_count))) {
>> +		dev_err(dev, "Please specify at least 1 Rx and 1 Tx channel\n");
> 
> The error msg doesn't seem to fit the second part of the condition.
> 

The negation part is to the complete check which means it takes 0 
[tx|rx]_count into consideration.

>> +		return -EINVAL;
>> +	}
>> +
>> +	num_req_tx_q = ch->combined_count + ch->tx_count;
>> +	num_req_rx_q = ch->combined_count + ch->rx_count;
>> +
>> +	dev = &vport->adapter->pdev->dev;
>> +	/* It's possible to specify number of queues that exceeds max in a way
>> +	 * that stack won't catch for us, this should catch that.
>> +	 */
> 
> How, tho?
> 

If the user tries to pass the combined along with the txq or rxq values, 
then it is possbile to cross the max supported values. So the following 
checks are needed to protect those cases. Core checks the max values for 
the individual arguments but not the combined + [tx|rx].

>> +	if (num_req_tx_q > vport_config->max_q.max_txq) {
>> +		dev_info(dev, "Maximum TX queues is %d\n",
>> +			 vport_config->max_q.max_txq);
>> +
>> +		return -EINVAL;
>> +	}
>> +	if (num_req_rx_q > vport_config->max_q.max_rxq) {
>> +		dev_info(dev, "Maximum RX queues is %d\n",
>> +			 vport_config->max_q.max_rxq);
>> +
>> +		return -EINVAL;
>> +	}
> 
>> +	if (ring->tx_pending > IDPF_MAX_TXQ_DESC ||
>> +	    ring->tx_pending < IDPF_MIN_TXQ_DESC) {
> 
> Doesn't core check max?
> 

Yes, it does. Thanks for catching that. Will remove the max check here.

>> +		netdev_err(netdev, "Descriptors requested (Tx: %u) out of range [%d-%d] (increment %d)\n",
>> +			   ring->tx_pending,
>> +			   IDPF_MIN_TXQ_DESC, IDPF_MAX_TXQ_DESC,
>> +			   IDPF_REQ_DESC_MULTIPLE);
>> +
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (ring->rx_pending > IDPF_MAX_RXQ_DESC ||
>> +	    ring->rx_pending < IDPF_MIN_RXQ_DESC) {
>> +		netdev_err(netdev, "Descriptors requested (Rx: %u) out of range [%d-%d] (increment %d)\n",
>> +			   ring->rx_pending,
>> +			   IDPF_MIN_RXQ_DESC, IDPF_MAX_RXQ_DESC,
>> +			   IDPF_REQ_RXQ_DESC_MULTIPLE);
>> +
>> +		return -EINVAL;
>> +	}
> 
> 
>> +static const struct idpf_stats idpf_gstrings_port_stats[] = {
>> +	IDPF_PORT_STAT("rx-csum_errors", port_stats.rx_hw_csum_err),
>> +	IDPF_PORT_STAT("rx-hsplit", port_stats.rx_hsplit),
>> +	IDPF_PORT_STAT("rx-hsplit_hbo", port_stats.rx_hsplit_hbo),
>> +	IDPF_PORT_STAT("rx-bad_descs", port_stats.rx_bad_descs),
>> +	IDPF_PORT_STAT("rx-length_errors", port_stats.vport_stats.rx_invalid_frame_length),
>> +	IDPF_PORT_STAT("tx-skb_drops", port_stats.tx_drops),
>> +	IDPF_PORT_STAT("tx-dma_map_errs", port_stats.tx_dma_map_errs),
>> +	IDPF_PORT_STAT("tx-linearized_pkts", port_stats.tx_linearize),
>> +	IDPF_PORT_STAT("tx-busy_events", port_stats.tx_busy),
>> +	IDPF_PORT_STAT("rx_bytes", port_stats.vport_stats.rx_bytes),
>> +	IDPF_PORT_STAT("rx-unicast_pkts", port_stats.vport_stats.rx_unicast),
>> +	IDPF_PORT_STAT("rx-multicast_pkts", port_stats.vport_stats.rx_multicast),
>> +	IDPF_PORT_STAT("rx-broadcast_pkts", port_stats.vport_stats.rx_broadcast),
> 
> how are the basic stats different form the base stats reported via
> if_link?
> 

Found few stats which are common between the if_link and the base stats. 
Will remove the common ones.

> Also what's up with the mix of - and _ in the names?
> 
>> +	IDPF_PORT_STAT("rx-unknown_protocol", port_stats.vport_stats.rx_unknown_protocol),
>> +	IDPF_PORT_STAT("tx_bytes", port_stats.vport_stats.tx_bytes),
>> +	IDPF_PORT_STAT("tx-unicast_pkts", port_stats.vport_stats.tx_unicast),
>> +	IDPF_PORT_STAT("tx-multicast_pkts", port_stats.vport_stats.tx_multicast),
>> +	IDPF_PORT_STAT("tx-broadcast_pkts", port_stats.vport_stats.tx_broadcast),
>> +	IDPF_PORT_STAT("tx_errors", port_stats.vport_stats.tx_errors),
> 
>> +static void idpf_add_stat_strings(u8 **p, const struct idpf_stats *stats,
>> +				  const unsigned int size)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < size; i++) {
>> +		snprintf((char *)*p, ETH_GSTRING_LEN, "%.32s",
>> +			 stats[i].stat_string);
>> +		*p += ETH_GSTRING_LEN;
> 
> ethtool_sprintf()
> 

Will fix.

>> +	}
>> +}

Thanks,
Pavan

