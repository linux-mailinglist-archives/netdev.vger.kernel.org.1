Return-Path: <netdev+bounces-41785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083477CBE49
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7194A1F22A77
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53CE3D3A2;
	Tue, 17 Oct 2023 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6pYgHWU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6203CD1B
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:59:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499EF93
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697533162; x=1729069162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=whXG8ilW4kViw7KMcvyKqjdTy3z4Svd4k//GFlDibtE=;
  b=d6pYgHWUNQ4Puhkht/q53G3AuWA7nFVHs6fQ1cKITFsHhN6udMJLDRbG
   Ud8QYtb2Bvrb8gOjna3816YtuvqiaZ//lhNmqOwoQm3jTLJbzHGfPvD/y
   rJDXHIwkG7DYV/X9sdEkPoB+9rOVPsQ8wv8Y+T9M/lZktmvK4+DxBRGi4
   Ou/a0pt+lted+BZ5kCBew8zIaXS76VTJDcVIPEiLklC1xp++LNr/tNB2y
   1auYCLjj6OuZZgTCSc8PwdmqyxY6hqChJpoC6vNxyPMjS85kkN6Sqvinx
   FZSGQq+nhGaWIz4ZW6gx2uXjPHFueajSOAcYgud5gurslNJWcdYDScHBj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="385574565"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="385574565"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:58:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="4003292"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 01:58:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 01:58:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 01:58:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 01:58:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 01:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiLmkkRUfkeX0xeIWEmGNcz06K8iAziSYwQvWo18wDYsv4CihtA6lIpp+QNF0M+MiM+pBkfNfEY19KbXRrjwD2VxiTd73SdIh+4VEZ0nIuGagLxE+10jn/5ndLdXzZneuuQacotkxYEqBcyTVyNp69w7snZsl7lwIlFPGgOmELS/a+9jChVv1J3U1LbON8lSEmqDI3YPiY/4AZyy3o/ZjgS+M4/R0a947n4JJDr9G9yPzj9lrtE2IJYdSLEAusC5mn+g3tnKrEUi9auu1JQLa78HWiD3bzyMfpvTj2T6zqbkXEoxTVab+fsCXS8nTqCMsJ06jl2aXpZ08Uq537URyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cvL9DaTDQM1CAIVFeVAlhw6b6dIHsPQ52Vig+68iI0=;
 b=iIrcqJBmYAht7Vdjfp3EbGaCGWuXHCjWU0FsCVbTFS+XiN+apc5KD0Zukbefb1DY2L30UxuNENPMbWUitngl0XUwMw2M1Rw74jLC29bMVu4zrxuhSmEaZVkKcg+QUMNC41Q0ell/lE+xhT7E40nyIfvSu7wowM/T/htokzjjiOayDO/eVXyois9ojFvwfwRs/hu/SLbKmG43XdbMBowm60FznnJRWf6FdwHkRZ2bK49HR2NlVZpJZjng1uZdFHO4fj3bCL5PriGXJ6+OhEbnSXI94I1wHzkew2ge35tWVpBK/V4+uTC1zTRc4hZu30xMm1UkMK2NKBROGmmD5IlW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 08:58:08 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 08:58:08 +0000
From: "Drewek, Wojciech" <wojciech.drewek@intel.com>
To: mschmidt <mschmidt@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/4] iavf: add a common
 function for undoing the interrupt scheme
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/4] iavf: add a common
 function for undoing the interrupt scheme
Thread-Index: AQHaAFEcLKmX0rhQTUOw3ZUFUXBU+rBNriaw
Date: Tue, 17 Oct 2023 08:58:08 +0000
Message-ID: <MW4PR11MB5776312E93F8FF5BED3B4343FDD6A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20231016164849.45691-1-mschmidt@redhat.com>
 <20231016164849.45691-4-mschmidt@redhat.com>
