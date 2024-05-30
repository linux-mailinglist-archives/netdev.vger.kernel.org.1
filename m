Return-Path: <netdev+bounces-99513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C438D519F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C311C21A93
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30D447A7A;
	Thu, 30 May 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4U+lKwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E13D982;
	Thu, 30 May 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717092442; cv=fail; b=NKv+bhqmipuhX77Inwh2uwWmo/XmJn/8kDUDwT3mlsKAcD6Yc/1XHZ4Xmnl44sCLG3gtXfTwBXQtfvgjM3EV8In4EWvGPhSHD94Y1P7ozDiBQ/LZClssQSh2O6pWXNRSjjAWkGNbxrvWeXR/vEllBv2VDRs1wb+0mTby4v1nGTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717092442; c=relaxed/simple;
	bh=qPI8SIboRvHfznLs/trbSG0n5BABhDtMC8TQutylavg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JaJCi3/1L7+YCua5L8AfkpU+BYHq1kDOts6pFQ+sSu2v5IA8uc7hN1QN5OAfSv4+sPAyi7uOtIIDDGi2wncfp8D8CyVijCTPUw1fnIbtXXRXhZfND3LaMTFuEFqjR1Z7Fg5B0jsXEf0NK2A8/NN7K5qsBImSAfnO8kk/4rAQzYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4U+lKwZ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717092441; x=1748628441;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qPI8SIboRvHfznLs/trbSG0n5BABhDtMC8TQutylavg=;
  b=R4U+lKwZcGzGvgCNU7ghNkkvWkPFdBVRQbOQezt50gFHLv0KR8RwXOT/
   VZXIhd1AUbDCeisNXhzKFmLriKH5rIYB8DOPIcUbX2iW2/pMI9r9VsLxV
   3QW74pZccUCS7eQeBr+ilmKrI1d8xq9eQUIC10PjvZTeVA1HARq2VVQSx
   ByJfaaDu5uQrzRjWrfcQkrDbUHlz8yXcN8Zip99QDocEr8iFcmqjWWd9R
   e1e3swx++C9obcj1Vws/EpAE6jXNvZB0olqUQw3vl8oCZZrTXaaiDjkTd
   mVjXxyTy/EY6pMeUsuHsO8H9VKl1KywjkSm6CsbAOdBnLY3sH4YM3wnyI
   g==;
X-CSE-ConnectionGUID: yiiBYojoSm+Ut1ZVznXliA==
X-CSE-MsgGUID: mNWM25ycQPKhUE5pmjJkDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24726033"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24726033"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 11:07:19 -0700
X-CSE-ConnectionGUID: jUqwd0NIRteVrFIwYLrQhg==
X-CSE-MsgGUID: cXBDz3/iTe6vpyONHqRClA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="35982993"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 11:07:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:07:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 11:07:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 11:07:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HusNxG+JDLDi5GYnqwaU3/qT5yxy5tI7Wu9QBk6I6Al7uULKMpors2nGDmPMkNnfIH1Bd31ia32OTZWzWuT6JHHXQDKYl6F2mAVgIr2dTR0XPmZEM1LgeeUuQCYjCnX5UTPaDW3UrjcdcqrdTw5+IyP2h/DevtU/TgeK4aVNh7RRpOYebxEmTTvYsbYWwDHTGl8YNZSbhLO0dyjewa5moO++2FnDsQU+m13ZQRBmTo+HRDEljrNdkZ9p0RfxcL2cehvtcwdVjqVgY0dvH+1ePD6tNkGlH1fFjQlAtudn5iSbIRtbG/Ttz2Lxvtz8mHFjN7Js6BYEh7o7+jaM3V8Bkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jq0mEh0l+MZbTFRfZY2oatZnnJ/YgfsEKaN1y+VjX9E=;
 b=bN/H5ipd9A8mzp3UPEc4x1Du2hsC8xjTki/Z9VXfVwqE3aW3Qon+e6GeGfaJvOpLvK7tLy6Z7mFX+K8mUd8DI1rzCbVWxh5ZlRQt+xrppcdreO0UffbQTGNzvRJs52WB88eOduXtGhOUlbZ8Sl9bf+EExA42e8Qd6k1ZbuuPCjWhkIymEMuNsuXD0Py2jmDTAOZ6paWfewyzdF6nZx4YZ01YQrYeCOYrjzV3lB/bRjf1kSrp73kfP6JnjB4gBnfB68F3sZejBurBiF3vvQz7Npjtqk63iHNH8M3s8vGiS7Q8Tc82NKcUaPHQIU+dzZGVB8bdSYuNAu3gSIW1SSn9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8762.namprd11.prod.outlook.com (2603:10b6:8:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 18:07:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 18:07:12 +0000
Message-ID: <52775741-de46-49ad-bfa1-4bda7e91a233@intel.com>
Date: Thu, 30 May 2024 11:07:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 1/2] net: ti: icssg: Move icss_iep structure
To: MD Danish Anwar <danishanwar@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	"Simon Horman" <horms@kernel.org>, Diogo Ivo <diogo.ivo@siemens.com>, Wolfram
 Sang <wsa+renesas@sang-engineering.com>, Randy Dunlap
	<rdunlap@infradead.org>, Niklas Schnelle <schnelle@linux.ibm.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	"Richard Cochran" <richardcochran@gmail.com>, Roger Quadros
	<rogerq@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>
