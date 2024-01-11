Return-Path: <netdev+bounces-62995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755D82AA9E
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6159B1F23E20
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBEC101EE;
	Thu, 11 Jan 2024 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gW5voJ+R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F393101DA
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704964596; x=1736500596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ItIMpH4OWOW0ezag5izyiJbis3vSxIAChpy857fIVJE=;
  b=gW5voJ+RMz8smvGIpemHZcBpLp9O+ZkHHedqUrZigZfyYCkibfzZPtrS
   oUJo3we5gXPMTLhZnwWIX9n8I/C9P9Yi5qZpWv5mdfcKwwE8hPQMagpdI
   bB1M0LyNQKM8iAlf1Gus/+LDm+puqNLVQraCu8im9jPF92yDCZHdziuzr
   WTqvGU85P+AIzuez0aJj0EbXjeuaUv0m92fuKnalYKJalwjtaHOB3vYIm
   kFfW9U+9R8VRqj613MIpE6CW5hsOJcpbqwnSAl+ufrDpho1CnHddZlKSJ
   Zu8qC51aHHJdDUx7sKhnIJCbRqE1CvVxj5tLPcnFf0Q4qJGOpUdzr5T2Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389229425"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="389229425"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:16:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113772656"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="1113772656"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 01:16:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 01:16:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 01:16:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 01:16:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 01:16:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvB9HPda0UFRtf21RMBxwqN0zqoRcLEQ7AE6K0JWh/bK6SpXVb8dl93kdX5/mr5XrIJ7reWxtv+MXMR/Xs+23qRRgb7OoeNdVgbbhl21HDqyYV5nFkmhDxtX0loL6VVnbMgu8XgESKWVk+FYiNncRLREYxWhX24jSeoh5t0KkANYF9+fnkTClv5CQ0TSlFZOYr38LwC1Pf9FuQv+UjVhdn6Khskw2pGS5QfskS2RZiT5fyarYscT5r4NqSWKZ+CEvlf7af0mhmRBGjre6D6jc+vvh+9sSh81ePZBhTeSXH8y3+awIqM34nzT5sv77u6sRJJHT+r89Pa+0WmiRszd+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjaLPDXaz9qTkvGUMGwXjaYZnCgLyE/5/xFGRwfXtVI=;
 b=kzssuWiiQCFfVq7122uO1Fr13B2nlSKUPaDJYm102i3DAAyXrkG05D9WMOV0i51xIQEALW3H86nYeGy05gLs9PkuaMK+haJheCmvYA2hkhMxIDCFDptQuMhsJ1jObs/vFVbgUGYF9/Zhk+HoLtSnwv+Dm6yGMJcqJOdnEzT2K2n44B/shjeC5qzbsj4sDHG4X5RrkwSVHC2IUcc3xHCLDERNIU/a8bYEjtkcDz/XOp9sDaYMHgLlA1n079Chn5IGKBIgYEa7LmNmv8zoAYrs0N8hoCR0Nf8e/0UyYVNUK3JrKOVa4NLc8q7IX8CEf5OXU/UI19yiNcYnwBAvPt5Jxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Thu, 11 Jan 2024 09:16:33 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 09:16:33 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"michal.michalik@intel.com" <michal.michalik@intel.com>, "Olech, Milena"
	<milena.olech@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "Glaza, Jan" <jan.glaza@intel.com>
Subject: RE: [PATCH net v2 4/4] dpll: hide "zombie" pins for userspace
Thread-Topic: [PATCH net v2 4/4] dpll: hide "zombie" pins for userspace
Thread-Index: AQHaPv9PdEbVjXsF8EmuApoVd3S7HbDJwWGAgAqcf8A=
Date: Thu, 11 Jan 2024 09:16:33 +0000
Message-ID: <DM6PR11MB4657AE584A2DDF34CD527E1F9B682@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240104111132.42730-1-arkadiusz.kubalewski@intel.com>
 <20240104111132.42730-5-arkadiusz.kubalewski@intel.com>
 <ZZbJndeZ09-DeztP@nanopsycho>
