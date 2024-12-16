Return-Path: <netdev+bounces-152224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FB99F3202
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1773018873E6
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B181205AA3;
	Mon, 16 Dec 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="ccgmECO7"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830D204C06;
	Mon, 16 Dec 2024 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357244; cv=fail; b=XnfxREvvHftvflWluXoAbaa7+x/ZHF2Tnjc9iDgnC1D0abNO5uI2U9N1ccjoABcup/58AgOBTn4mLtMYvPTPAl3A6sBgQUChObZcqbBXUx5Wd/up9zYcySD2+iwiEbLyIszug3UYjTRjbpU398YWsSCREfmDH/hPc+VBvntkW4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357244; c=relaxed/simple;
	bh=VaNhZVib6KjzYFjfZ0ZmFn4At6XTb9W8cJfXGN0xiFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VnFKK95apnNOZtLowDtJrUkfk+JAmije1wyl//qvNjz3bO26JJosfTP0AoLcA579A1cYzEKo273Z+nqOZO9KTSpHi82JYJ2KsmW8GdYqRbk29ofZO2RRpBC8p2dXe15/t0GVg9SLQwNQcZI0a+g5/nAISZHqB2o+umuSBG+XlXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=ccgmECO7; arc=fail smtp.client-ip=40.107.117.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ID8kDKdd4xIqqFubQeYG4c8NnLZ/1P6R8Y7QHCsqzCY3wqnPFmLBx70rCCJSo/w4cVQsA7e1rg3gm6qwQA7q3gnTQ7Ne4g0tbdt4xGBBXY6N1pkq8h0SZzNUdDa2ew41gjaw2/Wkv2cm6h9Q/shANo1v6WE2A10jCYvg51sCBm/J1nZ4hPN+tZ8pMOlgsvdvMJmdeMEUEXvNOpnqR1y56fxkluRctu2eGX8tHoEVNpZsPpN+scPeEVGW4B/bLKbnLBhtACkwcT1qzDo9pGgaO1DqjIKYnmBtuP6c3RhB13BHt4kmvCX3i1OF2+1LsOi3P8gakJoPKzgFYNnnG8p+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pW5F+E8e/NerHuPwJBcvwKUQKMqRgo8cOAW8Vok9X0=;
 b=gXaPJxlw5eezMKSLFbH1dxNTo0bfwZgrrMycE9Uzfj5SgvcP+MJR2PKr8GlPC0/bYx4aI0ISy1nArxgQlZGu+5Z6Mzbnyn32ygQgd36uB22NJP+uAHqzWYeUf1t401lq6UwNqU7xQALBYvsK07+0p0pa/ALa8nqlXd8NmZgMjdkKnLuQWJ2MPIuQjvTscccxYuUL7ldV+ZbgrBU6GbEQVXY18q8fJhCCwibwlcEfw+p7W3ynRpNfRaVwc3CXLjcFqv+s6ol7sWuCBmrjvrRgwqnCqCHUVYgNjL7W9C+iyr/NA1whbxsmQjBBtwQpTt1UdpfxzFcZIm44qvAoW/q+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pW5F+E8e/NerHuPwJBcvwKUQKMqRgo8cOAW8Vok9X0=;
 b=ccgmECO7xs1O9+0k97QiT8HMR/ulOP+jIISK515aR7y1sPIgo3VEs7dpQjD+4zLKyUEamTuSUVq4CfQ3uj+Ov6JaVB/3zRtZv3aDqUpS9DKMI8IHGc9/c2i+AUY47mcqF9CxgXhK4Dvicuc2af291LuvasnJdJYqeTgC/44QTVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SI2PR02MB5955.apcprd02.prod.outlook.com (2603:1096:4:1e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 13:53:56 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:53:55 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: ryazanov.s.a@gmail.com,
	Jinjian Song <jinjian.song@fibocom.com>,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	helgaas@kernel.org,
	horms@kernel.org,
	korneld@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [net v2] net: wwan: t7xx: Fix FSM command timeout issue
Date: Mon, 16 Dec 2024 21:53:22 +0800
Message-Id: <20241216135322.4533-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <da90f64c-260a-4329-87bf-1f9ff20a5951@gmail.com>
References: <20241213064720.122615-1-jinjian.song@fibocom.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SI2PR02MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: f357eb12-30bc-4eb6-fbd6-08dd1dd91442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkhoZDlHVE93d0hGV25SY0NFSUlFL0JnUS91TWJZenkrbkxCaTR0bUZROTN3?=
 =?utf-8?B?SE9XOGZtQ09RNmtOYXRCS0ZTQWRrREQ5UjBCQ1drV0pPZzl3NHl6MWVNakZJ?=
 =?utf-8?B?Z29NY3BDZ3ZDaGpSV25sN1VhWXRRVEV2RkFSbFMzaHdXVzA1T3NDbnpkQXlD?=
 =?utf-8?B?RkVtN3RjbWtqSzIwbk15emJuZzAzdVVtd2daU1N2aDg1QW1NZlF2K1JISnNC?=
 =?utf-8?B?akJnK203VWxKWm10azhwdkh5dGx5T0gycVJHdlpKTGdhYi9QTVE2OS9OM09r?=
 =?utf-8?B?VXdYcFJ3YjIzbVB2N1A0M29XQWNXZ2RwN2FGams3OEN4bkJseW54N0FqcTlq?=
 =?utf-8?B?MjcyRzd1WWNKTllNZ3NQVjZxUTRRb2VRSEtUZEJVd1oxWUhmQ0Jnb2Z2ODdX?=
 =?utf-8?B?NTB5RDNsTFVlWVMzaFQ1N3JTOEUzNDRMVzdUeC8wYUM1ZytYaUFwME9zWkRP?=
 =?utf-8?B?d3l1VGZ4dUVMS1loZ1kyeklVWWhCRG1ycEcwNFZxOXYwc0NON3BSZ2YxNTJs?=
 =?utf-8?B?R2hsVEdJcVpuUW9NYVlMbHZ0ZXJCQVdjb2VTRzFBL0cyZWVUd2d0Q1ZHSEJQ?=
 =?utf-8?B?ZXpLeGFyTCtDMmlZNFdxSDdyZzJZTDl5TWhlUlRSVDJzYmJXeXRiWlprNjly?=
 =?utf-8?B?TS8wbi91WWJzVGdEem1rdEIrYisya2F5eTk3Zi9TMWZVOW0rNTY4Q2d0K3Zm?=
 =?utf-8?B?alhxb0VSQUVtdEhJR21adjFxWGhVa3FYOUFmcFlkSWpXOE9DVW9DK3ZWUU00?=
 =?utf-8?B?RndyN2h1UERlWGdNeGdxbm0rVitXdGhrYkE4azRselpOeGlNYzduSmtldjNQ?=
 =?utf-8?B?MW1HNnhYNTdScytKbGVMb1BUSjZIU0tScklIVUQyTVd1Uk93cm9Fcnk4U1dS?=
 =?utf-8?B?VnMzM0pGV2tHRWQwY2ZiSVEwZzRhQXpPaEZiNG5meHNtcEhVS28wZVVNc1do?=
 =?utf-8?B?c1pjd0lCRFhheG1ENmxRTHdGTGFJNkpGS254VGdJNFdVckxhWGtEb3p3Q1lh?=
 =?utf-8?B?NXVoTTVUNzBERDdpaGJWMENycWZQbUsxelFiTnUvcEhlWkRtRllyZHI4R1Ez?=
 =?utf-8?B?R2tWemUvYmxDV1RGc2VvSlJWSlZMeWZUYmdPQlE2UU5qWFNRbFl3c0NrcXM1?=
 =?utf-8?B?NG01YTVJMXBDM0JLK0NCR2dxaDNJelVwY2hHTXlwd2xHL2ZINm51cTBkVVZx?=
 =?utf-8?B?Z0NMWGVMenRPSHg2TUs5UDBpcGtPbGRVVHdaWndacFlOaFp2RU44RkRNUzFN?=
 =?utf-8?B?cHJSMWJkRVg5MmcyYy96bnlZWlBhbHYzQXNVaW9zc2NGbWl4OG5lNFNpUU9V?=
 =?utf-8?B?MnUwRE5ScGgzMkpHRmp0d29LV2prV25GYURPN3AxamJFMU1TMjZRQUkvbmVi?=
 =?utf-8?B?MXUzaGRDNFNCQ2NBOTE4MzNubTdrYU94K0VUbjd4N3hkUmprM3JUSDBNSk9R?=
 =?utf-8?B?OHo0bmV6aHl5QnJrbjZSZms4OUQ3bHFUajEwdVhxMFA5dTRFS29iMGNVSURZ?=
 =?utf-8?B?bi83cjJGRk5nUHJHOVdVMkpqVHU3Rmo0Mkt0YVo3Vzc0VHh6akczRUgzT0lk?=
 =?utf-8?B?ZVE0Tmc5VW5vYmdHOTh5QU12bEhvWmp0S2QzWkxBWHovZWF6R25oRWNrR2hR?=
 =?utf-8?B?U1ZVeVJpT2d2ZTY2VUJWTVZUNzhZL0FkKzk4Qnh6ME9DaW94MU5CSFdPNzhM?=
 =?utf-8?B?bW8raUc3N25WOGM3emJERm1ESFU4S3pxeGFMV0NiT3ZnTFVwWkNTcVRlcHli?=
 =?utf-8?B?TnJGYU1hZmNHemdNdnJyc1F4Tks1eU9QV0VsTUxaWUVmVTltSDlnbkI0RmdB?=
 =?utf-8?B?MW51NXF3aVhQclRMWllXMlJucWJPTjdIMlREWE4wckoxVHdiRk1nb0o3RFpZ?=
 =?utf-8?B?aEl3MHlvVXFNVmt1ckk1cStEQnlrR2tZUktKRmo2bG53RlR2S2Y1UGVXUDh6?=
 =?utf-8?B?ZVFOSzVadkVBWEJpajcvcDNtdVM2ejc5N2dMd2JwL1p2SFJha3pTZHR3T21R?=
 =?utf-8?B?dnBjYmxYbFJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0o3M2tBTi9LcTl2TmM0ZkMzRlhEOFYrZno5WDU0VjJvY2x6TmNEanF2QnNq?=
 =?utf-8?B?MjNvaTBsS1BvU21SUHgrZHB0Q1V5QWhlakFZWE9zWmRrNTdvb3J5elRQVXdB?=
 =?utf-8?B?Zmdoekd6UllHMGQyUHpzc2lYSFBlTUNPOEQyNGFMTE55QmQrNG9xMFlrUktj?=
 =?utf-8?B?cVV4dmZOVzJmWWdJK0QyTGZlVjQ1UWRUK29VMldYbDlWK3pOOXltSlVsYnNo?=
 =?utf-8?B?VWw1dUdUNTY3VlRncGxJZmg3b1VEcWtSYS9lUnBmR0lpRXRmWVdkaXc4bzdS?=
 =?utf-8?B?TFR0UDdCaG9kZVlITnFPOEVHc256SFFaVWpOdG8vcGRnK2tEOGYzd3JqSGFZ?=
 =?utf-8?B?R2FxdEtqU3QwS0FFMnFNdHk4V2JVYXgweG1LMkZGYnZjMlUxUmtEUHNScGU5?=
 =?utf-8?B?akdCaEdKYW1ablc5RmIxZS94bTIzaW95SnJ3NitqY2tJb2lrMjVId2E2eWhT?=
 =?utf-8?B?cW9mQXNqZnM5U0dCMllRRlZnQ0RwVW1JZkNSS1ZIcnZNTW8yWVR2dWxNVVBp?=
 =?utf-8?B?SmkyRDhUTWlQMVlsbzVEUFZEdTl6Tll5ZzNmZTFKSFpoc21NSE9aWGd1WVJD?=
 =?utf-8?B?YlNCc1NtSlNNL1FMTmNUVkZKTXpoa29zWi9NcTVrWkxhMHdNVDc3QmpWNUs4?=
 =?utf-8?B?bTJzREFCNk5FaG9zbERacFJqK01FRitwK0xTVTVkV0V1cmlrNzBTZGFROUxY?=
 =?utf-8?B?VlYxZWdMeE01WW9mUmJrRUZ6azlERDdKR1hIVVM2N3NDcW5jWVhSQ2RyWEpN?=
 =?utf-8?B?SDZ2eUJOWTBXZmVGMzFyeTkyT2NOcEUrUFhDZTZMNWR4OHgyZWp1Qy9vdEgw?=
 =?utf-8?B?UllSU0xkUU1PU2xNR3VTZ1hNeEVOa1VuOUZQVVpIdVdnRGQyY0VoTEQ2c3J2?=
 =?utf-8?B?S1JvR2NFUThWenBxMEdhUG9vbUx5UGJVYlJBRnh5RUNVS0R3OFFHNm8xdExC?=
 =?utf-8?B?c2FlUEw5YXMyUjVTVkorcEVzcmNOZnBUNVR5dHdZc243VVJPTkVCYlk4azRT?=
 =?utf-8?B?U2tTYWVkYXlaa1dkU0tkUHJTNm4zLytVZkMrNmVEM281aWZ5T2NVV0FvWFhQ?=
 =?utf-8?B?MitKQndVWWdEQVIvUXQ5VXJSeDdzOVBQYjFsTHNRUFM0M216YjV0Z3FBOC9X?=
 =?utf-8?B?cXpaSEFrcmFLQUFrL1V0THFhZVNmdm1PYm1YVTRUYUlrRXRvYkUwcVRUTFVF?=
 =?utf-8?B?Y2tvRXk5S3NXeXJwTHI0UXltNTZBODZNUnBiWFV1ZXE5dWJUajVkdSttL0pE?=
 =?utf-8?B?Y1NLdUd6a2IxN0tzSVFrU3llazFQWDVSSmxoRzVWTXU2aHVJNTVJSkpGVnBh?=
 =?utf-8?B?RFpuOCs1U1BYUnVVd3JNU2dQUFpqdUJVU1ZLSkhzc2ZtY20yd29WQlF1RDhh?=
 =?utf-8?B?UUQ3Ym5LZmxpZERCa3ZYMURYSEZoTk9aSXIxaEJOcU1CRDVIOWo5MU16VFA3?=
 =?utf-8?B?Vm16RHZIYVJyRFVrMUNibjJvbGZ2enloRkRxZUxFalN0emF5ZVF0ZE9zUlVh?=
 =?utf-8?B?OTF3VDh4YXVsWGhza1AvdENkamRHa0U1K2ZkUVRKWkhoWHpka29sbHd5bkl5?=
 =?utf-8?B?dmZtQUVnNXdESWNsT1M4Z2wrcFRQbk5Wd3RYTFFaR1lvRnBrM1hqZlV3R3Fx?=
 =?utf-8?B?eDQ5T3BVa3BGaGV4d25KSFY0YlRFTHpMZ3Y0OUpEUFJtK0NJT2twcVJOakRP?=
 =?utf-8?B?NXU0T0tPcW9VYmllb1NibU5rM0t6R0tXL2cwQi9aUnpjbXdvR2g1T2d4U09X?=
 =?utf-8?B?alRuekY2TUZ2dkRPQThsTnBqdVBnc3FUUGRjVzc0TXBoUGk3by9ia0M0ZHBV?=
 =?utf-8?B?MGg2ZGhKbU5vVzVsWFhKc3Y0d0JXOWdaQU0rSXR6N0VtV3g0KzYzRjlydXVj?=
 =?utf-8?B?WTN4QzVJU0hnQ0YzVUE0NVZLZ09pZTNQUS9ZQ0RTMnM4bnI2bHVGSzFFVXhz?=
 =?utf-8?B?NjRVVktkMUhYREhnU0szeHpNVkNobVVmR24yUHp4dU52Qm1zcDFsNkdaUmZv?=
 =?utf-8?B?S1lqaDdXRlRMUzF4N3UvTURGSmhMY0p6QWVHVlk3TGl6S25wSWlKOHdMVzg3?=
 =?utf-8?B?NkdOTU4rSnVFMGZpMEliTmV2N1phRWcvcnRSR2h0eThZNE0wMy85V0NwOFla?=
 =?utf-8?B?WFpOQ201ek0zNldnQStxaFNSTGh2UVVuYWpwL3dhc1pNaVo5cGRKWFlaakJF?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f357eb12-30bc-4eb6-fbd6-08dd1dd91442
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:53:55.2114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucPCDipT7hbLqytMwwQWN5QGSxvmyLCLChFxVWKHh/sOwQrR7NBThyfgROWyHE803VsYrZw9Che26vxb6AVBMLPhBf/rKztjzy8oiElJUi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5955

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

>> Fixes: d785ed945de6 ("net: wwan: t7xx: PCIe reset rescan")
>
>The completion waiting was introduced in a different commit. I believe, 
>the fix tag should be 13e920d93e37 ("net: wwan: t7xx: Add core components")
>

Got it.

[...]
>>   	if (cmd->flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
>>   		*cmd->ret = result;
>
>The memory for the result storage is allocated on the stack as well. And 
>writing it unconditionally can cause unexpected consequences.
>

Got it.

[...]
>>   		wait_ret = wait_for_completion_timeout(&done,
>>   						       msecs_to_jiffies(FSM_CMD_TIMEOUT_MS));
>> -		if (!wait_ret)
>> +		if (!wait_ret) {
>> +			cmd->done = NULL;
>
>We cannot access the command memory here, since fsm_finish_command() 
>could release it already.
>

Got it.

[...]
>Here we have an ownership transfer problem and a driver author has tried 
>to solve it, but as noticed, we are still experiencing issues in case of 
>timeout.
>
>The command completion routine should not release the command memory 
>unconditionally. Looks like the references counting approach should help 
>us here. E.g.
>1. grab a reference before we put a command into the queue
>1.1. grab an extra reference if we are going to wait the completion
>2. release the reference as soon as we are done with the command execution
>3. in case of completion waiting release the reference as soon as we are 
>done with waiting due to completion or timeout
>
>Could you try the following patch? Please note, besides the reference 
>counter introduction it also moves completion and result storage inside 
>the command structure as advised by the completion documentation.
>

Yes, please let me try the following patch.
[...]

Thanks.

Jinjian,
Best Regards.

