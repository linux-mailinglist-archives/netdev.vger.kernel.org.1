Return-Path: <netdev+bounces-220381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F42B45B02
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B9D16E95D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956383570A6;
	Fri,  5 Sep 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9xE+iWe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2702148850
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084052; cv=fail; b=RJVfKsXJ6oLJNFK/OPQ5itEU4pDYB197FJX7f9tBQuM/XVNKPHG5+l44lCa3LzNAmQ/UzsAjQP88OPTqF/1jyTLWy2ycURQ9WrHvujV/8WXpwjIG6zTlRCBjyKKWoAN4N+XATzcK3OB9zN7oPyva6JTzQwAMUJxP1yEHWBj7ccA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084052; c=relaxed/simple;
	bh=uyAtu6SCGZeBxl1alDs3bCSJ8nNwl0b2B3VrLrakA0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cOuazWYDPLy1Q6riOw24Of84wrWKSLBlBWaQ0ixaSBZzasRF0wrldJIsVUn0BnMdfyl7ntMqa1jeAufPkBWwGps852GcQjzHJFKds9jh7QD1Ah5kevnbWkeltlsT2liWNGZ9aTjNF5VGYXWDnlowJTimWw6vO2qJPLee6AWq1gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9xE+iWe; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757084051; x=1788620051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uyAtu6SCGZeBxl1alDs3bCSJ8nNwl0b2B3VrLrakA0Q=;
  b=Y9xE+iWeb3HPqqkIqFy8gNqGruAgqm7rFY9hMxo14FP+I+t7xqnIqOAm
   nGASNgzxFn08ko88Sb4CrdBLkf9W6sPe3mxzOBKpgvvQyR27GgM8ByjVY
   70Sgc27VS+LgXYLFInx2aAxSyd4I3ZnVuHlreP6a4pjIyDRsjoN4o0CXJ
   YeigrSjX+b5GAvAxqk8t06YXtL3qW4anujzXwvM91s2kj5JEFhnqkUeHT
   AR6813jxwQtay45uybZsFpGvOiXZYSTz8Qc5m6dEDFmU3mV3NZDpzpXOs
   eHMlQ56du+ihHOayuQloUTMkK5RGV+A5HE65FoWudK+VsshAu2iK9eSMZ
   Q==;
X-CSE-ConnectionGUID: JBVVfgdSRraeS9902U5GFQ==
X-CSE-MsgGUID: sBvrsVLNRkKxrKupOf/0Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="47006569"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="47006569"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 07:54:06 -0700
X-CSE-ConnectionGUID: 7xyhshQsRWakaE1zx4YfPw==
X-CSE-MsgGUID: hi+DyBc+Riez7iUjCZwBRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="176277389"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 07:54:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 07:54:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 07:54:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.53)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 07:54:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgwzeMQt+Jh+BbqMkASTA3wrbpm8aESFj2WWG06Gha39drcA1/uizaOq33xdgaHu6FrGuz/RjSKwbxVvlldFza+RfjqmDL8XGgjsvASxY1FifJ7hw1LN+rZAdnAW/7VZLWHD5PqnV5a1njBG1NxlC37aG6+61o9HO69RVJwSEJFXIrro2kUN2heFy2eK0AnRtOh5cbb87dSzOPd3L2AjawsVqugr6w87SxoE8Q0LBuDo8aT5DyDv9mUlBBx/wtavn2BDaAwoY8pzr3GWCU/X4/+KWPr/Z0Zj4b81+VV3jyzo6V/JC//yaztk7XDiS4/2mWi77/+UDWlrqs0/TBrfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQgKnDJInjsZoEewVXv59xTRHo8TciTGSexSP184xzM=;
 b=jni2JRaRqq5JNEuxNoYDJ6KcP3/sgVtjD4ex0O4em42KKyZgTN2gKnTTZ2vb/J3ukSiy2vXVn2IBvxpD+LYphgUmF8cApn+3PiWdSCJwfYlqyA+cuWqKasL2Losz5mVh9EAcuZNDOCgP4wy2rua5XxoSNbVhOkhq8luxb4NV/ZfGJupmM1HNyab8tqbYc/rn0Hqc/fMfpqeN0EBk5V14Ss0yVQPqqSluAYw3JQD+RfobFse0d8zWtf35KkREaHmQpKtOL0iwLV+BLwF+5HA54PVLawaM9Vc9X2dpXR8cZpqpLSQp1jlgNGiRJMrWptJBkuwo78sxDY4R9FiHo6yVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by CY5PR11MB6140.namprd11.prod.outlook.com (2603:10b6:930:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 14:54:01 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%3]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 14:54:01 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Olech, Milena" <milena.olech@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v9 iwl-next] ice: add recovery clock and
 clock 1588 control for E825c
