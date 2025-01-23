Return-Path: <netdev+bounces-160526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9AFA1A0DF
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EA918822F2
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10A420C03B;
	Thu, 23 Jan 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOlnhCMo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676781BC3F;
	Thu, 23 Jan 2025 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737624796; cv=fail; b=k8QzGspwO45a2u93ogBHffxI1Ml/+2oJwu4Wz0tftfebmzPfyltoMPvGcj7kD9kSuk79oXcmta9uchpolpejs4iPgTyX2UH9S67yyBprwwIiq57OokQrsJgOBQU91eJe2QnWKoLOhajQn2hu7k7dmkOJ8rHxistAW+pJKyakNAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737624796; c=relaxed/simple;
	bh=k9xfm5bpqUGpC4eiiAkSISSxFtlGsuDWs+4XCrIvz6Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n3WIFpWGfHx038W5q7RFu6KXCZ87dDO6gP8I3WGxrCChEzP2qplo2kwPsPlIr/p19vHVPrRxS7EsYEQLomxz536bPgwisMKGjW3LshkpbYenD49VUI/i8qtQ3TxK4LhiGTD//RtqGn86MXUO0UpTYiYjRpTM53PPYyHK8SqDhwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOlnhCMo; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737624795; x=1769160795;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k9xfm5bpqUGpC4eiiAkSISSxFtlGsuDWs+4XCrIvz6Y=;
  b=NOlnhCMo2GnK5n0EVZRAq9drfNqd8Qcjs8oxBZdQ71OLxXmDWVz80tiw
   SqO0++IbNN7NQusY7Pbe5UFACWvuytMZVIBgMk0TVOXGiwayj+y6duFCU
   2Pc3nh4HRLx81lyBvfjPMsWrzTqHAR+h0bfSapbZXPYHg34FNfzY+0Frf
   IcxSlMxnbPAh4e86OwMne4yfjEaHKZPe66BvQSpD7Mf95yx5BlisgXo1P
   arvwPMotFkxu6E3XT3THJ4UrUVIbVAKXdedqVwqmtPeECvhzO8DMZ8pxH
   qL43YlzS3S++SsVrE3aF5I6VoHNe6PJV3GY6ALgx5iDu4gfdKDuVuZAgW
   g==;
X-CSE-ConnectionGUID: XB0T8OqqQ2eP00y0xIY7Zg==
X-CSE-MsgGUID: n5qV/YK6TPS9fHpQVxXHSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="38363965"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="38363965"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 01:33:13 -0800
X-CSE-ConnectionGUID: Cczr19EaSWa7Hwxa7DNJlw==
X-CSE-MsgGUID: HdiijQpBQ4WQ6PNnSLThDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107324645"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 01:33:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 01:33:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 01:33:11 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 01:33:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ppj2ZC1g3pvPHOUbIjY9LSwV4PXB5kYSq+3sFTk31WXVnrMt1pzYHGG2p0hJKHpuyobnarQBDSHmRmdaCUVNbhYgT+/l3xmLPYhCEO1W/16opEnf99hOrIAZzebtWAezxbGz0hGmDnGb1oeS8XyOszitIobnlQq3dgWIbnJYlWeNld++Fh4jfU2aVkCMPOYxXFBSO3zLgf6LftnL4bizdVG1s+ruyhZXal4cwWhcE4mHtc/Qu4XzYlXxqp1Mpr3acWe1oHJeG9YV+VtR+na88QLqUmPoo8Q06IgYZAFM3uxUQRJ6aJNd3WIAQKZgYzCqjfd1A4K/clGtMzWu0SmFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EKoaKQY9MnbZNehmrdlwTnk0gcarGfYUQNggOKFY5o=;
 b=lhL0O1lB7UquqaT9dZ5JJAGi70GLfmqBHcnFqXSePhf7TfBa9AXfJQGeiylkoQ7R72t1kPzzqjyv5f2IcxFRGbLhEuFEtvosHVhHKuwfFRAsqmeKC3JOirv2GyrOvlSEhteaXRWkwzXN/4Z2JrTiNFQrSXxviRFPKCWmmztvde3gDinTkziaqr0CNFreuZ54kquqwxqPAi2G55BD/A6vbzYpk4YZwTd8N10TiHYfWWggcXIquqa4Y//qtsycKMXEpy5y6L6Cs0uap42y5PQk5VTwieBYrVroU22zeg+o7VmqfGHPJD9ADh5oWBgvM8m2Y7qr7FvGCEUWfk0o4wCQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CO1PR11MB4916.namprd11.prod.outlook.com (2603:10b6:303:9c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 09:33:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 09:33:04 +0000
