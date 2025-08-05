Return-Path: <netdev+bounces-211765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE1B1B898
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B4774E1007
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F52222D2;
	Tue,  5 Aug 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asy5Ss0v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919C247287;
	Tue,  5 Aug 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411621; cv=fail; b=GZJgGlUrLIBVJc37oKcw3vcH6Xze2N2hXej7CNy3CPH4gp5XB7zvTB1PmYI73yLRcorNSo1GmD4U9tP94RPqrGYt2KEUrIFtA0zpr4r4bi7bMaJ6Koqvaur4aYGHDSEsS7CYorqunT621p5jZTaZ3LImBAWBZKBhE83/QfiRBfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411621; c=relaxed/simple;
	bh=YPHU8kMcUyX/RNcRH8WXnrWrLBqGiuiVaJnRwpegi7U=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=CgiE1iPdWGEW2tjchdqVaYbLeZvie8SRnd/NNHX5vYYxytxAsuI2ISWdcrBXoAy+q8gBlfFGp4q4YhCyINNwLRBXDT64eio3o1tUIyr3VPMa+yngqoz1BC3a7mOUrMvNSq6aFuQscWWeThmYGqE01nG3AmQEYIClFySnFm4Pvi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asy5Ss0v; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754411620; x=1785947620;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=YPHU8kMcUyX/RNcRH8WXnrWrLBqGiuiVaJnRwpegi7U=;
  b=asy5Ss0vVwaFFAmz217ySsRg5bbJ8qaLQiJg9K/33BBhEDzteXoqPQ2y
   IMDfBnRxeH7gQTQAEe8msC2DRifSfYgk4szJ7PKy+ec92aOhLpq9GBF0K
   FusWuXOsAwbzHv5qTV9fc/ObMMikBfK6XgUQ9q05OEfdTbkSRETvE5Gin
   tQsZfBMocV2srdGE/ZLjM74T2nU4cc/nGaU5Wj1Aj1xkAdn3Voo+B5Yg9
   +vpfN7ZfjPfJ9GPTVrApadqw3F13V+3pf5F8UQHdCb23a27G3Mi/Fgj9T
   eIPVpJP0WJ7KITYTXBYb2Ksvhc1//+xWbNaAqTpWnF02gMA+lNQpQzIwH
   Q==;
