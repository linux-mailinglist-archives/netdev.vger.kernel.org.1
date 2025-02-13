Return-Path: <netdev+bounces-166062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17EA343B1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91731893A76
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6939B227E88;
	Thu, 13 Feb 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KKFwHl0n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F163202C3A
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457932; cv=fail; b=PS7kVrJvah0+q1tMM/siPUbq+a4xMGfCZ+zsPTgNV5AHdX8O6nrJRex33BNy0Fbr2jWxdHa/TYKk8AJHsZ+saDJOx9+sIieDzlVI/edVR7xn39L4pWKnZYtvkcTLL/4LyQ+OPIXyBrDv5jZ4K0yklY4tIGoImzOjUA7uL+dXOcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457932; c=relaxed/simple;
	bh=3KV+8xMLG3AbAy2jPWvQVqhZQWEHaNtB19w5C350zJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I7eS4jtWsi8hb3mIMXXonwZ2hiGX2eoHCo0mC9H4b0d90FQDbI1OnqUS20S8luWyC7gbB9ONXcBSUWShJHUa81zxo5eNrdRXB03IyFy/FHRUpqdpgayFxIlxbsAp1M4LXeXAQ+8w7px1KZxBRmmcmYS7p3uEwXNnvhuz2uux5UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KKFwHl0n; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQ1NJ2AIULtAnngk2vWTTfqwBud6WOr4j9dvA89A5ZmCIi1M+npy2f2dWvtUDJmRGCh5qskF9ZDk8SbKbGr4Yr321JJM+IEK9DVVfz9l2TupXgiEVLkFv8MkEsA0ohXpkzNs3viVMWkw+Ny4USDLtGu7qaHgQ5vUECsak6SVsp/LBX2E5EjlhAAljgnDWlAKohd/3B2iStOFJcRYDeo6edn1RDoreGgkXBSQEqZQXIhkHS0Ef1TwFnqh5603x0+dWDTFCDThabmZi5F2/g/zmbBCuCY8utSijjXm3+suankQWdRM1EDcTMRW3FgwPedbRWu9QSyBPLu4YACMd6wk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpP1zLWxZiHTirdkpzbGqkOGKdjvo+4VFWhBpp6AYZw=;
 b=MlpkU9HlmDwYB9O2pmNUTmZw6x21LkAx+QPh47sTFYtvMZmBKF7dfrW3Y5WIN1SBJPdQ7NO9C3XctWn309C67F9ZCPagvLJUoAOpZBPr104qznb1nCA2h3HBAe2mXBDbpmpjPP/b5Tvlr/qPBKHkqNNSjsv/gEAquRQIaOSklIVbsqe9LHloweJTBEl5rJr997Liq54ZIkzCJ2tI4MgQhaf8XC6cBhld8/cH4kmRWkWFen0So2qq1130rPn39Dv0XHpVYbTwAoKPIAcX5bO4uAtIiqlKTrhvp6H6n4pAqzFWRsO2JpUMOZVRLcWgPztHsX3YkJzMdeVU0MUKRp66Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpP1zLWxZiHTirdkpzbGqkOGKdjvo+4VFWhBpp6AYZw=;
 b=KKFwHl0n+H3/XZBdJ37VeUgPcyDay38pLst5oAb7PLOC4P+ekAx3rX0K0ashtLYiJTN0ODEQRqzc6Fs3X/t3xGI2YS8Bp2jJrIEgWxSiPxfTMg7IOz+QSkuOQCNAiQnajZquUjiOIK6oFPhTqH6RMvjZuaV2PKbrhKF/nWgY+57+Yu8N7iV1gLnXfrRHe1qK28Tkt/f3aNnoDifljEHPj9/5NseosMyslf6KqfL6TOdBfXZWPKY9GXm79juxOGt9UcRAxTs6hf+sawJ2FTXWidUTrV1407RrJmKxU0o9oebLcABF4aF8jvEfYNbupj/v4fqivhblGQHufvcRe2wi9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 14:45:20 +0000
Received: from CY5PR12MB6322.namprd12.prod.outlook.com
 ([fe80::76a1:4b0d:132:1f8e]) by CY5PR12MB6322.namprd12.prod.outlook.com
 ([fe80::76a1:4b0d:132:1f8e%4]) with mapi id 15.20.8422.012; Thu, 13 Feb 2025
 14:45:20 +0000
