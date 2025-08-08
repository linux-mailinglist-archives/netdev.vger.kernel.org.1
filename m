Return-Path: <netdev+bounces-212170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723CB1E8E1
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D1C18C3A86
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44957279DAD;
	Fri,  8 Aug 2025 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kf8TH+Tn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99719275869
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658301; cv=fail; b=r5uPu/bnOl6qpXjA600+5Szf9RQf3WT1WoHX56J0kbFXUu80z9SQGYH0PaLsFnA+YhXKmlWoXUnapmgMGRxHxETmhTOA1HZWxbaqZKv8yKpbGhKMt6JGkwIhEcHe8Fb/3BAUjB39t8X+5Kc5ZvCngFVWuUOlX0zTm6XzKUN7TVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658301; c=relaxed/simple;
	bh=ptH13QyZJsLPBHmx0iTNqTWm9MXqlxHoehp9aZLTJ7o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hy7EWtUYdUJe40ztb9B12ainZvsK9ArQ2DPFluD2u49aCG2Sz4N915DFXP5z26F5Kzy/vYI0nH6sFdxy6o5278TTmfXn5Ea7fBwy+LT9Ewt93E4DPBbgBFgfh5UA3BF3yQL42uO3xsP9geocqUxGyp3wSp6p/ump2o/QoXki46w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kf8TH+Tn; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754658299; x=1786194299;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ptH13QyZJsLPBHmx0iTNqTWm9MXqlxHoehp9aZLTJ7o=;
  b=Kf8TH+TnhHHiFzUiUaQlQp4ujqQQy47mfS0l52iER61vFNMqHi1r5XyJ
   YRN3+5gcdw6+oyFJYr8wNHgQCgCtyQeH/pmHMSfIj+4Nb9M41Tsa+ZYBL
   jgNYbevi0AMlM9X7ahnjdir18A1PFUnAezSPdQ5XgANkD/mAbSFZERl0Q
   O5j3JUhCgxEgsIj/kDbiztugFGrSNofAa+zBtsQ7dkFTMROTnFzLHIAwI
   KdAzCoZcqT80nWge0jBSB8la3KzCcAivzz3OzeKvEFZS+fLLxOYoqmeid
   SqaPOciqjTMknrNk/j/Pt0I6mlDgDmWfJMpf58RSXV1Dfh3k2mvAGWDIH
   g==;
X-CSE-ConnectionGUID: 6MdF5qKmSiWZd8dt9rODfw==
X-CSE-MsgGUID: iO+K4HPwRDuLpKF/2MnFMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="44596858"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="44596858"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 06:04:58 -0700
X-CSE-ConnectionGUID: dPiPuk1sSL2RF0p28ym+XA==
X-CSE-MsgGUID: gUrABcy6QhKZjjE4o2btCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="202497786"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 06:04:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 06:04:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 06:04:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.77)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 06:04:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkhB3kYPqV3LX/L7a8CwG+6C3J36/pK8vOs7FEXtW6XuKyeqZsOre4Sd2BMZ+9luhBmzs+VjH/98Zh0/WjFNBiBFO4eeEWrX0kJFEhxXKAlTI7oPiNq0vBDeSbSeBI0wB+EM8FQ7CQanNxk8eXSyYLURcw4Ir61OKjQELlpVgAkYtaGEADO0d86M6YDA9po8D3SKZiKbFV0X+WTwOH8FlDKjKqbhuaRsXa0+6ntjWemNc1IzKgjVmSE/J66AhNn5yqFWqJr8dayTxTrx+0JAMgK65OchvFznei/sbOx7QwzBmYNHdnvZzfU09aCmHeoZUkY6my74iC2rAilYOtr4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5QtdnT8RJR8X3ndqmoQVtSOxxmg7A7EsCJIe3qiYLg=;
 b=KFiDKi7Q89nQuOI+cUTKZECgRAuPbAbPpPTPChH0yhe3/SmRbORhYOk3+PwnEtLZ4TJRJC346OdLvgRtnUKYRlN0hZHtQ2i4RiIXFRiZxl/XJebMCNx5sz8S9EWekOOBNEOsrrJIBoCbM3vtaIMW+/JXLs8Fp3I1At0i1Cnsv4KxPXMAQEIXcoeqeUpNtUXmyf8LOtITVx3naLhgd9pIXGUUtH2JSaKfuQNVLAgX6gDrhVMbenmPIFfL//aKbx79lSO6CpS3LXOv0w9zV0/m+k9TVdQCp3cjrtzqo8bD+bvZQknlLPxyAUGgxgviQkc4S2Eday+7XagP0WkVsvBq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.18; Fri, 8 Aug 2025 13:04:55 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 13:04:55 +0000