References: <20240529110551.620907-1-danishanwar@ti.com>
 <20240529110551.620907-2-danishanwar@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240529110551.620907-2-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:303:b6::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 260d40e3-05dc-443a-c5d5-08dc80d354b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGtQZHVwK2txVXNZZndBWDJ1QVk1S0VhbXFmS3ZGb05LNnJocUNCNXFPL1R1?=
 =?utf-8?B?allKSkd2NkNxZnErci9EaWdtb2xWSjJZWFJNZ3ladlUzTS9KTDUxZ2Y0V1I5?=
 =?utf-8?B?TXVBY3h1WDJIbDVpMVRTYXV0WkxjWVhsWTk3R2xYdjhVdzBZUEg4Z0hYYzEw?=
 =?utf-8?B?ZWw3c2ZvTnhManMrYTNBRkV6a2l3ZytFbjdNdFpPS0FJR1Vjall5TzZSZGhi?=
 =?utf-8?B?TmdWV3NBZVZQcVVybDNNN0QwQ2svcWVsbGNhaFU1S0x1VjR6NkJnd2JkMGk0?=
 =?utf-8?B?ZDBYeTE1WXliclhwQkRXQmpuOTRocThScVN1TEFMN0NOS1JiVFFBMWRzSFF5?=
 =?utf-8?B?VEJEUXJRYVpjOWVEYzZvV2VuVmVlanFVaVRjeXB6Rm5xcTZDcE1udmxocmpJ?=
 =?utf-8?B?Q1hvaU9FdVZ3SHdRKzZVUlFub3pYdzhadVNTQks0WWRzWlRyMDRKSWtIdFVm?=
 =?utf-8?B?Z0IrbnB2b0JQWXNzci9aSjRXU1Z1dWlLWWYrQjJuNkk4MnRSVXRCZWh6L2cy?=
 =?utf-8?B?MlZITWJ0SlZMWlJ1NjU0M2g3VzBRVlRYNUd3bHduclBRUEZiSjRXcGV5Z0U3?=
 =?utf-8?B?aCtsM1JvUEt3bE52WExmOFdZcS9XT3Buczd3RzZEU2lVUXdhS0VlT1kzZXJV?=
 =?utf-8?B?R3NlVGFCL08vcjZZajhIQVFRSkpDUldCZ1NpZFN1QWRLWm5CL1l2S0htZkhm?=
 =?utf-8?B?NEd5OE1RMFhDTGIyeEI4VHJvV21JTXVWU0hzTE1YRjZjNndHLzZBS3JWU1Bw?=
 =?utf-8?B?MG8rV3JPek9aeGlNQ3NLTHpXSHhSYnBxM0JOdlFDR3ZmK3I4YmRmWDJEZzRD?=
 =?utf-8?B?dm92ZHdZYlJvZ3V0bm1WdktYMVcrbHZRanRuY1dKK2NybE93dG9jc1NpSndC?=
 =?utf-8?B?OVFSRFhPODJlcHBKR3dlWTJpTUROcUNEdXg4RTVZWlRqcEFTcFJoYjNjWHhp?=
 =?utf-8?B?TVN6Y05wYThQbUF4alo0aWtKN2pWVXArbGNtT1VoUGw1Wk5VNUpod0NZZEl1?=
 =?utf-8?B?ekJxYXJvNXR2cTYxbFlDVjVKKzV0REdqVGo0VXd6MndrL2IvRW0raGEzUkJI?=
 =?utf-8?B?ajMwaWFTT3hDZi9ORHY4dnFIQzBkNTlpSzFiQi92U2prVThZTmdSSnByWDFQ?=
 =?utf-8?B?aXhZdys2bHdrMGxjZ2JzYXNFODkwWXpCaVNzek5tQlFyTy82VjIwWjhrcStn?=
 =?utf-8?B?R0N5QUh4NGpRdmQwMk9PSnNzUXpjaDdWdTdNQlcrQVFFa2VlbisxcjVEcTdw?=
 =?utf-8?B?UjcvRFNJU0ZyMldpTXQ1RkJwaGJXZEtpR0NhejZlanNmbTdnSTBaa3puVUhl?=
 =?utf-8?B?S2YrN0MxRWo5MG5UakxPZWlvU2l2SzZlN0JjaWE5ditTRk04aGgySXJJemY1?=
 =?utf-8?B?T2lDQzZjOGJMUlZnYkhLMnF0Z2o3K3hXcWdwTzNrVUV6WVNLZTVHSDM1YUxn?=
 =?utf-8?B?WHdFWUkvbXZrYm8rQ056RDJ3amlrdHc4MjNFYkZhcDRQcFVNdnJsankxYkVK?=
 =?utf-8?B?Y2tRV1NlbEl6ajRYdzdoZmZrdWFCMjZSelpzZjBhODFSVXdYNXhmMDVBM280?=
 =?utf-8?B?Nyt3VGtzYW9lV1BMZHJGOStseXNXTWtYQ0N5Q1ZMWk9MT1R6NWpZL0RRRUdV?=
 =?utf-8?B?L3ZyNTgzakN2cllDdzJZbk5WVlBnb0JVQmMxVWY0THlTV3NqeGZ6dEV2Wmta?=
 =?utf-8?B?bStqRWZYNGplbDJtUXQzY3hWbHR3MU04cWZUbGJjM3MyZCtOcFJzd2puR2VJ?=
 =?utf-8?Q?vqy/Gp+zlmKW7TSPfGQfv4G4Txqtclf0KgdQ0PW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVFhcG9FS1FuRGlTR2dMZW90RnFxc0JtczNiMmNyM215V1h6ZENNMXUyaUM4?=
 =?utf-8?B?K1Q1QU1tVi9FckFEUWVIcFR0azIxOGxPbTNHMDBPSHd2SEt6VGloVi9BWDBR?=
 =?utf-8?B?NkFKOWJsMWJFem90SEprK1MwUlRzZnkwdlJtalpVSXFoRU5OUWlZOFB1SEVv?=
 =?utf-8?B?d09ZMjhjWDBPYjArTGFBdjRaWTRXWUtFRk9qYkc2SmhvaDVFbVVDYk5SdWpS?=
 =?utf-8?B?UldNeFoyekJpeTQ3NjhHV0ppQzNJVXBuYU5aTGFPb3ByWFJpL000Nm83Njhk?=
 =?utf-8?B?TVhrMzNHZFdCNjdmaEhFVlg4RmZkbk1tRjhpVktZV0xXbXBOZ2lYVzZ0aGp0?=
 =?utf-8?B?MzhNU0pGK1NwRUtmUUdHa1JuckozL1pTMjRSNnJVdTB3elVXVHJpRVh4R2Rj?=
 =?utf-8?B?WlR0MUY5dTlZdTZYK0ZoQTRrM005bkRmSnNEdU1iMURMR29KSzZXWXBlZzI3?=
 =?utf-8?B?YzBBTE5hTG1WNGlqTWY0M1g0WEJOZ0ZGZW5abnJUR0p5eHlpTEVNUDlidDVR?=
 =?utf-8?B?MVZMNzZDVy9FbTYzYTIwVE1KemVPSGttTHZmS1BqY3lSVEpZdUFyQmhUWS9P?=
 =?utf-8?B?RDlCVTV3czIrUHV0WTZiU0tsUDZ1UXJyenFiNmM0bGN6Rkx1WnJEZFpQb0FR?=
 =?utf-8?B?ME5jTXM4V1NXWUROZ3V1NkxJVVNFMEYrMkdLdlVwZHN4MXU1QlI4TTMyN0tq?=
 =?utf-8?B?ZVB0M2VnNkFEd1hsaFJWeENLeFNvSkVscytiNW5hbFh6ejRJSVI1NnRRK0J6?=
 =?utf-8?B?ajZTSHBSaUVJQ25NNEpaN0NLcUozVklmVjdFQ0ljejAwZlRGWmVzT2hqSlJM?=
 =?utf-8?B?WmNLRXRGRW1VR3dwdGRyck90WHhrQ0pvWUlrbWlmWGVPOVQ4ZDZNSlM1N28x?=
 =?utf-8?B?Y1ZRTWNHSHdJRGNkU2wrWWt5cVc1TnZXdmo5eUlGVnBUWnc2WVkrS2x1MTJz?=
 =?utf-8?B?WHR3R0dHcFg3Nk9XM1kzSGJVN1N3dkFKMWF5cENpRW9GeWkrYzFYU3dURHdJ?=
 =?utf-8?B?Mi82YXRVZXZPY2RXbFFkTnZQaVQ4Vk0yYUdkNzZ2T1VINCtyTzloTVhkRW1Y?=
 =?utf-8?B?YVJZcXVQakVYVlIyeE1JRmVpTzl2YnYwL3NtRm5Ec2J3cHBhdzQreXNzU2x5?=
 =?utf-8?B?TXRpUnhsdE1STVdBMnZTYkdaaEU4YXl5RFVLaU9rKzJ3eWd1UDFiV0taR1F4?=
 =?utf-8?B?VUkwSWlWWjFrT0Q2Z1htdVJiNlprMGd2dVB2VTAvYmthR2JPTVJxS2VLb2Na?=
 =?utf-8?B?UGhXbmRvMERoTk83WUlMMTdhS0V1bU5rN2p5cFJyU2JlSGJPQlMxbUVCbGxZ?=
 =?utf-8?B?QWtqNzZaVnFHaG16QnRwSDdIZW9acHZiamJMWnBXOGNJOGc1Mnp5MkY1L1NO?=
 =?utf-8?B?ZTRkVDFqZFE2SmFjaE9xME9GNU45bzZ1TXY1blE5b1dmbjltYTFxNmpEUHVN?=
 =?utf-8?B?UHNVSWNOakZwUE9QRHN3ODJGU2RBZ1pCUE9wVmlIM0RpTzVXb20wSWo4SExj?=
 =?utf-8?B?c2lOWVdFTUdUY0ZPcWRKU1NOaHpNaHVXamNSRVJnWUZDaG5yV2J2QVhZRzNq?=
 =?utf-8?B?OTUxZTFqRXN0NmI4M3lydC9IdFQxZm91TnM1TWEzREVpZlgxUGthL3RwNzZW?=
 =?utf-8?B?ZGN6MjBXY0l6ZGpWVzRDbGVCQVpnaEF4SUF5WEhweUtTUUtmTDcrc2paN2Jy?=
 =?utf-8?B?YU1BcWJNc0Yxa3dPbjlhZm5YQ3Y2Tkt6aTJmTTRmL3dkMm55bThoSXRQZ3Fx?=
 =?utf-8?B?UFkxeFlsMm9jdnhPK3lpcWdXZWFqVzBVZmRKVTRNbE00RUxsSEpKTmFkMVJM?=
 =?utf-8?B?Q0NsakIyeUl4bWt1cU1OQUtpaGZleHFidEo5UzExNi8xS0ZqaWNhaUdEdXRq?=
 =?utf-8?B?N0J3UTU5RkIzVVQ0ejRKMThTQTJVdWRQS0E5ZVh3ZU1mRUwwMVg0RmVKVWtz?=
 =?utf-8?B?ZVJESTVZYU11N0FyYkV5dTlkYVJJbVpvZTZQK2l5bVV6Z1NscUJpL29ZdVNB?=
 =?utf-8?B?cEsrVDF3ME53eEJYZ1dTNnVTWXlkUVE3bTJFS282SUdLZWI0YjY5cGdBMXRV?=
 =?utf-8?B?b3RzSEJEZEY3M1UxQ3RvbXBvMTZFR0ZPTUR4d2tJK25rMjFCQkt3V1RZeXRQ?=
 =?utf-8?B?eUswVk1mdFBDQi9yampRNFZOKzlMZEMzVm1CSE9QZ1hyRkFyQ1ZCelBZd0NY?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 260d40e3-05dc-443a-c5d5-08dc80d354b5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 18:07:12.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFc3IwQiajjNxnEIM1jE9rqRYYs14yHfopKXaNa9bZkW8L7UEQPBrjJoZKZfzaJKVIlsAN2ztffX9OSxX7b6M6ofeKbsuN8BBjZEeIK0cNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8762
X-OriginatorOrg: intel.com



On 5/29/2024 4:05 AM, MD Danish Anwar wrote:
> Move icss_iep structure definition and prueth_iep_gettime to icss_iep.h
> and icssg_prueth.h file respectively so that they can be used / accessed
> by all icssg driver files.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---

This is a straight forward move, verified with --color-moved-lines after
applying it locally.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

