Return-Path: <netdev+bounces-70326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FEB84E606
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7638228DF7D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E432823CF;
	Thu,  8 Feb 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acX6ZUfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35EE823B8
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411874; cv=fail; b=GA1PCMGI2xclVs71nOpON6ljfurutngx9d6QYB5ps3YjtM45HsnI5sxGH2hnYBvriqpeXewC9FNuP5xqDPOp9Jtmnc+H3FUoTQoMbID/LDFV8GdV8HNHPRBZMolqoicu6sjKTPmvS/rKxypoyBEZIsokjSOqiK/x1t9c/H2w/aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411874; c=relaxed/simple;
	bh=Uq3rReFc33n5N9aXStsDDplz3OcdLB70fG/cAyovBqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MmUdj7sZR4ULhsJIWbMcq5EAuuOmTYv3zIk6DhVHMRdi4o0tRXpOProKGX5k101ri1UcffRcuss/0v44aE+8MRmfoFL57+YMAyp/JdPqTeGd62RJDs0MNmsNCVK42qEUjAx8AWdVKPDhWT0dFhsvIY9UcKyjfCZwUlZXCRF4ndo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acX6ZUfZ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411872; x=1738947872;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uq3rReFc33n5N9aXStsDDplz3OcdLB70fG/cAyovBqY=;
  b=acX6ZUfZqIt1dZKxtgYfw995/LhR0wfyh2lA8iAzkOzIkY697U1bLG6W
   l90BNneUvTOUJtWOAN0mUCsXW/ALt3u54UWhjPMzkKtCB4BbRmNuQDPE3
   d1J0a3vLUFUY4qh0t1Bmao9NJbjdIzWS1hIAbdAsI9y8kvHAChaIJlBV7
   jJEy5AWmB7RHJdUwkUvbZLOEFrNzgpJHMmcZcQfLEs1m1U1n059YYqU3K
   Bs+VOxFVeffMNhBpqrcK2i45nyNWbGs2q+MN7mBlJsz8AzphEmwAkyeal
   2cXHLB2LNa+IY4boxwGy8mdSxaQjGY3MuUUpz5wfBO9QC7muxmhzADvnb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1560612"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1560612"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:03:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934188028"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934188028"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 09:03:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 09:03:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 09:03:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 09:03:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 09:03:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwxV36zKBfHtnZwIzPdWObaKoVCYobqD0XCBcb/b0ziruAELVGucE2rKOov9ULSstc1ynAKxESoWVb+qLUib/hVZG2FCW0DQOVviWOYx9Vrt2CAhMWF3H8GY80KZI2I9NvE8pyqZR2dBTzhtKRxGTNlsqiygBh8AO0YNB7s3hQHWolPKtOEfJctq8yInmaGeQV2eCk/HLgpG2hQP+7J2KMZ7jITubX09N4e2kGcjLblvBtdoC2+L1HB3cQsWGvhNJg37dD5vJa9oTCR0bwm0vBLmXwM1XODg0FaV5+iH8EcQU0D9oGJpdeDIbgIoNKKGtSxMysKJKoR6KP5d5X2/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYmQoGEjfHGhzkBWqS15CBSrirSAeepvUO8j+zaPwb4=;
 b=kT0FUxNE/86mL9+nmathlp6hbtr6okwdP/xm6HpOI2C8zludJg2XxjwhsEc0M+Fn1oPIkwzXDWisLAzJUix1Yp4qte+PhW5hZcUyKY+6BR2ayW+peYR51CGYM4DOzk9HvxfV5kU2UIS0Dg+us6XwTVOwJzObItX7fG92AHpAEKkd8BblLEYSo+P2SNF92/KYSjBtDvg377UN83iASSjfd5zRtUMflvXlKvqrnLu4iC0cxVKpv9r5IXVUqNB9KfDPQMRGWKzEEJcghzM5qaBSkGdCdr5qWNBB9fod+PmU/bCWajeDGKmKsTWY+lmHEZffNq6xBK8pdyzaf1PPuK+BEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 17:03:53 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 17:03:53 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"bcreeley@amd.com" <bcreeley@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Stillwell Jr, Paul M"
	<paul.m.stillwell.jr@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "jiri@resnulli.us" <jiri@resnulli.us>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 1/2] ice: Remove and readd
 netdev during devlink reload
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 1/2] ice: Remove and readd
 netdev during devlink reload
