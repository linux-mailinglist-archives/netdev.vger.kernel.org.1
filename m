Return-Path: <netdev+bounces-150878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E9B9EBEAA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A636C1640B3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE9C22686D;
	Tue, 10 Dec 2024 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jD8Jhcxe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B53225A53
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871245; cv=fail; b=kT57aYzNvatJn1qSQC3j9aBH/d4qs/IiUa14ZAx+HopFq3QZ5+epyVIvC+eYqVOB8b6qZq4L96tV6vLogVji5+oXIJxa4hg/k32x/JN6ryxsslcc+Fvl7bH2HunZcR8iqn2koe7GcKzZ8NqGEKyM11/RpkmteI5NZCiSZBfEIXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871245; c=relaxed/simple;
	bh=I6RozDdjZBS/PPnINhcqJTrrSWjkE2vp8v9MXMqEGWs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YKQQhNi15Tt3uAfO8XAuEylN3Xhy84l5ssuw0qArYzHZNBRiSwu3M4Lx7N6L9Yn8Re4kJeOMzvBjLS7b1mAAb/WgKzkqt05ufBj6uQzceDgrMm1mlWTIU0ZLnpGK7OiboWcIwZQWcAM/JiJc3NN/LmXd4UJRpcus/7u0x0FhFb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jD8Jhcxe; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733871245; x=1765407245;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I6RozDdjZBS/PPnINhcqJTrrSWjkE2vp8v9MXMqEGWs=;
  b=jD8JhcxeJHys0YU2SGYovOd8vZuULobn6e2/Go8pXM840/zi7oodLMM9
   +CetsbuhlfU5LxXPuDbx/E+r0tFw1lb7iDmvqAmg6DKIpwfSEt97OVPV2
   BZxeVilKOWXOIq0aF8V1xUnAvvhoKs97cKub1U+yI3sjzlzdOql3fVx8Y
   L8jjscasv9l5qeE0w/v+/GAJQijgeVZx7OF4FLMomGtss6TJ5GO7zxXuD
   qaOHCCza3+AIokXavY9AkPP9Go2MbWK5mUf0PR7RHV5taDl846/7CMSSU
   bEHlHtcLwv0RCnwOM2vCj9VBAd5TYAWSEwbP7EjOFrXsxCvntm1LVq0VC
   A==;
X-CSE-ConnectionGUID: oZUQIFpCQkSbG3w6kiY6EQ==
X-CSE-MsgGUID: FANaXG3TRcKQr+2g48UE5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38018621"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="38018621"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 14:54:04 -0800
X-CSE-ConnectionGUID: Sy2PiMGhQH+LCTXUqtMHwQ==
X-CSE-MsgGUID: E1Si3Rt+SSW9GYnR2lYuEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="95625279"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 14:54:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 14:54:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 14:54:00 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 14:53:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/KJIXzNWYJzHNJpSiiFIySEjDx0RZtDdCcAVy07c2HCdwsbGV3Cqq3ImoKx25rzSF4JclAbzVoaU/4ssUMe3r392k+GyFjMqu+rMZ8mgtblyBsqMcEvr5mdJkEnahkwsil/bjvinOiDnPRrZ4vQyMiL2lp/vLjCSs8LAiFRyhU/QAq0CHm2ukNzeA/5snyMyeR9Bn6vvY8Kh1wfFhweQBmt6e03fhLMZX90qVbbmfQELKJU0jL+qjlwSZzaMSWDXkZAJ2KRLnH5K3/K/f0oyX6EDoYYY7DUyR2Sm+mW5h9/eAIgxensEiDOC2rE8ub4okWdiCx4qrlvshsmBoaGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvtjpL5Xvq3dcaxb3jUmlz06lkn2nJgU/lx3lirZEnI=;
 b=Sthd2CkSpVevM8IG+WJdieP5N4CN6cuxw/NKQhF8PDfIVrh3PWjO01MrDX8MerI46t257N26efIVUFEtEUaKj0GIh7Zwds7kEnfMrIAGbqKER8Bx6kaTC3Ofd0bz+cyAJgsfcuFqHxfNhZOnPMCh6U4s0Fian+3qTkwoUNcNts3FEPKqI1Abj98xVRoydJUm+Y549Hdp2cIO+dt42LFS32Lk6Pk/Xw+LmTsa8vaKWjUek8sQK9zekjMMgm/Rcu8u6I6n925r4a161QqQzERsdI9k0mecmivqhvTsPPbVhQyIA33JalTj2vM5YmldSr1ef80/xWuPwm9hk4BJw7uhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:53:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 22:53:50 +0000
