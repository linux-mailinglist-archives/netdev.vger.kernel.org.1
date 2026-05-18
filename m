Return-Path: <netdev+bounces-288989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EbEMjPpCmpt9QQAu9opvQ
	(envelope-from <netdev+bounces-288989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:25:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B0456AA57
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D44E230057B5
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A03B7B79;
	Mon, 18 May 2026 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJuSM6cS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E653E16BA;
	Mon, 18 May 2026 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099811; cv=fail; b=q+L0wwXOcOCrsTxbXAEQX+171Pq1rYdOIVeS23dAtnEPYEJBtqTJLfuiWs1WPUzW6nincocknPN4EI33nqBl+gsYBIhEBfobUoMsW0XEgqvj5QcUSCFLENoPTweUSm75gwO6qn8ftPYQ9F2U+6NXArJzGFb0ZAWVpdY17tC70vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099811; c=relaxed/simple;
	bh=YGr0Eh36uUx7vdgxsqYOD5hDY+F0tSQtOKz44dFVfzs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WWKVHOEjn8yW17u/NET1i+evrAf0MpCisqDIfLL4J+firbrr8IxeYNrbN9gToKJy5pY30al2BZBL6AywYzZKi5qGUbjRbEamuXIUcUAkr0EPfc9EA2vXSeTI/YfL4VADPETYseJYVmxDga2j2hBQTUqi5yjKC/972plcrBnLgy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJuSM6cS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779099808; x=1810635808;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YGr0Eh36uUx7vdgxsqYOD5hDY+F0tSQtOKz44dFVfzs=;
  b=UJuSM6cSlQX20q5CllHvpmNZv3tVJrN6N8amfUZiT7cQ1BhxQ7ZyPdyM
   Gl67kW8vA97rbwZiQxVeHd8aseViOdYX+WpVVRcbYiwiQj4BkIn/4QhD9
   yq63vHkz0nJfKu1dark0q/KOAkT5Ov2QjwhbY5IuMsGdMmJfSHYHj1+AP
   dN0nVzdZkNYy2FVfP3maSB++urjbHLCu+lhSTe0S9ZD0hKk1f4oSL5big
   aGZFPmYNzcREeo/s2h5OD1tsvqOR/zrwJArlzUsnQr/HRoTmk0sJucFiI
   dDRmn0n5wCIYcsra3SSRMRG7VeU5yGprBnQ0dyR+mJjbngWyHI64cuEP9
   Q==;
X-CSE-ConnectionGUID: P3wP+GgVTEWoudUWeRpUVg==
X-CSE-MsgGUID: Ks25wLfcQY+frBQKUPdpRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79087334"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79087334"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:23:27 -0700
X-CSE-ConnectionGUID: 6a+zUFHUS0K84Gfw9JgxFQ==
X-CSE-MsgGUID: K2ApN3UQQ7eJTuAzKPO28w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="269727433"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:23:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 03:23:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 03:23:26 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 03:23:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQvWmDSof1c4FqvO6xEpz9h9X/7SYy3UJO00ItQlry8zC8SuimTXhun71S0/MJmckEqaFy3zo1rV98xO89GhPRAsI7dr+ny1vOOAcaiulQ8C82lD9F9K9wMMt0ZqkvnUF3sUxHZh/k0kvRKjheFT9C7fIEzEg92LY/wl683OlwEbdSkb6JN02EJgAWTN837pcUVl+2/sn30VRTdw9OHYV3WkqDVVq1tui52tW87vuyVakzHZLwmLh9EokLgscMaeekfMgsLea1XvClxiFN/Uhi76+KmQi7OklljaaoKpyac5I9kT4noa7j0EW7GQylNss7YP9K2b7ZwZzOB+2qmUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQnSqCIDjLAdCwlat0frc3XNWYb+1USsXU9UD7kDphQ=;
 b=GQmPM8nWz4qJudCzhBgxcZ4eEUJ/X+hYuLA5pAQlH/SzLp+/HkNzjFi/obSPDc2iJ6r8NIRAvAr6zUHX3Vrg6L75uzJrOq/UjIZ2N1masDM1cReNqmWi4F6+xtFMJzb1/H7xOFiYs8fLap89JJWtmP7OOxE5D5VsaIgx/8bJ1Z88xLfdrfJkgriYNKfPD6PCjJF2jufWGotli0a0mR+wBbifUlWFE88ezUXtraLqlXNEO+8aHYEHcaHooqjCSWxmTra/MqdXOUtFAG9XqDyi1qwJL3u1Mhaabhs+LUa0t3TjkS83nXwBTlddiu4dhkVB+1oFJ/4sPViuYl5c1m2Kww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DSSPR11MB9644.namprd11.prod.outlook.com (2603:10b6:8:374::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 10:23:23 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 10:23:22 +0000
Date: Mon, 18 May 2026 12:23:12 +0200
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
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next v3 00/14][pull request] Introduce iXD driver
Message-ID: <agrokJC72PKcIeoV@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::35) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DSSPR11MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abe3414-80e6-4328-e789-08deb4c77d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: MHKSLZm+Ly4XtNOQFVEw+vy0Wc1oHI94aoyZmA00oPAODJ2pOpAFm2o/iwVUv0EvUVJU419sfFS98KpHzliSjqD/E03P8wsuJsh7sMP0Pr7L/QksTlh6VpayvmTI3AarlMe6NmP4ovENa3VmuPrtSyEzrMmTFz/9BJ4OVyHDuLXxETt0v9UgKa+bBJ/+hX1A7I8P7YACx3ujXtn7eiUSPkVy/spfIQugNEy8wduxJRaWJ2fMgF+/j9Zp5bftqN3W0f11/pEVm56vhCAQQeuZvCl1c7nds74hh3/8guwpCqMcuHIs2gJCO8kTI2K/hn7+FVRMCE3Tj1+fsNZuWrAKBgb8sGgt1UYaN4AxtHFuuJwRzXeVL1WBrg/4ELAYdm25wmaBid5nwrcs6aWpZgzRy0FylZIf2a+V1RjLZ1QYinCtCE7I5z2QGiFHO2TwIkTBMOVJU5qCp+5fDEiYG/igrqGK9LtUMfzD2Ot3mdOFx8rHv3/KPvlj8nUdilfENyPIOa42Pfmb3lByua1EuF+Qis7LNNT2+cNSMeJTtDANLve6X2C+W4Thp9zBxAz6BhjnwvjM36y3kXz9Imp/jOLc6sqysUoQkhwMQogdaRvk6LJ4a2yuS9wZUgIFUKI1gTPRbu5ip8ObN1ok9nd6Vj46SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eMK2DrVVzr7rrz9oC+YvgGYLtXVOqBvx4+EasU0pqf1EVoQJW1U85I1UwCI3?=
 =?us-ascii?Q?qDHZ/Pt01g80Qa2WmP1sOfJkzw7UWS9f5G2wXA/Nf+JWsB6lNcStS6KFncYx?=
 =?us-ascii?Q?LvvhpwfiWxfKg65X8TRehQjhOa0J9G11pSy4cAzcupmfM+tsc1lFd2iDbKiO?=
 =?us-ascii?Q?b9LYp9wduGes5MeTMrH84x7IuBfbtpT4TPCx+y4fMsWwaI2O3oQtPUejuiKo?=
 =?us-ascii?Q?yossSehUVPIDLjvAgnli53tvksOt9CcKdORsuqI/fG8GnCismhd0WIpg9+lC?=
 =?us-ascii?Q?RQBOUguj4HagjL2m57zEG5k2WjzCkHMS6ThPjtHKQ613P08nIDvHl8UhvnFi?=
 =?us-ascii?Q?OrJsoTberm1N52H51YWu4jp/TQGXojQYTyosJ6hZBLhzZPHRZL+aEcEMv6DO?=
 =?us-ascii?Q?9VjdLnI3QNTqPccxdCBJLU+flF8ShdLccIptOtmasww5981qfBsHwm6EEKYB?=
 =?us-ascii?Q?wp11EdUgMqWAjYILRn2RZnPgX2WZ7/SewuXjt+QuIfeR4PqUGaVCw6fMZtNV?=
 =?us-ascii?Q?F6z39r08w5QuGz8KeIDuIYvx9oJtkOpvXMyh8YevocIy57sCsL6jLARepfdX?=
 =?us-ascii?Q?+t/szQEN3znT5t8x+euNfQotGWQZVaYVxN8FYmK3jU6zf7aorwHOhbjOwbNp?=
 =?us-ascii?Q?QcGkMc4X3nQ5C3pUilBrtx4PCu58ixHdANALr6Jz0l60pM+4qH41cupoW9Fj?=
 =?us-ascii?Q?Q1e7DSH44TgKogDrkWLFlSkNQ8KJ04LXXK0GUkQf13smnjn84ks81CWjEaqN?=
 =?us-ascii?Q?JpfXbC8QqBkN5igyyAE3NXHrh3CyBfOk/D/RjU5Poq8NAMPGQizuICAU6a7/?=
 =?us-ascii?Q?VGcY5zLXPlol4nLulizrfV4PKRwVTcoNPuUgUdifmm+rfn7FABsgNUUM1R/m?=
 =?us-ascii?Q?UkaQ9kC6Og/PlHonHPKgsF6jK5tObrI7LQanHQjbDXod3/ODYX3UCkTowLd1?=
 =?us-ascii?Q?2EF1wIirzyJzfH57A/WDjyBIC0ACzT1xKToI0qcQKQJ95LoCkH5FF9djy/OV?=
 =?us-ascii?Q?Vf69ijn/nPNrmUDDh7Ylb5v0aXIfyFKxhBd6yIj+6Q20K4s4jC+DPr3ur2wH?=
 =?us-ascii?Q?LLkDSUN2v/k9xwhL84D3YmSwQVzQda8UokmBf1C9isJg+82lKZ+qWn8t2hp/?=
 =?us-ascii?Q?cWMEkX0M22/DPt6XOaG71EXTfJh+ds/FmeSCgQ3fZNgGE9OjDaWw6iCHHabi?=
 =?us-ascii?Q?kzg/vtoBwzQtGFjaJCifi8oTJcpL6tdoSdwJj37fhy8Djep85o3SvavGa+ex?=
 =?us-ascii?Q?3jr4dl5ed+EjKGuRo8JAM0UQBVZxwc/jdIm3hrwzQpM9yNmU8z3dqlAM+m72?=
 =?us-ascii?Q?gKlmlwhaaUusUmYTKNtrdhelR5RL4FRzhhdHhfdgNmZGfRb6N77ftqHWd0Ji?=
 =?us-ascii?Q?pACAqeXfu1CaVQVN8ZCQDkyGLENahab6rjFuVnBH9QaJn7ZkfiXPjY4ja9fn?=
 =?us-ascii?Q?SkxnQ2LTHxAVW1DVP3L0MlDaKFSTsFG0FVcBPYEmGerBS5X5jWq5pdIpg1cs?=
 =?us-ascii?Q?FPpfp/8xg/HEfxTXQVrN+TLRLthhpt1YsvA40ePpT4/V7OFynVagcJzFX8TU?=
 =?us-ascii?Q?SJWZHAPK1ahNduiCotl27ZeMRK12Yhd2+HJ4QSH4b14CfiLsmJb9BnsYTopG?=
 =?us-ascii?Q?FH6HgOvULdcU7ZBsku07r56EcxFscdgnJNoPENAuhoUbk4KI0XNyaoq3uUkW?=
 =?us-ascii?Q?4wL0bDmgoSlq8zb/tXOu17qpP7qWPu1F3KwFN4Nzkd2jpETsA582pQ6CAKlr?=
 =?us-ascii?Q?pKPABmXwevfu36kj9+THvrm9voBRYlfg1OU5u1RuVs+ukyEeMYCnk8LxDDJl?=
