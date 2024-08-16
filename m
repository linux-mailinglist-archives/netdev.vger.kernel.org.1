Return-Path: <netdev+bounces-119221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EA5954D46
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED091286D33
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E932BB1C;
	Fri, 16 Aug 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2U31AfM6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC61B86C0;
	Fri, 16 Aug 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820263; cv=fail; b=T8Etl/TCkPKm8xcJfCcCD/PvdnDdUgI5ok1h20X2D52tVizoVt2tV77JMyj61ZDucnBf+wEXt1kS/sKyZnhV28l9l/mAP9dli77XVkTKzJfZl3q4zFqrcO0nIkW+ZHjI9SCa7gIe60aOiw0QmQFBH1YZLD1llCfQe7v5sJkj86s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820263; c=relaxed/simple;
	bh=rt0TgB4HnUZi7l1l6VVfMRUddgzXDweYsRwpNESAbls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1EgEAjSh4QCuG17a+nBSs2PXnc58X9YeQedG11wFEfNOgKMlgf46gdUVH2zClwv3EWnfagRd3iaSE48Ozxue/0Zq9XUauaWpPpfcnRBH3XKWFA8aU9TpBvyMeltqOMXukewZcXd81jYe/S6W2jzDd2Bsktcf3uEH5kDg/DnqtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2U31AfM6; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVo1vbP4d5eD1FbpC3hFHcHiuMfV/DPH9L2vyUcyx9H8RDKblzEC2pJ7slSBckS7ffey9riat9hm+hPyPa3GRAFBwguVKmZoFR68FuQQM938eU6jt4LOAoMyxMJqW+qigzFngzQLO7gEm9hkxIPk2QQoNKZyYZw+R2zx7RjAHTFIPgHT/fbvcoZm8eiv1w+LotEXz1VrhOdaW7zbuWhzd5/sof06XdU2RTripOgfulSPVGzTaUotrSGdHeO1JtcIJUS4+6t29/qWqvY/YhIs5+foYnBAdtEZEeiyp1SLQI8A9u/vyvqEtxA1kSSEyArGSnZsjL8+08VJBZUYHM18LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/REGhs0WSXrR+WKSEvyPXuNox9N7hk5m/qLykCzD+ss=;
 b=hJF9R6XC7IkoPtb0zuh78863YZSR+1eToR5OwK+bH21fVYUbAfyDsAHmlP4dnYy3v3P/hMfM4FEsBNapVTkDapVZ0x1I6T/xFlQqn+19S3geO4Ky9i/Ykg9rAwRpmCOZ9GfNiOPjCMgIEJQ/IEYo7qVbd+7gK88m9uR4BtZGvKwz95mctG7iiODzqK2+CqOB+wPiqnqwwRH31P9MXig7sRAPqWoqYO0qHw4urvb6pvW0yFS40ZzItNWsYirZXFaObME6czMAklY6Cx76jBWlBJWVJoscmgxNJGWUlDCUvyNuyo7UDfKC9LibA35PAQbTgrtfn3p5MwRLLkKDF0N6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/REGhs0WSXrR+WKSEvyPXuNox9N7hk5m/qLykCzD+ss=;
 b=2U31AfM6erNwbpwGA2m4b5DW0t2BtIZCDhooaFrCzqgKbyFzmUkuLOIK0Pz8tV6KRpMid81m08dmfDIlITbFVQA8txH1PrcLEONpSMCy6h2OyYWdhTgxEQZNVEWg371uAiWdnCA6r4LbjTl8/97LFkNJ+oYLwSDuOKjZRj3TSeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 14:57:39 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 14:57:39 +0000
