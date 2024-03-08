Return-Path: <netdev+bounces-78621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29C0875E83
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481921F234B3
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367124EB58;
	Fri,  8 Mar 2024 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bG2QXi01"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8740E4EB47
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882993; cv=fail; b=Qcz+MUa2wQl1CaUshwLS7Sd9dYyNopToGvUatR1d+ZK/8ZW+il905o98OEtNo6CH8Dfx6nyYFdexRUZQsl7NxHNnuVjjJFjYJVifcWNp0VKacTg/I4pQF6hNp3U9lSKDS8us3iIkTWFm+MmwYkcc6G72q2KSbcq9iV0MKLqhPvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882993; c=relaxed/simple;
	bh=FtwOb5GZjaOvNyDrJ/Whseia3HBbQfRr0LezmkEvFRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTn+8PK4DzZ2vi5Cz5XzYtYeP5UknXCuEasds6VM6k2TT4FKaOMK3edatfHzs7Ss0ceUTWVfvzdkpvoeQn58k11YDbErZ2HXDnKCJ8+oXGc4AwjWsLHApzzzyHUwqoWKeGUiM+MBPexp2A+4Ey0mqK9kZMREPj+aHoLJMNEMCmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bG2QXi01; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709882991; x=1741418991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FtwOb5GZjaOvNyDrJ/Whseia3HBbQfRr0LezmkEvFRE=;
  b=bG2QXi016L1VAWRzbvGYgKpGfydDTUk3/MdawMjW3BOBCtfKExLLH1eb
   al3mPUePYq9c7mMG5smcjqjLk3xb3v+UKo0YySpQWV7jUyLebPf+z4qRw
   RVm7qkBJeVqmH6gWqLH7cn6r2gc8mst7A7owNdU9qxt9R56PV0XHUH0LX
   Hi58K2G7twAXjSDgCsmxl6nI0KEM7zNLeGmU7EVtiktbgLr3nMsrV1v+9
   YDHN3AzM9KXrINcAD0Aij66f70wBSqeJvTB0UKgl3/x3lycNzSf8Ycfjo
   3Zfu/n2wOGSbDAWd7jVhVb5WT8sC7B+JIVz9fPaLLOC+IEaKtkgpKcO/W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4731178"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4731178"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:29:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="15073300"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 23:29:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:29:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 23:29:50 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 23:29:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNkzElQAkgcRCCykqMRvxmtvD5o3N4BtShiqGG0s0K+VrYaqoIzd17qIpTFzPk+JwWmBKuHv6g7Dg3rGrxN7d4yriGr/S+BFkzgXPEmilG+nLM3LuN0cZszwfk5RbwRTQH7EKAligIlymEJKoDqBTm95w/yltry9e6lIGLrznbwVRINQ8WI+Fbp4oA5ur8ITfByBI16b8gbdInxWfSP9H1O8waMCTBdIli+DUPnuj9PiyS2boi04EtO+q/Wzl7h0KX9EyEvJR2m75GUFbzKO7Yo014oqLkeSTjuW8c6qnHtF3fBy3FvCjEz0zyuncniXFH6szEeeV7yCx1bvy62ldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBgSYkzQUzikiJYWTh3Okdk6b4Ly6grPKj4dT8J3wBA=;
 b=j0DfCFTd7r5NdgU5L7q3/i5JhMJhz6OIapYKsiP8KADSusj7XMEzfK99vpRUAi1VvYIhn97ZhObZ1PPcXrrt1F7meHuIQf6Dr83KzUcQ8DyCTgHvsDVuMaXTM/dW6Zea5Mk5P22IKdgoY19MQyYl7FBERFvNV38yOmbFZyBeX6wy1PQiRdPeJvEbjX3bxp2znXNPEe5womwQxc9rGNP+Fp5QcZg51/Kafe3pp57AERpnHzglS3O41tGQOUD/bKrJimWZrnaug+UM649PWr0RxJDMgoh4oFoujdjneB+V8Cx2KMmVYOGY2j1oC2KVobUnWjBw67CKzB0Fy9zFQ9TfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Fri, 8 Mar
 2024 07:29:48 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2%6]) with mapi id 15.20.7386.005; Fri, 8 Mar 2024
 07:29:48 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "horms@kernel.org" <horms@kernel.org>, Marcin
 Szycik <marcin.szycik@linux.intel.com>
