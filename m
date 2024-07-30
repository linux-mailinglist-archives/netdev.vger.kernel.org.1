Return-Path: <netdev+bounces-114082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A813940E3B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03681F24567
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBFA196C9B;
	Tue, 30 Jul 2024 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7baNdcY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD11195FFC
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332978; cv=fail; b=kM8ISM7tDMtkYTuEPeqnCc+AXt/pmlFbyG7uKU/LlS/GeB2ZRTEKqNv4UfVQqLmfpnMcYHAmt0dqStkiW6/2ywZXfvKgQ0CNu00X+e5N0sb5RZh+gUH3sUUiPWXTWTKpbjWGBxzhTp/JOGBSY2XAWXqqUEkQZx3ltzTxogI4Ee8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332978; c=relaxed/simple;
	bh=ySzdhaptILu3QjBiDWeK0wMg1P2AjkoSsjOb8V5UNbc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZGM4WptIdVY0ogyfMTC9VHCa3zNC9Y59DPVg1dbfTecCbSlxmq3+PpXKFwi+BjZJjNrtPQEgJyWdvg5X656UeBta+0c3VxtD3s49It+CnCIq0Thb4kJuiBJ1k4yAvr3pYW8gGOFE+1oubCYWvpv07skQD8z8C41KgJjeyJeDT/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7baNdcY; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722332977; x=1753868977;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ySzdhaptILu3QjBiDWeK0wMg1P2AjkoSsjOb8V5UNbc=;
  b=m7baNdcYX/hruBF1cgwL6ryPtaAm82CEz+/YDv9h+5kpkCSKUZEkAwCE
   9XZMU/cvzox1xCpqmhxVxB0HqYpTne8HIJ68NdwUd5F/zg2ntANwopeTo
   nzD8HFrw3NLN+Vy0FTj1U0EAkyp+74xwvX8+CQ04f/+/JAHztRfInjecr
   haIXpH0rZ1W5AA0ppJAu29aNM8SKzcRwVSV+WaSEZjZYp2wjzcoL0Zs2U
   mH+TiNgneCU446yIvQpVyjQGFeTVXVflvCxuNU0o934UyMAgbxrRL65uZ
   /Il/9dbo4Yob0m/kZTT5iZ8EQ0DvThlVplEe8qlA84yN08S0NX70pTZxe
   Q==;
X-CSE-ConnectionGUID: rJwlmEeaRZ6a6mz6BPUFpQ==
X-CSE-MsgGUID: znamyH2VS8OS1muroJOT0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="42663895"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="42663895"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:49:36 -0700
X-CSE-ConnectionGUID: UalmWWOkQgKUMJ/OdW7AsQ==
X-CSE-MsgGUID: L4FuhqcbSjaoZrHzIav7Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="58418296"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 02:49:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 02:49:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 02:49:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 02:49:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whC7N88LKdrljsoJdO9OyxdWqtFozyop1aasbw3nyz7/K3PdBeQ/uryfY+8JgJ1Mbx1f5nRttpBzagZUpKjfVawi40ch2mxN19fux4ynmfE71YO3ShnNpykdgMe0b9T2mcGnMHbne+Fvs4RmoXGFyBclSY054ZftMJP9qOzCCXqhi8n/YkYIRxMqgbJdmKHF3S5r0Nrv8zt2coHOoTKzTC693w+TCUg52o3lp+UO9/hGFH2t+FiZYBSy/A3OxRUXcjBmO7ewxd4q7fEykovLx31chi3P6x0Y0JwJo3ZXTVIKeCtHsmukJGLWHAJ1ggHr7Ve9WEWb8rcclMs0TPG/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lmI70Pp+/o4tHD96t8MMFHd8VbwQIVJ31l0aZd93cg=;
 b=qO1k6/y3JjkcfI3ml6uRIU3u21id6IfNRaXYRBCErSyZLom/+S+TvCy8YFJzZ780cm1KEeMB+63YgPcClvF3XBxjj3A59B87EJVWgC5k21mTHVdiZGqYeoDcSvKIH05mC4mxWi81/X34Yaxwv2kAuMqm1xn2KAZUfGl6kVuKuZCxlGk0mJKpBpEngYSoAOz6RG+mYwgpIons2IJhExTr/hIDTZai9MFCmj/mr9wZh0aphjBWXmP9R4J0MrN6GOQduzngOlbf5aJtgt6ELrRwfbO0bpGxYXR+Inhr+qmxD2Prlk73JvIUhdQ5Z3Yfn4IwLXIB1H+mw3ghGug/CoC6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 09:49:32 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:49:32 +0000