X-MS-Exchange-AntiSpam-MessageData-1: mHwuasjUmbvbBMudP1MdczArGKsn/id1r2Q=
X-Exchange-RoutingPolicyChecked: dzuXwbdDljM/Ffn97tCRJPrS+KJgEBXR1RH5uZPrEXnf3VmGSFgsE2CVbf8++Ea/gYv5kYep5r/mROTlQ6d24ACtJ+imOAPx4PldMhrduQ5TkI/J7nBp0kz8W/GEXcdOyPrIcztW8LqTe9pbyQN5h9TjzzJCziWKIvSqAZdTTWX6g94bDCIcSRBQRLhzySdRWXnvIowrw9x4Ppw6xUk0/9HAJMbdhTFI9fFi+jCCNDUsD8tSY2CgRUe/WARlabM5Ar4tDADhR2HomcFD/B8Ob2EN8czZs9wKxaeMG/wgUWxN86hKpH34owZPoPcRZCc/BUwAI4kC2vY0veWR1Zl8BQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abe3414-80e6-4328-e789-08deb4c77d3f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:23:22.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uI/E5ShwBpygbyYXkeSE0T4psIfbyg4h2/bIZMjC1Fh9jD4svBUhdlNNNT+hXI4L/53IBd/ddz3Mo9q+JYTuyrsB79H1jlt4I3TJQS1/NPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9644
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 21B0456AA57
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
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288989-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,soc-5CG4396X81.clients.intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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

