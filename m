Return-Path: <netdev+bounces-134637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BA199AA77
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E107B1C212C9
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC81CF2A7;
	Fri, 11 Oct 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dWd5Mvw2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6A1CF2A1;
	Fri, 11 Oct 2024 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668254; cv=fail; b=tcPEPNUpKzH4HvQkxaOilqRjMSyMMc23xSD7VZvmLYykB60bgZnCU3j5aJOMQrtTGfAJcmy0Yi7Xw/FF4un1TwNm4aTBrS1yc+UYJIGOTv0GMUfHBt6uchxyBMuF43SKoU7CXwsZXbTEeDfO3USD/1HL918mJk7oVmb5WXJexoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668254; c=relaxed/simple;
	bh=JVY8SBPEc2iRwkfsJWdsDB4z1mVmK7emIJimTfH4MlQ=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=Kcdla261cO2ZnuwhzeA/9BrTlrlfcELkG/NQyOGfD2/K/JtyctK/RVGAE1TP198DOnPetDjNA4FihDXurBjCyNz/ABTL1g8iKFmNJxjGez10G8+LCWGGUysZjzFiKRXKDnKDJGAuPU/BCF2IXsft6e1PBVEDQ+RUBA+bqsuajeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dWd5Mvw2; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjOwmRzrv39NyfVR7yHIB3T1JKlSMVqSa6R9KX8Wadpyu3IRPzrhJrt02qU4is4xWKbWHPcgXK6QFoK6GGYj2L76pvP3AqO5s0LZtI+t4yGTPRLxL9DuusfIKfPGd4AGu2LCX9UYp2NIP85VzVEveV0DazAgjKRIDGKsqsijtAsGWQeq+AaVvWewlwZ+0Ah6J6QHaGtQsIb6SBpzRlhFf+D1P56E3lrm6x0/j4waEaDOjcuixtMU27k3hUNBb2upZBEdI3UA3cuzbB1+B8D0xs4J9GJUsbO2jsXn6KLIDj7nFuPY+iRM1i2lPerau90UV7HB2F6g62II4lBU0PaYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHmjdU4wpdGZ1W+exyIo7v74zWqZpTVJkx4W/HdHFgc=;
 b=YOqi0cPAfg49Aggp5BzyOHpdhFkaEqJ6hfJAq8Ho3iJgfpqogPaLRlqaaMLCaZ8EWwNxMuFe0k9L0B1jFffrib7GkNZbB1192q95PK/qMfCKkiDxvlwioerTF1d+y9Ca6oq50P/6G5yXSpdRHqeKnHuRQhloM7xize7UWc11WR0SUwNZZPw8/iTZiP/tWGGvKlhT91M4sDSZJ+n07AHm57peVdMKZs7MkWjn8VB2CEkTfHbaJ1j389WmW8M945HTY5Ci0/AFCFrHxUWbMrWs8MCuyPQ4GXlELODsrwwWSCQ9CSD7b8kTmxjVi7hhnKsdD021/2aip1ao/MrZ0Bj4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHmjdU4wpdGZ1W+exyIo7v74zWqZpTVJkx4W/HdHFgc=;
 b=dWd5Mvw2UvLUEJgBrObQjkAu4bKmvI2L0XEAQeHGHmvyBDn1WeIM1GwbfR1Mr7bB9QZ8fTKHWBJSCCtsCrS5U+aCmMQL1+6YBaxm/2xn+hDI1lv0PQ6DOOPCkDkFCu3rjvru1t8q2XlcN+9y0zW3h3GxC87rvPOI2jw7BXM7Y5GhHyOZkVM5Wz+w84cAiIBhPhvmFQPWxIcTUoAHUCKmFo+AuKRVshv5XU7UYQwBo2UmMhGex8CfxbHmsb+ydVnVOnMCE6bhaerXVWu68iqlDX9EEeMPMuX9kliUYqxil06H0rCvgTiuZAGFRuaHCjxcEwdBIrt6djn329wK8rqTPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 17:37:30 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 17:37:30 +0000
Message-ID: <114b4c03-5d16-42ed-945d-cf78eabea12b@nvidia.com>
Date: Fri, 11 Oct 2024 18:37:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: phy: aquantia: allow forcing order
 of MDI pairs
