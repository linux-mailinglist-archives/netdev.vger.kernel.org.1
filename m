Return-Path: <netdev+bounces-78627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3606875EB3
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD946283058
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72A64F217;
	Fri,  8 Mar 2024 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/ShNkxK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F194DA15
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883627; cv=fail; b=UONGaEza1zjWQWXT/PLeCNlVt8HZbhVJq8tFXHoUfOY+8KOOGAw4mrPA9fB+TGSVgxO3Hxfe5/zZpM6BeWWGDc4maaV5/dKOGPw5zdA3VVN4otiPH3ruHG8R4irvcDovFEkKCGvxE71xkmw9zMpe/2O0rn3+rxbCJlv6SbGp8nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883627; c=relaxed/simple;
	bh=3IPWjRU45nPMwWb5Rl3JNeK9MQxP5GBgsx4klRsOfFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jmM3TK7c/H8otkkMZA1nnpP4kkuKL9QsiS0ssuKC0Tn48fUwUuQc0OhHNvDzetTw3PCgA31d6RIW1bzqlEUM43iMdLqrDGxznY0HBS+ZbDWCYuo1/DCzIA/Tl8snd7GiqwxzWZVNydjvq9Uw0qcGIE/3NYtEI19c+92WJbMJ9RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/ShNkxK; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709883626; x=1741419626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3IPWjRU45nPMwWb5Rl3JNeK9MQxP5GBgsx4klRsOfFI=;
  b=l/ShNkxKZ0kYiD3QQy5wBD/0Ff5A+8pgnnQigRO77XgC38boEsxoasUH
   Tq84vLrvOcrcMbG3oyGftPw63niLnNnQu0pYN61ZTgLe+lSJYNoP4vdLf
   xQbFeoRcwVale2Q8uJHIRvYMIIjYFJko7qeY0JPUcu9NCBObkyy12pVki
   tLaHGe+rqviC10PFYlkXdJgi2Fxt+ofXXnZlMNdYNTvtfkZSOLXEYpyy0
   Z7BrcKIPgJWxxKsFfujheZayDRwhcKQkPmL3dOE394EqFKgjQQ4/zL++l
   WjUpoaGnncJIhCVTvLL2XYES0RXLeqAMxRzPbUfogFO1ROdeIZ7xDV/iY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="22117670"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="22117670"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:40:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="14876682"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 23:40:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:40:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 23:40:24 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 23:40:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSbO6PtXbp1vfZ/oO8rSzeCzaPrTNSqdEk/FNFmOUj+FiZoOI81o8Ic7mc1WOT2kaSMHdJ8ewAhbI7RIYMkWletupJdiOL3J5PEe8X/9dOpT5BzA2Hic92yaBkBfzWsM5TYz58Hls5zDk6Y0nCLNDCAfVdA7uZlusyQ+AOZ8WWIWL5X7iMC+GappOVfhCbJf2jEUYkoqAZp1KBP15divrcwwnQ7SbQdnfpnX5PXyuTBWJ8cUwLjt+uXUFleGHW3f3l0eQswcuhQ2wIOzN3XslFha+Gd+Cb1TqXX9gkUM2Q+2/sos2rUsKeBq6EFfbmD0+rhl6ALD5V+Xp4pKX4Xa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6TmQHCOTOYl8ffIOFXtKCzqiUHb3+mxOP42w19fbrs=;
 b=juiZbXPs7yYYGoGTZoHkk+apZddSFfEJP4xYWDaLa1IY3z8lhhHx6cZJ2InppNeTp6ZhZ17nUmhB9bYZNzA+l6U0IgLR+8EITKUBMuUpRtU2NFUC/5zxLtYqwCn6n7Fvx6OewJBPo4de7EG2u6/N2UIpDk0ogv5ibf0GeTbG+rrMWZV8yRWfZlhNjPUPwMYrNnGi8J4twD8uuv291sarSxDGaG9lb9PhLyZeSs2mienPYz+yne0FiZ31qpJQXW5fBESCeTfgz/pYBF56a91Wzbs0ZTnhXkYcKEFniK2XVSP1o6p6fRWgCNC1brqoTdOeeQE1w28CptT3lgIRYqWHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Fri, 8 Mar
 2024 07:40:22 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2%6]) with mapi id 15.20.7386.005; Fri, 8 Mar 2024
 07:40:22 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>, "Szycik, Marcin" <marcin.szycik@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v2 2/2] ice: tc: allow ip_proto
 matching