Message-ID: <b001ae7f-d250-4f3b-8d2b-29b6c5adb642@intel.com>
Date: Thu, 23 Jan 2025 10:32:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v04 1/1] hinic3: module initialization and tx/rx
 logic
To: Gur Stavi <gur.stavi@huawei.com>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <helgaas@kernel.org>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>
References: <566b3d82-5e66-4e97-9808-a0e8e212fe67@intel.com>
 <20250123082016.3985519-1-gur.stavi@huawei.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250123082016.3985519-1-gur.stavi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0248.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::21) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CO1PR11MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: de1e26a5-eef7-4cb6-4712-08dd3b90efe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFpSZHBGcVZSZ3QrTlh3WUtqWVNYdFVlMk1QSDhRNER3cG1NZGpZMGtzUTc5?=
 =?utf-8?B?YUNhWCthQU52OXc0ZXBtYjZ3VXNvWXRhZ1FjTTBiOGFFZVhYREo3Z3ZsY0pE?=
 =?utf-8?B?cWFiTHdzVVliZHZwTWs5bWxPaUphckw0bzJYRm1KYlMzbUc5clRxL1dyNWFo?=
 =?utf-8?B?MWlMK1V3QVNsdTI4SllNQkpXTnZxNTBodk01VGkyTjNqblRRbEtxR2xJblBF?=
 =?utf-8?B?a21aVkxiL2VMMC9Pc3A3UWdWeER2UmI0aTBBTmN4M3g0ZGduM0pZWE9UaVBT?=
 =?utf-8?B?TWI3QmJrdkttT3F4MFpVNTJjaEo4VUk5ZVI3WEpyemF1UGN5NGtuMjJId1hV?=
 =?utf-8?B?eHBNTElVenBwekZVTldteVZMcmlvd3dzUUY1KzROUkVIa1Z1Vk56NWRNdW9w?=
 =?utf-8?B?bzBvL21WWFQxWkJRbS83QlMvU1c2WjdCMmVpRnNlYXlDVm5iMVpHTHNndlRR?=
 =?utf-8?B?QXVodTlZbkRLZDRQamFVSllYdFN3R1F0L1c3WFlOTDlZdHpvUlpsZzhNcFpH?=
 =?utf-8?B?bzNhV3ZidkdrQ1dDL2RCbkNNZENDMUNYVjlVRlNIWFM2VUo3ejQrem1uYUhs?=
 =?utf-8?B?d0huRHhpRkduamVxRHhzVDg2Z3VKNGJLZVdxanVaS0lnVjZxM1NoU3lTbG5k?=
 =?utf-8?B?M1JGYnNWcmhFbWNyeE84RXkyMTd6dGdJUDFkMDluQVdib0g4REZkV2Jnd3V2?=
 =?utf-8?B?cEhyVFlGdHd5MmwwUEF0Tktnc2RzK0lOcjJKVWtab2wyNW5zKzZTVXNXbTZ5?=
 =?utf-8?B?Yklhb0hFNzJCSWpVaUtYeXNJd1lQV0U1QU1OeGNQLzVZa1FtT1RUUktBNy9x?=
 =?utf-8?B?YklPczF0aGJJNXVLajFvUlNidUVUWEdiQnF2RFVuUHBOM1dPYkZNQjY2SE5I?=
 =?utf-8?B?ajJvVTZlY2dyd2VqL0xZakdMZUJwWm5MVVVZd2RMYjNpZUh6ZkIzTi93a0hh?=
 =?utf-8?B?N09FNGwvblFuYk9CT3Bld2NGZ3NQMzlDaitUeXlCSEU0YWdObkVzcHU2VUtN?=
 =?utf-8?B?VVpTQjRyVUxjaUY4aE82bUQ4T0FhdUZyOWJxODMwVW1jUm1OOTZhZ2tpRTZI?=
 =?utf-8?B?RnFUcE9UaDFYQlpaZUpHWFo1cTBhRDVaT2pSWkIxQktCS0JYTmp5VDNVdjVC?=
 =?utf-8?B?UXdiVndTcXE5Sm5sV1Babk44R2syVDRVbmtkQlFhKzY4M25ML1E0Z3l3emZl?=
 =?utf-8?B?N3RWUHdZWnprVC9QTFVuY2tFaXp3Z3pzYSs0eW16KzlOek93VDhsZHJQWTl0?=
 =?utf-8?B?dEJCSURIQ0Y5bURZY3R2TndqblNxMDdZTFNCb0hXTkJ3cm1qV25JVUJrQ1c0?=
 =?utf-8?B?Tk53SVJzTXAvOEIvVm93MjEreDd1OFhENTdNSlJlUjBLeDFFZUh1d0JFcXVG?=
 =?utf-8?B?SFdHeU1RTVdLNmN2b0cyeHViM09KTU9BSmpXN3ZSbW9CNGF5ejNFbTNCdFVG?=
 =?utf-8?B?T0Y3TUdOV0NCYlV2TWtZN0tzWkhYUDBFM255SmV0Z1RwMEZIVVRtZVFhbmNU?=
 =?utf-8?B?TFhwN3hYRzV6MTV2T3lYZnFnWWsrMEZEWDF4SXBmS0NIQTNrSURzRzJBTkpj?=
 =?utf-8?B?dHRrZ05XaUF1dWl6Q3pxN04rcFNkaXJheHNmUGo2V0hRR0FvcWNvb1YwZXV4?=
 =?utf-8?B?NWtTYTgvdElkU2EzNHpkZG52WUlwVTBkTGFIMkU0VnMva3BHOEFycnBZL01x?=
 =?utf-8?B?RElUU0g3Vk1BcGdhMEx1QjRRRDBVMjRsQjBHbHMxVXN5bTNNNEkzRE10em5l?=
 =?utf-8?B?MjBMczdGblVkMTZMTFAyaXBZOXZxLzlIWFVMSGkwRW11VTZrVGhhVTNIcFFt?=
 =?utf-8?B?bldXNWEvbHdkbzIzZUVRNExKQVRrdTVLN2JlSXhDa1hoRXNtR3FVWGFvZXly?=
 =?utf-8?Q?fPeOjad4AxhfI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUMrZ3NidGh2Y2JmOXo5K0pmRzQ2K3YzUWYzWE1LUzlXWkZyN2N2T01sbzA5?=
 =?utf-8?B?RFQxUE9lb0p3OXdvdy9OMXd3cVR1dm83bnRNazdjYmhybkpSOW4wSi9KY1BN?=
 =?utf-8?B?QWtTUm8zNy84WEZ5MDRzZmtkUmkwTHhmL1VoajdjbVY4MUZDVnpFeTJhVmo1?=
 =?utf-8?B?b1YrK05vUUt6blFKMnNqTWhiallvZEd6ay8wTUc2WllUMVF4T3NOcVVtSlFR?=
 =?utf-8?B?K2ovTmVLcUxzYW91Z2NKSWdZbWJSZENCcnpaMStQKzFxN3pBcUlucWs4cmNy?=
 =?utf-8?B?S2oxUHJRL0Z5Y1FZeUgrUUJoYVZkVnhnWE1vQlZ0b1NvYmVJaXdWcDdvWUdo?=
 =?utf-8?B?MmJZYTI5YW9DSWR2b0UrUFJ2eDlBVDJ3YUJtV0Raa1hXT1pWZXhrWUpNYVN6?=
 =?utf-8?B?cE8xRmZkZURiK2drUkROQmgzenhxZDhCYmh6TFJIaFBSVHBzTldFd0wxaVpa?=
 =?utf-8?B?a1IycE5rTmx1L09TVmUrMUlGTnk2K29vYUJoc0F5dllWMHArOFFNRytoMUZv?=
 =?utf-8?B?aHVSR0tMMXdmOWxMMUpwa0RUMTVUQVZrengrTTBVTlFOMXh0WThSNThtYUxB?=
 =?utf-8?B?RWdjNUFUVFFwNEJydzZxSE9KRDRPMy9OMStqT0psMmc5ei9wUWMvU0hqa2h2?=
 =?utf-8?B?eFNRZ1c0MENRQW8xdXhvUnB3bjdaeGlzUGI1Ykh3a2xERUwrREt5SVEyVkZI?=
 =?utf-8?B?TDIvOVpGaU5KYnJtTjlFZlJlMlpaRE8zZkdnU1JRMC9wVk1ES3hpOXNYK0lr?=
 =?utf-8?B?Rmh1dGo4YkR6Y2FzdFl1MVBCV3JDcG1xOVJzVW94c3JwRFZQSk9SWXRSL2s2?=
 =?utf-8?B?NlBFNG92ZkdIT1AvMkx5Q1o4OG5kemltRFZDOUFWclB5b0daZlNsTlVCcklp?=
 =?utf-8?B?N3FWdWl6elJBbGpGMWJpcnQ5aFM0VGdqZmdFQnpUSlR6N3hxZnE2YlUzeXpF?=
 =?utf-8?B?T2hJYnArR0xWU1p4bU5Bd0xsMjAzZC95WWFmaEtsMm5QeDVyekxXTmZpTFFU?=
 =?utf-8?B?VHkvMk1IN0lBN29Hc25FaDFzcEdNYWtQcDA3YW1qUDlMd200dHB3ekd1WFR4?=
 =?utf-8?B?UFlESVVJZnR1emlsMWJDVnA2YlNZeUUyL3lSMDFETThPVHdmSXRqUVc1WkpO?=
 =?utf-8?B?dGdqVmdGb0VXeXlaWmJxY0g4MjBvd21NaE1BWGRmRjZVMmZ6N1VLU1Z2ZGFY?=
 =?utf-8?B?OVVWVWxjMkxvRUxtNGVHWFBMK29pdUJmTUJpQ09oMmt2dzV5SkhjakZkYTY3?=
 =?utf-8?B?OXhaQkZjTk1JUk5mZVBxMXN5VGNvRkdNRGgybVQ2SFV6RUpzdG9Ed2RjV2wr?=
 =?utf-8?B?UTVud1MybTJ4TkxuVERWRzkwdzd1UWJKREkyeHUrSzJraExIdTJvYllIbGoz?=
 =?utf-8?B?UmNZd3hyUnkwVXNud3BNeXdYZ0pBdEozdlEvaGJ4bjB4WkFudkNWdjVQdEZE?=
 =?utf-8?B?MTE2YnJzMHg4K0czc1BHRmFwczJwc08raFNQYk1qSXc2aUUzSDBmcGkzS1M4?=
 =?utf-8?B?SVBOTmdBU0gyWUhLY3RUWWFoODUwdW5PMEVqRmNjTDlqU1VVQytsOEVhaTdH?=
 =?utf-8?B?V3AvWFlGRkcyem84aVg0T094QzJUVTg3VEd0SDNRdHNDcWZlTzgvR0ZnR1hS?=
 =?utf-8?B?UFhWdEJUNXJvSWFCdndBdU1iZG9OdkRkWUprR1ZDZ1owRTJTMUJIM2xlTmNB?=
 =?utf-8?B?dWM3d1QyTUVQZGx0WGRlZVRONVgwL0s3SkhSdkFBaWVjN25LZHl2bVlGcnAx?=
 =?utf-8?B?UjJ2VHpUK09Ceks3MVhFVS9MVmhZRG1LM1dLbE8yWGpFdWdnL00xSDNMaWVi?=
 =?utf-8?B?UUx6cnRHUG92SGtFRHpOcmtLRGg2eitrUThaN2tsMi8yakNsVis3T0NQRExa?=
 =?utf-8?B?aTdjVFYwSFZyN0Z6MWxPdEphTW5PSG5IOWx1Uzk4YUNvUlg4QUtveU9tUkl1?=
 =?utf-8?B?RW84bG9ldVdDMkdHWnFVWk5YMUhiNDltM1R6ME9ONXIzdmxGVi8yaGsveGx5?=
 =?utf-8?B?bUcwWmxadHY5L3hKdUlQR1o4TERTcm0rVHFhMlBleWY0eTh2UCs2NGNidDVo?=
 =?utf-8?B?TkJDcnpuSm1NZFlvR2pMYnhhdUpscThHb3hCbWkyOEdpcFRzUTR1UVFkM05z?=
 =?utf-8?B?bFZUQkhKQlpWM2lPcXh4MHlhQ3ZYVXFEWjc3d0dQUlJrL3JRVlQ3ODBPb3R4?=
 =?utf-8?Q?fuZxR4NoVZcVOgiA1Mq7LMM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de1e26a5-eef7-4cb6-4712-08dd3b90efe8
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 09:33:04.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKBswEjArfvaY4S3HBdHAMh1L0IUdsc28vYWtBz8Njxq6gAfi999FLGZqMpgOFO8uWcSbbEr89a2A6AdyhWMoNHFvWLxLD7ezUlgKAcejpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4916
X-OriginatorOrg: intel.com

