Return-Path: <netdev+bounces-246356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FEBCE99C7
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 13:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2E303019182
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F2C262FFC;
	Tue, 30 Dec 2025 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sYOSSQUK"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30CD1C5D7D
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767096245; cv=fail; b=QRrAl/ApGbjfdYrEyK2AnMQ4Bx07leBrtJVMcGP17CaeUar775UqXTDYJxT6yCscnhaFsS1drMBeQn7gF576oLk9UC3JFVHcof2myAxKKcS/3Gl4v5kva03FNoMFi6sRdQB5qwqbvXfqNt+a1/75jisLk8mGUfeLe97izSX3a8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767096245; c=relaxed/simple;
	bh=TLFxzl9DynRlI2NVQ2Zvd5mR/9AaKEXlbMlcqihcB4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u2qKr6UPyyjM6DaFrI27X2ca5hNaA3CJ8wIUdX9YjPqL6Z6OiDc5kQx3r3+7pTTINFVhspPhwWsBw3fRWu6TUvTQk2MhYAUmRdIwI33k3NxB4gszjvYvlB7DNiJXOpyBflvfB3UGH3sd7CX7ZU5tDh9NF8GvtOSorDS1bQsQG0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sYOSSQUK; arc=fail smtp.client-ip=52.101.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM/w53haLmjrP8Q6/yeXBVs0+KO+AdhlvMSI7XS234sYMaYX7k/FctgeqHxOwRDm/MalqxTe8rx1Og2+cDFeNnQjhIm+2cpcrfBiLnNS78nKwmJCsem/rvxAFQoNL8El2rgHDVSw3aunM54H0AOcIGXMaDiTjG+HehepCk59DHzvd5SF7DqUimItGd8xT8wiTZFGNgXx6bGVkESJqmBh1SPW5mk2VUQ2BQzTJQ3zPBgkiVNl/SDKldacNq5jGIwoQL0nzLG4ZSKwUoixGaviRMyu8acPflzVVvSPMzPym6R0Z8D8XCpRK+dsak/KWy9+mJpUASAX2cYGWpkuhwY5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHyaikEBWPHab8AUIRixUl7gScOCucOAEmYPdHBVT8o=;
 b=u3+IkM0WfA8rmY+w/fINdMDnBatjCXVXWbcec+YDA94t5V0yLhAA8gRbpVR3PRUqJR/HTanbZPkZcw3kI7f3y3J6nBz42+W5Jnww9H5sDwZGba6EvW5Trg1bnkV1IQjLlVt0Bc+dF7AmbHkavOwMTgqiL7PkFwsZr9eW4QW8LI3DCAkRhsCXxk4s8OyfTl+/zWvsk6CQR/SoBegF3QAk1N7cTSC6o826le3cwE7qFftGaS24xzQC+BfKm5OWfXb2lnsn6rt0xCpJK+Lgg1rYDccidsfG0ICKkHj6AatPY4Yk7OlKC+Ws9kgJH/5gvmHBiRjomqvWby8EIPekZkATAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHyaikEBWPHab8AUIRixUl7gScOCucOAEmYPdHBVT8o=;
 b=sYOSSQUKAHC13eH/BY2a23xunCMiUjQWFmcyuh5gd1D4/PPDX6lxmuOMkNJhQYEzmB3y0u0+L1CAFtHLyqEOqBeIX6y9a//EMHkz8CkSKBt7kzImtg0zmPC2QcUhPx3kGbg7CaPZR5AyAso4cgPkBuo32f0ST6/AFB15iD80zF1IZELPGfRaXdgmVztkwLnpRu7w7q4EIq5ExwegWJlPHjy/LwZyGkVu5v12VDIfLDrfxhpgThTR9UExMxFIRcrEvmKG6ZmX7HakRFSBsj7wsomi20ViN/J9TD0mr/zQFsauqRzuGe5JVA+bcGgi/+UViDzmZwGG+My/4KFLIjvz3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA1PR12MB999085.namprd12.prod.outlook.com (2603:10b6:806:4a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 12:04:01 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 12:04:01 +0000
Date: Tue, 30 Dec 2025 14:03:52 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Alexandre Knecht <knecht.alexandre@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	roopa@nvidia.com
Subject: Re: [PATCH net] bridge: fix C-VLAN preservation in 802.1ad
 vlan_tunnel egress
