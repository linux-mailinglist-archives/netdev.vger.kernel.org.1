Return-Path: <netdev+bounces-307228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ymSKEL+VGpAigAAu9opvQ
	(envelope-from <netdev+bounces-307228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:03:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0321F74CBFB
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:03:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Spsu0Yhi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307228-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307228-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1365331CCC59
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780EE43B6CE;
	Mon, 13 Jul 2026 14:56:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F52E7BB6;
	Mon, 13 Jul 2026 14:56:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954565; cv=fail; b=XqXkghZ8Pd4vskbBCxrAb2Keg5LzODc6UDfH1nDzJesY42Huu2EZIzWpzVfdP0S2NkPWtU/vyp3OLoxk8z3nCmzTOULzsrouuhA1UGJUkt2lhOaKQET/U674LbB0adehQnNMtJ8nCcJfUyMSI5a37PTINu3UYf8oaad96jgMHzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954565; c=relaxed/simple;
	bh=zxbCMH4p/OwgJJOvFa5lbBigFQ/I7Ge6riqVnI8kGdE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lymtnu4TeYRfmWSGDmKatlngnyzD7sfIgDh3oDGCRMiJi38Q4drf33pzkprZQfdsRE/KIB9SgsbyLCw0Fa2OXuFoiUUJCzr1E9+bdPZnMufrCwYO65tvAJFB5cWiM8r4zeJxip098ApGadHWfS3pbNy8JCBBoCEr3bwolFaAmyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Spsu0Yhi; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783954564; x=1815490564;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zxbCMH4p/OwgJJOvFa5lbBigFQ/I7Ge6riqVnI8kGdE=;
  b=Spsu0Yhid/VtDMEWKwtpM8g49JQHLOsXwPxqa0nYBUPHFE7x3LGwlFDR
   SJ56c2xnr8jS2dfYhZmhVSoy8qtgbzdpuvX5wwfDXUteawuRrYy/RZB6U
   hxmPZO6vdXmLoa//N2yLc4ewoOAiRKte7dDiMXTL1bBMi7bt/JjlEHZrZ
   YEAIqNX2lNknhFTsS3Rqs3hIBMkWw0349j/y51Qxo233YAdrdasdcnAiv
   bmCh3sfrJ+cRc4YX6EpBzn6Xfze9e2VCsDFeGwq419rLjTsjNIiiR361f
   uySe/CiK1JZDz2uPOoGN/86xIIpBI87X5rTr2QI1Qcio0pFjlrDsMri8L
   Q==;
X-CSE-ConnectionGUID: ICjq6DrLRpCw5bbmMB7IKQ==
X-CSE-MsgGUID: F1JdZk6ESOCG+ZlYqO4ZjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="72088726"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="72088726"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 07:56:03 -0700
X-CSE-ConnectionGUID: 4CueoTcpR5uBn9yJRQywDw==
X-CSE-MsgGUID: E9lY7KY9SLqCxL7lPH7PmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="285655621"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 07:56:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 07:56:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 07:56:02 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 07:56:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7P990L6y+pU5q03bC9Vgt7NqEjdqBy60PtoJDR5QOhMRt9G+3zAl1ykJnaUYfbfzYn+lN5c/HE7FqBAuTHvxl5kMy79EwpUX1+3hexirx1UCEcbq6TrkfEuBfojAYA6icfyx8tO3r4M+CcRNhyA7VUj8mJnmT83p8KZ2X3Opy3i9VR5DMxr/Q9C0xwJtCTJ29jM7g3Yeu6HaWNbKPf391DIBNGGomwcxGgyH7ZzxsF6wJE4JJtLsdpVrSgQ7WL9P8m6WwJVJpWDeB1Zs2ZM3BZE/c4J7efsm31D/XOi9N5m+fyusuFChFxbzOhyRgLdlr1SLZLuPcpr6Yzr87VdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMQEnP/ltpyx2QTR7i1Lh23v+ecPYknTnP2EIRfMczs=;
 b=RsENBQ+bhZZ8TzmXH6VvwVppaJo4TpkCWC0Kq7QrAYXL0UIWcSjcXVAnxq0cWC1dbZ6OM6kLnnuCaQwIExU2E7cXDNv0AZrw5VgKL1Dpmk1ogyJ/X+yUkzp4kVF2YWbbL6UZVVi97H1/gWVSse5fV1gG6ezATHOvSVECKpZSnjSOqW+eGPM0KzH1jwTYJdPRXeV+BEooPjQg1F1ptbghp0RpT5A0Nl9+kbaiIit1jaxd+Y+sFSCiCqfWKL2NjhD8CuAj+K80cMap3UrxCdSj0hOpdYhWALVLaGTqmHAPmsOzK4UgoNuIaE6i19WMIukWnQvVCqNR8kyMn7emKT5CmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 14:55:58 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%7]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 14:55:57 +0000
