Return-Path: <netdev+bounces-50184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4921C7F4D39
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DC528141E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F84D5AD;
	Wed, 22 Nov 2023 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYJ+GHG7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A44D6E;
	Wed, 22 Nov 2023 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700671806; x=1732207806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MX8Fm9RxxOI0g1HrR/56nyJnWXz/DqoMb7RodpUVixU=;
  b=cYJ+GHG7zQlW9ELikb3J4tjebDsjJdre5FcIff5s65aGTu9SoRDRdSaN
   9K7JKTTp3cmpWgDqv17yoYeB8w+NcYD0FEXOq7t1E3kRpGwc9nYxRXDd9
   DZePokuPy8NyjiTOMeN2CRc8Ry/EcdqDUN37W8KDV08ywHkpg0eFnDx8M
   gcRNYRacRFqMtRbLmJpr5g6aNInnHy+wtxgXK7RpqOAY5qbWMvZJPa0vi
   aNjEpONQ4KVDot5M+4SXs0Q9PwKMacg4PBr20E8lKtw3qZXaFZH0wc5Je
   +t927LKZo8b6jeeJRGmUg30Hzm3RWx4b8RSk5BUHjdxEsEnkcWz10BzBj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5232753"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="5232753"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 08:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833088858"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="833088858"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 08:49:57 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 08:49:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 08:49:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 08:49:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS+9RZjQuGh+Ybo2F6X2vQMOVViHmRLImi6CMe2wel1YVuyKKgqKOh29P6s1gowPuIi2NjhBCdeijGMnyWn6EwBH0wYy+e2FV1yEqUePnAxSJt8ZN4QlYnDA7DtNbsZ6z0T8zh2XWrV7IGn1Uupoh8Bd0aKmMjTiZCNl0pA67D+io1+jBxVkPMa5hxm++zXnChDGeLRklq6aX/Tm+h7bbe30BYGZ9FDy+3mvdU813HaxBvZKs+R9RiLX+E5JOXxlr/OQsUozHY8EcyNvIXW649imHTahuhD20NFoLrRDooYXKy/sLLr1oZlzMl2Hd2xJbM2F+up/lZmxy8gRMWxVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaPbEW68nnWWPJpfX9HGV3aqE9rF+Pi3BSio8WzFt6I=;
 b=D/lOHL92JcNaxeOp8IrB+ZBTI2WOz/61ayXib2oqTaBSBOE3Zn4JSAwqxyqZqzvaI1RpkP8CScTItP6S5LxIEDxoy74I9e2pmjT26//vMzZ1vbaN8bgyOD6KpN0PVBasQk0mRTphTh9PcOU2LEke5yZwhopQFzuVy1MFlUxckdLD7u53Kf+qxhaWxXrDtX19E5K7j/aT8q/xmM2t6z0Tg2tFdc4045Ci/eNyB7zmx83NvbpQsMKNZHfFgJomFC2IiPeCBqC+4gut/5oVkv+59W7ruKW9fioPquKLj7Huy4FgiSlBvOwcNiJ83fb8alDzSqmOPYoHCIk00VyyAyxmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by MW6PR11MB8337.namprd11.prod.outlook.com (2603:10b6:303:248::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 16:49:34 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 16:49:34 +0000
From: "Michalik, Michal" <michal.michalik@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>, poros
	<poros@redhat.com>, "Olech, Milena" <milena.olech@intel.com>, mschmidt
	<mschmidt@redhat.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH RFC net-next v3 1/2] netdevsim: implement DPLL for
 subsystem selftests
Thread-Topic: [PATCH RFC net-next v3 1/2] netdevsim: implement DPLL for
 subsystem selftests
Thread-Index: AQHaGYkLDd6Kay4e9UW2QkCiJNJMubCDd0KAgAMUVAA=
Date: Wed, 22 Nov 2023 16:49:33 +0000
Message-ID: <CH3PR11MB8414A2B45B06EC5ACEB3A525E3BAA@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231117190505.7819-1-michal.michalik@intel.com>
 <20231117190505.7819-2-michal.michalik@intel.com>
 <20231120171531.GA245676@kernel.org>
