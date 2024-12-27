Return-Path: <netdev+bounces-154335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD1D9FD19D
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 08:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A49918824C3
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB98913212A;
	Fri, 27 Dec 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JZft87Hz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC11876;
	Fri, 27 Dec 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286006; cv=fail; b=KMsSWWUt2lqUVhUWDmTxgUxgOTmH+EeUmjMgZnbeI0knvKYCo2PrBgNyBxtGe11Wp7Iq4rJOg/v//sZGBn39wM3mCFztm7M+KxKQLSGR8pIGflIBEWk440VvM7d4GbJl4M0CiiffO3UWep3tDZHlluHHDfrITP1QUDJpx0UKBvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286006; c=relaxed/simple;
	bh=oLsbPhGYTRIwGCZOUDECEFpMwJL5q7x9/7T3jawPduY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rd1xuo2nE6OONadoazNIVyKVkqJvTDYLpRVdY9+y9X2lHl6wLoRt18BMO3S0sY1Auo0SkHlhpRvjY5tEzAL1sl2TL5+3Dql07Pt8qn3/KPnJuqoPPPK6or6oOcvE4mez5RxpZUbFj9A951xUdaO42sYcMR/LLcxSDnqBarwYzpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JZft87Hz; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZamNB0tgF9Oo0wXKgjIsQeo9ne1vgtLNxp6dHWiwn7zG+7h8Kr/kBBNpQmngdhwI4PH1b+yq70WUvHeX+9VTEakcTlWJxksAGAjP4Bu/O8EbPYlmftPu1iQFzbppEy0RlD5t+cCrspeINdpP1gVt9uB8MLqAv3p8cY5qsZQS8p+oV787HrDNrQN1DXTgKbNGWqtmx1wgTlOZGM0HKfkSyuYu5YC61j9QehNpZ71Ag/pivkVWu3xBOpEHcAi0NWqJG7Qpbja31Gxo5lfm74fYnHBE8a+waMeqftz1nIhduHMtO2iUkUgs2yV8Ha7pDlECWR2jBsUxQ95IBzLhQrdDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HRGJ7tJ3ig/wfQclFFboUly9+8t1G1R+ZHmQcoE7Bw=;
 b=h/cMnX8WyrbtcuFO3t/tW3EjfH6ABz4SNdpbSfu5Y05u4p96mm39jvXiNnvUzU88j/wRagKcupU1za6GxS84RBhkkPF1f7fvEOTYmnm6LQXOKGbbiOJamH6rdAVLKcGhMhSj6y0wglOomKi5UKOU+KKzcmEwcicwnBm2wqagO0xVGNmn8WXdQccNdEpQ25ijAZeYJKn4EBVKocrWuykWsvRHnqYoLDlYvPz0HweArPy/4me+Ov0RC3VyWNZx+Zt666osXWkMVVDuEEA4a8fN3vYC9q1d+2JuFyEtfzT1i80Q9iFAbbR98HT2YQ926B1q86kRO7XHhEPH/fxjZ+Uq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HRGJ7tJ3ig/wfQclFFboUly9+8t1G1R+ZHmQcoE7Bw=;
 b=JZft87HzlzXJwxM8XMF1UP1eTWWC4IjDjamQaTpMHEtsve/NV+Qb5odrZLUfNLVwF5iYSC9F+glwPObaI8EY4mbXZkYEIUN2dTCuyBi6dAh8md9tG4xz/xsMHEdOiGnSlExRdeKJ4gabDWXz8nQKVvicgk3GDHIQpsyfiI4Y8Ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Fri, 27 Dec
 2024 07:53:18 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 07:53:18 +0000
