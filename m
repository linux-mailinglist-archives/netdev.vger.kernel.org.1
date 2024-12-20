Return-Path: <netdev+bounces-153605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD9D9F8D4A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EEB1883132
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E383C19ABDE;
	Fri, 20 Dec 2024 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SRLC7A3x"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9C7494
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679860; cv=fail; b=EVIaBUneDVHpmE0ppG1K1PpZPmbv5BoSiGRfv2AFlvK5lhnkuw6Kigslyg4FJmCCQhey1ddtMrh9JizaA/6YmNV3zrZsdkd8ShGxASq2kA/wjvV9/sHYS1zh4zom7asc+apVjH+cB4Fd9xmhhFChroUDMSt++pjs6xz8qD6It6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679860; c=relaxed/simple;
	bh=CRGqB0hrmVUOlFbycQKrqFBv9gJIyUC0kGBUk8wHG4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eR+Wt856A7jiL1sec7bxqpAEGGZnK+ZmdtA7LPTGGEZkVt4aR5psbfoNiBLLLXv+9EkSKlE/obnAc715K52MxYrRin60SUZmuDQUkJBgYG8JJQ3CRZtZTUxn0A57Rqo0VwgUPcdDo5CIqQFMwmteA0D9HCFUilXwmcsHKAr3AZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SRLC7A3x; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFvL+QHJkRewDFYHItWlVbJA1Np1t07mU7Wqia2VjpXRckV8WfZjD9EIjr+EcJ813gjj12cq1EzQhfnffegjlmoQihxxGLbB3PdJh8Z8tHFgI54HQ6MOtasDA0PSEimWMw0//9L916j/jtYptgaii9v+HH46Kh/hr2I9ASsfT6M2o3CDnWYDZ3okXcpF4inONnxwEhAsKX+xjvLSTBENKh5IQWl7pnvzB9RsRAME0KFqkP/MNeajwyNQxlKnhkRU+3133wrcpTjlIe3SCYDJFrfrf8mNX6apqzTifRopAktTQ0Z7a9S+xggPESAtd785GHR9r/ABLBgo+EEFm5ocHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRGqB0hrmVUOlFbycQKrqFBv9gJIyUC0kGBUk8wHG4Q=;
 b=xBzQA8CVsDLL829f28X6dsI/5bJg5kZHbvPT14fZgYE8dV2gcEzpXMLG8/Tu/JQnW9UtGqaZ2zHOCLjbJM8KGf8CRBQuhTgYIr4LiJUfM+KTcs/JwKalVuvIpji2LqK/VcjeYw/pP/PH+jX3UyTLQ/y5Rcbh1wADtrydvGG3EKFTtJDN0bMzq2obkY1j7cVG7mcmKrju2alX8otHYpQI96NyZ+E1ZJo42u10794cCMcLsX6RmSPfZ7R/FcJ0qHQG6RJbQ7IZcnddaogdde7LpbhSUZtUSFt/LzBwG3unXZe0a5vxhaZSjU3nUa8kx7gDYp4z3b7n2pY8gPHvEztG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRGqB0hrmVUOlFbycQKrqFBv9gJIyUC0kGBUk8wHG4Q=;
 b=SRLC7A3xiN9+oSvinx2P3Kh84lZIQZKrYd4qQ3WXBMHO7cnQhH7h/7PohZp/q5ejtLhFm407IdHF5RSY8gRz5w81lAeVtW7tQRbhrOK7S4MQy+Fhp2E0OnKlGX7ifS4GG7F3uyhpYCpvWoyv58Y32yQKwadyBA0WWY/dtI3H82zWoilBx/rMzkeWYWycN2SBoVjmge9Zg2P3TNAV++DkckDbTYC7LzGz7QQO3QDo/u+0xvMYyO+/GO3o9PU/zCUETfxgknBKrJtG7TA5DZBjb8KMyMBG1qj/i+oJsXWo5n6gfp3mkdvV2qT4xtUlrZ8ZWRY3XL8QXgsgIwmud14AEw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB8166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.7; Fri, 20 Dec
 2024 07:30:54 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8293.000; Fri, 20 Dec 2024
 07:30:54 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs on
 user ports
