Return-Path: <netdev+bounces-195443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A3BAD032C
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B2D3A2DBC
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87610288C37;
	Fri,  6 Jun 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="db4HUV6f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957228852E;
	Fri,  6 Jun 2025 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216465; cv=fail; b=bn7Pvf0xLlWvGSepitU9eYKvg/I0nrf61K7lk93Yp2XC17Z2q4HWZQeb4E9ymRn+VnBByiA4ztDz8XnHCpy2rGIeqSdIORbi2wviye9DunfEyjrfRqsUhu7/TqRz7jhlsEyP5JPt1WMRzYBAdWggSJTwvLnm6B/HZhV4DAJj120=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216465; c=relaxed/simple;
	bh=xAd30uVtW0yVE38ImLg47fzFIlBXBq9bj9bUUAWjHzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gr/PG4CvvThDkMJ9kQLOwdEMaRJQxNMvAZTHKs8uHXWuf91DS2V0GzPB61ww66myiJc07/a+RPeItG3HDB5ZftjyocBBbSEZA0A7F+7AHzK92t7XHWVn3Gyxnddh1C6e8U/h3fVwIZ7KiRU2FK+ewLmEbE5CWBWvR7zgwBB3Mq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=db4HUV6f; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3zUbvSxPZxrMy1rkzQPJ3SBHrudva70Al7cNe+ueU192HA7ylLFSCA2YRXZ2ClBac6Ny3oGTEQ6d7C4QxIwl6fljdVZ3OZZjfMTt2dhAVFBP3/3AuCYgfPW2lgffddRTDNuzcEIlK2igqpGax3zzVNKqvvomGI8bRaS3V2QbBdeHuOmqNpUsnXjjKJ/M1hiDZc78RJ+NXbztdgKK2i8mtHS/cWbWrZYLH3XJLYB0mbmVAM03Kgr7sSblLJ6Ui4h/35RlAcwOYdAI0+dsGvXvT3kL+hZjt6efjY/Wv0wvdbHLulYUddUgP7uDhA+enidaqc5MQp0st9oMtf8jhpNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN58C7GiIfRsLKfPBB1N79TYc4jHezhYyBasA2g20YU=;
 b=OicdSNvqgxVL2hW62FzSxTCXSpOR7qG/5wKKXAYDcFXqvwwd0lwHKPUHF194qjcYkjt+i/JFdPCRLuE3vF81ybTb38B/lsyS5WN6fWerUTmTQ8Z6x8VJCiWrYdVN8QaM+aU2mxdOctH4GFMyjQDa3AtTmseG08uKeTTHluA/+1eryuMoJBiGKPUbn6lPZl8OtTY0NbomILZNZziVyYANhGyd5rbNwyaX8VSa/YNRbbDh2XGDfTRI0DvY5k+JPXs5mzZi7SA9qn490BWiQD3LvJ49sYDY4FkQSMvs7gqUxaSkKCTgi2P1tFL+ygWGhQaZYadlyOm9ooDrQE2jIvOZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN58C7GiIfRsLKfPBB1N79TYc4jHezhYyBasA2g20YU=;
 b=db4HUV6fT9Zl+gd0nXXuwQx3/izd1tEUQIVbxkOq/ELp3t10UC+7VQIjbiPV9t1c8VIVykvchft/uHem6ZwHTUHyv9adXGwR/U7q07IGwVEvOzguQCEElBzyQOQG22zemC6wjNY5Vn5Iz6JcJ3XZHUaLYbYbPiwQkhQxG/Tz6aU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 13:27:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8792.036; Fri, 6 Jun 2025
 13:27:40 +0000
