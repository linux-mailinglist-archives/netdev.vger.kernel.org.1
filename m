Return-Path: <netdev+bounces-244114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D44BCCAFEF4
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 13:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48FB03012DE5
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F41D326D50;
	Tue,  9 Dec 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kNYZDKv9"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61FB326937;
	Tue,  9 Dec 2025 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765283492; cv=fail; b=GA8z5GzfzbKUGaNifBo+LwC0U3QtYPKO99ghbsHoGQjtDrxXUP/DM3I/I6tGgrMirFJLpd5hve8EQFcIaZs7DIVBfR+i/pe5Sl7jadcj8UOYHnQqFd4DfjQXDhS8hw6O9QEThCbB9GiLW76WilEEJ1O6WcUT14cLjFuUDA+i1ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765283492; c=relaxed/simple;
	bh=hAGXh0ryCStyN/WiTSSG0SPSwWBPu3SZO6LXKfbeLuk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OoEcAGVjLNrsxWwThWd/vx9UhuNvsVYTE/gaLDbZSQhQQLUiqCqvMsoFJrI9B9+BlOMKY/1W3jTwvq/FOGeddIn2GeaZxZjN+96FhZhYctEeVChhIzPfoKzbFjX/x27HxTr7LepOD8Mq6lZms/dzfirLiqaup/e3WDOqh8FTWIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kNYZDKv9; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j37CWbOKqQnv1M79XYJulE2TYR2aJk561KCGWJUJCQH04EmaehyECJQ619Xj2F9uf66LH8QMMN1iJbAYxKdx+BckZYo/dNLg6xZJWEAISbYUtZ14l56DWEUkG2WEDERAguZajiKlden59HJGdkzEmTv/q4VOMyslugtNcZm2OgAaG0NrMzCZ4t+JFUve/5H6kvT/PBEpYuEd75EPB8TN3tg7nko1o1BC8Ed2vHgLN54Uy5eFWuR9zXu+Im81D9Ff5EweC3LjHl/gDZ+lO0eVTx9pBCgnLNmVq/nEykzZ5qltml9XG8Iw8K5wOKZ+yQpdRpg0akuWhzCuOZhyaar1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frMEjUszukWONGPQCqB0r6vopEunQEfv7gYynINHG7Q=;
 b=ifUPesuGxphAZTIEkOYsTWdVzlQKTRd20Mk03qaOAgh57ksDB0arN2ouZjM8SKycdDwkxyxBb8TFldwNY74x5+U2VAxjSv/xT/FpY6piUBvmL1KY/wVnmdmOZD0txi31o0jkbKuV6ny3PMFZvOyJQ/+NsP3v/HvBL+OY8oItiOPTeB9xyUO5KcrZ5bE3PJKYrxXNEgC6cLrN9onVgcUpbsRJI1AqGGGH9346YP2fIlXYHvN2Nt+yV2/Vmux4vL6oI4niFYANnehVB7AJ1DGq90vkjC5uLU4XdvH0NUyeHgezbKEMet4A4nkb6046ivVECMjlHlMab07AmTOpaSMVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frMEjUszukWONGPQCqB0r6vopEunQEfv7gYynINHG7Q=;
 b=kNYZDKv9iekoGN5SAH18kWz0PcAlZV/R8+Nc53FTvT/QW3QxCkfFAf/G/qI+tRKedHZIi3yw22Zah/QmJGJhqjHWd8Kid4alsm5RKb5VxyehiVBO+tziTfi+URNB90jSr0W/oVRgVgqIBVoiY5v9PfZn/1WF8AsuDjyx2qmVykU0AMGEe2ppZo0lwrhFFwfanME4XQDauNS7DvCrydSehg/lMtUOllOc4fD9bciikIU4a5ZopqQ4cmrhaDvH/xAYO9a0hJ00RzuGRr6LEpoMu3fqhWwtzZD5Ky2xcZFQSESUBc5U2kJDfZveYGacShZfB9VYE9+d+nQN5JhvVA0eTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by DS0PR03MB7678.namprd03.prod.outlook.com (2603:10b6:8:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 12:31:16 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 12:31:16 +0000
Message-ID: <9f0da5db-e92a-42e2-b788-2b07b8d28cfa@altera.com>
Date: Tue, 9 Dec 2025 18:01:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: Fix E2E delay mechanism
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Richard Cochran <richardcochran@gmail.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Fugang Duan <fugang.duan@nxp.com>,
 Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251129-ext-ptp-2v-v2-1-d23aca3e694f@altera.com>
 <26656845-d9d6-4fd2-bfff-99996cf03741@redhat.com>
 <aTFuJUiLMnHrnpW5@shell.armlinux.org.uk>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <aTFuJUiLMnHrnpW5@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::36) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|DS0PR03MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: f011b093-edd1-4be6-e01f-08de371ed90b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amNiSEh0c3NLZjlNVVRhOU41cERBWktUWGZKT3MycWZwaGdTdFBqSkcyTHN4?=
 =?utf-8?B?V0tsVEE1NEFBdy9kWUh3a3Uxelk2Rzl2UFA5SGdqZ2JNdHBJaXpKQXZQWUQ0?=
 =?utf-8?B?bk5lZkpaZUI0SldzRU1CN0NuMTFndzUvcWtuR0x1YTdibEo2Q3lIZ3pwbytD?=
 =?utf-8?B?NEZacFBPekNreHR6RjcwZEo5RDZiWFdEL1JmenR5dDU1SWFMbUFGVWhFV3p3?=
 =?utf-8?B?aDk2eDFkMkdhZWhxOU50dTNHN3BBWi96U2tGSHp6WGdOeDQ3V1hXcVJzKzA1?=
 =?utf-8?B?ZXk0VkVhbjViUXN4dkVha2s4ZEEzMkV3NEw1dVEwRlNVdTh3UTJEMk1HMElD?=
 =?utf-8?B?UEpwU29WNDhlRmptWjZKWjNjNTRzMDVGM3VER2M0b2NnTkZHcHpTUHNSeWkr?=
 =?utf-8?B?a2VLV21mT251NkhJNzhDMDVtcEh1ZC9GVXY0T3VQNDVaazhtWXVPYWxTeW5F?=
 =?utf-8?B?MkJGc090YVBHOUNLdUM1TjVlQkhlNWxlYWZ5UUdIUmlmRlRZMVNhbWJLVGJl?=
 =?utf-8?B?aFA4SUJqbzE0RkRITU5wcFMycnd2cHl5dTBGMmJVUjlKUnBZTG9oN0h6MDFV?=
 =?utf-8?B?T0t3TU1OZUZDWHlCODE2Q256SmRIRXpUd0JUMzFrVlRUNm8xYVBGU1BmQ1NZ?=
 =?utf-8?B?VjM1WWM5MGlhbU5WMmNlSEF2L2V2MGg0K0FtK2tnN0FObmFhbkJ3eVo0T0JY?=
 =?utf-8?B?SVB0dEN5MmlMVVFtdlpYNjVaVmRhNjIvYlBsN0M4eEdFcWo4ZURrMkxpZmg2?=
 =?utf-8?B?MFlXL1h0OEhXSWhER3Uzc25oK1EzTXY2elZiV3B6ekExRU5UMVJWbnIzUzI2?=
 =?utf-8?B?NnI0R08vSFFxSW5ESEJmaGhVZ21FeG5qZjUvcUt2dlRyckpySktNZWlta1Rk?=
 =?utf-8?B?dXNLd1FnQlpQUVJMeS95UDBqcnp3OTROZ3ltN20wY3B4MEFad2huUFJaWG81?=
 =?utf-8?B?NTVDQkRaWWlkRlYrS3dZZHQ3UlFJNzVZSTRaUGM2VXF1VHZHY3BhR2ttYTdW?=
 =?utf-8?B?VllaL01OUU55YUV2UWdzbTFVZGcrWmpEa0VIa21OME9SeEEzZFVwb2VyS3Yw?=
 =?utf-8?B?MWhMakJsb2w1K0pVbk1ncVlDN0lmQjl0ajQ5bFY4T25pcG5jczk0WXprVFl4?=
 =?utf-8?B?V3JubStCQmhqMjQzdlVTa2RaZXJ5MzNHNFVpSlRmVUtVb3ZQczlnR2hsZHpG?=
 =?utf-8?B?TVA3M1FnQ09CaFdhK0NKRUYveUIwUFVEcGx3bmg5ZjlxZEVlS1ZtdTQybFJE?=
 =?utf-8?B?TXNWclU1OSt6Y3ZYMVFFdHFTQjZodXlONk8ybDNyUXEyYmNoWTRBRW9KcnJy?=
 =?utf-8?B?eldQSW5rNG5MNUd0K1oxSHN0YXRqNlJaTFNYUTgyTjNRYmhMa1JvYmYxTnJp?=
 =?utf-8?B?VVY1akhQeGg2ejhkVURMQU5RYjNHbWkxY2RRQUp0R28zLzhvQWN1WVlsWlRX?=
 =?utf-8?B?Tm9NR2V4UXNEU3ZOYUorc0d0VENaRGllNmVDZUZWTHZVRHYxMzFkUS96ZGI4?=
 =?utf-8?B?Wi9qZzFLR1dFZmx0cFpBMC8wQzdvSTVpQllDUStaRS85WHJNSm41eEdXeDVW?=
 =?utf-8?B?TWtiTXJQQ2VKQ1Z0SkNHUFVScTdhWlp6c29YT2Jwc1lPcmhDbXE2L0I4QjNK?=
 =?utf-8?B?czJxdlEvY1lzUUxkVmF3NWdBcUVmZDFPMXZTQW5JTXZJdDlZQno0VmQycVIy?=
 =?utf-8?B?VWZFaUJ2QTNTM3Q0dXZ2aGNzM2ZNYWFDS2JyOVFEdEhWS3JhU2EvaGtyVGpv?=
 =?utf-8?B?dklaVXNNanR4bWZxc2dpUFNudmNzUldLcHV5Z0R6cVlleUxONDFTY2lVUVJP?=
 =?utf-8?B?OG9yM3k5KzVlUE9pZHhaU1RZNzBBN0EvTisrQW1vRGRjLzZaVWlGTWIrVXJJ?=
 =?utf-8?B?VjF1bkpLV3RxanlObHlsVHUxREtqVlNabHc0YmYwUkpNUEx5K0ZQRFdnRGg1?=
 =?utf-8?B?K2tQYno5TGVwZU83RFVHSGNVSU5BR2ZiUE5wN0tjTHJieElULzFRbEZhbnR3?=
 =?utf-8?B?cmhhRHh1Lzh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1RiZWl2b1U3Y1AzVDJHU3BCYUR5MTA1b0VTY2JPNjRRSTZ0QysxTmpDbjNY?=
 =?utf-8?B?NnVNQldMc3FOei9BRGZBbm15cHgwZlc2cnV0SW9sMzlqb00rVS9nOU4zajdz?=
 =?utf-8?B?RlFkZHpqWFphUmVyWXNyYVFHZVJDZWVIejg1R25KSjRoN1cvM3BTSnVyZmp4?=
 =?utf-8?B?bUN5djN1MTRMT1JQWUtUMDFRZVhXekE5OElHWE5Xb1FadnZGUm1Nb0RYZXBW?=
 =?utf-8?B?ZU5VTmdEOTR5ekU2WU9HNmY5QnN0SE9jRGlDR3k4eGZLMkVZUElVc2FJSVZR?=
 =?utf-8?B?cWM5dUtnNkIyNHY1blRUZlcyVWNiR2JpSEJra25MKzhiM3k2eEwyMW1YVFZ3?=
 =?utf-8?B?Mlpyb3EzMU05MmtQQ3lNQUFpZGxDaGp4QjJpRTcwbzFGRDYzc2FXaWR0ZkZp?=
 =?utf-8?B?a0tyalVaZDZWVjIxQjg3Z2NFZ1FXZkdYZkEvVTZVN3gyYTd2ckgrTHM3emMw?=
 =?utf-8?B?Z3VSQUhtQ3ZCQnlJR2pRanE3Ly9IZGhtWmFpOThkMWd2SlduNUVhRmdJQThR?=
 =?utf-8?B?TTNBUWwrUDJnVUdVNFYrZUNocXBIbWMwb1J5bFJhQmxOWXBYRmtwMS94TGwv?=
 =?utf-8?B?WlZHQ21ZN0ZWeWhVcUt6Z0c2VVBsRTdmRDhNd1ZuUEpEMTladHZ4c1VTTHZz?=
 =?utf-8?B?Umg2Q01uMjBndVlGVC9CWFVpSk94WXgxd3pHdUpWczJyYmd6L3UxcHllMlBW?=
 =?utf-8?B?M2xqRFdCNTJpM3M2TU9GRG9UUk9zcDZ1dFRHd1JLUWQrbkdnRFhwak5uV3NW?=
 =?utf-8?B?dlJRNDZtNVZiVXR5MjhFNjYvOENBL09HZGgrV0RCbThEbStiQ0pDbUF5MDhW?=
 =?utf-8?B?WTFnR1pEYjByZTdiSkc0MURnV2lXMUNYRWRIbVdGd0xIUHV4QllZNWVnN1ZL?=
 =?utf-8?B?NnpwK1RXWkovVk5IN2JDQWF6d0IwcDdXVmNwUnM5elI2Y3lNQmFUMjBSL2lj?=
 =?utf-8?B?eFpHNzlYZmFLQzBqVVdzZGpNR012VWFuamNZOFpZOUh4Qm80ZzB4S0pKOVFP?=
 =?utf-8?B?VG5NS2lEdDMyejk5ckJzK2xvdVJySjFtUXdEUmI0RFVPTkE2TDlwWHRCU2Z4?=
 =?utf-8?B?ZTBMMnRRTG1pWWRZUVZFUlIwbFRNUUpWVStSSXZ1SldqaEl1ZHBaOWhjWitk?=
 =?utf-8?B?Z1o3WWpwV2VJUHUzNUN5dUNsaGEwQldMaE5jemI0MG5zMm0xVjBRdmpoTEZF?=
 =?utf-8?B?aXdLRzlweEkraFdiUTVISVNkcVVhUnRWQ0xGYzA1WFBMV1FkYmw0LzNwalh2?=
 =?utf-8?B?WkJvaTgzSjRWUXQrK09xRDdnd0tqdDBTWmVsZGJnRjBMcnVjV25Ea1kzc3do?=
 =?utf-8?B?UzlZcTJrOGl1ZTJFN2xJZTZqR0l1ZXExWjA5SVo1YXlEMDJ1cVdidEJTRml2?=
 =?utf-8?B?YWxmcllRbHFQMnJLQno5bnpCS2JqY3c5emR6N1pTd1l2bnV4WThHcWRiSllz?=
 =?utf-8?B?cTBDdlV1Z291OHV3OUgvUE1kY2l2RWRUS3NMa1B0UUE2cHVld2U2TXlCRU5t?=
 =?utf-8?B?d2E4dk50V0tQQ0poNVdETkt1cHRnd0dFTWc2N1UrWmVyNHNaRDJtL1VlQ1R4?=
 =?utf-8?B?Wk4yTzNRUGVaL05QemVWVFplNW5JS2FtS0ZicGorT3hHME1VZGpJY2VYd3Vl?=
 =?utf-8?B?SElEWllRR09RZ3VFMWd2YUlOY0t2dm8vWjVMVEpoWUFtUHNibGN1K0JWY0NH?=
 =?utf-8?B?UGllak90L0Z3cFlxcUdFNWJkOWN1dGFHaXNFSElqYmRySk4wc1VvOWNVTDIz?=
 =?utf-8?B?UXdCYkUrRTBXMVplbkYzV1ZYNTRUc0VqK2FrblNGTUYvVjdXN1JNS0VHWWtt?=
 =?utf-8?B?Y3NwR0gycHE5Qll0QTZLMGozbFhDczdkNEZGL2g0QmlFcCtxb0M0MnR2K1Y4?=
 =?utf-8?B?VEpGSWh3SmhZeGx5NXZiUXlRU0NpZjRaVXB2VzgwNW1ubUJuaUx2ZG9seHc0?=
 =?utf-8?B?RjZPRHJ2Z09Pd29KWTN2QTFzK21QU0ZPTkQzYlhnTnlzeHFKWUNDSVRWRUR5?=
 =?utf-8?B?QmJmeUIzUTg2bnFHWUk3ei9iRjhRM0pSUDhpYjMvc0c1UUVuZWJ4QzhJMjBl?=
 =?utf-8?B?YzhTWXRXV21ySDZIeWkrN21XWDRQcTFvYU02VnF4U0xwZVk2bmpYZnlPcU5Z?=
 =?utf-8?B?anQ5VVorRHdhM0VEYjRhYmVWbkNwa0ZwU0RhMEhoa0xPdnExV09jcGoxRVht?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f011b093-edd1-4be6-e01f-08de371ed90b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:31:16.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REPe/J/RzhXFPqCqtSpB6YSeEup6kBD2v4FlVzgtFj/YAbkzijkYR2qL1ddRSU6Lb1x7fQs6mZWSc6D5maWteyQwvg8mIOwuVITZ+cOx57E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7678

