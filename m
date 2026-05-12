Return-Path: <netdev+bounces-287254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCYbA0RhA2oq5gEAu9opvQ
	(envelope-from <netdev+bounces-287254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:20:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA402525B1A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06DC230B48B2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D280385D9C;
	Tue, 12 May 2026 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HusN/zQ5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F763385D95;
	Tue, 12 May 2026 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606052; cv=fail; b=CYKf/DCwNI01C8lk9O5MEry+McDEvwyx4k0yOEoznV3sq1xwdNhMwNFWM523ks39JPgL37F/xmYdxfhheXLru8iOWmYnX7IIKsnQzDb3Pm1y09TepICuA9auu87a1qeLpG2WScnihxDwnV2pqOWNDkazjZLvLRdWq8HK61Arosc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606052; c=relaxed/simple;
	bh=HLJJE07Kq8MZDIdHVrW1JKiqwX3H+yShIMJtgTyGsXY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GBsz9LMpnd/nivrzwTg8c71xe7Y5fSFYi+zsmRQAFNrOTeVdAmZbmvSYwJQxlGd8hpYgSnOTrVWqwC+3ZuFI4rGKwzUef1s5bkQ4aWS3asICd+6V1wh4BKOUzNW7Ktp7GLZYkVxExYYU1HjT2LDadPrP19TrclJWwboK9c0Kx5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HusN/zQ5; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778606051; x=1810142051;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HLJJE07Kq8MZDIdHVrW1JKiqwX3H+yShIMJtgTyGsXY=;
  b=HusN/zQ5x7/LwWEC6EzTV25wV7G3+pmWW88vhJMegf0hFQgUQDhh5bez
   yRqxOCeerB1YE5E6LeeEFA6fNhC7GfHvWycYO1rjKO9NL0pXvCvbyRboo
   Ea0AxcNoukBChqmRyjIhXjTdY39SLvScLelowDezfB3HQ2fIQ8UIEBAqO
   sMz5zKRV91KYoYawu7nIGfp86IO+uPwKWxG0XsxAKvMVnsdTd1fQOPrGS
   V9UliE3Q7f5AT+0qdOrvK5mF50IyhKVOeCJO137BWLYiRu3g3eCwvL9or
   xlCbK8fxztqOeVK8Nrwi3NdP8oPlORIlIKIj5pwMinkVDuhLEVwOGeIZm
   g==;
X-CSE-ConnectionGUID: nGOuKiMcTwKsT/iXICQ1DA==
X-CSE-MsgGUID: cnKBoGykRCmFBt8yMOJOYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="78666722"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="78666722"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:14:11 -0700
X-CSE-ConnectionGUID: rWwR2RXjRYmU7oCSWN5ZuQ==
X-CSE-MsgGUID: ibcPTzWYRKutFqx7TTuj9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="241834379"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:14:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 10:14:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 10:14:09 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 10:14:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/wnKqiJd07Ye7byXVIW2K+ziyZmZs6IqiBqs2rpGJYyxt/Z6JwWzIRvgfDTBwRRdbHRJULkfEWtLJhtbJWh+zgI2Bl66pMKcb+216wArDhA5cwYIhlXb86T4NZ79tvsN7AXEql96K1jv79BA5P1Xra7emcFLe/elw0vpRnnoL+N+9qPO4D6hzqOBBMKNVI8ucoGmHy4h9V/xlH5UUs0iMbFfJ/DXlLSUVoA6MhaFO+GK0oCYPUBxOIwivjXlXr5dGbWrGajGYKm/nF66xgc8GmEi35OmexdxF0S4vYlc636HS7AgnzI0sqyO5+BJcjFJirwH7VBedKAY0FMv6+kOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoZcRMbdnmKEM1uNwVlhSdP5tpfI552LMU2274DnfPQ=;
 b=Zb0xL3jbQaEfT0gFxmm13XQMEEoP4Vaz4hESnpZ185WsIU5nX/6+8PsXZjJ8+NJInrmhxMU1PdM4UxgRUyUB18TeE6MgXjR4DXjegXo8U6E6KrhUPYQGBzRMRPkyv6rP6YCQCPR3LwfECSwmmN5y03sFOSg379jta0OHh3mFiidukW9jbUzNIVm/yMeC+9zMq0Zu+wU3g4oABfcx+qNSipAwnYiMRH3igZLKTOFA97jDscVq3sEd3tZUdILhZrNrA8AoHWIyFwC2UNK3hLHprHPIeDsoAHw5WcH025JR/Vd0DPl1X/j4YlUSFj9jFuMyU0PDOXW5PvTuhqQUPGELJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB8829.namprd11.prod.outlook.com (2603:10b6:208:59b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 17:14:02 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 17:14:02 +0000
Date: Tue, 12 May 2026 19:13:54 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <lorenzo@kernel.org>,
	<hawk@kernel.org>, <toke@redhat.com>
Subject: Re: [PATCH RFC net-next 2/4] xdp: return status from generic_xdp_tx()
Message-ID: <agNf0gc0vpfV30FC@boxer>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
 <20260509084858.773921-3-maciej.fijalkowski@intel.com>
 <87bjekkcot.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjekkcot.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 434000f4-b641-408a-99f2-08deb049dd66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 8dO1/RruEaMCX8dKQL8QQlG1RvQLFipn6S2c+7oOtlw4kZfd2M51ejQRkDOYQm/d8TxrufgJn9gwHj1Q1qiua0bMMUj1fBjCD6m5pNFmDZFnrHoUXe+/L1MGXmMLBgoZ4oT1bTAUnPtxnYn3WGiD2o9jlU/YJtHMrv2ih3wDmg0kM7oNEhk91FC3sSRpUnzTzyQuYljP7xRcsrfv9tmWGZxPUK9WTqKfpBMJueHldgVwzEChqMYgzUK70I2oD2fLt9HMgk1UYjwoDGrmlHW/CK5rpgd1F3qNZQmm1pFvQKKRNRUOad/ttnJ26QzO1xVHl0Ce727WQ0SSt5JmMCPXYal90J4+/+DXZ7pZH6DVmInOx/vK9VIaQE++XADkSlw+THlItSqeUjpH4gx5dQ/G8K5Viz/JtAcYaSwgBs3iln+SiMgLxKpqeUBqyPtze7LNldDlaegLrIbUsxrzBAAudTP5xie6RX6a6Vi6JJpb///JGt2jq6kCgLw9okk2haso7oF7wyPGVNfV9EHnZS5yarnpUfLFMgHbQ9M+zmbZiObQTFPJsFbzQwr736lBBffXMOeGuWDN2Q5FJA+Kl+bCEH+1uMGZn4xhaB9pzwMlwLDdhctyUtISzByixmyPRM/qqlBJYyXXuo86pMw7jHyBH5JmfrVUvIOwztxyI3LO1+S7tcGyET4FwCZH188hbP5D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?h1zFoC0Jw+WNig3vX7skPd+Xj0MsPlrgpq1DdSlcryAetvZVaUkJyhRtmZ?=
 =?iso-8859-1?Q?m9ehyjSFFtCm3Bprwk1D5PXFi6As1jsWmlxwp/5u22lxCUbvH7mbhXcJfD?=
 =?iso-8859-1?Q?vIt9R8VsquwaRgpsQswjpCL3dU/ekoUeixmuAmTc+2Ann7lHbc+BRjOvv4?=
 =?iso-8859-1?Q?FSntXiKwbz1p/CGwfkVth3/nVFfMJHRrxTDSyPVxXSvto7H6+A5BST3TKP?=
 =?iso-8859-1?Q?WV9hmkx5GT8SUV4GIojBFZWwtQpkJYHABgPLjiN/m8T18GlTCKL62LUWzu?=
 =?iso-8859-1?Q?tjHwiNh10wsLeGCcgsmf6fYBigjs74tUbjPCeHL924gyswm+t+661Qg3v/?=
 =?iso-8859-1?Q?iazCrBR+Vr4NCVYJeABbKZ49W6IwgnXUl7pz8BGBPv2IjWyb/ySMFmI5B8?=
 =?iso-8859-1?Q?xKASJ8T7CanOqwUvQfLl7w9i6kHzDWyynIEv042u3bOf97bU8ctUPap14r?=
 =?iso-8859-1?Q?0HSn6aqDv14+xSrPuJowiCJGWMwhgX9C/YClvogJf/ktCQrQU3X0yqH2sw?=
 =?iso-8859-1?Q?ivhNLrohP0WnSouTeZR/2qGHeIBcLY1bvjLhbxpP9qPnu7NdmOqFe50Vdu?=
 =?iso-8859-1?Q?dbdw0gKiNBCmvvbM3pcpfGeRBMHdQCQQTAWrKRuQoEy+s38B7OSOcBY9Vz?=
 =?iso-8859-1?Q?8mmEEWjaFdJbtrfaJPVyH1Zqo9HD6qXRQ+b5HxBcC5Eq2hrddm4xrl9bOW?=
 =?iso-8859-1?Q?YZdNmKy5ZdyNdv2bS50+bRdNxSumw8WrIYXk9jbz+8vE01h64aVveoqwYO?=
 =?iso-8859-1?Q?2T/Sbacy7rPmmB2U43hQVF66EvWGnCmT9HyQcXKqN9MsWowbSpDV28sywI?=
 =?iso-8859-1?Q?Z9UCKRj2yfH4hbtTparVzx3DqA62om2KvcVCwW6dPVk1p/N+o1AlHiyhto?=
 =?iso-8859-1?Q?U1fZ1KuLzGvhuoCAfcppPPA+xmQy2rVkqoIVPismH9c6rV1lhmZpqYJFGr?=
 =?iso-8859-1?Q?ESF5s/LG1iQkZU1Y7AC7uHxRr5nY//hfBgzFgonjA7Rw+cNtdcSOgyVuHF?=
 =?iso-8859-1?Q?646r03LQ3nnKn2Hhs+qpFbr4l17y4+JrFxtjW3gUkcqaCtISUp0J52CRAd?=
 =?iso-8859-1?Q?SisycvJk6sXP4YwOSMNGpGnpHLvDnBNVvop5xSTjhFWJLek01pVgZwfkeN?=
 =?iso-8859-1?Q?6brBHR8cDIz+VEKXDlrv2x1ZDLn3vvVMJuAWGmieT0nLwy6cEGnhLQOkWl?=
 =?iso-8859-1?Q?bHfWuTiPd/VHcPgNOU32eTPnD42Z3kV5gR+d1uGo2bpgBWdSYzwNV210wL?=
 =?iso-8859-1?Q?R+4tN33gRfekxVSitm0Hu/eNa078ds3RJvLa9Y8mrv79gJyd4qALb/SQZN?=
 =?iso-8859-1?Q?2O3eykVs43YaRDF41+PjAAe8CDQ1jZ6C/dYfCbrusYQE+K5m9mw4Kul32c?=
 =?iso-8859-1?Q?SdtH3EWfR/LfRa/9xT6hvUg2Jza0OpFTdEPZ11GFhpNOsEInLuqewPIjIf?=
 =?iso-8859-1?Q?tNDnbYCWXX0R2vv0Bha3yVCuJWDLmnEYFVniuyznB3EeZQuvJyQ5uiIrXW?=
 =?iso-8859-1?Q?V+7SqF7CIIsAAHyC7i2BO3R0mE3UKEAr9HIowTVOw16vzxf8LMwFvz2jH6?=
 =?iso-8859-1?Q?xaLyICFBHLrqIDCNoIL7TaLQO/sFxS4tSjc6rMLz8Mq106utluMFGgh7/m?=
 =?iso-8859-1?Q?TEz6fJq43jR8NHTUOiwPbuN2o2cW2rN/rFHsbGF+iUOxATesrEIYJIrv6e?=
 =?iso-8859-1?Q?t9oPkjp93PocAyY+oXMrJzDzIPw8ONmvUPiRLHbtvf0c4bfcqLwPkwUa5p?=
 =?iso-8859-1?Q?1aUJY96zxoH2WiWBf6u/EQwZXKLJw5oJR6MfWwBRe1NXS2h5OqI487UBuG?=
 =?iso-8859-1?Q?dcXObsX88t+tdLlUQBUWbaeaVQIIE+M=3D?=
X-Exchange-RoutingPolicyChecked: J9mfHB7BUqv1ygdM7LLn9coWUD8BiFBV36Z5Pdfxj0dRcyJT339hPFFBx4w6AAOdDMl+RoX36U0+57aTEgAWr/njr3e75bYudFiH1Giw2QVu7LVU4NNegygulJEaoU+VOpEkyzlXOl46aRCQ3khyaZ5U8uqNQgiBytgrB5DrcH3MLN4riB+uPR7YSy44RM2qBAb8zd1ekVv4ulSA1wEyk+Xb8WMrrJCb9de/o6vNgaIRZwqaJTnpftkppQBUErLatj9Q0S8qunkC27T7ClrkRGbtFlmI1vFC4p+DslwLZUEjw4s0ob/EcGzq13IhBlMbkIlT9p1NZj/SnSQmMYVRzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 434000f4-b641-408a-99f2-08deb049dd66
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 17:14:02.8034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEm5qsy4xbr2AElufXyleu41tNP2R4lToePUvgVTSyKsBdeO1X0gVL0F7B3u/LNfKp8VrHpjQZ0LWTQPyimAWoGIMMnV0JChF/zsJqHL3sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8829
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: AA402525B1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-287254-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 02:57:38PM +0200, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > Once veth will start to use __do_xdp_generic(), this will be helpful for
> > correct stats values being incremented - otherwise we would not have a
> > knowledge whether XDP_TX succeeded or not. With this being implemented we
> > will only bump xdp_tx stat when actual transmission happened.
> >
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  include/linux/netdevice.h |  2 +-
> >  kernel/bpf/devmap.c       |  2 +-
> >  net/core/dev.c            | 11 +++++++++--
> >  net/core/filter.c         |  2 +-
> >  4 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 47417b2d48a4..473b18b0bb63 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -4255,7 +4255,7 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
> >  
> >  u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> >  			     const struct bpf_prog *xdp_prog);
> > -void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
> > +int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
> >  int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb);
> >  int netif_rx(struct sk_buff *skb);
> >  int __netif_rx(struct sk_buff *skb);
> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > index 3d619d01088e..b7a4a0266345 100644
> > --- a/kernel/bpf/devmap.c
> > +++ b/kernel/bpf/devmap.c
> > @@ -714,7 +714,7 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
> >  		return 0;
> >  
> >  	skb->dev = dst->dev;
> > -	generic_xdp_tx(skb, xdp_prog);
> > +	(void)generic_xdp_tx(skb, xdp_prog);
> 
> Why not propagate the error now that we can?

