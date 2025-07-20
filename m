Return-Path: <netdev+bounces-208425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C75EB0B562
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 13:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769553B6FA8
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 11:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6011F5423;
	Sun, 20 Jul 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sCyspO2s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7551F4621
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010112; cv=fail; b=gQPB7tYjPFUvLpQRIYKbdL0Cy079jfhGvDqgxCu2dusQA5YdEqP9gOJRoNuJ/f9e70v6qBY7zpj787DlCFyIeOLc98JQEV/zq3uVVARghmN8aKW2h1MyLw8XN2MEen5wT0orKhhl/Qy6+INDdeMsWm9rirL2eluQdOMKfFDJVN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010112; c=relaxed/simple;
	bh=cUTvBnm/BBXgZcsDjrcoAdkyZN8w2g4s6bJpOP3Xjcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZzZoyuaTtUSQuqUg18ktGNyGXLS+D3L9yiU/3DVZhFGseUOh1m83dEKmscWiLRw7Mh3fgAwbDEhSilewVAUrHFLbbanL5ZhKlYToyW5WsZUy9O4RSFerU7udEr7Rqalyyv1+axV0EFkmcKDnMSZe0g5JmTGMCIjsqeUcp3EJWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sCyspO2s; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idjMzR5qNDatz5TJmOY0Y3Gan7jI/a9b58dyQShsWWPJvYvqHJcmhycLZHemQdzYJSS8zQLY0cXy9QFJFNtYxDnLhuC9vJ4lcvpPju+GvFKkq3gtVBVjzEVNH+VkdHqj7U+SEo03S9QwJkh50aNa0vAouTIWT1uwrqS1+2ofILwxZcCHOxW4baHks4DWTebv0VW0kcsRNOKvWGIRYDljw0B3gOntE6YBRN0UDTnQ828IbKSskPaMFvXJCKApHQNRLpaXrRphN6GDAXYVxrtOxkT6IfRl6eTaCBm/dOaVnlyairHtyScLqkgSSj0hsinG0VwQRksO9b8CBUFbuESWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYy6vYgQRYWu1Ib510FX820QRBIWKXXVS/ta7xaXf7w=;
 b=SY/OVzzrxXzsCXZYz8Q2jzNCLTJuUksAyfNTGYCcyrAE/Oc/9RxPp8/SlNy2z7uwRER4cQOHF3653CdzWB39vRZtKcgLri2E9GK4cesnKeopihnM+0kOQUBNqQCNffn3nvJhxX2KRBI5pespr1AYXXQ8p35a2cZj4OsKI+0k0//aoy2eRJFDazNYFe+dfdZlyrVuYzBHz0Q0mKvFYNZs758itM2j2pn36Ke1eGo8NV5vtY8wpzLbueGXZCV71t6N/Hd9HZJ/TEJkkKpSUpZ5d8vOT1jLqwxiGiSd9qdvnBAZo5KOVKRveKNKm1sxKIhHTO2Cfb2fRUTChExvgXDqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYy6vYgQRYWu1Ib510FX820QRBIWKXXVS/ta7xaXf7w=;
 b=sCyspO2sRhnkzBd4xblhCeT8jEawy6phne9Wza0f6mx/ugmx3AUZewXCXDtwsGN6l+AoXD3VAYJgkXV9+ulHAOPzVWqygfRpCBQkUU/WFUQinmuoERegltyze4DXjpAutWpmakUdNj4cI8amDQUobuUJlRlq6Yrney3wLGLdr/EtHUzEpf8wvpsuUoTjC9qrrHmCPNvT/r60YDRhHn1r3QjRxUHYLInuSUrY4fpE6X7Xy408TtkbzVbFuI58uG8lInugKJNIVtxHbT2IThJXabQ9qncJ4rwwzzbGIdJ151BxERn+16x0yENpYhDrJ1HlViCr/kbmFgMz+diXIdI+jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Sun, 20 Jul
 2025 11:15:06 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 11:15:06 +0000
