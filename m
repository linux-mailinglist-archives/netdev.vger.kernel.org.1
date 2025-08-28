Return-Path: <netdev+bounces-217640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79FB39620
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B95361B18
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A309426AABE;
	Thu, 28 Aug 2025 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S4jy0DFj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58C13C9C4;
	Thu, 28 Aug 2025 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368145; cv=fail; b=VutrVdqyTHBk6wJahcXUENFMkRP4ZWEEeeMQcaYAOIyptb5bhcrbvL4OqZ3rpJWmHKBNsHeNAOH5+Po3K/9YPzWP+tCH5AiEJRdrhg+411kp1cYU0DWhy3hu08F35ZLR0mxPERhJZOWK0Kf3cw2xJZL3Z//UrE/wV5EtKgcC7Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368145; c=relaxed/simple;
	bh=zO4SfROS9xBDCd0mpetTekvci9R83j1WcMkLKvktMJE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FpxVRQ5BHdEiSmhzY1w176RGy6OQXYMwqjCzz/SxMf9AP/z+TSU5mOKSh0V44mxhlACwjkO2NjGCkYQ4eic9eqx88oyge5VNnMJfg7uZ6Ua3x5ZGLf4c09Up5ZtP9FARA7j5018EyZM4M9lG/eugdjej8YXEWiil+OrpK075ejs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S4jy0DFj; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZWjXkAXSt0ZDRkK0skb4WvPG3MrwEPjTLGHTCncYLVAeqdtR5ITkrLogY3BeDAmsw+7tb2bIPFujnKWvm8jxbm7iRIXLeCb9efFYpdAQsP1swx8Rg2n59tuZReyHywU5BSzhH9PJruXqK3g5xY8H/FpCPb6AMLpp8Zfs2TZXWqEeA8J8vHrKxDBfBOiSdXauhX70F0qPPNJ4jjj4IlEon0r3uxN7bY0AxA2pcJXPIfaivhLyljMdcbpnn2U8soOLImkoztBLoJRloDTQQ3Rmbd2Rm5yPGAATplLlFC0iWsasOviUtD7xkmCASCWXK7XfEjm6HgOLW+5k964CvrV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrcJS6l6g6x6d+wXmw0XDoWmij8GrEZApA/FyiCzBzQ=;
 b=FnXLwxHLKx0waLIQzbUM4vfFsZ6B3Ou1/XppauVUJtvrSr79SVJTctrHNr1sH/+z+S7WifqdhWmR2lY5ARSFR9vxN9thmHfgDPQOlhMs852CFw2Ec+OwrbqpN4fdKHrtnt/6rdcUPU4reHlCwA8rFyGsWa51mEyBFFi6l+5C8xPLekFzJoJGxeXShFOv7pjyEJVSxmXEQ+IxJkOnuTxPaZsKSfl5eJGoD0YM/k/GHzHvE2Xwyd/DE6HZ8WEjfpQmwkmJgt6UK1pjuSh8aC+qE3PCHCMytrRbAAwp3wD7/E/hWmpIXVxjZxyr6V/BYBSe8/5qX6RyqnokcU0Z0VTLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrcJS6l6g6x6d+wXmw0XDoWmij8GrEZApA/FyiCzBzQ=;
 b=S4jy0DFjzrz6TLPayAhzdgKTXC8jAk1Z3G2RYlGi8dclLs7D+Ya/wodtS4OMUP8rPio1BTQhFsp/tPKw9fJWbpWDgt/ibTZafM4ajEBvDeWH5+vNBuPW6ZrEXwAkBhaAC8HuUY1fGbsajVpi65728zH1jdLr7iaXencW2uZ/hwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Thu, 28 Aug
 2025 08:02:15 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 08:02:15 +0000
