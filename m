Return-Path: <netdev+bounces-211887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A0B1C39A
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 11:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD75189B679
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9341C3027;
	Wed,  6 Aug 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DDAQYG5/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3929189;
	Wed,  6 Aug 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473443; cv=fail; b=Z2N+Jjeg6hjf9X1sq5askD67bJxyp6mJACrhOTvnqB1aEiFTts5QZi6SmSCMfEFpWzXZmMceeeOXtW8Cu6z+H/w9RQ//c14v95eAIrAKFNvJxQxgtt8FYdM6zBQE7ToFHKZ4h+7hKGGRZse1s3+mGcvuvAAXpAy4ey2ehuRSVLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473443; c=relaxed/simple;
	bh=B1y46Ce9Je9lDLGSB068iqwIdoUrj6qs5gWeOAJCl1M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ST3A7VGvGfFC3hYFQy0lhTzcNqySP2tdtibfBsKZ2IBqr9hDQuAQC+cUJdvC/3VKlkwlVWoCHGvX/VEnvtYCyVZPciD0Q+2cE9F/OSba9k1KP5GOYl4BkKhMYRA49YgBkDZNpvYU+sKn3HCQiUqGQt8ftHulpJ3DEk4bn5HnT7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DDAQYG5/; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=You0js05C1dR9fyuPAYDfeeiK9Bdr7lmf5yWhgY/80qLN+sCwcwWuW1q9+JyYPbEIVAsWGaLzntKNxsvYnbojYMKgmiqrZcDC+RRl7dLPgqT++4eSjPXQj8Pb+NOOU4JMK/hEiQab14JNQIZk44kqpQjaCHrfxN0d7t9/Qq03gwi+bSrmM6FhvgakLPVhszsNLN+zkovzPRDWddf2mBgQrEdK+NljSPnt5MzenN2xf2fD7oQK+p/TsGCd3+5WwANZ6RS8qPkkdcV2moOyWaNu6IabiQjVPSYt8ZdsGnAEoN/Xxtt+q7mW/aShsx1Cf0SHCh98SeqKrUlxsXSynx2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjiEJZnY1OQsH4umGZ7V+m0mCrrcyiB8J4qO4FlITfA=;
 b=n2tznU1bB6/UBtyMTN9DlrOUolJaffelkKfjmVlumfcBdKA+uAXOGTt8+ZiskW/JBHfXJvizV5A4kxkM/n7hd36Wit3p5VU6X9Rf6yYBNu71hN/djiNtZTgWdRKMTI0GeNw4PdTpaQcdt3CoLzjf6aKJKhzxuDb96PT/I7czPw44R/TpaeoIO+XQL4pVbPCLQbsw64+l3lZovySDuC5Lwj550n2FvccVSXSX2qYZOD5Z07c5pW01TwB7d7n1Xdg+NIzA5CHJdCdUKFeqCpEBcG+4LO3b5gL6pwmbE5cwa5qbb10CqvKnCI0zONXfDqGmqlJdhojBYhx2ljxpykgnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjiEJZnY1OQsH4umGZ7V+m0mCrrcyiB8J4qO4FlITfA=;
 b=DDAQYG5/vBR3sjG3ZIqGNc/5QI9nXuh3KKCheRUmIfEi/I0uquCYMimy3G4zs5/EeC3aupJsaJlkFfln+E/5ml/SV9hIOdczHonCcjiJRErNMupt59zCzuqP1QtdNGg3MFo1IN0P3oL4m/3aEtdM4jmpotMjySQYTwekz6pB08I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 09:43:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8989.017; Wed, 6 Aug 2025
 09:43:59 +0000
