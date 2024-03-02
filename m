Return-Path: <netdev+bounces-76777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737986EE99
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 05:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB321F21F7D
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 04:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF51C20;
	Sat,  2 Mar 2024 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akNtq2jl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693218E
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709354032; cv=fail; b=NV6n43axQNTj2LvDjJx3dws9ddXQGVdb2A7G4srXM6WbhWFOUxb3qvGjxS+/FVVMN+WZQ+VDy18Ya7b3+HVIEfUkPn4HKxMqRz92XPv0T2KP36/AIKA64+1Ql7u/25xgInqO0/rrvnCjfV+yEVPheXPQcgSIAggkdSHdINOWFEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709354032; c=relaxed/simple;
	bh=LrHgiTN6NP8q4eoKIQHlIBb3DB2VYF5SqDtYBtquneo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YV4S1mqGk9ez+6BjF+a5LuLRF8LwrMT5LQ1a3fmHx7FLHI2yyACtAcAzmY6o4MbBMoUTVQ45hKEYUtNoSlxLCIHvLwaH1wJxwZApEOXqhRaWkVwKwkLGkrsw4k6mfk7cB6dpqZkLL1SeK4aECcpE3ZX/wSWOXNV0WGpwe/FTU20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akNtq2jl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709354031; x=1740890031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LrHgiTN6NP8q4eoKIQHlIBb3DB2VYF5SqDtYBtquneo=;
  b=akNtq2jlvInYzcyynrEZBWuiOSRr15HsgvOHmwEcd/Ru8Pq1FD2kJsGG
   7wqFiuuxIJJBh2N61UzktM4si3o6JuAJFy7FnpBzMo2TJgvBKxpJH9FhQ
   V5V4RBj6Ex+Iz2P1IHYF6y6zUC1vvknd/Oa3sQRFvwUHjVk5bmsPq6s2u
   nZwE7qSCtH5Q/I8Jyc29gBIa2BcRxjHLeI91CMPs3koEJXwJs8jECDx8+
   Q4ZsirBtCJbwg+19W8U7fjV2jDlLpArztnZ8ne/tUYB6uTlRp9lr+5qR3
   IGFo4KdBE7LkOd+7w32GY13Ah0Yi5IGbgTpU7di28Q4SPWpoPGLB9kEPt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="4486706"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="4486706"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 20:33:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="12991030"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 20:33:50 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 20:33:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 20:33:49 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 20:33:49 -0800
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Sat, 2 Mar
 2024 04:33:47 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636%3]) with mapi id 15.20.7362.017; Sat, 2 Mar 2024
 04:33:47 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: "Brady, Alan" <alan.brady@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Hay, Joshua A"
	<joshua.a.hay@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Brady, Alan" <alan.brady@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Bagnucki, Igor"
	<igor.bagnucki@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v6 03/11 iwl-next] idpf: refactor vport
 virtchnl messages
Thread-Topic: [Intel-wired-lan] [PATCH v6 03/11 iwl-next] idpf: refactor vport
 virtchnl messages
Thread-Index: AQHaZcIz0cZ58NoGIEabdXohMzSq2LEj6gLw
Date: Sat, 2 Mar 2024 04:33:47 +0000
Message-ID: <MW4PR11MB5911DC1CB1D1AE6CBED614AEBA5D2@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20240222190441.2610930-1-alan.brady@intel.com>
 <20240222190441.2610930-4-alan.brady@intel.com>
