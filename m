Return-Path: <netdev+bounces-73828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A817E85EBCD
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 23:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BBD1C20F13
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F612AAD1;
	Wed, 21 Feb 2024 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+FDW94D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1612AADF
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554615; cv=fail; b=bFraXpC7teL/CAYCYuxkBS+XMAX7MRGeaC9E59IRUieUh4srVFy1A9wgKD/oB3Wkvk05x9X+uJ+gJHLDsIkulkx1mh5S36YxE+kMfKsNKgzpFdgIQRRQHNKTRweEWDXltZpkgP72g/FQHYrGZAwzzRHm073kelv/M2DmdRg9rrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554615; c=relaxed/simple;
	bh=jedJ763H+n2zAH/YrGQgy+sG3IBGIVybsDMgEQtmjEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U1c8gSo1VUq6zVbQ58+MxR1Aqp8zk+g7/P8L8ogi/QEZowNpJKasGnUM8VLNmgBRyl774khPjr7CPljtp5IgIYVAttGCOfyJLMRKDCvgG3k1PxJwmJW6Yuv/q2pfa4jGBIc3cV2YiQiMn0lyn4rcR1vNS7+FjViE4KoSjxtRLSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+FDW94D; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708554599; x=1740090599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jedJ763H+n2zAH/YrGQgy+sG3IBGIVybsDMgEQtmjEU=;
  b=h+FDW94DG7vSUcvhwO8RpshwJ4IXA9aCT19PJ0lq6HM9pT8+6E3fD4qO
   9P4UhcOBUoned6mgflUUrxXzjSAV0J9KbtcYgy12vjjcNXznl2jkVmi9/
   3ank/llmk1JIdrwfyLqbA8Q557mPrFbTbp4ylIhlz0bmoSVGJRWaUNw0E
   eI0W6f1fl/YAk6i79gCcBoFOkuQ5CdYhitU2ah+G7wh8Cg7TcOwmOcsYy
   ErCQyOVIa+r1Ys170l42/S2mNugu0lPRkM0SaP34Mamc9sdrpBN9Sc0vF
   oU4Qf/wXi5bHb14TivvbSM3aK+yp4WflHPjdKU+grhfaZ1Htn3bdCy0cJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2608259"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="2608259"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 14:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913388283"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="913388283"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 14:29:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 14:29:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 14:29:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 14:29:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 14:29:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2lVN8Ss97HRFENz0BGI4oUOtveD275K7XgoEclx6cPrNHIIMV9iuCBEy8/93J7vh5wKKomxfvBuTyX+gH33hoU14UAC9I6zKUSiopBVrEVeG7Bl8A1L0B0gGDhHY9rQHWm01wZGii1XNApfRUyI69JST6YEVLgrk0EEzJHzCzfxBe0O9UoazjavCtmrHpjxb82FZ+gitAa7kebkjESX/usGz45P14IeKccbAub4oRTwohY03x0f7T56o1wrQi/9tyxkOoI10a69Z+PlU6OeRdxIpAfwSTn+68oTBPwDXhGts/l7dYpdsnQnDJqzb+BJV2tNPnhkpT5KOQi2MQq0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPBJynopR5c9zE5Vk4aH27gd0dplLoxS6ZGUOXGlWkg=;
 b=MsYLB/Ny5/Xhf5k3ZUcJLOVxlq4t7QSm3fsYwg+RTgInCt0GOyTQGImem7R14/aFhaNMa3Ppe+VNpT7iU2xp55xKyOTitZ+7nJz9Ud9O4zhNB+WqCXqwad+cFSlzII6qK5ae/YxKiqlcBynSclZjgasDO5Ok1/Y2mJo4mgdv19C3v/sYhvKXATVmmVEKq8bV2CgKn67letpN+7vZFkgpU2N1fxIBkxIUWd08DMC95hIie0eQZOuhnzzymaFxb5l3S5GEmkI2WTUNKBM28Lp6MBQGOAJYojnZ9Q/z+6W7t4BI8e0zhGsUi+DAdwn7EFp9R0il826yikgFp1OaVUirJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 22:29:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7339.007; Wed, 21 Feb 2024
 22:29:23 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "swarupkotikalapudi@gmail.com"
	<swarupkotikalapudi@gmail.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "sdf@google.com" <sdf@google.com>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, "alessandromarcolini99@gmail.com"
	<alessandromarcolini99@gmail.com>
