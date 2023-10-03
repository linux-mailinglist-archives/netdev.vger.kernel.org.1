Return-Path: <netdev+bounces-37590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEEC7B62E3
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9D9BB281519
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E14BD30F;
	Tue,  3 Oct 2023 07:57:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B86AC0
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 07:57:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E86190
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 00:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696319830; x=1727855830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DBy+DQ/rSrOhrdYVJ+RUjCnSvzRDUmnq3B7kLRYR548=;
  b=SKSKrrSFN7PEAmCWL5DqWXjxy7nKbp+mC9zqlEQBtAmKw4YKsp0XlVkp
   12YAwrnuwKwApeB7zi6ntG/Pt3Bw13aYbAFa7wqNh+fY553tFgoA6ADBy
   dZfyx1vg7/+QEikZJITxVKDd0yzicA4JvffuNtv+k6UnBqmY3Dya+BJjr
   2bzrzizUf4gr4G7w8tvoHd/DXEDkB3KYu6o6vqtycSXgPMzpqSyX1X+63
   k6Rr41B+pfpr+oa08r51qptHSYl+3uKH39yi3eQ7pKlnhYK4QOnBt5YX2
   FjvsfOnNCAhjqIdxbqxspaWrL6jG1/Jw+o+N6V38liyFWWTsap4cujdMx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="385640471"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="385640471"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 00:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="754325230"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="754325230"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 00:57:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 00:57:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 00:57:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 00:57:08 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 00:57:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5CCJR2qCNMzu0de3hMr+qDjxMecNzHgIaS9qPPkt+NlSoy+hKIlwo7bDrFA46gGhrwoPD+K+20WI/lrccsG6IT/oxMwqx0BO1nF/Vw2rxauuNea5jEnm3E7Fmiw+JuNji+ZHrAYjACZM4awlqFMy2AIf5EsBVv8b6cvJPzFFg4KqQEF1T/ZrWjPi/hhbZuxN8aopvh8cZHwX+j9BhDfb6XuapM9acGv3+PZyzXIl8/6bXucaQfe9156SW4C4t1TYjGCPLPgjcLb+aoOziV0NGozEZuW/rWhdeBqITLTCbrF1VGwyw/fNBk7EV3Cq7pHeuR47uzL9R3HyjYCqrh40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEHKcBZ5JwBI4iqceOMdUvlJP/wBf+9LkDvGzMBZDRs=;
 b=ilpKohjKx95qQUa49FQB4+03LTaGNEOBoDwAov6rIpXIWJKxCSFP4kY46VIY0AYjs0h+FMf7IscjTCAX8h0l/FfEQLeUgSL8YA4hbmPtbX/Phd+e7sAqsMA4l569buMoleAxplo26jP8dISR/hSlBUva9eWNo9/BJk62IIuRAHPnydtJTJ62Lxl3XvNXtwg2gvAlVr4BbbD1fKfCLTa404kV5rrSbvCulOjwU+eVEhxM+yNxfhHkU/1Dd03K/EzMcYJjIGxsML2NJBZUaEVYXL+dGVMRCh5XFrjJhI+d3xidyuAKGINzbtfuoLf4FKHknFENyqrl38x8u/hinpll9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH0PR11MB4838.namprd11.prod.outlook.com (2603:10b6:510:40::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 3 Oct
 2023 07:57:01 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::88e9:812b:618b:1fd3]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::88e9:812b:618b:1fd3%6]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 07:57:00 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: block default rule setting
 on LAG interface
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: block default rule
 setting on LAG interface
