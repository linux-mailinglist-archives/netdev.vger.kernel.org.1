Return-Path: <netdev+bounces-189875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633F4AB445A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EDE16C323
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960C4297A48;
	Mon, 12 May 2025 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UT9ZxYXz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1801DE4E3
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076824; cv=fail; b=SrRi0+9gefmmPd7RMo6A3Jvwh1Bhd1CqJEXeUZeY+JGJNt5PMjkCVFfwUuZP1cR5teS7vY2qZ4g6JnVplgaOV+5bmJmdfVhu22iG/n6KEhRZAAIMKqGFNxlO/pce+Muzx2MspbSZvOece2uyJMEc40TZRbjk7TH2W95SyRdmzUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076824; c=relaxed/simple;
	bh=6opTlcaV+XcbG8pE7ZPTf4E8ZVS4eHRS801JkKZf9bI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tp3dsLnqeUwdzE5VqiEc2hFkeTgKwJ/fzj2kjI6uJ1CeHkgfDyWwJzr5ltBzWMHOcCCYbpGsCtUDgmWoKFDs/J2v/Z7P2MjMB0MAcV4VNDRM3Yj7mO/9fmoLE6jRZDxS7whZEOfdyxVW3OahBovUZ7zyApdd1kh4qchtFnMipHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UT9ZxYXz; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747076823; x=1778612823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6opTlcaV+XcbG8pE7ZPTf4E8ZVS4eHRS801JkKZf9bI=;
  b=UT9ZxYXzD+z2VZbaox78iLZqMjhplcUgdrr0durCWqrvJcN25fr9MOdm
   O6seagCJ296Zf+iVBPxiiF91dGw2hNT87H/QXHcnvIocRTzfVo+p2j4nI
   lWDpY1QjaoEM3j/617/ZSe7j1n5jXTwIDaW0Bb7xV2Zg4FLCMH7F0cU9r
   o9zeeyHXo5dfu1sr5qC6/+I2nf8JuonKqKJCpbTupUbAnmZ5ZUCNnHs8n
   lEUTgHCRrE+EGFA6k320XcyypsqFZWAqrpbkSCGULiKVQoAyx/x1wgl+0
   3fQpkQU+p41TZFDw5hqR0gdPDgrQP+lrY5PMtX9qy0k1WOdXlg86e8ABQ
   w==;
