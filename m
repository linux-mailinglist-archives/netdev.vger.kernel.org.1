Return-Path: <netdev+bounces-111690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EC593210E
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 09:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D22D281B9B
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23022309;
	Tue, 16 Jul 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXdhLx7a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0044C74;
	Tue, 16 Jul 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114171; cv=fail; b=qRDYhBvxi7YoHc6oMynb1t6rSr9NYJxi5mvRa0KTG/O7M01qBPbWWdU3wZh7+dSZxGWrZXO9WcuzITJ2sZ40xJWyT0IvoSmRQEZfjvyb0cBZ5bgCvhwEMl3LDq7+dgeu6icYC11J5mgIQCe19EefJ3Ri7gb+hmzPOsMFUjNgKfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114171; c=relaxed/simple;
	bh=Fo2iVo2q7iKMWWWDdFAXM20T/Rclo0LHxZKJ3FaDnqw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QCJW05oqg3gVvdesyqLhsgfpv3EaPy3IzOjHziTuORq+cpsGhSlPHVhwN3CZj1Ss22UCnmsW/qEnI8mlkLv5hQ8XDqnvAoRF4UHDMOJjW5g8R3BlZTs5U67+2cWXF2SzJeb3qF6Z0SK6ItfGpEvu4jcSqBXcpoLQwNMTq14lKSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXdhLx7a; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721114169; x=1752650169;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fo2iVo2q7iKMWWWDdFAXM20T/Rclo0LHxZKJ3FaDnqw=;
  b=bXdhLx7aOUzszGGBTaQ2hSlDQ/ab4FMcTpQGYhtRRFOpHDt0/E+MCKz7
   KEanOLdPgcj0Svc4dcvxj+IaJ8Ux22k/KtyK/IpPhkLgfewL8J22GUPg0
   VLr0Tx/Sa88hGLxa/hcw3wmcDs5ivReaOQRky4Brm6RMVTWbDpBlgRII1
   6iJT5yTQHJpfpsiHWt3cr2aPomvipI24RSihbLAyqRYiscMJjbUWNo11V
   RRloGvQeZkoiG85ggaipFI+wFjyfLZDZLDAp0IKtrC2JCxiuApX+FLUWo
   0wYcKQJySaOLBvvOf70vmBc/Wx/UZKgUvqIfkXqSiE5GEWFtOn/h0F7oQ
   w==;
