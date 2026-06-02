Return-Path: <netdev+bounces-294110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMuFOzejHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:32:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FA862BA08
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 912D63001CF2
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15FC3CAE6C;
	Tue,  2 Jun 2026 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njW0cPtw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A9380FDA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392741; cv=fail; b=dcE9ZUg1+RX4YKvcwK9epAXHTcJQwQPfZf7O1ruAA6Uk0h94NVc3wjdovKtfym8/pzm5rAry66ei1K8c7j4gg2m/Ro3+Z7JBPNfdJBsJ8RI0j5LN/bolw/JpwPO9IJGcFzBwToJfqAzofLLNuaGTCuI/3GJxxnTEZwIj9wMtm84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392741; c=relaxed/simple;
	bh=VIXzenQs1yd35yz68mbvgO/VSYIFvyvhxbU/tgmVdw4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pP8PM4HAKVTMyS/2jeXpBZWUqx2h8vAiifCHRSC915QHsNi/OxjoUoG7dXnRE0fGOAftJG2kbuLNL2ru+n6977VXR+ACakpllSP3w6ywAV/NRob4Mz62GDl5yvBVEKeQYyG36DYRJjcyczFpiEZk0OdyomgtybFwBJjF5DknLi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njW0cPtw; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780392735; x=1811928735;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VIXzenQs1yd35yz68mbvgO/VSYIFvyvhxbU/tgmVdw4=;
  b=njW0cPtwPWWldSVTVKcjczn1ob72DYK5IxduKeHceY2cH93HFlBzHJQr
   6ZWGHYL40i9QTB5tWqFdHsfKlyCSgywZ/6RwownXRR2FRnrWgDRF5A4Th
   Stm0zA8ULtpBFZRp+4Crl4OlxspjpHpkpZrhh6Lp0Nr0CP67/Qk7WmP9N
   UBBnpjkbzbDe6A9pJ0SOBAh//c20CcR6e97p3RtM5JjzSR5Az+A8N+TxS
   ejaZlQNVGEElY0Z1oB+0zP+aReNJgueh724pOgk9mlzvz6eYMhCd/60qH
   C0XIFm/hhsKKOrfYM+9rxGOD4wwOWhnJQjw+Ne6wYfv8bS1ReOGLxr4rP
   Q==;
X-CSE-ConnectionGUID: NWrNbEK+QiykZFQap4FIfw==
X-CSE-MsgGUID: a9xAXnoCSyy61f4ziede+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81231272"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81231272"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:32:04 -0700
X-CSE-ConnectionGUID: +DfEn7xuSHaG61ZqArof1Q==
X-CSE-MsgGUID: 9IvASk9oSHe8eluoriud1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="248781915"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:32:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 02:32:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 02:32:03 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.12)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 02:32:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpH4ysBX0xXeFasoZEsniK2McPvjsndcSlNBdZA8EPDUdSOXazea4T4fNFHmau19EV8J2moX1hHheyYwtJOAVvLzaH74y56pR2Xh2x8qhzrzTtdIfebo8jDLva6M4AWuJO53Oz31UDssBfKJFqKSvrhNyLpSiA4HeTYAyviyEtD3x8ykIvCq4UeEOnEVd+14f6cnik1wEuvYmCgoIpELKh3hjEGgRmq0bE5HcbD+6NBSkafWoKfFLXbl5ZwRNfSuvb8Y0K6QcLLT3ihzNM83FX5FOT1syJkrgC4MhptbCU+JGxfijpKorBjQa8R26uYXi/rZo9YuL/d3+04tp0/3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIXzenQs1yd35yz68mbvgO/VSYIFvyvhxbU/tgmVdw4=;
 b=WMr4h7pobjtXP+EsDr8lvmc/xOcMzq/V1qB6z5m5CFds0fjevkIN3/WKvsaoR6kCOpXVjB56qM7HS1M6zg/ekKyFMbkpGS5HLA/hy+wILSpHIEq+5clL51wCW0XLUrFyf7GRSz81B8zRdbumJw3j35ZjYlOjwmiwEz2ZPlFG+q4M8otNI/gEyOjJtsa8rm0H2DrU073HR6Reg+IMo12+DIeIUxI3kejaLGdb6keVtFOjDdKde9+fFFkzb7GNI5j/G7qyjQhu+VJm0+TxaHSycGPon8/pxJzU2AtCG5DNAdR4XX0jOCnhkRrtd/i4vggTM4WFlZ8Q3mOuy0yP4veuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 09:32:01 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 09:32:01 +0000
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
Subject: RE: [PATCH net-next 2/8] net: mdio: realtek-rtl9300: Correctly handle
 ethernet-phy-package
Thread-Topic: [PATCH net-next 2/8] net: mdio: realtek-rtl9300: Correctly
 handle ethernet-phy-package
