Return-Path: <netdev+bounces-46900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BC37E700D
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0286B20B19
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834FA22324;
	Thu,  9 Nov 2023 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXBBgfjO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E248E1DFCB
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 17:20:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAB72736
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699550419; x=1731086419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xX8cSy/TJ6E/Mcd9IRwjymHxnZVtIebRX52mzFVCg6o=;
  b=LXBBgfjO4zX95T598DdatKTtLq2J+Pl6nT0dmO//cxjGHCi+xcXjW7Ao
   KZ/X43N3Ld9SXx4kn5A7ZImPQsu3eDfamFCp+GWnT5eFauDde1jw7uwMK
   zuH2f61pDBSkOTUsYfLUTJsbh4Q816+0pP/GY7WgpPZUGkFLyfHzhJhKg
   laNzsgDk0CEnFkstjkAMyOvoKYzbY9ah+IS3oayp69VnGDKf5hA47R9xk
   X2D9H3j3FSoZVdu8a3zfSXRuehVF+C64iSeNFO4cVcJfwISC9aytjyvEc
   IepIegd3/QLVo/V0/1XixbhVONSDShMVO4mvtbEmhOMgLzOp0bKOO0bCr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="421126232"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="421126232"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:20:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="829390619"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="829390619"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:20:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:20:18 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:20:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:20:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:20:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvDhArT8/h9ow6hUL+und/oLfg+qE3cBVErczY4EKJbRqdZg841nvxvNIAWn+iZ/mCQZY+iafjazZEk4dKC0tVHvq0oDk/lGGiURNuN7hD81OBc6mHPUTKLnDyIVLZ+XOdFyNByBVpc8h/bgQY6JZcxhhk/WtQRgzVCyyZYToRXu2fNgo2zi6B6eOsc5UUDUC0ho1c0kvu2MtoxQ5sv4DW5gbIRIgx0Ns0gHF3qqgri+KTibkN1HjXuKzDgARNjbeem0GsftqEhD2blG/rKVrdJN8dQ1IuVqNwWMF9HfJ9vGFnHh8hEnka4Ci2cSkT1n++kRp67fHVsNDR9xJ814zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xX8cSy/TJ6E/Mcd9IRwjymHxnZVtIebRX52mzFVCg6o=;
 b=C1lxiPdKngdejtQoJ4suoAH1Hed228LyZyQlyTfWiCQLOHU9jUzqhKAb3IP3coi8jYK+WDi38rZmvm+nHNZR0KZH/Z0lu2hr1YTvvqBh0yi1GwxKe+hanAgKXH0C73nP0PqWohZdjW3FO9JqKpy3xXYsf0mCc9SEtuEUqRcqe+jQ1ZHP0Dmd76OZUcvyYYo0HNdGjPWkEIQp54s9I/pRGQoWWQXV/ERTVxdfFevmwvFv6Jt2oW1Y5VNHPPfch9U+r9nnsmpzUFb8q0riienBW3KWScHIlfdpeCJKCqCYaKBNbN3ImYuGBtmu2X9blujHL5Zy9X1BqbnRMOmMtpHUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM4PR11MB6167.namprd11.prod.outlook.com (2603:10b6:8:ac::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Thu, 9 Nov 2023 17:20:14 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:20:14 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "jiri@resnulli.us" <jiri@resnulli.us>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 0/3] dpll: fix unordered unbind/bind registerer issues
Thread-Topic: [PATCH net 0/3] dpll: fix unordered unbind/bind registerer
 issues
