Return-Path: <netdev+bounces-120346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC585959044
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4061C213BB
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3571C7B71;
	Tue, 20 Aug 2024 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVXWKKeW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF882158A37
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191837; cv=fail; b=ojQm4pjXEwFekZ2b4v5HTQ6dB8y0liKfAC98R9Y7hwow+s2DrS2fxw/jb2796PaDvYwnrgaKOXbFZhfvTWeEfZSF71mrRaeRUDCrDRCCGePLjnZgsabVjxP7newtH19gAJlYjYSgOY2U9+cNYD7WQXpUrNdEtCa7NxfdKL29pS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191837; c=relaxed/simple;
	bh=z9+vsnkbQfpD8IYsOLilxm8kgcMyWKA4RFhJiKStwW8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oQfLDJOeJ8BIf6SPq0hAQtSUCzJnLx6N6YxcJG45k9A8x6Dw7sFIM67uj0n0U5Y7XLAhdjlOQe6yFsiYugZAwPOggUsfF5RJ3MFQEjw6N8HLr1BBzGeLxIX/myrPpoBjbhzRyc9FyLaomjSbnXnNZzbx9lq16+tb3PcY6307EMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVXWKKeW; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724191836; x=1755727836;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z9+vsnkbQfpD8IYsOLilxm8kgcMyWKA4RFhJiKStwW8=;
  b=aVXWKKeWIvAWUABkUtVr/ZTEM9qh9rd6Yf+PN+zz561cnehNfOHjGzSz
   GS91gPtXWESQaLhleICV6sP1ZLd2L+zg5zhxT+O0II9XjgPsqawRnIfJD
   cy15tOice/6NfGdEpQ++L9wapS6h+wlnFhBfqiFN613E5m10My97tj39p
   6XnKksZ+jmzpFk51FfDfXcmEVW+VctReFrnR2nlohpqoN01r03F35bJCt
   on33dNrtdvHxAwjO1dG3gOBfFgJSt38TDbXjBWXkIKFrWz/TLSDa92QYI
   Waa5lwLi5dX2hh+zXoYtQtbBny9ElZnJOwSd/8e3WBvJVxBW/9HhIFwPg
   g==;
X-CSE-ConnectionGUID: bRi/e3m2Q/2NRcq8ktpl6w==
X-CSE-MsgGUID: e1gvJCIVTJWMEPiq6Hr0uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="26324349"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="26324349"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 15:10:35 -0700
X-CSE-ConnectionGUID: oJRAiAIOT++u6hPuftO4eQ==
X-CSE-MsgGUID: xayefcevTzqd3V9xyp+ZcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60582948"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 15:10:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 15:10:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 15:10:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 15:10:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB2PYtcvQAObStUPvp4RF87O9GnK4SoTLMfuC4Svp9aY5e9wiTkwqmB1twNe+0DC/Dk359VCumzwntCF8ON0qXozKawfflwWRJVYCd/KeegIQyMqq4raHALbDdWPJtpdZoXjptQZHr9/jdsoxf5x8xBQgE90nIzB1nAAVQsibEJAOrfQqwR/lfuJFhPM3jy0DNKC7dRPrSc2FplavrJGnmWy6pa8JU2OT1fUO0nTFvyqlXaWPN3+eADPDZj9ODqqpsrZXECBk13qlkpp5vudhIuT96kufIDYW6hrjby9tccGeYA1ktOAtMGfP+tQEhZj3VJ0Xi5N6zffCGWs1pB+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhWl+SM+BJzluN0CMQjOqJIwgAeMudbEVlwE9H7eO0Q=;
 b=VSsZY1NRdiVqYfDAKFM65t78lqLyw2+3TTopEoAQ50HNp7yU1uzwwBZTf/eQrPcSWw6PDXO9YT5doJD0/ioBzKDF5HptxH4RFjLuzrCB5qBTzMYkeeqjNP1vaPhoSmXJ8wEtnE+4LO5Lr/BGBum2Qj1azef9PPZX7ux+ZGdR2OM8l6DEHvIuM4Gw28Vl6ZkRNm7yEju5nRcTZT8nNhESkrjyrHvUHX0O/kl7r6dCooqLx5CRobRejW50eMZB7wFkvNr/7eSTaMkLxtHfoBZezALVBIA7MdeZ014HuHtJtOwdHa4vBTBGL/KBEL8bXAG3dyRznaysN6Grid4MNHGaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 22:10:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 22:10:32 +0000
Message-ID: <b795aee4-d96e-4e9b-8b07-75e42b91a0cf@intel.com>
Date: Tue, 20 Aug 2024 15:10:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] ice: fix page reuse when PAGE_SIZE is over 8k
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Chandan Kumar Rout
	<chandanx.rout@intel.com>
