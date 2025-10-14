Return-Path: <netdev+bounces-229078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DEBD8026
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CF23B4E78
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58C930E0EB;
	Tue, 14 Oct 2025 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWnCwOGP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE51E3DED
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428268; cv=fail; b=j71KiZ2dyo45XW1Axt4UFfXEs6mXnPy7gafdJhqfOgPcHHz5FeUF4lCJezHLTds/IXJe1Vcogf1nczW2x/k5n668Im//ASzUI+pQKzGHTgDI+wUrw3LgEoAXpPdDLrNuM2enYCqywx+CdwwjXhMxXC0iwicd/AjNNmpJGUrJca4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428268; c=relaxed/simple;
	bh=QGjr8/PXS8DtxTR7ZHxwP/2lIL/0MtMYkxvjP8pSwy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tRv5e0TCejHsA7sL6sDLq15LB6F9TdQPUCD/+0yR4bGbja2XuxvK7hEUWm55FXSftSY8kE6Aob2nolGR5flZxs0C7Jrv8elH7pTaOInYdavzCOWWCGylXIlhvhasjg2xHmqA80s6vXvXlwbw/V0c8Ctjo9i9eSjSxsYUmqsV9V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWnCwOGP; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760428267; x=1791964267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QGjr8/PXS8DtxTR7ZHxwP/2lIL/0MtMYkxvjP8pSwy4=;
  b=MWnCwOGPLM7YSop5stoz7JnBRMoMJiyzT+0BmQsLaWpU/6Gjn1AOAVpg
   lfZoBR/yT669EWK/7zSB+MRYspCol9IFelY8NLx/b/ks4N9Ejqt83BtFF
   n/4MCw8rETHwTL1fPTLybna12UG+8QjBfTnQUYJVehNnsGqztPxoTQ0EJ
   sHuswqQbPRcwqu/umyD95KB4JRbQgwnut6DszVkGW7xodzNBUK+wRmZ5L
   pCUgqiRkuSWLpQJ95ZejCua/uLud5Vk4Ah4jF4LmbtXHJn5BKFv+CJ8PQ
   8joJxTDxy7ehIsnTP/DXmBhZun3OsORmYYrvdODEe4wFBQ+hBeFTMYF92
   Q==;
X-CSE-ConnectionGUID: z9PKtLyJTae5YIJ2wAMsyA==
X-CSE-MsgGUID: JVlOS13BQVef6deH/3pfkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="80019296"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="80019296"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:51:04 -0700
X-CSE-ConnectionGUID: NBOJ00I2SWOGKq/4EbmIyg==
X-CSE-MsgGUID: gOE8qt1dT9a4XAvGFbehnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="218955840"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:51:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 00:51:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 00:51:03 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 00:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWsTy28Lnp9vLe7th7TYddFtw+plH972rqB84JWj1sqYwKSIWk3OE5ThmmULfk99kYVrlnWv8SkFo0FNvvAdGQSd7AMu+UNSsIRi3/3Vu+3PaRCztCibT+t3IqYAu09cDY/vRFjxTVwFAjMZoKXaYUBb90RRfFpTwykD9cSQ6I84OCIpjIDEaZV5IybXXXdf1pA9OL+2KNQvCwYuXOwzOrCJIweDNOocxRFoyRR0RIygwg0WpBZNePAonxintCykg2vVRdXirZT8UtzrPPI6La06H5EDwPx1o9j3uxmqwTt9NyCWo/PIvTzLVhTnPVNAuAnTBZrGevUKL1EM9i52FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGjr8/PXS8DtxTR7ZHxwP/2lIL/0MtMYkxvjP8pSwy4=;
 b=N6nCSEEOg5CVVqSvrCIofMam8dFRtat95Ux/BYs0LnrHkATDh5ogcDjV/jrkSKGopWJE6/rSh/9y/J7furYP3i+gHuzPA4k8TzQDZcxnGSHT1qwM70Q6Atmn3D8svmBrHjMfDvRUktXMK1RTL1fNH7DCLMCmMLRE2Po0R7PO9J8yNSvi2cR5ICX6+GXybzIqTpJLO/LqM0VqwSrLYYxa1CNokYNxyYn7MWbHv1pqljUltNu+VR4ICMSGn360DAoInxH+0yxQEassrsGnvTu/TgfsVYzNoJp4YnibQJ9ofjrAA3BOIr/PS8pGVLG2Yodnn7EMJ0kYaN2e0byNxseghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 07:51:00 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 07:51:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v8 8/9] idpf: avoid calling
 get_rx_ptypes for each vport
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v8 8/9] idpf: avoid calling
 get_rx_ptypes for each vport
