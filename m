Return-Path: <netdev+bounces-217153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E86B37951
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4FD1B65023
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114762C15AE;
	Wed, 27 Aug 2025 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="NrusN29W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3C27AC34;
	Wed, 27 Aug 2025 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270515; cv=fail; b=TO2UPRBaJDPWKjVW2ULwC3uP8yUvtAq0QUqkh0yMDD4+sZGK1+/FCInlRlHCuMkQRfevNNv6bxWWk6K/EAcbnkf9YVP1/JgtwcfeKEShulO0y7qA1wkaUOqAEMsS8Pykyhcj0y1Ui563sTOPYuTdggR8pNcZLRF5HGYt8G9+2BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270515; c=relaxed/simple;
	bh=GzznVRvDK8T6r8+agNxd08/Oq3yg93rk9qFRAD0WXrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IvK3Ur//baYOfPuP6BUKLrI67ZKHMu/kxr/Bsa5hhq9k2sJb35z1dGJBPUV2km5HRxYv8XgZq0ZrY5ydv76F+T9sf8T0KR4PDMqmvdO0/0wgOgScZ1TUiDDe+q5K7exQWTtnzIDMOE/IPfpInvmP6Emb0ipaVVjR7UoLCqrAD24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=NrusN29W reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyd+NxCt4Z1S6ztLiLbIiDdrvbkWrP29GvMjD8Rfzylv3pp1kajv/vRnLtUUJ8uwiKIR+FFow/Rb2Qmi2fVoCP25iAggMt9eqAes/oR+h0ioqxK5k6de9KJ0Ngo5DWO/VmCOKZ3nfb3wYLQWGq/LJC6yV4d6VntMWmZKYk4jSV5+tqGyP57+lXKKA9jB1zzz09BoiItEVdf17J6GeSWY5/jtLGezrtRntt1EvSk4jpo7Tru+lbZdF2PF7Jwh7I6kFRPA/a+gj7NaRvChzONbuVmx4OCYC9TjQmghMgxjnI4hrcAfF3vVHHm/fCEQjV/c+Ha3NCeMJnvYUfE5OLXxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwNWJzOH7Y4SzR/ddA4o2U6q8H/JYw7qmBsld+03Dxk=;
 b=C8s4UgDjXtk9Ek7LyW8EXoENQ9JkM5Hp73jVzAvjZ5y0htWwz6zQpLLbef/u9+exfSWmE06J7Q55O3vrsS6/afBpQS9ACgl60aJyEuSzjPK2eyw5N18yemJ0Pwi/lxbtMYmH1y4y6nngFFiegc2L3jBc7FqTRbNSiLeQR6Vqhh5ov3ZzPeIqEJ7buej0yihdGS21Jp57pO2ztmA5KjSBef39Pay8Jzs/dUGjsWFc2mK/fKG4wERujJP5O7UYjpXti8u63/K/Tcz6JrhklC/gU7tvjFmfc/5TclcQi+ZmUIfAAvPYEvaOk5zmznxcWDHTQnzBoHoYOyYo9b4jF7VnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwNWJzOH7Y4SzR/ddA4o2U6q8H/JYw7qmBsld+03Dxk=;
 b=NrusN29WvWVdUfIOYXgOy83tBlvJ8drdynqqXKP69rqlhvQx/HqhsGRGg8WWIJM7xUB0r3USqed/xUzk+tas/M+GTyw5wUZuxotuvdsxBuwcLpABB/K+4/S0Hl+o7ah+pK6t1mRIdoqEJWsf2TrF3BlV9LZZUkhmwILedOuMn50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BL4PR01MB9150.prod.exchangelabs.com (2603:10b6:208:591::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.15; Wed, 27 Aug 2025 04:55:11 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 04:55:11 +0000
Message-ID: <ae68a2b3-71f5-4fe0-b74a-495bc537ab64@amperemail.onmicrosoft.com>
Date: Wed, 27 Aug 2025 00:55:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250819205159.347561-1-admiyo@os.amperecomputing.com>
 <20250819205159.347561-2-admiyo@os.amperecomputing.com>
 <88a67cc10907926204a478c58e361cb6706a939a.camel@codeconstruct.com.au>
 <d15313f4-46d1-4096-bdf1-783afd8e439d@amperemail.onmicrosoft.com>
 <9b66a22a2fe689a993d9ff83baf8b7bbecbb8c90.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <9b66a22a2fe689a993d9ff83baf8b7bbecbb8c90.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::7) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BL4PR01MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc727ff-2f50-48b3-2057-08dde525e700
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1crVlg0UXY4RUZ3cXhQQkFsZndZdVF2T0EwMnhCdmxjS0pSZUR5R2loSUR0?=
 =?utf-8?B?TUQ1RjFzSG1WNW9uNXpuYzRPbVFDNWE2Qk43YXM4UExHZU9iL1g2N01icmRU?=
 =?utf-8?B?WUVkbjBCQ2NEUTZlOWM0bmlMdEdSSXJpWURKb1pyMEFHUXdtZmNiUk0vdWtI?=
 =?utf-8?B?NFZDS29mZm5BNm1VcitkaHJhT0JVV21wZyt3RDM1Mm90Sk5GMk1HUTlWdkNW?=
 =?utf-8?B?SkFxY290alQrRi93ZFNBcm9aZUFPYjRWZEw0NFNOY0tpbVYvanVGY3lkekc2?=
 =?utf-8?B?NGtRL1pxdGZaNE1xQmt0YjNNbkl1NjN6bGJ3TDZpb1RIaWUvdzVPZHJtNFRh?=
 =?utf-8?B?cmIvaTlpL2xaRllsZStxVitRTDZaSC9hUldiOElDMVBhdGpubWMxZVk2V3FG?=
 =?utf-8?B?cVdMdjJJZmFMNFRjT1AzTSt1a3FHU3d3MElHb1k1OGJLV1I3dGtYbDV0cFhy?=
 =?utf-8?B?Q3UxbXdqbHZNclNIZGdHT2FNUW1TTTNyMVRHRzRTT1JheUdmQkh5c2t4YUVD?=
 =?utf-8?B?TUR3U3NCVGF2dFZyR3ViSGZZTmdJSjZVeHQ1T3psOFJwZ3NMc3lqU3VRUnBs?=
 =?utf-8?B?bFJoc2NWYVlQdEU3UkZ1bmNudDJjaG9LRll0NEpBQTFuamF6SUJ1Qmh0YUtP?=
 =?utf-8?B?NE5uWGtnL1VBcjZhUnNOL3ZGR1VaNUlJcWhDUlFMS1BWVzBoN09UQjVTU2JL?=
 =?utf-8?B?Z2dBTEdUaStnSk5ld0VhVXRZcldIMlc1eFM5MnAxSzNoM2tXbURSYS82NHM2?=
 =?utf-8?B?ZDBSRW9qRzlJcEE3OVRKdVI2eVBXSHZjaFhSZGNaTjdYZ0ZjN2FxajdBS2dB?=
 =?utf-8?B?TnBXclpRbFRIcEJGK1gyS20yTnFnR25NV3Y0aEJRZzVOc21FUW91UkhZWE9n?=
 =?utf-8?B?YzdvOTFUVEZJZTFjVTd5WUNyTjZJbVBwSlM1RjRwelJ5b25FM1dGYXpZYlFC?=
 =?utf-8?B?ZktwWXZCNnhydm5EdWJGOTgwOTJSWTBuQTJQYmlGZzdtaHptd0c2QnBtMlFB?=
 =?utf-8?B?UEtZTFNLRjVBeW5GaldLVjhqNjJaMXJhclRpZlk4bVVhbnluNEpsRDAvK3c3?=
 =?utf-8?B?N2Y3SXcwQ3htY0w3KzNyZTVNMnYydFJBQVpRVGZ5RXZ3WVJVSitwRi9keWIx?=
 =?utf-8?B?NWh2VVRWOWJwQmlZL1o1VktiOFNvZ20rbHpKdWFMekd0eStMSGVpMXdUSFNO?=
 =?utf-8?B?NEszTnBFTldHNUxFclkwcEVTQ2lEVUpidVJaektjQ0d0VXEwd016eXZHS1dS?=
 =?utf-8?B?Y1RuS0R3b0Z6bTIvOFlGMFJ2am4zUTRob1lYd0l3RzVpbE1UZUY4a25GNXZp?=
 =?utf-8?B?dWlaT1NmNGZ0TCt4emgralcrQmhqbmFrZGE0UWVtYnhiRld6QzZ4aWhRaTJB?=
 =?utf-8?B?aFBPVzgyeGVOdVNHTFRENmdFNVU1UHJteVVjYjJNSGRTZS90NjJJc2pXL0xs?=
 =?utf-8?B?bUVRVnQ0azdLeGVpeERYMHdCZERjcVJIeWpHTndoZDNEbUlVa0tIZ2ZMblVZ?=
 =?utf-8?B?Z0NEVlBpditZQ053MFFJOHR5NXV4UEsrTVFIUEdrTDJhRllQMjZPbGc1Mng4?=
 =?utf-8?B?a3ZQb29mbUp6NXpaRHR3dERnWjloLzFiYWtSak1uZHBybW5tbHBleTVEdjV4?=
 =?utf-8?B?aGlmS093YU9GdTlVSFlRQzR5UVplMnRoQW80cjhqTU1CYmI0eW5oV3Y2L3d1?=
 =?utf-8?B?TXB4YWx5Vk1pNFUybWhoK25kMXplaFhlTHUxS1hLMHpEVTJNbStheEI3cEhn?=
 =?utf-8?B?MDNCZVNpRVVrUWdJNENQS0dnZFcrNFlENW4rWllYV0VlRlNMRTM2L1J4NmVL?=
 =?utf-8?B?dVpIUTFNdE5BWHFoR3VUR3laU2Jud0Zma2gxQWIwZ2xiUGJUdnFWSlkvd2xw?=
 =?utf-8?B?VG9hekVnaDY3YWFDalQ5MG41YktranlhTGxKc2MxTWhnUkI3SnFZWGFTT3dG?=
 =?utf-8?Q?apBErSIKAzw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTUxTDgvcE1qSmc2ZElJMExMYVBHRi8zWGhlcTQ4NTZmVEEzUHJRMnRqcnBw?=
 =?utf-8?B?cDd4K040MUI3T01JRDF1SkxXRThMTGVEUERGVng5d1J1YjB3M1dUbzdQNE9k?=
 =?utf-8?B?a1k5RWZuT3FqcDB1eE52TmpTNDBGT1VtM01BMkVyalpZNkhFZmZtbWtxSVZR?=
 =?utf-8?B?TzF6MFpDRTM2ZGU5dVIxNzN6dWkvZm1vVEFuRzRwa3YyUVdVVGdsZTJOMWVx?=
 =?utf-8?B?MzRaeGluTzBDUnAwZ2psSTN3QlJZY09vaThwUFR5OGdVSDNxRkNTNzR4YmNr?=
 =?utf-8?B?RjFyczIzSjdYSXBwaW1Scms2aFoySTBJNkdKc0dyRXh0V01tREZaSW9YdzRU?=
 =?utf-8?B?TXRZd1o0dXZWQnRQcm4rNkk0R08wQnZacjdZanJRR2ZDOVBadDhmZmlZZExZ?=
 =?utf-8?B?NnQyRE9QSGVVbFBIVWtWRFhaN1IrK2g5VldDUVh4eGlDVEVUMVJJTWVTSzdw?=
 =?utf-8?B?RzJsOThmTVE2R0ZDL290d1dhbzkvcTZKcCszaXpvTUo2YmVEcStWOU1rSVRu?=
 =?utf-8?B?V3BrbW5pVVpVU3p2dm1nQVF2a3Q4VU5QNStwdzVybnBmcmUyYnQveVQ0eUdq?=
 =?utf-8?B?SExlSVhRbVdxV0xFRWg4MXNuRG5YNUJDZHdjTmFYeXhoK2R4ZUcrYUMyVFlI?=
 =?utf-8?B?RHZGbjB6QnI1L0oxeCs5YVEzSnBQM2tzVE5XSlNqazROTDZvZEthOGdGUFVD?=
 =?utf-8?B?U2FVTDZKSy8rY2w2TlVWSXhvREtKQWNZYi9KQXF2ZHNxRVlTM2JhSFhXRHl5?=
 =?utf-8?B?QmVjMGVVa2JkRDY5ZGp2eUpoQTg5RkMvaGhnR3BKNzFLWjdsQ2FqbHM2V09X?=
 =?utf-8?B?UVVqQkpqakNJRHNwS2ZwcUJaNEtGM2tsY2E2M2NxbGlwbEpoOU1mUDJNUnhy?=
 =?utf-8?B?WEhzcThMNEIzWEVjYndMV0JScjZ4SUZvNE1rcWdpbFlXNWRQVGk1amEvcm9v?=
 =?utf-8?B?NStObTJRSVVBTU5vMDhJQm9qTjh0cm1wRGE3U2ZhUW80WXF5blFHTkhyQUQ1?=
 =?utf-8?B?aDRJcFgwbXkvSElteDJtMTNidDNET3RjeTFHck9RZWlyZnowOTVUZGVmWVVh?=
 =?utf-8?B?b1RsTDQ2VG1GeWVsaW1EWnFJeDNSSU9rczh4U2xMK05VaGlkM2JTd3pYQmlZ?=
 =?utf-8?B?aXR3bTdmRGEwa3A2SVZiWFFyeTFwU252RWNmZEZzcmpDSTV6R0NsVXNpZHI1?=
 =?utf-8?B?WHJpMzNoLzdIMndKUE4wUDE0RkY3TTc2TjJDbG5haTFaUTNGc2lNS0pCV0J0?=
 =?utf-8?B?NTRBYm9VeGovckRvQ2xkL2RURWNFcjVNNjFLRHU1Uk9BOGpCZ2xHcnJyUUZm?=
 =?utf-8?B?K09oTElkYklsVWtZTlVFbzBHZGhWSXBIaFRFdzUzTDJsMlZtZWdRWEVmMHlx?=
 =?utf-8?B?UElqbVlLQllmajlsMk5nUlp6WVRLbDBFR1hPaER0N1hianZCbzY1SlpVb2d0?=
 =?utf-8?B?RGVZNlVTVnY5K1Q3bGRzUFV0QlY2Z2FMc0dhTHVJSWQvN29TcVkrRmtYQlVh?=
 =?utf-8?B?SU9kU3l5a1NxWDNqcDlOalROWldXa0x5Z00rTGdXLzlDTm90WDB4UVArLzgr?=
 =?utf-8?B?ckxxRXk4cmR5djI3aXBJRFNaem9OcnJSVmlZMEdrdnhaVnhWdUdTNWpNT2xB?=
 =?utf-8?B?Q2dyc1o2S1RKcWdvS0dBM015RThjYWlFdDJoYitoTE9qR3c0VENXZTdiYlR4?=
 =?utf-8?B?SVFrSy9ONWd0dW5MemN3ZGJ3SVUxTnFOb3ZJM3RtT0RwbHdMVitidmRLRFk5?=
 =?utf-8?B?dVlPdzZ3R251MXg2RERpSWxRaWVIQ2NaMTVjZ3hNVjJVK0JxejVsejhua21D?=
 =?utf-8?B?amVOVXIxcVhidzNISis0WnRCSnBYR2wyQ0djTm52Vzl0M1NCaFRkQkNxTWh6?=
 =?utf-8?B?TmZwQkwzbkF1TThaeDZ3Zkx5NkEzRzRrY3RVcktYbC9xdEw3VEJ6OWZUNW5k?=
 =?utf-8?B?Ym5oV0NGSU1MKzRMWVdiUjEyT2ZKeDN3L0NUWEFCNk10V0ZFTjNsek16YjV3?=
 =?utf-8?B?Q0lXL0R0V21aMTRkUjZ3MXBQSGFLNllKV09GZnVqczZKTjJKaHZOTmtsRUN0?=
 =?utf-8?B?dVpPTnJBYS81OEZKcVkwRXFJbGFrR3N0VytreWtPN0Z3dm1ZcjkwbzZHV29s?=
 =?utf-8?B?aFpnSmU1aEJDWmVxZ2NVRjUyd3NqMkFGTHVleDhGZGljbldqNWhJSTY2QjFw?=
 =?utf-8?B?Q09DZU1vajNNSkN1WVQyLzFtSlpiR0ZQdTRrWUEyTjBVcmhHWldXK2VpMVA1?=
 =?utf-8?Q?5R7gO6cviR6A5yMPBniloFIdyQlUbGsOPHwcKPSQRw=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc727ff-2f50-48b3-2057-08dde525e700
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:55:11.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZiVSXM2BrpUgcWeBFp5Q80ZyUGC0qREUMQWwakp8oivFXk6JVAbVuNLNwohlk57EUU78f/8aU/E1/il8ebTUSGlFoZ0SJl8fWfh5ptbrZ6idWhVdR/A9ZnGLuDES6tC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR01MB9150


On 8/26/25 21:37, Jeremy Kerr wrote:
> The only remaining query I had was the TX flow control. You're returning
> NETDEV_TX_BUSY while the queues are still running, so are likely to get
> repeated TX in a loop there.

Sorry, I missed this until just after hitting submit again.

The code currently goes

         if (rc < 0) {
                 skb_unlink(skb, &mpnd->outbox.packets);
                 return NETDEV_TX_BUSY;
         }
Which means the failed-to-send packet is unlinked.  I guess I am unclear 
if this is sufficient to deal with the packet flow control issue or not.

I have not yet had a setup up where I can flood the network with packets 
and see what happens if I fill up the ring buffer.  I think that is the 
most likely failure case that will lead to flow control issues.  If the 
remote side cannot handle packets as fast as they are sent, at some 
point we have to stop sending them.  The mailbox abstraction makes that 
hard to detect;  I think the send_message will hang trying to get the 
lock on the shared buffer, and time out.





