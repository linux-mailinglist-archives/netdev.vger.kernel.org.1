Return-Path: <netdev+bounces-174167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C389A5DAFF
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8311736F7
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F289323C8A0;
	Wed, 12 Mar 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vbu8JELq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC366238D49
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777344; cv=fail; b=ENSXA2fJlHFlZvlyxnT2vETcqXtKw4d9/Iqcq3CEwDohtPrFgZIYUGsY5yx0Y7Hjtzp9EdXPq+iWgmaELw2NGg5BoaAIPAX8708BN767lddmfSZoIBVN2GoU4zDk/WstkoPwY6o3mrkYY0+O/PMtsPvwq83AivLC4PJuS7tjFfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777344; c=relaxed/simple;
	bh=T9qKdRMo/AE6lwUc7BES2jpFxVllS++8v1o41Qm4Nw8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MrfAOJDFkh5LLVV4U2O0Ya+ycY0HwjZC/C2d1baDymS4K3Ofal19J8q5C+SY9dO0EbYidOxiRy/jsiYTxLnAye3h+w768go0s5IDp4IuqCwAzhsk6JPDhRoEGQtZQT5hVzyWxFChlYJYAp+2p34U/FognoAxY8x3BS3mKWxAtyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vbu8JELq; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1CDkzmRchzIXUqtw5VKe64m0bkvzlZ4wjYrMeBZsX/zPICV9C/vjyDKgCeNutcnlp2DyN6WiwzslDAKLLU8hbCgprXTKxS8zxpLS4294rNzviiFhDnSyxAnUOVlUhsE3k80gvDQe1La/UAEQsdgzTdTFr65wyPLsSAcKcYXY9Preg75C/28rdcbkooxX6KNkh7C1kjSDrD2sc0HPywe0s+emIxxmQ8bf4bANvBghSx2BwPyCOf/DnAY4j+qCmtPsc06vFo8xBlonRLx/YOSVtki1fBWdj87M83O9VDq2HoXyF3t0DReKHzL5TbS6SrflzxraT6tQY+6EK6bI5Ch7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZU1Jp/IyfpBgbW50nhkB23dDhpPPJIDcZZz2do67SE=;
 b=Nu8FqKdtSgfL8TtvBp/T4sqhZ/493H2LIEtIGLumSD6ITJDC5oEm6ywbXx1fk9qFFAxetoRuimwoNlkqy7r5ripoXuRlM+NS2xEi2s4spgH0g/Y0EeGoRgv0tSnOkXU5L4/I37sLTkqDqIPtxm5ge4PAVHm3mV3/9ERcVrPD3NLX4mbnly8WFwQgmw78UCPBCcXWaic7Jg9fl5KR3fei10TVraP/eSaVNTcHK0AxbkpzhZxchqidkpPWxoPjrnPTUwv/5ZQoOO83eymyFBS6cpoAwwAfvpZnHA/JKbjt9Yo0roIwyMbPAL1xmfJlkssQTVYQ5RuZfoeLGjWsBvdyDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZU1Jp/IyfpBgbW50nhkB23dDhpPPJIDcZZz2do67SE=;
 b=Vbu8JELq0cbPPVeLcuPonotglHaGP5cnMVb7Jvsq2wQiM8wegbykzvtVSyt7kLLPZYZKU+lWOhGe+aqS4Qbe3S+4ToY5BayAWuuLuYTguBDFE7gVv5mAyCAwElCvbiS5BRE0oRN7fKUq7vO2yPVxQ5iGKbKAtAGQi9nYABuZcBXadkLP9T7LagwySWrapS8mxQAFF7xBvuZvh1eRrhbERV9Omdpkwznx6Gx7nUwgZnJ+qhA3JGQ6C0Vn5DI0bKX79QESiHG+raRb2O+AZk0/2GnnE9uiVy8nfe6G6JXLU0BX+q6FZ+OhSveYPgxwH3HKOGbHNdKoNqunWUzb9NkpQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:02:19 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:02:19 +0000
Message-ID: <5fff8229-4aaa-44d0-9068-fa5d3f268345@nvidia.com>
Date: Wed, 12 Mar 2025 13:02:13 +0200
User-Agent: Mozilla Thunderbird
From: Carolina Jubran <cjubran@nvidia.com>
Subject: Re: net-shapers plan
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 Cosmin Ratiu <cratiu@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, Leon Romanovsky <leonro@nvidia.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 Madhu Chittim <madhu.chittim@intel.com>, "Zaki, Ahmed" <ahmed.zaki@intel.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
 <020727ec-6c9b-455c-bddc-78deb55ba5e5@intel.com>
