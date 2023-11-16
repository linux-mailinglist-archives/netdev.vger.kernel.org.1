Return-Path: <netdev+bounces-48487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B026D7EE8D6
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 22:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5C71F24215
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89066482F0;
	Thu, 16 Nov 2023 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVMx+FXQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241EB181
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 13:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700170602; x=1731706602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6R6iO9Y/5AUnXiv8WX+w60/ejRbjJ4zWC5dUy0RzCn0=;
  b=HVMx+FXQZrogjSEWIK9WVCPHNB+3p3VB6vx4E2SJ2SEt5BDX0H4DjrjB
   vuwg0gIkseFBIdlW+bNhIN91nVG1XMIl0hvI3TMrHrjFS+WjtL/rhNWRv
   jHLDt2A1nERtAwYBM3QAgJnq13lsKZNlS4L5WKc7pbj7zvdjjSJqb+/AB
   /QE3UZvbYedaCIXzaxGVP1w3ybpoWBsN13v9ygaciEKIRH5dKtU1VegBW
   xOMUnzetR+C8avwCVmbe1iRqsmxf5HGQbd1vUSPqz6GJEQLwAmAz5h1VQ
   Ml7DHCxJfuGvfdhwQ4DWce8pdJE6osxMGzquyowv6024l9hnDscxSa74T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="477406852"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="477406852"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 13:36:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="715351610"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="715351610"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 13:36:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 13:36:40 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 13:36:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 13:36:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 13:36:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eg+/ZMRlIhIvebXmyeLpqUCfmoAq+E3MbtXUA8lgDN8RMxjveUCnvmU2NmTJZ18Corzywjd/upJVRmziAWI3qhWEGq2FhlQoJP82Y4M7th20s4m8TBnhXlaKwr0t2H9w1PLtXZBc4ooklobiy3zOBUYOXf0w2eXkOgN1QDOgUtzQKSEs58eRf3vjqITdtCHPeBSu9gQKFDHHJUv49gUFlH940so1U5pwx7VTSwMfeIi507VFOhGGmESqVNUupLq1IcRgG0xu073cBXgOY+f+Ig6ERxJvokBqmZqmxWAbvGjwxHNWB9EOGPiptgN4g3XIZh9i433g3baF8Qp35QWo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxAkrEj8iLzjRvvaI41WMh3wtFOxy+zyOr+S4UpM/YA=;
 b=newBwtzRBfHQ/saXSTeKfJiqEyvRKWql/fONLhQM61rXFR1lhr0dLsUDhvFsdUISzloklHLGPFh0g2xKVMqOStGlSO+LCf+gEKS3pz3K/d9sjQUY6v8fcwC/KRNdLQB2swN4hsluxIhiZM+lNZmybHEFWC2ZHBLhXT9UXikXcWjH2aKisTdT33Tb6vHpARfsT2EidVXj9+w1e1ZpL//Z9s1Nk8AFb055ptPMMVXy5tzZaO3lIYkkY472ROOfk4g+pR/AqcEMua9Wlqw2bpzDH9TbDeIYE3V53JiqUPK+SK5ETSj+ien0+pp0tX+UeWcgAxEWjGxWKGUurjaoVFniTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by PH7PR11MB7025.namprd11.prod.outlook.com (2603:10b6:510:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 21:36:38 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de%3]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 21:36:38 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Wyborny, Carolyn" <carolyn.wyborny@intel.com>,
	"daniel.machon@microchip.com" <daniel.machon@microchip.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: RE: [PATCH net] ice: Fix VF Reset paths when interface in a failed
 over aggregate
Thread-Topic: [PATCH net] ice: Fix VF Reset paths when interface in a failed
 over aggregate
Thread-Index: AQHaGAh+TuRVRlC/0k+ODV3JK/6fpLB9AIMAgAB1h7A=
Date: Thu, 16 Nov 2023 21:36:37 +0000
Message-ID: <MW5PR11MB5811FEDAF2D1E3113C3ADCD9DDB0A@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20231115211242.1747810-1-anthony.l.nguyen@intel.com>
 <ZVYllBDzdLIB97e2@boxer>
