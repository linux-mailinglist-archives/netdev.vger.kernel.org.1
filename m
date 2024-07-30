Return-Path: <netdev+bounces-114108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 453F1940FF6
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA18AB2A401
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95B81A072C;
	Tue, 30 Jul 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SckCShWD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645719E82B
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335485; cv=fail; b=ZBQZNfAi6eshIjZmlSruvTLCidjgvDkdovg22zSzwEizEmMHnKpPaaep0GaWBDVC3f8bWCoo1DiGC5BuOtP0Xppf2DDPqtaokK+pJyeSGxMGP5wVjdbEXT/LgGtEa35YdLGP6ql6jaVdnf56aLueu+/BePban2ST/Bzj8AarvAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335485; c=relaxed/simple;
	bh=4fzRMREWZ5xQUvbe//9S0qFoXp3sYjBq037Jru4km9M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kUYvQ8aeCfvth0HOiOugxEAspY6e07UbwRcBWCQCSWFppJDmi3HWJN6PmgyUzMsM6WySZW7MDzkfpm2RKt1a4kgseYxeJrAAXSihp7+zBRkPvafbc+nrZq6RXVtd1LdchR7VjzvR90dUZweLPB2GdikZSopLq4ZvsYOuW/Y3ntg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SckCShWD; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722335484; x=1753871484;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4fzRMREWZ5xQUvbe//9S0qFoXp3sYjBq037Jru4km9M=;
  b=SckCShWDgmA0MV/NG7neX/7MsQY7+UQromVzniQBXsldXEdaTMMLzhjG
   Bsib2gfWtI8fC3S6zgeHVYQ2wW1+EwceOTDMzw3HBazF64HepB0DUY1Xb
   wcBd1Y8mAOxed78J2Z1/oDZGds3Bvl5peofPMjfIXYtMbQ7El75+iaEId
   5GmBuK+208YeUcSjAk2e3twQ3QRv0sdJwpC8l48LnzeKxoeGOOpG4mTgI
   xTtOR75bBAhRgQ6dWqDaU7bdkz4w1fEXChUEfOgBkKs8HRQNL987duLV3
   OcMqAfJk2zpk5IYrYr4OYU4LKGA/Su0d9e+9O3fEv0oytmqy5HiqRWy9w
   w==;
X-CSE-ConnectionGUID: YbPDO+/vTNa9Y222FiMVCA==
X-CSE-MsgGUID: Xm4qlgoVS8a6ymJv9JlxLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19983706"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="19983706"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 03:31:23 -0700
X-CSE-ConnectionGUID: CyRrTNW4TaeKI+5jeMR9uA==
X-CSE-MsgGUID: 9Uc83gcLTmGxB0ae+mDBgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="59085272"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 03:31:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 03:31:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 03:31:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 03:31:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2hBa6uXtLu2L32D5WxUCO+9XHlwIsLpx3uWktJagSh0F1j7/0geTMC1ESQR/2/h10J3qsaCysHHL8jZBIL3jS0HF3DLNygOZ+xS63HazHjsPl9O53wPGa0pTxjIwGHS4yCFiCcidiq2oLA14S+aN9qKa5nyusfBnTG1hb1kVUhsbaEnY3ZW4fAeTChJeXQjeiXNd7ZAME/FnVzBL/77ILFy79utxR5GzHq6R7WPg2w2WpJADrtdTzTABeFJJUekU1NqYxKV2OkB2uiYMPUFL4fJMEGwSK3LipJvNt1yHPiRY/4m5NVeWGEPkkzpYHJHZNspz7cYZ+Jg8/tAWV+XDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9Ov6KZnBtesyz0/LzqJXk+JJXrxNlo5XlSs1sVRC+I=;
 b=cKzvxJqnEfroiDTrK+nwVANawEu6OsHhn96zAAMYYGAWP9Xy5UeuT/q0nb1oJj+3P8uNkzCXhwJE5bUozUG4q9H4HfABCB6/gvzsjA+QSoUyYFSPZnRTyhvFemjhRQBa+Wxwqm7HSc3Hc87z4geI4/U0TYxDnv7CIqspzsJb8WkYUMbFJQMS+Vyry/58BgflxcFTXJgkO1kLLoOfy6QTvhfvj1fHYsXUQrblQ+s+AJ/+HKXTum82HKsFUCmUHkqiNQZKT4qy+9GVuO9qLrjatYoLCaj+muKWkD/tX8GkSMWiTbnxObR4WMlykgUyLYx2b70L9jeDzM2ct9Gy/Qp4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Tue, 30 Jul
 2024 10:31:19 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:31:19 +0000