Content-Language: en-US
In-Reply-To: <020727ec-6c9b-455c-bddc-78deb55ba5e5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0158.eurprd09.prod.outlook.com
 (2603:10a6:800:120::12) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 045e8410-6a4f-4cdd-7348-08dd61555b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RExrdkdscWRPVDExdFYwVFlJaXAvUXRUeFdTYmNEUm1mbVpwU1NjMWJQa0ZK?=
 =?utf-8?B?UmdkUjNBTFlTdngrakhUK2t6MTFxd0tnUHNFMU45VFdtUnpKVllQRHJ3ZURv?=
 =?utf-8?B?WGptRlNFaDNvZGtsaFAzUGxjMHVOb0JFWHRkZFpMT0Jld21rQ04xdFJNODhn?=
 =?utf-8?B?bGpsZFE3UGg1emxPcUxlVTJXZnJxQXVyaXRCd1JJeWtpNGpnRzBUY1pHSGdv?=
 =?utf-8?B?TjA4RnpWdWRHNzVSMXZ3VkJnVUlYNTFFVFlhRkFvZHpCeU80ZGVNODRka2w4?=
 =?utf-8?B?UEVlVXcyWjl5MDNNaGFqZjBPdjZvM2Qrc2JCZlFPVGhNN1VQdzQxSlQ3U2xq?=
 =?utf-8?B?V0ppc3B2TEZXUm1oaGRLdmpZVnBhbVlSdTBzdGpENERJTHYyN2lpZGNHTUp3?=
 =?utf-8?B?b3pyNDRUZlBkYTJ4ZlFpb2pGejQ0RzAyZDN2akxmaVVTaVp0UnlaTnRLd0d3?=
 =?utf-8?B?MXExd0hGQlBrZklTdVh0b29UTHJwNDgveUhCTU5MZlBzdWk3b2dhSnpNTkdF?=
 =?utf-8?B?cVVEK2RKZlpIb1ZjYmJFdTZ3VStQTTZQelh0M0cybk03cUhKdDJxN3R6UUs5?=
 =?utf-8?B?Vm1jTE9HcnZGa21YSktBclBlUHJOSW5mbzVUbEVhQ0ZNUWJmRDRMUk5IY2pm?=
 =?utf-8?B?MVBXYmJ2VG1JRDhiRDFzQWRtbHNSZ2huekd6Q0hRUGxkdUMraXJYZW5NcDRv?=
 =?utf-8?B?cWIvcWcwSEFINzI4NitZRS8vdlNYZ1ZaMlRSelJlQ0NzazNVRnExcWozQ1l5?=
 =?utf-8?B?blBoN2d3QlphRnFxcEtub05qOHhMUXJyREdUa1BWeCtieDN4N3E5Z2NBRWhC?=
 =?utf-8?B?cXNGcURSNzBZbkY3VFVveEVCYVVMNFVrc3BIcXRLT0VERTErM0N5UHNwcFJU?=
 =?utf-8?B?d1BsZFA1bXQya3lkQTY0ald1Y29mYW5LRTFhb2oxZW4zVkdKZGJpK3ZEQi9z?=
 =?utf-8?B?b2FvQUJSVk9LaVNIUXR5cTYvUlVFMW5YT2U3d0xDRzlaa1RGL3pJV3hib3dL?=
 =?utf-8?B?MVhMZmtNOFdkSU8wRFRacVlxUWRkeVNwcEk5M0xHV2FXdHNOc21PUTNURExP?=
 =?utf-8?B?ZXB0Q2ErVnJWUlA1QVlqYmN5Y2UzZVVSejY2TldlekpMWW4wYVFTS1lQN1Rh?=
 =?utf-8?B?OTVGOERWdlEycHhnRVowdTBmczE5Qll0a1J6Y20yR1RxeXJqak9pNVJud2xD?=
 =?utf-8?B?c0RYN3gvOUVLVmJpWWhORDFwdXdaaTdTQVJER0VnNy9TVTFxVzd2OE5vRHFz?=
 =?utf-8?B?ajVaRjRFK0xmTjkwZU52Y0pMRVdPR0dMN1pUUTlCR1gyOVZxSTZqSjcwRjI4?=
 =?utf-8?B?SEw2VHQ5WmRHOEVURlhTN0JzSlNhMmY3c2JrTWxEOWQ3MStMU2FDSWpLKzZL?=
 =?utf-8?B?Y0NXVjlYU2VTOG9Pd2dnM0YzdkpzSnM0L3FWU3phKzU4Mlg1TlRPdExWSElP?=
 =?utf-8?B?K2Nmbm1MTVRjWWhUalJjNk50a0ZocEtlU2ttOHlpMUpDN3hoMGgwSDFoRjI1?=
 =?utf-8?B?MXVzaVVjZHU3U1pvaFBheGJuRmNFVUJyY0NIRHZvdnVjeVZEc2pidmVVeWJs?=
 =?utf-8?B?VXlLVllIdGsyVFIvSENlc2dhcGVaNS9qV0hLc20yeTU0R2doTExiS3RZRDJJ?=
 =?utf-8?B?MG5yZEdMRmU1SHZKSzFkNG9zc3lIUVYwZkgwbXdmSVFJQkNORlRUcHh2Q05q?=
 =?utf-8?B?cUg2TXZFWTVKeXcxSW93YkxIenhBa294dFo2Uk9yVUVFUVdPM0s3cjVVNDhI?=
 =?utf-8?B?K21PRFIyalpsRjhDWjI4ZlFrSERXZXpZLzU2WGNaMGE3RExkUXVBU2RCcnpS?=
 =?utf-8?B?dWJxaE9vWGkwNTltTDNnU2dpb1BnR0ZBZlExNWNwOWRFcVl2Ulg1VWlHd0Nk?=
 =?utf-8?Q?N6wM6bG+7dvAA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmZwRk9oWWlHZWNJVnc5R0k2WjB5NDlkWmpKQ09iT1NVckNwMmZBSWZwQkl6?=
 =?utf-8?B?dmNUdTlDVWNzaERGTS9lWnl4UHNZdm84L3p3NzZyV3FyRTg1SURNclFlYUUx?=
 =?utf-8?B?QzNDTzdOMjFmSFhHN0pMM2VGNDYwbW5rbVFvMG5KTHVnc2xvbk1YdVEvV0p5?=
 =?utf-8?B?Y2wzSXhkYUtWaGVjQ1Q3bmVQaTdPcS9hdGZMTVhkWkwzU0ZiTGFWK0phdWJD?=
 =?utf-8?B?QjhXclhxSDBRVloxMFhzYkxJZ1ZQcVp2TnlqeGZIVzROTlFTRG9JbjdqWW5i?=
 =?utf-8?B?REdJb1d0Uk9SZDg1VndSZ09rVU9SMmJDeTY3VXhHcXJNemR3ZmV3ZW9sT09G?=
 =?utf-8?B?ZERDb1B2Z1FTNVJHdzZOOVFOc3VnSitqYjBkMW5CZHppVGZrd25pbU9WQjgw?=
 =?utf-8?B?QTk4a1EwQnF4T2dXcnUxT3VjK0YwdUxNbkdHS3BTZzVURFFGdmZqMU5BZ3NY?=
 =?utf-8?B?WkVvaXdSVXRhWHJ6WW9CZ1RiR3lSVVBzRXc3VVgxU0ZKZXFvMVNnaW8vOEZZ?=
 =?utf-8?B?NjhHU2VVSW5xN0srd0IrNFJ6ZU9iVlZaOVd0VDBPTkczdjlrVFpaOWdyVUQv?=
 =?utf-8?B?dXhSNGQvTTh5d1lWM3ZGTmJvNWIxdHRBaUdaK0dGSWNTQmc1QjJzeFU4dDMw?=
 =?utf-8?B?cExiZ1I4MXJrZUZmZEwwVlBXT2hCWkJER2dzU3BsUlc4SkpUVHBqdXM4TFYv?=
 =?utf-8?B?NklwWktIR04wdXA0T2dGVUhhaFVQL3lqd25RNUpCRVZKTUN0bE4zc01lNlhq?=
 =?utf-8?B?MkI0N2I3Sm9FN204eFlDRUp1cmdZL2dDUjdiR1E1R25oMHp4Vm1ITGJOWlRp?=
 =?utf-8?B?ZytURHc5OHRrS0NyNGJuVUtxMEM1cExqaVp0Zlp2dHRKWmxheEFTUGY4aXp4?=
 =?utf-8?B?ZFZTeVExTkcxeE9tS25LNHFHRGsxaUJ4eEFVZVlYa3JEOC9QT1ZRRzY0a2JK?=
 =?utf-8?B?RzkvYVhqL2pwZk55QkF2b1diY3Y1K3U0eGVhb3lJK2pnc0dOOUFSanZuYXFR?=
 =?utf-8?B?SWxTcEtLNXI5ZWRubUZDQzJkL3pnUDg4cjVCZXZ6U2RKWVBqR0VqTjRkdlgw?=
 =?utf-8?B?MExDUkx3bnpsN1h2UTVwMDZOUksrN2ZGbDVrYmNOZEkva1BJcklsbm11c1pJ?=
 =?utf-8?B?bStnQUJmM2RSTFJnWkdKejV3dTZEUjVLaFFWaFViazFBUkhIeG5meXZHWVBB?=
 =?utf-8?B?Zm94MGR4Y3hxSkxyS0hQWlJiak5jeHR4SHU3N01ia29Cb0xlN0Z5RGx1cjdq?=
 =?utf-8?B?d1RsQVpmcmF0M1E4b09lY2xvQ1M2VHFZY1pUa1BLSTZManVDVkZWNlkrVzht?=
 =?utf-8?B?a2gyN1pqc3NxYlZXMS96RHMyYytBYUZqMVJQbkxtSytyQXNtWXFQOC9jWHZm?=
 =?utf-8?B?cHRyanIrNVUzOUxRdWVaU2NMWllyZnFWcEcvLzh2SlpOTU9UVVcrZUFUdDlz?=
 =?utf-8?B?WnNUajd3YWJRa2k0Wjd5MFZHVXpEVEppeEIyaE02V2NPNDMzaVdwUytjQ2Ur?=
 =?utf-8?B?b0E3eWhwZm5WTnY2U0FJT21qelo4NDYyNy9OQjRULzFFSDl4K09EVG9wU2lK?=
 =?utf-8?B?SFVRUDZSNUVlSzNJZXZkVmY5UHd3eEtJUkgvZTR1c01FM1I0MnBFcHpDOUdH?=
 =?utf-8?B?S2o4SzFJSWVhUGhGT2pVVzBzeHdQZldGMkk5ZzYrOTM3VVBmMmlDczJDS0dM?=
 =?utf-8?B?L0tkeHpsRjdzakdobWZYNUdYZHhaTlhqbytOQkp0YTJ4TzFxU1YwbGdxdkNh?=
 =?utf-8?B?akxWcENuWUFEekpkNGVGR25XVGFpV0o0YnhMMXRUN2NKUjJOc21MVlBscFdN?=
 =?utf-8?B?VjRRY2hYTmRBcWRxM2ZMYTJDRHZ0VkphZGxyZ0hZK0UvdTVuSnIrSG96Z1RJ?=
 =?utf-8?B?UnRvUndWeWgraW56eDF6TzVYV2wvN3Q1UkFUcWhiTDhZckozTGZYMytPSW1U?=
 =?utf-8?B?UE5ydEUxYmV4TUVDeEExYUJVaHpZcUVwd2Q1WFU0Z0k4VDRMemZ6eTBteG5y?=
 =?utf-8?B?TmIvNTVuNXF1bTh5MVFuSyswRUdaWGZWRXJ0WCsrditDaWIrbnVNUFlpaDQ4?=
 =?utf-8?B?S0c5bStRVStRaTV3V25sYmF6d1IvdHRRWEdZS2FZN203RFlIVXJGZnBJc0Jn?=
 =?utf-8?Q?lyLrjX1+bOvPA9VWEmJkpsc/N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045e8410-6a4f-4cdd-7348-08dd61555b54
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:02:19.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEu4VVXqzyVa0/hWzWybzIkxIVaNz3vBH+PioynZchVZKXt7xbr2InAcFUutag5bTn0Rb1Bwrw1y8slPvNVwaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088



