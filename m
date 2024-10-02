Return-Path: <netdev+bounces-131381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD9798E5AD
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC461C22BAA
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4ED194A4C;
	Wed,  2 Oct 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVnGxtwi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B54B194ACC
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906435; cv=fail; b=gA+mRlMYa+osfWxWTDpUlAssBwbmCKCfB7WliuSIx57Mgyy425e5t37HwGMs2LbzVePjjsVyEHIuLIsetyAACcy+qUKymQ1sAMjp6J1wxJYzJU5DHksSurovslNFnojNXOU+32jB/XxA78h7C902ArFWSSMf3MTk9UWr+23fxQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906435; c=relaxed/simple;
	bh=nJBvA3HU5p9pS+/nYyNEmZIbn1s6dwjk65EJRbpYcbI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ldfpVGIqOtYzpzz3mEofyT2LCsUO+CNdUyQsqkQQn7rfu3qGpH6uGqZ6k2liwRHgfvQFovdEj+P/XPSECMdZiN5nbibnVgJeCPawnqtm3SJOCY0Uzayu0zieA4CuCO5uex2hMyd1FzJajU5xEjAcaUt6tvgGjvpfSgqblRvQLZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVnGxtwi; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727906434; x=1759442434;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nJBvA3HU5p9pS+/nYyNEmZIbn1s6dwjk65EJRbpYcbI=;
  b=fVnGxtwiSfaqZ+avwNXrM4B0I1ypugvyKcU0oEmVwzpxb3unwWlUdHRi
   B5ECYlxYvQe8nM5efb/0yzeEwZAmd3UVtuYbMM3qK3tkTl7U0S5cY5oet
   TvXj2VmWVpI6c0NWL3amWbPqxOq9b8pDs+PjkUciYAX+8MOTgtLyHj7WS
   7guKGtoMYLpiwEy+o5X9rAA/XS/HvxOv2vcNq1fJ/CHg2jtzpiLyx880b
   yx2pTnbLXJjepkf5suYAcSg9vfIL8eu6vUaAR3kjz+Noj1M+aCuYHNadn
   VzDkHDKlVqN60RoONy3byhY3c/m5pDvFkDyVSnGhaftqjDSRIQXM7SfBF
   A==;
X-CSE-ConnectionGUID: 7mFN/JxyQZuBtFvcdTmj5Q==
X-CSE-MsgGUID: Z6Pxngw3RZKlTVMHz2sM1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="38470994"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="38470994"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 15:00:33 -0700
X-CSE-ConnectionGUID: Ac7MhneAQMewkOIJRd/ntg==
X-CSE-MsgGUID: qg1XCSc4RNGl8/jafkAQCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="73999537"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 15:00:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 15:00:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 15:00:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 15:00:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 15:00:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk9TmKyfFRXJh2TdYAYZoROtosSbF3Ctc/e8Mp2q1ieFJ6o3zRF30qLgpoAEr1kECX1tCskrNxZPLXkcTsMBS3Ksb2f2Wg4WwULeecCLQP+tNO7QW9sefB8dFixbz/Oa8ZnZAvt9AhvN3mcTeTMPqQq2XSTLg09s6KgRst/iOgMnRkDNbSwol/z3UbiRaNlAMw0xL7LNOFHc4bW6k+kAa+0/yGAfxZkxaf0sEOiWW8qa5zSMEqRnqPZKrSUa97OXTxgEQnziinFdyGNFDCpVT9Gy5FBlpEXEGRqEXnzrR0BWpOtG16I+G6pkBTOSaTiHdS1oD4EiNkmgYbFwkzcUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFBPk+Ova1ehc5pJ68L+wOxIXMFBzyxKyVp6xdPdi3s=;
 b=BpqqsJ3LIJyBZxT0ZxAFkt6eNBAtwWYUSoOVHaNANhFHn6won0WA21LFkSokWnx9M3A9YIduEPiEk1XerNbzyK/0y/j62mO8gDQGDMWbdMIaI9SnSbfjYSlkJj8KthkK9CM+q7RdEB/DD7Rm/jXg60gVun9W2B7HTIP5QOd1Hhi4JW8sBBYjDKQhECR5bwgSYbOlr6BjfuyLPlzPWcWw8YPcVQJvGo5XM5bLgIs3KAboujiYNY7hUhgLbkJ7U5nd81nsIycODLsZ0p71P8jObnf2qFp0tEradwQmfDzOfPmZaKvzuzAQBKpBqhknnvKI6WdfXxKrXMRIwC/mdtGzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB7564.namprd11.prod.outlook.com (2603:10b6:510:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 22:00:30 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%7]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 22:00:30 +0000
