Return-Path: <netdev+bounces-112906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A80293BBDE
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 06:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA381F21D78
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 04:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E081C694;
	Thu, 25 Jul 2024 04:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9ssg2ed"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D588D1C2A8;
	Thu, 25 Jul 2024 04:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883326; cv=fail; b=rH6phqBZirHR5ClfVoORUk4ZKAsoScpe6W3PHDV+wnd+lIMby2KrigGaFXCkHwILQ2wXeS+Q3wBB6/CKT5r+M+2hU5tN6TtT6Xr1NbD1hGX1pkal5qIazotmHaAAHkUChpAouvei+PBP1mNf65J6FEutIZa67y3hqMR3jqT0DUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883326; c=relaxed/simple;
	bh=42UL9jOh7+u7KkGx5sI/l10rmZwnxRo8aax6VkitMMQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BlGQ8YvXtX6gPnA7X/u/Fpt2QlmQ+3Oe27/RkKP4uu3cOgvVzZ6D7++t9a+in/oGtZXLgp1qYt7et06Dpa3JUi2Jm5YNtlwMIcKBUWO7j6/hCmtfnJbUqc7gnGfGM4hCfh/pVcFWLDM6gVC50BIdWXLVUwuQsIHcG4BeNRG2v84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9ssg2ed; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721883324; x=1753419324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=42UL9jOh7+u7KkGx5sI/l10rmZwnxRo8aax6VkitMMQ=;
  b=k9ssg2edVz1ddA7eoXZZ+lchagpNFhDJj8oItvcvOsamZJdRaFz+9fL1
   cF+OV3nclQETr5X5cWOgLmKhrLOjrBStiButxtfVA/aX2elq9gcypUD00
   enM2szh1PKQBy0ORVCb0pkAGPrNee3VNuZLTAruLAGWfdoYP0WLpcgZ49
   d4ec/Fa4QX4WVy8TwA74iBMNhanVZLlZJ5M6uyAcnX7EBVpjcEpd7XJMw
   qTc+kDzZqb6AlJ48JWzvem8WsTuWsf1CpIHQ5+MhTtgEJYAqAOxYG6UV3
   tn3fBRH2xwJhSOWcH45lhitexdK2IcN/sU2Qui016cr/oBi3zqpZxh8t/
   A==;
X-CSE-ConnectionGUID: q0um2Mo0R4Wna6z7+RweOg==
X-CSE-MsgGUID: GhkM4NueREeovhH9v+r/rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="42127026"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="42127026"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 21:55:23 -0700
X-CSE-ConnectionGUID: OFveDKM+SgCTynjDbaNE6Q==
X-CSE-MsgGUID: 9t7/91QJTlu17m/4PfPsTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="57595712"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 21:55:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 21:55:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 21:55:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 21:55:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 21:55:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQ9wv7q0JOkM/B+2CTtn3IKLddfMMKhgeMuFRojqOuyw66m5i8D0WHFyBPiLrx1bcTeakhkNf4LpE1/6KVPbFAVhhHdVTsZ1qcSC/NzxIKvjeIigDHLVoyg3yFzghm95dnc1gF6eiiq5a+qyS7zZv8kQkZBR5dpAeOHw5r0yPUaPeHqI0rSYgFvMamP+hcnz7TnRsQQ0fBlk+JT8EF2WHKtynVnD0PnDqtn4R5zsqr28kMyutELmyT8mIQdLvM4+ig1BpABYS3k9aMLmAW+WDT1lYSOjCzKMIc8GSRZ1n4e8x7g90g6F0OZ0D5lJNoQNj4aMoqxacUTddbgIQ6VKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGlM2VIEHqfRBOg8yKloNmnGJ1sAKwgcfnHgr9axLbk=;
 b=lkiRwg872uBBudrxc8yB+FS0nshq4qMqq5IaegShpb5jSW5n6CWnw/JhZWgUe7KeRhanqNsL3d18LHfDGjM3+n9D97WxxzWoL2x5uNjhaKlBZp7FK1Cer4+e7A0g2GaLoZRrebJq2vtS6D1HEkgq6crUh0ed1rqduFqI5L8SCrjsCAlYNIz1I2qXS2hngMEt2wjzDFGClsQsZFYlJFSEC30z+Wi1Od4zYExqg2SNdGNGS3F3zr/OvMdUwyCXB3+uik1d+PzKqY9hYUeJ/VIvegaaEb61ioOMiCOwhuKXfu6aCWLxdiYxpV+InDjXMrrH/OmwVB3pnjiYTiLnbgPquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 25 Jul
 2024 04:55:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 04:55:20 +0000
