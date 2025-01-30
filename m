Return-Path: <netdev+bounces-161685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C91BA234A1
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 20:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA15F3A7C5B
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 19:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB811EE7CB;
	Thu, 30 Jan 2025 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mxi89P59"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F4199939
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264785; cv=fail; b=Te7PpwRaUvCkJmX69gW1b29PXI85hKam1xcmr2cdmw0p4TbSm99zV+/NbyWoJow3TaHlE/pn9iq+JVz7lt3LsnG2Aa0GTGPZPMncvdalsKTMrHkrdylTKddl/N1B9gNKY6DsiECr9gLdRute5zaEGCXoR2tCNA6BIQHUzh4Nmi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264785; c=relaxed/simple;
	bh=dzr1mpiJE5RyysIusxPUgp96VwIE6qFXwzWpqzKQjRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bqc+CIQNWm07o4TSUa1xCjRLbgSyd4ncEwHJNfi2BfSi5R1k6rGBATUfqQ1a1pOID2+2QhWtteAGj6eln5YZ7MCeHTnOlV5lhxxVGUeTiZEM8d30+O1YGmVryBIS87niKxiSRLyMXB6kIlSlPbEvJ4IvRCy1CHMZCCW38AdFubU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mxi89P59; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738264784; x=1769800784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dzr1mpiJE5RyysIusxPUgp96VwIE6qFXwzWpqzKQjRk=;
  b=Mxi89P59t2nVNgmYdYJtriOAfUjDepzsPo3Xbf18SBnxqyv99y3t9XP3
   aKFjMpf0JuVTRgtK2y0n78lJCeHfq4HuFvQxqJmanO7LcJlkvm0/ZkPSP
   r5tQN5RZyNEAXmu7JpL5/14+OKO3m4cRnRpWR/p8mDC/nkZUtrxFOssQa
   GrOmh2vFSa4763PursZPLVOzGCoseu3L4N+jViRfPfPYRu/ruujS4qvBN
   DeCx2TozjaDXdc37dX3bxX/V1pG+VJe1GSm/JTzYkwXmOjUX7j8gzw53p
   0Ke5rYOKaPaSOzy0rfqiYNxcqq/OHKZKW/5Ya4i3PiGgn7mO2u8ag2v5T
   w==;
X-CSE-ConnectionGUID: dkFVFjqqSwePA8Oi313FZg==
X-CSE-MsgGUID: TRWpmsFcRFO8YcoOv1jDYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="39100045"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="39100045"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 11:19:43 -0800
X-CSE-ConnectionGUID: mSJW1p63ShuvgFxubMa4PA==
X-CSE-MsgGUID: dxJsVXJBTBCSQLCFEnwSxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146606642"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2025 11:19:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 30 Jan 2025 11:19:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 30 Jan 2025 11:19:42 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 30 Jan 2025 11:19:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr0kndUn2qA1kwZFlyYS6iSOvnIVSRUgIcDMI9x9Ulu9CmD4Vwjy6KMzU+AgK5YFcp/pd8GjVVPPzMrT9wOYTyqk83m37QjfTaQvqUyw60IdjaFhxSTVtAysvMz+w/OS7aKtOLE3dZEbNuiGjgbqmf138xD/uUmqnK3VYLn9hEfFLh8R/VOtLLzhG31uZM4ZZo51YyWNE5zPL8MVua0gzQMBNnJkc6qm3ROqtm9bjPZe/IfQdlJtVnd4PSnAaa84bVIBPPY/X2FoALgARMcR8hH7O7q6q/+ffAgdcT+FNFkqcVTx7V/pUefrTRErhhUsepd+/LOrYWbmgYYVoCaGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzr1mpiJE5RyysIusxPUgp96VwIE6qFXwzWpqzKQjRk=;
 b=H9n5ssBw6LaVKdmlQkDBuexPCJWo27HpyuK9KFpjc4u0R+B40peiA1k7dRDrUqSl5Vpr32h9FF8VPh4cndUyRATbu1vaC6RQm532fPDHhUU22F8KmQrPuhsdW1aksf/byh9VUPRtq1TP4R3dScUocHHoK6qiMAOwUk4GSRLfw52AZbvGkDu8TtQyHnwp8G1XFssdGEUSPF5kooZQS0SCMQjF49W0LblM8WeZHdAPKstIVSjhO08SKw3xgfPZxIRVPP+4nent7WbhPZSMnaKB0imuFy9n+qohSDznbn/5sCQ4ZCKaWA/aldvMLYfArDooop/+k9T7ngYHy5xojSQXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9)
 by PH7PR11MB6032.namprd11.prod.outlook.com (2603:10b6:510:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 19:18:54 +0000
Received: from IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5]) by IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5%4]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 19:18:54 +0000
From: "Joshi, Sreedevi" <sreedevi.joshi@intel.com>
To: Russell King <linux@armlinux.org.uk>, sreedevi.joshi
	<joshisre@ecsmtp.an.intel.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] phy: fix null pointer issue in phy_attach_direct()
