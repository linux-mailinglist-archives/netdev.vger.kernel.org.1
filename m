Return-Path: <netdev+bounces-153162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CBC9F71D0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738D6168837
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8F14207F;
	Thu, 19 Dec 2024 01:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ukl+GKHT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F972AE94;
	Thu, 19 Dec 2024 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571982; cv=fail; b=aUnka4VKf+gZA2NMA9ujMUn2oddytcVfj4TjiU3xdDt4ncljHSB0nG4l6lO7FZrVCEl7V6pFWtWHCYr49fW1oCJCQcRuk3G8uQtvJi6SEhwJmGaRcnDHjGxZyiXOCMJ9wKEoVjJgs5XoXApsTZLdVWttrv5Hh4WSSIgOKwhttXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571982; c=relaxed/simple;
	bh=xo6m70VndP6jvF70wVgD/Hn5NUnu1z/loPPdctfoF7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uPjdJ2DquKx4IaajElEo5/nm5293ArHuwJEs33HPORKN6ir3jP91BOMMvw/omQ57ualFpLja/LwjTjQcOZc24cS+PclhE9oduBbIPopFi/wHUYDeRwONg4APXK13Tr5vm8v5nTkce3z1neRC29B6hOm0nvUun13ziTLr3Xv2+bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ukl+GKHT; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9WE/ZwpituPgLUF2Xv5Vy2nbYVdKBXTmDDKVOi/85OBXTRbMWZJ8wt4G2RULLwSpxYY/a7kA+YGOR13Vxa2fMowM96P3gQUZAqJ0j//vMD+S3yN+1xMqSlp46JM3UtgpBfzmQKSRpbyiZBlYXw4SoIRJaMngC4lKYyDtrtWOr6RXE86ItCk8GKw86Sw45xOHyk6fqaVaLvT67EuCN/kHIQoDB/HPGUZKYlhFlHdca15Pk8VDRlELyiNEVVumIGDPL+m2kf/zepFFZcNHUKTdTZ/wIMC27TkDtIX56dtgLj7sMnnSkT7ZBfIXOHISohnPl9sFrBX0OhQpsH5xYyXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo6m70VndP6jvF70wVgD/Hn5NUnu1z/loPPdctfoF7I=;
 b=Nbuma+dpoC8EuORzIcw8VBG3wei2vB5zQ56nd9BFpz90uHorommUM99kxByV5HRQrqoWSEsMa0PjszKq97dPdGQiMKmsn9GofX0WtGPg/9PMSbR49dHcEW9PyCIxMEUQJlmhdTYNV65kNDV70IosJiT9Pnvwor099Ot4x1paQxWUyQtdBDyrdaVWCE77r97rkOndJZAaMafy3R0m4F3OUyoY6yIUEhrbHhWOJ2LXCCC51Vyk3iX//Hz/Yzt3YoTRs8r3eOp6/UCITjcD9ZnXiGPo6Inr9sabo9zSifmk+yI9Ga5RJ7WXUPoqZWQXPrI7vY/Jj+IiaUTHKa6AZlz5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo6m70VndP6jvF70wVgD/Hn5NUnu1z/loPPdctfoF7I=;
 b=Ukl+GKHTPW7L+g24W/08C4BhvcbaOvHmxwa0/Ge2vJETQQFh7E4vTavyxSUV5AnjIZZVnaGN77lW4f0SjJrXZgtfKKRzHi5KoQaP7e1BeJvmyOMZgzsk1eiJngQq23HbxAVHxgImyen0BSIi7qwIBKJdIDRJoEwlTNDGeLdhLt1KVAnFRsN60UAmnfBXl+UxIZuRxNy41gWoZgPpCXiGpPNYR89mqdgGv4PyOBvazftEEc+ViqpsdI1RtEhC4bCaGOssbXGhNqQDbU50UuajPHNxClI6ODss8g2kX8hlLT7S40driQG40l3GjBTMg8SttnfVWWyoCqV9ykc3IlRhGA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8850.eurprd04.prod.outlook.com (2603:10a6:20b:42d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 01:32:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 01:32:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>, "horms@kernel.org" <horms@kernel.org>,
	"idosch@idosch.org" <idosch@idosch.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v8 net-next 3/4] net: enetc: add LSO support for i.MX95
 ENETC PF
