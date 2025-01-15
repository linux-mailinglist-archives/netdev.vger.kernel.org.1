Return-Path: <netdev+bounces-158525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB1A125FA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6CE161672
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C26577F10;
	Wed, 15 Jan 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcYtsP/h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DF7080A
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951113; cv=fail; b=hrSQPeKRvxyU9GiEisekSWjU0wVWBC8Bes7kbt7de4THnYlyNDVydlsrwEGAeccChW9I9gLcHpDAwr5F4s3/kWggbVFF2KaVaKGDWCsWpF5BMNuP/eJNt++4LoQqBRt/4nvox1cSzMtbkrtFWvLIOlfuekrughUsfb577rmjQV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951113; c=relaxed/simple;
	bh=KHh5XBjGF/Z6XO9EXWsmW2/zrZsNT6Q8jjj9fPyXhxo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JtpfT44tOyHcALlGe2InzYDiyUJHE+tOSalP61BLSuKvANGJazZOcQ+CAo+HzdCXCZdhGgoiK+LQgtNPh5yzizz16CjpP9cSzQw5Glqd36mdj4ZNr3Mzwi+B4dxuvGZzOTwnC2Fz1CAynwQ3H5yw3aCFputs9Of6DQ0ys49uOrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcYtsP/h; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736951111; x=1768487111;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KHh5XBjGF/Z6XO9EXWsmW2/zrZsNT6Q8jjj9fPyXhxo=;
  b=UcYtsP/hY8i9Kyb+Yt8NAgaNE+Z3+n7xpmXwv4vIRe0PT/5wHKZH5cP8
   7M28LEaAKNd0blDqta0keIa4+mMFI73fRK/iSEOZYlf0LKqHGADosjce8
   ZtsBbecKcWlJCQDoNq4CfrdXFd62lgriCCiVyCHbUkxpLRG/donZa7cRy
   tKhprqWAdPt+xlPDg/MDHBSJRDJhRUoQ/RYHHtj9eiqfOudGRwIw6UT8G
   rg0l/SGopNAU3HvLMUHDneFcPQhuD6p/MChnKRrMEsqtjlytHylW93lHM
   3c3hNsQFokGfwBMZkVoU5g0tBuPhuj0hcN0UL4r5VOC1tMLE1G5WgiG0+
   A==;
X-CSE-ConnectionGUID: F9Z/Gi5HT1iZC7FulKN7tA==
X-CSE-MsgGUID: VKNUkwRpReqYK9uhVecm6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="24888399"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="24888399"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 06:25:11 -0800
X-CSE-ConnectionGUID: dQNfV56bRl6wDHJrMnxIOQ==
X-CSE-MsgGUID: YqHhoTeGSbGvVelWHvFs6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="105347416"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 06:25:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 06:25:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 06:25:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 06:25:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JU3r3f9RfxXJ5yxUP1/6gug4L4T69J0WpbfX82IVxkaxePx4vqoXdyAZFvC3p4M6N4nkWRKUYZeFh6eSUe1gqmqJp9YR+d6fsSGDvlsJJNVLuGhZFxI38yzJfh7MlQpDFeLy3ZcTg2ilWDiPSiQqXiWi66veUT0kJoTmZHjnIIu+dsV+/QS1udbuwDeWWyctSxv8Mujbv6OqYsUG8TD1Iu4JZxWGIy0WrSg1rg5gI85P+Ui/Z+4Z5laNyX6UPqZWAo2lnPxB0RcH4EzcmFkJzN/K1pu73sMew/p43YxAvAJaqgS3UoxBfIgZTpBKv7aaVT0T8DIxUBEJbEd4xnqtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6YYucIB4TxVxsh9tZqrPHgFmkXS2O3I74eQYmaP/vI=;
 b=dpGe5YYQ/8emzjVKnBJhCNreQtSm9W5j0AwZh1Q6tuWareqGUJpd5HsH7Kxfcc8eWSscnsE6TAaPTBUcS8/nHioehyIfACzTFH+7CaG0CZxMiseL6UhIznZSPHBopY3CbBfMvyq6frZJSxOLEh+61ixd3rp3q/RuMit8OVMbCILikZsWlRLglrQZXIJahzkF9TMIY4PIxF2uqRRNDPRJEUCUogeOd6uBU41OzB1jYInL/Qa6NU73lxsew2JJdSbeNXGymBnJmBAvHudQCGcNMRtIIAvgl/Xk0jfmwJ9giM1CGzS3U4eDZy36R/HIcsyfz1XvVztwZrnEVeusX86KkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 14:25:06 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 14:25:06 +0000
