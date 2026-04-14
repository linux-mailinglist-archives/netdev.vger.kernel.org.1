Return-Path: <netdev+bounces-278395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFZfEo8e3mk1ngkAu9opvQ
	(envelope-from <netdev+bounces-278395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:01:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3683F3F9104
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70AC030BC318
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311213B38BD;
	Tue, 14 Apr 2026 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/ogoymS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FBF3939D3
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164264; cv=fail; b=Ogc5nkWPTPgRxRjs3ZAFHzlePGrxl5vZqO4yOHXhYUwxYtAtNak8lQ/ej5W0PhkhdtH+vSwRhi3mhXggSZhCpV7W926M/dZWrNCTZoHVjzpMcx8aqE6x4BlOaSHe1LqINrd6YPWKvIgMzP/ed1i668TXcPrtN6lfL5LO467ywWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164264; c=relaxed/simple;
	bh=58hc6O6ObDosx69C8OD3E4Ax5CrJnOZZic3SpI9pvag=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NxcNFmG/1OQ4F0f8Z58QlbFHO+/Ln++Ubl3CmSKnJj40/C55bmrYDa0RDauqBME8sG86an4CW1FJ0tJqxIb1vD1pvTiB5EXc6tpwg1yPZxKFZHPJlUW5JhDh8mis4rBBPW0c1tEAQTM/kMQA/tB4Dtr7eFFEoKDHIAu+x7pLI4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/ogoymS; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776164261; x=1807700261;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=58hc6O6ObDosx69C8OD3E4Ax5CrJnOZZic3SpI9pvag=;
  b=e/ogoymSSyWnSFENshvV++EmxAW3oHFb8AxjvlAcNhwKkybVOYUovvBf
   gWJnlCE6ptfjNt1EUR4Qrt12KFAOPeQoj+pet+6lSiP8XS6ZZ1vlvP/Qf
   5yPFMZJv9WH6LVV3GQYs86MK0ddYf9cYDmZLTA2lXgHbmA7cgwdvW1XzV
   JN1oYYarPkDI/q8CfEnLOUgoT28xQ44dehKwz4aV43Bpd7pyrMelML47q
   LYGpsTXwXOJ32vVxY3xt42snbR7gdGsvbaWAf32g2mYeBHIhxCj8N7Sce
   6ZUBxpKkubtmxHKdx7RxMPAfaK1i1NLfNJglb2eUVR3rimTUKhqt7qfjh
   A==;
X-CSE-ConnectionGUID: WY0q1rfSRPGnJhdSlMCUUg==
X-CSE-MsgGUID: 24loS7XtTYGgU0dIuo4Dkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="99761215"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="99761215"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:57:41 -0700
X-CSE-ConnectionGUID: oWoJBydMRGKqBaHTPabrGw==
X-CSE-MsgGUID: /GBcj0kYTr++jXPk6Ba6gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253465784"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:57:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 03:57:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 03:57:40 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 03:57:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9tMpt5SH7qZPy3anm9nT6FlRlnLdKZGEpnNcgZmkDbUwj5Y3OafExALarcJnumiUGxUKQT3QoAlDBKWBzsVLmi+FkPGyS/M+i/nKFafStWLnKWJWAfR6+5V2TZ7AD/GDD/7BM/bzQYR14nnZh7uWjGbyyom6hc9FwKqeBmM5mTpU9crK84rCoWHAgAocKVahqA4KFyXOyKhDxylRCVVtf9cs4OiRGCIih0X2HH85Ewxvo0J+9zd8URFIs0OaRkJsqxEpY1oafy/IspyPxIv+v6UnQwsbdvltYJjpoYSnk8mWAJqOWQ/CUN7lGc3iJdiXKMspOavABst7JqyG76a4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YJNmUygMJSs4jc2SWBT4AaJOyAVLgOc8EBcyIUvfTE=;
 b=euVT+L9L7jyCoZeLgZaWwursL0j7Ne8tHQiuia9jRZnKhhrtHZhEz/ueVmI4nQTLUQr2l4k+xhwyU1uMOumJJvh/ejvW+9p+ugVq/tcmxl0YO7ycH4lwcFohODl29eWkS22XHE1UhDcoxVQzvu1c5KcLz7I0UpcF3WTYg/WOyMCy2K/W+pXq8DiwwlgnB6vp1AMyC0lfe6rvP3xL4yhvy9US7HnE1+YZWaX+YSFXZbt0kNQlTGga3G2u+xSM1bY888d+/bSRjU6SprsFBA/pWUuaFkHh49kvxyGKyi19ArW1mTHp5mjm6DmzuhqkYF6u3IkJ2kXuEibxGTqqf79GEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Tue, 14 Apr 2026 10:57:36 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9818.014; Tue, 14 Apr 2026
 10:57:36 +0000
Date: Tue, 14 Apr 2026 12:57:22 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH iwl-net v1] i40e: fix napi_enable/disable skipping
 ringless q_vectors
