Return-Path: <netdev+bounces-166371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C154EA35C0A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9716716AD72
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A602F257439;
	Fri, 14 Feb 2025 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a9yZ3Kzi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12615198D;
	Fri, 14 Feb 2025 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530746; cv=fail; b=QdMvni7jP8ni2ScRSSeWs4AH6wYdhGmKex655Mmg3SDS4cWe3JAKkgE0NOSFLYS6ZYN75AaDe7UgSHHUhcKUwy0bKjnlUtoBJNYpHn72KiaF43N0cdaJFF2dpiHn0ElUZaeLZfozd5ysOmugvubNQfK6yorw95qnUUR0ABUCIOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530746; c=relaxed/simple;
	bh=riMRuZomdXIoZiW+Oq5qddd2RyjreMCIW0aYb5uSaZU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jan0+l2x/ikZ2zsvTYAZrlShWMxXSKEDhczh1CpueMKP03ABG3aELDMeBuKmOvEb93ddou/UFGL7wv5AXM0CITe3KgejDUdcv4EvOHCYWTJw0H4mL1ibI/wbM+58IHe7mbznsGsB5FZ19eh5frWJx5f4hhlT67HLAIoiA9qZkNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a9yZ3Kzi; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjDTjrExpSuDl6LkYnIePWC+zPc/Bmbt977rA7IhlFWuepHxl8xsRNyCCElw5Vh8Xo8wBQQKDms1CTB6RWuh8Ut7aiz5SrQLiEMYbPD8gW5Zg95DA9FfKsp9uCydJGYGlcAjPZ9mmmU7lx5yYBMMOEYCGswJDNfuZakT45/uP9VTAdw0vWayK7nz562zV1d3Lm2JAtTNU736vS1rL9ppuMZgh2N/HEMXAfUPyFOtH4wzfBsVpPQTc6vz3pfZE2/J1sqcCDYanxqENHr9NX0n61ZkE1OCqkljZO69ryBiFJGbk++SbUIkwifnfl5r/6p7XxJF5yngk7jcYliXaimBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMb/WE3l6QZ2x6sQ1uFj9wxvEJ9f6/0Lq1zSg9iMPS4=;
 b=wmURKxHuvzuJmZ0q5uztuguI6pRzM5yXwUahAByfV9U+yA2S6I6RNric6/etZLMwVo1/1SoaskykzHzo1+GyVgYb3LtWPX8pVYwIV+QlauNCIxovsQcgea0E/6i7zs9RnvzjDsNKOGtrlsaywAE5l9kX2Tnbe6X2jyyOInXvBW9XqMILl6e5X2XTK/tavo9xBz+S2jWka3BfzQlFQHPaSDUKp+v3pnD5Yb4xwALljDIFLwnVM3Is/rubu00mYC4rGVEqQUVlkpGBipQdPmzyitwgHucpVdLaiqFxYud8zpqdN3f5CrM0sMH5/t3+hllJ3PBDtkCi1mQVZy6AjrsfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMb/WE3l6QZ2x6sQ1uFj9wxvEJ9f6/0Lq1zSg9iMPS4=;
 b=a9yZ3Kzi0ix2PAo421pWBfpANOLcPT+hgD8d3VWwnZfAVlO014m1k6Y1AbiOZC1RI7cYhuz3DUlCaVU20vRX2dr70LUO7LKG1RhrkWtWK+WKQYltnWkM3gcX5e3u2oMbVWjp4bCnDrOe2ywRwA/NkR8c7iEmJu+aJCcgVRGJaFcrvwi17lS9KY7vR/1paxidq8ssfCdxxSWFJDL+3v7WLq4GWpCjkyfLONmXBUXIlyWotCdoI5di2UsZaJc2RHzliOjwybPfekNbcXDDicv6PChvSheK2o2hfMKox5dgtuWoALlcI/IqSSnK8PQhWmEzN+Xrf7qFrVcNrK522d86Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 10:59:02 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 10:59:01 +0000
