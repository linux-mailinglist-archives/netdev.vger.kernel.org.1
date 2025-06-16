Return-Path: <netdev+bounces-198178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D079EADB7DE
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B3F188F746
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D6C285CBC;
	Mon, 16 Jun 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgH6od2x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214E8488
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095641; cv=fail; b=lVCZJGgMECxbZndoMiPdmu1hRlpScwES9bMx5rqAxoH0I0bn8hKbRX1eQcGcFUqOtsDObbQ/QM4egd09XBr+1xxpBajdAyOVfexw9bktn0owE/Dj+yLBLEjYJjtSQ/7TLxK2VeQFYxq5n6mKQYRrjZ4pk99HqujtAsaCl/zkDI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095641; c=relaxed/simple;
	bh=MzNda0R6KwVjJpI0wHjZGGvZIRUxdHRqwXriu88m3XI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=usR9FSGST5wxbXDg0uvYgVql1vq/gg/zYNI5R7a4APqnXcums1hFAcXOY+StTCv1epZFShQNaTwSaoXDGmPRmmppg/QywPLYPFbXBh7nmaQMQA/hohDN0kQx/unWnCbytkx1sVUJGWh0M1u2YxfZiBZ1g6Q7WarFbkgpcHs6e7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgH6od2x; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750095640; x=1781631640;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MzNda0R6KwVjJpI0wHjZGGvZIRUxdHRqwXriu88m3XI=;
  b=KgH6od2x8WacxLkanc4cByYuj8nX888gE+ok/lOypECDX44QNa2tkEkg
   ma/940DzVVz7iSJSV94XrAXV2pWA8/0voG0pm2Mye1nJlYzHVTjxK2QR8
   4RZqMvT6Bvv5cHUgXP5ocAa0Tl0xcFTs6hkfxuOg5w/FzqpFeyLwegJeO
   91BFJqOI+mjWi396N0jiJzu8FEGAYZhvQM32BLrnnwcJvX7s+ujLo5NTd
   IozOL71X5JhKsuXlAJl7HvH1FKcrwKbJFXSkSrKqsotbOwTk0Li456aJF
   /MBAfhXcecYVjdhYd6nRmLS7P9RafaHrWn93/MR9uN7NWu+gjoq+L7YKL
   Q==;
X-CSE-ConnectionGUID: JDO960I4QrqrLF8qWh8Lww==
X-CSE-MsgGUID: /y0RzhhQSESUba0sxtkyoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="74783938"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="74783938"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 10:40:39 -0700
X-CSE-ConnectionGUID: Eh9TowCmRiGjlYrmacPOgA==
X-CSE-MsgGUID: JuJNll3eTc6Ulc74op4jbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="153833549"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 10:40:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 10:40:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 10:40:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 10:40:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xS0FqT8Y0y5C1A73GhW5/0RQAPgZSDR9eSH9Ji4c75FCw+MI/pQnNhUEgCP53ejuMjnJ0Zs6fQllPjSs6Lgh0tDJV8Ug9Sj9hgUz+KPkA87HMMDvOg356MI8NMLFdd/X4SqIOl0KQv0nWGwY37i9MNvadkSPtFqpzgR3NlTql5eoFt1WaDnLfYDSgDqF6sMtws+dIxfF4AOyGVomDI9yqe5gBbiEaMdRDf/XtmSmuQrti/Xi1W3ibhpTCG1V1hYRRtKLzNYKptp8NU4oez/9+uA5H5dFH7Y3t4T4QjeU4yHnZvAqVVYFkDBxvJ4piGnHPBkf+ZJyEZyayhnccd+G8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VIIqwrWvlL2LNcotKGm6eMrNPXtz2kJQy02GUK9i54=;
 b=OHFJr6gM/jZeokKSMPmdjDAkUZbooTVX3Q5O2CrVWIA/Y3V8t0HhB/1XjFOt1+oXMHWylkC+heVwee9izS8l0pzhtoeVKhLZRzXDveRDdfDH78sY3Eyo2cZ8M9T/oeZnHcWEixvcPZUCdlyFf1HYzZ0A2bdctJEfC5iDfqp0bGtWCR/XXsSU5oYuMNZTQXvz6YMwBnUhVcNb03ynpo43r5SBBR2gaQLbfyZVNcTfJLf4ydNiy6s0bh9uje8gNrVO2VrI1inZEpKwK08CnwCorNkG1TpT3In/+YjL2LwwCGTsAI3ldvsaiJ2k3T0316aNxqtMGuBa+2Qh1e7fCAmWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA3PR11MB8046.namprd11.prod.outlook.com (2603:10b6:806:2fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 17:40:22 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%3]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 17:40:22 +0000
