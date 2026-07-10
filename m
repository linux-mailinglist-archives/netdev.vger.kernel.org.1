Return-Path: <netdev+bounces-306496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 07RlNX/CUGqX4gIAu9opvQ
	(envelope-from <netdev+bounces-306496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:59:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F12773959A
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:59:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KIZ06FP6;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306496-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306496-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC8DE301888F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0433FF89F;
	Fri, 10 Jul 2026 09:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246D3FDBE8
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:58:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677505; cv=fail; b=J/TLuSavJHQ1ZXKpT+nr+Yrjz7geTAB+c6Z48T+rIpzymHo8fJ0phGQ4Vq8tXaiw4YPHIAcRP6HO2B79a9aBxKfHMUqxSqMA6kCUd167R704VBEjEVV+p/fsvWRrj5GClOMgmWEHUoUXuK3//oJy+YhM1v41+LnMR+aKyD0wsOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677505; c=relaxed/simple;
	bh=NGUnVy+grJkWHYKUIIcKJCA/lnXuV5CNFbCZH142NYw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cSMXdGvSzi7yh9E/jLFCCoMnH/unFvaQr+aRndJkBFrn1GPdqSdWi1cw+wfFoJYbisKLBh6Zpwp4vqjMogs/au/abi2sE1x98ZHvxpDNoXiNlOUfOAgwy9Ovn0O4E19MENBrX4zx7QZoZLLwDhm8dR+5XVLkNYWckahHtd+HOQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIZ06FP6; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783677505; x=1815213505;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NGUnVy+grJkWHYKUIIcKJCA/lnXuV5CNFbCZH142NYw=;
  b=KIZ06FP6EtRUCao39KYEQCl0pbLNujW/LCX5HaaONl7eCpI2MiLfmKd5
   6fLIOy5W17p/tAdf22UAZz24zo/OVkxmdrCJg3epFjk8Wt6ZSR0DhF8eS
   klFmUxsDNY4blJLCC4SFpCjSjPlPFqpzd5TsC5PpBC5XX73Ua//nQ6f/R
   XdYR3PXCODRMR9EQ2FWs3Lw2I7fAjn1CQXUZiD+dIY4RVV8NS6GmiLZy7
   E9787uuyL3s71csu7w/UHtrgVkvdeky8f6sI01h4BLvAzN9cn9/Dj0rcD
   /7C3ORIXqiaLYrmSNO2cl6Ney8a1euwSg4URpVVMCTfZtWTuaeHWPlIjd
   w==;
X-CSE-ConnectionGUID: rGUt/n+LTTmCod9Wh2DnOA==
X-CSE-MsgGUID: nvccPi2DQZunqA6RiXa7sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88288511"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88288511"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:58:05 -0700
X-CSE-ConnectionGUID: eNU2sM/PSBmWY6M+Ac05Zw==
X-CSE-MsgGUID: olsY8CqtRz614/zMyl0CfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259741906"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:58:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:58:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 02:58:03 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:58:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqGUh4PUuVEXCQ8T/T59TsJoiJ1hRlNv0rtWmk5g7Qtn4hv6pBbSTKCvgTRPB2FL7nKUYO0O2kIn2uCvRefYVvSzDWenBCw2vpopdNGwQ1j2J8TlidmLZF7blUybu0xKAHDVxLJI6KAk5YGo49sVp4Vf7bNfrJfPFzH1Z6ak7GzBrk6w3KUJ1PMKAZOpHesa1Qeolc8B5fr3k24oHjLT/N/8u7LOhCAPjM/LeWyB1eMVsfxulgLBEcHhHeH+4HMOkF+4CEnbBkdeKRsiYfJgiv+J1ULGKy4bm+QiLuo4or/taWxiFAeV0E/zWCNkHT643ZQosiKKcsYBC3En6jiFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FI2WN0VxPRGkxVO0VYNHPUkgukzOoOUDCelpnLI0UJA=;
 b=HgL+HGZ397E+opRFU+Nr52NbIGYQTNXDG9N2P4d5ySdveTC0gfacuLQ4MGmBuwglZn+TeFGNnzfXWb1/JuvR7wI/5q/DZxARSwH7gYrJzeACEyQSwu6U5Mau5Iskuj7+82FsppB8/+CgQNOCTs2WPpT/WHtr9+UUStsFX02Xp9RuFTgK0B02gjFX76BPfUMS9Sh34rbuPGF1NrjNQ0bzVHTuzhBNAIqG14nQk+LvHh7zLOXUDF2VOrU6jc5Ce8cTVqvktUmPJMCkZCI5+v/9EEV+gCozLBr7BzQuVoHbNbDqOvk3saQN9kR1dTRzRwB8R3dUxG2FlFEGoW9uY2R3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4SPRMB0045.namprd11.prod.outlook.com (2603:10b6:8:6e::21) by
 DSWPR11MB9956.namprd11.prod.outlook.com (2603:10b6:8:3a4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.16; Fri, 10 Jul 2026 09:57:55 +0000
Received: from DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485]) by DM4SPRMB0045.namprd11.prod.outlook.com
 ([fe80::b630:ca9c:20e1:f485%6]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 09:57:55 +0000
Date: Fri, 10 Jul 2026 11:57:50 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
CC: Simon Horman <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 5/6] ixgbe: E610: add MAC
 address runtime refresh
