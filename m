Return-Path: <netdev+bounces-180962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D117A83498
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5669188FAF6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 23:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C0C211472;
	Wed,  9 Apr 2025 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DD2aT25+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390191F956;
	Wed,  9 Apr 2025 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241555; cv=fail; b=n1CIxmgoYhs/NhSaI7Jzf8Sh2o0DDWiyAk3dsw0ys+foALbtwMFnvmCqc0xxWoI1qg5zjtwQyvZrmRs5stRrHxU1EStfFDdtZ5699C59hdbIoV/ZB+1mCxuRwT78LwDKHtZ913IvsFba1F4bZQdwWvxriudT6XRheCiZsVGQ7xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241555; c=relaxed/simple;
	bh=qi/twnWvDXefI/bDCRfAudqx4frx5u1bBGXWMwuRndE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k1tTTzKQvsUieYNIZcEoVIqTAitJk92a5J2pUKZwl+it7D22/vGc6W15yCzsfZyM+o88JgvKWgRlQZATtKbaPB/ycKYlEW/fd+Q0wt4RfUt8hxRa3+ZqzEgW/0RiRMgH1me2s0v33s3Q96pCGEW1yDKSleliYWBsV1QDNq+CpjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DD2aT25+; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DW/pTyUXlWFVT68rpdwTI9QJo3U/ugOixVup6ttwS0JFNlrmB9eg4FyJEBQM029HqapinekRTPPYx0zXALpL9Flp10mA2O39PudZto87fHP4MGwFEgDXx6HUXVIYk7be7BgHFVmV2x5IKOqc7WzXTWJWUrSLogCq8DB9ak7KgcyfwbCPRNIVfe/yNPnvx52MxA6V7hR7YoQPcUeKUBLpRyjdNXUaoxFJ9Ko2uadP6/O0C2jdwqu/AxASC266fx5qDT1u3oflf1FBePM2bNrKg+h7aHr5HbijztsiQYNGfclZmrlaWBR0rX1+g+xhUm10e7qBBWZmeV2b0ny63u3d2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adgUsOnQJW+PYBrGh44fbxUFQDdXXkB1k+n9Nwqvpi8=;
 b=Gd8RQjHV5FsjlMYF7xYCAQJIL7B27Cf8Y+aNXtqlNyrQj8oZIEoOBdb0bquF36ZCy82uztAzWO2Qb360kLg79tlzvTVrz4WGKNqVdC3IvtOa86/JZaehJkFCL7qexPm++IZ8pUAwjkh1ALLJl1bhKSodLrlL8JvCHUVGEa2nEY2OIF4VmkD7UxoFNij1UVqYFAdbtTtXWyOaR4hRa1qub5sO8bfUhkNq6cEjbGrPl6tXkuMXQgWoggyLR45QSXWiMldkwRbhNhNAhqt76eYmFqUf1fdLsxZXxf+EyMk6ye+ib/j5+K7jm8Hvit7T31PZ/2Bj3JraEqCVQbMF6cvqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adgUsOnQJW+PYBrGh44fbxUFQDdXXkB1k+n9Nwqvpi8=;
 b=DD2aT25+5/Eh3lz3nFzK+cV0n07+6P9wY0KslY1xsLATLACPFSCYtymKYWpQUYArW4Eokbx98Io5mVbNdJE8b0cwzKjUmx7RGzQD0B3l5B4+0Ar8Aq3zontoCY2zCgxqQibaM0rQAjCKWqaNBh8980azDfuehunDTXnjaL/RGiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Wed, 9 Apr 2025 23:32:29 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 23:32:29 +0000