X-CSE-ConnectionGUID: 3PAoMcB+QTWOZcoDwTUy1g==
X-CSE-MsgGUID: +F9I3NZCQC6+KFo6u2U3Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56626856"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56626856"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 09:33:39 -0700
X-CSE-ConnectionGUID: ++GQmw9DQFmu5Hv64NcXQA==
X-CSE-MsgGUID: sES6kp/3QI2yfkh33lVp1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169915546"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 09:33:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 09:33:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 09:33:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.87)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 09:33:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUZ7m3EKkLY+X5YDa45R/marEUKxbzFTzxwVdC2wJaZj0Yhx2FSU5gPxvzBbhkTjYyW8Da8RpF53tmRVT6DMZYNQ3JtyEM2OUOEOFltMxy1KniSYFqFJODKYUucQYSEeGZkK0YG+/fZtBNHd7iAG5r5yJtxPI/jLAmge3jWJoBVwyRauV9OgZP825HDQwAkyQgG5NUMhbzS0hKcmagrTaFryw9Vr05n+NAxk79lCFCKQZggur2eCzEFZG4MzmvRSAENQK70GN42A4hgk0ydTosXy6IozWw+6UJf6R86OLB8bkw5lRCj3nsyAyMDGyR1mNXJa6N1+KoFFScgJxkqT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVumo/cPhq83TdE7HFtO4ps4ttmKHxhBPi1LNjBWm9Y=;
 b=HitUOHqlVNLc1b2DP539wCd0cZk6mVmVbALIbE9qp7hIBuGs7SOs2vdnxj27oy+O36c+xNQ4C+Rrm3cBfD3FjjLx/VsZ/BAtwfNhEPQ0SaHMzqQvuDt0bNt2yWpkngQCbqbuPHk+YvWJ60QXkirx5gHRjW4Z5T3jNTF4my7kzksvr/cW3A0PAaa/9hef1SIpe/OdtGWXThDWgZsL4/vioFDyXO1PL84Q5XSaZzP8GbZ3HPL8W+jpXXht6tY0lLTXRY6oAW2F0XjyFUNU+PtgmPgS0qPsldLLIxJH1lKbuToVHxp+3QwLxqE3UsRsc0raZU6FBEdcsMrMSZtkmKzG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH8PR11MB9458.namprd11.prod.outlook.com (2603:10b6:610:2bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 16:33:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 16:33:36 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 09:33:33 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Message-ID: <6892325deccdb_55f09100fb@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624141355.269056-19-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-19-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 18/22] cxl: Allow region creation by type2 drivers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH8PR11MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1bae8c-41c1-47cc-b78d-08ddd43dd32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTFMNGd2THR5OE9SdGhYL3ZFRlRtb3FsL1U5a3dBV1JlZ0VFam92NmpHZk5C?=
 =?utf-8?B?WVErUGM4cjhrbVRkNEhKMURTSXBNMlRSY1kwUUFYdHg5aWg2L0JyOHNlUHhK?=
 =?utf-8?B?OG5GZEFZWE9mdkNGRWVydzZnaGNnczFrK1dwL29ucFlRaTNkWjZObHhPMTJy?=
 =?utf-8?B?M0t6YlNNYkxmOEpmcVRHbDl6c1B0UkY2b2JzRzYyanlxM0FRdk5VT1VjWi9j?=
 =?utf-8?B?bG53R2lBQURDNG1vK2ZrUXhHM3FTN1VzaWZnaTRhTnJ3Qk54MVRUdGNQakJF?=
 =?utf-8?B?REdJQXYwdk1BU0NVZDdKWnRyQ1VUdndHQk9KeDd6czMxa2JteHJ3RUREUjk1?=
 =?utf-8?B?QWpSYUx5Y2V2Q2poMkZZRXJHVnlWa0JHcEhUMHJuc1FTV3lRc25sbWpmS3hX?=
 =?utf-8?B?emYvSEVaK1RrbGNPV24wcTNHNlpWc1VMWVYvM056MEE0MHBJWjZMK05FY2Er?=
 =?utf-8?B?TFNnc0tKVlFBeklDL05xaTd4NTFNVjB6QnpLbkJ2MjVlV1QwT0N2QlR4UXVQ?=
 =?utf-8?B?Ukd1R1IzWXNBaEZSbThNNENMMzFuaWx1czQ2T2twRytVUnd6dFdGYnhuUCtK?=
 =?utf-8?B?RUJxM0wrWHdKQlo0UUFtK0MvQUZEVHB6Y2RzWDM4YnlXQ2lleFNxeEl2K3I1?=
 =?utf-8?B?RE5wTVNEaWVpMS9FRVF6VnVsTUdBU1ZKVjdrTFBvck1FQUo4Q3hZRmRNM1NZ?=
 =?utf-8?B?SVU5ZEZUdVM2aGFkbHRmZ0dBVVZsVmMrZVhiVFpzSFBuaTZ2OWV1V1RBOGty?=
 =?utf-8?B?UUdmbDVOVWlOWXEzWGVlalcyY1c1UHRQK0FsZkVZZFg1bExQbm9HR0p6RDU4?=
 =?utf-8?B?bHBEU3o1V0lJVnRlM2VucnpQY1dOeWc0UUpwczdoK2s1WEE5RDNCTFVuMmwz?=
 =?utf-8?B?allpd0s3M09tUXhJN2tXQW8yL0JrUUJJNzQyeWEvRnJ5MSs5aEMrMnpJaWla?=
 =?utf-8?B?QmxoMlFpbytCR0hjUFlrSkhXM05QZ01scnVReTdqdEJIRzVSZnZETjU2RzhQ?=
 =?utf-8?B?RjY2K1NCamEvOUpwTXI3RDFnSHY5L2xZUExGNUtyR25uNzdndHB2dEhQTmx1?=
 =?utf-8?B?NjVlRzdWTXI0UWp6cFl1MmpKSUx1ZFVkTFMxTVVGQ3NlYXhsVWF2NXR5WitR?=
 =?utf-8?B?dkZkRXhjQnRRdmhkVDFzK21HZHpjMW4yWnh0NUVtc3F3MU9Eam1vV1pmRmxT?=
 =?utf-8?B?Zmx4K3MvbDAxMzhNTHlEZlUyNGFLcWtYdTlXQXo0UERJeXRPWTR5VDZWTTlZ?=
 =?utf-8?B?emVLd1o1RitKWStTSHhxdzY1Y1FJeUJGN1g5Ry9rRXFDTitXZ0VyeU1WMDFv?=
 =?utf-8?B?U25ZRXU0WDhHZkJYMkFuKzRZV0JCZ0R4U3JtK1NocmhXTlQ3YlM4T3R3MHUy?=
 =?utf-8?B?eDQxSDhmaURxUDYzRmh1a2JoT1Q4bXFpdnJuVHg1TWtweGxVVzA0em0vV1RO?=
 =?utf-8?B?SGpsQTh1UUFJNytrR3RkUW4wZ3R6ZFlHRWRTM2N1aDVjc0N3bDVheUcvZ0N3?=
 =?utf-8?B?S1JDS2MzK2lDK1pTSC9iVXRkT0RoTGVDTmo1NzBMam82RXhaMC8zcVorTG0x?=
 =?utf-8?B?a1Q3N0xtTFVDOUlCOFNPc1NnZmpVQnVHY0Zuc1JZcVVFTitUekpUcUErQVI2?=
 =?utf-8?B?RWJZZzQrSzNzWXQvNjNXTUVtZ1pBR2JocGNlSEt6eWtmcWE2dFBMc1hNZjBp?=
 =?utf-8?B?RXN5T25aMXRITFVhZ1BnU1NlTTdQRlBwQWk0aEdLZDhBQ0Jxc3dhbGo3dXU3?=
 =?utf-8?B?eVhRZGMrZXRxbExWWGVKZi96aGtLaElBbnZOUkZIQjFRS2dtVVZxS2Q3WVpT?=
 =?utf-8?B?TEEwamp2czE3Y2JOSGttbURRN01YdHJrUEV6TE16QXpVb0VIOGlnNnAvK0R1?=
 =?utf-8?B?eWd2QzJEYndmWmhudFVVa2djRlJZckZlNTFmRGhtcjNCWSszTkhmc1FxY1ZV?=
 =?utf-8?B?MVBkaUF1NVd6VkhyWVpHb09SWTlUa2svdDA1eEs2aHdpdEFCNzQrVGNlWkFR?=
 =?utf-8?B?Q0xobkdSYWdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmg0aHdZMkxpeU5SbFVxemMxc3dKWEFEYVZHUTF2bXhwaHpXcU9iQTNadmJH?=
 =?utf-8?B?K0I0aTE4VmtrOUg0V3RHSFB0WXhpQzJvVFZ6NlliN1BjMUR3RjA5RzRTdTZp?=
 =?utf-8?B?R1BodzdIb01OQVFZUkJyT01Ua0hBcDAvSkVVc3JiSFlFanl4UnJxeExJelZp?=
 =?utf-8?B?TFBnYTdUUm5NR3ZXcW1tbzNPMVcrdER5Uk5kQ0xzL05MNjFzQStZVGExQURn?=
 =?utf-8?B?UHJCVmIzeG04bWsvNmtKV3lzSlQ3M1RXbFZRcXliU29xMXcyUVAwbThNSUxx?=
 =?utf-8?B?U21ra0ppeTcvTVNBTThTMVh1ZWFWeXFwbjg3aEVrazBuRzhnMFcvUVRQc0Q4?=
 =?utf-8?B?bHZEWktGWWZEQVJWQzZVN294N3N2M1M1SmdUVzdaTGVhSjdEV3VGWnk2MEZ2?=
 =?utf-8?B?STh4TVBUYjJEUnF2WWlLa0ljUU1jcFlGQk1CMHA1bnRXUnR3bVdyS3J0Q2Zt?=
 =?utf-8?B?dmFPKytBcHkyMU1zWTdQb1gvMnhrdnZqWlNacTJ1bXRjdHI2Z1U4ZlJqSTVT?=
 =?utf-8?B?NGdXeHJXWHBheEVxT2FPYVkzTkQ3V05oSXdUVjcyK1ljRkM3MjBxaUJuajhv?=
 =?utf-8?B?SVB1ZisyblZFQXhPOVlibytnTmVwOUtoUGZFZmtydVA4QXlBQUxPWTNaMmk0?=
 =?utf-8?B?MFJ3WFlTTmMvaEx3VFlPcHZuRkxSdDE5UGpHRkN4Z3MyUHFYV0grMVVONnRE?=
 =?utf-8?B?c2ErTExNTStrS21oSUJjcE9TcG1kMnZNM1BoUW03R1VQb0VZMXVNTW5ZRkhv?=
 =?utf-8?B?MmI4R2t5TXFYTHRaVGRTVnJ6ZGJyOUQwci96VlhSQVFMMkxzZTllMXpEdWR5?=
 =?utf-8?B?aTlSWDEwcUI2cm1PUzJxcFo1Wk9xd0J0SjRGem5aTGUwQ1RFS05NNHcraVVt?=
 =?utf-8?B?blk5bFZ3TzdLc2FUV0ZkN0dxMkl6Ukc3T0JSYWdUT2RXeWh0YWNydksvNU9E?=
 =?utf-8?B?SGxhNWtCcEx2enpIRHJsaTFYOXJiS1g1d0J1UXFuK1pNV0NGMjhkS1FQVWNI?=
 =?utf-8?B?N003RTVVVDV5UEpEOFgxakd2YTZwRitQZThxY3M5MDJ2amxUN2xlMzR1UDdL?=
 =?utf-8?B?c0ZuY05LR3JWV2dzU2tWOTVCTCtWcFFxS0Z5V2xXSjlhSXhncy9nWjU2bG5Y?=
 =?utf-8?B?NzBIVEloc3h2Tm9TdDg2M204WHMvK0xZTUd4UG1zRWpxZHUyNkRaR1lvd042?=
 =?utf-8?B?cVQ3Vmo0dzZKdHI4ZFFvWXdlQ2hLV1k4azZzdFlUK0xHRGdYVkYxYUhSOHZ5?=
 =?utf-8?B?YVZQeERIZDFrdEl5YVEvT0xxZUI3NmRmWC8vZThjRTFtTU80NUlZUGFTaU1U?=
 =?utf-8?B?NjVURnhONEo4SmdwRVhoYmJZdlNPdUx0VGhURkhVMkpQcFM4QUh3dERObnlz?=
 =?utf-8?B?c3l5RnIzN01BZHJ3YnB5NjgxYms0cjZ2Ny9TdENSSE1VYnlQdE50ZTc5OTB1?=
 =?utf-8?B?NkZreXB3eXhqSDhtRlEwN2JpNk5tVm5VRDlPY0t5NnArZ1ZCKzh2dzZLcEFq?=
 =?utf-8?B?Q21tRHV1MERWd1dMeDI0TEJWc0pVVVRyYU5RZldnRStGMnZ1RnBSR2pYU2I5?=
 =?utf-8?B?TGttVWROSHBPazdaY2dJVk13SkRLNTB3MWZsWEpENDllUGdVaGc3MW1CNXFZ?=
 =?utf-8?B?YjdzRUszTHIzYk04bnduMUU3dSsrQlN0Vjd0NHdZaHFQVDVqUWxuc2dpaUlZ?=
 =?utf-8?B?WFdGUEYwWHJDL3dhOFdySmV1eExOMHJUN3B6SThaYWNBYm4xRjB6aDYrbE13?=
 =?utf-8?B?TXVId3JKMU45NVpicy9jOS9DSDk2QURRVHhnMnpTMG0rNzV4WGdoQlZ3TTNS?=
 =?utf-8?B?ZVB6cWdiZzY1Ujk1ZVhVMmxuaHdhSkM0OW1EeDRGNk1XK0xtZS83YjhuU1A5?=
 =?utf-8?B?SUhTR0tKaFg0T09wNHpwUjFGa1IwdEtBVHhjZm14eUptRXVISER4ektoUWNU?=
 =?utf-8?B?N2tBVHJ5QUlJdXdXV2pRbjFpSmpWQVFQTWdKYUFGSnZVSUVUQnRscE1GRjdX?=
 =?utf-8?B?QTBKVzZUSkNkWUdIM3cyWG8wTGhydG9tL1RMU3hsR0pSZUhVQUhCZm1RODlD?=
 =?utf-8?B?dTJzeXQrYjY2eEZMVW5VVWpiZUpPZm1EczNGQzdCQ3lVbWRSNy9OemZ5RlZn?=
 =?utf-8?B?MkdLWmF1S3RReTFOdnVXWUhwTnRTRVJHVHd5dUM5UzdtR1BibGI5RVlKVFFr?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1bae8c-41c1-47cc-b78d-08ddd43dd32a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 16:33:35.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iy+lkfQrMuqJ+WXczthm2im1LJ7ZlDfCwV/OlX8PEymmGbKSRV5oQW9U0uutd/3G3WMCBkbbNASo905OCpJflch+7F0pbdHgkRPi2cqKJ6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9458
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Support an action by the type2 driver to be linked to the created region
> for unwinding the resources allocated properly.

