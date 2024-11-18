Return-Path: <netdev+bounces-145816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A849D1080
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D864A2835C5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC72198A1A;
	Mon, 18 Nov 2024 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxh3LCTo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806719412E;
	Mon, 18 Nov 2024 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731932441; cv=fail; b=h7LKEj0HWZHryU4g2RJVFHPZbFTn6PllwWWd/MWdfZoU38p7DlHS/qZ4ZN0RO624hLT+1Tkm33YAnS7M8Swobs2X5aiOiIiwwgGr4hjYMk9XUHDIteT7WQPmexp3jI9Cluv7dS7lGHwSB3+eDa0xECybyG7tKWmFSSf5rimjhaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731932441; c=relaxed/simple;
	bh=mcNMUM08k4tvDE4Stgdu0J2tkRuKjKWP6TGhi8Lq2tE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tCgIZsotA6cu5xq7EUwVyY6bHK74z2U7kl1jYeP/fO5aJkUgXY/HgT+/rYeZ9ttpPUxmoY+wVIrn+U6fizsGb++QimgQ7i82EKfcgTNMJ6Gg/rg/KbX/dBiPZits1ayjXam72zU3hu6SSmwLS+Ej5hZoj8sd/k5jo/gycEDiTG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxh3LCTo; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731932440; x=1763468440;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mcNMUM08k4tvDE4Stgdu0J2tkRuKjKWP6TGhi8Lq2tE=;
  b=dxh3LCTos+o943iQUmwXxlH6rwgwoVioI3zFzZm5mJByNAF20RvKDRNB
   CXVuHsUD+HiPgyhk6km6EXA20tWYX05mlPvw+zTJzC/9iGNj6cXlpI6L6
   Nk1UG0wRpa37fajD+ZfcUDoNKcfRx67WsyxXsUpiEYhwrlGJMr4Sxl2Y1
   n8Eo/NOhyQBXIvNX4FMGSr9MUCiCwt5DGmcWECIb1wIEcjJmvaKQOjU2+
   sgZyAPivUMME5wXGywGTxzXE7Gf4kelxrzpzUo9nCpo28YcVYMomIbfIS
   Tf851XzOI4GrhmgyfAHjbNG/kBTwx2fFlKE8zazsAFxgfE/4vAnN6qdJh
   w==;
