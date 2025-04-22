Return-Path: <netdev+bounces-184502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFEDA95E82
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2228E3A78E5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 06:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120E022A4D6;
	Tue, 22 Apr 2025 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pd4hLRRT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09C9476
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304154; cv=fail; b=qI4h3VZmekcXBSQqtk5ato2e3Zy64iOupmtMRU33DAbC3VH2p76MOQxnlzbF39JpBqVa32Hd3JirE5ZISTtCq3XLNraQVA0fk5cFrKG2Bi3+mNzG2vWjqIEZ4RnE7noEYDEhdXnGUnLSaqsfUAQVxmHcvhRW7gROulBdI6+a33I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304154; c=relaxed/simple;
	bh=ZYOk8XGh2SfBCfRZy8U/AzNAyMPT09oFAWvEhQTYxoY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QI8pkx5mPK4lyplvFvUJo7AHK96g3v2glyNZ9HvH05IqkrcnOANuq6DQ43oHrX0UR+sJ8RERygkEiEt1S81lRrA7PuOEURG54t5T28BHIAkZXSZHUPxYEpPAW0XZhKQx5WcatczR8eov6XLxFefYTB63oaPtOLcDDRUz0BnulNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pd4hLRRT; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/fgIhzzCmwcclKyNoFyb/DxpJdm0iYL5ZOdf2OC//pxdW3QlN2x5Lh5RBkFtVtAQyUUFImReyg3/8sQxO5taYXMvYFfnnETf8ffVpbLKond4VkDKh7E7yZ8FEBErnTskML0mTT+/uhNjmeGlKZxD4xocBrdUbqhS7j7098NPVoC6039OaQng1q/mcIV2uHUvBDpdClp7eaOumoeNrYxlnexs9AznR+C/AbBPjTe+cj3bJYGk72sI/6kWzlVwWwh+melIZZpKiZQuYL/+3RQUHtWOJusNcPmRIoUj/bGBBtuLOBusUK/WnbV31FXFsol9LuRoIbxNqJYDsuqN7xmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZptuBFCoyjyROAmpr/OlpCDGc3AJ2wGHwhSJAPL0Ck=;
 b=n6GBClzIyP0/A8/uVB/jZq5TXHF0pJzqxhu7xgHYCQwZHZheCJgzY+EhvvmRsMQr1f5Q3xdQejh31+zx8MueDeyvv8in444IoShV7Ta9UvsjZoLTLx//tZb44ZjVCG4gIAwTLvO+s68baTdXRjgGvC/xzM81LIx2XurdSD23fS2Zqg2taZa/VyrLjkaW43tk4t/ahXioY8GTtpihjHn/DxdoAztRx1OcGzOxnQhYlXYLtYxF70opgipr73IV76IEULxDtIYhCzeh/ABKsCHkHq6xDvSfX3Fol//0npezGzmNhRvLiYgIB1uMKpphZfbTYswMLAtQZJoqxNTDguYV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZptuBFCoyjyROAmpr/OlpCDGc3AJ2wGHwhSJAPL0Ck=;
 b=Pd4hLRRTb0BSuGvhqExGBO7D2WnfkdY6WKT3EtnCTLZ5IHWRFX5/L91zrlp8nPbGoRF5lOQ+wgel4zllhoHsCYfDewo5ZtxbgNsKatE5zFdLFzgupwOngtZ4c8uCqAE+cBQJpt7aEWTztn2F/oawvivZzURnj8vjyWQvQ3yUO9o1ogqPH60kGmj59nsIRZ2Qym8k+mHTPS3XezbJdeZQdrPuOrc9PxWPWtXv/kWvGrOnTqvLgTCCAO9/bwB16cj5WvIp68PihjpfeeSVgX1610FVRG7T0trTcPvi5gHjdJNCQBNDH7uXYrSHshqKBVrS9na6qCZPCditxqYvhW3qoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BN7PPF28614436A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 06:42:29 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 06:42:29 +0000