Thread-Topic: [Intel-wired-lan] [iwl-next v2 2/2] ice: tc: allow ip_proto
 matching
Thread-Index: AQHaZYu5DYM93dOfE0eI3NdSd6XzrbEtjJnQ
Date: Fri, 8 Mar 2024 07:40:22 +0000
Message-ID: <PH0PR11MB50136BFBFB6188DAC4424C7696272@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
 <20240222123956.2393-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240222123956.2393-3-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: f41fb8f3-d473-46a6-5cca-08dc3f430314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zst+gElgtbr7XHYdooIdXooQfVoNbn6GMns5DxGhVkEkTP1KYCUCXxfTHXcJnTLE3sa0yJgGFJWIsZuyHsNrnPuSwRqDHbWzrXTn7mrz+bB/8LJvtA8ugvLHHHla9ggYmwTIPxFZW3zLu3JNS1kDrOGgR9YIx0rKIqV1FtqwbvkkpdO/Dnp2QUHwyTJLEGwu43KjoRHYggYCEqFyuwxmDO4h0vIgsrTxOi1MJPqueJYFV8qjvxV1v5nE0heWtZ3awA1XC9Ah76Kpv3k3XZBoaLk4XBAFsklJa/nPTTenIExmzXxs6wvEV2YW4cguxkNhv1fnLvpAdanMi+ZeBU8QpHJ2T8z7FZPVK96mYnPb54UUUZ17BXRKsVOIuYlHJPXkasjZMj1xJLRRka/gRbnO+G06nF5sPrygLz1ekVbNItuIijRvhVA9v1VxGQpgx6yJ0togDGyGhH2Q/g2w96Y523n8erbwnEBhkwuZEfuT5+q3iUwxnzdn4+caM5tfUpab/ev8ecZ9H0bWM3USf3amidHeyG00FW+/C6rT2yPAGoE3jDJQre2tLtnyL2cObg1cZW7yvPqICSxjik6qJIPYHu+E+dRuOha7z8NXJj1vf1vCgwrc+6yASDQ39pJGJH22h4U3DFeCt/R6HPvD+TNV7ERFc8oIcbOx62kMjKhRkuJfkkAwQbyj9QJQomrbyTWVX9MWdGKVvRxI4hV1VSsygQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FzRs+qaolqdOxcTUZyz8YaX4LdjEL3HYTsUpMKckOBVWQ8Ob1S6VMcsckvuT?=
 =?us-ascii?Q?cJnfg8Ve6RnynFCwlyZJ9Iqr/jhgoFoNrtZP21RIPMVf3JNl8VtCWbJnhUUP?=
 =?us-ascii?Q?OJ2ug9h8484mW3RHmBVxosapl7uzdXdoyNg9nmfBaj1J/nwrlc6wAbSUSf1F?=
 =?us-ascii?Q?xmRTF8ueIVGWiOWlqevqrTBtMDmGnTxwNUXxJBx/Y3Cj9feMsPRchBUZeZzQ?=
 =?us-ascii?Q?pceIL49rpcRwJn/JBrh8HhmZcjByDDllXmsWDqBZ3qbjRuGN9Q/Y+lSiCdhm?=
 =?us-ascii?Q?YovaExs0Y8Bx2KQ4157utmsI7hYnqtJH6dzS+fbxiPc7Jz7+51hEgfAk4jRl?=
 =?us-ascii?Q?2hfdGC9am1315IBac/hAiuVF3DJVtFKM5mqc0irIEo8JYutvq2JldIgrMRfF?=
 =?us-ascii?Q?QVvemPMM1FCeYzMMiKJrJuZC8wM3q/+nw3mN+47AU5zgAZVTWBkXl72WPXyD?=
 =?us-ascii?Q?wXNIFWm0LJgwrB6mtPwXFwwjhlLHfET+DpCkVnkNym8KhnDPOuxzKyHxsQ6H?=
 =?us-ascii?Q?PrYu1ZOQILGV6imeqElZMbRV6DIEtcNuZbHEs+rJ1I2579jpO7b0oScqr1nQ?=
 =?us-ascii?Q?2Z3VOgs6+Z+tmOEAIAZmHmNd95Uubgq0W+WD0kFYZkTFrNbUcVxSDX1Hqc2n?=
 =?us-ascii?Q?swoApl9yKtTm8Qk6m9v3sjenBge+HNw3eLFKMQhi9Zp+HEtMx7mKpSqJY2Ce?=
 =?us-ascii?Q?jIXuO29zKJXt3siEU7nHMgtoDwsyHAMWnVgz9Vmj4rjTjMIh8Sh9++9uRcG6?=
 =?us-ascii?Q?yf8UfIgDEoFVzOCnRkjaCqwO01GHt9LZFoHG6nXr7vEb/CAfHZh8XHLeJJdu?=
 =?us-ascii?Q?t260HZ1J1boKzGY0XoDW5vJTAMSM9CnPvVmWaxVY9vGskgpubRR2ov5hdHst?=
 =?us-ascii?Q?E69QS3RG3hatMh1+WVDCoqnYVfNumzuKPLSjQ4bmLmmqGhqvFQW5AfFYzT6h?=
 =?us-ascii?Q?2Il/zAdv1QltnCu1WhqbDovOOGqCJUeqaZNhnW1e6wzl7wnTFVD1ay2F3r8U?=
 =?us-ascii?Q?TnkCCmhMfuIU3Wxh+QEZSdwpyPDkCtguZUw5625zZOEajyJGhGvD6wn5/mbB?=
 =?us-ascii?Q?/5ZfWape7wWami5nmqZbajb50nYntYopCiOxfV6m7hDiLOFdy6hu+7xbESQ/?=
 =?us-ascii?Q?vvaOmkk0LtMVsANUK+4fuliI8jL4Uwp+1ZPtSNio8IQg+l9LHHv/g9hZJ+2s?=
 =?us-ascii?Q?okqq0U3mIIfYkNnLrtfBrsNp8ISq0Iu1VL3hxjU0UXq+ST6G9pW0Hak0pmV0?=
 =?us-ascii?Q?IwjGeCT5FLiGgweyQjWHSZgTVOcEVBECkWvezmN9MsqnnJg0v0Y3YIUbVj3+?=
 =?us-ascii?Q?qEKzu+ccEUXDnTl1DVo0tHplQ9lj8gYeMSZQdMV+6o9eC0ur6JsAqs/WAJ9x?=
 =?us-ascii?Q?TMHQlbmPJiZSfIuUlurTXUTIRrH5hJ0nvhnp0soH8lApdndrVgtD/iOX2uBK?=
 =?us-ascii?Q?Yxyb/ehCR5niGf/v+jcHnCG4O9L08MdLwy+m/uy/cpwCWHSvznnWAqZOOG2f?=
 =?us-ascii?Q?k6e+uXP7BB5hOvWeMH0BaQbiRZjsnquc3W8cVmm3tFLZwlfS2Zo06I/0oLnL?=
 =?us-ascii?Q?L3W9JSgtP76QaceyMQzzCGA2Vw28S5lQ1jPmEotBWOK7K/VO43L7OoXv/If2?=
 =?us-ascii?Q?ng=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f41fb8f3-d473-46a6-5cca-08dc3f430314
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:40:22.6530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzXkSSZ3a5oQHbbDrPQBjKaHcmeOy5q8JUyVn6zpilAC91iLxR5va9L3J2Av03VK/CgySVIclSSGNzBAt83NRsg5OI0ThQWbiWeZqnID/7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Thursday, February 22, 2024 6:10 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; Drewek, Wojciech
> <wojciech.drewek@intel.com>; Szycik, Marcin <marcin.szycik@intel.com>;
> netdev@vger.kernel.org; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>;
> Samudrala, Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [iwl-next v2 2/2] ice: tc: allow ip_proto matc=
hing
>=20
> Add new matching type for ip_proto.
>=20
> Use it in the same lookup type as for TTL. In hardware it has the same
> protocol ID, but different offset.
>=20
> Example command to add filter with ip_proto:
> $tc filter add dev eth10 ingress protocol ip flower ip_proto icmp \  skip=
_sw
> action mirred egress redirect dev eth0
>=20
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 17 +++++++++++++++--
> drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
>  2 files changed, 16 insertions(+), 2 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

