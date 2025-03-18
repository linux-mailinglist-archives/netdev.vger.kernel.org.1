Return-Path: <netdev+bounces-175608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CC3A66B97
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEEA188B63B
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 07:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F81EB5FF;
	Tue, 18 Mar 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GTdXMjwe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341271EB5D3
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282947; cv=fail; b=Q+Bv8yUD8SN35XBAort6JGe7rvaqmP4pJ1fhy8KKGGu/C/YWE3Csb0NE9Z1gTkGb95HssXR1ENfX/EN/AUiFhFPs9G2xCaBWW2IHICMi6UHcT8BpsdyvOhgPw3Vb+HBarfK0ZJSS7zSceGl1T9fXUf1MqHvoJP5A9bfSeXSTnGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282947; c=relaxed/simple;
	bh=ezLMYbtmXgMX8x76d1yJQhVPxnFughiQDTXzQPesUyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nZxx5bIK/34cCr4CqnB4UPfRS2Gx58COkBreOov+VI4s5q3TohzWnHDFK17IUYew87muc2HYDPHlOhIcjqG3p+oQ2deHGJtoIvorAVqpap+CLz0/+Nz6l/WcMEB2xDUUJcIE/AApQD6Z2FS0GyHziRA1lnTANQwObA3K1x12B3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GTdXMjwe; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ir49eXhb8uVy/DUXQQcOPqNT49EpLbUHW1sTtD9tFdzcVKtTFnTpfHWcNLbM3SvMr6Xkf77MD+172EGWjuPfuDXxkAPWBTFvOinzxa7iPpmJUzgSMrebESTVbtJhQjpmYkho7BCygu8AFZSzvJy1gB+Cqp/1xDiHD4FSzKzx4qdLFdFLzrTNMAhD6iy++/dduydc2EVcFHxFWI5/KJ9Z/xdWRNsLOc8isvPWcfZCzDn4nBF2xEE+LhEw9b+1fprzlyr6VT8NNqMVLW+Uw62wObHgQCztinEfceoELeygS1ylXncTM7erJsbaCI2LSdX/WMFCviYx3aDMXtRvAzSZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIlZFDaGjYHwSYGCPPl6E2Dyi2WgD+2tNmCWdxLaGpg=;
 b=br17FwZDLAG4HnFWiIcv3siXbxEFpqpghwhHdBQxoAe5qYv3airTV2+doMy6Vf7kq0NPFNpO0cxTyI1bJDyzCs9xZ7QEezlW7jrBtT1/t/fz1optNAIoAwUPOOkSCD4xLdJe7X9gZclrlODM/hi3wEej3Ch9O0VytSRmrgSEe/D0Pl7wFyqNVXhooMMcvnxE0Efwoxf1pAn1rTCXutAh2LBANNgkVhKLNl79rT3HHSNgn3Z7qsayWwbwlACTPQpXNKWz9WDlK5dIkFH+3dKptEfSSpA/GMYDHtAmi7KafZWykpMLaH7UydZBDosA5MWXnEeZngD5eHZy6PlkzoA7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIlZFDaGjYHwSYGCPPl6E2Dyi2WgD+2tNmCWdxLaGpg=;
 b=GTdXMjwexvFxDaLhpdR1XLrnuSjIRpVzGgHSgS5ypRoLvFcbbC2c29TTMeuRZd+dgHzJZuk4pgcxxl23sgslwqA0VOiOt6z7U/NosrOsJ/7ICqtqWxp3rwFILLULRs+0TeMLP7vOaBlfQ5szQY4uAFNQlKqSXDbV+D3/ApJolSkzXF/m3BFKX0U5mEr5LRsrFP6LCn1cPA3sZyoB3fq7fBQDiI8Q53343FCQtqPUSozmw/s40K/3ZvsjNfJKkvEtevSR31QA+3uqvlGIDdQwjC5/abIKODuKswp/rOlhG2tJlvMcNVawgWVKxhe/LEoyk+DtkmkZKHmmearrTR143g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 07:29:03 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 07:29:03 +0000
