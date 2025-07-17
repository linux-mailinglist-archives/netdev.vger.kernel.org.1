Return-Path: <netdev+bounces-207867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F37B2B08DB1
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38337A4E62
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8462D4B47;
	Thu, 17 Jul 2025 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Nhd+whoy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BFE1E98E3;
	Thu, 17 Jul 2025 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757190; cv=fail; b=cYxgpxkSEVsZCrG4HsDsiSD1RgIhUCgq4Bq4feub2VU064hVZT+cNCkDmME8YVCzdM3tmDKX/H9cHiOg2mwOpQgr5W+OO2wPBvIR4uuk8dn0OKitQjbmSeDjhrA9Y0rw1Q40eecbfwkY90LFikqUQxjbmIZt/1zN+YTl80HDqWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757190; c=relaxed/simple;
	bh=KT2Alq7DIiZVIUQso35gcSWG5tQz+5RmvusOlY2WsGY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LxeMeTQCfEDzPwH3EVWMRxnylhokAhXOgXyiop3E5vtZ+IQ+4UOdoPOxUtI9nF7Qt1W4JPi9VSVzjkKQq+76I/Tj8QH/XD2AIK2MzA1XrGxNOmJojycDn/AYDuARGqTb5SH9dhzaAT9MRBd2s4VX2jHmYpwq41qeHm1WPsjhokM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Nhd+whoy; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+CIOmVBNVsEGzLVuv2BDUhZ+wM2TP2RRAGqNFKx7c8Ul3zU2nBb3qWv5qezKxI7SyJU65kgqSOH6koasJr91lJ0JogEmPSuqOz26p6pqlvD0aV5frnVvlY0FZ8bapIszG4agRNQWrKOxQNss5ukmdNub/iH3CwMIFPBai09r9kSHerqh//jlIK2rXlEYFfvh9/OHEnBcVB3Y5qHlOwptTpCkOuKrW9i9i7nilhHAfhNrGMJrldxGjEdprMc3EFIrqPIguSHAXqD44ZP4d0c4ynuZLZXt20FHxoqb5atXHKjCRu5iPvfW/dHU1DrR8pqZUKXNxsfmUYE0fPaCxJQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvYLM4XY6L7La2t0icRL/chMYAq+wpHKnHTN5t3sHoc=;
 b=Cg2jJnWFTin9TmG64emwPAHl/c96B6w3uta6oC3VxWFVLVoxSWNuBHnnWc2kN4Dtq09viaIDLXDy7bfUm5Px6+3DRXBHN3OCzKozoEW3bqx5icI8YUnire+Qb85UPVy4MtsdwwVz1cfsdk5+k1/Cspdf3WnlRrmej8tJpYtMjODJgUnN5bK+0Nid912Vr3A1LYPFuGx0aXDIsJON2LjUsdHMXmkAp8q1i0mMquXNMP6YbmIOWRuiUd1hK97eJ3DLf2cW6GvMTTHCFokxXR4S7Ef9HlsVWL+SbqjWDmAoAw8o1lHXXXCP25ej32ez2z+15p2YIn2x/sEAVn4E1vt+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvYLM4XY6L7La2t0icRL/chMYAq+wpHKnHTN5t3sHoc=;
 b=Nhd+whoy8CdKuvFbFThG2ctO6vOm3KEVCmI92kh6rQsMoy0ahe6fTHBP/hnQgK+7bDTJJbm+LZR1lsr/mVmCAwuT0A5nuFx7PyuxBDoOzM6vUTneVZgN94CROOyr/pZ1tbdjjYGvwdBzM8GsTAtVX0u3TuE8omTcQl3CjEDVyfT63bzeVwZGB9psCxPGt2ICsWJt91mzQusiK5KxQFBiE4jwgCUzmoRGQ5qHyhHOoSlZCepAXaG3PwydSwYKyTFTYE0nDN8Zy00lSQOS2DragwGlzWJT0FAgkmBbPoCTClOAaGrhJT4D4X265jT5xR2dgCDltOKAAqfQznTxviPVjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by IA3PR03MB7665.namprd03.prod.outlook.com (2603:10b6:208:50c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:59:45 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 12:59:45 +0000
Message-ID: <74770df8-007a-45de-b77e-6aa491bbb2ae@altera.com>
Date: Thu, 17 Jul 2025 18:29:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: xgmac: Correct supported speed
 modes
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
 <b192c96a-2989-4bdf-ba4f-8b7bcfd09cfa@lunn.ch>
 <e903cb0f-3970-4ad2-a0a2-ee58551779dc@altera.com>
 <6fsqayppkyubkucghk5i6m7jjgytajtzm4wxhtdkh7i2v3znk5@vwqbzz5uffyy>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <6fsqayppkyubkucghk5i6m7jjgytajtzm4wxhtdkh7i2v3znk5@vwqbzz5uffyy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::25) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|IA3PR03MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bc2f47-f27c-4fee-3772-08ddc531cdd9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SStOendzRHFBRysvTnk5QVBqbjc1VHFKRm5aa0ZiUzhOa0FmUGJTaU93dk1q?=
 =?utf-8?B?aE5Lb010NElvWVJGUXN1aXRaak56VmdRNkhmZVQxaHNLeEhtdWs3Q3ZOMkwv?=
 =?utf-8?B?dk5UZFc5dkcveEVOWE4ydFBFeXdhZnpYYXl6UjhaNGk2WllRY01ldDQrTUY3?=
 =?utf-8?B?TXYyNEdRcHRZL3RBUkJub21uak1sZWhDdzdTcElNR29XbjlqMGhWMEFoc0hG?=
 =?utf-8?B?Z09MNjhxNUJrcnJ3blFYdHorQjJuODBLU2ppWVhSMEpXRkhCWUN4K292VjNR?=
 =?utf-8?B?ais2RVV3RXRUUi9pNmx6TTZSRjNSc1FqanBWeEdZTlNKMlIrVXZlc1JzNXIz?=
 =?utf-8?B?UmUrYzRqcFd4MkdueUhmMU9xOGovakVBNktFQjFYWlh1MkF0ZkZaSE1YMzBk?=
 =?utf-8?B?NDNPblRhaTRkVS9Zc0xoNU9FZlBobVdCUHVvNk1VeVZMa3ZMNTlIOTFUQVJD?=
 =?utf-8?B?NnQwM2RpYmJCSlpaN3FNa3d1VXRsSEovVXcwUHFFS1QwbEI2Q0NvZFRJUVpW?=
 =?utf-8?B?YTU3anlyaTZLK2VrSmJlK0tyTEM1OUhyR2hUR1lIQzNoRkducHF1QTRWV2Vt?=
 =?utf-8?B?MExWZnUxTXd4U0EyODVMNnoxUkRwV2YrNmpOTk9aYkNyRE1wakNMUUp4UDRE?=
 =?utf-8?B?NHIxa2VaYnZVdnZ0a1ZoMmhaUjk4U1VsOTFiSmk5aVpOMXA2OHFSYmt3N3p6?=
 =?utf-8?B?YVNzM1ltWXpMc3VwdXBUZ1d6WmFiZTJ4bnRmQkVXbk9YakpRVWVxc3ZHL2s1?=
 =?utf-8?B?YTN4SmRPOFlGRzVkUjQ4YTFJeEVMQkNyV3FUSFkrek8xTG4zdlkvWGRqbTlr?=
 =?utf-8?B?VFlWN3hYK0VVWU43bXUxdlpaV0YybExqb2k3UTluZ1JrZUlEY05KdVZmNnJv?=
 =?utf-8?B?NnpFcHJ2a1RVRFlEb25vZk9VMVh1Uk9jVHNkNGJMaUFqUG1wVXlxZ2tyUmhq?=
 =?utf-8?B?WkJsVGQzUzBvejl6T3cwR0paUkpGeTJMQlhWVG5BL3ZRVFpuNlFzOGY0ek5t?=
 =?utf-8?B?OEtiem80TUNoRkJXM3FsYTB3TnBuUXlNTU1HNmkrMnVSYzlxVHJIVXNnZlJG?=
 =?utf-8?B?T3NycjFhT1ltNXZGMmcyM1BVSFA0a1BNZXlJaHFMb0U3Mjc3VEV3Z28wTm5K?=
 =?utf-8?B?MzI4MHk4WkoyWlJKN1djRTRKVUhDRXBFYmdLeXo0d0JiOWVtUnVQUExMS3cr?=
 =?utf-8?B?TXR0b3JrOGk4RkJ3dnVXbGdqbDFXVnVvTy9XVVBkb0x4Z1FMTWl6U1VxSkkv?=
 =?utf-8?B?U1BPdDVRWllMZzRYQkprbVBPdTE2bVlLWkJOc2RCbGtCR3J5UFNKcXNqMjNV?=
 =?utf-8?B?emlxZVJwYzByS05sYkF5TmlEYUNiT2FKV3lBeWk5RmlLT1VOaWJRTjA3L1N5?=
 =?utf-8?B?dzdOU1l1dm1TRzNhR1Y2TUhLUlNKVXJ0cmtQR1I4NDVLVW5rakJpcVRsb1k3?=
 =?utf-8?B?K2dJcDNlNmxoa2NUM01Fd3dUNERWd3Jva2pnZHlmT1lrWWMxeTVvWnVMMzF2?=
 =?utf-8?B?eS81M0VlK2dNSnlpRWpFclJ6ODZPUllFZFNKK3RVdVR4Q3dIanRnTXRndkpP?=
 =?utf-8?B?SkFzenl6MGwvd1pPaXVmOWNJMmZhQ1BXcVJUc2Jpamlsa3FZRDM1QTBybmt1?=
 =?utf-8?B?Z0F4TjBqWlZ4TTJkVXVLWWc3MGJtY1A0UloxVXFEaEhmOXZrdGJaWjE0aFo5?=
 =?utf-8?B?TFhScFBqNjBraEFldVMwTWlxTFBMekhBSXdVQkFxRzdtQWRrTWErbWFCTUtV?=
 =?utf-8?B?WEMyZzc0VkZxS0lIMzJUNTB6Qm40ZitwM3E3SHFrQ2xpUm1IN1lVZzRTd0NN?=
 =?utf-8?B?M0l4Y1RERDVUcGE4WTArVEhyZW0yb3lhb0dTL2k2OXhsQThFMEJ2NEs1WUln?=
 =?utf-8?B?cnJHQ1BLMGJKMG1iTVpVRWNpemRSSEMzU0xzTUZURzltaXA5V1JqLzNOSWRk?=
 =?utf-8?Q?XunDqdhPRqU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bm9DMmMwNUNhUzRnWmtLazV5Qk1pVnhnck5JV3VKRGRSWnhMZVl3ZHVTNnR2?=
 =?utf-8?B?Z3Fsb0hRTkM4V2JTc2FxSDloYytnQUtWNXJYREpuaE13YWc5UkMwaWlKRHJV?=
 =?utf-8?B?WlRVSGI3cDViWlcxeFNJck5SNlB4ZE94dWJmU2tpa2FyTXlFVml4YWFVOFcr?=
 =?utf-8?B?Q281dVRVU0pIaU5vVzBacnQrbUlIQUkzMk1kNFhZTENaTTRId0JuYWZPNHhZ?=
 =?utf-8?B?UW9jVGxieEVCS3lacGMxSUhyOUFJREtkSzZZZTBESG9zTlcxbk9UVXkxTUdo?=
 =?utf-8?B?eWk2WW9GSVBZVmJxbE5DM2FXaThPKys5ME1zZGpmMGo0ejZiNUtLWkdmWmJV?=
 =?utf-8?B?aEhjZXcxNEx3bkl1TXBhcUxqWC95cGI4aFFMSWQ2Ui80QmN4a2RjRlRXUGls?=
 =?utf-8?B?ZHR4MHpIdlUwcUtUR0QySWtGWUNFeENQWTFjaURGUUZyNkh2ZXFUS0MvT24y?=
 =?utf-8?B?RVZzdWw5VVROZFprV3NoQWdQYk52V3RrS1dGZVBpOWpSdlVCUTIzZmJsZUxM?=
 =?utf-8?B?VUxtUHVTd080eWVhSkFhYnRkVWN6amt0WlRseE1Yei91NjVDbndIdzd2TVQz?=
 =?utf-8?B?TlNXSlZ2cllUbTIyOFZiK0tqR2N2MFFyWlhocHZNVnhRU2NjRHAwem1DcUx4?=
 =?utf-8?B?TlZWVDlyNVhYL1MxY3FrcFhBTmVMMk9sVXNJV25BamtWUTlqakRVLzcrLzRo?=
 =?utf-8?B?dnVpQjdPb3ZZUGxXU1R6STRVRVlLTVhNOXJvZDRzSFcwMTVRYXAzVzFzc2Iy?=
 =?utf-8?B?M3U3VG55S1FrbDJPbUVnOWNOTWtSMWgxTm9odEZmY2FhUjhDWGtEOFpQSnlW?=
 =?utf-8?B?TEQxVnIxWFNNWlZwbU81bHAyQ2xsMlpTT1J1YTRRN2kwcG1JSWVmazNMRWx0?=
 =?utf-8?B?UEIvVHQ2QU1wYjF0YlhuZkdPZDhBVkxodVl3N1duSGVvZk5zT21YeVdMZW5Z?=
 =?utf-8?B?QktnbUJQTU9RTitVU1pzTGZ3eUtFZE9Xc0M1WnJDOUQ3aVN0dXIzWHBnTFVn?=
 =?utf-8?B?THJuU0VxR1lWeTRrVVVpYXBXczNCVTQzUHFWQmY2d3JuTVpLRHhIOU5vVC9B?=
 =?utf-8?B?MU5iM1J5eDJ0RDFEU2Q0dWdXVzNUQmlZTDE4cFRjWkEwM2huOFNHL2ZwcVhi?=
 =?utf-8?B?dnRVdjR2eTQ1dmxHUzZMeTZ0QjdiMW9LYndjR3lmZm9pQjZsQXpJK1FoYzMx?=
 =?utf-8?B?empNdk0rbjRvSk9OK1dPSDV4Y0dPYkFGVmh6NnErRlR3Z1RCRW9MUS94b1hz?=
 =?utf-8?B?ZndLaGhGZ1FyVkFnWGJFSk1ZUnc3Tm53eXYyaDhlVjdjRnlsS1VrUWpCNzEz?=
 =?utf-8?B?RUxmUWc5a08rOG1PbnNKa01MaUF5cE9NbHJyYi9jMHBvbVlVSHZZVmdydjJS?=
 =?utf-8?B?eE5wZmhSYnh0cXpaVkJCenpIQnNnVzcvZkJQeEkxTUFTQXZPSU0wZ3VYWXIy?=
 =?utf-8?B?amE2VnRrMXF4ckYyNWNzZG8vY25IV1ZhWWxBSUxzdEdoNHc5OUhOQkdTaXJY?=
 =?utf-8?B?NTRkQyt0c2N6QmgwdTV5UVloNjNuRTFlOWhKTzJVTnluOE12MURUT2FOMnlN?=
 =?utf-8?B?ZkZQQ3MzQTN2ZnlacGdDbXZYd1ByMktJR0ZXbXVqamE3S3NqSGpLTFFQVWJX?=
 =?utf-8?B?MUx5VENHLys4bWduemhUUkE0aW1yZnorRGFGK1YyWGVyTUxuaHd5c24wazBH?=
 =?utf-8?B?SWpOTFpEOEljYTY3bjRVK1hkWlhVSG1KTm1pRWZpd0wwYWNtbDErWEJaRjZE?=
 =?utf-8?B?b3RUYzQ4NTdic3pNY1gxdXNkODdMVWFxSzFOeEJ3K3ZWNFVkdUp1Y1Jodjc1?=
 =?utf-8?B?a3RvUnRBRmcwZDRkTEVMMXJXNkNBV1dRQnRvY3dzTXIrbEk0ZUY1WE9ZbEoy?=
 =?utf-8?B?VmpDa095MXRxb0owa3U4T3RoSGNiZ0ZlelJlV2R2OXY4RzF4Z2JKOU5XK0d3?=
 =?utf-8?B?ZHFZU1FIMEdSNWFrYUVveGtzeDlaeDcrNEk5YjFXaVZIdGcycGVZMFZjVjQw?=
 =?utf-8?B?TnVMTDVRU216ZWJRcXVEL0xOekt3cGVhL2MzZ0FUVC9raFQzUGw0bzA4Zity?=
 =?utf-8?B?ajFta092bEw1RFJVZURoc3dNVmc0REJlbGtSSUNqbFlDYThEZkZaSm1wUEN0?=
 =?utf-8?B?ZjlvOWFOckluY2s2cVBzQ1pjRlNTQ1RYZmxuNzFUSFZReFk2dkg1SVo4K2ls?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bc2f47-f27c-4fee-3772-08ddc531cdd9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:59:45.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSg0q1cijV6Pzh9yycTcnuXz/85bJFzOPJIseXHr4HAW/NmeGbpS59+ugodlGi4k0OF8ruyyr/kmcbSUh1QWDbmty4SSIB/rhjDhYwjeiPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7665

