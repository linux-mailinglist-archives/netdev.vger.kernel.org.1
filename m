Return-Path: <netdev+bounces-45185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071DC7DB4DC
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 09:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BABD1F2194E
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB4D264;
	Mon, 30 Oct 2023 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnaAqkSN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9443D71
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 08:11:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCBEA2
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698653472; x=1730189472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JrV9p031XU2lw+OQUeQ5j0v+gUOuPTHmbTNJ1hS4QzU=;
  b=lnaAqkSNKsnF5wieDKiXsoqoi3uOVwU0ld5WV7r6MXWZkaEJJS+zXhRI
   +U+QKf3nSn5xMxpa9336NfmX2b4cTIARx0gSuz7VW+pNCMqP5eudfDVsN
   tJ4u4znM1POLsNyxhyHtiNJW4dm6LP3u6KIx6zYEnH50jz0nGRSCmw3MN
   M3+uFilR3o9UJOTmVEdP3Llm6Nxe55vhJipvIbwnF9ABjENjZ0XzlRmwW
   16hsF1rh1XIqS9iKjZzqGgjmb0jw4Fr2vJ2lcb8/sO2UPx2M+uwW1S0MF
   mb6nC6yLAEpzzDsE7pdQaiGWa+itNjtHSrwF3BD15VaxULEwkxc4GlSYo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="452289067"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="452289067"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="825984915"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="825984915"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 01:11:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 01:11:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 01:11:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 01:11:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxQvMVg50VCmoncGUXPXMGkdAMtwIuzSL5GSVVvDRAXdE7mSwqku/ZtYEDdTqRwrPzGvSqBz/WgCjwpAMkBPvzsxwpnzsfR9dbNEp9cAktjMu1i0rkiK9PhzzsSgjHgxunWg6AvC/01IIfMC1TxfQx+iGbAnLTCIBLHZCfXzf0TIMjPNdpT/IlFjmO6a0Lmlsl03OLF6Sxd6RaZpWSgnNp968gAzJQnAQVtaOrW0c1qHUuu4Fhu7SkDDFYnirBamgHHBgeqnhc9PyHXQxVHQlPYGKnL/F8dj13hx7ENzGJhBK/sFIQJsDo69Ifx2zOJTvzIbEqmR875/9KusqlU5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDmmzTl9ryodxnJ9ZagFEQwccboyBsUVeXsMze/1JLY=;
 b=DeTi9vlY4d3wohl33q6mE+a6plaJxcY3TNfiQb8EYvJ5QlUzn93Epkaazvd+XIYX0axuQ6HuehSvhkvuFohwvzEt85YEpL5av/khBKao+yZSI9RMJMRJACivxBqionspSKBkZKuplDrpiQ6rasrLCPsgsiDGLDU1/Z88cH6pYp1qxPjQjJX19ZHDHx9kPzwMKDyQp1ejaICAIwMpqlOlRoMeGMATx1kXcDi58HCJrG7mZ0q8/dfOahdRjWatq7IISk3dt6Bdk8sn9ZP90cOsV8cCW3RLzxjvkp+k6ChWSsz3a0a06Q0s26EBbu1gtgaeepWT0y8L7WejxKyAVTB0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by MW4PR11MB6933.namprd11.prod.outlook.com (2603:10b6:303:22a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 08:11:04 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::d5af:4ec3:b590:6cc]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::d5af:4ec3:b590:6cc%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 08:11:04 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Ertman, David M" <david.m.ertman@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2] ice: Fix SRIOV LAG disable
 on non-compliant aggreagate
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2] ice: Fix SRIOV LAG disable
 on non-compliant aggreagate
