Return-Path: <netdev+bounces-112182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8A7937502
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 10:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6162829E3
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409C2757E0;
	Fri, 19 Jul 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="B9fSd2AM"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E836AF2;
	Fri, 19 Jul 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377606; cv=fail; b=ln3cDNyvf32P14WE36RagUytgOJXO8CUBwq/LUju2wlegNKq6JIR+P34+4I01+9q1FbE/if1v0ooEzIcr20UOL4p7cjKKf+iiu+8azsvrLBgpjjYpj1e8+/uGHlrzgVwHDDkm2uaHbhAt/CCxubSIjLXU0nGpGM9rWx3Sij1WM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377606; c=relaxed/simple;
	bh=eHC5QEo/8o9NRe8SakFtMVJSDcA1KQ9psThR4A9Zn/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EebQZ8NqHAHQ1KdLI0BqWYC306mzEzDSAI8gAim+PUfkHRZLB4zMza8MvTWZIqjfkoM2RSBDaGSgcoNCv7/Liu/3xcUadoKDxq8msrJClwcchp+KOq8wDFdfngucyAgHkk64RW2xfGl6r5Q/+J2nRyaSvEK8SH6rk028LGVfhk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=B9fSd2AM; arc=fail smtp.client-ip=40.107.117.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJuCx7CrSIIfpQjLzjeuBBUj4whfWTC8aOpxhaXCWvS/N9CH2d2a0YvSHY6GOOvxkOJ4e2Wf4NbybaqVCrR/OthbsCzcjMtTVcnySgHurIY9h0fI/1X31cg/SFjCGmsu+6JAxxtQsW8LK64F31eIcsEPcyjsXN95O8W1kC5DwuIryxmr3G7FfVC3vvLpGDkDePXiXNPVFIH/uPtUNlELW6MXpmoVYPHlMEx/esydtJDjIwoCgwmdwyAcz7qoxNLl68VY31vMbgRLLPUQkyZAFvgAA8LGyPWNhxaQ/Ff6DyqjFEYTFbPXkWbTE7RR610IvHCmUxCUHsmxKlyJlR/gAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZklz8msez3fdZBwUSGXmmUmJxAxMpZSfCyD0a5bNvo=;
 b=ycAjsTu0VWc9tTOI8hHzpmGjbiFInkKzr5aIpzYdxjHYZGQ8QNlQPgjHhfj9og++wVX7vk/8b2CcLrZFXcKNd6io9pyXLNM28Y0rv7+5GzKHBoYgdoTceeT4WdUltkEjjBBy4PArSWYCJwG7TPDCQ8FfeqV7JPvMG+Wsep5mCnx8f8H5IAgveXCN3Ms0BjULUixHrt2xAkWDEUg5TSHu1wiNF/euFsoibN73Timlb57mfSYL9KmLuiBCNuknDVZzle6i2vu92Ka9gzK8s5W5KZJV0SDPoD/8IzVnbAcY/vW2GyzqUuCAZZ5rM21VgjvRggwAnadfgVAFfoLDaCgQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZklz8msez3fdZBwUSGXmmUmJxAxMpZSfCyD0a5bNvo=;
 b=B9fSd2AMjsu5UycrAxCeGlojR9m2bZKx3bazug/kS/GLWa/P9phdGYvd0zXTmCCpKr88wUNAhQwJQXHvR6aW6HB7qB9lHsgKzUVHGCkpUsVBXlC3TpUPdxKHhLheACKRMuPaACrQeA4X8ltlGDB37ADbBLpINpjK44U3oMfTZGoJStXMtxapGDcXek2lIjp2yk27JuNpQ9F8eL1EmZXi1OYq5U8SJYuJdAMKOQbdcWXW2Amg4v6T3tjuT6YF9rNlFsGY+8tW2YvI/ajQCF/ghSOFIpO+RjP8wXX+QaofqkYEHrF8hHubi2mYiMbOPakG5FpHnYOJwTh66hfEdjUd5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYSPR03MB7783.apcprd03.prod.outlook.com (2603:1096:400:411::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 19 Jul
 2024 08:26:41 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 08:26:41 +0000
Message-ID: <3ebf010d-8dd3-4144-93b4-033cf2293d87@amlogic.com>
Date: Fri, 19 Jul 2024 16:26:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_uart: Add support for Amlogic HCI
 UART
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Ye He <ye.he@amlogic.com>
References: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
 <20240718-btaml-v2-2-1392b2e21183@amlogic.com>
 <0bfeee6a-a425-4892-a062-5ef91db305a3@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <0bfeee6a-a425-4892-a062-5ef91db305a3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYSPR03MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db9c70b-4a09-495b-4cd7-08dca7cc8444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlpqaHQwNS9lUzJMZytOMDF2SGJJZTJnY2NyTm91Yjc2VDVJYlNoYld4aW4r?=
 =?utf-8?B?Vlo5elA1bWFBQTVvMjd0KzZxM28rYlF0clUrSEg0TWQzc1dtZzVWa2FpRjF5?=
 =?utf-8?B?Q0N3b0FtbUlqelJTdGdRLzlxQ28wbkZrKzkyNWVmMGtPcnMzandUSVJKQ013?=
 =?utf-8?B?ZlFoL2plcDY2azdrN0llYnhpSnpoanlkV0FzNEN3WTVUSllSalBmOEpUOHor?=
 =?utf-8?B?eFlRRUN0U3VoMDYyYjdsOVNaQTVZWVRlOEhBcjFkbDREaTFhS1hGTXFCTW45?=
 =?utf-8?B?amNmK1dXbVpWdDJESE1IL2pkQnREN0drbGgzaUxmQUQxM1ViT3E3bXZ1dCsx?=
 =?utf-8?B?WThFWkxMWVlyQk01b21UaWxxRExpdUdjUVBSaFhxelFSQ1NyU1NIWGpNM3Zi?=
 =?utf-8?B?ZnVDREV4TzJzQzFESzdWWmVxelNNMk9YRFJ5aGg1RGt3ckFhUGQ3V3htNDlu?=
 =?utf-8?B?clZxcTJ3TTlnK3haOW9QdXhxZ2JqS2JoOE5RN0FpdHZEOVdVSFVZc1FpeXZN?=
 =?utf-8?B?dUxLbUo0bWJrbkVsV0dCYnA3SW5qUmlXUGlaRzNCMXpkcU9FSmFjNTRoeGxL?=
 =?utf-8?B?UGZxbWJRZ2pEcG5HOTNvYmZDTTVNNEJjMStBWWVpUld3RGpFN3oxcExBNjdi?=
 =?utf-8?B?c0k5NExaUHBHR3VEVGh1OFV2R2M4L29DeFlySHBmWFRQY1N5UjUzdUZCdHQ2?=
 =?utf-8?B?QUVUVHVaMjR1azN1UlZxQWVzQkFzS2h6dXA4Q2JwWHJpSGtuT3kxK2x6cW9Z?=
 =?utf-8?B?YlY5SjNweTkwNm1aaVFlZHpLZ0ZsK09RM3dBY1BFL2JGZWRrRTdEMG5xNkpK?=
 =?utf-8?B?MXZ2Z090bHRDUVBJdjZFRnBldTlxRGpUQ1haSjZIOG4xUUViekFBeTV0bStv?=
 =?utf-8?B?RUF4ZkN6eEx4ZC9BU3R2cll5VWtvbURPRXJ1TmpheWRvWTlQL0NhQ0hWZTBI?=
 =?utf-8?B?NVdTRzV5Sk9SdFpxVGRPd3RKN3ZzVkFyK0NzK3JmRzE5ejM2SCs4ck9mMFEw?=
 =?utf-8?B?RGlEak5hZWRqYTdNWGdQeWlmcURXdHA3WVB3VHJiRFlpZmNkb3ZITzRCdm1i?=
 =?utf-8?B?YUkzQjIvbXoyM1BaV01WT3UvRmJYM3RnVExpcm9wL3hjaFBsUjFBb2tyc29H?=
 =?utf-8?B?MXZaaFhlTHJJZFE3TUYwOFd6YXNzSFF0MmlnUjZQZENMWWxxZzQ0b1JWdWx4?=
 =?utf-8?B?Sk9CejFLRnh0eEVQV0ZxYVdtMlloem8rU2phd24yZytxMWhyTGNkT1U3QlQx?=
 =?utf-8?B?MmxXTUlwMDlocGdiZmpGakdKM1FwaStsLzZTWWEyRnFvWEpXWDVCamNodW5w?=
 =?utf-8?B?ekFSU0N2ZXAyRkw0OWdZa0dqelVEa05EUk0yUFJNZ2NWOEFZVFl2VUJ3U09Q?=
 =?utf-8?B?Wm5MYXNucmtVcFVRbUVpSk9lWVlMQ0dLU1JqVmo5NWZONmJiYU1DeER3eU5y?=
 =?utf-8?B?SkRoK3lEMFdQRldVdzE1TjdaQmJFNGUzdjBpc1A4N0FCWEVhRGxuQVlDSlU4?=
 =?utf-8?B?R1ZBOUxZVG5zRG9Ncis2RnJrMURMR3kyc2g4a2F6Vk8zOWR3OEptcHJNYTlu?=
 =?utf-8?B?SlVyQlZqYVMxUW9JOWRZdjgvR055Vm51bWpKTldvRGRpR2hoK1BmZ0x0RVg2?=
 =?utf-8?B?V0MrVHhwT2VTUzdVMDJXNVkySm1tK2Rtd29QKzlXV3hGdW13SUJ5VzY0M0dz?=
 =?utf-8?B?bmt5ZlZFY3lBendqVm5mTDhhTUpSTUFoSXZrR0NBeHJaMUV1djhFNk4vN1lJ?=
 =?utf-8?B?UXNtdVlXUXJzdUpQQTZYcFQ5dkZYSnRoODdvZ21qajFQVXBRMlZzWjNpRXR4?=
 =?utf-8?B?NENiRXVZOGJDWk1hamRvdUFZQWRmWVRzSXRtaXdiR0VVUWZtK1p1WUExcXc0?=
 =?utf-8?Q?e70eWqk4EUczC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZElKRlR5T2hyMWFxK2tLSU1Oc1didGZYbDV2NkxwaHFISzIvK3k1YVdkc0FG?=
 =?utf-8?B?a3NNSCthTUtxbXFZbTNZVzhmRU4zY0hOSnp4QVFUZU9pTWlBNkRmMGhGN0FE?=
 =?utf-8?B?S25LcnNseGo0cVNyVTYzd01tMnIvbDhxa3B4VTNTcHRGUnhQdkFkczd6anVo?=
 =?utf-8?B?U2E0dndJYXFpOUVzRzV1OWUxU3VKdnVEMUdoM20yVlJiZW5aWTVPMHp2M2VI?=
 =?utf-8?B?UXVrZ1Y5QmZadFNUa2RHcEJuUkNqOWtSVHJ5SEIwbXpTMmNlUm51azR4TTha?=
 =?utf-8?B?ZHZuU3lUbXN1RVFLTWx0aWZUb0RSeWN2dDljUEJrbkl2dXl3bkI3RmE3YkJX?=
 =?utf-8?B?Z3RIeWJhbS81VWhXbStBR2krRXQ0UnV3ZnhzcmI4TWtNT0VrblV2dUk5MW9K?=
 =?utf-8?B?dUlOTGhacFVtUVVPYUgzYitFZzFQckpUbmpFeUJ3eGYzbVVaRnFZaGJOVG9l?=
 =?utf-8?B?TDh4MjhCY1JjcDFjVGhHck1jbk1qdjBwRzlObU5BYzFjUXdPaUxKTWhaY1dr?=
 =?utf-8?B?Q3N0cVNRSFl2LzlyWWhHVVVVOTU3ckNTUU9VK3o0QWNlanl6ZFpDKzRwTDJN?=
 =?utf-8?B?MUN3NXRUZ2VqbWZ2YzRWVU5HL3ZnZ2RxOGRZaWlXdkJmVjhqWld1NlFLbDZs?=
 =?utf-8?B?cHkzZlI4cWw3MSsxQmFvbkhpUUF3REltcDRrR1VwNVRwdCt3cjJrMEovM1k2?=
 =?utf-8?B?MWNhbmluQXM4RHBaRUJKdjFyRklldUlUQnhVZEczTnVjYWx5TnF6RkdiOUFU?=
 =?utf-8?B?dGJLWFBGYWlXOFAwejA2U3NLTEw4d0JBbUIzUzYwVDFYbmViL2w2b1NvdFF5?=
 =?utf-8?B?Vko2WXBsYkxqY2xhTDhwc0RwTERpN3BsR0ZlTHlaU285d095dVlLeG1yVHFZ?=
 =?utf-8?B?dmZtbW90NkxSMGk2MnJCWUJSeVB5UGwxNVpPa2Y4cmxreWs2SnBpaWgycklY?=
 =?utf-8?B?NkQ2SExDTHdjRWFlMjZkREx1UkpSN1BGRU5kd1ZLQVAxaFJWMkRhNWpFVkNo?=
 =?utf-8?B?RUExaDhtbmJ6d0g4aDRJbzZwOEVTaWlQWm1HcDZsUURTRE5kbXVwblhoYzgw?=
 =?utf-8?B?Z1JWNUo0K2tERmF4cUZnMVNOVGVheDBBSmUvU2xzWkRFb0JkUThyMEJBakoy?=
 =?utf-8?B?Y0tYUzJVN0xUazBSY3RCOC9pUUtvNVREYU9RRkJlUkFmRTUxeklKQzk3bytM?=
 =?utf-8?B?VFgrSkpFYWo5Y0YxVGZsWWpXY0p0Mkc3eVFMZEJRTmJLLzdEQ3pvdFkvQ2dY?=
 =?utf-8?B?V1pxYlRGTDFtVXVpU2pLZHN5SmFqeVh0Qk1kUkRNTTNvTWJkcE54WVFOd1k4?=
 =?utf-8?B?Q002U2pyendXK3FaSDhyWmRCaUR5V2EyNUcvcGVocTQzK2ZFbFU1ZlFoMVBu?=
 =?utf-8?B?REloUEd5WXNCZEdScW50SmV1TU9NamJ5MEI5WjY5MXNGR1VVL3BmaVM3ZTR4?=
 =?utf-8?B?ZjJXbVowRWt0OEpRT2UwOWJBQzVvUEpuMlFqTTR5WlVtNnFkcGtwbWR4Tk9h?=
 =?utf-8?B?MzRjU1Z1QkFYY3czS09UV2Z2TmpRSFJ5eXoraUJDM0Z6VmJmdzV2eXQ2NGZI?=
 =?utf-8?B?R2RYU0lWWjRrcXl4VW5maEY3NVE0cyt4dlNoZnRuanFoOHVQbWRURlBHUDRB?=
 =?utf-8?B?UnROMVVDaTZSUjFGU0k4ZGFJQ3IrOE9KV1dKakIvL3VsN2grSmdFd2YvM2Z3?=
 =?utf-8?B?d3pBVDNmcGUrMHltbSsrWXc1ejUzK3hmUHByRk5aVllNV3QvVHluZ25kSEs5?=
 =?utf-8?B?cXdkSTFLZWR3cHpyUlBBWXB4Qk12b0ZjYWdPZUtsWWNEcGF1VERhNjkvNFk0?=
 =?utf-8?B?NEV0N3FCd2xCblhDSzlHQ1Nyb2xIem94OWt4WW9TRUVvZ2xQMU1UTCtaRDlr?=
 =?utf-8?B?SVBvSHJ4N3gwazBMczB2cjZmWmlFWE13MVRMZDR0QmlhYXpCT1crb1ZadzRK?=
 =?utf-8?B?T3FWZUNzNkpKSW42Ky9tSlZrWEpYaU9aWHVrZWtrc09XOVRWTVMvbWpDSmdQ?=
 =?utf-8?B?bkcwS09IV1diaEdnQnFzOENTZ2Rldk55THpPWitiKzBpYjNKc3MzL3ptV3NK?=
 =?utf-8?B?ZUJ1WUFnN0Y3R2MvSVN3VU9CZnBPSU9QcmV0Rkd5a3VrVkdGNng5dy85eDA1?=
 =?utf-8?Q?h2GQeFXHmbts/FCGc7iXW9KNO?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db9c70b-4a09-495b-4cd7-08dca7cc8444
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 08:26:41.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6VTC268mnRzKY0wZsC4xaibHmH8qbkmfN40aYoObALqRvOH7UdNVPLUVe7eRwzUhe/ljag4nTwvjOWq+FmsbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7783

Dear Krzysztof

Thanks for the review.

On 2024/7/18 19:43, Krzysztof Kozlowski wrote:
> On 18/07/2024 09:42, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> This patch introduces support for Amlogic Bluetooth controller over
>> UART. In order to send the final firmware at full speed. It is a pretty
>> straight forward H4 driver with exception of actually having it's own
>> setup address configuration.
>>
> ...
>
>> +static int aml_parse_dt(struct aml_serdev *amldev)
>> +{
>> +     struct device *pdev = amldev->dev;
>> +
>> +     amldev->bt_en_gpio = devm_gpiod_get(pdev, "bt-enable",
>> +                                     GPIOD_OUT_LOW);
>> +     if (IS_ERR(amldev->bt_en_gpio)) {
>> +             dev_err(pdev, "Failed to acquire bt-enable gpios");
>> +             return PTR_ERR(amldev->bt_en_gpio);
>> +     }
>> +
>> +     if (device_property_read_string(pdev, "firmware-name",
>> +                                     &amldev->firmware_name)) {
>> +             dev_err(pdev, "Failed to acquire firmware path");
>> +             return -ENODEV;
>> +     }
>> +
>> +     amldev->bt_supply = devm_regulator_get(pdev, "bt");
>> +     if (IS_ERR(amldev->bt_supply)) {
>> +             dev_err(pdev, "Failed to acquire regulator");
>> +             return PTR_ERR(amldev->bt_supply);
>> +     }
>> +
>> +     amldev->lpo_clk = devm_clk_get(pdev, NULL);
>> +     if (IS_ERR(amldev->lpo_clk)) {
>> +             dev_err(pdev, "Failed to acquire clock source");
>> +             return PTR_ERR(amldev->lpo_clk);
>> +     }
>> +
>> +     /* get rf config parameter */
>> +     if (device_property_read_u32(pdev, "antenna-number",
>> +                             &amldev->ant_number)) {
>> +             dev_info(pdev, "No antenna-number, using default value");
>> +             amldev->ant_number = 1;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int aml_power_on(struct aml_serdev *amldev)
>> +{
>> +     int err;
>> +
>> +     if (!IS_ERR(amldev->bt_supply)) {
> How is IS_ERR possible?
Well, I got it.
>
>> +             err = regulator_enable(amldev->bt_supply);
>> +             if (err) {
>> +                     dev_err(amldev->dev, "Failed to enable regulator: (%d)", err);
>> +                     return err;
>> +             }
>> +     }
>> +
>> +     if (!IS_ERR(amldev->lpo_clk)) {
> How is IS_ERR possible?
I got it.
>
>> +             err = clk_prepare_enable(amldev->lpo_clk);
>> +             if (err) {
>> +                     dev_err(amldev->dev, "Failed to enable lpo clock: (%d)", err);
>> +                     return err;
>> +             }
>> +     }
>> +
>> +     if (!IS_ERR(amldev->bt_en_gpio))
> How is IS_ERR possible?
I got it.
>
>> +             gpiod_set_value_cansleep(amldev->bt_en_gpio, 1);
>> +
>> +     /* wait 100ms for bluetooth controller power on  */
>> +     msleep(100);
>> +     return 0;
>> +}
>
> Best regards,
> Krzysztof
>

