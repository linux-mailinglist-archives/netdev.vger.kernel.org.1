Return-Path: <netdev+bounces-175682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B69E5A671BD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1543A3A7201
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71AE2080EE;
	Tue, 18 Mar 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="hPB392nS"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEFEEAC6;
	Tue, 18 Mar 2025 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294828; cv=fail; b=eNDw+KYqgxslcLB+HZHGlhrSl5XjTCkAIMwy9DpmRc2DIhDHCuinRCL1o2useifTLk+IW3DmYEMfAZVcRf5J1msVElAuo9iXa/DRgn1zmt9XV1Kxw/tIUkMNwEPAsmsWBIAYggQ6s5MQQHxtfmgFUBEwXpqaQRnwxnqfQr6F10Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294828; c=relaxed/simple;
	bh=pOBuR7MShU5tG4G453TSgydWQRNgZ2itxcZ+w5vvjKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OiE72heqbAB0AluLRcG53I7FC7koVhMKP5XOz+OKaskEMxWY3kf/lKQyTZbhFFxmOM9xFg9xC3PpfkUhZIMLcjrnfz35EpC91HbWPXa3gdjfWhUOWClomf/87LJBt73vTGqpr/eeEhl0aetdSD3+IAIgvJKZ+cpd4hw7OsH6R28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=hPB392nS; arc=fail smtp.client-ip=40.107.255.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCVP4XsP74PkJc6sIDvkfCAAHgv0v3uR2Tnyumewr+/2suUrDW16KL3gBpGjFt4sZHb883R1jAkdg/cSBbA9zVL3MCebmarBCg0IOwTXvc+ba/NmfhXJMxbHS3fpgTakEZoPImrVcCdR1Y3jHZv4R4sIN+ifhRu6l/vmoyYXJcDiMV209CHPbewY1IXSI6OLQMdodO/UYLgPT9/LdjjoQ0ed96ZHLltS7VCf7ZOlY05jYIlXbBV3qc/bLxS+6KaAdd84s8wYZOLGiUP/A5Nb35uQ49YMHd7K8r1SmV1dLF+6kjrws1HFNL8itAvsZrcjsL0Ju8C4i6EmB02ocDYG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOBuR7MShU5tG4G453TSgydWQRNgZ2itxcZ+w5vvjKg=;
 b=VmdRY9YLf1bMzljx2bjU0wm5m4S/su+dvJtPv6MYx6xaDjXw8nZXCMtnUOcz2pehke/V5kM+RaT6467kPOeG95mBaw6zDKA2CSh+TC2FbrHZ0DPz/vcXtLudZd+xkMfnvwiuCnv3RHkZe+/0TEFaxJP5LhoZQg3GjeHQMRy4PCD9OD8lzeRV2bmW1kVPxV/lB6Eh5T7Txsl7vL3FnnlPzcWTO3Uh8o7D5dlFIXWz7oN+Ni+AzcwD0VomqhN0lbGO2WbiCwoJPfz/K241QUcETSEBPZnggtfUOPX7Zj/VjsmhGBDtvHVnABR6sd1JNw5KmG+YcNKlDeAEE4su0cD3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOBuR7MShU5tG4G453TSgydWQRNgZ2itxcZ+w5vvjKg=;
 b=hPB392nScPaJNmM7UN/AP7AUbBQCecqahOpn2ZFa0MGzUq3mNgIj+tFgA4x0kvlLuDUsRtGVHKLT9992DtLfgKpXtvpcmeEW89CnKCSodZfvixOAWUYa1ABiDM5zSDNj5jX6xSXgoj62+EUMV/GtieyHeL3F/xpMazmEHREoZlLlfzIbxMHfNgy+zqpFQu8PZZylvYkAcyLzkzHlxYp9TAeXdc8BtdURSCmtA709+Flh8qZjZhr7ai4NLka3TqUKZ59u1MXoz2nkLwSJU50Evy+BliEBP9iJA5SJ1M7GGjb+ohlsZJrsJ/oK9lxvgyLBxvEVQX0EzpxOFYF4zUmg+g==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB6983.apcprd06.prod.outlook.com (2603:1096:101:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 10:46:58 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8511.028; Tue, 18 Mar 2025
 10:46:58 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Thread-Index: AQHbluibt/La9I2bwU+d8Trs1O9LmLN3TEUAgAEU3YA=
Date: Tue, 18 Mar 2025 10:46:58 +0000
Message-ID:
 <SEYPR06MB513471FBFDEAFAA3308000699DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <dc7296b2-e7aa-4cc3-9aa7-44e97ec50fc3@lunn.ch>
In-Reply-To: <dc7296b2-e7aa-4cc3-9aa7-44e97ec50fc3@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB6983:EE_
x-ms-office365-filtering-correlation-id: 762c4705-e125-470f-6139-08dd660a3538
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?MkVCdnhaZ0ZOTmxrekNaSnZSN1lzK09ad2QvM0VBV3NrSVZxckZ3MHZQWFd5eHhK?=
 =?big5?B?Ylh2R2FUZldtSVU0QUxzVTRlNlRibWEzM1FQUkhRRER1VTZIZ1VyWjl6cnJaZUhr?=
 =?big5?B?ZUFXVnVmRDZSYS82VVpTZXhRRlBCSUZiNlNBQldqM0ZCSmFTOHlTU203UnpKS21C?=
 =?big5?B?dDl5bUg3ZWJ3VHg1OWdvN0oyalJ0TjNXOU5ZZVdleU5yVFd1akhod2QzbGg3Nk92?=
 =?big5?B?aXRpKzZXTlprUFBSY25meEVQb1dITFgyM0pYRnBSM1RNT2ZoT29EQkp1Vit2QnAx?=
 =?big5?B?ZWRNMUlXWWx5cndjc256RVp6RFE0ejFZVUNJcmFld2Qwd0Q2VHdKN0Vic1oxU1do?=
 =?big5?B?NXkyZG44YUpJcGFicm1nY05TejZwZGNIN3FUcEViUlZpZUFUZ1ZwNEhSNFJNVnFk?=
 =?big5?B?RzBSdFFkejFBTVZGNVVwS1RyTHZudk5wUi9xNGxZUGhLV2x0clVaWGxEcGVpZ2Ft?=
 =?big5?B?UXdrR1RVUlRnbDF0UnpmWjVMVk1IMkoweDNPL2ZmRURaVlRoVVpzVFJSL1RRUUY5?=
 =?big5?B?NWU5YWk5NnR4aFp0SDhSNExaUWdWOHZ0eEsvZHJyMldicG9JcDc3bmpyUnR2Wm1G?=
 =?big5?B?bGJuVXVLSm9mK2tCTmNmNXpyazk5STVhMGxOUy9VTmVsS2swRks4RU51SVJzVGQr?=
 =?big5?B?eU5sUElob2wzN1pBNHdGSXpydU01S2pWZ09XZlBoSll4N3JEVzh4ZlZGeFFMb3Yr?=
 =?big5?B?anVONUtsQ21PSEQ0Zmc3Z1J3M2FtWmhYYjJQcTN0MDNSQTF5ODRxUG9OS04ySG1s?=
 =?big5?B?eE95WERwVmJqSXAvWEpycXlZMW5CR1RLMFQ4VUYyRjlCUGRuMEtDYnlhU2hUd3pv?=
 =?big5?B?ZE1KL0U5RXpOR0RMS0Z5ODQxWXRoUENmYmh1dFBkV1VXTUFuOWs4TnpkejE2aW1r?=
 =?big5?B?SCswWEEwdlNybkxOcHVkcVJ0TzNkMVNnT0NKY3hEejJWL1drRGtHM09pZmVJUzFh?=
 =?big5?B?QmczeHFLcVFrU3MrOHpEQTRSRVFxcjRjRFE1SzBLQ2hPaW9xc3B0WTlsU244ZXpH?=
 =?big5?B?ajNObVA1QjVqc1dnazQ3RVFvUkc0UTIwa3hsMm82NWNqczRYTmtOMzVzQmN3Kytz?=
 =?big5?B?MDVGUm5qTjJVelZzUUFCL3dFNGJ5eVNFWDNZbjQ4UlF0KzVyZ014YVN3NTE5UW1u?=
 =?big5?B?ZGVrVmQ1aHhKWTliOWJPai9pd0NhNDlSSTB0cVVXTU51NU5YTlFkbTZEeC9PZTdm?=
 =?big5?B?ekhzVDFIQWIwS1doWldiL1RRd0tKQ3JsYlErM0lBWDVzNmNiZnhZU1hUclBpTERr?=
 =?big5?B?SnVLaHFzVDZRY1ZGejJ3ZTJvakdoQjJDTHpRTWsrVTBQR2Y2akxqeFVndzYvL3dM?=
 =?big5?B?OTlkT1lUWDRmTXdpQVFtUGhDNUhEVkxQVVhnUzU2ZEsvbGg5VTU2WnlXVnptZmh4?=
 =?big5?B?bG1odGk5T2FBM0ZaYSsvelBGZTFxdFJqd2hGTitNLzk3amFxelJvZ1lHNHZKeFZK?=
 =?big5?B?ZUl0NXBpTjJRNXVTYUU0ODkxMktxYk91U1NGclp0S1haRnQvR3Rqa3N0K0ZndW5U?=
 =?big5?B?MUMzRjIzSGtPMWtsQVN0Nlg0LzJsQnpnOUc3bmpRcExtMEdUbzUzK1dKWFZmZThE?=
 =?big5?B?UlVSKyt2SXpWWXV5VFRsMG0rM2hsU3ZGZ0hNRUdZOGJTbWF1bUp0SUZDejFrZU5w?=
 =?big5?B?Q0tibEpoTkVjelQzMEJnREMxaEhybm42SjVDL1B1VEdQNmpKZVJJeEphR0ZRRFY2?=
 =?big5?B?cU9jNlpLbG13ZHU0c0QxdEpnWktXVEhXbkZrS2xyZ1dqQUdUTlNNSDVla2JwdHBX?=
 =?big5?B?WWtqRTVXNXplMGdBNUxPZFdmckpRTFdYd2FiMGJSUFIwZnZwdVpQNDVObG1KUnlm?=
 =?big5?Q?46bQgQUiZSkTWX9A9WrNIFjQ9NmyZ12t?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?K1hvdXRiZnJYVVlwVmgrZlVWZkU2MlVuZ1BsWXlkUmU1bGljc1hzTDMzKzVHSFFw?=
 =?big5?B?ZE91eVp6TWh6NGpwODB5T1h0VUwvWUNTN2E3SUh5S3Mrd0dyd3A2UCtaL1VqOExU?=
 =?big5?B?cFArYkVadUJkZDI2bk9lVGFuaS9zNmFGOHZZa3ZhWEcwVk1reGNLN09ZNmNjZHYy?=
 =?big5?B?UDlDNE9mT25ucSsya2IwTjB1SGVuMHcwMVZyQXltVFAxZnlLUU9vUmxic05EZGcz?=
 =?big5?B?RXhRU2k0OXFJbnRFODRZcmd6Mks0TThHalR1ZGJwUk5ydjlnNHc2NDE0eWVkTHRM?=
 =?big5?B?V1FyaDhGQytNcFgzcENjem9ia1ArNVMvV3plb3VMa0QyRk1iZ3lwZW9Vb2xPTnpJ?=
 =?big5?B?M3IxTmZuRnVUdy9kOWJaVStKa2hwMVZrY3M2R05GUlg3MTdQbTltRHlEYnpoMjUw?=
 =?big5?B?cXdiKyswcG0wR2JWY21FbmJzblV2UkVGR0lTdThXVjJ6TThSZUlWVDhwZG5rT2Ny?=
 =?big5?B?UDFKU0N3NktZSnFqWWRyWUF0a3NZMzBnSUFvczNja1krUEJSQXZLZFJMSXVJeTBR?=
 =?big5?B?YURCaktJVk5SS1RlWS9ZM2RnWU5QalBsdXRxRTZUOU91Q3p0K0FsWFFPcHlHWjdk?=
 =?big5?B?STZhUFlvVENleHNtSUx6Mk5MK0xiY2dpd0tLalNRNkQyeVpVd0hnM1ljeEQ5QWZZ?=
 =?big5?B?a012N0dBMGhoQTR2ZjFVWTJGbXdVRUo2N2ovRGxEZEY3K1h1dDh2aFBuRFFRVlNV?=
 =?big5?B?MnFISitSMW5OaFkzUzFTZmdvejdJMkNtUEI1bkNQZEVZcThUY3VGN0dTb2F0OThv?=
 =?big5?B?Y0ZqRXpzQllid0hOalNEb1VTamRjSnRGMGtCRDFZdkl2MEtOZ0llK0dYM0tNWk0z?=
 =?big5?B?VEtoZ2pxYm40dk9LRWhMMy9IWGFsaStHMU5VZFFnQms0dHdlcE54Rk85ZXB1d01M?=
 =?big5?B?TEJiVDV4UDJ6SDNJVTFJQnc2b1hWMDFlRndEMWlkQjN0bTBUZFdaQlVBbU5BNUtD?=
 =?big5?B?eFZVeTZjRGRwODBubDRPMmwyaW9NYnh4MlRXdTN4T3RpZVJYQ3FKbThhY0Q1Vzg4?=
 =?big5?B?ZEk3cVU3eFJnNXA5ampqcjNXWnZzM0RwRnYyYStkYTRYK20zNmFFOFNLTTdFUDVZ?=
 =?big5?B?VTBTNmVNTE93TUlxUFpUQ3h4aWRSTEZoekh3NEZGYzZ0UjVRclJSSTZPLzlYQWs0?=
 =?big5?B?UnFEdXFrMlVySmdIVzdhWkl6anJvMS9SVnBYcmNwYjF6Q214Y2lGSmNpTUFwUGFS?=
 =?big5?B?eHNyQ3VBeVp3RzVXWE9qS3Z1Yk10UzdvOEZ4UkJBOGhGcC9xc1QwTkxwb2d0SGQ1?=
 =?big5?B?NU5pVDUxeEhUbjF1Q2c2cDY1S2NRaFpwM1pNQWdPRFFTdVF1b2xpVm96SlFJMnRz?=
 =?big5?B?d2I4YUN1M2NkOWlVS2IvOXpWNC9DbCt1d0V4V0NqTWVJNGd3aE1SWkpIblo4WVp3?=
 =?big5?B?dE5acFU4V3pIYWFBWFdhYjhSdytWbXh3bnFPR3lZM2dDQ2hTQzc2bHVEc3BlRmFL?=
 =?big5?B?RmVRTjNUUUpNVlhZMUhOOHh1NVpOQzBtR0NJSStqM1d0SThwMmJSKzVmWlhmdCtB?=
 =?big5?B?UThZMnphYUlBUzdCMU94SU9iRm14L29xK2JmMmtVRGR5U25PODBKWThKZ21FU0d1?=
 =?big5?B?ejRxZWRyNDRZaXZZNHBmRzF5SEtKTm9lUWtrYndqbTM5OXZjWmJDMlJtWGRjVDRs?=
 =?big5?B?WjN3TzNJSk5sb0VOK0F5N1I0WmdDbWdsSWFYdlF0bUZKTGc2OHFrSEovcXRHRU1t?=
 =?big5?B?VWdXOUlrNHA0U0c1T2k2RTVmME1kTUZFak54V2RxN1N2cXh4Q09KajBaV1F6Z3pn?=
 =?big5?B?dmFwQVg1aGRTd3ltRkRwYnkzRWJ2QmR3TGF5N1BjbUhLNlU5K0hYL0wyZEpFL1g4?=
 =?big5?B?ZE9kN1JtWCtWMWVpdkMxOFcrNWtTd2grWTY5eGVLTkFRTzlMV0MxNnhIUUc1bGNN?=
 =?big5?B?NjN1ZVo1dTZRZERxS2NRVjN5K3hTQmw0VzVtcVJkekM1SG1YeU5IY3dGS1hRZUls?=
 =?big5?B?SHhRck8vc09WTVh4WWJTMzlzQmVqSXdmcWhnbnJreElVUEJjcFQrdnpINjNQYkZP?=
 =?big5?Q?IN6IcRXyVcdKIz5j?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 762c4705-e125-470f-6139-08dd660a3538
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 10:46:58.4828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ux0wpjayt74ZvTLlJF5BwIrknx1ixtEDwnsFB9hseFDsy2N0wZwxIMy5QlyNZok2r3/O0afzFiIu2eFRqm/yH4CMk0AZcNBlIWbf+3ZXjNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6983

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiArCXUzMiByZ21p
aV90eF9kZWxheSwgcmdtaWlfcnhfZGVsYXk7DQo+ID4gKwl1MzIgZGx5X3JlZywgdHhfZGx5X21h
c2ssIHJ4X2RseV9tYXNrOw0KPiA+ICsJaW50IHR4LCByeDsNCj4gPiArDQo+ID4gKwluZXRkZXYg
PSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiArCXByaXYgPSBuZXRkZXZfcHJpdihu
ZXRkZXYpOw0KPiA+ICsNCj4gPiArCXR4ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJ0eC1p
bnRlcm5hbC1kZWxheS1wcyIsICZyZ21paV90eF9kZWxheSk7DQo+ID4gKwlyeCA9IG9mX3Byb3Bl
cnR5X3JlYWRfdTMyKG5wLCAicngtaW50ZXJuYWwtZGVsYXktcHMiLA0KPiA+ICsmcmdtaWlfcnhf
ZGVsYXkpOw0KPiANCj4gPiArCWlmICghdHgpIHsNCj4gDQo+IFRoZSBkb2N1bWVudGF0aW9uIGZv
ciBvZl9wcm9wZXJ0eV9yZWFkX3UzMigpIHNheXM6DQo+IA0KPiAgKiBSZXR1cm46IDAgb24gc3Vj
Y2VzcywgLUVJTlZBTCBpZiB0aGUgcHJvcGVydHkgZG9lcyBub3QgZXhpc3QsDQo+ICAqIC1FTk9E
QVRBIGlmIHByb3BlcnR5IGRvZXMgbm90IGhhdmUgYSB2YWx1ZSwgYW5kIC1FT1ZFUkZMT1cgaWYg
dGhlDQo+ICAqIHByb3BlcnR5IGRhdGEgaXNuJ3QgbGFyZ2UgZW5vdWdoLg0KPiANCj4gWW91IG5l
ZWQgdG8gaGFuZGxlIEVJTlZBTCBkaWZmZXJlbnQgdG8gdGhlIG90aGVyIGVycm9ycywgd2hpY2gg
YXJlIHJlYWwgZXJyb3JzDQo+IGFuZCBzaG91bGQgZmFpbCB0aGUgcHJvYmUuDQo+IA0KPiBUaGUg
Y29tbWl0IG1lc3NhZ2UsIGFuZCBwcm9iYWJseSB0aGUgYmluZGluZyBuZWVkcyB0byBkb2N1bWVu
dCB3aGF0DQo+IGhhcHBlbnMgd2hlbiB0aGUgcHJvcGVydGllcyBhcmUgbm90IGluIHRoZSBEVCBi
bG9iLiBUaGlzIG5lZWRzIHRvIGJlIHBhcnQgb2YNCj4gdGhlIGJpZ2dlciBwaWN0dXJlIG9mIGhv
dyB5b3UgYXJlIGdvaW5nIHRvIHNvcnQgb3V0IHRoZSBtZXNzIHdpdGggZXhpc3RpbmcgLmR0cw0K
PiBmaWxlcyBsaXN0aW5nICdyZ21paScgd2hlbiBpbiBmYWN0IHRoZXkgc2hvdWxkIGJlICdyZ21p
aS1pZCcuDQoNCldoeSBjYW4ndCB0aGUgTUFDIGFkZCBpbnRlcm5hbCBkZWxheSB0byBSR01JST8g
SXMgaXQgbmVjZXNzYXJ5IHRvIGFkZCBvbiBQSFkgc2lkZT8NCg0KPiANCj4gPiArCQkvKiBVc2Ug
dHgtaW50ZXJuYWwtZGVsYXktcHMgYXMgaW5kZXggdG8gY29uZmlndXJlIHR4IGRlbGF5DQo+ID4g
KwkJICogaW50byBzY3UgcmVnaXN0ZXIuDQo+ID4gKwkJICovDQo+ID4gKwkJaWYgKHJnbWlpX3R4
X2RlbGF5ID4gNjQpDQo+ID4gKwkJCWRldl93YXJuKCZwZGV2LT5kZXYsICJHZXQgaW52YWxpZCB0
eCBkZWxheSB2YWx1ZSIpOw0KPiANCj4gUmV0dXJuIEVJTlZBTCBhbmQgZmFpbCB0aGUgcHJvYmUu
DQoNCkFncmVlZC4NCkkganVzdCBzaG93IHdhcm5pbmcgaGVyZSwgYmVjYXVzZSBzb21ldGltZXMg
dGhlIFJHTUlJIGRlbGF5IHZhbHVlIHdpbGwgY29uZmlndXJlIGF0IGJvb3Rsb2FkZXIuDQpUaGVy
ZWZvcmUsIGl0IHNob3dzIG1lc3NhZ2UgYW5kIGlnbm9yZSB0aGUgZGVsYXkgdmFsdWUgd2hlbiBp
dCBnb3Qgd3JvbmcuDQoNCkkgd2lsbCBhZGQgY2hlY2sgZm9yIHRoaXMgaW4gbmV4dCB2ZXJzaW9u
Lg0KDQpUaGFua3MsDQpKYWNreQ0KDQo=