Message-ID: <091ec8be-34f6-4324-9e79-d2fbc102fd6b@nvidia.com>
Date: Tue, 22 Apr 2025 09:42:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [?bug] Can't get switchdev mode work on ConnectX-4 Card
To: Qiyu Yan <yanqiyu17@mails.ucas.ac.cn>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <8b96e37c-842b-4afb-9c61-f71674874be5@mails.ucas.ac.cn>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <8b96e37c-842b-4afb-9c61-f71674874be5@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: 96857e53-0c69-4462-2926-08dd8168da30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTF3MWt6c3JROVpPQVNqUVF0RlBLNmExZ0hpTVdoMGZvVENCK1psdDBLWGdt?=
 =?utf-8?B?dUg3bWJFd3o4WHdYSjRTM3F4S2tXd1lXNWFnSTZzbUpNQzZXdmRQMm1teGNu?=
 =?utf-8?B?YkRaOStFeDJMNGRCYjNGdHU1RWJEQXh6OTdmcENyVUJWNXNlZHVoZ3hXbkJH?=
 =?utf-8?B?bGcrR1hCVUFUUlAvM2xVMGZNaGRKbDE2VjNOVDhWNXhhVk03YjFQOUJ0R1lt?=
 =?utf-8?B?Q1JNWWFzVUZ1cXVzeWkwelNvMWFKSzJpbUJvVjRyZUx2STZ2VU5NbjVpRkJI?=
 =?utf-8?B?Q2pjRHY1eDdVUWhqanp0RVpXemozSUx4WHBKU0lsWFJ6MnFxN25pOCtyWHdE?=
 =?utf-8?B?QUMxcTNqS3NYajBpMy9JNnYzcFlDaHZLdEtJaHEyWEZiblNqQ1N6dFlMZE12?=
 =?utf-8?B?Q1RPMHJyeFo4RE9tUXdzb2VER2dScUZWNlIxbWNRRllWV0lUci9yNUxiVXM1?=
 =?utf-8?B?NHpSSEdXd3ByOUJwdDdCbnRSRW9DNUcxMUVwR1JmenpreGdCRXYvK1g3cGRt?=
 =?utf-8?B?andTYnlWSHBISUNaY2xnWVEraVVOUlFMUXdKcG9SOUI5L1VCTnJuaFRGMTd3?=
 =?utf-8?B?c1FRanZNOXZUNU56OTM5K3ZQakcwVHEyZnR4cWtscXVOWXUyeEZnM0I1a0hR?=
 =?utf-8?B?Vmt0aUF3eWkwM0RvRVN6WnVYYUZieTdMNG5pQUozMmp1YS9Ud3FydXlrUmVJ?=
 =?utf-8?B?bVYwaWt1NXBPclI2SjBHZGxVOXJIZ0N4czY4d1Vrb3oyUVVPSHhYbVprT1lM?=
 =?utf-8?B?YUNWSFhUV2lPNUN3VmpxVXF3M2tkbmJvelpPWVF6cWlNejhqSjlQamV3OTBM?=
 =?utf-8?B?WGVHUnVkcUpRRzhBQ09XcUFaTEgvdmtDUFRvWFBZeWRmV2QxY2FMbUx0Yktv?=
 =?utf-8?B?aVhhWXlqY05ZYXBEQjZHYlcxaHFlVThxakc5YURwam81OW5LZ2ZtT3IzZElO?=
 =?utf-8?B?VUFYY1V3RjZTQUFibFg0a3k0MDNnMlloNlJzWE1xTjNZSHVwa3F0SmJmVzFs?=
 =?utf-8?B?NTBKOVIzQUpyMkN2dk5ETmZBRm9NQ2czamtLdWwxWjhDMXVUem5va1RraHlU?=
 =?utf-8?B?UDRKOHJhZ3NUSmpqZG04bjQwdlQyM2oybHhoZjg4TnFyeHhpTWtvVFJGUmZM?=
 =?utf-8?B?ZTdqTlpNbEwrL2h1Z1JLL0tPSHhOVHA0QSszMlJGNGZ4b1pHUitoYW9QVjF1?=
 =?utf-8?B?NE9QRy9sWXNITXdoVFphMEZ1SE5OV2k2WUlGbFhmVGFSYmFnTVJmTVJXRFE2?=
 =?utf-8?B?eVpnTlZMTFYzRnFhRCtXeUNVdVlXMkJzZ25EcXoxeHpSM1U3Uy9GNzFETGV6?=
 =?utf-8?B?ZUJyUXBrN2JOVnFQNk9WMFF2ejJTOGdxSlhaaktoVDhKU2NhR3RhVDIza1Qy?=
 =?utf-8?B?bklYTFY5WWxzWml6VHU3VEFPTmNkYWVvTXRITHcvazlRYytZZE9PSjZMUTlh?=
 =?utf-8?B?NVNXckZQSVlMUzgzT1Q3dnR3T2J2NjVjeUNJOFVZekpvclFlcHpGbnRXOHdD?=
 =?utf-8?B?K3VkZGx3aWxFS0VKcHo3ejZEdnJyb2xQbjN5ekNIa25TZXVhNFFKc0d2S0kz?=
 =?utf-8?B?U2YybFZ3Z3ZUQkJnbHErT2d6Njk5ZkNHcG5ob2JCWWZRb3RVdUVpSnlFYkZx?=
 =?utf-8?B?dTNaS2VWZVJOV2RRcktlL2dITlNRTzU3SnlkclpHbklVM0l3U09UTENtMmJI?=
 =?utf-8?B?WjVpVEczZDBIY0Z4YlR3M1dhWWcyNVdPQVdtOFhIMXVXUjdQS0VLNXpUaVZw?=
 =?utf-8?B?T254bnk5WTF4QjM0SGNDQXd6MHNUaW00QzRSbkwxOVlla2wrWTdJRmlZU1Yw?=
 =?utf-8?B?QWg4RktzR0VMSk42MUFkNDhxMjVVajIvZk1SRUJzK2V0OTRrbjBLV2Qya2JS?=
 =?utf-8?B?dUlyeWdHUW5tVUdFZWZ2YytqQ2oyYXJmOURiUGphMy9Nb01xUVZJbWhKdTZI?=
 =?utf-8?Q?hAvI82xq/gU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmpDUElFUmtiMC9lL3Mxa2RBYWphM2dKRWV0R3N2Q051Yno4M1N0Q0dJV1pj?=
 =?utf-8?B?TzZoWnJpMUZ6SE5vbk15bDN0alNQUURmM2hFVi9OYnV1eUVHQmFQcUF3WEc5?=
 =?utf-8?B?Q0JISUNiOWxZQWJwS3FTL0hhSHl3SlFwYjlURGdsZ3F4emRidXluSytwTDUz?=
 =?utf-8?B?YnFPQjdzTVJLc2RCU0MydEVxT1FrOStHQzc5d2QzYkFuM3VWUmhYRzdiSmJJ?=
 =?utf-8?B?NUFEUkU5TysreHBqV2lGc0d4VkdWZEtZVVNZaG04RTVkL0VwT21GdmxPSThU?=
 =?utf-8?B?WVlFcXUvREVYWHhqQVlGdGlLNkJCK0lmb0M5dVBoTjZ3blpLUitiNXJrZ0Jz?=
 =?utf-8?B?cmZNZ245ejVMckw3aGpYUVVzR1pHN29vUTNRbFQrNmNDTnJiNEJFSWtYb05B?=
 =?utf-8?B?bktSU1hJUHk3YnFrRzlFb3dla2Y4U05UQWMzb0YwZ0hLTE96SlVDcHJ2Q1Zy?=
 =?utf-8?B?am5IZjd0T0xrNWptMTdjb1laK0c1TUplYXNXZjBuczdDNlk4VUE4a1Y4RFc0?=
 =?utf-8?B?RGNtc0c5M2xuSmZtWVlGcHpyVUVPOVA1YXNWYmNXUzVtQmJxbEVFdzhDcE92?=
 =?utf-8?B?Wkk1d0pyNDRXb3hMazc1TXhneVJ4Vmc4d1hrRmd5TFdTdTNaNVBobmZrUW5q?=
 =?utf-8?B?WjJFaHo1WTQ5ei9SanFxeWtTVEZES0JnbEJZc0JDVzRoaWlFRDVmN1NyNWlX?=
 =?utf-8?B?OVpBQVl4VGR6YjcwSHFxNjVJRjYwWnJLMnlrZWpxemc0ZjJ0Q20vSS9BeFFT?=
 =?utf-8?B?R3JSUkFnNXNFeEFieUozMDFDYm83dGhrdFZ2Sm92VzlRUUtGYU5BczlVWjA4?=
 =?utf-8?B?djBxQXY5ZXlqMFlxRllCN2lsQVZmbS9GU2FwaWJmR05zQVJLZzEvSnJZbHVH?=
 =?utf-8?B?L200Zis2RVZCSGMxL2lEWEVyTUR5U1R1Z1dzZ3BicGt3WFNTT2RDSktPU2xE?=
 =?utf-8?B?dWx2T213QTArT1V2ZDBlZ0VvdG1hem1lQ0RNZFpEa2JZdVpnUkNXSndUZVda?=
 =?utf-8?B?dG1mbjNjNzR3VG9YUDkwWWwxYS9OUElDZnVOVnBaREQ5RE1iTHpTVnUzWkFp?=
 =?utf-8?B?dmcyQXdpYUxGdUcreWhHMC9WT0U2UElzenBGYXM5aGk5cFluaGE0U0dVRjNO?=
 =?utf-8?B?VjFPbk1WWXNMOGxIcG1RWDVHTERMSThveUZuWGVudjZ2RlY0VjlrUyt3SnZ2?=
 =?utf-8?B?dVI4NnhsNHFBRnRCY0ZrTlBiTkloRWdMM1VmZFUxTExJaW9lZ0pwSDN5a0Vj?=
 =?utf-8?B?UjZNMGo0OUtXYVRKeFBlNmNCWmFYWkNicHhMUTVTOVJ5UmlUYnZCNWU5VDJi?=
 =?utf-8?B?bnIxTlA2ZDEzb3BiclE1Z3FqQTNacUV0T0s0WTJ5QUo1ZTFraGxsTFlzWi9x?=
 =?utf-8?B?R3NYREVmbHFNMENzVjdtMDlnbDZaRnNPSzVPWG5rOWcrYnZGbEdNS3c1dlRz?=
 =?utf-8?B?VjUxRmU4WSs1azZta1N2K2pjV1FZbmdjM29kVC9kTVM5UkI2KzQ4MHZ2T21X?=
 =?utf-8?B?QVZpZFpBbklWQm03bEpiTko3REdiTFZyb0hIdDBIV3N0K2JWcHcrZHoxS0pH?=
 =?utf-8?B?Y2haL2pvYlUxN3FsSzRIS3RxNlpzZ1hTa1dVMGNESmxENE1KVW1KUW5Xb0ZB?=
 =?utf-8?B?RVVVc1dXSDAxZW9TaStuNkx3VWVlRlZZZG5ObVdzZitYTzhBUlpuK1dQTmJY?=
 =?utf-8?B?di9MaklPQ2ZYV2lJakgvTkNObk1rSVRYaURBTWJkd25FVm1ibk8zTTdzb29w?=
 =?utf-8?B?MklVcE5rWHJObFJYMFlsSno1ZCtPZlVLSmlmU1pRNmZvTFI3TTFvQ3JZTG1a?=
 =?utf-8?B?YloyazNDZ1Q5c1BDbHY1YVhnUXJGVmZCcFQ5QUw3VXB1eUl2WWN6dVh3QVNX?=
 =?utf-8?B?M1RmK2FlYTlZUGh2SC9LVUYrR1pzQ2hKQXBFTmhSRDdST1dyMWZyMHBJMWpi?=
 =?utf-8?B?VXBHSG94SlVMWW81ZHZuN052L25QOWlZWWs2OE90ZUI5OXFNOFE5c0hvdkg2?=
 =?utf-8?B?VWpCeUV2ajYzOFJLaWlVWVNKaTFZcmlTYXB4SnkvNTJ2YVk3ZUx3YWxFTjlC?=
 =?utf-8?B?YWxZbTRLWFBqaktleFlNdXNuOEtLSGpjZ2xrdHFrMithWVYyYWIzZ3lULy9I?=
 =?utf-8?Q?dOHFFThxkmchSo0dwb7p3hWiB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96857e53-0c69-4462-2926-08dd8168da30
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 06:42:29.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPcoWxCCuW4NVWNa3rekyu5DbtJCsX+kXF41iIBWvmf2ci+s3Chkf2DLOdoo+NSsYnBzD25zOZwVqwA9BJbbTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A