Thread-Index: AQHaWDUrR1JBePm1cU+MgzOwA/V3KbEAsI9Q
Date: Thu, 8 Feb 2024 17:03:53 +0000
Message-ID: <CYYPR11MB84290FB36866D0AB7C7C2A6FBD442@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240205130357.106665-1-wojciech.drewek@intel.com>
 <20240205130357.106665-2-wojciech.drewek@intel.com>
In-Reply-To: <20240205130357.106665-2-wojciech.drewek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|MW3PR11MB4683:EE_
x-ms-office365-filtering-correlation-id: a7ebe24c-2072-4fd5-dfbc-08dc28c7edb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hLtyjTXfTqowzLGHmQRCZUr+qXg4UYZMSpTD1yAPnK46MY1OX6EsRZKKy5v8dVKLSkJF4aujubVzFDDIG+akHZnsMWBIqW4GnbTHkMkj/F212yD02Zb2eUyE6NNRW2dgQaUsPTOtuoDJorrdjXlCgL9hlPpxNwvgNHoj/9dd2NkWIzO5iTUTm06sA1o3lSLRfmfdQ2dHXbuYFi7G5mkHQ5yjIFDy8xfeRQ7KAJCW2OPPr+ySQ/dmNBtwueZ9DbvlXBDE4roFA1ulYvtw/48txS7rAJ8N1uBt/xHhsj4zwcurUF0XzQufxpybKGvSQXvEweSCCCbTuwTwP9p7XDK2+kncJDfrJ+UenrCFagntU59tOASA7DrTdfc4SH4kyxKC8TJ5evpW7Ab0YKOk6GQrA1UDx/gV5uahgP+JRmL/DTfmWIoe0lR4XaRj/ERu+JwWC3UeiUV9jAsF32Gvp+7GnzFSRmW6H1IbEQhAXLEjI2T22tW3rr8Kmsf6CCWZv6n9xx4mSCP8EZ4qiEJWWk9XEDBIPynPkXcOExvnM+1S4+HyxvbRFIsJkC1kXOtnlA0WQb1VAcEFcKxMIjp11gJnWUYbp9YRTbGs7IAdAw+jcG/i9Hb7fKcRWQ4P3jmTCka
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38070700009)(55016003)(41300700001)(52536014)(66556008)(4326008)(54906003)(66446008)(76116006)(66946007)(110136005)(64756008)(316002)(66476007)(5660300002)(8676002)(8936002)(478600001)(82960400001)(86362001)(33656002)(38100700002)(2906002)(83380400001)(6506007)(7696005)(71200400001)(53546011)(26005)(122000001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mj+X1hvU0AIOv6XCCx8d8iBjI5B4HheoPjDpG4o2vfQcm6tDZGsbkXpnSxqr?=
 =?us-ascii?Q?WhR3hmznrHFFZTSiWVBQDxdLzFltjgWkZhhwWNiaESEF8k8XlXvyXhc+W8pm?=
 =?us-ascii?Q?lH1NLnWIwBLqZ+aY39whRJtpxM5SccfTcodG8VZFySL2mJd43BQdBLVTDmtg?=
 =?us-ascii?Q?4faobPkmcc+msiP1sajK/4/+qKhHAHVFvmjszV7XTGKzi4FvxIw/jNgCjaBv?=
 =?us-ascii?Q?aznC90rxs9U53JQ8UhkHVIfCkKRGC6ScxRhMqnLlFHPAZ/rDB6lQgJa0aMXA?=
 =?us-ascii?Q?knV12WBupT16p/gVN8xIH1EKu+0Krm1c7GIN+aNcUBMkyPx0DJvNJDyzsTWV?=
 =?us-ascii?Q?VABIF7G0NjOMyra3L490fpCbWbBc2/0FSFnuQlQmhVlG4iR8S9I0ons7nqZe?=
 =?us-ascii?Q?3CW0ZXP13xR1mat759ZeVd/NpYm/lUix+winn5NqxN0s3v4V49nhufNQHRFk?=
 =?us-ascii?Q?R1Ilz2X31DyoeCs/1Kh/Hh4f+Cc8QAG2yjhUj2x/63trIjEoAvqWAj9DuQd9?=
 =?us-ascii?Q?dnX+V92wt5wtFlyyW9kEbeHx/8G9rseOmvoAsr5f6L3aT0OLXr5Ausr2Rkl6?=
 =?us-ascii?Q?dvXbjPs2t+cr30P2EXobBj0cpJSowXbMQhGC//kD4rU981tEXrrOLKk2k/S4?=
 =?us-ascii?Q?VGyjpkIWOKQb8ujAFQ2xam2qZCakVuBVZue1XPZ5qKtDwJR9mifRcybfZCIA?=
 =?us-ascii?Q?IWi30P9nLuA4iFQ7dHs6LbjEjGjiLIMS8eQm7IlwoCQyqB7FYe/nUSUsRH9e?=
 =?us-ascii?Q?/KyWPagwGSbKn8tKgRfmSHCXX3umHBQPtzmH7a3tnWV2s0lEXD90DOpXPR86?=
 =?us-ascii?Q?blvPv50Bztfz68bjPLDJNow15TRAx298jzgjqma5UwuFziTzQEtoEK5fL0oA?=
 =?us-ascii?Q?jLMd7AdgL15Cj5zasfFThEGxjpqgDAkiOlnqQ5RZEwPvZns64XfrBM4da0eA?=
 =?us-ascii?Q?B/PyNfuNtfbf73KC6nI8e/2YWIBu7y/7gRrmi5XeLDoXjhvXv9k0kSngbYnV?=
 =?us-ascii?Q?xXpzJBHE3gXqWd2KqIaogooLAsJM6WfhLezzp27SkknAcfT9zUUTf/YmrnpU?=
 =?us-ascii?Q?MyCcSJIo9nFURZ5u46WTTMeFBbp3+EHx5CObCNsB9+j4hZ8JGqWgVA6MrLjh?=
 =?us-ascii?Q?9g2ETdths6cvwkGTzG+r3D7Sk8pw57irJ0ZrllYWzWQ1uhadbke8qg6T6jL3?=
 =?us-ascii?Q?uOlK0dTcVJrWjHMyLuV6HnihHXIZMJ25FjmD2C2+7SrFE7A4AYk0xELbxv2c?=
 =?us-ascii?Q?yyOp36g773DyPEmU08NKEjQL2qcLV04mhvqNVtZJ0kC3VhklegPcTuD99ww1?=
 =?us-ascii?Q?9TDFJx8eGhnWxvaDbMONrfM5yQqwifveI+R4d8TcfMhSBeHnF17UlR7h9mxs?=
 =?us-ascii?Q?zEG1mPES4OJHcoPQ6Vqz1IwTGvrSulGRemNrmTzN8XWqt0ABJX2mOXvlZ07+?=
 =?us-ascii?Q?fDI7si1ndEl3MaQBFBQfW0H2sFUlyBKvIGccFyTYpNF6NE7xn5y9GVGyt8/O?=
 =?us-ascii?Q?xFevBT4pjIQ+3PfSf8qj7MWF6ClgGrMb8W1LpymQnrjZHXjh1xejg/Eg2wc7?=
 =?us-ascii?Q?Nais5DSSywNcgPyhDWo7cbH26CIijZzWZBCdwkIfNHcbQJxT7rcSrH9xt1cP?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ebe24c-2072-4fd5-dfbc-08dc28c7edb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 17:03:53.1105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZqISH/j/fFSk1Wosyq6DiXuYwSaqI3GqzCpXOvNws/Qv1mck8mMrHgDnZenscoOuR53nIBvfrGjB/i1uApcfzLmbphnKrp+ruAlFXViwo+UoXwgLT0Ts4Ra1Vu1uvDo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of W=
ojciech Drewek
> Sent: Monday, February 5, 2024 6:34 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: vadim.fedorenko@linux.dev; bcreeley@amd.com; netdev@vger.kernel.org; =
Stillwell Jr, Paul M <paul.m.stillwell.jr@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; jiri@resnulli.us
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 1/2] ice: Remove and readd =
netdev during devlink reload
>
> Recent changes to the devlink reload (commit 9b2348e2d6c9
> ("devlink: warn about existing entities during reload-reinit"))
> force the drivers to destroy devlink ports during reinit.
> Adjust ice driver to this requirement, unregister netdvice, destroy
> devlink port. ice_init_eth() was removed and all the common code
> between probe and reload was moved to ice_load().
>
> During devlink reload we can't take devl_lock (it's already taken)
> and in ice_probe() we have to lock it. Use devl_* variant of the API
> which does not acquire and release devl_lock. Guard ice_load()
> with devl_lock only in case of probe.
>
> Suggested-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: empty init removed in ice_devlink_reinit_up
> v3: refactor locking pattern as Brett suggested
> v4: fix wrong function name in commit message
> v5: move debugfs changes to separate commit
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |   2 +
>  drivers/net/ethernet/intel/ice/ice_devlink.c |  68 ++++++-
>  drivers/net/ethernet/intel/ice/ice_main.c    | 186 ++++++-------------
>  3 files changed, 125 insertions(+), 131 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


