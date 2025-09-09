Return-Path: <netdev+bounces-221251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC47B4FE19
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B941883DE5
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715922F83C5;
	Tue,  9 Sep 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BZZkEmiJ"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010007.outbound.protection.outlook.com [52.103.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8CA34166D;
	Tue,  9 Sep 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425786; cv=fail; b=YRMacapcS27X8O239iVYNSGI67Q/B7fY0wG+VdM8Zt4YtPx+eDGTXrgd3X4vsDL2arMWpB7oQF5p+YDhAmQFKh0Az0vdYwLpeIP1TU2M8uJc+sVmorPib92WcHv04+poIbm6ahNwGftTB1DZdbweNcMITGZPdl4uSDVf+XpwpaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425786; c=relaxed/simple;
	bh=cQvW7h+dsDxjJ8NnnrXPzixokWCv3PpABGMU2tpw9Qg=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d8g4sXWsUrfMk5z8D6j62GZWLdqDSMDK5ugE3SGgVcnhwxIBwHYH6/IUhDkq0T5/JOk683riYIpBVqlLwQN3VdN9PNvtDqCsZrC1Oc+RmT9mNuBjLZpNkZtkMcCivCaGQJTUHtEyTFo5vai6GOpCI0LTektUfdvT1EwaXqqmbac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BZZkEmiJ; arc=fail smtp.client-ip=52.103.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOwl1JF1OvN7+nD8ir2XMHiGk//TA+OhAE5W3uLP6nksl6kBfvoU3wJ7Yj2FyQQJhI+iL2pSBKkbIrkM9B1ZSOO8/oVp773pAIOQeGZ3hWX8YLM0Sn5cbtKHxwGey/qCm2nkvr0x2ChbDxorydogQ7ewi8rgNt0BxKWVoA4y2Mp06LSTIyU5VlDOYfXRRhp6AKRxhhF0hycCgnRNXWseALKNwlP8lPHbMyE9Dr0vl/pBLKKKlrXqGsozOvZT2pxcy7dBni7X06hkT2xFTL/KTBs7tDcm7ri5BeQp3NGMnSXBUziwN1w+/k1p8KEb5uMWiYj3Dj4uxcviSQvCDMzqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQvW7h+dsDxjJ8NnnrXPzixokWCv3PpABGMU2tpw9Qg=;
 b=rleS9IMcTgogu32F5h9MXfhs/QOjwv3BwCPZCYUoEKWwc2rOXfsRbT9h+w4YKLhZZ+Vsf7r5YQk4YpG2LTMIVAj9PP5xoohrNCH+Yo21lb15cXBBGjfIjjoDGFYpVBR46J/wib3w4oHWCRCWrVyA9C/irakzXl66j9X3EayfPGiNQ52RJ+vB03Ht0eyo/m5ShiNonZooa4TxSrUEE/DFqGkG/8EuzQ0nSig8sBWaoavfv87i0i/95hW7qfFso8XVVTyGkppXFnYipfzb1QSQlxNaxr5pfYc5+tQaDNca0+JLQ0RYt12DkuLsnjSR7y6q717R9vyr0Uc4lfr11T1ThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQvW7h+dsDxjJ8NnnrXPzixokWCv3PpABGMU2tpw9Qg=;
 b=BZZkEmiJnT0/dV2OV60zAOB/GeC2Vhx8QSrC5KJGwFmevuUIppvbr4HLhnWcpajqG9uDGZbLjiRR0Dtof/cO1wyPYTccMpnHtk0TUOqrFlSuSx4nbvByszy4Fj1pspAzy1FDnBMzxmsXYldwR7eux+ZHPRWoDn7OkeDbQ72acHtSYhGMLGVNPZOq40nqLqy+z7FXr8KXMdO/bchA112RCyMzH+CYTo/UhLGpTWD+p+gf8guEqu019fFJf5fZqGJHNENcKKuF0ANADqMI8n0usOAP4H7hRwQgv2mjTrkztoxr8DGYXVcQKdO9c5rFFLSX+hmp229udZOP9bRYB/HX/w==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by TYCPR01MB10891.jpnprd01.prod.outlook.com
 (2603:1096:400:26f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:49:37 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::7679:e9eb:aeb2:f12f]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::7679:e9eb:aeb2:f12f%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:49:37 +0000