Message-ID: <15f8ff56-0359-450b-9fa3-cbb57781985b@amd.com>
Date: Wed, 9 Apr 2025 16:32:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/6] pds_core: Prevent possible adminq overflow/stuck
 condition
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250407225113.51850-1-shannon.nelson@amd.com>
 <20250407225113.51850-2-shannon.nelson@amd.com>
 <20250409093730.GJ395307@horms.kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250409093730.GJ395307@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbd313e-4404-40ce-3cdb-08dd77becb21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEMvMTVCaG1zY3dTdk5qaXdjN3lSd1NtbGFjeUd0N0w5WFJVTHB2ZkpWUDJN?=
 =?utf-8?B?SUxEdlE2bllZUmQ4cWJZSjUrb25kc1lVUjNrY1VydzRIVFlwT1NEdEtsdDdT?=
 =?utf-8?B?bFYxYmt4Z1BKeUx0WmoyVFdJREh2Z09MWVkvLzErOXROUnc0QlR5M295Qlpm?=
 =?utf-8?B?Q0JNMjQ5bnUzVncvQkZxcXk1VFkxb1lWWGJuUVc3djFkSjJTbERWN0dSOUd6?=
 =?utf-8?B?c1BuODU5aTJEM3lMem82VHRQaVQrakkvNVBuR0w5RkFpS3BheDVnVi93WmZq?=
 =?utf-8?B?Z0hRMzRpdGIxMHhyNVlBNTBZRlhheU1QQUt0VER2d0dQQUdDdmFnVnc2SDV1?=
 =?utf-8?B?Y3U3eVBlTUtBejJybnNJeURDLzU3QndFRldNSWVwcEtqVFNuYmo3QjhoR3VN?=
 =?utf-8?B?ZDQxM0tLNVlLRTJTQkR2VHUvLzZ1UVJEa2hnZVZleFNDTWEzbzJKQllVRUcx?=
 =?utf-8?B?cDEyMEI2SmUxc0hBaWIzVXVMZDczOUZ5YXBFK1daMWs2b3JYdS9FT3ZLaW1O?=
 =?utf-8?B?Qmt4cS91NkJncUdPalEra1BGV2JzSExmbzlteVczaWtManduV0dLWk1iUlVl?=
 =?utf-8?B?ZUZMTStCeWp1NFMrYk9zZzllQWxQVkZCM052NUtrLytBREVrdHNjRUZvYnl0?=
 =?utf-8?B?V0J5UGdxRXRONFBrVnNjaFAzQ1Jjazk1RUJSWUgweGM3bmp4L0tsK3JQZyt2?=
 =?utf-8?B?dlprZG9Fc2lIREl6Q3plUXdtZmEwSk5OSWg2cGFWTG0yMGFVV25EdzBtaU5O?=
 =?utf-8?B?V2xmaUpCbzU0STRic0RVRHpobzllak1yVDdZeUdGMC9SWTBCVTdBRWluR2Vs?=
 =?utf-8?B?OUFEb3RzaHVWZGZ3dzUzN2h3RVd4T0ZFcWpzaCtaT0puSkU3Zy80ZmlkOXdP?=
 =?utf-8?B?RzkzRGdod0l6dS9XVTBUaFBaak81MzFPRjRqS2RGcld4cVlkVktSWDNuNVhE?=
 =?utf-8?B?S09laW5tWnM0Mzd4UDI2ekJyYUtOYU1jNkJOV0NrdFA0UFh3eGRUMERsaytO?=
 =?utf-8?B?SkNTUG5UalI0V1dhTHV2akQ4REtIMXZZbVFKcHZUOXN2T3RvWnAvWEtHakdK?=
 =?utf-8?B?RDlXZ0orTXJVQW9ISWdGczJtRVJ1dzdna2lMMGo4cUdPb05LN0Z2L3VlTjdq?=
 =?utf-8?B?cHQ5Y1pLNGFXckJybUhWRDZ5d21wVytrM29OT09NRGFCUjdqbFBMeDRJWVFj?=
 =?utf-8?B?d2lyNi9KakZadENHZVJjc0FUVlVrdlZRTExWMHdpVHhtc3c1cUVnT0ZzWjMx?=
 =?utf-8?B?TGdyRGw4ek5PYWxUMkU3SjlVRWxPbGtNQWs1MWF4M1FrdWxkdnFoUkFNbWN3?=
 =?utf-8?B?NGdDRkJyV1d1NEgvVi9TM1RQWHVrUE9NdEhRRUZlVms4NksxWFRaWm1Zazlh?=
 =?utf-8?B?UU44WmJYOUIxaUVGZDhLZE9LTjdibXo4YVJMbUFvdHdJb0V2UWw3VVhKRVR1?=
 =?utf-8?B?ZmFta0hjSkZ1UmlpVTdVVzFxTWR0WFRVVGVGUXplTGlZT2lvckJnL0VzaDlC?=
 =?utf-8?B?OXAwdWk5VWJrTzBUem51TVZjdEFNMmNzMnJTV0xBdCs5QWZISFhFWStrVUJO?=
 =?utf-8?B?WHRFTFdTVHlDYmpic1grSHlOTnYyYVhsWVNRMlRvOXdUQXpVTENKQmZXUW1v?=
 =?utf-8?B?aTBGZnpuOTZVYnBWd0UzU1kvSmtKRERldnBoUExhQ2JoN0hrVUhaditqM2JX?=
 =?utf-8?B?MGM1Y3Y3cHVEeldaMVF2bm1DdXB3R1lEWEFpbDdJUWhKQ0sybWRIc2Z6bldX?=
 =?utf-8?B?ZDY1RWIzTU81RWZGVzIzYWxvV2ZpdTcrN0ltM1pSaUZTNjg2dDFkZVhjaThC?=
 =?utf-8?B?V3lBWGN3YXBpTGh3U21weS9STW9zL2hnditVT3pLSG5RZTRiL0FqU1UxZ3hu?=
 =?utf-8?B?cnBOL2QvMytKRkVFM1dzcDFPeGMzT0IrRVBuRmEzOWloQ1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVBpejRMckdFZm04OXBlOHdKQVg5TGhUSVpVL291RXdSZjVTYkc4dWF4NVhR?=
 =?utf-8?B?eHlsT2tvWE1sWm96b3p6QTUvMlhOOE0ySm5NL3hmRmp0TFRCZGVGbjhCKzc5?=
 =?utf-8?B?ZFlnbERXeGJrK0lCL21aOFV0QkhmMWFybTcyYVJQcTNzRjI5dUVqOHBzc1VP?=
 =?utf-8?B?WUo3WVJoS1I5cllOQkJ0RVZWeTdLeEM1cC9oMTBZQ2dPVFBKb2Z5VnJleThU?=
 =?utf-8?B?YTExZC9jTjJLcytoOFFGZjJwa3JxN3k2VWhOL2FnR1ZIRC9QeG1Da2ZKUUFS?=
 =?utf-8?B?ZTUxekxLVHJXZEdFOVZiTGVOcUZGSjRFNWNieStETE1XZk5QR0VaUUxWaS8z?=
 =?utf-8?B?ZVd4emIxcmprNVlwVnR1V2hacFRuNHRvMXoveEVUOTM0ajg1MTdLUWFWOGlO?=
 =?utf-8?B?a3dlTituWXdOdXgyVkg0MVJuOHpIVXFzcVhpbVdVTk5OajRUS0J0ZzduMEVC?=
 =?utf-8?B?SjRUR1VLQ0N6Mnp2dm1iRUtBczBoaENvQS8wTVhjellUbndwS1RPNWJaSzVI?=
 =?utf-8?B?WG1GNCt3QjVBRU9hVWh3WC9VZ3RZQUZWZll1SDZRMGN3RkwwVHZMM0VWb1Iz?=
 =?utf-8?B?QkswWmZmblBYYW5pYjRwMVdMb052V3M2MG9vTFo3TjdPejdKOW51L2ExczVS?=
 =?utf-8?B?d3ZZVWdkaTdWV0ltd05uUWs2S1hibHkvVDBqbk96a0FEZk9DbktmcWdjNys3?=
 =?utf-8?B?a2wxV1RldXFQS3h0TmVtQjROb296MSt3Y2FvMXlvcUM2RXZRRFVVT285NjNS?=
 =?utf-8?B?ZjNxeDFuSzR0bFowNjU5a0l6eU1PcStoK3pCZUlUTk5sd1M5TmY5TTZOc0xO?=
 =?utf-8?B?WDlyeS9KS3E4RXpMT1VNRk8wZVdTUExMZkJpU2FJM2t2TVRINUxQU2VrSGJ4?=
 =?utf-8?B?L0tBb0h6OFVxWlZNeDlTcnVEbzJuNUNIRWRreXFjSkVUb1czMlJ5UVlPM2lv?=
 =?utf-8?B?VTAvT3Z2eVhLMmhMOWFpSVphZGRYcUE5QmNpcDlaU2J3YzhTYlpLenc4T1dO?=
 =?utf-8?B?MW1jVXFNMEFFK3pUcExPaENIUEdrNTFoNG5DRVBVOG91MGtHSitrQjhIRkVB?=
 =?utf-8?B?UnhVdVFzZVJYb1pneEtNb3ZnSjZZQmVpblVsZWVBMmZ6OGttaXNpWm5GY2JP?=
 =?utf-8?B?TE5VanE4WUNQOUptMzZpbXhROFFtWFFkaXRJeFk1b1E2VlBtNktnT3J1NE95?=
 =?utf-8?B?OW43S1NCTm1OU1RsRlBrNXZpRkwwdTI1YlFCK09zRjV6UEdjZ0tGOFY3ajhs?=
 =?utf-8?B?aUNTWm5qN2FhYXRGamNZY1RKRnZhZ3MyRm43czJ1Sk1XeTJ1M3BmelpFYUI3?=
 =?utf-8?B?anFGcDRRaWJHNHlhYUlXTW41cXBjTWdaRE9sT21OY2lFc2hBKzFIOEFDc09Q?=
 =?utf-8?B?SEVuanh3YUJzQlFiUWJ2bjNKZDYvMHh1Qk1pK2NkcndqY0JueCsvd290dkdy?=
 =?utf-8?B?eEg1V01sNEVZNVhPbk0yK2dNWmFua1FxWFlhbHZMQWVtaEZrWktUTGE1V0VG?=
 =?utf-8?B?RkcxMFExbHFlZDRvMXhsRWxHSUVNdEFvTzNuRzBpcTU0am1iVlRWdFc0amhR?=
 =?utf-8?B?T2Fmb2FiWkFrZkh3NDdONVNDZzUwenBtdkpSdFVQNUNzc3djWkQzMVphS01h?=
 =?utf-8?B?SGVPRDVhaU9xaE56VDBKTjNQTE1VMlhKQkhUZkpJa0VhOUt6TUdDOWkzQjZB?=
 =?utf-8?B?bEFVZXlpdnFyYmFLM05TcXpWTGJWV1UrYjBodStQUUk2WkU0ZVoxTklrRXZQ?=
 =?utf-8?B?QkFtbzNyVHp2Z29jektEU0JMMWRHMEZNVHMxRVJFMTJNVHdqODlZS1pIMzA1?=
 =?utf-8?B?cHNWcWNsTnB3Q1ZrSC9tVUV6WE10bUxFbjlkMkt5a3VLMms1U2d1OVZuMFRn?=
 =?utf-8?B?akY5bStmSkRUaDM3SDlPT2cwU3dPdnhVMHdnbFBWNW9PRElWdXBQK2RFd0g2?=
 =?utf-8?B?WktLRWZ3K3p5UDhYamN2ZE1xS0swYzAwaC9JV2hua2NFR3hBeWhMVXNSMG4x?=
 =?utf-8?B?UXYwN0NXYzJQTkN0YndoQnpCaWlMaU1ZSFVDTVBsZGpqdjhuc0NhQTIzV0J1?=
 =?utf-8?B?b3A1eW1NRTUwRUdIWmVLQUFkVnZkTFdKYWJaNCtvMDdzM1V3bTVpdTV5UGxF?=
 =?utf-8?Q?FxzhAtHre0uNyBZW9Rv/H9jNc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbd313e-4404-40ce-3cdb-08dd77becb21
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 23:32:29.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZJfreypatvNTaZG9WfabUG3PynA7ha3g5uKNHe5k655QfnfnHe2V75BAjk5PpJIuZy5v8HK2c0jlyjHZnVXgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450

