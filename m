Return-Path: <netdev+bounces-212466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC7CB20BC1
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF00818861BB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C1237186;
	Mon, 11 Aug 2025 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zbfurXIt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A33C19CD13;
	Mon, 11 Aug 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922253; cv=fail; b=uxj15TG55nS4/1pNWxKeTzNKURmXvoLKa72BaQUEx4a/gbhsrIYr0eSkvn8Z/zh7bvVnDvcxAaVVbM5UtpQIsjmLFJkqJ7hS+bgzWUtOaCWVzYaZCRNX0l3mc4fDcBWjFSbowfjBoZ9UscfE9N9HA96au8Fp3UdWl2+YrqFAqPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922253; c=relaxed/simple;
	bh=cN6rWD97b+cwqzrpr2A5IWynufo7lLkpfZ2JlGTX1PA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qMB+WC8ab04LKcNCvFnTz0WkX0ulsLv+7gp04b/5wLW0nyYIKlnezLiVSND+NxHinYUJRHF5aqdsEPodscGDJpQrdmiGa1b95dIquAS0g+u2etogi3F7mTKUJliN6DRxuxPvgxZRTG2zlrkZ/cAJbMIVxWfTg/88Mysl0kJwRSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zbfurXIt; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC+MjVpF0GfGBIKH8zcOXMU5qwebjvuiluXj9g8U/Ty3swjkQ7oKkAEIwBzacFuyxlKBz/mgY8TwMW5vtpBhh/Y9M/GBcBLc7V+Nb0z9hXnWfGgSvTn/zbb3UBLpew4Od0dnyXMoPzrkTIVMGsPIHHAQIimyp6ktndpokidUo2hO8WbCfRodNVXYIQOOXNssQ9yT2n7pPzlNQjO3eUeBwyDaDs51V6e5RF8AYjBcHUxBJmyk4KMJipe1jHnFDYCBhZPXgAjNf2jC0+T0C6ESqlKGojfbKO85c/CWUSGTU55hrLVlq4AQuY8Sl5BzPhURmA2z0yhymcT3hVjwt17Rww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6M3k1X7a1oItEe1LOEtkLrfzeFLF0pWCIU0pMMlH5m0=;
 b=BgaFKpyr7lPhX35g1oNxxQvfzI9AyEYe1ZE248jkeQAiGmvRGtctCWGnXu3fK7e5movI6ae1skXlCnl4Z1wqbLb6O95f2eRT57w8ihE2ei/s5AGRhTzA3k6ncz38LCDRZku0HdqOMONo3b/dSHPlOEDU/KPbjkABVWd2g9KBzvYfq1sAhrAO0o48OmB/u/I0VlRJppkDoCilgdztVZJXVM2sf/tckAk4eN3KBmxCH29VcH3FfxZMAi2r7QlyRnb4oOTs4BmrNx+qy0wCat7nlCbLI3nqAdfd59SDnOebyped8l0K1EpCDrwLjxAuYCMpSn9s2IzGEhn1dtFab0MrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M3k1X7a1oItEe1LOEtkLrfzeFLF0pWCIU0pMMlH5m0=;
 b=zbfurXItWHZRA4g1kpA6YBm9v5TLNHAdu7JbZVWX1AQ/14uYI2jCsG9u3ryyVISDYikKavGYFhiQP3wKkXYYed6olWTD3WGMZV/XPQBT7Yd4dKbp1vQM4Y7o52EFKcp8magnUT0G7Zz1jvoEKaib3oMe6gwLCdCm9s4GgdwXyTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS2PR12MB9688.namprd12.prod.outlook.com (2603:10b6:8:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:24:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:24:08 +0000
Message-ID: <836d06d6-a36f-4ba3-b7c9-ba8687ba2190@amd.com>
Date: Mon, 11 Aug 2025 15:24:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 12/22] sfc: get endpoint decoder
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-13-alejandro.lucero-palau@amd.com>
 <6887a5956dc2d_1196810015@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6887a5956dc2d_1196810015@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS2PR12MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f13e09-2c0e-4250-4347-08ddd8e2bc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFYzRWNkeUVIVVdINDcySlhkc01pQ0RJamxKVUdqR3dad2ZOYzdjZkZVenYr?=
 =?utf-8?B?bDJLR1kxWkRKZTBoSkl2b3RZYmgyREMyNTJXYU5zRGVNVjB6bCtUb0tpS3dn?=
 =?utf-8?B?WkFXWTViMllSQm9tQzkzTFhDS2R1VWI2S3E2TDBCUWRiZEExWkNyMVh3cW5x?=
 =?utf-8?B?RThiQWMvYXpQZTVKRi9CSC9NNWFSQ0k0MC9MK1hBQ1dZdHJiZGtUOXNHeFVH?=
 =?utf-8?B?OHVOaXNMTmhBT25ENndKZGI2bEYrYUEyRERzR0VQRlV1SEFyOExuYkx4ZUR6?=
 =?utf-8?B?anBMWVRxcUdkTGdRTU5OcndrVU1YaVR1U2xlS05JRmtVVmhZY0w4OGk1MXl1?=
 =?utf-8?B?b0lXNjlDL1VUZ2IycnFwNHZHY0J6eW55U1JUK2YrSlJYNHltOU9oMTZzSFl1?=
 =?utf-8?B?STVMcjVOSy8yb3VpN1NKR1FCZlRpSTROMEd0MExVSS81NittaTJwaWVsS1k4?=
 =?utf-8?B?MFovcVR1M3ZWSXoxb2gyZnFVQzR2SlBKbFE1d2NiNkM4RVVIdTlHTUxLL25S?=
 =?utf-8?B?UWFSWVBscWQ0UStLdDc5VXV3djl0dy9hUXM1c3c4N3FyTFNMaDNZTU9lZU5R?=
 =?utf-8?B?ME9HMHZWS29qWUl4WVBSVzgyZ0JZdDlNaXRzOXNvRmV6SlZXeUZVTG9KSTdL?=
 =?utf-8?B?OGh1UmdtUUxxeFRKOEg3dUxscjQ2NzhKRGowNjFqRy9oNVE5SmpBT2ptSHI0?=
 =?utf-8?B?eGNtU0pqRE5GZU12OGpPZlpqVVNCQUo4dmNwcjNPUHU5LzZ6eC9oSWNibzJQ?=
 =?utf-8?B?M0F0cGFwL0V2NFRENzVTbDU5eDRPL2V4c1diemlja1YxWCtpNjNtRjlDc1A0?=
 =?utf-8?B?Ylg4bTlDaXhYMmVscjNzTGFJM0JVMndXaEhhUmdYcGlSTU41bzBRZXIzQzJ2?=
 =?utf-8?B?Z2VzRS93dEdCbjFwbEt2S1RNZUNRckdVWk9zRXFGd2Y3M2JybDRGTmU1bHdG?=
 =?utf-8?B?eVBPMUlGS3g5V0J1cGx4QnhHeDZ5Zk5vYnZZMzdRa0FPTGw5b08xdTJMcmpC?=
 =?utf-8?B?ZCtPSXdOSnhQSDJ5ZzRKeE1UbUw3WllXb2JXVjNTYkJ6SVk3U0VUOUh4cDZK?=
 =?utf-8?B?UjJENjBqVmIwMXN5U3FQU2FPUldqa2d0Yit2MGg1U3k1NDhuMko1blprMGhV?=
 =?utf-8?B?TzVwUXhrVnlOOG5OT0ticzFwU3I4c3V2bGg5TjdES0tsZkI3czZFczU0dkE1?=
 =?utf-8?B?ampxWlgwcUFDVCtIaUcyMzRmRzZrR01SRnB6aVhpd0F2YkxoY3N3U1VDWERN?=
 =?utf-8?B?bmNULys0SXZJOWMvTjBWZDhQZGp1QXpLODFBOVBBRURVMlJHSjZTcFZGK0lq?=
 =?utf-8?B?d1JnbTF0eGNreURNWXFWWHZ0SkJmeFN2YXlMOGtyV1JJM1gwdFlGWUd4OFIz?=
 =?utf-8?B?dkZYaG1SNEZkTW05MjcvWGJkZXRVb3duU2cyeHlpMnluUUNIeHMwaHFRblEy?=
 =?utf-8?B?V09sSWxKekZ4bkwzSmdMeUw5aVZSZCtjK1FSYXhmeWZwZTYwZkExSHNQU0xU?=
 =?utf-8?B?YkpKMDRsckxXZzJNUkhRZDl2eVZLSHkxTngvWHp3VmFmZHludGpXc2ZtQ04v?=
 =?utf-8?B?S29ZbnpVa3JvMGVVYjZuTkJxRE9sY3NHV1ZvWmZSN1d5UlBJMmI0a1FEUk1J?=
 =?utf-8?B?dTdvRDdNS2dkRDBScnVFUDQ5L28zYzAxVURYSlllVEVQTzBtWFlwbm52Uzhl?=
 =?utf-8?B?dnJyT1JlSTNDSjlacHc2QmFqL05PdDVJRm1reG00UHYyNThtYzA4TUIxajlE?=
 =?utf-8?B?d29KdldsYi9INm13eWhGUG5YdVI2NkxTNDN4REIvZG80MytFQ1FFZWhZVDRD?=
 =?utf-8?B?SjlaYmhpT3BXeGN4bFRvQlVSbVNRT0cycUduVFRYN1BjMGNrQTBIdWF6T2lo?=
 =?utf-8?B?R05yYzJxK05DdjBrVjV1MDkzRnJmeXF3MkF1emp2NjVwNmdPaFNqTUhqeVNr?=
 =?utf-8?B?L01SOERTWnpxZStmUFJwMWc3aytvS0p1VGRSc0RUZGVOS3VVbTFqSGpJeHk3?=
 =?utf-8?B?RVBlYTFRWTNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUlGRnJJa3FCR1EwZ0RFbDZGZ0Y0N0F5aDIvSDJPU0g1c3AyNm9Dd3VPeGhB?=
 =?utf-8?B?Mk5jT0x6U1RaTE9Bd1NnWWk0eTFTYjh3ODdaelAxSTR1WnhyV2VPRUtJcWVv?=
 =?utf-8?B?bU5SOEJJaXlOa2ZNUzU2Sks2YVlDbkZnT3ZmeE9pa25ocFlJKzdnc09VdjEv?=
 =?utf-8?B?OXRXWHNFWnlYa3NESis3aVp3a3o1YThhblh1UGx1aFVKekVWRGN1bFRDWDIw?=
 =?utf-8?B?clZXVkhIMGlmdllwOWJiMk9laUJyR0U4NERsZ0VaeU01RnNsaDRuL1R0ckZG?=
 =?utf-8?B?UE1VWlVLWFlmU1Y2ak9yOWR4bno1bitZbk94M085UTRjZGhsQ1VRdHNmdkVJ?=
 =?utf-8?B?NFgxdlBLNTY3QWpxYWZnNWlleTdhNGRoUlBLUWFTUFI1Z0ZsRTBqbFFKM0hq?=
 =?utf-8?B?TXRjeCs0a2ZZaU5SNlBCNjBia0lpSzlGVk9MbXMxQzI1ZnNQQTkxK2NOOUxF?=
 =?utf-8?B?aldJZkxvVTVIOWNTRFE4VmQ3VVl4UWxUUUxrTW5qdG9vK095T3VpdjJwbEtO?=
 =?utf-8?B?MXU5eU1MUFpTdlBYSFoyZ2RtNi9DN0hkaFpCSDhmTVNjMEc4eVF1UHJONHVx?=
 =?utf-8?B?cER0MWRONk1vN3YvMyt2SG9KUjB2SWJzUHJ1OXJZMkpxZjVlemRNaWg1Z1BX?=
 =?utf-8?B?RnA0ay9LMjIwQStvS3JJRkkyK2RKVUxXYTFQdURhZXorbFBoRk1ZMmVJK0xT?=
 =?utf-8?B?dkNjMWF6NEhXblJ5LytPMzR6SDQzOXQ2MWFnSU9ONGgxU205VFU4MzU2Zno1?=
 =?utf-8?B?NzlUaWoxMlJvUXBTZXVQMmVKalJ6RHdudHRLcFZBSVRxV0pjbzhTVTViSU5Y?=
 =?utf-8?B?anpxS25rMWp5RVFtRDB2WFNHV0E1Nmh0SVBnbkN3VExEQ1dtdzQwTFJtalVF?=
 =?utf-8?B?UDlScDd2N1FqRGNZRHNXSVRwL0xpdC9KRzNWS0RCQUdjc0JHalR0NFRuK3V3?=
 =?utf-8?B?M3Vvbzd3SkV4ZmplenR6T1EvV2d0aGdpc0FrdVJtTUVVaVBZeERnb1lIR3dY?=
 =?utf-8?B?SmtMNWw1dExGZk1tWXN0MUFYYnZQa21FTXlEb0FkKzlpcmhJZmNjb2tuR1Ns?=
 =?utf-8?B?OXh2MFJUUGd5ZDBkc0tqeFpXZUVQS2cwMmo0M1huUklPM2dxQkVGbmUyVWZ5?=
 =?utf-8?B?SVZiZ3UrR3J3bndXMGE2MCtqVGU1c2ZQYXRnMC9pNjBkOEpoenRWZVU0dCtV?=
 =?utf-8?B?V3BGZ1RBS01MampHcmU0V1IySVQrbllmUDQ5Z0owSDAxM3JiaE1jY2VZanZY?=
 =?utf-8?B?b0N2SW40ZFVlYWhlc1dYOVc1SHVoVVRsOGFFL05tSmQxRlM5WjlkV0w5K3k4?=
 =?utf-8?B?MHpmTGVTRlJKOHo2aGRac2FHUU0rb3JuZHZNSkRCTllWbXdSWHo0akptMHVF?=
 =?utf-8?B?Sk55VnhpTmszcWUrWEtWM0ZFdGpENVVYYUlQcHRxdkFnQmU2dzIyNmkyVUti?=
 =?utf-8?B?TnI2YkxHL0xvWmZSbzNHWHg3ZmNGU3dlOWNtZTAyZnZJOGVRc0hIeDU3VndX?=
 =?utf-8?B?LytkQ2xvbFhsN2NKTzVNVWFsUk9IKzQzaTZOK2FYN1c5a2hhMTF4bUVuWktq?=
 =?utf-8?B?bmJKVi9oOHgyd0FpYTlmM3VuVHZuSkYzNkU5K0hTZHA5QXExNStBdERnMnpI?=
 =?utf-8?B?OTJNRnk4S01UQXFxWXZPd0Y5SHBFYmtqUGhVVEc3d3dvbmRQRjZHNlU2a0hn?=
 =?utf-8?B?MWNoQ3dCOWZvdGUxY1YxblRNMnMxTUs4RDdBZ3RxSVA1UVNiRllFeWdnMW9Y?=
 =?utf-8?B?SENQcE1sRlpZemhxUWJqYmd1K2ZPdGNxVllJb2g2ZnVQK2haUXhrQTRiR1lj?=
 =?utf-8?B?ZGgrc2dwb2xCZUhvb0hhNGtubnBUdHhwOXdZWEhyMDltR0ZrMDlidEFpTVV1?=
 =?utf-8?B?V3VTM28rNXMrWTg3Q1BXV0YyejhwbUM3cE01YVl4ZktmYzAvcnlmV1pYcEZX?=
 =?utf-8?B?OFhXMHlWSkZ0WWNUZklrZ0hPaVQ4VU9wTkNScjgwUTY0dmJQY2c2Rk1PWFZl?=
 =?utf-8?B?MEtHaTlZVjRoU0lFQTVDSWdIZS91emZ4bWp5VWdMZE0xWkZjWHc5eXMzbkJR?=
 =?utf-8?B?Qis5SnYyTjZqeUFJZEcybTRHRHdGdDg5TVFWNWRNc1BicnFXQlcwV2FBUFJq?=
 =?utf-8?Q?JoIVkZbESyCg6vBH5vLQzUe7K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f13e09-2c0e-4250-4347-08ddd8e2bc04
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:24:08.6814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgRgvQME1fBasDJcHjg1VSV0SDoAClDraRHzaxdhT1shJfXtjARFG4pK8WibE0Om0cAa2WTRRkxAhzsQwV9WFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9688


