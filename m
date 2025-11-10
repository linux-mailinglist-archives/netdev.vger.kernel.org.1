Return-Path: <netdev+bounces-237160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64EBC465AC
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFBE18832D3
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2B82FFDF1;
	Mon, 10 Nov 2025 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zhHwvZe6"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E08191;
	Mon, 10 Nov 2025 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775204; cv=fail; b=nX8+HeYnbqAY5gy11RZn202kJiwim+gfWT/rOWfIhcHbTtBOFezXB/AddKwAvPiB0lfyc7wFgAbvgz1qvXkFVx70IvA3lu//r+HmrPRee6TQ+DaeVlhUM65RTcsify5j9nPwIqMjMsQYWczpoAEuBGyn+L6DYz2ffwnG+wRALDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775204; c=relaxed/simple;
	bh=rAm24Yhf5OnnxFDGHhcn+A85Km0ga6hHKGdXmH0a37A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h977U5wNL3K68p7P1RNbWDammk3LPCcai4GlC5hks+2XmNbK2i3EZdukV2OVSbgfb4eRx5K6B7a+MzS5/kH7upaBTYUILCwbJu2Tr2QeMbREhJnb3O7FH8eG+LV2zPnUPDM3yr05S/nfgkGAYqDI4Q4qRcLWETl9/6bmIaRVNUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zhHwvZe6; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu1+8hfHFjJwylAHYyvMGlPH08zCkKyy5nIUV94CC+qh9KyIrkLIHGg8poFpQaixL1bRK6DaiTmpKuBnal0UvcoKzK6GxyZ5sv97ziW+Bcy8EgOmOfP52Utbfn24tYP3MuLAF7mPaFcPGVnlzPxgwW9JqRMp6ORBpyeiN0UGKhVHn99w78oWCjdNM2d9TCZ7immVfq6rzg6MoaSkbwJbSnFW/XeNlx/rotTqRcud1di5sh5ea2U8Kw8Sg7SpQdWVjkvB3tNB1zvJrnNpdDHjbu5n0cC6iEdgVM3BvYC0c+A2MVhQmdBWF72OG1YNr9tt4vhddRnicIxpfcfpbFEWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WtW4Y11VhpcqcBSCL8qVZ1BgCquIMwC2J2lwqAeJaU=;
 b=VEsZ4al91h42o/6rUg5BKSbZ0sDrdUZQFZ5cNs7HGe4WviZmvzhheCtslgsGwOkA7eGL1hTsL/zYww8kLUyngaM/qjBYWlxlocGyDGsgASlQaqj/FTQC+3ig/WjKoU9sTD6vsDBuT2ovlrYJ1oSb4/zYR5ucpTd/9cBZSEXii7eiLezbsoytHhV33tJVLPXkQNKhnyPXQ+kBElKs0ldyIRVC/cb4ysn+mX0BFgLSygGwPEJF4QkX1vClGE2qtA8kYcByIMRT0xAr+3avWhjy+r19uhITlZ5VjWKNPxeB7VPWjLORl42UVRlqsRZdB7H292pVwPOH/pUbWs5mEWd1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WtW4Y11VhpcqcBSCL8qVZ1BgCquIMwC2J2lwqAeJaU=;
 b=zhHwvZe6rrxNqG1yV0HYAd+QAWBWhsA50XUAiggI9PbSHrgMtXijSvlPdIqp0hkmYU9E2mecPM5moiEpG64Dj61DyOHGfSG9ujjr/WklJnY87Or2Wf5bH2G5UyJRuIgwsrwgx989y/IB0uQlOLHGGtocLZrNHYnkOJflt9YdLZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV0PR12MB999091.namprd12.prod.outlook.com (2603:10b6:408:32c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:46:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:46:40 +0000
Message-ID: <bac55f2b-64ba-4001-b8cf-a6716c417d38@amd.com>
Date: Mon, 10 Nov 2025 11:46:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 11/22] cxl: Define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-12-alejandro.lucero-palau@amd.com>
 <20251007144321.0000778a@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251007144321.0000778a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0108.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV0PR12MB999091:EE_
