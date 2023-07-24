Return-Path: <netdev+bounces-20470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5399675FA64
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F07E1C20ADE
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C167D510;
	Mon, 24 Jul 2023 15:04:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D220F3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:04:32 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E58C12E;
	Mon, 24 Jul 2023 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690211070; x=1721747070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u1ujgz/4JBMUSm2Q+JJ24JlTmGdUeCicFRDQbEwanjw=;
  b=gXVuItiTjn11EWsOLQiUlfsuI9oI2Dcx/rHhUTL8DcdwROxZspz2tbYW
   wNlv4Id4Wro8YiiOFHfYbZdxjmvHK7dBUsFLeQIX+JBSQaJCuVBvuuZC1
   u58F6ZZWB3UmGxA3lkJ7Dyd8RJrIQu6MbFMkrMmSt45PyUB0lgJrNFaWe
   y8dQSUhi3Dv1U/wmLrtPD6YHbNUW2lg+5OlxyG8TOgUhYi6AUsH0y+tsU
   6Rav+vOZay5lSBSgzKJzjP+koaBOGHy+fmV6I3MXWzTeyd0RCadMi7brD
   aW5QJx1c5QzG9y2geN4yDDOtn/yZ8a92aBmi3RqXzjMRSRF88/qNI7whW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="357463420"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="357463420"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 08:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719701305"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="719701305"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2023 08:04:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 08:04:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 08:04:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 08:04:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 08:04:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8GLOGrgdE4k0MKGRM9DL6xcwOqN583Sdt5Kw8JCRYas7Uuos+IuzWo9XOeT2U9wgfeXP+RG08rHZsgNtLUtfoWkrdD7tIdhjZJE+6o5rISAAG7e0LcJ95e8CFPvWImWm5Ds1jcj/TY4p4Lb4fIMCtwAjBnozgh2OaoDFHAijmnpEVrXXRbrtt2WLXc/NeU65etNHaM4+xbFZtvcvcqY2x+802oXm6pkkFPYHxj+Q0p9YVkPcOOLnqb26FKcciBdtByQHzqvPA1MecOoMU0VtxnDwHdwKZJtVypv55oLpnfrvF70Z2DUzoBe9gJ1JSQ1t+svK7fpC8r4wywGQn2d1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LweKD6hYxHHaEAZya2bvnX4z0fJmoKkFgu3EyZFnohE=;
 b=UjQ2+fd0H0LAC+kQXE4bROlcz9lNQs8dKRWTec4PDnEBMN/oKMjrIzY9+5H3GRsXDbx340nXuudDbpd80OypFgP/cmtUMG7uKLW0JWeNuRY54UtrUx4OLbVLm4z7KG8KDOvGl4GTZUO+WStBpirYs1KwpSjVIbeKNVtx+uC98Roprxe295cPnJ5fCVVlVQV8+GM1D4idqjECE2NS5j1WqxEXZcK3b1nYA3Z0EVDlCTLQI8RSH8DEiQs5mlL9m20lKoVtQn5tI5E91unLAGk6cyjDV2spLnmuTqcW0NG59nXlbzeit3VpSxgX+fsLtxGOde+9fq5SnmwMSzavllvvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH7PR11MB7124.namprd11.prod.outlook.com (2603:10b6:510:20f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 15:03:55 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:03:55 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "kuba@kernel.org" <kuba@kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Topic: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/CsZmAgAARQbCAARKGAIAAIjuQgAAo5gCAAA2wkIAAMNUAgAA4eDCAAMCPAIADo+2g
Date: Mon, 24 Jul 2023 15:03:55 +0000
Message-ID: <DM6PR11MB465713389A234771BD29DF149B02A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLk/9zwbBHgs+rlb@nanopsycho>
 <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLo0ujuLMF2NrMog@nanopsycho>
 <DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLpzwMQrqp7mIMFF@nanopsycho>
 <DM6PR11MB46579CC7E6D314BFDE47E4EE9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLqoMhxHq3m4dp1u@nanopsycho>
 <DM6PR11MB46571D843FB903AC050E2F129B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLt5GPRls7UL4zGx@nanopsycho>
In-Reply-To: <ZLt5GPRls7UL4zGx@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH7PR11MB7124:EE_
x-ms-office365-filtering-correlation-id: 66402201-335b-4801-b13c-08db8c573357
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /SPUAjWdiLr/HYR/RJV9iDaes9zPL3gASg7OizXjXkHK6zMuC4oAeyPxH/ubZHNIhb00i7VgZMRQxNmdEGkdflcFpEW1ZHQMXFfw/hYyQuTDm0yLhf5YP2oJUo6b5IkbcFb7GnARB65iIOeozmU10rdOkmXPB/mjEILZOBShVkgxxs/pS35irklBYdUOhDtHME89ypeYRiTQCBDFcPJL52oqHZG/X8YDda+1pNTdaWdWdVrAaqU+E8W15mYQ2LaYvfi51CApSN8+md6aoFTP4JgENuu3CSzQ9Xb+onfCh2aKQVHCLO596B/UpXcaU5eCFoZWShhxWmEBGXRSmg7uxfZD/dKwhfEr/qNwStvDyWHd6yJzsoQGuqlOxGuE47S98um4iYrRRs9e0sW+sNMmdTxcJv4Q8zpa+vMmv3HqXIfr9Agq+V+twRhJPsgmlny0YBqtbP3Np/DGeT1m+EigADI6LKJggANdsQZstn+V9m9getp6ie/4dyEWm16rd8fSASUwEMr9KkT4JHEC/O54Q6SSJrLGW69UoFmQUAEb9vj1AO97twOz4aswD7LeYYO/TSFZOEoyNop6j6DKL8518/iqTXhyrR53VMIJlhjQ66G84Fff/RWCCdq2SiBVaufX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(316002)(4326008)(6916009)(52536014)(2906002)(86362001)(38070700005)(30864003)(38100700002)(82960400001)(8936002)(122000001)(7416002)(8676002)(7696005)(9686003)(41300700001)(478600001)(83380400001)(5660300002)(186003)(71200400001)(6506007)(33656002)(54906003)(64756008)(76116006)(66946007)(66446008)(66476007)(66556008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IhCPZ5efsrPF4FeMBFZxOHkXV7zsa1J/jacnakveMJtptbjJDs8/UChE73Ny?=
 =?us-ascii?Q?U394NkAwKITI5+kNSoy7UqxNZq6zAR+UsRn6XwhPCAxFn/S7t/Et8dLYSTEp?=
 =?us-ascii?Q?wF6FSVTo91djbntnhp41vX/W+CHdu1fdbTecMy6ZSEiyP5tYdSzB3VzQmY9O?=
 =?us-ascii?Q?Vggu7VfUFZ30OrxMwRCPW/DIcrdjA2bWZmKk+x3aO6H7TtAMB2WZtNmnogRd?=
 =?us-ascii?Q?x7mkIelXBLach0+8na8uwdP6m7mGsVp2GNaeVTJ1EZirlp4C/jEM0yVv5UQs?=
 =?us-ascii?Q?MlMeiGZrM5PnXyg5h8L1qFAjfSL5NvigPOSTw+9vIU+p4TN0tn4zNfS7LBk2?=
 =?us-ascii?Q?1aTrjx3jgEOWUa8947hf3NiLwg/zS7n2UJ/pLwiXwwauHR0W3vHi5l+jp0/Y?=
 =?us-ascii?Q?uMgK7gYHgSbzq/wcdfv/NqYCNQli7r785ZEp0We8dak+TqO2H5PQYYXUNGE/?=
 =?us-ascii?Q?TYKwSMccfndIl3pZb29BIZknlGF/D+cU8kNxZcA9peWsu20xfYxCrCr9tLtZ?=
 =?us-ascii?Q?s82rERaXVs2Xy7X9kXcitcymImBaiDtU2m5SFqiuuaHATKuYIWLGCUnnQbNp?=
 =?us-ascii?Q?ns9aQnarRi2QQi4bjK4FjL9Z34MEm29c725QWcaTGjhum4YW9WUPutcUVkb2?=
 =?us-ascii?Q?+8h6T70rufVgaZrC3WWdxsD/ecYruyQudH897RiFLxi0f129ZzDOFAm31hB+?=
 =?us-ascii?Q?h7WomSdZMPWToAoaxfqVlQ0K7GpBUr7RkGoVJSXgslPUjfZKLGgAmhsR6Wdf?=
 =?us-ascii?Q?CUfMMdP0a/AYFXhjUioqovDrJSv+551PsfY8B2/hmRbXRLWtwArbW7HGP9Hu?=
 =?us-ascii?Q?fDtbTjPwLQfI8aL20Gs8It5QoZBNRthucbhM4LucwqyqV9rBZDmUTVJhQlul?=
 =?us-ascii?Q?Ui4IeHXKgZVQ/xwUQGwc6uEUA/4G3sY23pFI/AT4JvayJmYSvA/9oMMJefpc?=
 =?us-ascii?Q?gXuGe5A57nJ4karGpov+ZjcW+Iw6Sku5RyKmauM/mN607CHnt9zJghw99z73?=
 =?us-ascii?Q?ZXYsVQshjIzD8LY3cFcHAPblcGDhvWEeOndnxUEiO0N1vhxuNKSusxAPT0Ra?=
 =?us-ascii?Q?G38Xj/6FgOEjEGlvevWL4I7WbpJekNwvAuSTHPT+VAiQsWiI0l10mfW6QMhq?=
 =?us-ascii?Q?bKOvHndxf1KtNsBYxOuY1wmfI5ACO7kIn6hI8UMwfXCvpi397JNWr0kyB3i8?=
 =?us-ascii?Q?HEuEzx1nU7rvIcCCOpPOiWDV8uRG/BFwIzZQqISULmw1uRXkRkjY6diT8Sme?=
 =?us-ascii?Q?VrFZVZB2hzlts8FLupFUnIgQvJAlrs3kn5ahtkBFNA0MeTnsJeqQnTLOcaP5?=
 =?us-ascii?Q?+4Sipg6XlYLU5XngHvYEgCAyYL6FmF2WACJReBPOCtLDQ6qj4wYgc97aRDEE?=
 =?us-ascii?Q?rUZTdhOtKl0GGJs0ZddKMxgCcOJd/GV5NuUccHyUv9y61LNFEWaeZcJMzawB?=
 =?us-ascii?Q?VrFo7b1dcMB0YddhE3Tw14BTNFx5Xd+xJXJ4XH5XV+chYKcDqXoAl2ZqKI7H?=
 =?us-ascii?Q?mjShTP99hGKEsRz+zen7qaJstnSN42SSxNTLekH8N5lt2bhAd7TOpQtt1KJh?=
 =?us-ascii?Q?eLivCX2Lx4EfGA+Y/4nJASoZWLssxQW+B+ELPsQe0clc8nTc5VIywMiN0RlH?=
 =?us-ascii?Q?OohjCQpN/S8NkgpdBlQlcjZk9RLzUV9PWoviez1PewxO6P0G/1pXkG9IsRwL?=
 =?us-ascii?Q?2I/WiA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66402201-335b-4801-b13c-08db8c573357
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 15:03:55.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1rZy/yB35OBN2mWH8O7szO3FdcWOWHXipNmzN5SVBFBUCW0UwbR7f8n19YQa9k0pvNOzeb7bG+fUuG8pivZ/AvgpN8aO5d4VyHcMOJP/eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Saturday, July 22, 2023 8:37 AM
>
>Fri, Jul 21, 2023 at 09:48:18PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Friday, July 21, 2023 5:46 PM
>>>
>>>Fri, Jul 21, 2023 at 03:36:17PM CEST, arkadiusz.kubalewski@intel.com wro=
te:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Friday, July 21, 2023 2:02 PM
>>>>>
>>>>>Fri, Jul 21, 2023 at 01:17:59PM CEST, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>Sent: Friday, July 21, 2023 9:33 AM
>>>>>>>
>>>>>>>Thu, Jul 20, 2023 at 07:31:14PM CEST, arkadiusz.kubalewski@intel.com
>>>>>>>wrote:
>>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>Sent: Thursday, July 20, 2023 4:09 PM
>>>>>>>>>
>>>>>>>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev
>>>>>>>>>wrote:
>>>>>>>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>>>>>
>>>>>>>>>[...]
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>+/**
>>>>>>>>>>+ * ice_dpll_pin_enable - enable a pin on dplls
>>>>>>>>>>+ * @hw: board private hw structure
>>>>>>>>>>+ * @pin: pointer to a pin
>>>>>>>>>>+ * @pin_type: type of pin being enabled
>>>>>>>>>>+ * @extack: error reporting
>>>>>>>>>>+ *
>>>>>>>>>>+ * Enable a pin on both dplls. Store current state in pin->flags=
.
>>>>>>>>>>+ *
>>>>>>>>>>+ * Context: Called under pf->dplls.lock
>>>>>>>>>>+ * Return:
>>>>>>>>>>+ * * 0 - OK
>>>>>>>>>>+ * * negative - error
>>>>>>>>>>+ */
>>>>>>>>>>+static int
>>>>>>>>>>+ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>>>>>>>>>>+		    enum ice_dpll_pin_type pin_type,
>>>>>>>>>>+		    struct netlink_ext_ack *extack)
>>>>>>>>>>+{
>>>>>>>>>>+	u8 flags =3D 0;
>>>>>>>>>>+	int ret;
>>>>>>>>>>+
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>I don't follow. Howcome you don't check if the mode is freerun her=
e or
>>>>>>>>>not? Is it valid to enable a pin when freerun mode? What happens?
>>>>>>>>>
>>>>>>>>
>>>>>>>>Because you are probably still thinking the modes are somehow conne=
cted
>>>>>>>>to the state of the pin, but it is the other way around.
>>>>>>>>The dpll device mode is a state of DPLL before pins are even
>>>>>>>>considered.
>>>>>>>>If the dpll is in mode FREERUN, it shall not try to synchronize or
>>>>>>>>monitor
>>>>>>>>any of the pins.
>>>>>>>>
>>>>>>>>>Also, I am probably slow, but I still don't see anywhere in this
>>>>>>>>>patchset any description about why we need the freerun mode. What =
is
>>>>>>>>>diffrerent between:
>>>>>>>>>1) freerun mode
>>>>>>>>>2) automatic mode & all pins disabled?
>>>>>>>>
>>>>>>>>The difference:
>>>>>>>>Case I:
>>>>>>>>1. set dpll to FREERUN and configure the source as if it would be i=
n
>>>>>>>>AUTOMATIC
>>>>>>>>2. switch to AUTOMATIC
>>>>>>>>3. connecting to the valid source takes ~50 seconds
>>>>>>>>
>>>>>>>>Case II:
>>>>>>>>1. set dpll to AUTOMATIC, set all the source to disconnected
>>>>>>>>2. switch one valid source to SELECTABLE
>>>>>>>>3. connecting to the valid source takes ~10 seconds
>>>>>>>>
>>>>>>>>Basically in AUTOMATIC mode the sources are still monitored even wh=
en
>>>>>>>>they
>>>>>>>>are not in SELECTABLE state, while in FREERUN there is no such
>>>>>>>>monitoring,
>>>>>>>>so in the end process of synchronizing with the source takes much
>>>>>>>>longer as
>>>>>>>>dpll need to start the process from scratch.
>>>>>>>
>>>>>>>I believe this is implementation detail of your HW. How you do it is=
 up