Hi Russell,

Thanks for reviewing the patch.

On 12/4/2025 4:49 PM, Russell King (Oracle) wrote:
> On Thu, Dec 04, 2025 at 10:58:40AM +0100, Paolo Abeni wrote:
>> On 11/29/25 4:07 AM, Rohan G Thomas wrote:
>>> For E2E delay mechanism, "received DELAY_REQ without timestamp" error
>>> messages show up for dwmac v3.70+ and dwxgmac IPs.
>>>
>>> This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
>>> Agilex5 (dwxgmac). According to the databook, to enable timestamping
>>> for all events, the SNAPTYPSEL bits in the MAC_Timestamp_Control
>>> register must be set to 2'b01, and the TSEVNTENA bit must be cleared
>>> to 0'b0.
>>>
>>> Commit 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism") already
>>> addresses this problem for all dwmacs above version v4.10. However,
>>> same holds true for v3.70 and above, as well as for dwxgmac. Updates
>>> the check accordingly.
>>>
>>> Fixes: 14f347334bf2 ("net: stmmac: Correctly take timestamp for PTPv2")
>>> Fixes: f2fb6b6275eb ("net: stmmac: enable timestamp snapshot for required PTP packets in dwmac v5.10a")
>>> Fixes: 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism")
>>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>>> ---
>>> v1 -> v2:
>>>     - Rebased patch to net tree
>>>     - Replace core_type with has_xgmac
>>>     - Nit changes in the commit message
>>>     - Link: https://lore.kernel.org/all/20251125-ext-ptp-fix-v1-1-83f9f069cb36@altera.com/
>>
>> Given there is some uncertain WRT the exact oldest version to be used,
>> it would be great to have some 3rd party testing/feedback on this. Let's
>> wait a little more.
> 
> As I said, in the v3.74 documentation, it is stated that the SNAPTYPSEL
> functions changed between v3.50 and v3.60, so I think it would be better
> to propose a patch to test for < v3.6.
> 

