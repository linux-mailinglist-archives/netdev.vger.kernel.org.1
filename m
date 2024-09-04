Return-Path: <netdev+bounces-125172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB5596C2AC
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D791C20DFD
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C981DEFD0;
	Wed,  4 Sep 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="qv0wpCCD"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2098.outbound.protection.outlook.com [40.107.22.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E11DEFDD;
	Wed,  4 Sep 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464476; cv=fail; b=S0LtYqcFeSioUrGYxuZqXEpWRHRW83lt5yhPsvi2Sq4V4+XuzUizAO0LkVdq2VYX3DwGd46wvT6QmsR2zqphnFRzuj4Gyck2pFxs2HJ4YDBTO4SJhFcFn1BG0Cj9E41tYjGDBEfe2uBRhjcHhEbyZlLKAfAGj2n1fr6kO4AMiXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464476; c=relaxed/simple;
	bh=QTKLWCekHEFGWFtdi+HzMakTPL3L2Hb0B+EmORYgeXU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JgRqSz4tEziru/X8pP1TM38lTCQkCfrGe3nAAnweuESQX2smpFxgQrcJ2eGh9KIQ/KcaBr2y0DN6dsiiy42L1Y3AJLEjEaaEzFOXbNa4QdgQvqNIKSaVX15yXmcUiBjyFrohG5Wrfzu5EsG9Hf4F9h2HTk9slZZ5s7xtliVVmMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=qv0wpCCD; arc=fail smtp.client-ip=40.107.22.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYDhj9JMJbmOEpOw+d41jPKjSFCvHlSd9oZxPxpilc0elsuOVIOkHcBvOs1WzJzry4dyHbRgeZtF4hcLKQKo5PBI0Wm23SPZjUFKDWh4MYTfHLJwi4Bg+J8YLti1K/mttgO99xyr1QGtiQ5pmm3MrJjBxFwXX1F31xaf8GVH+fw8ipZMjj164AR41c/sLMenn/sbEEwgAdiEKA3L1CjBN0tsHrAnnOjSG/D9v6JcE71KUFeitnbDz892sGmAOObSWzMTAGh9tOgWdmikyuj4WHe0XRT99fzvlwdFnn9KGZcOj7qnOxDTgAnNTRHgbkWy0ra5mDro994BW83P6wL1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTKLWCekHEFGWFtdi+HzMakTPL3L2Hb0B+EmORYgeXU=;
 b=jVFtzJEUuXs5u3edPUvoWcFZAvMsPeKtGxzI3WkG36jm6Gqnl6CXIA8V9EFRlD37k+DqL+TE69mXqrPEmxs2jce+wwpolqyVC4ClYAV2v8I6eSUn5DnkUhd/PqwUHrwXejPScnHTsLHS3byzPr74zgB20nQ9lz/BppNVqJ0uMf4s6acqt3cHxGY/EsF2TVxAcuu38pB8HeRmhNgH4eCjT9ZEqfu0DZdNvUIC0I3ZrmTQCm7pvtPnsQjIArrUeAOG5PMZ1tdDUnuChob7Du1xsld+iX3YCxjFBNdIS4ZMDM26Ax+zISxR90SCuX+ZaS5ugEb9GdKtRyeZh4Px36MDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTKLWCekHEFGWFtdi+HzMakTPL3L2Hb0B+EmORYgeXU=;
 b=qv0wpCCDsgK3HTJitMalQuolT9UmSaJL76C7EJxtbCHWxfH8AWyxou0bTZQSL0L5JDvcpAyVdlR2jXGbNsHbjP3UNyNAaeaB7A4GtXAi/eRkmu+OSRW2LgP3CU5Bre8H75OXKQYvKRThZoAFiaYat8o5vkJXDiBrSC6Ol6PPrr0=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by AS8PR03MB7415.eurprd03.prod.outlook.com (2603:10a6:20b:2ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 4 Sep
 2024 15:41:11 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::6ac3:b09a:9885:d014%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:41:11 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
CC: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"nico@fluxnic.net" <nico@fluxnic.net>, "leitao@debian.org"
	<leitao@debian.org>, "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>, "thorsten.blum@toblux.com"
	<thorsten.blum@toblux.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net: smc91x: Make use of
 irq_get_trigger_type()
Thread-Topic: [PATCH net-next v2 3/3] net: smc91x: Make use of
 irq_get_trigger_type()
Thread-Index: AQHa/tyfN+3ITFHg6EqttKqL7Ujmx7JHxAKA
Date: Wed, 4 Sep 2024 15:41:11 +0000
Message-ID: <xjsyqdymlfr4za57qj4ju4gsuuulavpjheuauymynepzqld4nw@xeqt4ofptkp5>
References: <20240904151018.71967-1-vassilisamir@gmail.com>
 <20240904151018.71967-4-vassilisamir@gmail.com>
In-Reply-To: <20240904151018.71967-4-vassilisamir@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|AS8PR03MB7415:EE_
x-ms-office365-filtering-correlation-id: 3080f586-d201-4969-0d4b-08dcccf800db
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZnZnYmVmVWdGVkI0a1ZWWlZiT3kvZStsV3pxVWpQbGx5LzdTN0QzYkV2RVBM?=
 =?utf-8?B?SjFxTGJFUTI3T3Y5dS9GZXVQdzNmSWNmQ1plQnNmMGkwbi9HeWZ4dkh4VmFq?=
 =?utf-8?B?Wnh5aDFZb3NubDlqZW1CR2xMSDRKNG5qQWhFdHFieDhxTUxjeDBpSWRzVjMv?=
 =?utf-8?B?UWE5Nk92azBDcEg3cXhVaHpXeWF3U3FkZndvdmdQdHlnOGZOVFhxWlM0c1I2?=
 =?utf-8?B?WU5kMlhZT2FWUTNCMzF5SFVqTUNPMTZpUmc3NklXK3lDWFFidWp2OFZubmpP?=
 =?utf-8?B?dG1laTg0UTJmZmhiMXpFZnB0WmpFRW9CdEtVNm1pREhsVEJCYUNSOENaTmxy?=
 =?utf-8?B?aytCTDlHcXA5U282ZWtlaEowTVdEMnh4a210c0ZYdkVoS3hDdFRnZWhtdEFn?=
 =?utf-8?B?UGl5d1NPTythdTVEYitpNXV0RFFTdnpUZDJqSG5yaitnWGRhZGE1c2x2NUlH?=
 =?utf-8?B?cXU1bCtMMW9rREdrSm5KaVNUQURwMXN5NFlhV2kyZ3VQWDY0NGMvLzUvd3po?=
 =?utf-8?B?b1dYSGxYNElZWDI4R0t4NDhEaHBGbXBNTEUrYnRMbTMrV3hCN1Q1dlJGb3lU?=
 =?utf-8?B?OTNYc1JNc0FSbFdDT0ltbWw1N1V0Y1hmS0VKTjZ5VmEzNHo4VkJxT0d6YlhH?=
 =?utf-8?B?QVZvZjVoYmdSYlplSEE1RWpBRVN3Z0pFVGgweFVWc2JoTnk5UGJuRU01RDc0?=
 =?utf-8?B?YWdJbWxYa21DdE9Pd2NJem1EcWsxRHFyMFV3Zi95dG1OQWtWREJVV3JPWldV?=
 =?utf-8?B?L3kwTGlFZStCTTA4Q0ZDcDI3UFNYV1FnaGpSOStVaHlzTGlCdkFTdlh4V2pp?=
 =?utf-8?B?SnNpclQxUDFwL2JFa0IxVTJJdk1vbk1lWHVWNk9aZnFNTkdhQlhNalA2OFh0?=
 =?utf-8?B?RDFqS0R6eEhEWFU5eXA0MjYxOFBrL2lyOVBUdU9NMy9xWUdJTkM2VnM5TXY5?=
 =?utf-8?B?YmxCSHdYZERSSTY2bVRnQXVrSWpTQkpNSEx1NWw0ZFFDMGNCZDEySGVDRk9L?=
 =?utf-8?B?d0czbGhBRzJrOTZOa20rV0RBM0szek1xT3h5ZVY4VU5IbStOYmJNSVFqSmMw?=
 =?utf-8?B?ZW8wTmhlVUdhSFdVOTFJTEZKUVpXQ3VWYnRvc1J6RFFVQlowTWN5eVZOREZ2?=
 =?utf-8?B?ZWxCNm1ncU5IUVlKb1JvdUFXc2plbEpTMEJBNll4WjZzWVVNUE1Jb0d3MnB2?=
 =?utf-8?B?ZkRQemJSOUR3bG9HVG1LUmR0SWxYR09iRXRGZDF4NDZSM2NhRlhZTjVtOEJ0?=
 =?utf-8?B?eTRRVGZoaHFDOFNveE9JUjI3RFVUSFZlRXNIU283c2FpN2JDMmROMStRRVAy?=
 =?utf-8?B?TG1QaCtjZVhmVXVLYnNxd0xzUSt2UHRDZFc4YXVYclM2ZzUwbUwxSlZIRFFL?=
 =?utf-8?B?OGc4Mi91UDM3K2M4eGVrbWphTHRjbWJuYTBXN2Z4SGFBVUhZRmovY21Uejh6?=
 =?utf-8?B?RzRSdXRranFMMXpxSVMxeDg5RmpyWmNhczRabXJrZkxCNlRnY2R1WGdrSS91?=
 =?utf-8?B?ZytFM1FyZFovZE12NDg2Q2h0KzRjQzBEMklCSmNjbEZ4eEdNaG40MjZzV0Vm?=
 =?utf-8?B?YTIralJYYU5KVEliK1B0OWpXVy9PS1JsSGVVc3AvQllkSnVZV3ZLaVdSVURI?=
 =?utf-8?B?Qy9JUTNGY2IwZmIyd2pVbm43dVpkZlNCOWhPZk8xdWcxVjZYTUNvUGJpdjcr?=
 =?utf-8?B?cEVwM242bTVaZ24xM3c4VXA1RUZQdFAzK2dpZVVFREQ3cTNxQlBDY1VEbG94?=
 =?utf-8?B?ckZHeUdyN1VkMXNkSUZ5cUREQ1g2NkRjMzJkQVBsQjdDMTQ2ck5hNUlvQ0wy?=
 =?utf-8?B?WVVwRmpkbEFuQUhqblFmNWFhTGo1cnBXN0FrOGhEbEU4VVBnNk4rdlFFRmEv?=
 =?utf-8?B?cHNQalJrbEhtY2EwbW1ndEY0UnNVZ2JoTTRtZldtQkhpaFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Um0zVlZpejBXMXJLSW9VNlEvcVgyOERPWStSZGF6emVrWWdDb1lyL3daL3h2?=
 =?utf-8?B?WmpQZDlIbk5CLzRSRnAzalVnaTBMYTJBY0lhM3JaUXVnZm1hcFBuWEFGTlRU?=
 =?utf-8?B?V0g5Z21JWkE0dk1jZ2h5bCt5SWhMeEJZMWREN1FodzEyYTZZYVRMMk5sek1B?=
 =?utf-8?B?ZkNlVk9aV1VGbnZMOFFiTzBEYkd5WXRucHpKUzdnVVRXWWxhbTJIbFhYRVZZ?=
 =?utf-8?B?WWpMWWVGUk5JcUxEYmZwYWtOaFY2OUpKSWVQbnFDVkxDYUlYa1dQdnVIK25Y?=
 =?utf-8?B?Sm1nTERjaWpLMXlCOXl6VVdqZVhhNVdRUDJnK0JvQjloNkhUZjhzQmpnY0pC?=
 =?utf-8?B?ZVI0dDB6MW1kQyt1ZE1vWG1kY1dZN3JlUkJkNENtU0lqanVWTzZiYnVOU2p1?=
 =?utf-8?B?dnpORWR2dHRSUU9lUFVmUXJmUDFMd0k3eHUrMy9FRVZ2NENQNkE0TXdyb1ZZ?=
 =?utf-8?B?a0t2V0RmTWQrcVJIeWxITW1nNDR0STlHNVRJZDd0ZlVCcHB0OGZ6OHVEeU42?=
 =?utf-8?B?clRQWkxneEhGSy9DV0tJUFgya29MV1poYUVrVFNsSWVpWCswd3BUNTFLMUFt?=
 =?utf-8?B?Q1BHNlZyczdHY2RQdGYvVGRscEpYKzN3QWRSVWRGY2hoa0RhYVpVK1h3UG9L?=
 =?utf-8?B?TEZiTGZwdjZLd1FKbTA3ZGovbXdGc3pmdjhwb2RKRG9Vc1NuOFYvL1Z2UHFs?=
 =?utf-8?B?ZHNJZkc0T1YvMWJmbGJQM21DeU9NbGloUGw3QkV5Sm0yaHFkUXg1OEUwWlVj?=
 =?utf-8?B?L0g2S1pnL1NSRjEzbDZUaVVPcFB2VTZSY3ZyRVhlSFZaZVNaY0pweHVYNE91?=
 =?utf-8?B?eW85S3FVMG9GekNUN2hpRW9ucDEzY1lORUtwOGpMa3VPc2o3S1RQNVVmWWJY?=
 =?utf-8?B?dkVXbG9rQWc3NmFURGhZK0V2b0dGTUJVSDE4TXJ2aDNDK3ZvV05wWlFJaFR5?=
 =?utf-8?B?bVJTcXpXem9hdFpJbzMzRElDY2pOdmxKZ08zQTlaQmU2amNlU3ZpSmV5b05Q?=
 =?utf-8?B?NVJoZ2o2SFFxQVRsbnM5VkdEdHIrSlJKTndBWW1Zd01aa2ZqRkdQSGxlQitW?=
 =?utf-8?B?MUFVRFcycDRYUlJrRmFVSUhsTGxPN3lPUXJLRkxPWmR0MWhhZC9nbmg2SXZy?=
 =?utf-8?B?Ti9VekZGYm1EcGFOakZjUTBqUUdkV1UrZFhWa0N6RDNoZlh2QjgvSWtjM2p3?=
 =?utf-8?B?blc1OFVyS2dibi9NclNoZ0xuQ1lORzl1YjVvRHhxY1F5OHA5Qmo0cWFiK0o3?=
 =?utf-8?B?dlpEVzdnNWxpRHdjZFlacXh2SzFxM29nK0FlSVEyWTk4K296MThWWDhDRDZR?=
 =?utf-8?B?SXFrditob2xsZkFEa1JQbHh4UkFaaTNNTjZJbU56MWNtaWVaYnZaN1BONEY3?=
 =?utf-8?B?Qy96QlJma2JWeWxSUnF5bTB3Rkk0blBpSFVJeVVob3Yzakg1UEFZZ1dDZ01n?=
 =?utf-8?B?TjljSFdjemtHZTBNYlBqeGhWMkp2OHhZN0FGWjFEVGh1WkI4aXE0M1hoUWd5?=
 =?utf-8?B?UjhJZ01ZUWpNY2VkVmsrNUtJcXFqSzI0Y1Jxc29pK3F1aUszUFZJR0llQUNt?=
 =?utf-8?B?TTNHc2dQUWFYK1NXQ3pSeldCVENQbXNBdFRJUndQMkF6RytTYjZHbVJRbDQy?=
 =?utf-8?B?alRiaVBWMHhJWmpMTTJnYkZHbHc2NzFqSzNKSWk5UzhHMkNxb0tGWmF2dEc3?=
 =?utf-8?B?QmRxTk5LbEtGYVhobzdqWEx1Y2FTWjFMcmw3eTlVVXVObHhyd2ZUSWtnYlpt?=
 =?utf-8?B?V20zRTVZOWFBUVBDS1ZsdXNrS096OFhsYWZEdkxzbUgwUXladE5hZDlRSjJP?=
 =?utf-8?B?TTlJcDhTazltdTEzYTlLWGhidWVrT2RtUFZEVk1DSHQwKzlPOFFOTGxaWGE2?=
 =?utf-8?B?MDByMWVJeXJTOExudnRqN01iT3VOcSs5UTVQUFQ5cGd0RDNIQW9Hdk91RGpm?=
 =?utf-8?B?aSt4bnNKNm55MGtQNlB4LzBFei9qRFdicG5qcDlhQ2VGTThIUllveWNsUVkv?=
 =?utf-8?B?aXRCa3UxbndZK0tHSzZDd09iZlRIYnoySi9ZaExRblN1bFhPbFd3ZGhpbC9W?=
 =?utf-8?B?cllOMzd6YnpHNEhZcVBybmovMVBDbWVHQ3gwd1h2bWlIeEJuL3gxOVA3cTl2?=
 =?utf-8?B?RzN3QkFpRnZEbURVaElTQXQ0NjlYVXhpeHVjS1RpbWZrZFR0UG5SZjJoQS8w?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D95149A5A1731B46913A64BAEDFE0152@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3080f586-d201-4969-0d4b-08dcccf800db
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 15:41:11.7636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICo9OIwiIhSdwEMWQNs2B6ECkKEd0nx2M+T5UuzsPtnH/eBM5y7D8+8cx4JNYhRX3zmF5eEjNHefdfMEsBfqRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7415

T24gV2VkLCBTZXAgMDQsIDIwMjQgYXQgMDU6MTA6MThQTSBHTVQsIFZhc2lsZWlvcyBBbW9pcmlk
aXMgd3JvdGU6DQo+IENvbnZlcnQgaXJxZF9nZXRfdHJpZ2dlcl90eXBlKGlycV9nZXRfaXJxX2Rh
dGEoaXJxKSkgY2FzZXMgdG8gdGhlIG1vcmUNCj4gc2ltcGxlIGlycV9nZXRfdHJpZ2dlcl90eXBl
KGlycSkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWYXNpbGVpb3MgQW1vaXJpZGlzIDx2YXNzaWxp
c2FtaXJAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Ntc2Mvc21j
OTF4LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCg0KUmV2aWV3ZWQtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1ZnNlbi5k
az4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3Ntc2Mvc21jOTF4
LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zbXNjL3NtYzkxeC5jDQo+IGluZGV4IDkwNzQ5ODg0
ODAyOC4uYTVlMjNlMmRhOTBmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9z
bXNjL3NtYzkxeC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3Ntc2Mvc21jOTF4LmMN
Cj4gQEAgLTIzNTUsNyArMjM1NSw3IEBAIHN0YXRpYyBpbnQgc21jX2Rydl9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCSAqIHRoZSByZXNvdXJjZSBzdXBwbGllcyBhIHRy
aWdnZXIsIG92ZXJyaWRlIHRoZSBpcnFmbGFncyB3aXRoDQo+ICAJICogdGhlIHRyaWdnZXIgZmxh
Z3MgZnJvbSB0aGUgcmVzb3VyY2UuDQo+ICAJICovDQo+IC0JaXJxX3Jlc2ZsYWdzID0gaXJxZF9n
ZXRfdHJpZ2dlcl90eXBlKGlycV9nZXRfaXJxX2RhdGEobmRldi0+aXJxKSk7DQo+ICsJaXJxX3Jl
c2ZsYWdzID0gaXJxX2dldF90cmlnZ2VyX3R5cGUobmRldi0+aXJxKTsNCj4gIAlpZiAoaXJxX2Zs
YWdzID09IC0xIHx8IGlycV9yZXNmbGFncyAmIElSUUZfVFJJR0dFUl9NQVNLKQ0KPiAgCQlpcnFf
ZmxhZ3MgPSBpcnFfcmVzZmxhZ3MgJiBJUlFGX1RSSUdHRVJfTUFTSzsNCj4gIA0KPiAtLSANCj4g
Mi4yNS4xDQo+