Message-ID:
 <TY4PR01MB144326D3A2DE75620443E470A980FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Date: Tue, 9 Sep 2025 21:49:25 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Parthiban.Veerasooran@microchip.com,
 linux-kernel@vger.kernel.org,
 "andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>, lee@trager.us,
 horms@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
 geert+renesas@glider.be, xiaogang.fan@motor-comm.com,
 fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v4 00/14] yt6801: Add Motorcomm yt6801 PCIe
 driver
To: Frank Sae <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew@lunn.ch>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
 <Z_T6vv013jraCzSD@shell.armlinux.org.uk>
 <da434f13-fb08-4036-96ed-7de579cb9ddc@motor-comm.com>
 <4fac4c4f-543b-4887-ace9-d264a0e5b0f2@lunn.ch>
 <4ad68dae-311f-4cdd-a6f8-0229f069ece3@motor-comm.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <4ad68dae-311f-4cdd-a6f8-0229f069ece3@motor-comm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PpBriOmF2JVO1LzWygyKBeEW"
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID:
 <24a39c41-0e42-4c7f-a5a3-e01f85b00591@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|TYCPR01MB10891:EE_
X-MS-Office365-Filtering-Correlation-Id: a851ef3f-8ca8-4f7e-03b6-08ddefa7b70e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|5072599009|461199028|6092099016|23021999003|15080799012|53005399003|3412199025|440099028|41105399003|40105399003|26104999006|26115399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZE01WVd4VTlOdkJva1RJbkhIVlpjK3NJMCtJMFFLV3dTQ28zajdORTNOMm5i?=
 =?utf-8?B?UldrK01RYUxBZDhEajdPRWF6dG9DQ01OZklYNUk4L0pmWGw1M0cyVGxjbmdP?=
 =?utf-8?B?N2RoUU51RVdMcXM2cWR1bWVrOVByQ21EazV5bFFiVW5iU2pVUU1TT2ZYR0hH?=
 =?utf-8?B?aUNLQm51cFFUdVk1V0JrQ3hjdlI3Nk9hZXZlV1VRU01iKzBJMXc2OTIraGpC?=
 =?utf-8?B?WmRBclpNSU1Gd3NmRCtzbUt6VHIwUnNJdEJ2NmdjZ3ZNRWhCTDZVS0R5K2g1?=
 =?utf-8?B?K2s4ZlltVXpkOWtpZ015TTdFOUxOTHJJT1R6Z1NPYTBnak5FNTJGc2JBZVRC?=
 =?utf-8?B?NVEwNDN5OWF1RXdZb05YZVpxandBekJGazE5Q204MmNMY2NjVDFwVURzQ0Ra?=
 =?utf-8?B?QW12cGZiMEhZYU5kYkx2YUlvbDE4ekVXOFFRMEV3TE5tWHc5bm1YZ3llaFFB?=
 =?utf-8?B?OThDQ0wxOUFzYndUN2RTRDNUSW56bERsTXZWWHo3Wlo3ZWRIczZScnloVkxZ?=
 =?utf-8?B?NWNlTG1UT1dwK2QyVnEwZTkrcEtaNGdqNXFFaTVtZWY2eDkzdVNoTVQ2S2pO?=
 =?utf-8?B?ZXA0UWc0bWxwTEVxMm1BRkNZczBmZTl1UjFlQkZudXg1c1NldUUxbTZaRjg5?=
 =?utf-8?B?bVpxWnlSNU02Ukd3ZDRWSEE2MFRaTG1VU0E4cngySmlpYXlWdWMyVmlZWEhF?=
 =?utf-8?B?Rk1zOFZQY2ZMdGt6cDlhSFhTekpvZ0N5Y0hpNHdScFNSSmZNV3BKQXlSbXhw?=
 =?utf-8?B?VXFpd1J1dXhDQjdjcHZMLzhqeml0OU94cERrRjhVYzJEVXdCaWpiMkRmbmx5?=
 =?utf-8?B?YTR3Y3phTXJkS1d3ZlZKQ1hGSEo5cWM4Qm9uNUhNeGk5bkppamNVQ2xFTW1S?=
 =?utf-8?B?dElnR083Tlh1eUYvYUlqaTZSVm55SFdwNlQ3b0ZYQjdGQXZaV0FDNmVzQnc2?=
 =?utf-8?B?MGNndGF1OTJOK1d0aktZNXFTRVNNU1RZY1Z4ME4xWUx2MVhJSlJlcGZzdHJW?=
 =?utf-8?B?eEkwTHBYTzFKYUhwZXQyVnYvVjhZdm5pRlNhWnJiZDUzanBZRERsMytTN1V5?=
 =?utf-8?B?cFQvUWEwVkFReExoL3l1djY4bUdSNStFZndaKzFac0RRWnZFOEhsREROSytO?=
 =?utf-8?B?R0dQTk9ZYmh6WTJGY0VHOTZUODdtbVJxYkV3MmRmL01PcU5zQ2poVWkzRnRM?=
 =?utf-8?B?ME5tc00rZ1k3WGhOb2dhMGlKeWVVNjZCZDBSWFJibXpXTEFwYldTSFdITFQ1?=
 =?utf-8?B?Mi8vUmJseXFuU29aV0ZlQzF2dkNtZlVDYk1BVkJKSG5BU2FaaWRGbGNoaVd1?=
 =?utf-8?B?VUFKKyt2TG9HaWRRUnA1THk0ZXVXRHZ1U3hjczh6a3RLbHZ1MUYwZHFYRVZh?=
 =?utf-8?B?SzEwMjJMMXkvT2dZSXoxRWgzL1RYWDRoMmE5VFM1ZjlsZm9xemt0VkNBZ3dY?=
 =?utf-8?B?VDdyVGd0MjFFK0hwemVaNURydFQ1ZmpUZ3lpbTY0aXdEOXBKdDNBRldzZXJU?=
 =?utf-8?B?ZFlXQUNIblJVbkpyeCtyL2lFdFBVbTJBd2RBdTczOE5pRTdvRUJsRnhoUWhH?=
 =?utf-8?B?d0tsT0ZGdlpuYnZ0QWZZK1g3Q1RKbjZpVE12ZnRsL0JoYTVMenNmaHE5blUy?=
 =?utf-8?B?YVQ4U0IrWUpHR2d1VG5YWUtBM1FwVVNmTUJaTWNoazVKbjJlRWxmaTBEdVdG?=
 =?utf-8?B?V2p5R0kyMzVZL1JFU21TTVNGTE95RHlIZGYrVTJ1dmoydzZzUHRZYWhuN2dB?=
 =?utf-8?B?L1p3b2VYd3dDOEZkSnNybUNRREpMa052SzRHTkZVRERKTkxnb1hiVHNDT1Js?=
 =?utf-8?B?L1FyR0t3YnBDdjRrdEZYZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGorWHo2bFRCd0lmZEhJNU90bXIvanZMV1Y1Y3V6aGd2ZGlUQkQ4QjZZaVR0?=
 =?utf-8?B?bXZLeDFWcnV4ZWd3YnpaUEFVSFhBZnBIYWtWTGNRV3dpZWF3T0VkMFVjZko3?=
 =?utf-8?B?UVNMRTRwQzhYVk1ZWDB6RU91ZC80VjJtbkpEbnF5YTAxcXUrdVd1TmtFUzF2?=
 =?utf-8?B?R25JUGRHbW01YjRRYmZPSUVMZmp1Tm1wemY1dzJWTW52MXMyT2x0K2U4bE01?=
 =?utf-8?B?aktUZEhaK202MytRT0lwSVphd2ZZcnRXK3ZTUWhUNmtDRXZNQjVST1RaSkhy?=
 =?utf-8?B?WEphcnJMNkFic3RqM1BlUWw0SGtsYkh0em9LQkY0K3NRQzNkSE95Q2svOUxK?=
 =?utf-8?B?ZmJrcWZBNUpTclNkU2FJbE1xSjVmSDNPQk9QVDZoV292L3ZRN0ovUHJ3OStS?=
 =?utf-8?B?U3F3aXZtN05NNHAzM3pLSFd0SzFlVGVFZG9pdFJKMXRTWVJNaW1uTS9nQ0E0?=
 =?utf-8?B?SVEyeXJ6QU9lTUh5UG1pWmhackJRMlJlZnA5OGUvdEpjNG9LTmM5R21VNEFk?=
 =?utf-8?B?cEszOGNxeE5VclNmVlBQUGI5blRxeFd1YW9uOHZ4Sk1FMktHS1RXb3VIQk9n?=
 =?utf-8?B?YUNhZUlIM01BWVpFN1JLSk9HQVF2Njd1Umo3QXR0cGxqeis2WWk1Q3pJRDNh?=
 =?utf-8?B?V3JvdVdkRWN6QzUwWVpleDRPTUJuVTkrbXBnMVBEc2dqcVMvVFhjYVlZa0to?=
 =?utf-8?B?NU9uQko1OExDSzM0dHNIOC9CS05VT0lFNW9uYUlRb3Jha3QvNGNlMUtVTktC?=
 =?utf-8?B?bFcvdklmOEhteGNmVHdaZ2RYY1hBTVNqR1ppN2MySDU3N3d0ck12Y0Y4dlds?=
 =?utf-8?B?UUU3NDFPV0phbnFjK3laMmY3SmdlcHRwVEdoUGJWUmpHTjlsM3NibHNJN2Ja?=
 =?utf-8?B?UEhnOWNMaHFta2dXSS9pT1Y2eVdxRS9zWlBwOFF1NXJ4eTdCZnIvcGx4cmkr?=
 =?utf-8?B?a1drdzhNRUZJdS9uYkRNcjFmMG1kYnd2cVlodE9CbkJ1cEc4YklxVGZ2a2hp?=
 =?utf-8?B?bTZ3aVdXU0pUSDVDaTgrVGhucVRIMm9Pc3ZXY0hZQnNBN3k0ZDdncHA4SnhE?=
 =?utf-8?B?L1M3akRZdG80Tm9rbjVYWUc4cEJ1SWZGTHpXNm1BeFpBam9CZW50SkFUakJF?=
 =?utf-8?B?ZU1uWFFvTkcySG40M1ExaGc1TUl4TTc0QmxObndMV0xNYTJDdXg4RlIxcklh?=
 =?utf-8?B?SXRHcGRvWnV1bmJvQVFaWWN5MmtUTFFJdTUyYVlZeHZ1UFJUY0dyQUw5RkxB?=
 =?utf-8?B?c1J2ZVdyRVpkSE9ENHZvc1dzSk9WZjBBWVlqWUhDZ2FxQ04yeWdEZ3VtdUtX?=
 =?utf-8?B?VU5CVEs1bWo4dW9xWnFiQjF4bTMwcDRJNmJzcitJZmxQZzVvTVV1cExYSHg0?=
 =?utf-8?B?TGRseHJaZWRWaE40UVFhaFN6VTNqVmtlWGlvNXlPK3VOVnM2TVF0ZDJaalMv?=
 =?utf-8?B?MnhjZkd5QU9xUnp0VCtVVUMwN3J0VVFHQWVvWW9UaXJQV3dNYnYrM1Q3RHFx?=
 =?utf-8?B?Q2x0Um8ySFJ1clJ3cWFaTGs1cVhmcmx1aUR0eFMvM3BsNkpRUTJ4amJlWHhX?=
 =?utf-8?B?K1J5TzdJOXNCTS9uOW5BS0EvcVRlWDk2WEpCV1VFNVowLzFrSXY2cXpKaWtx?=
 =?utf-8?Q?qAfETT10Wbr/BtsBM9cjat4uAC/Ks1p+ir7HyZUWSLtY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a851ef3f-8ca8-4f7e-03b6-08ddefa7b70e
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:49:37.0102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10891

