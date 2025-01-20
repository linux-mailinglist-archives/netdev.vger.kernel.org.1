Return-Path: <netdev+bounces-159791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7CA16EC5
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98071883EA9
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764011E3DE3;
	Mon, 20 Jan 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUpPcX+Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00231E3DEB;
	Mon, 20 Jan 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384560; cv=fail; b=HW9PnvMzITfw/QRf6HgaUKgAjngrcx/37FWz0XFSk9u8o/xNsiGK++vY8FyLomzxF9rDgAcPmEn2DliZbhAR4AdW8P4/thFPT7mSINMEe4zhzxcueNmukKIbKvsOsdom6MB5hawgGNWRbDgJ2+sH99123K+UKNoLlw+yMobGriY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384560; c=relaxed/simple;
	bh=Vv4a07ZRupVvYlZBRyZ/69ltVvkfpAdEJZL5dwHMXkM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u5sUqmd5j73WKXgb4Oz8bwYf+rk4Xsho6/h0jZzx4iWUgvqXpkrResfvJN0GCkKd6H7llrjI4IrTGCVJ4QPrGX4JCOcsvPmcgRcmAd1cZ4fiUs29j1AKr0uBMclS1QPI74Rhwi8WtY4bKxGSRSzo3QiCyye+OA1aSlC9fj2HzZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUpPcX+Q; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737384558; x=1768920558;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vv4a07ZRupVvYlZBRyZ/69ltVvkfpAdEJZL5dwHMXkM=;
  b=QUpPcX+QmM5OYevPLWl8H58aVraPEDRJGLogpZzgteTi30WZdYkzz6Ww
   ZQu+UgNJyyvAta2iV+okquD6EBj6H5ISvuz26BbuwR14eihWc/gzU2X4B
   WI+8YvtLcUZqrVzQ/bGlsfnPevfkF8wTpC1QABwAM/w9g7o/eDKOvucdx
   WbqpnFlbmJSvDShkpI4RJu2nJmvztFLPKSg8s/oAdVhXRy/ms0taMl4jF
   m6W1UQiO98uSZFpM6RZDf5I1gPW5ThZ4TyINizGCxPEYIqO0yq3VNehf6
   1aeDsWsBch9/ef6ze4y4JjbzkXl8BzQDP9Ayxnl/wYvEC2A/3lfwTijl5
   A==;
X-CSE-ConnectionGUID: IJHvBqoxRZyHMGkzhDIyZA==
X-CSE-MsgGUID: rOxHRCL6SbiNisP3M9KrPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="25382012"
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; 
   d="scan'208";a="25382012"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 06:49:18 -0800
X-CSE-ConnectionGUID: O0NMB2M8QKi80C0G2WPYlA==
X-CSE-MsgGUID: bKQcV91iQtevf58oWYsXsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; 
   d="scan'208";a="106661822"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jan 2025 06:49:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 06:49:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 06:49:15 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 06:49:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLySHnI6COMuLyuaAkTRnPxSCpjRcKOFr6mIotxgW1ZUY31oOdOrXgwSQNZ6PwXcWeqoqw9Gkqg4Hx5QoVWwT0H94csGphxEvtzPqHSHOXR8MWXefcxD8jwzR5yQ8owaZAU0R4F1MsITIJjJztRSubC4zR1R8xLzisriNhU5vHiWppHBFRvbelPjUPACJslhXIFQRK60Jxc3u7xsqrFMTNGSUnZjebVblsdDST5N/qvRgAqhiolCf/2Yz++eM7WZM1vmEFi1ASl7vapbpXcO3lkFgI7aUqhv1tyXsjrkoTdNVoTdC6zrP0wOAQOIaNq9B0M5STjS0157Bb5+ad8bPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KKdY3/4dHPe+JelWMgtj0EBI74oOX++4WcSSCMm6lQ=;
 b=EH4HJZxvLNeUgVsPFXy5W0ccbq3+wbZkqgDEFCfHuOS+aLac6BdRl83PXykVjc4a6w9vuaQcoqilusPTyXE7NqfkDGDJxuW5NnBnmCm7ieh0tSZyn0OahIy65h845Z7osrgyjg0XMRSQpkcZ6+7QA1Ny9T1LHpoc1bfGgb4D8EfWjflj1/nFOuoRp8Ip3naEdXNOkD/nq2aKqNV3+tYUcjpY8wU/95/GX0CYagBv8VUcjJWfw3O4wretmqwCyvgHnp+WQp+bUXLlUj8w2+0Px2pVVcn6g/HEXM+q+RkLq1mJ/MQt5rlCggMbUIhrj79gbMKPrCgVGiim68gHCj7KTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 14:48:46 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 14:48:45 +0000
