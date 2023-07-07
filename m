Return-Path: <netdev+bounces-16023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3559A74B04F
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 13:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFCB28154F
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE0AC150;
	Fri,  7 Jul 2023 11:53:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91EBE7A
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 11:53:51 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657D211B
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 04:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688730829; x=1720266829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pafTuQeI7VuKaMYWRi8iloUG//9RZ2vCS30E5t3Nsrg=;
  b=JXz2JnUDGKZJ2LH4DdzVvp7Zxf/dD2zXSX5rk+BLST9HycS/A9UalWN0
   SNRInnCbY97OFgpNdq1M8rqqPqkiBWszHMBU5vK1HMfHvA07vRWZbgOF5
   6Tk0HKhVBLfy2UwZnkn14jBAqKOgFg6hA8jlvTTA+DXnLwOwXHYqJ1jl8
   Wa3lLJwY3h7mnL9lTQSea5LF61nz7okSiy3g7LQ7hB9ecY44EOeZeCvjR
   pFK3mXtABA/5QuGuNwAUcXmJcK8z5Cfr3+9x3cEBcokaY3MjtJ31uSIKv
   WR0AyQIL3O0Dw5fC6/4zpydKoFrStu168D9718oHNFD5umfeEYJ/c3lk7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="362738914"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="362738914"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 04:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="833381135"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="833381135"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2023 04:53:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 04:53:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 04:53:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 04:53:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFfnwe5ZM1ynPGdGIPcjopSVcJA/1u8ZYRVEKRbeJJdHpxK4iveJypPrEG0fhOjh1fUOsLaWkJbztnrIvn5LmZQuzdxh5fGNqdT4avy8fQckvk/gnD/SSZ9O42aVj9khTukb653BBCMKRhcISMmdjTcMtASxUANIUBN8B1RDUaBPGBLK+cn9T/k96plRGTdgTnL6fel0YxcXOVasht9KJbmaqcEPHKaKa8Hwd5omSkKCCvAbq1jjI935AQ/ALJj5Z646rqLcsjfUMzKBqCoitfqwxK7RQU3VrCHbWIXSwav4DzewEMKUrH50Ggc8AuBvlNlyD+usri5EtzKvHPlE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awrWejY+/DR9f0ROssRVcz+VdlehZ8XnPi2jshJJemE=;
 b=jeD2BHkdQOtbJQ3vW7a2ULb4jNeB7hwrC0GDz6EoOjeojs+eQNIMMEjOCJLq3STHs/hQZlpYXKMxSQpumYmJ1pGuvDaj/5af8wnnw4CBvjcQ+SF6VbMSkah4aIAqHbLOCl82yuYNlf6qWlb0ba+VswYUPxI4n+676mt3rzzGOnQENNWg5oHNJ4NUo9md9m0hFR+NkBrgSGQLN/1S4jRVO6jOLjMe4q3GaW25ipFcWvoccj6e2+OHWg2D5lTljAN5avwQwP1QIeIi7zbSN56oxO2ee1GUdgm6NhC/aJf5g5/oET74XuJs/4g0bSbzJl5V8OITFtAGy4ry1dNJpdM8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 11:53:46 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::93f8:ecc4:eb28:7e65]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::93f8:ecc4:eb28:7e65%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 11:53:46 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Ertman, David M" <david.m.ertman@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bcreeley@amd.com"
	<bcreeley@amd.com>, "daniel.machon@microchip.com"
	<daniel.machon@microchip.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 01/10] ice: Correctly
 initialize queue context values
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 01/10] ice: Correctly
 initialize queue context values
Thread-Index: AQHZo8WoH7GxUI9F6k+TPZQn/tvc5q+uS8JQ
Date: Fri, 7 Jul 2023 11:53:46 +0000
Message-ID: <PH0PR11MB5013C25EB6CA1065C09E4DC9962DA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230620221854.848606-1-david.m.ertman@intel.com>
 <20230620221854.848606-2-david.m.ertman@intel.com>