Message-ID: <41dee583-c5d5-a4f0-cde2-7e0e550ff05b@amd.com>
Date: Fri, 16 Aug 2024 15:57:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 07/15] cxl: support type2 memdev creation
Content-Language: en-US
To: fan <nifan.cxl@gmail.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-8-alejandro.lucero-palau@amd.com>
 <ZqFy5Qsg_uLncLRr@debian>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ZqFy5Qsg_uLncLRr@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c8f523-4e50-46cc-048e-08dcbe03c583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlZnRFd4LzRHZ1hsWHNJaVVRTFJuZ0I2cUkvSWsvampDWC83NWdRazkvWFlj?=
 =?utf-8?B?N21pWkdINks1cXluQ2RNbHNTbXg2OWVuVVRJbFNSdUJJQy83NHdoeXB0aXBC?=
 =?utf-8?B?OW5TaHlXeWFIdWlOb09lczhUNzMwOUZsVVRVajZTcEVmQjVsQXpYVU1GdWdN?=
 =?utf-8?B?aTRKTHR3YjFqMm1BMTltNDQvVHMzZElNblh1MUpJMUF2VkZwMjVKc1dOL3Va?=
 =?utf-8?B?NEtxTGMvNUNHVTVaTUZpUHZoa1dQRWlNRklPTEJYRFVBbW1NZlh5bTNYMGJO?=
 =?utf-8?B?U0ZYY1JORnpyKy9mOWo0SVE3ejFLWHprbXNuME1iZ2pZLzlkOTB5OElLWmps?=
 =?utf-8?B?NVhMK25pUkp4Y0tSK2hkWWU0RTNHZmJiOXY5ZVQ2L2RuQWc1UDRtS0YxNEpU?=
 =?utf-8?B?a0E4QXcydWEwdlA4QS9DSUFoeVFQYSt6VDR0RER2UHRGenl3VElZWUF5YnlL?=
 =?utf-8?B?cFRobUlIQkZuOTc3OGMvUlBsbXdESENIYXRIMHhvOEtRZFVPdWRGb2Z5WXlk?=
 =?utf-8?B?azQxcS9ZbHBSa0xzS3hKdVlJeGxlZ2wwN3p6N1lpUG9ONllJa1Jqc0VUa2w4?=
 =?utf-8?B?MWpuOXhTeVE1RHlTNHptdExheDIzTUZ6VmhoVFdWM2RjdDd2T1EzVWdsSUI1?=
 =?utf-8?B?b0tGdGlxcDBkOWhFNFFHSGh0ZWFmeFhMQ0JFNE5hQmUxMUJnL0FMeXU4aGMx?=
 =?utf-8?B?SXdpd0hVTWdYeTNoMUVSZDNWZWZlU1RoaUxMQmF1YWZrUEp2dHdmUXJ1QjFK?=
 =?utf-8?B?anczTHZhaGhBY1RxOVZSZEkyaUwxdDZkbG1xcUQ3YUNPSjJReTFad0h2TDJF?=
 =?utf-8?B?K2RJbG83b2ZNSjdFN2xZQ3lWOWFuWWZtN0xXOTV2WUlWSnFVYk1vb3BGU29z?=
 =?utf-8?B?cVNaR1FLYXdUSGV0SzlPNEhnLzdjRlFYeTJjVUJRNUltdFZmdTFzSHV2dUdP?=
 =?utf-8?B?OFNPNTVaUDcxSUwwd2llYXZNRzFBaTZERFFkU0xmMERGeWltOEhRNnZPeDhY?=
 =?utf-8?B?ODJzOEdEeGFiVmV3R1hqQzYydVVBOHFLU1lPVmV4elcxRTZGTHlVdG1JQUFL?=
 =?utf-8?B?dEVJOElVQkNJcU00MTV5TytFbFMzVVZ6dEJRMkdRZVdZQTFFVXNWczlZNDEw?=
 =?utf-8?B?elplYXQvcFAyT2JzbVpPc2Ric2FsdlFkaEJhNjVjZmdpM1hrenpGUjV6cU9r?=
 =?utf-8?B?QmxIWFBRTzFSWVo2cHhxVzg0QjVYOERGR09HcSt4bGs5bTZJaFVTWC93dmxC?=
 =?utf-8?B?dkhlWG9HOGd2bmNXRXk5dUhoMDc2Q1VoUVByQlVGWm5hRFpYN1p1MDJHT1B2?=
 =?utf-8?B?a0lMbWF6QW4weG9DU0ZBbC93MnY2VmdOa2hicDZsODFtMGc4Y25WSUFwZlgw?=
 =?utf-8?B?Z211aWE0Tm4yZEdpcjkvaFB5cFRpUW9LR1FTdVh6TGNLVGd4WElRT0IxWVN1?=
 =?utf-8?B?QXkrdnlCNXB5OFpvVzJYUEZFdmwza1BBYVo1WWZId1VFRlh4emdZeFcydXZG?=
 =?utf-8?B?WHJ3RnRwdVVJeGt4U2tIYWFHaEdmMHV3WUF5OE5YVFdxZ0l1SG9mS3dpZi9y?=
 =?utf-8?B?RExLWG95ak0xcG1JaEt2dU14M08xYTlrWUpSa3ZlQ2ZweGJOMWpBOTJUbFZj?=
 =?utf-8?B?ZjFHNHpya3VoYWkwb2JudEFZaGxqdlRhUUUwbWg4bXNTUktmNk9ObGdDeTl4?=
 =?utf-8?B?Ui9nc3A0U1hvZ3lSdDJ4eFVQM2w2NjZteXN0dzNVTEVRVGpQOW9MOUhEakdt?=
 =?utf-8?B?YW5yNHhsQ25Eak56RTlIemFnUFIzSlUxNjV4aU5uMGEzTjNkT0I1dWNTcit4?=
 =?utf-8?B?UFh3ZkRWM3RoM2twS3BpZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlRGVkZnVHhaOTVvOW5YU2ZGcFdKZlJZcGhyVGVhcEk5V3VJZS9XVGNrTWc1?=
 =?utf-8?B?dVJlMU4rcTZBN2pNdzFWMVpDenJJUjJRbS81bFZUY0JlYWV2TXVuZlFxZkEx?=
 =?utf-8?B?ZFFWbG5hZ0p4T3UyNUdaTjFpMCt0SDF1VFQ0cDVKcWN6emRQamhTNkxDNExI?=
 =?utf-8?B?aFdUVW4yZldUSVg0dlJmZnFWaUpnZ21QT1FMVGpLR0hLSGdpZTNtMkVySk1a?=
 =?utf-8?B?M1ZERXpsWC9PWm9kekE5Vm8wRnlqVmNlckdmWStwSE5LR1UwQSt3bHRJWlFj?=
 =?utf-8?B?SHVMM28zK0lKalZIcjdnVzhIdlpFL1N5dGVSSXpjSC9vVW5pSlZSalpiaW5x?=
 =?utf-8?B?cWRZSVFOUmVRc3ZYeHhOSWF2NnNFQ0NEY0V6b3ZLM1hKQTlqRGxwekovbWVn?=
 =?utf-8?B?TE1yNnE3T2RrVW84a3FVK0NEZHZJVW5Ka0c5bG55VHRXS3EvNWVycWIxdnhK?=
 =?utf-8?B?eEFydGxSdlBZeGJCZityWHJ1VlhFQjVOK1o4b0Q3ZHNDUEg2eVo2Ylp2cm9K?=
 =?utf-8?B?eGlPYVRmSGFYRVU2ZFZ1ejQyU3VYaHFqWE1POW1TVUc2NS82M0x6NDgyNTFM?=
 =?utf-8?B?YmpGN3pvSkIwcURDdHNiNk55VmVZQmhneDUxbzd2VTlzc2RaS3ozcngvV1hn?=
 =?utf-8?B?OFhFMmxjTDVUU0ZZTjEvY1l2cE02L2YrdC9aNTNUeUw4SlVXN1hnZ1JIRVdI?=
 =?utf-8?B?QjBnRHloUGdaU1ZaUDZSNXZFNXhHZ3lBeWU4SWtteU5PVlM1UE05SUcxM0RW?=
 =?utf-8?B?ZTkxek84VVV6VjcyRTZMWmQySERPbEZxc3JBMUxNSWtaamszRzlEWFZqdHhD?=
 =?utf-8?B?dzBUTWJuWHd0K3JIZFFycVlRYzI2ZVQ1TzJCMEJNQUdKVFJZcTN3K1hRNXNQ?=
 =?utf-8?B?VkJoaTZMdUQyN09HK2FhNDh1bDdJa3J5c3BSb3NTUDFhV0RCa1Z1Y25IR1d3?=
 =?utf-8?B?ZlFqMklVS3dqVXM4MXlnc0pZMGZVb3VrcVBBaC9MMTladlZvWUdIV0pOZzNs?=
 =?utf-8?B?WmVsMjh6eitsY0h3MHNyZGpnclg3UlhNYTRSQTd2Mk91eitlaUNjYk00ODBk?=
 =?utf-8?B?OXZiMWxXcFBFQncwbkZqcFhjQUFXYnNpaFFyWnFxQWtlbHQvS2NkZVl0ZW9k?=
 =?utf-8?B?ZzREWlhkY0dsckZtSWRWM0RZL2ZicEVocXF2cXczb1dsNDl1eURRUnU4dExp?=
 =?utf-8?B?bzh0ZUFLR1VSMjM2SXVUTkllT2ZiNnVlU1RQT1NqS3hOYks1TmwyREVwdTZQ?=
 =?utf-8?B?dnc5L0NsNm1CN0hCQnltK1VEUXE4K0JKSlFzYTIzdGs1S21Hd1dxejVuT0tE?=
 =?utf-8?B?enZMY1ZrSVd2aUFzSytSenAzMDVkdm5GOVp6bTJqVHpLc2lUSWlSS2xFUmlL?=
 =?utf-8?B?d2NqRXpuZUxuSklNVzV4YTNKRkxGNW5pVTU1bDdBT3lUMENIRE5wVTV3RXk4?=
 =?utf-8?B?VGpRRmtObzhaNW8vcGRvcDJkdm5BYlZ2eVRmcit4d3laWnJQSllkRCs1S3hB?=
 =?utf-8?B?MnU2SXlHYUMrNDIvanNnVVZ3cmxPeWtEYm1zZ2g4ZW11KzBLZTB1Z045Wlc1?=
 =?utf-8?B?V0x0WkRHaDZQSXBzeTdOSkY0SXdaaXE3VVBRaEgzbFBnUm9mbjR4cWVPcjQw?=
 =?utf-8?B?YWd4djNhQkdUM0xncWNETEwwNFk3L291SjJDY3QwREg1YU05c0JFVmhUUllw?=
 =?utf-8?B?Ty9QS1pQZGUzd3hjZjFFUDlHemhXWVoxczBLcE4yOFlrelI5eit2YWZ6Z1VB?=
 =?utf-8?B?eC9FaFRHL05Yb3lqRjAwS1BWWHZmbG01dFhZRnFBYjJNSU41SXcwSmVDakFU?=
 =?utf-8?B?T0o2V1pybGxyVWdpN20wdHJUT1BJWGJsTkdVQVhKc0VGcHpha0pDakxEdnNG?=
 =?utf-8?B?TG8zTDlpRTJQeEhhbitHOU41eXBDTjk0elZLc0syME1tdm1LdUQrdjl3VGN3?=
 =?utf-8?B?aWl1WTdhOVZVbTFaU2xycUIzTSt2cWpRVGZZQzlJeGlWN3poMXdsTy90cFUy?=
 =?utf-8?B?SkI2dXVuTlNVcEVTUnFEaDlEZC9yY1Yrb1NOU2paUzVFdC95QnNQUFZpM0Vu?=
 =?utf-8?B?Zm5uVVJCSlVSam5uaVlPd05US3dQRzJodUtuNmlsZG9mMTRhdDhkOHNkcWJh?=
 =?utf-8?Q?tSOXWvqVuighVAQMIXJghQvw8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c8f523-4e50-46cc-048e-08dcbe03c583
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 14:57:38.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoMeuBd4+7aMqqj16vd9OXOIbB62ZRFUHqrh/r59jQEuM2QJ3W9Ao5JPx0WVAFCIk0sj+dtIr60IhRiQCcF1vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266