On 21/04/2025 12:07, Qiyu Yan wrote:
> Hi,
> 
> I have a ConnectX-4 Lx EN MCX4121A-acat card:
> 
> $ lspci -s c1:00.0
> c1:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]
> $ devlink dev info pci/0000:c1:00.0
> pci/0000:c1:00.0:
>   driver mlx5_core
>   versions:
>       fixed:
>         fw.psid MT_2420110034
>       running:
>         fw.version 14.32.1900
>         fw 14.32.1900
>       stored:
>         fw.version 14.32.1900
>         fw 14.32.1900
> 
> I wanted to put the card to switchdev mode, so I started trying to to the following:
> 
> # enable switchdev mode
> $ sudo devlink dev eswitch set pci/0000:c1:00.0 mode switchdev
> $ sudo devlink dev eswitch show pci/0000:c1:00.0
> pci/0000:c1:00.0: mode switchdev inline-mode link encap-mode basic
> 
> # create 2 VFs
> $ echo 2 | sudo tee /sys/class/net/mlx-p0/device/sriov_numvfs
> 
> # Try add interface to bridges
> $ sudo ip link add vmbr type bridge
> $ sudo ip link set mlx-p0 master vmbr
> Error: mlx5_core: Error checking for existing bridge with same ifindex.
> $ sudo ip link set enp193s0f0r0 master vmbr
> Error: mlx5_core: Error checking for existing bridge with same ifindex.

