Return-Path: <netdev+bounces-15789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D72F749C23
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 14:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15DA1C20D3D
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 12:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E098F59;
	Thu,  6 Jul 2023 12:43:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3F8BE1
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 12:43:44 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CAA1FDF
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688647417; x=1720183417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N4KJ285DMn7f8WWUnFsPD45KND/z66nDeWd+hW50MgY=;
  b=BUme0UyI0uzlpQQAaIyTHWjevkoaNWVHvmyY3OXQUU+z9ToU687381Wm
   1HYZ3PuirWSwPucK6sotzdeaXcl2Be2tw/MO2XUJDYFRMN2JVtclXoRkZ
   Jv9oO7XcecI/3YOrqMyxMYlwny9GygnKWMklzNcqLHJG4P2//zbFzdt5Q
   xJP90n7NuoHGtU7jkbrDmYvfpjgH1YGLAXkM+FhHzKTlatlGJsbMotRvu
   zUUi6CvgPbzD+9x7ebX8ekr6E5cPZKLsvkgjE1KUYTCKto58zjkAG1VKw
   L0QA0pxLpQ8sxBa0uM14HQGynBX0+r+rzQCK/ak8OybSTt6SkWf/gLdY5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="343180829"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="343180829"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:43:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="789537123"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="789537123"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2023 05:43:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 05:43:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 05:43:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 05:43:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 05:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKEAujJPrh65jEE01Kc4icfUqzWMUidx1pYeW/l1m6fv8Qm3Xaqb3Rys5h9/BySxj19030qWV2YjFTvYBo+DOeqNXcgr3lI7WDdmokX2TtD/CCrFir3oJivXKrEAVClLQAWAwsxUg+pdmgdAYcU4HVIrqU/ACs/xeSEaI4h2TcujUhA0t8P3mmUrrt+9I0DAWrLYLTwJlCteOZlER2knTupq1p6adTbbcjjmuTqPMbwxBW7r2DdRTvXY/X4DQl7FINlUuS4n/DfWyu8zXhKiLmEES+yeyFelT9aa/CUOoaNmg+ZE12j4n1Nk0pem6Je/sFHT986uxo9TPzGt1r/iVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4KJ285DMn7f8WWUnFsPD45KND/z66nDeWd+hW50MgY=;
 b=c7MXWNcXHgZ6fR62qbw3agpMiZcvUHJ57t20Rw7amTHM1T/coM/aoPzNoVcWVFRKYvn69MaeYgfV4e+Ru7kAnRiJS2MKYLBxlJj++9ThU+a5CijNI4lWLNi5vL3v+FWhe9BXEdVh7L9kzwLSAlbFLKtEE+ZEl0vZToLRwa1COs8pvk3YowrD7GmMeB2Y8Pq1raYtLSDIpq3DxNk3JU3xY5m2eraIBu3M7NNcAY4DGQpmUMjKOl3vV5V3xDPo213c+aUc18VSzaC3ZVK7iAMxSir1flDgGlhHLR3zRQ/KSvFpa0ukQl9EsoaojpklQR/ZK4U3HV76bnYk8vnWCCTDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:43:33 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::dfd2:5a47:bfeb:aa2e]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::dfd2:5a47:bfeb:aa2e%4]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 12:43:33 +0000
From: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To: Leon Romanovsky <leon@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Neftin, Sasha" <sasha.neftin@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Tan Tee Min
	<tee.min.tan@linux.intel.com>, "Choong, Chwee Lin"
	<chwee.lin.choong@intel.com>, Naama Meir <naamax.meir@linux.intel.com>
Subject: RE: [PATCH net 3/6] igc: Fix TX Hang issue when QBV Gate is closed
Thread-Topic: [PATCH net 3/6] igc: Fix TX Hang issue when QBV Gate is closed
Thread-Index: AQHZr37DdC5WVrGXg0W6Xbp4c6l2jK+sX7aAgABNVlA=
Date: Thu, 6 Jul 2023 12:43:33 +0000
Message-ID: <SJ1PR11MB618043DE126BF5649BA1ED0DB82CA@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230705201905.49570-1-anthony.l.nguyen@intel.com>
 <20230705201905.49570-4-anthony.l.nguyen@intel.com>
 <20230706075621.GS6455@unreal>
