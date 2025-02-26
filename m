Return-Path: <netdev+bounces-169928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B37A467FE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7AA16E56C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5772248B4;
	Wed, 26 Feb 2025 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nFUEpZ68"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5621B192;
	Wed, 26 Feb 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590698; cv=fail; b=QjaybreifqtuvXxdlCpbBsjuoNU67/kcOLNimm0yTKO19EntQSKZ13ELUHth+Gs5rsDSI8uILc98RfMmw5fAJkSlyw7hsxQadlls7tYxibghteozwX4wJlrioPqBdHZengUZAn7sBaNTiwsExQp41EqFnjE8OMBB6cgKO4mBGKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590698; c=relaxed/simple;
	bh=NRAHZnZMud7sXCJmfB5Ae8N7ElVt1tw5GJs6Uv7rfLg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gMSOeXw0/YE/Fy3Mu7VS40ZVh1nfxGMxMMJtLnR8M2HxUpPsTY1BVW3y4+aDS8eHHPHBsDsDkeue75jmnOovoBuW/ZW2tqo0ubKcHSQ6FBsFoi2OD90LI6tUp70j6ICWpA/jC/asD1ewa41KRSZE0dGqhEAvlFGeexxlQ8opVoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nFUEpZ68; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQJHXyq8xVHYpYiKxEeJH6UriaVm3v1oFgIQWU0rAALt9r0rp4HU/yhBQPAD0j3wkpt+nrC92KuE5pzuRItmvtYUQkRPk3Om3btUPWHrMHX3QmicKFTjzXVi/MFWlkAthUz/ObGnkl5v9UnvWihHe+j+r6ILEyn+S5rTi94GNqmruJHRcptSzNxeZbs4HEBeBrF2+NWT6iIntrpTZyyS85B+CihJZFOh3udqcoLZe4Xd7K108QjntkC+AGQI7k5KyEiKmW0Vq0cOMvm8cyadZ0jWulJZPetDXCoRDzXqIRxHRvotuWgZeWpCAEqWqV/oiNmAkvl/GEubJtQQUKDvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAR7myVsLXju1XpE0BamCupk1j4FobR++bV0KS412Fs=;
 b=q87XC3BYx6FCY56IWTCPuTT7YQ9Wn25uyC70awc9dWJilkD5HPi0eNlCBaMt139bMcURDth5p90sW22DE9ziflwwaL6TdFOCKrUJM68/O8WunNR6vgqtDP5txuG3EqZP0ZsgrqPSqqCLTaWh5OINz23g4EOpPwoy4K1Skzz3tW6DWfujageg3AFWv5H16fW7qWa8snxHfqQPEn1Wq+a4Rbqgm9qYB/iuGd9goJAJbhgM2Vl/RTjGtjoulpbQjv0agEndUxbkfkJLK3yzfRZg4LcSFf80koSH+3rqsLdm8YmicZ5wESoqE3QLpje92buD85wm77iH+3lAjhUx5AUzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAR7myVsLXju1XpE0BamCupk1j4FobR++bV0KS412Fs=;
 b=nFUEpZ6853IjF6NMemNZARRdXOZrSNMPk97ojS7e8tvl/Txg+QBJn3s+3eGzCQ+lPvJxN09UjY0N6v2K083ybgV7N3K2F4hEnAYUvOeEOpCq+KveL1fH7nLCn360dd9SVWdgnlluDB0Nv7xAY2k/ipNAnTfYmL+JMVYFshvrE4oyI+LmJ0OJldAEZcJ7D/rymhcws6pNUAQl6ZH4nw/1RxMfj5dbuSouvIGT9q30hcG+pMAaacIch3rM0xg0DTZ+UND3s/ari8YfZz0eObk550o2TvGFNorA0xlwgLZlS0zoVOCpbQA5EIHBEtRExcolFz4eQvBnqj6ESBbQurCr3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 17:24:52 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 17:24:52 +0000
