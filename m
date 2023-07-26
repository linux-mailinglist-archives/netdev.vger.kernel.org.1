Return-Path: <netdev+bounces-21622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E490E7640EA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD33281E82
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6B1BEFD;
	Wed, 26 Jul 2023 21:08:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB01BEF8
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:08:43 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325041BE2;
	Wed, 26 Jul 2023 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690405722; x=1721941722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zmXW/8i2LwxYD06/+j9I3slvZEQEmFlDHjtl3tIxuA0=;
  b=XpoG6ebHFbqtuxs3cJwk9Apix5DCN0KM+TQbBhQ8cUJ37DUzqu3W4ZRp
   dQa1DrPdmVK8b94G5N/OWZNjBuL+gnYRLHS7zTw6CAunwZPtssUlG++9d
   W9nz/avey+Y3LpQHKMMjssYCXPOrNZJ3443VPBp27SeIvbGyQWqaMdN2a
   DVEwgXzZfZvy4xD/tM3uyxTzotuGbaq+8TT2pZrYFqZpffTM/Ye8o+xCt
   NxlusnXwfy7dyRcPey2DI61kasErZ696isNUYjaosTIZlGXIlFHKBvxF9
   xurIWkK7dK81QXESu/ZCpfH2hK68dMaf8VSdacmqhSMWInZSPnuYH01oT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="399069789"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="399069789"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 14:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="796718928"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="796718928"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2023 14:08:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 14:08:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 14:08:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 14:08:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1QVsF0y5g+ImQ1b9spQZkvxQKcwl/ZOtj/JMGUHkEf7G3M0nDfvN45WSx5N48moIPzSd5g/8acy7TAdEYedxGhvC1MMG6hcaQC4y3K31f1lmS1flvlDRzsYYoA+0w9wenOm6dXxkWtWfVDq75pPnfc5Byh9VWEzha4AE9HVjHM2zUt//ir5XK3Ifo8F8Xm/62El/uiVJTEvIlKF/FkbJFctU7j5lsHgX97J+K1rsixVmSiD3jXmlsT5nQJGOXE72nXglsiLHm2R+qev3YVnlyUy/o5lPJdJXbNlq2KdK994Nor5JvCCuynn/fwxW8lylURlZI6OStU0r7bKJwSjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmXW/8i2LwxYD06/+j9I3slvZEQEmFlDHjtl3tIxuA0=;
 b=TA9Ocq8C+Yl0s/oK+zcAp1MBB0mFjn2p6CXCD9/qmsXqMyKlh4JaMun2Z7jGIwM+ivJFZtJPYof3mkSZwkLfCepUZn9WwEZnWJjzk2EYcqCGcLBPYIyvgi70mfR1y0v8/X1fGHO3MOVABOc6XFToa9gvzjBouKybUMyrK7qTB2kxAmt4Ymm5xwlJdLzq+mYUYK6GhgFpzpeXrJAJ80PnsrxK4HImeZ6sRVNsX/TfefU2CqINstQctUVymy1t9qrZXTe77R80VuRuQUsWMhpKI02W7hOK4Q9P39WcsLrg8A8HHaALQgCOciSjpORwQrR1FhuQ2RxJLcEoHos/7ddkCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 21:08:06 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 21:08:06 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "Olech, Milena"
	<milena.olech@intel.com>, "Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Topic: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/CsZmAgAARQbCAARKGAIAAIjuQgAAo5gCABv5UAIABdbUQ
Date: Wed, 26 Jul 2023 21:08:06 +0000
Message-ID: <DM6PR11MB465746A9C3512A61512070939B00A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
	<20230720091903.297066-10-vadim.fedorenko@linux.dev>
	<ZLk/9zwbBHgs+rlb@nanopsycho>
	<DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
	<ZLo0ujuLMF2NrMog@nanopsycho>
	<DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
	<ZLpzwMQrqp7mIMFF@nanopsycho> <20230725154958.46b44456@kernel.org>
