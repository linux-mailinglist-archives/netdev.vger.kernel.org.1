Return-Path: <netdev+bounces-208671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8865B0CA9E
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9E189543A
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7628DB5B;
	Mon, 21 Jul 2025 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZSJXRX3a"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA21885A5
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122968; cv=fail; b=FSJmrRAm1oMRc2X9x9FR0b6N9jINBhK/SlCVa6O+bP7IyC8hZPF+vykVFg9OINQg5L+RbR/MLyK1gVzgSVww3DR0lVmmflOZRvcDyubEKpe4myYhzTB5axqSZvYO1+c6JktPeRTfhPfcrTS8lXGu9NOg9vjvcrTgu/2NAR7295k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122968; c=relaxed/simple;
	bh=8fKIGr1aYJNuTqzFOLBalMgNQPSx6uV3z12mocZlLFY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aTDNfcM5HpPdFQtqzUDifgrglo4FLAxW3PPnQQpIhz3h0r/jSf7y8CGs1FJF+sBxnQsl8r2ngKqwzxOzCBTx2s7h/2zPvFo4GpWrgDOuENnwNGZ/3NhqLybLazctpQZi2w8hpd8w4XTSzxPeLwZIj4WJ6/zp2is/Ex/KNNg2SUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZSJXRX3a; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgXAvSJt6oTt+kgCo2a/DDk9cEfZxBee/AryKjeaQFQniLAmOdZLMhaMEVNwhi6obZlrQwnj0sTzkIo9IsnyalaXUpBlJRBwI/0u47UY0A1PQEiwNHWFGAH80YMvEWtUNB69s5zTe3dJHQJtntNkHvtLpFBuQN6pIG99NbV1v5QBoJAEd+6snKQ42WTng6pyiXGukD/V7N0P6REPDa0gfXOzaUHg3Uojtls6CeMqJY1RSDwTz76l0cXJw2djD/dL+XJKlD+t5S+3k/8NyMKiqR4cu5d5O8n+FlE5rOom18EKdo/LNvxjoJdycV9HXDg/CgPQELMz0oVUbjAABCPC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ake8y5xIPYXg0IX7nkSvbc1TKwW6UyVmP+nptZESvgk=;
 b=eLVK9oq1enlJEMf2YHwJgLfli1h9wbpbXEAQo1PnsaSy/u6/3bDGgp4TqOpZhyG7YW8ByF240YHLuht80Z325wstWrT2UcQHiqsvHmptEwzSuQT3B1fPgTYN/VAYyIwCjt1xW8aoojuOpSDbIkKBk9N2YKdY1FA0OARlFlzM5d0RJtBnWdwKsrhxnJ48DqtN5Eu0fBy/aIYReZwXQ6jlgeQyl0SV0qIv/ZA4Fgct+HiKNIVrh1jO9qzcu/h+41aEbI1Nu4PV/10RlL1U8kGoo2s/5bILbJJkN9W4Pu5ZcoHTh4jPbDkw435q/gt2FYWgJ6tOniJtl0VAbIvtcSaTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ake8y5xIPYXg0IX7nkSvbc1TKwW6UyVmP+nptZESvgk=;
 b=ZSJXRX3aeIi5Bp5wabLyWjweRmQLwkDYIONk1m0DjZnzrTI3RaoeG1qrLa93bJuP4ADC22sR+2pJOfRNURwIacOWEcSGVM+Ma642Tg5yPPvfMRD0J9umbDFU/dBw4R5Sb1a9NHLYPPXm1a6T0HW+vam3bsdyMjq4LVpaQGuwnK5NBEsssQkyv6iQaGs9KP14u+WH6CXJHRD4qF3tvFOkqqnxmqk+iRsNLlfpGB3TLWty2Y8scZGSb6xozUW1PC313AAGcN4tRvPucQP1asym0hgejGrkHjY+45kQeWERfy/YorpNtCXQ79ymCSGDO6yI1OBTxgh9ccibXWJFBNmMXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PPFF4B476A86.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 21 Jul
 2025 18:36:02 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 18:36:02 +0000
Message-ID: <8cb88079-c2e4-4929-a7b5-48dcd88db7fc@nvidia.com>
Date: Mon, 21 Jul 2025 21:35:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/8] ethtool: rss: support creating contexts via
 Netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 ecree.xilinx@gmail.com
References: <20250717234343.2328602-1-kuba@kernel.org>
 <20250717234343.2328602-7-kuba@kernel.org>
 <70db339e-a60b-430c-bc8e-f226decb44f7@nvidia.com>
 <20250721082111.6826d138@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250721082111.6826d138@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PPFF4B476A86:EE_
