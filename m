Return-Path: <netdev+bounces-198260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CD8ADBB77
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685903B6DE0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376021DF759;
	Mon, 16 Jun 2025 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtRBaiat"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6751C54AF
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750106832; cv=fail; b=o43GA/ElXlbxO4nuGXEgrJKIimG7E8q1HIPnEu6Q+BFzRTizWIZCfZSFvNn33DlGPDR81XIkB47tw2T/UmDptGeQoHpbERHaee1TYX0TfeNVUtR7rkzgu2fEHQ7p/gObC0W2xLhsxECQD1QiCVM6GVKUdmRJ+lvaT7lb/LE8oEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750106832; c=relaxed/simple;
	bh=kUgcPAJJQhh9lJkUvKTiMgZQQbN7aacftNhcO2QesGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s8Xi16TTOFgfGnChR8AMm2dHyT0YlnIR208L8Jzs3uHvKOs/sl7IrvX/ahyVUDvsRTm5NvaleF3zzKgoKR8OLbG9ztFFbzUXoLnfYtLj4OXPOxicI3MHttP8MVaD0GVL3PK4W22CUlEOi1EA6KzCYvhiV2D1pBOYahmKLWKwriY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtRBaiat; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750106830; x=1781642830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kUgcPAJJQhh9lJkUvKTiMgZQQbN7aacftNhcO2QesGI=;
  b=AtRBaiatjHAvsiDg7Gp6YmgB18H+oroRDIytdVUmxHNSzOo+QwSBjO6P
   BujfDkKy9RLErWtqNK/ySsmKpSmBLhK2j+sN6/KLtrPHIRvZdkxX1qdYa
   y9/pq29Ss+7pzkHKZoW9bZxDXyl/VVnBA0smVP2TGTD+MyAccS8g68LuG
   yPrZo0RvhpQ8RGdd9HNGZ+keBjW9svUX4+6Tn1brGXWsGLOCvBEAFE50Z
   btoPzoMy1tKV48C/wSNDYnN9xO5Q7r4bW6uM6Jy20blOWD7na9Iqj5kZe
   sGpUOgbj7FTPCv0VcGbSBvsupB3VwkcPet+ohSTgc5lgGRLS5QfCkROs2
   w==;
