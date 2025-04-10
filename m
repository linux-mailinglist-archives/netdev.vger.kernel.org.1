Return-Path: <netdev+bounces-181327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6959DA847BD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7C19A8017
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4431C1E834F;
	Thu, 10 Apr 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AUTsUNEm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98359189F5C
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298649; cv=fail; b=Cq28E+UdSM8s5c2DF3Ia6fBjfHhWlPTtT4Eu6mt1knBJiZkC4al5j4vDQu+xp7cdzR2X7i9//97Lz8k8lP6sKRvEZzQcIqoiIYlz2+93bL0Supi3obHPfg9CIxxdwP+dJlNc8f3DypPEsqC4q3yTGzLq62cgGzGy9ggVIvyEr8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298649; c=relaxed/simple;
	bh=EQPJgRL5CNnHRXE/Bdf1zF3oQX+hW6dXW39S6/YM8kc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WdQLRXUE0Ooj8HH6vHXRBOIwSa9WdOMpOdl0r0NOhC0UERkxMhwel9XMIkbLSRRbjMd5eUY5mkAkYDR7s1A8WJUCBoBdxqoNDBzVP1zaRo354e4m+QrCLjFRGoMADd0o3Xj7E6vJIELiJQddis01EDLJVJ6Sjkd86K05Q49qzn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AUTsUNEm; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp/+pBVnMyevJEza5fb/AryE3+83pVssuFcRiCylziJXhmZGww2RM06ZnMGUoMT1Qc2ok8Sx/b33okRj9oCNKkxqojq0yFUzwzJ1R6TQm9CHspp5FETUBtnYo6McNq86VDO9mlbI/0yBJIFZlVQ7//sqvE7MzBYrpCrhBL+j72ZhTx9yX8JL7XJ8bDQEl/5TxWRpYhOaLx59ghoauxvohM4nrO/K1wfeSH1pFHb1Rru45SL68YpIVJQWNOscHiRGZk8v0OhjCJU40FOSKV03p6uFpGNlJhRC7dMT9U/EjOOpcGVxlPYpmU7XH85E6+/Gf2vttudE0TV7E6mV5XhvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3usw1niW4dl9Ig+PVkKda3+wiggfTKElE72T1PhyUo=;
 b=X711gNAT6CIcAG2ZcOal7/0lfkl3+a8X43loQITXZds0mDe7Jcfd8ggQiNRZa+Dh9GXDvzPdD8amdj7W9+VRyGudAxwMzVrG27PnI6xkmPkRdLmjfnXdA8ggnRNYgU1hM3Y+Yxa5ZDWso5NDfBU93O+g6J47lbM14oMDi2h11w2/7RngmoiSDxz2nh9yAWYT4jdNEtad/BhnSMrt73YMbpuskkmziaj+wdEefWPnGitlzzeoinGXDKWWEh8aGikrGiv3+magqV1UamXZO26rWnMAz5lJ6+S9d76TsiJ7EygYgbYym9SYEcayoovvXOGLS85sA8/EM6LPZZw8mqW14g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3usw1niW4dl9Ig+PVkKda3+wiggfTKElE72T1PhyUo=;
 b=AUTsUNEmiL6JvCQoZPdv5ermv9fnziIByPSHxY9SuvDAVJ0fZ2vXvUlilaJMYGBF1lxoHBnqgbFSSdElGKmzhijTKngt6XM5C8PeLqNc+v+cUgJaXAu4OqqLpMdIuG8argU/gBMWxdN57jlp8ARbB/V3z1V0EEX+9ArPRBEoQtwSbnvHTHD7d6Y3ZjhWbMGumUblURfCB6XW0TtwrXlAGMgzbtFxNAm1uMVPldxHCHCKp7GbvjDVDSAtls3I/XdsSHCJY1NCHhRI3Gk67g71tXfqsGLTYhu2oTYSU5wyRtqj0hWOCLwO727hPtzE4koh9JaPCIjRVPVxqwkeBf1eRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 15:24:03 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 15:24:03 +0000
Message-ID: <2f747aac-767c-4631-b1db-436b11b83015@nvidia.com>
Date: Thu, 10 Apr 2025 18:23:56 +0300
User-Agent: Mozilla Thunderbird
From: Carolina Jubran <cjubran@nvidia.com>
Subject: Re: net-shapers plan
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cosmin Ratiu <cratiu@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
 <20250328051350.5055efe9@kernel.org>
 <a3e8c008-384f-413e-bfa0-6e4568770213@nvidia.com>
 <20250401075045.1fa012f5@kernel.org>
 <1fc5aaa2-1c3d-48cc-99a8-523ed82b4cf9@nvidia.com>
 <20250409150639.30a4c041@kernel.org>
