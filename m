Return-Path: <netdev+bounces-294111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD9fN6KkHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:38:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 805BE62BAFF
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E852330117BD
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247D3D092E;
	Tue,  2 Jun 2026 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHDZXymX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADE306D3F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393119; cv=fail; b=DSBeNZOTLiHmuMBM3PiU+sj7sl88Xi7E3uWgMieEdlf5MxLxyiGbHUl5o5eZ9E1XTm5CdOTuvZnwlG/Y3qyXI1B4gUeLyql9sWoKFmpyfpqA7C5JsYPP9OLDfnVO+x4omIRi6G4/Wo/SGatG33SLe9KNjuUqmwMWXhKzVSZiKR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393119; c=relaxed/simple;
	bh=eghqELVXXa6KytIssU5QZ588HjLrFbSHhJZWGGeivYw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jYzV2xjNhaFzdR9BhwvTwMcA6nPmsoQUIR7Nx0GW7VKCzmILPIszaD++2nCG8folcYrD7voE6Z/UlHUqAdcT8jwyDprMzjcrGvDn79zuK+IGd6fTjJsyHAYcACC82rOnnzlaptt3SeJyWJF9HS3rxeRxuS5N9bisttuy466o/Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHDZXymX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780393118; x=1811929118;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=eghqELVXXa6KytIssU5QZ588HjLrFbSHhJZWGGeivYw=;
  b=EHDZXymXL4WZWmecGMid25xBCFwKddTbyKZ8ajCR4554jobj9fOUeuWe
   6q7D0civ4EIgkFFgV+suJRVp28OTF44O3m0/bCzwzN2oMkszkjp2fOgQ8
   unSoVPfRfqoleppYA5sF8sPN8p0/PMKlSzf7NP/2jwQct390GTZ/j13tU
   Q6LHPAc5+vneu3kcDLakprH0eIW3rvx2/gPnJin8rqvTF2aoYgCEV851p
   lCUhi1meEBpn8gcvVOb4Qw9bPRmXHR1xxL5b/xsS5cUtCm/jk+j1B1IPN
   LF7cwMNGeEE356ZIUmMz+HgF5pXDkMbjN6c/g9FM85qGn7IXdwrVqPJLe
   A==;
X-CSE-ConnectionGUID: c+M6/azXRsy0fCVRCnFRog==
X-CSE-MsgGUID: NP6lOdqlTsqmhtyrrve7iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81165924"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81165924"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:38:37 -0700
X-CSE-ConnectionGUID: ILxxlpkkSmeU35Suaw/n+w==
X-CSE-MsgGUID: DUkUzqo8Tia9l5CRyQxwIQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:38:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 02:38:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 02:38:36 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 02:38:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sc8Wps7uV7pnY90DprID9gSXOy3fBIBJE4Vxn8UAC3VtL8R5QNFWXOaFNwN8XsyiLkn16G+7JJ9a2VENIw2HXUDTCcdvFBvheFSJ0ZxdrgP11ko7492+zEvMphJKDGYq1mBp+sDHkJCnp+MWkxSSz2ERXaHXg2k5goWCA8kOljZ6kZgvlaAVlTYMZfrhP7utfk47VuStPMjv47/NMoxCfKDirvXrn4H3HAOtGzgheVf0neo/AOf6UDD2Fkpam8fe88U6aiFbz96bwNNqqNM5gth9hG97fJQM/n81ZKafrIkCmSPAoJB0g15Z1k6GydUEXbfKduxYEid5lUqYflAEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4SAubdgvsyQHFnimZvNG09oFvQCEw0PYfnFBVesq7Q=;
 b=VuoLyfDqegmqAGup6PbeG7dQQTBnN7B5pviamssx69cck0o2Nmj7rtKJIVBldSHX01/jOLiAk/UF5oC2Rw7frIsGOz41NQLAX6dTtxNgUXmkRjYTm2PjzW9a5cA6P1ckfRigTfCzhATvFmaV4T1pBXPd2WrZt0uh5VK3I5GaytroLbHApIeK+v1Ll32h6e8ryO8IHx+NtZZsEIpt6gkZYsjj4ViX9KUvIT7exJhRq/KfVEB9hqO5VBUyeiNkhEQ4RRQozoFhBtX3yho3Y1KyvdBPQGy5dm0u70rGW4c8e7sRMlK+t5dKeCVSOehQN0GWSxvuS+hNDGySxnMaKWKl2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 09:38:28 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 09:38:28 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Markus Stockhausen <markus.stockhausen@gmx.de>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"chris.packham@alliedtelesis.co.nz" <chris.packham@alliedtelesis.co.nz>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "mensi@mensi.ch"
	<mensi@mensi.ch>
