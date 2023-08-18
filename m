Return-Path: <netdev+bounces-28989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BBF78157C
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CCE1C20C3A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AE91774E;
	Fri, 18 Aug 2023 22:43:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97962A2C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:43:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CBB2D67
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692398594; x=1723934594;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+qfzCMe7h44vWS2NeH9fGuIkPukIFP/VMqVEmM6nS84=;
  b=gF2v5xv0L9KF1J2C8kX/FN6OaGkG0vft3uYTeOflofRkRC4KF6EG9776
   U4DI3bMjJRXgZh+b1O3CPYAj60BWquevyRFc5jRtELszgS20kGauUEXJl
   aDg3ZdT0hN5b4wQyNUHePBugOL5i5AwKa+4F0Y+gq+pN6Kpb3v3NZ28Wk
   4XdQ793r015m7nhDXPCAc4oO4zwiMriPHOSIXBBZy0P6SHRaEivlqDCof
   qM2MeiIOjQ2QLHaGrhgR14IutOtAhJ5Z5qY6YM4Kph8o/bjaMbqsDEsr9
   9jGe16Hp4JZocrCsBi1YDbpzokYmhDWzW5G110xxEianiszvcMQaad6Ic
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="353518033"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="353518033"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 15:43:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="728762768"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="728762768"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 18 Aug 2023 15:43:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 15:43:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 15:43:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 15:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRKTv5HhQ36lR1omXr8+LNAwDlUCoa713ALpmw9j0WYL8TbxIJLInj8ALY76yTzgyykcF63e+6Ku1wzVvJ4f7IoudXLlJB7vgp2ZflFDbj+XMbCWcxrFaDX+Kc/imm1qXPsx2skyTEleZTy5InhWUmQZZl52wx+RDvIQwcckdvHKHJhaL5A5DeJ+cIHggdWNySutZ8B3ReaM05zm7d560vcdHPo+QpW8Zjw5whRJvwZvWQBlU/Km+WUPTTXSpdeVu5SHexCATVoYKdZCnogs2CHECYztLymaq721Q+MZCOZPaEJWs/v2KPmgA8IpYIHTfXqGmRY5zXT02SHXpqPkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy2co1QZq+0StusQp03+jPm/Cg8rQONTgNL8U7T8YZU=;
 b=WORhnQ+CzT/sY0G2gB5GV020TLURUkPy/Ms8H6Jql2BJp00jKogS8aNR8a72FfOW7aQPGawYpLOppUNvf0WCDR8MXToU0VYT+3AqcwsJwEvOk3DwXP1IJ8AAyMhMuGnL/E1T8LFgrnWi6ZXCsxWwXDA2WJNs9XzXSC6whtsvD/iulkvTw0NTgGigf+9MnTcN8JwZrj/0Ndd+K0vArzphkmhIIjrApt43HpZq1/8Ex4rWz7h+x08ATX1Cq+/cn2kzi6PNReQyp4VjlaFPpySwIzSVZN2dD1wdXKBigmwdXde1chOrjov/OnUAKIxh/QYrYoJgOIxa5yQzaJ41zu5VTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SJ2PR11MB7476.namprd11.prod.outlook.com (2603:10b6:a03:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 22:43:10 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 22:43:10 +0000
Message-ID: <53a996f1-402e-dea8-9c08-51b84d02d0ac@intel.com>
Date: Sat, 19 Aug 2023 00:42:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v5 14/15] idpf: add ethtool callbacks
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Alan Brady <alan.brady@intel.com>,
	<pavan.kumar.linga@intel.com>, <emil.s.tantilov@intel.com>,
	<jesse.brandeburg@intel.com>, <sridhar.samudrala@intel.com>,
	<shiraz.saleem@intel.com>, <sindhu.devale@intel.com>, <willemb@google.com>,
	<decot@google.com>, <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>, Alice Michael <alice.michael@intel.com>,
	"Joshua Hay" <joshua.a.hay@intel.com>, Phani Burra <phani.r.burra@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
 <20230816004305.216136-15-anthony.l.nguyen@intel.com>
 <20230818115824.446d1ea7@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230818115824.446d1ea7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::9) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SJ2PR11MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: e85158d7-2aa2-45a8-e693-08dba03c7f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9JmgMbLJMKEr38sqk3rd/AvCmMJ1D1cRa6UE10Zpc83+cao9MFz3bK6hHgMmbD75YgML8ow9bgDh3oKkbfwt0JU2kdZxFMHXh8ryqEc7Cgk8epaH7a0DZJMoRTL3S8qqwvPP7w9/7eGG+xWuAQMTIG2ZEEFp3MVlL25rdrGaejwBmxA53BgAEsjIJiewdkAhZabM+mSiuvO5mQOTLaNsqeq4ZGQmkdam4qUiC6UiACC8A1One/yU3XQBYW4yZp/Je85ZNafxuhmtiIp31T0bl61D+cLH6M+46XdCPphzSI4odCUDICzZSYApo8OVeShR0j9yEYewJM6DC4BxYWSnAJ9s52nFTuZum2rQ4ppaQNqpvRV8n9JMa9p73j87CKS4XfVy0MDJhLK6p/TbdNw5bzc8HvsXRqujgnxqbNw3z6anHXz3FoAASjLnFtVA5kvUrMOKNxBVBjTyBH8+ccTKwYuxVxcC+nnB7fnyUAiEogf0VGHfozPbv9tGIfKApLLxdpyoP1RsswMx76PwWN6FHDaJvcGG6MjL6SVp19Mis5tUnzPMHlNfJgGq9+0CtR7kUoWXyVnM7tHqQyFj7N8wpsMkO2ZJGYWAvA3TR6Mdh60SPrvbsLA9Wi4Utj2Few1CBiyqykX1EHKP8AbyI9Bwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(5660300002)(2906002)(7416002)(6666004)(6636002)(66556008)(66946007)(478600001)(54906003)(6506007)(66476007)(316002)(6486002)(53546011)(2616005)(107886003)(110136005)(6512007)(8936002)(4326008)(26005)(966005)(41300700001)(8676002)(86362001)(31696002)(36756003)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3g0cWs3S0t5cGJPTGJ5UitOM0dIVnBpSFJOWUhOUVBDNzNKUFhUSTBNRVU4?=
 =?utf-8?B?VlhpRThnMXhCbWxLUzNaU0toVWd6Q0RCTm8xNzlrQzZGQWppRnYrVXJtWWIx?=
 =?utf-8?B?L0hPbEFMV1FOQXlPZFk4OGNaZ2QrMUFPYjY5Nmtsa2FoTHlDZUpISEpjZW9n?=
 =?utf-8?B?b2dpdTZ5Yms2TVRVNkMrcTY5a0dkbzdZYlFFdzJqb0s3U2ZGOURFckFIWEpt?=
 =?utf-8?B?RzBuUFhBQjBmVUxnVlNNVmZZYk5selFGSkNWNk9Ja2ZRRTBzdmY4Q25UNjlH?=
 =?utf-8?B?WE5GMWw5dHVqMTJCTDZqUmpuVDFmUGFCUlJUSGRmWU1ZMm80MmozcVpTRW9C?=
 =?utf-8?B?UVM1OCs0QjJRcmJOMkNnaDBvL29EV1dEMHA1dlBsZVBPRlBPKy9iN3ZRZE90?=
 =?utf-8?B?ZHhGTzAxd1BHOGJYclpmMVFxbjc1cEpJajMrWDJkdzIzaFhFb0pPL1lKWFFr?=
 =?utf-8?B?eFgycnVOUUlnWTNTRWVRUDk4RkVhUEkxZHU4dG5QNUdsRjllMTZtdnd1UEJm?=
 =?utf-8?B?clhiaENOZ2hpKysrcUhnM295eCtjN3NraE1yRkV5cjB3aFRNVi9BcjNiQzZD?=
 =?utf-8?B?T2ZQR0czL0hIR0szbFliL2xOdWhDRHJoNEhETGRabjQ4cFlMSmZPM2N3R1JL?=
 =?utf-8?B?VjQzZjBzVEkrQlJpVzVlWUNYMHBuWS9NREZtZ3VJdHB1U0d1VThOYnM4eWZT?=
 =?utf-8?B?Ny91M0Zwa2oxclI3Z2djaFVNbnV6TFpxVnVUYi9xNThtRDByUmdGVEtuaHBC?=
 =?utf-8?B?M1Y1dnlhbi9tQXdIekU1ZnZtT1BRemppZWhtSjdVcXFxbWFLenZjKzhFVHhJ?=
 =?utf-8?B?RSt4Wmd2N2krTzZqd2dLcEQvZEFLK2pZQWhSZWYySUlBcGpGSW9KbnVVNzdy?=
 =?utf-8?B?MkEwcmRHRlJMcndYVXBEallGRjVGRlA0UEE5N09FQ1Uxc0YxSkxOcGpiTEx4?=
 =?utf-8?B?SmFtSWFHakRWZmlJbUlMWjZleE9mUlhDWUVabG5mRkJYRjY0UmxiUEc2RDJt?=
 =?utf-8?B?ZWxlVFBHZitTS3BuaWNqeU1JUDBFWWZWa3QybGR2QmRPSUlzaWt1R0gxUTFu?=
 =?utf-8?B?UTA5c24wc0N1UU5ZM0hBT0NGSDJ5OUliV1NPeU1qTG9GdlZOUVBocWdhS1Fl?=
 =?utf-8?B?WFlrdGJSZ25TVGlEL1VOdm5yUkJrN1RLSUN4cktYck4weWhteXpkNlFWN0hN?=
 =?utf-8?B?Y2Y2NmsvajZTeXV1b1ZaY0QyL1Z3YmUrOVhOcVBBcDJpS2o3TnJRRmkxR1A4?=
 =?utf-8?B?VXpXYlhFcVRTQlBJQ0cyejRDYm5iWVZOMjRJNjZ1TkVnbDdlcDFuSlhUcWxN?=
 =?utf-8?B?RVZSTjZYeTVRZnJWZnppTzZ3MFF3UTZoNzJPOUNkMG5BUUp4UFpUQ3A5bVZZ?=
 =?utf-8?B?cEFpSld0QlJ0RnA2NC94cllWU2pESWFNZUJjT3o0M2wwRVluWkVkUEg1alFo?=
 =?utf-8?B?bGFDeDhIUG9qNzZxRTFnSlZ0eFlzY2ZjZEF3eUFyNjRGbXpWcHZoTWQvamY4?=
 =?utf-8?B?YXU0amJ1MExWaHgzMkFuYVF5UjVjSTBiZy9RaEZ4WE0zak1sUGIySTRDdkF0?=
 =?utf-8?B?L0psRnlzWWR5UUZ3a3RuNzFrRXFJM3ZyNGkzL3BsVUt2UlVBd3QyK2k1N3My?=
 =?utf-8?B?ek40bnNhNEplZVRGbHgzSmw5cmpVSkQyU1hlUG9Fb3UyYlBJRDFQYXAwaUF0?=
 =?utf-8?B?bE9TbmFqQzV1ditvV2NRS0Y4TExaemtzQXdyNnlicDZZS3NGcU0wZnJoc2Uv?=
 =?utf-8?B?Si9NazJCRnRsWUhOVmFFNS84bVpyaEY5RkRjTFdQMmJnSkN4MEc2MnU1QndJ?=
 =?utf-8?B?R0V2dk9JWkp2Nk5ndmlPaWM1TXdwT21sSlhkaVBDVlFuRzNCYlk5RHg2UW0w?=
 =?utf-8?B?emt3Q0ZkNUgvNnpnb1lITDRGMk56aGs0Z1R6dENPQXErVFRDNUMyV21vcy81?=
 =?utf-8?B?WE1BV1k4WGFneFBqOUExQjFkZHVWZDMwYWlHcmFVY2hocUFrNS9wS2oyejdW?=
 =?utf-8?B?eDE1RXZiZDVQakJlUFRNbHZleVBuNDM5ODIxdVcrRm9wWEZUQ1BqbWlzUkhK?=
 =?utf-8?B?NUxEMExtZU9yKzBsMEU1TVltS3BNdk1kRU5hWGprcjhKNytxQjZPcUxuRU1V?=
 =?utf-8?B?YURiUUFDU3dJaGtGSkp1NlpxRitkQVVjbGdzWnNlUDAxbFdzZGpnMkhET3FY?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e85158d7-2aa2-45a8-e693-08dba03c7f82
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 22:43:10.4028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rgs6sf1S1F2tTydVN99FWwisgrARIvahlZl9gL/C/gctGYRt+qtNkMGhWh6FjhUmak8bsn9AMcKDQ7PDRtsm/bZIb0Zbj1nITgTcxBeBhhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7476
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/18/23 20:58, Jakub Kicinski wrote:
> On Tue, 15 Aug 2023 17:43:04 -0700 Tony Nguyen wrote:

[...]

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
> Also what's up with the mix of - and _ in the names?

I see that here we (Intel) attempt for the first time to propose our 
"Unified stats" naming scheme [1].

Purpose is to have:
- common naming scheme (at least for the ice we have patch ~ready);
- less "customer frustration";
- easier job for analytical scripts, copying from wiki:
| The naming schema was created to be human readable and easily parsed
| by an analytic engine (such as a script or other entity).
| All statistic strings will be comprised of three components:
| @Where, @Instance and @Units.  Each of these components is separated
| by an underscore "_"; if a component is comprised of more than one
| word, then those words are separated by a dash "-".
|
| An example statistic that shows this is xdp-rx-dropped_q-23_packets.
| In this case the @where is xdp-rx-dropped, the @instance is q-32 and
| the @unit is packets.

Public wiki is unfortunately present only for our OOT driver:
[1] https://sourceforge.net/p/e1000/wiki/UnifiedStats/

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
>> +	}
>> +}
> 


