Return-Path: <netdev+bounces-132215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222B9910A9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF9AB2C1A7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5351D95AB;
	Fri,  4 Oct 2024 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIi0CaM2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB51D89F8
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069572; cv=fail; b=N4nLEJx3J2DwHyfGAIqHz5DmqzoyMt/u3QykbLnDGAyE4DbtxW9XZDmkZDuwDdbxWsfqbyK7H2tsg0hRO8xwypiMeROi9r186UoCtSvSR+n6zXzrC3TZjSGCfhlFQCib+5sk4/CHHlXwG1AABZPcLTRp/aggT56V1eNwJU9IGEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069572; c=relaxed/simple;
	bh=g1NFRUKxNhAXLL+We+uHYZ1qfE5gfu8cn1jhgvJrT/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gEsasBcjo4hE39yo2bQa+3KX8GvoZX59PZ74yOoU49oksq4PwO6gucIihdUaF9h1z2mVP+UA7zxZ7goCabaLo3fhmZFEl1ZQq920hk8EQkG/ql/ol2RQLhvLOqlKvstKCSSF5DDLz8HH5zxoqqmbD8QHWkAa4/yyDizb1oIb3V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIi0CaM2; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728069570; x=1759605570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g1NFRUKxNhAXLL+We+uHYZ1qfE5gfu8cn1jhgvJrT/0=;
  b=JIi0CaM2DGFmikhOrBJp5K65xfn+hsIIFqQj4h5oqul7VnanFTVHF85E
   ofOF+aRRbIoPlV7+m9G/CswB4eKerKN3Ed0Xvuy9AfzxZpzB7Br51Ub9D
   5oTTkMbFPquAzwUXFVVnOLV1RZEbuBJUePYX4vmjp2jjerHSszG07U4bR
   TeRTb+UFdYpE/ezY4xS0GJqA8QSLqyx0/8GnmPfFEUEhEx7iPdNLB496q
   xtDt1bzSfjP+l1p6No6x7xqy1zQJiVhC0HD/RDhfVeuHig1bhKyPpPtvk
   yiD5JcCopGSXQtAzQnYxp9KEwQ4raxobbdfI7qV8DUswtwmiEL0uYCNfA
   Q==;