X-CSE-ConnectionGUID: TTTM+QjQSua1QyF1lUvOYQ==
X-CSE-MsgGUID: 7adzuMaiTO2PfjNorTpcCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51373269"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="51373269"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 13:47:09 -0700
X-CSE-ConnectionGUID: ysTwWyBzQdmSUo1ORL5SYw==
X-CSE-MsgGUID: YrZC4ivbS36kjjhBVqnxFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="149467429"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 13:47:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 13:47:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 13:47:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 13:47:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KV+gFxrsK+oyvzsVTP8LoRw1hrYJOun5fDStrmwYWZ1Nu/uVu0QUXhXL8k8yPcdMQy1Q1CdvrCznu/C2zoIsxKLBq6P7fyWAAUeKCWxHAznTGnlx+/cSfbtr2pUY95b11OWf8lJbR0GNezUn/sjGF85bxJ50vaolPy18NsoHTq48rIivJVWjw8EmvVa0jnNFU7PH7c638dKu0a553+JeEbv3YPu3li+MRrV3+myB+yWMxTZTGCcwYZjMBYlFLxn1VUrVNfvB1BFNzscoNS8iuEjRuimpMdmpkXI7x2/kl5FghuvwiMuNUYf4x5mPD6W3H62tuz6Ofwk1z6/OINwA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq41bPRBgzqZND6AF+kXeRT0YSKQm8ItLDRAnAAmii8=;
 b=o7Tenkffc6Y4GP5xwja7BoB/iAqaDXvdr7UT3G9sPpX3kDU1wDOiGNPvtPNz4s1/h9pJvx7Bb3RontHEwyX6Fo718FDVj1YFONMlKfJ0wqFSgmBIJ59PXSlcqikdpVjItJrY7ilmHaZ29Frg4/59EnJWF1Y3etCKx+/OgjpAHZBxmI2oZpQjHRdgHUWo2+0ZF49H8nnYPrS+qUQhvLBj8GrElrZVuLTYPPwAFYv0z3TNZsC5BdIQIaaUQPeO5aH70morKM+Fz5I/xU/tCeea8suyoDKAuXAwZJT8r+52DnHXh2a+1wTtDoV6N8lHWCyoCxIHdskVjGK4LO/eCTuGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7084.namprd11.prod.outlook.com (2603:10b6:930:50::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.24; Mon, 16 Jun
 2025 20:47:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 20:47:05 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "lee@trager.us" <lee@trager.us>, Alexander Duyck
	<alexanderduyck@fb.com>
Subject: RE: [PATCH net] eth: fbnic: avoid double free when failing to DMA-map
 FW msg
Thread-Topic: [PATCH net] eth: fbnic: avoid double free when failing to
 DMA-map FW msg
Thread-Index: AQHb3vihPXDJ/OT1gUKGCUst7//DfbQGQWiw
Date: Mon, 16 Jun 2025 20:47:04 +0000
Message-ID: <CO1PR11MB50898CF7932A9260C9FE3008D670A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250616195510.225819-1-kuba@kernel.org>
In-Reply-To: <20250616195510.225819-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CY8PR11MB7084:EE_
x-ms-office365-filtering-correlation-id: 3b17d7ce-92c3-41cf-12bc-08ddad16f3f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GvomZx2zBz2OYpKfobgwmrlv19TS2CzE3rGpAyO/2Ujjzp2J6uxIdmqn0aQK?=
 =?us-ascii?Q?AN4JdVGPH42C25StzDf5YZhF6N5PDUdFZ/2oE+Zlh4W7S5CEjmYsxo3pfgQd?=
 =?us-ascii?Q?UZpkQRnEFyK/qF+NfFeReWHS+TTyq+cQzx0ULvhatFL7FZ5hsfvv+oA3mbMx?=
 =?us-ascii?Q?jz3rEhnWJsIspkbq0SjzkQ0q1+TfOFKNN9bplusxzZ8BIokRxCAriHxgmQFe?=
 =?us-ascii?Q?tNOeLYxSkK0BpEP9X07Rr1BXiD+A9IfDGvdjBaauy5tEdO6VFbA/2w0MAhrQ?=
 =?us-ascii?Q?p6L3u7x3N/cp1ymuPBHHQ0Pao3x8WTDtPnWn7ZRfiDHbrLek9+EoOjZEp/J2?=
 =?us-ascii?Q?6hZRwNjnOQCSfWi1HyzR94ptGXCM7zF6Bxq+XJlj9PvA7TN500VAvdrdCicQ?=
 =?us-ascii?Q?QtGovM+W+9Die/Uo4+z8zSSdxmceUtQ2zE8lQndDmXQ068z341F7z35eDjOq?=
 =?us-ascii?Q?tFJnmvsb6PJwHBK3tmk1Bh+Em+aqUgECuLpK6pODGaS6GlHkndjl9YETUSdw?=
 =?us-ascii?Q?CjRzFiqLji69dlSS5rrMIgZSiIA+SONWIS8NI9QkUtx8B7+N72QzKimYj5c4?=
 =?us-ascii?Q?1ZP642tk2cEbGXsHzSQZ8epfymjDs02PaJlTmfSCkbU2azCSoKIR5bRikIGg?=
 =?us-ascii?Q?dfBLfmgCn1P8Uxt8gJ/N7aIvKqyMEBtfLmW5kg+TuN212G3R1+5J+Xc+A7MO?=
 =?us-ascii?Q?IfpyP3YdJdJWrGj7rlxTsyh2wIUScnwYh6B4GA+Qhj7+2HnT2xpkYWYvr9ex?=
 =?us-ascii?Q?ZNFqOfXWr92YtLhkzZH/Jj3H0wmlzsuTrBCvEzPkjZqHQCjCSkzd+hPYBpdQ?=
 =?us-ascii?Q?XFUKCDjEgX/TLyUBwyNKn3nPX4H3O7V1kKpAzVUHnOvboSPSoWUOH53EQNKd?=
 =?us-ascii?Q?cnJ/2WB79ldQDdJV6sURssqmCoeSJzM0tRHiOUZCnPBPr98S9iVPOII+FVvB?=
 =?us-ascii?Q?BzUPZuCjzsNkv9n8ZLkXL+jDpaMOEBTI4jXVPFwTJ3Qg0HXCpNguEwTJ1EJ2?=
 =?us-ascii?Q?EAtL0GSuzmwQ2N1hs4Gl6EvdIhlShRpY+zWK8repO6+X35gVN5nZA8S3Wapu?=
 =?us-ascii?Q?1rmn91eMceZuEiqoG7D+16tuN7uWTj02iFJxMNxNoa0CpMgqQ51hGafMJkz3?=
 =?us-ascii?Q?eujN+vSHgvljiMVLMaCyJ1D6s4bJRmoN7o7k0T/5O8T62uxCUzfowWalcD2+?=
 =?us-ascii?Q?HSLr4FoK6mPSWtSdSgSTPB6LHkdbsCd/AZ/JoeMHvwQ+yZW5CmWxxHq3H72o?=
 =?us-ascii?Q?5SYT42IJ3LCWKtt8oSHbVbGMSxeCQBvsdb7D0zm4uv6Wzv0+cI4CmmgM74he?=
 =?us-ascii?Q?Wd4gj8OVB0EYlhLhiu9bDqIAIoWYRRVLtW3SUOXqjktnUQeASfcpZ2oYpLbN?=
 =?us-ascii?Q?WzpcQ4MLgMLxM7OSPr/TiuAB2zr4jUgARVqRBf49Uz1MBugkpcGqod9igf3o?=
 =?us-ascii?Q?kIkjKesu4aeE5JfHQpDdhdNutSdgIyZENHnwGKp1Du9EsiaNEwIhxg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FEKGQ9k1nm7WSKDBUXZe1AqvbB9nLFwFbgCN1s8lLvqSsc+CuYUZNhXbacGi?=
 =?us-ascii?Q?dRoTpCX/nIzhacG4/PTwfUkcqNNV4acpcHaVkXkFeZv3oUTO4bOZnDeEEaik?=
 =?us-ascii?Q?d+Go5Yxez+HYluGMVk9pDSAQKrNDkAz2ivMHnivTqzQrUUcnaEQE3Wz1T0L7?=
 =?us-ascii?Q?N/I7w/WuUKjxPKN+puXNoMetF0/AFzsnfjfmLRH4X/WNOv3aIJefZ2VKI0s1?=
 =?us-ascii?Q?3eQWfQwMjJtxTDqU0yPiI0eQbI/4zAj2uQtksRK4RR/kb24VNoowojfd2b7N?=
 =?us-ascii?Q?TNDl6bA+GUtcKlwzIWb05w6Rl7Ojs59JWTiZwPpNUx6PZIFia6Mv5blI5ywS?=
 =?us-ascii?Q?p7iSQdT+UfO97YSGzBk0x+sUCwYE/xPO9ke4DQSbhWiEtWRmepvz2gRR70ob?=
 =?us-ascii?Q?7ZF6cvS99GaFPXI2BtGRcFoTNgHAp2LfQNfHq03fdeMxrBiAHvuinr8ViXdl?=
 =?us-ascii?Q?tRlyu/oH8YSZXpVphFyGZ2Tl1NU6tilGITqOeFW7FpHXytVHvzQWDP/bCCCe?=
 =?us-ascii?Q?CY7MM2+aVN5/qs1mrPgES4Hlklzm4MpVdSMauKv6epm0FVzAnv3wGfep5sDn?=
 =?us-ascii?Q?pSJ5ewJnPRnqRnf4OoIj+PpITB6Z6T5SJ9rZeu4xNzuJBIfJqXE6OeVqQW6u?=
 =?us-ascii?Q?xBJeFtqDaP9cirH3Yqe/R15WwWF/nCP7WtwV3HUN3uDeBuNLc/d5y0+AEfkf?=
 =?us-ascii?Q?PKnu8ptVkD87x3BHDf8L984F+jGICCG0JflSvcGzXt/BmlDA8X3zKLX3SvGz?=
 =?us-ascii?Q?WxHkJtykf3gaJPcPCKI9cpaWmi/9MprXS0Ug3Dq4586WZbxjTOKrG/AEETIp?=
 =?us-ascii?Q?4oYNuy7+G7KKCsTMM6PLHH+02NZ0bziykONNZPnLR0U49cUN2rQmwkFg9WdC?=
 =?us-ascii?Q?rKeJSQSIgnEk2RyCZd8RniIfeOJsQdKHdAYSk7TuS/HPiLLlSnPYVO3oqs1n?=
 =?us-ascii?Q?j2UFLJGFw4eaDpDfBAiFBzegY7yV4cTYO8Oc0ifalt09jJb6fzmcA9KJccLQ?=
 =?us-ascii?Q?iKNPlHDrJfmlMZXWwvYVkz5N+k4mvUGQ9zBFt+CxddTBuju7HbcTgTk3rLsu?=
 =?us-ascii?Q?ey4NGQk7GvGddMyiULJE24JRMpEbZYzoC7YiNHGy8im3VtmjyA6SuzR8/LaR?=
 =?us-ascii?Q?Gvyam+HNSZRIsZNX32d4JTy4DOHIdCniE1/7yBX5OAzpK0Tr8zwkaEdX2UXd?=
 =?us-ascii?Q?5cgsJHF9QK0s1h89WaL1soyS9kRdXYpaySf20ERc9fxgsyDcAmEN0B/anbi2?=
 =?us-ascii?Q?g4t7gvH3wKQ6PqTmoP8X7MM+pmxdHKiJujl53L5wCyYsiD6fgGYfKyPMlhqt?=
 =?us-ascii?Q?eJuMMwuI3PsR9Rt8tWQ17R66AAiUvOSIVRAy/nQ7y3NM8DQs4cO9nRhI155Y?=
 =?us-ascii?Q?fkmjaJ1iabKUVY43DsyV2p/XKe+fgoE3XYSOIm8d+4uOCUlZ1AKio2fxLeXY?=
 =?us-ascii?Q?wRrGQVjH9mGGjl+m/plkkzUPGiz7JE3+jzLuZj5N60/cTy7bQzt1CdZ/+asE?=
 =?us-ascii?Q?G4YbHEqiQwoMTaamyzMT74dMa4eksiL4cq/IXRTZvBY7OScXep4nql1XV8cN?=
 =?us-ascii?Q?eWT4xI9IyP3SVCOuCfQ5DyNzv2R+/GvNLui8ViqT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b17d7ce-92c3-41cf-12bc-08ddad16f3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 20:47:04.9895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NudXPHfsJWS3NxQlR800xjn1Exv00GlGL/oe+qkpIxiPm/2wJVm2huMvB5OoLftmn78FpygRRtFW8Xw5gZhfmgx+stQS/1tgZWFRFrJ304A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7084
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, June 16, 2025 12:55 PM
> To: davem@davemloft.net
> Cc: netdev@vger.kernel.org; edumazet@google.com; pabeni@redhat.com;
> andrew+netdev@lunn.ch; horms@kernel.org; lee@trager.us; Keller, Jacob E
> <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>; Alexander D=
uyck
> <alexanderduyck@fb.com>
> Subject: [PATCH net] eth: fbnic: avoid double free when failing to DMA-ma=
p FW
> msg
>=20
> The semantics are that caller of fbnic_mbx_map_msg() retains
> the ownership of the message on error. All existing callers
> dutifully free the page.
>=20
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index edd4adad954a..72c688b17c5b 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -127,11 +127,8 @@ static int fbnic_mbx_map_msg(struct fbnic_dev *fbd, =
int
> mbx_idx,
>  		return -EBUSY;
>=20
>  	addr =3D dma_map_single(fbd->dev, msg, PAGE_SIZE, direction);
> -	if (dma_mapping_error(fbd->dev, addr)) {
> -		free_page((unsigned long)msg);
> -
> +	if (dma_mapping_error(fbd->dev, addr))
>  		return -ENOSPC;
> -	}

Makes sense. It doesn't look like you free_page on other errors either.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>=20
>  	mbx->buf_info[tail].msg =3D msg;
>  	mbx->buf_info[tail].addr =3D addr;
> --
> 2.49.0


