Return-Path: <netdev+bounces-16026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D27974B058
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 13:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDAC1C20F93
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 11:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB46FC2D7;
	Fri,  7 Jul 2023 11:58:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A9C159
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 11:58:42 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEEB1FE1
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688731121; x=1720267121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TnRq0sBPbgdKbGNstg46Aykpt5GJzvy3uRP319ZJ6nw=;
  b=lrj9fXHaP+x5qU95K9V/TOtb2Lf3uKkBNzyMvDYnx3N4JclLL7eRQx83
   ya+Z3orGl1+6bMmvdirAGSoEFMmraUMdZFL6I33zOJXCmQ8m4PT6/IN4k
   4RRSU0fhAthzxPk3kBE237jgKmV/2BmT33qUDFZbq4LmlYUBtkQyopR/G
   LMnrvZSmRHg72aWxXo/0KkogDUE0Debr5hM4lEw8YydkISKv6W/9Q9GyA
   Oov39zc9g/sWvMekrrKCI6Aq1V8NFkVbuH46Mq+n+Jz1G1qaSMubUn50V
   lk/CH/3Le27ixaaoPb8V3vAiWw73letHqiICt9e4UoZZIsowL/Vt1Skmx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="367362088"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="367362088"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 04:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="864520626"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="864520626"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2023 04:58:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 04:58:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 04:58:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 04:58:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 04:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc7ORYfoMwR+hK/P/f+UnzehhNfz7as1+r4LSI7U9nvk5PzNqwH4HZubF/iTqqj8YobQV1d3Dcerw09rJJGFrLMJiJSdxIHcD/SE2TpFaL6WuFnD7k4SQ4/QPqwui/K0W8z7Lk5yYZ45numCsXS80vBDxForzGwDTERYjL3VVxGmom7lNeHPw/fkjXyG+6ChhxKs8lkZiZba6pNTb8GWdaMz5TZUvfT2wnZbmEvODllAE4+jpEF6ybk2yzPD/ZoCGJ9z26TRiW9UYBbGY+Eg4Tws/5jQlzkJ2jiXqHtDjZ60uRWACy5zsQxaRQxeUiysPCyREnUDS5SDsuYumqJkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gccFQz50A9mEMbx+uDipEM5Y0M+t8seRLCZugjgUiWQ=;
 b=BDWTSDRxQOJzCbaFU3AQhOK+34nAS8DhwueAX62ZIOGOY40FLYn5ywoJOZm8ITFYa8U8tMiKob95b3Q6ql6NBOZTWorXhl//FERGxeOx8Xj5FLfEd5GtZj5vCASMDII210LHf21h6GbShiUjdWsTBn33LQDV9qdOQCaStWIFZsyVgiyg1xQihldiSYOZOq8qxRKBBDGUb6OFMecQkWtQufclgWnNWY5VygHespiZSrozGhd5gcNvrwla3BtweNiymJ2oeFxGOnNhLj/efVggf9oo7NhMuM8f4sbZJ68/RsWCIlTBUTxcW8X9wLu8NK10ii4ocYzK/WeiJiwjNk8fYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by BL1PR11MB5351.namprd11.prod.outlook.com (2603:10b6:208:318::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 11:58:32 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::93f8:ecc4:eb28:7e65]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::93f8:ecc4:eb28:7e65%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 11:58:32 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Ertman, David M" <david.m.ertman@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bcreeley@amd.com"
	<bcreeley@amd.com>, "daniel.machon@microchip.com"
	<daniel.machon@microchip.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 04/10] ice: implement lag
 netdev event handler
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 04/10] ice: implement lag
 netdev event handler
Thread-Index: AQHZo8XlSoTJaXltH0+J0DfDs2YjTq+uTRJw
Date: Fri, 7 Jul 2023 11:58:32 +0000
Message-ID: <PH0PR11MB50137D483CDF4C4EE5DF76F0962DA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230620221854.848606-1-david.m.ertman@intel.com>
 <20230620221854.848606-5-david.m.ertman@intel.com>
