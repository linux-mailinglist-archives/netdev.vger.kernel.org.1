Return-Path: <netdev+bounces-301718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xYM5NK0IPGrSiwgAu9opvQ
	(envelope-from <netdev+bounces-301718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:41:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4016C008B
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:41:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=SLmtmJfD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301718-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301718-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B35130DAFD3
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E790C31E827;
	Wed, 24 Jun 2026 16:37:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22C31F9BD;
	Wed, 24 Jun 2026 16:37:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319053; cv=fail; b=Wvg1QXu/H5RaWJ1tVPBtMtpU9bI2VboiCNxPFsyboi9ewTyrIPkLaG3GclASUOgZF4BmAison3oUoDRPnVj+m2Ojaz+DdHmLtSAflye43RLBdTpmGsPQOrth3ru6A6GEZOfBC9ez34C/jB/QoZK+DXDSZMin8FYmj5stv1Y/fWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319053; c=relaxed/simple;
	bh=Y+K95gVXA4+3ehTh0rop4DzfiOCwU/Sek5iXfWoOkqs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=My9ANcXZ/iogrI0fTErDH/mfnfbOsJBMAfi1NBlDsM6YkKs/l2RvpRLcXQ+l8Za3yBSgDBV5lOGlL55+ah86q2PexnFIYVWkDIHkKQ6k1pa7vbPYoOnUtE7nfXgeOdbn/HXa0XrswEcxO2cUY2efkWCy7kT7eost5Wt+AF+6Crw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLmtmJfD; arc=fail smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782319052; x=1813855052;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y+K95gVXA4+3ehTh0rop4DzfiOCwU/Sek5iXfWoOkqs=;
  b=SLmtmJfDNYRkBAng/dEClSpdAYKNjo0UmRsVcoL/OqJ1QSGskfd1UWzP
   QmV7ONJUUJOZTFPEvpaUycJMAtadybEupA+YysnqCjtg15McRik1pOyvv
   2Duc870HCeUGrLtS7CLjRAMu2MHG8j/h4b5hHqB1/Vgm989M+jj5hpg8b
   pE2RQ12KYOU72ggPQfeczpne1cwl0EOXCEGXftFzoUolrZFVzmXJt1mj0
   9YcyT9CPLW1DdtGsmdmQcnEB6rtm2FCqU8m4JC8NOBOvoEIm5ysx6yRmz
   PldXPT4Mhzx29GDn5zVnF81Xe1CTAWL/AuPCpINWqH21ZCEuQyFMPD2CP
   A==;
X-CSE-ConnectionGUID: jKbk5C5mR4KnNFxxED/Lhw==
X-CSE-MsgGUID: x32ypoalQO6JMBaXCiJTeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="86932324"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="86932324"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 09:37:31 -0700
X-CSE-ConnectionGUID: sApyVSquRjOQaq8obxQ1Hw==
X-CSE-MsgGUID: grg68quQSriFIQYhnCSixw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="255018638"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 09:37:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 09:37:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 09:37:30 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 09:37:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lknVeF/f7/OfUQInm2VK7q2W2i3QlSsNlhCiA7bexlfygSlg7CCdZOo3TTQEfb2+/PhALaAFiVViuN3ou4/5PKAxnFTRC+zx30fTDmsiV63N2ojgi9y7g92bHQkJcLktVLON3DhvR4LJxVtYSoOcdMduPd8Z43onkyE/6JlqlS1exndRPZEUZ8sTwYAia7z91aqzeXy0528ABW1IJ1TcDEydTydJ2Sh3ipzZRGlTItxS5FY3O71ymaXZZOIuDyraLNO7EnRlC+h1QCF5Fhhpo5pLXH66HTTcaVuscY6gEDRoCWrPZ/n8VGiaSMyWHYxUrgeLtxta5kexZqyq3h54vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiTbmk2FjVtmyFU+42bvCDV9LRxjHgGvACiu3OIuQq8=;
 b=HGatqbJzrSQ2T0iscnDizDyh1ym81EWbWapRcGQxn/ibHKe8d0KMRTX3naYI7r40Qw9+xAr8s74vUjEmr6rSKFJRhNZxR2CVl0Hpl1nG/LHkkIkNpp5dzzKRwaYC3C8iHKP1PrKh+SOxq+/CkAOnaHZDieq3xsqKnaoAT1v6o9U5fNuYx0UB8Sa+RV1xH3v/qheLKI+JHb/rLv+wKJCSJUrTyFbXE5sxoVNzKQJlJUMLfJxp1Rj3PkBncUKV3gFIZs6yS5ryvmyqjYTlkLBUjld+/boTSZ4ePBTOJCuIvYPyMTN7+hvdzgx2KE75tN9fem9HpjczgrG8mMD4ry/Bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6113.namprd11.prod.outlook.com (2603:10b6:930:2e::22)
 by MW5PR11MB5906.namprd11.prod.outlook.com (2603:10b6:303:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 16:37:27 +0000
Received: from CY5PR11MB6113.namprd11.prod.outlook.com
 ([fe80::5355:e5c4:2d03:8ae5]) by CY5PR11MB6113.namprd11.prod.outlook.com
 ([fe80::5355:e5c4:2d03:8ae5%5]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 16:37:26 +0000
Date: Wed, 24 Jun 2026 18:37:12 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kerneljasonxing@gmail.com>,
	<bjorn@kernel.org>
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <ajwHuCp82SazSwKv@boxer>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To CY5PR11MB6113.namprd11.prod.outlook.com
 (2603:10b6:930:2e::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6113:EE_|MW5PR11MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bda8071-2392-4348-4775-08ded20edfce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: m26ab3cdVvi3rKK76fvCy0Y7jEPQRaF49QDh5zlyCyOAQZzrxvuDlBdX5EyRP4bV8H19vlzpkywd73+az/NiYKzbKaRBwQ/C/IgjjXoYGmBDB1gTjy44vsoAdxGExsRbVASMtCkekgZhXPERm0tqNlps5t7iaoeZDtO9Ro8BoXzLPJJh2P2zTRESLD+GGDOl6hT0+phfD4+fryJLUI3VM3sn7/ClRrxBQ0nha3m5jrGlgaA1zr0Y5IctrmVOaGHO3OTJ8PLnUK3tnWT3KYU9kRqzmtOuvUPjtKnqcVbkD7g6uUwxvgD3Dpx/6OBR8+/d3A/oG4DXReICdd+e1g9MhvE/Lb73O81rFwazGAIUm63rk0rcciEp80qyCa/tmrwv8fLq30P9ff2IA+mc0e/6qW2m2MERJU/wHP2RP1kfnZBqnlGlEWoN6hEXXPxJu6WjPIjGsezWtFYu9ly89Q5FWm7/Pkci2MrR8WucBdIHGkZDiOcQhkPrw9HiEPx3UdaVUwr4dLRb8Vza4K3a35eK58kodqIesIrArvKQv2dFQPVnYJcOeOXqgFQL4n8sf4JRy+YFWAn0KbM4DaRioB+MK7zUcd/2cDGTSetBbrJgppsXB1Ejiw1BA+PSCcSZRsTjN0jNm7dyhQ2d6y4hOkH7MG+lq9su568kxUca1X7JcMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6113.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YcyHNTpoizdmS7Fus3zj6GfP+6Wwh7u8tobCO47jktmOpNhTL8ydQcUcF97w?=
 =?us-ascii?Q?AOhJqOnFwxRU68tTZEcxh88FqTM8MfKEk0BVFWeY/HVPOqVVmkM9vSHnlxtN?=
 =?us-ascii?Q?UjjJAbqOkSYQ6aJh18aheP2dLmClCyJ5Le+rukXUahwUC+TWVAQlyB/Q99v5?=
 =?us-ascii?Q?kOL/Azj5ZcUoSau68WCTju6twZz79G/9S3zwF+MiGf30YPLOUqe3gNtFZckg?=
 =?us-ascii?Q?HQIfL07NOydpgOrvJ49+uebOJ9Q9LoP5vtxbQWpD6dG7wybR0qjY7sq/+fkO?=
 =?us-ascii?Q?kQ/LcVrdY7OImeqoe495g5suVXT+jmh1X5DQ0fR+5e9ZLMos1Jo1dVl8oKF7?=
 =?us-ascii?Q?yg4cPYsxJQ63wtMatK0q7v0Tr8lnoXs+tDwZSewLyqEWueh8YGpGuaWEBGV5?=
 =?us-ascii?Q?v/PKi3XkBSQqj3iImQoZ+q6tdFUhQw3MyR//v1xJZ2iP8UvEaqil+2IS7+g2?=
 =?us-ascii?Q?KrVkGJTYf2tcobSxL+9wRttL0ULGJ0ruPLM5ikOuF3/ahBuN3PD6rb0MZUno?=
 =?us-ascii?Q?uM3yvMCBIzdK/u72k+kaDh9iV2LezndiLMn2ujyViQO2X0vMV09wdDcV80pc?=
 =?us-ascii?Q?SB1f44W3y9AP3XOVwft3vVn2Iv2diUoKKJU/3/kMAwmdHgCMKvm3IvrNW6Rw?=
 =?us-ascii?Q?clptzTDxY8Nj9Jm7qtHzgcDtEVyWT/UP29nWSmec8CQFiwR6CfukVXRmtSNs?=
 =?us-ascii?Q?iz+3unLMYE25Y/ux0LWT0WAB4YQW4fNpCK1/ioWgT0juzbxi52DGbOtnw+KO?=
 =?us-ascii?Q?hg2aOTy5gB4rPITjzFJjbpoS8WXjZmQM5dbWOKxC/hHRgPBMYJi1EkZm09gG?=
 =?us-ascii?Q?82OoT0YD73+2ylHjlr+lIF4MWpsA10twq8t/ngQVYjCvm3ONz+f/f0Y046aJ?=
 =?us-ascii?Q?DNtXVA43vJgzZ2i8UZEQYWsXsRQLHXhWytGaSECh31gGcFHSFGOnBIqCOuQB?=
 =?us-ascii?Q?90cP5cRzyKRNnNf/OnPTM2rQlpbxWtc9PM3EtLVc0/DZLQ6ErB/GJ9R/zgzv?=
 =?us-ascii?Q?1dC0dq/zjp3RVQAQNT5Um5dGBUafqBCqhFS+4hRkHSF4Ixxv2NF78EAtaj3v?=
 =?us-ascii?Q?aLh32BoAcHXDPFPS/phCM6vu+iFZaKVHoJjgmSq3dTRpc0ay4fk1YtsPk4yz?=
 =?us-ascii?Q?i5iQUdGkGxuqQ4pCZHBNTgSV7PFPs5LbY4UiJdHyVvjp4HFVtxeRezjOaG/+?=
 =?us-ascii?Q?GSS3n2DaFOAIChyhoxijwEQMx63/OpFOhxjjdaHqtnShDeCcpwY7d4V23ez8?=
 =?us-ascii?Q?l036QtVUWVZ1Ono1j4mjOJLSgSLuntsx5nX6Q9LNJC8NIet3MehM+Vqf7IrJ?=
 =?us-ascii?Q?I3DUWPYsBif1L03xKQwqpCoFiaHm79O/waGizvGSEz0/ql1q246ef4L+mIqn?=
 =?us-ascii?Q?2mSlUhVMyJ9kZ1cBBaOMFav9H9PRF2BTKNXzyBtuWDPRFEAPDaKqyWDG/DMZ?=
 =?us-ascii?Q?AaNDT/quLqJ1LV8AXXu6S4B6e2OpoT+8UeUzMSFuuTAOdWdlTESOtEYAMCEg?=
 =?us-ascii?Q?cDkieOcXqZLafmF56IipK1hboyPgiTUg37kJnNI4UIBtkHwwjMGUzXCo2F0t?=
 =?us-ascii?Q?8vmXdQZ5JMYlwRK/iKeTYvtdL/nsOKRwQxrBWWEZwj1hL8ywWwAAktm7LKQu?=
 =?us-ascii?Q?j6Mih0td0uJfR1GVW/AKeq56dycgfer+zxOBsz4Wz73UGCVEWg9De6YaVd9s?=
 =?us-ascii?Q?pxvlYiAq1NxGUBhlCZMnPpt6SxllP950Rii0ZplrTicC8QOKDltwnhRIXLOb?=
 =?us-ascii?Q?cIOVtwhBqs9p4aSLiaHiIEkZOlzjcCM=3D?=
X-Exchange-RoutingPolicyChecked: Shpy9TpMAEUQpZg0rzlkVqc4rXa03xlOCGUVuzDsNJSlyN1Vr75aEwxtLiPYbFaQFjEnoFW8LL/OampmHNQJmeBI+7KSIfdkAEJyaFxDuhVSuwzHfrhDsDybmNwK/bOr0L4Rlrwlpmx3V1Yt2lKxLUwcIqCptTUQODkKEW8uSbY9mZ8rBLkUUTJ0VcOvllcFTBb+RB9jBroaRmck9g74Zj1s8Rq4dkHfzXZbSpP1tCEUr7dE+LDn1/oZf9a0pgK1ZySOTBRV6/PrwxhIMOihGK77B2kCIXwrAZRGMJwnVckzAMUJL53ZOdUiJqcjmxbLmIfKtp7NW+U28WY5FpM17A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bda8071-2392-4348-4775-08ded20edfce
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6113.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 16:37:26.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixQht4x1me4CbIqRUy9nw+Tu061jE/nJ9Nv7emiJTHP1UJDOS2KsyPIccW2OYsEnadSbgD3JEUtlV6DmOxiB5Pj0nQWyRyEelV87yBp7Ln0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5906
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301718-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:bjorn@kernel.org,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F4016C008B

On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrote:
> On 06/23, Maciej Fijalkowski wrote:
> > Hi,
> > 
> > This series fixes several AF_XDP multi-buffer Tx paths where descriptors
> > consumed from the Tx ring are not consistently returned to userspace
> > through the completion ring when the packet is later dropped as invalid.
> > 
> > The affected cases are invalid or oversized multi-buffer Tx packets in
> > both the generic and zero-copy paths. In these cases, the kernel can
> > consume one or more Tx descriptors while building or validating a
> > multi-buffer packet, then drop the packet before it reaches the device.
> > Userspace still owns the UMEM buffers only after the corresponding
> > addresses are returned through the CQ. Missing completions therefore
> > make userspace lose track of those buffers.
> > 
> > The generic path fixes cover three related cases:
> > * partially built multi-buffer skbs dropped by xsk_drop_skb();
> >   continuation descriptors left in the Tx ring after xsk_build_skb()
> >   reports overflow;
> > * invalid descriptors encountered in the middle of a multi-buffer
> >   packet, including the offending invalid descriptor itself.
> > 
> > The zero-copy path is handled separately. The batched Tx parser now
> > distinguishes descriptors that can be passed to the driver from
> > descriptors that are consumed only because they belong to an invalid
> > multi-buffer packet. Reclaim-only descriptors are written to the CQ
> > address area and published in completion order, after any earlier
> > driver-visible Tx descriptors.
> > 
> > The ZC batching path can also retain drain state when userspace has not
> > yet provided the end of an invalid multi-buffer packet. To keep this
> > state local to the singular batched path, the series prevents a second
> > Tx socket from joining the same pool while such drain state exists.
> > During the singular-to-shared transition, Tx batching is gated,
> > pre-existing readers are waited out, and bind fails with -EAGAIN if the
> > existing socket still has pending drain state. This avoids adding
> > multi-buffer drain handling to the shared-UMEM fallback path.
> > 
> > The last two patches update xskxceiver so the tests account invalid
> > multi-buffer Tx packets as descriptors that must be reclaimed, while
> > still not expecting those invalid packets on the Rx side.
> > 
> > This is a follow-up to Jason's changes [0] which were addressing generic
> > xmit only and this set allows me to pass full xskxceiver test suite run
> > against ice driver.
> 
> There is a fair amount of feedback from sashiko already :-( So the meta
> question from me is: is it time to scrap our current approach where
> we parse descriptor by descriptor? (and maintain half-baked skb and
> half-consumed descriptor queues)
> 
> Should we:
> 
> 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
> PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to userspace
> and do a full stop here)
> 2. now that we really know the number of valid descriptors -> reserve
> the cq space (if not -> EAGAIN)
> 3. pre-allocate everything here (if at any point we have ENOMEM -> cleanup
> locally, don't ever create semi-initialized skb)
> 4. construct the skb
> 5. xmit

Yeah generic xmit became utterly horrible, haven't gone through sashiko
reviews yet, but bare in mind this set also aligns zc side to what was
previously being addressed by Jason.

I believe planned logistics were to get these fixes onto net and then
Jason had an implementation of batching on generic xmit, directed towards
-next and that's where we could address current flow.

> 
> If at any point there is an issue, the cleanup is straightforward. That
> whole xk->skb goes away, no state between syscalls. Thoughts?

