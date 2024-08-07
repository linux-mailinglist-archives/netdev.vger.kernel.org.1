Return-Path: <netdev+bounces-116550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BA194ADD9
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5FD1C20DED
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3948412D773;
	Wed,  7 Aug 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cNVznhYp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E25768E7
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047311; cv=fail; b=kveYnIIc6ybyMeTrtkzDGBlw7AsqbDWwlo6IR0hPbup9P9z9FRxSrCNBd356Wr0kMZqOgNt2aU2q62Xer2zdrU4RT8KV39N6AxGHWyQ1THa53C+shrs1NSxV61YbKt5yVcDuh2mre+rzaQYrj56pt4EPdfZk29845RiRQZff7Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047311; c=relaxed/simple;
	bh=Vu6xYCLaAsFV06xBOSFHRksqoo8725rT83RpGXqpGZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S9lRofN++5x0u5fFavXB4MGMH2sFZTmpXHttcN4ddZR9iiBIcp0VE7gHNXhu+THbvaBb5/thI3+sTyVNYgdQDYuoZ6rKolhN/HW+orC2dk1DpUfPlHamRtHoMV6nYTvWl7ktqR1yEIh5Q3J15CNn1zsjs9rReUx9ssWL6m/45BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cNVznhYp; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0KIKBeKtd4hgsaGIDHxwVBQ/nLThllmqzY0oaxcSZ8llax6oK5NI2ryla8BC501KzUZAPkWGcPuBJPb10hlt5oG6NprPX2QOjXs3PrvVgLx6J99vKZCP//HioCF33pVipueE+SlsoibNayaJcZS6YH4G2q6J5RqnGf9XxcqzH4GdBEBkUy4SaiAf3ZSeua9hA2S9cGC2joVdjiBLdZFHasaWKiG7cWUutGS1ty9UTSGd2Z9AH4h/j5dh2YVcmFYuN68q46H0xgAK4D31W0zD2WEqHrSmCZybRQV8CAhUMU1C8qlwHGeaUDcDSuS+GQobZQ6djKlOeSWiZJbDyyFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbGExsLb6qLghc80ANjs5QzvqZHChi7gcJZfNz3BJ9Y=;
 b=BZXnDS7yMKIPON8fpUNoWrqCleSCzCC1D1L8mQ/HObVhKr4dRqRQlGXvw26yELvM/U2wap5ocgxYY65bCPlk5jB+LsnGhOOiwC9KHwz/RtMycm4259aguusxH3ToPBS9kmyfH3UCbHgYZLKEiaJUe8/RYEPUsaq/mDFMxUMt5y2tH+o7tXioA+r3I83DNYZJJ2kIzPsFusHCVmCo00ytfgDcjk3rKkobyYKB5zaa4u9Hc6JVmaoYT2NqkUWM6Sd9LaaOj76mGkPQ1/SIVoHIm58tnhLmXG9XclqIYWHSP0MD2uoPKBkGHZEtvDxE2HmVlb7l0GUQWhRx2GRbBDMnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbGExsLb6qLghc80ANjs5QzvqZHChi7gcJZfNz3BJ9Y=;
 b=cNVznhYp8aKzxDxx8BZWNUWZzy3jgFH32OmG47N1drkDsiEfhH+edQaAiQrNNMWVVDeSDSWW5BUm6yF2TDNymXahKelC00NjV2qyXwKZKMtS4QhZTvCTe0tpHPaMawe4Q8BlhD8APosGs3DQfTT1lZPz9RM9WweRe4jRf6U3VVliwFAvGIATQ42rryuPdgRhnGhsjwxqlknzGwEAsqJMuFVzBqNF2OD+tfK0YI9Wowxtm2JRaFEa2bO0efdztvemwjvzP7rcfNJJWKvO5ZCyfOBFsWznxcbFusnaYBm7fiKBZy+FwhUistfpFSewHHvJykG3YMWYcf1+2ZBvyR2bTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 16:15:06 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 16:15:06 +0000