In-Reply-To: <20230620221854.848606-2-david.m.ertman@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA2PR11MB5196:EE_
x-ms-office365-filtering-correlation-id: 77b06a8e-1d85-4f93-350d-08db7ee0d1cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6r0HKqPF4WgvCVffTmnNzCQG5MGCwxGiY0gQD7Zxxx/wiVG/WwP4zUvv4vpJQH45mGeoCiLXkpRcFWhvkd3AUMNrbptktE9tHIXkPCJ6devtguWgqmSYv0gKOCHS3yjadose7CT6KwExPwKtDPAUypRe39d9zEQ7HNHsH9a3jDeCjAlU7Spfed94xDnT7smcA3Uj2ykOTQbpX2ST5yq3kOQjRuXZ1lewcVYn0u6RNk62oYIDYzBRUls53HI/MuUhrActpFJseI2YTOmpA2FuHSfasr8zGTrlJQtXanDxZzrQLstuDPhjw1kO6Fn2QJqhoSObzvISs4JGuxUs6hXrOvjxt6WbIpx3v4W1tqtT2vWxksrCyczQ/AMQNv/TuysyqBIPPt6f3ig7g5NZkNqBoZr872ZRzmTZxNYthJs9442Ks+MwYiwVgnHBMonkit5G9xyTrGLVwAXUjF7TlgUrKZRF17CBEHlTgIg5Rm6hFtz6Iczi5Q1zSvfF8XpPSDqm+bsD3PA8Q8Vw4tjJFt7zg3e7RgpSNetxHEmO6+MIotc/knsKSOMrLGOMiMc3crv/YuvDhAywriUjagSdhgADwiTqjr7Y0UxqQQycmTB4EMSnZUDzXJJSZZQ8GERlHpzF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(9686003)(478600001)(82960400001)(53546011)(26005)(6506007)(86362001)(71200400001)(186003)(110136005)(316002)(4326008)(83380400001)(54906003)(66476007)(38100700002)(76116006)(66556008)(7696005)(122000001)(66446008)(64756008)(66946007)(52536014)(5660300002)(8936002)(8676002)(38070700005)(41300700001)(2906002)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nMcFN6Aj9bsUV9POZT+bcMN6jpIxu+KqqTyeWZWVqJZNwIzcNtaxtlsJK471?=
 =?us-ascii?Q?x+SL1fLLaV3p4oYKnD9Vh5WvB8BujcqHpVvkGRipDgrmUs7kmZ8NFOhxS9tR?=
 =?us-ascii?Q?VkUWEjvEOEVSrjb7WmRK3Je91TWoWDXnragK6k9sKUjFvp4oN28vbiFVrYWk?=
 =?us-ascii?Q?u05vMLiE2o3dr17EupCi1Lf6b27ILXx3WUUJbRLYnP4goTtfWhdsmWo5EoCM?=
 =?us-ascii?Q?FCF2o9ZPCffHzejrDTMfvOnmGUsU4c0lD9NzNmZk0AnuJg2Gdz6BOl1SFJH9?=
 =?us-ascii?Q?3AvF/2EZz9pD2HatWb0tbrTlEhD3l9iatL0O0Shn3PwnkI5HbL91jrE0Gptb?=
 =?us-ascii?Q?NCC343g8357HBqcx2GZGR9MKZ8AuqjFeYE8KpqWW3oZGjvvm8hFHjh9ZKCu0?=
 =?us-ascii?Q?l3zDG6UhWhTFkwQujmSwx69ed7al0Wn4XdYU0PTvnf53eAOvd53HGHlfOe5Z?=
 =?us-ascii?Q?IeKgzk5eubBEPwY3DtOhY1Dw3veDBGJ8cTZK707ttKbyK48ralHTSZJJGA90?=
 =?us-ascii?Q?dclxMAVoafKVeU/peCxM7F5vigs8wk/nQFkqXPQ5OhVP+moRj+cqwYYnMMgg?=
 =?us-ascii?Q?Jz0sbhaZzbIr02okwHTVX2p8YyLvi/TbZEWX0JglT966/nVOh1wW4T2NHEoa?=
 =?us-ascii?Q?NycM2RIVGqsZahxCPZOVkGTHiFIkTIKVFXgYx3tRUcVujs8A8Bt1iXw1NVJJ?=
 =?us-ascii?Q?Y+BuUcCnO1Iux+Hs8Ctg5rzRRC7ZfyRCA5N+7XdeJXSAIhrkNq+INjKShVQB?=
 =?us-ascii?Q?Oqm3j0r6v+IeJ1I9tfZJZDqZuvlA8RTQtFcVPuVu8i/d1hxvDFsKBkxXJeky?=
 =?us-ascii?Q?5/SGT8m7tHqJ4HPsGkYSJcLEJEnfA/9Ur8rPv+vYPP4R5SQd3lulrj/h5F56?=
 =?us-ascii?Q?ftsvsCyv+3dSjTEi5JV4WpHfKuSrWYkkpYm8lFS7j1Y7+SdtmbZlaUOA7uAO?=
 =?us-ascii?Q?DSBixkyms8YBhJKjjr65lwuIuZivI+PVYNTz4hRZpvOOL2FPS6DN588BzgGf?=
 =?us-ascii?Q?Nx2vIzCaFCzXD+ttq0+NZ8lZ7PNz0G3m193lqyv/KeJojV98+791JVzRJZkq?=
 =?us-ascii?Q?Py63jKckA5fXhnAvP6wwkTZ1Q4pI3yYv/JF5yQ0mXeY1RA3wLlBr7o6U0+Gh?=
 =?us-ascii?Q?EqexFFJl/T3eSqHwG3mXYYJefbbz+jVPMnpL48KON8FIo52ofn/4CX0LvKUk?=
 =?us-ascii?Q?AaZ6/Y6MM1drCf/W2sSpjfoArD6ROliH7p3XVFXIcF7M9oj1w3EWSon3AN7G?=
 =?us-ascii?Q?oCS+oRBe6ruZ6qUbRvEYpGoW/R4lQwqqGsaEdiK1HXz7hWFCsZAOHIiDWuCJ?=
 =?us-ascii?Q?8v4xSLTDiyoHnuER46YbReKQcDqxqQBZQyZfltlXxQvaFjsqHWSairZHucge?=
 =?us-ascii?Q?U422VcCdochrqJzfpsKK05XN4CA4PGXu7ZhaGViumbkwjB5RwOyCqCdH7FkS?=
 =?us-ascii?Q?NtwAoFT17IBzlGt9yZN9RTRBkHa+a8QnBQejPbB3RuciX4AQrG4N1el96qs/?=
 =?us-ascii?Q?HFuXejl9+PYiKgGK8oEgpkFKHMJAluSS/41AAllUNKhnEGeSlYjyi0h53Nfi?=
 =?us-ascii?Q?v6Xk+5+iugdd1Hs0aaLBb6Lxgyj7+ZE+PlQfoA/Adu2th5E7yktJzPyzHqm6?=
 =?us-ascii?Q?/A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b06a8e-1d85-4f93-350d-08db7ee0d1cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 11:53:46.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f724LMfMB9XkS8AQzGD8pgMnpxTPcEeGdy2h460OHjBrUIWcED6Ul9l6FQyhYkjedQxGBUMPLSMO7kzXmZq0mxcSkQGkxnU4nzZ+r1yMg0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Dave Ertman
> Sent: Wednesday, June 21, 2023 3:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; bcreeley@amd.com;
> daniel.machon@microchip.com; simon.horman@corigine.com
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 01/10] ice: Correctly initi=
alize
> queue context values
>=20
> From: Jacob Keller <jacob.e.keller@intel.com>
>=20
> The ice_alloc_lan_q_ctx function allocates the queue context array for a
> given traffic class. This function uses devm_kcalloc which will zero-allo=
cate
> the structure. Thus, prior to any queue being setup by ice_ena_vsi_txq, t=
he
> q_ctx structure will have a q_handle of 0 and a q_teid of 0. These are
> potentially valid values.
>=20
> Modify the ice_alloc_lan_q_ctx function to initialize every member of the
> q_ctx array to have invalid values. Modify ice_dis_vsi_txq to ensure that=
 it
> assigns q_teid to an invalid value when it assigns q_handle to the invali=
d
> value as well.
>=20
> This will allow other code to check whether the queue context is currentl=
y
> valid before operating on it.
>=20
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c |  1 +
> drivers/net/ethernet/intel/ice/ice_sched.c  | 23 ++++++++++++++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

