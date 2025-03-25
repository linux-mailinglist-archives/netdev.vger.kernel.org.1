Return-Path: <netdev+bounces-177616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E387A70BEB
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6923B84BD
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB06264F89;
	Tue, 25 Mar 2025 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RonBK0+8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D86263F32
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937038; cv=fail; b=Y+TCJkb1qsFe5CiPKYuaPwMECPL69Q1s4Gi5ccbWj/6QGIMfPVTccce2CpCb+2dY3DxCIyzee8b85AlHSq7COorK5gj/nCubQiPn8ptOuDig4Zf/boaeSNUgKz52XH/KOpfBHsB1mDMIRB6W+KdYAmjjqGpArk2727bAEpzYZJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937038; c=relaxed/simple;
	bh=1vpnPTz19vFkAS6urqD5UjebqpIoEqChfoBstxMHwAw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m2t7Lu6prrt1UrZ1iPSJMrX+tVJiUtVGAaCbPCNsT4yKN3Vk5c0oF3PJW9FJk6JlWvTnBmk6MTvGi1RwFdshHL1F+wm7/HQozaENcqN5jbSf2pm86gbNfPitRVR/+LaQX2SepS50XWNwTl8JnWlcF7llw1fTiZtjMDo1X9kRcpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RonBK0+8; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742937037; x=1774473037;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1vpnPTz19vFkAS6urqD5UjebqpIoEqChfoBstxMHwAw=;
  b=RonBK0+8NTBuXxSYGY/7CRG49fHkMc0TpL4W92pRj8bReJkDH+jv0OAa
   Hnf4ifDcfi7J42olhfglRRywKsVGwlFsZbUdFPUmjYBEFgqP5EfWwVnC4
   FgnF7hubnCumpemER75XMFxOZWIPVZbBfPOGX8A97UhTgqaw8xLvsLZrw
   S/AxJ2U7riZejzx5s05wvXrP74VXp2b8wK3i7irOLss0PXRpUO0grdbhf
   IifC8/VLYi5QZlpn4goHIVc2rf6dhIxm3THX1/7tnj4rBTetcqrii4RHW
   o736TR0YaiNlRYfYR6cntoJpXeHEbEvlFdCCWPEmzQioZYN1QKu3bA9wK
   A==;
