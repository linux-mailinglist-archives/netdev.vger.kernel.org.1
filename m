Return-Path: <netdev+bounces-46887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F9B7E6EB6
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E017B20BCE
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E791111B8;
	Thu,  9 Nov 2023 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hf7qm1HT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA722328
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:30:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE45835AD
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 08:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699547428; x=1731083428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jpf5Su71k0lkIpruYHcGfSN4eRmcbn4G//QYu8OrSfk=;
  b=Hf7qm1HTR6py1kTHhAFUrMRyiHclN8NRL3dVy27gwV2ZmwNZ/uojctxQ
   3p6kNnK9yHs2ZB7UFN+KCJ5SMEi7nhEtGRTmu2kWIhMNjz3a2TxCLxBEz
   7nBu9E4AnClI17eNh4DRI8s/ugHfyQl2IKZHVzTY5NMq9rhssFu0uFWk8
   KMCpKM7CN/SAkVI+R31RoPaBfgG7t5TdZZaR+YbCkSje4Rna2TJ2SDR17
   RHmDxIFS2PXZDOUDOtEm/YR15f9ofWMobCU2GW89LfSrowmfPm46B2AyI
   qHYI6sAjnq7tMiKCunOfieKeS8wxt/fsLqM+87GwxbWknlYFf2eAk9jVs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="2991662"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="2991662"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 08:30:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="11580085"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 08:30:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 08:30:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 08:30:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 08:30:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 08:30:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIiJKdXiEE3ecWpMCsfOTWolORSY5OEcgMswMnZJmGH4+3S5DClb/gL0btJTynBJQqqbF7EJFrIvsEpiJNd0M7czO8XYebffdMtJ5tjOBQ7+b7xk0+NmP7E0Xx+wTsSsc4JPUOfujRfU4kgqvg2pDVjpuRQ1DSKUsgTRm6Q0+V9ADSyXsL6hKJodjuk1m8xZkLxFaJvKywaBdYpoOtajFfrvCpLTG4I+YQLWlflcciWn/u0utQFOKTvElOOuVpnhvoYxwiFkcK/DAUOOmhXDenSr0v5Nkqfm5qjQoRa6Q6JHsdnBAynVkJC/+vZLfTJs95rEufv4AIW72iH+7XB1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZkpHFwuzaY86gaLZQ0TWXaZy8lcJsK0s8GW3OT6nPU=;
 b=G/xWzhwkm+61WFnbhRImUqm8GWANQ4OE4ppk90fUPt9hYXPPmzdMiPz7GrHk1XKa0omsl0Q+O2NQkwBnPGW2ut4BJ9C4xH9M+sTjlK78vEELIMsA8kzomuFFuX9AFQAJILIwv/TksNDR/Qe5Xw5VTKz6tMOJBRSYwFmRjSo2UOpjTheZeijkvlizB5HNCn5bbyDmshzrPZ9/EqcE0/xbWTscLftiK+Xw4LK4NsMTgh9i8d4fSUO3kn7gXUltu8qZ+KRSF3ToGxYO/7zSJYntAqXgpvWEw/dWbwxZl70uZT/hEoUrqXSgp7R/sJUJTc/NoiQ90LuO9uEwQIfQNktpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH0PR11MB5175.namprd11.prod.outlook.com (2603:10b6:510:3d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Thu, 9 Nov 2023 16:30:21 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 16:30:21 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Topic: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Index: AQHaEi9PNvCIepF1tEu7KRNf+M25RbBwe78AgAFGpmCAADfgAIAAMUJw
Date: Thu, 9 Nov 2023 16:30:20 +0000
Message-ID: <DM6PR11MB46571D4C776B0B1888F943569BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-3-arkadiusz.kubalewski@intel.com>
 <ZUubagu6B+vbfBqm@nanopsycho>
 <DM6PR11MB465752FE337EB962B147EB579BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZUzcTBmSPxIs5iH3@nanopsycho>
In-Reply-To: <ZUzcTBmSPxIs5iH3@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH0PR11MB5175:EE_
x-ms-office365-filtering-correlation-id: 3250c25b-8d53-443e-15da-08dbe1412ab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWeIX1qo29cii5GknrW9AfULUM+0Jj7QJltuyz34p9F2ALIPH9GrTGK4+MCxilYIvDVNusqGF1pOsMP7fHmR5DOrCDpkOmF2w6QqaN1vsigt9xSYePbLq81+YlbzviGkGxW0x8kT/FL3sEC9qBfmFce7wxUn6eDThCp/ratphdLbErqMYCXYJAk05UZYuHk/mdK7uLuhppsPoypI9FJrMUavfx96C7ezPbhCm2csBwr6mpvT4bnVi22nahbIvZ53VLyRzKdrhj+Bqd/jYJ9HEgsEBg32whvGw1/DA+1vWFIXVm0kA7a2NEVrowK3wmd3I1/AAXZkfG54uouVFJ2hgN6lUfjCxOwWX9zIGlA/sZ/qQDGx09SlevZmPsI+CiC6NLeUgi4St2UqfCxPP/mRnB6yEROfVlMWTxXoUuzovmS0cCbPbE9+6iBqwo0nsWMeNjQQXGy4/w9gUKfo78jht4/3yjDjI4ltET/kC1+893lZLkxNfKTjfuU42ZSLhnkYG53xa+WeI9YKGDmVDkDZwvIVwu16UthgrIW+6s5OYvqsz9VSxGphiMQLMmHJwBbAwCnA7J/Yn7ujAVHm5Ka607wL3IVJWvrTcUIIwqolqDyzVx3eJsp2RUAdexPUvEpp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66899024)(66446008)(26005)(41300700001)(76116006)(316002)(66556008)(66476007)(33656002)(64756008)(66946007)(71200400001)(54906003)(6916009)(38070700009)(2906002)(478600001)(86362001)(7696005)(6506007)(122000001)(82960400001)(5660300002)(83380400001)(9686003)(8676002)(4326008)(38100700002)(55016003)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5lKqR1rUb9y4/f5rEI8s6Fr77thW6lKZcUecYQFdbKyeqEmyJ2PpctIL6h4b?=
 =?us-ascii?Q?1xZM2xspLlYaIZcq//W70jTeypZVlLny9q5BppB1E7BRyBvbpP45I1p+WDaM?=
 =?us-ascii?Q?FunauNdxsmNqLRK6rUajEHvRcAf1AV+vistzF085MURQtDLX/ur102LxVct4?=
 =?us-ascii?Q?oILgZPF75G/LG21oQSCzRspTgyKbPBHspRfO7Ibvz0xf8wE5nUHTwqh5W4Lg?=
 =?us-ascii?Q?Mq1PGycV7dAZ01Q6SgRazLMcv8XzsSsipO89P2RSzo3m5IHO7tYdprRyQ/0l?=
 =?us-ascii?Q?UuiXBBZUWl9LTrvX69pXw7lP3CGIoXfhsIHm0B5oJvgy8WhRcowgKmzQhVLa?=
 =?us-ascii?Q?r2N+9UthslE+e3PxJrs/448VlsneAowvxzC4K3byQNyoCFGVvWvcN3IcVVkO?=
 =?us-ascii?Q?VJ+Kp2sCDdVjQ+xm0a48Oo8uK1TngDmp6iigVbAMOVHdnUNp+mYXZta9QHJF?=
 =?us-ascii?Q?hof5UqzzXtBNu9SwPnAXbBec8Z9VE1NfuHvgwPadNeJWTe+mZmHJr10q3lMW?=
 =?us-ascii?Q?gNxU3tI4HP7Z0IjBiXcYSnVZvUYhC/9hqRjWB1z1gexWz4QLyL04EA6U0v8q?=
 =?us-ascii?Q?f7q8Ac5mjNIoH7HCjIR7OixB8x6pWhJZyGPA5u5tx8LIt6j73BU+eQaMRnru?=
 =?us-ascii?Q?UVLMFXXeNfruFZFY9FULdy1h+wRgGi7lw9J8yGVppGhY2JpPyfZmuic6vKrF?=
 =?us-ascii?Q?NSdJQ98t4UtT1CsQGtuElq6H7pFY3QpNOVwOl/p6dSN7sp9G6AQBjMrYZaeK?=
 =?us-ascii?Q?owU4BHmmfzwUVDfXhK52nM+i6itbygUcD0DJ9Tqk/wArHUe8YOAyl/qDAB5/?=
 =?us-ascii?Q?iDQsqjzFwC0Q0BDYWElP7lzj3k/2lqMsDGDBVC2LRH9E0wPUPXbINqAu1vbB?=
 =?us-ascii?Q?vhrxxkHtv7d0zpKQE4zeYME0TI9C1Ge6C83RuAn2ru+lrm1EWKf4/84sVzbx?=
 =?us-ascii?Q?ShIKHLB49001he6MY7GHbPrVl/nLr9frBkKXHtTro2eIZJDqT0RWHh0SjIyw?=
 =?us-ascii?Q?Mw2DTKsGo16i6K8YSp8NZY2kdwCCd3Mj1tNgSjyeq3TwKnnQ+6IcJscNghAI?=
 =?us-ascii?Q?zwLGwlt5KT0G/I2ZsbrmxXQJUe01xRvgfn8kUr/RRkT6fR/iHGaKPcOsfXYy?=
 =?us-ascii?Q?h9hW3QN/QNHy24UEZ1BDT6RITp1MsaOt+lcwyUU6bUzsaXD1+5mcIEmi9Cax?=
 =?us-ascii?Q?p8QY3p8IVyOQz4WPAgpUbbOnUor6wCKu67T1G5dAy2rhkvi4Va0MSrIKXLWe?=
 =?us-ascii?Q?xQxqnRAA6Sz/f6VSSA8yqv0sC/Vk/jKXd36nS+UxnrDcJURzmmrGqLPHK8Pd?=
 =?us-ascii?Q?MYoa2q40fMzXv36cPHmWXRy5mmtyPPVsJAtaXa/wa6rlGRyh03k4chfmho6m?=
 =?us-ascii?Q?S1Nr+fS9H6RLVlajSca9DHi7YMfBU18q7h+0CHTD1RLOk8m2GkarQHLjX4yi?=
 =?us-ascii?Q?V2fKgldW9I0a9IcAXx44xAgWTDZQDmBbcFJWm+mOBCOTCtqZRHo52fKfZDyt?=
 =?us-ascii?Q?Y2F+MXf0jV4v0YHMfWvBmdqpSjgfbNwTZ14C0lcEQfEZNM6kuFo2HtYgLUV9?=
 =?us-ascii?Q?F/SsvE02z3QY0y1IqHkyJ3Az+qZUkNPP1zL8eHCwh4oZTqgi3p8Gm3R/63Zi?=
 =?us-ascii?Q?BQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3250c25b-8d53-443e-15da-08dbe1412ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 16:30:20.8476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrzF69YQPWvqtCYj/qg/+r6t+36ImDS1uBazsTAPPLk7uORXWgWaFELYaSBM6cddWCFGhJWLQZRw3Yhv/opgQV+LGcQryZWd8sgyJtmm5QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5175
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, November 9, 2023 2:19 PM
>
>Thu, Nov 09, 2023 at 01:20:48PM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Wednesday, November 8, 2023 3:30 PM
>>>
>>>Wed, Nov 08, 2023 at 11:32:25AM CET, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>When a kernel module is unbound but the pin resources were not entirely
>>>>freed (other kernel module instance have had kept the reference to that
>>>>pin), and kernel module is again bound, the pin properties would not be
>>>>updated (the properties are only assigned when memory for the pin is
>>>>allocated), prop pointer still points to the kernel module memory of
>>>>the kernel module which was deallocated on the unbind.
>>>>
>>>>If the pin dump is invoked in this state, the result is a kernel crash.
>>>>Prevent the crash by storing persistent pin properties in dpll
>>>>subsystem,
>>>>copy the content from the kernel module when pin is allocated, instead
>>>>of
>>>>using memory of the kernel module.
>>>>
>>>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions"=
)
>>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>---
>>>> drivers/dpll/dpll_core.c    |  4 ++--
>>>> drivers/dpll/dpll_core.h    |  4 ++--
>>>> drivers/dpll/dpll_netlink.c | 28 ++++++++++++++--------------
>>>> 3 files changed, 18 insertions(+), 18 deletions(-)
>>>>
>>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>index 3568149b9562..4077b562ba3b 100644
>>>>--- a/drivers/dpll/dpll_core.c
>>>>+++ b/drivers/dpll/dpll_core.c
>>>>@@ -442,7 +442,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>>>module *module,
>>>> 		ret =3D -EINVAL;
>>>> 		goto err;
>>>> 	}
>>>>-	pin->prop =3D prop;
>>>>+	memcpy(&pin->prop, prop, sizeof(pin->prop));
>>>
>>>Odd, you don't care about the pointer within this structure?
>>>
>>
>>Well, true. Need a fix.
>>Wondering if copying idea is better than just assigning prop pointer on
>>each call to dpll_pin_get(..) function (when pin already exists)?
>
>Not sure what do you mean. Examples please.
>