In-Reply-To: <ZVYllBDzdLIB97e2@boxer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|PH7PR11MB7025:EE_
x-ms-office365-filtering-correlation-id: cf658bb6-e1eb-4fab-49c0-08dbe6ec1d35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qwTrWCcRd09vpCMw1Zl96zLi8t7NQ2bobvJEcyUj2X92Imli/GtOVZtetNiXacPEwOpZyAz05h912sw8eF2sT3emCTtCo055oqjQmd+kR1+sYpm5EEnZSWF0g4p//jhw+CoyBBL0Cj1smCYCGd9Ii/09Gej8v9yjyonbkok8U3cop5fg1JAPsUoCU0AuuaWqeROowlv813u2r6VGDWKYCw6Lj32KZKLPFikGeazQMFeA5SVW6rYANpx7I+POkidO1ZMqyzsY4dUMpHnPCifpqylb2xbynciqnh2DiZMiUUn15DPuSpDB0zboFK6SCDmZC7k1FMl+8ekdCOL6PH01N405P790R3AZV273P/66p6lR9zak7yRGQ+8usLuL6HrgrurNJeIegvB0QfPga7yMHtlx6IJzrfuXmtI6MueDEW+I+YMCoGyQsdd7PnuHQur87mOnGTK4Bcfu0IubS+neriQTcvw5hSTIuYJ70QuyuA5akCrJEEQ4UDVhyvMjLo5EBfhLIqr9LjpyIJWsFEiGxCfoaVED2L+vF0+3Xf+dX5A00Q4DLBlYYWeAlLL3d8nVFc2/CFYZsdJZJSGUqGqobbG3nfS0KhuHWB1dxo7kiuo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(71200400001)(122000001)(83380400001)(107886003)(7696005)(9686003)(53546011)(82960400001)(6506007)(26005)(38100700002)(316002)(110136005)(6636002)(76116006)(66946007)(54906003)(66556008)(66476007)(66446008)(64756008)(38070700009)(55016003)(5660300002)(33656002)(41300700001)(2906002)(86362001)(8936002)(8676002)(4326008)(52536014)(478600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pQozXj2VMNQbBJ/+/jcznHwVqFyRho/nH7CLqLnSodOCcbe6kctOJjnwonCs?=
 =?us-ascii?Q?aiKipuJyA+7gvKgCdQY7DGjz664zR/oq7PilQenxaXpNDzHDwW3EtfoQwe0K?=
 =?us-ascii?Q?ZRxAY6FinD3TLO9IWKgPNi4lGx+nJ3ky0yLbwEEsCLt3pEKyP/czkyUPvuQY?=
 =?us-ascii?Q?hMiyNQMudh2DpDcRm8touaJPja60ZjU2lUiQBYuz3d3fUsY0S5WvQ47fE03d?=
 =?us-ascii?Q?/eMLf0QYaMD4YcLs3L5WjNojNCpT+FkHNZsYAf8ejAQeqGeJTb/MHww2WEkL?=
 =?us-ascii?Q?D9UptX9AH9hiiPIo3sq66B4GD0zt21mHD2f5RJBvNxr9VYMH0MHrqA0eQE8L?=
 =?us-ascii?Q?dByWL+jsWs8OdUBeTh6creiJk6esKAB6IXcxy3jWYVYHNANzKKj44x6B8yeq?=
 =?us-ascii?Q?A6X4uMWTAkvr+TeBmRG74zNmYomXBAgYeO6nWkd4OFR+2KQE+/TlOBJrjzJk?=
 =?us-ascii?Q?lKQX9aTL//AVGINjzrWyKlTG+ACEUHo653YLOemIqmeHG0VparNpCHNyxJgU?=
 =?us-ascii?Q?ZsGK/e05RhjDH0wK3TXIuki6al7J+7jF/fyaRoF7SwV1AmS9oUDfjGZtnsFH?=
 =?us-ascii?Q?NmYOQafKr115wCgSd1dMrtMj+GEnIWRgiypRQGK+joyxgyPrHE1k3y+zglSo?=
 =?us-ascii?Q?YFfCLanZwaombTNbBvmeJuwI4wBsBKACnOE+TYKk+tj+TEUfwsUFk2jCqJev?=
 =?us-ascii?Q?PFkPK5v13NrRW/X/eMwAPUz57PaRacpiOCIBGgq2VHSluvsmEIFmkfc27mxZ?=
 =?us-ascii?Q?txWzSAeBhTjvh2uRhtbpU8Gi+JmIWuVue7Y/hEybRnBnRqz1lKU5frKCrZ5D?=
 =?us-ascii?Q?IoKPdIdBhQddGJ7m4CiXsgSbq6Xb9PClIuLcQSBUTWwNO88ske+mNn2g/udI?=
 =?us-ascii?Q?1f3SnDG2cFRuWqqP5Pe5Xhnx07Rpd9HKEbGhAxrl6OUFvqZ/7C8LUG9t2xQj?=
 =?us-ascii?Q?dp4tVGFYNvsuCgxI420BCCrQiI4o8zSHHr71YRVBN/WiLafAzNza85ItEsKo?=
 =?us-ascii?Q?SjdLId8tCfklRjFr3okrN7K2rPRQ3FjbK5f0tev6JjyP3PLoT9RjmcsiixLG?=
 =?us-ascii?Q?bJN8MiJyhZcIPoTI8KJFYc/1j8MOwUHHe583qYqKkvnaCiFX2o4QBaZJdWGd?=
 =?us-ascii?Q?vmbnVQP+mc93mOfq3eOQy2buWDvmp9LNty0YPOdC5eJ/GjB568WMs3vv10Pf?=
 =?us-ascii?Q?YekuuBdIAUoENNlLByPrre5j84yDNX2Uv0JCgQ3B9pT2hsOPaV9+f80y9CwP?=
 =?us-ascii?Q?OEhVQu7YDK4BUptwc7eTdasGqVGgukukJK0237WxgD2IVNn00Afn9dBzlJGl?=
 =?us-ascii?Q?8+YvEwurNn0GbO1fVAeQPPgHY8/brRyWee2s7z99rfchPymp/7LJgRwzJZZU?=
 =?us-ascii?Q?5pU5CNIq79tO4v11Ouqv4+60sie4rC6m6PBLRIWi1Rd4OwyKooyq7IhyvQpL?=
 =?us-ascii?Q?rRB4XvdkuZj7bOJ3hDSCNdSXXkJykTAAfseeLj+VNcpedKz3Vtthz0/hiujY?=
 =?us-ascii?Q?COwRbuOsBQiMtUrtDPrLRgnHrqdq8PYGuJ98nQwKvbQyk0GvyLW8ToGvWFlH?=
 =?us-ascii?Q?k33+u+Wnu1oa83uPUtUosFM5msXaAhxxHiOEXnx+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5811.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf658bb6-e1eb-4fab-49c0-08dbe6ec1d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 21:36:37.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+SKLS1N8Itp6c/W1njklfFMmkF/N+v0Jc9Mqv51NBtccHLtZHNAH8p3LWlGdz1naSGqMrs8R6Ocq/BjiGnJBL+/wfYvzctWUOzakRMl8nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7025
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Thursday, November 16, 2023 6:22 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> edumazet@google.com; netdev@vger.kernel.org; Ertman, David M
> <david.m.ertman@intel.com>; Wyborny, Carolyn
> <carolyn.wyborny@intel.com>; daniel.machon@microchip.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Buvaneswaran, Sujai
> <sujai.buvaneswaran@intel.com>
> Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in a fail=
ed
> over aggregate
>=20
> On Wed, Nov 15, 2023 at 01:12:41PM -0800, Tony Nguyen wrote:
> > From: Dave Ertman <david.m.ertman@intel.com>
> >
> > There is an error when an interface has the following conditions:
> > - PF is in an aggregate (bond)
> > - PF has VFs created on it
> > - bond is in a state where it is failed-over to the secondary interface
> > - A VF reset is issued on one or more of those VFs
> >
> > The issue is generated by the originating PF trying to rebuild or
> > reconfigure the VF resources.  Since the bond is failed over to the
> > secondary interface the queue contexts are in a modified state.
> >
> > To fix this issue, have the originating interface reclaim its resources
> > prior to the tear-down and rebuild or reconfigure.  Then after the proc=
ess
> > is complete, move the resources back to the currently active interface.
> >
> > There are multiple paths that can be used depending on what triggered t=
he
> > event, so create a helper function to move the queues and use paired ca=
lls
> > to the helper (back to origin, process, then move back to active interf=
ace)
> > under the same lag_mutex lock.
> >
> > Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIO=
V
> on bonded interface")
> > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> > This is the net patch mentioned yesterday:
> > https://lore.kernel.org/netdev/71058999-50d9-cc17-d940-
> 3f043734e0ee@intel.com/
> >
> >  drivers/net/ethernet/intel/ice/ice_lag.c      | 42 +++++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_lag.h      |  1 +
> >  drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 20 +++++++++
> >  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 25 +++++++++++
> >  4 files changed, 88 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c
> b/drivers/net/ethernet/intel/ice/ice_lag.c
> > index cd065ec48c87..9eed93baa59b 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> > @@ -679,6 +679,48 @@ static void ice_lag_move_vf_nodes(struct ice_lag
> *lag, u8 oldport, u8 newport)
> >  			ice_lag_move_single_vf_nodes(lag, oldport,
> newport, i);
> >  }
> >
> > +/**
> > + * ice_lag_move_vf_nodes_cfg - move VF nodes outside LAG netdev
> event context
> > + * @lag: local lag struct
> > + * @src_prt: lport value for source port
> > + * @dst_prt: lport value for destination port
> > + *
> > + * This function is used to move nodes during an out-of-netdev-event
> situation,
> > + * primarily when the driver needs to reconfigure or recreate resource=
s.
> > + *
> > + * Must be called while holding the lag_mutex to avoid lag events from
> > + * processing while out-of-sync moves are happening.  Also, paired
> moves,
> > + * such as used in a reset flow, should both be called under the same
> mutex
> > + * lock to avoid changes between start of reset and end of reset.
> > + */
> > +void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt, u8
> dst_prt)
> > +{
> > +	struct ice_lag_netdev_list ndlist, *nl;
> > +	struct list_head *tmp, *n;
> > +	struct net_device *tmp_nd;
> > +
> > +	INIT_LIST_HEAD(&ndlist.node);
> > +	rcu_read_lock();
> > +	for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
>=20
> Why do you need rcu section for that?
>=20
> under mutex? lacking context here.
>=20

Mutex lock is to stop lag event thread from processing any other event unti=
l
after the asynchronous reset is processed.  RCU lock is to stop upper kerne=
l
bonding driver from changing elements while reset is building a list.

> > +		nl =3D kzalloc(sizeof(*nl), GFP_ATOMIC);
>=20
> do these have to be new allocations or could you just use list_move?
>=20

Building a list from scratch - nothing to move until it is created.

> > +		if (!nl)
> > +			break;
> > +
> > +		nl->netdev =3D tmp_nd;
> > +		list_add(&nl->node, &ndlist.node);
>=20
> list_add_rcu ?
>=20

I thought list_add_rcu was for internal list manipulation when prev and nex=
t
Are both known and defined?

> > +	}
> > +	rcu_read_unlock();
>=20
> you have the very same chunk of code in ice_lag_move_new_vf_nodes().
> pull
> this out to common function?
>=20
> ...and in ice_lag_rebuild().
>=20

Nice catch - for v2, pulled out code into two helper function:
ice_lag_build_netdev_list()
Iie_lag_destroy_netdev_list()


> > +	lag->netdev_head =3D &ndlist.node;
> > +	ice_lag_move_vf_nodes(lag, src_prt, dst_prt);
> > +
> > +	list_for_each_safe(tmp, n, &ndlist.node) {
>=20
> use list_for_each_entry_safe()
>=20

Changed in v2.

> > +		nl =3D list_entry(tmp, struct ice_lag_netdev_list, node);
> > +		list_del(&nl->node);
> > +		kfree(nl);
> > +	}
> > +	lag->netdev_head =3D NULL;

Thanks for the review!
DaveE