To: Daniel Golle <daniel@makrotopia.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Christian Marangi <ansuelsmth@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Robert Marko <robimarko@gmail.com>, =?UTF-8?Q?Pawe=C5=82_Owoc?=
 <frut3k7@gmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>
 <9ed760ff87d5fc456f31e407ead548bbb754497d.1728058550.git.daniel@makrotopia.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
In-Reply-To: <9ed760ff87d5fc456f31e407ead548bbb754497d.1728058550.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::26) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ea1e7f-f7ee-4fef-d412-08dcea1b6194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3lqOG1uWDJJcHpwVm9pNmdIWDVWaUxGbWFtVzE3Ykg4NU9EdVR6NW9pZzJI?=
 =?utf-8?B?dEdNSHNPMmVZcEpDNWZXYWtXL05ZdDIwd3MwR0ErY3hLdVkxUkk3R3FhcFFT?=
 =?utf-8?B?QzBzY3pENWRuWFpneWdkR3JDTTVDMW5NM3NTVWpraDZ6NEtzVnNRTnhKY2U2?=
 =?utf-8?B?ckVGMnZiUFZZdmROQVNxTkJiNnp6K1dER1Q2MFRmR1ZxcVZ2dnIzU2VNdjI3?=
 =?utf-8?B?T1NNNklIU2lqRC9oTDlaU3QwK2JWNTNIWFgzTTNzbVpIL05aaEhyNjZrbHZF?=
 =?utf-8?B?aUMrMzY2S0pVZ0ZML0FGeUEyV25IZGFKak9sZy9HOW9RTzFiQW9xN2tyMi80?=
 =?utf-8?B?N3M5YU9CbkF4SGVmaFVFZG4vK1REd3kzMkd5RE16dXhxRXU2SkxDTzUxdHRI?=
 =?utf-8?B?cDdrMmdQUEpNNmt5b1ZJaEI0SzFrMCtFbWRpR0hDcEd4NnU2REp2aHAxbEd3?=
 =?utf-8?B?cVBBeE9DWnpHY0R1ME5lUGJXenE5RWttNm1qd1ZDVTNaMG1YVEg5Y0F0S0h3?=
 =?utf-8?B?VjI2VkhNdklCZG1ENzFneEUxQlh0cGdhSnRrb3ppUTBER3VxQWM4TnlXL09h?=
 =?utf-8?B?aVFzaFNkcy9wWFE0WFM4ZnY3bllWcVZnYTI3VmZudVdpUmg1eDBPS3B0cHhL?=
 =?utf-8?B?Z0V6T0d5UUc3b3l2Y01OZzh4S1NtSFFvY2o1SGJtVW1tRjJsM0hJNWFvbGtT?=
 =?utf-8?B?QlJvcVMwRFZmeWV3Z1ExN1VQY2p2MTJTdDh6OXNVNjlwNHpDc3pHb3ZNY0NE?=
 =?utf-8?B?dW1la3VXZGhhQ21wTW1xMVMzeWhtbmxBQndqdDlkSDJCRmZEZlE1VlhpTndF?=
 =?utf-8?B?d3B0WjBFSFdtclJkN3dqQmpRdnNmdGNJdjJrU1N0WWxQZ0NXNVd4RzhpYXJB?=
 =?utf-8?B?NmpnQU5NQnZTdXhYa0JFUGZUL051dHNBY0xZRUlDWndlNzNUU1JseGkvTlpI?=
 =?utf-8?B?NzJqSnVEWnpHTkpIc1ZXSTFRUDBncmMwQWJheWZLR2N3dllQMXVUQ3ZiTFg0?=
 =?utf-8?B?VmxpNGM1SUwvY3RSbXY4T0lSaWs1Smc3b1V0Mzc0SEVpdGRGYzdwRW90UDJD?=
 =?utf-8?B?LzQyd3hUZFBQKzFyN24xK3pQaFp5bmVHU3BLMmZoTHl0aFd0VUdnNldtd0d0?=
 =?utf-8?B?SUYreXNSeFdnSVVKZ2lSV2NRVXpEUzhLamtEbVZEc1JpQS9ZSVB5Y1FGR3BC?=
 =?utf-8?B?cFpiT2ZOamQ3MVlIRlQrdFU1aUNYMzJJVE4yckNONHZNSStacmRTS1lMUEpW?=
 =?utf-8?B?eVVrUWZNRENWdjh0bWN5UlJmKy9JT24xcUtYdmRtZW1RWElmaldzaXRrYUp5?=
 =?utf-8?B?MFc3ck5hZ1BaR1lRYzg2cktwSjVGY1NEcHRhazRROWp1eXNrVFBpOENVMXdP?=
 =?utf-8?B?dXpuUThVUFhPWWl3QXhYUklJanJ5dFZVZlFFbFllSUduZmVDemEzakw1U2c0?=
 =?utf-8?B?R21YaW1IZ05tc2pYMFc4emFNSTNSNkxsdE5iU2Y4VGx5ZXBaNUFYeDkrOE5v?=
 =?utf-8?B?c2o3VktLWHRtZFEvYU80K1YwQkNuUUhOWjVWMG9yWUJ1YXdEbDlJaDZBRlhR?=
 =?utf-8?B?VDJjK0xaTE5yTFlmMDJ0YitVMmdPY25SYVBOVHl2MWhPNXpCUDJNS0RDcWVt?=
 =?utf-8?B?R3V2Rmh0NGlrV01PQXZiSGpoRlY5QThEMFEzWGN6bUcrMDJyNUtLVG4xeWRP?=
 =?utf-8?B?RWppMisrN0ZNd3E0NFJLcUp0clhLRWpQRVgwektDZ0N6bE5DSUcyVGxPdnhX?=
 =?utf-8?Q?7B2IFoLmUbnQYS4UKdaZQ/GAQja4ydLitUwNFlD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0t5c0dqcW5WczNwUjFhQUtEVENuOG80WmgwaStkZlluc3JqVzBQYURnUU5z?=
 =?utf-8?B?R1ExRUY0a3lZY3d6R1k4UTFhUTNoSUVEMGFPZWpiaklvMU5sbDk1VVJ6Z2d1?=
 =?utf-8?B?TzFqbElBZnRjUlNNZEFuUUdtL1JEbVpzeEVIQURhUnUxci81dmdwbnVuTGhG?=
 =?utf-8?B?ZDRkSGVJSFRhbTgrQWJsOU0xVVQ5eldQMStGYndYdmtLNU4vTHBSajVRK0Z5?=
 =?utf-8?B?MWViN0FjWHB1d2JNNmgreTBxanNXMktQdzFUL0tKN3J1VHF1clVhYi9MRHZX?=
 =?utf-8?B?SFlBZlA0bENHQ2IrVWVra0JSTG9NUzFJMTZ2SmIwZ0hxUHE4QnordDZNdWVj?=
 =?utf-8?B?UDIrbEhqd2ZGSlYxK3NUM0hGUHIrTFhhYzBZSDgyRDdQdy9PMEhvek5VSlI2?=
 =?utf-8?B?aWx6QlN3L0FLdmRoV2h3cUc0R0lPeVVReXlZeElQa29abjk1OGFuY2dnZkRJ?=
 =?utf-8?B?aytqbllQUlo3Y1NKRUsxU0Y3OFRzc3I2WjMxZ2pQS2M4SktvYVowam1ZaHlU?=
 =?utf-8?B?M0ZvVkdyUXhtWGRndWlsaUM5UDhvTzh2M2JONWdSNlhCZTJtRlJDeExXVFQy?=
 =?utf-8?B?M1ZBQ2dPdUtPK0o4NERaZGNScnhScjIyUzYyR0ZBWUNzUkxqSkwzeDlOKy9r?=
 =?utf-8?B?TE8yRUxxaVFFdWhpZzFNQU9EdnFIdnpUTWRhbDRJTkZDNWpRNHlOSXkrVVFP?=
 =?utf-8?B?RU1kLy9NYlRaS1BNYjVSRUxNOURGSXhkVWdlcVpSMFhzTnBXclhrd1c3SlNW?=
 =?utf-8?B?NlVvakhjVDNvRFIvRFMvUUUrWVc0THJIKy9nSWJEQzJONEVyWWpKb2orK2JS?=
 =?utf-8?B?YmZzV3h5NEljeHZDbHFrait1dWFMKzBWMzNNYlZsVEI4OHE1aytpWVQ3L292?=
 =?utf-8?B?Q1FEeDhVSXAxUm8rRmY4UEM5MUswaEw2aHo0azJFU0xSMzVjR2FydjhaYTB1?=
 =?utf-8?B?MWlUWjhzM0FER2RMOXBhc1BaaGUxTWFCNEJ6R042YWhobWxJUmc3NVJtL0ZL?=
 =?utf-8?B?MDNtZGtWTTQ3QlVBdm5oanVZOE01OEQ1b2NFaktIWWN6OVMyZnVlOGtnM0M1?=
 =?utf-8?B?eklicEUxc2ZXanptbUdOOTc2VHR2MjhvU2JJZjZRd2xnVnZpVnhtVVNCcEtP?=
 =?utf-8?B?UGhxamJwOXZ1Rm9Wcll3TXpQUFdyZzFUWnZwK3BmK1RadHhaazJoeDZQWWxr?=
 =?utf-8?B?emFudU5DcUxscGhWekthN3dIMVhnbG0wVmh6N3FUOHI5UXQwQm5TNDBmNVF6?=
 =?utf-8?B?WXFJd1c2c3o2UEYzUnl0bnhWRG5FOE14OEdyZ1dIWTVmd0FEbXBKcS8zRW1L?=
 =?utf-8?B?a3VuZ1QzSHRXby9XSkZwMVF5b3VaaDVGWkpKV1g0aUxBamlCd0Q3VkcyRDhL?=
 =?utf-8?B?M3dnWVBlQ3dBYmhNZ005RTRQYnFwZTFDNXJTUnk5WDRxcmtJcFhNY0c5N0oy?=
 =?utf-8?B?R3dYemYwOWVoWklYcmE2dENwM0tQbXlrY0phMVp5KzJOcis5UnJOZmpqa2xt?=
 =?utf-8?B?ejJ1eDBUaStGM1NTRGY1Qm5CVEhKV0VxTWUxeEVlVGErdWgyRGd0Q0lzNVFW?=
 =?utf-8?B?ZUxyWXBDMnpOeE9STzhLbGJpalVMdWpzbXYzNVdQUHB1Qi9FQ1BvMVhFTTF1?=
 =?utf-8?B?c2RXS2N3UlVSQ084VjRqbzN5ZkNDTC9CUUM0d1g5NnorRDk1NVY1V09TWjd2?=
 =?utf-8?B?L2hHTGczYjQ0WjdLY1hWOHVtOE5Ma3hFaW9qNzEybGZyVnhlY2JKOUFraUJE?=
 =?utf-8?B?VTNhQjhFK1BwKytGWWFWVHBJak1kNS83amlPTlBMcnlBUG5OYjVucXdFRVBX?=
 =?utf-8?B?UDVETmZXeDBRb21IUFQzWDgybzhGYUIvY0FzNmovT3VnU3J2aTRISXYvM1NG?=
 =?utf-8?B?ZXh0U1hyNFdoVW1STzQxQjBhSldUUzhCWTF5RmlDTW9Eb2ZjeE53TkdzcVZX?=
 =?utf-8?B?WFpiZGhXMkZvMWRQNU1sckFVdlMxc3o0V0pVTzNwejhyZmJzRUUyMkJ4d1ZC?=
 =?utf-8?B?NndHb3ozU1hZdFYzeUx4S1Z5QzNleC9ESVJWQUVibmZGMm9UN0gxQnVhV0Zz?=
 =?utf-8?B?MlZ6YURhN1VER0VOOE9VTGdVYW5rOFJSL1M4STlnY1M3RWIxNGEwOFErZk8y?=
 =?utf-8?Q?vA2mB8No7OJ6XNoXK9B6A8Exc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ea1e7f-f7ee-4fef-d412-08dcea1b6194
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:37:30.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AiCzL/tJUEGbUSbjqvhveIJXS/S74+UBIm9zEpAJJ/CGwxD898EseKtv6dLw8hWbMp+8PDEPhzD814fTYG9RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776

