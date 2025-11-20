Return-Path: <netdev+bounces-240548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ADEC7633D
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D962E4E269C
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEB0336EF4;
	Thu, 20 Nov 2025 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V+HFTMF2"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC030214D;
	Thu, 20 Nov 2025 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670483; cv=fail; b=BmuuPBeKASPL/FLUkzipTRGzQTvr/3Rp57Tf+lOzAO8lIkNvqmA+5lOFVbj974IZ5g2gC8GDQscLhzJH1t5iPhRZyUm2Tz8p3OhQk421/jAG4CkHhI0EE5JCnVU6sFq/XrEdPrN4fyTzT0ON7hUdOw1Mbc6STLLtdxHFUTdCOxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670483; c=relaxed/simple;
	bh=3Mai63Ysnl/sGWii62CnGOIYEKsKapAPJFh77O5Gm5M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=djF3UX0aACpMXbQnhwoD0WmH2QhD7xgjEKAVxHsMxx6SbGNBmyTrRZD9r1FO69gn6Oe3ZeXyf4kbNiIlx3It7oY/3zYL0uAz0cCOAhPrlCJ3xWzDeCGDJNlOpyP7Q8rF0bsV3SEnpYFaVu3KgDhzBkw5IFinCi0RHOdudICoWhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V+HFTMF2; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9kZ6x2J4g70hiitFyXmcSLUZGC6g7RXzhi4yqC6OORjtttQ0kj87y8j1BwW7DCBSfjMnzehmtP3d3JW4mBvMtb1rQtGFef7k7cYFXBf+lj+K1+xXFoK6e2vBpm1z49SiBSNGoDoj2EEOOPB2OfYl4IG5juCYOEfY0c1GlVKnW7znviXIQw1VwnmkL9oItQJQNhdIR81ymW8tPmKKjwC96Q5OILshA0Rqk4waUC14u1UgdqQcj15QaV34/4TQVdpt5V5D+pekvQ0x5Darh+s3Q+cogFtyXRUEkslj31U9d725T/yixpSXE0iJYeDZOLt237mc7/SFuiNdpkBfKtYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSS+Qc8Z/pPv2AGFd0jzImmzh4aenjvvsRC9hmZlZDM=;
 b=DHxPgx0kbTzf68dAryMa+s/V0iRajFhBjEa5esIqReQbXXrWqmP6px97kOe0GfoXOzhd3UJLa9rCQB1r3E2uuNCYe6YQE8jOb+uay+TaJfQsE//aZHrqFZWp3h2UDJAu5CbarYzNXsH5kGJp3vvtDQpk5Ycu3bNCFg83dI97hyWuWdnh1MSTp+s+Qb/U5jzVQp5WjuFB3XnEFwBt7a1KcW8tbaFt05ssh2BQIbBxAuJG0+qqWllR/Ed9qe46xiWnEr3WVTOKD4SCIDztL86nYyN1tADKVoSAXn0YHz8M6neuskkeiRuLAyC8Rr1P+RY9Il8oH5AMvM8FMHXR1BvF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSS+Qc8Z/pPv2AGFd0jzImmzh4aenjvvsRC9hmZlZDM=;
 b=V+HFTMF2jNDAiZa6WAycn/2Ps905JQW61U7sDIhbHrnz3FKCUeUXFNAu41H7TMVO8Tu5rMpU2bimYpNs+8sG6WHPC1iPbtYM8w/QsxXkSvVjapMFgM2C9mNTTMgeNuOWrv/xpwrOu7ev9ljA1Wd7ZeVXDd/o2cKxvIj7ZXtybn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 20:27:57 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 20:27:56 +0000
