Return-Path: <netdev+bounces-300881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lVCfGrrlN2pgVQcAu9opvQ
	(envelope-from <netdev+bounces-300881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 15:23:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCBB6AAE00
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 15:23:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=GXEKbyl2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300881-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300881-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40628300574F
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440593D994;
	Sun, 21 Jun 2026 13:23:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C14C6D
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 13:23:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048183; cv=fail; b=c7wVMFMfGl9c8kmeqrznakLB7XmqMs1ABVZsAhvA8D9gdCU6JAOwHZDkr8XPxXhsc1yWKrTnkuthrnGcedjX7Ars/HBYZUSwVkt6YCcCjpwqdGBhlvLsnnsm0E5niwW2jBK1dIjKAPGDKRq23EVkWbTQRW7zOk0hH4Be1lUH4dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048183; c=relaxed/simple;
	bh=vPatZRrD0dqBJzy1SWGWBRMNuEMPUVRQHLxTPVBgZiU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Em48qQGTG9xc/Z4JJsuu7qecAPKpmLZFnJHA5zW3O9wsukHIPm8r845gEWaEef0OrZ91ihKLaVa6vh5pMB7WrJiT/AA6Cl5F+O0+gsl8h0yPLLSc3Ota1gY+bqYReU7tcOHT93DUlfFVkUPnQ/iAYtBIk0BrXb1f6Yj05XQHYGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXEKbyl2; arc=fail smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782048180; x=1813584180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vPatZRrD0dqBJzy1SWGWBRMNuEMPUVRQHLxTPVBgZiU=;
  b=GXEKbyl2w1jOtnTvXb/LTWuSQTgj4feDVC5Z2LcjR1nDAkrwH9BR+G0x
   aGp3wPl/HKvo+7DVpidMPg50FjEbk6KPmugNhIo5oOFPH/3RVYUkZQeV9
   yKScsRScv1OjuW+SAtWxZityA7QiM6oxUKFf12/AG3gdVchAm8UKquagM
   afNceabEOemISdwU/KFDRdqnwKNTN1/1elSPAOPfnNkxpc7q64yh6fS2H
   Xg/mRuLHi2O2VfRZwhDvIR9vVb4pBgQDojsOuZ2CfrPP4Gnr/9FTa1x52
   m+uEx1VdAW/UXokhK7YDDX9hL9i2fUeBcrJnbtVWlWEGN3hrequeyGFj1
   A==;
X-CSE-ConnectionGUID: ut8qD2/+T/OsHftE0xHZug==
X-CSE-MsgGUID: P1ijlA7mR+aqMomcQE29fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="94300997"
X-IronPort-AV: E=Sophos;i="6.24,217,1774335600"; 
   d="scan'208";a="94300997"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 06:23:00 -0700
X-CSE-ConnectionGUID: tcgN6j5eT8CnkTmJZnsX3g==
X-CSE-MsgGUID: LLxj0Vo+Tf6kSyEfXdWepA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,217,1774335600"; 
   d="scan'208";a="246676638"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 06:23:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 21 Jun 2026 06:22:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 21 Jun 2026 06:22:59 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 21 Jun 2026 06:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8nNCgE6oUPN74KQ8mGZezirveKcG0LlP071udrvVpo0HuAqwDeLkkXd301Bcngg3qGJIWEY+JlvAjvaZsfMD15wigFBCghK0X4d9ePvCeCrjGBspwKHY9NcEb67iG0JU4Rz/QSoNv/Z8D40Mmn5dqfRjmm82YbuuvUkWoqTHI96miJQfsxfechwbGTNP4E2h/23VHCfEqMj0+kaOakNIkdwlq7OJDPaTmHlMeEJwJnwdF34nlEQYY4NpbDADBpbSkerBb/ovLPlHyAAOfekbtS10ePYnoHT1CKV3+YIRtVe63q+8YvEYkHuQIW8iL12TxmUD+mgs7cY6nr8owPn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMlib/P1GJt52WwbiEIXOSNQN9+Ub88R7r2hFbv/6xo=;
 b=wbADiyEQsH2OQ1uXp/7jDJB9PuX2yNyPdeIIyPqJsE2CFCFJevRE9Y75+MlmaoyoGD+va0V/fyWHxmkOvp5kU41I8K2FLHJSaM0JkxYRBNyowC97hFekfqDiFeTUMTXsA8v6smH6qH5c70oS2S2DirirDmSuHpxoCZFNJrWC/mEVGBQjR1AeU2ZEEY/ZTK0HKbARaJEfrRf1YPewuLNYq91VtCUf8TGSa4LzNAreWIQ3m3ekG1liuqgRYfOXinXA3OFx2YcmIXXsH4OJSqukI5K61qAptxvxQO3V7TDlQjcxHFSd58G+CGVlejYysWUHjZQEDO2UsVrsEU1NiQue4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB9498.namprd11.prod.outlook.com (2603:10b6:8:261::10)
 by DS3PR11MB9645.namprd11.prod.outlook.com (2603:10b6:8:38c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 21 Jun
 2026 13:22:57 +0000
Received: from DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925]) by DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925%5]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 13:22:57 +0000
Message-ID: <dce2391f-8e8d-4eeb-97e1-c7070f340d64@intel.com>
Date: Sun, 21 Jun 2026 16:22:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] e1000e: Report link down after "Detected
 Hardware Unit Hang" ?