Message-ID: <7b27e95e-85a7-43da-a06c-4ab56eccf5b6@intel.com>
Date: Tue, 30 Jul 2024 12:31:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/3] bnxt_en: stop packet flow during
 bnxt_queue_stop/start
To: David Wei <dw@davidwei.uk>, <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael
 Chan" <michael.chan@broadcom.com>
References: <20240729205459.2583533-1-dw@davidwei.uk>
 <20240729205459.2583533-3-dw@davidwei.uk>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240729205459.2583533-3-dw@davidwei.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|BL3PR11MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b12526-76b7-488b-97ff-08dcb082bfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTc4OWVhcExWT1R5VFVNLzV4eisyTzdHYS9tYXhpYWFXOGFSOUEyUC9uaGkv?=
 =?utf-8?B?SWtrU0FGenprbGFRaGt4YzUwdElKdUdQb1hHV2ZPZCtEemQvRnNMaXZLTytK?=
 =?utf-8?B?M1JiYnZTS25XNzFZRzRyalBNOCtZcytXcE9PMUdyeUE0OVNZTEJiWnFOVmxW?=
 =?utf-8?B?Ynh4bFp1TDVUR1g5NFo2Yi9hOGRlbG50aFJkUDY2dXdtS21KQWJoalYrd3Rp?=
 =?utf-8?B?blg5Uk5IVzNka3BVU0pwY1R0UHowWFNudHRmSDJvQlVuTkJML1RuL1VNNTdH?=
 =?utf-8?B?TU5XWjRyZ0RjU2UvOVNHZjNKVnVMMVpuRXRGbXRBekZiTTBrZjVkTTJPWTB0?=
 =?utf-8?B?Uk8rT3RuaEtFU3RndmVNWWE4US9reDFXMXVNbXI3emF1NVhFeHJIUzBTWVpB?=
 =?utf-8?B?QnVzWUJzWUFEMjEwcGxOQmdBbUYyT0ZiZGJiaDNVSm1aMzI4STJESW5Sem1R?=
 =?utf-8?B?YUR2WkxYclVsT1FTb05yTU1WMDNYNm52emVRM3AxZFp6OWZ2ZU1BWDRnT0h4?=
 =?utf-8?B?UHFxbHRLWnJkODF6enRwVTBkNUR5OVBIS3YyekNyaUpkZUZMaDdETnpzQ1lh?=
 =?utf-8?B?K3hqY25aQUVwWldFSHRXS2ZyN1M5cExYLy9qNk80T0lNRUVGNXNnMmI5bUQ0?=
 =?utf-8?B?MXNtS2lKSGovRVdNc1doSXhxWitYT2lYZlRmcWVWYXFkM2trelhFTE1ndmJl?=
 =?utf-8?B?ZUw0THZPcCtUU3FWdVB1SlVSdUp5ckVYUzR6THZuS2VzREFYSGNucW5XOUs0?=
 =?utf-8?B?WkV2YjBoZVpTSjB5R2Y4OC9wYmxqcncxQTFMYWdmc2tmNFZRN0h1dlVVMGV6?=
 =?utf-8?B?NXgvUWluVHM3dU1UcnU4L1FqU0cvVFVWSTV6RUR1NlJKTHMvYjBmbFFHSHFv?=
 =?utf-8?B?eDh2UHowOHVJeVl0Zmh5MVBIQTVRYTArQk1LdEZIRzRPcmdHMHhGOFpFT3dh?=
 =?utf-8?B?TmJNVHJVV2F5MXZOei82MXJzd0xlTko3ei9vR3NCeDRqL0lkSFRMR09KM2Js?=
 =?utf-8?B?Q3lhOUs3UjNuN0VVenE3ekRTVmV2RjlBLzJvbEtFWU1zVksyVjd5WnZlc3kx?=
 =?utf-8?B?N2crN04xOVU3RGtpSXBJek84dEdLRGIvUFg1SG0veVhxWU1tMjN6WWNLWC9K?=
 =?utf-8?B?d2dmS2RVQ1dZYnE1c3psT0U4ckY1dFJBQStoL3dEelJkeUFqRDJ5SmpEU3o2?=
 =?utf-8?B?aXZJZy82a2NnYzhXZkt3YlJOZFA5bFY5bldjMDB1SExHcFYvc3NnUWFOckdZ?=
 =?utf-8?B?dGw1WjZ5RG90QURHU1B5emtNSVZyQXhtVHlpK3VhYVdlbTFKb2wyblJJTWV5?=
 =?utf-8?B?YVZLbmpKcWVMMXl0OXRXd1o2WFhncDlXVmt1NHpQQUpoUGVmbkFpSnI3a2Yz?=
 =?utf-8?B?TzFoVjNVNE5SVDE3WTJsOTB5MlFKVEpkVm5mTlhMTTRQaTdWYkFpd0RNMlAx?=
 =?utf-8?B?RUg4UmNZdnh4ZHpaaS9GQ01rZUxveEIxOWZrc3VBNk52bFpwOFlacTJpdEFo?=
 =?utf-8?B?eHFFWmt3d0d2bExqdkJqRU01UEF0eU9FaldrNVRKbW16SVZTRjBQU0hZVmd4?=
 =?utf-8?B?eE5WWExiSHg0QUlMWWgwNHRiajRZcmhCYXRuRU9oSFppWlVJMjFqK3ZIa2gx?=
 =?utf-8?B?SjJuSjRtYXFjSk1UWE1MT2JlWFRsRmxiKzM4Ni80cHpENHBSNVhZY3Q3QThY?=
 =?utf-8?B?MkF3TmphY210cFh5Q3pRSE1mWlZGODlhakl3azNFV09ic0R3ckJkRXBHZkg3?=
 =?utf-8?B?elpYSk13KzNlK0ZaTTFrNlR6ay9hNmUyRDJnMXVKTml2TzJ0TjlGVzhHZWtP?=
 =?utf-8?B?OHd5RFY1SkFDdE9ranh4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1lobHgzRjBYZmZQOGoySlhmeXZpVmFPcGhzYmx2cS9NZFVqVTFzUXRUYllL?=
 =?utf-8?B?VkttTE50Yi9LbXViNFBWQnZQNlhHZ1BGcHprbVUyMXFnNi81L3RsbTg5R0s0?=
 =?utf-8?B?SGRaUEViVDc0SFg3bzdzdFFWL0VTSEUxeDN6RUltdlFmM1lGOUFRdFJZQTM0?=
 =?utf-8?B?UHoyLzRRYlgzNEpzV3pqWGY1alk5NUhoU0o4STUvL0dSRnlnbUREandRVng4?=
 =?utf-8?B?QWZnUmdKYzRHUVREWHM4N0hkMytVL0c3YzNTUi9MZmJtU3IzOHNoNUg2bEhS?=
 =?utf-8?B?UExyQk50R0JUSU1aK3Q5RUF0VHk4NlFZREFrQjcxVjZoU1NqZklhYWJlb3Fn?=
 =?utf-8?B?SkdmZnd0L05wcHBwT3B2NUtRNVJya0g2YVVTZkFUSkZiRmxLWFVsOXFlVU9N?=
 =?utf-8?B?MTh0ZnJQOGJZbUxxR3g5ZXBjSTFoN3RPc1BjQ0VGMHpaYzY5QlQ0aTFRRDdD?=
 =?utf-8?B?bVJERXRTMGpTWU9QbWpIZ1ZuNE0zcUNnOTJsbmsxczFuTUhvcmlZczVjUWZY?=
 =?utf-8?B?c2txZmFBMUlxRTVIbXlhVDIrT2JmVzlmU2JML3U0ME9hZkVJRm5idzBtQWVo?=
 =?utf-8?B?MWFrRVgzQ0RxRjc0TmRhWEJ6NU9qbTRsdlVwSFRqTEFwWEVFbjFoWGEwaVk2?=
 =?utf-8?B?NndVYzdVNm1EZExQMWwwaXl5SVJ2ZWs0NW5iblZkZXRaRlBqY2k5QUZnTTUy?=
 =?utf-8?B?WmR3OU45SENLclNLOGZkYlJnS1pMcE05K2d4K1I4eUVzRFdGN2VBRmNXOXpo?=
 =?utf-8?B?cVRFenJndjlBeTMzTE56cUliRTdMaTg3Y1pKZ2JDQlBUMEJLM0srQ1psQy9K?=
 =?utf-8?B?QjJMUkM5SVVIOFN5R2Rtd0h5QUxSQUR4MGp5ajZOR2hIZit2OUpOeElTdEZJ?=
 =?utf-8?B?YVRUWng0bjJoVmJNT1NMaHJybWR6bVloaDZZMllTMUdOZjUvakNEellYamIx?=
 =?utf-8?B?dG5tdjh0OHZTcGhtSEl5dVNaWmx0a2k2UWtmVGEyNkczSEdqaTZkWFNaODVK?=
 =?utf-8?B?Ykt6Tmp5L0JvTG9McWcrMFJJNVN2R1ZGTmY0bGxEUmpvaHVJUVYvWXN1NjZM?=
 =?utf-8?B?NE4rV0F4Zkl3aHJqMEJSQVpzcmd4UGlobUtsVWVIMEx0VGlvYVFhT1FrNGlj?=
 =?utf-8?B?bVRKTEtXQ0gyTGVzdmNXWGZ3T202cGNHSktSMW9LZEZQVmU3aGkvYjdwK0FX?=
 =?utf-8?B?L0FvRUx1K2VBOGhnRVZLSTBXeGM2cXRFTW1aZHRMNVg2MXNYdXN5SU5mNnRi?=
 =?utf-8?B?Tm1DdzVyOFJDS3JYTXhZc094dTJkN1VDaVd3ZTVFRGNlUjl6MUt0ZzY4Wnh4?=
 =?utf-8?B?YU8wZE1iSXlpWnZQRmxyUFRhY3BOVzZvQ3BpTC9qeWVVZ1l4b1RVQ2hBdzZV?=
 =?utf-8?B?QWJtZlBUZ2s2QVUzdlk1Z0VqQ0o5MURGRDNFRzkxcTNPVVppemtQUGxlVmlo?=
 =?utf-8?B?TUh6eExLZnNtZ1FwRm9FRWlLeGYwMGU3bWtOdjBGeDFIOVVIb0R0a2NvazBx?=
 =?utf-8?B?OEVESUkyZHBvTTV4OGE5WW9TTXZVeUtRUUFMQ0xNWW9SNU1od1FQd3ltaitT?=
 =?utf-8?B?LzkvYUtza0hxWVYzVWJMWmNDdXJXUXN3MWhLUnFBanlyNUt5VG91U2UvQzhK?=
 =?utf-8?B?UlFQUkdZQjVKeDROUjArWW1VWEdJNWpYRXZLQlNma242L0NpZllSWFJmZ3Uv?=
 =?utf-8?B?bjhZQlQ1WFZlbHhnSU5pMXF6bHFaMEpkMWVDNENMZ3B1UXd4OEpmZ2ErdklQ?=
 =?utf-8?B?U1BuTDUwck5vOGR0TFZvM1RoRUlhOWpVVFNSemlzZnY0MTNxOGR0Q25xL3VM?=
 =?utf-8?B?OUZ2T0pzYVY2VlZXUXhtQTFscVMrQllsRnRFYlh1Z3ppN3BadFVWQnlrWW50?=
 =?utf-8?B?NVk2TFhCN0R6ZHdyUW5zeHBObzgxalVWUGxGeXRmMW1QejhDL2pUampwcTNS?=
 =?utf-8?B?YitxTFhPd1pSbzVuTEY2aVE3WEEzcTNFMEcvWWpKMHp1byt1VWEvcDhkS0p6?=
 =?utf-8?B?Nk1CSTZwN0NCZmRLdzNZWkphSlhsclBqeTB0elFRM2tlL1cybXRrOWVJTGlk?=
 =?utf-8?B?dkRNOStaZ3FyRnVMaDZkUGhBb2VwZGd1Wm9xYW9SYUg0cjd5eXZmNGJ2OFQy?=
 =?utf-8?B?cXQwbDJuRmxaUW1sMVlmWUZONm9VYkMyK2RCaTZtUkhxbVAxcjMzNUJmdlQy?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b12526-76b7-488b-97ff-08dcb082bfe9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:31:19.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAIhiHc9r8MgRPvJEC42EKMWOQKV4sw5m4HxYInAqQJLvJJX6RJrML1W6/wqbChXYARrOJ7iZRxwAY/h9iVfWBaf8Ed+49XmaWajdMW4KfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6436