Message-ID: <e74a66db-6067-4f8d-9fb1-fe4f80357899@amd.com>
Date: Thu, 28 Aug 2025 09:02:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/22] Type2 device basic support
Content-Language: en-US
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <5cf568ac801b967365679737774a6c59475fd594.camel@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <5cf568ac801b967365679737774a6c59475fd594.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0277.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::21) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 734a5805-8e7d-4f5d-fe0e-08dde6093372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1JPSVRGbzlOZmY2dHZOQm1jbmlKM2M5SkY5YXZiZkp2MXk2TkkxMHNHNnhy?=
 =?utf-8?B?b0lCTUZ4Y3JOcCtqSHVtKy84SkFOKzhaUFZhak1XWHIrK3R3RGlJS0xqWGMw?=
 =?utf-8?B?QzZFUDZkR2tZNFV3dkxNYzBXalJaRGw1MngrWUZNajhnV2FYbmszL2hoM05S?=
 =?utf-8?B?TmJtVWNILzdTbTFBaUhMelJndlpSdU9pK0pwZjJ1SEtNNUtraHBvN2R6YTNy?=
 =?utf-8?B?UzR2N1h0WjN5aXhLOE9ST2hkUHdlVjh3MjduZk5Nbkg0OG5taWF0aW9wa1Y3?=
 =?utf-8?B?eFhNSEpGd0Z2L2NCdUJNb0JENENwdHprUWFrd3lUUExLbDM5TDVvUHExWE0z?=
 =?utf-8?B?bjYzMjIzYlo0aU0yL01YRFErWnFWWUJTdEpFS2JFQVc3Zm1pRkZYM2lqeVAv?=
 =?utf-8?B?Y0o2R2pMRXNXZ1pRZUtpaC9sbUlFKzFWMkF1T3hlOU80KzVDQWxEemdZWVl1?=
 =?utf-8?B?SXhaYzF5c1JMREFjZEswUDNXQmdOeW5yWkhIeEkwZVBlQmp6MzBLejlaMG9t?=
 =?utf-8?B?dFFQR2tiQjg1SHdYNjBkR0ZNOXRuTUZtRzkyT2dFOVpUSk9kak1YQUJJMitQ?=
 =?utf-8?B?Y1lmaHpDUU51VGhjY1VQVnNoQzhhSllvaFFMK1R2d0ZpRTEvTmp5UkNwVnlu?=
 =?utf-8?B?eGYvaTVJY2JmRldPWWQyazJWakF3THA1Z1pCYlpPZGxUOThKVFE0Q2trdDM0?=
 =?utf-8?B?UzQ5eW81ZHJpNm1ORVgrVXJuOUNEZU9Sa2xXOUNqdnRoK1dtQXI1T3ovSmQ0?=
 =?utf-8?B?UE9OMmVkakQzQVc1cmg2RjFsMVhFdzBQNmowNG56SW1KZkZFdGRoWkg2S3o1?=
 =?utf-8?B?MzBza1hzeU12ZS9PUTFaYlJsUnFCelJoaUgrU3BqcW9mSGpaNWhJMy9jaXFu?=
 =?utf-8?B?TVJLa3ZyQ0hIOXdQaTRkUEs0WG9LKzFCOHJvVXhqV2xZalpiRUNkUTBuQzJ5?=
 =?utf-8?B?VGt2Q3NFcUVSQittN2VKU2dDOHRkSURkV0NaQUE2NnBqSVFSN095eXBzZXYx?=
 =?utf-8?B?d2daaDBHZjI5OEVzT0VydWQzNFAzcVhCS2QvNDl5UVRIaFhGa2M2SG5LYjJN?=
 =?utf-8?B?VnlzZzV5WGRENTB1Mklvd0g3cTAxUnRKL3ZpZ3hFZXAwNkxUZWkzbjBKYzhh?=
 =?utf-8?B?UnZEUTFXeWpFRTl1K0lORm1FSzI3WlQ1aW5yRkhmdnZlblh5dkxsTWdzV2lk?=
 =?utf-8?B?L0k3VVZzWkVmSGhvbmhzV2U1QmFmQ2JMYlJHeVU1MzR1cGVyNWs5WUQyYWNS?=
 =?utf-8?B?UkZLNkJXNkwxUjJRZ05rdEdzT0JZN0R0RkZpNW1walNiTCthRS9ZQkIrTVM0?=
 =?utf-8?B?WjQyMEhTNHJXMXdIRm90Y2U5L2V0b1Z4WjFsRVJ2M0dEcmpxQmJZSWN3dWFm?=
 =?utf-8?B?czNZdERGUjBqTEJicUk2UlBtekdlR2g1NHgzVFZlTWx4NXZPZHZIMmZDdHkv?=
 =?utf-8?B?OHFkbEZmUW1NVUEzZ0U5UFNjeVNGcE03eXA0UlNZMWwyL012VGxRaklSSCtk?=
 =?utf-8?B?MW1KeGo0YzU2ZGd3ZVYzV1FZVjZLRjI3M2V2ejBaa3VWeFN6NmNWTHJ6VmpM?=
 =?utf-8?B?MDBGY2w4TEljc043Y1R1QkVrTGpOSEJHa0NxREs1ZUkybE4xWWwya3UyT3pE?=
 =?utf-8?B?YUZuaGZCMEVQRnkwVjVPMGsvMzhhMEZFNHorWkQyWHo5QjJhYXVVVy9FQzFx?=
 =?utf-8?B?OTRucDdVK0lPUzBaWWFoc2tFMW54R3M5dXJ2dkxOLzhtaW9GVzhtaUVMamRH?=
 =?utf-8?B?VzRnT2FBOU5wZFZwSENXTmE1TFhHK0tkbmdsUWcreUlZNGJ4N3NSN24rOVlx?=
 =?utf-8?B?cDJ6SndBRDNUTkk4ZmcrM1VmVS9MRjZaaXp4NGNXakoxVXdwNmg4RHRVeG82?=
 =?utf-8?B?QnBkOThVcWVDb1FWTDVIcHFlRmFRZ1dZTVpkS0RBejA0dTlLYUhoMEZMaXhq?=
 =?utf-8?B?S2FwN0wzMVZyNlcrUkpVMnU0NHZYRWFjVk11c0d2WFlLRUovcHg3REY0SmY3?=
 =?utf-8?B?MlJnVk5RMEpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tzd2cGxUYXYycTY3Vzg1SUZGckJxVUxXQ1lGNGFWd09mNUt4aC8yKzJFSzc0?=
 =?utf-8?B?SnJ3dmpHUTdQZGtLSkY1bjY5aG8zQU5HWDBSTjF6bjR3MWlxaFFGNEorTXJH?=
 =?utf-8?B?MW1ob1N4YzA3WHhqZnVWWUN5dWU3VEpySmpVZG9DVzc5cWtDMVE3N29VQ293?=
 =?utf-8?B?WXBtd2tLVVNFZlZRbFl0ZDFUL29scGJPWWRiRU8razM5YU5ybFUzcTNHY0l3?=
 =?utf-8?B?S3pEZWhUcXdaQStTNHk3M3U3TUZaZDd4dzBsUnY3QWtiQ2lYOElEMnlEZjFT?=
 =?utf-8?B?VDNieXlEQ2VZbFcxVE1NYkY0K1RnN1V2SEpCVTluMnBuSjM2TjJtOU9OSGE1?=
 =?utf-8?B?ZXE0Q2hSbXlybnVQYmtDMDBlSTJjdGdpREpObXYzKzZsRkJwakdMNTVzOSt4?=
 =?utf-8?B?a2RYQjZWU0JkdTZkWXA0clVVdFh6RXVqQjVJdUFiajZiSlRRS2srRmlIMUxJ?=
 =?utf-8?B?RmNxY0lkRXZMRzZDeUdUWVBZZkhpVmVNWjFJVXNsU2pKeEVySFNGSmxOYlJV?=
 =?utf-8?B?RzBQdWxNb3hETFcvVzlxaUEvRHhmamh6OU5DNkc4cWNNdmtDQkxJRFp3OXI2?=
 =?utf-8?B?eWFQNm04VUYwdGdNR0tTRG9JWWwybVNpQWtSeHlQQjNYdzdRcmdRV0dIb3dw?=
 =?utf-8?B?VDJ1ZWFoMVM3ZTl5My9VVGtrNXZzZEVGcFIwZm9tN0lOd1RMTTB1ZDV5ZGl1?=
 =?utf-8?B?ZHBLMk1UZlpvSWxHcVdsRGtCUm9UUm5HZmtXTE1udGdSRHF3SndPWXBLL1gz?=
 =?utf-8?B?WGtHOWU0eEt5Mk1TM2orNGdaaldwaUF4bnpacW1KUW1FVnRRYktSQ0kvb2hv?=
 =?utf-8?B?UGZtWVBXdzNaSTE0NC9DZDZuTEVKcFJoWU1WMzFWT3BKYllEU2NGRnUzMVJh?=
 =?utf-8?B?OEY3L3JWV213d2REcU5rZ2ZMM2FJSEZOdExkaVVQejM3NXNxZTIwWGFHdTFO?=
 =?utf-8?B?a21UQjdTR0RYTXlFdVdmcDk5SVZGajVNa09Cem1UVGdkUDgyMHJVUkFMZThB?=
 =?utf-8?B?QU1GdHdwL2xYNlhGSDA3MTVsUkE4cktzYTdkZTRuUE9MUG5qZzYycWtYaFNS?=
 =?utf-8?B?aHlQRzVKTW5tcFpscmZpYUNWbklRZ1JtR1pGU3pqaFBjT2FqeWQ4TEMrVEk2?=
 =?utf-8?B?aXUzVUhrNHVYKzZMVXFmUWFocE9Cakt0aitzVytac0hjRi85cXdqN2xpanB5?=
 =?utf-8?B?bGlpUURaK25GU08zb2dSbUI2L3JwMUVjOHNYeDZkdFl5VGRzaFJYRkV4Nnh1?=
 =?utf-8?B?M0VlMWNTS0t5WDdHREtyYVl1N1hBZEc0L1R3N09YK1JLNVgvdHZoZzI2SGc2?=
 =?utf-8?B?Mm5mZjg3UGh0RXVxOTVIanhyaks3YTlNYzdQK2lkc2REK3NrN1VOUW1mcm9K?=
 =?utf-8?B?Qml3cm5qQkJQVjZ1a0NZUWdWYktISHNOQXRaMTNvekR3WVM3Tkc3bitmRWNz?=
 =?utf-8?B?eHkrL25ORXREMHBudDJDeVllZ1ZEb0t3QnZ0dlp2R2NINm9jTjBFMVZXdWs4?=
 =?utf-8?B?a0FaZGw1TGxFVUdnRzZGRER2SGNIUHVQUXlpdkk0aWk0MjYrMEs1dnllS1o4?=
 =?utf-8?B?d2JScFg2aWlyQS9TT1J3ZGo1SVNDVi9oQUpZVGpVNEdubGw0elRneFp6cFAy?=
 =?utf-8?B?SFA3QXNPaFREbTdMdjZYVHdVZDN5eWxiNUJFMUV3R3Q4NnJJTURESjVzOEp4?=
 =?utf-8?B?STltRHBWWEJ5ZkJmQ3pTYTArNVhLVldGSm9HVCt0RzdCYjh2Y2xrLzV6djly?=
 =?utf-8?B?S096WlFyUzloWXNrM0ErcnNvOEVUTTJQSVpXQ2MzUFB0UC96MEJEVlVnV0pw?=
 =?utf-8?B?cUZ3Q3B4ZU0wTnFqRG56UUVqZ1MrYzNVd29GUGR4bjlnck5HcFpQOGtCL045?=
 =?utf-8?B?cWF1ZkV0bGZ3V080MTBIYVE0WG1xUlE1WkxwZXN6RTNGVnZyNzFRbE1BWUhK?=
 =?utf-8?B?amcxS2FHd0pQeXFvUHVqeGx1OW9HV0ZYeWJaRlduZmdwTGE4R0JUZDFGUzhu?=
 =?utf-8?B?OEhGdGROZDREaExXWnNYNGxZQjV5MlVsYk5YSnVqcklkL0hwa2QydGhqaU0w?=
 =?utf-8?B?MDBsaHJrOWhtNjFrUERMcFVrVzVNSys4RnFUVVNQckwxWHRESysvQkFpSW5y?=
 =?utf-8?Q?q7I8VnQYicRwStFBL2gWjLrl+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734a5805-8e7d-4f5d-fe0e-08dde6093372
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:02:15.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU6acP919MIltBadPGMqZwbVLZOMkSQ5pVc3J2wEMeVa4APaj0s8gOEwIoLhdKX3ZtZdpyTNHOiGmOoAT/k/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946

