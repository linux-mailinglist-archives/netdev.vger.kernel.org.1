Return-Path: <netdev+bounces-161684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E250A23485
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 20:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6141A16249D
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8A1F0E31;
	Thu, 30 Jan 2025 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiRKYngW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF31898F2
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264256; cv=fail; b=o8IZyT66KNySbiSubcRtDIXQDTmREkLETeN9HGIeHirfT8wqw6p4Ll84uI4PlrPNElJP1iznFGC7ekswLz5aEg2yqs3jG0yGLQ0r5QTb2pV945HdpZfh/b6/m/KdSSHHqygjCDW+jjecN6Mer+DiPrjxYxwwhE4uqr655KqjJi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264256; c=relaxed/simple;
	bh=ke+91IvPLWAAUHmOQHDZGpIX+LcoqmTejhcSzqLvfGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WR3ThzrBCyPJ2z/hJ8ci6Y/32FTFfSAra7LbOCuinXW4gS1swogCx+jdxEajXkmi3nd/x8BtisBk6wiB2qgNuSexagjk5X7P3w5+x2MSWqHgc3WhcmvjBnw1VzRzxA318WfWiIw5uEIpFG594GwEteUoaFgfX1iP/5dqPsjtDBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiRKYngW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738264254; x=1769800254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ke+91IvPLWAAUHmOQHDZGpIX+LcoqmTejhcSzqLvfGg=;
  b=QiRKYngWDB09GH1l3uAU0Go8bmw5p0siJ1p74Mvk1iZK8otWHbmSV5n2
   uAe9DO+GaBCqvFYp8DZkd7KvTlG/2bDmxViytua1ZIOTo1+Oh1baJ5CGn
   4bdsofDoi7HUFZ17B8839+Sik0VfnjXfQRWHy2yGTlVgq3ZLcsnN9voOz
   SGldNDacfG3zftoLqOdfHN/Gld6I9lX9GqtuTvwwlsr5lqjaAWnNrhVr9
   mkKQEhou38ij/Mf8z+tBoXfLDQSi7OuLYA4+PFe7cpf9nqeZtnKCj+9nQ
   2g4By9P7rK8o/mLBDguV+zKiOvfUFdR5VLNHrK2VSDpn/Z3i6QLXNFvqt
   w==;
X-CSE-ConnectionGUID: ztU7VgYZQta5ol4QiEb1Kw==
X-CSE-MsgGUID: f7wcG73BQFWC8fAMmojMkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38531958"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="38531958"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 11:10:53 -0800
X-CSE-ConnectionGUID: fgBbKBRRQNiOKYyLmc925w==
X-CSE-MsgGUID: jIFi8J5PRB+SL01Q6SWUGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109877153"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2025 11:10:53 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 30 Jan 2025 11:10:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 30 Jan 2025 11:10:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 30 Jan 2025 11:10:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO+qRbuR9Sw44YWQQV3/GuNX5+aQYWGKMj/GfODTbZIe69aBQks3KKiq5CuSp6jkBC88gtC34osYx619YSzWPKzkIh0UO1L+MgQjqL2Q4ydJ8nxuo2RbHlksrOLbyBfDT8wtQlAPrYWaAcRQl8Q+PXryVaa/IJJxPWf55X4q8CyCpOjuzeRbelWTTw1Uor11aol/5/5i+eWnRJefAOLAf+SoXmzXC0VjTVPgOxet5fk2Aviw+jRMx4Pxf1fqEqLNmtNoZ8NwFf4DGSIvsFsbzEZuOsWQ0y6eBnqRnKptt08thrSlMfYsfPOeSMCExccLGmdIXL9wVt8FCgjZVqQHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3VMlyHXsIViFcZDygVJ+RiERX8kHTuJb0nynAMyyRE=;
 b=vStm51Y7fuzPy5XoGFNufyBiUdvOpoVUcp4RmrgNUtDXzW1JCHDH9XsLJvBZ5D4dJyt68E+hp+Ur6Gzonxd2o9l0u7XR01kTbOZ8tYK0S6Tlt9zt1v0SCuqTg5mNMYoCBUSnHsSC7iKhcjhI2IFxvJFbmrooYR0QvDos1oWoW+4mnBVVrZdaQWy5UVXgOqce3SsXt1oLqngxdkYRNfq1Ax7yOcK64xX03R7BuUQzcdXsPDgEEoBeu6tYsK/bBbShnRlJHo8pF3gkFJErwxmQOsb5S6c6kIVZMgChuEVdNL5OPl8Q8+4XuvIS9779NRh8wr6TKOZo4Zl3Y0h+zNi7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9)
 by BL3PR11MB6458.namprd11.prod.outlook.com (2603:10b6:208:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 19:10:49 +0000
Received: from IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5]) by IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5%4]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 19:10:49 +0000
From: "Joshi, Sreedevi" <sreedevi.joshi@intel.com>
To: Andrew Lunn <andrew@lunn.ch>, sreedevi.joshi
	<joshisre@ecsmtp.an.intel.com>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] phy: fix null pointer issue in phy_attach_direct()
