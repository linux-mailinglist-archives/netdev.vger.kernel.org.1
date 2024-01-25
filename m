Return-Path: <netdev+bounces-65801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1983BCC5
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED551F2E09A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F351C69A;
	Thu, 25 Jan 2024 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJhJy7ll"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C61BF5C
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173436; cv=fail; b=jUJKNuQcd3Bw4TkMqDgireEkfGXDbAT1h7JcMiNXWlQ6KvgBGhY6GRfkDFdYSd22td+zmtbARc7TEDt8R4/fgk9KTYW0uJWVY8X9XZYFwKbkCvMoYfOS2z30h7yL8PW/FP2QBbdi0xViI64GcOHWpakJ16D1z1+8NPmf91YxyM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173436; c=relaxed/simple;
	bh=Pln+Vn/gaHtt0z6u9dCONdOdcl8SOeoExoyHg+oKKmQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dAD7qe6WColsZkdyCNvO/0bxCZAFwAOanWgXX+ETW4CBnzIUbOYe5T8LL6pWV5KkXsxYwL2mwVSMchtpq4hqIMwJcLW+PiaXSegEueJd19fpIPxoAjjC6DltmKSHEhm+TSq9Vk/78QesjCQVpy6r4R/qacAMq636fl/k5urKaxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJhJy7ll; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706173434; x=1737709434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pln+Vn/gaHtt0z6u9dCONdOdcl8SOeoExoyHg+oKKmQ=;
  b=JJhJy7ll9ocnb8SVhoXhv6uPNjaTbbIqfiHxQt4eq7asB5HsE8myWIEs
   Sj+pRjLmsZACAfyiNt7PcMvcZp3inj3rJTZ7ggMkP8PdsWx5y7oeDFcNX
   O/gK1wYkW2cnSvvkkPKe6tmtRSS2R7B2ucry8Tb16W3e7ykFE6IO7+ePG
   akCSP7CUWE9baaersBgHjIgw8A4GI7b/wH55TmhuYZCtBzsmzYPGedhYG
   dioU1C9UHckJjCYUVxXSZtrBF8m0Ldm/kMQZEOO6OwizabinqbwunlY8+
   R2QbeF3zdGl2WWYDAI+o9JH8WvPJe91XE7QJwDYSV5tIV7ZVyX68zecda
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405853681"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="405853681"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:03:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28413562"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 01:03:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 01:03:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 01:03:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 01:03:52 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 01:03:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ3CWUGbpep36rc0lTiE9Fvg5bu8MwjXnHujZNzf/CJR+mfZJ9LXfm6ovGPHJ8neMDAqjv4IG7WFmE+EM4l9oSk5B2na5vbsqjTSjuVyeMsP4MtaQf4YnpLhAhFyUpcjiGEKQX4RydSNPBJAmi8XUx1HqSCav6t/GjO6bVonODV7XaWuRmU3irpPe5TyTu3YSU0NtZUSzjLNZPAyhFwn7SaLQB1NvF7A0DuQvT2GGfQy+3A4jnxOTYEAA7qAhyANEX9mN5kQJYDN2g7WuAej4OLeFztWvBqB5IWmJ3jVi8rrlS/X0Ty9b2/wRw+p4NFHuTQoG4X6Dr/3DP5SU1Iz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJ72xLG77S/HWxe0jUM3LEc2baysTmRzcPvpxIB3CVc=;
 b=GEOhAnv3jPIWd/qAdldpWtp0tYj+TnVeOvASGfOmFGBcpaRhN0b0qYhQaLz/acvBR9+hbAq/xDQRlfpOw3rkBe2sRxPHT43oqQ0aPlXTpgzbTSsC6/+c1ICn50wVKiwfYferpWMUNYiWy0Xty+Eg9GtJUa5X01ccNjIwfW6MefPwj2lytrgDi4NYFysMgP6ORTnqw2qorKNVUZXYEfgUkpqqqLLMWFsIiRb0iIIq1GYtVkXHEixoTzuRF3pINljWrYXwBEv9WhH3PifKxXkqQvPd0pfc4IyJZh5HnIxd36XURNvADfQUzT5uOGQopP4WK/Y4nMCoxBNkTVzOW1GUkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SA1PR11MB5876.namprd11.prod.outlook.com (2603:10b6:806:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 09:03:50 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 09:03:49 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v7 iwl-next 7/7] ice: stop destroying
 and reinitalizing Tx tracker during reset