Date: Thu, 25 Jul 2024 12:55:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [tcp]  23e89e8ee7:
 packetdrill.packetdrill/gtests/net/tcp/fastopen/client/simultaneous-fast-open_ipv4-mapped-v6.fail
Message-ID: <202407251053.618edf56-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: f299f65a-7ffd-47ae-9d32-08dcac65fc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fgV8hVlT4tHPNg4NbpGu2G8nfxwM8B80bQKPUcz4v//2pcmymPzJmrpNjxcE?=
 =?us-ascii?Q?VECCV9plpZU/KzSpBXsmb6dZ82meP2KGR3E7IqfsKBk8S56omrqlZqqnIs4R?=
 =?us-ascii?Q?F+3pi0SHf6Ymm+075kQNBBamso0jYhlY2VeHjk+7EWUfNikJ2kluyc7DPOdY?=
 =?us-ascii?Q?bRBHIAwp+wCUkdkQCVkKV6Alyawm5P4pMRkTvEMJQsUIBGIi+Rxqe4OPwBnY?=
 =?us-ascii?Q?wXOoEVTQV6wqXR2j6wqiV7knOx6fYDjswt486JhNj0kuy/an0+8r5C8f8maq?=
 =?us-ascii?Q?bGJEtYAeasq7Rommo1CrxDOfkx3kNiC+6KSP7gAb04usTI4LuOvdmAh3Nj1m?=
 =?us-ascii?Q?wVUkS0K+FsKtKgfy9aEXZHdQibCNRyaTKqXIOcXSYOFeka7epQHyjDYtYAxP?=
 =?us-ascii?Q?Z/fmKLBf0/F4Rl3elmsQDVB2vDJAXkbm8X0qW4UhK73B0vdoHSO95Bodo5R9?=
 =?us-ascii?Q?RV9UkQi875CQwRdtG1tZpssDMLVaNnBxxpJyEfNENyVElsXtUrSTXpDWWjFR?=
 =?us-ascii?Q?0x/LZWNytL1hTQwTs1ze8Vn6rOaAoGbP4wNAjsVumBqSdX68Z8qm3juYh6kz?=
 =?us-ascii?Q?8tlpMpZf8EHvJiJ52x58UCYjD/JNR5jUh1EY3FzR9agCXX8H9MPXmbIhL9kh?=
 =?us-ascii?Q?Gt2AaoHa6e1cs0mCh2O/oxni7v1DKrSoRXAlajTls8Se/4X7q07pcrhqAnT0?=
 =?us-ascii?Q?Tfy8+Q7LbWO8jkQB6ZUZq3Sr8Grgt9mjQaTSZeRANwxlN8GZ5g3r/uMlUQ2G?=
 =?us-ascii?Q?8ZdgLpNdm8lza1j5jqwgTHYpV7ePXFJ3blrpoWwCIBAmyYm7Sn7E6Ybz12Jw?=
 =?us-ascii?Q?LLfrMaQ4STpzsCmzc3/G1QV4XqR01V1I8oCp3533BGr09gj5a9A+IZR9QrdC?=
 =?us-ascii?Q?kfvblkovMj0MLP5Nt5f6h1t/uuM8+4GmUlpi8yhTrIPwb+TlQJm0JFNQ26N0?=
 =?us-ascii?Q?wB2xIAy4hKPDnnCTTzeIzHQLV46EDdY89UlkZhPg9JzI7Agi7IOAUUD5+0/d?=
 =?us-ascii?Q?8DBNe78NzkPZ0dvv3ZvBFcFzxvUjXiJ8JuDwtDnU/LhUYkf+Z6BRoqvRcLqn?=
 =?us-ascii?Q?MgjrU0k16R6SeSruEKnL9XFy9WylgPCpkwxQUu68MacCwM8z2MY6BbHVzruX?=
 =?us-ascii?Q?E5nKznaG5Ubzz5Clfc5ARps2PgYn2txPAUMQE9GVhzzw88qCNCl0atYIm9r6?=
 =?us-ascii?Q?79f2DwVnJJ1DlyuprP9a1bV76Y0ZlWOHGtK8HL1JAqU6Q5jw9poOChr8vJWh?=
 =?us-ascii?Q?EahPm2xgN+sJ4jgsgyyexUoL9nDSB5o+nqMfCA19tjO1JeqI5rBFmUrAAgTG?=
 =?us-ascii?Q?DPU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ILOgGIYjUFyE6+rK5a/OoSLBU16Cu5XKPDD/45FiWga8fPyqd88b8DAvU9d/?=
 =?us-ascii?Q?XwKooN1cuW7Rh8PAMigROZzU9NQgH2N78mUR+y3HQYjWFtxcNX5XPJt7Njm1?=
 =?us-ascii?Q?mEvu6y8yaLoE9oXrf0hSd+onwHq0zoMA8wlZ8VrPrNIZHNJZXanM2KiGQRRo?=
 =?us-ascii?Q?QXLpK0PgYDQvCqkkIzzry2e5rGytBq02bOHxBknbou2edhtbgSy5PcpIazqj?=
 =?us-ascii?Q?v/wSM82wUJxx0f/B7PIMqQgJfviBmsrR19rrC7k+O6R79v3iF0xwZrmD+NaY?=
 =?us-ascii?Q?FluWh5iKRqwbXUhQB3tTckqr8fqIVdAaa+lKCkKx4SoJpXhTf+b2gJjieRTe?=
 =?us-ascii?Q?lVQWbnf13NafYSsN1LAKD7N+FXN3+7KFWYZHz4nNrJQEIVkKM1B3JX2O9/UL?=
 =?us-ascii?Q?X51fEHSAf1JlX7XmHhf1mAjZLu1CkuKx5s0azC9y/8V8tEBDkFNPrL3CUNof?=
 =?us-ascii?Q?DlqmeFPvxsVUGhMOOpXBaEeYLr3vuaSIawmQ1VmETWGRqWeExBlmXWPtzrW+?=
 =?us-ascii?Q?rND91gpGcSCNJt6/7kN96yFmJxx7pSXi1VRgp5IoSYXbV93IqxuCPrbO3K2p?=
 =?us-ascii?Q?a4soBd4fga7HdRKE//AkRv/t9/BCwXvMp0VYcLAh4rBnzNwo9cBQncMcoMJv?=
 =?us-ascii?Q?xg9KpRMPzwAPM6K7Q2apjdoJAUr4FrqtjmJSdXQB+1kvhYRaPM8KwcxOHq8V?=
 =?us-ascii?Q?6FTflGM84SJPhFb8bbxjyCg8uLobXyXiwoCNvFxgIQz3Hm8BOmMeDNRI1h3y?=
 =?us-ascii?Q?WP5KyRuVlGqhv8Bn4HRYIFHDCt4B0w0bFXVdgOMonuy04R51G9oN7P5XwLou?=
 =?us-ascii?Q?VmzSOHs15apZi+fLARhKQLuiyrNl/J2um9GepvKDV0Lhd5IRVkXCRFJ3zujV?=
 =?us-ascii?Q?Abw8In0ZUh8eDKTLAjBjcAhZ+odafB8p8y/15gbi5SgRE42ewhJJl2KVp44C?=
 =?us-ascii?Q?4DVG4AyWrJI6xeOUO/Pn7f5IgiYkTs0vBDj0gywbmCXg6ulRsaE4yVel68jN?=
 =?us-ascii?Q?RTI3XvTjMb1hObyqNmr9721Hbq35VMC8Xq0KDpctcWsDsJVWhMKXi4ZJesJu?=
 =?us-ascii?Q?nd2CAM5S8jevK/hkKmhqMJ+JysanmuIYo9ZScNugIMpBZRkkfG/xTZt3W1Zf?=
 =?us-ascii?Q?YqVZxkLGw5d/IU+nhgl53LvW4A7ATemhL5L32sQtB0Yha6yxmsyqa8wMokAC?=
 =?us-ascii?Q?NEl4crQs78rpfbigupMZ0r3YcOx8Vd7CmlSWFOkp+Z5VT4tr2jqmUFmNDB9K?=
 =?us-ascii?Q?hkHyWrs8Ux+hwsdHqUYhJcy+gYtGJP2k48H7Neb76olru/ZVFdGFEE4bJ2El?=
 =?us-ascii?Q?XkBbCzQPXOW/eUwRBGGhrz6D/FvNruErOGoKeOyBoea6vXumk9GGqSBHvBrU?=
 =?us-ascii?Q?C2LSwf9MYCk2B4bomuD5isMM5obaWr7XZw/aj8Xa1OfTgTVlcuog3xRhCAng?=
 =?us-ascii?Q?LY378xv0HdSgRpyEYaZmbQ+fua3gF17gp94C9gOKEQN2KraGfpYdI387DViN?=
 =?us-ascii?Q?dhzR2n1OWblDn1+LlQ6afZpeUvg6cO3Gr3dF1z7Xo0rd3nzZhOB5sKWEwjrO?=
 =?us-ascii?Q?4t2AytCXD6vq7HWzv4zglImI21NdjSuOBmc9K0P4EiXl2xHrsXUMg6xVI6hG?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f299f65a-7ffd-47ae-9d32-08dcac65fc12
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 04:55:20.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zEotEk7xHLTrw2mBNN+QWF2agoIEmAk6yu5vqjW8szCGtTzWUiBVHktGxN6fyyMpZFGiIDiiK4pd+kStQ+Stg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "packetdrill.packetdrill/gtests/net/tcp/fastopen/client/simultaneous-fast-open_ipv4-mapped-v6.fail" on:

