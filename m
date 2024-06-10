Return-Path: <netdev+bounces-102228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C58902074
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C322B238E7
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC907A702;
	Mon, 10 Jun 2024 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2c0lQvA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D991B2594
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718019503; cv=fail; b=swJjGWMnGOiNwGq+E5DH+SvC3rooecx20wC4slK6FvcezOtPRhVj60XKfXUpjD/SR8VfMf2o6PN6M8Tnx8hMz5MBEo4kA1E/2OjSz1TmgWdSvx8UOzXZLhgTLAj12Ktv5hC+BBg/+cjchiQmjC9f4Wt1G1aXDXG4Ak9DgIUlq3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718019503; c=relaxed/simple;
	bh=Py0MGvLhGofGltEb9YZvoaBkq+xNx8kcjBmuWxJxgeA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FfKqZ05KaH9CcWqlCPm2WTr53IPFuQQDAhd/Ochtz1zTDj8qp2YgQIWMlEXwpBPzeC586Z6y9Z3sM536SE5NojedDHdDz1ZXel0FtyFMeQTN8eMxxhLZEfFk/dToIbWX1fwSxwx47rz6VPVyMl9MSdwuMjWnZgS9hLHNSwG/S2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2c0lQvA; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718019501; x=1749555501;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Py0MGvLhGofGltEb9YZvoaBkq+xNx8kcjBmuWxJxgeA=;
  b=X2c0lQvA2hi+nRAYHIyg79rfK2/KPQYfMVNiQQUHMoM7sGYYE9hxkYir
   bVG9DTWyDEIWJIvQVmWZWvGCcnPYe5fG4LJjtRmW07V+JCP/s2ytSY4pE
   bnUss+5Sr4iAJ5aQbQDTPqOcj+rhNxTlS+9uSeMF3r+NsbamTg5sS2eoP
   d7u8Pqh00uVV7h+Gfl2KhCiuFUy0Kg+8jInQyypLCGqHO4/f+x1zLE+dx
   0Dm6w2tTAauTEyg9hKRmlWX1ru1TI8b3O0DohoySR6S9EPZy0V08G08sE
   D0uXcGwXb22zjrOFbpsl21eqnxvniopLNAFkhxTHbrKAjXWhvjIBgKBi0
   w==;