References: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
 <20240820215620.1245310-2-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240820215620.1245310-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:180::49) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: b760147c-e6fa-49db-7e35-08dcc164e858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGREVjR6ODZoV1pTSDZ6K3N6emlMWThJNjFoSDZvTE1MZVNOUWljK3FtREVa?=
 =?utf-8?B?cVVKY0tTQ1dodHZDTXlUS0xWWEZhekQ4Y3UrSmIzQ0lhdllQMGNuSldvOXVT?=
 =?utf-8?B?MDl4Y0xjZmZuU0xTcm5TN3RaSTYxc1g1Rzhaczh6YkNtYm5lRTl2cldMUWht?=
 =?utf-8?B?enRrWGppVk1MRFpha05lcTRuWU1xQlBKL3UvNGJPME9IeEhwb1lqUEdrQU1S?=
 =?utf-8?B?ZXBIbkZHaEk0bGxON3MwOHhjdDBOZW5nM0JWamdCbjdQTUJGMUlRaGp5UDBG?=
 =?utf-8?B?NGZCL0tqMmtGMFpweU5TOFFvTUtMOTl2blZOUDhObGNJcWpZQ2J2QndCcGx1?=
 =?utf-8?B?QXN0WkhxNUNaNGIvWkc2Zm9IVUVOU0taeWMxRHEwTEIzRmRvZjVJdUtqL2Rw?=
 =?utf-8?B?Wjdta1gxTFcxWC9kUWhwM0ZpVW9DRzVpTXFrUStVM3pyLzV1QTByZEpyNk5h?=
 =?utf-8?B?dXVPU2F2QmxNaEF5TjVPRmtpNEowZkpDeExXWk1ZODZjWGhicUcxdVN2RW4z?=
 =?utf-8?B?TDNReXJjQXpaRXo0VzJydWk2TzhCSXhoaWxIUm9BQklIQUZ0UHNERjVFOWNk?=
 =?utf-8?B?NzY1MEk0KzN4Z29Za1E4anc1dm8vOU1OQUxWL3JNQjFDZEFTVC9YNklMYUNQ?=
 =?utf-8?B?Zm1MY01RVHNYUzcwRERkR3JyRmgwNWFMOU92V08zVjh5MmVGeGdseEhDZU5G?=
 =?utf-8?B?bVBIaWlndnVHN2N1cDliMHFqSVBEb3B3NXlHSnl6SDhrd282WFpMVFBmbHh6?=
 =?utf-8?B?cEVXVTJ1ZENxOXVrNDZ0Nkp4Rm5QM1NMME9KMUFKejl5aGJnYkEvdVlCOEha?=
 =?utf-8?B?WGljVG9YZERraUEyNkFXZW1YMzdMdFVvUUVqMDFuRjRIdS9SUHZPcXFNZUE5?=
 =?utf-8?B?dHRhcnRQZ1RBOEdTMWFhNzJNMFVCQ2dxNnNPc2NPLzBoVDBFYjlUZ2ZTQVdL?=
 =?utf-8?B?cnR0VEtzMCsxZXhaRU8yWDMxTU00SG94VjYrNDRRK2Y0c2l4MUtJdUdJalZl?=
 =?utf-8?B?SmpkbUNMeFFxczZ0d1N4QktGRWhpbDA5dmxjQ3U2VnZvbXBMNGdBYWNraXB2?=
 =?utf-8?B?dEhaMFg4WVhrR1FLRWtma2VUR29KemU4NW1TVnlXdytkSTNGTlNMd0dmbmRn?=
 =?utf-8?B?UStnNitRdUQrWGVFYmhJWEhoamtZWk9yLzVuV1I2eE9KbDNRMTk2MytZcFQv?=
 =?utf-8?B?ZUxtYStTckljdUFRWEFiZDFuRlhKUHpUaFNwOWgrRUxFajk2LzVRV0pwWUJG?=
 =?utf-8?B?ak1KUjZRSFdPdm5SOHV5ZFA2TEdqVWJNMlczMlArSlRidGlxWFFYLzFDQnFE?=
 =?utf-8?B?YTlsUXY1bFJwZlhKTVJxUk5RazhIQVN2R3B5YTZPaDA3RGhNNW9FdHFQZlcz?=
 =?utf-8?B?amFFMXhKdkI2UWFDNXJMWlpkSE15VlY2R3N6Q3I5V0V2ZU9tVUg2RWRLWGt2?=
 =?utf-8?B?L3REVGhBK1k1bEFmZTZTVjNNd21uUW9YNzRNOTdQTi9pYlFyanVPU2tKYUdj?=
 =?utf-8?B?b2xNQU1GajRleVJZd0htbmRVN0hBSktDNGtqRkNhdUwrN1NTVDF6Y0kxUU94?=
 =?utf-8?B?UWxwUHBHV1g3WndhR21WMjROZWY4TjNTZ014UHU4ek1lcU1OREJ2c2NxQnk3?=
 =?utf-8?B?WXp0WnlQcTVHbXZJK2tybVhQY1NDK3hjcFVpRllYSS8rWVltS3hpVVdxN2do?=
 =?utf-8?B?UEdTQk9lTWMvOFBZTDNmajhzOVptL3J5RFFtOTVqRkkxR05DR3VFNlhNZENw?=
 =?utf-8?B?K2ZLcHdhcHpxVXhGTllOYlFCMnZkNHA4djMyNHR2ZHV4TXFYT0taSkJFRm91?=
 =?utf-8?B?TXdIRnRpa3FSYS9DSGFCUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWIweU1EcWJSSEdXOFNMVlNMVThRS3BSSUlicm52RHN2TEFXQm5XaXpBMENq?=
 =?utf-8?B?OSt3S0hkSzZwU2ZEdFJrcWJ4L0crKyt3RUtHbVdLSGVZNllDR0Z5NmRvMEZE?=
 =?utf-8?B?WUdPeFYxMU9SejQ1OXZKNGIxTjhuMyswSmNuZnk5RW0yMi9SbndmUjlzcW9v?=
 =?utf-8?B?eHFCMEhzOU9HNFVJNWR6VXd5bzg0OCtSTXBMa2tWNzlaSVRSZDdTM08zbjRZ?=
 =?utf-8?B?Y2xJZ1l4aHhEOGpWemtqYklqWVdvN0NSYkYrY1UrOXNRTWNMTFhLWmdwRDFZ?=
 =?utf-8?B?Q2dFUWZqa1NwWkxmQUlGeTlEUW1RVitwK3lDS1YyYjVRMUNjSjRvQzd0Zm1j?=
 =?utf-8?B?QytMVTcveWozTUVmSFAxZ2FLd0hpL3JlVEVjd3U2TFFkTE9BaXdCY29tRU9S?=
 =?utf-8?B?cGt3NUVaaXBWUnpJMjBJTUd6ZWtBMnp5M1BpeFd5bmVPV2JtbnF6SjM2K0pu?=
 =?utf-8?B?aXhaNmZxeW5pdFhLZXIzajJkOWw4bEdoQU5kWmZlYnVCSVZIcWdVTGRleXFP?=
 =?utf-8?B?alJKbnM0Tks1NFF2c1FXL1RDYUk5QS90bFRxa3RxRnVmaitkSmxvTmJwZkVJ?=
 =?utf-8?B?dGtnR0ZDdCtDV1hKUmtiMnpuZE85N1VXSTZ2Wk9aVUIzakRWMlhlVmhYdUFr?=
 =?utf-8?B?ZWptcS9VUjJyVWpkS1Vab1RwOHFCZGVFbU13Y1ZTajFLcUg4ZXN0a2w5Z083?=
 =?utf-8?B?emZ2MFJFT2ZTQk9LeGkrZDJRdXF0bkhmd1hpak9Cc1k2ZGQyNTZEOGRwNVFk?=
 =?utf-8?B?YUVnSEVBTEloeDZ6TlI0UUY0NStBYzRiK2tTN0pKQ0hyK3hRRktoNjF4UWxY?=
 =?utf-8?B?ZjhtZWo1ZUJBSTlNL21IMlY5RDExUkJaaFE4VSszSFErREVoWWl6ZXQxNVRD?=
 =?utf-8?B?eTA1RWVjbzBqUHJUak53Y2ZEUVRNQlhPR3lmNmRldWQ4bWRhb1VtRVhLVDQx?=
 =?utf-8?B?eWxINVNWUUhCQ0FqOXlsVlliSElmaGllVWhjbEpJdkhJUWpZdkV1U0YzSkVa?=
 =?utf-8?B?VnFxR0NVcnAraXRKVjFRUW83N2RPZGQvZzFXWEVuRjdMYVYyNGhra1RGOUMx?=
 =?utf-8?B?Ky90d0xicUNMQ1Faa000R29aYmRSWTZiT1BaVWY5UDlMRlA3NG83bG1xSVNp?=
 =?utf-8?B?dGZjbEEzcXdPRmw4UDJSMnJoMjRoQXBDMXNzOHp5WWpxTW1VZDB0VkpMaXBv?=
 =?utf-8?B?a2luMUt2VE9KMkxxL1M4blBrdzVMZmwrNVo1Q1VXZU8ySVhtalFGWWI5cnM4?=
 =?utf-8?B?bFJweVQ3SEFzRlZGOWZsSnViUGJ4K3YyUEJ1cnNtUzd5b2ZjcXZsREd1WThi?=
 =?utf-8?B?M0IwK1BXTDVyTDJ3eGFlODQwdWg3b0VDaG1zRVl2NTB1SC8xNHpid2hsbk9i?=
 =?utf-8?B?bDM1Y1NibUk1SzZ4Y0dGS1UvbCs3UFh1MkZRdGhUZG1xR0I1ZllXK2czMGJi?=
 =?utf-8?B?dUF3QzdUY0s0aDBlTGIvMzduK0Ewb3pqOFhiWS94cFNlN0IyNkNoUC9WZVZX?=
 =?utf-8?B?SlpBYzN5dkJaZnFqMk13NFF0cUNibWNvcFJaTUkrd2dIWldyTUdqN2tlUkhn?=
 =?utf-8?B?cWNWaTlnTjVPNGhWRGd2a2lqcjFzcU5STUcycWtMOVpMYVF6ZXo3TWd6SW5C?=
 =?utf-8?B?K294QmxmVUgxa3Z1THJyR3lTNmJYRktNOStlWnFSS2tHR2UzVHdDSW9FL0xU?=
 =?utf-8?B?MGZTRzN5N3R1cDFkMWRtcTdsYVRjWEM3eDdNRlBZVjlpZ0Q4aVh4bUJlK3Ns?=
 =?utf-8?B?dnE1Y2dxazFhcDg4OGJCOVNaMGZrTkxFS3JReEVkSk1YaVorT1lKYzlIQUdo?=
 =?utf-8?B?d1FvR3MyaERSejIyTjE4TEo2Qjg4eitWNXpBV3dVUXFhRmk0bGJ4bzVPMytR?=
 =?utf-8?B?b3IwbUk1TTBZMXU3MUZsY0lxcDc2UjMwMUZDdmVwbGhpcC9LTUZ3MkhxU2lL?=
 =?utf-8?B?VlR6VERKQnh1RGppZXA0KzYxWkttYjBVRWpJVmVMTnpVVWtTVHp1WEFhUUp2?=
 =?utf-8?B?TURPaExLMzVXS2RtUFpVNWVmVXVxVFBNNENFYW9TcXVtOGF4cEtMRytpQVE4?=
 =?utf-8?B?M2N6QVY3MElVSXZiZVRTbm00ZVo4VkpzdUVSK0NuUGxOa1FXc2FsL3FiekQ5?=
 =?utf-8?B?TUU0blRBSmdkamZTYUpwazRyN1dyTHBBQ3QzU3YwdHRDUVBxS1NualZ3Zkox?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b760147c-e6fa-49db-7e35-08dcc164e858
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 22:10:32.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYlFblvYpUSIiT65/K0esmVdSSEplOF0IumaDICUdJDzwcielGE/IeKGJpZFb89GM82+EogtZUNlT+fuiLXZuR4n5FWPcPYekG8QongHD6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
X-OriginatorOrg: intel.com



