Return-Path: <netdev+bounces-129393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BF983941
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 23:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24F8280F42
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D97F84E0A;
	Mon, 23 Sep 2024 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9gb0ABy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3718027;
	Mon, 23 Sep 2024 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128462; cv=fail; b=me+GMbQYgpJW8rfe1Itec1wvhYTdZg7SH3ly578rL6O3Bi8hsO/YoZYFgrUYb/qod5FJ1PZjaEZmVtGOeta8hDFlAtS0n7LB7PFpIAAjdTFvIwMtWdOLAZBM15/HJGGJpxY0Thfq0oZ81a4cwXVecMFga4GIpXqRNHQUQwd1m6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128462; c=relaxed/simple;
	bh=kRYC7lrHUBFQAfIJst1A9hKHihG2Ng73XYwwHptZt4o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rm9qEUsQVuncCa5PqsXhV7g7AVOv8tcalcBHFbzPSiD83DECdhepOCGNUM7mfHLGPlob8jUWlOCPIRRFCFs+fvHdtDNpaSQdcKfESqKWMP56H0AQMAzXpu+XiYituRBVd4DqqFZNqZPSmI8W2mdbZOC351lC95FUsDpOzR/7+Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9gb0ABy; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727128460; x=1758664460;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=kRYC7lrHUBFQAfIJst1A9hKHihG2Ng73XYwwHptZt4o=;
  b=D9gb0ABy3PkDJL2MRMUiHJO8VOKM8GAYOqFoO9uksvQaSRl7jY1Y2EKg
   xDVmPMNZLE8yfUyKnK5vmOwnGmHBM8niD4TNHxONyntMookfHBERb60xm
   VIFZyo/bR/sb6eX+FtzdGeNfC5PV9UrFFy3R9HV7MX9kDNSgzGBiJVlUQ
   dQ6bCpvq9BeVuQcbOZ3vwn27bth50JBCdos55dTOE3YRFmLNAuFdnPfrP
   UcQRXzhZRCOpOBlqOBuV2RKhPT3fPc5LrEXMkJtbIKa/n5cdwWjs7vTIT
   uItIiLaDFM5V13uKP8l6msAluuum9iJHaUJHEyavD4hoP+kEvyYWvOpzt
   A==;
X-CSE-ConnectionGUID: ucBDT3WgQL+6KVXoD0P4kQ==
X-CSE-MsgGUID: ZHxArKk0Tda5vcW2yqyNMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37235916"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="37235916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 14:54:19 -0700
X-CSE-ConnectionGUID: D3dfLSqFTQG4Ky+wpJdYHA==
X-CSE-MsgGUID: kxqqbIKfSuus85ph4BenrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="76124403"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 14:54:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 14:54:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 14:54:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 14:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Av/5paVpuqdOB2ssxVCAuCEkGNsfTceOzN9Hfh7ufAiZGG7AYo4TvECnAA9cTDAxYXmB94SmSiTSsnX5+dm8X2nOwQRA/wQqbG4TNyZWXAAQ8ggnBkCWx/owUWRQzcJ8+JxsmqdKk0zz/w3h5vFCmoJATizyYLrZmOyxcGr6b4u18WRhMduS+fZBg5Gn3b3x1rKGFIpvS3LUkMNvQ3WhYBCkeEki3lSto0UiVdQarb20CbtTsA+T+4LzJPi76zisa5qCmxloD67WhmOwiaYjes4WmYqBHrCQoEcMO2+4ZtwPwFdPok4Fk1i7KLUYNApMRmf0KN+xsFSXKPUL8uMH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRYC7lrHUBFQAfIJst1A9hKHihG2Ng73XYwwHptZt4o=;
 b=HvSfVOvKv4zV2xy0VKO7yO9RvyviGmQpm4M+WIZhBdxDX478EBbi4egq7wVUgm0MOVe+qufSwPftPRR7X7gkqys6x58sa5QLIqyBv+ryirvt3m9cQXUHzB/LgwQrszOb2SlZth8PGkEFw9yRKlWcQgd2g7Lzw+b8RFXo2lk6n3WzHbQRjf1jSySYtxgOiO2qz82iDZ9Skpai+3pDv0hK0hy+pB/yv+jtuiF5rxPIKUKvpIJqqAMgcN65O7LXXeI17Z0tVHYz5WK0akDlVQWITDuJNUvaUThmJlGBQLQ0g3KKgm+strakprwBmcyWYW7RoKGACg6oqVCExIGW4rfspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 21:54:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 21:54:14 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "john@phrozen.org" <john@phrozen.org>,
	"ralf@linux-mips.org" <ralf@linux-mips.org>, "ralph.hempel@lantiq.com"
	<ralph.hempel@lantiq.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v3 1/1] net: ethernet: lantiq_etop: fix memory
 disclosure