Subject: RE: [patch net-next v2 0/3] tools: ynl: couple of cmdline
 enhancements
Thread-Topic: [patch net-next v2 0/3] tools: ynl: couple of cmdline
 enhancements
Thread-Index: AQHaZN5HLbveXnfUIU69FZv/DjU6jLEVYPVg
Date: Wed, 21 Feb 2024 22:29:22 +0000
Message-ID: <CO1PR11MB508993726E942F2638B1A0C2D6572@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240221155415.158174-1-jiri@resnulli.us>
In-Reply-To: <20240221155415.158174-1-jiri@resnulli.us>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|BL1PR11MB5271:EE_
x-ms-office365-filtering-correlation-id: 53881cc1-8d2c-46be-5e81-08dc332c8dc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EkIGuT1kvJenVg3ZB8Eabeh5dEU4NEK/qPR+Eb/fV3yHmkYX6Tz3ZEn1DYXKgQq/poJiUxzcZXU3SobC1aPd9NGfgfYxKcY9nZzlgn45pZUA8/05PFYjU7H/0zvpW85m88gfcZP9GHettO2tX5SzYjyeTl6MjEjcr/gopiW6dbSPVpENHm/7s0Zkmy9JewXWishVQYHfGhPW7BMySqbVSa3CYDs4lmCXhAUuulkwZqeMHwwqbDDhoQz/4zyUOEMC5+F0ljvwOTiQJp5ZSgVArLUw8i7iVa/EHrcD8fWCxQ0Bq4peMshYtCCQFJd0m/eFM3sNWvvB2cSrHOTyrdOwD0ikBK9o6eYdRW8H+M0eNG5cgMph5aQ3YA5aqNKUbsrFYwoGw3mRLjz+3yqiAjYq3SJH0XMGmnCJTFtpVUMXWXqdfy0Wp/BJw2FBySM/ZX3KdJIRlIbxAES9f7rCJtUBPo+BnfSgMCXdtprr4RN20gDu/kPulqs9OpPvdXdzU4uwR9DKgtM2IiL5MNRls/1VRJCaq2hvy2Jtm4TeqnU71w7Lmrdtq32W8lD76MW5w6LS3R3yepEcYnnu6+9rIM10cIOJnpxVwhx5OL6tzJV50WQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V3pAgNm3693tqfunYiQt9G5thkvV4pLO0pBB/hUoL2uf2pYSgIRV7qIhRxEO?=
 =?us-ascii?Q?Ajh5KDMb0XNJcaLl0/1k9+wkBmwooppK7a2QJ1AwxNO9MxLyf3f6c1RImp+O?=
 =?us-ascii?Q?fQRu5dTqkSB3dzsOBHSmpkP//synkzWo7IdtT/PHov8HWCZoTuACnzdtG6WX?=
 =?us-ascii?Q?uSx2ABh84ZfiWtOaawKIpfuKh++1aiTVVN8ibEuz1+IW0dHS2ginc1112GHC?=
 =?us-ascii?Q?xFLZdXIgSMB49gsoV1efueZDgHW+QkQtfxcd4ISSECHjEqBh/GEDqV6qbhiv?=
 =?us-ascii?Q?7I7q0EMe1IXOMxGdD+8PiY8p78QwDQ32aCNmfRX7An698vkixmiD5zCdNj7v?=
 =?us-ascii?Q?35ObPmIrf6STP+9LbCFR1B8n6N6Qq2IkCfWwNlAryOYmpHnZ1jr2CFNsDFDu?=
 =?us-ascii?Q?8ozl5mmuZSrCSU6LX0SfheM1UwP86ZQJApzaRqCpoRzxiTolmFWrg9odQ0l4?=
 =?us-ascii?Q?qtsD0f2fi2EMghK48ToQNBcahWpKwd2seRgdcYzcOrQtB6LMmOElZNhmgFV7?=
 =?us-ascii?Q?4Er+NEXWQ7k2BIJP1u6dLr/ngULyBlUDx59x6nLIt6Q+4HIKY/2S8BEnthmh?=
 =?us-ascii?Q?l996LFk/CtnleW3UijeZmoKoEztxBapfd1Q22HjoZHv1w5khdkGQwFzW9y+G?=
 =?us-ascii?Q?YHjr1AXQrkwJ0/0bo5EOpguwkWfpl+7VxfryP47Wqw7EFTDDFyfpKKO5ge1h?=
 =?us-ascii?Q?IuHo4ICg+ThUrpgBg0lJEyR6j3k1ZoHue0mO9N52zdMBW/jQpX81z5W33i/W?=
 =?us-ascii?Q?9Sx0sBH28RBly8rPwjoFu0Z3nTnIbO0xM6N4Wny3aBu2RA1hWbjkrXsT1xrB?=
 =?us-ascii?Q?NgXlKB5ST4adLQCqberwvkbGa2D0JSdJ0p4GhSvWlPdyqmO/jIAOhCyq7cRu?=
 =?us-ascii?Q?3sdT6dNQ0bksYK/OCmI0E9WaGKdD3vOGgW4FDyNwL4xf82NlLtZRWz1SyxyH?=
 =?us-ascii?Q?T+r+ZAwv+6nwzyC4I9u1luW2rPf2BXm//tBRLqRyuEySlYzPGYtdqzcaHfgi?=
 =?us-ascii?Q?RO+rZSvIemg/CPejJdvtf5+Z28YWVvcmyayO9pU+U5WfBgIoAhNSX9z/bNfk?=
 =?us-ascii?Q?h5tZ/l+xunR2luMxtRxg1SLc39iQ363cJOnWeUsDdzFun7+1dh3vIHHFHhDD?=
 =?us-ascii?Q?jEhXFXobF2r6rbK8EO3FQFXVxxbN7bpn968IAn8Kghmas6FaV8ytyh0bU2NH?=
 =?us-ascii?Q?p1H9FELws6UJZsv7sqYhp7l4777LV4k50h7zN6C5TK6HLxP/7rpReohMVA33?=
 =?us-ascii?Q?p6gx/iBz6ccwqwStlCp+akLRyJqb1Fuw8+9JBQRgbXPe0mDoMwlnpgrTzt+5?=
 =?us-ascii?Q?AfDOJh9iaWcjoOtBoHnEydDWzdw1GTVoy/+2HMafBiQfbMw4MXW/oxWMXw2C?=
 =?us-ascii?Q?AU7lSriDpw1y4sA32VhnFbzi+PLXO/WvGFLltToJOgTDBCu7+j9XgkKloult?=
 =?us-ascii?Q?V0j19wgooVFmPHkOLo6OrSrEAFYzNg7PJPw/SRjCSY8eM5fdOsY/D3O13Bzs?=
 =?us-ascii?Q?wO14oic9dlD+8Z6fiZrRliQNOs4fFkaKy9WHJfbnYxxPSneCjfcUI/J4xrY1?=
 =?us-ascii?Q?9mtUmMiBtp49FLuYAiiOj75dnIMTgeeLqgEi4VYE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53881cc1-8d2c-46be-5e81-08dc332c8dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 22:29:22.9645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8KN0Mk+dAy2ITTFJrXOg113GV2u9X1nJQGcxwBz7x0eXTYT7IijUYuSa3nBVVYHwaZBLu2lC8jGzkFHoBLYIBpZU7G8N0MIp8bQYmDHtvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5271
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Wednesday, February 21, 2024 7:54 AM
> To: netdev@vger.kernel.org
> Cc: kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net;
> edumazet@google.com; Keller, Jacob E <jacob.e.keller@intel.com>;
> swarupkotikalapudi@gmail.com; donald.hunter@gmail.com; sdf@google.com;
> lorenzo@kernel.org; alessandromarcolini99@gmail.com
> Subject: [patch net-next v2 0/3] tools: ynl: couple of cmdline enhancemen=
ts
>=20
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> This is part of the original "netlink: specs: devlink: add the rest of
> missing attribute definitions" set which was rejected [1]. These three
> patches enhances the cmdline user comfort, allowing to pass flag
> attribute with bool values and enum names instead of scalars.
>=20
> [1] https://lore.kernel.org/all/20240220181004.639af931@kernel.org/
>=20

This series looks straight forward to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
> v1->v2:
> - only first 3 patches left, the rest it cut out
> - see changelog of individual patches
>=20
> Jiri Pirko (3):
>   tools: ynl: allow user to specify flag attr with bool values
>   tools: ynl: process all scalar types encoding in single elif statement
>   tools: ynl: allow user to pass enum string instead of scalar value
>=20
>  tools/net/ynl/lib/ynl.py | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>=20
> --
> 2.43.2


