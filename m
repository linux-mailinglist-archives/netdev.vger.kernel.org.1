Return-Path: <netdev+bounces-20103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C0875DA6D
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 08:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A5C2814D9
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 06:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977FD11C9F;
	Sat, 22 Jul 2023 06:47:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1BF11C85
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 06:47:26 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C411270B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 23:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690008445; x=1721544445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E2dVkTKujZC/l1L+9gkl3kFokrM4GttOLMRo0H0srrE=;
  b=DVDEGr5M8ge1IGWVC1gwYnl8ONZMXGw4uvXEMt1Bq/Xv9M9RtvXjIE3H
   lpdI/yISaEweMbVYTB2QBiNFTAFXQQdvAVHdBCmKptW3cWhV1CouJN1iq
   Qo983fpL+rBOfBqRDI83xtf6xElDELlA+HB/MShaU5e6NLF2yFOozHTR/
   nuxRqdEv81YNbomR8tmPxvcYtKJx4abT3gHAWUrJE8Qh9It5Gl4is/cMq
   J2u2t44XVVUFnR4OPl55naDe305F37zyTHUtr1Sru8h5VAqNN9P3qm/z6
   LZ6rGYFFoolxDBWoY1t7x+q3Czf3nN4pXxtdYVd7uPfL0rxO8hNzL1+Gp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="367200399"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="367200399"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 23:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="898937685"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="898937685"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2023 23:47:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 23:47:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 23:47:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 23:47:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oggetvvkaSUQY9TEPznRkHF37CbfwYFvt4zO2OuD1jnJ0DFPYX8krFsQC2Wo/xNcXFRVd0mOaq+K7OhMelJ8qrBk/1HBP3yFlYQU10wKt6G3plg98qkJGcudN8lfFwRjqS9+Pkv5sdah0C6yghzo4INRXc+9m6RWq7rS/bEwgv2gge9B+/ozgmIeNW0z80D0gCjXEolyR49kpNOVmtkpv34PhlAzmffQwRgYQBda9voeJJ6OaCilLrEe1U11rcTssjfNiLd2XCp/HlTfbKD00SyRxUd2PX5CEGEAAyITa9pG2kEjZkbyd/174QsQ2pyga5dyUlZDi8Nw5KR5nPo6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAKPOFC+Jt8aqUjZtDO4PPrZO+pNHkieygL7tC5+dVI=;
 b=AgodZ/IRbV+IgKeYurQ4VFlOV+XutRNV5a5viw1jNnxfnE1FZYFuHB1p+tQHM+LdB7cJrzSdpMBbsBOInE/7kUbztR5SpvDTEgz64Z2/eyurSqbXU+OigPI4dbiTRS0TVa16HgBFYHtdN5mQlatTvMELsUdxc+I08W91SriD8OYmMyAIuHurTYruKx6Z5gfUebwbJUjtYSmzxEUHIHwOj54iw2Z0rkkenx9mqwO5sEMDPrAZ5tsP01cpS48O4KTtctS5XxVtQ1CZS2/UAUmW+m5uWNwdluLz1wKFfOwWTdF1yRm4NXX1770Y11WkPaAyCQj1HqNp0CmxlccEVsc/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 06:47:21 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d%4]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 06:47:21 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "vladbu@nvidia.com" <vladbu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 06/12] ice: Implement basic
 eswitch bridge setup
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 06/12] ice: Implement basic
 eswitch bridge setup
Thread-Index: AQHZtLD46ZNN6GFf10CD9JFIs21rBK/FZzSQ
Date: Sat, 22 Jul 2023 06:47:20 +0000
Message-ID: <PH0PR11MB50132C6633A69AFFCD5B80C7963CA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
 <20230712110337.8030-7-wojciech.drewek@intel.com>
