Return-Path: <netdev+bounces-261901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOlREru5oWlfwAQAu9opvQ
	(envelope-from <netdev+bounces-261901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:35:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B06E71B9E67
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 881A2300C80F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94C6329375;
	Fri, 27 Feb 2026 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMLYnCV9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B652EC0AD;
	Fri, 27 Feb 2026 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206317; cv=fail; b=CpaysbNbMm7CoC+UkQppcvAjFYNmUM5S39On2Buk8PqMJt5I6C4fOhB/5FMIImE+c7TzDLvQLhxYv1HfNkiN5GuanDJ/DJfwvMv4Si5bGk+PkGKCKfhoJotL2EufOKGWBtGO7BeKPupli9qAIATcp0k9mEzUZYcMTgU/OOFhh5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206317; c=relaxed/simple;
	bh=JIG/zHT69hTL2WklmjiQnLvlW906mPnILIoYqbklh2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IRy2yztlAX2pg/WFJQKdRRD/2p/Tksb3mpLm8oxxVzYx6tGtLbNXJUT6qgPXCriE6lX+xGigEYMkcSYJczRs9HO9QOh4k3rvbcQYx51JYeuPhlCuYH3qWRaeUfJ2afOY8NKWu66g0qE+P+OE799dlounqV8MN97dtPAe3WKRQP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMLYnCV9; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772206314; x=1803742314;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JIG/zHT69hTL2WklmjiQnLvlW906mPnILIoYqbklh2c=;
  b=dMLYnCV9oNZtVBBB+lzfN8qgBd6UYnzZq2D551Miay9u7xNaMEszCozO
   KdmZBJC8Nv5t+sL0XssqoqhGD32f3T2JT9/INrTVtcgon0WbYuMWh7DQ4
   vEixmjCTR7eIRy0nP0/EnS/Vhv1j3dLnDO/pJlsyS2SKsJpI4FstVcS/k
   7jvatIbVgM6ftF/uN8Vlc/oU7fT/EMYpDcmutGrzVbqxGuzwG7Wqvp1IN
   lR9o4b2k9JqdjPPI7tYHXVrruZ9pgXYWMhimFh6uCoAzpllMbaHsfi2Xs
   Y/syQWv3V6R+4kPMpaKHVxdulen6Nz+4tKcCj3spi2WtRpePCjGU1pEyF
   Q==;
X-CSE-ConnectionGUID: mOd8kORrSmaB0ephaCb0kQ==
X-CSE-MsgGUID: +4YD8fZeQeejm6n8AEmx4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73196938"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="73196938"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 07:31:53 -0800
X-CSE-ConnectionGUID: qOUb4U/8RHaniv67m/y5PA==
X-CSE-MsgGUID: KyyZUTNtQPexz6IDHS4kPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="215088814"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 07:31:50 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 07:31:49 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 07:31:49 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 07:31:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdnv8YH+Y4zVXkr1szLp2YsBhaSQedjF7yTUTHs0UtRCgOJGEzfgeuDxQfY70e2S7hfgbpjbSCo8KNYkwyVJhuv0wBEV8XFUH57JPxk0kaxikBVyTpzvY7OLRKOGxbWmJ+UF+43Hhv617SSwf3kXD42NrMuYfKNxV1Aez92JK7M9mZ8YWNRjKSngWzQjdpomACvSoUsYZnhbkD3doXqL6pwdZyrauQyY9Z0r5/yOqvKPFb1jflkrLVnbmY+bs4M47BhKOQM45x+zuChjKm23+8vwcGwz8m1okS15ZxOTmrDPISsGcNPrIC4oLcyScGDzQhaET25opVRt5JD7CWxagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6jh7Z8xOi74uHK6mtS9tbxkm2T5A/a47r7a10M98YY=;
 b=YIGe+tT6fwlZpXu8GrJNUZqw0N0+t9ZIl3xRGPUj2OPbF+9cYPJszh4NJY5bZ1FKa+kTk9MnOOTNJf4OHTgkXiN7CUBDgI1EAWr2aSSGnKCjnEzwY2+Uk9ZtvIoTILeZnnxZWzHl0JuftyYGU/Bw43dc1aU94Ci4Yr+u1ofUQn/r3ts+E0a3RlOCkx+lSAYtuoNKvBVF9MM0euIYb6bln9FnvE8VsXntWcqEUwU9lf1/6YLQ8Q/kcnErx7VQx2C6qA+wlLWgOQazf06wWGUBahREP/vSWnvY0w8af6a5qtekCaDtl5qBRBPG6+TSSMjbZg+AsGwDfjIBgPGkRiT43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS4PPF11E6CAE14.namprd11.prod.outlook.com (2603:10b6:f:fc02::c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Fri, 27 Feb
 2026 15:31:47 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 15:31:47 +0000
Date: Fri, 27 Feb 2026 16:31:27 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <bpf@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, "Vladimir
 Oltean" <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Andrii
 Nakryiko" <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Simon Horman
	<horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, "Bastien Curutchet (eBPF Foundation)"
	<bastien.curutchet@bootlin.com>, Tushar Vyavahare
	<tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>, Ricardo
 =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>, Eelco Chaudron
	<echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "Toke
 Hoiland-Jorgensen" <toke@redhat.com>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kselftest@vger.kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: Re: [PATCH bpf v3 0/9] Address XDP frags having negative tailroom
Message-ID: <aaG4z7ZIARBAzueO@boxer>
References: <20260217132450.1936200-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260217132450.1936200-1-larysa.zaremba@intel.com>
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS4PPF11E6CAE14:EE_
X-MS-Office365-Filtering-Correlation-Id: ac008dc9-0ada-4553-e9ab-08de7615518f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: WNGjzXenhKs+SUPoSyz6U9D4Y/kg3vg/Vi/qMP2e9cP3zevX7pe4GE/7m0CmzWbOhOxAUXGBqDriENsIpctiTgZOoYR1P9dLzMJGVSLdOkO3pBr7sdTgveBEMGY4tF8oXykdzMl259k0nWCW9rDvDtl7TGumZSnaemMlfOJIcbFHoQ+7+NIxiPz1ntRUGwdYkHIrqiMGuw/Ub5h6AS6YHYR4OQL5JHYUSGzw3hiAJWuXR5hx8fGpRhFoNRv5Krjnh4oXj0gBLxfU4oSgKOi0uqX4D6WpHZs+20iLMRdiriygQkm9UI4hQn3mwDYxTppNhF4kCqbxGNRl3PLG2+C9ljcrDOg8MrWGS2YBDMchDaWylkIOQwQ5+JrGE8qDR35Mo7Dfl+ZFog3AmX1BQttwRhjNsYDYxSqO4tbPvvIzAmTXeDB1VJIVR/WkL2atdIrnmjRh9RBaqXuTyUFK92fEGKC4CcNIMHR8ncf7sJZoQwMyPX1IDoCaDbkc+AqB5bYf9I30JRVOWOrFC/TSBqBDaZcChd/tqmY97TV0+7Cta1NMpNpS3dBdGvIbts7pYryk8ADzfLGXT/u6FfUBkhRq773N5FxWvr5JJQKPfmgGh883Aa03b0/I8sVqzEGtV3UhfPbadyjEdndcLj6GIntnxJD6wz4ZtDpXlOa7O6mLOwvweGysRrXR3Hooh5l+jlXYjN4/oHFgHh5P4Hv0qI6f0w714iHcE1QjJB+s4iAj1jE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EnjTBAjymR/Ca0M52BncY3wn4JnpWuIn9dRDqIq/2uOhHIIdxN3ZAePKMeBw?=
 =?us-ascii?Q?N955dbIjuMwGaE7iEELqEIxrJyZGTI8fohcy1TrjH0kvbLPDMScIJ523oqNC?=
 =?us-ascii?Q?Y4Ii5zm0busb0h3EVTX3nT1fRaewFmpqwnQzCvwmSgUS/1JLey3XrIJOD1rz?=
 =?us-ascii?Q?Xa1XUrQ77xxFCUyoA7qdIUkYebR2b4bOR491WENJUJ7TbpHlN7k8tqOTx4C6?=
 =?us-ascii?Q?5WQ0tEsG+c5GyegteXldP9jZv/BWBNtuikeWI3nvupTcasAKz0BdScpM6HDp?=
 =?us-ascii?Q?ltu2l6K+9UJJoYYfhMBgGh6pUFKskyT6k3uMfCLVJZXNpY9oInOM9gMbRUAd?=
 =?us-ascii?Q?q2dCDWjsaiRxbxtt6cfbvKiu0zj3JRR6Yso7prVR26zrdUa3v/5j7E6Ff+xr?=
 =?us-ascii?Q?xVUTYVEM1hPFnYyGg6I/+25eUagbllP9e+uNfoHkYEHcTgfdCB+FoRe7iM0I?=
 =?us-ascii?Q?76NQ3F50aCngAzQnBkyVOrsXVjGxx0gAfOX559wPvWMhMO4mtxR1y86Cz4Mn?=
 =?us-ascii?Q?QDrHH5z9CJ6Yekv1qg3kVGokbScqaRFsPcufwSnQ0G/3F2+lWMIVtr+VnvqB?=
 =?us-ascii?Q?5gqK4KVCk5hPqKDjgOAh81XKrXfJfc+GX2oDIFRMWrlR93Hw1QDFDplUnKz0?=
 =?us-ascii?Q?PAIvsFtDqzTV+ke7lbI/xj8Jo047W5DacFmiVWIuZCTviCFw4WzSqILKBN/J?=
 =?us-ascii?Q?MUs5yfF2N4UaVoqLmVqqgumkT3OoglI24Y9eOX5UDA1aBqZZ2HYHpfvtw3aR?=
 =?us-ascii?Q?LAc5xthSqHD/JbR9qagAmfZVAw+1Oiuuw2Ep6ItvbfAoPzosv1v9i33GqGbw?=
 =?us-ascii?Q?jmBeb4zziPkxaCemFyHsvO+/X3LZQOJLn3E20/PRSe6WpoHw6z3jGUxAvjCW?=
 =?us-ascii?Q?bm8Vv4uNowRDdArs9uDwbLJ+HY02GKadf2ifSc7K2vNFQiP37Y+6Z2jVUIhP?=
 =?us-ascii?Q?RmQ9wKL7WoWLAqahmiaHa/mz32vJarOk7mbMiKdEI0KYV6E389YBxV1S+657?=
 =?us-ascii?Q?88Sk4jCx3KyNut9fahCwL6Yz9q2BcpFbrZyCaZYKAR5FjRYQf05CrIneLE0w?=
 =?us-ascii?Q?KWktCEdjBLwh8n+QEf/XNwktEYpGNLohbU1rRNh22Kjq9fS/Osf9uVKcN8eV?=
 =?us-ascii?Q?7VB+H0RVuHSMb3o20075/dfcNDV9ucKUmgahCx/Z2nmIZG9d+1oalShgyAuz?=
 =?us-ascii?Q?Lzhy6fN4muqxPGJTI4atsWqJMAis0pFi5pVlx4RekC2BEpbdTSy0KYmSu9s5?=
 =?us-ascii?Q?LRbW65eMnj2trM4QpfehyolrsSFDiBkOMvQot5JCuvvTXDRTH5RxAmfGerJK?=
 =?us-ascii?Q?obFv4uEjR+i+VfuwAopQT2koj1FcGUQ0QfH5jtgPhW/mOSSIOvrn3ZQCDY3Z?=
 =?us-ascii?Q?iJPEn1vvdHzKeoaLZSTHBGHT2aAqSZLbCacB7E5U+lo6CR2PHVj+/LBngs9g?=
 =?us-ascii?Q?lDbWVdIu0QgIiFRY2LKhIdNufEp8XkPvklvPY7rebcgoyxI6obhb+HE/FWwQ?=
 =?us-ascii?Q?W0+GzzpgDs1mcREwVG5uqAPM+od5YB5D7N0Nq0/9qQTZzEiAhfz8+/S4ZHP9?=
 =?us-ascii?Q?xaMhGqNXlW41EEV+XUJIYBMTBildeIMnLh8SNKgnXjjqlGgyKVH2OkE3rz/0?=
 =?us-ascii?Q?8Ejwh1bTzuuyAOPWxFLIwwumsGNE5GayYWCBMv5P/8l+jqmizDxoSZ+6y439?=
 =?us-ascii?Q?4qg+pnTkJnE+Y8Tiw/poJ541E9TY7EZ9nDl5qItlM59v3/VsoR//0iQSpl+G?=
 =?us-ascii?Q?8m0uASfFKMlMCgpF/EI9GuSdMbiPmi0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac008dc9-0ada-4553-e9ab-08de7615518f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:31:47.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnEUqNPL85WE/twmalfJj8W2HonDPPGuVlbNuNp8uPFP6VQRq3sNrPjR4H3MgvLSIUvfaGtqR9XEbu7JTSBlqMa8N/XRXqcucF1aJUBvjrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF11E6CAE14
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261901-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,test_xsk.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org,nvidia.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B06E71B9E67
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 02:24:38PM +0100, Larysa Zaremba wrote:
> Aside from the issue described below, tailroom calculation does not account
> for pages being split between frags, e.g. in i40e, enetc and
> AF_XDP ZC with smaller chunks. These series address the problem by
> calculating modulo (skb_frag_off() % rxq->frag_size) in order to get
> data offset within a smaller block of memory. Please note, xskxceiver
> tail grow test passes without modulo e.g. in xdpdrv mode on i40e,
> because there is not enough descriptors to get to flipped buffers.
> 
> Many ethernet drivers report xdp Rx queue frag size as being the same as
> DMA write size. However, the only user of this field, namely
> bpf_xdp_frags_increase_tail(), clearly expects a truesize.
> 
> Such difference leads to unspecific memory corruption issues under certain
> circumstances, e.g. in ixgbevf maximum DMA write size is 3 KB, so when
> running xskxceiver's XDP_ADJUST_TAIL_GROW_MULTI_BUFF, 6K packet fully uses
> all DMA-writable space in 2 buffers. This would be fine, if only
> rxq->frag_size was properly set to 4K, but value of 3K results in a
> negative tailroom, because there is a non-zero page offset.
> 
> We are supposed to return -EINVAL and be done with it in such case,
> but due to tailroom being stored as an unsigned int, it is reported to be
> somewhere near UINT_MAX, resulting in a tail being grown, even if the
> requested offset is too much(it is around 2K in the abovementioned test).
> This later leads to all kinds of unspecific calltraces.
> 
> [ 7340.337579] xskxceiver[1440]: segfault at 1da718 ip 00007f4161aeac9d sp 00007f41615a6a00 error 6
> [ 7340.338040] xskxceiver[1441]: segfault at 7f410000000b ip 00000000004042b5 sp 00007f415bffecf0 error 4
> [ 7340.338179]  in libc.so.6[61c9d,7f4161aaf000+160000]
> [ 7340.339230]  in xskxceiver[42b5,400000+69000]
> [ 7340.340300]  likely on CPU 6 (core 0, socket 6)
> [ 7340.340302] Code: ff ff 01 e9 f4 fe ff ff 0f 1f 44 00 00 4c 39 f0 74 73 31 c0 ba 01 00 00 00 f0 0f b1 17 0f 85 ba 00 00 00 49 8b 87 88 00 00 00 <4c> 89 70 08 eb cc 0f 1f 44 00 00 48 8d bd f0 fe ff ff 89 85 ec fe
> [ 7340.340888]  likely on CPU 3 (core 0, socket 3)
> [ 7340.345088] Code: 00 00 00 ba 00 00 00 00 be 00 00 00 00 89 c7 e8 31 ca ff ff 89 45 ec 8b 45 ec 85 c0 78 07 b8 00 00 00 00 eb 46 e8 0b c8 ff ff <8b> 00 83 f8 69 74 24 e8 ff c7 ff ff 8b 00 83 f8 0b 74 18 e8 f3 c7
> [ 7340.404334] Oops: general protection fault, probably for non-canonical address 0x6d255010bdffc: 0000 [#1] SMP NOPTI
> [ 7340.405972] CPU: 7 UID: 0 PID: 1439 Comm: xskxceiver Not tainted 6.19.0-rc1+ #21 PREEMPT(lazy)
> [ 7340.408006] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-5.fc42 04/01/2014
> [ 7340.409716] RIP: 0010:lookup_swap_cgroup_id+0x44/0x80
> [ 7340.410455] Code: 83 f8 1c 73 39 48 ba ff ff ff ff ff ff ff 03 48 8b 04 c5 20 55 fa bd 48 21 d1 48 89 ca 83 e1 01 48 d1 ea c1 e1 04 48 8d 04 90 <8b> 00 48 83 c4 10 d3 e8 c3 cc cc cc cc 31 c0 e9 98 b7 dd 00 48 89
> [ 7340.412787] RSP: 0018:ffffcc5c04f7f6d0 EFLAGS: 00010202
> [ 7340.413494] RAX: 0006d255010bdffc RBX: ffff891f477895a8 RCX: 0000000000000010
> [ 7340.414431] RDX: 0001c17e3fffffff RSI: 00fa070000000000 RDI: 000382fc7fffffff
> [ 7340.415354] RBP: 00fa070000000000 R08: ffffcc5c04f7f8f8 R09: ffffcc5c04f7f7d0
> [ 7340.416283] R10: ffff891f4c1a7000 R11: ffffcc5c04f7f9c8 R12: ffffcc5c04f7f7d0
> [ 7340.417218] R13: 03ffffffffffffff R14: 00fa06fffffffe00 R15: ffff891f47789500
> [ 7340.418229] FS:  0000000000000000(0000) GS:ffff891ffdfaa000(0000) knlGS:0000000000000000
> [ 7340.419489] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7340.420286] CR2: 00007f415bfffd58 CR3: 0000000103f03002 CR4: 0000000000772ef0
> [ 7340.421237] PKRU: 55555554
> [ 7340.421623] Call Trace:
> [ 7340.421987]  <TASK>
> [ 7340.422309]  ? softleaf_from_pte+0x77/0xa0
> [ 7340.422855]  swap_pte_batch+0xa7/0x290
> [ 7340.423363]  zap_nonpresent_ptes.constprop.0.isra.0+0xd1/0x270
> [ 7340.424102]  zap_pte_range+0x281/0x580
> [ 7340.424607]  zap_pmd_range.isra.0+0xc9/0x240
> [ 7340.425177]  unmap_page_range+0x24d/0x420
> [ 7340.425714]  unmap_vmas+0xa1/0x180
> [ 7340.426185]  exit_mmap+0xe1/0x3b0
> [ 7340.426644]  __mmput+0x41/0x150
> [ 7340.427098]  exit_mm+0xb1/0x110
> [ 7340.427539]  do_exit+0x1b2/0x460
> [ 7340.427992]  do_group_exit+0x2d/0xc0
> [ 7340.428477]  get_signal+0x79d/0x7e0
> [ 7340.428957]  arch_do_signal_or_restart+0x34/0x100
> [ 7340.429571]  exit_to_user_mode_loop+0x8e/0x4c0
> [ 7340.430159]  do_syscall_64+0x188/0x6b0
> [ 7340.430672]  ? __do_sys_clone3+0xd9/0x120
> [ 7340.431212]  ? switch_fpu_return+0x4e/0xd0
> [ 7340.431761]  ? arch_exit_to_user_mode_prepare.isra.0+0xa1/0xc0
> [ 7340.432498]  ? do_syscall_64+0xbb/0x6b0
> [ 7340.433015]  ? __handle_mm_fault+0x445/0x690
> [ 7340.433582]  ? count_memcg_events+0xd6/0x210
> [ 7340.434151]  ? handle_mm_fault+0x212/0x340
> [ 7340.434697]  ? do_user_addr_fault+0x2b4/0x7b0
> [ 7340.435271]  ? clear_bhb_loop+0x30/0x80
> [ 7340.435788]  ? clear_bhb_loop+0x30/0x80
> [ 7340.436299]  ? clear_bhb_loop+0x30/0x80
> [ 7340.436812]  ? clear_bhb_loop+0x30/0x80
> [ 7340.437323]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 7340.437973] RIP: 0033:0x7f4161b14169
> [ 7340.438468] Code: Unable to access opcode bytes at 0x7f4161b1413f.
> [ 7340.439242] RSP: 002b:00007ffc6ebfa770 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> [ 7340.440173] RAX: fffffffffffffe00 RBX: 00000000000005a1 RCX: 00007f4161b14169
> [ 7340.441061] RDX: 00000000000005a1 RSI: 0000000000000109 RDI: 00007f415bfff990
> [ 7340.441943] RBP: 00007ffc6ebfa7a0 R08: 0000000000000000 R09: 00000000ffffffff
> [ 7340.442824] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [ 7340.443707] R13: 0000000000000000 R14: 00007f415bfff990 R15: 00007f415bfff6c0
> [ 7340.444586]  </TASK>
> [ 7340.444922] Modules linked in: rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_intel vfat fat kvm snd_pcm irqbypass rapl iTCO_wdt snd_timer intel_pmc_bxt iTCO_vendor_support snd ixgbevf virtio_net soundcore i2c_i801 pcspkr libeth_xdp net_failover i2c_smbus lpc_ich failover libeth virtio_balloon joydev 9p fuse loop zram lz4hc_compress lz4_compress 9pnet_virtio 9pnet netfs ghash_clmulni_intel serio_raw qemu_fw_cfg
> [ 7340.449650] ---[ end trace 0000000000000000 ]---
> 
> The issue can be fixed in all in-tree drivers, but we cannot just trust OOT
> drivers to not do this. Therefore, make tailroom a signed int and produce a
> warning when it is negative to prevent such mistakes in the future.
> 
> The issue can also be easily reproduced with ice driver, by applying
> the following diff to xskxceiver and enjoying a kernel panic in xdpdrv mode:
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 5af28f359cfd..042d587fa7ef 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -2541,8 +2541,8 @@ int testapp_adjust_tail_grow_mb(struct test_spec *test)
>  {
>         test->mtu = MAX_ETH_JUMBO_SIZE;
>         /* Grow by (frag_size - last_frag_Size) - 1 to stay inside the last fragment */
> -       return testapp_adjust_tail(test, (XSK_UMEM__MAX_FRAME_SIZE / 2) - 1,
> -                                  XSK_UMEM__LARGE_FRAME_SIZE * 2);
> +       return testapp_adjust_tail(test, XSK_UMEM__MAX_FRAME_SIZE * 100,
> +                                  6912);
>  }
> 
>  int testapp_tx_queue_consumer(struct test_spec *test)
> 
> If we print out the values involved in the tailroom calculation:
> 
> tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
> 
> 4294967040 = 3456 - 3456 - 256
> 
> I personally reproduced and verified the issue in ice and i40e,
> aside from WiP ixgbevf implementation.

May I ask what was the testing approach against ice on your side?  When I
run test_xsk.sh against tree with your series applied, I get a panic shown
below [1]. This comes from a test that modifies descriptor count on rings
and the trick is that it might be passing when running as a standalone
test but in the test suite it causes problems. It comes from a fact that
we copy xdp_rxq between old and new ice_rx_ring, core sees the xdp_rxq
already registered, does unregister by itself but it bails out on
page_pool pointer being invalid (as these two xdp_rxqs pointed to same pp
and it got destroyed). So small diff below [0] allows me to go through
xskxceiver test suite executed from test_xsk.sh.

Thanks,
MF

[0]:
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 969d4f8f9c02..06986adb2005 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3328,6 +3328,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
 		rx_rings[i].desc = NULL;
 		rx_rings[i].xdp_buf = NULL;
+		xdp_rxq_info_unreg(&rx_rings[i].xdp_rxq);
 
 		/* this is to allow wr32 to have something to write to
 		 * during early allocation of Rx buffers

[1]:
[ 2596.560462] BUG: kernel NULL pointer dereference, address: 0000000000000008
[ 2596.568466] #PF: supervisor read access in kernel mode
[ 2596.574686] #PF: error_code(0x0000) - not-present page
[ 2596.580942] PGD 118694067 P4D 0
[ 2596.585322] Oops: Oops: 0000 [#1] SMP NOPTI
[ 2596.590694] CPU: 2 UID: 0 PID: 5117 Comm: xskxceiver Tainted: G    B   W  O        6.19.0+ #198 PREEMPT(full)
[ 2596.602065] Tainted: [B]=BAD_PAGE, [W]=WARN, [O]=OOT_MODULE
[ 2596.609049] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C620.86B.01.01.0004.2110190142 10/19/2021
[ 2596.621632] RIP: 0010:xdp_unreg_mem_model+0x86/0xc0
[ 2596.628195] Code: 0f 44 d7 f6 c2 01 75 37 41 0f b7 4c 24 16 48 89 ce 48 f7 de 3b 5c 32 04 75 1d 48 89 d3 48 29 cb 48 85 d2 74 2f e8 9a 9e 4c ff <48> 8b 7b 08 5b 5d 41 5c e9 6d eb 00 00 48 8b 12 f6 c2 01 74 d5 48
[ 2596.650847] RSP: 0018:ffa000001ffe3a90 EFLAGS: 00010246
[ 2596.658128] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ff1100808e308ea1
[ 2596.667403] RDX: ff1100808e308ea1 RSI: 00000000000001cc RDI: ff11000130150000
[ 2596.676719] RBP: 0000000000000000 R08: 0000000000001000 R09: 0000000000000001
[ 2596.686060] R10: ff1100011084a2c0 R11: 0000000000000000 R12: ff1100011541ce40
[ 2596.695445] R13: 0000000000001000 R14: 0000000000000000 R15: 0000000000000000
[ 2596.704866] FS:  00007f6044013c40(0000) GS:ff11007efbb1b000(0000) knlGS:0000000000000000
[ 2596.715336] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2596.723510] CR2: 0000000000000008 CR3: 00000001e9052004 CR4: 0000000000773ef0
[ 2596.733162] PKRU: 55555554
[ 2596.738407] Call Trace:
[ 2596.743398]  <TASK>
[ 2596.748045]  __xdp_rxq_info_reg+0xb7/0xf0
[ 2596.755108]  ice_vsi_cfg_rxq+0x668/0x6b0 [ice]
[ 2596.762499]  ice_vsi_cfg_rxqs+0x29/0x80 [ice]
[ 2596.769555]  ice_up+0xe/0x30 [ice]
[ 2596.775673]  ice_set_ringparam+0x662/0x7e0 [ice]
[ 2596.783066]  ethtool_set_ringparam+0xb3/0x110
[ 2596.790189]  __dev_ethtool+0x1200/0x2d90
[ 2596.796916]  ? update_se+0xc1/0x120
[ 2596.803224]  ? update_load_avg+0x73/0x220
[ 2596.810079]  ? xas_load+0x9/0xc0
[ 2596.816172]  ? xa_load+0x71/0xb0
[ 2596.822273]  ? avc_has_extended_perms+0xcf/0x4a0
[ 2596.829822]  ? __kmalloc_cache_noprof+0x11a/0x400
[ 2596.837493]  dev_ethtool+0xa6/0x170
[ 2596.843976]  dev_ioctl+0x2d9/0x510
[ 2596.850388]  sock_do_ioctl+0xa8/0x110
[ 2596.857078]  sock_ioctl+0x234/0x320
[ 2596.863614]  __x64_sys_ioctl+0x92/0xe0
[ 2596.870444]  do_syscall_64+0xa4/0xc80
[ 2596.877212]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[ 2596.885426] RIP: 0033:0x7f6043f24e1d
[ 2596.892186] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
[ 2596.917864] RSP: 002b:00007ffd329f5e50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 2596.929028] RAX: ffffffffffffffda RBX: 00007ffd329f6208 RCX: 00007f6043f24e1d
[ 2596.939757] RDX: 00007ffd329f5ed0 RSI: 0000000000008946 RDI: 0000000000000013
[ 2596.950460] RBP: 00007ffd329f5ea0 R08: 0000000000000000 R09: 0000000000000007
[ 2596.961597] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
[ 2596.972256] R13: 0000000000000000 R14: 000055a88e016338 R15: 00007f6044100000
[ 2596.982917]  </TASK>
[ 2596.988534] Modules linked in: ice(O) ipmi_ssif 8021q garp stp mrp llc intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp nls_iso8859_1 kvm_intel kvm irqbypass mei_me ioatdma mei wmi dca ipmi_si ipmi_msghandler acpi_power_meter acpi_pad input_leds hid_generic ghash_clmulni_intel idpf i40e libeth_xdp libeth ahci libie libie_fwlog libie_adminq libahci aesni_intel gf128mul [last unloaded: irdma]
[ 2597.040161] CR2: 0000000000000008
[ 2597.046911] ---[ end trace 0000000000000000 ]---
[ 2597.117161] RIP: 0010:xdp_unreg_mem_model+0x86/0xc0
[ 2597.125432] Code: 0f 44 d7 f6 c2 01 75 37 41 0f b7 4c 24 16 48 89 ce 48 f7 de 3b 5c 32 04 75 1d 48 89 d3 48 29 cb 48 85 d2 74 2f e8 9a 9e 4c ff <48> 8b 7b 08 5b 5d 41 5c e9 6d eb 00 00 48 8b 12 f6 c2 01 74 d5 48
[ 2597.151379] RSP: 0018:ffa000001ffe3a90 EFLAGS: 00010246
[ 2597.160243] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ff1100808e308ea1
[ 2597.171798] RDX: ff1100808e308ea1 RSI: 00000000000001cc RDI: ff11000130150000
[ 2597.182587] RBP: 0000000000000000 R08: 0000000000001000 R09: 0000000000000001
[ 2597.193333] R10: ff1100011084a2c0 R11: 0000000000000000 R12: ff1100011541ce40
[ 2597.204055] R13: 0000000000001000 R14: 0000000000000000 R15: 0000000000000000
[ 2597.214732] FS:  00007f6044013c40(0000) GS:ff11007efbb1b000(0000) knlGS:0000000000000000
[ 2597.226440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2597.235842] CR2: 0000000000000008 CR3: 00000001e9052004 CR4: 0000000000773ef0
[ 2597.246692] PKRU: 55555554
[ 2597.253088] note: xskxceiver[5117] exited with irqs disabled

> 
> v3->v2:
> * unregister XDP RxQ info for subfunction in ice
> * remove rx_buf_len variable in ice
> * add missing ifdefed empty definition xsk_pool_get_rx_frag_step()
> * move xsk_pool_get_rx_frag_step() call from idpf to libeth
> * simplify conditions when determining frag_size in idpf
> * correctly init xdp_frame_sz for non-main VSI in i40e
> 
> v1->v2:
> * add modulo to calculate offset within chunk
> * add helper for AF_XDP ZC queues
> * fix the problem in ZC mode in i40e, ice and idpf
> * verify solution in i40e
> * fix RxQ info registering in i40e
> * fix splitq handling in idpf
> * do not use word truesize unless the value used is named trusize
> 
> Larysa Zaremba (9):
>   xdp: use modulo operation to calculate XDP frag tailroom
>   xsk: introduce helper to determine rxq->frag_size
>   ice: fix rxq info registering in mbuf packets
>   ice: change XDP RxQ frag_size from DMA write length to xdp.frame_sz
>   i40e: fix registering XDP RxQ info
>   i40e: use xdp.frame_sz as XDP RxQ info frag_size
>   libeth, idpf: use truesize as XDP RxQ info frag_size
>   net: enetc: use truesize as XDP RxQ info frag_size
>   xdp: produce a warning when calculated tailroom is negative
> 
>  drivers/net/ethernet/freescale/enetc/enetc.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c  | 40 +++++++++++---------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c  |  5 ++-
>  drivers/net/ethernet/intel/ice/ice_base.c    | 33 +++++-----------
>  drivers/net/ethernet/intel/ice/ice_txrx.c    |  3 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c     |  3 ++
>  drivers/net/ethernet/intel/idpf/xdp.c        |  6 ++-
>  drivers/net/ethernet/intel/idpf/xsk.c        |  1 +
>  drivers/net/ethernet/intel/libeth/xsk.c      |  1 +
>  include/net/libeth/xsk.h                     |  3 ++
>  include/net/xdp_sock_drv.h                   | 10 +++++
>  net/core/filter.c                            |  6 ++-
>  12 files changed, 66 insertions(+), 47 deletions(-)
> 
> -- 
> 2.52.0
> 

