Return-Path: <netdev+bounces-112370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774A0938A4D
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3331F218C9
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 07:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B319770E6;
	Mon, 22 Jul 2024 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Fx+T/ZOA"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338065380F;
	Mon, 22 Jul 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634113; cv=fail; b=dW138TJ89hpdPe0wmMtev9QDKPGVhGjCOCI+MJGTUMxxXrUBMoYXiydbNNJGZtgL9OAhfF7egvKkmw1zkmr30MXbE0bfBm/lFHBLwETz1sMgRWgskn7HM4YJl/ue4rBqrdRaj1E7BcdTEHNaLJCIne6G8AcREe9rMDBi9X/YWT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634113; c=relaxed/simple;
	bh=tZ6jxtNyOGwfHtVgw1mEI093GAbU0gAVa5KIJ7RJT/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tyAq+ZY511wtOG7J+HM1CWwTkkLUadFugv+U0JRU4cTkLCnaofk7uihdTEV9FEyn9LsWsFknZQOchsxyytvcYobhmAB7WtoVBkTZUfmxe9yf79R6qBF8LBLu0FdRjm79RD2xsxCjq+VS9nsiQ1D6v7Oqd0YlO+1eyO+UPXw+Dcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Fx+T/ZOA; arc=fail smtp.client-ip=40.107.255.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rb61onZ1pKM0dcLbBURXCk+jsmzSxSFZvia1BhJByFGenGCJlDgpZg/CQBA0SZLm8CH0XpZZjU76T8sbYegV4swOOE0qsL/f2B4/5okjceDUCd8OJXcb1MXnFlrkdsJoNKTyrA6wMk0LrD++EgcvCi4tpQYQw4TY7rlJtgzIHZv/BWWAPvcX/b5Lio61ZB06T6m2tHVuD3dN/iw0XHL6YGy3/zEZFgnI1ySAwwE0sBiCkNmxRFYCcc7Zakl87y1PRguYkSk2vxNajWLYixZLGKQecT9LaBT9xgq7lkwDRQF53KscASE5N3guYfQQYmlb8QCzAaSVhiCgPpONMJ1wmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb4nhrGQv8e8SIBz6E9+UDIrd7CQu1wFUhwYIRqTx8o=;
 b=x+s5A6i43lUE0R2yAGKbUTgvxvKi9a8TsCxjMdej/CW255tAOHhBLtHx24+Q1ubpU1I0D0RcVGUjjQdnazgeWEFgUMePQpt5W1ms1rS6qi2lkl3s3t0Mo7MqdKHVaK+XN/xsPAbtU8c/vR+eSDavB7b8CDk9HgvoA9S4DSxqx4gdMoFaM6V1cVRVAS5O3yTSfKgOiEhkJTkXmaHy3R3m6tvBH2nJgUywlFlwWRntfKz778ognVG2xH/QXf+TlzaL4P2FovIlOsbycQnMLP+5Y9WmlpZtUpfVRL1O8Lwi08F1xZ1qoKfSVzp9dLbGcpCDm+068RKl6NWqWbseRbiYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb4nhrGQv8e8SIBz6E9+UDIrd7CQu1wFUhwYIRqTx8o=;
 b=Fx+T/ZOAAHuEJp6QHKIQSR/XZMJPc+RE1YE+GsQeOVgAHboZk+kfx5fJjKuseciLv6TyHeHB4Wd/dlo4okt2PgL4+RPU5rY16ceC4qNPyoRpivl+KArMoHu4tUjRvOwCmOFyu6tu5aGqVfqHQfr1ma67plY59oKHTR21G/JLGzn2WmYXlOJar4uM+LKp9nKjNYlv3/DMbRqvMumKCbY+iPiBtCM2NbjzKXIudTAT8GnoE7vi1U/LyxKxzT1WJsmG41CSgox72IiPI0IPe3yI18Dy6UnXc0+ohmxdIIBp4NDnabjqSswX/I+cDyYNfdcRIxfpWeWwAUxd4+GqeUporw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SI2PR03MB6462.apcprd03.prod.outlook.com (2603:1096:4:1a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 07:41:46 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%5]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 07:41:46 +0000
