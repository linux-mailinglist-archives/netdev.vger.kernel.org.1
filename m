Return-Path: <netdev+bounces-47027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBC07E7A5D
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222B12814BA
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FCCD307;
	Fri, 10 Nov 2023 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXiPcsv8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD34D269
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:02:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E385AAD01
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 01:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699606920; x=1731142920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gPAEedPNwmkr7XR0gfn8ef7+XjcNS1PdYJ9nNkzcwoA=;
  b=bXiPcsv8rohwcrlVHSwy+u+tWCSE+BKul6CGDRfUB+o1TIQWpYK+ei8P
   GKzDkk7yIzhgiFqpi+Dnra7sWMf8OHzfvQvLUxXZDSrypqFks8qgj51oS
   EnYXXLZHe3j5e2dP8RizurjvirKRXXc2+XJyRPMBxLu8iqHtH4g5RJqR8
   YlNomjwsAQOTmk5bH1ub04DzgWY5KuhqsDSTPjrV/szKzX6jlowQXJ/pk
   u8ftGeCDXcTs0CwdjFe3oxgRDlmvJ7DxT+9VBx+fnhaGnCcVow9ktOwv1
   8yurP0WXwn4ehcZITe2DWiUbAlaviEn81agg5e7z8sdMBaLxgyB1is+9z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="375198246"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="375198246"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 01:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="757154622"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="757154622"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 01:01:58 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 01:01:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 01:01:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 01:01:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtIBqb0DsDrgojr4ymQ7jOyJG4sgMMjGjaGmMlQUZluxWFhoIy0h9TenDBB3OjmIk4IuMoN+gNuNI2gHKm/M5wwlefk5sgb70Dfz1PgSKE4UM7YxYfXw1SNkeCUKkvPesC9qA+bK534UibZOlQ0oFf4ECcCoxO4YV51DTJTUmHdjw00uZtyTB80BPGkE4xEeEKwCLDhdvqsMhk+eDyU9kGBMosNeyt2Vd2C3bGFhyFDUMDbtDjmEWkkOYYTsmdTtaNRBp+cdJwE8/6Q86bGSF420BEXoAjNb3rKrMqPtUwAW4XeqqX4Rk17rHbzOY7g3bUQgpnsVO/DynZ0yhQ+Ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na/gPg11/G+xigJt0JLPOG7YYnUsk0Vw8bf+iColsr8=;
 b=E3TEpTje3p9M/pNU1Ljpc++pQnibxSEEVipxPrF69DdQWbSPPoESgRbvT7YWw7CJxjeats3KTqdejxHQlFl8ONsKG96/7eWuwEU1x4jfgV30iUyYqG2qPm7VAKAvx5y0GwqeLgrEGfQvogwVHDec+R1/EeRwqb4FADcW6DufT5WcBuw3GF4dau27U5hgYHL1ZSVIpZDTl5c/6Ta9llCNHzt/n6Focm3m/wAXqTHtFaKA08gNkDsUaZoGRoF7bBwlRQGXf8Ikyt4jIGyPdJWlsXNbcEMiczppne9VPDx+n8MdJ0pQFxAB9AYGonLFY4n1DIld7syRUMFzg2pLgayP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Fri, 10 Nov 2023 09:01:51 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 09:01:50 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Topic: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Index: AQHaEi9PNvCIepF1tEu7KRNf+M25RbBwe78AgAFGpmCAADfgAIAAMUJwgAAe7ICAAFgbsIAAfB6AgAAjAGA=
Date: Fri, 10 Nov 2023 09:01:50 +0000
Message-ID: <DM6PR11MB4657B61E86D5DFFAF83BC1E59BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-3-arkadiusz.kubalewski@intel.com>
 <ZUubagu6B+vbfBqm@nanopsycho>
 <DM6PR11MB465752FE337EB962B147EB579BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZUzcTBmSPxIs5iH3@nanopsycho>
 <DM6PR11MB46571D4C776B0B1888F943569BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fj5y9mAvVzXuf@nanopsycho>
 <DM6PR11MB4657DAC525E05B5DB72145119BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU3RlSmInnoXufxf@nanopsycho>
