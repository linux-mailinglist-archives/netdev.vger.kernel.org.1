Return-Path: <netdev+bounces-307259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rmoLCXEnVWphkgAAu9opvQ
	(envelope-from <netdev+bounces-307259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:59:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6917874E3A8
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:59:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=j9DRgyGx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307259-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307259-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D9F30E8C41
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E3534CFC3;
	Mon, 13 Jul 2026 17:55:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223652F360A;
	Mon, 13 Jul 2026 17:55:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965320; cv=fail; b=c4ifUcdxXPBYStVZJ2CxEhqG4Dq6BnRdKZCsq1Dh2Yr2p5wvnidG1rCU46NQWxsV1YswY6eJqTjVBgZVhJLvumgUz9sBU8bX7SMEl+w9J3alUUyRoXDVXzfU9DMN6VlzjD4T0jOWz1KgtlazjmjCrabBbn65PF9W0HvkvqDLurM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965320; c=relaxed/simple;
	bh=VnIvc8Go4WRMS4Te5iN1Q0lfZt8s/at/VUarLpQXJVY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GOpRJbXlORSZz3+yWEJzHHD20/jeJ/S8MwuNWY0/hDFB1kMqQ2e8Xmh+PSAFh4cZ02kh8DubC2dm2Hq7J3uJ8DYKyM4zVQkzFafDwTDJNo1xHu1V/3UfqggIK1S1dXsPlLzvgBV/YzhqtfoR/eOdyaCZ6PwoXmp1zJgLEVjfMdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9DRgyGx; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783965319; x=1815501319;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VnIvc8Go4WRMS4Te5iN1Q0lfZt8s/at/VUarLpQXJVY=;
  b=j9DRgyGxXLnfykoAo3hWcGJok2mbQj2teK1edlzU91z6Q94wGktIXT7Y
   h8hNeJGdmLmk1cF4dYHWUf//y10k5+mfaGr+sJjqw5eRk610VpYd0+bCg
   ouODjgZeJyloabBsltaFZ7kvZ1ELcifShcGuAFSyJQQ68T4/o2HAMlpAM
   m4rO85BFpKWw0W1bBdbGFoXOqsbj3l0GCwNPOqnCSJdK1urt4bQ3R018L
   06XMnsqtVrZHh7HizPI6PlEqV67JdUcrLiHshxseMMIRuxkRFnoAFKM1H
   qXTpJjCsQd+U4MTHFwYJ8PncGCDpBE+Z/I1JD7FPdalSaJxSZZSZDoyJI
   A==;
X-CSE-ConnectionGUID: 1SeISVaVRICmroFg9UZb3g==
X-CSE-MsgGUID: x+SG6j+EQIWwRDPsYTUoJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95224795"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95224795"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:55:18 -0700
X-CSE-ConnectionGUID: 57JD7bm7QiqvptGbWiJHBg==
X-CSE-MsgGUID: 0IC9nJLrQnW0Z1UtirwaTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259463617"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:55:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 10:55:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 10:55:17 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 10:55:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Us6XqKlH5+Ky8PzpJON4IIgwD72L6RkKMePF5KFeDkfMju+lbOhgkIuUnCe4POgi8gjGIuZCmWs7I/yLibUCXY2lIBU1fOaoEyfOP2XJZZgDDkNr5W00FB53r+YlSabO7iU78WHQpE5oG0yMmA+1VNCymWo2XjABBsF2X1TeSCXu1d9wLvHa5Ne2poAkmUw3M2CZAVLJ07/DFzASLWAzDnnvcbm/CZ3RVKcqOAoMXQJqU8lGWF7BnPzeugFFIzVF/FzuBc2/GuV9+oAjhDUEIIJF2lA87YDinIH6W0wqiH95iIOtbqKMddiDrxcwafIIwRsxDDUwky12HBvA1vXjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWzMAkOwrBLeb9h2l/7cxvaqNPf72dkDs+j/z9Svmp8=;
 b=lrZ32t8UrIqXt3CCbdq4a12zp2sq2KargXjtmOzM2i54Swegkec8fBaGLJ8QUWg0JcvQD+MOcinMBnkTHAImFd5xZ86yLaBWYo+fUf+R94436bG6xMKj2VTPn6e3tpelfnqc8b4IlxMjzcGYwqvEsQlUYI14koWSmk9jLm1nOHWR4Vw/uCwKNb+MSgQczSlNpyc/pFtkNohkoF3Btw5mW1QlQtJuWEqC0PtVSAWy6uE/andKvOxdOR8jUYfO2f3Vqby3PpRaPCnVArLYogoZeN7xZOOzh10KUB4FPfkogefq7Evsx4fDx4PRljha8clSrx9GfWbC0E5bQ7xwSHskFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by DM6PR11MB4756.namprd11.prod.outlook.com (2603:10b6:5:2a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 17:55:14 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%7]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:55:14 +0000
Date: Mon, 13 Jul 2026 19:55:05 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Pavan Kumar Linga <madhu.chittim@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next v4 09/15] idpf: refactor idpf to use libie
 control queues
