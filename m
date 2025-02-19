Return-Path: <netdev+bounces-167754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76784A3C0FA
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC35B7A5DCB
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E821C1E98FC;
	Wed, 19 Feb 2025 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BPgsn+nU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358345C14;
	Wed, 19 Feb 2025 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973706; cv=fail; b=PJKNTqQXsKSsLpzssTztg/x9jqa6SMgG/1ePBq9nYiRTgHNNSZUR1NyTJW4OXPUxHOjKAKztAhzWw6SPItk8yWTFTX+hBPIKRxlwGfxQOyUsxjooYyZi9ezw1OuSSm2gs9SxnGkB/YRgaUUrycT4Kg4ZWLATu1XwRrdUMKisz+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973706; c=relaxed/simple;
	bh=cgRmDo5YiwI9oH6ASmzuxsQVjna9aFaQq9t433FrL3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r5QMm5+3yHXsEvAZ9dY+Cso51HrVeVEhQEYJ5CpKQRkVwRDwVWyaPmZQu9Y7dv261dmhNiOVOmvAKnYAG7YyIzbXbYsq0Rsfh5X3I/gZEgMZDzKZzAbWL6hcoNhTL/HXX8klSTqqMDrvQhCvvR2M7+jPwEko6lVRXn7Fn3Fozfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BPgsn+nU; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDlwGEyqUEAdZXd1xa+8aaYZ1nRnuAD2IhZry7+mFJPzYxs4T+hO4pGOWfb+JJopAoDrRf5IdO67MLUPv920G5ViQG8k3ssd909z6C8jAQrCEDYJIPCw3sdnz9PCFyNJy6v7Zhxn5o42Mtsq348mdM3WTUbeVXuDdv6uWfHodN5AEkVE7/bLGEQz/mZMxlZ0O59uESdZAwtnBLxoCbWm5w08G8waKto+qe4pOiwgyPUyCzG1wjJ9MSGWCFmgNoRMoRiyHnrZFNGK1AspQtMEbaRs8/vgjH1sxWwEv1S5dg2d12BFKhTVcktMxZUqO+aTv1bYgvJeTpuZqZCx5c00/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZFV2UzXI2XgqRoc8b2qbBlY7/ietxvDByN9QFuqe9E=;
 b=loqT9vOESFwQDtBEsA+f3rS3sflSf3PzxB+U5Am7Q/M0Ey+BqAxQ6wPGXt2RQ7YUL+uTr4qAjGUOx8r8RVeZmFWSrYdS2XyTXBKG79tQqVs+dnswru+zOzelV1ELBMGEFav93XqmdTZCSs+u2v8z24mQXlaUnIPEtxH8riUFEvTO+EPhIjFNRdsGqrBlPptRHubnBq+OsOEMEytnD+HZldUe6k68CNv+x6hv/VQvMJR1s47xCQJg5DyFdgiS6pzRqPSe31N5OzuzS3+s/3aDMwyf/gFccko0aFXPu6ZFBAAqHkdB3d0wcqy6dlRdvzWwnZKIk0g/lyivWUkAWW4YNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZFV2UzXI2XgqRoc8b2qbBlY7/ietxvDByN9QFuqe9E=;
 b=BPgsn+nUo0JjG9ArUcwfWG+gfycmlnklCJ8kgDRhQTG1OvDVSpaeye+72uprHtktC/xLLdKGxHeQ2g1V790aprhUiFRlfm4gvAidjvpoYyWhSqpdOpIBkuCZGhrtBK6l/wZOUg1g91siEbafE3V8bqxEx1CoaF6TF4z1IYWGpBE5os5Q57POu9zbiA6EzvenbQJ0CYqJyWBuiWtntwA0WCSoPOLKojlHXykf9TKEy/e5MSVqwYijO3LovFXVf8HxpAA9KnYtkmZktI2Xz/g3p+7H1rfxfi2E7cxCq7CdGFdHKUdTw7cTq9y6uGKmebMyxtWgWUztvWfbE8SBQHgcAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.23; Wed, 19 Feb
 2025 14:01:41 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:01:41 +0000