In-Reply-To: <20231120171531.GA245676@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|MW6PR11MB8337:EE_
x-ms-office365-filtering-correlation-id: 648eb131-7644-41b6-6ed1-08dbeb7b011b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s0GOavVGocmcPZVHyg9cfjWJF5LSNOBCaMaTm/+7ggxR6KNcGO2cjSSaJqsDtfSQvGVHuejMvCduSXNcSrQmhVm2wzfAzyRD+YtJ2ukJ8gmevv+DOScuBMp10c1FsZ54/z7SY63Zx/IRiG13x5T0NMdRk27LUYM7F19bwCI9CHtTrhEdbD8kXpkxL+rB+uhNWkx072fPOOOr/bQsx+eLxP0HCwWWYJolnb9G8azH6Prr2vVP8c7W8uE1exPUwpGp37ERaC7ToTPx4eTvWQ+fyOZ9nUEnO7vVfzPc/MXOZSTjeYFjvQid9Ai4DGwbfIs/nZ6xZejr47sTY2D+4XFzCQN1S2aWqOIpq7WOJ5YaMVAFzzY8Wp5ccgw8fWdU15P50jEjCqVILBzyZJbadAAR4kEfUuzV/LBuMKOgR4dgTsZIfIzhxSF6ctyxnJE2CRXdhB1yOI7OZqB1Xif0lpTipgv0a/wHT/toGdsK6KLbOwud2MCvMo2r16B+NEsDIkVYcD1a6hXnz8V54BW4L4/pXJ1wNmZS3r4eSiD5xv/Xj8OrmRn2JyHWH2n9KsG2l2p7P2Un5kEdjx0pjgi+RHwvSWi5FbVE8NcVRy+qquaz0Gs8A0IxGpqgclBq7FQhPCK+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(122000001)(38100700002)(82960400001)(33656002)(86362001)(38070700009)(83380400001)(6916009)(54906003)(316002)(8676002)(4326008)(8936002)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(55016003)(41300700001)(52536014)(5660300002)(7416002)(2906002)(53546011)(6506007)(7696005)(71200400001)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qw48jt+5knFIIO0lB6iw5TNKAZvGxg+JXmGY/Mz30HCtPuK3P+voFBSNNU/u?=
 =?us-ascii?Q?u3tC6KqC1DSWKQfbkdUdmW2g9GyEllItVd+eoKzwPII7J0ZG7zMbhq35rgWn?=
 =?us-ascii?Q?NOgKwou0ntHvUKpXQnqKhlguatJG6Gqw3OyW8oDcRJIRdDNRUESAtdbKD4yE?=
 =?us-ascii?Q?kMybRfRxaFpfevBDOEilyDCs79VaYnasstxk2wMosCHsKvO+gy3zVN4Ijobl?=
 =?us-ascii?Q?8zYQClywi2Np4mRsWl2a/4XommcMKaZkYhSEeRhin5nHQVObcBdrGDsSxEkt?=
 =?us-ascii?Q?x5otDAb3UaUk4vFFPCOIFam+V06A47cKbgk9SDLURH+ggGtP+8dCqXrW6lgF?=
 =?us-ascii?Q?RntW/NeeDADRxUGSHKdWHF6uQFxgrjis+OLsSjCv5zuJs4QojM/kkzIUxJny?=
 =?us-ascii?Q?Mn4tZSGbbFUzemB/dRZTenZLmfx5gBieKcGmlIE7iE8z5kzXElXDQl7SiWPt?=
 =?us-ascii?Q?gZsdrEkFyBkgZecd6CC6eJ2mTAXMahVJkR8r0Bi88gjqZDUF2EXNXK0k29Qi?=
 =?us-ascii?Q?lTKBLsWS8bg+tNOiXWV8NI/4CSdpb6z5jxpJO58jBmng97Z6m4vfcHr5V5qO?=
 =?us-ascii?Q?dLv/q+o0Hhr08l+YOJTWtoZ+7xTF+qPnOFyifCPGzAcTOBFExskN5ABs7PgG?=
 =?us-ascii?Q?Yc4FmMyWUN1F28GY66nRzgnpQbgMNPo9Y3xUUjxHMcclK4DdRgcEEwD+7xpt?=
 =?us-ascii?Q?za/uQp3D8vHbL09iH9wDEKXgq4Ea2BzeZ4krytPWue5ieEVvfZZIZ6fAawLT?=
 =?us-ascii?Q?ZZtpc/Xzg/Y/bKRXLLOkacvjhKg74CuoX4Wa6xMUc+JsHiA/HjHZCCgsPXY7?=
 =?us-ascii?Q?HKnwJcEi6WhuMKZwY1Bt6cAk3qzFizYoaiTlFMYQqXkjAj7uW4mQXjAaQcyd?=
 =?us-ascii?Q?cI0ElouDDzb3xyroj0mkia3NwRT141QeZcbfM/3n9uh8iGiewWEQMm9lO0l3?=
 =?us-ascii?Q?CUM/HW3e9d7Jg/um3TJnqTFQ2oQtOE7Dw/KOK4/xzS83MDFEO49mvd7ieIZY?=
 =?us-ascii?Q?hRRyeBiqUjQsRlnUvXgmMd0TIYBW2OuqGCGnpeGeqrv5nUeZv4hHU3NBvI5L?=
 =?us-ascii?Q?5hc/yc0nI+E/mPupjDL01qTpd9atNs6kTke+LXSSycS7CIehnxdzoSwbKQ3S?=
 =?us-ascii?Q?bWmpAeVcCpXSPFqOzT1hRWOtf9KaF2Vyzmh1dK3O3VvualYhIjc1tW2AKuMa?=
 =?us-ascii?Q?ElwQSdXFB12coj3KxF4jivPGboT6WzusSacLSyMnGyG7gM/IituUVawBUkLK?=
 =?us-ascii?Q?nR5ZErfKWGdmILwYgy0mbLR/sbqpQMsj/gP2KXIcigXfgbry/z4zGtWJJBry?=
 =?us-ascii?Q?o3J6twDS4NCMbtqKeVv55YJBHudlg6IIiefsLthOD4HBqJC8SWFgaL/LjB67?=
 =?us-ascii?Q?wOaXFWSclVx+BlYBooOEsVQWVzfcqqXFfkqz4IE8sbUNKcXV9mhBLuO3g4ab?=
 =?us-ascii?Q?X0lAhHt2H0zD7jV/8sNygxfR29Wqu6OvWZXWIRwR+5kdb4iamy3IKTB4Oacx?=
 =?us-ascii?Q?D2kAyEXiPWYFprZijq9rNGHl8jXIXd80lFIUXoG4vVW1PuFWriO3zaUWqMlr?=
 =?us-ascii?Q?9hrbatfwJ+Zjda7N/YtQB04sSHOz5EGEuf4HUau5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648eb131-7644-41b6-6ed1-08dbeb7b011b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 16:49:33.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwqeU0oB5+gk+sSmbqqI+jFU4fPiMZ+jbzm5omFoE2WMcLWmFuYDp3w5YwYdrok8v+B5z9lgbQOUYL1z4xTF7nl06/SpEWxj/NnViv6eDnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8337