On 7/28/25 17:30, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for getting DPA (Device Physical Address) to use through an
>> endpoint decoder.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig   |  1 +
>>   drivers/net/ethernet/sfc/efx_cxl.c | 32 +++++++++++++++++++++++++++++-
>>   2 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
>> index 979f2801e2a8..e959d9b4f4ce 100644
>> --- a/drivers/net/ethernet/sfc/Kconfig
>> +++ b/drivers/net/ethernet/sfc/Kconfig
>> @@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
>>   config SFC_CXL
>>   	bool "Solarflare SFC9100-family CXL support"
>>   	depends on SFC && CXL_BUS >= SFC
>> +	depends on CXL_REGION
>>   	default SFC
>>   	help
>>   	  This enables SFC CXL support if the kernel is configuring CXL for
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index e2d52ed49535..c0adfd99cc78 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -22,6 +22,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> +	resource_size_t max_size;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>>   	int rc;
>> @@ -86,13 +87,42 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmd);
>>   	}
>>   
>> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
>> +	if (IS_ERR(cxl->endpoint))
>> +		return PTR_ERR(cxl->endpoint);
> Between Terry's set, the soft reserve set, and now this, it is become
> clearer that the cxl_core needs a centralized solution to the questions
> of:
>
> - Does the platform have CXL and if so might a device ever successfully
>    complete cxl_mem_probe() for a cxl_memdev that it registered?
>
> - When can a driver assume that no cxl_port topology is going to arrive?
>    I.e. when to give up on probe deferral.


