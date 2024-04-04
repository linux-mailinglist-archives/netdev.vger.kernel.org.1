Return-Path: <netdev+bounces-84848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62D08987DE
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A42D2912D0
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB5012836B;
	Thu,  4 Apr 2024 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKhlw7C7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50CA4DA19
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233806; cv=fail; b=UJLuzMazA2GQy/lBIkfSRJZDy7Wk7qilmbME+vpjg72bf9jVsnSr42S4FTsluwnRCAXytwr59OtVMuD7K+aahmU9gDW1jAt79SZkGpO2vKFwznEC/j8rQFzJje0nq89QrqSSN+GpiS5e2AI2uZMe2LgYDM8u8VtHSOT+LlKHHDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233806; c=relaxed/simple;
	bh=hbw+PnKqHyh9PGbt7+Ir2KJOCgT5sVZJADHsDqz5UVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VHbFbSEkvQMJoFVf+xKUspD6xop7btaMooVXdyoI1VP3lmCGly9r32L4b1zq9idVXqulkKmVox165wIJetsbiYZtxijP3vB3YsaHx9SnYiOroU684TsvAVThkgN8G/+98iZv5CiWAQB7wVuMaoG5R5w2+8/TquQ+FhjvHn/Xbi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKhlw7C7; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712233806; x=1743769806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hbw+PnKqHyh9PGbt7+Ir2KJOCgT5sVZJADHsDqz5UVg=;
  b=ZKhlw7C74fNCtgbzONof6Orc/bw48PxFPvdetiJti/1575n4iQHoe/pR
   sq55e2O0o+OxJvYFYxBbOZbl4bYyEnnUDvyyV3cbQ3vbYL1xxJnEecl+o
   257ZzrfhcZnooR5oxZ71ImRxLs4NMLXCZxlPgzxfVK08/hXc+4KJ5I62l
   Wp26E57EnqT8vPLk6sKiXn0ogZzr7H4/DE995N8EFzHJasGzlqLXuxlcc
   7ScWxP6BgAsnHFMeQjkLTVu7AP2igtVxAuw4a+WDh4T5qJojklv5u/eiw
   g78sKu0BfXmilh3EbxRoC4IyLCn3FSvQuSNZ7nppGRPhzpAmFPRpaYpcd
   g==;
X-CSE-ConnectionGUID: HcGhmZsBS+KYNZTBIMOH9g==
X-CSE-MsgGUID: GG5vWq08R0u8CXTmZQXMag==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7407039"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7407039"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:30:04 -0700
X-CSE-ConnectionGUID: GwZNfWZCR7KLuZM5YgpJNA==
X-CSE-MsgGUID: wfzKWty/RHumSwazQ4zPyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18623054"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 05:30:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 05:30:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 05:30:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 05:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/LhV1p4pXZqau/XifzwYBsbkjBxUKtVWgKZgjENpsl1ZHO55eT424jhqLZg4OYUyo+qYxrJ/3dMIz9+TSQggJwZ5Au1xdeKMuU+cKYyBwSPzKNjtHEchHGz1HGp9FyWQV5vzaSkTAU1RvGNhdHeCOVJIRmdggt33E3tZuADj/KmgNNLiqxIhnp3P4MGAd0GjQ/HSV2xc6sEtGknJX9LDJ5cPxxL8asQpsueNht3+LD810HvvOFaYKrqRgYuOl1MQlx9lozblZKr7lTLSLl1pd0QEPddunf6ScfoRYzl8zj1WrlgRMsX1iovTb8aohxPWG7AY2A6IjP2H6Mctm/2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbw+PnKqHyh9PGbt7+Ir2KJOCgT5sVZJADHsDqz5UVg=;
 b=M4WtUNOisoOOo+BbuGYts3sJlyL2eMyZHShwku/s+RW6lcvoVTClubhXcBiWRgHe73t1g1LAtZMH3sPkjMHsCDmf++l+jXs2wsfPQefnxvHbaNJvXbbPMx1c+xInOU/rHHUhg/BwF48EdXoVALattO+4z4bZi6L0vm2zYA6L11XkzITrzVoKUDkHhoSzL9kEKu4P/Nt3tFxfKeqGS80Az++zh9k+Ri6cIe664mmncqiBzhS6E2V3KB9YqeQKE/9UK6JI4IhaDMQPPnIM2StyGkke+JtlFzCShdz2z2Sx2v5/0kwB2j+yY+S8+Pli1W73ICp+BFSwV5BkbhkLgcGJoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5800.namprd11.prod.outlook.com (2603:10b6:303:186::21)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 4 Apr
 2024 12:29:58 +0000
