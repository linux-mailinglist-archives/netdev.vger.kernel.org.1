Return-Path: <netdev+bounces-139534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF59B2F90
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C4DB21D7E
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCCC1DD864;
	Mon, 28 Oct 2024 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mFJLjqp8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6D1DD0EB;
	Mon, 28 Oct 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116826; cv=fail; b=hD4gZXVM70EeJWo1k0gBspmVP0pL9gSETT6pdd08wTBDOvQqO+mW3R346D496LBejdIV6+9ogTgNBHFpF3wLbdl7MkQMrglGmk7R36qSTr40xz/ovWBcEq2up/0kf4Sf0s+P+wr6M/DVHOJIdA2VAiG4cBqLqlljdOFzLICd03c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116826; c=relaxed/simple;
	bh=ZhJR1FP+sss0QMKlCkNJdr5C86PjF5eXJCesZ8tonHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k44C/HxgHlGy09/DkShz4UBoTzj6SFUvDd7X6gHTjGLIdyeQKzReEg5DCerh1lSEVgKLTBOMU1xDLU/80iU6aMH2vQwDbgH8y7UTTSVzE7FIq2yr0BBkjf23pJhVpFwdY4Gu2W+8vSWO3U1sjSCupVpy/1xaCBMrgHEl7rAzzIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mFJLjqp8; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQrSUg6hAsHf84Vm8Kq316shcdLHSlOUG2XoO9TifysJB+befZgiVr5EB6ejliz02mUvE/wa6HoTdH6Ivm/gIBhzWyvGeUIy4Cl/0k/bjKQT1AACpOK2KH1Py0hZBLoU2RcxSY4YTk6xahHbjP+WH7CxauBQBCmphrGw0Le1b36RHFsSfzqbNqyqdj5MA8s3v7/CZF8bs+sfvBoAI2ADV00CInEysP9OaWcwUjc9swIRRGfUw1i8z1lYKArwh4lkaohYx6Kj+lfCYD7iTZSR5GrBKrSCfMdBJamga6vGKr3L2TEbcI/n1IwT1tdL+W1ZH50aFRt4eKQmeB2kBdg42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keJeNY7n4Q+8cUHClzKjK/8YXzpSTXkCUORLgLb5mL0=;
 b=GoHj+DN+X1TzwaRg+4jr+pw0gRPpbdNOkPOjfpfqy9w31hkMVLLE6JPlf0v6XKRDpZPMyiJWp8TrOD41W73/E/ST82pCi6XrDi/e1aHJ+F3HnbIJ2Y48pM2fUbCIlHHP0dZ+IxQehTLKTY9STOF5/ZStTIDFwMaSYi4pQx2jweWKPocRkdfqKaispMBJzlj/gaSNAI9Nn5TgG4AEMjXXE7rwmnhzx5Sr1NGv4xAUfCMuV6vw6JKni0UAj/ESqVOfS+GS0c9K7dH7LBhPYKBTUnKrRJs9Dda3IdkXQWvo5XbNGXoNoIUwGP9kPl1+We4oBF2Vl+BQzQQ9QINXLJzpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keJeNY7n4Q+8cUHClzKjK/8YXzpSTXkCUORLgLb5mL0=;
 b=mFJLjqp8IbSjsth/hYtRbDiVBLM6/4QR4F7tFe9XxNdvdlDzZjnSCBTDTCh8xoMGWOvyptGlXS6uARShMgfQMmbt3XnxSbVlgOAauYxZ40Md1nioNcjBLE+JT9QESrex9TF+l9mPDWmXvlhQZWAtVaan58YFnE1XnSmfi1lzyE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 12:00:21 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 12:00:21 +0000
