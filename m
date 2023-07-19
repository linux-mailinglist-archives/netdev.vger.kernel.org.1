Return-Path: <netdev+bounces-19239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C28075A058
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC12728160A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6B1FB35;
	Wed, 19 Jul 2023 21:09:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAA91FB25
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:09:00 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A41BF0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689800938; x=1721336938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vD46bRG+GyBRgDMVWmgVu1qofVjVDGSHHEqrffV77Ec=;
  b=PV3ybElOfTXLUE/JAQhutBYoVS+1xhamFq4KQv9H4/GwVQ7kqqNLjL4P
   V7yArU01d2uDkKaHhPRiaEBwKjM6yznTDHYMw6CQTepw/yU2JNPNNHdnj
   Zd4UvuXc/uXctHfejBzuMrqLGs/2RjReC3ooMv7yzMMAA9lppbe7wgLjj
   oT174Le9+KcnNCa5M39ntiYayGKdm9g5xAyjnlSCEzMMs8B9bQdMmOckS
   aGRyr6ntgaY7mQ9/nQJXmK2coMh0SjnkQSbWKiX1LLVpa3cIYijAUGvgn
   QSWlQZPuj2g/OUZ5nFUepfbN4oGrL11eDQoTIeiG7i6X9akNHirUiSbSF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397434787"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="397434787"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 14:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="759313948"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="759313948"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2023 14:08:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 14:08:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 14:08:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 14:08:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 14:08:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYJjfmdQYnkhXZYHFxAXo1al1JATY17zGvn61/o/wN5Rko+OBvnzga27awXrEuq45yfI5zViZgWxj+hzylrVgpFtrTtkVCi+3d168Cuo/0bOHXhj5UYkRNZkpDkBJM8AT8ZSBuziAk+PgFAuGl2vMcWEy6jKqUnQ3vWuG6zXOLMTITNt8sCcC66BJNB8EWA6XERDYQRRkZmEAV+CAUkd/7yevwyrQydabO7F6mCtM4XkUcGcLONU/9KXqTSxFgvvi+V3mj+gJU/ulST5BvEWeOLRd8+2yoxgI3JWbQz+Q6KbILyhBOT4IGvEqQ98MCVmRz1+Nzo5gVGH51T9tCeM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD46bRG+GyBRgDMVWmgVu1qofVjVDGSHHEqrffV77Ec=;
 b=hYctBT/eb9O2AWBSATyH1Z9S9A7lf5RhxKQBF99GSsVS4weVSbnBIlLsEvbZkNAoWEp9M8iS1AVaW61mtpZSGf4c4o7u4c+QQUFIixisFN17IeFqRmHaUk1lAkleOGXSbzu6IkSX0tbjYzGN9DnL02NVFFv+2Nzw1/aV1icY5tbJ5BlFnJFigyaBpYAq4xSWTzEchM1dEVsLDbEalE/sFybVvJvMCiS5NqLSiIzpIxgbFDQ3kHM/C02p+YkjPMfE6Xjr6D/gVTWsyKaSUTmRZuiCtMHthS1759qwzzKjzBuRMzJ/NBtHUA/FEk5y2JiS7fOMfOc7QgCrozklBkBveA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 21:08:52 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 21:08:52 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Donald Hunter <donald.hunter@gmail.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>
Subject: RE: [PATCH net-next v3 2/2] tools: ynl-gen: fix parse multi-attr enum
 attribute
Thread-Topic: [PATCH net-next v3 2/2] tools: ynl-gen: fix parse multi-attr
 enum attribute
Thread-Index: AQHZuZRc1E9x7V2otkOnab77FbmQka/A8iKAgABrYTA=
Date: Wed, 19 Jul 2023 21:08:52 +0000
Message-ID: <DM6PR11MB46571931C999A13CA20A9C629B39A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230718162225.231775-1-arkadiusz.kubalewski@intel.com>
 <20230718162225.231775-3-arkadiusz.kubalewski@intel.com>
 <CAD4GDZzJkBrrwDXwXe0XLrP6swP_T6wYOfLhTcYvX_oRfMy7Mg@mail.gmail.com>
