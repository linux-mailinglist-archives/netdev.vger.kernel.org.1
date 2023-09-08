Return-Path: <netdev+bounces-32572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095FA798756
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 14:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC1E281A9A
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E24538A;
	Fri,  8 Sep 2023 12:47:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200733F1
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 12:47:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BC41FFC
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 05:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694177239; x=1725713239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t2LvEexvrvBKNFTpMAwxuvo7yHQ52oMWjQPZnmquw24=;
  b=kendWpDvPN+s+JzvCrZHsfQ/Dnso/tHZ0NhU+gO5+RnjgJf/zL/KV3zC
   CXOc/U3odgNos3unYXUyURck2CoMuJWfWoNR5Vnx2jnCzo3inSQpaF6NJ
   yHYFdIIL/ymcoWa7Qs9mYV+U9Cs2j8LISK4BD1uYtaMdHRwUygZOUk/LG
   g0Qr4zbONRP12OXB9gq7ZbQaelZj+QFGeIRsbVbyXHFwmREMg8vR8rIz0
   PMJ/IPIwnke+6K/jgXMXlwDYBPEnGBWV+voTGrUAin+z8VDBrzsvqR6zV
   zN9kzLDTBQnTz5+Kwatg5bwlY4/qjzQrzM5zozCPtMc33z/6RhvrQW6mo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="376545284"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="376545284"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 05:47:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="808009131"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="808009131"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 05:47:19 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 05:47:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 05:47:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 05:47:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+AqmPEtyt5gZy4tX1e9+5kUUxPWgqTP7T/hG/it/67rj0+LaFTToytq/74w7pWPgnfqaz/EIUHUz05IGp+aJe/c6M99Ma/fDxflBjWopVmx/R4JV9G4krc7BFVAWNBYbwLrPprDXgVAeMr/rg4uTkuank9jLqcmQbpl1wjjOMlyrbu9NS3JZ2vEgxOZ6AOHfoe+yMb1nuMT4/zMZwz8somghH8rueXb6vYPfDkqUAhqz+CCQBQTX+btHNHKIHJfkwGnz4rWSGflWA7KvPr9JP3lcZd7/NcDumhNfr/F2FY4qoR3ebGBT+zEJt30Ce3aAbGX1kD+kZGrWQRYGjUaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2LvEexvrvBKNFTpMAwxuvo7yHQ52oMWjQPZnmquw24=;
 b=bLCXfl3VfsiRHnIVW0FSNrwL+JffVaBIDEfS/tcxlyJW7CkEiEnh+lzdcULurh9HDhwn4dJ3VZ9Dc5qaHVvrkH7XuDUa9wM8fOo0qaOVN69SKAWAwyXSa0jaKxNzlnU9ofeYlF71n9XxQdbFiM4OQrhUymdB3Ji0orcLWNm2YkPzi1IbV24rJNYX6mvL+M4nIbW4lpJ8f24UC3K7AzEt13FBn3VuGTCcwTB5YzJJPxRRLZioUVXka4jjQezVeSODunJpWhioo//17a1KOLHtA7ylBbu/QMOtY/iOfzL6f11BHINn5WirbdBvakTSNZoJ19PeEaszCdl08xO1DsK9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by CO1PR11MB4962.namprd11.prod.outlook.com (2603:10b6:303:99::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 12:47:14 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc%7]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 12:47:14 +0000
From: "Staikov, Andrii" <andrii.staikov@intel.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Pucha,
 HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
Subject: RE: [PATCH net 1/2] i40e: fix potential memory leaks in i40e_remove()
Thread-Topic: [PATCH net 1/2] i40e: fix potential memory leaks in
 i40e_remove()
Thread-Index: AQHZ4CSc4uADnkw6k0qbIKPTTVA9CrAMjYKAgARWx2A=
Date: Fri, 8 Sep 2023 12:47:14 +0000
Message-ID: <PH0PR11MB5611C4619889C5C45628CBF185EDA@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230905180521.887861-1-anthony.l.nguyen@intel.com>
 <20230905180521.887861-2-anthony.l.nguyen@intel.com>
 <6372d2fd-e998-4664-848d-539d592a516c@amd.com>
