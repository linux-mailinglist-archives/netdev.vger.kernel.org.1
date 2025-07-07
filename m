Return-Path: <netdev+bounces-204561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42698AFB2E3
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 14:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D02178733
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9196028E59C;
	Mon,  7 Jul 2025 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nxbUOreq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E748285CB8;
	Mon,  7 Jul 2025 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890024; cv=fail; b=clO8VJRoAOuk5yrLg8HRpAkpp8U3ZyYqzF3Cr9n3vj9KU1TwVVJyaCfvy+yFFhIBQvtlV+AaXCU357RAHt3NC6dBhY8wEFWiHTN/bpaY9u+iP8rmdSOgUhZOioT9aAcm89nO2ZJwkktCI5VFzSEl+g8oP2nDLPPZaekcos8tgR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890024; c=relaxed/simple;
	bh=XxxRyEGJFxe3xdYZff5n5H4gOiP+4dfsctgB/GGFPCg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aiiUUq02x83Nh1hzukLfHoxGwuIAL1hZgqwyp68qLzgVX0KFIpyBG7QNmMgGVSvtJoA3Ya9jc+z5tEcT0spcxsptKrrXcedlaqmPch2Ffq8324IsD3LEtnBk7Mi2n+YYnV89FHBScBabgpntHORlQKJKPZDTlU1LTGGGyEfYHUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nxbUOreq; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvWowyzhtvW1zA01B2nvw9oaApGH997rjYJRxusknwrJNs9/HYbKpuNc8htTBDzPyMCxXUwixFbk9Bbv537hMoox5oayfVuCXUnOy4o3i4vxSP//BfQfb9NluAItDhe9trWO37x5ugy4x2ChsmGlMrDqYUaRLvyAurwrpnTTBHFbPsGU9hb2sk4fzKXUX4iqSPyb682mYu+KOY6SZV9aj3uUEU2CQvhfP2iDzA7GaLgo1e1G9D+IelgISOBZeq1vtwT4kXJNSzeO6N5YMKPCSHui+F/GX7UjWp52QOeI5X863lStD8j0pKo5fMa1K/wmQ3UExlpfZFbhkB+JA0PtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4wKtEqnIWB0O6q/k45O5irunPZtWfRAOfJJ/lxyoEI=;
 b=rn2eabU8/iVFFk4u19WrdAj9wxIRUXR80geqk6v07gdJtjNIyiAFoADQkXBO9itkTJ8+z5ORyKoDVxGb2K6omqsOdAB+ia+Zfh6GwWs37gah75dnNWkNR/NR41ZfzKe+j0rCV3/fzDmdSKSadkchTN98mMESY/ZCLaleY22/8uAJxbHDyLpQeUCSgwSFJiYG62AB/mahI02TIlgNxrSF8AYOkyr/egNJMn5t4foArguwaybp9JZoLNFbA+5HH5spjhKy8jxbtULRJPrwytTUxFBG8LFjb5vbIR9qGJWI0E7FCbuwDrDJlotLUTsgsYHuk4GKe6hlilGrauuqxnCgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4wKtEqnIWB0O6q/k45O5irunPZtWfRAOfJJ/lxyoEI=;
 b=nxbUOreqY8cvS28KyHKodiYP8ZR/cSYu4g4WTGfeTBDDAip+p/eYOCLYPSsDBcHhV+ImuH0Ox3ldIoRN03cMC/4RR0Dr9oH8s5d2Szd3L4eWvmOEr8dFSQMBPJtlljhrMF9tLfRqYka2pMnYNXeoIkY8l32HRR3Qo6b46/gKHm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 12:06:58 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 12:06:58 +0000
