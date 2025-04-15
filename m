Return-Path: <netdev+bounces-182928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B4AA8A5D4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB037171FB1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215BF21C160;
	Tue, 15 Apr 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5pudfY4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8F20ADD8
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738781; cv=fail; b=m0TF6rioBtraxFkpUHl8ab9fZloGKYNBIQQEnbyLvJilHFsC4zELiiaHyIgPpYBZBqYrMGWJy3Z0o4lntkz1dVJUOII/NK1kLgysIecT1RxvdIUgAQ+OTYH3NoRpYHe02GMuxa0aVbVjiXRChCV2b3uyeSaxENBcaAmTDRgSm2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738781; c=relaxed/simple;
	bh=k6zzovwxuFXen4cn4hFdwol2jSnAJDfhHTq9poMgxA8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OFb8QE4t2mchXXtoNEvLdF+NnJhjWE3suWDbCrTFLMY7D/l9W1zvzzAMkGlibrKfh+NXdg1KobaYYUhF+7o4A/t8VRsfeX6tedFEwY+cV5sSapvTVBiJ8FksdhJR8vntSzYm5qcCnbPvSI6ji2nFhUsNjm7QHGcEgryFXahaufo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5pudfY4; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744738779; x=1776274779;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k6zzovwxuFXen4cn4hFdwol2jSnAJDfhHTq9poMgxA8=;
  b=P5pudfY4nBZH6EQoQsJGIrIZzyjDfb9hX/pT7g1KFXYBysUIqsZOGOtB
   k5MVWObHGxQ1B/G5ws+x93SC72gDLzVG4vaBGfKkBbjFsYSPmwrNATT+w
   MSYvGop0DCIejeHvh5VIO7w0Lz381NOeUSLgl5StWe+HKfySRiX8aBnt6
   aRLuD/DhxBi8/WdeuKY0slJRgUOuck772+kQ0cydV3Ks8MISYfAcLbUEb
   cF27sbW5tuLj6aPAVYzCx8+AhJ8XiRszCNClXeA7hGzDQFvgVrWkPmJDV
   DBczCK8VF1xFyfl5hEEGQVjQkvKGzHnBD/LgqxlpC7emsTPJ1dCt5i8g+
   w==;
X-CSE-ConnectionGUID: 8wgGuy4ySliEuR72Z7apMQ==
X-CSE-MsgGUID: zpvL2ECtSHWmj0znuSy77g==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="56898675"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="56898675"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:39:39 -0700
X-CSE-ConnectionGUID: mjITk77vQhK/vPD0t0NcPA==
X-CSE-MsgGUID: G2O/hyxXQhi8+3vLQmcvyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="135036501"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 10:39:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 10:39:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 10:39:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 10:39:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfp+8w9fc788IyXIKnsihxexBfOyfH+e1zk9JcWfGi94n6CKoM8pogt+IJF82/ej5V3+DGDfWwv9trpW/h8DdQg08VFyRp4FOPdueqppXPBBhKcJVOF8sGsNfNHYz31pX5iGYGqIipwicib8lXoDndcR015ApEH0zVYDtMrk/jat0gAeNsBOadHY7v+PI1bfffm9aKl6v0VTLS3g/hpn9jAEa6OMiMJlik0BTxzdU6xAyIWgrnEnjydxDSlMcwuKHqxZQeiEjXm8kV6L6dvN8V4IVhyt7QcbVRgfVIbEOLxpR5wnXD83HxdzkkV370oURzGso1K0NtZpVtkLVa4Fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/UG4ymvK3ZA6vVgdrQttm+c0k9B2wsp9E/kdxkvrGI=;
 b=pmGCghIAnzsna/nhcwDd9UHV7LFJppL9qixjPsIzpetM/NDrw+znmHvLkLYldFzl4ZgGzT8NABqk6yoApCAKltnlPMIa5i6La8KnTs9l+QurK9no77+6pLDA0o4Wl3d44CRCZZxiIlqC/tZGJ4tTearN3yVz2zJChKlyDCxKONjBBEbFbBHEKwkuf9SU5AUF993YaCy2lliknPDqnz89GgWyvPybZeHWLfKepuqctJqlyYX7ApQ/Bg5CTVOxTtzAprlfNTYKmjhU5Mq55gRjibwxOHCsdIrAC3FWfppiVcNNC/yNQ53k3nd3IT7wemg98wW7FfaMPbPoPul3TpXRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 17:39:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 17:39:34 +0000
