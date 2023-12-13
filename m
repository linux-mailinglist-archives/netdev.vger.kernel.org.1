Return-Path: <netdev+bounces-56700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2054810879
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 03:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A248B21064
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 02:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00ED1873;
	Wed, 13 Dec 2023 02:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNFRUpxx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22720AF
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 18:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702436300; x=1733972300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tnbJHYnBZ99fPjW80v0qJN5mKV4r1bX5fyny4F8bj+U=;
  b=PNFRUpxxUvzPxIxnSRJECLGu0Aw38ZKUK0Dl7cheeP5tANWxnLJ2+XI4
   YdqexlOFsCpWN2nMS0AOH/caUlnAukSQehW+JQ9CzFZ6wvzEPobIAyGVP
   HTztLu2kj2NbpdCGyPfVdmDT4grzhCqBePhAD3QNGkKEHOoGNT2TsJmkv
   FhhV4tWvV6dT3J/TDOG9GouOZ+NgLAWXAtPsOTkY61Zg6kSUmurmt1GIz
   d+MO9xKnA50I6cq7lVtjSjDmBU2pH8b2AeWYAm+EHydjMdtv8J+B1HnAW
   5g9kp4sbfL41OqI9FXjGiSOYvtKNbKoo6JWGhAMoJ4hnyhU+2wGpTbUDn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1716950"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1716950"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:58:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1105150983"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1105150983"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 18:58:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:58:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:58:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 18:58:18 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 18:58:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR5TIL3Y4S3ch1FOAVzxgzSl0hGE1g5P8X0kwZxQ9azQkBa9ylLtdA5LE+Ldpo9//QY/1ZQjsvYVNK3k23C+/rgVgLkB9dyED0OJsu4YXTEc4LiyvprkELPyZLwcK6TqnvGRtdTgvGkrjnq8PBxsBrcxNUJ8H/pbysYZSRBzBzzZV0+Y60je2GlJrc9oeegERaBL3W/WiZK0W8IFH4lfFwfqNq/D6/LdeRIN0muBdK7J8PxSYEzh3OVXsu0fAiY6v8JAbba0pflBAoIbOM5fY440a4vrK5JLSuMdFXLRTzxGvbzKK/6DnBz44LrgUbLgCrgYzr0p654SkLGdWXwPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t2AIxEVhsR8DIYj54+Rie8S7+1YZ3AGkmHp5tFfyEs=;
 b=NvqqkQK/yyr7eGFjowbPosxaHCXEbKH/MW9HMjNge8HO+i6TKfVY+uNgmEttJhce6QJLYu6hkvxnub4RwNk7R4es7o+8DeFasHVb9Fjpkp6glbmXQ/q8UHbAtKA4qSejB42UOIQ/UaARVWDbO7oqHxCrVwvKLkJN2e8MkDNNztd3OExnXn0cLz2NOnT9YxwRRniZGnPhmlWLDM5cWKVBp/VvZXAxj6hPx1H0RNWqG8kO7Bb4vY/7nsoIJ3A2NGfLOvl8vkycbZVC5dWT0+g32j6dEhMHspKxLAdvxQstPR/EiBmAuER78WvnTaxbMiv7yGKmvSS7olP7QilFyZ8ndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 02:58:07 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f%4]) with mapi id 15.20.7068.031; Wed, 13 Dec 2023
 02:58:07 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "marcin.szycik@linux.intel.com"
	<marcin.szycik@linux.intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 04/15] i40e: field prep
 conversion
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 04/15] i40e: field prep
 conversion
Thread-Index: AQHaJ9/tiGUWJ85xXkOXBuOB7mfVZ7CmiPiQ
Date: Wed, 13 Dec 2023 02:58:07 +0000
Message-ID: <BL0PR11MB3122A2A5B5CDD04ED4FAFC99BD8DA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
 <20231206010114.2259388-5-jesse.brandeburg@intel.com>
