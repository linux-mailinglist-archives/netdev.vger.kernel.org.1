Return-Path: <netdev+bounces-103201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5003906EE6
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1751C228E1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88299143C7A;
	Thu, 13 Jun 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkMUcDAd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28113D512;
	Thu, 13 Jun 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280680; cv=fail; b=kEaAZUeTd2puzS+xEN6Cgk1tJDiYmypAPZUxQrGGNuFECgEU27A4LzrQQiBr8BurK73UWjsw2JzE1rObH8XmWv6M4w9Mv9MfpP6aujfyxIztwKaId2K8X53l7SZTV++/+yf97EHF2PdThMMlfTRgjV95u3Nli+nvCd5irngJCcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280680; c=relaxed/simple;
	bh=fWVdM4Uzf21Zur7nMU5nByo1sbWSHbWUxSsk2P0NQhM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oTS7DLln7GvikWd0LFUDTCYbc9Q19uptoVdOCCCkliMv1iv7HxVuLxln/10MaR1rIrskrYBioMXgRQ3BDyaFW6/lU9X15EbD5AisAi5/PrBLZuB9r6xqw60nI2wU531On4iTfp78VZ09mEfvzdqIFCraXGB0B3kbP2MmqL+OZ3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkMUcDAd; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718280678; x=1749816678;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fWVdM4Uzf21Zur7nMU5nByo1sbWSHbWUxSsk2P0NQhM=;
  b=kkMUcDAdyxOVBGXhNfDqMZ9rv6Fx9fpx+xA52+hAR7DRd7RkGHcrGENd
   dOqzP/hO3jMVB0u9J6u6k9ilgf07vgDjcqU0SHorZK32GdsXGy2BdBdRJ
   MInIWgLJUIepWaQtfyg5pZc5E7sPyn9xlf24v4xpTfQkFfb92FW0l+LWq
   wwqyHaXXqqZVbtp7dx5zL9doOXtNo4d3XbxibMg83OnwiD07bO4gT5hr3
   XwMOP8tUvwnjaX0XzOXJwOTt72gCX/9YSS4BJHUNMxxfdhKElkpKyXkwM
   BD1qJcVSPRiDlYKTuCcgXO96qbOyaE13z5zw84abgEHXXbA5IETJaMKyf
   Q==;
