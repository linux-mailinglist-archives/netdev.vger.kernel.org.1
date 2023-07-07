Return-Path: <netdev+bounces-15976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0A574AC15
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 09:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0171C20F68
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 07:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA8B6FA5;
	Fri,  7 Jul 2023 07:39:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF11FB7
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 07:39:21 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54BC1FDD
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688715558; x=1720251558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z5SorA7vJ9Kj3sA63vwMe6N6GvM+Eu+tEspRN02fHQE=;
  b=d67YKK/YJVGvdt0dgWGhD05C5uHce2EWKBoqaEMe2jNVOWq9M/8g9VQw
   cWwZNFPuzwnyNuRI5G85A6hDas+fhxXsGgnyW62CGcGP9Um56DkWKqiKt
   n0d2Omv+pyoyF0Qbr72BLjMwxM4AXWh3IFXVLgBzYFohoGJY6lHFm3Qsw
   hXs7ZdO21dpFrp4vYbp28f7nM80R65yEvBbSYNvABEQZbgO4KEMlt9WIW
   JRxSAGawv0lL26i/89qBlG0IdvvdX/spszyqoOpvfHBJSgTgxGS+TvXyu
   bgf1saOnKfk9UuCDNVdv6ub7C53N/2ab4mgQ0ju3LPcDn2VoYxmdTfemm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429892392"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429892392"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 00:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="1050414230"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="1050414230"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2023 00:39:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 00:39:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 00:39:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 00:39:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mcd7O6kCF0MRstGAanoEYn7w+SELZVfJe8ti3mZekzrAroFL1JFtVUaR2nj8MuDa1Cyl3D+YK3udUUb0Vgo+OfPGCnShkvSKDKXeho5HR8Kodsu1KUlQ7Asg+xJA7XyfZJ4XpSSu9kG9d7fC88d51vhlCSAj1MlvZYcn9vOf70aebZk8IcdJAAm+UliA7XhcK7b+SddOTYKNtzg4CJ9STcjxiC5cdlsfF6iR913lT4HfbiYVDRAem0z3n4jbj8lMU55YOUM+ctg1A+ROr0BxOL27s4qIEMFByfpS9hdgkaY6amstw/oml8t8Bh4rPIVh1rTAyZsg0cM+m190ZTdCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5SorA7vJ9Kj3sA63vwMe6N6GvM+Eu+tEspRN02fHQE=;
 b=kHc0BOyQDUgP6BjwFpqBgE7+44QBto+937898nGlOw41EAjwAN28nJe+K6zJ//4pBScGuu3u5o2if7L7l1S2Sg5mIlLkURDPNizDgBxlbHmVpoao4j5B8OSUFuGzcHn/wiBZrqSaCMwb/ZLuEQDbu8rIK4TgFFv8AMv6kormos5ROYVJ6gAwJbh0+JrwiONUS20lNPDLx8KED6uZURdHD9rTd2ZE+v+vI+2KMSA5tmflIzB79BX8xiPuNB2X0Et6krW75bkwMlXc5iUseloU/kDqTa9NmwSP7J0QB7MW2tp5iGY4XO1v+eRA3eH5kxVnIEQQXo3n8lw5pM1SBFL8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by IA1PR11MB7872.namprd11.prod.outlook.com (2603:10b6:208:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 07:39:08 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::dfd2:5a47:bfeb:aa2e]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::dfd2:5a47:bfeb:aa2e%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 07:39:08 +0000
From: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Neftin, Sasha" <sasha.neftin@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, Tan Tee Min <tee.min.tan@linux.intel.com>,
	"Choong, Chwee Lin" <chwee.lin.choong@intel.com>, Naama Meir
	<naamax.meir@linux.intel.com>
