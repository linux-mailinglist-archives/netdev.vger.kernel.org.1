Return-Path: <netdev+bounces-65802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CB683BCDD
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC6E1C2264C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488641B948;
	Thu, 25 Jan 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUWFeYjF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB91BC23
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173583; cv=fail; b=uFrXGVE5HpPqzU17rqrqYkNwM8mb7lV54DfuOJuNzjDqKudOM8CxnWl6U4fzURqqZTm5qmvpukJX57YPgmjZqIz891H4vOt0Eq9tM3ndBXRsuzfvgk12Z1Lp6EjNrvJvbyFUGXiQU5htWS9YDI8d3KbA+EveRRkDC+VKBE79Nd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173583; c=relaxed/simple;
	bh=yfQ87gv85kCaKQy0SupxDfq4l32MrYih84sISA5oFho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbJ2Pg2FpTNKETP8eVosVWM/VxQwnd/1rchuO0T8BxMomfXtNYDrbhLd1Fn+q09kskyw8PRFqDr+gyX9lfM3x/uk28ta3N8e+lGPltJJV+O5sHyNyzlpj2dtH/TH+LlYu7Pr2YSkwZ6KsU5UaLs/Tqn6cDLqa8+EnBHEhWZOd4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUWFeYjF; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706173582; x=1737709582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yfQ87gv85kCaKQy0SupxDfq4l32MrYih84sISA5oFho=;
  b=TUWFeYjFPyZcKxucmOiFVG+MVvhIGkhz1YLT5eB/r0TF8459+6j/6PV1
   6SSRAOPcH5GJGOr0n1RCw5vzWFDgsUSLXw6aIa0BjXG61Tl0devIKZdX1
   rLUNPBsfZs+qDJswXSP6Vh83wRpmXLu9nF5LvyVXuqX0u9HLqEw54r6qb
   sfy/QRPFe67GTlGoUUFfmqTX52wAsE7yTikOrQYVmixVwjf/Vv1Yicsxz
   Vpb3ixW8QyS5V1xxvBySszE1zHPrtQE6hA81h4W7WPnMckkiZT5Prl315
   G5CGZ8V2qKPenFgs+6AHrGj2NuNpTUq1ID/MNthdbI53IdbnJauByLnuF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8760212"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8760212"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:06:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28704848"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 01:06:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 01:06:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 01:06:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 01:06:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqHAnmdK2Rkt1g03ghP1/13L7MgfbzZuf7xNtxO9B/5E12aPApuXoU5hXT5rkeRLliO3ujoME7eiSxpSbZOwwAT+sHEB2775LJaX1Xg4Z/o/z+/QOuEL4ot0kY4X4glCOo5gzrywnIgwyJFoVDI8X75nBLzJfBqSsOUNnbvlDcGPLCz+bhiTh0wU6s2MG2FkRRKOKSSZ4Of3AFyBsJCYC8kndXsa0F+wU157jHDJQJ+24zt6dOE0Gb7O+JozQnD7BC9vGgj32xGRskFiuvCiJPMwNxyElL62fiVdXlabQ5tt4Ck1EWni7zFbRqc9XEtOW1vnaYp5XZKeLpC6G7sIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeH75QiU1edyHkEj6fkg6/SlCxFLfxwz8+VREAePbR8=;
 b=nNjEJLk2vJYT/8wVoPDThQICRD3RcPPGH2IUT5zE+e895Z/oWwoXjJnLOyr3Yn60wd0u3vgVw2vFFagRNyGHyCLpz7IzqtWmBL/9RTjIccRsnv71CeYZkhVBNX4ffPC4whWeGwkluPWQccA2kRXSTezQr/mT6XpfbmIiv22buge68Zna9fHnaVwmroW7dDUCYhGAUwih5uS0DARN/EAxpk/nx5yCeeWJVqcnaAB5/zloloA0BgL4CeWX4x+7u064cAABt5GQEY3d8cW+gR6SxMuB1AOoPmCJahppJHPCM6KH8Zi1cxHDkhKZt0UZE1mJn7ghVMKDRiCq+Lo9GUHh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SA1PR11MB5876.namprd11.prod.outlook.com (2603:10b6:806:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 09:05:54 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 09:05:54 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v7 iwl-next 6/7] ice: factor out
 ice_ptp_rebuild_owner()
Thread-Topic: [Intel-wired-lan] [PATCH v7 iwl-next 6/7] ice: factor out
 ice_ptp_rebuild_owner()