Thread-Topic: [PATCH net-next] net: dsa: honor "max-speed" for implicit PHYs
 on user ports
Thread-Index: AQHbUjzGyeufL+QEMUu8gO9xw6AtrLLt12AAgAAR2ACAAAzggIAAw+sAgAADtoA=
Date: Fri, 20 Dec 2024 07:30:54 +0000
Message-ID: <ba41f79205ff4c0c90de71a6be2dd4e2e9ade0f7.camel@siemens.com>
References: <20241219173805.503900-1-alexander.sverdlin@siemens.com>
	 <20241219174626.6ga354quln36v4de@skbuf>
	 <eb62f85a050e47c3d8d9114b33f94f97822df06b.camel@siemens.com>
	 <20241219193623.vanwiab3k7hz5tb5@skbuf>
	 <b708216ed804755678f01f62b286928763a1f645.camel@siemens.com>
In-Reply-To: <b708216ed804755678f01f62b286928763a1f645.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB8166:EE_
x-ms-office365-filtering-correlation-id: 801c9d97-5817-4d3e-5f3d-08dd20c83cbf
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWlwT1J0OVM2MUNWV213aXNTTVJoeGJsQW0vdW42ZHEvUGRORmRoYytNL1Zz?=
 =?utf-8?B?UnFuY3pPNlFZYTk3bWZ6V09lN2JhMWg5VDFkZ0hQalBFVFZSWi9MTXhYZy8v?=
 =?utf-8?B?MnVKYW5xNHhudnd1K04xdGFsbEJBQXUyVEtEeStLVTJNbERPRktmVVRqb2hI?=
 =?utf-8?B?ZkVlNVpCT2FyWmplaTRBTmNFL1NhYWc4NngxN0pyUm9FR1IzZi9pMzNYWVJ3?=
 =?utf-8?B?ZUVWQXNEL1F0blZiVnFzT2QzcnBUUjNOZy9vNUVQVnd5Uk1KRWkzWi9mbGxj?=
 =?utf-8?B?WVZsdmxjTVNOdUdUWGVwd1hjU2tEdUpnemZUcUVYV2luUi96MkZ3b0VicDRm?=
 =?utf-8?B?T2Vja0ZHL1oyaEQ2YTVVU0xIN2dsVFJUYk9MVFR2UDdVNzE0a29kZkFROEVO?=
 =?utf-8?B?V0VjWTRlbC95VU5sYzJ4RzEzSFUzakxNbHhPS2w3OGVWZFd0SnNvM2JSeU5O?=
 =?utf-8?B?NkQrVUU5bjIzUGdxWHFxd3RHaEhEcGhPN08yU2UyRmN6bFpZWk9lUTN0Ymxm?=
 =?utf-8?B?Yys2eXgwSUhHNThWNTdwbUk2Uks5UHdtczA3Z2RpU2RodmY1c0pDR3o2L05z?=
 =?utf-8?B?WUorNU1jemhnTXkyeVhVWTIxSzF3c093TkFKQzZCOEdMRDIxcCtTU21PdEFT?=
 =?utf-8?B?b1UrNUxvQ2tVOCtrZFJ6VGhmY0RhM1p3eTFQNGJjNjJYWDlidGdINjRyK2tH?=
 =?utf-8?B?QkEyNkZzTitUK0x1MXUxdFRLRk9LNFFYL0srMzdQZ3czZWtTSkZUd3pxZlBp?=
 =?utf-8?B?YTA1TDAxcDFaK0c5ZEhZNmw2YjdiSmpFZGdZazJORVFuQVZkSDJla2VOdjQr?=
 =?utf-8?B?bGt5L3FmUTdPLy84QU01OTNQbWRpZ0lVczZKMG5ONkp1bkxkVXRIUlpuOTJ6?=
 =?utf-8?B?UEFPRnpKRmJJdU5GQ2NmVERWR0h6YU00eDUvY0psV1FMdWFFcytRVUV2emRo?=
 =?utf-8?B?aFRiWmU4TTlERE5KOC9aUEUzWE8wMVdyUjNBdVBQay9zWU1pV0V6a1dLYjFK?=
 =?utf-8?B?N0d0SVYzV1Q0dlpnRFh2K0dVMmEzVDJwTnduRlhNQWZyVGJDb3FNVVdJbEFk?=
 =?utf-8?B?TE9OUndhTlZUMk1JTExqOEZlcDNHdHZ2dU1QV2EvYXFxL2tZYVRzNkVUT1Nj?=
 =?utf-8?B?c0hpQm56cVRwaDlFSS8wa0tRQ3dnQzdIaWdFV2VkYzdJSk05TDc5NHlGeEd0?=
 =?utf-8?B?Rk5ETXdGd1NKcU1rcmoxZXdKM0tFKzBWd1cyWEIvbEJDbW9tNHNvUU5PeWpz?=
 =?utf-8?B?QytNTFRLNlRjWXNQdTNqU2lJU1ZKcWkzcXdMZ09nL2tSR0hIZjFCcjlhZUZh?=
 =?utf-8?B?Unc2aW83cCtvU0dlREdYVjBLNTVCTklReURhVkZLYlphM0V3dUczakFCM2dr?=
 =?utf-8?B?UkJ3YzRYakUrMTdHWVdtcWV4TDhoSncrcGozQXdUNGVHblBCaDBiQ1gyVzhS?=
 =?utf-8?B?OVoyV3NQdGJVN1owTENNaFU1bzllSWIwSkluRm1VVUc4MW9KMUJXVFcwWVpI?=
 =?utf-8?B?MVA3T2JkNXZFMm42MjF5c1dqbEUySEFNSUhpRUlSa0NHM0ZDR3pQRVJZaEJn?=
 =?utf-8?B?R1AvUXkxZEh1MUc4Tm52YXdkREdIdnZQZUIvVFhSL1NTem96YjlZYWFRUTdu?=
 =?utf-8?B?TXo5MmJmMDhvWXc1MHVKcVNyU1cwSUdEUG9NVThkOEptSjROQkNFcGxVbmVX?=
 =?utf-8?B?L3ZMV0REbG4zSGpQeWV2d3B1aCsydnRXcmNsLzQvZ29HeVZCc2kybDg5MWt1?=
 =?utf-8?B?S3ZDOS9aenI1WGtFVEVqbXUzYzFHSGFvZUVqcTBjOXJ5U05YMG0wc01FVW9j?=
 =?utf-8?B?TWNMWE9mSmV4UmlDT1ZzOGcyQXlacXlBdTVuWmVyQTBGSWtPYTRKOHp0blFC?=
 =?utf-8?B?STVBYTJLUGRxYi92M1RXYjQ5SzhlcWxTdTM4bHlxY3YvMWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0hnaEJIRm8wcmdaSjdPU1FjNDFncHVCZ0NoeG94aGVib2dzQUhXY1NrclNN?=
 =?utf-8?B?Q2wwRHJxWHhSVjVsUU9HejJUL2RCRFpWdXZ2a3BjbUxURkpOajkxNkdEVERQ?=
 =?utf-8?B?aE5sMlpqbWVMY1prTysrS1h0SnRnYlJtbU5PUmVtakNPZjBjZWZZemxhVjE3?=
 =?utf-8?B?OS9Da3dOL2lwRTV5d2ZSekZjRGhJUk91M0ErYit4dGwwN1h4UzR6TWZKNUhW?=
 =?utf-8?B?VGlDaDAvQ3kwQW5CNVRvai9weGM0dzdiYlQ1L0pjcEhlamZUT3paZ2VyTlow?=
 =?utf-8?B?WUZYQjZQU1dZVXNPQmgwcGZpLy8wT09zL1VuQmNzZUtNSlVyTWNwNHpJenNZ?=
 =?utf-8?B?Rjc0TUlzRlhGUW42Yzg1T0kwc25YWnFwSm90dUtVQWY2QncrbGtxTis5Ynhh?=
 =?utf-8?B?ZUlJdmVBajdmZXRMLzhlejl4Rmc3dklPWFFLaWp4QWlnQmJManV5Um80VlQ5?=
 =?utf-8?B?aDJ1b0VzYlRqRmxWdVZhWXNyTUFZcXoxMmtHbHQwWTgrWGxsUCtBMWJvVlF3?=
 =?utf-8?B?N1Z4clJhRE81NFZETzFPWFJtdldGczNHM2I0c3V2UWw4Vi9BeFREUGp1THdF?=
 =?utf-8?B?UHprRmp3MlNqZFFtQVRtVzBpUXhBcTJxUzdQd2p5cEFpRkZaQ0p2YnFzNUxN?=
 =?utf-8?B?bmJneU80VWRKTERLQ05IWXpBeUkvR3FlTGZJbSsxSDQ0bXNTc2JUQjdCKzU4?=
 =?utf-8?B?L3VVeTNPUUp0YSt1SWRUTytEYmlIem9XWjFac0NlemNkS2UvMVFhMDZXejhn?=
 =?utf-8?B?NXVTZjY1bXU5Q2NpNW1uMDJIZ0FxN0V4NXdNV3NabnV5c1dUQnZDemYyL3Vx?=
 =?utf-8?B?dlZsYk51TXdGdXlpUHZ1WXpnQU1jOFNSSkJxc3JVZmNNbDZva2kzTU4xczFz?=
 =?utf-8?B?Z3RKUk5nQTk0bXZ1T2h4eGxXN3R6Rld1b2VQYmMyS1NWeFlQY0ErV0MybDVw?=
 =?utf-8?B?M1NIV09jYjRKbGxXWlhUUFFkL3oyN24wdkxTbkUzdFRyKzhjRDRWbEdpVFJm?=
 =?utf-8?B?ekdjSGM5cUh4U3hwQS9FV2paUmVCbmRNb08ydU0yUjEvK2QyVHU4NkxQTzBN?=
 =?utf-8?B?ZllKOUsrTURRaHF0R3JTRmhzVG56MWZmUmRtK25aMmJrVzJ2Vk1YZlZ1Sy96?=
 =?utf-8?B?eFBRQWQyV1A1eW5XRCtkU1RJb0JMbXRFdm10bnlwU3ptZGNlQytoYTRxMFZl?=
 =?utf-8?B?RFRpSVgvdndVOTcranNiYUN2SjJUTFFUNDZteHlWNzBwQ2VXNDN1ais3Y3dr?=
 =?utf-8?B?U0JUOGZ5NnpUSDZMbTRhb1IxcGJrWFZWZWwxK1c4QWZoSHUyK1kzYUsrM0Uy?=
 =?utf-8?B?TEtDbWJ6Z0QxV2dwNEdCZDMwU0J6MnlxZzA3ZFp1bWE1dFkwb1NpYVFMVVU4?=
 =?utf-8?B?S1FraCtXM1dUT21aQ2lNNkQ1ZGNMd0VHbXRLSGZBUmFEMjE0S3NRRTRuUFRi?=
 =?utf-8?B?a0YrK2FrWTU0ZExraWdZUDlLQ2RDUUpJVVd5QWpKQ1JFKzliOW9FdFdJTkwx?=
 =?utf-8?B?Y1huUS9LWU12QW9Sa2RPT2M4WTg4U1ZzZTNGTmpEZGtRUzg0MWkwVTRjV1dj?=
 =?utf-8?B?MXN2N0lqNjY1MDg2MVVPVVNwQXRNWmlTcXJVZDR3MkMvN2R1d1lXV2ZXc24r?=
 =?utf-8?B?dEoxdmlHTmZPSmxrV1phbDNpUE5Ic0dFUWdVczFTRVhIWFBURU9XY3N0YmVi?=
 =?utf-8?B?WVRiU253TjZSbFJEM09SMmZUMDRzMG9aU0hWL2dFYkErRVlsRC96OWdpOWlI?=
 =?utf-8?B?MmlyNUVtd2dTV01rbHUwQktDUkpQR0J5eTh0bTd5OE1hLzVaV0VlNW1RWXNy?=
 =?utf-8?B?NXNoeFdYZFk3dDVXQm52dmpobkltaHhrUjJqcXZaQ1pVVDllTUZQV25oVnJs?=
 =?utf-8?B?Mkk2VGpSc3pMN3FTQzVHTmF0dnlMWlIrazRBL29DbXRBSDVMSG1QYlltTEJh?=
 =?utf-8?B?UmVDVjNqR0FpZnBDc0JHdGE1MXdoeVNlZVU4Y0E1Uks5Zk5kTmlFWTF1V0JI?=
 =?utf-8?B?UzRhZTdyT0JibEZ5MkNCdmw1SStGbjNZSVFna3dmbkdlUGhKaXY4cVoxVnZY?=
 =?utf-8?B?b3YvWUNwNWFVeEhwRkdXZXhaOEsrYVBQdkFRMGFqZlB3MTNPMDFuVDk1MHM0?=
 =?utf-8?B?Skw4ZjE1SFhaUXMxNDRrdEVaQTlIZENCQ2NReVZKM05BM21FYjEzQWl6TW15?=
 =?utf-8?Q?rVGlqy4iE/us1xKxWO0C38I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <535AAAE1B3C0864E9D5286F5DD5729C0@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 801c9d97-5817-4d3e-5f3d-08dd20c83cbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 07:30:54.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+5UMBneLRFiqDdh164Ywlfrl27e4sPG7cXLmHZ/0UrIWgC21J/kGJy6lRCe+2dwrZc5Ox8n+TfgSAbBF2ZJ5Pezyh9Ch2vkLnxhJOXti4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8166