On 11/03/2025 3:42, Samudrala, Sridhar wrote:
> 
> 
> On 3/6/2025 6:03 AM, Cosmin Ratiu wrote:
>> Hello,
>>
>> This (long) email presents a plan agreed with Simon and Paolo for
>> extending net-shapers with use cases currently serviced by devlink-
>> rate. The goal is to get net-shapers to feature parity with devlink-
>> rate so that the amount of code dedicated to traffic shaping in the
>> kernel could eventually be reduced significantly.
>>
>> This is in response to Jakub's concerns raised in [3] and [4].
>>
>> Context
>> -------
>> devlink-rate ([1]) can control traffic shaping for a VF / VF group and
>> is currently implemented by the Intel ice and NVIDIA mlx5 drivers. It
>> operates either on devlink ports (for VF rates) or on devlink objects
>> (for group rates). Rate objects are owned by the devlink object.
>>
>> net-shapers ([2]) is a recently added API for shaping traffic for a
>> netdev tx queue / queue group / entire netdev. It is more granular than
>> devlink-rate but cannot currently control shaping for groups of
>> netdevs. It operates with netdev handles. Stores the shaping hierarchy
>> in the netdevice.
>>
>> [3] & [4] add support to devlink-rate for traffic-class shaping, which
>> is controlling the shaping hierarchy in hardware to control the
>> bandwidth allocation different traffic classes get. The question is how
>> to represent traffic classes in net-shapers.
>> In [5], Jiri expressed a desire to eventually convert devlink-rate to
>> net-shapers.
>> Finally, in [6] I sent an update outlining a snapshot of discussions
>> that took place trying to figure things out.
>> Putting these pieces together, the following plan takes shape.
>> Plan, in short
>> --------------
>> 1. Extend net-shapers hierarchy with the ability to define 8 traffic
>> class roots for a net device instead of a single root like today. There
>> is no need for a new scope, the NETDEV scope with a different id to
>> differentiate TCs should be enough.
>> This is needed to allow backpressure from the hierarchy to the txq
>> level and proper TC selection.
>>
>> The goal is to either have a hierarchy like today, with one netdev-
>> level root containing nodes and leaves being txqs or to have a TC-
>> enabled hierarchy with 8 roots (one for each traffic class), with nodes
>> and txqs as leaves.
>>
>> 2. Extend the semantics of NET_SHAPER_SCOPE_NODE to be able to group
>> multiple netdevs, similar to devlink-rate nodes.
>>
>> 3. Add a new DEVLINK binding type for the hierarchy, to be able to
>> represent netdev groups. That part of the hierarchy would be stored in
>> the devlink object instead of the netdev. This allows separation
>> between the VM and the hypervisor parts of the hierarchy.
>>
>> These together should make net-shapers a strict superset of devlink-
>> rate and would allow the devlink-rate implementation to be converted to
>> net-shapers. It allows independently operating traffic shaping from a
>> VM (limited to its own VF/netdev) and from the hypervisor (being able
>> to rate limit traffic classes and groups of VFs, like devlink-rate).
>>
>> Plan, in detail
>> ---------------
>> 1. Packet classification
>> It is outside the scope of net-shapers, but it's worth talking about
>> it.
>> Packet classification is done based on either:
>> a. TOS field in the IP header (known as DSCP) or
>> b. VLAN priority in the VLAN header (known as PCP).
>> c. Arbitrary rules based on DPI (not standard, but possible).
>>
>> Classification means labeling a packet with a traffic class based on
>> the above rules, then treating packets with different traffic classes
>> differently during tx processing.
>>
>> The first moment when classification matters is when choosing a txq.
>> Since the goal is to be able to treat different traffic classes
>> differently, it it necessary to have a txq only output a single traffic
>> class. If that condition doesn't hold, a txq sending a mixture of
>> traffic classes might suffer from head-of-line blocking. Imagine a
>> scenario with a txq on which low volume high priority TC 7 for example
>> is sent alongside high volume low priority TC 0.
>> Backpressure on TC 0 from further up the shaping hierarchy would only
>> be able to manifest itself by blocking the entire txq, affecting both
>> traffic classes.
>>
>> It is not important which entity (kernel or hw) classifies packets as
>> long as the condition that a given txq only sends traffic for a single
>> traffic class holds.
>>
>> 2. New net-shapers netdev TC roots
>> A new netdev TC root would therefore logically identify a disjoint
>> subset of txqs that service that TC. The union of all 8 roots would
>> encompass all device txqs.
> 
> Are these TC roots configured on the VF/SF netdev? OR are these on the 
> corresponding Port representor netdevs?
The answer is it depends. If the user want to achieve tc bandwidth 
allocation inside the VF, these TC roots are configured on the VF 
netdev. If we are trying to achieve this tc-bw on a intermediate node 
that groups multiple devlink ports, this will happen on the devlink
port.

