Return-Path: <netdev+bounces-69925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2269A84D102
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856971F22252
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1D17FBD2;
	Wed,  7 Feb 2024 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="id4UA9cN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EDE823DA
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329822; cv=fail; b=IOOqorZA982ndubFxWFTJDz+F9488kuIe3FJlzAHJZgcbKSF4zHsiZ+JNn92/yWqHEmW7VkFSHriT04xdwlGaeCoy63y1NTMsaeSPzYdOOPmyH7AszCuRG1J3KcScfZtVwzQae399pceI6dFT/NKpHHjcIvuLTGot6YZMke0/X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329822; c=relaxed/simple;
	bh=IiA7hSLTuqpT/j7cDbFcCsHjljaZ7GRdPDmatYlSj1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GK5KpguJglESbhAGZzKkpE4SyS1sn7fDFctu6c4AhbLQOmAOomzkuiDZ6cz/gYtD5Nm6FpJp/+dDoxyF/eboszHM530ktqaEOpHv0B2+eIoDtV6Liuds2oR57Qp6Ws4btpbOjwY4jwv2MpHqfXAb1PL3Ya8THpZRliqpP0zxaP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=id4UA9cN; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707329820; x=1738865820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IiA7hSLTuqpT/j7cDbFcCsHjljaZ7GRdPDmatYlSj1I=;
  b=id4UA9cNAgOflwSju1E6lbCN2KdA6UPVbsW6VUveKEk02NVMg9WMij8w
   a5EUZh5jN0BQe65XyMBbU9CU3tEvUor5DZojrIKn7yJNrkJ1D/HLiW55D
   doMQVUzL7R/VrPlHiom5aJbrOyJsrD4N2NmaGG4M7kp5nFMwEIzP8FyPJ
   rxR1W/wBh3ZTqcVFx/++PtgEYUyW8Yk9hKRdI1hrOGmkXcXOT1uLFa8kL
   fVfW+0Y80rosSh1gXs9NJ+cr76t1pg42FskIG0BqUk6AEb4QnUFRwvfT0
   ibzutLF0TwqPw/Af0am1T8QaWLwWVcgXioi2yFu4oS/PrAwrUrIuRisBe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="26492801"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="26492801"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 10:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="824575505"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="824575505"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 10:16:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 10:16:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 10:16:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 10:16:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYXpFo/8idQNflcShuJuZgeUpbw5Z/ZRvhYmK/wbpPWIBvZnK6r6Yl+HJqLYrjk7/YxK0ilFmhBp2o4mvc7wTFyBzuWvUhmoCs/BQgioxk2PBTozcg3Qpg77xBtFpKyKl8mOmoNJ4rEekWj8xcvvMkHDD/a4LyFWMvH0K0L0DAadbbS/q9az9inl/oSbboVZZWy/ncjhsJ8SwVbaLfVrMlXzFH+RxBlwmCmo4Gx5vthouooPAAH2wJT5UMtIdf49dhEAEomibcpZM6JPPe91nSDpb0cfUIW84v/EKZQ8IpC56PhCA3Awg3xorvUGQ17tWr5GvwtZM0UEm8EV/beueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6dV9Sv9agTOCQyAIpRd5fZUM1l8dKMcv9CNHioxWh0=;
 b=DRKf3c4bzHcxr10IUtcPuFX5RDKUGxlQULpwwHWAgi6U4aV+L282DxV6ozOZlhD8/PcX5CcZQmMJUICvp6D/BlMglNwHFOKcdGHDlI+UlYj/NW8ptLcUtgBZVP3/l3K9GYrdU5CSRuGUnNYbu5dleWKWhWCelDeeWkBmzFt4a5sIrm0i0FBHUnN24+vnwJ6HwXxIpUKE+Z7f4YU19M0CfpOC3B7V/r0PfMaL54J5LoMZwupXTk5fNEVjQxogwCF/1S755Nc3gJhsbw4fAD/QOUsBlyaOsVG6uMPVLs2OhOpHlfdLki7sXyuF12OWXKpeZam6Ri1XdwDsbfKy9b0eHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MW4PR11MB7101.namprd11.prod.outlook.com (2603:10b6:303:219::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Wed, 7 Feb 2024 18:16:56 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::69dd:6b79:a18b:3509]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::69dd:6b79:a18b:3509%6]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 18:16:56 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [patch net-next] dpll: check that pin is registered in
 __dpll_pin_unregister()
