Return-Path: <netdev+bounces-192428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D909DABFDE6
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B820500B02
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DD42957B0;
	Wed, 21 May 2025 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FH4kvWc6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C32957A9;
	Wed, 21 May 2025 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859346; cv=fail; b=refkLgZxF1rU0YlZoiveWs5XbSN9cVTJljeVYLbeXmjxgEKbNSubbrQESPMHZOVL2PGLc8wVbq9H+1FMZUgK1NixPtdv0owxFT4S+EvgfGNzBgaCNJySsCSxgMhT9ixFw5egE8PquFbhbofpCseqQo2jr01KkC3y/FJyMURAk70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859346; c=relaxed/simple;
	bh=RQyYIx8+eb+7Vy6eJRa0i9vqS/0qzhThtoyMejnJA8I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SONbjxAfDHH3E39Kp8Lnf6KmkNbC1ag8Gulv+c5pwDk9QoiQAAdTZ0inopiB3Iot4exoA1jfRPgy+1eINmdEutdmjtt5GzqgEvdQnse9bSbltV0SZWbUkHckw6jCI9XgwkzoGynAEWoGipuPUannLDPtvJ7y66y278Fx3ZRKGKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FH4kvWc6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747859345; x=1779395345;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RQyYIx8+eb+7Vy6eJRa0i9vqS/0qzhThtoyMejnJA8I=;
  b=FH4kvWc6MjO1cZfWV9lSmrzGqVQQivxkMuwaXQq7MHmW9XfNzQwscmLi
   YNRTrXITsWBixgjzl659+Y1U/cRvEZSReOJM6PFCP4JLzL4MWUVoOXHVo
   AuozslB8X/O3e/zXwjAnCwpoDf4Rjb33ZumyRNpWCmwzHxgPep/J90tKc
   hPzsfp2DqipC6TOUK+syd+WewNJiMzxi7DGmW2OL6bKNxS1IpwgLLfKes
   r/qjXVJCBRKXfFYXyy2UqEWoJFNw+IbB4ZX6ACelutoKwISqpKTZcP3tn
   34RJOujKkCl2njbZlsB5k38ZwKv58utRl6eYxqX22tzwKSDj7r7LzgBnj
   w==;
X-CSE-ConnectionGUID: qKI030RaSfq/ZFxbzc631A==
X-CSE-MsgGUID: WsxwEegaS/KVNozULOCehw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49736486"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49736486"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:29:04 -0700
X-CSE-ConnectionGUID: NOQEY1JZS7ugh00Q8Yyr5Q==
X-CSE-MsgGUID: 50X/QgmFR+GXsQrjeZyJUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140659342"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:29:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 13:29:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 13:29:03 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 13:29:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxPWqAcXDTeTvj3TYBs627owbv+3Tky7WL6ea68kio+B2tarltaaIW160fqAdooXEOJd0Kyf2e/QaTHmXcr+MHmv/ZyNinqacT+OWg8IVYHBzW2NEMZfCoYKJaGt+YCyMLNCuC1Ax/naneLPWttTFl9qJVUZCmW21QVn1s2DHfy0moYEMXtDoRDnNUP8rYcIL8LeMaGm+0K+qia4BB0HPu4qk/87YiT/CvAw4+Yqk4MfiDzL27iGIqhCS4DAMnATeguYPsX3jVJZadofNGOBqsTor7KJKYCQbSMI+GvDC5HoGxe3EI0vCiXpUUVtP1Ugj9BxbynW+cbLem2ERzhYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iBvK/RmWVp3MKLt9oZ84pLyzia5lmQXgMgA57skwUU=;
 b=pBCLQAjPcVzgfZ3tE2xziWxM1iIwjFsG/OB7IR2nGHVZEkPL03x/3rA0h/3FFBN8EWn9jCp5JLsRY/byuAZYTJkQiskYe/965mTIL0ezXUsOPAvXOgVA3+fsj8jc0o8SwUDSFrIbOkkFHcAKn4O9GhA3uQAQUwqG2gRkpL76vlbsdSbFhqIv0XPSpnImuHJjav/7KM1BaCF77S28an7de3Pw+owX1/HKvuPSGSRfwvGadB2tzoMQEFwLhHvL5uUqKEG/R/I2lcnhXQ9+2FZvgojo16c79Aj+qPaPlr2xS/HKCFPkrM6VgsUq0evVcF1kwVfG7YptFViCkNFzeHvY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPF4C690C788.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 20:28:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 20:28:56 +0000
