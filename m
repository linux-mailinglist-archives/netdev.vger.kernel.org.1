Return-Path: <netdev+bounces-13078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5095273A191
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30E7281980
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F291ED29;
	Thu, 22 Jun 2023 13:12:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C91E513
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:12:34 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C10510F8
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687439552; x=1718975552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MwwswJgMijdFHmvWnRoEAUqkoz8w1NO1eMbmxRn48z0=;
  b=P13kwk4ztsyfxtBQgtsdYgsVZel4efmKx7qUTv1l50qpN7q4AW2yJg3r
   qs2zx8M0TO4pkZzeEO0iGpwAzC+RAKgyXRhePsUWIdUB7RbkbHOceeBmR
   2eUWttm0JlTa57mx98vfo3Q6dZ/FrJ1PsOIGFo18UaXR4EUUlrydCi3ko
   HVsS5uTBPm0t8lsp6MtVRgI4R+cnW9yJcK9p8OFb7e1iPbRQU42xp6dyk
   pl6qzXpE/LCKjkoZJnMDJD9fV6l3e1DIgDz0I9C8Y3DsnRkSCnq278p/z
   w5VwMXcDnQHv/X0eQovcjc5VbTqTb4cpz7TOopBdRSkcLY28TmVjN6F6v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="345216231"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="345216231"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:06:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="709090359"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="709090359"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2023 06:06:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 06:06:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 06:06:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 06:06:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 06:06:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2ZPwzP48aZ6KRk7OcjpvQWJMMU9hccHIOyuoF7Zgr1PVPTMUFFPDbs4J7Kf3eILS5NG8M2dsrDgitnSYNo3MoOoe4CIKVZUdYRRVxqTNeEzgq+eVyPeE5bSs56syO4tQZUWffNjR6anOezFCTQvhoALrKywc6yajur4CQMI9z0TDZQP0mLN1Tb+/Ffh349ryynMRSWzkDakKG2HsL5zkVSIRY6guqvCba5HLijxPyyMPVhEByuqZ2uAdyNuERlo9eIY0w1WA6ft/I1sOxVB3Aiyp+6QE5GTpXD5Eh5WB0FKA1T2tx7iT3msLOHmsN+u5clljeVWpazjl96AXcm6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL23JsbVRMZYVdj9ltBYTe+N15nxuxxpBIFDCOG92QM=;
 b=Ib5U4+XFhPMzGEo/4yB2lAOqyaeN1DA5q66RoI9mM7JzxlwTCWiGHL1Q6kIu+7Ud/uHsmaPK6VguA1jhoYpPimlXBv+klc4HfwfB60CDZM/2p31cQSAHJz05qja0rlzQ9GcUhC7jkX5j05JXiFpItLCTExPVVEF+9Av8J97YMMj5/X4+hhgAMrMkjaD3/Ee7sAGED8r15QY9dWmLd+nTlSvfgMSWSmx3pGUJoSjHuBIjyxodWfHra2q7CUGBuZUzDu2HbuEUBkE/Fctub7T6biNtcljlRxcygz2RZS/1gM2Q7jb50AQ7PPdZk+oLk8mJW0c1czTdY5Q8TwTeBmJrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 13:06:23 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::7b23:e512:60c9:ce08]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::7b23:e512:60c9:ce08%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 13:06:22 +0000
From: "Drewek, Wojciech" <wojciech.drewek@intel.com>
To: Vlad Buslov <vladbu@nvidia.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Szycik, Marcin" <marcin.szycik@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, ivecera <ivecera@redhat.com>,
	"simon.horman@corigine.com" <simon.horman@corigine.com>, "Buvaneswaran,
 Sujai" <sujai.buvaneswaran@intel.com>
Subject: RE: [PATCH net-next 09/12] ice: Add VLAN FDB support in switchdev
 mode
Thread-Topic: [PATCH net-next 09/12] ice: Add VLAN FDB support in switchdev
 mode
Thread-Index: AQHZo5+ceA2F19kYUUSIBPFEm+C1FK+Wu+mAgAAPS5A=
Date: Thu, 22 Jun 2023 13:06:22 +0000
Message-ID: <MW4PR11MB57765CBF044A67949E73756BFD22A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620174423.4144938-10-anthony.l.nguyen@intel.com>
 <87a5wrvgyf.fsf@nvidia.com>
