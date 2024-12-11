Return-Path: <netdev+bounces-151066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C989ECA49
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD0E28279E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC01EC4E8;
	Wed, 11 Dec 2024 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="avgdzTMx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C8236FB2;
	Wed, 11 Dec 2024 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912763; cv=fail; b=OiLlbdHmdrAdT0j7QPCVxcMSPD2Heo01TlSnGpTtHLIIhoedXeBt+6RC+3tBjrqetyOFV1XBWrh0+EemxOttL6xAgYk0pet5epWpZFzcTXaWn02FGdN7YPu9baZOLjA/h6SDn6QMbkm2ZWP5O5Kadk8GGZgjr/DlRvzJ0cOh5nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912763; c=relaxed/simple;
	bh=mQPmQkLnoOA5PZtitAGPgEqnEI89DN2UylLuMKcmJL4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SLWkcdR+3Rn35GrNzs1slM/cZvuXGoiC4mWzOWUdem2Pf5FZuW5Am6oS+/gskcKtg1O2hTsaEaDbUfSdbjNBL+OaA6xbTqSmZ7j8LmDG1rCqVYOYPh2H6l3u2hi687UckFNzG/Ve6V/oA26/SU9alnWTtXicZKrkPbRVRhn/JO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=avgdzTMx; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xy8GkuFFoZIW8Y1El1kINDJShNSsT4RsTJP1Mywm1NILqfOZ+cuNnTIxa31HNv+JgYYtKcS6G+2L/F3nYn0GX+9hdxQmT4G1UrM+8fKS1u5pBlnsLxk9nxV1D8lGBOe4torvKGEalGmYmZ92YoLe63LWYaYzKJkZoMUojGIbLJoQvdEcebwBXXCLOx30ff4VgzJsx3DlasEAnFsBh3kFwCCeYuyK8WK/Z0AbPHWVEyreyt+gdnk05Aym583x0gfJv+f5eKkhPgG3U3nWre+SGq21MmLlXjmHIBOTLK/Q1ONuvldl3u3rQJ6974iJweXA0CC2ztqBAKNguYMyTbDYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iTf546zlyXOnYZToIU/VJfMVVM6aiSiuLCkiALUYYM=;
 b=vgIR6ewG976H2D0vsOsJcrT5yk6Hv44TDoibmVZXRuHeMOsab96vBoWmIMJ0ersKlEkzo1g/d/SXRi3fucEnEdozRm5m/pJBw7jV0orOKzQRR+080XaHQPwuGs3CDxcnX8aU/teBa4HduJ/Ly2o32X338m1qyJeiF86VPYDpVR2TgVUQRxkZ5yr/Ey/juq+NfdYt1JuO1M/cjTMxiQSlVVaylm3VP3wmoV1mUPUdOdNffKo/aGG/X7AX+E96JUYLPIYu4/6nSz78vEUeA2BnPlOZQ7ZGaK1d2hA3On3sicVZLahXbfDQpxyuNm5pBshPIgJ3I2/PRo1SHkiApFF6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iTf546zlyXOnYZToIU/VJfMVVM6aiSiuLCkiALUYYM=;
 b=avgdzTMxv3Jmih859Or57uMNaIBvIilgIr1k4J3MwlyiGt3i1WG++1KOgEYWiVjNZA1yGxaVr7x4ROZ2YD/MJ52WZU3nhRtgqHxrR0iOBF8D/iv565Ih3LXWeTiVfaWuC/eMdzgnFdw904FfLVjcMwo3dNxs4EVTkuUBH0yqYwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 10:25:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 10:25:58 +0000