X-OriginatorOrg: intel.com



On 29.07.2024 22:54, David Wei wrote:
> Calling napi_stop/start during bnxt_queue_stop/start isn't enough. The
> current implementation when resetting a queue while packets are flowing
> puts the queue into an inconsistent state.
> 
> There needs to be some synchronisation with the FW. Add calls to
> bnxt_hwrm_vnic_update() to set the MRU for both the default and ntuple
> vnic during queue start/stop. When the MRU is set to 0, flow is stopped.
> Each Rx queue belongs to either the default or the ntuple vnic.
> 
> Co-Developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 8822d7a17fbf..ce60c9322fe6 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15172,7 +15172,8 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  	struct bnxt *bp = netdev_priv(dev);
>  	struct bnxt_rx_ring_info *rxr, *clone;
>  	struct bnxt_cp_ring_info *cpr;
> -	int rc;
> +	struct bnxt_vnic_info *vnic;
> +	int i, rc;
>  
>  	rxr = &bp->rx_ring[idx];
>  	clone = qmem;
> @@ -15197,11 +15198,16 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  	if (bp->flags & BNXT_FLAG_AGG_RINGS)
>  		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
>  
> -	napi_enable(&rxr->bnapi->napi);

I get it that napi_{enable|enable} isn't enough but why removing it?
Without it, RX will not work, the poll method won't be called or am I missing something?

> -
>  	cpr = &rxr->bnapi->cp_ring;
>  	cpr->sw_stats->rx.rx_resets++;
>  
> +	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
> +		vnic = &bp->vnic_info[i];
> +		vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
> +		bnxt_hwrm_vnic_update(bp, vnic,
> +				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
> +	}
> +
>  	return 0;
>  
>  err_free_hwrm_rx_ring:
> @@ -15213,9 +15219,17 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  {
>  	struct bnxt *bp = netdev_priv(dev);
>  	struct bnxt_rx_ring_info *rxr;
> +	struct bnxt_vnic_info *vnic;
> +	int i;
> +
> +	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
> +		vnic = &bp->vnic_info[i];
> +		vnic->mru = 0;
> +		bnxt_hwrm_vnic_update(bp, vnic,
> +				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
> +	}
>  
>  	rxr = &bp->rx_ring[idx];
> -	napi_disable(&rxr->bnapi->napi);
>  	bnxt_hwrm_rx_ring_free(bp, rxr, false);
>  	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>  	rxr->rx_next_cons = 0;