Message-ID: <alDCHrOYHvS1EdHE@boxer>
References: <20260702091553.57112-6-jedrzej.jagielski@intel.com>
 <20260708170223.1514429-1-horms@kernel.org>
 <PH0PR11MB59029D8B78557F03143546D3F0FE2@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB59029D8B78557F03143546D3F0FE2@PH0PR11MB5902.namprd11.prod.outlook.com>
X-ClientProxiedBy: WA0P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::21) To DM4SPRMB0045.namprd11.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|DSWPR11MB9956:EE_
X-MS-Office365-Filtering-Correlation-Id: 64303107-2d64-4912-4bfa-08dede69b6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|5023799004|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NMCsfMSBiled2ljyfV/qdLv7E3IXZZgboWcKasnj1XqjZLCJsmNwr/Y6MWWYtYlm/OQarAtIWCCs2uImRH/D7TJHf7UWHgHx+ljcYTbI2Xvyr1U8nYkzuE7ycWcfPpaLIvmfLQvJx/nd8Gujcqct9jSz1QPK9MQsl/5RAQYTBYl+wpx8XqNI1pDQZHNqyfssyuZgMeiaxP4XRs/z3ey7PZ1ucagsO4QKMq603efYOB4MbZgNO5YHVnUdXH58wfPfqgOZaTnuPq6PdXlViV6C1wv7IjU45wV+DruWUkcZe/4hUbmRRZNEMrmiz7Z1Q5xFUcZ/xjdXsJVZeC+hfiSu9fABM4w6T0YdgbATxmnciCj0D6jQoXmYt7AreQ0474xl/XX+bCStdiv8R6448jy21cGOmf4GF6JmPhxn/m386D4fzlbmGcbQkf0wwqlYqZz5oGoDVC0nl+fvET8iFCjA0xPx/5KYA2g2dO/nH47Pt9FdUbwaa/HZWvSlfF1/RZIvrTOGjIlfyWtG9gmmPhgN27Fw3YtMPZgcB/KF+AwYPjJ2FQpLoD98LYEo/H12ZRCjdFQ6wSwwbJpR+/Jlta5cbFBM3XF6aP470YeaVnsITU1jdC8FNR6Boe7UJH3Q/kso
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+/H+58/p1eTI3ADVyQD24JWRl5rdRKaVjxpRt9SJnJzvrFi1HW8amrIA1Qs9?=
 =?us-ascii?Q?QftRgu1JYW5sTnZf+1tFLmtxHrCvL+aLDqDJAVqH0TwLinw57fZih+Q0Q9og?=
 =?us-ascii?Q?ndV6WAPhPplvS+RN44a3OFvydPYdGJg9WR7Ial7oJ/vTHd27n8cz+FSr9OjF?=
 =?us-ascii?Q?gult8+Qho552XyXLMJDx0W3uvZjA2DGp8D4lDEvgMSO9pXeP1alisuMhyJnR?=
 =?us-ascii?Q?mTiwSekvP/TAjjLVrq1HymX22fLOf6mFWbgHD+meDit3q9cAf7PEGscV1zhf?=
 =?us-ascii?Q?XRCdCqN+nUX/ZQOOoadwvHvlsCaNdRog3d2DSCqmpzrHx9jpZQJ4k61gmtk8?=
 =?us-ascii?Q?jip52ogoAbLpMRUfTrSaN9mV53o0pBGMB/TIcjY3XDUQ+s2B/6BgMtVOKxYy?=
 =?us-ascii?Q?csym10UJXDLWogmPP1p7x0pNp2g0m0sHdcRxrA6KDDbchhiocSHeihLuSy6r?=
 =?us-ascii?Q?Ho/cy1kLjg3OIP1Cp+XbzRDpcypCP4nQMlD1HklJwjOxtVvQodEDmWx4AcPV?=
 =?us-ascii?Q?ywnN3/+GivScpwExVonOnpwW0kBHjCoGBQDfIHPf9SSUPC7YZ7cdnUWkFVWG?=
 =?us-ascii?Q?in9L6YDy3bwjgc0MoxeWbsN2EzMY+3pmcV6fB8WRPVSjsHmU2YuRalk3QRrj?=
 =?us-ascii?Q?GclvS83CtWHiLe0jNmNBtL0CqDEUphCpNQ+iQPL2ckUffuOtd4bWsFkC0KZd?=
 =?us-ascii?Q?pp4p8k6HGU0eb9ckKlgJIiDVV+ponCVk+LXdxnkYqUV3VW5yalc3CPXLnIy2?=
 =?us-ascii?Q?U5XCoSds4GXDbN1vbbLDgBvdZA93lCfCjFekgmxMSIEj9vAI/Yz5hvveMA/P?=
 =?us-ascii?Q?5yohpOC1ZQgJasxnMmFZMILBOoeHRrFEaYR5mbl5Awpe/1eto7P00yl0JHIU?=
 =?us-ascii?Q?UXixkCuDPYRJEVYwCn3m1GQ+4A7CU1omvdFrAmpjj0NmssL8/VKAEURqnG7I?=
 =?us-ascii?Q?Wl0xLE1kWXm2vQm4gO9GgDdZMYQ+Ax+UMtt6oFWBmNHDzFAhFSq/A6u2720f?=
 =?us-ascii?Q?Uns2RmAr7mJSII5Tp8kiBL3d+JhkJDA6lRAAcmYX9uJluUxNL0DqG1haUJtc?=
 =?us-ascii?Q?e63u5cTKULuDBZ3hUilYl7c7zUtYY07lVbpWPtIPznTQK0dMk+f0xRxb/LkO?=
 =?us-ascii?Q?zIfbEXuHIWKnGG25DkH4XJyIFCnpcCLT7hViAshF1Z+ewFwWf2AblRgECSFp?=
 =?us-ascii?Q?Gw1MhuTAuXwHscb4hv3SYBtvPxSQQocGLQqz7NX02yrFPsPOmvwOIGoJav+T?=
 =?us-ascii?Q?CJdvWsUMZYZVRRCdPQCdH8uPIlogeq0T+iD5ePmBNKGgZV4IzAIljBW3mR+U?=
 =?us-ascii?Q?SFbFUc4vUE51q/XtmJHrsgUXGPAjMXnokL8aaZ5dvu5pY15ApDIjX+o2O7QR?=
 =?us-ascii?Q?Je0mTxKe7mfowqbcU8RNA2zSetH9opqwzlcrh0xdr6J6ApH0v1563dkjirUa?=
 =?us-ascii?Q?+VYgwS9RZv9NdGDOAiELp+MHrxDWLQ2XfjewRk6ZHypU1Q9ZMYGf1ox3BOMI?=
 =?us-ascii?Q?y1UOU8zGTdS3ZGfU/0xt/x5LWsCc3WHolySj2e6YBCdQ3y8oxuAk/iS+NdOa?=
 =?us-ascii?Q?7G51WMGEmrsd5MDwKVfcNn5tBup2offyVM0xiWjB3rvyPshmMe7eZRzyK+WE?=
 =?us-ascii?Q?Gcqpxp/10aDY9wnjZk5JrZH4VLlGA50e/vpjBsOqZpYBWDpDQXt83jvFDRSl?=
 =?us-ascii?Q?gyhcVfd+CCy7ClfMdtxGmOYoekL2s2dFM7qsgeaQkYL7GA/Ytb6wu4ym6SVF?=
 =?us-ascii?Q?GW6wNofSs/epbSG/TuDcvPq8L1aKzgU=3D?=