Message-ID: <86fae995-1700-420b-8d84-33ab1e1f6353@nvidia.com>
Date: Wed, 19 Feb 2025 14:01:34 +0000
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
 <05987b45-94b9-4744-a90d-9812cf3566d9@nvidia.com>
 <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::16) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 605d0f40-e35d-4111-edb7-08dd50edef8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzBKSUNhRFkrK0lCckFDS1ZvWmRiU2tsVGZRb24veE90dFFzKzNHMkhWbzJE?=
 =?utf-8?B?ZW51TW5sT1BnWFhCbzNrd1dwaHlKM3FaU1BOSEhuOHplV0JsQzQ2QnI0MXVJ?=
 =?utf-8?B?eGFxTUMyWHliL3M3YlE5dUh6Zk5wa3BzQjFYVVZuaWY5YnE2NXEvRVRnN1cw?=
 =?utf-8?B?QmljSHNsYnQ3c04vSUV5ckNYV0FZTkNiTUVJekdvQlhSL2pDeUFnamRvaW5N?=
 =?utf-8?B?anJrWVNLMDUyRTRBc2lRQk1IU1V3K0E5SjVjNDRBVFBSTGJXRzd5UWtNRHQr?=
 =?utf-8?B?aGdBQWFnRWl4OWJ3a1VzcWtXbTUzbDRMOThGQ3ZrWUdDV2trVXRCajhsRjZI?=
 =?utf-8?B?Z0t0YnVoWkdyTk4zY3Yyd05pSGdLNWtLbTZjZ1k1RW5GYXJ6R05WTTZ1Q2Yr?=
 =?utf-8?B?QXZBTTd1eW11TlJ6MnZYd3RUMzYxaS85U2p0OEhYem5IUUN5SG5wOS9oc1ky?=
 =?utf-8?B?OFd0TlVnenZkY2pjWTRHcUFQNDJpeGFwNjdhZGZkUWJLemdJekdKRmE4ZnpF?=
 =?utf-8?B?V0ZtMWFsVXBGc3J5NU05YkVFd2ZYdHhEdWJwcytqdTVCdHBGRFEyOURkVXMw?=
 =?utf-8?B?VndlQmR1MWdOVkxpa3ZxSkJPQzE5TzdxM2ZGS1NkMXVKNzJmbk9UZ05BNDll?=
 =?utf-8?B?aytEVEY5bWpqSEd4d0NSa0hGMkZ0T3VJbnhuaUUzdDRLNlplbVBweXRWUHV2?=
 =?utf-8?B?UHZMejJNYkRaSXRmNGtwcjdUVkV1ZWlMOWs3aHdMZUMxRjVBRS95ZEZDUm5G?=
 =?utf-8?B?WHpOQlhNNTNKRTNXTXdxbStGYVRBZERib1JkMkd4a1RWdjVrNWQ2T2xYdXlp?=
 =?utf-8?B?QzdQRXQ5UVE4ak9ncGxQVjRVcWtBcDh4Qk9UZm9GVVk2ZG92SVp0QkFXYVlT?=
 =?utf-8?B?ZzZJUEZpOUtKOTBTNWVtMFNKNzRScFVLQ2JER2FrNFVtcEpxMWovTlRwUllp?=
 =?utf-8?B?Zyt5UFovOGhGdGFBcmRoNE9iY2tWZlBCWHNkNUdzYVB3YzBKa2ZsYTRPL2dK?=
 =?utf-8?B?MXRLQ2NGV3B2d2V4a0NXV2E4QVRFdGoxZHd0LzJ6ZEZvTGNrVDVUMWhCKzNX?=
 =?utf-8?B?U3hnOEN6aDFQWTBTUEdlUis3dDhQWi9UMTNYUVlVM2ZvV3M2M2lmUkFvSytH?=
 =?utf-8?B?ZngwNjRsZ2dXc2lrVG5LTHRFSDFFWFVGa2c5NXgwelcwSFVhdE1LWGF0RlJG?=
 =?utf-8?B?K3U3dkxGRjhZV2kyWElwaTBXbk9rZlpLcUtOME4rOU53ZW96WjM4WVMrVFor?=
 =?utf-8?B?RDNqZkZmK0U3Y1JvZk9BTXRHazJDK0xsUSs2QVIxZ3VERGxrbkJHT2w4dktw?=
 =?utf-8?B?Nk4wUXhDNjNNQzJsSzJ3aHdXM1pmOUYwL2kxQjNBR3FsQXkxcEdtWkhMeDdi?=
 =?utf-8?B?MTJ1cHk3bUozamNtL2pWbi9Sdkt3cHlzTytzZm5mQTkyeFBlTjBMZDlPZy9X?=
 =?utf-8?B?d2lIaStGODQ2WmRhWG9JeFpncVlDTUxlV2hBT2xES3YyK0pvR2FMbzI2S0NL?=
 =?utf-8?B?RjBaL3FyTnczWW54K2VKc2g2TGxzQ1dXK0Zudm1JOXZQc3YrU0hIS2ZlL3VC?=
 =?utf-8?B?YklxcGNWM3hNV0V5NUhYVU1lTEwyckpHU09pZ2RSS0tTM094Z3ViWDZKZGJ2?=
 =?utf-8?B?VjhhNzlWQS9meXVxNTRCazRoRmRPc1ZyZEczYmJBazBsTmdRV3Y1RVk5M3V6?=
 =?utf-8?B?UHplZWdoTi8vT3BwMjFiVjhCQWp1cEpvdU1abVlLSUdFTCtvWGJ1RHhRSVFH?=
 =?utf-8?B?TjR2bDJ1djcxQU4vYXdFNEJXUzF2MXUvcURaZG5rOFVLWFdXaTNDS2RLWVpq?=
 =?utf-8?B?cUNkMDFrSEJVZzBlNHVjMGJWeTdjeWduenV2VCtReWk2V0pQUnpnNXZBR25z?=
 =?utf-8?Q?p8WiMHWQhSUSN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0dkU1RpUVdPR0tlelJxaVRndHVlT2xsM21SenIvME5abFVYcVB0SEhHV1BK?=
 =?utf-8?B?S3p0VFFnaUJIQldvc0FTOVR4cy85VVBJbTZSQlhrLzFRbjgzQ3AyUmdiN1pn?=
 =?utf-8?B?RGh3eHF2bjdTdHpWL0RybjdrMklzaElSK3B6R3hiK0VyZ0Q1L1JYYm5idW94?=
 =?utf-8?B?Y044Q2lTbjN6TFMxZ05iZ04zblpsOEtwRmxsaXk2MWZxenZnVTNiem40RVcy?=
 =?utf-8?B?SGU4MVhwQ1docGhWMVpkN2xIS2VmQzV3dGV4S1hQSXpSRnBBbFhGR2t0M2tG?=
 =?utf-8?B?WmRpVDhYbzN0bnJvclJaZXp3TzFlTnF0WTZMSDg2cnVvMFhJa2Jtd3ZXTEVj?=
 =?utf-8?B?emE5Q0FTY0laeElhbU5pTXE5YklpYjhuT2JxVGFRbXlvZk5kUnl0SkpwVU1Q?=
 =?utf-8?B?QUM2WmdlMVdMVFBlRlBJeHpOdjlISndmMTJUWjhCYmlVZnd2UWZtRXF2Q3NX?=
 =?utf-8?B?VjBSN3B3dFhlK2JUMTc5OWxDa0ZvN2d4V0F6T1hSeERobXluOEo4U2RNNjBV?=
 =?utf-8?B?c2tnOUhHTFVENzB0S0EwN2xPY2hId0h2S0RlM1NDZS9uMmxGNGUvM3dSdmU2?=
 =?utf-8?B?cSt5NmhFN1hNUDZLcDBTTjZqNEhFSUJadVplWTZVc2FqeWhJVlJGMzVxeWxT?=
 =?utf-8?B?MkF0dXZYR2xvQ293ZGhOYnpPd1FsOG1EelR6YlFhZEU4MTB5RVlqcHdnOXRQ?=
 =?utf-8?B?bGFqZ2ZybndEVzl6SFg1UzZjUmpoMnExU08rV1hMTHUxcXk3ZzRQQmJJSnRM?=
 =?utf-8?B?eVVBdkdUaFlLZGg3Y21yL0VRZTBCRlR4TE01dzQ1MEFCVDBnQTBidU0xNjkr?=
 =?utf-8?B?dUcxWHpxM2JhVFlxZnBSYlREVisyaHE2cTBpYzNtbEdUelZSQk15V3FzYXdv?=
 =?utf-8?B?MFhMMGZBUWlVVldtTjJESEdRNWhsKzRQOXBxQXBaKzBoOEp5RC9iQlJmVHdo?=
 =?utf-8?B?VGhFUXJHdnRCbFg5em52Ym0rN3Nta1ozN3NvandQQzMxZitJdUZHM1dlMC9z?=
 =?utf-8?B?WUgrVmMxOWFaVmdBbldKb3NyYmk1RGJHTjNCMnFTakk5L0x4TThhVUd5emZQ?=
 =?utf-8?B?a0hKeXo0aTc3Y0Yya3g3L2cwc3FTNzIwQlJCKzBRQTFheldWd0lIeGZnUW9J?=
 =?utf-8?B?Y0JZNlh0clNNcEQ2YmJ6WTFCN09VMnFQc21iSGg0SlJTeCsxUlZ2VTVkZjEy?=
 =?utf-8?B?UHpIK0ZQR0lyaUlQWHZGOWFqT2NscklXN3lzNnhtOXlONmZuNG9RYVB0NWFE?=
 =?utf-8?B?c3JlNnc1MnBMRlBwdjZzeURNZjRuZFZzNU1UOCtuTlFMVlcySEI1QzVrcVND?=
 =?utf-8?B?Y09tQmNONjZuUm1DT3ZEQVJjcm5VNHZieUxOZ0FwQWdFaTNLZEpIK2N1L0dX?=
 =?utf-8?B?UHU3UkJGZ004NERYSGJ5SWRmblMwLy8yRWh0VVZCWTMwcnZabWR6Z2Y4MHN5?=
 =?utf-8?B?NmRSOXREQTRLRkI4ZW5xYkJQa0dtcHFORDJRRTZzR0RUVVczZFRFelFJVyt3?=
 =?utf-8?B?eFJpWEszbjRNbFlZL2FIQ1hZMGVMTWxydjFBZ2VGQmFURlEvRUdaK3V2SC9J?=
 =?utf-8?B?THBWQncwV3VUTTJ4dFJQb21kdTZnekNBYWV6a3JhbVlVMjJEUDJpbDJSbi9G?=
 =?utf-8?B?dk1ZMDByOGgzVWRDQmh0K3ZhOWNKZ2NLVFVYSUVoblhPdUcxZ3JJZUZBYzZ5?=
 =?utf-8?B?cVJEYzR0SVFIbUdkZmlZTEFidy9VTS81TElodFJxVWN6ZGhJNUd6Z1JybmV5?=
 =?utf-8?B?a0tpNnJySC9DMUdBT2ZjYStNU2FoRDhBTDIxZVZ4VmE4VENjMmZ5S2dzSGt4?=
 =?utf-8?B?Q082OXpEaVlFMUhsTlptWDdFUXFhZFZGUzBUb0lvUnRzaVJMdlNnSnlJT2VM?=
 =?utf-8?B?WHBDVURoZEtzSDRIbkZCVDdrTnZEb2JYSWpXQnB6V3pxWHpySGdTaEJrdmQ4?=
 =?utf-8?B?RmZGN21wMFpxS2JNZHA3RHFKeFU1aHBRTGpSd2d3SHRjOU51MmQ0S2E0VWtE?=
 =?utf-8?B?M2FaRkdYY29nL0ZGUUtielI0eERHd1RYRjh2OXg1dHNPU29rUVBHRTllcmM1?=
 =?utf-8?B?QWRTRHdXb05MRDhLVmZBbDRYdnZwV2tWRXlJM1oxUFhHUm9HRWJxT1RqZmpJ?=
 =?utf-8?Q?EkiGKki+oF+3sp9y2TYeLdT17?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605d0f40-e35d-4111-edb7-08dd50edef8b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:01:41.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LJNCoaO4UW3TKvigSXeo5zfu2MzS8gdBEHYsa9Ox1sAbh5fPJB/kWGyDHR/wrla1H0vzeZqk+Eb8U17QS0opg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864