X-CSE-ConnectionGUID: f0nwLH9bS3aGsVO1YRoIYw==
X-CSE-MsgGUID: xI4sl8vOTNm97HdQx7AvzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="43271916"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="43271916"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:20:40 -0800
X-CSE-ConnectionGUID: Ji2xk+L5TtO0BNvMQ2VC+Q==
X-CSE-MsgGUID: KsxupczLQC+amegD5lmFqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="94164619"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 04:20:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 04:20:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 04:20:38 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 04:20:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRuQMl6ZRSu8ac/LTZMxBKiPZ1QrwXSj+o/AQnqO0PvEMHpNPPm4j2b7xBvUIBKX+6Zi5elNVZ+/fNpQQ6z1j/DVylOJ7BZkuS82uTihBj7jtlksi5245SltmMbH/AvH03MDZBY7R/mEbFFMuWDGMkdkGZ0kKNL3t9c9PVvnNDf9gj66HlaPYF0Xm0yydvtJ+Myl3KZER090Dg+jXY/5Y/YkESqebfqAWvIYt/qBpoNahfC0g/ZP002Ko0IleSeAampknD8XREc6lCOk1LrnpWGu6x1ie0PtC9METMYwIgaVn4pK+MZzvC1hbGBJoQyHdZtaLTyjATdR9mKlwFU7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iMp9G8so4RW1YthPnZgMSvORvc0KR/RYFsRyq65oKY=;
 b=unZ47nCovxvcTPdOrpNhChupul44H7mslgui9mi3O48hKyXtGvA0uO3nmdH3tiescWvf03BxKvpNJUn7uTrgpdutUd1CxN8T63Q6nU/2ti9e99Y5X8UQ9zSpTOPoLTfJ1k3X9iAh8OQCjTSdVXiqaiqKVbZn6QgUp9pUo3m4g+MSQJ0a5HNQvj/+PtkYQ6iYqTuXm5FBKHLnSNwNgrgLRuiESznzgVEIAhkeuB2fyBiEBC6w+7rPTNR6InRJvtVKoWLzAIXEKRyFMyO2+QdDlKtg9FmqggUCGyDvGJgtLWTobCjAM8bHzOmXbBPvelCuoypSspqBn8wUYYY/Ns9vIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 PH7PR11MB5796.namprd11.prod.outlook.com (2603:10b6:510:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 12:20:35 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 12:20:35 +0000
Date: Mon, 18 Nov 2024 13:20:30 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Breno Leitao <leitao@debian.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <paulmck@kernel.org>
Subject: Re: [PATCH net 2/2] netpoll: Use rcu_access_pointer() in
 netpoll_poll_lock
Message-ID: <ZzsxDhFqALWCojNb@localhost.localdomain>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
 <20241118-netpoll_rcu-v1-2-a1888dcb4a02@debian.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241118-netpoll_rcu-v1-2-a1888dcb4a02@debian.org>
X-ClientProxiedBy: DUZPR01CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::17) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|PH7PR11MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 79765cc0-0e26-4e84-9c2d-08dd07cb67c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BHQpfbD2BQh3VI7sdXpxKT3t8AhrJ0qlqAteXb5Xirn+3Y+kXvB2qNHXkAWS?=
 =?us-ascii?Q?aAe7o2DpW87e6R12Ah9kABUIXIcdV1kJMyCFz/dLe1g4FdGySUTasEUoEMQv?=
 =?us-ascii?Q?kPGIm8k1j0wUG3FggMWvKnISu2SxCse5nSRIw3OpKo1/gHcQWWMX+7Y79osn?=
 =?us-ascii?Q?aEk0Wvde88/srxkxoaafNKvo5LFIqxhcARYMSAYsBcEqpxmRWRpolACM3bvd?=
 =?us-ascii?Q?SBwplOeqWCcrM/8pgWUPjSD5Sz7gKC70az3USp57lrqTjNLh1D4Z4gIcGqSf?=
 =?us-ascii?Q?B0X5dS9Qg5accDaUH4m2AY1xbpkkpWb4AAJ34zdidV3Qw5u+37PHNYWYl+Hd?=
 =?us-ascii?Q?WWLKgg1oxUkFCchhLu8lR0Ko+ORQJY73KgokP6jDVHroknDbIGDdSEKZ6oDk?=
 =?us-ascii?Q?Np29a2qNTrZI7yoHTZJa58jFM792V1ZZJ/n00wEFEv23Ms9OhzEesmZ5Ufff?=
 =?us-ascii?Q?BsjikTjvrk/RFvfBhufh7wHc1hwp89HPb/i5gC3rskpbI+ZPDLnbBonkk4Ti?=
 =?us-ascii?Q?WyToAsP0+KpCJJmqopG0uVEfHqOHiYBjkaD7ZutM8ocUdpvKmtPkSsvFrPMy?=
 =?us-ascii?Q?bC4nPPb1VatoM+0QTD0B9a8dQeg4BOuLs2V8Vrp+aL1FRZ2589xxG53e78lV?=
 =?us-ascii?Q?G0oUAijl0gsvAJIBXGWXRDg4scDUXmqpV1wNKy28z+ytOx2XEuW0umgKdDjD?=
 =?us-ascii?Q?blKciUKpQYTP5n4Bvp/buFknbv6wyfAUK3ONwEmn/4dEhUtFD/gjRZ5H21D9?=
 =?us-ascii?Q?DqaItJZD29NfkqKjaT7W6Iu18/eQNaVp3hIjXfLecinfIKN8mp5DU+Bq+zHv?=
 =?us-ascii?Q?PlvG7lYzTDtlrLLLWiyN9Ym/0MPvPsiHbFBH45r0tIgSXkIS20GwBCL7no7d?=
 =?us-ascii?Q?lAUc6qyjgavRF1qEA/U+gLI/rLLbtdB1SqQ+k9RILq4wcOWL3c1hnGeUt2fb?=
 =?us-ascii?Q?cUK1JdPLxpJg6n8ouxDM6ez2HKLFJlGlRZYlRZugxZyowz9aOM7Vd4W72whm?=
 =?us-ascii?Q?x6RosJpQDTxjbDwTleVgeKahTr0NU437oWPfoaqfBRDr6oj3KaORKmKIoTeF?=
 =?us-ascii?Q?oogB0ZE3Wk9tbTQN+iqdBir9J+t+r9LnRV5MnA9D0dPeTIxkR8o5ESEUXZgD?=
 =?us-ascii?Q?d1ziEE9rbJ5nsTZdf2pAehbf7Fr/VgNeEJdiO9mmy5VQfuo3o7rlpqKcGAdo?=
 =?us-ascii?Q?U0VAUD6YqCxyGFaQNeiviTAyW7cw1sn0SNXoG9OpPWaAaYl4fB8Tq9oW7Jro?=
 =?us-ascii?Q?6rlMSgflkI6eIZxz2arEv1zK2OACKzwHBfJGSmBl5T0zK0s+/43Ial9NpCnK?=
 =?us-ascii?Q?5cWkmZV5Tgt07FXUNcefcW+R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?50jYeGw0GVURyod0K3F7Kq1YhrXIV1zQtQaOK0GEMrPEl5XESXHcabVzgy2H?=
 =?us-ascii?Q?Tfg1a89moEMbQ/758YOOLPUFHBi5CSG2ES1a2gAtOCgc27DZv/sCJ5SFcrUs?=
 =?us-ascii?Q?2HI7FjM+acZoXnHsfdXdbL+O7JCoUm+pT0YRsOxUkTUOKLJgr1jlhn41cO4s?=
 =?us-ascii?Q?NA8+r5sHQr1aqDWEsS/QpQD59YN8xTJDneV+Q+gHbSX2L+0EJLzz9w0zZWaM?=
 =?us-ascii?Q?Bbq60neYK9Nx0yD8ExS0yeSiXYGJr1fZ6lGuLEcpVmd+EfAqz0bW+OwgndHm?=
 =?us-ascii?Q?PwjdTq5GUp+1L4K0x+iTEKEY9S60he0aFl8NAtJaka2sC4o0IwRmalr56Wgj?=
 =?us-ascii?Q?Ff0R9arMMjG3Ob8nuXCTPGy+3Onk1ns008+7wIqTNVw+Jkrn9w1ihZdHB+mS?=
 =?us-ascii?Q?T0CrCaKRIO2eS2c4OwX8G3L+kWl+NeHrwbeZxHu9ZqvnIk8yFY8ShoiabZDQ?=
 =?us-ascii?Q?XiJzSstgzczonNsciVRGS4kSB8/MRUgIAmZV0r1su78qeXlVBiaLe4TCvVbj?=
 =?us-ascii?Q?C20YIdKPGNLARbvsygTGxFW28mrFYg8pjf2F1ma/HHC5LvpkGZixvFX5wLmz?=
 =?us-ascii?Q?bXYVfvGxGzRIZAJPP124acUNUzQRBqrDEqUzTqElGW+8VJFkp0W4dcp/lvLz?=
 =?us-ascii?Q?sY/KRZ6XeFamU43Q2N7mLkoALBK2OM6Wz8IK6D5EJ4TfqLePB+OOsTWzEyDD?=
 =?us-ascii?Q?cjuVmrDQiAgUqVJymOQGRUO9CTFgbYK8yBR81+3qfUmhgMPLONYtBrGXVB4r?=
 =?us-ascii?Q?qS6ZTpxiLhNqMnf7tqjbAdkRKM9aa9xyn/3fkJqzuVDdXA+JpTqicwXN4PSW?=
 =?us-ascii?Q?MBiqy5m6/17wDLelO3j3gnmsR9R54aSUwMWS2hpnnT7RIKV5WoqHQJkl7XNe?=
 =?us-ascii?Q?O1R4WRZEtjNPLGo1DusvDFkI+23KmgHHc3ME4vMih0UnQots/795k9SPNlvP?=
 =?us-ascii?Q?lYyryYfUDCWVJ8W7Xbtlfmx5M3jOx9q7SomsvlU8FtEZrKY8y9fktHrh8D1W?=
 =?us-ascii?Q?/cngBNuuawy3gCDaqA+s+6iepQ0jg5ZFK+xybbA5HN6dpxfO79N1xKp3RjxH?=
 =?us-ascii?Q?UD6Jt5QPZY/1/+XMVpTJwPaRpLCvAEy9hVd03vacYmOAbPzwoS3IRu9Z7NK4?=
 =?us-ascii?Q?9nJQ2Smh6dhzFfoB40PURIeIcuF1NqGJAjcDckvpgnUT+GR6HsGRJOeyTQ+3?=
 =?us-ascii?Q?9LoYdzZKwOjeRT5CEGbsUqKgKS5KJ4UMUnBONMSDQiYToLiBkmCFfYXTkKwq?=
 =?us-ascii?Q?0iyc4Eys5WRJS9KioMOrxwIZ6FSUFY+lzBOeUlhZw35P6QD27XG+fJXE4ikQ?=
 =?us-ascii?Q?6At7wD/ouOVSuQlgxKP7a1aazDYG1l3HShaOib3+nbbZXaxQWOu2Gp6siBxo?=
 =?us-ascii?Q?2FURLWMIKKk0ukErLsX7TUgP1U+aaLbGZ4qD71TrLfZJ06H1wbzs2H/8e99c?=
 =?us-ascii?Q?tBC78co0MsghKcMEFIS1ky92L3rvg7CEW2cg6owwcPHTiqQjOOY+czyvkSbV?=
 =?us-ascii?Q?pC3gJXklB0n/pdnCW0dgY93SS6gub434l7dbaU3Ks4Fi+92oeLzTnVUZ2ZeE?=
 =?us-ascii?Q?6lhLdCavnzmGzDCmFec5zDVG3pJAJHU6QylKTZES+SyATRcBF1/NZE59US8P?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79765cc0-0e26-4e84-9c2d-08dd07cb67c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 12:20:35.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuYGbKpOc9nE6LeQ+4flSjxWv5hRNwpzf6B/B2mDb+PYInGBgC7JcUUtMfqtqPs2jGQZlnvH7ogO3Sw7phDNoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5796
X-OriginatorOrg: intel.com

On Mon, Nov 18, 2024 at 03:15:18AM -0800, Breno Leitao wrote:
> The ndev->npinfo pointer in netpoll_poll_lock() is RCU-protected but is
> being accessed directly for a NULL check. While no RCU read lock is held
> in this context, we should still use proper RCU primitives for
> consistency and correctness.
> 
> Replace the direct NULL check with rcu_access_pointer(), which is the
> appropriate primitive when only checking for NULL without dereferencing
> the pointer. This function provides the necessary ordering guarantees
> without requiring RCU read-side protection.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: bea3348eef27 ("[NET]: Make NAPI polling independent of struct net_device objects.")

nitpick: As for the first patch - please check the tags order.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


