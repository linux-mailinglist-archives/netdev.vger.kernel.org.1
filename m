Return-Path: <netdev+bounces-48771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B387A7EF769
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 19:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F7B2811C8
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BDA36B1E;
	Fri, 17 Nov 2023 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1dJrUwk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F130FD6A
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 10:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700245158; x=1731781158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CZozbeH5RozGrlwu60KeV2VEiBSGCQvtm/y7XeOALCU=;
  b=H1dJrUwkiFDXuU1spOtKo0sld8EDIdDlgnhGFA2eB0fWx3DOYryqAzdU
   SuYMOkelUDOkEWq05X896bkhLGe0f3B1FYVhET1f+Ew4kkQN4AhvlM3td
   HzM6euyUz+jarAf0l7w22GXSutI/DCHzOSRv6Bf7K+vJNnC6QIwZSI2Y0
   rHUucMbkebuEEGAyrNCYHrP1i0uc9/uANX3Em6pJnJ/VGv8PkRhaUd41I
   +YTsKEOGowtS501SpiBR+fMy8uoQeRw0+k/v7Boy1IVnDIC07EpC+9VK+
   wQrzvZKpYVsodDSK1XUn42QOD5xXJl23OigPtHLdXQFou1g+UCdycCYny
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="388495427"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="388495427"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 10:19:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="889322622"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="889322622"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 10:19:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 10:19:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 10:17:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 10:17:50 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 10:17:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSKwf1IMne3vUFt9++hk/sg/ucx8DzOt8d+51NObz/dYIIGVE99RlghjEglOku1BFDV79+kCVwzCQlmkS415aWCigeS4kp5MDx1A70Oz+UaUGhFEcpRFD8wwtsQgu6rLVzD43/NzcKBkpbdA1KzalaQx72c7c/kSrtM3mmusjFOprwaSTg6GvyIDJ/dbM69wtc3GArMqOBUofqp/AofAwLt5PTPk56xZustIIpDiJ8oIEEOcV1FVTtB4D74poI6NwqFx+SlQ9CxYTtzkTOSRBIYcjOKSuTl/yEebxCrJ7sMnxoP6ccLXUWM3o+5o9dfqY15P6IpkFq1Er+L3ZWmNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VQ0SPFUXhfc8cVCCtcXVF9VZBoycqapFz/FuMVzJEM=;
 b=nr05xUV7Mz3D9yLTb8CLp8EGPDTSBzNT574v7IEjhXFmWsmSXPSRgr/moA5zWtCap4scbUY/ArNvhzbGDRzehZ9UWcE5n5biodZ6CzrrQ2i7MF9JiksAfkpSzI90rcJU3VkY+yAoNMeJBxkInu4b1ktX3pRlqEescJXbzWEmqgBQhTRGnpXs2e9LjEIA+0T1cCx0ffVjU+/2qVcaXg9bHd6LrLzt65NI00bIfO6vUFKhynejcB74yMhrtL94z8W2V4r2OwpnDnqTW4Oiux3IBmS9GzsMhyeFvW6ZQhVi0JFy9UXCnBdpayG3sBjyF23+magdOVI9Pu1jHkTSEauGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by SA3PR11MB7528.namprd11.prod.outlook.com (2603:10b6:806:317::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Fri, 17 Nov
 2023 18:17:05 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de%4]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 18:17:05 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Wyborny, Carolyn" <carolyn.wyborny@intel.com>, "daniel.machon@microchip.com"
	<daniel.machon@microchip.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: RE: [PATCH net] ice: Fix VF Reset paths when interface in a failed
 over aggregate
Thread-Topic: [PATCH net] ice: Fix VF Reset paths when interface in a failed
 over aggregate