On 1/23/25 09:20, Gur Stavi wrote:
>>>>> Auxiliary driver registration.
>>>>> Net device_ops registration but open/stop are empty stubs.
>>>>> tx/rx logic.
>>>>
>>>> Take care for spelling: Tx/Rx; HW (just below).
>>>
>>> Please elaborate. Spelling of what?
>>
>> In all code comments and commit messages the acronyms and abbreviations
>> have their proper spelling, like "Tx", "Rx", "HW', "SW", "ID".
>>
>> of course lowercase names are still allowed for variables/fields
>>
> 
> Grepped drivers/net/ethernet (whole word only):
> 
> hw 34681   HW 3708   Hw  170
> sw  1198   SW  675   Sw    3
> rx  5913   RX 4042   Rx 4042
> tx  5424   TX 4095   Tx 4907
> id  5545   ID 1967   Id   56
> 
> I don't know a quick way to separate variables from comments but I
> believe that there are very few hw and sw variables and most tx, rx
> related variables will have some prefix or suffix so lots of the
> whole-word-only come from comments.
> Can we agree that while Hw, Sw and Id are improper, the remaining
> forms are acceptable?

"tx", "rx", "hw" are very common variable/field names, "sw" could be
also a shortcut for "switch"

If you want to argue, the stats should be only for the comments, and
excluding things like "@hw" from the kdoc.
But then, anyway, "current code misspells a lot" is not a reason to
continue the practice.

> 
>>>
>>>>
>>>>>
>>>>> All major data structures of the driver are fully introduced with the
>>>>> code that uses them but without their initialization code that requires
>>>>> management interface with the hw.


