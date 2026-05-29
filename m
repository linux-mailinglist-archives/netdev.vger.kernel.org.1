Return-Path: <netdev+bounces-293182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CQtJ2rRGWofzQgAu9opvQ
	(envelope-from <netdev+bounces-293182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:48:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D41606D2E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32AFF3000FCB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BEC390239;
	Fri, 29 May 2026 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWSSNnE/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4F348C75
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076626; cv=fail; b=gBjaJu+QsUYgQFU1FqnstiD8FXYg28T41LQbDqruw3Slchetoge9mdtj0Dm7gLcPsVADG04l88oTFor4UdB7qvX7G4YsaKgXS5bPdvI29g9jy8DLys1E8Q4R2x45nT85ac1soCCHCX9cbuxRasrjRFpY7zu7Uaq/mBuFYTMB+CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076626; c=relaxed/simple;
	bh=5SWO9Sfn5mKboMyu1MSF03KYa91TeXXim9dbWCW76js=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hmdctcn5RS72eqygrTX0NSxPu0EtS2hpOArc/qtHCfJKPrKh7WRs5416jUmdz92xGsIA7VRMMUQZwbZX5MibvyfPZjlhtLkjGZXmrj3HSFXgdfjE2A71PjokFx3RsHFcqlKWFUl+P194mssAfItjsPsfMiIWEjjkdeH8+TcfKtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWSSNnE/; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780076625; x=1811612625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5SWO9Sfn5mKboMyu1MSF03KYa91TeXXim9dbWCW76js=;
  b=jWSSNnE/AYW/HqlqExHCnxyCgvrjVHnlVCeHkBJ4qIEgtHkQXa2PZ4+L
   8wmuNlvO79qhX0pp1i4pwP8FDAXo0dWCJ6fgtBUTs5gTTslXzfCRZFqjv
   8Z/X6brGss2mPweidyGx7ZexBNiqxZbIUKd3OwqAaZhksxa+qhiCBGLCm
   oH9qNauvRMoDtdsIrpYhjUzTxzP3/Usb880EhjLPaeIJd/m/3YeG5f0o9
   /P5ntCr6wtFMnRtuBKO6TBp61wEC8S2Gjn3DDeBxWQ6IJY7meQhfoijLq
   rLcCqVBwpdD7zrqegPC2pG2K5AZ+UAgOPNMu2VQSo6rbsh5NtzO3EMUm5
   w==;
X-CSE-ConnectionGUID: gVdHEqqdR+6v/+D0+JJbLQ==
X-CSE-MsgGUID: TQTWV31CSp6q+OaQ0G65Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91506850"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="91506850"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:43:35 -0700
X-CSE-ConnectionGUID: /Kc87vGeRLyRtKQFu+n2wA==
X-CSE-MsgGUID: /SqW1taZROSEaq1P+DS+GQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:43:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 10:43:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 10:43:34 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.13)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 10:43:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyOyJFqQ/ps5XxrPqGa8bCvmEbw7HTLsrP2HgjSUv1Zb/U5Nvjx6uPMkD/CWmqDrNN/LeFHp1DIQ0Rw5jNNlLJGppihGlsXn3/tX2ayfBLQX1yx1KjnGRNbjwpq+/ZtToiD3X+Bg8PWxjWFwqwg7Is+rFsra7J1V+rrHz8iVcUHBmvV3xKS9wC3IX8oafGYWxQYRoIoQZFIDMZnbNFiClspZ1dpVET7mfOA4ElNs/ul6Vnd8iwvqaur3VEMWj3YFuqjTt/RCZrGlrbVZ5VraRFCVVoHp6GBvi6Pii+c4WzJdrMj2CG81s73jGmZpqgcWNFhpuoSjRxUk6g30ORMtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7Hv5Se3Is8QdXWGH6EVlCyV5sBouUm0sGzOmiZ+mQ4=;
 b=jb+8rBeTy+BoCZ1SYH458rneCMctW4x57oXkUsaQaageUL/kNAll2Oop49zyzv6bYxCpAH5xEVp9b7BHnSXESeTHAEnLk0nr2KWJxjUFG3xNDxdArA8XBR2sSP2BTYAQajDaPrSeXmAub/3NE5m4esR3AbhFBRv1nX2WdScrAlorZUjWsOYir5YMLm7IYp5S0QTkCzrdGwIQsUx2IwfsngPdsGVZsUrNZZKKf/7E0fAyRujfvSRZ2yfHgoFyjZLcWX4V4whqGPA9sKRNg7ylwqmtoIxF4sZAwkuQLFwcOjCvUUyqlkNufyzhIqP5Cvim3E2bWGZG+oknB9u5A/XHww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 17:43:30 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 17:43:30 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 05/10] Revert "ice: remove
 unused ice_flow_entry fields"
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 05/10] Revert "ice: remove
 unused ice_flow_entry fields"
