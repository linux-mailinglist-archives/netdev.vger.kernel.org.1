Return-Path: <netdev+bounces-258523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3BqqJx5djmmdBwEAu9opvQ
	(envelope-from <netdev+bounces-258523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 00:07:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C25F9131A38
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 00:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40CE5300E5FE
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 23:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682DA2DE6FF;
	Thu, 12 Feb 2026 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmEL7YVR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142E284663
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770937624; cv=fail; b=Sf52omghgqo6xle9DNMiJwN9q/9QEsfR6rfE/6M/PX7LBysSP2DJMu4zt69E4ge6DnnNc6+DBYIEIxa7TqQbkQsqJHo60eB7B2kYLSdIInKV7vvynBHMgHLD1yDHhCDBLwt2yUrCs3Z7F/mExkiHTs2487xc5y/XOUcenPF9vVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770937624; c=relaxed/simple;
	bh=ZNk6YiC/MJ6d098ZXKM70CMXz87tr5tYiQhEM1d5x44=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E6ywmUZQlWpkIsqwIrcNmq+CaiaRltBHEAL0P50sMEFwz21+69PAx3/oe0lPYW4Un6Ek25Jio3cP+KCKUV4DnbfHx0VG0/fjiLvEMZPmx9eVWCOQGBU+KOL5bFIseci93hz6bdzkHHjiGWqQgYiJ29Iixx6STSngKNonC8I0wxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmEL7YVR; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770937623; x=1802473623;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZNk6YiC/MJ6d098ZXKM70CMXz87tr5tYiQhEM1d5x44=;
  b=MmEL7YVRunMZL/Pnsr34T1YuwCAWJkV2tCKAYqF3Ma9HGVWMYsn/6Wqx
   vv6IRGde7Tn6nvL7fuG9vJ+vh3Xs/IMcm/e9HFd0CNmxnzIcQEdWSkDYx
   LoFD5196FvVaC3Wna3Nsb+4fanFPaV2xT4an5BLCPcZFuopFkAwu/RHF7
   G0deJ2a5HEGjQIAFI7ZIIW7J0BHoz6cg7j8VcSG87mTlcC9cfDi+CH6U0
   xLqdQDa0uf9HmA1rczEuUYiK1706NQG/ZUHC/vbz/9MBpXmF5vWfyid6q
   +6fWu/BGKyq/4ZUf3CIk3/Q1gH8mE7SSAPBtS0dijStfQk7c2HF/O2u/F
   A==;
X-CSE-ConnectionGUID: A1aUW4H8SCW/HDNWfCi6tQ==
X-CSE-MsgGUID: IPMHKLcNSuCDGmZ6ZrFH8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71837785"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="71837785"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:07:02 -0800
X-CSE-ConnectionGUID: guIGzZ/4SsiGNoOgKpdUpA==
X-CSE-MsgGUID: hpWVLXJiQry15z0EJqNejg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="250428294"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:07:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 15:07:01 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 15:07:01 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 15:07:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueQ6yF07Hv542meoGeMUGq6dY1OPjK0Hy4zvO4LiFkR6BRZ5a25J/vHMdTjo9wDBbQFHMaHmjWwgJ7jkpPzx0D6inCek4Xw8X+pNin3UWErjTjiMqEYlradNblicAtGksulbXfcU3Jy8l6MeQGkEc2gEjGSNnFegAxHW/76OIUvgpP58Pww1126FbAEpIAY9AxxfLO+uN3n1Y4GUCFHgCB/v8l5hfHCiDx9cub+O47GC77gPDN3/IJR6bAU0Oy8aIXQaROvgrb+bUfu9PJK0MdCRSNCSXoCRnmi+PxuFkBSXSiqTz6dTYoglT8pQtH2G0CdYkOB4Q00mvRItjqmSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKnFFlYsw/4GhlW/MPXfure0leqZ6q7mH5Gnop+1tao=;
 b=cz6GtlwoTWoMi46IPJerbpgK8ObxtakfdNuMP1BeCy5mW+Z2l+GBS26ulinXH1VS6FxWrQN/E+w/v7Ds1gznR0T+cF5tZDrSaFql4qWZq5dQOHd3kHoaY+Sx35hBtp9umouPD9/ygIra4Bc86TYUPDVauzoy9hxQAVJLSfrqGmCi6sOHANf/1/FgVhRVTPa8fythC2go+1hwWn0conFEF5RRzzY6yKb7Jir8ajceuhtA+MSUVV/cu0NddNbNc2PRK34Krnpxgqnn032uAlNJuWr3RdyqXiA8t5VINFWJHTxkx67vj4suTs9Z9RvfIe1ALLD+tj3gLfFp3ZuoPtWEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 23:06:57 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 23:06:57 +0000
Message-ID: <e458c560-099c-4c7e-be33-8471e8979347@intel.com>
Date: Thu, 12 Feb 2026 15:06:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ethernet: xscale: Check for PTP support
 properly
To: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>
References: <20260211-ixp4xx-fix-ethernet-v2-1-07567f886c8c@kernel.org>
 <168768b8-f26f-4f4d-9b76-230a76c312d2@lunn.ch>
 <CAD++jLmaYU_r+Z+t=6a9GZuVNGOHLGUfp7SDpDH8jnRqD1TLhQ@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAD++jLmaYU_r+Z+t=6a9GZuVNGOHLGUfp7SDpDH8jnRqD1TLhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0210.namprd04.prod.outlook.com
 (2603:10b6:303:86::35) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|CY8PR11MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: d465c07e-39f8-43d5-6595-08de6a8b6b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N01ldXQwNTRBMmI3S3JOVmE0WmxCLzJhcE9YdGp1alRlRnVXNWE1bVNIUHRZ?=
 =?utf-8?B?aVRUQmoyVFp0cHNDRVFmZEhTeWI3bFR2aXpOWit3SkxSY2NXeVRmMU9XQWNo?=
 =?utf-8?B?MWxaWEYwK2kxYXI1MnJsK3I0MzVhK3pGbFpMTS9md2tLSkF0NWt5REc4WkZX?=
 =?utf-8?B?UFRjRTFaeDZ0ZXBNSTNBcGdNb2lKVm1JNU1URzRaQ2xkUWdOcGgxaUhROE85?=
 =?utf-8?B?bFkvaU9ZZ3pWVDlVMnVJWHRwTUNEdHZJOWdpb3JzaEFRRnFFYS92bGZjaWtN?=
 =?utf-8?B?UldUSU9hUFRhSjlQaHY4NHFXSFlGK1NmSjcyOVRtR2U5SlJzdHZqbitsSUo2?=
 =?utf-8?B?NUs2Q3RvVlJPMG9Lb1pFTWdEZm9FeUJpY21KVVJvRXE1b1A2cUFnR01KaFlX?=
 =?utf-8?B?S1MwY1Rudm9lbzRRRFNkOVcrZEV2SHIybGkyajFxUEtzNTBITkxNdUVpSTJ3?=
 =?utf-8?B?RnFwZ242SllZQlpqdFpvWlRrZEQ2S284QktoSmZiVDYwN1Vzb3Vycy9Wanps?=
 =?utf-8?B?YTUrQlJWN0daSnNWNTVSUmFuaUNjdlhLMFZjaHI2TnVoSG9CVS81NmhaWXRQ?=
 =?utf-8?B?Ymk2NnpTUjRXWk1XQTJSR1YxRUtjMFJnMlk5aHIyM0ZMYktMOW5CbXQ4aE8y?=
 =?utf-8?B?V1BrcWFjQkZyU01IdU9SSWJGSjlGQ1NRV1dRSWhzQTNPU213bnZ5OFJtTmFM?=
 =?utf-8?B?c0VzWTJGR2FKTk1JRWZUajgxdStCeTRHUnZDVE90WlE1aXdLUmVYbVJrZVdq?=
 =?utf-8?B?YkJkQTRDS09zajE2aGI0Mjc4bWZjdXJlTXoxbS84dEZDREc4VVBCelRUMUcw?=
 =?utf-8?B?NW5reXMwMGJkMXdhTG1qWE5VdFFMUERjZENLWjk0NUVSaXc0eUE3WCtBZFBh?=
 =?utf-8?B?VWlUUG1yL0FiTDQwM2dzTTkxQTZOcmR0eWF0Sngwd3liY01Hdm51QWZ2dnNj?=
 =?utf-8?B?NnYzWVJjcmwxYzl2WGFMVXQ2UHZCUmZuSG16a0FteGlROFpsVXlocVhXNDlQ?=
 =?utf-8?B?THhiVk5Zbkl6SzJrRGYzak0xUE0yYWJ5UlBiVHhIQlJyekZCUkdYbXpvTXJl?=
 =?utf-8?B?bVUxMUZBcHhORkIrbXh5Y3R0WTlqVkVudmF4em1mOGhXalV4TEZtdHZmL1Bo?=
 =?utf-8?B?d3FKLzJZMDE3bjVVSUZJRWpTc2NCWkEwazIzODVSeVRjeWdIWEU4OTJCbUo2?=
 =?utf-8?B?Qzh1OXBBamhNeHY0TXZhaGsxWFUvYlF2ZEIzMW1NTXZ0aW51UGh0M2dMTzhu?=
 =?utf-8?B?K2FKVUFkYWZ2LzZVK3JtbGdSOXJVNFRwd2tIU3dUN2tyZ2NFYmc2T0NFb0tK?=
 =?utf-8?B?bkdXeFlPcElPbzZJdUx5MU1kZnJaWVU4c1lxQ2RjeVFCazNIdUFOeThwSHJF?=
 =?utf-8?B?QWJXYjBiTVlYWFNPYm5kZmpQVVJmQnZRVndycmVNU2t2UEFsT29NeFV0eTFm?=
 =?utf-8?B?M29tR1dTV29oSkY0eVd5eDFoQW1FUDI2dHNkM3FQVE5DRGw2Z3FqdmxXT01i?=
 =?utf-8?B?MnNJbHp1dXU2aDN4RENTaENXaUx5VkZHSjdPSlhQNXV3L0FrRy8veUtVb1FO?=
 =?utf-8?B?TktWODJHVGgzUklNbWhBK3liNXNLOVZGMTl6Z0N4a1c5cktWU1NKNDVVdUdq?=
 =?utf-8?B?eWhkVlBvc2pCVkpSbG5ROXE4R2NhdzZEd1pEQ2tHek4wOFBlRlpBMUlmeSto?=
 =?utf-8?B?MjVnM1lYOHdZOGx1Z282RVA3bUU3SnArVDRvWm1iZzBORnpoem55RXEzLzZx?=
 =?utf-8?B?TjNMalN6OWpNMmdjODVUMVd5UGZ5emJ6RXU5aDlyclhCc0pGbFZNL0VRWE42?=
 =?utf-8?B?UGg1MkxXS1VhQVB2OFhDd3dnNlpmVXVIRGxNc2NIeExuQXlOc2NSNm1QUHF5?=
 =?utf-8?B?OWJkR0VUaXNyRWdrb2NZUVpta1FuUGtCR2JWTGVOOEJrRFo4Z3FZaWhyNXFz?=
 =?utf-8?B?R0xZVEJsQkliTXhZV3pSQkdRclpiTEcwL3hLRTFUdFNrRzhXOXltTmtRU1Mz?=
 =?utf-8?B?RGUwY3FWd1VjSkdEVllvRnM0RUMzL3cxeGszWGRZMVNjZTYvblJuRUZTTXp3?=
 =?utf-8?B?aExPZFV1YnBqYk5LSVJsMEx5VmhsSngwSUdJeVV5SmlvQWVheWZkcjlkK1JT?=
 =?utf-8?Q?aV2o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clBMU1RaT2dRWmcrRDBEZXBGdHliby9WYjNIU1VXTEU2S3Q3V25uYWpzV1Jy?=
 =?utf-8?B?YnRQcFVXSndrSjFYM0VJRFlySHhTQ2M5YktFZk50QytjZ3Y1S3kvTzVNaENG?=
 =?utf-8?B?YWZLU0xhdVJkeDhVL0Y3NHJKb1p5ZXFlMEZOSUlnbkZmMG1SVTVqUmlqRXRz?=
 =?utf-8?B?R1N5Mnh2SURjNjZXeFFITVpod3dVTVFCSElnYzdpN1FFSnl6cS9nSGFvcldu?=
 =?utf-8?B?bFNKcGJSbU8rbzRSQ2tQUitTU1NKUkpwOUFUN0prMzdpQVR6bFBQUllaOXdy?=
 =?utf-8?B?a0lzNU9RaEVxc1J3ckdRVHVaa3gweGdROXgydFAwNENQeUduWHM1VGhvNWNM?=
 =?utf-8?B?OTJNamt1VGhwaUZYK2c5dzJkaWtEaUhhOTFJL2dpVWZEKzBiOEdCdUllUGc2?=
 =?utf-8?B?UFE0MlU2cGFjdWlleU9EK1lmd055TktkYzVocHp3ZVN4UHgzMFRQVGY1RGp1?=
 =?utf-8?B?STdyYWkxWUNlUGdOMTREblBpMGMyYktLZ09YSGc4aE1UbGdCcUdNa1BWc3dp?=
 =?utf-8?B?MHhiRDJTb0JKWnI3RWp5bCtxQmxSbXpwdThIRUQvWUh5K2REeTBURmkyOUVG?=
 =?utf-8?B?TS9SS2w0WEtCaHo5emVUa3lqYjBWWGwxam00UjJCR1BJWDhMc3VrQTA5cTFk?=
 =?utf-8?B?Y2VLYy9IQml1TktFWGxQZnBZY2IxV0NuVzc2bURwZTJtYUpGOG9LYlM1bnhP?=
 =?utf-8?B?cWVMSitCTW0zS3ptNWVsekRGTzNmeVQ4RWhhMUlzeWFFMndSNEpseUZ5K1hP?=
 =?utf-8?B?WlVjeEllMzJza0ZmK3hHU3ZaYmlZUXhlTkNRcCtuaWtsU3krTEY2Q1E2alpM?=
 =?utf-8?B?MWVaNW5zN0pyT0hETVhPR09HdzNEdklWUVEvVzdOMjEzclZaNS8yb3RsMHRn?=
 =?utf-8?B?WE9Yd0VkMkZxU2R2Tk5DdVEvejZCQncrYjZabmNFUTVrRUJOREpicERrQSti?=
 =?utf-8?B?MmVLZ0VSSjFEMDFGWFRwVXM4UGM5VFZEbzJ2cDRhSWJVZzVCdDZNbEVjeGl3?=
 =?utf-8?B?TUV6K2FaY1BZOXgzMEhrNjA5a0dUVFd5MzdRZjZaQ2JrU1FXdUVvOWhKc3U1?=
 =?utf-8?B?bjRnb05NbmJZdEVlZ0s0NWhPWk1TbUpmaHY0djVCcllQZTJOSzEzdGpPTno5?=
 =?utf-8?B?eU4vYzF6N3VHUXRJRGdYYXQyRUpUYkRmcExjbWFqWnZuQkVibWIzOEh0RktV?=
 =?utf-8?B?QzhvMjc1ZyszNkdxS2pOT05KbU1uVWxuRVM3dm9lVm0vWXdCN29hMTJvdk1i?=
 =?utf-8?B?aHNQdDZCNCtaRUxwNzZISk1DTlhlSFRrdXN0bGpVc0hRd0FrMk8xNlRDL0l1?=
 =?utf-8?B?UjdrWkZ2QVg0WE9IQlRubEsxYUNiOFJFM1ViSHEwRFpGNDN2S2pTVWM1NzBG?=
 =?utf-8?B?bDNES3BRbE00RHBjWHNrWUlCSVBmamdxN1YxT0h2ZGJLbEszTHEwMk5rOWRQ?=
 =?utf-8?B?d3U4WlBKZit4TkVDMDgrcG95Zld3Mmh0TnZWVjBwSDFmUGh2NEVua1d6N1l0?=
 =?utf-8?B?bmpMU2MvaDFSSUJIckdFeE5iVTJJSE5TV25nSHVUUFF1TjVvbDdTdzc0MzdB?=
 =?utf-8?B?eDZ0WUJVaXFDdHVZZzU2L2twd2MrclFKNitaZ3hzUDNjSGxya1dsMkVzVkh3?=
 =?utf-8?B?bjFpNlRidHNZSkRCQTlnNHFDK0kyRVRxa242YU1iR0JTaDRLTE5tY3VTbTE2?=
 =?utf-8?B?VmlkdTA3ZVJwZ2thRlBBeDhzS2pjMklmTi9iODZ5Q1VDLzlkM0xxZWhaQTZj?=
 =?utf-8?B?WFVrMFlXc1dpNy83WW1wZUw1elRiQWw4bm8wRDFEdDBxZGorRXd6cWlIdjhI?=
 =?utf-8?B?L1h1a1F6SDNkTnJHQ2tYNmtHSUFYRDVNaWVTck93czlCd3lzYmpObDR3SUJt?=
 =?utf-8?B?a3JpSmgxNVB5bkxoVFNmQVRvSUQ1eE92UytiTTR5dU9OMTFwVitmYnkrK3k3?=
 =?utf-8?B?dUdHUjRpRjhQMXhuRXY5eGYzMzZNUk5aUU9IdWVrQkNKMDFyNHdyYlhGYjJi?=
 =?utf-8?B?QkFLMjluN3M4UUsxbUJpUG90VS8xWE52bVJreE8vMUdDd1BxbHRMUzJTOEZY?=
 =?utf-8?B?YTUxdjIrOVVXamN3Qjd4TjE3bWhhVVJ4a2pzMkRMZDVMTVFGYkFrUWN3a3Ez?=
 =?utf-8?B?UElad2IvZXJqSExORDJRUVlrMEFISmsvUUtsLzdBeVR2MmFNTEtnL3lTeERP?=
 =?utf-8?B?QVRlSkNuQlpQNTA2M1hHYmRrbFJoTlBCMnI3N3pQNDJRUktPYUoxcmExUURI?=
 =?utf-8?B?M204QjhCWktjYnROalNXaU5ETFhpV3lQcndJTk9IVGJpbm9rRHB2Vmh6NE1M?=
 =?utf-8?B?Z3dCdU5JTEFtbURqUmx4MlpXNFdwenVtTjl1YmdJSlZJZzE1VXFmc0IyL2h2?=
 =?utf-8?Q?wB78fFD+ci6SPAXw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d465c07e-39f8-43d5-6595-08de6a8b6b81
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 23:06:57.4167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GupWfbcGKGnwvQ/iu8mu//EBfVsXUrkG/nbGj9gSUFKnp3vinFFrZMiEMKfV+M7qyugTUDb8PCMN04VeeXM3OVwcbt26Nbfgl53Bc+dZ3as=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6985
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,nxp.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258523-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C25F9131A38
X-Rspamd-Action: no action



On 2/11/2026 1:03 PM, Linus Walleij wrote:
> On Wed, Feb 11, 2026 at 4:43 PM Andrew Lunn <andrew@lunn.ch> wrote:
>> On Wed, Feb 11, 2026 at 01:58:21PM +0100, Linus Walleij wrote:
>>> In ixp4xx_get_ts_info() ixp46x_ptp_find() is called
>>> unconditionally despite this feature only existing on
>>> ixp46x, leading to the following splat from tcpdump:
>>>
>>> root@OpenWrt:~# tcpdump -vv -X -i eth0
>>> (...)
>>> Unable to handle kernel NULL pointer dereference at virtual address
>>>    00000238 when read
>>> (...)
>>> Call trace:
>>>   ptp_clock_index from ixp46x_ptp_find+0x1c/0x38
>>>   ixp46x_ptp_find from ixp4xx_get_ts_info+0x4c/0x64
>>>   ixp4xx_get_ts_info from __ethtool_get_ts_info+0x90/0x108
>>>   __ethtool_get_ts_info from __dev_ethtool+0xa00/0x2648
>>>   __dev_ethtool from dev_ethtool+0x160/0x234
>>>   dev_ethtool from dev_ioctl+0x2cc/0x460
>>>   dev_ioctl from sock_ioctl+0x1ec/0x524
>>>   sock_ioctl from sys_ioctl+0x51c/0xa94
>>>   sys_ioctl from ret_fast_syscall+0x0/0x44
>>>   (...)
>>> Segmentation fault
>>>
>>> Check for ixp46x in ixp46x_ptp_find() before trying to set up
>>> PTP to avoid this.
>>
>>>        ret = ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
>>>        if (ret)
>>> -             return ret;
>>> +             return -EOPNOTSUPP;
>>
>> Changing the error code is unusual. Maybe add to the commit message
>> why this is needed, or somebody might ask :-)
> 
> Tricky one, but if you look close changing the error code is what I
> try not to do! :D
> 
> Before this patch ixp4xx_hwtstamp_set() returned -EOPNOTSUPP:
> 
> -       if (!cpu_is_ixp46x())
> -               return -EOPNOTSUPP;
> 
> After moving the check into ixp46x_ptp_find() as requested in the
> review of v1 I have to return some error code from that new check,
> but it is now called from more places, so it returns
> 
> int ixp46x_ptp_find(struct ixp46x_ts_regs *__iomem *regs, int *phc_index)
>   {
> +       if (!cpu_is_ixp46x())
> +               return -ENODEV;
> 
> So this:
> 
>       ret = ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
>          if (ret)
> -               return ret;
> +               return -EOPNOTSUPP;
> 
> Is put into ixp4xx_hwtstamp_set() so it will return the same error
> code as before if PTP was not found.
> 
> (I can copyedit this reasoning into the commit message if you want.)
> 
> Yours,
> Linus Walleij
> 

That would be helpful to have in the commit message, since it is not 
immediately obvious.


