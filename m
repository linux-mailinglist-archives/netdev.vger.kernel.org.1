Return-Path: <netdev+bounces-304995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LEtyDpKYS2riWAEAu9opvQ
	(envelope-from <netdev+bounces-304995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:59:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EE87102C1
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:59:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=YqHj04wj;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304995-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304995-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF5F130347DB
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC31C41DEE2;
	Mon,  6 Jul 2026 11:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130F3BE17F;
	Mon,  6 Jul 2026 11:50:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338622; cv=fail; b=EP+c681o5VY2J901NEr9CZzwGBtvqlDl7bwRFa0zx9A7TfDvgpg/YT1wxOJjoB7tCmZ95eEQsMwggCww23n12S4KxRZ0Z47owF9LFPlu5lIMW9WuubxdybuOUQM5NZHEaqG63ZTyj8ELQrk4eTvikL+SMlLPmWKdru67Z64AEo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338622; c=relaxed/simple;
	bh=oJd6cAhNKiR1VTVp8b0sddRLaYb613t0uXcrDMwZLsE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hN0h+M4J/lAdAJtEruevVcKG9GKloLs+ptJ2+LIScD8YHg5dIJNSa/DU7dU4LN4l1DhhPNhKHNyfDzkkOW9kQTygm1FVWTw4AirvhZeKUvhuIJjjeVuz1DNRCSzPYoAqWWF4w6W0FEkoGrwpDw4eZR1Hdx8OlC/es9/FDicX3gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqHj04wj; arc=fail smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783338620; x=1814874620;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oJd6cAhNKiR1VTVp8b0sddRLaYb613t0uXcrDMwZLsE=;
  b=YqHj04wjkxNpvGXFTl4x/fDnDWFjhLSf+gct4koEpGGYgQuDkZGhmCYB
   L48UCRgwWhkSE6DWVKDBET/tl/18pMBF769eYSY/VwgIkWpvwzGqHxFCt
   FksKvqLSE1ZaJNkkTc1ikl6C6U28qFIcWqXxSFfnwKELlrQoXE3bhGzTG
   +k6s8qw7Oceg40m8/gz6u7Rd4p0V+BUy9tDfgF/79veK9ck0AmVycJwLs
   eu4tgPQtg9kaJAP7f4Sf/HjMjfndc0FDpVdRS4Sdiqkz28MJKFPv1oK1a
   JLkh/2fsQYHah9DejyDnb8XmAcgBP9vnOaoBKGZR3hqcvBhrYbZHvjm0o
   Q==;
X-CSE-ConnectionGUID: MyeMXyZrQpqrAHlQFFsRnw==
X-CSE-MsgGUID: qQpllcttRkCNzL3m2JT22Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83078952"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83078952"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 04:50:19 -0700
X-CSE-ConnectionGUID: 5PBqODrlTb+KFoc4jPiFCg==
X-CSE-MsgGUID: RJEsm9V8R5y3nqiViIUkjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="249246809"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 04:50:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 04:50:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 04:50:19 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 04:50:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHxmwkJA4764j8+Rcx95jIdG4KV7wx9Js2w7bliJL1gAyAZwox5Np8ki2SvZo5+zDl5ggKZxf260xpBM9B7c4WdEfauNoU5hBvQq8zE1VN73kCqjQurHT0l5hzmLWq3o7h72cM6VnHswAIEh9f861D6jGVK8tCwzTOt/2ZiYWyD8CP5eso3COeVo8zA6NR2sQWN0cVj+dA6AV+7vDUzqYJHhgD8YWHIiKGX286skobAvVfYGTWowmamssdPxcFhAPPVvBC1hF3lQNq0DAR5zr928dJhr/3R2nUisrAwV1laaLtwzIm8G1Ng8v2rRBf/jSAol0I9OHsp0mzDGG7koZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flbjSEJmVwSND7MNE+jMqrNj8ZUCq5Z/CCHgMWGZXsc=;
 b=krT7+jgLXUJ8gEASonfqJ5OjpChQbQrLcWoQB7GPOvZ+GljL8Oy5YcIktifAwI7lZqyk5ax9ni21X2vDdSaawYtphg3+GDScp6qDyYC3yjOvMgTMm+YLQpabx1eE1AM3LENMzdqBJLofDSUWBDHCRFY5XOXJYS+g5anTC1gjw/f/MmPKw2CmvOhyE6nJxLJAkIonk7z7yS/hV+i26W80GLhOxTys2V4h7rGuHUSM4h4zXjnPRNsw1jjaRjsJ5gI+JH3E1KmnrBIJS4ORcunJCeQeEPCBpSDHjWqT2uIPFdBHlbgbxwvcl/oEenae2rO30RUPZifwr/bVGpg9xqmXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 DM3PPFB266726CF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 11:50:16 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 11:50:16 +0000
Date: Mon, 6 Jul 2026 13:50:09 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
CC: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
	<sedara@marvell.com>, Shinas Rasheed <srasheed@marvell.com>, Satananda Burla
	<sburla@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Carlier
	<devnexen@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maoyixie.tju@gmail.com>
Subject: Re: [PATCH] octeon_ep_vf: Fix RX page leak on napi_build_skb()
 failure
Message-ID: <akuWcbEppMMQ0rww@boxer>
References: <20260705031620.274396-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260705031620.274396-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: VI1PR0102CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::20) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|DM3PPFB266726CF:EE_
X-MS-Office365-Filtering-Correlation-Id: ff963d1f-f1c8-4ef5-c972-08dedb54bf50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VYZjFdlfyCUIis+eCLqWredI2XcZs/ZezBAwkxe84538QaqDrSVJi+4yHk2S0zITULXuf8QDdvCeFyivDbnL1ZLReAJpKRfEIZNsKa/kh5L3fE2/rOrkXPP9htOQBFDwy96dQSgO+bx1akItSBiKgNrhdz5wajDqam24NXy4HW6K/X8QoZ29Sr2n69sfbhTPjPb1LCHFdIzR9NPmZBFVMp45Fq+BlScv/bjXccbmYBTO2pNd2ycep8/7Hcrd2ofOr95C4tHZmZOqwHY4+4x0Pr+4f0UVku51ngwmwepLc/P+R7gOEwIbBQLOBXY4+xvE1McXgequJxKn/DVvteqqrDwNp6b0FH/mjyqA5Onx/yaRWAZ5fbQDLG9wOaVIkai1L1rNpeHWle1eKm6ZuRboBBVY1UdpZCvETn/jK+UcWCniTKCpSuIy1mvRK1gs3YTGQm4uTnjNlS3VdjSd/yTWzz7B/7v6ZHJpAmQTTHg2222mqj1VI6oIjIx5tmX/N1sF7wu3B8gtxVMSWNyymMPsdHOed7znKcO5iXXu4Y1DYNYRFRRzmrasAilf/nMh7AyicTom608WfYyt7CipohJi39osIktPTTQwf4fT+7idm+rhI2kOpcZypKZ1WxTOQndeKfDMwkSok5uJ7PJ3zfE6+R3aNyU0cfnoDheXoyshvWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nNm3s646iEm8kHMiGIlC2VIGswFuqHzYfrlCtebJ8k08bXLfORukuhDgwdKX?=
 =?us-ascii?Q?WjWw27zbDtkrZAtgS8glpThEM/cED4aeS9RKdAEbr3NNXkDra+ekOjyOn8Sg?=
 =?us-ascii?Q?b98dzooPH/xYpNVruc+AyVUpXVGQw/dn3YZPwOLGCQXrtO7Iau9Abzcfqb+k?=
 =?us-ascii?Q?PBJcOruligKmDOUvXbqBSXrF7Q4v9mzpfibOQJ9+JxpIYLWc56EprIZ5aJ7v?=
 =?us-ascii?Q?cwmhS35B4buRjQXAeS5BDM78XOVkOr73E/vibpd372jMRl+yI4aJAEy8B9Wg?=
 =?us-ascii?Q?FtkrbwsaxmlU38TmgVaac6Mr4+itIbdPtOQhnZGO/C/u9ntGUKv2CClRT+DE?=
 =?us-ascii?Q?mcLh/b/DJ7CPzWsl9EDCJPbV/aVsCE+FiA6DotX1Au0l/X37dVLjHo/Cl370?=
 =?us-ascii?Q?Iu510FXFmrZ08ZTGD+7VLfqBwey+OXA06JKBj8zdNI/9UvvhTlSEBQesqiIB?=
 =?us-ascii?Q?bJwjZ0lD0KMcnZn1bPl30Q+ywUXnJEexGctC2QfaY+eqkoTg8nqrmW7bCOCH?=
 =?us-ascii?Q?G2rf2A5sETQ3RG/m1FO2i+b1gQntvhsntvwOKbFDjUNE2n5awmyCQGiClGxM?=
 =?us-ascii?Q?97mKHZkr1QndbXF/Ah5fdNoWzwBcmEQm7+d3azXBaIouXlaI23ZihwhCOXtQ?=
 =?us-ascii?Q?7JllmuZnOZ++lsTes/XBi8BV9VGBJHFVXjteWvnCS1AmxM3woYCQwtCH6PK0?=
 =?us-ascii?Q?riit4TdlJi2SJ6PuDgjdgXfl36XohGC3OSI1TjeBSqu6Fawr6DTiqZk05Yo2?=
 =?us-ascii?Q?WUiMWzHyFp0qG0PMl45yYVLYSrzsUbw5OavH4tElSo1ljNxYlwElb9Y11K+g?=
 =?us-ascii?Q?YiuVnikAhLnVhpq5WWr+nVoPdcQpowPaizuLoCA5hl+HeY/Ob1tvMXaiml3g?=
 =?us-ascii?Q?uxOtYzEDDXqFSRUx4jXCLvSeutn/Isfb7dXGAB0rBJo4JJPSWS+Wb12oi1NN?=
 =?us-ascii?Q?Y/3qyV7+7GmhCbDbrDACIri+InLq7PnDl+KMi6B5onBm9DspqIMSWWY82sH3?=
 =?us-ascii?Q?uxShzpMHjdkKpKmn3LCc1jJwLWra5dOCJP671y4Rij0HerZMRdA3PCP43eTh?=
 =?us-ascii?Q?DyhuOQ+kde1ER2PgVeet9C1/neqfO3Ya/0E3XshVu7+vgFhikeGcRUjzlZMc?=
 =?us-ascii?Q?ClHEjpYXIxNougTsAYbBNbI/H8PN5H2DIQDEgR1JISYYANIKpOtRuLeXZTaf?=
 =?us-ascii?Q?z8Ghm1YX8txc1ao5pDEAvWWSyitbvVT2/cBPnYiBqjS+N33kSdcUM48toiGM?=
 =?us-ascii?Q?H0M+dFdmB+uiclpwgsNTvioRoXdG5CdBzSJRb4auNWu6IJeuFEfGjamtZMRi?=
 =?us-ascii?Q?f56RatM/pNMkp97wultxl2K6WioC5zs0k3m8eIfg+fCBFJTYtIw8idEwqx5c?=
 =?us-ascii?Q?na0cDpmyFFuD0z3Y20TQRAemINDSZmCb7vciv+Ss6GpcgKAuRCD/H+HOw9Gk?=
 =?us-ascii?Q?0wX8iaqTzbASclX/0nmixgNP442uEMWOtC9ulbcxs9zHCCyAyfJXQviDA0hg?=
 =?us-ascii?Q?XX4fi/Za+CZ7bOf4XiFXX9A39rvPpUpSDCruTWHuGNs0EoIoLJtiKCfMHGrz?=
 =?us-ascii?Q?cnuMlwvE1+xtXuefKrjEP1FX8+khdATubHqSdVMRYU9llMH3EjnZ28n5O2U0?=
 =?us-ascii?Q?nzwfiR8vsPMXMsAcm9pIHF/RMdHSLIFo3pHp3yhVL0kfQPzZ3BqNvTr1iM5z?=
 =?us-ascii?Q?tqlHdUSWoXjPaYOQAoIw/k1ckpvkWeiZ7LaTDd682texjMSn5KcA+cmILFLv?=
 =?us-ascii?Q?/jPNdDlM/QNqWE5WV/Y14GAHd3kEP/0=3D?=
