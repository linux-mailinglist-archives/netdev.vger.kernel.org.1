Return-Path: <netdev+bounces-126848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A74972AA1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0630AB225AB
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62D17DFE3;
	Tue, 10 Sep 2024 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Be+WP1iJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDC17CA1B;
	Tue, 10 Sep 2024 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953203; cv=fail; b=gUAV5DURzDaDXgG7Xngb4/zXvLruqjVzu7BzixdQtn4th45QRUCsLJSQZsklFwODuJSKAMVF/6wIwC7bFoPsSXUMljvT128w6viOnYJCTuA1APxyMwbyCXjy6bPEEzlOfn6jAzs52P8zNaWHdJIGyVdVJv2NQUI5jmoLx2t2OF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953203; c=relaxed/simple;
	bh=UeMk+BoYXmfVcejsUyjs7bwrFI2MB/bAjaGVyjdeP+s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s5jKJhs84Sf4q3mXlZFAsaZioo2Hy5ojWN7hJx1ll6Ao1qmFWGj/5G4B6zfIf9/Xf1U+XPXmqrQ4HSfUcBrglURrHWe2rKY1J1ykkXlL44eChystXyO0exirydrgTbQhCnLdHU+XMD9pDNxlztrWX/cLdVdPK/uAU11L7WN8WRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Be+WP1iJ; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdX3cOc1uJisx0jT6ep1c8VfY8hUvBtNPMXyPGfg/BOYcwqkPAlGWYx88IvBIrDBYweZmpZ+7vYFSAbboCQfRaxqrngOzAOienWXRpwJ5J76tYJi9WCjNAcI4eNXi3rcaS91WlS++8nB35Pnfoh3eGRks2u3H/aISK4jWGTQWmNRQwxx+nTS8sLxduqPgFMDhz1D2jJaaZfCGmvU0+Yw7ALDkPF9usritfNd6iJYLC83YihYY7ywlclfofqu356AUfwEN1y6fi4YxyCFYQDnR6vvx1LTvUwcDk7vnJH3ijBL56OZPEfuLavz7De5yHquLkPth82/8tmM3Fmix9PucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZQBgLcsHBlbQ6THyEUz+Xm0ZUOlgFXvxa6xWeB7RrI=;
 b=XbDYF87CyG2z/56P1qHPN7dqV19EakE8dzeWR5VXoLPSujM7W/QKHo4G3lmIKdq5edSoOqpVFBSLyaGT6pY7csKSchdvlKWy+wUc4YYqU9j8nYIgGazU9HH4WFifg99uPJv/eiJ9BDwYtd2NUzV4UJoigOvcv14IVJW+tNOlH7vWFG2OQBvLx91MMpJDhWZLMGCUZZS8QTb9+wsPU3acKl/T/KYCxw2+OucBlOjcXe9JsozM8oOlL3wLJi5s6vp6AHmoPRE99PCfvqgFhtE5ZDNIf7pcjfT6/49bin1ek7shrTTzBiU4w1MTPLyTqzzMWyfvwJjWKSM01uGdPM4ppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZQBgLcsHBlbQ6THyEUz+Xm0ZUOlgFXvxa6xWeB7RrI=;
 b=Be+WP1iJxPB1O25OOuwadUQz9VlbVUgNNurAnJBzjBi0s4A8h7DNM2Ipwe5OhZ3Sh8QmC5idoGnFo0y3t829ODTbl6iQpVbJJRis+TR1yyFlo2nofzPvepxmMLJmFe++w83+svcHctxuIMGGEs9Chm9lBJ4ZpGd9VyOUf39mOEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 07:26:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 07:26:38 +0000
