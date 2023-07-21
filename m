Return-Path: <netdev+bounces-19966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61175CFF9
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462D72823AC
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE141F93A;
	Fri, 21 Jul 2023 16:45:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5F27F00
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:45:46 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1DE10D2
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689957942; x=1721493942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=suDHu0TE/ysXunXnmJgkX3zEUCjQZE7uXhDOjNfvego=;
  b=i6909s4CzUCiQvzcHiOAYPgi8ie+6QmGlD67AdFW4hJPi91rwHK4k4Vt
   kL3eyjielhv+vOaNixHwEq5UFEwYWordC1xJpRRpOPQFpZbctHipNFxMk
   b/t/8YZRyiTaN+I0ZPVOZtb38bVv18QACZdbG9/jh26/J2n5n6TqTiqi2
   PAP8PIWYgWxmmvn58winuHlHOChkSHBbvyIvDF4tIChBySJZp3waNKFf2
   drk4umZBYOFI6hvbCwnjYruH7CDS6uYT4OuoShlxyoJSFPMih8Fj1k6FW
   9zVC2xu/fswFEg2MCS+s3GFjuu0ppAP/ol+QRy2P/kK1UMW4jtolFkD7M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="351947411"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="351947411"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="898759424"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="898759424"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2023 09:45:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 09:45:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 09:45:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 09:45:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 09:45:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTE/chVeD2GADUVdfRzhznpRmQj3S7tdo7FQlFBFIN5qOR+cCqUdtrn9rkhxR05NjxobRxm8af6Gqo0Q2Fpb6KBkli2zxMhJiNmRq/92VAi+xa6pZB4KjdFAzBxVixjvPFN0b6dNCmgnBDZCZVt7L9D2n7vz6FuT3hFyNx+FwHiEuH7SneLRUOg16h/dFnHVspjv0pV0oqqYsdMr+vPd68DnaxbQ4lhadJPaWeJtHLP0Wo/Kq++bpDAsEXTotP0AZjNDBlB/WkU+A2AQXiUATAwc+NrmgmeTnD3TOetDqDESPTLjx6jVCldKiOqPLn/EJ1sxuthabdgYefNfwtNDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq6qAL6kCMPRKeVsrvgBUvc54AXp+Gua6QpSQll2lpU=;
 b=AEcMDt7SkoZ/vbpMOTxJpv2kxEf4GybQbX8ve9f++HZF9s+XuKrErSj5Des8lU3X1F+XnJ+vDuE1qldR8FhwEgUekPF83hhY+qDzdQuc8OwyP5Xr09AnKU68/V8RaoLXrEqh2xl+xacBBarZDAWLPGxL0F2DskIJWlNuqyE2BqqmunP+VcU+4FMdik9SmNR+Uae/AYR2t358TocmUXLWL0zVRWe2Qd1sA2JrAbRKdT6m96KcWUiJkaVOJoQvCg6NH2tYQrUjH50lWcDwvRS9mHOxjgGlAdIZspybYY45tevop72RaOGtG3FKS5E+Qkb+get3cbvIxBl3X48kUaVeAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 16:45:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::cb4c:eb85:42f6:e3ae]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::cb4c:eb85:42f6:e3ae%7]) with mapi id 15.20.6609.024; Fri, 21 Jul 2023
 16:45:33 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>
Subject: RE: [patch net-next] genetlink: add explicit ordering break check for
 split ops
Thread-Topic: [patch net-next] genetlink: add explicit ordering break check
 for split ops
