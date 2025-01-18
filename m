Return-Path: <netdev+bounces-159510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10535A15ADC
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6C0168DD0
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B01BBE4E;
	Sat, 18 Jan 2025 01:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMFAc8nt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C69136E;
	Sat, 18 Jan 2025 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737164005; cv=fail; b=bLRhKKoaiv6gtdKVJePrXuurBUTLmCKH+f+0+H9Sb4E4SmDA2rS6e8Tayg6DEPS3GvhydHIaFkprNh5BpmPCTn6l+u9bVULormvMC1ZJ9aJhf50/5KAKUg0YJdlF3OlaST2oA7H1EbW+DDwYRFpGqa+jiiEG4Ep23OBLu7bwgjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737164005; c=relaxed/simple;
	bh=7i/+4JiqxoJVeQj0zzIcA7C62bChD7jJharjy2npwlI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k4P3YpCP7u970EKG9Sav5NqMShwmF5IUpcSRG25rUJKsuTi4/e3r41QGZXLk/J9jcZ2NQLTZy2k4WcYfDxfs+hj8a66NZK/TI4yAwGfW8ReRC6CLKpVz2b/vB0Ai7AsjUJOQFBN2DXUFHWS3gF1BjD9OpmnEE7GNB2W4R+/+RRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMFAc8nt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737164004; x=1768700004;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7i/+4JiqxoJVeQj0zzIcA7C62bChD7jJharjy2npwlI=;
  b=AMFAc8ntEbKBH5ZE4SxEUeGk/hgXzpcsHz9qiSyVKOdfk9mytfVf8eRd
   dtW2RbinT6emvaRueXhlQcCyItAvMb9N4Kkll0nNlZsJsIfa4+50FPn1d
   y3jNj/rDXA8sGxZl+y2SdjeBnyROcfIQ8Q5roTyLlaSYePEOXxZOZueGe
   WQ9IGqECGGd7LGxQ2gQegTkWAQCqpFuafO2gJSVg2jsGbAt67OcUqc+Et
   m0J4Ak7ZDhhbCr+VYdaM0zwXiSEhd9i5PTzJ8STCrwZCpbQPCE4HYDSWs
   MHvE3UUrdgN3Z+ggEhLNv5d+O1+7ptPSmmh2VsCNQ6O8jNj6EvSjkSvn/
   g==;
X-CSE-ConnectionGUID: 4wjtjM1aQS+sKj902oFpUQ==
X-CSE-MsgGUID: Io/WzpclQ8G1Cdqr19U+0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="55167180"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="55167180"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 17:30:51 -0800
X-CSE-ConnectionGUID: H7UhZF7ZSqC63piBmKQPLw==
X-CSE-MsgGUID: eodLaUgdRkO/6+QOn/4KUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110584694"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 17:30:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 17:30:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 17:30:50 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 17:30:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJSx5/14ov2gyUwoWsytQiwk2RXtQqKmU7ev5+6jJA5ME8nRBEmcx4m25j9l+XCs+X4QeOs0Hc9t3cE+WyuqQNwMW4du33ZS07zI3gtla2kQTH3GwXfr4SVLto/Ef9Mq5XdYfAEyrVBYumfrQ9ikYxWtUKND6KHM5smFy7rQRorBlG+/HqiT3w5oxzAAsT9gLkZcPUTiq0dyP3Y9YuHKve5OSJYRNOv3TANGqudi+Ud+oigsmHgtzW5iet8YEU8gdftVt4GxQkr1TjXMuwOahuUvKOYbgdgggt51gKEsZ0vl2zGFW3NodUospgzMIgESCPHQV9xs4K1jx+9TtzhWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRd7s3yEDVuJWkuYC8fayVYfG5xvLg0jynxkrNZ9ETM=;
 b=KsBPsRH30KSWfR1QDD3Qx7I12cGmESruzL6A/B1arRHqOP16SCf8KeYPGJvweEMCyCwiMuJFpDueKwMv9UDJWtcwy0jL3OLyr0IrTTbbEAcWPZf/RNAeuOKKBGQndzwVfBwPB4YzFvgQlXkkO6vna4LowD0NJYgDgXs8yPpbwN0xIHdV5lK5cdwpVfGNjwzPBHsqcchbh2XTJdrbqVx03CPYr7pC60qafeyov2VBTBG6QwoygRENHc+lvs2EtYBjZAWMaR8f7Lr+ncNGMzxQpeMnvWct2Vpr76gcoZ2wjElBNqBkCf4i6buQVfJhaCE+bqXMZTxl0ioicHp0nsehjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Sat, 18 Jan
 2025 01:30:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 01:30:40 +0000
