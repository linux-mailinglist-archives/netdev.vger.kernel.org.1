Return-Path: <netdev+bounces-13142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D13173A6F6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B4C281A13
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F904200B5;
	Thu, 22 Jun 2023 17:07:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEDF200AC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 17:07:59 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E82C6
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687453675; x=1718989675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Z9BEBDfW/xUl4cX8LRihjPipiseZFtKMGi8QZfmmAE=;
  b=Uh1aIYLmHomowAeHlXE2gP5TIsQWOlS7+FFjl0rN6iZOcxhCoZvOvCQm
   s5zw2EGlza579Aok7mwsSz96Ah15636W1UnpudlTHV2EXh7M71gvCG/g7
   tj+JKLZY3+GszuYoaEnnHgKX16qHeDatngo+W6GLyhM8JNyfUBggxaSlE
   gBScLd4t0CrOEGsBCO29FtqVHZERwdhIC1GmsADE8EaFM378kwBbGWswo
   vG/i/U9IhG+wq6KX1TMGEON8vuclcagLsZ8yURPW0pnUr2VMQR6hcNly/
   UT+VghGu4Lv5Va1u06rYJuGhDvVtUEl+GPllkEiLN4k9pR8dUtPxu/esP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="345311936"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="345311936"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 10:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="718179737"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="718179737"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2023 10:07:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 10:07:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 10:07:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 10:07:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boCVbHdpObcmlEaUTcuCpVGGfaKdYYsospkzlIHTSQaGaSNcMqty1eQq5QjqxA60iXaeMU3+sDN/B1zF80AtqHpnV46JFU0+0o0hEJ726EeS9YEAZRV/6BEdeCEytnBTGOXex8JBUWC2XOfPl9s0H71SBZwnbIn2pOYzvsuEHPPZmij9ke2w6n/1QzpcZaXAb0X39/urw7u9oWXVgK06sB8CCfp6Dj7IsB2BxaSszqwzGm3VTG+auThtUxncWWl0nfGA8lnT3sdCc3hbNkdGfCXbIEIhil7FjUD7cP4W0XT/bYFgcVgKQ1RMlcgw6okKMMEO+5XTfwsw2b51Y9A2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcEHXvMwgFrJcEtgbOEpPG1oGx0Vz8UeuIgSVUe48XI=;
 b=BMLuLbbyocaMZ13wzqtSjhps0Mri9c+wrzzhCoke9ByUXk3gFdTfzFbLcL5i5ysyXgxP8dVDHhmwR0S5kmC1t7iWDwB0U6teGEGHhm8ir+3HD/+qslT9B480OksP5tWwjXIQPBNkIq5etwldeZoY0njTm435mKoaeBXIj9dQMt/cT2Lk+x8LA22udQ5E2A/FaM64MVgAlBK+ZaIs8RI7gBfUWzPP4VwCSOB0MFez+aK31+4b8baMUM6/KPqcje1ssaZDAhQ7d/CExHv3yXgSDInON+ksDs1JOk/0b64fwCyhQ+aDJAiO2WWuWBm5vYPQCGEeI7ixcrkGyaZytrDSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 17:07:49 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::7b23:e512:60c9:ce08]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::7b23:e512:60c9:ce08%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 17:07:49 +0000
From: "Drewek, Wojciech" <wojciech.drewek@intel.com>
To: Vlad Buslov <vladbu@nvidia.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	ivecera <ivecera@redhat.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: RE: [PATCH net-next 10/12] ice: implement bridge port vlan
Thread-Topic: [PATCH net-next 10/12] ice: implement bridge port vlan
Thread-Index: AQHZo5+bNuKKNmzf7kSLEU2K4Jxd/q+WvPCAgABTzwA=
Date: Thu, 22 Jun 2023 17:07:49 +0000
Message-ID: <MW4PR11MB5776C22462371A27B358CD96FD22A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620174423.4144938-11-anthony.l.nguyen@intel.com>
 <875y7fvgsk.fsf@nvidia.com>