Message-ID: <15b98214-eaa0-43a1-85c4-7105d5529440@intel.com>
Date: Tue, 30 Jul 2024 11:49:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 7/8] net/mlx5e: Fix CT entry update leaks of modify
 header context
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Chris Mi
	<cmi@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
 <20240730061638.1831002-8-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730061638.1831002-8-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::9) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fc7160-11b0-463d-48e2-08dcb07ce958
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RktJdmY2cFNUVm5QZExRNGkvQ0kyUmllSXRMTkYrRGNTaFNkVGg1WGVsbEFI?=
 =?utf-8?B?T0tNZDBtZ2ZiVG1RTFdJTXJMMHpvaE05K1VFNk9oTldQRjJEYytkc3kwWXB2?=
 =?utf-8?B?RnlLcVNnaXhJMjQ5WGcxbkEra0d0U0pKYjVVeDIxZk5tNlUwS0NSWmdEc0t5?=
 =?utf-8?B?cnBndGZVU1RpSStiM2w5OWpJZXJIS2o4MmZEK2FSVHJ1cUk4allrS1BXODgy?=
 =?utf-8?B?bVlqb1VnWVVRNDh5aDU1bmg4cHdjcGhNUlR0dGs0Mm1GN1JJZzBiUEJpUmY3?=
 =?utf-8?B?aFo2Z29KSEhudGdQaEUxSzhkMHF3QkE5L1pqeFkyUmhPazNuSkxmT2pnWkhh?=
 =?utf-8?B?NzJXMkJRWTFYblRXR2JFNUsraTUvNVk4N2pXTGlsUDlMM3U3b1VqbHhhRVgy?=
 =?utf-8?B?RFNBS1NqU1dxWW1ia05tSHo2Tyt0a1dZTktMaFVqQnk3UXhyUWFnckRJS3NN?=
 =?utf-8?B?WHFDVXlyanpHbldoMUFlT2dONG53anZUYzhWMzhDeDB4M05xS1A4aVRleUps?=
 =?utf-8?B?VHk5V1gxR1lVZTVlaDZLWDk0cXFuUTJvRmgzelBWVFBDRVovekQ3NVpwNnVW?=
 =?utf-8?B?aHJoRTh5eGFSUm45NzVXaEc2NXlQZWxveHhpc0ZuOWY1aVlTSmp4Tm9nNEox?=
 =?utf-8?B?cTNmTmFOVmR2aDJLYk5Sd2x1eWd4anBEdzNWUm85MDhrK2kxZEhzaEFhRFF0?=
 =?utf-8?B?cUdPOGlNeTdmQndtcWh5dzRjTnUwdG9vNTIxeUdFOTlMUnRJd3pJSnFDaGVl?=
 =?utf-8?B?K3dVbDZ4UkJzR25TWFFwZG1QNFJ6WGF0TVZyUHphbWJxV0c3c2E0N2YyRE1R?=
 =?utf-8?B?RzZ3VU5oa1VFb25aN1JtSy9yb0pSdG84VFVCNjI2dGtTUEdrNlNqd0Zla2oz?=
 =?utf-8?B?akJHdXNSYjA0TkNadnJBbGQ0SnJhQTFCWlBJRkl6SUlGQks2eEpQSkxYTU5h?=
 =?utf-8?B?WThHS2Z1YVlSQUVSVjF4WnM1ZkwzSmNCTTAyZ1gyL1VUbHhQb1hlR0d0aGpt?=
 =?utf-8?B?UGc2aDZ4QUR6b0pFQmEyM1RYZGo3TGxUcG8vRXd6a2Nua0F4V0RJdHZqMGJL?=
 =?utf-8?B?RUpzOGNuZC9rMEJheklSam5HNzlEUEhnOERvclp1aWhidU5oTkRMMmQ1Y2tw?=
 =?utf-8?B?bWR2WDdhRXVqNlBMTml2SjVhRlk1aGYyeFJPcTlQalg1dm1YQU10TndvaHI0?=
 =?utf-8?B?N0V1cVNXT3ZTanBVeVF5RlNDb2R2TG8wOE1aSmJHN2JVNjdlUG9WazEyR0dm?=
 =?utf-8?B?Tm5FTGRDUDJhUWRQZTc1OHNEYjZhRWFsM1BxSUU1WW5sMVdPY2RjU0F1L25t?=
 =?utf-8?B?OGxmQkFvTWdLZ0dNa3F4QkRZbGltOUVYUDFqYS9VdWlNSzZ5dUQvMFE3dUpT?=
 =?utf-8?B?M24rK25mVDI3b1E3NGZWK0x4NWVKTlI1OHhrRGN3MUtaRjRaYkFwZFgrcGNP?=
 =?utf-8?B?SWxlYzc3U3Zxa3JQV3N0K2hleWtZb2RvWVcxaG9ERDdFRkJMVDRPMzU2aFZT?=
 =?utf-8?B?bEc1RUVNT2FBS1RnbFg2ekZ3aS9TRzRoMUxKNE5pTHBWSlEzdFJWY3p1Rlp4?=
 =?utf-8?B?TDJLMzJzWURkVmswQzlNTitkQzAzRUJUQnRGdGFPWnNkUlVKWWd0NmlsNzgw?=
 =?utf-8?B?NFhweTZkcUNBN3MyKzI0aWFIdjFReWdyMVNpekNJQWNUUVkxTVlJY3I1QUJ4?=
 =?utf-8?B?NGVLcEVWUldnUkdlanJiaWYwL3FlL0xNYkhPQlZHcDc3NDZSOGFWVUExaStj?=
 =?utf-8?B?MGxuNlVhNGlSTUJNREoxdCtBOTZVZVZnRTR5T1FkZ1dPaFY4YlpMVkhzMFly?=
 =?utf-8?B?OEFMUk1tQy9GZ3hCS2oxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3E2WVkzTEFhRElyWFU1VGlEemNkQ2d3bzU3aEdDY3ZGanFRbWI3MHJtK21S?=
 =?utf-8?B?Rnh5cXQ5ZU1MVlloTkUydmozVUNVN0FXREwwNjRZV1IyNjlnMm1Va0JxOGV1?=
 =?utf-8?B?MFFUVDNyTVRnZTl3cXlaNENockFkWnJKS0phNE92TkdMdmRYVElKQk1mSEhK?=
 =?utf-8?B?cTluMW5RZGd1aFM0QlF1ZFZnYi9xMkhPRWs5K2htRlJxYTZBNmdGYTBWell3?=
 =?utf-8?B?TzhOdG41Y3d2dWxjTU44UllnWmpaL0gwTk55MTdaamRDUDJZZnVNT2cyRVUz?=
 =?utf-8?B?RFZ1SU5Nai9PRHVSUjh6Z2FMTFFqcnpXV3VOK1lZcVVmQWlMQzFxaEhRdDJU?=
 =?utf-8?B?SWhXRThpM1FDQjRuTVBWTE83amRrQ2tXWnIvVUpDT0RFUlZIeU9tQ3ZmTmJr?=
 =?utf-8?B?Tk50QjRla01IbHFwUjJiNDlvcWlJWkNDWUJTak81YVh5L0twOUZGQVVrdlVW?=
 =?utf-8?B?TGo2MUh5ZndrdkxZSDc5R1Nvc21DOU5CL0lwSW1JTkg0SXZCUDFLRWhwY1Np?=
 =?utf-8?B?bXVlWVhIUTBRNjgzVmt0bzZxUGFyQy9TUUp5Z2pzcmx1RWdrVit0ZFZxcHJv?=
 =?utf-8?B?ZUVUWmdZWHhMSnN1azBkNkxpazh5UW5XcGFJQmlabDhqaWdBSk5BK2oyLzFF?=
 =?utf-8?B?bmphQjBZcGZDU01kY2lUS1IxcStBRldLdm1SbEVMWWwrdzFpNmdlL0puTThq?=
 =?utf-8?B?K2dDMWhBTzlpTGU0YXp1aVhpY1hCZlp4eHNGYWRlU3hTaVg4bkZiWG1IYURJ?=
 =?utf-8?B?M3JSUXpVNnNVK2gwdHdYTTNOL1ZiUDAwdks1citLK0ZRQlRaOE5jbk1oa0NB?=
 =?utf-8?B?c0MxYi8zVXdPV3JlaEl3YXlNWWNZakJHTFR4cmp1M1ZrRklQWldzbUVpbjVQ?=
 =?utf-8?B?N3FkWmtlblp1WElMalNqUWlLT05CTjZhY2lHZE9mbTdhUFRJbm9jc0trb2ta?=
 =?utf-8?B?S3VVbVJ4OHY2VVFia1lVaUM2SzZMbU90OWtqclVCNXloWSt6Z1FwUHNzVnd4?=
 =?utf-8?B?UWhqMjdYQWkwaDVPTCt3cGhLUEI1eWlKVHQ5cVpaN0pKcmtBR1QrTGpZNHRU?=
 =?utf-8?B?dkhRN0RtUDRQdjBhSzBzaXhUWGN3VzdpaTJPNDRIQ2FxS2VmRWRuMVN5S1FL?=
 =?utf-8?B?bzhOZTFPYlN2RmFQbVg2TCtSRHNmNWZubUhKbmJxZm5yT1JuOUtCT1d4LzR5?=
 =?utf-8?B?azJJNkdYRDZTSzkyTWJCYTBkZVdmNGZBbjFvMVFOaVhuWmlXMk1yZG1WMkVQ?=
 =?utf-8?B?WTdrUWZTbGF2YWRTbDZUQyswMVM5V1NIVnBOVVgxaUZTaE1iSG93Tkowa2Yw?=
 =?utf-8?B?ODFRL0tkWmVHNEVaNHdWYVpWam8zN1BWU0NGZ0d6eWpwYXhIdXNoTDY3TkVy?=
 =?utf-8?B?NlI5b3ZqQTFtQWJONjgvKzZtT3FycFN3Si9nL05aNVhNMGNnekxLUW5TYU9L?=
 =?utf-8?B?eVhxVWZSbnprNllBZWhpajJSaDdpOWR3NFliZm85OUdSM0R6QVZuMExrb3hx?=
 =?utf-8?B?NlZDZEN6clhYUUVvdlQ4MTdwNkNKRzJkMEJqSmVKNlMyYXJZaWl0VWl6dFpZ?=
 =?utf-8?B?Q3MxZS92VmlFTVhJa05ETG1kMGU4YzBYSE5BQSs0czhZSEFDU1F0UkVJR1Rr?=
 =?utf-8?B?aXZGRHQ3RlNtNEtTd0dZNGtDQ0hsb0hQTklhZTJIQW5vTFJESTU5M25FaE0x?=
 =?utf-8?B?VkxObmpLdEdEVzBZVUl1NTdVaW1KanZaTDJqZzh1VGl3c2kxUDBqRys2a3dT?=
 =?utf-8?B?WDRVQWk2ZTBvam45ejhHY2tLeitwQ2RMT2JIa2VvQ3ZPQVZheFpjcEdNOEFj?=
 =?utf-8?B?dHJ4WmJlTWdZUGcrR1VyVVVhdVMwWktJZ1pzeXpSYUkvSC93bUkxS2ZqTFpR?=
 =?utf-8?B?U1NDaVI5ZHQwV3VodXEwODcwVVQ5V09STWEzUVZBdXA3a0lGaFErQlRrL1Bj?=
 =?utf-8?B?a0VMLyttbHVrTVRWRFVKL1ZSSVJJS0dYVlhsVyszYVJqak5CSnp6cVlUaXp0?=
 =?utf-8?B?SjhSeVZvOE5kbWRnNmF6eXdrU3hJUk5MaEcwR1hOaUF1enM5T0kwRzl1SDkw?=
 =?utf-8?B?VkVYOHNJMktCUmdkbWJ4MkNaWVdSMFh5RU1ld1JzaGVNak0xcXFZNE1nQUJm?=
 =?utf-8?Q?/XqIxLC4RMNji5gG8fbNCRhs3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fc7160-11b0-463d-48e2-08dcb07ce958
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:49:31.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LDPk8GIqYW1aWmkoEUmusTsZ+ZsWi34j61Nm+xmC5OThthmO//NDYcT8yo/VqiN3uOBZDUquPK0ZFe0XCKIeEom5NJbfdFFDJnPdNQYP2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com



