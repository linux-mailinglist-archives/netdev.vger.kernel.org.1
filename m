Return-Path: <netdev+bounces-114076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB7940DF3
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59CEB29D55
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A2C194C9B;
	Tue, 30 Jul 2024 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QF4BM52V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799818C335;
	Tue, 30 Jul 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332188; cv=fail; b=Wbv8bOfOfIwn4NCM9dQs5YV6qhordU1zAXUv18yfiKhKYcRNZTypdLGhFMzbKTIOcZRmCbuNjNj64eYUzgBoxHT9flCcOL+mtyj15wH2djssDEKnEDzOkd5lv+ODDrz57sdeeiac6DKp3A7yveMlQkc8+D+uAtmjT7H+NCjdL0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332188; c=relaxed/simple;
	bh=FUsua3z8npN6kWsHuXh3YJ4J7ZkDsihq2Acnmjzmj4Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K7w5QtlT5Gn3dT+8gRA83ISi3aG9v2819AWcruMs4vR8UvRrugKmeApyMUCrw3lU2s3UgXL8quQJMoK8WMRpYhXraznWOc9cBwoCvf2FlEasSuaSDwMRD3MfoN8nto+sSoAhXC//2PoavNQPCE0wIAigKQB+dU07RbB8lJzozHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QF4BM52V; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeFaKeSkOzqQ2pLdgvGcKqVYRuXxZgayjc6o4xqM6We4n4KuSbJIK5wP6LFFZrwi/zUwxnjOGIBn780vtI9Tx7VjeddjLsjyWrbRh6YK6VoCUGMNEL8Qy8uGSqOjq4bztrw6V+0aAIIiX6wYyHcDSzI46KVyXpGTCUG/eDM+oPG726CszHxs0CTxjEscEDyczfgPrNN9Pk5mdHmaTTkWujVdqkjvoJv3RrAQPL0NWUYWnR7OcDfB6iihGOip2jN1eClCG96atLuXmx5snbEcnakWzAjlCkzlHxy4HewRq7pYXEeMx0fDjyvTgsgCHocebY86WNHWEvRQ1GH+Oilsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vq1zum2mQnjaK8on4gL9PWc3tfgbNmM1LmLxkUNwE8=;
 b=fPrW99SFu+I0BFxV05CuK3W1kY0WQHu4ZP+IVdtdDq3oyzO6QnQ8/zw9tbllTutsq0swkXUdDsmSJ9RdhWbUI4g3zF07gyBSzJcfWE1BVMM1UB4JOcXlzv4+y4q2B6ItIzWPgzkvt4JUxp+9CFrP94DVoKpUDSzPI0GVa61L7xB3HpiExdKZW5ZCzJ8ckcSfCbXEuWIwEift9AxvvqmIg+FVyUsdUzIRQLbHbfFmCRb1yfm4hI7KW5OpCZTayEgrLQ3U8xo7Md8NOl0mXHEJnCwpMMOPmAMDcSRbf4K8YAIBT8EhD3DItAxztXLeQhpOhTSkGd1IgOpTggSA2dXJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vq1zum2mQnjaK8on4gL9PWc3tfgbNmM1LmLxkUNwE8=;
 b=QF4BM52VgGta38BPQnCeJyMnxRslUv3jakxlYfAE3pztnxcVX6AGc/yoJAfGbC0Wlv/JmVFxOc1tUVZa/vc9wlpuRY0YQPRL0MLco682DtYFxeZEaMyvUfrTA2Z1gjK+5LcTCsGWrFvBtFcwOwFDIRAAjriv1+1jSWvZeVTpFDPEeWUnFAM+f43eXKVjnRVndX6XV8LhKD664NWv84IktPJvGbevb3kJoir+Aqgjtiky/Aa0VseZ9JV8mH8q0ivSv69ZJXRipMdZ3J8F3UUGakiVaVarCuAPqI4iCXy5T0KGteiIPaKN1hlEGHd0vFZk2inV6MuW9ITWkVNtnhPa5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Tue, 30 Jul 2024 09:36:22 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%3]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:36:22 +0000