Thread-Index: AQHaEi9OB4zvczpCGUaIr1usLpOLxrBx0M4AgABky0A=
Date: Thu, 9 Nov 2023 17:20:14 +0000
Message-ID: <DM6PR11MB465721130A49C22D77E42A799BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <4c251905-308b-4709-8e08-39cda85678f9@linux.dev>
In-Reply-To: <4c251905-308b-4709-8e08-39cda85678f9@linux.dev>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM4PR11MB6167:EE_
x-ms-office365-filtering-correlation-id: afb340d7-354a-4929-5fc7-08dbe1482332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m0rtXeEas7zDX72dn0ew0ZSUYyPgkk0bn+akBwNg3lDGls2GlfSaK+nVuW1q2UqXABGlZ8VcM/X+5/R0WLN9X41x4UyavU0G8ywxhN6rJFMdjbpyjFhH2yqzMb/ekbvQRzeR0aUWnyQo3cYtaBMKRCDTqCdMII/nWLM/oH3z9QieUg69HiMRVnAr6e9oTpQJ7HRvVQKW8zDWi4aQKLJvfmAmvX+edIcoOFHFd5GxMx9kNhG6tzfBGu/q8t81mTVdwWUMi7z4lkm1dzRtM2127FK9aHnY0axzoFU2vjq94SqmgQ4weyt1X9IUTgVcLSWf/QvlpqHDHEjwCkrCJseBxJCTpnJSzikTA0+3/IYYB6lNkUg4mBllyqs3leJfvbl2x22Zn9L5w6+tqpIshhEHcKH/mbgtBgH6V1lgfCRocHUljZtgr4JPoH+1AX24PndtevBAYaoT5DPHf8XEf7ghglICFAb9pPbdKwa9v8R0nImhex7D1nOwClxx0oyWZ2H3j/X/36PzR5KFHLhIoAjekg2lzQBANX6mb74MdwFPcXldsNkKPcMMz2FsdkpySvH4zBz0i749/DzbJOOOdmuaULW1v4xvtRgxO8ucxf9Oh9gsHLQt0l9meQH0OJUbl3Ej
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(9686003)(26005)(7696005)(41300700001)(5660300002)(4326008)(2906002)(8936002)(52536014)(71200400001)(8676002)(66476007)(64756008)(76116006)(110136005)(54906003)(478600001)(45080400002)(38070700009)(66446008)(66946007)(66556008)(316002)(38100700002)(122000001)(86362001)(33656002)(82960400001)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qjh4cXUxdUxJVFNUeDdlajh3ZUEyYnFwZE1zYmFVMjEwTnE1NUZMeGRTalg1?=
 =?utf-8?B?cHA1L0FqaVhmMk1kNFdwUHE1VjVFWkRjRnJUUlFSWGU2SW5iNVljQXRmMVMv?=
 =?utf-8?B?enFkVGxVT25rdFROeEdPRDkvamFrTUZOMXNnZmhacFkrd2ZPRG80SVhTSGRj?=
 =?utf-8?B?SkFGaTJySm9oNkMyV09VeE56ckNxM3ExQ1JWaFZTU1JLemhYQ1RMUDFqSVJp?=
 =?utf-8?B?QnJIdmNLNHlMZ3B6RlFXZVVvMTg4Y1I2MDJ2UmVjWlBKREgxSEgrbWFvMnhz?=
 =?utf-8?B?a1NmQXduWVJvbTg4Uzk1SFRUcSt1RjBRdlBhWjBabmZnMHMyWmEybHdHMFky?=
 =?utf-8?B?Zi9KbVVSNFptR1BuTHVTT0I1clgzc0d1cFZsSWNYamxLcnljUjcvQzBKTk0w?=
 =?utf-8?B?bW1CN2lyUzNRTzVqU3R3OFFmZGRsZjNGV2ZvdjFrS0dvWGZncmxFNzhEdzJ4?=
 =?utf-8?B?ZnhtS29VNm9za1BJVzlmVHllaWNRRTFVeGdBdUhicXE0V0o5R1dqUGRvVzQ1?=
 =?utf-8?B?VHF1TTQrNkc5bHFOY3ZIQUVtVWVtdGdheDVQSEdaM2Z4emFMY0hEejF2UGYr?=
 =?utf-8?B?WXNXNVRwZVhwKzZDMFU4SFE3bVp1MnBlc2ZFVUdpNWhsRis4MndaMHBZYjRE?=
 =?utf-8?B?elJjS0cvc3p3bG12N3pwbVRmRkdqdlMvcm5OU1VyeVlBV2Z3ZzdaZERoa0w0?=
 =?utf-8?B?MlNUSk41ZkhURHQyRkdTTEdlVzZXU2xCdlZsbW4rcmNDZ3k5b2JCV0JBeG9Y?=
 =?utf-8?B?T092MXdkQTFxeml5ZXYvbHBQYWlnUm04MWNBRHhvN25BY1M1a21taEJOaEQ0?=
 =?utf-8?B?UmxyNWk1Qm1zSExvUlJEeVc0NHNHSUxSMkhLRkp1eHVCTTJ0S2daNkMvNVZ0?=
 =?utf-8?B?OXYrWWlpMEYvMGh3OUlHWU0rRXZBdDNQa01FdXRhVnByWkF3L0FZTjYySW83?=
 =?utf-8?B?T2w0Mzg3TnpNV0xYU0hTTEgwcWZlZlNsOGR2MldlWEE0SGdDNU9la3dxU2tn?=
 =?utf-8?B?SUcweC80c2VvYzRaQXJYQk5ad2I0TnU2amM5R0lvNGZIckt4TENhYk8zM0Qr?=
 =?utf-8?B?clRQeHBpbmpvYWpsVUNlMVdXMjdQZVc5QVVCWHFDSlNLNDRTSE5SOFJGQ2l4?=
 =?utf-8?B?YkZqUU1lWXJoSElqUGVDTWN4dlo5Qk8yeFAxeHFhSUUwN1ZNTkt2VG5HcHJY?=
 =?utf-8?B?WHd2Z2Q4TDYxZGJhRjZ6czJreUJxZW14WUtOZnEzOUJpRkpRRGVwRmJoQlcv?=
 =?utf-8?B?K3lyTkRhQUdLOUl4RnRYTDd6ZUJQQUplYTl6cHhGck14cEE5WGx2RHVWamYw?=
 =?utf-8?B?VHNxSytUdlVaajlxUzd0bWlHOXgyM1hTSDhDS1FaWVJpMTRiN043WXlMUVRM?=
 =?utf-8?B?TUVjMGZkcjMwRmd0ZU96WUx3NGViWmtFa1crQjdVckFqdUcxZCtwS3ZYNXRN?=
 =?utf-8?B?TXVjZEJjMFFSKzc4NE9LSFU3ZmFvcXhpUjE2cWxkdlQ3NEYrRW9teEJlQ09n?=
 =?utf-8?B?cmxSQXhVUGNKNHhKZXVFOUhXcUZGQnhPb1Mzc3hVdjAzaUlmNzJzU0V4bVRU?=
 =?utf-8?B?Wk52Z0ZYeHMwSmk2bGZHbDVMdlNLZjJHSjdwVUQxLzZlWXpBUUh3d3J4NnRQ?=
 =?utf-8?B?WldYVnpFaGlQb2NuQnYrbUZXVzlNb0pYUUROUGx1OUN2SWozcjM1Zlowa0Vy?=
 =?utf-8?B?cFN0OTNvVVlnbWNGRnhacFBWN0JQZWxzOWhhWnNpdkliR0JubmRjM2l6dnVV?=
 =?utf-8?B?alVBaldqOTlCWnFHUW9heXJWcDVxWWpmNkdpQkhLVFJ0SDZWajVKNncyeXZF?=
 =?utf-8?B?UURyK25wbkJFN3hFcGpReE5RcHJHTkpHL2krU3QxbmdUVDY1STlmS2c2MGlN?=
 =?utf-8?B?Tkg5dFh4eDdpWlhOa0RyZ1l0alZUeFNJRndyUlZxU0REdEVNVURRMFVPbUhE?=
 =?utf-8?B?cENncjVVNEZzUVdYSGtBYnhsSGVQd1AyVHZFYytOWWxKZSs4aEphbnBaTWoy?=
 =?utf-8?B?ODFrc0ZNUEcxOVl6S3FNZXhtVlQ3dFIyTXByc25yVTZTaDRVTkpiYjA0OUl3?=
 =?utf-8?B?cE1hY3ZzWXhHVU1jNWtoNjZUalJNV3dMQ0I2VUhiZDZ6c0ZOVGgvdWZNNUIr?=
 =?utf-8?B?Z3ZsREdyWC84U1hlVkVpTXFMV3dpSXBGMHNJeWtwSU80S2NLMUVCell3VW50?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb340d7-354a-4929-5fc7-08dbe1482332
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 17:20:14.7193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tysqm/McD4cd71d+incgaPeAhCeueM7YW/YIUFzfVJti54LP/heiXx0EJacnIRFKlbS/5fpTx8Pd4kNP31lOoCb/AebzL1V1SWiQcWR8ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6167
X-OriginatorOrg: intel.com

