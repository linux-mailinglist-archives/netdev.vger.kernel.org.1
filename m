Return-Path: <netdev+bounces-47084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EDC7E7BC1
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E93D5B20CEA
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6635114F70;
	Fri, 10 Nov 2023 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T92/sxEG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DEE14AB9
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:18:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0713E2E5E2
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 03:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699615134; x=1731151134;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HJ9/w3IznH8PtbXFfRkKTEmjbPhoIExzx7/+dh6vYhg=;
  b=T92/sxEGFPEb7t9MRe8Iv6QbY9Wtfol7mxMUcJn2Fnn5VwyYn02xuEKf
   2elErd79aBJ0gwj6L0s4R06k9w+7zx7qIyC3iUrusdbuOwe9QTTbRXrLl
   7s+p0504mkGXEUw+7WzK+UgftYKY/zZqBb1uBHBu5X8mog286StOuowyD
   PiFqNeXy7ZNQUbCrClINrL/fXpj9rPdYMoIbeCRv2g+vsgkMnhjVYD3ng
   obxb4W2kkn2soZKHdCCkKW5xp2m3QrJrSCH4ZApEGrEwVnm4XAlxc0wck
   yY9UvxUebB71IMNzcAn6cUhT4U9KWXy2kfdRBnF91IKhh7krjHsSTmnWD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="454471944"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="454471944"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 03:18:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="937149772"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="937149772"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 03:18:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 03:18:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 03:18:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 03:18:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXUPJcZHOfdlNOplWLh7NaX14u+FPvTWyBFYge7M/uUYxUf06lyXrXOh0Wiu31jteOc0+0u6FBnzmtybjt11OqjWHyD05tJstrt+F15l/CdLYrDu4HbfffoXiAv6HEhD49uMgaF94oaeuI98vvFhoaZONYWU0gs71I/vJ7DGHWz4RjaOgfwYCD4PkmCyCdH/5wMXC/oQ3zDvi1VxIusbuC9Rj/7IdvPdn4EwtrWNUVjjiDdhsD8rJH4Y3Y/Hz+d3cgdmQjPpvW8Tj0My43Ed4srtEjnbDqhxvRxR1MQakjol6Y8KIcVrc22CizliFkdFNp61b7hrj1nm5r3gXVzH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgpOk2OtcyTAgaI7ONlw+flbwbEFT1K+fD1bBlht1r8=;
 b=kcXOGFm+tiPq6wkJy4iMlSR3qR41pXnvUi5Sr/mvR3cDUEr+tTW5F/R9yNO1YpQR7Zmm0w252+iUWSxC2IcQMHLAtYj7wnFa/jqTzmnu9+60dc3J3IKBsdV0edsB7qjBfMKSgXhtV9aPrzFbZfccT4UZ4v5AZN1/xYREn0rkDKOzccmOSqaOJNVvHJEn65lpZzsRdzFL+XOjTVXn+5zUh/+uabwd+R3A9tzMYaaS+XF5u7mGY8Q36yDCRj5omsJvLoYEeQy8iWHOdm3s0xryD/wcxTmC3D1aI+/QRpg+KfORf0mC7fzTCrIwOo7Tv3Mt4k3plFkF9fAaxHujBTYbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM4PR11MB6119.namprd11.prod.outlook.com (2603:10b6:8:b0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Fri, 10 Nov 2023 11:18:51 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 11:18:51 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Topic: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Index: AQHaEi9PNvCIepF1tEu7KRNf+M25RbBwe78AgAFGpmCAADfgAIAAMUJwgAAe7ICAAFgbsIAAfB6AgAAjAGCAABUUAIAAEkyQ
Date: Fri, 10 Nov 2023 11:18:51 +0000
Message-ID: <DM6PR11MB46578574D6DA2F311FB97CF09BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-3-arkadiusz.kubalewski@intel.com>
 <ZUubagu6B+vbfBqm@nanopsycho>
 <DM6PR11MB465752FE337EB962B147EB579BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZUzcTBmSPxIs5iH3@nanopsycho>
 <DM6PR11MB46571D4C776B0B1888F943569BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fj5y9mAvVzXuf@nanopsycho>
 <DM6PR11MB4657DAC525E05B5DB72145119BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU3RlSmInnoXufxf@nanopsycho>
 <DM6PR11MB4657B61E86D5DFFAF83BC1E59BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU4AoNqxo6j5zy+V@nanopsycho>
In-Reply-To: <ZU4AoNqxo6j5zy+V@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM4PR11MB6119:EE_
x-ms-office365-filtering-correlation-id: d870c39b-d7d7-464d-09a2-08dbe1ded155
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/yGx4jCpKpifd/LU7q7DIOaA2vf2Xz3B2BXhsBxkEn+e8K4FyoatX8IOg9tA6n3jtnvCddHagq/+oPX933FPNZ8Qrwx6F1nKBii6OPCPsY3uwdIPhTSub/Uh1ILskxsFIFK6Vt61oYNzuiTsjR0BW9F3o4tkVBlC2YfaXYmYLNJYBxn7NSL4vt8iBSH6qe0oApwANp5NIbnP4gh/O4PMK9RGA2M5qkQ7AVUusz+ZxYEw9kdurPxs4T1/UhodeNAErFevGQygeYAhTIbJkAJYfiaAx/nhZdJyl842E6YJda3uO/ugqo1YyNjDLyPXNwVsMrBgerdUX6z05aMGtjhPMPrq1DodM5ms9Izd4pciJfSeGv8QhwfgvSfId6WNozpu40gKC21XJwDzgd0V5kFWeCKc+aJY0vhhwtjwXfS+KUsjxP9jd1J4iKn9NTr5uBJGjGAkBA1Gk+mKSlI8rSh3yOcT9Y2L52b3TihI/aP6dl+o2TLVbepA6VovUKa/+mc98yE7VPPII99Z6NHluFEZmr9PR1znX+kAUSmqNr2r3I+ZONs1kQfVqI4RTQoL4+01vYHTdDLLMKx8Qgwl40CcSc3Q/rJ80jEw2Pqhr2t7nbISSwSUmdMdNcMoISG6lRs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(55016003)(9686003)(83380400001)(66899024)(478600001)(6506007)(7696005)(316002)(4326008)(66446008)(66556008)(6916009)(30864003)(2906002)(76116006)(66946007)(66476007)(64756008)(86362001)(54906003)(122000001)(41300700001)(71200400001)(8676002)(5660300002)(52536014)(38100700002)(38070700009)(8936002)(82960400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R3M59U3B6ISE/LHBg+6HlppqePYS//TVO3APx9PyhLSgTKqJ1kyXcnSeP+5i?=
 =?us-ascii?Q?EonoOdKMg16X2Djtyq2IOlmXGV8hKP/ouKyBIrAsavAgbbFoDDAzCHIROKky?=
 =?us-ascii?Q?qVgn0su7s+LC5wQ+9WH8Fp7sH8XdvBG/6SfKZhgePQYTD8Rvn82FSTbXqHQV?=
 =?us-ascii?Q?mW/2NbiKojgD8CRUlJgTMUMnlClw+16BtXzbqxgYd1N1HG/3dYE2xwrVNXk7?=
 =?us-ascii?Q?CQdMDkWWhJyy7ruZRqkpe6CTJuKDNQu2l4thnWW8O1MjfcXNLMFi6sxEHkGQ?=
 =?us-ascii?Q?3d1kX3AsTSK6d8g/sZ7+/BPL+jha3Du/1ZhOovETq9iz+/j9CoyEY+TOcyWy?=
 =?us-ascii?Q?64k1Dh8qLhEEfANFlmqGK0zgo/W8yiyXJY/fjflBTyG8VFCBvqgGk9JP905X?=
 =?us-ascii?Q?5ZbgT4pIVQI6Lg7vpX+k27nKXhISh9hLozVP2y2uqcafeSy9MIBGJPH2Gpx4?=
 =?us-ascii?Q?aaoRhx2CtWw5/M6HZe+uVGSpW9rffR+AaKYgpJFY7GgFU2Po/NybUTEucqR9?=
 =?us-ascii?Q?sg8a2/b7pkbI1ISMVpFXk6gOxWkW+yN00csIxs41bZ2ZKbFYGvOTaKF2rpYs?=
 =?us-ascii?Q?IB514YaXewDLS29w0gzyFLBNgS42z5jRd78wtqEPDviCFyQdz+WlU7wSl/wU?=
 =?us-ascii?Q?CTA2J7wSITlkPOgAcoauX3/6lnlBLMJVWZVgVKePA3tZJtWCW8aCA8FERAfg?=
 =?us-ascii?Q?454TmggrGz4k7gpLi5Ra2h2VSFLgDZEwbTKCeMl4dWByNVrzHOs9NdR42rK0?=
 =?us-ascii?Q?U15aJ37u3cTBmH317YqcjnJPixKXVU0vIfevNG+3VLTxvVRZvxDidkBavdLy?=
 =?us-ascii?Q?3h8QsdcKnVqMhHzYzNkHroZmQxGEtlOTGtZdnA0qj+iu+fAwJl8T6QEocUWC?=
 =?us-ascii?Q?I/dXx+YKqe8CR8FlhVmaQV+T8PlNd2HoZJ8VUwSUnV1l8VOjatwJ5JYsxqy6?=
 =?us-ascii?Q?xIJVqkOB36hQxmRL5d/Z9A6oHeJOoTMSMOb7ub54l+Ga1ISDZmreXyGsxa52?=
 =?us-ascii?Q?xLtSpH7KhX0S4LpIJIJuALJ+sd9ev8By1eWa7sW3mYMmX0+/SnTpyIf3l01m?=
 =?us-ascii?Q?oaHrSkVa7zxIYaEymh8kblKRFXPMC0ePlXMQ6/dM3lo75tUbVjzu3GiNxJq3?=
 =?us-ascii?Q?zPp0iff0RI/qwZ/F0fOLTVvxB7hoAgqBL1/Mz8OLUA3EhqVdG/P8zPJuxgS7?=
 =?us-ascii?Q?mNUBh9f6FdnWOlb9OeFOh1fijaqGVWZeuLATBAS94lDcnEH+spoP9J1ilG/a?=
 =?us-ascii?Q?uPNzba6wOXPMkQfoWQatgdrmrIJBPjAFYmkox3pjZTK++xLHDG8vRfgzU95x?=
 =?us-ascii?Q?jYLvlWNbcf1nZqybsNuXJjkJQcGyilEzt7et4Yh8aUa83r5alns3klD17PX9?=
 =?us-ascii?Q?T+uH4brRQ6AUA0iO+h2fgInQdwmqhrEzowncs4X8AXJb/0Sk8Cr3Hi6NOJDV?=
 =?us-ascii?Q?jJEv37wxCCE571TaSUtU9eYUH0rmX8KNXprVGMlWjGD2Crt1tlm9PpZW63i6?=
 =?us-ascii?Q?vpW1yeod9fGHxgBqpn3SnNpwYSq4kBnNCosdyQ2bMlsefep/4k6x2f9oXkuK?=
 =?us-ascii?Q?sXhekEurgTjkHiOqlY/TkIaGZN1hiktyxVfS8OOKoHMAivS86XW6Xgvyq5rK?=
 =?us-ascii?Q?XQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d870c39b-d7d7-464d-09a2-08dbe1ded155
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 11:18:51.3943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPlEIkHvZM/YA9Y/d6LXBt+y7jD++kAYblXxzQHXFGZRapdb8IRGWmgjN5wLv//0YkKgZ8Zh2hfQ+p/0bRrV8Uw9fiy2zmW66qULAijEA8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6119
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, November 10, 2023 11:06 AM
>
>Fri, Nov 10, 2023 at 10:01:50AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Friday, November 10, 2023 7:46 AM
>>>
>>>Fri, Nov 10, 2023 at 12:32:21AM CET, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Thursday, November 9, 2023 7:06 PM
>>>>>
>>>>>Thu, Nov 09, 2023 at 05:30:20PM CET, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>Sent: Thursday, November 9, 2023 2:19 PM
>>>>>>>
>>>>>>>Thu, Nov 09, 2023 at 01:20:48PM CET, arkadiusz.kubalewski@intel.com
>>>>>>>wrote:
>>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>Sent: Wednesday, November 8, 2023 3:30 PM
>>>>>>>>>
>>>>>>>>>Wed, Nov 08, 2023 at 11:32:25AM CET, arkadiusz.kubalewski@intel.co=
m
>>>>>>>>>wrote:
>>>>>>>>>>When a kernel module is unbound but the pin resources were not
>>>>>>>>>>entirely
>>>>>>>>>>freed (other kernel module instance have had kept the reference t=
o
>>>>>>>>>>that
>>>>>>>>>>pin), and kernel module is again bound, the pin properties would
>>>>>>>>>>not
>>>>>>>>>>be
>>>>>>>>>>updated (the properties are only assigned when memory for the pin
>>>>>>>>>>is
>>>>>>>>>>allocated), prop pointer still points to the kernel module memory
>>>>>>>>>>of
>>>>>>>>>>the kernel module which was deallocated on the unbind.
>>>>>>>>>>
>>>>>>>>>>If the pin dump is invoked in this state, the result is a kernel
>>>>>>>>>>crash.
>>>>>>>>>>Prevent the crash by storing persistent pin properties in dpll
>>>>>>>>>>subsystem,
>>>>>>>>>>copy the content from the kernel module when pin is allocated,
>>>>>>>>>>instead
>>>>>>>>>>of
>>>>>>>>>>using memory of the kernel module.
>>>>>>>>>>
>>>>>>>>>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base
>>>>>>>>>>functions")
>>>>>>>>>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>>>>>>>>functions")
>>>>>>>>>>Signed-off-by: Arkadiusz Kubalewski
>>>>>>>>>><arkadiusz.kubalewski@intel.com>
>>>>>>>>>>---
>>>>>>>>>> drivers/dpll/dpll_core.c    |  4 ++--
>>>>>>>>>> drivers/dpll/dpll_core.h    |  4 ++--
>>>>>>>>>> drivers/dpll/dpll_netlink.c | 28 ++++++++++++++--------------
>>>>>>>>>> 3 files changed, 18 insertions(+), 18 deletions(-)
>>>>>>>>>>
>>>>>>>>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>>>>>>>index 3568149b9562..4077b562ba3b 100644
>>>>>>>>>>--- a/drivers/dpll/dpll_core.c
>>>>>>>>>>+++ b/drivers/dpll/dpll_core.c
>>>>>>>>>>@@ -442,7 +442,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx,
>>>>>>>>>>struct
>>>>>>>>>>module *module,
>>>>>>>>>> 		ret =3D -EINVAL;
>>>>>>>>>> 		goto err;
>>>>>>>>>> 	}
>>>>>>>>>>-	pin->prop =3D prop;
>>>>>>>>>>+	memcpy(&pin->prop, prop, sizeof(pin->prop));
>>>>>>>>>
>>>>>>>>>Odd, you don't care about the pointer within this structure?
>>>>>>>>>
>>>>>>>>
>>>>>>>>Well, true. Need a fix.
>>>>>>>>Wondering if copying idea is better than just assigning prop pointe=
r
>>>>>>>>on
>>>>>>>>each call to dpll_pin_get(..) function (when pin already exists)?
>>>>>>>
>>>>>>>Not sure what do you mean. Examples please.
>>>>>>>
>>>>>>
>>>>>>Sure,
>>>>>>
>>>>>>Basically this change:
>>>>>>
>>>>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>>>index ae884b92d68c..06b72d5877c3 100644
>>>>>>--- a/drivers/dpll/dpll_core.c
>>>>>>+++ b/drivers/dpll/dpll_core.c
>>>>>>@@ -483,6 +483,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct
>>>>>>module
>>>>>>*module,
>>>>>>                    pos->pin_idx =3D=3D pin_idx &&
>>>>>>                    pos->module =3D=3D module) {
>>>>>>                        ret =3D pos;
>>>>>>+                       pos->prop =3D prop;
>>>>>>                        refcount_inc(&ret->refcount);
>>>>>>                        break;
>>>>>>                }
>>>>>>
>>>>>>would replace whole of this patch changes, although seems a bit hacky=
.
>>>>>
>>>>>Or event better, as I suggested in the other patch reply, resolve this
>>>>>internally in the driver registering things only when they are valid.
>>>>>Much better then to hack anything in dpll core.
>>>>>
>>>>
>>>>This approach seemed to me hacky, that is why started with coping the
>>>>data.
>>>>It is not about registering, rather about unregistering on driver
>>>>unbind, which brakes things, and currently cannot be recovered in
>>>>described case.
>>>
>>>Sure it can. PF0 unbind-> internal notification-> PF1 unregisters all
>>>related object. Very clean and simple.
>>>
>>
>>What you are suggesting is:
>>- special purpose bus in the driver,
>
>No, it is a simple notificator. Very common infra over the whole
>kernel code.
>