Thread-Index: AQHaGAh+TuRVRlC/0k+ODV3JK/6fpLB9AIMAgAB1h7CAAVU9gIAABjdQ
Date: Fri, 17 Nov 2023 18:17:05 +0000
Message-ID: <MW5PR11MB5811E4210635755D5D59FE34DDB7A@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20231115211242.1747810-1-anthony.l.nguyen@intel.com>
 <ZVYllBDzdLIB97e2@boxer>
 <MW5PR11MB5811FEDAF2D1E3113C3ADCD9DDB0A@MW5PR11MB5811.namprd11.prod.outlook.com>
 <ZVema0m2Pw6+VYTF@boxer>
In-Reply-To: <ZVema0m2Pw6+VYTF@boxer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|SA3PR11MB7528:EE_
x-ms-office365-filtering-correlation-id: 0297bb7d-1fc8-4630-77e8-08dbe799676c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l08vw/abi+nXS9Fk5biomS3IxPfA0PiWspTZDgPaUoOtRgTbUBvfK47L3Jvj3p9yzQ8mzWNJArCetyeny8zhoaBhemIcz8PGC1AgWKhvtzM2/hIGPepPuPK8LGUvTI9KNlw1xOhdnfAmuV5s5ZKQ0imgEP4Dc9Igi8RuNeNGni3S8bP8gVN8ODY2D2xMCHL+8AZaiJNtmC2NbV3HGTTYZdye49SoiwgsasVCwgodixfVwUXX0VwsQRiSc3rwf0k1UdEOrCswPnwfHxv1eNA2XJWtxL5hQjQunGTfPLYZKbvMJQ2/nk1jnf+N0J8hk8mKW/MWuPTFBcJ/IQTJ0SqT7c8JbUo5OiPTGEn8Kab/VQmfaWza4YFObjohPN+TbwoHKCNXspXgzP5xP+HrpzLZY5JivwUNZ29L4/38V18+OXru9fjPK0bZbGjm8k8sf9fTR5IjCojaUmMVyDZq+QQZ4mjrmHpSuZ26VKLBKLgWW3CmqoZeaQ6INapTYjxqTDBZkI24DfJMhw/LGYubMJdGdxXXuxcGjcm7cJKjO5U/gDV2uNiBzlDhdaPVa0Y2lX1veslj5AUT3YjyHw68+lBjX1MVW6lL8C3Wt//VT8/MEfg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(66476007)(5660300002)(41300700001)(316002)(52536014)(53546011)(38100700002)(86362001)(54906003)(66446008)(82960400001)(66556008)(6636002)(66946007)(76116006)(478600001)(26005)(9686003)(107886003)(122000001)(6506007)(7696005)(33656002)(71200400001)(966005)(83380400001)(8936002)(4326008)(6862004)(8676002)(38070700009)(55016003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1HLV/QQqaHCRjUQQuzqOfDdLYzoeQJFwQofuDdNlSR7cw2ETZPNabBR1jNUo?=
 =?us-ascii?Q?kcTO4iXeRCruH95LDVYuZT9wvyBTlitPq/Z+noBeJ/TIPx6zUgNecK5cN77A?=
 =?us-ascii?Q?yafeRChOhKALjN3JXdqnmBqqTmXh/PLuO117+sHpGgwcotdt6UMNGeIvZhGQ?=
 =?us-ascii?Q?Urg2b655JbwgsGYXeN/0Ra/zzXRlq9GasAoqH+xTcCt7ByLeEWTPZJ0sjO/S?=
 =?us-ascii?Q?RcVenMeZt4IPZ/g1uBOe0yQ8RwHen3cqVs3ZjR2LeCtr1z0F1kc6zMsdkTeb?=
 =?us-ascii?Q?GbJYxRausQ8IfXMfJJ5GRY4XzZVoplYtgta95x5iicix0LxXx1dvsrnRSrYd?=
 =?us-ascii?Q?prmqc3oaV08mO4/mA3k6tD88LTauernYgXmBnFU4XKpfae9g7qJXwtUMq3VF?=
 =?us-ascii?Q?XsT4znntBqgKaa+/38/ImuL6PnRKSqoNb20i+XtVyrCVQPwStwS6STJCfLW0?=
 =?us-ascii?Q?gjwoABaKodhb8f4MtzlOWcyTEqxQqfgXWK87fchLqLMGqVPsB1L0W3P7oc1w?=
 =?us-ascii?Q?8g85LDcBWfSxaANEJknyobrJ1rGcDUYVuauE0s1kTEVFeMWzuvHSjcJ6O9QB?=
 =?us-ascii?Q?vHbr/Rxn8SyQjYnjfljPcIQvjRTxO2rEOpemqOTQL9DIZ4hvOQqC/GIttWQf?=
 =?us-ascii?Q?6BcIhDW07uQ5ZKvzpWxsKdR54UCb70ms9t9gyQ3UBfqSRay2ueczGMqjqkrR?=
 =?us-ascii?Q?YnVW8IZd0c04dD7nJX8pubh9nwLCWFDcL15VvAjcuiO2T7fgWt6A7f9Hd1B0?=
 =?us-ascii?Q?b1HEt31UDjLjH3pInFigYTYGu/4zG3R0UZGOH1Uy09svWqasKMA1lhEkrMo8?=
 =?us-ascii?Q?M6vIgVNH5GXv7WgWtD9tah5s3u32WJfu5frqKIiRC3f3x7+b8K97sIjgI/4W?=
 =?us-ascii?Q?WnDqTJ6OJcUU8otyzjI8HIfFGM+WQ07dE02pVf7AiYUx+QNSPKLrAxtf9h2S?=
 =?us-ascii?Q?leIinLR3cFqRb3zq/diAmyv5nyNKLdoqYv8sXZLeso/whLqw56Lv2NG7d7pO?=
 =?us-ascii?Q?/xIXgyGasrNuvYKQ/VHi1pl5j6347H2yNhKU29oc1a1xvyn45qI/UCNdu/hA?=
 =?us-ascii?Q?E/BRfydECfiKprY5Yu65lEhpd0fU8sZCGeWENW9tPCsNo0BXU2Vqm6tz1SxQ?=
 =?us-ascii?Q?Dx0eEK2QqQBPZG5wvry/Uusmm1e+aG465ufVbLEWZdglAeLvMTexk6b+y/eo?=
 =?us-ascii?Q?2t7rVMbpi3G9ZPINWrydkTOBa3lBIjJ/8s+LcF/Lk38so//7cbfGlLfCkOtz?=
 =?us-ascii?Q?4FzJ5/VVFz/fPPfxRoale8PdwgQ6uDMDOgBPEcMFeXzCqTtAGLVfUT4Qv+WD?=
 =?us-ascii?Q?rmBpU03LY0tokdTRdBB6dEMd/E83u+D903QXepBDGKlt/YJBv7H7N3C2ztFR?=
 =?us-ascii?Q?ANLlJ/QaBDH0VinNrJXySKHB62QtANxaZA3s1PKBEaJEomK1vuxpYYdbSjTp?=
 =?us-ascii?Q?6Zr0JSeM/VxtMAAJBHikx/5hkWLOG4JAuX9Z0Z7NPmSMmPsl2uhKuZEdBU02?=
 =?us-ascii?Q?Lu9sCDmipoB/taZBaZI/h6Hx9/OiuQtbdPV5TAYApsa47iovA67I69KyzglU?=
 =?us-ascii?Q?a3BR9BHJFvC3MLagCyh67s064DPMdrYuZgg4/oPr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0297bb7d-1fc8-4630-77e8-08dbe799676c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 18:17:05.3875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSNLAHUfNvg45KkjCwThR5OWXQV1P75rIV59gH2HXe6FbjhJC/wTvzoIdBc9vxIgBEPuQmOyqr0PWbUorU73PrhAkLe+bluKLLLsudgTgpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7528
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Friday, November 17, 2023 9:44 AM
> To: Ertman, David M <david.m.ertman@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> edumazet@google.com; netdev@vger.kernel.org; Wyborny, Carolyn
> <carolyn.wyborny@intel.com>; daniel.machon@microchip.com; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Buvaneswaran, Sujai
> <sujai.buvaneswaran@intel.com>
> Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in a fail=
ed
> over aggregate
>=20
> On Thu, Nov 16, 2023 at 10:36:37PM +0100, Ertman, David M wrote:
> > > -----Original Message-----
> > > From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > > Sent: Thursday, November 16, 2023 6:22 AM
> > > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> > > Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> > > edumazet@google.com; netdev@vger.kernel.org; Ertman, David M
> > > <david.m.ertman@intel.com>; Wyborny, Carolyn
> > > <carolyn.wyborny@intel.com>; daniel.machon@microchip.com; Kitszel,
> > > Przemyslaw <przemyslaw.kitszel@intel.com>; Buvaneswaran, Sujai
> > > <sujai.buvaneswaran@intel.com>
> > > Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in a =
failed
> > > over aggregate
> > >
> > > On Wed, Nov 15, 2023 at 01:12:41PM -0800, Tony Nguyen wrote:
> > > > From: Dave Ertman <david.m.ertman@intel.com>
> > > >
> > > > There is an error when an interface has the following conditions:
> > > > - PF is in an aggregate (bond)
> > > > - PF has VFs created on it
> > > > - bond is in a state where it is failed-over to the secondary inter=
face
> > > > - A VF reset is issued on one or more of those VFs
> > > >
> > > > The issue is generated by the originating PF trying to rebuild or
> > > > reconfigure the VF resources.  Since the bond is failed over to the
> > > > secondary interface the queue contexts are in a modified state.
> > > >
> > > > To fix this issue, have the originating interface reclaim its resou=
rces
> > > > prior to the tear-down and rebuild or reconfigure.  Then after the
> process
> > > > is complete, move the resources back to the currently active interf=
ace.
> > > >
> > > > There are multiple paths that can be used depending on what trigger=
ed
> the
> > > > event, so create a helper function to move the queues and use paire=
d
> calls
> > > > to the helper (back to origin, process, then move back to active
> interface)
> > > > under the same lag_mutex lock.
> > > >
> > > > Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for
> SRIOV
> > > on bonded interface")
> > > > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > > Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> > > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > > ---
> > > > This is the net patch mentioned yesterday:
> > > > https://lore.kernel.org/netdev/71058999-50d9-cc17-d940-
> > > 3f043734e0ee@intel.com/
> > > >
> > > >  drivers/net/ethernet/intel/ice/ice_lag.c      | 42
> +++++++++++++++++++
> > > >  drivers/net/ethernet/intel/ice/ice_lag.h      |  1 +
> > > >  drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 20 +++++++++
> > > >  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 25 +++++++++++
> > > >  4 files changed, 88 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c
> > > b/drivers/net/ethernet/intel/ice/ice_lag.c
> > > > index cd065ec48c87..9eed93baa59b 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> > > > @@ -679,6 +679,48 @@ static void ice_lag_move_vf_nodes(struct
> ice_lag
> > > *lag, u8 oldport, u8 newport)
> > > >  			ice_lag_move_single_vf_nodes(lag, oldport,
> > > newport, i);
> > > >  }
> > > >
> > > > +/**
> > > > + * ice_lag_move_vf_nodes_cfg - move VF nodes outside LAG netdev
> > > event context
> > > > + * @lag: local lag struct
> > > > + * @src_prt: lport value for source port
> > > > + * @dst_prt: lport value for destination port
> > > > + *
> > > > + * This function is used to move nodes during an out-of-netdev-eve=
nt
> > > situation,
> > > > + * primarily when the driver needs to reconfigure or recreate
> resources.
> > > > + *
> > > > + * Must be called while holding the lag_mutex to avoid lag events =
from
> > > > + * processing while out-of-sync moves are happening.  Also, paired
> > > moves,
> > > > + * such as used in a reset flow, should both be called under the s=
ame
> > > mutex
> > > > + * lock to avoid changes between start of reset and end of reset.
> > > > + */
> > > > +void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt, u8
> > > dst_prt)
> > > > +{
> > > > +	struct ice_lag_netdev_list ndlist, *nl;
> > > > +	struct list_head *tmp, *n;
> > > > +	struct net_device *tmp_nd;
> > > > +
> > > > +	INIT_LIST_HEAD(&ndlist.node);
> > > > +	rcu_read_lock();
> > > > +	for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
> > >
> > > Why do you need rcu section for that?
> > >
> > > under mutex? lacking context here.
> > >
> >
> > Mutex lock is to stop lag event thread from processing any other event
> until
> > after the asynchronous reset is processed.  RCU lock is to stop upper k=
ernel
> > bonding driver from changing elements while reset is building a list.
>=20
> Can you point me to relevant piece of code for upper kernel bonding
> driver? Is there synchronize_rcu() on updates?

Here is the benning of the bonding struct from /include/net/bonding.h

/*
 * Here are the locking policies for the two bonding locks:
 * Get rcu_read_lock when reading or RTNL when writing slave list.
 */
struct bonding {
	struct   net_device *dev; /* first - useful for panic debug */
	struct   slave __rcu *curr_active_slave;
	struct   slave __rcu *current_arp_slave;
	struct   slave __rcu *primary_slave;
	struct   bond_up_slave __rcu *usable_slaves;
	struct   bond_up_slave __rcu *all_slaves;

> >
> > > > +		nl =3D kzalloc(sizeof(*nl), GFP_ATOMIC);
> > >
> > > do these have to be new allocations or could you just use list_move?
> > >
> >
> > Building a list from scratch - nothing to move until it is created.
>=20
> Sorry got confused.
>=20
> Couldn't you keep the up-to-date list of netdevs instead? And avoid all
> the building list and then deleting it after processing event?
>=20

The bonding driver is generating netdev events for things changing in the a=
ggregate. The ice
driver's event handler which takes a snapshot of the members of the bond an=
d creates a work
item which gets put on the event processing thread and then returns.  The e=
vents are processed
one at a time in sequence asynchronously to the event handler on the proces=
sing thread.  The
contents of the member list for the work item is only valid for that work i=
tem and cannot be used
for a reset event happening asynchronously to the processing queue.

Thanks,=20
DaveE

> >
> > > > +		if (!nl)
> > > > +			break;
> > > > +
> > > > +		nl->netdev =3D tmp_nd;
> > > > +		list_add(&nl->node, &ndlist.node);
> > >
> > > list_add_rcu ?
> > >
> >
> > I thought list_add_rcu was for internal list manipulation when prev and
> next
> > Are both known and defined?
>=20
> First time I hear this TBH but disregard the suggestion.
>=20
> >
> > > > +	}
> > > > +	rcu_read_unlock();
> > >
> > > you have the very same chunk of code in
> ice_lag_move_new_vf_nodes().
> > > pull
> > > this out to common function?
> > >
> > > ...and in ice_lag_rebuild().
> > >
> >
> > Nice catch - for v2, pulled out code into two helper function:
> > ice_lag_build_netdev_list()
> > Iie_lag_destroy_netdev_list()
> >
> >
> > > > +	lag->netdev_head =3D &ndlist.node;
> > > > +	ice_lag_move_vf_nodes(lag, src_prt, dst_prt);
> > > > +
> > > > +	list_for_each_safe(tmp, n, &ndlist.node) {
> > >
> > > use list_for_each_entry_safe()
> > >
> >
> > Changed in v2.
> >
> > > > +		nl =3D list_entry(tmp, struct ice_lag_netdev_list, node);
> > > > +		list_del(&nl->node);
> > > > +		kfree(nl);
> > > > +	}
> > > > +	lag->netdev_head =3D NULL;
> >
> > Thanks for the review!
> > DaveE

