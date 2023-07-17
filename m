Return-Path: <netdev+bounces-18245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7263F755F78
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95B228139E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AD9A938;
	Mon, 17 Jul 2023 09:37:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3007A927
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:37:43 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855FB10FA
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689586639; x=1721122639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oj1NZrBOJjxrmDtSVfilUpGx3oEal/5VwRDqp+fllfY=;
  b=mWcq5EVgtU3kUFyrNlNFDs6Z9B0tW26GYoG8+unsfBZ5H3CWuFDixfjf
   8NOSb7Cz6sW3RhJMK1JMHQZimWgEVp6SdYx2bbz04pkEmhguduPB5wgp8
   X1DzhbTG7IFluoccFkLlJVuBiakOfIVEQ+NAMw51ckpsqbyz9UZR4pavG
   6KjGvrHzovdgxIyA9hmPZtCbV0mgSOTU8EEbv+iVpP/1dyynBHg+AxlHa
   usqoLUrSymtJUgitIHEOnrcG8fRlR+NMiSgehXHTKtwpd6ebIr26ehxJB
   jGXPL6O7wy32BpKJYfR23TRdW6GDV20LdLCCCqvKPQDYmU4YPJYZqDkxY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="363352144"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="363352144"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="813251887"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="813251887"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2023 02:36:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 02:36:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 02:36:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 02:36:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1lS9x6LvRxGBr+TO201e8Viw/JUv/6OGyBk7w+HlhIic6nYsmD9ksmc19zow6Uz8EJOCTUyMUFAj7i6Az9GjNXYhN7OH6oft15Bm50Jsi7720Vb86G51TttgI6Ae8PJeIrVCYv8mWOjcdf7PofP4ofTO6+mPrxBQfBQDqds1Ac5y4rpHHwYIoKXsxhS9JtVqeIlns+Fi1D3EoIaq3vwlC5lXJ6EirqrAprw7mmMOWCo6FSgs5RV5mGydENQIvJAPtoveXQ/+YlWbqwigRB/BNnecLCS+Kytr74AN8/NroH9Zuq1aJry+OmDfjLdNsfeNNUyNTltX94ZdYaqdNAvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oj1NZrBOJjxrmDtSVfilUpGx3oEal/5VwRDqp+fllfY=;
 b=Icw3rdxgrJO1IU1GXdWZYGXGSI3yxo+sr4w8h1yjDaZhmmC94F9GEPirSv37j2vis6oeGImVkq+BeMhDLsv7hRNE43Ng/ZH58ElmkfwPbpCT8K0jOMHie9hOX4ON/s9awPeTwsO1kcv6turuZNkw0BE75HHhAMl/KNUTdcBZF1Ki4GawJjmiMO27LvtjEheLbd9WSdhGowqoJ7Fz8iOiuyrA3Ayj0xsu0hFf4XyhFsLARDyOkcKJnOLQM3CjgDxr11nTSR/fSkGLXwxAXCyxE2x3Sa0msWeu3ze2OhsAKvf8MKyBIhtr+ufGYceZH0/hcOJ2lBSykqNvwLq6P7Psvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA2PR11MB4825.namprd11.prod.outlook.com (2603:10b6:806:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 09:36:44 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::5965:1e86:c9b1:c4c]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::5965:1e86:c9b1:c4c%4]) with mapi id 15.20.6565.028; Mon, 17 Jul 2023
 09:36:44 +0000
From: "Drewek, Wojciech" <wojciech.drewek@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2] ice: Accept LAG netdevs in
 bridge offloads
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2] ice: Accept LAG netdevs in
 bridge offloads
Thread-Index: AQHZuI/xJUGVQJQStkKj0eJAQ/4kH6+9r5UAgAABA4A=
Date: Mon, 17 Jul 2023 09:36:44 +0000
Message-ID: <MW4PR11MB57767325A9110C71C3539128FD3BA@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20230717091843.108015-1-wojciech.drewek@intel.com>
 <e5e7a277-9591-4154-15de-b78be569a498@molgen.mpg.de>