On 7/24/24 22:32, fan wrote:
> On Mon, Jul 15, 2024 at 06:28:27PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add memdev creation from sfc driver.
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
>> managed by a specific vendor driver and does not need same sysfs files
>> since not userspace intervention is expected. This patch checks for the
>> right device type in those functions using cxl_memdev_state.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/cdat.c            |  3 +++
>>   drivers/cxl/core/memdev.c          |  9 +++++++++
>>   drivers/cxl/mem.c                  | 17 +++++++++++------
>>   drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++--
>>   include/linux/cxl_accel_mem.h      |  3 +++
>>   5 files changed, 34 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index bb83867d9fec..0d4679c137d4 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -558,6 +558,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>>   	};
>>   	struct cxl_dpa_perf *perf;
>>   
>> +	if (!mds)
>> +		return;
>> +
>>   	switch (cxlr->mode) {
>>   	case CXL_DECODER_RAM:
>>   		perf = &mds->ram_perf;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 58a51e7fd37f..b902948b121f 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -468,6 +468,9 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	if (!mds)
>> +		return 0;
>> +
>>   	if (a == &dev_attr_ram_qos_class.attr)
>>   		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
>>   			return 0;
>> @@ -487,6 +490,9 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	if (!mds)
>> +		return 0;
>> +
>>   	if (a == &dev_attr_pmem_qos_class.attr)
>>   		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
>>   			return 0;
>> @@ -507,6 +513,9 @@ static umode_t cxl_memdev_security_visible(struct kobject *kobj,
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	if (!mds)
>> +		return 0;
>> +
>>   	if (a == &dev_attr_security_sanitize.attr &&
>>   	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
>>   		return 0;
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 2f1b49bfe162..f76af75a87b7 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -131,12 +131,14 @@ static int cxl_mem_probe(struct device *dev)
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>>   
>> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_inject_fops);
>> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_clear_fops);
>> +	if (mds) {
>> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_inject_fops);
>> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_clear_fops);
>> +	}
>>   
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>> @@ -222,6 +224,9 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	if (!mds)
>> +		return 0;
>> +
>>   	if (a == &dev_attr_trigger_poison_list.attr)
>>   		if (!test_bit(CXL_POISON_ENABLED_LIST,
>>   			      mds->poison.enabled_cmds))
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index a84fe7992c53..0abe66490ef5 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -57,10 +57,16 @@ void efx_cxl_init(struct efx_nic *efx)
>>   	if (cxl_accel_request_resource(cxl->cxlds, true))
>>   		pci_info(pci_dev, "CXL accel resource request failed");
>>   
>> -	if (!cxl_await_media_ready(cxl->cxlds))
>> +	if (!cxl_await_media_ready(cxl->cxlds)) {
>>   		cxl_accel_set_media_ready(cxl->cxlds);
>> -	else
>> +	} else {
>>   		pci_info(pci_dev, "CXL accel media not active");
> pci_warning() ??


The code will be modified and no error will be needed to be handled.


>> +		return;
>> +	}
>> +
>> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
>> +	if (IS_ERR(cxl->cxlmd))
>> +		pci_info(pci_dev, "CXL accel memdev creation failed");
> pci_err()


Yes. I'll fix it.

Thanks



> Fan
>>   }
>>   
>>   
>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>> index b883c438a132..442ed9862292 100644
>> --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -26,4 +26,7 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram);
>>   void cxl_accel_set_media_ready(struct cxl_dev_state *cxlds);
>>   int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>> +
>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> +				       struct cxl_dev_state *cxlds);
>>   #endif
>> -- 
>> 2.17.1
>>

