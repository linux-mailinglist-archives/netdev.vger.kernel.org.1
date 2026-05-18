Return-Path: <netdev+bounces-288982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG5mLwnlCmqJ9AQAu9opvQ
	(envelope-from <netdev+bounces-288982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:08:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92556A5F0
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CE7930EB73F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6841E3E7BDE;
	Mon, 18 May 2026 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxCJuI5S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF5326928;
	Mon, 18 May 2026 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098518; cv=fail; b=bom8RMB2K8bORpdJfUkrXB7Nvz8YQL2azETTDSPtkYncZkhLiRwCKnlWdpLA6VIYNtu5kaJBODccey6a1wYmPXd+hzOOL9MQ89jpYQmdUMnpW4lSiFILDNkqEmUbNyLUoDd42ftnfTXz0b8q9A/C/HIf/TabQC/y3/HBU7u5rgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098518; c=relaxed/simple;
	bh=fQ2gQaiSlXeMncER3P/2kg9an8aj4WnhiMxM3DaeUIM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f98HseRm1bWwFKHlcS1Fz4KSDTb2eATVFI7F7bPViPjaFAlLs+XO8bhNWtaNeDdBp5tElqQewOykLv8lg0d7L/7a+Un/VMrm+6/trc1knW58MmCvkUPAB5XqjAYrecTtdfnGVB6PvDL5AjahS74skAhS/kFhbSKzMdB+ydq3syk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxCJuI5S; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779098516; x=1810634516;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fQ2gQaiSlXeMncER3P/2kg9an8aj4WnhiMxM3DaeUIM=;
  b=lxCJuI5SHZ59+gamL6TJ+WCxfqg51T0lS574zRqxj/boCXR7Owy4XP4o
   o2Iab2nGaN/ZbW1FUnpyJDD3XGmKqJIwNi+sdgvURy2h++Opc84a7B2Yy
   7+zdaXEUtufs802DLCnb5D/wWaiI7926iji3nks+lv0cOpOK2b9FcTFWk
   FGEs8rhLZMkoNsfrphzMzrSkKeafaWjZ0l/dP71F9T80vIpG7pV4uI6Ia
   Lxn2UQo5AuEq5P07CSv0nx3txOYKm8hY3XyjP6RxTN9c+F0k6mX7Auh2a
   WaBhxMd190cLBbnS7/owaJyPuQ5qCi9+9yzhxMgVO4ombTvwwj7PfUVRy
   w==;
X-CSE-ConnectionGUID: zxc+ty+CTrGqcbDu2Mefhw==
X-CSE-MsgGUID: k9BWG/oEQ2eyxjb0H4Jamw==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79085515"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79085515"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:01:54 -0700
X-CSE-ConnectionGUID: qIcFEKR8RDiRLfFHhcpwkQ==
X-CSE-MsgGUID: 0anmymhUSPSRiOEZsy0lcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="232992848"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:01:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 03:01:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 03:01:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 03:01:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcsK0su09ol5tlrmNCO/C23zq543+KO2nuSWr9mNat41guHxxA4alh5CKaU2/jSoeAUR23/QvV94ipeKXJ1h7Jp1KGSFxqJ1Eb8Ejk8AFOQ+Gzy5NDoardIqto3nUIccMCWMt8pBN42PLrQ3O0cpwmwlv51U15JVwzSQcYWAhZK20lWUGZ1HszNXkYfGfiG9FczlWO+4t760jb00wurjlhNIzsTSBpDKuL3gOxTgkqNcWx93dXyi0XC1EkYI++BnloPO7zbfoeMVSnTedc3RJgHTSqoM9wZ5gfEdT145sUd1hNAwGXZXt//Y4dN1tPebZOCV4X4yrCmHlu4gtGf11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6MHWUJ3MTCU/mkHDIi6YtDrXU+5GBA7xf2Iz1BpSRY=;
 b=DSXd2StqqX3AUVQhHx/yJmdadD6k2Ve6Ksn3i6144aVwo8rH+51Jb3H1EJ8NxkVeLG0+OQcG2WexDEtpXim711k1vZSLtt8hsfTQqNdjus5expxsGnxeF3oGpZa6FutXG/nUgyz29NB2q4bOOKFkWsRQAYo03agwsbkAxoob/pU3PeDC9BwaFpwEtRqcWdHvLaS0HyJfeSBQuT8i2+VzsKmXNjT3yvLBpdKjhhw+rLzxq14YnNrXgqTYHKnItAQNdcrpyOxEtCIVBhtPHRPRdqvYvYmfgyl7JDTejzAdxQuz/78F+O/43qvFeBxfiADNLqhpq7E9L8IOa8xiBnI8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB7776.namprd11.prod.outlook.com (2603:10b6:208:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 10:01:43 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 10:01:42 +0000
Date: Mon, 18 May 2026 12:01:29 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	Bharath R <Bharath.r@intel.com>
Subject: Re: [PATCH net-next v3 13/14] ixd: add the core initialization
Message-ID: <agrjeYgxHqYE17TW@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-14-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260515224443.2772147-14-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1PR06CA0182.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::39) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 37136b09-ab88-4047-d645-08deb4c47636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|3023799003|4143699003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l+B/V3Ha1NksgZMjqI4l+hILZC6aEYIxn9h2I+xILYkiyki1MzQtmHiQXM/siskgqvctgmvAGzdhIm6sB6ntRbTFtiy1fHo+yIIVk4apEwQfFNz5ez8dvq9JxM9h0RhRqBzXihSe0FqSeadQPR7fm8NvQkv5aWqo4KtIXtu7wmZZKstcvPuBVTGgcd4SsEpBxSQG7yJGoPvOl9bdPqhSipCWorUdYRlMXx1FicmK3PYzNPw+Csw7cFUrRlAHOsYljORLn0+q3cRuGKpDGruF6kcuqnxqopiY5fXq1hiZomlrCzc0qUtSYAo/7U0YIlMh/dOpxCS1hPvO5pD7zQxrnnyc31XfjHQ+3qd3bVmewdvie/v4CstIOPhod6oHyCLvzhBg/tfPwAIIpPZRfvfhxSjhXSAmqU7AC4JYeYpmJavviLMtFv0rVnTkWRIumgsqsNcSVHEEtMKrI27/cy2ABVjn/msN8+4Ts9zIpqe/Rf5yWOifkqmjUYsmt5Ub+cayO85nRRk32OLWgo5P3mPwR9ZFUzdgsQHiHl3uInR68Dz0RiGVKtx0oya02f9ch/OQauqBnxm4giGtOpWyvNTH4tz+Ryd7JNyaJwWbHLmDgpC867i+BkYL/o9Is8EWYH1Wqo0FoM4opuDsOWrTrmQj4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(3023799003)(4143699003)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WPfxXB6LCTKhBaCmZmsKp+tyYw1FPpDg6Ywji0OCZZ1d3CDnSjPSsZnq2/4Z?=
 =?us-ascii?Q?zIYx2suNbRThce6OrS7QtJ63/dk47VRKqmVbBBvYqW34I0P/KH/NXXbXIbMI?=
 =?us-ascii?Q?3ha+oc7vrGK9DRJN2ahOmjpDrid9A8wOOHQ7gCqzCSxga+hzocAUSQlaK2o1?=
 =?us-ascii?Q?dZCH2OMrblqhZRNYhwWlwKy7PaUz10qbeJkYa+aMTuNPjoJBwutQAkE8X/Fp?=
 =?us-ascii?Q?b+rvcW8tH7zj8O3O1xQFSdm08tgr7DVC4ZT0NBVFipYhMSjAYzjXDj5zlPWX?=
 =?us-ascii?Q?3cJD+rsQWmb4P6QnZX18WjCbphfsP3jnsCUeg/dHmmioxHNCn5951NeJ7zXA?=
 =?us-ascii?Q?cS8DOBjnS42BRj36uhaW+7QJ/kKUQGcWdXIwrjAOe2WcriWO9C+8eUgygBWe?=
 =?us-ascii?Q?H6m+ew4/uWTuuC9uMvt1YFjBvZDyNNfaXFcPeFcXybGJjWeuOyxqZuwRMTG7?=
 =?us-ascii?Q?qMxQkHyF8s7Iwv4PD8pNMnWxFnynZgPbq4EDz4KNLVuXm/wr1YaK3/Ktl3dG?=
 =?us-ascii?Q?8q9yT7QVS67j41HZ/KvbAO91XyaSM8XYaQqOoUqs/hdSSgeGBXFOvxqWcJks?=
 =?us-ascii?Q?VxYvoMZUl3Ps+IICJST9C1dxNQ3JFZpwnlfMc/pxAoKypAu6JDkBWQqlT5TT?=
 =?us-ascii?Q?s3SBUdSFNAR7iKwTcvF7Ob2Gwm+Dq1VDhjjWFXNzdB2mXgHQdPVwhCqsyhl8?=
 =?us-ascii?Q?wpiRz9Rjb0zZ53L4geVXLlXaAFtjxFta+AuI/eXhcX50kLuuD3KaHRpxniWd?=
 =?us-ascii?Q?gcM4FWfnFPzu3ghnGNh32xU/0kWjwsaLcBm04MDcDP7QPX/guxvbIBJeeXmJ?=
 =?us-ascii?Q?+qN0ur1IrAW8SVyX/fzQMBZvCnBA1pPbAdJ0QEb6wj2nyyGGR/ihHSFbZdeh?=
 =?us-ascii?Q?zvH1S5m+l73NjmnD0QQBD9UKN/Vx1Mf66wWdnN6rsJ7gIrTofoPGDs4/pj2I?=
 =?us-ascii?Q?ODiiUrYpjFTP2ihtrg53ZuqJ8/BJyGFMFv0VixHwS3wnNnwlC+Rrv3QiwNsG?=
 =?us-ascii?Q?r2vEM7Fh5u+Rr8U5XoYdenURhFhkjzDSNvJNJLxNe26GVoxB7r/luQuYduw3?=
 =?us-ascii?Q?qZkb/SK+pQXjqpa1c384+aDop+jAbCqBUH9ye+J/PHPq3KVbbJ05tf6mdbir?=
 =?us-ascii?Q?9zIaFIY5YaToZLyxPpJnJTq4NT4tXyP2SZXWjpFhrRhogBJvQLpYuZp4zm0m?=
 =?us-ascii?Q?E1NgvJDcz0AiE43M04zWxQiJF1x2+jo8LaKZNgb8baapW0DYTeELSAD93kkz?=
 =?us-ascii?Q?GJrUOznbp1vZMUGRuJuZdW25so0INkYdASSyW3+awFIjYXeZ0AZlFAqAPu6Y?=
 =?us-ascii?Q?o3shGncIgwRibOYEpn3bIbjG0IXccvk9KYL7dYqLriK2wZEcwO+DZtpccKf5?=
 =?us-ascii?Q?UnF49pFtueFwyYj7BdUnrcqYErN/UH73UMm/V36uyMWIL20Xjbo+C+G4HmU9?=
 =?us-ascii?Q?pd5rBgBPeYTDSXTxCF3hhfvhWrV/Fm/Lusogjv4pjJAJUGDTnS/lmVd+mvHh?=
 =?us-ascii?Q?gC54qV23G0sRzflwR9X6gkZoOoGoBAL2nd/Mr3TYSeV4XBI9oXpw2ln2IAZU?=
 =?us-ascii?Q?1p/CHQ0NYZSBlpF3yCKSOKbXM54/GR+A6tvB9TugOXKsQOV1p1SJY2LXXzem?=
 =?us-ascii?Q?qDxNPATVfYaY0LuRJM1b2M7KcPywre9ESOyAG4XsK6+9/zGx6m4oj7Hczjrk?=
 =?us-ascii?Q?fUbvRjVszhbK0WBZnTiBRzZrKa86BtqKHAfFVHnOIBV78kRRzVZ0KnxrsuZQ?=
 =?us-ascii?Q?pgrKVw5HCRXzhgygow6L/a/Gqa9ljcM1NUDdgeITxSJucds7bbwSmtwkWyGg?=
X-MS-Exchange-AntiSpam-MessageData-1: zfuMKQf8lhEv/l27ABwn8KDTileWZ3MBb+c=
X-Exchange-RoutingPolicyChecked: nWggkvFWILFrxQPkU0KUPCehphzF6K15JUId1ayGDaT/sJytM2/KZy2pgA8lF+GlvKEaEdf0Dcmgz++JHIooSq38ZLTklRhxYdqSWciWs039is3lb+LdHlTthXIK1ytQh5hC4I3ejbIjAlebcvif6OLTyYPAAqVpRletWILNPrC0GYM15G2k5Mn+5xGbdyRCcONRFI/rNfpfjmmUXAidj/mHvPmcUKxT7dmkPjdnKOWCBfZAHVaFTqsM7Pgv4g11WMZYRkMTa0DPU0J1LhKDMUjhU0K2b1PyLL3/WQ/o2mRX86JelZHfgQuIhCgzHflffMo1AGBF4buy07Fsvj9KdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 37136b09-ab88-4047-d645-08deb4c47636
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:01:42.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6v2zkNzhEFE2ZITo67nxdvkmQYF3yJhVGggMXBV9Mjl/ec74J42hi2aDRocDQnwxcs5P7R4WkEDVf5KKi9R5yxDL1Fu7eUEm5gE3aqOt9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7776
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 1A92556A5F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288982-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,intel.com:email,intel.com:dkim,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 03:44:37PM -0700, Tony Nguyen wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> As the mailbox is setup, initialize the core. This makes use of the send
> and receive mailbox message framework for virtchnl communication between
> the driver and device Control Plane (CP).
> 
> To start with, driver confirms the virtchnl version with the CP. Once that
> is done, it requests and gets the required capabilities and resources
> needed such as max vectors, queues, vports etc.
> 
> Use a unified way of handling the virtchnl messages, where a single
> function handles all related memory management and the caller only provides
> the callbacks to fill the send buffer and to handle the response.
> 
> Place generic control queue message handling separately to facilitate the
> addition of protocols other than virtchannel in the future.
>

Regarding Sashiko feedback [0]:

1. Major version handling is OK.
2. Regarding other concerns, I think code is good enough for an introductory 
   boilerplate patch. Below is a diff addressing those issues, it still does not 
   handle HW Tx queue stalls, but I think this is fine at this development 
   stage.

diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
index 216aa5c02122..1b8f1394754b 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
@@ -62,8 +62,8 @@ static void ixd_ctlq_init_sparams(struct ixd_adapter *adapter,
  */
 int ixd_ctlq_do_req(struct ixd_adapter *adapter, const struct ixd_ctlq_req *req)
 {
+       u8 onstack_send_buff[LIBIE_CP_TX_COPYBREAK] __aligned_largest = {};
        struct libie_ctlq_xn_send_params send_params = {};
-       u8 onstack_send_buff[LIBIE_CP_TX_COPYBREAK] = {};
        struct kvec *recv_mem;
        void *send_buff;
        int err;
@@ -82,6 +82,7 @@ int ixd_ctlq_do_req(struct ixd_adapter *adapter, const struct ixd_ctlq_req *req)
                req->send_buff_init(adapter, send_buff, req->ctx);

        err = libie_ctlq_xn_send(&send_params);
+       ixd_ctlq_clean_sq(adapter, 1);
        if (err)
                return err;

@@ -90,7 +91,6 @@ int ixd_ctlq_do_req(struct ixd_adapter *adapter, const struct ixd_ctlq_req *req)
                err = req->recv_process(adapter, recv_mem->iov_base,
                                        recv_mem->iov_len, req->ctx);

-       ixd_ctlq_clean_sq(adapter, 1);
        libie_ctlq_release_rx_buf(recv_mem);

        return err;


[0] https://sashiko.dev/#/patchset/20260515224443.2772147-1-anthony.l.nguyen%40intel.com

> Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <Bharath.r@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ixd/Makefile       |   2 +
>  drivers/net/ethernet/intel/ixd/ixd.h          |  10 +
>  drivers/net/ethernet/intel/ixd/ixd_ctlq.c     | 149 +++++++++++++++
>  drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |  33 ++++
>  drivers/net/ethernet/intel/ixd/ixd_lib.c      |  25 ++-
>  drivers/net/ethernet/intel/ixd/ixd_main.c     |   3 +
>  drivers/net/ethernet/intel/ixd/ixd_virtchnl.c | 178 ++++++++++++++++++
>  drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |  12 ++
>  8 files changed, 411 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
> 
> diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
> index 164b2c86952f..90abf231fb16 100644
> --- a/drivers/net/ethernet/intel/ixd/Makefile
> +++ b/drivers/net/ethernet/intel/ixd/Makefile
> @@ -6,5 +6,7 @@
>  obj-$(CONFIG_IXD) += ixd.o
>  
>  ixd-y := ixd_main.o
> +ixd-y += ixd_ctlq.o
>  ixd-y += ixd_dev.o
>  ixd-y += ixd_lib.o
> +ixd-y += ixd_virtchnl.o
> diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
> index 99c44f2aa659..98d1f22534b5 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd.h
> +++ b/drivers/net/ethernet/intel/ixd/ixd.h
> @@ -10,19 +10,29 @@
>   * struct ixd_adapter - Data structure representing a CPF
>   * @cp_ctx: Control plane communication context
>   * @init_task: Delayed initialization after reset
> + * @mbx_task: Control queue Rx handling
>   * @xnm: virtchnl transaction manager
>   * @asq: Send control queue info
>   * @arq: Receive control queue info
> + * @vc_ver: Negotiated virtchnl version
> + * @caps: Negotiated virtchnl capabilities
>   */
>  struct ixd_adapter {
>  	struct libie_ctlq_ctx cp_ctx;
>  	struct {
>  		struct delayed_work init_work;
>  		u8 reset_retries;
> +		u8 vc_retries;
>  	} init_task;
> +	struct delayed_work mbx_task;
>  	struct libie_ctlq_xn_manager *xnm;
>  	struct libie_ctlq_info *asq;
>  	struct libie_ctlq_info *arq;
> +	struct {
> +		u32 major;
> +		u32 minor;
> +	} vc_ver;
> +	struct virtchnl2_get_capabilities caps;
>  };
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
> new file mode 100644
> index 000000000000..216aa5c02122
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#include "ixd.h"
> +#include "ixd_ctlq.h"
> +#include "ixd_virtchnl.h"
> +
> +/**
> + * ixd_ctlq_clean_sq - Clean the send control queue after sending the message
> + * @adapter: The adapter that sent the messages
> + * @num_sent: Number of sent messages to be released
> + *
> + * Free the libie send resources after sending the message and handling
> + * the response.
> + */
> +static void ixd_ctlq_clean_sq(struct ixd_adapter *adapter, u16 num_sent)
> +{
> +	if (!num_sent)
> +		return;
> +
> +	struct libie_ctlq_xn_clean_params params = {
> +		.ctlq = adapter->asq,
> +		.ctx = &adapter->cp_ctx,
> +		.num_msgs = num_sent,
> +		.rel_tx_buf = kfree,
> +	};
> +
> +	libie_ctlq_xn_send_clean(&params);
> +}
> +
> +/**
> + * ixd_ctlq_init_sparams - Initialize control queue send parameters
> + * @adapter: The adapter with initialized mailbox
> + * @sparams: Parameters to initialize
> + * @msg_buf: DMA-mappable pointer to the message being sent
> + * @msg_size: Message size
> + */
> +static void ixd_ctlq_init_sparams(struct ixd_adapter *adapter,
> +				  struct libie_ctlq_xn_send_params *sparams,
> +				  void *msg_buf, size_t msg_size)
> +{
> +	*sparams = (struct libie_ctlq_xn_send_params) {
> +		.rel_tx_buf = kfree,
> +		.xnm = adapter->xnm,
> +		.ctlq = adapter->asq,
> +		.timeout_ms = IXD_CTLQ_TIMEOUT,
> +		.send_buf = (struct kvec) {
> +			.iov_base = msg_buf,
> +			.iov_len = msg_size,
> +		},
> +	};
> +}
> +
> +/**
> + * ixd_ctlq_do_req - Perform a standard virtchnl request
> + * @adapter: The adapter with initialized mailbox
> + * @req: virtchnl request description
> + *
> + * Return: %0 if a message was sent and received a response
> + * that was successfully handled by the custom callback,
> + * negative error otherwise.
> + */
> +int ixd_ctlq_do_req(struct ixd_adapter *adapter, const struct ixd_ctlq_req *req)
> +{
> +	struct libie_ctlq_xn_send_params send_params = {};
> +	u8 onstack_send_buff[LIBIE_CP_TX_COPYBREAK] = {};
> +	struct kvec *recv_mem;
> +	void *send_buff;
> +	int err;
> +
> +	send_buff = libie_cp_can_send_onstack(req->send_size) ?
> +		    &onstack_send_buff : kzalloc(req->send_size, GFP_KERNEL);
> +	if (!send_buff)
> +		return -ENOMEM;
> +
> +	ixd_ctlq_init_sparams(adapter, &send_params, send_buff,
> +			      req->send_size);
> +
> +	send_params.chnl_opcode = req->opcode;
> +
> +	if (req->send_buff_init)
> +		req->send_buff_init(adapter, send_buff, req->ctx);
> +
> +	err = libie_ctlq_xn_send(&send_params);
> +	if (err)
> +		return err;
> +
> +	recv_mem = &send_params.recv_mem;
> +	if (req->recv_process)
> +		err = req->recv_process(adapter, recv_mem->iov_base,
> +					recv_mem->iov_len, req->ctx);
> +
> +	ixd_ctlq_clean_sq(adapter, 1);
> +	libie_ctlq_release_rx_buf(recv_mem);
> +
> +	return err;
> +}
> +
> +/**
> + * ixd_ctlq_handle_msg - Default control queue message handler
> + * @ctx: Control plane communication context
> + * @msg: Message received
> + */
> +static void ixd_ctlq_handle_msg(struct libie_ctlq_ctx *ctx,
> +				struct libie_ctlq_msg *msg)
> +{
> +	struct ixd_adapter *adapter = pci_get_drvdata(ctx->mmio_info.pdev);
> +
> +	if (ixd_vc_can_handle_msg(msg))
> +		ixd_vc_recv_event_msg(adapter, msg);
> +	else
> +		dev_dbg_ratelimited(ixd_to_dev(adapter),
> +				    "Received an unsupported opcode 0x%x from the CP\n",
> +				    msg->chnl_opcode);
> +
> +	libie_ctlq_release_rx_buf(&msg->recv_mem);
> +}
> +
> +/**
> + * ixd_ctlq_recv_mb_msg - Receive a potential message over mailbox periodically
> + * @adapter: The adapter with initialized mailbox
> + */
> +static void ixd_ctlq_recv_mb_msg(struct ixd_adapter *adapter)
> +{
> +	struct libie_ctlq_xn_recv_params xn_params = {
> +		.xnm = adapter->xnm,
> +		.ctlq = adapter->arq,
> +		.ctlq_msg_handler = ixd_ctlq_handle_msg,
> +		.budget = LIBIE_CTLQ_MAX_XN_ENTRIES,
> +	};
> +
> +	libie_ctlq_xn_recv(&xn_params);
> +}
> +
> +/**
> + * ixd_ctlq_rx_task - Periodically check for mailbox responses and events
> + * @work: work handle
> + */
> +void ixd_ctlq_rx_task(struct work_struct *work)
> +{
> +	struct ixd_adapter *adapter;
> +
> +	adapter = container_of(work, struct ixd_adapter, mbx_task.work);
> +
> +	queue_delayed_work(system_unbound_wq, &adapter->mbx_task,
> +			   msecs_to_jiffies(300));
> +
> +	ixd_ctlq_recv_mb_msg(adapter);
> +}
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.h b/drivers/net/ethernet/intel/ixd/ixd_ctlq.h
> new file mode 100644
> index 000000000000..e7191d3870b7
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef _IXD_CTLQ_H_
> +#define _IXD_CTLQ_H_
> +
> +#include <linux/intel/virtchnl2.h>
> +
> +#define IXD_CTLQ_TIMEOUT 2000
> +
> +/**
> + * struct ixd_ctlq_req - Standard virtchnl request description
> + * @opcode: protocol opcode, only virtchnl2 is needed for now
> + * @send_size: required length of the send buffer
> + * @send_buff_init: function to initialize the allocated send buffer
> + * @recv_process: function to handle the CP response
> + * @ctx: additional context for callbacks
> + */
> +struct ixd_ctlq_req {
> +	enum virtchnl2_op opcode;
> +	size_t send_size;
> +	void (*send_buff_init)(struct ixd_adapter *adapter, void *send_buff,
> +			       void *ctx);
> +	int (*recv_process)(struct ixd_adapter *adapter, void *recv_buff,
> +			    size_t recv_size, void *ctx);
> +	void *ctx;
> +};
> +
> +int ixd_ctlq_do_req(struct ixd_adapter *adapter,
> +		    const struct ixd_ctlq_req *req);
> +void ixd_ctlq_rx_task(struct work_struct *work);
> +
> +#endif /* _IXD_CTLQ_H_ */
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
> index afc413d3650f..24080cb30c43 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
> +++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
> @@ -2,6 +2,7 @@
>  /* Copyright (C) 2025 Intel Corporation */
>  
>  #include "ixd.h"
> +#include "ixd_virtchnl.h"
>  
>  #define IXD_DFLT_MBX_Q_LEN 64
>  
> @@ -67,6 +68,8 @@ static void ixd_adapter_fill_dflt_ctlqs(struct ixd_adapter *adapter)
>   */
>  void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter)
>  {
> +	cancel_delayed_work_sync(&adapter->mbx_task);
> +
>  	if (adapter->xnm)
>  		libie_ctlq_xn_deinit(adapter->xnm, &adapter->cp_ctx);
>  
> @@ -108,6 +111,8 @@ int ixd_init_dflt_mbx(struct ixd_adapter *adapter)
>  		return -ENOENT;
>  	}
>  
> +	queue_delayed_work(system_unbound_wq, &adapter->mbx_task, 0);
> +
>  	return 0;
>  }
>  
> @@ -136,8 +141,26 @@ void ixd_init_task(struct work_struct *work)
>  
>  	adapter->init_task.reset_retries = 0;
>  	err = ixd_init_dflt_mbx(adapter);
> -	if (err)
> +	if (err) {
>  		dev_err(ixd_to_dev(adapter),
>  			"Failed to initialize the default mailbox: %pe\n",
>  			ERR_PTR(err));
> +		return;
> +	}
> +
> +	if (!ixd_vc_dev_init(adapter)) {
> +		adapter->init_task.vc_retries = 0;
> +		return;
> +	}
> +
> +	ixd_deinit_dflt_mbx(adapter);
> +	if (++adapter->init_task.vc_retries > 5) {
> +		dev_err(ixd_to_dev(adapter),
> +			"Failed to establish mailbox communications with the hardware\n");
> +		return;
> +	}
> +
> +	ixd_trigger_reset(adapter);
> +	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
> +			   msecs_to_jiffies(500));
>  }
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
> index b4d4000b63ed..6d5e6aca77df 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd_main.c
> +++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
> @@ -2,6 +2,7 @@
>  /* Copyright (C) 2025 Intel Corporation */
>  
>  #include "ixd.h"
> +#include "ixd_ctlq.h"
>  #include "ixd_lan_regs.h"
>  
>  MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
> @@ -19,6 +20,7 @@ static void ixd_remove(struct pci_dev *pdev)
>  
>  	/* Do not mix removal with (re)initialization */
>  	cancel_delayed_work_sync(&adapter->init_task.init_work);
> +
>  	/* Leave the device clean on exit */
>  	ixd_trigger_reset(adapter);
>  	ixd_deinit_dflt_mbx(adapter);
> @@ -110,6 +112,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	INIT_DELAYED_WORK(&adapter->init_task.init_work,
>  			  ixd_init_task);
> +	INIT_DELAYED_WORK(&adapter->mbx_task, ixd_ctlq_rx_task);
>  
>  	ixd_trigger_reset(adapter);
>  	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
> new file mode 100644
> index 000000000000..66049d1b1d15
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#include "ixd.h"
> +#include "ixd_ctlq.h"
> +#include "ixd_virtchnl.h"
> +
> +/**
> + * ixd_vc_recv_event_msg - Handle virtchnl event message
> + * @adapter: The adapter handling the message
> + * @ctlq_msg: Message received
> + */
> +void ixd_vc_recv_event_msg(struct ixd_adapter *adapter,
> +			   struct libie_ctlq_msg *ctlq_msg)
> +{
> +	int payload_size = ctlq_msg->data_len;
> +	struct virtchnl2_event *v2e;
> +
> +	if (payload_size < sizeof(*v2e)) {
> +		dev_warn_ratelimited(ixd_to_dev(adapter),
> +				     "Failed to receive valid payload for event msg (op 0x%X len %u)\n",
> +				     ctlq_msg->chnl_opcode,
> +				     payload_size);
> +		return;
> +	}
> +
> +	v2e = (struct virtchnl2_event *)ctlq_msg->recv_mem.iov_base;
> +
> +	dev_dbg(ixd_to_dev(adapter), "Got event 0x%X from the CP\n",
> +		le32_to_cpu(v2e->event));
> +}
> +
> +/**
> + * ixd_vc_can_handle_msg - Decide if an event has to be handled by virtchnl code
> + * @ctlq_msg: Message received
> + *
> + * Return: %true if virtchnl code can handle the event, %false otherwise
> + */
> +bool ixd_vc_can_handle_msg(struct libie_ctlq_msg *ctlq_msg)
> +{
> +	return ctlq_msg->chnl_opcode == VIRTCHNL2_OP_EVENT;
> +}
> +
> +/**
> + * ixd_handle_caps - Handle VIRTCHNL2_OP_GET_CAPS response
> + * @adapter: The adapter for which the capabilities are being updated
> + * @recv_buff: Buffer containing the response
> + * @recv_size: Response buffer size
> + * @ctx: unused
> + *
> + * Return: %0 if the response format is correct and was handled as expected,
> + * negative error otherwise.
> + */
> +static int ixd_handle_caps(struct ixd_adapter *adapter, void *recv_buff,
> +			   size_t recv_size, void *ctx)
> +{
> +	if (recv_size < sizeof(adapter->caps))
> +		return -EBADMSG;
> +
> +	adapter->caps = *(typeof(adapter->caps) *)recv_buff;
> +
> +	return 0;
> +}
> +
> +/**
> + * ixd_req_vc_caps - Request and save device capability
> + * @adapter: The adapter to get the capabilities for
> + *
> + * Return: success or error if sending the get capability message fails
> + */
> +static int ixd_req_vc_caps(struct ixd_adapter *adapter)
> +{
> +	const struct ixd_ctlq_req req = {
> +		.opcode = VIRTCHNL2_OP_GET_CAPS,
> +		.send_size = sizeof(struct virtchnl2_get_capabilities),
> +		.ctx = NULL,
> +		.send_buff_init = NULL,
> +		.recv_process = ixd_handle_caps,
> +	};
> +
> +	return ixd_ctlq_do_req(adapter, &req);
> +}
> +
> +/**
> + * ixd_get_vc_ver - Get version info from adapter
> + *
> + * Return: filled in virtchannel2 version info, ready for sending
> + */
> +static struct virtchnl2_version_info ixd_get_vc_ver(void)
> +{
> +	return (struct virtchnl2_version_info) {
> +		.major = cpu_to_le32(VIRTCHNL2_VERSION_MAJOR_2),
> +		.minor = cpu_to_le32(VIRTCHNL2_VERSION_MINOR_0),
> +	};
> +}
> +
> +static void ixd_fill_vc_ver(struct ixd_adapter *adapter, void *send_buff,
> +			    void *ctx)
> +{
> +	*(struct virtchnl2_version_info *)send_buff = ixd_get_vc_ver();
> +}
> +
> +/**
> + * ixd_handle_vc_ver - Handle VIRTCHNL2_OP_VERSION response
> + * @adapter: The adapter for which the version is being updated
> + * @recv_buff: Buffer containing the response
> + * @recv_size: Response buffer size
> + * @ctx: Unused
> + *
> + * Return: %0 if the response format is correct and was handled as expected,
> + * negative error otherwise.
> + */
> +static int ixd_handle_vc_ver(struct ixd_adapter *adapter, void *recv_buff,
> +			     size_t recv_size, void *ctx)
> +{
> +	struct virtchnl2_version_info need_ver = ixd_get_vc_ver();
> +	struct virtchnl2_version_info *recv_ver;
> +
> +	if (recv_size < sizeof(need_ver))
> +		return -EBADMSG;
> +
> +	recv_ver = recv_buff;
> +	if (le32_to_cpu(need_ver.major) > le32_to_cpu(recv_ver->major))
> +		return -EOPNOTSUPP;
> +
> +	adapter->vc_ver.major = le32_to_cpu(recv_ver->major);
> +	adapter->vc_ver.minor = le32_to_cpu(recv_ver->minor);
> +
> +	return 0;
> +}
> +
> +/**
> + * ixd_req_vc_version - Request and save Virtchannel2 version
> + * @adapter: The adapter to get the version for
> + *
> + * Return: success or error if sending fails or the response was not as expected
> + */
> +static int ixd_req_vc_version(struct ixd_adapter *adapter)
> +{
> +	const struct ixd_ctlq_req req = {
> +		.opcode = VIRTCHNL2_OP_VERSION,
> +		.send_size = sizeof(struct virtchnl2_version_info),
> +		.ctx = NULL,
> +		.send_buff_init = ixd_fill_vc_ver,
> +		.recv_process = ixd_handle_vc_ver,
> +	};
> +
> +	return ixd_ctlq_do_req(adapter, &req);
> +}
> +
> +/**
> + * ixd_vc_dev_init - virtchnl device core initialization
> + * @adapter: device information
> + *
> + * Return: %0 on success or error if any step of the initialization fails
> + */
> +int ixd_vc_dev_init(struct ixd_adapter *adapter)
> +{
> +	int err;
> +
> +	err = ixd_req_vc_version(adapter);
> +	if (err) {
> +		dev_warn(ixd_to_dev(adapter),
> +			 "Getting virtchnl version failed, error=%pe\n",
> +			 ERR_PTR(err));
> +		return err;
> +	}
> +
> +	err = ixd_req_vc_caps(adapter);
> +	if (err) {
> +		dev_warn(ixd_to_dev(adapter),
> +			 "Getting virtchnl capabilities failed, error=%pe\n",
> +			 ERR_PTR(err));
> +		return err;
> +	}
> +
> +	return err;
> +}
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
> new file mode 100644
> index 000000000000..1a53da8b545c
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef _IXD_VIRTCHNL_H_
> +#define _IXD_VIRTCHNL_H_
> +
> +int ixd_vc_dev_init(struct ixd_adapter *adapter);
> +bool ixd_vc_can_handle_msg(struct libie_ctlq_msg *ctlq_msg);
> +void ixd_vc_recv_event_msg(struct ixd_adapter *adapter,
> +			   struct libie_ctlq_msg *ctlq_msg);
> +
> +#endif /* _IXD_VIRTCHNL_H_ */
> -- 
> 2.47.1
> 