commit: 23e89e8ee7be73e21200947885a6d3a109a2c58d ("tcp: Don't drop SYN+ACK for simultaneous connect().")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      68b59730459e5d1fe4e0bbeb04ceb9df0f002270]
[test failed on linux-next/master 73399b58e5e5a1b28a04baf42e321cfcfc663c2f]

in testcase: packetdrill
version: packetdrill-x86_64-31fbbb7-1_20240226
with following parameters:


compiler: gcc-13
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


we also noticed other failed cases that can pass on parent.


42ffe242860c401c 23e89e8ee7be73e21200947885a
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :9           67%           6:6     packetdrill.packetdrill/gtests/net/tcp/fastopen/client/simultaneous-fast-open_ipv4-mapped-v6.fail
           :9           67%           6:6     packetdrill.packetdrill/gtests/net/tcp/fastopen/client/simultaneous-fast-open_ipv4.fail
           :9           67%           6:6     packetdrill.packetdrill/gtests/net/tcp/fastopen/client/simultaneous-fast-open_ipv6.fail
           :9           67%           6:6     packetdrill.packetdrill/gtests/net/tcp/fastopen/server/basic-cookie-not-reqd_ipv4-mapped-v6.fail
           :9           67%           6:6     packetdrill.packetdrill/gtests/net/tcp/fastopen/server/basic-cookie-not-reqd_ipv4.fail
           :9           67%           6:6     packetdrill.packetdrill/gtests/net/tcp/fastopen/server/basic-zero-payload_ipv4-mapped-v6.fail
           :9           67%           6:6     packetdrill.packetdrill/gtests/net/tcp/fastopen/server/basic-zero-payload_ipv4.fail
           :9           67%           6:6     packetdrill.packetdrill/gtests/net/tcp/fastopen/server/opt34/basic-cookie-not-reqd_ipv4-mapped-v6.fail
           :9           67%           6:6     packetdrill.packetdrill/gtests/net/tcp/fastopen/server/opt34/basic-cookie-not-reqd_ipv4.fail
           :9           67%           6:6     packetdrill.packetdrill/gtests/net/tcp/fastopen/server/opt34/basic-zero-payload_ipv4-mapped-v6.fail
           :9           67%           6:6     packetdrill.packetdrill/gtests/net/tcp/fastopen/server/opt34/basic-zero-payload_ipv4.fail



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407251053.618edf56-oliver.sang@intel.com



FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simultaneous-fast-open.pkt (ipv6)]

...

FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simultaneous-fast-open.pkt (ipv4)]

...

FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simultaneous-fast-open.pkt (ipv4-mapped-v6)]

...


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240725/202407251053.618edf56-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