Message-ID: <e25325c0-b6af-498f-ac6f-e6b35c3109b6@amd.com>
Date: Fri, 6 Jun 2025 14:27:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 18/22] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-19-alejandro.lucero-palau@amd.com>
 <682e3b7cf2b2_1626e100ce@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e3b7cf2b2_1626e100ce@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0553.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e6b892-597f-423d-52e0-08dda4fde904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjJyd2FTdmJrV3JUY2d5dDIxdVVxV3IyNXJqUThOcW5JM2RvQjQ5R3pKNDd3?=
 =?utf-8?B?N3NZN2xFeTBvdFY0eHBpMlBLVEFpNklZZkpxNjlQNFprREZxUGdWVEpiK2dC?=
 =?utf-8?B?UnVNT1pTdW1ncTJkbFV2Y1hEcURqR09hcUhmcVNjZXBPKzFEM3RIQmRHUm1R?=
 =?utf-8?B?Q2dVWVdOL0c1ZlZtSys2VjQ0TjUvaEZIaHNQbyt2K1o2SXhKYmJWSmc5K1cr?=
 =?utf-8?B?SVllN3hoY2Y4VzdXME5CR2dLeTFIcnoxZ1k0bUJaaEppZm9GdWVUZTJnc05u?=
 =?utf-8?B?QnNnV24waGttWWhmZUdvL2ZUQm10a1Q2bGdRaEhBNm5YUkV0Q1hpWkVBaEVE?=
 =?utf-8?B?My9ocHJoclJNejVOSjBDczh0MXlIVDhRbEMzalFLT0x3bm5SVHZvck1FRStY?=
 =?utf-8?B?eFpuWW94aHVrSzZFMU05ZWlMdjYvakpIOWE1TVZJcWt1STNwaE5MM2V1eEps?=
 =?utf-8?B?Ujlmb05Obm1VL1MrOGhwU1BMamhXWkxhQW0xTlZsdjJ2ZG42VTZLcWlNY2RL?=
 =?utf-8?B?a3I2TC93QU8zczVMTmI5R0pYTG1Ycld1Mng0TkRneGI1RHpYMVZJOXNZSjdI?=
 =?utf-8?B?cEhFT09lQ2xrcGhTNzlXRGdoQVducnVFRFVzTkdOU3V2TllMOGtKWUdKRHNW?=
 =?utf-8?B?bXFlOXJXSUFER3VGaTdpZkh3M1MxcktGR1d5c0dFZW5vMVU5NERYd2NKYkFT?=
 =?utf-8?B?elpQU3VLTW5SeEJYL1ZLMC9wN0NHaEhnTi9UQXlnU3dJRENKZ1lKTU5UYmVT?=
 =?utf-8?B?T1ZWZGpiYjk5UVluN0loUFU1cG9aalp5aStRZmY1VzUwb0ZnN25LWjhsV0NX?=
 =?utf-8?B?L0VvZjhYS3lKZUYvVkxlYy9RdTBNK0FDZXF3cnhTSWJ1TGJ0aTJMNzRYOExF?=
 =?utf-8?B?d1ZwK0xtdXEvTGxwQjZJQnpCZDcrMVhISXpmejJsRHpRcDE3eXgvdjNHNFUv?=
 =?utf-8?B?czRFQk5zZytjaFN1b1E1d2hYVlA4a0xwNVZGZmVGUGhNUWs0LzNPOUdjdy9G?=
 =?utf-8?B?UlpFRGlIYlpPMmVJaXJoN2FjYnJyY0ZHeHB0UW9yWVJ1czl2SDRXK29OaDBt?=
 =?utf-8?B?QVZxc2tMajNjU0hobk1RZkZmNmM5UUgvZTRpenp6MWZGd24zTFJrUjQ1ZHFM?=
 =?utf-8?B?ZDN3QWhmQlNidXptZjh4UHZ5SFIwQWYzZHNMZHVPbHVNempGVERWMFVhZklM?=
 =?utf-8?B?U1F2Q0ZMcHFpa2VQUVQzNGVLK1JHRTQzb0x1TDRFamZySXlsdFJoeStJQmRS?=
 =?utf-8?B?QzQ2S0RaS1NxWXZCYm1FeGJwSFNXNlZ0L0NKVGRsSGV0c0JUNUVlR0t3MmM2?=
 =?utf-8?B?QnVqVzR1ckhMZmtsVDhDUGVMLzJSUmtEVVU3aFhxSko4a29GYmdwN0FoVDFm?=
 =?utf-8?B?b0pjejlORHFzMkVkdGVqaUtRY1d5YUJRVC9Ud3RreW9aelMvUGt1elIycUdu?=
 =?utf-8?B?TXAyVnUxYlkyc0F4emY5WmlDNWV1Umd4aUw0Yzh0d0dhWFlrV2xoczk1SVpp?=
 =?utf-8?B?R2xRNnlZZkdnNXlMWkFGSlNYZThsMFRMVWhjbWx6Vm04Rk5sR0pOaE1nOTZ1?=
 =?utf-8?B?em41YVBOd2NqZFhlWWdEZ1hveGoxYXRZRHY1bndHWVNtNVc5T0x2YVRHOWtn?=
 =?utf-8?B?eVpvQ012SGFRMFBpUkV3bHNONXkzQnl4V0swaXVzeFdhTlpSK0ppRFJDTjB1?=
 =?utf-8?B?cW1ORmsvc3lOL3BDVCtEYTBFQ2ZIOGFFT0RTeUJlYzNxVi9VcjN1UjljbXc1?=
 =?utf-8?B?VzY3WW1hTkIxVEcrK2V2Z3FzcFNMMTRUQmNoTDBjV21wU1JRSkxwRGc0SzRF?=
 =?utf-8?B?QnNLaVBBRndPTEYyMjN1OWxLbFBEZGQ2OThGMytxUHhPaDZwNzd0M0VScy9r?=
 =?utf-8?B?b2s1TXgyeFZrdDd6RkFtYWkxYlIwUS9VT0U4V08rQlFqZjRiSkg0NHlkMnFO?=
 =?utf-8?B?MnVMY1huWTZOeC9PcEMvcElaRlR2bDdVVnUxUkpxR08vV0o1VCtLLy95SWgx?=
 =?utf-8?B?SkFOWW01Qk9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHY1VitpT1NJTEVpUGpRVWJGcnBsQzhqdjBuaFlSUFZJd21IUWplNHJYTkg3?=
 =?utf-8?B?c0N0SlRKSGhtU1NCMDlrK2VvbDJXMGpZbEd2WnFjb0JzdGxjWnJNalFoemxn?=
 =?utf-8?B?NzdQZnV0MnpWanZ0cWN5VjdESG5RWEovRFZPZHVxL1lleUJNRTB1QkY2d3BX?=
 =?utf-8?B?NzR2aUlWYTBWSjVwdXZrMHc2TWdYVzlQckVhaFZRcjlteWpzT20zU256L0lE?=
 =?utf-8?B?VnQ2dkxYMFdpWmxsUndKSWF6b3Y2Z2F1OXd5cEo4Q3MrQWFtdUdHT3BjM0Vv?=
 =?utf-8?B?UCtPWk9teWlvZ01ZbmJFUGliRGdiSG9oN1ZJZVNkbXBmYU5xcHB2Y09YUmN6?=
 =?utf-8?B?SFpwSzZ1SllobUlUQWtCbDNBY2x1M25qd2VIU0tZRjVPYy9YTXVOYnVCY2NZ?=
 =?utf-8?B?UGJpOVpKUWxhNWJKR2hVait4bFhET2Mwa1dDVlhSL3Z0a0psNjhrVXkzZjlG?=
 =?utf-8?B?RjAzaUUraDBZcjVqZ2tLUlI4QXl2Ymxkajl5ODd4dHExRXdoVm8rU3pIb3J1?=
 =?utf-8?B?eTJ1SVJJOUpmQktpRGZNbzNBTy9ZOFp2RkJWL21ISUxPYjY0YVYxUlBEelhD?=
 =?utf-8?B?a0dXOE04T0FhWHAwV0tzb1dENm4xUUg4bUMxdGN0bFR5amp2M00wbUlFbTVa?=
 =?utf-8?B?Qkh4S3BCUjJibUJ2YXhMOSttcWE3V2F0aHU1eW4vSnQrVUZKbFA3aEpEYVdE?=
 =?utf-8?B?NnZhSFlmbGhkK0liYzJoblQzZWtrOWxGNTJxRVBPUkVDTDN3T2QrMVRLWHVL?=
 =?utf-8?B?VEhnK0ZrdzFDbFQvK3hiSlMyVnY1T05zQXVubEF3N1hWS0RSSVVMemRYSVRz?=
 =?utf-8?B?L2NKOFRLbUV4WXhBazBMUnFLekhYMWVoMEthbHRNeGtIRFdJLzhCN01MdVo5?=
 =?utf-8?B?aUVheml6eHo3TUVuckFRSzV6aHI0dUJSV3hRY2k1dGtJZStuaEd2eUU3bEJI?=
 =?utf-8?B?LzJyakx5U2VWc0U3bDczRXBlUHI5dnVDSTFneTN5VWNYY09WcWtuTDNQS3hi?=
 =?utf-8?B?YlJLbmsxNDlyaFB6d3c4em9zWFdYZFhxT1JuQlZMajQ1Ky9tSDNSSlpxbkh6?=
 =?utf-8?B?UWg1K3FJWkZ6RzJsWENYVFQ1b3FkQnRUbTFmWmpVcndXSjl6YjhtUXVPWkFC?=
 =?utf-8?B?QjhmZUZqRkYweFVYNWU3Znp5TmEvbEVaS21nYmFvK3JPTlNycTNjVnBPOVYv?=
 =?utf-8?B?U0pURi9Xc2h6cWM2b2d0UGh4T3FJeWdOTFlrUFduMEFIZ0ZPalpUT2VQd0Q3?=
 =?utf-8?B?Z0liNGZ5WGhQZWlLUW0wclViQjYwS1Q4bGR4dnFZU1RhdTBHWm1VRkZsTXBl?=
 =?utf-8?B?VVdwNTFYSkFiRE1lMThDclFvdDlxS0FoMGVGVmFWQnBiVWM4ek4wUGlDU1Yz?=
 =?utf-8?B?YUpPVFNiVmoya2dSTDIzRVVnWEJtNVF6Z0oyM1FhWFlNWEM2RDFZTXcwQm51?=
 =?utf-8?B?RnhkZmhYWWRnaWRrNzZwSjRaL2dScUhaMVExNW9LWkYwRk1MbjRXdnpjTzlV?=
 =?utf-8?B?TG9rNFJEejVTV2xMRGJjbDBsWDBsS3pLdFBRTjdKem0zUU91cVlGQXVzWng2?=
 =?utf-8?B?dnJDREpleWpwQlpKQnpKU2RHRnd5NW13Q2VoQncyc1krSnRERGpVVWdnWm9w?=
 =?utf-8?B?UnE1UFE5Q0VBWVlkME91eVFMeWdqL2RLbDY2MjVyUE83a1lVNlZacnRzOVYw?=
 =?utf-8?B?WS96OE0ySFR0NTVqam5FTHFtMFVUeTg4Y0hZWE5GaWVSNjZTbStrd2hVMmMv?=
 =?utf-8?B?TkwrbllIY1BSTUQ2Qy9JSVU4TlRnL0RJdCt6R2NnTEdLSVJKL0FzZFBDNStS?=
 =?utf-8?B?V0tLdWdzcGlObVJhZUx2QTAxRHc1MzBKbC90eGxSSXc2aWxYYTJrZGQwWFd0?=
 =?utf-8?B?eUFNcGNITzZkMDh3QzZXRitkTGdGMjRpNVBpODZnKzRZMFc5T1RMaHBMcUdY?=
 =?utf-8?B?MDJZd1p5ZzYwWm4vWURTYS93aU9SNHh1Tkx5RFpycHhVQ00xN1M0eUZsdHJy?=
 =?utf-8?B?YldkNnRibzFSOEFIOWFRbDlKOFVsQ2lWRndWQnhKdHFYbXcvcGVMNFNldXND?=
 =?utf-8?B?Sm5KcTl0R2lOb3RjS0l0V3JqSGgyQlZVOCs5OEpJc2t2Zy9BMHE3cldtQytw?=
 =?utf-8?Q?sSRSh6a2qFQoPaQeYPMXIfdqF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e6b892-597f-423d-52e0-08dda4fde904
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 13:27:40.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S94xEMbF0eavO6hGipP3NXGkw4QEF/zsjBpVPldF3caQZIADYJ1c+5ZZJZJGsKTPFNGr0wx9xtKoJ9ue3l+6HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680