Date: Fri, 8 Aug 2025 15:04:43 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Jacob Keller <jacob.e.keller@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <maciej.fijalkowski@intel.com>,
	<aleksander.lobakin@intel.com>, <larysa.zaremba@intel.com>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<anthony.l.nguyen@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 3/3] ice: switch to Page Pool
Message-ID: <aJX168tInG4tFk5j@localhost.localdomain>
References: <20250704161859.871152-1-michal.kubiak@intel.com>
 <20250704161859.871152-4-michal.kubiak@intel.com>
 <53c62d9c-f542-4cf3-8aeb-a1263e05acad@intel.com>
 <aJXiP-_ZUfBErhAv@localhost.localdomain>
 <ee6af42d-b274-4079-8a8b-35ec8d500c1c@molgen.mpg.de>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee6af42d-b274-4079-8a8b-35ec8d500c1c@molgen.mpg.de>
X-ClientProxiedBy: DU7PR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::8) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DM6PR11MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd74e81-b694-4455-93b4-08ddd67c2b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFpKdWtPYWYyejRNK3RuOXV1MWdvV3lNWGw2akRTS0I3ZkxQWUpPeTNmRHlE?=
 =?utf-8?B?bGpXU3lGcEVNR0RCWGJHZmdoNmFKRzV6V3FLeWFGL0dZY2s4WDQzR05wVzU0?=
 =?utf-8?B?ZFBERU1MZzZnVUl3QnZvelNPWWd3WHp3SkRtR3c5NEEzbHppV25IVjFjekdm?=
 =?utf-8?B?R3ZlalFiOXhiU0ZqWEkwSStURVZ1SW5zdjdPRld0RkR4Um1SOHVCVnJRMUlE?=
 =?utf-8?B?U2daU2N6TDF6bXFaU1ZLVnJ5VDdDQjNOYWM0NDZVUnYrc2hYNEpKS0QzKzJ1?=
 =?utf-8?B?VmxqQXptcndxM0duRzhjVmJTUjJhVERyaTVDT2V6RXk4aGRhM2dNM05qSWo5?=
 =?utf-8?B?VzZPc2Yyb2Zjb01FK0FObXVZbTJBNHF2aGx3cW9lY1JHYlp2U09FWnJGSnpL?=
 =?utf-8?B?SnBtV2JLNUVCbVNEY3BvSmpWbVdubU13REgrNjBDbXA3NkRmUGtPV1E5NTBG?=
 =?utf-8?B?VHcrMS84WTBaWjZuWDRKNEZTNXM5dTZGd1pjd25LeVZHMlhaZEZyMnVXaUdu?=
 =?utf-8?B?RVVTWGhjTjRSR3JJM1hSeURxVkFoMVNUVmV5bjhnOGY0OTdpU0dEazMvbE1B?=
 =?utf-8?B?ZXpCZ3FaVVMrV0t4dUg0cmxkUmFlZDkzR3dSRHp1ek5qVGp2eXZqazRkYzQx?=
 =?utf-8?B?RmJHbkRYTzNrRE90Wll1d2x2ZjhsMllqWmE3c3BqMGVzMFRGSGIxUzZFRGdV?=
 =?utf-8?B?UUd4MGdEcVRkUjZFNDhLKzN4QkRsMHRWU0piTXJEbDVDZVo4WHJ2OHEvdGRi?=
 =?utf-8?B?MUtmRkU5VHFBa2V3c05iYWFLZ2hRcjlDRkNkTHRqbU9nb3Yza0xvdnVhWlpV?=
 =?utf-8?B?ZUphOXdQYXlHMHFRdjhlSnlPNTVpeUpJWjJYRVkrY1ozb3FGdmw4SFcxVmhr?=
 =?utf-8?B?U3poeDFNNVU4bjJtaVFBZFdxWWxRc2dnWFZSMTE4SE14eVVNci9MSUhUWWZL?=
 =?utf-8?B?Rk53c2t2RHNBdlprYlVOZFNqZ3NkeEVERFk2dGtvT1RxYktzY3k5VTZ0STdI?=
 =?utf-8?B?YVhXRkNiaXZsbUttNG15Z3A0YUdLV2tiNUdsT2RuaGdxbWp6NDFZOFVPL0sz?=
 =?utf-8?B?K29MeEk3bzdGT0hyQldDdXJVRHBkelFzamtEWnMvbmZUZ05oUFhlWlhBOXFQ?=
 =?utf-8?B?SnlOYWtWZHBSRmo1VHMzWDI5UzZHa2M5YWVTOXNML2NPZzZDREp5eWdUY3FY?=
 =?utf-8?B?WU5mWHN6Rm5KdzMvYnhGY2JBVHpFNUY3NkRNOTl0ZFpJUzg5dCtJbndSL3VO?=
 =?utf-8?B?T0tieWgvQnQvamZkcnp0N1pyTi8zY3JHbEMybkdRVHp3QUE5YzRVMGIxMldx?=
 =?utf-8?B?NFhqbDB2cldHN1NNejhUYitKUmx1ck54NXpkVnJIV0QrZVpoWmJsNmF4dnM5?=
 =?utf-8?B?Q1FBNm1icWFkb0NOM3FwSSt4RmlxV0dMcHNzanl3R2dYVGVFRll2YXZwQmpO?=
 =?utf-8?B?NWp4N1p6aXRVZ2laLzJmV0Z4S0pXMHl4WW5aRmoxRGN1c2ZMUnFPTXBDRVZ1?=
 =?utf-8?B?VDNINHdGYy91K2pMS0NGWnNPRFlkaWl2a20xTjBNMjErYTNPSy8yWklaSExV?=
 =?utf-8?B?UGlzM2phSHlTU1JiRjBqVG5NcDB2QkZ2QWlmMnphTmx5ODkzU2Z5azFJTjJm?=
 =?utf-8?B?Z1dqN3NaeEFVTE9XWHphT1VNWktTNEN2NHhibnp5YmZlN3NCT3M0c1FkRmR2?=
 =?utf-8?B?WkQ0b0JrUjZtNnRhckJ4L2kwUzNTV1hsN0ZKSHhSYldZeVVJMHZRNVV0SnJ4?=
 =?utf-8?B?L1hLWXM3L2Vsd1J5d1h3SzdmY1VBMUh4Z3REempuM1liZ2lIdEJJV1FIdzJy?=
 =?utf-8?B?N3ZWUEx0OGhQQlprZ2RNM0s2KzQyek03Z1hScWlJU2lyMTlTRDJCeXZ6QS9j?=
 =?utf-8?B?L05vQ2RzNlh4azB2NUJFVHRvL1Y1UFIxdU5sYkR0Y0k5UzdEZFdCdjExZUg2?=
 =?utf-8?Q?kk8R/lnIAc0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0d4SzFhU2VCR0NJbVByemgrS1dtaXhMb09RcndqbzNjeXpQZjVYVFJBNXlS?=
 =?utf-8?B?cGlzTGs5ZDZaTnFkZ25xYThDbzFKa29XeGFGS05NVGpRNlRaQjh4NE9VRm5B?=
 =?utf-8?B?QUVSV2JveCtjeWM0cXV5bzRNd2FHRVk0Y0c2TEhiS0dpRVhUK2JRYldmRE5k?=
 =?utf-8?B?UGg5YTRNeDRhaGlmNmg2ZGtEQWI1dFpiVGxlSjE3V1NHblZqQ2lkY3ROWHRO?=
 =?utf-8?B?aGZQWHVjQmxpOVoreEIrc3NXY2xGbWZDcy83UDZ0ZVpQRjRIQnZ1bEJabnRD?=
 =?utf-8?B?bnN4SUhwc1YxNklJMTBaeWVLNVMwS2NEUEhDbllIMWNyN1VYK01wVkhuU0RD?=
 =?utf-8?B?MEJLRmRTejdMR3dteTlVZ2xtbWZ3bDI0Z2w5QytzbjlzNGNRT3BBMDQ0SUVk?=
 =?utf-8?B?MnY1UW9CdzhxTFBqaUcyWUFQMGlaY3d0YUYwcmg5RitIbENpaFBjQjBSeHNX?=
 =?utf-8?B?MlRIb1FsOWRlb25GTEgvV3dYak95V1ZVa2Z3NmhIdnBMWFdTVnFkbW92ZTFF?=
 =?utf-8?B?eEpnTDNyMjRoc01xeDFOYlkwM0hUdGNpaHJ5aTdzZkZiVmgvQzd4SWl4WEJJ?=
 =?utf-8?B?SEtKdk40ZjRMV0lsR0FodHcrb2U0ZmM5ZWM0enVPRExmd1RMd3AvVHlEY1VR?=
 =?utf-8?B?UzBHSUxMRVNZaFJDMHdMajJNcm9tcUVOSWowTnZKSTU3THYxYzN2SURGRkNj?=
 =?utf-8?B?YWRpcnFyYnlITWVDMVFpZU12UEN2OFBNWlpPVUpPUFZ2aHB0MFVrVmNxYmJw?=
 =?utf-8?B?SEduamV3T3VObmRTczlSamxVM1gyMnUzdExwTktvSGxUTmRRazJaakNDOFJD?=
 =?utf-8?B?YlB3ZVJta3g2Ukd4TkhNbDd6T01sVUVlbUZHT0xMRTZCdG96U2pyNGZYd0pB?=
 =?utf-8?B?dHRLR0VFZG5TcUlwekdWZ0xwUXpNKytpVE81MDk5L1ZHcFZTWjIrZ1g2M09T?=
 =?utf-8?B?T0JLT2RSMUprOVhVbXhiTUl0Mlo3SURWNFAwckFHbDJQUWRYT3E3dE5XTHVS?=
 =?utf-8?B?VWtuK2kzSjh1YTFYVHBNc0FIZzJnWWlrYUc4eGdqbHRZU040bWM1SnJ6Q1pY?=
 =?utf-8?B?emRDOWFud3lMU3RhT0JMWWN2ZUhBejZ0ZVlSM2gxeGtlTWVsdlVSWFMvNnhD?=
 =?utf-8?B?Z2tlTlhROElzU2R2MXhJMHFHdjByZTBuRlN6eWtiempVbW1CczdxV000UitI?=
 =?utf-8?B?eU5lQ3RwQ1hrdDJOQ2Z0dG9Ma04vYmdqdnJ4bXRZMzk2aEF0b1NXbzVqNWhZ?=
 =?utf-8?B?dGpraDUxVEExRnBpOGVsSHEzdVFrTVMwUml3RWJ2NWRxMnVMbm45M1dyVnR0?=
 =?utf-8?B?SWJGNHgyWmpZTW9kNnord0R6ZVZMTW83WmtyT29uNkVNTGF5bGdYQmRXU2xR?=
 =?utf-8?B?VzVmWGdoVlFqV3RKVzYwODJCTi95bkhCOGFtb1g3SHdwRnB5djRZSXF4TEJm?=
 =?utf-8?B?L0RqaE5WRU1TakphRTE2TEkwQmoyTTg1ZDlLMk1QZWJrNzQ5VC8yajhFaG1C?=
 =?utf-8?B?SktPZWtGWFh2bHlxWHlvc2lRYTV0NWZaMUwvNFhIYkxldWRpTlZXVXJXRWFq?=
 =?utf-8?B?YlArcUV4Z2dwZDgxcE9EYjlUMGJDeFVmVjBONDlOUnp4N1c3Y0RxSWtTbEdO?=
 =?utf-8?B?UE9rL1VzczhQMXR1NUw3aVpSa3czZjNQazVwVC9MSWE1anZYQmJvZG9LMHVw?=
 =?utf-8?B?TkJzMWtrcklwZFM0MU41TjZ1TklsZ0I2WEF2Q3RMVVNMV05hWEhvL2RKb2ZI?=
 =?utf-8?B?MldZcURHWkQzNkM5cjdiWmpOVnBJeElNSjhOdldza0RRUW1DR3k3K1Nkd2gx?=
 =?utf-8?B?dGhwMW5Qeko3Z0c5UUZQYnA2WFFQNW5MQXdaeUhnWkx6NEFwbDE1YTlseThM?=
 =?utf-8?B?cnZ4d0RUOC80ek1vS0dzT014LzM5OUF4VlRWTXVIc1FyQUc5N3k1djRMRlBC?=
 =?utf-8?B?bTlLWjI1UWxleGEyZzdYOVZ2WlU2Sm1PKzIzSmtVTGJnd3RDdG1jSmRET1Qx?=
 =?utf-8?B?ZDU4STBieHFWeFhNYlJwc1pXU2RFOXk0Ly95VnNycWltUWRHeFpZb09MTnll?=
 =?utf-8?B?K2RSZ0ExdXBtL1ZZeXJOYS9RUFFQOU1sdVFSdW5OWDBpRkxCeDdCOEROYmNG?=
 =?utf-8?B?QUd0OWlDR3hJczZXZm9DS0lFcjloR085MkVwTUo4N1M1SS9aR0Nrd0hWcmd3?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd74e81-b694-4455-93b4-08ddd67c2b5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 13:04:54.9981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTNqAF+0Oli5JznO7mTzbfm8aHyQkJXDz6fMZrWfEa/kYw/T0o27Z9qFeDVWJDlodGcl9IHwbCjF0ws/8CT/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
