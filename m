Return-Path: <netdev+bounces-290396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLOkClT8DmoSDwYAu9opvQ
	(envelope-from <netdev+bounces-290396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:36:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 465575A4EA9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A758306C2A7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5843CF05B;
	Thu, 21 May 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZM0Btmgc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAABF3CF049;
	Thu, 21 May 2026 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366291; cv=fail; b=lQAoidUKf5C6MRSjkVisqNRcJiVLnlGXesNUVOVoNp8pXyq2fZtIZHbchRwvHt4L4GMGUKi16RHbtK9kc+aASmGVgZJcYAtp47O22ObT4vSIvCvj35kWy6XDIpXXyQdBkF4X0QcedVB9yPNDZP1KznGGTINcoi3mgc4rqmkDgNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366291; c=relaxed/simple;
	bh=Y/GVh+PN0nLvuJjWbPSr/+c9VA7oZlMvVebFfGEXsSM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EhJyTfARfo/p2aHVfi0tFZ55dpGJoAc8eKTm/UXZVfsZ6QLb6Su5tEkMuCzWdmlDmgMsidSEctQEaM96V2kTr/R0RTOopb9bL5bqfKOLIgRe4nQ4Skqb6kdh/Pc4EazGcKJa+H5v5A8JvvqxuXUwwYPzLNhRzo/+9H92OrE/Iog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZM0Btmgc; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779366284; x=1810902284;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y/GVh+PN0nLvuJjWbPSr/+c9VA7oZlMvVebFfGEXsSM=;
  b=ZM0BtmgcTYqNEiqaeNj6KVKGhQW/rveT3TtXGq3/+QrzK64SSDaj+E+J
   Orm3fQrSBGvhbF5zXIZfc+YTT+s0G2olre3GXEdwUQ6M7xa98sR/UZOFP
   d+tySGumeDNj5pBy6OPm8fB12ecSM9FylydaoDSZx9Py8/L282nnyeYrZ
   wvbIA0t/1N2W+Nqn9C2CKLZUqkNmlv/0j5iyK23VoXRMxgr6iZCjFRX9k
   /Ot+GyiwrDDfecxnE5MpahpQrKT/GDy7dSKPM+kpLb3LtCJi2Ldxn9Mmc
   gIE3sRCMdEE0o5HrB+2t6WRHMpynx6Et5ZpCTVCAOHCFP9Vc5PwjfUObI
   Q==;
X-CSE-ConnectionGUID: 7zRCeZ9BQL2O56ifUhLA6Q==
X-CSE-MsgGUID: q6AkgXjwTBCuRTaPgt2T3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80263665"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80263665"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:24:39 -0700
X-CSE-ConnectionGUID: dZx0tHIHRRma0sBfpmLw0g==
X-CSE-MsgGUID: 3jDCt4dwRp+5T97rxdo3dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="236261599"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:24:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:24:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 05:24:38 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 05:24:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXCXtcQivisqCmImNGBQJ3Lr5hYxIUX4eutZh1B1D96GH49hDSDKw3VQ8KYsR2P9ThnTso2fI5cl4g1ac5SxLRR6a6eTCzD9K1qKh3Xs0+1NJeTxhrWUtC6l3Sbf//r5YIf68/saZ8xPsVgKEFVZfak1NWtQb2OrmW939JkuivrrxbbWv5YhtDAwn3UsB3LZVvam5oPosu1XC8GaPb5kkbZmA0aXDxKPWpeHOcEecPtg0prp8hkvmq9SHfqWi+Vvo+1AR04zww9jooiMr7qMkYFLku4jBZxlRCXIZBaucQeWmIJvCjQp8VI/yUjJlO9O9DS+Tu5i2Woempc6ShFz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8d0z75c9153Sp/eX0KvisbzfrKdceSr20nCOKXjxgLY=;
 b=WfUNn+OJb3w56zwbP1GGHJuSV+/n8eXiMJZstTlAKQRDF9JDva5yilri7XrSmSGKcvO0qqm4O0L7PYZe3ouU1DF1OCaBxnOwH/JMT+9OhMCfVlMBEkSvOHDQhkzv+59Xsgzh3b2aNGpDvMpjO+9VIulrgQ2B4pAX5acZegrIdyqak0OhrnPd/r9z62njV+Vr42ffAgk/KU/kNx+qk9Npg+t5gabwuBgcUWr295mMG45coc0Vvz1YB4hgA+buL4f7U7VJo2TTmqa+PPGtmMjlHEJDHtu2N/mU2LoovhV26GBEdHkGIU6bPINnU2wMkyiGyfrypwEOjgkh4eJFIvx2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Thu, 21 May 2026 12:24:10 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 12:24:10 +0000
Date: Thu, 21 May 2026 14:23:58 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
Message-ID: <ag75Xicuk6JwkTkC@boxer>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520004244.55663-1-kerneljasonxing@gmail.com>
X-ClientProxiedBy: BE1P281CA0434.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB4931:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a9693e-086f-4570-459b-08deb733dcb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: MZRrRHGpT7qQufAZLWpm8BEH6pEidRldYY/nBYcX6qMyHDzYBzQWK2dsm6NWYMiDmIW1e0mNH+N6wqQIfb/ciE7ksCaOUWZfYEDCFjv3VeGr6+65nJFQBN2T5FmcA2wqh3VEVYladIq4rsmqe+sgzyqEcT5I8GClwufukryQT/Uq1KQnLQg5iuqDnH4Nm++4zN0HjgZwF0LG2Z1WBiYLqek2KEbWBFEvBwOQNnU7wNKkaDW9jFDLtJ7NgQp/5K0TkySalaCrP1qfz2dsibc84tS6+j28yKJLRtiMM/mzFW81+WTq5FRuNg9aJ7TVhztvb2A++arGi7tfFdHTBNoKmKvG2Su9AzqOezXhyeKBw+fqkrnxrZjivVeEoLXtmfxF3IU/yrEHbZAc7R+KSCmdvxBbNUoQ1wDzDZkbiVLMCmoMU4Ts7c+YuWC1SpdNpy6u22GlphoRjGigNvVI9Q06C6KC0Sh4yHKmN+CISFPPrvBHiONzbzybBc8M4hHp1tRgVhYSZXkid1J5hTqO9Sk91v4TxUnO8HQY3MHWOgUjqyOFAX3cTCdbKe1jw+QjrdAw5whH1hh6/Ow+GBROe+hYsHwomDesE1Xec4fW9T6Bn5oP36OmDCvr8cpH3jpAxCLVjV7QlSzSf1KKZHfobNXKnSgmAIWUVvRarfp45OP6Wlk36jipkYiNuEp1se72cn6a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zf2Lz45qXkCDoAjjDz3g1biqMy5xtNCYEUkQ18MHWKmgWWRGW4D6guhIVeV6?=
 =?us-ascii?Q?VfEhzMu/K994EMxnmp5GF7GAaayw2fuK5wvMDtsJ8u5UElzaNYBpp5S5lrUd?=
 =?us-ascii?Q?CXYG8WxfFhR/wQ88woncXmDCnXIsH9p/bGxlWuBSu26U200pG0JyNvMdQezS?=
 =?us-ascii?Q?Ttu/8qeqhf0VIg6YUEpncDvUqOahBU+YigE6DDELUTDIvKpuRb7ml+tHBs0j?=
 =?us-ascii?Q?3YX7DG82c+0PQgJtr4GydsblGfkuU2FjF/JS79PEhFIrCDJwO5nbKoFtdL7H?=
 =?us-ascii?Q?bBeVQliRurDAtcKUeOAMVRlp/pZK9Ha/UghYitx4ZoqyS5jyuSNjNIej4sRC?=
 =?us-ascii?Q?tbv/zv6AQ10pb3dqCVXu9cw3wDbPh7qXH5MgjV8d06C3D/HuA7GlAbBM5Qt/?=
 =?us-ascii?Q?Pnv64/QqH3mRdjC1VkNW8qPrXR3dF5p8xS3Pfr9+up56EGc4UHFGDe4ojU15?=
 =?us-ascii?Q?yPqSGOsmLpphJ99zfOU/wLKhqFuIlTi7nVTRn4oHaPEYwK/JiQYT4ljyyJj8?=
 =?us-ascii?Q?B5PTEGLPhLx2dkZ8FuabULe4AJB6TYFRTzI7eIhSSOa1g1IWNAvjruGzwBoX?=
 =?us-ascii?Q?bmTGEjbNkWZPuQPcprmu1Ffng8vHxa+fSIWMPO2PY3eqC1iySyaEfPT1vvov?=
 =?us-ascii?Q?puozTTaVHIrprw1UPYVz1uO4wA/o8VfvEeNUYJ7QQOkdOtZdM+nLjc32LPVy?=
 =?us-ascii?Q?RO++w5PHhQtjlUckcoZVZospJxxxUJKqhqoZRVxZJzvuI3pBFO7467G8EKXi?=
 =?us-ascii?Q?voyXglrmlo16y7StQl+PrrFdhzsoqX/zfyZumOH/6Jvq9d62JP+ln7gWdnRu?=
 =?us-ascii?Q?0rPxpA74ADDeg72ZFnB/JBIAZ40dq4Dmf+B4+p1RNUJNGV69N8BlHXeB8k9i?=
 =?us-ascii?Q?jghLh0ExP5xhurZkzwwWGprJyN35TORj9Q6nkG3sAilCYSAKVaPgRhGRwFOM?=
 =?us-ascii?Q?vlDzFb+2w29jtRUVgcqxpaBxml1MQ//5WpVtoCFiuiORravqMNmfscno4TWG?=
 =?us-ascii?Q?Ktaclw9l+3UgBw//5YeKMpkWFaOnvPyNVAQhd5lc6gkKse9iKSaPDI/2WNlL?=
 =?us-ascii?Q?vAJRC4GV51/e0t5S5tlq7E+Y3m0Ys1SToLoytdpBkrZdaHkTL0LIiks3wZzD?=
 =?us-ascii?Q?9/9e9+71RX7SuT3bgTGGwpZfyF2/suzvJdc4z3+5R7jUXlIV6HbGHm1jO3wj?=
 =?us-ascii?Q?qAJvh1DD5sGg4CzQnMP1KzIVXR1gkR+c5P9CmihtgMO7E+tEOGlv8xnE9BAo?=
 =?us-ascii?Q?wRI1T/jb9/Vdlosb1q3xCLaVyviRcTg6YHTsUurq3XiwXUaoM5OP6PfyGEsa?=
 =?us-ascii?Q?I7bbML1ha7hiZwds7g1pNLPQ/jp9JUZKOuObhczE5uEB3l3k6Opt0RdacBLs?=
 =?us-ascii?Q?aZzqrP3dSFsE3eCB3Buds4TGew8YBXpGFy4CEwmiVPC8ggs4/yPaxyV2lfZL?=
 =?us-ascii?Q?tGz3nCsUwVIOY1hT0MvnAwye4GMF8B3fui+4V7uJM9ic8mmz6Mfj8jcjHZqk?=
 =?us-ascii?Q?3VMEgyqrhujPLQFEuVZqkrXuCUGXoaM2JIme5aXyWa1a92tw4wJErlaQfTq9?=
 =?us-ascii?Q?G+5IoCf/d1qnS5aCAhwRI5DJd4/0AmRskCzfTOt4yR1o64qNcsOKmapIVQbW?=
 =?us-ascii?Q?RVVdecYnXUy+UHupx62EMtRbjrTvDeCLXDAOCGguA14v+X5MJaoMOuem696y?=
 =?us-ascii?Q?smOdktobELoeEKM6r6I5MnpzdrO+F3atmud04emUgxqdQJZCahbegKiE30Bn?=
 =?us-ascii?Q?RLrb0dHnB5xSaez3Z9o/LSIFETAGb1k=3D?=
X-Exchange-RoutingPolicyChecked: IBimmnTGJhtMG4KlL6D62EqXrVIMpqAvqHHEdbjaxF+cnU0CYXzfCx8JQ5bomq0BtnwqgdRLu5OEab2Puzm3cSOh1nlmLny0mdllgsmO0UKG/9f/Mi0G3VcRhugLCCE88P5j7ok6d1eeu7MEj1zf11uM0ZmwBz0TeLeLl/SdCqrn9BSooDVgUY3s6zQwl4gD6x9xv6VnMOcS50tN2UjZ9fsKkAA+06SajL98PybkzlaQPuDin/NNcUZcj5L1wByurOZHtHypfNIV8M2YQbMCCqF3AZ1lW5+FXUE1fyQGcZRYTHrMjutij6Y7EtSy3z4Ms7dUlErp6WkKjZq8hxwlkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a9693e-086f-4570-459b-08deb733dcb9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 12:24:10.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1JEOYBzozpkeoXQ5awc7ymlXw508nTP5xcpYLKwoUu7fD0CEW/1I2Cj6A6S7zvoP3MIyWzbRhhSmqJwI3MnvvXjM95jW6pYojdbGOBX7CA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4931
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290396-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 465575A4EA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The series is the product of previous review from sashiko[1].
> 
> 1) META
> patch 1: address TOCTOU around metadata.
> 
> 2) PUBLISH of CQ
> patch 2: make sure xsk_addr->addrs[] can be published to cq when
>          overflow occurs.
> patch 3: keep cleaning up the continuation descs (more than 17) and
>          publish its address when overflow occurs.
> patch 4: like patch 3, but only handles the invalid descs cases.
> 
> [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/
> 
> ---
> V4
> Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljasonxing@gmail.com/
> 1. correct the description of xmit path in patch 3 (sashiko)
> 2. move set logic into xmit path in patch 3 (Stan)
> 
> V3
> Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljasonxing@gmail.com/
> 1. avoid breaking previous usage of sendto, and siliently handle
> overflow case (Stan, sashiko)
> 2. add one particular exception process in patch 4 (sashiko)
> 3. adjust the selftest to make sure it passes in either virutal or
> physical machines, which includes add usleep to support physical machine.
> 
> V2
> Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
> 1. adjust selftests (Jakub)
> 2. add READ_ONCE in patch 1 (Stan)

FWIW I still get test failures (yes with patch 5 applied). PTAL.

> 
> 
> Jason Xing (5):
>   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
>   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
>   xsk: drain continuation descs after overflow in xsk_build_skb()
>   xsk: drain continuation descs on invalid descriptor in
>     __xsk_generic_xmit()
>   selftests/xsk: drain CQ to wait for TX completion
> 
>  include/net/xdp_sock.h                        |  1 +
>  net/xdp/xsk.c                                 | 44 +++++++++++++----
>  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
>  3 files changed, 63 insertions(+), 30 deletions(-)
> 
> -- 
> 2.43.7
> 