Message-ID: <e8adc4a7-ee03-401d-8a3f-0fb415318ad3@amlogic.com>
Date: Mon, 22 Jul 2024 15:41:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add support for
 Amlogic Bluetooth
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
 linux-arm-kernel@lists.infradead.org
References: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
 <20240718-btaml-v2-1-1392b2e21183@amlogic.com>
 <18f1301f-6d93-4645-b6d9-e4ccd103ff5d@kernel.org>
 <30cf7665-ff35-4a1a-ba26-0bbe377512be@amlogic.com>
 <1582443b-c20a-4e3a-b633-2e7204daf7e0@kernel.org>
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <1582443b-c20a-4e3a-b633-2e7204daf7e0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SI2PR03MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 032e5a6c-6d60-4f95-cf73-08dcaa21bce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0p0TDB4NzhLa3MxV1ZjU3lJNEJ1Mnhob0ZXcUF3MERpSkJHNUJhZW1wRmF5?=
 =?utf-8?B?c3diajZ6blNRNkM5OEVSangyRmVhUllHd01WUnVnd1VIZzFNdlhZUUpPaWlS?=
 =?utf-8?B?eEFIdzBGc2wrcWU4SWZhQ053dFJ4bzluU1pIVmhFQk1ZQXFpYUZDZ2h1TkJP?=
 =?utf-8?B?KzhNUHlUZ3Y1dm5iN3VnZEFhM3kyNkQ4amhEdzM0bWdSamwzUk1QSGsxTUZl?=
 =?utf-8?B?TG8wK2JUZHZWQ1E4bkIxQzBMREFwMmFxSDl1R2xQd243TDd1TnM4UjNLcFZ0?=
 =?utf-8?B?WUlSYkczWkZJbmpxMFROU1JpbFJ3VVh0ZURUTTVTVHpFVU5POVhXYUVzcGFq?=
 =?utf-8?B?R1cwOXMxazBZbXpPOWN1OEZwNWs2OFBoNTBNWk5mZm4wTUZ6QWhDY3puQi9j?=
 =?utf-8?B?STNyTWZPcnlEZ1pwYzF0eFpRU2src29VenFUaTZaYXlBbnkreXdqWnpLeFpw?=
 =?utf-8?B?S2pmMFYyZWFmbllwY2R6RmRXbUFwYmxsUHRZOXJEU09vR1MzbUFYd0Z1WDd1?=
 =?utf-8?B?MlhIbUdqaUZLb2liN3V1VUMrNzNXZGVwSFRnUnExaEVTYW8vUW5kNjFGd1Yz?=
 =?utf-8?B?Ty9DMTNzK3lrcVJtMVRLNlYvSSt0SmN5WXZBVUJxRHIvbHlFMDZqTFpTWHZ0?=
 =?utf-8?B?WnFoemovZjlvRDZUV2ZXbEtpdHJXOS9qdzZKa2FJN3o0cmxuYmNSQWU5NjZI?=
 =?utf-8?B?bzFSM2pSMDMrOUdON3FoSFpaTkE3azVmcjBKSkY0K3hWSXQ2Y2xWbUl6NTIz?=
 =?utf-8?B?bDJNNDc1RmhlM3NvSWxRRDNIWFZGNXR5dzNnSGs4MW5wbUFLL3pHeXFnMG1H?=
 =?utf-8?B?MGJuVUlhbmFFRmJoR1hnWFlrOE8zMXcvWlE3amV3UDJYU056bE5LMi9oTDNi?=
 =?utf-8?B?WGFBdWdrVVIvL3E2cU1DdTJTUUdaUUFtYXlMeFhQbmtYbk8wSW5YOTY5K2JG?=
 =?utf-8?B?NDUyaGIzclJTZWpJdVc5dC9oMFdsWmdReXFpTFNoVTk3dGcrUGsrMnpDSWFB?=
 =?utf-8?B?TFc4RThtNlhDN0pwSzdqL0cvYndYZHdhdWRST3VvWmpuT281d0N2WG1udXNH?=
 =?utf-8?B?SzlCM2UzeURCSGZpNGlmMEVUaGFXOXNJVUg5bENJdCtsbGtjSWR4WERweEh5?=
 =?utf-8?B?ZElpU1Y2ZGNrNTRWdU1mcUkvTzEyYVFtMURBb0NSTTJhSmIzUWRrOEN3Z3J1?=
 =?utf-8?B?WGxYUVBLYk5lc0lCTVpxN24yMXhiSjNTbEpZcGlhQm9mc1ArQllvUGMzdHpH?=
 =?utf-8?B?Z0d5Y09QYzgvYTZaZ1pLYk5MMnBlWkY2SDh6M1VIMy9ydHRPTVNMaStsaUxB?=
 =?utf-8?B?ZGFtT1l5NjN1QWhDL3Nrd3NEcHMveVZVZ3FvZ3ByV1JEemxyNGZSNS9kKzlh?=
 =?utf-8?B?bVYzQzZyLzlIa25LbjJvaGRrRDhtRFBTbFlNTVhkNU9yY1M4ckNSTlRFZG5Y?=
 =?utf-8?B?aEgxTFNkWlhpNG1PR2ZYVVhEdXlUMXpsRDNxYVpnbWhxZ2JNSWtoL2pLTUJD?=
 =?utf-8?B?elJYMTI1ckpzSVpvQXA2RVhOUnZkc0pGRHF1Y2ZuOGQ5QUpHQXZENkxqeFVT?=
 =?utf-8?B?L001SEhrTGtNZHJDRGxiVVl2R0NpTWFkR3J1MTdrcmc2OXJpeG9rSzI2eERo?=
 =?utf-8?B?WUZiRzV1RDI0cDZNSmZtK0JhcGlPVkxUYTZzSHI2REJiS2tTZ2NsTHo0bHd2?=
 =?utf-8?B?VG9MN2U2Tm4zS01QOVRWNjR6QWcxSjU2eFZNbU1UWjFDMlBhczRVM3pZZTMx?=
 =?utf-8?B?MHp1QlY5czBOd1U2b0hQcEtZY05GdkdZc1ZlM1Z2NnNFbWZJSkEyVXpTMjNs?=
 =?utf-8?Q?6Zp+Kc4OEq6JpqXj/hG5HnIiZxIvTbw48Pe4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emU0ZEN4RGFYZlhZTlREWW40VFZHSjVuZlowQytLWWZCRjhlMHJrVklsdUVj?=
 =?utf-8?B?bkFtdHNtVDBqOVM5N0RSNytwT3JFeGQvTDJxbGlnQ1hyb3VLSFRYSjkzUXNt?=
 =?utf-8?B?N3QwQm80cFFjS0wwMTIrY2U4cXM5bWM3dWdxNk93NituVGlLSTU5dWpadzI2?=
 =?utf-8?B?clZHcmZneEh6bmUrbUFXdThCWTZlYVg3ZjVxeGZNNlZrYmJBQ21MM2g0dWM3?=
 =?utf-8?B?bU9lckM3VDZqdDRuYWV0RkxIV2ZWQjJpYUExTjVuQ2VYRmtIcFVra3g3dFla?=
 =?utf-8?B?VXBEUUN5MlBPYk5hTkg3dldNck4zYVRVaVJZV2g1L0t5eTB4Y3RTVEdFWnJR?=
 =?utf-8?B?RzFRS0NYeUZIbk0zZFN1RWRpVGlqSEx3R0dJVnpuVnQ5eEoxMWNJakZTY0Rx?=
 =?utf-8?B?TDhWU1p1UXVqa3NyV3dJSWhvbkRnTXBoMWRLYXZwTEkyNUllNklDM3BTOHNq?=
 =?utf-8?B?Tmtpa3pFRHl1bXJCOVEwRUptUllLK1MyaWIxbFh0cEpJVjlnU3ppU0tpVFp1?=
 =?utf-8?B?ZXBxTkpreDhWdE5wbW16L1gxMDlWa1Bybno2WUUydDMzTHYzZjVETmJnNjNX?=
 =?utf-8?B?ZW1tNTA2dVNXaTMzNEs3NEdhL04zWllrSkp3blpwb0kxZll6T1lMdkxZbE1j?=
 =?utf-8?B?UlVMeUZRMnliUGY1amUyVit4dWY1cWpJYm9UdDFtYm1vN3hWT0xMSTRSZjR6?=
 =?utf-8?B?ZmRJU0VzcXZJcjhITGVLMmdSTUVKNndMZTVVdUJCNkJBaVI4MGFYb0d2NkdD?=
 =?utf-8?B?cTU5SGJaL25JS1hlU0llL2xnWVZnbjE0MUswREpuZ1FIQ3pnMy9sOXNVcWxG?=
 =?utf-8?B?THZ5SHRmbmd1ZVV6bGZlb0thMUdTa2MvMXhmV2JyRDZYVkRzVmYzSjVRSTJr?=
 =?utf-8?B?S3FteGU5MW9MUHlKckE3bWJvN3psaGpiaVJPaTZQdnk5aGVVSFhVYUNjQXBh?=
 =?utf-8?B?di9tQXNLUXJ0dHhnMFNCNDl5K0dzd0dhQUxFcjE1aUZJRGgxUG01OGdaZ2k5?=
 =?utf-8?B?SFR1cGJ2K0g4NnhyM2s0Y3FjcEdUSFN1QlRSS2JsenhaT3FOWlIrK0pUQU5s?=
 =?utf-8?B?SnQ2NHdCbHArczB4dFNqM1hZaU5zUXFMcjJnKzBFNUk3c0dUN2hBQ091c1Vx?=
 =?utf-8?B?bG1HbjVhdVlZVFdSamcvalBIeGdmdktwa25uZ3NhdWs4bVRsL2JvaEdocDVv?=
 =?utf-8?B?NmVYTmI5b2FUU05TMzRFbWQyUjViK0MzbWJTU05iRzR4R2lvRFVqM1pjVXV5?=
 =?utf-8?B?dU94b1c3WFRqdHJzOHJSeHJxdGVRR1VFVmFLMTJhNHlLTDRUNm1kMVV4RFd1?=
 =?utf-8?B?VmNORzNJT1Q5Y0tIbUZ1WGpObndMOWJkdWx2WHdPdHJrVjRnK1dIYnZqbEI3?=
 =?utf-8?B?SEZsaHJacm8yRTlNRnd0dmVmR0hiNUJRT2NuQzBId0Nob1lmandLb3hPY2FY?=
 =?utf-8?B?ZnZnNTB0WXNzVmlXNGZuYkt5cE5iby85eHUwRno1bG1OSWdPM2M3Q0lja0hn?=
 =?utf-8?B?c0kyU0V3U1Jyay9LYUlOS0xKc0ZVLzhzNVFjL0hiK2JQMjNQdDFOcXJrQTNv?=
 =?utf-8?B?ZDdtUGlzWlk1cUVDSWtraFRNczZLd0FYdmJKZ1JWcVFUWE1EQ0VNR3UwNFcz?=
 =?utf-8?B?WW4rWWZ6dVdmekdBNzdWQ1d5a2FkdjVrQk9nQWpwcjJmbVNQUnhiZEVKMzUw?=
 =?utf-8?B?UHZWWEdDNDQyYU52TnFPYWtTMXFwdlJoQUxqcmVNK0ZSN3V6ZjEwSEtoYVh0?=
 =?utf-8?B?V3hZTjcrQUhVbXVxYzRkYi9vU1RVWmd4a1gyellVZmI5R3ZwVmNheFM2dnF2?=
 =?utf-8?B?VU16Z2taQjh0cy8vK1ZGd1Y1eWY3VjBEVkFxU0RINmpEUXNydmVraFNmdGs3?=
 =?utf-8?B?eWZhM3BsQllqTVZNWlJBUGdWdnhmcktQM1FDVmlUUUhUTllOaUF3eWpjQ2Z3?=
 =?utf-8?B?NlBRUWZxc2FlM1hBUUVzTWRJZnIwaGNDQ3JvN01mcDZ4NFlZQXI3NFd3USsr?=
 =?utf-8?B?SmtkZFdXT01hS09sU0JoOCtVdXhFemZwTEt4RElnV0NjSVdoVVF0U0lrSW9u?=
 =?utf-8?B?VE1FcGVXTnZOeGdicE45ODlxWkhoNjV1MG8rRnV5eThsYzBNdGVnNXl5V3FS?=
 =?utf-8?Q?IwD0HsJY2k7nTlWZhVh29Effa?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032e5a6c-6d60-4f95-cf73-08dcaa21bce0
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 07:41:46.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16CcnUGYtFWtIhEjGK+FDBlg377kXno7y1nt0lW47AHkE5vLdub5hePgczcgA12Pb7iG9CMr6RPMc+4hNj3nkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6462


