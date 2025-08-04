Return-Path: <netdev+bounces-211605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A03B1A55D
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77963167848
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C63205513;
	Mon,  4 Aug 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="nCyIV24p"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB76202C48;
	Mon,  4 Aug 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319484; cv=fail; b=Zw55N8tn4Me39jQ92zWbWf4UPjp59EBTNixpN2KbAROUpBo2UfWX8iINuZET0lMhW79KaciM77PiJ5H0D+7yF+4mKJ47iggmy3UzcMQxWqnfO3OD2ptvmVUi6ab61DrxzLutycqOw6D3hH3i0PuDc8hPPz7SDQzYv4rUeGrBSTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319484; c=relaxed/simple;
	bh=D5CecT1zzQQkAMdIgfoz9/4qGctC+MRnBJ04L4+DZ/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n9LIOXzkLs+ZSSX958BD70OzJYwGOlZtNNGXqJE9eS6f1RLn/Dt46AB4P8cYu4C/FPUoNmfDjGBIBZlCbY9FJGgy4f6K23gmww9/nbKQbkWfTvvey3T36+9llAuhK2PUV4l0g7pIUd2lXVpAo8CkhIYx7nnK8KPmfZc9Yu2FG8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=nCyIV24p; arc=fail smtp.client-ip=40.107.209.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3oWJNLPG+BC9NJJwy8H7h7P/ukeF2Qy8EP6cwQn7pOl8BflQJSOtR6qbUAipXp6UI7rYGSHLNZW5Z3UZXgndeaSnZ9NfsT++E5UZtX+eey0ExmuFyAO0uXmF/Y1rYUSc65VznVRXbjVYvxEiZvE+W9sT1L2JYRIXHCs0uWZV/G/zzOxI5oLtM0zuHE9zCXbfclpRi26HEg4y8Cq28oRJGWrQ7rNnAhtOkYmpplLb+QTheCssmJDPl6f53BmQJlYuuy3dX5nfoTQVrMnWW7Z8J4UUoq9Dhss2B84EwTGtR5WLZwR+OeZymLzgnUkuZz4LKB2ECn9s+rrh78Z8ZyAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZLOjPbwiFW8fCGAnJJzg7apR5muoXgwDsN53y7ZklU=;
 b=a9d3zVnChzw1tWj2f3EQXphcCFRQGuTRPQVAT1DYexzA1lSdmNos0Bs9k+3Z5DVlEhrumVRBvYX25iSBGowBlNV05EQhoK+du/K7NYZd97mk05LT8MMNS6QeDMEM4OhBzDr0id16mxqKAxfAxNkXJR7NCvKBha/1Dk+bhylnM2Wj8SgIEOWWWQMEozvbttv8pBMHzG0yMiAFSAldIAe0MKLNYbTmp80LhbWWAC65RDZ7c65eD3qm0JiZjJe/ANeIgG2DS/vm7jJa9P+440H4acXs4Ggln0A3RI4gK4vCuSrcf7F1BaxUEMYFmPJR1EJeRyMicjsGy7sDvajqdf54tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZLOjPbwiFW8fCGAnJJzg7apR5muoXgwDsN53y7ZklU=;
 b=nCyIV24p2lhzjoN2qUeql+zR7AofcCW8DoJzITj0ceS6YmNUKSp6AcZ+NdOBMbYASWNOrRsodtWRb7NvMu00JgCJULwg9UOSOBxJYbLbuLN/vTChbCfFeHJyAflv2l4ob03MEIMVHvZZlux90u5BiqeF2l/YXrxD73b36O+KgnJMQOvx2AGOiuPx/eA1RRNKVFBYgCSC5+eZieKwjr0rH1dObo0hQXaf2YxdMe90koeoeMVooTSDZY0UlM3B/GbRarMJm62KTM/9Ag4YJEjiKL3HBj4b+m87VQFILFo5YhhFjsCXpkW9u4Dev7j17JKIxaEcnNpr47JAihqOjLL4Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by BN9PR03MB6138.namprd03.prod.outlook.com (2603:10b6:408:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Mon, 4 Aug
 2025 14:57:58 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8989.020; Mon, 4 Aug 2025
 14:57:58 +0000
Message-ID: <13467efc-7c79-4d06-af1c-301b852a530c@altera.com>
Date: Mon, 4 Aug 2025 07:57:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: Agilex5 Add gmac nodes to DTSI for
 Agilex5
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, dinguyen@kernel.org,
 maxime.chevallier@bootlin.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mun Yew Tham <mun.yew.tham@altera.com>
References: <20250724154052.205706-1-matthew.gerlach@altera.com>
 <20250724154052.205706-3-matthew.gerlach@altera.com>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250724154052.205706-3-matthew.gerlach@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|BN9PR03MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 4632fc1c-7dc2-495a-6ef8-08ddd3674cfb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3d2bFBTQ0lyQ29zZWdJVW0vZEdiQkRLWXZDMTJEMlA1bWVjVzBKbGRvSlFT?=
 =?utf-8?B?NWFCQ01NQ2xaSFJnYkZGWnJBeFJ0RmNKelBZYmRRMTd1aFRXZGFINXE3dURk?=
 =?utf-8?B?Z1Rab2ZJT2hUdDV3Rk5ST3NUWnZnU1hrV1BqNVZOTnFScGVKdFFNTk16d3Fv?=
 =?utf-8?B?RXloNUNhbmZmT1duQUsvOENiS3plRFFRdFBYQWVNWXNSRTRUcFQrbWhJblZv?=
 =?utf-8?B?WVlxaU5yTTJlYkxJZnIwbWRKemxmOVRDa3gyTmsyakNJa2Y2QndXSzBsKzc4?=
 =?utf-8?B?R1hKbHI3MlZBckJ3VEpSR0d3ZGNXUDQzTnRpeVp0emc3Wmpvdi9haDlCL2dv?=
 =?utf-8?B?K3QzYmxtMG1FZkVQOWRuMzZkM1NqbUh5ZS90d0Q0NmlBNjdYMWw0eEtwekpm?=
 =?utf-8?B?YXlyaUQ3QlhNSWRiK014OUcwMkMxQ3hrckxVNXdHcCtMblBhVTVmQU1BZ3Nq?=
 =?utf-8?B?QlhQYVN3a2JYOWczZEpzR1dEYmF6REFIQTlhdWZIMVg3WW1TT0xoRDhwbVI3?=
 =?utf-8?B?eUwxbGkySVcxVUtUdU1QVjJBNG5UZ09NWmgxV2J3YmRPWnYyWEtnQnRVanl6?=
 =?utf-8?B?STc5NDJNSVdtZ3FJcVlmQjZoczdlWHdpTXJUS3ROSUErT00wb2oxUE9SV1cz?=
 =?utf-8?B?ZXR2TzZsRFg4d0diRStCWFl1WjF1UnMrNkdzVVRRNmRYSmlKV1pBU1p6NWNp?=
 =?utf-8?B?QWJSSUhhZzZYUWxmdjNxUEoyR21JZ2V0UUdFOGg3RThLZ2gzeEFuYmlNZlZY?=
 =?utf-8?B?Mmc5M3E1RmlPVzluTHdjeXBvTCtBSklJZ1RJM0hnMkt6Y2k1M1ZtSktINkpm?=
 =?utf-8?B?RnZ6WDdmeGtZcXcyVlgyang4TWt2STBEbWFCNnpjSXBOb2xjdGRrRW1Rb1J1?=
 =?utf-8?B?b3JFeHgra3ZPb05sQVd4OEdyVDFJQXcyVjhudWFxaUkvUCtsWnVDL3EyZFJM?=
 =?utf-8?B?NHF4a3lpcVgySWxKVC9lL2Z4NEwvbVVpZjJ3a2RsMGZPUEFiQzduaXNiTkZt?=
 =?utf-8?B?NjhJbE5rWmZqbHpXQi9INTVvRXM0SU40b2dLVFRYYTNjV29FeGdKTnd6Mlpm?=
 =?utf-8?B?VVEzRFJBVUZnYzU0cnZQSC95UGliMnhqN29ROXQ0QjZKeFdTNFBLcGh2bWhp?=
 =?utf-8?B?YnVBbHI1UHU3THFYZEQzV2U0TVNySUlNbnpYelZaYjhXUnllaTNsb0NSeUZB?=
 =?utf-8?B?eFVxNUlYNVlseFR6VkZ1WXFjQUFhTVpUZGgvSE00M2pvNXNIYThOak5hM2F6?=
 =?utf-8?B?OStxTDFiWHV4ZVV0NEMzYlRMeE42Qmw5eTVoblZQbFB5Qy9qcnFJa0dlZDBq?=
 =?utf-8?B?TFdIa1FZMmhLaFhWbm5YMm1NeU1mR0tCdlU3bUVYbGx4SWpLNitKM1BtRzdX?=
 =?utf-8?B?dnFPQjhPVWxxR3dLWEswczc2VlJNUTRleVBDbURTWXgrbVlhenZKSlZYU3JL?=
 =?utf-8?B?eFAwOFloaU5kZGtFQ1IzT29NZ3g2RXd4dHliMVpjQnlYWnlyVGJ5QWZ1WXI0?=
 =?utf-8?B?L2swVUwzVzVxME5obkRUKzdBVkpPbm1leCsydTJvT0ZMdmFjd0pSR3Y5OVdF?=
 =?utf-8?B?d2Ria1p1djZnOTRyWVdjSDc3dGowTzhCWVRLcWFVV1dNS2ZiVW5JTDRwS0VY?=
 =?utf-8?B?YjViS093eWpwQVF0L2tnbWdpUEp0UUpZd0FWazVoK21mWDdpd2FVUi9CUHRS?=
 =?utf-8?B?ZGZFWTFCcjc3eWV3VWNncjFFc0lrbnBVd2RVMEd0cU10NEZDMElEdm9iRTA2?=
 =?utf-8?B?L0g1Zi9SY01wSHB0enBydlRORU5jSzFQYkxEZ3dsK2lObHJvbkZKM0NXUEZD?=
 =?utf-8?B?dTVUeGVlR2hmRGgzcmFiRWlsVEFpbzJKa081Vmk2dXJBQnk4V2JNOTBjc09x?=
 =?utf-8?B?RE01cVdoVkVEb3VJQUFqVUgxREFoVWwzclRjYlk2QWRWQ1NjTnNsdTg1UitZ?=
 =?utf-8?B?akYzak1sSGhzN0txTFdtMHJielVRTzM5THB0bjZGSzZHQ3M1T3BOQ2w3MGk5?=
 =?utf-8?B?cjFiVXpoK2tBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW5pazNsWFlaK2JUZzFDaElDcm45NDR0dHJycXB4eHJPK3FkdFNTMVVocXV3?=
 =?utf-8?B?R0dhRDl4K0ZaUkNLaXJFcWZBYmRxbktaNnZBbGVyOUU0RTlkR3c1d1pYSEZG?=
 =?utf-8?B?MFZMSHNNYm5rN2FKbC9sdS9zM3pTTWQ3bkdzTmYreTMvMmluSW9uVUpaYkFJ?=
 =?utf-8?B?OFBySU9pTE1YU1BjK0JCVnVrVnRwUW5hemhMeUllSTVqbWVvWlFmMVhUeklM?=
 =?utf-8?B?WDgwZURYd29UUVh5WUNkSnBiRk9JNHNjb2NwNGlYeGU0Y1o0UlZMQmhMMzFR?=
 =?utf-8?B?QkNIaTdpRDF6RWtzVDltSTlpM0ZZdDAvbk9aM2w3T2svdlMwRGYvdFdFWWpi?=
 =?utf-8?B?ZkxUcGk4ZWU3TjFrSE13cGpYc1Z5UXRMdVZwa3FNNU56UHNrSW5ZNFgrekVJ?=
 =?utf-8?B?d3Y3dkdXUi9SSys1bEJ0bXF3ZlJBTzJxT210RmQvb2NXd1didDVuRVl4bEFU?=
 =?utf-8?B?bnp6M1FWSUZhOXIxVi9oSXYyVzNwTk8zSHhMS1dNR0syWEpaT29ydzBFUzFG?=
 =?utf-8?B?OHo0WVhmWm1ZbGtjV0o1TmNuS010TjBtRmVzWVphcStYdUd0NWNuaXJGMy9Q?=
 =?utf-8?B?NFVJSzRRS2RveFIxam1pa0xsUDdZRFY4Z2RhM0FJS1VJM0hqUUVpNzNhZml1?=
 =?utf-8?B?VUF4MzRhdUFOM2wxWDdudEVWRFBLd3FFQ1hPVTY2dW1pNnhvS3h2Z2syUm5H?=
 =?utf-8?B?RTFLNm9zOVYyWldrRWQ5dkVncnRvU1Z0cUgvTTBucFNGZ1g3WGxFWjVDSGM4?=
 =?utf-8?B?TzcvYWluTmFpUHZDdXI4M3dZc0hENkV4ZlJWS2ZndjgxZG9uUVlSdGRQcnVT?=
 =?utf-8?B?aGdGakw3VFpGZ2gxNkJndlE0OGRpRDQvSXlFYk01MmtrZmxJejZFQ1pjZ2Jt?=
 =?utf-8?B?VFdvcUJ2bWNRbjZ0YTk0NXZTc1NvbVI1dllOczF4TW9Fbm9RWnJvN2t1TUZW?=
 =?utf-8?B?RmlZMS9vYVhmMkZrblhkbWZoNXZ6N05wRS8xclBaOFVWU2M2L3h2SlZKOHg0?=
 =?utf-8?B?UzZWS3R3S3E2VndYbmZsOW9WQVpGZ01Zb2ZLZWNpcHowU2p5K01wcnl5ZlQy?=
 =?utf-8?B?d2xWdTBSalVxanJNUUVUV3NVRXBBZW8zWElQc3MzdU11djFUOXQ0M2hTaHM5?=
 =?utf-8?B?VGZDU0d5RzJCMU1RRXdzeHM5aUJOSEpOWC91M3lqaFBNcXFubzlHQnJ4aldk?=
 =?utf-8?B?cFRNREI4eUVNV2wrVHNYMTdtNk4rOTlnbEtic1N2Z1RCNVhVNmlRYzJ1QzFC?=
 =?utf-8?B?VXpZbVdONmdOTWNIaGx1NlQySzlpa2FnRHZtaEpwV0gvZU1ZNXQ4RGlBUVdh?=
 =?utf-8?B?WnBTZHRuMDIxWVdsQnJwZU0rYU8rcUM4TlVZVmRyNTByNS9Ja3UxN0Z0TjdS?=
 =?utf-8?B?c3A0N0l5U3pWdkI3Ujh6WTBnN0trQkhLd0FseWE2WVBoYk9KZGN5UVIxM0Fu?=
 =?utf-8?B?OENIcXoxVVd1bURVSU53MDJyMVAzN1Q2SkRpaU1YcnFBQzZwcHc1bkhHZHZQ?=
 =?utf-8?B?dDdrZ3JqWC8rMXlycnB3SVNPcFFUQldPcG0zZVhUUEVGWTJqamtBNzdDdHBS?=
 =?utf-8?B?QWUxOVl0dHBrUU54VTZzYjRrT3NuOTB6MWxZbHdtN1F2ZUREMUNnaWkyM09m?=
 =?utf-8?B?c3h6Mll6WlM0VHJnYkwrRWh4OXJHY3grL1M1clltNktxV0FlZ3FnRkJDZy8x?=
 =?utf-8?B?eVNoaU9BVGNUV0lVV01jUEM3Z2srbWQxRnN6ektYelZxQlV5S1VscVVQZlZ4?=
 =?utf-8?B?cVlMN1Z0WkEzcmFubmVZWEhXV2FaK3VhdGorMjNpa3g3SmRIVG9COU5pVC82?=
 =?utf-8?B?WnFYWjFMeHg1V3ZRdXcvNzZIRGtzSHhBM3B0Um5xRGNzaXNhSHBPRjA1cUlB?=
 =?utf-8?B?MmJGVFl1Rm9jME5MRlQrVWhBVHNRQmt3bWU1NUd3TkdNdlU2QWMyM1JkQ0Rj?=
 =?utf-8?B?TU9TNmNiZzJoUnFTN0NVVTV0NlhNT3V1WS85WUNiWFc1V3F2TWY0UUo2dGZv?=
 =?utf-8?B?eE9TZXdlK1VEQzE3bzhDcVRkK0VvVE16MTVSMUh3NTdqOTlRcUtjR3EzZ0RO?=
 =?utf-8?B?TzFFLzVFS0IxVXNoQlpVaFA3MzJSZ2JYemcyZGxoRUwwODcrS0hZd3dxT1B5?=
 =?utf-8?B?Sm43ejVKekNGVWJRVUFVQ3oxcU5tNHF3Y1cwNFp5UTdXK2RNNGFMMU1vS3ow?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4632fc1c-7dc2-495a-6ef8-08ddd3674cfb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:57:58.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iKykeYphT1n9ZxWNWy3wSEBilDrGbSuycu8U1JZJ/YgY6RY6PDupDKArIaX9MzBsOASzje9TBQU+D2xDvjQeIxSniraCZN7xFfnfWA5LDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6138



On 7/24/25 8:40 AM, Matthew Gerlach wrote:
> From: Mun Yew Tham <mun.yew.tham@altera.com>
>
> Add the base device tree nodes for gmac0, gmac1, and gmac2 to the DTSI
> for the Agilex5 SOCFPGA.  Agilex5 has three Ethernet controllers based on
> Synopsys DWC XGMAC IP version 2.10.
>
> Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> v2:
>   - Remove generic compatible string for Agilex5.
> ---
>   .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 336 ++++++++++++++++++
>   1 file changed, 336 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index 7d9394a04302..04e99cd7e74b 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -486,5 +486,341 @@ qspi: spi@108d2000 {
>   			clocks = <&qspi_clk>;
>   			status = "disabled";
>   		};

Is there any feedback for this patch and the next one in the series, 
"[PATCH v2 3/4] arm64: dts: socfpga: agilex5: enable gmac2 on the 
Agilex5 dev kit"?

Thanks,
Matthew Gerlach

> +
> +		gmac0: ethernet@10810000 {
> +			compatible = "altr,socfpga-stmmac-agilex5",
> +				     "snps,dwxgmac-2.10";
> +			reg = <0x10810000 0x3500>;
> +			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
> +			reset-names = "stmmaceth", "ahb";
> +			clocks = <&clkmgr AGILEX5_EMAC0_CLK>,
> +				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
> +			clock-names = "stmmaceth", "ptp_ref";
> +			mac-address = [00 00 00 00 00 00];
> +			tx-fifo-depth = <32768>;
> +			rx-fifo-depth = <16384>;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <64>;
> +			snps,axi-config = <&stmmac_axi_emac0_setup>;
> +			snps,mtl-rx-config = <&mtl_rx_emac0_setup>;
> +			snps,mtl-tx-config = <&mtl_tx_emac0_setup>;
> +			snps,pbl = <32>;
> +			snps,tso;
> +			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
> +			snps,clk-csr = <0>;
> +			status = "disabled";
> +
> +			stmmac_axi_emac0_setup: stmmac-axi-config {
> +				snps,wr_osr_lmt = <31>;
> +				snps,rd_osr_lmt = <31>;
> +				snps,blen = <0 0 0 32 16 8 4>;
> +			};
> +
> +			mtl_rx_emac0_setup: rx-queues-config {
> +				snps,rx-queues-to-use = <8>;
> +				snps,rx-sched-sp;
> +				queue0 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x0>;
> +				};
> +				queue1 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x1>;
> +				};
> +				queue2 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x2>;
> +				};
> +				queue3 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x3>;
> +				};
> +				queue4 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x4>;
> +				};
> +				queue5 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x5>;
> +				};
> +				queue6 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x6>;
> +				};
> +				queue7 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x7>;
> +				};
> +			};
> +
> +			mtl_tx_emac0_setup: tx-queues-config {
> +				snps,tx-queues-to-use = <8>;
> +				snps,tx-sched-wrr;
> +				queue0 {
> +					snps,weight = <0x09>;
> +					snps,dcb-algorithm;
> +				};
> +				queue1 {
> +					snps,weight = <0x0A>;
> +					snps,dcb-algorithm;
> +				};
> +				queue2 {
> +					snps,weight = <0x0B>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue3 {
> +					snps,weight = <0x0C>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue4 {
> +					snps,weight = <0x0D>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue5 {
> +					snps,weight = <0x0E>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue6 {
> +					snps,weight = <0x0F>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue7 {
> +					snps,weight = <0x10>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +			};
> +		};
> +
> +		gmac1: ethernet@10820000 {
> +			compatible = "altr,socfpga-stmmac-agilex5",
> +				     "snps,dwxgmac-2.10";
> +			reg = <0x10820000 0x3500>;
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
> +			reset-names = "stmmaceth", "ahb";
> +			clocks = <&clkmgr AGILEX5_EMAC1_CLK>,
> +				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
> +			clock-names = "stmmaceth", "ptp_ref";
> +			mac-address = [00 00 00 00 00 00];
> +			tx-fifo-depth = <32768>;
> +			rx-fifo-depth = <16384>;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <64>;
> +			snps,axi-config = <&stmmac_axi_emac1_setup>;
> +			snps,mtl-rx-config = <&mtl_rx_emac1_setup>;
> +			snps,mtl-tx-config = <&mtl_tx_emac1_setup>;
> +			snps,pbl = <32>;
> +			snps,tso;
> +			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
> +			snps,clk-csr = <0>;
> +			status = "disabled";
> +
> +			stmmac_axi_emac1_setup: stmmac-axi-config {
> +				snps,wr_osr_lmt = <31>;
> +				snps,rd_osr_lmt = <31>;
> +				snps,blen = <0 0 0 32 16 8 4>;
> +			};
> +
> +			mtl_rx_emac1_setup: rx-queues-config {
> +				snps,rx-queues-to-use = <8>;
> +				snps,rx-sched-sp;
> +				queue0 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x0>;
> +				};
> +				queue1 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x1>;
> +				};
> +				queue2 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x2>;
> +				};
> +				queue3 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x3>;
> +				};
> +				queue4 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x4>;
> +				};
> +				queue5 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x5>;
> +				};
> +				queue6 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x6>;
> +				};
> +				queue7 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x7>;
> +				};
> +			};
> +
> +			mtl_tx_emac1_setup: tx-queues-config {
> +				snps,tx-queues-to-use = <8>;
> +				snps,tx-sched-wrr;
> +				queue0 {
> +					snps,weight = <0x09>;
> +					snps,dcb-algorithm;
> +				};
> +				queue1 {
> +					snps,weight = <0x0A>;
> +					snps,dcb-algorithm;
> +				};
> +				queue2 {
> +					snps,weight = <0x0B>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue3 {
> +					snps,weight = <0x0C>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue4 {
> +					snps,weight = <0x0D>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue5 {
> +					snps,weight = <0x0E>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue6 {
> +					snps,weight = <0x0F>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue7 {
> +					snps,weight = <0x10>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +			};
> +		};
> +
> +		gmac2: ethernet@10830000 {
> +			compatible = "altr,socfpga-stmmac-agilex5",
> +				     "snps,dwxgmac-2.10";
> +			reg = <0x10830000 0x3500>;
> +			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
> +			reset-names = "stmmaceth", "ahb";
> +			clocks = <&clkmgr AGILEX5_EMAC2_CLK>,
> +				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
> +			clock-names = "stmmaceth", "ptp_ref";
> +			mac-address = [00 00 00 00 00 00];
> +			tx-fifo-depth = <32768>;
> +			rx-fifo-depth = <16384>;
> +			snps,multicast-filter-bins = <64>;
> +			snps,perfect-filter-entries = <64>;
> +			snps,axi-config = <&stmmac_axi_emac2_setup>;
> +			snps,mtl-rx-config = <&mtl_rx_emac2_setup>;
> +			snps,mtl-tx-config = <&mtl_tx_emac2_setup>;
> +			snps,pbl = <32>;
> +			snps,tso;
> +			altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
> +			snps,clk-csr = <0>;
> +			status = "disabled";
> +
> +			stmmac_axi_emac2_setup: stmmac-axi-config {
> +				snps,wr_osr_lmt = <31>;
> +				snps,rd_osr_lmt = <31>;
> +				snps,blen = <0 0 0 32 16 8 4>;
> +			};
> +
> +			mtl_rx_emac2_setup: rx-queues-config {
> +				snps,rx-queues-to-use = <8>;
> +				snps,rx-sched-sp;
> +				queue0 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x0>;
> +				};
> +				queue1 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x1>;
> +				};
> +				queue2 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x2>;
> +				};
> +				queue3 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x3>;
> +				};
> +				queue4 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x4>;
> +				};
> +				queue5 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x5>;
> +				};
> +				queue6 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x6>;
> +				};
> +				queue7 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel = <0x7>;
> +				};
> +			};
> +
> +			mtl_tx_emac2_setup: tx-queues-config {
> +				snps,tx-queues-to-use = <8>;
> +				snps,tx-sched-wrr;
> +				queue0 {
> +					snps,weight = <0x09>;
> +					snps,dcb-algorithm;
> +				};
> +				queue1 {
> +					snps,weight = <0x0A>;
> +					snps,dcb-algorithm;
> +				};
> +				queue2 {
> +					snps,weight = <0x0B>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue3 {
> +					snps,weight = <0x0C>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue4 {
> +					snps,weight = <0x0D>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue5 {
> +					snps,weight = <0x0E>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue6 {
> +					snps,weight = <0x0F>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +				queue7 {
> +					snps,weight = <0x10>;
> +					snps,coe-unsupported;
> +					snps,dcb-algorithm;
> +				};
> +			};
> +		};
>   	};
>   };


