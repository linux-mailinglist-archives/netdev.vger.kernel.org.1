Return-Path: <netdev+bounces-23696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E5576D2C8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEF9281DB8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572B6C8E5;
	Wed,  2 Aug 2023 15:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4376B8C0C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:49:07 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F6B1BE4;
	Wed,  2 Aug 2023 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690991345; x=1722527345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nwbBHYYr7OWTHxsivBFsP2KC+WDeZExF38FoFv0GsZ8=;
  b=AcrgK1DZczVi4cevkd7AfDIfqQcaPYqQeRFufETyjNoc/gcKshJnZM5I
   PP5zvNJUOj92uiLlSPMW2vyLVZWRrnCTvjzbRTOijPb+NlwYFuq1+RlId
   SX6ErG0JJuWf19C0E63OPYy3Hxly/n7AaGqO5zGRXymSKiqvsMqZKvI4G
   IZjaqzkP2SqjSiwGZ+3EpzYD+Wx3C77ww4VmTCMd78UgOl0OUBpxqovbl
   nxq207OuHPJUG69P+lui0mqsA3q+iYubP9ZmHNGjm2kIFuvdyfu50VuSA
   tfH7hA499IExi9L+Qk7qfxeW/4B/sVfo1Ai2suDhGLhCav7mNEr0VWIim
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="349922565"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="349922565"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="819265673"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="819265673"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2023 08:48:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 08:48:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 08:48:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 08:48:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 08:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/HoHYW5U1Y7NH93nR8sxKQbCfybrPBkaQW2fsSreMimRgOohEfWKDnKiDI1HlwA3o5J0Ff/YtPxzPS8IX/C3Y7JVrVL64Oo9DBWv9Dz3FWA66adzy3h+6KqPj3gFxh+WbCUavzKHP9SxaIJWEZ9tmmZCjq3BYssV2EigXPbtQMWUw0nNs+1mETui8tJc4/bEnbcnpiT+9iU1Ijjr70XcJaXCJDz84hX+aLSmh9cuV14O0H4/zHzRPBdQAWpr8zIxhs8LEG2rQneIgUYmNs1LDg2hb7JEwg6RLPEvFLQIov0NF8Q+XoWQ/qDEtty+z0BltcUAgG+efS0jqMfvIxvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xU+idUmAYtpApZPHDcaukmLNeUUo73mLe1AIDBIUHQ8=;
 b=iLp+YiRMjDEKUCxv8ertbgHjkkCPwNCH5Z09+cASgvz6XH8eGJuAkPM/sje/ehqDWuIdK1idMfAnO91OWjD2oYbDeTwu7tx2rUq29eciVV5/T3BWc8XzIRxN4yVB6Hpr56U04DHlCJOhf4Yyf3M10lpHpE0LiOgXIGmdlwBAHc6Xu8DAmalq+dukgM0DWRDAue3rq7zIR3xIrU+c2yaYaeLbKxm2eXLV7iGbR5s5LpKaJw7fChOAqgvwYdzkdqPhSXbRjhKjCxfn5/ceHUv/DKe53JqwAXE/+5OI4N1FgqRbFLKwxLrw+VLzMqYdSPXZ5uCgFFmCSRV62KfkqzJGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 15:48:43 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6652.019; Wed, 2 Aug 2023
 15:48:43 +0000
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
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/EGiaAgAu/VDCABANBgIABtWkAgAEVMACAAJH3YA==
Date: Wed, 2 Aug 2023 15:48:43 +0000
Message-ID: <DM6PR11MB46575671FF8CB35795EAA0669B0BA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLpuaxMJ+8rWAPwi@nanopsycho>
 <DM6PR11MB46571657F0DF87765DAB32FE9B06A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZMem35OUQiQmB9Vd@nanopsycho>
 <DM6PR11MB4657C0DA91583D92697324BC9B0AA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZMn+Uvu8B6IcCFoj@nanopsycho>