Message-ID: <9141f3c4-0997-4edf-9b48-59e6b8d5dc45@amd.com>
Date: Mon, 7 Jul 2025 13:06:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 22/22] sfc: support pio mapping based on cxl
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-23-alejandro.lucero-palau@amd.com>
 <20250627104635.000003c4@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627104635.000003c4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0269.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::34) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: bde818b8-995a-48ea-1ea6-08ddbd4ec621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ylp1VzM1SmtpTy9FWGxwM04rOXoyMDJVVjd1TmoyaUJjdkRCajRINThZRlAz?=
 =?utf-8?B?emcwb3YvWkR4UVFnY0hha1cyZ0Z3MTh0M01aS2xqcytTQTBRbWRkMXNaRkl4?=
 =?utf-8?B?NVowSW00cFdaS0hZaTRpU0xCcnJwZHV0VHB0Ni9kK3pNZjYza2sxRnlGaStG?=
 =?utf-8?B?ZWpsOWt4ZUZpc2t6RGNQMXJEZ0NuTWJZQ1E0dWRvZ2QyNmg4NDEvNTdPNGNE?=
 =?utf-8?B?RzlFMUhEOU5oRldoWTJTMUFsUGwveVBjRmtjVnVvRFJiY0srbklkbmJ6L2tK?=
 =?utf-8?B?eTF6OHBxcFpPckR5dVVNMlU3R0t6TGlBMDV1N3Zub3B3M0w0S3dROVNsbW5I?=
 =?utf-8?B?TGFwZzZLSURsenpMSW10RVpmS3Q1NjIraVJVSnRmVmo4OGlYd3ozUFdBcWZ1?=
 =?utf-8?B?N2Z3TTA1LzFlQmhWajhmRlZ1RUl3S041V3hvUm14VVRNSktFV2MxN29ZK21G?=
 =?utf-8?B?Nkp5ZmNtWnh5ZlUxODFTaDJZZ1RPM2F6a0tScFBDcDFxSUVudlR3SDgvVDlV?=
 =?utf-8?B?cXIzSFEzWTRhZFVHVy9Td21LNGVPRVNQbzRsMlZrWERkUDU0WUlic2N3eldj?=
 =?utf-8?B?QXNGa3Z5bktTQ1Z4aUl2aEc0Q3JqNVArcDlwcmcvSWx2bjJDaEtTeEl2aXNa?=
 =?utf-8?B?NkF5TXJkelM0UHhFUmE3S0NKV2syT1ozS0Q1Rk9QeUhQVFRtUFVCZ1BpN2xK?=
 =?utf-8?B?cHBqeVMzRXdWelJ5Y2p6TERVOVRwYkMyVFpiZU5GcGprWjdKa0VwVDExbXhy?=
 =?utf-8?B?djN6TW1kNG0vZUgxYVhYSFZpRG9qYmREczVGZkFTSVhQWXVKcncvUnAzMU1B?=
 =?utf-8?B?RUVtb21sSEV5cmVBc2J1WDIwV0NTYXFRc1FubzhoZVJ6SXk4R21Pa2x0UU53?=
 =?utf-8?B?RC9jaHNWK0lzQ3ZaK0E2Z2IxcEZNY3UwU2YwODFWOGsyYzR6U0RNemY1Rjl1?=
 =?utf-8?B?SlFEdThQUkFLeEo1Ti9SdFNwS28yZWJzTUdwUUlKYms3L2ZaWkg2UGhVdlpq?=
 =?utf-8?B?TG9oS0tiK1hzbTZHellHV1p3blNwOUZLQUUrRUx4cGVFS3dzcC9VVjcvN2x2?=
 =?utf-8?B?VEhCbzc0V2twNlhwa1IzN2FERlNad2taV3FvcFQ1YUtWUCtNRjQvRHd6eGRH?=
 =?utf-8?B?M2owRURJR29NaXZzYVBFaS82SUF0ZFIvMitMNzdvU1VZVkI2eXlZMjhuM1RH?=
 =?utf-8?B?aDhrK0U3L1dkcmthV3dzNndNTkg4L1NVYmlEcnhESStXQ1dEWTdKWm5JY3Nw?=
 =?utf-8?B?M05qYmRURjd4MS9Qb3RZTVh2TmpuZFQ1ZnB0QTNIKzZ4Wk1mODlnSmF0cVZC?=
 =?utf-8?B?Qm5yY3JMVklpKzlYS3dGUWYxaWF0ZitBeDlaT3VvSVVjUzVYcnREMlN6dnFH?=
 =?utf-8?B?eURla0NhQmFucU91WTVxY2FIN3FIRURlTDM4Tk1OT0hzTGtTRFJsMGpjZjRO?=
 =?utf-8?B?MHlvaFg1K21rb1JPbEZBV0tIdmZWaGxOOTM4end2QTNhakp3MnlHNWRMYTVL?=
 =?utf-8?B?R3EwcmNyajlUSEczQ29iZkNKejVFaUp4OEpRb051d2N1MzkwVFhPcWFLZUds?=
 =?utf-8?B?bUdteU81TWRSNHBWa1JReHhwTWJUVnRGUlRJVUxwTmlHRCtZQVJJdjM3L09p?=
 =?utf-8?B?N1NmNlR2bmYrVmdkUzBhekFsVkZVQlJGalZhWkl0NVZTVmNOY1lrdGZCZjBK?=
 =?utf-8?B?UXVVVWxqVElzaUtxTjlJQzRHUG13SERQSHBhRWo3NW9SR054R2RaWkkweUw0?=
 =?utf-8?B?NE1BbXhBMEFMOXNPeFVmS0hHT3hkakswTjVKaExzclI1dys5eW1XeG12K2V6?=
 =?utf-8?B?WU55NFFGaTNrN3JHcGVpTS9MeUNFRW01cGxPSjBvK3VlUEFxMldLOTQ5YVJW?=
 =?utf-8?B?Sk5pemdRVzNCcmxyekFXUGtscTZCcjBnL1FVcUJIeXZ1WTZjSHp5QWxiZ3Ev?=
 =?utf-8?Q?+m6kY+r5P+8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eCtORHR0MHFERC9vVHV6Z0pmZUJ1aVNpSExoTWFiWGVOdWdJUzVZK2drZFNS?=
 =?utf-8?B?TElMNlhyWTcrcCtNQXJUZ3J3dXNGeXhtWXRZS3BQVEpZanRqdmJZZGVxU1U4?=
 =?utf-8?B?U3JTaGNzTUJzYjhqaGEzQmMvUzEwRVBKL05pS3RYbTBkaW1KV0RubTZ3YVlq?=
 =?utf-8?B?SE5VcWo2VzU4K3VNanBFbnhRdURtMjM5Qkp3RzRBMnFOTmlld0FXejQrTTk2?=
 =?utf-8?B?RFMrVldrRnFqYmQvdUNTc3JhaEhHd2RiZTVLcUkyVnl5T0ZwcXJQWERRMERh?=
 =?utf-8?B?RnVVK0U4ZGVXUFVLdFpRRGtnTmFHazc5SXFTQkYwU0dxeFErS3lzRlRDemF4?=
 =?utf-8?B?NjlQOFF6UGFiVlJKS3R4dm9LRUZUeksrRmllUmRYN2ZETkVUWnBIMkxsM2Rx?=
 =?utf-8?B?clFkc2VySi84UmR3TnNEc0hxdTJ4ZXBKS0xUTkJqZk8xTklQT2NodDY1QitQ?=
 =?utf-8?B?YytHT3N6dG9KY05lOHcwSE91Y3djSktkMXVTWTZVRHR3YWFnSktBaTJUeGwx?=
 =?utf-8?B?WVViSktFRDJoeklrcEl0OGhYeFE3enB1ZjlNMnN0L1VHWWlBQmlISkNCTVI5?=
 =?utf-8?B?Tms4cmdySEl2Q2cxYmozTUU0ZVJ2RE9lemo0bTVBY3JTc0JxWDVWWGViTWdP?=
 =?utf-8?B?TERVK0RSdE4rVk9TQzVrU2gvY3lwbGR0eUkzQVFtc1RqVTJ0dDk1bHF3dThq?=
 =?utf-8?B?d0lxL2tUNE41Wml4TU4rZUdGNWtnT2RTTUtjSU9Ed3Q3Tm9wU3B2cUtpTXpW?=
 =?utf-8?B?cU04M0ttZENrNmh6bHQ3YW5Uc25IazdqdTVxUHp0Qmx2WHdVTlFEUzVGSXN6?=
 =?utf-8?B?U2llSGYrclRqT3F1ZnR2TlhlQkYvblpoNFBjWjF3NVFMTDR1eVA1cWlDalpu?=
 =?utf-8?B?NGd3SjNKWURuV0FTcUkwKzViQzlYUU1UNlZWSXlzZjR1Q3ZyUkZSb0RPWnZa?=
 =?utf-8?B?M1JiS0FxZjZVWTY1VWgycXFIVHQxZ2dqNGVlMXB6MGVzL3J6OTI3Ukx1bVdu?=
 =?utf-8?B?RXNUcmVzNGwxVVJTMGJiRFpjbFMrSnAwbEY2QnRzbFNhS3NSdjRBMlVwS2c3?=
 =?utf-8?B?NEZMZ2pzSDdsZjYxUWlUQzJ2eGQ3N2dYY2FoQ3ZqQjI4MW8xejZ2OXVqbDQ4?=
 =?utf-8?B?Q09ZNVJFZy9ya1R6S3FvbjUzOTU2ODcvYjV6UlVzcWdnQjZTcE8vdXJWL2tv?=
 =?utf-8?B?c05UUHczV3RQNkgyd2JBTUtnMkZIY2FhR2xKZTNJYW12d0JnYlY5SUVYOWFM?=
 =?utf-8?B?U2JtTzE3bENaZFRyTndnSU5qOWIyMC9uSlNwR0xHSkpMbjRzejFVdkd0ckk4?=
 =?utf-8?B?UEFKU0ZMZ3FHYmt3YzJOdVRJRzVqOWhTdm1haEU3VUl0RE1OVUFBNERtZzly?=
 =?utf-8?B?M0o0S2tSRjAvQkhFbmZpUk43QUtvWEhRWmE5emxtc28vSi9OSnlmZmo0RXc5?=
 =?utf-8?B?bStoem9OZ0NmcHVmMHJqb2JNY1RtMmNDRDhTRHJDNWVsMk4zWm9lcXdGN3l1?=
 =?utf-8?B?dms3U2VkWmRuWXNLZU5QRWp4S3lEclErWXVHOUthak9XUzBMV0hHSlA4WXBp?=
 =?utf-8?B?NFZsNndKdWlwWFR1Z3ZjUUhUMXRXbWJ6RlczVEI2KzM5d1hadmxQRGRnNE4z?=
 =?utf-8?B?K1hrUzVtYkRXYkw0N3N4SnAvaWprWnVaL2t6aW5PMzRNRnJYWlZmKzZQMVFH?=
 =?utf-8?B?UVR2enJpWXk3R0l0dWxsdWc1UnlpdC8xeTVtdWVhRjBLVU5ZeUNzRFpMZkFj?=
 =?utf-8?B?aTR3MXp5MlcrRDlqWGZwZzhaTG9Bd0dzWFZsOHhEdWpQazFOVUtNdWQrSWoz?=
 =?utf-8?B?MkltYXZOYXh5SnVZVElzY2I3Y1k3WW1uNG1KNElTZmNaQlVhb1R5WEtCUnh1?=
 =?utf-8?B?M2o5S2o5MjBmSCtsck85TFRyUWp3K0dGb3ZSNGFoemFrNkJyZzR2ZFhUKzBP?=
 =?utf-8?B?OVNpOVdkQWhFWENNUWg1OUUwaVphbHc2RzdYdGJla09ZQTdweWF0N3RoYlFz?=
 =?utf-8?B?ajVaa21RL1g5Q3hpZmxnUnJCMGg5bnUxekNSemFBYTlNQ0E4Qkg5Qmwrb2R6?=
 =?utf-8?B?THlHSHA2WDBncHltYjJqanRGejBQbVovRzQ0ekJxSUhwcGdiQ3RiYnNQblNP?=
 =?utf-8?Q?K4eZ1KLmzAwpoZ2MTSj51kiw1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde818b8-995a-48ea-1ea6-08ddbd4ec621
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 12:06:58.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: medAbK3YB3GePn39GToHjiPqvFonE9kJ6AKz7NFUSK9VGJmJI5kZLMp4moixxxrQZ+G5y2KEA9pc4SRbCTCR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589