>>>>>>>to you. User does not have any visibility to this behaviour, therefo=
re
>>>>>>>makes no sense to expose UAPI that is considering it. Please drop it=
 at
>>>>>>>least for the initial patchset version. If you really need it later =
on
>>>>>>>(which I honestly doubt), you can send it as a follow-up patchset.
>>>>>>>
>>>>>>
>>>>>>And we will have the same discussion later.. But implementation is
>>>>>>already
>>>>>>there.
>>>>>
>>>>>Yeah, it wouldn't block the initial submission. I would like to see th=
is
>>>>>merged, so anything which is blocking us and is totally optional (as
>>>>>this freerun mode) is better to be dropped.
>>>>>
>>>>
>>>>It is not blocking anything. Most of it was defined and available for
>>>>long time already. Only ice implementing set_mode is a new part.
>>>>No clue what is the problem you are implying here.
>>>
>>>Problem is that I believe you freerun mode should not exist. I believe
>>>it is wrong.
>>>
>>>
>>>>
>>>>>
>>>>>>As said in our previous discussion, without mode_set there is no poin=
t to
>>>>>>have
>>>>>>command DEVICE_SET at all, and there you said that you are ok with ha=
ving
>>>>>>the
>>>>>>command as a placeholder, which doesn't make sense, since it is not u=
sed.
>>>>>
>>>>>I don't see any problem in having enum value reserved. But it does not
>>>>>need to be there at all. You can add it to the end of the list when
>>>>>needed. No problem. This is not an argument.
>>>>>
>>>>
>>>>The argument is that I already implemented and tested, and have the nee=
d
>>>>for the
>>>>existence to set_mode to configure DPLL, which is there to switch the m=
ode
>>>>between AUTOMATIC and FREERUN.
>>>>
>>>>>
>>>>>>
>>>>>>Also this is not HW implementation detail but a synchronizer chip
>>>>>>feature,
>>>>>>once dpll is in FREERUN mode, the measurements like phase offset betw=
een
>>>>>>the
>>>>>>input and dpll's output won't be available.
>>>>>>
>>>>>>For the user there is a difference..
>>>>>>Enabling the FREERUN mode is a reset button on the dpll's state machi=
ne,
>>>>>>where disconnecting sources is not, as they are still used, monitored=
 and