Hi Serge,

Thanks for the review comments and the detailed explanation.

On 7/17/2025 5:17 PM, Serge Semin wrote:
> On Tue, Jul 15, 2025 at 07:03:58PM +0530, G Thomas, Rohan wrote:
>> Hi Andrew,
>>
>> Thanks for reviewing the patch.
>>
>> On 7/14/2025 7:12 PM, Andrew Lunn wrote:
>>> On Mon, Jul 14, 2025 at 03:59:18PM +0800, Rohan G Thomas via B4 Relay wrote:
>>>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>>>
>>>> Correct supported speed modes as per the XGMAC databook.
>>>> Commit 9cb54af214a7 ("net: stmmac: Fix IP-cores specific
>>>> MAC capabilities") removes support for 10M, 100M and
>>>> 1000HD. 1000HD is not supported by XGMAC IP, but it does
>>>> support 10M and 100M FD mode, and it also supports 10M and
>>>> 100M HD mode if the HDSEL bit is set in the MAC_HW_FEATURE0
>>>> reg. This commit adds support for 10M and 100M speed modes
>>>> for XGMAC IP.
>>>
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
>>>> @@ -405,6 +405,7 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
>>>>    	dma_cap->sma_mdio = (hw_cap & XGMAC_HWFEAT_SMASEL) >> 5;
>>>>    	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
>>>>    	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
>>>> +	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
>>>
>>> The commit message does not mention this change.
>>
>> Agreed. Will do in the next version.
>>
>>>
>>> What does XGMAC_HWFEAT_GMIISEL mean? That a SERDES style interface is
>>> not being used? Could that be why Serge removed these speeds? He was
>>> looking at systems with a SERDES, and they don't support slower
>>> speeds?
>>>
>>> 	Andrew
>> As per the XGMAC databook ver 3.10a, GMIISEL bit of MAC_HW_Feature_0
>> register indicates whether the XGMAC IP on the SOC is synthesized with
>> DWCXG_GMII_SUPPORT. Specifically, it states:
>> "1000/100/10 Mbps Support. This bit is set to 1 when the GMII Interface
>> option is selected."
>>
>> So yes, it’s likely that Serge was working with a SERDES interface which
>> doesn't support 10/100Mbps speeds. Do you think it would be appropriate
>> to add a check for this bit before enabling 10/100Mbps speeds?
> 
> DW XGMAC IP-core of v2.x and older don't support 10/100Mbps modes
> neither in the XGMII nor in the GMII interfaces. That's why I dropped
> the 10/100Mbps link capabilities retaining 1G, 2.5G and 10G speeds
> only (the only speeds supported for DW XGMAC 1.20a/2.11a Tx in the
> MAC_Tx_Configuration.SS register field). Although I should have
> dropped the MAC_5000FD too since it has been supported since v3.0
> IP-core version. My bad.(
> 
> Starting from DW XGMAC v3.00a IP-core the list of the supported speeds
> has been extended to: 10/100Mbps (MII), 1G/2.5G (GMII), 2.5G/5G/10G
> (XGMII). Thus the more appropriate fix here should take into account
> the IP-core version. Like this:
> 	if (dma_cap->mbps_1000 && MAC_Version.SNPSVER >= 0x30)
> 		dma_cap->mbps_10_100 = 1;
>  > Then you can use the mbps_1000 and mbps_10_100 flags to set the proper
> MAC-capabilities to hw->link.caps in the dwxgmac2_setup() method. I
> would have added the XGMII 2.5G/5G MAC-capabilities setting up to the
> dwxgmac2_setup() method too for the v3.x IP-cores and newer.
> 

Agreed. Will do in the next version.

Will ensure that mbps_10_100 is set only if SNPSVER >= 0x30 and will
also conditionally enable 2.5G/5G MAC capabilities for IP versions
v3.00a and above.

In the stmmac_dvr_probe() the setup() callback is invoked before
hw_cap_support is populated. Given that, do you think it is sufficient
to add these checks into the dwxgmac2_update_caps() instead?

> -Serge(y)
> 
>>
>> Best Regards,
>> Rohan
>>

Best Regards,
Rohan