It’s likely that the issue stems from cx4-lx not supporting metadata
matching, which in turn prevents the driver from enabling bridge
offloads.

Could you please confirm this by checking the output of the following
command?
# devlink dev param show pci/0000:c1:00.0 name esw_port_metadata

A better approach might be to check for metadata matching support
ahead of time and avoid registering for bridge offloads if it's not
supported. This way the driver won't offload the bridge but
it will also won't prevent users from adding the reps to bridge.
Could you try the diff below and let me know if it resolves
the issue for you?

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 0f5d7ea8956f..25a5845e5618 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -523,6 +523,11 @@ void mlx5e_rep_bridge_init(struct mlx5e_priv *priv)
                mdev->priv.eswitch;
        int err;

+       if (!mlx5_esw_bridge_supported(esw)) {
+               esw_debug(mdev, "Bridge offlaods isn't supported\n");
+               return;
+       }
+
        rtnl_lock();
        br_offloads = mlx5_esw_bridge_init(esw);
        rtnl_unlock();
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index 76e35c827da0..37781f9ca884 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -368,9 +368,6 @@ mlx5_esw_bridge_ingress_table_init(struct mlx5_esw_bridge_offloads *br_offloads)
        struct mlx5_eswitch *esw = br_offloads->esw;
        int err;

