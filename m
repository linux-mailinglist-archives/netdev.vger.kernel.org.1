Return-Path: <netdev+bounces-176404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE54A6A147
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1383F7B0EE2
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2881EF38D;
	Thu, 20 Mar 2025 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mfau2lm0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE320D519
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459151; cv=fail; b=rTSr40DyLmolDvQzDgQCSH+4dqBQB3AFJlx4V1LXEbQGMHCW4LFZZG9T8XJxoKRhmNLJ8t2zwK3fg8WBQN8Ubfn/EHfNJVr7FtIZO1NF+IiO+nwxkwXP5F5iUBf02kEEihmaCADEO2iB5IXG0CIVS7DF19s1vN3+AGd4gDX/Di8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459151; c=relaxed/simple;
	bh=mRwKi7R8G5ydfo50S6WYBaUXdpuR6eo0eDcZqSDpvX0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eQyKaLihXFLT2DjGn3OY+mVO+rUHVgTVKtw4v6ZhAtCkFpVr9UgJcFH8O75qJLTOIdpOD+Qi9cyc54BDtOO4aMsXTkqvq1hUx92ech300Igg/wqyq7z2GNepCpYEQmZFfN9HbjwiayXgQRU1BXG3xQa5POMPAeG2JOjQhGfRqbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mfau2lm0; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQz0z/SJEOU7K+u8nDURmckOdZAbugIZ42MJi1PQsKbmUo5uqkqj+WjqLdfCS+6dM9t6HY6FCev7fvi9taAIe2WqcwHz/AxGEq8FkLQbEo0BNqaYdQRANGLpIgWNGBLqMS2oDEkHh3HuOXw6L7bBiypAYF/ywfyo0XeaUWwCnLuU83NX9WvaX2CVLBTt3hOcICfbV7Ty3v98AIejQFuepYtHdZASYJ45dPkwQkdvnnNlU3sJ6ouVPyrEz7suTroe7q2m08wWsEps4f2fnvBp73p1SfGOu5yhyTaNs2htexb2dyPep7m0wkVQS1XSZzQL6DxvKnNIuwYH3HnWeppt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI0qy/QXfQlQowhIgOGbzM6vXe6bhAb92+kIcgh1+8Q=;
 b=Nu9TCa9rSH1lsi6gKyXZY7dGOIePC8cTGu06kioWXVDvqln2RFCvUcI36DLideMG6VZnqaEY0BYzbykFFuT93ctFNx6MVkBeiOcWjgeGa8UmIyVpZZY/rwQuWkCPYfWJpdx4oBWGSGW0wGRP9ZqdKQJl5j7KPtUsxylwsct1YTswAl7/cQju2PF7A179K+YRbWx6LOLdR/iA7V6Nh+RV+trMYM/0lSEtkNZaitjQfulxoclE04W5HB3j/qlOwSXnz5029fAi9FtxuAJmpuqUetqM4Tmg0QwTpUrhViU8sCfwivXs6VnykfBeSTPGIDa6k9K7pk2TUw7ArVj49fZ7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qI0qy/QXfQlQowhIgOGbzM6vXe6bhAb92+kIcgh1+8Q=;
 b=mfau2lm0ADWb71HbPDs3xN/LXfHis5BxytuTWUH/BaLgM2lP3mrA4qqKrQQcGmbTUzhryqk8YwApivxk0JOrO6EYGLPvreSZJcQTn/ZkjJpxo5ckNcGLXqYxC5gP+KixQc4t2Cmmc9NHrlB15yDGe3bGuXEGuZtgYqlX/hNFPGfM+OQCIcnOMOduQmP9wcgic0sjCYFHpiEla9dagf/jyYSEhGNYbRtmBQ2p1oDbDK5WeCwg4UREoQ/h0mdjFxvProWy99ZEjywfxhnGA4kfwgPJ9fSEi+bNlW9uHgF3xRc4Py83cMWefUsQFpRI9hJdGvmDjRh7EFQlwjlbdd+eOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 08:25:46 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:25:46 +0000
Message-ID: <fadfb5af-afdf-43c3-bc1b-58d5b1eb0d70@nvidia.com>
Date: Thu, 20 Mar 2025 10:25:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Fix ethtool -N flow-type ip4 to RSS
 context
