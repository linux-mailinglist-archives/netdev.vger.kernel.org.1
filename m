Return-Path: <netdev+bounces-288985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOg0Ef/nCmoE9QQAu9opvQ
	(envelope-from <netdev+bounces-288985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:20:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB456A924
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA3D7301C6AF
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B531E841;
	Mon, 18 May 2026 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJk0RDa6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5231714F;
	Mon, 18 May 2026 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099124; cv=fail; b=uelOWQXdBDI84okOYRUtxTK5a4G9MeEjdSzRqW5NnhFwiIHixhBgGnRSD7OcB3cgYWupIXqt7151U7Wnali/Td8pIHXYdUw+qNK4J4OoWF3aThhTnuPFSDHk9QXyEJBrLEgnec9Q/gAa60oSCNoImasRlA//MITdAz+7mQ+g1r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099124; c=relaxed/simple;
	bh=QkZz+MRnYLEVm9qsdmj5cXbG6eNQNTWUwozLlLYoKwo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ub4XUJpSs7oZORShvM0/SkdI29KhRCLrYEntxbTKijfFGz5VUxrtXFvNs+MEth4kiLXcuHJWyFfcn9Tr3er/twWkcKjppcdiLUdrCRyXcJ2sa8RPUzBA7vDk5nniTrMrkLFBzgmmDY2bIfY6wjLyhHbHpCQS96NF09oCrUUNKfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJk0RDa6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779099123; x=1810635123;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QkZz+MRnYLEVm9qsdmj5cXbG6eNQNTWUwozLlLYoKwo=;
  b=ZJk0RDa6PtV9rHPoWpmPEngDW6cQjvqeHbY1Yo5ucNwHBi/b8sdbKjL5
   UYaxUbtVDGK4iGnO3Q3QiGnRcswF6X8yi/eipvLB2S9VLz3IMFdwcMkwV
   mYB6rK7W03WqZ4gnMyvVYi0Vdu2/wTxchkT0Lep+HWsm7SiofralU7KmW
   y/ar2kmNnWNQw1wZiaT3tYAW34uYkLBYjq9c6QkduQwE9lwZIklSNRy+e
   PSe1duSevKd6b6jWqykB5ufHMzM7KeWydTogZiWRE3Q3bVaqIrfVy6aTl
   XzYetmYvvEZ4uT4u73FMFgI3kvofTgrL6cU6mcqAS6PTgBdAgTvLIbWPQ
   g==;
X-CSE-ConnectionGUID: Zw1DmFjUQeiLBKwUzsKRfg==
X-CSE-MsgGUID: prurI/FuR8mkK42Vxp4eOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="90529420"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="90529420"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:12:02 -0700
X-CSE-ConnectionGUID: TWIJeq2zTLuk21S70X4k5w==
X-CSE-MsgGUID: lrWz2b0xQwqDSDhb0R2ibA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="244366477"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:12:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 03:12:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 03:12:01 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 03:12:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myjuUG4O13250I/eTXIdz+l6UaaaDYz5vDILNi/0I6p+4MFbnemRurGEEgW4IZH2zqBDaXBntTfgXDGQNeOWnWfJtzl2qPZVd2duYe8upzekQY8rOtbJ4GJ8ca4vSeG/wOdIJEmSQVyfstM/r+zZNth1X5/JFMOBFMj3oTM50bsFVIpGHlWZzizfHLp8XiqOCvEwyq7/jStFjnVlySiOiZw22+6uxQubB4Cbcc5nXcCpYTMn9vvmx5AqAKHHbus36tJKh3qq/a+6TjKhw3wL1hp0LUe8P6KzzTzZ+FwOpqnMz5MBPBKvSKHqbok+XrOgAU4ImAm4VF+SwQwuTS06Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55kofR25h/x7cSA99ZGuj5t3+lAafGvNvcRSFUHWcD4=;
 b=WItVv34eLrI751z1cxg/FMIFd2CtGpNg3zcuknI01Myxq9SAcRvboNNCEmudMsCui8HTV//HVrNgERcq1J7FGfX1/sAAL0iKU0PIe+Inxhpl8cH3QkqmfZILyHnmB/3w2aR3ibHG2FPAUZ6XeLxpgDVvF7vrryci4el3SYNgknm9/VFYBjBIV4NirL+JMmeujtEyGmnsGe4ioYb76qeacqVOgVHuauPPpQoWXcBxnxulZn0/fGC05VLriaz7bnl2sZjriJbedtf2wJ7x3fIjLv3GAtZWubdJu10GNqIljCyvxwpYCWy7Wss7Uiu3D9zT0+p9DW2UICyfrb780ParVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 10:11:58 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 10:11:58 +0000
Date: Mon, 18 May 2026 12:11:49 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
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
Subject: Re: [PATCH net-next v3 14/14] ixd: add devlink support
Message-ID: <agrl5WqtOtpnZh3e@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-15-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260515224443.2772147-15-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:802:2::32) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: bd49fb70-2e1d-45ce-1e31-08deb4c5e548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7416014|4143699003|22082099003|56012099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: ZBc/cq2IgrsP/Z2Rajii8J5aralPvF63E3seZ/Tn1ueWW9hyWNQZK736aGusXTmN4M87qQr1pQ3Nv8TH0d1ZlyeJt3i5lSMoeXUBcPuKw7DO+3iRFidEAlOQ8IERxcWmueOQgqcHOH5WkTt+A8bIT5a6HN9WgbR5ZW4Db+MC9GN+WuZi29/0Sh0CXt3/HUlFmdMz2D1ZDodrtF4bTZlD1dfBdUsRKB+9ZTgBeirMHcGr3RS8TPQ+NQaSuXlrgGsUepf7FuRBT8rZQIupMuwxZhxarIivkeR1VsUwoIPu/NBzjIvnznTvNnbBlQ9VGoIL7vMcIDUOkYbczOTQg6u7TSGXCkVsAPJWEjQ9Z56hp9GTvjtJ7A3PrGgbPhxqzSEHrz7aRN3MBxS8yDUG41ViGKsiHojKOL8UP4Dp1bufMNYvd3Wn9L2tf2m/SRX9n8GvZ4RCjsh+K0WV3/KfMPT8XturWIAuzzDkUk1OBag/WiGovZV3vDp4jYPJz7hihxwMOg1OHkbIC/NA0vWo89Lf+6EywmqXUUcQ0w1wEgcUUxC/LFNCms3MZUAY272/eA/Pb/yYvtMrroVIgoICKLuHcarPwyAUBitvAZ/V7M/LyuUoWRZVc+G7hcq/GSXTd9P3iyhwWBbDWeQpuuNg/k5Ni2/0VTL2Jh6l/JBz63gWRQz5sJreq7EjJjvxaaeb5MRS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7416014)(4143699003)(22082099003)(56012099003)(18002099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JC1a3JAS+kgA9DiDGJK85W7JCxTYCHRzCmntWw7A8q9LH5azCg/F8XO5xHmS?=
 =?us-ascii?Q?X2+uAwhg6AWBo2OylFmQeWCgjx+/6O7tb2bsK8mrncdyiZmAtwPlfIcvktXH?=
 =?us-ascii?Q?rZ/H2BeAGsMI9nkh5HuFAOT909pS8IgBqlLcwGtviQ+tLZSR3lqLfx1a2m4T?=
 =?us-ascii?Q?iYcmYNq26NMf0OXbmJLil/OYwTV3FxdwHMpRg875kSRkyWMUXzMDRRCgOASV?=
 =?us-ascii?Q?DEMGRuWvBOx2qKry09GMVW/cgkxx5drH+I2Tm+ToXet7QGwOYqlvnRjrta5c?=
 =?us-ascii?Q?/Pa8TD9YKEYvX5iihWNgXZ2aHacHbUJpsJdnYenVAucM+s07coQ5OmVyf26C?=
 =?us-ascii?Q?U/KVj+wzwDes0lZROvLNVFDX2D8dDfjE6waFqFxBfiayl6F1jSpsBF/+gIHM?=
 =?us-ascii?Q?Cis7Xl+o2AduD9uAdkkSq1kteRvYKFutYLe9O2qnOWxscjEz9pu5+X2U6gxe?=
 =?us-ascii?Q?cGR3RxvEQQD4/svF8MRtMDhyWX56tUcwEA6OB2VTT2kBtYi/MODkEykwcr5H?=
 =?us-ascii?Q?5HUEJCKDBonFkxQvZz96M3uR1py4D5JkrMD9X/qEVrPm7u65Z/Xx3qhsuvQj?=
 =?us-ascii?Q?OpQ9kzmNzizQe3x1ptq4KYWH8LWy2KOL8JfnJ2QcyhDRhIIY4dVziWN6X33w?=
 =?us-ascii?Q?iPL2LMi+c6pJXitBFhqQmFeg1R+M+K8rImYDC0fLfOg/7jWRqfA9OfjsLXe2?=
 =?us-ascii?Q?VSLbCX3ulNMQunBvOLqVeChJ8zDrDyAf7Mfy5+A/YdeGjruHKzbZTiCEgRP0?=
 =?us-ascii?Q?69YwTU+h0/WdVZAi49lwBvvCvQlsGSvvEFPFwTlbxQhAxGsDgFHaSkPqLvpI?=
 =?us-ascii?Q?q7CLjR0GZru6KVZdvmI+EDYxebyQAt0HB4YBUatGIrDKD7WM8iaB1uYBg7Hi?=
 =?us-ascii?Q?pr2wBgaURp5BQgtTRk26f55JDFfhKILqj2Ig5/nzsje/z869YNYoh9YNv8SB?=
 =?us-ascii?Q?Xc8nn5dhrDQ12b2Hi1cN2qDu+ZkWpz0LQ+7E3AfFca+sRrgqAwejfhbXSGdB?=
 =?us-ascii?Q?P5dK7hSKRZztsuiqwRQKRMeIbN3kjXsaj7vpuVi6VSysuO6PFpqqPx8YPF8G?=
 =?us-ascii?Q?2Y/S/jC+tBratyXeaOg/gBQixuFLcx9ohYPDGMEm/BXQqQGR4b53oQh+STe+?=
 =?us-ascii?Q?UgzG5o+ut4b0jn49X4argovx6ahpkWp2e8uE04JDzf/HMzQJj+8gMut1NuYb?=
 =?us-ascii?Q?RlQoRHXPj2Q29CvfZSTRiZMmQRRJqHVC/+Wkxm039O3Os6a/uRpEykkt30be?=
 =?us-ascii?Q?r2t3Dxx5B4YPIPg4C4We8Wj703+Pz2nB0/6LEdYStqfd7ir4u5kLIDTaFgiY?=
 =?us-ascii?Q?zaq6zptlcREn2U45FsQuligimCJd+J+rwiY1koYJxfGl0T6RQTRo3TJbie7j?=
 =?us-ascii?Q?fLbReDJ1FUbQlwgn1p6jkP8Fn4GKMD/HzKkXaiFb42JlCO4MiWcOPRPztzTH?=
 =?us-ascii?Q?TrPy4MdOBfZFpAMwHbhL5AYDdHEqM35lLfAHlBsjZGZo+pJnrUjLcL2KAQGu?=
 =?us-ascii?Q?aoOK7xdh9XhYA4OkjkhubQD7b/gEMrzokUHdYErD2TgH4iI/Cq+WCJXxiWnU?=
 =?us-ascii?Q?2iodOwnc73fDmhnD5zO/B8UPmpi+yNRe4O4G1FLL8zZDOwTTwDM/nvb+VmnC?=
 =?us-ascii?Q?G6XjScSXnCWumwgcxGntw9tHBPz9KbN7M2dUADer6ZHj7UAAZEej5h8oUl/R?=
 =?us-ascii?Q?wArG76UkLHTn3d7xp7raJfyPumR810HY0yRjDWbtHaBluhAn6hNEEui9qVQk?=
 =?us-ascii?Q?lEGHyzdqIIj+juPRLRw3CnEHCphcV1jWRLICxXhZX1RwL67Dc9jSBXYuHLcz?=
X-MS-Exchange-AntiSpam-MessageData-1: K+HO6+opAsXJfA==
X-Exchange-RoutingPolicyChecked: T7FX/2SfKWakOYYSdeoT9qfW/avZXVM7gIyxsWHp5q5ayIaG5hQAGaDyf7Mj5riK403KVT2HWFMZigpGi0WAkzb4nbbjYQFNCMK1v7McEn55dNzC+oYrxCeoD0jJvaKGFBDAgbmzLBFzfTtWAvWpkBO2Y0ZOP5bO7uMjVmACK8NgRImMo7Haer4rmChDNHK7vseAE6UXa2uBEH1IdDOTn1PfSmVjLQsRY1w6sMoA6zm43M6+/cu065VnWluLD725jKdBt6hrT3LL1WbRxflsTkW1qNEla67leCrTysKM+aKKEJtrb4Q2XwlP2husdgZJGcNVZUPob4yxZEzQUQ5Wdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd49fb70-2e1d-45ce-1e31-08deb4c5e548
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:11:58.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jig4GFwTiNTNJE9V2mOfRzmd2n4tBSXldyZQwBfoxqwilBddzxVOqEk2JtFUwrz6PVxCGsdSUc+afVbQ0vQi4nEQxQp43QEj0+RLZXl8yK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 44FB456A924
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288985-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soc-5CG4396X81.clients.intel.com:mid,intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 03:44:38PM -0700, Tony Nguyen wrote:
> From: Amritha Nambiar <amritha.nambiar@intel.com>
> 
> Enable initial support for the devlink interface with the ixd driver. The
> ixd hardware is a single function PCIe device. So, the PCIe adapter gets
> its own devlink instance to manage device-wide resources or configuration.

I have accidentally posted the answer to the previous patch, here is a 
duplicate:

Sashiko's concern about devlink being registered too early is actually valid.
Would say this is not a serious issue at this stage in the development, but here 
is a diff addressing this:


diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
index 24080cb30c43..abf78966de61 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */

 #include "ixd.h"
+#include "ixd_devlink.h"
 #include "ixd_virtchnl.h"

 #define IXD_DFLT_MBX_Q_LEN 64
@@ -150,6 +151,7 @@ void ixd_init_task(struct work_struct *work)

        if (!ixd_vc_dev_init(adapter)) {
                adapter->init_task.vc_retries = 0;
+               ixd_devlink_register(adapter);
                return;
        }

diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index 7ff51865af68..aa894482ee35 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -125,8 +125,6 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
        queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
                           msecs_to_jiffies(500));