In-Reply-To: <20230620221854.848606-5-david.m.ertman@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|BL1PR11MB5351:EE_
x-ms-office365-filtering-correlation-id: 5b30d3f2-de5f-4155-83b4-08db7ee17c72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k6HnblMLuzSDIgqxnVt7qBAJB+kiObbcixJeEtGoNvmTPQ8x3xbLo7PvF6aybCGXuyw6RZxYRv9vYjxrSgTRXgZYpEiKGHUA6au/SxnzuOsjbBdvKN726LCHmnGUiSz9l/HQfzF4TgUIC4WiqR84LqkzO6O9szBMju5dd+hoTK7JnDboaEF2powysesRBfi1A0bK7k/7LHPmHRVZdSznUQ72/IVDSosjDjsrdpq7XdR8bHj+K3oGlw82p2gZEpMROjmFZlBep5nQxNmxUh5mqEDtK7AIX457POYV3lTpHMbMk6fBu70LvhjxTW+h9gLyND69HFBHuQt/rKo+qnIDCa0/qxtyUaTf51e2YL7vmuQJyo8ag7ncyW2k0eFTN5frQce2iRZ5ygENPRrjHLc4E/qNpDVmxb4oMgNAq1kR1kqSxsylR8mXVV7s3QwpZqSq8DDzc8NbbxPqm1WBLq7TsnnDIoVjdVWYa6daAKDBh7QvNozRWBoi8LLvcY5xG6RsHamMKj0oNeU24OLqUj745UOpiWlEZMpIXDDCecHB3U6ykDPHAm042E2v34bNgxIIkNX2pp7iAWejavjRr2rjDFhXeGrs3q0ptjMInfRvgQfSpgddDOKNxUNTl/Auz4nG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(83380400001)(82960400001)(122000001)(33656002)(86362001)(38100700002)(55016003)(38070700005)(110136005)(54906003)(71200400001)(7696005)(41300700001)(478600001)(9686003)(8936002)(8676002)(5660300002)(52536014)(64756008)(66446008)(2906002)(316002)(66556008)(4326008)(76116006)(66946007)(66476007)(4744005)(186003)(53546011)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?14aTdd6kaWaohOt2oqwOr93yjaHPUX0mJx9jSnExHXKSZ6QN+vYVKGI7QOsF?=
 =?us-ascii?Q?POePB38JbQ+SsEkTs/IWihxN3MKfXrYwJi0ntoIlO1HDtIu3boE2gdH79KQR?=
 =?us-ascii?Q?HR6dg1o6OF9pHgCdwVshNLI8SgJGutga9skAkx7jNqgjXICK/77vIXccjM09?=
 =?us-ascii?Q?uIkUnQ1914FyO8299Fe4yFzNvEIu8RbwofyY8CR0dd2H7ByJymqc3maYmC/j?=
 =?us-ascii?Q?EipX7hSo9L1vLxtcCOW82nnNNAe2zTadfZ+CB1Ct6TazpBlCqVWMHWSyv5/f?=
 =?us-ascii?Q?DsbtrKYQsSpoPDHzEXh1pKsplIFgzSf/ysXHlFhL+7bCLa+NM14PAmhtbhht?=
 =?us-ascii?Q?cVKcBbAPrQ9tyO+E0g4obb0yI8IXPw94ySAqO0E4k0hIp/d9gEl8EOqxnMgZ?=
 =?us-ascii?Q?kZVuknQ+DZJK15kD6/FhorKCh00p817CSYLISnsiR+ERQLungAN0C0Wq63z7?=
 =?us-ascii?Q?X12Qy20cmmnHDZCPhyJxR6YZj7jJphiC1SnVpUh7B0A5oreFvEvUgiPGNKPY?=
 =?us-ascii?Q?6E7TMJwJHqoX7WQs5Gi21BEMi5HDpuhpRU9HHTEv7HzTK6vzoZur/ZXivjr8?=
 =?us-ascii?Q?2Tnp6qEZK36pfuYSxOvxaCcqiZmarTtgjo21u3vGbHeWKTDLoRxxxpB+8V9b?=
 =?us-ascii?Q?lYYyL5eTS7Uq3B9eTVYRyI1BOocmL09hcASXLOoMaQnGwgzNHKqalveo87q+?=
 =?us-ascii?Q?KenvQjk1Ghf4ErFZ1c7zg0RZzQp5rmVSzcUt639rNyJZTfgse2wOLrha/1l9?=
 =?us-ascii?Q?j5x0ODf+keNNI9TJD4QRX10wFZ1f8lIXopmGbIBVcbZEnlW+qWqRmZv4T3Zx?=
 =?us-ascii?Q?d9O0T5rqavbmkUmD9r9UfzpJv0EWkvdeIysj83Wy1Vz1exbPRvtWgzwf4Ick?=
 =?us-ascii?Q?H2Dsa9leU8pPaeVwE+CxX9J98Sj6qCST9p/vnfP0bbi9kr3R6mgACwirYB4C?=
 =?us-ascii?Q?HGZ1HIy/ccuBrXetg70fu2Yq590btNlwvlo6l4HPm6dnvPmgytWp0xbWsOU5?=
 =?us-ascii?Q?1PVPBtjNDY26yJUzCnMWWbrdETtYmcALePILFW1rQszL6v8NZfncn39OPnLU?=
 =?us-ascii?Q?ut3kllPH7oDgxAqrH+5MalStzVJRuHOnd8ldVNVujT8w/8twbbvRM8+5NUc/?=
 =?us-ascii?Q?SrN0T5Ixzq9xrgCE+dcbWLO462TH8fCsE4JxW7PLAXvwtSkimfZ2GV1I9Ign?=
 =?us-ascii?Q?+3nJ4x22LLi3yyQ2RrRuhlerJkO2ZBh+fA3R+abu8knk+hrVZwjJjJH8U89I?=
 =?us-ascii?Q?jFBm2mNqA8lYl6AQ8llPSD7NEZ+fceKTiAIlH3K93lZoY8F3JGoAtNVGHcYF?=
 =?us-ascii?Q?00lER130G1uCSYmjFz/Olp2SMsTF5UuObDbdBLp7Ml1Lwd43nPzn0Op7ndq3?=
 =?us-ascii?Q?IxqGeX8USuURV+/AZGwJLZnfYvhINFudavJCS0780yv+Wrc0A+FAHFVU5ldO?=
 =?us-ascii?Q?oZF//glbuWxU1BBqHiPAvoamCnuEzduvXVrGPQFfUx1OXwfr8RQPCX5FE1+V?=
 =?us-ascii?Q?iMwmqW1h4NafIioKYPeI3t4MFzhfQX3pQyPmufrIAfwYybbmTSuKTfMfHK9d?=
 =?us-ascii?Q?IYdTpG8epGjNqV+cj9M9YSa68OfuBFJ7OaUNR8ECYWYGUsv9KZZxIij0c/0O?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b30d3f2-de5f-4155-83b4-08db7ee17c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 11:58:32.3277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VI0RGwh/XEAUqaI1IUAVUz1kLjcLJB/t8RG66lirGMh1xNUeMTrcJL2dxVAzQzQgyBQrVriOhZMlB81IBjz61oexFaTFlHWvTgEIfu+teLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5351
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Dave Ertman
> Sent: Wednesday, June 21, 2023 3:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; bcreeley@amd.com;
> daniel.machon@microchip.com; simon.horman@corigine.com
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 04/10] ice: implement lag
> netdev event handler
>=20
> The event handler for LAG will create a work item to place on the ordered
> workqueue to be processed.
>=20
> Add in defines for training packets and new recipes to be used by the
> switching block of the HW for LAG packet steering.
>=20
> Update the ice_lag struct to reflect the new processing methodology.
>=20
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 124 ++++++++++++++++++++---
> drivers/net/ethernet/intel/ice/ice_lag.h |  30 +++++-
>  2 files changed, 140 insertions(+), 14 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

