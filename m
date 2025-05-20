Return-Path: <netdev+bounces-191741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B91ABD02A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B058C4A34F1
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD52825CC51;
	Tue, 20 May 2025 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dn30h1tV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D82571CA;
	Tue, 20 May 2025 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725492; cv=fail; b=lpn/FGSBlESKYN8qPy0DZZrGlx0z5U42gaz1LX5ZuuhRTXBxoHAiVNP5jjd1iNxqTZ/m3P+CU2PgV8OQbxiWsxoCvf8D5L0oQ8LTvWVPcCtA3+FI+4i4/Dj3YMiiaUCBqvp1ZcvCZN9zYwbU+VgXPgLAuKLVVJe8SlyttqSDyio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725492; c=relaxed/simple;
	bh=zu6pAgGmUb9facsqM9m+xAlniWbJtlWq+askTGRsvx8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nBtUMW5XyZbf1iN1sbuGIcZQgd3UhZUnyO1oZoXOKEzu3FBC1quvXWyCph954zH/Vq2zS5V74JXKARGH/ECp3GuTS8OfnJei/ksd3j+R83Dq5KLNeGY8oT7SJfIepD5JsSlft9erFFizhLqQJFBwL0lF2LH0PmtbRi8FbdroMBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dn30h1tV; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C79vg01++V9hB2Q5v/jxl2a5fi85CY3bMxUsgYJbrUHdekaaECfDXX3QJExF/TifSRQ/SrYz/Mhif0KOaCYMsAsCRdxgpOJQNM/H8blz9fK7kJxXiTVRP8rtlVSg0hB/0Hi+yCMPBvQ+crtEoUBBK6KuN2PFL9OE1cFxLpjnUubeJx6SwcE4ShMZ3v5bDx/eHaCvPwq4a2xL9BzsqKZDwzXXP4Ns6P8B32jO6jQZ+7D38kgdIomPnLsteX9Lx7jtcEMdq68a7BTEoFWSQMB7CQWHAzc5I0IQKtIZiIe7dNXI9+U6ZoFmYvJyu6sadmRkCWhpVxvFHX89Uz948z+YOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FMubFPG5QS9gTTaMfEyWY0z4kJl7F6keDQdtdveVqU=;
 b=cjC0DsPLR++89/aVDMzM1Il3wLSfPCpGsYz+d5Csbeion0rA5rUCegNMXrPabXq/o+6dHNl+RHG3eoKbREaBS2IKhwq5XvyvSVUkyJsW+sCkeXmKNmiTQycr8EmK8X/pksnuTWGjgPFhOmXwHeQbb63T2h5Kn9tAvrlpjxONzx6LTbR942PaKS3qkCT898XyYMQcZyx990D7zJgrZ5ZufCx3WcWo0hevDsKL/rqefDqGsabsS67hiOBy+71Rmfp/gacY4DrYsxb0O0cIU86817OuYlzrj1XxnXyk0SQuyfyNKbd93AmkOXV6/4EF+eyUb/EUyVpvaFin0UheJGkoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FMubFPG5QS9gTTaMfEyWY0z4kJl7F6keDQdtdveVqU=;
 b=Dn30h1tVG1JlznrpDQp+lGgdr0LdxqPZQRR4HUoQtWp7kF4NRbfcaQ1PwokbRkQUFCQ//6ZjD6vDyCSSWOqZ0F0wvuquxfLSQ9eMYsiX9MNDwbYKz3aO5tuYSSpY7jhrM0ZdEXvh/cTkSTnd1lITEs74ddL0sTKVJlqlM7fIAfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BN5PR12MB9463.namprd12.prod.outlook.com (2603:10b6:408:2a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 07:18:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:18:08 +0000