X-CSE-ConnectionGUID: zPfO1iJdS2+GmQI8/NacVw==
X-CSE-MsgGUID: S2eT7bCfQimwoZUwQKjh4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66433061"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="66433061"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 12:07:02 -0700
X-CSE-ConnectionGUID: nWb0atSgSzKQwNkSH/Gt0Q==
X-CSE-MsgGUID: 5DZdIYsYTs25rL76nwUxrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="142580700"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 12:07:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 12:07:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 12:07:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 12:07:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLHGvgZhTn1NAsp5y4HR6ePxuHvGOAgFWvqHbalJMtXMi2KSGwa+Gb59GluUvqadEHmNd7wwNbdjjHWQfCg//Kg3Gd1ycjhWyDAfB9PFKc4MWn0f5xUk8g+8sVKGKFO7UqISbyXwZHg2Of7bRwBqflBBpzVj38tWScqZIZQDq/vEyXUERCoUBl+AGkP0KgvTQouHf95ni3SG9VIyzCLzLevXxrCib/YRcb6H7IX9qMwuTJhcHadQnZod+eLFvwTDfxUeuzYY2iynIWIy6Y6Hw9ZSroFnTK7aQGYiSHwUrD/azIFyxe+QkcjkTyw3/fj3C16IuUh9LMXbA42MwM4fcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDzegTI9EG+pnixMGkji8YFhiLKGR0w0BDfif/iHGBM=;
 b=dSDxS88D69oeZqn6a7uYH69ZiA4RIRxjChoOxiJu5R9o7rL5kqqdaV0DcuHG0I8J+c85Shy4zTHQpJS8VELIzJYSeA1hopGUWyEZ+XIOi7W9K0McuJv1eToGzGzaY9wxxLJAf5FSmir5v0zIFnn3YTyd1vckyC0iw7RYcXe/ZN67h3dFV84btCpwBLqpNM1MrcWq9f2pA0c1DN/l+BRygcJelsjVFNkNlK4tqidVOhi9OtKC29rjGU6YHBR+75HuwQq+lPTmaUJv/MXE4r49H2CGt8cq6othRRp5/KKanHp6DZUnG7EHeOXUynvn65CvkDbiHUUmm2mnAHwX7V4GBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB8271.namprd11.prod.outlook.com (2603:10b6:a03:47a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 19:06:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 19:06:58 +0000
Message-ID: <6984e594-b5eb-43d7-9783-fca106f79d8a@intel.com>
Date: Mon, 12 May 2025 12:06:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ice: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
References: <20250512160036.909434-1-vladimir.oltean@nxp.com>
 <f557afc2-32f5-4758-9c68-dd319ce508ba@intel.com>
 <20250512185346.zxy2nk3kexhqf2px@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250512185346.zxy2nk3kexhqf2px@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:303:2b::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e458ffb-9841-4f49-8e70-08dd91882b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1hwVFBINU5pT21PcnRLUkp3eDVEK01zdnBwNitjN0xvWTVadUJUczVRSTlt?=
 =?utf-8?B?K3orK1lXeE1uc1J6R1BqOWtiMVBhVDJzdDZQWFZ4WGZIYTFXNmptdEdMWWlw?=
 =?utf-8?B?dmxnZGZkTWRqVGJ3bnQrZjFVeUdnOHJsZ2Yzc2hUaTF6QWJRa0dyejZ3RDlD?=
 =?utf-8?B?YVJvMFd2aHFsa3htNlUzdG9NVXhGN1E3WW1oMWNaMUYvS0tidm1sZlRSS0Ew?=
 =?utf-8?B?bE4wMEY2REpHajV3eElxNVRIOUdsNndYTG14ZEtXSzJNaThLNEkxNUcvVzRq?=
 =?utf-8?B?UDVOTFg0RE0vY29kU2licmVHTzlJU2NiTEVKRmVEUU1IU2ZBTTZaQStWSFpC?=
 =?utf-8?B?eklQU3hvM2pzTHFQSVZOUFJRMG9NNDBpS2lkdGNLaVdLOWw5Q0Nkd2pQT3JB?=
 =?utf-8?B?b01KLytoY2g5TEtCaEVXOWRiRDdYVnNRNFRjRmhFeWN3ZEZURWpYQmpKN3hW?=
 =?utf-8?B?UE1BYUNIVHhWS0RCMUFISFhzTS93d0hjUW54U3YxdHg5Wm52TkpsY1pIcWw5?=
 =?utf-8?B?K3VxRlpXcytNcTF2b3h2Ylp5V1ozZE9GVDJsbDc4WjJLY2RKcHVKdUxqRDhW?=
 =?utf-8?B?eldIUGRWaTMyRVRJSGpHakR0bU5UUi85d052RG1LQmpTQ2hoVFFhZTlKYklr?=
 =?utf-8?B?alVyeVY4UmZWL2lkMytibjdPREpPQkRCWGNrMHYzcjBXRDdyMFFla1ZYUFZs?=
 =?utf-8?B?OC9ZVnVqb3BrcDlCb3FQdVVSZmI3a0QyN1o3dnA2OFdrL045RkFLVVQ2RTBi?=
 =?utf-8?B?Q0ZRMTBpdFVQalZuRElHMEdwVWd5dngvRDhsOWJhbnZzSjl1L21kVXFoUmdt?=
 =?utf-8?B?MTlFMGdRNHBKWFpUdkhjeVFtYWQ1UzVUemRTa0d5VWtya0FaSzBsK2Q0cWo0?=
 =?utf-8?B?enY3R25UWlJxVlE1aUdFNUJLTWZrQmc5TVNsbGlXRW1UYVR1L2JPZ2hEYUE0?=
 =?utf-8?B?dG91S0YxeUc5QXY3NE1jc0J6Z0Jod2pRK0FyRXlBV3MzY1dENUlXY3pMbFNt?=
 =?utf-8?B?Sjk3L084RVVMOWJUOGJ4U1c4UHphSGpUOTdUVVlmZ3ZuYW1JVXdiLzZkL3Ew?=
 =?utf-8?B?TDY2RkZHZEJ3TGxEdVllVEIvdURPZDMyM3g0Yk9Uc2tHdWN1dnRrYnJvQjJI?=
 =?utf-8?B?MDFFMEc3Z2ZFeXY0ckU1TGdlT04xZVdtWkVlL3o1ZGVBc3o4S24wNExPKzRB?=
 =?utf-8?B?OFRMa1ROU2FYWG1TQ2doN2FVcHd2cnkvdzd3Y3RObEt0OHRnclcxekRSYkFk?=
 =?utf-8?B?OVdDVHNuMGVzRW1GOTVWNUZBc3h3Q1Fva1VWMGVyRE1tZFRGUFBldzdyVHB3?=
 =?utf-8?B?Y2dUeHZFWDcySFVDeTJBY001anhNN3Q2dENVRGJqM2tNT3p6SW1QVGNaSHhG?=
 =?utf-8?B?RC9YRXZIQkxKS3Vzd2k3d1ZadWU4c1dPbEsrcDVPUlJieit5dGtJVVUxcEZr?=
 =?utf-8?B?aXlHeG1Xck5RVmttTnVWUVlKMkRWUUhiQVRYY2hhajBxMVJnUkZiaXBaWHVm?=
 =?utf-8?B?VkhRaGp5RHlwSGVTZ0NPeTNyUWcwZ3E0SlJ6UE1SZFBTWDMxY0ZrRUdxakxr?=
 =?utf-8?B?UlZFbWhhVzgwejhkMTdQMUxJcHdBOEZoNUVRK1ZMdEh1eTExZjgrNTF2VUp2?=
 =?utf-8?B?ZVhVQjNJbmxyNDdOSFRJR3QxTFoxZlAzb2pZejhHTTgxK1puRjl1Z2ZRZFNL?=
 =?utf-8?B?QUt2VmtQZkZuTFhQZVhvWjNNRVlnV05TL2ZUbFdIL2pOT1MrV29CQnBSZDIz?=
 =?utf-8?B?eGlhOE1JejhnS1BnTk1lcXhjN1c1MUFvWkVwa0lZdnEyN0hsZ1FaTGdEbUMz?=
 =?utf-8?B?eEdRUXF6UTgzVFVlRUF2ZlljVFpiSHhMN2FnTTlmRmw5WmJvTWp3eWZ1cWxF?=
 =?utf-8?B?UU9vWjliQkRYcDF1N2J4YnVJT0phZ1ZhaG1QQ1I0ZXV2V2U3cThzYzd2dnlZ?=
 =?utf-8?Q?9DlNI10ZWFc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzdmRVQ4ZDNHTHVIZWU2YUNsZUZDdU9YT2FDT3l0TDYrL2h3U3JGS2RnRjMw?=
 =?utf-8?B?a3FsTUw2L0d3b3JXM2p3cEVOWTRMOXpQMGVpR2txbHNCd3pJTWdPbmM4U25E?=
 =?utf-8?B?SVk1QnZ1NGJMSHN4dy9PRmpnZkR2MFgyejM2WEd1S3VVN2lZR3RQaEJFVktx?=
 =?utf-8?B?b2lucHN1dUxXVDl2WUE4dENDcmR4ekVxUFliYytUYnFmRzdHTjZISnc3QjUz?=
 =?utf-8?B?MWptTnE3WTJUZ2RydktKdXpKNjNkR2w5MFQ4MlgzVitDdTJhVW44RGd2MUFw?=
 =?utf-8?B?RnA0bGIzOUI5eHpHNlRLY1poQzZhdzh1SFY2YkJyYVYvY3VZbVRCTGQ2ajBL?=
 =?utf-8?B?N3BsMEduR0NoOS9oTjNWNlhRd2xqMkNka2libDdibmtPZlo4SWJXN3ZYanda?=
 =?utf-8?B?KzdXeVpJUkF5MVQrbi9qWDVVMlh1ZktKeXhhemlXdC84VXgzNW9XekFRUlFm?=
 =?utf-8?B?aVFOOTFFd08zcUNaWmorUitJUllkeHZHZnhCS3hnam1RbXZSQVNTZDlNcGg5?=
 =?utf-8?B?SlEzdm8zQXJGaWlKVnpLYU43ZGZvdS9jMkdjOGZNQzRqLzl2SkEwajZxNU9P?=
 =?utf-8?B?OHE1OUtIRW9DV3JCM2R4Y2ovQ0FQOXBpVDZVeExOSTZrWk9kdnY4UFRtdmRC?=
 =?utf-8?B?QjM3Q1Y4NVBCWTAyR3YvWU80VTNjOHJ4WnlBTXppelFJQlhXdTZSdjAvc2xV?=
 =?utf-8?B?RTJJclNHQ1Nyd2JnWTdsQTlLYTMyejVtamFrd0Q4MDBrRFZqV2NvR2w5V1Vn?=
 =?utf-8?B?MGMzTzJZK0R1cFFiM0VId2EzeVhTWGQyV1BXUkQxQ2hqSEtBZzExSG4yQkYv?=
 =?utf-8?B?cGplZG43d29GUGlGWmQxYmVXSWZwYUh2ZHUwUmpnWmZSSlRNNlhtMFlwMDdB?=
 =?utf-8?B?ZzlTOUc1cDgzQ25NTkdYQzhOOFVwd29RVkNoa0hWZmVmMWpyNmpucjMvY2VS?=
 =?utf-8?B?OGdnbGlpQ0hvbGdzV2JIMGgvcFpnTVE1dkh2NGRkSkF6YVJUWms4bjFaUTVL?=
 =?utf-8?B?Myt3SHRFa3RwUzl6VnNvUG90Qlk2Szljb1JEcDcwd0pBd1V3b0EwZWJrY3dq?=
 =?utf-8?B?WDNLRWxBM0VXWC9ISDVZMW03cjZ1d0N3cjM4T3BLa3QvNC9qenU1bE52dlJU?=
 =?utf-8?B?QmkvTWF6UGZBbXFNRmxDOEg5VGI2REJDNkZvS1hVUzRjTFBuK0FZbGJvRWRJ?=
 =?utf-8?B?UTJlRVg3alE0QTFyWkdOdVZ5bE50b0pENkJuMGJza3dFMlBKYk9UQlkvbjFM?=
 =?utf-8?B?N3U5d1NOLzZ1TTNpaWNSRkN3QzF3bUl0OTVXaU03TmwxQXZGUnBDcjA3ZGxt?=
 =?utf-8?B?SVBDTUdqR09jTDFocmlBdGN5TW95T2FMbzVyMkJnbERBOEtzZ2Q2ODNOSjFB?=
 =?utf-8?B?djhSVzNNcFJEeWpEekNodm9UeHdRM2xJakQzbldPMVRRQ0hlM25tQnlCdENm?=
 =?utf-8?B?MnFXRXZwRmQweDNWZVBOVXdMRGN2cWI3MHpiV2dOcno5b2hTMTI0bXloYUll?=
 =?utf-8?B?MDNZTWtab0RBODhOYVZFU2hLb0w4QnBhNEVMZzlJbnM2MmcxTmN0RStxZmlT?=
 =?utf-8?B?RGRYT0d0a01NY2QvOEsrSm14dCtTcW9HOHV2Qjl1eGlUWWVIUmxIQ2krUFFE?=
 =?utf-8?B?R3RwMHJYYmZPekNITGF1NXdGTWowQjQ3RFBYdDdrWUp1SzFXbXhkSVRWZDdQ?=
 =?utf-8?B?ZTV2KzNvbGw4TTRSYWJLN2o4djJDZHdkcmJ0T1ZXd0lTSW4raldCcEtIbVlR?=
 =?utf-8?B?K2xDZ0FVelZWK21ubytla1NFTVBVNlhmdmY2eDRmZ3U5KzE5Uy8vYk5RYnRy?=
 =?utf-8?B?bVVWSWJoU3QxMXlwbHJSY3I0TmRiekZkUEIzQ3dPSUVDTUU1WDBaYnpRL0RD?=
 =?utf-8?B?dGI4RktUSjl1TmNSVWJzcTN5NEcyUTRZVHBvUmcrcjNBeWtRMmM1Q21FT2Iz?=
 =?utf-8?B?TnFMaG9BTVVtelV6Sk1MTWdzVlZ5ZkdPbDczWks4UndhbHFFVExSNU04QU5k?=
 =?utf-8?B?Tm5mek9LNkRRaXUrWGQ1UFRobGJ4aHZIeFhIM09lZ3VJRGZtdmMwRGpJN0xu?=
 =?utf-8?B?cUVGdWtJeDNYbDU3NUt3VHZzNVl1VHFRRERVTytEbTJoUExZMnhSTlZOelds?=
 =?utf-8?B?cHBJQWdzb0lDNUhmWXFGVDdOVHVibWxJNUFiYWZJZFZuUWhiLzJKaEt2cnpC?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e458ffb-9841-4f49-8e70-08dd91882b61
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 19:06:58.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0FFZDpi20CzHqh2wcEqUqP5lQwjtVTfeTcyB7Ko3ZXYl7WaslxR+g8biByNRAQD7iF+ipRtr0UrQg7eNaiAs5v7klELm2Cjx9ZpuqUq8gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8271
X-OriginatorOrg: intel.com



On 5/12/2025 11:53 AM, Vladimir Oltean wrote:
> On Mon, May 12, 2025 at 11:38:17AM -0700, Jacob Keller wrote:
>> On 5/12/2025 9:00 AM, Vladimir Oltean wrote:
>>> New timestamping API was introduced in commit 66f7223039c0 ("net: add
>>> NDOs for configuring hardware timestamping") from kernel v6.6.
>>>
>>> It is time to convert the Intel ice driver to the new API, so that
>>> timestamping configuration can be removed from the ndo_eth_ioctl() path
>>> completely.
>>>
>>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>>> ---
>>
>> Acked-by: Jacob Keller <jacob.e.keller@intel.com>
>>
>> Thanks. This has been on my list of nits to cleanup but I hadn't gotten
>> around to it yet.
>>
>> I'm covering for Tony for a few days, and will queue this up on his
>> dev-queue today, so that it get get through our validation cycle.
> 
> Ok. I have 3 more Intel conversions pending (igb, ixgbe, i40e), but I've
> put a stop for today. I assume it's fine to post these to net-next and
> not to the iwl-next tree, or would you prefer otherwise?

I think we typically prefer to go through iwl-next because that lets us
run a validation test pass. I have no personal objection if the netdev
maintainers want to take these directly.

Thanks,
Jake


