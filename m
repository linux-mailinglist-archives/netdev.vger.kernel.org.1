Return-Path: <netdev+bounces-46888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E360D7E6EE9
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59451B20BCE
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B4622308;
	Thu,  9 Nov 2023 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qrmwg5l8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC9225CD
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:33:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AB03C28
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 08:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699547620; x=1731083620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WGrzpoSL+tjZwECiZ1HAee0v6K260Q8LnJ71Ouj4SmE=;
  b=Qrmwg5l8hKuWwbGbD9rw6OF+iUctI/G86hzsxLefngdwfdi9fjbc0BSg
   RMq4yxByTBmnbwTUvRyR7pbCCbBSG0AH+OYM5Cd5VRvVPwd8tW5TmXlZo
   /lR4m6dvjzCdc1OLWcUEum032vrVatCnRk4alraUyV576sZs+QS1Qao7I
   bexE79OFchiMBuhWNiryOA8o2qSzBuow+5yFJ1NckZbv5nlh39C9spBBB
   Rw7sqlBbn1xPXR/4FaUdaQUYggvhSm+ca9YDdp5tRAQWR+lNkLkN/bHRu
   y6Zfdfx1rSaCauL5rYFWSXRRGe/O1jO8o79IP2M4i/KHgVUYPSEYedg7b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="393929703"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="393929703"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 08:33:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="798360875"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="798360875"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 08:33:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 08:33:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 08:33:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 08:33:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 08:33:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny0zQV5JG2bYXCc0H5Df41lhHu+VIY3vlfyVCDMESPPt8JUqFT3AuWScUdJx0Po1t7GfnGR1vj/EvLSQwYvVu6FnqlLnSPRrap5n/MGWyM5HJHCMQw6IxPeKyLzPIuL7iGQ0tv+Qrj6Tl4MjD0hYXluArBQzmjC+31djn0jlY1gCXJVLdb9tHo3X+SQHr6DxWClxJtbv4BF0Fiy1jbq2jNBT1xt8kERTksTho06V1Ae93BnKtnZy4GDgJMMqWebQ01hAK6HjFEt/84l2bTxjGrYPp+hvuF8w8Yb6IggkFmqrUUPabdi1Crp8vTu00CoJg71oFrysFUFcg4vyDapghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEHdcmJdIAmmnTYEwd6dekeY4xJO28VN5dB8etzFV28=;
 b=YM+PFEIr2AgeFHfxvFWLfvxovFjJ/xcCNdVmQ6k5PBl587xKmlFYfXT0xw9MUHF1lfEI/DVv6cQyKU8VwInkeYBBIhUFa0+BR6ReDDcYzK2fmqn0Jr5QeMWcAgkA5Uhfo3g17Ugv2SzAf5NEcaqkgPhSgiSh9SdeQgoRhGxcOncE2fI+OcYDMxB7KdYR9KcaFG9PTReKLbtStjH/cByQXDWD2cR8ijppQ6Wb2ZCn9W6EAxjaVrMNF+hQCBzF7KEB0zB9FkjwXEzLJuWxfyGJjIX1pArxWiQdT0h4Ap1W14Z5lC7Ere2XvpsTY6E1z9ZxEE+FUb6I55gr16WncfiYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Thu, 9 Nov 2023 16:33:35 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 16:33:35 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 1/3] dpll: fix pin dump crash after module unbind
Thread-Topic: [PATCH net 1/3] dpll: fix pin dump crash after module unbind
Thread-Index: AQHaEi9O+MhpyYqtOE+7KgFNzKw5JbBwho0AgAE4RKCAADstgIAANcfw
Date: Thu, 9 Nov 2023 16:33:35 +0000
Message-ID: <DM6PR11MB46579E6553D7C7DF5B37BD4C9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-2-arkadiusz.kubalewski@intel.com>
 <ZUukeokxH2NVvmpe@nanopsycho>
 <DM6PR11MB46576110B45D806064F437C49BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZUzcEdhmnBVdXsBD@nanopsycho>
