Return-Path: <netdev+bounces-15112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232F1745B9C
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 13:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532C31C203FF
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A72DF52;
	Mon,  3 Jul 2023 11:52:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C29E55B
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 11:52:07 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F789B
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688385122; x=1719921122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U4j5v1NRQx9LsIpN0WOFyKboWmncOgI8eIhk5fGStV8=;
  b=d4aLrFpRfDcAWj6ksHFHu32xzdkySjCWSGsQC+ugV63hzJAULSwd4kkO
   kcLiYJ/vqeixvtVl7eSvcUF5SfXbemIskyeE+qR8n/dJ0nfAi6jOdS90C
   dZNA4UbVeKEEo1da5wiIdL12FXcHmJV4RBldVFz++7SrejsJW+SxBPktg
   VqwfZErkHgwW/COsgYpEGtswuYciVLQcJPuLi2P16GomZkMAq+AXH6xUo
   KYDGikZ6UCKrEEqq77xbmbmbnOp6hEHgRkCg6hllOljH+KMCJDAyyVAu3
   sTF6RCM/5NJHV5Z6dkGyZMVgyScrslLDRCVMgw7cTVP6FfamHV5HTU9IF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="361721842"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="361721842"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 04:52:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="842635183"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="842635183"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2023 04:52:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 04:52:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 04:52:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 04:52:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 04:52:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xesb6H/huIXeXhVj+MvCkoKZq8hY2nYjSmxcKPQ2IB5V6+cIu3EZDMHUPvB66MfChV+DrOtDPwYxB/iY77FM7yTvn9kBwsqq7ES8XVNFnOWZiusGlp76eoiSnRYAlD4T+/GpdBV3+p3etIMciMewNHARtvB7VKCzDAEFZCc70e6y53G0ARhqgwbL5wzZ18aTXlcCOUKIB0uDe0+w+BWLbXOaV3MLQK1LMzaX5uGMxlR8ZBu6aciDfYFa8JqwTqDu+ZG4GVWVIcCKB9wJdHAnLihujXDxwAC5wwSdvrbE2LyhHZm+jZE1QwAR0Xm+/chGXiWlxbMQq0UaSfIVHwmEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl7u0pyisbJq9cfHsltywA3ChXZWPdbyDvirYYbnB/8=;
 b=Rgxb1VlfaBt12d8HoTL5LlWAlYwRPIYeVhLCKViV45fmIofP4pQVezDxUCw2VZb7WUg7JI11G2a9Rvn8MaQHHg1LvzVmnn01xMjHIufTrRj+QdtkPQuKzOeJg7pCG3BjRRRuHHrkNmsRi14jM+XV80Ek9bZ/xwvF4IIUxxFBviRGH74D2VxanmWxFU+i+NyfCfFGjo4TqvWD7iU18ec/+Era/AfqAGseR51LgqgLlB5KtPZ1oyhOBV6BahYgb6Pem2a/FMA7G4tZvEoANQzUZPzv1+s2l/RO5XhbVYhf+yQapfPMigz1UY7JPJ74KnO/pkM4AViSLDkV7Su7Unj+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 11:51:59 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::fcef:c262:ba36:c42f]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::fcef:c262:ba36:c42f%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 11:51:58 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 2/2] ice: Rename enum
 ice_pkt_flags values
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 2/2] ice: Rename enum
 ice_pkt_flags values
Thread-Index: AQHZpRCTak/Tp7RBAUm9w0pH8GyU8q+n/1hQ
Date: Mon, 3 Jul 2023 11:51:58 +0000
Message-ID: <PH0PR11MB5013C17C35751D81B4DA80629629A@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230622133513.28551-1-marcin.szycik@linux.intel.com>
 <20230622133513.28551-3-marcin.szycik@linux.intel.com>