Thread-Index: AQHcPJaVB4WmYfyAGkSmyb2G2UMZwLTBRUYg
Date: Tue, 14 Oct 2025 07:50:59 +0000
Message-ID: <IA3PR11MB89863A24935B6C2B6425ECFAE5EBA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251013231341.1139603-1-joshua.a.hay@intel.com>
 <20251013231341.1139603-9-joshua.a.hay@intel.com>
In-Reply-To: <20251013231341.1139603-9-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB8253:EE_
x-ms-office365-filtering-correlation-id: 4c20e497-87a7-48dc-d21a-08de0af66aa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?dyJ5ai+S6u3k+8XKTiTk4O90oUyMg96vMGyTiZ2n9Ki0amQPHeLTS7bkvypc?=
 =?us-ascii?Q?mxTk7hyXQhWX0aCh0HFKG0cidZhMoepkzfXDea2IyjQeVJqwbf03+ONvMQlj?=
 =?us-ascii?Q?MWDnLtvfjyoAh1Xf+/d1LC/6Qt+Qoidyrb2HYq5a0WWm1S44cMZvDzNj/Jds?=
 =?us-ascii?Q?SL65ohtjTJFOi4+v2bYvDA3PA4FpIR3bnQCFk4FiHRtYubQfzJXyaB437cc7?=
 =?us-ascii?Q?OoRVku49s8j+Y24+6TC9TnuciHMVc8WWHzZtRXzZWDk54SjWyNWcEmBIHw4s?=
 =?us-ascii?Q?AqNACbiVF8knu8DLgkD7tX8lwkl+Gf/adwwqPgifc2oLs4jDw9xdelodSdXg?=
 =?us-ascii?Q?egHw0+L9FWn7CnqtPme6Yy4jLc9eW141jNMPwWvJcbaf4+HKiwSSM+xg0XPh?=
 =?us-ascii?Q?5n+j7Sw+q2JyHZpn8uVA/2q0HEz1lAuGP6KchG4dDAk+DzDpS8LEKVyIGOB8?=
 =?us-ascii?Q?8w9mimIdxgoAbdwMHGWzWaJKq0vlsoFXij0d1E5JnHwDM/FaRIYRRuhNr6fB?=
 =?us-ascii?Q?XLqe3RFCMKckCe/4hZzB+wIdKSbITrSwgAHE/VLUHOggErmzNcC/jnYWbAxL?=
 =?us-ascii?Q?0YbtCIGsnxUaTuIoovN73Px0zSyLA14JdZsNPU8ucblnaHwxdTLIzfDtYk7O?=
 =?us-ascii?Q?99qkDyacXbuz+Sva5uZoKFoo95HSPRlIJGH4232ku3CSjZ9pEts5jVbYcaBi?=
 =?us-ascii?Q?J9B7XaxeM3IAI75G4p/MuoyjVS2R1sbC64jHSJqEAGoOlL8XUQLcZi5SULd7?=
 =?us-ascii?Q?S+KjfaV1qmj7rxQS00jqMknzmE6gXbQHlQGIB3oiGALJNZse/cq5JhDLgtGL?=
 =?us-ascii?Q?z4Pm3hnxFljQuErKtokH5kBtmPhNr9SUz+pxcRtD35Z4Hxx7KnMc2FiwaOUL?=
 =?us-ascii?Q?uMZtDGWfbf7NHYl1bY9O0vf/sCR71N1sikgKusxvyvXtwVGxf0edRtHbti5h?=
 =?us-ascii?Q?vxxeOXRZgGRko/VFJGTcf0QtHzz3BUlizNVzYZeM/cooHifrb1ZiJ0sGTDLF?=
 =?us-ascii?Q?DfpdPMQXVFqE/rBa5QFJzVlawuJSA1114eg7cRvWHgxnbqDS2jlx6T3XG0jF?=
 =?us-ascii?Q?XF3RzvIZSPilLPKPqHAciPtIzJdEUeUBvS44iUniSquBOf+O8TG+mZv7gKiu?=
 =?us-ascii?Q?ZNMyL+haPCujUc59vlEKuvrdroccKPMG/VEvLGtt0wgfeuaKAu2k4RKP+9PA?=
 =?us-ascii?Q?rY3lb5Aoxs6etl/CWeZFQnomGq8bVVTgfhrcVPHzxrMDvfiFtF58bCnBnXzk?=
 =?us-ascii?Q?bjx2vpWwq3Xy8oNPlRTMaCmBwdSJPeMFT+bAC4kPNrH0TOpiFx5ECZ0X1qem?=
 =?us-ascii?Q?pGmoNmgt8E+bxIg9tKz9GbfaDVxIv5vwl8+3cRgUIg4olDtei2FRBODTRO6e?=
 =?us-ascii?Q?RkwJRmnkD3VrW5RTd2zGsqNzOGXJDhY6nd9lB6gssgfXUOCbofpktpQ4j9D1?=
 =?us-ascii?Q?oTI6xyl/zHNcvCNCZFK5BUXJNFi24ebo9lHXBo+7h7ZyZE9Q1YPn5z99A0pl?=
 =?us-ascii?Q?HBEez3AaRy34qW0HiU03kbowOVry20Zm1Vg0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u1Z0FKR9xQQf0yFzbRnz7bz+6uRvVml4H3LVjik0vYLz0UiMgB8pkAqLcQVd?=
 =?us-ascii?Q?tMZTdlTuxfx8vEqvgagmWLRIjzUkH66ivuipqsze9AwoNyf/GUPMLqShKpHy?=
 =?us-ascii?Q?Gzt8UbJSleM/XBTbdgK0G9vTKniNIUQreVUMhi4caiNyIeGkVYY4gP6v83C4?=
 =?us-ascii?Q?LfefyE+qu6YjoPkrUWAUisjCtgeglY3O0x45TXkLAZIA72jN+CAL/7NMKhix?=
 =?us-ascii?Q?JeE/q7Ng+RyqOtqvfb9XRfyV0WItweisRZnhj4AV1uPITWR6bPEudUIDMHyR?=
 =?us-ascii?Q?2kC5o7oEdcOwK1H7kFsjIt17CppHy6ieuQJCxSG3Mi9/IrlBZIsDlWeXlOax?=
 =?us-ascii?Q?+CokoBSzpzWdN5nF4B6tDW9l2X+jeS9n+MVcf3M/IGZ9CE/YaUqk8/twJwdo?=
 =?us-ascii?Q?fcaUGZTVp41FVVdWF5pj/iRvNDlCNlFmStqekfDTczfRX8U25n5KUIjJZNFi?=
 =?us-ascii?Q?GPKQuGy5Nq/IKqal1Ol3J//bLkbpnOT9/oq16iybNljk5RD3IZq2Zol5Ywui?=
 =?us-ascii?Q?BZAvnRgxngsvnrgnNaNhd1IpXGQBkH7qdVorcwSGKqiGMds5y2KHf+OA9iYS?=
 =?us-ascii?Q?uO35eQIJYbFM3a4l3a4BX04etejqYaD2jY0uw0nzvkZBVYRNANjN183FTohX?=
 =?us-ascii?Q?5zRwya7yeqaf0IgoUVHpSErRjp3ftDa7nd38YTR9NYPfa61fgjk/WviaaKNy?=
 =?us-ascii?Q?zgLTD1+QD+mI5Z3a+69fbEpKPRNrFK5rY9g6ayZa8LRgOWNzM+0eZinhC9MD?=
 =?us-ascii?Q?TDLeqnUCNUTamvilj2Oj1518Y4bWN1HH7qb4/xaMTrIDpghe0neOjSNy+8Jw?=
 =?us-ascii?Q?upK07CYHHJZpI47AT6um/Rncxu3i9QZmpnf5lmKqIgLq/GYkVBh4nFIh6HQy?=
 =?us-ascii?Q?HqToXih2UyxzIL0iPkEBACXamkuEliisCXjk+nz9bfrV/8wXKp9Ss0kkVJzH?=
 =?us-ascii?Q?nEeJR2yc4IpDb2YeIQIrFk/aNfdP6QILU0MVacjKKWvVhaesS8YLdD0Fl9FE?=
 =?us-ascii?Q?XCOPH4giuNs7YxU53vm0uY5vhNRwJNq5hQ23XJ2Kbw9mJ6p4lQPfnLmBHFoq?=
 =?us-ascii?Q?KHqKK8X0VQuPet1d924auZyO6qUM/YQEDm3FJRVjdjHDIbHPKA6Xil0E3utW?=
 =?us-ascii?Q?kehVvwi4Th+RmmPL9sD80GOgpc4iaE9TXCX/fKnL689C9iNQERro5r9MJpF7?=
 =?us-ascii?Q?9QZ7d4HvIXYH0ntnjnQTtghzs1qjedXLJw/azKoG03Rc76jNhTj/z9R3W+lr?=
 =?us-ascii?Q?yXOFhY1PQ08qB3VeVXk0IfnKnS9/HZ+Pc/YVRmk4ZCNhAxsc1hymPeYtR/6n?=
 =?us-ascii?Q?Jfbr2YPJvgXY724nnirbIi2TgvA1YZolknTsCxltggSfhYdwS+8DpV5xDKta?=
 =?us-ascii?Q?eF9xShX3riuDRCtZMQZ/qiypobK/bTblpVqCwFgwAodWnNR9d3gscu6oE5tZ?=
 =?us-ascii?Q?ZX5TtVQIwRQ8RwamXVaR2aqrk2La1MnyylZl9oFWrCsnJfq6Aty7kINKSMJ9?=
 =?us-ascii?Q?d1kDgdgLzdnJnAxLeNLewg02o8aSfGMqbcmE5ouinwSe80qaq5yINM65xAuY?=
 =?us-ascii?Q?JD/xahoXOzHUso3T/7W5/NLVbs4Xle6KNYBxqRBEtFi5MQSch6+DRLBb30S9?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c20e497-87a7-48dc-d21a-08de0af66aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 07:51:00.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFRb5nA+TiibINlrvXrestPoJtrrMcdA6kd//CI1HGAJj3gCp+WsDoQsjsEybDkc1ZwpypNI7pIPq6SojLn3qVkfPphnn0PUgoWLK6Z4Ww8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Joshua Hay
> Sent: Tuesday, October 14, 2025 1:14 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v8 8/9] idpf: avoid calling
> get_rx_ptypes for each vport
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> RX ptypes received from device control plane doesn't depend on vport
> info, but might vary based on the queue model. When the driver
> requests for ptypes, control plane fills both ptype_id_10 (used for
> splitq) and
> ptype_id_8 (used for singleq) fields of the virtchnl2_ptype response
> structure. This allows to call get_rx_ptypes once at the adapter level
> instead of each vport.
>=20
> Parse and store the received ptypes of both splitq and singleq in a
> separate lookup table. Respective lookup table is used based on the
> queue model info. As part of the changes, pull the ptype protocol
> parsing code into a separate function.
>=20
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
> v8: rebase on AF_XDP series
> ---
...
> --
> 2.39.2

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


