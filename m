Return-Path: <netdev+bounces-161101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07603A1D555
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 12:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139E21887A34
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179FB1FCF7D;
	Mon, 27 Jan 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUw3KWgr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889E647;
	Mon, 27 Jan 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977435; cv=fail; b=icbCkhefpN2lDeEuqsO3o4pK4KRNqH43ST60mlpVGx3R83yF7B8paTg+KD3jWTUASb/qLRSlzjsbj5yInRbRZmmB3u8BqjdBsWs82qZEIloarV+cYmAh5vXpXRtGxm13Sz1a/xod75SLnSixMJhjEF6CQs5a+3arhywBIM/HIdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977435; c=relaxed/simple;
	bh=8ko/hVPQcqZ2+ke0cmxxfRTrhEY6dmpAlMsexzZAYug=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJjvCgycnD8RVuEVz7lCCbArWYwGxOfCdWbI8AXFn1mZgr29UXoD21nlJhICnheOnnn2NmwbwUnHo9t3bfEgTzo0gI3vMaI39m7V0LUslC6eaGWtt7bQbveTWOzuv8Db7CbVJPV/w9TjmDfV+6P5pAq5DcT0kI8Wv/GlYod+Cis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUw3KWgr; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737977433; x=1769513433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8ko/hVPQcqZ2+ke0cmxxfRTrhEY6dmpAlMsexzZAYug=;
  b=hUw3KWgr8SMG4O/6getpuzUkuvuY3AstTEAmREAKI//v639Jtn7r3Ej+
   EUPBVGFC3d15iBd+uBGT/gGU/1VMwBbeNUW0zugD1qVRpnRVBB2TqV/ZF
   2n+4JA9Atjmmka9lMgw7jSdvQ8lXgsVUGkZ2eYRKpuIP8pwwtbdHkArJP
   388tNouaCJznIGJhOi9Cp/2SEWGcOoshTPt8xOiKCU+8z52BsZ04y6ETH
   kjH0lllR3Ud+dSVubj1j2l65P46fzbGQvm47UpJ6QEHGMDzSLEWptG60v
   ecsMAb+SsBVpdPENzh1p9tdDRN26tW4hIDBxHUaFqs7i4IOYp36fKHH8q
   w==;
X-CSE-ConnectionGUID: /7TX0qUjRkKxI9TtqNb4dQ==
X-CSE-MsgGUID: cQKI7HnDQiWr1NLamKhU3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="38603437"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="38603437"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 03:30:32 -0800
X-CSE-ConnectionGUID: NB8iNjRmRoOeIT/9OGnyaA==
X-CSE-MsgGUID: SZz3zi7dSqCKJEGqQzW3fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="108941345"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 03:30:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 03:30:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 03:30:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 03:30:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEXHzVErrmbcG79XBLkJFF8p1Awlz/uXPTRyE+AA+p63FBgdntKHpjLZmQv5CkQg4W50XJwlNi8ag5YCAlZtcW8yNtQVFkwYiTSyjsssQtsAgdc72JB404AatTNA7JyeEk235oKePDUHvsrdkx/JvPzW6uAY/RA61mPtYhcBUBdj6loDeUFeqcGFXZzb4FYWSl9gBgaKcivtxnwmcrJz9twnKnzeFNYeWp7volaNprCEji1isI34iy7Hxciiy6xdQdI2M6GDWldqHDuyw5zlh1JfrkU5gnelZPc9OYmtebAVZPfeR4Uxv8Gj4icTL3qkrGxcayBR3LGtNAbKIFQvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ekXDO4oQcDlXE6kkQ3OF1vOVkCvZP8srCLfGtqn1lo=;
 b=q5hEr7Yu6QinB5Ni2vVgwLpCbVGfzNUdijWXR+75Mk/bGQaCEcVDoSIY44hWaoLl+HsMBKDn4edFEV7qHnGWdwcjPOcaJ0az4sT+vYtnbSKHxdWuin8o+3iEexZjZVAEwm4yDzsjJ210U+LVe/v6zZYU/zdYF6MzJo+sfOAIvtFKpUAbG8ShQPFp2c7VavSziodL3387OJxAlzVcxUEQBHF0PI63xSoKnDg7cIZL3qpzdsOZy7w6bG2VOrJPGDIkA/Yv4TEezpf2OmsXPVLF9F09OFBmxuv7ZGjbwV3ufjsDvHXI7WqbJXiSKxFFA18BsaqK0nlMmLrRy3PSii5vjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Mon, 27 Jan
 2025 11:30:23 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 11:30:23 +0000
