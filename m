Return-Path: <netdev+bounces-134639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A302D99AA9F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65EC1C24A40
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33331C6895;
	Fri, 11 Oct 2024 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZfVmIQZK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EDB1BD4E7;
	Fri, 11 Oct 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668420; cv=fail; b=eW4CwgKI33VQ6zuKD3bT7iI4pl+r9smcCHIiG9bSeirWnN/kifYuepiSdxjxTE0pzLfVn8bgg2SA57DxlVpw4hKPcOKqVj7veBK7+EH59IpKxSWKoOoXuf1/1Ej9G2JgsSsB5uZGpWCVYHEMHE+FppuTwnzRMsHGzb8v1uxL76s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668420; c=relaxed/simple;
	bh=eC18YO8vx/gzvcwX3TqK1st6OyJm4DjYmv57Hdqkhn0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PLZD11lH4i1Tj3mJjSTqKAc7HgDKzc4aIaulQyvipICSmg4Qf4Iq5yG9tOuoSLtLD2dVGcEQRIOxj2C3HxMyLvDg3dcppfpZ8jZo55Kkd/cj0TNjFFoUAXNw0vBvVDWTbnBErYRmCuHwj7y1WAX2qpi1nxUnIxo5fwUhfpDDckU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZfVmIQZK; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBJO3sCHmPV3+Gihb1j706bluxoPZKmO2FRJBAAgi4wYZ2N1dFPfSY1p6ZlnFL48JqQeI4KW0n4qpNWds/zO9Pti8S5HA1t54eGkWikAjzMNOfWxvPJ9Ll3mwr3SEhtVjP3WL19VPp179YTakOWo0sRPMcaacWRkRzCx1SqhUAf7IBmcM8PI5d+e016MdLjfJkxuZHpX942Spu/d2t6NVdKOcujJdxaOEZE0mJyjw+9FYB2Bv4yv1JBDLjfC/MxwP10cAq+m3Re+ORGwUg48QaTZN7y5uhBadhh2S2il81r28fx4TvZfYn0y5AMZBQ5yFLhA5Y1nmoUGWIPDImzAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CvVzaWaRBH3xRpFEGYKqsZDV+ob1XAhXvemb3oXY8w=;
 b=PC5dwhCc3z22K6kTMrt6J8obVioXU19SMj4GbECo/b7BjZL4qAlcAfSIyOF7VTEpkdAF2aCTVihBNBawEtLm99JDQtCw2tSo7dnrg/R2qRcGRmLPhXhGas65YMYAwmwoa2Na30wc0+0xMAPTFACQ3X/73+FuqfwWuEeUkiPcpgpMF57SkBjULfg/pyFmt4ILZ450KgykO5qF4/F3NplPhZXBwfkp5Kn7DB7ZQj9fYB0Qm+sRsOX68Mlla7cHjt/Fnqx/T9VppIf5Uzifv3iB3Op2t2FpVdv3WgA64yhyPevCvF50lDGi3/ie5/kxc++dQJJBX5e4ArckUAnndglyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CvVzaWaRBH3xRpFEGYKqsZDV+ob1XAhXvemb3oXY8w=;
 b=ZfVmIQZKS9mFsqnWRmUDMUnsn/ifNWaod/c3elQVu8D/Xp+iHStcjDdedQRSRQHWJlQ8UbqzDYp1CIZvYK3szgEd6DFtcLn8Me7uHf1IFM5Lb/xN7nWlNxX0MTaObYYEPkmsKa1mf6qtOXm9ITwIKOE2RtaAjx3Ca5dAHXgCsGjLTQTKAR2m+J8DE06mB8sO0f7FVh+4rSytNUW/s/4vjW1dFDiRk1wft9aQRd2KeBFv3Wvw+k9iSL6JVtRb7ryvQ+HP3JlhvOxN1S6TNbrNYWSM5QGf9iQGX2TLdzb/ihbCr4YXRo2QL/46nvOEiKpeNs/NI3lkdwi1P/4pP1UOvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 17:40:16 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 17:40:15 +0000
Message-ID: <b7fcee99-91bc-4e9f-9acc-8b955212f038@nvidia.com>
Date: Fri, 11 Oct 2024 18:40:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: phy: aquantia: allow forcing order
 of MDI pairs
