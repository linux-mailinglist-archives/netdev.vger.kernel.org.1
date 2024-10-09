Return-Path: <netdev+bounces-133675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E013E996A9A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C48E289249
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB6D1E0DB7;
	Wed,  9 Oct 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zk9V7hLD"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A451E0B6B;
	Wed,  9 Oct 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477837; cv=fail; b=Ni/R24TrzLLjXxfFy7aeIbeiRjBg2FsvoZFgKK4BcSACoNbqvE+yUyBO66efSq7jegCrbJpTRI+wXT3Qj9X28vEMj59s6UXTp7JyFd/IDe24xoUXvFPD+X6t4DCs9ha3Me66EGrxjkYT+KUetkDLwUMAZuBWXRSbK7hvxfZx+xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477837; c=relaxed/simple;
	bh=u4J+ea5nb5enFASkm56MDs8t28QcjeTr869MJtzOTMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qy9z0ypgEqs0jmF7qautdJc3TSe+52VUGraM8ZRrFL9RJzadCX91aKiV5JAQzUsslmlYqj+gkRpcbGNETcus7I6IXcAewdni9vQlhJWA2iqCH1QhtnFLmRXUw9y/xiNrpd+YhSiEfWc/KrHkiUx4x+yI7sH1Uc9zz/dWoaLJjq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zk9V7hLD; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFjRG0pqtm1dJdYW4aVxwnHFyLqhDzv30xv288iIyapFk0QK1Ipi6IlhTDiYmaQaHaEzcNyqwJLlADeljhGUxztezfTMFVzbffu1F3zWcsg/1PwTJLhDrVTKKuq0eUhDcX4Q+clnmZShOj3eKv43KHzKADsCiaGzAcXbyTpm348dHJpUkW5J1ImW9S4o1lqhik11yneuCSEA1VMf1B3s7u26tN4uBNz+vFoEGTTBff9KYQ4ByfU2BPyxrx2TFgL5pOoDt+oAZJS/5ugNpa73z1T/WRJlzveuWuyJ8GhvmgJ5mOT5wHHEKdCREsIXwGgf9gH41+KEffaTV5bx6zWJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4J+ea5nb5enFASkm56MDs8t28QcjeTr869MJtzOTMQ=;
 b=tGjCA5HPJ0stlIoRI6TOxyxcLUFZnliqprTmGyhe/GbncFELlFZZhBeas4ciIH72yWXPNCzAfR6VNnhNiJEehAFHbqh4OsNpq2F49ytGCc2YPwgWFRFspfdEEto/tj5cIayIpY3Nd4XHMKOSaBcUYSJuYwxH63/EWmGslts2uqUgWGfRL5/E1jV8hchDwE1UpHFMDYfyx2jJu7ClE/ENjqHAc3VEbGPvLWsM3/HPRfK4QmjRTcU7tUUwt7B18SWmVcjBFbdWcpLlT2UOSSnfMHAHGu0HgbKU/U+52Gj7O9b2e1D+7GvLwUmw91JqNgd1gw2848HS8P/kQ4QfZhp4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4J+ea5nb5enFASkm56MDs8t28QcjeTr869MJtzOTMQ=;
 b=Zk9V7hLDvBXY5RHFF19U7A/ANVsJDwG2LksJqhivv1DiRlzfwav/LskiaESK1wzAjuZ8xjNxnYzXlPfJgrySQSg9T9MKHrRAy0C3Z2MvIHXoIMgG7jby8qw2tIeKW0KA1hQwBvQHT2BibGmcoVdspMYTVOl3ND4qm/5e6VG5Ymfh0+iPWL5f+dXk3yvfHhVbcIW8VCrGsFcLaKNkX2UiYwUkGHg54MeOd81dH7RvWFULsJren+TULB0R5zfurfoGZ64VsZmw+yo2yX5hYDQM46poYYvqLVqkaRZ1pps53v4hpU4AHD7jr87vPB8MECQ8wWdOXiBEru3alX6+rSYU6A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9775.eurprd04.prod.outlook.com (2603:10a6:10:4ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 12:43:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 12:43:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "csokas.bence@prolan.hu"
	<csokas.bence@prolan.hu>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: fec: don't save PTP state if PTP is unsupported
Thread-Topic: [PATCH net] net: fec: don't save PTP state if PTP is unsupported
Thread-Index: AQHbGUsw7TlltIrJNU6oVx5r2PFTLLJ+UX4AgAAKtHA=
Date: Wed, 9 Oct 2024 12:43:50 +0000
Message-ID:
 <PAXPR04MB8510790CAA16524DA0AC1A0D887F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241008061153.1977930-1-wei.fang@nxp.com>
 <20241009115448.GJ99782@kernel.org>
In-Reply-To: <20241009115448.GJ99782@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9775:EE_
x-ms-office365-filtering-correlation-id: da55fca3-b542-4e6e-3cc9-08dce86006a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?M1N1Zmdjckh4VVBDcTJCUy90U2VsTXJGVW5rM2IyamVkajk0a1BOV1ZLeXhs?=
 =?gb2312?B?RVRyd1Vwdy93TGdEV0pERk8yQ0tZT3lHTlZ6d3lJKzFTb3YybWdjcU1UMkND?=
 =?gb2312?B?MGNuWjloWVBEdm1YU1FQRlZlY2NpT0xMUy9VVWNJOU82VHJGd1V0WXEwSWQ2?=
 =?gb2312?B?ZWlTU3QvaWtrSzlMMmp3VzVPN1ViSHBkVE9GN1ZpYW5hWGtLNHB2c2dZNmJC?=
 =?gb2312?B?UnZ4MUhUWk5SWk9Kdjd0U2dkWG0wMDN2RG9xTFBoZ0Y4b0xuTEluMFRNWkdi?=
 =?gb2312?B?aktSQmZCVmZVZnFldUJQWDdIZnFya1FQcDRKbThJMzJSayt2VnQrcllna1Ba?=
 =?gb2312?B?QmpqcEtjbDMzeW9oSEtQWW96MER6bFcvRkpHVWRkQmo0VW9BYlhZN1hIdUcx?=
 =?gb2312?B?NGRhRVNva2lCNmZ2K1ZMWXdvZm5qeFZLZjFXeUl2dmtqczNWNWhreXhaYnhu?=
 =?gb2312?B?Y0VkYysxeWZDUGVOU2xkclQzaVR1ZmtWWHdZYTJlbXZtR3ZvZUpzc3JwR0Nn?=
 =?gb2312?B?NUJHTklLb0xRRHhtMmNjVldBSTJxdE5hYzlRWGhsb0hJTzVROGpGRSs2YThS?=
 =?gb2312?B?SXV2WnRsRElINkE5RnRHUkM1U205a3lCNE55UHRmREZUb1RqWmNaQ0tZZEN2?=
 =?gb2312?B?Y2Rza0poWkFqekRlby9DWTFoWmxTZVNFb2VYbWJLOXBuZnFpYWNUVkEyUHQw?=
 =?gb2312?B?OUpaL0cxS2toNG0rVkNNc2k2RGIwZUdudjVRam8zYVN0TGgrQmV0UkNHSDlR?=
 =?gb2312?B?blM3bEhEQ3dMMTRWMTk4UXBZcjJDQ1pCSFF0M1F4U0ppQVhra2NrVXZ2TVZp?=
 =?gb2312?B?cHM1Zk9vN1dzeTF4WUczT3BtQWFjMjA4TlplR25EdFdhZEl2VzM4U2xKUGo5?=
 =?gb2312?B?bVZ6VVlObFUxUHpOMFByRThsQS9ZemdmUy9HM0c3dzJiaU1XZnNGMDR1ZEhm?=
 =?gb2312?B?eExCWXpIeFpDMUw5cU1EUXg3RzhyQWMwTjh0VXRHY3FpNDQyTlpCUFFGcDMz?=
 =?gb2312?B?REUvTnFtK1JWNURWK29NbWFFWVNYYndnOU9IaXRrUTEva2txTWxzaWh3bWMz?=
 =?gb2312?B?SzJ5RHJ3S2wrN3F4RGhxSGU4RHBaYzNCdDZSbnpPQXNOVDVsQzh3bzRTaEwr?=
 =?gb2312?B?eHFyeUpMVnpwOUNqRlBUbUtiYzdORzBuUW5zTGxPTi9TcG9mYnkrY0NwQTF3?=
 =?gb2312?B?KzVJYmZFdENEY21zbzBJWVZldWxUWlNpMUVQczVmb3ZkalhhL0E0d21BM3lO?=
 =?gb2312?B?VEt2RDU2bjFWN0hIOThHZnR6ZXBLbW1oVWpCcGhUc1VYVS9PQW9DY0lMWHl2?=
 =?gb2312?B?S00rSXFNRkUyQ0J6dmhCcmdKWmIxYitCamlQWmk4NCtjV0x4aHBPbWR1NmMv?=
 =?gb2312?B?dkx2TUE0QUFnc2dIQmc2STNDaWY2cmtjQmhnL01zQm5BV2VmSXB1dzJsYU5w?=
 =?gb2312?B?cHZuR01qTVc2T0R0SEdCWmVaVHZ2cGNmWjFjSHZLTnpwY1JuNzZReldqMkNN?=
 =?gb2312?B?MmUvdnIyNHlOaTRzYWxBdHBjVys1WWFuS0lzMlhLeThHc0NyVlNmL3VHVXVN?=
 =?gb2312?B?bUtIVVYwSnRLamhYVTIxWWVYaUZQSXNsdFZtTURuZE1aWTUzdE1iUXdNRDdN?=
 =?gb2312?B?THNSR0dhUEtINzJEZklYejhFZXhMNXdlenIwZmcwNWtoaGNZVnFiUlhIODhv?=
 =?gb2312?B?Z3pTa25jS216S2pPQTh1K1NoK1NMKzVjdmJPQ3h5UFVYbHZEQ2syajB3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MVZhKy9vRmlQUlExOUpVZlEyaUtNRUd2aENwdHloOUw1dWhydm1FV3cxS2lL?=
 =?gb2312?B?YzFwUEZoUWxpNkNNR3JWVGR4M3ZRVVNqbEhRYkFvRVJkcFl1aTVNKzVEbldp?=
 =?gb2312?B?REhYalQrS2dMS3ZMaHhRQXZoTlJ1WjZjNzl5Q0x1eGh2dVhnaktjK0ZoMlh2?=
 =?gb2312?B?N3NJczNnK3JNMFU2a2ZSVytjekp2Q29KU0NkYzE4QUF4N0JlcHhCdVBPMjRG?=
 =?gb2312?B?b2VuQWtjakFVdWtuOFZQK1pPQWNrbGFjdUdNUmNhY1B5WFdWWnpuZndpWXdE?=
 =?gb2312?B?ckltMkpybkVhUUZIY3YyVGcyTDVRV3FPelM4Ym1PbHpNQ3BUN0oxdGJWMXVY?=
 =?gb2312?B?MEFDK3Q3L1BpVVlTUmEraDRTTEJTWGhpVjl6cU9yR0NDY0U2cVhJSG81cEps?=
 =?gb2312?B?MVZVVDBkclZUR3dQRm10Z0pPY1dscVdpRVljdGdoRmRXZXpwWjRXY21vM2lC?=
 =?gb2312?B?UUJVY2JiSXdVRG9RNlV3NTN6VG8ySjFzY1J3djJLb2dFTjJkLytlQ21vWkpr?=
 =?gb2312?B?Y3pobXBEOTNzU2IrdEw0TXdBQmMxWHNNUGNNeTlIVXJMRmJMOWxpKzJGUTho?=
 =?gb2312?B?YUw5bTcvUDJBdVl4ekZOQXc2eE4rNUdiZ216ck9lcjZSczVnSkdzeXU0UTVz?=
 =?gb2312?B?eXR0YmpONGd3YllVY2FybHU3VFBoNUNJN0V4K2gxZjhqNUZUN2h6YWxEUnZm?=
 =?gb2312?B?a21wSGFFQS95VHRSMG9IdGVPeDJOeGVpczFLUTBaQ2U1WCtocFNHWElpWHI1?=
 =?gb2312?B?eGZaMUFUaWJJTm1aV21PekdXdU1IVWJmcHU2ZTFtWHo0dm9ISGZlTkNpaFk3?=
 =?gb2312?B?UlhhYUJRQ01BbERsK2IzS2Z6S2l1YW42OGRGQ2pMSzNSdkZOcmd6cEZpNjRN?=
 =?gb2312?B?enpRVzRDY0ZpMGxCR0p1cm5LMGZBaW1jZG02NE0vNmxLTUVvdmZWZWFWK0sr?=
 =?gb2312?B?NURzcjMrUzlXbVdIWVY5ZGpnZzBrekJITW4rbFIyWDZmRURJNEJtL0FDMTl2?=
 =?gb2312?B?emlrakNiZkR1T25RVVdsb3llUjRrclNIODFlYVhGM3F4QndqcWxrU25ZZHdI?=
 =?gb2312?B?WWtGRHBVRnBOQkx2em9udGRLVm9FQ1JZN0FCZ2lTQWp6MGRHYTJ2aGJ2ckp1?=
 =?gb2312?B?QzFOM0pYNXliTDFESFk2dFhtT0M0czNXOTZaSHB0MTYrZURYTWRXc0daUGs1?=
 =?gb2312?B?WVlZc2lsNEdweVJuRXZzRzVtdlpIN1ZYWngvTGxZaUVFdmpoUjMzTThCSzcy?=
 =?gb2312?B?VlB2RnVqbDRMelNYZVB1N3ZMVXBIVmdrc25NSXQwQnBjaFdyNFEvRmFvVkVW?=
 =?gb2312?B?UzVobXB6UStOajc2M0RCSFVMSHJueUhLYm5JUWp3NWp1TXNBKzFwSGdBc3Z6?=
 =?gb2312?B?Z2pXeUlZZmZLUk8yZ3Qva0hXYXNMS2FpOU1pbEVXOVVtK01MUlFBU1V1Yi9j?=
 =?gb2312?B?TDlCaHI0TTNXam9EbmhVeFpvbWxkYURRdE5mUWtKMWxzRWJiemhwVmZrM1Ew?=
 =?gb2312?B?TktTbmxIOTZQd093d3B3WXdnbTJuYnNyMjhQOUhuemtab0JiaTJ3OW5wUWUx?=
 =?gb2312?B?cUdXRUJCYmhheWFPeVNheC9zQ09BMU15YTZaZmdmMXl5WnBsaGV2UzFnMXNP?=
 =?gb2312?B?eWtDRFdoSFF1THBRdkVKM1IwVGF2c3NsTGtXTE8wbGVQNW1pdVR5UkR0RWxj?=
 =?gb2312?B?TlJxd3JKczB2RlFlRlA5d29PWTQzNncycm5EV2JWNmhJZ1ZKUUtsNFhmQnZs?=
 =?gb2312?B?S2FralA1a3ZBcEtyZU5YeDJCRXM1N2VjTnFFVWhKcXR0eVg5Sm5rQnErczN5?=
 =?gb2312?B?blNlQnZkZWtrTjRKZVFUbDlSN29MU2U5MWJ4TXBBb3dwOFNxaUpGQTVsalVm?=
 =?gb2312?B?dWZRSTRLOGZ2QTl1Z1UwdVkwYk5zcktiSmlZVG9JNEdkVmdTSU81VHVYWWtt?=
 =?gb2312?B?Z3BoSHBMZlZjVi9BWm9hRnY3VGZhMTh6YVA2aERTTWkxVytnOFdSWm9NY1hj?=
 =?gb2312?B?Q3hYbEdEY2JKelpjQitaNk1Nc0lYeVNubGhkUzhGd1RVNXhHb1NvcXFFdEVz?=
 =?gb2312?B?SXJMOWJzamJ3TWZZRUhCYUlqbldCdXVYS0VBZGlsdmhzcTBTMTNXc213OVhT?=
 =?gb2312?Q?GGoE=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da55fca3-b542-4e6e-3cc9-08dce86006a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 12:43:50.4805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bifSedOQm+ZIzYWG9l9nSZsN+YypZqVUkulr8eWbNvUf2P6tanMrfTkKKyIcfC1LjcKBXmRLCEpjLEM0U3qYvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9775

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jEw1MI5yNUgMTk6NTUNCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRA
Z29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcmljaGFy
ZGNvY2hyYW5AZ21haWwuY29tOyBjc29rYXMuYmVuY2VAcHJvbGFuLmh1Ow0KPiBTaGVud2VpIFdh
bmcgPHNoZW53ZWkud2FuZ0BueHAuY29tPjsgQ2xhcmsgV2FuZw0KPiA8eGlhb25pbmcud2FuZ0Bu
eHAuY29tPjsgbGludXhAcm9lY2stdXMubmV0OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggbmV0XSBuZXQ6IGZlYzogZG9uJ3Qgc2F2ZSBQVFAgc3RhdGUgaWYgUFRQ
IGlzIHVuc3VwcG9ydGVkDQo+DQo+IE9uIFR1ZSwgT2N0IDA4LCAyMDI0IGF0IDAyOjExOjUzUE0g
KzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+IFNvbWUgcGxhdGZvcm1zIChzdWNoIGFzIGkuTVgy
NSBhbmQgaS5NWDI3KSBkbyBub3Qgc3VwcG9ydCBQVFAsIHNvIG9uDQo+ID4gdGhlc2UgcGxhdGZv
cm1zIGZlY19wdHBfaW5pdCgpIGlzIG5vdCBjYWxsZWQgYW5kIHRoZSByZWxhdGVkIG1lbWJlcnMN
Cj4gPiBpbiBmZXAgYXJlIG5vdCBpbml0aWFsaXplZC4gSG93ZXZlciwgZmVjX3B0cF9zYXZlX3N0
YXRlKCkgaXMgY2FsbGVkDQo+ID4gdW5jb25kaXRpb25hbGx5LCB3aGljaCBjYXVzZXMgdGhlIGtl
cm5lbCB0byBwYW5pYy4gVGhlcmVmb3JlLCBhZGQgYQ0KPiA+IGNvbmRpdGlvbiBzbyB0aGF0IGZl
Y19wdHBfc2F2ZV9zdGF0ZSgpIGlzIG5vdCBjYWxsZWQgaWYgUFRQIGlzIG5vdA0KPiA+IHN1cHBv
cnRlZC4NCj4gPg0KPiA+IEZpeGVzOiBhMTQ3N2RjODdkYzQgKCJuZXQ6IGZlYzogUmVzdGFydCBQ
UFMgYWZ0ZXIgbGluayBzdGF0ZSBjaGFuZ2UiKQ0KPiA+IFJlcG9ydGVkLWJ5OiBHdWVudGVyIFJv
ZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQo+ID4gQ2xvc2VzOg0KPiBodHRwczovL2xvcmUua2Vy
Lw0KPiBuZWwub3JnJTJGbGttbCUyRjM1M2U0MWZlLTZiYjQtNGVlOS05OTgwLTJkYTJhOWMxYzUw
OCU0MHJvZWNrLXVzLm5ldA0KPiAlMkYmZGF0YT0wNSU3QzAyJTdDd2VpLmZhbmclNDBueHAuY29t
JTdDYjEwY2FjOWVkOGNkNDMyODRhYWUwOA0KPiBkY2U4NTkzMGNkJTdDNjg2ZWExZDNiYzJiNGM2
ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODY0DQo+IDA3MTY5OTk3NTI5MzUlN0NVbmtu
b3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQw0KPiBKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9MQ0KPiBn
eHdueE5qazkxeFg3SSUyRm9jbyUyRjRPaEJieE5DcnloRE1vNzJPOUprcjJ3JTNEJnJlc2VydmVk
PTANCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMgfCA2ICsr
KystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMN
Cj4gPiBpbmRleCA2MGZiNTQyMzFlYWQuLjFiNTUwNDdjMDIzNyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ID4gQEAgLTEwNzcsNyArMTA3
Nyw4IEBAIGZlY19yZXN0YXJ0KHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2KQ0KPiA+ICAgICB1MzIg
cmNudGwgPSBPUFRfRlJBTUVfU0laRSB8IDB4MDQ7DQo+ID4gICAgIHUzMiBlY250bCA9IEZFQ19F
Q1JfRVRIRVJFTjsNCj4gPg0KPiA+IC0gICBmZWNfcHRwX3NhdmVfc3RhdGUoZmVwKTsNCj4gPiAr
ICAgaWYgKGZlcC0+YnVmZGVzY19leCkNCj4gPiArICAgICAgICAgICBmZWNfcHRwX3NhdmVfc3Rh
dGUoZmVwKTsNCj4NCj4gSGksDQo+DQo+IEkgYW0gd29uZGVyaW5nIGlmIHlvdSBjb25zaWRlcmVk
IGFkZGluZyB0aGlzIGNoZWNrIHRvICh0aGUgdG9wIG9mKQ0KPiBmZWNfcHRwX3NhdmVfc3RhdGUu
IEl0IHNlZW1zIGxpa2UgaXQgd291bGQgYm90aCBsZWFkIHRvIGEgc21hbGxlcg0KPiBjaGFuZ2Ug
YW5kIGJlIGxlc3MgZXJyb3ItcHJvbmUgdG8gdXNlLg0KPg0KDQpZZXMsIEkgY29uc2lkZXJlZCB0
aGlzIHNvbHV0aW9uLCBidXQgd2hlbiBJIHRob3VnaHQgYWJvdXQgaXQsDQpmZWNfcHRwX3NhdmVf
c3RhdGUoKSBhbmQgZmVjX3B0cF9yZXN0b3JlX3N0YXRlKCkgYXJlIGEgcGFpci4gSWYNCnRoZSBj
aGVjayBpcyBhZGRlZCB0byBmZWNfcHRwX3NhdmVfc3RhdGUoKSwgaXQgaXMgYmV0dGVyIHRvIGFk
ZA0KaXQgdG8gZmVjX3B0cF9yZXN0b3JlX3N0YXRlKCkuIEhvd2V2ZXIsIGNvbnNpZGVyaW5nIHRo
YXQgdGhpcyBpcw0Kbm90IHJlbGF0ZWQgdG8gdGhlIGN1cnJlbnQgcHJvYmxlbSwgYW5kIHRoZXJl
IGFyZSByZWxhdGl2ZWx5IGZldw0KY2FsbHMgdG8gZmVjX3B0cF9yZXN0b3JlX3N0YXRlKCksIEkg
ZGlkIG5vdCBkbyB0aGlzLiBJZiB0aGVyZSBhcmUgbW9yZQ0KY2FsbHMgdG8gZmVjX3B0cF9yZXN0
b3JlX3N0YXRlKCkvZmVjX3B0cF9yZXN0b3JlX3N0YXRlKCkgaW4gdGhlDQpmdXR1cmUsIEkgd2ls
bCBjb25zaWRlciBpdC4NCg0KVGhhbmtzLg0KDQo+ID4NCj4gPiAgICAgLyogV2hhY2sgYSByZXNl
dC4gIFdlIHNob3VsZCB3YWl0IGZvciB0aGlzLg0KPiA+ICAgICAgKiBGb3IgaS5NWDZTWCBTT0Ms
IGVuZXQgdXNlIEFYSSBidXMsIHdlIHVzZSBkaXNhYmxlIE1BQw0KPiA+IEBAIC0xMzQwLDcgKzEz
NDEsOCBAQCBmZWNfc3RvcChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldikNCj4gPiAgICAgICAgICAg
ICAgICAgICAgIG5ldGRldl9lcnIobmRldiwgIkdyYWNlZnVsIHRyYW5zbWl0IHN0b3AgZGlkIG5v
dCBjb21wbGV0ZSFcbiIpOw0KPiA+ICAgICB9DQo+ID4NCj4gPiAtICAgZmVjX3B0cF9zYXZlX3N0
YXRlKGZlcCk7DQo+ID4gKyAgIGlmIChmZXAtPmJ1ZmRlc2NfZXgpDQo+ID4gKyAgICAgICAgICAg
ZmVjX3B0cF9zYXZlX3N0YXRlKGZlcCk7DQo+ID4NCj4gPiAgICAgLyogV2hhY2sgYSByZXNldC4g
IFdlIHNob3VsZCB3YWl0IGZvciB0aGlzLg0KPiA+ICAgICAgKiBGb3IgaS5NWDZTWCBTT0MsIGVu
ZXQgdXNlIEFYSSBidXMsIHdlIHVzZSBkaXNhYmxlIE1BQw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+
ID4NCj4gPg0K