Message-ID: <2aefce6d-5009-491b-b797-ca318e8bad4e@nvidia.com>
Date: Tue, 30 Jul 2024 10:36:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system
 side
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Revanth Kumar Uppala <ruppala@nvidia.com>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-3-ruppala@nvidia.com>
 <ZJw2u6BIShe2ZGsw@shell.armlinux.org.uk>
 <BL3PR12MB64504E3A40CD6D8EAB7FF0C8C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
 <ZL5nQxCyj8x+5lWk@shell.armlinux.org.uk>
 <bb949d68-3229-45b8-964c-54ccf812f6f8@nvidia.com>
 <ZqdzOxYJiRyft1Nh@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <ZqdzOxYJiRyft1Nh@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0098.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::13) To DM8PR12MB5447.namprd12.prod.outlook.com
 (2603:10b6:8:36::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0508c3-c003-4b21-e6f1-08dcb07b12da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXFzemZGZ0pCMXY4NFg2NXczY3VrNzZCNERsYnNzbWlUSGx0MXNRV3JjNFUy?=
 =?utf-8?B?bVc2WWxLa0hUR21ETk9EbldKNGViZjIzbHhxRHBMU1c4NXlpdEE1Wms0OGZ4?=
 =?utf-8?B?cDZaSmZOcEt5d2JNaTZ5Z29tenJrL1Q5azFYK0d3VEVmRThFVE9KVlJzaFhi?=
 =?utf-8?B?dkFPbnE3WVljOW1JRnFIWFZyVWtPTytzbXIwemxsVk50Znh4ZDBRUDdJV3Fs?=
 =?utf-8?B?eEZTMEFoZkF3ZEkweGk3c2ZSeTlTb1o3VGt4dTc0cG02REg0d2hTaDBwMjFC?=
 =?utf-8?B?L1p3dndJakNZd1loTU90bk1mQjFRZ3IwYlZjZlJCc2s3WUIwY2xzdnlMZkFu?=
 =?utf-8?B?dmkzR0l3NXo0RmwxVm05Q1pINy9oSGhGdjNOVHlmZVNIUjNrZGpVbmhIUDcw?=
 =?utf-8?B?REF5OFNQN1FyMjBuSDRjaHdOcHZWM2FmL2tnRWFzR1gwRWZ2c3VEQ2JYTk1j?=
 =?utf-8?B?YlVOVmtYUnR1dllNbU4xTWt3Z2s1Ym43bGNSL1V2TlRIUEJiZmJGdVFHRDlF?=
 =?utf-8?B?SzJ0TXhrcUN4SkpXSElLa29MQmV3M2tnUXMvbXJscTRjTU1MRW5RWTVHSmRT?=
 =?utf-8?B?Yy9TWjR3L3d5bmxvYzVPeW9RNWFEaTJKeFh2K2lsaExaaE5kVlNqRVZJR1hi?=
 =?utf-8?B?VjlmL1BFOERiaUF1eXhGSkRQZ2lPZ1gyWWZEd2lzS3lDSjZmZnVTRkZqaC9z?=
 =?utf-8?B?Yi94YjhnMS9NbEs1ZGY4ZGY1SG14SVhDVXlSRHQxaGJJaG81YzhMZVRvOFVV?=
 =?utf-8?B?M3kxM0ZQeVJxLys0Vk5HQitUdXhQcG5RYVpUSVlvWTNpVU1Pd1VQLy9pcUNF?=
 =?utf-8?B?M25MZ2dUdHhSRzY2cXVBK1hCSm5XWVRUSC9DcVU4R2dkSWsyUEZkS2ZXb3Q4?=
 =?utf-8?B?eENjWU1HZ0M2UThvQlM5cVpleDEvdlk3K2VCR2R6eU1ycTJvTEhOS2RwR2dx?=
 =?utf-8?B?Z1BIeE1zR3hoRmhLZVRqeTJ1R1VHa01jM2dCdHhsOFVjM1N4QThhWkRKelRO?=
 =?utf-8?B?SlJoVWhCanJ6bVQ2bUNEQnJuaTloQlEwemRlTjRiYkVlZWt5Sk1sY0lKSi9Z?=
 =?utf-8?B?Z25GMTdQYjJJSzRrVWRWbnBtaklsQ3VDNjZjNEtsSXh4RlVwaDI3NWRZSUJt?=
 =?utf-8?B?ZTNvTlkvTnh3dUxwdVFQazJnTWpCZ3pPanl6ZVJ4NXZBT2Qwd1VLNTAwK1pw?=
 =?utf-8?B?cE1vWmhpUVpzakNkOFljM1UvZ29SMWdEbUR5aEJOb2lzKzhZN3ByUjZMU052?=
 =?utf-8?B?dXJIMVFxYW9xcnRBTDBWeEgraWJCTmFYeG5VWmV3Slp0TExpOWIwb3ZXeEo1?=
 =?utf-8?B?TnRFZkVlY1NqL2wvaG43VVJLYW5veHNDN1d2cm04L2RJRXp0R3ozTTN4R05N?=
 =?utf-8?B?Mk90b1l3L211N2VUaW0wSjJXa2FZc1lHVHF6UEpFVlFGNVpkcmkzNDVMNmcz?=
 =?utf-8?B?NktCMGxEamE0WVhaR204Z3pFOUg0ZzdBTUxZK0E4ZzhBY3ROdDNoamxmN3hK?=
 =?utf-8?B?dWF2YVU3V3dtZ204UHl0WEJlQXM1MEtCa01sVmxlZFIvRUhuZ25QeFhQcUpz?=
 =?utf-8?B?V0U5ZWhZYUVIWS92Q3RkbGpCMVkxQXFIR0ZIRlBmMGdkSUZIZHVkOGNmL05V?=
 =?utf-8?B?cS9EU095bS84c3FBOVhXME5XNzZmQ3NyZEwvZTg2S2pLQTVYOVkyWnpHN3VT?=
 =?utf-8?B?Vndld3NWYkxFR2dUYWNrN0M3aExmN2NLMDd3b3FXbU54TFZERzFFdUliZ3F4?=
 =?utf-8?B?NlZ3VFJBcXgwS004VENkRWxNMDNLUTMxQ1lBaSt6OEZZOWZSWXFvSlRmUFRU?=
 =?utf-8?B?NVZaaktpY2QvRWRraGZ3dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGxyK29PdnVNSnlueDBZVWFOc3Jaa0VMcEx2dkQxMnk5Yk1iQ1J5M0o2aHkr?=
 =?utf-8?B?NWRDRVNKejdOVEJEUGZ6VThnbUFKaU9NdzBFRmF4UFNwRENRdkJiNVVPNDgv?=
 =?utf-8?B?alBTUS9uc2dUNXdrOFd5V0x1RjhpRW1ROUlZdDhnQmRVOThSS1ppOEhWbXdN?=
 =?utf-8?B?b1cvVGNkQ01adGV0ZFNBYXVSOUNhd3lWOWVRbTBqSTR3VzVBNEpTMDJ0K0xv?=
 =?utf-8?B?NTFwVGVwU0c2bVBVWmFaS0FTcFdmR2ZGSW4xS2ZJOCtNN1pGZXRFanZMNnN0?=
 =?utf-8?B?NEVrZDhGdTNXdU0rWXkvelVIYlY4cHhhb0RBb1pQaTgxb00vVjZmWEtQQWtJ?=
 =?utf-8?B?ZzZJcnlzS2UyU2JzN2Mza1RnS3VWaFVOR3VmMlJaZzlpejRyd1Y4TExVdWJr?=
 =?utf-8?B?Y3hMVVdVL1F2dE1mak9UcHBvQkFGQnNPV2tIWW0xNVpFd0M2TVV1WlNod3Ur?=
 =?utf-8?B?UEZyTjdreFlYdkZ3bmI5WURhQVdTYWh1WVRPaHp1QkZ1ZC9weGVudEg1NHp5?=
 =?utf-8?B?SmdvcGYrMHFwOGxnbDBaTG9iaXFUOTh4ZmRUaWh2ckx6dG4xS3JXSXBKZVVz?=
 =?utf-8?B?ekUyYU9lSitKb1VsclpkQzg1cGtlb2loaHlDdG5GMHUycFFZeWZsb2JtVm5Z?=
 =?utf-8?B?Y0pVSmw5cmF4M0hzelF2RVB3K285Z21tOFBqMjFlWWxpZHczc1dYREFMQkJu?=
 =?utf-8?B?ME1FRG53MWRRcEJXMTVWOUVZem9Udlk3U2lGaXM3c1p4WDFRUG1FYkw3U3JT?=
 =?utf-8?B?Vi9pek5yU1VOdGtUVmlYa08rL3NRYk9vOU94V29tZ1U1bExTTDltREw5d2VL?=
 =?utf-8?B?Tm1YaEJxdUNiM1NrV2xmbXF1Q1JxRlpGMEw5MFNBM3lHN1JWcWtpRm1id0hS?=
 =?utf-8?B?d0hCZEpib3cyNkhLd0hJUHk5c205MDlYVi9PcXlqZFY5KzVPU2tVamtGVlZN?=
 =?utf-8?B?RFFobmZFb1M0akxVMXMwSFFGS0IrM3cvQThQUE81Q0JXeFZLZWhLMFFFQ1Y3?=
 =?utf-8?B?a2J2T21mKzFCTWU0dFdlQzVFS1hmbkFERU9wSEs0SHZZbStlbzZYSjJla0hP?=
 =?utf-8?B?SUV0UmFBd0l4TVE0MDBkTi9BdEhGbVlDNndCMHU3RVpRdVZUeTJERUdWL2w4?=
 =?utf-8?B?bElLUml3ZmxvUExjN250TjgraFI4R1ViWUk3RDZER2I3QnY0VGhnd3lDU2Y1?=
 =?utf-8?B?WEs4UGNKbFg2T0NhNGo1c3k1MzVCcWVhTnJrTkk5TGpjZ3VxRm4vZGM2OUk0?=
 =?utf-8?B?bkZnN1F0TXEvWi9SSDRKZlJZVEJtcVlXOGdGV1dROXk3N0E0WmhadHNYbWph?=
 =?utf-8?B?MWhvdmpQYW41eTJJNXVMZHFWWmpNYjdZL3pXMEpURDFCVjBaVnNXalBMbmtF?=
 =?utf-8?B?R250M05FazhWa0lSN05SN2toaHRYYU4zL0hTbW5CVjlocktmUlNPaGhQMThp?=
 =?utf-8?B?RkRDbk5sRG92eU95TUoya3VjcFNzVVJ3WlU0T2hidHdqcWxEOHplV1pnalhN?=
 =?utf-8?B?ejBZV0ZwTWpvZTlPckdQVzZuRDNrNFV2ZEphYjU3VityeWlwekJ1RHhCd3ZG?=
 =?utf-8?B?R3hhT05LeCtxYjQ1TjVJRklkQXMwSzkxZTFLTFFwSHRmQWlqUVBtSTlvMmY1?=
 =?utf-8?B?WHhsRmtGOGhxQVVFNzJQN0kzZ3VhOGc2R3BiS3FmMjlrTFFXRnNrS09ReG81?=
 =?utf-8?B?c204TVVzQWhacHZBejdUMEJvZHJ5TjdTU08rYUoxaVJBOVh0c1FMcWtBQlp4?=
 =?utf-8?B?cC9IMVRSdUhNRUF4QjNibHJnVzQ4cTRuZFlaNE5qMGw3UHVwcVpRWnhKb2Rm?=
 =?utf-8?B?MmczQVVYSUlRY0dmdEJ0VlA4UTZlWDRmRTQrRCtEQWN0YlpJaWNyUDNOZGh0?=
 =?utf-8?B?ZGU0bUJYeGVrVnRhQ2IxNjVqSFNybXpERHEzOUg4bVhxTUE1Z0tkTWF5VTJJ?=
 =?utf-8?B?VkRpODJRdmh5L3k3b0xBZnpFZmh6ZnNZeEZDWTgxZFJzZjVLUC81bXRQa1FN?=
 =?utf-8?B?MjJrQVJVVnpKSitvdE0wTmUxSytncFBOUE42T0kwV3MybEJkbHMvYlBXZjBF?=
 =?utf-8?B?elpGc0dhUDdjMDIyU1Z2RXpRRUZLVDZtWUcrdXlINlp3d05DVHRWOFhGSGE3?=
 =?utf-8?Q?h4vTyTyMz2mWXzD9RH/0HnkPA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0508c3-c003-4b21-e6f1-08dcb07b12da
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:36:22.5654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owJdMTQQxI6hdzfNiNDkvLkrwl7rhSylYCSLG4AUqMBSpCQGPZWsL4+nukVIVAH47vZ+OnFX/JptYQStiP4MpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374


On 29/07/2024 11:47, Russell King (Oracle) wrote:

...

>> Apologies for not following up before on this and now that is has been a
>> year I am not sure if it is even appropriate to dig this up as opposed to
>> starting a new thread completely.
>>
>> However, I want to resume this conversation because we have found that this
>> change does resolve a long-standing issue where we occasionally see our
>> ethernet controller fail to get an IP address.
>>
>> I understand that your objection to the above change is that (per Revanth's
>> feedback) this change assumes interface has the link. However, looking at
>> the aqr107_read_status() function where this change is made the function has
>> the following ...
>>
>> static int aqr107_read_status(struct phy_device *phydev)
>> {
>>          int val, ret;
>>
>>          ret = aqr_read_status(phydev);
>>          if (ret)
>>                  return ret;
>>
>>          if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
>>                  return 0;
>>
>>
>> So my understanding is that if we don't have the link, then the above test
>> will return before we attempt to poll the TX ready status. If that is the
>> case, then would the change being proposed be OK?
> 
> Here, phydev->link will be the _media_ side link. This is fine - if the
> media link is down, there's no point doing anything further. However,
> if the link is up, then we need the PHY to update phydev->interface
> _and_ report that the link was up (phydev->link is true).
> 
> When that happens, the layers above (e.g. phylib, phylink, MAC driver)
> then know that the _media_ side interface has come up, and they also
> know the parameters that were negotiated. They also know what interface
> mode the PHY is wanting to use.
> 
> At that point, the MAC driver can then reconfigure its PHY facing
> interface according to what the PHY is using. Until that point, there
> is a very real chance that the PHY <--> MAC connection will remain
> _down_.
> 
> The patch adds up to a _two_ _second_ wait for the PHY <--> MAC
> connection to come up before aqr107_read_status() will return. This
> is total nonsense - because waiting here means that the MAC won't
> get the notification of which interface mode the PHY is expecting
> to use, therefore the MAC won't configure its PHY facing hardware
> for that interface mode, and therefore the PHY <--> MAC connection
> will _not_ _come_ _up_.
> 
> You can not wait for the PHY <--> MAC connection to come up in the
> phylib read_status method. Ever.
> 
> This is non-negotiable because it is just totally wrong to do this
> and leads to pointless two second delays.


Thanks for the feedback! We will go away, review this and see if we can 
figure out a good/correct way to resolve our ethernet issue.

Jon

-- 
nvpublic

