Return-Path: <netdev+bounces-101261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73898FDE25
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 07:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E781C21CB8
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD072260C;
	Thu,  6 Jun 2024 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jAa9Z1rA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD719D890
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651932; cv=fail; b=jhexwzyR4aWDYFiGCVr/q4zxAeXjYEfAwIwuA0xy4MbalzBsQffk2ry3Mrt/9ZzMU4/CElRlnuLgvFthOILh12kgbXaSjF+EZpslwkxHu3/edz5JZj6LcZYSJGolnJeJHE63oPxb/U+Zco1ivRA2sLRzVOw1gcE98DqwDRKll00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651932; c=relaxed/simple;
	bh=pBnfwTOtLJqLkvTiD+Am0e/hsENfnQYm7sqj8vZGi6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lx69tv1GBVnHf8Dfrq5s5WlZrREzKEkxpixvQfR3I7Iipon1MDPe1DovNbEb6IvFxdxp+3D44mmfcZ+0Q1Z7fukfqsdB9Hn8VlEBYFsxXvSKcc1XVlugRg27zmBNTqrK0Fr9M+J2hOLj7okzXpZEz4zdqGMqG2xOICnq2FIX/lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jAa9Z1rA; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrBYPiuuTOl7BK9w1QV0kACujgkz5DVUtHdf9Kmrx5gqMl2aGQc64e6qRcAgxER0ZMocQWvNgOcT+9vWJocJGR8qqL9t7xUnaTL2bawQEAoUS7SADP1J/ZPXPsIsC6h/m/JXksyFbQGxKeKoWLsvJzim7/T4RC2DfOCMzLWJQ86/Iq3cattAqCCmcN/r/IdvcCfc2OLuMUQXsQ1q6wul8MUP60RuY8lI5xMmIvgH9p9OhhbqDxThkUOwFYKs4jrSjl2ZkkWhORi3fDY4YzYwjYBSpjAUc9gDst43YfBVJp7v/o5Dky2sO2vMt020foxH8ynIpAiBLp5JcniZ4SD3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1yH+bSGrvzFmUvaWks5VTzHINp+OQpxxCHDtW59Uz8=;
 b=GTAEA2Hftg5uGtkXn0B5Bv/SPAHXnifyiLaVkJRevZMizryQH9LNZYD8X+3a29pN1cnNiw/zzzerrCrv8TL4TQJWZMwWvgiq/T7V+WQq0bkSNqCQolHO9NiQAC9+j/iBsX4lWeKP5edGil+w3C2bSDRYD/tX7ey984HwhVCN0zXLu70OEazEQ6MxruTXVdh3jfU5u10p4u9WZlnNnXfWK/isSKjhFheUXlnjyV57FJcfzvXGpkrtCB0Kza/8RVRzTWHFfPmPqMGq4WJJ9MrSVYe3j0BrXcttZt9CwGVKSTFtHVR3VyHGxdPNAdvuc/tzpX7hNZqzf1MeLQDJpN3Beg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1yH+bSGrvzFmUvaWks5VTzHINp+OQpxxCHDtW59Uz8=;
 b=jAa9Z1rAq2AeA+BRW9IQh2/Zyc9CDYzho13s8FzKRVHNQfO3dLfpvZ5ZE6jtExK7R+bir3JuBSfUrwAh4Ajmw7ln8bVNtkm9Hg16cHgmsd/Jg6eQQ3PG91KtlbzHc7Yicf2i6gvqSUxEtw5Qey0S0yvsQfo0lUqhTi1O7MHqDly/nmnHFovboFR6HhXtGxT/9CF5iezsmFCtS6s1GD2eO+hjg3utYSdrBAUsWlO4GVFZC4YA0zKKvQqhmd6OZCxP4RjOq3xm/akbSTWgikxOGqQBX7r1RyHxPQbXL4XmnMcj4TIaqLnPnO9bBcLcoLWBUB5orgsBBT9DKS7rMHmRFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 6 Jun
 2024 05:32:08 +0000
Received: from IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed]) by IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed%3]) with mapi id 15.20.7633.018; Thu, 6 Jun 2024
 05:32:08 +0000