In-Reply-To: <ZUzcEdhmnBVdXsBD@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DS0PR11MB6469:EE_
x-ms-office365-filtering-correlation-id: c3718ab1-7bc9-43c5-922f-08dbe1419ea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DwXy6vg9Gts3j6qF24w9z4QuQcaunUNsTA3cH4rJToVV2fez0bVU/Qw9My+Y2zPxOM5cRWMHAEAOFiA9a8+iDGx0y5Fqi/GreEcQEohKwUkww9J1R4phijN6shNDKuR31LV7jxsjDh4wcdS6uRmdxOzu2WdqCXEEtINCWiKS20U6TI+gkeRbDvF7L30lC3gW4GCUbs5YTpamnaF1j8e3NUg0LAWtkWIhEZciiM46krJxwOwRJyW7F8o26SzRN0beM0VhKFB/bVQCrHNGzkUjRkELqf6NkY4jYEVwe70Rb6E/oNHkj3TuBL6KtGAqGvPgZybc/KPuFRROLUKyytw/IzXCFmbPOYGA7XE5sqagOnoAHZpoR+nXUK+hZ2qk5nQwVhaKMC8CM7Zk5kV313umSlWlA673uYczdMbF0nUNHd2dOFbQ3y1VvMeW7nvBQ4J//DZzU5G6S48/ELF8qysgkBwfIFNo1rh4mdqSFiC+pfHFTinLxKilYQeZmf9aicb9czsR0BSmyZ/uSS/+PN1hNoczfj3S8W+V83TvPAqWolt/m2PYk+xy+X8rYPlj76I06Qc8VzbZmfIXrWfIsptaAxq1Q1SzSh7YOootA4AUYVpDsvD6/eVlztg/PuMSK4/A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(76116006)(66476007)(66946007)(66446008)(54906003)(64756008)(9686003)(7696005)(6506007)(26005)(478600001)(71200400001)(82960400001)(83380400001)(33656002)(122000001)(38100700002)(86362001)(66556008)(6916009)(38070700009)(52536014)(41300700001)(2906002)(55016003)(5660300002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cjRZajiOOxQ56Lb2ijOuKbnOGPSnju3enDzjCuL/v6Lr/WSoWWlcuKy8eo8G?=
 =?us-ascii?Q?JvKHVYHG6Lj+7NjPs/FaJ428Q7moaOu48RtNI2Yf+t8uOGLUPLErwzkZuh+k?=
 =?us-ascii?Q?P5WtGfLekTrKw92+ujMnayo3CH0bvFxOPpwx6uu9t3bYcG/SjoWo1KjDFYOC?=
 =?us-ascii?Q?IpByYHfmZdyqA8mG4TKn7UDtU3eypX2XCGfU8UqRH2lOE1cuje3cU0UlO06T?=
 =?us-ascii?Q?i3Cn5o1RfBZQuQ+44Wy//hVdp2QMCn6z6ol4Ufmv85M/XvyuyW8/tXMO+O4X?=
 =?us-ascii?Q?qEmLd6RjNhpFO+ZWocbs+vg5bHsCmjJi53AeWwaJ6XvENFmskw0b5ZDt0JCX?=
 =?us-ascii?Q?2qf7GRX1kqZontJqbBDeQHJXIIhPzCFiUoR0ugrRYE3xNnuny7a8qMZVoGNM?=
 =?us-ascii?Q?J6XULG7lo0Vgzz4gYEGihTnDexSkjp4RowLW4IiKW/45BhA2LPnmtodfoqeW?=
 =?us-ascii?Q?C1LK0+NGY/0rk+uQD9AqwvzKaKpcdSQj1gWFB+D+CVk9Hg/32pClEIVgXngr?=
 =?us-ascii?Q?/aRpzpGIpEL/7SE6YqSRjck1FRR2JqZ6OL39kXY40+W6BZKNKejWJ+edzUfG?=
 =?us-ascii?Q?4DI2Ts176EheAYfzo2z3GYPpDXmjh36/s7s/IkwmReU3J5NoXdO6QEsRFNeh?=
 =?us-ascii?Q?l2MmP4JqTYEC7rITIrgKkwX3UfYszgSPIsk4bnSylJvtHRhSiZI/FC8JbGXB?=
 =?us-ascii?Q?9qxB6B1+od/iJbJnEB45N3xyqsvnMXqEb1zoJpo7x22K4STac73zbW4GGgHm?=
 =?us-ascii?Q?QvqL0z8W61N7cv1OFsDUf3tL0ZoT7qKOmepED+mAccvfB/cfFExgGpWeXgGq?=
 =?us-ascii?Q?H5G2BWjBvqkKCi2QRilKwW6B08yLPu3sN6Rkjz+5blZydWwWooLzqxqs5fC9?=
 =?us-ascii?Q?rxWehpM1mMiV/K7NEO2zg5ICH+tdLV5nBrezmNNyteBKIs6VHB/iPmW50qbz?=
 =?us-ascii?Q?zqFekfJreLG2e7xmOa44eflFKcoe2nrUSrLzwQsu+oIUk6BOZ7yzfitoUgGO?=
 =?us-ascii?Q?Pypu4u27P+kzXWeLKPhdc5h2LJcpoXCfvTWIdwuGSlQHqJMLi0NY/c6Z5Fk4?=
 =?us-ascii?Q?IBq7mT6HXEaR+WR0/qi48IqXsTdGak8SU13WvMi/k+N15zmM+KQZ/PK1jrVL?=
 =?us-ascii?Q?JXIVrosnKw1P5Edk5YhmE+yteg8NwlrHanbz2IUdZR6qFTcezmYFv/yG67FU?=
 =?us-ascii?Q?H7Q0sfKh6lLaTCle0niFNZE/KYbVYAsvbaRErhFiuboRyuWKsa6Wx7/jPMpS?=
 =?us-ascii?Q?a0nVRCqH5+tBwh+TXs1UE/6DA2uaAhSZOeuQW+Fjg6tJxZhEaqKww7gml2Rz?=
 =?us-ascii?Q?WlRAe3MMNs7Iw8UXbv2DOZlR4xVrtIE78vpC5LV/MYaXO1AJ0Qlq8lcT6LmQ?=
 =?us-ascii?Q?Q+6InHqC3tU+uhVjkxITgnomYaKv2o8bQqmtw27B7WbloZnY0gGp8K0gxahT?=
 =?us-ascii?Q?FUvNcWT0ySte2TTygXrKqEpOx1Ku2ZBvjHoZC3sD9LTsGuSrLP+tdmCjpMNJ?=
 =?us-ascii?Q?1S+N+w2X9jnfuZzi6X0a50qDaG/70ivAVgFeoDHf5mNrva3+SecKguAd6E8x?=
 =?us-ascii?Q?G6Fnyb4W59yGTmvmP88WJ6d5qfm6LsHhrHlBqSMEjAo5Er1jmdmM0VGNZCyM?=
 =?us-ascii?Q?zQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3718ab1-7bc9-43c5-922f-08dbe1419ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 16:33:35.3213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Hv9UXegFfiIS4XgQi+KwlC8avFieQEQspX8EF6eM7QzqbEym1TYc6xnAqo6yPtIMUEit5V+Ksb4S6DkdAvCETo2uvvYVx5AxBMgBMxUT3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, November 9, 2023 2:18 PM
