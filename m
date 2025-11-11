Return-Path: <netdev+bounces-237667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0518FC4E742
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CAE18861E8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7340A2D9ECD;
	Tue, 11 Nov 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UmIkwmLR"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7B274FDC;
	Tue, 11 Nov 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870862; cv=fail; b=JG9FMgl1ES5IUyrT5XFOIfgEPMzDHqGJjLjnoaUHxZe3ZDKbWAgjp3aW2NBaTzRi8RofwLD3wHlcnLk+zPViZC8S3HgeNYCXK/7009al+a9tuLgwz+/faerNRaxNegSMPQf/870nrkwTS+GWmk51dP4YdlZYV2PldCOmw+Xmk7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870862; c=relaxed/simple;
	bh=yifF1CaqrFHYkl40djaHTM4gwNcktUKrlcjLwPnILKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XfyeljMJ+RInu+zj5zpUF0uzLFMvP7BrbJrZ8118KHR8LpOHnx1ZiEKq4+tEQdfAOTDEndW41+Eu2xRM/+XZFlwSKvpu/SMd2dVXkiVdBBQO4nZ3Q1KA+9F8B20/GimMvhg8YOdTYFbwqyCmV+ZyCzfgcPVlaluIsBHbPqBY/Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UmIkwmLR; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skTJHCj34BKnlFgjbbn1VBUwSiJc1IJE2Jg1XtxUkpXceW5GObZn9bJO4WT5fcXz8vG4fASaiZ/Ucq8kmKsCfW6bbf9VxaWTwlEo10UQIaYatr8HiFYipkuaUvo1xkRPaG1rh0nHAy/bgtlhc8sBE1bj3TgwGj01zaoY2XRvN1dqcWCy7R+70wz0DM7CmyHhhJf7C/YTBS6lmJ6XsB2Hk1+TUlSZV7gY1SIpGHcJw1cFybrVuWTL+hXj6hiPfScdLoSVE75fv7Sul+rKsvk3WqyFAhBcNvC0krKwid9uLOsMNI+Y/AdeqRvbzD1+DS0+JR+Z9YPHokxnJUMqiubrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yifF1CaqrFHYkl40djaHTM4gwNcktUKrlcjLwPnILKU=;
 b=N0Wl6Zhv7peaKlZ5ZnhseDX6g/k8WYayHFT05jrl1J8ei3BDxDvIBo55HaWpeoiEyCMJ5GEIaNYFWH6V2tnjgv4aLPLitOcfDRrJf2c9oo1TwxTQeLQs/izUFmmtI4AYUFKj4U5NzrMJZdHelyAmZJZpB7lAMERReMXV6nNzOO5CzeyojaQ8kl90qQfGdD18t4rMuLcbTPXvnEZ6PW+JmvJBTyHl4Uzqtyh4QxnVwLOcDEYSM9LzorzNZ/Y/NFgd12XnvJFKqENYMOOLSblh0D0xOExLiPqSB/s5B2J/zk8EjUFD/knmczVkCsQ6rM5hnMZB/Cm4uIHDOonhXT4rrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yifF1CaqrFHYkl40djaHTM4gwNcktUKrlcjLwPnILKU=;
 b=UmIkwmLREIkfx7elDbbMlt/91mrBofb1SmKxl4++QaPr4Xhfm4HZH2WBKHOwFGDDt3VzxPgBQKTpW/RG7gYEt0r9A/V/BT//E5Ite74/DQK8O/T12YqRddw2vGwXP+jucXZI9CxUm2egwjJkKYHhPODsBVGib1HPCV2MENspNWofGI1W5f1Zf/ps1iP5yaSuOesH1u+O9/kmdgCfYYVw672QQOQ1T5XO+xR0MNhFJLFj20foz3HI7hC2rcV0OlUHZe8oSAf0gE3rMS7eVLvPeDJyOoJ6+ett//eMqCfHj0PaQQNaHBHKCxzqqnlvN4vqdvULhComMVzEIN7y7bmg8Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11845.eurprd04.prod.outlook.com (2603:10a6:10:621::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 14:20:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 14:20:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Aziz Sellami <aziz.sellami@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Thread-Topic: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Thread-Index: AQHcThB8B/EmTKsCu0Wd8Fe2HUqMMrTs2uCAgAAVb+CAAI4ZgIAAAklw