On 14/02/2025 11:21, Russell King (Oracle) wrote:
> On Fri, Feb 14, 2025 at 10:58:55AM +0000, Jon Hunter wrote:
>> Thanks for the feedback. So ...
>>
>> 1. I can confirm that suspend works if I disable EEE via ethtool
>> 2. Prior to this change I do see phy_eee_rx_clock_stop being called
>>     to enable the clock resuming from suspend, but after this change
>>     it is not.
>>
>> Prior to this change I see (note the prints around 389-392 are when
>> we resume from suspend) ...
>>
>> [    4.654454] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 0
> 
> This is a bug in phylink - it shouldn't have been calling
> phy_eee_rx_clock_stop() where a MAC doesn't support phylink managed EEE.
> 
>> [    4.723123] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
>> [    7.629652] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
> 
> Presumably, this is when the link comes up before suspend, so the PHY
> has been configured to allow the RX clock to be stopped prior to suspend
> 
>> [  389.086185] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
>> [  392.863744] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
> 
> Presumably, as this is after resume, this is again when the link comes
> up (that's the only time that stmmac calls phy_eee_rx_clock_stop().)
> 
>> After this change I see ...
>>
>> [    4.644614] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
>> [    4.679224] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
>> [  191.219828] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
> 
> To me, this looks no different - the PHY was configured for clock stop
> before suspending in both cases.
> 
> However, something else to verify with the old code - after boot and the
> link comes up (so you get the second phy_eee_rx_clock_stop() at 7s),
> try unplugging the link and re-plugging it. Then try suspending.

I still need to try this but I am still not back to the office to get to this.
  > The point of this test is to verify whether the PHY ignores changes to
> the RX clock stop configuration while the link is up.
> 
> 
> 
> The next stage is to instrument dwmac4_set_eee_mode(),
> dwmac4_reset_eee_mode() and dwmac4_set_eee_lpi_entry_timer() to print
> the final register values in each function vs dwmac4_set_lpi_mode() in
> the new code. Also, I think instrumenting stmmac_common_interrupt() to
> print a message when we get either CORE_IRQ_TX_PATH_IN_LPI_MODE or
> CORE_IRQ_TX_PATH_EXIT_LPI_MODE indicating a change in LPI state would
> be a good idea.
> 
> I'd like to see how this all ties up with suspend, resume, link up
> and down events, so please don't trim the log so much.

I have been testing on top of v6.14-rc2 which does not have
dwmac4_set_lpi_mode(). However, instrumenting the other functions,
for a bad case I see ...

[  477.494226] PM: suspend entry (deep)
[  477.501869] Filesystems sync: 0.006 seconds
[  477.504518] Freezing user space processes
[  477.509067] Freezing user space processes completed (elapsed 0.001 seconds)
[  477.514770] OOM killer disabled.
[  477.517940] Freezing remaining freezable tasks
[  477.523449] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  477.566870] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
[  477.586423] dwc-eth-dwmac 2490000.ethernet eth0: disable EEE
[  477.592052] dwmac4_set_eee_lpi_entry_timer: entered
[  477.596997] dwmac4_set_eee_lpi_entry_timer: GMAC4_LPI_CTRL_STATUS 0x0
[  477.680193] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
[  477.723771] Disabling non-boot CPUs ...
[  477.726898] psci: CPU5 killed (polled 0 ms)
[  477.731364] psci: CPU4 killed (polled 0 ms)
[  477.735439] psci: CPU3 killed (polled 0 ms)
[  477.740198] psci: CPU2 killed (polled 0 ms)
[  477.744220] psci: CPU1 killed (polled 0 ms)
[  477.748546] Enabling non-boot CPUs ...
[  477.751996] Detected PIPT I-cache on CPU1
[  477.754800] CPU features: SANITY CHECK: Unexpected variation in SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU1: 0x0000009444c004
[  477.766211] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU1: 0x00000010305116
[  477.778379] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU1: 0x00000003001066
[  477.790231] CPU1: Booted secondary processor 0x0000000000 [0x4e0f0030]
[  477.797726] CPU1 is up
[  477.799388] Detected PIPT I-cache on CPU2
[  477.802952] CPU features: SANITY CHECK: Unexpected variation in SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU2: 0x0000009444c004
[  477.814415] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU2: 0x00000010305116
[  477.826537] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU2: 0x00000003001066
[  477.838440] CPU2: Booted secondary processor 0x0000000001 [0x4e0f0030]
[  477.845865] CPU2 is up
[  477.847325] Detected PIPT I-cache on CPU3
[  477.851136] CPU3: Booted secondary processor 0x0000000101 [0x411fd073]
[  477.857958] CPU3 is up
[  477.860108] Detected PIPT I-cache on CPU4
[  477.863949] CPU4: Booted secondary processor 0x0000000102 [0x411fd073]
[  477.870714] CPU4 is up
[  477.872933] Detected PIPT I-cache on CPU5
[  477.876778] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
[  477.883556] CPU5 is up
[  477.985628] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
[  477.993771] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_mac_enable_tx_lpi: tx_lpi_timer 1000000
[  478.171396] dwmac4: Master AXI performs any burst length
[  478.174480] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features support found
[  478.181934] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[  478.202977] dwmac4_set_eee_lpi_entry_timer: entered
[  478.207918] dwmac4_set_eee_lpi_entry_timer: GMAC4_LPI_CTRL_STATUS 0xf4240
[  478.287646] dwc-eth-dwmac 2490000.ethernet eth0: Energy-Efficient Ethernet initialized
[  478.295538] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[  478.372819] usb-conn-gpio 3520000.padctl:ports:usb2-0:connector: repeated role: device
[  478.382118] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
[  478.410458] OOM killer enabled.
[  478.411350] Restarting tasks ... done.
[  478.415459] VDDIO_SDMMC3_AP: voltage operation not allowed
[  478.417763] random: crng reseeded on system resumption
[  478.425747] PM: suspend exit
[  478.474698] VDDIO_SDMMC3_AP: voltage operation not allowed
[  478.533428] VDDIO_SDMMC3_AP: voltage operation not allowed
[  478.600368] VDDIO_SDMMC3_AP: voltage operation not allowed


