Return-Path: <netdev+bounces-21624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4997D7640F2
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0458B281FA2
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FD11BEFF;
	Wed, 26 Jul 2023 21:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418CE1BEF5
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:10:10 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE8F1BE8;
	Wed, 26 Jul 2023 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690405808; x=1721941808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pkBbAqz2VughNXcRJfTiVlvjvyUVTEUtBaixLf0va5M=;
  b=TXTTrd6P9h6qYVG4NCZ4TDvKTkpZsdgZ7h1fkTZOloIz4fNnNqk93FMt
   zL6EoTZQz+89+55hnhf1fQvK16EE77g5ahaYHb4i79mcgZKHL7N3XlHUj
   Es/jUxpTWN7eKYSxSome73hf3+xBvfUdoU0z1ZRJxfo2BItsw8HWXHdEB
   3A9rj2cl2hDdWoMTEXdeA9PPx0b5j1pOtsZ7ZI392j2j3InneWB+CvKro
   2m2qDQXnofFRNSwzfm/azfgXIFCYGVn4Qvs373Q1nC3pOcbbGJcilULMB
   9YjPlIFxhPiC/cdaYTGuKDBNWVy8C7+oV1jhaZL1DhiM1kahUP38CMZBX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="399070005"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="399070005"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 14:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="796719656"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="796719656"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2023 14:10:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 14:10:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 14:10:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 14:10:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 14:10:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLG3ngem/UBOinAG4UTDXF9S+voAfb64SPOqYkp3paRhJ8VR70h/C6n2tvTeDLZ8U9m7l5iqPEjRHQhcuipvUbkOYdGyUrt8eKxRfdcGDbrbnKe5pFQEdnblcTHHZA+C+737Aup+mOcJy6ESRIWLEBnPJU2/0p3vkLGFkI8eyCZzMUDig3iZX0rAsHRDI3TZAD/y2gURiPBM0GnDSI/dMq+Q/61cEJoKdeh+juJ0o4/3aQZYfRlmt4mYiOAtAEmXIw6KeZ3UTaY0Vu8kMpR25QOojzel7H642U25DDwvuqoXEKlNacijo204DT13DHl3TnS+eemaU2kcvfe1iwsglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkBbAqz2VughNXcRJfTiVlvjvyUVTEUtBaixLf0va5M=;
 b=Lc/ic1EixSnGv+mijCokoh5KLIweaeJ8EY9bp113mB9f6bKNUOeXeJxomVs0Ffn97L+2omjrcw1QAGk7cUgTYGV6XxXz0o0qulz6sYX9S5o+Xo9qo7Sv1a/iECKOfXsfuzmuk+lR23XuUVxxpkzzSGbB7bLSWY82mdIzm9k7FBDIamHBuclM8qFnxgrWaK816aoUwzHwZnMtenoM6K/RVYD0joviEU/eXqruofGeX0KEDh9Ha7p1acgRioxz27kNM+V4PTpqGDkrBCa59SCm2Q7TpOsfUz1ouUgFnt7HXUFdr8VtsYr4AZ2V7aPkHnfhKdhQzBLFMwBBV9Li9EDhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CH0PR11MB8088.namprd11.prod.outlook.com (2603:10b6:610:184::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 21:10:04 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 21:10:04 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "Jiri
 Pirko" <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Topic: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/CsZmAgAARQbCAARKGAIAAIjuQgAAo5gCABv5UAIABFKsAgABhlsA=
Date: Wed, 26 Jul 2023 21:10:04 +0000
Message-ID: <DM6PR11MB46576C213362F2A76466A0FA9B00A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
	 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
	 <ZLk/9zwbBHgs+rlb@nanopsycho>
	 <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
	 <ZLo0ujuLMF2NrMog@nanopsycho>
	 <DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
	 <ZLpzwMQrqp7mIMFF@nanopsycho> <20230725154958.46b44456@kernel.org>
 <a3870a365d6f43491c8c82953d613c2e69311457.camel@redhat.com>
In-Reply-To: <a3870a365d6f43491c8c82953d613c2e69311457.camel@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CH0PR11MB8088:EE_
x-ms-office365-filtering-correlation-id: 01051384-d47e-49fe-92d7-08db8e1caebf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vFiCZp82lrFRmFwMkJNjD1lyqLTn4zpEOtXnHw7O9Mw6MobdL35rbYzlIcRgtTsO9vraac7EOgoFC939vURyadVp/0XeiJq6EbpE0VwTHPiwZHad2XomxR4/SIbLHK0OofufRZ6A62dt+n7sgTP0BiWN/Vpaw2CRumEk+AakXNffxJxxkriNJRcvkaAdKsVZcRzo6mXQFj352zayhmuUcrqYjuNpSk5rKxiXbxVKdZdl/EiZuwM//22G+w9QD1wIjLQBgCu0s/RKvM9AV8y7uWX4CS/sqO64Hllen8SYuLnIzTNHtAcUKyYHfrGKmDPJV3AQuGVuWXHwGGPlxK0FQ0JDtEMyLEu8Gi7ies67NY0rWJxZoVsullVzRTYDNL+5m9XTmtjbraP7eWEQicAVzRQsdDtTFLcoOnt6OVmwZAaSLXJBVM6kbgbTkM9/QKNRvP/q1P4EJYRdRNBZPP3PkNUzX8W7HQg1Ugt/DiyuWfC7/VkVyBypPwP2KPZ7qtlYUiTCZX1piSs9RJXMrjsnG3ROIZo85llpFzAmd/Snj5tvbK5oYA3a5HEIfBo3wDGBd+R8agSBu03KFel/P9ssmSHmQ9wPzeQCpF/nlU5IWbdAhytGU+M0TE/rFcLRjobf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(2906002)(71200400001)(186003)(6506007)(26005)(4326008)(38100700002)(122000001)(316002)(52536014)(41300700001)(33656002)(83380400001)(66556008)(66946007)(5660300002)(76116006)(66446008)(66476007)(8676002)(8936002)(7416002)(38070700005)(86362001)(55016003)(64756008)(82960400001)(110136005)(54906003)(478600001)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFJxK2ttZ2xMR0RKcWxmZmdmY2hqOHBoU04xRDl2ejdyRVJ0azQrQnBDWW5E?=
 =?utf-8?B?UWc1RjBlNjhjZVFBcEhiWFVJMFhWdGZaY2pQWHdtbEZ6SXlVWllsOWdheDhT?=
 =?utf-8?B?TnpURUNNVjR1NEd6NUtjeERmWWRKUGJZN1pIOXRUMFB4N01iK0UvS0hZdVNE?=
 =?utf-8?B?dGhYSkdycVZlbFY2dDU4UEhCZy9EMXJ3aUxqNDNoMmxaRWJHejJrVzI4L2p4?=
 =?utf-8?B?YXlDNk9zbmEwSThOS1B3Qkl4KzU5cS9pY3Y4Y1NBT1dCTzhkc3YzQUdYQ3Bk?=
 =?utf-8?B?Mmo1K1Q0TkxORmVZQktnVjJoSFNQRm4wcTVEaHZ2Ykc5UHB0OEJaN1lweXJO?=
 =?utf-8?B?STBoakYrUVRvQ1VVa0dyQ05LdnUyTzhEaDdCSHozckZCQ0l2c09MQTJyak1w?=
 =?utf-8?B?WENkOW03TnhGc1BGUk8zZHphR3M1T0NlajVjNHJCY25VMU0xWklESGl5S0RF?=
 =?utf-8?B?QWFQU3pDUWZDa21lSS9qbi81V0c5Qm9pdk1ZMHVpNXVZNThQVlhyRnBWQ054?=
 =?utf-8?B?VllQWnpkL2cxNFZXaDE2YkRkT0RrcjFDbmVNcWd3WFA3YklpSVB4QWZVKzk1?=
 =?utf-8?B?WTdiNkNwRStOQ0lxajVEYTlHN1V1Q3IwaHFISFBMbG81WDVKOGxzUmk4VC85?=
 =?utf-8?B?a1d3TnpFRncxdVE4aHdvK3cyMGpkZzEwRnM5OEdFVFpjNlZQZzdRb3FnYXcr?=
 =?utf-8?B?WHpRczNNRFFrNm5YOWxVME5TUlV1SHVwUnNVR3lRSXV3U0NEMm1kSEljQ3Rk?=
 =?utf-8?B?emZ0UythTmhQYXBQTmxIeUx3T1lOY3NSajlld29oNkNhZlZQdUxnT2lKL2JO?=
 =?utf-8?B?Z0JiNGJaL3BPNDdpY3hYWnNXNUJxVm5jcVE5QmdBYmhxTGppT0ExRXY2TmZQ?=
 =?utf-8?B?MHFObjJtVzluVW9XVDNkSVQxNUdvZEkxT1M0MldzUWVXZFlBVGNMWlZldDdl?=
 =?utf-8?B?NGIxUE45bndGendFZm82QXJ6UDRhWkt4dWVFRElHRllMVTVvY1NCZ2QyeXE5?=
 =?utf-8?B?SDlKWDM0SEdlSml1Tzg2UEVmWXZ2WnBQSFNsUW5NSHVVMnpqbytMYU5JbmZH?=
 =?utf-8?B?bU1TckNxMnhEVnh5Qjdac1M1OEtiZUpLWnN4OS9QRHhDYVdDS2xtQ3ZrRnl6?=
 =?utf-8?B?QjFZQ1h4NnZvN05WTS9QamxVcS8xUWNmSmE0aDBZSlNFc0wxZzNHWmRTS0Jw?=
 =?utf-8?B?OFBuY3QyNUdwQkR4NXlaT25ERjBKMDV5RGVwVzNGL1gvaVZxWG05QVd0bU5k?=
 =?utf-8?B?RE94YTVKSnZHOGFONWZYRFRQOXIxY2pzY3QrZnpQVlZlQ0VZRTJXRFhJdVh0?=
 =?utf-8?B?bFRrYjkzQ0NXa040OGNWMzZ0L0JMRDNGL3IrZUwvalU3MEpRTlRlK0YxMFla?=
 =?utf-8?B?eUVlMEs3MFVEZVRZT21XNHBlRGFkbXNUT2JtSzRxQzBvSmhHWUlBd3p0eDE0?=
 =?utf-8?B?cGJUQnVwWEJmYmNRNEdhTEh4RERCNUVhUnluWWdCbUxxZzZ1ZlJYNmhDKzE3?=
 =?utf-8?B?ejc1VTl3Ti9paWxJaXJkbS9mNG4yR20xUC94UGNBVGR1TVRGQUdQS1c1Tjl5?=
 =?utf-8?B?cDQ1VHpYS0F0L3ZzWi8wT0hoQkxBc0NzaWhWRUxiOFBjcVg2MXRPOUdzUkR6?=
 =?utf-8?B?TS82QW5SSzlHYTVMMVRzRmh2akZjNHBtVm9SSFRidkhWVVNSTGdjR3FTVURp?=
 =?utf-8?B?cGJyUTdoOUFmSWs5aU53YzJZY2JyQWd1Y1dtMU44ZzJ4UzFUQnJHeGtXeWlP?=
 =?utf-8?B?Uk5sVXRGVVQ0L0NtOGNBa0UzWVlaWkwvY1kwbFk0RzVEaHkyV3h1VFFRTVNl?=
 =?utf-8?B?Q1NpZWUrckFwRHM0c3REZVNTWHJWa0FnTHllbDRPS3J5bTNieFViYlpKK1Jy?=
 =?utf-8?B?L0V6MDQ4bmhzVnI2WXR3OUp0aG80dkFiYzN4ekpkeHd1UjQ3Yi9rRndCSE00?=
 =?utf-8?B?TkJjcWJ1QWdaalYwMG9VWnhYYjE5clI2OXVnZEFUQWhoM1FIbUV1YUNnMTRW?=
 =?utf-8?B?OWFqc1hXOHJzaVhnVjNxRkpLU3RGSkhnblI5UDZ0VVd2WHg2ejNjRWljc2pj?=
 =?utf-8?B?RnhvYmh4bW9nbloyZDRVS1F6T1k1eDVzanNGOWs4VVNLeGRucTVidU5WbHZw?=
 =?utf-8?B?cFNPMW44Q21RS3RQa1NGNTg5UGFta0wvLzFNcnRKa3A5WklnRDY2ZXBkcTBq?=
 =?utf-8?B?bGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 01051384-d47e-49fe-92d7-08db8e1caebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 21:10:04.4465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PhAL4+m3v9H1INMBfv9uMFCXUwG4yz+8CePY2pPn/pigRj4FXdVcyu0ktfNOmvlY/gCzILCrR/RLqdJKSDXzvlZLJl4wqhoEu+ZgHTOM2nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8088
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQo+RnJvbTogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0KPlNlbnQ6IFdlZG5lc2Rh
eSwgSnVseSAyNiwgMjAyMyA1OjIwIFBNDQo+DQo+T24gVHVlLCAyMDIzLTA3LTI1IGF0IDE1OjQ5
IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4+IE9uIEZyaSwgMjEgSnVsIDIwMjMgMTQ6
MDI6MDggKzAyMDAgSmlyaSBQaXJrbyB3cm90ZToNCj4+ID4gU28gaXQgaXMgbm90IGEgbW9kZSEg
TW9kZSBpcyBlaXRoZXIgImF1dG9tYXRpYyIgb3IgIm1hbnVhbCIuIFRoZW4gd2UNCj4+ID4gaGF2
ZSBhIHN0YXRlIHRvIGluZGljYXRlIHRoZSBzdGF0ZSBvZiB0aGUgc3RhdGUgbWFjaGluZSAodW5s
b2NrZWQsDQo+PiA+IGxvY2tlZCwNCj4+ID4gaG9sZG92ZXIsIGhvbGRvdmVyLWFjcSkuIFNvIHdo
YXQgeW91IHNlZWsgaXMgYSB3YXkgZm9yIHRoZSB1c2VyIHRvDQo+PiA+IGV4cGxpdGljbHkgc2V0
IHRoZSBzdGF0ZSB0byAidW5sb2NrZWQiIGFuZCByZXNldCBvZiB0aGUgc3RhdGUgbWFjaGluZS4N
Cj4+DQo+PiArMSBmb3IgbWl4aW5nIHRoZSBzdGF0ZSBtYWNoaW5lIGFuZCBjb25maWcuDQo+PiBN
YXliZSBhIGNvbXByb21pc2Ugd291bGQgYmUgdG8gcmVuYW1lIHRoZSBjb25maWcgbW9kZT8NCj4+
IERldGFjaGVkPyBTdGFuZGFsb25lPw0KPg0KPkZvciB0aGUgcmVjb3JkcywgSSBkb24ndCBrbm93
IHRoZSBIL1cgZGV0YWlscyB0byBhbnkgZXh0ZW50cywgYnV0DQo+Z2VuZXJhbGx5IHNwZWFraW5n
IGl0IHNvdW5kcyByZWFzb25hYmxlIHRvIG1lIHRoYXQgYSBtb2RlIGNoYW5nZSBjb3VsZA0KPmNh
dXNlIGEgc3RhdGUgY2hhbmdlLg0KPg0KPmUuZy4gc3dpdGNoaW5nIGFuIGV0aGVybmV0IGRldmlj
ZSBhdXRvbmVnIG1vZGUgY291bGQgY2F1c2UgdGhlIGxpbmsNCj5zdGF0ZSB0byBmbGlwLg0KPg0K
PlNvIEknbSBvayB3aXRoIHRoZSBleGlzdGVuY2Ugb2YgdGhlIGZyZWVydW4gbW9kZS4NCj4NCj5J
IHRoaW5rIGl0IHNob3VsZCBiZSBjbGFyaWZpZWQgd2hhdCBoYXBwZW5zIGlmIHBpbnMgYXJlIG1h
bnVhbGx5DQo+ZW5hYmxlZCBpbiBzdWNoIG1vZGUuIEkgZXhwZWN0IH5ub3RoaW5nIHdpbGwgY2hh
bmdlLCBidXQgc3RhdGluZyBpdA0KPmNsZWFybHkgd291bGQgaGVscC4NCj4NCj5DaGVlcnMsDQo+
DQo+UGFvbG8NCj4NCg0KVGhhbmsgeW91IGZvciB0aGUgaW5zaWdodHMhDQpBcmthZGl1c3oNCg==

