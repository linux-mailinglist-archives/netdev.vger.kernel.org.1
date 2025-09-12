Return-Path: <netdev+bounces-222405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E861B541D1
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A565466EFD
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 05:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460962701D9;
	Fri, 12 Sep 2025 05:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="wGwqNbJE"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012000.outbound.protection.outlook.com [40.93.195.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5D238C15;
	Fri, 12 Sep 2025 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757653233; cv=fail; b=i8QQpuo6WFrl6r3vLL5D7NEVxvMkRgpXVBLIZ8zoBl6DsqM4gljv8521LkS3ouUlYC26bxpqK/653ogWQp6UoYf5K9wVccwQVPoydjIf8gTYPCsRrU9VyAlXsrgpJ8GF8LFIQAT6/sUix7b9JcDhrDlijYDyaN1KX5CC14GnqHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757653233; c=relaxed/simple;
	bh=+WReCs8wml0K1ZXSi0E65AqdZFqyLLnYDbzOmG1DIns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hJ/nqtKA4aigBOBc1D/OlG/1Vq/T0US3zRZkirQsgLbhL7e/+MGVbCSGOan8XneSNxPhnhVjrunMxAp/8FE5UGyjLbn1pUgqOfzttdrzd6RTzRDv+jsi+odmZkRBnT502HcGz7hZ19J8p5MzF+hIKXZyJSFklGkcSD4rc3jGlOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wGwqNbJE; arc=fail smtp.client-ip=40.93.195.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hS/gvg1qxNrAF6Q8gAg4qZ3pf331tgeD4YUHPPpeC7tkjRQRjpuW5QfMAVcIplqySyUOjNoAEZSRdnab0WQ+GWTE8PrDDJgAS++4+98xIV/QZbAYv1CC47NBiP7a/pCbgVHbDXx6y0eA8om0se3d9F+FETdpNGfy4/xwYMs1zzU9O68MFKgjlcihQroPeeYe4bDBJicOM72DKFm4ki3+x0215v7PaSdVSUTJYY1ItAArFkxfNnRFKKBOPIxet27eYr9vagW1r69m/UXtrTPAJx1GiapW83vfGtOgoR3mkEqyRLQW6g/3LQCYemtA2tuFpkoWw+JWFvnwlhhkKp0B/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah5CbP74gUYwPwhds/g/FKgaZDgZmOzTjDgci+wGaL4=;
 b=yXXx2SdsrFuqjguXLfKZNwpGQZ1+RtxTFVqOhdTW/u5YH/ddwTxvtJJwBQeWrT6AuJLuhPHPIKEaQKm7sot8zAF562wE2OofAww4JIQpS+EAotXUNwddXrEFtrQ8NQQNx8Ae/zbWN3mFo06SxcwIUezCQHfRm28yNHAFOqdo+YpU/Li8rTPw2OlujYCSTH996iHlRwZZFG5/t/WLaZDsu95z1nvWJN1RvDHot6DNxFpJM+YlqWLrjxA3CdAa2VMQviMpcB9PqwXyRIzji5WxpeXo8EAwYqnKeYRdnlyGuSSo1aOaVEKBtL/jd7anrhhJar5JO2pDH+ZGIv7SCqGItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah5CbP74gUYwPwhds/g/FKgaZDgZmOzTjDgci+wGaL4=;
 b=wGwqNbJEmkSxPQuYSwsa3mHrOt/y6OJmsGpXDKTxpWeXHICTBarv3RXHqQW1AVQlkByNklVnrjhB/8vGIvFFMI9c26fIEqEH8xu+474eRCef8Ljc1OD7nxzF2nDoDPjMmQCqKRVhrSwfL4NkTqgBGZ2s7ILHFEeVPd41YnuE4vlbMAhffWoOClrO8Ttz/zwguzyZLJ9cqJw4GtTkDHio5xgZHz/3nYMk08hePlNVvPi9k7T1H7ktlyWKui4V7OKy96/DoZO3wJS3gSpeFMKIdFMqlwv37T+FnBcMJpiRBHI3gHo6nEiTgsiaEMImShgLkkIQrzBPwXeSIWDq6mdQLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by BY5PR03MB5127.namprd03.prod.outlook.com (2603:10b6:a03:1f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 05:00:28 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.9094.017; Fri, 12 Sep 2025
 05:00:28 +0000
Message-ID: <e5b8b21d-f326-4fd2-8791-fa507f67f273@altera.com>
Date: Fri, 12 Sep 2025 10:30:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: est: Drop frames causing HLBS error
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250911-hlbs_2-v1-1-cb655e8995b7@altera.com>
 <aMLFzSLBHxsk9YI8@shell.armlinux.org.uk>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <aMLFzSLBHxsk9YI8@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::8) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|BY5PR03MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f7692c-414b-4951-644d-08ddf1b94a0a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjRUWDZybkE2RjMzVGRUcW84NzdJQjFYd3FaTmVGOCtwd3Z2NHFTcFF2RFA0?=
 =?utf-8?B?R1dRaFJRajgxWWl1elhiN3A2ZnJyL21xMURRVWtGUCtJWE9USG15dnZOS0lH?=
 =?utf-8?B?ektmQWtadHJ6Zk1ZbHoxVlBwN1ZQaWtWMEF1VjBiMmxOUFlYL2JIdVhLYkk3?=
 =?utf-8?B?QmRMTDRJc0RXSlRTYW1EWTkzYU1LOEdLVTErbFJrN3NpMnJIZG9sVk9tUFdm?=
 =?utf-8?B?cWFiYVFvUHpndnlxaitNaHZSMTdEWW5hcXozd2E1VHFmbkVObFFwNVp6Wi8x?=
 =?utf-8?B?RktyeCtueXBtNStzQm5PR0RPOFBZZWJWWnhoemFyU2dzNU83aXdGU1hveDA3?=
 =?utf-8?B?Y0I4Um8zdGE2K1Fzd0prcU5XcXNnRGluME1xVkdnYXVSK0Eyd1lkaU9UZ09I?=
 =?utf-8?B?UmZMTEdiaGMyaFNPT0JrS3Z4OXFQdVNOOWIxYmpHbDI0YjZvVFlIbGlueWZu?=
 =?utf-8?B?N1RIdGpWa0ZIQ1lSV0VRL1BsSkpqYlRZdEdQNlcwcGk4L3lvcXczd1kzWFBS?=
 =?utf-8?B?SGtXS1V4KzJCUUFKZ3IyQ2tabnFkcDBDSzhjKzBxZEVMREs1eG9hYUZ0M1ZN?=
 =?utf-8?B?a3dvZ2lWMTVPRU0rZGJBTDd4WnBiMzA3TzBNR3U3K0dFbGQ3WjhDMDZtcEVC?=
 =?utf-8?B?bEhnUlFtR2VXUE9TcVpad0RHSEkrbldsYXI0NzEwYmVXeXR2eHFnYmJ0dXNZ?=
 =?utf-8?B?UStIYzRZaFNqN24vZGFOKzV6aWxVTzVQQkRwZmFMWEx0aDN4VllhZFdySVdz?=
 =?utf-8?B?ajVQUkJLWjgwMzRSdWdTSE9IWlFxRjl2eVdGTFhVWjNIRStyNTRlKzBmYVVT?=
 =?utf-8?B?VHJPQWdDeGJ0U1NjQ0RtQ1dSaXUwRjMwZEhwNTZlWmFuMXN2V2lnTE9VRmVn?=
 =?utf-8?B?Y1A3S1ViZW5wVVM3bG1tNnZrNzZ1eU1nelFwZTMxYnN6a2ppay9VTGpGRG9W?=
 =?utf-8?B?YU5xRmpBRWZVL2ZNSSthYkVub2NhaFdDbVEvQkpxSG1nelJiS1FNU2x5dC9r?=
 =?utf-8?B?THk1SDhFcTV4c3EyZ1RFdGZoUUFMK29tWEQxeU9wSFBxUWxpZnh5eDRJZWtv?=
 =?utf-8?B?TzFDejh2RmRXNnRRNkdoK2ZWczBHZFZWQWxsRVduMEdGdlN3OW4vV3k2YnFJ?=
 =?utf-8?B?ZDJ3M0tLbVVUcEhHZHBHa0d3NzQ4R1hsSW5tQzNLZS9XSWVlY05BZm5xSDBX?=
 =?utf-8?B?eHlVYW5vaW1vN1BMSWZZcU1GMTJlUXBGK04rdGEza0dhd3Y2bUFjS3pVNXZK?=
 =?utf-8?B?eW96VzlJK3FBR0t2QTNaQ2NsZklNZUFiVUhIYm92T0VCSHRibWdkRnd1SzNq?=
 =?utf-8?B?OUZFeDR4UkNNYk5vL0xOaHAwcWJvVWlPVG5qWGtmSGVaUUlJbWZGMXZGNXFI?=
 =?utf-8?B?K0dzbFcwaE1ZSnNlVUFXNCtxMnE0QlNuT0RMQVZKaVRmL2lKT0VDOG5va0gr?=
 =?utf-8?B?bnQ3OGhzMStqRjNkNFp0MUFGcDZmaWwwVDRBUDhyV3ZjWDFwZURJazhBNXpC?=
 =?utf-8?B?b2RJRHRlYSt6V1VHaXhpdHQ4VytqeVlKTkhBL2lnTU1mVnUwZC9Oa1Q3aExL?=
 =?utf-8?B?UjVJT1BOcFRYN3BaaVFQVXJTVkFTbk9uYk1SYktCNmcwbExpdTM0RkpnNnRq?=
 =?utf-8?B?OWJsTmZFNWhINWxSY1l1c2J3K0dFb3B1Tm5jV3o5Um5OQVA3MUNCd2pVaWk5?=
 =?utf-8?B?UWhoU3JTTGljdFA4SDMxcnBYN3Y0VFkrZUJCdHJJRk9WN2psOFVLWFNZRE53?=
 =?utf-8?B?SkFkN1kwenBBWWtrZGFhMlh3eHJMWktHRnB3dFUyMXFYdU9SQzQ2dTl6Sk9E?=
 =?utf-8?B?dENlcjk0aHQzZFdGcXhhOEJ1bFFuQ2NSRmtDVHVpMHlBQ0l0K1JkUXNWQnVu?=
 =?utf-8?B?d3hZWFIxMFQxYmY1dDYyNEVFTjhqaXZrSVJUVDRiVG5iY25nMFl6a3NVVXhl?=
 =?utf-8?Q?8ODNrsHQACs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEhBY3htU1V5eFh4ZzN3aW1pQkdhWTNlMEFBZEFPcXVuUFk4eTFySGJTOVVp?=
 =?utf-8?B?V0svZGh0M0JEcyt3LzhtYjJXcDhPWHBFYThzTmtKT2duWktpNkZWeDBkVmM1?=
 =?utf-8?B?T3ZLMUVkOXNHUXR2VTIvNDlUYlp0NzlLU1kvcmp0SlpMZjhudmI3V205Z0Zm?=
 =?utf-8?B?eElNc01qNWpsNVFDMjJmemxTYVRKZENiWXJNeWNlbUF5V3hpOTZtNGpNVVlV?=
 =?utf-8?B?M0dFMk9CUFlSWkp3eHZRN09lVlB5SjBjdDBWRm1ZY2xUWVUyeHpJemdMV0pW?=
 =?utf-8?B?em0zUkRCQnY5S0dLRTZ2K2MxZFN6RS9TS2VVMEtqYmdHZUpNUXdQb3l5NnRR?=
 =?utf-8?B?TFl0Q0tNK0JDTzNCb3E3ZHlUcjVVSkpRM0RKT05RUVcwYVhLa2p4dThPZVhS?=
 =?utf-8?B?VmUzSm5XdXF0dkdJV2Npbmhkb2ZrNWUzQzJDTFJNTzh6dWhiaFFHd3VOWmhx?=
 =?utf-8?B?OXFPMXltNnJSU1pwQVZSdnBxc0phc3JBVFZpSFJ2MjZWUVR1VHlsa3kwVVJ1?=
 =?utf-8?B?QUh5NkhoVVp5R1ZKWkR3bXRBeEZrY2NkaTk3U3dZOW8yMHhDOTFscnBqTlJj?=
 =?utf-8?B?TnRKSzkzSVFycXhrUlRPSkhSV0k3RzVuV05oTGU5blhkL0JPdE11WFIyWUhr?=
 =?utf-8?B?dkRvbnNqOTQ0Q3FBcFpITzNxbUhpc290UE1BeVJhcUV5Z3VaYUl1Qm9nYXJP?=
 =?utf-8?B?SHl5b2xEZW9VODRITUtKYzRLR0NwbEhKZkIvVWh1R1FJd09hbEx0cGtDT1Jk?=
 =?utf-8?B?U2NDYTZQeFJOYjc4VCsyNVpHZ25tWDczN0F6MnUvSjUvSUFZVEdiOHArQS9R?=
 =?utf-8?B?dHgxN1VMZndwY2p6UUJKMUFxTnlpYXl0RGdkbmMyYzJnM2RPRWpNbXdtZ0gy?=
 =?utf-8?B?T255dTFGQWJXcFZ2MnQxbHpidjFPQ1FrU2t1K3dmTlFHYmhydlJqRDhSWVpY?=
 =?utf-8?B?V0UzSWJEa1ZzZEJOVFE5ZU1PNGdGWkxDSDVEaWhyZnQzUFhwcit5ZlJXMnha?=
 =?utf-8?B?WExXaVpUY2tFaWhFcFZxK2Y2QU9qU0Y3RjdOL0pEWjNScjVzUERsNTFIVjc5?=
 =?utf-8?B?WmFRL1hRNDdGVk9QUUhMUk9jM3Z0dkhpZTd5R0FZSmNTZjhtUzRzcSs2dzhT?=
 =?utf-8?B?eDgrRUhJN3MrUFJ3SEZqcTFxckhEVGZ1NXM2d2JEWUU0MHFVSTFLdE8rWUpX?=
 =?utf-8?B?azhRbmJ3MjFlbWZrenp6ZlZwK0UzV1dtMi9zV0dEZ2RQblA3amZTUkdWa050?=
 =?utf-8?B?bWJHdnU2TVh0bEoxSnQ2ZkgrQnVjbkM3QWRodjNkZURLODNyV2pqYkNOMGhl?=
 =?utf-8?B?K0c2a3RSYm5QdjZnVGFndDBqOWlDSXVySU5HeEltMEwwOXZyVDVadnl6VTBR?=
 =?utf-8?B?RG9sYkVOTkhZTTM5eHZYQUtzYzc4STYwVkhUa1RTZVpvek9RMjAzQzRKcjZ4?=
 =?utf-8?B?M2U3ei9YRFMyekNVYWR1K0gzb2pWb0ZSYmlzM0VweWlqUTR6c1RNQjh5ajlj?=
 =?utf-8?B?My9yUGxsc3FGM1N1bDJCWkRFTmhRdW1xc0dVWThxckVFaHl6Wmp2K0Jxenky?=
 =?utf-8?B?OHN4azFiT2VaeTJWY2RiNUtUZ3BabjV6VEhZem9yNXkwOHNQSU45K2s1WnNJ?=
 =?utf-8?B?cllTR2JNcHp3T2tsYk5vSTNqZmdrazVYd1pzU09KN2h0Rks1ZG4wMzE1SEw2?=
 =?utf-8?B?MDZjNzBUWUkrVG5QV0tzQXRYOHZJZTNJVHYvbXIzeHlNK2RRZy9iZ2hEMko1?=
 =?utf-8?B?eWwwbWNaYUNzWnIzaktGMkorRFYrVXMwWlRVNnc4YUN1SzdvTTljUWlhVEhq?=
 =?utf-8?B?Y1hjMDFUY0g3ajloWmdPVzNGemJCK295bzlxME1yT2tJSEQvcFE3Nlo4RVFL?=
 =?utf-8?B?Q2dlOXN2MnlRaGN4VUU3YmZRZDRXQjJDOVk0dHNjdHhKUHFlRWdzRVZuQWxT?=
 =?utf-8?B?bTdnckJldUJENXBvbjhQYWtIVmxIRkJvYWdJeXlGak91NFdmRHRIczZRVXFr?=
 =?utf-8?B?M1BoTFd3NjJZUG5URk9QNldla2JUUWtXU2pEdkZPTDI4SG9kYTQ2azFWb1RP?=
 =?utf-8?B?RUE3cFNzWXNtbEZEc05mVmw3RjdQNjgyZHVyNmNwYzl0SGE5aE9TKzBYUG91?=
 =?utf-8?B?amZDazEvSmtHU0RtWW9Edk5waFNlNDVJYkJnVkorMERWOUVYbGVzVU5OVkw3?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f7692c-414b-4951-644d-08ddf1b94a0a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:00:28.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyprj43F0w3mEpBu16aNoA64poWEsW1ODrI8Jk/QDxqD75t6dYvaoyJTEqD9+g2qbIqFRbHaLNwtc0fV1aslqpDMs20w/fns6AisHA9MMSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5127

Hi Russell,

Thanks for reviewing the patch.

On 9/11/2025 6:21 PM, Russell King (Oracle) wrote:
> On Thu, Sep 11, 2025 at 04:38:16PM +0800, Rohan G Thomas via B4 Relay wrote:
>> @@ -109,6 +109,11 @@ static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
>>   
>>   		x->mtl_est_hlbs++;
>>   
>> +		for (i = 0; i < txqcnt; i++) {
>> +			if (value & BIT(i))
>> +				x->mtl_est_txq_hlbs[i]++;
>> +		}
> 
> There's no need for the parens around the for loop.

Sure, will fix this in the next version.

> 
> I'm afraid I can't provide much more of a review as I don't have the
> documentation for GMAC4 or XGMAC.

Understood, thanks for taking a look regardless.

> 
Best Regards,
Rohan