Message-ID: <27f3bdd8-d3da-4dca-bcc4-5bdf7b3ebb35@amd.com>
Date: Tue, 20 May 2025 08:18:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/22] cxl: Add type2 device basic support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-2-alejandro.lucero-palau@amd.com>
 <aCvsTqArfcKJQDBD@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aCvsTqArfcKJQDBD@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BN5PR12MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: 50db4073-8661-4788-cb2b-08dd976e78a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzZDQ0t2MlpjUnhYYjNVWjJpNStBMG5rcFltUHNLK2MwaW1YUkRPZ0N1bXdT?=
 =?utf-8?B?cXhaTGNva3phOGh2dzhKWXFzeGZTb09JRkJzN08yZTh4WUlhRkF0N2JFNU9R?=
 =?utf-8?B?cS9JMkkxdEt5bGNCOVlnL3hsMm15azJPRDR1b1NFOUdlOEUzRjc2djRBdGFi?=
 =?utf-8?B?d0t4eXpyMjREOVZDTzBycGczUjJFV3dqeHhYa2hhM0J4c3lHZGx1QS82YUhq?=
 =?utf-8?B?cDV5YWtWaFUrM051YnMwVCt2QWwzclgwUnM0T0FyY0x1ZHZXNjEwc1Q3eDVj?=
 =?utf-8?B?WmJ5aTZMTUMwVXJDUE5QSzdvcUpaSEN1RXVaRGduU2drd29OMUVYWXpaeER6?=
 =?utf-8?B?M3MzNnN5emYrY21TZFdLOGhMUEdGb012MUZiYjZ4WjN1a3pPUGpEc1QvaDRY?=
 =?utf-8?B?eDlzM0tWWitacGpVNC9rQXdhclVHcWN3MnZrbXhJcElOYUh2aTJDdEx5Y0xa?=
 =?utf-8?B?cGVjTUVXZ2VnTEVyZU9aMEpaazZnRit0RHBhLzA4bFo3N1IxRkFtM3pvN3Vh?=
 =?utf-8?B?QVBkc3pydjJJeEtMRnIyYy9vOTBmSlZiNUE3SzJmT2xmQ1ZGMUtZMHRYRlRk?=
 =?utf-8?B?MHh6a1JvTGRqbjcrZklUOTl2QnpYYmwwSHVsZU1sNWpVaE9OeXBhdkhuSnYr?=
 =?utf-8?B?cEtMZ2tISkRkVlVxd3l3YlVBSk5BaVJkRGl0L0gwaU9MRTR2TncwWllvMFUw?=
 =?utf-8?B?dXhHL0psWEkzRHBYak5qYUorUHNvbU90bkU3eTNhK1I4YmxWWlhjYTRGRndS?=
 =?utf-8?B?dENoQ3hPUTQrSSt5RFdiS3A4Q01hVExQZUVJWHJTQzBuVWE4cXd0TElQa2VG?=
 =?utf-8?B?N0hRWWdjbHZNcUxzc2g0WFE2YTFBVmNUbGErUEFvRS9BU1BsQW9leUNYQTR1?=
 =?utf-8?B?MkY3VUZNZzkvdjgrekZtbndPZkk1UDlrKzkwbVVRSklJSTRDZ2dQK0N6dDND?=
 =?utf-8?B?cCtVT1BuMVhxbkcvL0NsVnV2aDVzWWdSc3o3THA3cUF0ZFdUSW9RZVdaNjA3?=
 =?utf-8?B?YlRZZnZ4T2RWaDdaY2xnMG1HK2JvSDgwQXIwZjhGTUlvendqOE02b1RKMzA5?=
 =?utf-8?B?TjhYdzlhYmE4ZzREdHNvWmVWc21vZnJmQ3FtZ1VRNDhiOUNLM3AzNCtuekF1?=
 =?utf-8?B?YTBacXBnTGZsNUZsK29iOUE0WnFkRFBoc0d1YXJIZEt1ZjB1Nks1MHFVNWtq?=
 =?utf-8?B?UERoNDFyaFB6YzJob1g3VGZ1WC9OUGYwSjZvZkRCL1BBU1ZkUS9YSUhhcW9S?=
 =?utf-8?B?ZnJiTXRFbG5hQUpHSVlQWDFPcGk4Q0JaUlBsb09FQWpqaGpFY082VVQxTzFv?=
 =?utf-8?B?azF2TmdUQklaR0czbEhYMm9Va28xbmpiNVcveGhDRTRsMi9rSjBrWU5MSXVl?=
 =?utf-8?B?Y2ovZ3VVTlIwcFRQUmYzU2xBYWFDVk91NzNpazNSUDZYS2MzN085M0lQYTRP?=
 =?utf-8?B?VFVGOUhhcHJFdUNHL2NyRFhFWFFtT3UrQkUrdGUvN3RyNXB3UE5YdEk4Smc4?=
 =?utf-8?B?S2pMOGkrVUFmVS9IaVRPZTh4NUJkMTJsL1RWcURXaUNXWitqWjRoOTMzOTdP?=
 =?utf-8?B?MGhtL3laQU9IZStDWm84NUVZTnJHQzVCUnh3S3YySTlZRVFYZEhRcG1UVFJh?=
 =?utf-8?B?c21zMFBDVERrbE10VEVQeFJ1dVZmZk9GR0dqUGdXTG9zd2R2dVdWdDVMdkps?=
 =?utf-8?B?RkpZU05QMm1pZWkycnlCbkRsSjQ3VFdGUzJDSnhYUm45MER4b2IwbFczakww?=
 =?utf-8?B?d2w4dkJ4Y2xXVGVBRmdpUy9sMTg5ZThRaFpZZ2UwNTlmUFd0WXlJWUpKN1NX?=
 =?utf-8?B?bFdzaUdReXhqcmh1ZmRGWTFuNFpCMjNOY1AvL3ppUEVpaDJUb3QxcThhWWJ3?=
 =?utf-8?B?K1E4M1FNNzFRd3Vwa3JFaXpjVXNBdnBxWldtb3F4Nzl3b1d3NTZHcWxSMmp2?=
 =?utf-8?Q?J7GjI+x1V7g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFBaU1Y0N3d3Y0dhS0l2WithT1k3aThCTWo3VHRObTdFUk9NalNoZmx0djV1?=
 =?utf-8?B?QTEzMkZwM3c1Sk9sRGpNMTNHUGE3a2dhOXBxdW1LNi9za3d3allXeXIwZ2Rr?=
 =?utf-8?B?UjhMdkxLa2UzNkJ6SzZMNFR1OEc0VlhIUGpuR3hpMWJlWTkzdTRQN1NvbjJO?=
 =?utf-8?B?T283OXcxZXovSG5Ebk5nTHUxb1hIeTN3eHFnZUFwejZ4b3FPelYxMGFVVnYr?=
 =?utf-8?B?dXFqaE5YZTZxVHhxL2ZyQ1dmTDZrendOcU5SRWpaSTA3aG0xS1I0aVVoaHdV?=
 =?utf-8?B?S1RHVktnQ3Z2UFBZNjJUQkJCQ3Y3YUs5THd4dDU3bFNxTFFYOEE3aEk1eWN2?=
 =?utf-8?B?L0ZSWXVoYjkxeEZTbGdsdGw2eUR6dW9FbE5Mb0FVbFBsTWhyQWNPbDg2NkFR?=
 =?utf-8?B?WVRucDdZaXRzcldZRFZUa2RWL0FyeklDZmM5MU5kc0pzVDhqOFFmYkJuUkRn?=
 =?utf-8?B?UVRMbU1kMFcrOFlCL1pKc1UxZzVjREtGYkptV1BwRm1nVkgwQ1JhSW0wZVV6?=
 =?utf-8?B?SHBaVjdYMU8yZ2o1UmlmTE54TE1lcXhtT2dWWlBLN2hpemRVUzZYR3NQU0Yv?=
 =?utf-8?B?aE10L2hHK21qdGF4NHB3aGljSit3REZnMVVIRlh4ci95cHA5bG5mN1FwWlpJ?=
 =?utf-8?B?Ky8vR0toYXR6Mlh5OXVEYnIrQ2JmTi9ZemVtSkFvenhQNGhsM2NTOWJqUjRw?=
 =?utf-8?B?YU1UeWVzYzZvem5sdXlLMnl4dUFPejJIM1lOdTdhTnV4SDlTN1EyejVvRkFu?=
 =?utf-8?B?cnRXSHlCWXAzMTZ5MGs0azV2QWlpNWJyYkJvajJIQXUrSG9UeE5HNmd0RXRU?=
 =?utf-8?B?Ykttei9nL2wrL3JLWnhtL2M0SHJIMWxGRjNSUmZDeDgyOTFLUEFaUDBIdEJx?=
 =?utf-8?B?L2xQbWdURVN5Q2p1WkZlZ2x2RG9WZWJsT0d0RUlrVHJ2NEliWkprQ2xlZ2F1?=
 =?utf-8?B?WkZlS1ZoR2lTRUZUTy8yQlU5Kys4VlE3N3NTQklPZDU5RkFyOTFaUE9oM1M0?=
 =?utf-8?B?SDJBei84ZjZXampMMWtOdHNBUnhzZFVOa21sbzlKR2EyWnZvQmtwQ2Q1MUlL?=
 =?utf-8?B?MUdMcWUvM3BQTEp5d1RzbGhyeDlPNE02NC9lN2xRVEUycWpFalpVZ1VTaCtR?=
 =?utf-8?B?U0tzQVFsZUdTbjgvcXd5Y0RPMExZMXlkZ1Y3S3A5ZWVIeXZXUFQ0dk9FU2sv?=
 =?utf-8?B?NG9oRExwa1hOVU5NVGI5NVJWbFFDdHo1VU16Ty9FczI5WGxveDZRdEVoaXlB?=
 =?utf-8?B?NVpPS3lrMk4rYUgvUEJpeDM2dmZ2aTlDNTFCSDBJYjFJL2tFSHVPNHNYLzZ2?=
 =?utf-8?B?OVRJR1cvcXFUTm9nd2RTMzR0VXhyVEtWOHdmN01XZHlac0czZi9ML20yZTVi?=
 =?utf-8?B?bUtlb0pCcW5IZDlITmZIYzh4bERISHFPVVpFRGRYZFQwNU45WnVwR1U1SG0x?=
 =?utf-8?B?VGFoK1RVUmk0cGd2RjViKzZ1WFRkWGloYmRVdWdiMEtRMDFNdkJDTzJWNHhH?=
 =?utf-8?B?TEh0aGlxQVUzQ0RnZXZyaEVHQXEvbE0yNzJNdTVpQkRDYzNlNFRXVFIxZlI0?=
 =?utf-8?B?bVRYR3p4TUd6eTJtNmtaV1B6SU5QTEMzODRSWWNGZkRZakJhN3ZaSmxZK2dZ?=
 =?utf-8?B?N211bnhzbitid2lodmkrWWxCK0dPYlRoaUV5RkR6V1dRZXAweTJLa0VCNm04?=
 =?utf-8?B?bWxQMUdmUWdRVUgzbWc2a0dKNGcvUWc2NFdoT2g0S3E2RG9XVW5iT0NKMG1H?=
 =?utf-8?B?cXVoSGJlWnQ0M01zMlpTQXlzUCtmYXlJeE9rbTZDSDl4UkM3UEhZVXZxSzBY?=
 =?utf-8?B?dldNMlBBYWY4ZVhPN0xpSmtnYmtxMGhJOUJVY3h6YVAyeS85MmRnSmZzYXZL?=
 =?utf-8?B?S3lOTG94RzFic0lucisvVjIyaEppdFhzTzNzS3dDUXp0d1ZYTUR0amE5cmNB?=
 =?utf-8?B?OHlCUHRLRzZpeW1vWDZJRWw2NXB4YjBMNnFidDI0YUlzL2FreDkzRkNEdEZV?=
 =?utf-8?B?UDdqSGVTUDl2Zlprc05xWW1TcUtjSHREQXl4N2c5VS9xVjFwZ25ZYVhJblVH?=
 =?utf-8?B?YjRDTnhhcEhNNk9GT3hDMjZQU2pIdVowbHpRdThtODdpTzJDVHI1dFlxR2R0?=
 =?utf-8?Q?3HscvrusTRGWBdEkmZVJy0EUV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50db4073-8661-4788-cb2b-08dd976e78a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 07:18:08.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOucgM+sjDDjvuqW66lBO8cOt0A5231d9Z7B/vf4BmI32l7kMV6nXLYmX7mWg4ErkQaYXIBMG6jMeMPmiEIbTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9463

Hi Allison,

On 5/20/25 03:43, Alison Schofield wrote:
> On Wed, May 14, 2025 at 02:27:22PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state and a macro
>> for helping accel drivers to embed cxl_dev_state inside a private
>> struct.
>>
>> Move structs to include/cxl as the size of the accel driver private
>> struct embedding cxl_dev_state needs to know the size of this struct.
>>
>> Use same new initialization with the type3 pci driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>
> snip


Thank you for all the review tags. Much appreciated.


I'm afraid Dave merged the patchset some hours ago. Maybe he can still 
add your tags at some point since I think he is using a specific branch 
for this merge which will likely be merged to another one in the next days.


Dave, can you reply here for knowing you have read it?



