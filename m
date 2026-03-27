Return-Path: <netdev+bounces-272427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHA9OsQ2xmm7HgUAu9opvQ
	(envelope-from <netdev+bounces-272427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:50:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD423409EC
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55DD730ECC1D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BD73859E8;
	Fri, 27 Mar 2026 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByJo65zx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA23CA488
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597387; cv=fail; b=PATNhumk+e/o1DyP9k0l1HvYtQsIZEtVcUOVwL5V1V7Q0DAq1piMvNxIsEH93o/UqqYBqbjzPm0T9+1ly2UW8fMWqLCqtILpKe2X0cH8f1o5pG7kx9fH++f0BStZveaJfNqjYZYzZ7eloU0j1FobiN3n0Zk3q6GyHVjwCayuYIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597387; c=relaxed/simple;
	bh=ikBUy7C719IVGCkGNYVpVDsCoVR+9DpOFIx8YmJVSww=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h9tssZYFHJg7KGy6dabmymCdZ/zGIx5+g3CVza8sE9n6n84WritiZJqqUb68xysg3GqqsHNcljRpLTj+0Ykzgfd5hfynDVknCIz5cKO6+PmFhJhIV66LYGjgY0/t2fWWK72MguRZGL6m3ow1oy1gIGv9sL91URPI8WcrxwvfISU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByJo65zx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774597383; x=1806133383;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ikBUy7C719IVGCkGNYVpVDsCoVR+9DpOFIx8YmJVSww=;
  b=ByJo65zx3iPDe9qvDBJaQtJP8vdF8tJY06HEYKs+9AGH3KgpRRTk0icj
   Ob5xNXqUmwVd0lSpYunROjkelC3jJcGbkGhoOIKwubj9JIrCyx0TQoCQQ
   D1Kc1GzTUaHjYBhUxRZ6BWd7f1qCP+okgPpAOPeF3sf2YIdq9i3klLU7e
   O/vBdhgnOo+p1cpuTa5t5UJI1UsJY5K9RJOx2P79Qy3Jdaeci5EqDO0e0
   eEHQzPZykoRb+a27QRiQRFBcRv4hUQJi3/znbuf62CvchyuGwQti4M5eD
   dt8vU50uFDhtTv/sJCHW0B3oBIoOVcIQI7RmbD7rDdda1MKmZ1Mg/TrFR
   A==;
X-CSE-ConnectionGUID: ADBVx2CBQUKNBmZutKLdeg==
X-CSE-MsgGUID: ZfY9GfJDTteOSHzzgz6DRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="78263039"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="78263039"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:43:01 -0700
X-CSE-ConnectionGUID: T+RFb/0GTLeTPqpKAxPumw==
X-CSE-MsgGUID: QkfB8WzpRnCPOzRVphTsnQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:43:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 00:43:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 00:43:00 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 00:42:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CR8gXdpMWvAfBVBkuV3tOSIzCBlBAH9Iec5eWoxPDgXyMONkHpIVxFTUhAUnlq76Gve2qKXLt1B0zWRLRxthyuGRnc8vswmljOydyJdYHfUBHoXiNpcV6ot+atQBkiRj0V9Wkr+Ok9ISvXq8bwNe/8orqfMNtE/6/ilBltHzFjVnikmd/5zmO9BVAad2npLUKT7TiUeHyHfdlUra1QD5vuKT2AIM6O21DQdvv8nM7K+ZE8f6Ejo6eYzPsfzTKqrLZmXIv+1wjcYi7IUf9rP4omxz7mvN8wdwNG38sg4qEvplXc0YR+porvTVXgAoX4E+tI5LZZXxaQgXqDu3wKdUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfShXbwTpZH24UxYagTFOkyHTAjdwxCRLB0KtykuLGI=;
 b=axBG2v6sytb8csVBbbeL6DbDafV6N1xtsC0BPMsQNjqBjoBuKYNBmP9MgJs3befBAHH47bvybwvzvlamDIJbFv9Z+j6XlMfWnDiCGN95kZEHamassrGm5qgqmLxrdtu0ccplay7WSn9NO1w91JpX7SsldlsByzvkCnoWIIZhyZv1Gs73VIEjOOUsNKLVDVWa/9/bFfrThu63K5xE7CSqaSdH1KopvdFBuh3PJYBV5XQdEUpBYhrw0buHXhPt7R65jx4wjU34j+JBu4IRDb0MEex+v8zflR0IGSeM56KAAcs1AWfwF1GzHTFBFnHvbML13v7t0m3zHDfQ41O1vnAHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW4PR11MB5799.namprd11.prod.outlook.com (2603:10b6:303:181::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 07:42:52 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 07:42:52 +0000
Message-ID: <f930e404-412c-46c0-9e3c-feee4d3c70fb@intel.com>
Date: Fri, 27 Mar 2026 08:42:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] devlink: unify devlink_shd_get_priv() into
 devlink_priv()
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <intel-wired-lan@lists.osuosl.org>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, <edumazet@google.com>,
	<horms@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>, "Michal
 Schmidt" <mschmidt@redhat.com>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
 <20260325063143.261806-2-przemyslaw.kitszel@intel.com>
 <20260326143808.1fd69825@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260326143808.1fd69825@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0243.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW4PR11MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bef2057-b279-4eb5-37a1-08de8bd47356
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: cDIOugWgpOeC/wbfNZdE3R/wqHuTKWF+jjz4uwDrLQjNnM8WdSoSLUOCMoDtw5zWseDjx5E4Gov0zco7wfkOeqKg+vpgT81ZVMohvWauyw2dlwwJAPLRarKDZzAMthk+GsJejKTsGLR3JxH3G2vu4BT24I/f+/AzhVx/UUtL9tg9bVUCTeYWcTeOBJN4b8ORRPKu7wdly2YkMebex5okkwDg3AROJtc6/oiRtpb8RAgypVOkaFl/iPmprdUBwU8/V5YObvz/epf6Oczl7qLEFbFlIiDCKsdL4xq9YtqafI+2vlnfK53KL0BUT8SF7X0x/jyh59I3drpvOKlP/VDco914GjzeRigM+qQ5Nv2V9kq1Rdj3Es97i9HFrgkVOJYKwyarV98CR3Ir2PLTbxdOjjtmI9kdpU5X90Z4yv2nk99dptjWo2oWIV3AmtQ0ga+RO5vKxVxUnoaKLybWZJuKK/2OQVLk11/tMS70BM2x7kXoeVZDEHIXTk5PZXoNfVpH+NfwnOT1Kj6QGux5SygBz2nydq6m6q5x3N+2N9WYrR5bNExsHCE8MDbNkpektwi/W507Id7AgkRQowwrOEzaVTZHC7e1kLRkUGTWQRd1ytWYErmZM8yK6SJOWsotUN1lgtCvqvVkLlQB2YkqPugafNF+3BYCC2V5mlj9N8eGXlxDN1QK/M42MrukgBxL7rCPUVJU8pK8J9yrb+hYFl5wD/hSuSQiLwq8Zh1nFVsKHD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjZLQndERFNoNmJHNVFqZFJaWlZSdWorZzRNZGNFT0pyVUYzaDlZUkZBVzd5?=
 =?utf-8?B?cXNQUEVybDZRSkw0NU9nOFNxbnhUamRXZno5Y1MxbDhneG8vWVd1R1pTSXJq?=
 =?utf-8?B?Tm5jMitCRHlFRFpQdFR1Wm9uTElSWXI4LzRZZ3l5Q1p1cDVabkg0OGZwU045?=
 =?utf-8?B?SVhOYVlHZFFrZDNSZ0NEUzVXd0ZhbVBQNnd1elltdFlRM2xjazBCRjVxOXE3?=
 =?utf-8?B?V1BnUmxlYzBvbXpsRnpIQ0M5QVFjcm9VcUxVSzJUbDlITUhlb2IydUQvYkRs?=
 =?utf-8?B?UU02Umc0VmpGZGlJRklZVUMyQzJRUjg1Z0trU2w1Ri9CdTAwanZtTWVpS0NT?=
 =?utf-8?B?bnlYZlVsWDJiZWY1Szk0VkxFb3BjQTJpVDFaUmdXeXBBaUl4TmhHWFJGLzk3?=
 =?utf-8?B?NUZNNGVNeGhxTWlmU1JFRDdnZzc5NkdLbEhEcm1lWnVPQXl6OEdYL0JmUXNn?=
 =?utf-8?B?UWMxWUYySCtSemZ5OTJrMVl3VWx4SW5ObWZnbjlCaWx3YTJkL3ArRzZEWE81?=
 =?utf-8?B?NkNqTDQwZy9SN094dlRSVHVDdXd6MXQ2MDN0anA0V3dNcENxZC9nMVN5bE04?=
 =?utf-8?B?MHB2aXlkWnl2eGkyRkFmZGRWR0s3MGRQYndmdnBRd21nUTIvVXpXNm5ObUxn?=
 =?utf-8?B?Uzl5b2t4ZVZQZzVPMTJSNGFuQmUweU9CV2RJWk1mLzNqK0dxNUZ5VWJsb0M4?=
 =?utf-8?B?QUxWNjJzZS9vcmFlR3RZQ3NqK0JsaVVoNEtqZHZsb3c2c0ZwdnpDYVRKYUd2?=
 =?utf-8?B?U0JqQXpERUpBd0E4TW15Q1lRdDM3ZlhLNkt2bjNvRks4N1lDWjFRMldPci9x?=
 =?utf-8?B?VG5kbThOMy9nQ3BJUWkyYjFFNDEvZmVkcUJzTVlJcENobGNEaGF4aWRHWXFk?=
 =?utf-8?B?UStIRGo1dVlKWHU4b1c2RlBwTHVYNVJGN0tISUwzZWtpcXFDbm92cHFxS250?=
 =?utf-8?B?MmQ4VFlsaDY3T1JaT01jRzg4R1RiZU1BT0N0TlVIZTk0eTJiQ0d1emt0YVVX?=
 =?utf-8?B?YnBvbzBadmZUbVZmd09xQnBDbkhuM29iQ3hJNll2dlBUUlUzcEh3c000RjBR?=
 =?utf-8?B?Sk04TWRxbGlDdk5GNDBOa0x1ZEZMQ1pyMnpFQlI2Y25Fckc2aXZPc1JhSHF2?=
 =?utf-8?B?K3cwRi9JWjNUNEY2dW9DQ0lGVDJob01rY28xQm1HMWt1WnZTdUVlRElJc3M0?=
 =?utf-8?B?cURqbHJycEE2Z0tKN3A5aVVTQ3kwR0g0bXZMUlc1TWpDUmNSdUN2R3h1bWhH?=
 =?utf-8?B?b2tsaEFEL3JLRUhxRzlLMHlEeDlKUkluSktxakQyUXpibnZPT29aMHhoNXA3?=
 =?utf-8?B?Yk5JVWZ0YUhCWDFSRFdoMHMwd3pLRWd4UmpaZXFpSG81T1BKZUlrcXJaUWkz?=
 =?utf-8?B?QkFNNk1VRWhyWXdUYWxhUit2bStqb3AvZFdnQVdtMHZPd01pTXJJVTB5dWVt?=
 =?utf-8?B?NXhtYTJ6SlE3bHUxY3IrYnRlbUNSdjhRcXpvbUZwTDNEZjNqOXJaWExvam9L?=
 =?utf-8?B?UFYxSzJHQkVGT2VqVnJhYm5Ick91ckptaXduMG94V3g5RjE1eDBUZWFyeWxj?=
 =?utf-8?B?WlEyb2JuOFlrR1JxOGVta21wSTVmS1lERG5ZYU5NaFdqVzlwcCs1UmpOL0lY?=
 =?utf-8?B?MkZIa21abHV5YlhGcUFXVmNKK0VQdUQwbXgrem4veDgrak10ZG1xbmtuSGFo?=
 =?utf-8?B?NFJ1YjhubXMxbUthcFk5NUZhY0R1YzE0N3VKSnR1TW9ZVllwRTlCQlAyRVph?=
 =?utf-8?B?QmdIOG9IODc0MURSWXRhNUlhVlNpa1EveTNXMDJHWUQwWnZhVm5jOFBVTE9L?=
 =?utf-8?B?L01vTDJhZ2Q4N1BmRnFOVHU1eUNtazhsT1h0amJtQ3h5YTY0cVB1WEFZTGlK?=
 =?utf-8?B?ZFl0TFRtNXZPcDZWWU51YXdRajNCVGViUzJKWFY3TklmeEYxTU5mTmNwOGFX?=
 =?utf-8?B?R0pkNDlwTjhCR2Z0dkdyRmRUaG9CbjRqM2RZUmE1SEV6SkVtRFZPVS9TVWxN?=
 =?utf-8?B?TXFDUytZZjRpNzJnSXEyMm1jMytFUmoxT1lQMFA0LzhnMjFYdVBtQWdUWERU?=
 =?utf-8?B?TE5Dd0pwOEExMVZyclh1Y1BNRkxSdTYwQytFbWtVcENIODVxbFNvcllZc2tX?=
 =?utf-8?B?ekoyM3FwN3l0b0JnUktSRFFValVRQWMrWGxTR2pDTnUrWVpicHFDaTVHaHlh?=
 =?utf-8?B?NzNMU28rL3JvdnVxQ2tKb0xhSGRXbitoWWtyRWttN2lQTG10RmJzK0JrUG52?=
 =?utf-8?B?SzEycTJCeStraG56bDk5TkdDZlRXWlpkVCs2QjRQWTVHVUJsSWxwNEROZ2Fv?=
 =?utf-8?B?LzByZXBobTU5MFprdDFnMU8rSVM1WkJIU3pJeWxtaEo3NDkraVhKci9PU0g3?=
 =?utf-8?Q?dMgmdL5JqI8xpIZ0=3D?=
X-Exchange-RoutingPolicyChecked: U7LYw415EgWn3uKz0kdqCE8UX80VkAbXVsX0qQNuYP13K1FTe75BoI5V2yTNxt3kvLkoDuJfIFRln+5VKTYRLEkxBX+0fwzWyjIEyzPseEnuIilWRd8qitNIuZ1y+iH0oPzK0GfEZ/pDEMRitHM/lL/L1z97KDWFdrt0vxIayx3YwYNIH/Sf4Ewd7U8juvXUm40i7rns3iAOmVodaYhpt8zXDvtboiAXqcm5dTd1VaKzz0wnj333M/Jnlz/H2Hf2DFWhsvQMwvSrLEobtWTWx8tFMW39PYmwvULAIirIGQY5rpaHS3TYHkiRwBxuTPpFkw/M0pfi7S06jwuXP2OXAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bef2057-b279-4eb5-37a1-08de8bd47356
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 07:42:51.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsDo/Enwzb2uu2rjhaBoKlhq00ZBGy6r8IcBvkQJ7CJS3tOoilyOaAqNBGwRo3kZMlAZVTMUHKbMBVnVhMeA6PMO0wZF8duxOTktMLglMYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5799
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272427-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5DD423409EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 22:38, Jakub Kicinski wrote:
> On Wed, 25 Mar 2026 07:26:52 +0100 Przemek Kitszel wrote:
>> Current API makes it possible to access shared devlink instance's priv
>> data:
>>
>> 	void *devlink_shd_get_priv(struct devlink *devlink);
>>
>> but it is easy to forget (especially during rebase from "before shared
>> devlinks" era) and call:
>>
>> 	void *devlink_priv(struct devlink *devlink);
>>
>> which even has the same signature, so it's hard to catch the error.
> 
> The implicit conversion may make things hard to reason about.

hmm...
now we have simple devlink code with a possibility of hard to detect bug
in drivers, plus hypothetical drivers code that we will need to reason
about. I would replace that for:
"complex devlink code", which will be harder to review, but then without
bugs and with hypothetical drivers code that would not require reasoning
at all (one API call == no decision, and no checking for correctness
later, when someone will be hunting an unrelated bug)

Anyway, I have used "hypothetical drivers code" twice, so maybe it will
be best to forgo this patch. I will just call correct functions in ice,
and we will wait for other users with priv data on shd devlink to see
if they struggle.

The priv_to_devlink issue that Alex pointed out will remain unresolved,
although it's easy to just keep the devlink pointer in priv (as I will
do in ice).

Thank you.

> Are you sure you actually mean that it's "easy to forget" or
> it's easier for OOT transition?

I have literally forgot to change (written from scratch for upstream)
code, in the part that was rebased conflict-free. I guess, I was the
only person that were in need of devlink-shared, with code ready to
rebase over Jiri's work. And I'm done, so there is not much relevance
now for this point.

> 
> If we are worried about misuse we should instead add an accessor
> for "individual" (better name welcome) instance and WARN_ON()
> when devlink_priv() is used in the shared setup.

that would require the same amount of code as this patch (curr ver)
has, only with WARN_ON() instead proper value (IOW: we detect what
developer wanted, and give them big warning instead)
I'm not interested :)

> 
> Or add a third argument to devlink_priv() which will pass the size
> of the LHS ptr, and warn on attempts to access priv of the wrong
> size?

this could incidentally match sizeof(devlink_shd) :P