Message-ID: <20251230120352.GA518022@shredder>
References: <20251228020057.2788865-1-knecht.alexandre@gmail.com>
 <7cde982c-a9c1-4b9e-8d73-458ebede9bcc@blackwall.org>
 <d9558681-3113-4993-81a1-ff22873908cf@blackwall.org>
 <CAHAB8Wx39LZUO72uh11aEbdFbFYe0XGJxn_UW6X8X-ESjryksA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHAB8Wx39LZUO72uh11aEbdFbFYe0XGJxn_UW6X8X-ESjryksA@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA1PR12MB999085:EE_
X-MS-Office365-Filtering-Correlation-Id: 018de074-ab78-4fd7-235c-08de479b8567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3IyT2lRTWZSUlhoMFVycnhEMkoxTXhhWUxvdjZQY1hIaVRpNnVGVi9LZmFT?=
 =?utf-8?B?azJhQVNsMzhYeEkzeHh1MVNvRVV3SXVLQi9pcER5b2Q4d1BuQWxTSnhuMDQx?=
 =?utf-8?B?bC9NdjlXSG9tREJwU2g3aStEZWI1M09xWmIwWDBYc0x6VmVLNnJyLzB6cGp4?=
 =?utf-8?B?UjhZS2tQUjRxMSsxOGlwejcva29xRVhDR3JNMGRkWmtrcUxjejR0Z2luOWVI?=
 =?utf-8?B?LzZoMEg0SU5PaUw2aXBDdzVsU1lESElPOHVGWUUvOWJNQTZoaVhqaFU3cmxX?=
 =?utf-8?B?R043MWNVU2R0dmtGbWg3eTZ1eXU3K0ErZWg2VllUYmt4ek55VXJ5enJodUpp?=
 =?utf-8?B?T3ErTFUxdjVQSkZXQ1dic2lkU2tHMGRiYlRIVmw0V2JXMmh3TVIyUkVGR2k3?=
 =?utf-8?B?MnpJTG1ETmJONVAwUmFvWVNBQUw2U2dkckdjenRUVWcralE1ODVoZUVwS3pi?=
 =?utf-8?B?aWxaQkE3U2t3eVNGNVd0dHlydGFrVldLb29SUGp1TzBLcTF0VytQWmxwYlpT?=
 =?utf-8?B?dlQ1WkcwYmhwL3pVN3M3b3RISVdjb25LdEdHckNGbEpWRFh0c2NpMit4VytU?=
 =?utf-8?B?QnJENnpIVlJWN1YwZ1B1anNPbExURDFJajVRRHdJT3pJa1dSaVZCTklZcU5i?=
 =?utf-8?B?enIwZ3Nhd0xtbkx4U0tUSlRBN3ZHeFlKWCthNE9HdWx4bUFtTitkQ3pTMFJJ?=
 =?utf-8?B?MFVFTllqWkpOREoxMGRQRUFROEt4SzQ3SVlST1B1eDMwY255ZHNvdkViSzZ4?=
 =?utf-8?B?bUZYNWFwVGpCWHZxeVRnWVE3S1NVY1ErS09WcVRmKzg3WTdPTWl2VEhLTGxI?=
 =?utf-8?B?UENFQXY2ZHhUczQrbzlEV25RVGZaSGFHdzAycis2Z3N0bmt0amlPT0hpWk16?=
 =?utf-8?B?aFlCM3R2eTcrMmU4SjhyR2tiN1F0dHFnemEvLzdpRndoNmdtVGFLQVpjMnZs?=
 =?utf-8?B?cWY0dTNWQ1IzQzkreHRtYStrYWFzcW44ejlhV2MrdzMrTmlMR3RlRFZPTVVr?=
 =?utf-8?B?VHNoazI1R283MW9QWU5BZ0F6eXJodGJuYnZGcUlMTTZlV2NBOHJrQmVzVnQw?=
 =?utf-8?B?VW9CalJXSUk2UzY1bWlRdWE0TWN2aEdXek5SWHNETjdMRnhzZWZMa2FzZkt0?=
 =?utf-8?B?eFlpUVprV091NklXd1RlL0drdDZDK05telZzYmVaemNsUkdKc3hzM3ZtMTdk?=
 =?utf-8?B?VFRqOStLS2NUY3MrRjJJWUFjcVJ5YmdDWks0YStaUHVtM1VJKzkvSFRENmxz?=
 =?utf-8?B?NjlDMmhKcHpwNGxTdFRIMGo1TGJ6VVJ0eFdmZGZVRHg4UHlCZUlSL3FIV25t?=
 =?utf-8?B?clhaQ3kzSjBtQnN2d3dBRll2WDczamZBWWVJZ0N6VmtsL01Sd09RNnJMSnlS?=
 =?utf-8?B?d3hPbTJkTzArd0dvbWlMY0w2bVd3Q2FoV2NIMG1hUUx1NEdTZnNvalRYWnVx?=
 =?utf-8?B?Z2pkS3N5MlNpTjYzbUVhMmZiUjZSSjBTODhIMldzcXZ6cWFsU2FHMitxTld1?=
 =?utf-8?B?WWVRcGxoU3NtazRwbTNhdmN2TXdpYlVFQjZzaDhnUUwvMW5adHJsU0t6RnFI?=
 =?utf-8?B?bXBUNWg1bit6Wkc0U09ZTmY4TzR5SWtRSHlMZHVNNW13dXZrMUFYOHYxdVNx?=
 =?utf-8?B?enA1WlduQUgxM2gwQjZBQXFBdFZSVGRXMHpLaWVoVU5wRnFaZTlnQk5sb0du?=
 =?utf-8?B?YWRkeFJaR3hXNEF3U2pzdDRnYi9USW1TVUozYnUyVzdVeVdnb2pTaXdMdVpV?=
 =?utf-8?B?Z0t4NXhLNURoRmJoZVBobHB0Y282MGRJU0gzQmZBbWdmQW5xaXFhSHpIYmZX?=
 =?utf-8?B?UDZhZ1ZsNTZoNHNrc1UzKytKN0xzTG5DSGhteGN3alFEUWRqajdqZGFmTXYy?=
 =?utf-8?B?VGRkeDhseWl2VVA2a1pRK1BkNkJHcmw3a3Q4d0dUT082bzlUV3ZiY3RySHFl?=
 =?utf-8?Q?PQZZcuY68mGxoygm0ns+p7LltJgtY7H+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkJUdU94azVJTGtQbUJkRVZQRkFRc2M5K251QUpYQjFzcm82T2toc1d4SXRy?=
 =?utf-8?B?cC9Bc284TTlvaVluaUJCaTd4KzBGRjJIRzFodmFmZzVaTlBWQ0VzVkpmSkpq?=
 =?utf-8?B?M0srN1dtcE9hMnZzQTlLeWlmdDIyZ0RQbzNaeFhKc3NMekhyTjdNRjYzVVk5?=
 =?utf-8?B?S0dMSjB0WXcvOE1IUHpmTkJROGFqS1hwbTJNSGhya1VkVW9TVnh0U1V1SnVQ?=
 =?utf-8?B?NlNVSVZLaW8rTE5lSGlmNlpEbE1Cb0QvazhKSVJEak56RmluMEswcm43SENk?=
 =?utf-8?B?V0lJcEJaL0psb01vaTBiWDRKN0NCUlQ0YUo2VjMwaW52S3IxNEExbU5SVElN?=
 =?utf-8?B?eHNHRWFYRkF1Q3VwY21JNWIzRC8weHo0VHNmZ1RlZDh4bEkwNTl6V0JSYy9w?=
 =?utf-8?B?SXdHOU5DaVRPaUo2cysxK0hkUmNGTDBaRWgwSjdkOEt5RDk2YWdqamVoV1JD?=
 =?utf-8?B?TUYraU8xcGtNTW5obFI2ZXR3aTRlYUdCcWpwUmNmZzVyeXg1VU5FTWt4YkM0?=
 =?utf-8?B?bTdaR3NGUUt6T24wWEZ4c2QreDF3eXVzMmRtZk5GQ1J2UE1sMUc5M1lGRWhL?=
 =?utf-8?B?SEVwQmlUcHhiSkxRWHY3b1BPV0ZSbmNpNUdlUVJCOVRxbmFwQlNQdEVKNFlN?=
 =?utf-8?B?bDhtZGJvak5LMTN5bFRQVmYxc0dKdnRvOHRpSklva2g3OVdSNVdDS1BBWkVT?=
 =?utf-8?B?N091cEdobXU5dUNiTExyNGI0Ykxpd0NNcmtsTXZ4dEhSeTBtNFNUM1owc0s1?=
 =?utf-8?B?YWxiaWpRNlZwUFhmcVpuVFlYcXU5aXNiSlhWNHFxRkFuZ3JwdTEwY1pQejEy?=
 =?utf-8?B?ZEszQm5TNC8wVktoKzFPY1hWYmYzK1ZmOFhEMzNTUS90TFZSaVpvQlZqY0Fr?=
 =?utf-8?B?RXFzWlNIRjRkZ1lWMXJsYktoSUVMb01OZzVKamM1dWxVa091dFpWOFZsS0dt?=
 =?utf-8?B?STJnKzB3bGdwd25hU05zNGhvWldwZmdwSEZKR0ZOS3VPTTl3SVM5UWVhcE55?=
 =?utf-8?B?bTVwT0pkRTVHSkxPS0tDYitEODNNbU9idEZQS1VJZGZxWm1WM0luWWZVSDFC?=
 =?utf-8?B?NnBGbjBWMVdmVlBMVW5zQnAvTzhjSTRncFhvRlZNNHo1OVhnS2pQRHVxZG5L?=
 =?utf-8?B?Z1dYa0lpWVBMZWpKL01Qc0FDQ2IyRm81QzVjcWpmU0djRk9vb2wrRGRBYVRo?=
 =?utf-8?B?WEJUUzhNbW9VSDB2Y1hBTGV2Qkpqb1p5ZmJyTWFCRy9yVXJKeVV2Y0hjblZk?=
 =?utf-8?B?NTZIaUZLUVFpcW9YVzlnc1N1R0pBYkFub2hLblNTRFA4Z3I0bmVrcS9kbGpK?=
 =?utf-8?B?eXAxOTZINEdDWnVPOGtiMHZSN21nUmNETWo1Zkl6L2MreXg4c1IxU2NoM3BJ?=
 =?utf-8?B?dU1mRWROUTRxLzdTZkFQR2wvbW5CaEo2elZYSElwZUhubXZBd0pYaVpEZitn?=
 =?utf-8?B?TG5XUU9ITU0wdUE3NXJRYXdreG1GaUlGWUp2Mi9SYzhzc3ZLaXN1MmhqbDlY?=
 =?utf-8?B?ZGYrTUFjT3E2WnhhRkREZFJtaWRqTjdZRzZ4ekxHQjRvaFBPbWdVOGFvZmRS?=
 =?utf-8?B?WmNYNlNkNGNZS0pPaW13ZXd6N3U3dHNOY3FiNHlCMUF3Z0tXQUNXUEFnVk9r?=
 =?utf-8?B?VGw3UTk1dVZXdFZkZ1V6V080d3l0NGFvY09oK0ZpVDVyYVl6b2pOTEVIVm1H?=
 =?utf-8?B?Q2JSOTBsVUZ5WStyNVA4czNNcEpVM3I3cTJMY3pZbWw0Z2FVRWFhQmhNM1lJ?=
 =?utf-8?B?MmFQVGpIVVdNMkZ4b2ttMXZQL0xjVnhERUo2UFY0dHYwQTN6YndWZ1I2TmFV?=
 =?utf-8?B?Um80dWRRS3lpV1lNMTRkdTRFRWtIbmF3UEVQQ0pYZ3dMOWhGdVZyQmpvekR2?=
 =?utf-8?B?cDRhSXpRVlh1WlFrTHl2MUhKRlhKSUZCOWxjTnRtVXY5L21BRkdSUHpOdzQ3?=
 =?utf-8?B?MzVNVjhpaWdyWE5nK2hmSTZtL0hRdnNMVENsb0daVVNDdGl1ZXRja0o4Qmpk?=
 =?utf-8?B?WkdyOW5TcGc4bjI4bHF3VExwRDI0cFlFTEM3VDEwNmxHQ3J3K25FaGtmUVlk?=
 =?utf-8?B?UncxWFFTWlJyeEVxRmZCNDY2UEJMT3JFVVAvZ3g5alh5TkszTFQwNkVTNkc0?=
 =?utf-8?B?UlBzZHpvaUlTTDBuL2VrNkliSjhxOXNtNWFwNkgvYnBreEtVWlV4dE1wZ0JT?=
 =?utf-8?B?bzhhb3VFRFFZUWMzMjdLNk4za3lhMlhQYksrU0V4SUN0dkpVUm9Ucjc3aVc1?=
 =?utf-8?B?OGRPMHViQWpueTRYZTJYTGdoZFVUL3hYSit6dWdUNHZieWRDeEF6bDlsZEEx?=
 =?utf-8?Q?yki4ny0e6wx6Jjtd+e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018de074-ab78-4fd7-235c-08de479b8567
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 12:04:01.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Me+X1qVZWxrV2nrc1+wOADVrIr3L+WoH9vrWxaiDuiXuAmMkyD1Ak+mtWRNrI6lYkPu9EuXHwrGIef7LhiEIDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999085