Message-ID: <32daa270-bcb6-cb2f-b916-aaa4b9ee895c@amd.com>
Date: Fri, 27 Dec 2024 07:53:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 05/27] cxl: move pci generic code
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-6-alejandro.lucero-palau@amd.com>
 <20241224171943.00000bec@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224171943.00000bec@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0061.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 1283051a-6548-4723-8024-08dd264b8679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0szTzBob0NzVU1ad1d5c1hkYmxqSmM4bExYZ2s5MlZuTWNLMVRxQkY4c1Ey?=
 =?utf-8?B?c0hZN1VpQ3QyN29oY3NBYnV1WDQxRHB2dmRpSFFvZHI1c1hHbUVUOUNRUXZr?=
 =?utf-8?B?SGZvaW9UbjVFOFUyK0R0blB5UlpwZlJDcUJpL0xtWHZhSENsQ09zN0pCdC9O?=
 =?utf-8?B?aVVLb0NadlpqTFBGUzNQWmhRcHo0SHlJU1dXTkxSV2dQMHJhMFNSbVc5eUxo?=
 =?utf-8?B?aXRRaXVyOFptTTZ5aHprbzR0V0VDb1crSExWbTN4eWVUa0wxV3hVK0NRS0Jm?=
 =?utf-8?B?L2RoeGNVeFVhZUxVWmdtdENCNTZ6NmVlSFVvVXpiTTYwWit6U0dYRG8xekpJ?=
 =?utf-8?B?TXpmbVR5ZnB6Q3ZJaUxiVGkvQ0JkUVYrekZQQWVKM01zTlhTcGx0WE5GTVNO?=
 =?utf-8?B?cDlrNml3ci9JV2hHS2luR0hkOWdvWmd0S0tId3I4cnQ0M2RrWUpIYS9vNWhQ?=
 =?utf-8?B?OVBpR3gvM1lhRGphQXVBSE9MYzhUVUU0WXRrc0hQRnRJR1BCcWNuMEpJejhO?=
 =?utf-8?B?K3J6d2Vxa1c3U0ZURE4vY0twMG1rS2o2UWlPK2xrOGt5SUQ5YjRncVFNamV0?=
 =?utf-8?B?QnZPVVhKVEZWMmd6VmxtZDhHd0RGSHJJM0MzNVdkRXh2ZDRubDRYQWpPdExZ?=
 =?utf-8?B?QU0ybTdKVW1MclFTeStWMXIwNUhxbjAvYnFTell2dGc3emp4bVFWaVZISXc4?=
 =?utf-8?B?NnFFM2FPZEFGRGxrdFVkQUd0QmNEUFBTY0t2Z3YzUUxDL1hsWnBxWTVjV3lV?=
 =?utf-8?B?NTh2cyt6eVhmQ3NyZnBIK1MrL0R4OTNmTXRwUGgzbXFMaDVCSEgwRlowSFU3?=
 =?utf-8?B?OWt5aUlYL2NrUjZoVmFuU2pzWUVJdnZibVdhNkFlWmhxaWU3WVhUejZ6VHR4?=
 =?utf-8?B?a3NBbk9jbFFtWU1EMDNNMHFGY1N3Q1o4N1drb1FqMWg4RzJrOGlHb3VyVnQ5?=
 =?utf-8?B?aTBHSS9ySjVJaFdyYU5nQTlzZFZUZlVhUHcwSFBFQjdNaUdRdTlsT0Y1UzZN?=
 =?utf-8?B?Q25uSHBpa0RXYk5WVkRZeVFGSkYyZFBiNVRQdStmRFdRWlNaYkhXNmxCRnFp?=
 =?utf-8?B?MlZySVNma3dzOWNkcWY0amQwU3RFQzV1NjJ6eTJ4c0FDVE9PQnN0UCtvSFZL?=
 =?utf-8?B?UVpYVG0xSmg3bHRXMFB2YUZnRkZxNzExbHpLdE5aeHhBN1ZRTXZrSVFOL09J?=
 =?utf-8?B?S3FjN09SMThTMHo4b0Q0dGFvYjUxOEdSZDcrMjgva0tRNEY4Sk9tanlRRURl?=
 =?utf-8?B?MWpBc3ZJVmMzakI3bTlaZU80Z3J2QysreXFsT01jOTBVUVFmdkJreHlBcmlJ?=
 =?utf-8?B?cnF0MyszaXI5UEttMHlmaXNrY25HS1d3QVVSM3VHeHBwdmFqWXBEOEZsUXYr?=
 =?utf-8?B?Q2d5aFVYNzl5NzBsM3I3eXNJcXhsdGNSVmZteG5pQUoxMTIzMm0vVnFRQVZH?=
 =?utf-8?B?aC90d3BZZTdEQ3R5dXdaNlNGWWhLWEY3RXlpQzJpV0JrMUhoSytnZnVSNWNE?=
 =?utf-8?B?TFFCZ0ExNEpJZVFRZ1dhUnVYOW5FcHZlZjdoZDA5V2dQRktPV085aDRFbndr?=
 =?utf-8?B?L0xOSWRSd0N2T2JwWGxFUE9tUkJjbDZvOTVub3JEM0R5aCtQMVV4V3JRbG90?=
 =?utf-8?B?OURlaCtCSlM0MTFEOWw3VjdOMGlUdjhhcDRjYlJRS3FEOWtSaTdUelFvVk41?=
 =?utf-8?B?OS9oMjk0dGcwYTRSdVk5ZGRoNzd4dkhRbkV2TDMrcTlkTldZUjRCQ29heFVj?=
 =?utf-8?B?Zy9aQnd1MVZTNVBRUHJmbjYyT2UwR25GRHkySjdIUGRTZHFxVmoyeDRhbVZE?=
 =?utf-8?B?bURpbDhiRlB6UWhNUThYcDdPVFRLSFdmWTZOUndjNHBXb1RsOU12QUVSQVIw?=
 =?utf-8?Q?bm3POduLghAkY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXNQcFg1UC9Rd1VvWmlkOTVsR2Z3L3lCMnFWeWxmNjFrVGxhcjVoYTNzclVX?=
 =?utf-8?B?WUVjM1NRaHJjTDQ0OElMclVWZkRCUE1RcW1CbWN4ZFcrN0g2bEhxZFdtbUpC?=
 =?utf-8?B?bEd6VXR2bWRtWWJzZ0dhMUh6ZEUyWlJERno0RFN5TG9qckRhN05IcVRvSWRP?=
 =?utf-8?B?QS94S29POWJKYnVoY0p0SjgxYlI4Wk1zZ2xpNnlpL3V6VzdtVGFBcU9hMlB5?=
 =?utf-8?B?UlVMaExsa1ZUbXhPZk9lMVNxL3JqZTB5V25kMzU4N0xienJZMFhuQjhsMEJO?=
 =?utf-8?B?MjJMUHRLczd4czduUWhxdHFWNFVwcnU5L0xmZ2hyOUpHY1hQZE51eUZtd1Q5?=
 =?utf-8?B?YVpvdGdZYmg3c2E5cGhpLzZNMUNXbi9Cb1ZyWThSekFsaFFvcDFmK01STTc0?=
 =?utf-8?B?MEpMV3A2OVRmM3B3VE5BcFV6MmpuaGtCWVVkTUpqR1J1OW5rNSt6Tm9SYjJz?=
 =?utf-8?B?eExaQ1daYXV2MFM0T21mZGEyU21qU1hjeENIYk50WVNyS01XRG1zNmpqckdV?=
 =?utf-8?B?cmM0aDBIeEIxZXF2SFUxRHk5UkIrZ0E5VFcza1F0eTlicTFqUTRkTW5WUUVG?=
 =?utf-8?B?Y0trU3UwMDZnR3NXK3JpeXMvODlDenRYZjhGY1Z1U3JPWW9sZTRaVHFUTTM4?=
 =?utf-8?B?dHM0R1dNby9SdDI4OFRyWnJUVjN5TzJXajFGdTdJNVNKNDliOFFOZHk5cnRW?=
 =?utf-8?B?QlFBWVBpNkNYRHJNY3V3S2lKTjI0ZkVoaTc2bXZzOHducFNnMjJJUmFOckdN?=
 =?utf-8?B?bUF5NkRnT1c4cG1ISk1Qd3kwU0Z1WlNuOFp0WTE2b004RVoxdXJQcU1qejRv?=
 =?utf-8?B?ZWhVdFdqMXErQnU0RlJtczAwSEErcnpLdGJ2dzgxTzBnT2tQaU5WZkt4dDEv?=
 =?utf-8?B?NmhDbTJnSm93b0RyVFR6WENaM2xuYVROV1N2Z2p4UUVBS0kyaS80Q3lJUWdU?=
 =?utf-8?B?Z0JXcXVJcDViQWIvdEtyVTVoNnk3MXZDMExpVmUyb2xBZWNneUh6UGRTaitw?=
 =?utf-8?B?N2lsMHRUUEZlWXc4NG0wVmRpWVNzSkhnSVpjOGMybHhUb3ZVZWFLSlFKbGVL?=
 =?utf-8?B?dnYzdHVra0lBbjNvODZkdXJ5cnJ1TkpNSkJhS0RuUkx1RTl3bjhKSGFOeUF3?=
 =?utf-8?B?Y3JPUndBQ0RpRS9QUjlXTjV4TE9CV3JNYjcxUk1URmdibkh1bXdJZ3B3V0cy?=
 =?utf-8?B?YVFQcVJzRFVtV2Z3VC84Ui92WUw0Um9BU21Xc0VrdGYrUDJmWWVlUmZZWkZV?=
 =?utf-8?B?TkF5VGUzM0FVSzFsYXExbWo3N1Q2YlhZazJxc3BITUZ1UCtoR21TajJQZEo3?=
 =?utf-8?B?RHRITHpySVp3K2RKeW13WUNhcnV3Mjc0NmJkZSs3VWpCeTZ1eG5MdEx6a1pM?=
 =?utf-8?B?ZFB5RWxZcG9xSVhOcUZXK1VGeENMZkpEMisrQkFGWUVFWFBXcHVDa0ttSkhn?=
 =?utf-8?B?RnE5YnpKUEJlZm9PNXdvZVhSWDZNY2l2K2pQR2M1ZXVxSUg2OFhGd0xSNXRU?=
 =?utf-8?B?eUFLeDAxOFNnR2p6VEY5SzlIKzlVeFlRVmRkQzY4UUY3RXdXdDdEM1JJS2Zp?=
 =?utf-8?B?d0o1Z1NsWWVMeWdxNzhwSk1VczYyNm45RFcvODJrSXZiWXpqVGU3bUtXSzh6?=
 =?utf-8?B?SXQxSUtHeis0NW9FNVVZSjFtdEdXZ0lsREZDYkVPSUE3bDRnay9PZUliSktU?=
 =?utf-8?B?VytIWkFlaUM4UmxNdVpoUWxVMTJDNHd6N09nOEV3K2s3QnhuelpvMk5jcnNY?=
 =?utf-8?B?d0krbXRKYXJGMTh1NEdqVFprT1Fka2M5QzFwZW13OEo2ZUVDclRRZDRmNnZ6?=
 =?utf-8?B?OGxRYlBUWTBWZC8wL1FJaHBJUmdjZ0l1TEw4MzFMWFNtNUlTWDJIUGN0TG85?=
 =?utf-8?B?dHBZc0tjT2lHeFZlTUdkNk93cHNKRThGaXROYUhHQVNzdmVsUHpWa0RkbE5p?=
 =?utf-8?B?enNaZVp6bzFmbmxmYm9Pd3ZjNk81dks5aU5lZndZWVVIMkd3NGpwVWhDSUNW?=
 =?utf-8?B?M3pSYmRHNCtMdmpwd1lzSFV2QW5KUUppaDN3TVBMWldOdmxhVzJCbmRTR283?=
 =?utf-8?B?U2J2TDRKejZteExQZ1ZlYUZxZUNWWks1ZGtyV0ZoQU04V2w1MDdkUU03NXFj?=
 =?utf-8?Q?oUi4xoaifZKuwNKk8KJG5VxRg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1283051a-6548-4723-8024-08dd264b8679
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 07:53:17.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSVcVW4abdzWGyE0IsUSRnN3L0Dt6EGTKAG+qFZMQmT7rDcOEoRhWX4GfZ1qUbQyCudt/28vwSqc7x1cGu5G8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377