Thread-Index: AQHaTepo9EgV4nrvjEC8B45zHN6gQbDqPxkA
Date: Thu, 25 Jan 2024 09:05:54 +0000
Message-ID: <CYYPR11MB8429135B7D40420B46DA9E51BD7A2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-7-karol.kolacinski@intel.com>
In-Reply-To: <20240123105131.2842935-7-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SA1PR11MB5876:EE_
x-ms-office365-filtering-correlation-id: 0727fd97-7de4-45c5-b579-08dc1d84d637
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ODnwHURF651qWLITlXDcPNS2yU4F/luC4Y0jjO2rW0YhJ4wS8quB1IsgzMaJkj2IMUrgsjnJQ7vwLuYM9HnNgeS9X4HMt0GLncWzhCMjpCS0ujZaa1pGDSF7Y8msu8rhVMZGUQoSpqZ1YEgZEMDLLYDtlwrUXhBGMI2PsCOmtfUZBPl0Um2v12aiM4NKIGoiW9ZjeUBLAtdmnTmfZBbZ5lKpaV78Vij6pvnlEfHkz2s5CbrxHogkas26f8neVmAIshjF0IHvWEoKrO75Sp+arQ+9+rDS87A3R+QuOViWdgfdUQFH6T5nbA8tlnsOscvT4bzvCXrEvmRrkCN427AP4zZgsQdALD5zT4s9FgD7Buz2vOPpO9v2ERVG69RO+Wy+MkOX03lAWMgW/Y4Q4iOk8aUT2GuFV2ZGqNcYTq6k+Vi7US6FKYSohI1HsV+Ih4dZLaitHRxCbsT6WWrwTQm+Sxx+oAXe2ovxHSvBJW0Cork0LuKPCcXJsmWcS6wi+gJCfPZXam8wyGMcWrTiWkSu4AWWqUrWKoWXfDYs6s+rDIE/h6t10vqVRrGdfnNJlJHOcwLnx59bydexSoNJv61D6JCyNSHqu7hTIxmdMA2OygzTotCSYs6xRovAFJnHzAP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(83380400001)(107886003)(26005)(38100700002)(9686003)(71200400001)(55236004)(110136005)(5660300002)(4326008)(8936002)(7696005)(478600001)(76116006)(66556008)(6506007)(2906002)(8676002)(66446008)(66476007)(54906003)(52536014)(316002)(53546011)(66946007)(64756008)(122000001)(33656002)(38070700009)(82960400001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hz2Kl9289CdQHd7JWeoeuEeApoT+IgXa8Q0JVcKUV43T52XGKb7dQN7Dg40V?=
 =?us-ascii?Q?ckLeo2KM9lBP60M6uJwa4xyKeDPmJXIRzwkASlWVSB+lPgAw6NmDJ2GGYroY?=
 =?us-ascii?Q?HbUdn2R9ZkVRx9UqGEBvd/l8m7sXA4fswuj1jDVpbD8HG6loVafdPQNRDiuI?=
 =?us-ascii?Q?0255idUNl6myZ2NEknXDyQ0QeOtpabxPsCdzEfpAsyV9SQQ9K4ELeURHv9SR?=
 =?us-ascii?Q?mlBUmW+KxRLkGAnss7POEXV5p+jdT1RvS8JLLE9hMi03rApQaODlLiY65Mwr?=
 =?us-ascii?Q?I9wPC45Z8aZOqNjw7iVBIqw9A32F9mnw7Y5N46pYEq2PS+/63I4Djn29vBxo?=
 =?us-ascii?Q?mZjnur1OwJ6bu0K2qPprubub5Y9JNEbShz0MiISD8yMcWGXLlGUZXHNGI/F6?=
 =?us-ascii?Q?OtFw7E+8K4+V4R6gfQ+upJ/3TYmRYmTjVGdWvC1V0R6YvTcwK2uVBRDDl56B?=
 =?us-ascii?Q?pekXPDjNTbfNq62xF/QI7wgDA4T9+5VDaqgolZNCYT9X/uKUXUmiWVZ/yqAB?=
 =?us-ascii?Q?Zq0I93Je/3pinxFbRmtnDYrfQ/C6trDc+B2ugh8+S70gBdxRCfggiB0YAhzn?=
 =?us-ascii?Q?egUTxhd1gsGYmr2JMtahYtSY/qIJTfKdgemVQBVq8W2X4peqctcgyQFHsGVk?=
 =?us-ascii?Q?P0s/G7Eo3u4ypbqRw2A13cHyuSlKXGFh8WlY56bh5BeMprwypTDbx+78iJjp?=
 =?us-ascii?Q?PPRefU7yID/ZaWdG14MUDxic+BBVqQZQTjh8rlBcBtLSHJZbsPvlyn9cmgUm?=
 =?us-ascii?Q?Nt8gUMf6rVdBRt//vrHpdCCju8pkg4BQsDJshzRhGBYZew9HbfrgT+kDQc7A?=
 =?us-ascii?Q?8K+h0lTjlvJwVPkMHz1sveTf6mNm49YXq5426FOLcjEiIYAJsa2fxykMDdjU?=
 =?us-ascii?Q?nNWXb/xtRZ2VWB9PSHAp/YWHIRhIUqG5peMJr3FWrKiQAZEs+vjVu7uEuEy7?=
 =?us-ascii?Q?yJzgEiIsvNF7k+M9WS3VJ4zEvyCA82QH7mEYDJCisIihjCCn4gY9ddYR1oRh?=
 =?us-ascii?Q?emtJyd6/gqFmkRVkmI/sDLzJyKoYAj1BQjDhAAI5u5cSy0bYzIFDBGEZltAf?=
 =?us-ascii?Q?yFEGXPkTVtwOdOLATGH5d3bMhO6fS6uGSzzUhsjgmzYf8V/KpO+Y0UeSv3+8?=
 =?us-ascii?Q?hVGEicuMOZBobeISJY2VBFQTDv1R0tSrn5Vviage2UPJd1UnB8enZZGRpf/5?=
 =?us-ascii?Q?J8suD0D1NHJ5L32u7GGET2hnsTL6N0Va+weLTwXf4YTLvrEzzF5wL7nrJtQC?=
 =?us-ascii?Q?FM3MbUgDeKc7EWVfuW0MrCU8X+bTuPSWmXANDtOVr3eMyck3Du8tKOS56hN7?=
 =?us-ascii?Q?CWuZfD+WZ2qewN4nJ0YVqxaITuJqF9u7Yy9Z/frD9MlaqTaUlyLozjb2NtGO?=
 =?us-ascii?Q?TV/Elh2Y7PPnp71dzAroyfi12Cttj3akKLbVMa70r8LVnABFxzWanZ9yDnSY?=
 =?us-ascii?Q?huzp3W33icXgvXHTtE0STkMekzCz1MgjGHUBs/PFAJ1yi0wPj0p9590PnNZM?=
 =?us-ascii?Q?WuAnoGq7WVAkPbI5fxU955gncB7LNs6JB3lNwGPUY2RHrztrtXcVLDvYZ4zL?=
 =?us-ascii?Q?nWy8IiRd22ViAiJrRXQXWbC99lUnpO1649Jyv0Qqzwnr9MPpSMSBp6wrlS+v?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0727fd97-7de4-45c5-b579-08dc1d84d637
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 09:05:54.6434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZ0mYRb+IWjzQacu3PIoY68PZDIO6Mo2U2UHInbAOmfZqYTEvUtKldMGoyABjdNYXBlG2XyDi+RlFb/6PvAyNGMoAgH91QlRvi2fe1Ea+5aVNrpEu197dSNt+ssV1tA4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5876
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Tuesday, January 23, 2024 4:22 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; netdev@vger.kernel.org; K=
olacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony L <anthony.l=
.nguyen@intel.com>; Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Subject: [Intel-wired-lan] [PATCH v7 iwl-next 6/7] ice: factor out ice_pt=
p_rebuild_owner()
>
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> The ice_ptp_reset() function uses a goto to skip past clock owner
> operations if performing a PF reset or if the device is not the clock
> owner. This is a bit confusing. Factor this out into
> ice_ptp_rebuild_owner() instead.
>
> The ice_ptp_reset() function is called by ice_rebuild() to restore PTP
> functionality after a device reset. Follow the convention set by the
> ice_main.c file and rename this function to ice_ptp_rebuild(), in the
> same way that we have ice_prepare_for_reset() and
> ice_ptp_prepare_for_reset().
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c  | 62 ++++++++++++++---------
>  drivers/net/ethernet/intel/ice/ice_ptp.h  |  6 +--
>  3 files changed, 42 insertions(+), 28 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