Message-ID: <83806014-4e57-4974-b188-14c87a4cef8f@nvidia.com>
Date: Thu, 13 Feb 2025 16:45:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] tcp: try to send bigger TSO packets
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kevin Yang <yyd@google.com>, eric.dumazet@gmail.com,
 Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20240418214600.1291486-1-edumazet@google.com>
 <20240418214600.1291486-4-edumazet@google.com>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <20240418214600.1291486-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To CY5PR12MB6322.namprd12.prod.outlook.com
 (2603:10b6:930:21::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6322:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: d78f2980-c108-422f-350b-08dd4c3d09fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2VPWkNPRFgzMWFVQk5lOVE4UFZpK2sxNnNsb1JVcW5PZDdDQlFiMjJQdFYy?=
 =?utf-8?B?cXpPbWZBMnNFbEtWdW9jak8rcXVVRjljSnpTUkJGMnZNT2RvTWtjTFdnK0Fw?=
 =?utf-8?B?d25heUVjRGVSZDVxLzlxWHJFT2dWQnFVdTRQdmxGeElDT1F3d2ZJSzNMMWJ4?=
 =?utf-8?B?T1lIdW4zaUYxRFZTTlIwL0dxWVhNRkRaSm1FemxIcG54eFloREJucmhHMSsw?=
 =?utf-8?B?ekh1ZXhHSUdnYjRPaTJpb2hLR1BxQi8rT2FjTnBwaUQ3WTRTZlM1b2xMZTVq?=
 =?utf-8?B?VTBFZklBWXpLRHRjeG9mUXZXR20yN2dlcGdLZmJpV09SY3hkTFlRUWdxQ3d5?=
 =?utf-8?B?aGRKQk9GSTk4K081VXpNa0o1OFFET1NLRS9ZeGs3K3NqNzNjNHlwY3Vmck9Z?=
 =?utf-8?B?Y3liR0RJOVZUQlRNMlFPQisyNUNzK2pKc25vQXAxQUJ3TDVVeDJQcndNZHo0?=
 =?utf-8?B?d2tjSHd6MjBVcmUrOEQ0VEZjUlJoeDMrYVcxekl4cGRJeFg5ZUJSU2c0RzlO?=
 =?utf-8?B?QUx6REtLUjhrZmpVQkpmUlAvSjdwQTJIbHcrNjdFckQ0bGhpdEFudVREODBY?=
 =?utf-8?B?MUNKdjV3Q21hb2FZMHFZS0l3VjVZYTM3eFRUaFN2MmxwN1VFTFh0WGxkVFg2?=
 =?utf-8?B?WjdwU0VtVU1YMTQybmVnVFFUUkNwYWQrTk45YXlaS1pyK21vYmc2alJwZjBx?=
 =?utf-8?B?MWY1akN6eWN4QW5PWmFTR3gxZUR2Ly9uRVB2VU1EMGpHTU9Oa0ZDN3VBdTdr?=
 =?utf-8?B?T2hpV1NEWjYwR2tsL1kxcWNpUVNZbHJtdWRraUU4REdBNFpxMHQ1STdUdDNl?=
 =?utf-8?B?cmgyOTR2WkwyODRXMnJGdVJuL3JrN1ZCL3V6Tm9jYzJkNHF4RzZHamdjR2Nn?=
 =?utf-8?B?aEVBOXo4N0JFVlAwUTYySXZwd0lsZVFJLy81all0cHlIakFBMklReGNxR0Yv?=
 =?utf-8?B?U1ZNd2F5RThjR3lMdG9wY1V5VktKMVdWK0d4bGVMY0hpQnFQQmFKTllDUzhU?=
 =?utf-8?B?QjBWYmFsYzVsZkVvVER1eDY5bHVmNXMwRVNuaE5iZjYxcDZzMWx2bU1keC9l?=
 =?utf-8?B?L3dlWmo0TklHN1Y4VXBweFhGS1VIQmF5UVVPWkdaa0h5ZVVCRm9iRTlOcUxF?=
 =?utf-8?B?RGZWclpEekJYVHErWlppeDFLUmdPYjVsLzNhUzE3MWk3eWRqdUt1d3JhVi9G?=
 =?utf-8?B?L2pZaEdSaklKdm51YWQrTDdoMkJvOU02YW1Ta2JNTDRGbDVYVFJZVCtScUZM?=
 =?utf-8?B?dFBrejI1T1IwTDFkQzhrNTZGdmFJZGVWMEI4Zm5CS1c1YWlQbkVZeWtQZGJl?=
 =?utf-8?B?dVJucVdFRDNkNjBWNjVROXRueFZhdWZpNXNqaEN3MXRzUURZclJNWUNSMk9H?=
 =?utf-8?B?MDNDM29IbVhFMm5JcnBhZ0l6aTZmaUhsSzB5ZlhNajVwRTJZdFFIMXAyQm1t?=
 =?utf-8?B?UDErQ0Zwd3F0N1o1L1U0T3IrWHZyekNraHlob1NQWng0M2xvejQyMkswc0lr?=
 =?utf-8?B?Yk42MUZOOHVaQkVIOEN2OEdwM0NObFBxenJQejNiRllNSDlPdmJVS01jaU9p?=
 =?utf-8?B?Z0ZNSUNzVUlTR2E4Z1RqUjlFbGdmOEFOYllyMVNTZU5HdFJxRGZpenp0NjFu?=
 =?utf-8?B?NFRqdFArSThXMjFHQmdYSTRCenMvaXluQzlrSTJmUlBmZnZORjJ5elE1cERq?=
 =?utf-8?B?OU1EclpONmJaL01rNzRlbEd6Si9WWkVsYUh1U3o0OWFNYUxFWCtxUGRLaEdB?=
 =?utf-8?B?T0tSVkRqdkJqem9kOGJVK2RQK1VYcVR5OWJ6OEZDY1BUOGxHSjI3STNxdmxI?=
 =?utf-8?B?N2hRb21uV2xXc3BVMTlpOG5ucTRsSFhGRnRESUphZ2pxMnB5UmxjS0sxenpy?=
 =?utf-8?Q?riFW+K6ZN60Ew?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?My9wUklUQWkzTnFtWUhMVjB1bE5sdS9jcUVMNlRXRmtkTHplcno2NVhuUHBE?=
 =?utf-8?B?a0lIZ0t5Unl2WVk4clp3NWlOM3Y0ME1LNlhDMUtScWlIVTVwUzlZdm1ab3Fl?=
 =?utf-8?B?K05wcU9lWEJGZDMvR2YwRG9UdTh1UVFkZks5Nit5c1E5OXl0S3dzZHZERWY5?=
 =?utf-8?B?M0xXQjh4T0FvMkQ1UjFqZFBKeHcyQ1F5UTJmc3FjV3dCVXluT01BcTdJVkR0?=
 =?utf-8?B?L21pRk9xSzJoM0ZjYXgySmlhc3FSTUNzVGdJeFRCczU1UXJxMlFNbmExVUdC?=
 =?utf-8?B?cllad2Z3L2MvOTh2YTdPNWxTRlNBdzB3cHQxd3ErZzdZblBnM3haWmJjbTQ5?=
 =?utf-8?B?c0syRW9iSWdtSCs2TDk1UlMrL1BPd3pVZWc4TGNSRGdhbXhwZExHZms1QkEr?=
 =?utf-8?B?L1BVeElqQzdvNERtOWI5RXhVSWFFNGczSHZ3MGxNSXBIZVZlWWtQVlNWSkQ3?=
 =?utf-8?B?eng1SGprTkxwcncwamRWMjlNUGkyZXF1UVhQOGxpeDdDWUNKR2lrUnNJbUV3?=
 =?utf-8?B?YVRMaUZSNUZPRFN2MW5NcVpad0NkSE4vVXhMT2RxODhqSVhLNG9CUjlDR1lX?=
 =?utf-8?B?TVhwcGJyRUpYNnE3L29leTg2M2E4elVHdnlLSVhtODBwQ3RaRHd5czUyN1Z0?=
 =?utf-8?B?Kyt5ZXA5amkrRUZGQkF4NU5Pa0Y3RVdweVV4UkJ3NlBxU0V3NEU5SnFoVmZY?=
 =?utf-8?B?MzF5aWhCVGFWQkMvb2pEN2xFWHhMektzbzFUV3Y3WURaTlNzVWFoRk5XWGxM?=
 =?utf-8?B?Z0IzSWpGUi9XWEtXYTVkcTh2QjM1aDBsbDZ4WThVbEJBSlc0c1FTLzhyMFRs?=
 =?utf-8?B?cHdZVlpZTStpWGxxTU92Nkt5Q3dXSFNyVlJFdXhpN3lqL1A3Tng0aG1FdXVH?=
 =?utf-8?B?ejRQVWZXOTBsRUphakVTRzRJMHA2Z2F3T09VSTVpSlB6Y3BTYk11MmpkY1pZ?=
 =?utf-8?B?THlPTEl5UDRlZU4rSGI5eEVIOERjeEN0bGVjVndvbmdUUDhHUURLMTlJSGdW?=
 =?utf-8?B?QlNaVTVMc2VwUzgrMUZnSjVNenpQT3k5OTJPcUZkVWFVdFAwVXkxY3VaZHFt?=
 =?utf-8?B?MlFvdWVhc1pMUkNLSXdYckt0eEVpWUVsdndNUlJndjhhZkphVHB5SWZGakZp?=
 =?utf-8?B?WkxKNnZtaW44Um5IdmNwaVBrWXFSVlV0WFNxL1lYRU5SMDN6NTdFYnkrNlRj?=
 =?utf-8?B?UEVUL3Y3UjhmUkE2azBVUzQ0VHZ5UEI0L3hqU3pVWmQ3MVIybGN0emM4clRv?=
 =?utf-8?B?R3haRlNQbEtXQlR3R21EQjlHUXpoUlJ6b1dKQ1h3SlVTeVAzaTYyS2Y4S2hp?=
 =?utf-8?B?NFpkdXErQ1oxTU9qSHRFcVN4QWk4cDVvQ3h0elpzTitSZENxb25OZzRiSlA4?=
 =?utf-8?B?VUR2SlVzWjJlNnpBS1AzbytOMStycWYzQi9xS1A3d252VzNNT1Y2SDcwUzRL?=
 =?utf-8?B?b0w3VFg4UGFjdnhiUWpEZVU2TWpON1FtTXRQK0xUQVcvRUV6SThudzRqMnJ3?=
 =?utf-8?B?bVk0L0VZc2tVRElDQS9uVE5ITTR2aGlqeFlLb20yUlowTjhCTzFJU1RaQXJw?=
 =?utf-8?B?WlBxSjk5dVo3VE44d0x2ZFByTzVxTysreU5DN1phcEM1cFozMXc2R0lkR1px?=
 =?utf-8?B?d08zN2VybTU5ZEFlaWtBZW9YL2R1VDZTdkJzNzl2UjZGeXlFY0lJZUQ2bTg0?=
 =?utf-8?B?cDRaZ3dabHVrSHhlYWZrclN2NS9qbkM0TGE0dGpZaDQrQkVRWUVjK2NFdnVm?=
 =?utf-8?B?WmVtUlBKOG1kS3R6MlRtbEZldHFuaTFjNnVxTmN5T0o3NVhIZk8vT0p1UW81?=
 =?utf-8?B?dWZHUzBqMTdWS0k3a3dnV1gxWW5QUWIrZ3ZlRTA3ZUxwYXErR2hMajN0Y0p3?=
 =?utf-8?B?cWNMV2NTRDAvNy92QTRoQ1lZRmFpelZBamJiVkF4RFlrRkdtVXN4ZzZSSEQ5?=
 =?utf-8?B?cThjMUZITEx1a2N2ck9CMEY4aG9XanNPWUVTVjlFc1VTVHVJbGdkK01hMDVl?=
 =?utf-8?B?TThxcnlsWEFIR2tCTUpEVWNBSTAyUGRNMWszNG5DbG5xallicU5LTVVqM2Yy?=
 =?utf-8?B?ZUMwVkJ5QVdxVEEwZ1FYZitIZ3F2eFpKa2JxTFVONmhNNU00b3U3cjJtbjZr?=
 =?utf-8?Q?gXIolyA6t3KROUINrzyO5wZgd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78f2980-c108-422f-350b-08dd4c3d09fe
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 14:45:20.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: One95K/F61QlpQEHbXxGA6hBD/THu+G62vmerjA2Kmuqo3cd9yzItT2q/o4P7Mdaa6nmj5KiYOEq0ppkklR9jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094

Hello,

I'm troubleshooting an issue and would appreciate your input.

The problem occurs when the SYNPROXY extension is configured with
iptables on the server side, and the rmem_max value is set to 512MB on
the same server. The combination of these two settings results in a
significant performance drop - specifically, it reduces the iperf3
bitrate from approximately 30 Gbps to a few Gbps (around 5).

Here are some key points from my investigation:
• When either of these configurations is applied independently, there is
no noticeable impact on performance. The issue only arises when they are
used together.
• The issue persists even when TSO, GSO, and GRO are disabled on both sides.
• The issue persists also with different congestion control algorithms.
• In the pcap, I observe that the server's window size remains small (it
only increases up to 9728 bytes, compared to around 64KB in normal traffic).
• In the tcp_select_window() function, I noticed that increasing the
rmem_max value causes tp->rx_opt.rcv_wscale to become larger (14 instead
of the default value of 7). This, in turn, reduces the window size
returned from the function because it gets shifted by
tp->rx_opt.rcv_wscale. Additionally, sk->sk_rcvbuf stays stuck at its
initial value (tcp_rmem[1]), whereas with normal traffic, it grows
throughout the test. Similarly, sk->sk_backlog.len and sk->sk_rmem_alloc
do not increase and remain at 0 for most of the traffic.
• It appears that there may be an issue with the server’s ability to
receive the skbs, which could explain why sk->sk_rmem_alloc doesn’t grow.
• Based on the iptables counters, there doesn’t seem to be an issue with
the SYNPROXY processing more packets than expected.

