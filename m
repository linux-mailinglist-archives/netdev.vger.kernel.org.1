Return-Path: <netdev+bounces-39622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C006D7C02B7
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2C3281B59
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26BE2744F;
	Tue, 10 Oct 2023 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTz0NUhz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794B2136B
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 17:28:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E71810F6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696958903; x=1728494903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IeCqrsnC4AxBG8OqDa7iF1BTuN4yOwmab+hgdN8Pzh0=;
  b=YTz0NUhznx7GAnKg6OzHuCgpYbpTMSqXXvdzCG10YexDE0lFG8QMgqOO
   qrgymra5xnHKFPD1UcXTu+gOjycKcAD72r1vtQOQ0CE6VNuNOTgd7pF3/
   7RaayH23zPr6GYUOBNViZppfYnPMlO/fxPAAHo+Ie07lVJezC1NqoMm0R
   0tNOXLPQpa2WqtN5sY41RISA4n9qkk2ZVIOfUakz5gdmSF4mrrzfL7t8B
   wEjz/n9VUQGo94lWEZba6UTeZEX+XOgywJt1EUV6WkPJC8vOXA1APvomE
   ozoPHOgEJUXhs8n5A7qhK2FujQvf8xK0oiLFZEHk1UHYde80EvGbdpC6R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387299507"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="387299507"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 10:28:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1000787062"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="1000787062"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 10:28:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 10:28:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 10:28:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 10:28:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIN4ZTt1G4Cjz8uQBT2yZDqnTPGEwoaEgVD5xsWs6xhwzSt4R5cLIWVSGztBmpFKW+faD29cJ3+m/uYMWYKVQRRIa2MxDN3GwS+3vMhX/QuaoU/hPLYSqXaWz9TJ0+Ba76/lHEM4O30WC66zlof3QM1VCx4NtbiORM0aUXNUuUrdSiDdUKBJnfwBYRxrY4Jne74kCw4Sl/y8u1HbY696Gqgsd56pnIpy5q2J1Li+EW/+afxHqbjSX2fT+noPLBZpZgHgbA3mJhvXOfIV75pHSGaSr8Zno98hFf/FlpubMGorJImm/7cyLpGqm6l1EbiUNmOT7oij+aOB/CPw/VICYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7elNhy1Gi1yd42GHdqbDx0iqtDYNfSKoyQPg595se4=;
 b=URk507DdzLdoNyDFUdYy2w57O4W8PUxcpRA9wsM7vZ5rR2I/8oeWT7T+PMLs1smu6Nwcx+51YC6/itQFQKi/538xlhq1nQvog1c9x+yRbiyQ4Q7ZoKoPY1dlJW6qD3jE/bh8DtylgqiMbIUuOoZFLmV0+K166dxxUWT5DO/6bMSu58WChwOIhonNU4h1M+hmXGhWtylRsR9n0dxKvAwIRG9NmspRamwV7hKIkw2yuBs5xlhIwFx0436ZDt3qH5x3+WFZ929MrkbUdCYWfTulBaPGhRj8uVcX9QYqqGDIdCr5c/UrUqrQcVsiFgHBiM9PW/52MgEujVfO7BsN1jWCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by SA1PR11MB6759.namprd11.prod.outlook.com (2603:10b6:806:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 17:28:11 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f611:cea8:26fc:3c88]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f611:cea8:26fc:3c88%4]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 17:28:11 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next] ice: Fix SRIOV LAG disable on non-compliant
 aggreagate
Thread-Topic: [PATCH iwl-next] ice: Fix SRIOV LAG disable on non-compliant
 aggreagate
Thread-Index: AQHZ+fEefLLrPevLxEOsMaX2+06rDLBDSibA
Date: Tue, 10 Oct 2023 17:28:11 +0000
Message-ID: <MW5PR11MB58119DD5B9580265161BACB1DDCDA@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20231006210211.1443696-1-david.m.ertman@intel.com>
 <20231008140934.GI831234@kernel.org>