In-Reply-To: <87a5wrvgyf.fsf@nvidia.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|SJ2PR11MB7599:EE_
x-ms-office365-filtering-correlation-id: 4e1af091-1bfa-4a76-befc-08db73217a79
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C1bmRJOQOCuvN2JPw6b/mvItGw5NNd/18DxkFQjWpJARvBnHXH/8SoIrlDTwr16SOu77wI2NwqQM29jezLQI0fclJadIdtJ7eS1Cxe/oR4FKiYTFwUseX3HszvDxriGCeohOxD9WQ5c5PHaJEriXvPfWpG5iOQO2eCn0Ovdr8s9zNerINKOZ8h20sQBbJyjqwDp3IKC5/GFXc/+jls8l+8Uqn5fM3YGpescjNaQBQBNBNXmAvHoChh+y0WU/2knrvO8F7dyeJ744H3DLhmlnHcKZCCP1/agpz/qx6N35r2Pk+Ab+Ds/ReMnaWyN46Y/FHdNLu9tJnVKUonAn1VnfE6EjI+gPeaneRbGpbeez+wDCdR5FoIOznJL6pvu1EqL24SksJ1O8MyDVL67uBUaZxJRD7u4EhPRu6kC++AuvQVLHw6kNf/2C4cV3KEEt4zm6IWdvQclDF/iLIlbswuuMhu5hekCDgMOy+rcErK6aJLws/2ArVKgLE/ZVApvdH0sDlgBQf6OIbjpY18uqn3B/0vCKoAq2+c2TermrMgrC4oiysJd1sOJqI6+MbVQ3P78kDdtZpqGnPz+4junFQeS04tXjJIdMVuyEEY0mXAmzy50=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(53546011)(186003)(71200400001)(9686003)(6506007)(107886003)(30864003)(478600001)(33656002)(55016003)(2906002)(86362001)(82960400001)(41300700001)(52536014)(8936002)(8676002)(110136005)(122000001)(38100700002)(54906003)(38070700005)(4326008)(316002)(6636002)(7696005)(5660300002)(66556008)(66476007)(66446008)(76116006)(83380400001)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OJk2dvt90AXwJ1GW+G2g1IoWwIplEXkFyYtaYkL/8hCrRQSAbJTjo9UNgskU?=
 =?us-ascii?Q?+Zg0knuVdIATMpaeXXSXz8zmU4PUSnjl+3n8yyr8cEs7Hpfbb9WkT1NLMxQz?=
 =?us-ascii?Q?Z8r0OPAGhEyXU+rHp4FhGQ1JVRlOFX8JZU3okoE9YR4BIPlBjtFMgqFonLj8?=
 =?us-ascii?Q?jLtmkVSQEJNQdfhkpeV9uczmW3j1Vs1jTEseipIHD+G/OcGXKzGjyGRs65qS?=
 =?us-ascii?Q?UhTfngr8uf3ZqUtzB231qoFugvwueE+kmbp+kn+JZ+Tt8TZADI2byO9jrkng?=
 =?us-ascii?Q?iRb5J0IEPT3ib2JXLErdLcZTGRlXs4qnSg+L1UDkG1UNxCLItTRqb0d659Id?=
 =?us-ascii?Q?ZBzysviGGr+hiGhXB8fiB+/SZtw9oLqes5glejDy0GUTdHSY3dFjUCYOrWyv?=
 =?us-ascii?Q?8pwsRMJtRXHDjm4RiQkKX6PON+10eJEAa5PCP1rmPxkLrUntrOtgeLp8CLXv?=
 =?us-ascii?Q?jJ3Moakxc9R8hcsgftzKE0OtYnSaUfUOWXO3JWo22lvFmvSxMNmazLdoi/0t?=
 =?us-ascii?Q?B45zCD19XB1KzMp5tqZfch9LZtBCMoB3hm8HUwSSHlRPi0YTIjSxAyFYU/zu?=
 =?us-ascii?Q?0l4W+7iohGYlnYtoW/kwP7GVhT4c9P35CkWi2ondC2rnG0wfUCp5RZyuNcae?=
 =?us-ascii?Q?xyzP9E0wFz9FyisaUvf7heABNOPT1R8ttF2iB/FNKGA14y/8wIEgkPc3oOhe?=
 =?us-ascii?Q?wM6mV4FyKCmmC6SoYWrFydaGPc+77S+SGCUMbqrJMcSVatCLVYGH+Ucu3JD8?=
 =?us-ascii?Q?ftxoEcHnfLxXrbZw71unryfA4YjcIzqHDgUm+s80cHvSFwiWqy+1RLZrECqT?=
 =?us-ascii?Q?kKmHXNPtKZcXmV9Ofj9VQ3CHX2/idKvq3vrgd6FweGnPqkuHoRR05R/D1MLs?=
 =?us-ascii?Q?n50Y/+c1LbDvpoqSWVcaSHPhbQcCasZ1ATAVo8CYZLgy8SOKntVDmcc0wtSb?=
 =?us-ascii?Q?4up/5//UkiOefcA0wkKoqVAVaSNLKP526MawAhCRrej3oRlHX9qFOb+qVCTE?=
 =?us-ascii?Q?WNCHNpdhNy9omMVgKel776ry4ZfRsj4nmhSpGvGXniMRPvFVpIzfiEgnGSOO?=
 =?us-ascii?Q?oD1ZlMYh/XxfsNMEMPWHzc7pFnzRv44zgLFLfv4+8/WeBXkjkxJLfiImGJ59?=
 =?us-ascii?Q?dDmYbSlYbqpgVsX88ZbiMOm4nks4eanrrqT5Tta6l6W4ycCR/tI/8Dx7wrfi?=
 =?us-ascii?Q?JLQrijalASa+VPUfcnxXmMv0mOFHPVJIygwF2F7XjODQVuIgzc9XdKKmSIoA?=
 =?us-ascii?Q?7bBxpsaQ9lAsuvFrOMjaHcQwF7Ih42Dl/GVMGuP4R/1q3XAPjh5lfvIBhhwB?=
 =?us-ascii?Q?CY1rtY5vRMnCbqjPh8SBR32bIdCTd1tsaND1P1OJAVqLthRLPYievpSl9TiP?=
 =?us-ascii?Q?hzAzd40RthE0ehgmRvpBTExwXFDiizBHvygo1kxY4Vg+sfdryaSoxBQTshqQ?=
 =?us-ascii?Q?WLMiTn7a1cspqaIEsPvz3DKOg+V6bsFooCflDZfJPsC4X3oRqqUhMImr8mtD?=
 =?us-ascii?Q?o1/pjooFuyJr3DqhQ6mTSFbMxUIkfva12Jsvh8CCqvUmj2Ffzj5+cXbQUVAL?=
 =?us-ascii?Q?YxwA9Midf7fOtyqmfkw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1af091-1bfa-4a76-befc-08db73217a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 13:06:22.8683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhgDxxk7U1esxX0JjWfj1OIaqD6Vqob4bgZ/RUue37y/Gmgn98NUY5O4HWDECP3Q7MJXQsnV/QT7ERHFiBw4u27plBpGGt5O1XxRV2AOHjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Vlad Buslov <vladbu@nvidia.com>