For a good case I see ...

[   28.548472] PM: suspend entry (deep)
[   28.560503] Filesystems sync: 0.010 seconds
[   28.563622] Freezing user space processes
[   28.567838] Freezing user space processes completed (elapsed 0.001 seconds)
[   28.573380] OOM killer disabled.
[   28.576563] Freezing remaining freezable tasks
[   28.582100] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   28.627180] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
[   28.646770] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
[   28.690432] Disabling non-boot CPUs ...
[   28.693397] psci: CPU5 killed (polled 4 ms)
[   28.697401] psci: CPU4 killed (polled 4 ms)
[   28.702649] psci: CPU3 killed (polled 0 ms)
[   28.707369] psci: CPU2 killed (polled 0 ms)
[   28.711482] psci: CPU1 killed (polled 0 ms)
[   28.970011] Enabling non-boot CPUs ...
[   28.974751] Detected PIPT I-cache on CPU1
[   28.977635] CPU features: SANITY CHECK: Unexpected variation in SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU1: 0x0000009444c004
[   28.989014] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU1: 0x00000010305116
[   29.001163] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU1: 0x00000003001066
[   29.013015] CPU1: Booted secondary processor 0x0000000000 [0x4e0f0030]
[   29.020526] CPU1 is up
[   29.022168] Detected PIPT I-cache on CPU2
[   29.025747] CPU features: SANITY CHECK: Unexpected variation in SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU2: 0x0000009444c004
[   29.037182] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU2: 0x00000010305116
[   29.049328] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU2: 0x00000003001066
[   29.061196] CPU2: Booted secondary processor 0x0000000001 [0x4e0f0030]
[   29.068779] CPU2 is up
[   29.070095] Detected PIPT I-cache on CPU3
[   29.073916] CPU3: Booted secondary processor 0x0000000101 [0x411fd073]
[   29.080749] CPU3 is up
[   29.082898] Detected PIPT I-cache on CPU4
[   29.086729] CPU4: Booted secondary processor 0x0000000102 [0x411fd073]
[   29.093496] CPU4 is up
[   29.095715] Detected PIPT I-cache on CPU5
[   29.099556] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
[   29.106351] CPU5 is up
[   29.218549] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
[   29.234190] dwmac4: Master AXI performs any burst length
[   29.237263] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features support found
[   29.244732] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[   29.267679] usb-conn-gpio 3520000.padctl:ports:usb2-0:connector: repeated role: device
[   29.270504] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
[   29.306091] OOM killer enabled.
[   29.306981] Restarting tasks ... done.
[   29.311423] VDDIO_SDMMC3_AP: voltage operation not allowed
[   29.314095] random: crng reseeded on system resumption
[   29.321404] PM: suspend exit
[   29.370286] VDDIO_SDMMC3_AP: voltage operation not allowed
[   29.429655] VDDIO_SDMMC3_AP: voltage operation not allowed
[   29.496567] VDDIO_SDMMC3_AP: voltage operation not allowed
[   32.968855] Broadcom BCM89610 stmmac-0:00: phy_eee_rx_clock_stop: clk_stop_enable 1
[   32.974779] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_mac_link_up: tx_lpi_timer 1000000
[   32.988755] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx


