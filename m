Return-Path: <netdev+bounces-233805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D288C18B74
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9A83A467B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC912D8DB1;
	Wed, 29 Oct 2025 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uii+usbU"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279C21FCCF8
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723228; cv=fail; b=S3NHIAIt8WH/rS3IODa3e9JKXJOKAOY2jWcw0o0NgrKsam4a0o4eU2urje3qQbluGJ/+ibpN8pV1MEGNW8IhB54lQMY2z9s7J5bRzuM0grlAZydxRHjMf9VtnwWK3LLBg9rUhjNs1HnajTrFKszfusWKtRMwHMzEoZK75dGYzJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723228; c=relaxed/simple;
	bh=qDnECX+Uyo9h+xKK2G2ZDvZMgd8FELkgGVmTSDBfYq8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jExVLPBye6f9ze85ArULBDLxGKwyoJzjQtUeArAb00F06OdGai4iOH0b7XMoIB5EXV00rqNsM1Kz6AY/gHlAqp9nEkWbO1HWThd6asvKsBywAcA9PqYu1RJ+sr0NnH0dkzdpRBMVuoWNNrlPh7agNNVsldt2SvFimf6UgumfhAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uii+usbU; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py8/Dk2SBemyq8e/hcOoXzDAIM5bdWt4B1lIevPU0niW9hNNzThgVohT9RfzuuTM8pSSnPd8hVRrGDEk1Sg7MDNOT+PrlKt6sL+3XEdpHiIeXand/BIpe5jNrzfi5dGDJ/jYBVDvvIWXzbjS3i36vmDqXA71fcnzGz0eABfqtUqJxHnCaNWgIdcw2F98lweIsBvmd+CwEfMe2fMS4RduFR63ADSBWPQqNaKuRzqUvQoflOjMnNKEsG5x+AyAco13ohegfV7lbzlZKp7AnUqfJeveecaxoXOQ+GUdAufCAY0ea2HtBc0jce6MjqGVurmXClr9looABkGSZeFuCEi9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMvJlTNolSwRc5uh5B0T6zRaTnNSWN/9xlNvVJdIdnY=;
 b=MZNUmUaY29QWEREcO82GQTX7k3UEZ1xZHTQcYLrtKSYLm7s84eLeIgV2mmd88bYnvdidsMW467S5BThWoyBY8auix53RiaMIFcYLGd+/+hllMQZ7Da/dfKsA0gc9Ty3jz+tXxT+JCKHPamiDE8C6RJcamok5HoGNBLtysjTElEwbwngP2wq0Cii6rcG4srAnE2XMKWMCEhLWfyyiV2tNgbHPfqJNU1dXGx2uJEHQQaLwDeVC7aoVct0hOgWSKKqipB3Keoz1/oYwHsMBIYbxRrH9si0VuzFEpUtXWI+Kdzkl2+vq4/3j3xiarckzPnWXyYooEgGmZTGI4jV1g0xLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMvJlTNolSwRc5uh5B0T6zRaTnNSWN/9xlNvVJdIdnY=;
 b=Uii+usbUH7FGR0OOQRMWjFiXCmAdmzl+NUSueESVrY7YapLZACjUvu5j6M7jSvZMmsqEfvkBtV2rHICYoZNYDKAklsoSOLdR9/pu1z7Y4n6Y7zqa8ChAEO7qLiaXYIHTc8e4EeZ7waAX8NM9TUg6REAq3AoOjHlib5OXx8gp++Ig8ylqcUZ/jt+R4icGrk0L8LYkKoh0Fk4kxKqUyydrHilKQiWuOpkYnk4n1SHtmZPQJVVjVKVEM3GzrsaTUZM6I7c2RM+41izFgVc5AT9WU9SpjpnbOOQnS9XVkwdo3YlqiMktXrvQw+mXp1iYXCNvvXTEkTJAnk1rsNx8iJBrrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:33:44 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 07:33:44 +0000
Message-ID: <3edcad0c-f9e8-4eeb-bd63-a37d9945a05c@nvidia.com>
Date: Wed, 29 Oct 2025 09:33:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net/mlx5: query_mcia_reg fail logging at debug
 severity
To: Jakub Kicinski <kuba@kernel.org>, Matthew W Carlis <mattc@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, ashishk@purestorage.com, msaggi@purestorage.com,
 adailey@purestorage.com