Sure,

Basically this change:

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index ae884b92d68c..06b72d5877c3 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -483,6 +483,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *=
module,
                    pos->pin_idx =3D=3D pin_idx &&
                    pos->module =3D=3D module) {
                        ret =3D pos;
+                       pos->prop =3D prop;
                        refcount_inc(&ret->refcount);
                        break;
                }

would replace whole of this patch changes, although seems a bit hacky.

Thank you!
Arkadiusz

>
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>> 	refcount_set(&pin->refcount, 1);
>>>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>>>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>>>>@@ -634,7 +634,7 @@ int dpll_pin_on_pin_register(struct dpll_pin
>>>>*parent,
>>>>struct dpll_pin *pin,
>>>> 	unsigned long i, stop;
>>>> 	int ret;
>>>>
>>>>-	if (WARN_ON(parent->prop->type !=3D DPLL_PIN_TYPE_MUX))
>>>>+	if (WARN_ON(parent->prop.type !=3D DPLL_PIN_TYPE_MUX))
>>>> 		return -EINVAL;
>>>>
>>>> 	if (WARN_ON(!ops) ||
>>>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>>>index 5585873c5c1b..717f715015c7 100644
>>>>--- a/drivers/dpll/dpll_core.h
>>>>+++ b/drivers/dpll/dpll_core.h
>>>>@@ -44,7 +44,7 @@ struct dpll_device {
>>>>  * @module:		module of creator
>>>>  * @dpll_refs:		hold referencees to dplls pin was registered
>>>>with
>>>>  * @parent_refs:	hold references to parent pins pin was registered
>>>>with
>>>>- * @prop:		pointer to pin properties given by registerer
>>>>+ * @prop:		pin properties copied from the registerer
>>>>  * @rclk_dev_name:	holds name of device when pin can recover clock
>>>>from it
>>>>  * @refcount:		refcount
>>>>  **/
>>>>@@ -55,7 +55,7 @@ struct dpll_pin {
>>>> 	struct module *module;
>>>> 	struct xarray dpll_refs;
>>>> 	struct xarray parent_refs;
>>>>-	const struct dpll_pin_properties *prop;
>>>>+	struct dpll_pin_properties prop;
>>>> 	refcount_t refcount;
>>>> };
>>>>
>>>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>>>index 93fc6c4b8a78..963bbbbe6660 100644
>>>>--- a/drivers/dpll/dpll_netlink.c
>>>>+++ b/drivers/dpll/dpll_netlink.c
>>>>@@ -278,17 +278,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg, struct
>>>>dpll_pin *pin,
>>>> 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq), &freq,
>>>> 			  DPLL_A_PIN_PAD))
>>>> 		return -EMSGSIZE;
>>>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++) {
>>>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++) {
>>>> 		nest =3D nla_nest_start(msg, DPLL_A_PIN_FREQUENCY_SUPPORTED);
>>>> 		if (!nest)
>>>> 			return -EMSGSIZE;
>>>>-		freq =3D pin->prop->freq_supported[fs].min;
>>>>+		freq =3D pin->prop.freq_supported[fs].min;
>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN, sizeof(freq),
>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>> 			nla_nest_cancel(msg, nest);
>>>> 			return -EMSGSIZE;
>>>> 		}
>>>>-		freq =3D pin->prop->freq_supported[fs].max;
>>>>+		freq =3D pin->prop.freq_supported[fs].max;
>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX, sizeof(freq),
>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>> 			nla_nest_cancel(msg, nest);
>>>>@@ -304,9 +304,9 @@ static bool dpll_pin_is_freq_supported(struct
>>>>dpll_pin
>>>>*pin, u32 freq)
>>>> {
>>>> 	int fs;
>>>>
>>>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++)
>>>>-		if (freq >=3D pin->prop->freq_supported[fs].min &&
>>>>-		    freq <=3D pin->prop->freq_supported[fs].max)
>>>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++)
>>>>+		if (freq >=3D pin->prop.freq_supported[fs].min &&
>>>>+		    freq <=3D pin->prop.freq_supported[fs].max)
>>>> 			return true;
>>>> 	return false;
>>>> }
>>>>@@ -403,7 +403,7 @@ static int
>>>> dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
>>>> 		     struct netlink_ext_ack *extack)
>>>> {
>>>>-	const struct dpll_pin_properties *prop =3D pin->prop;
>>>>+	const struct dpll_pin_properties *prop =3D &pin->prop;
>>>> 	struct dpll_pin_ref *ref;
>>>> 	int ret;
>>>>
>>>>@@ -696,7 +696,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32
>>>>parent_idx,
>>>> 	int ret;
>>>>
>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>-	      pin->prop->capabilities)) {
>>>>+	      pin->prop.capabilities)) {
>>>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>>>> 		return -EOPNOTSUPP;
>>>> 	}
>>>>@@ -732,7 +732,7 @@ dpll_pin_state_set(struct dpll_device *dpll, struct
>>>>dpll_pin *pin,
>>>> 	int ret;
>>>>
>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>-	      pin->prop->capabilities)) {
>>>>+	      pin->prop.capabilities)) {
>>>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>>>> 		return -EOPNOTSUPP;
>>>> 	}
>>>>@@ -759,7 +759,7 @@ dpll_pin_prio_set(struct dpll_device *dpll, struct
>>>>dpll_pin *pin,
>>>> 	int ret;
>>>>
>>>> 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
>>>>-	      pin->prop->capabilities)) {
>>>>+	      pin->prop.capabilities)) {
>>>> 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
>>>> 		return -EOPNOTSUPP;
>>>> 	}
>>>>@@ -787,7 +787,7 @@ dpll_pin_direction_set(struct dpll_pin *pin, struct
>>>>dpll_device *dpll,
>>>> 	int ret;
>>>>
>>>> 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
>>>>-	      pin->prop->capabilities)) {
>>>>+	      pin->prop.capabilities)) {
>>>> 		NL_SET_ERR_MSG(extack, "direction changing is not allowed");
>>>> 		return -EOPNOTSUPP;
>>>> 	}
>>>>@@ -817,8 +817,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct
>>>>nlattr *phase_adj_attr,
>>>> 	int ret;
>>>>
>>>> 	phase_adj =3D nla_get_s32(phase_adj_attr);
>>>>-	if (phase_adj > pin->prop->phase_range.max ||
>>>>-	    phase_adj < pin->prop->phase_range.min) {
>>>>+	if (phase_adj > pin->prop.phase_range.max ||
>>>>+	    phase_adj < pin->prop.phase_range.min) {
>>>> 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
>>>> 				    "phase adjust value not supported");
>>>> 		return -EINVAL;
>>>>@@ -999,7 +999,7 @@ dpll_pin_find(u64 clock_id, struct nlattr
>>>>*mod_name_attr,
>>>> 	unsigned long i;
>>>>
>>>> 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
>>>>-		prop =3D pin->prop;
>>>>+		prop =3D &pin->prop;
>>>> 		cid_match =3D clock_id ? pin->clock_id =3D=3D clock_id : true;
>>>> 		mod_match =3D mod_name_attr && module_name(pin->module) ?
>>>> 			!nla_strcmp(mod_name_attr,
>>>>--
>>>>2.38.1
>>>>
>>