In-Reply-To: <ZZbJndeZ09-DeztP@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DS0PR11MB8081:EE_
x-ms-office365-filtering-correlation-id: b5deb738-5a50-45ce-71a9-08dc12860104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IWM6tNddb18rVJTSf4sj2/dU3G/NzrYqnyuwKDFKzrGdCGsifcracRtHn/8ZEx/ugWCHGlNWuSPORIi072QDhnvQReCyRV2Uu+vGNOc1JkU1AhDD+6fbLzagFWuIxJN4JxnjT12q5TE3a1GqJHyeV/IASZV7pq6JzIlJmFNt+LJ2gxm0j0oKqegP+S1fOXCo+G+QJeWysfZxz15pk/uknmRvlnyo/rPBO3JIEY9dETn794XmaFYOnBaEhDHNzA9b3g95rtS1EpbhEfdet1pPwjK+mnoVRCCQTvW8nzBZ1NNm4EyDIos9kh7PGDSWPb30FYukZYFKnxWeMrkSteZl60tJ7BnNubn1vvz4SlMeXslExUUT3IWET3ZlJODlTv2pcf+EXCMpMUT1XM8JvfHQIQo7SbnVKCxgH4nStaFk8Qcm0vY9dwWilE5lMsn/fP5MwUatqlHPHysxHnuias3UGUYT/xpwNaJRyl8aN207wVI5cKMXDSUDYc7Na+EyxAkN453/Loi3+27stlmmeJaKW/+EQKOs99px899ddAiYWg2+3F8y8iGUrILErPTDyAsWGLel3TSUuPAGXw031upamgB6E9hsuJWGZFYCjcsSIviuYEVANRbue32iD2Lco7g0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4744005)(478600001)(5660300002)(107886003)(82960400001)(71200400001)(86362001)(7696005)(6506007)(8676002)(9686003)(66556008)(66946007)(316002)(66476007)(41300700001)(8936002)(76116006)(33656002)(66446008)(64756008)(6916009)(54906003)(38100700002)(26005)(122000001)(52536014)(38070700009)(4326008)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IpNaxEreCmyb3/qkEQ1zDsBS7GskLzHFPwg4SlX6NZ1vc58dh3qobehPxr8K?=
 =?us-ascii?Q?mfet+0pV8rBrKWA9/kBYDvew5H+gbayLDGhiVib8ABn6bR2qozEDgP+bq1qS?=
 =?us-ascii?Q?qcLScRTmsXti+Lvc2UUA9MiqXGIb7ROa35XA+ER4bBjy5qFsQSSmiRFMig2I?=
 =?us-ascii?Q?5ul86t25eqsGGGSb/GZGvnlwUZvxuB1oTKZh+B/FfPRUpRM4N9gNrUrbAkfG?=
 =?us-ascii?Q?nIxl34pYxmOB5H3Uu80WuEczKtOKezYwJe/qlLwGSnCycBq4/+CpdTno5wVH?=
 =?us-ascii?Q?Be2rz3lsGD+3Tl+FPUmHpxIq2rjCGnYimQ+xJXxoRVop+adaUrF3MEL9+1mu?=
 =?us-ascii?Q?D9icnn66BIe2rclREJeDpZdR1f5hvWIVeqpkSPyKIIA15JxIxh8SY6bYWpos?=
 =?us-ascii?Q?s6Geo8o98JDbqGTyRWtbkzwYfPCJ4lnMaIicJMhYv3YjQLegxvSHFA+hf9K2?=
 =?us-ascii?Q?S+jKUCYgDs1U8sv7useTASAkn+ubcLQDPbdepby2OOK0R0NWiHEEwDOfN0eb?=
 =?us-ascii?Q?eGBmLTYOL4bvHjDEuF0VYK9fh3K+ZHkF6oqJ3+9dXR3mWncm1gF3IJY47xjS?=
 =?us-ascii?Q?MVdrlR7GHFJyK99tFOsJ8mx88vxXHlNJwWXRT0KSZbRJx9t0Q1TDkCJ3Gf4R?=
 =?us-ascii?Q?6Ie9QHXtpzHb9sNTffaBkcnviX95/IxagAJrB37g0NhYVLK/7Kce8UvUiayp?=
 =?us-ascii?Q?OLFpuSL5mGdUsX7WZANJakE8GDLEg7TBe6EWuBz/M7p8gPxQgsRjPxoCpAGM?=
 =?us-ascii?Q?vyGY8rqoePdNwhiQMrSKSSD4RqbBBaCzfUJAiyPzvp8q+xq8UwOHfwyFK4XT?=
 =?us-ascii?Q?e4bk0gkUPVh2/ax/ajzhJfV13si09L93Gb6Oy1l2Eyv6gU1vunnOXlpXOSMY?=
 =?us-ascii?Q?rC2GgkSk4kULoDr9c6rqvtObYL2PKTgVgzIGugZPrx8ZkdpzqLRyxtNROZO/?=
 =?us-ascii?Q?XwaNOrVZpqvW2Yxone/1UR0TXqWCvsWi9Bfbd0/wFPKVBc5jho1GhUV86fXz?=
 =?us-ascii?Q?r3/53S3x7Z1FI0M4mChkmvOb6i3aoDM1u3vcrtVd5Al1gMF2DGtg5qqhv7Xc?=
 =?us-ascii?Q?Je+jLj2SpP0NpTsY3QXJYzCRPlkgKlF0jLE5VlREcCXVOOwxf7+1Jx6ZqCBN?=
 =?us-ascii?Q?E5tCdIw6+OANeW9YD2TAYT8mkq5P7JJqOHdQHJdT/KsHI5DgP5xt70L2hrvA?=
 =?us-ascii?Q?JwbtbOsf5WDrqJJFJqst3HF4C95TUwYdQTUEr1OgblA4k3WMFMMq87fupmHI?=
 =?us-ascii?Q?59dKeJNw2WnvU8gOyJY9zktgwxaenQ0D9zK19jWQZ2KXFn/Xa3k0nAR3l4KS?=
 =?us-ascii?Q?LogBBrE3j811xSkvaI8Njf2XAK77Bo7TTy3bIDYU45P5ARMR5XJiDPwhdYn6?=
 =?us-ascii?Q?4o9cJ/meaDJnKDGX5QfB0nYW4favng1WwdlgE6VXQbPMzWU7rFoOO1U7ZvvE?=
 =?us-ascii?Q?4uLbg1vWDL72lOkP3C2ALA8CdxUbTEplhTnuObFBO960eVFX29GbkURSKAqP?=
 =?us-ascii?Q?btmrHzWYOJ3V+4ROZXXIioMaSQ0zymv25odrEUThSjqC7mdV5KJS0Jp9DgWE?=
 =?us-ascii?Q?wT6i00qcQzdjSqd+2suIN6CijhRruyTF0mQ/zrED5wTdtqlK15dnHYVGPukw?=
 =?us-ascii?Q?Gg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b5deb738-5a50-45ce-71a9-08dc12860104
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 09:16:33.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsbT67UcQZnjBY3gTLVnUgYxecyA0XV8fvCafpXbQJCnPYgkBdRY+xQvODsjhzc5ZjPdT1bQ3atbi1BC+RseAr+ORB7rWVNEZb/48k3SZ7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, January 4, 2024 4:07 PM
>
>Thu, Jan 04, 2024 at 12:11:32PM CET, arkadiusz.kubalewski@intel.com wrote:
>
>[...]
>
>
>>@@ -1179,6 +1195,10 @@ int dpll_nl_pin_set_doit(struct sk_buff *skb,
>struct genl_info *info)
>
>
>What about dpll_nl_pin_get_doit(), dpll_nl_pin_id_get_doit()?
>
>I think it would be better to move the check to:
>dpll_pin_pre_doit()
>

Yes, makes sense, will move it to dpll_pin_pre_doit().
Then won't be needed in dpll_nl_pin_get_doit() and
dpll_nl_pin_set_doit().

Plus, will add check in dpll_nl_pin_id_get_doit().


Thank you!
Arkadiusz

>
>> {
>> 	struct dpll_pin *pin =3D info->user_ptr[0];
>>
>>+	if (!xa_empty(&pin->parent_refs) &&
>>+	    !dpll_pin_parents_registered(pin))
>>+		return -ENODEV;
>>+
>> 	return dpll_pin_set_from_nlattr(pin, info);
>> }
>>
>>--
>>2.38.1
>>