In-Reply-To: <20230706075621.GS6455@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|SJ0PR11MB4911:EE_
x-ms-office365-filtering-correlation-id: 768313af-8c5f-4513-a6eb-08db7e1e9bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTITti8/c0wGEi/+jABos+R35Kg1/fKTwC26Mk6HrY/bEQTb7DOKqiB7XcgnEvSHLeWLrfd0P/YrAg+cbxxuVgUB2t8KC30loO8+vdrxFN/RbC2P7tMIL6u1bA3FxZacXiLTSYvIXEZxz4pZLuiY1VDuagEcQ+Yz4Psh4AWoctsXJ9E+7NuTMa3GdIVoEC0fkhZQ9fzixKXfTfWXCkgWUeck2ylIBJpJ2TDgjOPaIQzLrvdA4LQ5nxm38cX0/XP2+0I9hh7k9a4SoXc4pg/vnOkZ9DzrTfebIDcDcuJq8bjfL+nA1FaZvbRHd/XhmdElv3SFnb7BFAMIvNox5BD7f2TlgYuHd8Hzd36ewoM9n74PBqesrJ0/KyfKJeS2nnFdnqNagJ4Q/R+bPC0zMRenA9yvzwMKir0AC+nDpACP1ThUmTvzWI9Tmyjtyg47TwP1+/+eaKUiFETRQy9TZnMcLw4oVHTGg72FS8mF95efde1E92Gy6mo5D9NpWlrvryYE2POISx4xaRMg/mo499dr87IqRghEt4T7Mr2xtcsoR1zxm56727UNp5lqdr9mR5n7csYsAtSxx3d0MjEVF785gHmsIUCescLil724BjIwU/y6YpHJVRtbUIwsFte75yVr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(33656002)(86362001)(2906002)(38070700005)(5660300002)(52536014)(55016003)(186003)(83380400001)(26005)(6506007)(53546011)(9686003)(54906003)(7696005)(4326008)(122000001)(66446008)(110136005)(82960400001)(6636002)(64756008)(316002)(66946007)(66556008)(38100700002)(76116006)(66476007)(478600001)(71200400001)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3MwTjR6UDJaQW5yZ2w4L21pTkdtR2w0V2R2dk1RN2RhMHJiQzY0ZTZPV0tp?=
 =?utf-8?B?Z2dUNzdYcTZNWEE4QU9mNWkxbGZ4VUltdnBnWXpZbDJJV1N3R1NnbkN6OHVY?=
 =?utf-8?B?azArdk5XNE9nVGxIL3dGNjJ3NHRWVzhzTzBpK3lFZGszYWFMV1pMb1N2UVlU?=
 =?utf-8?B?NDVDRWZWaWRrNnhJdHNPT0U0TlowYklUQUJtYVR2bGZnR3g1a0xlN0hqUmlG?=
 =?utf-8?B?UWJnbjg2SzRYTTZTY0lmMERXLyttelFDY0ludzROVnRmb2VnNUN5SlBodzlE?=
 =?utf-8?B?dm1xV3VIL0NNaWhzaVA5KzlNV0lncGZacy80Rml5eFllVm9IRTMxTkVmYi9T?=
 =?utf-8?B?eXdpRlRmeElSSDdOT0g0b2NKdjJSZnl0QWJQV0FSOWkxZ3B2dnNKSFhxbnY1?=
 =?utf-8?B?WjIybEFGb0p1VHprd2JvRHYwYVo1YzFTMkM2SXdoTVpPOUtZbk5lL0hzTlFF?=
 =?utf-8?B?UUc4cmxQZzlIUFYxeXFyYzF2S2F0Vll3clpDaGkvejdCL2JVSEpCOFYwNHV6?=
 =?utf-8?B?UGdsUVNIN1lveEVnaXJrdWdHcC8rdjZiZ1JHb21oR1J6L2NKS2lSQnI0SFNz?=
 =?utf-8?B?eWdhaVNDRTdEc1ViMjNIclRTcUlIdTZOUnZiaGplVUt5d1p3RitBMDlnWndL?=
 =?utf-8?B?dXZ5OEZTZFQrYS9FVEpPY0NKTXptUVRWVVV6OU1XbFJRRkdJSTg1RzN6c0FW?=
 =?utf-8?B?eHJDcUFxb09kVHAxRGdUWUpEamxiUXFRYm5hWHpIUUd4bXFvZnVFR0NRN1Zj?=
 =?utf-8?B?VldvZzE2K3ozUlJoZkh6SisrL3B3NlhBRnowcDZ0M0pqakphQldkWlN6TzhC?=
 =?utf-8?B?SVRoVURjeVBoK280YkFHM1g1NDJxRUt3ZXp0TFVXYXdLR3owK3lXdUVFUEV3?=
 =?utf-8?B?WU1qbldNTUVFV1hlZmwzWis1bEJSazBGaVJHMzdGeDBhcDFjZkN4Y1hTRE82?=
 =?utf-8?B?Z0dVS09uallHVW1sbEhWZzF0emVva1REQ1dQQld3ZGRmQW5KWWU3UkovU0ww?=
 =?utf-8?B?L3dvbkJsRUhVd2NYZjV4d3d2emhCb0NHVWgxNUxic1hjR0NubnlvOFpnVmo5?=
 =?utf-8?B?dnlnUUtDWjFUeEQxRWI2ZTVzWG5nMW5jdjZUb1o3Y1Z5L3lwNW5jSlByaGJO?=
 =?utf-8?B?akx5NVh2MmZnS0pCaXh6V0ZtaFhvN0pnR3JRWjduTEhLQWRLMGhEQ3dKK2No?=
 =?utf-8?B?Nk9zY05ocVltWGdzY0NZR3dGcXI1ZmxrU2p5K1F4bmdkMWdYajE3OG5SWGN5?=
 =?utf-8?B?Tkg2Y1ZmQ25yRnhsR2kyZHVYa2UzRm1xeVl2VGhNZ2daN2RaVkxFUGl0alNV?=
 =?utf-8?B?ZEV2aUdqSGNBYWxITmowRWJyN2xjbDZTbFMycjREa3paODVDcE1iMytRd0Jz?=
 =?utf-8?B?SmRJa2JyZUtxU096TGlCUE1ka01KSWQ5NVhybkc5eEwxQ1RKNGh3aTNGTkt5?=
 =?utf-8?B?SE1BVFYxMHU1TU1GY2ZaWGI4RExlUDRIbG12cmc0MEZYMlJyYml2eGRHcmRL?=
 =?utf-8?B?RmJTbXdYVFl6LzUxV0JDZ2ErV01hTkJVTVpKTVhrVzRXM1ZYSXBVZGVTa2FS?=
 =?utf-8?B?WEhnbmdyOGxjWEFYRExZaWtUM2xmcmFUMFB0RHZ0TyttZHArbmRSWW5ySjJm?=
 =?utf-8?B?TXNwcHNMZWhsZGdmRHJwN05JbnAzSmthelRCSDdaOWpheEg0QmlQMGtLTXNn?=
 =?utf-8?B?VUxtQ1l6M09DVFJGVWZLVVJQMEVzR2tBNy92S0dqeVdOUFAyVGgrTzBBL2w5?=
 =?utf-8?B?UllYd3V1bGVBR2JWS0ZOeFUvdkxXL2NLM0RueFZmU3J4enNza2R4RzRiV1o5?=
 =?utf-8?B?SkIvNmZFQmlTSW5yS0lTenBoSmV2Ym1nditXNXV0TGJzUTBFWlo2ZmlQWVFY?=
 =?utf-8?B?OEdXZ2o2dkVFbUpRUE9oTlJtbUQyODFJREx2WEdXWVRQK3EwQlc5NTBnY1Ri?=
 =?utf-8?B?VElXbTlvTitqaitlZ2pLTTN1d2lUVHEyaWtsVWhWemN4TGtkUFFCa2ZQMmhX?=
 =?utf-8?B?ZXdTV0ROMnp1UjAxNERhQ0R2NEw5QnFqdHZnUEhsUFN1T1gxTXBlbHVhaW54?=
 =?utf-8?B?eEExaCs3anVKcnpzaWZ6Q1hOemY5YlA0czZpUWZNVTVUODZ5YnFRYzFBdHp1?=
 =?utf-8?B?UzlZc2pLb2xFN0VVczVFVE5ucW9UL01LR2NmNkRvUzRITVkzTVFFU1RhWVV6?=
 =?utf-8?Q?CUvjk2GlzqCRdpGCxYcKsQQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 768313af-8c5f-4513-a6eb-08db7e1e9bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 12:43:33.0366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wnl3KUSqZZ4ABJrUFnB3eiqPWU9t+uG5d19XxVyPWXeoZ6C0LTymDRxumC6awnj3d1xEGfEi9WPtCzidsoOzEcf8J71Qnx+CuMy/wZJVQrVknrkzlrh4aZ3yLFA64rdi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RGVhciBMZW9uLA0KDQpUaGFua3MgZm9yIHJldmlld2luZyDwn5iKDQpSZXBsaWVkIGlubGluZS4N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9uIFJvbWFub3Zza3kg