Thread-Topic: [Intel-wired-lan] [PATCH v9 iwl-next] ice: add recovery clock
 and clock 1588 control for E825c
Thread-Index: AQHcC8bBzY2NxtyEhUisdaCjbiHDLrRgXTmAgCR0vXA=
Date: Fri, 5 Sep 2025 14:54:00 +0000
Message-ID: <IA1PR11MB6219ADDEA32B0C45C4CD0FED9203A@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20250812202025.3610612-1-grzegorz.nitka@intel.com>
 <IA3PR11MB89864D7323B7E3662CAD765AE52AA@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89864D7323B7E3662CAD765AE52AA@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|CY5PR11MB6140:EE_
x-ms-office365-filtering-correlation-id: 7ee5da00-0cf5-4149-f554-08ddec8c0ccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?oRIGavSK9BR5zLzfMTH8WgFbGkohk5sjsyuZ2YKicRfGE1/u05Ru4Yphfq3K?=
 =?us-ascii?Q?cSya+GPrW+RycorUj5tsAPPImk7ZQSmQlAx/cRfqvO/W2oLXjIHdkx3cSrdW?=
 =?us-ascii?Q?fvp5rc561u0+Wq3QDQOyMkDwOBsbjlcsWx+CA88T7p78ohHvN860LLod9c8X?=
 =?us-ascii?Q?QVfRn/lzC3UrRVeexHcvsIigsfwVFDHE5DnbxOU34il2bJCguPIONx25uWjp?=
 =?us-ascii?Q?0Ysa5XtfBAR45Ca4T2vKNct9aiYO6Ud96MwzlhuTzOEp6TwjFEQx2XVLtUsd?=
 =?us-ascii?Q?pTh6JZe1AVyYhsdWFPbvRfjRKwa9I0Dl8fOhGJYXYTSWlaN1SBzUNK3he83E?=
 =?us-ascii?Q?HXpRoNfLkVd3xPDpRuh5ujNoqaU1xXV4MDPXvmSV9moRNWzVTupQXbNvht2v?=
 =?us-ascii?Q?nUH+4TulQO0gS4p5wx1lySdwHosFm7N3LlOo5C3j4J1CUZbCpzYqHEsG3+Qx?=
 =?us-ascii?Q?N3tMMls/nvwoANjiLQGw8fKxgO+gG/inuTdGKIMMElcmJERwh/dG+gUwPXp7?=
 =?us-ascii?Q?VtAiztYlSEfwCVLLR2A1CkJZoEYmTgGW8rkbIBjdn1HvLlXVOwfWp/YqTaz9?=
 =?us-ascii?Q?pHF/fzClCBt89piePb3FUMSwnVEApoSNL2Nn7Ha3UedlKPIFmAuw6vkvvcuj?=
 =?us-ascii?Q?kgagJrhLR4T1VhFaA6LSTYpj/Pf9gIJ2U/P2TV/tOnacy3dONhWgLkXaTzTh?=
 =?us-ascii?Q?fEBCtwmv8DXMCuJui6x2T0yWTH56G3+2VnnHjowoczhFT0rdyqDKGS+r9SMl?=
 =?us-ascii?Q?Onb1z7M7P3prYodnWGqPSCVFcLltZtdVHLS3EBHfbv2IYAYVyda6PnNpXlX/?=
 =?us-ascii?Q?vh6ssT3Xvx8cRzo6zCYwF7OrmLlsjjTaSOSMceSPKQBoRUxxfg+ltm0TLcB+?=
 =?us-ascii?Q?StN6Yb6+dM96pI4F1wLQUUei1egdB0V7H+I7aN6Hga6BmT005NSBtOul+mmz?=
 =?us-ascii?Q?Ugsb9SsKCcHVx3JwBpfFOwxGedmPaZC3tpdeOGsLBZFhYq5qyfpjQ6rhgJIN?=
 =?us-ascii?Q?l9msGrtaIOgFrQJyKkQ0bILaEeyfvG9qHeiu/ulEfiOktmFpiS9hIJK6yayJ?=
 =?us-ascii?Q?1TuML5gic9NsqgqpQRUrVvTfRuIr2xJCZvZerNp337CoqMFgxlAJQS+4Nsw5?=
 =?us-ascii?Q?7Lz5I7knJgz1BsbWsmkoppBxnx8du9Q0J6tAfJVpnnI2NVZnPtUntyjoat1o?=
 =?us-ascii?Q?wGchAtEbn84npNe0tMib9dLNLys+qVSX7LB74YtH6AwBvgJ3krrnviuKQurb?=
 =?us-ascii?Q?HLoTEs/0YKRrRKfmxaKWlWq7A5wRoJslyKtR5l3oXpJoLUsVL6zhoVy79OiV?=
 =?us-ascii?Q?xBm2/zusy+vgTgmlV3hRlQ7lScqZI6cPZ8z0sUPXxaZhfQbvq07ezo9qnn0Y?=
 =?us-ascii?Q?8ZkULZHkiyqs0V5BoUNHhY5noqkoMYKGcVprpS/seG/B8gfT5CQwYk7nQYRg?=
 =?us-ascii?Q?yB1D0X3sv89do6Z2W22Ro5x7EyFneiYIQiU0xqzx3nplHuHezmyDVA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a/NcAzr/WcU+PP+vYHD7YXQAkjNFhO1rUcXeLd0P7aanPAReTWof7PIhM7l8?=
 =?us-ascii?Q?iHSFjotKT8mdo1u+pTiLGKpcJTNE2zDnRkU7iofMVDdgY3ZqrxyehaY3DOuI?=
 =?us-ascii?Q?TPOoVi88fUXGNMW9qSZ2pvBzoBDfg8wK6orW0TZ4s7MwfHVsXS8uB5qL5PBr?=
 =?us-ascii?Q?BMlzC3BQ3E5G9+RmtmL+1vZbgjcDmED675iMVlWHk0fASMRBrnOYxZbgCzda?=
 =?us-ascii?Q?yH6ylYngcYecfISpSSCK4ifbD8HthWKlvCOPq+UYAlMT3v2gSrcEoaYFtM8V?=
 =?us-ascii?Q?ewg4pFO2+iaxEgwAlgawc7NtcI0jURzsKFhv5I09fd4Devd+3+skxLbp/YRA?=
 =?us-ascii?Q?EV4156L6ei/yytGLrnpndxcEloJ5qAz2UrJuim958hr8d3KQxnn88uk4Objh?=
 =?us-ascii?Q?+ar8WmEL60hl4/DTM7ya3hclrQmmF6G0CnY2ufG+VaXie5cihKnXSEbXe/VM?=
 =?us-ascii?Q?Gqg+NKjSwVTQjGmZa/O4dY3gco6Lm9kyhAtmTpIvLwWRrNEiwJ7nEHwmzV+8?=
 =?us-ascii?Q?CoEq6LU/c55FQzPei5HrWkBu8e5hqABfTWq2b6EKZ6znxFc/RNVpV7K0483v?=
 =?us-ascii?Q?M4OocxN2c3rkIVI1hSMhz++3By6ko1065N1RrYHUYMFS5c/5Nciw7ZhNL2nz?=
 =?us-ascii?Q?g63rxCNrsAxYNtNrGm8bAx80LtbS4j44hx4w/FtxBXf0UQOtAa1sWdF2fIDq?=
 =?us-ascii?Q?i8Mf0T1OPD9Exz+a0b55V0K7dn6dNUIkTpb6sKVr7sQ1kW3kZ8sv3s06kvB6?=
 =?us-ascii?Q?OOqpwRl0n82rSQdBhnmI4A2zeIWIJuyFHCe5VrIAztAzeuBdErrq+LxWAyau?=
 =?us-ascii?Q?WACCbemYHg6D3L0py4baO45Pj8F64byqTnOcpG+7Oh8ul4Szl+gX42m8gLS4?=
 =?us-ascii?Q?Aq9yhEwBcq370ld7sAMlkA9XCCnDePCa/bCXDP+6Blb6PFx9vuiRctl8ygbl?=
 =?us-ascii?Q?fF3q+IejEehSpaHzNwi3QTW+gTC4xruUX0IYUwC7fAnz0CPSnxF7izUA5RRF?=
 =?us-ascii?Q?4YHOVAgz3Z9NAQWrJ5t+j+Ttn74b+iHoNpy8hMIfGuvWZ1lc38BDfB7wVNJg?=
 =?us-ascii?Q?2kAmpRte98wo8pd2foScHd8/60EWnl2SeHmpBdNlkxdRNFcYsuC5rhJhDiel?=
 =?us-ascii?Q?t8D3JtlM07nULgLo6LGWIL2V2sZQlpu4G23ezYT1349N+q88hTIcdl0ldx/e?=
 =?us-ascii?Q?fgVEzYgePFPNbB8HQT2d1dHYnWDmLjf58P/g9yEVdkQVdIxw/cMzzoXJm7rs?=
 =?us-ascii?Q?sCex15p3NvqASUke9kbhpVnQBi4xQ+1xMIEI0fPAp0kweI6g6ThNPKx5nRjw?=
 =?us-ascii?Q?yXPKYquOOUan4F6KHugcvMcHgDckNEuESm7psDy4/ahQsidcqJawieKf1JA7?=
 =?us-ascii?Q?WVk0oQ5tbDYjcv+//8kYkbbPWoHxb0Hm1Gi/IQwPhus+7NZO20pAObdZU5EY?=
 =?us-ascii?Q?4sZQKsh7lkIoDyt4dAsLV0al4MxlV7sNivK0FXY1Ar4Vi7ouM69N0DvlsT5S?=
 =?us-ascii?Q?jMKXrpjJADrynZ4eGf7G/t5r9hH57rKoQLkaYqsKl3gC0f7crcXAgBGmFbso?=
 =?us-ascii?Q?5WjavoDkP5Zzungu+vGaZiAlo3O9LYCCPbYCDpHo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee5da00-0cf5-4149-f554-08ddec8c0ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 14:54:01.0337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hr0xUZtMzb+MzBcKiwwK6YscWWYSe4ZgN+j8bGuRbEEkyWuBw3i0738TA/H3bLylgGqYzIXnIGNQsucaWcGL0sANPo8TTrKV1pTf1fWbYC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Wednesday, August 13, 2025 12:10 PM
> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>; intel-wired-
> lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Olech, Milena <milena.olech@intel.com>
> Subject: RE: [Intel-wired-lan] [PATCH v9 iwl-next] ice: add recovery cloc=
k and
> clock 1588 control for E825c
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Grzegorz Nitka
> > Sent: Tuesday, August 12, 2025 10:20 PM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; Kubalewski,
> > Arkadiusz <arkadiusz.kubalewski@intel.com>; Korba, Przemyslaw
> > <przemyslaw.korba@intel.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Olech, Milena <milena.olech@intel.com>
> > Subject: [Intel-wired-lan] [PATCH v9 iwl-next] ice: add recovery
> > clock and clock 1588 control for E825c
> >
> > From: Przemyslaw Korba <przemyslaw.korba@intel.com>
> >
> > Add control for E825 input pins: phy clock recovery and clock 1588.
> > E825 does not provide control over platform level DPLL but it
> > provides control over PHY clock recovery, and PTP/timestamp driven
> > inputs for platform level DPLL [1].
> >
> > Introduce a software controlled layer of abstraction to:
> > - create a DPLL of type EEC for E825c,
> > - create recovered clock pin for each PF, and control them through
> > writing to registers,
> > - create pin to control clock 1588 for PF0, and control it through
> > writing to registers.
> >
>=20
> ...
>=20
> > +
> > +#define ICE_CGU_R10				0x28
> > +#define ICE_CGU_R10_SYNCE_CLKO_SEL		GENMASK(8, 5)
> > +#define ICE_CGU_R10_SYNCE_CLKODIV_M1
> 	GENMASK(13, 9)
> > +#define ICE_CGU_R10_SYNCE_CLKODIV_LOAD		BIT(14)
> > +#define ICE_CGU_R10_SYNCE_DCK_RST		BIT(15)
> > +#define ICE_CGU_R10_SYNCE_ETHCLKO_SEL
> 	GENMASK(18, 16)
> > +#define ICE_CGU_R10_SYNCE_ETHDIV_M1		GENMASK(23, 19)
> > +#define ICE_CGU_R10_SYNCE_ETHDIV_LOAD		BIT(24)
> > +#define ICE_CGU_R10_SYNCE_DCK2_RST		BIT(25)
> > +#define ICE_CGU_R10_SYNCE_S_REF_CLK		GENMASK(31, 27)
> > +
> > +#define ICE_CGU_R11				0x2C
> > +#define ICE_CGU_R11_SYNCE_S_BYP_CLK		GENMASK(6, 1)
> > +
> > +#define ICE_CGU_BYPASS_MUX_OFFSET_E825C		3
> > +
> > +#define SET_PIN_STATE(_pin, _id, _condition) \
> > +	((_pin)->state[_id] =3D (_condition) ? DPLL_PIN_STATE_CONNECTED
> > : \
> > +			       DPLL_PIN_STATE_DISCONNECTED)
> Can you consider implement it as inline function instead of macro?
>=20
> Alex

Apologize for late response (summer break time). To be changed in v10.

