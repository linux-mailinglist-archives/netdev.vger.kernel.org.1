Return-Path: <netdev+bounces-78618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB3A875E76
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6171F22590
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383B4EB4E;
	Fri,  8 Mar 2024 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBruSbH4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F30A4EB4F
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882932; cv=fail; b=gw1XA8DF2KbrszNNk+yNPDRdUCGF1iUvKxIkjd4wcHVqNuDjZ1ItGuMkEeMsxqCx0zMJ8Bvh2OxBevlGRD4VtQCShCw4WKMsDwzoeGa+fEUrfjHnO1dr8y/SxXiJZ/1NyREtNpaNni3HAyFlOvdi/F6S5o6Y8k9rFVWu67IlWo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882932; c=relaxed/simple;
	bh=jpNE8vlfBvy78pBr5PAVPVaxEe0jv9sAnHAMf25U/uE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iUe7U5UBxtQk4TD0qGzC631hEj+pCBCTdOAixDMNDGvBzFPGOjH50AJCrnTO2bjVsRxxgPgPdR4/iIeF6obNZkuqUxJzRGmNxBSofZg3DKAFnms5VI+ooAkm6wRv6IOvzg+AfGG4FRSod1odNXyjYN1RzRfcn2cEPihJ4dgeOVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBruSbH4; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709882931; x=1741418931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jpNE8vlfBvy78pBr5PAVPVaxEe0jv9sAnHAMf25U/uE=;
  b=TBruSbH4m8FcCz7pNCIULZ8LLuS3VCwjnnrzTwIBMOG6zoldWENy1zxh
   XxztS7oiEVtG3p2jM9rrps0VuESDIYgVa/eHX3ZJ8ZMYeL/Q7Rx5g9qPm
   Sq+wjWu3F4SOW4LVhosYXsyTWH5m/1ljdGOBR9AUKDtHZpd4mCiFeK5A0
   p6UKm7GUS+xI1bFb4aDzhQWmVJOVhkL/gxnVl+6JfKbZZWarVohBDJQnk
   xJwXOljLZ7AkaI68EK6Z9cImk2VcuKTC4QEnshE30zmS/aGYvGae4L9Zs
   mFNUO8SiAH98sH0ujZhHH50XVzP5ASn91Zc/Ya+ObkHh1kahQAAs85XSp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4451216"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4451216"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:28:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10261518"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 23:28:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:28:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:28:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 23:28:49 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 23:28:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTNX8NhxWIvsgUhbzbZuUynHorTrnQi5UJRhZr3+dqIZmIeZ9cA5sLUhpmCJww7MiN5gqi1C7seHRRtYLULF5QvEzsKeBFUTlbO6WjtYsBEEdTiHprybR7neEOrsKtw26RSPLloslSzKfEQXMqc8dtWCYw5OLbT+AzeX1BVWFcHW8rnG3ODgmYSYvtyw3QEDbYx22Ishp769bMY7xr5zmZkpPEhVrNzLJGpGjr3ilLitCRLociP16koDs3uFzNDUSgO+DufCNLWDnNKYoyDhFOKlvqZQB1AAIK2K8HNdJgmCgSLb/RrdNKF1EGVx+0Nei81NQm03K5k9CtLTu0r3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1AcdVBaGrASA1nHfdKxwUCsw8/7TUNFBvjk6zhwVeU=;
 b=NuoyZ8GKx8+0MTp1lxgh9SLMaHkW1AcuQGfgX2emiWUJ1FYXWrTMPSh96OogmuUUscSZw06pJjybXnVWyxoXG6GDQU0oOAJteyCZFnpSLAt8K7trXE2sNUqbYglfLJRXCUlMupl93AWSqspOxnWkJRov1biop7OCXXYgqthF1C9zYgeypYOM+O2tGG74TDkL5n5uBoRIgQ2qoSN9I8xsmtTp0IzrPRQ5yU/6A6VYj+hGtGjr92GO6KV76D+uu5fAWbcu+5TvT6gzMXN5rBH1rY/TziOpG+US8gnpSjUXGf9CwEmt7x/ehapKk/Qtxp6DpJjBYPqS3d6sER4k9KW9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Fri, 8 Mar
 2024 07:28:47 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2%6]) with mapi id 15.20.7386.005; Fri, 8 Mar 2024
 07:28:47 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Marcin Szycik" <marcin.szycik@linux.intel.com>