SGkgVmxhZGltaXIhDQoNCk9uIEZyaSwgMjAyNC0xMi0yMCBhdCAwODoxNyArMDEwMCwgQWxleGFu
ZGVyIFN2ZXJkbGluIHdyb3RlOg0KPiA+IE9uIFRodSwgRGVjIDE5LCAyMDI0IGF0IDA2OjUwOjE4
UE0gKzAwMDAsIFN2ZXJkbGluLCBBbGV4YW5kZXIgd3JvdGU6DQo+ID4gPiBUaGVyZSBhcmUgc3Rp
bGwgc3dpdGNoIGRyaXZlcnMgaW4gdHJlZSwgd2hpY2ggb25seSBpbXBsZW1lbnQgLnBoeV9yZWFk
Ly5waHlfd3JpdGUNCj4gPiA+IGNhbGxiYWNrcyAod2hpY2ggbWVhbnMsIHRoZXkgcmVseSBvbiAu
dXNlcl9taWlfYnVzID8pLCBldmVuIGdpZ2FiaXQtY2FwYWJsZSwNCj4gPiA+IHN1Y2ggYXMgdnNj
NzN4eCwgcnRsODM2NW1iLCBydGw4MzY2cmIuLi4gQnV0IEknbSBhY3R1YWxseSBpbnRlcmVzdGVk
IGluIGFuDQo+ID4gPiBvdXQgb2YgdHJlZSBkcml2ZXIgZm9yIGEgbmV3IGdlbmVyYXRpb24gb2Yg
bGFudGlxX2dzdyBoYXJkd2FyZSwgdW5kZXINCj4gPiA+IE1heGxpbmVhciBicmFuY2gsIHdoaWNo
IGlzIHBsYW5uZWQgdG8gYmUgc3VibWl0dGVkIHVwc3RyZWFtIGF0IHNvbWUgcG9pbnQuDQo+ID4g
PiANCj4gPiA+IFRoZSByZWxldmFudCBxdWVzdGlvbiBpcyB0aGVuLCBpcyBpdCBhY2NlcHRhYmxl
IEFQSSAoLnBoeV9yZWFkLy5waHlfd3JpdGUpLA0KPiA+ID4gb3IgYW55IG5ldyBnaWdhYml0LWNh
cGFibGUgZHJpdmVyIG11c3QgdXNlIHNvbWUgZm9ybSBvZiBtZGlvYnVzX3JlZ2lzdGVyDQo+ID4g
PiB0byBwb3B1bGF0ZSB0aGUgTURJTyBidXMgZXhwbGljaXRseSBpdHNlbGY/DQo+ID4gDQo+ID4g
U2VlIHRoZSBkb2N1bWVudGF0aW9uIHBhdGNoZXMgd2hpY2ggSSBuZXZlciBtYW5hZ2VkIHRvIGZp
bmlzaCBmb3IgZ2VuZXJhbA0KPiA+IGZ1dHVyZSBkaXJlY3Rpb25zOg0KPiA+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYvcGF0Y2gvMjAyMzEyMDgxOTM1MTgu
MjAxODExNC00LXZsYWRpbWlyLm9sdGVhbkBueHAuY29tLw0KPiA+IA0KPiA+IE5vdCBleHBsaWNp
dGx5IGhhdmluZyBhIHBoeS1oYW5kbGUgc2hvdWxkIGJlIHNlZW4gYSBsZWdhY3kgZmVhdHVyZSwN
Cj4gPiB3aGljaCB3ZSBhcmUgZm9yY2VkIHRvIGtlZXAgZm9yIGNvbXBhdGliaWxpdHkgd2l0aCBl
eGlzdGluZyBkcml2ZXJzLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgcmVmZXJlbmNlcyENCj4gDQo+
IEkndmUgY29tcGxpdGVseSBtaXNzZWQgdGhlIHN0b3J5IG9mDQo+IGZlNzMyNGI5MzIyMiAoIm5l
dDogZHNhOiBPRi13YXJlIHNsYXZlX21paV9idXMiKQ0KPiB2cyBhZTk0ZGMyNWZkNzMNCj4gKCJu
ZXQ6IGRzYTogcmVtb3ZlIE9GLWJhc2VkIE1ESU8gYnVzIHJlZ2lzdHJhdGlvbiBmcm9tIERTQSBj
b3JlIikuDQo+IA0KPiBCdXQgSSdtIHN0aWxsIGhhdmluZyBoYXJkIHRpbWUgdG8gZ2V0IHRoZSBt
b3RpdmF0aW9uIGJlaGluZCByZW1vdmluZw0KPiAyIGZ1bmN0aW9uIGNhbGxzIGZyb20gdGhlIERT
QSBjb3JlIGFuZCBmb3JjaW5nIGFsbCBpbmRpdmlkdWFsIERTQSBkcml2ZXJzDQo+IHRvIGhhdmUg
dGhpcyB2ZXJ5IHNhbWUgYm9pbGVycGxhdGUuLi4NCj4gDQo+IEJ1dCB3ZWxsLCBpZiBhbGwgdGhl
IERTQSBtYWludGFpbmVycyBhcmUgc28gY29tbWl0dGVkIHRvIGl0LCB0aGlzIGFuc3dlcnMNCj4g
bXkgb3JpZ2luYWwgcXVlc3Rpb24uLi4gUGxlYXNlIGlnbm9yZSB0aGUgcGF0Y2ghDQoNCkhvd2V2
ZXIsIGFmdGVyIHJlYWRpbmcgdGhlIHdob2xlIHJlZmVyZW5jZWQgdGhyZWFkLCBJIHN0aWxsIGhh
dmUgYSBxdWVzdGlvbjoNCndpbGwgTUZEIGFwcHJvYWNoICh3aXRoIGJvdGggZHJpdmVycyBhbmQg
ZHQtYmluZGluZ3MpIHdpbGwgYmUgYSByZXF1aXJlbWVudA0KZm9yIGFueSBuZXcgZHJpdmVycyBv
ciBhIHNpbXBsZXIgYXBwcm9hY2ggd2l0aCAibWRpbyB7fSIgbm9kZSB1bmRlciB0aGUNCnN3aXRj
aCBub2RlIHdpbGwgc3RpbGwgYmUgYWNjZXB0YWJsZT8NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRs
aW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