Message-ID: <d2bfe3af-c3ef-b6fd-6e0e-6765fbed2954@amd.com>
Date: Wed, 11 Dec 2024 10:25:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 28/28] sfc: support pio mapping based on cxl
Content-Language: en-US
To: Edward Cree <ecree.xilinx@gmail.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-29-alejandro.lucero-palau@amd.com>
 <0f2c6c09-f3cd-4a27-4d07-6f9b5c805724@gmail.com>
 <bffb1a61-bc47-cc60-6d1c-70f57e749e36@amd.com>
 <25df5f6d-096e-593c-9b6b-710658415a2f@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <25df5f6d-096e-593c-9b6b-710658415a2f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P191CA0056.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::31) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 910bb743-dc9c-4cd3-281a-08dd19ce33f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3dnZ3Jzd1V1cEt6OHBpMEUwOEJmcXdqbW8ybGNrZEk4MnVDS3F0czFDZUJI?=
 =?utf-8?B?VGZBaVNMTEFEdjE5L0NHeGZLcnN2WWJEOCttY2E5cEgwM2d5Y0tpdEFkZXc3?=
 =?utf-8?B?WmdrWFVVOGx5bWhVaVM3Mmp1S09Sc2VpY3pZRWVYdS9ZMXh3c2JnMHVDMFNv?=
 =?utf-8?B?clZhUDJMcW9xYXEydG16NVBlVkhtVkJvUG1ucDJ5a2ZYNFJURWd5WlpQb1VS?=
 =?utf-8?B?eUtEUFpmQi9ZTVpPbWUyT3huZnFUV0NuVmVCRjhmVlVnM3ptYUxRY1dqaW1x?=
 =?utf-8?B?alFNTVBBK2d0YnVqV2FZV3VEQWRxYmI5Y24wZ3UrWXFhRTExZThOM3U5aytu?=
 =?utf-8?B?N3RpWm5LTE1WbXY0VWFmMmdmWEYzTTBFcXkweWFMdUw3aW5hekVHTDdZaXBV?=
 =?utf-8?B?MkNjVlRIamhrRFZOUzMrL1c2ck90Z092ajQyNEVjMSt3SmZkNWJBVDFwTGs1?=
 =?utf-8?B?NlhLbzdqczI5VnNTMU96Rm5HWUxGZGNtbVlNY1JLY3A5dGdwWUtadUlxeldu?=
 =?utf-8?B?ZjF3Z09GWS81MDFtSUVrWHB6YWFDMVkwYVhjTytIZkRRWXdsZmZ3Qk1lSy9h?=
 =?utf-8?B?SVhFTzBVSTJHdGR1KzFXTGQvNUdIMWF6dUNpL3ZhVTNMRVhGREdVdVo5WHdL?=
 =?utf-8?B?Q2ZRaFVoUWtxVndBOGswaXkvTlhSSGR2cXV5eDVQWENJQ01VZUhJYXZiTHcy?=
 =?utf-8?B?aGhqZ2FlWVJDQ1MzN29jZEZXeUV5OUdkNzdiVU5PS3krOHlTOU9aZUptYUdI?=
 =?utf-8?B?S252RlRlS0p3VnhRWkVVbUYyS1R4cEVHeDZGbHhVekpNcm9BQzVsYjBlSkVN?=
 =?utf-8?B?bmNRWHZkUEd6MXcrNTRrSi9rUDA4N1JId2w5VmtRUSs4VUZHRlNCTVJ2Y2RM?=
 =?utf-8?B?VGhDMGxrNXFoVEtBOW1ZRWlkUm5mWWN3S1MwenFwVlVSbU0rajROSlpjQktp?=
 =?utf-8?B?bnVnQmxHckIranpPdGkxVmVlcTA0VTd6ZURGd2NtZDNHMHlNY1UyUEFYZFZS?=
 =?utf-8?B?bXJuYTE1WEJCaU5pZzhub0hiYjA0UDRHc2pGYUIvZ2RobWxLQnlrVEYyNm1L?=
 =?utf-8?B?NXY1RERKeVdQUEVONXZaQ2NoTU5lR2N4Q3lNa3FhV3FSV2poR0ZwVCtRbFlG?=
 =?utf-8?B?NVlJdTNMNnoyTXF5eHhwSXBYS3g5TEJ4Q09JWDdSOTA4VmhuRlZXcDlTZEZk?=
 =?utf-8?B?ekswbENpYk5RQzlXS3NZdkZGVDk4Y0N6U0FJczZ5c3VPNmp2RUIzZURib3pR?=
 =?utf-8?B?VTRMR29zemdvZGlIV3pUMzJHa1RxU0hyeUloWkdvTjNQeDhtQmtwOEJuNWVX?=
 =?utf-8?B?QXA0YkVvblUwTENGMVo1alNrT1RuY2U5ZzFpVmtsbndIZ2hUejc3VnNoNElk?=
 =?utf-8?B?QTNwSGxQdU5oZjdacG1YNHlOTnRGVlExa2hwUk9HZmtIU0VjZ0x3M2szU2JX?=
 =?utf-8?B?MkVjMlZ6TWo0QmFUNzEwbUM2WGhFYklycDFLOGNURjNpMlVXbk1hZjB5ZE5r?=
 =?utf-8?B?NUdCd0pjbUM1SUNSTU9WMXp6a0g3OXlYM0JMWDA0SFc5ZGNPZUlEK1RzSXp1?=
 =?utf-8?B?MTJ1QVd6V0tWOXRlTzRUL09QY29wNTdUMENmOFZncjNBVDZ5VE5XZTRUSU5S?=
 =?utf-8?B?V0tUb0szZHhSOVltQWhPVS91SGxoVGd5cFF4Zk13a0Jmait4ZHpvUE9tY1dj?=
 =?utf-8?B?aGNGeEpweGUwZmJrdExucmc0aTMxZXEyY3Rwb0ZJUVUyV2VVc25TYkUyM212?=
 =?utf-8?B?ZXliZFhwNml4ZzdZZ0QyS2pLLzFEVVpZRDhCa2I5TEFHM0o3U1gwMktORXha?=
 =?utf-8?B?RVAxTHJPeVV1K0Z4bnowdEdEUWZsN3hZNEhkYWhCTVJKT0lLQjVvKzJMNlNq?=
 =?utf-8?Q?kPs4+Hv8+NWG0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjBOYUtoTUhUZ2lvR2VBRWNESVc5Q2U3cXFrZWN6UUhtZU1RMzhzajd4OSti?=
 =?utf-8?B?S2dMbE4zZ01qK0NibzdXRC9ITGdidWx5TDJhR0JTQ1hOazRtYnFKaHhoM2lI?=
 =?utf-8?B?b3ZEZS9oZHgvVmdvemJDb3pRd3dxTXJJb3ZJNnhXQVNmUjRWOVZ5cXhNRXdT?=
 =?utf-8?B?SEZTZVJTaUJiUTFQbDdEd0IrY1F1VUtqM1IwMXpMUmZ0WWtZVHl0L1JFUk5w?=
 =?utf-8?B?UkJKOXdIRkZBU01XMVpZOWRsS3U1bmk0b3l1YlZqQ0ljS01DUDFSNUIvbU5D?=
 =?utf-8?B?NzlKb25TQ0JNcXlrUXRLbGQzU1A5QzFWUkdyaVdmR21wUWFJWlFXSTRQR0Qw?=
 =?utf-8?B?MFdGTVNTSExBM3Q1MzcyUEtQQzdiSllPallKSzN6OUt0VDhQbmU2VVJLaXIw?=
 =?utf-8?B?eitLczVvOGdpQVZCcjhqZlZURW9ra3loSzVORTBpL0JNdlNQdk5Pa3ZNNDBM?=
 =?utf-8?B?S2ZIdERkdUpjRUdwYkR3OUVITms5bmt2WWJkUlQxTG1nbU1GSWVoU1BzTFZE?=
 =?utf-8?B?eS9JQmVpYjdHWnI1UXBKN2ZVZ0gxVG13a1NzdHZPNkIyOWptekxhK1ZVeHBt?=
 =?utf-8?B?MEZycElsZXpONXpuZm9NaWxUdkt4bmpmN3Q2L3ArRUkvV1VvV3NzSFVPUFBS?=
 =?utf-8?B?bkYvcE1ncGlURHp1M1FGeDZlVzE5bjhnQis4Zll5eVZRdjFWNGRrTGFBdTRO?=
 =?utf-8?B?c045b1EyVEZ3cndsYmJMeWMvTm9KdjlQRmNjT3ZQdDlLREVBVGZNZllxZjhx?=
 =?utf-8?B?UDh5OFJkaEV5Mm1tR1k1SnhXZDhBZGsyem5nNndpaklONUlmMmMxU1BMWitV?=
 =?utf-8?B?SFNYbzR4RXVFS2x4SzBYMXE2cDRUMWF3dkFWeDlqNGlWVXdZbjBJcGw1NFRH?=
 =?utf-8?B?cXVSTWFZTC9CZ2RWUXlLMjFOUmhrSDhvUU5SbHFIS2g2SmwvbGR2T1Y3Z2x6?=
 =?utf-8?B?MWcxa0tRYTM4SWFWa0FvRXVxdlJON1ZvREZGbWVhYkpyRnJBS2NZUjNGUUVZ?=
 =?utf-8?B?K1kxd09XcklhUTQ5OHZ0NGNiT2dJQkVaclBiU0JBN0wwUmxZUzM5TG92MVJU?=
 =?utf-8?B?aE5kazhmSFpmOTd0ZkE4K3R5VnZFTUd1Nlp3UEt5ZHpoMytFakFZOStzNk1m?=
 =?utf-8?B?OVVneVpoTUNBTG1iZTlUcTF5Mk9HZEUwWjFuWTZtZzloTDY1NmFRdE5wYnZn?=
 =?utf-8?B?VjJoRzlPaFZTSDBvc1ZiMGFzR1huRVh5dWtCNjJWb2FvSUIrR0xJSEY0R2lx?=
 =?utf-8?B?Skd2NCtCNEpuOEkvZ3pQZlQyM3RJbCt0RC9IQkdhRmR0RmVaM3JTWHpCUGdB?=
 =?utf-8?B?WUMzQXBtSDhybzJvWmNNUy81a2lFemNrTHRwdVI5dFN5d3lZVUxSR05CaUJ2?=
 =?utf-8?B?VU1KTXNuZ1FRUWc5THBoYmtzTGRNbVBnQklkQWlzVDJLS0hKNjljcnAzUnpU?=
 =?utf-8?B?dzVmSTRKSkVwRnVBbWRIYjZtdktqd2NHZEljaVptQzN6UjJQdEwvT0piTWM4?=
 =?utf-8?B?cCthYlNXeUkrdmFCVnFqTm9UN3lsNHR2NSswNXMzVldlZkxuZXFrcTVzMVRh?=
 =?utf-8?B?SGhXb0hnL3NFMUZ6QlhDSXZlWUZSTWhKdmF3c3BYWEhSWGV5QlVUUXBPZXRt?=
 =?utf-8?B?WjdBRi9qV3R1My9CcFFIRzFsZmVKMll5UWoxajVNbDg4RjZuK3BwNEt6TlZC?=
 =?utf-8?B?WXA3ZWZxYUlpZmlya0E3Q0VYSitUKzdqUm5MUlEvZk9XdXAyd05PcTFoNVZw?=
 =?utf-8?B?NlljM1pDejY4N2tnclFnVWd6UlV3MFhPdEJnRWMyakVKMWorcW1DUUVvSDJp?=
 =?utf-8?B?MS9ac0JiRldINUR4M2FwVFQ3UHgxdDArdzBtdUM1RXk3c0czZm9LWEZ5dmVv?=
 =?utf-8?B?UGx3Q3IrVUtrbEtyaUQ4bWY4aC9McGpqWlZzY1J3VmpPaThBbFBabDNITGFr?=
 =?utf-8?B?aWI1dTd6ZXpRS0hRZG94TEdDTDlZSFVLOHhTd0JvUDVLOUJTM3lFU1ErL3Zi?=
 =?utf-8?B?WWZmTkg4cG95VzdLR2Q4bjNCWHI4Yk1HQmd3Z2pINnQwRGRTTjhoYktzVlJO?=
 =?utf-8?B?dkVsK3ZLRzNwd2RyMDFWNHdPVE4zTW5NdU5GTWtTTmU5T3FPaEZQQjBGRm5v?=
 =?utf-8?Q?DiKvBN2dng4TVEXKaLUF30Njn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910bb743-dc9c-4cd3-281a-08dd19ce33f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 10:25:58.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dv2mTAQ3Z75qXIf9RSMJ6INuX2aXwgqq/zNRtErxOs5jQDHBfXdsFRa61vN8DKiuoaF+cZoTQBnyJmhXdT34kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329