X-CSE-ConnectionGUID: TmHbJDnsT0i2+qxJG+ln0g==
X-CSE-MsgGUID: 0BDpUCxFR5WYfwnMRfUjwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="22342771"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="22342771"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 00:16:08 -0700
X-CSE-ConnectionGUID: z6FZMx1xTGu6wGlEWF06SA==
X-CSE-MsgGUID: xBNKTlrISUuB0Fep3oqDBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49752651"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 00:16:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 00:16:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 00:16:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 00:16:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dF3iV9rtIh1ZrJfCRcY7mMBvZNYsVzxkTUHvcqsldgIsiHfyUUV4QoA7ydJ8e+I367IG3agpeTXvPj5Qpn0usLpvNpJWJJ5nUSfsDH6MCFFZTE20+ULWErAo9iVPHhaI3c7IKZnHx4JEvArf0S3U6jyEqbwL9BBUtITSDuZOD+L05k8mNYhyXzgNeEF6AnleKaKeSBGKrk8NAIU1HZMQ01yQc/2Ut5EhfIA4jNKhg4bil40k1ZTN+oQpwjFNX6KpjM4Yf+TDyIA84hoajFqzujft52jBjq1m2+GIoAuOX1Ptgsqxv45RdRMnzmR5WpkMNpykuR+Vopcia5mNh15NOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNQ27ziyQoIeVDV0AzGbQkXB03wdwqWCza0pV78+xZg=;
 b=dY+rSX74cBVJt7wo8AOF4Lu9CcbgrM6p9DrSzctGblG7R+RolIRT/8s/EkRcjizWN3Y9i4duXUl7orlA/nzneLiO4jV2WCo0Et3mFPkDZbDpm0pcELrU/8WdThisvUFEeyCqHiDyZNBOxxghpqDVPdQXUwJm3GYjYV3jDrzrzW4Jb8nYVVQrkOqMORYheJ6cNFO9TIR6E5nsWy8GBP+aJazv+fXXBcqwq8ITLqJGjO3oAdfvL+oVqQzY/9P+dpu4GMu4YM/9ut/vxVU/w9VAW01LpGPnQaiDapAYVB2OERh61+/XLUOC3TM3ufuVtsaKbjjdX8MqqwnWKlPNr7B4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DM4PR11MB6432.namprd11.prod.outlook.com (2603:10b6:8:ba::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.20; Tue, 16 Jul 2024 07:16:05 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 07:16:05 +0000
Message-ID: <1f082012-1ad6-4b12-8eb4-96bcc61704a0@intel.com>
Date: Tue, 16 Jul 2024 15:14:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] cxl: make region type based on endpoint type
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-12-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240715172835.24757-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DM4PR11MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2bb5f6-93d0-4dad-403a-08dca567281e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVRaRGdTWXBkQ1lSb3VuLzFacUZVMjA5YVg1cGVlbjduWWRxc1lBKzNaMFBE?=
 =?utf-8?B?YzNpcktnQWcyK1RkNmY4cVA3eXRUUVYzZjh3TUtaeHQ5MHpTc1V3MGFuSFF1?=
 =?utf-8?B?R3k1dHpkUmNmVE9nZnExR1hlQndzWE1tdTRnR0orRVlERzh4WTJPb2ZFbFA4?=
 =?utf-8?B?alduK0FGRzU1RVNWWDZncC9PeWUySUxGdTNvU05tNitua1FOdjd0bTJ2Znh2?=
 =?utf-8?B?VnpzQXFKWG53L2xra1E5Y3Z0MXdJbUNqMTBDbWZ5enpyaWV5YmlXT0tUSjd4?=
 =?utf-8?B?dzlyM3IwdzIvelcxV0dNKzU5aDg2cmZYT0w2d1V0OG55OGZRN3Y5c21IOUow?=
 =?utf-8?B?MlAxMm83SG9RUG1kaWRmK25manlYZDJOb25iNzR6QTFlOHc4anpWakZIV25R?=
 =?utf-8?B?dkREdnluTmIzeXMyNTRFVGRJL2FqeGpLU3BjUGYzY3ZyVnFCU2RGcWdVR1JJ?=
 =?utf-8?B?VStvbjRaN1N4NlRCQWxhSlpNUGhybXVjY2JId2lRUFpUY2czYUlvdXJuTEdI?=
 =?utf-8?B?SEY5bXZsQVJoOUorOW81VkFScTYwNEhOQXFXc3h4Z2dWWno0RXhWdG03aS9p?=
 =?utf-8?B?T0U1ZG5HY3hsaVRVbEdIcDh3V1dDakc3V1RwVU5XRWYweTBlbGxzYTJiTldj?=
 =?utf-8?B?Rlc3c1FJazZlSjF6NnBYY3FVSHJHdTA3TmtZTHdlU2ZRL0xNdlBBMkJ6dy9i?=
 =?utf-8?B?Yi9COVk5aGhuMnFscFVjTG9Vd2ZzS3lCcldyWHVhNGVEcmw2dWlsQTNnL3pt?=
 =?utf-8?B?QzZJWVBzVmRiTUtsQ0xPdVFPcHErdDhOOHpQS2pIR2tjK0JsMzBxdUlCK3Qx?=
 =?utf-8?B?WFdaejNwNDh6S2VqMHVIOGFBNXVhU1dCUlhBc2U2Z2trTjdMdEhmMStjaHZO?=
 =?utf-8?B?YTkzcG9pU0NZLzQxdUZoQ3JtUUROQnZuMXNDVEM3TGZRMUdYSHVEUzl2anJ2?=
 =?utf-8?B?UWdWTUh1QzR6YnI2NHdZaXAxS3hsV0FyazJvMUoxWUZ2K2l2MmFBQjdBeGI5?=
 =?utf-8?B?UkhiVThqUlFBNmFoMGZSdVp2QkJwMzFBd0orSHRubDlRbFdGWW1QUCsyRG1x?=
 =?utf-8?B?cy9UTk1sWXhyb1c2YUQ2WnQxd3R1ZkhhSGlER0ZmWjlwdHFBbmNmWGlKOUtL?=
 =?utf-8?B?SGE1Q05aNmJtQjYxMVdMTmNQOHBOcUR5L1BRa2U4UDYwRFlyQWpOdmE4Mmha?=
 =?utf-8?B?amQxK3pjRnBpZU1Lc2NJVXJMb3QrbnVSVXN5MWFSakR1K3dzZ0tjcXlueDVP?=
 =?utf-8?B?bVhkaU5FY0JpNlFXbWk0SnlPTndSZVVoRG9lM3pTcUI1cTdwQlFxRTIwQWRJ?=
 =?utf-8?B?TmxHTDk0MUw3by9uSXZBSHlZcTUrSHQyUUZVMXErVWY4MTVjT1p4Y0Y5aHl2?=
 =?utf-8?B?N2JiWU0yb3JhTWQxRUVLcGI4OVVTRGZKWGNabm50MDBpeU44ZUk4RnFSWHVI?=
 =?utf-8?B?OWdQS1NaVHNtTEM2Y0lmQ3lrczlPMFJ0N2tBejFZcFQ5ZW9qakdWd2llRkxI?=
 =?utf-8?B?LzdyQlYwZ1dEbGYzN21SeEtSZ1h2REJaYy9rK1RiV1I3Qlc4S1dlQnBtWk9p?=
 =?utf-8?B?T0dTcm01OUxScGw2MEpkSEphWmdWdDdGRjBOa3p3Q3l2MTB5ZU44WGRYa2l4?=
 =?utf-8?B?KzhadUlwVkF3bGpWWmo5RXExb1Y4L3V2eHR3VXZJbHRlRG9VYkJ0ampkVTNp?=
 =?utf-8?B?MmIvbTlmY05QaVkvajBySFBqNFFnMmRGS0FJQTlrempzc0RCVEJYWnBoQm5M?=
 =?utf-8?B?SU9MRFBxSitXY2M0aWJMUFFqY3NDaXlmMTF2Mzk5dVFZN1dRZnpvQ0ltM1RM?=
 =?utf-8?B?Y1duZThSdXJMOHlMRzdIcC9vL1JPR2hjUDhpcTN0dzVnQ3RBL2s0WURZbkhs?=
 =?utf-8?Q?tmNyP95BWjwCZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUZJamlYZmswOHhjYk9TMmhIeGxzTHkrdHV0YVpsaTZWaDhNVHdRNGc4aVFW?=
 =?utf-8?B?Skc5Z2lHQkJ3THJUWm4ralFLSTBPRmk3NTBjYjF0YmdUdVY4am9HRjNTcThT?=
 =?utf-8?B?VmI0V3BDWXNaK0Yvb01RdzViK1BzcG1hRXN5djNRdUpaRThtN05BV1MwZzh2?=
 =?utf-8?B?QWRFSHRobG9NLzBSeXpIYzRIOXcxcHpZRG1vNTY2emlQeXlQdG1uWHoxNzJT?=
 =?utf-8?B?UW5kTWc3bHdabXZzY3B3eE92NHREeXZMSTJTemVsa3YxRGZQdGt1bkxBVjlw?=
 =?utf-8?B?aGJEU3FDZlZwMVJNcjBwTzlQV2FjTTlSdkZGZTl1UzlvVlF1ZUtSMmtWU2JJ?=
 =?utf-8?B?eEdDTG9vQkNDcUZHNkc3ajk3UXR0aEJsTmZGMjFKQW0wenQxaE1CNWVMVVBE?=
 =?utf-8?B?SFJxTU9lRnBWNlhvd1cxVEc1TitSVklFbk51OWxtbitna1FaU0JrR2NBcVlG?=
 =?utf-8?B?NmJSN2cvS2JMNHBhMUo5K2daTnVBL3BYOEhSWk93cXI0RENDaCtuOTkwSXYw?=
 =?utf-8?B?R2l1S0RyQjdFZnNKVHVDSkJzY3hwYkt6cFk5NCttR2RYNUlZRFVWc3BsZmxB?=
 =?utf-8?B?b1lGejRvNWRRMVJKYVluU1lleW5PZDQ1MVZodHROaUQzQWVPRFpzUmVsdE9k?=
 =?utf-8?B?UWR0QW1Ebzh3Qzh3MVFpYzF4R2NmbXIvSndlQ3B1bXNObFNmdnZWSjRzVStj?=
 =?utf-8?B?aTllVzRrbVJOUkNXMUJrWjh5SVc4RnBBN2R5b0VPRzZEeXFKaGw0bmRBVzZw?=
 =?utf-8?B?dXdqOHBrRElkK2I4aFRFNzdjMnIyb01DL011Z0VHdm1BcjV2MHh4ZFN5QVcz?=
 =?utf-8?B?dTFGcWZQanZya0N1N0FkUVAwMGdhWGVNVU90ZnFmMGx1UTBidFNEQ1UzSjhj?=
 =?utf-8?B?b1dtTmVkZlF3WW9mSHJJL2RubWNtWTIxMUE4U055dThqZDJ6Tk5XV1hDZzFq?=
 =?utf-8?B?MHc2Nnc5RFZhVGUxckM5aHZhVGxjZWNZa2NiR2ZGb01MeVJTNTBweFVUaEp4?=
 =?utf-8?B?RVBUcTJjbDNiR1cyanlCZ0hOZHdvM04zRUpZYXkydGZrK1ZLYVc0L1pObjQ5?=
 =?utf-8?B?cmgvOHBLRm1zbkZZQkFDR2twMnNzcW9XeExSK1R5RWNqd0w3dUsrWkNNSVAv?=
 =?utf-8?B?MlpPQWV2ME55a2t5RGdIKzJJWFlQUWVaaVZHdS9QWnpiMlpkeFRMM3N6Mmpa?=
 =?utf-8?B?QVVyNzAvOW1HeHVtNjhrYVdNTlZkcjBSQVhraGlwVGZBUmpIeDdQQVR0VXJt?=
 =?utf-8?B?Qk00TDBKcU05QmRSS29xZ1hDcGJjZEZUQ2ZPbEZ2VlBDZDdEUjUvOWtoRTVV?=
 =?utf-8?B?Mm1pQXNqVVF2cmEyMFo2M0JoNmJWV21pbmtINFBtb0U4eGVDbEVOQlNHUjlh?=
 =?utf-8?B?MHNJQzcvbzlTUWNUbkpKVlFUdVRHTXgwOVhtSEpwNlBkNDAzeVBUbnBmbEJt?=
 =?utf-8?B?RUd4TmZhTGFJUWd1WEpZdEtvcWpYSUFmMS82Ui94SWwvc293cUtkRWZYRzNY?=
 =?utf-8?B?bEUzMnl1dzFCNlRIL29jY2JwSXNKYjY3RWw2M3pWUWUyczUvZkdJcDIrNDJG?=
 =?utf-8?B?SGs3b1p2R1NOYWdEbU9HUjFVaTJDeGlOMzhmbnd3UEpYOVhwNHo2UWxLZzFx?=
 =?utf-8?B?a2t4cnM1Q2dRWnBaTW5JbUIrU2lQR09oOERkYWFTaUdGZjVQNUZIT28xN1cx?=
 =?utf-8?B?elk1ai92UnRHYWtQWHlHWFAyNTY0WEoxWkpteEo0TzBQNlFzZkN0dkluRE5B?=
 =?utf-8?B?M0hoQ2JaeHgwK0dSb3haUEYxTURGV29YampWSjY4eVBWTitFTjR6NWkrY3dR?=
 =?utf-8?B?K3RpOW9xN1I3d08zbFpZYURJNVlaaWdJS2VobTgxYjV1S1hBZ253VEpzdW40?=
 =?utf-8?B?MFNWUXFscUM0UitvNkhTN1gwZXMyN2E0SVJ1YXNXamdhYkdiUmZyK2ZCSHRC?=
 =?utf-8?B?dmpxWSt0VXU2MXdLRlZBVE9yWDd3bm93MTQ1SnBYalgwYTBEZkE5U2kzR2I1?=
 =?utf-8?B?ZU0rYWdlOHdkZEd6UWxDSXhXQy9yOWtubDRUNnFSbmdBamR5eU9yMDAvTGdQ?=
 =?utf-8?B?TDZ6c2hDODR0YU5qOVNWRXVTeTA2bk5VTGdJTlNvbXkwK2krb2hzT3RSd3FE?=
 =?utf-8?Q?D6CF1+24CyowuE54Ph0NV1aWi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2bb5f6-93d0-4dad-403a-08dca567281e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:16:05.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2VrUTsEhlSB3KGnZSwOalVR4SKQMVJgyXNRxGf7imRVfvuUUl52rglAlkTdJTIqcEuIWyqZto1KazGxjCGG4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6432