X-CSE-ConnectionGUID: Mo+v+WyFSJuMqHMPxCiPgw==
X-CSE-MsgGUID: 5Ab1ciPUTR6AGS4mO8kW3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14624198"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14624198"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 04:38:20 -0700
X-CSE-ConnectionGUID: AGEqeel/RZquxvnfzbs5tQ==
X-CSE-MsgGUID: kIKZUAqmTEa/EE0TwoFNbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="62205510"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 04:38:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 04:38:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 04:38:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 04:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvO/Xd/MZR5uc4sCeDcQbwtA9PTjnLqoDpw0vHhwPj4xiNz6gK1STFgNgHNelwVITeF7QeFVnAOVW5jVJMLh71ROHRcmc3nkjz4oS1mmv5JN0A6Ly8ZrzayIYIjoHm3m+SYDp4zuAOUnWtVeEuBhR1lumzbRti+QIfU6s47jlWmZaRcihjKPViwXwCL+Srw1ZWfDoyh7w6FOy+MiKmxBJkicK0BQlFoZE7Doxv3cRA/OTNl4DarfPAjWK9vzyamw9jRk5zjSSQ0Th2QFCmfX5YiupfwFpfq/fRrRNP4wf2H1mnl5V1smCXbF/5BcHpRZAV5QcV3tniJfO7Ou26jgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8qyTlg4A/cSxeppePeCtkr1ozXD7nJue6F9hMceffQ=;
 b=lY7vW83x7q3QkTPBvGe3O0CI+xuxtutlR+cHFBm9W6whIFVT6ncoGWWsFdMRhKIhk4R3fauCTFfKzD3/8UyLpadybrXp3lz38oaBy6Hq4hehMluQcyNnOxS7iPB/pm0KNMV+qpO3z1+ttLsqskKuD3WbjY7snh0dBvNw/7fCPUWudrAB3xynHu/fluPxvMPM3S+AzCgBv8wRBKzCvaJTuH2JQ0DR2C3GLwUMpJLDjcJfiathpWRLFKqw4zi+bwEQAyxbD2XXduR9Nr74Kw1z1jlnS8y4byBTptQ2HBOAGctIc0PAEisWfwin52VuW0Wg18n1JjUKS9D+jzbE7oT8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8468.namprd11.prod.outlook.com (2603:10b6:610:1ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 11:38:17 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 11:38:16 +0000
Message-ID: <0cece70f-a7ae-47e2-a4a2-602d37063890@intel.com>
Date: Mon, 10 Jun 2024 13:38:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG
 forwarded response
To: Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew.gospodarek@broadcom.com>, <horms@kernel.org>,
	Somnath Kotur <somnath.kotur@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, <davem@davemloft.net>
References: <20240608191335.52174-1-michael.chan@broadcom.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240608191335.52174-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0138.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::36) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: af2d5bda-fed7-4bdd-e2bc-08dc8941d1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUFyWGpPNTFOOE5EbytseVBtOHVTVGQvVTBSSGI0THpDNFlrUjNkc21SNW1U?=
 =?utf-8?B?a0R1bFBxYnpVQitOajMrNjVRdC9WYjNEeGNMcUtrZnFYVnhtaWZUdWdNNmFD?=
 =?utf-8?B?WFdHaGpiaEIwN1Y4MXA3RzMzd2k0MzFDVkhoK0pmWTFvTW9KSHdUMXJWOGEx?=
 =?utf-8?B?Vk5yL2FMMFJTNENxdXZ1UGdkOG1WOSsrdm9wVVR4czBvcTRzVUM1QnVSSXhB?=
 =?utf-8?B?VFJ2d1V5bjQ1dTcwYS8rTTdMV1FKS0plZk1IOXo0cUkvTXdxL1h4a0JoZXcv?=
 =?utf-8?B?RFZkYklrWkd4ZkFHd2V2V2U2VnJIbzBDWW1wOHNHRlRLS0dkRjBQdXhUYVV6?=
 =?utf-8?B?VTI5VFZScFMrTEI1RGhxcmpHZjB1TDNucnplK0x4Vmp0bUQ0M2xoTHhtQytG?=
 =?utf-8?B?U2RTOUsyUVVFWkxLSU1TQnpuanVieXIzVG8zRGdZRHJLVjhzNDRRNlpzcXZK?=
 =?utf-8?B?Um9PcjlLQVhiYjkzcTlpai91dW13L1pib0pGalpCNVp4bnVrYWZKMlRGT3d6?=
 =?utf-8?B?bklDRUtFZXZ4SWo1UWJqNzBTeitrK1hqMkFDSHlWN1E4SjdIRzBOQXRaT0Fy?=
 =?utf-8?B?U2FEcE1MNlBLMjI2RTBEbmlFTnZ4dERQbXVwdXg4QlB6c3Vjc0gvOVMxS0Ns?=
 =?utf-8?B?SFF5NHhZUHFqVjM2Y25DQ3JrWm5BcTZGZ1VGc1pYS1ZYRURnWEpSZi9sVzlw?=
 =?utf-8?B?clV2TDRvdkthdFl3VWxOTHJTRE13d3RNdHRJR3cvcG02QWJZYXMrZmU0akJN?=
 =?utf-8?B?cFBHY0ZQWUVrVkV6Q2FqdlV3dGJQdTh1eEh3Qkk2Wjl6clIvczRBdkJhamlN?=
 =?utf-8?B?U1ZMUUU0YkF0NGVDSUNQWGJFcVlHNG10Q3FtWk5HNzZyVVZINDM0VGVKZDV6?=
 =?utf-8?B?Z0tIamNUenlOS2F1dnljait3NG01RDZyL0Y4OFAwcmpmdTdyMHV1WndHVjdw?=
 =?utf-8?B?cjB3NzgrRUtUZUplblZwOU9ybTQ1elFuRi82NmRJdmYyaUZpS2RVbGo1dTlx?=
 =?utf-8?B?QWJPWGR3amFPNEFTZEc4UTZZdWY4N2JCbzdCVXRwYzhYUDNJS1VYVGQ2akx2?=
 =?utf-8?B?N1kwRDlVMmcrRGZBZkpScFJLSk5idllucVc1ZStxTlNnUW5aMUVQWmlNYTFh?=
 =?utf-8?B?c1lxSVR5d0JkSzd0OGZFSkQ5YWdNdDhlM3FVSWVwcmhoSmNkcTk1akRlQmRZ?=
 =?utf-8?B?TkR2bmFBZXRsMXQrS2EzRUdxZHU1MXF5Y3BKVHAyekVpdVFVUTJLMThVQmF0?=
 =?utf-8?B?ZGNFRnpyTEZocVVVdHBXWnRDNlFrQTVDMmVxSmhpdXhXUy9ZUEdtckRmVnM4?=
 =?utf-8?B?ZVMyRkd0ZmhDTUpyRFNqQkJwbkF3UXdlTUhDUDJ0WnBTRHg3SEJvMlN6MGYx?=
 =?utf-8?B?TGpqN3YxMFAveUxKazkwTU45Q2pJaUdxVS90TnlQM3NNemFDS2hacThiZnNW?=
 =?utf-8?B?bUZTa3hoTUVlQVFqTlFka3BXRFhLbEVtWXFaQ2VKWjZrMzJjYlE4by9wb0VM?=
 =?utf-8?B?QVN2dGxlenRXY1c1dVZLVWdaMGM2eW1oSy9JQ2laUkREUVRObTUzNmQyZC9T?=
 =?utf-8?B?MmNwcnF4djNqbWduMGY4UzdySnUxUTJvcWU3YzUvZitBa0M2TzBjWFBxamM0?=
 =?utf-8?B?UWYxZGo2ZVlOdTlqQTRwN0FKc3Y3MDRleTJ5Ung0MTVHU0RpMUFURUZ2UHN2?=
 =?utf-8?B?UTNHVkJRTm5pam9teXF0RGZKWVUvVmpVVmV4QUd3YU9ZbVpZVXhwd3JjTlVw?=
 =?utf-8?Q?R8t+GCqmB8FeGbVxVxyiss6BT59grRLOXZsBF14?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eElKWHQ3enlobW9McVN5UzVPMHRjVlgwRUlqdU1DVW51TjVFamRqbE0xTFBq?=
 =?utf-8?B?L3k4NGErLzVmZWNDSHBNaStmMTBDUXdmMXdPN1VlajFldTlYNk4zd1h6Y1lK?=
 =?utf-8?B?cUF4OE9PdVZqSXlQRFRZSE8rS3V3djI4WUxLdDJ6R3Z4d0w0NXJENTVhU0d3?=
 =?utf-8?B?akRib2JIYzBncUh1Z2ovMWN6dmRoaisrSlVKeWRuejdoUm1paHhHUTV3WlpG?=
 =?utf-8?B?aG5Wc2ZScW1jaUI0YlphQnJscUZKNjZEQ3VhZHVPMUQ5aGFHUDlOSzAvZVpB?=
 =?utf-8?B?dTZVN2h3WDNZM25zVWRrWGtHMkp2ZkdZSkJxNE1VNnFvWHZCcEdLRVVlbEZq?=
 =?utf-8?B?Z2IzTWZYNVc0VFk3THdDWWVCN2JVT3ZsdFA2V09rMGRhRDVLeXhaenpQaU0x?=
 =?utf-8?B?SzlJUUd2WVNzVUJhd0t1aEhGTmNFMG1iM0YwMkJISDlrZkVxdG9qbkY2cUJj?=
 =?utf-8?B?S2dkcFp3M204YlpHbXpGZzFrdjFSdktNWTBmS2xJeHlSWGpQWVExd0x0TGdl?=
 =?utf-8?B?Rmg0L29qYnRnQjhSSlVlQ28wVTFENmFVMGRuZU9oVmxiN3lBSEZDUUlaak1K?=
 =?utf-8?B?RndGa3ZnL0R2bm83ZnJGdk13TUhTdXllR3JQSC9VZTRaSUlGcnVMUEdmWmYx?=
 =?utf-8?B?K1dMblg5cmpGTUY2Z0dlTXl6TXNqTFFzclNodzNXR3kvQ0Rqd2NEdWw3c1c5?=
 =?utf-8?B?V0l6aEhJd05oaDFQbGhWZEZzUUVuT2V3S0FiMFVMTTlRODk3eTN5Y2JhN2FR?=
 =?utf-8?B?NCtIdzJFVjVsOXV2SWNET2hmelVRVmdjNk5iUjlid25IekhUalVvc3diR2t2?=
 =?utf-8?B?SElIWnJ2cnpZVGczeFpXN2duSkQ4Um9zZ0RrYTY5NnlNTVNiYTNlZ2ZVOEhu?=
 =?utf-8?B?eGxGZEV1enBidTVoa0duMkNTWXJRQXovelhQSmx3eTZuL3gyMzc4bVFjMjNS?=
 =?utf-8?B?THA5bkZZdmtlZ0ZHdTZUU3JGWGdWN0Vta1NCOE56OGhCelN6T1VnYktSU1NK?=
 =?utf-8?B?TjAzTmtCZXB6MnlwNEYrOE1JOEdpZVpOWXZ4d0d3TFlPSEE2c2lMYmVyWXF4?=
 =?utf-8?B?TlVrZ0VsQ1l3ZFd6M0RBbUZCemxoVXJYZ0NPeDRkZnF3bGxCK2ZCdTJOQkRK?=
 =?utf-8?B?WnNkWjF0WHNtWnVRcUFoT0MxT2lSWHcwMkI3Vkp0ZnZrTEFFSWFOUWJKL3VY?=
 =?utf-8?B?MHdUU1E4clQ0S1YxeVFpN28zUlhJdDhjbGZFSHIvU1dEZFBzRnJRSGM1bTJr?=
 =?utf-8?B?a2xVRENCNDU3cjNsOUFmbkNQRGlGV1l4SlQwTGhTRDlRTnhIa2F2KzZZSksz?=
 =?utf-8?B?Y3IxVkw3OEpQcEVYN0p6UUJMVTBrME5nSGpOWWVvOXhwdS9JbUwxQVhyVHNt?=
 =?utf-8?B?OTVVd0VuYnVCMUE5MU90SmhsOU94MTRCcHFma3FMYnJPc2JDcFo4VVhyVTJW?=
 =?utf-8?B?L3BwdEs2Q2hGc3JQYndWd0hLSTRITG9KT2l2SzRKNFZSVU5WYU8xeVF0RGRp?=
 =?utf-8?B?azgvTzdmZjlVK3RhYVRxdUx0U1h1UHhVaGpsWkNCbVlJWlZKRUFvUjZQZDZl?=
 =?utf-8?B?NFkrM0ZGSW5tc0IwazJBNVg1S2g1QjhCZWtISU5OZTl5ejY0c1hGNUgrQUNJ?=
 =?utf-8?B?WDZrRkhRSlJ6RmF4b1JYejR4NzFSanR4Uk41UW9aZlJPZTFrUlVaeWgrTkVj?=
 =?utf-8?B?WDg4b0k4b1hmbUI0MnZqd3AxU3JXYm5TWmJhRU9xTGsvMk5JSFRoTG4vSlhE?=
 =?utf-8?B?RVhHU2gzbmhPalh6VmNQcGc0Y254TWI4MFNuL3JhdTdIT2t6YlFKV1pGUFJ0?=
 =?utf-8?B?Vyt5b2ZxUENLclBlK1J0UHdOc1J2OURYTkwxWnFHUElmQ29CM2pkdk9QVFpL?=
 =?utf-8?B?c2tIS2JnVE5mWVBmbkx5cTZXSWRBcHllRGcvcnU0SzRURURFbGFQY1c2T2pY?=
 =?utf-8?B?Y05lcUFLZVhJamZHUnFKZ2tyMkxJTERYV1N6ZThVUXJ0QkJrZVZLVVJkc0gx?=
 =?utf-8?B?Qllpb2M4ZXFVOFU2WE80b1gxanhCRmZYTFhIamFrUmVPRERwRWZyck9HQzVB?=
 =?utf-8?B?TjRXak44Y1N3a3BlbERNdUhpeGxOQm5RTHFXQ3lxWFpPQUt2QU5oZTExU1B0?=
 =?utf-8?B?Y1ZHQ0EwSXpOQnNpZEhqZTVxMDJSanp0dzhJei84S0RWMUdkaEhtU1dpQmNZ?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af2d5bda-fed7-4bdd-e2bc-08dc8941d1f4
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 11:38:16.8823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+nQl9t/2hpjLCnaU5bHZAID6jqdXreFQSgNYhj33CqtJtBZNn8Nez4NGvifOkulCKpSkwd1638bqmuWRBPsQaJcSYekaSKPL4Sjf/kEkek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8468
X-OriginatorOrg: intel.com

