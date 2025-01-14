Return-Path: <netdev+bounces-158188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA81A10D92
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC87D1621DF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0481D5CD1;
	Tue, 14 Jan 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5HWQXdD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472114A609;
	Tue, 14 Jan 2025 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875448; cv=fail; b=SShCxBMGxdNG1f3B/Yrge7jiNB0IrV74dV+1DPkcdratvmsZ/1flZYmPnevtW0Xh9S5AfbYruD49ZFrbhB6Zdm1+UQBmBt+81si70Zf2WejuauK/wPBAQT1vh1jDFESDDfFqT4n/b505y3CKPpZmVPoQpq/BvBZ6d1Q0VUlfDYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875448; c=relaxed/simple;
	bh=js1QsvkZev7ArLWXIMf7YQnczG/yCsuTVHfWrZiqRiM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FbUNyLXEu2Goi6tAUvEtETjGIb4QtvnQbxPtAeG2E1JhXxP9qGVPOmXJXGqrci7NlhALUvCLIEWQTf1Jc+qw9i4slqWSeMF8nG7xatEWClnscq94oiF/Gii9IJ0BvPw+2PlX7uI0keZJC5LG6Q9ryJ1JQ9rX+DNQwEYKZaKenQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5HWQXdD; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736875447; x=1768411447;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=js1QsvkZev7ArLWXIMf7YQnczG/yCsuTVHfWrZiqRiM=;
  b=c5HWQXdDL5SxNJnOqhVktckXowtSDDXpkyRGC4HCiEwk6/q+CqY/KWJ4
   Q8T8SXvyA3ip5tCrk1oeXI/6AqmbEHtR2tlKeueVMe8iH2eNzHuxbXTU6
   gWBR7SXKobuRHZSyfOSVvVi1wXFO0o9sBQVm+Or4Oh8EBgEKnvbtrK6Eg
   5jNmKBtY9jfVwRL6mp/lq94Cnx3j2BKR/0E5ycLM8uk5hDdRIAtOpJr5u
   atC2FRNhdeduC5WkA30Ncxa7W971K5KQ1HiBOtEzAJU292A4XPGslRmHA
   TnvPnDC6Rbs3Iru3qOw3ApZJCmy2mnsii811jOs2YHgx/lxrM+SnU1qf1
   Q==;
X-CSE-ConnectionGUID: Pgues2x5TKaCgG1wta5h2w==
X-CSE-MsgGUID: 5hqkWHYsQx+9s6BLYINtzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="48184589"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="48184589"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:24:06 -0800
X-CSE-ConnectionGUID: p+qzN1PsTOWNt+i1jol2yg==
X-CSE-MsgGUID: nfICS2TaRrmoQbBhXu4c1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="109836899"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 09:24:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 09:24:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 09:24:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 09:24:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tknr6uGdbDEfGpWAzRU8KrAcAOWR0btYL3mMzXMI3Aom3yedyXYeDByZ7fpwIdfNYeTYD6TsBckWIfyxKqo3byDok6zh9rd6r0dRFi1cXS3pPho4s1UfhCywuC+2KxAuQFjd+k8PF4IKRUzb3Uvd913IhPyCCMw48w2eaXrBEqyjpWHLJf2vxbd4kJZ9yVN7lidPoRhJVgxIfgCtWMJ6zAaDmDwako+i0Ihcp1Ohrhh37DfXtOhaUIoy5QgyFYdPhTlQXoYH88hFC5LOLgg2kp00AxWj3zvbEQmVlLYxIo1VmgWZ113zZm6HQ2vVyzlHyDs4LdhrK3PX0NnHlJF5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma/0ON2+w+M/Hi63BNe5ycrBavpRgrWsk3xLs/+m68Q=;
 b=Gx7hHXVbYbu+Rmwr8uHeUYLjqsXMVgdaNpDF8rwEqTFuizRvP3YeKG0rL8UgnZbmlNY+1fcOpdtYupQH1s9phhY6jn8YyxRfXl4QOcWTIKUBmzrohd/lKS7Cm50/pnXYDDblwg3jXnbaAOGhNxaIiojMTT1Ug/om1+4VdMH3GT+t0QACOk2oXdn7ljmGMQkN6t5HcN07ZSt5UorN7nGefHCZb0KcU6zcdPwJkQxsyETW2uTUIT2bX0wWy1bo/ONTDTP1OcfZ4ARi6yeK/HiLYaNQEHWhasWum0lvEBFejZMSJxoIORVbhh13UmzEImOQEjoLa9xYpme9cItsQC3FjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 17:23:57 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 17:23:57 +0000