Message-ID: <ad4dkhE6/blFAH6l@boxer>
References: <20260324130922.562714-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260324130922.562714-1-aleksandr.loktionov@intel.com>
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: f92e3a5e-5100-4d54-e14f-08de9a14a340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yf/mCukzZoSw61QT2iEDZCxEpRISO/Eif+s+zGLLxxcSJpA5Hq6FljFYAOFgsDvfHKbXoNrWNfpiC7humOlghDu4b+7dQ6f2WriUsWlDAMSymQ+HMsioIzG+L8rZ30ipAtwkNORgo1X6DirjDGkC/XchF0fFHEiw1+KXpSdKj0gYnvs8XSiC5/K5TW4H77JZuK6DBlOGmUrsWxjTpL2Yjap6+YUmKNVuPDMWgX12dKKoMmRUqIlMRr9ZSldq7aD++4rgtJxSxmE63wYU/BeBTjicHa/6sjMF6O+cyQQX0tNf23orvdlLCRQM2aBaAOuHYRE29i7oMlJCblgd5bWMiO9OIWeNie6ONUWVnNKaimdorF+/LWWp1sIbnKmH6cU6k8Q23mhbDlBdkMDCKeZZWe/ZFuFzT69zIzEAXBiO0QFSdo+tks7tiERsr2JLQMpYb7H2sp4gIC3ne4dE95ggADjiPvKn+KgJUHYd4/n95lxflTAvguDMrlDnOUR8U3BStMIMkQ4ELaMCIpQtHZxzS+2WJNqwMkLPBITBfFgD22OIcG+rJXQk4NPlK+yRZdV1Q1QoTQmSHXmrKKnERYYp/RSIWNS7YZkwnBhGK1OgWEed3khVoZndNLNR3DR9nvFny68Wk5SRr8lI7vF5lSQkau1uw/WmbbNeus57OLFjuy0rl0rog/cgN4y7RMo1l+vqa//gKlqH/YQad8O5lG54iP1P1U8Jms5akksC+OyR0EQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x890RdV8BlWLmBppjOPsseYtjh0Yqpkmn7jglNggAnoyMrwWUr8T4se5p6Jc?=
 =?us-ascii?Q?KX8SgWmMvLMAptHNZpc3IA/3od9gcDDHcTPp2EslMdSUBhhwE03kXHXnVwnW?=
 =?us-ascii?Q?hbWCcJFSG5F6apPLjfvtRsHQO9J4PxiDpzOiQSv+kUA9pBJWufPmglSYgctp?=
 =?us-ascii?Q?HNMZu457xAwqi+hoSBUnlC6fjnbyfGfBSzilRS/ovJDh0ucTHPJtB3i5NkOi?=
 =?us-ascii?Q?NHxw/HmW9MZX1Am+zTMmbmWTD1NV/4I9HcPXhC0fq3qwbnYbI1aaRNWW5K/S?=
 =?us-ascii?Q?c5LfK3TEEUTZFnAW39rL0YfKj9xL+STU7CpBpBTGpChKF/GAkPXF+Cc4V3Za?=
 =?us-ascii?Q?7h8gbSg4fEl3hdnZYYnqZjlQhpUgT6S/sFqq1GfV4J6N0t/c6BNpNYfwnf8R?=
 =?us-ascii?Q?N5A9MhT3RKCjMPXfczNOheOD7aZT3F7y2ixvL8o4mqOa3CHA1UPK8srLsdEC?=
 =?us-ascii?Q?OiBBDAPsDz0HJNvgsuIpOOZj41c2UAgNiXR7YsNsVx/wQ+0up0nRuZSV7017?=
 =?us-ascii?Q?yz8ktrlnbs/Hc1h48YYCNK/lvvApWh+Eqv7J8IZqZ2Yt/qyDKPwxxf1+I1y6?=
 =?us-ascii?Q?4DSE8YK1jFgKsfi7pf3Gkskm9SZEfwHady6ujGJr7jFbe3SkS/zw2gmVlSJ/?=
 =?us-ascii?Q?+K2SGShgI7O8GuQ+aWy+7IR1pgTov+S63HcxVXgApqWdXjkxAUEZzCNOWpwW?=
 =?us-ascii?Q?K3LDebhOwdUrhKvTrAVvi4SBtJlYWMDWKVnViQkPK+BcGWCv34fB3cih2q3E?=
 =?us-ascii?Q?0JmY25V5C6aktap2fXPT1G4EnVvBYYDLVxKA4wxnKiwW7A+HzTF0tefIAwyu?=
 =?us-ascii?Q?zbk4vOSy7iDVeE81cwpKS9TxKNmCxEjuJ/4fyasaQiHYwS841V7xiphKIPSK?=
 =?us-ascii?Q?yLLdQgLWXhf9z6W0WjZLMTYz/W1ZnViQ7lsXyQSLlId64cHCiWIMBJBnKG/8?=
 =?us-ascii?Q?XmBcfEGwFAf+XPNemlbaeZMcPXZg6WeusO+lrBMI0ocMZmfFO83nsTOJWSAR?=
 =?us-ascii?Q?sDP+Q+X+zxNKI4/0jqCHzHRcgSO7aLr9mO04obm1mYmKXjYJrwaSuBrkT3HE?=
 =?us-ascii?Q?DScj/Fdl8Y5Y6Xd7z6qK5Jq6EFE3iq0G0JGTXC0r3k4NNQyylKppyXNl0wnv?=
 =?us-ascii?Q?3GE508nHuUDl749YvCyLb8yeVo6L07tukTd2KDW3CLVf0Iohg438a/+PgbWk?=
 =?us-ascii?Q?D1r/kIZd+RF8u2kxbXkwfV3Xih3AC2yLs0+4gJzd+h2MxyqVywsO1pMwApcm?=
 =?us-ascii?Q?f0beXcOiZ15hccBWBzz6UnIu8kgpB63ku4KXO/Cd4VQd8gyF4LnnRTCd+ZuB?=
 =?us-ascii?Q?0Tc8XXXFFV7SzDnXhosJxmdEUhmOjvHfPucln1JLZP6b+5GdeofIsI8Tf91n?=
 =?us-ascii?Q?ts2xjVO/RcvB0ymfTLA6Dm8hP7eKDSWutDG5H0z/53NlO7jFbofsofpir7Tk?=
 =?us-ascii?Q?l2negrodDXvButd8U29pQYOJQsPH11V4qtQFwnp+wWVL5+OVFId14iPjf2EE?=
 =?us-ascii?Q?GLJWdhyC+8cSC1+xtR0PcFhH5life26XCAS4GCjmfSXyQ/klJXqs5BnISw6V?=
 =?us-ascii?Q?Ebkd/T1vK5WaGP1sv4CnNV5x/ctMihJiUplv7M/hQxgzyR+PsJZ8V0AgMTxu?=
 =?us-ascii?Q?7Q6Y8tG4wYbrlqXb4MSHzPfkIY/enNeIngDpFuu5/8n/nLDXqNYys/rrpZlT?=
 =?us-ascii?Q?0UJXmz1ifatnQcOd3MC/n21zy3SzArvssoxGp3a/ibBY6qgEVnOZ4Xl3wIIm?=
 =?us-ascii?Q?eE2WqvF75rTPfdhHxzMe5WhnKkAdLgE=3D?=