Message-ID: <cc693881-70c8-4019-9b5f-f74669121f5a@nvidia.com>
Date: Wed, 26 Feb 2025 17:24:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
 <86fae995-1700-420b-8d84-33ab1e1f6353@nvidia.com>
 <Z7X6Z8yLMsQ1wa2D@shell.armlinux.org.uk>
 <203871c2-c673-4a98-a0a3-299d1cf71cf0@nvidia.com>
 <Z7YtWmkVl0rWFvQO@shell.armlinux.org.uk>
 <fd4af708-0c92-4295-9801-bf53db3a16cc@nvidia.com>
 <Z7ZF0dA4-jwU7O2E@shell.armlinux.org.uk>
 <31731125-ab8f-48d9-bd6f-431d49431957@nvidia.com>
 <Z77myuNCoe_la7e4@shell.armlinux.org.uk>
 <dd1f65bf-8579-4d32-9c9c-9815d25cc116@nvidia.com>
 <Z779FzlWTwbbKW1s@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z779FzlWTwbbKW1s@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0168.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::11) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: a39a8573-d4e0-47f8-4a23-08dd568a7aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnA0R01hRTNEaDQ5R1pWSUhJMWJiRzA1d3JWSmhXUnJFZW1EV2kyNmJJQlJw?=
 =?utf-8?B?aWorLzlJSXhmR3F2NGh6aHFQZ0lneDB2dkFBVmN1dng5ZWZXbDhlVVBnT0RE?=
 =?utf-8?B?bFRJbEpEUHdCcXdyb05WSzFIb2dCOFB4blVLT04zdXRld0hFTmdtdmJwVjBn?=
 =?utf-8?B?WTV1SWoydDVYR0hIRjhiRXRwSkpxUitINnp0TU1leXBuVzdRdnlBTEpmL2dy?=
 =?utf-8?B?Tk5GVk9NYU02ckpkek1GYkU3c3cxaXIzdTNXSTNra2tlc25USUF6K0FVVm5Q?=
 =?utf-8?B?bUcrRHR1QkNaRlhxK2RON01iSHFNckh3TS9CbW1kenI1M2hWSGZmNDdsalBo?=
 =?utf-8?B?YmN6a3NkQXJlRmFvVzcrUUE0MXNhWUpYTHF3L21FS0N2czVCZmN0OTMwRHF4?=
 =?utf-8?B?cXlwUHV5cW4wR3N0SnJIaUVndHozNTY4OVZlb005c1prN0EzeG5zY1BPMUlX?=
 =?utf-8?B?QnBkVmg3cDY2YVJ6NzRDclVhbzlQWmR6ZFd5UEFrbllkUFJUWEFpNkpTME1n?=
 =?utf-8?B?eVdlaS84dWdQaUZOQXZSdmxUaENwc0paVUFxZ0grcjVwZzBaNnpaOS9zc05P?=
 =?utf-8?B?akJQYzNPUVgvWmVUdVcwTXI2b2JxUVV1Q3lwNnFiUlU4anNTT0VKbmZvdEs3?=
 =?utf-8?B?KzY4SnYrc01XMHdIVlZwWjgzc3V0b3dOK1MyT2htL2FuZitFMUd2d20xbDBC?=
 =?utf-8?B?cW82d2FMYm9oUGMwYUYzaVR4SmxCZU5sUS85QS9tTy92Tmc4Zm11aTZMQmNj?=
 =?utf-8?B?amdzeEhtd25qNHpaU2liUFQvMzRjRHhqV2tzUU5acjhUMkYyeFpoVjNWbmIr?=
 =?utf-8?B?RE9VUXh2TUhRNGNROHNGbkpoK3h5ODVLMmVjSE81clBzUHFZbzB2TGVpYXla?=
 =?utf-8?B?YXFDeE1Xdm5CWXBGeHcvZG14SXVyYUl0czdPdHJlT1kwVnU2VFRGRkJlU3pJ?=
 =?utf-8?B?S2orWmZnL2M0RG8vREp3WEFXRUQ4UFdHM3luMGhyN0Y5dVpyRXZLVmJvcDhF?=
 =?utf-8?B?bUVLQmI4dHlZc3JTWElvMWZPaHVjcXJwcjg2SHdHdUJ3ZkUvRmQ4NVl5VlpF?=
 =?utf-8?B?am84cXg2TXd3em9aN0p1UFJObGR2YnluU1Q2eUtkam5aTXlEbTFrNlFDNzNM?=
 =?utf-8?B?bUszSnBQUEk4S3kwY2pTYWRGdzkwS0dMWWJ3aHlPL216OFF5cUpmaWt6VmtO?=
 =?utf-8?B?YzRDREZGZzd2eUVGYmI1aTNzM2Q5eGFRS0drcTI4b0RmR2JEUUYzb2hHTnNi?=
 =?utf-8?B?R3JldFBhczZGNlZ3bk5SeHdFR1Q1aFdpb1lGa2hjWVBHTU13YTFwblROMUw1?=
 =?utf-8?B?QnAxc3dFZ3V5MTFtMlBSczAvN0x0K0M2eHJESVdZbjBUSnE1TFV3bTRZU3F1?=
 =?utf-8?B?N2tnQ1ZJaVJQWEREZ1lsVVNiZ3EvWjJYNnBwMkgwcStFWkhtMEJvaFNXc3Rx?=
 =?utf-8?B?MHdQdlRWQ2NHOE1HMUNmdkY0b1phL3FnNXRCRThSSlZuMjRYb2c1ZUMwSXhO?=
 =?utf-8?B?Z2ZlUFVmL0hKMkFVWlFJMFdXa3FialdYeGo4YzJPSVprNkZlaE1ycjg5akFE?=
 =?utf-8?B?TTBHcWt2SWVJMDBLOTlTVmN0UmZDZW5MQ3p1d3kxOUdETlMvYVlkZFZFcG0w?=
 =?utf-8?B?T004SjEzSnNRSndlZDdVUnE5VndFYVdwVXNjbGE4L0p2QzgzMWJkbmxEa3dS?=
 =?utf-8?B?VzBNZFUwZU1NdGdkeWtEL3hGYzNBdTd5QmRwcFNtckdQMEVLRXA5azBDNGNE?=
 =?utf-8?B?ZFJ4MTZJcnoyRkZITHUrOXM5akxmNFNReXo5YWNKdFJLUG8zdWJEOUoxcUtX?=
 =?utf-8?B?cmQ4MHVmcXY5dnR1ZjNqZHEzVm1KT0I2UEhpaEE1dU9KaGRjdGVWK1k0M1pq?=
 =?utf-8?Q?tymy7QNBMAhhS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3FvZ2V5VnBKMWtjWm1hY2pwZ21RTnFSQzVTMkxtUlBFT25BYjlEa3AwcUZO?=
 =?utf-8?B?U0wzZkgxUGdLMU5oVzA3Vm5uWXJkeUVoQW5YTUt3UTJsK21XRTZIdDNzVTlj?=
 =?utf-8?B?YlZxNGtXdnRGd2N3REdseEhJT2htK0FPSVNnaEwxWmtxVjNncytuLzdKYzRr?=
 =?utf-8?B?d0VTYnZCcmR4RlJLZEJHNjlMSnRVQUdZblI1WC9WTzJnYmJtK05nRDFnaUtO?=
 =?utf-8?B?YTJOc3pKMTA4QStMSmJySTh3TVphRnZsSm5VV2padzNVZzNpVU41STJJeHdM?=
 =?utf-8?B?UHJqVitnWld6T3lTTkJuNXY3M1dUaDNBc1RhTHk3V1RDN1BvNEppV2hZdUFo?=
 =?utf-8?B?SlFJU1BzYzdoeXFiTHdGa0VKRWRCMVVzMHM3ZmFKZ0lqbGJzakowTm9xaTlK?=
 =?utf-8?B?RzltakhOWTNFSGdXTUxqVnE0R0ZOTFNwZm1PSkdYMU45cTdGYW1tRjliQStl?=
 =?utf-8?B?N2J6WVJTWnQvVFJWOCtrTkQvUnZnVWpjWGVwYjI4STJUS0M3UDhIUHRkOXJX?=
 =?utf-8?B?a21oMkdJZWEvUkdhRnE0R2QrNlZZdGVIYmMveGlsZm1HZkNwVUQyZnM3WGlV?=
 =?utf-8?B?b3VURGJCaWhJcTAyUmRrak9Zc0swaFdTYmEydmttdUxlQlFEcUthM2V3U1BL?=
 =?utf-8?B?eFJSdGYyVWkyUGpydDd3K28zY05aZFdLUHNocS9NdVlZd1pIbjB4YUZuU3BM?=
 =?utf-8?B?QjVJMVNuZzBWbmExdmN4SnJhOEFxdU11TWdKcnR6Q0dRSGRpb3RjZkk0NzJt?=
 =?utf-8?B?eXBwWnA3c2RwdHdpd2drSE5zbUgrWVpWMGU1YnVFTmhRRDdoeXUxNWxvS2lB?=
 =?utf-8?B?TXZYYjRPQXdIRjR2cXpYb0RvWFpuUzkzdHl6dzBaSHpkT2NreUpFYkc0aTdV?=
 =?utf-8?B?WlltYitOcGJwbWZjdWs3NzJJYTRuVnJ1c3d6T2d5eG9yNkc5WHJlRHdxS2xG?=
 =?utf-8?B?T1BTMlhxekZXUEdZMTBQb04reTRmZ2IyQlBlR3BIVXJKOVBaS00rMkY1Z09x?=
 =?utf-8?B?dW5jbUJEM3dsOWdVQjQ5ampZWit6MUcrNlFKREVDYkpWM2d0bzd3WlgxcWt0?=
 =?utf-8?B?VFJqZUF0MlU3aml2N1ZMTmdIOEJWeDFIS3Z3OG5yQmc5VE80ZDMxTjkwc3dM?=
 =?utf-8?B?Q0ZXaFJheHRHWWU0amxRM216elI3ZXl6Z3MyenZoTnNHU09PRFNWTEpjMTJZ?=
 =?utf-8?B?M3lia2crRXhGdWVvNWNheDJBWmQvbWZKR05UL1haMTgvbUFKUkxKeFA2TDhk?=
 =?utf-8?B?VEhSK1JaRkpRdnVoK2RldGtSK0ZpZWVrNVBtOHlGZlI1dFh2RFpEWVFCTUVZ?=
 =?utf-8?B?djF6OWh6bWZBREhUcWtoVDZRTHRLQzRqYkpJWlNKb3FxYnB5NXdDWFNzaHlZ?=
 =?utf-8?B?d0NnbmJ0bDlSY1ByWGZlUkhmdmV0Sm9SaGMxdFo5OTNWWmJrSURWRm1FalE2?=
 =?utf-8?B?cUFFdEYyaWltRGNLd0lVcFhiU2JHcVFPOUNEZFlQYjVMempTQmxvdTYyRWhM?=
 =?utf-8?B?MlVQS3k4eHdqVWdDU21OcEtXMEY3cWJERCtGR0x4RzlUUzExWHRsaW1PRmxO?=
 =?utf-8?B?SzJZaTRrQk4vTkdIbVlvZklpL040UUVZUGloN3BMTjY2cjFGSDBkV2pqQ1Bj?=
 =?utf-8?B?L3NSenFMemhMcTFjbFc3U2dPYXorYVIzMlVqbjVVRHJQVTJPVHcySUppSlhW?=
 =?utf-8?B?ODdRcXRRb2EzMEFrb25VSHgwd3Z3aVVycFhmZ2h0bGFIVWpCWkJ6bldpQ1hZ?=
 =?utf-8?B?VHBQQXZETUZVczVtYnUwbTBKUTUwdlIxYnFCOWxYaFovaXRla04xVm1WZ09j?=
 =?utf-8?B?SzZ5Ty9WVjk3OXBxZDNRd3BYU1l4Y0RvaEJqZ0w2U1luaXFtRjJYdXhUUlF2?=
 =?utf-8?B?eFEwOGRjVkxOVy9CbmJ1ZzlJNVhYMDBTbTA5cTFrdzlEdGpWeGErelZLeDZ3?=
 =?utf-8?B?Wk5NTTVwVERaWEZJSHVjOHZRSVhrdjBHQzBlVkoyeVRCUHZkRlZ3L2hadnVu?=
 =?utf-8?B?MDM2eDZ0cCtpeUtKNThpNGJnWmxqREVXeVFNUUFhcExNMHVlQjRQbk1SNVdu?=
 =?utf-8?B?ZU1INXhSUDRhY1BRaTlzeksrYmJJdUVUSklXd3pBam5hWDQwKzZjam9sYU9U?=
 =?utf-8?B?REo3ekY3bjVvS3VOWE1la3ppbnFtK0hpdnErdHFjVjVnZmszSzlzN2tNSDFt?=
 =?utf-8?Q?9bSzKQ/kAavnlQbNzkTbr86mYOevJmLe61WYYj5VCkyF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39a8573-d4e0-47f8-4a23-08dd568a7aab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:24:52.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHk2tRL2qIdgKZSG4f5k3QTTViddjStfsWUIwwItZhIuBkRmTBK8tha2+bG6ogwEX9nk1GBxsKNrBxlJM9brzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865