Message-ID: <alUmeXWCjtN_MQ4B@soc-5CG4396X81.clients.intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
 <20260710215313.1475803-10-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710215313.1475803-10-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1P194CA0058.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::47) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|DM6PR11MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: ad53f6c7-8557-4090-699f-08dee107e41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|10070799003|376014|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MzEeOf/zqiRnxStvXQiWUUZLlin9+kVWp8NbxZ7hqK0pPgwUTtPXt0KN5pzU81ELAmASZTqh+46ZJMssCfNclMIUwML1zsClWKzSaBHznSykBRP6tD4WsXNb6Nl+AQJYC/sVqMwDT0Y5WWqWE3wIqEe3Ax5h1vd6G4wrR/njRsd3g4OShjKl9jdgDnVIFHwciaQg/XD753G+u6ggRH8o3oQhnjsUa2P9U1FNPA7LQCE0/A32sdJM4LeaUcygDn0WfgIlKuyf8LVXZX5YtM+JahiNEqPzDL7rayMdF5GR5FVMdDrNJlBvSlDPROwOjQdjF9WEYBLxeOKhSlExx7UGEVuKmpT0NOmXTqcACOSprZqv+YJTv8y2w3Y+UKWQoDF/jXMyCmHcz0unwwmDrMNLNfolr/hfPCu1chxujgQhxNlP0j/sbx9kYhpGZYAzdfKi2bFNyzaIYzq4JLhJWw1RffkgJJ6h7ZbqIaWRyh5bqvPgCAb5EAlJzpY+rKTWMocGbP7LeqUTVIuLX8B2Wt0dQupe4jm4JbfKAlMN7aWnZrLrsgPUTGeGp/v1Hp2ocaemI+h5ZrtKOKhycV9QLA1v61DHYvp9bgcNVhQnFqjf7cfDM6dzsMHEZwYqivxhkYPGbLEbIfIuVPFdGXbVqmymGEXtnBZShnZmU8va7tenq2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(10070799003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6+Uokqpg3CdfonKQGrCChLGmIY/9N4pB/9lSBNCU4TIWjM9c6lRtdVDrzI+V?=
 =?us-ascii?Q?e8vQGaInCwtagdx2B9apmcbNJSYFL9SOQNSYf/OA8QKxlV/0aLM5/X2cGb6u?=
 =?us-ascii?Q?Zv3rJye1ujo1taqk3Lm9WIw9s11gEuB5xyJnyZSDdUm898zcpeTekh+xcbjz?=
 =?us-ascii?Q?doxMSQsSVNN+cTUHeHzrWMRhxI7DYphemVLkMYqvnTq6Or+iQVbjDHdV4WU+?=
 =?us-ascii?Q?XSlp3Dt5hWXSwmsJg7WO0p1MTPLAFxHilN1QcD3DrSQIA6C1vj8hPfwR231c?=
 =?us-ascii?Q?PRctkFvLJv5hiK6OxHJ1rU1g5BuaJyr1duD8NjgZZw4BNLbUZGAyT1NZoX9D?=
 =?us-ascii?Q?CPlIeaMB/0LR3TuXIg0yTJ1GMHU8CdHVaCN6f+V+TKfuPGcd24I55LtTCvJD?=
 =?us-ascii?Q?YlOc+1W122hfWLiSITdyCng4xq/ZX3E4VWOsM4aftIW9M1RaOOz8QdLtQ/BP?=
 =?us-ascii?Q?0YKMzP4mzsB8rX/KZV5eqBZ5B+zeVwiy3/qbB4bg1jSdhZcFpw5IpMijAlnR?=
 =?us-ascii?Q?MqXLTifdmCikkPia8Y0i5EVsuqcYhCgEwqD6DbZDN2TzIFGoG1DItb0oxF5e?=
 =?us-ascii?Q?RAOtv5j+fsXwmsXvX88qP6k1Sk49sEj8Vdd4eJ6YNfb3f6BRK1YsoF1zq3wR?=
 =?us-ascii?Q?Nrmo+EzZGi6pX/TFFIdsz6Hm5K4QuvMDgEfouX76Yv6t/AawAOKJVfnd+fKB?=
 =?us-ascii?Q?ZAqQDX+whwi86ZNLkWIzaLtzPsSu4bpyhflhd3xfW8hrCwrECmjdl89YxoIx?=
 =?us-ascii?Q?ic+TTxuYi7EINYycUgFpPEiXgKPJRU5kgYbOloYF8IJl6jltWy2S86FnMh4/?=
 =?us-ascii?Q?nbSPCzNhqT2DwdgxGVDL7VZSWIKQnzvQpKMxFEzHIeUzEgequgNMd7lGzp/7?=
 =?us-ascii?Q?s3u8ucCfTYDCH4JAXIUuRy5NjIDmrwCDJA+uomeAOYAF/5KxQc/GI8dfVCSJ?=
 =?us-ascii?Q?otpzmotypxFJL1ycrDV57ZQiNC/Nbzf8mVP4c3PYhhZm8ppYMc9d1uvP9xGd?=
 =?us-ascii?Q?dwaBCQ0dq8ESfW+JSgvtHXtXShJbsX+EsWTKIPWrBXCkhzpEXuGsKJp2KRrp?=
 =?us-ascii?Q?neUzZKiuqVRIU0Pl6ug29vkSYeGcTsJpAJ63gtff82fi/ovfPFnHkH//LTTE?=
 =?us-ascii?Q?fX3nvJrPujzkFcpth1Yw2xqCt7+8snBTjj8QFVkdhvZQgQ8URzooDrKTZCJn?=
 =?us-ascii?Q?PRLLjVKW5FR301q45v4eai970YySGeesMNc5xHmycUbATGIodTsHLfr0Z//2?=
 =?us-ascii?Q?EJoJBGJb/DGniDdT5Sru9FJLQuLhlSuJJJg7GDadj3MgdvjaH2YaddZbLmsh?=
 =?us-ascii?Q?ro0zspxkakpWwYlZJtehRQyfkaa8Y284LKPx+tZe2Y2pa0tV7GyQksknDYZO?=
 =?us-ascii?Q?5zgIfPAD2Jxg74q8wQHQS0vCfGhOdFI0HWXhUTB37KEv7ANutK6LEm5dYN5P?=
 =?us-ascii?Q?dPDuCf8k4wf76VzKUR6/iXI93ZAhMbMewKpOFH2RSCE6DblW43riryenrscx?=
 =?us-ascii?Q?Xjle+POa8x9HgvgQT8aucaAX0laAKCS28X6aoPq1jxGmT/g05myZ3lO5Yyf/?=
 =?us-ascii?Q?S/JWUU1BnU/XZcghsVJrUzpx+bszE+ds0yC4p1FUmOFo++z9Q3dhJ/YVSdCF?=
 =?us-ascii?Q?DZ8AmEyw6m1BJ1G4f7dU2GxBM6CSnjZL/d9tkgAe4Q6UctJSgRMmU98OccCg?=
 =?us-ascii?Q?MVnJ4No+e7ohoPk+7Wx2mJ98+GgVGZZ+mdIJY2wkPHVk5+T20q55/sr16mxu?=
 =?us-ascii?Q?4ZsBbt7LINbGTxy5am8N2S2GpJ1aWsFrlzgPKiqP8oawKx1ptyX4tLKFPhRA?=
X-MS-Exchange-AntiSpam-MessageData-1: 8g2c96jr9HFvXx2DL5jwr4uBVS9VOwEfa74=
X-Exchange-RoutingPolicyChecked: Ih02UfscaBCipr+t2yJd6XsbkfiCP6h31ZP8Sv9yO5KNkPg4qBwrJaWVoWzCruwUf/DWk0aXC3rvrCbha9QyhNelAWXSTWDD1B4g5wasu2G526kznjX1Amw3onN7xnqmXAepNughSQWXQquUazPvYQ9T78LMNE/4TOL0kJGzyXiEiUdnFwhJppMs+MD9skkI4UdsXfvXRBEeHPuAO+sSuKr5IS/EeXYgiPQAjyOFoAZEY+LiwtOylTeZLb6dQkl2WTB0W/bFZTmudxSMz2O5UWthP2KThVXGtucMXeDdMljmtBOYLXKeNXLRa6jFvUbFqIYSvmkVKhJmNRcArywjjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad53f6c7-8557-4090-699f-08dee107e41f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:55:14.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dro/wdBUwQafO0i/MRpXB4SaIAtXme6G3PDWpIZkFOlc+1oVlL+aZ3tBXPx96gndxrPXZX4f6h2H4tR0w5taX0eOmozB2vw+cygP9yfuFok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4756
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307259-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:madhu.chittim@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:aleksandr.loktionov@intel.com,m:Samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6917874E3A8

Here are some minor changes that came out of Sashiko's review.
The first one is not needed, but does make code more consistent and robust.
The second one is updating kdoc, where Sashiko was concerned about a functional 
change. I have checked that the functional change itself does not affect 
any callers.

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 04a0421c1b77..d768b63700c8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2931,6 +2931,8 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
        adapter->arq = libie_find_ctlq(ctx, LIBIE_CTLQ_TYPE_RX,
                                       LIBIE_CTLQ_MBX_ID);
        if (!adapter->asq || !adapter->arq) {
+               adapter->asq = NULL;
+               adapter->arq = NULL;
                libie_ctlq_xn_deinit(params.xnm, ctx);
                return -ENOENT;
        }
@@ -3993,7 +3995,7 @@ int idpf_set_promiscuous(struct idpf_adapter *adapter,
  * @send_msg: message to send
  * @msg_size: size of message to send
  * @recv_msg: message to populate on reception of response
- * @recv_len: length of message copied into recv_msg or 0 on error
+ * @recv_len: length of message copied into recv_msg
  *
  * Return: 0 on success or error code on failure.
  */

Everything else:

> commit 9ebd6c429379be8477841f5180023c78d16732d0
> Author: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>     idpf: refactor idpf to use libie control queues
> This refactors idpf to use the libie control-queue API, removing the
> in-tree idpf_controlq.[ch] and idpf_controlq_setup.c and reworking every
> virtchnl send/receive path to use libie_ctlq_xn_send_params /
> libie_ctlq_release_rx_buf(). A few observations below.
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > index 357ff3e86b2e..388075a07af7 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> [ ... ]
> > @@ -4128,9 +3731,9 @@ static void idpf_set_mac_type(const u8 *default_mac_addr,
> >  
> >  /**
> >   * idpf_mac_filter_async_handler - Async callback for mac filters
> [ ... ]
> > - */
> > -static int idpf_mac_filter_async_handler(struct idpf_adapter *adapter,
> > -					 struct idpf_vc_xn *xn,
> > -					 const struct idpf_ctlq_msg *ctlq_msg)
> > +static void idpf_mac_filter_async_handler(void *ctx,
> > +					  struct kvec *buff,
> > +					  int status)
> >  {
> >  	struct virtchnl2_mac_addr_list *ma_list;
> >  	struct idpf_vport_config *vport_config;
> >  	struct virtchnl2_mac_addr *mac_addr;
> > +	struct idpf_adapter *adapter = ctx;
> >  	struct idpf_mac_filter *f, *tmp;
> >  	struct list_head *ma_list_head;
> >  	struct idpf_vport *vport;
> > @@ -4152,18 +3756,18 @@ static int idpf_mac_filter_async_handler(struct idpf_adapter *adapter,
> >  	int i;
> >  
> >  	/* if success we're done, we're only here if something bad happened */
> > -	if (!ctlq_msg->cookie.mbx.chnl_retval)
> > -		return 0;
> > +	if (!status || status == -ETIMEDOUT)
> > +		return;
> Should -ETIMEDOUT really be treated the same as success here?
> In the old code the async handler only ran when a reply was received,
> so a timeout could not reach this callback. With libie the async path
> now delivers -ETIMEDOUT via libie_xn_check_async_timeout(), and this
> new short-circuit returns immediately without reconciling the driver's
> mac_filter_list with what the CP actually applied.
> Note that idpf_add_del_mac_filters() clears f->add / f->remove for each
> entry before sending:
> 	if (add && f->add) {
> 		ether_addr_copy(mac_addr[i].addr, f->macaddr);
> 		idpf_set_mac_type(default_mac_addr, &mac_addr[i]);
> 		i++;
> 		f->add = false;
> So on -ETIMEDOUT those entries look "applied" to the driver while the
> CP never acknowledged them. Would it be safer to only skip work when
> status == 0 and fall through to the list_del reconciliation on
> -ETIMEDOUT the same way as for any other error?
> 
On -ETIMEDOUT we do not have any buffer to handle.
In this case it could be either added or not, we do not know.
Both options lead us into a suboptimal situation, but treating it
as a success is simpler. Also, 2 minute timeout probably means you
should reload something anyway.

[...]

> >  int idpf_send_dealloc_vectors_msg(struct idpf_adapter *adapter)
> >  {
> >  	struct virtchnl2_alloc_vectors *ac = adapter->req_vec_chunks;
> > -	struct virtchnl2_vector_chunks *vcs = &ac->vchunks;
> > -	struct idpf_vc_xn_params xn_params = {};
> > -	ssize_t reply_sz;
> > -	int buf_size;
> > +	struct libie_ctlq_xn_send_params xn_params = {
> > +		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
> > +		.chnl_opcode	= VIRTCHNL2_OP_DEALLOC_VECTORS,
> > +	};
> > +	struct virtchnl2_vector_chunks *vcs;
> > +	int buf_size, err;
> >  
> > -	buf_size = struct_size(vcs, vchunks, le16_to_cpu(vcs->num_vchunks));
> > +	buf_size = struct_size(&ac->vchunks, vchunks,
> > +			       le16_to_cpu(ac->vchunks.num_vchunks));
> > +	vcs = kmemdup(&ac->vchunks, buf_size, GFP_KERNEL);
> > +	if (!vcs)
> > +		return -ENOMEM;
> >  
> > -	xn_params.vc_op = VIRTCHNL2_OP_DEALLOC_VECTORS;
> > -	xn_params.send_buf.iov_base = vcs;
> > -	xn_params.send_buf.iov_len = buf_size;
> > -	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
> > -	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
> > -	if (reply_sz < 0)
> > -		return reply_sz;
> > +	err = idpf_send_mb_msg_kfree(adapter, &xn_params, vcs, buf_size);
> > +	if (err)
> > +		return err;
> >  
> >  	kfree(adapter->req_vec_chunks);
> >  	adapter->req_vec_chunks = NULL;
> Does this code leak adapter->req_vec_chunks on the error path?
> On success the kfree()/NULL of adapter->req_vec_chunks runs after
> idpf_send_mb_msg_kfree(). On error the function returns err early
> while adapter->req_vec_chunks is still allocated.
> Its caller is idpf_intr_rel():
> 	void idpf_intr_rel(struct idpf_adapter *adapter)
> 	{
> 		...
> 		idpf_send_dealloc_vectors_msg(adapter);
> 		idpf_deinit_vector_stack(adapter);
> 		kfree(adapter->msix_entries);
> 		adapter->msix_entries = NULL;
> 		kfree(adapter->rdma_msix_entries);
> 		adapter->rdma_msix_entries = NULL;
> 	}
> which does not free req_vec_chunks either. Is there another site
> that frees adapter->req_vec_chunks when the dealloc virtchnl fails
> (for example on a mailbox timeout during teardown), or does it
> accumulate across reset/unload attempts?
> 
Seems so, but this is a preexistent issue

[...]

> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> > index 8d8fb498e092..1d8dd67e299d 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> [ ... ]
> > @@ -234,23 +244,18 @@ int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, u64 time)
> >  	struct virtchnl2_ptp_set_dev_clk_time set_dev_clk_time_msg = {
> >  		.dev_time_ns = cpu_to_le64(time),
> >  	};
> > -	struct idpf_vc_xn_params xn_params = {
> > -		.vc_op = VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME,
> > -		.send_buf.iov_base = &set_dev_clk_time_msg,
> > -		.send_buf.iov_len = sizeof(set_dev_clk_time_msg),
> > -		.recv_buf.iov_base = &set_dev_clk_time_msg,
> > -		.recv_buf.iov_len = sizeof(set_dev_clk_time_msg),
> > +	struct libie_ctlq_xn_send_params xn_params = {
> > +		.chnl_opcode = VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME,
> >  		.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
> >  	};
> > -	int reply_sz;
> > +	int err;
> >  
> > -	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
> > -	if (reply_sz < 0)
> > -		return reply_sz;
> > -	if (reply_sz != sizeof(set_dev_clk_time_msg))
> > -		return -EIO;
> > +	err = idpf_send_mb_msg(adapter, &xn_params, &set_dev_clk_time_msg,
> > +			       sizeof(set_dev_clk_time_msg));
> > +	if (!err)
> > +		libie_ctlq_release_rx_buf(&xn_params.recv_mem);
> >  
> > -	return 0;
> > +	return err;
> >  }
> Is dropping the reply-size check here intentional?
> The pre-patch code explicitly rejected a malformed reply:
> 	if (reply_sz != sizeof(set_dev_clk_time_msg))
> 		return -EIO;
> The refactored helper only surfaces the return code of
> idpf_send_mb_msg() and unconditionally releases the Rx buffer, so a
> short/truncated payload from the CP is silently accepted as success.
> The same reply-size check has also been dropped in
> idpf_ptp_adj_dev_clk_time() and idpf_ptp_adj_dev_clk_fine():
> > @@ -267,23 +272,18 @@ int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, s64 delta)
> >  	struct virtchnl2_ptp_adj_dev_clk_time adj_dev_clk_time_msg = {
> >  		.delta = cpu_to_le64(delta),
> >  	};
> [ ... ]
> > -	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
> > -	if (reply_sz < 0)
> > -		return reply_sz;
> > -	if (reply_sz != sizeof(adj_dev_clk_time_msg))
> > -		return -EIO;
> > +	err = idpf_send_mb_msg(adapter, &xn_params, &adj_dev_clk_time_msg,
> > +			       sizeof(adj_dev_clk_time_msg));
> > +	if (!err)
> > +		libie_ctlq_release_rx_buf(&xn_params.recv_mem);
> > @@ -301,23 +301,18 @@ int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, u64 incval)
> >  	struct virtchnl2_ptp_adj_dev_clk_fine adj_dev_clk_fine_msg = {
> >  		.incval = cpu_to_le64(incval),
> >  	};
> [ ... ]
> > -	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
> > -	if (reply_sz < 0)
> > -		return reply_sz;
> > -	if (reply_sz != sizeof(adj_dev_clk_fine_msg))
> > -		return -EIO;
> > +	err = idpf_send_mb_msg(adapter, &xn_params, &adj_dev_clk_fine_msg,
> > +			       sizeof(adj_dev_clk_fine_msg));
> > +	if (!err)
> > +		libie_ctlq_release_rx_buf(&xn_params.recv_mem);
> Should these three helpers keep validating that
> xn_params.recv_mem.iov_len matches the expected reply size, the way
> idpf_ptp_get_caps() and idpf_ptp_get_dev_clk_time() still do?

No need to validate size, if we do not use the buffer.