X-OriginatorOrg: intel.com

On 20 November 2023 6:16 PM CET, Simon Horman wrote:
>=20
> On Fri, Nov 17, 2023 at 08:05:04PM +0100, Michal Michalik wrote:
>> DPLL subsystem integration tests require a module which mimics the
>> behavior of real driver which supports DPLL hardware. To fully test the
>> subsystem the netdevsim is amended with DPLL implementation.
>>=20
>> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>=20
> Hi Michal,
>=20
> Nice to see tests being added for DPLL.
> some minor feedback from my side.
>=20

Hi Simon - much thanks for taking the time to do such a great review.

>> diff --git a/drivers/net/netdevsim/dpll.c b/drivers/net/netdevsim/dpll.c
>=20
> ...
>=20
>> +static void nsim_fill_pin_pd(struct nsim_pin_priv_data *pd, u64 frequen=
cy, u32 prio,
>> +			     enum dpll_pin_direction direction)
>=20
> nit: Please consider limiting Networking code to 80 columns wide.
>=20

Ohh - yeah, I overlooked that - fixing.

> ...
>=20
>> +int nsim_dpll_init_owner(struct nsim_dpll *dpll, int devid,
>> +			 unsigned int ports_count)
>> +{
>> +	u64 clock_id;
>> +	int err;
>> +
>> +	get_random_bytes(&clock_id, sizeof(clock_id));
>> +
>> +	/* Create EEC DPLL */
>> +	dpll->dpll_e =3D dpll_device_get(clock_id, EEC_DPLL_DEV, THIS_MODULE);
>> +	if (IS_ERR(dpll->dpll_e))
>> +		goto dpll_e;
>=20
> Branching to dpll_e will cause the function to return err,
> but err is uninitialised here.
>=20
> As there is nothing to unwind here I would lean towards simply
> returning a negative error value directly here. But if not,
> I'd suggest setting err to a negative error value inside the
> if condition.
>=20
> Flagged by clang-16 W=3D1 build, and Smatch.

Fully agree, will return immediately with - EFAULT.

>=20
>> +
>> +	dpll->dpll_e_pd.temperature =3D EEC_DPLL_TEMPERATURE;
>> +	dpll->dpll_e_pd.mode =3D DPLL_MODE_AUTOMATIC;
>> +	dpll->dpll_e_pd.clock_id =3D clock_id;
>> +	dpll->dpll_e_pd.status =3D DPLL_LOCK_STATUS_UNLOCKED;
>> +
>> +	err =3D dpll_device_register(dpll->dpll_e, DPLL_TYPE_EEC, &nsim_dds_op=
s,
>> +				   &dpll->dpll_e_pd);
>> +	if (err)
>> +		goto e_reg;
>> +
>> +	/* Create PPS DPLL */
>> +	dpll->dpll_p =3D dpll_device_get(clock_id, PPS_DPLL_DEV, THIS_MODULE);
>> +	if (IS_ERR(dpll->dpll_p))
>> +		goto dpll_p;
>> +
>> +	dpll->dpll_p_pd.temperature =3D PPS_DPLL_TEMPERATURE;
>> +	dpll->dpll_p_pd.mode =3D DPLL_MODE_MANUAL;
>> +	dpll->dpll_p_pd.clock_id =3D clock_id;
>> +	dpll->dpll_p_pd.status =3D DPLL_LOCK_STATUS_UNLOCKED;
>> +
>> +	err =3D dpll_device_register(dpll->dpll_p, DPLL_TYPE_PPS, &nsim_dds_op=
s,
>> +				   &dpll->dpll_p_pd);
>> +	if (err)
>> +		goto p_reg;
>> +
>> +	/* Create first pin (GNSS) */
>> +	err =3D nsim_fill_pin_properties(&dpll->pp_gnss, "GNSS",
>> +				       DPLL_PIN_TYPE_GNSS,
>> +				       PIN_GNSS_CAPABILITIES, 1,
>> +				       DPLL_PIN_FREQUENCY_1_HZ,
>> +				       DPLL_PIN_FREQUENCY_1_HZ);
>> +	if (err)
>> +		goto pp_gnss;
>> +	dpll->p_gnss =3D
>> +		dpll_pin_get(clock_id, PIN_GNSS, THIS_MODULE, &dpll->pp_gnss);
>> +	if (IS_ERR(dpll->p_gnss))
>> +		goto p_gnss;
>> +	nsim_fill_pin_pd(&dpll->p_gnss_pd, DPLL_PIN_FREQUENCY_1_HZ,
>> +			 PIN_GNSS_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
>> +	err =3D dpll_pin_register(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
>> +				&dpll->p_gnss_pd);
>> +	if (err)
>> +		goto e_gnss_reg;
>> +
>> +	/* Create second pin (PPS) */
>> +	err =3D nsim_fill_pin_properties(&dpll->pp_pps, "PPS", DPLL_PIN_TYPE_E=
XT,
>> +				       PIN_PPS_CAPABILITIES, 1,
>> +				       DPLL_PIN_FREQUENCY_1_HZ,
>> +				       DPLL_PIN_FREQUENCY_1_HZ);
>> +	if (err)
>> +		goto pp_pps;
>> +	dpll->p_pps =3D
>> +		dpll_pin_get(clock_id, PIN_PPS, THIS_MODULE, &dpll->pp_pps);
>> +	if (IS_ERR(dpll->p_pps))
>> +		goto p_pps;
>=20
> This branch will cause the function to return err.
> However, err is set to 0 here. Perhaps it should be set
> to a negative error value instead?
>=20
> Flagged by Smatch.
>=20

It seems I need to start using Smatch - thanks for pointing this error, fix=
ing.

>> +	nsim_fill_pin_pd(&dpll->p_pps_pd, DPLL_PIN_FREQUENCY_1_HZ,
>> +			 PIN_PPS_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
>> +	err =3D dpll_pin_register(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
>> +				&dpll->p_pps_pd);
>> +	if (err)
>> +		goto e_pps_reg;
>> +	err =3D dpll_pin_register(dpll->dpll_p, dpll->p_pps, &nsim_pin_ops,
>> +				&dpll->p_pps_pd);
>> +	if (err)
>> +		goto p_pps_reg;
>> +
>> +	dpll->pp_rclk =3D
>> +		kcalloc(ports_count, sizeof(*dpll->pp_rclk), GFP_KERNEL);
>> +	dpll->p_rclk =3D kcalloc(ports_count, sizeof(*dpll->p_rclk), GFP_KERNE=
L);
>> +	dpll->p_rclk_pd =3D
>> +		kcalloc(ports_count, sizeof(*dpll->p_rclk_pd), GFP_KERNEL);
>> +
>> +	return 0;
>> +
>> +p_pps_reg:
>> +	dpll_pin_unregister(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
>> +			    &dpll->p_pps_pd);
>> +e_pps_reg:
>> +	dpll_pin_put(dpll->p_pps);
>> +p_pps:
>> +	nsim_free_pin_properties(&dpll->pp_pps);
>> +pp_pps:
>> +	dpll_pin_unregister(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
>> +			    &dpll->p_gnss_pd);
>> +e_gnss_reg:
>> +	dpll_pin_put(dpll->p_gnss);
>> +p_gnss:
>> +	nsim_free_pin_properties(&dpll->pp_gnss);
>> +pp_gnss:
>> +	dpll_device_unregister(dpll->dpll_p, &nsim_dds_ops, &dpll->dpll_p_pd);
>> +p_reg:
>> +	dpll_device_put(dpll->dpll_p);
>> +dpll_p:
>> +	dpll_device_unregister(dpll->dpll_e, &nsim_dds_ops, &dpll->dpll_e_pd);
>> +e_reg:
>> +	dpll_device_put(dpll->dpll_e);
>> +dpll_e:
>> +	return err;
>> +}
>=20
> ...
>=20
>> +int nsim_rclk_init(struct netdevsim *ns)
>> +{
>> +	struct nsim_dpll *dpll;
>> +	unsigned int index;
>> +	int err, devid;
>> +	char *name;
>> +
>> +	devid =3D ns->nsim_dev->nsim_bus_dev->dev.id;
>=20
> devid is set but otherwise unused in this function.
>=20
> Flagged gcc-14 and clang-16 W=3D1 builds.
>=20

Yes, I noticed that and already fixed it in my branch.

>> +	index =3D ns->nsim_dev_port->port_index;
>> +	dpll =3D &ns->nsim_dev->dpll;
>> +	err =3D -ENOMEM;
>> +
>> +	name =3D kasprintf(GFP_KERNEL, "RCLK_%i", index);
>> +	if (!name)
>> +		goto err;
>> +
>> +	/* Get EEC DPLL */
>> +	if (IS_ERR(dpll->dpll_e))
>> +		goto dpll;
>> +
>> +	/* Get PPS DPLL */
>> +	if (IS_ERR(dpll->dpll_p))
>> +		goto dpll;
>> +
>> +	/* Create Recovered clock pin (RCLK) */
>> +	nsim_fill_pin_properties(&dpll->pp_rclk[index], name,
>> +				 DPLL_PIN_TYPE_SYNCE_ETH_PORT,
>> +				 PIN_RCLK_CAPABILITIES, 1, 1e6, 125e6);
>> +	dpll->p_rclk[index] =3D dpll_pin_get(dpll->dpll_e_pd.clock_id,
>> +					   PIN_RCLK + index, THIS_MODULE,
>> +					   &dpll->pp_rclk[index]);
>> +	kfree(name);
>> +	if (IS_ERR(dpll->p_rclk[index]))
>> +		goto p_rclk;
>=20
> This branch will call kfree(name), but this has already been done above.
> Likewise for the other goto branches below.
>=20
> Flagged by Smatch.
>=20

Good catch - will move the free above just before "return 0".

>> +	nsim_fill_pin_pd(&dpll->p_rclk_pd[index], DPLL_PIN_FREQUENCY_10_MHZ,
>> +			 PIN_RCLK_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
>> +	err =3D dpll_pin_register(dpll->dpll_e, dpll->p_rclk[index],
>> +				&nsim_pin_ops, &dpll->p_rclk_pd[index]);
>> +	if (err)
>> +		goto dpll_e_reg;
>> +	err =3D dpll_pin_register(dpll->dpll_p, dpll->p_rclk[index],
>> +				&nsim_pin_ops, &dpll->p_rclk_pd[index]);
>> +	if (err)
>> +		goto dpll_p_reg;
>> +
>> +	netdev_dpll_pin_set(ns->netdev, dpll->p_rclk[index]);
>> +
>> +	return 0;
>> +
>> +dpll_p_reg:
>> +	dpll_pin_unregister(dpll->dpll_e, dpll->p_rclk[index], &nsim_pin_ops,
>> +			    &dpll->p_rclk_pd[index]);
>> +dpll_e_reg:
>> +	dpll_pin_put(dpll->p_rclk[index]);
>> +p_rclk:
>> +	nsim_free_pin_properties(&dpll->pp_rclk[index]);
>> +dpll:
>> +	kfree(name);
>> +err:
>> +	return err;
>> +}
>=20
> ...

