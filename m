Return-Path: <netdev+bounces-281003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAcjOeiL62lBNwAAu9opvQ
	(envelope-from <netdev+bounces-281003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:27:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C33460C3C
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C856E3015C9A
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C96E3115AF;
	Fri, 24 Apr 2026 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLTlbT4H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA730B501;
	Fri, 24 Apr 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044454; cv=fail; b=h3yVzuwjC9zbwRSClob6ihET5HuI6OM516MeFuooDwO47oHcG0lRYz+lqLKkN5C6I2mvB3/OgZlVlrX/Ks3Bt0FDD6gaz6Z2cDKDnDy9g87+uC/kL2TR4SWqReR1l1ucbcTd+2Pkw220IiBs77JoQtthvTDNKwst5CTkvhmzC80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044454; c=relaxed/simple;
	bh=CCMRAMP1kT0WFgdThz1c423Hfz7j0wtM//ub26PZAR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p5bjuqmuXbKKmiRwxqqpyCiWa/b/uQHMXGAPQkLzSv5zC2o8c8CyMqZrbTlcoc4jgH01EDFUh63Ct16ULVbtef8XxEicUwnKFf1nVHlwY50sy3tTLhuhH2FY7tnr/324rFaHyNhfUEejar8NBpZ6ujLjrsAOyu649ZTdJsv3EhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLTlbT4H; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777044452; x=1808580452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CCMRAMP1kT0WFgdThz1c423Hfz7j0wtM//ub26PZAR4=;
  b=VLTlbT4Hz7X0cYUQioMAeNWR/0G9P4ZStV8FbuRBbR8d39wRc5W6NSht
   M0x3R9W3Yp6v9FIPJRHm3+mACCwL8h66vYALhDlq3EzxcxOgHCKVTSrne
   jTbyY0GQZSP9rLM6jfNBXtJd1YgOSRoLNeaA3yZ2rmjILiB3/f1Bk4gZ/
   mH3V0W3TCL2M0WQyc2rW+2PEbgpAaNgbEUrpHATxv692IeE7XUT4rnqBM
   ShZ0ESCbOnVxPlbSllUDlayVphXTKBTyUMoCchNwtBqeRMCHvwTn7kloq
   c9P62w4AO/T5aqbKIhKP8KGvIxl4jHCq7LRZOWMT2duA6OZ5ogTU/lXi3
   w==;
X-CSE-ConnectionGUID: 7uPkkOFSQx2WUQ1flTF0HQ==
X-CSE-MsgGUID: 5WnwJ4YxSWKTJ74zv7h8jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="89489480"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="89489480"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:27:32 -0700
X-CSE-ConnectionGUID: LRk1ufgJQlq/Bj4cpeCKKw==
X-CSE-MsgGUID: x7A5Qh8tQSCBvYzJH6+AkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="228404675"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:27:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 08:27:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 08:27:30 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 08:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFsMdhMhCha48+JR7JOMAgNb8qWu0GbqwEivumnsdVutdN8FPWMXEVBL8vjs17gCsP+J1yN5zJSRqk4mN+ltdCtF88AU05qAWqxwLlhcumGMmLxm6PNQ7KV54pSNTDatE42LdDh2sTboKgx6Kmu8ZODe2MiQbF/rF1iGfuY0lWLGILINSJQrAySudF5iz27cIPtVrGCSx1nwHg0zFrEddDX//J8znKIE/8cHTVJb03mQM7LOkScQAWUiEp3SgCym8vO0Dhig8EgVco3DbWeZ2SgrWDTf1CFKSdlVXLboPQpn3FnA451mE/OLcYMe/XY0lx7qzC1eELa/RVv/rWfCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivNp9ZuyQFnvXLV4vMeAlw/7SxUI7JVn9GnJsDcdlR0=;
 b=T5ix7NQTnQhWnTUPzlzV3MqUWVOybExNY71dmftTVrAeXI8+lGcGqtnql9pMekk+kUgDdYlqD8n7Y6yIwhCZG2/QD8K/x4aM4UrZ9+XJIFQIHfxWdiId7lwMpqjuaoN5yyVP2TWwkKWB7Kr/WAkM7e8JWqhQIceqsPNk/lYNujquYljDAk82bEizOPF+V7pg2qE6HdMCWJa/Y2f1M9nXiOGrt82o5TJ2z7pB13LiEHEEyyEk+lbqMrhlLnYMDK/HAp+3vu9TSGy7nWU8mv4sLVRgrilzmjeyoikfTFhvSuPAYROis5kmLR2zZNw3HBdGMU9imhHVeFJD+aHj/WfBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ2PR11MB8540.namprd11.prod.outlook.com (2603:10b6:a03:574::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 15:27:25 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 15:27:24 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Choong, Chwee
 Lin" <chwee.lin.choong@intel.com>, "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>
CC: "faizal.abdul.rahim@linux.intel.com" <faizal.abdul.rahim@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Tan, Khai
 Wen" <khai.wen.tan@intel.com>, "Looi, Hong Aun" <hong.aun.looi@intel.com>,
	"Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 1/1] igc: skip RX timestamp
 header for frame preemption verification
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 1/1] igc: skip RX timestamp
 header for frame preemption verification
Thread-Index: AQHc08OD/II+GdNj/kGx3L2SHzcPQbXuVhrA
Date: Fri, 24 Apr 2026 15:27:24 +0000
Message-ID: <IA3PR11MB898621435FAC13D3B95499D1E52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260424075907.310456-1-khai.wen.tan@linux.intel.com>
In-Reply-To: <20260424075907.310456-1-khai.wen.tan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ2PR11MB8540:EE_
x-ms-office365-filtering-correlation-id: 6709e05b-19f3-4ed4-8ac5-08dea215fc90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: wiHJzpnjbLFkSelixvijfBStDpxMAX1pmGeCwcZxL40+qAdbFDzxHB6OotM0WanNXFZcczhsNVlfDP4SLE6wgXw6wZqz3V0A9CviqgnQ57vsRj608o7k7/+9c/C2Dc079g+cw3LEDedQvtJYFXEYRAd3c3PX2L4N3ELRO/GyYASTR/t09Zvl18pH5pufG9oKGu1GwPnkPxE8zK8UCeIl7OgrjX2SpfpIovijZ/vz9viwG1TWCsi6Xp8AD9hLRvt+PxUBetILZEz0QrBJ+jVQG6F/H5QfOLx7SehThpCUX4fIb1uRgvvyWktBi/CuelAb2l8FnF0zVZ9oiALwVbqbJ+d3vUNgiXhey5Ewq7OAmfG94/ETaStGgS1afTc2uRPIEn4JMiCbZIBTvMUyqeAnKqS6YP0+RyhLYu81XfnjNEVYN4wSf3zJQo+sBRz/LBiXSCvdGtJ3S5HASFefq+YN84DBPURKD0XZv7+wkJDyTC9/N5lMGafVGtIqQI/XGqfazdq8YC9jBQ4SsaiSinslSrd3Qv0GhQZ2RYxp40/R5nRotc0YH4n24epyGBjMGRDCyyAQSs35GkqOcn03FQLSEkqWStqgTHpda/v58Trl0+Zq1NPTTMZennxFt+FTqRHBTmlkrkdjvSYxPHryyRLEuP8djq097zK+wLrFBafIpJuMIA8qcqqIXRzR8kJyWiNCxe7rOvmRb6k4SGSnSwOITi7GMBrd8CwaZDpfA+6wqL9BFx7d7cKTjXk7ZYc3VjqjM0DawvCt4/Wr+33p/18qc4oRLrmWLMUh+tyP6T+VtSv8CFMMwCkHREkhN0LDEy7Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dg8MJJVlUF67wYdmDa15ytzqRvCZvoK6+dFusqGhy6g/sak/s3lLTOCHBqpy?=
 =?us-ascii?Q?lSN7A4dtHJQpHjbZ7Xyu33DbG3I7pIfFVTEBDnBzuwSqu7ebbLMWUFbcBgD9?=
 =?us-ascii?Q?4hweATeAD3L78O5Fh99uckIZpCg33+DyZYUyVA1XC6GGmTkivADzZ9tzUu7g?=
 =?us-ascii?Q?V9QCLUOqHmqS/rR6Ia8E61/lKvl341DtA/TRSpKOBvI6y5D1bnjtHPttSut8?=
 =?us-ascii?Q?LnNTFoo4FtyRnwX4AkaTjp/zaz08PaKPQh5I4Bh5NTCyCfAJzPeKbbcI3KgQ?=
 =?us-ascii?Q?oRcJ8QNnccx4XQU2hs10g3B4kOrcPtliKa7SeA2kXxTNTNcNE0Eo2+ucDNAa?=
 =?us-ascii?Q?vDTQTnl+i7GbsaU2ySW0LpFXBBBfbALWLoYQqUBPLi3nw5e9mGhutQ4U9H+O?=
 =?us-ascii?Q?vPJe7mmgCNmhDMTyNuD2OsksJ48utVuCeDEmRlQ6yVbwPuB8dh/oGyyros3V?=
 =?us-ascii?Q?9x4HxwJ1XGjBZobOs68wiwQyhKUDApbmTFCeQhZ69DqP5a9nTnaKo0zM8kXs?=
 =?us-ascii?Q?X5J1W1/Xpfl9+th1zHLpznQorpeixaPp5u4gb4eGYfIWJDsBufWjwYuUl7xC?=
 =?us-ascii?Q?e7BkSHuf1hzes2eZBzcNEqC/Br9RQLxL6uOrtt1gJG3cfoRfMYB0bH1PMFFG?=
 =?us-ascii?Q?k6eU3N9i6mM+/wEW8Gq6sj9GbSu99q4IdoraXm0jgvWMjxicmWo8Jtbh56XG?=
 =?us-ascii?Q?4NcZFPmaeKDORpf1JKC/Yh6upaAU6tuJnuFesYyjxkxjUpkTRrrGGyYxVBKJ?=
 =?us-ascii?Q?UHr0o79EAQyD3h8BGQJbge9WyH/ij64pivDJtNLumGXauBShkbh76pCyqNhO?=
 =?us-ascii?Q?+yL0RSguGO7VApY5Q9GNVV17gEB/i1NNEp8jVnCIuXdEbBuhc0PnRMMpV3m7?=
 =?us-ascii?Q?Az8vWyIG1C4ooadaHXR1UxQMZ69mYgfUjwG0sKC1jib4Jyf0iPQuvakwLvxK?=
 =?us-ascii?Q?1WdCzRA5sYXcLFADPo+aEU2ajJB6NiGvhsEHjYluYdyE6gsXh+1xltwyKGL2?=
 =?us-ascii?Q?NzBxGVFcwCUGidwL+6B8ePUGItGlMN3o2r7zCTCkxyRE1VHvo1mM2yKRmXfx?=
 =?us-ascii?Q?iPbef15Gz+FxrfgE/+38D3Zm1xSYsClD69786T/M0XkybL0vXp+I4VQ45WeF?=
 =?us-ascii?Q?/5JL9iNr/EiQTsl0F+SksHagqsliLXeAwbfwz8aJ6haKmS313E/RAAlw8nrB?=
 =?us-ascii?Q?5fWr1hP4i6GJvy4zR5xzB7GgKRBetIIoV567WqWD6xYZ+3nSnQFBaHQsPBks?=
 =?us-ascii?Q?XgsjnmRbsha9jo/QpCh0ia00GFDoAFggc51KOEBhhR1ETozQ9wAgYImZX82p?=
 =?us-ascii?Q?K6HLZRpr6QACSGawed61/j9E1jLoNXrkOl6u19hMW3uj/pcF1zIicRHYTQPA?=
 =?us-ascii?Q?du+CxCxmSngTF2NTTy+Uo45WvdIYkxibw0xNBEIA9o5foxTO1YGI6zFfEHVq?=
 =?us-ascii?Q?5VP6extNGEOzSZmJqNuWIe+ISqgoEgay3p/CNYWhpd+VMw2xkyPRgQk2EOdn?=
 =?us-ascii?Q?glwDhsG5vOvO2EPf91YWD08uqwKM+IXx2IYOSVQZHutxDht49DXCiJbX2LHf?=
 =?us-ascii?Q?VQmLWd2xEtLoQhsWq2ynkHMIoyKwFvMqloF3QAtSJBeof5Tnw4MM0sihuVTP?=
 =?us-ascii?Q?lKcxo/5N0xkA0X8yTVbzabLIkZQDybb9lhp/hqxHJLisI642aPvxBbylbGlz?=
 =?us-ascii?Q?o5T4pwsxLJMBAm+/gW80OaCBg7951SmiK98qBsbPvLbM2JxFJGev4POwrcBT?=
 =?us-ascii?Q?AH0zO4iiVjcmCBhpoDLwOOh4Nw54GR4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AIVFwjmnkTZ9hKapP5qb9zszO6oNpvkV/bqEL+O+TPwCDQYxgln9luxPFXznIIiA4MF5GiOUixESmCQvtQ4ibgEgs0sGOzP7UlJ4XJninBWjQvA6bKPvyYgl1lvYCuytGS+r+zo4B5syDAMrizPZqd+lUvJvBWBA8Wuc34Sr1xeapEgJotzBK+3hlOYPSlZlolI7wKK8XZYu2oJkWa6mnXmYA1kBEMx2IwS/ySsrAgsWWZRG9sSQL+o+LKGDj/o0DC++/w5Nu6ckY6phXEtB4yFohvH3xRIly/bdGrWFFrzzHrYZWdJtEodRtEbJrGjG/IHU5p0VVTtQSZqmLFokmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6709e05b-19f3-4ed4-8ac5-08dea215fc90
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 15:27:24.7590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EG27i0iXA0mjzI60YcFMgvI1qC+QsN3nZZHhDWjLguuZraVwJ3URuJcin9t3iVWK9XNrV8/2EzieOA8swjaq1bnB7bXthmdBdSYZ4B/gMCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8540
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 16C33460C3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281003-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of KhaiWenTan
> Sent: Friday, April 24, 2026 9:59 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Choong, Chwee Lin <chwee.lin.choong@intel.com>;
> vladimir.oltean@nxp.com; Gomes, Vinicius <vinicius.gomes@intel.com>
> Cc: faizal.abdul.rahim@linux.intel.com; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Tan, Khai Wen <khai.wen.tan@intel.com>; Looi,
> Hong Aun <hong.aun.looi@intel.com>; Abdul Rahim, Faizal
> <faizal.abdul.rahim@intel.com>; KhaiWenTan
> <khai.wen.tan@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 1/1] igc: skip RX timestamp
> header for frame preemption verification
>=20
> When RX hardware timestamping is enabled, a 16-byte inline timestamp
> header is added to the start of the packet buffer, causing FPE
> handshake verification to fail.
>=20
> Because an incorrect packet buffer is passed to
> igc_fpe_handle_mpacket(), the mem_is_zero() check inspects the
> timestamp metadata instead of the actual mPacket payload. As a result,
> valid Verify/Response mPackets can be missed when inline RX timestamps
> are present.
>=20
> Pass pktbuf + pkt_offset to igc_fpe_handle_mpacket() so it inspects
> the actual mPacket payload instead of the timestamp header.
>=20
> Fixes: 5422570c0010 ("igc: add support for frame preemption
> verification")
> Co-developed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 8ac16808023c..c470d2354ce8 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2649,7 +2649,7 @@ static int igc_clean_rx_irq(struct igc_q_vector
> *q_vector, const int budget)
>  		}
>=20
>  		if (igc_fpe_is_pmac_enabled(adapter) &&
> -		    igc_fpe_handle_mpacket(adapter, rx_desc, size,
> pktbuf)) {
> +		    igc_fpe_handle_mpacket(adapter, rx_desc, size,
> pktbuf +
> +pkt_offset)) {
>  			/* Advance the ring next-to-clean */
>  			igc_is_non_eop(rx_ring, rx_desc);
>  			cleaned_count++;
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