Subject: RE: [PATCH net-next 3/8] net: mdio: realtek-rtl9300: harden
 otto_emdio_map_ports()
Thread-Topic: [PATCH net-next 3/8] net: mdio: realtek-rtl9300: harden
 otto_emdio_map_ports()
Thread-Index: AQHc8lClKSNKfd4ZokaU6Uw1LMh5rrYrAeVA
Date: Tue, 2 Jun 2026 09:38:28 +0000
Message-ID: <PH0PR11MB5902AC16692DAAC68542A76EF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-4-markus.stockhausen@gmx.de>
In-Reply-To: <20260602052640.93083-4-markus.stockhausen@gmx.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DM4PR11MB6456:EE_
x-ms-office365-filtering-correlation-id: db814cc1-2143-41c1-8e0d-08dec08ab37b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: iMicXFwxWXTkStULy0ECE806iLZ1yoUhnqkZymFAUvireN/GUC+ZDMH3dCPwWzAJLzlyWr22wsEoY9jB0Tn4a++AzBWr++XX9DVG7+d8boh7lIjqbwyfRLxjL+jJvixC7KvRTnokdvuVPjWwqEWGcew0yMOzfJWMwNYpypVqVSEOROeAelxQDmVti6P0xD4z5pNHp5Q3No4wNFHM4gSz0FMF8Q7WLx68nal9rD75viNb9S/GZKdWETn5jlL6WDmrdNaHulGGYknnEgFp72riiAtDQ/YGDr6FBfOOUegro3WrA3UDWeNnvhlh1ZPJFq+a7KW+U/kHUEof4kpKNzUgkxtugZwsJUKHoA2Lm5821Gp+1Sf/I2P13O7F3JW9X1wq8Puu23Z7sWIHHVbhr4MCN3aEdDqmoz3wbBvtWsChTSNXZt1YvlVl1pPtPpJtyIoDK0/5A/Wd9us+AOBoJvmMNlFK+ZP5P18VnC1VL9A5A8jSudkhayHPFvlMhV6oKk7f0bqeEexPdQOxhuHh28yfKZ7xA+1hJqBRHkyWi6PTJu6StGSTqCqVPgnvkMBJvr3V2SmQxdDMe8n+BiZkD1uJrgxrF8ma+po278XT/sI8BJidJ090aYARXAijBGqrDs9W0ATDLXAmkRrD4X69JV/TQ/AvBHQcuzb/vJQRPwkTE4PDH53OBjn/IAGBaAfNV9dpuYsbtiR6VNAGPtW7vsERgf6uwDIpAZ2SVsSz6Tl56zJs15XZC5WMuUI4ACZcJp7yshpszTXeZj7ZIHxV8qVYhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ApYp+H8DSeYEs5dSPvcX8ea1v3BQLwyfGtlXJ5M2r2+OXtMmlTEamoOA5ZQh?=
 =?us-ascii?Q?0/nCow2PQUrNqgHHET2gNq96OL0IcpzNe0z5yGMaCpQDoMsH0eIGlZOzkV40?=
 =?us-ascii?Q?ZpgjOOSeQMDa9Pk3ac8Sss6VYevAEmP2hSURsu80HfaMBb8dOgvxBLY36AQB?=
 =?us-ascii?Q?qpGx7VD+fUVWlZjY7Vov3ws0Oum2khtTZzD1MSJxMGRWPfzufAcS3FU4cHSR?=
 =?us-ascii?Q?JXJxQq73qO+kzI935uZocnpb+YaFoXeLdmzuCyzo6+HXjJf6d18TDotSy+PT?=
 =?us-ascii?Q?oNMOk+TPyo0bInhjEc6SRAtSoh7Mrh4Bufe9cgaCoPl3muAu7lrcu5V9Hky+?=
 =?us-ascii?Q?/FmsZu1vM0DkpDjU+l6dpfN8Dax1C2sWWnXMK+GNVgG9xEH63XgrD7DymjtD?=
 =?us-ascii?Q?aTnm76tNf2xyZ8EaekGIggXWuiMrkPGbjFeI0BdxQ9OweYjvQR9gXlzbjxY3?=
 =?us-ascii?Q?P1hSC3ZpZWvkulwvQCOHg5QA0IR3LIH5n/+WPhT1ltTi8J06wtz2e3eNgd4E?=
 =?us-ascii?Q?J0CTLkpDl2GYmEGrBmx+9sfvDxWh7sO8umjsfaiwzABXxOR8pgl6oM8T8YcM?=
 =?us-ascii?Q?JCaEtYXGpIRc7v5wvOc/YhJsbWoUbfhHdDze+1GdnDRS9Dn6kBjhchUbYNzp?=
 =?us-ascii?Q?BAyp1vKvk0/6i1Hbv7Hz9Csd18v0qik9sqAxCjT2VxFsDNrXAZQLsN3ED+sF?=
 =?us-ascii?Q?ytxo/SnU6g3VkVqHgVp6h9RY6iEP8f5ilX0+QnQFoDP0FUdSxb04UrLqJJ1y?=
 =?us-ascii?Q?6utSX714+D/KHm9+TNDRi6Jb71pL5G/ttiJLbOv+5B+3QibWslQpaDsh397U?=
 =?us-ascii?Q?Lj8CPjo8OuIqdLOPaaMU+7YgemQTRSMvGJpTTj887apDtwhFDHRO/LWDUk+X?=
 =?us-ascii?Q?6tW67AcGRudmhHkO10k+asR2h1fFEm+qy6Ofw/H2Ug5kK7JdXqwUw6lU9LRs?=
 =?us-ascii?Q?8vA/vs1LXdWlcriPtytXymDsAz7xg7xQ38e9q2GYNaJmDWR/LoIS2imTpWYG?=
 =?us-ascii?Q?RWDcG9wwgLRtt7OquugCDeXLpecO0BfVX2Yb5SthPXTy5N0Y4FZJfOK/t9y2?=
 =?us-ascii?Q?CkqP9KyV+QGmzZSX9x2tUVEJZaOzsmY5fVYOUbdhHvsfK9SOj1qt15f+oa2y?=
 =?us-ascii?Q?88LfnDLtY5+J7dThMDHO2AxaRSs9RxZMr7dUhylHyx3UXZfFz7M3TQkBycIF?=
 =?us-ascii?Q?rpGjWSLolRX8YGARcOwgSwUbkAkGQhBUywIqpiSOf9h6AC012w/pkIacLBdH?=
 =?us-ascii?Q?DoviHXIpWHgAZuPeWCtMi6k3Zxdk38LFEbWDkQAmTYIASFFHEH910gBfgSXd?=
 =?us-ascii?Q?zmfXUMx6Vmp+uJXt6JUNUa/8bQvmtGu+Fg5AU6uS10w+fibnLjKnSUGO4aDN?=
 =?us-ascii?Q?TmO/pOseZaBp2jdqGwZnY3/RIhbNnA8HjIRzhevP23ggHEqZ6ODKp4+a1uZ9?=
 =?us-ascii?Q?T39kDc+UddNs08I+NeFtyPlSkW1Tr8KQDDIIY/tvb/7sK+N6QwTwNAwMXHxb?=
 =?us-ascii?Q?ouuUDgZJng2vs+YBcl719Z9l6VnjDhcksa8CthCf7CbGfwpDeKVJwHwA6Vl7?=
 =?us-ascii?Q?vfApMrU9c3HNd0mW+p/dj3AA9gdvQ1H/sygTcO0q8vF8pyGwKUxWASQZEY3S?=
 =?us-ascii?Q?fFaJGTaj9a3s66m+K//c76qpPtF2zQTO3GRO6hk6qoGhzr0zVI+EpYRwB+te?=
 =?us-ascii?Q?YNRpufbkLcGk+d97I/VFXlxJuhv9FNq9/hwVNpKJjfiPLl1AZ+ueVjTo1pmE?=
 =?us-ascii?Q?mpVNAiEiEg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EC77YX2RYdqWODFBpwmldNDl6ElPwUq2WtCVE6yGbuE74WBeyIfsn0WoGOXtniXkqyXJjYKLZb27GyhlmF4Vq+p8/DtuboL0YEysx1OwOD1loTHVh/0nnvUNs4PguGQdDXRhBqFHAG9waZ3/gobvS3lExuZFGTvynT/jwZk1bcgT3WjFbQhLsp/DhxLU0MImyvoeJSkJkP7cX7MPvVX86gq41grFjuw3kqlMOpbbtxrILkM6RA8PwAJI5eSBh2GRMsTSzus+4F38fyAAXhAAKvgq+2QIuZcq8SOzEyjwOz2KGrS1WgoTBtQuYKN54BYN3lwhgeAB1RG44FOwM8HuRw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db814cc1-2143-41c1-8e0d-08dec08ab37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 09:38:28.1851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPfRwjJV2Fz98vaZRKYuzVKg8907JJsrpESZErIgX5c790k5U9Zze+zOYv7LA+lBTzR4PA2QXNYxkHzAF9WDLjmpKUDjNvhtVrU9HXmUBBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 805BE62BAFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294111-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,PH0PR11MB5902.namprd11.prod.outlook.com:mid,gmx.de:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