Content-Language: en-US
In-Reply-To: <20250409150639.30a4c041@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0413.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::17) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d399ae9-7e48-43ff-52f6-08dd7843b999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDBwTFRWdHVrNEl1aU9kTFZkOVJvOEx0QXU0THk0WUlFNXZKZ1J6d0NaeDYw?=
 =?utf-8?B?b2oza1p2a0k1NWx4cmFXNUxoWTRqVzRaRC9WSlpUNVoyRVQ5NGpJYk1jY2Nv?=
 =?utf-8?B?bmtDcHVIeWNVekVYSGE2ek80MlFBbVhDNVVYQ2d2eGdCT2NXUXROYzk0OTVh?=
 =?utf-8?B?WDY1enZabFp3ZTdEcTAwajNwMzN1NWZ2eS8rVzdoeitBdWhPaGhaalQ3NzBO?=
 =?utf-8?B?Zk1DYnNtOUxyNTNiMDVpMFNRQkhud1FBQjdxSDYxTDFVS1BEM0hBUFdFYUdD?=
 =?utf-8?B?TVhQckhvTzhDNFk1UEh5ZnFYOUluS0ZkeUV6b2s2YUZzUTRZdUpVcFllNm1n?=
 =?utf-8?B?Z0JySmlPRUlnWmdXR015N2JRNlFwRVBGSFlDb2lONEVBbHBPaHVCRU5nc2gy?=
 =?utf-8?B?NE50ZW8xeVQrci9sNmNvSUpBMDRVRzNrS3ZmblFocFRIc2xmblJrQXlEVmxH?=
 =?utf-8?B?MGtyQk9iN0Z1WDl2alMzNURlZGZWN3Q3MFVRYjdZNzFpWjhsNXpXMGVEWDB5?=
 =?utf-8?B?L1ljZTBOVVZranVEMVFGMVlXbjVBUUNIcjZFV1F6U3N4ei9OVkFGK3FhSTNn?=
 =?utf-8?B?TFE5NlBrV2dpbDhhaE9ZUU42VERWcmp4VlVIMFNaeElhWENXbE5xRzRVcTZV?=
 =?utf-8?B?NGJwY3ZWSjdsUm1tc3UyeVo3ZFA1NnFZdS9oc2VkU0wwc0lLMCtteFJ1MmE0?=
 =?utf-8?B?RW53VEkrZWNHTjFtK2ZvWEpockNva0RNY3RRVmJHMGlzY1k4WWYyeWR3U1h1?=
 =?utf-8?B?bWhOSC9SS3VpOFFhS3FMNTlvaG0rb1hnaWloQnl0bVZYUlJ2VGNTSDRKVTFL?=
 =?utf-8?B?M0hpdWVGTm42UmVmNEt5SWs0WEtGNndta0c0UTFxTEVDZndRUGMxazlnbmRn?=
 =?utf-8?B?Yk9pR3M1ZGovWTFVQnNvMHhpd3ZjMkRIdnJzb1lrLy9FQjYxNzdSRFY3VG05?=
 =?utf-8?B?RXRjZnduYnFYbUg3K2hKbXR5UHhQSWJzbXk1cE1OZTZrYStrT0p0cnpjVnp0?=
 =?utf-8?B?eVJuT0QrSDQ4UlJqOVcycXNTdDlteXN6S3RYS1pwUjhMU1dTUkVpVWdVL1Ux?=
 =?utf-8?B?d2ZwaWVKcWV2SUgrbS9taWFadHZ5VFluMERTOTQ4SU1VVlhUOUZpQmlHa3ZZ?=
 =?utf-8?B?dVBwL1U2c3hIUkVCRVB0UXJ2THByQVRaOHJVMGRIUjgvVTc4elJ4bDFwaDJP?=
 =?utf-8?B?ZFVZaFpmayswNC9BZjVIM2tQamJkZmdaSWxnYmpEbllGU3JEUWVVYUZ3Wi8z?=
 =?utf-8?B?cSt6Q3dwYUxrTjhhbzNGekpzT3hLOG4zSTBVcWVBZnhXdWhGS202V3oybits?=
 =?utf-8?B?VlEvcGp0a2pYUnVubHhSMEM4R2RLdHJDTGYwd05nS3BTc2JWVHJmeWU3RWhZ?=
 =?utf-8?B?UGRidUNKV0dlUHc0L3YwNklUQytLZ1ViNzUyN0dMNTRtdHpMVDFRWU9lUmtL?=
 =?utf-8?B?azMxWkJZekJyVDRia0NRRmdsUDN6Nld1Kzk2NDV2ZzVEQ0FUamY3Slc2d0h1?=
 =?utf-8?B?c1VwOUI3dFY3UWlUaXlhekpKQVF5Vk1mbDlWclowTkdEdmk3MmhDZmxIbTVF?=
 =?utf-8?B?Yk00akRVRTdwR3RtdkJHUUlabTU2S3hSb2xaNEVxMHhGMUplakN4SVY2R3Y0?=
 =?utf-8?B?OVVqUU5UTUJTMnFhUlNVaDI3Z0dacnV3UnIxYWpxMlhhb3FSWStQQzNJZDA2?=
 =?utf-8?B?bFlJdDl6NUNQaEowNjNEYno4Y0ZnUlRNUmFoM1FCTGh3Ry9ERERTV2t2THJx?=
 =?utf-8?B?MHZwYWNOZld0WTVWeSswaVBOSzZmSEVtNVJ4eEdZUndqOXl2QUc2REd1cDAx?=
 =?utf-8?B?OVJNVW9lV2RsVDJGN3I3bmlQc2JCbUhZbkpkdVQ1ZDlERlNteEhYWmcwRGgz?=
 =?utf-8?B?SDUrSGdiZjVvdDV4TkkzdEJBcEZmYUZvT1lZUG55T01URkJ0R0VXd0RCTFRj?=
 =?utf-8?Q?VxRyb8f5m6c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDlETzZKM2xQZTE3VlJETVdyZnc4RHJCOEZhWGlnaWpjU0tMT3NjcVBwVUxD?=
 =?utf-8?B?ZWRmYXZIL3Q5QVgzbjlKWklhc1V5bVlIbEo5Z1poUXo3VWdtZUZTTXRlN0s0?=
 =?utf-8?B?YkhQKzBhRkt0QzI2SnNDVGZ2TUF2RSs4YmxsUDYvMmdrQUtUSWw0aEpraW5i?=
 =?utf-8?B?ZHJuZ3k0RC9SeCt0cUx3TmR5WUJlUThrMFBidHFhTlBlRGl0R3R0SS8yNzBS?=
 =?utf-8?B?ZmhieUxlbjhJQ29NMkpVTk9uUXNqbGU2S1RUZlRZUVlCTnNMTFhVaWpyQUV2?=
 =?utf-8?B?Z3EzVmdPOFpFUk5uUE4vY3lmWU95K1BnM1B2Vnk0dCtoWm1hS1RPZkZVTXBs?=
 =?utf-8?B?Q0l0VndEeUJvSXlJTFZBRnRSc1JWSThwRUtzeDZnUFo2R3lRamVuOTloa29B?=
 =?utf-8?B?K21aUnpCMjhYZ1pPYnM1b1hRNDN5Zmo2VWU3Z2RVR2Y3WTlMeWcvSVora2E1?=
 =?utf-8?B?VU1rb3pHSHgwSFVUbkJNTnFHTDV2amhNQ3BXeTZSRUxZaWRSdHNzbkJlMEdL?=
 =?utf-8?B?WXFZK0N5UTFtKzZFbmdEc3IvMnJpWU50Y0Fha3hxTDYycmNFVTJKS2NSUWpK?=
 =?utf-8?B?T3EzNVBEcFYzMUI3Uk4vallzYXplV0E0UUR2V1VPcmlueCs5Zk5veC9DV2I0?=
 =?utf-8?B?bDE4L1NRbzhGMk5rUXhFNUtlK3JFSThLRGZ3d1ZkV2ZkalU2ZDZCMEJQZW50?=
 =?utf-8?B?cGNmcThhR3NJYmE0dWZHV1FHNUluTmxOQXVEK1pMbTFlZW8xUWkzeFdnVURr?=
 =?utf-8?B?NHdCWG52VXNKMzZFeSs2dWI0YzFOMVlFSFFXRlNsRjJYdFFNTTBFUkpnVTlJ?=
 =?utf-8?B?bHRvcFJmTXhYRHhtTkVmODQ5SzNCYjU5WGxHU2pjRncvd1JFemxnZGUxOHRU?=
 =?utf-8?B?Szk3YVVTekl6aDBBeGg0YlE2KzFNU212QzkzRXlTUU41YTI4bThwYTJzcmxS?=
 =?utf-8?B?bmxqUHdxZ3ZhZW00eUc0ZmVmN21WUzhPVlJHT2xqb09VczY1MUk0SEV4ODUv?=
 =?utf-8?B?T2Q0VGwzai9VaWRmTmc5TXE4NlVKSkMvbTdsY1JIMVk4UlpTTG1zUzgyWGp6?=
 =?utf-8?B?RnNvVG1GY080TVJ0ZkVSTUZHYU4xaU9lZmJvUS8zZHN2QkhHak9Hcm9PQ0ph?=
 =?utf-8?B?SGNyVDlNT0VyTUgwTXdLNVM1bkxJWU9KZE1ydTlJZ0RCMkczRmp2YTNCL3Rs?=
 =?utf-8?B?REM3S21NckZVN3VtdS83ckV4NTBNbk0vWXIxbjh4WE5BU01HY3E4eENudmdw?=
 =?utf-8?B?bHZrT21ZZUcwOVNPS3h3NnZzTktRQk9wT3g3cEk4QnhLWW5PaHhsajVSanBX?=
 =?utf-8?B?T0Z5djhMb2wwKzRQb1owVDZVSlFCSExlK25BVmxGOFhwNmVQdnVsNU91R1Bt?=
 =?utf-8?B?WFZlY2E5azdvQzUxdXIySHQrSmdkTEVhTXF2LzdTTDNVWVUzSVA0OS9raCtP?=
 =?utf-8?B?TzVLNVpJQS9PSEluYnFIOVlpYTI0QTlCdXIvMEdoSzZRT2FJeW9aKzNUTk1j?=
 =?utf-8?B?OTdISkQ2NFZTRDYwbHNFdDV6dkNTR0wyL3E3dVdvcmdINi95RVR6Mll6VmxU?=
 =?utf-8?B?eEJjMzcwY0l0WUlVMHFXV0g1Q1FaZmJrMkRBWk4zM0VXUjhWa1R0byt0TVdj?=
 =?utf-8?B?VVZUTVlLWXVHRy9mOVNYVVVwaVduTHpZVnlObWFlT3lYMXE1NlVOQWVXb2E5?=
 =?utf-8?B?a3paaEZKU0U2dktDVjR5UnlhT1h2bkFGRTB2SENGSENKSktYQlIxMDl5RmN3?=
 =?utf-8?B?WGdsakU1eVNvLzR2RTFqQmxPNC9vK09vQkU3SXJFSWl4cDdaeXJoQUlXV1Vk?=
 =?utf-8?B?L2VoMkpPWTlyUXlPNFlCaWo2Z24zQUw3YWpEVTFMVmdMS1lRQ0U2YjZMSGRW?=
 =?utf-8?B?NEwrdVVBazVrQ21TUnNHWFZMYTZ4Qm84UURzR3BZNlBtOEFjZmdNS25CV2Vz?=
 =?utf-8?B?ZW01MFozSHpsV3hSV21tRmZmYnFaalhYQjVNOTFKMDJpV29wY0JXSS9DTXUv?=
 =?utf-8?B?WGg2WStZYWZsTmYzaXhOcGlQY25oRTZoRU9oQVNYVUIyakdkbkxLcXEwWG56?=
 =?utf-8?B?ZDcxT1hFQ25ibWtoT2VTWnJGbjNnQnRHaThKOWpzc3dROGNzUFppcGZXeFVS?=
 =?utf-8?Q?vQdobbY3rs1Cxr34mX8i4cioa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d399ae9-7e48-43ff-52f6-08dd7843b999
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:24:03.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7EcSNH0jgVeq6MqrWMrmPjuTI6f927oxWi5ST7PMDHcwh2gQ+NksRU5DKBmf8VImvvvUBkvglGz7Imfh5Hoiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124