Message-ID: <afbd3445-a4c2-4000-b3a2-af299267fe69@nvidia.com>
Date: Sun, 20 Jul 2025 14:15:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] ethtool: move ethtool_rxfh_ctx_alloc() to
 common code
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 ecree.xilinx@gmail.com
References: <20250717234343.2328602-1-kuba@kernel.org>
 <20250717234343.2328602-6-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250717234343.2328602-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c411ad-1506-4f2a-0ea1-08ddc77eae39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXNJeHRGL3hUVnRaOGJvZDdwd1FzbzcwL0I5VFlUd1RqcjliVWZqL2ZBb1B4?=
 =?utf-8?B?dkxyVkpyY2JnNWxYY1FnOVFKekRsaFgzOThnVFVmRmFIeml3MTgvbHJUVlJO?=
 =?utf-8?B?VjdTdjlXMVZ3ODR2ODlMQ2hVNDhlT1R1SlZaalo2TjVVamhldXhSV0tUZm5D?=
 =?utf-8?B?Nm5PU3Z2WVJUTTN6L2pBRXBUT1B5SUVCeWJYbFVmZnpFQ2hlVUU4enRiL200?=
 =?utf-8?B?Unp5WHZ3RVFWN1IzUE5UMHZDQkxvV2h4bXIzM05xZ0xDdjFuNkhsa0FTTVRm?=
 =?utf-8?B?YWtQZk1UWTlxdFNyMHBUL0VNUS9xUERUK3RSYjZGQXpRbThPVjRnZ3BxcGw3?=
 =?utf-8?B?NjQ3U1lxa3gxdmI0djdJZzJCaDZMTDZZcTlPYUZ4QnRVTmdoMURKcytLZEQ3?=
 =?utf-8?B?M0taWFVzK1ZjMWJJbzR0VHV3SU5Ua3FuMGhtM1ZpTUFyYW9tc0tqVlR3RTg1?=
 =?utf-8?B?TERGemxyZm4zMmhHK1kxUFFqMHRxUDVQbElLRkFwVi9KUHk0cHQzR01idmh4?=
 =?utf-8?B?OStyYUM3cjVPemVjUDc4MTRNWGlvVjV1RHU3M25rUktpZ1FQdmRPOWdBUDJp?=
 =?utf-8?B?aFJIQS9XNXV3STR1RVlDQTZTeEZMQTU2QTBadFU4YTVxMEROT3ZXelRGMFNu?=
 =?utf-8?B?Qy95VG9sZjhCK0g5Tmd6Z21sUk01K3lxeUg0bTF0Q1BLblFQVVVTb3hHeWI0?=
 =?utf-8?B?K3RvN0ZCalJyVUEvNTRkd092bStWWDh4UDcwWDRLQkF4bG5LdUxBYWV5Tm5V?=
 =?utf-8?B?azFMc2JRWHhrdXNVMnNTZGRWZ1lQL0owbmpGNG5GRHZla1hZS1BwM3F2dzZJ?=
 =?utf-8?B?Y3BoV2J5RUhEa05qNXk5c0ZvMzBUNnhoQUtOQzd1a05WZ2FtQXlPT1kxT05X?=
 =?utf-8?B?bEJYTU1mUHQrRFBURjBOU2Fwd25vcTQ5R20xRExUejh5MHVHTlFxT2o4QVg2?=
 =?utf-8?B?Q1lpdjhYdWl5cGloUTdCQ2xPb3RjekxmdHY0aXE4N1l2N0R3U1kyWjBacmE1?=
 =?utf-8?B?Z3hHNlU5WEtiVWNtbzl0WHp4TFd5M2JBNkRGSktxczA0UC9rTjFoT1dtRHBZ?=
 =?utf-8?B?REo1RXhtTzhFQzJnR0t4OWpKUksyOFc5L1JFYTdsbXJybTFQaERVYk9Kb2xZ?=
 =?utf-8?B?Z09lUmh3bWhHRTVlMS93Q1BGR2RHNDFaTnhpY2UzOEtqOUYxYmhDYmRLZjRP?=
 =?utf-8?B?dENyU3h3ZHh1NUdicmF4RnRpWDdOdGRId2Nvelp1bkpyZkVET2VBdDhuUVJL?=
 =?utf-8?B?dGZPcjRzNjNjaldoa0JvQUFUYi9LMlp1bGRGVFQ3ZVN0Qm9GWVVYQmxOZTlD?=
 =?utf-8?B?VTFCTkgyejZOSzVaWjRZR0JsSUdKSVJzbE9CUDJ5VW55V3lVMmlWRUVWSXRE?=
 =?utf-8?B?aG42dnFib3ozZ2trdTczbklYTW9sM0FKSktzVUZPTVhZQWc1MWFJbjZ3OG1m?=
 =?utf-8?B?dVZKczJ5VWo2QW5VVkFLQ0ZPOXRmZGNYdkgzM3krY3EwbmM2eXNQbFBvZWhG?=
 =?utf-8?B?Tjg2RHJsbndIVXFmTU5qRVR5RW5yU29kdUtuRTBxZkJtSmc4V3oyaVZrZVVT?=
 =?utf-8?B?TXdldXAySWhqck5qMWhPVW5UYWkvdVB5TDlsdndtSTAzUHV0a2RpczBERGNO?=
 =?utf-8?B?VXlScFUrcm1ucVhpaU0wOVA5NUFqcjVHYU44Q09XZFR5eEl0MzVnV1hLQnZu?=
 =?utf-8?B?RGY0MnhKRFR1YXNrdGRMWFdQY3BNdnE3ZEhwNTcyUHlOeUMxc0YraER0azRz?=
 =?utf-8?B?eWZqM2YzMUNHUStzRXR1NitNT0U4MXdKU01GSlYrdWM3ZmV6MWNGRy9TZGk3?=
 =?utf-8?B?TnNCMUJNRjdoYVZZalhPZkV5bDB6YVVuRFlYQjJrS3JXTTlURlZXNGFWRHBj?=
 =?utf-8?B?UjhZNTNKSHkrQXE2a3BTaDFGNkgwNkdxR3IzNzJBVnllNGZhd2RtMlowY3l4?=
 =?utf-8?Q?TgCicISIMqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2orUGZWY2lEQnVxQWtTOXRKUmQ1UmMzcUp5MEdQekVTYzMzNmc3WnhQS3VH?=
 =?utf-8?B?RTcvUXQwSStmNjZSY3BhQ0Jabnk2SkdRdCtCRG5DeXdmQktTZUh2dXlDUVh1?=
 =?utf-8?B?aXA2SFpyRDZ4cXBFNGo3NlUvNWtBY3orWW8xbzlxUWlsRmRaVVFpTmZGZVVK?=
 =?utf-8?B?Q1VLaDZFdVNYNWp3cDhwSWc2dlNSeU05UU1ETmxET2pDY0RNVlBVaUR6SmJB?=
 =?utf-8?B?cTFEOW4wSHFOMllza3FMZjF6Y3NWWFpMWnBmbWdnUE9rZlZPampvYzVkdjZ0?=
 =?utf-8?B?b2E2SXI0SmtmQkdlM1pHUkFob2Y0RE1YUVdQa3JjOTlIdENwMkJkZVVPSEc4?=
 =?utf-8?B?UlN3Um80OGk3eDltS1o1Z2YzUEJBV1NnMjlGOGhGeFIzcXNYaXoyUDVKbUt2?=
 =?utf-8?B?VjVqZGhiVWhVQ015QmhlbUpTa1dHaDN6ZHFxU0VjTUdjY0hvRjNWNFZyWk96?=
 =?utf-8?B?Sk9sWkpHM1JPU2RjMWxvNmJJTytSV00zR0Zld1IrMmpSSHV1c3lXODFFQVd4?=
 =?utf-8?B?RXFxVkViWjJoRk94a2hSTEEwZG81THBsM2JuNXBSam51UDV2MEI1aTZGVjRp?=
 =?utf-8?B?UFlhWjlxZHB0WWZxcmw3RXQrTXpoTFh4YjNJVVVFRlF1dUgzYVRqSU5RT09u?=
 =?utf-8?B?RksyNHJiUUlKNURUdHlpMWdqWU9lRzVQYkxtVXdDUmNKYVFaTWNNQm9Ya0U4?=
 =?utf-8?B?QzJXNGxHYnBVN0VXVWtYQ29Qc2ltZm5HUEkxV29rcWZWWDJ6RmpUa0V1ajdW?=
 =?utf-8?B?RjYyUDhScFhXMGZSd3pPQWg2TDJQQzRCZFI1SDJQaURiYWdxQnIrVDVQeFpt?=
 =?utf-8?B?Y0JrOSt2RHp6cnlhK1N1M01XU1BEQ3BkWkt0SmxVYTlFdndsaFVZTUJ4anF4?=
 =?utf-8?B?cmp6N3dObFllY1A2bW81M1lRVWhPV1p1K3JXTUdpOWJnY0t2akF2YTBYNys1?=
 =?utf-8?B?YlVQQWRPRC93Q0R4UUV6NW1OcCtDQ3I5R1ovcDJZblNhWjkwczIvdC83N0RT?=
 =?utf-8?B?eTE4TmNIdEgzbDZIeHZMMXNZd1Q1RTBCSjdiWDByR1p5cEpBdXFmMGw1NGgv?=
 =?utf-8?B?VFpQTVBqZnB4YzJma3FPM3ZkMnhmUzhBUTF1L1BWOEg3WGZ6SS82R2pEUUlp?=
 =?utf-8?B?RnJjU2U2YmpFTE12S2dUNkJSS3hKbFdnbW1POHFpbHd4YnlWYlB0a0RBeXdo?=
 =?utf-8?B?NVl2RDVhL0pVdUxEU2FWemxLem9JQ1dzN0ZjZVRUTjJEOFVMbnErd2o3dTlj?=
 =?utf-8?B?RkJzb0xZTGprQ2RjNmxubWFiQXVoVW1WRnp3MC84bW1vcCtlQWxyQ1V6aUdI?=
 =?utf-8?B?WmU0VEMzbTRkSTJ4bkpuUVlIR0lpMHptUGs2UnBkQTlETVUzVmJRdndaa2pl?=
 =?utf-8?B?ODgyWkdFTzVRTmtKS1VtaTBJMFpUVzJxbE4xWEZiL3Q3S0hUV2tRWnRrSW5u?=
 =?utf-8?B?TE9XWmpQOTl3c25zN01pNWVhelFyU0tSTC80dVVXRzZ5VXppajFNVTgxdDA1?=
 =?utf-8?B?d3pSa3dYRm95dU1VUlpPeXhZeDNNVEw5T3RDbHhYeU5NMFRBTTdja1dEcHZB?=
 =?utf-8?B?TnJwRkp2YVV1bGpQUzZkYzNBT1d6cjBTOUlPS1cvWnh2d28zZ1c3d0tjS2Nx?=
 =?utf-8?B?TTYzSGcvL3FtM2JXZ29NNjNGWHVFN2JwM3kralk0VnRsTGxGZHdhWGZPL01k?=
 =?utf-8?B?QmI4eGtQbGFFbUJoM0NiZGdpS0Y2U0dzSFNLbDhEZlNoYkYzalRid0hrMU05?=
 =?utf-8?B?LzJLb0lWbzJiTjkxOFRod2tvRVluVnd2eERFWXNKUFBlVXBpdUZQSndXbWJq?=
 =?utf-8?B?QUlQbll0cGQ3Zm45NzR2QUNFc2xRajQrZlR1NmZHL09nc3JzUWRYbDBQNFhE?=
 =?utf-8?B?RTNnVTFDUmJvbDJia2pKWGpnR2dHWDRCS1J3NFpFdGtpOVRuYS9WdkJDY3E5?=
 =?utf-8?B?WU1sY0JnWjNyaFI0dUkvclUwcWlsZm9DM0kyTnVHM3YzK3Z3ZEVDZ254bklu?=
 =?utf-8?B?NjJ0c2VMdGxvTFIxbEo4Y1VIU2RmcmUrN2N0TnBSS1dXWFBQdUQzRGttZGJt?=
 =?utf-8?B?ZEVXSFZBWVRFRTJhejVUSC85d1NJUFNkRFp2SFRQTFVCWWJyRUhjYTk2SXFR?=
 =?utf-8?Q?V9V7CEPGDVSvMYIuPObq9B99a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c411ad-1506-4f2a-0ea1-08ddc77eae39
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 11:15:06.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftpiRG+8/u6tb5den1gnfFLABvB3pcR3ZHBEQZzM6dR9zB8Y+zFMSQagtNWmL/YB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

On 18/07/2025 2:43, Jakub Kicinski wrote:
> Move ethtool_rxfh_ctx_alloc() to common code, Netlink will need it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>