On 30.07.2024 08:16, Tariq Toukan wrote:
> From: Chris Mi <cmi@nvidia.com>
> 
> The cited commit allocates a new modify header to replace the old
> one when updating CT entry. But if failed to allocate a new one, eg.
> exceed the max number firmware can support, modify header will be
> an error pointer that will trigger a panic when deallocating it. And
> the old modify header point is copied to old attr. When the old
> attr is freed, the old modify header is lost.
> 
> Fix it by restoring the old attr to attr when failed to allocate a
> new modify header context. So when the CT entry is freed, the right
> modify header context will be freed. And the panic of accessing
> error pointer is also fixed.
> 
> Fixes: 94ceffb48eac ("net/mlx5e: Implement CT entry update")
> Signed-off-by: Chris Mi <cmi@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
> index 8cf8ba2622f2..71a168746ebe 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
> @@ -932,6 +932,7 @@ mlx5_tc_ct_entry_replace_rule(struct mlx5_tc_ct_priv *ct_priv,
>  	mlx5_tc_ct_entry_destroy_mod_hdr(ct_priv, zone_rule->attr, mh);
>  	mlx5_put_label_mapping(ct_priv, attr->ct_attr.ct_labels_id);
>  err_mod_hdr:
> +	*attr = *old_attr;
>  	kfree(old_attr);
>  err_attr:
>  	kvfree(spec);

