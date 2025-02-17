Return-Path: <netdev+bounces-167008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA3A384EC
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E00188516C
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6C12185A3;
	Mon, 17 Feb 2025 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l74mHm25"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE9D1E51D;
	Mon, 17 Feb 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799680; cv=fail; b=U12gM4ZyIekfJu7Uy3EKfY+969mpF7Crq/ZrKEdMOrYvAcC+3Ol5SRLypwWxZ0tt4/e5kVxaWlBaU2zxARVKVWIlCCUX5jbhXUoewygR+aLkYLIYvumgECkUvNPY7MHwRFRStSEGfoS+LcJDr/vs0RgOK2F4oPrKT6Qz1qpA9E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799680; c=relaxed/simple;
	bh=tYY+9s54+UWibuC1blWlvBQXjEew36u603pV0kVX4vs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FP9hIYixd89+S1f4zOC5I4JVH4NuYips6N9GCPyXZHDVAnand0rny2Kvai3ytB9RZwTKfmxLhpu4x9BojR7646KVUzwCIrwhk9Xw8wnKXQ9wMMpG2ZSeCa1bQOwo1uhYZGc98vRxB+hhdAW8c8/Q2DHpF+6eZVktcpUqCL/yiyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l74mHm25; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCekHedfG3C82CNyED6uXfvyHFv7GJFPkVDJLK9UNSj747Ue8trmDT+/4VhFLH7T4XFvRm4bR71YSBdreZba0XZ5d2suvL9Yz1fJcSSJEnq+77mS5mFehjq2P/o/I2dAQ4A2jLW84wiwWWSVJKh+tXSeGtruhwgbUobQGJcTz0DzT3IqdvGLD+4rqe2OzjIyvlVttOCrFv5AkDrXrHM+XTtUcOaSMabp9TERjGAf3ENapDOQVbl3A9kBjaz6JLWT9GgKY7RJ4vN41lIXGnoJictl4ktLjUWDWLuq1vOcRq8gySRaXdNcrMuziP1xdH++vX2HkokKMVMYBrYzUVaaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcW19wnBImIvu4emPvLKmq7EI6MKlQsfLJ1M3EaoEQw=;
 b=B7NVrXiROnI+Fe+o8VJiX5xtAwvmyZvTKuWdg5i+qo39HomFy3Ao+QhFq22go77oKG8cpd7kbHqrn2fT9QQ6st73PGL9V2ONnNKi1tV/Z2/aPwFZQPxM+J+nZLvLIMUG1KC4xDhUfm1HdjQxs3hIilMZxsuVGJNaoUtobwGP5giWSbDgSdnGKTv9swl31BsTnS++Dsj2yg4P+srjx+OfCWTTJH6hIkJnTWo5GjYT/581PISa1dv0QYwuNPclFxHCFbCs7o5ecgwSdjM64Jav/6pvTR530KHNCxuEvC1BHgw3VQietQufDzuyh4Arg6t7Bs5ZMRhZ5BQM0Pk33pVLZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcW19wnBImIvu4emPvLKmq7EI6MKlQsfLJ1M3EaoEQw=;
 b=l74mHm25byiqqvQQWlnHIvYzWDgfcrcr+kc9Az9hA8YRjT8RW7Kk46dD6iHTaa+Xu0RElt+bd4u32e+KZHKwcxDR6QHc6Uyi5HoW8u7IMmq2Cdv6jiOM8ioUKwEyG8Fi8aI22Bscyo8jHiN07C+gypKPXyhCxQ8yutg3sqqyse4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 13:41:15 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:41:15 +0000