Thread-Topic: [patch net-next] dpll: check that pin is registered in
 __dpll_pin_unregister()
Thread-Index: AQHaWND9Q3NhQdxilEOGPQ771WvDqrD/MfHQ
Date: Wed, 7 Feb 2024 18:16:56 +0000
Message-ID: <DM6PR11MB4657A65CFE8A638A933798589B452@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240206074853.345744-1-jiri@resnulli.us>
In-Reply-To: <20240206074853.345744-1-jiri@resnulli.us>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MW4PR11MB7101:EE_
x-ms-office365-filtering-correlation-id: e2269653-addb-41c0-b17d-08dc2808f7ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkvYJE7lUFe9LrSD/qnIEZeYiGEQGN8LDK1MvuEsMdll4TFp6UYUya69Nr1coMo5tMEcr87yyKskZQCB95/OyjN4/gq9JG/YtE3V3UBi6xzgTekKegNKDvU/kWUl0IfWVB+Uwb5aXoY1vl0HuJexySesCPu0q6vkL7MIl6AM3ZcHdq5R15FiFGxmLRTd0j4TOn9hbN2pgJyGGuRJwj7+Z+zxLkKSICF7YnqtOcBCMAya6Z7d0ZaGmQjrm/yukXcX77ekYmh+ysKmBt+CqskWVy0CaoSiFgXDZo2m2btV4TEUsFKytpv46MjtCEwKo3e6UhjrefbcMYZTBWbK4dWiNYk0QObSpLGg0kV+C1XQF6V0AX1HsN9IOP3nwdQ7H1CbUb4RMmF72y1nq3w9kRdMwtlfeQ7Q/G0CTUVlcstauqMfzcqHQmbgLx/9FU3G5OZrv5csUp40e7EOZtbNQU9fNEQkSz7C05u73+OEbfizPLG+CHQat1Y8D1z2JSMiVs7KKuI2y++aac5tNdDOTnjVG7Y8Ug9SeekZi4yoeaT01U3ZXV6k+HSF7upKXf+iqbOWJLlUnFAiFbNTJQruyE1NoABXMf2YcguMPmEThqx6OH2mXSq73TuSl9nKtgMmL6+I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(55016003)(122000001)(33656002)(82960400001)(38100700002)(66946007)(64756008)(110136005)(66556008)(38070700009)(66446008)(66476007)(76116006)(41300700001)(316002)(86362001)(71200400001)(2906002)(52536014)(8676002)(8936002)(26005)(4326008)(7696005)(6506007)(5660300002)(478600001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Rz3FAybSntcLHCc94ixKguQfwavi4IS332ABNiV2LDzgTMoVQr6cC8skEQY?=
 =?us-ascii?Q?st64M6jYM1ZWriHg9jUnANC6YP3Nftwnl/6gMM4N5cVLTRKIs72w0RBYfcyC?=
 =?us-ascii?Q?ghbSGCsHeYr2hkUVTEEdNHxi8EOjBk/Q17RtzbCT3p3Fl2WnbqYNF7gWuBdP?=
 =?us-ascii?Q?NLlDODqXqD5nWvhO/xbs5xA4/cJ5wuPGOX3KnJbJH5Sn+8DLzxIpRVr+Ty6c?=
 =?us-ascii?Q?TS4tMnY/1nA8zysvJy6Ze0kIQZhWoqp71iVX/yDgKwDwCzxh76SPDHDc+OpT?=
 =?us-ascii?Q?nNCK5aRru/BQ8oKQ7P6pLp2NXIUtDo+KJJaBZ8Sz4edJ1xkUEpYLFsVa1P2O?=
 =?us-ascii?Q?+D1BiJCWpLzlnWOzcPjwAr38dbG+5hyodPi0xRkjHEdvD9vmIZtMm4Jrjgv3?=
 =?us-ascii?Q?JxQlmHWDPmu4rHoIP6xW0i9QMBidGI9DwlOSTaDnaBmTOk8RMaMrb4Zg9P20?=
 =?us-ascii?Q?CflKybv0hQx2pewBvEUteCvKkNNtJyD3EgLBuZGLFTgozVYS7ycgslu7CMTT?=
 =?us-ascii?Q?yzOQ6oosCsUt1lJZlqLMytDonwgbwXkhWizzR7Tj2PgSwj2kOuXd1LbXtNZZ?=
 =?us-ascii?Q?xEeX4QiNgqoXHitEKUdlthAH15tZSDA5gDIBA0G6miJJTq+Y66bV6X4dqymO?=
 =?us-ascii?Q?zyZb/9GUwPe9fJ6XwcOynRRst7/H239oXkye9WSq/zB87GCFXn+Rrg8KuJC1?=
 =?us-ascii?Q?UijbELB49RAEt7eI2FHZHN7Y7/cF9wLkaS6ZL/am73xD2jclsax61IVxWiUh?=
 =?us-ascii?Q?D2cimlEqoeCfpCpTjegyIg0O5RsTMn996utcbvloh1lVtHyC1vLB0pljVcYl?=
 =?us-ascii?Q?nuk0rwyPXx/asrAcGD9LexUk7UM2XZgAgeyemTetrPeWQNY7WE0FEH031TZb?=
 =?us-ascii?Q?aEvHlqeSfSuz0dQY1Pm3lN+zcO5VvhJy5f+2tlKOTsW/IbIAzN+Gp1banEFo?=
 =?us-ascii?Q?+cDrHstuD1QLf4gZvpS6CmJWVfbOnggaVb6wsNpZVo3lT4p8zgmijLKca2Qq?=
 =?us-ascii?Q?sVkJOz4uWCL+CBkEzInPGwOVutXnvzA7nuaC0JbvgeGkvJUn+34/xyyrrOni?=
 =?us-ascii?Q?53Cf5itkVUbv5Nkong5g9tpcJyXK/JClXsTPK748bqtz0Xz1siqKhN09119P?=
 =?us-ascii?Q?ReeCAe4hytbgQvzJWnmtPMstRadh1FVEcJt0v+MTdUQYM1kN5ZsQeS+dk5L0?=
 =?us-ascii?Q?JAit0V8i4cSM3KgY9TRtazgnx4q4FIfQSahQ8T6Zlp3xVnvFy2T/WP9CoYp0?=
 =?us-ascii?Q?HdwX2CnYskCTjHSzIGOUOAb7TIRP9N1nV4B2HtkCJhwCLxdWqQtiPDvBudao?=
 =?us-ascii?Q?Ryr/cagP+twc5WG8ixuRHTAWsEu3Xmi0+APFVvQtZkOpe+7rsxwbSN3Ip1LH?=
 =?us-ascii?Q?jGCoav6j7qVOdBNr9Nfvc8P1y+0PVv6k7rDKq1ulEOHy0WIK0eYVe1AJO6X+?=
 =?us-ascii?Q?j6zeWJT2WPReucfMfkfiOUdTNHKDIHjcYCZKDQoAjogCOR2LtdZe0ZAU1hjw?=
 =?us-ascii?Q?atPVAjk23ZYOJsM0PsG4ww7/GBmJvIIMQ8b9hx50raYcj4mCSYZWV9C91nV7?=
 =?us-ascii?Q?jgQkUTEWOGqOVdOgnH8OlvAqZ5OUCpwOsfIVOneCtj+ad/i5Vga6WNCx7zNv?=
 =?us-ascii?Q?oA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2269653-addb-41c0-b17d-08dc2808f7ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 18:16:56.3912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0ykHTt57C3CyzqH6DxxnvcZSCCUHd7G8zAQJQUUOKyE8U3gPj/Z2O9fakIJrmaeHIsOg0mhdHTBAD+8P8aoVrI1NPtjBi4ezTSKnFMPfKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7101
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Tuesday, February 6, 2024 8:49 AM
>
>From: Jiri Pirko <jiri@nvidia.com>
>
>Similar to what is done in dpll_device_unregister(), add assertion to
>__dpll_pin_unregister() to make sure driver does not try to unregister
>non-registered pin.
>
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>---
> drivers/dpll/dpll_core.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 61e5c607a72f..93c1bb7a6ef7 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -29,6 +29,8 @@ static u32 dpll_pin_xa_id;
> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>+#define ASSERT_DPLL_PIN_REGISTERED(p) \
>+	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
>
> struct dpll_device_registration {
> 	struct list_head list;
>@@ -631,6 +633,7 @@ static void
> __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
> 		      const struct dpll_pin_ops *ops, void *priv)
> {
>+	ASSERT_DPLL_PIN_REGISTERED(pin);
> 	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv);
> 	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv);
> 	if (xa_empty(&pin->dpll_refs))
>--
>2.43.0

LGTM, Thank you!

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>


