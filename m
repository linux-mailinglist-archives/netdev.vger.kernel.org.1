Return-Path: <netdev+bounces-132632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3766D9928E8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4818C283D7E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF08D1B4C31;
	Mon,  7 Oct 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7adzLYM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EAF143C4C;
	Mon,  7 Oct 2024 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296058; cv=fail; b=R6uzWp8bmqA98P/wjehpjd/mhEsGmVKWtKMuXk2UdAxfAePwVbAxjBC5dVUdc8CgGKZA4rM+qZMG8bs7LT0ezoFo45rmf7rlPkFZNMlLtxrgD67TVkIzOIxGPiZdc3UqWSWarU7Lne6y47z0szx+b+xfY5emAZJBiOA1QFUiIvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296058; c=relaxed/simple;
	bh=Wu03jOv6qBZ4beGjLreR8+smW1AtWi1Nu49Krj/R5Go=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=crGH6U8ZwXZaAVIaVGZcyktK320yOlby8O/knW5wq6nh5ef9snSGv/guD4Q/uJqts8tla4xv48oNvikIZq14uLwod4T6Hi1SL6keSyE3TEfrelbxsms/6wsYgy3I+bo4S+gMcNIoIAIPrd3J2Fm3MJpzGmNlG7GsH1vNToHbOY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7adzLYM; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728296056; x=1759832056;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wu03jOv6qBZ4beGjLreR8+smW1AtWi1Nu49Krj/R5Go=;
  b=c7adzLYMAqrcD5T5EC0TQUsjCWYddHATggMmJs2F4B6ahm6/8mulcmss
   5s0wN02yMop9o5KQUIUg22ic2UGoLGRg9I3KEaKK41rrOj3XdAGY3VlaZ
   yFVFVRT47by919hgQnhKZXd89d+Zh2E+sVdllcff7RYoMkxQCWhG5nmbs
   SMFulcA+9wniuTVVbdWo3cvE0J+W2ups8LpISzCa1RGz2n9pg9foFpWw8
   wyTsSHlvzSUkHGA6eei8zuHuo3cLCjGYRLY2JV+XMCPb/zrQiZd5pxS55
   wz1AbU51njra8EcLYama5pJtT8SFGIo540xIkIiFmKjui2f/THKy+KYNS
   A==;