Thread-Index: AQHc6SB5n5M5CzsLaESjgv2avI7NgrYlUvDA
Date: Fri, 29 May 2026 17:43:30 +0000
Message-ID: <LV1PR11MB8790CA434874C1753D67F53B90162@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260521115000.4637-1-marcin.szycik@linux.intel.com>
 <20260521115000.4637-6-marcin.szycik@linux.intel.com>
In-Reply-To: <20260521115000.4637-6-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA1PR11MB8173:EE_
x-ms-office365-filtering-correlation-id: 62ab05fd-d5ed-4cb0-0913-08debda9cc50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: RJpn9TiLPMbArrMzJpoGmV69/9UAOh6Ip6jgiPY31ivvwGXGvOjaCZ8UBaaC81DmMly/YIN6SCuJt+DG4GlHjt5umHV4prLm2mdK8Y7zE22wqVZb4B3+GIGyzIOykiTDLpnbU50M9MIo165hVC4XzXJXk5y2HnpUAGU+6x/HrcoaaUERaNYSj+C064P2FDd8Pv/EEwjEXpwRmJ/K03CG2xYyDcl/eMvr/YhXI6czQJqAilyCwJmPBtV7EQKtClYg5OxTY/eCdZJSgN50ZrnrhR24IuMxGaUzOrFniRwmXHKMC21D2TwTcdfP4XqtdWi5nuVdzCumUGx4TPmGkgkL8XJvJOXloqKLHtsTVcf80A3lJmGRZYNxOJoGXH/cUdZILMMHpNNZ0vOGe4tXa0xtwwdYdQjnfFY4r7WY3yOP1wcKhH4v/8rm2tQpmopLNxFqgJbsbLBGA3Dxqhb1E1uf7t2dgeqO7/zXriTY3hKd2jjL0GYumgLo1DHyFiEtz/Dv+VTbFIF1Pq7zRvFsLnqaOzgJwtuF7pmvJSTQQ+JnsgFn5MWQFcMgFo/HCQqnymPYNP2f8stxgvh3oDRzjdgLW4AunWUhYA/pqGwDT/CbwtBn7xfwoay2h+GV/mcOMOyVdnmCkFQO1d/fP6EG5AETXfNC9rEmcL8YQsuDAA2w7r+OGJaJbMKNzpzIZNhw5/g8jktugW+CBg6qZWCpd39W/IpL3yAa88EuVXM1QuN8Ors3GmKohy+7ma97MnswSban
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LNr4PzROC4z6DWKhgsKnRRx6pXM5FT9MT0MdSqitV2oSMZJtQBhLypNnl7bs?=
 =?us-ascii?Q?nvcHQLpTtPMAsX9iuA0v0+JtgqWEiXx6KlLpd65YhCoDQM7NshBbiw+l/ujH?=
 =?us-ascii?Q?TY4/I0h7hoTT3dcTPtdI+ASF4nbA2UpcBzWb+jGKqR4i9Ca/zq4LaoO2MwGa?=
 =?us-ascii?Q?ABUNXFKgvQpXkAivd8MPL2UwAuzrYzKay9R/hkuwcfGxYkUhU+ASGqjWaBFU?=
 =?us-ascii?Q?x49GiiYzMXOkIMmRYhhd3fZ8WZqtWWDr2TuvHswO/79rJ6srpSB6bfAbnhbY?=
 =?us-ascii?Q?iIMvFdad5vSD3oUx5AQo8qdU5k+8zKgWCRYF9++f8xCrMZMIsDFprOSnFqDj?=
 =?us-ascii?Q?T+DAfUHQ1NysNKaq785arVCrkzUnWx3FTXHZCPUWV1KCBgLwmpHN/VWqIsoI?=
 =?us-ascii?Q?RusQJUocDelbn2W9dGvOitZoxjQn0ifaZGqUF+9k5dSyT0l66VFJhf6zQxGr?=
 =?us-ascii?Q?EOKvspYicoa4qZ3AFlAl72QK/GPw2FP07Bp+VOf+oS6RU6J8L4XPSf6F7tCF?=
 =?us-ascii?Q?Y6ufqC88GyR9LSe1mP95IbFJ7myRyLjNNt9E8G9rTZAcB2g0rjTyotc9ZOJg?=
 =?us-ascii?Q?4bat2l/+eWPhIo3kWZnsHFddNKTrOMpHrUDd9U6UT3ZdPW4J6D/43CFxx+2g?=
 =?us-ascii?Q?YNlaJf6rLhVy2MOYy+JcRWhX/Ju/D97ZrxI9LiaXVDqgg1NwsCdsN56ARYiE?=
 =?us-ascii?Q?r+EXPpFr5d1Ce7Yr/AwwHPjP/ooqC7Ed2jySFG5hZ1aTG0/bBftEq2jZ/OyQ?=
 =?us-ascii?Q?5/XHMfJpKO6GEjGGwtmE//7cwOT1W9uB08D+Ckb2rcaIfgOXYWG8EjaOaYM5?=
 =?us-ascii?Q?6f4x1237S+9g+lyKxipSsqoQI2hausWJ1Ddvw+9JzRC0iBGVcEdMqJ7PhkrC?=
 =?us-ascii?Q?HTXSmEENbqBdge10ddrH1zk5TXnAcYx5mH1z3QLGXdlVwm4bscbn5Fm3XdhT?=
 =?us-ascii?Q?EwYcmgBwcGeaXGISvfRHfSCaXA51FTZR7Gslk05DBnwcMNebal872FXFmiUh?=
 =?us-ascii?Q?ZDapmcYkVYs4ytXDxo+jl/nAHGt8obGQZct4bc3OIEGkJ9kPysSG29NwRkMt?=
 =?us-ascii?Q?7xZHP/GT9lAzFKi4fa5ULOLmgaZRdpmRM+3XfLPVYEkgwI7jF+UUFz3itcy6?=
 =?us-ascii?Q?Aplyn8h7lNmOgvDnH9KULX/W6l4aNa+BxMb0qRk7yhCdXJDM8mb9xSvf5/Lh?=
 =?us-ascii?Q?FwBSwAR4BnfZgCy75flu0gfySdDVS0/at2QsFF5ftHotndGiZOi32M8QcRZN?=
 =?us-ascii?Q?e6SeaXLHW3I4XLCR7aXHPaK7folZnY7DvJNKxvNS9Xn+c4jXGN4IzlOZhG0r?=
 =?us-ascii?Q?80B8MfxU6J7R5O5ZHJywCayzNeU7UXCgQfbBYBkKsHAX9eMUzD0MF4J6Hn6C?=
 =?us-ascii?Q?ftfei0BEM/p7TNj3YZma1nO9NtjtAiHDRBzSBclejRrF+pe43/GgjEVRGbPY?=
 =?us-ascii?Q?2E7gvnDRlpmYEvMzfZHMrw15oDg+drzZLKe7KF3L85AOnTJIb4krmm3QFnGd?=
 =?us-ascii?Q?IdTQMcavEX6fwvUZJ13TkT0SJp4KFRz/1dq6dtJu7vFFdS2q3z2iODJNolg/?=
 =?us-ascii?Q?pUpVDh7Jx1FynPP1JWdqf5blvCANe8mtW+vNaSDtv4L6aM73e7SyK+lEJBQ7?=
 =?us-ascii?Q?5Qeq3A/R5tOlgV9Yks1l5TwTrwm72olV8RNpBJpAvuuhT0WHnfjlqxFTW9/w?=
 =?us-ascii?Q?ibrgInXCKQzjQiBIemSBv2CXCYSO7xX6lrHmTUlDhoitNauFUhRUbIcSJLje?=
 =?us-ascii?Q?d2a8bWQ9hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DaU3wHUxjxKVHiJywr/82xgE1xCPe8bK3tUnJCMPsUnl7yBu9kzPOOB7vRobmK04G49EzYhbO3NJS35YK99wHVYMjXtNNDH1J3qq9WQwinKB3FK6KFTLFM47mIeWSG8VfWhMiO/lwas0B+MffF87xbe6qb7HzAGR8H8wMuCLQRRn7DV8Hp5Azi2pY+VsDTSzJPNX5X6DjJB8z3OZ02LVyv9IpDbMW8LKngrCU/fr5bvmUsntXTHuGHqYqbKNo3zLMkjjtGNqfw8UqOoJpCxeQkMWozlCvL3kynfkl0MaVY7ssBJNBDIMM7zAJi6q6P5JyD3Az1PqBHXjNTDf3JbbuQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ab05fd-d5ed-4cb0-0913-08debda9cc50
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 17:43:30.7803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ooCjYRyOeLA622c2Mc/C4GJW3GLzh33VXUSFrG1aY/zMtrvGfGhjQYmB0cslZHTack+VMIKKpIJnpfDZoNcxj/twC9rh3xLxnrZH2/v9LdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293182-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,LV1PR11MB8790.namprd11.prod.outlook.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 48D41606D2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: Thursday, May 21, 2026 4:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Marci=
n Szycik <marcin.szycik@linux.intel.com>; Loktionov,=20
> Aleksandr <aleksandr.loktionov@intel.com>; Kitszel, Przemyslaw <przemysla=
w.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 05/10] Revert "ice: remove =
unused ice_flow_entry fields"
>=20
> This reverts commit 4cd7bc7144ec2c0bb27208c3bb1f153dfd44b1c7.
> These fields will be needed in the following commits.
>=20
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v2:
> * Add this patch
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.h | 3 +++  drivers/net/ethernet/=
intel/ice/ice_flow.c | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