Date: Fri, 17 Jan 2025 17:30:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 02/27] sfc: add cxl support using new CXL API
Message-ID: <678b043e3b876_20fa29423@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241230214445.27602-3-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb34353-dc72-4ec0-b8ae-08dd375fb808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dbM1Hlz01oR3AJUH44W9MJPgaWhlxwhBdrMt31kUaWIOmf3qJntHbHP7gtzz?=
 =?us-ascii?Q?44su7xvgbAGlFRT/jLa6W5GQ7B5AtQUQztQVomT/Fvc/D3HH/9CMHlP6C1Qa?=
 =?us-ascii?Q?FrU//Ck929OCcEFJtuIuj6D6LZmLgw0PiZc2YB19IdgBc1kaK91mg89Q5ycS?=
 =?us-ascii?Q?1Hc/aU6NQ4OKuo6zNYbzdKhTyNWeW+DEpmxUD9TQDD09Xviz6aAk/Cri7rVa?=
 =?us-ascii?Q?xSxee5rgPhAo7qvz756D/TKFSqZGC1AtUG/j7UAqtH5/S7Jvj3ADYqlX2Sdh?=
 =?us-ascii?Q?dgagbo9qBYHWI6EdH8BWPguw8kIwQDxPWwS1aqS3MX6svuRBp/waDa1+lY08?=
 =?us-ascii?Q?DqI9oZBp9w0pEurc7ZppLZANydYvK89VIm62ID9yH6SkKkskEj4vQmUuhCVr?=
 =?us-ascii?Q?5g0YclfNy8mM4TL+4r3C/Pm7NaZCpfozqywr5gSabRLR39q2YLw1278n7883?=
 =?us-ascii?Q?paSqkBtRxxQcijjhYnlitGj9UPfvHrwnBlRQ624CWrnTt6zX4kgYQh4qqHYn?=
 =?us-ascii?Q?3tFWWzxCZXRxrwzKQWG2FCcoaZLLooJJCSvUY2hSBHDEfKZ6wbkAASL3IxYb?=
 =?us-ascii?Q?tOUVDvANxiPoU40nKZLuN/4fUQOwoDhJhHazOeIQcCOmz2T1ZBnehAzDAXst?=
 =?us-ascii?Q?yNWwJSOG5QqQvfTxmAhC136tLYHe/Xzf+VCoEyfRGuGtWSQY1OkgjuXqahch?=
 =?us-ascii?Q?t88oefBdaXZw7bHfRm88zrVn4g8RMbwCAqDhM2nJHr4jWvnRtH4Kyg9vRq9w?=
 =?us-ascii?Q?E8q+p1QNfNKuKlRfw62cOBapsuBH/+bsrZxXVWaLexjBvUqMleA+soeQNrNE?=
 =?us-ascii?Q?w/9tKE930raVVQ+A4ZjxYATDu1zzfsH6z6fqm9W6X0fSBE+7vfHTbIv9veD9?=
 =?us-ascii?Q?/Z0xZTaRoY+IArMfH792bRMvk0KoskwKpgKX1vV/tcBsdeGjosk7hOW401NP?=
 =?us-ascii?Q?1DiJ5UjjrNEdjWjThpXbGZCBjLjyjMuhDSlLlSBXV5/AfyxhhpxYSpfVyoWO?=
 =?us-ascii?Q?nljsTBZ5EEpTPg9cr9v7uuL9bIgbIwx7g/WttZzoDSre0/d4S+uhpw4TPUWQ?=
 =?us-ascii?Q?ZFOO8wal/e0C2aWcVqusG4kWpVMOjfwJzHAKGZBMcnS0CX1fMFI1/ptIXPu9?=
 =?us-ascii?Q?64O+I8xwa5VSridATD8NGse+ItlBC0U3NlHWLUED6hFj7ZZLaghK84eRpotQ?=
 =?us-ascii?Q?l9whqSQdWa6ehzCq8stPnocDagEoAH8YFixqxthUj9IviK7wt23Fp4EnMdIT?=
 =?us-ascii?Q?XyA842je272/lsWr4wCEO7wy25P2MefjoUS5e4YQ/fFKg5Au/JbIfOampixS?=
 =?us-ascii?Q?ACN0L94Wgp/9xiExt3yOWhYOkRjavbR2vsm/Qzq90tHHm+PYQggIB71pfddu?=
 =?us-ascii?Q?t9WO3aEvO7RN2NbIPOrDVymwnjl0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NDETwiSpmRP56hZ5O4BYXiz8dxzq/PC9fwj2ty/SjiuS8LtENVRcVKW3NW9h?=
 =?us-ascii?Q?O75hAXiy8lfoDIZB7oq0duaonTjZ6wd4SAG3rBxTzqP39fagIhfzI4xvsKH5?=
 =?us-ascii?Q?1Jr444yBgxpKMH+/AJ7s10tDzO+F6hH34VwFTMXU+cYvBpDXFR0byjEyS68i?=
 =?us-ascii?Q?Mv0zrvrk0Alc07udPB477qGr5uCgXVPle1P3DX3VnhIRvI8AiErNh9PW+YLe?=
 =?us-ascii?Q?wCCw4FmmRUl+NrqPYbSg+uPq91cpWLYH1/aB8vpSvklCahCUl432m8ru2+Xi?=
 =?us-ascii?Q?qagP/GpqrtAS+4J+ufnyIKHXQIrNfTiDAf+R75i++hvIOiFHRFjmB5aHJcpx?=
 =?us-ascii?Q?jqckn7NUG4Fjzuq9WDuYZW+UlFSPEq/6ZgH9klwj4NZkuWCKZCllr5C1nUoM?=
 =?us-ascii?Q?Cl/dk3gYGt93KhmMlBZcvsj/76pOzgAybDfT5A/DVx78VFYM6IBgu1Isk1Nh?=
 =?us-ascii?Q?XYWh++uW7oPxglpLFROPCtGDLj/rZoRvHMU3r1sMKZe0WW6GVQqiKgP7MQOH?=
 =?us-ascii?Q?uvso0MKeYPI0At+US140xpIRTWw5hQvtFQm3SyqrwvK1MV+9GsMeNp4zQHWH?=
 =?us-ascii?Q?5mbADLIxE9rpqbH0mN8iIsPvYxh2Jr8wtn8HY4p5LZD8NUXniBoVIUzkDynM?=
 =?us-ascii?Q?3OaYyBHFPW7Er3so1Lie9RvIEOo6qcFu0NgFSIEJsML2Imc+WSAubrIF0fmc?=
 =?us-ascii?Q?tQwgSxGo4MoFMeig7pcY4fZcum4DgqeRztIAcU9q8T8m1TVnJl/zW5OZEKOx?=
 =?us-ascii?Q?/sVo7Z6RIXNtxb/sMyg4JPv3oxL+gqqAU/fEuMBIkvH4lALf3ASj6lVicZDy?=
 =?us-ascii?Q?uMBcOA6cpnS8V7YKvs+rvRjZUoxgJZmlc6rPb1R05b+a1OtpdVohszBcscCE?=
 =?us-ascii?Q?TVpFS7nkAlwqkyBuDS5mtLRaFUHcc8m9Qp+4xkcN8he7Q2S6hBWxopx92rnK?=
 =?us-ascii?Q?sJut11wkSif6KxvxtN6pEiiNLdMyU6Sz47YtLJmpExoPUclAzZSk9vmbSjHX?=
 =?us-ascii?Q?2ktkraky8Os+/pOHIMOrHmsIUGWBy0hBN5nWjeTLJI1djsVWelUHxvYsR5qW?=
 =?us-ascii?Q?VBb9+PPG4jXatj1nyjQW0ojmXpcoytDP2DkegwpEfrCSzY2yyunoxqSL8cpR?=
 =?us-ascii?Q?r4+p6ihwGADpGENQF7LmsYC50eWxqhS2G0IfevM+qnQiXuS5eDR88oTZqQzn?=
 =?us-ascii?Q?O79vUz7fR0MmLXjSatEqoyJd2TN/gw/bApj1ca8+R8TAc0VBfLfS2lJF+bar?=
 =?us-ascii?Q?6GjWKvFzwCTVILj4w6/3rJKCp8a9NoeUyrjzrv5pIavfrvS14Z+aVVeNxuXH?=
 =?us-ascii?Q?cmMCS4+E+6Ctgp1gQfJ5L2VRfS2y3vzsm4ysQRnJNgRY5wDgb4NKp0hy+2Ur?=
 =?us-ascii?Q?QEAxVaa98abqMtAARezahlnLxQ1KF8XD00gJCpq7tg8zRXPdIilaqwLajoNk?=
 =?us-ascii?Q?qT0W8D4c8J/ZvfxXvnapXkz/8PwsvS9lJt/wtAnBKcysX22CAWjIzEX4z7By?=
 =?us-ascii?Q?W8W5ym2ckLV5pF6iU4JyE/d6HNO6Q9oIjkyAPUSC00lMq23cE/3/l3GP6+Eu?=
 =?us-ascii?Q?iiY/aIsNGWF3sZ9+PwJJM7kh/oz1d4dbYfY/xOV0zFCpw0c7B+KA8p0ACbFC?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb34353-dc72-4ec0-b8ae-08dd375fb808
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 01:30:40.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3fTTRhhRJwdKwX/EHgZHGfTLcVlwfnq25Z+AmkvGSQgEA7VknEV7n5OpyyyxusFPzcIhR55y2zYEmCma+FpEh+EpV6tRZruh/yigJyO2mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig      |  7 +++
>  drivers/net/ethernet/sfc/Makefile     |  1 +
>  drivers/net/ethernet/sfc/efx.c        | 23 ++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 86 +++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    | 34 +++++++++++
>  drivers/net/ethernet/sfc/net_driver.h | 10 ++++
>  6 files changed, 160 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h

v9 did not pick up the comments I left on v8 of this patch:

http://lore.kernel.org/677ddb432dafe_2aff429488@dwillia2-xfh.jf.intel.com.notmuch