In-Reply-To: <20240222190441.2610930-4-alan.brady@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|SA3PR11MB7628:EE_
x-ms-office365-filtering-correlation-id: 3005e4cb-cb94-4852-a667-08dc3a71f3ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xcC5ExZCEnRwI7fhz3XQDpWmJ6ByuXxHSRlYOcKpiydRvLmSdw9qsElqGiVZPEL3zwx9+Vw1iQVouoBMHbR3bXo+rd/vTpTTkQ0GKgm4CmfTn7cNNFykVx9Cdy+FXadApbg5jYSBDwLMP1eEMc91anaMyZoLmo9vI4J+knHPyu7j7p2vOxB+BAXt/aElJp0aCMlYndt8mq8EgFA8t+GLLdiDMZWmq+fJUKRiPpNScmjUZ4guAo0JPWQMc6ND0eA7bSB9kVv0561bFjVpvLYM59xDJX249BpntNiwU0bCvs3f0IvKQe87HlaUFebef7k/P3tPe0BVMYPm8T/7LpbOkUwp600ZUJtQK+TGOkjLbphqRu0RSJbIr5qTOk/zUKu8nYmaTSchlUFybA35ItLLRsv628qxaTBMiJt7qlmZ8WBK2rWFt5qG/OczDB5D6G66Ka3ee2H87cCbsxuYWscbL+rWdIgIcHKztG6bBnwYnxBecaOcS0nD+8UImKT+UO1BFhZXXHB97u0eCjL/SnvspxxtFNYRvjKjAbkKgi2Jf0b3mdYEOY1w2n6t7mi6T8wgW2Xwr8FAn8Ezzuf+wCFamLhTU0bRaXYDDKj6ssqF1/UDXhhw/GRKLMxwDFruH1OHQtqN4nPGcLCUK2bjdaHq/nefldESSN+5mUHsbDQnv/bsZkJrVYt4Hr9/TpxHX/vaDxT2/9cz2R6kSOc+8uTNXgaGmb0ctS7e1PThZoWbg7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g6+7z5QNBB55IqXNopusX7FkaknrGcRlqApamty638O5bjcSAV/ezliydJbC?=
 =?us-ascii?Q?xMcbmkN6FyVtcEav7fUjeCUMwPWTIRYmq0U9t37MKMQa1G5hY4uUUjYCpSpr?=
 =?us-ascii?Q?nUafYP1ZM1Lr/IgdW3AD82mfgoHmLOgbMfFIpN22FRursFOLrrLYw+DZ6vJm?=
 =?us-ascii?Q?KAOD7Ghg38f9jZtAMkaA80qBKT46ZVePKckxG6fMmKMIYI50NlglAP6hg5ig?=
 =?us-ascii?Q?s42qTmbaFHcG15UkxCuehdjvNh+nJ3Oa4aRegQ80O9+PA5C4l9rkku0lmMUw?=
 =?us-ascii?Q?2rXgEY0gnx/OWDVAeROgP3ffRE4WGdhMHvZvHzXsI3MUJYSl5pXa1u0oybcF?=
 =?us-ascii?Q?qc8q5+lw6ldS1MYWJNZbeO1ZOqvHx9yVbyWOTmEwS5cqzQCrxGFekVD+xJQX?=
 =?us-ascii?Q?hnIoxfz7mOiJha6szDprNTsJDGq3AU+GJzchcDS6qokt+YJxD26NoRAIrcKq?=
 =?us-ascii?Q?qrOVWfgAhyvWTfypLj/21tN5RiF24uH2G4bSEtRBiGxTgPgl09TELvlJnezc?=
 =?us-ascii?Q?4cbN7fqCS6+X+sI1z8PcJpvw+vE5Yd9eKUmoW3aoSFT1sZt2sXxZetOuwli2?=
 =?us-ascii?Q?lMPvPZ3DoynlLk54AQ355JngZge5IUxUjInh4wq7GtAoXTRhayqul2G1wzeK?=
 =?us-ascii?Q?69FyYdTXLL6HbcSaUIIPjudQD1JYXKqXw20CMhyolcQoxJmJ0VesdDq2I8ir?=
 =?us-ascii?Q?nULJL3pO2Jl+vz93lGXc4Y7BR00P67czJcQILWy1tGFr1OdF6q/S8VHwf5+L?=
 =?us-ascii?Q?m7TL/R/uOmlmAmvTERH2pBC5cP0Ep7f6Ofqbmkn1SrHjXLPwQVHWMbC00AHw?=
 =?us-ascii?Q?5mk9ehX6lm2KGEdRIxf3lhzWJW35ptMzhuBJ//5oOgY5mwip6Bv7dgNlG6CY?=
 =?us-ascii?Q?XJfeda4+gz44nNuw+WygGcdeUqh6i64GwdxaXjNIJ7NC8PxXuUYy8YCRQkYE?=
 =?us-ascii?Q?8QRsy56nUAqkmyy0EjtikRR5jygs8biZedgLt+Px03S+ptaJmlVOshCpgelX?=
 =?us-ascii?Q?p3bu/oRPKGD8vJ2FLrndMcIlrZWgSy9BJNpFeuCAuT/OfFVuv9QKUpTCVbOj?=
 =?us-ascii?Q?CsL7vD/XjbOMEP0pder5eZ8vFx1Iku2nvm9HJnu+XBA6UDxLoe5pEQv74oPG?=
 =?us-ascii?Q?TS0vGXZWC5UmscJzxrOquPruMpBUYAtT2AwB+/c8bKg/qlfJhmbPxFlMO2ZV?=
 =?us-ascii?Q?J79r7rNJEIGgC8xgrzdfiDLqRlsY+KSasxy7TOlWMd6rdIKUj7UnhFMPesIy?=
 =?us-ascii?Q?bWnKd9yfyHzQE4wF5sYi0S9/7iOtcFTDJNki6LG3mBDK40lpKovqU5ANS67T?=
 =?us-ascii?Q?pmafZy3zcTP9HJspcR47Fb9MRC5qsr1hDxyA7DBRs0148G36cj/zhk7bhNX5?=
 =?us-ascii?Q?CoRR2I8NVWo1VK91YlrukLfdttvjpPSEVj0VYV+bXjqeTT2/t7mGt1h/egl3?=
 =?us-ascii?Q?bMSctVVPbvS63UEjn8cvshWCeAapxZ1j2GcqzIUYc+msL08x6DcEIFXk1R3z?=
 =?us-ascii?Q?3oIOEeBQj/mleEJQFMHzU6EjDRecMFiR4x/XeWNTiKZClyzB3AI/5L7wwxkO?=
 =?us-ascii?Q?R4trU21UUXGUdOeIjkVuQN7GTDzv7G1pZCj7PiBYJjQgikH0lQuBGikhJYmj?=
 =?us-ascii?Q?hQ=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKpZquhSV84TqiyCxa2UTCp1tjKNZR9BEBHu23arhqg55o6K9a8lGOGdtS5hFNUNrpFLb3y3/EOZlu+ij4C6ZCr+S6rO1eT0YEEFOLf3DHZ/wluY4OaivC9gpBAaAm+kQaUEpiKibJD0JWTsHLNvgWamWvv+4Nf1kniGgfir8kQBOfbqU0GaEHyj3QzcK6H4PhWjhEgpw/sI5Jc8qaD+cXD++bDelf/yb30xAu2FqmMNzLkpa2402PR2Ydw+7qUvtqB7z8+9iD20wWaOud/C4upRLy46x6TyBK69OXRCzuDh00Eiq4+CfPFQnkWStEQnGsn2k0mfKubwgyC4Dta6Ag==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MVATqrsmVV+uu1oDxhPOzVObOboKCG8PZ3JZ1RQHpc=;
 b=VRtrksweEbQpy8xWtOJ7m4q4PTL2drFq6uL0T7rRfpD9G2OFTfCHDt4NTSBvrld5s4o/S5dBGbJg6QxPk5NAIXHyB4XQm5MPXu/J2PstZQYlpZCht5UyK2ZVtHJ8csII0wTlmq1YbEUuOJURawIjeVniNnBJCWQJ3606ru2Ik5GBVqG1bN/+s6NxNZnoDzPkN+2m/VGN/MkSUidDaC5S3oFTSrq6atsCjRGA0OZEis53zYp3gsUAiHDXeDk+Jeep+Y3BKhAlYo6PhVFUfIfpVIQBMOUxvKRJTYVCpNd3jJLsKouneSQWqY/Rbi+HTGLHCo3C2RBkuV5LM/1VBjiLwA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MW4PR11MB5911.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 3005e4cb-cb94-4852-a667-08dc3a71f3ee
x-ms-exchange-crosstenant-originalarrivaltime: 02 Mar 2024 04:33:47.7470 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: v9Rb4jxvtsn/l4Ysd2Olkp0kf4uZGjMr0KwyoOajCWN8p45zzvZsmsLpvIrYsRubCG1v2D2m+UiOu0bgmtBi4EdEuC6XCTuBRw9YMc7p94o=
x-ms-exchange-transport-crosstenantheadersstamped: SA3PR11MB7628
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alan Brady
> Sent: Thursday, February 22, 2024 11:05 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Brady, Alan <alan.brady@intel.com>;
> netdev@vger.kernel.org; Bagnucki, Igor <igor.bagnucki@intel.com>
> Subject: [Intel-wired-lan] [PATCH v6 03/11 iwl-next] idpf: refactor vport
> virtchnl messages
>
> This reworks the way vport related virtchnl messages work to take
> advantage of the added transaction API. It is fairly mechanical as, to
> use the transaction API, the function just needs to fill out an
> appropriate idpf_vc_xn_params struct to pass to idpf_vc_xn_exec which
> will take care of the actual send and recv.
>
> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 185 +++++++-----------
>  1 file changed, 69 insertions(+), 116 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 95ca10f644b2..2dab7122615f 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