Date: Mon, 13 Jul 2026 16:55:49 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
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
	<bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next v4 02/15] libie: add PCI device initialization
 helpers to libie
Message-ID: <alT8dYPTxD3rhqht@soc-5CG4396X81.clients.intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
 <20260710215313.1475803-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710215313.1475803-3-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: WA0P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::21) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|MN0PR11MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: ab517849-49d5-451f-2eea-08dee0eed8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|3023799007|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: nAw92odaNURBp+6rL5oQ/f3O3HwIBbIKis9aWKmKyoDMtler1zRMfRuiTASbw/0zXrc3BRrRpuyUXuRJnXSRGrkz4OBO5xMwwExhoEZnj9MxM3os0D0Rap17B8pk8XwCP6OzETIcQwYI5hQA0A1AKXbI5F9Wu7KRpK0VWsrG36lbX6EWbUX2WqnsCUVzcGgns2dfPZ7UXJqbELT82Uray5Y1TfDsZbyRPc3maADaR5vfXM1Zn7/ZzmDs2HZX4HMHyf2wCsuHruqr4XgsQltS+btI/c6ZE4MHxE60dBVSrjFC8G+vdn8bvQ9Xp05adjBRCgrXg/LmjKGVHmK7tohVbbxNhC0PDsR2EMCuabbuUXQOZ+48ePqyTQhOMJaj9oDHBTTktLagd3AW/HDZbUhG9e2PQM3NIWcuX06vHwUdlfLcJFz0ylKY0nXDtzbO7UHvSinpOb2T8bE38MEwGGLw5x/cWyC2plWVSXKxZirrKezSZUPupJJ5pnpdMiZZ2T3koezksjDs2MTB16rqVkcbTiUqmbGE/vG3omtvguIMdKke6Xypqo4BcrL/0hIvwLbPPbR9jliHKrycd2Ex2Yh+zjGXOTEaO4T0V6kcUK1Ax+G0qQDYL67mOyTuvXk5EjNz3kJOJIMIGNIVVCjUPqTZ0jhKkcNkINjLlLICt/4y6Iw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nhpGnr1e+kvCYv/t7BlGPJhItaWSuL7QHrFrWfrHTQpyNQICR57s8cNLqKLy?=
 =?us-ascii?Q?3r1+gDRz0JQargJROMgYpwgWDh2eZmLq2cf8WISSYs29CL9Vnv99TurHU1o8?=
 =?us-ascii?Q?XlQIyb06HIdCepr8mv4tVrlQJLLX4WUwxL47SB4aaL6wVnvM2KL7M/xGF4Qh?=
 =?us-ascii?Q?2OZ/Ic9V4D9PrSfaA8gau2DzyK2LQcZG5fC8AnsqZWGQ28yr2ddVnx0tHIB9?=
 =?us-ascii?Q?kWh8ueP+zQprYh25R3bJXfO3bhUnBMmIDEmvLPJFUF+VRbo4HI3dfJGHTdX5?=
 =?us-ascii?Q?dNZV+RdE05+vgozxf8na5uuKNNsrsCiBIMCmYDPAhcnR6xOIEA2X0BZZDcQU?=
 =?us-ascii?Q?7rAJyTQkZotPGl/gKfSv5OdOBw3Ohlc2bPPLTpWkbD3WezqQ0BluBfKlJEk+?=
 =?us-ascii?Q?BStr+0NZvzchgOyBS98q/vSIXqDE+UGVNjZhZGLYbdU4RDXxP/rjmOYeAK+4?=
 =?us-ascii?Q?oXwgjIUGkilsFdw172V5eaW2Uczs+tSrSSVcFzSlhFe3RfhZ77C53FJ3uZDr?=
 =?us-ascii?Q?YYpH/znfB7Gt9py+Ru19XNCDE1rQvolSEzzN7wjnSJFEwLpjfMi3WJWkLT6k?=
 =?us-ascii?Q?q0n60WhL0rUfSQtzFUfnVbJxejGZWDYAJ5xGK3iHBqcyMDtYVwg1PEDjwNVO?=
 =?us-ascii?Q?EqMMYR9wLfsb256qhfcFShgBeMPTIJbPMTwOeIjrDfYorGb7LVhkJpG5iP7B?=
 =?us-ascii?Q?uANoF0NeQUyGOHflNrUACKmW9d93UKR9egLK8e9v7sUrCsHuXv435JNqc0tR?=
 =?us-ascii?Q?TYfBf1500njRIEU7xWUOFL9XJ6Vr2FKgWQS1gQ+EaK18uPaBb+G/vNilDU+/?=
 =?us-ascii?Q?CbqV/7HLX6zapOODTWQNqK6AiyszK2rgm5uHWM8GDcINQskqeyPzqhijy8pT?=
 =?us-ascii?Q?ECt8xsJVEz0RhQY9kvEgh5VKHmXHuNXnm35ruVOow1a8jr34yhl2yuQiOsQT?=
 =?us-ascii?Q?Zc1Y4keZZ0gZiN0O2gL5d07gIniHqMp6f21FM9sbrMjBcmNWIY8tfREmIeFu?=
 =?us-ascii?Q?r/KcMhkIrQfffjUOG3Gb28AmS3GKXaSghSTiThLAjchLUAk4rgcFld1FVuXM?=
 =?us-ascii?Q?KiI1zvf+KdCjsJfbCPRjo4xS9chU6ZQvzSK8fXSgutS3pe4UcaKJM5Tc8ci4?=
 =?us-ascii?Q?R+PMHdOQzt2JHN6XAS6oqhi/2XiOtoCMazFjG2OlPQHd/W8vC1WQ+nCcH3KV?=
 =?us-ascii?Q?Uq7Fwb+sLXEqKMN6af2EQHmL2cqZZIWFY6YidikBzlJizm3cCBQDxTSUTboq?=
 =?us-ascii?Q?dQP56IQgAHCU7L1XHRRxEQxR3y59I6Jl2Ez1QtIQDv/8o3mVXznWwdNSP/r/?=
 =?us-ascii?Q?LXftvWcZ2X3WcYy9BXt4cp7pFPosn9yhBZ4YiMJLdG7W0WZ+noyVbqLLXFkp?=
 =?us-ascii?Q?tbCOzhq1ygeJrjsDab24YvUPXM2PwmRh2lqLXC6iiPbbPJ2z0QmW/HuSVmo3?=
 =?us-ascii?Q?piai30RGBn3WmgaETqAvythLKb6/ELrLYk/8hTarWl05K5xbpOSh1AqjRSlx?=
 =?us-ascii?Q?BSD2SyGhi8dFuvPXPXkVjHjRPeIhD3nXqNa+RrJyLXb6Ua+5hAVsDe3L0Dn+?=
 =?us-ascii?Q?gg5n6vCSVM3kvMTnF8ZKHgf2giyaSqtcNTnPM9/km+2NmomNkkPmyS9i8ZW+?=
 =?us-ascii?Q?fUgasKzvBw0DZ4G+iTF9tnMD4fRo4dDdotjf51tbJWT7AX6NAQtq6NTGdsd9?=
 =?us-ascii?Q?xf5ea2JN4XLxFo++DSJiqS3D9dVuPttk99m4N9owSLJ0RsQ0EmrkalzWkIDt?=
 =?us-ascii?Q?bu4aEXEjIKE3lusapjNmQLvusgQN8g2Vq3GrqGbjuJWrvhy+c2ljIK1jGQbq?=
