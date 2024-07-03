Return-Path: <netdev+bounces-108914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D2C926345
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4916D1C2011F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27825177980;
	Wed,  3 Jul 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgkRpoKd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640B814D44E
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016451; cv=fail; b=SSaQRsAnanQyLPTyIACMR2/MNMg5MBHgStV6vsJbN5IVJxnMORs7Fw6GT5bJaTteivFt6CwLbfv3W9R9M4swNpyeJgj6zOHP1OlhZCobyBOE6HmFNRmw7d7IpTMF7AYzy9rg3koD1fGFW0rQVURgZnlNwPUHFQEs50xpR+PMpg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016451; c=relaxed/simple;
	bh=ZanRGwVyI46LK+6kspKwf05cTaMsyKtLLAdBGjK5JUw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fEKD0byP9tuiDxLrlI69ys3Nrj35As5T2WmaZhUcV0JFWJhPJMBEjl4WItdP1WUywquf/I76SQSfIAw29GOubuZ3EhgreIzTI8LStra2o11EjgtmC/ax9Nxkik7wPHAqDnJZVAjRi6w6Kis6Zs4cfbNmirU3kOoj5ehGKRmoiKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgkRpoKd; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720016449; x=1751552449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZanRGwVyI46LK+6kspKwf05cTaMsyKtLLAdBGjK5JUw=;
  b=RgkRpoKd8KLCVk7N8xoPsQqCnCf3JxaB45Ogn0Xa3Wu4kossz6V5ChKz
   f6XOG2mC6DlzjMGsuVZB4/63c3ho3wKoXNdoz1wgj/SAblDf8SaTegzP6
   Pv6o3rQqNOGaxBBGhwyXjPLu9nNJj9IPBw0j7iVRyHECJijZImlg1uXAL
   ZKsgQZu3Te703djGlnxloMYu8Cl3NOCn35mJ2kElruvjP8PTfkdvMrf1u
   CB5jDivaWQGQDy99pge2DkvN2/6DG4w7R3au/hQbxMoMuWegiF+gBtI3P
   C6w7+p5vwc6dYwaXMu/3jcvctm+KzmbevfxawJczkdY48++yyj7zZOBZg
   w==;
X-CSE-ConnectionGUID: NUNOTGX0RmWEHOZomUbjEw==
X-CSE-MsgGUID: 5W8LhIg9Tzaql+7zlaC1rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="21058852"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="21058852"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:20:48 -0700
X-CSE-ConnectionGUID: X1sBn/lzSUOu5/5OjfMfrw==
X-CSE-MsgGUID: UAusnm0QQtqnUShSpFryOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="50865983"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 07:20:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 07:20:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 07:20:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 07:20:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nidb7BS84dD644AXEA6mt0xgHZqHqqc8NQuEqu6A1x/hGF/KOCPZtI6kQZms4EEYWZf+EhQspMoIllzc6ytwNNj2v9cZIu9ZqHpAViI6LoyRz7oF8172k/icwF/vFczLhwO1TlrYVs0zYawOGS8oaFentExZkdlWZg8zbkvbA8CXCOUXxI7R+ZFBxOjY9fnGXgqUkwdmS4GhphNln3tKuzfhRb5LFUwxzs/0IyzjAXYZ9HugBohy3DiLns/7KehCTQj/ZeNx0dox58erqyGDtUUVa/e00JmKJ7/ir6mXWCI+2htXsyN87LIx5PgR1razdmR3yHJj95LoOLKZ+mGHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0F9W2vqCBS8dnszScxmN5lZBQkzQsxr/nbGzjYh35Os=;
 b=Y0jgyXlUFIKNQBqojL5Xlo7JVGjPK3xFNj27AGUSevKaHiTAgRDqOrTm8MSna0/Uml+vOPuH1wetDVguDMRhcFupVa/6daa+HXe+tigA9nQbAtXM3cRT+LraNbDovk/rBBoHClpMn1nKJOVkx6tysSQFQGOYjyfB4LfYc4slsazfSoU341QZP6DEKQiN8u+ZJ9iSK6XbPEE0PnC8PwgEtK0SacFDVSd9tENQohLNG+ssWRdNu+K+Dygo+tESyLnbB+7lGbSWSn1jN4lNS9k8JHeX5uWphXNCuv28ZsqNJklrO0j5ZSAuvduZNvifMNTbxOb/Lh8pa37D4w6Akt/V4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by SJ2PR11MB7620.namprd11.prod.outlook.com (2603:10b6:a03:4d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 14:20:43 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::6a5:f5cc:b864:a4c0]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::6a5:f5cc:b864:a4c0%6]) with mapi id 15.20.7741.027; Wed, 3 Jul 2024
 14:20:43 +0000