From: Markus Stockhausen <markus.stockhausen@gmx.de>=20
Sent: Tuesday, June 2, 2026 7:27 AM

>Due to its design the MDIO driver needs to set up a port to bus/address
>mapping during probing. The "ethernet-ports" subnodes are scanned and
>from the "phy-handle" property the MDIO nodes are looked up. In case of
>a malformed device tree the driver might produce out-of-bounds accesses.
>The PHY address is not checked against the maximum supported address.
>
>Add a sanity check. Do not use the existing (unused) MAX_SMI_ADDR define
>but drop it in favour of PHY_MAX_ADDR.
>
>Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
>---
> drivers/net/mdio/mdio-realtek-rtl9300.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
>index 381c45e0597b..517b01115f34 100644
>--- a/drivers/net/mdio/mdio-realtek-rtl9300.c
>+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
>@@ -78,7 +78,6 @@
>=20
> #define MAX_PORTS       28
> #define MAX_SMI_BUSSES  4
>-#define MAX_SMI_ADDR	0x1f
> #define RAW_PAGE(priv)	((priv)->info->num_pages - 1)
>=20
>=20
>@@ -495,6 +494,9 @@ static int otto_emdio_map_ports(struct device *dev)
> 		if (err)
> 			return err;
>=20
>+		if (addr >=3D PHY_MAX_ADDR)
>+			return dev_err_probe(dev, -EINVAL, "illegal smi address %d\n", addr);

Could we have more meaningful error code than EINVAL; EFAULT perhaps if tha=
t's bad addr case?
what do you think?
Also - is %d convenient for printing address value?

>+
> 		__set_bit(pn, priv->valid_ports);
> 		priv->smi_bus[pn] =3D bus;
> 		priv->smi_addr[pn] =3D addr;
>--=20
>2.54.0



