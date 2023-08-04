Return-Path: <netdev+bounces-24329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBB876FCB2
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C4628232C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143B9474;
	Fri,  4 Aug 2023 08:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D1A923
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:58:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB53526A;
	Fri,  4 Aug 2023 01:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691139489; x=1722675489;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R2vHJS4tAeUfKyf5nyjxTOXpiqJnALDnVSjxjGVMXho=;
  b=JZTDHuNHd1P9KINynojeQq3DUEqIhK/zEmleSoKXQPL4+dmr+YhnwjhA
   kk0l014e5gKugdyWEGiaD2vaciFfY+Dah74mxGZpCEaF7wnhp9nBLGpHA
   QwSewScs51EdWdKASkmeRoGjizf0Y61FmNwYKWPXQSsNDFo7ShXoza7qZ
   NV3aIzj425GoiXmLSSTyFdHtFPKWaTaG+AJb+xsjZmm3iuKttOUKp4jZ5
   pkGRhcUjauAE27JMCB+Ag6fEtVos5AnqIJ6BZ2JioNMiQcVrk28z0c63+
   DwF6tUhl23eobnDznTK1ojn80wReOgFDZwK1MXx8yIFb962xfqeABYNA0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373757219"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="373757219"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="853660051"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="853660051"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 04 Aug 2023 01:58:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 01:58:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 01:58:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 01:58:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us3jlpuCXjZooo/Eb2QuKTICT1xTvqhN7KO1AfhUhqzE1uy0nlyQYTn8PkboxMasEeYsM+wc5+k4dE7m7p7TUTYpv31a3XZx1orE73IvOOVPdF51YKkuDjuMStqbeFA1bxp1qMOogiiWJoRcrCcJ2nb14Mrwe/Ap2+UFmoZg0A2/+hGMAk9Ac9HKFwhdusAdXsfJDwemWrLwycwEhkOJC6iOgZkLCQSTfcUDNTdJgh/GeTBE052v++z/6GmmWvuZrbPlY/M76AEgzqJH22j0VrQ+ITwBQMiu6/LLQPvIv93X7irBPj4ExJhGlhJg4dQbLQWsa4d10TRv3fHgauxBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bgywg256AsJdpNqXOoHZ6/MEbpwnkCW3Eb1xRXREEe8=;
 b=lY4yu39dkjh02l6VDhghF0gFj4K4ZX5QquwH/pnp9V7ZaRPYi/9bA19QBJAnwej89KIx3Qwp14mzbXS03Y6qdw3O+avJ0FNKj8mR70UNkUmPAnOXScb33yijOj01HhQLdW6ZmPgjq1YEbye11NzQp4O9+VfLxDwyAvzknqIR4I78IWOrVh0o3s758ayP2q1AUJJY79hPkQdsQNRkMggJZFYJ3Y4hDE45HVIDjsw9Nv5rpivVioqOL2UP/qwSTmG+B0eO1Ij/l5ZsB7bZvPs6SDq3sXGXCbVs7KwinmdXfqp98GX2010spG+GVboPtGdBorb/689Qj6mg4ERGiVDrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CO1PR11MB5075.namprd11.prod.outlook.com (2603:10b6:303:9e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.21; Fri, 4 Aug 2023 08:58:06 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 08:58:05 +0000
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
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/EGiaAgAu/VDCABANBgIABtWkAgAEVMACAAJH3YIABEpoAgAGdQFA=
Date: Fri, 4 Aug 2023 08:58:05 +0000
Message-ID: <DM6PR11MB4657DAB437CE3760FC1CE8C89B09A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLpuaxMJ+8rWAPwi@nanopsycho>
 <DM6PR11MB46571657F0DF87765DAB32FE9B06A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZMem35OUQiQmB9Vd@nanopsycho>
 <DM6PR11MB4657C0DA91583D92697324BC9B0AA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZMn+Uvu8B6IcCFoj@nanopsycho>
 <DM6PR11MB46575671FF8CB35795EAA0669B0BA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZMtfHn8es60MSMj+@nanopsycho>
In-Reply-To: <ZMtfHn8es60MSMj+@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CO1PR11MB5075:EE_
x-ms-office365-filtering-correlation-id: de82063f-4246-473b-6b8c-08db94c8eacf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: skFXIcWcjgy7vIgV7vy6Vec8ZK25qZEtjtyULG8IbyE7paAOSRi5vfH997Vxub0THywTZhZ+gcfzQObGXuUYfrvipi3gD34zpyoCKSUvMbqTta9LmxUDaV+6JdN/XSHyF3674QhZGQEt3Lm1JE0uWCcQylSw6PHzW2L7oOz2QAGIo4hbIvKjD+jyMgWAV7hfh+7WpIj2qVVyAxZWd5jhAznFxgGtN6/u3ClJh4p1aEcAh5SKGB4eKKY8WJzUl15u1BSnnSYhkUCD7agMjmcATOazaxLdBBZl6I2CfKCyfBoUM/XSuyySlS8KuDOClDTObXwZvIIeCuONbdGUPmMuE0KXxpbOlcrEumWhwaQi+HB0kM5nLkXe+Hn9EjY/GwxnlEKQTHnqEkR9GZsqkyvbtCVP5yVmJDrE/ZkU/oPtraQwgLFlK96bWBMTTCVEJNpcy+veYqC7B4KggOfvwt7UBksaN6Yfeo3GEQLvx9QhD/b5fLYcb4/YMTzG4tJhBXJ2M9w876iSvh1YyL8mZgNIj4GRtO6nhny/jwlO47KJ4Yq4uRINTmCYFfJphd60pI4tYrBeF7ShVAzQKHe1XFbW8gVl8X1YiLLcjbgdao6Yj3xdo+M4yfnQS4e7nmZe5eEA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(346002)(366004)(396003)(186006)(451199021)(1800799003)(7696005)(38070700005)(9686003)(86362001)(71200400001)(55016003)(6506007)(26005)(83380400001)(38100700002)(122000001)(82960400001)(33656002)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(76116006)(6916009)(2906002)(316002)(5660300002)(7416002)(52536014)(41300700001)(8936002)(8676002)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hks6t1DMuSM5VId9vleO43VUh+/9zgwIIlvi5OWnkCSwQwbUJ1ccrFqjd0QI?=
 =?us-ascii?Q?JCHm8GXYfcPrPOsb17KjhzCn0oHy7uzgButXK+dbiiG4pifTuYX5uYDetFi+?=
 =?us-ascii?Q?kU9saapjwgqYcgu4Sc0Xs3SWSuPyjA+pGPC87NyfEgkOV7NEP9U2PQv1UH/W?=
 =?us-ascii?Q?sNO8l52ZfPnIma0ldX6cjRh2rKOJBhcid+ekFWkkNL1rQCBQU82ff6BceEjA?=
 =?us-ascii?Q?MaDyR5yxGZ1JggA96ycT/6b5nqmV1dHusfal65ANnIIDPOZac6MAUSP1xWtP?=
 =?us-ascii?Q?oEGlhrXnAw/+iuGA9xaGPlBoQQ122SxLJtxSD0pg/ifa1w4nTgrVOXIR5XGx?=
 =?us-ascii?Q?U6bn4DngGEGvOCXX6hiLpWeFWkLfPjfuZiFdjA7ZYlgDfwjpEY10kOuh0Hsz?=
 =?us-ascii?Q?4/HVTGVvk5gttuNEGLDMIUxUnWRYubdXBaw++6eh1Rfqy4YxEwKYd//PPeqL?=
 =?us-ascii?Q?Eidy+7Gad3ktEsh14WUpBPKt387j/7WYUX0DG+dXn14JwO0peTuzbKULno5j?=
 =?us-ascii?Q?0XkSFgKcRm/ns9rPn85Ptdh0hx+lmyu8zVyTO8KzVI/BX1yDCLUmfin4rmBY?=
 =?us-ascii?Q?L5ZubIJb1BwpUSBGXVp2zsXbF7QWTp8n25BRNI+TLJOFwmi8qSaMkNHWQO8B?=
 =?us-ascii?Q?oT1ySO8/jcczGUdtAuTGLR94Dp7uvI6NVDhoX52OmJlZ7ua1kfWbF+2eIFyD?=
 =?us-ascii?Q?9C5ks9ulAUf5khmYG5xP0DmgOVGGiQuba9x1I/jF2cPf1n7DUZ2MFePg2HB5?=
 =?us-ascii?Q?vdywGx8966zS9oZQXO4SqCjD2mtNc6SpQF38YR8SU5F/kp48EjuvyUIU3R5I?=
 =?us-ascii?Q?7LqvoYiiVbxTwGp2pJEfX24iMeZdLIoVqvc1/B0vRybUGA/CEZbnEv10dtto?=
 =?us-ascii?Q?DAsRvwXw24MgW5Y9B6J8P5LseRVHUIljFJl5fXMo3BbvOVEN5siay2nweap9?=
 =?us-ascii?Q?YPR7NzOTgRpxZuHPVQUBBs2sSwmjZq3SikYEO0BoPRUTkwGXl5yGoHWkcAlR?=
 =?us-ascii?Q?FGUWaWYBjR2Qzp1liaJ6UUK1nlNVXL1mKIBspwwwQb1VfezerXy9roHl1Zcx?=
 =?us-ascii?Q?3sR1//Z7tYlNZnAnVQ9yTGuIYoTM5DYyOP2v5AooeDlt17fkNSv92wu0Ptvk?=
 =?us-ascii?Q?ssV6kpb9Xo8QGlWTuCfWpktEaAHroPuqowZvB6lFmWWs6+aY+3SbVdoM2tiw?=
 =?us-ascii?Q?1eHE3S7Pmh97adTUZAD02XSsCY5qR0wKzIUI6+rfGF1bPKj96Cez93EpJcdW?=
 =?us-ascii?Q?GvtEZMDWxAYgFX66OZODZyf+mw4GbzwF0sPBO1W37qiMm5qheBpNgJCrNunu?=
 =?us-ascii?Q?s7bowfdTPFgm/uRA5Kwd0EK09OdRmHtmVcLAQ1qh3UBIKpHScskCyFUKhs64?=
 =?us-ascii?Q?mN5IuPYjT1hdJQ6H/QwMacfOuqnKTbsTuBrp36xPZkfH88VlcWLbvxxxBYWT?=
 =?us-ascii?Q?AAKXJ+35+4Cfd3783MJ+/+aqjIo00qATKGugAG5QRuZtkPtu2btVnV/WxsKi?=
 =?us-ascii?Q?uJ3ItQT1/tWFiClYmmUDopN2MOSCFUqhvjK2jHha5R0wZUs4GV65slFsVQW1?=
 =?us-ascii?Q?wpfw+tw4W2RJ/7Aj0AMkxd9Bk65wNg8qNFijWDuuf7/yfckw+eWwLMbX8/a9?=
 =?us-ascii?Q?sA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de82063f-4246-473b-6b8c-08db94c8eacf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 08:58:05.6420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLfxx+2+GhDvveVrzWDQ/b39IzanpPw4RzxZMud5q5JvReR27QA6S2d5yaMGqwhzkVVaq66BiCTp2781FZwzYQPy1nwxBd/8CFHxyQnB2KY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5075
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, August 3, 2023 10:03 AM
>
>Wed, Aug 02, 2023 at 05:48:43PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Wednesday, August 2, 2023 8:57 AM
>>>
>>>Tue, Aug 01, 2023 at 04:50:44PM CEST, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Monday, July 31, 2023 2:20 PM
>>>>>
>>>>>Sat, Jul 29, 2023 at 01:03:59AM CEST, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>Sent: Friday, July 21, 2023 1:39 PM
>>>>>>>
>>>>>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev
>>>>>>>wrote:
>>>>>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>>
>>>>>
>>>>>[...]
>>>>>
>>>>>
>>>>>>>>+static int ice_dpll_cb_lock(struct ice_pf *pf, struct
>>>>>>>>netlink_ext_ack
>>>>>>>>*extack)
>>>>>>>>+{
>>>>>>>>+	int i;
>>>>>>>>+
>>>>>>>>+	for (i =3D 0; i < ICE_DPLL_LOCK_TRIES; i++) {
>>>>>>>>+		if (!test_bit(ICE_FLAG_DPLL, pf->flags)) {
>>>>>>>
>>>>>>>And again, as I already told you, this flag checking is totally
>>>>>>>pointless. See below my comment to ice_dpll_init()/ice_dpll_deinit()=
.
>>>>>>>
>>>>>>
>>>>>>This is not pointless, will explain below.
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>>[...]
>>>>>>
>>>>>
>>>>>[...]
>>>>>
>>>>>
>>>>>>>>+void ice_dpll_deinit(struct ice_pf *pf)
>>>>>>>>+{
>>>>>>>>+	bool cgu =3D ice_is_feature_supported(pf, ICE_F_CGU);
>>>>>>>>+
>>>>>>>>+	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
>>>>>>>>+		return;
>>>>>>>>+	clear_bit(ICE_FLAG_DPLL, pf->flags);
>>>>>>>>+
>>>>>>>>+	ice_dpll_deinit_pins(pf, cgu);
>>>>>>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
>>>>>>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>>>>>>>>+	ice_dpll_deinit_info(pf);
>>>>>>>>+	if (cgu)
>>>>>>>>+		ice_dpll_deinit_worker(pf);
>>>>>>>
>>>>>>>Could you please order the ice_dpll_deinit() to be symmetrical to
>>>>>>>ice_dpll_init()? Then, you can drop ICE_FLAG_DPLL flag entirely, as
>>>>>>>the
>>>>>>>ice_dpll_periodic_work() function is the only reason why you need it
>>>>>>>currently.
>>>>>>>
>>>>>>
>>>>>>Not true.
>>>>>>The feature flag is common approach in ice. If the feature was
>>>>>>successfully
>>>>>
>>>>>The fact that something is common does not necessarily mean it is
>>>>>correct. 0 value argument.
>>>>>
>>>>
>>>>Like using functions that unwrap netlink attributes as unsigned when
>>>>they are in fact enums with possibility of being signed?
>>>
>>>Looks this is bothering you, sorry about that.
>>>
>>
>>Just poining out.
>>
>>>
>>>>
>>>>This is about consistent approach in ice driver.
>>>>
>>>>>
>>>>>>initialized the flag is set. It allows to determine if deinit of the
>>>>>>feature
>>>>>>is required on driver unload.
>>>>>>
>>>>>>Right now the check for the flag is not only in kworker but also in
>>>>>>each
>>>>>>callback, if the flag were cleared the data shall be not accessed by
>>>>>>callbacks.
>>>>>
>>>>>Could you please draw me a scenario when this could actually happen?
>>>>>It is just a matter of ordering. Unregister dpll device/pins before yo=
u
>>>>>cleanup the related resources and you don't need this ridiculous flag.
>>>>>
>>>>
>>>>Flag allows to determine if dpll was successfully initialized and do
>>>>proper
>>>>deinit on rmmod only if it was initialized. That's all.
>>>
>>>You are not answering my question. I asked about how the flag helps is
>>>you do unregister dpll devices/pins and you free related resources in
>>>the correct order. Because that is why you claim you need this flag.
>>>
>>
>>I do not claim such thing, actually opposite, I said it helps a bit
>>but the reason for existence is different, yet you are still trying to
>>imply me this.
>>
>>>I'm tired of this. Keep your driver tangled for all I care, I'm trying
>>>to help you, obviously you are not interested.
>>>
>>
>>With review you are doing great job and many thanks for that.
>>
>>Already said it multiple times, the main reason of flag existence is not =
a
>>use in the callback but to determine successful dpll initialization.
>
>So use it only for this, nothing else. Use it only to check during
>cleanup that you need to do the cleanup as init was previously done.
>

Ok, will do.

>
>>As there is no need to call unregister on anything if it was not
>successfully
>>registered.
>>
>>>
>>>>
>>>>>
>>>>>>I know this is not required, but it helps on loading and unloading th=
e
>>>>>>driver,
>>>>>>thanks to that, spam of pin-get dump is not slowing the driver
>>>>>>load/unload.
>>>>>
>>>>>? Could you plese draw me a scenario how such thing may actually
>>>>>happen?
>>>>
>>>>First of all I said it is not required.
>>>>
>>>>I already draw you this with above sentence.
>>>>You need spam pin-get asynchronously and unload driver, what is not
>>>>clear?
>>>>Basically mutex in dpll is a bottleneck, with multiple requests waiting
>>>>for
>>>>mutex there is low change of driver getting mutex when doing
>>>>unregisters.
>>>
>>>How exactly your flag helps you in this scenario? It does not.
>>>
>>
>>In this scenario it helps because it fails the callbacks when dpll
>>subsystem
>>was partially initialized and callbacks can be already invoked, but in
>>fact
>>the dpll initialization is not yet finished in the driver, and there will
>>always
>>be the time between first and second dpll registration where we might wai=
t
>>for
>>the mutex to become available on dpll core part.
>
>Draw it to me, please, where exatly there is a problem. I'm still
>convinced that with the proper ordering of init/cleanup flows,
>you'll get all you need, without any flag use.
>

But I never said there is some issue, was saying from the beginning
"helping a bit" and "not required". Sorry I don't know how to draw this
other than above.

As agreed, will fix and use it only to deinit, let's move on, it is not
required :)

>
>>
>>>
>>>>
>>>>We actually need to redesign the mutex in dpll core/netlink, but I gues=
s
>>>>after
>>>>initial submission.
>>>
>>>Why?
>>>
>>
>>The global mutex for accessing the data works just fine, but it is slow.
>>Maybe we could improve this by using rwlock instead.
>
>"it is slow" is quite vague description of what's wrong with the
>locking.
>

I mean serialized access to dpll is something that might be the issue in th=
e
OS with multiple pins/devices and tools monitoring them, no hard data so fa=
r.


Thank you!
Arkadiusz

>
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>
>>>>Thank you!
>>>>Arkadiusz
>>>>
>>>>>
>>>>>Thanks!
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>+	mutex_destroy(&pf->dplls.lock);
>>>>>>>>+}
>>>>>
>>>>>
>>>>>[...]