Message-ID: <91496a94-1648-b69d-e014-65868aca3a78@intel.com>
Date: Wed, 3 Jul 2024 07:20:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v2 0/7] drivers: Fix drivers doing TX csum
 offload with EH
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tom Herbert
	<tom@herbertland.com>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <jesse.brandeburg@intel.com>,
	<cai.huoqing@linux.dev>, <netdev@vger.kernel.org>, <felipe@sipanda.io>,
	<justin.iurman@uliege.be>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>
References: <20240701195507.256374-1-tom@herbertland.com>
 <ab3e6312-cf67-47bb-b30f-d425f7914053@intel.com>
Content-Language: en-US
From: "Greenwalt, Paul" <paul.greenwalt@intel.com>
In-Reply-To: <ab3e6312-cf67-47bb-b30f-d425f7914053@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0291.namprd04.prod.outlook.com
 (2603:10b6:303:89::26) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5140:EE_|SJ2PR11MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: d86f3e4d-7ec2-4da4-61bb-08dc9b6b52a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2RESzdnMGNZTUxSOUtMRWRSZ3RsWWVKVkI2enhtaFZ5Rk1abzBVYXlpSTlh?=
 =?utf-8?B?KzJaMVZiYzkxVE82SUJaOXcxbEEvOEZqTklUc1FPL3RwSU1wUWMzVy95b1kv?=
 =?utf-8?B?aHJwc0tuMGhrd3lWcXpzRjUya2hrMmZka0hvemc5NElJcE1CTi9FdUduai9N?=
 =?utf-8?B?b3JSL0NZV01kelU4ejc4TEJOS0RFUlhtVFdwYUdwWElYYlZic0QyTHhDekMv?=
 =?utf-8?B?aWxodlZDVUVFR0RNZGErRFk1L1YwZmE0YmxFS0NpTHgreHFoU0VZdU9rbUtH?=
 =?utf-8?B?cldXUHBJRU9kbURJS0RlRm9XV1lKaGFmM1dVc2FDd3cvZG9abmJXNjYzbmtT?=
 =?utf-8?B?NE1hWVVmRTVLMkFrTkJRd1lyNFYwUm50L0hMbWlGWlhLbm5DUFRGMHVCelBQ?=
 =?utf-8?B?M3l1MXhMTW9FT0FwSDF3eHBZZUJ3aS9SeHVZQ3dka2gxZkhkM09BOVRXRFB0?=
 =?utf-8?B?engzUHJOMjJjMHJ6MFBydktWUDBaTHlhU0xYTHVLOCtXWEpGTnNNYTNmTzFG?=
 =?utf-8?B?RmRzeUZ1Ri9OQllNS0lReitFSmFWTVhSMFdiQTNqcjlTNTc1Qk11SHl0d09C?=
 =?utf-8?B?K3pXd29hZ3JhOVZxSnFLU2JCdWQ4MzluTDNVVkRqYjJZZGdSZUN0YmtpR0dU?=
 =?utf-8?B?OGdJbkYzNEhZY21KUXBCVjhJRExya3A1WENYcUpDdFkvRkxqVEduTXlXclJD?=
 =?utf-8?B?NTRpVkxvd2Fva05JTldBS1pOVzhmL0hrUjZkYnpBUFpGcUR4d0dVMVlnY1dv?=
 =?utf-8?B?enpFV2lMbWovOGRsRnFCVk1tbS81Y3FmNXRmZ1M3SnovZWUrM2oxcTU5aHF4?=
 =?utf-8?B?ZFNUZWpVeWJ6eGdmNElXN04vRHFNRVNFY3B4R1V5TitQazlORk5TY1loSkdi?=
 =?utf-8?B?QXZQcTBsRHJ2WE5JZWhjTmRNRm1GeHpMSFdTeHA1SEQyYlFHaHNoclJXSVo2?=
 =?utf-8?B?VGFJZ1BBaW1CK1FlOU1ZbktTUTFSSXo0Yy9MNk8yT1A0amQ2MmpWVHZSem1R?=
 =?utf-8?B?b05NOEN0dGUyQ2VleVlIcGxRMVVpcjNHODNUWmJSTFppNmUrbFNUOVQ4ZHVs?=
 =?utf-8?B?bkRPRmZ6aDBsQVh1WVlrSWg1YkJYU1VxamZ5ZkdTU1Y5UjVtZmZSeDlyK3N2?=
 =?utf-8?B?U3hlSW42OUJvbWhibllmZGdXQlpRT3QxUSt2WU9ickFsSHFLTkxub3ZkTVFr?=
 =?utf-8?B?ZzQxWnZhekRmallFUDNuU0ZvYzNJcGtnT05CSlZRL1JML1hLZUsvZ2xaWUNZ?=
 =?utf-8?B?Z3hpYnhQeTIvclFSWmVqL1FVelA3bGxjUDZuQjQvWXZZc0NKeHVXMGNEZWU2?=
 =?utf-8?B?UzVBZTVqTmVON2ptRjNpZkwvZDAwRnVkQVBqNVJUeDNNNEtOS2U4RnA0MTVT?=
 =?utf-8?B?dWJDa0wwbWFqd3F1RzdCZ0ltZFVyaVlDeGdDdWt0SUduWCtXMnh4MjBQYVVx?=
 =?utf-8?B?Z0wwMWRUZmh2dE8wTTl2OGg4Y0x6SW8wWXRMSVozYWN4d3VGRE8yTVRHMjlF?=
 =?utf-8?B?bUlSSFJ1MHpKMEZyTEQ0RGZnbGpJQkZ0MkxEd2V0NEdnSWVKbXpUM3RUVGpI?=
 =?utf-8?B?RUZhaGxib0tRN0t3MTZ0Zm1GMmhHbzBjTXEvNGdtZUtWMGdSTzFGMzB6UEgx?=
 =?utf-8?B?VEx0NSsybUQ2Y04wU1pTVWpmckpBOEJ1TkhBeGV0cjBsRjV0cDJjRXBuZE5V?=
 =?utf-8?B?cUxmME5KSVhhQnNUbXp5L0tDSndwRndPcWx6eWdybk5lNjBNdW1oRVcyMC9o?=
 =?utf-8?B?VVBtOTc4SmZLdUFtRGVGdGt1UVJhZUNVdHdKd1plZlA3RStKNkFuUzdCUHhR?=
 =?utf-8?B?bk1KYnJBTXdTbkdzT3hNUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjZYNjQ4UDh3b0pHN0ZZdEZ3NURGTUVjaVBKTDV1d29jWkFNTDlkZG4yajQ1?=
 =?utf-8?B?ZVprVXA0OXZFL015YzZ0bkI0cVAxdUJJZHBtcTY2S2tIbzdXWTJRaTZ1YWFk?=
 =?utf-8?B?WVk4L3o4UnNncW5MVUs1V2oybmJDNXZCQlBKV2tIRjlLdlhzUEJwNXpFZkdW?=
 =?utf-8?B?eEdnOG8wTFBPaFNJc0JkNTlYajIrYmNPL1ZEMWRWS1dpQU9OcExtVXRucjNM?=
 =?utf-8?B?ZE1OTVhmTlFrMXRYUHM0ZDBiKzUxVWZSbXNYQTBBbW94YTA1eEM0OGZMT2tV?=
 =?utf-8?B?NzU4d0gvL3dDOXVwZ2xYSnRTQ2M5RDI1Tm9aSCtzN3ZPNzBTK1c5SU80Mndl?=
 =?utf-8?B?ay80VEJYS3kxZGx3bkNURGRxRXFhNm92OXIydkR2M1d4OTY4VDNnbFFRZXBK?=
 =?utf-8?B?ZUQzM05PRG1sVXJkVHJKN0lMc2ZCL3FsRTlvR2pPQTJISXFibWhUMU1XUHB6?=
 =?utf-8?B?czBCTllaQ0syd29IdnpEa1BubjRVNy93b2hTSTR5MlMwdUZnN3Z4VVNnZEpW?=
 =?utf-8?B?MWxYQUlGQjlLWnZuWW5vN1BpaFY4VnBVU0xFaWFCN1BWOUhoczkrTENTYWcw?=
 =?utf-8?B?Z2J3SnpsZ0U1TFNwclNPYWswZm5NU053UDB1OVM4ZVA3am5vRmtncmFsWUVP?=
 =?utf-8?B?bGxlYUZLSmkrMVZjVlhxZVdEM0hhb3VBWXMvNXRNalhaL0tUNnExYXpuWTkv?=
 =?utf-8?B?TGVzWE1tUko0WUR5QmZSeEZzQ05iR3p0dEtHUkw4cEk3OGRmNy9kMjlIWXQ3?=
 =?utf-8?B?QnNDRDZvaVlYeEdTM3NtMWRZZWVBRjh6TFhpaEhkWGlUQkw3RG53YWw0NWZs?=
 =?utf-8?B?dEszQnNrRzNnZEtPTGFXaVNQK0h0NUNwNy9vcVN0Zm9zY2toNHRuTkQ5THdq?=
 =?utf-8?B?N21sZE1HSTBoYWxhdUxvUi9LTm4rTGh0dGt0UE8zQW9UUTVnUnpjTXZQejZj?=
 =?utf-8?B?Q0FLTlpoMG5jLzd5K1B4NHVhOW5uMnBQcU40YVlCZE8rZklZTm0xMUl0Wkx6?=
 =?utf-8?B?ckhZV2JNOXVYQWF4VHlLa3FPcE1GNnJ0cTM2dGtWdmxuM0U2UnNlTCsxWmlq?=
 =?utf-8?B?MzRhemNoYStNMG15eXFJam1LS2JOR2FNY1BhSXB5dDcwY1laaG1yc2N5U1VV?=
 =?utf-8?B?ZkFvN21uMWp4cDhhR3V2OGp4K2tRM2gyVFI5RXkzUmMzVHpsQ1F6T0FzQ01F?=
 =?utf-8?B?ZW9TcVFQK0ttUTdhbUR2YjA4TTNVMWVIZUltVzBneDk1YVo0U3MyZ00xZG5V?=
 =?utf-8?B?NU1IenVpdzM2dDJaRzhJdVZWcE4xVDZmQlhST0JCc2xPYmFWRXFJcXdGUFNl?=
 =?utf-8?B?ZzZKUWlGSHhLZngxMUVmNitMMnA2SEU0bXczNEM2WkxlZlYzVStiZjhNV2lO?=
 =?utf-8?B?UzF6bEhCNXBueGNJNysxZ09pakcvY0ZjZWM3VCsxSFhsN0Vvakk4VjVZdDZZ?=
 =?utf-8?B?YlhzYzY3M1NpYURnSytUbjZjSGJHeFZ0L1NQcm9PaWJWY1VjQ1FDY0dKUS9X?=
 =?utf-8?B?TThXNlVlM2VNeWNaSExRakpieDMxQTJyT0Z5anE1aXdLNlNkN090TGI3MTRY?=
 =?utf-8?B?Z1NwcVErVFRERDJCbTZ5Z0hCOVYrWVJCMC9FSGFVRk5UVHRwVGVNczFkcVlk?=
 =?utf-8?B?dW9sb0JSTTIrc0w2VHZEQ2R5a1VVVGdGcUM2NStBUWxSbVA2NUo2YTRMUUNP?=
 =?utf-8?B?MGFBQW9XbFJYeUpvMnM5QjRDMStTVDNOTFJDMDFDdWVzNHBDWnI0dE9vR1dy?=
 =?utf-8?B?d2FiNFlQdVNwWEljTWlhVUFKcWllZ0N6TS9NR3RqSVpiTTRad1A0VHNqSGIr?=
 =?utf-8?B?QXMrZ1BpNzMrU25ZditXdVo0YlNyeExSN0ExdTlQbWk2dERpMHVscGtMQzBv?=
 =?utf-8?B?MVNzUGJKVUcwa0REcDZSL3RXUG5ZZjF3QmZ2ZGhXMHJ4WXJiWHZOcEVZdUNK?=
 =?utf-8?B?L3B0OUl6dElqVlQwRXBjeEZqRUVreFM4TUgyVklrOUdvTkpNOEVGMnFUaS9Q?=
 =?utf-8?B?QXpvbWxlcmQyQjd0ZVk1c0dsVDc5bnYvNlRzbGVOdFhCeXFCOXI4Zk1vVFRs?=
 =?utf-8?B?d0dwUXVqcmlOd3BvaDlYanpmNUYyWHNRcC9ndzcrYlc0VkplUndjQWN6WFdk?=
 =?utf-8?B?L3VrL3FJWFh5RVEvemJCZXUvUjVpZUZKOXhTSDZqdjZ1azNTOXQ3YzZabzZN?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d86f3e4d-7ec2-4da4-61bb-08dc9b6b52a2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:20:43.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqdU4OlhnlgLDxUKyqfzudEIOoOA2Gym7/eMt5peJMRzid9JAe4TD/LUh3TWczmb4T23dp+eNXMHenBKr5XaQmTGij4DcUNpIloa0xY/rnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7620