On 2024/7/21 2:25, Krzysztof Kozlowski wrote:
> On 19/07/2024 10:20, Yang Li wrote:
>> Dear Krzysztof
>>
>> Thanks.
>>
>> On 2024/7/18 19:40, Krzysztof Kozlowski wrote:
>>> On 18/07/2024 09:42, Yang Li via B4 Relay wrote:
>>>> From: Yang Li <yang.li@amlogic.com>
>>>>
>>>> Add binding document for Amlogic Bluetooth chipsets attached over UART.
>>>>
>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>> ---
>>>>    .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  | 66 ++++++++++++++++++++++
>>>>    1 file changed, 66 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
>>>> new file mode 100644
>>>> index 000000000000..2e433d5692ff
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
>>>> @@ -0,0 +1,66 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# Copyright (C) 2024 Amlogic, Inc. All rights reserved
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/net/bluetooth/amlogic,w155s2-bt.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Amlogic Bluetooth chips
>>>> +
>>>> +description:
>>>> +  This binding describes UART-attached Amlogic bluetooth chips.
>>> <form letter>
>>> This is a friendly reminder during the review process.
>>>
>>> It seems my or other reviewer's previous comments were not fully
>>> addressed. Maybe the feedback got lost between the quotes, maybe you
>>> just forgot to apply it. Please go back to the previous discussion and
>>> either implement all requested changes or keep discussing them.
>>>
>>> Thank you.
>>> </form letter>
>> Apologies for the earlier omission. I have amended the description of the
>>
>> UART-attached Amlogic Bluetooth chips in the patch:
>>
>> "This binding describes Amlogic Bluetooth chips connected via UART,
>>
>> which function as dual-radio devices supporting Wi-Fi and Bluetooth.
>>
>> It operates on the H4 protocol over a 4-wire UART, with RTS and CTS lines
>>
>> used for firmware download. It supports Bluetooth and Wi-Fi coexistence."
> You still say what is the binding which is pointless. Binding is a
> binding... awesome. No, say what the hardware is.
>
Hi Krzysztof