X-CSE-ConnectionGUID: 2p7o3TwFRVmAKudm+ibw5A==
X-CSE-MsgGUID: axZW9kM5RN6ib+hfdjMqtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="26209933"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="26209933"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 05:11:18 -0700
X-CSE-ConnectionGUID: m3S3UP9iSw2BmiisU/Jhjw==
X-CSE-MsgGUID: A2r9p1w0Q/C2FmoQAiI2OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40763923"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 05:11:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 05:11:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 05:11:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 05:11:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0DBavYZ6/puM6dlJn377iRFOFGR/FOvOTiSjn19dqbF59ZZK0VwlzU5yaEi0y4/Tox0i2QrPT1sJFJFP7/B4aJvF9Vj03kNmfjRvci9DpjTkQZ4y2u11u9lcvE2dEcbLAWmydv467ISVZF+azYLFUJIfhBPJpSnapbHAN62zuV9jLyABM3UsK87juHd8ZysXk08qcKylieAxi31SkUOpdJuQjZ66mFeUn9RqZhmzuZj32xl7twwDTCznNh8XsM89ycIXAThP9a3W+7ELb+YrVmNTlliGEyc6v6aWD7hgmO4BTmIcZeBkWgIdUdxQYe2z7egNPpfgxv4L1R3LOW7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PxgKUy4SXL8M+qdbEsAA3H8ytyywZc9bNjYQ673OPI=;
 b=g6w8oMjsMO5IpCwhS07kYxfGgbq3b0oTWtkSgR/JupVu/yNsDShS4vxbAtlbgNOZnEGbSjEXum0NWjH0FR9u2jMHfog1+pm/+zoTGErev0eW4gUYC8riJJgRExhQ9S6EhWMCs/q5t9lq0sXAYftDDzRRtTpQRJEItBoZaJl7bUYJGQb0RRoTj+X1WSjUqfJhLbXXv8OF4YDETGfwpfK3Ol+lWuuqxLGSfTmJji0rsroSLpGXa/LGl3KS0p/BjROYQbqnR6dkujWpZ04TdSeqIA3LqpfJTYllv0w6d9aanTnzrvPL6egkclGLpqQTshY5hCTnyH88IJ6cEl6YuXkQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL3PR11MB6338.namprd11.prod.outlook.com (2603:10b6:208:3b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 12:11:15 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 12:11:15 +0000
Message-ID: <4a2236c6-1a1a-45bb-89d5-bbb66a8e79b3@intel.com>
Date: Thu, 13 Jun 2024 14:11:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] netdev call - May 7th
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <netdev-driver-reviewers@vger.kernel.org>
References: <20240506075257.0ebd3785@kernel.org>
 <2730a628-88c8-4f46-a78d-03f96b3ec3e2@lunn.ch>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <2730a628-88c8-4f46-a78d-03f96b3ec3e2@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::30) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL3PR11MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 037c2c5e-2eef-4de9-9fa2-08dc8ba1ec8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|366010|1800799018|376008;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3A5a092eHowZzRxSGdMUU45Z1VOSXFQQ0tQQkVwQnFjSHZwdzZVdzBveHJZ?=
 =?utf-8?B?WGw5bGtiZXRDcGpOMzNmQk9WL1JySTZUMGtWSUpPTk91ZzhHNk1BQUN5aVcz?=
 =?utf-8?B?SWRwTU9LU3JDTkozcitoZStMNGxocW5La1Y5VUViaHlaczg3S1FYb2dFZTBJ?=
 =?utf-8?B?RjRqT3RsdWpVblVldE54QlNhTDdScDdsOXlnVTBtc2F2cG82aXArQzJVdklX?=
 =?utf-8?B?QWpTY1J4T25iZUwyYVVvaFBSdysxVUxuSVJSanIxSFIzc1gxKzdIMlo2RXJD?=
 =?utf-8?B?RW1RcW5zS0RnWEg0akhKR2NTaXpVa0pHRk84cFMrNURFVXpsUkpvMkhCbEpr?=
 =?utf-8?B?SFNqK3V4emI1aEM2ZGo0MHhUOXlkRjdEY0QvRHViK2taaXBqMDF6bHluMVJh?=
 =?utf-8?B?a1JUa0VHSHN1VUJPNlRUcWRmbzZXNHdMWFJjYzJqcUViVUNPTmpsR0ZnWlpa?=
 =?utf-8?B?S3FkazVJRUdOMXRNQWdvVGlLbzNwNndLNVRQOFpaNnBkbmJxQVpJd2VlUUtY?=
 =?utf-8?B?QlB3THdKTk5zektLdldwU2NKVHZyUy91NkpCeG1KVDBGRGZRZk9FMXBxOUpT?=
 =?utf-8?B?K21aM1Yxek15allmQjk3ejhzL29qUksyeVREZTI2RTh3SEp5K25GT0l2aGla?=
 =?utf-8?B?Yk5WOG9valRwSXByOE5jQmhkWmE3MkxWZEJTL3d6L3dIa3V3RVYvZTNBMVJo?=
 =?utf-8?B?RTdhWUZ3QkZ3WXp5TTlFb1d6NjBOSXdXMjVHbFNVTTRpTk9QOWFuaHBLNkZ6?=
 =?utf-8?B?QlVFVFIyalFXU3dEMytWTko5Q0VZMHN6bTcvL2JZdFc3RVpLOUJQUWd4bmsy?=
 =?utf-8?B?MXNxTXFBcWErNklIVzh3M0pHU1pvRjVBeUUrbDgxUWpDemxwUWw0YkFjNFlk?=
 =?utf-8?B?Z2Yyb2RQL0JmMFZFQlFYbEZ1b2hZOUFyOWdTSEFGMVo2WDYzV0dvVlJ4Ty81?=
 =?utf-8?B?cVMvekszRTNTVUs2SXRzL1Q3Kzh6WkszTHRuRWo4UWIvR1NTYmhsUlZNQmda?=
 =?utf-8?B?a1hMYmUrVXYwVlcxWEl5TTRXMmVVMUEva2FxbXJjU2I2UGdYRW9OMlh2c211?=
 =?utf-8?B?OGlBZjc2NlFVWTlYcWRaR0pRTTZwMTZkeEIvSUllR2ZDdjJsdDZTcUQzZ3dB?=
 =?utf-8?B?WExpWTV4d2pZeEg5bTlYS1BETEJhR2U1SUZyM053cFBrWjJsbW1IMG5McGdu?=
 =?utf-8?B?NG00aVFOY1hwRkxQNnpxb0tNa0hET0FKajVnR01mQWkwOXNVd2pKVlJqQVFT?=
 =?utf-8?B?dFBIdWhQcWRSR25ZT2E1dkZUZjBDd3NMMzF0OFRTUWE4N3lOTENjMitPa1R1?=
 =?utf-8?B?K2E1QTl0N2RzYUJuem5GNnVXSkZ1VjZwNWVjRFlGYjdibzZicG42UTdQZ0h5?=
 =?utf-8?B?WXBrYWRVelVzY2FibnZpcldPbW1vNGU1bEVUUVl5Z1lWVHpLVm54TDNyVXFX?=
 =?utf-8?B?UHZaWnRIKy8wSVFFT0RhZTJoeTdYYmdGNU1waVRla0FPU0NGR3RQK0hxRWwr?=
 =?utf-8?B?N0tyQnA1bDdPTTZpN2o3aUNKN1IwdFlzTTJEMjRnUDIvTHMxa1FpV2hSZGx5?=
 =?utf-8?B?Yk93TVhKQzg5bEVIWVNOUlNrem1mc1RZSmYyTXc2Vkl5OWk0ZVNkZVdPZUJt?=
 =?utf-8?B?aHdLdlQ1bFF0bmMwMDJnbTlxN216YlVYaW53R0lVc01xbHplODNwSys3NEN0?=
 =?utf-8?Q?KcYdRc3AshRxkkUXzBAc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(1800799018)(376008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm1hWEsvT3hNQkdtYW1SZ1g0WEhUWG9OVkdVbHlOTTUwYzJjTjdUWExqdGlo?=
 =?utf-8?B?M3hYRzc3aDR1RUtaemZVdm9ZZG1jeXNtVVhUVnhHWHkrdVdUMVFUSXN6Zlp6?=
 =?utf-8?B?WkhadzFUM2FJbHlUeGdML2xlSmFRb2xuQkJ3clJDdlBwelFsOG5ZQzJwQjcy?=
 =?utf-8?B?UGtKU1kzdHpoYXg3M0NBcURZMW91TzVuVElvemk4Qy8zV0RyemVSZitJSWtX?=
 =?utf-8?B?Yk1EenYwZGFFT2dleDBWdFJkNGN6cXZpM3BBK2lLMEFjaitXVG01dGdVK2Zk?=
 =?utf-8?B?WWgxV1g0SVJ5a0RRZEx0cVcrRUc0Q01sK3VsQU5RbDR4SUNiT3pDQWtYbTRQ?=
 =?utf-8?B?NTlmWXNGSXFqNW45WnFSNHVlKzUzUEhPNlFvQjFrOG9Jb05PZGhSS3NkcDNm?=
 =?utf-8?B?dmhWMEpjcVJwN3RkbmFNOFE4Njh3Zk1KRDArRFlNaVhuU1UvVEllbm81YWpZ?=
 =?utf-8?B?ZWUwWVZVZDVFYUtaNXkxSkpCVC9yQzRaZVlCUXZ1Z0JsV2xHbXZHUmlxNXd5?=
 =?utf-8?B?SDVoQzZTQXhzY0twR05jMFNkZDJaMU9sM01vUXdQWnNEME1yTjZzSStqbjc4?=
 =?utf-8?B?ek9GcUNQa0NqSkltR1Vyd2xjSW8zOGpoNTdUUUl1cCtaTEZ2SXdKTjlMNWJM?=
 =?utf-8?B?K1IzOWp6cWJIV2ZPTjZkWlRxMlVPVmg1Z2pOTnNydlJLaHNhRmpOeitpN0lL?=
 =?utf-8?B?RUg5cjgvSWh3cmRQemxtc21Rdk9iVHA4U2dNSDhwTGtvN0hvQXdhQjhTa05W?=
 =?utf-8?B?ajRVcC80YmdJd0tObVc1UkRpV0psSng2MWNiTldlbkFWbkt3K0R3eFFXUXZj?=
 =?utf-8?B?MStYcHQzTTZmRVpWVWdYZmppMmI0Q0RHMm5ocEhHbUllRlRIZW1rdWUwTFdo?=
 =?utf-8?B?NVBCNjd1M1piNGV0M0dvSXJwdnI3eUpidzMvQ0tJSXl2MjZhTWlPVlZ6TFhT?=
 =?utf-8?B?ays5VTlhSWRhM2tkSnl0emlGWTd3emJUVnpWZmFsTENtdWlnUVlEZ2t2SVd4?=
 =?utf-8?B?Y0NScTF6dEg1S2pGUTNINFN0aDJKcXozQ3hrTXVyMExITnpJNko3RkpNV2RW?=
 =?utf-8?B?TUxpaHFpczNOSVl0dGpuSEsvMWViN2toR3orNjdEMjFtVWlGdFBJUm50QmZM?=
 =?utf-8?B?WmVnbk5xbitzYk5KWDRXd0ZQWCtBdjhMZEU0SmRtcEJDeTBRYkdsMXBITmp4?=
 =?utf-8?B?bEh4ZjB1elh2elVrbE5WT3pyYVZhQ3ZVeGpWN0QvRGQ3RkE5ai9lbm9rQXJa?=
 =?utf-8?B?Qmt1WnZ3Rm05QWNKVGc3K1hwQk91b0J0NUl3V2tIcTdGaGowMlEwOTFQRUhl?=
 =?utf-8?B?R3JUcDdydmVxQjNjMVZrYjNZc2NUbGd3dzNrM3BpbmZyTWNLL0MzNHl6anVu?=
 =?utf-8?B?WmJjeldpWmZIb0ZPTGEzWEh3dHlCeVBZek9aVG4xZGpsbk5YcjVTdWxJRFgr?=
 =?utf-8?B?Y3hPWm9VM3BXN0xuODRUakpHVHhUU08rYUoycDU2K1NXMTdVRDNKU0FKWHZM?=
 =?utf-8?B?cnBmWVg0dUFGRDNWV1I4QzBRTWhTK3BhTDVIOVZHRURQWk9kSkpsK28yblNY?=
 =?utf-8?B?K25ia1IyanZ2c1dMVm9vdUZPMUZwV3I3UWdwUGlzUlNzOTVlajI2UFZFcW1G?=
 =?utf-8?B?dFRoc3ZSZTNsRVBNVGJZMG9NakVqR1c0eklHMWozQ1IwT3dEcXdMbm1maUJs?=
 =?utf-8?B?REIyMmQ5RjFtWDlKc0EzcU5JM2FQRUYyNnQveEFENVdrVGQ0QVEvOGk4Nm5n?=
 =?utf-8?B?RFYxSU95N0VBbHhIdy9rMGVyTE1zaWpFcE9nNE1FOU02NDU4cVduUGpXZ1JW?=
 =?utf-8?B?Yk82cWc3dFlKanBqa0ljNzFGL1RuWHd1ZGZzNnAyeC9KUG9OeUt6WUpHRytW?=
 =?utf-8?B?WGJjRWdORjdIMWUxM0lDbkFTdlZSYzc1RGpWV0NRVmgwV0pDQU1HNzBsczFy?=
 =?utf-8?B?dGdGZ1loU3FlTG1Bb0xJZXhuY21iYmtmL0tleDY5dVlXR0tpR1ZFNWFCNkM5?=
 =?utf-8?B?SjNRRnprTkNlMVFMSnJ6eFhuZittUVlqV05rdmdkVGlrdXR6RTBXZ2h4TzEv?=
 =?utf-8?B?TUI0aEN5NDA3eUZoc0YxZ2d3MVF5bXNQU01Cb3Y1OWZyTUZnYmhEVVNNeGFo?=
 =?utf-8?B?aTdUdzgzZGoxR1Z3QjRkV3lQRE0yY1NpYmlaZEF1b3E2NDlhMjlRMjRQc0lU?=
 =?utf-8?Q?ntxu89o4EEp7tgJF2Apaerc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 037c2c5e-2eef-4de9-9fa2-08dc8ba1ec8d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 12:11:15.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KogmptkpLFpKuGL2EgOsSen9O4Kho5JVjZnA0ZKPMAc8vt4FKM1W7Sgk/ccQGo8onnfDSfR3oEdpoVAbNbZSBTVh5FrL2c33qFoLs2L1/QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6338
X-OriginatorOrg: intel.com

On 5/7/24 16:05, Andrew Lunn wrote:
> On Mon, May 06, 2024 at 07:52:57AM -0700, Jakub Kicinski wrote:
>> Hi!
>>
>> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) /
>> 5:30 pm (~EU). Last call before the merge window. No agenda
>> items have been submitted so far.
>>
>> See you at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> 
> Maybe we can have a quick discussion and poll about:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20240507090520.284821-1-wei.fang@nxp.com/
> 
> Do we want patches like this? What do people think about guard() vs
> scoped_guard().
> 
> 	Andrew
> 
Was it discussed? Any conclusions?