X-MS-Exchange-AntiSpam-MessageData-1: c/0Nbwago79MnDaXPQTfkSB9jowuO2RGMV8=
X-Exchange-RoutingPolicyChecked: bf9M+GGgvn+TQc/G36UMPs9kSKfeA/BzdNfHXl8QGGhPIJJMr1UNfuf8mNCKXpTSTD/W0rpkl8RRLLKbuONo9o1eeGMH3FaR2vMeQnrRwI97Er3CaMKR8G63LBjkqA+TcYhQDHmy5xuh15BiNcVW2/qt8TgCMrfl4kVlZylk65QtKpdOM0MzL95wrBrAS3kAykEjtP7siI23hTPqKptS4iMBhKryErfFOjzF76dgEKWlyPDK9Mffxm6paBrgPTGcrW/LZnKg5pHK97YW5eENpzzOye69sh+duO3VG4sNZrZp7o178GLPzgCBH0C5eWwxh7IJAa1uf94va1afkyRTxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab517849-49d5-451f-2eea-08dee0eed8a5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 14:55:57.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+2EdFH3bij7MgkBv0+jKRlun83mbkVYXFMY0Xg796LRker3M3xqPwoQLvmRiNVv5yHqrNSSHogREdISoSajq5ip+6T16paXLm93rDdFNgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6206
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307228-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:phani.r.burra@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:anjali.singhai@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:bharath.r@intel.com,m:Samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0321F74CBFB

