Return-Path: <netdev+bounces-247410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D17CF9C5F
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 18:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77CC6317400B
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA233ADB8;
	Tue,  6 Jan 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Eakk5WrP"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA63396F4;
	Tue,  6 Jan 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719635; cv=fail; b=YbXxvXfJsaDQW13uuytQCvTmkLUFA/NHI5+v/dZuzxgTKnI1eb1VwS+PHlMEpajJwdV2zzAu1+LSpVNnfBE/yhts7YYUmcIoDrJPaRZnBAgqCwM0Vqi+pZycHSAUpchxLvuZk5Ay3M9jLADJCezl8j8m7Ou8jBoGXqR27VmE7+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719635; c=relaxed/simple;
	bh=/OH41luY4sQIgRiCaVxDxlySSnyjsBvb2kCbLzLDHaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RAsZOFJGnpwmVx4DKmM17Pj+W6i6Opanp8ODhf+H7r8gL7k0wt4nIoaIocMFKO9YbisMW++TrTpj1OnOkWgyXG+s9DB4m6iKBKYE21LWOEhBY0DG5TTDRQOliQS9/0ANFRFXpdRPoTu/cleI5TJVPS7UmP9t8KoAB06EFWL/h/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Eakk5WrP; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKWxQEG71vzSIv92Ei3q+VBFEjDfCyH6rZbfAlKbiwc/4nE4aDauc7Q33cgCsox1StiJJtqFaa1WKVi7idIFrwXvkYCvxyOLfv1fWskSSsxuyJYZAg6y8xWpLAArGBnH5STi8QYla+oVzrTUdTPVHunGZdXBH8CNxPlGkdN8H1Qt6xZCDZMQyNUlnBbBfV7LdzQdCS4tI8zqcuVRnHw5MxV1Cgs+Fzyzw3kagyks+l0LlPysWXos3rLcCz/bR9pEAdZI0guEIc3DCAVclmZ/084snkDbtRT1cN285ZY7kGiGGOUNmvjg9m1Q0SRJ6bD14RMWSmp8pkYf5HUEUXdf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4emFdR+bjQ50TbN5GLnChAQe4AVDd7JXEJffTdi3oM=;
 b=yjfqnEpaVMnwAbxelsrKhHAyAvdL23GpCGAJ5T3eVbbMlkr221Nf1/PXEn8IxMcZpS77LPF1Fxe15OsxgRdWITxZ4tWm8ZdOLSM+Xv2pLevqndMpFlGe6ARioeLgyf2wPXunIhEKk5iXpX/h41cYj20uRGOTJ3yMcngvwd/B0qGjqBNGle4wgQun1LlC51yT+oOs23kI5u3Ob3teIsbfjxq5f14dnf4VR/kwIfwrqOiYNN6E2PquUXqGk2jdd855YGS48J+lN2aBkiHNgI+ShXvVPDU50eUK1w69txwvJdEYyb+iGVCd2HEgzKCn+EcVJOCB7Xa+hYn4blJ0qiF72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4emFdR+bjQ50TbN5GLnChAQe4AVDd7JXEJffTdi3oM=;
 b=Eakk5WrPTTNgMiRDEi+pJLFLCGefIDnpa6mHAdY3XYAnbJLirxFRwDxf0Ukl2NkSkWC/FClEQ2J78Zll/mT+shqg1+kLJhjtynwV8rSOXKXVtkvVRlDQPfYVKmPZlHOl59KvCDDo+Rc/nnRHhsUsy6X/ZnqwWPXjnbqFk3sy3Kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 17:13:47 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 17:13:47 +0000