On 6/27/25 10:46, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:55 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A PIO buffer is a region of device memory to which the driver can write a
>> packet for TX, with the device handling the transmit doorbell without
>> requiring a DMA for getting the packet data, which helps reducing latency
>> in certain exchanges. With CXL mem protocol this latency can be lowered
>> further.
>>
>> With a device supporting CXL and successfully initialised, use the cxl
>> region to map the memory range and use this mapping for PIO buffers.
>>
>> Add the disabling of those CXL-based PIO buffers if the callback for
>> potential cxl endpoint removal by the CXL code happens.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> There is quite a bit of ifdef magic in here.  If there is any way
> to push that to stubs in headers, it would probably improved code
> readability.


I'll look at it, but I think that would require a major refactoring in 
the main sfc code.


>
>
> I was expecting to at somepoint see handling of the CXL code being
> called returning EPROBE_DEFER but that's not here so I don't
> understand exactly how that is supposed to work if the CXL infrastructure
> hasn't arrived at time of first probe.


As said previously, sfc code is not doing so because it implies a higher 
complexity and I'm not sure the case behind EPROBE DEFER should be 
handled this way. I mean, the system BIOS is doing most of the CXL 
hardware initialization and those latencies supposedly possible are 
likely arising at that point. If the kernel cxl code is affected by some 
hardware latencies during cxl kernel initialization, I would like to 
understand them better. Is this dependent on cxl hardware 
implementation? is it because the way cxl kernel code is implemented? 
The case I suffered regarding cxl_mem module not loaded does not, IMO, 
justify it. Maybe I just need a reference to the CXL specs about this 
for setting my mind. Anyways, I'll think again about it.


> Otherwise, main overall concern is that lifetimes are (I think) more
> complex than they need to be.  I suggest a solution in an earlier patch (and
> in reply to previous version)  Devres groups are really handy for wrapping
> up a bunch of devm calls with the option to unwind them all on error or at
> a specific point in the remove() path for a driver.  That should resolve
> most of my concerns as you'll have something closely approximating a non devm flow.


I think your suggestion makes sense so I'll follow it in next version.


Thanks!


>
> Jonathan