Message-ID: <e3aebbad-42ec-44e5-b43d-b15b9cd0a9ad@intel.com>
Date: Mon, 20 Jan 2025 15:48:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI descriptor
 registers
To: Simon Horman <horms@kernel.org>, Dheeraj Reddy Jonnalagadda
	<dheeraj.linuxdev@gmail.com>, <michal.swiatkowski@linux.intel.com>
CC: <anthony.l.nguyen@intel.com>, <piotr.kwapulinski@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>
 <20250116162157.GC6206@kernel.org>
 <fe142f22-caff-4cab-9f6f-56d55e63f210@intel.com>
 <20250117180944.GS6206@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250117180944.GS6206@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0168.eurprd09.prod.outlook.com
 (2603:10a6:800:120::22) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 130a9acf-1ec6-43ca-959c-08dd39618aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T253VmtYVUxrdTBlTXVmUDFYaDlQNlBBYVlVdkRoMk5jYzdTTkVXaVFpSWxR?=
 =?utf-8?B?VHloeDdOYWx5ZkFqblhyZWRJbHpFSDk3TFZTRTV1RGY0TStLNUJIVTNHZUZT?=
 =?utf-8?B?SzJhNWhRTjdyMk9MZ0R0K0lVc01sN0lPM3g0dFBxNHRWeDVaVmZRZjRtMUhT?=
 =?utf-8?B?QlQrKzdnNzdxY0NjeHZiN1NvSTgyMHM2VnVVa1I4Q3JUcHNLTW5GY0VPdXN0?=
 =?utf-8?B?K3U0RDRYUlB2OW4wODdVbVYyMVZwc2F6NEFFejgrVWRyR2xCMWZrV2c2eitI?=
 =?utf-8?B?L01GTGpScnZkcTRCbHZlN3VuTDc4K0h5eVg3RlJ5Q0FLazhiak52cSt6Ukhq?=
 =?utf-8?B?eEtibXAya2VQOTNWcmVtWUl4emw2dWVOdlBoSW4wNXEwVU1HUm1EeTVOOGsv?=
 =?utf-8?B?SVRDcTNxbnVvdWErcjlBSmdNTnA1elBabFFBOWNDNzk3WitFb1VQeUY1Mnc0?=
 =?utf-8?B?cnVEMHROMFFRVlMvK3FaczRhKzdIM1h3Q1A0TjRXaWVGOGVKbDRURDJlT0RR?=
 =?utf-8?B?a3A0RXVTSXNjMzhOZWFJd2pLVy9rSCtsMlNHcU8ybGoxUkc4Vi9qcG0rc2h4?=
 =?utf-8?B?ZlhqNHFwMXpYbE1JdGJPdXgxTmw3Mk9Jam1FNjJscFBUeDhRd0JhNWpxK3NC?=
 =?utf-8?B?cmsxT0tIeTIyYk9NMEljTHd3WWdqKzJuNUp3c1hDQmlsWmhIQkdpSVdWcU9j?=
 =?utf-8?B?enpYdEVRcFVaMmRsdTRRL2lMeElUTUxBaG9uNHZLSGRrcHNyR0Y5QmtWNXBR?=
 =?utf-8?B?T3NTeHF5Ly95U0s1Rmthcm84Z0dJTEtTcDFINlZYaWo1UUVMSEJkZTJqay8r?=
 =?utf-8?B?TVBxUDVuZFlsOTF1YVZsNHlla0RrSXJTeitBMHg3TEpYRkkxVkFrV0ZUampz?=
 =?utf-8?B?Z1hQbTBTVGJiK3FvUXBhQWl3dzlSM1gvNkwrVlA4S2hIeVNiTnU5MFFXOUpr?=
 =?utf-8?B?cWFveU42Nk9zQ3JNTDNqMk4vN3ZrMHdlSzVaZ3Q0ZHhtZ2lWOWFBYUhydmFM?=
 =?utf-8?B?ZzNvTFMzd2lPQVNKcDQ2RXZ0bnlvTTdtVk1JKzdOTDJqdFpHRkQzRy9BWWZt?=
 =?utf-8?B?dnFUZGRpQUlqdEZLdnZlaWhUdGVIOWp5bWxyWmpRdFZ1bGd3NXBDMUU5Q0xj?=
 =?utf-8?B?MVU3Q3NQcmkzaUgyV3F5MCtJV2JWdFAzbTEvSXRMdUR1VHlHWkk5V1hkbFBJ?=
 =?utf-8?B?QmJwRXcyNUpJL08zaUZnL3FldXp1MnZtWXQyaFhFVDhPWnpGQXJkMmx4RVlj?=
 =?utf-8?B?ajdwZDk2VkZHdGVmMHA2ZnIvdlNHcXNGZjdVSCtkbHVtbnhrNUNNZ1gveGNw?=
 =?utf-8?B?ZHRUU2xINmxMR2lXQVBrOXJqSmliRktJVzFwZjRTZEV3QjMrS2M4dDNNVThE?=
 =?utf-8?B?aFZoODlzN3dRdDFINkYwSDNIY2tDbFdNaE92cFkvVmpXMlFRVzdhdFNyRU02?=
 =?utf-8?B?OWYwMlJ0RW00YnVlOU0vc2swZ2cxTDJPOE56cmR1RTJ6OWh1V3F1QnR4OXF4?=
 =?utf-8?B?djhGTUh2RDB3NWpZeHA2KzVUV01PNDMvRndkbTY1cmJrMjNkUzFkZFdCMEpi?=
 =?utf-8?B?VXdycFovWkRVMVVFTGtnUWxjRC9LaW40eWQ4Yk5ON24rRlZaNWVBYUErRUky?=
 =?utf-8?B?V3Z6VUtpMVpJREFZa3lvbzMvT0hTdUxJUXhjL3gyL2NvblJBM1lpU2x5azZt?=
 =?utf-8?B?SW01dnJRcGJPQmtPRlJmQUtFdlRYYmUwdkhGcW5xRThtd2J2YkpWWVFEV3pt?=
 =?utf-8?Q?gvfAs2RhmwMeycemytDyh/heIh02zjBDr4MTgDZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ZVQUZHeTdydFBGR09rSWx6Y2d6RXhmY1pkOEhHVjZRY3E4eDBMaTVNWUEw?=
 =?utf-8?B?Z1g5NzUvWHlyNFVyTktMSjJLckdvRi9NQnZVNXRtVVFLZzUxV2RnRCs3dDhB?=
 =?utf-8?B?dFpKQkZ1ckJ0bnBhSy8xMXZkQS9VMzI0SDllSjVjbjR2WUpSV2g4L1J1U2FL?=
 =?utf-8?B?cVo4QndZRUJDVHhsTkUvRWlBWXJhRTlNSGoxc2NHeVA4NFZJWmxnTmR4OXNQ?=
 =?utf-8?B?T1BPcHpJSHo2T0ZMNElCaDJJWU03Q1NOd2xRVUNpZWdtQkFFbjhSNnNDRXhk?=
 =?utf-8?B?STUzZkN0eHo0Qnk0Yy9Wd2tnZVlOSkxPYkRpWC9ldi90MkJCZjZWOFRRRVZS?=
 =?utf-8?B?VnNGUGF2MkQ5cDBFR2NOR2k5SmVTZ1h2TjhEMDR1bzRYSkJubjN3MDlNVEN5?=
 =?utf-8?B?blhST3RVZXozWkhXSlhrcE9zMlc3RVJUQ2c0TFpOZWxkL01HV2RzVmNZWmhi?=
 =?utf-8?B?SnJMN2FRTzd0S1BEa0I4S3FCN3o3K0E1R244clZTMW9LYzZBa0lQUjJWalBZ?=
 =?utf-8?B?OTlyRldQdFAzYkZYVmY1QkdIYnp4NE5TMUh5bHE3UCtRN0c2cHpXUFY4Z1hm?=
 =?utf-8?B?M29sYXBIUUdIcFBPVHlBOWw2aVIvQ2dWZXlYMkxRcjRIZVBDZVNndGYrTjFG?=
 =?utf-8?B?YndVeWwxOGxOaFBQN0FyTVN1d3ZvWjZ4bStkbmR1OXRqVFp5ckdVRkV5VGVZ?=
 =?utf-8?B?SkpmalQyUDFlTFhrOUIvWUpzTTcybXYwQkM4YVdwTHpocG1PWjlZYnE5MkJu?=
 =?utf-8?B?Y3I4MUxhT3BZL0NWVFk3dHl4azl4VFNHUTI4R21paWo5YUpUdENsSmJ2clRD?=
 =?utf-8?B?Q2hCV0xtbHpjb0MzMFNhUWVFc3BDMjhSN25JVkFYaUNoUEU4d05scWlValRQ?=
 =?utf-8?B?SkZBTkZta1ZDRWdjalNQdkoxSTJINENJUEE1Y0N1WWZwT1BldjRqeDZjcENo?=
 =?utf-8?B?U2UvUjFPbC9pSnNQVy9qL3VyTkdqUlZLQXNoOURUWlpjbUhvYmgyN1hPQWVH?=
 =?utf-8?B?d2lua1R4c2JyMkFXZ0xsUFE3eXZ1TGt6aUYxREFSTFBVdDRNYldPb0twZWFF?=
 =?utf-8?B?eUhHQnlaSFFvdllJS2w0UUxHNnoyRTI1YXJhREVzbGtsaVdRV2pLTjl2MjFt?=
 =?utf-8?B?ZVJlSHpyQ28vWk9sV2JwM1o5YlZBM1UzRnc5aTdRSFEzV1luSHZYOENLMXdE?=
 =?utf-8?B?aVpRd3N6ZkRndUJwdGZjUXcwSE1wOGxNd1daelRqcE0zVUg1Y3JvZFJTTjkw?=
 =?utf-8?B?LzNSVlZZTHkvMnFOeEV5aE9pZ1FBdWpzeEZ4V0Z2MkZHWkpyS2xuK2Q5bk93?=
 =?utf-8?B?bEU5OUtUNWozTm5Xblpib3QwU0N6VjJ1aUtQOUtleEJYWkZXbmlIS0dYWEwv?=
 =?utf-8?B?c0RTNjFQTm5VM2orNTVFZ0loQWdnSnhqdWF2QklGUzJLbzl0OTZSR2xKSnVv?=
 =?utf-8?B?K2J0WkhDNUFSakNLQXIxWmVyemxsNlJrU1BrNkFvNmFDWFFzc042QVB4Nkxa?=
 =?utf-8?B?d2IwYU5Ta1Z6Ly9EbW1ha3dPTTRoT3NaYW5EV0NzK28yQnBLd2JBczhzWDJR?=
 =?utf-8?B?M1BsWDA0eGRDb29kUENmcGY3dHowOFdCaVowQWcweG9WaUs0aHc3eUd5ZXV5?=
 =?utf-8?B?YXpSdUJ4ZjZLUFJORXVsdlFRQXNsOTZKbStUMW1laENzdWFsOUtuVU94RnJm?=
 =?utf-8?B?OEFFUjFJQnJkV2JObXBEcG05Rit5QjNMdjNmbndzdS8wc2FaT24zVm80WG42?=
 =?utf-8?B?ektielFzc21WRWNkRVNJdWZnaGlacTcvbmEyTmtkM3UrQjlKcndld2I2Y2RH?=
 =?utf-8?B?Q1hDQWNYRHVQTTRwTEdWamZ3eG5aMGVGSG9mdlk1QjNHTWVnV3hZSFA5RGtC?=
 =?utf-8?B?cFJtWDR1dDhGZ3FweUdFWWhyc002RDlMeTB2WFU2VGNzemlNM0RhZTU1QmZT?=
 =?utf-8?B?cm5OTDFaMi9YNk96NWRVL01WT0ZiSUU1NmU3bHozZTZRNEsxMVIzSVVBbWp3?=
 =?utf-8?B?WGp0ZnZndFZ0Z3F1dDY0bi9HZkxhaGw1b1NGVDF5THlRQUpneDlWTHFHZERo?=
 =?utf-8?B?RWVZYWpHRjF4ZStjZmh0dnFOV2d3OFpVVjFaVTZUbVdjdy9WZkUzNU45d2k0?=
 =?utf-8?B?TGttY1NodTlTZFkrWDJyMy90L25PQk5hVjdFSG9zL0FDTWliZnFnVzQvdkQw?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 130a9acf-1ec6-43ca-959c-08dd39618aac
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 14:48:45.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPI5y0JmSpKs2zmNtqLFSMeX3DMC9WnqJaccBIl7qBjeiVDMN28MModzVOFJDZuz5dg/55glpqjk4lZ5tJ3M5rF9c9kvt+FQdnJzqw8wqXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
X-OriginatorOrg: intel.com