X-Exchange-RoutingPolicyChecked: QAhK5UjqeR+eQrVSE46XNgwRJiGRBnSgMjMVcBJAbrwrC279TT/A76KlI2FBqab6or8N8P46HCJBF+j6nyzRuJloEVX8/bftp4NkgHop6Q+owD3/SVYK+SFEv0kHA2PaYDSqAJTphOmpDmbub5esrobHi812cFnjkaN64/Kqe/nUSsDuHNOZrXhvnx8gTIKKBDbmoBnK8pwtk96b5LMUvRv0kIRQASWPpvmFcLGkHU8FhLfFZPTjNDAFUGpL4a/REhrdLZrmD4gvRC4CTuLGNiIEyQD0e1iBHJPVc1V4pTc3R1YS8DrS81A6tLiznITba1iW/U8b8ohrvXuVLD0J3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64303107-2d64-4912-4bfa-08dede69b6e1
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 09:57:55.5716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoYNKY8JDGwhmgCdAzIsldsBjiAhNu/0ZWdcah5rkzgfI6rVShb0zGsB0nYuZr+jFOvrJhg0jsxVm/1RO4yxK/hXYqVuzPuj3S4WnhSqm0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9956
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:horms@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,linux.dev:url,boxer:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306496-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F12773959A

On Thu, Jul 09, 2026 at 09:37:27AM +0000, Jagielski, Jedrzej wrote:
> From: Simon Horman <horms@kernel.org> 
> Sent: Wednesday, July 8, 2026 7:02 PM
> 
> >This is an AI-generated review of your patch. The human sending this
> >email has considered the AI review valid, or at least plausible.
> >Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> >---
> >ixgbe: E610: add MAC address runtime refresh
> >
> >This change polls RAR0 each service-task cycle on E610 and updates
> >netdev->dev_addr, hw->mac.addr and mac_table[0].addr when firmware has
> >altered the MAC.  A refresh is also invoked from ixgbe_reset() so the
> >address survives RAR0 clearing during init_hw().