> 
>>
>> The primary reason to define separate roots for each TC is that
>> backpressure from the hierarchy on one of the traffic classes needs to
>> not affect other traffic classes, meaning only txqs servicing the
>> blocked traffic class should be affected.
>>
>> Furthermore, this cannot be done by simply grouping txqs for a given TC
>> with NET_SHAPER_SCOPE_NODE, because the TC for a txq is not always
>> known to the kernel and might only be known to the driver or the NIC.
>> With the new roots, net-shapers can relay the intent to shape traffic
>> for a particular TC to the driver without having knowledge of which
>> txqs service a TC. The association between txqs and TCs they service
>> doesn't need to be known to the kernel.
>>
>> 3. Extend NODE scope to group multiple netdevs and new DEVLINK binding
>> Today, all net-shapers objects are owned by a netdevice. Who should own
>> a net shaper that represents a group of netdevices? It needs to be a
>> stable object that isn't affected by group membership changes and
>> therefore cannot be any netdev from the group. The only sensible option
>> would be to pick an object corresponding to the eswitch to own such
>> groups, which neatly corresponds to the devlink object today.
> 
> When you are referring to grouping multiple netdevs, I am assuming these 
> are port representor netdevs. Is this correct?
> 
Grouping multiple netdevs; these are devlink ports not netdevices.