>>>>>>measured.
>>>>>
>>>>>So it is not a mode! Mode is either "automatic" or "manual". Then we
>>>>>have a state to indicate the state of the state machine (unlocked, loc=
ked,
>>>>>holdover, holdover-acq). So what you seek is a way for the user to
>>>>>expliticly set the state to "unlocked" and reset of the state machine.
>>>>>
>>>>>Please don't mix config and state. I think we untangled this in the pa=
st
>>>>>:/
>>>>
>>>>I don't mix anything, this is the way dpll works, which means mode of d=
pll.
>>>
>>>You do. You want to force-change the state yet you mangle the mode in.
>>>The fact that some specific dpll implemented it as mode does not mean it
>>>has to be exposed like that to user. We have to find the right
>>>abstraction.
>>>
>>
>>Just to make it clear:
>>
>>AUTOMATIC:
>>- inputs monitored, validated, phase measurements available
>>- possible states: unlocked, locked, locked-ho-acq, holdover
>>
>>FREERUN:
>>- inputs not monitored, not validated, no phase measurements available
>>- possible states: unlocked
>
>This is your implementation of DPLL. Others may have it done
>differently. But the fact the input is monitored or not, does not make
>any difference from user perspective.
>
>When he has automatic mode and does:
>1) disconnect all pins
>2) reset state    (however you implement it in the driver is totaly up
>		   to the device, you may go to your freerun dpll mode
>		   internally and to automatic back, up to you)
> -> state will go to unlocked
>
>The behaviour is exactly the same, without any special mode.