--------------PpBriOmF2JVO1LzWygyKBeEW
Content-Type: multipart/mixed; boundary="------------uUgPGVUggQ30rC9nKZzo2NXQ";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Frank Sae <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew@lunn.ch>
Cc: wiagn233@outlook.com, "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Parthiban.Veerasooran@microchip.com,
 linux-kernel@vger.kernel.org,
 "andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>, lee@trager.us,
 horms@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
 geert+renesas@glider.be, xiaogang.fan@motor-comm.com,
 fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Message-ID: <24a39c41-0e42-4c7f-a5a3-e01f85b00591@outlook.com>
Subject: Re: [PATCH net-next v4 00/14] yt6801: Add Motorcomm yt6801 PCIe
 driver
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
 <Z_T6vv013jraCzSD@shell.armlinux.org.uk>
 <da434f13-fb08-4036-96ed-7de579cb9ddc@motor-comm.com>
 <4fac4c4f-543b-4887-ace9-d264a0e5b0f2@lunn.ch>
 <4ad68dae-311f-4cdd-a6f8-0229f069ece3@motor-comm.com>
In-Reply-To: <4ad68dae-311f-4cdd-a6f8-0229f069ece3@motor-comm.com>

--------------uUgPGVUggQ30rC9nKZzo2NXQ
Content-Type: multipart/mixed; boundary="------------ngwIJ9ElVJt8svkQMB65E0l2"