From: Jon Hunter <jonathanh@nvidia.com>
To: Daniel Golle <daniel@makrotopia.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Christian Marangi <ansuelsmth@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Robert Marko <robimarko@gmail.com>, =?UTF-8?Q?Pawe=C5=82_Owoc?=
 <frut3k7@gmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>
 <9ed760ff87d5fc456f31e407ead548bbb754497d.1728058550.git.daniel@makrotopia.org>
 <114b4c03-5d16-42ed-945d-cf78eabea12b@nvidia.com>
Content-Language: en-US
In-Reply-To: <114b4c03-5d16-42ed-945d-cf78eabea12b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::31) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0734fa-c868-40d6-a4bd-08dcea1bc40e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N04yN0Fsa0lWaU55MmRESWR5U2RXekZYckhXM05kaHprd095aTBHcC9tV3Fu?=
 =?utf-8?B?dDBzNjlDTitLY0FzaXk0QVlteElWc3hFakROdWNvMk5najNXcW1qN05MdElm?=
 =?utf-8?B?b0t6d0dKTzNIMEJubXBady9iV3l1ZkszRlZhRjhBS09pS3lrdktyVGJyV0o3?=
 =?utf-8?B?dTNTSmNMeXRPTXluRHYwNjN6NHB6alZLakFBTXhERHFRSmJIVjJFN0h0Rkdq?=
 =?utf-8?B?bk4rV0k5QVFaT1NibXROVXJkR1lKblM0bkdrV0VEaEZYSWt0eXB1UTFiSHZo?=
 =?utf-8?B?TmZFTFZFL0M3NUd6c2x2ckZxRTc3TGpsTzRJOXA4UmtBZzNmMUVwSkp0SFFm?=
 =?utf-8?B?NHdJc2ErbHYzNlZ5NW9HYTdRakU5UjFFVTVQQ0xKL3pwMDJaZ0xVdXAzcWU2?=
 =?utf-8?B?RVk2a2pUNEY1bUlxdzRnYVFveDh0b0RDdjVScUxlSUNPbnhrU09LZStCRDBZ?=
 =?utf-8?B?T0pRVDl3RXc1VHNHdlhRRXF1M2gyV2FPSTFNajVsUG15MWNpSUpBSUF6Skor?=
 =?utf-8?B?ZWN4c0psYUhJYlN1V1dKWTV3MkNxeFAvMElkM2F4d0FoaEVTMGNKSWxVano5?=
 =?utf-8?B?YUxwVEhVOXg5VDIya2VzTnNoNTNhZk9uS3U2ZXRjYlhDbDdRTUV1ay8vUTRH?=
 =?utf-8?B?WUlXQm5MM3YrcDdRd3lueVprbFEyakRoMVpMcnhLeXlZMytyRUg0czRQTXhi?=
 =?utf-8?B?cjFBL1hWcW1oMVBxSlR1Tk1ZUFNEMERiK3N1cU1VUml6WFpaVTlCb1FYNDVC?=
 =?utf-8?B?NGZpS1BWaVhFYVBhd0dxZlF5VmdiRWNLWlN1ZktQYjlZeWhSZVhUWkJpdnlM?=
 =?utf-8?B?Q1pMdlpCbWtJTyszSVlSb1pFb1FqdFh3K2czajhHYUF5bUJqek1VbzNSWnda?=
 =?utf-8?B?TEt1cHB2c3pJNFNBdHlweXY5S2g5cXkvSm9wVmo2YzNQR3BMVGxpVlV4WUtm?=
 =?utf-8?B?eUJHSENDMWZhdS9tdld1TGJjelB6bytDMTRlVmJIbTFhQ1JKUXd2SjBIMnh5?=
 =?utf-8?B?MGJqaDZXK1dXVUZXTUk0eTNrbHk5OVd3ZzRCQmZYWXJsK091bzJtWkpoUCtk?=
 =?utf-8?B?UXpLK2FueE9XYmtkR1dld2k5VHFDUW5NWUtFajVtcG9sODA5Snh4WU53NHF6?=
 =?utf-8?B?am5zK3pSS0pzd1lHaDlCNm4wWjF5TVR5a1N1Q2UwUWtYMTF5QUNqbmhVMklJ?=
 =?utf-8?B?SUhWU2JHYTZPQjlrcUtHb2xVN0JJRWM4MHd6d3VWeStTaE1yNDUxc1IwVk9E?=
 =?utf-8?B?T1VoVlE3ZGtVczduUFMvSEtYdW5FampZaXhPV0dBd0tEY3ZVQkZ4UWF2NEdF?=
 =?utf-8?B?akdQeFdxVGNUVzl5QzdHSDFPaXFxTzdLR0dVbkp3NXRvbk1ndG5KYlRhRGN4?=
 =?utf-8?B?dzMwUTRIRnJFS2xEdU5scUgyTVBhK2Z2RTBOQkcrL2RjU1YrKzk3S09HUE1y?=
 =?utf-8?B?RVlnNVByWlFDOVgvZU5ySUp0RkJ3K2R0RjZDb2xBbUk1WXlNUFNsL2QxR1hX?=
 =?utf-8?B?VHlTUWVqSXVaczkzT3M5dkpFbURZaTVGbjBocXlMZ2RobUZWOGlJcG00Z1d0?=
 =?utf-8?B?VEVNWVBPL2hXMkdHNUl0T0VEVndXWEd1YjM0ek9pVWlLbHNYbUNXa0RaSWdj?=
 =?utf-8?B?Znk4a280cE1JZGl6aWRrcXBVLzJkMjZnOWE5c1Ura1pFZTAzcHF1QWx3cUpF?=
 =?utf-8?B?ZzlteXlnMVUvNktzNWJNbE1wK0ZHTGRzbHFRSHc2SUxLM0FBRmYxRkpsTmdD?=
 =?utf-8?Q?yHXRhPMnDx3D7OYbgAGz3MUbv7ryUi2FcmvmCQI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkVVaU1hcEhHRS9GeGJoUmNFTHMyajJPc3k2OFhKL28wSk9LOXMrTVl0Tmxp?=
 =?utf-8?B?RXkwNkdzcGZ3QTFqSjNqdkZQOThFZkYxa0xBTU9BbHdVUE1jSzVWdXVBSThN?=
 =?utf-8?B?UDVZU0IvL0RENnQ1cTFBU0g4TU9TVHBCZmJUd3U5MGw2VGZDVHpNZlkraFJC?=
 =?utf-8?B?NTZVSnlVVEMxNTJFeFpwdUJLNnpob3hITHFUY2hobnFOV29zUXZ2anVRSjl5?=
 =?utf-8?B?czlpK1c4ZXVFbytIQ1ZVLzFGeWVxRHRySzI4MERKTytKRVdTZUlDek12V1Jh?=
 =?utf-8?B?SDNkWDErWVN2YndhUWNkOVJ1dTkwR3ZtVUpQRkJidmJTZnA5TjIvYnN6ZjJj?=
 =?utf-8?B?U0pFeVBrbXdkMkNSSFVtN2ZXTGZHWkVHQjA0Y1IyT0dhUHVsK1MrOXJFRVN0?=
 =?utf-8?B?NUpxblhBU1htKzVGS1VyQTdEUDkyTkhHelUyMkxkTVkxeG15eEhNUEVVdHF1?=
 =?utf-8?B?UlhiOUpZN0JXa1J5ZkRYN2NUclRxUHRwRUdrTGpUYi8yVTFMQ2ZmMjlzd3VE?=
 =?utf-8?B?amZqajh6ejlJMTRiWTIza0RMZzd2TlBtSURobGQxWU4yQjhrNWZXRzRFWVcz?=
 =?utf-8?B?R2V1RGdFQ3RKdnh5RUhQVHo3YnE4UkwzSWg5QmxidkZsMGdpOUFsQysvTUNZ?=
 =?utf-8?B?UTFQM2tUR3ZxOVJSTFNKTysrWENMQ2Y5NnQwNEZyL2R0YmY1Q25PUGRTYWhB?=
 =?utf-8?B?Mjh2dDQ2S1pKZjgzRlgycVBxU1I4N0M1eUVUK1Jna3FwNTYvQzZCKy9FbHNs?=
 =?utf-8?B?UFMzaUFtenF6V1dxZGwvdGp3N0MycmdndXFzMGEvbVFBcXhWNGpSRTJ5cWMw?=
 =?utf-8?B?STJZbHRVbUx3dTZXSERRaGJoOUJpQXJQS2dlTFpXU2J6UFNORnJ4WEErNEpI?=
 =?utf-8?B?cmg2ckxCZzFvejFXVkJvQlV0SkhnVStHclVIcnE2VG1xMnowM2hWNUFFL0Ri?=
 =?utf-8?B?SUkwYkwrblk3cDRQWnZSTE14MGRnS1k1U2h2czR4OFVEdkFiaFFuR25FZjhN?=
 =?utf-8?B?KzU4UEVYbWlLZjZxbVFxdHhMRkJEek9ZY2Zod0t5ZEJYdWtnR1lNRGtvUmti?=
 =?utf-8?B?VUNieHZBa3hMQXRRTTVCY0hJSHJ5emYwa0ZLblJkMXBaa09seWJxSTNhQzJ1?=
 =?utf-8?B?RmZqUmN5RHByWHFXQkVxTVVLcCtjWGxZUGJyYi9PVEMrUUs0OFpLd1JMYVdC?=
 =?utf-8?B?NTNKYUhZS1Jqa0kzdmM1aXFlZ1NzcGh0OFRDR0gyNXB1U0pkZTNpTE5QUllJ?=
 =?utf-8?B?ejlhUDlDbDYvUVdRRG9RTXJMSmRSUEFZbFoxTGxtQkJPY3d3U0w1N29wNzIy?=
 =?utf-8?B?NlUrUnVjZUUrbjl4RGpDeG42eE9WTzZPK3dHcUZZb1h0ekQvNDhBL2tKeVRL?=
 =?utf-8?B?bVhTeDBTaFdMdjdnck03YThaT1prQzVyYjlYNXQ2QnB5N2FkTXFucVM4NURS?=
 =?utf-8?B?aFVWNFE3U3g1QzdFR3BmRk9JQ2RvcFRoc0RzOVIvcmFzaHphVitEZW9DcExB?=
 =?utf-8?B?WTczWXhsWDRGNW9janZWcjd6RHErMWZDUnlFeFhkVmpIVnhycllLUS9kbVJR?=
 =?utf-8?B?L3JFRDl3RTdLVlF3eDJEdTZPMXp3VlJwNStYY3kwNWFVSFZxSGpNcTY5R2pW?=
 =?utf-8?B?dldyMU5aMldXK0pCYmNtOUZFMlhnR2FKKzg4cm1tdnJTUHF3VExreWd3RzNO?=
 =?utf-8?B?OFArWXZGQ2tEU0pTa21aSTdpVWFuZXlyQlJ6VlY0VElKL0J0ajZ0OGRoaXNF?=
 =?utf-8?B?TnNjcDZuQmdzbS9GZWNQWWM3cEk0b28rdk5sQkthS0Q0aFZMZ0FJV0Q4dUpP?=
 =?utf-8?B?eTFzcThSWFI3OVl6K25TTUc4Vkd6ZGxNOWlCM1liZGZ2UDJSUmtocTk2VVhD?=
 =?utf-8?B?NTFmV3AyK1F6OG1haWtkMzJSWHRPZGtleEJlMG43enF6OEpRQ2JkQzRiWW15?=
 =?utf-8?B?MG95Yk5MdzJsOStqSERSbm9nbDlyM0c5UWNrL090MTcwNm9SQ0V6bDlxd0lz?=
 =?utf-8?B?amRrWVp3aHNFOERJR25HYURHd0pqM2pUVVc1dTA4T3dRelduMlFya2FlcDVt?=
 =?utf-8?B?cWtJTWtmTit6elFTNGxrMU15R2xMb1d0THQrNzNvclNiRlBCSHhmMk9ZM0Er?=
 =?utf-8?Q?RD6fJ8kBHoZvaaeYryBEUKiNX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0734fa-c868-40d6-a4bd-08dcea1bc40e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:40:15.6461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3CLLqbBCfAUM5elE92R3/NGQbAXwal5AD79ELoNtTwtBRnYUD4ZJ51FPu1iTnEdCy/p66l/TqXnGJrq10dWbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933