I tested this on socfpga platforms like Agilex7 which are using
3.7x, but don't have any platforms with dwmac <= v3.6.

> Alternatively, if someone has the pre-v3.6 databook to check what the
> SNAPTYPSEL definition is and compare it with the v3.6+ definition, that
> would also be a good thing to do.
> 
>  From the 3.74:
> 
> SNAPTYPSEL
> 00		?
> 01		?
> 10		Sync, Delay_Req
> 11		Sync, PDelay_Req, PDelay_Resp
> 
> TSEVNTENA
> 0		All messages except Announce, Management and Signalling
> 1		Sync, Delay_Req, PDelay_Req, PDelay_Resp
> 
> No table is provided, so it's difficult to know what all the bit
> combinations do for v3.74.

In 3.73a databook, Table 6-70 has the following information and this is
similar to v5.1 and v5.3. But don't have 3.74 databook.

SNAPTYPSEL	TSMSTRENA	TSEVNTENA	PTP Messages
00		X 		0 		SYNC, Follow_Up,
						Delay_Req, Delay_Resp
00 		0 		1 		SYNC
00 		1 		1 		Delay_Req
01 		X 		0 		SYNC, Follow_Up,
						Delay_Req, Delay_Resp,
						Pdelay_Req, Pdelay_Resp,
						Pdelay_Resp_Follow_Up