Seeking feedback on proposed changes:

"The W155S2 is Amlogic's Bluetooth and Wi-Fi combo chip. It works on the 
standard H4 protocol via a 4-wire UART interface, and supporting maximum 
baud rates up to 4 Mbps."

>>>> +    description: bluetooth chip 3.3V supply regulator handle
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +    description: clock provided to the controller (32.768KHz)
>>>> +
>>>> +  antenna-number:
>>>> +    default: 1
>>>> +    description: device supports up to two antennas
>>> Keep it consistent - either descriptions are the last property or
>>> somewhere else. Usually the last.
>>>
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> And what does it mean? What happens if BT uses antenna number 2, not 1?
>>> What is connected to the other antenna? It really feels useless to say
>>> which antenna is connected to hardware.
>> Sorry, the antenna description was incorrect, it should specify whether
>>
>> Bluetooth and WiFi coexist. I will change it as below:
>>
>>       aml,work-mode:
>>       type: boolean
>>       description: specifywhether Bluetooth and WiFi coexist.
> So one device can be used on different boards - some without WiFi
> antenna? But, why in the binding of bluetooth you describe whether there
> is WiFi antenna?

Yes, it can be used on dirfferent boards. The device can operate in both 
standalone mode and coexistence mode. typically running standalone mode.

Therefore, I would like to revise the description as follows:

aml,coexisting:
     type: boolean
     description: Enable coexistence mode, allowing shared antenna usage 
with Wi-Fi.

>
> Best regards,
> Krzysztof
>

