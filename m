Return-Path: <netdev+bounces-62993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA1182AA87
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342D82821D8
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965EFC0B;
	Thu, 11 Jan 2024 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaoQliZw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35310940
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704964037; x=1736500037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LjttTbrIHjpSPOqpSDknuLojcA9DlE7nQmwiU7usBpE=;
  b=TaoQliZwflAsY+W+6LWCdI/Ao/UAIOB5nySlgvOKJxonOq60qlYHXZoH
   jbR00d8vLwt1KNDoEt8FySKdwgKmv6jgU/PMvlbcKPnl/OdGQH1cDdflV
   xOXBWX0YLEeUsePTAZIWbY08TYuScmiLy49iYrnVXv7M02D2qHf3jvguG
   /+gUfH9t8xmwJaoAvFUsdJU8kzW2DE+Q40fMxlmT3D4s2eR94XNzaV+rw
   lX742A+a0DKY/cWB9QZiBIy803zB/sLWRn23giX7ZjYk9ufo9Vw4ddSDf
   TqRzKGIZyeEgfhTOfXkhsZCbNU7V7rjpDd7wqtsefMrdD0iVWcxaaBH6E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="402559007"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="402559007"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="872958915"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="872958915"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 01:07:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 01:07:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 01:07:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 01:07:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLvMASyh1MFF4wDchQykPR+5r2HouQ/xvqJgAumX5yhP5nQIwSXUmN344KMcUGG2XTM/V2Thbb2bU0wiE/RJwe/+CKbs72U4r1c8b+ro1yDJAcP9q0/wSY2MChLSK2r2XKX7Ye/XsNz+Qd04oGMPvvuAfI/+JWpC4qWgWY0f+vxDzahk4k8swj/0JUceePokfwDdmMK0chqq8hYVS3XYMcbCPxIkH132erjkxX1XdauUJR4K6PqnCcMIlSzoBXZIE4wzsFmdYm5fddb4iJ3+YuMO8K5bzQl2fJKUpFFts259Pw8wdknORDSLVvlp5gCtVgTiIbNb5VOj6G+kS+CoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5HGnV7UiBLKKzqRV81vdZY90U5HoOpY4sIupmaRGBs=;
 b=g4oDTRa/KgeA7eL4MEO1cOdu1CcrxkMLf6fAJysd9d+aSSBHDhi4GVL6LYQWu+EuNRX1tM7cWsDf+mj0InKVB/+I1tNKtwl8JVy+pDIxiy6PNtoZpgdZ9k4xtlM9NhbutBeIQCwTdYm8Aye1EvjXNUDxiykqe0jhFrKBNDgWdrJzK25RjKowv51GLeRnKYZuaoseLVKc64LjziC6fIoL4UB5J9AgHQP6iDVqJj3Znpv/O5p/grxvZtieoNcn/63QAFH6obrM3uFKq4MTHCdVjZWvqktW1VBE1EsUEZiuzPKR6+GVsVh1Drcbkkmn02Ikl+wyRA+G2HrALHZMtrCIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 09:07:13 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 09:07:13 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Olech, Milena"
	<milena.olech@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "Glaza, Jan" <jan.glaza@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH net v2 2/4] dpll: fix pin dump crash for rebound module
Thread-Topic: [PATCH net v2 2/4] dpll: fix pin dump crash for rebound module
Thread-Index: AQHaPv9T2ZvXSItxZE2yIUAw/db2z7DJys8AgAqOMjA=
Date: Thu, 11 Jan 2024 09:07:13 +0000
Message-ID: <DM6PR11MB465736A99FADB61391D5AC4A9B682@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-3-arkadiusz.kubalewski@intel.com>
 <ZZbRhsldnlKQfoDb@nanopsycho>