On 26/02/2025 11:37, Russell King (Oracle) wrote:
> On Wed, Feb 26, 2025 at 10:11:58AM +0000, Jon Hunter wrote:
>> On 26/02/2025 10:02, Russell King (Oracle) wrote:
>>> The patch above was something of a hack, bypassing the layering, so I
>>> would like to consider how this should be done properly.
>>>
>>> I'm still wondering whether the early call to phylink_resume() is
>>> symptomatic of this same issue, or whether there is a PHY that needs
>>> phy_start() to be called to output its clock even with link down that
>>> we don't know about.
>>>
>>> The phylink_resume() call is relevant to this because I'd like to put:
>>>
>>> 	phy_eee_rx_clock_stop(priv->dev->phydev,
>>> 			      priv->phylink_config.eee_rx_clk_stop_enable);
>>>
>>> in there to ensure that the PHY is correctly configured for clock-stop,
>>> but given stmmac's placement that wouldn't work.
>>>
>>> I'm then thinking of phylink_pre_resume() to disable the EEE clock-stop
>>> at the PHY.
>>>
>>> I think the only thing we could do is try solving this problem as per
>>> above and see what the fall-out from it is. I don't get the impression
>>> that stmmac users are particularly active at testing patches though, so
>>> it may take months to get breakage reports.
>>
>>
>> We can ask Furong to test as he seems to active and making changes, but
>> otherwise I am not sure how well it is being tested across various devices.
>> On the other hand, it feels like there are still lingering issues like this
>> with the driver and so I would hope this is moving in the right direction.
>>
>> Let me know if you have a patch you want me to test and I will run in on our
>> Tegra186, Tegra194 and Tegra234 devices that all use this.
> 
> The attached patches shows what I'm thinking of - it's just been roughed
> out, and only been build tested.


I have tested these patches on Tegra186, Tegra194 and Tegra234 that they 
are all working fine.

Thanks
Jon

-- 
nvpublic


