Return-Path: <netdev+bounces-208913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B09B0D8F3
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69085188C71A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BCA24467B;
	Tue, 22 Jul 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNBuyfZ8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF51E32D3
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186021; cv=fail; b=OolZbEny1K/a1Oa5PgknMjOtUGfPCFaHQK/oDWhtnFaUUxX0goz74vGJW0YB7257VywhWgdHn63LxG9RvVMpVtWjCJYQQlz9wYXO4S4nr6fHPGrqpNeU5AQ9lyrPQrOds7T2eZzZ08Zd4Wt3t+Lisi1T4R65VMylJstYmwEjCc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186021; c=relaxed/simple;
	bh=JyUKuo+rgeG7CPLJzQbGuxxTcu51yPoCs5lWjmPRB3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d2y+OYApbYBj6TdwyWnLL0I49ih7wBbJngDf7VFO+FoG+EYRszLSpzBqsEFZQeTc1LJXIBonkXt0JemJwFQ1OI3wqC5aKCGUGHXRKlcqWzmX28ZCZKif1WM6H0a/J1dPpR/sECZooJNJ181+JVK2Qi5iIcGlDdl2ha/xGTaIbIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNBuyfZ8; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753186021; x=1784722021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JyUKuo+rgeG7CPLJzQbGuxxTcu51yPoCs5lWjmPRB3I=;
  b=UNBuyfZ83MFycBvgYvw2rwko1HdOwV0cSozcvJvsVJegn0ww69Ad944Y
   jJ4YT8A04hgp1AFul5REmqjdmIcsOcRx5JPYPojockxekd4rixaolZgAz
   eDo2QB/D8BX+qhc9Q12zar3q98VCHXoIZMwovNRuGOYlGCfxjvTsyq/uR
   nrttQ/Jbr4au0cCUbfssgxhIuuw3ByPa1x2ms1QGYWdhpDiLA6a0F3l74
   BB19H50aaWwxIlk1hhp7wkAzNvpaHeu4JYq1yUhdxy/ytn7/SMimVLPp/
   pAaldgvUOU31RD9EOVGSjxCfyb+D++9fBiM15n54WL/iAoHVa3y8HIGXE
   g==;
X-CSE-ConnectionGUID: EpA8+L5JQpWwvnQu80KW8A==
X-CSE-MsgGUID: AltQJU3aRiWaXMThMV2r7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55581216"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55581216"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 05:06:59 -0700
X-CSE-ConnectionGUID: xgcfb6tqTyaKhIGYNek6cA==
X-CSE-MsgGUID: BGKZNfCKRhCOsM97ZnMhrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="159851948"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 05:06:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 05:06:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 05:06:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.71)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 05:06:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4H6B/n7lolpPaccN3qYY16ofngT3jXgypP/mdGYdiKXHQrBCr72YnuHLVxTmTWZ4YoFFKa+VFqpCC8RAtzRzBid10wxjwe2peHyYb2kbj7ugOxTyeuwFOCYnWR1ZBUBFdyxZ2HSYkVNdvQ5782oRCUMEOzglucmKdfiIYAgAqgApZ+3B67gYbcwvlvm4r/V56DdyMYjr6csld2pJ48uzrN2i9/k8iXt4+P/G/rTRnbtc54vZMlgchzTklgRSzZLIAeWcsq8wXrucIkMEbQKfTRvtsXvQ/GWl6I2a+Q5TIv/gSGoWyMnsSdRyWFciRz/aKEX3ArMP5uyjxC40cr92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyUKuo+rgeG7CPLJzQbGuxxTcu51yPoCs5lWjmPRB3I=;
 b=tcBW7uT1U67mv8qf2wnHNupwFl9fmLzfvjmINZCqPoMm1aMF4/+ecHe2TBaJLfjF0peho10UwEMZNega20ZODAbRBGSeMHzGd/PwW5Ta1hJA++r5SLprz3uLmCT3/HMg5dPLQzmnErHhOWRKQe7Oq5Kx+M+ddtLzU/UNBgdTXAj4Es3Ezu+r8owG58iwzBuxdUzF3gH/Trc1igrwb97LfCkJ1F+7CMpH2OikmT5jJAHGilz883MkJhNJCr/ueyusbX17IDM6k4tzf5a72qh8hA4KnT4k6ttUxEHXmmFnBZLgihMLtBEzEsURZedym6NwxsThhGYz1AzLz4mEc/jAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 12:06:56 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.8922.037; Tue, 22 Jul 2025
 12:06:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "dawid.osuchowski@linux.intel.com"
	<dawid.osuchowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 03/15] ice: drop
 ice_pf_fwlog_update_module()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 03/15] ice: drop
 ice_pf_fwlog_update_module()