Message-ID: <3c8f1154-91cd-4b25-b517-30c4cb97f40b@intel.com>
Date: Mon, 16 Jun 2025 10:40:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] eth: intel: migrate to new RXFH callbacks
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <przemyslaw.kitszel@intel.com>,
	<jacob.e.keller@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<joe@dama.to>
References: <20250614180907.4167714-1-kuba@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250614180907.4167714-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:303:8f::14) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA3PR11MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 87492797-0f80-4d6a-9c20-08ddacfcde7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ei85MkFLVmFUeElwWkpNWmQ5Nm0wZ2hCUzBObmh1TUl0RjY3eFB6V3BSUkJa?=
 =?utf-8?B?R3dVSzJNTXU1YlNRVmtTS1M0c2dsMUo0blpkVWZHTzhhNjRUNksreWx1MWhy?=
 =?utf-8?B?NDhLQnJQSVJvSDlUS2dqY2VHVFBFV1MrdWNEazhiYkJvdEJrQTNxdEFuSmhu?=
 =?utf-8?B?QkVPS1krV081K2NkdGl2YnZkY3M4azkrY2FGMFZPZjB2bmhKRmZjVlRQd3Bi?=
 =?utf-8?B?L0Y3SjQ4SDErTUVEN1JYamZ6QkduQXpQemlOZGtGNEZGVjM4OUJwd3lFQnVI?=
 =?utf-8?B?UGIrWGZIc2hxTzNVT3dGZXVyY0c5UFNScE16ajZQRzBvNUplTGVxWGNoRFVY?=
 =?utf-8?B?TkJ5T1FHN1dwY1g0NC9IbFZVZWw3eGw2VDVNRWRxT0VnR24wdVNURlZ0UHBs?=
 =?utf-8?B?NU9YY01JaW9NZWd3VDFXUlR6ZDNTT3I1TGgwdlR1cjl2V0RhQXNlVGJtb3ow?=
 =?utf-8?B?dzBFQVdoVzdPeDFoeVZDZWlvM24zcUhwODhmOFBwWGo2TE9mdDJwaHpoZGJD?=
 =?utf-8?B?a3I1WkRSK3NkQ3g2ZTJ5a1pPT2VGZ3g3RnZjZ3NDNjBTbXRSV09HRldIVkdG?=
 =?utf-8?B?bTZvb0s4L1dnbjcvQ1BjLzNuVmYwalI1Qi81NCtlSEd0ZThGUmpuekl3bEVO?=
 =?utf-8?B?akp1eHVFNGRZeERSS2Y3U1E5MDBWemtkdDlWT2xLcEJMZEwrVUFJWFBYZ0dO?=
 =?utf-8?B?bm5nanhTeXNSUlpmaVRrZURPY0dPR3VsWnJWTG5YbFd1MFJ0emRldVFOZHk1?=
 =?utf-8?B?MjQra2k0SmJQN2lJZFZvWitZYXpESEt4MGc0V2FJQnhUM2Mrby9OeFZ0WXgr?=
 =?utf-8?B?WVE0dVlJWnlwa0gwbmxVUkRPUHhra2FkQXF5NHZaSjFYc3NSbC84SFAwRldH?=
 =?utf-8?B?MmN3SjB6YUc5N0p1eUZRUms2Z1RKN3ZTTzQ5OWFjbjErWEUrMjhwU1I1NEZP?=
 =?utf-8?B?SUEwQW51RE5xWmVzMWlTbWx3dmxCRHNvR2JmVzI4bFAzbEliK0IvcEpUMXp3?=
 =?utf-8?B?a2g4bkl2ZVlkN2pHejVVUUFqOHJkVERQK0JZZkZNRUg2d0tVbmFqUFJaMVFQ?=
 =?utf-8?B?UnFzRmVCRXJHWWo1YkZIc0FZV3JKaWwwZTFaeUpNRTN2R21OY0dCS1ZOcCti?=
 =?utf-8?B?R29OTnJ1MkdZQTFaRnZLa2NuWVpuUll3d2ZxZEVCbk9FQlJtUUZEaVVuZmlp?=
 =?utf-8?B?NExnMC9LYm83eDA4a3I4VVJGYXZET2tFRkdScUZsSXNJalcya1NLeEsxUG1M?=
 =?utf-8?B?dkl5OHNNU2tTczdWQXdyTHBpajNhL2dkYjFXdUtqT25ydElRYXk5NU85LzRK?=
 =?utf-8?B?QzBNNHFWWlJJb1lGM0x3ZVg1Z25BRTExUE0wWi95UGFIL2VETFZkSzFIQzZ1?=
 =?utf-8?B?RVVUODlwSVAxTGRZaDhNcGp0a0xBd3ZKZG5aRDNwZWFrV3hHeWFBWFB5cnlj?=
 =?utf-8?B?eUJLNFU1QzJmdTNQSit2R1VqcDZIWi8zb2FPeXcyU3NPakpSTWh2KzFNWTMv?=
 =?utf-8?B?MWJCcHJBd0NQQ0thekJkQjcwWTJ5Z3RWcjVoVkRkU3cwMzEycTN0STlSeGNS?=
 =?utf-8?B?Z3k0SHU2bFFGOWYzY1ZsWmtzZzRhb3pMaFRLUUxYWGpjd3dUYjF2Z0liTjQ4?=
 =?utf-8?B?V1FoQktxUmJaT3dPNW00czJtNUFkbXVGQ21LdjNVczE5aVFRVHVUQkVLeW5a?=
 =?utf-8?B?N0VGNjZSUElLMGM3OTVpRzN6R0pxZzJaWWFBMlFnd3ZXVzVVRXd5Q0pBK2Vm?=
 =?utf-8?B?WUZSc0N5Y1BHMUE5QlhsMDVPdlRrSEZ2bTJzTGtqZ29IYUE0aEJpVjZZN0lF?=
 =?utf-8?B?L2ZTWlNTRHk3VEhvTEd4TnY0bGI4L1c3MGlLUndvWU5ybmYraTRCKy9XamhF?=
 =?utf-8?B?UjA5WFcxOVJnMEtKOFFNbnA2MWxxSDRueDVPajlONWRBemJnMnFCUTIwOTRF?=
 =?utf-8?Q?YfsTEFLCndY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNuczcwb3hYRk11QkpvWVdacjJQRzBteFUrNHVpMTVSMCtEV09JcjBKclYw?=
 =?utf-8?B?Zmtud0VJY0ZyNlJMRWNOTW1DeWhhaHFYTXhNZlpzTCt6cEhhdDg4ODBBWXQv?=
 =?utf-8?B?cmIxK0hRM2NlcWorMG5qQ2FRZEMxVFB3L0cwSGUwUERpd1dycXZvaVJ3MW9l?=
 =?utf-8?B?RE5GTmQwMkZOTk8wSm0wMkVnY0w4VTU0SlJFbTZmTVVOYnlRbXJGU1l1M2Q2?=
 =?utf-8?B?bS81b3ZPOG1CQlNsdUpJdzVDWS9CZDAxMzNwZERvR3F2YUljQVRlKyszNjN0?=
 =?utf-8?B?VzZNenNveDFpWWh0WU90R3FyMlV2M3NkOGQvUndtNmE2bVZKalg2VXFkb0gx?=
 =?utf-8?B?ZW13OGJ3NUt0Qm1WOGhNcUtXbEk1cVNQT0lTL3BSbU9mNFhVd2hJcVE5RkJk?=
 =?utf-8?B?VG1RVHdBejAyNjZUb1FTYjNyWEZEUktmKzJnUDdCeVVFdXdhUkdydlQxQm1I?=
 =?utf-8?B?VXY0Q1JMMGlSL01BdzZsZkpUdE50NGZUb0Y2Y2RobTVsekY0UXE5NnR1cXlm?=
 =?utf-8?B?c0pTMFpsOVZlVkRueTU2bE5rQnloQ2FTUHB5TGsrdGlpSDlDWjZQaWhGelRp?=
 =?utf-8?B?L3JNbUhaV3Z4UzUvSmJTV0xjVS9kNXlvamZJRHdqNEpLdFhSbmVYTDlaZ3FN?=
 =?utf-8?B?R0ptbEZ5RTBYZnFRVkJvUFBVTk1CZ0tLMlB1VUxndmZiUEtvMEpkL1VtZ1ZI?=
 =?utf-8?B?dXZlTVNtYWNnL09MY200bnVQNnJUZm10L284Ymt2VDE5VmQxVTVFUFFNYThP?=
 =?utf-8?B?TUVqUm02WndYT3d2MXQrNEZsUUlXdElPNlVBZ2hVVm00NEE1c1ZKSnZ1K2M2?=
 =?utf-8?B?NnZqa3VDWjFxaytvSGRUNHlsLzdyVzNBSmk1ZWxYcHltQjBXL2Ric2Y2V1h6?=
 =?utf-8?B?QXhoNFVJWXdEem9MaWVoTXlzM0VUdnJ0YkZBS0tQMG44RDZ2VFp6V3lZUkZP?=
 =?utf-8?B?VXliWFNKSklBZHZEZ1ZsR1Q2citlcTN1UktIUE9GdWwyZXRIRU5XNTduYjkw?=
 =?utf-8?B?dHowN3U1L1dUOWt2R1VtZnlId3pUL0JTdSsvRlNPTnAyWm9JcUhWcXZLcFli?=
 =?utf-8?B?c0dTbWxxZzMxVjZQTnByeDdSUmxSSUJBTW5KajFpUVZ4Y3ZBNUt3bFlEYUhV?=
 =?utf-8?B?a0Zab0taYXhkT3IyTHJWZ0RHYlZRY0VBSXZjQ1l1b050aUZqeDBsWXFIRGxw?=
 =?utf-8?B?TEp3c0ZZYXcwY0p1Zk1RS2hadTJwVVFBRDN5ODNsbW1FamtkSmxpQ0R6Y1RB?=
 =?utf-8?B?NEtvajZQVFZxTjRpTSs4VEpFS1pCa2ppc2RidE5UbWNzR2Erc1hqYmdOZ3RL?=
 =?utf-8?B?UFVhWC9mcGl6ejVkbDN2UVFsMEkrUTdsZFltZUQ4a1Zhd0VYOGFRSGtRQ2U3?=
 =?utf-8?B?bEF0V3RsdmNpMndiem1MZXhJTzFCYkl5VnhEdGZWd3YyU3hETmIzaER3cUFs?=
 =?utf-8?B?dE1RY1EyMnVzTlR2M1ptK0NuVE1NT3V1STZFeXNtUERRNHdPeXNxMUpSOE5D?=
 =?utf-8?B?MFhpNEI2MDBxdm5PenErMmxLcUFxWG1OT2dDUXB4QWxvM1RzbHpHRWkwWjlP?=
 =?utf-8?B?ZFEvTi9NZXRIbk8xREtQVHR4enNMZk1XU2Y1Vjl2OWZFbjZCRjlRNTk1WFF2?=
 =?utf-8?B?TlJ5VjZ1blFEaUxxazVZRk9jeURVdWZ6ajJMVER0aGFNdWZUbGs2L0VyU05w?=
 =?utf-8?B?WWIyZGVFakQrYjVEM1BTM2pWK1kyNFVlcjNrMXZscDRCVEM0aVJWN1ZseVVY?=
 =?utf-8?B?OC9RMVo1SndKSHR0V005aGVHT1VzU1loc2ZCMTRPb2p6SisvdFVOVDRrWlRI?=
 =?utf-8?B?cVB3Ty9majE2dTBkeDcyMjFpR3ZuTnFYTjNTTTB6MkhVYWRQSmxnNUZsckEy?=
 =?utf-8?B?YTdRNGEwQnM0K1M1VmIyaUIzRjAwZUVPMjZzODBYbXhtaXpFVERpcmdHdVRh?=
 =?utf-8?B?Zm1zdDVzUTliekdBK2w5T1duRUZ2QVBSb2dXT2ZRYk5HS3pqdlZkSllJbUpQ?=
 =?utf-8?B?UEdCYmkwY1BOamxOVVlYdWxzVU9Pa01oVFV3OE1DY2lFOUtyWHh0OWlVVDB3?=
 =?utf-8?B?RFRXNU1OZGVoakk3Nnl5b0lSU2QwbE94bGhaQ2k5T2FuaDdwUGo3YjJyWU43?=
 =?utf-8?B?U0VWajNRdDVod3BVbEZRd2VtQm5ZUFRUMTR4ZStLNThUQ3JjbHRhalNqVGFL?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87492797-0f80-4d6a-9c20-08ddacfcde7c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 17:40:22.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mg2PJb8tLx2SIALEyMeK2JtmtLx1qRoXc/SliHS194u4V1ji0yi3oI+urlcs8vdsaxDoWmVqiNYLWC0HnaPwcwK6fD/ggicydWhslaROHsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8046