In-Reply-To: <20230712110337.8030-7-wojciech.drewek@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: 33c03028-0b4f-4863-a2a3-08db8a7f7f94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/kJ5sjLJl482mXvHbpX0KAfbHIEYZ+ywdM4TNBexZNXsu/T/k/iXcpOEk2xuvpa6XAfGf9QAg/gL2RN6+bSflCqLguexUiy7UfzHAsRoAIyCYVMMpFUSbxXDZomXmoEJX7j5cFv8CwIK6kJTAwHn8Y4LNF01S0VcpsbqaKS7VjLLdcd5Yycj8x3epeUcRZ1FAEQXoGPmO/uefgSyyHQZZegUfzOob881dzThAUeXeJnBz4VQXOPHVotFNCTjsx44XoVSE/suqHn2vprblpr/5yi7hxy5zc576+zqHI5d+3Y3PrLyi28FW32TJl4SAoOYRd2qBrVBVtBrr4UAipd+m9cb4scnUp/4OaVqDK71PBM46kqqNN4uDoLopBJPE+hfC9Y0MT8rKe9/nqW9+ViE6nBAqDyae5TOQ3iV5bC106RJFR2M0f/MHCuADmIXsS2R5XbNRQiaNbIP2MNIgHqCcG/TLbYeYt2rXS+8phTLfhFghcUFvn7J6En7u9s/ThcD/Z/nYiymwk2l3pGf2Fi9bNYpbLndyP8+o2SWCZH7c3+azscPmIaXhJfYU5PWCkaYTvrpKSoL4VlO4Kt/pxuShaF35SsopAzM79sjnTl2CVKd6gnImPHYoZTG0KORIVD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(2906002)(83380400001)(38070700005)(86362001)(33656002)(82960400001)(122000001)(38100700002)(55016003)(4326008)(64756008)(71200400001)(66476007)(66946007)(66446008)(66556008)(186003)(76116006)(478600001)(26005)(53546011)(41300700001)(316002)(110136005)(6506007)(7696005)(54906003)(9686003)(52536014)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ukvSThH3OUJfJg4cJMnau0TIgrmRtTDajyf3YmxSLaJjiF56aDdjvKGfRAL?=
 =?us-ascii?Q?wQaF/2foxhWg7d2KtQlaIMW8poJBOsPnLng38nRXqbBexujSIbucxrUTHR9y?=
 =?us-ascii?Q?MeJXdXFE01RZuh1F7+rcz4PUfaOtufAJtZ+0Y41euyCU620FE1DGDS0/883d?=
 =?us-ascii?Q?yNcgRTm4JHAhd6R/zyKgJosZxkh3iO/xdwGNaQYMgLOxjpleLGhhafL+6oVG?=
 =?us-ascii?Q?RLnNBj7wZhCmo1oOclBANj6Sey/Z820s3haAivE0bFTo4+CK4ypGRc52Rcx/?=
 =?us-ascii?Q?hLSM+SwAcpJSwSdJkkAqSNYrPCTWV03kXUpYlmBpFEwxOrWeLk/WEgCXUMrh?=
 =?us-ascii?Q?DGtJ3RkTtlg0z901AGSezsMDMh7jNc7WpU4a8pflfEqxECoXmYPZ1g5yYLFX?=
 =?us-ascii?Q?cD8k1aJKvXjUgzrXkWVmZgLBXNyZ16NxWP4KjD9PEgEG5UgLYWLoWfzIJ5QZ?=
 =?us-ascii?Q?pkJ8ImnHUaJ8IWOeg9BxWFALG/ixraA6Pj4n+FOIh1Q65uN7LldypeiR9uH/?=
 =?us-ascii?Q?oM2FwWT603Pm7ubXfcKTVqqDQYFLafx4wX/7PQ1RqCW9vSiQmkXiIi3sjtC1?=
 =?us-ascii?Q?t6eKMigOhn4yNGSqH6+DNWTLiS3raIOtOPMjTJPmrw6J230SBnR5/A0P9dam?=
 =?us-ascii?Q?qs1SsE+wi81dkNRKfwh2RGYqffvhxkUOTqs40SoFs2GSiJERuaksg7qI+T2C?=
 =?us-ascii?Q?VbfWIq+CoUiY/mxRFCrbc3xTCQT3IeNPt+Wylf1H/MGZFZmv49jwh3RWwxW2?=
 =?us-ascii?Q?iXxuSXmbZkG6bTKovILIjwwIHlSCrdg+05MX1+t0IxgaIKEA9klLcT2kgY4Y?=
 =?us-ascii?Q?zHADaWGOzEpwAhhmGYc4T6rnsG2u4CXe+L8DJNzdMCvtMv3iDn/x84WcG4NK?=
 =?us-ascii?Q?7qjP4wQ1WasAm4J9sZXQD6OCoh4sONvSUbka+Wnn9wN69zIsWtxen0kyq0b0?=
 =?us-ascii?Q?9rjCi363ckv/FxeLDEEAXWzg6AH5CLRQ+Hh1Oi8WCBgLlLrrfZV7nFtJCsGg?=
 =?us-ascii?Q?otk4WFmib7Hr47MbbBtYRybS2W9rF+bg3w229RyZhT0kH4di6hG1WgDAN3Q9?=
 =?us-ascii?Q?FGwZjRhlffJhGZmewL+8TYskdfzgpAC0bJoFI3JFHsSFkv8VgpSMgDX53A96?=
 =?us-ascii?Q?FhSpgNTKHkyKUWGXdYg55ImqcKWyNmVnz8fMdWnoAC+kgXEJlIzYQrpYqsr0?=
 =?us-ascii?Q?yr/WbxifN1jChiAcKSPAbOu9A+327IPVKfTz8mlXwY90/nvMHUCBhyktZUds?=
 =?us-ascii?Q?jrfZzQRilJHFDBKxajlpskO59ysUEYOwBZErDXDoUWcqZZ0YgryXztSKt6y5?=
 =?us-ascii?Q?VmX2DO4Y235EQ/hB+3lACUWfVD1zEYvjdQpxhhICmEUz9yiNWwACYvjDCF9r?=
 =?us-ascii?Q?n3WVZw1umGw4nTPI1x4TyQgh1qOgvYm1grqylTsfWvGCFAxWznBTzJHACxsi?=
 =?us-ascii?Q?SDJ4hytaQtAFMDH7KC7yt+ReiA/9wPkz1ZcVQndj6U374ZSTfJF8hZR0BVGr?=
 =?us-ascii?Q?OMM+g8wSbm8eaDusyjrGItNbSyGucZTj2nhIKqrfPtJ0RdPYK8LI0AlNEnPi?=
 =?us-ascii?Q?dCj6Pljv1s+h/U3cAFahggXhKO+zoo0lJMTRE8rFrro/fESTOIogropRo+hc?=
 =?us-ascii?Q?AQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c03028-0b4f-4863-a2a3-08db8a7f7f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 06:47:20.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8Z5m92OOnBKz7NIKoK3Ngw45uaKGnsgz2hL3JCJ8g8rGWfhOCYwHl1t87ZsORo4o2g6ESwZ+xG4DrZ5GaFOOrcEseS6kttLVbtOZA23MwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wojciech Drewek