X-Exchange-RoutingPolicyChecked: edyPEu578qPfDpmf6cBE7KxRYrDslen+3PAFkJxNADbs2JWxh5WwU9Jbnm7HFLyqHdAC55Y8DK4pcSR5SbHF5N76jyCY2QlTB1mn0BHqf1/mzAaAcrePUNh5Bdu4TqotCChVNIwKgtcApKFU8dMoyld93gP4xEyUHcPb39ZbTiup3+oe3sZlO/a1pqP98A5EQFTRj1MXzVGPnUek1nJOFS3riMNVKTALMsRZVUtkjdkpGHaNYaETNSbgAjHw2UK0fa3OBIGif7RZmPB5/fPZ4Hri0IK2bRTjM8blsE9mIH9DBwMslZGygfDttwX7bBaieGZRnQcyzJ+Ti3BvThFIGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f92e3a5e-5100-4d54-e14f-08de9a14a340
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 10:57:36.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrwKlGFTMezhTK+CQ9MPgoH21ZNZAmUbFt/9IJXsHEwOeHW3FLf2g/zfmfIvBzvCsg80ErL9sydkr7A8glXGrRLV8aMR4tiHUsmqgymn4jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278395-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3683F3F9104
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 02:09:22PM +0100, Aleksandr Loktionov wrote:
> After ethtool -L reduces the queue count, i40e_napi_disable_all() sets
> NAPI_STATE_SCHED on all q_vectors, then i40e_vsi_map_rings_to_vectors()
> clears ring pointers on the excess ones.  i40e_napi_enable_all() skips
> those with:
> 
> 	if (q_vector->rx.ring || q_vector->tx.ring)
> 		napi_enable(&q_vector->napi);
> 
> leaving them on dev->napi_list with NAPI_STATE_SCHED permanently set.
> 
> Writing to /sys/class/net/<iface>/threaded calls napi_stop_kthread()
> on every entry in dev->napi_list.  The function loops on msleep(20)
> waiting for NAPI_STATE_SCHED to clear -- which never happens for the
> stale q_vectors.  The task hangs in D state forever; a concurrent write
> deadlocks on dev->lock held by the first.
> 
> Commit 13a8cd191a2b added the guard to prevent a divide-by-zero in
> i40e_napi_poll() when epoll busy-poll iterated all device NAPIs (4.x
> era).  Since 7adc3d57fe2b ("net: Introduce preferred busy-polling",
> v5.11) napi_busy_loop() polls by napi_id keyed to the socket, so
> ringless q_vectors are never selected.  i40e_msix_clean_rings() also
> independently avoids scheduling NAPI for them.  The guard is safe to
> remove.
> 
> Add an early return in i40e_napi_poll() for num_ringpairs == 0 so the
> function is self-defending against a NULL tx.ring dereference at the
> WB_ON_ITR check, should the NAPI ever fire through an unexpected path.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/
> Fixes: 13a8cd191a2b ("i40e: Do not enable NAPI on q_vectors that have no rings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

The problem comes from a fact that napi instances are kept after
rebuilding VSI with lower queue count. Instead of duck taping the driver
and adding conditions in hot path (!) we should fix the issue at its core.

I'm gonna send a fix, please drop this one.

pw-bot: cr

> ---
> Test configuration:
>   Kernel   : Linux 6.19.0-rc8+
>   NIC      : Intel Ethernet Controller XXV710 for 25GbE SFP28 [8086:158b]
>   Driver   : i40e (in-tree)
>   Firmware : 9.40 0x8000ed12 1.3429.0
>   CPU      : 2 x Intel Xeon Gold 6238M (88 logical CPUs, x86_64)
>   RAM      : 64 GiB
> 
> Reproduction steps (FAIL before fix):
>   # 1. Reduce queues so excess q_vectors lose their ring pointers
>   ethtool -L <iface> combined 1
> 
>   # 2. Enable threaded NAPI (completes fast in 6.19, no hang on enable path)
>   echo 1 > /sys/class/net/<iface>/threaded
> 
>   # 3. Two concurrent writes to disable -- fires the msleep deadlock
>   echo 0 > /sys/class/net/<iface>/threaded &
>   echo 0 > /sys/class/net/<iface>/threaded &
> 
>   Both background tasks enter uninterruptible sleep (D state) immediately
>   and never return.
> 
>   Observed kernel stack (W1, holds dev->lock):
>     msleep+0x2d/0x50
>     napi_set_threaded+0x10b/0x110
>     netif_set_threaded+0xe1/0x140
>     threaded_store+0xd2/0x100
>     kernfs_fop_write_iter+0x138/0x1d0
> 
>   Kernel hung_task message (~120 s after trigger):
>     INFO: task bash blocked for more than 122 seconds.
>     INFO: task bash is blocked on a mutex likely owned by task bash.
> 
> Validation (PASS with fix):
>   Both background tasks exit within 1 second.
>   D-state process count: 0.
>   Busy-poll (net.core.busy_poll=50) + 50000-packet UDP flood with
>   1 active queue: no NULL dereference, no crash.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 28 ++++++++++++---------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 ++++++++
>  2 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 926d001..5042f8c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -5182,6 +5182,14 @@ static void i40e_clear_interrupt_scheme(struct i40e_pf *pf)
>  /**
>   * i40e_napi_enable_all - Enable NAPI for all q_vectors in the VSI
>   * @vsi: the VSI being configured
> + *
> + * Enable NAPI on every q_vector that is registered with the netdev,
> + * regardless of whether it currently has rings assigned.  After a queue-
> + * count reduction (e.g. ethtool -L combined 1) the excess q_vectors lose
> + * their ring pointers inside i40e_vsi_map_rings_to_vectors but remain on
> + * dev->napi_list.  Leaving them in the napi_disable()-ed state
> + * (NAPI_STATE_SCHED set) causes napi_set_threaded() to spin forever on
> + * msleep(20) waiting for that bit to clear.
>   **/
>  static void i40e_napi_enable_all(struct i40e_vsi *vsi)
>  {
> @@ -5190,17 +5198,17 @@ static void i40e_napi_enable_all(struct i40e_vsi *vsi)
>  	if (!vsi->netdev)
>  		return;
>  
> -	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++) {
> -		struct i40e_q_vector *q_vector = vsi->q_vectors[q_idx];
> -
> -		if (q_vector->rx.ring || q_vector->tx.ring)
> -			napi_enable(&q_vector->napi);
> -	}
> +	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++)
> +		napi_enable(&vsi->q_vectors[q_idx]->napi);
>  }
>  
>  /**
>   * i40e_napi_disable_all - Disable NAPI for all q_vectors in the VSI
>   * @vsi: the VSI being configured
> + *
> + * Mirror of i40e_napi_enable_all: operate on every registered q_vector so
> + * enable/disable calls are always balanced, even when some q_vectors carry
> + * no rings (as happens after a queue-count reduction).
>   **/
>  static void i40e_napi_disable_all(struct i40e_vsi *vsi)
>  {
> @@ -5209,12 +5217,8 @@ static void i40e_napi_disable_all(struct i40e_vsi *vsi)
>  	if (!vsi->netdev)
>  		return;
>  
> -	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++) {
> -		struct i40e_q_vector *q_vector = vsi->q_vectors[q_idx];
> -
> -		if (q_vector->rx.ring || q_vector->tx.ring)
> -			napi_disable(&q_vector->napi);
> -	}
> +	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++)
> +		napi_disable(&vsi->q_vectors[q_idx]->napi);
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 894f2d0..3123459 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2760,6 +2760,16 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
>  		return 0;
>  	}
>  
> +	/* A q_vector can have its ring pointers cleared after a queue-count
> +	 * reduction (ethtool -L combined N) while napi_enable() was already
> +	 * called on it.  Complete immediately so the poll loop exits cleanly
> +	 * and we never dereference the NULL ring pointer below.
> +	 */
> +	if (unlikely(!q_vector->num_ringpairs)) {
> +		napi_complete_done(napi, 0);
> +		return 0;
> +	}
> +
>  	/* Since the actual Tx work is minimal, we can give the Tx a larger
>  	 * budget and be more aggressive about cleaning up the Tx descriptors.
>  	 */
> -- 
> 2.52.0
> 
> 