The more I have been testing, the more I feel that this is timing
related. In good cases, I see the MAC link coming up well after the
PHY. Even with your change I did see suspend work on occassion and
when it does I see ...

[   79.775977] dwc-eth-dwmac 2490000.ethernet eth0: configuring for phy/rgmii link mode
[   79.784196] dwmac4: Master AXI performs any burst length
[   79.787280] dwc-eth-dwmac 2490000.ethernet eth0: No Safety Features support found
[   79.794736] dwc-eth-dwmac 2490000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[   79.816642] usb-conn-gpio 3520000.padctl:ports:usb2-0:connector: repeated role: device
[   79.820437] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
[   79.854481] OOM killer enabled.
[   79.855372] Restarting tasks ... done.
[   79.859460] VDDIO_SDMMC3_AP: voltage operation not allowed
[   79.861297] random: crng reseeded on system resumption
[   79.869773] PM: suspend exit
[   79.914909] VDDIO_SDMMC3_AP: voltage operation not allowed
[   79.974322] VDDIO_SDMMC3_AP: voltage operation not allowed
[   80.041236] VDDIO_SDMMC3_AP: voltage operation not allowed
[   83.547730] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_mac_enable_tx_lpi: tx_lpi_timer 1000000
[   83.566859] dwmac4_set_eee_lpi_entry_timer: entered
[   83.571782] dwmac4_set_eee_lpi_entry_timer: GMAC4_LPI_CTRL_STATUS 0xf4240
[   83.651520] dwc-eth-dwmac 2490000.ethernet eth0: Energy-Efficient Ethernet initialized
[   83.659425] dwc-eth-dwmac 2490000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx

On a good case, the stmmac_mac_enable_tx_lpi call always happens
much later. It seems that after this change it is more often
that the link is coming up sooner and I guess probably too soon.
May be we were getting lucky before?

Anyway, I made the following change for testing and this is
working ...

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b34ebb916b89..44187e230a1e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7906,16 +7906,6 @@ int stmmac_resume(struct device *dev)
                         return ret;
         }
  
-       rtnl_lock();
-       if (device_may_wakeup(priv->device) && priv->plat->pmt) {
-               phylink_resume(priv->phylink);
-       } else {
-               phylink_resume(priv->phylink);
-               if (device_may_wakeup(priv->device))
-                       phylink_speed_up(priv->phylink);
-       }
-       rtnl_unlock();
-
         rtnl_lock();
         mutex_lock(&priv->lock);
  
@@ -7930,6 +7920,13 @@ int stmmac_resume(struct device *dev)
  
         stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
  
+       if (device_may_wakeup(priv->device) && priv->plat->pmt) {
+               phylink_resume(priv->phylink);
+       } else {
+               phylink_resume(priv->phylink);
+               if (device_may_wakeup(priv->device))
+                       phylink_speed_up(priv->phylink);
+       }
         stmmac_enable_all_queues(priv);
         stmmac_enable_all_dma_irq(priv);

I noticed that in __stmmac_open() the phylink_start() is
called after stmmac_hw_setup and stmmac_init_coalesce, where
as in stmmac_resume, phylink_resume() is called before these.
I am not saying that this is correct in any way, but seems
to indicate that the PHY is coming up too soon (at least for
this device). I have ran 100 suspend iterations with the above
and I have not seen any failures.

Let me know if you have any thoughts on this.

Thanks!
Jon

-- 
nvpublic


