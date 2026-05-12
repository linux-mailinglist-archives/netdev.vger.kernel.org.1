Return-Path: <netdev+bounces-287252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBBULaleA2qE5QEAu9opvQ
	(envelope-from <netdev+bounces-287252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:08:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 205E2525767
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE62F3042E39
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5012A3DB996;
	Tue, 12 May 2026 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMZhp/nm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162F4F7971;
	Tue, 12 May 2026 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605609; cv=fail; b=RvXQZuPrxJHQyBIsfExzfm4XJSgBdjt94lky7XwrDBtlFKGzEuBf9F19nH/rYk9JIximthOWl8j57qzl/2nSC4wDGZKgKWPJaisC6QWJobqRZXhSt8GxjQDu3KYsI0pryeXXUtppIOfi9szkQNYRYEsk7Y95C7A0AhiLPbjos8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605609; c=relaxed/simple;
	bh=O1Aandq+eePOS77aSsBKV+nuLLk6Ela/DDWiy7WV7q4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eSGE/ALsxy9rFSdcGlqGUEvXIAtT6l9tMLba5ZdhcN1OtNTKfKwMJzSmLcJCRTICeL8NJ9nm7/T5fM57Yw2+/HCfgiO/qWBG4iwOUZzQ3UVDa1dfZbz3+kc2D3GWXTu+eQhOZpYixafzNiXbphHgXhYxhBWPFZXRNg7ZweQE4F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMZhp/nm; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778605608; x=1810141608;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=O1Aandq+eePOS77aSsBKV+nuLLk6Ela/DDWiy7WV7q4=;
  b=OMZhp/nmy4AAzD5pDVMT48N+ybFlLkJIwWkqtMhxX3jnGsat9a8j7xqA
   DdVfsl9DK21+s89SLzpPBZ8WF2cZUdPOV3+tbI1/XKv6v1lt6D1Y6RmfZ
   55RI4wQuY/eO8c4bsXPjoZGVDE5IrGZS5/BblF9Y3SgRBnu+NKKJYe21C
   plri271PKhpABII4QgWOlZ7ofNbM+/OwP6ihJeSaX6Jz8zKL+HiUiTvBx
   xHDhnHY3Ts4g/kXsqkNs2HMT5rNcGCU8zNRut2H4M85uzbKeG4OJS+qnZ
   ursJdsOsRwzV1LhMGWwjSme/ZH0xU5UfAZ0rej6ROiRvNqLOwc89XMdCG
   w==;
X-CSE-ConnectionGUID: NrtmYp7LTsigqDwyAOBHKQ==
X-CSE-MsgGUID: YNmcb24nSpiuphXEJoj3fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79376606"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79376606"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:06:47 -0700
X-CSE-ConnectionGUID: wTywzPY6S4O2fufxytT0XA==
X-CSE-MsgGUID: tAPvBZcXTia9XWEIvuuFrA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:06:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 10:06:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 10:06:46 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 10:06:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxxc86rnHg3ZhaIimAWD8R/xcdhwrbGaRmxfTRzibUivfkpYPoXTMCIZnpKPqQDQhg5JgK1IbtAaPX6kaWiseRQrz1IyJhYVjMYwhfqlwY9JY++ljuPy3tKlT0hYUXA7h6+yQWGOpq8laJxobgVkRJOUtFZTFt29YdSGIvttCR828I7T+AclRZN/cuN1kwik6R/pXpK4sa2DR/ScwT8FIOS/3lU9LjM85IL1olER0STZHWDRcS++43MwBHWoyPztrEtQeP/XAGfzpDXGdrlFTINmPB7nigM9jFTIvrpC/vnJJPAmdU1fm2hoQEfyII8hr0MzlOtW05IcXUuJIEswtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X6X5d75w4wd5ER1YWAvyFdAWxhNzuOYbbWgwhNHb64=;
 b=gq9txqKCiFmODSuuvcUbfvosr94Vo2zlnARHIZHhe8eqzo4Vf7Yvu5R5Vm1rCfaW5UYhL8dYZ5t7zV+RAO8L7hizvPmPMXRyDC+CcB7HhPYyquPC+bh9qs7a8yAKCv604PF8XStWOd0ZvoDpkvPNWsQKKLOnPwxmUsF2c64Qk2Ra480D9XHmcWkgLXDl6Lg0BTsN7qge7swe8ayB0zv1vOVs5AybIyk5dNemN1oMw48XGjcrXF7PQnsBazxmX2pqmjgCB6G24vSoB75MRpM/PnVhgvCCDeiSpK22qHuQLq8OIHtknMUMWC7yylrCOTQBEWCWQPzSOepbaO9Ta2mD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL4PR11MB8824.namprd11.prod.outlook.com (2603:10b6:208:5a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 17:06:43 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 17:06:42 +0000
Date: Tue, 12 May 2026 19:06:34 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <lorenzo@kernel.org>,
	<hawk@kernel.org>, <toke@redhat.com>
Subject: Re: [PATCH RFC net-next 4/4] veth: use generic skb XDP handling
Message-ID: <agNeGjzEsYRaqqFf@boxer>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
 <20260509084858.773921-5-maciej.fijalkowski@intel.com>
 <878q9ok8ac.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878q9ok8ac.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL4PR11MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f30b31d-e5b0-404b-c4d3-08deb048d72f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: soQCH+F5KDW5B5IOhbFfuHL4Nx7wXW/vwm8XfhGrapyDk5XuqspQwZGLtkQMRBABTAM7QqVfPJLKgPNnuVvipt6E6k3cJW7qgzHf39sADG0nguNB2/yBwUR6SgNZZL4p0vxvKGihkaRcDCzG5yMzcztJB5fTgi94jUlTbAm63JfClpOP0OCFj6ocfUYsqhKzSAfH389UR+IWStOVHUkolNa2MsN1EytWLMd/K05jG3F0sPzA3L4fsCM+SGSi4jFOmvQ8pPPEKFmqw3qdWJXJHkbsfCy2IDKRyrFDaCc7bUPzpN0rMQaxHU26rhgCLR+QrM673ay3fKVGiGiveIJpiSXrxLomEdtzw2jBc2uEGbUXAlekn70i4zM+Jvljy9vA/oKTaXC9qA3kTtO4wouw+pUGVck1+7DJaAB+3MVPhoKjQUK06D76HM7SsUKc6bJFp17w0rTwJ+WeL7FK08+Rl7wiakwLHsUUGQMRDz/sINXSkR1CggdxeJQit9vveRWM3xiuUTciEU7Z0R5N9T/k8o8LToH5nmykZj4peDxe41GT2mjDRlfMpOlcd2PVL2th5ehDHPyGnwcIHNfvlC+8ytLJN5Z4oCnybfoahGSVkAnMIy9MIvVzQ6cvH7ewpeKNvGJNRGgpgb8OWHO7xWiqdVOohIeZzUaPupyQ1BjeP2jbw0XlG6vUUaVTOZ4x1X6H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?50msfy4SlZ+UR6QFfujDvSsavL6/YFsMq63Mnq6qk5FRGZKmvb3oOjWmn/?=
 =?iso-8859-1?Q?Bvtphvy8zyh4t++FaUjEi7ixroQkiHLbANM+6T4R/PbtaRYv98DT4ZAbkF?=
 =?iso-8859-1?Q?eQjnmhP826ysOOl8gJoNrN4DSyvCE7qDlX1iPlu5BxqPLgkDBUzYvbpNko?=
 =?iso-8859-1?Q?uGFmiaX3mANpivkBborgmzwtRFJwTKYP+0gouBsTVdpJuzyFCDYXh4/9Af?=
 =?iso-8859-1?Q?Ap0rpSV4sS5Vavf9hYc5UEjpqnbS64vYB4JzdGFMv4ELSTJP00Q2+dSpOv?=
 =?iso-8859-1?Q?cJ+Ixhc3XUeqRBEE9yUxuSCXECXCw+d1MVIrgcPnfIIWE3/E+I9Up6Wric?=
 =?iso-8859-1?Q?0ME/HovZ03TSY5d2KVIBfXy1rmHJU5vx6rPMZz0jkQtqp3nr9ydcUHgKQl?=
 =?iso-8859-1?Q?21Vl+HqwVVUDS0KdEL+9C/BvzmZR66RlZ044uhUOQMxxp9lZ8Xfj7C6zVs?=
 =?iso-8859-1?Q?2aJGFN3kpwJK5bJP4d8UtY0VgJjmcUN/KzNHoPGSLODb+U/hlEEnXuIayO?=
 =?iso-8859-1?Q?z7H924Z056z6EVoOM0hxr4qoqNx/IC1hG1nxBM5SMdp8PD7cJP+FIupeIz?=
 =?iso-8859-1?Q?5iUl5w0qG0SBcsdv7fbgay0CXWBVlAU/LSo7S1dj0DfXbp+DFbyJPuFKXT?=
 =?iso-8859-1?Q?Mk5cYXw+SE1r5eC2d0cDf1wdW67KrlgBKnD66YiWmu69iip1LnITWHOS8V?=
 =?iso-8859-1?Q?xby3lQUERe8P4LtZj7uEoRDUg9LrhHyQMjQteoio3hT9KIBG9lmKH+XClX?=
 =?iso-8859-1?Q?1UQKHr9Xzo59s8l9SdJokbmvxfM0qZ2TKt5eKGAZAJ59t6Zw27vl9OR0MM?=
 =?iso-8859-1?Q?Pqy1tCDU98OswKUhc/FdFLioC3F0uwyv9/0NfPOewZugzYrKh4RQcFXrie?=
 =?iso-8859-1?Q?wlhoj7wvPUS3FvbarIkc6UFPHFRXbJ8nIDji4qKs/zZ0heMaRSKduTV8sb?=
 =?iso-8859-1?Q?24dg+7Jluk3eF8NAj+FwDiQYSc9IvAnFArhYqIXj2+nf2XX1l78R4MOBVH?=
 =?iso-8859-1?Q?vVcj1KjaRES9zQxp8R0nrpuBMSjwE4xePtjUHQbK7PzCk2ylRvBHCVn4ll?=
 =?iso-8859-1?Q?PAHuv3GIPUWNZiXkLa89NwyItbGxgYC70j9kvy4ZrClSVIURqTW+i/UghC?=
 =?iso-8859-1?Q?qT4MoQiO26UHujCkKxvFFnSwfbSH9zoRX9AXnuJ6/L48c0X4G+bkfVIqhI?=
 =?iso-8859-1?Q?0tf2H+VaBpVx47x1wU3EGKw582JuNkctRCK6C7ACSKVR6WZ1OdzbTLC27Y?=
 =?iso-8859-1?Q?tEiZtJT/tzmminqAqbKn5Witwpk3UJiS1iM0Ecdmjzll8UfdpK/XiX3G9t?=
 =?iso-8859-1?Q?vpQahmfXk2TparuGrTwtanxm3xuksSnKtO6D49M/fk85l9GhRfT05xv1Oz?=
 =?iso-8859-1?Q?c5xftsSJeIckCuAflx/Z6anxADfls8FayguAI61b1cjhSn4mVmbvYSbZ0u?=
 =?iso-8859-1?Q?1dqiBK5jy3GUgcTtAZPHH0lyLRStGi6hc6ePzqe25n2EWrWNo+v5OC2Ghm?=
 =?iso-8859-1?Q?lREJI8ZbZ5LesbL74ia9oS4Tpj3Lp3aebKS7gf5nHTevzTojNenIUHXLbJ?=
 =?iso-8859-1?Q?t//P7/ZQK7vw37CbtUld8LXhAJ1DvnHDGNqUkJYCxhUDeMdI2uo1zTFWka?=
 =?iso-8859-1?Q?ghyJkQK5qhR7+V046VPlP1hdlB8O5UvSArrzdms/w4Iz2wN5h56SgkOxfD?=
 =?iso-8859-1?Q?ZeK9cetJ4cIxmOFaid2F7o/Cr7EFIWss1CmcJf8NY1nY7N21NBUxPQ+mSZ?=
 =?iso-8859-1?Q?fo7ct9tDOH+mvnvjACkP8M7+XP22hwUp7YjjchvSremnQ0EbR8+kRZyqRG?=
 =?iso-8859-1?Q?YliiWS00YEUyNJgeOrXQx6CCky7GsNo=3D?=
X-Exchange-RoutingPolicyChecked: u1mjrdWxkiuhxkyKrgeLViyQdtTmbDZxdtoS52BQSxCTnS8pta7Tcs9bRM1UcN+SRKGotBXgW0/r04Nx1dFWz9JhJ30axOJCVuYBX/oazIXo6r1ObNamr6C5nK5fVQ15HTJdtMPeb83Az7EQ9V5IpDxcCZPU+P6GWzdlVeXC+k/VNNtmUs2UCWv3nFfEopJp0YkWat+O95XYksw/gh2/zO8s7efwPYHVNoQEHGzziTXXmMXzvSuC3rfU5qkbBb93YsoRTMoIiMVyRGK/6ZFWQmxWmL2fvl+i8zNIDDRgnwpr3qvzSMhZY8bbxWVNUkvHxWZNEOWehjw+rLyeZ1LTnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f30b31d-e5b0-404b-c4d3-08deb048d72f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 17:06:42.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKh7mKPxUriXljD95T2eLwKGcpXyqIzHQXK2rkKGsZAZmtXvdyNNR0v4Vpd5Wl1vbBbqfw3g14NzQAPvVx0RD5g+zHYe1iKziW9yIjpYWss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8824
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 205E2525767
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-287252-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:32:43PM +0200, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > veth currently runs XDP for skb-backed packets by constructing an
> > xdp_buff and then, for XDP_TX and XDP_REDIRECT, converting that
> > skb-backed xdp_buff into an xdp_frame. The backing memory is still
> > skb-owned, so veth has to pin the skb data and frags manually before
> > consuming the skb.
> >
> > Use the generic skb XDP helper for skb-backed packets instead. This
> > keeps skb-backed packets on the skb generic XDP path: XDP_REDIRECT uses
> > xdp_do_generic_redirect() and XDP_TX uses generic_xdp_tx(). Packets that
> > already arrive as xdp_frames keep using the existing veth xdp_frame path.
> >
> > veth still provides its own page_pool and xdp_rxq_info through struct
> > xdp_generic_ctx. It also keeps using struct veth_xdp_buff storage so
> > metadata kfuncs that need the skb continue to work after a possible skb
> > COW.
> 
> 
> Hmm, so now if veth with native XDP redirects to a native XDP NIC, we'll
> end up in the generic path? We'll loose some bulking capabilities as
> well, but maybe that's OK.

Hi Bjorn - thanks a lot for taking a look at these changes!

This touches a path where receiver has XDP prog loaded but sender used
ndo_start_xmit() to produce skbs onto another end of veth pair; these skbs
are then stored within ptr_ring where receiver picks them up. Native XDP
still has bulking, however the skb path has a little bit of back-and-forth
juggle between skb<->xdp_frame conversion. Now I got rid of these
conversions but also of home-grown generic XDP path as well as bulking and
the end result seems to land in the same performance results.

Does it make sense to you?

> 
> I guess what I'm saying is that some performance numbers would help
> here! ;-)
> 
> (I think it might be some accounting bug as well, but I need to re-read
> it!)
> 
> 
> Björn

