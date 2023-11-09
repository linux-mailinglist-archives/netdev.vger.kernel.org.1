Return-Path: <netdev+bounces-46795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 354807E6739
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86661B20C3B
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A6013AD6;
	Thu,  9 Nov 2023 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RV6EywTh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2018313AC6
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:59:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCEB2D56
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 01:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699523962; x=1731059962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Awwr7rprL2z24zmRbKeBzKnQip38UGIZg5eUF3UZwD4=;
  b=RV6EywThCHAM7bmQw33qwm+taf/HaDN+chF+C5egMBACIjn+fw7zj9V8
   qWCnOoG4ExSgyWBnwffEsFL0rJ1uVna/LFEQresYZZjgpFddQfnEMIueW
   j0EQnBR9aKIvrrat3t7Kiu0hQlMARvbx+0l30I9rPrBOzK9NGGFwR/nFI
   5zin4A85cOx1dMh1AMt2gd71NMrXWXD9iDjEfo07FRpN0Ib1rxALn1d2S
   +oFCsY/I/qyc9pinPy9TLvAOOnxRy1JG8EXNVGrgTcGHgXMhOf6pfkkDT
   FDuZlxuAlEdb9rML0a7n7r4Jgsom8KBfK728JA7NtWis4lfIN5hsKfsYY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="2983537"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="2983537"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 01:59:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="854032494"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="854032494"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 01:59:08 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 01:59:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 01:59:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 01:59:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 01:59:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZihXBoGDDEFO39q5ImTJD93BJKpneOJaw4YSwewYZe6gVS28UtyZ6A9GzWtzXzMrFRIYMCb726V47WUUNUv0U9xzvpXxCHTwoltNS9TFaOAC974cEApmHOCU1FrZ7dQXnntnZ+ZiD/zHyUWQ6qQTStF22aejor+WNgGH/dU49AmG3DKpSCIxxs/y7i9qHp5rHg8syIksksGGgS1WKHNvnNG6BHLkUjcqtFStWbFPY2NvqhEFnqGBL3CTL9PoXh1FcR7aqt9UxK02Stn1yoVAU7+nqm9GOQaSdFnxOs5la0CCdwlzfrz9KxRXk+oC2HesTZPvEtJtuvVsW21bdOWzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quIywg2d78/qiccreumLBcTzuAWm8g+l0Z20+ph9KDA=;
 b=IsRAKLrkjzHQFJs14NAzF8tgxW3/HUQCIAWkVAh+FausiD99j5Dx+o1fK0tw8zydW/6qcf4Tv9RA9XkPt6D5eynT+C8a/Z2FGDGdkdQpbhoEtyYr37c/8vu9vfM891YOimsSGoEu18WsEhCwfcWp/uygaNN7yTwH+sbPENqIata3e4eEIEqay8ftYA/h7zEukqltcSjaKCGqKIIX+pw8nUCM+VDttgnsn41pIeFnbME93l7i73xRCJjrSkHYc2+5+lKVxsqytBLLUSmbqVPodPL4U/Tcm+rdODFrU1xqQ7XHzGxzFC08/4xD+wPcV8nMLYq0pKgncGIvr9DGgNbPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 09:59:04 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 09:59:04 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Thread-Topic: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Thread-Index: AQHaEi9R20w3ZLh/s0yEUYAIdOH3G7BwhkSAgAE6GCA=
Date: Thu, 9 Nov 2023 09:59:04 +0000
Message-ID: <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>
 <ZUukPbTCww26jltC@nanopsycho>