On 8/20/2024 2:56 PM, Tony Nguyen wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Architectures that have PAGE_SIZE >= 8192 such as arm64 should act the
> same as x86 currently, meaning reuse of a page should only take place
> when no one else is busy with it.
> 
> Do two things independently of underlying PAGE_SIZE:
> - store the page count under ice_rx_buf::pgcnt
> - then act upon its value vs ice_rx_buf::pagecnt_bias when making the
>   decision regarding page reuse
> 
> Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---

Seems reasonable.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/intel/ice/ice_txrx.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 8d25b6981269..50211188c1a7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -837,16 +837,15 @@ ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf)
>  	if (!dev_page_is_reusable(page))
>  		return false;
>  
> -#if (PAGE_SIZE < 8192)
>  	/* if we are only owner of page we can reuse it */
>  	if (unlikely(rx_buf->pgcnt - pagecnt_bias > 1))
>  		return false;
> -#else
> +#if (PAGE_SIZE >= 8192)

Whats with adding PAGE_SIZE >= 8192 here? Oh. I see you removed the
previous check, so this code only ever executed if page size was large. Ok.

>  #define ICE_LAST_OFFSET \
>  	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_2048)
>  	if (rx_buf->page_offset > ICE_LAST_OFFSET)
>  		return false;
> -#endif /* PAGE_SIZE < 8192) */
> +#endif /* PAGE_SIZE >= 8192) */
>  
>  	/* If we have drained the page fragment pool we need to update
>  	 * the pagecnt_bias and page count so that we fully restock the
> @@ -949,12 +948,7 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
>  	struct ice_rx_buf *rx_buf;
>  
>  	rx_buf = &rx_ring->rx_buf[ntc];
> -	rx_buf->pgcnt =
> -#if (PAGE_SIZE < 8192)
> -		page_count(rx_buf->page);
> -#else
> -		0;
> -#endif
> +	rx_buf->pgcnt = page_count(rx_buf->page);

yea, seems weird that if page size is large we would just not track the
count? Yea this new flow makes more sense to me.

>  	prefetchw(rx_buf->page);
>  
>  	if (!size)