PkZyb206IFZhZGltIEZlZG9yZW5rbyA8dmFkaW0uZmVkb3JlbmtvQGxpbnV4LmRldj4NCj5TZW50
OiBUaHVyc2RheSwgTm92ZW1iZXIgOSwgMjAyMyAxMTo1MSBBTQ0KPg0KPk9uIDA4LzExLzIwMjMg
MTA6MzIsIEFya2FkaXVzeiBLdWJhbGV3c2tpIHdyb3RlOg0KPj4gRml4IGlzc3VlcyB3aGVuIHBl
cmZvcm1pbmcgdW5vcmRlcmVkIHVuYmluZC9iaW5kIG9mIGEga2VybmVsIG1vZHVsZXMNCj4+IHdo
aWNoIGFyZSB1c2luZyBhIGRwbGwgZGV2aWNlIHdpdGggRFBMTF9QSU5fVFlQRV9NVVggcGlucy4N
Cj4+IEN1cnJlbnRseSBvbmx5IHNlcmlhbGl6ZWQgYmluZC91bmJpbmQgb2Ygc3VjaCB1c2UgY2Fz
ZSB3b3JrcywgZml4DQo+PiB0aGUgaXNzdWVzIGFuZCBhbGxvdyBmb3IgdW5zZXJpYWxpemVkIGtl
cm5lbCBtb2R1bGUgYmluZCBvcmRlci4NCj4+DQo+PiBUaGUgaXNzdWVzIGFyZSBvYnNlcnZlZCBv
biB0aGUgaWNlIGRyaXZlciwgaS5lLiwNCj4+DQo+PiAkIGVjaG8gMDAwMDphZjowMC4wID4gL3N5
cy9idXMvcGNpL2RyaXZlcnMvaWNlL3VuYmluZA0KPj4gJCBlY2hvIDAwMDA6YWY6MDAuMSA+IC9z
eXMvYnVzL3BjaS9kcml2ZXJzL2ljZS91bmJpbmQNCj4+DQo+PiByZXN1bHRzIGluOg0KPj4NCj4+
IGljZSAwMDAwOmFmOjAwLjA6IFJlbW92ZWQgUFRQIGNsb2NrDQo+PiBCVUc6IGtlcm5lbCBOVUxM
IHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwMTANCj4+IFBGOiBz
dXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQo+PiBQRjogZXJyb3JfY29kZSgw
eDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQ0KPj4gUEdEIDAgUDREIDANCj4+IE9vcHM6IDAwMDAg
WyMxXSBQUkVFTVBUIFNNUCBQVEkNCj4+IENQVTogNyBQSUQ6IDcxODQ4IENvbW06IGJhc2ggS2R1
bXA6IGxvYWRlZCBOb3QgdGFpbnRlZCA2LjYuMC1yYzVfbmV4dC0NCj4+cXVldWVfMTl0aC1PY3Qt
MjAyMy0wMTYyNS1nMDM5ZTVkMTVlNDUxICMxDQo+PiBIYXJkd2FyZSBuYW1lOiBJbnRlbCBDb3Jw
b3JhdGlvbiBTMjYwMFNUQi9TMjYwMFNUQiwgQklPUw0KPj5TRTVDNjIwLjg2Qi4wMi4wMS4wMDA4
LjAzMTkyMDE5MTU1OSAwMy8xOS8yMDE5DQo+PiBSSVA6IDAwMTA6aWNlX2RwbGxfcmNsa19zdGF0
ZV9vbl9waW5fZ2V0KzB4MmYvMHg5MCBbaWNlXQ0KPj4gQ29kZTogNDEgNTcgNGQgODkgY2YgNDEg
NTYgNDEgNTUgNGQgODkgYzUgNDEgNTQgNTUgNDggODkgZjUgNTMgNGMgOGIgNjYNCj4+MDggNDgg
ODkgY2IgNGQgOGQgYjQgMjQgZjAgNDkgMDAgMDAgNGMgODkgZjcgZTggNzEgZWMgMWYgYzUgPDBm
PiBiNiA1YiAxMA0KPj40MSAwZiBiNiA4NCAyNCAzMCA0YiAwMCAwMCAyOSBjMyA0MSAwZiBiNiA4
NCAyNCAyOCA0Yg0KPj4gUlNQOiAwMDE4OmZmZmZjOTAyYjE3OWZiNjAgRUZMQUdTOiAwMDAxMDI0
Ng0KPj4gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAw
MDAwMDAwMDAwMDAwMDANCj4+IFJEWDogZmZmZjg4ODJjMTM5ODAwMCBSU0k6IGZmZmY4ODhjNzQz
NWNjNjAgUkRJOiBmZmZmODg4Yzc0MzVjYjkwDQo+PiBSQlA6IGZmZmY4ODhjNzQzNWNjNjAgUjA4
OiBmZmZmYzkwMmIxNzlmYmIwIFIwOTogMDAwMDAwMDAwMDAwMDAwMA0KPj4gUjEwOiBmZmZmODg4
ZWYxZmM4MDUwIFIxMTogZmZmZmZmZmZmZmY4MjcwMCBSMTI6IGZmZmY4ODhjNzQzNTgxYTANCj4+
IFIxMzogZmZmZmM5MDJiMTc5ZmJiMCBSMTQ6IGZmZmY4ODhjNzQzNWNiOTAgUjE1OiAwMDAwMDAw
MDAwMDAwMDAwDQo+PiBGUzogIDAwMDA3ZmRjN2RhZTA3NDAoMDAwMCkgR1M6ZmZmZjg4OGMxMDVj
MDAwMCgwMDAwKQ0KPmtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4+IENTOiAgMDAxMCBEUzogMDAw
MCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4+IENSMjogMDAwMDAwMDAwMDAwMDAx
MCBDUjM6IDAwMDAwMDAxMzJjMjQwMDIgQ1I0OiAwMDAwMDAwMDAwNzcwNmUwDQo+PiBEUjA6IDAw
MDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAw
MA0KPj4gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAw
MDAwMDAwMDAwMDA0MDANCj4+IFBLUlU6IDU1NTU1NTU0DQo+PiBDYWxsIFRyYWNlOg0KPj4gICA8
VEFTSz4NCj4+ICAgPyBfX2RpZSsweDIwLzB4NzANCj4+ICAgPyBwYWdlX2ZhdWx0X29vcHMrMHg3
Ni8weDE3MA0KPj4gICA/IGV4Y19wYWdlX2ZhdWx0KzB4NjUvMHgxNTANCj4+ICAgPyBhc21fZXhj
X3BhZ2VfZmF1bHQrMHgyMi8weDMwDQo+PiAgID8gaWNlX2RwbGxfcmNsa19zdGF0ZV9vbl9waW5f
Z2V0KzB4MmYvMHg5MCBbaWNlXQ0KPj4gICA/IF9fcGZ4X2ljZV9kcGxsX3JjbGtfc3RhdGVfb25f
cGluX2dldCsweDEwLzB4MTAgW2ljZV0NCj4+ICAgZHBsbF9tc2dfYWRkX3Bpbl9wYXJlbnRzKzB4
MTQyLzB4MWQwDQo+PiAgIGRwbGxfcGluX2V2ZW50X3NlbmQrMHg3ZC8weDE1MA0KPj4gICBkcGxs
X3Bpbl9vbl9waW5fdW5yZWdpc3RlcisweDNmLzB4MTAwDQo+PiAgIGljZV9kcGxsX2RlaW5pdF9w
aW5zKzB4YTEvMHgyMzAgW2ljZV0NCj4+ICAgaWNlX2RwbGxfZGVpbml0KzB4MjkvMHhlMCBbaWNl
XQ0KPj4gICBpY2VfcmVtb3ZlKzB4Y2QvMHgyMDAgW2ljZV0NCj4+ICAgcGNpX2RldmljZV9yZW1v
dmUrMHgzMy8weGEwDQo+PiAgIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweDE5My8w
eDIwMA0KPj4gICB1bmJpbmRfc3RvcmUrMHg5ZC8weGIwDQo+PiAgIGtlcm5mc19mb3Bfd3JpdGVf
aXRlcisweDEyOC8weDFjMA0KPj4gICB2ZnNfd3JpdGUrMHgyYmIvMHgzZTANCj4+ICAga3N5c193
cml0ZSsweDVmLzB4ZTANCj4+ICAgZG9fc3lzY2FsbF82NCsweDU5LzB4OTANCj4+ICAgPyBmaWxw
X2Nsb3NlKzB4MWIvMHgzMA0KPj4gICA/IGRvX2R1cDIrMHg3ZC8weGQwDQo+PiAgID8gc3lzY2Fs
bF9leGl0X3dvcmsrMHgxMDMvMHgxMzANCj4+ICAgPyBzeXNjYWxsX2V4aXRfdG9fdXNlcl9tb2Rl
KzB4MjIvMHg0MA0KPj4gICA/IGRvX3N5c2NhbGxfNjQrMHg2OS8weDkwDQo+PiAgID8gc3lzY2Fs
bF9leGl0X3dvcmsrMHgxMDMvMHgxMzANCj4+ICAgPyBzeXNjYWxsX2V4aXRfdG9fdXNlcl9tb2Rl
KzB4MjIvMHg0MA0KPj4gICA/IGRvX3N5c2NhbGxfNjQrMHg2OS8weDkwDQo+PiAgIGVudHJ5X1NZ
U0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDZlLzB4ZDgNCj4+IFJJUDogMDAzMzoweDdmZGM3ZDkz
ZWI5Nw0KPj4gQ29kZTogMGIgMDAgZjcgZDggNjQgODkgMDIgNDggYzcgYzAgZmYgZmYgZmYgZmYg
ZWIgYjcgMGYgMWYgMDAgZjMgMGYgMWUNCj5mYSA2NCA4YiAwNCAyNSAxOCAwMCAwMCAwMCA4NSBj
MCA3NSAxMCBiOCAwMSAwMCAwMCAwMCAwZiAwNSA8NDg+IDNkIDAwIGYwDQo+ZmYgZmYgNzcgNTEg
YzMgNDggODMgZWMgMjggNDggODkgNTQgMjQgMTggNDggODkgNzQgMjQNCj4+IFJTUDogMDAyYjow
MDAwN2ZmZjJhYTkxMDI4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAw
MDENCj4+IFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMGQgUkNYOiAw
MDAwN2ZkYzdkOTNlYjk3DQo+PiBSRFg6IDAwMDAwMDAwMDAwMDAwMGQgUlNJOiAwMDAwNTY0NDgx
NGVjOWIwIFJESTogMDAwMDAwMDAwMDAwMDAwMQ0KPj4gUkJQOiAwMDAwNTY0NDgxNGVjOWIwIFIw
ODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDA3ZmRjN2Q5YjE0ZTANCj4+IFIxMDogMDAwMDdm
ZGM3ZDliMTNlMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAwMDAwMDAwMDAwMDBkDQo+
PiBSMTM6IDAwMDA3ZmRjN2Q5ZmI3ODAgUjE0OiAwMDAwMDAwMDAwMDAwMDBkIFIxNTogMDAwMDdm
ZGM3ZDlmNjllMA0KPj4gICA8L1RBU0s+DQo+PiBNb2R1bGVzIGxpbmtlZCBpbjogdWlucHV0IHZm
aW9fcGNpIHZmaW9fcGNpX2NvcmUgdmZpb19pb21tdV90eXBlMSB2ZmlvDQo+PmlycWJ5cGFzcyBp
eGdiZXZmIHNuZF9zZXFfZHVtbXkgc25kX2hydGltZXIgc25kX3NlcSBzbmRfdGltZXINCj4+c25k
X3NlcV9kZXZpY2Ugc25kIHNvdW5kY29yZSBvdmVybGF5IHFydHIgcmZraWxsIHZmYXQgZmF0IHhm
cyBsaWJjcmMzMmMNCj4+cnBjcmRtYSBzdW5ycGMgcmRtYV91Y20gaWJfc3JwdCBpYl9pc2VydCBp
c2NzaV90YXJnZXRfbW9kIHRhcmdldF9jb3JlX21vZA0KPj5pYl9pc2VyIGxpYmlzY3NpIHNjc2lf
dHJhbnNwb3J0X2lzY3NpIHJkbWFfY20gaXdfY20gaWJfY20gaW50ZWxfcmFwbF9tc3INCj4+aW50
ZWxfcmFwbF9jb21tb24gaW50ZWxfdW5jb3JlX2ZyZXF1ZW5jeSBpbnRlbF91bmNvcmVfZnJlcXVl
bmN5X2NvbW1vbg0KPj5pc3N0X2lmX2NvbW1vbiBza3hfZWRhYyBuZml0IGxpYm52ZGltbSBpcG1p
X3NzaWYgeDg2X3BrZ190ZW1wX3RoZXJtYWwNCj4+aW50ZWxfcG93ZXJjbGFtcCBjb3JldGVtcCBp
cmRtYSByYXBsIGludGVsX2NzdGF0ZSBpYl91dmVyYnMgaVRDT193ZHQNCj4+aVRDT192ZW5kb3Jf
c3VwcG9ydCBhY3BpX2lwbWkgaW50ZWxfdW5jb3JlIG1laV9tZSBpcG1pX3NpIHBjc3BrciBpMmNf
aTgwMQ0KPj5pYl9jb3JlIG1laSBpcG1pX2RldmludGYgaW50ZWxfcGNoX3RoZXJtYWwgaW9hdGRt
YSBpMmNfc21idXMNCj4+aXBtaV9tc2doYW5kbGVyIGxwY19pY2ggam95ZGV2IGFjcGlfcG93ZXJf
bWV0ZXIgYWNwaV9wYWQgZXh0NCBtYmNhY2hlIGpiZDINCj4+c2RfbW9kIHQxMF9waSBzZyBhc3Qg
aTJjX2FsZ29fYml0IGRybV9zaG1lbV9oZWxwZXIgZHJtX2ttc19oZWxwZXIgaWNlDQo+PmNyY3Qx
MGRpZl9wY2xtdWwgaXhnYmUgY3JjMzJfcGNsbXVsIGRybSBjcmMzMmNfaW50ZWwgYWhjaSBpNDBl
IGxpYmFoY2kNCj4+Z2hhc2hfY2xtdWxuaV9pbnRlbCBsaWJhdGEgbWRpbyBkY2EgZ25zcyB3bWkg
ZnVzZSBbbGFzdCB1bmxvYWRlZDogaWF2Zl0NCj4+IENSMjogMDAwMDAwMDAwMDAwMDAxMA0KPj4N
Cj4+IEFya2FkaXVzeiBLdWJhbGV3c2tpICgzKToNCj4+ICAgIGRwbGw6IGZpeCBwaW4gZHVtcCBj
cmFzaCBhZnRlciBtb2R1bGUgdW5iaW5kDQo+PiAgICBkcGxsOiBmaXggcGluIGR1bXAgY3Jhc2gg
Zm9yIHJlYm91bmQgbW9kdWxlDQo+PiAgICBkcGxsOiBmaXggcmVnaXN0ZXIgcGluIHdpdGggdW5y
ZWdpc3RlcmVkIHBhcmVudCBwaW4NCj4+DQo+PiAgIGRyaXZlcnMvZHBsbC9kcGxsX2NvcmUuYyAg
ICB8ICA4ICsrLS0tLS0tDQo+PiAgIGRyaXZlcnMvZHBsbC9kcGxsX2NvcmUuaCAgICB8ICA0ICsr
LS0NCj4+ICAgZHJpdmVycy9kcGxsL2RwbGxfbmV0bGluay5jIHwgMzcgKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlv
bnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPj4NCj4NCj4NCj5JIHN0aWxsIGRvbid0IGdldCBob3cg
Y2FuIHdlIGVuZCB1cCB3aXRoIHVucmVnaXN0ZXJlZCBwaW4uIEFuZCBzaG91bGRuJ3QNCj5kcml2
ZXJzIGRvIHVucmVnaXN0ZXIgb2YgZHBsbC9waW4gZHVyaW5nIHJlbGVhc2UgcHJvY2VkdXJlPyBJ
IHRob3VnaHQgaXQNCj53YXMga2luZCBvZiBhZ3JlZW1lbnQgd2UgcmVhY2hlZCB3aGlsZSBkZXZl
bG9waW5nIHRoZSBzdWJzeXN0ZW0uDQo+DQoNCkl0J3MgZGVmaW5pdGVseSBub3QgYWJvdXQgZW5k
aW5nIHVwIHdpdGggdW5yZWdpc3RlcmVkIHBpbnMuDQoNClVzdWFsbHkgdGhlIGRyaXZlciBpcyBs
b2FkZWQgZm9yIFBGMCwgUEYxLCBQRjIsIFBGMyBhbmQgdW5sb2FkZWQgaW4gb3Bwb3NpdGUNCm9y
ZGVyOiBQRjMsIFBGMiwgUEYxLCBQRjAuIEFuZCB0aGlzIGlzIHdvcmtpbmcgd2l0aG91dCBhbnkg
aXNzdWVzLg0KDQpBYm92ZSBjcmFzaCBpcyBjYXVzZWQgYmVjYXVzZSBvZiB1bm9yZGVyZWQgZHJp
dmVyIHVubG9hZCwgd2hlcmUgZHBsbCBzdWJzeXN0ZW0NCnRyaWVzIHRvIG5vdGlmeSBtdXhlZCBw
aW4gd2FzIGRlbGV0ZWQsIGJ1dCBhdCB0aGF0IHRpbWUgdGhlIHBhcmVudCBpcyBhbHJlYWR5DQpn
b25lLCB0aHVzIGRhdGEgcG9pbnRzIHRvIG1lbW9yeSB3aGljaCBpcyBubyBsb25nZXIgYXZhaWxh
YmxlLCB0aHVzIGNyYXNoDQpoYXBwZW5zIHdoZW4gdHJ5aW5nIHRvIGR1bXAgcGluIHBhcmVudHMu
DQoNClRoaXMgc2VyaWVzIGZpeGVzIGFsbCBpc3N1ZXMgSSBjb3VsZCBmaW5kIGNvbm5lY3RlZCB0
byB0aGUgc2l0dWF0aW9uIHdoZXJlDQptdXhlZC1waW5zIGFyZSB0cnlpbmcgdG8gYWNjZXNzIHRo
ZWlyIHBhcmVudHMsIHdoZW4gcGFyZW50IHJlZ2lzdGVyZXIgd2FzIHJlbW92ZWQNCmluIHRoZSBt
ZWFudGltZS4NCg0KVGhhbmsgeW91IQ0KQXJrYWRpdXN6DQo=