X-CSE-ConnectionGUID: mYdwv8IFRFaluljJIgVrjw==
X-CSE-MsgGUID: Dqo8f495SKmeKnB5YK7Syg==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38804361"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38804361"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 03:14:15 -0700
X-CSE-ConnectionGUID: aF8QC2X8Ta6V44Kn7mxJpw==
X-CSE-MsgGUID: GyYX+wvYTKyfE9taT9d8PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="79416155"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 03:14:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 03:14:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 03:14:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 03:14:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgeyXAxY2ExV5wXdzuppRM/8gpIDzd27DuEOu5TCCnq1Ig4fTeWgsdQfv+Vy+zChcGNuBvKpgX6FmWIKomICyxSh4Tm/DG+RsKLE6JlaaV4JtKlfpZftDlGZrj38qPj3qwpmOr8srHeBr6SNeWVddVBC43a1GDaqIg+uYdj/8hyIjhS0Ouxku9mrAKy2K/nSGDxPdq78WLW/Sqw3n8g45nO1G++u8xWEpNBw/BCZbAQRdUTcMJgfgPUtcPnL6JlpSx66sQfsgMXhu3pkTESfTRPKDGKaL/h8IoL+Osfq3o1lgebBzPIbhnvmsJQ8yoMo7Q2KA33n1kTcYjRnJcObyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx5Z6/Q/i6fihWBXVRsp7LXvq+kH6lhtEMCFs3EJslM=;
 b=nq9JDpSiHMXvnE0l0x/oAghWfg9/AuCP+/5A6YtdHO9Xqn+UdRHcYUPCL7+zvLkxzr76Ce3unParzSRHF0ssDm5YfkcmsMmRyEXwKjQ9CABY/wfiTFGyKpudV+apKyGwcA8LYsXUKW7zFRamE8FlJF1xoqtNW3erno0XFM0DLS1/hQYvE6dREJ9n+XIHqVCK4LCJRBNsYyrLuYORggVb2+/zlr7+llzSs3Q9BTDYFrL0lfbMC3WKeGYstEE50IxNRWpdydAuyMRJsnJCJcd1fawm3tgnxRdAIDDi+o9un+QF0X0jycC6qgaMhS4+6QAJvIjwJam64uaI3acCtW4mZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB7516.namprd11.prod.outlook.com (2603:10b6:510:275::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 10:13:58 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 10:13:58 +0000
Message-ID: <ac59684b-37fc-4e47-b496-e6f9bac87b8c@intel.com>
Date: Mon, 7 Oct 2024 12:13:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cleanup: adjust scoped_guard() to avoid potential
 warning
To: Markus Elfring <Markus.Elfring@web.de>, <kernel-janitors@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>,
	=?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Kees Cook" <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Tony
 Nguyen <anthony.l.nguyen@intel.com>
References: <20241003113906.750116-1-przemyslaw.kitszel@intel.com>
 <63de96f1-bd25-4433-bb7b-80021429af99@web.de>
 <Zv6RqeKBaeqEWcGO@smile.fi.intel.com>
 <c7844c93-1cc5-4d10-8385-8756a5406c16@web.de>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <c7844c93-1cc5-4d10-8385-8756a5406c16@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f07315-9d62-4046-b113-08dce6b8c217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVZsYThQN1JHSUVSMDNUV0xrM0o3dDJJd2VtL1pMVHdPZERaTzdxVTNGdXBD?=
 =?utf-8?B?dGZDbWg4SWZzZWo0VkFmK2FDUTN3eGRCUVBINURvNTR3bUNJNklvSER1MkJR?=
 =?utf-8?B?VzRRUVQyMklaekpUc21vUXRQcUtidVpTcThOcUNtK3F2MkJiZFlmeVdjdTZC?=
 =?utf-8?B?ZXJidDBQRWJqWmowWStCZlVmajZ1NHdHbkF6dmVEMVl4SFpxV21aM2VEYUtX?=
 =?utf-8?B?NzVwTU44dlp0dWtieTU2Yjk3ZkhVV1Nlb3J2L0tkTXNncGFhZkhySnUrTHND?=
 =?utf-8?B?dHhiM1ZJQTlMcEh2YkNCWFpHMDlMNzFvWWZ3SnoxLzBoMEFlaUcxaXpheWM0?=
 =?utf-8?B?OCtyYW1kYXdyT1lZS2MxVFZVN01Lc0tkeVFzV052OHA3SUUrcnpCMmthUk5s?=
 =?utf-8?B?TFcxQ2lYSVJvWG5GaEJ2NGo1eGpZQXNrY1htMHg0Q0Uzc0xxTzVYeVFOaTBp?=
 =?utf-8?B?Qlg2eVRZaUFINXYvUk5LcklwSWM0cXMyN3M1dThsZE9WUWxjczZjTTF5TkFu?=
 =?utf-8?B?SFlXamdyeFJlOGpPdFVQRTA4UGZkRkk5cVpwWFNWc2JBVkhWWllMMi96U3lR?=
 =?utf-8?B?NUl1T0R1V0wwRWtUN0JPSWF3RU4xN242ZHc3RWhNSjNJam13QzdCZmNjMSsy?=
 =?utf-8?B?N3pDTU14Yk5nRFFaR2lMdTN5QnJtaktESWhDZ2k4TENmWGpPNUg4NFkzM2Jn?=
 =?utf-8?B?eExnM1M4VW0zK0dRcGZoR1ZSZXRZaEoxM2lkTG1tRE5GMW91Qm40NmlKaXow?=
 =?utf-8?B?T3BsbVRCL1ZqQ2N3dkRnbGoxeW9sOTV1ZE9hWXJHUTZmQkExZ3paVm9ZekdT?=
 =?utf-8?B?UlFUellqMk9Jd21vSlFsSHl3enVUa2tWbmgwcndleTRzL2Y3VjZkTWlPWHdl?=
 =?utf-8?B?eE1ycWdHYk9aVDRsVmtFRnZxbTc0Y3M1ckJoV2dISGIvMTRvb2pneTFuY29W?=
 =?utf-8?B?M0ZFRmRMVWFNTHRmWVlFbW9tVFQzNllwY1NuVUxnTzBQcllQNVBBZHpzTTVH?=
 =?utf-8?B?OG9iQXRvUW1aby9WN1Z5TmlnQ1FCT3RyTlZlM3ozMDhmTVozY0pQbEVsaXhS?=
 =?utf-8?B?ejhERzJVU3pSRUpRZVgwOVZaUWhZWU8yR2doMzZvMHFLRTVxcFpTTFJQQ2Jr?=
 =?utf-8?B?d2FPSmNJbG92c2lra2xtZG9hSkhjb1oxQld6d0hwRnREN1QvbkFZU3RDNU13?=
 =?utf-8?B?OFhzL3EydURmY0VOTDNyQ1BUQzVDdnJLS0I0b2RpNHd1RmVLZjlKVTlZQXdl?=
 =?utf-8?B?YVF4MWUvTGV4dHJJMlZjK0JoUjJiYk9nemZnRFBiaUNTbVVWRkdiMWRvcVUz?=
 =?utf-8?B?eTFka01aWXNXdkw5Ym1veWpNMnNjMWhqdG1VNVRIRzhYR0dnNWZuU3pZaDBL?=
 =?utf-8?B?SWorR3BrK3g2Z0J6VUZZbDdaNmRLZ0JnZ0hndk1DeVB2WFdXTDdRSUVEMUo1?=
 =?utf-8?B?N1ZxSVoyRHpscHVSa2MzeVZmUThuVkNsYnhYNTVpWG9YYW1vMnNNUko2UE1t?=
 =?utf-8?B?amRQa0tpV1FBOWorVFFqcUkvajBaaUN5K3duZDBZM1NveHlLMXNENkJMamVh?=
 =?utf-8?B?eExnQXM2T3JzK0cvRWJCczlTMkFiYmtueksvOHMvRjVnZTVHdXVVUDJBR0Js?=
 =?utf-8?B?QTBiT0FjZFpDRGhLc3REU0VXMEFQdm11THhyYkV6TWJQOHRBVDZVR0NOcDh1?=
 =?utf-8?B?WDF6TzBKMTN6VDJlNFJpYXdkZEJWT2d6YW9rblJ3cHlMR0RiSko0eVJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHlsOFA2MVdEejZrVzR1bmRkODljekpxVjkwZHFOMVc4S2tFZlJRU3JMSjBx?=
 =?utf-8?B?eVU5MGttcGNuTTkyTHFQY1pQZGppTXRad2N5OHd1enZ1TTd5OVZsbDZoMGdT?=
 =?utf-8?B?NjdmVmJBRVQ1S0pEL3d2WmxWdjF2TGZET0dJOWJ4dlhwZWsxQzlWSk4wY0x5?=
 =?utf-8?B?Z1luZG9UeFR3TUtreW9ISXRmNWZzaHp5VG9qZWpkNzc4VTc0aVlVK0RtcmlD?=
 =?utf-8?B?U2VyZEtGR3ZLY1JVemtOdDVHQnFteFBsVHE3Mk00UGNCc293ZXBsUkZjU3Qx?=
 =?utf-8?B?d0dBOFZzK2Z1ZXYra1JmQTR0L2xxSkNsczZJQm03SjArbng3bTJxaEhIN1Vu?=
 =?utf-8?B?aEw0NWtMU2lFWE1TQ09qYzhIUWc4bFN4cHIxRm5OcjBrU21Xc1ZZZEQwTTRn?=
 =?utf-8?B?STVxVjRsQ2VGV0tRTDZTTDVONk15bm5UUzNvSFNDZzhtRWxUN0hONGI4dW9w?=
 =?utf-8?B?YUVHU09Scm9wSzFYRjZaQW9JVkVidzdRVjN5dlg2YWJncjIwN3BqN2ZDSHRh?=
 =?utf-8?B?ODV0SWZRbElVcjhzZ081SHBVc3NxYWdDTC91VjlJYndLckVNOThuOThLMFBR?=
 =?utf-8?B?LzhiWGJLdk4wTkoweUQ5L1haR0FyQldaT0pyTXhNdHUzSVJoTnVBZ1hpa3V6?=
 =?utf-8?B?cjVtNjFpMmJVeXVvM1NONHZVajM0N09TY2JWMW9adGNKMUZleWVMWFBmQUM0?=
 =?utf-8?B?ZzNQQ0tBQ3J3NTFPTGFZOHBWRE1sQkprc1dFMkFHa1d3NXBOU29Lc0VtOG9u?=
 =?utf-8?B?M0FURmVicTRhcStyRmJRbmQzbzZVdlc0UTVMM1owU0RRUGtjempRTC8wM2NJ?=
 =?utf-8?B?VTRoTllIc1NlTWg1WW10K0tZM0VoZ1UxWWUrd0k5ZWdPTmRsckdDUG1BTjlm?=
 =?utf-8?B?SmRMVHpFbjZ0UmFUZXhEdGxjY0JGTzA5UU9MREJIYVRRZVFiL2hrd3RycytJ?=
 =?utf-8?B?ckR3WC80eUNaUlB4dW1EK2piTUppdU96UHBkTVJmVW1yVk9RMjU2QzlzSjhx?=
 =?utf-8?B?eTRMZU8wditJT2Y0dTJEMngyQW9hUUJXVCswTExzK00vSWI1V3RoNUNoY3ZT?=
 =?utf-8?B?cTZrL3dwU1hXWnQwUjdlYnc4R3krcFpiaU54d0tHSlhYTlVINHorU1BleldM?=
 =?utf-8?B?KzRwRnJacTRuTkRJdk5IbFNHZ09YMVlRYzlMQkxUb0UzdUJpV0lKaVJHS0tr?=
 =?utf-8?B?RytuZnl5dmRUYW1XK2FGYTBBbi9kdXpSNTNTb0F6a2YxM3RieFdxRFF2aXFS?=
 =?utf-8?B?V1Y0NjBiekI4SjF2N3lCMkZDYm9ENWliZVVYSk00bmJZcERwSnBkT2gzZ2JR?=
 =?utf-8?B?ZzJnMCsyeEJjaEJtWTdjNUw3T1N4UUViYVVRT0JFeTFmeGhhcFd6NllvUGha?=
 =?utf-8?B?TnNJcmNnQVQ5aVl5ZGFzbnZmS0FKSmdqd0czQVFQRGxRcEpaRGhEcTc5a2NS?=
 =?utf-8?B?cjM2ZjZoUEY1VS9xTzJQMGJjR0Y5czUweDJjdlpsdnhodHRMYmpTNzZKODJK?=
 =?utf-8?B?TjdyemZUNDJ1cTFmSk4ySHZSMENPM3FnaVVxWTJFMmptM3h5SElQZCt2eXlm?=
 =?utf-8?B?bnArK2RUaDdCZ3JHejFEUG5YTjk5Syt6TnlJVTgzVmk5bkRaQnkxQkc0WnN3?=
 =?utf-8?B?RkRYTzkwcWdsT2EzZHNING1BN1FHbnJ1K0dxeHFtSUx2aWczQi9pVnFiVlYy?=
 =?utf-8?B?dnZaVGV2bGppQlo5TXQ2TXZ3dHR6c1hZTFYvNnJGNGQzZ1llU2pJQ2NCQlhT?=
 =?utf-8?B?SFRKLzFRcGh3SGRPUmlYYVJSbUNZajFRMU8rVmJKUFRIWFB1Rm1sOWRoRi9h?=
 =?utf-8?B?WTNSM0VTOXVQTnpJd1JzUUZRVWgxRVlSSGFYc0V3QlBQUUhUODZwUTUzbWgz?=
 =?utf-8?B?ZVk0VDdSdmVRQkg5WC9jc2lPOVhQaU9VcFFuanVUWU5qaWIyemRFcFZVWWdE?=
 =?utf-8?B?UExIa0NrTjdReHBac09tbzFuQTdTdFRxeS9FaHlENVBkZjV0QUdqRzB5SFlH?=
 =?utf-8?B?K1hHUXZnVjdxc2g0WVUrbjI1YWliV3dBY1AvL0dESXBDSGMwMmJHZ1VwU09m?=
 =?utf-8?B?ZEUyNHY4VjROekRzN3hjRnZPU0tmdEpqd2ZmZUxPZHZLSlZTSWhBdFROL3ZH?=
 =?utf-8?B?NlV4c0VCN3NZbkUzdWlETWJEdlZIZnl2T0J5NmVZa081ajRybjFVQnFJcFdE?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f07315-9d62-4046-b113-08dce6b8c217
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 10:13:58.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdgUqyRFz0qqkPovxptzX8yAZvzx5apHQyijk3eoRNORB33raZ5KcesYE0mWTY13iRukLLLKwbPQt4RukHd1QN3Qe5imFQ10OYwfEbeEN94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7516
X-OriginatorOrg: intel.com

On 10/3/24 18:00, Markus Elfring wrote:
>> …
>>
>>>>   "__" prefix added to internal macros;
>>
>> …
>>
>>> Would you get into the mood to reconsider the usage of leading underscores
>>> any more for selected identifiers?
>>> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+define+a+reserved+identifier
>>
>> The mentioned URL doesn't cover the special cases like the kernels of the
>> operating systems or other quite low level code.
> Can such a view be clarified further according to available information?
> 
> Regards,
> Markus

could you please update CMU SEI wiki to be relevant for kernel drivers
development, so future generations of C bureaucrats would not be fooled?

