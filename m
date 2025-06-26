Return-Path: <netdev+bounces-201427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB06AE96EC
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3E27B689D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0E23A563;
	Thu, 26 Jun 2025 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="KkPw7Csx"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304633993
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923472; cv=fail; b=Ue8/oOn1nf0hthNx7nzX+HckbDilAelggiYXWRRw7rFxDMw4wwt4vC6/M6dSufgR9uQXlbrKfptiF35+Dob+Zr2UPjmNNf6GY9dhkBwEiZb5RgcJG41NESKRnSjj9AACviWGAyvbRY5zZOYBEG8E8BN/rZauiImfnjjNbI8wCYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923472; c=relaxed/simple;
	bh=M8KAglYrHcymyNbr0/vVrnxuTq7pKA008CoBQsWFnj8=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NcDdMDm1/2xbhjLFWnNyFGvQEjRcStXEbGj1B00GOgbpEpYYuGyWFfkAZ04BAK/hGuKvwjEduDTZyjLXkv11kUKFXmQzrjfTHAVm1nPjyZMb/kp4Q1gSWIlm8CsERBm8GVXSqg1DNKzx82ehhyIQnCg+J7AxiRDoAhnLoJCkhus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=KkPw7Csx; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAV8fS2ti4Wz4eNen9kImLAeyIbjnj1XjXWjqwKgGoY8eRkBs1BhdEUH6253h0M8Cl5220BgByhRnzs8NGPO3MIBdH/8+mTpdWFPK3pWQqUhkpEVspshL7e1gZYhKR5dfNeDTrLXNE7gU95n92UW7CTBTzJ6I0ybXN0dKNt/5fl6lSoiApQwpONVPhOQ1R4Ftyr8lPbcJjVVM/J7fP2lg0tsQ0Y8KjKZzL8uyTbbJ/kvLpy2p1waHBKWhvuj37KEj7CuIOMEIVgogZXCSqnRECN5yjfI4JFCeEjKxycArydG7eLlsJWFMjXG+ogA0/N1A5nqPhj48XswN4b/KZgtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7SVR6EauZ9vvu1+xFAL32o+bRE4unEbPUAmy3Invhs=;
 b=qPCVnhchZW8I+/REmmK54B/6uABq/NKS2Efs0y/vmMKyddQ/z+D6KD80okB/OevZ2vPgRiZZEaPfaFNG7QZtYc9rorHaYqKF4kDqgPG6mkTt7iZt5S3BkivCfa0DkVoCowJTg+VwjWB7xxtR7bnyrDQwssjlc11JfznrbME5SCSmfZ7w9ZkggK/WBFpz9kCW/aDHMuZWpEqot3xunzUN+6lyIuQNMvoEc8BmP9UJ6+rWQbIEDzLUN8YG84GyTi2dnjbCCFraDUpTvufnO6VZQm68JNGX1O73+5ie8gX0s/C2ol63IPYO46GHtKkzXxEl/zDCYAI2oXzWTfI5Rz541Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7SVR6EauZ9vvu1+xFAL32o+bRE4unEbPUAmy3Invhs=;
 b=KkPw7CsxzN2LVzIf4TGdlmeUoq2d+171sbsDXhBPVRKVWDpmeBya2tdZQnmIJNJbb0ez1+a8OGQhZibNsleFfC2VuaRjxm7AV/pXHSPlWZwjrJajpPBgP8yb3i6I+LnapDQHFLFLnlyih+mGPzHcgKfJu9b9DYAq07aRWLChJ78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by DBAPR02MB6341.eurprd02.prod.outlook.com (2603:10a6:10:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 07:37:46 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 07:37:46 +0000
Message-ID: <e0105ca9-4903-4b47-b6f4-76f1e3da65d5@axis.com>
Date: Thu, 26 Jun 2025 09:37:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: phy: bcm54811: Fix the PHY
 initialization
To: Andrew Lunn <andrew@lunn.ch>
References: <20250625163453.2567869-1-kamilh@axis.com>
 <20250625163453.2567869-4-kamilh@axis.com>
 <36cf2f9e-4ed5-4040-ab30-c508b4a3f21e@lunn.ch>
Content-Language: en-US
Cc: netdev <netdev@vger.kernel.org>
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
In-Reply-To: <36cf2f9e-4ed5-4040-ab30-c508b4a3f21e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|DBAPR02MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 42586fa6-f6ec-41fa-4cdf-08ddb4845806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUVHU2ZWaDZHN3lSWjVMdUJNdVdzSk4rUEN2WGJ4bVZaL2tPUE04QnA0clRU?=
 =?utf-8?B?YlluQVdJL0Raa0RWSVc1MHhwQllDblBMNVdUWlJUeXRzRy93VnNNcGM1aFls?=
 =?utf-8?B?Ti8vbzBLUnYvSys5VWo5MFIwZENmWjhhai9ONVhraEJFWUw4bVNhKzhjNzNO?=
 =?utf-8?B?Z0ExdkZUTHY1Qm5sZWVkKzhDTFVKNldDYTkrVlpTY0FIb1BPZEVsZ1ZESFkz?=
 =?utf-8?B?V3YreUkyTFVOMDdnRjVxMUhsMktoOENWS2FwMjlnK0VXcFlRWUFVSUZDelA0?=
 =?utf-8?B?NXVaNWx1NDUvcTFjRlFjN1R1T3BVUGZrd09VUm10V2hiWFhOSXRIVitqMysz?=
 =?utf-8?B?dloxUU9kbTl4cDYzYyt6cjZKa3JzVWZYY2hrVERZNk9qTHlXMHlJRHlrNHN2?=
 =?utf-8?B?Njhrd3cyQzBJZGJPeWJULzBZT3FJd3d4M2cybmI2QmQrSmNsSm1HYUdpZ1B1?=
 =?utf-8?B?MHlKN1VmU1Y4Y09zK1FjWnB4WjVOT1FIZVdZaXlBOUorbGN0V0lXTjdqVk1y?=
 =?utf-8?B?U3NudDJLVWxYWmxwM1JZLzJoZVZGa1dqWE5udGRvTlB0RU1BWklOZWVuQ0N6?=
 =?utf-8?B?cko3Y09oRlNhb1F0cFJwY2o3TDJGTkZUaExVKzdMbWhsODVLdEo2bS82blFr?=
 =?utf-8?B?S0xVMmVhQ3N6YWE3UE9hT2IyNDRSVjNYRzFMaDMzdWMxeFM4QTdXRHZlOElK?=
 =?utf-8?B?ZFcwM1lZUDhPMWRRWFpRRE9QeDZIbVluazFYdGgrL2dzRklneVhIK1Uxb0ht?=
 =?utf-8?B?cHF3b1JYZDFQa2lLNUppbzBZTFhFckY1a3FoNmJWSE9HWmVNZWhkbU9ZeXpE?=
 =?utf-8?B?a2hvb0J0Vm5iZ3l2MlEwUmZSdUVIYmpsTHBmSUt5aCthUmlCd25aLzF2ckJt?=
 =?utf-8?B?R3V1UXgvK01iWkRTN2IyZ2dubnpVNzd4M2l4OVlSWjVOVEZCOVRCZFdQUU5Q?=
 =?utf-8?B?Y1dRVVZRWlVvRGtFY0xxbGVRVmdDUTg3VzJPTnpGMVpkMjJUUHJNcGlJVjN6?=
 =?utf-8?B?ZTZLSHRUa2hpT1ZQVHRzNGx0TUFOdTNNL21lWTRIV1pQWWdEYjZsOVpVOWZ4?=
 =?utf-8?B?WEs2bFJhcTloaWhWVlJRSitqb3Y0T3h5NCs0WjJEdVROcWJEUnNwdS9jRW81?=
 =?utf-8?B?dVpGQjVmWEpxMCtGY2NVQkZmQVc4VEJsUnFId05BZ0pVZlBLODFRNDZMb3Vj?=
 =?utf-8?B?eldiNDFCeTNDUXRyV2tBNVpGZGhrZ1ZKeWsvVG1makdkVXV6bURmU0lUYWlv?=
 =?utf-8?B?ZFpRdFNyYzl4NXVEMHpZaXM5cW5iMGE1cC96NFNqalIzWGpYLzFBQ3hqU3BU?=
 =?utf-8?B?U1lzcGRJWHgvcU5pcDdUL3oyeWRNRUJaM29TaVVGaTVNRW1tRUFBYk1vWmF0?=
 =?utf-8?B?ZERVYXZ2Y3JaRHQxMVFWYUxLZ08zdUt2UHVGRzZXR0tkSUJJS1hJS3R4bnRK?=
 =?utf-8?B?cW9idURvQ3Q2RDZsRWRDcWQrTkdWejRBem1IZFR1UzNtSE5YOUNTV2lKR0ho?=
 =?utf-8?B?bFh1alNINCtUSk0zYWRxTGFBWU95RERqVENTODRZY0Y3d0dGYlNHYjF5VGZV?=
 =?utf-8?B?WmFGZmxiblhCYlNxOFRqZEhlZFcvcyticSsyRkU1MFg1Z2xRSC9FZGFPWWUx?=
 =?utf-8?B?aXdEN0JPMlM1L1BYWFdKSm1VelIrakZTVUs4SUJjeldrbWJGaEpWckpVUGxV?=
 =?utf-8?B?eDRFY0VLOVFrVzJUSFdrQ1VtUU1xSUkxenh0cGEyODVqTG1SSEZxTCtuU0pC?=
 =?utf-8?B?aVZIeDFjTXFQdEo3MWVxcnQyck40a3NRZXdVaWlTSVJFd3NUODNXVG1WZDNZ?=
 =?utf-8?B?TUk5b3hrakdlRzJaQW1CRVNNSkNKQnFndmRBS09IazJrd3F5RllGZzVRSS9z?=
 =?utf-8?B?ZGhKQytoWjZlR29QeHp1Q1puK3JHTEpjZDh4MjhCVG8xZUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y29pT002TUpMUm8rZk50bUFoWGxkOWhtMTFWYlprY2wxbWV5a1FqMURQZjV0?=
 =?utf-8?B?UVhieEdwT2FqQnNoQzNIOFNqSHMzSzg3ZmRBM2JXK0hxdWpVeWRpME9IeTV3?=
 =?utf-8?B?ZTlHVy8xbVJMUy92M0R5UFB3Q3ltNmJOVjUyZ0JVQWRNWFVKM0VyZ2RENzJQ?=
 =?utf-8?B?cnNLTlpPS2E2blVqRy93VjV2QjQ2dlBpSGMxVVkvMTM2UFJYM3Z5NXpXeG91?=
 =?utf-8?B?N0VIcEk1WmNGMENPM2FodlVXK2RsNTlWejVZL1QzMEpvcndYMkpJWklZYjhy?=
 =?utf-8?B?OVBabnRTdTI2cTBka3Q2UXVMajdkWUl5cHp2bFhieGVaRThVSjNEQzkzS2py?=
 =?utf-8?B?Y2lWS0ZSR3AwcDhtNlFyazkyUjhwL3NKemkySnIzbndwTzNWam9BSGtCWjNP?=
 =?utf-8?B?aldWMzl5NHlmQkxwcXhWMFZvSXg0TU1xTUp2M21FTVlHWlBPb3ZMcThtM29W?=
 =?utf-8?B?NzBMS3k0MGNPckdvWmZnaGZUd21mcDBnK1VjVTU2aGgyVVhteU95U09JTWtL?=
 =?utf-8?B?aW5Ec3ZDOFY5Z2lvYmdoZ1dRRGN5T2RvcHVZcTJnL0xScVpNM28ya05HaDc4?=
 =?utf-8?B?dWZKVWRibWdPdjhra3E0TmM4L1UwZDN4WnFXdXNpOUhiRmtZQlorWkc2QlJl?=
 =?utf-8?B?YVBOQ2ZENjN0UnFXVUVycVg4K2x3UlZYMy91RWVjaDhPdjkzajJBU1VqOGt2?=
 =?utf-8?B?U0x4VXFiK2dubTZFUVBmYmlOUk9Xd1cwMXJrR1UwWTN2Zm53M0pvQy9vNWpQ?=
 =?utf-8?B?ajNtODA4a2NlUTM5OWNGNEsrd3ZlZFlLbnlMU0M3UUdVVzBGMGxDcUV1UHQy?=
 =?utf-8?B?WVI3aWliUVdDY2dPUkpvbEV2Q1ZLOHg2SCt5cjhmd3JWMklvVTNVS3J2aWI2?=
 =?utf-8?B?aThJNmtRaSttbkcyTW1qMUErUGQ2eGUyZkovUnVmYmRBejBaT0lmVzc1SHg1?=
 =?utf-8?B?TTBDQlJYZU82UFA4ZGg0NWlVSTFPTnFheC8wa05kd2J6cklzTWdsMHBvOTdx?=
 =?utf-8?B?R29yTVYrSm51MUlCaEdEVGptNHR5L0ZWZ1VkdzBWeUcwSGpJbWV2aVFtTDJL?=
 =?utf-8?B?bkFKbGxaeUgrL3p1aHVUdDAxUVNwdGNnWjgvRXZVbUxoSFJZNC96aHJVQzh1?=
 =?utf-8?B?aVhxK1VIQ3pnelBCeGJlYjFwOHQycUxvaG44a21mL0txazJXQXVHUk9BTU5V?=
 =?utf-8?B?c2oralVmakZXL3IxQ1RydFMwN2czYmJMV3Nnd3Njc1BGazBBMnMxcW43d2Zv?=
 =?utf-8?B?aGlSbzJsRGFSTkJNWWMyK0F2TE5zWWxaa3IvTXk2VWlwWFp2TXF6SkNtTzNV?=
 =?utf-8?B?Q0k1U3RmOHVDSmMwZDNtODZiUjFQTDg2azlVWUJjVkJZWG9iUGhHbDVmcWI5?=
 =?utf-8?B?WWgwbzVBUkZvSGRyWWhoOVIwOE92TklOenNsZWdRQ0hHM2dLTXAxNW8rVVRH?=
 =?utf-8?B?Q2J4WWtVZHk5S0ZVVjd1bllkT0NVdTIyR0ViR0o0b3V5cjBocFNJM3IyZ0Iy?=
 =?utf-8?B?MGUwTDUxSlFwTlBaSHlQK0IwUFhIZjRnb3ZSZGczY3hnNFhRZ1JLWXJUK3d0?=
 =?utf-8?B?Rk1JanEzSkVYY0hLcENMNld3d0wvc2dqNnVVeWg5WlhQaDhWY0RiSWEyTzN2?=
 =?utf-8?B?UzRBTkJteFJ5NENCbnJ1LzFIaXY4WmRqT1l1bVZMTkpGU25LVlZ0VTlmZ29B?=
 =?utf-8?B?Mm02VEcrMVptSFp4dzVzYlJCNnMxWTR1ZndiaXd5REFtd1Nha0t2MEZRSkFY?=
 =?utf-8?B?SFJUamxxVnhYOHNKUHJCejhrOFJBOXBQUS9OcXNidm1uY00zV29xTnVTaEQ1?=
 =?utf-8?B?U1FaMGs5QjBZS3FiTmJnRldZM0hCRFArZkZiZ2pLSUJMT1Q1ZkZsc2drclIv?=
 =?utf-8?B?cWFIRExycHh1TjFwTkdxUUo3aERodzhFRGtwV0NvSFExd3dBQmU1MWl1ckJB?=
 =?utf-8?B?TVhZZXg1WXl0Y0dkTHltdFR4d2lUWkNPRXNySkh1eUxVQllPMWZGbmk2Zk1v?=
 =?utf-8?B?NFlaKyt0bnU0OEhjS2tnaC9vRndJS3BzbnFUWG40d3lSMFEvQUNHQmxBdlJ3?=
 =?utf-8?B?dTJDU3BXaDlYanB0bmt4MjUxeXNmUlpsVk4ySUc4aU1Yb1pLNGdXbDNjZG5m?=
 =?utf-8?Q?Vm2BcCGPhDWkabFDtaMyH6I4l?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42586fa6-f6ec-41fa-4cdf-08ddb4845806
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 07:37:46.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdgntdnJwXQkpj+8LKT3m302xrRIMD3b2PKyqYGzF5THYSNwAKVGedkVLdrXf62t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6341



On 6/25/25 18:49, Andrew Lunn wrote:
> On Wed, Jun 25, 2025 at 06:34:53PM +0200, Kamil Horák - 2N wrote:
>> From: Kamil Horák (2N) <kamilh@axis.com>
>>
>> Reset the bit 12 in PHY's LRE Control register upon initialization.
>> According to the datasheet, this bit must be written to zero after
>> every device reset.
> 
> This actually sounds like a fix. Why are not you adding a Fixes: tag
> and posting it for net, not net-next?
Yes at least the patch with bcm54811 initialization is rather a fix, but 
the rest (MII-Lite phy interface mode) could be also considered adding 
support for this Broadcom-specific phy interface mode for bcm54810.
The bcm54811 is likely only available in MLP case, which means MII-Lite 
only and from this point of view, adding support of MII-Lite is a fix too.
So if it does not matter that we are adding support for non-standard phy 
interface mode including its effects also valid for non-Broadcom PHYS 
(full-duplex link modes only), I'll submit it as a fix to net, instead 
than doing it here.

Kamil
> 
> 	Andrew