Thread-Topic: [PATCH net] phy: fix null pointer issue in phy_attach_direct()
Thread-Index: AQHbcnzIjUJuMNncQ0eitKAUk2d4urMuHwuAgAF3r7A=
Date: Thu, 30 Jan 2025 19:10:49 +0000
Message-ID: <IA1PR11MB628928A8735D0B5BDBEBB05489E92@IA1PR11MB6289.namprd11.prod.outlook.com>
References: <20250129183638.695010-1-sreedevi.joshi@intel.com>
 <fa054892-b501-4e98-a8a5-6fc9acc68be5@lunn.ch>
In-Reply-To: <fa054892-b501-4e98-a8a5-6fc9acc68be5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6289:EE_|BL3PR11MB6458:EE_
x-ms-office365-filtering-correlation-id: f67b0fde-6154-4791-1716-08dd4161cea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?r5Nia12UhnS8Piyx/vTJ1bvAMh+1pdNYP+uY1CJ2oO79b239i5kSH2pS5wG+?=
 =?us-ascii?Q?390MZGGsCvIyPMGpjhr067+3VhLLZPuTlYrLlbtW2BgJHejdwhvXknZGcuc/?=
 =?us-ascii?Q?UtP5ccOsnmqsstBJb/j7CHYRgk6VAgMtCYRfYxhp7DGoTigA2Py8unBdthTP?=
 =?us-ascii?Q?bEhBQE1Ii/kgzO7xU/uAXs+8KaELqAw24Xt9rYp9ji2VFxZyYfNKqLjCiWcH?=
 =?us-ascii?Q?yvOqvsVRSaMSyZIPejy0wBGODPb35zPkbFn+0VU+267+ughi6p6doIIrzNCg?=
 =?us-ascii?Q?zpZzi/6L4MgWPnzl/+EEp5OwBtp+4ilzcqt+jBTIuyn8cnjf+zeyoz+tzfbX?=
 =?us-ascii?Q?Lba6W4wbpI6lZ+7GI6XH3r7jic848uI7Liq44w9vJuk4QcYVqqH1iLteX2u5?=
 =?us-ascii?Q?zKn5HnRsUGGWaaMuoCiT0TNlGSbtIYEeNlHn/HWKUW9o/S8XySX+tlIsyD1Q?=
 =?us-ascii?Q?OGClq9lV6sWbrAF9nV5ZJY6wqQuCCg9S3MoqlzFwvTFdsdfp0sRWd1yl0mZL?=
 =?us-ascii?Q?N143YlfDIrg/nGMV6G6XicdQoWyfuXsTTaHTMzpqo7tPvhKm28rkQcpWjuH6?=
 =?us-ascii?Q?GbZCH/1ILHRoCt6qdZ6oMDiX6tVK7tJwpJlj+CMymL/cy/0YzdJYhU0Vi0LC?=
 =?us-ascii?Q?V5pm3XYeMZmxYWIGZa48tEArTC8BoYZHUwWz9nUiyRmg6+YridNIczjZ3rvN?=
 =?us-ascii?Q?dHZxn5YsAui6F76YNaOPzt7Ul5YbL/ToUtOaDNqwvp0NWvBb2+1DmUDocUcE?=
 =?us-ascii?Q?Le4QhOfnNFrLAB2iMBQ/IfawV/240shK/1XPNC7gRrl4fzS1g4K4nvCuK3CJ?=
 =?us-ascii?Q?Q0Fyi6HxbZlCnl/OHiDCh0l51RdS/oaufJZxY3YasM2FexljRG/Vgj1+ib3v?=
 =?us-ascii?Q?nYgscLY3dizZhA2rMnZBPaJOpeiR/SskxYK4axCs1ON/eJLZ5yoYxLk15I04?=
 =?us-ascii?Q?CjB78G/FYGIHm1XP24pthaS51lZ5W1G75fQ8L0TzZBlA0rTaVM0E6Zng7gpr?=
 =?us-ascii?Q?pK4vMmrs5eB9TTloPUQP78ynqdfGp1GufzPPJJKhSeyWDfZhPSas8B2XXsnL?=
 =?us-ascii?Q?+WbiJkJo6gGNe4pN3C8yn5zpoBVVco8hpBB2gyKFj1ZhSxrvj8yYwMQ6GA6y?=
 =?us-ascii?Q?ZvzB6/PrSzg4zPFPCVPH0kl+lPuegKtL5Y5vZ9p0gR6oIGx/J6DMJ0FXUS/O?=
 =?us-ascii?Q?IZcUdhZsJ6uOm5VoWVcJe6qYset9ffPZF9d3vkvBRyiRXes8jpml+QVhcRjv?=
 =?us-ascii?Q?ONrp9Uo4WgGyciJtrauXJOAATl2f5aaknBg/3sKGXhK7eZiIw/xtVxStqjXa?=
 =?us-ascii?Q?FzfiW9TSi7sSJ0gAxRJ5ayeS64poBnjLK6m+OsnMQfihWI03k9q5ueMEvZGC?=
 =?us-ascii?Q?IroyUPm7j7gcmWQzHMGZyqZTsBOQIrBWHGhyDsSd2zygwhYi81KY8eVfvea0?=
 =?us-ascii?Q?ZPXPrmtyUgULGJYKz6/4stCXkxewb1vZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ukpd+6OABJRAXtOKGllWZUSUIjZCompTekW5pG823jrzSKznOijGqxtgDAbg?=
 =?us-ascii?Q?+vH4d+9oBDoDnd+tn3QKBcr9OCyDp8wpjKc2e7bmj9QVuuU6Z0fS5O43ihsy?=
 =?us-ascii?Q?vFqBmVCXPoAxG2X25asfXG76bvdUYg9QwWOJcatZ2rMaZsUJFMspgVbXu84n?=
 =?us-ascii?Q?8dlw/BChXvIilp6ufTWnrXFr+DmayAkKroZO+naF8o7KXS4hw/74VCfUzd3z?=
 =?us-ascii?Q?r0Ua6MWLRWk/YVJ/QWWP9/811oS/DAn1fjjbUJlumxy63qsLBcqeeDifr/53?=
 =?us-ascii?Q?ZMEMEGgnvvea/cEc8jo6F+U/9psLj7IzBL9wO3S4Gi0QLv1tFe2+6gSzx6bk?=
 =?us-ascii?Q?S5Pb9XJJlGKi2n4kAAxbVnfpeG+wfOqhmFtl5k06x4zH3tl75ZHIET4dk3H1?=
 =?us-ascii?Q?p/3jcMHhRSuWblSdnUPc/0OyYmbFd6OLxYIIwYBhHzjr9lOG0QvrPSDT5WsG?=
 =?us-ascii?Q?2sxfzxTmnOsaenKfav3JMjhHjYptqkiJmATH4cVhfJLfUBfdeieugC+/XbdY?=
 =?us-ascii?Q?EjIFecfcr3VAVf3hwtJN+c7GHFkJv5OPUwKOdQOILwUPUer36xkijIqs7HXe?=
 =?us-ascii?Q?ZXI71jxWmlLflLq3mIXmcYxI81SrxIbOp73o9zKfJO8o8ZI83npUsezdWhZ1?=
 =?us-ascii?Q?ioXxtMQfkOjEXCEukp6aqXv8B9YmfNy/THMmsKydumPXr73+/Q1sqPv1a3YJ?=
 =?us-ascii?Q?Lqn5i2kgaauPD/M5esJ2FdXP2z3UFPIw2dyfOPDzfgHFUAc0cLMi885XUpwR?=
 =?us-ascii?Q?IoD5AEkS/T39wA0ltUU6J/7P+J7pb4uLVm4oGLeh+vDLawTbcuZRgHw61FRF?=
 =?us-ascii?Q?FigVasDkOK+Xzb4c6tpZza7FU2fHCFv6iq+2o3a1B+WKcFmrIY5P8APcsUIN?=
 =?us-ascii?Q?RCcGsx5poqbMfHM9OSIQgZSgvTc7dltO1pyugzch/33XLV8837PslMZHLRrg?=
 =?us-ascii?Q?zE9L5GGS59mjXGdFGiv1AZpn629VeXvRpfnDKuEtUNEyFOCRWVy1CAh/RTH/?=
 =?us-ascii?Q?5AlMX714a7MdJD8l4/wbQTLSnfzV/ak5fTxeRDoif+XuPXBwcLHXXDXcdgZR?=
 =?us-ascii?Q?mWn0m76gOUKOedLGpl3zY0d6vlayjjoE8LLdCWWJaNq1CqiziAY3DWE77EWP?=
 =?us-ascii?Q?cwtofZUVfW89b0KPymfdEy7IWiyrwiEMi1T8EiLLLAlhBpVz0n2ROgHMlD4l?=
 =?us-ascii?Q?ZbdKdWuxAtR8h4+YwGq0R/HGbUslzlVsnKoaiqMMkoXqOCCemh7nipEJtJEr?=
 =?us-ascii?Q?SjDYcIeje/aH8eF0yl61WVeZJeXP07Rfx2M4q3VRTYSo7FQqH9Q4moCJ+Exh?=
 =?us-ascii?Q?RL6GZu8jNwvnOk8CZ6UoIhR7m+PYHLMLsoJ2dS7GqHuItU74x8JFZhstrx7z?=
 =?us-ascii?Q?ZeLC4qVKFvY4qW7Bns+7bkoX+sc3oPXeLKlnmbSLnekiDY4YEUUA+Hz4TD2X?=
 =?us-ascii?Q?RXyslE18Nv0mcsig33+TIgou0iVnEacTMIXhImQhmaF3TmJGgK0WvZVhCiq9?=
 =?us-ascii?Q?Jw1n1Ka58fRMVYtWb+4CqRBD2Bh93SgPEm+r2laNQaKvo/YbmVuyR+BMSk/o?=
 =?us-ascii?Q?mF21iHFDDOyaZUMmqTNT4OFWK4kLqdSMYHE54NoD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f67b0fde-6154-4791-1716-08dd4161cea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 19:10:49.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HT+pksZ29JQt9kiAKLngiW/rC2rpKvRY1Dupvs9D0/DOYKaYiLMvGRrwRG5Sx7QFY2DkCv94fsZfw39voYQE+82IgaPlvLQXiyAW9LYPdP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6458
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, January 29, 2025 2:14 PM
> To: sreedevi.joshi <joshisre@ecsmtp.an.intel.com>
> Cc: hkallweit1@gmail.com; linux@armlinux.org.uk; edumazet@google.com; kub=
a@kernel.org; pabeni@redhat.com;
> netdev@vger.kernel.org; Joshi, Sreedevi <sreedevi.joshi@intel.com>
> Subject: Re: [PATCH net] phy: fix null pointer issue in phy_attach_direct=
()
>=20
> On Wed, Jan 29, 2025 at 12:36:38PM -0600, sreedevi.joshi wrote:
> > From: Sreedevi Joshi <sreedevi.joshi@intel.com>
> >
> > When attaching a fixed phy to devices like veth
>=20
> Humm. Zoom out. What is the big picture? Why would a veth need a PHY?
>=20
> 	Andrew
[]=20
This issue was encountered when working on a POC to demo the mii_timestampe=
r timestamp
callback hooks mechanism. We are using veth pairs as we don't have the HW y=
et. In this demo,
we connect a fixed PHY to veth and attach mii_timestamper hooks that way. H=
owever, as veth device
(like any other virtual interfaces) does not have a parent, it causes Kerne=
l Oops and on our system
it needs a reboot to recover the system. With this check in place,
we could connect fixed PHY and mii_timestamper hooks successfully. I unders=
tand
it is not a common practice to attach a PHY to a virtual interface. However=
, having a check for NULL
before accessing the member will be good to avoid issues.