>
>Thu, Nov 09, 2023 at 10:49:49AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Wednesday, November 8, 2023 4:09 PM
>>>
>>>Wed, Nov 08, 2023 at 11:32:24AM CET, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>Disallow dump of unregistered parent pins, it is possible when parent
>>>>pin and dpll device registerer kernel module instance unbinds, and
>>>>other kernel module instances of the same dpll device have pins
>>>>registered with the parent pin. The user can invoke a pin-dump but as
>>>>the parent was unregistered, thus shall not be accessed by the
>>>>userspace, prevent that by checking if parent pin is still registered.
>>>>
>>>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions"=
)
>>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>---
>>>> drivers/dpll/dpll_netlink.c | 7 +++++++
>>>> 1 file changed, 7 insertions(+)
>>>>
>>>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>>>index a6dc3997bf5c..93fc6c4b8a78 100644
>>>>--- a/drivers/dpll/dpll_netlink.c
>>>>+++ b/drivers/dpll/dpll_netlink.c
>>>>@@ -328,6 +328,13 @@ dpll_msg_add_pin_parents(struct sk_buff *msg,
>>>>        struct dpll_pin *pin,
>>>> 		void *parent_priv;
>>>>
>>>> 		ppin =3D ref->pin;
>>>>+		/*
>>>>+		 * dump parent only if it is registered, thus prevent crash on
>>>>+		 * pin dump called when driver which registered the pin unbinds
>>>>+		 * and different instance registered pin on that parent pin
>>>
>>>Read this sentence like 10 times, still don't get what you mean.
>>>Shouldn't comments be easy to understand?
>>>
>>
>>Hi,
>>
>>Hmm, wondering isn't it better to remove this comment at all?
>>If you think it is needed I will rephrase it somehow..
>
>I don't know if it is needed as I don't understand it :)
>Just remove it.
>

Sure, will do.

Thank you!
Arkadiusz

>
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>+		 */
>>>>+		if (!xa_get_mark(&dpll_pin_xa, ppin->id, DPLL_REGISTERED))
>>>>+			continue;
>>>> 		parent_priv =3D dpll_pin_on_dpll_priv(dpll_ref->dpll, ppin);
>>>> 		ret =3D ops->state_on_pin_get(pin,
>>>> 					    dpll_pin_on_pin_priv(ppin, pin),
>>>>--
>>>>2.38.1
>>>>
>>