In-Reply-To: <ZUukPbTCww26jltC@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|IA0PR11MB7308:EE_
x-ms-office365-filtering-correlation-id: ce1519f5-d6fe-4a8d-a590-08dbe10a8184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wjqyUUMgbGz/FfFQiGT3csgha9mwBnzsGr15E8Mz4Yxcdn2FrHEUZy54teYtNav0kCcZUDKtuLynFLxXZk+Kwxa43gTCVLa++1RKSL7LycOryZz8zsboGQJAxEf3yXGslrL/M4EMkqeY9e10cCwXUanXMKhO73XVTdpB19eosIaT/25G8qlFPyvKyO+dUa4Qi4rjYRCk4YxEiPkDvP/b/FRHDmrhMf2EoBcypJkTXmHOYdn2AgzQIDbr8yX/M91AQ4wHr+DXgmksCWCi9MlY5FOmdAvtfJ/OsqaoDgOUp8CQ1M1YTxHdrlz70k5UMOcKCG1FR+AzCrfrMk8z+4r7B0gMakTmsa1fvb4ZEr0TgElKA8LEZEHFNN7jGMr6X4GsG9odD8jNGQmF+xobWhXT/LmBOArAC+xemqaeKO6y+IiI4Ba6IV08lGOmL4f+nlQDdzNmGAaOAKvWWc8I4RL7UDQJav2Lgru1GgBvlgE/aMKVr2C2Pm4S9+caBOSatlkrRpk7eNy6gEEj7TYo+Lu9le8noCcULXbk2TigraJEOdc4I7keDjKuyoWSjHJANATTC98qqFFwlGVqtD53WXDueAjSUo5ADUcOquz46nA4wWOD9LEnqZmydDcMwKf4RDMu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(7696005)(6506007)(26005)(33656002)(9686003)(38100700002)(71200400001)(38070700009)(83380400001)(86362001)(55016003)(478600001)(66446008)(66946007)(64756008)(66476007)(41300700001)(66556008)(76116006)(54906003)(122000001)(6916009)(5660300002)(316002)(52536014)(2906002)(82960400001)(4326008)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X3azcwk5jZ59vEa8hv6yuVEjCxv4wGOLCE+rNdzCkVTdkgrN17qUoRnI4gKl?=
 =?us-ascii?Q?k1Z0COtHbQpE1XYgxN1zCegSDhnYqtW2awW3MgCxYZkJ3GWm5UrZoFSPpkPM?=
 =?us-ascii?Q?DybMxHhUtk7FQHBxselSxeAuG46gnoptVGYf7LWNy8MgtLFMVs6mf3LkzVUP?=
 =?us-ascii?Q?ZbKTnANLRxNdzkZEVUbbLc/XCPfHkcyXnRxpfXSevm/dKGclGEYSFAfRmCey?=
 =?us-ascii?Q?ZjbFMIvPOnSZbws/QZUMasUm4IU0Jsm4blXhUVtSAAKDcINBBOuFCs4CZ5v2?=
 =?us-ascii?Q?XlbKwibV3F82tpiF+oRVm11kgAdhzQflpcKIefpzy4E2PtyR9hyB9UG3u/74?=
 =?us-ascii?Q?9/ONOJahC11/+MzderA5+pNqmDinzLLb3chybPOpzve87jIuEJPw258b9Vun?=
 =?us-ascii?Q?CYGrpRbnymChcF4Dk2wKzQgadkR0FdJqTjCvuo+hbA8RHewHzfJuBShc2U8+?=
 =?us-ascii?Q?lEtqV7nGb5p/LG0sQAf7hnbweu6VQqlBBsl6Ek4UPt/7APpHTTQ98dOKiyO0?=
 =?us-ascii?Q?jnQNuBm1xarsLGts4xq5KQGUmZADHREMHOq07f+ae7onCdLFWr0R+uTirNJQ?=
 =?us-ascii?Q?JlRwT54cMN0j4mqAz4f9PRJ+/J5pRYBfSl/YZeZktcDR8faBle4KNm4+oaUa?=
 =?us-ascii?Q?Al/H8MSb2rn+hcyvDpY6NZgJKjcR9Y3IqcSSrjO1tEXWV8v2DjlXC1HlCCgJ?=
 =?us-ascii?Q?cxW/6Hpy443bUETb2y08OKyX4DWohHVQ9zmezYXSxAMY0mmNX/btksUpna5Q?=
 =?us-ascii?Q?V0dqGTGoIOVI8x3qfV5L/dR18TWbZ8gkFKAaYLl9nCkLbwskskjd8nJZ/mCa?=
 =?us-ascii?Q?/awLT6HvaV1SRMsbnZLPqiGuw0ocS2IrWjGtNqe1VqjfAOy53eHwOxVyikkq?=
 =?us-ascii?Q?Ju9WRjDjQMqjNIa23ol0VdTG+Q58NgqkSajnE+2iEo8DJHXQnrtjR4Lp6DPm?=
 =?us-ascii?Q?oVpABSmWJOqrxZMxMoXobGfUMg1ruldNrxWo5pGY+NNbLF8edDXOaub8G18C?=
 =?us-ascii?Q?Ux81+gayQGV9nAovt7jmFOqnt2VNGKQkwmgk8kjzy4C8Z/+Ws5GAcFSPuW14?=
 =?us-ascii?Q?2IqNTgt3Hl9FhglkJQF9ZZfzACyX7GSsT1vGCK6pkhUf6fC7qy5aDak90PO9?=
 =?us-ascii?Q?5jhSg8Enrt/q4xTNyeFpNHf4uHkB5YKdSPz3dJn2T4ri+L3JrY+TiTVoz8CW?=
 =?us-ascii?Q?sWLcdzgJrh1CLFaASRtLooetDAfCC9VEw0X/diRP6D4tyYO4BLJDzVj6hrXX?=
 =?us-ascii?Q?nlE2f/Gy5OVaflNomBUuC9BGl2+Jg1l2QPE9ZwuUrgFz59lcHChiWE7YhW7X?=
 =?us-ascii?Q?GSzgCVszhV6GQq00fLKGKYduoHofLYY6MnTOnsOXEx7fZOR2M9U4E5LCAuzD?=
 =?us-ascii?Q?W6sVmPUuy6E7g8Q3BQoawaDZTTxMnhDFYoNVtmJNO1EKJnExHgRqHtwGPb0L?=
 =?us-ascii?Q?EDTsU4hxI87nQ0UJVY5eNd6NSTlkSdCDSnMc+xm0e9Vm9diVT7auUfpQj3Cf?=
 =?us-ascii?Q?k9AnnixvQ+XT5mctHs//9oBiQqIKmYXxl3SI8JgOlVNrES5L9Xvvj7ULWwyV?=
 =?us-ascii?Q?ZX81c9v8Iyukj1q325JYsv1St3e9hilgQjYSfFsyA1UsEVIT3Cic6pR6VXkV?=
 =?us-ascii?Q?Cw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1519f5-d6fe-4a8d-a590-08dbe10a8184
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 09:59:04.1607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3TlOOiVMtcPx/7EAR4AcIu0Py3bPAe6qHUd7gaaiVJiaemwUHkPwLR56+1i3Jf/7e8/pPyrLcXvonuC5BDrICr8vDMl46Icc4F24oO6hR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, November 8, 2023 4:08 PM
>
>Wed, Nov 08, 2023 at 11:32:26AM CET, arkadiusz.kubalewski@intel.com wrote:
>>In case of multiple kernel module instances using the same dpll device:
>>if only one registers dpll device, then only that one can register
>
>They why you don't register in multiple instances? See mlx5 for a
>reference.
>

