Return-Path: <netdev+bounces-23299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A4976B802
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22CA2814C0
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D829D4DC6E;
	Tue,  1 Aug 2023 14:50:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95DB815
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:50:52 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52171122;
	Tue,  1 Aug 2023 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690901451; x=1722437451;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rWm4JCgihsFm4r3h7JFxMUVneJGmmNknhKKkj+dNq/g=;
  b=gPNkEp+pAHq9lE40YvXw6zPsmVsC89U3tfEFkpwnN2bk1Ijksfn0Eb1T
   /OoD9BbrlKCChqq2+EBsV97BMLSzep1pUmQLBG9wlKeqgT4nivBG1JTCg
   EJnj84ufaB7BJ834ODTU5aubYa1BiuFMFM3XCc5kONsuml7b5YtI04Vf4
   gg68ebJDnCdk29y0Gu3asl8TjSJ7AvUdHT8PrPg/dRiR9qZIIePsOizxh
   qixQoW3jq1lk/WE7zbW+cTViSbDpqE4nyfXgPwj4mv+k8Qu1sXJhdIcTC
   bGTNP1eZLx1yjRokhOEeX//wM7fG29cLKXBbm6nJy4L0M5iEgCRU8L8aS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="400265783"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="400265783"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 07:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="678692455"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="678692455"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2023 07:50:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 07:50:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 07:50:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 07:50:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 07:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEew9/cQEuMxWoD3I4jMfdxnNqfcMORzyYI5Q3YuMwnDOSb7Yb9ad/X/zj/9beQWaSDvGyIAFsuU1Bd/MmOk+joqksghVYI86YxwfQ5qSREnRQ4/sAD+mQTh7Sk4H9XQbHyaiTlwELvpy4kT67wAyf4A+uUvoO1Mh88xE4DwOHOrYGoFTegN/gGLr2YSHdyiPDDo76yvDtwSX/X4s2h08CwivvLnMZHIhwpPiVWWPT+HxZsFeE4LMTwAKh1o9Rg8h/twC2Dbsiv+XF3y5gdFxCeYqyLA9tKNpzS0A/jmz7w3Tkqi8P1LJrZFRXzVFB1wyA5bDONOfqKOXfhLWFqw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a+5jVGFgIqgx1+RiGGqZ9msUxrG8xL/hoov186ayI4=;
 b=Sv5bcVWNZ+QSDDyA/zND5GAreCz0zdNsenJIn/sq93ahePdZgSm6/gDo7v9DK6gmxhrvV/g/GNlv/96NIf9V7wNk/3bDJ+BbWxnLUtytbzhDMmyc/skgd65NzMYBjCkjHN3jookBJRHnXHpsFMmA13kNdGllesMJfyEy2v74veajUUzhJ4Y6zznmaeThqrkLBAMgjn44lfySTWkxDDfO+6RwmIEbspfYP3YTe5o7mi5NBnwo8K2ivl/zqqpmt4q8VioIqKunnUTKyfIGau+9EzCuI/rTgoJfb1mrh91ND+KigcZQ/BsOQDIUtcS1MeHVnxhK5QGAuc5it9lBFswMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CH3PR11MB8658.namprd11.prod.outlook.com (2603:10b6:610:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Tue, 1 Aug
 2023 14:50:45 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:50:45 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
	<kuba@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni
	<pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>, "Michalik,
 Michal" <michal.michalik@intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Topic: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/EGiaAgAu/VDCABANBgIABtWkA
Date: Tue, 1 Aug 2023 14:50:44 +0000
Message-ID: <DM6PR11MB4657C0DA91583D92697324BC9B0AA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLpuaxMJ+8rWAPwi@nanopsycho>
 <DM6PR11MB46571657F0DF87765DAB32FE9B06A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZMem35OUQiQmB9Vd@nanopsycho>
In-Reply-To: <ZMem35OUQiQmB9Vd@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CH3PR11MB8658:EE_
x-ms-office365-filtering-correlation-id: 6528e0fc-bd1b-4f7d-ebcd-08db929eaf79
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPojwZFLDIYrFVkNY1uCsqUim1h82ZcmEv5aQYAmyRnrs5zYCTYkTpJnufTbkRiodltGOwbP/pQRk5h02+ELHVmEHx8A2iN7RFEP2IFeokADhzkrE4uj4WZ7Ld1I86+uNSlberGExzBTOX+hEuxC9rvRWAW0OLZT7PvAWTBZrh9qONuJghfgJ+vLmcG3kIotX0CkFm/myBqP/+ef8qRgopQjzrjvLY8m0WJvD6yG3zKELQt+LPdHlIq4Sn2xoSMlGbE8R1Z0TW+GevvGqaGR0jbSK0B6lHONENU1xZndN7FTppvEGqUAc3a/GevJBOyLTtF254juWSh9aaXxu9HzRLMiNEBrhRU68LHVuXjn2RRqrQx+F9rAW7K33a29k7G8eFZhT4JN0+jo9n6EwiF3Y/0twLRpdp6YMq/+2YLFkfl1dJqKbiHdaZLQiLUo834fOP04vJgatOxegv4vligJFUqQ8gbLHcp6OiuDTRuYEJs+cv+GmRT6AuHInYrhUdVovCbUEpjyw91K6iK+N1PHzT8dLb5gLabOFP6ppLgXRlHH2aEYfQsahHenqo4n7rrxYLiQpyEI7/lmywYgisSgjoYkChJpb9SvztdZWI7mZX4XHmDIs5r5IigRWm065DfJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(38100700002)(66476007)(86362001)(8676002)(8936002)(316002)(64756008)(5660300002)(4326008)(66446008)(6916009)(54906003)(7416002)(122000001)(33656002)(52536014)(76116006)(66946007)(66556008)(82960400001)(41300700001)(38070700005)(478600001)(2906002)(71200400001)(9686003)(7696005)(6506007)(26005)(83380400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6oSVZ93JBVDSL2GZaDVHXv1LJ6TLtcgFxoOFk92X98z06nwto9JlfutDcRxc?=
 =?us-ascii?Q?E3OleFrKrCuVWRR1GC5qqIIqHQBytBqYJOLBUf7CiZadlGMkWjjelOJs4q4H?=
 =?us-ascii?Q?9hLFRQ9XOuF4kA2E7ehJo2OhJuMgyfxEGBk8t3UIoqUfsn1/KJssuJGYfnpp?=
 =?us-ascii?Q?25dULBPYzleONeD56YVrpcZ5UtGyBm3wGPHKNfxDuCBwWGujfptFWScIeYv7?=
 =?us-ascii?Q?6ktzgFF6IQJ8BioxXFBC4OHPmoy74UwIXLGwWNq2FRifQ7Q6+pHXqh4JOP8A?=
 =?us-ascii?Q?T80AmvMMpG5rGAoIPITpL84nB2WP9XdIy9iDDl1PoE1mfwKHgEkto/8CUnFE?=
 =?us-ascii?Q?yzzVP2u5a4QzjqXbpI9e0m79Ul3FvzOYi/kXNOzp9TOM6V4HS7ovb/uokHvh?=
 =?us-ascii?Q?gryb11dHO594aZbzFHge/7radq6xyCAuSUMF4O27kAqiHUGKA/A7NQV6D76Q?=
 =?us-ascii?Q?SHxyA0LL4kEmIn+primUVK7SS47HAYnW8bfB9GHNk2MZXLBzSvvKhP0vbNeU?=
 =?us-ascii?Q?HPLjU0wvT/kZ1KHUKmT3UiUv1CdzOkd5MF9Mi22powIojD7CsRxeDhueXmR1?=
 =?us-ascii?Q?OoMIG/WsRSbyQFUcxO2UssdQCC0M1Bz5cVsPp5U77PWsd0d/BdqMMbQt1Jv1?=
 =?us-ascii?Q?77xCoraLSLFEJ3pI2BXwb7XBbLEAuDGTBYDc0sAzeEMeQwLWG7VzUEDCZ/BC?=
 =?us-ascii?Q?6lm8Ja33hNTd/T1gmtLwV8DfRDHEsWIVbEcXMDN3rUNNMqkyvGLHEF2q2EWT?=
 =?us-ascii?Q?ImrnkbKGrfIEtUicvbG2/v19jb5O8yMlNWbyQXMnFfxlZVp/PT1WuTfS1UVu?=
 =?us-ascii?Q?1pEh9GOZfaBtCHolaNIGhwAxjcsUgArL8MSkjkCShIdMcOkqwqgWuW7x2KIA?=
 =?us-ascii?Q?tQNU2GAm5OixlpjRxVwzwAE86gxeS9HOZVWoVMNzWC9pLd7HQ5exvweMiw4v?=
 =?us-ascii?Q?fye3eJbyoTmKoIjZHD1dvdFdZ6wgrHX6rpQsMRZko24FmHbBIrX6mriRtTao?=
 =?us-ascii?Q?P/jeyRlOFAwC0DgG13mhRjeClcZK36qgn8ya3ud6Wg1gEoLyHbjsMTUaRo2r?=
 =?us-ascii?Q?7liP1c+mfBQbUNh5wj8fsDWQUgiELd7SzgbM4/C+bYJJ8KEQIyrbFHT0K6F7?=
 =?us-ascii?Q?2eL70b+Gsre8EFyYZpGYmPiDs2eQRpR4qzwOnwrZMyTpnI1789RzOVj1usiR?=
 =?us-ascii?Q?HTO6EZAWJJeEAitqMKPUHhm7N5u4sNcW5jJT5bSyq3hf9b4GOX3MI22QtasX?=
 =?us-ascii?Q?r68QBthi0y30yn0gCUcSLg54JxeKZOQAY/61Bkb94mbKABQzDDuPkd7vtcun?=
 =?us-ascii?Q?JfBxAC9+UJDg+pyBNmH1EoIA26s7/IJdCw64567SKshL2/rRnlkKu8O8PtqX?=
 =?us-ascii?Q?1nzalZGBmZZT4+T25geyJ1oQDVYDZqpnTdKnU0uoYVIadj9zasKciMK2/pWe?=
 =?us-ascii?Q?pVZKSaeT5b0D2wdMeXhmg53rckp46A4B2NgIXBo/bhOWoIPSgEvIDAA1yAEx?=
 =?us-ascii?Q?1IgVdHwmEcZiBk4hpNstGVIrNPVfnUdeTMrhc9NbOwMwzcOY5z5R5ofzZDm4?=
 =?us-ascii?Q?9YXqzVmc9Z+B1MBOAdKmzUF/jmqHbTt4o18EvyJPuUxXJYu7+WmgIsvY0DsM?=
 =?us-ascii?Q?YA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6528e0fc-bd1b-4f7d-ebcd-08db929eaf79
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 14:50:44.9418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ze52gx0UKV62KOmLJMZj19e2sLvTCe76IfxhPdtlYEZb0HxxE54kBsnyuTlLxBiqUVvL8+GFTkgNuMGcvhT/QEpFWAiEvQH2sOxu8TGwPDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Monday, July 31, 2023 2:20 PM
>
>Sat, Jul 29, 2023 at 01:03:59AM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Friday, July 21, 2023 1:39 PM
>>>
>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>
>
>[...]
>
>
>>>>+static int ice_dpll_cb_lock(struct ice_pf *pf, struct netlink_ext_ack
>>>>*extack)
>>>>+{
>>>>+	int i;
>>>>+
>>>>+	for (i =3D 0; i < ICE_DPLL_LOCK_TRIES; i++) {
>>>>+		if (!test_bit(ICE_FLAG_DPLL, pf->flags)) {
>>>
>>>And again, as I already told you, this flag checking is totally
>>>pointless. See below my comment to ice_dpll_init()/ice_dpll_deinit().
>>>
>>
>>This is not pointless, will explain below.
>>
>>>
>>>
>>
>>[...]
>>
>
>[...]
>
>
>>>>+void ice_dpll_deinit(struct ice_pf *pf)
>>>>+{
>>>>+	bool cgu =3D ice_is_feature_supported(pf, ICE_F_CGU);
>>>>+
>>>>+	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
>>>>+		return;
>>>>+	clear_bit(ICE_FLAG_DPLL, pf->flags);
>>>>+
>>>>+	ice_dpll_deinit_pins(pf, cgu);
>>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
>>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>>>>+	ice_dpll_deinit_info(pf);
>>>>+	if (cgu)
>>>>+		ice_dpll_deinit_worker(pf);
>>>
>>>Could you please order the ice_dpll_deinit() to be symmetrical to
>>>ice_dpll_init()? Then, you can drop ICE_FLAG_DPLL flag entirely, as the
>>>ice_dpll_periodic_work() function is the only reason why you need it
>>>currently.
>>>
>>
>>Not true.
>>The feature flag is common approach in ice. If the feature was successful=
ly
>
>The fact that something is common does not necessarily mean it is
>correct. 0 value argument.
>

Like using functions that unwrap netlink attributes as unsigned when
they are in fact enums with possibility of being signed?

This is about consistent approach in ice driver.

>
>>initialized the flag is set. It allows to determine if deinit of the feat=
ure
>>is required on driver unload.
>>
>>Right now the check for the flag is not only in kworker but also in each
>>callback, if the flag were cleared the data shall be not accessed by
>>callbacks.
>
>Could you please draw me a scenario when this could actually happen?
>It is just a matter of ordering. Unregister dpll device/pins before you
>cleanup the related resources and you don't need this ridiculous flag.
>

Flag allows to determine if dpll was successfully initialized and do proper
deinit on rmmod only if it was initialized. That's all.

>
>>I know this is not required, but it helps on loading and unloading the
>>driver,
>>thanks to that, spam of pin-get dump is not slowing the driver
>>load/unload.
>
>? Could you plese draw me a scenario how such thing may actually happen?

First of all I said it is not required.

I already draw you this with above sentence.
You need spam pin-get asynchronously and unload driver, what is not clear?
Basically mutex in dpll is a bottleneck, with multiple requests waiting for
mutex there is low change of driver getting mutex when doing unregisters.

We actually need to redesign the mutex in dpll core/netlink, but I guess af=
ter
initial submission.

Thank you!
Arkadiusz

>
>Thanks!
>
>
>>
>>>
>>>>+	mutex_destroy(&pf->dplls.lock);
>>>>+}
>
>
>[...]