Thread-Index: AQHZ+5+CfokJv8s46k2hlT7/LCC1NrBiGezg
Date: Mon, 30 Oct 2023 08:11:04 +0000
Message-ID: <PH0PR11MB5013B1AC9BEEC3D2FAB6454096A1A@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20231010173215.1502053-1-david.m.ertman@intel.com>
In-Reply-To: <20231010173215.1502053-1-david.m.ertman@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|MW4PR11MB6933:EE_
x-ms-office365-filtering-correlation-id: e255d6c4-ec81-4be0-8b17-08dbd91fc304
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEG8cN1B1RK5J7NDrTzH8RgFzdpjHMFloNwcmoh3duA6aaXOypJoNbkaXEe4FuihvedSjvlcTqE2jOgEwnVwuULKn5YQyeNUW9o3K1Vritd+ZFrQpZdZfb7yrcMnvsXWgjSgRCMtMVV2kMSizoAynWjqCWFABjVNzB4fcVH1h1E1DTLYNtWRCdWiUMBn8Qmj4OZduGW34RBy6SV3sNX6pAzy9zpzPml4VSrHlX0Qx2WHUOldMzyM49HsFdmyRzo1vhu3DcjmvWRLctbG34vuvMezRPJnvGCIW6XRspVBL8exPMPiwaT2rW5k1sz7//jwwQFLPeVV97xGUvyPeJwlmBTUanQlApU2YhCsm6vJ3wBieigcXuPXL9pNr/ZmJXhn2UuKD5C3dQWLgke/TJhKy7rY7bi/IvWmHLVFX4yNPdBatK5eOcyoRD+9akdTIH4ep9A/Rtpbrg0vHVauFHLv/RabCl3g0bPBWxBmYyvzgsAOpaY24tlsjcXkWW2E7F6qNWnKFSdc19Pc9Ab2Vb0x7McSWAKgp9ascPk5g5MMCHEYIb+EjAwyvu7M5IKrSx25ZA9u5jB6/ELFzlTSmhTBmDaYOA9IL+qGmRrSvXylxyDXVimn72mJFYlQ1cuJolcp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(33656002)(2906002)(86362001)(4744005)(38100700002)(83380400001)(55016003)(316002)(5660300002)(82960400001)(9686003)(122000001)(41300700001)(71200400001)(110136005)(66446008)(66476007)(64756008)(66556008)(66946007)(76116006)(53546011)(7696005)(6506007)(38070700009)(52536014)(26005)(4326008)(8676002)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cIF5AVWv3oWNh6kZW9tVLiw1HVk443SeVLyMBmoK2/5pYgLwuRAAHZOgEd31?=
 =?us-ascii?Q?or2/xcEsxriNaHFZL5OC9tJPzqJHlasN7Pkjrc/GGG4+W5gUubk2V4Ww5wlo?=
 =?us-ascii?Q?F8thFHP2pDyQm3bfw7bn+E7yRBPBwFuCFyTK+0gMW7221XQB7+6tAtfRzzFK?=
 =?us-ascii?Q?v90e9sHYxgwEC4eGHWXtJjMW7qwUpMcOUe1+zV+EBkx22hCP0f0muHhfvzTT?=
 =?us-ascii?Q?C9h7l3jaUxVur5/iANZWZWoHsYOH+SHI7ac2lxQzpvRx1LCvpC2BzutQQLCo?=
 =?us-ascii?Q?AvE+lmkdlqJpAErGZVyitcMufxxaCijaQrhgiMW4VrmkYJ+T8LWw2ejTxeQQ?=
 =?us-ascii?Q?AG3izBrGAYDoXdfTewR2DL5VBCe4/UplRJBrTBJ5dtvpH4qNnCAi9rJOWH7h?=
 =?us-ascii?Q?rbP3edVL0hRqlRIgJm6zQiNug59b+qYP9ueVtsMab9fFuA+2GvV2xxcW9WX0?=
 =?us-ascii?Q?fhbK3M8a7VOA4wZ5VQonHH8l6jV3CsF+NWJ+Lms2uWBFsuqs7udH6QuGCHiK?=
 =?us-ascii?Q?FPgwte/wdnUEj+A1HgWmvSMXqth2WB6NpPRAHEGYV+dqEKDoGUCnUm21aajj?=
 =?us-ascii?Q?6D6vKXzjWWTFYpL0uhZJ72ysdmUXvXw8wTXbETJEvSxoNb3p2Oz5ZXlCMaZW?=
 =?us-ascii?Q?NOEJsFAsmRluvFQZZy2h3/PXKHUH4bMNWoBW5xOBISf4rDlE4hXU0A/piRtS?=
 =?us-ascii?Q?eb+v/bf/t3Owj8yziOKzVOvqjXra2D35N2z/OkxNsnDxrXDKwUA7qWhzyUWi?=
 =?us-ascii?Q?N1ZccWVAO6kRh4jPiYjhHeptZk10sz52kQ/W7FX5gXxcvrmClLJYZ5sh3ZHR?=
 =?us-ascii?Q?H1vZB2EXtZ2/9dYpcWfpc5BYpKLfWk0bmkwTJv3M+O7HaLonO8HCWYT8Undb?=
 =?us-ascii?Q?nK2LN8yQH/9ba5457l7C1pbgAvtRoJWbZGkIFHqK7W5XjGpJEi9sawXjU0ht?=
 =?us-ascii?Q?O/wIwcIr3uzcJZSdmRg8iZQUzDRGzSsR4yPPTyqfRa8hSbiagfnWXZjMwUHg?=
 =?us-ascii?Q?FuaThGcmGO8iLjkZvEpb7vjHWkycQXovKJLD2vxdaGPdfmvlyUz8SzApEcap?=
 =?us-ascii?Q?vhcQqjrFltD36vMZp9EGxcPbfL7tuLS9u93obIuKVNrPumqQou5/itQwSZTl?=
 =?us-ascii?Q?6UAJPz0QL1hVqONF5S3e/XkR8qIDud1RvCW6DuVdPwtSiYjJ/bqZMSRc9ww9?=
 =?us-ascii?Q?ao76j8ga0e8mqhEhvS2hvt3XlBqdj09FvuyPGSVp83+NzfU6B3EboEUTwMsN?=
 =?us-ascii?Q?74k6DCI1bXiBS24R9sR9DKBDOOtnIAt0EYp5+iXwPEku1O66OCXmXqIcy5/J?=
 =?us-ascii?Q?j4SjBKJDedS93+s5KtAmx1VqjzSb898ocjlfyS4Mfldrzy9X76m+ccGqrV9n?=
 =?us-ascii?Q?WM+2DGRX8u+Zp46hN3Gev8ATQBiHYR4+oIqjEfj/gDbdNN8jXg7PS2litkfQ?=
 =?us-ascii?Q?JiBbKPdtWuxSYsvaF+IrTJFPR0mtM7zxsEAO8Wvqm9YLqpQ0QQrqChyYr3va?=
 =?us-ascii?Q?mrzbBnd8F/+2+gjmEiysethfs774JbWZ9fReBZEIGZnPTo9pq626r9ggUCPu?=
 =?us-ascii?Q?pi4xxKgWdTD7J+sNzqODajULy4oVPTlZoEcncgyuXJG/3eHfzvCWd7JDglsn?=
 =?us-ascii?Q?mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e255d6c4-ec81-4be0-8b17-08dbd91fc304
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 08:11:04.1634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nykuQzAbQSN7Din/XaiYd9i2un9HPUUB6816My60R6IW8Y3D8dNlKKtSONUoYHo0rF86C+aG0Rijy6f4WsFCDorqvhIOA6efQwZ4sFGaG3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6933
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Dave Ertman
> Sent: Tuesday, October 10, 2023 11:02 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2] ice: Fix SRIOV LAG disable=
 on
> non-compliant aggreagate
>=20
> If an attribute of an aggregate interface disqualifies it from supporting=
 SRIOV,
> the driver will unwind the SRIOV support.  Currently the driver is cleari=
ng the
> feature bit for all interfaces in the aggregate, but this is not allowing=
 the
> other interfaces to unwind successfully on driver unload.
>=20
> Only clear the feature bit for the interface that is currently unwinding.
>=20
> Fixes: bf65da2eb279 ("ice: enforce interface eligibility and add messagin=
g for
> SRIOV LAG")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