On 11/10/2024 18:37, Jon Hunter wrote:
> Hi Daniel,
> 
> On 04/10/2024 17:18, Daniel Golle wrote:
>> Despite supporting Auto MDI-X, it looks like Aquantia only supports
>> swapping pair (1,2) with pair (3,6) like it used to be for MDI-X on
>> 100MBit/s networks.
>>
>> When all 4 pairs are in use (for 1000MBit/s or faster) the link does not
>> come up with pair order is not configured correctly, either using
>> MDI_CFG pin or using the "PMA Receive Reserved Vendor Provisioning 1"
>> register.
>>
>> Normally, the order of MDI pairs being either ABCD or DCBA is configured
>> by pulling the MDI_CFG pin.
>>
>> However, some hardware designs require overriding the value configured
>> by that bootstrap pin. The PHY allows doing that by setting a bit in
>> "PMA Receive Reserved Vendor Provisioning 1" register which allows
>> ignoring the state of the MDI_CFG pin and another bit configuring
>> whether the order of MDI pairs should be normal (ABCD) or reverse
>> (DCBA). Pair polarity is not affected and remains identical in both
>> settings.
>>
>> Introduce property "marvell,mdi-cfg-order" which allows forcing either
>> normal or reverse order of the MDI pairs from DT.
>>
>> If the property isn't present, the behavior is unchanged and MDI pair
>> order configuration is untouched (ie. either the result of MDI_CFG pin
>> pull-up/pull-down, or pair order override already configured by the
>> bootloader before Linux is started).
>>
>> Forcing normal pair order is required on the Adtran SDG-8733A Wi-Fi 7
>> residential gateway.
>>
>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>> ---
>> v3: use u32 'marvell,mdi-cfg-order' instead of two mutually exclusive
>>      properties as suggested
>> v2: add missing 'static' keyword, improve commit description
>>
>>   drivers/net/phy/aquantia/aquantia_main.c | 33 ++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c 
>> b/drivers/net/phy/aquantia/aquantia_main.c
>> index 4d156d406bab..dcad3fa1ddc3 100644
>> --- a/drivers/net/phy/aquantia/aquantia_main.c
>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/module.h>
>>   #include <linux/delay.h>
>>   #include <linux/bitfield.h>
>> +#include <linux/of.h>
>>   #include <linux/phy.h>
>>   #include "aquantia.h"
>> @@ -71,6 +72,11 @@
>>   #define MDIO_AN_TX_VEND_INT_MASK2        0xd401
>>   #define MDIO_AN_TX_VEND_INT_MASK2_LINK        BIT(0)
>> +#define PMAPMD_RSVD_VEND_PROV            0xe400
>> +#define PMAPMD_RSVD_VEND_PROV_MDI_CONF        GENMASK(1, 0)
>> +#define PMAPMD_RSVD_VEND_PROV_MDI_REVERSE    BIT(0)
>> +#define PMAPMD_RSVD_VEND_PROV_MDI_FORCE        BIT(1)
>> +
>>   #define MDIO_AN_RX_LP_STAT1            0xe820
>>   #define MDIO_AN_RX_LP_STAT1_1000BASET_FULL    BIT(15)
>>   #define MDIO_AN_RX_LP_STAT1_1000BASET_HALF    BIT(14)
>> @@ -485,6 +491,29 @@ static void aqr107_chip_info(struct phy_device 
>> *phydev)
>>              fw_major, fw_minor, build_id, prov_id);
>>   }
>> +static int aqr107_config_mdi(struct phy_device *phydev)
>> +{
>> +    struct device_node *np = phydev->mdio.dev.of_node;
>> +    u32 mdi_conf;
>> +    int ret;
>> +
>> +    ret = of_property_read_u32(np, "marvell,mdi-cfg-order", &mdi_conf);
>> +
>> +    /* Do nothing in case property "marvell,mdi-cfg-order" is not 
>> present */
>> +    if (ret == -ENOENT)
>> +        return 0;
> 
> 
> This change is breaking networking for one of our Tegra boards and on 
> boot I am seeing ...
> 
>   tegra-mgbe 6800000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
>   tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach to PHY
>   (error: -22)
> 
> The issue is that of_property_read_u32() does not return -ENOENT if the 
> property is missing, it actually returns -EINVAL. See the description of 
> of_property_read_variable_u32_array() which is called by 
> of_property_read_u32().
> 
> Andrew, can we drop this change from -next until this is fixed?

Sorry, I believe Jakub applied and not Andrew.

Jon

-- 
nvpublic