Message-ID: <eccb157e-10c3-4009-9036-dabccf4ba918@amd.com>
Date: Mon, 17 Feb 2025 13:41:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/26] cxl: support device identification without
 mailbox
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-10-alucerop@amd.com>
 <67a3dc0071693_2ee275294fc@iweiny-mobl.notmuch>
 <9ce2dc57-ad51-4587-8099-60f568984b84@amd.com>
 <67a50c15de8e1_305d76294d2@iweiny-mobl.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67a50c15de8e1_305d76294d2@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CT2P275CA0061.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:24::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: abf64d9b-adea-4d1e-df7c-08dd4f58bf9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjF6RFRwSS9zWGszdmt6aVJXbTZBZ2FlbmdLUGliOFM2dHRqMmIxZkRGZXFN?=
 =?utf-8?B?b3JOMlI0R1ZHd21MdEszR2VyK0lCalU0dTNOS1ptSnQyZFRiM0srZ2dNalFC?=
 =?utf-8?B?K1VrdUZpUXMvbXhVcXBLcGJFT3UwWGtxNi8vbVFIajZ3OFVwRVBhOFNVSWh1?=
 =?utf-8?B?N2o1SDhMMUU5TCtqbVVRUlBCQk9JQnhsdW1GVFA4cklFeHpRbkR4V1hoRmdt?=
 =?utf-8?B?Wk5iRGpKV3JicTByenROTDdnN1QzNjJZWXpnTjVlT2cyT2dCQmlLNGROQVpl?=
 =?utf-8?B?U1pFVDJTZ1VPWVdtUmo1YmliT0x4RWJDVVNrVlBGZTFCeVowam5CRjVPZUdI?=
 =?utf-8?B?Tjl0Rm40aGtJTm05VmxkOTk1Rm4rWGJBZ1N6N05EY0htZFNTdU1OZ3VFNEhR?=
 =?utf-8?B?WnZOL2FhbVMyMXNrYXhFcVk4dzhhbkxIQkJFSVdhZ2JBZWtvOWpCUlRiVGYv?=
 =?utf-8?B?MzVmeFNqTWRwY3JuN2xXVk9abVdCOTM0SFVVQm9jZHJpSmltZ1loeXpaTXh0?=
 =?utf-8?B?ZnR6ZzRFc1hnTFRPQ3BLTmV2SlZOalpFTWR6TlpmZ0FkTHY1MDcyTnR2dS96?=
 =?utf-8?B?TWVXallaclcrbXVTSmgxbkdiallCYTBVQWFDVDBlalVqdTAzZVVQNitTbmQx?=
 =?utf-8?B?NnlFN0x4d2ZORDFRR0c5blAyYytqMDlPc0htMG5yWmFqczMvK3R1UnNoa3Vm?=
 =?utf-8?B?L0JUbmUwSldsY0F0MHpBRndjWkxhMnlzd1orMWJnVVJvbVBjRlFEcFFUb3pG?=
 =?utf-8?B?YWI4L2VEcUxtZ015V1VJNm1lZFdTSm5aaTlBcTdqUGpnUlhLQ3pNUTg0bGpO?=
 =?utf-8?B?bU1iTWhDdUdSVWl4MWhObkFRdWVtMlZuVzJxN0tTWGJtWXZES1ZrMEIrZ283?=
 =?utf-8?B?NytvZ2NGWGx4bkhCaGNJQTRlSngvcE5DckZiT3pURTF3SmowejZpUThGZUxL?=
 =?utf-8?B?VTNOSEZVR0IvV0FZRFZPUmdNanJSNmhra2EySDdKQnBMa0xvVk9ydDFjTVFV?=
 =?utf-8?B?S1dOWVlyYm5wUlFCaW1UdUdaNmZlRUdmR0lUOVU0SjhPS2lyekE0dXhabnpw?=
 =?utf-8?B?SkFaVTZnd0ZIbmFZdkF3Z3laTWxpVWphR0xwTnQ3K0FpSnJpKzVtQjdxNFlx?=
 =?utf-8?B?NEo5Q3UzeTd5WUQ2U0xHYjBNdC9QUmU1dVdybEZTN3RTbCs5ZDVtVXkya1JT?=
 =?utf-8?B?OTZKUmJTWmQvMEFBamt3RGh5UEtEMFZHTkZiVjl2RU9weGF0OWlFZlhJR0RI?=
 =?utf-8?B?a2JCU25aVEVyUnJUNVdVWWlFNHRZNFFCWmMxdHAyMlpEL3JEVmVkSFV3NEtM?=
 =?utf-8?B?dTNSOUtaUkFUbE9BcExUdnlHVC80STFwanF0a0gyZVFrZ2E4UXg2RFlueHlG?=
 =?utf-8?B?Y0d6MGZzdjByazdGV2VDVEJTOEJGOWF5S3RHKzNtVzBMTGxkZ3JrY0hZUlVy?=
 =?utf-8?B?TVZNMitIUms5ckM1dlF4WVh2a2JseTdFSWIvTXZ6WXFkWkc3SjBVVkVwaEpY?=
 =?utf-8?B?NzM5eGJlaHc0WkJITVRyWUJSTXJQdUgrTkZZa3dhMC8rYk1ZYU9vcm1GYkJK?=
 =?utf-8?B?bk9CcS8yU2gzVmMwelNuVHVWQTR3bUtGQXNTSnorU3B4aTZkZGlMSXRwL0pP?=
 =?utf-8?B?YmxpN3ZQUFJSZ1o5VEFaZXhDWmVKS1JUOTFTT3gwZERyZXlhYVE2Z21UWjk2?=
 =?utf-8?B?UEhjaXRIVHUxVTZmUTFTcEFrYTNmQVdWVWNON250N1dIN3QwNXovSEdsczZk?=
 =?utf-8?B?SHZFalJsenNQbVhCS3lpY3dYNjhpSGUwOU80L055Tm1VYk84WmV1ME54RVg4?=
 =?utf-8?B?NWI5U3NTektuY0lONjRCdGErMWFiSWxoTE91RjNqdFV2Qk5vU1NLYVJFNUhs?=
 =?utf-8?B?THlxRTVrbk1mYzRNbUdMT0pPQnFodVJNQTF3aHlITytCNEFIdlAwNGdIZ3Bo?=
 =?utf-8?Q?oEomCikulJE+o5P3F7FNYNWoCBEvH3m0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3p6ZXhndWNmZkNnTHB3NFEyeDg5THAybjVHem00bXJtNFNMRnRPMWZ5b2FX?=
 =?utf-8?B?dUtHZGhmNVpNOTRSdkdqai9adWVzalFUc2FFcmZwWHd4UjV4dGR4L3YzRXhy?=
 =?utf-8?B?MXNaem5pOU12THF2eE9HSm1DRVg1RVVXclRRWm5ra2gxbXlvU1A4cDlSclBy?=
 =?utf-8?B?VXIwM3dLME03QURBTXNBYWZpcTJTekdyeldZTU9RRXN2R1J1Q2JRczFWd01J?=
 =?utf-8?B?czNPWm5sLzBTbE5KUFNyOXlMSjNVY0JZSmVqOTZlZmQ1TWFRWTR6cWhxR2JG?=
 =?utf-8?B?d2MveGkwUGRiMFBUaXAyS1RQMFp3TnV3ZlZPL2NrQjNSWDkrOENsdmFsMnI4?=
 =?utf-8?B?b24yUlNoQ09wWTBXWjB6ajFWT0FrRC90SHhuUFJPNURjVzBvL1dvUEdFelBk?=
 =?utf-8?B?aW9JRnVQU24rUVV6YnlzMXdUVk1zWlVXQmtrLys0dGU0YTEwU2QyWUswb0dl?=
 =?utf-8?B?U01TWlZrYWJNYnIxT1ZZNnQwbld6VnNab3k5dEtUaDZVOHUxSUdZV243S3Iw?=
 =?utf-8?B?ai95MDQzN3dUNU9Eb2JKek54V0FJa2J0MEd6bFNuVVJxK2hiR0xJUEIzaFNs?=
 =?utf-8?B?UEdoaE9YM2VIcU1IdGowZWVrOUhoMnQ4RFVtVzNLRFJLR2dqUFc3YXJzc3E4?=
 =?utf-8?B?R3ovMVc3M25yOUN3bTd6MEJOeUJ0RTMwcTFXYW9ra0RIcllXNVhaWHV0SUt3?=
 =?utf-8?B?V3ZzZGJUcmtiMklobnRQc0NXeUhTQndSczl4TnVmQUQvVnoxRGZuVWVxa2VB?=
 =?utf-8?B?aSt4Mjhxc2dOTWlqSzgzVU0xNnFZcWp5RldwMlNzd3orNkZ2N2xndWM5cUhQ?=
 =?utf-8?B?K1N5ald0dU5Ud3Rka2kwT0d0R1FYclB5QlJLbDNIczh0LzJSdFVkMDN4eU1t?=
 =?utf-8?B?bSsxTFM5TFhwT1VqVnFyVFN4ZWNndWVEdTFLSFBmMHFjYnRPczJXL3dTNzdK?=
 =?utf-8?B?VnA4OWJzTm5tSTFEMmNIY0Y2KzcwSHF4SDJQbnI4cjZBUjNYWXFNeEd5Qnk0?=
 =?utf-8?B?a25SS3dyYURjODlnZTNOUWhMVmphNE9OMW5lbHJSV0NKRzVFL0xWYTA2ck8y?=
 =?utf-8?B?bCtuZ0hNRFRpRjJHYVhWaGdWeFVJRkptOWc3TmV4dlgyaktZQ210OEI5ZnVp?=
 =?utf-8?B?a2xrNUJoQnY2QnVZSmhONHB6R2x3aGlEVE9DeHJtWkFmZHViWStiYWorUmdl?=
 =?utf-8?B?R1l5UldpU1lkMnBaK2JGcW00cUdJeGwvWXFqd3luZm1PMnFoeEJ2WmVJbTUw?=
 =?utf-8?B?V2Ixd2YxdVhpMjlSR3Z1N0NHQm9RQ3NFTTFkRFBpRTJzOTZ2eHNpdkkvYytv?=
 =?utf-8?B?UHRnN09Odm0wRzBsV1VFZ29hQzhOb0VVdUlUUE1ONmJHVjh3ZVJWWDdMQXdm?=
 =?utf-8?B?T01wSjNWNnl1bWZWdmRUUkdjU0lHZFY4L1NRaXBSU1VndUFKa2pqNjBCMnlE?=
 =?utf-8?B?NHhnYkJxeW5mSzhmL2t5R3g3Nm0yc0h1REgwK3doREo2VVhGZXg5RkxEYW94?=
 =?utf-8?B?akVudkdjWWx0UUFBbnZObTBhTEJqcHc5VXhDNGdxbisvd05mdWNFall5bmZa?=
 =?utf-8?B?UzdNbWZQM2IzWnU5emN2RjIxY0lFOTlsdTloYTdOWXZFWWp5Z3FrTmhXWkEz?=
 =?utf-8?B?eW9YSEp4MVAyTnZtcFJZNCs0bFMySHpJdGJ5TXN1bmtRcnFiWFNid0VSZng3?=
 =?utf-8?B?RFlCRTFONWd5R3d5akprcWN0eXNXRWpORWNqZ0xod3JabVMxSkgvcWhJQVFm?=
 =?utf-8?B?YTVTSWNZNzdhTzZaaWluTzEycXVoaExkQkp6WjZSSCt3TEhBYjdRbXYzaFpH?=
 =?utf-8?B?SlFYVUEyeWtPNkQxMWorMnB4NktQbnhJQTBiUy9makhKU2M0enJGaGJUN1Vx?=
 =?utf-8?B?Y2hHQmdxN2tCN2doWXZPa2NxWDBOSzluWThBQjQrbFdpTE5VaHB6VDhPUks5?=
 =?utf-8?B?b29CRlNpU041eDRVQWZDYTJGT09QMTE3N1lVSXpoaS9ReThWSFR3U3BkaXpC?=
 =?utf-8?B?dlB5RFNPVkRvTlB1dEU0QUZjcnc5ZTRIa0Y0eHJvcnVqeWJic3Nsd01seDRB?=
 =?utf-8?B?WDdWOXdpaDdCTWVDdWlRQ2RjUUtpZFpKVCtyOW53RkFnSGN3ZVdRNGlFM2RK?=
 =?utf-8?Q?YzPEWwKlVWMr2LYNVtjhA7IKN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf64d9b-adea-4d1e-df7c-08dd4f58bf9f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:41:15.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp70IFxpmZaXQMFW6MeCQJJaOn4oeMjARyLBAU+djFRXL+cuonuaQfaZVIrDdVjW6NZMKBgQQib9JBEYIFYo0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120