X-MS-Office365-Filtering-Correlation-Id: a043e02f-e3e1-4991-5768-08de204ecfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QURidTVDNzFjN3ZEc2VRU25hQjgvczNyOVFCWTRjcFFjVHVlVEc1MUppb0l0?=
 =?utf-8?B?Y3RZaG1hTHlEaEQ0Y3p1czFkMlVkdCtoTElMdkMvendmVXVkdXp0RkNDaEhV?=
 =?utf-8?B?Z3dVSVpzUEc0dUkyNjhBUEU5ZXYzamZBenNzNmtVQStucGFkUGRHa3NHM2VH?=
 =?utf-8?B?M2RyaEtoRzJYb3RaNFVXbmxGUmx6alB5bDdyNGd4U09uVktjam83ejVvaWVu?=
 =?utf-8?B?MmR5Z1lwaGxMd2V0WmFUMWVra0VQMVhlOC9vOWk1TXN0bDJYQlVETHUrZnM0?=
 =?utf-8?B?bzhNdEZsQ0QvVHFLQm9jdUUweWVVS1hwTFpqMDQvWmtsQ2gyV1Fka1BwUCtz?=
 =?utf-8?B?ZjhGRm9RQTkxUTJUeUpHdjh3SmdqUkx5S3pPMGVyTzdmN0MzNXVxN25aM3o0?=
 =?utf-8?B?ZnJSRG5wQk5BZDk4VUlTeXcwQm5WemloQmZtV2JLcUlBYzJRcWlPaFNxc3pa?=
 =?utf-8?B?dmxXQ1dIdDh1ZDJpRHBrdDBUejF5a2R2UXo5WXhjUjdGYU10VSs5T3F3RENG?=
 =?utf-8?B?ejdVZHJCd0NFN1RLY1dsdWpRZDNZL1k0MEkrT1hBVXdoTlJPKzdsZmg3WCtU?=
 =?utf-8?B?QkNXV1JzRkM2MWxsRkxLS0xNSU5saW9xcFJnZ2pLNG1kZlJ3YSt3dUdsdlZV?=
 =?utf-8?B?YXRMdkdod3ovZWpScHU2b2FJTXpEcnpZVFZkVENoUkw3WnoxcFhMQWxrdTJs?=
 =?utf-8?B?djBwTFYwUGhXbjA1eFlyaW5keTZGRDRiRFRnSjY0bWN1NTg4SkFEdERSWitO?=
 =?utf-8?B?YzAwdW1TVGpKY1k0NkNiZ1ZpaFBSYXhRWGtvN3BaSHpOeThWc2o1T2ZqTGJx?=
 =?utf-8?B?UzJNWTdNQ2g1V2dPZzdsYlR2REZadmhFT2EzdjVHbHNlTjBYSTUwaXJMRVBZ?=
 =?utf-8?B?TW54bmV1ay9GaWcyc01aQU1iQkpVd1h0L2NHaVlmQ1dtaDRLV01FN1ZCM3FN?=
 =?utf-8?B?RkhBOXEzREltdXY0SitPQ2JGSTRUU3g1ckhhc2VBVkdodnoxczNON05QVWVK?=
 =?utf-8?B?TDcwUzVUbUk5dFV5YU1TdVFwODJTMlNEKzNYVXFSc2VtelBjcmZhY29kb1pC?=
 =?utf-8?B?SjJuYmVEMWJ0QWdqV0VGdHVMUFpUSkFVTjkxOCtTb3BYZGQxVWRVbDdmZnJ5?=
 =?utf-8?B?RnMxb2lGZEx3QVlnem9XZW1rRzNkUU9qaWtVcUxVRkFzRUNmTkZuZUZ3ZDdL?=
 =?utf-8?B?ZE96Q04ybWJzcE5aU0tRUEVQd2ZwQURMcnphYUFGSURQRkh1Q3dFdm00WjRo?=
 =?utf-8?B?U3VIQlhTNUcwWUl3M2o3aTRsR2VXclNOUWJsc04yb1liNTJzdEtxS0hvR1Yy?=
 =?utf-8?B?WHdBQS9VN0M3eWY3REJrMmcya2hOWWI3Z2FMSkxFWEVVai9rRGZhZVpqUXhZ?=
 =?utf-8?B?MXQzQmtIdy9CK2NDbFZEdzhPcnJxWjdKRTlaY2hyUDZqa2QxUi9aeGxkRXUr?=
 =?utf-8?B?ZVJBZWhWYzIyUGx6MXMrOU9YZytZR0xDeElkQzFScUFBcjAzMFJacGQwdW5t?=
 =?utf-8?B?VzlWM0ltQVRGc3Vmb2J6NjdueldieGN6d0U0MWE5a0tZNWkwVG1UOGZsWEU4?=
 =?utf-8?B?NEtMTk0wZUROL3dMRmdTUUVJTWdVSVg2NW1zQWVFUUpiVXlITW5zWFpJdGRv?=
 =?utf-8?B?WERPMDdZSjlKTERKazJ4U1pybWk5TjdDdHB3dUxDQk54endFNm9BZmVTTzY1?=
 =?utf-8?B?WWhXODdxUGtRNWFsRzZZUmgwQzI4OFY3SHpjNC9wVml1cFFiZUVGTmJkczli?=
 =?utf-8?B?RTFpck9PY0FRdmcxTlZYWVZUSk04bEdudTl4RndCc2R3QnBPbEptc0p6Zk41?=
 =?utf-8?B?REJoU0hhT0MzMzlCWlJJQmFtQVZmblBwYWRQeTh0MmFZUW5sVTBzVGlVeUF5?=
 =?utf-8?B?YlZUTjVreEJBN1BVTFgyZ3pKWVFPVnZjMTNqeXBGMENycVhyc3k3UU5Lc2du?=
 =?utf-8?B?QlN4Ujk2Q1BzRlVyaVhlWCtXam9COFlqNmhVd2Nrd3hLZUxFKzlyZmpMSFd6?=
 =?utf-8?B?U2lJMjdPcEtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUVZWDdsa2Y5S0dIUCtsbktDYzljTUFsWWVZNEVPU1o2RlkyQkZWWmNUTnRL?=
 =?utf-8?B?VUF3aExMVjFPdjRQanB4MnA4YU1oVWpKaDBKNGlrYTZxTVBrNEFjMXhHbjBn?=
 =?utf-8?B?VUpJQ3RkOG5VRWFvREpSanNSeG9SYTNmL0dLTndldWVrRlRkamo0OCtldXEw?=
 =?utf-8?B?dGFZSjlFRytaY1ZBN3E3OEsyQWgyem40akdPK0svbXJVMFk4OVljbUFLd3hT?=
 =?utf-8?B?R3ZTK003elF3WjRXVUQwT09iZ0h4Y3k1UnB1T1RCeDQyN1E5bktsWTMzTjZC?=
 =?utf-8?B?Mkt3RXRhWEgxNFF0VzZZNXlKQnJVdmV1cUMzcTY2Yy9xeG9zYW5QUThaNk1z?=
 =?utf-8?B?QkdUNjRyNVZwNHo4Y3UxR1hwbWpaa1N0MUFyZzd2elVlNi9MQU94dHRhYVE3?=
 =?utf-8?B?VlcvNG1mdkFTOTNkQUhvNkFZcURZck02alBqTVBFeGo1LzRtU2F2WDNPVWFz?=
 =?utf-8?B?UVJ4ZmNNL1hIZFF4bTgvblRvWnZZOU4xeXhQTlQyeFkwclhUamw2NzhPVC95?=
 =?utf-8?B?dlNvbzdZT2o3R2w4ZElYZ2NzdTFmaTJZaHNQWU92Tks3SEwraXEvb2RLNzZk?=
 =?utf-8?B?TGxXdnR2VjAxQkFER2VpZ1FWZVpPN1VmRDNiM0dOY0tUUTZ1cE9DZXZSMWcx?=
 =?utf-8?B?amNuR2VuQUNaaVQvUktWM3dpU2d6eXJoRDBDMlBLVU9wRHVzVmVlVTdJV2Fu?=
 =?utf-8?B?MTFkTzd0VGc1cFVRODR1R3JVYzBFTlcrVVFVRElpUXRoYkFXbHdtSXBwdEls?=
 =?utf-8?B?d2h5dVg0TW54MHhUSXpFQjhSbE5mRm5jWmxlazNtYkZ3Mmx3QnhIbjZOdGZm?=
 =?utf-8?B?d1IwaG5kWHNXUWdCNzZBV1ZkTWlYZ2dweEh4aU9XeTkxV24vOGRzWGNVcko0?=
 =?utf-8?B?YWZyZlpJUW8vS2paWSswTm5MbGJ2VkVxUWliZTZJdnVUOGFia2dpcTdaaGYw?=
 =?utf-8?B?ck1jblZNbVFaNWJPc1JsNTREOWc5VnZLNHcyUXJYcVc2UEdWeHNJTjdZMkhx?=
 =?utf-8?B?RFZrYnYrTjEwc2gzWUhUa2h5L2xxcFlpcnlkZ2s2c2x5S0ZBOWxMOG0rVzVM?=
 =?utf-8?B?NEZIbGU3Mmd2ZTZIVDRCdWRvOVhUcHdIOHFEK0dYZUQ2bnNVWTh2VDZhUlZs?=
 =?utf-8?B?bWJuckVpb2tRTWVRNDBWNmg5QW1FYzV6d00yVW10NzBKb2JJZlE5Z1RFbU12?=
 =?utf-8?B?WFArRkFpTkdmc1lBNk92WU1pS1NFTnNIVjV6OTdlQ2V2aWovdHVOMTVMSFZ5?=
 =?utf-8?B?M1pNSnFpazRBY0U5bGl0eGNzbXJsMWFWVmtOeW9reDdnSklpQzU1WjhnbW4r?=
 =?utf-8?B?RTk2MDRNVW5HaWxXdFZSTTl0NVJjREx1bEtOUG90RThSSWdCRCtEbnBrL3ZX?=
 =?utf-8?B?NU8zNFhHY1NabXBLc3A5eldPa0ZmVkhiYWlmOVRBTTFDZWU3eHgyaHBSODRo?=
 =?utf-8?B?Zm5PM0phTll3Ym5oZFQzZXBQaVdYVFNWTDd1dzU3MDJjckVRaGJEZ096OFJy?=
 =?utf-8?B?Q0lsVmsvL2NVODZWTURRM2xTN3BacGRKVExJM1B6UXFCWlRESEZ1WDhQWmVY?=
 =?utf-8?B?QVdFMzhZeGxOM1hJd3hCdVEvbnpjaDlDZDRLaTJzV1BDb2RPaUV6ay9TVmlE?=
 =?utf-8?B?U0laOWYzQWtXazk2Tkg0Y3dWeGd0UUQ1QWVQMmx0WGczYzJuWjNSUnlzckpr?=
 =?utf-8?B?VjFmbEhOajdUVHcvQk5VRW1KdGp1Tmw1TkVQU3c2elIvRVlSc2loUU83bFIz?=
 =?utf-8?B?dlQ1RzN0RTJIQjFySGtBekl4VmRyWTZJTUltbVExSjNHRXFGaFcwR0h2NGR6?=
 =?utf-8?B?VlJUU0FUejJJenBYMDlxdVpycnlBeGJtaC96bFVITUlqR3VlWURYbTFLT2s2?=
 =?utf-8?B?ZEdiOVpwQVJTampvRzdzUkVjSVJ3eDRCYklWYU1waTR3cmJWV1p6eGpKZ21p?=
 =?utf-8?B?RjJjdWNYa1crdGE0REJvTUFZbkNZbStYRHdxU1I3TUF5OU5vNmhaZnBwOGQv?=
 =?utf-8?B?ekVpZy9VVGtWemlmUW9YWnVLUzRrdzRIZURlczdRelJGNE5pYk4xTXpJR0pX?=
 =?utf-8?B?VGd2VEJPWDliM2VPYlNDYnBjMU15K2lXaHBZT3JFcG16eDU2WHVtZU5mUnhr?=
 =?utf-8?Q?n0Tm85udS6/2SS1KGVTK8v2I4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a043e02f-e3e1-4991-5768-08de204ecfc6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:46:40.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4OkaZ0iYEkyu2uyES4DL5CqlypWSXisPn2LLD1our2Uggg19lcGjNwr8McciBPhOlhXEVf4ZXyTpWLWbE8NMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999091