Thread-Index: AQHc8lEO93uKzUJnU0Sx9zGd9jsgNLYrAGow
Date: Tue, 2 Jun 2026 09:32:01 +0000
Message-ID: <PH0PR11MB59021E62692FC52557016A9DF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-3-markus.stockhausen@gmx.de>
In-Reply-To: <20260602052640.93083-3-markus.stockhausen@gmx.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DS0PR11MB7529:EE_
x-ms-office365-filtering-correlation-id: c2ff5ad1-98dc-46cb-0ab1-08dec089ccb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|18002099003|22082099003|921020|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: F4NjeQx2rX9hRJ1PqWMG8mwI1S9davCM4wqw8fRqWs39AM6dxgiFM/vEtTVGehBlXTge4/aJ70ORg5zAhQjGejUg8roDgr4lEAHmE5UDeTIQh+RkmmSzPvJrw8mOePN2AH88lmMpITK1roAvddQe+MekATFjOj84B2hNVdVij/irjFTKr2P4pFHm8Uccf/oYW7YdX7fd4oOxBy609F9t/8A/Mgi1QgV3LFXpdAku2um+/2A8QdugcLpSjwb2dUtFWOsA+2sdhzSHcjSYfLb+ITKA76nzMtfGclJWLsTr2GDEr8dOQbqXlGyj3mYKVDKoA2Cg1V52V5O6Iu8qdq636mUIr1FCbwvrrQXAmllVwLNNFx5dX37kwpadLN3Mm+sxN2v0UyLX9x98obyykJzrOQmClsSLxMn/N+W21bXru+taKhbaqKv4pR0X2pJw5Rbb8mVoWAAA+UfxkNXj1zUEofVaSBUGEXwglmGU3qAfsHumXTXOlpsKzm+1I3hAdgwjTGjvqNPQHjTafx30Whk325kUtoB1ClTpOCkuHHD48xod0kq2tGwCULDHBiKkeb/H20upX+e0BeB0v3hWyLTiX2mmjfBJS4Z+KOYE3kPk0Kh4InQbhePjIRsqlLaG6Wv+qP+b24duv1k+DhiN1lruM2T7j4YQaR2rOpSp+ix7MBKXEEk1fral3au9zgL/uodq/mkXp0KstphzZHv0J8Khe+UQePOrsfXIRQdbzc0Bz6SvfgHIMYxDthj+RP7N/gAf0YfS4/DLaqeH33iWStYPmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(921020)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ohAjfmxF7B2UGSgQRWasNS6Dgoy21GJptWC5XF8vILxFnia1Y+sSQbpYO3Z5?=
 =?us-ascii?Q?UamVw2WOHYrYSRND+6bT3LKj/qF7x/dajKaVo1ybRxWZww15Q6IdxPQDxkDL?=
 =?us-ascii?Q?D6uNGDHndjPZM+ERQEjOlDASPSX4FsF56oAgbpcFrgzv+5YieQcIx6i8slNB?=
 =?us-ascii?Q?a9qPasihebxhztSo/8nd1At6P5JJqu2G5w3cbs37iTfI+weHEHYmMNWaCkMy?=
 =?us-ascii?Q?z6fWSuuY0bzhv19xqjo5SF3yGs9MUFhPTe/KP7W/uv8dmbr6tfnJXEY1sra1?=
 =?us-ascii?Q?EdwYglkZQBtZM32Jvmor+qRYP1bPAmP5R3ET5DSAhG6V5uyYGW9hk/a5oIIR?=
 =?us-ascii?Q?jCOd+ljH6XwLkbn80AWY/MuElNgaxNc37Pq6Im2JueInIwsftD0Jj7OKCQGy?=
 =?us-ascii?Q?pD6ZqLhPkf6yET4eh8q77765uCIwcL2NVyjoI5ttpytmEXzvPLH1y6YOMRmh?=
 =?us-ascii?Q?8FDoXMrp8PAYkaZh0YM8gGSfmck2WPeU48LuFZVrNizObk3wN6SK04iRDNyw?=
 =?us-ascii?Q?BwdwGQi3R+Cq9UZ7zMd/XxTGFPKjUvuBiz5ePKK40VVCoQs5oPUgeE3QfUkq?=
 =?us-ascii?Q?304gTWfG4nMFD5/tdx3CmxlYNKDhDuiEr/P6DvnAtPedcHl3pEGgpiOWV/yE?=
 =?us-ascii?Q?85GJwj9llw1oHBGplot+4Zj55LJLPi3Q2d91KdKCPWjpHQOhVXExSQn5s0WJ?=
 =?us-ascii?Q?6CxPUkORC+dM+1jo/41buWEWHjMBOrUBC9qBxr+DkWU9MUZFjh3ReiPqxn6H?=
 =?us-ascii?Q?8ODCjSuq6QYi/Q1EK9zPPdKuuf9Iwg2ptPd9Zk45CvtZ2VAGcGDVLMepMi+p?=
 =?us-ascii?Q?Ny5CzdulwDVFZHmW5AGDqPXCunhNHBBPzTeAxMMpfpzn0xjyPyWz96+61GxG?=
 =?us-ascii?Q?5IvR4vQYLhvjrEOIAoWaWPw2d6Aixn8wiCyqj6wa4ccd2MOVPcm+8vjkTaeN?=
 =?us-ascii?Q?NmcEeWairQXI+IQMJaGWIziRJmnkyFW6OJg+Dx/8NwhApVWTYif+hTqIXfSD?=
 =?us-ascii?Q?OzKbQLblmdwwKOFCdj1IqyCYTQWh+tIGR3rD/it0WHpOXDCmgAXiFAFKSnm6?=
 =?us-ascii?Q?mcGx8HP7qS22y8gZzTH91k56LWTxEIsj53FoBbsH+myk0z39YwxVvVWCNgxS?=
 =?us-ascii?Q?kwglSagc00pR+3vs6e2PWW7eEvBErGpH4qJ5B5TcaCsAgqCT2H070CTxhRx/?=
 =?us-ascii?Q?WvsFnn6p3sSysesFocJC/oMcRr6m6YTw5R/ajzJdKPOZQHC+7jtUz47BanQx?=
 =?us-ascii?Q?8GF8qG32wUQHyZQed4Hp8TXq3kmMFa6Nks+8ByMpApYg2XPJIQgJMAzMNDIh?=
 =?us-ascii?Q?tEGmmjGuUqJu3gbL97Z4VFEIS6O/7KIpy1I5MgXxqSbIDGC6Zpj7RA7vqBd2?=
 =?us-ascii?Q?/F7ltHqP2ZRm9BqqyBffS4Si4iyvLlVrUyHkLgOnXuaT0SB9jcfL0m7cTsuX?=
 =?us-ascii?Q?5KlNlq2PG6y1oZQCaZvJJ+nAPlkbvSzdahqZEidrNQzAh7I7CHZ9TMvUpgXX?=
 =?us-ascii?Q?jWiC88Jb+axgUavYqqCDgek7/aCcUs3fHLj984MBJeCa1EQj7npkvBDM+DCH?=
 =?us-ascii?Q?DImh13whARmmQxRo1D8Z5OeNAPio2SlyZxKXyztwBBwkR0AzH4bfY9BnHAcW?=
 =?us-ascii?Q?lhv6mHWfeRyVHx72ASl5Verm54MSUgHFCLIk+jjB8KaI503OCoE0vMMfyEAJ?=
 =?us-ascii?Q?MqldDhJG/fjpwbo4Z5ex/olQLOPuMZvjfP7B8L5f+H3FSZIKYXXabVMuFd3r?=
 =?us-ascii?Q?awj/lmk9+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qAXuoWcbKDn9UBnnCfCFx6iJdVk5ZJxocBIKXntG2gtg+ZBsDVMJ0gFIOmznaeG8+qstk0HbJoiupwRCq9LnjqGA/j/NkGgMmC03TcoxU26lIPSu0GRi2Yiuc1QaIq27bTjtmczq/iuZFQV9PtneHR/3gh8YX7PVQzBmhMXF30Xc5MQXG/9cwhIcq4OnnoLw1ji9jg19PMBYXqY2zzgZvZFGpV0DKFvGiM+r+O46sCKdAuy8ecNz4P9dgHnPMGgTiNruW8fieFRNII3xM7uEqBco4c7Keok80FKBdzClvsDJK0LhJJ7yE1Kw+8WA5h+YVavf3+dyTULQ4vd/5zSdqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ff5ad1-98dc-46cb-0ab1-08dec089ccb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 09:32:01.0486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0D/ThdQmtIHDH5paV/zeZIsu+kSw+c9yW9F6JgMiTaJGLGeM5q0xe3SY4GckZads/JAllkqywDr0JhB5/eqNekBjPkuyo1iDI8UMfNpuJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 01FA862BA08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294110-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,gmx.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mensi.ch:email,PH0PR11MB5902.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

From: Markus Stockhausen <markus.stockhausen@gmx.de>=20
Sent: Tuesday, June 2, 2026 7:27 AM

>Realtek Otto switches usually make use of multiport PHYs (e.g. 8 port
>1G RTL8218D or 4 port 2.5G RTL8224). The device tree can describe this
>fact via an "ethernet-phy-package" node that resides between the bus
>and the PHY node.
>
>When looking up the device tree bus node via the chain port->phy->parent
>the driver totally ignores the existence of a PHY package. Enhance the
>lookup to take care of this feature.
>
>Signed-off-by: Manuel Stocker <mensi@mensi.ch>
>Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Hi Markus
quite unclear (at least for me) what's Manuel's role on that patch.
If he's a co-author please add proper tag, if you are sending Manuel's
patch on his behalf please change authorship.=20

Code itself looks fine