Message-ID: <d56b1bda-14b7-4d48-a999-68e4e4d8c06b@amd.com>
Date: Wed, 6 Aug 2025 10:43:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 04/22] cxl: allow Type2 drivers to map cxl component
 regs
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, dan.j.williams@intel.com,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-5-alejandro.lucero-palau@amd.com>
 <68840b6dbac3_134cc710045@dwillia2-xfh.jf.intel.com.notmuch>
 <1e1a898b-1872-4aa5-9a3e-a593e3f5ad6c@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <1e1a898b-1872-4aa5-9a3e-a593e3f5ad6c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0178.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::22) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: bb58091d-41ba-4c39-a9d6-08ddd4cdc47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjVWWEJqdkhRaEoyVTRBWTVjVnZZampkaXAxY1dNL2Q0YXo4cmU3KzQ1WWdS?=
 =?utf-8?B?RW5ycWtOVHUvbDZtTkFWeWJEOEd1ajNuUm9SVG1xRGZBTnZBTlRmMlV4RHJ4?=
 =?utf-8?B?UGFkSVRrMzRTQUlRd1dGSmJUcWxmbTlTalB2ZkVvNG16WHlXeC9ra3pEWXFH?=
 =?utf-8?B?eGZZcFY3Sit2MnJuRlVuY1F0Z3lmN1JaOGlyL1hGdzd1bVpIeWFQL2g5YUlO?=
 =?utf-8?B?Vlg4SkkyeEM3VGpOV2hXZmVHRjRjanlnYXlCZlVwVDJVdGFpR1l2MCtzR01I?=
 =?utf-8?B?SHRkWjBaZDlvSjBNNEM0bkI2d3JFUFgzbVlpNzJpcXliemlwR2txaERmYzds?=
 =?utf-8?B?RDFJZSttTGhvaXFVNlpCTDVaQk9WN3pSUWdCRmhQdFQ5WkVGbk5KdE9yUGkr?=
 =?utf-8?B?OHRzc0RsYklUU2YvclFTckExTzlSaTg5aTFLKy9wNDN4VC8rR3dJV3dIcW82?=
 =?utf-8?B?ekhKMStmUVYvd1JzOGVEY3lya0N4QXNoaWkwdHU0M3FzZjdoUkdlOGlKLzZM?=
 =?utf-8?B?ZUlaTjdzUS9CYXQxVWRNMkt3VXROT3dWeUdza1hFdCtMSlg3aWU2cUNQNjNU?=
 =?utf-8?B?emVFNCtMV0h2Z1k3M0xtcEZjUVdZckx0QUVrUXhYMUdSTlQ0bUFMc01nYlBx?=
 =?utf-8?B?SXVNaXROanI2N2ZGVmxjcCtqeG9FL3JsWkhjOVF1ek1LdUVOeS9lUE1sdllT?=
 =?utf-8?B?N1VJZERHdlAyOWxZWFJFWTNoQUtVRUExOWo5MHVEeERvUjFLQ3Nic1B3ZGd1?=
 =?utf-8?B?SlJ5RXd3U3VSVFNBV3hTK1hXSWJsQklndGV3eTk2NkVuU1ZHN2NmcnRSam5X?=
 =?utf-8?B?YVJCOVJ4MUtQbHJCZkRjTXFNRlc1eWpJMkZtZXR0UXR2Vyt1dzh0TG9DdWpV?=
 =?utf-8?B?L3F5TUxkTUhSNDJHYXlZVmVJSVptdkptZ1NDUFBGK2wybzVWY0pxV2hpbTdt?=
 =?utf-8?B?dXYycHhGZmF6ZWdKZWltaGVoQUJLd3pxLzI4WUoxM2FrM1BGNG5tcUhxRk1I?=
 =?utf-8?B?c1grMFh1UXZLQUJKREhJSGIrN0pRaGtpdDZ0MUU3Qi9NbTBRcnkrUDM0QzVX?=
 =?utf-8?B?WUJ3RWhJK0JzY1pQenFYUVY3L3NaRG0xY2xtQVBmdEQ5K1doSk5xY3loYWRZ?=
 =?utf-8?B?STVpYm1ZS0p3UW9zSFoyYmF1Y2NaV1EzNnFhblUyUjF2SzlxNmkzaStsSU5r?=
 =?utf-8?B?cG56R2UzTzczd2FJa3NQUFpxdDRXTmtTUzkzOEhMOGxnaERDUTZYUHpoMk4v?=
 =?utf-8?B?VmJpNy9HYUpIMUdrME15VG1TOS9YUmI4VjdzQWJrUzNtSXZIWGhCVUJkckF5?=
 =?utf-8?B?WGJpaDh1K1VvMFZKSHkzWkVOQVE1TXNKKzVmbERQa3ZQdi8yYXFBamI5Syty?=
 =?utf-8?B?VlAwUTBkZnRReGdua2pvd2Y0dGVFYjlhWmJHWHUyT3ZBMUt5NldnTDE1azZX?=
 =?utf-8?B?bkZoTThQY2kyb3d1dlVDVnRJL0pobXRMc0hFckJGS1ErNGMva08vSG4wNUtw?=
 =?utf-8?B?dHdWSWNPZVFCWUFhbUQzTjdmYUEwZG9qNE5ITXBWSndicGdYQVJZZldWN3BP?=
 =?utf-8?B?eXBTcnFpaTJiSTIyWmppSjFpL09UcmR3bkpCbUhaY050eUJ3cFdKeVJtSy9L?=
 =?utf-8?B?VnRYMmlRWkEwZUduNmdhdjdCUnJ2MFc0cjcxSmxLN1gwcUxhM0NxU2dEb3dD?=
 =?utf-8?B?NjkyekY0aGp4c24xM1h6LzQyNWhERzhhY2pqTWx6cm52SHdEV3BSQ0crMlFM?=
 =?utf-8?B?MDAvUE1ILzVoU0tmbFdQZVhHbnZQc0Vhd0paSVJmWS9nMkRmVUlqek41L0lH?=
 =?utf-8?B?bVAzWExDVERYcEhUMm1KYXJpQUNPaTRId1dEN2RYT2RYOWV3eUNEbTUrY212?=
 =?utf-8?B?eit2b0dwOTA3c1RwZmtWaGIrWGR2Ui9WcXNHWE81Um5lb2RaWTRFWnFKd0pO?=
 =?utf-8?B?dDB6QnVGVkRvejhqYkpWV2MvaUVPYk9GMTRDVmk5RzhyclVJODUrdGtpeGgv?=
 =?utf-8?B?dVZGMlJDSDVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk5KTTBrTXd6YWZ1MW1DUU9NdDBFQ2lBb1JjWTMzY0xTL0o5RGxwUTZyaElj?=
 =?utf-8?B?Vk9jYTBOMG9UMUhOR3RmZ0hkeDZ0UE9TdHQvRFI4WGZTVFl0MmNuZXFCOWVL?=
 =?utf-8?B?c2p1Tlc0QzNVNHhYTTlzaHh6dGZvVU1JbnVoRVY5N3VIQ21STlY5aVdJbUdT?=
 =?utf-8?B?bUF3c2ZzYVV6V2t2aDRSbkJheXVMaHVqWGNWZUVUeGNVZnBPVmROOUZScjF6?=
 =?utf-8?B?V3I1ZWdodXB1cDJIbmpuL05lMnFVekljNXc1MFJKV1h5TFRQWVRRSWoxR3oy?=
 =?utf-8?B?dVFFdy9JajRFc25xQ0hnSmxLNERGUE0wcHFDRVp1ODNaWWUxdWEvdld6SGM0?=
 =?utf-8?B?RXppb3UxK0NXSUJ0UWVXMGFONlVSMXlaMk1aU281NUJBemhwVzN2UGRmVkJ6?=
 =?utf-8?B?SGY4YmoxTHB3UUIxVnNGcWZMbW8zUGEzZlVmN3EvRVZDNk9YYk9JZ0F5aFkv?=
 =?utf-8?B?cnorL3pnUE9qMDh5dzFsMzN0WmptV3Rld1lPcjZCUDFLVmpMMkg3aHFIK0tB?=
 =?utf-8?B?TzVCYWI1SFBRMUhLRGRVMGNXUXdOaFZLL05TS0RLV0FiL1NnK25XK1B3bS9K?=
 =?utf-8?B?SlhYOXk2U3A4V2k4MDdFMGYzNU5lczdyVVNqdTkvVWVsU2tvM1MraDdZMWlP?=
 =?utf-8?B?UmJkWEhld2kvY2lXa0loQjBlYlExT2M0WkFUbzNid1BjTFE2WVlmZHhac0R6?=
 =?utf-8?B?MXA4QWhUYjg0ckI2OEF5dm43bWlnNkI1SkQvWHFsazUvWnpGeU1WN05oTytY?=
 =?utf-8?B?VkhFZkpxSUVzSjlVUHlxaFVWTG5pb3UvWkdOWUw1TVNqNUxNZFltUTU1aWNW?=
 =?utf-8?B?ZkhLK0hiNG1uZmVzZTF4SjBvK2QrVWZNTWpCOVZ0UGtIS2dpdndYNkQ1NkRz?=
 =?utf-8?B?dVhYVGdTVHdUbFlkcnlmKzVWUzkvaWx5anh4MHcrOStycHpURWE0V01nNFg1?=
 =?utf-8?B?ZWNFZDN0WGJZaVFSRTdncmZmME1tNEVhU0NhVFg4dUpLQmtsMVE3VG9RMlRQ?=
 =?utf-8?B?TnRZZE9TMjVGdEZhUjluRS9BOEhWRkd2bnRoRnVIUFVUbmFQaitYcW5zSXE1?=
 =?utf-8?B?Z0sydDlLMXBzcENJY0NEQnpBSjAzQVdBcHlEei9hWWxGQXU5b3ZRcTBTR244?=
 =?utf-8?B?Q29PYVYwTi9pUi81bmd5cnJESHBGeUdaQU5pWnFpNnRxUW9RdC9DN3dNMWxY?=
 =?utf-8?B?ak5zWldPZmg1dDJjMmtTT1FQc2pIMElQNkxpRzZNQ1RmSGh6UURtRXNGalE1?=
 =?utf-8?B?aFE0bjRVcTNmalhKYzZJN3AxZHVTZEpYM21CcWdPYUJBV1E3N0ZNZGxkaGtT?=
 =?utf-8?B?a1FOZ04zYThnY2tGTlI0eXRBdG9xZkxablhmeWxpVmhLSE5jUEJ6K0M3REdV?=
 =?utf-8?B?dGh6VWQ2L09EajZUVTRvdmt3Y0xHeVRBaE9VUk1nZXFCaGZMVlRxNUFiZDFY?=
 =?utf-8?B?b1ZJSWZRMTlacjFUaGJxQWlmKzJOWStvbmNqOUdsc05uR0x4Q0NPZmxPL3NF?=
 =?utf-8?B?Zzkrd1JDakJyK29HTGJLVFlrU3NPZFB5OVBhSGVhT1RyR2NpdUkwbi9kVkZr?=
 =?utf-8?B?ZE44SHpiZ3JKOWxTRHZscHA3blVVVUpqR2xkZlNxMU01dTNIeG5VN2pQYUtp?=
 =?utf-8?B?VEYrSEQ2NnIvcnUvczR0MFFob2lnclZTNGtIWlFqd00vbEFTYWQ4SEZGdGVY?=
 =?utf-8?B?NHlFdW1iUlpPbkczK0dtQTZWd25VRzRZeGVPcDh4aklRWDZqdEk2VnVJOFRj?=
 =?utf-8?B?eHlLbWYxM2NiVmxHcXJoSG8rbHFyU3RSVm4vUm1kV2FnVUVEbE5zM0UvSmZ1?=
 =?utf-8?B?dXgyckhSNUpuSnZKV1oyU2cvQi9Zb3MzSm10R1E3UGhjZmpsQkhNM0JuWDl1?=
 =?utf-8?B?MUZ5RTBYM3JDYXo0NTRWOUpRWUNneUk5UGZONzlYYnZHTlRoSjRMQm42MlNI?=
 =?utf-8?B?ZURMc1V3MHVZNnJaSGZ0SjBnZjN4eDlrYks1VE1JWjl1S05kdGtsT20vNDdC?=
 =?utf-8?B?NW4zZUZtNlJLYXB6a3JLdFJlSUt3djBjWTlicEx0b2RRQkpJVmphczY3QlNN?=
 =?utf-8?B?WTgyeGRiZzZ0bTlINnkwZTNKTnZIS2ROVUVOVG9YbHBUZ1F5cjVKWVMvOGJC?=
 =?utf-8?Q?QSY5galH9S3KMNT5jTsos/EwX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb58091d-41ba-4c39-a9d6-08ddd4cdc47b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:43:58.8657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BP390bHhHpSgfYdFU36uYKMLsM2EgwQ4vikl3qd5KdAE68FQmmoUfXZX4SG7rUd5L0klTWPXcYkpyZSmC/DRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017


