Return-Path: <netdev+bounces-45946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3E97E07B9
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FAF281EEA
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F920B16;
	Fri,  3 Nov 2023 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yfk9mtY0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6F1A5A5
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:45:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47281D4E;
	Fri,  3 Nov 2023 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699033517; x=1730569517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dDljHAM9OSZNG3HMmns0nHSTumeP0HEPytTINCIikv8=;
  b=Yfk9mtY0kINdtCbDzKSWb3rgfybVfj1WnODhgxz5SjCP/BQjr/1yzot0
   kByBfIsTJyQjM5je/Cgi6j7sEr+TUmnPmPOOImapPFPegsp7L10DipTU2
   mnjJtR2MyeLEIVAtGEqoF+87nKZd3fozfevV16+HHOkHLhpFy6ujmSjNm
   SVtfgQcyj8TmwT1ddtTzj0l7ycNLxj4jUoxfxpKoIwnRvGEbq0pBQJC/5
   4QSaQ8cxv5uSCQo+qMIaVPDBgZq8QQ1P2HMymxuXIrC6skedCiZTFyVe7
   08/YuLoGvYS11T1zkgXkAXoC14HKsiQMWPehBvi3ZnEjYIWr+rG+TY/bJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="10525972"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="10525972"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 10:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="765311124"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="765311124"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 10:45:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 10:45:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 10:45:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 10:45:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFw+YEMgUI+uWR4UfwRsuIaFMpohokdYmkxgXQS0NBxee538PqLo+GQ4pWubqYBYZAYwdsIgLmooHAc1bw3HHGTmImLmSLnypHTa/iYHdcUhGBYtZrVl4AziM0GdOL4KV5zTdAHMzo2Kdxxl5lNz0AWpe0QxBdQnsQ9c5hRjnB+PAXEjFto/liVQWz6hiEGkGSgabAiUQ4FH6M7dJrsoaPYVtntS46L2HB+J6t5Zy6AkG66SRBKq9aNxhwE223+HbEly6xOZkzK6k4e8/EtAZmLnLnpqLHYph3djReCOKq99xyXFnDigae172i6BaGH+p2gwti4Ei3knS+CrgzebgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDljHAM9OSZNG3HMmns0nHSTumeP0HEPytTINCIikv8=;
 b=jKdwrrFoLosRJvRvrcauQjTtsRM02mdfShcevxg5zFaKJ5E2FedAIo/1uQ3zuwQoZX7Zbn9NgKGxQK0laBHEjMe+a9LlXafT35u3Gvn5P9Upi74b2h9j41wIICIWXIDvxtQHulQ+DDPLUkxjwIGfHUMOD6s3tiN358Atrkd4Dr6uHM7015DtMhY79ZpPvem7fMXXKFKcYws4lpxoaBp4wr9zVl2GtA/uSD3AS9Z4aK+rvtw1zmcuSQE4+uSqs/mYbll7PaUMGBBJzFpKBX3rUwHunCi359VvJzzD7X7pl8hRXloqvRdo34jdXWFCgH4XhbJKWeI/BWMsEQxgEWZuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by MW4PR11MB6619.namprd11.prod.outlook.com (2603:10b6:303:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 17:45:11 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::750d:a434:bc26:3a94]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::750d:a434:bc26:3a94%7]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 17:45:09 +0000
From: "Michalik, Michal" <michal.michalik@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>, poros
	<poros@redhat.com>, "Olech, Milena" <milena.olech@intel.com>, mschmidt
	<mschmidt@redhat.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH RFC net-next v2 0/2] selftests/dpll: DPLL subsystem
 integration tests
Thread-Topic: [PATCH RFC net-next v2 0/2] selftests/dpll: DPLL subsystem
 integration tests
Thread-Index: AQHaC1Gto14I0BavZEWxQBc41YbWmbBjp8AAgAU653A=
Date: Fri, 3 Nov 2023 17:45:09 +0000
Message-ID: <CH3PR11MB841409F56A8857162B39D1AAE3A5A@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231030165326.24453-1-michal.michalik@intel.com>
 <ZUDNFHlO4GtA/UAh@nanopsycho>