Message-ID: <5c0d64bd-3730-c0e7-b0af-5929aa4fbf9d@intel.com>
Date: Wed, 2 Oct 2024 15:00:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-net 1/5] ice: Fix E825 initialization
Content-Language: en-US
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>, "Arkadiusz
 Kubalewski" <arkadiusz.kubalewski@intel.com>
References: <20240930121022.671217-1-karol.kolacinski@intel.com>
 <20240930121022.671217-2-karol.kolacinski@intel.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240930121022.671217-2-karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::16) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d53be7-5d6c-4ed3-ff85-08dce32da140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU1ObVM0KzZ5andZSlp6Yi80OFFYaFZRTENGQ0FNck00RC9lRm9GVklraWk1?=
 =?utf-8?B?NVRTZkEyZjF5WmpLQXZSMUw4U2dhUExNVGkrcHI3akx6SkVuZENMTUdvWGN5?=
 =?utf-8?B?aHRwRHZVZmQ4QXN1VjQxV2lrUy91aTJCc1JrRHUxeVQxenQ4SkNpaWRLR3Vm?=
 =?utf-8?B?aGhYLzYrMHZBdHF1ajNoem90M3MxcFA5bXZockl5K3ZSWXNqM29GU05CY3c4?=
 =?utf-8?B?bGo5NzA2eUdIdC9iblQvelBkNVR2Ly9KMGtUdUR4T3pBaC9pcWxUTVBkak5G?=
 =?utf-8?B?eUxDOUZOQ1g4SXMxWXlzdGo1emxObWpRa1hKZUh4Z0cwa1VHaDdtR0RnTllD?=
 =?utf-8?B?bVEvME04dm51RjF5VEQ5YlRaSFdXWXd6ekhsdndPMFZwRm4wU0RYZlFDL1Ir?=
 =?utf-8?B?S2pkNThFYjFYc1NXYk5uU0RSK0s0TU1PanVsOW1zZStYRWJhS3BEcVI2aG9o?=
 =?utf-8?B?SDBKalZ4WjA0UGJBbG0vUlpDVkw4cG0rdWdnc3M5MjBPVzNQeEZvS3lYRFdu?=
 =?utf-8?B?My9GVFg4QnRvdmdYeHI0R3g5RnduMWgxYWFCQzVIWi9LakJ4ZFEzUzlEaW00?=
 =?utf-8?B?dmtSc0VESjdXb0x5RmNpNFJicXU3U1NjTXI3dTZuQzJpcEhLQUYxS3VvZmpp?=
 =?utf-8?B?QXBEa2F0aW1OeFc2SnlvYWhpdDR2dVpNVjlod0NEaFh1dG16ZFQ3QnUrWXA0?=
 =?utf-8?B?b3RlZzV2WEw1QmVWR2NzRzY5NzZMaDBzVlZhYm9BUjF1bTl1SUtXdkF6SVhL?=
 =?utf-8?B?RzN0UFhPMWlOejhuNEo3NW9GaS9yMStYbHNMU1BHdTM1WG5zLzNwOXNKbEhv?=
 =?utf-8?B?aHNURGZtUDNXcnVwRnExTHJYSEMyMjNhQ3prKzRnQXZwZ1RzSnorWWJwOTRU?=
 =?utf-8?B?WGhCZVJVZGRQMlZsdVk2ZjBhMkxkZkxJRjExVUI0U3dIRU0venJjYnVGMXNC?=
 =?utf-8?B?R0pVbitKWG5tTkRON3N6RXFUZ0lFTnNONGphY0E3cGFSelIrTUdGaEF2MlZS?=
 =?utf-8?B?TjdwdkJrV0JxNmFHQld5YWd6VFVoWW4ycVZseFBha1V5aDI2UllxTnl5UGxQ?=
 =?utf-8?B?elZRM1NHcFRJN0Z4M29kdkV5ZTIwV24zNzJNMUxibDNTcUN3MEZGcGhDNlpY?=
 =?utf-8?B?LzhLUkFiRWtWM1M4dnp3UUdMZjZPdzNwaUw3QjlyZE5ZQ2U0K1F1MTRWNDBC?=
 =?utf-8?B?WmtCd3grelF6ZXpzeTgwdUU5WHQ1Tm5BMkFRT1g3NE5KYUlaM2ZTWnNEWHVH?=
 =?utf-8?B?SUphYXJ6dng2TVFoL09jazI2alpjSjJqeTJYc3lvTzVvS3NhWGVWaklEeFR4?=
 =?utf-8?B?QlBHZ09BMU15aUU3QXlYQTdxcldiOFBsZkMrWm9WVnNQbmdEdlFpVzBlSFB5?=
 =?utf-8?B?WlJMK20wckhLZHJ4ekxmMDh3NUcrVzRQTnB4M0ZlaWVjTVpOV1pHUDJmMThz?=
 =?utf-8?B?b1N1NmRlQWdzSmV5NWd4eFdXTS9TdU1EQkF6QW4wTUJRNGpNaDVpVkcvSlZv?=
 =?utf-8?B?Wkc4Y1EzV0hLanlvcVR4WnduWUVSZTVYYzNrcVpBbzlrZUx6dG91WlFHTWxN?=
 =?utf-8?B?NUdsOFJTSjh0MzI4cmtpcVB2ckJ1QkJHU3hCTlFyKzU1SEpoYWpZVmZwcU5x?=
 =?utf-8?B?VGhtcG5FMDZ0T0hNZXUwMWM3VnU0ZktTRTU0NWVSdExUejJkeTMzMUpySkxp?=
 =?utf-8?B?eEZrck1tN1lIeFpiYXB3elpkczcwbzAvV3J5bmVqRjB6a01lM1ZGRFV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk1KbFpOM3A4ZG1WNlFsN0V0bG9sVlIwQVRwTTJVSmgzZW02RTNCK01mMEl5?=
 =?utf-8?B?MWtlRXNzdjVWdEQ3WVdLeDRqbU0zZHZ5eGRlbk1CMnZPT3ZjT2Z4L0g2NmZW?=
 =?utf-8?B?ME56alFUeHdSOWRqM3lkemhhamU3WGV4ZEtLekdYZUJYUXJsQVVWQkhwOG5V?=
 =?utf-8?B?UmlTbk1jV3pQTGlZNXh4cFNaM0s4ZkxYUGp3RjU1dUt3QVNXSnFrdjFmbUVx?=
 =?utf-8?B?aVNFQjJWVUdWd0E0Q0h1blpYY1hjM2xGbVA2UitRb3RodElzTHM2eHFBaEgr?=
 =?utf-8?B?Q1JUL29UUWVNSFNDM041cGFKWEdzVUM2cWhRSmlwaEF4cStHWDdGZjFuOVlY?=
 =?utf-8?B?WnJuNHV0NkUvdG5FdlBaTmJqZTRFN3BVNU5UK2kreUgxUXFJTlRDOURNQWJJ?=
 =?utf-8?B?dW14SkVDQlhBVG1XcGR6ZXJqazIwOWpGR0tyaTBTS0pXYTdSaTl0YWhmOXh0?=
 =?utf-8?B?SkpPRnl2QVF0Yy9MYStFWkl5ZmtreEtsUWtwTGxQL2hNZFVadUFRNVZlNk5E?=
 =?utf-8?B?OUFSUk9FMnFMdy9wSGJmMUNwUitiZ1c4dmVFQWVVc0R3Q3A2MkFPTnRZSytq?=
 =?utf-8?B?bE0yRWdxVmZJMk0zWEhTbDhnMUVFMmdoY3g5eENSczZoZ1ljdE85bHF4SWRJ?=
 =?utf-8?B?R1REYnB1bVJDc0hyOUVacGcxWWZzL3NKWTloek03Mm5aaFpyYTlOMEpkeW95?=
 =?utf-8?B?Y1QyVTlNekl5SjJBTS93QWkvQldWZ0NhK0NvVTI4N3I1aUl2N3JROWFNMTJk?=
 =?utf-8?B?NGVzZDgxcFh2a2IyRHRKQmc1UjhUcjErZ2FDNTBVcmJtaXpnZ0IvaGFCeXkx?=
 =?utf-8?B?cHhGRldSTWowRjYxUnN6dFE5aWsyTzJLUVQrWEVqMDdoQlFrUUhmdzZpbEtz?=
 =?utf-8?B?dDdJVG1SajlLYkdBYjdVN0l3MlFWL2Q1bUJKUVFLbElJSk5PcFpTMFVDMFFC?=
 =?utf-8?B?SFVyQllvN0U1SG9vTkorTVh1NGVTYVdPcVQ5RjBNb0FOSlhwVmRqNEVEZVhS?=
 =?utf-8?B?Yy9SeXVVaGo2cEE2OWVPVlJnNm1EYUhteTdYVWNmQ09oc3NjY1pwdzFMb2V6?=
 =?utf-8?B?NUVyY0hiMTJPUHpyM09MN05VMS8wQng3WGF3Wk1Dc3N4V0k3TTFJeFJjdHVG?=
 =?utf-8?B?cis4RjcwNFUvUG1udmQvSkVVY2NhUDFjOXJ3NG1xMDEraWRUUmphUnRLMWdN?=
 =?utf-8?B?ejR6c0pTSGdzbDVadzdRRUN3WllkZXBCUmNwaGVpSVZFdFN0dEY2a3lzc2ly?=
 =?utf-8?B?TXVhd3ZqMEwzZ2wxQy9UWHFJWkgyQmJWQzRZajE5K21LK0lHQ0wzeEI3Ukx1?=
 =?utf-8?B?Sk1kRXBMZUdEdEYvemFKN0dDTC81eFpYdUU3eDI2R0o1RXVOMnVmRS93ZzNj?=
 =?utf-8?B?RTY1Z3FVTWZLVStWcVJZdE14K3R0RlJGOGFlN01CVXkyejJSTmNhUzJjZ0RD?=
 =?utf-8?B?Q2V1VmU1RG93ejJMOGlHYURyeFVmelA5UUlKL2RlZitWVmVJYTVIMHlPc0VZ?=
 =?utf-8?B?VHZCYXhCR1F3N3lHdzJCeTV3eFJSVml0WlJ0QjRTMzFLVkhzM0M3WFMySFRs?=
 =?utf-8?B?WGthWFdSQzNSdlpqbHNRdDNrOUZkb0xRSGlXVlNqbkwzWTRiVzM2Y25oR2VK?=
 =?utf-8?B?bHU5blRDK0NQOEZ4UlpZNXZ2VDBQdFkyTUVHd3d0ZEpCSndaL3YzY2hwUW5O?=
 =?utf-8?B?ZERaTk82OG5ONjV6L3hUZWhUYnpuS1pDMHN0MWc4NTBsbk9vd1ZvQTQ1cnFt?=
 =?utf-8?B?RHRtWDBDNVMyQmlwc3FrdUJJTmNCRnFscW12Szd0cnFUdGZNbUd6b3Q2U3Bn?=
 =?utf-8?B?L1NiQ1JBemdXNStuZU1mWGJNRGR3bUVEcElPaW9wcm5wYS9SakJQdFNXdGdP?=
 =?utf-8?B?c1lnQnlQa0hPbnlyaHJ6RHM0di83U3J3dmNiYnhld3NsTFJPanJ3SkRBTm16?=
 =?utf-8?B?TnFyeDF3YjBOY0tubXBXU3YvTjhtcWtzcXByenR0UTZwSG1Tblp3TkpJVTdq?=
 =?utf-8?B?TDNFQzFwSUVOelQ4cWxTTG9pekY1akVaWlhoZ3FBc21NUmJGUFBtMVNKOEZm?=
 =?utf-8?B?OUk3Rk5sMGhlT2I1KzFIOVg5WnBlVXJkS3J6eEhIekpSVzUydEF6YXhtaWd3?=
 =?utf-8?B?QXNuVUpYbTlxZVpKVStkdGNWMnkzWWorNW55UmZ4NGdLV2pGc1NNV1RXd3BR?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d53be7-5d6c-4ed3-ff85-08dce32da140
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 22:00:29.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zaf0APs33C2lD/PK4GdehWPLPlB/1rQXP4dNPQypEgL0pIvNvZ9BT0lDnmUYrer7Kp0fg+MnBAZahX/gttZPLDTXNs51ZPHyxRXeHFiYwHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7564
X-OriginatorOrg: intel.com



On 9/30/2024 5:08 AM, Karol Kolacinski wrote:
> Current implementation checks revision of all PHYs on all PFs, which is
> incorrect and may result in initialization failure. Check only the
> revision of the current PHY.

This patch seems to be doing too many things. This part sounds like a patch.

> E825 does not need to modify sideband queue access, because those values
> are properly set by the firmware on init.
> Remove PF_SB_REM_DEV_CTL modification.

This seems like another patch. Also, this doesn't sound like a bug so it 
should go via -next.

> Configure synchronization delay for E825 product to ensure proper PHY
> timers initialization on SYNC command.

This sounds like another patch.

Thanks,
Tony

