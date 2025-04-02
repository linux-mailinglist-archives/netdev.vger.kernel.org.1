Return-Path: <netdev+bounces-178836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AF1A79216
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3852C17027C
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2220E70F;
	Wed,  2 Apr 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YAzgGvvi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F52D7BF
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607440; cv=fail; b=WNgGirydgHZgwsnQO+GhAXUaazoLc0QuPPe6igU96gU0/960fEjmWn2PQclwyvjkU00L6b8CKzPloVBNuPrdCo+1OwIA4THiS/eudwNZHsKq9RI4yDFX4oOIxL1OAtIpIyy5a7toiWwql/C9lHy4hGLC8XJ9Jwx95YPbWiRc0pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607440; c=relaxed/simple;
	bh=QTSBs7l8YY8MsWfD7nyNgDpmc/fAO81saoZdCX/xtzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QjsFYW6uNF/utp6QQfRsNWXNEijjuSMf2Wc0p4CWkM0SFSC9YLRh3LDnNjZ7nCVkMdaH1RAggu3Q4OzUVfznkCh+9ps7+dbEN50T9skWNInhqwakDsiHeS9RGFXI2GkCbgOap5mDN4ygK3/kWUUcrDFr4UWXuxHOO2GkcM3Ti6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YAzgGvvi; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743607439; x=1775143439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QTSBs7l8YY8MsWfD7nyNgDpmc/fAO81saoZdCX/xtzg=;
  b=YAzgGvvidVm29T2JeooLg9egcSUkyPb5EPG/pOtbXLr7s13+E6C/Y2dO
   vck+PL5WkixtemHOVaQzLPiCoq5gxQqkWYDgFLJw/QcpH/7QtUCUgtU/R
   yBGzhxQcFm3qk+RRyd2jUmEZGXlBZV8e5O0w/vqLnEDQijMwghERYA2me
   ndEz22pW83aAErLGTLQO9HbVTK54sYrFDf+OA68yM58hopb22+700PuEg
   ato4fI6tg03nyQJJFnNOdvun2EEOToDS5h0iLIim28mAa4x5Ufzf6VVs5
   iShMcbm/6UKl+/UKgfzAA0UljAFNWXrbcnPeNihg0MV8iPxXht9xH8al/
   Q==;
X-CSE-ConnectionGUID: obxZ118BT828hXUoi0hIZg==
X-CSE-MsgGUID: tLr60l8ZSzOY6UHPZmwl5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="67446317"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="67446317"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 08:23:58 -0700
X-CSE-ConnectionGUID: R011ls9YTOq5yTvPKohe4g==
X-CSE-MsgGUID: dH9khYsSRCmectMZxA2KrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="126691397"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 08:23:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 08:23:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 08:23:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 08:23:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieQ3+FcSFEaRmaw/3aRihzBfkjX9RwbkBrhjK6sHe24Pr84kSdcFKgBcBwEYNFO07EacL4E53QqIqglibAD1GQhwJTr10PgSLwp7MJUNSI8qTx5RHwRDh+Qken0MIbn5aCRJWeG5vNZIxphQX5KfZ6Zvrd+j9jSEaNZj6io0R7CP2C+HMkDJlI1GqdqFwXbN4Lf9nspWjSGt3yVRP4k+ASsKGKsaFj8apdhCGXZsXQMecpNi64q+LWDn3pZtDp345AjLigfQaAUA9Z0UGxNgKDrdFksUrDlXRCcLMrs6DJ66oe4U7KgamL4UjItPH3ev/twmUGlEvXOxoImnPPvgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5qnGtmJ/HhKa24tO1AFqRTITSBeU3T3U23uI/xlrWg=;
 b=c7YK058zDzU+3yhmbTtGOdpgkBx8/sjuY+YFr/RdiOsrWhUTnp5ZIidVniwZfEqwZre2hF8HTvhyGUG0jdU6yRwyz0dyBDfjBZwLCDSnktk6CzIdGhZhWBL7cyKO1P8vvsk5JDZkGlPfhegENJwNb8S/wQuUmDvnDqDFCBcjw7F/w9PQT6z27qXLPlQD5n7c/IJgRnyTKqyBMR4yV1NID3RuMzVzkQNTq/MqdnUUIilqMk9Y2uAp9OR153nv7Q+bNPmsBoXr/FltTQO8rvs8wiLYJ+L3fVD3bnBSVwbH2qtTMnCDkDhvnpYHLDhItRR0ddaf+OMMvSPOLi9aSw/TIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10)
 by IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Wed, 2 Apr
 2025 15:23:54 +0000