On 6/8/24 21:13, Michael Chan wrote:
> Firmware interface 1.10.2.118 has increased the size of
> HWRM_PORT_PHY_QCFG response beyond the maximum size that can be
> forwarded.  When the VF's link state is not the default auto state,
> the PF will need to forward the response back to the VF to indicate
> the forced state.  This regression may cause the VF to fail to
> initialize.
> 
> Fix it by capping the HWRM_PORT_PHY_QCFG response to the maximum
> 96 bytes.  The SPEEDS2_SUPPORTED flag needs to be cleared because the
> new speeds2 fields are beyond the legacy structure.  Also modify
> bnxt_hwrm_fwd_resp() to print a warning if the message size exceeds 96
> bytes to make this failure more obvious.
> 
> Fixes: 84a911db8305 ("bnxt_en: Update firmware interface to 1.10.2.118")
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
> v2: Remove Bug and ChangeID from ChangeLog
>      Add comment to explain the clearing of the SPEEDS2_SUPPORTED flag
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 48 +++++++++++++++++++
>   .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 12 ++++-
>   2 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 656ab81c0272..94d242aca8d5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1434,6 +1434,54 @@ struct bnxt_l2_filter {
>   	atomic_t		refcnt;
>   };
>   
> +/* hwrm_port_phy_qcfg_output (size:96 bytes) */
> +struct hwrm_port_phy_qcfg_output_compat {

I assume that the first 96 bytes of the current
struct hwrm_port_phy_qcfg are the same as here; with that you could wrap
those there by struct_group_tagged, giving the very same name as here,
but without replicating all the content.

> +	__le16	error_code;
> +	__le16	req_type;
> +	__le16	seq_id;
> +	__le16	resp_len;
> +	u8	link;
> +	u8	active_fec_signal_mode;
> +	__le16	link_speed;
> +	u8	duplex_cfg;
> +	u8	pause;
> +	__le16	support_speeds;
> +	__le16	force_link_speed;
> +	u8	auto_mode;
> +	u8	auto_pause;
> +	__le16	auto_link_speed;
> +	__le16	auto_link_speed_mask;
> +	u8	wirespeed;
> +	u8	lpbk;
> +	u8	force_pause;
> +	u8	module_status;
> +	__le32	preemphasis;
> +	u8	phy_maj;
> +	u8	phy_min;
> +	u8	phy_bld;
> +	u8	phy_type;
> +	u8	media_type;
> +	u8	xcvr_pkg_type;
> +	u8	eee_config_phy_addr;
> +	u8	parallel_detect;
> +	__le16	link_partner_adv_speeds;
> +	u8	link_partner_adv_auto_mode;
> +	u8	link_partner_adv_pause;
> +	__le16	adv_eee_link_speed_mask;
> +	__le16	link_partner_adv_eee_link_speed_mask;
> +	__le32	xcvr_identifier_type_tx_lpi_timer;
> +	__le16	fec_cfg;
> +	u8	duplex_state;
> +	u8	option_flags;
> +	char	phy_vendor_name[16];
> +	char	phy_vendor_partnumber[16];
> +	__le16	support_pam4_speeds;
> +	__le16	force_pam4_link_speed;
> +	__le16	auto_pam4_link_speed_mask;
> +	u8	link_partner_pam4_adv_speeds;
> +	u8	valid;
> +};
> +
>   struct bnxt_link_info {
>   	u8			phy_type;
>   	u8			media_type;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> index 175192ebaa77..b28073777ef5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> @@ -950,8 +950,11 @@ static int bnxt_hwrm_fwd_resp(struct bnxt *bp, struct bnxt_vf_info *vf,
>   	struct hwrm_fwd_resp_input *req;
>   	int rc;
>   
> -	if (BNXT_FWD_RESP_SIZE_ERR(msg_size))
> +	if (BNXT_FWD_RESP_SIZE_ERR(msg_size)) {
> +		netdev_warn_once(bp->dev, "HWRM fwd response too big (%d bytes)\n",
> +				 msg_size);
>   		return -EINVAL;
> +	}
>   
>   	rc = hwrm_req_init(bp, req, HWRM_FWD_RESP);
>   	if (!rc) {
> @@ -1085,7 +1088,7 @@ static int bnxt_vf_set_link(struct bnxt *bp, struct bnxt_vf_info *vf)
>   		rc = bnxt_hwrm_exec_fwd_resp(
>   			bp, vf, sizeof(struct hwrm_port_phy_qcfg_input));
>   	} else {
> -		struct hwrm_port_phy_qcfg_output phy_qcfg_resp = {0};
> +		struct hwrm_port_phy_qcfg_output_compat phy_qcfg_resp = {0};

nit: we usually just write `{}`

>   		struct hwrm_port_phy_qcfg_input *phy_qcfg_req;
>   
>   		phy_qcfg_req =
> @@ -1096,6 +1099,11 @@ static int bnxt_vf_set_link(struct bnxt *bp, struct bnxt_vf_info *vf)
>   		mutex_unlock(&bp->link_lock);
>   		phy_qcfg_resp.resp_len = cpu_to_le16(sizeof(phy_qcfg_resp));
>   		phy_qcfg_resp.seq_id = phy_qcfg_req->seq_id;
> +		/* New SPEEDS2 fields are beyond the legacy structure, so
> +		 * clear the SPEEDS2_SUPPORTED flag.
> +		 */
> +		phy_qcfg_resp.option_flags &=
> +			~PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED;
>   		phy_qcfg_resp.valid = 1;
>   
>   		if (vf->flags & BNXT_VF_LINK_UP) {