> Sent: Wednesday, July 12, 2023 4:34 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; vladbu@nvidia.com;
> kuba@kernel.org; simon.horman@corigine.com; dan.carpenter@linaro.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 06/12] ice: Implement basic
> eswitch bridge setup
>=20
> With this patch, ice driver is able to track if the port representors or =
uplink
> port were added to the linux bridge in switchdev mode. Listen for
> NETDEV_CHANGEUPPER events in order to detect this. ice_esw_br data
> structure reflects the linux bridge and stores all the ports of the bridg=
e
> (ice_esw_br_port) in xarray, it's created when the first port is added to=
 the
> bridge and freed once the last port is removed. Note that only one bridge=
 is
> supported per eswitch.
>=20
> Bridge port (ice_esw_br_port) can be either a VF port representor port or
> uplink port (ice_esw_br_port_type). In both cases bridge port holds a
> reference to the VSI, VF's VSI in case of the PR and uplink VSI in case o=
f the
> uplink. VSI's index is used as an index to the xarray in which ports are =
stored.
>=20
> Add a check which prevents configuring switchdev mode if uplink is alread=
y
> added to any bridge. This is needed because we need to listen for
> NETDEV_CHANGEUPPER events to record if the uplink was added to the
> bridge. Netdevice notifier is registered after eswitch mode is changed to
> switchdev.
>=20
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: fix structure holes, wrapping improvements
> v4: fix potential Null pointer dereference in
>     ice_eswitch_br_port_unlink
> v5: update ice_esw_br_port::vsi on VF reset
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   2 +-
>  drivers/net/ethernet/intel/ice/ice.h          |   4 +-
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |  26 +-
>  .../net/ethernet/intel/ice/ice_eswitch_br.c   | 384 ++++++++++++++++++
>  .../net/ethernet/intel/ice/ice_eswitch_br.h   |  42 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     |   2 +-
>  drivers/net/ethernet/intel/ice/ice_repr.c     |   2 +-
>  drivers/net/ethernet/intel/ice/ice_repr.h     |   3 +-
>  8 files changed, 456 insertions(+), 9 deletions(-)  create mode 100644

Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