On 2/6/25 19:23, Ira Weiny wrote:
> Alejandro Lucero Palau wrote:
>> On 2/5/25 21:45, Ira Weiny wrote:
>>> alucerop@ wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
>>>> memdev state params.
>>>>
>>>> Allow a Type2 driver to initialize same params using an info struct and
>>>> assume partition alignment not required by now.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> This is exactly the type of thing I was hoping to avoid by removing these
>>> members from the mds.  There is no reason you should have to fake these
>>> values within an mds just to create partitions in the device state.
>>
>> Let's be practical here.
>>
>>
>> A type2 without a mailbox needs to give that information for building up
>> the DPA partitions. Before it was about dealing with DPA resources from
>> the accel driver, but I do not think an accel driver should handle any
>> partition setup at all.
> I 100% totally agree!  However, the dev state is where those partitions are
> managed.  Not the memdev state.


But as I said in other previous patches, this patchset version does use 
cxl_memdev_state as the opaque struct to be used by the accel driver.


>> Mainly because there is code now doing that in
>> the cxl core which can be used for accel drivers without requiring too
>> much effort. You can see what the sfc driver does now, and it is
>> equivalent to the current pci driver. An accel driver with a device
>> supporting a mailbox will do exactly the same than the pci driver.
>>
> I agree that the effort you made in these patches was not huge.  Changing the
> types around and defining mds_info is not hard.  But the final result is odd
> and does not fix a couple of the issues Dan had with the core architecture.
> First of which is the carrying of initialization values in the memdev
> state:[1]
>
> [1]
>
> 	> @@ -473,7 +488,9 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
> 	>   * @dcd_cmds: List of DCD commands implemented by memory device
> 	>   * @enabled_cmds: Hardware commands found enabled in CEL.
> 	>   * @exclusive_cmds: Commands that are kernel-internal only
> 	> - * @total_bytes: sum of all possible capacities
> 	> + * @total_bytes: length of all possible capacities
> 	> + * @static_bytes: length of possible static RAM and PMEM partitions
> 	> + * @dynamic_bytes: length of possible DC partitions (DC Regions)
> 	>   * @volatile_only_bytes: hard volatile capacity
> 	>   * @persistent_only_bytes: hard persistent capacity
> 	
> 	I have regrets that cxl_memdev_state permanently carries runtime
> 	storage for init time variables, lets not continue down that path
> 	with DCD enabling.
>
> 	-- https://lore.kernel.org/all/67871f05cd767_20f32947f@dwillia2-xfh.jf.intel.com.notmuch/
>
>> For avoiding the mds fields the weight should not be on the accel
>> driver.
> I agree.  So why would you want to use the mds fields at all?


