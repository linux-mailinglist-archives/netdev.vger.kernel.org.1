Return-Path: <netdev+bounces-167025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A58BA3859A
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127831894806
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874EA224890;
	Mon, 17 Feb 2025 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uDDgTbWv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4322331F;
	Mon, 17 Feb 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801321; cv=fail; b=dZYFavfbRYsllkEIATUftN2riq4EwHzWHgc+2ldtbU398+XK42ABeTf0MMfKNWcCGBcyqyWr4Dn6h1mXJBbuIOZnb2D1pbuHQK+JmUfoDTD14e7j0TqqCNDaaAbsJ4VwvTJfU/op1o6fMQ9vEx+xDCKeMoQp/iA+h55uWrHP/G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801321; c=relaxed/simple;
	bh=usAJWeDQe9aPu/wq8BiuM9s/CDBEvq8Jm8x0FShWRN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=acN6KRiK3MZS9HuHfjuUrjY9exWKWTlRKjGfKwFIHV1FBSNU/rz3RaVD36xUE7NvtVBwH/hRUVZAouX4IN9PE2qcQxP3LyevmQsPvFkMO696cWTS8hKM+IiYVztISxbwdZMapHZmoNvZv8GkXLLySJ0p1UWsi64O8UeZz6uiv2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uDDgTbWv; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ra1e3L4vUPJqyAY3WX2HFxH0qnch2OiJjNBKV55WJMz2qQ52D5PHpLA5Rs4jwNHK9836hGIUTgNQ6yoK1bx1/anM94B7BStqtdinDoeXBKXEGt2Noez0vMzBh4MquZdgpenc9vYq6wqLqfGc4S/UoZ8I7ZI8TC0AX6o8+6BqH18PxsGMRIbGGaHKWm2FyY7Z1+qLpJXIPOZo/BbzimiDJ1iO0PCKg2ERSgdmAMhHjtDBVDX4knBxdNIIEFf3LpIRoThLRTvzqL10yKlID7RVVGu5+gD5owlH0n3MQAg05J8X+jQeHYtvr0bCAftyDjg9gH9kKspK16+xb7bqv7Mtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5LsnkVLozOyibLGuo/90elmly9DNuRq4bdtEwzoxk4=;
 b=lpUYSLU5hZQAOUXdUZuSyHo+YMx3wvE7EtrdvQSEm0wmsjuetc54/HSxJiNwI7fXdG8VTD06KZ+VmVD1nD18PeZ8FBQEpJ3Z2/NRYdFlVj/qDTOg5NrUhWUlqjmgQll9o7VRpIsFP5ucHCITo2hbtEP44AnbQOyICf9j2/uR526VCBxjW9aQr59kF2VCZmAONiyiRWW9hsRtfqBvBejWa35Y8i8mfWIgUpz/3JWW2A+uEPh+AZHKyPUdEUTKsZeBaCh1wFyHBlOpSyc1YqAlAp2KOgXkjij1NFUsqSh3CQ2T56LxcJZMnOiYnfz3WFlXRiQSbcFqM1YfyWo1M7WoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5LsnkVLozOyibLGuo/90elmly9DNuRq4bdtEwzoxk4=;
 b=uDDgTbWvcwpW49ZILGHu6flXTxij2mi4zMbr+PpSSZewwCsSKEZpTETCJmgZcXhd3A1w6NDGQvYrzd+9jXRsW80wypgaGPAK1I13rx6bD6wTYzorSi7WaiJ0LPrM5QoWfaffMBGtId4CH22Fyj2OuIrC/JP3ccCWP4PpWyKlvMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Mon, 17 Feb
 2025 14:08:33 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 14:08:33 +0000