Date: Tue, 11 Nov 2025 14:20:54 +0000
Message-ID:
 <PAXPR04MB85100E644E9508F3362B470488CFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251105043344.677592-1-wei.fang@nxp.com>
 <4ef9d041-2572-4a8d-9eb8-ddc2c05be102@lunn.ch>
 <PAXPR04MB85106ADEC082E1E8C36DA65188CFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <d43743aa-715d-43b3-b00d-96433a85f5fa@lunn.ch>
In-Reply-To: <d43743aa-715d-43b3-b00d-96433a85f5fa@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB11845:EE_
x-ms-office365-filtering-correlation-id: a71a6930-4bfe-421e-e2e9-08de212d86ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2N0azFLNEluVVlWWTgvVEtMMFl3ejdMY2ZHaDhtalluZm14V3dpTGg0eTRD?=
 =?utf-8?B?Wkc3aG04UjQ0WGN0WmRiU2xRT3E2OTdIVEk3NmhUWmdLbSsrM29ldHZ5WTJB?=
 =?utf-8?B?UmwyckJ2U1B6Q00xc3dJQkRKK0d6ZnJPRzM0bFViR0R1NXp1WnhPN1FTdDht?=
 =?utf-8?B?bStIQkZIRCtjNjJOd05EQlBSRUhWS3QvK2lzbW9LdUJySVNncVVWbjZBQTJS?=
 =?utf-8?B?a1NpbzYxVUZ6RkJSaTM2VXlnbm1OZDZQTjFoOVV6QVBFcHFEUldNZFpaVkpn?=
 =?utf-8?B?L2V1WXNZbmloYnZCd3Y1V1dLSUdZS0pLNE9ybWVZWjVsSE5oU3ZPcktNUVp6?=
 =?utf-8?B?WU0wekN5djd3UmFMNGVUQjBVYW5VaTV6bktXdXNxdjBoOUVNVW42TGdMczUw?=
 =?utf-8?B?U0dSZ1UxRktxenBaamlqRHJiSXJQT2ZCb0wvMmxEcGg5VHB3VTFFTE1iOG8x?=
 =?utf-8?B?TWhMRDRXMnRFaDYyRzRNRVo1MFlnNVFFV3A1MnRNWTRYdDZsWkowVEYxMzdJ?=
 =?utf-8?B?T1FQb0FYYXV4OExmMXlpblo5RDZ1dlY3VEcvK2kvNHozWlNPcXdtaUNCaWdD?=
 =?utf-8?B?eGpvemgzWlBkVlVnN1pTM1dkL3llSTJ6MHhDRnFjYzc1VzVaMjBtYW9zZkYx?=
 =?utf-8?B?L0xQZVRQMFVoUmdFbTdGd2FFajhtLyt3NSt0Y25NSThHWVhEWStWbFEyTnd4?=
 =?utf-8?B?Mk1oVDJpbzhNYlc1b1Nuczc1bmY1eEExMlVvRXdyMjFVSnNsZWNXbytONW9k?=
 =?utf-8?B?RXArQytMNzViUDc2SzNvVnlwd2FzbHp6RDY1eWtHa3FPZnpaTXdMUm5nekc4?=
 =?utf-8?B?MHFLdGlFbHJuM0VZTGtUaXNNMlJ1MjlNUUFweVJDRmpRMlYwOXlQcWxwYTRa?=
 =?utf-8?B?MWk3c0ZESk10eWJMSkFtSExJMklLSktXSmhCbmxtMHRkTExpRk5Ga0E5YkFv?=
 =?utf-8?B?bEJnZCs3KzFLTzhhYVpjdHpsSXVuMEhyaW9WZlhSQy9uR3ZyaWlpM0NrZHBq?=
 =?utf-8?B?YUszR2ZnOFBBNGN2M1hWa3RYdHROZTZqSW9LMjFxb3pxTXA3enIyYlk3b0pU?=
 =?utf-8?B?M0FnRC9SM202cktuNGVvMVprQlZCWDRIOWxNWThHdkRTbmhqNnp6eG1mL0o1?=
 =?utf-8?B?NGJEVFhHM1dldytFOGZKQytQZTFaemhyS2txRHphdU5zeEJUMkFhK29hNUhE?=
 =?utf-8?B?dTRiL1VYOVdkdWI3ZVB2U3dxWlllV2hkcmdMa0M2UXhZQWJEaEZMeFpvYktC?=
 =?utf-8?B?NTgrd1UzQTVDMkNKTlJrcFFJY1ROa3hvOE5SVWpjQUx1Z3Z1N050SnI1QWNt?=
 =?utf-8?B?QUEzWXR3OTAwWjhzd3F5M1UxWnNhdU5VSVFWaE5ta2ZITmo3am1hMmpEOWdC?=
 =?utf-8?B?N1pBUHV6T3JrZTY5ckt2OUZkUHdJWnRuekFhc00zZ2FQOGsra0x0aXE3aEo2?=
 =?utf-8?B?RXJxS1Zpc2s1bHZwbWN5VmprRVNUUFB2ZWxsMXNWUW1zZlBTb09DSHJpMzJk?=
 =?utf-8?B?ZmJEVEpRamZFS2l1SDBGSzF6NXl5U21TSjhzeC8wSGpaSUVNcXFvK3ppQ0VH?=
 =?utf-8?B?QTJ3SEFONm1zZ052WCtjVlIxYmR0NG9qdDRSVklaUXJ2dTRnbjRJODcrSklT?=
 =?utf-8?B?VGZWYlk4THRLS29DTEpBVi9qNFRiOFR6Z0tSekdNVG1WeDZURmxxZmVSTTFn?=
 =?utf-8?B?bHZnc3BTaUdTZWJLcU44WlZTQldUQXpYYnNHald4RlJzdkNMZXU2aXd2L2Nv?=
 =?utf-8?B?TTNFbkxMQ05zNWh6N0greGQ0YkZmNFd4MkdTaHlZa0hpMWxhZzdaM21HWm1m?=
 =?utf-8?B?Q0k5bkNrNmorU0pOa25EMS94dURmbnJUaXI4S0tjdzRPWXV3bVZWS1pJcVEz?=
 =?utf-8?B?NzRQS091aXprSStlaU91YjF0YWx4OXlkNzhncm9MdVpIVnd4VHZiay9UT1FC?=
 =?utf-8?B?bEozaG1iUTlHMFhOYkxaaFdOV3BNdHN1eDBrd1pHK2R2YmlqY2FTS2s0RUpu?=
 =?utf-8?B?ajQzOU0wWUVNZWo1RDNGY05oZlU0YXRVbVBVc2M4UmJoTnhaZW9VTHZaM1Ri?=
 =?utf-8?Q?CTgBFe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vml4MDZaakdjNS9idmZ0aEpyMzduWnhSTEtOTTBzYkIvL0daa0tPZzNNOTlR?=
 =?utf-8?B?dkdOMVczOVdJTVlvNGViVklDTzRIUlRMWUlPWk9PRnErZ2NJWUVDdCtNWTc2?=
 =?utf-8?B?Zys0NE5Lb253OGNEN3c3UTB4azVXY092Q0FrK09pN1p2T3RKa212bUdhQkZU?=
 =?utf-8?B?MzluNGVMSENuL28vUGxPUXRKc3Q3b0pISk5KMm82bzQxdVhSSjRLVkx5Y1BC?=
 =?utf-8?B?RWFmSGcyTlhVTFk4WC9UdHJ5dzhidEswcXV4UlJpR1RSdnVhSldXejV6ZEE2?=
 =?utf-8?B?YjgxVjFxWXlRcVNqTEtwL0U2elN6TFhZWXFCcWVKRnhxS3JRb2JZZlVscmE5?=
 =?utf-8?B?Tk9mb1JybnVCTjg5YVBjQ2NzM1ZQZW9lZjBNRnI2ZytiVWRyWGxYdUsvQ0c4?=
 =?utf-8?B?MjNRbTlpNURKZ1V6TzFoNDBMRG1rRTBva3YzNTdCamVjeFRmOHhIK2dPM0lD?=
 =?utf-8?B?c2ppdzNSSmlGMkpTNUhYUDkxNVhwcjY1aHVMSDVaODdZMzdvQ0tLU3JDeGVm?=
 =?utf-8?B?WlN4eVZjemtQRFZGUExVUnV6R2RBeUpEVlhXMjNTWmpwWHM4UlR3aHZmLzAx?=
 =?utf-8?B?Ti82VG5EOTBzRjBkSlh5WHcvSUhxTWtwN3hJZDVTZXh6cmhvTlF4MW5xMy9J?=
 =?utf-8?B?QjFZUmlkV2Q2YURhOHVwQ0hoaEpyWGN2QmdKRjhLc1pGUWtrT012bmg4UXdq?=
 =?utf-8?B?MHdwYW1zd3ZQR3JscjNKdHVIREpObDFFS090WWxzbVJjMEhBdStVc3NvdWpV?=
 =?utf-8?B?TlJpc1dOYVB4cVhwZ1BxVTRvMnp0UXhZLzUvblptZmRkRVVPSUpXMFVzaDZU?=
 =?utf-8?B?WXB5alhoVWNXTGcrdlp1SUlWaXk2U2dCOEd4WDBybHJkVXRUaDNKUkJLZFpY?=
 =?utf-8?B?c1FHN3BMZVFxaVlLcjlHYW9KR3hUWTA2bGxvbERxb21PN21qSHlBY2g4UVRn?=
 =?utf-8?B?NXRpcU5zalVoSk1jWVNmNDZDZEJKSUxvUmNWWFFJNDBjS05YMWNCUlVobVNO?=
 =?utf-8?B?MkJPZEFqaTVmVVFySTRxclZvMDRpVVF2REVZWXUvOGJ1dmJOUURweFQyallP?=
 =?utf-8?B?Z2VHY1dsQnNvTUttd3J6V250bklmQnhjbmd2UFdsWWVxNStweEcxaUhoY09X?=
 =?utf-8?B?c2lYc29UeTZMczJ2MEpiVGJjQnExdzRuYVVkWG5GTjFkM3B6TTE3YlJUOVF1?=
 =?utf-8?B?RlYrRGV5akljNVlFZ1Y0MEFjb2lhOGNoTVZqZG1LMExNenBGWnRjTGZ2cngx?=
 =?utf-8?B?Mlg3NExNbnltUVdXM25rL1VPbjU4d3JpbHF5cm1acUdOcVpWZHlhVktwQ2xC?=
 =?utf-8?B?VTFwUjhsUXlqdlBBM3l6Z0YxK2t6czFOTUxRaHVhWTh3dUR1QlBIQzBRQlpJ?=
 =?utf-8?B?aFJOVE1tdzZVVERmaWZmd1hPaUt1MkZZU2lGRTI1dHBPT1UzL2lIeEdFTmZh?=
 =?utf-8?B?QTUyR3NMMHdicGlaYmI0MEpJTnIzRTNadVFNRzhOSWlGaG1qMkJBS01RYU9m?=
 =?utf-8?B?MzdIR244ckx4ZUdMblRCNVpBRFZkTTN2Q21pbjE2ZWpiSE1PUTZVemd1NXlx?=
 =?utf-8?B?VjFxT1huenpidTQ0eXcxRE1GSVhWYzJsa0R0alpiU09td3ZUMnpQT1NQNFhl?=
 =?utf-8?B?a3REUGwzVHNZaXJ3cXNnMDVEZW9tcW5UeHNWcThDVWNoZjd1SlhWSnkydWdj?=
 =?utf-8?B?ejVEODNROERPZVBveE9OYnFIZmVQaWJreTZGaFdkT2VkMFRRcGhFcTFBSTJ3?=
 =?utf-8?B?dHFwYXhac0liZ2ExR2Z0QlJMOW9VWEdVc1FSSStvZTAybzJkanlHN3g1U3Bn?=
 =?utf-8?B?YlhzRitJOEtsQUd3SFRWUTlqZzNnWUJNUDk2MFpOdFcrR1BhRVFpQzJCcCtH?=
 =?utf-8?B?eDNsb00vZ3kwaWt0YUhXK21sM0VQMDFabU5JeWFTOHVTa2ptNGxHamxVY24w?=
 =?utf-8?B?R3VqaVp3RHZkMnhDWTVnN3BYM3hxU2ZiS3VPZHVSSUp2RllMc2JEZ3ArM0g4?=
 =?utf-8?B?YlZxaWZjalFncTRVK0hha2JCS25IUmVaZHRhY1poc2pJcjl0aTcxNjlXR3Vn?=
 =?utf-8?B?MXpHNTgxZkI0Q2p3WlgwazQ1ZUNjUlo2aEp4bzhMcUYzUVArTGNjdXgxVldI?=
 =?utf-8?Q?JIkw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a71a6930-4bfe-421e-e2e9-08de212d86ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 14:20:54.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgBh/wSQ5BWcIYdl7Fp6Fz61vrnnBTYWK5N7ATKkAaSP+9cDORr3mIlRDS9wHnZofX6rwjpoF0t/KxfHJN/Pqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11845