On 10/04/2025 1:06, Jakub Kicinski wrote:
> On Tue, 8 Apr 2025 17:43:19 +0300 Carolina Jubran wrote:
>>>> I don't believe there's a specific real-world scenario. It's really
>>>> about maximizing flexibility. Essentially, if a user sets things up in a
>>>> less-than-optimal way, the hardware can ensure that traffic is
>>>> classified and managed properly.
>>>
>>> I see. If you could turn it off and leave it out, at least until clear
>>> user appears that'd be great. Reclassifying packets on Tx slightly goes
>>> against the netdev recommendation to limit any packet parsing and
>>> interpretation on Tx.
>>
>> The hardware enforces a match between the packet’s priority and the
>> scheduling queue’s configured priority. If they match, the packet is
>> transmitted without further processing. If not, the hardware moves the
>> Tx queue to the right scheduling queue to ensure proper traffic class
>> separation.
>> This check is always active and cannot currently be disabled. Even when
>> the queue is configured with the correct priority, the hardware still
>> verifies the match before sending.
> 
> It needs to work as intended :( so you probably need to enforce
> the correct mapping in the FW or the driver.

We do configure the correct priority-to-queue mapping in the driver when 
mqprio is used in DCB mode. In this setup, each traffic class has its 
own dedicated Tx queue(s), and the driver programs the mapping 
accordingly. The hardware performs its default priority check, sees that 
the packet matches the configured queue, and proceeds to transmit 
without taking any further action — everything behaves as expected.

When DCB mode is not enabled, there is no fixed mapping between traffic 
classes and Tx queues. In this case, the hardware still performs the 
check, and if it detects a mismatch, it moves the send queue to the 
appropriate scheduling queue to maintain proper traffic class behavior.
The priority check is always active by default, but when the mapping is 
configured properly, it’s followed by a noop.