In this case there is special reset button, which doesn't exist in
reality, actually your suggestion to go into FREERUN and back to AUTOMATIC
to pretend the some kind of reset has happened, where in reality dpll went =
to
FREERUN and AUTOMATIC.
For me it seems it seems like unnecessary complication of user's life.
The idea of FREERUN mode is to run dpll on its system clock, so all the
"external" dpll sources shall be disconnected when dpll is in FREERUN.
Let's assume your HW doesn't have a FREERUN, can't you just create it by
disconnecting all the sources?=20
BTW, what chip are you using on mlx5 for this?
I don't understand why the user would have to mangle state of all the pins =
just
to stop dpll's work if he could just go into FREERUN and voila. Also what i=
f
user doesn't want change the configuration of the pins at all, and he just =
want
to desynchronize it's dpll for i.e. testing reason.

>
>We are talking about UAPI here. It should provide the abstraction, leaving
>the
>internal implementation behind the curtain. What is important is:
>1) clear configuration knobs
>2) the outcome (hw behaviour)
>
>
>
>>
>>>
>>>>
>>>>>
>>>>>Perhaps you just need an extra cmd like DPLL_CMD_DEVICE_STATE_RESET cm=
d
>>>>>to hit this button.
>>>>>
>>>>
>>>>As already said there are measurement in place in AUTOMATIC, there are =
no
>>>>such
>>>>thing in FREERUN. Going into FREERUN resets the state machine of dpll
>>>>which
>>>>is a side effect of going to FREERUN.
>>>>
>>>>>
>>>>>
>>>>>>So probably most important fact that you are missing here: assuming t=
he
>>>>>>user
>>>>>>disconnects the pin that dpll was locked with, our dpll doesn't go in=
to
>>>>>>UNLOCKED
>>>>>>state but into HOLDOVER.
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>Isn't the behaviour of 1) and 2) exactly the same? If no, why? Thi=
s
>>>>>>>>>needs to be documented, please.
>>>>>>>>>
>>>>>>>>
>>>>>>>>Sure will add the description of FREERUN to the docs.
>>>>>>>
>>>>>>>No, please drop it from this patchset. I have no clue why you readde=
d
>>>>>>>it in the first place in the last patchset version.
>>>>>>>
>>>>>>
>>>>>>mode_set was there from the very beginning.. now implemented in ice
>>>>>>driver
>>>>>>as it should.
>>>>>
>>>>>I don't understand the fixation on a callback to be implemented. Just
>>>>>remove it. It can be easily added when needed. No problem.
>>>>>
>>>>
>>>>Well, I don't understand the fixation about removing it.
>>>
>>>It is needed only for your freerun mode, which is questionable. This
>>>discussion it not about mode_set. I don't care about it, if it is
>>>needed, should be there, if not, so be it.
>>>
>>>As you say, you need existance of your freerun mode to justify existence
>>>of mode_set(). Could you please, please drop both for now so we can
>>>move on? I'm tired of this. Thanks!
>>>
>>
>>Reason for dpll subsystem is to control the dpll. So the mode_set and
>>different modes are there for the same reason.
>>Explained this multiple times already, we need a way to let the user swit=
ch
>>to FREERUN, so all the activities on dpll are stopped.
>>
>>>
>>>>set_mode was there for a long time, now the callback is properly
>>>>implemented
>>>>and you are trying to imply that this is not needed.
>>>>We require it, as there is no other other way to stop AUTOMATIC mode dp=
ll
>>>>to do its work.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>Another question, I asked the last time as well, but was not heard=
:
>>>>>>>>>Consider example where you have 2 netdevices, eth0 and eth1, each
>>>>>>>>>connected with a single DPLL pin:
>>>>>>>>>eth0 - DPLL pin 10 (DPLL device id 2)
>>>>>>>>>eth1 - DPLL pin 11 (DPLL device id 2)
>>>>>>>>>
>>>>>>>>>You have a SyncE daemon running on top eth0 and eth1.
>>>>>>>>>
>>>>>>>>>Could you please describe following 2 flows?
>>>>>>>>>
>>>>>>>>>1) SyncE daemon selects eth0 as a source of clock
>>>>>>>>>2) SyncE daemon selects eth1 as a source of clock
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>For mlx5 it goes like:
>>>>>>>>>
>>>>>>>>>DPLL device mode is MANUAL.
>>>>>>>>>1)
>>>>>>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth0
>>>>>>>>>    -> pin_id: 10
>>>>>>>>> SenceE daemon will use PIN_GET with pin_id 10 to get DPLL device =
id
>>>>>>>>>    -> device_id: 2
>>>>>>>>
>>>>>>>>Not sure if it needs to obtain the dpll id in this step, but it doe=
sn't
>>>>>>>>relate to the dpll interface..
>>>>>>>
>>>>>>>Sure it has to. The PIN_SET accepts pin_id and device_id attrs as in=
put.
>>>>>>>You need to set the state on a pin on a certain DPLL device.
>>>>>>>
>>>>>>
>>>>>>The thing is pin can be connected to multiple dplls and SyncE daemon =
shall
>>>>>>know already something about the dpll it is managing.
>>>>>>Not saying it is not needed, I am saying this is not a moment the Syn=
cE
>>>>>>daemon
>>>>>>learns it.
>>>>>
>>>>>Moment or not, it is needed for the cmd, that is why I have it there.
>>>>>
>>>>>
>>>>>>But let's park it, as this is not really relevant.
>>>>>
>>>>>Agreed.
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state=
 =3D