Additionally, with a kernel version containing the commit below, the
traffic performance worsens even further, dropping to 95 Kbps. As
observed in the pcap, the server's window size remains at 512 bytes
until it sends a RST. Moreover, from a certain point there's a 4-ms
delay in the server ACK that persists until the RST. No retransmission
is observed.
One indicator of the issue is that the TSO counters don't increment and
remain at 0, which is how we initially identified the problem.
I'm still not sure what might be the connection between the described
issue to this commit.


I would appreciate any insights you might have on this issue, as well as
suggestions for further investigation.

Steps to reproduce:

# server:
ifconfig eth2 1.1.1.1

sysctl -w net.netfilter.nf_conntrack_tcp_loose=0
iptables -t raw -I PREROUTING -i eth2 -w 2 -p tcp -m tcp --syn -j CT
--notrack
iptables -A INPUT -i eth2 -w 2 -p tcp -m tcp -m state --state
INVALID,UNTRACKED -j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 1460

echo '536870912' > /proc/sys/net/core/rmem_max

iperf3 -B 1.1.1.1 -s

# client:
ifconfig eth2 1.1.1.2

iperf3 -B 1.1.1.2 -c 1.1.1.1


If needed, I will send the pcaps.

Thank you,
Shahar Shitrit

On 19/04/2024 0:46, Eric Dumazet wrote:
> While investigating TCP performance, I found that TCP would
> sometimes send big skbs followed by a single MSS skb,
> in a 'locked' pattern.
> 
> For instance, BIG TCP is enabled, MSS is set to have 4096 bytes
> of payload per segment. gso_max_size is set to 181000.
> 
> This means that an optimal TCP packet size should contain
> 44 * 4096 = 180224 bytes of payload,
> 
> However, I was seeing packets sizes interleaved in this pattern:
> 
> 172032, 8192, 172032, 8192, 172032, 8192, <repeat>
> 
> tcp_tso_should_defer() heuristic is defeated, because after a split of
> a packet in write queue for whatever reason (this might be a too small
> CWND or a small enough pacing_rate),
> the leftover packet in the queue is smaller than the optimal size.
> 
> It is time to try to make 'leftover packets' bigger so that
> tcp_tso_should_defer() can give its full potential.
> 
> After this patch, we can see the following output:
> 
> 14:13:34.009273 IP6 sender > receiver: Flags [P.], seq 4048380:4098360, ack 1, win 256, options [nop,nop,TS val 3425678144 ecr 1561784500], length 49980
> 14:13:34.010272 IP6 sender > receiver: Flags [P.], seq 4098360:4148340, ack 1, win 256, options [nop,nop,TS val 3425678145 ecr 1561784501], length 49980
> 14:13:34.011271 IP6 sender > receiver: Flags [P.], seq 4148340:4198320, ack 1, win 256, options [nop,nop,TS val 3425678146 ecr 1561784502], length 49980
> 14:13:34.012271 IP6 sender > receiver: Flags [P.], seq 4198320:4248300, ack 1, win 256, options [nop,nop,TS val 3425678147 ecr 1561784503], length 49980
> 14:13:34.013272 IP6 sender > receiver: Flags [P.], seq 4248300:4298280, ack 1, win 256, options [nop,nop,TS val 3425678148 ecr 1561784504], length 49980
> 14:13:34.014271 IP6 sender > receiver: Flags [P.], seq 4298280:4348260, ack 1, win 256, options [nop,nop,TS val 3425678149 ecr 1561784505], length 49980
> 14:13:34.015272 IP6 sender > receiver: Flags [P.], seq 4348260:4398240, ack 1, win 256, options [nop,nop,TS val 3425678150 ecr 1561784506], length 49980
> 14:13:34.016270 IP6 sender > receiver: Flags [P.], seq 4398240:4448220, ack 1, win 256, options [nop,nop,TS val 3425678151 ecr 1561784507], length 49980
> 14:13:34.017269 IP6 sender > receiver: Flags [P.], seq 4448220:4498200, ack 1, win 256, options [nop,nop,TS val 3425678152 ecr 1561784508], length 49980
> 14:13:34.018276 IP6 sender > receiver: Flags [P.], seq 4498200:4548180, ack 1, win 256, options [nop,nop,TS val 3425678153 ecr 1561784509], length 49980
> 14:13:34.019259 IP6 sender > receiver: Flags [P.], seq 4548180:4598160, ack 1, win 256, options [nop,nop,TS val 3425678154 ecr 1561784510], length 49980
> 
> With 200 concurrent flows on a 100Gbit NIC, we can see a reduction
> of TSO packets (and ACK packets) of about 30 %.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_output.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 5e8665241f9345f38ce56afffe473948aef66786..99a1d88f7f47b9ef0334efe62f8fd34c0d693ced 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2683,6 +2683,36 @@ void tcp_chrono_stop(struct sock *sk, const enum tcp_chrono type)
>  		tcp_chrono_set(tp, TCP_CHRONO_BUSY);
>  }
>  
> +/* First skb in the write queue is smaller than ideal packet size.
> + * Check if we can move payload from the second skb in the queue.
> + */
> +static void tcp_grow_skb(struct sock *sk, struct sk_buff *skb, int amount)
> +{
> +	struct sk_buff *next_skb = skb->next;
> +	unsigned int nlen;
> +
> +	if (tcp_skb_is_last(sk, skb))
> +		return;
> +
> +	if (!tcp_skb_can_collapse(skb, next_skb))
> +		return;
> +
> +	nlen = min_t(u32, amount, next_skb->len);
> +	if (!nlen || !skb_shift(skb, next_skb, nlen))
> +		return;
> +
> +	TCP_SKB_CB(skb)->end_seq += nlen;
> +	TCP_SKB_CB(next_skb)->seq += nlen;
> +
> +	if (!next_skb->len) {
> +		TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(next_skb)->end_seq;
> +		TCP_SKB_CB(skb)->eor = TCP_SKB_CB(next_skb)->eor;
> +		TCP_SKB_CB(skb)->tcp_flags |= TCP_SKB_CB(next_skb)->tcp_flags;
> +		tcp_unlink_write_queue(next_skb, sk);
> +		tcp_wmem_free_skb(sk, next_skb);
> +	}
> +}
> +
>  /* This routine writes packets to the network.  It advances the
>   * send_head.  This happens as incoming acks open up the remote
>   * window for us.
> @@ -2723,6 +2753,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
>  	max_segs = tcp_tso_segs(sk, mss_now);
>  	while ((skb = tcp_send_head(sk))) {
>  		unsigned int limit;
> +		int missing_bytes;
>  
>  		if (unlikely(tp->repair) && tp->repair_queue == TCP_SEND_QUEUE) {
>  			/* "skb_mstamp_ns" is used as a start point for the retransmit timer */
> @@ -2744,6 +2775,10 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
>  			else
>  				break;
>  		}
> +		cwnd_quota = min(cwnd_quota, max_segs);
> +		missing_bytes = cwnd_quota * mss_now - skb->len;
> +		if (missing_bytes > 0)
> +			tcp_grow_skb(sk, skb, missing_bytes);
>  
>  		tso_segs = tcp_set_skb_tso_segs(skb, mss_now);
>  
> @@ -2767,8 +2802,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
>  		limit = mss_now;
>  		if (tso_segs > 1 && !tcp_urg_mode(tp))
>  			limit = tcp_mss_split_point(sk, skb, mss_now,
> -						    min(cwnd_quota,
> -							max_segs),
> +						    cwnd_quota,
>  						    nonagle);
>  
>  		if (skb->len > limit &&