Message-ID: <e5a9000a-230e-4118-8628-b44b682c8d8d@nvidia.com>
Date: Wed, 7 Aug 2024 19:14:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethtool: Fix context creation with no parameters
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>
References: <20240807132541.3460386-1-gal@nvidia.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240807132541.3460386-1-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0071.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::25) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b018de-cc7e-4b08-0e21-08dcb6fc19ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDNVUzFWUFhocFRvRzZVb0wrcG5LL0MvTXJkcVBlSTJJMWRQUENkTTZPcVZO?=
 =?utf-8?B?a1IvMGhqN25Na0RVYklEMTlwTFlJRSt6OGFDcGNSQ080SzZ0RllaUGlDck9R?=
 =?utf-8?B?WmZYT1VLN1BmVkcyQ2hmNHJOcTVyWDFvSG1ocmU3UmI3VzRlSlo2WXJ3aXc2?=
 =?utf-8?B?Y0lZcU9FTnk0TWhwc09CNXYxYmxPdkUvb0xXdnRkeVptTlZFMmlzUDBVamxu?=
 =?utf-8?B?dHJqQlRLcU96UHZnQW1jWlROblVhWllUU0ZlMzY1cUxzSHJIS2J0U2trREwy?=
 =?utf-8?B?d0xsTjVmM0lJZTlneGJOMjd2ZStnajl2Ti9yU3RSRWloQm9yNVN4T000Q001?=
 =?utf-8?B?NEN0aFdabkw3K1Q2SUJ1bEJxWU9RNmVwNEw3YUhNYWVmVFNyRmVyeHV1Qk5k?=
 =?utf-8?B?M29xdmozcXI4Y1hnSVp4SzNmTFpDcDBWSDFXMzNDd3ZFSUZGSmtBbFA0dVZS?=
 =?utf-8?B?OXNEV2RSNnI1b0tnT2gzTXVIc0E4cDU4eTNUbWRtSVBQOW5XeEppYWsrVkwr?=
 =?utf-8?B?VE1zUVdMd1FqMHJONFJQYzR2WTU2MnFpZkkycUlyb1g0R1hReHZIQXBwZEd4?=
 =?utf-8?B?K1VPeGZtcFVGT1laV3RZQTEwaUN2SVVpcTZlT3JFd3lVOVltU2VYUEoya0pK?=
 =?utf-8?B?Z0F6NzB0enI2NEJWSzQwVWhycm5WNlBzdmVtVHVxTG5WNEFZS2hFdmUzZUxj?=
 =?utf-8?B?RzI3VldKN3h1dU82bTZOYjJhejRUdzFwT1NocThPSUtlN1Q3ek9jU3pPcTJQ?=
 =?utf-8?B?UGs5SVd6ZmQwYVRNOG9TSHNQK1FySjg4NjZ2MHIzWVhYaVVSRFFsbmNXb0xT?=
 =?utf-8?B?UlpiTktMU1g2UHZsNW1MY3N3VmF4eWpURUQra0kyRUpCT3NrVWdGY2dySktS?=
 =?utf-8?B?anRycHJ2ZXF5SnNYQ1paMk9CeXR2WTlld3Jva2I2blJrNXNaL05kdzdJSTd2?=
 =?utf-8?B?dXVzRjd4aEZwTFJodmFFWnJCVUIrS1piT1BFLzhZVThONjNuYkdtYkVzV2JX?=
 =?utf-8?B?aHFCNDVjNlppL2U4OFlvQWtJNUVjOVEwUG1ZeE90K1FFZWFORFhidmdYL09j?=
 =?utf-8?B?R053Qll0L2t6bTZ6bXNzRzZnMmJCTXY4SzdURHJsTGZDZ2g0Ym1Wc295Nnp1?=
 =?utf-8?B?Tll3R05pUldNb2d3N3RqZ1gwbzVQeW1KOWVXRGl4ZlZNOHR3MWRMV0NobEE2?=
 =?utf-8?B?eklpSHpHaHE5YU42YUdmbTJQYzlBTWk2VUZuREoveVEwbU1oOEtpa1pGOTdZ?=
 =?utf-8?B?Y1lQYTAxR0xYb3M4ODRDVlNGKzJqdnYzM05adlNOSlZBamthbmx6cHUzZkh2?=
 =?utf-8?B?ZUJ4TkxWRitNU2N3SWlvcHhRYXV3c09rRVg2ajc2WU1SZzFFOHVYQWpTNmFr?=
 =?utf-8?B?MDBXTkJmTVZ6MHNqa25VRlhNZ1RrQWNPdmVaYVN6ZXJYem56ZDlIRTNvUDNH?=
 =?utf-8?B?RXVwVmRxSkdoVjllMzhjaFFOazNaRldNNnN5R0w4WDlPYVVRUEs1UmlPcWd2?=
 =?utf-8?B?cnQ0eEVSY01lUFBDV1J1b1JJYTdsZ0FoSTMxcTkwMmFKNWRqTGVjL0d6a3BN?=
 =?utf-8?B?WERXeWdzVHZnYy9uMUNHbEtaNWQ2T05NeVpZNjJUbHRTZzBHY0YwWWk5V2tV?=
 =?utf-8?B?OXZsRGFhVTU5cERMNTlLYUpBQ0ZIK0xMdUdIb2dBTGJqdWtTZll3REc5UEpx?=
 =?utf-8?B?aDBMVFMveExUWmQyN3hjTjhZVTlaaGpZNE5KL0c5OTE5bWwvL2JnUWFUZ014?=
 =?utf-8?B?SGVnM2drUjAxT3hDYjhyTFhuV0RSSnVtemxENkwwWHBjczRyZUNjWVh0R1Vm?=
 =?utf-8?B?cW5IQUZMaWtlTnZLWE5DZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3hxNE5yODA3YmJjdG9ydHg0RE1YOWRrT1RVbXhkRVVDcjRUSE1CcFBVdUs2?=
 =?utf-8?B?WVJ5MHVxQzFUSzZ6T25tcldUTGN6OWk4QTNQQzFSRDM1OGtCOEhmUnlYT0p3?=
 =?utf-8?B?V1VBL3Nod0swSFpRem81WG9vRW10OWphcVRBZzNCam9WNDhXMVpBWXh4Nllt?=
 =?utf-8?B?bGxtckNEZUtRd1Z4bFhDdGVpWlRGYlNVUzZ4YUZpSHFic1pYSEVCUHdvN1Rr?=
 =?utf-8?B?L2h5ZUdENTFoNnU5dDVxTHl4UlEwY1ovTXRJTXl6QTNENDZmZFFwM2hrVW52?=
 =?utf-8?B?eTB2ZlFBZHVtUmdrWFdGTW9vR0hrQkdoT21LMkE3aldySjY2aU5TNzdJQnJL?=
 =?utf-8?B?blpvcXdJSnRZcFBoaGtMd3dobDF1NzlCeE1xaUV6VU5DSGZ3V1ZCaitPVE5q?=
 =?utf-8?B?bWJxY0grT2JIMGd3ajhINEQ5SVgvcTc1OVRLZHdhekJDTlBwOE9xcE9xRWt0?=
 =?utf-8?B?V1M3YWVpTytMOFUrMDVDSUZIRUZMZEdyWWdXRXhZZGhuTmVaQjlobkZ1dis0?=
 =?utf-8?B?UjZtT25mNFI5bENlNUM2OGFjanpHK2VQMjU4dnA3UFZ0RWdhN2FMb0s4MlZU?=
 =?utf-8?B?MTVhY3dubEZ2dVRUUWk2RU9JMHpodFR1WWpBUFFpcE45R2gwazh0WTY5cVV4?=
 =?utf-8?B?NGlvdnN3K0J3d3Jzakt3Qk8vM3FXbU92UjJ6L1RQVlQxSis1OWtyMUFwNmtI?=
 =?utf-8?B?Tk5TeHREZmFtVFhIbC9OT1ZweXJkcEhrYVR3Y2hRVCtKQVIzYmpoY0hZQ1lD?=
 =?utf-8?B?OS9ySGhNcjBLajdtR1RNbTVSYXpBci9xYms0eXRpWERNOUMxREZnRDNLV1Rt?=
 =?utf-8?B?T1E5TGk2RmQxeXJEVUE1OTJLM3NpQ21DTnJla3FNZXJHdzZiSnR0bllRcTQ3?=
 =?utf-8?B?T2FHa01sajhNRW5jUXVZbVl6Q2hoNjZYa2xYWHgwZHVIcjJjZ2lZZzFjZkRn?=
 =?utf-8?B?N1Q3UFZhUWhBbm1PNWVRdktTQ29WNVVPVWRrZ2hOSENkSk9Oa2hQU29TWDRn?=
 =?utf-8?B?TVA1bS9naU9yQU9xRjlGMzJ5dkNHQzZja2N4Z0EwMXIyVVNtSzRtNHJpTG14?=
 =?utf-8?B?OHg1WHMreTN6dUt1eFVNR1o2bllMaHpiQ1Bray9DSXRDcFYxZmsxYkxna2ds?=
 =?utf-8?B?Q3RQVksxZWQvSngvNGJuQ2tGbjNSdWczTVB1MUVmdXRjSlhtMjh2Mkg0cGp1?=
 =?utf-8?B?Ulp6RmFibUw1YnJoV0hFb29PQjJSTUVUWmsxdHNuYmdaZ3hEN2hkR0huMVl2?=
 =?utf-8?B?V1FlU2xSeHRhRlJOdUZOREsvNStKK2dMSWxWT2NXVUtGNVU4NkVsWVlFTFNz?=
 =?utf-8?B?Q0RJMHdUWlJ2S3diVXV6YXZlZzZNdXBBaUVuSko0RlRuUU1HRCtUa0ZkRHVt?=
 =?utf-8?B?b1BvMmVxSmd4WGhMUzI1elhIMWdUckpKemN0VldYdklJTGlNYzFXTERDZVps?=
 =?utf-8?B?Ry9mTnBNZjNja251RlRKWUk4RTNRWUlta0hGdW1aKzAwNkJzN0plbHBGejZp?=
 =?utf-8?B?clg5Mkw0bUhwZzFzSkFKbGtaQ0kyMFFnczZWOFVrVWNaSnZWQm9tbFlpbzVx?=
 =?utf-8?B?VEpXclVCaHcrNndZRC96T21RN01KZ0c1ckNUV2svNGFTeVE4aEt3RktWQzV4?=
 =?utf-8?B?OUN2aTF4b3VIaTNUWEdleFUyRzlYTHJCZEpPN05JSjB3OUNmZkN3a1Qva2lj?=
 =?utf-8?B?TlB1Q3JXalJ4Wlc5b0R1OEUzS1lSdlVDWEtITUpZamdoK0EvVUFJK05XMlJz?=
 =?utf-8?B?VHZBZHpSQmcxOXZaN1RVVEhQWktBK2x3TTdMc0hsSk4xWkg4K1lDaFIvSzNy?=
 =?utf-8?B?TjVVSG1TRE13ekltbVZ6NWJReEk0bG04cWxEYmJlUE1xTm5SS3dxcnJZaEVB?=
 =?utf-8?B?NFNPRkx1cnpqOFhEQmpZelB1b3NUUCtHRFNheEl4Q1p1Mi9aSk1QZitWa2ZS?=
 =?utf-8?B?TFl4dHFuTXh5bGlIMXIzMWYvSVlhemZEYk0wb04ycXZob21BSStrY3NYdCtt?=
 =?utf-8?B?NStOQ3ZLOWtNTGpoUFVDVGhzaUdVUVBxK1pwRWpGc1dZcjA4VE8xOWV5ZE43?=
 =?utf-8?B?bG5ka3J0NXNpMzNaa2s2U0NHakJZR0R4VmRTajVRekdzTjFZYWNRMTgzSXZz?=
 =?utf-8?Q?rKKkZ5Pm+A1RXQuP9PvAkb/dU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b018de-cc7e-4b08-0e21-08dcb6fc19ab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 16:15:06.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KwCssIZXzjMGvlq4UBUoJJLzjlf5VygcB0becU63SKXFz4HiJJpWfcZ0cXiRGIA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038

On 07/08/2024 16:25, Gal Pressman wrote:
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 8ca13208d240..2fdbdcfa1506 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1372,14 +1372,15 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	/* If either indir, hash key or function is valid, proceed further.

This comment is wrong, the check doesn't really verify the hash function
is valid. I'll remove it in my fix unless you have any objections.

Not verifying the hash function is probably another bug, but it's too
late to fix it at this point?

>  	 * Must request at least one change: indir size, hash key, function
>  	 * or input transformation.
> +	 * There's no need for any of it in case of context creation.
>  	 */