Message-ID: <4bcdf54d-a744-4f51-9fdb-7121099538b0@intel.com>
Date: Tue, 15 Apr 2025 10:39:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8] ynl: avoid leaks in attr override and spec fixes
 for C
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <donald.hunter@gmail.com>, <netdev@vger.kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <daniel@iogearbox.net>, <sdf@fomichev.me>
References: <20250414211851.602096-1-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250414211851.602096-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0369.namprd04.prod.outlook.com
 (2603:10b6:303:81::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: dee9b795-f47d-4610-3cb0-08dd7c447c7f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm5FSnUzUkJGdUhid3d5WWtwTUtwQmd4RDBYbkVVQ1VYVW8vRXBSUkZLSFZI?=
 =?utf-8?B?K3h1bTVTNE5vYjJjSXpuSEJDdHVaWllYOXZDc091SnFiVXlHdzdzSTVKNHpE?=
 =?utf-8?B?bU0xNEZwVnVYVkxLVmJORWFpbTdSdUc2SWwzWGJpQ2V5aG1zOEY3VTJsOHA0?=
 =?utf-8?B?YkNwRFR4VkYxRHFhMmhEWnZ1eHJtRUx1TVlmL2hmVXpoaTU2Vi9mSEJmSE1I?=
 =?utf-8?B?MDlvb3dyWncyb0JrR1pmRFFoWnlVbkUxNURodDVLclhzczBsQlFZMllZRnBw?=
 =?utf-8?B?YU4vVm41dVFFTGFmMGxXU2ZyUFd4Qlp5UnN1STdPQTRGeDBGSXdreVAvUVlo?=
 =?utf-8?B?TW4zRmhHckYxNHRWeTk5RXo2MDhueWRmMXF5WGtLbEVOc08zdER2VFRVVTJm?=
 =?utf-8?B?dVJDZWd5b0Qrc2ZpZ29lK3ljWW9YZnRoalRHZlBJSy92RWJyTWRYd2lGa2Fy?=
 =?utf-8?B?dWx4WlFFeG9ENW1qZnliaWJoZkwzclpDbVBNNU9ab2N0cnB5Tk50cUE5SGRx?=
 =?utf-8?B?M1ErOTE5cGV3RFBwRUU5NDQ3Ymd6bEVsc3BYMmFUQjFxeUJnd1FZVEhURDkw?=
 =?utf-8?B?MXQ2ZkV4ekxJWHd1MXNYd0RVSWVRRkxHVGoxcTZvYWk3OUN3N2U4MExPSnk5?=
 =?utf-8?B?UWpaZGNrbVVwa1cySlFrTXI0U2p3RVJTdlBDS2F0bUNVSDlVeWcrMDNIY2dm?=
 =?utf-8?B?YTF2amN1QXI5bmZmL29lN2M1YkVpa0NqclRNRlRJemxoeDdUV1YwSDQ1aU1Z?=
 =?utf-8?B?TUd5YnhMQ2dZT2QyUUs1T0ZneHlpRGpzSVNLUmUvb0RRQW1LWTJrVER4S2JH?=
 =?utf-8?B?aHdJeDE3eTFPUUFaQ25MQWVMcVdlWDZFRjRHVDBjYlp4N0dRS0kwN2g0VjZT?=
 =?utf-8?B?MWdMWXVpaGRnOHVZbFE2WThMYzUvUytoU0RzMndvQkZXRWdtc05HZGpRTVhI?=
 =?utf-8?B?MHVGQWsyYmlMd2pLWXEyMi9sc0VlRFY4OHAyUHZMTXRzOUlCOGowRS9sNFpJ?=
 =?utf-8?B?OG5uVklrQWtDdW1GSHJRRGJVMVFOQkdCYy9MNC9mRW1iZkZUS1J1aVMyUXpF?=
 =?utf-8?B?amtBSE84RDlkNEg2WmN4Z1AvbTUzTDNKUTk4UjZmMW5Ma1NmNjB1aUZxWDAz?=
 =?utf-8?B?VHFDQ3ZQWGpxckNVdmJjbmxEbGg5d0ZUY3hFRSt5RDczdTV0a25XZUZrNjBG?=
 =?utf-8?B?Y0hPTm5CcStLNGhlV1VKTncyVEI4dVFsN1VPMTlxMHZnZGpKRDVLL1BiWE5S?=
 =?utf-8?B?VDFNeUs5eTRxME05REx4MlpwY2JEc3dwcVNMR0phSktsWUsxSVVsNStnQlNH?=
 =?utf-8?B?Y1RENzdzMFpVcUR5NlRoK2VJSTgrT0JQdFB3SDhjdUdDK3NZYk0zOXZ1VEVr?=
 =?utf-8?B?d0U5aHhYc0NZWFAzUFpNbHFCeU5JMGJjak4vS1A5bU4yVFo2ZVVWZm4yQXcz?=
 =?utf-8?B?dE9idjZwTG9jVklSdEtkWldsc1c2Qi81OHBTV05VT2FETkZaRlQySGdMZ3VK?=
 =?utf-8?B?M1l6cVdVYTc4S3pOczU1cnBSbFZVVzlNY1RBa1BzZURUbmlGM0V3ZHBEY2Fw?=
 =?utf-8?B?N2p1L2hGVkFVbDViRzJ3Y1dlU1FpMzhOcWg5RExPN2Q2RlJOTy9ZSGw4NFdw?=
 =?utf-8?B?Nkp6YkVhNk5VN3Vzc3FyUFQ4T0FSelk3Vk91a2hyL2t0eDlqMXIxaFBUbjhL?=
 =?utf-8?B?NU9xZi9pMDVFbzh1WERLWFg2SGc5R2l5K2JKNnBTZytMbjRTaXF2Z3gvZUNh?=
 =?utf-8?B?UC9qeEZ3ZG0vV1VpU25relJrMlczMXBJcWlTc2FjcjR1ZVZSU2tnMWdSWXFC?=
 =?utf-8?B?Q1R2a0x1ZVVrZ2FEMHkrMGNlaDlycUhPRjNBTjkwVGxQMVU5RWVIdG82RUNv?=
 =?utf-8?B?c0tIRFZoR2RmL2dFTWpDS01UWEpCbVlLMGtHcTNNbEhUOEdEUi9mM2l4czhI?=
 =?utf-8?Q?PYUdCqDv+jc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXplYnBjSmhxTXJyM1lNanhPdnZ2NXFZYmRPUTRRaTk0b2hCWVM3NnRERVQ0?=
 =?utf-8?B?NDE4SHZwRVc2VWFLR0k1bFVwUHlxVk55bExrQzNsaDZ5ZzV6RXhRcFZJYURY?=
 =?utf-8?B?bFlCb3Z5d0Jqam9EUjFHYUhMQWkwN3Fqb2ZSMUlDWVRIa2N5MDJmSHVZdjZC?=
 =?utf-8?B?bDJERXNsTzRZRWV2OG00b0JKRkl6dlZmWVZobXFDSzFWRUN1Tk4wK2tiekQw?=
 =?utf-8?B?dUg4WURFdkZreXhQN3VoTDk3ZWJKMzR3SzZHZUZUcGZxUm8vbDRTVkNXZGFm?=
 =?utf-8?B?OWxRbVN1aVBVdjUzbkJ3RnVQVjA0MVhZb01ZV1FYVk1USm0yVENMRFpYb0F2?=
 =?utf-8?B?TFIzSHFTVDN4Y1UzMFkzUEQ2S3ppNWUzblFmd0F3YjVYajVMbzY2RU5hWVUz?=
 =?utf-8?B?ZldMTTZTUUl6ekJVZS9yNWdWeThnZDFuTHFvQ0hDZkhvaG1tTFljWGxzU3gv?=
 =?utf-8?B?bFg0aHYwaSsxS2RVaERWMnhrM3NXU2dMRmxycHJlZmZQc1VjYXdaeUhsZUFL?=
 =?utf-8?B?bGdNYzFLVmxpWmQzVVhDWTN2azJUNFkzMlkyc0s4eDdyUDRCSWxHSkZpb21n?=
 =?utf-8?B?RHZCaFM3TGE2U253N1o1RlRqQ0Q0QU00MFozOUd4S00yQkhaSjlwQVZsczly?=
 =?utf-8?B?Q3ZxMXgwZTNkdHBQSWdaZlVobWxRMGpEUjR3NndBTVpDcFFYbnVyMS9HMWgy?=
 =?utf-8?B?WUZxajNqUFIzdmtKMmQ5RDlpaUluZkNjYkVmMUhQaVM4NUMyRjU0ak1NeFhy?=
 =?utf-8?B?a0ExNnRZd0lPYnY3dTVndjNhWXhLV05sTldIbkw2NW1EN3JGMnhsNUtqR0tt?=
 =?utf-8?B?SklEMVVjd1NVbnQrVGFLM0ZaT3d0a3ZsS3ZKbTh6ZDFtQnIreTBIeDJ5NzFS?=
 =?utf-8?B?NEk0Y3Q5TXpmNk4yR1B6ejVRVWZPUzJhdjRBM3FpNWl2SEdwSnFCY21HL1dK?=
 =?utf-8?B?cFlBNWZxdkoxK0hpekdoall1dmdkdnVlOWt0TWw5bCtvYWlTdkZmN2JyWjUx?=
 =?utf-8?B?d0FVWU56ODhRbll5SUpidHBkcUZEbUdUY1hVRnFOTjlhTHJjRUVycGREeDdt?=
 =?utf-8?B?VzNka2xrdGd3emNkUENKczhhenMrMVM2MjV6eUViVXlhWnpKN0xLZGx0c25U?=
 =?utf-8?B?LzVKeVE2d0RvKzBsSkU4QitJKzNtRnEyNnNMOEV1OThiRTEwcEp4QTV6OG5Z?=
 =?utf-8?B?ck9Uc2VSLzhHZlEzYlJ0azBiZzlGcUdyNThTeGpFQ1QrNktEc1VGWXZKVHFw?=
 =?utf-8?B?T21VeCt2RTdvZTQ1TUkyY1k3VEh6Sy9NY2JURzZrOXR6MktTUFgwWjlMbEw4?=
 =?utf-8?B?eXNkdVJKRjdyZFBOd2RtRE02YXlVL3FIcnY2VUpSQ1l3WlFOaENtV2V1ZEtH?=
 =?utf-8?B?Z1Zvc3R1WDN5Si9CWEU3eGNSODVjYm1EWVFpaHQ1MmFGS1VOYzF0TWtJZXVs?=
 =?utf-8?B?TWdTMU93OXNZNFVtYlJhUDRYeFpIWHlscjRrUXFDek9NYmNaSC85cmhsc0xr?=
 =?utf-8?B?MllScG40RkhwL0s0N0JkTURCKzE5TEduODFCM2hhZ1BKRnhEdVlVYy9SZDQ0?=
 =?utf-8?B?WDhqNXdMTndWNHZ5RnNKV09Ja2NzWnNTbGFBcFkvNmVxT2tYUG10eGg3T1M2?=
 =?utf-8?B?SlNjYmNTQy9JRUtsUGRCdTlqL015cXhWdGpIeFE4d0pkdFNuMFdoTno3enYx?=
 =?utf-8?B?a2p5bGFiaVlEMXkyYWdiOVpqYkFrbWZwVUlXUUpDcUNNNFRvWEY3S1FCaEdT?=
 =?utf-8?B?QUZPSWczZWRHZENaQ0dQaUJEWDNmT0FGVlZTaTVaOGcwVmVrNFJhMWU4Qm41?=
 =?utf-8?B?UUtmQkJwRzFialpkVGZrN1lnWDEydnBkVTBBVS9JSjR3M3E1ZmpoaVlsYnhQ?=
 =?utf-8?B?L3RkN1ljQ1lVVFg3YktyaUxqQWZKK2ZPaEVJZ0hvMzNmZit3MEpXWVZzL2I5?=
 =?utf-8?B?TXZzVklLbUFwOWQ5N0I3dWo1VUVyU0d3M2Y5ZzZVOHJzN1A2Qi9CKzZxTDR6?=
 =?utf-8?B?ZXdqYkZ2OENzZysreGEvOHJuM1Q4MFhMa1NWYXhkSUFrK0VXRGlGckpiamc4?=
 =?utf-8?B?cUFZMzA2cGIwZ3FxVXhNYzl3ZlJnckIzaEUwL0FPV2d2YUhYSlRyZHpONnNo?=
 =?utf-8?B?Y1loR3hHUGdQdUt1bkE2WUMzeGNLS3VvMGYxSUs2cWpPK1l0cHN3SU1ZTlVn?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dee9b795-f47d-4610-3cb0-08dd7c447c7f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 17:39:34.6107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXEvTuSStLmR2JiDfVkFJKMtf1wMwu10Q1Ch5IHURCpiVAbMFE3RqSZMNQ7ABLhfFsF+mvjR5jA2KfbwlxaRmxd3VjWqBW72SKosX1OQ3iU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com



On 4/14/2025 2:18 PM, Jakub Kicinski wrote:
> The C rt-link work revealed more problems in existing codegen
> and classic netlink specs.
> 
> Patches 1 - 4 fix issues with the codegen. Patches 1 and 2 are
> pre-requisites for patch 3. Patch 3 fixes leaking memory if user
> tries to override already set attr. Patch 4 validates attrs in case
> kernel sends something we don't expect.
> 
> Remaining patches fix and align the specs. Patch 5 changes nesting,
> the rest are naming adjustments.
> 
> Jakub Kicinski (8):
>   tools: ynl-gen: don't declare loop iterator in place
>   tools: ynl-gen: move local vars after the opening bracket
>   tools: ynl-gen: individually free previous values on double set
>   tools: ynl-gen: make sure we validate subtype of array-nest
>   netlink: specs: rt-link: add an attr layer around alt-ifname
>   netlink: specs: rtnetlink: attribute naming corrections
>   netlink: specs: rt-link: adjust mctp attribute naming
>   netlink: specs: rt-neigh: prefix struct nfmsg members with ndm
> 

For the series:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  Documentation/netlink/specs/rt_link.yaml  | 20 +++--
>  Documentation/netlink/specs/rt_neigh.yaml | 14 ++--
>  tools/net/ynl/pyynl/ynl_gen_c.py          | 96 +++++++++++++++++------
>  3 files changed, 92 insertions(+), 38 deletions(-)
> 