Sashiko has 1 concern about this patch, and I think it is not very relevant, as 
this is a 32-bit issue on a 200G+ HW, which AI also mentions. Seems like 
checking offsets under ifdefs would be unneccessarily defensive.

Sashiko says:
> commit 0540f7038f92c56e3d90344d11ab6f07b9f6b975
> Author: Phani R Burra <phani.r.burra@intel.com>
> libie: add PCI device initialization helpers to libie
> This patch introduces libie helpers for PCI init, MMIO mapping bookkeeping
> via a list of libie_pci_mmio_region entries, and a lookup helper to
> translate offsets to virtual addresses. The public map/get APIs accept
> resource_size_t offset and size arguments and are intended to be shared by
> idpf and ixd.
> > diff --git a/drivers/net/ethernet/intel/libie/pci.c b/drivers/net/ethernet/intel/libie/pci.c
> > new file mode 100644
> > index 000000000000..a0d3535d6529
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/libie/pci.c
> [ ... ]
> > +bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
> > +				 resource_size_t offset,
> > +				 resource_size_t size, int num_args, ...)
> > +{
> > +	struct pci_dev *pdev = mmio_info->pdev;
> > +	struct libie_pci_mmio_region *mr;
> > +	resource_size_t end_offset;
> > +	void __iomem *va;
> > +	int bar_idx = 0;
> > +	va_list args;
> > +
> > +	if (num_args) {
> > +		va_start(args, num_args);
> > +		bar_idx = va_arg(args, int);
> > +		va_end(args);
> > +	}
> > +
> > +	/* pci_iomap_range() would silently map less in such case */
> > +	if (!size || check_add_overflow(offset, size, &end_offset) ||
> > +	    end_offset > pci_resource_len(pdev, bar_idx))
> > +		return false;
> Can this API silently truncate the mapping on 32-bit PAE builds?
> The parameters offset and size are resource_size_t, and the bounds check
> above is performed in resource_size_t arithmetic against
> pci_resource_len(), which is fine.
> However, pci_iomap_range() is declared as:
>   void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
>                                 unsigned long offset,
>                                 unsigned long maxlen);
> On 32-bit configs with CONFIG_PHYS_ADDR_T_64BIT (for example PAE),
> resource_size_t is 64-bit while unsigned long is 32-bit.
> > +	va = pci_iomap_range(mmio_info->pdev, bar_idx, offset, size);
> If a caller passes an offset or size >= 4 GiB that legitimately fits
> within a 64-bit BAR, the libie-level bounds check passes but the values
> are silently truncated when handed to pci_iomap_range(), so the wrong
> sub-range gets mapped and the mr->offset / mr->size stored in the list
> no longer describe the memory actually returned by pci_iomap_range().
> Would it make sense to either reject offset/size that exceed ULONG_MAX
> here, or narrow the map API to unsigned long so the truncation is
> visible at the type level? In-tree idpf and ixd likely never hit this
> today, but the public signature invites the mismatch.
> > +	if (!va) {
> > +		pci_err(pdev, "Failed to map BAR%u region\n", bar_idx);
> > +		return false;
> > +	}
> [ ... ]

