Return-Path: <netdev+bounces-46802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859C17E67DC
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB38B20AD6
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963B818E1E;
	Thu,  9 Nov 2023 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nr/VMV+r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8318C17
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 10:25:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C972D6A
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 02:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699525514; x=1731061514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mpw3oM8OGvKfH0cP4XQ6QCUTwbYgC17ha+yNTpelDRY=;
  b=nr/VMV+rYPxJ6n6wAsFHx7/9FdchQ3Tmr3Qd1PQZ2d+iTurNoTIMMwr9
   IJwxqS1wUMmB9TS1F1xpHjxnLl3hzyc/60Z3/3GE/Pk/A7qAK/Zak+mKQ
   SMldFmp3qrAeWGSDSfhfBaJgbWOQkOncwtbMfvowRll0799u6fkG5wnsf
   7I+kmrJbZsi9CUGX3tF6K3q3Or4J69mC3JxodvJGQXGvwamFaIUcUNAPQ
   VGaBXjisztsFyJP/mW/4ifcOCYCWEu/ci3m7QpPjwBt9YZVlUSI0TFIMf
   i/q0/cxoQI1TLbnp5v3mEKOv6bdsq9VKL1Z48ynWp35HbM22ZnlusRl1Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="454261804"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="454261804"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:25:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="1094819349"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="1094819349"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 02:25:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 02:25:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 02:25:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 02:25:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/eEANlfPUXMGa9tgLCnTu1VALZXubg0uQJ2vsh7cxUL6iwGXkhzcQCdDUhhj/TQXxdJja7Ogh2IYW0roYGOmjX73xGIRLr/15/pQ2UzK0pq4zTAipSgszEczMcvBwrg46wju0HzQgTaHjG+vtEZUH+4zbLzwZ3r9qWGIxYf54Gta3/9TX/o0pbXOQyg9kQVCUgoTOFyS7Vd1slgh9n3F72B5dB9cpBwB5mbVtKpqJE5q9pTWWioashUIfmBjitEJra6wnVv8FB8Y0ulsHMybLFMcHLhlocqFbTHRim9bVONMViecVIGMctVBJJCUtOIBchJ6YmkzOWKoc3j93D7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFA6GiXNkgf1Znf9zVENfpQQOKChbeb1H3E02ATwdqY=;
 b=XiBOetgSR+WPdCNTjRIFqUPpLgBxA8QF1m04CEnFXXzXU8oxWDbKdFV+kRh54G815skWlcfqi1s4PzsXWGlecGd8IbKeXwxLuJV+g3Zi6aA5VBZfx7pX3B9G3biK/qZgiRW+I1aii6k5ktaVeqNIqSddxSJJ09eOrKyQccFwzDHhqrHZnjfWckHw2flVNvZWOQi4YGJ7Bp9FaIarWHd3+UD60UFV9sSaadvb6qwtjKTG9PuKZvh85I/fvJ4YQvBozyeYUrl6+ePzLmpDVsUtcmMTB79/RSvz4x8D6GFjdgziTzEfb5XzvhptzG3okoJDbWJVDQ0TFfEwB3NttGeXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by DS7PR11MB6245.namprd11.prod.outlook.com (2603:10b6:8:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 10:25:11 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::3d98:44fd:690d:c3f3]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::3d98:44fd:690d:c3f3%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 10:25:11 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Raczynski, Piotr" <piotr.raczynski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 09/15] ice: return pointer
 to representor
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 09/15] ice: return pointer
 to representor
Thread-Index: AQHaBm5JcGilnBMFS0aoxZd1lmQaebBx4Raw
Date: Thu, 9 Nov 2023 10:25:11 +0000
Message-ID: <PH0PR11MB5013A700164DDAB6C7A2796796AFA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
 <20231024110929.19423-10-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20231024110929.19423-10-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|DS7PR11MB6245:EE_