Message-ID: <9461675d-3385-4948-83a5-de34e0605b10@nvidia.com>
Date: Tue, 18 Mar 2025 09:28:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: Block setting of symmetric RSS when
 non-symmetric rx-flow-hash is requested
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250310072329.222123-1-gal@nvidia.com>
 <f7a63428-5b2e-47fe-a108-cdf93f732ea2@redhat.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <f7a63428-5b2e-47fe-a108-cdf93f732ea2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0076.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::18) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: e46bc346-212e-41a2-ae4d-08dd65ee8f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cENoTkF3ejZQOWRZemZuWkpTd0tHUHVLSWp3TlNBdVdtNlRjdm9OZDhIa0Rw?=
 =?utf-8?B?VW5sNUE1ZjM4ZDZSOXU5QzdEeTdrd3ZRbUJTUjVqN0xtVCtCK051WmhPQ1NU?=
 =?utf-8?B?am5lajViMVRXaHk0Z2FhdTU3VHFBSnljVGxtMkNOTnVRbHo2VEMxalp3OU9X?=
 =?utf-8?B?c1ErTnRTazFTU1Z2SENDSnRSL1oyOTExbjZtQ2lweHlXQUtWNkF4empZK3M2?=
 =?utf-8?B?dytVVDZRWnFrVnFsVnhCNzl1V3NVZkRVZ1NudEtjNU5jalVNaDBmRHRPWnkw?=
 =?utf-8?B?bEtFb29aMnBubDN0cERGYzduZEgrNFJVbWYyejkrVjAvaUpKY3ZXUUQ0OWpU?=
 =?utf-8?B?U2FqUDRzUjFvdjRyR1lJbTRvbnpvWkRzT1NwWGVNeUtISlc4azlOYm1LWGFH?=
 =?utf-8?B?d1lJYWRpL053eEo3cEFoNFpIWThPNEpWWjlZcEhHbG5BVW5HZHBSM3JWWVlv?=
 =?utf-8?B?cXFOcGhVZnFQZlhFbzdCZHpVTGFVVnczc1R0VUc3RkRGR2REeW5rRU9lRDA3?=
 =?utf-8?B?MGdlZk9aYjlPeklOcEdjbzR2QTFTVG5OSlgvb0xLcEJ1Y3BhQkhGL2V5ZlU1?=
 =?utf-8?B?TzhCclI3bjRvN3JrbVZqcEJQTHhJR1JDNDNWOURYT2dHY2ZpaU9mVVZlS25m?=
 =?utf-8?B?eU10RmNTaUs5Mk5WamhkSjd2Ny9ZUDZaendhUlRWenlmMjhaS2dQUHFCL2sx?=
 =?utf-8?B?Z1EvdURrQ2t0N3ZJK2tXRlBnaExiU0lNcXpNZ0FXRzMwcXNQYkhWdUxDU2Uy?=
 =?utf-8?B?ak0vVEF1YUJabW9LNFc0SFRZMWNpVUZIbU0zWmwxc1YvVnVvTmVhbzNNSVdW?=
 =?utf-8?B?NWVBT0hsUWpScmFpYnNxb0tQTWo3OXFUMUpjZVg3Y082ZnkrMFZ5Y0lXQ2Qv?=
 =?utf-8?B?TnczWmNhRlhrOFVyYkFWamdPZjkxNTVWdnIxSEVmaTJNS3NOOUQvUC9RMkN6?=
 =?utf-8?B?ckpObmFwY2ZCQlppRnRoNGdTNy9GR0lwdXRtSTg5emZHZ2xPakJob1hWQmpO?=
 =?utf-8?B?ZVNlVGlXbG9uVWp4dlMyMkd1aVQrQTFsWDd4Y3UwMEVHVmRmQ05sWHM2d3Ey?=
 =?utf-8?B?ZlB2V1FuVjREQmE5b3VCekdSV0Nwc3dyUTByaW55RjRodW9FbDlKUjhWMFlp?=
 =?utf-8?B?OGtnb0N3NlV5L2JXUGp2U2NMVm9SazhQR3IzNTRpLzNoTkU1RERXMGlLY0h2?=
 =?utf-8?B?aXBZOUZaK1J4cEpZUjhSWmJCVUJsN05saUNoaXN0eUNTOGgrZjVBSVNSRERv?=
 =?utf-8?B?RTRWVXdqUHJQdG01Y3RTbnBCTkJHbHk0K3pmTHNaTFZNa0EzbXhKd3Y1WVJS?=
 =?utf-8?B?bkNzUVdQQ21UeUN4cGFKdVFQQlhQWko3MkpSNlVET0xpZnY1cmhVTWtxNzFo?=
 =?utf-8?B?VDh0MUFUV1ZuVlg2REkvTk9oM0Q1dDRMRnVXUldnOURQL2dyTkEwekxYNFVy?=
 =?utf-8?B?S0FQMUJCem45Q050UjFqdTVBS2syc0ZRTU5tUnQrRXBQL0dzVU8yZXg3bkhC?=
 =?utf-8?B?M0QyTDN1MEhlblNscTFpQWs5dDZGZk9GTVFWSG9wOUZZMExrWXpHbmh3NXFE?=
 =?utf-8?B?N3QxTHEwNXlzWTJPRVVuSEcveEI3V2pNZWxDR2toUU92YXE1Sm40cEkxVUE5?=
 =?utf-8?B?NlJoaW95UkdWLzQwWVlrVVQyV3ZXZ0NqbTNBeXg0dGFRZ0E4QmtLdDBvMlho?=
 =?utf-8?B?bDZjc0N6ZXViTEtRMEt6eWtvUmYxK2hvNjNCSGppbVNMUGJGREtmQ25ZcVBK?=
 =?utf-8?B?STcrelhUMGRqSWVESysyS2JHSy9RODB0alVjUERKQitXeTJNaDF6T2JhK1hU?=
 =?utf-8?B?SU9PbUlLcTJ3VW12a2F3MEtvRWlPQmFIVmZzb1JwZVE2UVhDNUpxOHVJZEpm?=
 =?utf-8?Q?D0Ax8wgzuoKS9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTBsalpzRG1raDdFZWFlREo5dGgvbWFVOWdyZ0NrR2ZzbE5rS1hsaFhGSFFK?=
 =?utf-8?B?bjVnWkxCZEJmUSt4TzhYVDZZRXZjT21rWFBSMzBnZUY4WXNzQXg5N1VxQkVP?=
 =?utf-8?B?MUVpV3FBQVJBalR5UXdOV0M3Nkl4dFN0OVRleUd3SEYrdm9odElkMTIvQ2s0?=
 =?utf-8?B?THROdEZ0Q3d5TWJvVUxNME1zV1dnczlFOFRlOWF3VHArOUVzNGpKS09OeDNs?=
 =?utf-8?B?cTQ4OWJyZGVPRkJCUklXcUVoTDVrMVM5aXlvSmJyc0Z1bUIrYXFyT2VTWHFY?=
 =?utf-8?B?N0ZjOG9PZTBGTllta0kwYXBqQy9pTHp2WXpid094R3VuMWN6dE9US1YrNXJH?=
 =?utf-8?B?WGhNVU1qd1NFdExCRE94UGN6bGpGcjFIT2VvdVRTZGFjanNTalZET1ZTWVVn?=
 =?utf-8?B?anExd05QOEwwSS90d210NFVXbnJ6VHhDaEVzYjV1ZnI1SjNXcVdXeCtSUTI2?=
 =?utf-8?B?RHRYZXdwN0lhMkx1bC9INjZHWGhFNzdYSWlWRlM4a1Q0blYyakd0c2k0WHd2?=
 =?utf-8?B?YlJOaUxCU0MxQWZlTU1xdzlaZkxZeGp2dVhPK2c5cDMxU3BiUldEL1o2SFFN?=
 =?utf-8?B?cjc0eEp0eFZ0dENhaVpMK1ZUYU1jZDhIKzdzd3BieGxCUEVDbmJnVHUyNlU5?=
 =?utf-8?B?a1lVaDRsWFpDcXh2SjlGeXdJbHpmMGlDNE9WaHpwWkdtTDdJUTA4OUlNVllT?=
 =?utf-8?B?RkpvdnplVENNSW9jcjdUc08xUjNGNkdVVERNUVBCR3FrMTRSckVSWCtDMHhZ?=
 =?utf-8?B?R09XazNQeHZUY1VhaFFZekV0dVdZQ0hWRCtIaVNycmFVVHgwVFYwU05SOVFq?=
 =?utf-8?B?M1NVTnRTK1p4MnNLbStFTXByS0VLRFFhOSsrcEdsclRHejZwaEtNR0RCd3Bs?=
 =?utf-8?B?M2RlWG9rWTNySEV6RVk3QjdWcHZlTWlqNi9aMWpiQmkrbC9xeWhJemZkS1ZK?=
 =?utf-8?B?T09TSTdIY3hWcGgzN3dMQ3R1aG50NFZlaURnajI1OWNoV1djQndEWmhDQmtF?=
 =?utf-8?B?RzBkRHZXMzFSa0VPZFZNYjVjMjFPYjNzMGltYnhkQWpVNFB4SkdGcXA4bGFw?=
 =?utf-8?B?VDhNdFQ1QlFBV2hTemdmMW1iU0FhQ3dCc1hMMXZtK2twVnRWblhKZ09vdHYv?=
 =?utf-8?B?ZlkwR2hUSmRaU3dsMVJIWkZsamZ5SEtrbjQ0clAwUDFxV2d2SFFwdjhYdnNS?=
 =?utf-8?B?VnNjTmlkaU42QTZ4Zm9ZSEJIcWVaZmtEQmsra3BuUEhrN05pN3crMlhBaGFw?=
 =?utf-8?B?Zi9uUGhTQ2Z4anNkTW5jZzEwSGNpdmpUVDFSbEQ4WEFjdlZzVkRFNVNEaU9M?=
 =?utf-8?B?TmlBcGpERUxXL09zWktKc0xpK293TTF6OWkrY0VQT0RCeTJqdWl6VHF4bldM?=
 =?utf-8?B?SkhmbWp3bkRaYk1NQ1U5dEFKNTBrdzFuY1BxK3JGWGUrdVlvMWorbFZoZFMw?=
 =?utf-8?B?TG50RXBDNnRlc0wrQWdjYXNGdk5NandkbndHR0VqUzdLVG1uYSt4QndQZU9O?=
 =?utf-8?B?UWd5NEtlcXhVeEp3djdUV243ZlRZTDlUczVrNXlWWXV4TGVKblAxQi9oSHMv?=
 =?utf-8?B?VlpDaWg1YnptNnNqU3ZEQWhqSE9aNHdKVWtBYTZEb01KTmkvTVlrUmc4SFNi?=
 =?utf-8?B?MDY3Vjcvc0tHVWtYcDNtUzNDT3lCdVpBM0o2WkhTU2NqckJSeDlZZEV6amlm?=
 =?utf-8?B?VUZJSnZ3YmgyV3BkLytQSTE0MEF0THlwdWM2RTVsb1psRm1MOG1mdlpvVWs3?=
 =?utf-8?B?d3ZZTU9lZUpRTHVnTE5RcGV1S21qZHFhM25UdVBHcHZ1ZW54NnhhODdFalZq?=
 =?utf-8?B?am1CbDJSOHd3djhPRkZxYk9XMVQyQzg0Z0RGSWZiZ003QytXeWpxVGRZS2Rp?=
 =?utf-8?B?VkJjczhKanBxM2hwK1NKVjVPMGZWVWtDczVlU0FvTnhFODRvdDN1TFBXRGhk?=
 =?utf-8?B?M1gwOFcwQlpaZSs4N1NuZ0JxV2NJVHVIeHFRNDViVFZBSjdOdERvVDZIZ3ZH?=
 =?utf-8?B?UUcrR2hyZldUQUFJQXJvUjZCQk5FZXJZZGNUaVNFYjBPT0VZQnovb3FCWW5I?=
 =?utf-8?B?L2tlZzM0L0QrMVNFM3p1Q09oanQvUVJxTTI4ZkxSMEZkRmtPUEUrdHBYNjRD?=
 =?utf-8?Q?jazX9HlEy/j1c3e1DV3kYR3gF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46bc346-212e-41a2-ae4d-08dd65ee8f05
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 07:29:03.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 909XL0w651qP6OHA61mB635UOvcRJva0POJWcmhjTCbj6O/5u78HalWLtw9Vl9yO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094

On 17/03/2025 22:19, Paolo Abeni wrote:
> I fear we can't replace macros with enum in uAPI: existing application
> could do weird thing leveraging the macro defintion and would break with
> this change.

I couldn't think of any issues, you got me curious, do you have an example?

> 
> I think you could simply add:
> 
> #define FLOW_TYPE_MAX 0x1f

I preferred the enum so it would be "automatic", anyway, will change,
thanks!

