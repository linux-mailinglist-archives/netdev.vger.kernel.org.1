Return-Path: <netdev+bounces-46950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C910D7E752A
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 00:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03951C20B6E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 23:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9B338DCA;
	Thu,  9 Nov 2023 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmE9TqHl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312838FA2
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 23:32:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774164482
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 15:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699572747; x=1731108747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XSvgok3LVVLk++phOLVEwH0yTYVp2lJ7YBcPcFFU0OU=;
  b=QmE9TqHl+3gN1XYnMm7RjPvla40Ph8+SMEF5hTw3tV1wGmaaNWLuy/Mf
   H9KtUE6b5DKJhdDvZSxGiQtMSZDFWZHLGKlW61bYwPo5C/1B9dQ7EMdOL
   YET2oApUeHtZis0RjSd1WdJXJCmu9ybKHOsiqEglT6kbvhdf2kZ1ZmIIi
   gfDp12fuaCix8ujnklRZKnYecV+dqRu1lmYYVMpXMgQqrJzZI9x/3SAbD
   g+WgtjKOL4JNabR2LvQn9XIcv4AJinpY5JSQCigYa2ciRhuNbiT1mIX/y
   sSP1lx8xI+o+OJ2PlISSMrJevcGDwH5lxxvKS2KrSZJ4Lymlj0+bw+B10
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="456589251"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="456589251"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 15:32:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="4870773"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 15:32:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 15:32:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 15:32:24 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 15:32:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVeKr979OgfeNY2CTAcTfllmjojsfO/elKDsFJ6B2n0ThMit58WVCR29LfsjSWPl/E0w36Wr/DsWjZixhc9JX8UsnFRB3EoUo43dqlNUg36obUdD2Hxb6xxRdJIjB6kKzsJLO9Y3OgWqnaO/pcbs7ReDQqajJycd+2RIp6syGmZrUuqZQvhEMWS4ARZ528tH+EVedygumfJQUzKC9eZ3q/3C6I8qrQvB8lB5/I/0dgoehlboRoHJ2dT3chlwe5H/9BWGYGt/5VLbzjz7E8idvsARJLC//jzjFsNRFSD8OFrUxk7yGMvKLwYk5dkS5gGR47IcyPsSAwMmxEFxUdKA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+ppfb2sG82fdXmgLACGjeRL6Vq204pE8aWepScrD9M=;
 b=jxAo8cfunv1mgnTcwsFUY+Tgnx86ceVP3sgM5OILEXOdJcFg7ZBGQYT2dM1CH8XzdIbZu25R+lxG2oo2HKcaK9oQDjhCM/QDCceDHiMSnp335olUK6AhGpP1/1vQ5R0ub83YnLYr5TL1Ln8It8Jjc9HM1opNVDi05tggwqQyNjz7u8V9NrmEg+Tv/6HHySUvJQeQJREu6mXAi5jEv3mNUD6tPgXrQkv3s/RRHTWOx4VQs6vH039ar85TSt5qUDXCnvgL2Bn9uCzKGAD94HJB0Q7TpLoAFZcXzXR+DC0SnATiIOlQHAof7hvdmlHid3hklSQ6BycUBc/t9VKYLBDf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH8PR11MB7045.namprd11.prod.outlook.com (2603:10b6:510:217::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Thu, 9 Nov 2023 23:32:21 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 23:32:21 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Topic: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Index: AQHaEi9PNvCIepF1tEu7KRNf+M25RbBwe78AgAFGpmCAADfgAIAAMUJwgAAe7ICAAFgbsA==
Date: Thu, 9 Nov 2023 23:32:21 +0000
Message-ID: <DM6PR11MB4657DAC525E05B5DB72145119BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-3-arkadiusz.kubalewski@intel.com>
 <ZUubagu6B+vbfBqm@nanopsycho>
 <DM6PR11MB465752FE337EB962B147EB579BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZUzcTBmSPxIs5iH3@nanopsycho>
 <DM6PR11MB46571D4C776B0B1888F943569BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fj5y9mAvVzXuf@nanopsycho>
In-Reply-To: <ZU0fj5y9mAvVzXuf@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH8PR11MB7045:EE_
x-ms-office365-filtering-correlation-id: 57fd83ee-f5af-49de-92c7-08dbe17c1f09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GFkxXaRyp8lfPZIB5vZcSkRRQyAZrIFFKDjWkM2T3BJjNgzHki6TlQcVxsq7v/E9IJHKCobwc/PDRj/Sq9JtsnRUUmnQnCsVKuFPI0FU2notJUH340+NVDoFtxsdyYKzIyxhFoOI8avhjkQtI8HQ31bFHSVfl1VoqcRErQjT1zlXDJ8vKbS27Sn0oculJA7huSgp5WP17BI5yXDA/6OtB0T7MtfNdnvXwIWbOe9+y9Q+of/jQ0mb8x2H5pOfbP0ovvptkm0L15a+n+U4Bsu2s8gPCTtEvu5wyCNCcr9j6EB9HSbjHLtmPwW/mPKKob+Ty1Ff2UvZ7WFSZrIfvEa41vw9e1XHoOhlM2bU4W02yMHRFZ7pJXg0oH+myjVR+QUdH14Swi2mkfqT+qmHpgFIvCBI6hKzrmpm93nwHnN+g649YdezBmnKbUcL9+T/IhjB2bAt8GKm1UyOnCiz6ygEExUIDezmJZG/HJBoNVZjOFiQM9U4R+WHFE6h8dNoQ2nUoGSk23HESjuXSrdEzyillv0Rqn7AGxbIwPokUimwpnwSMV/dWgGo/dHDWmp1Mj8nrvD9w8H5JHc9VXLyX33z0zMcLTLTvdy51dtPDXRnFPDdIsQy56KfjnZYNnErfq6Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(71200400001)(41300700001)(52536014)(33656002)(6916009)(55016003)(4326008)(66446008)(38100700002)(64756008)(54906003)(8936002)(316002)(8676002)(5660300002)(2906002)(86362001)(83380400001)(66476007)(76116006)(66556008)(26005)(82960400001)(66946007)(122000001)(38070700009)(66899024)(9686003)(7696005)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QrKOCrVhIIf365M/Xo8p5+tWXp8ZlXcXWet4ndO6dnUwZheTAV2gy1phE861?=
 =?us-ascii?Q?zWJ+Z32iOjngBdVg7L0RYiDuWnMybKY8EvTBb+SWwhOzIhL+KxPH9ufI7OZ+?=
 =?us-ascii?Q?Z5lAMT4JHYdggeGmKGIiGNBdpZQy+pe21b3FWSeOQhCQHqZuS68CLg3IbvHn?=
 =?us-ascii?Q?W3+p9b3As1H4/tvL1wT0OAbkKoJ8mvv+e3oKqqSY5XQLkMG3STHdjZrfhyZ4?=
 =?us-ascii?Q?6tyJCc9PGFPybTerdEfd7CMM1nTLbFPdMC8Sd30aJ5a8gTYTgwBmjLRq9xn9?=
 =?us-ascii?Q?maO35GG0BQyOx4fZ0wtIMeEj03Ln71Zj0QZxkh0IDObJxwtnemPnD/BRQuHs?=
 =?us-ascii?Q?gRnzbTD9Jiz3yms0ihnkaiUU2K0PZNSCEtIwQ8jqELqMyplBiyV5OC9Xg9nm?=
 =?us-ascii?Q?9GKR93ZvHGkaj2PQT8UIXX2qS7BMrIofc4HxIe+b6dhJ6fC1TLF3iVoqAmhG?=
 =?us-ascii?Q?SJ9vGndwHs9lK/HiIsKCNBsSXnWETvEgPwLxqaz+I0ZPdqgonEtYu7LefZ5z?=
 =?us-ascii?Q?YW+Zcy5ygTGAs1YXyP1qX7aVI6e6dVK6PzSaNn9kAIxge9mhKzJXfCyMv+jV?=
 =?us-ascii?Q?eskBhNPm6OIB3S0Cz0oN15G7dezruGPWASAoACcCqMXhnrCQatEopIF1uxiw?=
 =?us-ascii?Q?jRZSKwS+ivE8xDEzV9V5B+e2CZiuc6wBAPDAGH09r0WQovMjYmVM0aIbJfxr?=
 =?us-ascii?Q?LiZPiF72RS9D8NDxRYPnZq8Swce4YWXnme2MwJrBP4160NmK6Cn9HDnrKtNM?=
 =?us-ascii?Q?F0XFZZPoamx+h87GHc4obuF1Ip760mFHKUQUfVQS6hQZ2DjnmUJ4ZOTj4k4v?=
 =?us-ascii?Q?6K9TOzi4VuRWDeYRY5df4N+62DA/VRVQAwTPhuorxj5BBer2gX9HWyHx+9xl?=
 =?us-ascii?Q?O9pSghOfqmnL++/w0/BwgwFxdrgtjSwmB3ouMtG1neS9F32EHbxZ98+dxH0J?=
 =?us-ascii?Q?4TS0DTrVXHX7BK6YDFJR/u09nQZgdl2sGSVqGaSH7/r6jPsqR+QphNlmjJE8?=
 =?us-ascii?Q?pAxbI/NgqwIlHOTM8vsv4SpeMq56fc0fEQaNKVEJxiiSuZ/D2DeDHg5Dk93I?=
 =?us-ascii?Q?GC4sNy+VAMJIIrh+Pt1fpTOomiUNYW3tnzPjWiO/gSIiMnV46FwnHpJkzxNf?=
 =?us-ascii?Q?T/f8I0dTFbiqzuJ7tl5Ae7Vb9OZyaXRJQp0isojiMuaXDCiXBDM114HhpeI6?=
 =?us-ascii?Q?maMBylSZLqEQWXBBtGMgX+5LX+OsKjpx4Hlth+rio98IzXQaTF/lGsuUJ6G+?=
 =?us-ascii?Q?5f7+oKd3eEt2SRJ9MyCj2HB/sTJTEt5zMmhK4MO84+SAdG3Cpzepd/bMicLT?=
 =?us-ascii?Q?wu+rmpSubKNz1ANowPMach7+qDLgQCGZEPQer/pt1pKDHmxPosIJ7NiU5dq2?=
 =?us-ascii?Q?sIll7hrkyL2+DtmcaizSVTuOiGr8TUKHyu+N5SmJENIHfjIw6Zwm9iEmUOzc?=
 =?us-ascii?Q?0XMgW1CEKeqC6DBMEZf3voCOIyquNdK0JG86XHPmMdcLfwAQCJSmIPyLjzDH?=
 =?us-ascii?Q?VREtnayVetIj1lfl4RIKfXI/lQt5lB8+iI2n3YCiBB+B+OfBKC1kNZKIKTsL?=
 =?us-ascii?Q?xveL66bDD52/fwT9sbZSVy86ELwarWPS64lOothF7gjpqHwUohSkPvQY781O?=
 =?us-ascii?Q?Zg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fd83ee-f5af-49de-92c7-08dbe17c1f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 23:32:21.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzc3TNasn/7pBVHfrbG9Vxzv+BsIgedmiANZsgoUx5CIMryDZXtewWk2wqzhSGnVYun6k2a8FcTf1tFhXqi0N1DcThxPLLB+sVI2evsdMyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7045
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, November 9, 2023 7:06 PM
>
>Thu, Nov 09, 2023 at 05:30:20PM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Thursday, November 9, 2023 2:19 PM
>>>
>>>Thu, Nov 09, 2023 at 01:20:48PM CET, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Wednesday, November 8, 2023 3:30 PM
>>>>>
>>>>>Wed, Nov 08, 2023 at 11:32:25AM CET, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>When a kernel module is unbound but the pin resources were not
>>>>>>entirely
>>>>>>freed (other kernel module instance have had kept the reference to
>>>>>>that
>>>>>>pin), and kernel module is again bound, the pin properties would not
>>>>>>be
>>>>>>updated (the properties are only assigned when memory for the pin is
>>>>>>allocated), prop pointer still points to the kernel module memory of
>>>>>>the kernel module which was deallocated on the unbind.
>>>>>>
>>>>>>If the pin dump is invoked in this state, the result is a kernel
>>>>>>crash.
>>>>>>Prevent the crash by storing persistent pin properties in dpll
>>>>>>subsystem,
>>>>>>copy the content from the kernel module when pin is allocated, instea=
d
>>>>>>of
>>>>>>using memory of the kernel module.
>>>>>>
>>>>>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>>>>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>>>>functions")
>>>>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>>---
>>>>>> drivers/dpll/dpll_core.c    |  4 ++--
>>>>>> drivers/dpll/dpll_core.h    |  4 ++--
>>>>>> drivers/dpll/dpll_netlink.c | 28 ++++++++++++++--------------
>>>>>> 3 files changed, 18 insertions(+), 18 deletions(-)
>>>>>>
>>>>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>>>index 3568149b9562..4077b562ba3b 100644
>>>>>>--- a/drivers/dpll/dpll_core.c
>>>>>>+++ b/drivers/dpll/dpll_core.c
>>>>>>@@ -442,7 +442,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>>>>>module *module,
>>>>>> 		ret =3D -EINVAL;
>>>>>> 		goto err;
>>>>>> 	}
>>>>>>-	pin->prop =3D prop;
>>>>>>+	memcpy(&pin->prop, prop, sizeof(pin->prop));
>>>>>
>>>>>Odd, you don't care about the pointer within this structure?
>>>>>
>>>>
>>>>Well, true. Need a fix.
>>>>Wondering if copying idea is better than just assigning prop pointer on
>>>>each call to dpll_pin_get(..) function (when pin already exists)?
>>>
>>>Not sure what do you mean. Examples please.
>>>
>>
>>Sure,
>>
>>Basically this change:
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>index ae884b92d68c..06b72d5877c3 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -483,6 +483,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module
>>*module,
>>                    pos->pin_idx =3D=3D pin_idx &&
>>                    pos->module =3D=3D module) {
>>                        ret =3D pos;
>>+                       pos->prop =3D prop;
>>                        refcount_inc(&ret->refcount);
>>                        break;
>>                }
>>
>>would replace whole of this patch changes, although seems a bit hacky.
>
>Or event better, as I suggested in the other patch reply, resolve this
>internally in the driver registering things only when they are valid.
>Much better then to hack anything in dpll core.
>