Message-ID: <12e126f8-f966-43e3-9fd3-f9105461d7b2@intel.com>
Date: Tue, 14 Jan 2025 18:23:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/3] net: stmmac: Switch to zero-copy in
 non-XDP RX path
To: Andrew Lunn <andrew@lunn.ch>
CC: Yanteng Si <si.yanteng@linux.dev>, Furong Xu <0x1207@gmail.com>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	<xfr@outlook.com>
References: <cover.1736500685.git.0x1207@gmail.com>
 <600c76e88b6510f6a4635401ec1e224b3bbb76ec.1736500685.git.0x1207@gmail.com>
 <f1062d1c-f39d-4c9e-9b50-f6ae0bcf27d5@linux.dev>
 <054ae4bf-37a8-4e4e-8631-dedded8f30f1@intel.com>
 <e9cacef2-1049-4296-92f4-85041f4b6eaf@lunn.ch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <e9cacef2-1049-4296-92f4-85041f4b6eaf@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df9f0e8-d4ce-4db1-0025-08dd34c039fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTN2NTFSV3FIQlBtb0VRUkQ5bUhPQjdFSHVKUnF4YTNUSzVHLzQ3ZFJYc3E5?=
 =?utf-8?B?bUhZY2dwRUpkcWQxb3drRTRBUFFRdjlyclpnWGovQXNneGE4QzF5SGhwTHA5?=
 =?utf-8?B?bVBIeE5nNHp0a3VueE5lc3hzTDhjN3lzRE1YSGZsaXEwTXJhQTR2ZDBTcDFP?=
 =?utf-8?B?TzFuaEN4OXJGTWE3THVJZFQrNEF1YjJxN1VCVVJIUzBtRlowZWFyTlpWME0w?=
 =?utf-8?B?VHBHcGhFQ1Z5NVpCWVFjL2NQUWMwSldHSWcvNCt5d0dpbFBrbjNUR0c2djN0?=
 =?utf-8?B?b3prbmZNd2U5dGVtMHJDTjE5YlUxRGRZS2hWVng0RVFoYWphTDhPbGd3bUZ5?=
 =?utf-8?B?Y1k1Yml0eTJWODZqL2FuRWo3b21yeWFML2wyNTNBY3U1NXNTdTdJeGhhSVZu?=
 =?utf-8?B?WCtyWDJGUnpERWYwWlJaU3Z6di9oVmxud2FvVUJoaWcwb2wzYjRsWU02eEMr?=
 =?utf-8?B?WnpITG9mTWVZU3NmWTBSWElqeDhuYmQzalV1OFBEd2d1NHBIM2M3MFp5cE1r?=
 =?utf-8?B?aDVUb0ZmYUFsYW9oOG9iSVplZ0w1Yjd0dis5cGwxaVRrRUpvK3lXaEpvV0E0?=
 =?utf-8?B?cGlTTWxIWVlES1l0K2ZTRjE3VmJzTFBXenh3djBHcFcydkZlVlFJS1hKa3BL?=
 =?utf-8?B?K25FOTdXbzhaSnpGNFZZRVZXbUh6SHdqOEsrQ0c3K0FiR2VpSVRDYUEvS2dh?=
 =?utf-8?B?ZEw2M1QvR01kTnNHcm43dUpYSTdiTmlWa094eVN3Sm1DSEppek9sK0pkeUxV?=
 =?utf-8?B?a29oZ1FMTHBQTUFORi9LNGVRajVrdE9FVTkyR216R0J6Y2d1TjRqUGFZWXE3?=
 =?utf-8?B?dHYrSkZPQUtvMHdDYWVxZjdBZDN3Sk5sYzJuR2kyZFdrYklScFZUWWx2eEpq?=
 =?utf-8?B?L1pmazhvMXpZWXVGZGg5ZWQyS2twc2tMSnE3alV4RE12MlpNZWJITE4yNWxD?=
 =?utf-8?B?bmI4YWo0MjFHRk8yNENMMWpMVWk1S09KSFlCMzNaV2NkSlhQak9Db0M2K2Vh?=
 =?utf-8?B?cVR4bmRtcTBJY2Nqcld1enhocC9KeVp2VmxOZ2hsaHp3Y1gzREZoL2lwWE5o?=
 =?utf-8?B?RDYxTUZlRTFla2ZUSWVVdXg3QUwvOTVhNWxzTzZQYXk3QU1yNURST2hIeFJO?=
 =?utf-8?B?VkpkQ1VqUTFrMFZNSDBSQUova0tieHpJU2Q2NytpSFRTeEsxQnhveGF0aW5u?=
 =?utf-8?B?c0QwWEVueG5ieXl2Y3IrbmNIYlpZTy9DNEJKQ0toZ2cxek9ra25KMEpLWllN?=
 =?utf-8?B?ajhUNjlKSzNOa0ZhUmZmTGtIQ0pkekZGbVB1RGg5Y0ROTTNBTXBzK2h0NW1I?=
 =?utf-8?B?dEt3T1k4b21qcE9yRVhYYU1CNkpabkEwbWlwZ04zaW9PbTMwekVoR3dNVGNl?=
 =?utf-8?B?R1J2U3JzbCtFYmY2R3JjQnFTZUNRcVlibFZrMzNRditDV3RwWElFbk1ta1p0?=
 =?utf-8?B?K2tVT0V1K0Q4VTR0VnVyaE95VVRuRFowQVVLdTFkamx6cmRuOVYwUWppaWhT?=
 =?utf-8?B?eFVCdjd5bmZyNmUrV2JwRlRDOFZsREdVQlJydE92OWE4MWdoRWk1eGVpOWM3?=
 =?utf-8?B?bnhFZTlxc1VpNVZYS1ZEbURtVTZzcUNCNUJGZXJaaXpRb09WT3FyZjZOSk1Z?=
 =?utf-8?B?M3VQYVgwQnc0bndEYlhMZ29PT0l0MVlITnVYOUJDMHVoY2ZVaGQvaDlNWGxz?=
 =?utf-8?B?b2hpNml1dmpCdytzUVlrdG5FeDU2bjl5QVZKcmVRZUd5cTFVajFuRXd5dFdt?=
 =?utf-8?B?UzJEZHRhL3phZTQzUGpNZEIrdU13VHh6RlBpTWFqRFZWeHl0ek4ybWJnU0Ra?=
 =?utf-8?B?ZVc4TFB3K0JMaHAwNE8xK1IxNTRwVHFOLzNFYlg4S2p0bXJSU25ZMUxZODNl?=
 =?utf-8?Q?uj7LkxlSf7RTS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHYxR2pxa3VsNmx2c1h6V0NYSUplS2ozWklVQWZzbGhyRnRWbTQzSEkybE9W?=
 =?utf-8?B?NHU3RVRQTzRtdldHVVVBd2lXUjFMVms3K1NjV0hXL01vcS9YYS9uRndlbDY1?=
 =?utf-8?B?QmlJREZjRGVHK0FYSXp4MzV3d0F2MHVpL1pvYWc2SEpiM05DYXVzTEo2TFhY?=
 =?utf-8?B?aVV3Q3ZSWFBZTHdmczN4T3RBRHVFQmphWldvZ1RrZE5KenFUOHFROG1RWmhP?=
 =?utf-8?B?ZW1PSCtYb083VXNHTHlJQUo4Q3QxejkydEJRUlpMYysrL0VZeVZyWWpwcDZE?=
 =?utf-8?B?SjdTRVpvSDdMMWwrVnU1TjVlNC9sRURsMHJRMmV1Y1NDV3ArY2daaE1QTE5G?=
 =?utf-8?B?UWNUeThnNHVlVjdzZU5Od0xPTlNyeTFJeVF2ZHVYMFhMU1pIN0c5RHBsRjZX?=
 =?utf-8?B?bkNjSHB1ek9vdXJQSDAvSTRaNzJQQXAyK1pKSmFkb3hENVQzQkxiVDYzTVdN?=
 =?utf-8?B?UG1hNXB6R0dCNHBUZHc0anVtdlBZM01RVFVleEp0cmpBak1TOUJkUmp5U2o4?=
 =?utf-8?B?aVg4SU9DQ0FML0ZadlF5SUovQ2FISnpNb2duR1VFeDgvSVdFeEMxK0p1NnFX?=
 =?utf-8?B?N1psU3QrV2xMZ2VXaWQ1Z3NxZTNMeDZ4U0l3cDViUHVUZVIwRG5EUkxRM2l0?=
 =?utf-8?B?NjFyalVLZVNUeDdWNmxmL3JKVStkbG5VMWdYOFExa29taEhiNDBWYlZleXNq?=
 =?utf-8?B?NTdjVWFqdTkycExCaG9maUY0SHB4SkRBQjJtR1JrQWZyVFo3NldmeURuVlhP?=
 =?utf-8?B?YWtNTEpJYXYvbi9wOG1uUm5Vb0V1c0RiY1FqcElQQTRBNEdVM3lMc1I3eEMz?=
 =?utf-8?B?Z1daU0hES3B6U0MzWXV0NGViM1VkSkJVdHF0cHkyTnN2Z01rblRnWW5GTGlQ?=
 =?utf-8?B?SUpsam9WbVRlMkxmYmJNUVhpOC8zTXE3bUZ6d0J6QkJIOG92emNOV0FNWE1S?=
 =?utf-8?B?b1FnVmxuZHFWdktTaDlVL09TYkkrdFdBQjdXNnh3TURVRG9oREZxN0RJcDJD?=
 =?utf-8?B?S3g1V1VzQ3hZcFFUeVp6bDdxQ2ZsYUYxMElJYk1DT3FTek00c1MzQmVhTVhB?=
 =?utf-8?B?ZjhOT1Vsb2xBeDhYZ2tKOXZYMmhia2xvWi92SjJqYjBURjhiK2xseHRiR2JI?=
 =?utf-8?B?Y2dFZWNaOFVUUFBTWDRwUW45elpyYlVsMllqL2hSVTg5Qi9ESDlQbFd2MFBK?=
 =?utf-8?B?Vm41M0JXQVUvSGNLQ0V5OGJsRzgwREdqYktoNW1CZW16Vm1HRXd6THF0RHBq?=
 =?utf-8?B?TEJQczFFQUtucGRieGViNkt2R0kwNVJzazZkZ0JtR3hSeUt0c1g5bHVOWUU3?=
 =?utf-8?B?R0gyUlRZclpQNlhRaURpcEFJK0JjNlhNbVpDUElkMVZvT0V6YmNVUHhVR05Z?=
 =?utf-8?B?U0llM0RmalgvN1NVaS9PdkVtVXFaWXJab0Q1UiszeHhPd0xUOGpBVVhjR3pT?=
 =?utf-8?B?OGt5Nmk4b3ZQSXFrOVU5SnpXLzQ0TS9pcGVrU1FocEluUTVSVU1RUUtDUytx?=
 =?utf-8?B?ajZsTjZDelZwenZEcGZQaktqVFdTTzhvRGx1eU1qQmNKbHZ2YktWbkNQV1Mr?=
 =?utf-8?B?bXliSXltV05udUp3dG4xZitrTXo0Zk56UW44eXhyZG4yN0hWWHhZS0ZzR0Zr?=
 =?utf-8?B?YzZpOHNyemZ4UkUzQmhBeEFsQ1ljM0dlUmVkQWl4RXlKTkJESDZoek4yaTBs?=
 =?utf-8?B?U1N0ZzJkUVBYdkRiQ1YyNi84ZjdJaWxORzJoVHlpK0FiN2VEV0lCKzRKWlZH?=
 =?utf-8?B?V3Rzd0l0Y2xPREJpK1ZTbUpOSkl5YWpKd3MxZkpEWng0SklzOWJnbUQvSGJF?=
 =?utf-8?B?OW9yeC95VE1BdGgvenFzTXBOcHRwVEIyTGd2clpQV3A5TTZDVUJUUGwxNVpJ?=
 =?utf-8?B?c3hOUjhoVWRzcGVJUTZHR3NBWVBMemt4bmpNWGdhTm1wZjVEMmxWZU40WmRl?=
 =?utf-8?B?RnY0U2FxN3NlZE5HTFhLMVJwQ1k1dnRDTTJwL2RmTmdSRS9aNmlGUUZNaFcv?=
 =?utf-8?B?TjEwcnhaTWx5NkMzbzFkK1gwOFpsTUpWQ0hONmt2eXQyN2xydnU4WmkxbkQ4?=
 =?utf-8?B?UHlBK3BFT2hpbzFlbmpGek1rczBvSk5MYmtqdUtLbkxEODhLOGNDS2MzOHZR?=
 =?utf-8?B?V2lkVEliNWw5YVlqcm1TZTBXVnVmc3VKbEw1YUxudi9DeVR0bnMyMEpYenZt?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df9f0e8-d4ce-4db1-0025-08dd34c039fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 17:23:57.0233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp3iIDHi7ssfSirHkfZsPh2EzCj2qfLFk2E4M9RwgixrlKTeLJH3hl8AHo62lt4YSgPXxHKYD5EENc4WC1ZEpOJZl8qY8VxOLpx0jBpL5SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
X-OriginatorOrg: intel.com

From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 13 Jan 2025 17:48:22 +0100

>> 1. It's author's responsibility to read netdev CI output on Patchwork,
>>    reviewers shouldn't copy its logs.
> 
> I somewhat disagree with that. We want the author to of already run
> all the static analysers before they post code. We don't want the
> mailing list abused as a CI system.

Sure. Maybe I wasn't clear enough, but I don't encourage using our
MLs/CIs to test stuff :D What I meant is that reviewers shouldn't copy
stuff from the Patchwork output. The authors themselves should track
their series there, but only to make sure everything is fine, not to
"let's see if I need to fix anything else".

> 
> So rather than pointing out a specific problem, it can be better to
> say that static analysers XZY is not happy with this patch, please run
> it and fix the issues it reports.

Right, probably the best way.

> 
> 	Andrew

Thanks,
Olek