On 5/21/25 21:45, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/region.c | 140 +++++++++++++++++++++++++++++++++++---
>>   drivers/cxl/port.c        |   5 +-
>>   include/cxl/cxl.h         |   4 ++
>>   3 files changed, 140 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 4113ee6daec9..f82da914d125 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2316,6 +2316,21 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>>   	return rc;
>>   }
>>   
>> +/**
>> + * cxl_accel_region_detach -  detach a region from a Type2 device
>> + *
>> + * @cxled: Type2 endpoint decoder to detach the region from.
>> + *
>> + * Returns 0 or error.
>> + */
>> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
>> +{
>> +	guard(rwsem_write)(&cxl_region_rwsem);
>> +	cxled->part = -1;
>> +	return cxl_region_detach(cxled);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
> There's nothing "accel" about the above sequence, it is nearly identical
> to cxl_decoder_kill_region().
>
> In general there does not need to be a parallel universe of "cxl_accel_"
> helpers for Type-2, just use existing infrastructure and maybe enlighten
> it a bit to accommodate a Type-2 nuance.
>
>> +
>>   void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>>   {
>>   	down_write(&cxl_region_rwsem);
>> @@ -2822,6 +2837,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>>   	return to_cxl_region(region_dev);
>>   }
>>   
>> +static void drop_region(struct cxl_region *cxlr)
>> +{
>> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +
>> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +}
>> +
>>   static ssize_t delete_region_store(struct device *dev,
>>   				   struct device_attribute *attr,
>>   				   const char *buf, size_t len)
>> @@ -3526,14 +3549,12 @@ static int __construct_region(struct cxl_region *cxlr,
>>   	return 0;
>>   }
>>   
>> -/* Establish an empty region covering the given HPA range */
>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> -					   struct cxl_endpoint_decoder *cxled)
>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>> +						 struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> -	int rc, part = READ_ONCE(cxled->part);
>> +	int part = READ_ONCE(cxled->part);
>>   	struct cxl_region *cxlr;
>>   
>>   	do {
>> @@ -3542,13 +3563,23 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   				       cxled->cxld.target_type);
>>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>   
>> -	if (IS_ERR(cxlr)) {
>> +	if (IS_ERR(cxlr))
>>   		dev_err(cxlmd->dev.parent,
>>   			"%s:%s: %s failed assign region: %ld\n",
>>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__, PTR_ERR(cxlr));
>> -		return cxlr;
>> -	}
>> +	return cxlr;
>> +};
>> +
>> +/* Establish an empty region covering the given HPA range */
>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> +					   struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +	struct cxl_region *cxlr;
>> +	int rc;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled);
>>   
>>   	rc = __construct_region(cxlr, cxlrd, cxled);
>>   	if (rc) {
>> @@ -3559,6 +3590,99 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	return cxlr;
>>   }
>>   
>> +static struct cxl_region *
>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>> +		       struct cxl_endpoint_decoder *cxled, int ways)
> What is the point of an @ways argument when @cxled is not an array? It
> was an array in the original proposal. Recall that this interface needs
> to be useful not only to Type-2 but also the nascent CXL PMEM case which
> will likely need to create interleave CXL PMEM regions from label data.


Yes, you are right. I'll fix it and add the CXL PMEM case in the commit 
message.


Thanks