Message-ID: <108b6d70-cb06-4fd7-9cb8-f926a1b0e363@intel.com>
Date: Tue, 10 Dec 2024 14:53:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] ionic: add support for QSFP_PLUS_CMIS
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <brett.creeley@amd.com>
References: <20241210183045.67878-1-shannon.nelson@amd.com>
 <20241210183045.67878-6-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241210183045.67878-6-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:303:8d::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e57ee3-03d5-4a27-9181-08dd196d8385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHd0NFUrRnJIM1BPV1loT3BFN0NRbmlqalhXN2IzUTJUZ0tCYjdKTDljMTlu?=
 =?utf-8?B?MUd3SVJvVU5ialREd3NiVWdkVUhjZDcwRU95WXMvS3RReFZvOElibFpoOWt0?=
 =?utf-8?B?Mlg0WlBWMlYrTzl0RFFiSE44Si96VGhLQWNJYWhVU0E1VDMvUjgxTHpnK2Qw?=
 =?utf-8?B?MmhtSTVraDdsYXROYXQ2cCs0YlQ1cHJxanBoQksyU2IyQitQRFdhVllWZFo3?=
 =?utf-8?B?YzBqYjl3dHYyd2w4THBCVnBTSlVhRzA4TW1pN1U2a0xIRzl2bWlYMTRiOTVE?=
 =?utf-8?B?TmxpWDYxQ2wrajNKQWxQTmwvOFMxc09pQzZXSnNoVGM1RG5wQ1BXeHlCdFlw?=
 =?utf-8?B?MytwakY1MEMyWWJMMXdyV3Z3b2U5OHNCNTFBRXozR2VWYVBaendWQkM5aDBX?=
 =?utf-8?B?eXBkUy9uU2ZFcXlqUFdvb2xEbmJ4M3A2SUZjN3F6NGdUNHZSMVFWSlk1N0lE?=
 =?utf-8?B?RUQzazB5b2dMaWdwNENsd0lIMlRPTzBsWC9YbVozZWNUVElBR21yQmFRVjBn?=
 =?utf-8?B?U2x5QVRPOTd6Z1BjZ2s3YUJaUEMrNis1TWYyU0M3SGg3WHZjczRXTkdwQVVF?=
 =?utf-8?B?V0x3V21SZ3JzalZibFI2c24vZ2xONzRibWJrcTBSbjNDV2JtT0RXQUdtbUZE?=
 =?utf-8?B?SDBZVnZvcVNuNjBBclBEcmFwcndXdmRiMGVPTTVnMkNHZlNyaWlUQmtqY2I5?=
 =?utf-8?B?bnI5OUFSeDJ4aG01Uzlaa0NQb09Sd0JJY2IrUW1BVlpiclozOFBQNTJpV3R2?=
 =?utf-8?B?V2VjSmRMaHBmZFFIdWpIbmJhSkdVYksxd2RoYVN0TnRseXVUM1dKY3Ard1pu?=
 =?utf-8?B?cDJrMDZQVk00UTBGejBuNGJkTWdCUnlaTjhMUGNPbjVNaVZqcUVJOC81NW95?=
 =?utf-8?B?Nzl2YkF3LzFxMFBCYWdYUVVCcWg0U29CTU93YjR5UmdJcGVzdmVmb3J5N3gy?=
 =?utf-8?B?czk0anVyQUpSUjloa1JNMlFIR3VWMmttdm1xbFVHR05oQ1dWR3I1enVPaytq?=
 =?utf-8?B?Zlp1TGVqL1V2eFNUODk1LzFOZEZSOWY4cE81dlN0MURGcTBoREo1ZVU3SmhO?=
 =?utf-8?B?SkpSRXg2YmdpUnVRK3NzZUdKY0JTaVMvUjgwVENLZ3JuQ0Njcno2QlY5OWY3?=
 =?utf-8?B?Vnpnd0dLYk9sUUhWbnpvOTdWYnVSMTZHaFVIYjM4Zi9aRmJsRDBpQzFUelRZ?=
 =?utf-8?B?SklrTTFYME9lSHpwbldvb0RPOW90ejNBQ2JSa3UzOUxJV0ZOMFdSY25vbGVB?=
 =?utf-8?B?MkdOQ25hcHRobUw5QlZzbUFiQ2s1RFhDMVYyeXd3bitCcjFUcnBVc3Q3cTE4?=
 =?utf-8?B?b0xGVlFFT3p5RGpEOHIvRmRZNGtKeE1JQ2VvYlF1clpsZUZwREo5RlNpZHB5?=
 =?utf-8?B?aGdkUjZvTXh1Y0pJU3Q1N2xGeWM3WFU4bDNLNVlVWk12NmQwMDBTYTJaaEIr?=
 =?utf-8?B?a2RhNzVxK3dTaldEOTZkTHBlY2RsdFBuTCt1Q3NuMW5IUS9BaWp6N2VyWlJm?=
 =?utf-8?B?S2grV0VwNGJvUVFSSWhRT0pnRU40R2R3VnlWOWlqQVJma1FrMTBGTTZYRXdu?=
 =?utf-8?B?NXJEY0hNNjE4U1VpY2M2ZWE5S0RjWGpka3ExekpDeEQ0Y0ZGQUcrRmx0M2pk?=
 =?utf-8?B?c2hYcDJTQUNMUzZvdUp0VlNXb0w0ZG5pRmRPTVNJU2M3SFZSeDd5Z3ptWXox?=
 =?utf-8?B?QmFpdndpb0c5bjJNRHNQMm9iTUMrZXZSOERDVzFTby9PTXhZTFBkMWRZSlFP?=
 =?utf-8?B?bXdBakR6WFJsbS91M2pGU25WMGpyRlZPMGdsNFowUEhSZE1UN0ViM2Vhd3ND?=
 =?utf-8?B?bnQyL0xFY2lrZzJqL0Yrdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1lac2dZcTVJUVhGcGhIUWdvNk5COVAwWHdKcFJnVTUrZHNkbFhYVHNQVFF3?=
 =?utf-8?B?K1VPODFqdHc5cjJxUEZRa0Jvb1V5Mm1STGRzSmcxakJFTklrSk9aOWpPeGNK?=
 =?utf-8?B?U2kwVTFwNWNRc05lVDdsb1orTndQK0hGUlUyTmlPekxwUzJ0NlRkVWM2YTZk?=
 =?utf-8?B?Rk1IMjNxeExEeStNQkdIZjZUd1RzbW5pSWRDWExDNTFGd2ZncTRpcktaai9x?=
 =?utf-8?B?cldvMG40RmFWaFhpNE0zRmhKdHJOeUFoajdCQlREcStTdm9VNVRmcjBGRjBR?=
 =?utf-8?B?YmpaS0tYTkZYdGNuaXNYM2UxMVRLMm5DRmZBeVRDSGE3THA5UkRGVGJWMXB2?=
 =?utf-8?B?OUpzOWd0aUlMUk8yMTFYNWNHRmlaa0FMRThmTGR0Skl4TEpkZkJ2U3FBZndi?=
 =?utf-8?B?TXNiV09DV05wRVNIWjNoYkJ2Wko5QjFGNzFiQTFleHBZdytLMTFORzVZTDE1?=
 =?utf-8?B?bDM5U0RXR1FyaWxNYXZoa2RTM0doYmRoaUo1TFFoVzFsZHBJZUpxbXFrM2Fh?=
 =?utf-8?B?ak5vQlpteW1BWEk0OFNZQ3J3d1FFTkVpNGNRMlBsSHYyKzFjYjRLM3BkTnk3?=
 =?utf-8?B?cEt6S1lyZFdWQ0FUUUNLb2xrTldvNEdNS2tXMU85blJZaHlPRGRKWnA1OTBE?=
 =?utf-8?B?dElhaHZVS2hOR201SU55cjhZZk9uQ0hmY0g2Z1k0bEh1b0UwMVcxT29kZGsy?=
 =?utf-8?B?Z3JiYUN6RWhqdld6WDhrUHdXdmUwUjRDQ09ueDNOOVh3Wm9kaVNiZ3BRK3h1?=
 =?utf-8?B?aC9OdVV0ZVZydUdFZUkwNnA5RDQ5UnlGUGptRXpBRUgrM1NEOXB6ek9SdFdK?=
 =?utf-8?B?MVQ3Qzh1a0NTc1A1M3RWbFJLRi9sK2VYb25mMElrRklBS3lMRHJqQWgvL1k2?=
 =?utf-8?B?Sjh6SGpqbmovdUxHQ2ZaZGhTNUViSkFCUjdPaHBGSUpMRDNoL2FjTHhhUFJz?=
 =?utf-8?B?QmJOdDdPQ1k1cHM3ampsa1BLdHk1Z2taZTh0c1o4TlkwN3gvMFl2NnRvTTFr?=
 =?utf-8?B?bzc2UWlnY21wOTV0eEFkSURWTDBDWlJxMnB0L1lyRC9qbGZDdzBjOGlheXJu?=
 =?utf-8?B?V1lxazVLK2N0ODFoMHR6VkZwckpnWHBwRXh1RjFialQ5REhtL1c4bVllUHhP?=
 =?utf-8?B?YWFJTkE2dGsxYnNxVEtna0ZkdDNNQm9KTEZxUHJUSnNtMmNmVlF5L3ZwRkVq?=
 =?utf-8?B?OWpTYXQyK2FmUXhjakl5TUI2dGJuR0w4TXpDeVNBWU96NlZncWZNQytjY2NC?=
 =?utf-8?B?UGt1WkNMWmlhOG56MG02Y3dHcDUzWU1rZ25pUGZKS1J6N3pZNEpiMC9ML1ZW?=
 =?utf-8?B?elZEMDN6SVljZ1ZKRHFya2tmcXJPY1lLVDlSYVJpOGMxdSthZnhqNk1WeGlu?=
 =?utf-8?B?LzJ5ZFRrRUV6WnZOUEpDN3VQNVVoV1QrOEcrRitJdmZvaks3clMxc0JDZFVk?=
 =?utf-8?B?Z0srbDdEWXdqTDljUjd4Q0Z5ekdsdGFNejBLSm42SS82SllxdDJ5OUJESjN6?=
 =?utf-8?B?MGN5a0djR1VDWnlDRnJIOHNMekJyeUFoa2ZaOEhuUzk1VkJMUGRXZEMyU2VJ?=
 =?utf-8?B?VmdMajRTRW1DODd3NGlDOU0zMExLTi9wM21mWDRmdmx5TSt5NjMrUFpJempu?=
 =?utf-8?B?YTI2OUoxYk1pQTJLQi9OSXRiZ01qcElIUG5ORTk3ZVZtZ1g3ckRjN2RxcFQw?=
 =?utf-8?B?L0tlSzMzVWhuNVZJQkROVk9wdlJpNi8xZ2xZdVo2N2VEVVd2bDRyNnZyVnh6?=
 =?utf-8?B?c0FKYmpzYTdvVWpUaXJhTXFiNTUrL1M0dlN5V2JaMTJ5aGNOZUM5eEc0MVFq?=
 =?utf-8?B?dDVPUGdxbDNlT2JDdytmeFoxZWtUSE5PSmFXOVM4aTQ3RGx0VjFFYlZOd0tU?=
 =?utf-8?B?dWRxZTZIdkk2WWh2bndTWGdySHcwUjNDeXVsWDFzTllWaEZkZnhXZnZENnZp?=
 =?utf-8?B?Y1RwaXRkemhkWkR5OWE4K0ppeWpoL1p6SlFBQ0tIK3RGYVJlZ0F6OHZuZ01s?=
 =?utf-8?B?ai9MUmVhUm9ucjRadHc5YjJHeEsxaTFBb0hjRk9HaWVzTkxkeHI5M3dzYkdJ?=
 =?utf-8?B?MVBRRmJMQzh6ZHdlejRsUDlMZlEwMUtvQlorVkd4RVJibG1RV1FVRXRDeUFp?=
 =?utf-8?B?dnRzVWJrdHc1dnJ0SmVScUFFMlpyR1Z6NG1nZ3V1aERHSTNzUWN1Vk9mcTFV?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e57ee3-03d5-4a27-9181-08dd196d8385
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:53:50.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adEqcCcEsZssRVJMYAbs7ZGa17o39HaIJv1CIMphqS50yvche/RtPnz/y3SdC/4j3qBcomqUOJG4jCDanxiU59IcZnQIBJi5JfenN3qU7E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235
X-OriginatorOrg: intel.com



On 12/10/2024 10:30 AM, Shannon Nelson wrote:
> Teach the driver to recognize and decode the sfp pid
> SFF8024_ID_QSFP_PLUS_CMIS correctly.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 272317048cb9..720092b1633a 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -968,6 +968,7 @@ static int ionic_get_module_info(struct net_device *netdev,
>  		break;
>  	case SFF8024_ID_QSFP_8436_8636:
>  	case SFF8024_ID_QSFP28_8636:
> +	case SFF8024_ID_QSFP_PLUS_CMIS:
>  		modinfo->type = ETH_MODULE_SFF_8436;
>  		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
>  		break;