X-CSE-ConnectionGUID: BGikoiUFQveM6P70WcCNYg==
X-CSE-MsgGUID: MmsCNKkbS3a7/YgOM5xkSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55194972"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="55194972"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 14:10:36 -0700
X-CSE-ConnectionGUID: CArucdUaT3urxyKPKfi2YA==
X-CSE-MsgGUID: x5w2E6WZRumKOEji919KDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="147680615"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2025 14:10:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 14:10:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 14:10:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 14:10:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWqj7eYZkVOp+JeUhcfWD0T9byMXA5R5v1SYGhR6xYUPjfJn6jRMcf0J8s5zgSqI6OohqcMXJuUlI2ZrMKYgiehDp77CHo2+x7pozTlj0/pgmTNCy0HFhTE/uBQTGN6gwCHeBYSTahnt+t8+2f9nsAGKCZdKsv8hdyuuK7bIprWb0H6DGSob/flvV3TYz6lo0wN4Xz+YweFdGYvutLnPO+KoKloCPYB5O1CxekdEKb/K6mbRn+hRwOvXfuaADqDBlkv+FOrpjhbdT6TR4EpPTeBqep/4ksLVuNg5Rt066sCKc/kX1frNLdUUs5rZwZkredzPt9O8UPyGbMTwDpEpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDcTfaQrfO2TkPhwBeuBPgJetJSRCJ83ZtwqrzwTw30=;
 b=XTrQe0F7E+Uu5jCg7rwNoAutEMobgA4Y8mcHJZMhOkem4rUYjfDaMvjjhZ8Tu/25Z8kvIhckN4RUtCdh1cMTZjNkcL+SWLBDxqksGcjGojsR5+V4RbQ+5R3zmudsx9h4A1NDSnFs+AFkRwa8Rycw9uW04tuHRqN+N7vx7n4DSUHAgSK2+1aIQ2QfYCF8vhPne2Min28by9hFYPjd71nAnH0D0ymM22tvoU+Y23fBcX+VPukKhcKmrzrMaRdoakmgeMyuVTCW/Hr+4jo2yj/e6CL/4NWN1LPZ9QU9Slux+JS4veP1IsczdJpBY1IC291xD2ePjuNnjyh7KEuDCOBxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8705.namprd11.prod.outlook.com (2603:10b6:610:1cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 21:10:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 21:10:30 +0000
Message-ID: <75d06e1d-a21d-4365-a793-2dc593d6e751@intel.com>
Date: Tue, 25 Mar 2025 14:10:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/10] idpf: add Tx timestamp flows
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Milena Olech
	<milena.olech@intel.com>, <przemyslaw.kitszel@intel.com>,
	<karol.kolacinski@intel.com>, <richardcochran@gmail.com>, Josh Hay
	<joshua.a.hay@intel.com>, Samuel Salin <Samuel.salin@intel.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
 <20250318161327.2532891-9-anthony.l.nguyen@intel.com>
 <20250325060030.279c99bf@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250325060030.279c99bf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:303:8d::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 82764436-36e6-4c1d-bf35-08dd6be17926
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkRBbHNGdDByQWNjUXZBeGwzc0sxTng0LzlraVhleWFHVG0wdVVTU0NFQlB1?=
 =?utf-8?B?SElOcEhNWlZGMEYzd09FdCtFQXdqWVRGN1J2Q0djVDFlWTFLd1AxWjF2WFU0?=
 =?utf-8?B?MXplSWR6bml0UmNNM0lOOXZSWVBSdUh5WlluNXE4YXF0MHBYSXo0OXd2bzhR?=
 =?utf-8?B?SUhGN0pWZHBLS1ppZjl2aWFFQXoxQkdORGRSWmh1VFkvSkZVdUo4WmplOHNM?=
 =?utf-8?B?aWFBcTJZc1FXVXJrN1lKZ244YTZ6bngxR1pLbEJFOEVUSmFtWTZrUGwzRXp4?=
 =?utf-8?B?ekozbjFsUVpPdXRsOGJhdHlPOUxxaldaVk1rcVNDemZFRnk2T0xwbGhZRlJR?=
 =?utf-8?B?RHNYR2h5eE9wYUFXOGNLVmZXdWVDeDl5M1dzYTh2cWlMN3A3UUxjNnZyeUpQ?=
 =?utf-8?B?bWgvMnRQbUpwc1g5WFQvN2YzVUQwaFY1dGMxczhKeVdwZ3lwLzV2Tzc3OUo3?=
 =?utf-8?B?cU5qQ0ZDcU1UbkJlbTVBWDVRVTlpcGZ1TUVTbjJBempuVTNlMFpsdW5Jd0Mx?=
 =?utf-8?B?VitiaW9KRUhVa2U5UEpiZ21aMy8rR05IbkQ1UFNDU0h6OVhuazdvVEl3cDh2?=
 =?utf-8?B?dmFLMmZwWTZZMlBIUjh0VmV5ODVQN05FelhSL3hiSUxHREdDY2J1NVVoN0pP?=
 =?utf-8?B?ZTUxYlhCdkRwcGdRb2FlMWZYVzhvYlN6dG0xN3IyTk55L2p0bU82ZHRFT2VX?=
 =?utf-8?B?NnhhYUVRVU1CZ2pRNG5FeEhLUmhrbWtEVTMrV1E4Ti8ySTBEWjN3Tkl1U1Fz?=
 =?utf-8?B?T3o2dzk1NHU1dytYN1UyaEFRSlpCczJJaCtZaVdXMTFybXNsMEl1di9uUEx2?=
 =?utf-8?B?WTAzaTVuYnJPc2RuTmwvaHpKTDB2dGpDMCt4S1NFQmM5bktTWUlNdXYyUjUz?=
 =?utf-8?B?NE96cDdXR2Q4ajRCcTdtNysyanlaMW9IV29EcUdIRWFOdGlUOWtyNW1Yek9Q?=
 =?utf-8?B?a0cyVWJVcW45WGFaQWlRT2ZlZ0p5SUpTaURlUStEcjRnR0sycTV3amRWdUhy?=
 =?utf-8?B?NWIzTGlwWUI2S0Vib2lXNXZSQ0pzV0JkNjdwR2dFSVJLRXplMUk3RlNyRW40?=
 =?utf-8?B?bzFNRTQzT2dETUMwckZqUVlzTGlaRDByYWI0RU5QOUhKdEtKWGV4WUVDRnVl?=
 =?utf-8?B?b1A2M1pmVWE1YjY2Sy9QcnlxVjR0bkxzMExrU2I4RTVWc0Y5MktRcUpMUTVY?=
 =?utf-8?B?dldtRDJTY1BtNlI0L1N2eG1jRFE4VHhySVVaTE51dFMvblBwTHpFUFJkWjMy?=
 =?utf-8?B?Z1JyQjhQem5ZMloyeHhPMGtwY0lNTitxUE5KT2RGYWliNEd5bVlYVkNXbG4v?=
 =?utf-8?B?Q1Nqd0luWG85aWdOMExvYzh2WVhWQ3lNdFplTGwwVWlWM1JuTm53THdyaHZ5?=
 =?utf-8?B?bmVldXMzd3RhR1p4bGtsNEhRekFyUU83eEtJSUZUNUNxdktVeFNWU3NHOGFW?=
 =?utf-8?B?ZWIrYUtHMzFLSGdsV2F1bmpKNm82NXZDZXc4Z0g0UGk4VkJaNmIxZExjRnZE?=
 =?utf-8?B?TXZ3S0cvSXBKVHA4eGZyM0V1Z2Zua0t1T3hXUlN0cTNhZCtaWDQvR3pGVVJt?=
 =?utf-8?B?K1RyMmxKSzBnTGdXaHJORGVUNGF3RG5CcVVldnduRnUrSXVoRmJGc0ZzT1Q0?=
 =?utf-8?B?VjNLT3YrQUNLek9pMTU0VVdmODh0L3M5b0FtQnVkOFdXWU5ncHUyYlFNYWE4?=
 =?utf-8?B?ZTAreGZBd2Jwb1pSWktyalFTWlcvRERjaEJ4NzRBdjdZYUVLY0RJd2xXcEp0?=
 =?utf-8?B?N3h5b3o4YzNFSll5OTFDMHQwMEplMzdQcHk1bmYvelpndU5LV2w5N2dFdjZz?=
 =?utf-8?B?aEJVYzBLL1ZrRENmVyt6TkpXVXBXMlZwV2xHQWpIUWNJaVhubzY3azliR2tv?=
 =?utf-8?Q?6O5OlKJdsulQT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dERycFUvZlNjL2pEd2xYa1hoSUU3c0loODJtUkZ5UTNiRkV6WU9rQVF3K011?=
 =?utf-8?B?SUQ0d2xScDJ1bUNhNnovbis5RjNCWHJNMkpzYzQ0TkhWOEpBZ25jSWF1dnM2?=
 =?utf-8?B?RkV5VWIydmNnUVR4aFZWQ29FZkdpanZ6NjJWdm5odmxLYVFyT3gxaEp3bDF1?=
 =?utf-8?B?LzZDZUxHN2hpemVpcEpWb1FzcHAwaS9yTjBWZ0NUejdjY0Z0ZWQySzNZdlR5?=
 =?utf-8?B?NVQ1ZkdTUTJBUWRqZy96ZElRMXZCR2JCUHRObENLaXhQdU56S2RxMnJ2Z21n?=
 =?utf-8?B?ZVVnVGFkK3RzQ3EwS2M5YkRMN3k0U1FHWlVsVHFkbUZVS1VoYy9GM0F5WDBU?=
 =?utf-8?B?Qm8wNGxDaTVCV2xsQWV2eTBxbFdHNTFLMmcrUFgzNWp3bFd6M05xOWJyWTJV?=
 =?utf-8?B?VWM3empZVUVCS2Fmam96aWh1eVgyL0xJdnlLVG1sODFEMkdWclBneUdQVyta?=
 =?utf-8?B?K1FXYnNiYklzWXB4R2lkVWQ4bjdXODZ1Skx3Rm8vb0dQODV1citmdFl4UXI3?=
 =?utf-8?B?UzRPRGtINXJtRmtvVHVoa0o4a2MrNjU2Rjg5TUo0aU9nOHN6bERuMWlKQ3Fr?=
 =?utf-8?B?YUkzUy8rcCtFU2owMlVENjVseC9Hc3RRUzVwQmhscDhqRTJwYys3RWFUQnZS?=
 =?utf-8?B?TXJLSEY5Mkdma2VsUndQUlRxTlNkNzhGTUxoYWxIaEI0Qzl5WENBcXJjMXU2?=
 =?utf-8?B?QkZjQVVsZVB2MTd2YnlGdnRDSFZPNnJxNUZaSzhqeENWNXZuSCttd2k4djVu?=
 =?utf-8?B?dmxGNFdLRVRSYXVsT0VYSGRpQWp4L1pOMldLeDlpeVZ6dzJveVVZYTNpQjlN?=
 =?utf-8?B?d2VaQUs5Z2NEUXBCdXJTVXVMUlo2K2swM0oxa0VHdDIycE9vZHpqcGxXeFhF?=
 =?utf-8?B?T3VMV2doMlBOTEJoM1EvZmFXMUxMVTE1enNuRjZrWE4xTkhTMTFHNk5RSFVk?=
 =?utf-8?B?a1p2dHFTT2ZxN1ZJS0lBWU5jRmp6TUVFYk1tZjE0ZG56cTlkYXp4bmk3MFNV?=
 =?utf-8?B?bWVINmtNUERpUHdFZmpZNkdmN3RQalJjb3JWczFIN2lDdkozQW9zSm1lM09s?=
 =?utf-8?B?SzRIWDVoNEo2Z3Z2RkdpY1Q5eHNwdm45MDhCVS9xc3dxM2FkMzNoOE0xVUp5?=
 =?utf-8?B?Vit3SitGSjJmZWZyWjhrUWprZVJXNm9UUXp6SVViek5WMVNMUXFKZkJsa3d4?=
 =?utf-8?B?ckRKWVpiZDJBWkkzZ0daMldZYXgvV3lFOFZiWDMzd1BDVkdGUkxSbzFtOEd0?=
 =?utf-8?B?VnRoZnN1YlBNVklkZUlHSUxicE5INERQSk5HekJYdGcyZUFqQ2owdTkrWjll?=
 =?utf-8?B?d3FBVHBySFQ4MDhuZmZ2Qy9UUUxSc2Vqc0dDb1ArWFFDU1FsT29LQlo5akNO?=
 =?utf-8?B?VU9OUzlMNkdkcU80UHg2MWVmY2pDMzR1ZTU2a2lhQjZKcTVzUXdRM2w4YnFw?=
 =?utf-8?B?N2FZazR6ZW1qbnBrVnVnZys0UWtEMUd3RFFQU2pWKzAzaEJOSjBlbnRSenRF?=
 =?utf-8?B?WFNIVlI1ZmZDSk9hSDFma0ZKQkF5dG5oYU5GVzA1eFdieWVDWHYxVEVmaG9o?=
 =?utf-8?B?R0NodWYwNFhnZVY5bEJmSk1qQmNvQmJvb3lvNHZpTnVtNVFYb3VDMFZVSnZk?=
 =?utf-8?B?WXA3dGI1VUpnNmxiUVdqOUNCdmZ5S0pncTJibWMyLzJxem0yN1M5S2RPMExa?=
 =?utf-8?B?eUNKOTcxMWJrNEVFUU5wZU5HM1JpRHNmQzFJNnQ1aU96M3F2R3FvMjNlUkI1?=
 =?utf-8?B?SkhTMGloT1ZBTytUSktRdWkyd3Jqek1GSHpaeTRDRFpvTnlSUkt4RzNFYkJF?=
 =?utf-8?B?UEttZHhuWlh1djY2TXY0elBQajhZNUpZYSs0SU85NHdjNUU5MEVRMXhOZHVt?=
 =?utf-8?B?S2pQUjBURktEQWViTDdLUzcxbC96UXBIVDZsVWFjNmxLU2p1dGVDaWd1RzFz?=
 =?utf-8?B?V1pwSVRFMkRoRFZlZEsxY3FrYWJGN2FoUEh4aXN1bU1ONkMwODViL1hOZXVD?=
 =?utf-8?B?UFMwSjJzWWY2bHFwYzVISzhJTHlWaGpaL05WUi9zOVlzdjgxSzUwck9aNGhF?=
 =?utf-8?B?RkF6RHRsZUxleUw1WHdFK0dudXN1WmU3dmNySUN4d0JKSHVGVUFraTZER3Rz?=
 =?utf-8?B?ZDNKR0ZneVRoQkxLaFA2TkJSTFdTYmc1SFZpVVU5bzR1TU1IZlo5VXp6UFpW?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82764436-36e6-4c1d-bf35-08dd6be17926
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 21:10:30.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3GMA7Ud5MDmvlIyy0FMr9t2e/yef5p7ckFU8MmF4vEQEXQRH1nidlr+fZalAcPem5dgawkkVyWqXy96lHIlYfguS78js54hjGuEkhyzo1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8705
X-OriginatorOrg: intel.com