PiA+IFRoZXJlIGlzIGFuIEludGVncmF0ZWQgRW5kcG9pbnQgUmVnaXN0ZXIgQmxvY2sgKElFUkIp
IG1vZHVsZSBpbnNpZGUgdGhlDQo+ID4gTkVUQywgaXQgaXMgdXNlZCB0byBzZXQgc29tZSBwcmUt
aW5pdGlhbGl6YXRpb24gZm9yIEVORVRDLCBzd2l0Y2ggYW5kIG90aGVyDQo+ID4gZnVuY3Rpb25z
LiBBbmQgdGhpcyBtb2R1bGUgaXMgY29udHJvbGxlZCBieSB0aGUgaG9zdCBPUy4gSW4gSUVSQiwg
ZWFjaA0KPiA+IEVORVRDIGhhcyBhIGNvcnJlc3BvbmRpbmcgTGFCQ1IgcmVnaXN0ZXIsIHdoZXJl
DQo+ID4gTGFCQ1JbTURJT19QSFlBRF9QUlRBRF0gcmVwcmVzZW50cyB0aGUgYWRkcmVzcyBvZiB0
aGUgZXh0ZXJuYWwgUEhZDQo+ID4gb2YgdGhhdCBFTkVUQy4gSWYgdGhlIFBIWSBhZGRyZXNzIGFj
Y2Vzc2VkIGJ5IHRoZSBFTkVUQyB1c2luZyBwb3J0IE1ESU8NCj4gPiBkb2VzIG5vdCBtYXRjaCBM
YUJDUltNRElPX1BIWUFEX1BSVEFEXSwgdGhlIE1ESU8gYWNjZXNzIGlzIGludmFsaWQuDQo+ID4g
VGhlcmVmb3JlLCB0aGUgR3Vlc3QgT1MgY2Fubm90IGFjY2VzcyB0aGUgUEhZIG9mIG90aGVyIEVO
RVRDcyB1c2luZw0KPiA+IHBvcnQgTURJTy4NCj4gPg0KPiA+IFdoYXQgcGF0Y2ggMSBhbmQgcGF0
Y2ggMiBkbyBpcyBjb25maWd1cmUgTGFCQ1JbTURJT19QSFlBRF9QUlRBRF0gZm9yDQo+ID4gZWFj
aCBFTkVUQy4NCj4gDQo+IEFuZCB0aGlzIGlzIGRvbmUgYnkgdGhlIGhvc3QgT1MuIFRoZSBndWVz
dCBPUyBoYXMgbm8gYWNjZXNzIHRvIHRoaXMNCj4gcmVnaXN0ZXI/DQo+IA0KDQpZZXMsIHRoZSBJ
RVJCIGJsb2NrIGlzIG9ubHkgYXNzaWduZWQgdG8gdGhlIGhvc3QgT1MsIGd1ZXN0IE9TIGNhbm5v
dA0KYWNjZXNzIGl0LiBBbmQgSUVSQiByZWdpc3RlcnMgY2Fubm90IGJlIHNldCBhdCBydW4gdGlt
ZSwgYmVjYXVzZSB0aGUNCmJsb2NrIHdpbGwgYmUgbG9ja2VkIGFmdGVyIHRoZSBwcmUtaW5pdGlh
bGl6YXRpb24sIHVubG9jayBpdCB3aWxsIGNhdXNlDQp0aGUgZW50aXJlIE5FVEMgYmVpbmcgcmVz
ZXQuDQoNCj4gVGhlIGhvc3QgT1MgaXMgdXNpbmcgRFQsIGZvbGxvd2luZyB0aGUgcGhhbmRsZSBm
cm9tIHRoZSBNQUMgdG8gdGhlIFBIWQ0KPiB0byBmaW5kIHRoZSBhZGRyZXNzIG9mIHRoZSBQSFku
IFNvIGlzIHRoZSBNQUMgYW5kIFBIWSBhbHNvIHByb2JlZCBpbg0KPiB0aGUgaG9zdCBPUywgYmVj
YXVzZSBpdCBpcyBsaXN0ZWQgaW4gRFQ/IFdoZW4gdGhlIGd1ZXN0IE9TIGlzDQo+IHByb3Zpc2lv
bmVkLCBpcyB0aGUgaG9zdCBkcml2ZXIgb2YgdGhlIE1BQyBhbmQgUEhZIHVuYm91bmQ/IEEgRFQg
YmxvYg0KPiBmb3IgdGhlIGd1ZXN0IGlzIGNvbnN0cnVjdGVkIGZyb20gdGhlIGhvc3QgRFQgYmxv
YiwgdGFraW5nIG91dCBhbGwgdGhlDQo+IHBhcnRzIHRoZSBndWVzdCBpcyBub3QgYWxsb3dlZCB0
byBhY2Nlc3M/DQo+IA0KDQpGb3IgSGFycG9vbiAocnVubmluZyBSVE9TIG9uIGNvcnRleC1hIHVz
aW5nIGphaWxob3VzZSksIHdlIHVzZSBzcGVjaWZpYw0KZGV2aWNlIHRyZWVzIGZvciB0aGUgaG9z
dCBPUyB3aGVyZSB3ZSBkaXNhYmxlIHRoZSBkZXZpY2VzIG93bmVkIGJ5IHRoZQ0KaW5tYXRlcywg
c28gaG9zdCBPUyBkb2VzIG5vdCBwcm9iZSB0aGUgRU5FVEMgYW5kIHRoZSBQSFkgZHJpdmVyLiBU
aGUNCmlubWF0ZSB1c2VzIGEgc2VwYXJhdGUgRFRTLCB3aGljaCBjb250YWlucyBvbmx5IHRoZSBo
YXJkd2FyZSByZXNvdXJjZXMNCmFsbG9jYXRlZCB0byBpdC4NCg0KPiA+ID4gSSBhc3N1bWUgdGhl
cmUgaXMgYSBoeXBlcnZpc29yIGRvaW5nIHRoaXMgZW5mb3JjZW1lbnQ/IEJ1dCBpZiB0aGVyZSBp
cw0KPiA+ID4gYSBoeXBlcnZpc29yIGRvaW5nIHRoaXMgZW5mb3JjZW1lbnQsIHdoeSBkb2VzIHRo
ZSBFTkVUQyBwb3J0IE1ESU8gbmVlZA0KPiA+ID4gcHJvZ3JhbW1pbmc/IFRoZSBoeXBlcnZpc29y
IHdpbGwgYmxvY2sgaXQgZnJvbSBhY2Nlc3NpbmcgYW55dGhpbmcgaXQNCj4gPiA+IHNob3VsZCBu
b3QgYmUgYWJsZSB0byBhY2Nlc3MuIEEgbm9ybWFsIE1ESU8gYnVzIHNjYW4gd2lsbCBmaW5kIGp1
c3QNCj4gPiA+IHRoZSBkZXZpY2VzIGl0IGlzIGFsbG93ZWQgdG8gYWNjZXNzLg0KPiA+ID4NCj4g
PiA+IEkgYWxzbyB0aGluayB0aGUgYXJjaGl0ZWN0dXJlIGlzIHdyb25nLiBXaHkgaXMgdGhlIE1B
QyBkcml2ZXIgbWVzc2luZw0KPiA+ID4gYXJvdW5kIHdpdGggdGhlIEVORVRDIFBvcnQgTURJTyBo
YXJkd2FyZT8gSSBhc3N1bWUgdGhlIEVORVRDIHBvcnQNCj4gTURJTw0KPiA+DQo+ID4gVGhlIE1B
QyBkcml2ZXIgKGVuZXRjKSBvbmx5IHNpbXBseSBjaGFuZ2VzIHRoZSBiYXNlIGFkZHJlc3Mgb2Yg
aXRzIHBvcnQNCj4gPiBNRElPIHJlZ2lzdGVycywgc2VlIHBhdGNoIDM6DQo+ID4NCj4gPiBtZGlv
X3ByaXYtPm1kaW9fYmFzZSA9IEVORVRDNF9FTURJT19CQVNFOw0KPiANCj4gQW5kIGkgYXNzdW1l
IHRoZSBoeXBlcnZpc29yIGxpa2UgYmxvY2sgaXMgbGltaXRpbmcgdGhlIGd1ZXN0IHRvIG9ubHkN
Cj4gYWNjZXNzIHRoaXMgTURJTyBidXM/DQoNClllcywgdGhlIGd1ZXN0IGNhbiBvbmx5IHVzZSB0
aGlzIE1ESU8gYnVzIHRvIGFjY2VzcyB0aGUgZXh0ZXJuYWwgUEhZLg0KDQo+IEJ1dCB3aHkgZG8g
dGhpcyBoZXJlPyBUaGUgRFQgYmxvYiBwYXNzZWQgdG8gdGhlDQo+IGd1ZXN0IHNob3VsZCBoYXZl
IHRoZSBjb3JyZWN0IGJhc2UgYWRkcmVzcywgc28gd2hlbiBpdCBwcm9iZXMgdGhlIE1ESU8NCj4g
YnVzIGl0IHNob3VsZCBhbHJlYWR5IGhhdmUgdGhlIGNvcnJlY3QgYWRkcmVzcz8NCg0KVGhlc2Ug
cG9ydCBNRElPIHJlZ2lzdGVycyBhcmUgRU5FVEMncyBvd24gcmVnaXN0ZXJzIHVzZWQgZm9yIE1E
SU8NCmFjY2Vzcy4gU2VlIGVuZXRjX21kaW9fcmQoKSBhbmQgZW5ldGNfbWRpb193cigpIGluDQpk
cml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGNfbWRpby5jIGZvciBtb3Jl
IGRldGFpbHMuDQoNClRoZXkgYXJlIHVzZWQgdG8gc2V0IHRoZSBQSFkgYWRkcmVzcyB0aGF0IHRo
ZSBNRElPIGJ1cyBuZWVkcyB0bw0KYWNjZXNzLCB0aGUgTURJTyBmb3JtYXQgKEMyMiBvciBDNDUp
LCBhbmQgdGhlIFBIWSByZWdpc3RlciB2YWx1ZQ0K4oCL4oCLdGhhdCBuZWVkcyB0byBiZSBzZXQu
IFRoZXkganVzdCBsaWtlIHRoZSBGRUNfTUlJX0RBVEEgcmVnaXN0ZXIgaW4gdGhlDQpGRUMgZHJp
dmVyLiBUaGVyZSBpcyBubyBuZWVkIHRvIGFkZCBzdWNoIGEgYmFzZSBhZGRyZXNzIHRvIHRoZSBE
VC4NCg0KQlRXLCB0aGUgcG9ydCBNRElPIGJ1cyBoYXMgYWxyZWFkeSBiZWVuIHN1cHBvcnRlZCBp
biB0aGUgZW5ldGMNCmRyaXZlciBzaW5jZSBMUzEwMjhBLCB0aGUgZGlmZmVyZW5jZSBpcyB0aGF0
IHRoZSBiYXNlIGFkZHJlc3MgaXMNCmNoYW5nZWQgb24gRU5FVEMgdjQsIHNvIHdlIG5lZWQgdG8g
Y29ycmVjdCB0aGUgYmFzZSBhZGRyZXNzIGZvcg0KRU5FVEMgdjQuDQoNCg==