In-Reply-To: <ZZbRhsldnlKQfoDb@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SA1PR11MB5778:EE_
x-ms-office365-filtering-correlation-id: b12c1972-fe4a-4cda-6df8-08dc1284b332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JAcAD3I868xbXBngk/L4Qy7+MUfPeDPcriSJK+YxnlifRXBD8citgZvA2TPYqzfD6VWMXK9qVvZfLlq2UuMGv8DcxVSwSZIgkHTbYmRQ8CYuqSZSx4QLh64EJnHfQLdFRFiHiDlLYBC3PUuFriC8FlN56Hi5yPfbhEh3FU/ILKl56uccr5B2xi8Hd0KXO4daNeiX7gb6XhoEioTWQnIVTdLPx0l2W5wREVrbPqyY8PeEti9Apz4a+EVzNN59vD/luw3AQHjBmCOqA+NquKEwiw47/Kt6w5kbU8Wc+wATwdSNSYdWTiDp42C5HVR0VZTU/Jx+42r6CLNpeoGSl76b2X1XPxvg9kptsiqZJ+UEbo+vXS6X9EBVwlHUxy8jSTrYQZJgtGFgaUW61D2k1BlwONowFTTbMsdhqDSLYrYziei+4+6qdwqosAFl7OfTn5F1NMkU0woIIkmDZhZGyvDEP6SXQ8HaeKK+np7WzkaqIsTNuLiyCvI+BT9uQIBGVAmEZXLBZ5t+q7kxEfiQfG8A2e6dQ7n+AK7QncuLoki/lJXcPqiexn5KXY0NzQrPcvE5CZijDjuHZK/PRv1Ud1/LVosDuMbnuGOpQ2YbU4fLrGs5+34uf71tZK9fFINrRb2r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66899024)(8676002)(33656002)(5660300002)(52536014)(2906002)(122000001)(8936002)(38100700002)(4326008)(41300700001)(82960400001)(86362001)(83380400001)(6506007)(7696005)(478600001)(66946007)(9686003)(26005)(66476007)(54906003)(66446008)(107886003)(6916009)(64756008)(316002)(76116006)(66556008)(38070700009)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TfN/hpfiaJX+7PhmWzKhMBhmcrdXJ6dTcicwXrljv0Sy6nNcW9DGVKFP2k4M?=
 =?us-ascii?Q?t1Pq7wc/HdCzFCpVFvmMGup5dru+dBxpGUY9C9T+nxSHqW6p/BOaNBFAATu5?=
 =?us-ascii?Q?Shjih8hPqSlkOpPX2DYDQTegbor9wNpBDIbgGymPVEmB0+HsZHrfktNhHKSb?=
 =?us-ascii?Q?3e1ADFxoGTaw3quqc3MLrxTT4vc3t7e5+RAns1rZmkC9x8viqOD28mRJZU56?=
 =?us-ascii?Q?flEL6VpayM8bFgROXvzrgyRSX3bi8398cO59gzTUXoQ3jbo61E2LHLxJVn7O?=
 =?us-ascii?Q?AadDy1sTl+Kd69KVXQIp50aXbknWYR1HQQJh7cMhplwHhQRmNncvL3lqrulI?=
 =?us-ascii?Q?gaVC6nYA2xrYCdVvmuALnl2qwQjMRi5y/yOO9lBCz0lN29BZvK/9n7M8gPiM?=
 =?us-ascii?Q?YLiOiSgvDHiNSuL3YcCgaB7YFIBrFiDz1HDh3VFTkNurc9vsX89mp5WNXXMv?=
 =?us-ascii?Q?pE4WYSieFuiCnsVBjTjwl8wMjSXRhb/CDH76CLUc6qjG6iwXhSOBWOuhC6Vn?=
 =?us-ascii?Q?iad4opaXo+BkucYvMu+/l0h8jphtjWKOD7zgmrCgKbsMudjL2WsFKRizY2D0?=
 =?us-ascii?Q?jhl5PD8p9V2BJ/ql1XRyKf0N/+IGvAJhJ7wzgJm2YN0zfVr5Y3Qt0f95X+rs?=
 =?us-ascii?Q?LexIWSCaLXAWFS/L6P+hutsqnDO6wsJmDzlFJHHTEEz1nKOPQRyDf2uezY8y?=
 =?us-ascii?Q?KbW2HyChDrZZeS4UuIMm+IkiSkP2BkBYAgv4nTXER8/SfIOKeiP+fVUA5DkQ?=
 =?us-ascii?Q?41uq0uxaJ6B3TA1AltCbdS6ToBcnAZ2Wd5nmNP52kR0Ej060p1LKnRx8u93m?=
 =?us-ascii?Q?RpIstFUa8zi5YsYn3cMob/srXzzi6L1Dd8RYcE6W5ZHeRmE5mWReEWaLuj6O?=
 =?us-ascii?Q?PXrgYaSkd6RKgdUJuqCgByfqusgvVd9r7dWq8rIyF+SLb2f9iygQi9F/fdr+?=
 =?us-ascii?Q?LidVfQ/45zaH6Y+B6ErnqlTAbT6gotItyKI3jQ78JILpEJmymohjjCPASudC?=
 =?us-ascii?Q?J0k8qpuLSISHWjsGm2UFcb8Ij4DpNq7LTJlqjSt4nhbTmqs1APWY2KPQkCns?=
 =?us-ascii?Q?XZCSBu7G0h4Aqi92jb+9o0pwiuzP5aVffHHlZKv07zfHFIRpv1lMv9na5Kcf?=
 =?us-ascii?Q?ljL5fhrIxbKq7ur4GYcmxKPKhMfKbKBD9mtCych0cR6LCjrWv2eLKllciBVG?=
 =?us-ascii?Q?fOIquISjBnXLGW3JCTCec4X6VQgglSNlXUS+ME+kQqFTPcXcZ/g6RW/8x6s2?=
 =?us-ascii?Q?i1M4UGF+iGK3+tBw484Hmz26ixS3N3EuMT9tKv+zpIZ1/oqiX0DPVhbF5DVq?=
 =?us-ascii?Q?VCe0gfKL/HZg+tb7UJZQxeFFG4UdzBUeSMfS716YP9ph9UsELD7wlgIZQ72L?=
 =?us-ascii?Q?o748nV9nmNKT4K0ctWrh2iZ7Cq2s53yaJmbWqyx5WhrtTyTUKIyK5GzIpRmu?=
 =?us-ascii?Q?l5VtlBFq6hMHu3wLpEGUMjJlinDEHklpvafsPPjlSLX9cVqh84Y+0H+m+Q/j?=
 =?us-ascii?Q?le6trBOEiIoZXOqE256ptysGp/KwV5jDfAQNRU2TkMqyPZRY4NlIuiMS/8kG?=
 =?us-ascii?Q?biZ0lfaUsMkgA/OBUi600MGIB41ZSbI/qTJW0wbVsfH3cTY2cMTx4om34IOR?=
 =?us-ascii?Q?Qw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b12c1972-fe4a-4cda-6df8-08dc1284b332
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 09:07:13.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tc1dGUQBAgxuc/6OMs4J9TatRuh45gzM9K9RxaZ0Q096QPMKcNkTrZSwu+QqkQhddD4FB1vjzIY8HRIXcsErb+zMTpw+RKzCU1oXRQ4FP+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, January 4, 2024 4:41 PM
>
>Thu, Jan 04, 2024 at 12:11:30PM CET, arkadiusz.kubalewski@intel.com wrote:
>>When a kernel module is unbound but the pin resources were not entirely
>>freed (other kernel module instance have had kept the reference to that
>
>Wait, you talk about module, yet you mean pci instance of the same
>module, don't you?
>

Well, the kernel module can have multiple instances. I.e. for multiple PCI
devices, or one each Physical Function available on a single PCI device. Ou=
r case
is a kernel module instance of different PF but still a single PCI device.
In general, all the PCI devices controlled by given kernel module which use=
 the
same dpll device would see this behavior.

But sure, can mention that those belong to single PCI device in the commit
message.

>
>>pin), and kernel module is again bound, the pin properties would not be
>>updated (the properties are only assigned when memory for the pin is
>>allocated), prop pointer still points to the kernel module memory of
>>the kernel module which was deallocated on the unbind.
>>
>>If the pin dump is invoked in this state, the result is a kernel crash.
>>Prevent the crash by storing persistent pin properties in dpll subsystem,
>>copy the content from the kernel module when pin is allocated, instead of
>>using memory of the kernel module.
>>
>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>> drivers/dpll/dpll_core.c    | 29 ++++++++++++++++++++++++++---
>> drivers/dpll/dpll_core.h    |  4 ++--
>> drivers/dpll/dpll_netlink.c | 28 ++++++++++++++--------------
>> 3 files changed, 42 insertions(+), 19 deletions(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>index 3568149b9562..0b469096ef79 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -429,6 +429,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>module *module,
>> 	       const struct dpll_pin_properties *prop)
>> {
>> 	struct dpll_pin *pin;
>>+	size_t freq_size;
>> 	int ret;
>>
>> 	pin =3D kzalloc(sizeof(*pin), GFP_KERNEL);
>>@@ -440,9 +441,22 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>module *module,
>> 	if (WARN_ON(prop->type < DPLL_PIN_TYPE_MUX ||
>> 		    prop->type > DPLL_PIN_TYPE_MAX)) {
>> 		ret =3D -EINVAL;
>>-		goto err;
>>+		goto pin_free;
>> 	}
>>-	pin->prop =3D prop;
>>+	memcpy(&pin->prop, prop, sizeof(pin->prop));
>>+	if (prop->freq_supported && prop->freq_supported_num) {
>>+		freq_size =3D prop->freq_supported_num *
>>+			    sizeof(*pin->prop.freq_supported);
>>+		pin->prop.freq_supported =3D kmemdup(prop->freq_supported,
>>+						   freq_size, GFP_KERNEL);
>>+		if (!pin->prop.freq_supported) {
>>+			ret =3D -ENOMEM;
>>+			goto pin_free;
>>+		}
>>+	}
>>+	pin->prop.board_label =3D kstrdup(prop->board_label, GFP_KERNEL);
>>+	pin->prop.panel_label =3D kstrdup(prop->panel_label, GFP_KERNEL);
>>+	pin->prop.package_label =3D kstrdup(prop->package_label, GFP_KERNEL);
>
>Care to check the return values? Also don't kstrdup null pointers, does
>not make much sense.
>
>Could you perhaps move the prop dup/free to separate functions?
>

Sure, will do in v3.

Thank you!
Arkadiusz

>
>> 	refcount_set(&pin->refcount, 1);
>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>>@@ -451,8 +465,13 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>module *module,
>> 		goto err;
>> 	return pin;
>> err:
>>+	kfree(pin->prop.package_label);
>>+	kfree(pin->prop.panel_label);
>>+	kfree(pin->prop.board_label);
>>+	kfree(pin->prop.freq_supported);
>> 	xa_destroy(&pin->dpll_refs);
>> 	xa_destroy(&pin->parent_refs);
>>+pin_free:
>> 	kfree(pin);
>> 	return ERR_PTR(ret);
>> }
>>@@ -512,6 +531,10 @@ void dpll_pin_put(struct dpll_pin *pin)
>> 		xa_destroy(&pin->dpll_refs);
>> 		xa_destroy(&pin->parent_refs);
>> 		xa_erase(&dpll_pin_xa, pin->id);
>>+		kfree(pin->prop.board_label);
>>+		kfree(pin->prop.panel_label);
>>+		kfree(pin->prop.package_label);
>>+		kfree(pin->prop.freq_supported);
>> 		kfree(pin);
>> 	}
>> 	mutex_unlock(&dpll_lock);
>>@@ -634,7 +657,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent,
>>struct dpll_pin *pin,
>> 	unsigned long i, stop;
>> 	int ret;
>>
>>-	if (WARN_ON(parent->prop->type !=3D DPLL_PIN_TYPE_MUX))
>>+	if (WARN_ON(parent->prop.type !=3D DPLL_PIN_TYPE_MUX))
>> 		return -EINVAL;
>>
>> 	if (WARN_ON(!ops) ||
>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>index 5585873c5c1b..717f715015c7 100644
>>--- a/drivers/dpll/dpll_core.h
>>+++ b/drivers/dpll/dpll_core.h
>>@@ -44,7 +44,7 @@ struct dpll_device {
>>  * @module:		module of creator
>>  * @dpll_refs:		hold referencees to dplls pin was registered with
>>  * @parent_refs:	hold references to parent pins pin was registered
>>with
>>- * @prop:		pointer to pin properties given by registerer
>>+ * @prop:		pin properties copied from the registerer
>>  * @rclk_dev_name:	holds name of device when pin can recover clock
>>from it
>>  * @refcount:		refcount
>>  **/
>>@@ -55,7 +55,7 @@ struct dpll_pin {
>> 	struct module *module;
>> 	struct xarray dpll_refs;
>> 	struct xarray parent_refs;
>>-	const struct dpll_pin_properties *prop;
>>+	struct dpll_pin_properties prop;
>> 	refcount_t refcount;
>> };
>>
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index b53478374a38..3ce9995013f1 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -278,17 +278,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg, struct
>>dpll_pin *pin,
>> 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq), &freq,
>> 			  DPLL_A_PIN_PAD))
>> 		return -EMSGSIZE;
>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++) {
>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++) {
>> 		nest =3D nla_nest_start(msg, DPLL_A_PIN_FREQUENCY_SUPPORTED);
>> 		if (!nest)
>> 			return -EMSGSIZE;
>>-		freq =3D pin->prop->freq_supported[fs].min;
>>+		freq =3D pin->prop.freq_supported[fs].min;
>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN, sizeof(freq),
>> 				  &freq, DPLL_A_PIN_PAD)) {
>> 			nla_nest_cancel(msg, nest);
>> 			return -EMSGSIZE;
>> 		}
>>-		freq =3D pin->prop->freq_supported[fs].max;
>>+		freq =3D pin->prop.freq_supported[fs].max;
>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX, sizeof(freq),
>> 				  &freq, DPLL_A_PIN_PAD)) {
>> 			nla_nest_cancel(msg, nest);
>>@@ -304,9 +304,9 @@ static bool dpll_pin_is_freq_supported(struct dpll_pi=
n
>>*pin, u32 freq)
>> {
>> 	int fs;
>>
>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++)
>>-		if (freq >=3D pin->prop->freq_supported[fs].min &&
>>-		    freq <=3D pin->prop->freq_supported[fs].max)
>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++)
>>+		if (freq >=3D pin->prop.freq_supported[fs].min &&
>>+		    freq <=3D pin->prop.freq_supported[fs].max)
>> 			return true;
>> 	return false;
>> }
>>@@ -398,7 +398,7 @@ static int
>> dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
>> 		     struct netlink_ext_ack *extack)
>> {
>>-	const struct dpll_pin_properties *prop =3D pin->prop;
>>+	const struct dpll_pin_properties *prop =3D &pin->prop;
>> 	struct dpll_pin_ref *ref;
>> 	int ret;
>>
>>@@ -691,7 +691,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32
>>parent_idx,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -727,7 +727,7 @@ dpll_pin_state_set(struct dpll_device *dpll, struct
>>dpll_pin *pin,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -754,7 +754,7 @@ dpll_pin_prio_set(struct dpll_device *dpll, struct
>>dpll_pin *pin,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -782,7 +782,7 @@ dpll_pin_direction_set(struct dpll_pin *pin, struct
>>dpll_device *dpll,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "direction changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -812,8 +812,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct
>>nlattr *phase_adj_attr,
>> 	int ret;
>>
>> 	phase_adj =3D nla_get_s32(phase_adj_attr);
>>-	if (phase_adj > pin->prop->phase_range.max ||
>>-	    phase_adj < pin->prop->phase_range.min) {
>>+	if (phase_adj > pin->prop.phase_range.max ||
>>+	    phase_adj < pin->prop.phase_range.min) {
>> 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
>> 				    "phase adjust value not supported");
>> 		return -EINVAL;
>>@@ -997,7 +997,7 @@ dpll_pin_find(u64 clock_id, struct nlattr
>>*mod_name_attr,
>> 	unsigned long i;
>>
>> 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
>>-		prop =3D pin->prop;
>>+		prop =3D &pin->prop;
>> 		cid_match =3D clock_id ? pin->clock_id =3D=3D clock_id : true;
>> 		mod_match =3D mod_name_attr && module_name(pin->module) ?
>> 			!nla_strcmp(mod_name_attr,
>>--
>>2.38.1
>>