x-ms-office365-filtering-correlation-id: f8fb3ddf-2736-4765-9c12-08dbe10e27ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLX4pWulto+Gxiw3KG2ei1Jz2KHJvWMWs3JfRb4h0NYcySg9M6sL/ew6QZLFeOFe4CC3SjIOIdYMpfRpgsqXBa3Xf1HlC2M76/AzS7JWSr9yJyz3M+8LYxBZ3bueE+3ajfB560w5Bgmpp8wrZGH3P9w8qT2f095gCK0lzbVRjSKZCoCPdfYwdQGPPuVptiqKOFdFA3uhw6IzkoBhn/IzGBltcnGHsAbZM60vkTbtk7NxI5c9b+T2L1ZpQKTr5+jRE2j41kNOnSAba6rlwEKctjKGb0sGBne7lApBNEv1IgJvF5B3/F5IUor6Lz4k6oW8Jqj6cb9WEAX2VU2Oz4BOjsWzv9L+6JYeEYToNmPgoV5srqRNqVGAkRBlyZ3BxveBQXP/U3Zxpa9qXTqJ/aw20KmoKLToWuHF5y8jeChJ6z7wCdMBEWWxEBNi0TEeXwxywW9PV4SB2IVcYOFSN51G+zBZUdtAeW9pqarAas16fUXCvFhdATbafxTJa2TaG6H+wWLzoo3D2j8tm3PpgLzm09yupOVfNzV3UF4XE4mCmpVZ1942ee2CGnH5VCjw07VEpzSBJ4gVviKgkSdQRD7MePWt+ajn7gKeecpkIk9Iop8FRYPHPSK5UWO9DSLTHJkJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(38070700009)(33656002)(55016003)(83380400001)(316002)(64756008)(54906003)(8676002)(110136005)(52536014)(8936002)(66946007)(66446008)(66556008)(26005)(4744005)(5660300002)(4326008)(66476007)(2906002)(478600001)(9686003)(41300700001)(71200400001)(6506007)(7696005)(53546011)(76116006)(122000001)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x3GE/csma6c4n2lizHbl8aNiO54WERCAtkhBewQV1u0C5E4pyki+k8VYFYen?=
 =?us-ascii?Q?kDaHJZ2KW6B9YpFbk9Infa4JptkcscTWyBhoaDWsdh+yF4YlkwACr8r0F8Ti?=
 =?us-ascii?Q?1giOJxrxN7/JN2jo8OPDs42wDWcb41AfALUEbPT8FrconOp9dGBPK4bXzVeQ?=
 =?us-ascii?Q?A6mTuai9PBf1pWByoJ+LsI48hrqurn6lhZkTHTO3svv41j5E1jyPLrKwREfU?=
 =?us-ascii?Q?iRO1mxnsimGbYJ0ZJr5LfpekpqqGB10z0yHMkbKPdX+48mqELTt5Q8ewGO2H?=
 =?us-ascii?Q?4XJHlAaSTj6Zejls6RGvqvi30DcNMsStqYWJ3mkjoQIFsTObmIX5UAmLs6+c?=
 =?us-ascii?Q?nw0fJpwMUxk3tgOz7BilEH5FLa0aYQ8WlNJykOn3QmLk67jtmKEUZsHbI1kH?=
 =?us-ascii?Q?fvo/N9rEWtVDAtFw0eYZ6K7aJP+6pgs1dQSgKLv0vf0oiKi5XYIlh4tjWHgQ?=
 =?us-ascii?Q?qar0YHyaxVp1ghVKRj+XQrYuBd4R4kbq9go45wzxVk9cgZu687K56a93VIfX?=
 =?us-ascii?Q?Vi1wiDeN0IzohzIuhBTrzqQQNAMdhUHK7kv+GsScyzw9QbI+G3S80TtXNZ9T?=
 =?us-ascii?Q?6+1mH8qQaGpawgFtSnVu6ifq3ob4B59CDjtog0HDh92cCL0O3lTI2wdHG/jf?=
 =?us-ascii?Q?lndAb5JKHIUzVNjrzWAdqDO6IWVMhdVwDKi0O8tkcmKF6ZlFxuXRZEKndL7O?=
 =?us-ascii?Q?a5bQHvyiq7aFlsh60n+lCvDlxaLPfUGazGxsEvc6pMqsMKmquvM+gfrspDwl?=
 =?us-ascii?Q?awh4DLO+7jFbRaQYiNdHYXnSVZkkQwu6xhGcBOiW6ULnMkmTwr6CGebhk+TJ?=
 =?us-ascii?Q?rKEjSD+vjcMdd3m2u6liatW7ZBkEHkA6rAkb9EUvKO931Y7oQed0znBoU8z+?=
 =?us-ascii?Q?pwHNY/gm4jZdeAEQ334p9N9jI1xImbC6jTMf04Ozse+KLSN5wF0vBVXeXyUT?=
 =?us-ascii?Q?pC9AViPOlenZrXSi9/Ml1HMUsSLHuJB13eQrTmu0Fuxhnb7FSN/ApoZvozSe?=
 =?us-ascii?Q?HjNcrBRVp587hix800agr0gT7gBbTH2QbrVN8jy/gD5dmC0SOTKNFoO77nvH?=
 =?us-ascii?Q?ooy7AAMcRnHe5yGoqYbXKmTJtqMqdx18MkU7QrJTY1mreHXFoRePD4/+9zot?=
 =?us-ascii?Q?tvB3qdxDJd2i5BlekW4sJHmzuQEnySHKNKd4d1tGPVk8NlpEo+TH60Pz/NJf?=
 =?us-ascii?Q?IUtBoet2tou7Xm99AfffRvJY6x/yg+ue1dHB9WA5jlXuhdaBTRB1QEZRYf8n?=
 =?us-ascii?Q?LvNF9FtFioUW+RwHi5QYTp2lrwmDm5K2Q0TQPOfc4J9tC9eYIdL+2lg5XZAL?=
 =?us-ascii?Q?a8k8iKFjnwCHAaJ+oHihQ6c/0gGPKlILQKOuuUaj6/lII6gLt1uHW844ur43?=
 =?us-ascii?Q?UJaauYdrUiPmRue/2GxLbcSIAjySPNs2hAsxYCDqAKcqlb8udUQ4N9JyZTGp?=
 =?us-ascii?Q?BpFTZJk5U6QR3ze+niu9X+VHz/Vkt9VhQK/GFxNtgOmEHQd4kOpYLeNxaRXX?=
 =?us-ascii?Q?cUlPjzXV0BP1jSvVTbQtHIVQylcV51Sl9ieIjRZvj1E4qAW8RXy+fkeItbd4?=
 =?us-ascii?Q?Jzz2ReOFWXqvSzxm2ozI9/ms8J46Cl+o3kYTLUNqHn/QBoMiLMzu3rctQDJy?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fb3ddf-2736-4765-9c12-08dbe10e27ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 10:25:11.6506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyBoGWui6hiLUigQXFHkLUTO+m+5zUKovKMmNpVcO+IEM6hkvc5jbA/0Pp53hdo3B8e9I3DkQ6HdA//KJ3ls7YS0ArUQJ4QLwCuHak/M6/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6245
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Tuesday, October 24, 2023 4:39 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; Szycik, Marcin
> <marcin.szycik@intel.com>; netdev@vger.kernel.org; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com=
>;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Raczynski, Piotr
> <piotr.raczynski@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 09/15] ice: return pointer =
to
> representor
>=20
> In follow up patches it will be easier to obtain created port representor
> pointer instead of the id. Without it the pattern from eswitch side will =
look
> like:
> - create PR
> - get PR based on the id
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_repr.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

