Return-Path: <netdev+bounces-301952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BzooB2MXPWqiwwgAu9opvQ
	(envelope-from <netdev+bounces-301952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:56:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D686C54D9
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:56:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KjiALRyi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301952-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301952-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FA68303BDC7
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862B13DDDDB;
	Thu, 25 Jun 2026 11:56:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4953DD85C
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 11:56:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388572; cv=fail; b=ZJesqpWssqtMaZvbYTrui+VoHZZjXXc8eR7xuQUfJlRdJ2vhnwSV3v8h0B+Uik1an1cpO5/IlrGhXRlrrJ30pCxLkcjlDtQgcxcMSfzTxBCA4lKPNu6SkmMsP4RDhKOmRrf9CJT/RltgfDx/vfwH/gy8u+Nf4W+U6YhY1f1OOU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388572; c=relaxed/simple;
	bh=4l4y1TSaIO0Gl6Ba6mXYwBMikG7kFBoMQQ1jeh9lSnk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rO8BIBw7od57YJ0DvuZSScVZy/sDb8PBWJRkd1V4ogeAR/zHf5x67gYJHdKJJ9RCpPMpysqEtXsV/b/mpTdi7Fxkh2ZELhzhzvA3yYwWMDRtfN7Jxy/OEWDESSbRTxfxybEpkVJLnhD8yeJEWYkC49/x9PD0fFRIGGZr21uHhsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KjiALRyi; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782388570; x=1813924570;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4l4y1TSaIO0Gl6Ba6mXYwBMikG7kFBoMQQ1jeh9lSnk=;
  b=KjiALRyinutzPMK4RU2s+ubY9CNLNTRyKDLsO3byW6u/pCS0a9wtutMR
   ZTbW/yRwen11spuTgRh1P3YDkrEGSmCTkj6cvBGGOovpoaiIACxDDL96R
   HAE7baiD7Oxgy+xuQkzbDhiasB4T7vOk2LLPFd6tFqBgtU9L3nODyxghj
   CjbMtvo4mA/d5MAV5oL4bdvOEMQknr/FdGNEOniDnzjlWvC7PkY88GMck
   xn7OXX9ymme3a8Y7hdlsN6mrbAGbWCqlJji4YaxwDb3PBzKKq/Of0nyo/
   I4s8s3hVOm5SY0AwJqPkXa6imy6ZyK5cMrL/rjzmO6TVwyTWRiHRM5Gg0
   A==;
X-CSE-ConnectionGUID: vNCHiNYTTL26WCtLXQKY4g==
X-CSE-MsgGUID: wHm/0iMgTcuL868m9nBnmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="70673230"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="70673230"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 04:56:09 -0700
X-CSE-ConnectionGUID: cGxAKIUHTweqxLhjbWsh0Q==
X-CSE-MsgGUID: Ck8uVjRtRreS2EWJcefaKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="249150875"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 04:56:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 04:56:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 04:56:08 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 04:56:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEzyvOMhSQEEXRCWmRsJsHddk5LhPC1Lk1eMNWZRy/rTc/BZkoH2Y+rLiJtxVbXlM9+gK4oaV3RGZHmRWlYKa4jS4Kpwa9WDSayoXOSXsb92tVRzrAd1YbSckEzkM8ipIEttgGN3+G2qKtviJFi3BYusNwNYEfhp5Ceme2frdgm9Uto2k9oebbBmBhB1Fx4v5RGyYhv2SXh1c5x7l/5XZ36LLOdYbVzQc7UpW4DXghYNn0aa5/lwLPt0y8oafC6MPwBUM0mmbHAL6b2fE/a/D7K7ISYcD+UemAjrHPE9f9vmcDszzodeaC2szu7UY3Tk+xoB3R+CeehAzcZoz7K7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQo6nTw8wK0j4EMFE1qlEuU9WGUx8PafVEUL2xjtJVQ=;
 b=DoJfXerbc3g45IHnW31jNYydOI4Yqq2NUQuUfyZc3XR2P7AtuDGrzYWhcGltoGxdxa3gNaI+uwqPzkHJ4pN5LQ71d0QiRU/84E2br5tmwSSQ6nhcWRLG/me+ZOOWNCZbyc7vcP5OWDQwZ1wI/E/3q3idFlFIvJYB5d/aIZPS2rjr30dakmydWT0AQe8qQSQgHI3GLGEVXH2O41eyxLAMrqGQetAuI5hTIsSOoBD1UAZDVQ/ikW6v5gcLXUi03YPv8aMUpQdXL5KBCCABJT78JtRlJrgw1KDbLy+eUAJ1TONiPpvkQca/+z27jPiHjbiQdk1VSvxIZDbifl3TFF8Guw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH3PR11MB8341.namprd11.prod.outlook.com (2603:10b6:610:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 11:56:04 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 11:56:04 +0000
Date: Thu, 25 Jun 2026 13:55:52 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <poros@redhat.com>,
	<arkadiusz.kubalewski@intel.com>, <przemyslaw.kitszel@intel.com>,
	<horms@kernel.org>, <aleksandr.loktionov@intel.com>, <pmenzel@molgen.mpg.de>,
	<sx.rinitha@intel.com>
Subject: Re: [PATCH net 1/3] i40e: keep q_vectors array in sync with channel
 count changes
Message-ID: <aj0XSF8U/Y290f2F@boxer>
References: <20260602225513.393338-2-anthony.l.nguyen@intel.com>
 <20260604012707.2843206-1-kuba@kernel.org>
 <25ca3a21-7d29-47e8-a0fb-5fbb7ddfea99@intel.com>
 <20260605163934.547c7bdd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605163934.547c7bdd@kernel.org>
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CH3PR11MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 476b781a-5c29-4ff0-28fa-08ded2b0bc04
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ECQ7FVVVZvfC6owG2abtTd3mLYM0i6+fZZLch9KY0s9CebQ+ralkrQwd8+tpMNEfvSPiLBM9ES4A6hcCjn1IkoCn42mcEsuVQM3AnXs31jeBpWgiv33C7JnPqLgZPNlcFNRdqSGmMp12+4E82TJWrGSDlyFU/3jcHn/0J36xF0RnHbVAxzy/fr1oWenWRdVYL1K0nHB5xRyzrVxBfNRepfpuLjRVbep5E5zS9B0O8jAqZtWvxqGMVMXKVMTuPNoclPBY0kDltcZT/NBm7cxIZawtO2FVcOZB3T4Yu5JRqAdQdE3JkujQuIqUdz5Pa1a9BvbZAZg4t1T8K8lNGSA1S74LeOywZxnwXiiKnAKsBrbkg9zUcIGbgJhq9ldELfCgeC8HsJRVdMVcMSlOtzf3zpZdSiv2S6oec2UpM+zEia8X9lfH/1D45np0HzbkvvzxLlrItwShup6eWx7TeKt6pqaYeM5VbzTUgScMzLeuzkJqavOJ6juZSzYOGlZnIoNjoKQMgwnxXqS3Kn4wMN7kD1y6O688k4Ae9IBOZOexuSrxlR5DreK1MFPEnyRExgCJINH5ZZwr3zS0OUzUN019G9Un8150ECrWfTfbY/jFSurS1rx1sZ0cd3wNVMvDhPL5dIxovWFuqhTbXSxBCgCEV0njEH88rj7ZlvGvvgX/1pk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cLIZ4uXiZVwUd9LKcCtrfGPCaH3Cka5GsJzI5tv/sLjqPwYM+O31EHyj3Mso?=
 =?us-ascii?Q?rvSoBjToOxTzzuV0uanOUo9FYcCaSe6QAVPVx0fHmbdlf5kZ9DHt8ekW9eh2?=
 =?us-ascii?Q?tdh16IbNufTcwv/mC7GnX4sUFS3DrabJDZhzfYBAhaQRctoZD9bjIQIGoTJJ?=
 =?us-ascii?Q?SGRTCcJnyyrWYRssmdrID8CABMuXpqStaeKsx684+4NibkRgTIoU38Zrrq38?=
 =?us-ascii?Q?NNtYB3oDWWuNaODl3BG1ddvJiF846OzFv/hNz7IMPYkTqplJSaqp+v3lWZq2?=
 =?us-ascii?Q?d9vwhs+wBkluhtaM6qs/h90D/aCVtSKW8BD9BpwD97VxNt9/XccXnKhYc8es?=
 =?us-ascii?Q?eoMqslGfHp0w8YMVG2naIY88sUWYu16/Onum45uLjT3qO692XQsYiVcioPuV?=
 =?us-ascii?Q?conGkvHbrp1TdIm9XDZ5Yc/L/QtBSgmsvNvCQnl/3360VYSkp7HKs/32x/ax?=
 =?us-ascii?Q?G5hmzhJMuU9wURJdocB2f6efo8ebuzFrBF2KRJ315gNdPr1gXzJ92OhAAyPv?=
 =?us-ascii?Q?CBAQJLY3RRAbcMKOJpKJuEbXYVVHm0r3BNWR5svj1Wr0CtcswBscMovfnQhn?=
 =?us-ascii?Q?38axYmke0q8otxYD84gRaT90Xjf3Hr4fVWx0JY8heFJp5SiZ4BKb8/KQPPeJ?=
 =?us-ascii?Q?WRWvNh2mOFjzfDIRsnpIjeckc1bcRMPIcCSOfetjfUAFV+DqVQKhjYVYwetb?=
 =?us-ascii?Q?GWW5iFaKnrVA9HwiSA8OESb72SNFcSpNyQbvl+x2n+dBfaWLueCslcfxrQVd?=
 =?us-ascii?Q?9V6h/HpH9w9EtPRD/rIwI3UcrCrRkJbPeQnpyry03pDLDi1kUnUmzu60Fn4t?=
 =?us-ascii?Q?5KTR7UXb5g6l2eLWRyZrP4bBBoDRWxwBvTP62tzzTG/ZJx1SXyddNBhsYUk9?=
 =?us-ascii?Q?G2bMXj+7D2ayHYApqYR6peKPMHNk1j8hAt3oBxCIH+Poui5eWy82n1fW4ylj?=
 =?us-ascii?Q?FJR6lhbe4kbOXWBI+rfzC2j1Is0vcHtK/PEd98d8wIRP0cqsksY3gxGgkudz?=
 =?us-ascii?Q?jxvepNrbDvvFodpSh1bwfIzoTtWHgcB1TzfbhkoPRRstrdUx6flJZzYwr4oW?=
 =?us-ascii?Q?2J30QQvnf+85YsulDEdPYuGGD8h1RoQjSUTA8Bh7vArfxVWCew/duJfZMjFR?=
 =?us-ascii?Q?SRpuYm/6PCam/ufTHzwyQ0+xEzL7N7e1bvMLfIPc2b1cvsK8sk8LDUXdf2+d?=
 =?us-ascii?Q?3Sft9fK1vvpzxiILZA/ccz8uYd083mViH/BiM15p3TXkpMcVC4+9PK3J/Tq7?=
 =?us-ascii?Q?HnsSzh3XP4ysXbaH5Nov4oo+W2PtoAElF+WjIuH5GxSlV56MkJbHy/xfe1Ro?=
 =?us-ascii?Q?d2xOOZpOOzHSpEw6D5c0U0VRHDhvccLxYHXwYCCxP4YucvDzPE99YX5qUI36?=
 =?us-ascii?Q?fcyBFU6+3ldDoU3GjBhP7m/syxueCj+p8ni5RKycttEL5nqoj/gSDRLcBnRA?=
 =?us-ascii?Q?wDQEOWv89Gf7JisTTin+nuPNdBTGPtQUOvGaXKZvCL01zXKtkt4bj+bak6CW?=
 =?us-ascii?Q?RXjQ3562KRCHW2Sy5Ai07IOQGHYF/4EQFwjeTJlrUr5j8fqkYGysqVzkJuh6?=
 =?us-ascii?Q?M1vkTxrj8GPnhWT5keEBEbmdjsP1+0foarGYm9jPzjci9UHjIpULrZSYlx8z?=
 =?us-ascii?Q?L0yvicH7YG19LOQmMQnGlC6Wgqsvr8QdALPElHu7TSq6pW8YJtGgJEqe7ASD?=
 =?us-ascii?Q?jFhbDjZBWbac6rk/+uMva85bTAsnXpQsTMh461EJEjLn7rLjlFpaIwR276af?=
 =?us-ascii?Q?GVr0rWJRH80/+S3D4C0GHuIYLQawSgc=3D?=
X-Exchange-RoutingPolicyChecked: bLydiqVeObvpyiFUWLs2azRC3sAC9R5m6l7SnhKv8uOV9Xnl2e9mynA6JyHALH7qHaaE80wbyYXsDl1mGAu7y4Y4mPTBQml0+rQFsEBEkdHVb5D+WOHJKUrtn0sqaYW2b3tCbfz3t/Yuwh3OVvNb3/UxrrsXvAhE1j1PqjHURy+ZeI6N/VbRlYOmge9PlSUNToNZvPnGcx0xyxabSGGoSkKy0BQAi5VweIOmjjWpRevHyrrxG5yyW7ovJEfR8P/dWzBmqlGd0VdqGltBzm6zAM9JAJNhY/kCivgVLe41xlZiZ6Me/ObD+UhlSTKOQYPamDCzZ86Ew2ZFPpRYQ9Sj8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 476b781a-5c29-4ff0-28fa-08ded2b0bc04
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 11:56:04.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtZ20Flgr0m/bR1rbpYQ780Ae8XRkfDDA6Wz0WmbXyBjgfpR5pFaz3xsJFb26gGHmCBZX938pAQerlp4x4W+u8EHmo3krdhlTfT1eCfNH64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8341
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:poros@redhat.com,m:arkadiusz.kubalewski@intel.com,m:przemyslaw.kitszel@intel.com,m:horms@kernel.org,m:aleksandr.loktionov@intel.com,m:pmenzel@molgen.mpg.de,m:sx.rinitha@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,boxer:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85D686C54D9

On Fri, Jun 05, 2026 at 04:39:34PM -0700, Jakub Kicinski wrote:
> On Fri, 5 Jun 2026 11:01:19 -0700 Tony Nguyen wrote:
> > > Should the new err_lump label, and the existing err_vsi exits from the
> > > two allocation steps above, instead unwind through the err_rings block
> > > (unregister_netdev / free_netdev / i40e_devlink_destroy_port /
> > > i40e_aq_delete_element) the way i40e_vsi_setup()'s err_msix path does?
> > > 
> > > The pre-patch code had the same defective err_vsi target for the
> > > qp_pile and arrays paths, but the patch adds two new failure points
> > > (the unconditional q_vectors kzalloc and the new
> > > i40e_vsi_setup_vectors() call) that route into it during reset
> > > rebuild, where vsi->netdev is already registered.  
> >  
> > This does seem valid, but as mentioned by Sashiko the pre-patch code has 
> > the same target/issue. There's a recent submission [1], with changes 
> > requested, that should cover this. Did you want to take this now or wait 
> > and have it sent with this other one?
> 
> Hm. I convinced myself yesterday that the old code did _not_ 
> have the issue because it was pass false as the second arg to
> i40e_vsi_{alloc,free}_arrays() ? Good chance that I misread,
> it's tricky code. As much as I would love to apply this to prevent 
> the deadlock in NIPA - let's wait for the follow up. I'll pick up 
> the other two patches from this series off the list.

FWIW it was our beloved "pre-existing issue", alloc arrays could fail at
ring memory allocation and bail out without de-registering netdev.

Regardless, I'm gonna send a v4 with preceding patch that should fix
this...

> 