Message-ID: <6363077c-09c0-427d-8380-1e0d5831e1e0@amd.com>
Date: Tue, 6 Jan 2026 22:43:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add an additional maintainer to the AMD XGBE
 driver
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251211112831.1781030-1-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20251211112831.1781030-1-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::31) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe9e7df-82f3-41e6-81a3-08de4d46f3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zjg0dTczaXlCSzFZVG0zZENsNGprNGRqTG5ZYXdLbVViajlNb1FRM3JVbkNX?=
 =?utf-8?B?bkhjakw5THltdGEyL2d3NXRVaGE5aVFqZFV2SHo5NThkVkdsUkxEUHNZUDNF?=
 =?utf-8?B?dmx0bFhQaVJhV1ZHaExrVVdDN0RPTUl4MkhnRitoS0FNMlMvV3NscW5aWGFM?=
 =?utf-8?B?dUhBenZPL2hNdkJFMnFvb1RJSldwdVBBekJmeHNZem5ESERzWjA2blFzS1hx?=
 =?utf-8?B?NXhVamMwaWZhYTB0VHA1eldobVI1YnBBenNKelFvZWZnSGQxSzBhOCtZUmZU?=
 =?utf-8?B?Z0pXRGdTRjlncG1tQnNoTmlGdVVoVno3d1dxaWFQQXh4M1FLaE5JY0M0akhH?=
 =?utf-8?B?OHhUdlhiZVM4Ync0TGhOYk1CZWxROGxSaG5HUEZnZG91U0VTUUdhdDhvZmN4?=
 =?utf-8?B?RnFidnhYSm9FdlhtcE1Ia0NVZlNBd0VHOUtqbzFUNHp1TGJqNmlPNGI1enBB?=
 =?utf-8?B?NW90STRubHRGLzBpNTZUQzlFcytMc2xrS3lMS0xESytiWUNuZHIyY1FWcWhP?=
 =?utf-8?B?Z01IRnE4SytWQUVDR0NkdHZsV1FyMmRQeUdxUnZ4WE44QmxVaDlzQzVnSlU5?=
 =?utf-8?B?NDBwOE52OEgrYVQ0TzlpLzJIV2dPWFIvSEtKcDFjcURuL3V3T0J0eVdZTlBn?=
 =?utf-8?B?Mkw2c2NmdTVCR0pTMm9NU2E1T2lDMWpuNVMyTVBsMmlLbWpQK1FIajJkU2xp?=
 =?utf-8?B?WlZpT1BkUHNCQWdNeWZZd2VSK0x3M2tPMG1yK1VtU09DaE55d0w4TXJXc0xB?=
 =?utf-8?B?ZGFJRk4rN01LWDdSYlpGL29iSExzY3ZKeXZHbmprNkdFYzVyNzRHYnZuaEUx?=
 =?utf-8?B?MWR0YVY5NEJhelFMYThSeFhvWmJldlRrc0JkekJIdzNhWDM0bENkOWdmdG1n?=
 =?utf-8?B?S054WUlHOW1kK0ltaExCZHY3VnA1blNsaWg1bE5WRjl5bFdxMExCamNQL1gv?=
 =?utf-8?B?azkxWUJuc3lOaGh1WnFZMUU2NG9xVXhQUzlwYzdSTDZ6WFF6Y2M1WU9HVk9v?=
 =?utf-8?B?azhxcmpWNXoxTTEySnpmRk9MQks4cndrY0lqS1dNNXA2cGRhcWllcE8vZXVh?=
 =?utf-8?B?dWRtWWp6b2owM3RwdHZUOFBwbGF1bE9TUnVWVGgwSFhYbDVzUGtoVzhLVlNO?=
 =?utf-8?B?cG9IUUJZUEd2SnU4Skl2c1Y0QlFCQzIyMkpyOFBCc0l0U3ZiYTYrNlBabFdj?=
 =?utf-8?B?T25WaFBZTWhZamw0ck01TGtkamgrWU1qdWh2UDlHVVJmNFRETVJ5QjhuVjRB?=
 =?utf-8?B?eE9QTjlFQ3hZS21FUVJ6LzBTQXVaMm5WTFlTQkJvL1VlVmM0WjlRTGRDcHFn?=
 =?utf-8?B?dUJFaHJEdlZGd211VmMvN214bk9VbDhLbUFVMHBBLzVhVnZBbytZR3VlQ2hJ?=
 =?utf-8?B?VjQ0bUJWaXV2UkpiODFUWGdjNEJpL0t3M2tWQ1lFaDMwNzVydFJBenpjRUEy?=
 =?utf-8?B?RXV2YjFoNUtHdmlRWDBveC9yTVRTNWQ1ODZzaVV6ZWNPZysvamVVbjY0S2tC?=
 =?utf-8?B?blJCNUlDQ05HY2M5M3o4OVcxVG5RSmFMRkN3ZS9KK3c3ZkV5SHp4UXFNMGtJ?=
 =?utf-8?B?RDE1SCsvK0dnSHdOM0YySWNpMWxhb1RvbXJTQUpDTmFtVWk0ZXd3VGtiUWRm?=
 =?utf-8?B?V3o1Q08zMkJwRC9XeUFpSGN2bVpGZVR5TEVUZTJTY096TFpLUGRVdzQzWTlk?=
 =?utf-8?B?V1VyU0txeHdabDJKVXlyRFplQnJoeDQraC9SeWNrcWtWcTljcVlCdWdpK0hu?=
 =?utf-8?B?cmxyQ05MWkY3bUVQdGFZRjk5TUlzSFg2YlFOY014eUYxM2FGREtQMHp2RExZ?=
 =?utf-8?B?L3dRN29iVXlmTHQ1STljd2NLVmxPMThWWUhjeGg5MnpqMmtsb0ZNNTNWWkFE?=
 =?utf-8?B?dUdxSk9Yd2MveE1NRG1Dc1VvV0s0cW8wOUhrSVlqVDA0NEc0ckpYL3dXdFRU?=
 =?utf-8?Q?UxFhez45UQwzYR0tDFQZDFxGjDBdzkuQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWpLcDNsVmwxUG5LZThvaGl6L1FmYVY0TnQwakdzY2FBdnh0WHJabGVDd3cz?=
 =?utf-8?B?YmVlL1JHQmEvSlY3SGgxTS85ZitWNlNVWEYrWHpHSUtoeXBYcDVrMXdqQUNG?=
 =?utf-8?B?aFdpMkM2SGRwb1BrKzV3ajF5UUoyVWdTVUlDZXhXcGhmYW5mU2YxWHNwYnJq?=
 =?utf-8?B?bzRjQ2JENVhKOXMyeWM1VkNNb0YvUjRpQ2U2N3dOSm9rNUU1V3dwai81Q0Nr?=
 =?utf-8?B?M0FFTVJqdmxGajZoYytidmdsNzZZcEl3dlpqWmV5YlpSZFFadVVpdmFIby9O?=
 =?utf-8?B?Vzgyb2pTWkw1emR3a3gyTkFlRlpiNis1WE8xeUxJeVNiZWdISk9GZFJ0Mlk1?=
 =?utf-8?B?allyYkhEODhUQlVzNFNuYUd0UzJJRUlqNXcwcFVMSWgxdXFTTTZoQlBPekFp?=
 =?utf-8?B?cjg3dzlJeG4yVVA3UXZha2JLc29sa3hEa1hTY21ycGRDamRkUGVlUG5wY0Vq?=
 =?utf-8?B?cWxWQjRjWndNMFFNTVUxc0s4cWxBbFJJVDFMOE1HaUt4U1RuNit6L0U5b3R0?=
 =?utf-8?B?bGtXRWZscm5UZDQxT2ZEeWlueVZmdXJreU5HZ2ZkK2EyNGlHU2k4OGxuOVlT?=
 =?utf-8?B?eEM2YWY2azh5K0gyeG1xVm5wMEhsR25HWFZreEVjR1R6MnFkNzFLT1pEOU1W?=
 =?utf-8?B?RU5JeFZUeUs3MWtrcFV1am1TWi9uZHVvbmdMY2RsVFNYNVFIWTVWVy8yRStL?=
 =?utf-8?B?TWRwUE1tcC9QbTkvMmlBOXpkdGdxZlMwZEY2SHR2UlNDOGpnU25WUXVCaEZy?=
 =?utf-8?B?YTAwNHhoTkt0djM0bjJiSldKblR3MUtqNnl6ZHEyWFEwZ3dFank4VzIrbWEv?=
 =?utf-8?B?RXF4bXhvTWR2OHhqWnVOTzRNWFJNdm1yUUJNWjFMTExBVHh6OTZzdFlrRDds?=
 =?utf-8?B?MnJYMmFnbktQSEdudUs2MXFPY1BSaG9PWkRkbUduSjRUQ0RQK1FQVkN0dVE0?=
 =?utf-8?B?RnNtYzVrV2tmaFN1d2ZVRDFoUk5NeUI3QmtRU3lKN21PaFRjTkwxNk41TTd1?=
 =?utf-8?B?ajZoS0txZ2RrS3pJZ2kyMyt0Z2pQdEFpTlhLcGszdHAvNzFYUjJTU0syMitv?=
 =?utf-8?B?VzE0Kzd3aEtwVXVOZVk4NzRHN251cDdGT2FtZGR3ckNPNVZDbEM3VVdnRVNm?=
 =?utf-8?B?N2FHdFFQY285YU1xTFJJZmVWOGhLWjVkalNEQzlwRjMwMjQ5TU82NzVNc3Br?=
 =?utf-8?B?SG1DT0pYb1FBUi80ODlMTDlQTUQ5Nkc4VVFMSWowQ29EekQvVGhVVzEyZ1RT?=
 =?utf-8?B?M1U2djNaVWZjN1VtZzEyUlhFUzVqdDFzaE1mamVZbVp2YjFwSDVSVy8zNmpR?=
 =?utf-8?B?TzFYd2c4SlRXTXhpeGFaUS9DczM3OHVqYzEvcjhRM3Yva0ZOdUNhV2xpL0JZ?=
 =?utf-8?B?V25BenM5U2h1YkY0KzhjRUFpbkMzMy9VRUNhK1pOSUx4SFIrcEhITHJITEd4?=
 =?utf-8?B?ZGFFejljY2RKMEM1Z1FydjZ5SG50ODJQaUtvRlVjY2tqdHA3WTRHRjVuU0FM?=
 =?utf-8?B?clFFYlU4VTk5c053d1RFaGNhZGFwa2o3Tkt6RTNLdTg3NTcrYk1vaytzaHM5?=
 =?utf-8?B?azlBUXpPeGdtMnVMTk9DNi9MZGlhZzlJUFg0NmM2TUF1UkVWQkNSeUIvRWZO?=
 =?utf-8?B?bjY2Sm5TVjR1Z2Rzai9Ba1E1Zmc2WEZNL0lDTTdSVURRU1ZzUVZNbTZaUzdp?=
 =?utf-8?B?L2ZsNWtpclZKNDBGZ0VVU2t2SmExaHNDdVRwK3FzYnBUdUM2eXcxK09HeFdT?=
 =?utf-8?B?czZxajd1bWcwcGVqdHRlTHBqMFpxY0I5NjRmTTJodVhXOFRLS2dDZnNLWFZl?=
 =?utf-8?B?UE1BQWVZd2FwdE5OQXJGWXY5Z3U1QUZJRjh5NUZMNzNWbjlGZmo5c2xNWG55?=
 =?utf-8?B?WHFON004SkxNYXBZdTRwY3JRZnNnL1hteUI3UU5Qd0xKTGhibnFTNDhZMlBX?=
 =?utf-8?B?RUh4OXI2WjFlUzN1dllqSFZLOVYrMTJhUSt0VmxaMDZQL1hHZUF4QW1adDhH?=
 =?utf-8?B?SXRtc1BFeVZydUgzUVF5UUhJWkx5MGloRUxyY2ZhL1ZLMkRzZ0UwMkVXbFEr?=
 =?utf-8?B?ZlZ6b2RWMG14NzY5MDNXRHpEblgxZjQ1c1NxMTVUOFcyUzhmaDdvWUtlSXhO?=
 =?utf-8?B?M2xaNkE2L05lckRhWW5paDdaK2VDMUhXZ3UyUFpnNjAwdUFQZ0MyUWhGQXFr?=
 =?utf-8?B?bmxnbkJiUFgyTXRSNVhYdHlWVVN4QVNKUzVXQURuTW5XZnNMVm9rd3lIdFc0?=
 =?utf-8?B?U2FFNERzZm0vL21OUGdFSkZIV0pZbU41MnhZT1ZYUTRaWHZlaXRQS0xNRUgz?=
 =?utf-8?B?SFllQVRFSTJyeG1TZVRLdGF3KzV6MnVCU0JvTXJyNFN2SUtrWU03Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe9e7df-82f3-41e6-81a3-08de4d46f3ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 17:13:47.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6Aoi1y1I0qYeaIQRE99mLriH5cTORyAxPelW2xxp0Nc1aUiNaSwCXsxH3G7X/FkJkEuWT+KtYmXH9Cz2N6XJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065



On 12/11/2025 4:58 PM, Shyam Sundar S K wrote:
> Add Raju Rangoju as an additional maintainer to support the AMD XGBE
> network device driver.
> 
> Cc: Raju Rangoju <Raju.Rangoju@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e8f06145fb54..b82621a8c0ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1271,6 +1271,7 @@ F:	include/uapi/drm/amdxdna_accel.h
>   
>   AMD XGBE DRIVER
>   M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
> +M:	Raju Rangoju <Raju.Rangoju@amd.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
>   F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi

Acked-by: Raju Rangoju <Raju.Rangoju@amd.com>