In-Reply-To: <ZMn+Uvu8B6IcCFoj@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH8PR11MB7966:EE_
x-ms-office365-filtering-correlation-id: 4e77c17a-9891-4c39-5e1c-08db936ff335
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LZvp6NHABYkQstdRajyAgKdoyOOybfH6R1nQ/rWmz/HjNxLEkCRdR1d2m4xXXA6b9u0mliyqQan1jg47rU3pn+EOogMtid1N5D46gU5t89p7uWkdb0C97am8j8dysuC/iXNtMblqEFkfOIqOyPO+GamLL5LXS6NA89tLwtHZgQfNtzc+DgGrAgoAf61F0965OjvI+8Tkrfp8EiVkVhVUUpSg9AMMYObzddxeDdsJwDgdl8086SsVVmg1moAJg5r+vouUuHafSA5fzLPhPn75datgXdZ9yaWagquQ0oJw8oXT6hH2DG4z98kBwFjBtzIomjSQqdceJqOlg9HnjeeCcjtz9KLfYFx6zAyCq1DOn+hoMitj1CdsQ81qJ3XcO++G2o09d7QfVyVCL5QBV3ZQRrXKS4cd3ZUzYQeqM7bMb4lRj7WuMsn4ezQqKpbjI4z3ok+W8x/MYAPo29DRo/TpJR64HniLVajipMRmHppuJOoL64DReQwx9n0cYKPl7vCz/VUCAb+LNotUBIVM1igEqNvf2TR+KC2OZUMzhJRsdufwj5EKVoybi0CZvXJzpZQDTzLLipxHu81mgfMb7xJaAJmhUru/5Kd/Go+hfS0lQw58g4ZhzsULez8D4k89asQm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(5660300002)(122000001)(7416002)(26005)(83380400001)(38100700002)(82960400001)(41300700001)(316002)(186003)(8676002)(8936002)(6506007)(38070700005)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(76116006)(2906002)(9686003)(7696005)(33656002)(71200400001)(478600001)(52536014)(54906003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0w+cQZBrF/yexrM6E64cvBPGGG3QY6KoUCmjZ9yborexFptYo9CotpwZozTy?=
 =?us-ascii?Q?Zma7qK3E2yyjgNA7Hbzag8IoaJ3yq2gut5lVtdUOFC8izGvux5HeFHwovAwn?=
 =?us-ascii?Q?ftmNl8BZZVKq3YLfZU3bIw/tYKFFGjSeZbDyI6jr1BqCP90mM6gvyZ6dFxe0?=
 =?us-ascii?Q?k56eORHYBFZy8P+zDZWczTzpv/SQ+y0ENKSLs+19/0vXxFPbL9tX16lsk4sf?=
 =?us-ascii?Q?Xn3aeIJl6jMLh0ScBtd8xCp5QaBuA18SgvLXx/ysQ+n9SwdvH9pbopCXN8xA?=
 =?us-ascii?Q?dNiZMdZLZ5CmoXXFBeNIO8LAJd4WR7yg5jx8tAx8luLG0aLfTy7RoXPSjCoV?=
 =?us-ascii?Q?NtUi0DmWd3w7bpVThLS6wXFSho0oqwcEPgZaJIrCe1gJyj3F0pcYrUS05hNS?=
 =?us-ascii?Q?oXL7SQ/e0W1DHdnkDyOQrQOPJIwZHM+y41hyuvC0lnAkm5Jyq5PRl0Ms57nZ?=
 =?us-ascii?Q?QLO6n6jCq16pZXVyTAAaasltJ+KPcdw6b6tPS8nNwl44jl5iGxW60mKCjGCY?=
 =?us-ascii?Q?w0HaVuwzYw7DHxAm0pseEoWeUrLnMg8NJvhv5nAL1jco/J8uvBvxd3zqnpi2?=
 =?us-ascii?Q?TWur1xUjMSZH3QMz2P+cHemoMYK2zdQG+GvJhs0ouk2hddx0X48TEfd9irun?=
 =?us-ascii?Q?agXrelwGF7H7NkO3AtTEYgez2nELtsfVdF2kZQfqiNi94vy8hNj04b0MTq5L?=
 =?us-ascii?Q?fC000/1lKu9huDX+MsX8knUbIF6BiSo2d3AdIk1ijOJHltGr/Cy3RTqgXKXZ?=
 =?us-ascii?Q?Uue5TT8+QHcOU5Kf9faSSdbrHXLqcvZvZwvTvlS6Tg2f80phhirrvG1U1XCb?=
 =?us-ascii?Q?MJyXcSDTt+AsccI+pfvx0rMBlEFIyQ6ywtxegGywr2PmQZaDX44D6U+RaoFe?=
 =?us-ascii?Q?14KGrtGl6c6CHX+fPouseRXRso6ZUAOSM0oXfRPVTCJ1puQlZMFBYRcXZnD6?=
 =?us-ascii?Q?mu/ZV2D4DVfA0habVLgPNPTrakq8iMxHbT5DroTGEWewRTwrmm28IlawdbMl?=
 =?us-ascii?Q?MIe/7rTUJnl3piQGiIiZ+sQG3WKU0FaQhCZd+kR/UqMn+vN7rrYrXLv6q8dS?=
 =?us-ascii?Q?u0M4A2KCczErQz2ULYBXWFT4AE+D2hiZBKmEl84x29D2B2vgmC+jJzaOBJeh?=
 =?us-ascii?Q?ZZc5PqN03+EsJU6AuaGERzB32yokoODdv+IOcGuu0zn+hhfC8T9t7cVnY5TL?=
 =?us-ascii?Q?AsYmPBuQt3JRvw7tTyPHq/JYD72fzFpOXGDkx/7awKdo1IXhhLee/23sPtW+?=
 =?us-ascii?Q?CBD9PEqeHEVVQfSk/FEUdprlYL24ujj3Pb2Qa8Y0ahkF7GJ4eCnbxtyInJb5?=
 =?us-ascii?Q?ZdjnRirJ8ooVX13zxyv0mrXu0wbuU8Ef5UpR2KsEBY/3jL1vok3PPQ4Fi/sL?=
 =?us-ascii?Q?i/dUQmKA8GJ+w911HAaiP9hzok6bknrgDfUeXAaxEgRSFX0g6rAyLYelo1fL?=
 =?us-ascii?Q?TrPdrqs1L6Hl7tWwc76ElW1oGz7BThliitjeRk42pZjggQI2HOmeaELFbjd8?=
 =?us-ascii?Q?1TimJuGsrNVhBcbdsq97rd+3NJMLgrsEGlEgtNOhSma/9Awiza+nseCIrw5d?=
 =?us-ascii?Q?t5NIuYt0HoUnUwZArDXKdy62EvzFlIFmzIzfBBE4z9jxtSplLxKmDsl6r/ZP?=
 =?us-ascii?Q?Vg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e77c17a-9891-4c39-5e1c-08db936ff335
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 15:48:43.3489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSxh431Zz4rRPUaal0lVxqLLnB8m25+kcjCjpv/2Z8nhpf+FCcFILV8Gr2EeSMbGRPFJ3sC0PPKTBdVeR205tNHJJXHBtqaWZbHjOMgQZBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, August 2, 2023 8:57 AM
>
>Tue, Aug 01, 2023 at 04:50:44PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Monday, July 31, 2023 2:20 PM
>>>
>>>Sat, Jul 29, 2023 at 01:03:59AM CEST, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Friday, July 21, 2023 1:39 PM
>>>>>
>>>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>>>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>
>>>
>>>[...]
>>>
>>>
>>>>>>+static int ice_dpll_cb_lock(struct ice_pf *pf, struct netlink_ext_ac=
k
>>>>>>*extack)
>>>>>>+{
>>>>>>+	int i;
>>>>>>+
>>>>>>+	for (i =3D 0; i < ICE_DPLL_LOCK_TRIES; i++) {
>>>>>>+		if (!test_bit(ICE_FLAG_DPLL, pf->flags)) {
>>>>>
>>>>>And again, as I already told you, this flag checking is totally
>>>>>pointless. See below my comment to ice_dpll_init()/ice_dpll_deinit().
>>>>>
>>>>
>>>>This is not pointless, will explain below.
>>>>
>>>>>
>>>>>
>>>>
>>>>[...]
>>>>
>>>
>>>[...]
>>>
>>>
>>>>>>+void ice_dpll_deinit(struct ice_pf *pf)
>>>>>>+{
>>>>>>+	bool cgu =3D ice_is_feature_supported(pf, ICE_F_CGU);
>>>>>>+
>>>>>>+	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
>>>>>>+		return;
>>>>>>+	clear_bit(ICE_FLAG_DPLL, pf->flags);
>>>>>>+
>>>>>>+	ice_dpll_deinit_pins(pf, cgu);
>>>>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
>>>>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>>>>>>+	ice_dpll_deinit_info(pf);
>>>>>>+	if (cgu)
>>>>>>+		ice_dpll_deinit_worker(pf);
>>>>>
>>>>>Could you please order the ice_dpll_deinit() to be symmetrical to
>>>>>ice_dpll_init()? Then, you can drop ICE_FLAG_DPLL flag entirely, as th=
e
>>>>>ice_dpll_periodic_work() function is the only reason why you need it
>>>>>currently.
>>>>>
>>>>
>>>>Not true.
>>>>The feature flag is common approach in ice. If the feature was
>>>>successfully
>>>
>>>The fact that something is common does not necessarily mean it is
>>>correct. 0 value argument.
>>>
>>
>>Like using functions that unwrap netlink attributes as unsigned when
>>they are in fact enums with possibility of being signed?
>
>Looks this is bothering you, sorry about that.
>

Just poining out.

>
>>
>>This is about consistent approach in ice driver.
>>
>>>
>>>>initialized the flag is set. It allows to determine if deinit of the
>>>>feature
>>>>is required on driver unload.
>>>>
>>>>Right now the check for the flag is not only in kworker but also in eac=
h
>>>>callback, if the flag were cleared the data shall be not accessed by
>>>>callbacks.
>>>
>>>Could you please draw me a scenario when this could actually happen?
>>>It is just a matter of ordering. Unregister dpll device/pins before you
>>>cleanup the related resources and you don't need this ridiculous flag.
>>>
>>
>>Flag allows to determine if dpll was successfully initialized and do
>>proper
>>deinit on rmmod only if it was initialized. That's all.
>
>You are not answering my question. I asked about how the flag helps is
>you do unregister dpll devices/pins and you free related resources in
>the correct order. Because that is why you claim you need this flag.
>

I do not claim such thing, actually opposite, I said it helps a bit
but the reason for existence is different, yet you are still trying to
imply me this.

>I'm tired of this. Keep your driver tangled for all I care, I'm trying
>to help you, obviously you are not interested.
>

With review you are doing great job and many thanks for that.

Already said it multiple times, the main reason of flag existence is not a
use in the callback but to determine successful dpll initialization.
As there is no need to call unregister on anything if it was not successful=
ly
registered.

>
>>
>>>
>>>>I know this is not required, but it helps on loading and unloading the
>>>>driver,
>>>>thanks to that, spam of pin-get dump is not slowing the driver
>>>>load/unload.
>>>
>>>? Could you plese draw me a scenario how such thing may actually happen?
>>
>>First of all I said it is not required.
>>
>>I already draw you this with above sentence.
>>You need spam pin-get asynchronously and unload driver, what is not clear=
?
>>Basically mutex in dpll is a bottleneck, with multiple requests waiting
>>for
>>mutex there is low change of driver getting mutex when doing unregisters.
>
>How exactly your flag helps you in this scenario? It does not.
>

In this scenario it helps because it fails the callbacks when dpll subsyste=
m
was partially initialized and callbacks can be already invoked, but in fact
the dpll initialization is not yet finished in the driver, and there will a=
lways
be the time between first and second dpll registration where we might wait =
for
the mutex to become available on dpll core part.

>
>>
>>We actually need to redesign the mutex in dpll core/netlink, but I guess
>>after
>>initial submission.
>
>Why?
>

The global mutex for accessing the data works just fine, but it is slow.
Maybe we could improve this by using rwlock instead.

Thank you!
Arkadiusz

>
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>Thanks!
>>>
>>>
>>>>
>>>>>
>>>>>>+	mutex_destroy(&pf->dplls.lock);
>>>>>>+}
>>>
>>>
>>>[...]