Thread-Topic: [PATCH net] phy: fix null pointer issue in phy_attach_direct()
Thread-Index: AQHbcnzIjUJuMNncQ0eitKAUk2d4urMuI2SAgAGNrNA=
Date: Thu, 30 Jan 2025 19:18:53 +0000
Message-ID: <IA1PR11MB62896ACA123AAED81DA3FFC689E92@IA1PR11MB6289.namprd11.prod.outlook.com>
References: <20250129183638.695010-1-sreedevi.joshi@intel.com>
 <Z5qBt4Cnds7NvBea@shell.armlinux.org.uk>
In-Reply-To: <Z5qBt4Cnds7NvBea@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6289:EE_|PH7PR11MB6032:EE_
x-ms-office365-filtering-correlation-id: 879a3b09-2aec-488f-364c-08dd4162efab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?s+SDOStPGKC1sZw4KlOVtAdC2S3gPjT27d8YI1e060xyQ8vXZvAZM9qgTe0g?=
 =?us-ascii?Q?64HGnW96IHMSbEIRHZfummV2X8ispw+aEmdND2zCLdgWUcgdgAcSU8qPv10b?=
 =?us-ascii?Q?lH1c1cv9tvS/+989F+QAynWo6svknW8DqxEVTJgYnQ/VH9T2MO4mhR0augiR?=
 =?us-ascii?Q?XfHMorB3lWIKMl3BtDi1YPkxDWArNYQlfWog2G3Yzn6dJKgmQlPP6ipGoHBL?=
 =?us-ascii?Q?j0X/EMvI2JhtUyoWBGVBWft75A9zxnLCozJhdL4yNyAFGyvqsx+lo9YyIJGl?=
 =?us-ascii?Q?vPbIDXGCXixthlov5M27RdVh2oPkNLByMBBWYlFV66zPH1eRj0cphAoWWJUJ?=
 =?us-ascii?Q?BKGo48d1tAIq1mnJdgDT+5/VI6FafiUviyvqxIDVntQCKoSsUGBlhSvODx0i?=
 =?us-ascii?Q?iNCbio1wdnHpd/eX6XnnzOHxc/baFMhA/LOP9FSCjWeIzO4sZ5tNnF6xjmj0?=
 =?us-ascii?Q?cRdKn2d/XI68hWnt2QBCXWzyeE9NhDRliaiOpkeGR15XCNiIr0elOBMcySwk?=
 =?us-ascii?Q?rhB0anNEGMKS3F6b3++sqeomSXXLuOMW9ab297ogLvr4e+GvCrSJma4tx7Ih?=
 =?us-ascii?Q?BwcYOTbTc4BVVYFs2gzsm0LvDwPwSW+W2k+ong2YPXwBesMO7+Ea/xKVp/4D?=
 =?us-ascii?Q?Nr0XO8wb1S/u/etrc3ltdkrEAMxG1zHnDEinMeRaSAmD6R7TqR2/sHB1wG4Q?=
 =?us-ascii?Q?edv2TviHMlMgyY2Pc5KTloH8c/yS9HjzLEMiBN2SOo27mV0V/S3yYMfzxcdX?=
 =?us-ascii?Q?i03/3qV/ICCnqnwZPgqABvoRlWu/mSxqetNuZkqmpvZpRoxcJDHlB7MOJmGe?=
 =?us-ascii?Q?yaDeIgAZkRiP9r6nAXXR0bpPSPrY+LRrCWDNNQhQfs8QP30KGhVTEpnjQpTn?=
 =?us-ascii?Q?ky3iU8s2+OJvKuvSCAFG0IFCcGt9tNGzVItzP+g2dL6Z1KeV7pPRBsQIpcOG?=
 =?us-ascii?Q?dHcT+azshDMh22tPQXodX4RH7U+S2t146cJyL6JrWYlsGBLmSrwuLi4qHBHC?=
 =?us-ascii?Q?2IEUU3GtlKFXlAj07qFuqjLMCUPcPNWuDxsxhfB8opYHrQ5wQf1EB0XHf4Pz?=
 =?us-ascii?Q?yF2eNIPLXqpmFMjQ4Ic/UPO9CT5LDJsn662Bf3ffp8I5F+fI//EVnBj/FtB/?=
 =?us-ascii?Q?Nrq/KxGTQ4h4lgm7TFxVXeMc6auvNZYNM+tzw3EnvDoMpW44g+rYdxh1BfjZ?=
 =?us-ascii?Q?CZObc6EUD4EJPwNZYYQYvFgJKspK019cjXvlMxAetBopn4ZWgUMTwlR/eoXu?=
 =?us-ascii?Q?37WJ7hOul7ow01maJJbE+XyffBFvNMuZ0KoJyK08+S/JeZRCKg7MK1jki7mK?=
 =?us-ascii?Q?h1Z8Qw+CjEnm5U1ceNTJC3UKAl8et6nz/JQ0i1eAxOOhiBzuMaUbAmYoDezO?=
 =?us-ascii?Q?x/QiegfkaHxYvbENHiUjO3xZsNz5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2cp3r8Ahwly+JN6NMbc7zzSx/Vz4Q3Gbp36HzLXP8ULuabsfU9LHCJRu0Zes?=
 =?us-ascii?Q?17y+uwP7X2E7IRuOn8pdi0M3gS7ywakm06DeMoVOQEWUHSPxmp/JJyKPMPAl?=
 =?us-ascii?Q?bUlERO7V5weqoXpjQujoICiZb7DdZ2+ZuFyVDUpM4chm7ZLiar+gabLEtgB7?=
 =?us-ascii?Q?0Xx7I9ErbJ/SgFSDdVaoSY2SJZ4ldsIHKZR7cowhVWAU/xTowW5nVwqDXqBm?=
 =?us-ascii?Q?IfKiFNZJRTi5br+N2fSZQ+VT1Dv8Nm3T9ZV/mZvYx/n29l00+8mel2TH4Jsu?=
 =?us-ascii?Q?s8Ow1+dNDm0AsUzkrzkIsDCoeC0rj/5j1E0/Y+J+YdCw6lzIN73OFcfTMqE3?=
 =?us-ascii?Q?6ziH2sujVopuCiEgukPmZjAMW2YGYGO5zEYd5cwsaitiIYJIny2DFhA5HP++?=
 =?us-ascii?Q?I6w1aoSNRfDvg8J1+mnPSmkY7RKyOrictvMhrt6giQCvseLk2IjDNW/hGp7U?=
 =?us-ascii?Q?QPpDKNbDukS0Raoh5j247LfTx5horSWXWcvVVPpi8eM+1ON5oZIRiaehSs9+?=
 =?us-ascii?Q?Z1anjcA6sbt56lrT9uWLBuYCLfDkfGEU092FxDJpfzvsQxUHLL1y/TN9beBQ?=
 =?us-ascii?Q?P9BclmKBN0sJ8HW2/LUq0Pg1FKAZGzdeqhCFw71E1pwyXQH+Gl50lFlSG0KV?=
 =?us-ascii?Q?DVrwmJwRewdba6N8SZa8TkDWxqh5rjWGNmA5Gn1dGnbmQfco/11C8KG5wbKh?=
 =?us-ascii?Q?39rCsrLRxZRbGzEapPjTPDieolGChga66raJCdZsIRyxacrcPyl8D544FsAE?=
 =?us-ascii?Q?YvSKzL4VIPOshRn3fQr2GmTuAN84zIbTMb5JKcMJExOrSJOOmYS+08A8KJok?=
 =?us-ascii?Q?HB7pC2Ejbp88oK/Slh4+rwaaoZNA33PO33EQxn5ioRS9c6cHWtdisPwO4fho?=
 =?us-ascii?Q?aMlMvlySUcxankB2wcZWCeBzydzT+VM95LUQQvMwCNEZEvMyHgwl64oJ0lRL?=
 =?us-ascii?Q?EDZ1/v3tN8i6jajP7Wli+lvDMGuekpY3v1YSI855lSBP8f/MHbtCtrjiPKT5?=
 =?us-ascii?Q?hrvC8SFD5gV3OtkFwpl0kUkh59EoAVj1zgOjZJxkvBYBD7bxvkg4r3n2lvBv?=
 =?us-ascii?Q?baGAgXsO8vlW1oZvfG5mJQbDHNzHo2eX2/vDScvxSt175dzXqwJKgWAr1Nvb?=
 =?us-ascii?Q?p+Rjn0riXjkoZezOh6gHFPJvIryQG3CStTQibOxzDyUOAKznzYJJIPxcGGFC?=
 =?us-ascii?Q?HfwJFA46qd+7mbR8wnE3m/aLbCh66bXqiz9bJwfsjc8MRQvWp9m+qVWhdBni?=
 =?us-ascii?Q?j9FjFtRVpmOPGOpuY/V25m7AzAcZ0XaNaqqRDIkKJ9ZgtA1HhSu2uIKdOzv7?=
 =?us-ascii?Q?TimAvrVyHfRiV5AQQMkE/Z8lyt2A8lyxzEQGryu/8ZvVO0qIyWmnU/YjIep3?=
 =?us-ascii?Q?hyLGPW/4Akbo8DpGdDFLMg420QtvS9Lu4XM0KkTrknRXlxCamLeI+AL84dZ9?=
 =?us-ascii?Q?y7N3K3QzCeu6/T0xJYWHEfViu7LAfBin7q6gTsHo3qptEYKPRMCGyK3vcOUJ?=
 =?us-ascii?Q?TzkNpA+DVyitl6gvnpICS+DZbg/LjjAd1/1FioD8CknQnVvtxsNlmIptepA4?=
 =?us-ascii?Q?lE10mII/jRU8q6LGMCfTuVP/FV5R06IHciwGPIUG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879a3b09-2aec-488f-364c-08dd4162efab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 19:18:53.9974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYB9oWw/bjIfxoo4tSazoNaV+xQD2vJMDb6KmCAcCa3K4yUwvhm2FRJKD+7dfRMdNu9UtpMI1dZx19ZW4hzoIO9olBUicsE7m2bnKFJwJWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6032
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Wednesday, January 29, 2025 2:30 PM
> To: sreedevi.joshi <joshisre@ecsmtp.an.intel.com>
> Cc: andrew@lunn.ch; hkallweit1@gmail.com; edumazet@google.com; kuba@kerne=
l.org; pabeni@redhat.com;
> netdev@vger.kernel.org; Joshi, Sreedevi <sreedevi.joshi@intel.com>
> Subject: Re: [PATCH net] phy: fix null pointer issue in phy_attach_direct=
()
>=20
> On Wed, Jan 29, 2025 at 12:36:38PM -0600, sreedevi.joshi wrote:
> > From: Sreedevi Joshi <sreedevi.joshi@intel.com>
> >
> > When attaching a fixed phy to devices like veth, it is possible that
> > there is no parent. The logic in
> > phy_attach_direct() tries to access the driver member without checking
> > for the null. This causes segfault in the case of fixed phy.
>=20
> Kernel mode doesn't segfault. That's a userspace thing. Kernel mode oopse=
s.
You are right. My bad for using for the wrong terminology. I have attached =
the
Kernel Oops log in my previous reply.
>=20
> I'm confused. You mention veth, which presumably is drivers/net/veth.c.
> Grepping this driver for "phy" returns nothing. So how can veth be broken=
 by a phylib change?
Yes. There is no PHY attached to the veth. This is part of the POC we are w=
orking on. We attach a
Fixed PHY to veth so the mii_timestamper hooks can be exercised for the dem=
o. This was uncovered=20
during that and even though there is no PHY usually attached to a virtual i=
nterface, it may be good
idea to have the necessary check before accessing the member to avoid issue=
s. Wanted to check with
community if it can be included in the upstream driver.
>=20
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