On 4/9/2025 2:37 AM, Simon Horman wrote:
> 
> On Mon, Apr 07, 2025 at 03:51:08PM -0700, Shannon Nelson wrote:
>> From: Brett Creeley <brett.creeley@amd.com>
>>
>> The pds_core's adminq is protected by the adminq_lock, which prevents
>> more than 1 command to be posted onto it at any one time. This makes it
>> so the client drivers cannot simultaneously post adminq commands.
>> However, the completions happen in a different context, which means
>> multiple adminq commands can be posted sequentially and all waiting
>> on completion.
>>
>> On the FW side, the backing adminq request queue is only 16 entries
>> long and the retry mechanism and/or overflow/stuck prevention is
>> lacking. This can cause the adminq to get stuck, so commands are no
>> longer processed and completions are no longer sent by the FW.
>>
>> As an initial fix, prevent more than 16 outstanding adminq commands so
>> there's no way to cause the adminq from getting stuck. This works
>> because the backing adminq request queue will never have more than 16
>> pending adminq commands, so it will never overflow. This is done by
>> reducing the adminq depth to 16.
>>
>> Fixes: 792d36ccc163 ("pds_core: Clean up init/uninit flows to be more readable")
> 
> Hi Brett and Shannon,
> 
> I see that the cited commit added the lines that are being updated
> to pdsc_core_init(). But it seems to me that it did so by moving
> them from pdsc_setup(). So I wonder if it is actually the commit
> that added the code to pdsc_setup() that is being fixed.
> 
> If so, perhaps:
> 
>    Fixes: 45d76f492938 ("pds_core: set up device and adminq")

Perhaps... is it better to call out the older commit even tho' lines 
have moved around and this possibly won't apply?

sln

> 
>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> ...