In-Reply-To: <875y7fvgsk.fsf@nvidia.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|DM4PR11MB6502:EE_
x-ms-office365-filtering-correlation-id: 5c05807f-4b6b-43fd-2125-08db734334f6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bDTZjdYC9d93iw4iUpgTjKpcAXsVbP7cqcGnNOVWjRhaAhe79wt3eu0xU1YCgYzlaXscvDT43mAsYv+f2uni/c/oV22SomNo5GxEUjq9EoP8Mmrnj6bvLYcduf72EjUxZFUmJVwtuJa5pD32itrd4T2smEtLA4pCkPbhH46lWIP0YgUNb0Ki46QJambcte6rSO7i1yt+MUSAiAfK15r7zojpotKf/P79TtgX+JioB+eV+qZHVTAO9TOCRpTZeehQ8vdhpdvwqVuPBKc2qk7Wsx96MWrEj8Lk5Hxh1e3w8GJXnBKeXoUhpCN3FI1UN6HvrqKbz6KoCpgQmqt5eFs+yAwvZZbXUUyGaH2RFEeisv4Pq/558fHkYXurC/F4UZd59uLeEOOqkG4DXcbeyEn1qp+EBnirQ4AS43jyQxQmFu60Z1BOJRTzrgFKcZcxTVWeB2+FlpjbL+kp9B6X2l/Y3koUZ80fTZdU+JvnVe92n7x1krWNFbHsQN5PheA8Qu0IbXjnbjhQdgg9bqDZgmlRCvE+a7ARGjYlZtw8ou6whYzsIjHvrFfiF5BjZSFFkyZJvwZzuJwzoZnb2AVZA7Yo0iFdLaEFt/AJ78Q2rp6EC0TwO+UbDsCB/EbUUsZjLWtP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(82960400001)(110136005)(6636002)(71200400001)(4326008)(7696005)(76116006)(478600001)(54906003)(66946007)(9686003)(53546011)(2906002)(186003)(30864003)(41300700001)(316002)(7416002)(8676002)(8936002)(66476007)(66556008)(52536014)(5660300002)(66446008)(64756008)(122000001)(6506007)(86362001)(33656002)(38070700005)(83380400001)(55016003)(38100700002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UdT4qExnAritAgytyVm//vVmDFEbSxLwvMb+9R3KyT32iKDsMwY3X3D6TCkP?=
 =?us-ascii?Q?jZw5JdJpZ5CbfuCOLuIk7xo2nljlKNp3LEoO6KZP4Suw7w1P8BuA180nCGt9?=
 =?us-ascii?Q?QhKcN3z0kAMQtQKPIw+3VUcZhb9h2bkTBm5cZIijccpE79WqVCwJLPTwYEW+?=
 =?us-ascii?Q?q3TQa4g+ZtwUBztlf+qjKNBFMtpow4p/1O+uCdZuHhUkdRjE/OetKUORrFZl?=
 =?us-ascii?Q?JEVrahlL3MWhmbr7/l4NjMs1bpifyRdDDdZShEb6ERyl5A6ndDaJXdw0ZRII?=
 =?us-ascii?Q?S56PUnnousec8gLWh0VD4zUcn4I++YMRLFlbSRvQaN7qO2zmkVgl942FK0H9?=
 =?us-ascii?Q?iBuaqpwaViumCxasZ3iEdu0SaXyZ/AUQEOvOZWBV78Tg6J5+V5n0L9kCjPG7?=
 =?us-ascii?Q?LaWEHGeeGyCPQfY32l+DzLaAxBIqUDmoyE9dH3B3A1WPs8eixKNAbzSpKGb5?=
 =?us-ascii?Q?AOaW/SpcBzv8jMTNP0dhh9HQYLpBo1aKwk+l3xonikmx/BGgJQnbbpICeKs3?=
 =?us-ascii?Q?Z5uy8oZTKA6t9KYrZyOaXn2KKLJU2A45sQXKvWbj0uyZ2QEsmr5QvOEPfK3G?=
 =?us-ascii?Q?b6ikHheRjtr8DcFbzgKyzTw43gbqdJ1/tKGnQ/mcGvdLMCWc6nxNH3DjNzjp?=
 =?us-ascii?Q?HflAGvFc8otCxx67YiYWfa+6ovi86hJHt9aXFuub6Wko23rp6s1nwElTZ3Jw?=
 =?us-ascii?Q?e/YlCnEDXtUJLwiGM/njpaN5KxYw4vZ21EWGU+YarVXrR6OHiBstwnLECe62?=
 =?us-ascii?Q?VxVz7ShWPYPy3Xpblo1BlkPZYNaP0aGjE2CnBnRkZ3/4D8/aZ/1D0a/+N+Qo?=
 =?us-ascii?Q?TecudF4uQBiH2JStvKLcOt2mWYSxzJuQaz/7tG/wppkh6C3A4DxyMAdaHJoO?=
 =?us-ascii?Q?DhDem8cVRj3QhNrF77uTcxHJdDQqqWqazCHcY4tRJ8Tbo7JnBMoQxqtvqVIE?=
 =?us-ascii?Q?Ld6BRsKI79cqr7BbJcOw155NK+9kjDx+EamRoWFkdUxsZ/Qd82IauFw3imoh?=
 =?us-ascii?Q?i8GVIXtyx9hX8MTZa5gJ5V/Zy5l3ndjw73iGVER6XjppXmdTWRM3BSeiB0wF?=
 =?us-ascii?Q?5ec37MSNk/bLF5fiiAyD4VQYAhY5hdqMgykQtxW5tv2XFsK4ZoBsZnhaf6Zg?=
 =?us-ascii?Q?5KM5p2R0xlBKJFrQAo4cSV07xsXsecY3FoHjQyCj0tKBcVHe4xuPqyKppHmJ?=
 =?us-ascii?Q?33ddC07sXB7cTEn/Lo+NxpFc/Er/MxkD0s/wnJCoWm7GjLznSWEHmffWerKt?=
 =?us-ascii?Q?uUrDPW6RItraBHFAygxlZiSUrQqvUUvEjkRz8tzf0xxPqEM47pMkq3BVRzTr?=
 =?us-ascii?Q?fLUqeIQa6mVHWS2aDquFanx2fC8Bt37Qoib596IXbhGKmMBQHhrt4pR60vTT?=
 =?us-ascii?Q?buN276Awuvp5Di2G0Tqnyg7D0mGuFxvm0Fr6ji/DUfB0O94FPMK1UDGUtxg5?=
 =?us-ascii?Q?GP3jxWQJI5c2nle7dL2YZWup/NbI+x3ChIhgxsCYsXUksynxBcbxin66YQP/?=
 =?us-ascii?Q?8cq/rxs77pFmF9EymrW+z6d7mfz8S3/30GqlAsGaRTcYZvXr523wqJ5r5rMV?=
 =?us-ascii?Q?D7WzTOIXpyI/pMiftcs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c05807f-4b6b-43fd-2125-08db734334f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:07:49.1605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3TLgXr/Gi4OBuuGnfQs03FbwUzSTmbtJ7gZ3JIdSl8upDHuFpbMefbvEW2OxqecJ7piuJGq85dxUN4Fd92tR5qJCbKpmqfbO5QaIimOeyk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6502
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Vlad Buslov <vladbu@nvidia.com>
> Sent: czwartek, 22 czerwca 2023 14:07
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com; edumazet@goo=
gle.com; netdev@vger.kernel.org; Michal
> Swiatkowski <michal.swiatkowski@linux.intel.com>; jiri@resnulli.us; ivece=
ra <ivecera@redhat.com>; simon.horman@corigine.com;
> Drewek, Wojciech <wojciech.drewek@intel.com>; Buvaneswaran, Sujai <sujai.=
buvaneswaran@intel.com>
> Subject: Re: [PATCH net-next 10/12] ice: implement bridge port vlan
>=20
> On Tue 20 Jun 2023 at 10:44, Tony Nguyen <anthony.l.nguyen@intel.com> wro=
te:
> > From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >
> > Port VLAN in this case means push and pop VLAN action on specific vid.
> > There are a few limitation in hardware:
> > - push and pop can't be used separately
> > - if port VLAN is used there can't be any trunk VLANs, because pop
> >   action is done on all traffic received by VSI in port VLAN mode
> > - port VLAN mode on uplink port isn't supported
> >
> > Reflect these limitations in code using dev_info to inform the user
> > about unsupported configuration.
> >
> > In bridge mode there is a need to configure port vlan without resetting
> > VFs. To do that implement ice_port_vlan_on/off() functions. They are
> > only configuring correct vlan_ops to allow setting port vlan.
> >
> > We also need to clear port vlan without resetting the VF which is not
> > supported right now. Change it by implementing clear_port_vlan ops.
> > As previous VLAN configuration isn't always the same, store current
> > config while creating port vlan and restore it in clear function.
> >
> > Configuration steps:
> > - configure switchdev with bridge
> > - #bridge vlan add dev eth0 vid 120 pvid untagged
> > - #bridge vlan add dev eth1 vid 120 pvid untagged
> > - ping from VF0 to VF1
> >
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice.h          |   1 +
> >  .../net/ethernet/intel/ice/ice_eswitch_br.c   |  90 ++++++++-
> >  .../net/ethernet/intel/ice/ice_eswitch_br.h   |   1 +
> >  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c  | 186 ++++++++++--------
> >  .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.h  |   4 +
> >  .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |  84 +++++++-
> >  .../net/ethernet/intel/ice/ice_vsi_vlan_lib.h |   8 +
> >  .../net/ethernet/intel/ice/ice_vsi_vlan_ops.h |   1 +
> >  8 files changed, 285 insertions(+), 90 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/etherne=
t/intel/ice/ice.h
> > index 8918a4b836a2..9109006336f0 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -370,6 +370,7 @@ struct ice_vsi {
> >  	u16 rx_buf_len;
> >
> >  	struct ice_aqc_vsi_props info;	 /* VSI properties */
> > +	struct ice_vsi_vlan_info vlan_info;	/* vlan config to be restored */
> >
> >  	/* VSI stats */
> >  	struct rtnl_link_stats64 net_stats;
> > diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/=
net/ethernet/intel/ice/ice_eswitch_br.c
> > index 805a6b2fd965..d7e96241e8af 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> > @@ -5,6 +5,8 @@
> >  #include "ice_eswitch_br.h"
> >  #include "ice_repr.h"
> >  #include "ice_switch.h"
> > +#include "ice_vlan.h"
> > +#include "ice_vf_vsi_vlan_ops.h"
> >
> >  static const struct rhashtable_params ice_fdb_ht_params =3D {
> >  	.key_offset =3D offsetof(struct ice_esw_br_fdb_entry, data),
> > @@ -573,11 +575,27 @@ ice_eswitch_br_vlan_filtering_set(struct ice_esw_=
br *bridge, bool enable)
> >  		bridge->flags &=3D ~ICE_ESWITCH_BR_VLAN_FILTERING;
> >  }
> >
> > +static void
> > +ice_eswitch_br_clear_pvid(struct ice_esw_br_port *port)
> > +{
> > +	struct ice_vsi_vlan_ops *vlan_ops;
> > +
> > +	vlan_ops =3D ice_get_compat_vsi_vlan_ops(port->vsi);
> > +
> > +	vlan_ops->clear_port_vlan(port->vsi);
> > +
>=20
> vlan_ops->del_vlan() call seem to be missing here (dual to
> vlan_ops->add_vlan() ice_eswitch_br_set_pvid()).

Good point, we will fix it.

>=20
> > +	ice_vf_vsi_disable_port_vlan(port->vsi);
> > +
> > +	port->pvid =3D 0;
> > +}
> > +
> >  static void
> >  ice_eswitch_br_vlan_cleanup(struct ice_esw_br_port *port,
> >  			    struct ice_esw_br_vlan *vlan)
> >  {
> >  	xa_erase(&port->vlans, vlan->vid);
> > +	if (port->pvid =3D=3D vlan->vid)
> > +		ice_eswitch_br_clear_pvid(port);
> >  	kfree(vlan);
> >  }
> >
> > @@ -590,9 +608,50 @@ static void ice_eswitch_br_port_vlans_flush(struct=
 ice_esw_br_port *port)
> >  		ice_eswitch_br_vlan_cleanup(port, vlan);
> >  }
> >
> > +static int
> > +ice_eswitch_br_set_pvid(struct ice_esw_br_port *port,
> > +			struct ice_esw_br_vlan *vlan)
> > +{
> > +	struct ice_vlan port_vlan =3D ICE_VLAN(ETH_P_8021Q, vlan->vid, 0);
> > +	struct device *dev =3D ice_pf_to_dev(port->vsi->back);
> > +	struct ice_vsi_vlan_ops *vlan_ops;
> > +	int err;
> > +
> > +	if (port->pvid =3D=3D vlan->vid || vlan->vid =3D=3D 1)
> > +		return 0;
> > +
> > +	/* Setting port vlan on uplink isn't supported by hw */
> > +	if (port->type =3D=3D ICE_ESWITCH_BR_UPLINK_PORT)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (port->pvid) {
> > +		dev_info(dev,
> > +			 "Port VLAN (vsi=3D%u, vid=3D%u) already exists on the port, remove=
 it before adding new one\n",
> > +			 port->vsi_idx, port->pvid);
> > +		return -EEXIST;
> > +	}
> > +
> > +	ice_vf_vsi_enable_port_vlan(port->vsi);
> > +
> > +	vlan_ops =3D ice_get_compat_vsi_vlan_ops(port->vsi);
> > +	err =3D vlan_ops->set_port_vlan(port->vsi, &port_vlan);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D vlan_ops->add_vlan(port->vsi, &port_vlan);
> > +	if (err)
> > +		return err;
> > +
> > +	ice_eswitch_br_port_vlans_flush(port);
> > +	port->pvid =3D vlan->vid;
> > +
> > +	return 0;
> > +}
> > +
> >  static struct ice_esw_br_vlan *
> >  ice_eswitch_br_vlan_create(u16 vid, u16 flags, struct ice_esw_br_port =
*port)
> >  {
> > +	struct device *dev =3D ice_pf_to_dev(port->vsi->back);
> >  	struct ice_esw_br_vlan *vlan;
> >  	int err;
> >
> > @@ -602,14 +661,30 @@ ice_eswitch_br_vlan_create(u16 vid, u16 flags, st=
ruct ice_esw_br_port *port)
> >
> >  	vlan->vid =3D vid;
> >  	vlan->flags =3D flags;
> > +	if ((flags & BRIDGE_VLAN_INFO_PVID) &&
> > +	    (flags & BRIDGE_VLAN_INFO_UNTAGGED)) {
> > +		err =3D ice_eswitch_br_set_pvid(port, vlan);
> > +		if (err)
> > +			goto err_set_pvid;
> > +	} else if ((flags & BRIDGE_VLAN_INFO_PVID) ||
> > +		   (flags & BRIDGE_VLAN_INFO_UNTAGGED)) {
> > +		dev_info(dev, "VLAN push and pop are supported only simultaneously\n=
");
> > +		err =3D -EOPNOTSUPP;
> > +		goto err_set_pvid;
> > +	}
> >
> >  	err =3D xa_insert(&port->vlans, vlan->vid, vlan, GFP_KERNEL);
> > -	if (err) {
> > -		kfree(vlan);
> > -		return ERR_PTR(err);
> > -	}
> > +	if (err)
> > +		goto err_insert;
> >
> >  	return vlan;
> > +
> > +err_insert:
> > +	if (port->pvid)
> > +		ice_eswitch_br_clear_pvid(port);
> > +err_set_pvid:
> > +	kfree(vlan);
> > +	return ERR_PTR(err);
> >  }
> >
> >  static int
> > @@ -623,6 +698,13 @@ ice_eswitch_br_port_vlan_add(struct ice_esw_br *br=
idge, u16 vsi_idx, u16 vid,
> >  	if (!port)
> >  		return -EINVAL;
> >
> > +	if (port->pvid) {
> > +		dev_info(ice_pf_to_dev(port->vsi->back),
> > +			 "Port VLAN (vsi=3D%u, vid=3D%d) exists on the port, remove it to a=
dd trunk VLANs\n",
> > +			 port->vsi_idx, port->pvid);
> > +		return -EEXIST;
> > +	}
> > +
> >  	vlan =3D xa_load(&port->vlans, vid);
> >  	if (vlan) {
> >  		if (vlan->flags =3D=3D flags)
> > diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/=
net/ethernet/intel/ice/ice_eswitch_br.h
> > index dd49b273451a..be4e6f096d55 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
> > @@ -42,6 +42,7 @@ struct ice_esw_br_port {
> >  	struct ice_vsi *vsi;
> >  	enum ice_esw_br_port_type type;
> >  	u16 vsi_idx;
> > +	u16 pvid;
> >  	struct xarray vlans;
> >  };
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c b/dri=
vers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
> > index b1ffb81893d4..d7b10dc67f03 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
> > @@ -21,6 +21,99 @@ noop_vlan(struct ice_vsi __always_unused *vsi)
> >  	return 0;
> >  }
> >
> > +static void ice_port_vlan_on(struct ice_vsi *vsi)
> > +{
> > +	struct ice_vsi_vlan_ops *vlan_ops;
> > +	struct ice_pf *pf =3D vsi->back;
> > +
> > +	if (ice_is_dvm_ena(&pf->hw)) {
> > +		vlan_ops =3D &vsi->outer_vlan_ops;
> > +
> > +		/* setup outer VLAN ops */
> > +		vlan_ops->set_port_vlan =3D ice_vsi_set_outer_port_vlan;
> > +		vlan_ops->clear_port_vlan =3D ice_vsi_clear_outer_port_vlan;
> > +		vlan_ops->clear_port_vlan =3D ice_vsi_clear_outer_port_vlan;
> > +
> > +		/* setup inner VLAN ops */
> > +		vlan_ops =3D &vsi->inner_vlan_ops;
> > +		vlan_ops->add_vlan =3D noop_vlan_arg;
> > +		vlan_ops->del_vlan =3D noop_vlan_arg;
> > +		vlan_ops->ena_stripping =3D ice_vsi_ena_inner_stripping;
> > +		vlan_ops->dis_stripping =3D ice_vsi_dis_inner_stripping;
> > +		vlan_ops->ena_insertion =3D ice_vsi_ena_inner_insertion;
> > +		vlan_ops->dis_insertion =3D ice_vsi_dis_inner_insertion;
> > +	} else {
> > +		vlan_ops =3D &vsi->inner_vlan_ops;
> > +
> > +		vlan_ops->set_port_vlan =3D ice_vsi_set_inner_port_vlan;
> > +		vlan_ops->clear_port_vlan =3D ice_vsi_clear_inner_port_vlan;
> > +		vlan_ops->clear_port_vlan =3D ice_vsi_clear_inner_port_vlan;
> > +	}
> > +	vlan_ops->ena_rx_filtering =3D ice_vsi_ena_rx_vlan_filtering;
> > +}
> > +
> > +static void ice_port_vlan_off(struct ice_vsi *vsi)
> > +{
> > +	struct ice_vsi_vlan_ops *vlan_ops;
> > +	struct ice_pf *pf =3D vsi->back;
> > +
> > +	/* setup inner VLAN ops */
> > +	vlan_ops =3D &vsi->inner_vlan_ops;
> > +
> > +	vlan_ops->ena_stripping =3D ice_vsi_ena_inner_stripping;
> > +	vlan_ops->dis_stripping =3D ice_vsi_dis_inner_stripping;
> > +	vlan_ops->ena_insertion =3D ice_vsi_ena_inner_insertion;
> > +	vlan_ops->dis_insertion =3D ice_vsi_dis_inner_insertion;
> > +
> > +	if (ice_is_dvm_ena(&pf->hw)) {
> > +		vlan_ops =3D &vsi->outer_vlan_ops;
> > +
> > +		vlan_ops->del_vlan =3D ice_vsi_del_vlan;
> > +		vlan_ops->ena_stripping =3D ice_vsi_ena_outer_stripping;
> > +		vlan_ops->dis_stripping =3D ice_vsi_dis_outer_stripping;
> > +		vlan_ops->ena_insertion =3D ice_vsi_ena_outer_insertion;
> > +		vlan_ops->dis_insertion =3D ice_vsi_dis_outer_insertion;
> > +	} else {
> > +		vlan_ops->del_vlan =3D ice_vsi_del_vlan;
> > +	}
> > +
> > +	if (!test_bit(ICE_FLAG_VF_VLAN_PRUNING, pf->flags))
> > +		vlan_ops->ena_rx_filtering =3D noop_vlan;
> > +	else
> > +		vlan_ops->ena_rx_filtering =3D
> > +			ice_vsi_ena_rx_vlan_filtering;
> > +}
> > +
> > +/**
> > + * ice_vf_vsi_enable_port_vlan - Set VSI VLAN ops to support port VLAN
> > + * @vsi: VF's VSI being configured
> > + *
> > + * The function won't create port VLAN, it only allows to create port =
VLAN
> > + * using VLAN ops on the VF VSI.
> > + */
> > +void ice_vf_vsi_enable_port_vlan(struct ice_vsi *vsi)
> > +{
> > +	if (WARN_ON_ONCE(!vsi->vf))
> > +		return;
> > +
> > +	ice_port_vlan_on(vsi);
> > +}
> > +
> > +/**
> > + * ice_vf_vsi_disable_port_vlan - Clear VSI support for creating port =
VLAN
> > + * @vsi: VF's VSI being configured
> > + *
> > + * The function should be called after removing port VLAN on VSI
> > + * (using VLAN ops)
> > + */
> > +void ice_vf_vsi_disable_port_vlan(struct ice_vsi *vsi)
> > +{
> > +	if (WARN_ON_ONCE(!vsi->vf))
> > +		return;
> > +
> > +	ice_port_vlan_off(vsi);
> > +}
> > +
> >  /**
> >   * ice_vf_vsi_init_vlan_ops - Initialize default VSI VLAN ops for VF V=
SI
> >   * @vsi: VF's VSI being configured
> > @@ -39,91 +132,18 @@ void ice_vf_vsi_init_vlan_ops(struct ice_vsi *vsi)
> >  	if (WARN_ON(!vf))
> >  		return;
> >
> > -	if (ice_is_dvm_ena(&pf->hw)) {
> > -		vlan_ops =3D &vsi->outer_vlan_ops;
> > +	if (ice_vf_is_port_vlan_ena(vf))
> > +		ice_port_vlan_on(vsi);
> > +	else
> > +		ice_port_vlan_off(vsi);
> >
> > -		/* outer VLAN ops regardless of port VLAN config */
> > -		vlan_ops->add_vlan =3D ice_vsi_add_vlan;
> > -		vlan_ops->ena_tx_filtering =3D ice_vsi_ena_tx_vlan_filtering;
> > -		vlan_ops->dis_tx_filtering =3D ice_vsi_dis_tx_vlan_filtering;
> > -
> > -		if (ice_vf_is_port_vlan_ena(vf)) {
> > -			/* setup outer VLAN ops */
> > -			vlan_ops->set_port_vlan =3D ice_vsi_set_outer_port_vlan;
> > -			/* all Rx traffic should be in the domain of the
> > -			 * assigned port VLAN, so prevent disabling Rx VLAN
> > -			 * filtering
> > -			 */
> > -			vlan_ops->dis_rx_filtering =3D noop_vlan;
> > -			vlan_ops->ena_rx_filtering =3D
> > -				ice_vsi_ena_rx_vlan_filtering;
> > -
> > -			/* setup inner VLAN ops */
> > -			vlan_ops =3D &vsi->inner_vlan_ops;
> > -			vlan_ops->add_vlan =3D noop_vlan_arg;
> > -			vlan_ops->del_vlan =3D noop_vlan_arg;
> > -			vlan_ops->ena_stripping =3D ice_vsi_ena_inner_stripping;
> > -			vlan_ops->dis_stripping =3D ice_vsi_dis_inner_stripping;
> > -			vlan_ops->ena_insertion =3D ice_vsi_ena_inner_insertion;
> > -			vlan_ops->dis_insertion =3D ice_vsi_dis_inner_insertion;
> > -		} else {
> > -			vlan_ops->dis_rx_filtering =3D
> > -				ice_vsi_dis_rx_vlan_filtering;
> > -
> > -			if (!test_bit(ICE_FLAG_VF_VLAN_PRUNING, pf->flags))
> > -				vlan_ops->ena_rx_filtering =3D noop_vlan;
> > -			else
> > -				vlan_ops->ena_rx_filtering =3D
> > -					ice_vsi_ena_rx_vlan_filtering;
> > -
> > -			vlan_ops->del_vlan =3D ice_vsi_del_vlan;
> > -			vlan_ops->ena_stripping =3D ice_vsi_ena_outer_stripping;
> > -			vlan_ops->dis_stripping =3D ice_vsi_dis_outer_stripping;
> > -			vlan_ops->ena_insertion =3D ice_vsi_ena_outer_insertion;
> > -			vlan_ops->dis_insertion =3D ice_vsi_dis_outer_insertion;
> > -
> > -			/* setup inner VLAN ops */
> > -			vlan_ops =3D &vsi->inner_vlan_ops;
> > -
> > -			vlan_ops->ena_stripping =3D ice_vsi_ena_inner_stripping;
> > -			vlan_ops->dis_stripping =3D ice_vsi_dis_inner_stripping;
> > -			vlan_ops->ena_insertion =3D ice_vsi_ena_inner_insertion;
> > -			vlan_ops->dis_insertion =3D ice_vsi_dis_inner_insertion;
> > -		}
> > -	} else {
> > -		vlan_ops =3D &vsi->inner_vlan_ops;
> > +	vlan_ops =3D ice_is_dvm_ena(&pf->hw) ?
> > +		&vsi->outer_vlan_ops : &vsi->inner_vlan_ops;
> >
> > -		/* inner VLAN ops regardless of port VLAN config */
> > -		vlan_ops->add_vlan =3D ice_vsi_add_vlan;
> > -		vlan_ops->dis_rx_filtering =3D ice_vsi_dis_rx_vlan_filtering;
> > -		vlan_ops->ena_tx_filtering =3D ice_vsi_ena_tx_vlan_filtering;
> > -		vlan_ops->dis_tx_filtering =3D ice_vsi_dis_tx_vlan_filtering;
> > -
> > -		if (ice_vf_is_port_vlan_ena(vf)) {
> > -			vlan_ops->set_port_vlan =3D ice_vsi_set_inner_port_vlan;
> > -			vlan_ops->ena_rx_filtering =3D
> > -				ice_vsi_ena_rx_vlan_filtering;
> > -			/* all Rx traffic should be in the domain of the
> > -			 * assigned port VLAN, so prevent disabling Rx VLAN
> > -			 * filtering
> > -			 */
> > -			vlan_ops->dis_rx_filtering =3D noop_vlan;
> > -		} else {
> > -			vlan_ops->dis_rx_filtering =3D
> > -				ice_vsi_dis_rx_vlan_filtering;
> > -			if (!test_bit(ICE_FLAG_VF_VLAN_PRUNING, pf->flags))
> > -				vlan_ops->ena_rx_filtering =3D noop_vlan;
> > -			else
> > -				vlan_ops->ena_rx_filtering =3D
> > -					ice_vsi_ena_rx_vlan_filtering;
> > -
> > -			vlan_ops->del_vlan =3D ice_vsi_del_vlan;
> > -			vlan_ops->ena_stripping =3D ice_vsi_ena_inner_stripping;
> > -			vlan_ops->dis_stripping =3D ice_vsi_dis_inner_stripping;
> > -			vlan_ops->ena_insertion =3D ice_vsi_ena_inner_insertion;
> > -			vlan_ops->dis_insertion =3D ice_vsi_dis_inner_insertion;
> > -		}
> > -	}
> > +	vlan_ops->add_vlan =3D ice_vsi_add_vlan;
> > +	vlan_ops->dis_rx_filtering =3D ice_vsi_dis_rx_vlan_filtering;
> > +	vlan_ops->ena_tx_filtering =3D ice_vsi_ena_tx_vlan_filtering;
> > +	vlan_ops->dis_tx_filtering =3D ice_vsi_dis_tx_vlan_filtering;
> >  }
> >
> >  /**
> > diff --git a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.h b/dri=
vers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.h
> > index 875a4e615f39..df8aa09df3e3 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.h
> > @@ -13,7 +13,11 @@ void ice_vf_vsi_cfg_svm_legacy_vlan_mode(struct ice_=
vsi *vsi);
> >
> >  #ifdef CONFIG_PCI_IOV
> >  void ice_vf_vsi_init_vlan_ops(struct ice_vsi *vsi);
> > +void ice_vf_vsi_enable_port_vlan(struct ice_vsi *vsi);
> > +void ice_vf_vsi_disable_port_vlan(struct ice_vsi *vsi);
> >  #else
> >  static inline void ice_vf_vsi_init_vlan_ops(struct ice_vsi *vsi) { }
> > +static inline void ice_vf_vsi_enable_port_vlan(struct ice_vsi *vsi) { =
}
> > +static inline void ice_vf_vsi_disable_port_vlan(struct ice_vsi *vsi) {=
 }
> >  #endif /* CONFIG_PCI_IOV */
> >  #endif /* _ICE_PF_VSI_VLAN_OPS_H_ */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c b/driver=
s/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
> > index 5b4a0abb4607..76266e709a39 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
> > @@ -202,6 +202,24 @@ int ice_vsi_dis_inner_insertion(struct ice_vsi *vs=
i)
> >  	return ice_vsi_manage_vlan_insertion(vsi);
> >  }
> >
> > +static void
> > +ice_save_vlan_info(struct ice_aqc_vsi_props *info,
> > +		   struct ice_vsi_vlan_info *vlan)
> > +{
> > +	vlan->sw_flags2 =3D info->sw_flags2;
> > +	vlan->inner_vlan_flags =3D info->inner_vlan_flags;
> > +	vlan->outer_vlan_flags =3D info->outer_vlan_flags;
> > +}
> > +
> > +static void
> > +ice_restore_vlan_info(struct ice_aqc_vsi_props *info,
> > +		      struct ice_vsi_vlan_info *vlan)
> > +{
> > +	info->sw_flags2 =3D vlan->sw_flags2;
> > +	info->inner_vlan_flags =3D vlan->inner_vlan_flags;
> > +	info->outer_vlan_flags =3D vlan->outer_vlan_flags;
> > +}
> > +
> >  /**
> >   * __ice_vsi_set_inner_port_vlan - set port VLAN VSI context settings =
to enable a port VLAN
> >   * @vsi: the VSI to update
> > @@ -218,6 +236,7 @@ static int __ice_vsi_set_inner_port_vlan(struct ice=
_vsi *vsi, u16 pvid_info)
> >  	if (!ctxt)
> >  		return -ENOMEM;
> >
> > +	ice_save_vlan_info(&vsi->info, &vsi->vlan_info);
> >  	ctxt->info =3D vsi->info;
> >  	info =3D &ctxt->info;
> >  	info->inner_vlan_flags =3D ICE_AQ_VSI_INNER_VLAN_TX_MODE_ACCEPTUNTAGG=
ED |
> > @@ -259,6 +278,33 @@ int ice_vsi_set_inner_port_vlan(struct ice_vsi *vs=
i, struct ice_vlan *vlan)
> >  	return __ice_vsi_set_inner_port_vlan(vsi, port_vlan_info);
> >  }
> >
> > +int ice_vsi_clear_inner_port_vlan(struct ice_vsi *vsi)
> > +{
> > +	struct ice_hw *hw =3D &vsi->back->hw;
> > +	struct ice_aqc_vsi_props *info;
> > +	struct ice_vsi_ctx *ctxt;
> > +	int ret;
> > +
> > +	ctxt =3D kzalloc(sizeof(*ctxt), GFP_KERNEL);
> > +	if (!ctxt)
> > +		return -ENOMEM;
> > +
> > +	ice_restore_vlan_info(&vsi->info, &vsi->vlan_info);
> > +	vsi->info.port_based_inner_vlan =3D 0;
> > +	ctxt->info =3D vsi->info;
> > +	info =3D &ctxt->info;
> > +	info->valid_sections =3D cpu_to_le16(ICE_AQ_VSI_PROP_VLAN_VALID |
> > +					   ICE_AQ_VSI_PROP_SW_VALID);
> > +
> > +	ret =3D ice_update_vsi(hw, vsi->idx, ctxt, NULL);
> > +	if (ret)
> > +		dev_err(ice_hw_to_dev(hw), "update VSI for port VLAN failed, err %d =
aq_err %s\n",
> > +			ret, ice_aq_str(hw->adminq.sq_last_status));
> > +
> > +	kfree(ctxt);
> > +	return ret;
> > +}
> > +
> >  /**
> >   * ice_cfg_vlan_pruning - enable or disable VLAN pruning on the VSI
> >   * @vsi: VSI to enable or disable VLAN pruning on
> > @@ -647,6 +693,7 @@ __ice_vsi_set_outer_port_vlan(struct ice_vsi *vsi, =
u16 vlan_info, u16 tpid)
> >  	if (!ctxt)
> >  		return -ENOMEM;
> >
> > +	ice_save_vlan_info(&vsi->info, &vsi->vlan_info);
> >  	ctxt->info =3D vsi->info;
> >
> >  	ctxt->info.sw_flags2 |=3D ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA;
> > @@ -689,9 +736,6 @@ __ice_vsi_set_outer_port_vlan(struct ice_vsi *vsi, =
u16 vlan_info, u16 tpid)
> >   * used if DVM is supported. Also, this function should never be calle=
d directly
> >   * as it should be part of ice_vsi_vlan_ops if it's needed.
> >   *
> > - * This function does not support clearing the port VLAN as there is c=
urrently
> > - * no use case for this.
> > - *
> >   * Use the ice_vlan structure passed in to set this VSI in a port VLAN=
.
> >   */
> >  int ice_vsi_set_outer_port_vlan(struct ice_vsi *vsi, struct ice_vlan *=
vlan)
> > @@ -705,3 +749,37 @@ int ice_vsi_set_outer_port_vlan(struct ice_vsi *vs=
i, struct ice_vlan *vlan)
> >
> >  	return __ice_vsi_set_outer_port_vlan(vsi, port_vlan_info, vlan->tpid)=
;
> >  }
> > +
> > +/**
> > + * ice_vsi_clear_outer_port_vlan - clear outer port vlan
> > + * @vsi: VSI to configure
> > + *
> > + * The function is restoring previously set vlan config (saved in
> > + * vsi->vlan_info). Setting happens in port vlan configuration.
> > + */
> > +int ice_vsi_clear_outer_port_vlan(struct ice_vsi *vsi)
> > +{
> > +	struct ice_hw *hw =3D &vsi->back->hw;
> > +	struct ice_vsi_ctx *ctxt;
> > +	int err;
> > +
> > +	ctxt =3D kzalloc(sizeof(*ctxt), GFP_KERNEL);
> > +	if (!ctxt)
> > +		return -ENOMEM;
> > +
> > +	ice_restore_vlan_info(&vsi->info, &vsi->vlan_info);
> > +	vsi->info.port_based_outer_vlan =3D 0;
> > +	ctxt->info =3D vsi->info;
> > +
> > +	ctxt->info.valid_sections =3D
> > +		cpu_to_le16(ICE_AQ_VSI_PROP_OUTER_TAG_VALID |
> > +			    ICE_AQ_VSI_PROP_SW_VALID);
> > +
> > +	err =3D ice_update_vsi(hw, vsi->idx, ctxt, NULL);
> > +	if (err)
> > +		dev_err(ice_pf_to_dev(vsi->back), "update VSI for clearing outer por=
t based VLAN failed, err %d aq_err %s\n",
> > +			err, ice_aq_str(hw->adminq.sq_last_status));
> > +
> > +	kfree(ctxt);
> > +	return err;
> > +}
> > diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h b/driver=
s/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
> > index f459909490ec..f0d84d11bd5b 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
> > @@ -7,6 +7,12 @@
> >  #include <linux/types.h>
> >  #include "ice_vlan.h"
> >
> > +struct ice_vsi_vlan_info {
> > +	u8 sw_flags2;
> > +	u8 inner_vlan_flags;
> > +	u8 outer_vlan_flags;
> > +};
> > +
> >  struct ice_vsi;
> >
> >  int ice_vsi_add_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan);
> > @@ -17,6 +23,7 @@ int ice_vsi_dis_inner_stripping(struct ice_vsi *vsi);
> >  int ice_vsi_ena_inner_insertion(struct ice_vsi *vsi, u16 tpid);
> >  int ice_vsi_dis_inner_insertion(struct ice_vsi *vsi);
> >  int ice_vsi_set_inner_port_vlan(struct ice_vsi *vsi, struct ice_vlan *=
vlan);
> > +int ice_vsi_clear_inner_port_vlan(struct ice_vsi *vsi);
> >
> >  int ice_vsi_ena_rx_vlan_filtering(struct ice_vsi *vsi);
> >  int ice_vsi_dis_rx_vlan_filtering(struct ice_vsi *vsi);
> > @@ -28,5 +35,6 @@ int ice_vsi_dis_outer_stripping(struct ice_vsi *vsi);
> >  int ice_vsi_ena_outer_insertion(struct ice_vsi *vsi, u16 tpid);
> >  int ice_vsi_dis_outer_insertion(struct ice_vsi *vsi);
> >  int ice_vsi_set_outer_port_vlan(struct ice_vsi *vsi, struct ice_vlan *=
vlan);
> > +int ice_vsi_clear_outer_port_vlan(struct ice_vsi *vsi);
> >
> >  #endif /* _ICE_VSI_VLAN_LIB_H_ */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.h b/driver=
s/net/ethernet/intel/ice/ice_vsi_vlan_ops.h
> > index 5b47568f6256..b2d2330dedcb 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.h
> > @@ -21,6 +21,7 @@ struct ice_vsi_vlan_ops {
> >  	int (*ena_tx_filtering)(struct ice_vsi *vsi);
> >  	int (*dis_tx_filtering)(struct ice_vsi *vsi);
> >  	int (*set_port_vlan)(struct ice_vsi *vsi, struct ice_vlan *vlan);
> > +	int (*clear_port_vlan)(struct ice_vsi *vsi);
> >  };
> >
> >  void ice_vsi_init_vlan_ops(struct ice_vsi *vsi);