In-Reply-To: <ZUDNFHlO4GtA/UAh@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|MW4PR11MB6619:EE_
x-ms-office365-filtering-correlation-id: 0b108639-bc90-42fc-d65c-08dbdc949fc2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BYTBtOXGatSzFyVi2EXMhNE7PwdK7Wk6vQtw/Cq1GOZfrlyeQ+ltgkY8GmGE1xx+lNqsaWnEM8zdvi0CLK5s5ZziVHMiX9LB0DNzgh+qXFVyk7OKZdAO2clxNHIJ60PYrPJP5kZTAkGlnQ0B5mIbOosUSq+7YbBegiaKJ7rK0b73nC/lMQ9+zbBeKH4j2EA74qvRrKtug11WYBMok5DFcgsCcZtr0almpg7818QsKFCJcqkdk+GV/yR29oZl8K1MutM5hFWlReIb0SESzL4oBzavz91FkIbGPchHThmZmGux0Tb61/Uoo+DJ9Nkl224PUoeKwA1zpOWdc8S0qVpJvArAWewHYPygrggQKRp4Mu4IGBhsfo4IdF0zyvBmHZbPcF+eASH0isFte7wnEbXv1HEuxakSVg4yeaI1USx7Mq2LOZrkBD6YuvAq5rF/J02Ayz4Uz3a7OvkJevJ4nusVb0iO+7c9bAdysopOTmXuU1UxTbd/zfC6g3VO0o5DDlbz30Il2mMdQtsQ9scpOaAGlCG74M3//kLw78F/6WfcrmuYHD8c+GCcaEtS44jxDzRE+/oS4TNFyMtN3kSfgKu0MpRKuYfqPLCsYdXE2c52MQg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(122000001)(38100700002)(316002)(6916009)(26005)(55016003)(71200400001)(83380400001)(38070700009)(86362001)(7696005)(6506007)(53546011)(33656002)(9686003)(478600001)(966005)(2906002)(7416002)(8936002)(8676002)(4326008)(82960400001)(41300700001)(52536014)(5660300002)(54906003)(66476007)(66446008)(66946007)(66556008)(64756008)(76116006)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm52QzAweW9sb3dUbmNVblJDQkwvUWVHQ09IVzYwWm9ycXc3YTFWVGhZWFBR?=
 =?utf-8?B?aGhOZTlFK2pnOW9Na2YwMzdWZzROUlJwTkdPUkxlWEZnS2VwZEc3bnIwSXNZ?=
 =?utf-8?B?cklHMVp2Z3VKOE93Nk9XT2RFRlJUNmFBM1NrdlZVWW94cXBUWXlHbEdYMURF?=
 =?utf-8?B?M3N4eGd5b1lROW1mYUtPbmE1WENOekdmcTU3N2Rud3c5N3dYMVJnOWQ5U3ZV?=
 =?utf-8?B?TlJONldxSmE0V2dNbHhwd1NLeHVMM0krd0FaYlpUNmRhNGJCclVwMjUxOGUv?=
 =?utf-8?B?K1d1WVpQYjhMcFQ3QkphN3Yrd1lQSVRCWFBQbnRIL3l3N1VzYkFXSVRCWlpD?=
 =?utf-8?B?Ykx1UndZVk56OEdNYVBsdmZrREhrWW51YmY3cmg3MlBpUGFQbnQvOU9nWUs1?=
 =?utf-8?B?WU4xU0ZDUU93enIyZi8zaHpEb3JGTHpTQjBQYTBXWHZzM3g3Nk1iYUdXR2tE?=
 =?utf-8?B?TXpIR0tBdmtzZXByaU8xM1BiUjBqQ1ZsVlFsY29IdXZORGI1SlVRNDAwc1Bl?=
 =?utf-8?B?M2xaWFYvL2w0NGtpVW5JQUVTWnltQXNScFBIbnUyaHRxclpFak4zL1FpajZX?=
 =?utf-8?B?c2hLS1lBMlV3SlJyYXNnZEZNdGNnbE53MHpCbUxiaE1saTIxUnJJam1ITHpj?=
 =?utf-8?B?VUZUalFUWXF6c0ZJTUptSGtFdTQ5QkxMVEF4VmN5bUVXWVR4MEg1Vk4yVUFo?=
 =?utf-8?B?dFJYWEc2SUJ5ZGRjanV4UGtDMmxpK3JYSlluZFYxQ1doNnVGNDVuNzFBdFpp?=
 =?utf-8?B?SU5pYmF3aTMzWVhSa08zeDF0Vmdjam5XMDdxbVh3N0wxcUlzMXV6U3hIWk4z?=
 =?utf-8?B?eTNrZmNNb0FsMk5zR0RlUDZDYjQ3TG5nQkRVajJxWEdzelZxZWdlMFFtU1BB?=
 =?utf-8?B?SHZuMjltRVJYQTREUHArYUpCT1ZCYkkzanZEdVMrb1Y2bGxBbnAxZU80UGUy?=
 =?utf-8?B?TER4TVlsRWJLTURXaDdSc2ZEZHUzaTlZd2M4QUlCaE5LNVlRRUJZVy9rWnla?=
 =?utf-8?B?SFhMbVgzdTR3c1FhOVduRmpXSXljbUpsdnlXb2JNeUI5QTQ2N2hXSmtCbTZa?=
 =?utf-8?B?b1RZeEVmLzR4K3FtYXMvM3hLOUVCTUNyaFVYdWpPcFR3RFlkZ09DRkZOMDQv?=
 =?utf-8?B?UUJ3UzBIaE9GS1VwZnhtdEJJcVdEU3NWeGl0VkU3cmlyRFBjVU9Od0hjYktD?=
 =?utf-8?B?NjgvNUp0dVBtMCtlekR1anVYc0o2WmxmcHg5SFhxOHRDbVcxRXNuc3VZTHNJ?=
 =?utf-8?B?RVk0a3JNc3NMdGNuUzZhVitYdVVqOXFyYUxjQm5nRTlVNnU0UUpJNDZ6K01u?=
 =?utf-8?B?dlhwQU9uRDFZRW9HVEpCcEVZQ0FDSVF4cDhaVU8yNDNKeXNjSHJpTjdaYjJn?=
 =?utf-8?B?SEQySUlxZ2t1UGsyTVI0aUJic0tGc1p1RXNFM0NMUEtSZUMyWDhLWXRoM0dx?=
 =?utf-8?B?SXVOSklxN0pLV1RZNVFSeEdrQkRzZG5PdEdnK3c3dXpZb3EyNXJUTSs4SkJs?=
 =?utf-8?B?NTBFckp2VjEvZFRPU0hnUkFCd0Exa283NTFSMHhFSCtyT0tzc1Ruc2JJaGRp?=
 =?utf-8?B?endmMkxoNVV0d0pFeG40Y0pVWlFUdjVYZmtIQ0hPbGFEL0dOQmRkQkRXOERu?=
 =?utf-8?B?c3F5enBqMVBqSGZkY3l3TDN4TnJEMjFac3ZVR0lzRDlyUlYrMFYvOHNKVkdn?=
 =?utf-8?B?WDgxNW1vdzhqMTBxdUxYQTNuS25vaENHQjVEeVFXcE5MMjBLQmhuRlBrQ3BB?=
 =?utf-8?B?cmNaekE4NGp0aFVvbUthcXVONGtCbWhrVVVtT3lrSlUrN2NldDV4aDRoalVk?=
 =?utf-8?B?MUNhT2VLL1RBMkRDalM0V3FkWjJVL1I4MVdzeE0rSXY0ZFFRd0dha1A0RkVt?=
 =?utf-8?B?NmtqTjJQQXpIaW9RdWorTWk0V08xcllpZ2FsUi9ycWIxY0I4UXRDd0pGUDE4?=
 =?utf-8?B?NEE5T3M3c0xNQWVvK25PR3ljMmpQN1l5bXNQMHR1SUNIWHF0OHFJTFhWK3BG?=
 =?utf-8?B?Y21SU3llS0h3dm5qUUwrL1VaNENEbTlESGJjaWx0ZUowYXVWMms2R1RWV2xz?=
 =?utf-8?B?UXdacHpISk42ekx4WGkwZVhwWW1WUy9zWHJtQThrTXFJRzgySzd0ZUVuZ1pR?=
 =?utf-8?Q?1O25qq8YXPx32WlO9M5nIRWxC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b108639-bc90-42fc-d65c-08dbdc949fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 17:45:09.6109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D6Hj9rAteZOdGUt8VPyInE7RN0kjekUzSNUccL/u/bzJVuH05r0CJHPbTK7fctOxrU+2QWA2AG9wMqeVMjhm0q4C+DyyfxycI6aUnBiH7eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6619