Hi PJ,

On 8/27/25 17:48, PJ Waskiewicz wrote:
> On Tue, 2025-06-24 at 15:13 +0100, alejandro.lucero-palau@amd.com
> wrote:
>
> Hi Alejandro,
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> v17 changes: (Dan Williams review)
>>   - use devm for cxl_dev_state allocation
>>   - using current cxl struct for checking capability registers found
>> by
>>     the driver.
>>   - simplify dpa initialization without a mailbox not supporting pmem
>>   - add cxl_acquire_endpoint for protection during initialization
>>   - add callback/action to cxl_create_region for a driver notified
>> about cxl
>>     core kernel modules removal.
>>   - add sfc function to disable CXL-based PIO buffers if such a
>> callback
>>     is invoked.
>>   - Always manage a Type2 created region as private not allowing DAX.
>>
> I've been following the patches here since your initial RFC.  What
> platform are you testing these on out of curiosity?


Most of the work was done with qemu. Nowadays, I have several system 
with CXL support and Type2 BIOS support, so it has been successfully 
tested there as well.


> I've tried pulling the v16 patches into my test environment, and on CXL
> 2.0 hosts that I have access to, the patches did not work when trying
> to hook up a Type 2 device.  Most of it centered around many of the CXL
> host registers you try poking not existing.


Can you share the system logs and maybe run it with CXL debugging on?


> I do have CXL-capable BIOS
> firmware on these hosts, but I'm questioning that either there's still
> missing firmware, or the patches are trying to touch something that
> doesn't exist.


May I ask which system are you using? ARM/Intel/AMD/surpriseme? lspci 
-vvv output would also be useful. I did find some issues with how the 
BIOS we got is doing things, something I will share and work on if that 
turns out to be a valid case and not a BIOS problem.


>
> I'm working on rebasing to the v17 patches to see if this resolves what
> I'm seeing.  But it's a bit of a lift, so I figured I'd ask what you're
> testing on before burning more time.
>
> Eventually I'd like to either give a Tested-by or shoot back some
> amended patches based on testing.  But I've not been able to get that
> far yet...


That would be really good. Let's see if we can figure out what is the 
problem there.


Thank you


> Cheers,
> -PJ