Subject: RE: [PATCH net 3/6] igc: Fix TX Hang issue when QBV Gate is closed
Thread-Topic: [PATCH net 3/6] igc: Fix TX Hang issue when QBV Gate is closed
Thread-Index: AQHZr37DdC5WVrGXg0W6Xbp4c6l2jK+sX7aAgABNVlCAAEUngIAA+l4w
Date: Fri, 7 Jul 2023 07:39:07 +0000
Message-ID: <SJ1PR11MB6180C9DAEB4F5FBEC5D47D71B82DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
 <20230705201905.49570-4-anthony.l.nguyen@intel.com>
 <20230706075621.GS6455@unreal>
 <SJ1PR11MB618043DE126BF5649BA1ED0DB82CA@SJ1PR11MB6180.namprd11.prod.outlook.com>
 <20230706164039.GV6455@unreal>
In-Reply-To: <20230706164039.GV6455@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|IA1PR11MB7872:EE_
x-ms-office365-filtering-correlation-id: 697ceba6-4196-462e-beb3-08db7ebd3f63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EhLpFvjk+t/JyyA41OTFIiWf8NHhNI6ECBvt/njeDxQbIgAw59gXK30WWZspNYpfR7EFSvaM6x+cworuF8WwHooGXJg83pAwY2UX20rgaDAgJheL2tF+xx4E0XRcw/2ZrSmv2BrcGEPsrbsRsiYXyk3EVkvzxLTL71UTlctAnZ8fO9HBkC5S2quhvREcYMNEIusQVznZoeNx3D+xFmHRRT4vao8eRQSFBM/yct0ByUh+B64mSv+pF9qga6lws23W/DNgwt0orEaxSLwROOa3v8E0qwPzWOLtR9k4o23vI5jDsgFtTN3NjhHy1eoRekSlpDLmDrT0t/iP3wxI6yJ18U+woFschp7YqXQm7WxPFCwNkQgcZMvSnCEpywfCnR5ycBY+15FeEKKw4I+QmW4spTE+IspsCIeoKGwa3u65mwfGyI49wMOUhs8MOj/0EAfDEg70vf5YAziJIG7GVQau9qI2YQwi1dk2CBqo6XPRYnlvRcfQ7XF0P/Fss+GefW7KkkAl7h2dUMulp2QQ/CTpNLL40S9Tx/XwDc1CtRwLUNocEYPQYTqLywF/xEmZvrLY56eAgwXNBjhj0nRbQ6d+e1Fa8HrtLYXGPa1YcxQ12h2vpOINRS7+H+lRQxoaxnog
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(71200400001)(83380400001)(6506007)(26005)(186003)(53546011)(7696005)(54906003)(82960400001)(478600001)(9686003)(122000001)(8936002)(316002)(8676002)(41300700001)(5660300002)(52536014)(33656002)(66476007)(66446008)(64756008)(38100700002)(76116006)(66946007)(66556008)(4326008)(6916009)(2906002)(55016003)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTZNUzRZc3JQZVQxUXdlWTBRak9EZSsrSm50SFV1QWZEbjNDYzE4a0UxNklo?=
 =?utf-8?B?dzhySWF0VEZicmxPZlpVTTQ4eWRZa2IrbVpGdWZOKy9NbHpvWlZqMHdwL0Ev?=
 =?utf-8?B?OElzRXpxMlR0YXVSVEpuSnV4WjVtelJXcC9Ed3lvSUR3SGF1cVQzZE9aUHZK?=
 =?utf-8?B?eU9Oam55dUtkZ1NoWG91dzd4TjZNR3hBRzZxQVYzOGtzQ2hOVHplMTRNalpu?=
 =?utf-8?B?Vk5kK2dZUWplVFJBcG9ZeW5xelRDQUZzRmlsVzM0Q2ZWYzhRNlpCS2w4RHZ2?=
 =?utf-8?B?aUdFZHdNTDAycC9EMVBLMnpGNW1PWUJlYmczWFFWb0xJR0doa3hrc0laeFNW?=
 =?utf-8?B?M2xrSGlTVzk1VVVmNnpubnhRUldHM0dRSlhZWHIzZnlUY2xBb1NweFRGY0xB?=
 =?utf-8?B?eWZNVWttOFRYVU5WMlBvMFlmbVNpUkFiNmowTDRiTnY3UUxSTkVJMXRucE5s?=
 =?utf-8?B?WDhnL1ZRems4bmZzV0hyNWFjNHg5SVFUMmVjeThKS28xeWZWNFRMZjFpRmxp?=
 =?utf-8?B?Y2R5cnZOa2xWR2hBVFAvZmlLdjFMQjNodFgvQXoxM3dVUWNlSGRvMzJWcm5j?=
 =?utf-8?B?ZDNLRW5DcE15elZEQmw3LzJ3bHEwdVRJeW1CNXlKbXNvSjh5Z1hMVjI0RjZ1?=
 =?utf-8?B?USt0MVpSM2pNd3FWbVl1OFd2NjgrM0hkd2RxaktKZVZUSDdRdUJadCtXeFEx?=
 =?utf-8?B?b0NaVXdISldReWNvVlhGbHUrK01weW5QcEFiQ2hpNU9jVHNNWFRvUkwwOVNo?=
 =?utf-8?B?Z2pCYVBPWnRqN0pNOGQ5ZEhTVGVHZnE4Z2phendOUnJqKzZFalIzalkvd01R?=
 =?utf-8?B?aEo4VGtzejc3S3drRXdZaVNWdVIydU1VQUh0a05DOVlDMGJWanJEaW43Vmxj?=
 =?utf-8?B?cnppVmYwckxHczlsVmx5aXBDTTZPS3lVeXVydEt6TTNaSXp5VWpqZE1JdWxD?=
 =?utf-8?B?eG5HS2VjQjhDbXZKRFBrRzE0UVJyYy9iQ1BhNk0xSlRjUVFnNmFkTWFZeDNw?=
 =?utf-8?B?TGF5T2hUMCtIekEzY0ZQc2pyY1QzbDluUlZ5U3hEVVFsMG5Hb3pFY3ZyNGRO?=
 =?utf-8?B?U0xqbXN6aUlzVElFSUtGL1A3NmFkYTQ3R0F1Qk9CUEN2MjlUaGJ1K3RlVFR5?=
 =?utf-8?B?aDBML2ZWVm8zUGhBVjJIVVUxL0tCVlVPNEFnZlZ6dEJLQU11TThkMVVyNVJz?=
 =?utf-8?B?cHkvOHRYVDRCWHN5TnhMcFd0VlFNbnNlaTRhbERqK3VXRnI1Z08rTitXQUZI?=
 =?utf-8?B?UWZrWUQ2bGx0MGJWVWpDYXFpUFlqeW1FMFREbDhHT1ltMTdzdGZPVGtTOVg0?=
 =?utf-8?B?T2hwVEJpTUdSNjgvazZDVlVPOURnVWhwMmFNMzByTXpmZTMyc1l6Y2FSM08w?=
 =?utf-8?B?b0RoSXpYNnlTeFhUWWVPZHJQQ1VFenVsb2VYUlVBUkFLYVdwTVdVNUJCQTJI?=
 =?utf-8?B?WGhvUUFtTVlLUmhVcHZLb3FDYkFCakZ2K2xsT3M5ODJoQjRDamsya0t4UjhD?=
 =?utf-8?B?M2dla3NZYUxoNnlrM2srWDBrRFFYU1pNU3FlcmYvSkc5SnF6Q3BtK0gxSmlO?=
 =?utf-8?B?SDNxcUFPUHhWa0lGV2dJNVJZakZQMEROQ08vT0xtS2U2dklvVDY3ZFVKQnhH?=
 =?utf-8?B?ZWw4cWRXVnFSaHRlZXdTbWNjcFNHK3djR0d2MHlZNTVRWjd3cXhuUG1KMFI5?=
 =?utf-8?B?OG8rUUszRUZZNHlrUkRqd2lIT2IwN1MxaEtiYTlvM2xkSzBwZkhmTFM1R3pI?=
 =?utf-8?B?OTR5YUZYdE9CTzUwZ3pjNk5iRnBnamNvaUFwV1BkVVBQZXppN3A1eGp4d0Qz?=
 =?utf-8?B?OXZPdUhCSklnMnhta3JyVTVrcEtJS3lVWmtDVUY0V2k5YkpwS1RkdmNuQlU5?=
 =?utf-8?B?T1VnbDlmZ1hoUHNmYWZ3ZTFUSjNQNTNQelJJVlZVcXZZUlpNRjBIZCs0UzBw?=
 =?utf-8?B?T3doeDF0VkJNNzB2UXNuekNWZStaZkUzNTNScDJjdDQ0OUwvUmNoVWVJd0ZC?=
 =?utf-8?B?RG1QYUlVQ1RleURnWVBCalF0SVVKbkZ2RnJjQ3hNL2ZaMVlCaDBZQjVoK1R3?=
 =?utf-8?B?NVZ5Zlc4d2MyaTV5bDlnWHV6aVNSVlFDZ29aS2JWYlMwR1ZGZ3ZReENYUDl5?=
 =?utf-8?B?YlJSL2dRR3R6VlQyV1BhOHNsU2l5UmdsK3hyVHFoNllXOFFhdDhoTUFzeTha?=
 =?utf-8?Q?ZRYSGScl0SjlWZcT+stu7vY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697ceba6-4196-462e-beb3-08db7ebd3f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 07:39:08.0097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGc0afySx6P41Tk/BW12uSIuMNpqdnDDApuPHW6W+tPkTL5SJ2ZqGrs4pf3EF95u0eQ9OJc4bBT0udj3h39KMdKVYVTXqUHkz756GHkk9ZKskrHTOyF6mia7CwnmMVSJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgNyBKdWx5LCAyMDIzIDEyOjQxIEFN