Wanted to check with community if it is worth applying this to the upstream=
 driver.

This was the crash log:
025-01-30T18:26:53.952545+00:00 dregen kernel: BUG: kernel NULL pointer der=
eference, address: 0000000000000068
2025-01-30T18:26:53.952570+00:00 dregen kernel: #PF: supervisor read access=
 in kernel mode
2025-01-30T18:26:53.952571+00:00 dregen kernel: #PF: error_code(0x0000) - n=
ot-present page
2025-01-30T18:26:53.952572+00:00 dregen kernel: PGD 0 P4D 0
2025-01-30T18:26:53.952573+00:00 dregen kernel: Oops: Oops: 0000 [#1] PREEM=
PT SMP NOPTI
2025-01-30T18:26:53.952573+00:00 dregen kernel: CPU: 80 UID: 0 PID: 7734 Co=
mm: ip Not tainted 6.11.0+ #100
2025-01-30T18:26:53.952574+00:00 dregen kernel: Hardware name: Intel Corpor=
ation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0011.032620200659 03/26/202=
0
2025-01-30T18:26:53.952576+00:00 dregen kernel: RIP: 0010:phy_attach_direct=
+0x34/0x3f0
2025-01-30T18:26:53.952577+00:00 dregen kernel: Code: 55 45 31 ed 41 54 49 =
89 f4 55 89 d5 53 48 89 fb 48 83 ec 08 4c 8b b6 e0 02 00 00 89 0c 24 48 85 =
ff 74 0f 48 8b 87 78 05 00 00 <48> 8b 40 68 4c 8b 68 10 49 8b 3e 4c 39 ef 7=
4 0d e8 27 a6 85 ff 84
2025-01-30T18:26:53.952577+00:00 dregen kernel: RSP: 0018:ffffb6b4337c7698 =
EFLAGS: 00010286
2025-01-30T18:26:53.952578+00:00 dregen kernel: RAX: 0000000000000000 RBX: =
ffff9dbd9a3c5000 RCX: 0000000000000002
2025-01-30T18:26:53.952578+00:00 dregen kernel: RDX: 0000000000000000 RSI: =
ffff9dbda39f9800 RDI: ffff9dbd9a3c5000
2025-01-30T18:26:53.952579+00:00 dregen kernel: RBP: 0000000000000000 R08: =
0000000000000000 R09: 0000000000000000
2025-01-30T18:26:53.952579+00:00 dregen kernel: R10: 0000000000000000 R11: =
0000000000000000 R12: ffff9dbda39f9800
2025-01-30T18:26:53.952581+00:00 dregen kernel: R13: 0000000000000000 R14: =
ffff9d014dc48000 R15: ffff9dbda39f9000
2025-01-30T18:26:53.952582+00:00 dregen kernel: FS:  00007f6e30b20b80(0000)=
 GS:ffff9e778bb00000(0000) knlGS:0000000000000000
2025-01-30T18:26:53.952582+00:00 dregen kernel: CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
2025-01-30T18:26:53.952582+00:00 dregen kernel: CR2: 0000000000000068 CR3: =
000000bd51444002 CR4: 00000000007706f0
2025-01-30T18:26:53.952583+00:00 dregen kernel: DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
2025-01-30T18:26:53.952583+00:00 dregen kernel: DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
2025-01-30T18:26:53.952585+00:00 dregen kernel: PKRU: 55555554
2025-01-30T18:26:53.952585+00:00 dregen kernel: Call Trace:
2025-01-30T18:26:53.952586+00:00 dregen kernel:  <TASK>
2025-01-30T18:26:53.952586+00:00 dregen kernel:  ? __die+0x1f/0x60
2025-01-30T18:26:53.952586+00:00 dregen kernel:  ? page_fault_oops+0x15c/0x=
450
2025-01-30T18:26:53.952587+00:00 dregen kernel:  ? klist_next+0x145/0x150
2025-01-30T18:26:53.952589+00:00 dregen kernel:  ? exc_page_fault+0x77/0x16=
0
2025-01-30T18:26:53.952589+00:00 dregen kernel:  ? asm_exc_page_fault+0x22/=
0x30
2025-01-30T18:26:53.952590+00:00 dregen kernel:  ? phy_attach_direct+0x34/0=
x3f0
2025-01-30T18:26:53.952590+00:00 dregen kernel:  ? __pfx_veth_adjust_link+0=
x10/0x10 [veth]
2025-01-30T18:26:53.952591+00:00 dregen kernel:  phy_connect_direct+0x21/0x=
70
2025-01-30T18:26:53.952591+00:00 dregen kernel:  veth_newlink+0x1f7/0x550 [=
veth]
2025-01-30T18:26:53.952591+00:00 dregen kernel:  __rtnl_newlink+0x70f/0x980
2025-01-30T18:26:53.952593+00:00 dregen kernel:  ? avc_has_perm_noaudit+0x6=
7/0xf0
2025-01-30T18:26:53.952593+00:00 dregen kernel:  rtnl_newlink+0x43/0x70
2025-01-30T18:26:53.952594+00:00 dregen kernel:  rtnetlink_rcv_msg+0x14b/0x=
3f0
2025-01-30T18:26:53.952594+00:00 dregen kernel:  ? dl_server_stop+0x2b/0x40
2025-01-30T18:26:53.952594+00:00 dregen kernel:  ? __perf_event_task_sched_=
in+0x8c/0x200
2025-01-30T18:26:53.952595+00:00 dregen kernel:  ? __pfx_rtnetlink_rcv_msg+=
0x10/0x10
2025-01-30T18:26:53.952597+00:00 dregen kernel:  netlink_rcv_skb+0x54/0x100
2025-01-30T18:26:53.952597+00:00 dregen kernel:  netlink_unicast+0x23e/0x39=
0
2025-01-30T18:26:53.952598+00:00 dregen kernel:  netlink_sendmsg+0x1f3/0x44=
0
2025-01-30T18:26:53.952598+00:00 dregen kernel:  ____sys_sendmsg+0x2d7/0x31=
0
2025-01-30T18:26:53.952598+00:00 dregen kernel:  ? copy_msghdr_from_user+0x=
6d/0xa0
2025-01-30T18:26:53.952599+00:00 dregen kernel:  ___sys_sendmsg+0x86/0xd0
2025-01-30T18:26:53.952599+00:00 dregen kernel:  ? do_fault+0x2a4/0x5d0
2025-01-30T18:26:53.952601+00:00 dregen kernel:  ? __handle_mm_fault+0x55f/=
0xff0
2025-01-30T18:26:53.952601+00:00 dregen kernel:  __sys_sendmsg+0x57/0xa0
2025-01-30T18:26:53.952602+00:00 dregen kernel:  do_syscall_64+0x3b/0xc0
2025-01-30T18:26:53.952602+00:00 dregen kernel:  entry_SYSCALL_64_after_hwf=
rame+0x76/0x7e