Every registration requires ops, but for our case only PF0 is able to
control dpll pins and device, thus only this can provide ops.
Basically without PF0, dpll is not able to be controlled, as well
as directly connected pins.

>
>>directly connected pins with a dpll device. If unregistered parent
>>determines if the muxed pin can be register with it or not, it forces
>>serialized driver load order - first the driver instance which
>>registers the direct pins needs to be loaded, then the other instances
>>could register muxed type pins.
>>
>>Allow registration of a pin with a parent even if the parent was not
>>yet registered, thus allow ability for unserialized driver instance
>
>Weird.
>

Yeah, this is issue only for MUX/parent pin part, couldn't find better
way, but it doesn't seem to break things around..

Thank you!
Arkadiusz

>
>>load order.
>>Do not WARN_ON notification for unregistered pin, which can be invoked
>>for described case, instead just return error.
>>
>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>functions")
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>> drivers/dpll/dpll_core.c    | 4 ----
>> drivers/dpll/dpll_netlink.c | 2 +-
>> 2 files changed, 1 insertion(+), 5 deletions(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c index
>>4077b562ba3b..ae884b92d68c 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -28,8 +28,6 @@ static u32 dpll_xa_id;
>> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>-#define ASSERT_PIN_REGISTERED(p)	\
>>-	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
>>
>> struct dpll_device_registration {
>> 	struct list_head list;
>>@@ -641,8 +639,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent,
>struct dpll_pin *pin,
>> 	    WARN_ON(!ops->state_on_pin_get) ||
>> 	    WARN_ON(!ops->direction_get))
>> 		return -EINVAL;
>>-	if (ASSERT_PIN_REGISTERED(parent))
>>-		return -EINVAL;
>>
>> 	mutex_lock(&dpll_lock);
>> 	ret =3D dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv); diff
>>--git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c index
>>963bbbbe6660..ff430f43304f 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -558,7 +558,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct
>dpll_pin *pin)
>> 	int ret =3D -ENOMEM;
>> 	void *hdr;
>>
>>-	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
>>+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>> 		return -ENODEV;
>>
>> 	msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>--
>>2.38.1
>>