Message-ID: <a71ab8c5-b841-47bc-b11b-df4496918132@nvidia.com>
Date: Thu, 6 Jun 2024 08:32:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 02/14] net/mlx5e: SHAMPO, Fix incorrect page
 release
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Tariq Toukan <ttoukan.linux@gmail.com>
References: <20240603212219.1037656-1-tariqt@nvidia.com>
 <20240603212219.1037656-3-tariqt@nvidia.com>
 <20240605202019.740a1682@kernel.org>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20240605202019.740a1682@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0274.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::6) To IA1PR12MB6018.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6018:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc1f1b8-21bf-41eb-bd60-08dc85ea01d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXAyT3JyWU0yRy9IUnNHdnFtQk1mVktoSnNHQlRqVHJKdkJrV3VGaGttb29j?=
 =?utf-8?B?NkdKMUNhc2ZwbFhTK201TGRTQ2FMV3dSR0JyZjh3STZBWU54eG5sT2tmL3Vm?=
 =?utf-8?B?OEM5RWlicmtJVGZ6U2NXa0RlZm5GTEx5bGF3T3ljWUVzT2RQVFoyNmhyZm94?=
 =?utf-8?B?NmFBQmE3VzNuRVY1Ykk4dlFvVFFGaWMwMWhFbWZnWWpmZWhTeXZ1SXhSUTJn?=
 =?utf-8?B?T0VSTlg0eTdIdmI2cC9iNnF4SlZiYytvbHRBaFhMa3B0SnB3WXVQeEJtRmUy?=
 =?utf-8?B?Zit6b2ovVGNYNThsREd0ODRBSXFhMHM4SUVCKzdENEhkTlltaWlOd0h0VFhN?=
 =?utf-8?B?ZHRVQU1iSlhkbThINEJIWlRVSmd0TzBHTGdFK0o4dGdzYlg1KzNrclA5TVZ4?=
 =?utf-8?B?WGJGSGFSNm1EZ1diYmRVaVNrNFIzZ242T0ZNaHBpUGYrS1g2YXNLR2JlUXpo?=
 =?utf-8?B?ckhhcTlJRStwN3VTUGI4d0k5OEhjL0xLVm9GS1dXSzArMXdVMWsyZVRwdFJk?=
 =?utf-8?B?VlpZVFozN3pITjVCRENJZzdkUnZFYlFGNEFWS28xQS9qZkxHaUVtSHg1S05N?=
 =?utf-8?B?ckdDTWZXUDdCRU8yK2F0NSt4VzVWUUFMdlhaeXZPR0JHSVNuL1FhTUVyaU8r?=
 =?utf-8?B?RmZhQjhwbUpONDBBY3huMkxWYVp4dHJMYlJUS01TT1lqUlhQM2wxK0NUc1lQ?=
 =?utf-8?B?dnZmbWVENEg2cGVPbUkrY1BCNnczQ3NYS1paZ1lIQm5jbmFJMGRieU9oMThh?=
 =?utf-8?B?KzROZG9WbUNvei9PMEEwK3VrUUxWc2lqUHB0M0dxUkVmRkZCNVR1dWFicUxv?=
 =?utf-8?B?OVd2V1o5eDBudlc5NVIzT0I1SkFEbmlRNldTZWpBTVJYN0pDK2Y2OWRYMHpO?=
 =?utf-8?B?OGdsc0grdm5vem9PR2RSM2g4Q2xubkxweWdMem94QTUwTm0zWlVNZUUwb1k1?=
 =?utf-8?B?VmM1S2JPQ1owcXB0M3pVRGdiNUhpQ2JsSmJjZS95R2pVK1NUVWYySjB2NFQ1?=
 =?utf-8?B?ZnQ0MDZ0Yjg5NEp3RkhNdFRGYnhkVGxvUHNiODdKY0hlVWZwOFpDaHkxUHBs?=
 =?utf-8?B?R0NwdXpxTHFVWjNuc1czNkhYN2F3b2NzenQzVGRaQTZzTm9NOXVkczBUSlhl?=
 =?utf-8?B?STlDckpwM3J6anhxaTZ2c3laa25GYjZzRHhGM056WDA3RXBvM08wRm1oWFlu?=
 =?utf-8?B?ZHdaLytOcTNQci85UGdpQmZQNEFDQ2g4YUZzWWNhZ3h5bUxyQ08xNEE3TjRu?=
 =?utf-8?B?emdiVmk2bHNLUnh2OGJEeWozb2MxTzZRc3BDTHBKdWNINGlnSEVaMWFXZEpn?=
 =?utf-8?B?bldhUTF4T2hKcHZHNERIODdYOWVjMlpkYWQvclZGRmgzdEJYeVdrdUd5a1VE?=
 =?utf-8?B?bFpNTkIxMW16VTNTZ3ZqcHVYallxaDFwUFF5ckRMNTlqTnVjNjk4UHBpWjlR?=
 =?utf-8?B?UDVXVUJTeGpzQk9nNkt2d2VVS20zdDBYN2p1dkwxdlpPZGlvck80bXpkV3BZ?=
 =?utf-8?B?ak81Q0J4Y1BZMDc5ZXRxOU1oNHBoMTVoVlBoZ0lyaXBadVJVa2lTYURkMWxn?=
 =?utf-8?B?TUFjNDJnSmJKVTlON1ZhY2lWampNUC9IL2hCSjhkL08yVGY3eCsvdmxleGd4?=
 =?utf-8?B?RnlpY05WVHdjdzVlWjY4c3lOWnlrTE9Yek9VOGUvQ0Zwcks1eDRFeFBCcEVw?=
 =?utf-8?B?ZW5OVHFuVjJ2eExKV3lFajFNRU5PanBTcXMzYk1wSEtERFlvZ3JGd2p5Tnpt?=
 =?utf-8?Q?JhqIiTggQsFOkcZ0Uw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3RTOUJhdGxEcjNoUlFnajZQUG02bFBoNUcxT2NpOUlhNVk0bFV2aE8wQUto?=
 =?utf-8?B?eno0dEFkU2F4MHNtQSt6Q2NGMTNMUGpPRy8vR2Q2M24veWpwZkZ5R096Z3lG?=
 =?utf-8?B?TnFTekN3Z24vbk9nUXVPRU81LzErcEdUSHhmMHFnYllNR3Z0OUR6RUZtL1Z1?=
 =?utf-8?B?amR3YkE2andCSDY5YW1sZFNqL0h4bjgrQlFxb1ZYbHBhdVFFL245cWFYWHNU?=
 =?utf-8?B?aXRyNUtVbXlBQ0pVeU4wUjZySGlzd0tKa0FGS294TVdMQlpEb1lTZEJtU0xY?=
 =?utf-8?B?UThhckIwbjF3VndmQW5nWE5aRytnZW51UlRhcUtDdWtUOTQxQjhXbHd0YXE2?=
 =?utf-8?B?bzNVUTVZM29HTGxvMmdJcHJSN1QzeHZxajU3ZG9qSW9yT0lEd2MwejhmeXNs?=
 =?utf-8?B?TGg0TlN4ZEphdTVxKzJabnQvS1BTU3Vib2lITnVjUjVabERVNDdrRmtrclEx?=
 =?utf-8?B?VEJWblo2SlZ6dGdLNHh4cmF0dlNSWnpjdmZxVDNxSEdidlFsSk1oMTFIbUdu?=
 =?utf-8?B?L2hMVndnYTdyRFVMc2F1TUN2d294VzhuUWVDemNUYS9naDg1UmtNeTJ0Z09x?=
 =?utf-8?B?dEljV2RVRE9YVVZMbHpYR0ExaW4wZmx1b2xOZmw2cEdzU1doMnFlNmE5Y3V3?=
 =?utf-8?B?a2VwcnpsZk0xWU1nYWJRUkV6L2xrYUFkeTFyYkNLTjNpMWM2MDZFODd6Z0tv?=
 =?utf-8?B?LzNqUktZQy9QL0d1TmJZcXRuRWpETjZ0OW44N3ZvZ01taE5kTk9yUmFvVTFw?=
 =?utf-8?B?TzdmUlJKdmp5QlNUa01SS2ZyWFBFWEYvdXEvbXR6SUpxSThjTHpNVjNQSy9x?=
 =?utf-8?B?K1FZYUVjTnZzUkJmekcwYkRMVjZYM1pURjlSVHdhaHlSR1Vra2pocXpodzBl?=
 =?utf-8?B?UFVhQS9ETnJaOFNjZUEwQWRPTnkyNHhYUWozTkpKNkZHemlUalJySmdyZXpH?=
 =?utf-8?B?Sk1EUmp2akxTZDhRenMvQXRDSW91NzZoQVh5NURzUXlpZ1BhNU1mN0YycGho?=
 =?utf-8?B?RlRseU9TZEIyR2RaK3N5a2hnTWRhRS9xK1hpK2Q1YXlvRlU4dnJmUGN2WnNY?=
 =?utf-8?B?R21qUXZZSVF0OFZTTnByVDRDaVN1OGVmNGZncXVJY2sydHowYjdMNFhncklw?=
 =?utf-8?B?QnJnTk5mZTc5ZVl0YU1jUmx1Q1dXZVZBcHY5R2RNTzBnQ3NVR3JLS0MrazdC?=
 =?utf-8?B?NUJuaXJ3YWl2cGFEZWZWK3Y5SGxBd1hrWHlSbEhJdVdRZW1pU1BxNzJkNlFl?=
 =?utf-8?B?SGtZbjRGNEdSRmdmaW5ldUpNZmYxbHJaK05oRTlaZXZmenB4NHVwYjF0dGRC?=
 =?utf-8?B?N01RakIxRkUzeDdYeml6aHBnYnl6c0wxZC9aUHhEVnZQMWx6WmZqTXlSNktH?=
 =?utf-8?B?RklmNHZRRWFxaHdyMzJKQnY5aDRRY2MxWDljTkRCTCtkOXkxMWt4V21na3Bo?=
 =?utf-8?B?UzM0Rm1KcW84OXVFdy85THh0WDNJWGRlNmQ0RWVaYXJRVkJ6WEJJa1AxMUhm?=
 =?utf-8?B?dldaNnZGQnVZM0tUVkZ2cDYxT2pWMTdoU3ZYblh0dDVGNnFlSWZBVWFhQjMz?=
 =?utf-8?B?N0dzNTFyMVlVQ1UzVzBFd3FyTWRzTy9xNk8rbkw5czdWajlKQXEwcjRpa3k5?=
 =?utf-8?B?U1B4RTcyemN0MFRjVCtFaTNOd3RrTU9zSUJlSnd4QUlWR0JCaDllTHNmd1hl?=
 =?utf-8?B?RUc1QWJBWU9kYlBoVDY2TlgrRzJGc2F2cEgvOEthV01rVzZGUGlJbU84RUJF?=
 =?utf-8?B?b1NURU93d0VzVjliNTlRVTVZWGEveVMzWDNjTGxFd1lGTW93NHpqRFRRbVk5?=
 =?utf-8?B?bk5oMkxkaFpjbjExRDVLK1IyU2ZvTGhVT3NzVUJkaVRWM3JiQjZMb3NVTUJ4?=
 =?utf-8?B?TUQ0QlgzNElsb083MTZZU05mVml4WVNWNFl2NWZsQUtIa2ROZkdhZms5R2x6?=
 =?utf-8?B?Vms3OWY1UWMySkFrdE1sQis5Tm1vTFdySWlqWmpSSk9rbTZZMlhmeDNXNk56?=
 =?utf-8?B?a3Q4NWVvWTF0TGF4R1orR2Z4TWpJUTV6dEtBbnJ4blA3UytQdlJTa2hFNTMz?=
 =?utf-8?B?ZzVvM2hQdWtYZ0ZZQnVYcExNMUtZNlpZZVcwSE9vTnRMeWVhRTUyM2NJMkty?=
 =?utf-8?Q?gDX8h3vYwx79ND5kweGWaEn3q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc1f1b8-21bf-41eb-bd60-08dc85ea01d2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 05:32:08.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EODGEzTAfBt5DskszU3+4p3/1seLFeEv4k0Y+Y26yJ2sT/kXuaHokARpEElJtPPRFy0rhNZycIcQ37pGBihQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244



On 06/06/2024 6:20, Jakub Kicinski wrote:
> On Tue, 4 Jun 2024 00:22:07 +0300 Tariq Toukan wrote:
>> Fixes: 6f5742846053 ("net/mlx5e: RX, Enable skb page recycling through the page_pool")
> 
> Why is this still here?!

It shouldn't, I planned to remove it, but missed it eventually.

> If the bad code path cannot be hit without
> applying patches later in the series, it's not a fix. Let me remove
> this for you when applying 

Yes please. Thanks.

> so y'all don't descend on me for "hating
> vendors" :|