Thread-Index: AQHb+vjO3nBdSJ2qEkmPDFuTaBIHDLQ+DC0A
Date: Tue, 22 Jul 2025 12:06:55 +0000
Message-ID: <IA3PR11MB8986F5ECA39B7F65A44321E2E55CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
 <20250722104600.10141-4-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20250722104600.10141-4-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB7869:EE_
x-ms-office365-filtering-correlation-id: 6466144a-4ff4-4a8c-86ad-08ddc91840c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RDrrLux64bSOhkz9xtNEK71qlGPaeum4S2JjaXgvFoiVG3b4Atci4L4ekeQf?=
 =?us-ascii?Q?1pb/Yfz+x1d1q+iZRk1Arx5DMv+D20n9sVh5qKEYCXRBSorHsiT6sh3lF3Z2?=
 =?us-ascii?Q?7WSPEUXYCo33RXr3ZWuKouwMPiobuQt1VpSscjKeNEine24Qg2R5J3W8BeN4?=
 =?us-ascii?Q?3k6L2mJF+3k+mmfY8VMpSAK2QG9Fov/8vN5IxagZhyvvcBdWaqKQsNp871hG?=
 =?us-ascii?Q?KKior0iypK34y8bFoK35cZhzgE/OtEw0Oa34XtBdRw/LhSpZHHLV5uJOth2J?=
 =?us-ascii?Q?z08DlGyT1zYxpXIoel8FTMtbXm/WUpb+Xnfg3lZgk4bVa7/UNDHKBcE/7oL4?=
 =?us-ascii?Q?TYoDuPL9u2/tppYw4BXsHj23ShU9DsI3d5no/2NZvp6tbYDCG0uPmEeBEUZT?=
 =?us-ascii?Q?ToOoXZ1Ig96qPr0TnEObhZFTV++pC/yvJq96NBoZthEp1g5Yw3BBjpi4GqZx?=
 =?us-ascii?Q?5nXcPdtA46i6F59ngsEhQyrY5oFFBdGG2vLNwrcuD1pPLBa1w2cQMYHppAsW?=
 =?us-ascii?Q?ss6UWqeFH4xxaB13TC3Alw0c8f+vYakdwj7ViTLCb8pC4jSWM7ObvZEdWj+K?=
 =?us-ascii?Q?92kCJhpg28OaFlMSpJJ4NtyuKiltA7uSqhrxppDT61j+FLwB0pK9t0VBYtmY?=
 =?us-ascii?Q?Lf1q9z1XifZnSGQd0C6U9DZSLx3s+h4tRFT6bzEHO335kdEw1om1wZgRmU+X?=
 =?us-ascii?Q?Rb4yxIFcbLbPtIIc2wCwHGIsyV+/TteYYFYxDnt1cAAJqIBrwrVz2rx13XTH?=
 =?us-ascii?Q?3ojkhsQe1XvDUbP6ZnCL/jZlmO7E47p/WsLo9OUEk2Fgqi8HDXytNL8p+7bV?=
 =?us-ascii?Q?5gksxzWbcSiC1eQQFuAFZSrZ6Sa1ho8BB0Pha8sytUv0jwWeS0GnRwRLkinz?=
 =?us-ascii?Q?S+IwwZ6YQzDTbAL74YAnwNcTZVFvoj6lBV6Ow1rtPb5q2EGpWX3FMBPgogd3?=
 =?us-ascii?Q?iBZJy3gIc+tATwOcisYSeAoMkMTp+3oG/V1FK3uSqC/Pmb1kuz5VoB31RqQ8?=
 =?us-ascii?Q?jKm355XQFZhF7+U2umVD3Le8A1lDKWURbjjIPvv3gdl5yZcs5su2pdOjc6wf?=
 =?us-ascii?Q?oM6c2Curby6+5CzaMBUv4uWu4b0I5NGY3+RK5HcqMvJmvCKu2zY9/wu7JV7H?=
 =?us-ascii?Q?METC4Zt7NDrRWD7nJr3XAWnCOanlvq/5qngB7Kc8VwQUdzQJQQgQuHH8Ksjb?=
 =?us-ascii?Q?2+GbX5Dtay2fRtfVH1TMZ8T3GxnJIm+9yUcyy/87il5UMA4d3awHvDaN5gb1?=
 =?us-ascii?Q?pBNJwfeLw9o3GwhMk1BNGGzsYj45lsqVbNcigBOMslHVg2m6LwI/wiz9MOPP?=
 =?us-ascii?Q?9pwoilr1+97VDOmUv6ZBQ2pi/262Gui9qRUWw0OuFQT63XF2gfwwCS47hy6W?=
 =?us-ascii?Q?CmsbNbMOSIec4GvnGoRZ+yV2Uyd++skTlHYYx4V9GLa5wrgv6CqgjWkSTyTX?=
 =?us-ascii?Q?Io99wWJUADk+koZCY/eh4JT6gWOJFUOB+Blap5Ea6GjlEJJdmOB3Fg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XlZ8sMSUqZmyezAKCzgh2fNTTWLELyPmWWpG7wBWsAcUr6i1iZALpxvFkwdK?=
 =?us-ascii?Q?t1cExTxookNVrB5+PZkz6PWSR5lsPgzoWsdq6Uk/2/TtPZU5Eh5TznN4BbUe?=
 =?us-ascii?Q?xaenaaABhPFXpNOzQSKa1v1QN30NOd7a32MTWnAj/1u9rGttLXV1fQ1K5itK?=
 =?us-ascii?Q?X4fMClvcOrbOdNwaDsQ7gPbHEjetm2o9ux2rDrFuNBvcqGEESev+FWAVIqds?=
 =?us-ascii?Q?abaCOywDPkxQkbGm4qb+Pgu9Ej+DVbJD7RgIz4Dune4stHpWs016TVv9vsfO?=
 =?us-ascii?Q?3xgbFBVVv7fYyoZ0DoRzTMCDs9D1Uum0PHif1KaqC3ArW4rRAnZoEZgI/has?=
 =?us-ascii?Q?kB4XV8Si7R+XyZjEmIhMLjB7GkXREUZoVDjtB6zHlaVsRB3XyBtdxrm3WzYZ?=
 =?us-ascii?Q?eD0MFWwmwuijY2AovZY+AgiHTYwZuYFd+8eHYxpRrH3wePINqV5i8sX6O9bY?=
 =?us-ascii?Q?XQZAhsI3Lo82Y3JzGX5KhL7yRDdr8lx1RhFokTFvN4ZfT9l8KzrHuc0UCgIK?=
 =?us-ascii?Q?D+naqt1EL0x4aEvxLXA350E9seB/pooEr2DZWncuxpW1++feZiA/u2bGsUCY?=
 =?us-ascii?Q?ctlfbWWuCHIUUO3Go7v6cc+fBXwIup6JLDLaHRnA0ZItMAzLhqaa1l502UPn?=
 =?us-ascii?Q?luKTn4nLFGxBa6pnhg34BIspYfkVIBav/ed4qlwIqf3z+/7hAYjRcjVtiG66?=
 =?us-ascii?Q?/jPf5f2Tvc9NsKL62BVddGalMqIjPT3xBNyWorht+Gxu9CUr7dOIddTTykbQ?=
 =?us-ascii?Q?+qSX5crbqhRq/yHPz4lWTbNXNnwXckG7YjzUdXrZbei6E4zrD3jNYLhNfmLj?=
 =?us-ascii?Q?7wZQz0qwMZtupVQNwSF3ypWNc2nczEaCsLdFXBSl3i0OZrf+dIthWaaj7UIB?=
 =?us-ascii?Q?MBC6N6IPobQq6GXBT/+O29Smj2KZiM6ujNx4kkUJmgjxPWk2pm1S0y1aYwux?=
 =?us-ascii?Q?yR7L3v/xJEASBaOwR099pHWBIF3zYyzl8r6YoHViu8FRMdMP2J9RPe2rYNeu?=
 =?us-ascii?Q?0FnFOp0uG5/sfsJd6GJCjaPoxf4XyG2kuUDiJkZfqxuiveHwW5tR+GsHU7rA?=
 =?us-ascii?Q?17wIllpr11l3aj0YYUuU62v0CSwYzecvsmuhLL1edmiJjRM0JbVPotKcANU9?=
 =?us-ascii?Q?YOydc5BmwwOXpagj6iv0opwc7wv+GlKBY5+1au0jCcz8MlyFAxGrgUTYgcxX?=
 =?us-ascii?Q?KP43LJR+HsPbCVtlX4tjCAxl/hPy2008QdZyFSYK2MYN4rsrOFjhEswY55KX?=
 =?us-ascii?Q?DNoOhtIr1F3czXzxfE7cO1yDavEfosXA2XADgKy8SWrQa9oR3tU4WIAHQfdR?=
 =?us-ascii?Q?X8iJr5u1PcN3CSLyynDTbnnnTjvdsUXIqF4s+eqa7kWuaqafqjyGzZHJED8I?=
 =?us-ascii?Q?6ZGosfaVGDNHew919nk4TnxNXTM4OcZdEpw28EZUYXWqLNI4S8xsp2y15cQq?=
 =?us-ascii?Q?XnraxE77A5JZzQzpEnma9sfg7V5JDlQQjTI0/SQ5iBl0Ou4T8SQUHwKy1TCD?=
 =?us-ascii?Q?ZG684tTr7Mo2S1PFv7uxCLMdmZcYZNmV4jy5cc4eJzqEQpti234S5xe1t6TS?=
 =?us-ascii?Q?YGsE2FkmvxpbPl1ov+u5gWiXUEdNsgtrwrfZZuP/pNW9hcum3DVtoymdURIj?=
 =?us-ascii?Q?sA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6466144a-4ff4-4a8c-86ad-08ddc91840c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 12:06:55.8971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8bNV4yC7z6iR9K28YS1nNQ4I1PU8ycjU383MJsm4k1cSrVYtC0lS8+4siWjHbyNtE/1oS5ow5sYIHQzjMp0d/xlGx8wkcwJ4Mc6kgjW6J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7869
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Michal Swiatkowski
> Sent: Tuesday, July 22, 2025 12:46 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; dawid.osuchowski@linux.intel.com;
> Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Zaremba,
> Larysa <larysa.zaremba@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 03/15] ice: drop
> ice_pf_fwlog_update_module()
>=20
> Any other access to fwlog_cfg isn't done through a function. Follow
> scheme that is used to access other fwlog_cfg elements from debugfs
> and write to the log_level directly.
>=20
> ice_pf_fwlog_update_module() is called only twice (from one function).
> Remove it.
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