In-Reply-To: <ZU3RlSmInnoXufxf@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MW5PR11MB5882:EE_
x-ms-office365-filtering-correlation-id: 0d9a896e-cdae-4b19-1dbe-08dbe1cbad81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Z/Y6+rF9uYEOpHqlV3FjeBn1ExCyZUXWhF3VGmPayl77ujbcGsfPGinGnHy1rPArehfwCHLQit6SzbkQzMFiY33eWxwXSpgyoo1tZgqg1A/3aPTs0ikQdSxD13+EYBFIPxI7T1TR5xNefdhkGqwGuG6qZ37yX5Krd2I+EbDuMHJ0MPO7JAhrU/tifI7/DRtaXO+Pl8C5wE2Ctu8a8Ap9pQaVYl4SScg3tlxHJik5nC9Bv98+xfQMPzi1UNB3A1uG0SmBEkMsPBZ3GP0vTXvhjpU0LI8Q93+5O6B4qjAvprRHOqT8OftC+k2IHCHfeZLhXY+jEhkzQZdTxNF7Vy88JcFIJrhXP5DnVqVrrjrgdTmtUHt9W0Ic8LMVRcCj/zVDVQvj2DzD7T11UVhbC/BLzWQ/bXR0zRnu0y6h5EaBhZyROHp4udJYn9PGsHahj+haRtGlOWU10zEH+5ZrHkeVn4CnIlzMfHN/6pugdLNO9mgOy9adSNBen62IjXkxBRGBJHHvBwMRTUSvugLUt9qoQelCb+7BZkRk/qjDAofo1CeUtDskAuaPblbzJFbAycVxc7RIcdyAVqcs6U18UGoqJesXSbBDQ6+RLF1XknQt0040HFj8eZBvRc3hsIOB/0f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82960400001)(316002)(38070700009)(76116006)(66946007)(83380400001)(26005)(122000001)(478600001)(7696005)(6506007)(71200400001)(66556008)(9686003)(8936002)(2906002)(41300700001)(8676002)(6916009)(4326008)(55016003)(5660300002)(38100700002)(66899024)(52536014)(33656002)(64756008)(54906003)(66446008)(30864003)(86362001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yiA62pAPZLaYBL1ns1MhyZ6fkrr1lf60FW6WuIKhDsB2c9GRQJ8+Twhir1+T?=
 =?us-ascii?Q?QwFHDPp++1/lOhqc3ZnEzu6CuZ2LeXdi8Xs248wPkFCnaXe/altOKDCtqsYH?=
 =?us-ascii?Q?gdlhFZ9L3E23htxtXdvh2QnobO499tokbnn7oILitlDjzTdo4d3rScTdPp0p?=
 =?us-ascii?Q?MZIKbhkoKlR4jrxBlFOXwdm7Q36UNSrAtJBOaerzyWMvRTRQk+y5IqGD/Xvc?=
 =?us-ascii?Q?z5/hKI2UZzq66ZT8eSyKK2tnQ6UE2KeJBtD4yjaAeKmRhzpX20IQRdmm7UlU?=
 =?us-ascii?Q?r04KTBvs226UTaAyhiNGi4UuaARwB0wWQQS1MMeA9wqowfC2duXJ//znePaW?=
 =?us-ascii?Q?T2X2MLegPh+dA3KLejTHlrK40z3DcbI7ptWQtDblRw8TtpoQELWyh6JgSnQ7?=
 =?us-ascii?Q?D3zGj7M4lQ8UhoiznUHHmH37wEFBg5nrH8DJTQ72hifO+fZYJtuYrmk/U+Rs?=
 =?us-ascii?Q?8Lyd2hv/kuOgJsqjkTcBKG3uBkkXq9W8a8+iX2C9zUPuvWxemUO/IBPVp5+8?=
 =?us-ascii?Q?nJNteVwiTjIz2UPWb9TbJvwABhy3VT7WcK5NMhVdr/A1AZZfvW7aAe94bEy4?=
 =?us-ascii?Q?bRmmPVsNDOvdCP7um7pQb38u7GllemLLD1QBQzbJyWqZGjKrutmtvXCij2o5?=
 =?us-ascii?Q?2ZEjLD07BPLj9eueFTa9eyA3LWg3Nx2i3LGtk9QlvUoUpE0Sz59wioZvG7YM?=
 =?us-ascii?Q?FeXApVTAPtFIX7ucpmpS8i+CyaymvAkibvojPGS4U5IwTkrz4yQtl90O4BMu?=
 =?us-ascii?Q?OhLFMKuqjbxNlj0caLJHS91z/vqq1BORZ5k6SXMi44FjH6RrR7Q+CUk5fh7Y?=
 =?us-ascii?Q?Pzx6Y89NLwtxinbBBJPmFYgm8tVm3sRT/8PtTP//jS0Ay7+LKC/otbvXFx0o?=
 =?us-ascii?Q?rraB/g0a2wZAF25FerwuqFjbqVmcYaMVrdbyV9E5/d2FLegmEnNvWt/gL40v?=
 =?us-ascii?Q?CrHsMI2YHKwivjkmcUwXszu5z8172HFF3zVKAlz6O4/R3hjNlYLWFE7ip/8F?=
 =?us-ascii?Q?OMlWPvZF0DDHQpg26iD7oVoXc4Xh67WlVa0TkAt+8p9QwsjUrBQVgLG73J4w?=
 =?us-ascii?Q?wBat1mGWNBffu+Ay2aG5yL47GbwqfK5nPDHPvtWQUqglaLO/I6dU78AJLmwN?=
 =?us-ascii?Q?IqamhtRRO/AEkV8aFt5v8ql+GhbCT1ZXkab4B7f0tBegb0icaGHHXAVeTE1+?=
 =?us-ascii?Q?eXDrJ3bZaboCxrZnTblegCj6uqUudGfNoKzgZzcnJ8izGlpKGzP0oOC+4z0K?=
 =?us-ascii?Q?kPtl71f8MKXXN3GyQ/1JhAZrNgWUYoT77xXC9Ux7WMbPpp6DDZiBvH4UHV5g?=
 =?us-ascii?Q?hUrLi0uMyj9mJJY35Sn0wDzYGNQG9p7bYOf3jR3k0ZYIgezpWwZoNzCe8Bwk?=
 =?us-ascii?Q?BOvucE1A2LM02tLUlVdUBy4HyYRuoGKiuMfrShf2ao5EV+oNP2RYTfY+XkJy?=
 =?us-ascii?Q?07uRWHUVik1c8MaeRWEkgYGDim71P2r1+noi3s1Me/wRRqld+MfVhdpqIld3?=
 =?us-ascii?Q?YO6P8ZCx/04fILIjTmmTBNicsxkJnTxRBzWtwv5VxSqky2ZT0YVpgosQ82lg?=
 =?us-ascii?Q?R/+nRfl9g1V5R2vOL/weSAE0YjzRz1O3QcydQHp5xe7ETJXQnb4mfN/sN39k?=
 =?us-ascii?Q?zw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9a896e-cdae-4b19-1dbe-08dbe1cbad81
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 09:01:50.8419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvPbTbz8b0N32MXKx1kd7efjRZnx4u3l53LWqAn3x9HBX3Yh+4VoNtzus7ujIxM8eTItLVqoGdRJJKSaJsY4Hl0im7PTJ+GRk/M1cLYSxDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, November 10, 2023 7:46 AM
>
>Fri, Nov 10, 2023 at 12:32:21AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Thursday, November 9, 2023 7:06 PM
>>>
>>>Thu, Nov 09, 2023 at 05:30:20PM CET, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Thursday, November 9, 2023 2:19 PM
>>>>>
>>>>>Thu, Nov 09, 2023 at 01:20:48PM CET, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>Sent: Wednesday, November 8, 2023 3:30 PM
>>>>>>>
>>>>>>>Wed, Nov 08, 2023 at 11:32:25AM CET, arkadiusz.kubalewski@intel.com
>>>>>>>wrote:
>>>>>>>>When a kernel module is unbound but the pin resources were not
>>>>>>>>entirely
>>>>>>>>freed (other kernel module instance have had kept the reference to
>>>>>>>>that
>>>>>>>>pin), and kernel module is again bound, the pin properties would no=
t
>>>>>>>>be
>>>>>>>>updated (the properties are only assigned when memory for the pin i=
s
>>>>>>>>allocated), prop pointer still points to the kernel module memory o=
f
>>>>>>>>the kernel module which was deallocated on the unbind.
>>>>>>>>
>>>>>>>>If the pin dump is invoked in this state, the result is a kernel
>>>>>>>>crash.
>>>>>>>>Prevent the crash by storing persistent pin properties in dpll
>>>>>>>>subsystem,
>>>>>>>>copy the content from the kernel module when pin is allocated,
>>>>>>>>instead
>>>>>>>>of
>>>>>>>>using memory of the kernel module.
>>>>>>>>
>>>>>>>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base
>>>>>>>>functions")
>>>>>>>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>>>>>>functions")
>>>>>>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com=
>
>>>>>>>>---
>>>>>>>> drivers/dpll/dpll_core.c    |  4 ++--
>>>>>>>> drivers/dpll/dpll_core.h    |  4 ++--
>>>>>>>> drivers/dpll/dpll_netlink.c | 28 ++++++++++++++--------------
>>>>>>>> 3 files changed, 18 insertions(+), 18 deletions(-)
>>>>>>>>
>>>>>>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>>>>>index 3568149b9562..4077b562ba3b 100644
>>>>>>>>--- a/drivers/dpll/dpll_core.c
>>>>>>>>+++ b/drivers/dpll/dpll_core.c
>>>>>>>>@@ -442,7 +442,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struc=
t
>>>>>>>>module *module,
>>>>>>>> 		ret =3D -EINVAL;
>>>>>>>> 		goto err;
>>>>>>>> 	}
>>>>>>>>-	pin->prop =3D prop;
>>>>>>>>+	memcpy(&pin->prop, prop, sizeof(pin->prop));
>>>>>>>
>>>>>>>Odd, you don't care about the pointer within this structure?
>>>>>>>
>>>>>>
>>>>>>Well, true. Need a fix.
>>>>>>Wondering if copying idea is better than just assigning prop pointer
>>>>>>on
>>>>>>each call to dpll_pin_get(..) function (when pin already exists)?
>>>>>
>>>>>Not sure what do you mean. Examples please.
>>>>>
>>>>
>>>>Sure,
>>>>
>>>>Basically this change:
>>>>
>>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>index ae884b92d68c..06b72d5877c3 100644
>>>>--- a/drivers/dpll/dpll_core.c
>>>>+++ b/drivers/dpll/dpll_core.c
>>>>@@ -483,6 +483,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct
>>>>module
>>>>*module,
>>>>                    pos->pin_idx =3D=3D pin_idx &&
>>>>                    pos->module =3D=3D module) {
>>>>                        ret =3D pos;
>>>>+                       pos->prop =3D prop;
>>>>                        refcount_inc(&ret->refcount);
>>>>                        break;
>>>>                }
>>>>
>>>>would replace whole of this patch changes, although seems a bit hacky.
>>>
>>>Or event better, as I suggested in the other patch reply, resolve this
>>>internally in the driver registering things only when they are valid.
>>>Much better then to hack anything in dpll core.
>>>
>>
>>This approach seemed to me hacky, that is why started with coping the
>>data.
>>It is not about registering, rather about unregistering on driver
>>unbind, which brakes things, and currently cannot be recovered in
>>described case.
>
>Sure it can. PF0 unbind-> internal notification-> PF1 unregisters all
>related object. Very clean and simple.
>