In-Reply-To: <20231008140934.GI831234@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|SA1PR11MB6759:EE_
x-ms-office365-filtering-correlation-id: 87da64dc-6e71-458b-16c0-08dbc9b6471b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u6WvG+IqPpBmAFHGltE8TmN7R8uq6WxTq4YqtSytDUrH6kUOL//C5UOasvVAXCwZIrDoYFHMN11LNmnjwTGOZkGEyzDx7x5dnfciZqMwYtrcZ60WqbTLX1PclufN2m7vQsaz0GcXcR7C48X2FQ5XbuAAjCg9yQceL/0HCrNneS4ym7SIBTzcoNnz3lmnmC8OWaJt+gBomy7EWaFLc44treET4BferjhY56hyzG8eCil8qmRV5b3hxtjRI9Ny+lAZ2qZwgWWfnM0qnHeRmnr1KrRYbtua9Q5mZ1pGHxt37QAff3oAN/Uua1be7JmKQB6p6krWj6Z7fTrcnXNrM73RUnKK2PCwgDwz8T7h0np2/w3ItAss2I3eaiwKcDcWy3e5jZIAwC22kZMqYQQTSuF3u3HYp7kC/GmNsUjLOaFhgbmM7VTgHacy6eiZMcc/Mk9YhVhctmTpJrMCtRD4G71/uLgpG1pn8l+v+kGsq1ncOlWCWHayKowtnfaxh2o/OD7F5d7fNTkY+QcgI7OZTOhGEMRVdM39g99spnfRxOWw5upGnLpQLmkbWOUs5eUmtKxwfhl/zsUX6C3B8VpKlYku8lEr51JhB8JVsaqnOjEtHwipWQXBCQJNinxswHZMWpim
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(53546011)(9686003)(33656002)(82960400001)(38100700002)(55016003)(86362001)(38070700005)(122000001)(26005)(2906002)(83380400001)(71200400001)(7696005)(6506007)(478600001)(6916009)(8936002)(8676002)(4326008)(66446008)(316002)(52536014)(41300700001)(64756008)(5660300002)(66556008)(76116006)(54906003)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UCPrluTooIeGq3fqPdxJMdjxjxZmdvaQwtmH5vJn4V5rJwHNyds5zkuUNprC?=
 =?us-ascii?Q?/I6RVt1G+eGxr2cxVGus1iRggHynAsgYVIUCMcTwu8YrTSJ3l1SCN7Hcr7IO?=
 =?us-ascii?Q?agKId1FGEfnFCHzahI3if8Fus16VML+tQMtyun4zTQpJYZDxpuiXeuM7iXlP?=
 =?us-ascii?Q?zQA3k1LBOw39FaO2hgd4tiFFz2Jt8RM09HJXyOvgyovFjVVE2GS5luT+rzdZ?=
 =?us-ascii?Q?uyOH0TK/gAHI5Gbd1FPeRfHRY7JsReMuN/3kvRlsALK1MxLNgQFhLsWjDpo7?=
 =?us-ascii?Q?v6EAVBH+I+6Lu8IMk65DKp6tFfDQ7P5gIHI30wxRCOOuGnDiY8ZYKdWxptd9?=
 =?us-ascii?Q?gMW0uvNcDQ9iE3GxkcX0NOrvtVJwlrn/kfp8xZVAkM23TAMJb4eADc8tNPHf?=
 =?us-ascii?Q?iwpsaQfc0L3ZFBrDOuQwPR0kkyRlgs5qwP2RQBKKgmYFnSMdcOqL7ZLL3Tkt?=
 =?us-ascii?Q?svb/XeuxvGaKz3kLJ8VkT0KsjNDQHqQBgqfHGby0a07JL0s5K8GrAbMEDaQy?=
 =?us-ascii?Q?gWrRcO34s0dY81Xxr3AgfEkmyDOb81Jh2iPBqTAcnb6zmUh74MNzfoSo2pOd?=
 =?us-ascii?Q?1d85gLiTwct69OLNogqoTB4NwQDJDUHqODOI23hBu0bdGtAbmqw8eQZdwACx?=
 =?us-ascii?Q?bl4PSmpHPIfyooK1n0VVjL9xunBOhxEjiKkyazjJHclHk7hb5wfr6hBOmpW6?=
 =?us-ascii?Q?lsRYkoEXpuSHZfzJ5dj5TZbvoxnDteeFY+l8AdXFrPZpEVaoRokswsIHy8ZG?=
 =?us-ascii?Q?3fRRWkC1QFjxT68GOwXdOPIW9M364YjLdo4g2vo6s9phq20/RWz3f4C64Zqx?=
 =?us-ascii?Q?oMNeTSNMBF0hvyA9dA7h4X0t8W4SxhDAtLIfAOsgk0CBalJlH5FZ4JcunKqr?=
 =?us-ascii?Q?LCP+BIKLS4Sp5gWVVKt2yHDT7HL+vvSSHVkHdpsQ/NC6enf1dUUUY4DZuWYL?=
 =?us-ascii?Q?fqu66LKGev5qciFWDMMNEBHF+XtjEyDyscUDFC+9hvcFiEdhF4Dida8IFv1K?=
 =?us-ascii?Q?0z5/UJEJPH65akJQrj697OHlAl7qsntUPeJOR7FqE0ln2qEoOla583Gi9w1V?=
 =?us-ascii?Q?ImHI4FPXtpHLEzU6xlrTSf0t5ifOjxJU+NDqsEhmd5XO5imzo6Ljo45xHujN?=
 =?us-ascii?Q?6oHle62PgSk1vfNTvBfopJJrksz6ulIDzorFNebNajRnp3r5NiHO4dHyYl9N?=
 =?us-ascii?Q?IFIr3/VRX3WRKQU3MmmBYkeIEAoMWDeoNBExcSDdB/aNS033J6PSdbq1uCkj?=
 =?us-ascii?Q?A0xoUMd/2wc0V4dgC2Kmu7GMFRiS+puCCIaFSMQtbhVjhUOYKuMBeHLk5JNQ?=
 =?us-ascii?Q?9NaPL3eYGmdODkLQIt3GlO98qgXPvqURel7MxLC+X2yo/yAlvESdEP2ySVZ2?=
 =?us-ascii?Q?zyvtcU+GNC4bjQeFiyrjlglmbdJNekwoTIim/p2prdeOeUt/fSvfy/sYGqRY?=
 =?us-ascii?Q?Pog2bz9zkwVpHxlRmIdApqNOD2G90akom8uRpEEEILL+SfsiqmCndrBHR5RL?=
 =?us-ascii?Q?xvfZYRqQ/S5eH363aa3IEVL25J6an/7lzZufTikyjYyCS4eVk1KRJpg5C+aE?=
 =?us-ascii?Q?9w1cNQbFkA700kcq6a24Q1sslEtz7CXAdE+e0dE4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87da64dc-6e71-458b-16c0-08dbc9b6471b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 17:28:11.6713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThAlu5IjCGuwfGvHVFQ7bT6XucgNmaFeTtINu5gSWou/NbS35k49g+Rd0chdL4Zbgp+Rif4FIMmvmx2ur4JPZUZfbiCQy57YOXPhqfgg/GA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6759
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Sunday, October 8, 2023 7:10 AM
> To: Ertman, David M <david.m.ertman@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Subject: Re: [PATCH iwl-next] ice: Fix SRIOV LAG disable on non-compliant
> aggreagate
>=20
> On Fri, Oct 06, 2023 at 02:02:11PM -0700, Dave Ertman wrote:
> > If an attribute of an aggregate interface disqualifies it from supporti=
ng
> > SRIOV, the driver will unwind the SRIOV support.  Currently the driver =
is
> > clearing the feature bit for all interfaces in the aggregate, but this =
is
> > not allowing the other interfaces to unwind successfully on driver unlo=
ad.
> >
> > Only clear the feature bit for the interface that is currently unwindin=
g.
> >
> > Fixes: bf65da2eb279 ("ice: enforce interface eligibility and add messag=
ing
> for SRIOV LAG")
> > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lag.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c
> b/drivers/net/ethernet/intel/ice/ice_lag.c
> > index 2c96d1883e19..c9071228b1ea 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> > @@ -1513,17 +1513,12 @@ static void ice_lag_chk_disabled_bond(struct
> ice_lag *lag, void *ptr)
> >   */
> >  static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
> >  {
> > -	struct ice_lag_netdev_list *entry;
> >  	struct ice_netdev_priv *np;
> > -	struct net_device *netdev;
> >  	struct ice_pf *pf;
> >
> > -	list_for_each_entry(entry, lag->netdev_head, node) {
> > -		netdev =3D entry->netdev;
> > -		np =3D netdev_priv(netdev);
> > -		pf =3D np->vsi->back;
> > -
> > -		ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
> > +	np =3D netdev_priv(lag->netdev);
> > +	pf =3D np->vsi->back;
> > +	ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
> >  	}
> >  }
>=20
> Hi Dave,
>=20
> unfortunately applying this patch results in a build failure.
>=20
> --
> pw-bot: changes-requested
>=20
>=20
Sorry about the mix-up.  I fixed the braces issues, but then sent the wrong=
 version of the patch out.

Correct version on the way with v2.
DaveE

