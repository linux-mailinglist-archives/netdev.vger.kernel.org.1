Return-Path: <netdev+bounces-268557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCshE5kzuWnpugEAu9opvQ
	(envelope-from <netdev+bounces-268557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:57:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CAE2A85D7
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A537D304A220
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A9C37C907;
	Tue, 17 Mar 2026 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Roo40suv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4343379990;
	Tue, 17 Mar 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745046; cv=fail; b=uF4Vx99lOcVUCwZR2VzVyWPvfSg9ilfBCwGsEuVs2G47WpnEqmr1w5OHKrBYCKt/53hvppk06mYpjHC7uj16VfRc7hUI43A5vamd7yMR1XKKSdIjZavYMazuXU4J6UhC0lh3u1F++tRvjXTw7urHNSM7lZ2+D1MjWjpe8KrAKCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745046; c=relaxed/simple;
	bh=wpjB7oDzDTfGW0L1HTIT++sigJWxLFun+160oCj5Z5g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hzvQiqeMVuAY0WBjVctyzQlDKESIYT43AWU9PK5kiT0251SjJwdW/4xHjcn+gSgaM15oImeS2WF1Lil+wVUHC0aLxZPU3lRsioUCA5094wFbGb3kTyCDrWH/k+di/3X1NDKLHJdRgc9b/qYZAXCGy+aaoFRR2PB+JrezZDnBSAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Roo40suv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773745045; x=1805281045;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wpjB7oDzDTfGW0L1HTIT++sigJWxLFun+160oCj5Z5g=;
  b=Roo40suv0+bZh/3Cla7KLtmwaiv789XMeJODGm2QPHNnB/hZpMhnmEKW
   r0mNFEmV/qHVUu/LOhhgP7oGw139o0mYezHh/nUKqe0U61p+2kkWevww2
   7Zu+Lywc0CVQ2Jhcg38BcG2NEUbZWxJ4o/l+NVSrf/proZVEuWpcDDtfO
   MLb9x3nqxj7mPAQvlZLURd3UqxTsGxSNUmGwra9BZchroQuS04pL6qMr7
   JqL6O4rgUYPFpO4aTBKJO+thjPfsyr7DPaMBRcgc0NJ2Y6qXfgzQHeZBT
   gErxP7XovY6svAvSmsKv+ZnlHpA53G21xWQQ5zL5m45lFreO+Fc5ViTt/
   w==;
X-CSE-ConnectionGUID: bes+yzFGSDi6ef/+JWJ/cg==
X-CSE-MsgGUID: dqE/yXkGRxm6Yn+zblErqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85473095"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85473095"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 03:57:24 -0700
X-CSE-ConnectionGUID: xkB3CQZDSzaTRM85yHfgVQ==
X-CSE-MsgGUID: WDGztel5SCOXeAOvS6Lf8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222182209"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 03:57:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 03:57:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 03:57:23 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 03:57:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fScnYKLqUQpbZQGsvTfWEEu4KSq0WZmibayV8/WnCSXAXA7oAR5GiPjd31/aC4MEAuSHg6OBU/fVkW3YC6wzBoFtdtRpABF4dpfph2xP+OoPfhqP66NN39n/ysB4cLj9cM+0c8Z5fve4kxylXGDjGxrRn8ktGwwhnYBPAz78JS4JSRMzPxgWypGpiRYxsOzEC8q0iUqq9XYABYq0oxZxuK1m+QekF7b/S39Pq39/ESff4pBV1DTHHXpnxaTN/zbba3JDZeqEx4LgE8xUp2wsqYJ+0o/sbtZe8mo2lLhZ9DziyfiziyMgVgjmJrfHfIrVHilAPWFv85FbWiqCQNryIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXjyzdctly9UR5IDaG3+OqTvRhZDA9krvIQ/X7exw8w=;
 b=ezK9gRjxcpCz2e4i25epeLwDdfiTFYwcK8sjPycUGl9AVd8++cgrF5S5bU2HsQDsnWnxZKbhEcZICfTI9uev02GNWO8kbX6glvEixG9u3/CmWcvaUvOE8nPJkCQvZd8yQ5XVLYlpSAr8yx3K0BnqCG8ip8+pymm3da5RNpomuknXBE+V9DC6QPFwyxD/HdKvKIs5UmiZJcqjIVXNooqaig9/pw8aGV540UlRJEDJV7qPOdky4+6ErRKq0iiRn7SQxNWJENzhvqdlpnZLsaKy4X38dFZvYnnHQlEhX2d1OQr+yVK4DWPHu48oD0IaxCgPiU0q1I/2tVxgR73ccC9bEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7652.namprd11.prod.outlook.com (2603:10b6:8:14e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.17; Tue, 17 Mar 2026 10:57:20 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 10:57:20 +0000
Date: Tue, 17 Mar 2026 11:57:09 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <larysa.zaremba@intel.com>,
	<aleksander.lobakin@intel.com>
Subject: Re: [PATCH net 5/6] selftests: bpf: fix pkt grow tests
Message-ID: <abkzhZex8RtzNLdm@boxer>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
 <20260316174550.462177-6-maciej.fijalkowski@intel.com>
 <87v7euq00g.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7euq00g.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: VI1PR04CA0096.eurprd04.prod.outlook.com
 (2603:10a6:803:64::31) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 8394d516-484b-4aca-41a6-08de8413f648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aNXUoHbwPJ7Y+OBQ+UBsAcKBLvrOiFzzYrzObqvRQh/BeaoPOJdJuWXvPlrc1zT3gpohaI+9epNiTTR7reVQCefWkih3LiJG9syA7FvqD72lAqvFSjrPdczLOntCOhicGHYyFJlk2EKh397hiWSfJaiTevU6U3uggBEqkdZ+RBJcEQioQOd3Fj/gLBmfwmw5bUxAaB58VQwTdeb08JfnXBzC8c//MbQ36baORJqC1sMVqTP2eH+1tYO7Nr+uTno6kbXTitIH+acbrkysUo1TukuVGWBZdxLRwJI7QvmC9RIKvLdH6hTmwKNopedVLs1ewKrR5oifo7j6BzLoQt3WoKuF3jn6A9pMPJ1hLJxm+NIrQ+hEo3Pny2T2FfRXCTgbmAdP2OYFGT+l1Rpeso8VFC0NLeRkZ23XpHHe0xfIEkgHEpdSWdnY5O79HMr1G0ojvE1XCqRcBv8Kdovh7nQKPpSKfCOowy7yZN6Y+CfNtbAtNEQ3OCS3ji2X67y56bbc74u4sprGojm4S0yA2H9H4IvzCkA0JBaI8mxJb9P/R0Rsr27K0IL4YKKrTUU/XvqmuC/yZnf5PB/Mtu4MDT0JuBroTnMAbvX5bcjEM3v2ZtCOSH53sdIVJOyt8dMzfXaXNzHhx0dpLbJB42wkgBs7KSAosmXMGzR6cEdQp/t40FbJdy3s3Mbk+ZPlaqBGn5aUKEqbf+7vqchcuPt+ruKQwps88lbB7u+/UA0RA75e+Hk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4mSDBDYOGVUzF69+Y3eBEGQXH8TjLCRic3RkqfFc/jpFGy/HfAxRLdBZYf?=
 =?iso-8859-1?Q?4619jbqkPUL/T2/sDESBQgs/JVG+XlGe6YPJX/okLp5DY3WUOGsXDqx5Ua?=
 =?iso-8859-1?Q?aoZw53RcS7oKakz3NRv0qokyyLmX2yZFZ31nAOKMZuGXi6tvtBtg4b9YX/?=
 =?iso-8859-1?Q?0Dl6uswq1wxuWiey/a8Sc0IvFZ12znO/INpQfiJzkX8hs81/h1GkC8t7DC?=
 =?iso-8859-1?Q?t2USLR3IBZUG95ad9TPNASct+dG6hDE+tRSdaLHxZlp8mzdgEA7MJPrm9A?=
 =?iso-8859-1?Q?tZYXocq1o+33gzQDmhmPXXcG9eT98j6H0+oxbiNaOE32v937jQkrgRHWx5?=
 =?iso-8859-1?Q?OeLDmnaQjBCArmVGS1pfkzuajq4KDeKIahmr1GX7H4i+/kHPqOrQAhIx0P?=
 =?iso-8859-1?Q?n18HVbPZOeD8ooXorgp6Bvtgewq1Yk66vloIk5db6D3oVeNR1w+shpb5tR?=
 =?iso-8859-1?Q?2H8PwQgqg2cr48Ivw21H0gImIcHDf7KiCuMSbpt1CyUDwvMRWg595IcgPi?=
 =?iso-8859-1?Q?Lc4DfniH11E14Ly+AdY1e6/Kx8VnKgeD1NaSRcwJX8a62ClqRCM7vt9DvH?=
 =?iso-8859-1?Q?FOjEp2CvR+QDeP5WiFjwQVnG2HGpn1mgejp+pTIY9xcuOXNihAUA43qhhL?=
 =?iso-8859-1?Q?1qqzXwDJqLcCrQV8tf4Ymhml3nyNWAH4WegiAdtn/FeGQsWQtuiwWjPBDL?=
 =?iso-8859-1?Q?vibEZBK0QaIL4sYMXPxUtt/PKQmSB9imTAcAlEffGfGNINek2jJOM2fJ3Q?=
 =?iso-8859-1?Q?wMd8VfHN5dFuvA/4uGlybsWFO59i+oHyGHykxCsLlUT2UbQpIB3M7Lq5+/?=
 =?iso-8859-1?Q?0nF6KLW7K2xSF0VpYptVNSMcpCvzc//vzRWgNwkMe/9OHqHhJqE0ACxm7N?=
 =?iso-8859-1?Q?Fmd271tvtG+anseDJxnzglQEStX/tPREO9wmjHjDVs/PzMUXAqavS/hDDN?=
 =?iso-8859-1?Q?3M8X4nkawzVDydxoQcI8yaREUU4ewkrdRBz0ajT3gEhpmEXEyCIZ7mFpFa?=
 =?iso-8859-1?Q?uRT2P5opJc8KJ0rYQSziIWPfOJZsjAK+2akvHjzvOmJAF7+Rum0U/Oq1dW?=
 =?iso-8859-1?Q?vf+0CKzLYyNsoRkp7iha1C6l2dYirDvhR76AoZbmLCjSzboruphGblKO5h?=
 =?iso-8859-1?Q?I3/yu4+GVW+OU89a4UVgPiOAG9ts0yWWKFZvkMMPKc0WyvrW1WgU4FcS9B?=
 =?iso-8859-1?Q?HXwTeTXgKlmypblOk9DJan3jJGyFbOlE5iFGuDjcqDfldwmJoA7mY/1uYm?=
 =?iso-8859-1?Q?ntqRBMN5gFPybgdKuxLIb7H8MDiYloZb0331P23M95/66k4mnegYKDhINe?=
 =?iso-8859-1?Q?8EaoJxz5Upze2Vv5P1R0juuaB6gTyR9s5enrGkoaZNGOcrU05E4L2PKbSB?=
 =?iso-8859-1?Q?XeKeeIUFe0HOJXaAryln3tKo7kbA4Hu406eVlOejE/9Wpe683w+hHLrBJt?=
 =?iso-8859-1?Q?DhfFnpxsZ27stoBqzfwKBOmmD4osKMygon66HwN1tS5oVk0/lQ0x6nSNKb?=
 =?iso-8859-1?Q?t94AVs/UTd1mpaUfneBl0DgRKUNS6TqHdjz52daF0MJwoJWQBFMRAVwbKt?=
 =?iso-8859-1?Q?HD/ZN9va9a5Pbuq+Xo1DBu7WmLhU8YHPVOAyCfg7kwpIoHNx2wuHCeAKoJ?=
 =?iso-8859-1?Q?kNVN92tgJxwRWnLPtdtvTEu4pAhmhFJGEL3h0g/2EbAg6xUSaZWXbZ1Ln9?=
 =?iso-8859-1?Q?npxO2AF9gln0kPjcrDoiWijxa9SaFawrQBp8LB/MV7ICpKoQwk7ENDMMIU?=
 =?iso-8859-1?Q?qIpeztHRh+3HE6cQNURGDBMz+kAkeQYwdApcnNZgTC7D+qBlBTWmSHwIWQ?=
 =?iso-8859-1?Q?WQRsaKc/TEFrKEPWwmtdQC3sNfeXN6s=3D?=
X-Exchange-RoutingPolicyChecked: BlMpn6ZPoHRKEcwBO204NWeeiVuNUqpd31r+jG7res7/hVytuG2c4vPC+qODWfrAkB2fEf1UaRQE2R90jAVHEfwjJssBRctT7+Q7UsvqREn4KKLC+WjCbfxs1m5YF1sIuPFqKDPT7vAa86CkYgmdWSmH2l6B8VqwmLCD86y7YsB8pr1TQKHhfATt1UvtkkaTt+lSKdgC0lm1GzlBNYjY0DeIs6t/5A4BfeAvohilC4la3GHAmc9Hy+xlxo3nKZggIlJJc53JySipkjqvyDzJU1yWbOuTBDPVdtYIctjZJXmDXeSJT0zvaeWAu1Gf6LqpALu5ojRFhZpGxTZcPYHqFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8394d516-484b-4aca-41a6-08de8413f648
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:57:20.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNF9q3nue4D9QpMjUBLEJIE0CUuHE87WOi2lppfudE4wbM/JoUhRGbXFtjkbun96VBNJmoBNxXQh+DSaQDWjIc0BDFG1h/mW/G63CJrHb9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7652
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-268557-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B7CAE2A85D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:27:11AM +0100, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > Skip tail adjust tests in xskxceiver for SKB mode as it is not very
> > friendly for it. multi-buffer case does not work as xdp_rxq_info that is
> > registered for generic XDP does not report ::frag_size. The non-mbuf
> > path copies packet via skb_pp_cow_data() which only accounts for
> > headroom, leaving us with no tailroom and causing underlying XDP prog to
> > drop packets therefore.
> >
> > For multi-buffer test on other modes, change the amount of bytes we use
> > for growth, assume worst-case scenario and take care of headroom and
> > tailroom.
> >
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  .../selftests/bpf/prog_tests/test_xsk.c       | 21 ++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > index 7e38ec6e656b..a496f1784b66 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > @@ -2551,16 +2551,31 @@ int testapp_adjust_tail_shrink_mb(struct test_spec *test)
> >  
> >  int testapp_adjust_tail_grow(struct test_spec *test)
> >  {
> > +	if (test->mode == TEST_MODE_SKB)
> > +		return TEST_SKIP;
> > +
> >  	/* Grow by 4 bytes for testing purpose */
> >  	return testapp_adjust_tail(test, 4, MIN_PKT_SIZE * 2);
> >  }
> >  
> >  int testapp_adjust_tail_grow_mb(struct test_spec *test)
> >  {
> > +	u32 grow_size;
> > +
> > +	if (test->mode == TEST_MODE_SKB)
> > +		return TEST_SKIP;
> > +
> > +	/* worst case scenario is when underlying setup will work on 3k
> > +	 * buffers, let us account for it; given that we will use 6k as
> > +	 * pkt_len, expect that it will be broken down to 2 descs each
> > +	 * with 3k payload;
> > +	 *
> > +	 * 4k is truesize, 3k payload, 256 HR, 320 TR;
> > +	 */
> > +	grow_size = XSK_UMEM__MAX_FRAME_SIZE - XSK_UMEM__LARGE_FRAME_SIZE - 256 - 320;
> 
> nit: Use defines, XDP_PACKET_HEADROOM, and maybe
> SKB_DATA_ALIGN(sizeof(struct skb_shared_info))?

umm right, but the latter would have to be exposed via UAPI ?

