Return-Path: <netdev+bounces-196414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 317A9AD4AAE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522A11898270
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 06:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA0522687B;
	Wed, 11 Jun 2025 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TAhkmL9e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D0EEA8;
	Wed, 11 Jun 2025 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749621914; cv=fail; b=F3EzG62q2Fdo4Kqll8g7k7tsCtNhG/AZYyKwU8T7exICfakuswxz54Bg7ZTrPuoB2rL30MMDjN3X5zWFJj1LQQwUo+f6Xk0jZpEdrH2HnXIzCkkXc21CUZTwObhORVa5AqDtnZAWcJgShFTxR2q2NAtO1ZRXzeWuwUpaffH1QjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749621914; c=relaxed/simple;
	bh=Na+iSy1XrvDAtIChN60c/ceAiZFZ2tLlvpg9JA+umR0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ob9SniDG26+cyl4OddUb3q8kVIxJ21jrAfvUkMLxEMe1HrW/cMakeGV6nZMerlsUFNXFbHNOIhRLpJj8T7lKlrTCAoHNWoSIFlePYfqsaHQCitYvQRrGAcUj6kU/HaNthHTrrJJ/7HRvZfcMedXU/LZD5/PYfIeHJeIPqoUVWY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TAhkmL9e; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5Ubp4kqnLRZg5RFzg0tJKz4e+BXmhvCsupXd7ZHJHy5TU+NY8jfsMpS1lSeWxCfsU6JguJLhWOfoxq+sHE0OykGOe57nyNubfd/aXNwXiOHLZubA9MfArK1v25gQU3G/Ex8dl463awDH5JP6iJdpOUqb7uAlG0QvwuKYrLQSEi2o8vk63/z7Sk9WvXNwrq577puyrPaCehXVu3SEUnI4VhrN/242P2wzBRNe0felj+3zaDuOehEmx1cE3aWZJigyzPFhgmTv1hh9qKKxdhs/VhpCqckhRqaHH1QI0++U2jnHAxvmXYUa+3vDquIJnyxA59WCMYfGmT/CZJpmJTcag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IoYfv0xh9/+8xCwDl8lE2YfWJsrpcYJf3Pf+bHFWNQ=;
 b=hBVtGlLS6ORIiVGyCHYWEG1mLb3W+DukcGDeE9tjuzl8qw1udEEd7+JbYG7DNPnnF3cQJu64tbWi+7+KjXpbd40ZEKD/I2/s1bB/egmnMxmfoffr8tGlPcdEPID41/T6qUs5delf78kn3QACHr6uKc13KySdMmOxtBmG854Koj8q/2O/VYt89cXyx+2fP5lUrKHBrO71rlhwfvAHkyvjZa8UBkxoEyzQ1gDHaM89hkZv3CLwCbQmneC/arsxArmmdOIePN0G2kENrM7ZwEn3FGI2CaRpCnHlQpOXm6sgJwUGqBzUD69cXhDJMl81bmdJOiO6INPHvutm2mffbBeOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IoYfv0xh9/+8xCwDl8lE2YfWJsrpcYJf3Pf+bHFWNQ=;
 b=TAhkmL9eHT8i/vfYKDyWHEHOEhU59cCmtgDYYecY1Z9OKTBUG7Q1iVdgFe/eEPIWz6SmdH3lVttLbwVtBpleNEmssH0WyrenKTmHXuA6NnU4QHVIUM62idD94sspQPeGh6CFOc4518atXKg+9zNaS0ERVYdSguy5msMTKXfnahHdGUAoOG5+6DbNOo670q5Tkt1lXrZAJbrfd/TEv9axalGvGeDggV5eAY5aPrfice+qc7Gb2Hrdw98avtlXuOoAzPzQWz9KnKw1V4aHrpmvsMpJrh8aunBqfZ5EE98YbH/WWttaoRiJGju2ST6XV2S0nfCpZAV5TiG50Bey6qZIfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Wed, 11 Jun
 2025 06:05:10 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8792.034; Wed, 11 Jun 2025
 06:05:09 +0000