PGxlb25Aa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIDYgSnVseSwgMjAyMyAzOjU2IFBN
DQo+IFRvOiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+DQo+
IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQu
Y29tOw0KPiBlZHVtYXpldEBnb29nbGUuY29tOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBadWxr
aWZsaSwgTXVoYW1tYWQNCj4gSHVzYWluaSA8bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRl
bC5jb20+OyBOZWZ0aW4sIFNhc2hhDQo+IDxzYXNoYS5uZWZ0aW5AaW50ZWwuY29tPjsgcmljaGFy
ZGNvY2hyYW5AZ21haWwuY29tOyBUYW4gVGVlIE1pbg0KPiA8dGVlLm1pbi50YW5AbGludXguaW50
ZWwuY29tPjsgQ2hvb25nLCBDaHdlZSBMaW4NCj4gPGNod2VlLmxpbi5jaG9vbmdAaW50ZWwuY29t
PjsgTmFhbWEgTWVpcg0KPiA8bmFhbWF4Lm1laXJAbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIG5ldCAzLzZdIGlnYzogRml4IFRYIEhhbmcgaXNzdWUgd2hlbiBRQlYgR2F0
ZSBpcyBjbG9zZWQNCj4gDQo+IE9uIFdlZCwgSnVsIDA1LCAyMDIzIGF0IDAxOjE5OjAyUE0gLTA3
MDAsIFRvbnkgTmd1eWVuIHdyb3RlOg0KPiA+IEZyb206IE11aGFtbWFkIEh1c2FpbmkgWnVsa2lm
bGkgPG11aGFtbWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPiA+DQo+ID4gSWYgYSB1
c2VyIHNjaGVkdWxlcyBhIEdhdGUgQ29udHJvbCBMaXN0IChHQ0wpIHRvIGNsb3NlIG9uZSBvZiB0
aGUgUUJWDQo+ID4gZ2F0ZXMgd2hpbGUgYWxzbyB0cmFuc21pdHRpbmcgYSBwYWNrZXQgdG8gdGhh
dCBjbG9zZWQgZ2F0ZSwgVFggSGFuZw0KPiA+IHdpbGwgYmUgaGFwcGVuLiBIVyB3b3VsZCBub3Qg
ZHJvcCBhbnkgcGFja2V0IHdoZW4gdGhlIGdhdGUgaXMgY2xvc2VkDQo+ID4gYW5kIGtlZXAgcXVl
dWluZyB1cCBpbiBIVyBUWCBGSUZPIHVudGlsIHRoZSBnYXRlIGlzIHJlLW9wZW5lZC4NCj4gPiBU
aGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHNvbHV0aW9uIHRvIGRyb3AgdGhlIHBhY2tldCBmb3Ig
dGhlIGNsb3NlZA0KPiA+IGdhdGUuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHdpbGwgYWxzbyByZXNl
dCB0aGUgYWRhcHRlciB0byBwZXJmb3JtIFNXIGluaXRpYWxpemF0aW9uDQo+ID4gZm9yIGVhY2gg
MXN0IEdhdGUgQ29udHJvbCBMaXN0IChHQ0wpIHRvIGF2b2lkIGhhbmcuDQo+ID4gVGhpcyBpcyBk
dWUgdG8gdGhlIEhXIGRlc2lnbiwgd2hlcmUgY2hhbmdpbmcgdG8gVFNOIHRyYW5zbWl0IG1vZGUN
Cj4gPiByZXF1aXJlcyBTVyBpbml0aWFsaXphdGlvbi4gSW50ZWwgRGlzY3JldGUgSTIyNS82IHRy
YW5zbWl0IG1vZGUgY2Fubm90DQo+ID4gYmUgY2hhbmdlZCB3aGVuIGluIGR5bmFtaWMgbW9kZSBh
Y2NvcmRpbmcgdG8gU29mdHdhcmUgVXNlciBNYW51YWwNCj4gPiBTZWN0aW9uIDcuNS4yLjEuIFN1
YnNlcXVlbnQgR2F0ZSBDb250cm9sIExpc3QgKEdDTCkgb3BlcmF0aW9ucyB3aWxsDQo+ID4gcHJv
Y2VlZCB3aXRob3V0IGEgcmVzZXQsIGFzIHRoZXkgYWxyZWFkeSBhcmUgaW4gVFNOIE1vZGUuDQo+
ID4NCj4gPiBTdGVwIHRvIHJlcHJvZHVjZToNCj4gPg0KPiA+IERVVDoNCj4gPiAxKSBDb25maWd1
cmUgR0NMIExpc3Qgd2l0aCBjZXJ0YWluIGdhdGUgY2xvc2UuDQo+ID4NCj4gPiBCQVNFPSQoZGF0
ZSArJXMlTikNCj4gPiB0YyBxZGlzYyByZXBsYWNlIGRldiAkSUZBQ0UgcGFyZW50IHJvb3QgaGFu
ZGxlIDEwMCB0YXByaW8gXA0KPiA+ICAgICBudW1fdGMgNCBcDQo+ID4gICAgIG1hcCAwIDEgMiAz
IDMgMyAzIDMgMyAzIDMgMyAzIDMgMyAzIFwNCj4gPiAgICAgcXVldWVzIDFAMCAxQDEgMUAyIDFA
MyBcDQo+ID4gICAgIGJhc2UtdGltZSAkQkFTRSBcDQo+ID4gICAgIHNjaGVkLWVudHJ5IFMgMHg4
IDUwMDAwMCBcDQo+ID4gICAgIHNjaGVkLWVudHJ5IFMgMHg0IDUwMDAwMCBcDQo+ID4gICAgIGZs
YWdzIDB4Mg0KPiA+DQo+ID4gMikgVHJhbnNtaXQgdGhlIHBhY2tldCB0byBjbG9zZWQgZ2F0ZS4g
WW91IG1heSB1c2UgdWRwX3RhaSBhcHBsaWNhdGlvbg0KPiA+IHRvIHRyYW5zbWl0IFVEUCBwYWNr
ZXQgdG8gYW55IG9mIHRoZSBjbG9zZWQgZ2F0ZS4NCj4gPg0KPiA+IC4vdWRwX3RhaSAtaSA8aW50
ZXJmYWNlPiAtUCAxMDAwMDAgLXAgOTAgLWMgMSAtdCA8MC8xPiAtdSAzMDAwNA0KPiA+DQo+ID4g
Rml4ZXM6IGVjNTBhOWQ0MzdmMCAoImlnYzogQWRkIHN1cHBvcnQgZm9yIHRhcHJpbyBvZmZsb2Fk
aW5nIikNCj4gPiBDby1kZXZlbG9wZWQtYnk6IFRhbiBUZWUgTWluIDx0ZWUubWluLnRhbkBsaW51
eC5pbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFuIFRlZSBNaW4gPHRlZS5taW4udGFu
QGxpbnV4LmludGVsLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IENod2VlIExpbiBDaG9vbmcgPGNod2Vl
Lmxpbi5jaG9vbmdAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE11aGFtbWFkIEh1c2Fp
bmkgWnVsa2lmbGkNCj4gPiA8bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+
ID4gVGVzdGVkLWJ5OiBOYWFtYSBNZWlyIDxuYWFtYXgubWVpckBsaW51eC5pbnRlbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogVG9ueSBOZ3V5ZW4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjLmggICAg
ICB8ICA2ICsrKw0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4u
YyB8IDU4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrLS0gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lnYy9pZ2NfdHNuLmMgIHwNCj4gPiA0MSArKysrKysrKysrLS0tLS0tDQo+ID4gIDMg
ZmlsZXMgY2hhbmdlZCwgODcgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+IA0KPiA8
Li4uPg0KPiANCj4gPiBAQCAtNjE0OSw2ICs2MTU3LDggQEAgc3RhdGljIGludCBpZ2Nfc2F2ZV9x
YnZfc2NoZWR1bGUoc3RydWN0DQo+IGlnY19hZGFwdGVyICphZGFwdGVyLA0KPiA+ICAJYWRhcHRl
ci0+Y3ljbGVfdGltZSA9IHFvcHQtPmN5Y2xlX3RpbWU7DQo+ID4gIAlhZGFwdGVyLT5iYXNlX3Rp
bWUgPSBxb3B0LT5iYXNlX3RpbWU7DQo+ID4NCj4gPiArCWlnY19wdHBfcmVhZChhZGFwdGVyLCAm
bm93KTsNCj4gPiArDQo+ID4gIAlmb3IgKG4gPSAwOyBuIDwgcW9wdC0+bnVtX2VudHJpZXM7IG4r
Kykgew0KPiA+ICAJCXN0cnVjdCB0Y190YXByaW9fc2NoZWRfZW50cnkgKmUgPSAmcW9wdC0+ZW50
cmllc1tuXTsNCj4gPg0KPiA+IEBAIC02MTgzLDcgKzYxOTMsMTAgQEAgc3RhdGljIGludCBpZ2Nf
c2F2ZV9xYnZfc2NoZWR1bGUoc3RydWN0DQo+IGlnY19hZGFwdGVyICphZGFwdGVyLA0KPiA+ICAJ
CQkJcmluZy0+c3RhcnRfdGltZSA9IHN0YXJ0X3RpbWU7DQo+ID4gIAkJCXJpbmctPmVuZF90aW1l
ID0gZW5kX3RpbWU7DQo+ID4NCj4gPiAtCQkJcXVldWVfY29uZmlndXJlZFtpXSA9IHRydWU7DQo+
ID4gKwkJCWlmIChyaW5nLT5zdGFydF90aW1lID49IGFkYXB0ZXItPmN5Y2xlX3RpbWUpDQo+ID4g
KwkJCQlxdWV1ZV9jb25maWd1cmVkW2ldID0gZmFsc2U7DQo+ID4gKwkJCWVsc2UNCj4gPiArCQkJ
CXF1ZXVlX2NvbmZpZ3VyZWRbaV0gPSB0cnVlOw0KPiA+ICAJCX0NCj4gPg0KPiA+ICAJCXN0YXJ0
X3RpbWUgKz0gZS0+aW50ZXJ2YWw7DQo+ID4gQEAgLTYxOTMsOCArNjIwNiwyMCBAQCBzdGF0aWMg
aW50IGlnY19zYXZlX3Fidl9zY2hlZHVsZShzdHJ1Y3QNCj4gaWdjX2FkYXB0ZXIgKmFkYXB0ZXIs
DQo+ID4gIAkgKiBJZiBub3QsIHNldCB0aGUgc3RhcnQgYW5kIGVuZCB0aW1lIHRvIGJlIGVuZCB0
aW1lLg0KPiA+ICAJICovDQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgYWRhcHRlci0+bnVtX3R4X3F1
ZXVlczsgaSsrKSB7DQo+ID4gKwkJc3RydWN0IGlnY19yaW5nICpyaW5nID0gYWRhcHRlci0+dHhf
cmluZ1tpXTsNCj4gPiArDQo+ID4gKwkJaWYgKCFpc19iYXNlX3RpbWVfcGFzdChxb3B0LT5iYXNl
X3RpbWUsICZub3cpKSB7DQo+ID4gKwkJCXJpbmctPmFkbWluX2dhdGVfY2xvc2VkID0gZmFsc2U7
DQo+ID4gKwkJfSBlbHNlIHsNCj4gPiArCQkJcmluZy0+b3Blcl9nYXRlX2Nsb3NlZCA9IGZhbHNl
Ow0KPiA+ICsJCQlyaW5nLT5hZG1pbl9nYXRlX2Nsb3NlZCA9IGZhbHNlOw0KPiA+ICsJCX0NCj4g
PiArDQo+ID4gIAkJaWYgKCFxdWV1ZV9jb25maWd1cmVkW2ldKSB7DQo+ID4gLQkJCXN0cnVjdCBp
Z2NfcmluZyAqcmluZyA9IGFkYXB0ZXItPnR4X3JpbmdbaV07DQo+ID4gKwkJCWlmICghaXNfYmFz
ZV90aW1lX3Bhc3QocW9wdC0+YmFzZV90aW1lLCAmbm93KSkNCj4gPiArCQkJCXJpbmctPmFkbWlu
X2dhdGVfY2xvc2VkID0gdHJ1ZTsNCj4gPiArCQkJZWxzZQ0KPiA+ICsJCQkJcmluZy0+b3Blcl9n
YXRlX2Nsb3NlZCA9IHRydWU7DQo+ID4NCj4gPiAgCQkJcmluZy0+c3RhcnRfdGltZSA9IGVuZF90
aW1lOw0KPiA+ICAJCQlyaW5nLT5lbmRfdGltZSA9IGVuZF90aW1lOw0KPiA+IEBAIC02NTc1LDYg
KzY2MDAsMjcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB4ZHBfbWV0YWRhdGFfb3BzDQo+IGlnY194
ZHBfbWV0YWRhdGFfb3BzID0gew0KPiA+ICAJLnhtb19yeF90aW1lc3RhbXAJCT0gaWdjX3hkcF9y
eF90aW1lc3RhbXAsDQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIGVudW0gaHJ0aW1lcl9yZXN0
YXJ0IGlnY19xYnZfc2NoZWR1bGluZ190aW1lcihzdHJ1Y3QgaHJ0aW1lcg0KPiA+ICsqdGltZXIp
IHsNCj4gPiArCXN0cnVjdCBpZ2NfYWRhcHRlciAqYWRhcHRlciA9IGNvbnRhaW5lcl9vZih0aW1l
ciwgc3RydWN0IGlnY19hZGFwdGVyLA0KPiA+ICsJCQkJCQkgICBocnRpbWVyKTsNCj4gPiArCXVu
c2lnbmVkIGludCBpOw0KPiA+ICsNCj4gPiArCWFkYXB0ZXItPnFidl90cmFuc2l0aW9uID0gdHJ1
ZTsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBhZGFwdGVyLT5udW1fdHhfcXVldWVzOyBpKyspIHsN
Cj4gPiArCQlzdHJ1Y3QgaWdjX3JpbmcgKnR4X3JpbmcgPSBhZGFwdGVyLT50eF9yaW5nW2ldOw0K
PiA+ICsNCj4gPiArCQlpZiAodHhfcmluZy0+YWRtaW5fZ2F0ZV9jbG9zZWQpIHsNCj4gDQo+IERv
ZXNuJ3QgYXN5bmNocm9uaWMgYWNjZXNzIHRvIHNoYXJlZCB2YXJpYWJsZSB0aHJvdWdoIGhydGlt
ZXIgcmVxdWlyZSBzb21lDQo+IHNvcnQgb2YgbG9ja2luZz8NCg0KWWVhaCBJIGFncmVlZCB3aXRo
IHlvdS4gSG93ZXZlciwgSU1ITywgaXQgc2hvdWxkIGJlIHNhdmVkIHdpdGhvdXQgdGhlIGxvY2su
IA0KVGhlc2UgdmFyaWFibGVzLCBhZG1pbl9nYXRlX2Nsb3NlZCBhbmQgb3Blcl9nYXRlX2Nsb3Nl
ZCwgd2VyZSBzZXQgZHVyaW5nIHRoZSB0cmFuc2l0aW9uIA0KYW5kIHNldHVwL2RlbGV0ZSBvZiB0
aGUgVEMgb25seS4gVGhlIHFidl90cmFuc2l0aW9uIGZsYWcgaGFzIGJlZW4gdXNlZCB0byBwcm90
ZWN0IHRoZSANCm9wZXJhdGlvbiB3aGVuIGl0IGlzIGluIHFidiB0cmFuc2l0aW9uLg0KDQpUaGFu
a3MsDQpIdXNhaW5pDQoNCj4gDQo+IFRoYW5rcw0KPiANCj4gPiArCQkJdHhfcmluZy0+YWRtaW5f
Z2F0ZV9jbG9zZWQgPSBmYWxzZTsNCj4gPiArCQkJdHhfcmluZy0+b3Blcl9nYXRlX2Nsb3NlZCA9
IHRydWU7DQo+ID4gKwkJfSBlbHNlIHsNCj4gPiArCQkJdHhfcmluZy0+b3Blcl9nYXRlX2Nsb3Nl
ZCA9IGZhbHNlOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArCWFkYXB0ZXItPnFidl90cmFuc2l0
aW9uID0gZmFsc2U7DQo+ID4gKwlyZXR1cm4gSFJUSU1FUl9OT1JFU1RBUlQ7DQo+ID4gK30NCj4g
PiArDQo=