Hi Dan,

I think your concern is valid, but I think we are mixing things up, or 
maybe it is just me getting confused, so let me to explain myself.

We have different situations to be aware of:


1) CXL topology not there or nor properly configured yet.

2) accelerator relying on pcie instead of CXL.io

3) potential removal of cxl_mem, cxl_acpi or cxl_port

4) cxl initialization failing due to dynamic modules dependencies

5) CXL errors


I think your patches in the cxl-probe-order branch will hopefully fix 
the last situation.

About 2, and as I have commented in another patch review in this series, 
it is possible to check and to preclude further cxl initialization. This 
is the last concern you have raised, and it is valid but your proposal 
in those patches are not, in my understanding, addressing it, but they 
are still useful for 4.

About 3, the only way to be protected is partially during initialization 
with cxl_acquire, and afer initialization with that callback you do not 
like introduced in patch 18. I think we agreed those modules should not 
be allowed to be removed and it requires work in the cxl core for 
support that as a follow-up work.

Regarding 5, I think Terry's patchset introduces the proper handling for 
this, or at least some initial work which will surely require adjustments.

Then we have the first situation which I admit is the most confusing (at 
least to me). If we can solve the problem of the proper initialization 
based on the probe() calls for those cxl devices to work with, the any 
other explanation for specifically dealing with this situation requires 
further explanation and, I guess, documentation.