X-OriginatorOrg: intel.com

On 7/16/2024 1:28 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
> Suport for Type2 implies region type needs to be based on the endpoint
> type instead.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ca464bfef77b..5cc71b8868bc 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2645,7 +2645,8 @@ static ssize_t create_ram_region_show(struct device *dev,
>  }
>  
>  static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> -					  enum cxl_decoder_mode mode, int id)
> +					  enum cxl_decoder_mode mode, int id,
> +					  enum cxl_decoder_type target_type)
>  {
>  	int rc;
>  
> @@ -2667,7 +2668,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(-EBUSY);
>  	}
>  
> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
> +	return devm_cxl_add_region(cxlrd, id, mode, target_type);
>  }
>  
>  static ssize_t create_pmem_region_store(struct device *dev,
> @@ -2682,7 +2683,8 @@ static ssize_t create_pmem_region_store(struct device *dev,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
> +	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id,
> +			       CXL_DECODER_HOSTONLYMEM);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> @@ -2702,7 +2704,8 @@ static ssize_t create_ram_region_store(struct device *dev,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
> +	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id,
> +			       CXL_DECODER_HOSTONLYMEM);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> @@ -3364,7 +3367,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> -				       atomic_read(&cxlrd->region_id));
> +				       atomic_read(&cxlrd->region_id),
> +				       cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
>  	if (IS_ERR(cxlr)) {

I think that one more check between the type of root decoder and endpoint decoder is necessary in this case. Currently, root decoder type is hard coded to CXL_DECODER_HOSTONLYMEM, but it should be CXL_DECODER_DEVMEM or CXL_DECODER_HOSTONLYMEM based on cfmws->restrictions.