> Sent: czwartek, 22 czerwca 2023 14:04
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com; edumazet@goo=
gle.com; netdev@vger.kernel.org; Szycik, Marcin
> <marcin.szycik@intel.com>; jiri@resnulli.us; ivecera <ivecera@redhat.com>=
; simon.horman@corigine.com; Drewek, Wojciech
> <wojciech.drewek@intel.com>; Buvaneswaran, Sujai <sujai.buvaneswaran@inte=
l.com>
> Subject: Re: [PATCH net-next 09/12] ice: Add VLAN FDB support in switchde=
v mode
>=20
> On Tue 20 Jun 2023 at 10:44, Tony Nguyen <anthony.l.nguyen@intel.com> wro=
te:
> > From: Marcin Szycik <marcin.szycik@intel.com>
> >
> > Add support for matching on VLAN tag in bridge offloads.
> > Currently only trunk mode is supported.
> >
> > To enable VLAN filtering (existing FDB entries will be deleted):
> > ip link set $BR type bridge vlan_filtering 1
> >
> > To add VLANs to bridge in trunk mode:
> > bridge vlan add dev $PF1 vid 110-111
> > bridge vlan add dev $VF1_PR vid 110-111
> >
> > Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> > Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> >  .../net/ethernet/intel/ice/ice_eswitch_br.c   | 296 +++++++++++++++++-
> >  .../net/ethernet/intel/ice/ice_eswitch_br.h   |  21 ++
> >  2 files changed, 309 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/=
net/ethernet/intel/ice/ice_eswitch_br.c
> > index 1e57ce7b22d3..805a6b2fd965 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> > @@ -70,16 +70,34 @@ ice_eswitch_br_rule_delete(struct ice_hw *hw, struc=
t ice_rule_query_data *rule)
> >  	return err;
> >  }
> >
> > +static u16
> > +ice_eswitch_br_get_lkups_cnt(u16 vid)
> > +{
> > +	return ice_eswitch_br_is_vid_valid(vid) ? 2 : 1;
> > +}
> > +
> > +static void
> > +ice_eswitch_br_add_vlan_lkup(struct ice_adv_lkup_elem *list, u16 vid)
> > +{
> > +	if (ice_eswitch_br_is_vid_valid(vid)) {
> > +		list[1].type =3D ICE_VLAN_OFOS;
> > +		list[1].h_u.vlan_hdr.vlan =3D cpu_to_be16(vid & VLAN_VID_MASK);
> > +		list[1].m_u.vlan_hdr.vlan =3D cpu_to_be16(0xFFFF);
> > +	}
> > +}
> > +
> >  static struct ice_rule_query_data *
> >  ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, int vsi_idx, int por=
t_type,
> > -			       const unsigned char *mac)
> > +			       const unsigned char *mac, u16 vid)
> >  {
> >  	struct ice_adv_rule_info rule_info =3D { 0 };
> >  	struct ice_rule_query_data *rule;
> >  	struct ice_adv_lkup_elem *list;
> > -	u16 lkups_cnt =3D 1;
> > +	u16 lkups_cnt;
> >  	int err;
> >
> > +	lkups_cnt =3D ice_eswitch_br_get_lkups_cnt(vid);
> > +
> >  	rule =3D kzalloc(sizeof(*rule), GFP_KERNEL);
> >  	if (!rule)
> >  		return ERR_PTR(-ENOMEM);
> > @@ -107,6 +125,8 @@ ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, i=
nt vsi_idx, int port_type,
> >  	ether_addr_copy(list[0].h_u.eth_hdr.dst_addr, mac);
> >  	eth_broadcast_addr(list[0].m_u.eth_hdr.dst_addr);
> >
> > +	ice_eswitch_br_add_vlan_lkup(list, vid);
> > +
> >  	rule_info.need_pass_l2 =3D true;
> >
> >  	rule_info.sw_act.fltr_act =3D ICE_FWD_TO_VSI;
> > @@ -129,13 +149,15 @@ ice_eswitch_br_fwd_rule_create(struct ice_hw *hw,=
 int vsi_idx, int port_type,
> >
> >  static struct ice_rule_query_data *
> >  ice_eswitch_br_guard_rule_create(struct ice_hw *hw, u16 vsi_idx,
> > -				 const unsigned char *mac)
> > +				 const unsigned char *mac, u16 vid)
> >  {
> >  	struct ice_adv_rule_info rule_info =3D { 0 };
> >  	struct ice_rule_query_data *rule;
> >  	struct ice_adv_lkup_elem *list;
> > -	const u16 lkups_cnt =3D 1;
> >  	int err =3D -ENOMEM;
> > +	u16 lkups_cnt;
> > +
> > +	lkups_cnt =3D ice_eswitch_br_get_lkups_cnt(vid);
> >
> >  	rule =3D kzalloc(sizeof(*rule), GFP_KERNEL);
> >  	if (!rule)
> > @@ -149,6 +171,8 @@ ice_eswitch_br_guard_rule_create(struct ice_hw *hw,=
 u16 vsi_idx,
> >  	ether_addr_copy(list[0].h_u.eth_hdr.src_addr, mac);
> >  	eth_broadcast_addr(list[0].m_u.eth_hdr.src_addr);
> >
> > +	ice_eswitch_br_add_vlan_lkup(list, vid);
> > +
> >  	rule_info.allow_pass_l2 =3D true;
> >  	rule_info.sw_act.vsi_handle =3D vsi_idx;
> >  	rule_info.sw_act.fltr_act =3D ICE_NOP;
> > @@ -172,7 +196,7 @@ ice_eswitch_br_guard_rule_create(struct ice_hw *hw,=
 u16 vsi_idx,
> >
> >  static struct ice_esw_br_flow *
> >  ice_eswitch_br_flow_create(struct device *dev, struct ice_hw *hw, int =
vsi_idx,
> > -			   int port_type, const unsigned char *mac)
> > +			   int port_type, const unsigned char *mac, u16 vid)
> >  {
> >  	struct ice_rule_query_data *fwd_rule, *guard_rule;
> >  	struct ice_esw_br_flow *flow;
> > @@ -182,7 +206,8 @@ ice_eswitch_br_flow_create(struct device *dev, stru=
ct ice_hw *hw, int vsi_idx,
> >  	if (!flow)
> >  		return ERR_PTR(-ENOMEM);
> >
> > -	fwd_rule =3D ice_eswitch_br_fwd_rule_create(hw, vsi_idx, port_type, m=
ac);
> > +	fwd_rule =3D ice_eswitch_br_fwd_rule_create(hw, vsi_idx, port_type, m=
ac,
> > +						  vid);
> >  	err =3D PTR_ERR_OR_ZERO(fwd_rule);
> >  	if (err) {
> >  		dev_err(dev, "Failed to create eswitch bridge %sgress forward rule, =
err: %d\n",
> > @@ -191,7 +216,7 @@ ice_eswitch_br_flow_create(struct device *dev, stru=
ct ice_hw *hw, int vsi_idx,
> >  		goto err_fwd_rule;
> >  	}
> >
> > -	guard_rule =3D ice_eswitch_br_guard_rule_create(hw, vsi_idx, mac);
> > +	guard_rule =3D ice_eswitch_br_guard_rule_create(hw, vsi_idx, mac, vid=
);
> >  	err =3D PTR_ERR_OR_ZERO(guard_rule);
> >  	if (err) {
> >  		dev_err(dev, "Failed to create eswitch bridge %sgress guard rule, er=
r: %d\n",
> > @@ -245,6 +270,30 @@ ice_eswitch_br_flow_delete(struct ice_pf *pf, stru=
ct ice_esw_br_flow *flow)
> >  	kfree(flow);
> >  }
> >
> > +static struct ice_esw_br_vlan *
> > +ice_esw_br_port_vlan_lookup(struct ice_esw_br *bridge, u16 vsi_idx, u1=
6 vid)
> > +{
> > +	struct ice_pf *pf =3D bridge->br_offloads->pf;
> > +	struct device *dev =3D ice_pf_to_dev(pf);
> > +	struct ice_esw_br_port *port;
> > +	struct ice_esw_br_vlan *vlan;
> > +
> > +	port =3D xa_load(&bridge->ports, vsi_idx);
> > +	if (!port) {
> > +		dev_info(dev, "Bridge port lookup failed (vsi=3D%u)\n", vsi_idx);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	vlan =3D xa_load(&port->vlans, vid);
> > +	if (!vlan) {
> > +		dev_info(dev, "Bridge port vlan metadata lookup failed (vsi=3D%u)\n"=
,
> > +			 vsi_idx);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	return vlan;
> > +}
> > +
> >  static void
> >  ice_eswitch_br_fdb_entry_delete(struct ice_esw_br *bridge,
> >  				struct ice_esw_br_fdb_entry *fdb_entry)
> > @@ -314,10 +363,25 @@ ice_eswitch_br_fdb_entry_create(struct net_device=
 *netdev,
> >  	struct device *dev =3D ice_pf_to_dev(pf);
> >  	struct ice_esw_br_fdb_entry *fdb_entry;
> >  	struct ice_esw_br_flow *flow;
> > +	struct ice_esw_br_vlan *vlan;
> >  	struct ice_hw *hw =3D &pf->hw;
> >  	unsigned long event;
> >  	int err;
> >
> > +	/* untagged filtering is not yet supported */
> > +	if (!(bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING) && vid)
> > +		return;
> > +
> > +	if ((bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING)) {
> > +		vlan =3D ice_esw_br_port_vlan_lookup(bridge, br_port->vsi_idx,
> > +						   vid);
> > +		if (IS_ERR(vlan)) {
> > +			dev_err(dev, "Failed to find vlan lookup, err: %ld\n",
> > +				PTR_ERR(vlan));
> > +			return;
> > +		}
> > +	}
> > +
> >  	fdb_entry =3D ice_eswitch_br_fdb_find(bridge, mac, vid);
> >  	if (fdb_entry)
> >  		ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, fdb_entry);
> > @@ -329,7 +393,7 @@ ice_eswitch_br_fdb_entry_create(struct net_device *=
netdev,
> >  	}
> >
> >  	flow =3D ice_eswitch_br_flow_create(dev, hw, br_port->vsi_idx,
> > -					  br_port->type, mac);
> > +					  br_port->type, mac, vid);
> >  	if (IS_ERR(flow)) {
> >  		err =3D PTR_ERR(flow);
> >  		goto err_add_flow;
> > @@ -488,6 +552,207 @@ ice_eswitch_br_switchdev_event(struct notifier_bl=
ock *nb,
> >  	return NOTIFY_DONE;
> >  }
> >
> > +static void ice_eswitch_br_fdb_flush(struct ice_esw_br *bridge)
> > +{
> > +	struct ice_esw_br_fdb_entry *entry, *tmp;
> > +
> > +	list_for_each_entry_safe(entry, tmp, &bridge->fdb_list, list)
> > +		ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, entry);
> > +}
> > +
> > +static void
> > +ice_eswitch_br_vlan_filtering_set(struct ice_esw_br *bridge, bool enab=
le)
> > +{
> > +	if (enable =3D=3D !!(bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING))
> > +		return;
> > +
> > +	ice_eswitch_br_fdb_flush(bridge);
> > +	if (enable)
> > +		bridge->flags |=3D ICE_ESWITCH_BR_VLAN_FILTERING;
> > +	else
> > +		bridge->flags &=3D ~ICE_ESWITCH_BR_VLAN_FILTERING;
> > +}
> > +
> > +static void
> > +ice_eswitch_br_vlan_cleanup(struct ice_esw_br_port *port,
> > +			    struct ice_esw_br_vlan *vlan)
> > +{
> > +	xa_erase(&port->vlans, vlan->vid);
> > +	kfree(vlan);
> > +}
> > +
> > +static void ice_eswitch_br_port_vlans_flush(struct ice_esw_br_port *po=
rt)
> > +{
> > +	struct ice_esw_br_vlan *vlan;
> > +	unsigned long index;
> > +
> > +	xa_for_each(&port->vlans, index, vlan)
> > +		ice_eswitch_br_vlan_cleanup(port, vlan);
> > +}
> > +
> > +static struct ice_esw_br_vlan *
> > +ice_eswitch_br_vlan_create(u16 vid, u16 flags, struct ice_esw_br_port =
*port)
> > +{
> > +	struct ice_esw_br_vlan *vlan;
> > +	int err;
> > +
> > +	vlan =3D kzalloc(sizeof(*vlan), GFP_KERNEL);
> > +	if (!vlan)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	vlan->vid =3D vid;
> > +	vlan->flags =3D flags;
> > +
> > +	err =3D xa_insert(&port->vlans, vlan->vid, vlan, GFP_KERNEL);
> > +	if (err) {
> > +		kfree(vlan);
> > +		return ERR_PTR(err);
> > +	}
> > +
> > +	return vlan;
> > +}
> > +
> > +static int
> > +ice_eswitch_br_port_vlan_add(struct ice_esw_br *bridge, u16 vsi_idx, u=
16 vid,
> > +			     u16 flags, struct netlink_ext_ack *extack)
> > +{
> > +	struct ice_esw_br_port *port;
> > +	struct ice_esw_br_vlan *vlan;
> > +
> > +	port =3D xa_load(&bridge->ports, vsi_idx);
> > +	if (!port)
> > +		return -EINVAL;
> > +
> > +	vlan =3D xa_load(&port->vlans, vid);
> > +	if (vlan) {
> > +		if (vlan->flags =3D=3D flags)
> > +			return 0;
> > +
> > +		ice_eswitch_br_vlan_cleanup(port, vlan);
> > +	}
> > +
> > +	vlan =3D ice_eswitch_br_vlan_create(vid, flags, port);
> > +	if (IS_ERR(vlan)) {
> > +		NL_SET_ERR_MSG_FMT_MOD(extack, "Failed to create VLAN entry, vid: %u=
, vsi: %u",
> > +				       vid, vsi_idx);
> > +		return PTR_ERR(vlan);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void
> > +ice_eswitch_br_port_vlan_del(struct ice_esw_br *bridge, u16 vsi_idx, u=
16 vid)
> > +{
> > +	struct ice_esw_br_port *port;
> > +	struct ice_esw_br_vlan *vlan;
> > +
> > +	port =3D xa_load(&bridge->ports, vsi_idx);
> > +	if (!port)
> > +		return;
> > +
> > +	vlan =3D xa_load(&port->vlans, vid);
> > +	if (!vlan)
> > +		return;
> > +
>=20
> Don't you also need to cleanup all FDBs on the port matching the vid
> being deleted here?

Correct, we will add it to the next PR.

>=20
> > +	ice_eswitch_br_vlan_cleanup(port, vlan);
> > +}
> > +
> > +static int
> > +ice_eswitch_br_port_obj_add(struct net_device *netdev, const void *ctx=
,
> > +			    const struct switchdev_obj *obj,
> > +			    struct netlink_ext_ack *extack)
> > +{
> > +	struct ice_esw_br_port *br_port =3D ice_eswitch_br_netdev_to_port(net=
dev);
> > +	struct switchdev_obj_port_vlan *vlan;
> > +	int err;
> > +
> > +	if (!br_port)
> > +		return -EINVAL;
> > +
> > +	switch (obj->id) {
> > +	case SWITCHDEV_OBJ_ID_PORT_VLAN:
> > +		vlan =3D SWITCHDEV_OBJ_PORT_VLAN(obj);
> > +		err =3D ice_eswitch_br_port_vlan_add(br_port->bridge,
> > +						   br_port->vsi_idx, vlan->vid,
> > +						   vlan->flags, extack);
> > +		return err;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int
> > +ice_eswitch_br_port_obj_del(struct net_device *netdev, const void *ctx=
,
> > +			    const struct switchdev_obj *obj)
> > +{
> > +	struct ice_esw_br_port *br_port =3D ice_eswitch_br_netdev_to_port(net=
dev);
> > +	struct switchdev_obj_port_vlan *vlan;
> > +
> > +	if (!br_port)
> > +		return -EINVAL;
> > +
> > +	switch (obj->id) {
> > +	case SWITCHDEV_OBJ_ID_PORT_VLAN:
> > +		vlan =3D SWITCHDEV_OBJ_PORT_VLAN(obj);
> > +		ice_eswitch_br_port_vlan_del(br_port->bridge, br_port->vsi_idx,
> > +					     vlan->vid);
> > +		return 0;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int
> > +ice_eswitch_br_port_obj_attr_set(struct net_device *netdev, const void=
 *ctx,
> > +				 const struct switchdev_attr *attr,
> > +				 struct netlink_ext_ack *extack)
> > +{
> > +	struct ice_esw_br_port *br_port =3D ice_eswitch_br_netdev_to_port(net=
dev);
> > +
> > +	if (!br_port)
> > +		return -EINVAL;
> > +
> > +	switch (attr->id) {
> > +	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
> > +		ice_eswitch_br_vlan_filtering_set(br_port->bridge,
> > +						  attr->u.vlan_filtering);
> > +		return 0;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int
> > +ice_eswitch_br_event_blocking(struct notifier_block *nb, unsigned long=
 event,
> > +			      void *ptr)
> > +{
> > +	struct net_device *dev =3D switchdev_notifier_info_to_dev(ptr);
> > +	int err;
> > +
> > +	switch (event) {
> > +	case SWITCHDEV_PORT_OBJ_ADD:
> > +		err =3D switchdev_handle_port_obj_add(dev, ptr,
> > +						    ice_eswitch_br_is_dev_valid,
> > +						    ice_eswitch_br_port_obj_add);
> > +		break;
> > +	case SWITCHDEV_PORT_OBJ_DEL:
> > +		err =3D switchdev_handle_port_obj_del(dev, ptr,
> > +						    ice_eswitch_br_is_dev_valid,
> > +						    ice_eswitch_br_port_obj_del);
> > +		break;
> > +	case SWITCHDEV_PORT_ATTR_SET:
> > +		err =3D switchdev_handle_port_attr_set(dev, ptr,
> > +						     ice_eswitch_br_is_dev_valid,
> > +						     ice_eswitch_br_port_obj_attr_set);
> > +		break;
> > +	default:
> > +		err =3D 0;
> > +	}
> > +
> > +	return notifier_from_errno(err);
> > +}
> > +
> >  static void
> >  ice_eswitch_br_port_deinit(struct ice_esw_br *bridge,
> >  			   struct ice_esw_br_port *br_port)
> > @@ -506,6 +771,7 @@ ice_eswitch_br_port_deinit(struct ice_esw_br *bridg=
e,
> >  		vsi->vf->repr->br_port =3D NULL;
> >
> >  	xa_erase(&bridge->ports, br_port->vsi_idx);
> > +	ice_eswitch_br_port_vlans_flush(br_port);
> >  	kfree(br_port);
> >  }
> >
> > @@ -518,6 +784,8 @@ ice_eswitch_br_port_init(struct ice_esw_br *bridge)
> >  	if (!br_port)
> >  		return ERR_PTR(-ENOMEM);
> >
> > +	xa_init(&br_port->vlans);
> > +
> >  	br_port->bridge =3D bridge;
> >
> >  	return br_port;
> > @@ -817,6 +1085,7 @@ ice_eswitch_br_offloads_deinit(struct ice_pf *pf)
> >  		return;
> >
> >  	unregister_netdevice_notifier(&br_offloads->netdev_nb);
> > +	unregister_switchdev_blocking_notifier(&br_offloads->switchdev_blk);
> >  	unregister_switchdev_notifier(&br_offloads->switchdev_nb);
> >  	destroy_workqueue(br_offloads->wq);
> >  	/* Although notifier block is unregistered just before,
> > @@ -860,6 +1129,15 @@ ice_eswitch_br_offloads_init(struct ice_pf *pf)
> >  		goto err_reg_switchdev_nb;
> >  	}
> >
> > +	br_offloads->switchdev_blk.notifier_call =3D
> > +		ice_eswitch_br_event_blocking;
> > +	err =3D register_switchdev_blocking_notifier(&br_offloads->switchdev_=
blk);
> > +	if (err) {
> > +		dev_err(dev,
> > +			"Failed to register bridge blocking switchdev notifier\n");
> > +		goto err_reg_switchdev_blk;
> > +	}
> > +
> >  	br_offloads->netdev_nb.notifier_call =3D ice_eswitch_br_port_event;
> >  	err =3D register_netdevice_notifier(&br_offloads->netdev_nb);
> >  	if (err) {
> > @@ -871,6 +1149,8 @@ ice_eswitch_br_offloads_init(struct ice_pf *pf)
> >  	return 0;
> >
> >  err_reg_netdev_nb:
> > +	unregister_switchdev_blocking_notifier(&br_offloads->switchdev_blk);
> > +err_reg_switchdev_blk:
> >  	unregister_switchdev_notifier(&br_offloads->switchdev_nb);
> >  err_reg_switchdev_nb:
> >  	destroy_workqueue(br_offloads->wq);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/=
net/ethernet/intel/ice/ice_eswitch_br.h
> > index 7afd00cdea9a..dd49b273451a 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> > @@ -42,6 +42,11 @@ struct ice_esw_br_port {
> >  	struct ice_vsi *vsi;
> >  	enum ice_esw_br_port_type type;
> >  	u16 vsi_idx;
> > +	struct xarray vlans;
> > +};
> > +
> > +enum {
> > +	ICE_ESWITCH_BR_VLAN_FILTERING =3D BIT(0),
> >  };
> >
> >  struct ice_esw_br {
> > @@ -52,12 +57,14 @@ struct ice_esw_br {
> >  	struct list_head fdb_list;
> >
> >  	int ifindex;
> > +	u32 flags;
> >  };
> >
> >  struct ice_esw_br_offloads {
> >  	struct ice_pf *pf;
> >  	struct ice_esw_br *bridge;
> >  	struct notifier_block netdev_nb;
> > +	struct notifier_block switchdev_blk;
> >  	struct notifier_block switchdev_nb;
> >
> >  	struct workqueue_struct *wq;
> > @@ -71,6 +78,11 @@ struct ice_esw_br_fdb_work {
> >  	unsigned long event;
> >  };
> >
> > +struct ice_esw_br_vlan {
> > +	u16 vid;
> > +	u16 flags;
> > +};
> > +
> >  #define ice_nb_to_br_offloads(nb, nb_name) \
> >  	container_of(nb, \
> >  		     struct ice_esw_br_offloads, \
> > @@ -81,6 +93,15 @@ struct ice_esw_br_fdb_work {
> >  		     struct ice_esw_br_fdb_work, \
> >  		     work)
> >
> > +static inline bool ice_eswitch_br_is_vid_valid(u16 vid)
> > +{
> > +	/* In trunk VLAN mode, for untagged traffic the bridge sends requests
> > +	 * to offload VLAN 1 with pvid and untagged flags set. Since these
> > +	 * flags are not supported, add a MAC filter instead.
> > +	 */
> > +	return vid > 1;
> > +}
> > +
> >  void
> >  ice_eswitch_br_offloads_deinit(struct ice_pf *pf);
> >  int


