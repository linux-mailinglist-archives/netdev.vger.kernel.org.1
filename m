Return-Path: <netdev+bounces-245914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE7ACDAA9E
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 22:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3318300986F
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 21:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A6298CD5;
	Tue, 23 Dec 2025 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dRLqYORn"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D2C16DEB0
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766523887; cv=fail; b=iA20qLHplwffVM9mR/RhWbc6xwocJWZa2St06ztHISt+3ioDBsZvLQ6RqVgExiMcGHiEfdcDfnxrG1TxZUxJpcRnSHjt6f79McIK379cJM6NyXGzqaSwwx7N48GE2tlWvB0JTRhHcF2Ch5uHOMEIyC+/qcdpDKwVbUluH98dSXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766523887; c=relaxed/simple;
	bh=h26YayXPYvsgctH3LbkGIpmRrY2QGWzZss/Uq5OefuA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W98i9J/Dp2ySe0wKZWasKOWymEcFrJvndO3JCBcbpEEl+b0hsxIHVZMUlF14vh8PqJxq59/6GCVI+S8bEQMTddEgYsbtPlxPuWSo4LizkerYdOrc5WuWnlnGSpy96wY3I2VtweSKka9hesX8sI2lfiD4l1VDHkfdhT4cEzBjZM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dRLqYORn; arc=fail smtp.client-ip=52.101.193.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vECJ5QdCgfQJ0ymDS7qZ6nMCfU5ohGfnd18H4PuJJr/H8g9mUxNQuNhjIWOQKC1b/1SaDrfCq8JLXq9gI3pYMn2FbHJd7/KvYWPwpqbqJrutEYMVlFH1j+CXjAe6ccOYsiggByrnJTUr6ZosCZNLifq4Ym0R2KRZ6b1UL6iurDAYU30XdgoHcfCRJ//iPUsVrTqNcfPxMGSspjB5Dl9M4G3I1PGkKGagPkFdqSCTbcnUi7sxwwsk67+BfFtzqFHzPKDV5qkpOsqTo74DYWiPqbQg5YZM2OBuy0qspBn3/HkZHq/NfVoMVZb7HzJKjCwnyndQyRINRQx0SGzyO45+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lUn6cG9sB0O9UHi02GA18PTjmSW/HZxqQEP8pjlnIs=;
 b=lz8WIuJGo3N/znTth/Wr1NWr/VVuUontYPElrnHY7qk5zSpbmZ3nXeg9i0qJmuUFuwtInr0xGVJLLe5BYcYRgjEw8SnGaAEsLRbw1zxNk80h1Cvo3PJM0irXDE5ub+XCGf9lsRSaTFcykoZWczfNoj4lmAtMoAbhFmX7NsiNYS3frw1dOa+88Fjrv+hH2QGMVJHAbjntkdp3hjL4NclW/FdB1sOgX8154YqsmwEwpETMICR27HU9sOswRsS1Y9l/HWPX8okFo2jgxRVnqo0z7CaYJhG9bcG6sTO8fB/s2TXD0+td0yNKcriyhWDs2x3OZkz7sLTnoFUrgSIbS3S46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lUn6cG9sB0O9UHi02GA18PTjmSW/HZxqQEP8pjlnIs=;
 b=dRLqYORnCWYOca30d4GpZHr+vbExHj18NnsJyfXlRJWxTeX0Nbr18sNm54AgP5hJjApkmZLhJ7Jzi4UBpKLh5z/mpdpjmWvSu6tPrn5BOLFHd0rrmsqMBaKzLxJiEiY79VsfXgRfauJ9SeV4acanidv4JTj1Gpll7W30aZ+Wm5ROFxYW+uaxFyofMpCnZsXRi0AxDs3xzWBVyzry2pjoS2E2EgKbFTOtR/INinUzgBHxqWyZMfABQZtS+Sh+rISYEevCACYFL8FoukBytgQ/rLP5u9aadyjl6BxD8nmUFau6Q3uX+IxOVhAbpLWRWejAdV/lj0tKcdkZUfLI236EfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 21:04:43 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%3]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 21:04:43 +0000
Message-ID: <e93a2084-7200-4374-9a85-d597796a1d9e@nvidia.com>
Date: Tue, 23 Dec 2025 23:04:38 +0200
User-Agent: Mozilla Thunderbird
From: Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH ethtool 0/2] ethtool: Add support for 1600G link modes
To: Michal Kubecek <mkubecek@suse.cz>,
 "John W . Linville" <linville@tuxdriver.com>