What you are suggesting is:
- special purpose bus in the driver,
- dpll-related,
- not needed,
- prone for errors.

The dpll subsystem is here to make driver life easier.

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
>>>>>>
>>>>>>Thank you!
>>>>>>Arkadiusz
>>>>>>
>>>>>>>
>>>>>>>> 	refcount_set(&pin->refcount, 1);
>>>>>>>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>>>>>>>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>>>>>>>>@@ -634,7 +634,7 @@ int dpll_pin_on_pin_register(struct dpll_pin
>>>>>>>>*parent,
>>>>>>>>struct dpll_pin *pin,
>>>>>>>> 	unsigned long i, stop;
>>>>>>>> 	int ret;
>>>>>>>>
>>>>>>>>-	if (WARN_ON(parent->prop->type !=3D DPLL_PIN_TYPE_MUX))
>>>>>>>>+	if (WARN_ON(parent->prop.type !=3D DPLL_PIN_TYPE_MUX))
>>>>>>>> 		return -EINVAL;
>>>>>>>>
>>>>>>>> 	if (WARN_ON(!ops) ||
>>>>>>>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>>>>>>>index 5585873c5c1b..717f715015c7 100644
>>>>>>>>--- a/drivers/dpll/dpll_core.h
>>>>>>>>+++ b/drivers/dpll/dpll_core.h
>>>>>>>>@@ -44,7 +44,7 @@ struct dpll_device {
>>>>>>>>  * @module:		module of creator
>>>>>>>>  * @dpll_refs:		hold referencees to dplls pin was registered
>>>>>>>>with
>>>>>>>>  * @parent_refs:	hold references to parent pins pin was
>registered
>>>>>>>>with
>>>>>>>>- * @prop:		pointer to pin properties given by registerer
>>>>>>>>+ * @prop:		pin properties copied from the registerer
>>>>>>>>  * @rclk_dev_name:	holds name of device when pin can recover
>>>>>>>>clock
>>>>>>>>from it
>>>>>>>>  * @refcount:		refcount
>>>>>>>>  **/
>>>>>>>>@@ -55,7 +55,7 @@ struct dpll_pin {
>>>>>>>> 	struct module *module;
>>>>>>>> 	struct xarray dpll_refs;
>>>>>>>> 	struct xarray parent_refs;
>>>>>>>>-	const struct dpll_pin_properties *prop;
>>>>>>>>+	struct dpll_pin_properties prop;
>>>>>>>> 	refcount_t refcount;
>>>>>>>> };
>>>>>>>>
>>>>>>>>diff --git a/drivers/dpll/dpll_netlink.c
>b/drivers/dpll/dpll_netlink.c
>>>>>>>>index 93fc6c4b8a78..963bbbbe6660 100644
>>>>>>>>--- a/drivers/dpll/dpll_netlink.c
>>>>>>>>+++ b/drivers/dpll/dpll_netlink.c
>>>>>>>>@@ -278,17 +278,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg,
>>>>>>>>struct
>>>>>>>>dpll_pin *pin,
>>>>>>>> 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq),
>>>>>>>>&freq,
>>>>>>>> 			  DPLL_A_PIN_PAD))
>>>>>>>> 		return -EMSGSIZE;
>>>>>>>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++) {
>>>>>>>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++) {
>>>>>>>> 		nest =3D nla_nest_start(msg,
>>>>>>>>DPLL_A_PIN_FREQUENCY_SUPPORTED);
>>>>>>>> 		if (!nest)
>>>>>>>> 			return -EMSGSIZE;
>>>>>>>>-		freq =3D pin->prop->freq_supported[fs].min;
>>>>>>>>+		freq =3D pin->prop.freq_supported[fs].min;
>>>>>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN,
>>>>>>>>sizeof(freq),
>>>>>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>>>>>> 			nla_nest_cancel(msg, nest);
>>>>>>>> 			return -EMSGSIZE;
>>>>>>>> 		}
>>>>>>>>-		freq =3D pin->prop->freq_supported[fs].max;
>>>>>>>>+		freq =3D pin->prop.freq_supported[fs].max;
>>>>>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX,
>>>>>>>>sizeof(freq),
>>>>>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>>>>>> 			nla_nest_cancel(msg, nest);
>>>>>>>>@@ -304,9 +304,9 @@ static bool dpll_pin_is_freq_supported(struct
>>>>>>>>dpll_pin
>>>>>>>>*pin, u32 freq)
>>>>>>>> {
>>>>>>>> 	int fs;
>>>>>>>>
>>>>>>>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++)
>>>>>>>>-		if (freq >=3D pin->prop->freq_supported[fs].min &&
>>>>>>>>-		    freq <=3D pin->prop->freq_supported[fs].max)
>>>>>>>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++)
>>>>>>>>+		if (freq >=3D pin->prop.freq_supported[fs].min &&
>>>>>>>>+		    freq <=3D pin->prop.freq_supported[fs].max)
>>>>>>>> 			return true;
>>>>>>>> 	return false;
>>>>>>>> }
>>>>>>>>@@ -403,7 +403,7 @@ static int
>>>>>>>> dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
>>>>>>>> 		     struct netlink_ext_ack *extack)
>>>>>>>> {
>>>>>>>>-	const struct dpll_pin_properties *prop =3D pin->prop;
>>>>>>>>+	const struct dpll_pin_properties *prop =3D &pin->prop;
>>>>>>>> 	struct dpll_pin_ref *ref;
>>>>>>>> 	int ret;
>>>>>>>>
>>>>>>>>@@ -696,7 +696,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin,
>>>>>>>>u32
>>>>>>>>parent_idx,
>>>>>>>> 	int ret;
>>>>>>>>
>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>> 	}
>>>>>>>>@@ -732,7 +732,7 @@ dpll_pin_state_set(struct dpll_device *dpll,
>>>>>>>>struct
>>>>>>>>dpll_pin *pin,
>>>>>>>> 	int ret;
>>>>>>>>
>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>> 	}
>>>>>>>>@@ -759,7 +759,7 @@ dpll_pin_prio_set(struct dpll_device *dpll,
>struct
>>>>>>>>dpll_pin *pin,
>>>>>>>> 	int ret;
>>>>>>>>
>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>> 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>> 	}
>>>>>>>>@@ -787,7 +787,7 @@ dpll_pin_direction_set(struct dpll_pin *pin,
>>>>>>>>struct
>>>>>>>>dpll_device *dpll,
>>>>>>>> 	int ret;
>>>>>>>>
>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>> 		NL_SET_ERR_MSG(extack, "direction changing is not
>>>>>>>>allowed");
>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>> 	}
>>>>>>>>@@ -817,8 +817,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin,
>>>>>>>>struct
>>>>>>>>nlattr *phase_adj_attr,
>>>>>>>> 	int ret;
>>>>>>>>
>>>>>>>> 	phase_adj =3D nla_get_s32(phase_adj_attr);
>>>>>>>>-	if (phase_adj > pin->prop->phase_range.max ||
>>>>>>>>-	    phase_adj < pin->prop->phase_range.min) {
>>>>>>>>+	if (phase_adj > pin->prop.phase_range.max ||
>>>>>>>>+	    phase_adj < pin->prop.phase_range.min) {
>>>>>>>> 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
>>>>>>>> 				    "phase adjust value not supported");
>>>>>>>> 		return -EINVAL;
>>>>>>>>@@ -999,7 +999,7 @@ dpll_pin_find(u64 clock_id, struct nlattr
>>>>>>>>*mod_name_attr,
>>>>>>>> 	unsigned long i;
>>>>>>>>
>>>>>>>> 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
>>>>>>>>-		prop =3D pin->prop;
>>>>>>>>+		prop =3D &pin->prop;
>>>>>>>> 		cid_match =3D clock_id ? pin->clock_id =3D=3D clock_id : true;
>>>>>>>> 		mod_match =3D mod_name_attr && module_name(pin->module) ?
>>>>>>>> 			!nla_strcmp(mod_name_attr,
>>>>>>>>--
>>>>>>>>2.38.1
>>>>>>>>
>>>>>>
>>