In-Reply-To: <20231206010114.2259388-5-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SJ2PR11MB8451:EE_
x-ms-office365-filtering-correlation-id: ac2bfd2a-3a94-4702-e99e-08dbfb875528
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L40T2LD7N10jGCmaZCEqtyYMc1uDIopPMYfk91b62XCHL9PWcA1H/kExLZknEh32r3z8GTxx1/SlzjaJQK97nnWVaIykrDpJUq1hkOGdnYBUow24k8bJxrgp7LBepIQvMba0vibw+XU+ymKhR4AfpFq6Cp97osGzPCdC9hdSACJiPDt4jgw+tzAbk86eI+k6LpJw4IfPSGwgPZ/qePCBzrgx6P2qeHwxE2C0jXuOev/W6heKFYsW7cvQeL6FQqxagmU0ba3eHjG463Chm9jM4pdQDy8/2a4NFV43rKfNoxYvkHMcl6XEv4tME3XueGJeQFycljOHS2XKmpXpv8FYzAeQ3nJ2G4zBMw5AEoDHr+SCY+KIX5NDaOr3ytbObd8avl+TzZdFm6dUXizZhE2dtmMewq5vd+apEENiJQaQcqQjYsAVCtyI/vgwfBbGrhyH6ALKE6aAJF1QraaVaXgOQviBw6o/5wOeTW1HuZwA26K+010V8RIodKx/1TLB7OiAQdbELVqrWVxSNQFU2XpimEgDdBBGndHzJd+sgcxhgbTKtflr/MhooVTG++XX8BZmGfZphQt82CNP/RdNg0JPXu0xF+8ae7u+Zm7s8Ecxw8o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8676002)(8936002)(2906002)(4326008)(52536014)(316002)(5660300002)(55016003)(66476007)(76116006)(66556008)(110136005)(66946007)(64756008)(66446008)(54906003)(478600001)(38070700009)(26005)(6506007)(7696005)(53546011)(41300700001)(9686003)(71200400001)(82960400001)(83380400001)(33656002)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CrHZvJTt3djbPvVEIHpHZyF17mEDG0+KgAcFFI42OTqBNt4jaYX9lc6RDmZt?=
 =?us-ascii?Q?/LCECRJcxjeSzzoLikCj1AGKuRCXtw6SxsDKn6yefBib0khhAh23s3ZZvYJN?=
 =?us-ascii?Q?Xsiqb91j0/tn69MFPE4hja9KQfeatV8nrJmayxM1FPOmmVxjF0hr8dY4sKvM?=
 =?us-ascii?Q?snQovMUwXfWPhX/L7nmceSqc0pYlgBKJmhH8UFXPdpBVJg+dG0RmjVwXMUU3?=
 =?us-ascii?Q?HtqGPPOmw17KpkxzaFphcTC2d4rUu6/rErXA5EjEud5hr27agtjxCmgKi6N5?=
 =?us-ascii?Q?n0DV70sZIMbuYrMPvvGpbIX0o2RdQY0noPyi1qbGvgHgq7VGw3atW5+AnCj3?=
 =?us-ascii?Q?FnNFJ7AaPjnp92x+D04BdDNcG1fw4TFlH50wVuzqJ15t73TwJEOY1zEiro9n?=
 =?us-ascii?Q?NZ8YpQLttNlHPj3jlz0W4++TrSTX9EMytKwOvfh4UVMZ1VeRwSQ8BILjRvIc?=
 =?us-ascii?Q?rLl02TIx6i2Pra6FXo3HpdwB6X/deqFWVSZK3x25S6rsi4AOLLIdEgXSQMSo?=
 =?us-ascii?Q?GrQnI2Eu4RlDA6NEZCscnIQEs/6RcQKZBSJB4psL5TJ9LQ6r9b1GYGKvDfq4?=
 =?us-ascii?Q?bkgSmwgOWjWag6RAgeZpS82emDnoYW46tW5JKKrQxMQxkLfrT8zXdsiHofDF?=
 =?us-ascii?Q?ZK2Wo+p0wvPkGcSFUFGRVLnDCMdeZQJqDbfoWKYGdNIXhAjlEBCRPprepqlG?=
 =?us-ascii?Q?nKYDOFahpeBrHnijXUXA0oMa/cRTb66wkChq4EwB4hDGfOXJegP4k1h6Te5B?=
 =?us-ascii?Q?PLeEmMfB28Kn3WMsSk1Aq6E9HuuXAFSJq6fzHtKSitxpgTv2p6pSIs3F4RCT?=
 =?us-ascii?Q?oyG99R90JmMRSFd18UoEDrGnN4jch1eD+rBd/5XNUECYiKTs74OnIxMxtQFE?=
 =?us-ascii?Q?De5eWTVmdHl5wI/Ux9+R+7eLIwjQm+GPNIf6VjWrUQQzwN4nlNZft/9iYDjg?=
 =?us-ascii?Q?dMvknyTRMn+sb9Qm0d/2PSnjbgx9oKa/35DfnxSxvp1cefAHWKWUMJMyaGv9?=
 =?us-ascii?Q?hhmh2s+ecNOAVPFpSXl8WtqKF94D+J6eQDHnQNlyZSAc4iBn2XczKbib9/H2?=
 =?us-ascii?Q?fpJBakJj56D7F7QyX7cj0ODr8/zX5sBAQDkQD1iJrBHrRUWSFzlvrBLOmy5z?=
 =?us-ascii?Q?kYTnffktedHzs4dKsOBAvOk2b6kw0SIWiySLxJtL39PMX3T1aXCWF3bbzXyH?=
 =?us-ascii?Q?Qn//ajV2yi/sd7jMC2mhoyphdelGZDv/xcEm5Y2jbXKYCIntttU35vwmKTk/?=
 =?us-ascii?Q?0L38R1HYpaFqxhHHpLj/WP8tXaEh5oqj4bixk1fHOw4UJ32/Fy2ZppJdwo80?=
 =?us-ascii?Q?wRSzYYRyRw1TZVs57I1TWbEe9z/YHpAizGTmh3NwXQ63mPpJQC2hgV0zg0sj?=
 =?us-ascii?Q?l/huafiCmVx8CKLU/DmSmf0cakuua8trblIVBF+iNtorKfR5OSwDo3kBxz5d?=
 =?us-ascii?Q?IjisvPJt4xx7SfNizhmNGPXmsSscZM/kRmAqHz/W/8+tiSUVepX5FFzLT+HC?=
 =?us-ascii?Q?StMDcx+5dEZfSsSSMeK5SFWxDobvmI23oNzomIewH5p1r2o1LCqeXl0Frr/O?=
 =?us-ascii?Q?wGHQx83UfAoGoANhUffbGQi9aXtQVz5I8XfHI61Q0WPbMQnE9OkTRBq5JNuL?=
 =?us-ascii?Q?4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2bfd2a-3a94-4702-e99e-08dbfb875528
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 02:58:07.0722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MSn58NBa1vu/ZyFlgIKJQBthaS7rtu+Eykv5A/598UVHDelAgDEpzzpqvi82z3mPjo5NwHG92N/K56zmmbOITDhHB+/NW5fWZfSXs2f/khhiT7ePT9Y3F97kXJ1MV6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
esse Brandeburg
> Sent: Wednesday, December 6, 2023 6:31 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Brandeburg, Jesse=
 <jesse.brandeburg@intel.com>; Julia Lawall <Julia.Lawall@inria.fr>; Lobaki=
n, Aleksander <aleksander.lobakin@intel.com>; marcin.szycik@linux.intel.com=
; horms@kernel.org; netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 04/15] i40e: field prep con=
version
>
> Refactor i40e driver to use FIELD_PREP(), which reduces lines of code
> and adds clarity of intent.
>
> This code was generated by the following coccinelle/spatch script and
> then manually repaired.
>
> Refactor one function with multiple if's to return quickly to make lines
> fit in 80 columns.
>
> @prep2@
> constant shift,mask;
> type T;
> expression a;
> @@
> -(((T)(a) << shift) & mask)
> +FIELD_PREP(mask, a)
>
> @prep@
> constant shift,mask;
> type T;
> expression a;
> @@
> -((T)((a) << shift) & mask)
> +FIELD_PREP(mask, a)
>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: updated commit message
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c |  83 ++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c    | 116 ++++++++----------
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  12 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  41 +++----
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   8 +-
>  5 files changed, 109 insertions(+), 151 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


