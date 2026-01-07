Return-Path: <netdev+bounces-247893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CE1D00485
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 23:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E153016DE1
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 22:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364492D1931;
	Wed,  7 Jan 2026 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XJbojQ1K"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C742C3260
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767823749; cv=fail; b=IgIHtsfNEkse2X0FQO5MIE1bBc7dF4556Ld4jWJJPAvNKm1ZgdfzlUKyPo3l3bq6eSy0xGb8KlS9xlBJtmA/EOX0oQQz42AGnB4rCMEEbj3LEWQPecaX+s/cTZxwt2kg+LvR9cXC2v96xWC2/PJOl89lsMk+rRDO/TXS11dbYvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767823749; c=relaxed/simple;
	bh=Fkcb5BJS9xeUzlbLEelay3vBqDrK29qm/RQAkYK/gRM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SoDBPIfgdf+qc5Mjqy4dH7pizPfFhOEgaeQc4jgC/0CaCJsmvPKt8iLl8nwFeCkveRWCcS/DF+upU1di0N4N30jAFKuMZTzZ3OdggvpDRrQfRnCOlrC7MhywMajN3JV0pefUdnuqL88tsH/5wK1SvMjsqCcd3KEDgsXqPjBzkls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XJbojQ1K; arc=fail smtp.client-ip=52.101.52.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea7eLRC2//AhzIXA+pnBU6SboB4Bza+QBRMXPZi7PhsWxYzZp1KK1gyF3ZWDEvWd1NVLHxnJu64vfAlDY+t1B2nCxdZe1nm4kBzpRD4HL35TaHfk8GAjEVNRzSquw+pikG9sd+A0UueWmg0wnHEoDa6W3K6mPWsqmNmyxkj5jjXa1uSiO5P5k84Akjp0TEonr2ohygdNz+0NuWYHpcZSkkjnNQsCoVgF4JCrVZX9MmTG4/BiVdXDIbJ0zMLL6b5ipACPbQ3L4lAuHyPh3SvDKTR7bXo/I+x2L6i53sgYYCFNN10gEFnw7lUwd9yMnlKaTMzFf6mggJa4x6RGQuqLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NztjAclZ3iA1/D1fXkyMnRc9rEVYgooG0k134V9kX1g=;
 b=Co7eLhyUnUKJHB+T0uALUmcnKevbGGQJluyGWMiTHr2b4jObMReRiuG6i2k7BxAbMxmkEGIeWHuSAxZYbQHzZA9cJofnJfQDHYdKHXGED5ztgeTGun9NU8W95kjHMZPd6X9pK0YGYskl7MtMjX5jdfWdhM6rS9D99KdkEzPZTzUfTZ16tGrTMVNYCKM49aJ39DgLsst8M8HJuEkLYkej9ynkppfV8tg/uHzCf43HVTGFeh7kWDFy34EDgA5v15QlqjQfffRgwY7oi0YOplONKxf+hj+dgQoHzjkr3FTmAj7FGFL+bmfSvS3eEU/pbHmava/ltO5TsCdoDObuxE3w7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NztjAclZ3iA1/D1fXkyMnRc9rEVYgooG0k134V9kX1g=;
 b=XJbojQ1KqbnKALlUuMlJO+uTsNF14s8ke2EKlsY/Js7l6LHAvTFNKXuNlPdP5ONo3HZmloGWkL0NXSNcr7CodWm/vDGGJg1vT4YKVWG4UDPirDKCv0CC1eFDvBm6/SUQP3t6Wvz+YOtzfEO0k9TWzSoNCqlknxUTxTQU4A2ZfPKQBmeogFkcjIq1YdmvkERvnzpT8HdtD7j1vDOCHhGY3ei/aL/+GRUvwdzE/r3+0fSxQwgTjwe5hJZ6hOZk+/S0sOq6gsCmxlkl0YRVAl2/D+kc+OAxYv1mR3ym2tlBCxM7zCBXmZduFD4ULx5WZh89N/JUvwzen/JxJnAG+D3JJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 22:09:03 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 22:09:03 +0000
Message-ID: <17453401-86b8-4fbc-8907-c2cf1faa06ac@nvidia.com>
Date: Wed, 7 Jan 2026 16:09:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 05/12] virtio_net: Query and set flow filter
 caps
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
 andrew+netdev@lunn.ch, edumazet@google.com