X-OriginatorOrg: intel.com



On 7/2/2024 3:31 AM, Przemek Kitszel wrote:
> On 7/1/24 21:55, Tom Herbert wrote:
>> Several NICs would seem to support protocol specific TX checksum offload
>> and allow for cases where an IPv6 packet contains extension headers.
>> When deciding whether to offload a packet, ipv6_skip_exthdr is called
>> to skip extension headers. The problem is that if a packet contains an
>> IPv6 Routing Header then protocol specific checksum offload can't work,
>> the destination IP address in the IPv6 header is not the same one that
>> is used in the pseudo header for TCP or UDP. The correct address is
>> derived from the last segment in the routing list (which itself might
>> be obfuscated so that a device could even read it).
> 
> feels like there is a missing "not" after "could" - with it added, reads
> fine (not a request to change, just being verbose about assumptions)
> 
>>
>> This patch set adds a new function ipv6_skip_exthdr_no_rthdr to be
>> called in lieu of ipv6_skip_exthdr. If a routing header is present in
>> a packet then ipv6_skip_exthdr_no_rthdr returns a value less than
>> zero, this is an indication to the driver that TX checksum offload
>> is not viable and it should call skb_checksum_help instead of
>> offloading the checksum.
>>
>> The i40e, iavf, ice, idpf, hinic, and fm10k are updated accordingly
>> to call ipv6_skip_exthdr_no_rthdr.
>>
>> Testing: The code compiles, but is otherwise untested due to lack of
>> NIC hardware. It would be appreciated if someone with access to the
>> hardware could test.
> 
> we could test intel ones (except fm10k) via @Tony's tree
> 
>>
>> v2: Fixed uninitialized variable in exthdrs_core.c
>>
>> Tom Herbert (7):
>>    ipv6: Add ipv6_skip_exthdr_no_rthdr
>>    i40e: Don't do TX csum offload with routing header present
>>    iavf: Don't do TX csum offload with routing header present
>>    ice: Don't do TX csum offload with routing header present
> 
> sidenote:
> our HW is supporting (among others) a GCO check-summing mode described
> as: "Checksum 16bit (TCP/UDP) with no pseudo Header", but we have not
> yet provided patches for that, and I don't even know if this mode
> will be used (CC @Paul)
> 

We will be adding support for GCO "Checksum 16 with pseudo Headers" to
the ice driver. It will be off by default.

>>    idpf: Don't do TX csum offload with routing header present
>>    hinic: Don't do TX csum offload with routing header present
>>    fm10k: Don't do TX csum offload with routing header present
>>
>>   drivers/net/ethernet/huawei/hinic/hinic_tx.c  | 23 +++++++++++----
>>   drivers/net/ethernet/intel/fm10k/fm10k_main.c |  9 ++++--
>>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 22 ++++++---------
>>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 20 ++++++-------
>>   drivers/net/ethernet/intel/ice/ice_txrx.c     | 22 ++++++---------
>>   .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 28 +++++++++----------
>>   include/net/ipv6.h                            | 17 +++++++++--
>>   net/ipv6/exthdrs_core.c                       | 25 ++++++++++++-----
>>   8 files changed, 98 insertions(+), 68 deletions(-)
>>
> 
> I have reviewed the patches and they conform to commit message/intent,
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> (for the series)

