Return-Path: <netdev+bounces-190228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F39AB5C45
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5913219E3B15
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0152BE0FB;
	Tue, 13 May 2025 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kgtSI9cr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B74433C8;
	Tue, 13 May 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747160890; cv=fail; b=nmblYQcAmRvO2w1rum+3nujgbWDLsa2pUHSncOqTcsWGn0xIME0qb2/s8Fd2sUzCLClX0WvCFGfJgz/8wXqBzcq4z1XQ0FYQT5BqJXojS8osHN4m+BCM/abzZrkVu+WxjwxOlDS56/uPkIqjQs0Tt1m2ncBW1XXjXIi3r5fiyqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747160890; c=relaxed/simple;
	bh=526VBvGx9TEfmSfXRvmX/VAd9Q1/GxCEH8NRFWd41U8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8Zh1ngcOdFwQTlDTPFIfHhyi0jJKcFnrOy9kc6F/0lg8YbAGr+/LyCSAD58ogqNd2c21IVeIKIHPi9JJYYOpET2ZOPR1EEmIQXyuoM7k0uA1zKkam6+bUUeK83Q/Wcst359EgJ6q2XVaYVrTwLAlKjmmS40ETUxLxB8Ia1yX70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kgtSI9cr; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQPttsFc+6u52w86ryQ9ocYePJlac4K4lr7Ji8O6wMTHCbczcQ8mxnLAilAV/SSlQOdX8ZZbv+sF+elQ4PvFjriEk1Yy1zXPGydf+e/lQcWgaeKaMzf7AOpwduMy/NssOLb9ta3Vguz6+vC6SHTjXonhwiW529xm7Cy7myzvtjNuvdv+HXd821vbgmD45RHBo3mKznDUJDslAP5V+xdvWzftuNbGj9ThjYzVflLSOqGpFY7PvELkk4LuP6RE+N+IPODLdwuS8TLP0UFrcjr2+dvDVSBxFoU4vOafSTmlrlE7tLtZUGAOKkTCb2cArAb+/OXk5DJmOzf15l8iZWqFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBCfKiLsz2jI7ItgQVDDWUF9ERyhbOa6SZ+/IM7rs8w=;
 b=cjORu7MYVmi0Iwz+igf1jFc2fZ9CznxkHeAzfx6O8AuSRgpqUiD+2AI2dVhY7zhWsGDhGmpEB5x8V6my6wxwe5R3+qepu1KRzqoRQ2cCgbrSFhEiCaQe0GVsEfp9kI5T1kVMmmTOFTNJFcKE2B9fReLMAbPRikiqFCGiwkO0cjAFhX0vEort68Zct1E6kYd55PEC+Yerki6lDAJalmk3gcDBo5n7zSmcJJEWZT6y/07fy9SpOoG7KVD2QTRhUAZLrZMJlYynTlbh3D4/90l8ibqu5YfOSv0UiGCv9hcKK+frUvStbOavLpjxwRejwWBm2fMXN7uS3DEsFa0AO94j3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBCfKiLsz2jI7ItgQVDDWUF9ERyhbOa6SZ+/IM7rs8w=;
 b=kgtSI9crobbJrV0FB+DJYJ8D686YGAQ6vXyOgAiOz8QAbOgTLhAMgiKUsUescSyrp3Y/EK+HCLwf9YChpg6SGWaCoAJ+mO+S23UXweaiJjEX9b6sZ42pEt43+abI3AlUFAOO+vUKhzJOEkDvxb5AHeVBRN2YTBR3JAP1rEFpzr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 13 May
 2025 18:28:03 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::ad89:457b:e4bd:b619%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:28:03 +0000
Message-ID: <7a951b14-c1df-488e-b63b-cdcb4a854b5c@amd.com>
Date: Tue, 13 May 2025 13:27:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 06/22] sfc: make regs setup with checking and set
 media ready
To: alejandro.lucero-palau@amd.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com,
 Ben Cheatham <Benjamin.Cheatham@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
 <20250512161055.4100442-7-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <bcheatha@amd.com>