Received: from MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073]) by MW4PR11MB5889.namprd11.prod.outlook.com
 ([fe80::89d6:5ccc:1dcc:3073%3]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 15:23:53 +0000
From: "Olech, Milena" <milena.olech@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "Dumazet, Eric" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>, "Mina
 Almasry" <almasrymina@google.com>, "Salin, Samuel" <samuel.salin@intel.com>
Subject: RE: [PATCH net-next 04/10] idpf: negotiate PTP capabilities and get
 PTP clock
Thread-Topic: [PATCH net-next 04/10] idpf: negotiate PTP capabilities and get
 PTP clock
Thread-Index: AQHbmCC5P2L2XyfYBUyTDqxu1A3KuLOD2JAAgAy521A=
Date: Wed, 2 Apr 2025 15:23:53 +0000
Message-ID: <MW4PR11MB588909DAED47807C491FE7C38EAF2@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
	<20250318161327.2532891-5-anthony.l.nguyen@intel.com>
 <20250325054956.3f62eef8@kernel.org>
In-Reply-To: <20250325054956.3f62eef8@kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5889:EE_|IA3PR11MB9136:EE_
x-ms-office365-filtering-correlation-id: 02877127-c8db-4ac7-140a-08dd71fa60ec
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tpN6j63Riyh0Ijik9AC3j1pWd7VxqU9Tlp9dOzc2doVXOne7mmJvr9tvbdJ2?=
 =?us-ascii?Q?HMT9tB8gvTsvVwHFMbXlDbn2M44prqLiOSMg59+hCHvrKGyWqbUtwa1F6EWt?=
 =?us-ascii?Q?4XTwxoMkftCYJLl/zaoQ3ufgHIaZGhgLjt20psc0xfqqyX5/pXGAi69WOwBM?=
 =?us-ascii?Q?V8ic+9hy00P9JKgxL8UDmSDEYfSOtr2CgcWNaB3h/vtpXev6fXxChM73Vmp6?=
 =?us-ascii?Q?IY1i0MFZA2E818AOLNRoB07hDq+/zWxnMLyM4DmOLe6JvPZJfIySXKuTRo1Z?=
 =?us-ascii?Q?xVAS9sMZ7zIyJZy8bCdcRfLGtVVdQbiQtOD9o49fUXAJDieLWMj2banOEtlI?=
 =?us-ascii?Q?Amws5dkeg7OfpE535BmlTLSC8+TXEaj4WGkFlPUMRCBhrvJCxcKzAAfS5JOh?=
 =?us-ascii?Q?7ojWqMt+347N25tVxDJXItD55yRCqVh/0Ri//a/BZWHwNiej/D851X6VdiOu?=
 =?us-ascii?Q?KMG2KDbKP04bilANhr3jz5MhOES256ZILO9l/srgtJRlWn92O5XNETsEMeil?=
 =?us-ascii?Q?1bR7BLGvUtLiaseq91Mnl9LqXKjj+aJX3hFplnGuf2uPF7HNncQHQzBikAMT?=
 =?us-ascii?Q?3ZkZh5JBxItqABWVo3WEplc/60dgin9O9DZt6mM7Gj8B+I3lFnjxhi133sPD?=
 =?us-ascii?Q?p/2kyYU3/nVGRx61g2VEjp0LfMW+kGjYdBYpMvNRUyUKIj4SZgn6R41j8Iel?=
 =?us-ascii?Q?GwLccMNAk6GUPkkmChOZrlpItTR1+dG+S996Qtuf1NFLLLGfRs4mfei2V7Rp?=
 =?us-ascii?Q?59WXHOboqL5Dqbwfb/3DNP49KTxiQG+IUWJAuJ33j8QPqqfvz3GsEXp1Rb9F?=
 =?us-ascii?Q?xAlBFh4bIOIFt4SudIyc7nzTjChTf4LrExfk4xqCyw3o8vY4N5a7YjfHvhhO?=
 =?us-ascii?Q?19ifrV4ryDfGhcpYGuL71upIU04O3CCNxWhqKoJICxunua+J8YnpQdW5I8MH?=
 =?us-ascii?Q?SeZs5M+B3gL/2FoooGRfl/PoKf0ciLz4JYeqff5puVZe11b8nhzLHBCKUWps?=
 =?us-ascii?Q?T41ISm8YjbbXlbj8OGxZ+GmM2L5Fr5pvXjLTWDvGnRZxGAgEAWRzjA30kCB4?=
 =?us-ascii?Q?9UR7cbzTjSJF1pbJOwTadq9bI0B26RQR1yYxTp9ORwT550aj0f5q9VRnUXXw?=
 =?us-ascii?Q?K+B6lt8G6WidpRDDrCOxkC++4GriKapfM4n9hc6/0TZm3/ZYA0oU3ozEt5ue?=
 =?us-ascii?Q?F0aupZ2JMNF/gy1UBWa1JfXvle+rUiZz5neVYXHwTlWEtmsbYRK6f7U4NHob?=
 =?us-ascii?Q?rbkFJC1765FYgWOyQMhk7cC7BSAUu40VLAZSl0zFTbqPXghsG5FvZPxvM/vp?=
 =?us-ascii?Q?4lrSgu5FUcraOyxPp7duW3kvShPsEMPTYCJko7sthRw2K6vul+x8iGR3zHkr?=
 =?us-ascii?Q?2fjy8M4Og9LZkey/1Gw0XaYzKQ4Jc9hEiLg6O+wqXSAbGEbiaa127GEOMF/i?=
 =?us-ascii?Q?5DxKPcTrzlauJ6BcuKtoR8L02K1Ye/Bw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5889.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mREVB7LuGNfcB/7UFfd7IeoYX6RwbEWLujiGywlh4mNVbdXa7oJL8QiYq2BY?=
 =?us-ascii?Q?nhhu4og+/4jAT61E/j8Z52cOoEe9ofktaxK2/QdKvVVuhnO4yOTGnb+Bvz4n?=
 =?us-ascii?Q?fi0QkKKLDjSJqMrqc2V82VtZyvhLDIYLpV7kkuiqTYs9Atdzd3k6lx/yj+Q/?=
 =?us-ascii?Q?vZEqUZxlTAZN0B3kK9HF2qAGIVqhfMrXq2lGZXV4TNwNTEQqM6nuNnVv3f4W?=
 =?us-ascii?Q?hZkmdjgr+btYl1fO873pLQwptLSOlRoygTv85MUZa+PDY/kSkzKGYo7EoMWg?=
 =?us-ascii?Q?TGTZlVZ1AMMs3zlB+qltV6ULiUcRQTERoEAzdK+EBc21kQT3ReCbNq4VsL3t?=
 =?us-ascii?Q?neJ0BWkmyAKMmj8VBaF3j4tKtEp7Ey8dJ7Lg3rIwER+76vYajJK71Xc0dVZi?=
 =?us-ascii?Q?AWxnz5bj3QxgctWym9QPY7IYtDCZWVLgphz2aWHKLRIiayV2mfVdPVaYR7k4?=
 =?us-ascii?Q?HhZ52WN5xPtygE4RY5+IZ/vj6NfeaXrPPXKvizzHG9UK+5ZVMaDZv2ZljktD?=
 =?us-ascii?Q?a55Rg0qUgQnRhrHjEgjKR/Pjq1ecQ3lIcj1JvqdYLFJ1a2txkg7Gzy77L4Lm?=
 =?us-ascii?Q?wuQH9DjKxsJPLB4rIBcH9nYOMHHsgDWGZKJId21C0OY8J+Pdwddp3FaWHW/I?=
 =?us-ascii?Q?OP6hU0L8xRAzRpIgeIPZlKp8Ckr6RJ5OSOyDEshgIcis2qPfDY6SLScaPdeR?=
 =?us-ascii?Q?6exZnlBKooI/ZSnv3QCP1AYRZmCp+Bh6kq4D3h6i5A4OILeZPRR44AVOMPDo?=
 =?us-ascii?Q?SdeNlvCKc//UuahPi62ny9h90kJ9f5sxAgLw/g9IdwYJYHoB4Cxpz7hQ6NMF?=
 =?us-ascii?Q?Owye9EeWdGAhgNkGMyUnn1xTOoVwiUoMtVbu516R4K9mHrUtyedn61w8uz3t?=
 =?us-ascii?Q?4eTXzzwVteA6F+AO1E74o8N9QibbxXyLdOoJPlO5CaPq1vljcvDcnfSFy5ZX?=
 =?us-ascii?Q?p5hyHpI8ugtyRy13X54XDauBUgAZT6ioAHymO33RPXZubwSmuwrYgMBDjohB?=
 =?us-ascii?Q?LT7tFIRGvcVwSPx6+pjsamgnel9FB67O54g3oiYmLXNXvXJahWY7xzP/mXVd?=
 =?us-ascii?Q?BNNIOLP9Khru8KPfCkpYVykfEW82bfkQ+RgBZ8AhNxU+oPHCq2FF4iEX6hR1?=
 =?us-ascii?Q?vyI3Z7bEhW0L5xjTW+DhaHrRw88oafSLfTN1LzjGaEQ7i9s/39ApOpyVMze2?=
 =?us-ascii?Q?fh1WFHKeoit7ma0l2VvV47ndE2N3gkshd6QiOEM9XB6KPBDTCKC94cPpWPCj?=
 =?us-ascii?Q?C/FjPRHgu1XqcuXZqrPX8Y/giae9l8vYw4dfkdwPwJeK7gbz0QRJeJIjnock?=
 =?us-ascii?Q?MS3AhCGksm6Jk2bRs/eM9q024OhWELUspPNawAUlSJrXsoEM/tdJvs+ZjE4Z?=
 =?us-ascii?Q?KFj9Wca5yJhq3yv1O/OVTccBfjGqvFmFciEWChSkGfBAgLk2faFELF9MSLkj?=
 =?us-ascii?Q?B316tXAHuOBGznDGL2yHD3y6UX75p2oHliKEqxQvqgVPnh6c7mSWbd5nWj66?=
 =?us-ascii?Q?uQHrejFf+sNVPSc5nM9YQGaJs379jYrFko5VqI5hVV50vd/19ETO0SVW2zRK?=
 =?us-ascii?Q?G82XKGY9VrU/3K4Gi64eAsXRA89CJxp8/UXrxvQz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5889.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02877127-c8db-4ac7-140a-08dd71fa60ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 15:23:53.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcG3cX24e/c7qmSkgh4MLkBigheKrYcmsBeLd8r7QwgzzqHB8wLXzY/9sh+0yTxs9ktCPX4Sm9KUt1hImzdT5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9136
X-OriginatorOrg: intel.com

On 03/25/2025 1:50 PM, Jakub Kicinski wrote:

>On Tue, 18 Mar 2025 09:13:19 -0700 Tony Nguyen wrote:
>> +/**
>> + * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer valu=
e
>> + * @adapter: Driver specific private structure
>> + * @sts: Optional parameter for holding a pair of system timestamps fro=
m
>> + *	 the system clock. Will be ignored when NULL is given.
>> + *
>> + * Return: the device clock time on success, -errno otherwise.
>
>I don't see no -errno in this function.

True - my bad!

>The whole kdoc looks like complete boilerplate, but I guess=20
>it's required of your internal coding style :(

About the kdoc style...I do agree that it looks like boilerplate, but
it's - to some extend - Intel style, and as Przemek mentioned, we tried
to play it safe and keep the comments...

I can try to review kdoc in this series and remove those which do not
bring any significant info. Please share your thoughts.

>
>> + */
>> +static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapte=
r,
>> +					    struct ptp_system_timestamp *sts)
>> +{
>> +	struct idpf_ptp *ptp =3D adapter->ptp;
>> +	u32 hi, lo;
>> +
>> +	/* Read the system timestamp pre PHC read */
>> +	ptp_read_system_prets(sts);
>> +
>> +	idpf_ptp_enable_shtime(adapter);
>> +	lo =3D readl(ptp->dev_clk_regs.dev_clk_ns_l);
>> +
>> +	/* Read the system timestamp post PHC read */
>> +	ptp_read_system_postts(sts);
>> +
>> +	hi =3D readl(ptp->dev_clk_regs.dev_clk_ns_h);
>
>So hi is latched when lo is read? Or the timer may wrap between=20
>the reads? Can reads happen in parallel (re-latching hi)?

Actually we have HW support to latch both values simultaneously.

Hi and Lo are latched in idpf_ptp_enable_shtime function, so I will move
lo right after ptp_read_system_postts.

>
>> +	return ((u64)hi << 32) | lo;
>> +}
>
>> +#if IS_ENABLED(CONFIG_X86)
>> +	system->cycles =3D ns_time_sys;
>> +	system->cs_id =3D CSID_X86_ART;
>> +#endif /* CONFIG_X86 */
>> +
>> +	return 0;
>
>Please split the cross-stamping into separate patches.

Sure, will do.
>

Thanks,
Milena