Message-ID: <dca35949-06fc-d179-c2b3-71ad1a0ecadb@amd.com>
Date: Mon, 28 Oct 2024 12:00:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 03/26] cxl: add capabilities field to cxl_dev_state and
 cxl_port
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-4-alejandro.lucero-palau@amd.com>
 <20241025151402.00002e12@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241025151402.00002e12@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0319.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 5444fb1e-38df-46c8-9a1e-08dcf74818f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjZMNFkybjlFcFBtUjkrRnhCUFdGazVNWlV6VzE5ZTBIdnJCcUppL1RZV1l1?=
 =?utf-8?B?a1V6MG92dGdWME1VOWlTMHN1c1ppNTZTdVlzZWpQd21iK3dVNm43OE5nc1A5?=
 =?utf-8?B?NVNINkNzZGRXYmt0SW5lUDZNSStZVFp2MnhYbzJ2UThWYlNlS2h3T0ZrTjhm?=
 =?utf-8?B?YUVqMWVyRnFobTlCbFFGRGltd01UWUE2RThzOTV1Q2l0NEplenBwcFQxTHFv?=
 =?utf-8?B?RXFkM3VLSWtVRHMvUHZFbXNQaEtSVGtONExiakR6TmNqUzhGSmxMRlp4ektt?=
 =?utf-8?B?aTdRbG1IWmZnbm1ZRWhURzNmcE03N1dJcmMzdUJFQ1J3Q29RQURHK0lKWEdJ?=
 =?utf-8?B?NE1GeFVxMk1VTEpkR1ZhbkZGTytXTXhTeEQrZ3MwdWVzcU1CWnQ0UVdCWFZi?=
 =?utf-8?B?MWFRRkhwTHNHc1l4NVBQeW4rOUg3WlZkd3FoRTVsT2dJVnQxM1pVekxMdXp3?=
 =?utf-8?B?RGhhdEtoWVI1VkJpQ1d3YVBVd0dKZGI5bVlQS2JIT3F6TkdrMWV3aG5mSWd2?=
 =?utf-8?B?am50ZkQrWGVwdEx1c0RSNEVPd250VUVNUUltRGdPVU56bHhSdzN3ZWdhSmVy?=
 =?utf-8?B?Vm14NWN0UnBZQzNZaWlmdmNaVHBtZmtDNUlKQTRqTmlqNTcwMnZ6bU9YTktF?=
 =?utf-8?B?R3o2ck03VUlzYVhYRnBFbE1WcTFRZ0prZEF6L2RDNHFMeUthVFFNS0l5R2d3?=
 =?utf-8?B?S1pTRFB3WjRZL21CL0pXVUpSSkltNHRmMzRKZDE5c1FLMG9yWDMvanlRQXJ3?=
 =?utf-8?B?dGFiSGlNU052ZkFhZWxuSk5CN014Y3kzM2t3enVkRmVZSmRZaWZxM0luZmdQ?=
 =?utf-8?B?NkhyYmVWQXV2b1l1VGU2bmlmQUVTSlU5bmhVN0hGTXdZbU5odG83Z2Z5eC9w?=
 =?utf-8?B?bklHbkxQcG5iYUdPOUl5d2h0cDBhNGNIdm5tY2FBdWpwWVY4TEw1cXRjV3NC?=
 =?utf-8?B?TEN5MWpLa25ZcXVkSjg5TkMvbEpHdFhlU1FBSGxmVlZhbklUVzRSM2Y4UXRw?=
 =?utf-8?B?bG5rWkNZeFBQa2xMOTlkRERZWDltclh4bGV1YUlLYmk4VlhGek4rRy9ybkxJ?=
 =?utf-8?B?WTdkL3ZNQmdqZGo0SnJSZ3Ava3NtSDhpY2pjbVJwa0hZN3Bvam5IMUtDb0NH?=
 =?utf-8?B?dzNacDFVaVFWZ3BZUFdrb1hNU09mc0pjT0RRZ2hWQlhQd3lrY05aekNLYU5H?=
 =?utf-8?B?YWJnZlVheVN3Q1lWKzg5M3FObzBWanU5cjhkaVJrYjl1aS9XYnFzSHZHMTBv?=
 =?utf-8?B?WWN1SHVYMUMvTlNySlFyb29WQ00wSndTdjN2cXY3Q1Q2bGdWb2IvZHBxTWwr?=
 =?utf-8?B?bFk4R2VSTXpjeSt3RmQyR1BPbHZpdncrUlVzTGJETTF6U2t6bXVNMDNJMHo1?=
 =?utf-8?B?NnlwTVJMWGhyYXBjWTNRK2U3RjFmNTBuRXBCTjRtODg1QXNoL2ZYSk9iZm95?=
 =?utf-8?B?SDRqSTBnWng3RUplQ2VtUlNidkllODZycWlsQUlRYzc5Q1ppRHIvRlNEcUVI?=
 =?utf-8?B?alZUbE9YeTByWVhkNTFVQlJvS0F4MExJYW43NldNVEIxNXVwaWhBREtwZmtW?=
 =?utf-8?B?YmJ1cUlaTkRrREVyU2YwQ1FwQ3lQclFRWTRlRUF4RmpzTTJEc0RWOURjTmdr?=
 =?utf-8?B?MWFtK0UxWmpxenFBK2Y1YlB6TWpzVE9XTU90Tkh0cUxKNlRHaGhiamdlaitV?=
 =?utf-8?B?SC9jbkFYQ0ZhNy9FWUNvY2tmVllHT20xcUljNmNMOHRGb1dZcWpFWUI2V0pw?=
 =?utf-8?Q?f0qyI8Y+u2p16LlE3sAE8rlgwJiyBpCJTPBTlic?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFRHazZoRjVJT3NIL2RicXhabCsxYXd3bi95STFBYkhpbDMraHVYMmdkd0gy?=
 =?utf-8?B?TnN5eWhGUkYyZVVsc2d5TzAzOU9BcHdGQXRSUDI4ZVczS29xUEdiVEc3MWNB?=
 =?utf-8?B?UGs5SkdlYnNTUCtDTHlFWU1zR0l4b0d3RFhpcnhLQ1dmcnhrLytsc0JOb01Y?=
 =?utf-8?B?ZmNhR29qV1VUL3pXWWFTNGM4ZjdQZGhVVGRobHpNUUpSUURCa3JQdk9ERGY1?=
 =?utf-8?B?SDhPaGZwNjNreU9CZDBPRENVbGFNMFNVK0RxWEs2UjFNSmtjU2NLTTRVcXl2?=
 =?utf-8?B?SHFPMkh4b0RydXdyUWp1cnh5YzV2VkhUdU1DaFdlSkdvbHJtQjRXVVh5S3pq?=
 =?utf-8?B?TnZMRHFtdmpPdU9jWDhrYkptK0dKZkwzdlRyRGR0aUNaUzNoMWJUMUc5akd3?=
 =?utf-8?B?T1JWeHFhcCtBMys3ajZNaWlIck9UdDFSUWNibW1pUjFSWUEvUzN1M2ZyNFRl?=
 =?utf-8?B?cW9VTUg2VnNpSGlFdjF5OWNoSFc5Sk5ia0hFVGVvZmkzdGdNYmVhWVducExD?=
 =?utf-8?B?TWkzU1lDOVFFZ3o4bFlmcFhRSDB1N3EwUVEvVk1RZEZ1SnVidjNWeitiT0lt?=
 =?utf-8?B?RDBtOVZsUllUdFJpQkZpNGF5UFUwOWRZeElhdms5ZHZWTHlXK1lWMzZJMFg2?=
 =?utf-8?B?bnNRc1lWRGRXTkpiZU8yTnRzaG5YQ2g5ZkVOQ0djOWdOY3VHSkQrSXBnbGNl?=
 =?utf-8?B?WXZDa2c5cG5RREZLWDUzMmZsMUpsS0xudUhQejdCeVJwbko4eFdkT0h0OTk4?=
 =?utf-8?B?S1V3dDZndHJkYjZ6MnRRUEFsb3l6empDZzZCaU1BYlkvRTAvMUZZVnEwRGgw?=
 =?utf-8?B?aWIwT0dxck82eTlMcldtOXlndE1sWHA5VGRXOVBJVUxkcnhyVXY2dncxaHNN?=
 =?utf-8?B?UnJKZm9pMzhscHUydy9LRzM1Zmo2ck1iK3g0K2hWQUhDaFZyY3M0dGFyQkVt?=
 =?utf-8?B?MnRQU05jdVJXWDd1WlJMVmlMWEFmMFVGcm53RitMeTFsdGlJb0dQVjFZU0NO?=
 =?utf-8?B?YVlaNHhLcmxURU43RWwzTHljMjlXUENrcXMxVitZR0wzTm5DR2k4dnVBdDdC?=
 =?utf-8?B?TzA1QnI1TlNSZHRYSkM2T3BBRTNERzExVzBYdWU1MHhGNnpJdlJERENUQkxW?=
 =?utf-8?B?b0JvNDQ1OVBPM0tBS0x5RVpRWUoyTHIyeE5DWW41SDFnNDlKVXo0MExlWjJa?=
 =?utf-8?B?K2Zwekg0VTJ4ZTZObkIrcFg2ZFFpZHB6cEpOMHUxb0JHVXJHcmFtRU8vMVN1?=
 =?utf-8?B?WEwzMkt6Zk5heWYvbnk3YU5iUHNrVmR5aU16MlpweDJPYjBnRWgzeHJOKzlI?=
 =?utf-8?B?ek1qWjZVSW5nOWExenRxVU9SamFnSDlkaklieUNzVGVqMURCQnRNaW9ta0RZ?=
 =?utf-8?B?bkxWdmVVeW1EeVVGODM5L1pQVk5kZ05QaVBRMU05RmtWS2hWeXVLaWtnUnJh?=
 =?utf-8?B?RzUxNDFHV1c1blBpNjhFdnkxSjdINHRWR25aalkxcktvUE9mclZNOEpMMjhY?=
 =?utf-8?B?S3pwM29HbFhZRS9DWDBUMFp3RmhyVlF2M2dIZEFHRGt5eFlVcHVBMDk1SVVV?=
 =?utf-8?B?eFBRTFY2MERaMzg1SVR3bEtTYjRCUjMvU3NOR3c5QnZjN3lMRm1EV011amRO?=
 =?utf-8?B?WTB1Z3VHcnRUUkhySUdSdGRjR0R3Vk9jbTJJY3hqY01xU0ZPSlZ5OGUvVTNx?=
 =?utf-8?B?TFdlb3ZtQVBEQTJienZ0YStWNU9kNDU4YUxNTkpROHhzWDk2VEV3NjRNN080?=
 =?utf-8?B?NUNERDNjaWVuV1N2Sk95ODBJcXZBMWRCNmNuYmUvV0dRY0N6S2ZaMjhzS0xD?=
 =?utf-8?B?RVg1TndlY005WnZ6MVllUlUrRkRtT05tMnVIdU9TcWQzNXIzZHFWMjZIa3dQ?=
 =?utf-8?B?WHVFeDNCencxWEErblZmN3JlUEhjTFFRM0dNUiszN3NCeEJjcG0xUU9NWWQ1?=
 =?utf-8?B?ZWQ5b3dVT0hGUUVYZHYrdGV2WlkvZi9RVThpR2hOV3o3d1J3YzdWYVlLRjdx?=
 =?utf-8?B?dFByZlFBMTEyZVh6V1hJMVB6NWY3aVBFc1p1WjVsRnZSejducFF1Wm42bEFT?=
 =?utf-8?B?ZGh1bDAxUlo0bTd3TnBTRFpTTFg2aWg2OVZLZS9icVA5a3A2T0wzWWsyTjdm?=
 =?utf-8?Q?IzK8peNnXG1F8NkyJXjOh4btz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5444fb1e-38df-46c8-9a1e-08dcf74818f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 12:00:21.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyDW6kTr4Yu8Wquh/Os7ApAI7xyEOpOpdiskCWerD89KaDqA1u8BoFLl6sQaRYQF3CJvTUP9s8MkLw8WaUkNdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449


