Return-Path: <netdev+bounces-198723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E5AADD53C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106173BF2A2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CCA2E92BC;
	Tue, 17 Jun 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1iDphdG2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B7221550;
	Tue, 17 Jun 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176394; cv=fail; b=d+XdFZ0pYa5262dsaFfFo7OODHYKmjhDqP/9E5n8NJTHMGgVvk3baZAi8gpCSIThcjfoBX+ZmMFLMfkPG2xVk4g/V4V1fgIHdsVc45FzRuTuMHXCCH37JCsnrgvoPL02fY9cbVQWh79uNEJEoWTrQk0PTz698g2ShHpTqAQHon0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176394; c=relaxed/simple;
	bh=SLYs1MsbAyGzMfWlYHprZio0+DFq9kCnHc5VuGDoiR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bkoqc702X5QEP1XgRk/NKvwfkcIImmnx6VzJ1OkVPfh3dx+XQXrX4KcbzJN7Tjc6vtlS+GPyr0H2/e6coAViUhRv/vV88DvoTp2OhBnflU7LN80okQxLcX0WqGfpJkeFXQB6Mg0wiMeU385z/0qTMujmSmxTjoNLFI/ArWX13ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1iDphdG2; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1JUHFPboEr0j5aQ3T1ifqrpF42FMK8L+MCPN+WXe8nTBW/AtaCDjOkkfuGvwr/OeF3kWXjAYq+Uus7wFwyyk2/qvEOxJO4+qWuc96a5oSMM6kbwFlF6kLIsCtsf8DBoJ6MsonkUsruOaFKt+GgS04Gi755Os5/wHeoE54mbbjrUOhOmXOS9vr1U+cemzPivU0f58Nl1hVTGEGZYIKvEU49plVtKsEE+Q3n0ueJQRjJFG6YUj8ux7b0wDxGLUStTsYvpEUinlkfg8vvjopM8NM3Q90sXTBQeZDqmuDn5lfSoUuo5WKoMJJGzkeknD4+ghzcOoF2ygwG1F/ufRm6Vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uo+G6xzVTr99T+od6pnTeUye1tVuj580/ZM9Z+rt1k=;
 b=p175Hng3Smtq/lKbHu8ghfyNVBxSMhfdNXHyWJHURWv0v/xP3NUxaTruYZueAepb/HmCIyww4lbcGmjv1xp3/cwMgTuQKXWL4m2jk8gbLGiHIURwiEzOTK0TD5Nh3nNPO+sMo6xtUmkKZyfHn67lGuT1YowMYUiRwwoGE45uUFFMySSyW61aunXbAV46pnpqYOwg8a4MOi36ULCiziNOocWfbc8wFKpDG/ZAY9k2cbHa+ri5+8gbDIm3MOToWgbapJTe3mkOovoYMLwsu1trjaEjF1++8pujoviA1ap7WZOotf3Q7B40ZjVfpjMsB/ZAkJBHDZPWYTAarfZqrpOZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uo+G6xzVTr99T+od6pnTeUye1tVuj580/ZM9Z+rt1k=;
 b=1iDphdG2NOJua7KoKH76OGtPAFUWpzJjy//iZ4LeWds3ZPxDLG5P5TH3TWs3jYYQhbhiovNQYcuT+9tF8R47BV4WPvItwjDYmFZuke2JQqzvnAeRwe5o1Paw5CMVuWnxfWNF9cCgm96+Rrz8V94tMaasYSDOSVopYCdg9+HWq4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Tue, 17 Jun 2025 16:06:30 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.8857.016; Tue, 17 Jun 2025
 16:06:29 +0000