On 10/7/25 14:43, Jonathan Cameron wrote:
> On Mon, 6 Oct 2025 11:01:19 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from Device Physical Address
>> (DPA) and assigning it to decode a given Host Physical Address (HPA). Before
>> determining how much DPA to allocate the amount of available HPA must be
>> determined. Also, not all HPA is created equal, some HPA targets RAM, some
>> targets PMEM, some is prepared for device-memory flows like HDM-D and HDM-DB,
>> and some is HDM-H (host-only).
>>
>> In order to support Type2 CXL devices, wrap all of those concerns into
>> an API that retrieves a root decoder (platform CXL window) that fits the
>> specified constraints and the capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> One thing I noticed on a fresh read through...
>
>> ---
>>   drivers/cxl/core/region.c | 162 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |   6 ++
>>   3 files changed, 171 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index e9bf42d91689..c5b66204ecde 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -703,6 +703,168 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device * const *host_bridges;
>> +	int interleave_ways;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +	int found = 0;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
>> +			cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	for (int i = 0; i < ctx->interleave_ways; i++) {
> I think ctx->interleave_ways == 0 as it's never set, so found is never
> set, but then the check below succeeds as found == 0 and ctx->interleave_ways == 0
>
> Definitely doesn't feel intentional!


Yes, that is the consequence of the other thing you spotted later.


>
>> +		for (int j = 0; j < ctx->interleave_ways; j++) {
>> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
>> +				found++;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (found != ctx->interleave_ways) {
>> +		dev_dbg(dev,
>> +			"Not enough host bridges. Found %d for %d interleave ways requested\n",
>> +			found, ctx->interleave_ways);
>> +		return 0;
>> +	}
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @cxlmd: the mem device requiring the HPA
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * Returns a pointer to a struct cxl_root_decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>> + * caller goes to use this decoder and its capacity is reduced then caller needs
>> + * to loop and retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with cxl_put_root_decoder(cxlrd).
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
> Currently unused.  I think you mean to set the field in ctx


Right. Refactoring went wrong.

I'll fix it.

Thanks!


>
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxlrd_max_context ctx = {
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +
>> +	if (!endpoint) {
>> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	ctx.host_bridges = &endpoint->host_bridge;
>> +
>> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint is not related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
>> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max_avail_contig = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");