Message-ID: <e8861e2b-6056-48a2-897c-9fa320eb2e80@intel.com>
Date: Wed, 15 Jan 2025 15:24:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/11] net: add netdev_lock() /
 netdev_unlock() helpers
To: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <jiri@resnulli.us>,
	<anthony.l.nguyen@intel.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <jdamato@fastly.com>,
	<davem@davemloft.net>
References: <20250115035319.559603-1-kuba@kernel.org>
 <20250115035319.559603-2-kuba@kernel.org>
 <e7479c79-525d-4796-b9ed-7ae2ddb5435b@intel.com>
 <20250115060853.0f592332@kernel.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20250115060853.0f592332@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: eb457680-0fbd-4a99-e22c-08dd357068b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NElBMnFhZk9pWlcwVXEzRWZuRUllMFBWQ0JzMTN2alplTUhKUzZVWGx0TGYy?=
 =?utf-8?B?dkpPSWpjUTJxbXhVNkx3YmNDbXUyaVFhUXZYcHgvUE9BQnNiSW13VGROb29z?=
 =?utf-8?B?cjJHYXBJajFtTHRxSldJWEY0TDRoRWQzMGZ3L09zcUZIa0pPbTRRYjVTVkxV?=
 =?utf-8?B?c2VzVkdoRHRMV2srSWN4Q0U1bk9JQW9RdGdMV21OanIrV2FDVjdXNjAxc2hs?=
 =?utf-8?B?WHF6aWZPSWZLNlQwSlp1NVdwVVBGMTVNb3FuL0hxU2k3ejR3SUI3T0h4SVFi?=
 =?utf-8?B?bkRuS1kwYkpEblFPeUJGVERzMXhhZE1MbUJ5bzBLVWhVRjBzVW1tUHJKSWc2?=
 =?utf-8?B?S1NOdnJ6clc5R3ovQTR3RERYL1o0SzlqYmt3RWVqV2Fva0xqRi9KeisrZk1J?=
 =?utf-8?B?Mm5DUG9FbkhOR1pjYzdIcDdXV0ZkUEpER09hVERuNThnT3ZrT3RIQmZxN1Jl?=
 =?utf-8?B?T2RzckEwWFdnWWNqeUZjb3J6WEtaM2dwRmhaYndiNEs1Tms5YlUyS0VIY2pC?=
 =?utf-8?B?ZTRkOXVodkI3VFdkamZEbHQ4dzFybDBTTittVmgwdnphU3dKa2t3cUpoNXV0?=
 =?utf-8?B?dGtrYXBRdS85TjhxMTBoZ1FVa2RDQktlZlVnbTNlSExGcjZEZVJFUmU4bHNM?=
 =?utf-8?B?WGhnSFVlMDRhdm1LNVROTEtRNWJVak9xTHZQdzV0Vk95VnpILys4M0xPZUJr?=
 =?utf-8?B?M0JFdEREWHpnaDVjc3NhVXd4Mzc5WHR4Ni9pbkNFVU5wSmgybXBwRDNialdq?=
 =?utf-8?B?WTFrR2xXR2E3V2tOTm5tTnRHeXdKYmJXU2hZaWkzWlZ1bEVVUjNaZnVrT2FH?=
 =?utf-8?B?S29Kemt2M25rZkwxbldnd1lXcUtqNTFYbUg1TVRTTWo1SmFON2NRWEEveGZo?=
 =?utf-8?B?QkxqWTVIcmpyYlZiMjA5T2JXVFhRY3p0V0JBcldZaDlHT1Bha2NpWlRsMCtw?=
 =?utf-8?B?TmJnNE55OCtJNGtzNkVveTZ2a21qbytxdFdNR3I4Wjd0N3Z4ak4zZWNabVZp?=
 =?utf-8?B?SE0yRlZPTmJSY1dXUW51YXEvUHpMTTZLZFgybEFrK1htbDdTTjNjd2JWL1ZQ?=
 =?utf-8?B?ZnlXNlMvWWxKNVY2eUlWS3lSUDFZWXVFQWtJYVBad2kxaDNsUUJFOXFGaEgw?=
 =?utf-8?B?L2dCNmVHdmQ5Y3pOWkxQTlNoYzdFQmlNY1VaemRHa2FSSkVFeGlIU09UWHF6?=
 =?utf-8?B?dnNrSGd6RGZ0c3M2T1dWNHdaV0VPSEtGVHFacU42L1QxUGJFKzlBR2FiYjAw?=
 =?utf-8?B?UkR1UkNWTjN2MjFhSmUxR0JsSXp2VG9MbVBFSDZUVjFTd0RUWjYvVEkyOUhv?=
 =?utf-8?B?RWlpa0dUQ2cwZ2NLR0hCZ2sxYlZBdW82L0RoT1VkWDFSVHF1Wm1GdC9mUjMw?=
 =?utf-8?B?T2pBaUgxN0hMLzAvSW9nOE9NbkJNc1lIQnQxdDhHbVh3V3hlNnJTaWo1Ymt0?=
 =?utf-8?B?Q2IxMXd0bmlFcEtjaVA3Z0tSNzh4ZWszRnlDVDdGZ3BpSGZvMGRNdG00NnlP?=
 =?utf-8?B?YUxQVEhldHBHcXE5Q1k3elJsMGU4Q1lXOG4zSzV4VWtLNHFyaTVHR2RQb2tG?=
 =?utf-8?B?NlI3QkpMUWg3UC9BV0YxUHYvaTI3SURkMUJXWmp0bml4dkd3YXlYOHYxSm5v?=
 =?utf-8?B?cnI1NGU0ZEpsaXRHdkViMlg1UzlzZlE2cDYvZVZuNXUydXhXWWRsNTYxMWZz?=
 =?utf-8?B?NXZRKzhHOGV0amhkMzZGckZwbHp4ZDhxQzVSelM2ZEROY2tlcHloaElVTHZs?=
 =?utf-8?B?dS9LRVRXd0xSYVdlY2NzRXhWbVhEeXA0ZDZQejFVMEJFbUM0bnRzbVAwSE9Q?=
 =?utf-8?B?V3pYV1F3Q21kaVQrU1NzVnFvWGQwbXhHcG4vR2RKZzdQamRSVFpIMGNlMUtz?=
 =?utf-8?Q?t5tGW8MVtmlbp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXpmMzUweDI0UUtmUjYvaXJUY1g2bVhxYXhJai9UV1E3WWVwbTRYTkVRZVpD?=
 =?utf-8?B?YWZkSFlSZXh0d0lEZHA0SW1CbWp2WE1YdWg5QUtFbFg5dU9MN0oyZjNuZG1v?=
 =?utf-8?B?bE1rR1J4azBmcmR6ZDRNdzljRUtEcjRSaDlhY2JHcXBENGw5eVRLZVBLNjl0?=
 =?utf-8?B?UWxOaFNDYW1TUm1KeS9BUWRmTFcwVlZxZGticys3QXNad3pac1VqWUlGZkEx?=
 =?utf-8?B?TXplTWVpcjVXcEJjZTI2UUZ6Ni9Sb3ZkMDcrTFdydVM5UzZHd2JlSGhtempx?=
 =?utf-8?B?dmlUN0x4MW51akF3c2FmRDVFdjBKcUhaWGNjYkVRVWFrNjJzZDltQ2ZCT0Vm?=
 =?utf-8?B?cVJqd2xtYjhpYXlCRFVlMjFFbWo4SHZIQ1Z5M3Q1OE9WTzRCcnBNM0dJYmJN?=
 =?utf-8?B?a0twNzZDY253ekVKSEo3eFNHZzV3dUo0d0MvK1J4cHBGOG5IeWd4YVVmYmpO?=
 =?utf-8?B?Mi8ycmdRQ1NYSkRaMm12SWg1RnZsRElVbGhTbGYyMWJGZStlOTZRUWxUdXhy?=
 =?utf-8?B?MUloa2FDSDVkZXAwYmxUdCtBT010c1hIaHhGVDR5Y290WlVGREpxN0NPem84?=
 =?utf-8?B?ampiaFFqSmU5eDBqbVErTHVNRngyT2lpem1JRlc0UkxKNDVtY2thRVUwdktr?=
 =?utf-8?B?a0w1MVlqNTZXNDRtVTdqeDBnQU5heFg4NjZtNHh0V2pSZm8zZmdNRzVpR2tB?=
 =?utf-8?B?N2pLajFQL0lBSlRiV1ZCRjBhbkFDRVAxc3hMaGd4LzZBcFA5aDZveGZZc0Jk?=
 =?utf-8?B?RDd5QVJJM3lOWXdKcVpIKzk2SExrN3ROSnpyZFZCeXZidks2RVpQVTYvdlVs?=
 =?utf-8?B?RzVpenV1ZjNjN2Zia1RvQ3lXdnhEa2JNdlFyaWZrYVJoZ2EzSnA0Tks1blVV?=
 =?utf-8?B?c0NzdXdvbkdselBhcVpHdHk5aGVDblRvajhTY2RnaGIzaE42WlQwVTQ5SEx0?=
 =?utf-8?B?VXJoN2pTVWFLOVVjRi9CUmxFTXF0RDRKbDlsRVdHcWdiSm15SGJPZGJRZTA4?=
 =?utf-8?B?U1pBWlZMTVRqTmtFcmVCdDRTYW42QnRHTGNvbkFnSXZMUVBGelFGak1aVitJ?=
 =?utf-8?B?a1VrcitnNFFlZG5uL1lJN21lVFFhZzR2UjJpVVkrUDA5QUR4R3ZZUzhxTU5T?=
 =?utf-8?B?bVFlSXRMSEl5WnN1anRUUWVQOGg2eVhGME9pc3YzYWtsNzROQ3Q2Ykl1bEdu?=
 =?utf-8?B?WjduTWV6VXRjSUZMV1ZPL1BrT2JianJJYUl2WG0rV2hkOUVUZVBBbTZFVHpr?=
 =?utf-8?B?elM3am5MWlZKckxqWk5MUFJlVyt1UU9iMHRhSkxUWU5VUjlPTitGTytDaDdl?=
 =?utf-8?B?clpTU0k5dVZjOWlkZ1dmZzdSRWNXcUUvVWdvRUI0b1BvN1krZDQrd0dtamlx?=
 =?utf-8?B?K3d4RXpkczRoWm9rMzBhQThjWDd4TU8zcVZDQUwxemtuR1VERGRwVkhUTDcv?=
 =?utf-8?B?RXR1MUNRR1owSmhTZVJ2U1BwRTloaEdlMVFGTjFTNXg5alRQK05vM3h6dml1?=
 =?utf-8?B?TWk2RzNSTllEM1lTSnhUNC91VmIrVHFKZ29WNTBXUTU5dDZ6OUp6clZUenRT?=
 =?utf-8?B?Y2FjdmhXajJyRWlNckgwbENHRWl4bDBoUUVINmF4VExxdmtEMUdaMVlVcjZx?=
 =?utf-8?B?K0NoQWp2T2RpUGRyWDdqeEV1NkdzUnNGQXNMM290Si9DV3RBYmtLem1PeUwz?=
 =?utf-8?B?ZmRtNHZzUWN3cFVuSU85OHh1OUNhZCtUMFBzZjlBTGtOaEcyU0FLeW9FRG95?=
 =?utf-8?B?dkFiZ3ltVHZSVlIxOTdkUEhmR01SdnlBdTRpSVlwRDhJb3IydGFidEZjVFFQ?=
 =?utf-8?B?dDhSUUkvMTVhS1hqNjVySlVTaDhWMHgyN1BHUFpZWE9aZlZ1cVZlRnFIdWZo?=
 =?utf-8?B?dTVKQnY0VFE1eUF0NWptRkZaOVJYa2MrZnFISVZVYTlNRTQ4T0VubzhlMDhZ?=
 =?utf-8?B?L3ZSZENyNklkTVlqZWpuTWRpancwbXlUcnFndjBuUkFOQnYyZDY0aEhDNnRy?=
 =?utf-8?B?aWxBK0Y3cUpBSjRzY2V0c3JpZ3dQVVNzNlV6U2xmazlrL0ZmeHhzcXh5bWNL?=
 =?utf-8?B?S0h1UmhrN1EwVzFVN1Z2SFlhMVdYNWlYSnd0T2IxL1dneFh2dG9xYzV4MjFN?=
 =?utf-8?B?bkk3NVp5eUkzSTR6aEhSVklmTjFFenVDZllPRUV1ZkkvT3FmQnRWNURyV2lL?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb457680-0fbd-4a99-e22c-08dd357068b3
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 14:25:06.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJWbtxjr2vDjAFTEE5FTL5BBW6lSrAAiPbUJHZTRqoIR3qz99DTPXaRcqW+PEBU6krcs8/mCuhpd2Wze0VeuWiAFesqjymiA54OlQ1VK1Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com

On 1/15/25 15:08, Jakub Kicinski wrote:
> On Wed, 15 Jan 2025 09:36:11 +0100 Przemek Kitszel wrote:
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index bced03fb349e..891c5bdb894c 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -2444,8 +2444,12 @@ struct net_device {
>>>    	u32			napi_defer_hard_irqs;
>>>    
>>>    	/**
>>> -	 * @lock: protects @net_shaper_hierarchy, feel free to use for other
>>> -	 * netdev-scope protection. Ordering: take after rtnl_lock.
>>> +	 * @lock: netdev-scope lock, protects a small selection of fields.
>>> +	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
>>> +	 * Drivers are free to use it for other protection.
>>
>> As with devl_lock(), would be good to specify the ordering for those who
>> happen to take both. My guess is that devl_lock() is after netdev_lock()
> 
> The ordering is transitive, since devl_ is before rtnl_ there is
> no ambiguity. Or so I think :)
> 

sure thing, sorry for not checking prior to asking :)
thanks to both you and Ido for answering!

