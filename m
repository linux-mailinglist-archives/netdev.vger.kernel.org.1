Return-Path: <netdev+bounces-189949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB7AB492A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156D717A334
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA611D9A79;
	Tue, 13 May 2025 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7a1jJEf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F11A7AF7
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101820; cv=fail; b=uCfCTxtdCBC5JwvOPLUnN7urIXEYkyKyIEijd/b/+q2MVkpZJT0xkKu6LxWhFU2tQNVqKrzIQn+WUcLUFUN8GKSXhChCWtohog1Zvbohk69q5V30zdouLZeardNGIgMyFXJrMGqVJ7I6D5MS6+hF7Titcb2GTgWC4IRWrd57m5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101820; c=relaxed/simple;
	bh=bVxXbhEngmCo+mbAp5oN+abiTS9p4Jj5NnEhSaaItzU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U9nN5QMNDldvW2Sd2SMiHt1vW2aDRpr2dxnzraqN2YFfcS6TBsS4HWdCt2spD+fHmLnOLXbu3FORo2dURQWvKONCQfA87RASaMlvLoLcAVqspG47NKMLp4nNu9XmVwNAptlbjdEQra1yeaPsVcsB36ciZsgHqjYgKBB44ischqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7a1jJEf; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747101818; x=1778637818;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bVxXbhEngmCo+mbAp5oN+abiTS9p4Jj5NnEhSaaItzU=;
  b=d7a1jJEf9FBhfoZ6/gg6SLn+dR1x9seYF7FDM5gjWhWbAE6IjigJQXBK
   HS3Gzp3EuFtpu62BmztUxMwvaLe7iz4DFPiS/L1umXoHWMHbCkDRmlUaq
   WkriYFvxKbeOmKIyFcJj2+T3NpF+Y/8c9D/WnkgkxQIJzz3vBkV7X36J3
   xEgGZ4I9jl/mwXPws1n+CcZNUHDxLImF2FS2Vc27pT29J1pKPRdcH4Ev2
   RffCuna0F8MhnmigNWaw5st9qEmbYWdzNR/i60ziBx/DNZBWt+vdXzOb1
   +fun3v3vBfESMEpZgGm+Nga+TrvZ5zQ1XFuD6p8awqIzGx+x4QvjOTnRG
   w==;