In-Reply-To: <20230622133513.28551-3-marcin.szycik@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|DS7PR11MB6222:EE_
x-ms-office365-filtering-correlation-id: 5c198720-dd34-4538-5f0d-08db7bbbe842
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 53XU+SpsQtZsmgTWR1cOxwp6+iwANjV5n562kaAYfA9egeR625uN2BflCLMcuvI7Lx2ZyuGe+0HcsK38FnN3gkSy49/7o4BvaSvuLoaKbOzc8ktIHi/1XXaPIqPTndRl7tdJQVw8zSnrxhCh1b+bMzApncd+1Ap6GhBBcD0AQI8o0ousPYitzLYde15eCBeH2k2TRmyJrZvTzoEVj/8MdBgasPJUQC1+5PEbAzelw9I0XIIhhWuD1To3T1PbWFSQ8Z+/Ta8F/Kuhv627njo/p4YvZ4qooGQUIlYK1SQ2SkRcYK9Ok7TE63oo1STyGMYUDP3wSikwIBt/px9EFn3KO3cs7cakmJEgL+AN5oFgEn89FEHdFJ8lmaj2RhRLlHGheephd/4C8DtzBVke5iOS+MHRayiXuFuIutgLjD34K/7zGwuQvWeMeMtG3nuVwKkeTgHVj4Q/82+Q0j3K+iQd9DucCnwjzdciv+oFk8bZH9i7E2h3rXKoy0HbIowbWBgFjQP7CiW2OV62Z51tezqY28IxyWC4x6H4lAJdSHbmrVY3UvHqDCvit6OgOz09if/FB1pHV3W9khf0LF94kjozPEv7Jlzcqj4uxDYTV8cLpo3qaRaCUNxq4WDXVX7f3wkf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(66446008)(4326008)(33656002)(66476007)(64756008)(66556008)(66946007)(76116006)(316002)(2906002)(478600001)(8936002)(8676002)(52536014)(5660300002)(41300700001)(55016003)(9686003)(110136005)(86362001)(38070700005)(38100700002)(4744005)(7696005)(53546011)(6506007)(26005)(186003)(82960400001)(122000001)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lH7B5kiuTLmuqju1XryITvnjXG4zXCxjMAcAkovCKh1ee+2pBX6QNU6FVyt6?=
 =?us-ascii?Q?k+WnGpLsZRJ+Rouv59TMBx4uQg8NZ1j1VmFv9xa6uagUKa9K68B/82xuz09F?=
 =?us-ascii?Q?BgRofUDfnzNFON5NZoGcoVUEDYBzD73qPywAppPygQWtlPJAF9S0Y3WnHqab?=
 =?us-ascii?Q?8qiX+r5l4udR0kGKa5erwz+RddtCRDwffG+YAnq0dfOHVIehDyacc1L1PVQJ?=
 =?us-ascii?Q?Z+M1QblhUbZGdBwOTY4sxLwRq1NUHlRGT5toHSzxr2NmaX8cVevS9bIQnKz3?=
 =?us-ascii?Q?P22tbJIxSUwTdmiSAsiG1GmUkg57gJFddWowhG7GSjlLMhEJBLRBFVYBgdYo?=
 =?us-ascii?Q?/qTTLpViGpvDglq0hqEc4vRAYR/bF2Tic09/1vN1hf8VSJ1Gz7jcch3N/r9v?=
 =?us-ascii?Q?ZB5ZbIlSW2/c3si4HSuVj/T7VWRV3l64yoBL/+f+23h3nGsG8nfq7WsSDG1H?=
 =?us-ascii?Q?bq9ItpdBry4guyela+1Vhyo2i9g2ShcX9BGSXq2deQ0O76cyx7kn1Jhw5tvs?=
 =?us-ascii?Q?Oh5/4ygUF2oRTCRKyGNdd/YmWp3/35DRUG9AI5Z8i0VonYo13F22blrhtzsx?=
 =?us-ascii?Q?fuXGCUSBH+r3BKS1KFQUefpE1Et/ByAB9bVkFjWW1t3zytz+DEVyTKzRuNhn?=
 =?us-ascii?Q?pRp91+6K6YeHMVbbxsziuPyzoEDz90xc6UNTi9oiBBPgXH9m68acXGYmE+w7?=
 =?us-ascii?Q?ih6JlnIKX/Qyf6V1wuiSGjwySnLHJPIrkUmpbXjuUsZYEO8lziQjXB/1hdu9?=
 =?us-ascii?Q?k/ZEKUOHtuu5cIun6WG9AiZQlQjcP3+nux+FgrugeWC7h6kyyFc0EC47oSBv?=
 =?us-ascii?Q?dsIkfleW+9tvY40GzLk7v6BfNUzYpLyTI4z/udy7HU/IGPCtMB6UzZvfXKYX?=
 =?us-ascii?Q?M6KKCXgGmRqRua4jLuXFaQIyEGpvPEiFsxCorWwWXndKquya+03uN0vuwFIO?=
 =?us-ascii?Q?3FRQLIRggpk6mDQQ/cZu/XXHX2imb9puspvPWZRCuO3iQSuQ0ooN80OOBZ1F?=
 =?us-ascii?Q?Spz7fIWtStWZMQVFvTNdIQ6gRvCAWBWWekcCvvSO19Vl9I7JBZ2tfrJ2B8yj?=
 =?us-ascii?Q?OzwVAONI6V0qOj3PvJota/9nM0XV8ah+Yq68AXGqXtW7kqAcFsfMbNgCL3Cx?=
 =?us-ascii?Q?ZknrMThTWuLlIdm6HoxxAouJZrsnnl47teFXbN+/d8yR1ANQ8dJC4mfaFk4w?=
 =?us-ascii?Q?oxgxZHDgtOBbyHiid6DWCw9+ym169vHH4PYUhUx/qrAEQTuqG8Hd1G2xZY3d?=
 =?us-ascii?Q?AvgpttPhx9Qpltx9MqS4GfXwFNeAXwo5NdtCig9b+UkSZLzdq56aNMemqXrl?=
 =?us-ascii?Q?31gJAMxpLuX7IKnjYfxOqNHa1P2THd2xWkPdLcRW4p4+S4lR9NUsjz7o+FNI?=
 =?us-ascii?Q?63DNmWaCu7JZ9M2sLHVNvUlNRHrccp7caUrRV6TQRwv3FhPFr4T9BBeA/EPD?=
 =?us-ascii?Q?pgHReSUkZ9pfbde9XkuTvgmcBeIXrA6E4RkIlsWw6o7YAkvqJSNLMw+E3hwz?=
 =?us-ascii?Q?Hx0K/Ed+W3N4sCE8cWHTrzeqMyniDELdHD9Q9rXM41/YduzgqKITsxZHH/HX?=
 =?us-ascii?Q?XX2Qqn92JhgscJV+54i++7jKKGdk5R5TLPZQgWrmA2KbvHqcbZtXOjUuqTZV?=
 =?us-ascii?Q?8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c198720-dd34-4538-5f0d-08db7bbbe842
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 11:51:58.8770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pq3bmW6VC2F0/7jQJF2J2RPfw62UeemIaGfU5note7iA927ijrSypR/GPxgP8JYtro9FxaGSZ5UKKWaGIz+NB5QZofQh1ALQaWju9tWnsQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Marcin Szycik
> Sent: Thursday, June 22, 2023 7:05 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next 2/2] ice: Rename enum
> ice_pkt_flags values
>=20
> enum ice_pkt_flags contains values such as ICE_PKT_FLAGS_VLAN and
> ICE_PKT_FLAGS_TUNNEL, but actually the flags words which they refer to
> contain a range of unrelated values - e.g. word 0 (ICE_PKT_FLAGS_VLAN)
> contains fields such as from_network and ucast, which have nothing to do
> with VLAN. Rename each enum value to ICE_PKT_FLAGS_MDID<number>, so
> it's clear in which flags word does some value reside.
>=20
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_protocol_type.h | 8 ++++----
>  drivers/net/ethernet/intel/ice/ice_switch.c        | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