-       if (!mlx5_eswitch_vport_match_metadata_enabled(esw))
-               return -EOPNOTSUPP;
-
        ingress_ft = mlx5_esw_bridge_table_create(MLX5_ESW_BRIDGE_INGRESS_TABLE_SIZE,
                                                  MLX5_ESW_BRIDGE_LEVEL_INGRESS_TABLE,
                                                  esw);
@@ -1917,6 +1914,14 @@ static void mlx5_esw_bridge_flush(struct mlx5_esw_bridge_offloads *br_offloads)
                  "Cleaning up bridge offloads while still having bridges attached\n");
 }

+bool mlx5_esw_bridge_supported(struct mlx5_eswitch *esw)
+{
+       if (!mlx5_eswitch_vport_match_metadata_enabled(esw))
+               return false;
+
+       return true;
+}
+
 struct mlx5_esw_bridge_offloads *mlx5_esw_bridge_init(struct mlx5_eswitch *esw)
 {
        struct mlx5_esw_bridge_offloads *br_offloads;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
index d6f539161993..f920c1c47f47 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
@@ -93,5 +93,6 @@ int mlx5_esw_bridge_port_mdb_add(struct net_device *dev, u16 vport_num, u16 esw_
 void mlx5_esw_bridge_port_mdb_del(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
                                  const unsigned char *addr, u16 vid,
                                  struct mlx5_esw_bridge_offloads *br_offloads);
+bool mlx5_esw_bridge_supported(struct mlx5_eswitch *esw);

 #endif /* __MLX5_ESW_BRIDGE_H__ */

> 
> when the failure happens, there are messages like this in kmsg:
> 
> mlx5_core 0000:c1:00.0 mlx-p0: entered allmulticast mode
> mlx5_core 0000:c1:00.0 mlx-p0: left allmulticast mode
> mlx5_core 0000:c1:00.0 mlx-p0: failed (err=-22) to set attribute (id=6)
> 
> I am wondering if this is a bug in the current driver or anything above is wrong?
> 
> Some additional information:
> 
> (Fedora stock kernel 6.14.2-300.fc42.x86_64)
> $ uname -a
> Linux epyc-server 6.14.2-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 10 21:50:55 UTC 2025 x86_64 GNU/Linux
> $ rpm -q iproute
> iproute-6.12.0-3.fc42.x86_64
> 
> Best,
> Qiyu
> 
> 