X-MS-Office365-Filtering-Correlation-Id: 0350750f-2d74-48f4-3784-08ddc8857191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cCtzR0RQeTdta3VNM0dDZzdpSXBkdWVMZVdaNjgxMllDMnczTVg2ZDV3SXA5?=
 =?utf-8?B?KzVsbzh5VVNueTc5eS9laEppaFhYRkZqeTJZd3hBOXlod3EyWHBycDQ3UnJF?=
 =?utf-8?B?aThZcncwcDJ1R25oYi9CV1EvV2t5d2hFdFRLK05TZU5naGl1NEtxRHVNMlN6?=
 =?utf-8?B?WXpNc3Z6enl4eXZhWGNpODRxRFJoTHdiMUxKYzYzNElwdSsrOWIrbmVXdjg4?=
 =?utf-8?B?ZFp5UDVsT3dZTHZoVTdnRlJUaFpPQjNEU2p1NFJEWHV0MXFBQnF0M1ZJb2l1?=
 =?utf-8?B?cTM4THdOZkszWnltanhrK24wL2s3VG5KdTVjT0NkTGFwREtUYkgwTytnelds?=
 =?utf-8?B?dGpyRUxOeFhCL2p5eUF1cE1QYlA1R1pZNlJDVHlIQ3lDV3lSQ3JNNk12OWpS?=
 =?utf-8?B?NC94UDhwMksrT2IxQ3JwK3pKczl5WHpmTnFJK29zcmF1NjFDaXZIQUlJVmh5?=
 =?utf-8?B?Z1pXMUp0STlIcGIzcmV3dHZjTExWTE4vdkZtaXVPU0l5TkxYdWhSZ0xxekJ2?=
 =?utf-8?B?c3J2c1orV1JrUjhPZ2JiWFU2OXpIMkd0dVNBSXRTZzYyaHhjYW92cXJCUWt2?=
 =?utf-8?B?K1RibTFrcnlVcStxQWJIMGlQeGd1VytVVWJhOHFSUmJEcW5OaHRESW4wSnpO?=
 =?utf-8?B?bGxUZFh1UE5ueStjTzhPL0paRU41S0NvM016R3JnQVBmVVlna0ExZTBhYmor?=
 =?utf-8?B?WDBXSUlNdVdPZ0ExTnovRS9VTmVCVURiZ1JNdTlQRGI2bC9IaTRIQkN6RFNk?=
 =?utf-8?B?czByODNid05Wa0NaekNBSUQwL05KTzNYQ214ZUxIMUFKbnl6dmJGakhnaWQv?=
 =?utf-8?B?eU1QNEJSNW8zL1J5Q2dqMEVaMmgvcll2ay9DdFl4dkpnKzlUM1JwQ1RjYmh4?=
 =?utf-8?B?bkptN3RzZ2xNUGxxRDQzakJxSGwrMGZrTWZjbW0yL0NlT05mcmdZSGI3MEUy?=
 =?utf-8?B?eTRMWHBieHJmd1NtMU9lVG5LTHFvRnp6QmRraFFUVCtQczU2aklldGl4ZmhS?=
 =?utf-8?B?NFU1SVdma3gwanU3ajlQeEJyMjE1SFJ0RkRNbFhuTUdwdmZESHA2Mkg1OWFK?=
 =?utf-8?B?Y0hJamFWR1hCNVZTanZVcmJ6cGRSU1JObFV5RkVOQmF5SkUrT2wwb1hCZktJ?=
 =?utf-8?B?TjZETUNxZ1FoZGJ6QzNISXdDNkMrcFFBdEwybkNOdTZ4WEhlZDg1d1hTNGN6?=
 =?utf-8?B?d3FMQVVGMzhydE1iUnc4Q3VnOU5weWMxVlJyK0RqTDlkVVVUKytDWHFSczR0?=
 =?utf-8?B?VVF5Tk9PVE9RK3NuRVdJajUzWmprczI5anZDaVlpMFp3OEFIWHJEWW9Dek0z?=
 =?utf-8?B?dHpib1dRTDBxZXBxMDNISnMrTmZPam1OQlk5SmFGWGc3R3NvZUNmWGhPaEF0?=
 =?utf-8?B?czFiVk9WRmEvQlVqVkRwb0JDNzk4V2lCYWRURC81MlJXcjNEdFRjNk5Hb3lD?=
 =?utf-8?B?T1hlcG1GcGZwSVNXUFowZFp3M2dKZUE1ZHNQSnJxQnY0YVNCRG83dDk2a1pw?=
 =?utf-8?B?NE1aTTVud28vT2FacDZaSlJPQy9Zdjk0U2ljVnIyM2VreXA2TlBQNndzMFdC?=
 =?utf-8?B?c2F4S05FZVFlU0ovM3pMcHJna0FSMHk3d05RaEZ3b284VXROOCt3eTUwSGti?=
 =?utf-8?B?ZTZkYlBjRys2QytndkdYeXg1bWpzN09yZTJzeHlTK0NUVFVuK2EvL09qbXJD?=
 =?utf-8?B?TkhabEtaL3RiOUdUMCtFenVSeEtzWFdYN0VXbHIwYlVFV0pya1p5b2lESjVB?=
 =?utf-8?B?WDlXMXM0bFR6Mm1wZ3h1QUlRN2J3Qlo0SlNwQzNoaEJTQ3NjVlhjZSt0c0xr?=
 =?utf-8?B?ZG5ucEhZYUZlSGk4VisyYlZzTktNVVpDSlhqbHJLbkxtWCtrQWEwd1p1MzE1?=
 =?utf-8?B?T3NleW9KZXd6RFFkQmFlcmoyakM3WUR1VmZqRlFxQXg1VXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWpRZmwvWHZpQmZOWFJOWW8zM0xFRGxGZE8zZlZDNjFQeE9hYkNERWtlbkNG?=
 =?utf-8?B?SFYrb0RjZVRKZmlERnRwVXRyMm5hNUNuZGpWdTRVVXFLKy9OTzVoU0k4K3hC?=
 =?utf-8?B?OGd5UnVIalJ4NkdkU3QvZnNmcHNYbSswbTBjRGUzUVQranlibzJUOFdNNW9M?=
 =?utf-8?B?cmsyQ3dYVVRndzEzVkIyR29vM0MxVUdSbE9ueHRYZ096RmpjRDBoWmh5RzZS?=
 =?utf-8?B?Y0locmxWWVBmV0NxaGE5cG1uV2lSUFFodVl4MTlWVmZWMnd0UXBYVkw0dzBD?=
 =?utf-8?B?UExYSE5uWXBWZGlmMTZyTXpOSnJlSXh5K1dWTUhLYkFyenhNRVJ4Vm1ZR0hF?=
 =?utf-8?B?N3ZzRURseE9yVXJTUEN4OVFvaEdGS0syYjlqSkJWb0JTbDlxek4wMFRqNEFF?=
 =?utf-8?B?TTZWcForR3B0MURXSmc2U1hPR2xVbDh4dE5QUm1hK2FIeVdvaGRoQlJKZXlX?=
 =?utf-8?B?YmpKUGJPYjM5RDVQNVFNV0VGYWJubWFjYWpsbXF1L2xqS2RCOFE5QXFpR2pi?=
 =?utf-8?B?VmF0S2NVSXM3R0xUYjArZjllQ2toSWsvakNjY1F1dUpnMnBXS3VKU1BjemJC?=
 =?utf-8?B?L0JCU3MwQllyaTMwb3YrZzNObU90SWhvZXJiaUJESkVtQlQrWFZQWFVnQ1NS?=
 =?utf-8?B?T0RpVTNRYTJvQTVUZ3JlMDBLNGVOQ2U2ZUxnMmNZVGJVMEdseHNQb1I4bmVm?=
 =?utf-8?B?MS9rNEFBUCsxc3RtK253RlJDL1g3N05LdExKbDRPZ05nbTE0dzlxV2k3K3o5?=
 =?utf-8?B?cndGc0FJMnFxR3NIQWxYYTBNbFZVOVZOVWR1MkpUYTQ4OUJXRFR1dmNaVVVY?=
 =?utf-8?B?SFNGMGtudTdZSGVlQ3J2ZU5jMkVBanVwS2JScW1EY2R1RU1jV1p2YStzTmRW?=
 =?utf-8?B?V2J5SWEwRGNNWTZvUExIMXBrcmFxQk1PdDg1QllpOTVobElua2hQcEc5TjNL?=
 =?utf-8?B?VU1BS1ZaYzFXYVZiVHRXTlYwTEV2VDl3RmhFbkVTVWNwT2tXN1k3cGc0THBh?=
 =?utf-8?B?NldWNTU3R05ZR0J6d3dyMzVlSUFMbHlVdXVDSWQxQ1lIOEI4eGl1dHJrcnFT?=
 =?utf-8?B?NDhQUUM3OU82ZjJDWTZTYzM5OSt2UE9IOTVqOEcvcCt3M2pEZVMrelFsSW95?=
 =?utf-8?B?ZkM5WERncnp4WGhTRVlmR1lLNTNXMFJzdUtUZnhENmpORk9nN2JOdkZlQUJr?=
 =?utf-8?B?cDBwOWJjWEFCUTFSeFVZeTZBREI0eEswLzNpMGk1bWpPTmhXVzFqRmJ5L0pP?=
 =?utf-8?B?Ky9vUEVxNkh6bWV3RlhCNW8vL3ZXYmFXRkl3MkMvSkxrUnFRNEJzc0FsNWJH?=
 =?utf-8?B?NG1UOTlDK3VyNndEQ1FEM21HSVk4N0FoTXVKSGtpbnMvbWpJYzdaT01TUVA4?=
 =?utf-8?B?ZEZXdTl1clh4NjRqYWJTT3JIK0pHMFZlWmsrMXIzdmVZcFFkWGt0Vm9NTkhK?=
 =?utf-8?B?dWgxRzRVaWkzV0dxZTkvUjhzSTQ2bzFnaVdHVklBeGxFYXJnQlJCdEJQeHNq?=
 =?utf-8?B?VmdpNnFHd1NSMkkrNmhIQ0JlNmdiQWduR0IxdUc1UHZFaFFDbm5FN1gwcy8x?=
 =?utf-8?B?R0xtTVlVdUhDb0pCOFppMEp5dTFkWXlseFE4bkJhdDdIZFdLZzVJQ2swWEx3?=
 =?utf-8?B?OE9zSnJjc2UwQU1odDBUSGxEblV0eHlDZnk5ZGJ0Um8yeTYzYWlrbW5DQnNS?=
 =?utf-8?B?VHVxTjNYMmJGTEp3UmhjNHErVkFhZTM2eVB4UklOQ2xCMGZ5VnlQZldIRDVP?=
 =?utf-8?B?eHBiVjlpaTc3TjRvZHNFR3QzQWZBOWVERHZWdVo1SnNBMlB4K1FkRzlrcGRa?=
 =?utf-8?B?SzdVdzVQRGRReVlXRXB0OVV1VUJXWXpFNDRWZ0ZxV05COGxoWHRtampxY1Qx?=
 =?utf-8?B?MkdyVEViNjl6eGhZTVB6TWEyT005OWs5ck9yMkpvVW84dzU5RXFxK3NnRk1l?=
 =?utf-8?B?Vk9qZFJWVzJqU2FtcFVrYmpPdFUzOUw2RyswN3c1M2JIanFRTzhUY0tPNTZW?=
 =?utf-8?B?L3lRR01wbVdIN2xjdFBSRHhqQm0rS2g5MkRteUp3TUZwZ1QvSTgwY0dCby8r?=
 =?utf-8?B?L3dzcjdHWHlXNHJieXVwYTJhRHAyNGwxQmkwT2o5a0JibVljaHpqd3F1WUFP?=
 =?utf-8?Q?nsZ3iuxRnf4t6QJsW80zw6K94?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0350750f-2d74-48f4-3784-08ddc8857191
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 18:36:02.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZNFtCD1B8+w6twHStJRGsTviq5H1uPwqcrQnXVRT2888/E5XhKVDREPp4nik322
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFF4B476A86

On 21/07/2025 18:21, Jakub Kicinski wrote:
> On Sun, 20 Jul 2025 14:42:36 +0300 Gal Pressman wrote:
>> On 18/07/2025 2:43, Jakub Kicinski wrote:
>>> +Kernel response contents:
>>> +
>>> +=====================================  ======  ==============================
>>> +  ``ETHTOOL_A_RSS_HEADER``             nested  request header
>>> +  ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
>>> +=====================================  ======  ==============================
>>> +
>>> +Create an additional RSS context, if ``ETHTOOL_A_RSS_CONTEXT`` is not
>>> +specified kernel will allocate one automatically.  
>>
>> We don't support choosing the context id from userspace in ioctl flow, I
>> think it should be stated somewhere (at the least, in the commit message?).
> 
> Sure, how about:
> 
>   Support letting user choose the ID for the new context. This was not
>   possible in IOCTL since the context ID field for the create action had
>   to be set to the ETH_RXFH_CONTEXT_ALLOC magic value.

Perfect, thanks!