In-Reply-To: <e5e7a277-9591-4154-15de-b78be569a498@molgen.mpg.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|SA2PR11MB4825:EE_
x-ms-office365-filtering-correlation-id: 81313d83-cad4-4a89-9790-08db86a955a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sxzDSkcxQIN8gBdj4Wgr7EsgnSZJDO2h5B3Twrbw9iH6PCMVkP18ODyLrAa1g4HZMMQhcyF599JaOOyHHYOYIgyx+q/+i/QCkAQfdZuo2iAhHNCZEV/jvEwHwWLpayGnTL5Tke4Gc4hl7Xt2sxQqazksJJqytu6tiD4I5OWlN6obKpqnN95QWwHyLK9LVqRTGzhWeZ1tHjvWbAD76nzH6vf7rhptTTH1SADHypuN5eZUyrsxM3xfSvu4zODNWcnhh7BLCrzVzLQKJva/6bXdgGien5kq2Ba67ohdhEF2iNmN5IOsq4YToDSDXbLPQAB1g8gYuWeS7tecoMQjSFH0zirqFZAGEI/xBpw8iQbqHM/Y9AcW0bmcVZ3cLnz/5jsAy0FE9Xn2FGbx59/EfZOhxUOTRe+YnIjXyd7KL/v4ONieeuCYS6h5gXxqjKhDLXZu6Y7ZgnK072WavR/bu4T7C+lwLDtBBo1aJ+gJVXC1Bnc2/O8VG8uI0DnYtckGILpvrapK53XJ/QuaC+Lg93kdvz96lGvOETDl3BD83WS0ZX6CGiKh8LYUdjo8051w4TR/33drL0fUeNfC7YMVMZhjGqJf48O45Oiuz7yf5Fq4zqrEqt2wjL57V75URXozW3AYFplmh2yDYsA1YQcWXtQBqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(71200400001)(55016003)(86362001)(33656002)(38070700005)(82960400001)(122000001)(38100700002)(966005)(9686003)(478600001)(2906002)(26005)(6506007)(66946007)(53546011)(7696005)(316002)(52536014)(8676002)(5660300002)(8936002)(54906003)(64756008)(76116006)(6916009)(66446008)(4326008)(41300700001)(66476007)(66556008)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXdsdG5WMXdBOC9aaEdxSGhwQ3h2VytDS1o3Kzl5R0drZFh0M3N3bzZmazhQ?=
 =?utf-8?B?WWgzKzJwczd4bURDTk9YYXhNU2hqSXQwa2dvUi9Qa0xHYWFOeFRxdVpJYUdY?=
 =?utf-8?B?amV5V0ZualVyTHpwbEpSMm9xMmtCeUxlWGNpVlRQMm8weVhneEVEQnlrV2pC?=
 =?utf-8?B?R0xPL3dFWUpiamRWQldQRjRkbkozRFl3b3BDRTRsa1diNWMxYU1MZVByQVlU?=
 =?utf-8?B?QkQzdE5TcGVCci8yK0YvQUJTdW1Xc0JKcHJ3SSt6eTlwendMOVdLN0NtWWpL?=
 =?utf-8?B?QVpMQlJIVmNqZXJIR2hkNGNEbmh6MGF3UXJUUWxoWW5iRFViRi8zYnU0RHdx?=
 =?utf-8?B?V0U4SW9UNWFwWGtLMEZQUHp0L29obFFNVU5LYjkvREpvamtsM2o3Wm41TVNU?=
 =?utf-8?B?NHJiUStMaWJlVU05UFVoUlJnL2x5ZEVsc0xnVTd1MTMyMXh4N3RBUW9lRUth?=
 =?utf-8?B?dTZuU2V6R3ZtYlM4MytpczFra3laQzN0WXhMRkpuQ3lOQUFQUHZ4Q2RTb2x0?=
 =?utf-8?B?OTNFT0h5aHJPVDRYamoxVkpDZE9hbmJmK3U4SmpPM1FCcmdWMUt1b08vSUdz?=
 =?utf-8?B?cktORHZ0ckR4WEw2Y0EyT3hTYkZuSUFtZmJTL1BLdVJ1RHpWOFJQcXBOYy83?=
 =?utf-8?B?NVFDMDVSQmVEd3YyRDhtZTZlUmNSM2xJTjhKVHoyQVY0c01SVVg3cm1WZ1hY?=
 =?utf-8?B?SVkxanBhWGxXZUttZG82UEpSMmdFSjRYNm54KzVPbzJOWHRhaWNBY0ZWZncz?=
 =?utf-8?B?QUVBYW51eFhXQkRsUEV4bEJtdG5lSTBxeitucVpqRXNyOERHcGtDVHFOSis1?=
 =?utf-8?B?eHVPUERzN2Rnc2hqbDQzUURBVk8vd3didjdnbGErNDZOSmNpU1NIWmp5eEM0?=
 =?utf-8?B?MmxHSGcralhuMHZNN2liT3A5TU9RT0ZpNVZnZ0JLd3MrWWpHNDI3SmcyOXR0?=
 =?utf-8?B?c3AxSmNhQnlwdFFaYkR0YzN6TThUMGFadU5LaXJDMlZoNDFTZ1NhcEJGOW91?=
 =?utf-8?B?OEdYYVY5VjRmQ0xFRWpGUFFCT1FzKzNEWUhMNG9WaGJtcS9IMGhxa0JmbUcy?=
 =?utf-8?B?Y1loZXZOVlhkdktrR1YzRnNxUGJJekJaZlZpRFp5MS84Rm1LWU5ES2JQL3Nv?=
 =?utf-8?B?NnAzemhad0JXc1UvVGZsUGJhWXJpSGkxV1FaNU1oL3lNQWJHMkgyck5QbzhB?=
 =?utf-8?B?YUpLVDlGRDRBazdtMkJ5bnBqTTMvSEdnWVhhRS9sUUZOblV4VjFBd3h0SUlr?=
 =?utf-8?B?UzBzVGEyb05TTEp6QUxxampYbStPVjhIZjNRRUtJWE4xYTRVWThCRzl1VUFy?=
 =?utf-8?B?cDRJRUZFMnZiS2lzaHBUbVM1SXlROEdvYUZXZWxNWXRza2hleFA2VThKa3lM?=
 =?utf-8?B?eWs2d00vdldsMTVVSFBMU1hMQTlWWTRSY0JjWU9kS3FJZ3J4NUd0YmQrV0Fz?=
 =?utf-8?B?bjAwWTBVR0pqODVmcVNzQllxMlVYeThuVmpxVStXMnZWTlp5RGtiK1JPWXdO?=
 =?utf-8?B?a01IbVpBTVcwc2ZjYlVLa1V3RnR6UHJ5NUI1SmRtbGVITWR4TlIvZUlybzZS?=
 =?utf-8?B?MmlMUkVVTUVTcHdpSW5WSkFkU3NrUFZTdVJqVG1wME9tZnQ5djRaODJNSE01?=
 =?utf-8?B?ZXYxanBOVXN3aHJUemx0dmpmWnVDaFpEbzM0QmpNQTlNcHZVcmJkRHViS1hj?=
 =?utf-8?B?ZGREcU1yb3NUczA2MU4xMU5sZHN0dTQ0R3VjTUhVM1V1TldlcnlPanlvMmJT?=
 =?utf-8?B?MjlvM0pGb1gyUDJMdEZiZlRSMHdjejdNdTlySnZvN2syZzlqWUtQL2xjWDZV?=
 =?utf-8?B?WWhMdkFPWE1NL1NVOGpMSmlHZUJhbEZFelNtNkRKWHpiM0NTeUFRWWNXTTNO?=
 =?utf-8?B?SS9aNHk2bnUrcXlCU25JbE5wZ2xDWlJxZStOYmllbXdhS012WW5TeURvWHdH?=
 =?utf-8?B?QitMQ1dxNWpGOHllYm8vM1phRHh1MGZzRnE2b1drNkJaMGs0VXBILzlhT2sz?=
 =?utf-8?B?cUtTTTdJVWtUQjJUOFMvb2YvRENXcnJzOUFCVEhwZEE5SjV2aWZSWTc2UXo3?=
 =?utf-8?B?eEtGdHhYQ1FXVWhBYlNNTktrUWtnMTlLM0s3eGxXd3BjSzR5RnVSL1k1Q3Q2?=
 =?utf-8?Q?/K0Euz+t5mRRc6vHm5wl369k6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81313d83-cad4-4a89-9790-08db86a955a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 09:36:44.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGSKUNnDbiCkYE+OdXxKu2GlzcA6oc1UJjDyf33LlgflpUrM862Bbmpt5zK9/cDAMMv7eO7dRR3wvbhGkRXz7192n24ujulA32nEshOXKLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBt
ZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogcG9uaWVkemlhxYJlaywgMTcgbGlwY2EgMjAy
MyAxMToyNA0KPiBUbzogRHJld2VrLCBXb2pjaWVjaCA8d29qY2llY2guZHJld2VrQGludGVsLmNv
bT4NCj4gQ2M6IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBqaXJpQHJlc251bGxp
LnVzOyBzaW1vbi5ob3JtYW5AY29yaWdpbmUuY29tOyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50
aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjJdIGljZTogQWNjZXB0
IExBRyBuZXRkZXZzIGluIGJyaWRnZSBvZmZsb2Fkcw0KPiANCj4gRGVhciBXb2pjaWVjaCwNCj4g
DQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guDQo+IA0KPiANCj4gQW0gMTcuMDcuMjMg
dW0gMTE6MTggc2NocmllYiBXb2pjaWVjaCBEcmV3ZWs6DQo+ID4gQWxsb3cgTEFHIGludGVyZmFj
ZXMgdG8gYmUgdXNlZCBpbiBicmlkZ2Ugb2ZmbG9hZCB1c2luZw0KPiA+IG5ldGlmX2lzX2xhZ19t
YXN0ZXIuIEluIHRoaXMgY2FzZSwgc2VhcmNoIGZvciBpY2UgbmV0ZGV2IGluDQo+ID4gdGhlIGxp
c3Qgb2YgTEFHJ3MgbG93ZXIgZGV2aWNlcy4NCj4gDQo+IFdoeSB3ZXJlbuKAmXQgdGhlc2UgaW50
ZXJmYWNlcyBhbGxvd2VkIHRvIGJlIHVzZWQgbGlrZSB0aGF0IGJlZm9yZT8gSXTigJlkDQo+IGJl
IGdyZWF0IGlmIHlvdSBhZGRlZCB0aGF0IGluZm9ybWF0aW9uLg0KDQpCb3RoIGJyaWRnZSBvZmZs
b2FkWzFdIGFuZCBMQUdbMl0gYXJlIG5vdCBhY2NlcHRlZCB5ZXQuIE9yaWdpbmFsbHkgdGhpcyBw
YXRjaCB3YXMgcGFydCBvZiB0aGUNCmJyaWRnZSBvZmZsb2FkIHNlcmllcyBidXQgZHVyaW5nIHRo
ZSByZXZpZXcgWzNdIGl0IHdhcyBzdWdnZXN0ZWQgdGhhdCBpdCBzaG91bGQgZ28gd2l0aCBMQUcg
c2VyaWVzLg0KVG8gc3VtIHVwLCBpdCB3YXMgaW50ZW5kZWQgdG8gc3VwcG9ydCB0aG9zZSBpbnRl
cmZhY2VzIGZyb20gdGhlIHN0YXJ0Lg0KDQpbMV0gaHR0cDovL3BhdGNod29yay5vemxhYnMub3Jn
L3Byb2plY3QvaW50ZWwtd2lyZWQtbGFuL2xpc3QvP3Nlcmllcz0zNjM1MTANClsyXSBodHRwOi8v
cGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9pbnRlbC13aXJlZC1sYW4vbGlzdC8/c2VyaWVz
PTM2MDYyMQ0KWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9aSDc2OWFnam1GZVRM
a3E5QGNvcmlnaW5lLmNvbS8NCg0KUmVnYXJkcywNCldvanRlaw0KDQo+IA0KPiA+IFJldmlld2Vk
LWJ5OiBKZWRyemVqIEphZ2llbHNraSA8amVkcnplai5qYWdpZWxza2lAaW50ZWwuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFdvamNpZWNoIERyZXdlayA8d29qY2llY2guZHJld2VrQGludGVsLmNv
bT4NCj4gDQo+IFvigKZdDQo+IA0KPiANCj4gS2luZCBucmVnYXJkcywNCj4gDQo+IFBhdWwNCg==