Date: Wed, 21 May 2025 13:28:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 14/22] sfc: get endpoint decoder
Message-ID: <682e3785ad735_1626e10094@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-15-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-15-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPF4C690C788:EE_
X-MS-Office365-Filtering-Correlation-Id: dedc5195-b6ea-4af3-3189-08dd98a61be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zCiQIjhzANA3LJA4lRvVs2gNa53h8peuD7MvZ2m9cRSkib5WDdUbOtJpJayL?=
 =?us-ascii?Q?EOBaFr2jNcWA+y+gdnNvXkHpifZ0BZnS57Uf2SnZvYCfbmrFXnSxRsmzxTbL?=
 =?us-ascii?Q?L0jy3TykV5q9o5BRyqEzwTQ9g6YGG8chfftfBAZ1dHVRvccth1rn1yf0mI43?=
 =?us-ascii?Q?DxB5Ec0jxKj4R07Lq4Dj5EJKghTWrIrWhiP7hGYeefsqyhCl9nByH1gJ8AB2?=
 =?us-ascii?Q?6WMYG1a6ZFT70eYQCTmLOkMAa+czxz8BPC3VEQnzG+Z6p1VLDm5fbMzCHCm8?=
 =?us-ascii?Q?5607bCVGuXAxHgQHu0Hcb57JfEogwkOmDhLT3adAlyjs2CxJfk55eRFg7NFQ?=
 =?us-ascii?Q?/3e1MAXO5PSGNd74+4SRQaGqQUmtGYv9OhnCupFocbJzLGlZvr17q4XHHS6V?=
 =?us-ascii?Q?/baTD2FO23KXKkraUBY4mdNxl32R6UgGU4SVQVfqs0Ll6Hi4XtnF7Lla31KC?=
 =?us-ascii?Q?mL67kmSpxXzxGBbwkV+RoGh2MKIYAGPWwQRNjisgmfhSkrpBQ07tQ05yTInA?=
 =?us-ascii?Q?xablca1Rt23jUF/hLXNkpKj2hbDmJ6AsArppJnOpal9bOyzZnD2VcRKtjfSx?=
 =?us-ascii?Q?KmtQWGYqSu/2+Ntrhw9rJn7BqWbjLa55SGNC9NWEDVPjJLcXf9boQ9Wc/OR2?=
 =?us-ascii?Q?60LTFfgXvY/vpPtii3ROZmcZszyGY+TxwKh/SWHr/UVahc2oGU2beGwQfo/v?=
 =?us-ascii?Q?7VWfonEhzfqq9k3VrTYLC4QHCajjguEVP4D5QVFjM92AgstQxNpM+D3dAA4M?=
 =?us-ascii?Q?anbcQiE6TyoFSIGRe3UOKdHYYvT/0F3s4LWnpmVKBOlJaaB6Q5C4a918mwAu?=
 =?us-ascii?Q?uzBkZV2bMOAOoSmFM+hMWrC/1IdXsrN7zB+Nzfqy5u0JTrBQMAazl6Co+0Az?=
 =?us-ascii?Q?TnIe7SPGHsjhEFF+h2X5WFNhQNtDDmlNIet9IgK+becnyOoLUtpyidHWsTjo?=
 =?us-ascii?Q?niuG+Wp325Lwj6QEk0CuCtsPl4Wv9hKuhIda93L4MdQAdtjq9wmIaVrULgQz?=
 =?us-ascii?Q?IjtOC/nMT4iiu6hqIUmirPbHdQK7AqifsMX+swEVcOoW1BPX4d+61m4qVROf?=
 =?us-ascii?Q?rWyurwoxaIZQBBdvCnmZZ+/+4UZQ7Xp2tW5/QU8VEXLVgosyOxMsIAcxDXRY?=
 =?us-ascii?Q?1ZnJ5tluuxu1QAju79qztITiLXGWL8jGb2mUrCTMmk3KZQtmfVT6c4Vy4dsB?=
 =?us-ascii?Q?0YULWsMEhzIdUTCRZvAfxTXW2iKanPswZgqr+ThLrXXs0clgLk9VpMf3k53x?=
 =?us-ascii?Q?bTNy0Tsi5VY7DxJMvHnYSKz6n5+Pe5Y7HCFsrxaeD9MMx/VZipojHuuFJBKe?=
 =?us-ascii?Q?OokbrNL1qFHwcB9CchedykOwQdgjqMuVBAH929QPh3vuU/40PCAx991QB7vq?=
 =?us-ascii?Q?uddSukPJLEzxnZIE/aBf+4rd85iVZzDXgWiecNRq7qRPTZt12btD+a5R7TM2?=
 =?us-ascii?Q?Xl/VSnYgsQkW78kYEfNxEPbXphJTi+Hf8AHiBUfJKaS9hWzMj9Kjgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dtr1RqJKw+eY64YRRYIFaBnsU/f6/TK6n3hf4v/O7SAnk5qbdnCX6jgXp0X/?=
 =?us-ascii?Q?sYX1RaR3OlR0+lI1WSvcLAXdBiHq2+hP428hqIajt5e/Pt1NkzvoMwAA/tE5?=
 =?us-ascii?Q?JmMU+kZFQpVH5JXk1y/tJ0bpAl2PUNC5EKXP74Mf4+pbXltQnKzuhccnCwlB?=
 =?us-ascii?Q?+JW5C6Z/XDj8Bp1sj2BtS4xZor4aTrc16T2RxupoDO6tbZPWxoQvCboo/Bk5?=
 =?us-ascii?Q?3sc6zxDhP82FNUfToCpeHwCiOHKNpra8zA3DMbgLr1W4O+vc2DvMyyU+xn82?=
 =?us-ascii?Q?KTEvutEET84vUfR7g8rDzrzJBT5mTa08K1RH5EFlXMNot0479B5qeq1TibAE?=
 =?us-ascii?Q?ldhy0C0kJv5tByxzXqtgtZWuRBYFMl4zIFKjXO7bmaXrmMc2xHUa/8UFxxbe?=
 =?us-ascii?Q?T/K6LlrxjCu1u1pUEck0LYvJCEVKO6mt2QpF8FU1ZggUjucJJemyUcer+6pX?=
 =?us-ascii?Q?edxeqWK5r6CdreXvnlgmvJLm3v5P9XAz/jv2Z5k9xY3GyqqPfN5INFt1k58R?=
 =?us-ascii?Q?q5W8iwpbbjdWfdrmiyuY4QuEfeAMHRKBN6qSGoO4f5W1rGFjstL091NRctFW?=
 =?us-ascii?Q?Qy5qO4C8up2GN+Iue1AqTTdKXOmUhgrI75hRYG1Iyq8djcn69MUn/krNfyqc?=
 =?us-ascii?Q?q7evRTO+EzFA5V/XXBv8W8QlZK7Bgl2usgwsg3xq72AxPITP3oJKw+206kOM?=
 =?us-ascii?Q?NExfKlBAQRnh2GVfsl42IvntchCxDr0+/f5wMGArvsTMUwAS/Hx+fdWm5Jn1?=
 =?us-ascii?Q?ruwjKHEHKK5YvUCqbIEpzmQm52fYcgBzjqaeLWpCl4n35cYynBJlHzczT1OQ?=
 =?us-ascii?Q?M6+SHxzkLc54ItkURkdN8FHXNVSCdUcp7ic8cwK090YBEJBBMrZ6fysPAR/r?=
 =?us-ascii?Q?hyI4X4DWJRdc4Sp9pCohW9Xdw1qwmEC33zoA6Emz9HiZoqgs5YW+TqeYwcjD?=
 =?us-ascii?Q?/CQIoYmNCzgsauvRyNAqBJd0WYmjFbqd2As70a8VzPQhFtZUy0JlcNnU66Ke?=
 =?us-ascii?Q?UZGz7Eeu+XEkFBOaIXZVw68831KRyMdGhDj7X18sNOjlhSzGLrqLZ+gUkwlB?=
 =?us-ascii?Q?4acv9FEwIT+1JPxnmnSjDk2L/RLJRGbrXsJJDbf7F9XOmVsJEGTeRtKIwPT+?=
 =?us-ascii?Q?o9Hp+VuyDfYHR1ZmaO2WetgghnR37Z/pfBMZOUZlfK7WFZcZjK52ogassQCw?=
 =?us-ascii?Q?McBN918PzVBH0CoFl7xaJvjeielgdSXhonZ8k2mLYQk/VeL5aJTtSk25wiBr?=
 =?us-ascii?Q?53F0F58uHsRVTDKI7Yi6ylndv+EF3nolnW00OfICTSRSo0uSn+RUwMC7IG/c?=
 =?us-ascii?Q?ePE9YUqsaqCIEKvLJghIIeGbSHssNVQ9dvhMlwUVz3JSo3NUgWSEapN++U78?=
 =?us-ascii?Q?twiID1pSnEVz+1ihaJayOgIdRNlIeLixUZO3thFMUBdWLeohI1u8z0qZmnB2?=
 =?us-ascii?Q?ezfBL7K9MdRy4kb1rgumEE+rIBgW5kFeFTcThY32C0MlgBgjyuyBuEB8pWeT?=
 =?us-ascii?Q?RJtZJOSWH8CSmi0IirVXtdVo1Dny1mAJpS0ckvW8uHCrTkWVV8tJRWBOgE7c?=
 =?us-ascii?Q?p41lqzw76DQhvFi9V1aOFbvzLCd2vwWcGNQGffONiFvWmRScRX+B1cb6Hp4P?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dedc5195-b6ea-4af3-3189-08dd98a61be1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:28:55.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwGy09ww+Poj/jSjgfS//rT2VeA6HLi+9NL64E0qnmszcoy+8nZDl6t6bYfU0m0Ti3bihyrc8wD6ZBz7/HVsA9EDUcv5LBN++RKKNVSpGbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4C690C788
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 5635672b3fc3..20db9aa382ec 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -98,18 +98,33 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
>  			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
>  		cxl_put_root_decoder(cxl->cxlrd);
> -		return -ENOSPC;
> +		rc = -ENOSPC;
> +		goto sfc_put_decoder;
> +	}
> +
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (IS_ERR(cxl->cxled)) {
> +		pci_err(pci_dev, "CXL accel request DPA failed");
> +		rc = PTR_ERR(cxl->cxled);
> +		goto sfc_put_decoder;
>  	}
>  
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> +
> +sfc_put_decoder:
> +	cxl_put_root_decoder(cxl->cxlrd);
> +	return rc;
>  }
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> -	if (probe_data->cxl)
> +	if (probe_data->cxl) {
> +		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_put_root_decoder(probe_data->cxl->cxlrd);

Again there is nothing magic about a reference count that keeps the
allocation valid until this point. The endpoint decoder could have long
been unregistered before this point. All the reference allows you to be
sure is that the allocation backing the object is still there, but
cxl_dpa_free() is probably going to crash in cxled_to_port() or
devm_cxl_dpa_release().