Subject: RE: [iwl-next v3 6/8] ice: change repr::id values
Thread-Topic: [iwl-next v3 6/8] ice: change repr::id values
Thread-Index: AQHaa86jT0x9MOz3Fka0LiHwHGjrFrEtfSEA
Date: Fri, 8 Mar 2024 07:29:48 +0000
Message-ID: <PH0PR11MB501392405BCF0EA67333729B96272@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
 <20240301115414.502097-7-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240301115414.502097-7-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH7PR11MB7098:EE_
x-ms-office365-filtering-correlation-id: 2a26eb3b-d052-41f8-a109-08dc3f4188f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zcF1N3JT+3nkPDatAk8JhY6L5FTABlVD63bLsXbqgpMHQMWaFzdEPj4R/uj1r+/jp6UaimT8pXjyADa3Q4Xo7JGOoukEWXnltt6E2rNK4mPunb0sRV9in3A8Aq8yjKQc3fi2rhDqiyMfBQ+2L2UAiYUmFP+OxNgjUtGpTjXDoyWrrPHMjCWO31xEouilok7KKV+FKlZF2jTpbv/Ro/PqDZmMWpEhJCfznnC+KXk5pbS4xWoRG2ZkWSmoG5dNiB374cS36vThNA1imUMj1K2Y9VJiG16qQbWv+7SOi4ELcBPW7g2KQg+06T71qKanL+gbDSIWEqreit4g8HCP9dkjy/tqKwBFZnbOKFnDG719xOF78fXjLZPGUVA/8+eW5e42Myb0YkYOL7joFfc7FZosmP/ETffyOPZAT1GjUbhXXNDevzkJDpdVAa/xa5bBWTxz/1lnnC7LCN+tDjOsP1qSwRSDIvdB6vytV1d6LhzUZpygIru6rGr4j5Y0Oc5HV5/y1DoLLj3W0luAYsxFMBPCby1zxLVeFAda/wdLwNIAlEVyJNfO0V0YIEeNFqMxTgENAY7a5RAyRDspQZY6BAUbrXP28a+HGL0C9BzOX/7T7aLho1rkY3AKs+hMwZGI3aBSuHHVKKYil92qRuH5lwbbs/Um94eNlLZgfpQ5uHjT0dSEzivEUsYbWKedSAA9FgW45c6nEMzEqTO3fxhMuDbAEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RKa/XbiNxydh1rNN9LjUY/sZZosmZMDv/KJUhrhTDKl62is2E7LR3frJMaI4?=
 =?us-ascii?Q?v8F5FEuIhYB7zJm70GRu1Hx+uq9yYjfTs9kxHBaHcRC4gF+/a4RgTUpXVO5n?=
 =?us-ascii?Q?+qCW/gHh2fZLblrfa02u/12WbT56AOy5F6Il+IDGZ8yGe73DqKu8/jQc74Mc?=
 =?us-ascii?Q?4XsYs1RY2hC4zgbWvTUcJAtsT0yfqvr/BPanJnCRICoPNk7Z7A5d2KKwUTIO?=
 =?us-ascii?Q?E4TwkGt6QLITCGmL/iHgLfbVx9Yi6qzIl5jCjeLOuj7+rDhfG1Tz3xdsuigh?=
 =?us-ascii?Q?qJhGHo/RRmfWI+wsg3DyEvqtdhRdtgoUD2sO2ssfAKB2NtXYJlYeWU9iHZAz?=
 =?us-ascii?Q?ALSTIT9KGETB1Cv0GLv3TOV2oCOGqZImaXTrVp4ilQm0oE1l4brADMBeqhn5?=
 =?us-ascii?Q?Xq6cT9WYvejBUJY7yRenAD2Phcg3YWy0jzp1rF2G6ECMgGcpVHBhKz/mFxwd?=
 =?us-ascii?Q?p1lGfTjLaJw6aVa5PWzyxYblDh437QjOSrZOJ7f+NKKd2uR6KxXNgkcbyGf0?=
 =?us-ascii?Q?dWDiH9HU4ziX/IfxwRKE4WoYAV30emcxASiMPJWLJr4ysPwg8iE/W+tNUnYw?=
 =?us-ascii?Q?roYDo+7tBUEwcQEs2yx8oaNUyiw+EuolV/Ex8L5RydAIBJNts9oDtH/Q58Pr?=
 =?us-ascii?Q?wo0p5MtYcj9nuglvv1mbfMcmH0s6jquBVz9/pnW56+pPkJDndA4O72OT+XCc?=
 =?us-ascii?Q?2bAkbK4VzoWi1alopQbz0cBfdWfczC8BgBkZQ5FbWdOYLzQKu5NH6t7G6D62?=
 =?us-ascii?Q?rZx7bXttudLrEband8eGRwx+RSeQxagNVSUqrvi5lkEZDswy10iOWHBDSJAH?=
 =?us-ascii?Q?q0aiNNHBbnF5wF4OR/SLQpm8WBm/itGNKMZCRk0RBeVwr2Ve7X5X881hkcTb?=
 =?us-ascii?Q?ran0Uk+62jD3RAJ2LQ2JmUoIZSHZM44CSJYmtmSgkTurYmad3uS5G/AE8c9e?=
 =?us-ascii?Q?Cl8NUY1cLXq+5FiL7xbAxN9G6WJadOvDipW0uVaBOBQyXQg0vJte7Ppswlcp?=
 =?us-ascii?Q?lgTpqiN16z2sEKMJhvXliJouWKq3PLU5kS5TouD/AQU8LGuyZm8l8zN5P/nl?=
 =?us-ascii?Q?2d3oWOAhS6hZcDAntQf9r3Tza+mfDSjBxPi5Z5IougI1/+UVyvRytrfMo+uH?=
 =?us-ascii?Q?FZCJcoiTzt77w9T0SPGAD9FLOMxXsYCPY1ADPD7QoV27nznGYCx5bnumD8wc?=
 =?us-ascii?Q?EpTzmNi2zmrQpe2Cq2Mm1YEtg/DirHHU/cPmZP0yXfUJW6mtGyN8qy06ldzb?=
 =?us-ascii?Q?pATIOBDz15xPogNK0mfmnZXm2tooWmV2rZ5N8XMyZZMv5htB4qsSB11Zq9uB?=
 =?us-ascii?Q?p8LUSRF0S+OtofNHzXqhubyj6yOLzHWKL3rSsLD3sGQUfoNeTweyp4RL1HcF?=
 =?us-ascii?Q?9E8OAhS5dAwe6wy/3+gnOfMzjtDn/XpJ0kuVNIpgNW7BSClP8Xk5wYXF883s?=
 =?us-ascii?Q?3uK+jwi+IzmOgrB6s3lO12OxRHhySe4LWMtNq3q4vu74t2HK/l1Ll0qirTQQ?=
 =?us-ascii?Q?uWwB3DeZnGvVQiB0Vto4fOlsFE9Lw9C8nyo6EQnY+mj25RYmcGduFVUed3Ir?=
 =?us-ascii?Q?TusrnuR0Sg6rM7SXSUd1qX29lA3YzIr8RZp8cMqx2vHcfPsVZLNLAKJ/dTrP?=
 =?us-ascii?Q?zQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a26eb3b-d052-41f8-a109-08dc3f4188f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:29:48.2682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E01hYR/zLFmcQsc3uKL5BVtcwERLdYDIe41MyJoFG7f7P4wlfPbDMofT+wtvngq7FeSEOI6VUzUd3bvV+l7eWvUrR5atgePRn4JvTlXr+Bc=
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
> Subject: [iwl-next v3 6/8] ice: change repr::id values
>=20
> Instead of getting repr::id from xa_alloc() value, set it to the src_vsi:=
:num_vsi
> value. It is unique for each PR.
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 5 ++---
>  drivers/net/ethernet/intel/ice/ice_repr.c    | 1 +
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