>>
>> 4. VM/hypervisor considerations
>> A great deal of discussion happened about the split of shaping
>> responsibilities between the VM and the hypervisor. With devlink today,
>> the shaping hierarchy and traffic class bw split is decided entirely by
>> the hypervisor, the VMs have no influence on shaping.
>>
>> But net-shapers has more precise granularity for shaping at queue
>> level, so perhaps there are valid use cases for allowing VMs to control
>> their part of the hierarchy. In the end, what we think makes sense is
>> this model:
>>
>> VMs can control the shaping of txqs, queue groups and the VFs they own.
>> On top of that, the hypervisor can take the netdev root of the VM
>> hierarchy and plug it into its own hierarchy, imposing additional
>> constraints. The VM has no influence on that. So for example the VM can
>> decide that "my VF should be limited to 10Gbps", but the hypervisor can
>> then add another shaping node saying "that VF is limited to 1Gbps" and
>> the later should be the limit.
> 
> Isn't it sufficient to enable rate limit at a VF/SF's queue or queue- 
> group granularity from the VF/SF netdev? The hypervisor should be able 
> to rate limit at VF granularity.

You can do that, this depends on the requirement. If we have two VFs 
that shares the same physical NIC, one VF could fully utilize the link. 
To prevent that, you should limit each function from the outside (on the 
hypervisor). Otherwise there is no enforcement to let the VFs fairly 
share the link capacity.