In-Reply-To: <20250512161055.4100442-7-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0165.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::11) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 517ec89d-3e4d-4175-c493-08dd924be575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0Y2S25ZanNnWE90cEk0aFFlU3pQSThXSXg3NmxKY3I0NjRFWDRUZWFsZ3RH?=
 =?utf-8?B?aFhaYWhuQTgwdWExZmN5WEQvZmNCVEwza2dQdkFNUGNSaEVIRnJ3WXZ6ZkV2?=
 =?utf-8?B?YTdOUUhPSXNzazhOTGZXZmFHODhsOTkzTUZ0eXJMR3pKSnNVVXZqNnZaS2Nr?=
 =?utf-8?B?RytqU3hrZzd2c3RlQmpGSysrRGd6V1R4SG5xTHJoQStuUlJjSnIwbkg3V3Fz?=
 =?utf-8?B?SloyM2lWMlBtYndjUWxFVkpGWHRvZnIxL0pwWWgvaVRvb0xVU2l5UmJjTXow?=
 =?utf-8?B?NlpvWWdaOHEvMmVFdWRuWWdxci9iUUdDUTFQb0pseXlZc1FveE9yR3krYmpl?=
 =?utf-8?B?elBGeGxKYmhoV1BSQ0s1V1NNZC95M2xFMmpxRmFoWFBFM3BQY1JxN0JnTHJt?=
 =?utf-8?B?UjMreFkvL2pBaWJBYnk5VE0xWGc4OHlyZmt0cFgvTHFaVTJQK0xBSy9KMlYv?=
 =?utf-8?B?NjRTbGF3V0FFSGNYZjNwOEt3azk3OWcxNWFkYm80SjFLU0JiMVdROGgrbkYz?=
 =?utf-8?B?dEduNE9icksvUEx6RDhLanFzQjRwVENPK3N1VDNiMWVldWhMdHMrR0pzbWlu?=
 =?utf-8?B?eC9WMkJiNndLN2szN2RYWVlKNExIcjl2QVdqR2g1VnFDS095Q0daVFR5UVhP?=
 =?utf-8?B?RkFjZStoWER2ZEhxemZjTG9HN2p6ZlJTQXNpZ2pOR01PT2RsMXlDRHdyeXZO?=
 =?utf-8?B?VkRpZ2J5UXFzS3NIdVdjcmxxQ1FpM1JST2RpR3hVU1BUTWtKZTR1azNjYk5F?=
 =?utf-8?B?SHRaR3p5RVBMTmhMM2N4SjFnUjlaSmRrUlpDQ1RaTTFXOWVqL3h2T1hkYndU?=
 =?utf-8?B?NzZlOExaUVgxZyt2VXQrdkh1UGdxMWd3bFR4RHVZWmhUdGhiMmxVRWlXUU1y?=
 =?utf-8?B?QUJ4dXVDNkJoektkdnZIL1c1NVJsU1liK2hzUEtrYllId0dOVTdSbFNOekh3?=
 =?utf-8?B?RzFkOFQ3dkFtcUJpblJaWllEYXFDTDVMcHB6NmV0NWJZNDgyVjB6YmlwOXdD?=
 =?utf-8?B?SCt6U3VuMG90KzlGVVl3bVh6NVRqRTJOWDNSc2R0NEdDbE54TmsxNjgrcjNz?=
 =?utf-8?B?bkNqK1d4RUNGWFR3UnZ2aExjMk9UZkhUZ29MS0h5SEdjVUVlQVZCUWdaREtG?=
 =?utf-8?B?dTRabFc4VHFPUmdMc1crUC9nTWhzLzVVS2JLVDFWTzJ0YXNxTDl5QUxXQWNr?=
 =?utf-8?B?Y2I1amxmNlg3S3RVZm05N1pJbHUwb2E2ZVRiZG5rMHNnSm9pZjlXamtqKzJk?=
 =?utf-8?B?dGg5V2FpcHFVMHFaNkpCZnY5OTlpSVRqNHVpTDVkV1h3cFFKL1BNMC8zN0VT?=
 =?utf-8?B?MTBxK3lSWnk1WTdqRG5CUC9JWmtINU9FUVF0WE1XdU1RMGY4T1ZGWldadjI3?=
 =?utf-8?B?cDB6b1l4Zk5aWFFYR1d4anZMdFN3Y1lnSVZPT3BwVmpiajZDZjRvVVhRMmdi?=
 =?utf-8?B?NVdJQ1hqbDE0cHFhWmNGb01OTDRtQU0xRkNrd0xWKzlIN3pNMmpXa2xkZnI5?=
 =?utf-8?B?NDhvRjZTckQxdURRM3E5bWxQS2ZSdDRDL01KbTN5YlUzU0w2QUE3YTRpTGlh?=
 =?utf-8?B?T3dRQW9FTkZmVDRWanJGMnFaa0VSUmNib2c2b0JFSlpqWXZrVHUybVNNb2JU?=
 =?utf-8?B?OHJ1aFlMU0dKdFJkRHd0SnNURHREKzlNbnJWZGhQcnB3T1Fsd0dTVVExRW5I?=
 =?utf-8?B?dFhPNXJyQnF3bHdYQ2xkckRwZlc5TTErbFl3V2xaOFBIM0xXUXFWUkNCcThG?=
 =?utf-8?B?ZVlkQ1JmRGlNYTBCc2pMOU0vYlFCeGlzRHN0eXBNSlpyTGZCL0syR01rNm9U?=
 =?utf-8?B?ZW9nQkdITWhwQXhYS3lYNm94QSswZjk0YmJVM3ExSUwwSXhDditwYzA2aWtT?=
 =?utf-8?B?a0JYRDU5TEo4cEhqN01zT0dvaGFwalRweUlTTnlXakpLL0dmODNGSnhobElh?=
 =?utf-8?Q?5bU7qxPNbYo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VitXWklQV0YvNDNYYXJxV2xObEgzbGFFTHNCNFJGdllXWUpsQUV4LzdhMmhD?=
 =?utf-8?B?Wko1cWdTYjU3Rmsxd1ZRYjJzVmNibXM2RTZWTUxYSk1kTC9wVmVOckluSEN1?=
 =?utf-8?B?UEFGQXdrNmI3U3lkNVRyYmQwQWtISUttVFFCM1FpK0tEMTQzcHoybzlPNG12?=
 =?utf-8?B?cWU4Rzh1bGU4MzJxNUFOUDZXbjRHNUVMMnZXTE5kRGlITnJ4MTY0QnEyTTZm?=
 =?utf-8?B?UVpQeUhyc3Q2Nk9NMHQwSDFjVFdzUmNrQzJaK3Rxci9va2tkcUZabmh6azJ1?=
 =?utf-8?B?ZnBSZnRCVUNYVklZOEJnL0FUT2NUUWdDa2N5Z3BPQWVEUGI2L1F3amVQa2lI?=
 =?utf-8?B?RTFoUDNEbEpqaXJzMm80eDBwMG1DZ3VmVTJYRGNpVnFiS285TS82dG12eWZI?=
 =?utf-8?B?eFBaYjNzdU02ZTQrcWtJWVp0ZDRMSE1jR3VmalR2YzFVL21FRWVGUlZTbGR6?=
 =?utf-8?B?dFBKaGZEWmVlWHZQMTlCa1F5K0FtUzUzWjVOZ2ZQSUF3bjFsWkx6ZVIxY3Zn?=
 =?utf-8?B?SXI3NGtBTE1mYXVKM1REQUFXZEpURDZJWkRMYzV0eUNCQ25mdGNRSk1xSTRL?=
 =?utf-8?B?d0dyVm0zZkdHeTVBQm4zSzZmcDJiMGtsZm1WcndvK0VFQ3ovUmtLMmY4MGxE?=
 =?utf-8?B?R2g1dkNqQlpVbkZYM1hKbnF1TCtzMVNnUEFQZTJ4b2U2b0FTSmk5ZTVpaWNI?=
 =?utf-8?B?WTdhMGJ2bGJCcmhyQXFuVFoyWGVUVGNZRlVBWkpUS1N3dldEK2JTNFZqK1RM?=
 =?utf-8?B?WXhMWVRkL1o0VU54UmVVSlpralFRVWdhRUk0R2QvU3NQM0ZIWWNMMkJlSHlS?=
 =?utf-8?B?L2xuSWExOXhjZEoxVlV2blFHbWU0RzlhUU1JTVQvZ2hONXlyeWp2TXFiZ2F6?=
 =?utf-8?B?K2FCV08rUElwRjRldGpuUXV2ajhacHoxdld1S1N1MDMvaEJqTldiOEFZRFFi?=
 =?utf-8?B?VTFNeDMzSmtIenptS1RraVRZK2dPQWVtT2dwNHhGTTBtOTlHSW5JU0lCZmxL?=
 =?utf-8?B?RlNxSDlMUWRNZGdZdWFaTFZ2QjJHTzY1by9La2czYTJkSjNlN1pCcTI1S0Zv?=
 =?utf-8?B?NDZPcFllTm9yeDZoUkt2d0JPMVlFY3EvSUJRT29HZmxDeU5oMFhKNEsxTzJx?=
 =?utf-8?B?YmFCNDEvL1JGMlRtR3dWWDBXUy9tUnZuVkhoZG1MbXlmdjBDRFJZeUZYTEZV?=
 =?utf-8?B?Wm9ZdnFEZU5TQTlueWpkVGxOTTBUSVZIeTFNU1RqQ1VDTkVCM1VDZVB0VUxG?=
 =?utf-8?B?OW43djhpaEJ0NDZqL3liVTBmOGtTQTJZRmxselB5ZlZwdW9RNmtLSWNuUHNv?=
 =?utf-8?B?Q1pkaUQvYWlHcUNLNXpCRkNJdk1CMjJXZms3MXlJcHdWT0xHQjIyT2dWRnZa?=
 =?utf-8?B?Q21Ba1c4R0M4eFVFOEZrTTJNR0xLNFpMYlZlQ0VSVllBd0VBdzNXbXRIN09Q?=
 =?utf-8?B?NGVEamkwbUl5eTYvMEVJWUdOYlJnb3d3cXpESW5HYytobXIxUE5Ic2krWDJo?=
 =?utf-8?B?WWdodGIrOS80dFcvSnRLOFpzbFVMYWpBeWJjSHpUNmFkK1ZrVkFWV3BKSFU5?=
 =?utf-8?B?VjcvdjBvR2pFOFY5NU9QV29ZQmxXcXNwbmJnMXpEbDFDek45UkVSSjJHS2xZ?=
 =?utf-8?B?L3JOYmNLUWdJV1Vrd0ZoMFg1WlZrMWlDb1JvZG4zKzF5NE82Vi9NQkMwTTJC?=
 =?utf-8?B?Y25rV2Q0UC9QdEd1QVR3eG1uUGhLV2hkTW1JZVZVSUZ6clZmU0RYWUdnc3Bj?=
 =?utf-8?B?NzlYdUZyRlM3U24rOFEralVkSjMrODhKS2pmbGErdWhPMXB3MTRrWXduZVFj?=
 =?utf-8?B?ZU9JQmpac255VElrT3p2a2RzSFRHM0Y2NUJVUytiOGRmMktXQmlVVlBwMExq?=
 =?utf-8?B?UFQybHNTQ2pTWUowNW9FeGJRZW9aR21ZcGlGY01RR0tsdE1WQ25QNjdPNHVl?=
 =?utf-8?B?T29WSm54c20xYkxJNDFJckZmOEUvQTRNeU1ROVkzdFpxYVlOWDRWSVdjamdG?=
 =?utf-8?B?MTBHMUlLSGo2b2VyaDd3RDc4aEhOTEZ4ck1yZ25Jb2Z0MFN2YjVlOWo1SjNk?=
 =?utf-8?B?Q1VPMi8zK0FaQktBYXJIYUNxWU5TQStQMHJZTUVTNk1kSm1SZGR2UlZMWFRN?=
 =?utf-8?Q?wC/JUdN5SBX3hBhJLpnmKeepy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517ec89d-3e4d-4175-c493-08dd924be575
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:28:02.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZGGdtykWmi5DJfuwr/2YdQBdb3fHjvBIbC5AQV3fEV63fQ+pDXsEMu20i7HF8EiaLIW624XS3Bs6jk876FtqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842

On 5/12/2025 11:10 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping.
> 
> Validate capabilities found based on those registers against expected
> capabilities.
> 
> Set media ready explicitly as there is no means for doing so without
> a mailbox and without the related cxl register, not mandatory for type2.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Zhi Wang <zhi@nvidia.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 753d5b7d49b6..79427a85a1b7 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -19,10 +19,13 @@
>  
>  int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
> +	int rc;
>  
>  	probe_data->cxl_pio_initialised = false;
>  
> @@ -43,6 +46,30 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	if (!cxl)
>  		return -ENOMEM;
>  
> +	set_bit(CXL_DEV_CAP_HDM, expected);
> +	set_bit(CXL_DEV_CAP_HDM, expected);

You have duplicate lines here. I think I pointed this out a couple of
revisions ago, but it probably got missed.

Thanks,
Ben

> +	set_bit(CXL_DEV_CAP_RAS, expected);