On 10/25/24 15:14, Jonathan Cameron wrote:
> On Thu, 17 Oct 2024 17:52:02 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type2 devices have some Type3 functionalities as optional like an mbox
>> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
>> implements.
>>
>> Add a new field to cxl_dev_state for keeping device capabilities as
>> discovered during initialization. Add same field to cxl_port as registers
>> discovery is also used during port initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Just a trivial wrong spec reference.
>
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index c06ca750168f..4a4f75a86018 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -12,6 +12,37 @@ enum cxl_resource {
>>   	CXL_RES_PMEM,
>>   };
>>   
>> +/* Capabilities as defined for:
>> + *
>> + *	Component Registers (Table 8-22 CXL 3.0 specification)
>> + *	Device Registers (8.2.8.2.1 CXL 3.0 specification)
>> + */
>> +
>> +enum cxl_dev_cap {
>> +	/* capabilities from Component Registers */
>> +	CXL_DEV_CAP_RAS,
>> +	CXL_DEV_CAP_SEC,
>> +	CXL_DEV_CAP_LINK,
>> +	CXL_DEV_CAP_HDM,
>> +	CXL_DEV_CAP_SEC_EXT,
>> +	CXL_DEV_CAP_IDE,
>> +	CXL_DEV_CAP_SNOOP_FILTER,
>> +	CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
>> +	CXL_DEV_CAP_CACHEMEM_EXT,
>> +	CXL_DEV_CAP_BI_ROUTE_TABLE,
>> +	CXL_DEV_CAP_BI_DECODER,
>> +	CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
>> +	CXL_DEV_CAP_CACHEID_DECODER,
>> +	CXL_DEV_CAP_HDM_EXT,
>> +	CXL_DEV_CAP_METADATA_EXT,
> This is the 3.1 version of the table as metadata cap wasn't
> added until then.  I'd just update the reference.
>

Right. I'll do it.


>> +	/* capabilities from Device Registers */
>> +	CXL_DEV_CAP_DEV_STATUS,
>> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
>> +	CXL_DEV_CAP_MAILBOX_SECONDARY,
>> +	CXL_DEV_CAP_MEMDEV,
>> +	CXL_MAX_CAPS,
> I'd drop that trailing comma. Don't want anything to be accidentally added after this.


Sure.

Thanks!


>> +};
>> +
>>   struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>   
>>   void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);