X-Exchange-RoutingPolicyChecked: EQIwSazLuCUG4Qgt/r104hKBY/88nEB3TOaF97C/kPyQTKawsply8HqD0lYVOYEuxfepB5WHOTflvGbb/5HhYs1IB/kRnCRajCCkOr7NnF7ooUfld2MvHYTbr4w/IxkVoA03CiDy4oh3ey/Yq1D94sxYYzHrcfODF9OGxbc/gOZtq5EbblT5kCM5IwYNeO5F1aAL8hU3m73mN4K0VL/XlCvyeKSqWRk8z1xyZqbm4BplGh4DEwt2HTErVo4jWe6iHfynLx1+AdTGt3FTINgAUBHDq70FS07pYXIDcus6kxqEZum71QtVW3TxUngdAq+Gr6copiRCqzCdxxStvJs+gQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff963d1f-f1c8-4ef5-c972-08dedb54bf50
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:50:16.7408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1jkTxwPgtVXCMaBmT1sWgPP39+/kBtho8kEnPPlSgF/cpt2RE4hWbpdrLEQfuSpTJ5IeW0CWerJQDTR2HPJZ6vnI3JFe30IGQR/+ptaV88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB266726CF
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304995-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:vburru@marvell.com,m:sedara@marvell.com,m:srasheed@marvell.com,m:sburla@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:devnexen@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixie.tju@gmail.com,m:andrew@lunn.ch,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[boxer:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6EE87102C1

On Sun, Jul 05, 2026 at 11:16:20AM +0800, Guangshuo Li wrote:
> __octep_vf_oq_process_rx() clears buff_info->page before building an skb
> from the RX page. On the success path the page is consumed by the skb,
> either as the skb head or as an RX fragment.
> 
> If napi_build_skb() fails, however, the page is not consumed by an skb.
> The error path advances the descriptor and leaves the ring slot cleared,
> so the page is no longer tracked and is leaked. In the multi-fragment
> case, the remaining fragment pages are also unmapped and removed from
> their ring slots without being released.
> 
> Release the head page when napi_build_skb() fails, and release each
> remaining fragment page before clearing its ring slot.
> 
> Fixes: dd66b4285470 ("octeon_ep_vf: add NULL check for napi_build_skb()")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

This will conflict with:
https://lore.kernel.org/netdev/20260704061511.2350737-3-maoyixie.tju@gmail.com/

Maoyi, maybe you could take this and apply your changes on top and send a
v4?

> ---
>  drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> index d98247408242..302559b16be7 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> @@ -418,6 +418,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
>  			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
>  			if (!skb) {
>  				oq->stats->alloc_failures++;
> +				put_page(virt_to_page(resp_hw));
>  				desc_used++;
>  				read_idx = octep_vf_oq_next_idx(oq, read_idx);
>  				continue;
> @@ -434,6 +435,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
>  			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
>  			if (!skb) {
>  				oq->stats->alloc_failures++;
> +				put_page(virt_to_page(resp_hw));
>  				desc_used++;
>  				read_idx = octep_vf_oq_next_idx(oq, read_idx);
>  				data_len = buff_info->len - oq->max_single_buffer_size;
> @@ -442,6 +444,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
>  						       PAGE_SIZE, DMA_FROM_DEVICE);
>  					buff_info = (struct octep_vf_rx_buffer *)
>  						    &oq->buff_info[read_idx];
> +					put_page(buff_info->page);
>  					buff_info->page = NULL;
>  					if (data_len < oq->buffer_size)
>  						data_len = 0;
> -- 
> 2.43.0
> 
> 