Message-ID: <1931a1e5-c2b9-4208-b500-b2b0d15da39c@amd.com>
Date: Tue, 17 Jun 2025 09:06:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove Shannon Nelson from MAINTAINERS file
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, brett.creeley@amd.com
References: <20250616224437.56581-1-shannon.nelson@amd.com>
 <676127e8-80e4-4374-b791-488b6c53da70@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <676127e8-80e4-4374-b791-488b6c53da70@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::31) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa7203d-ab6b-4df6-21e6-08ddadb8ebb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkl5eVI5Uk5UTE5vK1VFRVMxV3Q1cE1aZzg1eFF1WnpJVlBJUGpmSkIvSk0x?=
 =?utf-8?B?SUROVjhoaG9QeEtkMVBCMkNIQjdzYSt2b2c2VXRqYmhvQnpTS0ZoMFBxQUE0?=
 =?utf-8?B?WjFqRGtBT29NTmdpR2swVm8wZmd3ZHJHV2ladTVMcDRvS2ZoMy9reGFlc2dr?=
 =?utf-8?B?RUlCWHpuTlBhajNhRCtPazFmWUtteTM4L3dSMWgrZ3RTR2pGbzNrcytOeVpu?=
 =?utf-8?B?WUV0Q0Fpa2NaelM2eGhyUUdqVjlxdUZEb3p5Y29hd0ZZTE5yd0dzT2ZaM0xs?=
 =?utf-8?B?YTJEOVI1U2I1bnNnSElIV1podkpGQ1ZiQVMrcWw4WkVkOVNONFFDaHFwbTNm?=
 =?utf-8?B?ZFh6TDVGYTdsMnpKNUdZcldPMHRUZ1hzYTVEYmYxR3dmV2dyNWs1aTZQZmJi?=
 =?utf-8?B?WVBrVVN4dHpwWSs4T0tabGJ3K2lrbE8xZnp0Mjk0WTBNUklyQUNVQkpMS082?=
 =?utf-8?B?TWlGbmFJYUpuQ0dyV213VFA1ZFBBUGh6eWg3Zmx0aHZUemtVYlFQQUpWT1BH?=
 =?utf-8?B?UHpYVTZGaWMrUXN2NkcraGFNMkFaYUJFeGZhZXlFc29nbzhVTmI1eVdkNktw?=
 =?utf-8?B?OHI5ekQ4cmpNOG14VmFNM2VaOVF6Q1FjcVgrTWlPTmY3R3FFUFR0MVNJRFNk?=
 =?utf-8?B?TmNzNnQ5bXJYVCtFamwzUW0wNDdiSmxhUXcyUHJLNk9MZUhjdUJHVnYwb01h?=
 =?utf-8?B?MCtMd0hueHp5NDdIVEFuWk1CeFVhSm1FUm1vK0J4STFvSzdHOGphU0dUWFFU?=
 =?utf-8?B?L0ZYcXBGenJxTVZhbFJ6RFZyN3pRUVBhV21zQmhwTGU1aThMay9OQzZIVitz?=
 =?utf-8?B?Q3pUM3dCeEZ5Y2RnK2s3NXBGUU1lYm5QWUQwWDV4WjJOUEZ1K09jRFUzK3dR?=
 =?utf-8?B?K1JlVHJPZVJIWEUwaFhVcWpvR0NoSkV6Z1MwQm1jRFA1V2taZGRZQkVCNU9t?=
 =?utf-8?B?YlZ1S2l5UWNVZEdNanJKMTRXSDgzRHRMZzh4c0x4UjlZVDBtckQxSGlYNHpM?=
 =?utf-8?B?ZGVvMHFNS0hZVUxYYlhsUlJRdmtxMTlHa1ZkdGxENmNtQ0ZxUWdXc0NlM2tu?=
 =?utf-8?B?cVJKbU0raTFzcWRDY0RuOUE2M2RISzhSdFh6WEp5a09QTzJSWmpsU0VJcXc2?=
 =?utf-8?B?OWw0bWdUR092aEROZXpDNVQ1L2J4NmZFS3J0aGtVQUtxOHpvaUpnT3haaHNP?=
 =?utf-8?B?UHkzTWh3MFJ1QzMvZEIrSncyemNydU53T1ZJa0pZN2RBQk9iWGljYy9vSlhw?=
 =?utf-8?B?VmZHeWU4cHRCM01YL1ZoWDJtc3VpL1JUVnpDQlFXVmlCWUNTdk44MURmbmdV?=
 =?utf-8?B?OXRlZXN1TlpsUDhyNVdUU3owNDA3Smcya1F5QmdobnVYRkQzM3dCSWFjWm5W?=
 =?utf-8?B?S0d1Q2dFc2lOUU1rdmFucDl1a3dYVERUbzBmckVFVkxVaEJ1U3ZPUGNNbmZ2?=
 =?utf-8?B?b1RtcXRSN0VZdTBHTzJqdVJITkZEeC9tTmhvTmhzQUhTRmp2MGJBQ3A0OVhD?=
 =?utf-8?B?ak9mSEJYUmV5SkxWTCtRaXl3N2RVbDNmMWF6c3RGOGRRenFmUkozeklCVjlO?=
 =?utf-8?B?VDB5a1ExajFUMVZUbDJsbGlNd0lXZStoRkt3WVR5M2RSRHRYV1hJb0grU1Vs?=
 =?utf-8?B?VXdrOGlEMVdoUk0yRks4ZFdkQVB1ZWRkNWNDQjFZZEV5MUt2QVVxcHVJVFBP?=
 =?utf-8?B?aEIyeG1OUGRpK3kwMzB6d2ZDVkZOT2RHeldPcmZRKzNWNXdyQXA3L3QxeCtY?=
 =?utf-8?B?eWd0SDhQamZjWDRDanZaTEh2UnF5SEExb3lUTWp5VnlRQmdMb09XcUJ6ZEtV?=
 =?utf-8?B?SFM5VFFvd1AybVM1ZVZOZHJkdzlWWFVpSGovYWVlbDlaeDlOajE5aWpPVGwv?=
 =?utf-8?B?UXNHNk0rclMyZ29PRFdLcjUrT1NGM3ZQdnZGK1NuU3p1bHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0dMa0JlYTFnVHVuMHJMNmFOVWcrUUgrWjRBV0Y0MzhQdDFzNTRyVFVIK2da?=
 =?utf-8?B?eUlZVFBVcnhEaUZJZko0bWNPTkZHU0N0TkJyOGw3Snd3Q2dhNGhJMFpYZ0Z5?=
 =?utf-8?B?by8yOWFXdVlkU0hjckNidllZeVVGbnRLZEdHWG9aVnFZQ0ErNlhPQVM5SVJW?=
 =?utf-8?B?UEZoN1hraG9vQUJRNThqai9FL0xJV0IzN0FNSFVQdlBMZ1FwQWdXdk5jSGlj?=
 =?utf-8?B?VnpCbXV6VjV4UU5LZitXV0U2dHR0Nld2TFJ0SFFiektRcXhPd0VRdGNvdFpM?=
 =?utf-8?B?cEViVHpaRFFCc3J2NDRMSUMrYy91NzBiZ2JVbjFkdEJJWmlBU3owZUZKdHh6?=
 =?utf-8?B?Yi9tN0pnMkZ4NWhVSXAvb2h0VzVFU2FwTGVJRWZPejJBdkNBL1BjZ25kS3VD?=
 =?utf-8?B?YXBrUVNia3k3dVJwbWdIbkxlQ2YxcXNjTXhHaVBHWEJqREVSQ3ZNdCtYNGdC?=
 =?utf-8?B?V1g3cWlqb1kvck1DUlA4Z0ZickNYVFNnWG1CNlYzS2RrRVZQZWpKVEJFL0dr?=
 =?utf-8?B?TXpEY2YwRDVvWmNtYldmMGZ6b2lsRTQ2T3c2cUVPdUFxdytvbjBhdGQ2VU5Y?=
 =?utf-8?B?OFVzcElSTFNEQmRLMWJVTjlJMzdFNmJoK2RGQjNPRFV6NVFUQThuSjhWYUFO?=
 =?utf-8?B?b01CL1BEeUNzQkR6S2dxcEJTaTlhUCt5N2JpaHQrVkxRT3RLVE5QZ1puM2h0?=
 =?utf-8?B?b2pIQ2NWVHVsYkRudmtBY29kRU5udlBkUXlRL242enhZU3Z4Um9EQkJ6MUxT?=
 =?utf-8?B?NmNQNGN6UVpFK3ZKaUdaQ3NubVR2Y21IR2ZtSXRDaVJVK2kxdmZNQTl5SEw5?=
 =?utf-8?B?VDRiRXN6cHdqM1dTbE1MSlNuL3JLQktWSUdEdXk1cWRGUVpMSmxhaXBoblFo?=
 =?utf-8?B?KzZkS1JXWDhDclVDV0loSGF0TGlBUlpFNkw3RGVsZE9OVmpoVXNTNmVxYXI3?=
 =?utf-8?B?dFJZUTdWSTRib21ndXlkWnF2Wm1pOFZIUjE2SUZxS3hYbkZRNWJnRWl1eCs3?=
 =?utf-8?B?QTJCRVBVaUlrYU9mNmQraFlHYTJPZG1tUmluVEFmVytZZVhOVXZBSHhZQk5p?=
 =?utf-8?B?WDk2eElPZlBQOFI4Q2VEVVZwZ1EyRDdpNTJhdTFoVjVidlJYVTlXZjBySlh2?=
 =?utf-8?B?bjFmbDRja2Z2UHZSMmhsakkvUlVUZWpPMi84MFFwMTRhNVFpcUFjNmY4Z3A1?=
 =?utf-8?B?N3Znc3JxUERzaHZ3U2xmbVd0VzFuVFVEczFvemozeWxkbHN5bU13YXNzbkov?=
 =?utf-8?B?aDJOSGdNNDBPWFM2V1JidUxDdnh0ZzZSV1MvaHhEOXUxeXlSM1ZjNWNqQ3Rw?=
 =?utf-8?B?V2RKUEtBRXNnZFBrNWFaSlJ4NmttUTZKUUxWTFJBQno4bUxUSTlpNEs5NFpu?=
 =?utf-8?B?dWlVYVBVMWhzakpjOHVRb3FKbGhIVE5yVUlBTTlNcXJyVmNzSi9tSjF3bzVZ?=
 =?utf-8?B?dG80dzZvTmZ3RGRlM2c1dE9nL0xsclIzV2lLUHBmQlV0b3R1YWFXaGExU0tO?=
 =?utf-8?B?QkdhZEpPZzJnMHJnUmxhdmhYT2xtcU1aWDNIbEQyS0NhR1hyZnIrQTk3Wlln?=
 =?utf-8?B?OU1XbjNVK240azRzNUlBbGs2WCt6cmVQRktWRHZjZ2FhK3JSdS9SSTBPWlZr?=
 =?utf-8?B?ZFhCZXVRWHhtQ1BrY1QxWTdMNFJYOW4yanlCbFpHWk1JVEZuN3MwVzlTcC9q?=
 =?utf-8?B?SG13QWxtNDlnWit5a1Qxbzd2ckRrSXpaRkpBY2tGR3NaR0xvTEFlcFdlZnBH?=
 =?utf-8?B?dG9SRXAwbzhjZVdSenNLNllKTTN0N0hPSXBOa3R0YXJjd3FST21KTEhMVDEv?=
 =?utf-8?B?UjcxT2dJNUVHSFJ5N1RZNXhEVlBIV2hQNGlYYkJDMnN2TlNiV2c3dE5KaWNt?=
 =?utf-8?B?NXBBUW9Tdks0R3J3Sm1Hb2RSbzhIZVJzVlZrcno0eFdKM3VBck5qcUFNVjhC?=
 =?utf-8?B?YXB4ODRBa2xDRUxLaVVlbWl6QkJORjVCMjJzK0NDMWlQdERzeWthQkVVNFUy?=
 =?utf-8?B?aVJVU2dtZnczSnk2alVjSEdZTVFpSHVQNk11dzgxWjJ6WUZsNUVBNWNuUTEr?=
 =?utf-8?B?eXpDZXJONkNVZzBOeHMyR0YzbE1RdUhndW4wN2FkVmRsaW81VHlNQ1Q1Uk1O?=
 =?utf-8?Q?0LSMFnnd3nP3zsUnNBi1iie/S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa7203d-ab6b-4df6-21e6-08ddadb8ebb9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:06:29.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdfK6SsVdycjNbD75SICQ+uej+iXUb4u8094AS3QLNAKAqAM18yJ6Ybdo2XqeRvErod5dt0Vb9B1ix9IC0IFxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247

On 6/17/2025 8:03 AM, Alexander Lobakin wrote:
> 
> From: Shannon Nelson <shannon.nelson@amd.com>
> Date: Mon, 16 Jun 2025 15:44:37 -0700
> 
>> Brett Creeley is taking ownership of AMD/Pensando drivers while I wander
>> off into the sunset with my retirement this month.  I'll still keep an
>> eye out on a few topics for awhile, and maybe do some free-lance work in
>> the future.
> 
> Didn't you think of moving yourself to CREDITS like a true veteran?

Thanks, I've had one or two other folks suggest the same ... I wasn't 
sure about taking such a step, but perhaps I'll send something out for 
that.  I realized that I also need to update the .mailmap file.

Cheers,
sln

> 
>>
>> Meanwhile, thank you all for the fun and support and the many learning
>> opportunities :-).
>>
>> Special thanks go to DaveM for merging my first patch long ago, the big
>> ionic patchset a few years ago, and my last patchset last week.
>>
>> Cheers,
>> sln
>>
>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> Thanks,
> Olek