Message-ID: <2feddf43-7d86-4fc2-9817-3d0e51152b98@amd.com>
Date: Mon, 17 Feb 2025 14:08:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 16/26] cxl: define a driver interface for DPA
 allocation
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-17-alucerop@amd.com>
 <20250207134605.GV554665@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250207134605.GV554665@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAYP264CA0010.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 5619d461-5bff-481d-e2ae-08dd4f5c9028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3g4SUh2aDRmcGdyREVEOTNPRnUrMm5sNlRsUHY2QjRuSFVra2dURDlmYXVp?=
 =?utf-8?B?elpiY0ZNLzB2VDhwcDRHdWtVVlp3WldCRzdGYUtQR3lzYUllaG5VZ0VoV0wz?=
 =?utf-8?B?Y3BGU3BNZkJNOStDWExBTlUxVndMSUpYTGNxbGgvd0EwT2xFSGIrcEtzMEpk?=
 =?utf-8?B?aElGdXV5L2ErOUhNdEhOc2dGbng3S0F2dEZUSk43NzZYcVN6ZFZJbkVxSXZY?=
 =?utf-8?B?RE53c2RzZFM2dmFiYXRUUFp5aVFlbTFKOGJ6c2diNFhFbDVxYXowM3l0WlFi?=
 =?utf-8?B?dGJka051eGdaOHNrZ2dVQXdtaW9SbW5JRG9vbEtRNU02Sy9aZU5DOXMxWitx?=
 =?utf-8?B?RXN0Q3JSZlB6WVpxdHFGT0pGZUQrMGJkUlF1QmZGOU1udk5uNHc4NTB0TTF4?=
 =?utf-8?B?TjJTSzJWbUtjN3pyRGFyK1JFK0dNd0FvZ2ZETG9LamhLaFZONHNBS3BoaUhM?=
 =?utf-8?B?eTVpaC9UNTA3dUJneC9WOHpiZHh4alQ0eGN4Yzg0cUtHMFp3Z1Q3Qi9XT2tx?=
 =?utf-8?B?eDZBbDVTcEFQOU9GeFdHK1NSWUN6LzZ0VXZZNCtORXN3YWt6TXBGeUxDWEc0?=
 =?utf-8?B?SjFNL2xubjd3QkhqRTNUSjI3dGdFOGhKQkloSmlpOVNNTU8weWRpbG9FUUIy?=
 =?utf-8?B?WFg0SUVnNFlKYzF0MlliMVZ4cm5vQU1IZ3ZaVDMyazBocE1zZXIrWGptV3FC?=
 =?utf-8?B?ZkRhRUtraTZaOVZ3R0N2ZHlmd1l4S1Ztd1VLWlI4UHVyMDZOajF4TGkxMnBJ?=
 =?utf-8?B?OExWZE1SV2tCSzNVUmdUaVE3ak5Cc3pvMVlpMkx5K3ZaVHhsUE5zZXBEeFBw?=
 =?utf-8?B?OUtuMVR5UjV2bk1RZGN3Zk1xajRPN2tjTFIyZkRGM0ZBZjd1bmgvYjV0RkN5?=
 =?utf-8?B?ZEJwNzQ0S0dPNDZ6Y2FiWW5WaEtwV3A2SzJvbUR1NzNab0lvU3Babnh6MnpQ?=
 =?utf-8?B?Rm5LZU1MNDFjM3B2Qm9tbWVRMGhyVG1IUU1vVk1jR2hJSytBVW9wM3BYcndD?=
 =?utf-8?B?ZjQ0TXBxaTNyVE9PaDhWSFRwbW9CMkRkQXpFbXVWWjFpK2FOS081czB6ak9I?=
 =?utf-8?B?bERaM1p4dDQxRnI3L2NYV1QrLzZBSUlHUkxJME5xakIxSE9VTjBWQ3FWWktN?=
 =?utf-8?B?K3A4cHh1UTArajMydkNaRmVWOTQzOXJKbGp3Um1hRlZzc0ttMS9EY0E4a1Br?=
 =?utf-8?B?VExsZzVnZmljU0hidmVaZnZ3UWh5ZjNJSWtleGE0SW9teHBLUzZZT3VUbTI3?=
 =?utf-8?B?U0RFMlo0c3U5bUtoK044bGxiVlR5NmVvNHBJLytIbnJZWjhZcnFyQ3l2SGg1?=
 =?utf-8?B?TG1oN0cva1plTVRTYW1OZnp5bWVVSnVaRTJrNTVBM0FOTnVzSFdYV0lQK25a?=
 =?utf-8?B?R2hycGxGK2c4eFgxT0RUdlpyWUdNeG1xTFY5YWVYZWd5ZnlqR0dWbWpBMVo0?=
 =?utf-8?B?Q3RaeWtDMU9weHFWTWtWSG9wQVJDTlNSbXY4QkJBTnBxRlZjWTZOMnQ3N3dM?=
 =?utf-8?B?cVlsNnBWYUpaRVNieE1FLzJvQzNLeDFpNUVicGlOV0twY1Z3Z3E0UG5icms1?=
 =?utf-8?B?SUY2eGFUMnEvcmlRcGhRdDcxeVJHbjRtQi9iQ2VNanZZNmoxUlBLVVhPbjhQ?=
 =?utf-8?B?NDFCN2hRK2xBQkh1MGQ4VE51YU9xczc1QjN5azBPNm4vY2Rjdmx1djlqeldH?=
 =?utf-8?B?WENJTXZyc3pPQUw2OHMrSDZJRGlJemsrQ09wNk16UmZuQS9GalRHYkIwZWRi?=
 =?utf-8?B?dkpnRnhvSUdkNmJ0YjNwMUlHRExrZTl0c1huZmVHa1JUNjBxNUVVUEN4cjNi?=
 =?utf-8?B?MzhoUU5samVnaWpJenNmRThqTHBSckt1S042OUxrRVYrUGtFY0tRdW5hYnJM?=
 =?utf-8?Q?wG/GSbH9yfXcs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEtlYkRVdi8yVUNBVyt0YVJPWldtQURpeUN2UnNqNnJ3d0RCVXpSaTMvd25V?=
 =?utf-8?B?NGtqS21lWExDMkNGWVhwZVlvUnJhL1pNeG5raEhXNlIyKzlZQTU0c3ZleTFR?=
 =?utf-8?B?Q2QvOGlmU1ZDVmZTTDVGWk5heVprUkJueElCeUl6THNBcW5kQWpqcldqRThp?=
 =?utf-8?B?ekMxdUZ4SlZYelhKbFJEM3RuM1R2RThXNzFzRlZZSUhIa1pialNaSE9EKzc0?=
 =?utf-8?B?MHI4S0lkbk5ZYkVvRTdJOWF4ODljdTZEQzJPWHBEek1WN1R2a3VoZnl2TytX?=
 =?utf-8?B?REMwalk5SEZ1TVBIQVR1UGRCUHY4OHY2eTk5ZnRrc3l0ZUo0TlBCbVppNXFk?=
 =?utf-8?B?eHlleTdVSUtMbmd6ekI5YnVJdVFaNUJERHdDWkhZbXZXbWxYaVM4aHhkS2ov?=
 =?utf-8?B?Yjhja1dQNHFGM3hqMmtGMi80WjVWcXZSWGRORmZkZFMxdHFXMGVXNDEvZC9y?=
 =?utf-8?B?UThLVW91LzdXdFJVcjc0Wlo3MUxJWUdzRTZxQUdVdjJtb0U2KzVwR2Z5MHZU?=
 =?utf-8?B?bG8xTlVackFUakVaYUhHU0ZKam1QVHRIQm00RDN0YVVBaGdHVUJPc1h2WDJ6?=
 =?utf-8?B?d1o0d2JCQ1NwYVl3SlU4RDJOZlhxQlRWekw0SXBxcmpEWjh2MlV4Y05tdVhv?=
 =?utf-8?B?WElXSlJHOVdtQzdzN2Z2YmQ3b1NuWm5pY295TE10RzZnSzVJNHUra2FWUklj?=
 =?utf-8?B?N1JFblhJZHpOM1lQS1RaYjcwYm8waVBLNmlwVlRTd1Q4Z3FPaW5EcFJHcitQ?=
 =?utf-8?B?L2JDeFpzOVh3NFd1S2UrcGlOc1pLbVNmTjdQUnBFemtVaC9WR1oxb1FFbWpW?=
 =?utf-8?B?clB5amozKzNoSWhTN1UwdmhQZzZWazBEdmY2d1NpYmhzWWRLUVEyUXVwckFl?=
 =?utf-8?B?T0JUNDhzZ0d6Nm9Idm8xcnBFeDBqY2hMOFptdTZ6dXI5dVptazUrdlJXR2Nv?=
 =?utf-8?B?WEpzY2YvaGpEdG4wcmd3VTBKQjNxNFE5c3NTdTFZbkN6VjgvUnRRaG1qU1g3?=
 =?utf-8?B?UzVrQTlVeEhvOXVjenZRMFVVaGlwcDVHTlVqV1MwTDBSWmFma2hTeUpva0xz?=
 =?utf-8?B?YjlYcDJOdnRrTGFSUFRPNHV1OXZCQUVPSi9NNU4zNmtuNFNPQWNTUGFrMDJY?=
 =?utf-8?B?NlIrbTRCRkhxZTBhcG1taG50SHJmTnFMRUk1RHpxL0VqWjc1aHd0ZnppT0dt?=
 =?utf-8?B?ZjlnZE1iU21wZUpsRlVzeWZoaU1BSEFicmxobk1WaHloWUhVMkY2eVRYalRx?=
 =?utf-8?B?dVhsNm1GRG80aXFvMkFseS84eFpLeWwvdExOL3JTK2tFQzVBaGN2dHhjTWVU?=
 =?utf-8?B?RzQ4UXJid1lBTUZnYTExbUpIK1IwWXRFbzhkY28yeGdoR1lHMkwwZ2toS0hI?=
 =?utf-8?B?U1p6djRiYVdpYzJqUXBKeHE3QVZMU0RkSThFNzFaZURNVnRXMGpmbDNuMDhO?=
 =?utf-8?B?eklsaExCZVpvRnNWQWRXdFU0N3JnNVBYYWhQK1gyVDFSN2tCazlOVWkwcjgv?=
 =?utf-8?B?VlhZZHRFVWtiQ0Z2d1N1amZEZjlQQmNIdTYxYWVCdXZqSFQzMGxRa2E1ZHVQ?=
 =?utf-8?B?T3c3cytHRi9qUlYrNVg3UkdGV2NlSVdZSkY2MWgzOS9MQko2K0ZjelBIdGhr?=
 =?utf-8?B?M3NFekowUTdGbjVYalliUGoxMFJJbG1aRGtoek55azZOQldoY2tVaElkMHFm?=
 =?utf-8?B?ZlZzODJMTHpheTJtQUdHcmJLV3oxYXRkcWp6UkJrbXpGSmp2U3drRitCZGpF?=
 =?utf-8?B?MlBGNHBpWXFEbDk0ODZUZFpUa2dQNEhWdVRiaHdiYW1YNjNjOWVRWnFPNXo2?=
 =?utf-8?B?ZDF0TnBLTmx1aTBQbktObGMrMTQzWjBTbVBqRjEyNytDcTZGWnFaWVVQOVpn?=
 =?utf-8?B?bXBIaWsvUWR2ZW5mZHBsOVhQVnoxSUIxTU1ya3k4K2svS0JSTWdNa1YyVEdw?=
 =?utf-8?B?cWpvTEI0eHVsdkdNbk9naHFRd1hYam13ZUhjeTlSTktZMzZNb2dvclZVOTVn?=
 =?utf-8?B?TDE0QUlHUUFYYUx3SS9hMzV3ODNpeklqeXBaQTh5UFM2dm9SeStWSEFueGxY?=
 =?utf-8?B?YXVTWUovWTVYTTUrdWZkV1dLZU1PTVB0cjVFQnBaSTZQcDlLakpzRTlBMG1r?=
 =?utf-8?Q?1pvwZVco3oqenqjr1JIWUu0RG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5619d461-5bff-481d-e2ae-08dd4f5c9028
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:08:33.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Nvx7gi4wWqWM3PT2cYN+uwnnTzgrMAO8GgFg7VpFlz7AqiNtVNRIl6YoHZj88rGQAxnr4uzmfXwZ+qVSKD+Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877