X-OriginatorOrg: intel.com

On Fri, Aug 08, 2025 at 02:03:43PM +0200, Paul Menzel wrote:
> Dear Michal, dear Jacob,
> 
> 
> One minor comment:
> 
> Am 08.08.25 um 13:40 schrieb Michal Kubiak:
> > On Mon, Jul 07, 2025 at 03:58:37PM -0700, Jacob Keller wrote:
> > > 
> > > 
> > > On 7/4/2025 9:18 AM, Michal Kubiak wrote:
> > > > @@ -1075,16 +780,17 @@ void ice_clean_ctrl_rx_irq(struct ice_rx_ring *rx_ring)
> > > >   static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> > 
> > [...]
> > 
> > > > @@ -1144,27 +841,35 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> > > >   		if (ice_is_non_eop(rx_ring, rx_desc))
> > > >   			continue;
> > > > -		ice_get_pgcnts(rx_ring);
> > > >   		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
> > > >   		if (xdp_verdict == ICE_XDP_PASS)
> > > >   			goto construct_skb;
> > > > -		total_rx_bytes += xdp_get_buff_len(xdp);
> > > > -		total_rx_pkts++;
> > > > -		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
> > > > +		if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
> > > > +			xdp_xmit |= xdp_verdict;
> > > > +		total_rx_bytes += xdp_get_buff_len(&xdp->base);
> > > > +		total_rx_pkts++;
> > > > +		xdp->data = NULL;
> > > > +		rx_ring->first_desc = ntc;
> > > > +		rx_ring->nr_frags = 0;
> > > >   		continue;
> > > >   construct_skb:
> > > > -		skb = ice_build_skb(rx_ring, xdp);
> > > > +		skb = xdp_build_skb_from_buff(&xdp->base);
> > > > +
> > > >   		/* exit if we failed to retrieve a buffer */
> > > >   		if (!skb) {
> > > >   			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
> > > 
> > > This is not your fault, but we've been incorrectly incrementing
> > > alloc_page_failed here instead of alloc_buf_failed.
> > > 
> > 
> > Sure. It's a good idea to fix it while we're rewriting the Rx path.
> > Will be addressed in v2.
> 
> Should this be a separate patch, that can be easily backported?
> 
> […]
> 
> 
> Kind regards,
> 
> Paul

Hello Paul,

Do you mean that the patch should be included as part of the series, or would
you prefer it to be submitted as a standalone patch targeting the 'net' tree?

Thanks,
Michal