To: Maxim Mikityanskiy <maxtram95@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>
References: <20250319124508.3979818-1-maxim@isovalent.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250319124508.3979818-1-maxim@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::16) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f30d6f-8f14-419c-9d82-08dd6788cfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGFZMXlMSWZXU20wNGhHbUFiMkpxd2tKb2dLRFM3Q21CSDlKQ2N6UXRMMFE3?=
 =?utf-8?B?WVdqR0o4Qms4eFA5V0g1WTRVajNPM0NDS1V6ZU9OTG5NanNuTnhUTDhwNVVj?=
 =?utf-8?B?Z2s0WEdNTDczbmZ2eGlCT014SlU0NVF6ODdTdGM4dW54UTlNaEdQNGR0ZjFo?=
 =?utf-8?B?OTNxUk5uMzM1MmYrWmZKRFlSSlRpQnJHNElwRVkyWEVhMnczdzU2UU50ZzJW?=
 =?utf-8?B?MldWSkFNdU5MUzVzdGk1enBnU29WUGFsbHBKL3NDTW9FeEI2a1YvSldVRTdF?=
 =?utf-8?B?YUpQRDJqeHczZ08yYjV0YnVkVXRoVUdoQklLUEJsZlF6em5lVCs5ZUd1aFU4?=
 =?utf-8?B?ZzdhcGxPdkwrL05kRisyM3U4TEVTQWsxWmNlTHhTaFF3T2U3VmwybC81anR1?=
 =?utf-8?B?T0RHWlBWSTRwQmFUWlBKMHRFTnZVNzhCV2dIaWM1ZUFrQWY1Z0NrLzBjcGpo?=
 =?utf-8?B?b1hmakM5dUpmT1dEeXJnYWNrUmR3N3BRODJYNjJuR1JuRmFsamRzRTNuQzJu?=
 =?utf-8?B?SnlUOW1kdSs0d29HUjkvQjZuQjZwWWFsd2FoTlR5RUpYNnAySXpaak5oSVov?=
 =?utf-8?B?TUI2TzFRZDMvdWtXUlhuYWwrcVRLQlVmc2Jpb2o3TlhHbWFwMmVRK0lLOWFZ?=
 =?utf-8?B?QXRSY3BTQzJXREUrbXh5YzJTV2VCNzNiZVVZNDFrRzJoWVBJSE14TE96dlU3?=
 =?utf-8?B?MmFTNkRQL1p0bGVxZnhRU2k1Nm93NUdOZkErcDRzc1lEN1MxRFNGOGN2SWNa?=
 =?utf-8?B?dGFFNE94Y2c3UVpQc29mVmN0eUVRazhaQ3dlWWVVd013RG5EaUUwbjlYcVIw?=
 =?utf-8?B?VUFMdEJDUTdQUGxacTZXZVZBazlreWdTOHlFOG1QRVp6Q1RqTzdBUkFGRVpP?=
 =?utf-8?B?dWE3WFhTZ2lZN2tZcUF1RHFmbVIvWkdraXhmYlorelN3R3M5ZHpxajhNYWJT?=
 =?utf-8?B?K1NTNGhvOE1rNTZaS1hlVTVObFpZaGNuU2t6Vnk3YWNqVkpUQmgrdDRjYnlo?=
 =?utf-8?B?NHJtdXM5ZHBaL0N1T2JacUVXKzJpc1o5LzFkUUgzOXZ2Q1BKejRsSEpKZjJm?=
 =?utf-8?B?eCtLN3A5Q2xidWpuNDZpYzA2amh3TEM5RzJ1a0F6MGk2OFVaWWxvWERmYlBa?=
 =?utf-8?B?UUdLZXZBTHhkOVNSMmtSU3BRZ29YUlozeUNhV0FYZ1lXRzBHTGNQd0VwM2tm?=
 =?utf-8?B?VGw1L3ZJeWxlTGtaNjN1OHBrdkM1cG1CU2d1a05qd3ZCQzZRcVhiTlM0VVVs?=
 =?utf-8?B?REZIa0UrZlgzeE1KWU5pRVU4TURwRTZjTk1VZis1amU2SEpRUDZHLzZwSUdD?=
 =?utf-8?B?OHRvUitFTlRNckFKOVBpQW5OeEFFcFhiRG1idHdXVjVlcDN1MkwwcU0vdDho?=
 =?utf-8?B?MkJEL1o0ZHNPcDlQUEdsQXhRSGJyVjZ0UUI0a2QzZ1l6WXo4ZXIwQWpaSkFQ?=
 =?utf-8?B?UnVIN2t0czRiWFRwb1V0WVlLNi9QYjFwS2VCQUNxdHhFUlBQbkpqZE5ZeW82?=
 =?utf-8?B?dlRJN3B2bFFZK2IwaWpIZDIzOXJacUw5VWVRdy9NQzFDUnBlS3R6RCtMZzNk?=
 =?utf-8?B?cE1hS0pWd1l1ZXZyZ0Z2U3h6ZGU4U2QyQlAvdmxoYVMrY3p4d1dRcUV0RU1P?=
 =?utf-8?B?Z1M4TTZRVmVYWXQxTFR1V0dWVlowRk5JYkVadnlUOTdrbEJQZ0RWcm15UG92?=
 =?utf-8?B?Nk9aWWU3K0d3Mmlla3ZlQWRVKzh5WDFITG55NnVpQms5U3pIK051eGRCbkZV?=
 =?utf-8?B?bHdMTUJhTDNER1N6UWRRdlJhUDQxcTZZSmwzcHR3UkNQYTN3TDZjdStuV09G?=
 =?utf-8?B?VjNuYUk4OSt0R0xsZkErZVFaWURQMnVzMUtTWG5saWx4YjdYdHZDd2E0R2pR?=
 =?utf-8?Q?JX2aeK8f+uxR6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0gzb3NQMHkwQm5EUDFwdE1pWVA1MjVUZElqS0ZDdi9tczlUSWRndUhHVlpX?=
 =?utf-8?B?b2RUZnRHNDNFVFlwY0Y5aDQzUHJvS3V1RkQ5ZnBVMzZKcWdjTXMwaWJONy8z?=
 =?utf-8?B?L0lTVFRvakNPTldaVHpvRklHUXF5QXBlb1lrVFFBd012b3N6UWVmNERKdXhi?=
 =?utf-8?B?L1d4VDVTR1Z1bzdERHhHdFZSSmU4ZGRmNFdkMmpJWHdvc2h4N1FWaXdNSlZ4?=
 =?utf-8?B?eTgxc1BHNDBNWE9jVW9PalBNcTk5MHAzSUp6ZWRQMWg3eU5UeVBpVWgxbDlk?=
 =?utf-8?B?bmorMklZK0xnODJHcWlpUmpLdlQ2dGdLTnRPUzMzYmpPdXUrNHBlUEVKaEI2?=
 =?utf-8?B?aXpMamppSlFTemIrR3M0Z21VVUlwRnAyVkNtVnVaOVhTZ0pqVXVxY2haTEtH?=
 =?utf-8?B?OEppNElFTXdoMmljb2lUN1F1VnJSOGZLeHBDZTdRV2ZsTys5RjU5bFV2Sktj?=
 =?utf-8?B?dkJkVnRxMEZ2VWU4bnN3ZzFDc3B1czNJNjNvN29naUxBWThLV0xuNXFVbmZh?=
 =?utf-8?B?RVhGVzNjZlZrbXFleGhBYWZ0QVVvbHZZalJpNTFzY1dkZFNRb0lPSy8vUkI2?=
 =?utf-8?B?TVczakN0bmxLYXJ4RXgzVHlGMHpCMTJmWWxHKzAzeHZNUWt2enpRSnM5MjNs?=
 =?utf-8?B?WFVqaWF2NWxBWllCTklWSUZoRWlFNVUxN0JKc2lDRnpjRFNXS21LakdkMnA3?=
 =?utf-8?B?UUlmTkorcTBYVnVSV3gzN0NVeGgwNlE0VHlPald5N21KN1RaT1dKalc3RTJG?=
 =?utf-8?B?TDVMMGdXVFNWMVV0dXcrK3BMSEl1NFdMTjJOSkQzaEtscFBEVmZzM09heGRQ?=
 =?utf-8?B?dDdMUGlCK25KaHVTWm4wVnNUN0pjM3hKUXhPVGc0YjNnMkR2SG5XcGJPMHQy?=
 =?utf-8?B?eWdWWlZzMjFtOU5wUGJYOG0zZUEvWi9kQkpRejJkcmJKWWtUUGdkdVNqODhw?=
 =?utf-8?B?WndYNWlTekpyM3YxRkl3aWVuak43UEt1dlVNSkp0TFNJNXZneG5hVjR3Wk5W?=
 =?utf-8?B?RUdDTXBVbE00WGtWcEFCejlma0dBazZCUEI4ZlR3Z3pMMlJEdy9rTElFdUJD?=
 =?utf-8?B?UFZxMXdrOURIa0YzK1ZoeTlhSm1lTlEzL21vK1ZaRnd5WjVGMW1qekhjVTNE?=
 =?utf-8?B?bHVLTlJyMmVJQjd0VmI3dCtrNnV6eWpEdU5xUzJyN0tURWgzcDBJeUgrVzVo?=
 =?utf-8?B?RkZidVFlUWt6bEFHKzVMb29EK1A5YjBPL1dCSGxQanEvUnN1SkhqbXRwTXUw?=
 =?utf-8?B?N3NHcDE3TU9HQnJjR2hEb01NYmRIa1ZwaFdlSzRIRmZFMFFhR1NqeWtBVU5K?=
 =?utf-8?B?KzMwTE9nVE1NR0laOUtaNDJ0NDVjQ3I0UW5ZcWlpNG9IWEl2QjFqcUJZcVI4?=
 =?utf-8?B?SytBMStWSUE3T2VPZTI0VnVBOU85WXZEWVQ1K2VOK2ZWejZuZnJscGNoblR5?=
 =?utf-8?B?cUM1bXVYSTA4d2NvZzh1Z3EvR0JScExKMWJXaTNzbnZDTWppL1ZldTZ3eTk4?=
 =?utf-8?B?cy9GVFRiUmpzMVNNTVRMSHlFV1BUYklBT2xlY0hqVkl6eXUyUWdlWXlpMDZR?=
 =?utf-8?B?ZUxSVUVPTnJFemZTek5lM05CK3BLMVg3VTliVk53M1BTQlVZS2owc3NhL3Nu?=
 =?utf-8?B?Nmp2Um9lZFJsa1ZqcWdLNmJKSW5XcEkwa3o1aHZmMlE3WnBDREYzMyt2UENU?=
 =?utf-8?B?UU05dGJoOHVnZzVtVFlEMFZ0UGhlQmVYME1nYnVNYXRGeGx4R0VLVklJR1RE?=
 =?utf-8?B?ZGJvTm5mZ0t1TW5zbTVPMlRZdHFxRlpVQjF3UkhlR3lHTGMwM0ViQkNYQU14?=
 =?utf-8?B?Wk9yQzhvZ0pOVUdrRkpJMndCbi8xcGJ3ODNZblZPc2xRSjhxYUxXSEtneXVs?=
 =?utf-8?B?b3MwTGZHU0lZRVJjMGREU3k4eHZLUzhOVFc0SDlGcWd3S294SmlsbVNmSEpE?=
 =?utf-8?B?UU5aSDNoZ3BEZ3B2QlZPQk9VZWNiL2UzQzV6UWNWZWdNSUMycVJhOEtySk1v?=
 =?utf-8?B?bVF2Y2FCKzFISitwZDh5ckV2ODVOaWlCdW5VUkNmOW85SXZDMmlsU2dqQndC?=
 =?utf-8?B?V3lkOVpWbFBVR3FTY1RPdU9jZElMSmZNVE5xRjBOVHl0TmZCVHduRUNCd0dM?=
 =?utf-8?Q?mVYxkkt//cFwdo0UGCLPX/tIx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f30d6f-8f14-419c-9d82-08dd6788cfc9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:25:45.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2oUrcFD2n4KVHWxxJ6Owk42nv5FWQMmO/K5nMRNqgL6eSZbN8hwpXwD18M/vkop
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

Hey Maxim!

On 19/03/2025 14:45, Maxim Mikityanskiy wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> index 773624bb2c5d..d68230a7b9f4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> @@ -884,8 +884,10 @@ static int flow_type_to_traffic_type(u32 flow_type)
>  	case ESP_V6_FLOW:
>  		return MLX5_TT_IPV6_IPSEC_ESP;
>  	case IPV4_FLOW:
> +	case IP_USER_FLOW:

They're the same, but I think IPV4_USER_FLOW is the "modern" define that
should be used.

>  		return MLX5_TT_IPV4;
>  	case IPV6_FLOW:
> +	case IPV6_USER_FLOW:
>  		return MLX5_TT_IPV6;
>  	default:
>  		return -EINVAL;