To: Andrew Lunn <andrew@lunn.ch>, Helge Deller <deller@gmx.de>, Helge Deller
	<deller@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
References: <ai8hmGQmXQu64Ld3@carbonx1>
 <e78576e0-9b55-446f-9d10-da3b7aec9b31@lunn.ch>
 <9d80ed59-5483-4c33-9d27-52fdf24aac6e@gmx.de>
 <51828156-e859-44db-9926-c076796d0f75@intel.com>
 <d86c0dd8-8bd8-495a-b750-2a0036fbbee4@lunn.ch>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <d86c0dd8-8bd8-495a-b750-2a0036fbbee4@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To DS7PR11MB9498.namprd11.prod.outlook.com
 (2603:10b6:8:261::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB9498:EE_|DS3PR11MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: feb7f78f-1b6a-4043-7c86-08decf9835ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8EOuU5CNJas940KGtYX/ZHlGQCGHdyng/wIH4fRCpN1wdgfORiKwl7bH4dju4Astj+8aqvEKYAH0qFcHL24gbIuK1WRBTm0edmLnX2lqJBDnnStj65KDI4mWLtHCM1ArarXTclInUy9t23IHQ98Deud3hlRm5HsIiG5HP7/vhhokTqjYfcsR+XbVfCQ9ljdZBwVCHZB9cXClDLR42SHHMMT6D91S2Ti77UTxFO8/lxOv0XPKLcjqV4iqetzbsLu1RS9aBrtLiqRJcWdhlF5Yg/IzpS61O9bZrvkmN+XHJP3tQ+nKpIZdsl6H9CxeWjLO4cw+toRPPpJXCZ6qRv9Q+7MnGCBgY+ufyKJPCNMQeyJ5pgvfnF+AhyBxbEiC/gru+orQj/JSbe/65AyZ3tBq2iSvLmSzPlJkx3PC7BTgpVb4/fGcqkvJcaRmqkAzKwTgMMmq5TRZZKvwBeoOVzXbHJXLB8QjIvZzyNnQB3pAn/0HzIcdSFx6MYJ8IbjRAWzCx7BXCSm5rBvfIFP+BE0HBxo+paaz/oFoDhK4o1uBy6tLMzburSvYPoZDSHPoslxmp5Dt1N5zZjfd9K/zdJcL5bGXhyj43KtNQlRNKibcz3otr5M/Ts6aWFfYnlce9OW5XnijW+koj6gwJtd+v0ctv+OVTuI62xTz7LOOtjoAKW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB9498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K095Qno2QTFVc3RURURFNnhDcE90TnBPc1R6dGE4K2JYNHozOFB1Qzhack04?=
 =?utf-8?B?ejFmT3V0UGtnMG9XdlJMMkRXQlJyMzFYMUhVWk5JaHE5YXRCZEJuQWxYSFVu?=
 =?utf-8?B?cFVIbkpxVGEzZFp6ZGsxb05FZVhQZmhGc0VtaEhMd3lYeVZ2NlFqVDl3SWVx?=
 =?utf-8?B?Y29ueG1pU01BTmQwQlhJS1Ftdy8rQzlScTNqNThWUUtvVUsyQXRSNDd5eCts?=
 =?utf-8?B?TE9FRWg4V1JmVDlUNmRWSGw1SEdsUmlmRVBzV1BXckYwazVFTzZsR24xYWxW?=
 =?utf-8?B?U0o0QmxzNksvZC9GRzhWMjBKTUw2TVZCQk5KWTFnODcyZHA2VWpjWW04MjF1?=
 =?utf-8?B?eEsxNndBYWNENzFHeGpvZXhBa3ZMbDBJbnBTTHM5dFJwUFNBcmdEdy9PSk1Z?=
 =?utf-8?B?RWpJWUplV2FJdzZOcTJCR1lHZjBUMGhSOC9FcFhzMUNEZ2F6MlRid0FFdi90?=
 =?utf-8?B?dUdab3R4WWFKcWVxZ0NyWis2TzFWYzN4UVEwaFVTK0oyUVoxUTNGNTloQUlw?=
 =?utf-8?B?UXRwRDZzTk1NalE5NmswRzRXaTJoQktyeHIvNWxrL1JGMTRyclhrVzBCWHFu?=
 =?utf-8?B?cU1paXRxNXNmM0lFUTJybHRpNWNtVzJRVHBpTVlvVlZLSGQ3NGlkcnEwZ08w?=
 =?utf-8?B?UFBTZzg5eDVhZXM3a2lNem45MHJOa2YxNlRUUnBSNkNUaHhKSjE3YXNuYmpq?=
 =?utf-8?B?azB2ZjFRc3MvYzY4SE01U2Zabm5jQ2JLS1ZrU2psMzdUQTF2K2dLQmRSSnYv?=
 =?utf-8?B?bENjRE9RaDVhcjZSdkJKZTVRa3prM25CSUZlMTJUU0ovUEZ6U2RIMU9rZHNI?=
 =?utf-8?B?Sm5TQVBqRE12QU5FNDgrN0RyQmc0ZGJaRUNLQUZ1TlN4dFA3MlZLdjVQNnNn?=
 =?utf-8?B?YWR0RjR2MkJXRnpvLzVtc1oxTXpSMy9pbFlSMFpkT1BiazVmK0Q4NHNpM1dU?=
 =?utf-8?B?eG0wSnlXTUFPQzlkOURQRlloNzA5U29qWjJjUytsa0hrVUNiWEpoTlF4YjIr?=
 =?utf-8?B?dVhiYnVuUC9XVmpTMnphOEs2enZwbHhDcy9KbGpGaHliOEFRNitpQk10eHlF?=
 =?utf-8?B?TUY5bzdUTVcyblRNU0toWk1hT0ROZ2QzT0Vjb3lGSjQySEl2VEpHb1M5TlU3?=
 =?utf-8?B?UjVSbWVhVURQb0x4Tm1iYmhDZ0M5UVo3b1VTOEZYOFo0NlZjR1hYVG53WW91?=
 =?utf-8?B?UjFhYWw3VmtTQzJDOUZhd1VndUtwUHlIM0IwNnFYam5zTkUvZFAxTkdTWmQv?=
 =?utf-8?B?S3ZCMHdEWjhQOHJacGovQWVHc2JtRk9RM2YzUUpmL1VQZDBQNGRRRmZiRlN1?=
 =?utf-8?B?K3dzdmpXN091WHFPYndLNHl1cUlLUjJzOGJoZWhpazJPT3hoVDI2c2RPWUZ6?=
 =?utf-8?B?T25XclhSWEx3YUFHTzVLOGh4WU1jbUlOd1UvMDQ5T2laYjVBK1d2RE1Kd3pm?=
 =?utf-8?B?NHEweDBFbkZHZW9QNDdTQnp5QXB3WCtLUy9YbW9peDgrZGliYU9aR0g3ZU1W?=
 =?utf-8?B?MXRlNndYZDJxVldtbXNQdXRuOW8yTzgxMDI3MEpPSmQ0SUpSUk5PSEZMbG9I?=
 =?utf-8?B?OENIeGJVZGZhYnJNTk1IbEloRlFYSkZkZXBNNkR0UllsNEVOOWt4RVRRby9K?=
 =?utf-8?B?bHYzeldxclVZV1ZZSEFPVXByK0c4Zm9JaTkzVndqM3c4YVBZdklMVTZsOTB4?=
 =?utf-8?B?ZzV1SlczSC9tUFlQODFRTjZlNWxPbXQwUjRVOExLVmc1U3gyWE83TkNxUmRU?=
 =?utf-8?B?aEhORnVlQ0dzakh6RWJtUmxxNzJKaGJVR2FhRW1VbE1RNytWRXdVaXRNMzR2?=
 =?utf-8?B?L3hOWUdZU0pjUXVDSHJBbzQ0TWtycVQvcWdOYTdXZXpzamhweEpzaWV5QXUx?=
 =?utf-8?B?R1EzcURwOTFpeXJLSXRtZHgxdFZjN1ZEckdnYmNaSWl6am1FOFhFU0U5RHor?=
 =?utf-8?B?elNUZUpGZkhpMys3VC9LN2VuWk9IblRLK1N0QjRxbm5DV2RhY2F3bXQ0djVD?=
 =?utf-8?B?SndRVzdwOEZLdG4rMTZPS2FDK2ZTQ1BjY2FDL1ZjRWNJaWRhd00rbzQxbnZL?=
 =?utf-8?B?cjlpUEFEK09IRW5NWUZhbHdUV0hNTUVrZEhQdEJ0K1FIcVdvQU9HKzJrcnlj?=
 =?utf-8?B?ZmF5L3Q1SDM1TnBWNk9hdUlnMWFBTTBjSXFHNzlVcFFNZjRNMitUOU9kUG1i?=
 =?utf-8?B?YW9teGtiOHg3bm92VUJxNXQxL3RrZUtRdGxUQ0NLb2RjcENUZFNlTzNBSW03?=
 =?utf-8?B?RW9PRkJyWEw0TXRkLzIwNXBOelVhYXhJdWIvY1BHWEFXcW9iVVNGTmU5bkhl?=
 =?utf-8?B?QTQvL045UzZVOTN3Ti9yWEVQQmlEMlUrT0xORGQ5Wno2OXdSS3V4QzFtZVBS?=
 =?utf-8?Q?e1WKN8NgD6P545ek=3D?=
X-Exchange-RoutingPolicyChecked: NK4EwFvS82kXxg67CDlU41cJq6vu6qjYB0fxEwyF5vDLiAF3sgtdbEcfsy/2Y/8WJAELy1aifi50fVlmRrQwpeRIQBKmCYGTYdYxSJBX4Zy1P+nmIWmAEXVSVp0Ugx+CTEkR2Nh5BQZKqqcJ0hWtwf6WdAKrgS/RLLhzxWF7Uzddz0cmATUWPQlsStucUQoE693NgB1dS/2eHpQ/ABhCfHq1zn7xrBJHefwk7jcTY3dGLsilEWxzoF1MAe6XjA9lAyL4o5dbNBIPjjOMshJDKePD4nPZTFRGMG5o/5jUNkuFVzd9zfC2o7eFK6gI/20H8cO/dNa/DwjTKVVZn42rPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: feb7f78f-1b6a-4043-7c86-08decf9835ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB9498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 13:22:57.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBYZNox03W9MvsFS47o1/CcUwzteqjWCwzqhvUehJ2Q70ib2UJsPwR303+cHs9yzFJ09yNMZ8WaqJU5tdJ8rIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9645
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300881-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dima.ruinskiy@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:deller@gmx.de,m:deller@kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima.ruinskiy@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BCBB6AAE00

On 17/06/2026 0:59, Andrew Lunn wrote:
>> This does not seem like the right direction to me.
>>
>> The "Detected Hardware Unit Hang" print does not indicate that the interface
>> is dead, but that the transmitter is stalled.
>>
>> This can be due to an unusually high load, or a HW fault / race condition
>> with another component, etc.
>>
>> When a hang is detected, the transmitter is stopped with netif_stop_queue()
>> and eventually ndo_tx_timeout triggers a full reset to the device, which in
>> many cases recovers it from the hang.
> 
> Does a full reset cause the link to be negotiated again? If so, there
> is no harm in setting the carrier down. If the reset is successful,
> the carrier will be restored. However, if the reset does not recover
> the system, does the carrier say down?
> 
>      Andrew
> 

The way it is written - a reset triggered by the Tx timeout path will go 
through e1000e_reinit_locked(), which calls e1000e_down() followed by 
e1000e_up().

e1000e_down() calls netif_carrier_off() at the start, and e1000e_reset() 
later. e1000e_up() triggers a link state recheck, which should restore 
the carrier.

So if everything works as it should, the change proposed here would be 
both redundant and unnecessary. However, we have been getting reports of 
these unrecoverable hangs from time-to-time, so I suspect things do not 
always work as they should.

There is one issue under investigation at present, where a persistent 
hang was reported following an aborted hibernation attempt. We are 
testing a patch against it.

I did not see anything in the original description of this report tying 
the hang to a power state change, but I will happily share the patch 
once we get preliminary positive results.

--Dima