I just wanted to have Type2 support patchset working with the new DPA 
work. I was hoping those concerns not addressed with another patch or 
patches Type2 work should be adapted to.


>
> I proposed a helper function to create cxl_dpa_info [cxl_add_partition] and Dan
> proposed a function to create the partitions from cxl_dpa_info
> [cxl_dpa_setup].[2]
>
> [2]
>
>     void cxl_add_partition(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
>     int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
>
> 	-- https://lore.kernel.org/all/20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com/
>
> What more do you need?


I need a stable API to work with which is not going to change so quick 
after a work like the DPA changes.


>> This patch adds a way for giving the required (and little) info
>> to the core for building the partitions.
> The second issue with your patch set is in the addition of struct mds_info.
> This has the same issue which Dan objected to about creating a temporary
> variable[3] but this is worse than my proposal in that your set continues to
> carry the initialization state around in the memdev forever.
>
> [3]
>
> 	The crux of the concern for me is less about the role of
> 	cxl_mem_get_partition_info() and more about the introduction of a new
> 	'struct cxl_mem_dev_info' in/out parameter which is similar in function
> 	to 'struct cxl_dpa_info'. If you can find a way to avoid another level
> 	of indirection or otherwise consolidate all these steps into a straight
> 	line routine that does "all the DPA enumeration" things.
>
> 	-- https://lore.kernel.org/all/67a28921ca0b5_2d2c29434@dwillia2-xfh.jf.intel.com.notmuch/
>
>
> Note to Dan.  I think doing 'all the DPA enumeration' things is the issue
> here.  DCD further complicates this because it adds an additional DPA
> discovery mechanism.  In summary we have:
>
> 	1) Identify Memory Device (existing)
> 	2) Hard coded values (Alejandro's type 2 set)
> 	3) Get dynamic capacity configuration (DCD set)
>
> It is conceivable that a device might want to do some random combination of
> those.  But the combinations we have in front of us are:
>
> 	A) 1 only
> 	B) 2 only
> 	C) 1 & 3
>
> I'm not sure it is worth having a single call which attempts to enumerate the
> dpa info.  I'll explore having a call which does A & C for mailbox supported
> devices.  But B was specifically in my mind when I came up with the
> cxl_add_partition() call.  And I felt using it in A and C would work just
> fine.
>
>> So if you or Dan suggest this
>> is wrong and the accel driver should deal with the intrinsics of DPA
>> partitions, I will fight against it :-)
> I don't want an accel driver to deal with the intrinsics of the DPA
> partitions at all!  But it should be able to specify the size parameters
> separate from creating dummy memdev state objects with values it does not
> care about.


Yes, but those objects have been there for a long time ...

I bet we can optimize other aspects of those structs as well, but this 
is being done in the middle of patches like Type2 and DCD relying on them.


>> I'm quite happy with the DPA partition work,
> As am I.  I'm just trying to go a step further so it fits a bit cleaner
> when DCD comes along.  I do apologize for the delay and churn in your set.
> That was not my intention.  But I thought the alterations of the memdev
> state were a good clean up.
>
>> with the result of current
>> v10 being simpler and cleaner. But it is time to get the patchsets
>> depending on that cleaning work going forward.
> Agreed.
>
> If Dan likes what you have here I will adjust the DCD work.
>
> Ira