In-Reply-To: <20231016164849.45691-4-mschmidt@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|IA1PR11MB7824:EE_
x-ms-office365-filtering-correlation-id: d5dbad09-01a2-4ba5-fb28-08dbceef2ef5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J/o520RRVWycq0mqsIF8FBdL8StaPcdfNKYlUvnSaueoBVFEog3infz4En58oZfsGyZ/qYZCPjf+AZJe/7k/c75IIlHliCgJDzekIMN227bBGA44oMbs4Qx5nIIlpQ6WMoCdbw5KfwyUqC+SjbBNEE74eE+Xzabu5WPeV0M87xIAi/xTug6VZEPSuw9RPdjP42Iu2o4vf+gqc8ma7513PLBe9gochiiGGD5T6uAB6KHqzwyjfQUfGiLWaYLK3fVs9qRKLymhTujp2H97snUzQEwZ+DoVV4Gg38Goy+hVHRs7dOLlTnC5r6+tW3YFu718BM6HPzOWlzUCkQyhFzK6ZL9RffE5+hGFbuIU19E5amMseEGbGW/ZjEAWgOcRUqygf8x1aGXeu5oklPjLCMyYJCAllQ26VWOMcARcHyGI5JSXJeUlvdiCtib+BktCyP2y4jYoC9ul4WA0bcAC4thmUr5VRGpwRJVNPbjBQXuydT+FfpStB7FMoEDaA40kkZmHUpvZyLt2Qej3pjpxojUhAUrgR6SsEZA/AFAKi0DFaOvf8keDtaIjNY+QeC7zUJmiujBdv3b69b0QO2FhyxV5BHmp3MBxYgMDWy6noeNeGG8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(7696005)(6506007)(53546011)(83380400001)(122000001)(26005)(82960400001)(107886003)(55016003)(9686003)(38070700005)(33656002)(38100700002)(86362001)(2906002)(5660300002)(8936002)(4326008)(52536014)(8676002)(71200400001)(54906003)(110136005)(76116006)(66946007)(316002)(66446008)(64756008)(66556008)(41300700001)(66476007)(478600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kqx1BtDzzorQBC0P3wcB6SDvg1iSZTAWPep9vC7q8Qkpgm2u4zm4GOxbg0le?=
 =?us-ascii?Q?0aEDMVaiu7ebBu7EkfJCihOOabYkJpBHJpIAEIeXtgE/5dMWaF6/yKEU1YSL?=
 =?us-ascii?Q?FXlC6X/Y5/n9jc930t3vEvguGqkAOLzEYEf8w0BYP5mf5Pcq4C9LGM3sHNFq?=
 =?us-ascii?Q?WSsLNSDkxc3YyZXZ1Bt9Xs5M4a6cpDL121VLN+237Rl3E/RLzdWKTGzjw3jY?=
 =?us-ascii?Q?fwfm5J2Wju92rDcB3UyK6BuGRTdKsS21kf4KIBKzJXY+bJ+hlM1FWb70BtN9?=
 =?us-ascii?Q?wJVly44mMWNC7v4RK95Eh9MQwwn0yf23VWLX2dXiQVO3XuchV64kqGV4DyYh?=
 =?us-ascii?Q?vncO0uoyAK1k+2J1g5eINB95EBr+6ldZKU3ThDPm4JX9vmhqEuJvYF8o5QQN?=
 =?us-ascii?Q?6/KZjWZiExr1QOoBBG2jHDYaZa1U2KCO8XnElTdFl8Z7T73Bp0VXbQkyHx4i?=
 =?us-ascii?Q?zTr4dxFTOKWIMeN5RmBYfO8yuUA41iLmX3E3go3v8dz/sCIoIw/GvrJkFeMY?=
 =?us-ascii?Q?Cfdtp7vRXXIq2qtHCDhMBMKNLKel9i1xSrFT4pxPc67lVs12sgf4rAx1yFnd?=
 =?us-ascii?Q?DehgQB7FoCI7YDHh/7+0RrAsxoDwkNs2X2FNiYByL+ODj2PNnd3RyN44Yle7?=
 =?us-ascii?Q?7hNo1h+fj8PjvcNvCIPVF2qVkpdwRlCxlqgVwWiI0WtYocofAwsNcSMO0gNN?=
 =?us-ascii?Q?piSVDBA63YSQhwibGPYeR9mzQymePsRF1KuGqMr7cJQG89+gh/qDQmk9b/oP?=
 =?us-ascii?Q?NjdgvJdjojM4kdTECMMhLFsLbrD7JETWuHUfYG92yKISteCYY01J8MhsCqC7?=
 =?us-ascii?Q?sOLKwp0FE3bmiYRI2mHRXG9xxNXZNLV5GWYegOi8GHOpTlxEGeEnFuPZlUMQ?=
 =?us-ascii?Q?GeatZvcbed9528Rr9gI+Zk+j4x6GTy4PKp9R3BfcsUZEPb8BgTKjTm5Wa6cM?=
 =?us-ascii?Q?6RnBubhSe8OJToRpjbjT1fX2Lsayu5TZr4imPqLgr7igSUmt8vXC53eRbQtZ?=
 =?us-ascii?Q?w8ndQTHgTYg/GG+JnXqaGbWxTveyE6Tbnx7P1Ku9djPyDvW2TOA3Cb1vYqfR?=
 =?us-ascii?Q?eWxCZHYk6M3kC4XqiVEjLeECBbPRe9RCh9Q8LlPh75jS4LM3e6W69gXq7Jrp?=
 =?us-ascii?Q?uPDLVVbdFTO9na+Vp+XEPkVY6HIq16Hm+xOtdxp4xTMEFIKKB2vUCDtj8ycg?=
 =?us-ascii?Q?zLM18vnFPeS8uS2Dj+Oha4q/Jlzpu8mDCxG9NDpaX0l5SYPxHXOjD1azTcGn?=
 =?us-ascii?Q?aOJtqGK6EPBOk7wlZy4dQ5rDhF21Ey+HaXxtC4jxMFMq8iC2zvSvM5vKyfXk?=
 =?us-ascii?Q?MrCCfX5uoXEFsgWDGbI1/uTnn3uvjnorYW6rNCQUHfzwOqiEU/mCOD0wPvBj?=
 =?us-ascii?Q?4W9TkCimm2RmiuVj4/UziD5Sibmzg0yv1ZXlGosBWy7p2nqjJEFmcsnpN+Fp?=
 =?us-ascii?Q?4RlBDtyuMNNCIEunMZG9fxfZOe5kzH53mEeVcZ2gqoRQkCQXuLBg7nSWfak+?=
 =?us-ascii?Q?EDOJ6ZRX4h3jjWwb9v4A5CWnMHC67F/3oM+8/vMXWTCXG4HHZkyIeoIzAv1l?=
 =?us-ascii?Q?IiBhgHoKFV4ypEvpMHIxmWgyrriTxEJUXmE6SDwu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dbad09-01a2-4ba5-fb28-08dbceef2ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 08:58:08.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yerht5KuMCwZ1thaBZb9o7mskQo4DyE+hrqyYzbzAjmxET2G2rr2kxiwiBAxLZPo8zFqyZ/Jmer7KgTjZp4matAatnbIx9FxlZlD8UueqYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Schmidt
> Sent: Monday, October 16, 2023 6:49 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 3/4] iavf: add a common functi=
on
> for undoing the interrupt scheme
>=20
> Add a new function iavf_free_interrupt_scheme that does the inverse of
> iavf_init_interrupt_scheme. Symmetry is nice. And there will be three
> callers already.
>=20
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