AFAIK, the BIOS will perform a good bunch of CXL initialization (BTW, I 
think we should discuss this as well at some point for having same 
expectations about what and how things are done, and also when) then the 
kernel CXL initialization will perform its own bunch based on what the 
BIOS is given. That implies CXL Root ports, downstream/upstream cxl 
ports to be register, switches, ... . If I am not wrong, that depends on 
subsys_initcall level, and therefore earlier than any accelerator driver 
initialization. Am I right assuming once those modules are done the 
kernel cxl topology/infrastructure is ready to deal with an accelerator 
initializing its cxl functionality? If not, what is the problem or 
problems? Is this due to longer than expected hardware initialization by 
the kernel? if so, could not be leave to the BIOS somehow? is this due 
to some asynchronous initialization impossible to avoid or be certain 
of? If so, can we document it?

I understand with CXL could/will come complex topologies where maybe 
initialization by a single host is not possible without synchronizing 
with other hosts or CXL infrastructure. Is this what is all this about?

> It is also clear that a class of CXL accelerator drivers would be
> served by a simple shared routine to autocreate a region.
>
> I am going to take a stab at refactoring the current classmem case into
> a scheme that resolves automatic region assembly at
> devm_cxl_add_memdev() time in a way that can be reused to solve this
> automatic region creation problem.
>

Not sure I follow you here. But in any case, do you consider that is 
necessary for this initial Type2 support?