On Tue, Dec 30, 2025 at 12:25:39PM +0100, Alexandre Knecht wrote:
> Hi Ido, Nik, thanks for the review. I'm sorry for the missing
> maintainers, I felt so bad when I saw the bot result after posting,
> will not happen ever again.
> 
> > It's not clear from the commit message why 802.1Q bridges are
> > unaffected. I think you mean that in 802.1Q bridges the C-VLAN is never
> > in the payload and always in hwaccel (even when Tx VLAN offload is
> > disabled, thanks to commit 12464bb8de021).
> 
> You're right that I should clarify, but I think we may be talking
> about different scenarios.
> 
> The 802.1Q bridge I mentioned is specifically the case with
> vlan_tunnel enabled (for VXLAN bridging). In this setup:
> 
> 1. The bridge uses per-vlan br_tunnel_info to map C-VLAN (0x8100) to VNI
> 2. On egress via br_handle_egress_vlan_tunnel(), the C-VLAN is cleared
> from hwaccel and used to set the tunnel_id in dst_metadata
> 3. After skb_vlan_pop() clears hwaccel, skb->protocol is the actual
> payload type (e.g., IPv4), not a VLAN ethertype, so the second phase
> of skb_vlan_pop() that pops nested VLANs from payload never triggers
> 
> So in this 802.1Q + vlan_tunnel path, there's no C-VLAN in hwaccel at
> the VXLAN driver entry point.
> 
> For 802.1ad bridges, here is what I understood of the flow at egress
> in br_handle_egress_vlan_tunnel():
> 
>   // 1. S-VLAN is in hwaccel at this point (bridge put it there)
>   tunnel_id = READ_ONCE(vlan->tinfo.tunnel_id);
>   if (!tunnel_id || unlikely(!skb_vlan_tag_present(skb))) // ← checks hwaccel!
>   return 0;
> 
>   // 2. Set tunnel metadata (VNI) : this goes in skb_dst, NOT hwaccel
>   skb_dst_drop(skb);
>   // ... creates metadata_dst with tunnel_id ...
>   skb_dst_set(skb, &tunnel_dst->dst);
> 
>   // 3. Now remove the S-VLAN from hwaccel (it's been "consumed" for VNI lookup)
>   err = skb_vlan_pop(skb); // ← BUG: also pops C-VLAN from payload
> 
> So at the moment skb_vlan_pop() is called:
> - S-VLAN: in hwaccel (skb->vlan_tci) : needs to be cleared
> - C-VLAN: in packet payload : should NOT be touched
> - VNI: already set in skb_dst() metadata : separate from VLAN
> 
> The S-VLAN was used to lookup the VNI, but it's still sitting in
> hwaccel and needs to be removed before the packet goes into the VXLAN
> tunnel. The problem is skb_vlan_pop() does more than just clear
> hwaccel, it also "normalizes" any nested VLAN it finds in the payload.
> The fix uses __vlan_hwaccel_clear_tag() instead, which only clears
> hwaccel without touching the payload.

I agree with the analysis and the fix looks correct to me. Also tested
with test_vxlan_vnifiltering.sh which tests the 802.1Q scenario.