On 12/11/24 10:11, Edward Cree wrote:
> On 11/12/2024 09:38, Alejandro Lucero Palau wrote:
>> On 12/11/24 02:39, Edward Cree wrote:
>>> On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
>>>> @@ -1263,8 +1281,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>>>>        iounmap(efx->membase);
>>>>        efx->membase = membase;
>>>>    -    /* Set up the WC mapping if needed */
>>>> -    if (wc_mem_map_size) {
>>>> +    if (!wc_mem_map_size)
>>>> +        goto out;
>>> Maybe this label ought to be called something else; it's not really an
>>>    'early exit', it's a 'skip over mapping and linking PIO', which just
>>>    _happens_ to be almost the last thing in the function.
>>
>> I do not know if I follow your point here. This was added following Martin's previous review for keeping the debugging when PIO is not needed.
>>
>> It is formally skipping now because the change what I think is good for keeping indentation simpler with the additional conditional added.
> Yeah, I agree that additional indentation is undesirable here.
> (Although that does suggest that the *ideal* approach would be
>   some refactoring into smaller functions, but I'm not going to
>   ask you to take on that extra work just to get your change in.)


I appreciate it. :-)

>> Anyway, I can change the label to something like "out_through_debug "which adds, IMO, unnecessary name complexity. Just using "debug" could give the wrong idea ...
>>
>> Any naming suggestion?
> I was thinking something like "skip_pio:" or "no_piobufs:".
> That way if someone later adds another bit of code to this function
>   (to do something not PIO-related) it'll be obvious it should go
>   after the label (& hence not be skipped), whereas with an "out:"
>   label normally that means "something went wrong, we're exiting
>   early" and thus additional functionality gets added before it.


I like skip_pio. I'll use it.

Thanks!