I like symmetry :)
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 26 ++++++++++++---------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 6036a4582196..791517cafc3c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1954,6 +1954,17 @@ static int iavf_init_interrupt_scheme(struct
> iavf_adapter *adapter)
>  	return err;
>  }
>=20
> +/**
> + * iavf_free_interrupt_scheme - Undo what iavf_init_interrupt_scheme doe=
s
> + * @adapter: board private structure
> + **/
> +static void iavf_free_interrupt_scheme(struct iavf_adapter *adapter)
> +{
> +	iavf_free_q_vectors(adapter);
> +	iavf_reset_interrupt_capability(adapter);
> +	iavf_free_queues(adapter);
> +}
> +
>  /**
>   * iavf_free_rss - Free memory used by RSS structs
>   * @adapter: board private structure
> @@ -1982,11 +1993,9 @@ static int iavf_reinit_interrupt_scheme(struct
> iavf_adapter *adapter, bool runni
>  	if (running)
>  		iavf_free_traffic_irqs(adapter);
>  	iavf_free_misc_irq(adapter);
> -	iavf_reset_interrupt_capability(adapter);
> -	iavf_free_q_vectors(adapter);
> -	iavf_free_queues(adapter);
> +	iavf_free_interrupt_scheme(adapter);
>=20
> -	err =3D  iavf_init_interrupt_scheme(adapter);
> +	err =3D iavf_init_interrupt_scheme(adapter);
>  	if (err)
>  		goto err;
>=20
> @@ -2973,9 +2982,7 @@ static void iavf_disable_vf(struct iavf_adapter
> *adapter)
>  	spin_unlock_bh(&adapter->cloud_filter_list_lock);
>=20
>  	iavf_free_misc_irq(adapter);
> -	iavf_reset_interrupt_capability(adapter);
> -	iavf_free_q_vectors(adapter);
> -	iavf_free_queues(adapter);
> +	iavf_free_interrupt_scheme(adapter);
>  	memset(adapter->vf_res, 0, IAVF_VIRTCHNL_VF_RESOURCE_SIZE);
>  	iavf_shutdown_adminq(&adapter->hw);
>  	adapter->flags &=3D ~IAVF_FLAG_RESET_PENDING;
> @@ -5206,9 +5213,7 @@ static void iavf_remove(struct pci_dev *pdev)
>  	iavf_free_all_tx_resources(adapter);
>  	iavf_free_all_rx_resources(adapter);
>  	iavf_free_misc_irq(adapter);
> -
> -	iavf_reset_interrupt_capability(adapter);
> -	iavf_free_q_vectors(adapter);
> +	iavf_free_interrupt_scheme(adapter);
>=20
>  	iavf_free_rss(adapter);
>=20
> @@ -5224,7 +5229,6 @@ static void iavf_remove(struct pci_dev *pdev)
>=20
>  	iounmap(hw->hw_addr);
>  	pci_release_regions(pdev);
> -	iavf_free_queues(adapter);
>  	kfree(adapter->vf_res);
>  	spin_lock_bh(&adapter->mac_vlan_list_lock);
>  	/* If we got removed before an up/down sequence, we've got a filter
> --
> 2.41.0
>=20
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