On 3/25/2025 6:00 AM, Jakub Kicinski wrote:
> On Tue, 18 Mar 2025 09:13:23 -0700 Tony Nguyen wrote:
>> +/**
>> + * struct idpf_tx_tstamp_stats - Tx timestamp statistics
>> + * @tx_hwtstamp_lock: Lock to protect Tx tstamp stats
>> + * @tx_hwtstamp_discarded: Number of Tx skbs discarded due to cached PHC time
>> + *			   being too old to correctly extend timestamp
>> + * @tx_hwtstamp_flushed: Number of Tx skbs flushed due to interface closed
>> + */
>> +struct idpf_tx_tstamp_stats {
>> +	struct mutex tx_hwtstamp_lock;
>> +	u32 tx_hwtstamp_discarded;
>> +	u32 tx_hwtstamp_flushed;
>> +};
> 
>>   * idpf_get_rxnfc - command to get RX flow classification rules
>> @@ -479,6 +480,9 @@ static const struct idpf_stats idpf_gstrings_port_stats[] = {
>>  	IDPF_PORT_STAT("tx-unicast_pkts", port_stats.vport_stats.tx_unicast),
>>  	IDPF_PORT_STAT("tx-multicast_pkts", port_stats.vport_stats.tx_multicast),
>>  	IDPF_PORT_STAT("tx-broadcast_pkts", port_stats.vport_stats.tx_broadcast),
>> +	IDPF_PORT_STAT("tx-hwtstamp_skipped", port_stats.tx_hwtstamp_skipped),
>> +	IDPF_PORT_STAT("tx-hwtstamp_flushed", tstamp_stats.tx_hwtstamp_flushed),
>> +	IDPF_PORT_STAT("tx-hwtstamp_discarded", tstamp_stats.tx_hwtstamp_discarded),
> 
> I don't see you implementing .get_ts_stats ? If there is a reason
> please explain in the commit msg. We require that standard stats
> are reported if you want to report custom, more granular ones.
> 

My guess is that other Intel drivers haven't yet gotten around to adding
this :(  It wasn't in the kernel when we submitted ice support.
Obviously not an excuse, just an observation.

>> +static int idpf_get_ts_info(struct net_device *netdev,
>> +			    struct kernel_ethtool_ts_info *info)
>> +{
>> +	struct idpf_netdev_priv *np = netdev_priv(netdev);
>> +	struct idpf_vport *vport;
>> +	int err = 0;
>> +
>> +	if (!mutex_trylock(&np->adapter->vport_ctrl_lock))
> 
> Why trylock? This also needs a solid and well documented justification
> to pass.