In-Reply-To: <20230725154958.46b44456@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MW4PR11MB5890:EE_
x-ms-office365-filtering-correlation-id: 6c0aabd8-f203-49f6-ed14-08db8e1c6863
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlYDwVexueFfb4a5t1mFPKu9yD4cezKotOgYWfWpIKa452iHChbuO0H0VtEHkaDfDsys9eohTWE9xNmczETBJLhIdfvJjQiUfWXhM9p5zS2XeCHPPcoddoJP80+ZqY+W7G9CTJPYrXr5Q0KymWWWBDyO/l2O15SwEGrFZZPe7cMqqbvAq+9otVL1M0kJd/VCjikKk70tAye/XPeyk8WNmQ5LhrlFxKexivXfzWQpWw3TNOQeO5VQoytm0+JE1nkO0TkrXXUUFMhVqJuQUGIzJ23X6+dmdsyl46mT58sC4zC0kGUHykht+DzLA7bL0cTzjX0efCHYbn/k9CQ1e4DFLJu+HMyMdMuN/vsC/REtfoQBcAFLpGY8TQN8R8cGEAgoVdCas9JeDj2dTzp5Mft84ESrojLUXrvOcZdqb6ceAU7DQ3gr2070CFa5x9OhAFpxkfJ6Usxv16nWJECvJ6G2LpcMM91do4oU2wkGAjz+trpxyJADtlQKGgow0fdZcXssxtJrg2vF+Fr++WM1u02NW9axowIGmolIMgvVx/1fi97roQZYIb9fUyDYw56yWwrzG2AbVLYRz+5ioEGuci7Dz/krmG9ZFwZZotuHi0y0zwTmHEODgSEfn+d+9eFZZ6QA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(7416002)(52536014)(8676002)(8936002)(41300700001)(5660300002)(2906002)(316002)(4744005)(4326008)(66446008)(64756008)(54906003)(76116006)(66476007)(66556008)(66946007)(71200400001)(186003)(478600001)(9686003)(6506007)(110136005)(7696005)(26005)(86362001)(83380400001)(55016003)(82960400001)(38070700005)(38100700002)(33656002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eHWCYI4NzSO7Ok56R41qi1waYXZAXu2W3uqzTCaUHW2A/3ce0YI9Cia8lmaG?=
 =?us-ascii?Q?i7y4TIFOoZgzqtEB4x+P3Fdl+8Or9seqevT3dCLNzO+mfOWx/dcUvIVsOJUr?=
 =?us-ascii?Q?0W7soBN2m54+fRK0b2VShOdQIqe5EqxFnSHBx5B6MTrOrxcWl1WgKyBM8zZr?=
 =?us-ascii?Q?/uT2y7ReQpotv+RkhneXRiPepH6oeWExN16qX+E8s8jNcG4F0nqjv0eu/1pN?=
 =?us-ascii?Q?wxyzbi+zzYpg+54CmTQkMKdGjzoboQam+knLODXN03y2rgzBghm8CwfSgwxk?=
 =?us-ascii?Q?xJlQyEs9ZmJ0W6c+sHyRJ9AdFGrz/BddFD+fSaWVN4YbGkl/IQDLL6KsEYW4?=
 =?us-ascii?Q?F17yb/KlOKRZKqv3dKEYpdK3MpYjtabl7xi7Js6awclTJPrrysPqWGltEvg6?=
 =?us-ascii?Q?MjO8qSqKUliK6ZEV6uSACUi/vi5Y9Nr4TDOqXrE7gtXuSbBe7DrWo666+j/d?=
 =?us-ascii?Q?AEXVBIS3IPsDLGHVPA6+SN+ho2dJJiOJWxbn/tzSf2z+J5dIkvk0JpLYigaJ?=
 =?us-ascii?Q?MBY4kkrKJ483TpQ8hBz6ctJ/LTfL852B5IZfsvYXWfnF9zSdNNE8tVlYxzWR?=
 =?us-ascii?Q?tJ6lRDiGjWu1Hqpf88F6GoIHC85JGBwp6HQhB235pIB8pBqDb4d0xw6K7s6p?=
 =?us-ascii?Q?g1skvRzPovrKM302p8e/W8Um7ipHIiKJuxdio/NGDkkMeahc0XNmWFQyCVW4?=
 =?us-ascii?Q?90s9JAEj3E1ZQqL0V4GbDskCrd2cuH3JdEcjOEegiP8gIvQddijgnb+H9HVY?=
 =?us-ascii?Q?1dUHv0LbSpOFMuPQVCGsYelmkiBDgMvnxEY/h3O7RkEChzymD4HhsLONKnfb?=
 =?us-ascii?Q?+AJjLGheRF9elT7USVxYR6/EpDITfzwIjqfXZBLt8jsga+EvmonyEc84/3YI?=
 =?us-ascii?Q?+l1LSTcQBOuyGx+VZqAGFOPUovNlLEZ7d8Y3t21ke3/MAEbzBLuxCIhNJlba?=
 =?us-ascii?Q?GfLnl6n2GFTyTfbYvVyNSwSd7aV11Tp4s3mknMOS4X9IXV2FiWhjlQ6l5lVY?=
 =?us-ascii?Q?7T3znRjbw40LBug1Jv4R9d1a1qbS8mc2sFlItcSybr3Me99m8b2jfZA8hcwN?=
 =?us-ascii?Q?QOhcTKmC4kaztFdLB48UYc47hqYqPsGFTdJCu3oi09+nnFODiXcXrF9FhGCT?=
 =?us-ascii?Q?s2I5uWJtYBWOyabIlFMBB8d1gKhtMigCFL2saCh5ety2zmK/xFDO/4IxnFhh?=
 =?us-ascii?Q?m+QeKJTiSg9SLle9Kblo3XdAwtoVLh5DBDyclSLsaKhUjcr2qYcB1tbgn7zi?=
 =?us-ascii?Q?3Dk3kZeWsFFD9JFCzPFLecITK1y4mBh+XQzQU3HXeQQQIXY7/0UJPTPgmMsk?=
 =?us-ascii?Q?pI/I0cnn8yjC0KgR8hn1F3MIybd0PjJmQ5GKV7zx/dZvI9FI59hDNXMInCF8?=
 =?us-ascii?Q?xcskPuWkpgrK5V64XkKrHT30GN97E/0Ll/DSNZP98Rr4LLXwUR+7AhFXO+z3?=
 =?us-ascii?Q?jpwcAgFPBK4PflXAwuDLSTY2ubDx+XIcX5Ng0TYi0ez6Y71c4MZhJv9Yucpy?=
 =?us-ascii?Q?M9IsGexjuTVjcqW7uqxyg+TxgR178Gk03n/8eG5Et0G1gKR7bXRjq7cWCIY4?=
 =?us-ascii?Q?sgf51PjJruEy3BpKmB7A4mjfxdhmDkhDzOCV/MTy8R0RweJ4BukyUOIgo0KS?=
 =?us-ascii?Q?RA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0aabd8-f203-49f6-ed14-08db8e1c6863
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 21:08:06.4637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHV0OzMcqXboVBgZK6HExLq+1FiX19+O5dujP5Ig6XLbRe+9X3da9CII9mfW0gLKawNGVCRN7IAwdIkKdEeZjJl0vQ5JTIpYkrf9cXTQRCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5890
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Wednesday, July 26, 2023 12:50 AM
>
>On Fri, 21 Jul 2023 14:02:08 +0200 Jiri Pirko wrote:
>> So it is not a mode! Mode is either "automatic" or "manual". Then we
>> have a state to indicate the state of the state machine (unlocked,
>>locked,
>> holdover, holdover-acq). So what you seek is a way for the user to
>> expliticly set the state to "unlocked" and reset of the state machine.
>
>+1 for mixing the state machine and config.
>Maybe a compromise would be to rename the config mode?
>Detached? Standalone?
>

Well, those seems good although standalone a bit like the property of a dev=
ice.
I am biased by the FREERUN from chip docs and don't have strong opinion
on any of those..

Thank you!
Arkadiusz

>> Please don't mix config and state. I think we untangled this in the past
>> :/
>>
>> Perhaps you just need an extra cmd like DPLL_CMD_DEVICE_STATE_RESET cmd
>> to hit this button.