X-OriginatorOrg: intel.com



On 6/14/2025 11:09 AM, Jakub Kicinski wrote:
> Migrate Intel drivers to the recently added dedicated .get_rxfh_fields
> and .set_rxfh_fields ethtool callbacks.
> 
> Note that I'm deleting all the boilerplate kdoc from the affected
> functions in the more recent drivers. If the maintainers feel strongly
> I can respin and add it back, but it really feels useless and undue
> burden for refactoring. No other vendor does this.
> 
> v2:
>   - fix missing change to ops struct in ixgbe
> v1: https://lore.kernel.org/20250613010111.3548291-1-kuba@kernel.org
> 
> Jakub Kicinski (7):
>    eth: igb: migrate to new RXFH callbacks
>    eth: igc: migrate to new RXFH callbacks
>    eth: ixgbe: migrate to new RXFH callbacks
>    eth: fm10k: migrate to new RXFH callbacks
>    eth: i40e: migrate to new RXFH callbacks
>    eth: ice: migrate to new RXFH callbacks
>    eth: iavf: migrate to new RXFH callbacks

For the series:
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

>   .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 34 ++++-------
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    | 38 +++++-------
>   .../net/ethernet/intel/iavf/iavf_ethtool.c    | 52 ++++------------
>   drivers/net/ethernet/intel/ice/ice_ethtool.c  | 59 ++++++-------------
>   drivers/net/ethernet/intel/igb/igb_ethtool.c  | 20 +++----
>   drivers/net/ethernet/intel/igc/igc_ethtool.c  | 18 +++---
>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 22 +++----
>   7 files changed, 85 insertions(+), 158 deletions(-)
> 