01 		0 		1 		SYNC, Pdelay_Req,
						Pdelay_Resp
01 		1 		1 		Delay_Req, Pdelay_Req,
						Pdelay_Resp
10 		X 		X 		SYNC, Delay_Req
11 		X 		X 		Pdelay_Req, Pdelay_Resp

> 
>  From STM32MP151 documentation (v4.2 according to GMAC4_VERSION
> register):
> 
> SNAPTYPSEL	TSMSTRENA	TSEVNTENA
> 00		x		0		Sync, Delay_Req
> 00		0		1		Delay_Req
> 00		1		1		Sync
> 01		x		0		Sync, PDelay_Req, PDelay_Resp
> 01		0		1		Sync, Delay_Req, PDelay_Req,
> 						PDelay_Resp
> 01		1		1		Sync, PDelay_Req, PDelay_Resp
> 10		x		x		Sync, Delay_Req
> 11		x		x		Sync, PDelay_Req, PDelay_Resp
> 
> For iMX8MP (v5.1) and STM32MP23/25xx (v5.3) documentatiion:
> 
> SNAPTYPSEL	TSMSTRENA	TSEVNTENA
> 00		x		0		Sync, Follow_Up, Delay_Req,
> 						Delay_Resp
> 00		0		1		Sync
> 00		1		1		Delay_Req
> 01		x		0		Sync, Follow_Up, Delay_Req,
> 						Delay_Resp, PDelay_Req,
> 						PDelay_Resp
> 01		0		1		Sync, PDelay_Req, PDelay_Resp
> 01		1		1		Delay_Req, PDelay_Req,
> 						PDelay_Resp
> 10		x		x		Sync, Delay_Req
> 11		x		x		PDelay_Req, PDelay_Resp
> 
> Differences:
> 00 x 0 - adds Follow_Up
> 00 X 1 - TSMSTRENA bit inverted
> 01 x 0 - adds Follow_Up, Delay_Req, Delay_Resp
> 01 0 1 - removes Delay_Req
> 01 1 1 - removes Sync, adds Delay_Req
> 11 x x - removes Sync
> 
> So, it looks like there's another difference between v4.2 and v5.1.
> 
> If the STM32MP151 (v4.2) documentation is correct, then from what I see
> in the driver, if HWTSTAMP_FILTER_PTP_V1_L4_SYNC is requested, we set
> SNAPTYPSEL=00 TSMSTRENA=0 TSEVNTENA=1, which semects Delay_Req messages
> only, but on iMX8MP this selects Sync messages.
> 
> HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ is the opposite (due to the
> inversion of TSMSTRENA) for SNAPTYPSEL=00.
> 
> For HWTSTAMP_FILTER_PTP_V2_EVENT, we currently set SNAPTYPSEL=01
> TSMSTRENA=0 and TSEVNTENA=1 for cores < v4.1:
> - For STM32MP151 (v4.2) we get Sync, PDelay_Req, PDelay_Resp but
>    _not_ Delay_Req. Seems broken.
> - For iMX8MP (v5.1) and STM32MP23/25xx (v5.3), we get
>    Sync, Follow_Up, Delay_Req, Delay_Resp, PDelay_Req, PDelay_Resp
> 
> Basically, the conclusion I am coming to is that Synopsys's idea
> of "lets tell the hardware what _kind_ of PTP clock we want to be,
> whether we're master, etc" is subject to multiple revisions in
> terms of which messages each mode selects, and it would have been
> _far_ simpler and easier to understand had they just provided a
> 16-bit bitfield of message types to accept.
> 
> So, I'm wary about this change - I think there's more "mess"
> here than just that single version check in
> HWTSTAMP_FILTER_PTP_V2_EVENT, I think it's a lot more complicated.
> I'm not sure what the best solution is right now, because I don't
> have the full information, but it looks to me like the current
> approach does not result in the expected configuration for each
> of the dwmac core versions, and there are multiple issues here.
> 

Best Regards,
Rohan