Thread-Topic: [Intel-wired-lan] [PATCH v7 iwl-next 7/7] ice: stop destroying
 and reinitalizing Tx tracker during reset
Thread-Index: AQHaTepU00e+durVkk+nPzskYT60KbDqPlxQ
Date: Thu, 25 Jan 2024 09:03:49 +0000
Message-ID: <CYYPR11MB8429973B06520BDB86675701BD7A2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-8-karol.kolacinski@intel.com>
In-Reply-To: <20240123105131.2842935-8-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SA1PR11MB5876:EE_
x-ms-office365-filtering-correlation-id: 16b5fe96-073f-45c8-b5dd-08dc1d848bce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++C7vAcJEARSTnnO+lwJe+tVXl4nNm+W3LYCCVdPxfFDo/ofL6CBv1CtipIgii+pxGh2M5PZvwz43qC59kez9PrfW4VCzFqYA/PHIEv9KZWVe8cmUsA1nlNx6+yc6aUUIAG6e8zLKMWIkEzZ+dWNzLALFSPsLDj78omuGzDsXKeJqUCon2J8dP6rUmMwjqmTtJBTWlaQGsA/rGZvUB+cysNxMXYgA/CCyboLGpZbX2A1YuLOphMVuAJK5F216QcTZHm7lOUyhlm7gMXu/Odt6le2Fyp7zBX6qshJjTJpdqjZm17K5XTBxueg81W1TnSeNk0yL4onGjMOIAyWGTR/Wio5QHZ1mERt+IsmZJZcQ2LVaEAn9KN1XDjAoovlsK2jdKhKXKJw8WZdr+Ffq79AucmuBeU6s1tNBcRfNbzUwwrAjt1KQUbgAsvZAT3FwQkxRPs1ML48bjt1zBHF3VJOJ0lGJQVDZ9GDew6PhzhHUUCydsf4ipzDNanUfPB332fBvh21UL/qMD7oDQBzP1Skz27lGFBZGNFQLgG6jWZK/vIwCfj+2SMb+NiPxRlD2CJ8Wx89sHtuQxRdZd/JGsqD5n7iL5Dru8Ngb8Jh67rQvrhmHkb6zuOac0p9oDe+t/Sr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(83380400001)(107886003)(26005)(38100700002)(9686003)(71200400001)(55236004)(110136005)(5660300002)(4326008)(8936002)(7696005)(478600001)(76116006)(66556008)(6506007)(2906002)(8676002)(66446008)(66476007)(54906003)(52536014)(316002)(53546011)(66946007)(64756008)(122000001)(33656002)(38070700009)(82960400001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XKfWdqBhPeAVQapNoQliL8asB8m4lsLByMzqNrdDlxnFajA51Aj+WBcyNipm?=
 =?us-ascii?Q?xL7g8J6bhh00ZH/p0B6T/fy2Jr0fO+KTvgUPc5bR88qaSTZc2W64ifEkVWV+?=
 =?us-ascii?Q?MtAznBmPU6p7RT8zvQZsyq2riLC4siFHCaFVDDUaChvSqi/2Ez9Up8Vi5uK/?=
 =?us-ascii?Q?8/BSu+a5gkUaLkwTb7Bxd4diob/bOhO5W0R7x8lzfr5IOocf2huZoUBGDeCc?=
 =?us-ascii?Q?i0bv01IzRT9G/4uVlnn59TdFwvWzIxZvp7vkcJeQOepEe1iZ5sVVfkdX271w?=
 =?us-ascii?Q?MSJCO95e7N5WoB9O1JTillFwY+5z15nEuI2zBF9ypAar+qTPQtNdxJQtRCJc?=
 =?us-ascii?Q?DL6PR4cGni6QL2T38dxxc7ClvikoDIbVy3rbJhH/WFaf3QRCbVv6aL8CxtYi?=
 =?us-ascii?Q?9JItk7bQ+1IKmKvD28cJmFG51CNK4aRUComxV/w/rpEHfKTt+kt85uBreiPa?=
 =?us-ascii?Q?YZwB5LxKO8qucDT1GQH1zDUnVAh4xhfM3Rruj4wzNuRRH4pUZytAMhCb9f3T?=
 =?us-ascii?Q?5krX3bG/lIEGul6j086y1Z5QHWQiMSkkxdZEl3dXTaUeJBAh7nkjM6blRi23?=
 =?us-ascii?Q?8wNVlJe8aRjp5Cw0Dm1wGcP6KeLB/VTBJWtrh4yjKuUG4EErWWxJkZDmVR93?=
 =?us-ascii?Q?jeaLL6aMilq1qxthjffbUab1nRJhrqDoni1I1OU5clMKxJUhj8X0fCehiO5U?=
 =?us-ascii?Q?+SXXSj1rr3/u3LNZbE3yxsje3sWMB8Uz9BZPS+n4lQ4N25ix7CsSSyKi68k2?=
 =?us-ascii?Q?dlT3z6WpbM02MSHWEL8ClRR4P+InNpv+xQfGvFnwwQyf8hlNwFk8Y30df8e8?=
 =?us-ascii?Q?Ntf9HKnBlvvgLNkAt0AjttfbKF5nFe1vahy2pUnE8molD5bVWQ6KBIgTMDmQ?=
 =?us-ascii?Q?IRALufO/Hx6tB4TeYTO4MMqOtByztBE8yT1Hl7QYnDSyjDqEUIhYl8gkhLAI?=
 =?us-ascii?Q?88MJQl0e/FePBADQGGium2Fuq54A6qtd29yRvLMlXRtyhYR9wNacgYowQbK6?=
 =?us-ascii?Q?2OL+wwJZjFshf444z/KeYkZdBt6Splz/hSbGBA5/I4+kQgBeVlZh8hgJqJ0e?=
 =?us-ascii?Q?WRlGDT6Z5Tr2rOqltlm1INxy2Zk3nWjN71cNnrbImF3dsTBXlCXJ98aPSzTg?=
 =?us-ascii?Q?9qQQvFVYBPj+3RNrhfNUT6hpwpHhvfI9f5B7elo9GogSihz3B17NbisatxQV?=
 =?us-ascii?Q?qiV2d+e5hlOP4GkCQh13p+D+BwPEw2+wwk4r2+OimWvhyVOoPONRhMGiMn+O?=
 =?us-ascii?Q?1YbmoPGXAH0n2hbE0R5ykaP1s7TeS1IQD/jBHMn6xsoIYa6U3rqENKYyFX9s?=
 =?us-ascii?Q?cVGuAucrycUVrGTRBPDNeWeOLYmyuMJsyFrn+dt7dUrwobcTJuYf0lvgkTOk?=
 =?us-ascii?Q?5+DX6iH0cnHUW/xcILoOsJbFgmcm5RA8V8MT0mn5Z0UggwxgcfpL+LeyPYpw?=
 =?us-ascii?Q?10otJQVcRNV0CMmhZoW2EODzUTosqSqA+f6OqgwPtnOmXebjPLWuOOENzKNK?=
 =?us-ascii?Q?VYGpbnSYEdRfU9qckpjspYOEcgtcOo6om8Iz7iT139AhY4fvsTC9Q58j1BPV?=
 =?us-ascii?Q?TsnlQnsrF/R3FP0TDc6lSyeZ9eydiWgvEYrJMe8o/IVGP36xgYLAVXebhDPv?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b5fe96-073f-45c8-b5dd-08dc1d848bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 09:03:49.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlIX0P68TB74E9OMGNbgvnhpToWkVXRHcFQ9U+iPngts7kaJ1rXite8T9RoVMnJEwN2UfnH12EQ80AVE+4XqMug70spiR8ukXUEGl7L9aFxI7Ws3v7me6a2JwCtKeoaw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5876
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Tuesday, January 23, 2024 4:22 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; netdev@vger.kernel.org; K=
olacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony L <anthony.l=
.nguyen@intel.com>; Brandeburg, Jesse  <jesse.brandeburg@intel.com>
> Subject: [Intel-wired-lan] [PATCH v7 iwl-next 7/7] ice: stop destroying a=
nd reinitalizing Tx tracker during reset
>
> From: Jacob Keller <jacob.e.keller@intel.com>
>=20
> The ice driver currently attempts to destroy and re-initialize the Tx
> timestamp tracker during the reset flow. The release of the Tx tracker
> only happened during CORE reset or GLOBAL reset. The ice_ptp_rebuild()
> function always calls the ice_ptp_init_tx function which will allocate
> a new tracker data structure, resulting in memory leaks during PF reset.
>
> Certainly the driver should not be allocating a new tracker without
> removing the old tracker data, as this results in a memory leak.
> Additionally, there's no reason to remove the tracker memory during a
> reset. Remove this logic from the reset and rebuild flow. Instead of
> releasing the Tx tracker, flush outstanding timestamps just before we
> reset the PHY timestamp block in ice_ptp_cfg_phy_interrupt().
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 33 +++++++++++++++---------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