No difference if this is simple or not, it is special purpose.

>
>>- dpll-related,
>
>Is this the only thing that PF0 is special with? Perhaps you can
>utilize this for other features as well, since your fw design is like
>this.
>

None api user is allowed to the unordered driver bind when there are muxed
pins involved.
This requires a fix in the api not in the driver.

>
>>- not needed,
>>- prone for errors.
>>
>>The dpll subsystem is here to make driver life easier.
>
>No, the subsystem is never here to handle device specific issues. And
>your PF0 dependency is very clearly something device specific. Don't
>pollute the dpll subsystem with workaround to handle specific device
>needs. create/register the dplls objects from your driver only when it
>is valid to do so. Make sure the lifetime of such object stays in
>the scope of validity. Handle that in the driver. Very clear and simple.
>

In our case this is PF0 but this is broader issue. The muxed pins
infrastructure in now slightly broken and I am fixing it.
From the beginning it was designed to allow separated driver instances
to create a device and connect their pins with it.
Any driver which would use it would face this issue. What you are trying
to imply is that it is better to put traffic lights on each car instead
of putting them on crossroads.

>Thanks!
>

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
>>>>>>>>
>>>>>>>>Thank you!
>>>>>>>>Arkadiusz
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> 	refcount_set(&pin->refcount, 1);
>>>>>>>>>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>>>>>>>>>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>>>>>>>>>>@@ -634,7 +634,7 @@ int dpll_pin_on_pin_register(struct dpll_pin
>>>>>>>>>>*parent,
>>>>>>>>>>struct dpll_pin *pin,
>>>>>>>>>> 	unsigned long i, stop;
>>>>>>>>>> 	int ret;
>>>>>>>>>>
>>>>>>>>>>-	if (WARN_ON(parent->prop->type !=3D DPLL_PIN_TYPE_MUX))
>>>>>>>>>>+	if (WARN_ON(parent->prop.type !=3D DPLL_PIN_TYPE_MUX))
>>>>>>>>>> 		return -EINVAL;
>>>>>>>>>>
>>>>>>>>>> 	if (WARN_ON(!ops) ||
>>>>>>>>>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>>>>>>>>>index 5585873c5c1b..717f715015c7 100644
>>>>>>>>>>--- a/drivers/dpll/dpll_core.h
>>>>>>>>>>+++ b/drivers/dpll/dpll_core.h
>>>>>>>>>>@@ -44,7 +44,7 @@ struct dpll_device {
>>>>>>>>>>  * @module:		module of creator
>>>>>>>>>>  * @dpll_refs:		hold referencees to dplls pin was
>>>>>>>>>>registered
>>>>>>>>>>with
>>>>>>>>>>  * @parent_refs:	hold references to parent pins pin was
>>>>>>>>>>registered
>>>>>>>>>>with
>>>>>>>>>>- * @prop:		pointer to pin properties given by registerer
>>>>>>>>>>+ * @prop:		pin properties copied from the registerer
>>>>>>>>>>  * @rclk_dev_name:	holds name of device when pin can recover
>>>>>>>>>>clock
>>>>>>>>>>from it
>>>>>>>>>>  * @refcount:		refcount
>>>>>>>>>>  **/
>>>>>>>>>>@@ -55,7 +55,7 @@ struct dpll_pin {
>>>>>>>>>> 	struct module *module;
>>>>>>>>>> 	struct xarray dpll_refs;
>>>>>>>>>> 	struct xarray parent_refs;
>>>>>>>>>>-	const struct dpll_pin_properties *prop;
>>>>>>>>>>+	struct dpll_pin_properties prop;
>>>>>>>>>> 	refcount_t refcount;
>>>>>>>>>> };
>>>>>>>>>>
>>>>>>>>>>diff --git a/drivers/dpll/dpll_netlink.c
>>>>>>>>>>b/drivers/dpll/dpll_netlink.c
>>>>>>>>>>index 93fc6c4b8a78..963bbbbe6660 100644
>>>>>>>>>>--- a/drivers/dpll/dpll_netlink.c
>>>>>>>>>>+++ b/drivers/dpll/dpll_netlink.c
>>>>>>>>>>@@ -278,17 +278,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg,
>>>>>>>>>>struct
>>>>>>>>>>dpll_pin *pin,
>>>>>>>>>> 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq),
>>>>>>>>>>&freq,
>>>>>>>>>> 			  DPLL_A_PIN_PAD))
>>>>>>>>>> 		return -EMSGSIZE;
>>>>>>>>>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++) {
>>>>>>>>>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++) {
>>>>>>>>>> 		nest =3D nla_nest_start(msg,
>>>>>>>>>>DPLL_A_PIN_FREQUENCY_SUPPORTED);
>>>>>>>>>> 		if (!nest)
>>>>>>>>>> 			return -EMSGSIZE;
>>>>>>>>>>-		freq =3D pin->prop->freq_supported[fs].min;
>>>>>>>>>>+		freq =3D pin->prop.freq_supported[fs].min;
>>>>>>>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN,
>>>>>>>>>>sizeof(freq),
>>>>>>>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>>>>>>>> 			nla_nest_cancel(msg, nest);
>>>>>>>>>> 			return -EMSGSIZE;
>>>>>>>>>> 		}
>>>>>>>>>>-		freq =3D pin->prop->freq_supported[fs].max;
>>>>>>>>>>+		freq =3D pin->prop.freq_supported[fs].max;
>>>>>>>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX,
>>>>>>>>>>sizeof(freq),
>>>>>>>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>>>>>>>> 			nla_nest_cancel(msg, nest);
>>>>>>>>>>@@ -304,9 +304,9 @@ static bool dpll_pin_is_freq_supported(struct
>>>>>>>>>>dpll_pin
>>>>>>>>>>*pin, u32 freq)
>>>>>>>>>> {
>>>>>>>>>> 	int fs;
>>>>>>>>>>
>>>>>>>>>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++)
>>>>>>>>>>-		if (freq >=3D pin->prop->freq_supported[fs].min &&
>>>>>>>>>>-		    freq <=3D pin->prop->freq_supported[fs].max)
>>>>>>>>>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++)
>>>>>>>>>>+		if (freq >=3D pin->prop.freq_supported[fs].min &&
>>>>>>>>>>+		    freq <=3D pin->prop.freq_supported[fs].max)
>>>>>>>>>> 			return true;
>>>>>>>>>> 	return false;
>>>>>>>>>> }
>>>>>>>>>>@@ -403,7 +403,7 @@ static int
>>>>>>>>>> dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
>>>>>>>>>> 		     struct netlink_ext_ack *extack)
>>>>>>>>>> {
>>>>>>>>>>-	const struct dpll_pin_properties *prop =3D pin->prop;
>>>>>>>>>>+	const struct dpll_pin_properties *prop =3D &pin->prop;
>>>>>>>>>> 	struct dpll_pin_ref *ref;
>>>>>>>>>> 	int ret;
>>>>>>>>>>
>>>>>>>>>>@@ -696,7 +696,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin
>>>>>>>>>>*pin,
>>>>>>>>>>u32
>>>>>>>>>>parent_idx,
>>>>>>>>>> 	int ret;
>>>>>>>>>>
>>>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>>>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>>>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>>>> 	}
>>>>>>>>>>@@ -732,7 +732,7 @@ dpll_pin_state_set(struct dpll_device *dpll,
>>>>>>>>>>struct
>>>>>>>>>>dpll_pin *pin,
>>>>>>>>>> 	int ret;
>>>>>>>>>>
>>>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>>>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>>>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>>>> 	}
>>>>>>>>>>@@ -759,7 +759,7 @@ dpll_pin_prio_set(struct dpll_device *dpll,
>>>>>>>>>>struct
>>>>>>>>>>dpll_pin *pin,
>>>>>>>>>> 	int ret;
>>>>>>>>>>
>>>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
>>>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>>>> 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
>>>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>>>> 	}
>>>>>>>>>>@@ -787,7 +787,7 @@ dpll_pin_direction_set(struct dpll_pin *pin,
>>>>>>>>>>struct
>>>>>>>>>>dpll_device *dpll,
>>>>>>>>>> 	int ret;
>>>>>>>>>>
>>>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
>>>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>>>> 		NL_SET_ERR_MSG(extack, "direction changing is not
>>>>>>>>>>allowed");
>>>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>>>> 	}
>>>>>>>>>>@@ -817,8 +817,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin,
>>>>>>>>>>struct
>>>>>>>>>>nlattr *phase_adj_attr,
>>>>>>>>>> 	int ret;
>>>>>>>>>>
>>>>>>>>>> 	phase_adj =3D nla_get_s32(phase_adj_attr);
>>>>>>>>>>-	if (phase_adj > pin->prop->phase_range.max ||
>>>>>>>>>>-	    phase_adj < pin->prop->phase_range.min) {
>>>>>>>>>>+	if (phase_adj > pin->prop.phase_range.max ||
>>>>>>>>>>+	    phase_adj < pin->prop.phase_range.min) {
>>>>>>>>>> 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
>>>>>>>>>> 				    "phase adjust value not supported");
>>>>>>>>>> 		return -EINVAL;
>>>>>>>>>>@@ -999,7 +999,7 @@ dpll_pin_find(u64 clock_id, struct nlattr
>>>>>>>>>>*mod_name_attr,
>>>>>>>>>> 	unsigned long i;
>>>>>>>>>>
>>>>>>>>>> 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
>>>>>>>>>>-		prop =3D pin->prop;
>>>>>>>>>>+		prop =3D &pin->prop;
>>>>>>>>>> 		cid_match =3D clock_id ? pin->clock_id =3D=3D clock_id : true;
>>>>>>>>>> 		mod_match =3D mod_name_attr && module_name(pin->module) ?
>>>>>>>>>> 			!nla_strcmp(mod_name_attr,
>>>>>>>>>>--
>>>>>>>>>>2.38.1
>>>>>>>>>>
>>>>>>>>
>>>>