On Fri, May 15, 2026 at 03:44:24PM -0700, Tony Nguyen wrote:
> Larysa Zaremba says:

I have reviewed Sashiko's feedback and there are some valid points remaining 
after several rounds of AI review (both Sashiko and "local" [0]). They are a 
minority of comments and all pretty much fall into the following categories:

* existing minor idpf problems with range checking
* problems fixed in the same series
* some more serious problems in the ixd code, but IMO acceptable for 
  introductory boilerplate series.

[0] https://netdev-ai.bots.linux.dev/ai-local.html

> 
> This patch series adds the iXD driver, which supports the Intel(R)
> Control Plane PCI Function on Intel E2100 and later IPUs and FNICs.
> It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
> exposed by the same card. The reason for the separation is to be able
> to offload the control plane to the host different from where the data
> plane is running.
> 
> This is the first phase in the release of this driver where we implement the
> initialization of the core PCI driver. Subsequent phases will implement
> advanced features like usage of idpf ethernet aux device, link management,
> NVM update via devlink, switchdev port representors, data and exception path,
> flow rule programming, etc.
> 
> The first phase entails the following aspects:
> 
> 1. Additional libie functionalities:
> Patches 1-5 introduce additional common library API for drivers to
> communicate with the control plane through mailbox communication.
> A control queue is a hardware interface which is used by the driver
> to interact with other subsystems (like firmware). The library APIs
> allow the driver to setup and configure the control queues to send and
> receive virtchnl messages. The library has an internal bookkeeping
> (XN API) mechanism to keep track of the send messages. It supports both
> synchronous as well as asynchronous way of handling the messages. The
> library also handles the timeout internally for synchronous messages
> using events. This reduces the driver's overhead in handling the timeout
> error cases.
> 
> The current patch series supports only APIs that are needed for device
> initialization. These include APIs in the libie_pci module:
> * Allocating/freeing the DMA memory and mapping the MMIO regions for
>   BAR0, read/write APIs for drivers to access the MMIO memory
> 
> and libie_cp module:
> * Control queue initialization and configuration
> * Transport initialization for bookkeeping
> * Blocking and asynchronous mailbox transactions
> 
> Once the mailbox is initialized, the drivers can send and receive virtchnl
> messages to/from the control plane.
> 
> The modules above are not supposed to be linked witn the main libie library,
> but do share the folder with it.
> 
> 2. idpf:
> Patches 6-9 refactor the idpf driver to use the libie APIs for control
> queue configuration, virtchnl transaction, device initialization
> and reset and adjust related code accordingly.
> 
> 3. ixd:
> Patches 11-14 add the ixd driver and implement multiple pieces of the
> initialization flow as follows:
> * Add the ability to load
> * A reset is issued to ensure a clean device state, followed by
>   initialization of the mailbox
> * Device capabilities:
>   As part of initialization, the driver has to determine what the device is
>   capable of (ex. max queues, vports, etc). This information is obtained from
>   the firmware and stored by the driver.
> * Enable initial support for the devlink interface
> ---
> v3:
> - lock libie ctlq transaction earlier on Rx path
> - improve ctlq Rx buffer size validation both in idpf and libie
> - fix RSS LUT buf size (will also go to stable separately)
> - improve xnm shutdown handling
> - skip zero-sized BAR regions instread of returning error in idpf
> - unify treatment of initialized and uninitialized ctlq messages
> 
> v2: https://lore.kernel.org/netdev/20260403194938.3577011-1-anthony.l.nguyen@intel.com/
> - improved failure handling and input validation
> - removed cp version from devlink in ixd
> 
> v1: https://lore.kernel.org/netdev/20260317230905.847744-1-anthony.l.nguyen@intel.com/
> 
> The following are changes since commit 822d4a8e390a08ccfaf2abb347ae670b230b196f:
>   net: usb: usbnet: use proper ep number macros
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE
> 
> Amritha Nambiar (1):
>   ixd: add devlink support
> 
> Larysa Zaremba (5):
>   idpf: make mbx_task queueing and cancelling more consistent
>   idpf: print a debug message and bail in case of non-event ctlq message
>   ixd: add basic driver framework for Intel(R) Control Plane Function
>   ixd: add reset checks and initialize the mailbox
>   ixd: add the core initialization
> 
> Pavan Kumar Linga (4):
>   libeth: allow to create fill queues without NAPI
>   idpf: remove 'vport_params_reqd' field
>   idpf: refactor idpf to use libie_pci APIs
>   idpf: refactor idpf to use libie control queues
> 
> Phani R Burra (3):
>   libie: add PCI device initialization helpers to libie
>   libie: add control queue support
>   libie: add bookkeeping support for control queue messages
> 
> Victor Raj (1):
>   virtchnl: create 'include/linux/intel' and move necessary header files
> 
>  .../device_drivers/ethernet/index.rst         |    1 +
>  .../device_drivers/ethernet/intel/ixd.rst     |   39 +
>  Documentation/networking/devlink/index.rst    |    1 +
>  Documentation/networking/devlink/ixd.rst      |   30 +
>  MAINTAINERS                                   |    6 +-
>  drivers/infiniband/hw/irdma/i40iw_if.c        |    2 +-
>  drivers/infiniband/hw/irdma/icrdma_if.c       |    2 +-
>  drivers/infiniband/hw/irdma/ig3rdma_if.c      |    2 +-
>  drivers/infiniband/hw/irdma/main.c            |    2 +-
>  drivers/infiniband/hw/irdma/main.h            |    2 +-
>  drivers/net/ethernet/intel/Kconfig            |    2 +
>  drivers/net/ethernet/intel/Makefile           |    1 +
>  drivers/net/ethernet/intel/i40e/i40e.h        |    4 +-
>  .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |    2 +-
>  drivers/net/ethernet/intel/i40e/i40e_client.c |    2 +-
>  drivers/net/ethernet/intel/i40e/i40e_common.c |    2 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |    2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |    2 +-
>  .../net/ethernet/intel/i40e/i40e_prototype.h  |    2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    4 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |    2 +-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |    2 +-
>  drivers/net/ethernet/intel/iavf/iavf.h        |    2 +-
>  .../net/ethernet/intel/iavf/iavf_adminq_cmd.h |    2 +-
>  drivers/net/ethernet/intel/iavf/iavf_common.c |    2 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |    2 +-
>  .../net/ethernet/intel/iavf/iavf_prototype.h  |    2 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c   |    2 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.h   |    2 +-
>  drivers/net/ethernet/intel/iavf/iavf_types.h  |    4 +-
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |    2 +-
>  drivers/net/ethernet/intel/ice/ice.h          |    2 +-
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    2 +-
>  drivers/net/ethernet/intel/ice/ice_base.c     |    2 +-
>  drivers/net/ethernet/intel/ice/ice_common.h   |    2 +-
>  drivers/net/ethernet/intel/ice/ice_flow.h     |    2 +-
>  drivers/net/ethernet/intel/ice/ice_idc_int.h  |    4 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |    2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |    2 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |    2 +-
>  drivers/net/ethernet/intel/ice/ice_vf_lib.h   |    2 +-
>  .../net/ethernet/intel/ice/virt/virtchnl.h    |    2 +-
>  drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
>  drivers/net/ethernet/intel/idpf/Makefile      |    2 -
>  drivers/net/ethernet/intel/idpf/idpf.h        |  103 +-
>  .../net/ethernet/intel/idpf/idpf_controlq.c   |  621 ------
>  .../net/ethernet/intel/idpf/idpf_controlq.h   |  144 --
>  .../ethernet/intel/idpf/idpf_controlq_api.h   |  177 --
>  .../ethernet/intel/idpf/idpf_controlq_setup.c |  169 --
>  drivers/net/ethernet/intel/idpf/idpf_dev.c    |  101 +-
>  .../net/ethernet/intel/idpf/idpf_ethtool.c    |   28 +-
>  drivers/net/ethernet/intel/idpf/idpf_idc.c    |   38 +-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   69 +-
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |  117 +-
>  drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 -
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    4 +-
>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   99 +-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1844 +++++++----------
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   96 +-
>  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  306 ++-
>  drivers/net/ethernet/intel/ixd/Kconfig        |   15 +
>  drivers/net/ethernet/intel/ixd/Makefile       |   13 +
>  drivers/net/ethernet/intel/ixd/ixd.h          |   58 +
>  drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |  149 ++
>  drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |   33 +
>  drivers/net/ethernet/intel/ixd/ixd_dev.c      |   89 +
>  drivers/net/ethernet/intel/ixd/ixd_devlink.c  |   97 +
>  drivers/net/ethernet/intel/ixd/ixd_devlink.h  |   44 +
>  drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |   68 +
>  drivers/net/ethernet/intel/ixd/ixd_lib.c      |  166 ++
>  drivers/net/ethernet/intel/ixd/ixd_main.c     |  147 ++
>  drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  178 ++
>  drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |   12 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    2 +-
>  .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |    2 +-
>  drivers/net/ethernet/intel/libeth/rx.c        |   12 +-
>  drivers/net/ethernet/intel/libie/Kconfig      |   14 +
>  drivers/net/ethernet/intel/libie/Makefile     |    8 +
>  drivers/net/ethernet/intel/libie/adminq.c     |    2 +-
>  drivers/net/ethernet/intel/libie/controlq.c   | 1213 +++++++++++
>  drivers/net/ethernet/intel/libie/fwlog.c      |    2 +-
>  drivers/net/ethernet/intel/libie/pci.c        |  208 ++
>  drivers/net/ethernet/intel/libie/rx.c         |    2 +-
>  include/linux/{net => }/intel/i40e_client.h   |    0
>  include/linux/{net => }/intel/iidc_rdma.h     |    0
>  include/linux/{net => }/intel/iidc_rdma_ice.h |    0
>  .../linux/{net => }/intel/iidc_rdma_idpf.h    |    0
>  include/linux/{net => }/intel/libie/adminq.h  |    0
>  include/linux/intel/libie/controlq.h          |  426 ++++
>  include/linux/{net => }/intel/libie/fwlog.h   |    2 +-
>  include/linux/intel/libie/pci.h               |   56 +
>  include/linux/{net => }/intel/libie/pctype.h  |    0
>  include/linux/{net => }/intel/libie/rx.h      |    0
>  include/linux/{avf => intel}/virtchnl.h       |    0
>  .../idpf => include/linux/intel}/virtchnl2.h  |    0
>  .../linux/intel}/virtchnl2_lan_desc.h         |    0
>  include/net/libeth/rx.h                       |    4 +-
>  97 files changed, 4236 insertions(+), 2883 deletions(-)
>  create mode 100644 Documentation/networking/device_drivers/ethernet/intel/ixd.rst
>  create mode 100644 Documentation/networking/devlink/ixd.rst
>  delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
>  delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
>  delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
>  delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
>  delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/Kconfig
>  create mode 100644 drivers/net/ethernet/intel/ixd/Makefile
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_dev.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lib.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_main.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
>  create mode 100644 drivers/net/ethernet/intel/libie/controlq.c
>  create mode 100644 drivers/net/ethernet/intel/libie/pci.c
>  rename include/linux/{net => }/intel/i40e_client.h (100%)
>  rename include/linux/{net => }/intel/iidc_rdma.h (100%)
>  rename include/linux/{net => }/intel/iidc_rdma_ice.h (100%)
>  rename include/linux/{net => }/intel/iidc_rdma_idpf.h (100%)
>  rename include/linux/{net => }/intel/libie/adminq.h (100%)
>  create mode 100644 include/linux/intel/libie/controlq.h
>  rename include/linux/{net => }/intel/libie/fwlog.h (98%)
>  create mode 100644 include/linux/intel/libie/pci.h
>  rename include/linux/{net => }/intel/libie/pctype.h (100%)
>  rename include/linux/{net => }/intel/libie/rx.h (100%)
>  rename include/linux/{avf => intel}/virtchnl.h (100%)
>  rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2.h (100%)
>  rename {drivers/net/ethernet/intel/idpf => include/linux/intel}/virtchnl2_lan_desc.h (100%)
> 
> -- 
> 2.47.1
> 