Message-ID: <e507443b-71cc-4c48-a193-f5361a1f9086@amd.com>
Date: Thu, 20 Nov 2025 12:27:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 01/23] cxl/mem: refactor memdev allocation
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:74::21) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a77d28-8cab-49b6-f560-08de28734a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUdDMGNGQTI1YnRIK0VkeGFndjFGVE1SSnFXRjB2OEJsb1c5WldHajVPRW1z?=
 =?utf-8?B?TVRUYzY4RE5PUGpSUkJ6OVNPVmI2TG5HckZERmJVS3h6Mlk5ZXVqM25JVGl1?=
 =?utf-8?B?T0trdURGWmlJMW90Q1pmYnU4bkEvMHdZdGV1TXpWUXJIQ2tsYjk0bVFramZ4?=
 =?utf-8?B?WGNMMmw1dlBxKzVCWVlOSXo1QmdlSmUvTGtiU2x5VlV6aFV4UnBvSlBsVGp3?=
 =?utf-8?B?d2JuWFdTN1lTS1RsNExleXc3SEtSRTJJYXNKQ0FtYTljU2lybW9XRlFpb3ps?=
 =?utf-8?B?V3hvWXBFdHRRUFZ1M29sQWZLVmtFcXBBMmpQbkxkZFlGNDgweGJpKzZLRC9h?=
 =?utf-8?B?cmJoN3gyTFA3SitXYlBDby9sRVVJNE5DcnZJODdCNVNUUE1FN296WVMrZFNi?=
 =?utf-8?B?SHUwUVRXektJcUFoUmwvVXZ4aVU5UFhzWkh3RDFocDJxMkwyNHlaV294eEpk?=
 =?utf-8?B?Q1ZJYlVxTEF0UWp3MUF0aXRWSVJES3UrQkc3Z2Y2N3NTU1FFQVhiR2FwYkF2?=
 =?utf-8?B?T0J2b3Y4cVR3L250K2lJWlp1SXNyazJ6eG12TTBVYm5PZlFEdXphdStLUjRW?=
 =?utf-8?B?NnFIaGVyMW5pSmpaSW54QlBsb0VBVGhNbzZZYnNPVXkyS0Q4c0ZkdFRYZ3Ry?=
 =?utf-8?B?NDA2REt6TXVXMzBnOVBjODJtbGFJdUV6K09aMHlKWjBXdGUrYzdHUG9ad25S?=
 =?utf-8?B?Ky9NQ2Z1QkxCUDh5MGNrb1laNmNmY052SW8rdGJMbWRMWXNub3BQU3cvSGJr?=
 =?utf-8?B?RmNibmNuVzNBWE9ZTk9kWURyS0hXMmdmVGc1d1podlB0U2ZZT3ZCZFVIV3Vu?=
 =?utf-8?B?MkZwV2drVXJFbUJaTktHS2pQU0E1ekhJc3VnQ29sdjFBcHhEVnZvSjNET0Js?=
 =?utf-8?B?Ti9iblpTZXZxM2lld3FJUTJkcGJWWEJ5N3JnOEpqclc3TFM0WnhCV0R1Q2NV?=
 =?utf-8?B?YVlEcFlNdXdEVGZ2b0RGZVpGM1NtZnVqcmZSZUpIb2lzS1hVMVhpaGRqOUQ3?=
 =?utf-8?B?SEtHcHhxWWtaWkt4bFI2Q0NwVkx5MlBnb0FhN3dEMVBLVU8vMXNFZTE5ZEFG?=
 =?utf-8?B?Y2pWcnB0K2FpMm9vYVFTS3Yvd1MxYnhFYmhEcWhmYlFOZ0RwMkp5aE84bThB?=
 =?utf-8?B?TDVKSkVwTzlyUXliOGxJRWVxd2NnV0F1QXBINFpjMkRnTFl2cGo0WWJDcE5U?=
 =?utf-8?B?MEgyQ3I3YkVBeEJlUWtzRGIrdmY5TmtONktWRytDZ2dWY2hRZTkwc2Fhb1VY?=
 =?utf-8?B?WjNTUC9XUGFlV2Z5OHNYQzl5RWx3ZjVHQ1A0d25uWXNvK2N0d1FCS09hYlE4?=
 =?utf-8?B?eExLUHdad3ArSU8rckJwU0srR0F5b2tNVWRXa1dyeFVSMTVGcGFJMEQxR2Yw?=
 =?utf-8?B?RFBISTBianBoK3JLMDJKRkQrNjRXVkVpL2pzNVVGek9BOGFiL2dSaW9pYUoy?=
 =?utf-8?B?ckdJQnVkeUNMamRzMDlyTGFMUmhZY2p2Qmh1N0haVGZPdjk4cjlobTI1T0FB?=
 =?utf-8?B?US9BVys3Z2JveUlPbDBjZk9iZUdRS3VCZ0I4ZlRtdmd1VVRBNDdnaG9WV3I1?=
 =?utf-8?B?d2w0RHZVdjdyY1lxOUZhMVNVSnd0Q0k5aXVpdGN5SDV6NUlOQVMvcWFzazcx?=
 =?utf-8?B?U2NkRFQzZkQveG5jUWVTMWl2OU1wOTFveG1YL0lKOW9PeVNLcTlta09LVnd1?=
 =?utf-8?B?MENGd2FmakNreHRESXhVVHB0WU1SbDk2Q0gvT1VJLzc4dFRPNUF5MStqY29y?=
 =?utf-8?B?c3gvU01pMWtTVjdVcnZ4aW5PbTNVOSsyRitETWM5dG15NGt5MXI2eVFqQlZ2?=
 =?utf-8?B?MmM0MjMyWDhKT29HejMrY3JiZVhpL3BGTm52K3lxZFVPMURnSjFvZWpoOEhX?=
 =?utf-8?B?OVprb3IwUnFkSytxb2ozNUl2bzA3V01KNmlMWE5ZYWRRejBVWGU3cHRWblhz?=
 =?utf-8?B?OWxmSXRkbDhUU0JpY3RoTEpDOHgwc0oyZjZKVjI0cVQxMi9tMGZuelpmWnVy?=
 =?utf-8?Q?9C0sT2/Nitn0QtEcClokR0d5XaOeyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUJhRVkzdEcxWXRLZjhkVG9EbXZJMHc3eW5CSjFYMHJjVUJtekxwV0J4eVVR?=
 =?utf-8?B?bW1lQUluZ2FTSXk0ZlNCblRkU20wS1RnS0N2cno5RjFXNHVPL2tBMUNuNEQv?=
 =?utf-8?B?MlhwbkVTUFpEQ1ZucWxQb0tiOER2dDRGQnpzampjNFVOelJOQk8xaTVMcDRQ?=
 =?utf-8?B?K2dpUzEvR08vRUpSOTBZQko3cllXd1RISGhVbnhxSm9kN3U3QWJZbFFQREJa?=
 =?utf-8?B?ZUt2bUlJWWM1MjdsdzZxZkM4d0V4bDJpbktzNEJnMUNuMjZPSVBBVjJWSGMz?=
 =?utf-8?B?N3ZPQy92SENyU212WjJJRUk5cktnY1d6dU9URXp5dHZDZkRtUE5IWFNpMERU?=
 =?utf-8?B?TXQrNDJZbzkzWTIvUSt3cDU3S3pidmcrRzN1N1l3czBGa21kY0JHaXlkcUhO?=
 =?utf-8?B?YVU1bmp4Rit3bmE5QkJ5ZEtXZi96ZmVSeElNS0VVWXNSdmR5c0RNZm5hUEd3?=
 =?utf-8?B?VzBnQXNjSTRCQjgxbHZTbWxOVVBFSEcwSFBFMXFLQ3JYT3YvdmhKZjF5NEF4?=
 =?utf-8?B?SHhUSmF3U0hHbzRzWmdrbS91UWJWS3drS3RDajFSMUNnSHRMUWt4dlFEdmo0?=
 =?utf-8?B?RVM3UWplQzFHYis3SjM0MzJFNjJBcVFueDIyY1VHbjE4dGZUU3pyczkxWXBO?=
 =?utf-8?B?MnhSQ01VajhSWlJiZmlSRHlnNURic2pVV09wblpmM2ViOTRVU3prdHg4ZmRx?=
 =?utf-8?B?ckpZZUJJbnhHeEs1emwwK3NNUEp0S0Nyc29TOEhpK2I3OEwrYU1DaUd3SzUw?=
 =?utf-8?B?OXAxYXpCK1c3cnNVZEpacDg0N2t0ZDBTZTh1cGRQUkwwQ1FuT0lQSWd0Uk9i?=
 =?utf-8?B?OUFlSTRERkVaVU9oWXRpWWFHc2tGK0NvZ3dwbU14MHhob1ZQeU5CUTR0a2Iy?=
 =?utf-8?B?TlJYYWpOSmxXcXRMWG1nZkdHZnZ6Z0Q2MDJDcmVOekZoKzNZUng0bno4M1Qy?=
 =?utf-8?B?d0pFQXA3MUxNZ2tXVVdNY3ZnQjhVYmc2Q2FXbUhTZW1PNi8vTkNmblFwQWE3?=
 =?utf-8?B?S3lmSEJRa2c1TmFCZVRTOGEzSWszV0M0OFFFaC8zUWtrVkVUNE1NOU1uNVdy?=
 =?utf-8?B?T3poaVZkRlVlVHpkSTlwc0VGQXFIR0Y1OG9yejc0b3ZVd1M0MjdFNUkvcm9r?=
 =?utf-8?B?Y25HNEhKRUUyVkxtS2VSSlBlMEt2NnZhVzYxTGFZUHBLSHFsUEhWUnNYaEwy?=
 =?utf-8?B?ZitYNnAzMTFnc0daZjJTTEMwZm50aFJEaUNwQlc2MkRRb0N2RkNOVEhxN05D?=
 =?utf-8?B?RWpsRW0rWEpyQUJuYk4xcCtmVFVPTUZJZDlJWGY3aE5QcWQybmptU2J2Nm51?=
 =?utf-8?B?TmRhcnVBUjhJVStwMU1KNXhlVFZkb1BWS1BScW4wZE9HeTFCYURQbVZhMDdv?=
 =?utf-8?B?TmMrN3NTaXI0d0h6M2FLbjk2SkgwZWVDRWR3NDFwbDFwOWVZVEtydEJsNFpP?=
 =?utf-8?B?cHZ1S0xickd0ZGc3VUU3NnlhYTY3UTlGaUREZ01ad1pXZ3RLUVlsRjh6b2sz?=
 =?utf-8?B?ME1NU1hhTlBOU1d3STBmMWxOOUNvcDYwV0lJWnc4Zk5JcmdiUnRoZE5LSm9l?=
 =?utf-8?B?ckRDV1o0dmFQVFJ6Nk1PTFByRVpmK29KTWNBQ09YTjQzbEZlQVF1dlBSUnhB?=
 =?utf-8?B?VnBMQjJWditjTHd4cU9KZTJpbm1zR3NKL3BIcmw2OG52OWJaU0ZPd2MxNW5w?=
 =?utf-8?B?ZEZ2RngvYTE0ZlZpU0Y5Ni9LQXlzSGkyb0lqZ1pCMTRFT0JlSlJjS2tRSGRw?=
 =?utf-8?B?OVNVdVp1ZUhzUWt6cHhqbUhlcEQwSkdNTnZXdlo1QjRibW1jR1VJbHRUdkY1?=
 =?utf-8?B?bXdmd3VkOExpRFE3ZXRHYXk2cU83YWpJRzhOTzIxK0UyTjdwRXdkZEw5QnVG?=
 =?utf-8?B?ZUtRRWZ5b2FJUUhsS2pIZDA5L0FMbFBxOFlQZFRGbnB1UVJteEVBUmR6ZjZ1?=
 =?utf-8?B?d0hNVk5ZQXVhMlRJcy95UVQ2RkFqaDlBNnZJbzB3dnBDUzNLYWdoMXVudWE1?=
 =?utf-8?B?a3JSYlEramQ0NVlya1dpdE1ZZ09KNjBodndUWXVaQUVQbGZJZjg5TXR3YnJQ?=
 =?utf-8?B?SGNzZUtZY1BaUmVkSkRhRUVTTjE0YXJ1ekVYT05JQXNVWUhNQWpiQk9zSkMv?=
 =?utf-8?Q?1FPn/qg2RzReWEo5fWsTGNWh7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a77d28-8cab-49b6-f560-08de28734a56
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 20:27:56.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bGaqA7wiTJ73y3/H4jWgF//Bw8WbvtRzwzvxB8B5Ir00yfO0qazpALBh74vokyvNy4WL8aO46ESvoLr3oBbXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