On 7/28/25 17:23, Dave Jiang wrote:
>
> On 7/25/25 3:55 PM, dan.j.williams@intel.com wrote:
>> alejandro.lucero-palau@ wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Export cxl core functions for a Type2 driver being able to discover and
>>> map the device component registers.
>> I would squash this with patch5, up to Dave.
> I would prefer that. In general I'd prefer to see the enabling code going with where it's being used to see how it gets utilized. It makes reviewing a bit easier. Thanks!


It was recommended to have sfc changes isolated for facilitating someone 
testing the type2 support with another driver. But I think it should not 
be a big issue for anyone to squash some of them, so I'll do so.


Thanks


> DJ
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/port.c |  1 +
>>>   drivers/cxl/cxl.h       |  7 -------
>>>   drivers/cxl/cxlpci.h    | 12 ------------
>>>   include/cxl/cxl.h       |  8 ++++++++
>>>   include/cxl/pci.h       | 15 +++++++++++++++
>>>   5 files changed, 24 insertions(+), 19 deletions(-)
>>>
>> [..]
>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>> index 9c1a82c8af3d..0810c18d7aef 100644
>>> --- a/include/cxl/cxl.h
>>> +++ b/include/cxl/cxl.h
>>> @@ -70,6 +70,10 @@ struct cxl_regs {
>>>   	);
>>>   };
>>>   
>>> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
>>> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
>>> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
>>> +
>>>   struct cxl_reg_map {
>>>   	bool valid;
>>>   	int id;
>>> @@ -223,4 +227,8 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>>>   		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
>>>   						      sizeof(drv_struct), mbox);	\
>>>   	})
>>> +
>>> +int cxl_map_component_regs(const struct cxl_register_map *map,
>>> +			   struct cxl_component_regs *regs,
>>> +			   unsigned long map_mask);
>> With this function now becoming public it really wants some kdoc, and a
>> rename to add devm_ so that readers are not suprised by hidden devres
>> behavior behind this API.
>>
>> It was ok previously because it was private to drivers/cxl/ where
>> everything is devres managed.