>>>>>>>>>CONNECTED
>>>>>>>>>
>>>>>>>>>2)
>>>>>>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth1
>>>>>>>>>    -> pin_id: 11
>>>>>>>>> SenceE daemon will use PIN_GET with pin_id 11 to get DPLL device =
id
>>>>>>>>>    -> device_id: 2
>>>>>>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state=
 =3D
>>>>>>>>>CONNECTED
>>>>>>>>> (that will in HW disconnect previously connected pin 10, there
>>>>>>>>>will be
>>>>>>>>>  notification of pin_id 10, device_id -> state DISCONNECT)
>>>>>>>>>
>>>>>>>>
>>>>>>>>This flow is similar for ice, but there are some differences, altho=
ugh
>>>>>>>>they come from the fact, the ice is using AUTOMATIC mode and recove=
red
>>>>>>>>clock pins which are not directly connected to a dpll (connected
>>>>>>>>through
>>>>>>>>the MUX pin).
>>>>>>>>
>>>>>>>>1)
>>>>>>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>>>>>>>pin_id: 13
>>>>>>>>b) SyncE daemon uses PIN_GET to find a parent MUX type pin -> pin_i=
d: 2
>>>>>>>>   (in case of dpll_id is needed, would be find in this response al=
so)
>>>>>>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2)=
 to
