Return-Path: <netdev+bounces-288871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBgtKJy5CmoB6QQAu9opvQ
	(envelope-from <netdev+bounces-288871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:02:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F24F4567201
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C66623016D35
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F305F3C76A0;
	Mon, 18 May 2026 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laEh5Hcn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798540855;
	Mon, 18 May 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087767; cv=fail; b=F8XIf10XMNor/Ce1kwCC4ddkbFHt2mC8BjKNwmux2BqdI6WLzf/+nBOZUKFKwusqnlJk9oo5qQ4xFxFdIPUx4jg+jCetdB1bAt/W+PW356urDA0+i3M/uTKUtyosAsbLCVk3z7EiLxQcCVPOyTr1xIrX7Z88Djk5N8PKvyXHmuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087767; c=relaxed/simple;
	bh=B0jfxkN8anjPQKrr/GXwvkmzUcvSGhLOzGD4idPKjx8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=naNZgStmnfp8zD7SSN7d3klYPt8GTvjPXhvcRHTH54cdMnqYmE/4A0vlFWrARNMA9/38psKd/rXdBx16oAUwaiMk4ZO5xJSVtwwI9p0nQDx7FKkyprPJAVEo9IpLCtPlBW8ZSMDH/coz7IXntARoMkNk8+41P0TWQLRksE1fAIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laEh5Hcn; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779087766; x=1810623766;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B0jfxkN8anjPQKrr/GXwvkmzUcvSGhLOzGD4idPKjx8=;
  b=laEh5Hcn+i1/lhy81JxqvuaV7Gpsbk2NsnhvfPctnkyLnfrLLCZWUwxx
   4+A5mg1bUv+zjeJE4oneJnHhvTA+qgbKDZ7CijNKEgyMg7LpDN4FVJA+m
   NbRtYAqQpIUa2hUSLmK99jHCOAYgG90UZRsZ2Tn35TQpBrC3bAhFl/4Q9
   3uxF6RB+5Z/LJH2bEu9qrHrrohW2s5FzVnJuTaUbH+EynRcouggCdARrt
   1CFpoKS/8xIx0NszjMaAhXYWbJX7AyznJsO0vO4a4z0Ehv3+i3/ZjxZwh
   3jLwWLCYzEiLeIs/Tc7QEq4gwaXSlk1+6YgIKSb5NXv7vIWhiKXCNfmie
   Q==;
X-CSE-ConnectionGUID: ikoSK0D3Q3STuq+Y6W4MBg==
X-CSE-MsgGUID: z5tX5KdqR1yCGcJkGQY1ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79964703"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79964703"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:02:45 -0700
X-CSE-ConnectionGUID: bNzjCf5YSpaguSj6hZuPvA==
X-CSE-MsgGUID: aK4OkmBGT0aMIUXnQ2AZYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="239595404"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:02:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 00:02:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 00:02:43 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 00:02:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkKurohCQxTrt7gbdYP0RJw5swwl8eASoGfRSCuBk1WbhCPTpqkPvjJonx7TmNtXxlazI08AEVN1HDV3vtJklzV5LQKRsn+13sV9Qxl6gjzKMi1qMr4Wyt/o/eCHE9E8e5FVEPQZucXff5CYmBuNpUTY1j51uMSvnFfhWJ3BuPaUOMhM1ju7FBvNJRtqRonLeD5YwyICX9d8G/Gj6/IU+k6er7l9l3rVChdO74dAr7+VPlJaovMMMr1hOjeslGjUd2c3SgmAkAtC09CFeQPkxLfPOYyjCbTM7ED9laSsRRaTUREFrOHaP6y+Xkmd4dKWddvBYV6F5FNMj8kMgb3QqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEGQ90LFGTUaxsV27RaC+3FS1K65A1xWKGCB8qrz/B0=;
 b=MK9zCVKt7wXFRzT7WAORf94sJsJuD5n1NQwUwfPSNwQ64Y7CGhAawNAXSIRqdIIhPWtJrjd/Ah5iaGTBdv7anAGfwRVtKSzU/2pIHAOks4VjpVPoE/8rWk3JARwQkKWIDkNIX97JykX8bsxD3hd0+lc/k2Zk6Cq4n1e49R62eP/LCYBDfE55GWA3lDp+3op9K7Md8iIpGcEYqcR2EQJqLvzkl0GnrKuVBVPYoal8R5MQDRo+p56GAYH6+BiCvHJYgVFJ49kXMXeG04eV4qUNfuNfD18XC6bZc3JXbDQV59K9UHQ/m1Lb3vg/aCm8H1bRTqg0j6hrmOY6A0gEGTV7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SN7PR11MB6751.namprd11.prod.outlook.com (2603:10b6:806:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 07:02:39 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 07:02:39 +0000
Date: Mon, 18 May 2026 09:02:24 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Phani R Burra <phani.r.burra@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<anjali.singhai@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>, Bharath R
	<bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 04/14] libie: add control queue support
Message-ID: <agq5gK3_LgxVl7g9@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-5-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260515224443.2772147-5-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1PR0102CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::42) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SN7PR11MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eeac405-2fe2-417d-1435-08deb4ab727d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|4143699003|11063799003|3023799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: XA3dCrVgOwLqKZJjaRF0+FyD2+cI/aXfK8O+P8ZxgerJ/3rpBszo54/Wj/iPjRaVQYNZbHsG56R97VI58T1H9DjFzQmD05qtkrjfsbIW9mDDKptx51qinYX0kX0Kl4vyMcX8+GDGvHZ3YKXMmeuJb2Kw5/Ud3mg1u38OVy+bOj5P9MNosEXB4neKWo0le3MyERKDKJZ53CFGrfJoqCzqWVXithved72IdS3PnLn6zRu8ktzajbWufV259UWDakmYvKLuHVEE0jTFFIDGVy0htxLWjKH6q71LC7ReR8hdU44nOKslWMzifWA/uMaFs20BzAWvfofeUC/9LqOWc2jLaQEyjA7AFQ9vyzqKgN3pY3MaHtt1gncEplPu32vsErsSmm1S1G34TJMb13gF9qiU1pdK50b8N+/1JC6E95rvDS9Jn/TA6GP3OnHaQ6GyuSe1fryxKmQ/GWkYfcioew4vXe+r2W7XHW57sA1E83bUnoczJ08e6aJXUeZTMlaP7PcagzIwLXcPxv1BEjE+mTwxX9B84guSWQnr1HAUiTxfLI02f5NTfRI34To4Fry3OJP8sCZRCv5R/EatLqucoqP0jncBOcI6KnQQmwEVoKWsvl6SZKESZvkI+qsThsn6ZXZ14QGC5fQ2Ye6Gczjd6bUgnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(4143699003)(11063799003)(3023799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cf6Q43j7L5Slmw8QUk1fJovAx7TQM4GSaxmhPLyozr2hr1kZB3oawHWvbhiB?=
 =?us-ascii?Q?CgL4j/6RAOF2T7ml97iDa1Kaf26rwWDlTjhS3NN3cbQvPFcnxvB3tZam0Ap0?=
 =?us-ascii?Q?hVo/UVWmzDLrdfyl0dny7POy8QGsJt7HFWW5Moctd/iZ3d+LRSgiwJdSNR/s?=
 =?us-ascii?Q?pofhromUyYPipnRpA4FKMBna2LzfJqj0aafkS+h/93k+Aq9e+C932AZnWDvu?=
 =?us-ascii?Q?CaRpjgcORVRJg3snMr0UvvArvUGKJIeJ+FhpIgByZz9J1QaIgDjSsJqQj/eT?=
 =?us-ascii?Q?e9ffyVKEMTIsgW8cCU71epHl9WyjJoQunH8KMIcu2+JDZJOn2xC/sJNqqv2a?=
 =?us-ascii?Q?Uhlp8gLnt53ULHqFEXnajiIY6b/UniuZejQEBFohQcEUA4kqwJbYpeaW9gT5?=
 =?us-ascii?Q?VmnXhBStGCUWI4DDGUi0+E54GiF7yRuHXHoG9rperAnCqSf8sp7QusFVi9LH?=
 =?us-ascii?Q?qlp7VS7wGm0oBw9WisyrLb8HdJzCJqkWLkkH5WjEAtH2ZRpwa/+ecyfeQOgD?=
 =?us-ascii?Q?Wn4y/WPDFRI853c5I3Ow/ZVUuZOJawvW6Smlg7yAdrToAO3F2xOHAu0YJV+D?=
 =?us-ascii?Q?DtG4y2XZ0JuC1q7uYgH5rtk+O0Tptw7pPbHKUNUTRqY4LgGZRyrAlsOYN5Ps?=
 =?us-ascii?Q?sH+2vTY5b6TDpM8S5pn5ULEv7hqVquLPdpyqS04UMRc2Xb1d7CxR7vYWfWQ4?=
 =?us-ascii?Q?rqgKqWWG6/x6TFR9ktczip3Fx9MF0V7SF0goOlae8tuCSsIiVjntaFkpcQdw?=
 =?us-ascii?Q?VyWM6lnyCg1fWl2+E/LqGvtwBGOJFePX2GnUTvRRiEyMZlnHjm5PdB188Biy?=
 =?us-ascii?Q?q+PvetdZmE1s95fB6yzDiwtKDG+Ub3Alcps/wvGuoEcYJfHAbY8+pBCCOQOJ?=
 =?us-ascii?Q?QhEujDz8Rt4NMEfpmRH4r20Co+6znjRMmubD5vadT9Tu8/w1G9iwwPpwGioD?=
 =?us-ascii?Q?8THIiTVwaR9UFdy7H7jlVhFmGvVyfSUTV+PO7D9XfsQX3QLwANRDwKvpLWR0?=
 =?us-ascii?Q?4d00MwAPKnsBSbszxmviL4v8V+muexpI0OlPvnwbSpqoAv4hum42WTS5PR+h?=
 =?us-ascii?Q?haVjkNPLxMVsM4vg1owvJjxTs3jYN/CC6OsH+hCr6QxOY38NJX2r600k4TDy?=
 =?us-ascii?Q?JorsH7YtJLOWTYClvrzBDqk6ZEtvDGX34x/gKZ+lgiz3yqy2zMC9/1c7jWOD?=
 =?us-ascii?Q?m7OUEudVwltHBSALthbHDSK49oK2HyqMgeH8RHHyXxRnbGF0EYpSFGI1V1Dv?=
 =?us-ascii?Q?PaCKxd6Asr/Wn/NOl12QZTK7o78as71ueEGcv1u5degn3n1pmQTyAx1izc7d?=
 =?us-ascii?Q?DPdZ94AyXOPoqRptzCkhExjSWOMPM/MwCIhCiRwIGlR7KgEe8rV3jOp4uqq1?=
 =?us-ascii?Q?zwsSQ8HJfHA8zNCuJUnpNEAUwmHI1RJKVjfwcQCenZ82svZoFli4KA82hA8r?=
 =?us-ascii?Q?gv9fuQp9Jt5RuZseaClBb7teiQ+qipRScOIo80iJvuBer1bwS+8NYs2Udm7z?=
 =?us-ascii?Q?9gcRL+tb090nlGMOvpS/1AcUi0GzJHRJsKghOr4TfBgHNHTWm2AHdeiHKuQe?=
 =?us-ascii?Q?CXh1H0rna45dTvXXcjlUiRZVUxD53kX8HTxRJxDLy9GH1fe3LqIPp54aWl39?=
 =?us-ascii?Q?QJrsmLOLLE1VGCUFY2RrLRWd+KShlaJygycRFj3Gt1s5GVr6hbdw+UCJFU+C?=
 =?us-ascii?Q?tpu/q/97Jii5EYf044qJLc/3bJq8Pel8cvPXeUcmVtZfNfkBvvQqjEA3XDZn?=
 =?us-ascii?Q?PI8JHY7wln27pBZCO0F6KnS7sFLSnujzLe/AtT68ziJ8cUCcAYxSbsdL5CtE?=
X-MS-Exchange-AntiSpam-MessageData-1: kpfxThx/+Pf5/nRDWl+N7fZ+lcxSyAoB1yk=
X-Exchange-RoutingPolicyChecked: Qe55K3EHUVi5Ncfct+2yBwsLO1J5pSFnsqwwsX7EtEA/SZXSxvGUWdlplBv5cAAdwcQ+glrPgNDExZgijKnam7IQwdRD0xKhDU8LbPnlYEIrR20Z1c/ikr3B5JdbqzV7d9bQ/kokoEtEAWyxsKHgTf34IdmUn2nxVeYNDj5UjAbr8nf8V1LiA5mrPwJTrAkkoi4iblmwzt4UaSJzDU8A5+l9JBvWw2olITpuV4YzsMx1r5c+J9qIj78nmfVeeP4W7YAYasmer4YEfADQazsYSj6PCpTb+Dbi5OOc0BB+cuuZvcaz8hLyhBlqG6EfcZgaLSk+/qnFUnbU64bLfbPrBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eeac405-2fe2-417d-1435-08deb4ab727d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:02:38.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FtZdJoDjo1j9gqPWCjHd73Xz7xCzZSzTX8vwYDbB7wrjlp9pqIXESGEc67y2r+N34SmfodUyBErynbMH4h0w+Ig3uzid7wCrrg/g7UPFpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6751
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: F24F4567201
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288871-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soc-5CG4396X81.clients.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 03:44:28PM -0700, Tony Nguyen wrote:
> From: Phani R Burra <phani.r.burra@intel.com>
> 
> Libie will now support control queue setup and configuration APIs. These
> are mainly used for mailbox communication between drivers and control
> plane.
> 
> Make use of the libeth_rx page pool support for managing controlq buffers.

I had reviewed the Sashiko feedback [0]. Here is why I not find the feedback 
very helpful for this particular patch:

1. libie_ctlq_post_rx_buffs/libie_ctlq_fill_rx_msg - libeth FQs are configured 
   so that offset is always 0 and truesize == HW DMA size.
2. libie_ctlq_deinit: Final teardown without the lock is fine.
3. "If a caller sets up a bidirectional message" - Rx and Tx queues are 
   independent. The whole comment is just confusing.
4. "[libie_ctlq_recv] does not clear the DD bit after processing a descriptor, 
    will libie_ctlq_recv() mistakenly process the barrier slot as a new hardware 
    completion?" - we clear DD before posting the buffer.

[0] https://sashiko.dev/#/patchset/20260515224443.2772147-1-anthony.l.nguyen%40intel.com

> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> Co-developed-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <bharath.r@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/libie/Kconfig    |   8 +
>  drivers/net/ethernet/intel/libie/Makefile   |   4 +
>  drivers/net/ethernet/intel/libie/controlq.c | 614 ++++++++++++++++++++
>  include/linux/intel/libie/controlq.h        | 249 ++++++++
>  4 files changed, 875 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/libie/controlq.c
>  create mode 100644 include/linux/intel/libie/controlq.h
> 
> diff --git a/drivers/net/ethernet/intel/libie/Kconfig b/drivers/net/ethernet/intel/libie/Kconfig
> index 500a95c944a8..9c5fdebb6766 100644
> --- a/drivers/net/ethernet/intel/libie/Kconfig
> +++ b/drivers/net/ethernet/intel/libie/Kconfig
> @@ -15,6 +15,14 @@ config LIBIE_ADMINQ
>  	  Helper functions used by Intel Ethernet drivers for administration
>  	  queue command interface (aka adminq).
>  
> +config LIBIE_CP
> +	tristate
> +	select LIBETH
> +	select LIBIE_PCI
> +	help
> +	  Common helper routines to communicate with the device Control Plane
> +	  using virtchnl2 or related mailbox protocols.
> +
>  config LIBIE_FWLOG
>  	tristate
>  	select LIBIE_ADMINQ
> diff --git a/drivers/net/ethernet/intel/libie/Makefile b/drivers/net/ethernet/intel/libie/Makefile
> index a28509cb9086..3065aa057798 100644
> --- a/drivers/net/ethernet/intel/libie/Makefile
> +++ b/drivers/net/ethernet/intel/libie/Makefile
> @@ -9,6 +9,10 @@ obj-$(CONFIG_LIBIE_ADMINQ) 	+= libie_adminq.o
>  
>  libie_adminq-y			:= adminq.o
>  
> +obj-$(CONFIG_LIBIE_CP)		+= libie_cp.o
> +
> +libie_cp-y			:= controlq.o
> +
>  obj-$(CONFIG_LIBIE_FWLOG) 	+= libie_fwlog.o
>  
>  libie_fwlog-y			:= fwlog.o
> diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
> new file mode 100644
> index 000000000000..934721c98f34
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/libie/controlq.c
> @@ -0,0 +1,614 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#include <linux/bitfield.h>
> +#include <net/libeth/rx.h>
> +
> +#include <linux/intel/libie/controlq.h>
> +
> +#define LIBIE_CTLQ_DESC_QWORD0(sz)			\
> +	(LIBIE_CTLQ_DESC_FLAG_BUF |			\
> +	 LIBIE_CTLQ_DESC_FLAG_RD |			\
> +	 FIELD_PREP(LIBIE_CTLQ_DESC_DATA_LEN, sz))
> +
> +/**
> + * libie_ctlq_free_fq - free fill queue resources, including buffers
> + * @ctlq: Rx control queue whose resources need to be freed
> + */
> +static void libie_ctlq_free_fq(struct libie_ctlq_info *ctlq)
> +{
> +	struct libeth_fq fq = {
> +		.fqes		= ctlq->rx_fqes,
> +		.pp		= ctlq->pp,
> +	};
> +
> +	for (u32 ntc = ctlq->next_to_clean; ntc != ctlq->next_to_post; ) {
> +		page_pool_put_full_netmem(fq.pp, fq.fqes[ntc].netmem, false);
> +
> +		if (++ntc >= ctlq->ring_len)
> +			ntc = 0;
> +	}
> +
> +	libeth_rx_fq_destroy(&fq);
> +}
> +
> +/**
> + * libie_ctlq_init_fq - initialize fill queue for an Rx controlq
> + * @ctlq: control queue that needs a Rx buffer allocation
> + *
> + * Return: %0 on success, -%errno on failure
> + */
> +static int libie_ctlq_init_fq(struct libie_ctlq_info *ctlq)
> +{
> +	struct libeth_fq fq = {
> +		.count		= ctlq->ring_len,
> +		.truesize	= LIBIE_CTLQ_MAX_BUF_LEN,
> +		.nid		= NUMA_NO_NODE,
> +		.type		= LIBETH_FQE_SHORT,
> +		.hsplit		= true,
> +		.no_napi	= true,
> +	};
> +	int err;
> +
> +	err = libeth_rx_fq_create(&fq, ctlq->dev);
> +	if (err)
> +		return err;
> +
> +	ctlq->pp = fq.pp;
> +	ctlq->rx_fqes = fq.fqes;
> +	ctlq->truesize = fq.truesize;
> +
> +	return 0;
> +}
> +
> +/**
> + * libie_ctlq_reset_rx_desc - reset the descriptor with a new address
> + * @desc: descriptor to (re)initialize
> + * @addr: physical address to put into descriptor
> + * @mem_truesize: size of the accessible memory
> + */
> +static void libie_ctlq_reset_rx_desc(struct libie_ctlq_desc *desc,
> +				     dma_addr_t addr, u32 mem_truesize)
> +{
> +	u64 qword;
> +
> +	*desc = (struct libie_ctlq_desc) {};
> +	qword = LIBIE_CTLQ_DESC_QWORD0(mem_truesize);
> +	desc->qword0 = cpu_to_le64(qword);
> +
> +	qword = FIELD_PREP(LIBIE_CTLQ_DESC_DATA_ADDR_HIGH,
> +			   upper_32_bits(addr)) |
> +		FIELD_PREP(LIBIE_CTLQ_DESC_DATA_ADDR_LOW,
> +			   lower_32_bits(addr));
> +	desc->qword3 = cpu_to_le64(qword);
> +}
> +
> +/**
> + * libie_ctlq_post_rx_buffs - post buffers to descriptor ring
> + * @ctlq: control queue that requires Rx descriptor ring to be initialized with
> + *	  new Rx buffers
> + *
> + * The caller must make sure that calls to libie_ctlq_post_rx_buffs()
> + * and libie_ctlq_recv() for each queue are either serialized
> + * or used under ctlq->lock.
> + *
> + * Return: %0 on success, -%ENOMEM if any buffer could not be allocated
> + */
> +int libie_ctlq_post_rx_buffs(struct libie_ctlq_info *ctlq)
> +{
> +	u32 ntp = ctlq->next_to_post, ntc = ctlq->next_to_clean, num_to_post;
> +	const struct libeth_fq_fp fq = {
> +		.pp		= ctlq->pp,
> +		.fqes		= ctlq->rx_fqes,
> +		.truesize	= ctlq->truesize,
> +		.count		= ctlq->ring_len,
> +	};
> +	int ret = 0;
> +
> +	num_to_post = (ntc > ntp ? 0 : ctlq->ring_len) + ntc - ntp - 1;
> +
> +	while (num_to_post--) {
> +		dma_addr_t addr;
> +
> +		addr = libeth_rx_alloc(&fq, ntp);
> +		if (unlikely(addr == DMA_MAPPING_ERROR)) {
> +			ret = -ENOMEM;
> +			goto post_bufs;
> +		}
> +
> +		libie_ctlq_reset_rx_desc(&ctlq->descs[ntp], addr, fq.truesize);
> +
> +		if (unlikely(++ntp == ctlq->ring_len))
> +			ntp = 0;
> +	}
> +
> +post_bufs:
> +	if (likely(ctlq->next_to_post != ntp)) {
> +		ctlq->next_to_post = ntp;
> +
> +		writel(ntp, ctlq->reg.tail);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_post_rx_buffs, "LIBIE_CP");
> +
> +/**
> + * libie_ctlq_free_tx_msgs - Free Tx control queue messages
> + * @ctlq: Tx control queue being destroyed
> + * @num_msgs: number of messages allocated so far
> + */
> +static void libie_ctlq_free_tx_msgs(struct libie_ctlq_info *ctlq,
> +				    u32 num_msgs)
> +{
> +	for (u32 i = 0; i < num_msgs; i++)
> +		kfree(ctlq->tx_msg[i]);
> +
> +	kvfree(ctlq->tx_msg);
> +}
> +
> +/**
> + * libie_ctlq_alloc_tx_msgs - Allocate Tx control queue messages
> + * @ctlq: Tx control queue being created
> + *
> + * Return: %0 on success, -%ENOMEM on allocation error
> + */
> +static int libie_ctlq_alloc_tx_msgs(struct libie_ctlq_info *ctlq)
> +{
> +	ctlq->tx_msg = kvzalloc_objs(*ctlq->tx_msg, ctlq->ring_len,
> +				     GFP_KERNEL);
> +	if (!ctlq->tx_msg)
> +		return -ENOMEM;
> +
> +	for (u32 i = 0; i < ctlq->ring_len; i++) {
> +		ctlq->tx_msg[i] = kzalloc_obj(*ctlq->tx_msg[i]);
> +		if (!ctlq->tx_msg[i]) {
> +			libie_ctlq_free_tx_msgs(ctlq, i);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * libie_cp_free_dma_mem - Free the previously allocated DMA memory
> + * @dev: device information
> + * @mem: DMA memory information
> + */
> +static void libie_cp_free_dma_mem(struct device *dev,
> +				  struct libie_cp_dma_mem *mem)
> +{
> +	dma_free_coherent(dev, mem->size, mem->va, mem->pa);
> +	mem->va = NULL;
> +}
> +
> +/**
> + * libie_ctlq_dealloc_ring_res - Free memory allocated for control queue
> + * @ctlq: control queue that requires its ring memory to be freed
> + *
> + * Free the memory used by the ring, buffers and other related structures.
> + */
> +static void libie_ctlq_dealloc_ring_res(struct libie_ctlq_info *ctlq)
> +{
> +	struct libie_cp_dma_mem *dma = &ctlq->ring_mem;
> +
> +	if (ctlq->type == LIBIE_CTLQ_TYPE_TX)
> +		libie_ctlq_free_tx_msgs(ctlq, ctlq->ring_len);
> +	else
> +		libie_ctlq_free_fq(ctlq);
> +
> +	libie_cp_free_dma_mem(ctlq->dev, dma);
> +}
> +
> +/**
> + * libie_cp_alloc_dma_mem - Allocate a DMA memory
> + * @dev: device information
> + * @mem: memory for DMA information to be stored
> + * @size: size of the memory to allocate
> + *
> + * Return: virtual address of DMA memory or NULL.
> + */
> +static void *libie_cp_alloc_dma_mem(struct device *dev,
> +				    struct libie_cp_dma_mem *mem, u32 size)
> +{
> +	size = ALIGN(size, SZ_4K);
> +
> +	mem->va = dma_alloc_coherent(dev, size, &mem->pa, GFP_KERNEL);
> +	mem->size = size;
> +
> +	return mem->va;
> +}
> +
> +/**
> + * libie_ctlq_alloc_queue_res - allocate memory for descriptor ring and bufs
> + * @ctlq: control queue that requires its ring resources to be allocated
> + *
> + * Return: %0 on success, -%errno on failure
> + */
> +static int libie_ctlq_alloc_queue_res(struct libie_ctlq_info *ctlq)
> +{
> +	size_t size = array_size(ctlq->ring_len, sizeof(*ctlq->descs));
> +	struct libie_cp_dma_mem *dma = &ctlq->ring_mem;
> +	int err = -ENOMEM;
> +
> +	if (!libie_cp_alloc_dma_mem(ctlq->dev, dma, size))
> +		return -ENOMEM;
> +
> +	ctlq->descs = dma->va;
> +
> +	if (ctlq->type == LIBIE_CTLQ_TYPE_TX) {
> +		if (libie_ctlq_alloc_tx_msgs(ctlq))
> +			goto free_dma_mem;
> +	} else {
> +		err = libie_ctlq_init_fq(ctlq);
> +		if (err)
> +			goto free_dma_mem;
> +
> +		err = libie_ctlq_post_rx_buffs(ctlq);
> +		if (err) {
> +			libie_ctlq_free_fq(ctlq);
> +			goto free_dma_mem;
> +		}
> +	}
> +
> +	return 0;
> +
> +free_dma_mem:
> +	libie_cp_free_dma_mem(ctlq->dev, dma);
> +
> +	return err;
> +}
> +
> +/**
> + * libie_ctlq_init_regs - Initialize control queue registers
> + * @ctlq: control queue that needs to be initialized
> + *
> + * Initialize registers. The caller is expected to have already initialized the
> + * descriptor ring memory and buffer memory.
> + */
> +static void libie_ctlq_init_regs(struct libie_ctlq_info *ctlq)
> +{
> +	u32 dword;
> +
> +	if (ctlq->type == LIBIE_CTLQ_TYPE_RX)
> +		writel(ctlq->ring_len - 1, ctlq->reg.tail);
> +
> +	writel(0, ctlq->reg.head);
> +	writel(lower_32_bits(ctlq->ring_mem.pa), ctlq->reg.addr_low);
> +	writel(upper_32_bits(ctlq->ring_mem.pa), ctlq->reg.addr_high);
> +
> +	dword = FIELD_PREP(LIBIE_CTLQ_MBX_ATQ_LEN, ctlq->ring_len) |
> +		ctlq->reg.len_ena_mask;
> +	writel(dword, ctlq->reg.len);
> +}
> +
> +/**
> + * libie_find_ctlq - find the controlq for the given id and type
> + * @ctx: controlq context structure
> + * @type: type of controlq to find
> + * @id: controlq id to find
> + *
> + * Return: control queue info pointer on success, NULL on failure
> + */
> +struct libie_ctlq_info *libie_find_ctlq(struct libie_ctlq_ctx *ctx,
> +					enum virtchnl2_queue_type type,
> +					  int id)
> +{
> +	struct libie_ctlq_info *cq;
> +
> +	guard(spinlock)(&ctx->ctlqs_lock);
> +
> +	list_for_each_entry(cq, &ctx->ctlqs, list)
> +		if (cq->qid == id && cq->type == type)
> +			return cq;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_find_ctlq, "LIBIE_CP");
> +
> +/**
> + * libie_ctlq_add - add one control queue
> + * @ctx: controlq context information
> + * @qinfo: information that requires for queue creation
> + *
> + * Allocate and initialize a control queue and add it to the control queue list.
> + * The ctlq parameter will be allocated/initialized and passed back to the
> + * caller if no errors occur.
> + *
> + * Note: libie_ctlq_init must be called prior to any calls to libie_ctlq_add.
> + *
> + * Return: added control queue info pointer on success, error pointer on failure
> + */
> +static struct libie_ctlq_info *
> +libie_ctlq_add(struct libie_ctlq_ctx *ctx,
> +	       const struct libie_ctlq_create_info *qinfo)
> +{
> +	struct libie_ctlq_info *ctlq;
> +
> +	if (qinfo->id != LIBIE_CTLQ_MBX_ID)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	/* libie_ctlq_init was not called */
> +	scoped_guard(spinlock, &ctx->ctlqs_lock)
> +		if (!ctx->ctlqs.next)
> +			return ERR_PTR(-EINVAL);
> +
> +	ctlq = kvzalloc_obj(*ctlq);
> +	if (!ctlq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ctlq->type = qinfo->type;
> +	ctlq->qid = qinfo->id;
> +	ctlq->ring_len = qinfo->len;
> +	ctlq->dev = &ctx->mmio_info.pdev->dev;
> +	ctlq->reg = qinfo->reg;
> +
> +	if (libie_ctlq_alloc_queue_res(ctlq)) {
> +		kvfree(ctlq);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	libie_ctlq_init_regs(ctlq);
> +
> +	spin_lock_init(&ctlq->lock);
> +
> +	scoped_guard(spinlock, &ctx->ctlqs_lock)
> +		list_add(&ctlq->list, &ctx->ctlqs);
> +
> +	return ctlq;
> +}
> +
> +/**
> + * libie_ctlq_remove - deallocate and remove specified control queue
> + * @ctx: libie context information
> + * @ctlq: specific control queue that needs to be removed
> + */
> +static void libie_ctlq_remove(struct libie_ctlq_ctx *ctx,
> +			      struct libie_ctlq_info *ctlq)
> +{
> +	scoped_guard(spinlock, &ctx->ctlqs_lock)
> +		list_del(&ctlq->list);
> +
> +	libie_ctlq_dealloc_ring_res(ctlq);
> +	kvfree(ctlq);
> +}
> +
> +/**
> + * libie_ctlq_init - main initialization routine for all control queues
> + * @ctx: libie context information
> + * @qinfo: array of structs containing info for each queue to be initialized
> + * @numq: number of queues to initialize
> + *
> + * This initializes queue list and adds any number and any type of control
> + * queues. This is an all or nothing routine; if one fails, all previously
> + * allocated queues will be destroyed. This must be called prior to using
> + * the individual add/remove APIs.
> + *
> + * Return: %0 on success, -%errno on failure
> + */
> +int libie_ctlq_init(struct libie_ctlq_ctx *ctx,
> +		    const struct libie_ctlq_create_info *qinfo,
> +		     u32 numq)
> +{
> +	INIT_LIST_HEAD(&ctx->ctlqs);
> +	spin_lock_init(&ctx->ctlqs_lock);
> +
> +	for (u32 i = 0; i < numq; i++) {
> +		struct libie_ctlq_info *ctlq;
> +
> +		ctlq = libie_ctlq_add(ctx, &qinfo[i]);
> +		if (IS_ERR(ctlq)) {
> +			libie_ctlq_deinit(ctx);
> +			return PTR_ERR(ctlq);
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_init, "LIBIE_CP");
> +
> +/**
> + * libie_ctlq_deinit - destroy all control queues
> + * @ctx: libie CP context information
> + */
> +void libie_ctlq_deinit(struct libie_ctlq_ctx *ctx)
> +{
> +	struct libie_ctlq_info *ctlq, *tmp;
> +
> +	list_for_each_entry_safe(ctlq, tmp, &ctx->ctlqs, list)
> +		libie_ctlq_remove(ctx, ctlq);
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_deinit, "LIBIE_CP");
> +
> +/**
> + * libie_ctlq_tx_desc_from_msg - initialize a Tx descriptor from a message
> + * @desc: descriptor to be initialized
> + * @msg: filled control queue message
> + */
> +static void libie_ctlq_tx_desc_from_msg(struct libie_ctlq_desc *desc,
> +					const struct libie_ctlq_msg *msg)
> +{
> +	const struct libie_cp_dma_mem *dma = &msg->send_mem;
> +	u64 qword;
> +
> +	qword = FIELD_PREP(LIBIE_CTLQ_DESC_FLAGS, msg->flags) |
> +		FIELD_PREP(LIBIE_CTLQ_DESC_INFRA_OPCODE, msg->opcode) |
> +		FIELD_PREP(LIBIE_CTLQ_DESC_PFID_VFID, msg->func_id);
> +	desc->qword0 = cpu_to_le64(qword);
> +
> +	qword = FIELD_PREP(LIBIE_CTLQ_DESC_VIRTCHNL_OPCODE,
> +			   msg->chnl_opcode) |
> +		FIELD_PREP(LIBIE_CTLQ_DESC_VIRTCHNL_MSG_RET_VAL,
> +			   msg->chnl_retval);
> +	desc->qword1 = cpu_to_le64(qword);
> +
> +	qword = FIELD_PREP(LIBIE_CTLQ_DESC_MSG_PARAM0, msg->param0) |
> +		FIELD_PREP(LIBIE_CTLQ_DESC_SW_COOKIE,
> +			   msg->sw_cookie) |
> +		FIELD_PREP(LIBIE_CTLQ_DESC_VIRTCHNL_FLAGS,
> +			   msg->virt_flags);
> +	desc->qword2 = cpu_to_le64(qword);
> +
> +	if (likely(msg->data_len)) {
> +		desc->qword0 |=
> +			cpu_to_le64(LIBIE_CTLQ_DESC_QWORD0(msg->data_len));
> +		qword = FIELD_PREP(LIBIE_CTLQ_DESC_DATA_ADDR_HIGH,
> +				   upper_32_bits(dma->pa)) |
> +			FIELD_PREP(LIBIE_CTLQ_DESC_DATA_ADDR_LOW,
> +				   lower_32_bits(dma->pa));
> +	} else {
> +		qword = msg->addr_param;
> +	}
> +
> +	desc->qword3 = cpu_to_le64(qword);
> +}
> +
> +/**
> + * libie_ctlq_send_desc_avail - get number of free descriptors on a Tx ctlq
> + * @ctlq: specific control queue which is going be used for sending messages
> + *
> + * The caller must hold ctlq->lock. Any dependent sending must be done
> + * in the same critical section.
> + *
> + * Return: number of available descriptors/messages on a given control queue.
> + */
> +u32 libie_ctlq_send_desc_avail(const struct libie_ctlq_info *ctlq)
> +{
> +	u32 ntu = ctlq->next_to_use, ntc = ctlq->next_to_clean;
> +
> +	return (ntc > ntu ? 0 : ctlq->ring_len) + ntc - ntu - 1;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_send_desc_avail, "LIBIE_CP");
> +
> +/**
> + * libie_ctlq_send - send a message to Control Plane or Peer
> + * @ctlq: specific control queue which is used for sending a message
> + * @num_q_msg: number of messages present to send on @ctlq,
> + *	       positive and no greater than the number of available descriptors
> + *
> + * The caller must fill in @num_q_msg Tx messages staring at ntu beforehand.
> + *
> + * The caller must hold ctlq->lock. The intended pattern is to first check
> + * the number of descriptors available, then fill in the messages and perform
> + * send within a single critical section.
> + *
> + * Return: %0 on success, -%errno on failure.
> + */
> +void libie_ctlq_send(struct libie_ctlq_info *ctlq, u32 num_q_msg)
> +{
> +	u32 ntu = ctlq->next_to_use;
> +
> +	for (int i = 0; i < num_q_msg; i++) {
> +		struct libie_ctlq_msg *msg = ctlq->tx_msg[ntu];
> +		struct libie_ctlq_desc *desc;
> +
> +		desc = &ctlq->descs[ntu];
> +		libie_ctlq_tx_desc_from_msg(desc, msg);
> +
> +		if (unlikely(++ntu == ctlq->ring_len))
> +			ntu = 0;
> +	}
> +	writel(ntu, ctlq->reg.tail);
> +	ctlq->next_to_use = ntu;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_send, "LIBIE_CP");
> +
> +/**
> + * libie_ctlq_fill_rx_msg - fill in a message from Rx descriptor and buffer
> + * @msg: message to be filled in
> + * @desc: received descriptor
> + * @rx_buf: fill queue buffer associated with the descriptor
> + */
> +static void libie_ctlq_fill_rx_msg(struct libie_ctlq_msg *msg,
> +				   const struct libie_ctlq_desc *desc,
> +				    struct libeth_fqe *rx_buf)
> +{
> +	u64 qword = le64_to_cpu(desc->qword0);
> +
> +	msg->flags = FIELD_GET(LIBIE_CTLQ_DESC_FLAGS, qword);
> +	msg->opcode = FIELD_GET(LIBIE_CTLQ_DESC_INFRA_OPCODE, qword);
> +	msg->data_len = FIELD_GET(LIBIE_CTLQ_DESC_DATA_LEN, qword);
> +	msg->hw_retval = FIELD_GET(LIBIE_CTLQ_DESC_HW_RETVAL, qword);
> +
> +	qword = le64_to_cpu(desc->qword1);
> +	msg->chnl_opcode =
> +		FIELD_GET(LIBIE_CTLQ_DESC_VIRTCHNL_OPCODE, qword);
> +	msg->chnl_retval =
> +		FIELD_GET(LIBIE_CTLQ_DESC_VIRTCHNL_MSG_RET_VAL, qword);
> +
> +	qword = le64_to_cpu(desc->qword2);
> +	msg->param0 =
> +		FIELD_GET(LIBIE_CTLQ_DESC_MSG_PARAM0, qword);
> +	msg->sw_cookie =
> +		FIELD_GET(LIBIE_CTLQ_DESC_SW_COOKIE, qword);
> +	msg->virt_flags =
> +		FIELD_GET(LIBIE_CTLQ_DESC_VIRTCHNL_FLAGS, qword);
> +
> +	if (likely(msg->data_len)) {
> +		if (unlikely(msg->data_len > LIBIE_CTLQ_MAX_BUF_LEN)) {
> +			msg->data_len = LIBIE_CTLQ_MAX_BUF_LEN;
> +			msg->chnl_retval = U32_MAX;
> +		}
> +		msg->recv_mem = (struct kvec) {
> +			.iov_base = netmem_address(rx_buf->netmem),
> +			.iov_len = msg->data_len,
> +		};
> +		libeth_rx_sync_for_cpu(rx_buf, msg->data_len);
> +	} else {
> +		msg->recv_mem = (struct kvec) {};
> +		msg->addr_param = le64_to_cpu(desc->qword3);
> +		page_pool_put_full_netmem(netmem_get_pp(rx_buf->netmem),
> +					  rx_buf->netmem, false);
> +	}
> +}
> +
> +/**
> + * libie_ctlq_recv - receive control queue message call back
> + * @ctlq: control queue that needs to processed for receive
> + * @msg: array of received control queue messages on this q;
> + * needs to be pre-allocated by caller for as many messages as requested
> + * @num_q_msg: number of messages that can be stored in msg buffer
> + *
> + * Called by interrupt handler or polling mechanism. Caller is expected
> + * to free buffers.
> + *
> + * The caller must make sure that calls to libie_ctlq_post_rx_buffs()
> + * and libie_ctlq_recv() for each queue are either serialized
> + * or used under ctlq->lock.
> + *
> + * Return: number of messages received
> + */
> +u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,
> +		    u32 num_q_msg)
> +{
> +	u32 ntc, i;
> +
> +	ntc = ctlq->next_to_clean;
> +
> +	for (i = 0; i < num_q_msg; i++) {
> +		const struct libie_ctlq_desc *desc = &ctlq->descs[ntc];
> +		struct libeth_fqe *rx_buf = &ctlq->rx_fqes[ntc];
> +		u64 qword;
> +
> +		qword = le64_to_cpu(desc->qword0);
> +		if (!FIELD_GET(LIBIE_CTLQ_DESC_FLAG_DD, qword))
> +			break;
> +
> +		dma_rmb();
> +
> +		libie_ctlq_fill_rx_msg(&msg[i], desc, rx_buf);
> +
> +		if (unlikely(++ntc == ctlq->ring_len))
> +			ntc = 0;
> +	}
> +
> +	ctlq->next_to_clean = ntc;
> +
> +	return i;
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_ctlq_recv, "LIBIE_CP");
> +
> +MODULE_DESCRIPTION("Control Plane communication API");
> +MODULE_IMPORT_NS("LIBETH");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/intel/libie/controlq.h b/include/linux/intel/libie/controlq.h
> new file mode 100644
> index 000000000000..a6ed4fa159b1
> --- /dev/null
> +++ b/include/linux/intel/libie/controlq.h
> @@ -0,0 +1,249 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef __LIBIE_CONTROLQ_H
> +#define __LIBIE_CONTROLQ_H
> +
> +#include <net/libeth/rx.h>
> +
> +#include <linux/intel/libie/pci.h>
> +#include <linux/intel/virtchnl2.h>
> +
> +/* Default mailbox control queue */
> +#define LIBIE_CTLQ_MBX_ID			-1
> +#define LIBIE_CTLQ_MAX_BUF_LEN			SZ_4K
> +
> +#define LIBIE_CTLQ_TYPE_TX			0
> +#define LIBIE_CTLQ_TYPE_RX			1
> +
> +/* Opcode used to send controlq message to the control plane */
> +#define LIBIE_CTLQ_SEND_MSG_TO_CP		0x801
> +#define LIBIE_CTLQ_SEND_MSG_TO_PEER		0x804
> +
> +/**
> + * struct libie_ctlq_ctx - contains controlq info and MMIO region info
> + * @mmio_info: MMIO region info structure
> + * @ctlqs: list that stores all the control queues
> + * @ctlqs_lock: lock for control queue list
> + */
> +struct libie_ctlq_ctx {
> +	struct libie_mmio_info	mmio_info;
> +	struct list_head	ctlqs;
> +	spinlock_t		ctlqs_lock;	/* protects the ctlqs list */
> +};
> +
> +/**
> + * struct libie_ctlq_reg - structure representing virtual addresses of the
> + *			    controlq registers and masks
> + * @head: controlq head register address
> + * @tail: controlq tail register address
> + * @len: register address to write controlq length and enable bit
> + * @addr_high: register address to write the upper 32b of ring physical address
> + * @addr_low: register address to write the lower 32b of ring physical address
> + * @len_mask: mask to read the controlq length
> + * @len_ena_mask: mask to write the controlq enable bit
> + * @head_mask: mask to read the head value
> + */
> +struct libie_ctlq_reg {
> +	void __iomem	*head;
> +	void __iomem	*tail;
> +	void __iomem	*len;
> +	void __iomem	*addr_high;
> +	void __iomem	*addr_low;
> +	u32		len_mask;
> +	u32		len_ena_mask;
> +	u32		head_mask;
> +};
> +
> +/**
> + * struct libie_cp_dma_mem - structure for DMA memory
> + * @va: virtual address
> + * @pa: physical address
> + * @size: memory size
> + */
> +struct libie_cp_dma_mem {
> +	void		*va;
> +	dma_addr_t	pa;
> +	size_t		size;
> +};
> +
> +/**
> + * struct libie_ctlq_msg - control queue message data
> + * @flags: refer to 'Flags sub-structure' definitions
> + * @opcode: infrastructure message opcode
> + * @data_len: size of the payload
> + * @func_id: queue id for the secondary mailbox queue, 0 for default mailbox
> + * @hw_retval: execution status from the HW
> + * @chnl_opcode: virtchnl message opcode
> + * @chnl_retval: virtchnl return value
> + * @param0: indirect message raw parameter0
> + * @sw_cookie: used to verify the response of the sent virtchnl message
> + * @virt_flags: virtchnl capability flags
> + * @addr_param: additional parameters in place of the address, given no buffer
> + * @recv_mem: virtual address and size of the buffer that contains
> + *	      the indirect response
> + * @send_mem: physical and virtual address of the DMA buffer,
> + *	      used for sending
> + */
> +struct libie_ctlq_msg {
> +	u16			flags;
> +	u16			opcode;
> +	u16			data_len;
> +	union {
> +		u16		func_id;
> +		u16		hw_retval;
> +	};
> +	u32			chnl_opcode;
> +	u32			chnl_retval;
> +	u32			param0;
> +	u16			sw_cookie;
> +	u16			virt_flags;
> +	u64			addr_param;
> +	union {
> +		struct kvec	recv_mem;
> +		struct	libie_cp_dma_mem send_mem;
> +	};
> +};
> +
> +/**
> + * struct libie_ctlq_create_info - control queue create information
> + * @type: control queue type (Rx or Tx)
> + * @id: queue offset passed as input, -1 for default mailbox
> + * @reg: registers accessed by control queue
> + * @len: controlq length
> + */
> +struct libie_ctlq_create_info {
> +	enum virtchnl2_queue_type	type;
> +	int				id;
> +	struct libie_ctlq_reg		reg;
> +	u16				len;
> +};
> +
> +/**
> + * struct libie_ctlq_info - control queue information
> + * @list: used to add a controlq to the list of queues in libie_ctlq_ctx
> + * @type: control queue type
> + * @qid: queue identifier
> + * @lock: control queue lock
> + * @ring_mem: descriptor ring DMA memory
> + * @descs: array of descriptors
> + * @rx_fqes: array of controlq Rx buffers
> + * @tx_msg: Tx messages sent to hardware
> + * @reg: registers used by control queue
> + * @dev: device that owns this control queue
> + * @pp: page pool for controlq Rx buffers
> + * @truesize: size to allocate per buffer
> + * @next_to_use: next available slot to send buffer
> + * @next_to_clean: next descriptor to be cleaned
> + * @next_to_post: next available slot to post buffers to after receive
> + * @ring_len: length of the descriptor ring
> + */
> +struct libie_ctlq_info {
> +	struct list_head		list;
> +	enum virtchnl2_queue_type	type;
> +	int				qid;
> +	spinlock_t			lock;	/* for concurrent processing */
> +	struct libie_cp_dma_mem	ring_mem;
> +	struct libie_ctlq_desc		*descs;
> +	union {
> +		struct libeth_fqe		*rx_fqes;
> +		struct libie_ctlq_msg		**tx_msg;
> +	};
> +	struct libie_ctlq_reg		reg;
> +	struct device			*dev;
> +	struct page_pool		*pp;
> +	u32				truesize;
> +	u32				next_to_clean;
> +	union {
> +		u32			next_to_use;
> +		u32			next_to_post;
> +	};
> +	u32				ring_len;
> +};
> +
> +#define LIBIE_CTLQ_MBX_ATQ_LEN			GENMASK(9, 0)
> +
> +/* Flags sub-structure
> + * |0  |1  |2  |3  |4  |5  |6  |7  |8  |9  |10 |11 |12 |13 |14 |15 |
> + * |DD |CMP|ERR|  * RSV *  |FTYPE  | *RSV* |RD |VFC|BUF|  HOST_ID  |
> + */
> + /* libie controlq descriptor qword0 details */
> +#define LIBIE_CTLQ_DESC_FLAG_DD		BIT(0)
> +#define LIBIE_CTLQ_DESC_FLAG_CMP		BIT(1)
> +#define LIBIE_CTLQ_DESC_FLAG_ERR		BIT(2)
> +#define LIBIE_CTLQ_DESC_FLAG_FTYPE_VM		BIT(6)
> +#define LIBIE_CTLQ_DESC_FLAG_FTYPE_PF		BIT(7)
> +#define LIBIE_CTLQ_DESC_FLAG_FTYPE		GENMASK(7, 6)
> +#define LIBIE_CTLQ_DESC_FLAG_RD		BIT(10)
> +#define LIBIE_CTLQ_DESC_FLAG_VFC		BIT(11)
> +#define LIBIE_CTLQ_DESC_FLAG_BUF		BIT(12)
> +#define LIBIE_CTLQ_DESC_FLAG_HOST_ID		GENMASK(15, 13)
> +
> +#define LIBIE_CTLQ_DESC_FLAGS			GENMASK(15, 0)
> +#define LIBIE_CTLQ_DESC_INFRA_OPCODE		GENMASK_ULL(31, 16)
> +#define LIBIE_CTLQ_DESC_DATA_LEN		GENMASK_ULL(47, 32)
> +#define LIBIE_CTLQ_DESC_HW_RETVAL		GENMASK_ULL(63, 48)
> +
> +#define LIBIE_CTLQ_DESC_PFID_VFID		GENMASK_ULL(63, 48)
> +
> +/* libie controlq descriptor qword1 details */
> +#define LIBIE_CTLQ_DESC_VIRTCHNL_OPCODE	GENMASK(27, 0)
> +#define LIBIE_CTLQ_DESC_VIRTCHNL_DESC_TYPE	GENMASK_ULL(31, 28)
> +#define LIBIE_CTLQ_DESC_VIRTCHNL_MSG_RET_VAL	GENMASK_ULL(63, 32)
> +
> +/* libie controlq descriptor qword2 details */
> +#define LIBIE_CTLQ_DESC_MSG_PARAM0		GENMASK_ULL(31, 0)
> +#define LIBIE_CTLQ_DESC_SW_COOKIE		GENMASK_ULL(47, 32)
> +#define LIBIE_CTLQ_DESC_VIRTCHNL_FLAGS		GENMASK_ULL(63, 48)
> +
> +/* libie controlq descriptor qword3 details */
> +#define LIBIE_CTLQ_DESC_DATA_ADDR_HIGH		GENMASK_ULL(31, 0)
> +#define LIBIE_CTLQ_DESC_DATA_ADDR_LOW		GENMASK_ULL(63, 32)
> +
> +/**
> + * struct libie_ctlq_desc - control queue descriptor format
> + * @qword0: flags, message opcode, data length etc
> + * @qword1: virtchnl opcode, descriptor type and return value
> + * @qword2: indirect message parameters
> + * @qword3: indirect message buffer address
> + */
> +struct libie_ctlq_desc {
> +	__le64			qword0;
> +	__le64			qword1;
> +	__le64			qword2;
> +	__le64			qword3;
> +};
> +
> +/**
> + * libie_ctlq_release_rx_buf - Release Rx buffer for a specific control queue
> + * @rx_buf: Rx buffer to be freed
> + *
> + * Driver uses this function to post back the Rx buffer after the usage.
> + */
> +static inline void libie_ctlq_release_rx_buf(struct kvec *rx_buf)
> +{
> +	netmem_ref netmem;
> +
> +	if (!rx_buf->iov_base)
> +		return;
> +
> +	netmem = virt_to_netmem(rx_buf->iov_base);
> +	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
> +}
> +
> +int libie_ctlq_init(struct libie_ctlq_ctx *ctx,
> +		    const struct libie_ctlq_create_info *qinfo,  u32 numq);
> +void libie_ctlq_deinit(struct libie_ctlq_ctx *ctx);
> +
> +struct libie_ctlq_info *libie_find_ctlq(struct libie_ctlq_ctx *ctx,
> +					enum virtchnl2_queue_type type,
> +					  int id);
> +
> +u32 libie_ctlq_send_desc_avail(const struct libie_ctlq_info *ctlq);
> +void libie_ctlq_send(struct libie_ctlq_info *ctlq, u32 num_q_msg);
> +u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,
> +		    u32 num_q_msg);
> +
> +int libie_ctlq_post_rx_buffs(struct libie_ctlq_info *ctlq);
> +
> +#endif /* __LIBIE_CONTROLQ_H */
> -- 
> 2.47.1
> 