Thread-Index: AQHZ5+pU/ELzKi+cKEC9+xScvhzOlLA3zmNQ
Date: Tue, 3 Oct 2023 07:57:00 +0000
Message-ID: <PH0PR11MB501320F5FBB449D2471A741A96C4A@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230915153518.464595-2-marcin.szycik@linux.intel.com>
In-Reply-To: <20230915153518.464595-2-marcin.szycik@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH0PR11MB4838:EE_
x-ms-office365-filtering-correlation-id: a36276e0-f738-43b2-201c-08dbc3e6531e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7rFZIZPLEwQ7AKMFaHrDw95vEspxmdZ1iCHAbymKa/etoWJfw9gfGg1boxK1FahzJ0CLJr6iVx7ZtDl8xHZZsh8qJa5O40FhPOq4GQDCnecm+axhAvPj41SSxEXAe27hYHIpPrDvGaxjKrv7EWuh6SqQ4qqbTwf3s9p2e7eXqPepkVwXdXRYSMKBdccaSZfzo4sRHVzUjytmCrtNS5ZWzKJ6bkqBVvYtNrH49baNWaboa4K5LLEJsHyrvs/WzLJdZs70Q+M3vXtdr1Med1LBfffOvOnsjpFtAGqVcuhYWnop388FFjX9O9gBMW2qH+pzq2JM9al+9jrI6QAnacODW5/7lAzTVAL5beYLruGlFN7y2l51QmfzoWAjKZ5+/IH4g/+uYQTzAVugs3P7I78SXUJyxHJDDU2dDTT4PVtI5TYt9yUtxEwP1m6KyvwezXXARPLXuPjguiuaZy6U42xQGDDEdvg2/dK2yN+pWLl5xr/GnIynn1Dp3gM6zVDuEadWnOjTHD2AzxK8tPNfiO6JE3OLkTfwAtb8WXtuhtjQG1zwqZMyHqmotTjWUYR5jahuyz4zBZXur9GS4KLnck9CLq9p66gRaxLH7mKwYTkwL2nbXsYXjvlK5w6N/4o9To6P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(41300700001)(5660300002)(38100700002)(4326008)(26005)(122000001)(55016003)(82960400001)(38070700005)(86362001)(2906002)(8676002)(83380400001)(478600001)(8936002)(53546011)(33656002)(316002)(52536014)(6506007)(64756008)(76116006)(110136005)(71200400001)(7696005)(66476007)(9686003)(54906003)(66556008)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VNMYK6FfqR8HK3L6XS8ZvT8EmXv7fDY2o7Rbksbh3nnpnLFrq9ouRqcPc/Ro?=
 =?us-ascii?Q?N2Qf+CtSCsKdNeCFKzHfz7S76sKjZysyGpLdiicmjRobXWqvAx1CdLDMRMq4?=
 =?us-ascii?Q?5wyOv6PC6c/3p6+GAeAMawPxp8GjQdEgAAJKnzBr03iaF6P6mYg3BdTeu4eD?=
 =?us-ascii?Q?yK8GbHqL7cI0Y+201jzwg/rxsyPPHDwmZmSOIqISQyNZ76TMtVEszk0jkm3S?=
 =?us-ascii?Q?twvrAE6mdryE/0vD9VJTVJ0/AfQod9YSFBwHhTnEs68k73zFlnUyb/0yZb1F?=
 =?us-ascii?Q?N/nH/O5VpwbPbTR/68paqZNKHBKwZ7GoxjsTMi7G0eGAwA5MAbK+GjAKc8uV?=
 =?us-ascii?Q?mH7ZOrmkKjT+3SCxpV4Wm+/3YZY/vDFn6CpOZ+TXzik1nzniVJLHAoGC0TH8?=
 =?us-ascii?Q?BK5DRQorzuUWBpFnGf7enJQF5qXmCvrLGJhmMv6ILX3/jUF9+ZLn1TynB9zj?=
 =?us-ascii?Q?+xlzfaAgXt7goD0OUNxBNhFuLTZ0LQV9zv+2s1enRgj9fLq6zuC/jTO9qWEv?=
 =?us-ascii?Q?Q3fG9wIr2YFCyF1Qf3KAzdHi7JLTZYlaptSXxzYkeDzPollLrnzqoy6Dxd7G?=
 =?us-ascii?Q?kvn0DXXn3cG4Q052xdyrauoljthSaOGWlXtjS/rSG47F1fAdJ/k62VYXp6Nv?=
 =?us-ascii?Q?rwWWt38Z8z7nAYDttkWga9wuDZ+BRd2r2Y4H3h001dAnIbvSsVU/9tNoOs3G?=
 =?us-ascii?Q?iLdSyrIvfvDN+RPx6prH558QNdsCFHI15hltQSIWX9ZZHeW+M+HFMaSZALNk?=
 =?us-ascii?Q?2jNJYIcQoggUrxtY93YP4S99l0OXGNZEMc3gFWZxYUaGzWBsDu4dSQVPce6D?=
 =?us-ascii?Q?prCT0+/aU3c0MSxbFlfQynIXre17ZV2K6nK0sImw9Rbk7lQL1bhDur1tXHDM?=
 =?us-ascii?Q?eyZRT2aU09TCqjDCA0lKi4PevBP1S5e/wAvthTllnyWUawdiGQcOjQSybFH2?=
 =?us-ascii?Q?dfNngD0EsyKd+0Yw1gR5nC+Y1BPapMLkIP9e+XXdItTVR2xY39wTuoW0vf90?=
 =?us-ascii?Q?pC3UKkl31ck/a/u65AAazO7WTPjB5dVMTVl0cympzhSALU4vrqAj5WAEv+XC?=
 =?us-ascii?Q?XawSjaq/EPwSYkOx+3cysU7nI3QhVYTSie+nV7AK98RBDV0PRs/r4UxEKarb?=
 =?us-ascii?Q?OAzxf90b8iYdVucakFfFHSN6YAf4D5c8wvl3WCJCURkng39LU0tzkfH71pWX?=
 =?us-ascii?Q?IuaCfhaDhK/f5GNLREfsGrYxeGbKwbRY7CAXxTQB1Il5U0RiGLag8kjtI9Tu?=
 =?us-ascii?Q?0n479wyVUdQtJ8WpOp82Ts942wQwjaZuHEy9oi5KyZgjSCdLbgAI29J1ZZ5u?=
 =?us-ascii?Q?mmv9YbDS63rkBdFx9GzlFiXCAKdwHp1YLnOBuTyTzSRIl1HFxX63pXFwD9IE?=
 =?us-ascii?Q?Y7lT0LpUjNDwadDXnkfIuxA6UfhgwL1Ojjj8CQD85jsKTUaJItyu7kU/7UQa?=
 =?us-ascii?Q?5iJOHCZs+Suefu0AJBLpoAN8pqw3Bt3k009dRrtI+k9TajkPsouJAduxLzkB?=
 =?us-ascii?Q?kR9QrKxV0p8zZ4rHdM8uKeDxQ9fztlcDcvTB/qELtCbsVIlONYAz8VnBGgqx?=
 =?us-ascii?Q?tdOYVHR1Y7U95S3Q3lIEhQNLTQmIGsbsp6MDRRDPTibHfrzrKKtJ3ds/T9JF?=
 =?us-ascii?Q?8w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a36276e0-f738-43b2-201c-08dbc3e6531e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 07:57:00.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWnxig8q/Z5b+o1BpHpeu1SuQHJEIToFi/WDFIXGoRb970ZryWOjpXFWIxo6FopBU6eQySc3Cygn4VKxSBtiC9Ucq0hhEgQMBS8z3kLlagY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4838
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Marcin Szycik
> Sent: Friday, September 15, 2023 9:05 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Marcin Szycik <marcin.szycik@linux.intel.com>=
;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: block default rule settin=
g on
> LAG interface
>=20
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>=20
> When one of the LAG interfaces is in switchdev mode, setting default rule
> can't be done.
>=20
> The interface on which switchdev is running has ice_set_rx_mode() blocked
> to avoid default rule adding (and other rules). The other interfaces (wit=
hout
> switchdev running but connected via bond with interface that runs
> switchdev) can't follow the same scheme, because rx filtering needs to be
> disabled when failover happens. Notification for bridge to set promisc mo=
de
> seems like good place to do that.
>=20
> Fixes: bb52f42acef6 ("ice: Add driver support for firmware changes for LA=
G")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 32 ++++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_lag.h |  1 +
> drivers/net/ethernet/intel/ice/ice_lib.c |  6 +++++
>  3 files changed, 39 insertions(+)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