Thread-Topic: [PATCH v8 net-next 3/4] net: enetc: add LSO support for i.MX95
 ENETC PF
Thread-Index: AQHbTQds3cs7GTJJukOoxOijXKUPD7Lql7UAgACuRgCAANKcgIAAtrGw
Date: Thu, 19 Dec 2024 01:32:56 +0000
Message-ID:
 <PAXPR04MB8510B5F144CE751D74DEE0F788062@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241213021731.1157535-1-wei.fang@nxp.com>
 <20241213021731.1157535-4-wei.fang@nxp.com>
 <ee42c65c-cc35-4c6b-a9d0-956d06c56f7e@intel.com>
 <PAXPR04MB8510CFF87187B095D15DBD6088052@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <48f2de4d-1695-4d8d-834d-b306b17e09a1@intel.com>
In-Reply-To: <48f2de4d-1695-4d8d-834d-b306b17e09a1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8850:EE_
x-ms-office365-filtering-correlation-id: 7d982a17-93d4-4bb9-3df6-08dd1fcd10c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnhHR1Q4OHBFSzgwUzlpWU5yMFhTUm5uRVpKcDkza2lvOG9tRWdwazRkaGYz?=
 =?utf-8?B?R0tobDIrVUYraW41bVl3ZnB6NDNRKy91MlhockFIdzdheTRzYWcvZU1OWnRj?=
 =?utf-8?B?R2NzWlZBUmU4eWdhWlNnMUoyVktmK2R6RVcwK0I0UGVBZnVnK2RlbG1TQm91?=
 =?utf-8?B?eC9GeWE1bjNUdXJQLy9xY1VFT1FTcG9aVHpySnk5Ujd1TGtOOG0zU28vZnlO?=
 =?utf-8?B?bDUvZDk4dVJTci9QYUZEckxHY0RUQ1k5T01vUzlrZ2ZsSmFTN0JWa1Z5aTRu?=
 =?utf-8?B?U091VlpiZzZwV09jQWY0VU0veHVwVlNvV1lvWEtpUnZGUnMvQUNxSjN6WTFS?=
 =?utf-8?B?RHpSZTIyaW9DQVhqbjZCQ3U1eUk0SkpLcUo5QTJFdkY2NkpZYy8vRHRCU2Zw?=
 =?utf-8?B?U2ZsT0laaWNkdUszNU9mcDhmMUcvUGtkYWlnV3NrRGZTenBpTlViWVphU2tY?=
 =?utf-8?B?Y2RuV1liV0lzM0N0VXB4QkdpaTVBa2tJaExsYWJLT3hqeSt3aUFnQ0k5SzE2?=
 =?utf-8?B?L3NhdXloZTdHZG82WjBNSXd5TThlRFUrUGxKWS8zcWtVVDhXSGJ6MG5hWm82?=
 =?utf-8?B?ZHFzeG5KVHgxVFluYUo1c1dKaHJiYUJIRGtJeTg2SzY1VEJGdGpIU00zbTl5?=
 =?utf-8?B?dEYzczkydWpiNjZWNFkvV29KblU2NGlxRkY3dkpOK0RUZGJCekt4aHhOTFZi?=
 =?utf-8?B?aVRpTndsTkNkMWdmN0t0RVRaU2tadm41QVg2K21FV0ozQWNpYmw4T3pybi9p?=
 =?utf-8?B?NTJkWjlWVGRLL1ZZaG01NGxnOUNoZEU3R0ZFS08wK2xIYk8vYjNzdzFPNGRC?=
 =?utf-8?B?UWZtNEgrVWZES1dmWUQ1YXRsanIxWnRlVlZxNWFlTW9OZzJjOHI1RzM1amg2?=
 =?utf-8?B?eVk0VEZ3UnBkelVlc29ESkd4TFp1eWpWQ1A0MUdvTmRMcEExcEdyRTFxaUd5?=
 =?utf-8?B?cEpZNmVqMFNoMDlENEEzSkNvQ2IrSnVodGJVMFcvaENMMFRnRE1ZcWJGb3ZL?=
 =?utf-8?B?WkRNSkgrNXltbVFqUzkySm91RlVRbGRoVWZhbm5yYk41anZwTE9oTGhDNnNO?=
 =?utf-8?B?S1RnOEhwQTkrUmlhVDI3eUx2enZ3enUwWjY3OTM2VHRKcEhBbkxJSmdwdDlL?=
 =?utf-8?B?QnpvWjF4Mk1nZVFGZ3VPOEhsYUxjaXZEaHpadHdUWUtWTGtmNnh2Q1lFVG1L?=
 =?utf-8?B?dVplL1J5MzlWK2JPVU4vMEViUzFweVozbVVmRllhK3RZUTV6YytHMGNGdkVk?=
 =?utf-8?B?ZVlNWmwwSHZURmE2UkVzamx4anYvMkVtUlRsWGFJM29kUFE3Z1pXTmVqK2Ja?=
 =?utf-8?B?QUJiS1loSmRhSFFCKy96L2NPTUl2aXBTNzhlUXdqUTV4dVR0MHQvVFJHLzIv?=
 =?utf-8?B?ZzNMR1UrNWtoUEgxdHZhTEpNa2wwWWJjMkxvR3ZaSjZCNWZXMlhwL2V0WWJE?=
 =?utf-8?B?REtOWldrQXpBaWJsdTZQUGJKTWZod2FjSUF3eFhyZVVOb08wdTNUcUN4MFRU?=
 =?utf-8?B?TjBYeVJ6SnZWaVJYMDYrTU1hVytTcmxrdHhEU2hFTmZBeDBBQjNHNFNpbGh4?=
 =?utf-8?B?ajhUMXIrbERFZ0ZIeWNQM3hoeUQ0VXpJdnhBQXFtdnI0RVdQWUVJd3RkbUdO?=
 =?utf-8?B?YjZVUkpvajJoWHNxbVlpZ01NVXdMRGVMRlRTeldMUmxEWDYrKzZnUFYvWDJi?=
 =?utf-8?B?c0hXMzh3NlZodTZoUldUSmZ6bThjQkExTXAxUU1JYmt0UExSVmMweWRKVS9N?=
 =?utf-8?B?S0tGQkFuUVNwSTVBcHJaSVRKcm0rWUxlRUc2c011VkxRdlBxYnB0dE5oekVN?=
 =?utf-8?B?K2dEVWNHQjVhU2RxUnlwaTZqVzJodXlvTWRXRGNTaFMybjlYWFo0NVBsa1Fr?=
 =?utf-8?B?L2JvWW4wYTRzM2NLdG1kM3FzUTcyZjJBRERuTEJlbUtYd21sZTNFK0QrS0ZT?=
 =?utf-8?Q?Hn35WAk0PImZttKTFZTHdYP/K4+0Qz9l?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjQ0U3Q2WTNoeUorZUpYcTR4YzhIZ1RONTNSR2xMY3dZUmxUelV2OHQ3c0Ju?=
 =?utf-8?B?and6ajFpQzlyZjhUQzVSUXBDUnNOeFlSUnFwWTV5MU92ZDhFakNNbFQ1QUhB?=
 =?utf-8?B?SnBZdE1laXRsaFQwL3ZsN2Z2aHBKWlV3L213OUZtalptNzF0cytwL3dUSmxR?=
 =?utf-8?B?TUZZQmk5c3d1bmQ5WVNVbHhlakdPYXBkcjVtMHNpK3VpL3ViWE9pWitrb3Zy?=
 =?utf-8?B?K0g3Zi9odENnbVdCNVVxS1hNZ21aTUtkNnF0Y0ZXUEh1L29KY2QzTVl3ZFhy?=
 =?utf-8?B?aDU0bHp6TG1kM25TcUUzUWQxN1Z0REZVcVVoa1JXNHM3eWdvUmFLU3hUd3RE?=
 =?utf-8?B?b2M3d2Q2OHdrZXJqNTY2WTh6SXR5UU4zNVlsNGEwVVNESzFXMHVPTmJIaWZa?=
 =?utf-8?B?L3kxRlZnbXBEZk95NzNjK1RVS25KWWh5SXRFZzdmamtyMVc2T2p6d0gvWW92?=
 =?utf-8?B?bUczdUovYkJNWUNtYnBzdHpIMGw1a1NkdXNtVWMrWTVsZnNybVB4NHdMVENo?=
 =?utf-8?B?bGp5Y3NWVklxWVczcVhRdkhDTWptSUlBNkUrNGY1SnFlTHNDZ0pab2V5NzRD?=
 =?utf-8?B?NXVqdXZmZWkrZzRGdmtNUVY5U0QrQmZUU01Mb281d2FuM1RmT0RRNk5pNFhJ?=
 =?utf-8?B?Nmszd0dJVXRBM0NxYlBNTEdwMG5FSSttdmY0RjRHWitIZzlHamlpVEZuT0Rt?=
 =?utf-8?B?Q21VbWxhYWVGR28wSm9pQmtJbitEZ3dyWUZHSjZNZGh3dklmbDdZekIyYnhq?=
 =?utf-8?B?MU1VYkZQMXBNaTBTdDZFOG81OWFLUG82dDlQV3hvVFU0a2hoa0xBZHFLczhU?=
 =?utf-8?B?Rk9Qb1puK3VjMjlVMHA1cUc4VXJrKzB5WHJtT0ZtZUxSYmNiWXM2QzhsZjVJ?=
 =?utf-8?B?aHBoaUNjVXBNY0wzeUFnaGtkcTRiZFlqR243U2V4c3IwZFgydEVlUmxEcmNU?=
 =?utf-8?B?RTRtZ2tWYTA3NUR6MTI3d0lLTHhabUswSy9hUVRUZjhWZGQ3Vk9YWGliZTRU?=
 =?utf-8?B?dFJEUmNMNGtIV2tqNXVVd215cVVVd1o0Mm91S2kxOUE3RTRDbVIzc3dJMGRR?=
 =?utf-8?B?ZW1ZT3o0U21HZHF5dkVOU3VGMVBQSnBzV3gzYW1OTnNYN3pkYmhJOWJSckxs?=
 =?utf-8?B?enhSVmlOUnYwczFxcEtTQi9OMHgvdkxWTndtQ0I4SnNhYm9WcGVxTUFQNXpq?=
 =?utf-8?B?WDFLZk83LzUxOS9jT2EvMk5WYm5XZFoxeGIyM2RvWlA5Z09EdnFucW1EekM2?=
 =?utf-8?B?ZkFkS2pHU3c2MEU0ZUVhOHFXb05DSWRqR2YzbVExTUhxVDdmY3Fsd1JCZXdu?=
 =?utf-8?B?Q1RjaVpjQ3RCM3krdkkwSHMvTVNLYmo3YzRWbmtQZW1HNHN5dGVZQjFicWRE?=
 =?utf-8?B?TDEwbnhkdERML1pxUm5NODdtcmdBdmlzbXhhSU1LVW9ZTndxZjdGbTJSUEI2?=
 =?utf-8?B?Z0psVDhGaXVENVBoSXlWSys5c2ptb28rWlhaNWZiTm5iK3huSUFJTGZjZDV4?=
 =?utf-8?B?NG10N2Q2OHcxZFdiRFV5dVBjRXBXUFU4bWJqWUFvdFI1Rm1iMVlWNDNuZ2dz?=
 =?utf-8?B?ei9sWFpEYVFMTHlXZmFHcnE5R2VnSURUclc5SlVJRGE5UmRjNWZiWHBjUnc4?=
 =?utf-8?B?d2t4eVBLbUcxd0dSVndKeFJSNmZJNVVRZFQyUENpUlQ1TkNQVjVwVXEzUzRS?=
 =?utf-8?B?aXlNRDJ1RW1lMlJiRkE0T1B6Q3FzbWlxeVg4cDVqSWZLWUtHK3daVy9KTGFD?=
 =?utf-8?B?NjA3ekhHRDNDMW5ZamN0T3UvYzZCREZ2UHdNbS9LREpvTytDMWY0SDdlVVdm?=
 =?utf-8?B?SXN4NDltcVcvaEU3Q1dldm5oUXUzU0JTRjdFcnpET21nbTFUZzFWTCswTXdk?=
 =?utf-8?B?NTU1dnd3QmZxYkl0bDZ3bXFkVy94RnQ0WWVGUXJaNTMxbTVkNlBxem5Zd252?=
 =?utf-8?B?OXlDZCtSQTgrLzlQSVJmQkt6ZFVLaDVUUGhGMjgrTDZKdnpXZURuU3p2M1JI?=
 =?utf-8?B?VFJqY3J6WmVYYnBvS0lvWVlha3FiQitrNWJYREV3U1ZkVElldTRTNWxFSXRW?=
 =?utf-8?B?WHdBdC9QTThTZ3EvU1BuNGMrb2VaVklmWSsvdDRlTlgvZWMzN0xQRmpBL29G?=
 =?utf-8?Q?uo4c=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d982a17-93d4-4bb9-3df6-08dd1fcd10c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 01:32:56.6508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vs3eNA7DaWYHxT+3ACfRFkLzQwVG1MkXLkwR0mzoW/4TFJzRJX0U2duYif+vcB2I/n1flalpOdXbsEV4z1tfXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8850

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgTG9iYWtpbiA8
YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT4NCj4gU2VudDogMjAyNOW5tDEy5pyIMTjml6Ug
MjI6MzANCj4gVG86IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogQ2xhdWRpdSBN
YW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBWbGFkaW1pciBPbHRlYW4NCj4gPHZsYWRp
bWlyLm9sdGVhbkBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsN
Cj4gYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBn
b29nbGUuY29tOw0KPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBGcmFuayBM
aSA8ZnJhbmsubGlAbnhwLmNvbT47DQo+IGhvcm1zQGtlcm5lbC5vcmc7IGlkb3NjaEBpZG9zY2gu
b3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggbmV0LW5l
eHQgMy80XSBuZXQ6IGVuZXRjOiBhZGQgTFNPIHN1cHBvcnQgZm9yIGkuTVg5NQ0KPiBFTkVUQyBQ
Rg0KPiANCj4gRnJvbTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IERhdGU6IFdlZCwg
MTggRGVjIDIwMjQgMDM6MDY6MDYgKzAwMDANCj4gDQo+ID4+PiArc3RhdGljIGlubGluZSBpbnQg
ZW5ldGNfbHNvX2NvdW50X2Rlc2NzKGNvbnN0IHN0cnVjdCBza19idWZmICpza2IpIHsNCj4gPj4+
ICsJLyogNCBCRHM6IDEgQkQgZm9yIExTTyBoZWFkZXIgKyAxIEJEIGZvciBleHRlbmRlZCBCRCAr
IDEgQkQNCj4gPj4+ICsJICogZm9yIGxpbmVhciBhcmVhIGRhdGEgYnV0IG5vdCBpbmNsdWRlIExT
TyBoZWFkZXIsIG5hbWVseQ0KPiA+Pj4gKwkgKiBza2JfaGVhZGxlbihza2IpIC0gbHNvX2hkcl9s
ZW4uIEFuZCAxIEJEIGZvciBnYXAuDQo+IA0KPiBbLi4uXQ0KPiANCj4gPj4+ICsJCQkJCSAoKGZp
cnN0KSAmIFNJTFNPU0ZNUjBfVENQXzFTVF9TRUcpKQ0KPiA+Pj4gKw0KPiA+Pj4gKyNkZWZpbmUg
RU5FVEM0X1NJTFNPU0ZNUjEJCTB4MTMwNA0KPiA+Pj4gKyNkZWZpbmUgIFNJTFNPU0ZNUjFfVENQ
X0xBU1RfU0VHCUdFTk1BU0soMTEsIDApDQo+ID4+PiArI2RlZmluZSAgIFRDUF9GTEFHU19GSU4J
CQlCSVQoMCkNCj4gPj4+ICsjZGVmaW5lICAgVENQX0ZMQUdTX1NZTgkJCUJJVCgxKQ0KPiA+Pj4g
KyNkZWZpbmUgICBUQ1BfRkxBR1NfUlNUCQkJQklUKDIpDQo+ID4+PiArI2RlZmluZSAgIFRDUF9G
TEFHU19QU0gJCQlCSVQoMykNCj4gPj4+ICsjZGVmaW5lICAgVENQX0ZMQUdTX0FDSwkJCUJJVCg0
KQ0KPiA+Pj4gKyNkZWZpbmUgICBUQ1BfRkxBR1NfVVJHCQkJQklUKDUpDQo+ID4+PiArI2RlZmlu
ZSAgIFRDUF9GTEFHU19FQ0UJCQlCSVQoNikNCj4gPj4+ICsjZGVmaW5lICAgVENQX0ZMQUdTX0NX
UgkJCUJJVCg3KQ0KPiA+Pj4gKyNkZWZpbmUgICBUQ1BfRkxBR1NfTlMJCQlCSVQoOCkNCj4gPj4N
Cj4gPj4gV2h5IGFyZSB5b3Ugb3Blbi1jb2RpbmcgdGhlc2UgaWYgdGhleSdyZSBwcmVzZW50IGlu
IHVhcGkvbGludXgvdGNwLmg/DQo+ID4NCj4gPiBPa2F5LCBJIHdpbGwgYWRkICdFTkVUQycgcHJl
Zml4Lg0KPiANCj4gWW91IGRvbid0IG5lZWQgdG8gYWRkIGEgcHJlZml4LCB5b3UgbmVlZCB0byBq
dXN0IHVzZSB0aGUgZ2VuZXJpYyBkZWZpbml0aW9ucw0KPiBmcm9tIHRoZSBhYm92ZW1lbnRpb25l
ZCBmaWxlLg0KDQpUaGVzZSBhcmUgZGVmaW5pdGlvbnMgb2YgcmVnaXN0ZXIgYml0cywgdGhleSBh
cmUgZGlmZmVyZW50IGZyb20gdGhlIGdlbmVyaWMNCmRlZmluaXRpb25zLiBUaGUgY3VycmVudCBt
YWNyb3MgYXJlIGFjdHVhbGx5IGRpZmZlcmVudCBmcm9tIHRob3NlIGluIHRjcC5oLg0KVGhlIGdl
bmVyaWMgZm9ybWF0IGlzICdUQ1BfRkxBR19YWFgnLCB3aGlsZSBoZXJlIGl0IGlzICdUQ1BfRkxB
R1NfWFhYJy4gDQpBbnl3YXksIEkgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIGFkZCB0aGUgJ0VORVRD
JyBwcmVmaXggdG8gYXZvaWQgcGVvcGxlDQptaXN0YWtlbmx5IHRoaW5raW5nIHRoYXQgdGhlc2Ug
YXJlIGdlbmVyaWMgZGVmaW5pdGlvbnMuDQo=