The hardest part of CXL is the fact that typical straight-line driver
expectations like "device present == MMIO available" are violated. An
accelerator driver needs to worry about asynchronous region detach and
CXL port detach.

Ideally any event that takes down a CXL port or the region simply
results in the accelerator driver being detached to clean everything up.

The difficult part about that is that the remove path for regions and
CXL ports hold locks that prevent the accelerator remove path from
running.

I do not think it is maintainable for every accelerator driver to invent
its own cleanup scheme like this. The expectation should be that a
region can go into a defunct state if someone triggers removal actions
in the wrong order, but otherwise the accelerator driver should be able
to rely on a detach event to clean everything up.

So opting into CXL operation puts a driver into a situation where it can
be unbound whenever the CXL link goes down logically or physically.
Physical device removal of a CXL port expects that the operator has
first shutdown all driver operations, and if they have not at least the
driver should not crash while awaiting the remove event.

Physical CXL port removal is the "easy" case since that will naturally
result in the accelerator 'struct pci_dev' being removed. The more
difficult cases are the logical removal / shutdown of a CXL port or
region. Those should schedule accelerator detach and put the region into
an error state until that cleanup runs.

So, in summary, do not allow for custom region callbacks, arrange for
accelerator detach and just solve the "fail in-flight operations while
awaiting detach" problem.