Subject: RE: [iwl-next v3 3/8] ice: default Tx rule instead of to queue
Thread-Topic: [iwl-next v3 3/8] ice: default Tx rule instead of to queue
Thread-Index: AQHaa86daf7WJfxJjkW+dYpM5H26urEtfNBQ
Date: Fri, 8 Mar 2024 07:28:47 +0000
Message-ID: <PH0PR11MB50138C75BC918723668FDD1096272@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
 <20240301115414.502097-4-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240301115414.502097-4-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH7PR11MB7098:EE_
x-ms-office365-filtering-correlation-id: 0b7ea1d8-af8e-4348-545f-08dc3f4164a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IvXdQ3DsTY2XMRHKx3gFc0l6AwvuLT3DxpYXqfwNU62zTdWUEk7hzuYKIUjlsNvlDrRZcMXuGva0101zjK5ayJqXMRNsYpDa+kwxr89mcdjsfHSacFoPRjTH166uz5J+BQIHwmZGhVoVHxSyqfUhU36PNGe5fZ9xigvgMGQmUEvJ5/0Dz7+ZpQlJiH2abMv+npY+3cDFW64G529w5idPHrklsexQ5PWxGYAzVbYzgC1bLxXxSM9w4Z5Mb+VXgmaMhVfo80ZauljwXLzvIQtHFnoWr4LW+KJQ0gDYNmPiJe5yxJ0ZfAmrhqCW0D45X1+Da6oB08dzV3mQ07YsCJZlc4vnq7ytaHH+tOkz/F7VWAUxyQo1dP9eZgvuZLWf2/AKEifSClUEaTvbZgn71rOY/puIYmZJZdRUe1hF2JehSC6FB0IH9L2qpwCd8mmN2v++VqgT05bc0kBD3K9RLx2XWEJIJBtnATzw4ueGw3UMdLdo92BJRHy3wYT1A984UDOt5g0IYIG+pX2TygnGb+zPZBfwVK6Ng0GbjbZVAeNIoc/UHNm8qMfNEbvKTWpN4PKSX47xKZoJV5xq/IG98df7++qhypKTIYE6ufdoeVLGUqDNlduxPN23wlZNnAY0r2/3dIByOkPrh3Yul0935j/rSKvgSfueeNFVHxsm8FbSQy3XvxG0GurwT/tJlPaoi+Yhr7fGHUN/3xj+zwylAwngT8bTZqiemKESho1Uql0C0RA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6/Fwzbwupw3SB+J00SWsHANV6rSxft85zjR4j/Y2AycK1bYo3KXWGrG5GL/r?=
 =?us-ascii?Q?c5TXgT66oOLDM39htOdXe/pZ1wf+4yJ/9YnunXLZWafc5V94eyIqRzGoIE/N?=
 =?us-ascii?Q?AGoLSxbYzprCuJp+D67RTZrKVG9Rbuc1+jemSWGLa5bDQrmuqEdnuoKRi1+V?=
 =?us-ascii?Q?WEiBAP25bRRt/kmJpK8IJ43Meyt9bMVN+rPDIoKgScnQZAXuKeV+v7bV4j6e?=
 =?us-ascii?Q?VkBdQbIgYlwJafxPHJMcgyQYSC77bxzy+PqPvH29NKfw3s7N3vKcOpn0/TRD?=
 =?us-ascii?Q?84NLOr+HuJNoIyHYF2tGhHRjMjVrZ8e4FVLqfLDYfhSWM4O33k/CJkABW8pc?=
 =?us-ascii?Q?LDVN8AmKmjaSmznMq7O1NGoNt6xxwCBnac6yjXIjK6jp5Qw2SvX1ja1ijo1I?=
 =?us-ascii?Q?uXtEqWENCcAunLyn5d5ugYPAg/b/VvAsgaUG2AIgYG6WGTOwToKujYt5xh6h?=
 =?us-ascii?Q?eJ4WTPCv0dfLmzePzc3u3n0OXXcouyLC+fVSxvWiC8i5pgELxrvGhJnJXYmK?=
 =?us-ascii?Q?sXSczQNgvD7Jb+Vb6OTMe+5vpQO1lE+tg5hSqbX6pdYv3XktznexUIZEn2TY?=
 =?us-ascii?Q?q48/WmUS41nvRNuD1CP+l2id/UJ//gM3Ov/x1wLf+JV5DGcOWNV7qUqMpmiC?=
 =?us-ascii?Q?56pO0r7Y99YB/rCUZAtrkhBeWt8hbxMaWF4l5ohjYkbv+zwKKBjPnz6dRTSl?=
 =?us-ascii?Q?FDAmRSQ9kf8PG2Rstv2H6cbDMkkay7APn2o6Y+Jx/hqUfNW06+zM4u0JIZAc?=
 =?us-ascii?Q?XLGavqA1hTnkYnBb7Q/fEwDYTv/olHPAwQR+L4xFnIizkNjYa6HynFRg0HvB?=
 =?us-ascii?Q?/WWdCLXWGfsAtO1i4OcwR3X6jBH0fv8In67yx1o0+DWvQ/op98GqbwHWqmSI?=
 =?us-ascii?Q?UFQFFaZS4Wh8GzZpXJgIuF6w8yRHyiDwZIhA3urQc6ZS3NkmvP7rpy2ekOMH?=
 =?us-ascii?Q?WGOQ1jy6NMKKBbiq8Cracosnr6eyNyWwKSItfMS14Ri3NfU7v1ptQH2YJ7JQ?=
 =?us-ascii?Q?PuyxUmu0BVxJpRbzYGaVDE7h4OZKGJYZOlV5plJR1rQeWlp5Mt59q9gw+Xmg?=
 =?us-ascii?Q?3++wx/A5l89SjLapSRO5zRoiq2uPegFRySQ1bwQNTtp9XCW5quoTCImigZJ0?=
 =?us-ascii?Q?UjhW+Yz72UbYl6q3Qvx8GNnrmiXMJzJ2/fDHHhesfpXJqkJf+NEZKkbtsB8N?=
 =?us-ascii?Q?lTPgr/GdqaRfr0CC4f48RjSVm8x+gA5DhxK0OJTJUyNj2SA4Pf1WpTrrebjQ?=
 =?us-ascii?Q?v7+fAwCoCCM2E7xt7cScTlXeMj7JQZP2FbY3jBYGvi10GNC2UQpkibDUac3B?=
 =?us-ascii?Q?mny4e7ynfiRTpMaw32eqIGRb6vtkJbAY7gjUomCVkvRe23DZcN4lwEscoqwl?=
 =?us-ascii?Q?awXX+o8BmRUooBY7lYWD0XLaPbHAAwdmWb1jLNHNx96k0zNjROvESSb4K8g3?=
 =?us-ascii?Q?ldwKVrtmcc2JosDa4AVgk1FaBW+gTa8N/dEB40Zf4B2sOyvutD2h9NEz0OwJ?=
 =?us-ascii?Q?1TOgPXBpiwpqbFEagod1TOhOmYPSc+oF9agXLq+QDEtHoiEc5SNgQ3rlTC4c?=
 =?us-ascii?Q?/Du4g3b3QVtrbQsiQLq6VYVEeJ4faxb5s9Td0+D3Fa0mCJt65uEM4yN/t4Ij?=
 =?us-ascii?Q?og=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7ea1d8-af8e-4348-545f-08dc3f4164a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:28:47.3123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VyAiOq2PMzbVGyBk+aHfC8bsSzjJ/wB8sLshJIaPlK8ZX49zSq/7TUD0LKv+yxc9obBD0WufLcG7OqHNKp3CXiML4avhb9JeVre8TD5/1zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, March 1, 2024 5:24 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Szycik, Marcin <marcin.szycik@intel.com>;
> Drewek, Wojciech <wojciech.drewek@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; horms@kernel.org; Buvaneswaran, Sujai
> <sujai.buvaneswaran@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>
> Subject: [iwl-next v3 3/8] ice: default Tx rule instead of to queue
>=20
> Steer all packets that miss other rules to PF VSI. Previously in switchde=
v
> mode, PF VSI received missed packets, but only ones marked as Rx. Now it =
is
> receiving all missed packets.
>=20
> To queue rule per PR isn't needed, because we use PF VSI instead of contr=
ol
> VSI now, and it's already correctly configured.
>=20
> Add flag to correctly set LAN_EN bit in default Tx rule. It shouldn't all=
ow
> packet to go outside when there is a match.
>=20
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 107 +++----------------
>  drivers/net/ethernet/intel/ice/ice_repr.h    |   4 -
>  drivers/net/ethernet/intel/ice/ice_switch.c  |   4 +
>  drivers/net/ethernet/intel/ice/ice_switch.h  |   5 +-
>  4 files changed, 23 insertions(+), 97 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