>>
>> With traffic classes, the VM can send out tc-labeled traffic on
>> different txqs, but the hypervisor decides to take the VM TC roots and
>> group them in an arbiter node (== a shaping node arbitrating between
>> different traffic classes), or to group TC roots from multiple VMs
>> before applying arbitration settings. This is similar to devlink-rate
>> today. The VM itself should have no control into TC bandwidth settings.
> 
> 
> It is not clear if TC roots are configured by the VF driver or the PF 
> drivers supporting switchdev. Can you share an example configuration 
> with steps on how to configure hierachical traffic shaping of VFs 
> queues/TCs
>
 From the inside the tc roots are configured by the VF driver.
 From the outside this will happen on the devlink port that indicates
the eswitch port that represents the PF.

>>
>> Cosmin.
>>
>> [1] https://man7.org/linux/man-pages/man8/devlink-rate.8.html
>> [2]
>> https://lore.kernel.org/netdev/cover.1728460186.git.pabeni@redhat.com/
>> [3] https://lore.kernel.org/netdev/20241206181345.3eccfca4@kernel.org/
>> [4]
>> https://lore.kernel.org/netdev/20250209101716.112774-1-tariqt@nvidia.com/
>> [5] https://lore.kernel.org/netdev/ZwP8OWtMfCH0_ikc@nanopsycho.orion/
>> [6]
>> https://lore.kernel.org/ 
>> netdev/67df1a562614b553dcab043f347a0d7c5393ff83.camel@nvidia.com/
>>
> 