Message-ID: <d9ae1e18-8574-ce45-fbf1-c8f595568a62@amd.com>
Date: Tue, 10 Sep 2024 08:25:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 01/20] cxl: add type2 device basic support
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-2-alejandro.lucero-palau@amd.com>
 <1041a5dc-8037-45f0-92a2-7ab1ad9a62aa@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <1041a5dc-8037-45f0-92a2-7ab1ad9a62aa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: cccb23e6-b3ae-461d-3aa5-08dcd169e87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2hCVExQc29LK1FkQnl1MDFONHh2YmxadmZuemVlUXZRY01jS2xacFpMaVFK?=
 =?utf-8?B?dlJVck5PREJHb0ZPcnYxM1o0WC9jN21kS0FqdldwSDNGK3Q0VU5jZW5lMlcx?=
 =?utf-8?B?YzhoeDB1Y2RRVmlYVEVMTFBqL1lEc2pxWUZmMTUvZm9hV0pORTV6MG9BSWhR?=
 =?utf-8?B?eTNIV3AxWHFCL0tTTVROY1A1Zk5HZVRBeTNudHZ1dDNzbFdzK001YkltTWRD?=
 =?utf-8?B?NHRWbkl3bFNFVGVWMHFjbzBZTXlXbk9DcWtyTjRPRXc1NTNtNk1VYkRoUVRz?=
 =?utf-8?B?MUJ2MllqbmJjMzE0cDMzM0VJTC9acTgwdlFjemI3Z1IyY0c4dEZGOFdrY0hi?=
 =?utf-8?B?V0t0a0VieGcxdkVPZ1Jva2N1a0I3TlA0V0d5aWVXVDNNSWVLU1Zqa1pjb1Y0?=
 =?utf-8?B?V0Q5OUNMVUhxWHRLRlpHUDdxcVIrNExaQ0U3YVdMVUpnKzJNdGFsaGk0K05n?=
 =?utf-8?B?dml2T0x5YUhkbzAwQ3EydWcybU9MQy8xKzNlZXNwb1p2ZDQ5eEVYM0lwTldR?=
 =?utf-8?B?MUx2aWhXd0N3YlNHS2R1NVZXdk11WDZCOWpJSGdEdjVSS3ByNVJTU29lamVa?=
 =?utf-8?B?TnV3WGYvMkZBdDVXNjRNRnZYd0hNNEZRc3RXbHZWREdWUXVrbHZ3OGJMMjBs?=
 =?utf-8?B?Y1U1ODVWcVdacXJYRVY1NDk2dEtZN2Y0REI3VmVvRmdLSkoxTDZCUytMVC8z?=
 =?utf-8?B?cEhZOEpRZUlDbWdnejdCdjdPdmE5Y0ZEWVBVZVZVdUl5OG96TDM1NXFzbFhE?=
 =?utf-8?B?SUdDMkZmWmtUazQ3TkhtZzJubG44dzMwY2pVNDAyWHViSjFUblpjNjd4Ymxj?=
 =?utf-8?B?ekV4VVNJckcyRENCaVRHUnZWSGt4SDlTWWREb3FkV0swaVNpT0E5QU1HL0xS?=
 =?utf-8?B?SHF6R05rYnBQNUdudWFiejVxNzU4dTE1cERJcXF2ODJ6dFRpeHpuOVZsZGFG?=
 =?utf-8?B?Y2FCNUN1dEJDdHRNdWtUZDEyVERVWjMyb0JKUERISXhEakFRMFFjVi81dXZT?=
 =?utf-8?B?TDAxVmRpU1ZQMFlJK0w4dGpDWkFIQmhUZDQwZnM1QTJpMEhDVHpJZEFvNlBm?=
 =?utf-8?B?Z1dkeVNjVm01U3VWZ3B4ZUhKZ1hueFZ1dW4zZkw0THFFa01WMjlGckpURGQ4?=
 =?utf-8?B?TUE0MGFPVkNpVnRpTHJ6RXlYcXFsdmMydjJWQ0oxQlVYUzhZdU4vdEgrb0E4?=
 =?utf-8?B?dWdpT2I0VXU5T1F1Wm5PenBHbnBvTHRyb20vUis2YVpyR0pxci9oZ3FabEY3?=
 =?utf-8?B?cUdYZ2dTZWgxbzU1K3hmbEFvT1hicG1zQVJZLzFXTmdTNTF3MlozNTh2R1Yz?=
 =?utf-8?B?Ky9rcDZYejVxY3RFb2VPL0FqbGJCcERoVjR1S0h6c0pDWmcwMXUwdHE4SzNM?=
 =?utf-8?B?Mms3ZGVRSGxqZXlzcGh2VnZaWUNwWUVESzhZckNUTmNXZGZnUElhK0trUjFO?=
 =?utf-8?B?OThTRHRQOTBqS0JXS3hVZ2RnakFqREF3cVlISmtDOWhzbTNLVUZ3SFBSYnZC?=
 =?utf-8?B?Vkd1S0cvNWFwVDFRTFJJSnV2b014NGJjeWRhcnZzTml5dWFiTWZpZkFDeWtI?=
 =?utf-8?B?czBlU1JqWVh0VWZieUh3YlNjV1drRDhmRU0vblNqeDRtcElhRHF6WUZRRExP?=
 =?utf-8?B?SUJIWlpEdjQ5b2JYUVdKUUhJLytXeVd5NThkYnRnTlFCT3FyVDNrTy92M1Zn?=
 =?utf-8?B?RkhmbGx5d1ZzcXc1U3lSL1ljSjlmZEM5azVlLzNMSU1MNkl5RWVicjFLWkxa?=
 =?utf-8?B?ZnBKd0ZyVStPSUZjTU1kOTFhTlF1ZXg0RmgxeklHUVlyZEtod0Jndzh3TU14?=
 =?utf-8?B?cGZTajQrNlcxN3VWL3g1TXp6a3ZOSEFjYXFHa0xoSmNEZEg1aHBydzBsZmF1?=
 =?utf-8?B?OUc3dDE1TDcyRVZwdmZEbE5hTGVnM202aDFLakJPVkx5WWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzNNd1g4QWw5SFpFbXVSOTBiTHBHVEE5WGU2VXI2MUFXWERjV0E5TFN1M3lj?=
 =?utf-8?B?QUVkOXQ5RHR5TnpaRW9oZWd1dDM3bm1taWtRTFFUamhhUG5pano1NnJVck5t?=
 =?utf-8?B?SGZFNkJNOXFQRk5kRVpiYThBeW5CMzA1bithZGNNYkFMWE1hS0VDVjd0TGh6?=
 =?utf-8?B?czdGR1ppM0ZQNEZ2bDRKNjNtYUxUcjZPbmJCaE56U0tJNFJZdGJISGJWQ0Q5?=
 =?utf-8?B?UW9iOCtXMGl0ZkRRR0dPdk94L1BSWGhMTVMzeWE4MjR0ZURhZDBoVzNpSklt?=
 =?utf-8?B?NkVBWGNvZUhGRDhhN2oxZDUwNXphYkpVcFFwZURtT0VsNG5LaGFTZFRPQ3ps?=
 =?utf-8?B?T0I4bm5ESWNGMERCUXg5clAxdVFORVZlU3ZLQmdLbjZreWpkNG5TbDRUdW1K?=
 =?utf-8?B?bjF0eTFTN3dyQVVZUmxRV2lBamtGdGduQ0VDb3MyVWdGTzBMZFB1NnJ0dEpk?=
 =?utf-8?B?RGZJVDFSMmlEZ3p3QlNjVXJkNTNVblVicE5Db3FMdkVvWjhhWEtlc1c2WGEy?=
 =?utf-8?B?NHN2NHp4bUgwbVRkT0xvOEJuRDB2dlpuay9PcmJNL1Y2K0s3TzZqblluYmZa?=
 =?utf-8?B?WW1WV3VJQkZTYTFsbDJENGhXY2grbDBVaTJpRm0xUnA3SFFXcGlCVVNjcjV1?=
 =?utf-8?B?OXFuZkdHSjdLMkREUFpBNGtPcDBidG1pbGQxNU92cXJlWnBoazBqY3VjbzhH?=
 =?utf-8?B?MWE5OXRTcWZDRVhRZHpTdEEvRC95ZzNYeFRXdHJhNWVnVWIzekg0RUhzOFFF?=
 =?utf-8?B?OGVwcFA5VGVQeUlzK1Q2S0RNa016RlpwSmwwbzlTcGlVSWhtdUxaSFVrS002?=
 =?utf-8?B?WUsvbmVvVWw1SklOOGtLZFNqU2IwUXV0VDlDRDczUWZnNGFwK2ZSQitsZXor?=
 =?utf-8?B?QWxERzlXWlhvNEFmdjR4cFROamZGMkZvN0U3am15VURZM01SdCtYc0kzQVJ5?=
 =?utf-8?B?TVBra21KKzBtMDU5VjBwVURLdjdxRHBaeld2cTRVdnpkVzNVMVEwQ2pVVWNz?=
 =?utf-8?B?ekVvVnViRmE4dWJQMGxKeUZFd2F3S09IdEpDbzFuL2Q1MlhuVW52a0kzUFVT?=
 =?utf-8?B?Z3R0QnY0b3FuMHcwc0FWbmwrZjUwSkJGZHRwV05KQkhmWWtqcE1JUGRBb01P?=
 =?utf-8?B?WHJRbnpDcXRCY05CQnZRTWRHb1MwaVNMWmhWMlF6S2hCbitqaWlWa2dHSnNx?=
 =?utf-8?B?bUdVeG9sdHR6WlVkZXlNQm5oUmthTU1GbXlidWJsSlFmWS9PQ1JIWTFuN3Vh?=
 =?utf-8?B?VmU5Tnd4a3VsTitPU0NZdThzT0F4ekRHdS9KVEhZUTIrZ2NiSUdtZFVVdlA1?=
 =?utf-8?B?NzRCWU5zaXRtMkg0VFN3TUVobnd1Y3pNTm05Z2Z3K0pkK3hRTFZuaWRoUCtG?=
 =?utf-8?B?S0JwT0lYTk5NSHFHb2VTTzFYZWVOSE56RVdBU2RHL0xtNVJMVFNwSmhYd0F0?=
 =?utf-8?B?RHdlU2p3ZGI3amovcE5hOTM5VHdMOW5rMnRUTnJpSkd5cFlMYUxqUkxwL2Np?=
 =?utf-8?B?YzJwL1M3T1dEQ3ljdTBiMzQzWlBMQjEydmVtcWl5VlBCSEFQc2FoNEg4dnZH?=
 =?utf-8?B?ZmpkVHB3SXBZcGFNUUFBK1d6VmpmbE9YRWFUN0ZUZkxnOTBZNWZURUxEbk9o?=
 =?utf-8?B?ai9KVjlGL21abkk2ZDN4bUtPbWNaOHY0MWFoVUZ3bHNiaHZRbFhmQUZuZ1R5?=
 =?utf-8?B?MEIzNWo0WkwrWTh0cVJZWmx2N2RYYTRDaXRsOStOTU9ZSlcyWlRpZ1J3UnFq?=
 =?utf-8?B?SmJTdzBvdUticE9CQ2pSYW1YbFZDTHA3Nk9DanEvUWNUK0pOWFdWQS9xektq?=
 =?utf-8?B?TWdRZ2RnVFBBV3lrRHU3bmh2WVduTTEzMFZjVko5cHhPZVdGWDFFSEw2eEJs?=
 =?utf-8?B?Qm0rZ0tKQVB0S2hwdFB4TVkveVlPcHJybE5ieWJsOTBraVF1Tkd4VFRxRk5E?=
 =?utf-8?B?M1d6U0V1My9tUkZQb0d6N3lwSWsyUnhYcWRCVGd4YWFHTVMrSWZ4TkFiMzZr?=
 =?utf-8?B?SHRYS2lxVHFMR0c3cmRWMERrZktjOUNHMy9mNGNzNU9oSk9CRWFKSFBDb1J2?=
 =?utf-8?B?a1ptU2xQUitjRHNNRk5ud2t0eTZjekFOUVF6QzZLeGVQVEVlaWxHREt1cHBh?=
 =?utf-8?Q?SWHtSEnruHdHNndYAWsLfcYBp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccb23e6-b3ae-461d-3aa5-08dcd169e87b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 07:26:38.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Irh9FjKE7u2DB/x0qroBy6uI+/sR0w5FZd+DVlGy93yUGgniV5bsLVr+YmfjigRibByyWTb0j8vnq4QmFDsVPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816