Received: from MW4PR11MB5800.namprd11.prod.outlook.com
 ([fe80::b022:a668:b398:77a4]) by MW4PR11MB5800.namprd11.prod.outlook.com
 ([fe80::b022:a668:b398:77a4%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 12:29:58 +0000
From: "Kolacinski, Karol" <karol.kolacinski@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Michal Michalik <michal.michalik@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v5 iwl-next 09/12] ice: Add support for
 E825-C TS PLL handling
Thread-Topic: [Intel-wired-lan] [PATCH v5 iwl-next 09/12] ice: Add support for
 E825-C TS PLL handling
Thread-Index: AQHahnHEJ1LudDsnJEmK4mvLIZne6rFX9LiAgAAU94w=
Date: Thu, 4 Apr 2024 12:29:58 +0000
Message-ID: <MW4PR11MB58005728FD74C12F9552E520863C2@MW4PR11MB5800.namprd11.prod.outlook.com>
References: <20240404092238.26975-14-karol.kolacinski@intel.com>
 <20240404092238.26975-23-karol.kolacinski@intel.com>
 <5238eaf3-cc47-470e-85ba-4930a2acbc15@intel.com>
In-Reply-To: <5238eaf3-cc47-470e-85ba-4930a2acbc15@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5800:EE_|CH3PR11MB8444:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnKotS2lot3hlmE46UsvxPZ5Ew4KJbDB5NCC/PeI0cfCTwdkLvloQt03Wr8qk0P28JRMs0RpNEQt3Nk+73gYxD6Z39fUmdLepm7YqorVg262byzuf4i56uT8UNkYT0/sLBkx/d9yyzOfqNS/yK4ZZ+oPvs+0adr6+kQKh7vrC3DZHrFUr0a0gHAncbCQYg8flMP6DcgdWIL34mivYZroP8sXQxqIEd9hiU7X/Z6cSwtYP7+TetYt8HPMlaIjgAy+SwkmpTIWpBjpWTZrbapzSHaTI1TqS7Uij33Kn0+vKpNwNPEWAUDuPTwEPpsyRg5VkARlZmJx4WT5/Tpgwi4dMeSmsN0/k7Lw+vwQG39ADseJ76peoyC1HNBaVROScn1Q9yC9sHkqb1SXwZB4CQn0J68Q6AjAgR57U+zIRViTFvPhP4/RN4gl6ZhUURniiGJ6a0O0oN15CcjM7iVsXuzSUcVh4LpFP1Q/Jl5r9m22F3S140Wg4nQk5QGdDtvR0HXlqjmwktMYiFZyhCkJr113cKmd2vfqz38IO84LEJjDTJwgTggL4iguDT7rhKCduyaLR+4Az5y91ZoRBi04HmL4qQxNLFeQOqpVeBfHm6VZ9WGYRE1RjjPCkRVYmxcWrROtYWu7wuU8BJkbnuVVhJKQKjrF+VyrFLIdyl/aATTV4Hg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5800.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?sLncuhrhqejg7HemCmCNLl606G07gqUHqFx0pzubJ/pgqds1Qyn4eS3AWI?=
 =?iso-8859-2?Q?VVHcMzVzcGvWbmjzvHeU/6DTz4yFmYc9gJUuPk+7DNaN71LGW3jUVJ4bOY?=
 =?iso-8859-2?Q?O5bivoXb8Bsn/4qtSsOFs3pyiZFKrGoddH6hb1fDuY9D0ZVvMDbJ7dDZHw?=
 =?iso-8859-2?Q?rxnDVq4r8ZcbX2ygbH0n/QrVUF4s6Z2WrYA12I0w7Yx0TRPRdQpflvkMo1?=
 =?iso-8859-2?Q?vYktMwXVhCirxnmFiTKQek6tOUxxnEVWPdnv1woN048z400DtZ29xKAieh?=
 =?iso-8859-2?Q?OQDTcjHki79mrFTJIBFiBL851WWUlYa7FU1B0tchhvjegIz6cmtz76TIB8?=
 =?iso-8859-2?Q?B/3nyrhXvsgrG0JCu+jw549blwRh5LywxH5yVC93+fxcSrzovyhKuet+l3?=
 =?iso-8859-2?Q?+ubQ3/l8+oBnLas0YIGRLfQwZJSwi0Zs0Rdu193rsvfAduU2QzqNS16Tmo?=
 =?iso-8859-2?Q?nc2VIYFMCzEbiWbm32sw2dY8NA8/bZC4YS35hkAi/5f6UAUMUVyp2qEVn5?=
 =?iso-8859-2?Q?LaTdWXUyjL4Mjshe8qz0astQq06yCs/WQfZa17C9+6nyru+JeHUmoZGTX/?=
 =?iso-8859-2?Q?4jkvA378TcLx4G4hpqQDQ6vuSuNWwmT1SqXQWAckrajk/bPMzrVwr1qJ/B?=
 =?iso-8859-2?Q?hEPrNDkDVVGatfpvnDgtOJvZoGoKRDLd21aLHFh8poHNtgxBxJGnp79Jt/?=
 =?iso-8859-2?Q?10FxbLzGroCvP3j2P0rqGzeReEwrF72LGadCa7V7EzxKJQnprfHZTpvnuW?=
 =?iso-8859-2?Q?//Sn8IlBbEYQ1NvdpeBVmiKVPQi3u0BYy31kA/HnQwIoc/VyNwE6uXs6Ct?=
 =?iso-8859-2?Q?nrfAwPwBmRXmLJ7hCPrDTa2PgNxGqCrODKxSLKp0eG+SvIXXoGsM3EOZCz?=
 =?iso-8859-2?Q?KHA1ClJH7t5d1kks7tOd1U30c2Hb1bwonmaUD2PPDW+7XJcuxGsmcZ1Uwm?=
 =?iso-8859-2?Q?toXsvLyEt67pnQWItPu43ooPb+m04UI2l5KC/k9FGeJolWS+7pGgHlrQ7S?=
 =?iso-8859-2?Q?rNDGTRbTCSkA/GvDM0XgoNaalqmcDjQPzxLKxkPvDUNc3fijZixop78PAM?=
 =?iso-8859-2?Q?kcFGYQ0IIJX4iO71z8V3wR9SOrSl5T7QRjcFKR5THY03WpXhvjnicQwLZW?=
 =?iso-8859-2?Q?xOzMbTinEHAZL4S+tiUwT+RTjlmIPQaVXQXhcC/90K6HnaikC1GxY6vz3c?=
 =?iso-8859-2?Q?zGnWX+Za/V5CoXF51gL9AR2sux9mkwPl8t8Xqem7GRl1lcGPY2S8gptNqr?=
 =?iso-8859-2?Q?zOedX1VDLW+KD1MQtVxBqNot91RNi3IEFl/QJ1CnFrVj2X1agUeRy0f/d+?=
 =?iso-8859-2?Q?bbvFOkdWZw+Ec2vIe60rfQMVRymKubRDAUDRU7B7el/TXAFOGEQsY0WgUm?=
 =?iso-8859-2?Q?mpPit63HZM32sQhx0pYzMA10MxoPnQ/WiLR8IIzCYUqrtqINEDauN4zS6Z?=
 =?iso-8859-2?Q?Vtzjshvi9UyZoGY1CmK5+UR87/CJcHhdpdF5/7k+Ob1APh13lOvZlPWMRW?=
 =?iso-8859-2?Q?c+g3Kg5FLwRtahGqbTrYzsYeRLr2SzDeqDOlXxd8fUWjGNaGqW84M9+9wY?=
 =?iso-8859-2?Q?dnIRTUKhje2HWDu46Nt2/vEGeAfXW1L81A+2a3MokDb26N4I4aDRhwpLXK?=
 =?iso-8859-2?Q?k1vWHIg8r8fpqZ/Oxe591V6Vh2DarncO6znlsKVTgdj+n8y4BSMjyPbg?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5800.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fa40c8-45ca-4664-d4d3-08dc54a2f12f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 12:29:58.7159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+FgArm+G6bqR41gjvVlUbgdwHt/lwW8SFZ1OGaVPvS1S8THamF3BLSfvZbkaNl6Ld5UVs/6hVMj5oIkow+ye6XYj1nJYjzsyRxtUnXLmsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
X-OriginatorOrg: intel.com

From: Aleksander=A0Lobakin=A0<aleksander.lobakin@intel.com>=0A=
Date: Thu,=A0 4 Apr 2024 13:11 +0200=0A=
=0A=
[...]=0A=
> > +#define NAC_CGU_DWORD16_E825C 0x40=0A=
> > +union nac_cgu_dword16_e825c {=0A=
> > +=A0=A0=A0=A0 struct {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 synce_remndr : 6;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 synce_phlmt_en : 1;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 misc13 : 17;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 tspll_ck_refclkfreq : 8;=0A=
> > +=A0=A0=A0=A0 };=0A=
> > +=A0=A0=A0=A0 u32 val;=0A=
> > +};=0A=
> =0A=
> Will this work on Big Endian systems?=0A=
=0A=
I guess it won't, not sure about compiler behaviour.=0A=
It would probably work better with masks defined and le32_to_cpu().=0A=
=0A=
[...]=0A=
=0A=
Thanks,=0A=
Karol=