Yeah good point, just a matter of 'return generic_xdp_tx(skb, xdp_prog);'

> 
> >  
> >  	return 0;
> >  }
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 6cc2a5bed20f..09012cdea376 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -5628,11 +5628,12 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
> >   * and DDOS attacks will be more effective. In-driver-XDP use dedicated TX
> >   * queues, so they do not have this starvation issue.
> >   */
> > -void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
> > +int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
> >  {
> >  	struct net_device *dev = skb->dev;
> >  	struct netdev_queue *txq;
> >  	bool free_skb = true;
> > +	int err = -ENETDOWN;
> >  	int cpu, rc;
> >  
> >  	txq = netdev_core_pick_tx(dev, skb, NULL);
> > @@ -5640,8 +5641,12 @@ void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
> >  	HARD_TX_LOCK(dev, txq, cpu);
> >  	if (!netif_xmit_frozen_or_drv_stopped(txq)) {
> >  		rc = netdev_start_xmit(skb, dev, txq, 0);
> > -		if (dev_xmit_complete(rc))
> > +		if (dev_xmit_complete(rc)) {
> >  			free_skb = false;
> > +			err = 0;
> > +		} else {
> > +			err = -EBUSY;
> > +		}
> >  	}
> >  	HARD_TX_UNLOCK(dev, txq);
> >  	if (free_skb) {
> > @@ -5649,6 +5654,8 @@ void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
> >  		dev_core_stats_tx_dropped_inc(dev);
> >  		kfree_skb(skb);
> >  	}
> > +
> > +	return err;
> >  }
> >  
> >  static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bf9c37b27646..d6d14e0a1e35 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -4619,7 +4619,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
> >  
> >  		skb->dev = fwd;
> >  		_trace_xdp_redirect(dev, xdp_prog, ri->tgt_index);
> > -		generic_xdp_tx(skb, xdp_prog);
> > +		(void)generic_xdp_tx(skb, xdp_prog);
> 
> 
> Dito.
> 
> 
> Björn