On 9/10/24 07:12, Li, Ming4 wrote:
> On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differientiate Type3, aka memory expanders, from Type2, aka device
>> accelerators, with a new function for initializing cxl_dev_state.
>>
>> Create accessors to cxl_dev_state to be used by accel drivers.
>>
>> Add SFC ethernet network driver as the client.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c             | 52 ++++++++++++++++
>>   drivers/cxl/core/pci.c                |  1 +
>>   drivers/cxl/cxlpci.h                  | 16 -----
>>   drivers/cxl/pci.c                     | 13 ++--
>>   drivers/net/ethernet/sfc/Makefile     |  2 +-
>>   drivers/net/ethernet/sfc/efx.c        | 13 ++++
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 86 +++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++
>>   drivers/net/ethernet/sfc/net_driver.h |  6 ++
>>   include/linux/cxl/cxl.h               | 21 +++++++
>>   include/linux/cxl/pci.h               | 23 +++++++
>>   11 files changed, 241 insertions(+), 21 deletions(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>   create mode 100644 include/linux/cxl/cxl.h
>>   create mode 100644 include/linux/cxl/pci.h
>>
> [...]
>
>>   
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..e78eefa82123
>> --- /dev/null
>> +++ b/include/linux/cxl/cxl.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_H
>> +#define __CXL_H
>> +
>> +#include <linux/device.h>
>> +
>> +enum cxl_resource {
>> +	CXL_ACCEL_RES_DPA,
>> +	CXL_ACCEL_RES_RAM,
>> +	CXL_ACCEL_RES_PMEM,
>> +};
> Can remove 'ACCEL' from the resource name? they can be used for both type-2 and type-3 devices.
>

Sure.

I'll do it.

Thanks


>> +
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>> +
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource);
>> +#endif
>> diff --git a/include/linux/cxl/pci.h b/include/linux/cxl/pci.h
>> new file mode 100644
>> index 000000000000..c337ae8797e6
>> --- /dev/null
>> +++ b/include/linux/cxl/pci.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_ACCEL_PCI_H
>> +#define __CXL_ACCEL_PCI_H
>> +
>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE					0
>> +#define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> +
>> +#endif
>