DQo+IFRvOiBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaSA8bXVoYW1tYWQuaHVzYWluaS56dWxr
aWZsaUBpbnRlbC5jb20+DQo+IENjOiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXll
bkBpbnRlbC5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBrdWJhQGtlcm5lbC5vcmc7IHBh
YmVuaUByZWRoYXQuY29tOyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBOZWZ0aW4sIFNhc2hhIDxzYXNoYS5uZWZ0aW5AaW50ZWwuY29tPjsNCj4gcmljaGFy
ZGNvY2hyYW5AZ21haWwuY29tOyBUYW4gVGVlIE1pbiA8dGVlLm1pbi50YW5AbGludXguaW50ZWwu
Y29tPjsNCj4gQ2hvb25nLCBDaHdlZSBMaW4gPGNod2VlLmxpbi5jaG9vbmdAaW50ZWwuY29tPjsg
TmFhbWEgTWVpcg0KPiA8bmFhbWF4Lm1laXJAbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIG5ldCAzLzZdIGlnYzogRml4IFRYIEhhbmcgaXNzdWUgd2hlbiBRQlYgR2F0ZSBp
cyBjbG9zZWQNCj4gDQo+IE9uIFRodSwgSnVsIDA2LCAyMDIzIGF0IDEyOjQzOjMzUE0gKzAwMDAs
IFp1bGtpZmxpLCBNdWhhbW1hZCBIdXNhaW5pIHdyb3RlOg0KPiA+IERlYXIgTGVvbiwNCj4gPg0K
PiA+IFRoYW5rcyBmb3IgcmV2aWV3aW5nIPCfmIoNCj4gPiBSZXBsaWVkIGlubGluZS4NCj4gPg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IExlb24gUm9tYW5v
dnNreSA8bGVvbkBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIDYgSnVseSwgMjAy
MyAzOjU2IFBNDQo+ID4gPiBUbzogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5A
aW50ZWwuY29tPg0KPiA+ID4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGt1YmFAa2VybmVsLm9y
ZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+ID4gPiBlZHVtYXpldEBnb29nbGUuY29tOyBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBadWxraWZsaSwgTXVoYW1tYWQNCj4gPiA+IEh1c2FpbmkgPG11aGFt
bWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPjsgTmVmdGluLCBTYXNoYQ0KPiA+ID4gPHNh
c2hhLm5lZnRpbkBpbnRlbC5jb20+OyByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207IFRhbiBUZWUg
TWluDQo+ID4gPiA8dGVlLm1pbi50YW5AbGludXguaW50ZWwuY29tPjsgQ2hvb25nLCBDaHdlZSBM
aW4NCj4gPiA+IDxjaHdlZS5saW4uY2hvb25nQGludGVsLmNvbT47IE5hYW1hIE1laXINCj4gPiA+
IDxuYWFtYXgubWVpckBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENI
IG5ldCAzLzZdIGlnYzogRml4IFRYIEhhbmcgaXNzdWUgd2hlbiBRQlYgR2F0ZSBpcw0KPiA+ID4g
Y2xvc2VkDQo+ID4gPg0KPiA+ID4gT24gV2VkLCBKdWwgMDUsIDIwMjMgYXQgMDE6MTk6MDJQTSAt
MDcwMCwgVG9ueSBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+IEZyb206IE11aGFtbWFkIEh1c2Fpbmkg
WnVsa2lmbGkNCj4gPiA+ID4gPG11aGFtbWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPg0K
PiA+ID4gPg0KPiA+ID4gPiBJZiBhIHVzZXIgc2NoZWR1bGVzIGEgR2F0ZSBDb250cm9sIExpc3Qg
KEdDTCkgdG8gY2xvc2Ugb25lIG9mIHRoZQ0KPiA+ID4gPiBRQlYgZ2F0ZXMgd2hpbGUgYWxzbyB0
cmFuc21pdHRpbmcgYSBwYWNrZXQgdG8gdGhhdCBjbG9zZWQgZ2F0ZSwgVFgNCj4gPiA+ID4gSGFu
ZyB3aWxsIGJlIGhhcHBlbi4gSFcgd291bGQgbm90IGRyb3AgYW55IHBhY2tldCB3aGVuIHRoZSBn
YXRlIGlzDQo+ID4gPiA+IGNsb3NlZCBhbmQga2VlcCBxdWV1aW5nIHVwIGluIEhXIFRYIEZJRk8g
dW50aWwgdGhlIGdhdGUgaXMgcmUtb3BlbmVkLg0KPiA+ID4gPiBUaGlzIHBhdGNoIGltcGxlbWVu
dHMgdGhlIHNvbHV0aW9uIHRvIGRyb3AgdGhlIHBhY2tldCBmb3IgdGhlDQo+ID4gPiA+IGNsb3Nl
ZCBnYXRlLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIHdpbGwgYWxzbyByZXNldCB0aGUg
YWRhcHRlciB0byBwZXJmb3JtIFNXDQo+ID4gPiA+IGluaXRpYWxpemF0aW9uIGZvciBlYWNoIDFz
dCBHYXRlIENvbnRyb2wgTGlzdCAoR0NMKSB0byBhdm9pZCBoYW5nLg0KPiA+ID4gPiBUaGlzIGlz
IGR1ZSB0byB0aGUgSFcgZGVzaWduLCB3aGVyZSBjaGFuZ2luZyB0byBUU04gdHJhbnNtaXQgbW9k
ZQ0KPiA+ID4gPiByZXF1aXJlcyBTVyBpbml0aWFsaXphdGlvbi4gSW50ZWwgRGlzY3JldGUgSTIy
NS82IHRyYW5zbWl0IG1vZGUNCj4gPiA+ID4gY2Fubm90IGJlIGNoYW5nZWQgd2hlbiBpbiBkeW5h
bWljIG1vZGUgYWNjb3JkaW5nIHRvIFNvZnR3YXJlIFVzZXINCj4gPiA+ID4gTWFudWFsIFNlY3Rp
b24gNy41LjIuMS4gU3Vic2VxdWVudCBHYXRlIENvbnRyb2wgTGlzdCAoR0NMKQ0KPiA+ID4gPiBv
cGVyYXRpb25zIHdpbGwgcHJvY2VlZCB3aXRob3V0IGEgcmVzZXQsIGFzIHRoZXkgYWxyZWFkeSBh
cmUgaW4gVFNOIE1vZGUuDQo+ID4gPiA+DQo+ID4gPiA+IFN0ZXAgdG8gcmVwcm9kdWNlOg0KPiA+
ID4gPg0KPiA+ID4gPiBEVVQ6DQo+ID4gPiA+IDEpIENvbmZpZ3VyZSBHQ0wgTGlzdCB3aXRoIGNl
cnRhaW4gZ2F0ZSBjbG9zZS4NCj4gPiA+ID4NCj4gPiA+ID4gQkFTRT0kKGRhdGUgKyVzJU4pDQo+
ID4gPiA+IHRjIHFkaXNjIHJlcGxhY2UgZGV2ICRJRkFDRSBwYXJlbnQgcm9vdCBoYW5kbGUgMTAw
IHRhcHJpbyBcDQo+ID4gPiA+ICAgICBudW1fdGMgNCBcDQo+ID4gPiA+ICAgICBtYXAgMCAxIDIg
MyAzIDMgMyAzIDMgMyAzIDMgMyAzIDMgMyBcDQo+ID4gPiA+ICAgICBxdWV1ZXMgMUAwIDFAMSAx
QDIgMUAzIFwNCj4gPiA+ID4gICAgIGJhc2UtdGltZSAkQkFTRSBcDQo+ID4gPiA+ICAgICBzY2hl
ZC1lbnRyeSBTIDB4OCA1MDAwMDAgXA0KPiA+ID4gPiAgICAgc2NoZWQtZW50cnkgUyAweDQgNTAw
MDAwIFwNCj4gPiA+ID4gICAgIGZsYWdzIDB4Mg0KPiA+ID4gPg0KPiA+ID4gPiAyKSBUcmFuc21p
dCB0aGUgcGFja2V0IHRvIGNsb3NlZCBnYXRlLiBZb3UgbWF5IHVzZSB1ZHBfdGFpDQo+ID4gPiA+
IGFwcGxpY2F0aW9uIHRvIHRyYW5zbWl0IFVEUCBwYWNrZXQgdG8gYW55IG9mIHRoZSBjbG9zZWQg
Z2F0ZS4NCj4gPiA+ID4NCj4gPiA+ID4gLi91ZHBfdGFpIC1pIDxpbnRlcmZhY2U+IC1QIDEwMDAw
MCAtcCA5MCAtYyAxIC10IDwwLzE+IC11IDMwMDA0DQo+ID4gPiA+DQo+ID4gPiA+IEZpeGVzOiBl
YzUwYTlkNDM3ZjAgKCJpZ2M6IEFkZCBzdXBwb3J0IGZvciB0YXByaW8gb2ZmbG9hZGluZyIpDQo+
ID4gPiA+IENvLWRldmVsb3BlZC1ieTogVGFuIFRlZSBNaW4gPHRlZS5taW4udGFuQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVGFuIFRlZSBNaW4gPHRlZS5taW4udGFu
QGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4gVGVzdGVkLWJ5OiBDaHdlZSBMaW4gQ2hvb25nIDxj
aHdlZS5saW4uY2hvb25nQGludGVsLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTXVoYW1t
YWQgSHVzYWluaSBadWxraWZsaQ0KPiA+ID4gPiA8bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBp
bnRlbC5jb20+DQo+ID4gPiA+IFRlc3RlZC1ieTogTmFhbWEgTWVpciA8bmFhbWF4Lm1laXJAbGlu
dXguaW50ZWwuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUb255IE5ndXllbiA8YW50aG9u
eS5sLm5ndXllbkBpbnRlbC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5oICAgICAgfCAgNiArKysNCj4gPiA+ID4gIGRyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jIHwgNTgNCj4gPiA+ID4gKysrKysrKysr
KysrKysrKysrKysrLS0gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfdHNuLmMN
Cj4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrfA0KPiA+ID4gPiA0MSArKysrKysrKysrLS0t
LS0tDQo+ID4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKyksIDE4IGRlbGV0
aW9ucygtKQ0KPiANCj4gPC4uLj4NCj4gDQo+ID4gPiA+ICtzdGF0aWMgZW51bSBocnRpbWVyX3Jl
c3RhcnQgaWdjX3Fidl9zY2hlZHVsaW5nX3RpbWVyKHN0cnVjdA0KPiA+ID4gPiAraHJ0aW1lcg0K
PiA+ID4gPiArKnRpbWVyKSB7DQo+ID4gPiA+ICsJc3RydWN0IGlnY19hZGFwdGVyICphZGFwdGVy
ID0gY29udGFpbmVyX29mKHRpbWVyLCBzdHJ1Y3QgaWdjX2FkYXB0ZXIsDQo+ID4gPiA+ICsJCQkJ
CQkgICBocnRpbWVyKTsNCj4gPiA+ID4gKwl1bnNpZ25lZCBpbnQgaTsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArCWFkYXB0ZXItPnFidl90cmFuc2l0aW9uID0gdHJ1ZTsNCj4gPiA+ID4gKwlmb3IgKGkg
PSAwOyBpIDwgYWRhcHRlci0+bnVtX3R4X3F1ZXVlczsgaSsrKSB7DQo+ID4gPiA+ICsJCXN0cnVj
dCBpZ2NfcmluZyAqdHhfcmluZyA9IGFkYXB0ZXItPnR4X3JpbmdbaV07DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKwkJaWYgKHR4X3JpbmctPmFkbWluX2dhdGVfY2xvc2VkKSB7DQo+ID4gPg0KPiA+ID4g
RG9lc24ndCBhc3luY2hyb25pYyBhY2Nlc3MgdG8gc2hhcmVkIHZhcmlhYmxlIHRocm91Z2ggaHJ0
aW1lcg0KPiA+ID4gcmVxdWlyZSBzb21lIHNvcnQgb2YgbG9ja2luZz8NCj4gPg0KPiA+IFllYWgg
SSBhZ3JlZWQgd2l0aCB5b3UuIEhvd2V2ZXIsIElNSE8sIGl0IHNob3VsZCBiZSBzYXZlZCB3aXRo
b3V0IHRoZSBsb2NrLg0KPiA+IFRoZXNlIHZhcmlhYmxlcywgYWRtaW5fZ2F0ZV9jbG9zZWQgYW5k
IG9wZXJfZ2F0ZV9jbG9zZWQsIHdlcmUgc2V0DQo+ID4gZHVyaW5nIHRoZSB0cmFuc2l0aW9uIGFu
ZCBzZXR1cC9kZWxldGUgb2YgdGhlIFRDIG9ubHkuIFRoZQ0KPiA+IHFidl90cmFuc2l0aW9uIGZs
YWcgaGFzIGJlZW4gdXNlZCB0byBwcm90ZWN0IHRoZSBvcGVyYXRpb24gd2hlbiBpdCBpcyBpbiBx
YnYNCj4gdHJhbnNpdGlvbi4NCj4gDQo+IEkgaGF2ZSBubyBpZGVhIHdoYXQgbGFzdCBzZW50ZW5j
ZSBtZWFucywgYnV0IGlnY19xYnZfc2NoZWR1bGluZ190aW1lcigpIGFuZA0KPiB0eF9yaW5nIGFy
ZSBnbG9iYWwgZnVuY3Rpb24vdmFyaWFibGVzIGFuZCBUQyBzZXR1cC9kZWxldGUgY2FuIHJ1biBp
biBwYXJhbGxlbCB0bw0KPiB0aGVtLg0KPiANCg0KVGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQu
IEkgd2lsbCBhZGQgdGhlIGxvY2sgaGVyZS4gDQpXaWxsIHNlbmQgb3V0IG5ldyB2ZXJzaW9uLiBU
ZXN0aW5nIGl0IHJpZ2h0IG5vdy4NCg0KVGhhbmtzLA0KSHVzYWluaQ0KDQo+IFRoYW5rcw0K