Thread-Topic: [PATCH net v3 1/1] net: ethernet: lantiq_etop: fix memory
 disclosure
Thread-Index: AQHbDgKOZ83p4nb9sEuFQOlOvNk7ArJl6imw
Date: Mon, 23 Sep 2024 21:54:14 +0000
Message-ID: <CO1PR11MB5089E94A9C5795B9A7B75424D66F2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240923214949.231511-1-olek2@wp.pl>
 <20240923214949.231511-2-olek2@wp.pl>
In-Reply-To: <20240923214949.231511-2-olek2@wp.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH8PR11MB7070:EE_
x-ms-office365-filtering-correlation-id: e41cd2db-021b-4b68-8478-08dcdc1a43aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?MNjoF3nZsUoZhev9oS41oGp9w5P7Wz+Nw+Pm4gg7jMBYjjfkcriFl4jzB09U?=
 =?us-ascii?Q?sfrwF0cmfzzWRb9Qu1dURN8W2srsjZjIMUAXJMjA8/c8RtH92OO7fjpOjf/O?=
 =?us-ascii?Q?nVW185TRDzAuSc0msa3bNV/zrww0AR5s+MvI7RB02QjkKwa2kF9e99DLLrPe?=
 =?us-ascii?Q?gh4JQmv82/dKwEp0vVk9szvDZB7ahZVubxrEwmDb2JYt3lSvdZQM9l21GfKA?=
 =?us-ascii?Q?oRw3/8JVhMwC+o6Qcg4VmP/6vVdnAywW/xBjUXf99ADLpDBBYd42Z6ksPE8o?=
 =?us-ascii?Q?SpAb5HyeQ5a0VwHNlhIy7MkrXjvfCljyg1zKPU9oNnS6A9ugUV4mud/upbIn?=
 =?us-ascii?Q?V/FV2Fw0cki5IvHjkD0dODhvOxECtwK2QbevpPzc8gsMwYTbfAvG47Fh2qfm?=
 =?us-ascii?Q?4i6QznldDrFhSUmpP0GscbZs+LxXred+QLyj09lt7oJKugqQWlavxcJxghqT?=
 =?us-ascii?Q?TNW/orQ2EjXKH5UH1q/6RI8yV/VAPX8xq0AMCtBHV5ux9fXS0iS8tqonXXHu?=
 =?us-ascii?Q?ObbY6haIapR4HnzH7sh8AG2JYTxiLPHzz5yVhCWueIOAbqGHlHfVhtMNTaDu?=
 =?us-ascii?Q?V4n/kp3+OX1bQpOqHstBNeBw4EBnQmLwxkmOs95BODNa6yYpo659y8X7pPBr?=
 =?us-ascii?Q?VzSWbGY4D4XFh8yJgsoQc0guPbWa3EJZlCOxjhi2byYxiSHjlXFUFIKw2HPb?=
 =?us-ascii?Q?oywAyXGeNWNbozViS+U8DZADLVgtkR4S3+XkKUC3aYDO3qFfbb0bDuFfxdxx?=
 =?us-ascii?Q?TZiNrBt2Z11yxS9KTUhPRJNPhwBXk0ngKCQg6byWlFc/paATBrE70r9Z06by?=
 =?us-ascii?Q?Lt124Aq2ixon4IzNIOIM7gZIa3W3TOawm2JW78vfGWUCJGIZJh56kQ4/7YGX?=
 =?us-ascii?Q?nObuTyU0aJ7+62pLLUXROp2nHI4zuYJNkZVVDlMDp02Ehp92g9XFEVMb0u9B?=
 =?us-ascii?Q?673DWGOhU7ZwgyLUSj1jH8xG0OzFBzXKz3SyMxajgf+X6NkvF+md1+YhHTmN?=
 =?us-ascii?Q?tyJ86FVXCXy76M/nzfpOirqUOAUlEVmC3OCpzkivwfF8xPpzuwQuBAkeXIgz?=
 =?us-ascii?Q?6AsipDugCZUWvtPxDdkXAXaMUeD/RiLQEsMjS3sF15M6KzIielo2rxahlfP7?=
 =?us-ascii?Q?oeFXP6bCr4Kp97sRSJfiBbs99+YVZ6T6sRO6HxkuuDZpfsIu9DrFMlVsBPNn?=
 =?us-ascii?Q?A7Nf41WL7IGqSTwm5qBkA2LmWk+5lDmi0qZ2Ph+WNMYWdkQHBfnFF7x8Jinu?=
 =?us-ascii?Q?sEAMnY3lwRLEs2C9b584bh8J4A3jK5eQK3/eLiE6otBtkeNEVGxq9sK0DnTU?=
 =?us-ascii?Q?PKQyfpuVq4C/27wqYrjHbYaYkRFQWvM7bFL6Bvr5AZNVAak7OHZkHfcle72Z?=
 =?us-ascii?Q?/G4Em3w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cXSJuzT4PJz/FzE7XSVVz94oatdcLWgh+LXBVEuPxzB85M60r78csgfLdtVp?=
 =?us-ascii?Q?coQkoBm8DKfLi+k1S66mYWjmxPIGqxgwCPXiUgnlGtj1owhfte/2ysv0dVnc?=
 =?us-ascii?Q?4MnrrwaTZCjtTvOrrUqLzycCl8X5ikG9leJweXjxrxicr1Mw8ivdMZfsL8Nx?=
 =?us-ascii?Q?PiMAn1a3L3iwSLulrmqIcucM5bWm/mKqF/T7OD8ZBz4oysoXbNZe7HbrdHpa?=
 =?us-ascii?Q?WNJ2TL98PJ1YT1XLGmjcNNeOb6HAFO02SvcZK/QT0+ckf1Kxk3KVFHa596YU?=
 =?us-ascii?Q?GOqB5b4m8p2RJFXWnVZunSrVXrnR1r4Bc7HMRpgFWqs8drgNMHVk/wUrDKIS?=
 =?us-ascii?Q?V0VU9qU2ZhmDYJOxxOtBkJf39DOEh1e5TQvTDAtpsYTNf9s6q9Dw9bOCN54p?=
 =?us-ascii?Q?isz4/ZSLEvQSGvFp04n4Q7SskBrfYnM17XqHWImDrGHnBRu/maEEm7JcAAEk?=
 =?us-ascii?Q?AUd5vRUImsj38ilWJSHSGniBObAexzvWo+DSBP3Pv80lX/XG5IPHmc4nMFau?=
 =?us-ascii?Q?55OgSymnWuKcH1mFC2Bcwg6Zm4Om0CeKLsz1bDedpjVey/vwKhu2gcFchnVB?=
 =?us-ascii?Q?C/m9DBkgpzxz0ZGQugMJOUrolDBIr8pyBGz/kYgdLNdq9+USmRJteCXLDjFN?=
 =?us-ascii?Q?oAfzer61HpDOwqGPsOdfJwhna+ONWVdASvLiWNQaMakDtDpP0H8ygaA5RtZA?=
 =?us-ascii?Q?jUGBiH5MtLJIJfP81vNvjU9Kz4DWmPtaheypEDkZdAPrXnGmEljHNwpq8mjb?=
 =?us-ascii?Q?y1qCm+ZJ3nUMseze4I38qOda/JBPotBpAGEQd4qddgMQ4bnnNJ6sWajiwu3s?=
 =?us-ascii?Q?hBCMj05IHxxCtDl9YiZZcakM9udomVg+vQskcfTo25ZzZhQj5vf171YlPmNB?=
 =?us-ascii?Q?C4afwDam8Jq+JyK3JjYQMbWue9oya6q5SYk1yNVCuQIFtimMWYiE5ofP2vbo?=
 =?us-ascii?Q?LnJ+zEWKapNxzCf/6/7CI6YdNGeqFN53r8HwgiD4JtRGRH07lYDhzrFoaeU8?=
 =?us-ascii?Q?FU0iK1sJfcTSPRhWVogRiEWfv4N31agyQGE5ACGZvBQTbFpH1M5GE3cOU8os?=
 =?us-ascii?Q?glCQdKdT/H3tDxKMCkOlR9L73RzjNUSkZ04MoNrnRNGEqMhEkhxSpFcjgHVR?=
 =?us-ascii?Q?DiRBmCL/beItGZFyLW0zVZNmGzbQpdDM5vLcTv2FtnGOdmMIEPf64o/j0zTF?=
 =?us-ascii?Q?auy/qafU9stwVlMVxx5VIWsEO1JrjWawRZXwYYmspzTFeBZiH6P62AsNo9Zo?=
 =?us-ascii?Q?RW5C6Kct9IrCLEew4g7juax9VtH+hg/3kJ7Xm6ZmZ6mZVrr1Dz+Slz/M5Gb4?=
 =?us-ascii?Q?i5mST4pu6ITYT72qwD5Xoj1PGVe735TK5H1MV4P0uySU3FnOLuQX0L0BDunk?=
 =?us-ascii?Q?BJJfgH8PQQnnt2KcgYJILiu6y258EzHuSY5MsM7sqRXSTGEYGvzmvyuUorcB?=
 =?us-ascii?Q?kAaq4daFh308PLs+yPaqlNyiuySPb9+uURDJLgXom9uQQoV5g+QcVeWtFTPR?=
 =?us-ascii?Q?O/oCa9cDLtQCQmYJ92qvdEfWUg+yQYmbxuU7dDO2pPVk1Q6xKxSyJyoL/qsB?=
 =?us-ascii?Q?6SqjpObzAKwTvsg/qdtDNaJ9eTmfHjJBqJ7jFn3P?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e41cd2db-021b-4b68-8478-08dcdc1a43aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 21:54:14.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5ZEzW9xjoeRAIDjAcIh8D/aZlvxfaK4ZwgEdGUXulwisc6aMXHQqQBPFZjf6GTDJcqK0nSUEmQhFJApfxALL5ZK3LctepgKjS2tjcBNg7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Aleksander Jan Bajkowski <olek2@wp.pl>
> Sent: Monday, September 23, 2024 2:50 PM
> To: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; olek2@wp.pl; horms@kernel.org; Keller, Jacob E
> <jacob.e.keller@intel.com>; john@phrozen.org; ralf@linux-mips.org;
> ralph.hempel@lantiq.com; netdev@vger.kernel.org; linux-kernel@vger.kernel=
.org
> Subject: [PATCH net v3 1/1] net: ethernet: lantiq_etop: fix memory disclo=
sure
>=20
> When applying padding, the buffer is not zeroed, which results in memory
> disclosure. The mentioned data is observed on the wire. This patch uses
> skb_put_padto() to pad Ethernet frames properly. The mentioned function
> zeroes the expanded buffer.
>=20
> In case the packet cannot be padded it is silently dropped. Statistics
> are also not incremented. This driver does not support statistics in the
> old 32-bit format or the new 64-bit format. These will be added in the
> future. In its current form, the patch should be easily backported to
> stable versions.
>=20
> Ethernet MACs on Amazon-SE and Danube cannot do padding of the packets
> in hardware, so software padding must be applied.
>=20
> Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