On 1/17/25 19:09, Simon Horman wrote:
> On Fri, Jan 17, 2025 at 11:01:22AM +0100, Przemek Kitszel wrote:
>> On 1/16/25 17:21, Simon Horman wrote:
>>> On Wed, Jan 15, 2025 at 09:11:17AM +0530, Dheeraj Reddy Jonnalagadda wrote:
>>>> The ixgbe driver was missing proper endian conversion for ACI descriptor
>>>> register operations. Add the necessary conversions when reading and
>>>> writing to the registers.
>>>>
>>>> Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
>>>> Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602757
>>>> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
>>>
>>> Hi Dheeraj,
>>>
>>> It seems that Sparse is not very happy about __le32 values appearing
>>> where u32 ones are expected. I wonder if something like what is below
>>> (compile tested only!) would both address the problem at hand and
>>> keep Sparse happy (even if negting much of it's usefulness by using casts).
>>>
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
>>> index 6639069ad528..8b3787837128 100644
>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.h
>>> @@ -150,6 +150,9 @@ static inline void ixgbe_write_reg(struct ixgbe_hw *hw, u32 reg, u32 value)
>>>    }
>>>    #define IXGBE_WRITE_REG(a, reg, value) ixgbe_write_reg((a), (reg), (value))
>>
>> Simon,
>>
>> As all ixgbe registers are LE, it would be beneficial to change
>> ixgbe_write_reg(), as @value should be __le32, (perhaps @reg too).
>> Similar for 64b.
> 
> Understood, sounds good to me.
> 
>> This clearly would not be a "fix" material, as all call sites should be
>> examined to check if they conform.
> 
> Sure, that also seems reasonable.
> But do you also think a more minimal fix is in order?
> 

@Dheeraj, do you want to hone your minimal fix to avoid sparse warnings?

follow up question: do you want to proceed with a full conversion?

@Michal is going to send patches that depend on this "full conversion"
next month, so he could also take care of the "full conversion".

>>
>>> +#define IXGBE_WRITE_REG_LE32(a, reg, value) \
>>> +	ixgbe_write_reg((a), (reg), (u32 __force)cpu_to_le32(value))
>>> +
>>