Message-ID: <05987b45-94b9-4744-a90d-9812cf3566d9@nvidia.com>
Date: Fri, 14 Feb 2025 10:58:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
 <E1tYAEG-0014QH-9O@rmk-PC.armlinux.org.uk>
 <6ab08068-7d70-4616-8e88-b6915cbf7b1d@nvidia.com>
 <Z63Zbaf_4Rt57sox@shell.armlinux.org.uk>
 <Z63e-aFlvKMfqNBj@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z63e-aFlvKMfqNBj@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0300.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd12dfa-d8da-4080-5a65-08dd4ce696f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rks5OHVhYmZXNkxTbGd6UHBPd1ljdlpwTWttMURRYzBHbnNHL0w2MFRCbHMr?=
 =?utf-8?B?cVpUK2RzMTV6WmJObU1PcTYydTNKVlRwZG5lcjNsN2I5eGZrY21oNGI3UWkx?=
 =?utf-8?B?YXlnWXZKZHVmNFJYWGZvMHdDc21EeEFhVDZnUlNvRmc4ZU45K1BBY2ROVDc5?=
 =?utf-8?B?QXZrZUU4VmZIdjA0akhkdWNEelRGYzlrN1FlRlBjQ0Rma0FJb2t6WUV6WXJo?=
 =?utf-8?B?VnI2SzBGbmVpTXYyK2ZJTVlJMUZhZWRMVHpneEV0QW5vZ0hxMXdCam1iNE5O?=
 =?utf-8?B?ZnNBNW1Lb1NLSHZYd0twNXQzWStvbU5zS2pUajhxNzRYV25rQlU1dVpTV1Yv?=
 =?utf-8?B?Y2N6N0tKZExPeVE1emVxeFhWUmZ5eXJxcmROZnpra01DTEFvUGYrUHB6OHl5?=
 =?utf-8?B?TW15TlQ2cHNSYnRIVEwwZHJ4K09lQVJqNUlscGFDamZUTEdvd1EvTzV1S3JH?=
 =?utf-8?B?TW96YkxGdEhXNTJSellnc3JzbTUyU3RvOEJCczBvdytXYkhRVjNoZ29SSVI3?=
 =?utf-8?B?UGVnYlZmY2tIRnErOEpRV09IYjFoelJGZW5ZR0pLRkFUbVZ0RFFNa2FXOWhu?=
 =?utf-8?B?amJrMjkxaVdDVjlZcnM0ZStCT2VMY01lZVMzZUJtcFFXL2tsMVBWTUZHdncy?=
 =?utf-8?B?cDdIWkNmZ1c1QjRYZjBma08veDFOQk9TQmNDRHQxeW5UOUhvakZaYm5HL0Rz?=
 =?utf-8?B?TFZlS3l1czFpTm1IRFdTY0VIeEZrVDl2KzRHL0hTWFFSNHpNV1Z6MkczdTZO?=
 =?utf-8?B?djVzY0pwdUllU1VpdEpZZUd1NVVWZk5Rc0EyMnI5RlVUS1lyaDEzcllyN2FC?=
 =?utf-8?B?S3Urd3Jpdmw5cFdwUnJZTVlFZE15UUdvTDNDTGl3dWx5dkg1KzkrVDJTaHBo?=
 =?utf-8?B?TytNSFlRL243TWhXb29JUE1weCtGOWFlQ2RqQzdIRDk1R3JDbTQzSFVIalBK?=
 =?utf-8?B?U0xHOHB1K2xKWUNtTHJXa2xBZFZsMlU4Y3d3dk1INlNUMlU5V1lSVDEwT0xo?=
 =?utf-8?B?T2xmWlU0SEUvUG9TbFdtS1RtRVdQNS9TN1BXbDlUcXFaOGxLL1J2L3VNZk5F?=
 =?utf-8?B?RWdLcTFwcXNacm53MllWd1NHYi9WVTE5UURtNTk0Z2ZFeWp4bVpLeWt1SU9C?=
 =?utf-8?B?SjFOM1poVkFkbzZwSTM5OU5BcnIzM0cvdTF1cy9hSEN3SWR6NkUvb2RpNlF5?=
 =?utf-8?B?Vkg2R0pxbTF4c3FuNk1jcWNVaU1YZWFYWXZEYkNGSnc1NkNoL1ZmZU1wdVdC?=
 =?utf-8?B?N3dDMFlTdDcxQ3dDRUsveS9lZTVLNXFKT0lDeGtneGZOSk1yYXhCSzBtMCtZ?=
 =?utf-8?B?aDRKVHFRS1Y3U0xQcnJGODlmTThqRTN0ZlloNDJzN2RPV0wrcStJT29NRSsr?=
 =?utf-8?B?TTdUQW85OUxIVWZGSlVDeUhwZ0pCeWt2cnphMjVaVlZRd1Qrc2ZhaWRwb3cr?=
 =?utf-8?B?SSttaU5XWkFOdk4vVUNWSFZFV0dvMldhUUUvU2x2c05WaGIzQzhud1ZxRU8v?=
 =?utf-8?B?Sy9MNjk0NlFkSnVyWXRxZ1NJVU9hcTdZL2haNGZudXllL0x0NExyMnB5S0tD?=
 =?utf-8?B?a2czUG8vV1NYNkpUUzh1eUo4ZjJRNnRqSlMwdDRuSGc4NmlMRlRwODVuT0V1?=
 =?utf-8?B?eGt3OTdoZm5JT0dBM0RlMFJGMzFvVW9sN0x3MG5BQWRFcGZ4R1BNVmRLaS82?=
 =?utf-8?B?M0hib3JHckthU3F6UVdsT3NXNFlEREF5ejRNSzBMajZ5ZmZqbGpHTmZ1VFRV?=
 =?utf-8?B?d3AvQVlkZGlhcFFOUUJzaTA3UmhKdlB4MU9XY3NtU1V6emtaNUNjL2srVUlN?=
 =?utf-8?B?WExPQlNNK3hEV0FUdmRYSDZSTk91SUFlZ1hZcHRWSERSSzdJeExnWUpOcWJj?=
 =?utf-8?Q?+1Bx94Tb4dV9x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTBiMmRiSjh0aFQ1aG54cWJCRmYrZ0F3YXNmelBlVG8rTUhLZmw0TEVqeld6?=
 =?utf-8?B?OFkvRTRLQVJsa0s4RlBmcUI5a05mbkZIREc1ZU5NSEhKalJoN01ZT0ViR3dz?=
 =?utf-8?B?RVZxUFdJU2sxM21qUkpyTnd2RkFLdTg3YXU2WER1MzlJVG1hOW02MW9yd2x4?=
 =?utf-8?B?WHpUUG5ySUdJMVN6RUVQUlJ1MTNpNFFKQlVndG93ODVVaXlOdjV4Z3BVTTVw?=
 =?utf-8?B?V29CZ3ZnN3NnWCtLK3E5L29rZUZ3QU93YVJIeFF0aC91d3E1TEhKR0xxTmxJ?=
 =?utf-8?B?SkpJcngydThZK0VadE1BRFZvUzdOalVseW1xTFRiL1R4RVRTZG9yM3BUblpq?=
 =?utf-8?B?S2hJRGJ3d3dVdUN6YjQwdkRBU1YwVWtJNVFuOHdTdGFCdW1JaUVSY3hZejdw?=
 =?utf-8?B?WkpzVUMzN1lwRmhrdEFKZ0xtbVMzZmNsRkI3M0dzdWdBTDArUkkxVDMrSGNl?=
 =?utf-8?B?ei94dHpDTVM0NjduR3F2b0c2b01sRDV4NjlPN0Q4dnkvbzZEMUZlYVcxNDIw?=
 =?utf-8?B?Y0t3KzZ0RVBibGxic29LdzQxNTFuYTNaK0g3bFhIaWZMdk5BdEV0TGlNZWNC?=
 =?utf-8?B?ektUZWNHQ1hlelFlWVFRNXhEcUdHY0VJWFN2a3RxVGNxNkJ3bUtBeFdkblU2?=
 =?utf-8?B?S3ZkSDRva2Ivb2h2TDFPdGthVmVpa3VsbHlLeDgvY3FVRW1QRXNvNUN0bjBR?=
 =?utf-8?B?ZGgwb0w0bWRsM0JDczc3dllrQ0NjYTdYQjhCeUZ4L1VSN3JNQWxHb0YvaHh5?=
 =?utf-8?B?eWVsSFVLV3I1K1R6bi9pYmN1TjZvT3J4RFhtdkh2bW9XNitOTjN6YXBhMGpO?=
 =?utf-8?B?Z04wUVFhU2drTkNuT3NvY1p2cndvaTlQZ3ZBN3JKa2Vja25zajBOTk1WT0oy?=
 =?utf-8?B?bUlzdUZvL2Q5SVM1WHMwTm1NN2I5MEJxQnlVeUVBL29mQVVRUjFJWGJTLzBu?=
 =?utf-8?B?MHpRUFRHTndIcXcwQS9KSjVvOG5HQXp6elJKMGJjUHIyaEdWdFBEcW5pSEVj?=
 =?utf-8?B?WHJoZHBYQ1FWZ0ZMYWppOTNzd2NnaXNHZWhaT2ludmY3ZGhoLzd6U01jVXhD?=
 =?utf-8?B?WnVnOER6ZFJNRkUzL3prZk1KVXQ4dC83KzBsaWxBUlllOE0zTUlqdGdBVmtl?=
 =?utf-8?B?ZHoxUFBKRVhUZWVLMW1mZFRvSW5sd1l4YkpaNTUxSE4ya0RTODhjQlBJeUto?=
 =?utf-8?B?SWswOUJVcWNBQ2h3MHg5L2E0RlYwRmcxYk05WkdZVTBuQkg4RXUvWFRuTUZx?=
 =?utf-8?B?NTNneGp3OWF3SHUwc1lSUGlnVlJ6QjJWSm1qd2pVY2g2MHMrbnU5MnBHNnlO?=
 =?utf-8?B?Y2JnYXNLUFhua0pKNWt4S0JOVVc0Rnp6NURUVm9rd1ova0JjRkFzWmZiNFNl?=
 =?utf-8?B?MnUvNDV6cEZqMndJRjZDQzU0THpCQ3YwVlNVOTRJRmhGaTlGcXpRRTV2ZU1C?=
 =?utf-8?B?YWZncEJhemFnazNqSlNTTFZjYWR5WlhBVG9GWEg0WkhqSitNcFRITkw0dHRY?=
 =?utf-8?B?K3o3VlM3OWJnYXFYYi9Gby9FZWRNRTJQOFpxWGxZMnVoTjVnRms2UDZoaW5t?=
 =?utf-8?B?N2dUejkzRm5UT0pqanlyMkVXVGsrTnlwUlNYcDlnR2lBWG5pUHg5VFpTUDds?=
 =?utf-8?B?WXBlZXlGOXl6aVpSdzRVbXFzeThnTHdSSCt5QkZUQjZ5elRNSk9FYXVEd1lw?=
 =?utf-8?B?eG1qTG5Qb0VTQ3UyeFdzVnZJR01ISVV6S1k4VENFWU5WY0swRy8wWjhkL2hi?=
 =?utf-8?B?T2o2YkhUb0RwbUlpcUxKdkZaR1dOeE1iZUxJM0h6Y1ZLaFZvNEdRUHhDdmFT?=
 =?utf-8?B?WVlMYitKTHRGM0M2b3dLaFMxamN1MFQxZGJOZmpQMlkwbnpXU21SUzBPZzU4?=
 =?utf-8?B?YmprUWlZdldCV29GejV2NURBUjFNTGljN25Ma2w1RWQ4T3B3NDVVOU1Dcnhw?=
 =?utf-8?B?ZXdNN21DVktWckw5R2ZYU0IzUGRlaG1WRkZSRnVabk13RWwya0kyOG1ka00w?=
 =?utf-8?B?aTJSR0t2OTZCQ3k4eTJ6TWNRL1duNy9wY1R0a3N2aExYTUtuV0xqOUhUY0Ey?=
 =?utf-8?B?aTJqVE9reVR4U1FPdERSZ0VEV2hxZDRTTXhRZjU3a0hWWCtQZysweUlRdUlr?=
 =?utf-8?B?bW41ZTZCSVZuNXhpWHprYnBxYWpJT2YyNzByQ1p5K2gwOHVML2VmSVdtSGlj?=
 =?utf-8?B?T2xsMFVVQTRIeGM2NWtlNlc4MEVFbnAxNFlISnhKMWx3dGZvM3M0cGYxWExy?=
 =?utf-8?B?T3AvUDJRdlpCZVQzb1FldzdLZ0pBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd12dfa-d8da-4080-5a65-08dd4ce696f5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 10:59:01.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8OufsAl2d2RTgELJp5sQNoWn+e94UMvqx3HJeLNjzhuKRs9zdULmotLTxUm2DxeQuxxWHfVegDjy6Zpz0Ytmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131