In-Reply-To: <CAD4GDZzJkBrrwDXwXe0XLrP6swP_T6wYOfLhTcYvX_oRfMy7Mg@mail.gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|IA1PR11MB6324:EE_
x-ms-office365-filtering-correlation-id: 5fccdf79-2dc4-4677-db86-08db889c5ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJbJXmYPg8W9BJ1xc77jecBrHx+0NMzGDu5VzgYdebXNR9A4AZkLK72M5VVXE60wKowwYXo8WmXL7a3E5mjthYHz2QJSS+bc8AUj6WoNDVgoLGPAKb2GwJcLOR75pMWoeDzKfhvSFguZhmcj7/8ZtjcVfb9iiacZdWlV+0hqANqwZEyOlhGYLq24KYMaHYzo7ktTbr85rk8ZOtrVAWWEPWfPDXebhZ/lzPTvJCgRB2gc3pzfHn2Q/NYm4eANWpXgokFuIKAds1OYG9b5CAqHeK/jo5gotIyBEGEUu3gbTFVnVpXLj88dKBJwoVRtHTNLQiPIHG5EUclAy2D/V4cnL0S4se1ma9Uwm+KGsvag23AVhoL2VgUTxB4rVaTtmPkLz/R99AsYMa3f0q9Qsaq7AJUQDOScUWHbPIzwkIEvQrIDJoVZNbaLPmIEgMHhsamGMk9cL8Wcv0m+JD5YLQVd579A5oLgf/QUckn+q6cL7jlYcTBTeUB5/W4dxUaBzwpD6RrMF8mFM4Bc2aZsQWCTGlyY6LGlZdBIpSVvOKzS9rmjNtjGtr7WyxWy2mzHC9fbNVCbSH/OQmdNFZGNH5C/Z+KzvfSLlk7THfka0YKSoxYf5T7S7SZJsCl1kPstq4Il
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(7696005)(9686003)(33656002)(26005)(6506007)(186003)(71200400001)(83380400001)(55016003)(66446008)(76116006)(66946007)(64756008)(82960400001)(6916009)(4326008)(316002)(2906002)(86362001)(8936002)(8676002)(38070700005)(52536014)(5660300002)(41300700001)(66476007)(66556008)(478600001)(122000001)(38100700002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjY0Z1Jsb1YrQnhCcjQ5YXR1UnRseVJPYWVVVExwSHQ0SVBFd0VKaStSbVZk?=
 =?utf-8?B?aGViS0VteWtJeEtka2FFOFMxWENZTkNuRXdDSnpNelBFQVVmaE5SYUwxNGFS?=
 =?utf-8?B?K3JmY2VuWlF6U1ZlMXVrKzNFWEVyRFQ3T2cydS9VNnR3YlRNWjVqTEdCQkg2?=
 =?utf-8?B?Zy8xTzhYNVlzOXhTSS9KL2JkM0dwOTdRcmlqT0F6NS9pNGhtUlo0YkR3RGc5?=
 =?utf-8?B?MHF1N2RWRitYTXRaOFU2VTJ5MGcxZ3l3SVlWdFo2eGplSEh3VDA1eTJqQkpY?=
 =?utf-8?B?N1NSQjVKQUJmNVVHZ0g4dnF4NFUzNUEza1ZyMGl0ZTNZSStBUHpSUFRCVHN5?=
 =?utf-8?B?em03dGtiTXpoUm4yZlVKMHhNMkMvdUtFTnhmV0tqaThNeW9pMTE0ZnhlTjM3?=
 =?utf-8?B?Z2tnWVduZC9KL0ZnYUpvYU5PKzdRdWtxSzZpWWtNRFh3RUIxY0ZQblJ1UXV6?=
 =?utf-8?B?S2NBZENOMlFRRXI3TVROTjdkemhIUmJkQWwvSjdZWGZwQnRiVDk4S0JTREgr?=
 =?utf-8?B?dyt4NkpLMmsrZHdZa1Z1SEhNQ01QVXdVc3NNWmxoKzBrVWhCYzVHQWZIdU9s?=
 =?utf-8?B?SUxzSjR4TFp5dHVLQzlCb1pQNnlqWDh6bi9NTFIwaitqVG9nN3NyRWJIcDkr?=
 =?utf-8?B?OWk2YjZsTDhCanNpWlhVSDJjRmNSdjJNNWpITU41U3FRSDJqQit3QjRpcUFm?=
 =?utf-8?B?RjBjYkxyRjVld25rZ1Y2cmppMlRrbmFENGVhS3ljNVBjMDRTWGdmMGxkeGNG?=
 =?utf-8?B?UUlaTHlqV2s3R3VXK0VUZndMcEQ1d2F3SS91WXJXQUZFaUdjeWdWZ01jeXpQ?=
 =?utf-8?B?RFM2Zm5XdnFwZWl3OHZqOHhQdWlSbHR2bWsvcHFuNWFkZmc5OFYxbUhDS09R?=
 =?utf-8?B?c2kxUmpiNVhLVi85SGpCcU01UnI0Vk4wZy9zV0hPZE5UWWNaK3JlcklPTVFw?=
 =?utf-8?B?MWZMcHVucTdpQ2w4UVY2aVVHc1hmSFVCWlE3MlZ2LzkvbGhNTzV4U2lsTFJi?=
 =?utf-8?B?SnhKNDNNK1dKcEowNVFKRHppOW9CaU8xU3lDekhmd0toRVdMUnJvU3FJeWZw?=
 =?utf-8?B?eDhBSUFPTHpsNURhYlFPOHNiallhOFR4YXJ0L1g2ODUrQ05kWTZpa1d1Uzl1?=
 =?utf-8?B?NXV6azA4WTluSlJtNnV6QTVERGNIZWVCRS9lbWtuRzJST3Y3c3pxTTMxUHl4?=
 =?utf-8?B?OXFpNHEzOTc1dXo0SHVHQWZUSkw3NDh4QnB5aVVFWFg2V3hvdEhCWU55VU1r?=
 =?utf-8?B?bno3eUdBYzkwd0pNanBJbk1lVC9vM0tQTFhFeVVzeERyNVVLRnArUUV6OWJ6?=
 =?utf-8?B?TXowT2JNMTBES3dWaEttNnc5Unh1bkZ5ODhjMkJBMVhVdlZoRVRXWDdFa1Ju?=
 =?utf-8?B?L2w3Q0dLek8rRUJXNjNOSXZXS0VueXlYSzlUcWdIMWdTZ0xIVW9sS2ZWdjEr?=
 =?utf-8?B?dXJ4S2l4SFE1bUFNR0FxR1IrMVdyYW43WENsZGJaOGtPK0p5SGpFVlNvWXhw?=
 =?utf-8?B?dUxhMEpXSEh0NW03ekVsZHRNcnRpeVByNC9tZ0xVdXRTa08rK0pUelJlUnZ1?=
 =?utf-8?B?d3BIbFN3N2g3OHViSzZ1YmFVWWtsQlM4UTFZUmI5T0l1bExCOVdlT0hxZml6?=
 =?utf-8?B?Vyt6elRrRmh5QXhLNWZ1czliUnVKanZvQ1BCK0pXbTNRVWczdlF2QWxPZW9I?=
 =?utf-8?B?eUZpVG9ieFJncDVlLzhQdDh3VWZVcEhxL0hra2pBS0ZuNlRkMVZYai9SaDZu?=
 =?utf-8?B?NXVOVitQdFJ0UncxdStmU2dlaDdaaWRBMUlDb1JmMG1CWXprWTVOZlhUMjNF?=
 =?utf-8?B?RzFMK2Z6ZTRKUkRxTHo3Uzh6dFlKU1JiMHFNdmpsTHBMUVlOTytUNndEZ0xP?=
 =?utf-8?B?UWJqd1Q0dW5ZOGQvalFIZExSOW53M2JwakJhenRqNCs2TkVsR0hIcVB2WXM4?=
 =?utf-8?B?Z2Y5TjYxbEFnOHpsekd2bmhPS0tmZmU0ekprSWpZa29nRVowb3JFU2dBM1ov?=
 =?utf-8?B?aDJEbkFwZzNweVYxcG1ySmRrcTBSQWVZV1Nwa2FUWVprMVBVV0hmYkVMNHBC?=
 =?utf-8?B?Vk9sRWJrdjg3TGlDdm5WUTNWTjlMRHIyT3Nad1BQbkNJUUJCclFMN2FDZG9F?=
 =?utf-8?B?RUZGTkNJak94VUtuVSt6R3ZJWGsvaStxMDNTRU90Q2N4NGlhZ1B3ZXU1a0NB?=
 =?utf-8?B?U2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fccdf79-2dc4-4677-db86-08db889c5ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 21:08:52.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfGq5UigDVg1zqwuXSCFZfzqSa92bHOWfKhwFV+CMxqQyD5B/Y+ZSEFg9JiBfDP6jR3DKgClLvO2x3zNCoZjbxX1nfy3tx7yOPyBNin+tvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PkZyb206IERvbmFsZCBIdW50ZXIgPGRvbmFsZC5odW50ZXJAZ21haWwuY29tPg0KPlNlbnQ6IFdl
ZG5lc2RheSwgSnVseSAxOSwgMjAyMyAxOjE4IFBNDQo+DQo+T24gVHVlLCAxOCBKdWwgMjAyMyBh
dCAxNzoyNCwgQXJrYWRpdXN6IEt1YmFsZXdza2kNCj48YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50
ZWwuY29tPiB3cm90ZToNCj4+DQo+PiAgdG9vbHMvbmV0L3lubC9saWIveW5sLnB5IHwgMjAgKysr
KysrKysrKy0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL25ldC95bmwvbGliL3lu
bC5weSBiL3Rvb2xzL25ldC95bmwvbGliL3lubC5weQ0KPj4gaW5kZXggNWRiN2Q0NzA2N2Y5Li42
NzFlZjRiNWVhYTYgMTAwNjQ0DQo+PiAtLS0gYS90b29scy9uZXQveW5sL2xpYi95bmwucHkNCj4+
ICsrKyBiL3Rvb2xzL25ldC95bmwvbGliL3lubC5weQ0KPj4gQEAgLTEzNSw3ICsxMzUsNyBAQCBj
bGFzcyBObEF0dHI6DQo+PiAgICAgICAgICBmb3JtYXQgPSBzZWxmLmdldF9mb3JtYXQodHlwZSkN
Cj4+ICAgICAgICAgIHJldHVybiBbIHhbMF0gZm9yIHggaW4gZm9ybWF0Lml0ZXJfdW5wYWNrKHNl
bGYucmF3KSBdDQo+Pg0KPj4gLSAgICBkZWYgYXNfc3RydWN0KHNlbGYsIG1lbWJlcnMpOg0KPj4g
KyAgICBkZWYgYXNfc3RydWN0KHNlbGYsIG1lbWJlcnMsIGF0dHJfc3BlYyk6DQo+DQo+Tm8gbmVl
ZCB0byBwYXNzIGF0dHJfc3BlYyAtIGl0J3MgdGhlIHNwZWMgZm9yIHRoZSBzdHJ1Y3QsIG5vdCBm
b3IgdGhlDQo+bWVtYmVycy4NCg0KWWVwLCB0aGF0IHdoYXQgSSB3YXMgdGhpbmtpbmcgaW4gcHJl
dmlvdXMgdmVyc2lvbiB0aHJlYWQuDQoNCj4NCj4+ICAgICAgICAgIHZhbHVlID0gZGljdCgpDQo+
PiAgICAgICAgICBvZmZzZXQgPSAwDQo+PiAgICAgICAgICBmb3IgbSBpbiBtZW1iZXJzOg0KPj4g
QEAgLTE0Nyw2ICsxNDcsOSBAQCBjbGFzcyBObEF0dHI6DQo+PiAgICAgICAgICAgICAgICAgIGZv
cm1hdCA9IHNlbGYuZ2V0X2Zvcm1hdChtLnR5cGUsIG0uYnl0ZV9vcmRlcikNCj4+ICAgICAgICAg
ICAgICAgICAgWyBkZWNvZGVkIF0gPSBmb3JtYXQudW5wYWNrX2Zyb20oc2VsZi5yYXcsIG9mZnNl
dCkNCj4+ICAgICAgICAgICAgICAgICAgb2Zmc2V0ICs9IGZvcm1hdC5zaXplDQo+PiArDQo+PiAr
ICAgICAgICAgICAgaWYgbS5lbnVtOg0KPj4gKyAgICAgICAgICAgICAgICBkZWNvZGVkID0gc2Vs
Zi5fZGVjb2RlX2VudW0oZGVjb2RlZCwgYXR0cl9zcGVjKQ0KPg0KPl9kZWNvZGVfZW51bSBpcyBu
b3QgYSBtZXRob2Qgb24gTmxBdHRyIHNvIEknbSBwcmV0dHkgc3VyZSB0aGlzIHdpbGwNCj5mYWls
LiBMb29rcyBsaWtlIHdlIG5lZWQgdG8gbW92ZSBfZGVjb2RlX2VudW0oKSBpbnRvIE5sQXR0cj8N
Cj4NCg0KQXJlIHlvdSBzdXJlIGFib3V0IG1vdmluZyBpdD8gaXQgc2VlbXMgYWxsIHRoZSBkZWNv
ZGUgZnVuY3Rpb24gYXJlIG1lbWJlcnMgb2YNCllubEZhbWlseS4NCg0KPlRoZSBzZWNvbmQgcGFy
YW0gdG8gX2RlY29kZV9lbnVtIHNob3VsZCBiZSAnbScgd2hpY2ggaXMgdGhlIGF0dHIgc3BlYw0K
PmZvciB0aGUgbWVtYmVyLg0KDQpPaywgd2lsbCBkby4gQWx0b3VnaCBJIHRoaW5rIG9mIG1vdmlu
ZyBiYWNrIF9kZWNvZGVfZW51bSgpIHRvIHRoZQ0KX2RlY29kZV9iaW5hcnkoKSwgd2hlcmUgaXQg
d2FzIGluaXRpYWxseSwgYnV0IHdpdGggcHJvcGVyIHVzYWdlIGxpa2U6DQogIGZvciBtIGluIG1l
bWJlcnM6DQogICAgaWYgbS5lbnVtOg0KICAgICAgZGVjb2RlZFttLm5hbWVdID0gc2VsZi5fZGVj
b2RlX2VudW0oZGVjb2RlZFttLm5hbWVdLCBtKQ0KDQpUaGlzIHdheSBhbGwgdGhlIGRlY29kZSBm
dW5jdGlvbiB3b3VsZCBiZSBrZXB0IGluIFlubEZhbWlseS4NCkRvZXMgaXQgbWFrZSBzZW5zZT8N
Cg0KPg0KPj4gICAgICAgICAgICAgIGlmIG0uZGlzcGxheV9oaW50Og0KPj4gICAgICAgICAgICAg
ICAgICBkZWNvZGVkID0gc2VsZi5mb3JtYXR0ZWRfc3RyaW5nKGRlY29kZWQsIG0uZGlzcGxheV9o
aW50KQ0KPj4gICAgICAgICAgICAgIHZhbHVlW20ubmFtZV0gPSBkZWNvZGVkDQo+PiBAQCAtNDE3
LDggKzQyMCw3IEBAIGNsYXNzIFlubEZhbWlseShTcGVjRmFtaWx5KToNCj4+ICAgICAgICAgIHBh
ZCA9IGInXHgwMCcgKiAoKDQgLSBsZW4oYXR0cl9wYXlsb2FkKSAlIDQpICUgNCkNCj4+ICAgICAg
ICAgIHJldHVybiBzdHJ1Y3QucGFjaygnSEgnLCBsZW4oYXR0cl9wYXlsb2FkKSArIDQsIG5sX3R5
cGUpICsNCj4+YXR0cl9wYXlsb2FkICsgcGFkDQo+Pg0KPj4gLSAgICBkZWYgX2RlY29kZV9lbnVt
KHNlbGYsIHJzcCwgYXR0cl9zcGVjKToNCj4+IC0gICAgICAgIHJhdyA9IHJzcFthdHRyX3NwZWNb
J25hbWUnXV0NCj4+ICsgICAgZGVmIF9kZWNvZGVfZW51bShzZWxmLCByYXcsIGF0dHJfc3BlYyk6
DQo+PiAgICAgICAgICBlbnVtID0gc2VsZi5jb25zdHNbYXR0cl9zcGVjWydlbnVtJ11dDQo+PiAg
ICAgICAgICBpZiAnZW51bS1hcy1mbGFncycgaW4gYXR0cl9zcGVjIGFuZCBhdHRyX3NwZWNbJ2Vu
dW0tYXMtZmxhZ3MnXToNCj4+ICAgICAgICAgICAgICBpID0gYXR0cl9zcGVjLmdldCgndmFsdWUt
c3RhcnQnLCAwKQ0KPj4gQEAgLTQzMCwxNSArNDMyLDEyIEBAIGNsYXNzIFlubEZhbWlseShTcGVj
RmFtaWx5KToNCj4+ICAgICAgICAgICAgICAgICAgaSArPSAxDQo+PiAgICAgICAgICBlbHNlOg0K
Pj4gICAgICAgICAgICAgIHZhbHVlID0gZW51bS5lbnRyaWVzX2J5X3ZhbFtyYXddLm5hbWUNCj4+
IC0gICAgICAgIHJzcFthdHRyX3NwZWNbJ25hbWUnXV0gPSB2YWx1ZQ0KPj4gKyAgICAgICAgcmV0
dXJuIHZhbHVlDQo+Pg0KPj4gICAgICBkZWYgX2RlY29kZV9iaW5hcnkoc2VsZiwgYXR0ciwgYXR0
cl9zcGVjKToNCj4+ICAgICAgICAgIGlmIGF0dHJfc3BlYy5zdHJ1Y3RfbmFtZToNCj4+ICAgICAg
ICAgICAgICBtZW1iZXJzID0gc2VsZi5jb25zdHNbYXR0cl9zcGVjLnN0cnVjdF9uYW1lXQ0KPj4g
LSAgICAgICAgICAgIGRlY29kZWQgPSBhdHRyLmFzX3N0cnVjdChtZW1iZXJzKQ0KPj4gLSAgICAg
ICAgICAgIGZvciBtIGluIG1lbWJlcnM6DQo+PiAtICAgICAgICAgICAgICAgIGlmIG0uZW51bToN
Cj4+IC0gICAgICAgICAgICAgICAgICAgIHNlbGYuX2RlY29kZV9lbnVtKGRlY29kZWQsIG0pDQo+
PiArICAgICAgICAgICAgZGVjb2RlZCA9IGF0dHIuYXNfc3RydWN0KG1lbWJlcnMsIGF0dHJfc3Bl
YykNCj4+ICAgICAgICAgIGVsaWYgYXR0cl9zcGVjLnN1Yl90eXBlOg0KPj4gICAgICAgICAgICAg
IGRlY29kZWQgPSBhdHRyLmFzX2NfYXJyYXkoYXR0cl9zcGVjLnN1Yl90eXBlKQ0KPj4gICAgICAg
ICAgZWxzZToNCj4+IEBAIC00NjYsNiArNDY1LDkgQEAgY2xhc3MgWW5sRmFtaWx5KFNwZWNGYW1p
bHkpOg0KPj4gICAgICAgICAgICAgIGVsc2U6DQo+PiAgICAgICAgICAgICAgICAgIHJhaXNlIEV4
Y2VwdGlvbihmJ1Vua25vd24ge2F0dHJfc3BlY1sidHlwZSJdfSB3aXRoIG5hbWUNCj4+e2F0dHJf
c3BlY1sibmFtZSJdfScpDQo+Pg0KPj4gKyAgICAgICAgICAgIGlmICdlbnVtJyBpbiBhdHRyX3Nw
ZWM6DQo+PiArICAgICAgICAgICAgICAgIGRlY29kZWQgPSBzZWxmLl9kZWNvZGVfZW51bShpbnQu
ZnJvbV9ieXRlcyhhdHRyLnJhdywNCj4+ImJpZyIpLCBhdHRyX3NwZWMpDQo+DQo+QXMgSmFrdWIg
c2FpZCwgdGhpcyBzaG91bGQganVzdCBiZSBzZWxmLl9kZWNvZGVfZW51bShkZWNvZGVkLCBhdHRy
X3NwZWMpDQo+DQoNClllcywgd2lsbCBmaXguDQoNClRoYW5rIHlvdSENCkFya2FkaXVzeg0KDQo+
PiArDQo+PiAgICAgICAgICAgICAgaWYgbm90IGF0dHJfc3BlYy5pc19tdWx0aToNCj4+ICAgICAg
ICAgICAgICAgICAgcnNwW2F0dHJfc3BlY1snbmFtZSddXSA9IGRlY29kZWQNCj4+ICAgICAgICAg
ICAgICBlbGlmIGF0dHJfc3BlYy5uYW1lIGluIHJzcDoNCj4+IEBAIC00NzMsOCArNDc1LDYgQEAg
Y2xhc3MgWW5sRmFtaWx5KFNwZWNGYW1pbHkpOg0KPj4gICAgICAgICAgICAgIGVsc2U6DQo+PiAg
ICAgICAgICAgICAgICAgIHJzcFthdHRyX3NwZWMubmFtZV0gPSBbZGVjb2RlZF0NCj4+DQo+PiAt
ICAgICAgICAgICAgaWYgJ2VudW0nIGluIGF0dHJfc3BlYzoNCj4+IC0gICAgICAgICAgICAgICAg
c2VsZi5fZGVjb2RlX2VudW0ocnNwLCBhdHRyX3NwZWMpDQo+PiAgICAgICAgICByZXR1cm4gcnNw
DQo+Pg0KPj4gICAgICBkZWYgX2RlY29kZV9leHRhY2tfcGF0aChzZWxmLCBhdHRycywgYXR0cl9z
ZXQsIG9mZnNldCwgdGFyZ2V0KToNCj4+IC0tDQo+PiAyLjM4LjENCg==