Message-ID: <b1b7b052-ceac-4119-9b72-ed8f4c1fbfe2@nvidia.com>
Date: Wed, 11 Jun 2025 09:05:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 00/13] Add support for PSE budget evaluation
 strategy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Paolo Abeni
 <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Donald Hunter <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
 <8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
 <71dc12de-410d-4c69-84c5-26c1a5b3fa6e@nvidia.com>
 <20250609103622.7e7e471d@kmaincent-XPS-13-7390>
 <f5fb49b6-1007-4879-956d-cead2b0f1c86@nvidia.com>
 <20250609160346.39776688@kmaincent-XPS-13-7390>
 <0ba3c459-f95f-483e-923d-78bf406554ea@nvidia.com>
 <cfb35f07-7f35-4c1f-9239-5c35cc301fce@lunn.ch>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <cfb35f07-7f35-4c1f-9239-5c35cc301fce@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e4a8e8-70e1-4f2b-1acd-08dda8adeb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnZuSEpBOFBJV3N3d0ViME9aejg5R09Yd2k0MzNUUTk5K1VONmZOclB0YWpU?=
 =?utf-8?B?MnExdEI3TnJPdnRBeWVQYWtWNTZlMDhPSm1NUklDM3ZyZmVuWFpKMzdrTDNt?=
 =?utf-8?B?UFJXRXp5ZENIbUJoQjFiRU8zSjBBS3J6d1paNUVlWGg3NTNlcW1lTjQ5NXNr?=
 =?utf-8?B?SkpvbTUrdDRHZWR3TzgrR0hKM0FFbnhiWDFYa2xaZ3RrQTVpUnZWNEsyQ3pp?=
 =?utf-8?B?alRmMFRFUlFya2hSQk9hMHBJSndUZXpsNTU3QVMrTUVZVi96SlFQK1IwbmpV?=
 =?utf-8?B?SUNMNUtJWUFPcnl1cW1ka3ptUWE0NHArTUd3bnhsVFFMSG54bmNCVitpdldr?=
 =?utf-8?B?NDlqcFl3c2hnaGhIL3M3eFRtMUpUZm96ellKSFE0aVNDVS9MR1VaYVJFZnFL?=
 =?utf-8?B?UERZWVhFZE80MzI2WDdFTE1yUWg1T3RSMHhLTnlUZ0FYaklhM2hOQjkwV1JS?=
 =?utf-8?B?Tkk0My9sZXRIQTgvUTFQcThWT0pBMGQrYm52NC9SNG9MYmJhWlAyeksxSkpY?=
 =?utf-8?B?SDRHVjNkQjNXNHBkZnA0TDFSRU10M0N3RnU1ekJzeUhXZjQ4Wm9sN2NENUxT?=
 =?utf-8?B?anB0SVo4bWphaEw2Wk9FSjJuUGJUNXpUNUZONWQvYWpwck9yQzI5VHVrYzNr?=
 =?utf-8?B?aG5ORWtIUG9NaVJDdHlZNTdzTlZyYTlJcXIyTXl6WHM1bW9nQzlKZC9SRDB0?=
 =?utf-8?B?SUU2SUFWendmV1BsWVZoS2J3eTZWRXErdlN1OElmd2ZCZFYzUDhNdG9rdkpk?=
 =?utf-8?B?bW40MEV4YkIwLzVTTEU3cEY3MFkxM0FVMDZ6R25mcU4wbDZla2ZyaUFLM2NN?=
 =?utf-8?B?QTdEeGxMZ0hJWXlqVVpHQnorZ01GVkphOW5jN3hGaisrKzZwaEQ3blkyQmVF?=
 =?utf-8?B?cEE5bGU3aTFRb1ZHWEtiS2ZCZEV3YWJSb3FwOVJDN2M5a1lqa0s4c1RrNXRQ?=
 =?utf-8?B?MFhYYjhtYkpCSEozSS9oUFJOekFLRk1PSHpYRm4zNXhadStKcmN0Y3lUSzZJ?=
 =?utf-8?B?YUJpcGJScysyaWZPSnpZOUQwYktRTWovb1lMS205Y2tOZzBtd1FiQXAxVERm?=
 =?utf-8?B?K0FGMlF4NDc0YUsybEpBWG80Mnd5NDcyU2ZQRDN3cmxyM0JYN2JCMnpUcUlI?=
 =?utf-8?B?WXJjTkhhM1VXNlFwT3RpeXRJeHJLQmJpeFNjUE53K1NOQ2wxeUg1djl3Tkta?=
 =?utf-8?B?eFplSCt0K0FTUmdmQ0F4YW9vd3R1SlFjSkZIaktaeEVobk9QU2JPVHRxZHVD?=
 =?utf-8?B?UEtvSDhPaFp6Sjg2eHVBNUNLTDBIOFZwWXRqZ1ZBejN5elVrOEdFMkNjbVEx?=
 =?utf-8?B?d1M1bCtnL0w5VmV3cFRhSG9ycGRWZXEyQkpDQlhzcTNoWS9Ua0ZxckJpVkFv?=
 =?utf-8?B?ZVdwTDJwRHhBb0UxaTBjQjN1UkFwS3RvV1k1Y0ZYalI5dm1QU2RrRzZlVkEw?=
 =?utf-8?B?KzBHWk1xMzA5Y2wzOGJJM0FLcjNZZGlWVzRlNkhKdnpFWkIvTWtORDB4Z3Ba?=
 =?utf-8?B?ZThidCs3SmVCbytCNGxKcGdERUlKaEVFdnlMSURNSzlYUFliZGI2SDMxN2Zs?=
 =?utf-8?B?d042Mk52cmdZWnAzTFhlQVo4TG5MYlFPWlB3VERkOWJONTdzaXVSd2lPallj?=
 =?utf-8?B?MjdsMnpYTjlQYWh5NEtJd2VrSTFReU91UlR4bmwyRnJNd1pJbDk5RWN2aWV1?=
 =?utf-8?B?aTNLR2JIUWMxYThVV1VpY0tReFNCWkdxVWx1aG9KWG9TYmoyS0I2M2FIeG9C?=
 =?utf-8?B?TVV5U1dmb1dYdHMrSDhWV0h3WWtwRVlKd0t1YWY3dHoyUkUrVUYxbk1HRGdl?=
 =?utf-8?B?MGJrVGdGaDhHMVJWS1lsZnZIMWZtaUdJWXJUQzBDRFgxQXpsNVZJbGRxTzZ5?=
 =?utf-8?B?SHBDbThlZkV4RURWdStOcm5NbjFGbGVyTktMcktHNzZrUUkrbE1VQTE4MnBC?=
 =?utf-8?Q?HwL5OkbbSKY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFRkV24rOURIT2pkWTlBa2t3SUdPUyt3emFtWmo5bmFoZzFON2NnNy9VTUQw?=
 =?utf-8?B?SE1TUGpvZEZoWGorSHFEU0pDY0ZwWVd4TXRsNU5sbHNKNnJHSUQ2aFA5c1Q3?=
 =?utf-8?B?bWkrcGJ1RmxuVXNlU0tPREoxeGdNMjBTRTFOR1dCS1RKSzZXR2lWYm9VT2V2?=
 =?utf-8?B?dHovaFc4M2R1Y0d6ZlBRVlpBKzhNcXhIL1JpYVZtcmptWTZoVUJuc0xzVSs2?=
 =?utf-8?B?eW9oKzdLMldBeG45UFQvNk9obGRXdzFUbDNSV2xPQlZLSXUwN2dTR0lmOUwx?=
 =?utf-8?B?YXFMMkVhemxDQkdaSGNNVUo1eE5yZGlxSUdHMzBiNVFVVXdkUjZXYi83WjZY?=
 =?utf-8?B?b2RYQTEyUEp5TzhCdTZ4YWV0MU1PbjZrT3hObjZRc1U4SWM0b3U5Si9nRWF5?=
 =?utf-8?B?a1NVTzh6UDlGYmhaL0lrSUxkbis1TjlsUEI3c1lxQlMrNnlVdW9EMDNHdkRJ?=
 =?utf-8?B?TUY2NXZGQTkxSmFIN1AyckQ1VlhlaUwrY2ZHcllQL3pMYTI4RHJMaFpBMzJ5?=
 =?utf-8?B?NDVubFIrOEw5aWMxSEVNcnBwVW85bjAxOUxWay9iS0xCck5hMDk0bjhHbnpH?=
 =?utf-8?B?U2w2SzliYWI5MzVUMWFtVSsydmNzN0dYU1NUMElHMGJqV2xlTUVQM3dJZzJo?=
 =?utf-8?B?MDBZTDQ3bXdLS0Z3bDdOTWtsRWpoNzV5RCtid2hTMzFhM0ZvN1YyZE1NbS9w?=
 =?utf-8?B?ZTBML0VONkdMV3FLd2xkaUtxSnh3N1drSEpTbmJsUHJrMjJHMUhPU2wrMWdC?=
 =?utf-8?B?WWQ2YnVVZzBrT01QM0xQRURrS2lmYXp2NUdVN1dacmZIR2dCbnJJMk93SEJV?=
 =?utf-8?B?d3Q1dmxoSWtWMTBSaTkyZkhiM1JVZytnbzRDdlZGdDNQRkR5THFTd084T2g4?=
 =?utf-8?B?MmcxN0ViM3ZVVkJOWjNQSTh5b2VyMnpvekEwbzhhKzV0WFVpQnk5ZzhnNDN2?=
 =?utf-8?B?ZjYrQkR0eDhmc1VrdGRvNnRuVEMwWDNIVWlESHlMUjJyanFJbVkvTHVINVlV?=
 =?utf-8?B?Nlk2M2F3bzVIWUFqM1RIUDY3a2ZYYmQvdWVoN0o4dUw0RTBJdDNRM0ZKa29N?=
 =?utf-8?B?dkhFTkJncXZaSlU2Nk5iUHhkN05JRFp0WWZ6UU9KZmowQk1SazVCSzZOWTdS?=
 =?utf-8?B?dUhlWEx6RjZFUVYzOFQ0RFhXa1VBSGpLalNyNVlTdEc0VkZudVpJM1N6UFRJ?=
 =?utf-8?B?QUs2ejkvMW0xOWdhcVZreFdBeE11VTV3aFgvV2pVazBCY2ZVbXB4WVYyQ2E2?=
 =?utf-8?B?UC9tNFc0aU04U0hsNWxRTUxQU2hzNkw3MFZKWGRWQUJQUHlSakxINi9qdzdu?=
 =?utf-8?B?ZGVKN3lTSGorT3UybkpBSmUyeThFQnF1cXZOYWVkL2x2UnY0NCtoZnMwUE1l?=
 =?utf-8?B?NjZNQ3NyVXI0Mlp0L2lzTGMzWithTDhGOU9RTDZLRFB0WGcvMmVMTlo1bEMx?=
 =?utf-8?B?YzIwQVNpRWdrTlFmaGRHS0lpQjkyUjFsSkdmRnlseDJ5RWRrMG5oWFMyMnNq?=
 =?utf-8?B?dlgyVzI0aTdUYncvTW12bnVsaU5xUHg1ZlJJajk3cVkrdXJ4ZnN4bklOYnI4?=
 =?utf-8?B?TlpDcHJ1T2QyS1VpekRSanEzMm5nYWNoV25DWVRTQ1dNTTUzbVdNb3AxYitW?=
 =?utf-8?B?WGxkYWRZTnpabFNBVEl4aVJCcW9pa0hZNi9QSzFTZk4zcDRqYnRidnpLcE9y?=
 =?utf-8?B?bldSL3RBUEtMRkl0QWJRYUgyK3hOcVFHdE9pZE9PbVhicEJOQk5ocVpUTndQ?=
 =?utf-8?B?OHpESHFlM2h3TGhuUDJPeTF1UEltS0R3Zm5vcHhXZGdZSS9NWHlRVmxOQk5W?=
 =?utf-8?B?cXFrRTNkVVBhTEJjQ3FlTHNBeTB1NVFLSGF4TGtJZHlTUWNiRkRiM0ZuVWZP?=
 =?utf-8?B?NGc2eURldVVVVURwaWRCQzdSbjlXNWdINEZYRTBxbXk1ekRKLzRRWjMxdFF1?=
 =?utf-8?B?bTVNVjgxakJvQm1LbmF5V054OUVNVmRTL0dUQ3kyNHh6UnFIaVFOd041c05N?=
 =?utf-8?B?VWhpT2xFNGlOZXp4d0s1MXROSzIzWU0wU1RuNzZ5VnlSYTY4OUh3T1c5L2dJ?=
 =?utf-8?B?M2ZhVldaQTZ6WGx6V2RNbVhsTng0RWl3TVFCMHhaVXhZd2hMK1ZZMUFtN3J6?=
 =?utf-8?Q?HtIxQQHOrsd+iXFn4fEyVB35v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e4a8e8-70e1-4f2b-1acd-08dda8adeb99
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 06:05:09.5010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBXRqms5rA4moza4Z3n/yh0goHKF93T9Pz56Alinel0zNwqEpYyBBU573G6x3dx5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

On 09/06/2025 18:12, Andrew Lunn wrote:
>> I think that in theory the userspace patches need to be posted together
>> with the kernel, from maintainer-netdev.rst:
>>
>> 	User space code exercising kernel features should be posted
>> 	alongside kernel patches. This gives reviewers a chance to see
>> 	how any new interface is used and how well it works.
>>
>> I am not sure if that's really the case though.
> 
> The ethtool Maintainer tends to wait to the end of the cycle to pick
> up all patches and then applies and releases a new ethtool binary. The
> same applies for iproute2. That means the CI tests are not capable of
> testing new features using ethtool. I'm also not sure if it needs a
> human to update the ethtool binary on the CI systems, and how active
> that human is. Could this be changed, sure, if somebody has the needed
> bandwidth.
> 
> Using the APIs directly via ynl python is possible in CI, since that
> is all in tree, as far as i know. However, ethtool is the primary user
> tool, so i do see having tests for it as useful. But they might need
> to wait for a cycle, or at least fail gracefully until the ethtool
> binary is updated.

Thanks Andrew, so I interpret this as selftests should be added when the
userspace patches get accepted (or released?)? Not part of the original
kernel submission?