On 2/7/25 13:46, Simon Horman wrote:
> On Wed, Feb 05, 2025 at 03:19:40PM +0000, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space. Define an API,
>> cxl_request_dpa(), that tries to allocate the DPA memory the driver
>> requires to operate. The memory requested should not be bigger than the
>> max available HPA obtained previously with cxl_get_hpa_freespace.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  4 ++
>>   2 files changed, 87 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index af025da81fa2..cec2c7dcaf3a 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/seq_file.h>
>>   #include <linux/device.h>
>>   #include <linux/delay.h>
>> +#include <cxl/cxl.h>
> Hi Alejandro,


Hi Simon,


> I think that linux/range.h should be included in cxl.h, or if not here.
> This is because on allmodconfigs for both arm and arm64 I see:
>
> In file included from drivers/cxl/core/hdm.c:6:
> ./include/cxl/cxl.h:67:16: error: field has incomplete type 'struct range'
>     67 |                 struct range range;
>        |                              ^
> ./include/linux/memory_hotplug.h:247:8: note: forward declaration of 'struct range'
>    247 | struct range arch_get_mappable_range(void);
>        |        ^
> 1 error generated.
>
> ...


I do not understand then why the robot does not trigger an issue when 
building this code for those archs.

And where does that second struct range reference in memory_hotplug.h 
come from? Is that related to cxl.h?