Cc: netdev@vger.kernel.org
References: <20251204075930.979564-1-cjubran@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251204075930.979564-1-cjubran@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 0715b340-5590-4bd7-2c7a-08de4266e542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEVUSlZZUEE1ZlE2cTBBNXplQWcyNllVSVdDcjdoTjBGNERWWFd2UFV4MitG?=
 =?utf-8?B?T2EycFdqNzZlZ0F3TEVvK28xdDRsMWxJMFBVamg4RDBXK29iYVNZVTFQL3JY?=
 =?utf-8?B?Z1JkTk1SdWRrOEw4by9qcGU3UDZuQVVSRWgyWUFpb25Oa2pXb1lGUnVteFNJ?=
 =?utf-8?B?cHJCekJOVHNTTmQxb2xCRWpLaUQxby9aanlaRWJ4VGp5RDE4TlV6MU8rUG5a?=
 =?utf-8?B?TUIxZ2EvU09mUG9aOVB3U2ZQN2dMTWdtTDJmMVQvZzNZOTg4MjhmQjJpV1NU?=
 =?utf-8?B?ZFUrK1piT0lta3pmOGIrQ1d2R0krSTJMUkJsaTJHWVE2L0tCek4yVjJ3dFl2?=
 =?utf-8?B?Snp6dW1ieHZyZWg5WW9hSldXR2V2eGFSNFVhK1BLeFNVK25INVJBYTlneU9B?=
 =?utf-8?B?OVdQbmNUWS9iUDlVZjhaQ0VTV3RwaEZMQmF1MDJaSUIyTXNCenFTb1ZDQllw?=
 =?utf-8?B?aEZJNUNaTWNaWE4yRFY2clYwdzRqSkhtcHJRUkhWL2IxNG5YbWRpVTIvNlhT?=
 =?utf-8?B?UVZjakVYb2UrSjk4bFdHaFpVWHBneVhsNVhpQU5NUHJjOG5OUXFla25xbVl0?=
 =?utf-8?B?UkROWDIrTUlQSk5SaUI2eXVYS0VsQ25rVit0clFqbEVrc0lqaFUxMEk5NXg3?=
 =?utf-8?B?eTdoTlFSMFAwZU9NVjdEUDcyV2QzWVZqNmlodHYyVDh0ZmJyMnlzaHIwMU9O?=
 =?utf-8?B?OVFaTW9SVXNtR3V4RjZLaTZlcjlHV28zTWMvd2Y3ckhFUnUzU0V1NlFBVkFM?=
 =?utf-8?B?blhWRTdNQk8wVFdVNmwzMUlQZkZ4ZXRYeDJLOW02Z3hEQnJvMmJ2V2c5dUp5?=
 =?utf-8?B?RGVoNVN0NnhoN1dzU25BdGZCL2F0akk1OXFUWXV6LzdGY2JGZnMwdTdueXpS?=
 =?utf-8?B?Y0hnY2NPSHJJVitMODNXWGlhcERRdlpjbm5yMFcrYmtxQXNWQUQ2K000S2hv?=
 =?utf-8?B?M09mTFd5dGp5TGF6YlhYSEZ5N1ovMVcwczVWR3crTjVRb2lIRWVpUFNGYUNi?=
 =?utf-8?B?RW9MYzNOTVZCTGFVaFRNRmswQ1E2Q241NnJoVUFRTEF1T2pSVTYwTEU0ZW9x?=
 =?utf-8?B?NTkvQUVqSHVraFFIUnVQcVA3TFFYeXlreEZWN3hGTU95NktRVVVGWEZSMm5s?=
 =?utf-8?B?bnRNaEdjVkJPbnlWbWZXdG9uaEtxVDVDOXFEclFWYkpRYTE4QitqUDlCbUFI?=
 =?utf-8?B?MWtMSXZEaXRYbldxSzJXNkdxUU5FT1ZZNHZVMVFSTGxQMko4U0xpM0FnSmE3?=
 =?utf-8?B?M09QSlp6SnZ1alVVcENkVjdTcXdGVkt4SndjT2dDRDVObVRBWUljbzhxOXkv?=
 =?utf-8?B?elh1Z0lQdDJuRjRmcVlMVHBnRnAveW5GU1U4ci9MenpoNXQzY3kzZExJWkpQ?=
 =?utf-8?B?enREV3Vwb21ZVHR5WndmTlE4bmZJRE5vU3JTRVZkTXJtSXNkSGVDYmF2cC9y?=
 =?utf-8?B?VHg1V0lWSHRnRTZMRGJWaG0wcUg5WktmSlZSYTk1OEpmbXcrcVhtTXptWUNG?=
 =?utf-8?B?ZnN5NXBSanFMQUtJTjllNXhKL1dIM1owcU1NVWcxc2hGWTBSaEg4ZHpQN2Er?=
 =?utf-8?B?RVlCWnF0OG1UZFhGa1FYUzJlNjJicGd4R2lUYk1DU1BCSURwR09VeTdmVGhL?=
 =?utf-8?B?ME1TNVpLbDlDRUZHb29rc0xVdUtjRHlKb3NSbk41ekVxRmVJNGZHeFRsZ1dT?=
 =?utf-8?B?a1NYMWxnT3F1QTZGdytFZXA2b1YxRmtGTEZRZHBzek5UZnRwNm5Ock81SS96?=
 =?utf-8?B?VUFYRDFDZEtzaXpvYytFam9BUGxBSnJ2Y1pZWTlOak4rR2gyZndaVmVIZnVv?=
 =?utf-8?B?WjVLeXNrTVNBSW5ueFk2YjhSNkl1VTAwK1JhU256UzluRmdSYUtrUlE3SUlG?=
 =?utf-8?B?bVFkWjdnU3FlZVRtYVM3YVFjc1UxaVNWSUdHaHRFSWtrS3gvek0rMWsrL2R0?=
 =?utf-8?Q?452fIc4sc//hz7JTXviV0yFNj4S83Jzm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVNtMkFkREVuQ0VYRXBwQ3dra2hZNklhYnlhL3VxSi92eFlpdG40SG5KdkVo?=
 =?utf-8?B?alZ0QzlNbEpDeGlHSDJ2WFh2S2hESjVYTGx6eGtIN1cvUnVxMEhEYUdaeVRD?=
 =?utf-8?B?TndBeEw2Q2NBc3g3em1qS1p0ajE0TmlXY1Z0RG1tVTJpV1lHYmlOSFhKRnJ1?=
 =?utf-8?B?blM1cEk3SVJhNERubi9SOEVPd2dsSTVSVERSQmMvUjI5YitXcEVwWGVKblMr?=
 =?utf-8?B?T3FYTmtxVmZxUHFQSEtFbUhpUkFBREw1QkhZZnpHNVlDc0tET3plS1EyUW5p?=
 =?utf-8?B?N0tISWRNOFhPUkRaZ25IQWdlR0Z0QnFEYVczalNqRE5aSkZMNUNHenRTRTZo?=
 =?utf-8?B?T2hSYXVwK05keEFXR2ZYMHNpckFGUDlxMmxnUTI0ODc3RzBhM0FtWnQ1R2Nk?=
 =?utf-8?B?dlVPZzMzRDUzS01kVWZRNy9ldzF0YmNpT2NmVG1mVkk5TXNCNFI0VitKd1Zp?=
 =?utf-8?B?SDVWQUFPMGVHYjlaTmpuNEppZ0hYeEsyaEMwODJWZVlFenBHaGpjMkh3bmc3?=
 =?utf-8?B?UkNvV2JnbE5VS3Y2c1NELzllR0o2R20yQjhiQXRWZ3N4SDh3UWNFQ0s2SGF4?=
 =?utf-8?B?cUhqSjY5ZitmYnUyK3dveUdZMExnR3lCVVJ6VnpWM0VReVZxY2pPMjZJdXlD?=
 =?utf-8?B?a3hVQ3o4MncrTGkvVVhYS0RPaEN0MlVtS3U0eC9nOUNXeU8rQmxkeS9BR0lo?=
 =?utf-8?B?M2dLdXVmN3RjWnBJN1ZCamNYV2pRdDdaMmpMa0VxNmlSakUxbUQ5akNuc1Bk?=
 =?utf-8?B?K0ZIM3VlR0NWOTBxTjhqOUFVY21JK1hGVW5XdkFZeGI0aU9KdU5TYys5aGZp?=
 =?utf-8?B?aHo0YUZITlhMbFlGbHRJaFhMb2xvRlU5U3VOZUVPWWRuR1pZR1hxVE9NT3dT?=
 =?utf-8?B?cG1uUWdMOURCOTJXQjlzOWtlTjE4QWpkTVJaSTRSYUx5bDJncnk1bzNEUU9x?=
 =?utf-8?B?QWRzQ0tndkJoS2pQbXV3MWdRYnFVVjNTem5EYWROWlNuR2F3UkV4VHdUa1B1?=
 =?utf-8?B?RWhvK0VMM3psMG9IOGR6MWFTc2Y3LzRjSmd4bFJYMjdzWVZTeGhocmxQM3lO?=
 =?utf-8?B?RUdoaitsaXpyVHBDYU5oZWJ5eUE4UGd5Tlk3S1dzNEttbWU2S0tPczhvNVNE?=
 =?utf-8?B?elpadkM0UDBTdDlwZzJWUWlscmtCaVhSd1cvRU04YXA5NGNBMEZGakJtaXBu?=
 =?utf-8?B?cmRHcmZQbXlrMElIMzJSM0NTRGk2SmI0dFEyRW0rMEM0ckVFME5JUmlXNGN0?=
 =?utf-8?B?MjlvQ3cvRjFsWHBpNzI3WldmalVGMngxanVWOWNibStYVFFxeFM5VVQ0NDRa?=
 =?utf-8?B?UEc0MzZQY3AvRDdVMWFQTitySVQ1R3NYSkZ1K1FJSDdkNkhFdG1sdEZLTnpG?=
 =?utf-8?B?T3Y5R28wR3lieUF4RWQxMStYV3dxTkY2emVOMUxOeXZVMGF5aHpKaitGUG9N?=
 =?utf-8?B?THM0RjFGTG0rNXpTZmQrZHNJMmNNZXA4c0tuTDQ0dS93ZlhaU2V3V1o2RjAz?=
 =?utf-8?B?K0N6QzBvY2UzSm45RVU5dFV2aDhqUGpIU2tBelhHbmo0TzhHOXZqM2ZiTTFa?=
 =?utf-8?B?cDRselZyOGIrdmtFTnRWcWU5aWlFclYvSjFxamdUVFRzYkZzeEtlMmtYWEQr?=
 =?utf-8?B?aFBxVURHUUVxL1puMUVUSi9HWnlKOHVJd25QQlU3UHE3aGpuMnJ0Z1ViWGQw?=
 =?utf-8?B?cVNvTnRlVERiWkFmU3BmOWlpWlpIRFRzU0pWbkJoTGxDZklDY1d6QzJHbkMv?=
 =?utf-8?B?bHpLN1F3R3E1REo3ZlpNN0pBM1dYL1BRM1FGRXFFUHhqOEZOV3NUVWhEdE1W?=
 =?utf-8?B?Rkd4OXRkVVpsRVEvL2xpTmY0bWlsR2cvN2hWU2xPeWFyeWs4ZEZJZG5MazBo?=
 =?utf-8?B?bkZ2RXVMZWFzSGlaOStKTGhjK2pXNGpJR2l2UHhVV0dRTDlyOU5EZzdFbjdw?=
 =?utf-8?B?eGN3U1BtWkh4aFM5TFlLMUJvR3NzTjNaSjZqRjM1K1NzM1VieFdsb1FwMVc2?=
 =?utf-8?B?dGoySWVaeXM5cEQva0J1YW9DQnVPV1o0bVNjZVNQMzMzTzJoOG95NzI0TWNr?=
 =?utf-8?B?Y01yQkdrbUNnR1AwMGJKYXozVkR4L2dTQlRwZmREWUtsNTVLN3p1K1IrdStm?=
 =?utf-8?B?ckp5cWtVWHBiWE1VNzJYc201MVJ1a0hDVk9vZDc4NzYvMSs5UWRncjRIM2dh?=
 =?utf-8?B?Q3lIZnZ2MVZEcldzR251UVMxZ0loekNIRTVMV2JQUlZOMjVHNkZXeDdYK2li?=
 =?utf-8?B?OXlLQUNLU282Z1BPWS8zdk5JKzZVYVA4cGI3K1pkYzJRaXBETzZjUGhHcWJN?=
 =?utf-8?B?QmoxeUYrSStQZmVuaTg5czFvVnpaMnoyWS9pUXIvY0o0aDgyaHVIdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0715b340-5590-4bd7-2c7a-08de4266e542
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 21:04:43.6640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TR+MfvZXV5UjfmBCdlj7ugk98Ug5EzMPvegP31L4+CfxYsckoXffoR8bquWYKkGucDbT1ugy1QGybdR8ZAeHgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520

On 04/12/2025 9:59, Carolina Jubran wrote:

> Hi,
>
> This series by Yael updates the UAPI header copies from the kernel and
> adds support in ethtool for the new 1600G link modes.
>
> Thanks,
> Carolina
>
> Yael Chemla (2):
>    update UAPI header copies
>    ethtool: add new 1600G modes to link mode tables
>
>   ethtool.8.in                           |  4 +++
>   ethtool.c                              | 12 +++++++
>   netlink/settings.c                     |  4 +++
>   uapi/linux/ethtool.h                   |  6 ++++
>   uapi/linux/ethtool_netlink_generated.h | 47 ++++++++++++++++++++++++++
>   uapi/linux/if_ether.h                  |  2 ++
>   uapi/linux/if_link.h                   |  3 ++
>   uapi/linux/stddef.h                    |  1 -
>   8 files changed, 78 insertions(+), 1 deletion(-)

Hi,

Sending a kind reminder on this series.

Thanks!
Carolina



