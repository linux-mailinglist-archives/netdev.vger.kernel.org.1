Return-Path: <netdev+bounces-50620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E882A7F6552
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6C31F20F29
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FC8405C5;
	Thu, 23 Nov 2023 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SoDE73wG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BEC10CB
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 09:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700760175; x=1732296175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pp04mNWSz5Q0DVRUvLse5+S3XRlyxwZa1z+ZJxw1UZE=;
  b=SoDE73wG8t3BvHTrjg3jCXhLNUwp/X+jWqROJZVBCtjW8SDS4ZGl/p2a
   HgNZNqWsWeOlMaIdRiewD88mvpIO0lo8U9x7UJTW6zC4FqdYpzlox6f2l
   EyPBUvfJAsxNiVK6l0+L4GPMyrguFQX9Zvz2V4oZCFlJX3bHenEMcDwKA
   ASBy8JUy9HsOxD2jFz7uVTD65+jGNh86zeRz1ZwlHx5j6rGXDRVUcLNLV
   34PxTk4FXDTD6IDslqYx65c7nZpClyRJRuzGieBEuOYQ9m3T2Cve+pxrl
   FxgK6VFlblv4RBAIAuLlPI6qArk699U/8ryo6rE1e3FDkIoqKkUjgJISx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="372466144"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="372466144"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 09:22:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1098869932"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="1098869932"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 09:22:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 09:22:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 09:22:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 09:22:53 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 09:22:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8VQe6jzTuFe8N5XnXiPX8EtmsINGtE5L11OCElkn2ljMBxZbdz4/WDv4RDfSX7HB3R488p1ynWhmKdFiCC7trb9ICL9nP12RF3tyPth7ICOILLnE/9XHXXcd0Kj8zfRRqFYPi+tT5t70zwTAoGLb4gLdTFCUY2NdRUXGtVv37c06z/qHUIgkq0usbqS/0TQ5OBOVoIjN8WkynwFQOPBZPeHdrHERTNrzU45R2dibQJqLuYPvhmKl5ocGnOXmi3F/EoTqDXuZkSCu3C/GqXWc/VgR1Lth40dI/7ipmHbhXq8mGxht9UVh7BVDiyUb4WSZP0DcgfMwCnAg9zdYlB3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgbUg3i0AidA7V3PzFXg1dkeh7Qsfoy/vvHabkfz8t0=;
 b=DPBOO8rgH3dwXzpdPxta5/jgWaQFRFdfzOtUtkRGqtLVozs7JWZE0PaeGPfGPfSnhrucR4Y3q4XfvSju8yfec9ddZjuqQiEgLLoyXUc5EXS5fJz26L7Dc5WUZCdpnRKIvxOcBUvmw5fInVzVHpkUMhDKWa+FE9KpyUBjeuLHFr/uPLTFBUpiSsX3gOwPfodC3X6yc+WdmplQcnMZvj60BpYY9khgbJ0wxMU5d/xP41hdWDYP8EzrK9KRFkacwEcfbMvBioz2dAWnDC3R9PBBaFrq6LvZ4stpwGrB0dm9ed6Uj2pPqKqL9mvDtVz7lSqGHXgv2jA5knTVdfOekxC4Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by CH3PR11MB7202.namprd11.prod.outlook.com (2603:10b6:610:142::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 17:22:46 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::1498:c32d:2d2:975c]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::1498:c32d:2d2:975c%6]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 17:22:46 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-next v1 4/4] ice: manage VFs MSI-X using resource
 tracking
Thread-Topic: [PATCH iwl-next v1 4/4] ice: manage VFs MSI-X using resource
 tracking
Thread-Index: AQHZn6NdbWVfUm0zz0i6FrXhqi/DsrCJI/qA
Date: Thu, 23 Nov 2023 17:22:46 +0000
Message-ID: <BL0PR11MB35211950BCAC4646FAB7851B8FB9A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230615123830.155927-1-michal.swiatkowski@linux.intel.com>
 <20230615123830.155927-5-michal.swiatkowski@linux.intel.com>
 <CO1PR11MB5089B50AB69E2EA953E07FEFD65BA@CO1PR11MB5089.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB5089B50AB69E2EA953E07FEFD65BA@CO1PR11MB5089.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|CH3PR11MB7202:EE_