X-CSE-ConnectionGUID: UL+iGHEzQgeW+QGpwh0i+Q==
X-CSE-MsgGUID: TWPyz/HvSoOsti0nDYgh0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59591129"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="59591129"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:03:38 -0700
X-CSE-ConnectionGUID: 1unT9uLCTvK4ZAyU+k1ktQ==
X-CSE-MsgGUID: 28Vquz7QQdy8Bv0BMogaiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="142439925"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:03:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 19:03:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 19:03:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 19:03:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8dWYhzDQZqSdxIS1P9E+ec+NrP8kqJb85xDNckoAjyODkF7/g6xQiQW6GVw0XT3IrPvwCireBhHSyewSt3sQO1gy8O07gWZ9itRrvItG6TuAKjYyZTPZc0rz87IMuLbVVZbxplNOzWSAeCYelo8phQgrfEqhcVBIXLWpitIqpir+AmRI//2lgpf5IHcINdnkuZ5bHgeGOuRRyEXdKjQZ2czk5BNJqq9cH3aYlxvMMGJYshZsrOrUY5+0YSOQjED/KF1xaejRvOG50U1ChEaBctKj6fcdaXJOHK0ZnTjGmgsR3fp8D/XRYW2N8S5Hoz0FOijqc59rHQ/Nb6WR8/Now==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qPVS0RgfDhOFAoKOagFdU6moaUW+gmWub65mPJifpQ=;
 b=f2jtx1AEoObTJfKicF7n+jkDsuQL1bc/aXzmjUm+UfsX9EjogrJWgiBWm4kozORg8HRI+4XOaG59MqUMG7lOh+j8fItI5VThYg1AgD5bm9lmNs5gKZr09DTEr2Nzl9XepcBRRfLu9YOitQ32uLbLJkxoaHOswPAn0tJOF04OMZV5MHviLsutgFXDwR+y2wgqmGDEKG53R5U7/Rvi52InNVlZSR3NQ96UVNNRQ+HcCkylw7MRtXsoqieAtTJE/hH/OPRKW05VRhC0pS4jzTGAmF8RyD7m/G5mrgsBYox9REkv2w56Om3Zg1IRSgFOl2JGY5yJg7MNsebZc9N3CC/9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6769.namprd11.prod.outlook.com (2603:10b6:510:1af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 02:03:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 02:03:33 +0000
Date: Tue, 13 May 2025 10:03:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Willem de
 Bruijn" <willemb@google.com>, Simon Horman <horms@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	"Kuniyuki Iwashima" <kuni1840@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC}
 to struct sock.
Message-ID: <202505130959.3212276d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250510015652.9931-7-kuniyu@amazon.com>
X-ClientProxiedBy: KL1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:820:c::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: bb840a90-fa62-439b-423f-08dd91c25d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BgMDJkmCxNpyY0epVMWWZ1Pnd0ZetzwAt/aj3r7sCesRcSZdc1fZGHKOm4vr?=
 =?us-ascii?Q?gcar0NZwU3w2SKbLyxvu8uSihEqG6xLLqJU/cibfm4cQsi9UGqdf67m6X6SR?=
 =?us-ascii?Q?jz7oa4T3FuQpO68rtdtZL7XG18WYABo5JeqroPuxYNLEDKTQLSnZyLCvqzYw?=
 =?us-ascii?Q?PG18lkPTfTzJ2xpqeshFCjxgCAB8kp54aKcRX6SM+/OZOsOYdevxsKL/ZbkC?=
 =?us-ascii?Q?mmAvOFH2hlDuIgKDI4wHGfBLQJhR4UIUdpjVw+Lzj+Vd2q4xa1QGZ9Li6/7O?=
 =?us-ascii?Q?NNDbQV++mOW2TXEutyQTgp5HmgLLUpMW3e2eNeii51vgZDMg1HvVG/flfOyg?=
 =?us-ascii?Q?zBns3aNKCKgbkWhuDCS+n4ecBajOwwksxkEXmlLNcrRL19zzxKKfw6TyT4R+?=
 =?us-ascii?Q?xThUiCG6SxUKuLNEkTftNJpb/7YtWLJZsYka7Ywh3kGPL5bqFuNMU+Od5CzC?=
 =?us-ascii?Q?2Z/Ov1S2hx+ni/sHhJAr4/LJPAlJA1Ns5aIRSekX+Sy8kMuTj4cp/BnVXnmI?=
 =?us-ascii?Q?n1Iyqf7gY8/xyhW/eKvQ6t+F6I0mFW3iknZPy3JuqvbLnmsXOUWjjMQAVMIY?=
 =?us-ascii?Q?onc1YSsrT7bLBhLQYnO5m08ejLcVeG80/AgtCiRHRpDrTJd9ZroGFX8gARtA?=
 =?us-ascii?Q?RTf95f27AkmaIOWjUVvjuuKHv/r9Cl+6J3GChD7Pxk+RLe+axCUeG069016E?=
 =?us-ascii?Q?h4AhfHuJxNu8RdtfHSPQG8SBoLqALGaNrnBXuCVEbDErzt+PzbwKfpMLopcS?=
 =?us-ascii?Q?FLaeCCkQoQHhGj2w97uYe3N6bwWjL9Gm/QiRUtYXkMiSLUSBoUWpNJ+xRdHv?=
 =?us-ascii?Q?CO+fdLBx26jRWaMgWnmlj/+WpxwxkRK7Ci+GTthCVi5jioV7I8Ub4Pk0aigb?=
 =?us-ascii?Q?S8VrI4v3vL4p8HNlHSzu1QRHCgZzWWh+I00DPSOs7oxSd3lQZpGy8nJN+ocK?=
 =?us-ascii?Q?S25j6p6mfAl2M4xVGwwswXcGxCn/CKhQvIN3/jp350hoVG9YYUaftALava84?=
 =?us-ascii?Q?vicK5O59iQ3lQr5r03TLrAV0EGK61vGJmsHVvWTh73QBtVZ32yUg/c7sWqIF?=
 =?us-ascii?Q?Tu22LGqxvpLVWdrwiW9JEWTmoIbr7f0zoUTKtDcg3Sp00GsxNVjy+RQ+jsrU?=
 =?us-ascii?Q?2EnBNi8NkDI+Ehr5LlE74tnjIg8UVBvzovUzGYE3pbeFxDw5UcCCrVbanDyU?=
 =?us-ascii?Q?mZlN1GilHHUESunBwYU1EH19qtnXAAEloJZaNiVlh4CX9dA428FtTKmkl2bp?=
 =?us-ascii?Q?4FGgn6Uj5egZHPfMJZPGKSgc93BtEXsC+N/sLklDgokSptsw2mJmFWdcELWE?=
 =?us-ascii?Q?zMIv5w4K50HTwK2Iy05mlYkJkQ6GWIMUPoLXNTJEEO7i/tE9Cw3OfzUePxwN?=
 =?us-ascii?Q?3j7YTs397XrBFsuHj2/C5n86s3Ds?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dzkNZv+xw2iibciPwqgzeUs0q2wGow2aCl4OmiKga3KiGaAnDEMxsLCBZ0q0?=
 =?us-ascii?Q?knDx+BDBEIwoYWN+XJnWQ3H+W0BKAXDFOPmEsHxAWz/S0D5uM76BBiWQmnyY?=
 =?us-ascii?Q?9nbh0BiaHj6z+BSpwyu+p46lTF2YvrprROXvzQ0xQJ9UPV8byk1D4/9iQ36F?=
 =?us-ascii?Q?RYYlh1DB8n8pKoSMtMRZ0N7jF3OCBy4qyzx2u3nSF/loMB88TYSw0le0Pd0e?=
 =?us-ascii?Q?yvSAWGLs6bylEr+h7jmlqkFj0n5tPXyaQ01t258xHOzxtsmQ56++9I3bGTZ7?=
 =?us-ascii?Q?6mtz/WobNgi81GdzxHFsPjei6VF+tDOBDXfrU9bwdX3oj8hqcfa5nctPvn10?=
 =?us-ascii?Q?/wADKYVYJdd47kndhn6rIHd8L1Eo0+UXom8dNos/MnfrST5dGNBvdA5PJDqx?=
 =?us-ascii?Q?uX/KBNCq7EhicsocSpmnAZd1VJzz4B57iggFCg9dB2DqN6wrCSUr4TtAoOxV?=
 =?us-ascii?Q?GrNYb2M9VZngk5E6Gafvp3tqv/C8BsPKahPaY4sEsHoyKobWeVTAzcw3tpyF?=
 =?us-ascii?Q?GGWMYMDMKYZpoKHUyiwSXJZyccRdbqzs8TUs2QO92kp2wynlqarjQW6mp+yD?=
 =?us-ascii?Q?fzeMtJtE3NS/iKpASDTfAnVEzJ5ipRAVtOu4qBDhRXhojI3wzxLtguj14biy?=
 =?us-ascii?Q?PWVqf7pSrLNDo+KxBXIUlGzPBgH2KDECUumVfhXygDzobsq7oQjSdSpCVO9H?=
 =?us-ascii?Q?QzhH+6VyFysyQxQgoPLc442TsVpmEttjLHZv/9pnh/aFYKStOd6hVUAk9oyM?=
 =?us-ascii?Q?soO5mDgfz1gcq+P2xrMAYrXYzIewVTv6tPMDUcffQVEEgMc4vHeNOHDAxr8w?=
 =?us-ascii?Q?NCuKHTA4tq2pL42e60vnRj3Kr+MCqfwWVnIUaYRRwPFfqCqrDhuJFSlIEf8v?=
 =?us-ascii?Q?VZdj4mzCQCn0mWOvZhBW2RlN424YdDIXnAMzIjdLYFnOcyP8YQqKL4UQ8p90?=
 =?us-ascii?Q?vLPHtdPNob9sm9nNGWDtR0T3QgqGI/kEFME72LJGNms0uSlFAUVz1xrSdtV6?=
 =?us-ascii?Q?7uSAXQWCtz381gD9/sOFE9QBu6G5SVZViUiJfofoWK2ZbwdCFry5HRwzZf7w?=
 =?us-ascii?Q?KmwfrFz6+g4vjK1f3KC7WHg9zqseMl4cP9M0xX60vLO2wHZqiFJJ0cUr1N84?=
 =?us-ascii?Q?OPCAp5n0xH4Ocg6ONihwveqmrTpqDyLf+47x5w+RVP+yQRTa4woshcm8bXie?=
 =?us-ascii?Q?+AHMqM8/6gC0uhHMGxuoVHEhMNSE6ssl8BWNbEe2+MVzMi1yNcgq/xgU//Kd?=
 =?us-ascii?Q?1FB5lu/QMZpmI0jCxX2IDq/FbP00vKSJQQMOd11pVmBwAICFWAqRZc2QNfyS?=
 =?us-ascii?Q?U+clp7StP0ZPjUn6fjCqLYhW/xEA3gmulzs3CBauadJnkJ3DVHXV5ODdqelA?=
 =?us-ascii?Q?lRqpHQv828XV01iYsBhFCZ1YyG11rMFUIteqIlymM9UIQTuTgJVYi/n5kHoX?=
 =?us-ascii?Q?yRvd9mTjIFiGRVmNawAn2ofOfmsUmUTpGukgS52FWiCKGP2tcQSqTmCR4d40?=
 =?us-ascii?Q?2xjx6iaoFBHyQn0Wa/U5tkTvPwayQ7OHtYK22is89VMvt8X/3tX6JIeJ4AHF?=
 =?us-ascii?Q?wRq/nU5LB0ZFF3ASomJQsr0vlQVXcmLKoPX/qcdj7TiZCDBDjWStZvjd154z?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb840a90-fa62-439b-423f-08dd91c25d99
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 02:03:33.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEeIgMD6ysKMwu1i2OV/1bhUSQvHq97HMMIYNvNag8Z4Y91aNH7OatIu9osLL0LUMV/Ba+foxyNuGZp1PzHtbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6769
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "last_state.load_disk_fail" on:

commit: aaf23d0d0fb88067cb42ff899899ba235c757f97 ("[PATCH v2 net-next 6/9] =
af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.")
url: https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/af_un=
ix-Factorise-test_bit-for-SOCK_PASSCRED-and-SOCK_PASSPIDFD/20250510-100150
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git 0b281=
82c73a3d013bcabbb890dc1070a8388f55a
patch link: https://lore.kernel.org/all/20250510015652.9931-7-kuniyu@amazon=
.com/
patch subject: [PATCH v2 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,S=
EC} to struct sock.

in testcase: igt
version: igt-x86_64-aa9b10408-1_20250419
with following parameters:

	group: group-13



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505130959.3212276d-lkp@intel.co=
m


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250513/202505130959.3212276d-lkp@=
intel.com


we don't have enough knowledge how this net change causes load_disk_fail is=
sues,
but the issue is persistent after multi runs. just report FYI.



[  188.263289][  T440] LKP: stdout: 410: can't load the disk /dev/disk/by-i=
d/ata-INTEL_SSDSC2BA800G4_BTHV61840945800OGN-part3, skip testing...
[  188.263298][  T440]=20
[  190.692731][  T199] pcieport 0000:00:1c.4: AER: Uncorrectable (Non-Fatal=
) error message received from 0000:03:02.0
[  190.703436][  T199] pcieport 0000:03:02.0: PCIe Bus Error: severity=3DUn=
correctable (Non-Fatal), type=3DTransaction Layer, (Receiver ID)
[  190.715600][  T199] pcieport 0000:03:02.0:   device [8086:15ea] error st=
atus/mask=3D00200000/00000000
[  190.724643][  T199] pcieport 0000:03:02.0:    [21] ACSViol              =
  (First)
[  190.732684][  T199] xhci_hcd 0000:06:00.0: AER: can't recover (no error_=
detected callback)
[  190.740979][  T199] pcieport 0000:03:02.0: AER: device recovery failed
[  190.785617][    T1] e1000e: EEE TX LPI TIMER: 00000011
[    0.000000][    T0] Linux version 6.15.0-rc5-01027-gaaf23d0d0fb8 (kbuild=
@5fa04ef0f688) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for =
Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Mon May 12 09:41:23 CST 2025
[    0.000000][    T0] Command line:  ip=3D::::lkp-cml-d02::dhcp root=3D/de=
v/ram0 RESULT_ROOT=3D/result/igt/group-13/lkp-cml-d02/debian-12-x86_64-2024=
0206.cgz/x86_64-rhel-9.4-func/gcc-12/aaf23d0d0fb88067cb42ff899899ba235c757f=
97/5 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-func/gcc-12/aaf23d0d0fb88067cb=
42ff899899ba235c757f97/vmlinuz-6.15.0-rc5-01027-gaaf23d0d0fb8 branch=3Dlinu=
x-review/Kuniyuki-Iwashima/af_unix-Factorise-test_bit-for-SOCK_PASSCRED-and=
-SOCK_PASSPIDFD/20250510-100150 job=3D/lkp/jobs/scheduled/lkp-cml-d02/igt-g=
roup-13-debian-12-x86_64-20240206.cgz-aaf23d0d0fb8-20250512-42822-1bot8b9-2=
.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-9.4-func commit=3Daaf2=
3d0d0fb88067cb42ff899899ba235c757f97 intremap=3Dposted_msi acpi_rsdp=3D0x9b=
0fe014 max_uptime=3D6000 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=
=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=
=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 =
nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.=
minor_count=3D8 systemd.log_level=3Derr ignore_log
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000100-0x000000000009eff=
f] usable

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