X-CSE-ConnectionGUID: 3Or+j7T8Q2KZva/RZYnkJA==
X-CSE-MsgGUID: TCEDgOJvRjqVNYOeE1+1bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="30186706"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="30186706"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 12:19:30 -0700
X-CSE-ConnectionGUID: snA86W5qQ7iA0cBJcGpQRA==
X-CSE-MsgGUID: Mj9qUsOiQ8WPrHQUBdLmXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="79366099"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 12:19:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 12:19:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 12:19:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 12:19:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 12:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmrvNY+1PW2LfJkuEUi/LENQO4NXZb13pN4HvNEBwLTPOwiQr5IQoeCJDQQd0Q33djgWFUXwEtIpPa8SooBebHoUPIxcEPfZ4aH1ux6wFkevhls0KtQDzPwZ9TxLQX88Z/ZfMQAe8Y/iqwZpr7Qvvmk1p2XMsA0urGMDHKysi3YLLV3a4aggoufwcs/YsUFjldwJIZ8yQovpV4oyO7+x2zrrR8AHDZ91J+4QJdus6pxI6qnqlRS9UDfMKU+Julrzq4+1dsUtt9TP8vkG2V7vRHvMP2aJq2YaB4LHQZR8f9Zj9HAh1VGIMSXGcaHFtd/3BtrGD+WUo6+/sf+M6AiKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1NFRUKxNhAXLL+We+uHYZ1qfE5gfu8cn1jhgvJrT/0=;
 b=JlBSzTrQ10aBD2eKXxti+3fXx3yhsoEyUorGHCut2AWqTH2v5odj6vvcYp3vvwGBBgkVrG4viBqpZLrp4gHsXa7j1LlwQ2IpCO0Q1JtjfWkJffbRRcd6tBzyoIYYG40/ATKsscMPo7vnt1cdtv9OBJAzjBeO0k1TUU2HLgjAw931RPH3rcEBSAzX+m7LJHBsL33jk0Y1iE/ep3/N0pVdfYdVZRnq7TtmmsF84KCX+Xe4ZOJem8c9I7e3WK/CpYV+NSGTWI0Cqkm8PJdMs67NsUHq6dAgPB2bS44Lt2u8S7Px2beisKv9hdgxWGUkWgQl6OIyZ9ysX0wg3Ofr8yIpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4662.namprd11.prod.outlook.com (2603:10b6:208:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 19:19:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 19:19:24 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Michal Kubecek <mkubecek@suse.cz>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>
Subject: RE: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Thread-Topic: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Thread-Index: AQHbBcDOMMZaBx8spU226K8QgDZHzrJWUSaAgAABlQCAAAVKAIAIokcAgBXkhgCAAB8wgIAALI8AgACfeYCAAU7NQA==
Date: Fri, 4 Oct 2024 19:19:24 +0000
Message-ID: <CO1PR11MB5089C7F00BCDDCBB678AF260D6722@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
 <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240913224858.foaciiwpxudljyxn@skbuf>
 <IA1PR11MB62661EF398124FC523CC3C03E4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <45327ee6-e57c-4fec-bf43-86bd1338f5fb@intel.com>
 <20241003091810.2zbbvod4jqq246lq@skbuf>
 <dcdnyuvjksvebfgcavogszlcoro3gwinzc6fzfjjtijadyg3km@7spc2j4v2ci6>
 <20241003134916.q6m7i3qkancqjnvr@skbuf>
 <tctt7svco2xfmp7qr2rrgrpx6kzyvlaia2lxfqlunrdlgjny3h@77gxzrjooolu>
In-Reply-To: <tctt7svco2xfmp7qr2rrgrpx6kzyvlaia2lxfqlunrdlgjny3h@77gxzrjooolu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|MN2PR11MB4662:EE_
x-ms-office365-filtering-correlation-id: d71eed26-a790-476a-0ca7-08dce4a97533
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4seekLMVkydGchZAZc3ROpfPPKK7vyBidNq4/9xTjqRn3rsww168CM4zJkl1?=
 =?us-ascii?Q?7IOrpilrXb4hCSHlAXFIDm0/yxx2WBg/t7h2zkit30JxUAbyvHCH1diLYBom?=
 =?us-ascii?Q?naHsmc9l6HMo8ip4VDbXRp6FESAdHLsh1eO2WM7+V6IN7T6qY+TDhTlHT1ab?=
 =?us-ascii?Q?CVsgpaM7zAR6OHLvVi9//9kr0nLJ6tQm71VJLKqKW6UjpD/6JXoG1rR81J2T?=
 =?us-ascii?Q?cbHLgTsz6vThAJQOZ9Af3191RULNJh3x/mM44TgZeL79xieJjq8LDgf68C/r?=
 =?us-ascii?Q?cQpLkMSbfSrYd06EwC6sFPShQfu+GyMqGtZOYu2YWBhXzXOPv2OfGjsOevzR?=
 =?us-ascii?Q?DbsmbYRuUl4fB5ElbtIHz39BaF52PUBOj6uLgTGmrm8rZgQkMuWqX1yCjSub?=
 =?us-ascii?Q?1F6g+uZsqFpJGZMQ2cj/U+sG0Nm6IxQPTDgnoQkZrdrF10PBl0mZCXpz/ae7?=
 =?us-ascii?Q?urkjfJe70FhSo7pEu4Xi9Dg9Mnyy94x9vJLL+jMaoj47wsyZBDqsIVItS0vd?=
 =?us-ascii?Q?WG0aW9QyYvzzE4qlvJzGZUwaalcFbIYNplY+3CAPG23R6HcaEzZOWd+ymt4S?=
 =?us-ascii?Q?ut+OYz/7HaNrixMLDbb5Z4LNVkQE0mD6a0LtQCmLlIyoUEfgaIFfUIG7m7Kk?=
 =?us-ascii?Q?J3RgPI/ASEtOYt97OmQwleGpT2BPn0bi2wohQ4k9K1TjNW4NPSbCH/mirv00?=
 =?us-ascii?Q?uG8pCfqO+y8zcM3rdKG+TF9CE8KMNWwGk+x9UOeEmA1DseY/gcORmFoIbOqf?=
 =?us-ascii?Q?A0bJ+CoPQI6sTlJdEKtC7+UR8h5dblNTahz7A6LFklHStoNNHgl3WPCnq/im?=
 =?us-ascii?Q?FSBps44KjA0cml1dc2tDGB1Tfhlzp8/nVckohg9SYOClV8GASXeB7+MKMQjs?=
 =?us-ascii?Q?vMbmJrgj3m4siRJKjkWIplRrjNffbyi4RKyvkOhmUlLL7u6PIQTeeyliENUf?=
 =?us-ascii?Q?I/ZlMd1KBAPQaXlN4iuSdpES/pTeN95mct1B6S7RtRvxqMDUbi4F3g0DIwID?=
 =?us-ascii?Q?1rjyaz4Ili5SHkU5W0qfJ/Im3CN5j5y1Llfn2ujcKYOyS11ZI4gcEIUp3woq?=
 =?us-ascii?Q?Zwejl9++trP0PMTbx5pkTTKF7VPdalQJsnvE3CQQEin3SoU0bPpAwaogCi5r?=
 =?us-ascii?Q?dG3BerLanfAlTcCpFoYVWBsWEVaQy1GVCudM4VRW2UnoYoJ98/nMDV44gemO?=
 =?us-ascii?Q?Lf6lkbPFQjOk+c91Zx0MIDZ84rFWyaooGIUEA+vJoKWOqJIKHibMrn4ePmBO?=
 =?us-ascii?Q?sfbML6qiWU1BiRGyeJFnJOKeWZMc93mb7q3onw72ybYVC1+pU/OXmeaCrBOn?=
 =?us-ascii?Q?gk2tqDNn9UbcpmX3q4cz5zx/oe4lETY/6U+54nsJDzhc1A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B85QTAKn4Ro0yqmourFMaTFp9GqWtU/Rct4NBcneeslzmySZhFZRLozEQ664?=
 =?us-ascii?Q?u+zGFOq061hCQmiKGGCZwnq10roGgMMVVB43Z6x8nj1xhhSmCqnJ3+lFl/Gj?=
 =?us-ascii?Q?CLisZQtqjCv2K9KiFhLVJoAS+jk7T6KnXSU5sL9pQDiT8NvNWT3nl5In3nsa?=
 =?us-ascii?Q?C9+mfoaZw+4kvWpM+wCK7TQ/8hrrBVSoUK+mwRO0yNr9BoF7JIxWhHIe7phE?=
 =?us-ascii?Q?II2jDR1JVdpBd7byecv9sBBApme+KQ3lhZfq9tht1zrebr+gLuqd4nI50izu?=
 =?us-ascii?Q?UxB5pWiHKDQwZb88ZCWNM/q0+dHiobNwtX8Dh8jEfHj0VmmuU0+CYUCcAPNK?=
 =?us-ascii?Q?kRoTvWKpCJG3g1J+5iS1gPA5817WcWmGHW4tqy1rPiG1YfufxniIfg9GYgNf?=
 =?us-ascii?Q?Q+OcV+mC7cSCn2hXReSXSJEDNpDDDOBRYX8WK/oXEvIPsGuKPCnqbHjp1FUK?=
 =?us-ascii?Q?A7lvRQ//WTBqSFWLJ8RntQdOp62gq2s/wOdKYWJGl/xBHrjbwy8AHQpFABxV?=
 =?us-ascii?Q?GhSEzKFgN8hzYX64AlObogC0booYbLJcmpFWKS8FK++i0VCgHWqFuabP9qD3?=
 =?us-ascii?Q?uxCPmKEhHwRL6btyFyzF0hD01c5Me9M531qgg4Tla1XqAKSdqo6WGSJT8SP2?=
 =?us-ascii?Q?rHl0jqEVgvPSNPqkB1ZNpgH0eDaSoVj154vp232j1z96BwOTo/6RPxryvysK?=
 =?us-ascii?Q?R7yrJw/VckAgixC2PVxy8eps83Eh6WKloIFDbGaA3OCqX3vpVY8bnWGur3mz?=
 =?us-ascii?Q?rMqD+i7Lpr3ossU788x012XgAla9aeJY97kbp3wiEXtXZJ/+zY4t/fohhAlT?=
 =?us-ascii?Q?IKOUUvc5IUN/m80NdHP0Sqi0wkMOQfoB3gS64IeiQ0lq8LjLjbKpE9tgd1fG?=
 =?us-ascii?Q?XAj/CozQXZ+5vVhJqfmf8EsE964H/YFrScS0c7OQme1F0LnCowL7b5l+tGjb?=
 =?us-ascii?Q?cSP7o/C4ENLd9taVGt7veNKJpDurvOW4PGlQcrL3hMNZv3d+aLHHFtx1tuEq?=
 =?us-ascii?Q?oAVSUVsC2EiLptciOMMq5QqszKzDaWulYVn474q7pAv3WUPjEvah7MtVh3e1?=
 =?us-ascii?Q?pMIVlQ42Z4ZxeqnUjC6Yx6HdMhMiZfDAIfCz1eFSGH5jzdDzrKccWHFyG/UM?=
 =?us-ascii?Q?qGROu4GYq9jKbGg9xqKzttARfvhJWa7HNhFdFpaFC0cMpeJfdh6omj7tbVuo?=
 =?us-ascii?Q?vfBRJAVnfcrHpoPoOtYHM33iIeGgk4EYPQXTq1SGiTwoPioeQzz63ekW8ARY?=
 =?us-ascii?Q?tW1IpTrvFPOWlGXWNZztSbAQ0aq+7WsKBtrtUKzatbDL0St04eTUpT9+kgQ+?=
 =?us-ascii?Q?VOURn36EW5f3eG5v4/taBM8UGLYuxzsgi+Z3wKPDkd71BtopPZH0IEY3We+I?=
 =?us-ascii?Q?pGo605wv7nYQRmSQgDaDtPvy27z8NWvSgDCmGwVIe+oPSKFVIqpNC3N9xw8A?=
 =?us-ascii?Q?2FuelD19UAXdKTvJniVV+xAdN18+ro9aZvIudkjApn6WEKC4bZOxTBmTjMBS?=
 =?us-ascii?Q?3fZfCv1D+xtwh38sL2AVjddGAsegEA/MPbrmG5oJBdqbm6IKaPRpsh2ELXPk?=
 =?us-ascii?Q?6HcXjhBgKERIT3qHHw9DCw9LAYQ17f+hM4HUVrhU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d71eed26-a790-476a-0ca7-08dce4a97533
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 19:19:24.6433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KH2YoLsOEEgrejUqysL2gqWl0S5aqbvo2UwV3ZXLllIc2JcIpoZog7BbDYvxHEEBt8IY1M1m/q81cHaT+ndXBuWq86lSQF+Z/wzuxCTVWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4662
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Michal Kubecek <mkubecek@suse.cz>
> Sent: Thursday, October 3, 2024 4:20 PM
> To: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; Mogilappagari, Sudheer
> <sudheer.mogilappagari@intel.com>; netdev@vger.kernel.org; Jakub Kicinski
> <kuba@kernel.org>
> Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
> ETHTOOL_GRXRINGS ioctl
>=20
> On Thu, Oct 03, 2024 at 04:49:16PM +0300, Vladimir Oltean wrote:
> > On Thu, Oct 03, 2024 at 01:09:47PM +0200, Michal Kubecek wrote:
> > > I'm afraid we will have to keep the unfortunate ioctl fallback for qu=
ite
> > > long. The only other option would be to only use netlink for RSS agai=
nst
> > > kernel which provides full information and use only ioctl against tho=
se
> > > which don't.
> > >
> > > Michal
> >
> > So, then, is there anything blocking this patch?
>=20
> I'm still not fully convinced that this mix of netlink and ioctl is
> actually better than fully reverting to ioctl until we can get all
> information via netlink.
>=20
> Either way, I'm going to handle this before the end of this week so that
> ethtool 6.11 can be released. At the moment I'm in favor of your patch,
> however unhappy I'm about it.
>=20
> Michal

I have no objection to your patch, I think its correct to do now. My sugges=
tion was that we can improve the netlink interface for the future, and I be=
lieve we can make ethtool continue to use the existing ioctl interface on o=
lder kernels, but use the netlink interface once its available.