x-ms-office365-filtering-correlation-id: 06da2d4b-cf84-4eff-a9dd-08dbec48cf42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z7XEQdaB+gy7sNZAATmKDHFqvtGyuPksM3ostpOzro2nQ4iTrC53k8gdEC4P9S1ZBpsh9A14C7nViF/Xuh6SNj1TqiqS7WiB6MoNOrInzN6rXNm+zMILOGQA4Anb206MT0RhyZcGYsQJ29zNsC1SACHVySUh118BbMZEIOkmxba1O+herd1lDqZGsOZ/vyaK3uai4rmtJ1e31+94gnP6ENrvZHsB9KVhREi3bDyx6UROC+/8Kx37QUgexmnb4mHIoHDS6tM5T+VTXxa13rTurwNyy3XUY8L/iWM9G3CIRqYt3en1ek+m2HgU+Zaj062+uDlN948dvUyqyX/u0HZwKrJxNMHU+SJ1+DftJHijecCy4Heu5YewnHPSNpZDUkWFdAHSgYwrRvZMNaNrS6n8CLJLTpID4748HqKhum30phSsuFQd3OwiAbtcw7d//6TRFkGrntx3eCFiYM0RmHksFswCvlVDBQwMDdd9HXHn93UuDWP6OL9LunshXMAm6Z5wA89JIUhTV5/QWRi/Haw6EpHmZGmQ9Bb9Fd+aEFYKmynISWk9EpJPIaJnj0GwA2BcAaSfAObQtzU2c7R8DaOU4flcceoeyE7qvLwF87ZgfGh1+AkSvPUIerqxZMJlJk2l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(6506007)(7696005)(478600001)(53546011)(9686003)(71200400001)(8676002)(41300700001)(52536014)(4326008)(26005)(8936002)(5660300002)(2906002)(316002)(64756008)(110136005)(66476007)(66556008)(54906003)(66446008)(76116006)(66946007)(86362001)(33656002)(82960400001)(38100700002)(122000001)(55016003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9gbOjyJJJPLlds1CuAajQUxWFRMjVslyr3D73ikVTxjWtdnkw/r0aGZSvDyN?=
 =?us-ascii?Q?uNAA0oA+85pswHGzb96j3pShx4w2ZjLqzqG16jt23quvorkhMEyxqlgEUnub?=
 =?us-ascii?Q?Me9H8ddeXQlXxfKJ0IBtV4IQyXwq3OrM+R+f8IuqgcbNXa5LLS8+YX0qNVfo?=
 =?us-ascii?Q?+ArDrh2GyvDUNUTGIo/ofrxme+ZN+7F8PfhiMUR0dZxvbbguQZ8712LW7ye6?=
 =?us-ascii?Q?yIpGHIZdEmq3CxPJtq5kAgE94Cu43aeT3KSEiZpfWqsLx6sShJdlUEvaLBNc?=
 =?us-ascii?Q?kvyNoPfEEkohkuIslC1HnzXcdP/1yRixBnpmUWFHtH7TikYnwo4yjmJXMsO4?=
 =?us-ascii?Q?b57AoiMzRYyxJR5q6+gNkL70sP16Ql3Zq52VO9mekMYUAUJMmFARfPidVEeI?=
 =?us-ascii?Q?RxVK2IWGuI0rjhe88a8AO0DyzKfA36F+5ilFifEJNFiPkYqfQdEP4GO/coyj?=
 =?us-ascii?Q?cASsl6ncmyVCmGY6cWg68sr6VpFp0g2Wz097MLGFzGZp7lKMxvpx5qJG4teb?=
 =?us-ascii?Q?SUHvJR+8k0PEMyrdKPcvNSSJM/73BpPfHBmstU+V0OmO3052HIaNRSY99uNp?=
 =?us-ascii?Q?YeJFlho0B2hDsHEX+S6mB/eukiLckKg3uNNPvP1pZAxTOEC8gqL79JCGJt/2?=
 =?us-ascii?Q?DqUnsZet7I5C1+lHhRHQlu07PfWFdMrPseHt3MAEGcrvC7J68pkSO3rVypt2?=
 =?us-ascii?Q?uLVHwon0sBVKx6SSC9hBY2hvrjaBBJNNst4U+t9gvdkKeLqzXgX60Q/P6E0W?=
 =?us-ascii?Q?YR8c0G5HgQonRYBcAn6VUt/AIJThIRVIzQJEvglzIpqrtheSmFr6NqZa2Z9x?=
 =?us-ascii?Q?Ev6Q5SE91mBHsUhuCiKnudRb5ei8PsFgKYj5SsWMTmdNUy7XH32L5miIMUUF?=
 =?us-ascii?Q?V/vs5acq4bmhw1kJcTEPXaYY9nkyO2DvL4o95Pw4j6enXOyWGR8b07enDs8v?=
 =?us-ascii?Q?rpP+jgn/tP318z/Meq3myusn3OhaEPI/8LR+3RCqD0IkTRB0wemqf9CdNHAn?=
 =?us-ascii?Q?3iVnqwAVhEsUpvvVf69JYZ2oySRc7YFZ/b2V0AtWl9dsj5C0K/3Jj40772Hl?=
 =?us-ascii?Q?34SQACmzKMFl3vhES66p3AFQ0wH0DzjnkU4nloF/etia2AbD0kmsmidw8iZ2?=
 =?us-ascii?Q?LQ+0YJy4WQoj9sqXeYhtBUnxvUoxmWUX6kbIis3hg2ybamYywyVYOURrojTd?=
 =?us-ascii?Q?MYzk6DOZc1c/4V9fk8ELqEBKJu4lGsvH1VV92qmiFN8bKT7jl2Rf5X9bN5yY?=
 =?us-ascii?Q?j4KXSUBg4f66yTHMS96InHzNb/2rzE4lWDo5GZu9LKFCZg75Vuh+Y2Nz4bDL?=
 =?us-ascii?Q?mEeKUbrmcKwrBZQ1kjCZSilftICoS8QTxKVSzlMmSGEJM0b8IwYMgDdCn1OM?=
 =?us-ascii?Q?5kzI7t9wbcQpvmT/AJNlGY+rqgT+LVBcWP3DEHsSI8Di12fP1u0/167kBsNC?=
 =?us-ascii?Q?euAVysFzd7fl4HXrakU5xyNsmJ1Pq9/6HhEC+dasrb7OOh9aosKTyoGGHk8H?=
 =?us-ascii?Q?xhkuX+uuIZu3kYXlyIn3Op1fguqtXoMtIh16If71mEYwwc2WJAR4NWBMZxM5?=
 =?us-ascii?Q?ZRRKwIWcx4IjESCazuNhRtiQzQzYUgKm9/H0si9QXXBMAek28NkSBnDMYDEO?=
 =?us-ascii?Q?0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06da2d4b-cf84-4eff-a9dd-08dbec48cf42
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 17:22:46.1870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HdO5+odY/ob1EHJHo6NBC2RRODxlY23zSX2oia3+QfJDnS8rNHvWJYsqe2grS1d2t+6D1hiFNa4pDrTf5breFJISU1MqnAOe5RLip0MS0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7202
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Keller, Jacob E
> Sent: Thursday, June 15, 2023 5:58 PM
> To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; intel-wired-
> lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 4/4] ice: manage VFs MS=
I-X
> using resource tracking
>=20
>=20
>=20
> > -----Original Message-----
> > From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Sent: Thursday, June 15, 2023 5:39 AM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>
> > Subject: [PATCH iwl-next v1 4/4] ice: manage VFs MSI-X using resource
> > tracking
> >
> > Track MSI-X for VFs using bitmap, by setting and clearing bitmap
> > during allocation and freeing.
> >
> > Try to linearize irqs usage for VFs, by freeing them and allocating
> > once again. Do it only for VFs that aren't currently running.
> >
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_sriov.c | 170
> > ++++++++++++++++++---
> >  1 file changed, 151 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> > b/drivers/net/ethernet/intel/ice/ice_sriov.c
> > index e20ef1924fae..78a41163755b 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