Message-ID: <2f12d571-44bd-4737-a6df-e9d11a0a9c78@intel.com>
Date: Mon, 27 Jan 2025 12:30:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] ixgbe: Fix endian handling for ACI descriptor
 registers
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
CC: Simon Horman <horms@kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<anthony.l.nguyen@intel.com>, <piotr.kwapulinski@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250115034117.172999-1-dheeraj.linuxdev@gmail.com>
 <20250116162157.GC6206@kernel.org>
 <fe142f22-caff-4cab-9f6f-56d55e63f210@intel.com>
 <20250117180944.GS6206@kernel.org>
 <e3aebbad-42ec-44e5-b43d-b15b9cd0a9ad@intel.com> <Z4+mH7s/YnfdXgJ5@HOME-PC>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <Z4+mH7s/YnfdXgJ5@HOME-PC>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 8501af47-8060-479c-c67f-08dd3ec5fcd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFhHeHBwTHdvRnJKcktkYTRINklnejBzN3ZYd2JwaStwT1VhMW90d0tUeXdm?=
 =?utf-8?B?bEVYUWZ1YXJ0UlJiNTB0aUVjdE04NStzU2JwSndnSlByNE9rcXVXa0xVWGVL?=
 =?utf-8?B?VmEwN3g0WlA5REZUWHAzd1QycldkWmVzZ0NiOU5DVWQzVHdtZDFOcVVKVkNQ?=
 =?utf-8?B?ZVVCRUlHL1dsUVVXVTNkMDVjb2dJOWx5MjBsNUZiKy9qdSt5YjdSYlhVcFF6?=
 =?utf-8?B?dG1rNnJ3YkZhcHkxbUdMUXkrS0JhQmxlU3pZUGhNUk1LOVpMRlFRb1ZzWEhS?=
 =?utf-8?B?L0ZqS0cvOXZyRnk2YXpabzNXQmlrNGgzdm83VlE3MTNSVzJEVG5FeDBKbzZS?=
 =?utf-8?B?Nm5Nbkt0ZmgvRGZnei9lZVU0KytBQWdkTThaY3UwNzJXZjRtUXJaOHNhaHBp?=
 =?utf-8?B?WGxQSVJRZmRDUDZDcDkvVlpZOHpoWHZGZkVSNTFJM1huc3VZbTU0V3JZc1hO?=
 =?utf-8?B?dnRZYTI5QjI3UDJzUkpHNXNCUTJoaERBUnZ0RS9hU0lOdUxiYUxXOVNHMHBh?=
 =?utf-8?B?YkUvN0ZCVDB4aXdKS3ZWQm9qZkNmRGlNYktzOHdDWEY5THUrSUI1K0loczVo?=
 =?utf-8?B?MC9UWXpOMW9HS1dIdUJTNTQzWEFwV1RsWVVRRWxGZWdEckJUN2VoTUwzRmla?=
 =?utf-8?B?d1hlN3haUE9PYUc5K1NMd3BSUHRQL09TQUYzQkhpbHUxMmNBK3VmNTlPa1cv?=
 =?utf-8?B?N3h5VEpZbFpnbWhxaUNTeVdpa0RQcnkrSnQ1N2x1QTZsTlcxYUdvcHpHZWhO?=
 =?utf-8?B?RWRuWGsxRVVUNTNOaEZ4bGQ0NTJVdDBpS3pmYzJzeU1iOURkQzhvcGZnYlhn?=
 =?utf-8?B?NXdZZ3lRYmsvbk9xUTBZRlREY1hIWFpXYStKcDFiK2RqQXV5ZUpCNk1GTWdv?=
 =?utf-8?B?VVMwWlhaS3krWGpIdWpLU2VSOTNzQmhlYnZCM3dLZklYL0NSNzAzOHBxM2M3?=
 =?utf-8?B?RTJUdm1KSXdJdlZVVnNzbXNYZ3pTQmNHTFloVkhTSUtvZi9XVEhYRUhTVTV2?=
 =?utf-8?B?bUt3MGxBRFJQZTNwSUdKYVBDbUdxSTE0Wldma2Y5OUZCNTM3OXlrZE5Qa0RM?=
 =?utf-8?B?YjVaNURzTkRmZ1hIZ2c3dnNPbWtsQ1gyZWlBTnAzSkwwcXQrNXpwQy9RS1Jl?=
 =?utf-8?B?RUNObTh4YUp0NG9TTVMxQUQ5VlRyRUFzR3d2L0lvOUhUQWlVZXI0YytVTUgy?=
 =?utf-8?B?Z2N6NzIzV3pYeVY5Q2doLy9sZE95T1hMTzlHbjNuK2pYWDBrcm9FLzl6cFZm?=
 =?utf-8?B?ZWRKRkl6T21kQVo2MGUxT05LNFk4TFFvKzRTLzN1cUtuQzVZZFlCUnYzcUhs?=
 =?utf-8?B?dGVzYXBHSTNTK2cyUGc0ME1uNkZMK2ZwRUl5SHZBM0daczRxLy9WalJYZzdK?=
 =?utf-8?B?Z2psVlg1cDN6RHFzTjU2anEzcXBpWXIzZ0Z4WXpxUUlEMHloQW02a3J1V0Fx?=
 =?utf-8?B?UUNuU0ljOG5VVFZTVStTTS84VWMzMnM1cGJYZ1owTytIVko1L28vK0REWk40?=
 =?utf-8?B?VWtNd2JZc2QxZ1V5YTgwelpUZUttUS9LM0tKNEhwcGZyNXNSNnRZaTdjcGl2?=
 =?utf-8?B?d3ZMb210ekM5YkZ5cnVCWllGa0ExN3luS1hxOXlBdmErWk9nK0xlcnNnKzZ1?=
 =?utf-8?B?ZWlrQ0xQbVhlQktDcVdwbHVzZ091MFpIWXRLeFRKaXRYZDlTWWlvR0RVaUFj?=
 =?utf-8?B?dVFUaWZZa0g5Z2wxdjZHQkNZdDR6UmRtZjJRNU9PWE8vaWtYS3lwZjhwTnMz?=
 =?utf-8?B?MzBvWkwya3lyWlBlaGg0VDZzNlFsZXhxblFaSU1FakpvSXhKYjkxaWliR0E2?=
 =?utf-8?B?UFVMSmNXaGhBd1VocFc2KzJETDdnRkVxaC9KNUNOUUF1K1ZSY2NiK1J0aC9a?=
 =?utf-8?Q?ucmmt1auiZykP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjN3VGU1cXVXZFFJSXk5cDNyNUgzWHlKMHRrWFpPeW8xYWRCTURGWEtBaXA2?=
 =?utf-8?B?VFN2U1VHbEhPNElJVVRUK2dSb3dMQlptTlZvNXpuL0dIL3VtL2R0UEZjWUtt?=
 =?utf-8?B?ZWk4YlR6R0RDR0ViSGw3NXR6dVdMN01TZ0UzRlk1djJCd2NIVXhlLzR1WWND?=
 =?utf-8?B?Qlk4dzZ4Q2NkRHZSSlJ2WWxwUkw0bDNvT3dXdG8yNkRkeVJiZHFzSWdncjZh?=
 =?utf-8?B?Z0xwWUZSV0lndmNsNUxFWUtIZVJJQjFwWHRFV05ZSnNSazQzOTJ2dXpGRmJi?=
 =?utf-8?B?N3pzdk5oL0NNOEw4dGhCNmYrYzkvRE1iUEovL1ZhdFJhbnFrUlp1RWZnUjFQ?=
 =?utf-8?B?MmpWMFNPZnJWTVJ6Um96RlZFRS9Yb0JuTUgwYm9aL0ZpRElpMlV6MmVvaXV6?=
 =?utf-8?B?WWMvMmxwVEpKbk9QS2crcEo0RDIwQUQ0dC9UVzRqZ0lDUWVOWTlJa1RrZGhJ?=
 =?utf-8?B?dFFkM3Fhbngya2laQjIzVDB2b3JBcHErS3BPTWVqQVRKeHBEK3lkNTlvNmE1?=
 =?utf-8?B?MFA2Vk1VOXZZSitBejR3bUhzWEJaRVV0RHl3MWtkNHZQbmNrNXhNa08vaTkr?=
 =?utf-8?B?dmhxN2NlR2hrT2NpMThpY1lHQWlKL1FFOGVldnUvL2s0dEFmaFpJMjV4dlVO?=
 =?utf-8?B?MDhCTWxFeXllYVJITGdtdGJzUnlsU0Y5bGhNbkthWjBWSGQzN2N2WnlhQUZP?=
 =?utf-8?B?a1Rucm9nN3duczgwcG8rZ2J0TmltdkVUSzBBakVjK1RmbzVCUzQ3MU5QVW9o?=
 =?utf-8?B?V2dLY1JYaHlCMk4rUXB4Z2k2aU1kOEZZTU56UE9nNklOT1ovQlhhSkdmeEsx?=
 =?utf-8?B?TWE1MURWMW52NTVCSU5oYzR0bFdyRlZXM21HNW9zTThWb2IxelN1L09ka1dk?=
 =?utf-8?B?OENlVjlMMW1WR3dWOXBzQUNiT29LUTlHQUxtV2wxVXB6MURreTc4Z1A0TjU1?=
 =?utf-8?B?eW5Ydkc0TXdLc3NGdHdzK0QzRXYzVnpKUDZMK2UxRkFxZTJRbDZ6NzJXdG9q?=
 =?utf-8?B?ZTh0V2xvckp4R3ZFQ1NOV2NMT2djL1BCY2UvSDVTVk5Rc0owUmxqeUpzUlB2?=
 =?utf-8?B?YWQxNmtqUkFPVllmd0FkZ1RxcUVLd00vY25WU2VETVpJczV6VGs5QWI2Uy9F?=
 =?utf-8?B?ZEpoMzdHNDVGbmNVUTFBaCswTUMrdUNCdWRkM2Q4ODBtR3BFaG4zOXRCcU5w?=
 =?utf-8?B?eG9UUUY3ZjFWdjFjRTdkZkZCSms5K3BOWW9NeTRSeXViaVhqVXRoei9CU3hU?=
 =?utf-8?B?RThMUlRndHYvc2VDQmhDWmpzTjVzajIrOUpYeVQwckVKcFVGZjlXMGNBTWhl?=
 =?utf-8?B?TmVVUHIvekl5LzdZQVdwVEU4Y0pxdms4c0JKbUtTeXRSSFRnV3NoUGJZS0Y2?=
 =?utf-8?B?WERLOWlBTU82U0YzU2QxZnlBL1A0LzhVUDg5amZZMm94NXJiek0ya3d3bGRx?=
 =?utf-8?B?WnR6UlRBcEh3WkNTeEdjZWREZHgwcnYvY0VaYU5Pd3d1akVDKzhHcFR4eExV?=
 =?utf-8?B?eGowalRnU1g1WmwwaWtQQnFzeTdCVG4vV292cmExMkNOQW45eHJVdGJwZEZD?=
 =?utf-8?B?eFdDekxrbUNSSkI3WEc4WFZXL3NlYmt1V1NiZmZxcVFoL2Q4QjFmWE16SzVV?=
 =?utf-8?B?NEc5L3M5SEVwVkRMNzQxNHFoZy9ZekM0TXQ2OU9XQ3dhbXYzV3kydmgrMTZ0?=
 =?utf-8?B?YWphQURlYjBzVHg2cWloTXJLWmZTSUtGOGJRcXJRNlc1WmVyZFFWUm9sRGJW?=
 =?utf-8?B?ejErcStmM2VRU1BPZENKdEJZREQ2clRhbDFKVmJld0dpRmFSU2xYeTBTU09U?=
 =?utf-8?B?QkRKc1VNaGkxNDkwQ3pOdFdCaEx0WEMzTHozNzZYTW9POEdRQzB0alYxdExB?=
 =?utf-8?B?djdZRkdtRm81Z2xoUGlJYnN5NWlScGdIbDJWZ0d0ZUhVdFJoeDFaV1FWS0dY?=
 =?utf-8?B?Y0J1Zit4ZVA1cVVselFubEtmekNoMlpXcGVIT1ZmS084a2l0WTIwOWtXR3NW?=
 =?utf-8?B?WlY5ZWNHMGJQUWhoV25vU21ORVBoT3RvcFlVZUJkNTZXUWpEaGEvVnlmSVVX?=
 =?utf-8?B?bElSWE5pbWV6OE0rOVgxV2FUZjdQNnplMmZCMVNDNkQ0SzAyMGd6WUhjOFhv?=
 =?utf-8?B?TDBXWDhJbXpmV1dnWUNhcG5mNTh0djVpTW1kQUtsMVJ1MWlLYitYd0dTc2I1?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8501af47-8060-479c-c67f-08dd3ec5fcd1
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 11:30:22.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fagLWjbl31hucvtBm44xuHKjfEiTaPk5sL13tihEj9JOPJi7Q9wmZFFrI6ta2mamuq6EjWE/dlwIh53at3J2GwTSK5ZGT+W1y9D0XioQtWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com

On 1/21/25 14:50, Dheeraj Reddy Jonnalagadda wrote:
>>
>> @Dheeraj, do you want to hone your minimal fix to avoid sparse warnings?
> 
> Sure, I will update the patch to avoid sparse warnings.
> 
>> follow up question: do you want to proceed with a full conversion?
>>
>> @Michal is going to send patches that depend on this "full conversion"
>> next month, so he could also take care of the "full conversion".
> 
>   I don't mind sending a patch with the full conversion. Although that
>   would have quite a few changes. To clarify
> 
>   1. Are we updating both @reg and @value to be __le32 ?
>   2. Should we also update ixgbe_read_reg() to also handle and return
>      __le32 values?
> 
> -Dheeraj

Hi, noone objected, so the answer is 2 x Yes