X-OriginatorOrg: intel.com

T24gMzEgT2N0b2JlciAyMDIzIDEwOjQ3IEFNIENFVCwgSmlyaSBQaXJrbyB3cm90ZToNCg0KSmly
aSwgbXVjaCB0aGFua3MgZm9yIHRha2luZyB0aW1lIGFuZCBkb2luZyBncmVhdCByZXZpZXcgLSBJ
IGhhdmUgbGVhcm5lZA0KYSBsb3QsIGVzcGVjaWFsbHkgaW4gcGF0Y2ggMS8yIGhhdmluZyB0aGUg
bmV0ZGV2c2ltIERQTEwgaW1wbGVtZW50YXRpb24uDQoNCkkgd2lsbCBkbyBteSBiZXN0IHRvIHBv
c3QgdGhlIFJGQyB2MyBlYXJseSBuZXh0IHdlZWsuDQoNCj4gDQo+IE1vbiwgT2N0IDMwLCAyMDIz
IGF0IDA1OjUzOjI0UE0gQ0VULCBtaWNoYWwubWljaGFsaWtAaW50ZWwuY29tIHdyb3RlOg0KPj5U
aGUgcmVjZW50bHkgbWVyZ2VkIGNvbW1vbiBEUExMIGludGVyZmFjZSBkaXNjdXNzZWQgb24gYSBu
ZXdzbGV0dGVyWzFdDQo+IA0KPiAibmV3c2xldHRlciI/IFNvdW5kcyBhIGJpdCBvZGQgdG8gbWUg
OikNCj4gDQoNClllYWgsIHlvdSBhcmUgcmlnaHQgLSB3aWxsIGZpeC4NCg0KPj5pcyBpbnRyb2R1
Y2luZyBuZXcsIGNvbXBsZXggc3Vic3lzdGVtIHdoaWNoIHJlcXVpcmVzIHByb3BlciBpbnRlZ3Jh
dGlvbg0KPj50ZXN0aW5nIC0gdGhpcyBwYXRjaCBhZGRzIGNvcmUgZm9yIHN1Y2ggZnJhbWV3b3Jr
LCBhcyB3ZWxsIGFzIHRoZQ0KPiANCj4gIlBhdGNoc2V0IiBwZXJoYXBzPyBBbHNvLCB3aGF0IGRv
IHlvdSBtZWFuIGJ5ICJjb3JlIj8gVGhlIHNlbnRlbmNlDQo+IHNvdW5kcyBhIGJpdCB3ZWlyZCB0
byBtZS4NCj4gDQoNCldpbGwgd29yayB0byBpbXByb3ZlIHRoaXMuDQoNCj4+aW5pdGlhbCB0ZXN0
IGNhc2VzLiBGcmFtZXdvcmsgZG9lcyBub3QgcmVxdWlyZSBuZWl0aGVyIGFueSBzcGVjaWFsDQo+
PmhhcmR3YXJlIG5vciBhbnkgc3BlY2lhbCBzeXN0ZW0gYXJjaGl0ZWN0dXJlLg0KPj4NCj4+VG8g
cHJvcGVybHkgdGVzdCB0aGUgRFBMTCBzdWJzeXN0ZW0gdGhpcyBwYXRjaCBhZGRzIGZha2UgRFBM
TCBkZXZpY2VzIGFuZCBpdCdzDQo+IA0KPiBGb3IgcGF0Y2ggZGVzY3RpcHRpb24sIHBsZWFzZSBz
dGF5IHdpdGhpbiA3MmNvbHMuDQo+IEFsc28sICJpdCdzIiBpcyBtb3N0IHByb2JhYmx5IHdyb25n
IGluIHRoaXMgc2VudGVuY2UuDQo+IA0KDQpJbXByb3ZlIHRoaXMgYXMgd2VsbC4NCg0KPj5waW5z
IGltcGxlbWVudGF0aW9uIHRvIG5ldGRldnNpbS4gQ3JlYXRpbmcgbmV0ZGV2c2ltIGRldmljZXMg
YW5kIGFkZGluZyBwb3J0cw0KPj50byBpdCByZWdpc3RlciBuZXcgRFBMTCBkZXZpY2VzIGFuZCBw
aW5zLiBGaXJzdCBwb3J0IG9mIGVhY2ggbmV0ZGV2c2ltIGRldmljZQ0KPiANCj4gXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4gVGhpcyBzZW50ZW5jZSBkb2VzIG5vdCBt
YWtlDQo+IHNlbnNlIHRvIG1lLiBQZWhhcHMgcmVwaHJhc2UgYSBiaXQ/DQo+IA0KPiANCj4+YWN0
cyBhcyBhIGVudGl0aXkgd2hpY2ggcmVnaXN0ZXJzIHR3byBEUExMIGRldmljZXM6IEVFQyBhbmQg
UFBTIERQTExzLiBGaXJzdA0KPiANCj4gdHlwbzogImVudGl0aXkiDQoNCk9rLg0KDQo+PnBvcnQg
YWxzbyByZWdpc3RlciB0aGUgY29tbW9uIHBpbnM6IFBQUyBhbmQgR05TUy4gQWRkaXRpb25hbGx5
IGVhY2ggcG9ydA0KPj5yZWdpc3RlciBhbHNvIFJDTEsgKHJlY292ZXJlZCBjbG9jaykgcGluIGZv
ciBpdHNlbGYuIFRoYXQgYWxsb3cgdXMgdG8gY2hlY2sNCj4+bXV0bGlwbGUgc2NlbmFyaW9zIHdo
aWNoIG1pZ2h0IGJlIHByb2JsZW1hdGljIGluIHJlYWwgaW1wbGVtZW50YXRpb25zIChsaWtlDQo+
PmRpZmZlcmVudCBvcmRlcmluZyBldGMuKQ0KPj4NCj4+UGF0Y2ggYWRkcyBmZXcgaGVscGVyIHNj
cmlwdHMsIHdoaWNoIGFyZToNCj4+MSkgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHBsbC9ydW5f
ZHBsbF90ZXN0cy5zaA0KPiANCj4gUGxlYXNlIG1ha2UgdGhpcyBwYXJ0IG9mDQo+IHRvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2RyaXZlcnMvbmV0L25ldGRldnNpbS8NCj4gTm8gc3BlY2lhbCB0aHJl
YXQgb2YgZHBsbCBuZWVkZWQuDQo+IA0KDQpUaGF0IG1ha2UgYSBsb3Qgb2Ygc2Vuc2UgdG8gbW92
ZSBpdCB0aGVyZSwgdGhhbmtzIGZvciBub3RpY2luZyB0aGF0Lg0KDQo+PiAgICBTY3JpcHQgaXMg
Y2hlY2tpbmcgZm9yIGFsbCBkZXBlbmRlbmNpZXMsIGNyZWF0ZXMgdGVtcG9yYXJ5DQo+PiAgICBl
bnZpcm9ubWVudCwgaW5zdGFsbHMgcmVxdWlyZWQgbGlicmFyaWVzIGFuZCBydW4gYWxsIHRlc3Rz
IC0gY2FuIGJlDQo+PiAgICB1c2VkIHN0YW5kYWxvbmUNCj4+MikgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvZHBsbC95bmxmYW1pbHloYW5kbGVyLnB54pWmw5YNCj4+ICAgIExpYnJhcnkgZm9yIGVh
c2llciB5bmwgdXNlIGluIHRoZSBweXRlc3QgZnJhbWV3b3JrIC0gY2FuIGJlIHVzZWQNCj4+ICAg
IHN0YW5kYWxvbmUNCj4+DQo+PlsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMTY5
NDk0ODQyNzM2LjIxNjIxLjEwNzMwODYwODU1NjQ1NjYxNjY0LmdpdC1wYXRjaHdvcmstbm90aWZ5
QGtlcm5lbC5vcmcvDQo+Pg0KPj5DaGFuZ2Vsb2c6DQo+PnYxIC0+IHYyOg0KPj4tIG1vdmVkIGZy
b20gc2VwYXJhdGUgbW9kdWxlIHRvIGltcGxlbWVudGF0aW9uIGluIG5ldGRldnNpbQ0KPj4NCj4+
TWljaGFsIE1pY2hhbGlrICgyKToNCj4+ICBuZXRkZXZzaW06IGltcGxlbWVudCBEUExMIGZvciBz
dWJzeXN0ZW0gc2VsZnRlc3RzDQo+PiAgc2VsZnRlc3RzL2RwbGw6IGFkZCBEUExMIHN5c3RlbSBp
bnRlZ3JhdGlvbiBzZWxmdGVzdHMNCj4+DQo+PiBkcml2ZXJzL25ldC9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPj4gZHJpdmVycy9uZXQvbmV0ZGV2c2ltL01h
a2VmaWxlICAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+PiBkcml2ZXJzL25ldC9uZXRkZXZz
aW0vZHBsbC5jICAgICAgICAgICAgICAgICAgICAgfCA0MzggKysrKysrKysrKysrKysrKysrKysr
KysNCj4+IGRyaXZlcnMvbmV0L25ldGRldnNpbS9kcGxsLmggICAgICAgICAgICAgICAgICAgICB8
ICA4MSArKysrKw0KPj4gZHJpdmVycy9uZXQvbmV0ZGV2c2ltL25ldGRldi5jICAgICAgICAgICAg
ICAgICAgIHwgIDIwICsrDQo+PiBkcml2ZXJzL25ldC9uZXRkZXZzaW0vbmV0ZGV2c2ltLmggICAg
ICAgICAgICAgICAgfCAgIDQgKw0KPj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvTWFrZWZpbGUg
ICAgICAgICAgICAgICAgIHwgICAxICsNCj4+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RwbGwv
TWFrZWZpbGUgICAgICAgICAgICB8ICAgOCArDQo+PiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9k
cGxsL19faW5pdF9fLnB5ICAgICAgICAgfCAgIDANCj4+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2RwbGwvY29uZmlnICAgICAgICAgICAgICB8ICAgMiArDQo+PiB0b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9kcGxsL2NvbnN0cy5weSAgICAgICAgICAgfCAgMzQgKysNCj4+IHRvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2RwbGwvZHBsbF91dGlscy5weSAgICAgICB8IDEwOSArKysrKysNCj4+IHRvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2RwbGwvcmVxdWlyZW1lbnRzLnR4dCAgICB8ICAgMyArDQo+PiB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kcGxsL3J1bl9kcGxsX3Rlc3RzLnNoICAgfCAgNzUgKysr
Kw0KPj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHBsbC90ZXN0X2RwbGwucHkgICAgICAgIHwg
NDE0ICsrKysrKysrKysrKysrKysrKysrKw0KPj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHBs
bC95bmxmYW1pbHloYW5kbGVyLnB5IHwgIDQ5ICsrKw0KPj4gMTYgZmlsZXMgY2hhbmdlZCwgMTI0
MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9uZXQvbmV0ZGV2c2ltL2RwbGwuYw0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
bmV0L25ldGRldnNpbS9kcGxsLmgNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9kcGxsL01ha2VmaWxlDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvZHBsbC9fX2luaXRfXy5weQ0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RwbGwvY29uZmlnDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQg
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHBsbC9jb25zdHMucHkNCj4+IGNyZWF0ZSBtb2RlIDEw
MDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kcGxsL2RwbGxfdXRpbHMucHkNCj4+IGNyZWF0
ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kcGxsL3JlcXVpcmVtZW50cy50
eHQNCj4+IGNyZWF0ZSBtb2RlIDEwMDc1NSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kcGxsL3J1
bl9kcGxsX3Rlc3RzLnNoDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvZHBsbC90ZXN0X2RwbGwucHkNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9kcGxsL3lubGZhbWlseWhhbmRsZXIucHkNCj4+DQo+Pi0tIA0KPj4yLjku
NQ0KPj4NCj4+YmFzZS1jb21taXQ6IDU1YzkwMDQ3N2Y1YjM4OTdkOTAzODQ0NmY3MmEyODFjYWUw
ZWZkODYNCg==

