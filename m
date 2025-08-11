Return-Path: <netdev+bounces-212502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23745B21101
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB98500B7A
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE1D2EA73F;
	Mon, 11 Aug 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ogqg01Kz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3272EA730;
	Mon, 11 Aug 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926843; cv=fail; b=K9v6obLMy85ZpMVUMP4e5Q591nNmh0BI6VBuxJIcNIV9izY3pp4QDfleWaF6PvSc5ObirV9HbjNa0uhity+/Kn078UZLZyhIB29Q5kY2s+v6VCjHWPzVLcckwlxLlRL6VWGqQkmeyj7lL1BtqwIVlOkn/IZiNUShObgZpm66VZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926843; c=relaxed/simple;
	bh=CUHMEWzhNJkg29afeGmnZfXbs9J9dvVetcTADNbOh3w=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jH26KH3+oVZKuyzfo0sZNKVX4PA9+DTMj2vs1xIG5jKiELEuVCUbafTP0X5mtCpjshQixpzxX5iJtJn9nFSyug6b2TtFbWNkIc2ElfRg4JySJQMI4dAjAWoAYoZR/zD3Rgw6BXieCY6/36SrjPKavMGiLyBiAkEWM3MoH+tWm3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ogqg01Kz; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6i2rg7oCyWS+WRQfWuj5J1u+1FPfQeGUKteJNbvJ/JRp6iatsbHvrUQiCmgUhJpOLwtmIB5+QkaP7nHsVkMU6KpOg+3evolmWL5Hdz0jxSI4Eegp74DSWtiLucjbJGtk0CAfcPK/mq6hDH73EOtJQOZw2KwY9JkkFiJc+XuA3einUsqKXctcxfYwQaftO2m+06FrvsQgzdL/WggCVeBf5PDa2ecQWSxRMV9qgg1Tfe7/Wu/QEXS3OF7yJTDDDgzUdeO0ocmx+8+dHCaGIEaNyYHbMZdqQwT1mewm6p63AZy5y+erROqMhWbI5qQpOXivyo7URR42nFyTuWHwLgXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLtb64lNMIZfsgaFQnvqu6y4a57LpgjnBHzODnq8MXw=;
 b=SGzv9pfHXMp0HuAKyINhgJnxpFPVgCO/SEbcZcDCRdLrf1t6v+FqbY6sS/PzkxblaKS9hSW5zRjBTbhbuT3br1g1btGHZrBFnB3/TYGpTLJFmJQnrEbT0VK4uxTg98+mpVWrg83GUqw8Khy9Gxc6ht2J889yda3EHffKrvRDgRwJFXB3MZjK8W5w5gtiBToJzPZjBlRi8ZpXi2nW34wCLnndCgtxdyPThwTiWD7QcBeLvjEY+fWjMxWH5Wm8fNND2QNnw5HaeVAc4LFzWkT02VR9yNFnKBF1gucJpGTFrQtTEy8hlAqk8p5A2sj1BgsKC+CmOtpi4vhC97hqtNwoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLtb64lNMIZfsgaFQnvqu6y4a57LpgjnBHzODnq8MXw=;
 b=ogqg01KzOjMLINWJGeVl33zgbcbEYXEkcSZnxsNDWaorkfMZmeXEfCNVK6NqNWPHtROnme/Gaap0ukHBidECsEL950MZL5fjr4TxOxPvqr5KtqGp41HoSeH8ZmBVCur+WZNa/kZGRM63VCm2yFeaJgvs2H5O3OqSlE4H2srlPtwqptZF4IAuoEncdnWVfzTypIQ0fvgg/9rzRECCZZHDyIHzKl99EYxmgRqKkJBZKazAf5kslHrVQB/khQjeMUJVKt1Lea5uXaBxJj1dCo6KH79htE6IY6Uraz5LO1Z0ZUAlu0oofxDXeStS+zGozkc7Zup7W261w5Vu/pneqgyX8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by PH0PR03MB6333.namprd03.prod.outlook.com (2603:10b6:510:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.11; Mon, 11 Aug
 2025 15:40:38 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.9031.012; Mon, 11 Aug 2025
 15:40:38 +0000
Message-ID: <a70d060d-f1c8-4147-8f1b-1c7ce6360252@altera.com>
Date: Mon, 11 Aug 2025 08:40:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: Agilex5 Add gmac nodes to DTSI for
 Agilex5
From: Matthew Gerlach <matthew.gerlach@altera.com>
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
 <13467efc-7c79-4d06-af1c-301b852a530c@altera.com>
Content-Language: en-US
In-Reply-To: <13467efc-7c79-4d06-af1c-301b852a530c@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|PH0PR03MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ac96cb-e9d4-4049-b5eb-08ddd8ed6bc5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGF2aEI2K2FENG9RRDBmWkE2eXNJTEZ6eWp5eEVNUVdxR21uTHB3NDEzQnpR?=
 =?utf-8?B?NWZYeXM4QXVZalhJOUFReGR0MG1HQmt5TDlRRHMrRWtQY3dCY3A2ck5sdTc5?=
 =?utf-8?B?dlQwUnpFTTN1cTZDL1RQck4yQ2ZGRytwNzZVRVNZVVRtcGwyNlhKOTRldHI3?=
 =?utf-8?B?VE05cENybFJNKzR0OENWbUpJdHQ1emtBckhhbVFiNTdlWTMzYjVMd1p0NVBq?=
 =?utf-8?B?dzBoamduSUNrL1lFeStzQ3VyWUxBdDJxWnB5dWJmK3duNlZMZ2dvSk50UzRY?=
 =?utf-8?B?ZEFaeXkvVW8xMjlNK01kRk1Qc0VFM0F6M2wwODZBZWdRcjJSWTRoV2JwNnZ4?=
 =?utf-8?B?eXBWZTVvTmtScFV6VjQ5UkZBeWdrcWNVZW9Zbkl4SUc5bTlIbmFlRDYvTmpr?=
 =?utf-8?B?NENiN014ejhkekRGazN2UWdya0Mvc0FIOGN3VXZVbk5qR3h6azEvb3E1a1ha?=
 =?utf-8?B?djZjTDVHNEVQblh4R2NwL3lHclJaTHZ0dFRxYjJKV0RNNUhsdWI1bkRUbTJu?=
 =?utf-8?B?Uk0rYVI5R3RSN20wakI5ZEtkYmlMK1JjUkFudXNxdG1uRzhJV3JsdXNMRi9E?=
 =?utf-8?B?Z20vc0xZcHNtbDRqd2Vxc1VFS20wc2lhR2xiV1VFVHFhMmNuMmpWTGovb0tj?=
 =?utf-8?B?YjU3M3h5MTZZVHArbHdOL0N5ckpueTE0Nm1mS25wOTZVaTdQRGt0SHJZSGdG?=
 =?utf-8?B?VzdFMDJlcVhhc0F1QTZMSEw1aTV5ekdRdjJHNVBhYzg4UzZZclc1WFVDbEto?=
 =?utf-8?B?U2FPc1VvZjdhaXZYdy81dGR6VXIwQnNOSStxTzREVmREZjhvZng0a0kyblpI?=
 =?utf-8?B?RFVwUldabFVCbHUzdndrdStlWDFyL1dZSjZHVWtUdUFCdllIQ1VQbStNZkh4?=
 =?utf-8?B?ZXJYdHErN3A4RkFJb1BPR1NOa2RiZTE0eUpCUEZtNk1UWW5mT2RaTWZZQU9v?=
 =?utf-8?B?WW1vRmxKTUJsSGsxcUt0Z3poSlJwVXhWSUY2SFFENDlBbGlkZFh4VGwrR1Vu?=
 =?utf-8?B?TERFdE5LSkhuTEI4Rzl5SVRJeG8wMmJwZ2s4UXc3akwxR1VidTBQWk1BblE5?=
 =?utf-8?B?eDgvNVN5QnZHSkhuL3V3K0MzVlRBem4rb1lrdmxSN3ZNVVVrSGxZbllPbG1K?=
 =?utf-8?B?YUFxbVpQSlEwaDNpWlZXQnkxSmNXd0MvaDNQWFFhWmRoZHVxdWVDcmlCWThV?=
 =?utf-8?B?UzlQaGJFbXpLZFlNcTc2d0N1bFdMZUhqdndyYlBhUGpWY1BQRFFmeGdzZ3d4?=
 =?utf-8?B?SmVQbjQrZVVOWGdzSmk1ZTYrWGtJcnB5MlJ5d1dkWXR3NTVWMmc0RStWSzkz?=
 =?utf-8?B?K2N5MUxGamw3TDU0QmVHbXpGQUFtaHQ3U3BDcjFZaGlCcXJhamJYSzFxbGNC?=
 =?utf-8?B?a2dhOGRhZFZwdXVvSWl3RUhkVlZRSVFNREVLckd1V3prNUVtNlc3dDVGazk0?=
 =?utf-8?B?M1FqMFp5U2hKVlRabGY1bktMVjY2akNrOG10c2ZTSDhDejBnN05BSkZnZDFk?=
 =?utf-8?B?ZXpkNjZZTnNwSG9iRmNRY2ppelhWcWxsVFBXem9wNmZmaGFTa3AySnJlb2Vv?=
 =?utf-8?B?RmFUL3YreWpWTXZHdTdMeHhuWGEwZ3Z4M3NvVS9ObHNvaDV3RlhQN2lzVjRW?=
 =?utf-8?B?TW96TmRBOWJxSUtGMVJ2VFk5aSszUXJ4c1BvMzZqendqMnhGTjd5VHNKRFNU?=
 =?utf-8?B?RENXOFhDRVJoQjZOWDVablBPUk8rN1FJWE11NnE0OHZKaDJuK3d1V3pDMk9j?=
 =?utf-8?B?ZXN2dEtydHNqYUc0Q0YvMTVqeVdTQloyVG1rWnNyYmZCeE42VWYrZ2lQZkpO?=
 =?utf-8?B?WXdBVnNtZ0lGSWlFNllhVzV1UG9FR3ZwMGNva21pSi9MZHRxQXZjajAyNzNh?=
 =?utf-8?B?bDhrdFc1MFhHZDJlS3NwdXVialFWaHU0YU95UWdOb0krWkRRd2YxaGVpbUNW?=
 =?utf-8?B?RkVKYmxGUFRrb0lQeE1Qb1RyTmRFR2dhT0crKzB5V3pZWmdsT0dWWis0NUZw?=
 =?utf-8?B?clQ5MlZJR1pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3loUjBCRjV2djBQTE9ZTlh5Q0xoaEpTdTljcmlvOW8rRFNndGVtblRaR2hp?=
 =?utf-8?B?OUtLNUVDU1oyTjFHZVAzcTZEbXRXZlhUVUR1OGxxYnFIUFJvVkZZUDJ0VzQ4?=
 =?utf-8?B?V2lYRzlSUEdPaEp3cExkU3l5bUNmYktUYlkyd2VPd2xzcGVkL0o1T1h0OGp0?=
 =?utf-8?B?NDIzVkJWZXc1a2EvTUJaTEdPVzU3U0psM2dYYVhjS2JCMXB1T3lJd0Z4ZWxH?=
 =?utf-8?B?SmdwaG0zUW9FemRob2VqTEtNQnUxMFR0VnhWOUFVQlc1bjhjRWUrMCtyUnpr?=
 =?utf-8?B?ZmNIZGs5V2RZWWVmaGFpSTIrSHFUeWlSeU9scExoKzZ1RDA0bXFEczVjcWRH?=
 =?utf-8?B?S25uVSsxTitNSzVqMTlmV1Q2UHBqb0tBVVFOVjRsWDkxRFN1THoza0lNTUdl?=
 =?utf-8?B?enZ6Q2xha2ZIMlNab0tzYmhSQWh0c0FGZDAzeHRvZ0FMQWNwRjFuN2NLdHNr?=
 =?utf-8?B?eFNFRkduVmRoZXQ0VWhjSjNCeUhUbkxoNHZlSEMwb05ocTdWRUFJYzEzc0N6?=
 =?utf-8?B?Ry9pdGQ3TUZWci9KV3Uyd01SbTdTQWJneUFrdVNCSFozL1JjV1N2NnJBUXpH?=
 =?utf-8?B?TldxSUZSNjVnei9ZaWZTbTQvQ2treUNFYjM4QTk0TTlUZ3JnS0pHQ3pGS3Uw?=
 =?utf-8?B?dFByb2RiM3ArVVUwUnpXanN0MEFlbndoNkhldEZHb2dkTnpCNzZZZ045bUVQ?=
 =?utf-8?B?WHVzSDZ3dHBiTjJhaWJYcVFCT1pETU5SYUtBcVdnVnU3bTIwdWJzVUdYL2FJ?=
 =?utf-8?B?amZ3OFJ2bDhoaUNXaSsxZ2lwR0FrNlB2NXRmWFZramRiWHdxSmZyVTJYaUox?=
 =?utf-8?B?NDdWRFJuWVhGcVliWkdvWDRuZ24zLzhxa3JzZk9NN0k2b0EvZnhGT1NMOHhT?=
 =?utf-8?B?Nis2SDR6T1l3MjlxTWZFRDlkYXRDT2tibFZ4allNSllOLzBoRWwrRWhJSTcw?=
 =?utf-8?B?NlZJZTZDL2xZZXdZckdoM3JqbHh6QzZMZWU2R2w1S25zbURycWt0cTNCZXQw?=
 =?utf-8?B?dlIyUHlPRnBZZ3NKUWx6cnNSNXM2UU9QMFFFSnVYR0VFUlBBdnNISFpWaldz?=
 =?utf-8?B?RnBSOS9ZUDZXZFZYdmh2VnJrVHdhblU4Zjg4bjFzb1hpaWFTbERGNDZDbFo5?=
 =?utf-8?B?ZDh5cm9CZzhvZm1WVzNTRWIwVEp2ek1WU2w3eTNnTC9TQWplRFFDSCtiZTl2?=
 =?utf-8?B?UldNU1ZtM1B2VTFvNHgvUk5EdkxKSUhrOUhDTHpQUDhOeTJHbEtsbGxOcHIv?=
 =?utf-8?B?UXVpdEVabldJWm5GajNTVVhrdzNockRiMXJ2SEJUMzZuZjI1cG9TcSsrRERx?=
 =?utf-8?B?cXBrVVhtWmFQQ0pFdndacDBUa054SjFxcE04dGNhM2R5WHJ5TnFIWmIrdExB?=
 =?utf-8?B?Z3M4aWhXSnJ1SjF3NnJFcTRHaUpzL2dpR2Z5UEllbWRuZGpYb2J6Q1gvdmxn?=
 =?utf-8?B?OW8wMGRSaldHYlUyQkQwK29GTStJVFJ0eUhiNitjTDFkOUN4blJvUm5heFBu?=
 =?utf-8?B?REZjMEI2RkdmQmtiUklIZWZLYlorVVR6aTNETXliZ2JnbERwVW4yR1V1S2Ji?=
 =?utf-8?B?blpVUU5PUWdDYjN1M3Y4QmRZM3BLVmNORmRYbHZyajF6c1QvQUNqY0VFQ3Zy?=
 =?utf-8?B?NVdib1g4dXhEdUFWdWlwdHVVZUN2UEtSK3NnNGxxWVJ1aFUyQXd3T280NlRE?=
 =?utf-8?B?UjFiSkNYcE5wRnVuVFIzR0V5R0gwLzJOZWFFbmhxcHUzcGJXQU5XRlhYNGZJ?=
 =?utf-8?B?V21FeUdBTHZXOHZpQWtuSHFsZjYrWWpiOVc2aXFVNDNkRU1Na1hrMU93N2l0?=
 =?utf-8?B?Rmt2MU9oUWhYMVNuM1o0QTNOZ3h2b2ZZa00xaHp2MjFTeVFmSGVMTzRzTEVU?=
 =?utf-8?B?NGFnbWQxakZlUDdtM0NCQXJPaEZOYUxMTWRZL3ppSXp6QlZITmFPdDVMeGVK?=
 =?utf-8?B?RGJNdEZpMEZTS082UkNQd1JsL3dDVGcrcU45UldoSkZnaTJ5WEV3cjRLL0Rn?=
 =?utf-8?B?dzltK1U3K2Z0OGErN1NIM2tYczBUWEJpM3NiUXNGREpENkhDVytzRnZpeTJz?=
 =?utf-8?B?S3UwSkJ3aDNJYWoyK09jWVQ4YXU3TnAvVjNiZ2dkb2hrSU1oaEJlWEUwUkZl?=
 =?utf-8?B?Wk5xengvaXAvMDFINmpPM2NiM2d5L2U0STgvclV4dCtxZEM5a0NHcTNVM2tC?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ac96cb-e9d4-4049-b5eb-08ddd8ed6bc5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:40:38.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqPAz6GuuNxJlluLzg7AFD23oPY6PhU5cV97PgyEbY+zGVpPP41JT7bUT5rh31gosIOa/TQZwLDMi/6zrWgJGMFLlZFs0XjJmSx1e+IvHqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6333



On 8/4/25 7:57 AM, Matthew Gerlach wrote:
>
> On 7/24/25 8:40 AM, Matthew Gerlach wrote:
> > From: Mun Yew Tham <mun.yew.tham@altera.com>
> >
> > Add the base device tree nodes for gmac0, gmac1, and gmac2 to the DTSI
> > for the Agilex5 SOCFPGA.  Agilex5 has three Ethernet controllers based on
> > Synopsys DWC XGMAC IP version 2.10.
> >
> > Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> > v2:
> >   - Remove generic compatible string for Agilex5.
> > ---
> >   .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 336 ++++++++++++++++++
> >   1 file changed, 336 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> > index 7d9394a04302..04e99cd7e74b 100644
> > --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> > +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> > @@ -486,5 +486,341 @@ qspi: spi@108d2000 {
> >   			clocks = <&qspi_clk>;
> >   			status = "disabled";
> >   		};
>
> Is there any feedback for this patch and the next one in the series,
> "[PATCH v2 3/4] arm64: dts: socfpga: agilex5: enable gmac2 on the
> Agilex5 dev kit"?
>
> Thanks,
> Matthew Gerlach

Just checking in again. Is there any feedback on this patch (v2 2/4) or 
the next patch (v2 3/4)?
https://lore.kernel.org/lkml/20250724154052.205706-1-matthew.gerlach@altera.com/T/#m2a5f9a3d22dfef094986fd8a421051f55667b427 

https://lore.kernel.org/lkml/20250724154052.205706-1-matthew.gerlach@altera.com/T/#m3e3d9774dbdb34d646b53c04c46ec49d32254544

Thanks,
Matthew Gerlach

> > +
> > +		gmac0: ethernet@10810000 {
> > +			compatible = "altr,socfpga-stmmac-agilex5",
> > +				     "snps,dwxgmac-2.10";
> > +			reg = <0x10810000 0x3500>;
> > +			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "macirq";
> > +			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
> > +			reset-names = "stmmaceth", "ahb";
> > +			clocks = <&clkmgr AGILEX5_EMAC0_CLK>,
> > +				 <&clkmgr AGILEX5_EMAC_PTP_CLK>;
> > +			clock-names = "stmmaceth", "ptp_ref";
> > +			mac-address = [00 00 00 00 00 00];
> > +			tx-fifo-depth = <32768>;
> > +			rx-fifo-depth = <16384>;
> > +			snps,multicast-filter-bins = <64>;
> > +			snps,perfect-filter-entries = <64>;
> > +			snps,axi-config = <&stmmac_axi_emac0_setup>;
> > +			snps,mtl-rx-config = <&mtl_rx_emac0_setup>;
> > +			snps,mtl-tx-config = <&mtl_tx_emac0_setup>;
> > +			snps,pbl = <32>;
> > +			snps,tso;
> > +			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
> > +			snps,clk-csr = <0>;
> > +			status = "disabled";
> > +
> > +			stmmac_axi_emac0_setup: stmmac-axi-config {
> > +				snps,wr_osr_lmt = <31>;
> > +				snps,rd_osr_lmt = <31>;
> > +				snps,blen = <0 0 0 32 16 8 4>;
> > +			};
> > +
> > +			mtl_rx_emac0_setup: rx-queues-config {
> > +				snps,rx-queues-to-use = <8>;
> > +				snps,rx-sched-sp;
> > +				queue0 {
> > +					snps,dcb-algorithm;
> > +					snps,map-to-dma-channel = <0x0>;
> > +				};
> > +				queue1 {
> > +					snps,dcb-algorithm;
> > +					snps,map-to-dma-channel = <0x1>;
> > +				};
> > +				queue2 {
> > +					snps,dcb-algorithm;
> > +					snps,map-to-dma-channel = <0x2>;
> > +				};
> > +				queue3 {
> > +					snps,dcb-algorithm;
> > +					snps,map-to-dma-channel = <0x3>;
> > +				};
> > +				queue4 {
> > +					snps,dcb-algorithm;
> > +					snps,map-to-dma-channel = <0x4>;
> > +				};
> > +				queue5 {
> > +					snps,dcb-algorithm;
> > +					snps,map-to-dma-channel = <0x5>;
> > +				};
> > +				queue6 {
> > +					snps,dcb-algorithm;
> > +					snps,map-to-dma-channel = <0x6>;
> > +				};
> > +				queue7 {
> > +					snps,dcb-algorithm;
> > +					snps,map-to-dma-channel = <0x7>;
> > +				};
> > +			};
> > +
> > +			mtl_tx_emac0_setup: tx-queues-config {
> > +				snps,tx-queues-to-use = <8>;
> > +				snps,tx-sched-wrr;
> > +				queue0 {
> > +					snps,weight = <0x09>;
> > +					snps,dcb-algorithm;
> > +				};
> > +				queue1 {
> > +					snps,weight = <0x0A>;
> > +					snps,dcb-algorithm;
> > +				};
> > +				queue2 {
> > +					snps,weight = <0x0B>;
> > +					snps,coe-unsupported;
> > +					snps,dcb-algorithm;
> > +				};
> > +				queue3 {
> > +					snps,weight = <0x0C>;
> > +					snps,coe-unsupported;
> > +					snps,dcb-algorithm;
> > +				};
> > +				queue4 {
> > +					snps,weight = <0x0D>;
> > +					snps,coe-unsupported;
> > +					snps,dcb-algorithm;
> > +				};
> > +				queue5 {
> > +					snps,weight = <0x0E>;
> > +					snps,coe-unsupported;
> > +					snps,dcb-algorithm;
> > +				};
> > +				queue6 {
> > +					snps,weight = <0x0F>;
> > +					snps,coe-unsupported;
> > +					snps,dcb-algorithm;
> > +				};
> > +				queue7 {
> > +					snps,weight = <0x10>;
> > +					snps,coe-unsupported;
> > +					snps,dcb-algorithm;
> > +				};
> > +			};
> > +		};
> > +
>