On 12/24/24 17:19, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:20 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
>>
>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>> exported and shared with CXL Type2 device initialization.
> Rebase gone wrong?  What happened to call of
> cxl_dport_map_rcd_linkcap() in the original code for instance.


Wow, not sure how this happened, but thank you for seen it!

I'll fix it.

Thanks again.



> Jonathan
>
>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> ---
>>   drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h   |  3 ++
>>   drivers/cxl/pci.c      | 71 ------------------------------------------
>>   3 files changed, 65 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index bc098b2ce55d..3cca3ae438cd 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1034,6 +1034,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
>>   
>> +/*
>> + * Assume that any RCIEP that emits the CXL memory expander class code
>> + * is an RCD
>> + */
>> +bool is_cxl_restricted(struct pci_dev *pdev)
>> +{
>> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, "CXL");
>> +
>> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> +				  struct cxl_register_map *map)
>> +{
>> +	struct cxl_port *port;
>> +	struct cxl_dport *dport;
>> +	resource_size_t component_reg_phys;
>> +
>> +	*map = (struct cxl_register_map) {
>> +		.host = &pdev->dev,
>> +		.resource = CXL_RESOURCE_NONE,
>> +	};
>> +
>> +	port = cxl_pci_find_port(pdev, &dport);
>> +	if (!port)
>> +		return -EPROBE_DEFER;
>> +
>> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>> +
>> +	put_device(&port->dev);
>> +
>> +	if (component_reg_phys == CXL_RESOURCE_NONE)
>> +		return -ENXIO;
>> +
>> +	map->resource = component_reg_phys;
>> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +		       struct cxl_register_map *map, unsigned long *caps)
>> +{
>> +	int rc;
>> +
>> +	rc = cxl_find_regblock(pdev, type, map);
>> +
>> +	/*
>> +	 * If the Register Locator DVSEC does not exist, check if it
>> +	 * is an RCH and try to extract the Component Registers from
>> +	 * an RCRB.
>> +	 */
>> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
>> +		rc = cxl_rcrb_get_comp_regs(pdev, map);
>> +
>> +	if (rc)
>> +		return rc;
>> +
>> +	return cxl_setup_regs(map, caps);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>> +
>>   int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>>   {
>>   	int speed, bw;
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index eb59019fe5f3..985cca3c3350 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -113,4 +113,7 @@ void read_cdat_data(struct cxl_port *port);
>>   void cxl_cor_error_detected(struct pci_dev *pdev);
>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>   				    pci_channel_state_t state);
>> +bool is_cxl_restricted(struct pci_dev *pdev);
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +		       struct cxl_register_map *map, unsigned long *caps);
>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 1fcc53df1217..89056449625f 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -467,77 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>>   	return 0;
>>   }
>>   
>> -/*
>> - * Assume that any RCIEP that emits the CXL memory expander class code
>> - * is an RCD
>> - */
>> -static bool is_cxl_restricted(struct pci_dev *pdev)
>> -{
>> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> -}
>> -
>> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> -				  struct cxl_register_map *map,
>> -				  struct cxl_dport *dport)
>> -{
>> -	resource_size_t component_reg_phys;
>> -
>> -	*map = (struct cxl_register_map) {
>> -		.host = &pdev->dev,
>> -		.resource = CXL_RESOURCE_NONE,
>> -	};
>> -
>> -	struct cxl_port *port __free(put_cxl_port) =
>> -		cxl_pci_find_port(pdev, &dport);
>> -	if (!port)
>> -		return -EPROBE_DEFER;
>> -
>> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>> -	if (component_reg_phys == CXL_RESOURCE_NONE)
>> -		return -ENXIO;
>> -
>> -	map->resource = component_reg_phys;
>> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>> -
>> -	return 0;
>> -}
>> -
>> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> -			      struct cxl_register_map *map,
>> -			      unsigned long *caps)
>> -{
>> -	int rc;
>> -
>> -	rc = cxl_find_regblock(pdev, type, map);
>> -
>> -	/*
>> -	 * If the Register Locator DVSEC does not exist, check if it
>> -	 * is an RCH and try to extract the Component Registers from
>> -	 * an RCRB.
>> -	 */
>> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>> -		struct cxl_dport *dport;
>> -		struct cxl_port *port __free(put_cxl_port) =
>> -			cxl_pci_find_port(pdev, &dport);
>> -		if (!port)
>> -			return -EPROBE_DEFER;
>> -
>> -		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
>> -		if (rc)
>> -			return rc;
>> -
>> -		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
>> -		if (rc)
>> -			return rc;
>> -
>> -	} else if (rc) {
>> -		return rc;
>> -	}
>> -
>> -	return cxl_setup_regs(map, caps);
>> -}
>> -
>>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   {
>>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);

