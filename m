Return-Path: <netdev+bounces-175280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911EDA64CC3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8579C188FFCB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6023815B;
	Mon, 17 Mar 2025 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="GdAa6YsS"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2128.outbound.protection.outlook.com [40.107.215.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0130E199E8D;
	Mon, 17 Mar 2025 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211193; cv=fail; b=lVwpV1aB2F9yzZcx2giANELrTMYAY1U9QYMQC3xGYznLtumaDFbuq8anHrQAy+41a3cETPCR1VVKYTj0Z/Rkoq8IP0KfssbKOkyGz+acVPr5WE11onq3ts5mkeDCuKepfKFxppnFt5Dq/YLBJkF13xU1Pu3Z4ZlKeWvzrtUrEQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211193; c=relaxed/simple;
	bh=Jdp6yb354+qXMVjNsRf8W695ppipsCTvSlOsdJf383U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BSSDDneXV8f3wHXsuRUTAvuFmOLxa5rR1lkVhd/Ykd+L089tKsCXVc6iALlw0S7wjCoq4EyYK2YwpL/rsxyiI3+JdZ0F9Z2+fQ1lfHBJs4SuEazGs9Z1sqbWa9oQUYPAfMmuGTdp6i5Gl2ESn3E9xqFGcfvkJvccDG9zY+6HaU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=GdAa6YsS; arc=fail smtp.client-ip=40.107.215.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv2jc3MyX9p9ddAGzmyLkI4NJN8rEnguKENrf35RZGhS6u2BUc2t1kDre1kM/9KxQ18zlO6Ye/FWKXV8kSR5S+sP3Jlhb7lHHSWURs+blOHsj3NiJahgN7RTFL8q2gFSH5WHHRPu+xmdrbErhji+aV+zELRCx2Q/bCWZd9ad+zh3dHauNl9WZZRI48PbdJ/WozHwkNlnPx3vj2lNtebfxagUF/zD/uY+n6Bj6N/NMC775J38Xzb3wBl6q4+kmUYFJLRMnhob2FSsIQkAy6mQREnmNFe54yUv8RJ3cLJnCTHKVhEznShTzvHq4q6NT9uWBiOsuyThmZpwpVXBz61inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jdp6yb354+qXMVjNsRf8W695ppipsCTvSlOsdJf383U=;
 b=Ee4EbqFpyTCAD3fqS2Uqq4K7AkagCjFfd6zxdJS7imEA+AgM5cOEvAZJ1+PlrHCUEDWTBLUEsLBl46u8SjqMhg3me2Wz9nSkmFufFKQ9GACLnONTmInwyrPbP2Fz73Cpo/GeZusDgopoV0jgZj3mdNnEkSPp7/e3tbi1lr9NSZPCPAK0XPPDVEvC8RaX3+92dhdzw9oqBMKZqe6pd575SQV2SegM+ViYo2Cbvj/2l45gXqd17vOD9VIOFoZ4gUMSwbuF0JvfNzOZeQ5t2VRVM4xFWzHui+Go98SKWmVAb/C+bKwRTfWXivHHeavr8RcfE1yCC5vPpOSyh1y4zq8zaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdp6yb354+qXMVjNsRf8W695ppipsCTvSlOsdJf383U=;
 b=GdAa6YsSDotjUm0ZLIbbk79biSRnHTvrPzoRcNb8JpAt/6LrjPj2DJ+O0OpZ9zqcUaL3NpTJdU62ABIhLurmPy/hkX1yvVvfKMzE4cPTSDbaDyjb/rWWmYrB1aqy3PaU6NeibaslwTBAzE1wk8k4qQv33RyEscU8MJNqLI+D0RiV1xumwinoju7vmE6t8KakhLdVDKWom8WBiYHdSsa5zwplP1aRZtKoo0/mB2F4jyBDCZv4j7LCqqbfLhtCLtLqrvFCjUBQ3QKh8BcViYmh4CmCXMNZCb4+WOvEjn2mKbZB+FLjdc+MSI448KitJZ+E4FCAgQWFCuhW16YYIA+neA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB5663.apcprd06.prod.outlook.com (2603:1096:400:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 11:33:02 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8511.028; Mon, 17 Mar 2025
 11:33:01 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Russell King <linux@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "ratbert@faraday-tech.com"
	<ratbert@faraday-tech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject:
 =?big5?B?pl7C0DogW25ldC1uZXh0IDQvNF0gbmV0OiBmdGdtYWMxMDA6IGFkZCBSR01JSSBk?=
 =?big5?Q?elay_for_AST2600?=
Thread-Topic: [net-next 4/4] net: ftgmac100: add RGMII delay for AST2600
Thread-Index: AQHbluibt/La9I2bwU+d8Trs1O9LmLN3Bk6AgAAl6QCAAAE58A==
Date: Mon, 17 Mar 2025 11:33:01 +0000
Message-ID:
 <SEYPR06MB51347CD1AB5940641A77427D9DDF2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <20250317095229.6f8754dd@fedora.home>
 <Z9gC2vz2w5dfZsum@shell.armlinux.org.uk>
In-Reply-To: <Z9gC2vz2w5dfZsum@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB5663:EE_
x-ms-office365-filtering-correlation-id: 9e1a8aa0-e50e-444a-081f-08dd654779dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?M2dOOXNMTFI0ZFV6VnlSdmRVMkQ1MlBZalFYZHNVdHlLUVFsRVF6dENKamVMTGdG?=
 =?big5?B?N1IyeWlKaVRyQjNEYmNyd0hacXVzS2VOaEU3VTlZTTdSZzFXdGlleTRzdEZNeHZJ?=
 =?big5?B?QUxEUGprbkpkY2RGZnlFSmFPL1J5ZWx0dVlSV2ZkSlBhMlBja1R0MkhzNTlDS3JP?=
 =?big5?B?RmdkRE05cXFydXg3RXc1bDJwc0xUZlQxVE0yS05YamZoZmNnYUpWUzc3VHEzTXhT?=
 =?big5?B?M0NFTC9lUXhlZkZ3SWlVZHhaYmM0RVA3b3VPWjFBbzlHN0RRTUQ2eDg3c252NUhP?=
 =?big5?B?bTZON1RxbVhOMW5aaWdWRS9vbWp5YkdtUjdaTVg2KzJMQ090YnZxcFhPQUhrbU13?=
 =?big5?B?WitnYzRNVEV3REVvNW9jd3IvSGhDZ1BEdVVDU2U2U2JMVUhXTndZelZsMG5vQ2du?=
 =?big5?B?ajk0dWpPdjJFbWtXT2xGandiQ1JpaFpGbXZGa3dLZUpMSHo4NXoxMmMxZUxHTXZr?=
 =?big5?B?dUtZWHZpd2d1YUcxQ0tiVXVjZGt3MmZiNlBPTUxnSUdjaHBreEg0aUNrM01RUUJJ?=
 =?big5?B?ZnRUZHoyem5tYkZEcmVMOHVQTlhuOS9LZW5YWlNsQnBqeUNSSXV2MEpJNktTYjFa?=
 =?big5?B?SWdKUGY2YWlHWmswbW1JL1NCaTlQYklqTkM4Zk5vTGc4S29MYzJvK21wRXgyM2xx?=
 =?big5?B?cWdWNDBuTDFrVFIzN2d3QXlxWDV6R013T1dhZHg1S21CL2JRMjltbVduTERMY0Rl?=
 =?big5?B?ZmtTMWF2eHFUaVRZSjdnQUZtQmtTVEdiVFRDNUc3dkgzS2F3NjA3ckZjdStBdGt3?=
 =?big5?B?RWp2SUFONXB2RmpqVUN1RlZ1K0NYYmdTWnJGOFhGWHJwWmZTbjBaMHFUNDNJSG5o?=
 =?big5?B?TVBKRVFpZUhDVXo5cEhiUmhjeitkZk0rMm03TEJ1OHJBVng1N3pzRW1rNFN4MFRk?=
 =?big5?B?VE1EWG44aHh1UWFoNU9sVXV6dlNOV0NmV3VwM1RLVVZUSzFnTGtmZ2ZlcDJBTWVi?=
 =?big5?B?Y3ZXYTM0RmNuWjNjTWtxVCtpZ2g1R21zVUlTR3g4UXlHQUJ2UHpwV0dKcHRQS2R5?=
 =?big5?B?YmVGKzlveTl1ZTBOa2pQSVR2czZPdjI5QmtqSU9VWFZuYVRkSFVxQ0FFUGdwanBX?=
 =?big5?B?V2NIdjN6NWdoYndjdkd2bDV3K0JVQ1ZRSHl4S3cwY3hZb0ZoZGJBREhmN2dDVnNa?=
 =?big5?B?Q1RMMHRGMVR5bm9tQVhiTzdYNW0wVExFcUNLbHJUODlvZk5aaDMvQjhvdzBLd0l6?=
 =?big5?B?ZzNkYTF0RlFOWk9CamlyNW1oakthQUFoZnJ2UGRRdXBHTk1uNjAwOUZ4ajFyQ2pw?=
 =?big5?B?MVdQc29rN2JxVzA0U3BMZWxEcEFVQ240Y2VLcE1TS0ZQZm1oVmd4SUxBMlV6OEhi?=
 =?big5?B?dVN4VTk4alh2NG85eXNaQ2gvclFMN3FPaDRrN2JpYm53OUd5OFpiQlk3MzJCZksx?=
 =?big5?B?amJwcTZrRlFqM0JSY1hZV3NFMTlVc0VqbUJoUTUrM2U0YkNZMVFUaE5MWEoyM1FJ?=
 =?big5?B?Y2hyWTgxNHZwc3lQeG80M201dW5PN1djZEZrcEZvd0hNN3ZuZzI2bXhoUWxXRTgy?=
 =?big5?B?cDNmQmhPU0lmeHd6QmViRitEdS9jVzVROTFsRktvNGM2VUxaUFNpZnd5d3hFL1cy?=
 =?big5?B?Q2dycXlJdU1uOG1CNFNXMEltZzFGbWlXL3dGK3VGVzZrb29BYmlxcGF6SGdrZ0t1?=
 =?big5?B?N1NVMWJGVHhRTmZLTy9VWll3ckdYd0Z1WW14YjZkYmJuM3ZOd1lLd1RUa0d6RWJR?=
 =?big5?B?aUtzcW9TbGVOYzFnM21qNTRYdUhmV04vd2xWNGRWb0lnVmJLYjIyblJPOTA1OGRI?=
 =?big5?B?Nlp6ZG91STN3T2g1Um5yNlhDWmdnQ0p1RXBoZGdJeTBHK2c0ekE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?dDBidWR1Ri85aDdTM2ZKRVlDMW5BTVMxYm5rMkJ3ckhSbFZiSkhWZ1NlQWRLSU90?=
 =?big5?B?L1ZkRERUZi9zTDlqbDlBclRhMG1hOWx6d2txL2w4alZTeXFCUXcrRUt5SWZoam1U?=
 =?big5?B?ZFgrZWVpMndobHpRdUdTVnZNSXF6MHdGdnRpTk82Wk81K0VNUDFxRmw1NGtVbzFF?=
 =?big5?B?U0ZtcXExa2ZIRzBsUllyRVNPaHFQcUwzeUEwTGFtQnNlWCtGTGRjdzNDNEhycVpG?=
 =?big5?B?TVpyNEdqc0N1OVZhZG1ZVFlvYjZGSXZFcWpyeGVqWjlQeEI3bWY4cUR2bjBkYkJF?=
 =?big5?B?NXB5eG0xc2NBZk83YXMwQlhXSUZLL3o3NTZsdFEyUk0rS050UVMwR1p6TVhoQ25Q?=
 =?big5?B?Zm1JWmlTVkREbkdPY2IxYU9wL0Q2aFk2bjUwZHdzYU45TzlCak0xNm93YThMVzJs?=
 =?big5?B?OURGT1VRRWVPb2FzVWFYSkw5SmR1VTNMbC9WVGFTdmhsbzZIUGFWanlCc0MrdGJq?=
 =?big5?B?WWFEMks1c0NsNDVaSG0yTTZoOEd3YnlocjdWekRxSEtwTmJiKytjYTRYcnoybUVq?=
 =?big5?B?M040UVlqTURXMUwvNEE4NUlGQ2lwZXN4UWxhYllzWFdBR3VWZDhJNHU3RjVKcHdM?=
 =?big5?B?cjY0azR6eW5sWDcrb1E1eEZ5aTVxMzJ6TVRaTHBUd0IwcitTdDMwZzRvUGQ1bW5R?=
 =?big5?B?Zktuc0F1MnE1NXU1aUE0c1hwOTJmSW1XczlVeWt5ejRaUFJwYkVUZXR6NGl1USty?=
 =?big5?B?a2ZwVDg3Y0JnT0xJRlRWb2RvZzVJeEZzUis1NEdDdW5Oc1R6MFFYZE03OFdQV1A1?=
 =?big5?B?QndSSWRtc0ZOdDd1MXl1UFRxLzgzLzFRS0U2SDBmZ1NpVjdidFpZQ3VWa1ZNTisy?=
 =?big5?B?UGlNcHVZdDJwQklxTnZGb1ViaGs5eW5McEJ3MXcvYndNTENhdi9SMm92cTk4OGl3?=
 =?big5?B?K1RTUEtPbzhMWDhRY3pDUWRJTmNzZ0pLajBpeDNSRnJYUlRNZUR6STlsMnF6SytM?=
 =?big5?B?SXFOTVhBZWQ3TjBlckNYcGtjVFhJWDVRcmdkNW9jV0t6TnlXbzN1YkU0MkdzZkdD?=
 =?big5?B?UENXYjZpUWNaNUlrcmhrRUFwLzBzYVVTaW0yaGk2a0wxbUdRK3EySnhwNG1zZFhl?=
 =?big5?B?bzB5RExwekJMSnhSak1RT2k2VDUzY3A3SVhja2Z1Nm1TUzZucWY5SlBJSlZPUTY5?=
 =?big5?B?NXlCa3YvVndXYnFTd04vM0ZkbnJyL2t6RjFORExVZ0ozUkhobXhjVWhyQ3RMMDBD?=
 =?big5?B?Q0tGcFVVaU45TlY5MFRoSDhEVTNCeGM5UlROOXBPYm5veFQzM1Q3cWRPRnhBc1Ax?=
 =?big5?B?dndtMnBRWkZhdmIxMDYwRVArTGtGZlVsamRabHBsZHl3K1RYcW5Pa2pOOXlFTGpq?=
 =?big5?B?RVdCcU8vMVljYnltR1cxNVdKaENueUJVK2VPVFhjMFo2ei90UHJJQjlhdkZWNTkw?=
 =?big5?B?NUg0ZVJ0Z0ZOanBkSnBENTc4Rk4vSmZ1SnhONnFIdE5HbktNcTRzUEFFOCt4TWtG?=
 =?big5?B?VmpkSDQ0NkhQd1Q3aDUyNytZVE1jT3M4L1VCdkdaT0EvaHlod1JBQUNEMTNRYnhD?=
 =?big5?B?V0xjUGk5RVVScDdJL3Exd2VWMTVma1UxRmJlSUF2NGRhdWZ6VVZlRVlYbTdlaHB0?=
 =?big5?B?anUya0JPbEpjMW1KZmVLaUl5Rjd0OHd3cnpKaERzdU8yOVYxUTl0UTVWbkdyN3Zi?=
 =?big5?B?ZGhvOEViZ3NWa05YWDJNQTc4NFlvMFlGOTQ0WGNGSkZqSkVWS0FSVmdzemdyWlFY?=
 =?big5?B?VlVaaFVaWkplczk5b21TSzA5UXBEWS9DeTMxMkRqeWJoWktnbnZibFRjQjBQV3c5?=
 =?big5?B?M3lWeTdXSGlQU3ZFWHhiWTd5Q3l3d0hyaHpjTlZtbTNVR09mdmxqaElpbmtCY25Z?=
 =?big5?B?OE11Yk9pQ0d0dkY0RzJOd25JVUF5ZWQ3a0lPUldvYlI5Y0NKTUdkcHZaSk13ZGUv?=
 =?big5?B?SXBZakdsVjJhakQ4bnVPV1l0YVFicExlMkJuSzhYM0h6dDNMYzlNczZFT2oyQUZX?=
 =?big5?B?QlJJOUMvamkybFlvNHp5K21razhDZDk0YUpzY05sY2tJY0lSSEZCT0FiWkZhWHNj?=
 =?big5?Q?Fkuqpt4fI1DvA1ml?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1a8aa0-e50e-444a-081f-08dd654779dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 11:33:01.7580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OohVmvbWh8NlRpaEBbjQmgCnvjtZWjf1oMCguxi2Sna6DD7sfu+JD6iDAeNrx2zKLfdvUMw4FJ1gcQb+GGvLeF9UeewadqOMkFhB8HEPY5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5663

PiA+IFNvIHRoaXMgZ29lcyBjb21wbGV0ZWx5IGFnYWluc3QgdGhlIG5hbWluZyBvZiB0aGUgcHJv
cGVydHkuIEl0IGhhcyB0aGUNCj4gPiAtcHMgc3VmZml4LCBzbyB5b3Ugd291bGQgZXhwZWN0IHRv
IGhhdmUgcGljb3NlY29uZHMgdmFsdWVzIHBhc3NlZCwgYW5kDQo+ID4gbm90IGFuIGFyYmlyYXR5
IGluZGV4Lg0KPiA+DQo+ID4gVGFrZSBhIGxvb2sgYXQgb3RoZXIgZHJpdmVycywgeW91IHNob3Vs
ZCBhY2NlcHQgcGljc2Vjb25kcyB2YWx1ZXMgZnJvbQ0KPiA+IHRoZXNlIHByb3BlcnRpZXMsIHRo
ZW4gY29tcHV0ZSB0aGUgcmVsZXZhbnQgaW5kZXggaW4gdGhlIGRyaXZlci4gVGhhdA0KPiA+IGlu
ZGV4IHNob3VsZCBiZSBzb21ldGhpbmcgaW50ZXJuYWwgdG8geW91ciBkcml2ZXIuDQo+ID4NCj4g
PiBBbiBleGFtcGxlIGhlcmUgOg0KPiA+DQo+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20v
bGludXgvdjYuMTQtcmM2L3NvdXJjZS9kcml2ZXJzL25ldC9ldGhlcm5ldA0KPiA+IC9taWNyb2No
aXAvc3Bhcng1L2xhbjk2OXgvbGFuOTY5eF9yZ21paS5jI0w1MQ0KPiANCj4gQW5vdGhlciBleGFt
cGxlIHdvdWxkIGJlIGRyaXZlcnMvbmV0L3BoeS9hZGluLmM6OmFkaW5fZ2V0X3JlZ192YWx1ZSgp
DQo+IGFuZCBhc3NvY2lhdGVkIGZ1bmN0aW9ucyAtIHRoZXNlIGxvb2t1cCBhIERUIHByb3BlcnR5
IGFuZCB0aGVuIGxvb2sgdGhhdCB1cCBpbg0KPiBhIHRhYmxlIHRvIGNvbnZlcnQgaXQgdG8gYSBy
ZWdpc3RlciB2YWx1ZS4NCj4gDQo+IEkgc3VzcGVjdCB0aGF0J3Mgc29tZXRoaW5nIHdoaWNoIGNv
dWxkIGJlY29tZSBnZW5lcmljLCBhcyBJIHN1c3BlY3QgbW9zdA0KPiBoYXJkd2FyZSBpc24ndCBn
b2luZyB0byBhY2NlcHQgYSBwaWNvc2Vjb25kIHZhbHVlLCBidXQgYmUgYSBjaG9pY2Ugb2YgTg0K
PiBkaWZmZXJlbnQgb3B0aW9ucy4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGluZm9ybWF0aW9uLg0K
VGhlIFJHTUlJIGRlbGF5IG9mIEFTVDI2MDAgaGFzIGEgbG90IG9mIHN0ZXBzIGNhbiBiZSBjb25m
aWd1cmVkLg0KQW5kIHRoZSBkZWxheSB2YWx1ZSBvZiBlYWNoIE1BQyBoYXMgZGlmZmVyZW50Lg0K
RWFjaCBNQUMgaGFzIDY0IHN0ZXBzIHRvIGNvbmZpZ3VyZSBSR01JSSBUWC9SWCBkZWxheS4NClRo
ZXJlZm9yZSwgSSB1c2UgdGhlc2UgcHJvcGVydGllcyBhcyBpbmRleCB0byBjb25maWd1cmUgdGhl
IHJlZ2lzdGVyIHRvIHJlZHVjZSANCmNvbXB1dGluZyBpbiBkcml2ZXIuDQpPciBJIGRvIG5vdCB1
c2UgdGhlIHByb3BlcnR5IHRoYXQgZGVmaW5lZCBpbiBldGhlcm5ldC1jb250cm9sbGVyLnlhbWws
IEkgDQpjcmVhdGUgdGhlIHByb3BlcnR5IHRoYXQgZGVmaW5lZCBieSBteXNlbGY/DQoNClRoYW5r
cywNCkphY2t5DQo=