Hi Alejandro,

On 11/19/2025 11:22 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for always-synchronous memdev attach, refactor memdev
> allocation and fix release bug in devm_cxl_add_memdev() when error after
> a successful allocation.
> 
> The diff is busy as this moves cxl_memdev_alloc() down below the definition
> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
> preclude needing to export more symbols from the cxl_core.
> 
> Fixes: 1c3333a28d45 ("cxl/mem: Do not rely on device_add() side effects for dev_set_name() failures")
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>   drivers/cxl/core/memdev.c | 134 +++++++++++++++++++++-----------------
>   drivers/cxl/private.h     |  10 +++
>   2 files changed, 86 insertions(+), 58 deletions(-)
>   create mode 100644 drivers/cxl/private.h
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index e370d733e440..8de19807ac7b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -8,6 +8,7 @@
>   #include <linux/idr.h>
>   #include <linux/pci.h>
>   #include <cxlmem.h>
> +#include "private.h"
>   #include "trace.h"
>   #include "core.h"
>   
> @@ -648,42 +649,25 @@ static void detach_memdev(struct work_struct *work)
>   
>   static struct lock_class_key cxl_memdev_key;
>   
> -static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> -					   const struct file_operations *fops)
> +int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd)
>   {
> -	struct cxl_memdev *cxlmd;
> -	struct device *dev;
> -	struct cdev *cdev;
> +	struct device *dev = &cxlmd->dev;
> +	struct cdev *cdev = &cxlmd->cdev;
>   	int rc;
>   
> -	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
> -	if (!cxlmd)
> -		return ERR_PTR(-ENOMEM);
> -
> -	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
> -	if (rc < 0)
> -		goto err;
> -	cxlmd->id = rc;
> -	cxlmd->depth = -1;
> -
> -	dev = &cxlmd->dev;
> -	device_initialize(dev);
> -	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
> -	dev->parent = cxlds->dev;
> -	dev->bus = &cxl_bus_type;
> -	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> -	device_set_pm_not_required(dev);
> -	INIT_WORK(&cxlmd->detach_work, detach_memdev);
> -
> -	cdev = &cxlmd->cdev;
> -	cdev_init(cdev, fops);
> -	return cxlmd;
> +	rc = cdev_device_add(cdev, dev);
> +	if (rc) {
> +		/*
> +		 * The cdev was briefly live, shutdown any ioctl operations that
> +		 * saw that state.
> +		 */
> +		cxl_memdev_shutdown(dev);
> +		return rc;
> +	}
>   
> -err:
> -	kfree(cxlmd);
> -	return ERR_PTR(rc);
> +	return devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>   }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
>   
>   static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>   			       unsigned long arg)
> @@ -1051,48 +1035,82 @@ static const struct file_operations cxl_memdev_fops = {
>   	.llseek = noop_llseek,
>   };
>   
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds)
> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
>   {
> -	struct cxl_memdev *cxlmd;
> +	struct cxl_memdev *cxlmd __free(kfree) =
> +		kzalloc(sizeof(*cxlmd), GFP_KERNEL);
>   	struct device *dev;
>   	struct cdev *cdev;
>   	int rc;
>   
> -	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
> -	if (IS_ERR(cxlmd))
> -		return cxlmd;
> -
> -	dev = &cxlmd->dev;
> -	rc = dev_set_name(dev, "mem%d", cxlmd->id);
> -	if (rc)
> -		goto err;
> +	if (!cxlmd)
> +		return ERR_PTR(-ENOMEM);
>   
> -	/*
> -	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
> -	 * needed as this is ordered with cdev_add() publishing the device.
> -	 */
> +	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
> +	if (rc < 0)
> +		return ERR_PTR(rc);
> +	cxlmd->id = rc;
> +	cxlmd->depth = -1;
>   	cxlmd->cxlds = cxlds;
>   	cxlds->cxlmd = cxlmd;
>   
> +	dev = &cxlmd->dev;
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
> +	dev->parent = cxlds->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> +	dev->type = &cxl_memdev_type;
> +	device_set_pm_not_required(dev);
> +	INIT_WORK(&cxlmd->detach_work, detach_memdev);
> +
>   	cdev = &cxlmd->cdev;
> -	rc = cdev_device_add(cdev, dev);
> +	cdev_init(cdev, &cxl_memdev_fops);
> +	return_ptr(cxlmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
> +
> +static void __cxlmd_free(struct cxl_memdev *cxlmd)
> +{
> +	if (IS_ERR(cxlmd))
> +		return;
> +
> +	if (cxlmd->cxlds)
> +		cxlmd->cxlds->cxlmd = NULL;
> +

This series caused a NULL deref in devm_cxl_add_memdev().
__cxlmd_free() only checks IS_ERR(cxlmd) and proceeds to dereference 
cxlmd->cxlds.

Adding a NULL check for cxlmd fixed the crash in my setup.

BUG: kernel NULL pointer dereference, address: 0000000000000358
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1553a7067 P4D 0
Oops: Oops: 0000 [#1] SMP NOPTI
RIP: 0010:devm_cxl_add_memdev+0x71/0xb0 [cxl_mem]
Code: 89 c4 e8 c2 c8 be f8 85 c0 75 17 48 89 de 4c 89 ef e8 b3 08 f9 ff 
85 c0 75 08 45 31 e4 45 31 ed eb 08 48 98 49 89 dd 48 89 c3 <49> 8b 85 
58 03 00 00 48 85 c0 74 08 48 c7 40 08 00 00 00 00 4c 89
CR2: 0000000000000358 CR3: 00000001553a6002 CR4: 0000000000771ef0
PKRU: 55555554
Call Trace:
<TASK>
cxl_pci_probe+0x409/0xb00 [cxl_pci]
? update_load_avg+0x83/0x780
local_pci_probe+0x4d/0xb0
work_for_cpu_fn+0x1e/0x30
process_scheduled_works+0xa9/0x420
? __pfx_worker_thread+0x10/0x10
worker_thread+0x127/0x270
...

Thanks
Smita

> +	put_device(&cxlmd->dev);
> +	kfree(cxlmd);
> +}
> +
> +DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
> +
> +/**
> + * devm_cxl_add_memdev - Add a CXL memory device
> + * @host: devres alloc/release context and parent for the memdev
> + * @cxlds: CXL device state to associate with the memdev
> + *
> + * Upon return the device will have had a chance to attach to the
> + * cxl_mem driver, but may fail if the CXL topology is not ready
> + * (hardware CXL link down, or software platform CXL root not attached)
> + */
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds);
> +	int rc;
> +
> +	if (IS_ERR(cxlmd))
> +		return cxlmd;
> +
> +	rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
>   	if (rc)
> -		goto err;
> +		return ERR_PTR(rc);
>   
> -	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
> +	rc = devm_cxl_memdev_add_or_reset(host, cxlmd);
>   	if (rc)
>   		return ERR_PTR(rc);
> -	return cxlmd;
>   
> -err:
> -	/*
> -	 * The cdev was briefly live, shutdown any ioctl operations that
> -	 * saw that state.
> -	 */
> -	cxl_memdev_shutdown(dev);
> -	put_device(dev);
> -	return ERR_PTR(rc);
> +	return no_free_ptr(cxlmd);
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>   
> diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
> new file mode 100644
> index 000000000000..50c2ac57afb5
> --- /dev/null
> +++ b/drivers/cxl/private.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2025 Intel Corporation. */
> +
> +/* Private interfaces betwen common drivers ("cxl_mem") and the cxl_core */
> +
> +#ifndef __CXL_PRIVATE_H__
> +#define __CXL_PRIVATE_H__
> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
> +int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd);
> +#endif /* __CXL_PRIVATE_H__ */