References: <20260107170422.407591-1-danielj@nvidia.com>
 <20260107170422.407591-6-danielj@nvidia.com>
 <20260107133747.2ae75f3d@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20260107133747.2ae75f3d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:806:22::20) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: cae5f27c-9605-4228-586c-08de4e395e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3VVaTd3ajYwQUNDWExNKzduVlNBWEczYmJaTkhmRW0vYzhnM005UUtzcUk0?=
 =?utf-8?B?ak5RK2xEcVNxZEZUWWM4YjdjRnpxbFgxZUkyL0s5Z1NrSVlwTEZ6bjJmeXNu?=
 =?utf-8?B?bWtCWU12N1EraXV5Z3pPLzlXWlZFOGVLZndvRVZCM2pVL1Rxejd5NHRWajhu?=
 =?utf-8?B?MWhtVjZ5ZU4rRy9XKytlK014OWx2YXNOZ2JtbTFtaVhpUWpWbENZY0Y2am9S?=
 =?utf-8?B?R0VlT25iQ1FaVjBWNFdXcnBLVGZRbG5FYTYzNkFZVllwS2gybG9LQzE1b2lD?=
 =?utf-8?B?aTNpZHg4M25lVzMwU1doaFRCYU9rcXlmdE9QQkFLL1BNYlN0VWFwZlJPdWxo?=
 =?utf-8?B?M3llanl6WlI2dGlCRTQyK0RMa1AzSE5NVVZ4MlVzbDh5NStiYjJSOGtqU3pR?=
 =?utf-8?B?RzY5THN5ZU5nS3FRdUUwQWJrUkh2VzEwbHB2UzQrTDZyK2FvU3JUNzdrRVk4?=
 =?utf-8?B?UXE1NjVSd2dRZDk4VVJkQ1MyNUMzd0Zib0ZwL0pHajF5dERKQ2xuWjB5VkhC?=
 =?utf-8?B?SExVbnFxNVh2VjdGbGVpdDFUQlcvT0NDenVIYmNiR3hHYmN5cHJ4SDFqWGlO?=
 =?utf-8?B?RzVEYStqdE1tZm9CMnR2TTc1c0RzZk53VDNNbnkrQmNmWktONm53Z3lvRFVa?=
 =?utf-8?B?QzhkTWNRNURsb1dzbEtKWUMySVI0UzZoV1REVDVaZE5Bc3NMNlRRRjF1dzZG?=
 =?utf-8?B?TXVPVGQxM3Jia3psb3NhT2xnb01mODhiYzlCUTBmUTBlc3hXRjdiUzFDb2NQ?=
 =?utf-8?B?TFcvVE1DQ0hrd05hK2JEN3BWMjkydEV0dEQxYmJFNjgycUFNYTBVV1orbmZp?=
 =?utf-8?B?T0x5UUJnY2dSTG96N0JRZEQrM3VvRG9DUzZ4Y1RJZjVBZnFDOEt6QXJOa1RR?=
 =?utf-8?B?Q2xKbDh0VVhjckg0eWFsdC9DU1NCQURiVTZHSzB0UVhHR2FPUll6allTTWp5?=
 =?utf-8?B?b0NJbVRCTmt1OWFxV0hSYTd0cm1wT0ZDOVRoZlhHdlJwYVA0S3dXLzBWdXBv?=
 =?utf-8?B?aXlpZjJYNGNQMzFsdGFHSTVLcE1KcjR4VStyZS9QVHAzcGM0elZSOGpwTExk?=
 =?utf-8?B?RkpwRjFlb3dLUUpEc05ZaHVBUXJwMDhtbnZ6OG84VU91Znd6bEJRUWN3U2tW?=
 =?utf-8?B?dDFobGVQcVhyUTRUaGl1VDhxWVVOenpwZHN2K2RVM2dVKzRHL3l5bnlINUZi?=
 =?utf-8?B?Z1hNUDk0Q1dsaWZyRlAxSll0cDhOS1ExKzZsOGgwT0VGcW1jWmpJWTJTUDhX?=
 =?utf-8?B?ZHFsUmFJTCtQb1NsQWNmVmx0Q2RjbXZhMjVDelg1ZjRuYi9SWDBWT1RsUzY5?=
 =?utf-8?B?aUVPd1NzRGtPdmIvMHhCRGI1T1lFN3ZBTzZhd2pPUjAvV2tkN2RSYzV5VjZn?=
 =?utf-8?B?a1pOd1ppQkdqdTJqdm0za2hRWmV0K1oxcnFkN3ZtS0d6QzM5WWxOcXFzUTJW?=
 =?utf-8?B?S3BvSVZlcTY3dXJ1MFQ3NHo2cy96dTlNL2JyY29HRVJnU2c1VDgyZlJWRzIx?=
 =?utf-8?B?cHh6MHJXdWZvYUszYUNrVS9MUkRjeE1YOUFDM1JVUlQ2aWxZNkhqMDN4djc2?=
 =?utf-8?B?WEMwcDdOb3NKTXJ2eUNqR2JoWnVobC9FdHhIWDVnRkgxSlFtemlSWEdJN1JI?=
 =?utf-8?B?N1hmazg2UTdROGlWbDlMVXpZUHQvbEFzMzVMSS92YTliWHc2dzJkUUlVd1JD?=
 =?utf-8?B?OU5ld3RRQ3hKZlRpdURIaXNibzFUVlI2K2FuUmRaK3NtMXBXSlVmNWhENFdr?=
 =?utf-8?B?ZkU0UGcxVXJBSTNNb1doUG1yNDR4UWE2dDlpNDlnN1k4RmwvWXFQYVpBb3p2?=
 =?utf-8?B?cFVRMkdBTkthRXNHK2lsU25ybGJtV1I0cDA0b0d5Q3gvcXhYQzY1ZVg5TnJT?=
 =?utf-8?B?OE1lRnRlbTdsVW91by9tbnFaSjZ6T0svNURFWXVqQVcrTm13cGpkNzVzN3Fl?=
 =?utf-8?Q?w9tbVMsKdOlLjy5Npg4oaiz+WsHRE9G5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTJTdkxNaGRlbzJnTHJFeWR1NHBKL0N6eDhTRWhRd3c0eVpQb0RoU2ZlQ3p5?=
 =?utf-8?B?a1R0VU55aXhmbGc2QXE4aWJSUEJJS3dDVHhxS25aY1hIcGlNSUtaazR3Y1RX?=
 =?utf-8?B?ZFkzV01PMEduWGUrYzd6VzFWSEdwb1FQb0JhajI2WUZ2Z254dmNGZFVibXVW?=
 =?utf-8?B?c0FsUjdmVER0ZUVIN3NaTnlOTHlqTHFHSXRGTUhLUk1KWTE2QnVaL2JHS2RM?=
 =?utf-8?B?Y01ES2lna0NQVWIrR3JjUjdZNk5oVVFHbWI5aHl1T0ZvQ3FNMzkvUm9zaHJC?=
 =?utf-8?B?bm1vWkdWTk9MVDB2S1NRQzczUnBia2Qwem9mVnpYTkxzbGwyVWFaZDNpYURN?=
 =?utf-8?B?RnlidzVqWG02clFHWElOWmlvYm5KVElmSUtVT3Z5bVNhUm92ZklvSkRrRjNQ?=
 =?utf-8?B?MDNiZzJOV0FlR0dvcmUzRUJQNG1ZcWRTSEFEdHBKaE5RQ1BXdjg5d0F6R3FJ?=
 =?utf-8?B?aTVTcW1Qb2hSa1A3ajNoNytHVk9QU0sxRituRTBZZ09OZXFrcllBbTN5UnZN?=
 =?utf-8?B?UGpHTEE4RE5xNmIwZ3BXNFVZaU14QWptS2Y0Z1JXMytMZFpaaHZ6SHhSUmF2?=
 =?utf-8?B?MWZQUHJzRGQzZTZ0cUo5d0hrTTlmSmNuaTRvc1lWdWNQU2svQ3YrUnRhcXJr?=
 =?utf-8?B?MFovWDBIcWpXb08wTXNpZ202MFlWVGo1RnVGVUI0MDJXdG5wU0xBMXZITmpw?=
 =?utf-8?B?TXR1emVUaXlKL1pvd1g4SWZoK3RJalJzUjU3UmJHSEorY1B0eGpwVEwvSkx0?=
 =?utf-8?B?ODhPTDBpeWFwaVM5SjkzVnh1UWUvVnU1VnFTcHVOQkJDN2JHUnh4RUZneTJq?=
 =?utf-8?B?Y09BdFRCd2l0cWNIOGw0WmdNRHdxQSs4V1NyTnp2STl0Qllsc0JrMjNZT0lw?=
 =?utf-8?B?ZDBjVTJYVUtwMWEwYmhxWFR4R0s5alJVMG50bjFJTG9jbVZKVWVOUzIzWnR4?=
 =?utf-8?B?c05hdDZrZEZuS05FWjVYTytWYVBXYzduQXZKdnBnSkpNMHFLZDJ1Q3JUc0hZ?=
 =?utf-8?B?UnYyck40NHo3cHg2bFZDTk9nTkxNYWZmNFRDM0IzR28vOXFXNGJZcytOdmgx?=
 =?utf-8?B?bGNhZk02ZHgxTG1YcEVIUUpIWnJ3cWNRYUd1MHlqbUtLMmZBL0dGdTdqcjNl?=
 =?utf-8?B?NHRENEY4U3htRHVxLys4Q09GR0hhZm0zNVhQcytqRWs3ZitRa2hMbks2c2tB?=
 =?utf-8?B?NEtVWGlhTTJQLzg1dm54VTF3L2EydTdpZ20vbTFaWEVMK2lDdU1Cbk9Jd2VX?=
 =?utf-8?B?T2lsaiszSWEwdG9rTWttZkpyY2hIZGdlSklOYi9mZkQyTVJRR0M3T1Q2ckUy?=
 =?utf-8?B?cEk5NE1ETVVBWXY1WVpMS3cxQXBiWG9DeDE0eW5JYzM3Y25IU3UvdUJPODdn?=
 =?utf-8?B?Z3Z1S3l5Tnc5dU5LVFA5SEtoYk84R0xuRFpIYnBPOVFZTkhRZHlTWHQ5dFB3?=
 =?utf-8?B?YWpLWkl2eE1yMTBlK0x0RnluMUhNQmNhTUhpeTYxTmhlbFNaTW10OTRuNHd4?=
 =?utf-8?B?bExIRTVoK1R2SURJWFJraWI5amFoS1c2M0o5WC9laVRpY2kvTCtvQnFueFB1?=
 =?utf-8?B?L0ZkbDUrTWxkamtxeVUrYTVEM05lSVpjMFZPZFBFSTFSZTJ5UTJEdGQ2eGl5?=
 =?utf-8?B?REpoY1V0eDdrVklNeGRCL2pFNy9LVm9tYXFoSG9PSld6WnE0cnNuMy9yLzhn?=
 =?utf-8?B?djBxREJ5b0ZxMXVpR1cvcTFGMGE4eVZzUVdxOWk5OS80YjJUWHV4a3VJbnIw?=
 =?utf-8?B?c3VoRFhkQVBaVHAwc2JRZmMrdHNEVERvRjZNUzluenNwbXQyVGk5TThWUUV2?=
 =?utf-8?B?MG8vRUhRdlB3b0J5b0tZZExMQmxocjJkaWl6Z3RGMGZOVFpVdWxwekFwVEZn?=
 =?utf-8?B?M3kzaEMxZVBkVmpyd0kxeFArbnhDUHNiVEY3Qm8wRURDZytIVHBwMDFDYk93?=
 =?utf-8?B?VkFDUE9ST2N2cXpBT3piRXN1OC96Qld5Mjhjc2pwaFlNOE5mTW9CY3Q2RXls?=
 =?utf-8?B?MGlwaEJFQUQ0MFRwQldVTGJ2dXBUS3YxdWsvZFZTT2IxZ3p3bFV3RUgxU1BH?=
 =?utf-8?B?MVcwSGxHdmF4cTVFNjJvb3RKaURqRTA3Q2krVnZITXhHL3dtUnlwUmw3aTFE?=
 =?utf-8?B?MUZyNEdXbUlRMHJTMWt6c3VzRGluSUVEbXRZalBWMXNXSGphUDRpWHZaWWNs?=
 =?utf-8?B?bFppVjByR3VFQ0hidkZWVVhyK2Q3WnhVR1RNSzc5dFp0dUZCQXdDbGRvUkxp?=
 =?utf-8?B?d2ZoM3drT1pzYWw5ZFlhdXFJRHhPa20ybXNvS3ovUHpXTGl2NDYvUUdXNEpI?=
 =?utf-8?B?d3BlR2VFaFBId0NEUVFzc0I2Q0JtUWlJVGdmNGFXeitQdi9JZWJxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae5f27c-9605-4228-586c-08de4e395e4f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 22:09:03.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCFiP0dGKsrlrefhwaq+SJDZs4askVH3Zf6MRt3LVhKbNjAuH81xfIOiTUANfZ09IdLBeh/Zn8xawhLTsgLWAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135

On 1/7/26 3:37 PM, Jakub Kicinski wrote:
> On Wed, 7 Jan 2026 11:04:15 -0600 Daniel Jurgens wrote:
>> +	if (err && err != -EOPNOTSUPP) {
>> +		if (netif_running(vi->dev))
>> +			virtnet_close(vi->dev);
>> +
>> +		/* disable_rx_mmode_work takes the rtnl_lock, so just set the
>> +		 * flag here while holding the lock.
>> +		 *
>> +		 * remove_vq_common resets the device and frees the vqs.
>> +		 */
>> +		vi->rx_mode_work_enabled = false;
>> +		disable_delayed_refill(vi);
>> +		rtnl_unlock();
>> +		remove_vq_common(vi);
>> +		return err;
> 
> disable_delayed_refill() is going away in net 
> 
> https://lore.kernel.org/all/20260106150438.7425-1-minhquangbui99@gmail.com/
> 
> You'll have to wait for that change to propagate to net-next to avoid
> a transient build issue:
> 
> https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-01-07--21-00&pw-n=0&pass=0

Thanks for the heads up. The AI bot flagged another bug with the return
value of virtnet_restore_up so I'll send a v16 once this patch comes in.