This approach seemed to me hacky, that is why started with coping the
data.
It is not about registering, rather about unregistering on driver
unbind, which brakes things, and currently cannot be recovered in
described case.

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
>>>>>> 	refcount_set(&pin->refcount, 1);
>>>>>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>>>>>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>>>>>>@@ -634,7 +634,7 @@ int dpll_pin_on_pin_register(struct dpll_pin
>>>>>>*parent,
>>>>>>struct dpll_pin *pin,
>>>>>> 	unsigned long i, stop;
>>>>>> 	int ret;
>>>>>>
>>>>>>-	if (WARN_ON(parent->prop->type !=3D DPLL_PIN_TYPE_MUX))
>>>>>>+	if (WARN_ON(parent->prop.type !=3D DPLL_PIN_TYPE_MUX))
>>>>>> 		return -EINVAL;
>>>>>>
>>>>>> 	if (WARN_ON(!ops) ||
>>>>>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>>>>>index 5585873c5c1b..717f715015c7 100644
>>>>>>--- a/drivers/dpll/dpll_core.h
>>>>>>+++ b/drivers/dpll/dpll_core.h
>>>>>>@@ -44,7 +44,7 @@ struct dpll_device {
>>>>>>  * @module:		module of creator
>>>>>>  * @dpll_refs:		hold referencees to dplls pin was registered
>>>>>>with
>>>>>>  * @parent_refs:	hold references to parent pins pin was registered
>>>>>>with
>>>>>>- * @prop:		pointer to pin properties given by registerer
>>>>>>+ * @prop:		pin properties copied from the registerer
>>>>>>  * @rclk_dev_name:	holds name of device when pin can recover
>>>>>>clock
>>>>>>from it
>>>>>>  * @refcount:		refcount
>>>>>>  **/
>>>>>>@@ -55,7 +55,7 @@ struct dpll_pin {
>>>>>> 	struct module *module;
>>>>>> 	struct xarray dpll_refs;
>>>>>> 	struct xarray parent_refs;
>>>>>>-	const struct dpll_pin_properties *prop;
>>>>>>+	struct dpll_pin_properties prop;
>>>>>> 	refcount_t refcount;
>>>>>> };
>>>>>>
>>>>>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.=
c
>>>>>>index 93fc6c4b8a78..963bbbbe6660 100644
>>>>>>--- a/drivers/dpll/dpll_netlink.c
>>>>>>+++ b/drivers/dpll/dpll_netlink.c
>>>>>>@@ -278,17 +278,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg,
>>>>>>struct
>>>>>>dpll_pin *pin,
>>>>>> 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq),
>>>>>>&freq,
>>>>>> 			  DPLL_A_PIN_PAD))
>>>>>> 		return -EMSGSIZE;
>>>>>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++) {
>>>>>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++) {
>>>>>> 		nest =3D nla_nest_start(msg,
>>>>>>DPLL_A_PIN_FREQUENCY_SUPPORTED);
>>>>>> 		if (!nest)
>>>>>> 			return -EMSGSIZE;
>>>>>>-		freq =3D pin->prop->freq_supported[fs].min;
>>>>>>+		freq =3D pin->prop.freq_supported[fs].min;
>>>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN,
>>>>>>sizeof(freq),
>>>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>>>> 			nla_nest_cancel(msg, nest);
>>>>>> 			return -EMSGSIZE;
>>>>>> 		}
>>>>>>-		freq =3D pin->prop->freq_supported[fs].max;
>>>>>>+		freq =3D pin->prop.freq_supported[fs].max;
>>>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX,
>>>>>>sizeof(freq),
>>>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>>>> 			nla_nest_cancel(msg, nest);
>>>>>>@@ -304,9 +304,9 @@ static bool dpll_pin_is_freq_supported(struct
>>>>>>dpll_pin
>>>>>>*pin, u32 freq)
>>>>>> {
>>>>>> 	int fs;
>>>>>>
>>>>>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++)
>>>>>>-		if (freq >=3D pin->prop->freq_supported[fs].min &&
>>>>>>-		    freq <=3D pin->prop->freq_supported[fs].max)
>>>>>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++)
>>>>>>+		if (freq >=3D pin->prop.freq_supported[fs].min &&
>>>>>>+		    freq <=3D pin->prop.freq_supported[fs].max)
>>>>>> 			return true;
>>>>>> 	return false;
>>>>>> }
>>>>>>@@ -403,7 +403,7 @@ static int
>>>>>> dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
>>>>>> 		     struct netlink_ext_ack *extack)
>>>>>> {
>>>>>>-	const struct dpll_pin_properties *prop =3D pin->prop;
>>>>>>+	const struct dpll_pin_properties *prop =3D &pin->prop;
>>>>>> 	struct dpll_pin_ref *ref;
>>>>>> 	int ret;
>>>>>>
>>>>>>@@ -696,7 +696,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin,
>>>>>>u32
>>>>>>parent_idx,
>>>>>> 	int ret;
>>>>>>
>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>>>-	      pin->prop->capabilities)) {
>>>>>>+	      pin->prop.capabilities)) {
>>>>>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>>>>>> 		return -EOPNOTSUPP;
>>>>>> 	}
>>>>>>@@ -732,7 +732,7 @@ dpll_pin_state_set(struct dpll_device *dpll,
>>>>>>struct
>>>>>>dpll_pin *pin,
>>>>>> 	int ret;
>>>>>>
>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>>>-	      pin->prop->capabilities)) {
>>>>>>+	      pin->prop.capabilities)) {
>>>>>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>>>>>> 		return -EOPNOTSUPP;
>>>>>> 	}
>>>>>>@@ -759,7 +759,7 @@ dpll_pin_prio_set(struct dpll_device *dpll, struc=
t
>>>>>>dpll_pin *pin,
>>>>>> 	int ret;
>>>>>>
>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
>>>>>>-	      pin->prop->capabilities)) {
>>>>>>+	      pin->prop.capabilities)) {
>>>>>> 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
>>>>>> 		return -EOPNOTSUPP;
>>>>>> 	}
>>>>>>@@ -787,7 +787,7 @@ dpll_pin_direction_set(struct dpll_pin *pin,
>>>>>>struct
>>>>>>dpll_device *dpll,
>>>>>> 	int ret;
>>>>>>
>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
>>>>>>-	      pin->prop->capabilities)) {
>>>>>>+	      pin->prop.capabilities)) {
>>>>>> 		NL_SET_ERR_MSG(extack, "direction changing is not
>>>>>>allowed");
>>>>>> 		return -EOPNOTSUPP;
>>>>>> 	}
>>>>>>@@ -817,8 +817,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin,
>>>>>>struct
>>>>>>nlattr *phase_adj_attr,
>>>>>> 	int ret;
>>>>>>
>>>>>> 	phase_adj =3D nla_get_s32(phase_adj_attr);
>>>>>>-	if (phase_adj > pin->prop->phase_range.max ||
>>>>>>-	    phase_adj < pin->prop->phase_range.min) {
>>>>>>+	if (phase_adj > pin->prop.phase_range.max ||
>>>>>>+	    phase_adj < pin->prop.phase_range.min) {
>>>>>> 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
>>>>>> 				    "phase adjust value not supported");
>>>>>> 		return -EINVAL;
>>>>>>@@ -999,7 +999,7 @@ dpll_pin_find(u64 clock_id, struct nlattr
>>>>>>*mod_name_attr,
>>>>>> 	unsigned long i;
>>>>>>
>>>>>> 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
>>>>>>-		prop =3D pin->prop;
>>>>>>+		prop =3D &pin->prop;
>>>>>> 		cid_match =3D clock_id ? pin->clock_id =3D=3D clock_id : true;
>>>>>> 		mod_match =3D mod_name_attr && module_name(pin->module) ?
>>>>>> 			!nla_strcmp(mod_name_attr,
>>>>>>--
>>>>>>2.38.1
>>>>>>
>>>>