Hi Daniel,

On 04/10/2024 17:18, Daniel Golle wrote:
> Despite supporting Auto MDI-X, it looks like Aquantia only supports
> swapping pair (1,2) with pair (3,6) like it used to be for MDI-X on
> 100MBit/s networks.
> 
> When all 4 pairs are in use (for 1000MBit/s or faster) the link does not
> come up with pair order is not configured correctly, either using
> MDI_CFG pin or using the "PMA Receive Reserved Vendor Provisioning 1"
> register.
> 
> Normally, the order of MDI pairs being either ABCD or DCBA is configured
> by pulling the MDI_CFG pin.
> 
> However, some hardware designs require overriding the value configured
> by that bootstrap pin. The PHY allows doing that by setting a bit in
> "PMA Receive Reserved Vendor Provisioning 1" register which allows
> ignoring the state of the MDI_CFG pin and another bit configuring
> whether the order of MDI pairs should be normal (ABCD) or reverse
> (DCBA). Pair polarity is not affected and remains identical in both
> settings.
> 
> Introduce property "marvell,mdi-cfg-order" which allows forcing either
> normal or reverse order of the MDI pairs from DT.
> 
> If the property isn't present, the behavior is unchanged and MDI pair
> order configuration is untouched (ie. either the result of MDI_CFG pin
> pull-up/pull-down, or pair order override already configured by the
> bootloader before Linux is started).
> 
> Forcing normal pair order is required on the Adtran SDG-8733A Wi-Fi 7
> residential gateway.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: use u32 'marvell,mdi-cfg-order' instead of two mutually exclusive
>      properties as suggested
> v2: add missing 'static' keyword, improve commit description
> 
>   drivers/net/phy/aquantia/aquantia_main.c | 33 ++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index 4d156d406bab..dcad3fa1ddc3 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -11,6 +11,7 @@
>   #include <linux/module.h>
>   #include <linux/delay.h>
>   #include <linux/bitfield.h>
> +#include <linux/of.h>
>   #include <linux/phy.h>
>   
>   #include "aquantia.h"
> @@ -71,6 +72,11 @@
>   #define MDIO_AN_TX_VEND_INT_MASK2		0xd401
>   #define MDIO_AN_TX_VEND_INT_MASK2_LINK		BIT(0)
>   
> +#define PMAPMD_RSVD_VEND_PROV			0xe400
> +#define PMAPMD_RSVD_VEND_PROV_MDI_CONF		GENMASK(1, 0)
> +#define PMAPMD_RSVD_VEND_PROV_MDI_REVERSE	BIT(0)
> +#define PMAPMD_RSVD_VEND_PROV_MDI_FORCE		BIT(1)
> +
>   #define MDIO_AN_RX_LP_STAT1			0xe820
>   #define MDIO_AN_RX_LP_STAT1_1000BASET_FULL	BIT(15)
>   #define MDIO_AN_RX_LP_STAT1_1000BASET_HALF	BIT(14)
> @@ -485,6 +491,29 @@ static void aqr107_chip_info(struct phy_device *phydev)
>   		   fw_major, fw_minor, build_id, prov_id);
>   }
>   
> +static int aqr107_config_mdi(struct phy_device *phydev)
> +{
> +	struct device_node *np = phydev->mdio.dev.of_node;
> +	u32 mdi_conf;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "marvell,mdi-cfg-order", &mdi_conf);
> +
> +	/* Do nothing in case property "marvell,mdi-cfg-order" is not present */
> +	if (ret == -ENOENT)
> +		return 0;


This change is breaking networking for one of our Tegra boards and on 
boot I am seeing ...

  tegra-mgbe 6800000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
  tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach to PHY
  (error: -22)

The issue is that of_property_read_u32() does not return -ENOENT if the 
property is missing, it actually returns -EINVAL. See the description of 
of_property_read_variable_u32_array() which is called by 
of_property_read_u32().

Andrew, can we drop this change from -next until this is fixed?

Thanks!
Jon

-- 
nvpublic