[...]

> >[Medium]
> >Would it make sense to hoist the E610 gating out of
> >ixgbe_mac_addr_refresh() and skip the rtnl_lock()/rtnl_unlock()
> >entirely for non-E610 devices?
> >
> >The type check lives inside the helper:
> >
> >    static void ixgbe_mac_addr_refresh(struct ixgbe_adapter *adapter)
> >    {
> >        ...
> >        if (hw->mac.type != ixgbe_mac_e610)
> >            return;
> >        ...
> >    }
> >
> >so 82598, 82599, X540 and X550 adapters (which comprise most of the
> >ixgbe device family) acquire the global rtnl_mutex every service-task
> >cycle only to return immediately.  Something like:
> >
> >    if (adapter->hw.mac.type == ixgbe_mac_e610) {
> >        rtnl_lock();
> >        ixgbe_mac_addr_refresh(adapter);
> >        rtnl_unlock();
> >    }
> 
> Cannot introduce rtnl locking into ixgbe_mac_addr_refresh() as this
> can be already called within rtnl-locked path

i40e does a lot of dancing for cases like this. rtnl lock is handled via
boolean provided as function arg:

static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
...
	/* Release the RTNL lock before we start resetting VFs */
	if (!lock_acquired)
		rtnl_unlock();

...

end_unlock:
	if (!lock_acquired)
		rtnl_unlock();
> 
> >
> >would avoid the rtnl_mutex contention on non-E610 hardware.
> >
> >>  	ixgbe_reset_subtask(adapter);
> >>  	ixgbe_phy_interrupt_subtask(adapter);
> >>  	ixgbe_sfp_detection_subtask(adapter);