-       ixd_devlink_register(adapter);
-
        return 0;

 free_adapter:


> 
> $ devlink dev show
> pci/0000:83:00.6
> 
> $ devlink dev info pci/0000:83:00.6
> pci/0000:83:00.6:
>   driver ixd
>   serial_number 00-a0-c9-ff-ff-23-45-67
>   versions:
>       fixed:
>         device.type MEV
>       running:
>         virtchnl 2.0
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <Bharath.r@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  Documentation/networking/devlink/index.rst   |  1 +
>  Documentation/networking/devlink/ixd.rst     | 30 ++++++
>  drivers/net/ethernet/intel/ixd/Kconfig       |  1 +
>  drivers/net/ethernet/intel/ixd/Makefile      |  1 +
>  drivers/net/ethernet/intel/ixd/ixd_devlink.c | 97 ++++++++++++++++++++
>  drivers/net/ethernet/intel/ixd/ixd_devlink.h | 44 +++++++++
>  drivers/net/ethernet/intel/ixd/ixd_main.c    | 16 +++-
>  7 files changed, 187 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/networking/devlink/ixd.rst
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.h
> 
> diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
> index f7ba7dcf477d..f0c077843fa7 100644
> --- a/Documentation/networking/devlink/index.rst
> +++ b/Documentation/networking/devlink/index.rst
> @@ -88,6 +88,7 @@ parameters, info versions, and other features it supports.
>     ionic
>     iosm
>     ixgbe
> +   ixd
>     kvaser_pciefd
>     kvaser_usb
>     mlx4
> diff --git a/Documentation/networking/devlink/ixd.rst b/Documentation/networking/devlink/ixd.rst
> new file mode 100644
> index 000000000000..17b63c8425aa
> --- /dev/null
> +++ b/Documentation/networking/devlink/ixd.rst
> @@ -0,0 +1,30 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================
> +ixd devlink support
> +===================
> +
> +This document describes the devlink features implemented by the ``ixd``
> +device driver.
> +
> +Info versions
> +=============
> +
> +The ``ixd`` driver reports the following versions
> +
> +.. list-table:: devlink info versions implemented
> +    :widths: 5 5 5 90
> +
> +    * - Name
> +      - Type
> +      - Example
> +      - Description
> +    * - ``device.type``
> +      - fixed
> +      - MEV
> +      - The hardware type for this device
> +    * - ``virtchnl``
> +      - running
> +      - 2.0
> +      - 2-digit version number (major.minor) of the communication channel
> +        (virtchnl) used by the device.
> diff --git a/drivers/net/ethernet/intel/ixd/Kconfig b/drivers/net/ethernet/intel/ixd/Kconfig
> index 24510c50070e..34181c59dcdc 100644
> --- a/drivers/net/ethernet/intel/ixd/Kconfig
> +++ b/drivers/net/ethernet/intel/ixd/Kconfig
> @@ -7,6 +7,7 @@ config IXD
>  	select LIBETH
>  	select LIBIE_CP
>  	select LIBIE_PCI
> +	select NET_DEVLINK
>  	help
>  	  This driver supports Intel(R) Control Plane PCI Function
>  	  of Intel E2100 and later IPUs and FNICs.
> diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
> index 90abf231fb16..03760a2580b9 100644
> --- a/drivers/net/ethernet/intel/ixd/Makefile
> +++ b/drivers/net/ethernet/intel/ixd/Makefile
> @@ -8,5 +8,6 @@ obj-$(CONFIG_IXD) += ixd.o
>  ixd-y := ixd_main.o
>  ixd-y += ixd_ctlq.o
>  ixd-y += ixd_dev.o
> +ixd-y += ixd_devlink.o
>  ixd-y += ixd_lib.o
>  ixd-y += ixd_virtchnl.o
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_devlink.c b/drivers/net/ethernet/intel/ixd/ixd_devlink.c
> new file mode 100644
> index 000000000000..23ab11226978
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_devlink.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025, Intel Corporation. */
> +
> +#include "ixd.h"
> +#include "ixd_devlink.h"
> +
> +#define IXD_DEVLINK_INFO_LEN	128
> +
> +/**
> + * ixd_fill_dsn - Get the serial number for the ixd device
> + * @adapter: adapter to query
> + * @buf: storage buffer for the info request
> + */
> +static void ixd_fill_dsn(struct ixd_adapter *adapter, char *buf)
> +{
> +	u8 dsn[8];
> +
> +	/* Copy the DSN into an array in Big Endian format */
> +	put_unaligned_be64(pci_get_dsn(adapter->cp_ctx.mmio_info.pdev), dsn);
> +
> +	snprintf(buf, IXD_DEVLINK_INFO_LEN, "%8phD", dsn);
> +}
> +
> +/**
> + * ixd_fill_device_name - Get the name of the underlying hardware
> + * @adapter: adapter to query
> + * @buf: storage buffer for the info request
> + * @buf_size: size of the storage buffer
> + */
> +static void ixd_fill_device_name(struct ixd_adapter *adapter, char *buf,
> +				 size_t buf_size)
> +{
> +	if (adapter->caps.device_type == cpu_to_le32(VIRTCHNL2_MEV_DEVICE))
> +		snprintf(buf, buf_size, "%s", "MEV");
> +	else
> +		snprintf(buf, buf_size, "%s", "UNKNOWN");
> +}
> +
> +/**
> + * ixd_devlink_info_get - .info_get devlink handler
> + * @devlink: devlink instance structure
> + * @req: the devlink info request
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .info_get operation. Reports information about the
> + * device.
> + *
> + * Return: zero on success or an error code on failure.
> + */
> +static int ixd_devlink_info_get(struct devlink *devlink,
> +				struct devlink_info_req *req,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct ixd_adapter *adapter = devlink_priv(devlink);
> +	char buf[IXD_DEVLINK_INFO_LEN];
> +	int err;
> +
> +	ixd_fill_dsn(adapter, buf);
> +	err = devlink_info_serial_number_put(req, buf);
> +	if (err)
> +		return err;
> +
> +	ixd_fill_device_name(adapter, buf, IXD_DEVLINK_INFO_LEN);
> +	err = devlink_info_version_fixed_put(req, "device.type", buf);
> +	if (err)
> +		return err;
> +
> +	snprintf(buf, sizeof(buf), "%u.%u",
> +		 adapter->vc_ver.major, adapter->vc_ver.minor);
> +
> +	return devlink_info_version_running_put(req, "virtchnl", buf);
> +}
> +
> +static const struct devlink_ops ixd_devlink_ops = {
> +	.info_get = ixd_devlink_info_get,
> +};
> +
> +/**
> + * ixd_adapter_alloc - Allocate devlink and return adapter pointer
> + * @dev: the device to allocate for
> + *
> + * Allocate a devlink instance for this device and return the private area as
> + * the adapter structure.
> + *
> + * Return: adapter structure on success, NULL on failure
> + */
> +struct ixd_adapter *ixd_adapter_alloc(struct device *dev)
> +{
> +	struct devlink *devlink;
> +
> +	devlink = devlink_alloc(&ixd_devlink_ops, sizeof(struct ixd_adapter),
> +				dev);
> +	if (!devlink)
> +		return NULL;
> +
> +	return devlink_priv(devlink);
> +}
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_devlink.h b/drivers/net/ethernet/intel/ixd/ixd_devlink.h
> new file mode 100644
> index 000000000000..c43ce0655de2
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_devlink.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025, Intel Corporation. */
> +
> +#ifndef _IXD_DEVLINK_H_
> +#define _IXD_DEVLINK_H_
> +#include <net/devlink.h>
> +
> +struct ixd_adapter *ixd_adapter_alloc(struct device *dev);
> +
> +/**
> + * ixd_devlink_free - teardown the devlink
> + * @adapter: the adapter structure to free
> + *
> + */
> +static inline void ixd_devlink_free(struct ixd_adapter *adapter)
> +{
> +	struct devlink *devlink = priv_to_devlink(adapter);
> +
> +	devlink_free(devlink);
> +}
> +
> +/**
> + * ixd_devlink_unregister - Unregister devlink resources for this adapter.
> + * @adapter: the adapter structure to cleanup
> + *
> + * Releases resources used by devlink and cleans up associated memory.
> + */
> +static inline void ixd_devlink_unregister(struct ixd_adapter *adapter)
> +{
> +	devlink_unregister(priv_to_devlink(adapter));
> +}
> +
> +/**
> + * ixd_devlink_register - Register devlink interface for this adapter
> + * @adapter: pointer to ixd adapter structure to be associated with devlink
> + *
> + * Register the devlink instance associated with this adapter
> + */
> +static inline void ixd_devlink_register(struct ixd_adapter *adapter)
> +{
> +	devlink_register(priv_to_devlink(adapter));
> +}
> +
> +#endif /* _IXD_DEVLINK_H_ */
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
> index 6d5e6aca77df..ea6aa793a6a7 100644
> --- a/drivers/net/ethernet/intel/ixd/ixd_main.c
> +++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
> @@ -4,6 +4,7 @@
>  #include "ixd.h"
>  #include "ixd_ctlq.h"
>  #include "ixd_lan_regs.h"
> +#include "ixd_devlink.h"
>  
>  MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
>  MODULE_IMPORT_NS("LIBIE_CP");
> @@ -21,11 +22,14 @@ static void ixd_remove(struct pci_dev *pdev)
>  	/* Do not mix removal with (re)initialization */
>  	cancel_delayed_work_sync(&adapter->init_task.init_work);
>  
> +	ixd_devlink_unregister(adapter);
> +
>  	/* Leave the device clean on exit */
>  	ixd_trigger_reset(adapter);
>  	ixd_deinit_dflt_mbx(adapter);
>  
>  	libie_pci_unmap_all_mmio_regions(&adapter->cp_ctx.mmio_info);
> +	ixd_devlink_free(adapter);
>  }
>  
>  /**
> @@ -93,7 +97,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (WARN_ON(ent->device != IXD_DEV_ID_CPF))
>  		return -EINVAL;
>  
> -	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
> +	adapter = ixd_adapter_alloc(&pdev->dev);
>  	if (!adapter)
>  		return -ENOMEM;
>  
> @@ -102,13 +106,13 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	err = libie_pci_init_dev(pdev);
>  	if (err)
> -		return err;
> +		goto free_adapter;
>  
>  	pci_set_drvdata(pdev, adapter);
>  
>  	err = ixd_iomap_regions(adapter);
>  	if (err)
> -		return err;
> +		goto free_adapter;
>  
>  	INIT_DELAYED_WORK(&adapter->init_task.init_work,
>  			  ixd_init_task);
> @@ -118,7 +122,13 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
>  			   msecs_to_jiffies(500));
>  
> +	ixd_devlink_register(adapter);
> +
>  	return 0;
> +
> +free_adapter:
> +	ixd_devlink_free(adapter);
> +	return err;
>  }
>  
>  static const struct pci_device_id ixd_pci_tbl[] = {
> -- 
> 2.47.1
> 