On 13/02/2025 12:00, Russell King (Oracle) wrote:

...

>>> I have been tracking down a suspend regression on Tegra186 and bisect is
>>> pointing to this change. If I revert this on top of v6.14-rc2 then
>>> suspend is working again. This is observed on the Jetson TX2 board
>>> (specifically tegra186-p2771-0000.dts).
>>
>> Thanks for the report.
>>
>>> This device is using NFS for testing. So it appears that for this board
>>> networking does not restart and the board hangs. Looking at the logs I
>>> do see this on resume ...
>>>
>>> [   64.129079] dwc-eth-dwmac 2490000.ethernet: Failed to reset the dma
>>> [   64.133125] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
>>>
>>> My first thought was if 'dma_cap.eee' is not supported for this device,
>>> but from what I can see it is and 'dma_cap.eee' is true. Here are some
>>> more details on this device regarding the ethernet controller.
>>
>> Could you see whether disabling EEE through ethtool (maybe first try
>> turning tx-lpi off before using the "eee off") to see whether that
>> makes any difference please?
> 
> One thing that I'm wondering is - old code used to do:
> 
> -             phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
> -                                          STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
> 
> The new code sets:
> 
> +     if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI))
> +             priv->phylink_config.eee_rx_clk_stop_enable = true;
> 
> which does the same thing in phylink - phylink_bringup_phy() will call
> phy_eee_rx_clock_stop() when the PHY is attahed. So this happens at a
> different time.
> 
> We know that stmmac_reset() can fail when the PHY receive clock is
> stopped - at least with some cores.
> 
> So, I'm wondering whether I've inadvertently fixed another bug in stmmac
> which has uncovered a different bug - maybe the PHY clock must never be
> stopped even in LPI - or maybe we need to have a way of temporarily
> disabling the PHY's clock-stop ability during stmmac_reset().
> 
> In addition to what I asked previously, could you also intrument
> phy_eee_rx_clock_stop() and test before/after this patch to see
> (a) whether it gets called at all before this patch and (b) confirm
> the enable/disable state before and after.


Thanks for the feedback. So ...

1. I can confirm that suspend works if I disable EEE via ethtool
2. Prior to this change I do see phy_eee_rx_clock_stop being called
    to enable the clock resuming from suspend, but after this change
    it is not.

Prior to this change I see (note the prints around 389-392 are when
we resume from suspend) ...

[    4.654454] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 0
[    4.723123] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
[    7.629652] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
[  389.086185] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
[  392.863744] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1

After this change I see ...

[    4.644614] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
[    4.679224] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
[  191.219828] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode

So yes definitely related to the PHY clock.

Jon

-- 
nvpublic