>>>>>>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, whi=
le
>>>>>>>>all the
>>>>>>>>   other pins shall be lower prio i.e. pin-prio:1)
>>>>>>>
>>>>>>>Yeah, for this you need pin_id 2 and device_id. Because you are sett=
ing
>>>>>>>state on DPLL device.
>>>>>>>
>>>>>>>
>>>>>>>>d) SyncE daemon uses PIN_SET to set state of pin_id:13 to CONNECTED
>>>>>>>>with
>>>>>>>>   parent pin (pin-id:2)
>>>>>>>
>>>>>>>For this you need pin_id and pin_parent_id because you set the state=
 on
>>>>>>>a parent pin.
>>>>>>>
>>>>>>>
>>>>>>>Yeah, this is exactly why I initially was in favour of hiding all th=
e
>>>>>>>muxes and magic around it hidden from the user. Now every userspace =
app
>>>>>>>working with this has to implement a logic of tracking pin and the m=
ux
>>>>>>>parents (possibly multiple levels) and configure everything. But it
>>>>>>>just
>>>>>>>need a simple thing: "select this pin as a source" :/
>>>>>>>
>>>>>>>
>>>>>>>Jakub, isn't this sort of unnecessary HW-details complexicity exposu=
re
>>>>>>>in UAPI you were against in the past? Am I missing something?
>>>>>>>
>>>>>>
>>>>>>Multiple level of muxes possibly could be hidden in the driver, but t=
he
>>>>>>fact
>>>>>>they exist is not possible to be hidden from the user if the DPLL is =
in
>>>>>>AUTOMATIC mode.
>>>>>>For MANUAL mode dpll the muxes could be also hidden.
>>>>>>Yeah, we have in ice most complicated scenario of AUTOMATIC mode + MU=
XED
>>>>>>type
>>>>>>pin.
>>>>>
>>>>>Sure, but does user care how complicated things are inside? The syncE
>>>>>daemon just cares for: "select netdev x as a source". However it is do=
ne
>>>>>internally is irrelevant to him. With the existing UAPI, the syncE
>>>>>daemon needs to learn individual device dpll/pin/mux topology and
>>>>>work with it.
>>>>>
>>>>
>>>>This is dpll subsystem not SyncE one.
>>>
>>>SyncE is very legit use case of the UAPI. I would say perhaps the most
>>>important.
>>>
>>
>>But it is still a dpll subsystem.
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>
>>>>>Do we need a dpll library to do this magic?
>>>>>
>>>>
>>>>IMHO rather SyncE library :)
>>>>
>>>>Thank you!
>>>>Arkadiusz
>>>>
>>>>>
>>>>>>
>>>>>>Thank you!
>>>>>>Arkadiusz
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>2) (basically the same, only eth1 would get different pin_id.)
>>>>>>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>>>>>>>pin_id: 14
>>>>>>>>b) SyncE daemon uses PIN_GET to find parent MUX type pin -> pin_id:=
 2
>>>>>>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2)=
 to
>>>>>>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, whi=
le
>>>>>>>>all the
>>>>>>>>   other pins shall be lower prio i.e. pin-prio:1)
>>>>>>>>d) SyncE daemon uses PIN_SET to set state of pin_id:14 to CONNECTED
>>>>>>>>with
>>>>>>>>   parent pin (pin-id:2)
>>>>>>>>
>>>>>>>>Where step c) is required due to AUTOMATIC mode, and step d) requir=
ed
>>>>>>>>due to
>>>>>>>>phy recovery clock pin being connected through the MUX type pin.
>>>>>>>>
>>>>>>>>Thank you!
>>>>>>>>Arkadiusz
>>>>>>>>
>>>>>>>>>
>>>>>>>>>Thanks!
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>[...]
>>>>>>