In-Reply-To: <6372d2fd-e998-4664-848d-539d592a516c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|CO1PR11MB4962:EE_
x-ms-office365-filtering-correlation-id: b8bd823e-a915-458e-ffba-08dbb069ba1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: as84r9Q1T1Gf77J+5AtYOL53AsocJoKbRLCRIDzA0Xy7HJl03/NYu+/OdTLZHB/QVSqsU7ewYBk5aaeI+4CXndlsSQMT7FAGwy7Vzpxd5Fp/ADpClD3kAfWhALDEpr4/LtiL7SB2I+OT1u7uR9vKuAu2cet5zYqXfmcv21rNFPfHLIloslzRlyvwkCMQt/aKRgAf0ss1+ZPSm5FRwqpucpptX0QY4acHMAjrg+H1j+4Z8TF9+LTEX3mnapxfYcDYn4JlsPtUQ2eG4+bSd9ldU3XuD2N6CvksHukg57GluWqgYVTpOysmb1fsJWzyTRpdI1ijcy2E5JxV0VNVdFkYT/tmnxZT4M7mIiAPt0n3s+DqE4CQ6eg9Mj9BaEn+3wBKXMwdrB9RgFB6J3JXAsgxs8J05Q5g6Lp7V80DchsUdYevHpALclYU9ynyEE3hYBIXscqk2cJCBFeoO9sMZAuMWJ8dx+K5/+jCsbyiPzRFYUstSzlbofiQFgpdp4jDcuq+QRyHrdF2F2lY3WYBNYXR2tCZmbcEC00Stb/kiwLWpjlexW1GXXJyEVt18ia+dwbmpE8NOY4dmkNuAa+GgR0WmeD94ZMT9ldXktGHKzvi8Qi+bV9JJR3TrGJs/EAB7g01
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199024)(186009)(1800799009)(7696005)(6506007)(71200400001)(9686003)(26005)(4744005)(2906002)(54906003)(66946007)(66556008)(64756008)(66446008)(316002)(66476007)(76116006)(5660300002)(110136005)(8936002)(4326008)(52536014)(41300700001)(107886003)(8676002)(478600001)(33656002)(86362001)(38100700002)(55016003)(38070700005)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmNzUU40MjIrNFV3MlpWaDBuK1Z2NG8vNkIvejZOL1JkaXo0ZmRZUkUwellz?=
 =?utf-8?B?ZVJVNGtqQXlHSXFXb01TNm51cnJpVkxTTXZKR3RLQW44YmZlV0xmOUliZW9y?=
 =?utf-8?B?WTdITWh6R29aNEV4N2JNNU1KNmdXNW1ydXgwSXd0MVBaZjFtT0d4dXQvRkFx?=
 =?utf-8?B?SHdKQkZ4M0NHaE8rLzhNblF4a3k4Q04vMUJPUTZJdWloNGhRd3pqUmhOcXNm?=
 =?utf-8?B?WlhBcHZCS2h6RXZFczVvamp0UDU0cWhZUEc0WjhzRzI3VVgvUWVvUDdoNk5n?=
 =?utf-8?B?ZzhSVHFjNVZlTDl6ZXMzNk1Pb21mZTBjQUJlSnhubjdQd0JWSE9TMjN4Qm1N?=
 =?utf-8?B?NUd3bHZoZjlLaS9YUSttZHJ3TkFuMVhlUm5IdEhCWkE2N3g3MDlUUW93QmRu?=
 =?utf-8?B?K2lKMWJPM0ZZdmV3YXBKWjZZV0RoV2h1V3E5ellHNHhuTktpRzdKVFRqdlhU?=
 =?utf-8?B?MitSWmpQNmZqTkREOXNBV1pXOS9iUmFxN2lOenNveWl5Y1pRU2tnRmV4NGsw?=
 =?utf-8?B?VFRRT3hTOS9XWVV1V3M0UjlIL2ZEeFdrM05nbDZ3TU9zaStMQ2c1VXRCNGhG?=
 =?utf-8?B?czZHclBodjVOQU1vQ0pWV093WmEyNHROcHdUb3lWdFJZdlpWb1NMVHJjNWVu?=
 =?utf-8?B?ZWZyVWhEOHZsU2Z1M1ArN1d3ZXgxczAxVjAzRys5SmNCcXVTTFVTUDRPTmFO?=
 =?utf-8?B?RjU1Wk9vK0lTNGVZY1NhTFlVemFvM0xWOEJtdlBUbkp4cm5HNVVNMjIwdGc2?=
 =?utf-8?B?bjNzcjNxd1BYUU9oTVpaUi91VkpnYWFlNk9qZVM5RGIvVkJpYi9pVWZONFRP?=
 =?utf-8?B?c0lYRzB5V2s3aVBzQ0VZNkRZQXNrQTM5dTZ0bXFlYVpxbHhWbDdNcktjS0RR?=
 =?utf-8?B?bzZiNjhlRERMcCtZR0hKdTFScXdNUDhmd0kzd3BORDk5MzlLVkw1bjl6MGFI?=
 =?utf-8?B?blk1K0dpNUlLRXVoNHAwVEpTM0ZZZ0d1V3hsYWQ2WWpHbUZOaW5oLy9MY2dZ?=
 =?utf-8?B?c2RBdWZHdTZLZlpPZUNQNjkybVpNU0NlZzlvOWJyZEVRa25iZHZGVENkWEpk?=
 =?utf-8?B?SzFKR2o4eFJZZkhSTVNralNnM25nYjJSMVlacXUrdlNxZHlJSEFtNG9sN3h0?=
 =?utf-8?B?SmpXNk82NkpOVjVGWnJwQVhaTDJ0QkZxUnRycUlvazhQV3Myb1hqcklyRklW?=
 =?utf-8?B?MDF2SndwRkh5ekM4T0xnZmxCNEkzYjNGYWdMY3lOZ29BaUJBUlExOVVlM1Vn?=
 =?utf-8?B?VmtrVlN2RmVxRmtaQ0JxSGpPR3FhTmdnWHpVT2w3ZGxzTmpFckttYnAzWTE5?=
 =?utf-8?B?LzlLV3FWWml4bDJUVXJKYllhRmlWNGdteDJvckpIVjEwUUZNdWZGYmRsaHdP?=
 =?utf-8?B?bUhsSTlERkpXTHg2NHNKdDlUbDFObzFQTHRTZDBKUmJ2V2NGakhmK0lNK0Rl?=
 =?utf-8?B?MUFlbzVFK1RsK2hQeDdpM3NNMHZRN1dubVRrckRRNGE2MHZjZ2U2U054SDFn?=
 =?utf-8?B?RXZ1SWxNcXRmMW9QUUszVjRzL2lGSTdqaUlsT3ltY3ovczRDOHhQUEVOUjZl?=
 =?utf-8?B?cXhrUEZRTTQzOGt4elIvc2NTM3ZtejhnZ1VLWTMwVUxVTUVzV3diUFBvK1FL?=
 =?utf-8?B?TmFUNHVFZXFqUkRpTVFzenEvR0pyTUlTYmZYV29yMmFsWHRWMFh4R0ZqcU90?=
 =?utf-8?B?QUF2enJSSmdUOUY2enZWSlZobi8vMUU0ZzVJWEpuaHE5UFZkMkk1NTdoTGNT?=
 =?utf-8?B?N1I5V3BUM2lZSHZFcjlNeHZSRU9JRXg1cHlKazFxTitldlFHYkF6QnFIbEha?=
 =?utf-8?B?dS9EdEw2MHpXdHVrOS9yd1d0dTdzNXhxcVMyK3FrMURpc1h4YTJRd0hObVhQ?=
 =?utf-8?B?NHVJR3Fqd25PRVlEQkRqOHJlcWEraXFIWDk0YnJ6SVV1OTVMajhYYW84QnVr?=
 =?utf-8?B?dG5Sb21QOU8rYnFzNnpueVFQYTk1cml2a0t5VnAwQnoraGlCN2R5RC9pL1Rm?=
 =?utf-8?B?SXJiN2JMV3Q2QkFIejVDSkRmS3dhYy9TMVNmWmlMaUJTclB6TWZ4S3NWTEtX?=
 =?utf-8?B?SVlaRHlkdWVOT0pXSG1mcmg4d01xMm9wMHdYTTVWOGdTUGlwTExYb3NHYnJB?=
 =?utf-8?Q?AL2Ej6UBZh85p/TVmBKMz+X6E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bd823e-a915-458e-ffba-08dbb069ba1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 12:47:14.3347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OIPg7D72DVohNBEEoJ2T9CTZNuvxsnmuDHtLPm50qT81GXoP4niW4f4UfXj8QO5zAvSaRI9DSYOhfyQkB25jQ8piIeu9E5T4iA4TQjVRLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4962
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiBMb29waW5nIG92ZXIgYWxsIHRoZSBWU0lzIG1ha2VzIHNvbWUgc2Vuc2Ugbm93IHRoYXQgdGhl
cmUgYXJlIG11bHRpcGxlIFZTSXMgYmVpbmcgdXNlZCBieSB0aGUgUEYsIGJ1dCB3aHkgYWxsIHRo
ZSBleHRyYSBjYWxscz8gIEl0IHNlZW1zIHRvIG1lIHRoYXQgaTQwZV92c2lfcmVsZWFzZSgpIGFs
cmVhZHkgdGFrZXMgY2FyZSBvZiBhbGwgdGhpcyBleGNlcHQgZm9yIHRoZSAicGYtPnZzaVtpXSA9
IE5VTEwiLiANCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLiBXZSBoYXZlIGRv
dWJsZS1jaGVja2VkIHRoZSByZXF1aXJlZCBjYWxsczogaTQwZV92c2lfZnJlZV9xX3ZlY3RvcnMo
KSBhbmQga2ZyZWUoKSBhcmUgbm90IG5lZWRlZCBoZXJlLg0KDQpSZWdhcmRzLA0KU3RhaWtvdiBB
bmRyaWkNCg==