References: <20251028194011.39877-1-mattc@purestorage.com>
 <20251028194011.39877-2-mattc@purestorage.com>
 <20251028154330.6705d2da@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251028154330.6705d2da@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 12afe034-8f2c-4d02-a160-08de16bd7d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3E1S0NMeVlBOTRyamVCZjV4ZCs1b2xtMlFqa1pkWU9WL05YekpmWkU4TDU2?=
 =?utf-8?B?aEhPOFVvUUtHU2Q0RVlkSDk2VGMyVVJFdXdTbHlnU2N3eUJKcGxjZ1JvMkxs?=
 =?utf-8?B?R1AyM25IZm14REg0YzJsMlNsRzlNOUdoZ0hZUjVqMENXdEFMdnlCZ0g0MTc4?=
 =?utf-8?B?a3VZdFVOaWRsNVFIYWFhQTd3TXVueDMvYWg0VU1ubnYxRGZxbkhCaFRnV0Nz?=
 =?utf-8?B?SkYyQ3d0NnZOMkloWlpPRXI2d1YwVUFhWHQvaUtpTkN0dVE2aTVtQVFycXZl?=
 =?utf-8?B?Q3VrQU9jWjNzN0xENmhpaHh3bHdObStEQUg0WTFaMUhsUi9PTW5vZkdWZm42?=
 =?utf-8?B?aFF6UjNGL3U4YzV5elllZEhEOTlydEduR3dnQ1E2QzVTdEVxL1RZODRDY1ZH?=
 =?utf-8?B?MSs4aEJVa1J0NG1kSDlkMXVCTElXNlNCazFnai8wM2srU2t0WjY4YUU2cUNX?=
 =?utf-8?B?UVZDcWVhMTYxaE1YWlBtdU9qM3p6MnlYWFozMjFUclZFV01pUkJ5ZVVlMkVx?=
 =?utf-8?B?R0FmUXo2UzY4Yis4NGVQVEIwUHpzeVE3aWJkODhCQ0cxV1owQ0xSZUZRV0p2?=
 =?utf-8?B?S2Y5NklPNUEreW5zL21MMGRkV2NubFBYbVpGRU5SZmVCQ2VJMEU4b04ybmJS?=
 =?utf-8?B?aFZoZVFnMFV6ZFFMaHQ1UjFLMVArT0gwUGtIdTFMNWJ0VTh2MEtSOFhhS25t?=
 =?utf-8?B?S09wa0ErOGpNRnNvckEwNG13WVJPNndaMGRkdmdFV1dEZzJzNCtPWG9JRm40?=
 =?utf-8?B?cmQ3R2NGY3NPTmQxNU94YWRGbms1L2l4QUZsdE1sc3MvTjRTb0hzQWpFSGlD?=
 =?utf-8?B?aW01VXJsUUhzaVY2NU5SN1JFT256dzhIcEZKYXlZcGRCS243R0FtZkN4YzdK?=
 =?utf-8?B?SVc2N1ZGN0gyRWtWWWt4WEtHVGhhUGU4a0J0Rmp0M0tMVGJOcHczeHlWbzJa?=
 =?utf-8?B?TytjM01SRTQ4S2RHcWN3TTNXTVpxZkxiajNqNVV5L1UrZUk4RGpYYWsyUldV?=
 =?utf-8?B?Zi9HbSs0UFJ6dG84a205dFl1RzdicGFWNVN1UE00Qys4aSsvcTc0dElKdVh0?=
 =?utf-8?B?RnNHeHplWXAwd1hQUmhxdzI1anhwK25XbUlIZnA4emM2NE9oNXRkN0M1OUZK?=
 =?utf-8?B?bERjaEJ4bVZ4bVFIYlE1eS9ZUXMrUHdsY2Z4blVjSzVwTmNTSzdSWnpGTnhJ?=
 =?utf-8?B?U2ZWbVp4QXhyZGRMZWFkY1FzZjhjR0JzWHN3Vzk1NTRVMjE2WHZlSWtxaDBh?=
 =?utf-8?B?cVd0bXdYODZ1dkNIRy9jT1Nzc2padkM0V3VGQnJDY3kvZWdId2hESmVOcTBW?=
 =?utf-8?B?RjM0TmQzNkhPcitKcW1ld0tNSWM1WVhwNHR2dVIrOUxIZ05SVHh1NHgzVFVO?=
 =?utf-8?B?YUNJZnFEbDRCOUY2ZzVuYkpzZHFoZ2hYamE1Q2tFMGxIQlRwNEZjRlZFTXY1?=
 =?utf-8?B?T2RLaW9zcEE4MWJsZFZtNWZISTR1eEZBbVVwUFcvVDVCSXJkTytEUmI1OC8y?=
 =?utf-8?B?UU5QN1hqOTNEcDYvQkp0Vkk1Z3ZQaWFHaE10MHpPK29ML0pPelU3anBWTm10?=
 =?utf-8?B?eDJ1QWcrSTdDK1Jhd3dzc3kxK0JEZW9IMjJkajJ2T3FPaFJZQ0w0M1NXVFNi?=
 =?utf-8?B?aGYzQ0M1MGIxeTdDTzFnWFdDN2wyQmdBRm1uUnZQNVplaTVaci9ockxQZ3Fs?=
 =?utf-8?B?OFE4NTB3ZnEvTTZqRFpXRlI5dkpsQkJlNm9YZDJmcEkyb2prOEo2T3JHRk1n?=
 =?utf-8?B?ajJlVFN0WURhcVZRRi8vTlNjSks4VmJGTEhmRmNVOFNwRjNja3ZXUVpkNWdS?=
 =?utf-8?B?UzdHZnpXL0RnWlFsYy9tTEtvbnZ3V3NYYkZSYmNEMmV0aXJXN1VsRnNkS0Fw?=
 =?utf-8?B?SjYrQ3FxcTRWaURLVkppWjUrS3VQYkc4cGZDSG9yNHBWTmExeE5yMlFOZHVu?=
 =?utf-8?Q?DkYF8hY1ttUMAJhnklK56b3cWcYh+WAl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHkrSCttNjBGWEpCbUVTc1FlVEtMVTREazZUL0tIcXVFak9TVndERkxCem5N?=
 =?utf-8?B?WGd0bGJwazZka2FvMVh0MFVDQnBvVDJtTEt0Tm9rdEJaT2xnTnNaWWhwM1da?=
 =?utf-8?B?UCtaYzJ4S3BBUGw2aDJCTFloelF5RXlxWTZWTElJQTl4dWtzVHRaWmNwK1U0?=
 =?utf-8?B?US82OGl3Yjg2Yk1NYlhBT0hscEYvZ1B2blJoMVRtbjlhWHF6UEoxUWVuWTBW?=
 =?utf-8?B?MGxuUTFXVEhvbTY3R0d0a2NVTnJ4WlFGbE0wVC9vMThlRWdUZVBoWSt4NnY0?=
 =?utf-8?B?L0FJUmpjVmd6Z1ErcmtBaG1IYUdNcXc3cFZLQ1VIektrK2Vpa041Nk1vU1Mr?=
 =?utf-8?B?SDcrWnZha3NpaUkydzhxZlZPcStTVmwwbWZOamx6cXB3aENpSVQwY2d3NEtn?=
 =?utf-8?B?NHgzOGtvaDNsUStoR1lKSmdzalkrRTJseC9YSVV0RmU3V2o0bmVNWkFCYXM2?=
 =?utf-8?B?QVNWUVBPSEhNTHpCdEV2enZtc0tJOHhHQWdUWlMzTXRzU3B5Ny9JWC9WekFq?=
 =?utf-8?B?aWFxazEzLy9BVWt6NytuU1pWNEhkWFJsMVdJY1ZUUEVvZnQ0WXhFZWxqK0E3?=
 =?utf-8?B?OG9kOVg4eklsRGR0RW56M2lWeGlMR0pwMHg2Z2RMbXFUQXBQY0pFdVpvaWVD?=
 =?utf-8?B?T3pIejlZNUJvUnE4cUFVZHIwV0gvbDg4ZnZQblhMYktRVlorVVpNcUl6ZUxM?=
 =?utf-8?B?bXNrcG9MaW1aRmJqRFIyQWtBYjVlRDQyNnJkeGNxa1FHUVVtOGhvWFB2Y0ZQ?=
 =?utf-8?B?aWQvMnR1MlBuYk9CTkdjRWlWbFJHZHVjZ0Y1c0U3UmltNGY4Si9aUC85NE1s?=
 =?utf-8?B?Y2Z3Q1lOdE1OUHNmUEljUWNQWXBqQ1JzN3NYbjBDODk0WFVWZXI0aTg0cjll?=
 =?utf-8?B?Uy9iSWgzb3ZEVTNVeS91R2F0bTlGSzVvOEtVNHkvRnVmcEpDZGo0ZSt0RDJN?=
 =?utf-8?B?ekIvTCtiMjlEUS8wemlsMGRicEVuVlpWSDRNOE5wMzZYS00zV0tJNHlMK3pY?=
 =?utf-8?B?TnRkRTBPY0svR2p1cTFpNWVJbWRxWFNlY3pNdFQ4U0xERDVXUHB5bW5GNE5B?=
 =?utf-8?B?czdjcUxHMGZFYWJoTUZLLysyT2hOSFhSNnduZUJOdGt3MERNVzJZQnZoeUEy?=
 =?utf-8?B?Sy85aVZkSWxiWk1iYkhjOWdqTDluT3ExRWJzVEZ3RktGTmdDTmNqOUtPYkVw?=
 =?utf-8?B?bExsQWZZa0V2czYva0t5cGQzcVdJd21uNGVzbFM2SHd6TVcxMU9rYW5OK2tR?=
 =?utf-8?B?MEZITE4zL3hEZDJSNnNaMDZkbUt4UVFiNHFqVHFVV2NaVGI3a3ZHNWowUy9Y?=
 =?utf-8?B?cERxemxBRlF2cnlMVWoxRVZ5UEtsUnprb3NQbDd4SXo0cStSMlRvbVZRVEZQ?=
 =?utf-8?B?SSt5SHZwQWthRUw0Mk8rR2c3RjVPbS9veHU5T2pXcmM0anc5ZDJVRmpkNzI3?=
 =?utf-8?B?aDNIaHVUTGkzazJsNDYzOC84VzJRR3Iva2RLVFF3QWp6SzcyQk04cm04NVMr?=
 =?utf-8?B?dHFMT3hUSmRLeXpLaGsyUHRwdXFNbk5uVzYvc1NaTDBvbHI4cUtSb1pKcWUz?=
 =?utf-8?B?R0JrK3NoazZ4c2pWZnYrTVJMY3lMWkNzL0V3bUxPSzJ4ZzF5Qkxma2J2b2Na?=
 =?utf-8?B?d2tCUmhMZE1KYnI3Mm43R2IvV3dUZkZTZW91VG1wQjBlRmZXUzFZdkJnQlht?=
 =?utf-8?B?amprYTU4ZDNFaFhLaEQ3WmtwamxsNEV2ZU9lcU1GaVNCWWJkdHhVY2pLUzlS?=
 =?utf-8?B?ZGdSUEtNV3c4QzFmbEplTXlvUHlHZUtyR3RkRDVqRjdvMlZLdGJKdDZvbUds?=
 =?utf-8?B?ZkdMZ1ZUdk5oV0pURVJYaUUrZDlDdDluNWN5NUtJSlhUTFExQnZUeStQdnIy?=
 =?utf-8?B?RFROcEduRVo4NWkzNjdTL2VpV013K1U1VU1mbnZsdXZiYm5rQUg5bVNmNE11?=
 =?utf-8?B?cGFaTTJNOTVQVkE4UVhrRml0YzNWMCtBM1pYMFdzQVVNV1BVWXdmQWRnb1dU?=
 =?utf-8?B?YlZBbW1RbElsa0RJMVhsamx0Um1JQ1d2VDRQYnBKU0hJbmNaYmhScVhtd3Fz?=
 =?utf-8?B?KzZDdHZDeTdQcDVETisxUmI2NGxyRlE3cTZRUEpycEZPNGNQdkdwSGN0YVdi?=
 =?utf-8?Q?ZBoE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12afe034-8f2c-4d02-a160-08de16bd7d15
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:33:43.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsbGRXhtOvYPvQjI//kODZCam1xPdUsofsdrNZ8DJ67LbT3OSPCrmgiUbHwzDHxC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707

On 29/10/2025 0:43, Jakub Kicinski wrote:
> On Tue, 28 Oct 2025 13:40:11 -0600 Matthew W Carlis wrote:
>> Whenever a user or automation runs ethtool -m <eth> or an equivalent
>> to mlx5 device & there is not any SFP module in that device the
>> kernel log is spammed with ""query_mcia_reg failed: status:" which
>> is really not that informative to the user who already knows that
>> their command failed. Since the severity is logged at error severity
>> the log message cannot be disabled via dyndbg etc...
> 
> +1 from me FWIW. I wonder if we're hitting this on the same class
> of systems but recently this started hitting at Meta as well.
> Millions of log entries a day because some ports don't have an SFP
> plugged in :|
> 

Allow me to split the discussion to two questions:
1. Is this an error?
2. Should it be logged?

Do we agree that the answer to #1 is yes?

For #2, I think it should, but we can probably improve the situation
with extack instead of a print.