--------------ngwIJ9ElVJt8svkQMB65E0l2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCg0KPiBBZnRlciBpbnRlcm5hbCBkaXNjdXNzaW9uLCB3ZSBoYXZlIGRlY2lk
ZWQgdG8gdGVtcG9yYXJpbHkgc3VzcGVuZCB1cHN0cmVhbS4NCj4gVGhhbmtzIGFnYWluIQ0K
DQpTb3JyeSB0byBib3RoZXIgYnV0IGFueSB1cGRhdGVzIG9uIHRoaXM/IEknbSBnb2luZyB0
byBidXkgYSBkZXZpY2Ugd2l0aCANCnRoaXMgY2hpcCBhbmQgcnVuIGxpbnV4Lg0KDQpDaGVl
cnMsDQpTaGVuZ3l1DQo=
--------------ngwIJ9ElVJt8svkQMB65E0l2
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------ngwIJ9ElVJt8svkQMB65E0l2--

--------------uUgPGVUggQ30rC9nKZzo2NXQ--

--------------PpBriOmF2JVO1LzWygyKBeEW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmjAMGYFAwAAAAAACgkQX75KBAfJsRme
cBAAkqGGMWyPbhQcNTexpUSmV2IF/I4ek6Kwa36ib2RazOgfjj2nzbs+egLk2Ht5sUfNVjVYCPXv
Ml5Ny6WQM+NE6p7YfcdQ/gs1qjdvTrnNx5ZWlkQ+lPrrVb+cx3PGzndk0qRXmRZ5FuU7MtnneppU
zDXU/lOMTX7Uq9QHOat874Az99SqKU39iHlzxlhEiiH/3srAnmx81nmffaJFGcwQnrYplNSAkTRh
0crDGPcarDPUwEjbp5in5m4vCi2xeDpyTrcCCSWU26B0jNWyW2kpwoimxKEP/P9ScEyawWzGLXDN
PJ6RoQ0FkGtRXWxiKsvXERXId6pntjpSIS1dzz1oKQOYUjGCYoFvlNb2hDA9HbTdHbkM21+s7bk3
t3J7QHxay5TIrrUpzO+KgP5Yd7U/nKS8lxXogEK6oQLPHKPyQ0DAll0gp7LjW26wTrQz4pFd4qUn
ntgdNY62vVIRGqBZrZbbisFF9eX3I9NgL6DuOXItfG39VdnIg0XuBDRBRZ78cWiL73MgVWDL2W7Y
0tq271WxADZMtjIj5GZcv0ufM36hpoDkIGVJxTlcUTPLdaMz4h4s9/uiL1SlRmHWFMBM6WN7qzDP
phKVQSzSK053WsvGIygA8x3xhMuNFVdxaF1CcxnjC77PZDf40t8TJ5+6x7kZuqot5N/NHz4oKefP
e0A=
=YOIH
-----END PGP SIGNATURE-----

--------------PpBriOmF2JVO1LzWygyKBeEW--