Thread-Index: AQHZuvtP8rYroMSi0km86Oyq1DEvDK/Eb3Vg
Date: Fri, 21 Jul 2023 16:45:33 +0000
Message-ID: <CO1PR11MB5089ADDBFA04502A6F7D56ABD63FA@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20230720111354.562242-1-jiri@resnulli.us>
In-Reply-To: <20230720111354.562242-1-jiri@resnulli.us>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SN7PR11MB7566:EE_
x-ms-office365-filtering-correlation-id: 26e4c0e6-21a0-499b-1e08-08db8a09e713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xtlw39imANa3wlivlZKJvz9p0PlF1eLyDJ/64CLAd8JbTSkJJc2lZWgQNOfad/kAFcIHbRfgJhzHi+ZlhGgkoZTNC2cgzcBbGrJ6HEtK+ze1+SdI+RM0YiJ8qGFyOTyxnSO7wgrUq8KNIVzjqQP4p68yh2bFZnN/eX4+2++KTwZ3w4MbqXERpXhxzwBQSD4OdSfzJjBe40vzuJQ/C9R4r4IQjMHFHsSyiwc5fH54tUW4VjHiY4fbWQ70eVN1h1ABT2rBdZfRjB8UQkdvAw8fAEimkEGuwmXrBjeAvv14JjKO3XmPpFOVBjYEUCRpjQNhXMgV1qO0/Ls/pTSL6QZus5lQFjpOdP08VLwW+RgNSeeTNrPUuxChHAtfJOcmviPfZDgpyZMA1dx4aMLB2st+M135SbpVTEYCJu1eIKmGxR/pTqYbhpR4pppVFI3oo0SGlEylc168b9BMUJKs2TsZNG9EH08P0l0aivvKcpmaJEN3u8wzZU2UfNbVzeL1LSizZkaDEnBAdHQEqcze67stw8Rk2hGCFk/6+izif2bt+jLa7zgJvsm+ITvFALctI0RlhWYGLtdLx5TToPhE6nXjlkMSEWLO9NaSB/fRFroaLb+EPkiyrgd+DIGLxcoCTcZ5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(55016003)(82960400001)(38100700002)(53546011)(26005)(186003)(71200400001)(6506007)(316002)(83380400001)(64756008)(66476007)(66446008)(66556008)(76116006)(4326008)(66946007)(8676002)(52536014)(7696005)(5660300002)(41300700001)(8936002)(9686003)(54906003)(2906002)(478600001)(110136005)(33656002)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ndw0voeg1ht472Wuu476TlcGvmZpXZ0SAvIHqG14IID+eBBMrhBUPVqmZTE?=
 =?us-ascii?Q?lhRVGgHWlzfEYJDLoNnJvNWr+vLWqvCrru7JNKup0V4sFznGy+Gmv/ei7ekg?=
 =?us-ascii?Q?gNkRCXyUeQCyePFb8pzs0v4fm1e/jhNPfEoFVDrXrZg0wxHHpReJ3oH+7Ir9?=
 =?us-ascii?Q?RXQzg2aZvOYomP5lXWku0wltf7YcdMiPJ6NCtJoA5UAO9Q7qImjS2tpuB6G9?=
 =?us-ascii?Q?cT7aVE0wcn1gXjj/waSDbHVDatk4xorrwStGJIH8XsMV1rttsM9OLR3lQ7rg?=
 =?us-ascii?Q?hsv5k6BR50/j1ctaDo250xFec1u1O1i07qy/K1IcdhlA9F3ldB0OFmb4O4sj?=
 =?us-ascii?Q?V8reeEOVJCt+iNCocvDF3NZd9Vj+y/R2lLaRTXVr+On98sxMoN0T4stHLd0j?=
 =?us-ascii?Q?LEjfV/05IID+G6MweFfA7uAiJgq5Octb+ZGza1UJFMSZsPU3dNb0twIx+95y?=
 =?us-ascii?Q?gISM/KIFv16zbZ8BZls9z5ef151HLdToBuhkPm6Kt5PdXkZHseTkVPAeTnmP?=
 =?us-ascii?Q?wF1Kd+PApcW3tmMXD6swSKDKBwXOuAWNcjpcEDvnhkFJaALMde4D0+NJ4Axn?=
 =?us-ascii?Q?xGRKvmLHuUhA0gsYb8S/t4MDxO8QtILFpW8xvZ7kKsHft+eqq3Yma2PFH5cw?=
 =?us-ascii?Q?n7znA4iEQAbwWvppLJpLyZwMdiH27RVOPPSBDTyh6awVYYKQmoo2QTVyti03?=
 =?us-ascii?Q?8kSfhVbgWVmVFqBawzO8qYQSRPEHlp/Kwk0J0QkDt3AFELp/NkA0LJLkQqk9?=
 =?us-ascii?Q?WmPEMWqVlBAaUuoxUjCdsTFhjevFoO9LZb+Pt8nHjV2FImXDDpFgHpx2zbt/?=
 =?us-ascii?Q?6+RpULWj7yP6tosS/RTULBvTwW1wrhVtT8kU+fchgqjjV7k1DgI0rAMcmd8r?=
 =?us-ascii?Q?WcUXMPmxD2e1humMwpH833FX7TRmNe27Z9DZpzENewl7j1PywWQpg27H/pkt?=
 =?us-ascii?Q?yORRL9aowCHCTWLaeSolEgrVtpCDtvbbnslfTeLOgBE3yMNTVn3t4HjZMSy2?=
 =?us-ascii?Q?RLk8FIaB40zD4O78v/B8v/cMsH7Wx22ng1NUKULcGwqb89XhHrpbsPzhk7iL?=
 =?us-ascii?Q?87rWfZY90mjLC2+Q/EX0qaZCrLm+SvHNNkteh/oKm1vFCjlxVz/YVXSaQ2m7?=
 =?us-ascii?Q?ji7Bya+49zcQuO20ypmkr4zsBigBTW8K3nDRbiAsafi/ySBKLv5Lqpc3aZ3r?=
 =?us-ascii?Q?aASUAUgI9yFwFKogKwCYXkTx9GFEPHOuwOm+PZnIT1EsIb/LY/mcCCyHJPvf?=
 =?us-ascii?Q?oCaDNkR9wLigHwxJUDMmZQhkf1USqAYMy6uPYPlP4NonguoT4dRt2pgU1eud?=
 =?us-ascii?Q?fYU4v+VtK/dxgN7Kl/tzGbpLYn+JvjKkUwOgX8eeQWfa0IUZgxRVZrH2dfD7?=
 =?us-ascii?Q?Kl6rZ2G0zinf8CEbVCGjCpxeMzHDt1Ox/5S06qTnW38gfuT/CCH99XN2KQsl?=
 =?us-ascii?Q?SkTn6lHwVXHW5aJ7c9F27snVtFz/Q1UYNGGccCY8WtrK7H+4TlpyLVnwFUDj?=
 =?us-ascii?Q?dSmPiZnnyplVh9R8M2szlM6qbhWXM5usZXtQWJr4M/jR86nGlSDXm9UMoCIB?=
 =?us-ascii?Q?YMu1Sg5LsIygHxk8FPLj5jQc+6V5bm7rXA6dol+V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e4c0e6-21a0-499b-1e08-08db8a09e713
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 16:45:33.8987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAJTWAHAOLNWuoiNa19+o62IYQ8cCgK8W6TvrM35M5NwBpUcQPNiDhkf4nvQyeW/eZ81NGUdezvGOs0r0c0w0yx5yJe/lsrjdKOurk425ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7566
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Thursday, July 20, 2023 4:14 AM
> To: netdev@vger.kernel.org
> Cc: kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net;
> edumazet@google.com; Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [patch net-next] genetlink: add explicit ordering break check fo=
r split ops
>=20
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> Currently, if cmd in the split ops array is of lower value than the
> previous one, genl_validate_ops() continues to do the checks as if
> the values are equal. This may result in non-obvious WARN_ON() hit in
> these check.
>=20
> Instead, check the incorrect ordering explicitly and put a WARN_ON()
> in case it is broken.
>=20
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>


Good fix.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  net/netlink/genetlink.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index a157247a1e45..6bd2ce51271f 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -593,8 +593,12 @@ static int genl_validate_ops(const struct genl_famil=
y
> *family)
>  			return -EINVAL;
>=20
>  		/* Check sort order */
> -		if (a->cmd < b->cmd)
> +		if (a->cmd < b->cmd) {
>  			continue;
> +		} else if (a->cmd > b->cmd) {
> +			WARN_ON(1);
> +			return -EINVAL;
> +		}
>=20
>  		if (a->internal_flags !=3D b->internal_flags ||
>  		    ((a->flags ^ b->flags) & ~(GENL_CMD_CAP_DO |
> --
> 2.41.0


