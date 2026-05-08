Return-Path: <netdev+bounces-285848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH1QF+/o/WkPkgAAu9opvQ
	(envelope-from <netdev+bounces-285848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:45:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C66C34F7493
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEC84311EDF4
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18141327C09;
	Fri,  8 May 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrJTuAQ+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5F3E1D11
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247451; cv=fail; b=o+XlPeGoTFqPNdhQVTsFbU+emSzhbNvcFbta5AzMgdXt80A1sgkKWuKoGKljD/+4OZ4/Bk0o6r4f5zr3XY3p20h6AOkFST+K+tvJ5JlLU1503vfDtTtQgO/RCxejwLd4H05vOpmoEAEkK201qivsZtxIDlU17oUqfn2tbzI4Xpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247451; c=relaxed/simple;
	bh=eV8Bl65YRVhsByDU6NzqFPfUCioMZJnME8Xvvz0jFbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NOG+GAmUU+fqq6AQQqs41OptI+JerL4wLCZwNF2XOhfNIVbOGDaFchd+vf21O+aDDEgMF5ukCTCs+LNQyEbjkmsDKIvGTSbsX71CT08lFSTotFvkt7TZWVsAtfkdLOc0Vb3ZmXk+A+B1bcDHXLyYAZixgNOKs1nihQI67GKpobw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrJTuAQ+; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778247449; x=1809783449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eV8Bl65YRVhsByDU6NzqFPfUCioMZJnME8Xvvz0jFbc=;
  b=JrJTuAQ+pYgpdmnGTu9iSvrGBdIpOyp9W0P3uTNZyUDQHB07xO+Bee3V
   4ChR0A4lzGwBf05DLaVLtqBdHYOnqUlvjNIrWgscOzlkAKSM8SbsiwVUe
   meg93fg8G5if/Y5/jrSJ40ZEcIvfQ51Y+IrbxN/0IyBwAfBefxxJDgCWM
   6jTbG+FavlPZ0snWwXcYwU0rhyF1IpMIktQzPmIPP6EvrFVoxlWU0xKWV
   t7yGO71YDE3mNduhaS3rtkdRZXModKNL1kLDJURZqHmjlgX8ye3K94CD8
   ENrEuaWhcqkuUBDLzvI9YFtSGKstfpnCAB/ejLJu+UdripFQKb4tvdQmq
   g==;
X-CSE-ConnectionGUID: EzTUqvFuTfqPZqeqczX3FA==
X-CSE-MsgGUID: uK5bMdUdRiiG1u4Z+3TiaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79232957"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79232957"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 06:37:29 -0700
X-CSE-ConnectionGUID: M9rgB3fyRCyjCkjdXTI1Ww==
X-CSE-MsgGUID: 8/B4wukZRWCFFCIGNezIQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="237013945"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 06:37:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 06:37:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 06:37:28 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 06:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuyszdMtQ50xu/cmGgu5ZGf2Mzf3QJXp3ABaouZNUfSGc1yi4j8O1cUsFrcvhbP6JyTYRZRjTOe1DJXr3eBJrWj9oZkaTiB/ye1uXlyUOwFqvKdnH2XwHLTakMiUL8ZwqfYTyMyk5VUWJifksWx8RNo4eTK7/NhvxQ/WgfwuybKDWfGnCgTBo7akn/s+BNImC56bY+p9OrlGRp2AStOGHR8LoWBaMkziX4gMmGL+c2eJIjF11nlrtbU5/y9KfjiBo92sfnzC11fjx8eFW5ar5zuOu+bzaAaeqn1OVvffL16kBu5daORI+R0Kcsec2ySNpvLg7TeCvJrCWm6fmcs1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp4+v2g2U9dqCZzgMDD2da+YjejxgSboRnfIRheXi6U=;
 b=VClj9fc2zDIc88oJ1688jYi52/Do0IH0EezsETkl4xVcRcWYERnk2Kv6s92n5+Nf9VdSnUodXtYvQTRg29UnVKvGkwZNW2s70/B6iJ3QoHWXcGipx8XeSsutHK+7RyNSQSQm1uZ5JHXEEaxzkp4Jqpj2If5RH6gl500DBQoGtLtw6eDWWgBW183Wy3yJI6XOMjk60t3eNRHDsyF4V+NtNkzCSNZtxgMdnhgyvLnbYCSGw06FBphCdJ53bASWnR5CsHrepFYWDSQIDAzEHb4EL34dkpR+7XKAMkOW0rVw19b/VoYKrByJe23KiccLyQzKdsuzIZfnMFQ7W2AbD+ygtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH8PR11MB6927.namprd11.prod.outlook.com (2603:10b6:510:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 13:37:22 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 13:37:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Schmidt, Michal" <mschmidt@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, "Richardson, Bruce"
	<bruce.richardson@intel.com>, "Medvedkin, Vladimir"
	<vladimir.medvedkin@intel.com>, "Connolly, Padraig J"
	<padraig.j.connolly@intel.com>, "S, Ananth" <ananth.s@intel.com>, "Miskell,
 Timothy" <timothy.miskell@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Drewek,
 Wojciech" <wojciech.drewek@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>
Subject: RE: [PATCH iwl-next v1 04/15] ice: add VF queue ena/dis helper
 functions
Thread-Topic: [PATCH iwl-next v1 04/15] ice: add VF queue ena/dis helper
 functions
Thread-Index: AQHc3uqUi5ar39LJOEOzEd4RVWLatbYEIEsw
Date: Fri, 8 May 2026 13:37:22 +0000
Message-ID: <IA3PR11MB8986D8AC00918C492A712404E53D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
 <20260508124208.11622-5-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260508124208.11622-5-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH8PR11MB6927:EE_
x-ms-office365-filtering-correlation-id: 07aebb86-4f4c-4a4f-ed96-08dead06eee7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: dMtOY2CzxFIOVlgrG1PnWx8fKZMUDD/FZbVrR4lvDw5mSqnJyGeU2tdNuUKhhSsA79g0picHEnTBgPfIF+ON9eD8ucPdrCseNNEgK9q59Kbb+CiL8w6jOQ0nfDogNav/ggNhDslP30r9Wi9H83dVkZ3CRuHNWmxTN0NeZUku+U/Fzj0RDPo4Ziku+9ktufYW6ripF28I7DTmFZsQKUtqZN+ATJSCUZ1OWAXeb9B50mwZO1KvzB7R1EE15GpkNnzyxZs/J9dkIUBZg2jzEle0Bcf7jDTGGre1pL4pKFHCd7YSizoioP8cAuZp7DQyqZTXArlWuxtlBt8PDzqpYcVWuCFrQ82wfAzv2aKdht/PMMFRZDxKtTuH0fkKBS8hy26d4tcAVm6T/YopoDEpy0qUftP9UE1AYLC1h40+iwNoNotvx/zPVYPiiCjcXW3q4spi6C3ArTn2xVPznYp06woj+PsDXu5OaAfHseL0Ximj4+AhG0KPQcTc002FrZDqVsLdx5WxKYjifHNCz06zhnPisYvFh9lS4xkZQF2UyYsn1GPD/f1FvAuTQq+7V0KinNL6+K0uMBc+eLyAnULrfI+/5hkTkdgYV97uocJuUTeY8bJziGcsCVG+YTPRfeNfMC4Z+tWW+eLPzYYkhySHgRMwS2tHZAZxHZxDEXYJi+A7+f99nlCbhUjMVJM5xy4PNaW3QVBUVI17G/YpXhWXXX6dJ17G8Xz+yTltGnqWVCz2G0vbFALrfbLqCjXDSgWQbnQJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MpAepaxzC5NkESSSYeLO5Ruh00PNJ/DFfB586p+8Wx419/NvYodNV4WffeQG?=
 =?us-ascii?Q?Q9YFrQCE+QAf+H0ncGYzZY4mf4vU2+jg2gac5y8CSERglLzUH5n25dLuK9OV?=
 =?us-ascii?Q?xRTyCTy5ibBZs27hLjpaRc+4NlsxxXWsYVFvHOIEjlPtuN1xJOQntmKbo9vM?=
 =?us-ascii?Q?XUwDclflevuMc9AzrHSCwEQY8n+yXwZ4asP69OlEQe+uc0LigWNWinnbtoDW?=
 =?us-ascii?Q?tul5B71+7JRsD5qbKZTovnx3qIyd/RZvF+LyNtLFKgafmfoynnPEY098EZ0A?=
 =?us-ascii?Q?qMK50bS8hkP65/ta3VT3kzgLwRqbtSd0pLrIA4ZyDIslOdO9Zg39OmksodHh?=
 =?us-ascii?Q?NV6UAlSLZii3HxUr1PrULua81Focv+geoYqlpdp4U3kMDmDqolhj6wBCNpk+?=
 =?us-ascii?Q?r0AJin091bpAurzqqwxCUxCRDMsBFbwcZq65ntdzrWe1mWZ554YuQ6AiThvF?=
 =?us-ascii?Q?1fG5CQ9qyWIPJMglu2t77zSuot1xLwgAqpabnBrMyWQ81s26hI4mZdoD73CY?=
 =?us-ascii?Q?YPHnS56i1AEcM+4D9GT6rTRhNqzGkyt/TtHXe7mRfbPE/ch6PI/yfKPmMU7Z?=
 =?us-ascii?Q?tc+czKlrDonVZ85ox4LXfaP2RQZj9ZVGnIvgBWdk2irN5Xv/okhT5BvdP6Xg?=
 =?us-ascii?Q?ZK3GUYZbhuJGEIxhf41VX+IoGpsnKTcYDKvfx1Z2cCR9+6Z+em8LDVMkhkGJ?=
 =?us-ascii?Q?hYVcGbvf6sfqRfPbAkn1nUIjpVbI4YoBjLWiFD604wb6gLM9LH193y6wa7GP?=
 =?us-ascii?Q?bzuhLd1W/W0dL2BK51gsjrG6wKH5Kq+Mrdna4ekQPK/X/HJwq1DJFS/Qsd/y?=
 =?us-ascii?Q?I/gyCpCfEiyLgSUT+HtgtBaN4S4BCpREiX1OOs0RAtH2W0gZuCuLig/RQI2E?=
 =?us-ascii?Q?MU/f0ofbtaPiGxdJOEy+w7duBTOoFvOkm+JTA6+yxbYxo5zmXOvsyOmBaNXs?=
 =?us-ascii?Q?Iqe460HdYl2aRS5aydqn7Zke6wy7GfIumOJ5aSi+Rc4jiescNF1xXhixrpgW?=
 =?us-ascii?Q?CCTJSg/D7l/kbpUYKxRRSKkH6JSvzt8Bt5zAeDPU3zjTt3NBTKjXBr5fbWE7?=
 =?us-ascii?Q?hy2lmod7f3kf+oQ0MzEmCqzi2FlIHPNBu+7ZlaIuqTG0tarVNy2lo/hfbcuN?=
 =?us-ascii?Q?jIK3zYjI7LXb2S98TUx/ZJyh6IfMBk8heEJxVeT7vI2NlGSf+Z5gZFBHw9jZ?=
 =?us-ascii?Q?ZDAX16K77Sp6nODXzYdJPZ6z1OzbTkqv/ftyUitqBD7wLNW/ooZhFFWeVYOI?=
 =?us-ascii?Q?4lmAMHh4w2/YJWgC4HJmwQAfQSR4h9SOXI9hqq1gPMqO0PVNIITGo75oEn+H?=
 =?us-ascii?Q?U7iEtbVBugk4Cq93B7/639UdqgxOJXUBH+c+DEX95BMoZSSxeq8uPzbT9qDo?=
 =?us-ascii?Q?/RUF5fiSK+V0xViL2zvOl+9wGdzXEhzAa+wHFmL0eoGMXbOpEwfrtQDt49PO?=
 =?us-ascii?Q?XRqPH86v8AQ0T0S/AcIP2HxayqcuNXHayd50lKTABX9CxSLJ75EW0X99RhlQ?=
 =?us-ascii?Q?0P0KdMf7c6dy7q46EvgNexQRxYrIv/9+yYFmH1CqzO3ZpgEWeg//4O73Hnay?=
 =?us-ascii?Q?EK//qzIWjfS+odr/y3skTt8lJfnTvSfbhsBwzuDFr2gbDmFiAflP6Dh9dui1?=
 =?us-ascii?Q?lN4XKY+YNqWZu4+6GVmRgGU9r00JhF5HU2+994utvn4zYgXA1BQWdtd8VK34?=
 =?us-ascii?Q?0Yq5NGQn/XnWuUyVCwzUbP4c4zhsrwjWofq7i60L3GamEFXyTx45Utct588w?=
 =?us-ascii?Q?1bXGXpnlH+k+GaA+arp5LZmwt4tdMPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZSQI+DRw4EcPX816pHLrO/p5IEM0RjsBAaaG3A3Zp3e02wRh/qFQ01QB752zwCPVkuA7fJ/aXZoMCbEmpXcuLPuJCarn7dhkVwBtK4q/wseca6k/kO0gRHe5IEp4lfpHUV2p4Rji3PdU2RRM9C0cl7bS/8ABpKtgkKeA+W0IjS7m9qtamj4HRbrRdk8WZ8PBHNXdeJAeWdfzFGdRXkJ9Sqhezy4bJlFgHWYfULM7ytbhR0Ctuh55DEdaHPvRUr+kWFnD8jRIWKw6jNrMtgrHfCXxGXPOPywlNA+TiSACwIHbo2H4UIoeql6zMnlTI1Nx/rHJjL8D5yVQxC3zlpGNMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07aebb86-4f4c-4a4f-ed96-08dead06eee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 13:37:22.1626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wf1PUn/6gQAGRxlgthp1STcl1AUuGssj8m8YhNd9cjPphQcg9lIFvq0fbL2kC5ImBWb89/rC7T7MGVAaAHbIwjxkRHYLXOoZwcKNXkZYlsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6927
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: C66C34F7493
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285848-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Friday, May 8, 2026 2:42 PM
> To: intel-wired-lan@lists.osuosl.org; Schmidt, Michal
> <mschmidt@redhat.com>; Jakub Kicinski <kuba@kernel.org>; Jiri Pirko
> <jiri@resnulli.us>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Richardson, Bruce
> <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Connolly, Padraig J
> <padraig.j.connolly@intel.com>; S, Ananth <ananth.s@intel.com>;
> Miskell, Timothy <timothy.miskell@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Czapnik, Lukasz
> <lukasz.czapnik@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Saeed Mahameed
> <saeedm@nvidia.com>; Leon Romanovsky <leon@kernel.org>; Tariq Toukan
> <tariqt@nvidia.com>; Mark Bloch <mbloch@nvidia.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Drewek, Wojciech
> <wojciech.drewek@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>
> Subject: [PATCH iwl-next v1 04/15] ice: add VF queue ena/dis helper
> functions
>=20
> From: Brett Creeley <brett.creeley@intel.com>
>=20
> Add three new functions:
> - ice_vf_vsi_dis_single_rxq()
> - ice_vf_vsi_ena_single_rxq()
> - ice_vf_vsi_ena_single_txq()
>  (ice_vf_vsi_dis_single_txq() was introduced earlier.
>=20
> Those functions wrap operations needed in the processes of enabling
> and disabling single Tx/Rx VF queue, which are:
> - check if the queue is not already in desired state
> - perform the dis/ena operations
> - bookkeeping of the queue's state.
>=20
> Future commit will use them from another callsite.
>=20
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/virt/queues.c | 111 ++++++++++++++----
> -
>  1 file changed, 84 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c
> b/drivers/net/ethernet/intel/ice/virt/queues.c
> index 6e4ec681fd07..28adc24197b8 100644
> --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> +++ b/drivers/net/ethernet/intel/ice/virt/queues.c
> @@ -224,6 +224,57 @@ void ice_vf_ena_rxq_interrupt(struct ice_vsi
> *vsi, u32 q_idx)
>  	wr32(hw, QINT_RQCTL(pfq), reg | QINT_RQCTL_CAUSE_ENA_M);  }
>=20
> +/**
> + * ice_vf_vsi_ena_single_rxq - enable single Rx queue based on
> relative
> +q_id
> + * @vf: VF to enable queue for
> + * @vsi: VSI for the VF
> + * @q_id: VSI relative (0-based) queue ID
> + *
> + * Enable the Rx queue passed in.
> + *
> + * Return: 0 on success or negative on error.
> + */
> +static int ice_vf_vsi_ena_single_rxq(struct ice_vf *vf, struct
> ice_vsi *vsi,
> +				     u16 q_id)
> +{
> +	int err;
> +
> +	if (test_bit(q_id, vf->rxq_ena))
> +		return 0;
> +
> +	err =3D ice_vsi_ctrl_one_rx_ring(vsi, true, q_id, true);
> +	if (err) {
> +		dev_err(ice_pf_to_dev(vsi->back), "Failed to enable Rx
> ring %d on VSI %d\n",
> +			q_id, vsi->vsi_num);
> +		return err;
> +	}
> +
> +	ice_vf_ena_rxq_interrupt(vsi, q_id);
> +	set_bit(q_id, vf->rxq_ena);
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_vf_vsi_ena_single_txq - enable single Tx queue based on
> relative
> +q_id
> + * @vf: VF to enable queue for
> + * @vsi: VSI for the VF
> + * @q_id: VSI relative (0-based) queue ID
> + *
> + * Enable the Tx queue's interrupt. Note that the Tx queue(s) should
> +have
> + * already been configurated/enabled in VIRTCHNL_OP_CONFIG_QUEUES so
> +this
> + * function only enables the interrupt associated with the q_id.
> + */
> +static void ice_vf_vsi_ena_single_txq(struct ice_vf *vf, struct
> ice_vsi *vsi,
> +				      u16 q_id)
> +{
> +	if (test_bit(q_id, vf->txq_ena))
> +		return;
> +
> +	ice_vf_ena_txq_interrupt(vsi, q_id);
> +	set_bit(q_id, vf->txq_ena);
> +}
> +
>  /**
>   * ice_vc_ena_qs_msg
>   * @vf: pointer to the VF info
> @@ -272,34 +323,20 @@ int ice_vc_ena_qs_msg(struct ice_vf *vf, u8
> *msg)
>  			goto error_param;
>  		}
>=20
> -		/* Skip queue if enabled */
> -		if (test_bit(vf_q_id, vf->rxq_ena))
> -			continue;
> -
> -		if (ice_vsi_ctrl_one_rx_ring(vsi, true, vf_q_id, true))
> {
> -			dev_err(ice_pf_to_dev(vsi->back), "Failed to
> enable Rx ring %d on VSI %d\n",
> -				vf_q_id, vsi->vsi_num);
> +		if (ice_vf_vsi_ena_single_rxq(vf, vsi, vf_q_id)) {
>  			v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
>  			goto error_param;
>  		}
> -
> -		ice_vf_ena_rxq_interrupt(vsi, vf_q_id);
> -		set_bit(vf_q_id, vf->rxq_ena);
>  	}
>=20
>  	q_map =3D vqs->tx_queues;
>  	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
>  		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
>  			v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
>  			goto error_param;
>  		}
>=20
> -		/* Skip queue if enabled */
> -		if (test_bit(vf_q_id, vf->txq_ena))
> -			continue;
> -
> -		ice_vf_ena_txq_interrupt(vsi, vf_q_id);
> -		set_bit(vf_q_id, vf->txq_ena);
> +		ice_vf_vsi_ena_single_txq(vf, vsi, vf_q_id);
>  	}
>=20
>  	/* Set flag to indicate that queues are enabled */ @@ -351,6
> +388,36 @@ int ice_vf_vsi_dis_single_txq(struct ice_vf *vf, struct
> ice_vsi *vsi, u16 q_id)
>  	return 0;
>  }
>=20
> +/*
Please use linux kernel style:  /**

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> + * ice_vf_vsi_dis_single_rxq - disable a Rx queue for VF on relative
> +queue ID
> + * @vf: VF to disable queue for
> + * @vsi: VSI for the VF
> + * @q_id: VSI relative (0-based) queue ID
> + *
> + * Attempt to disable the Rx queue passed in. If the Rx queue was
> +successfully
> + * disabled then clear q_id bit in the enabled queues bitmap.
> + */
> +static int ice_vf_vsi_dis_single_rxq(struct ice_vf *vf, struct
> ice_vsi *vsi,
> +				     u16 q_id)
> +{
> +	int err;
> +
> +	if (!test_bit(q_id, vf->rxq_ena))
> +		return 0;
> +
> +	err =3D ice_vsi_ctrl_one_rx_ring(vsi, false, q_id, true);
> +	if (err) {
> +		dev_err(ice_pf_to_dev(vsi->back), "Failed to stop Rx
> ring %d on VSI %d\n",
> +			q_id, vsi->vsi_num);
> +		return err;
> +	}
> +
> +	/* Clear enabled queues flag */
> +	clear_bit(q_id, vf->rxq_ena);
> +
> +	return 0;
> +}
> +
>  /**
>   * ice_vc_dis_qs_msg
>   * @vf: pointer to the VF info
> @@ -415,20 +482,10 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8
> *msg)
>  				goto error_param;
>  			}
>=20
> -			/* Skip queue if not enabled */
> -			if (!test_bit(vf_q_id, vf->rxq_ena))
> -				continue;
> -
> -			if (ice_vsi_ctrl_one_rx_ring(vsi, false, vf_q_id,
> -						     true)) {
> -				dev_err(ice_pf_to_dev(vsi->back), "Failed
> to stop Rx ring %d on VSI %d\n",
> -					vf_q_id, vsi->vsi_num);
> +			if (ice_vf_vsi_dis_single_rxq(vf, vsi, vf_q_id))
> {
>  				v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
>  				goto error_param;
>  			}
> -
> -			/* Clear enabled queues flag */
> -			clear_bit(vf_q_id, vf->rxq_ena);
>  		}
>  	}
>=20
> --
> 2.39.3


