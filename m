Return-Path: <netdev+bounces-173904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C15DA5C307
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5C77A809A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8EC1D5176;
	Tue, 11 Mar 2025 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eWgJwj+L"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818E1D5CC4;
	Tue, 11 Mar 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701197; cv=fail; b=PNkoY2KSx33oNOMRl4ynt4qK6defLOmejZG9kSXflaBlEJnKiKHtR1FIGeP95+HA4GuaeSYUt+29+cyLfaGdkIWIk6xcJU0s2+FCnEpbXVjO00GX8K9QFWjzWnd1/wblUgyQh36SOszYlUtoEW9+TJI1TAExtYDTd23ATVcA8mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701197; c=relaxed/simple;
	bh=Hxu11fO5IbbSu0ce7GWdTbGPvQraMwd9Q9QpQWTXlX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qdvkFzs5JBc+DTyAqyego7TfOfHSXQAGxdYnmgENg6hdaHEktQQk7tLrkVoXz4wvB7B55Z3mr2/+A3OLcxrAQ8xIaeBuCVBLVG6MvdDWD1uTOft501TachnryUXpyrHuNZzPB1hn48KpxnqG6Bt5TauwRe341UnuO2YXOhcw+Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eWgJwj+L; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+o9msu3sQbAv/tE0bTjJiXp9xh2g5LXJPlLMJbahC+z3S3lLdJe9LBFxCQIwSfVGTZfC/nY6dfJRX3zeCtkoqdt7GeDdKAkXuE4fZDqEGJSHSbDjThEJxY7ZbbG12YiSspCAggWqEWGbB5qz/MCZqiGx7EQyJ3Fx0tlbHQ/7Qd2OejVj5YHCgtt1IY+LhqiQSl7eCxHmdKCT4X/X6pzQwq/V6REcCP5A2YNGy7or4/CdXODmuGmEILbv2C3EXBzWHqrBwmeZqQOJ2uTJuUOCTHsK05veSGQb59kMivm8lqOtvRh0gGCJ8TQsiehNjZFYfkmQMuKQo9/rWc6mx5UWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hxu11fO5IbbSu0ce7GWdTbGPvQraMwd9Q9QpQWTXlX0=;
 b=GkiA6ZGlHafrKjWRUBj0cRH15HQwpWNhQSi1EckVioENIsTn6sdG/541akCDu978+ZiBX+5Hc3ye4H7LDV9hIFUaFkkn7ot/KpThTbc9amFpOtlVAK4HJ5D0dWOGbo2dqWM8TCD7NxDLHbWFZaua75D440GkUnWzYkJ2xPsDSbHoVG9eXfhsq9Q+Ag7Gu3QxSwGETZ2ciOZvc35CeKJ3rhazk5sZE0LH9Wj4N95Xkt2forbtvxmaRPzDibM04cq1jIXORXObXaEllP5SDkPLWLKSnMIr13Ya5c6X9DhXxwr+c6sL8HrDAFTXFQ8lpMIeTTQ9u1apo/UMuB7GUwa1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxu11fO5IbbSu0ce7GWdTbGPvQraMwd9Q9QpQWTXlX0=;
 b=eWgJwj+LU3fzfJkMVyekmbaEdByGE5jXVluXIf+1qoZ1FeJQImCLQLCHxSCz7PETLYeRWaNMaTQyYJ3cHzeHgG1ee0yQrkhZK4IfnDADXnIn6e5/O61yxELdiAEPKaYSTOPZsPtHm5lkGZZeHZd9iRamFsgU+TaLmR/x10DGrTEiZKRavrwthRjlwMSpmYRGhFFS7tbXMxtL49Tyji5FqzUixkdNE4N4sRmCrAANkjX9mGyWA8t21U09iPfu2kzXoiVix/cacz5/Z1cq90gQK9R06w7ievKjfRadntH2ZRKG8Q1JB6gR1SgqeqRF2xRrlX6DfQAP22nKlk+U/GDcYw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS1PR10MB5389.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 13:53:11 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 13:53:10 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, "jpanis@baylibre.com"
	<jpanis@baylibre.com>, "c-vankar@ti.com" <c-vankar@ti.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"rogerq@kernel.org" <rogerq@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "srk@ti.com"
	<srk@ti.com>
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw: Fix NAPI
 registration sequence
Thread-Topic: [PATCH net v2] net: ethernet: ti: am65-cpsw: Fix NAPI
 registration sequence
Thread-Index: AQHbkoW344hKP7+HDEmX75IUaoS7jLNt9MsA
Date: Tue, 11 Mar 2025 13:53:10 +0000
Message-ID: <02d685e2aa8721a119f528bde2f4ec9533101663.camel@siemens.com>
References: <20250311130103.68971-1-s-vadapalli@ti.com>
In-Reply-To: <20250311130103.68971-1-s-vadapalli@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS1PR10MB5389:EE_
x-ms-office365-filtering-correlation-id: 61af2d0e-adc1-496d-aa7b-08dd60a40f8b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWp2UmRvQWp4NG82VW5EcXhzclNkV3p5WFpYdVpUSjdzTVJmdFBHVFp2K0J2?=
 =?utf-8?B?aSsyVWRZUFZDdGE5YnVHZGttK29nY0x6eTVPcjhhYVBLdjRQWHYrek9pbG9J?=
 =?utf-8?B?MTdFV2NmY090Y0JTY3B3Tjl4TzZUWVRLalJ1b0J5YzdTYkNOcjhOQlY3WVpF?=
 =?utf-8?B?dkhLa3NTb3ZqdEVJcVRDbUpYaithRTdPZ3N3MFN4aFIzZG10a2J2eHRoaktL?=
 =?utf-8?B?RjV4eHBQa3ZYNC9JNHJFV01acWp5Y1dRcy8wV25CR0FNdTU2NGhrRTlTODln?=
 =?utf-8?B?Z1ZmVXg3OVZqb0FSSlhmSjhsWElUVnBweENYTGFRdUpFV1ptaytWTmpwZjVE?=
 =?utf-8?B?cW5KaEZ4a3c4YVdQMUowbDNFSk9XRVJjUG10Ykd4U3cxR08wV0toMlJ5YWRJ?=
 =?utf-8?B?b1dYNDc0K0hkbStFYU1ZblRjQ3JBOFNsbmZocXpHVHlNZVVZUGpKMGlZSU5v?=
 =?utf-8?B?TFB6V0tQSzNnZE5EZGdmdXY2S3lJY1VlM0tyRVNaV2dITXlGYmx5M09aUVRv?=
 =?utf-8?B?UVVkNzNGNENMVUlqandUYkJWemx6UUhJRDV4RnNhVk1OMmpyUWh1TWJRVjYw?=
 =?utf-8?B?ZjZ2YkVpa29BWWY2OW9Wd2ZTRUcwQ05uRCsva1pyU0tYTTBJd3FEejdNQU5r?=
 =?utf-8?B?SzEzdFNRNGRRVSsxUFdETmt1eDdFSE5qaVRzRk41OWRGd1dzTi85UTg0Lzht?=
 =?utf-8?B?STlVQk5aeUFGWWlrQzMwNEFyY2V5U2pDOHNBUktyZkltMjRVclVtN3JyRk93?=
 =?utf-8?B?TVRhRVB1dGtCTFByZnB0eVFxMnBGc1J3T1pTQ1p4MlRNMHI0WUtScE9TdWlp?=
 =?utf-8?B?NXVvNUZBZWNraVNuVHM1NE9ZSFFZeGY5QTh6SE1DNktxbllTcjRRSjdqUlpN?=
 =?utf-8?B?aktpTlpJc0xYMUJGcmZMQWN4bk1ZdERqTytjYUNyQzVyMEM5dFRwdXpWVS83?=
 =?utf-8?B?aStsTkYwT21yNktqL25pMWNrUldCSnJmUzhva1R5SUlXRVpobDBqb0lNRGds?=
 =?utf-8?B?L2FmeVRqQ1RHdENQcWp3MGZDWkJsSG1yODkvbnF5YU1paVBKVWN3azhOQzVB?=
 =?utf-8?B?eG9ZS3hrSVFyMWd4bTlvR3lYcXR0QllEdjNydmFETFQxTlc3ZzRiMGhxMWZI?=
 =?utf-8?B?WXNxNGd0bUh0akFYZ09QRlVyS3RsdmI0SDFtQ0FJZEdFL0hJbXJDSm1ueXNo?=
 =?utf-8?B?eURzMHdLOTIzc3UzNlBXdjBxbUFEYXhYN0Z0ZFl0eWtHRUptT21Bd2FHVGlO?=
 =?utf-8?B?UW5tbmxKZVYxNUlCckt1dHRpczZrSTZzTTVXcDQ4RTE5UkNCRmZMc1VNS0tI?=
 =?utf-8?B?ZEg0Rm8rMkZoRkdkMW9ONzQyZFNlUDNVMW9UV050b1psZFgwR2tFWUgzOVVY?=
 =?utf-8?B?ZzlxSzk0NHc4L1U4RU1xU2lrZ1dhOEpEcmJVdUdWUmp5YmVVQTVWWGFxd0Zo?=
 =?utf-8?B?ZG9xbzl0UzY4aklwU3V4ODNkbjJscWFSSE8zMVBEYS9XQXZNV1dWaUFxLzla?=
 =?utf-8?B?azltbGZxQWFFY2I5TlV2QUF5Y3NDTlBpRHN6Nzh0bDZtT1Fqc3ZtQmQxRjRo?=
 =?utf-8?B?Y1dWYjNuUStnS2VhSmsrelBHTGozbjRGSGluS3RzVXloZmRTdWV3T0RxKzhB?=
 =?utf-8?B?ZkJmR3h1c0dVeFY0anJzLzBBVVdMc3hPZFd5WGR4aDlEQWVETFNOVlA2bVRZ?=
 =?utf-8?B?U2xhR2pHMnlDUEZ5WkZaT0NkeDRxWkNMRXN1ZEFMRFBSMEtlZEgrNXl4Zkpp?=
 =?utf-8?B?eGRodkhxanpYYUs3dHhkNHVpaU1QVE9MaHF3LytWbmtEM1ZzZXdWc0J0aG84?=
 =?utf-8?B?K055VzZuUTQ1VnM1bUNPd2VnWXd2ZUV1SWJrVUVnU3dQT2pBd3p1YjR5T1hh?=
 =?utf-8?B?eGN3cFJ6Tk5VUlVLakJEeThnaWdJU3MzWVZtaTJPK2ZoSFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXJzUUk2VWN5YzRQUERISTdESkx2SXRUUytZazBGNWJKUlg2ZlJ3ZFhjZTVT?=
 =?utf-8?B?NHA3cE14SzhLZkdVQWRXTXZYem8yVlQzbjlOYkVSeTJVSWlCaUF5WUVyMWJx?=
 =?utf-8?B?bHdRemZxVWpNZGpGa1ZwQU01NDN5aW9SMzdvRnBuTUtSc3oxSllUcmwyR1RT?=
 =?utf-8?B?NWtaRGg1ODZ5N1cva3BGS05jTlA1UFdQQkwrWStUSU5ibzhBRG10TGV0Q3ky?=
 =?utf-8?B?MW8zNWNQelNqQzAyOWNOZFFXNXNnR2NrOEFPR29jeUt2WDdIcXBuamU5NjNq?=
 =?utf-8?B?Zi9SL0Yxc0QxTDZrcm14cmlQbVRKbnZ1UHpTNGNvMzJ0eDNBRTVXL0JMYUl5?=
 =?utf-8?B?Q2cyUGdsemxrUkhxS2wxOVZDWDZvamNhQXJPSXVpTmxoKy9tL29YM0l4WXgw?=
 =?utf-8?B?eUFiMEhCMkkxVmxaVEVFcEhGZnNKZ3k4OWhWQ2ZDb1JKOVoyUmZST2RPRVdw?=
 =?utf-8?B?OUxkYitnZlpvOGMwTnVxWTN4YWRUZ3gydDh6TGhOcm1rRytEL2VhNkVuVW1a?=
 =?utf-8?B?bklCa2U3dC82WUVSNXZQQnMyVEQzSzdoYnF2a1JlRjRVdHJlVUN2NUMySFM3?=
 =?utf-8?B?d3pUb2FuL2RvSnQ0U0Y0ckNXbU9HY2hKTXk1cll3bXNlbG1kQU5vN3Uzdytk?=
 =?utf-8?B?UkJza2NLRHUzMXFPbmZSVDBSYXVYcTRSOHpmaWhTa2Z5eHo3bzNTZENPNEVM?=
 =?utf-8?B?bkpwOTUzQXYvYmgrT2JwdCtwWUU1dkczTzVlVXM0UXpGZVZlN3EvajdxbXh5?=
 =?utf-8?B?ZTRaSkhoTXpidmNkdXpUM0RONUc2dm03Y29XbjUwSTExUW1pcG9ROTBKSG1D?=
 =?utf-8?B?aE5xdWN4cmxaSHFUOFNySTR6YlgrTnRLNVBpVkpUdFVGcXF5RjM0UE15Tmll?=
 =?utf-8?B?YzkxOEQ2L2s4bWRXbmx3L2hJYlB2dFEwWHpIcHBqVnVaWEx5cWJZK0Q2cUpI?=
 =?utf-8?B?T1hWQUwzWEx2ZUFvZ294aHpDUEdORXBsZTBKT0xYVXorWG9zNFVCZlNxZ0V6?=
 =?utf-8?B?dURXQlUwWkp0ODJNVDQ4L2xGVUFiZTlPNjlhVStQWTR6c29xOWE4MnNRR1p4?=
 =?utf-8?B?WHhNTmpLNXpQY05TdEcwUzFoTkRNa0RIRXBnaUNsam9peWZ5TmxDTlM1TURF?=
 =?utf-8?B?QkRPYnNMTGV4bllaNFliMWVYdXBuMkdYeFBNeVc3VG1XWnRWMldMb0tKKzQz?=
 =?utf-8?B?dHdULzF4SE1kcTF3Y0I1ektaMTVsUDBzU0FDSXJiZkZ0QWNVZndvRXoyS2pJ?=
 =?utf-8?B?Vm9lQWNnTGFld1RRaGp1ZVVWaWladEtMTGxwUERlbXNER3NIWnBRS0RBUUhU?=
 =?utf-8?B?c0FVaEM1NDhHa0YybGRzdk8rMlpDeHhVTHRRNHdMWm9aMmdtVWlFczJSZEg3?=
 =?utf-8?B?Rll1UkZGK1I1ZnVxVm9uYm0zZDJmWGxHRkc4SmRyTFlDNkt3Zk5OQktOY2o4?=
 =?utf-8?B?Mk9WUWZtVCtjRXBCWUxKY1R1djhoaE0wcmFaOTIvdG5TQ3hKVmc4aiswbnZP?=
 =?utf-8?B?TzhYUTYwa0p2clkwYi9jYkNQeW8rclh6QWQzZm9VemZVQ1BOQ3VwOXVuWm9V?=
 =?utf-8?B?MzM5STUzdU1LdGVkWDBkaEZoNnVMc2VuUXZHOTh5Q015d29SVyswaDR2NGZi?=
 =?utf-8?B?V0M4SVFBSW9nVW8vdFNQTDQ3ZlVvTjUrc3pXbkIxZzRRc0E1TnFYSnVIODlS?=
 =?utf-8?B?Zkg3d3prVWM0R0xSWWxnUDM1NVQ1OHlXTFg3QUV6WlBiUEtpdVZoVHJtN1ov?=
 =?utf-8?B?aDNTQnZGMk0zUTZocmpTRkptcWNZTUJCKzNNS0NxbVNjUUI4c2x5aWtJMURS?=
 =?utf-8?B?LzJQcjNGWXRTU2pjRkRsdzJXWlZLN01iNnNPd1gybmprRFRmY0xPN3ZUL0pZ?=
 =?utf-8?B?TW9PRVBsOVZyL3VXYUttRjlaQk82c29mSVY3bzlzdW5KbHBFdm9scmYvTUxB?=
 =?utf-8?B?UHgrV1JiNzRJNFVBYlNQeGRuc3Y5SnlUNE5laDRYMSs5NkdOdXV3eTEwZ3hC?=
 =?utf-8?B?M1hIRFU3cE5aYmdVdmg1aVdnVkdWNEp6eHFLVGIwaTRCZmxtK0ZHTmRway9K?=
 =?utf-8?B?ZkxhM1JsRjJxamRqbDJBTFRLNUlRbjFzU1UyRzFMNWdHOTdqTkZDL3hYM3lT?=
 =?utf-8?B?TnJjbUZ3eTR0dWNYT0Y4VFZLbVFRS0dCQzVVQzg2VGZpRXg1RlVSelp0amJH?=
 =?utf-8?Q?/Hh5+UfyFv147/KgGRCLWd0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7D97600E5F3FB42BB3A27E42D4C0EC4@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61af2d0e-adc1-496d-aa7b-08dd60a40f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 13:53:10.7983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jOqUagb9EogxhJ/TKanS+EC5eKHdmbnPwWK/+xME45lObUTEUEw+hF+Y6W6Zm4CJ1aViSg843XM6emZ6WvAx27FBrIW+fc92tM27Kiw4wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5389

SGkgU2lkZGhhcnRoIQ0KDQpPbiBUdWUsIDIwMjUtMDMtMTEgYXQgMTg6MzEgKzA1MzAsIFNpZGRo
YXJ0aCBWYWRhcGFsbGkgd3JvdGU6DQo+IEZyb206IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25l
c2hyQHRpLmNvbT4NCj4gDQo+IFJlZ2lzdGVyaW5nIHRoZSBpbnRlcnJ1cHRzIGZvciBUWCBvciBS
WCBETUEgQ2hhbm5lbHMgcHJpb3IgdG8gcmVnaXN0ZXJpbmcNCj4gdGhlaXIgcmVzcGVjdGl2ZSBO
QVBJIGNhbGxiYWNrcyBjYW4gcmVzdWx0IGluIGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLg0K
PiBUaGlzIGlzIHNlZW4gaW4gcHJhY3RpY2UgYXMgYSByYW5kb20gb2NjdXJyZW5jZSBzaW5jZSBp
dCBkZXBlbmRzIG9uIHRoZQ0KPiByYW5kb21uZXNzIGFzc29jaWF0ZWQgd2l0aCB0aGUgZ2VuZXJh
dGlvbiBvZiB0cmFmZmljIGJ5IExpbnV4IGFuZCB0aGUNCj4gcmVjZXB0aW9uIG9mIHRyYWZmaWMg
ZnJvbSB0aGUgd2lyZS4NCj4gDQo+IEZpeGVzOiA2ODFlYjJiZWIzZWYgKCJuZXQ6IGV0aGVybmV0
OiB0aTogYW02NS1jcHN3OiBlbnN1cmUgcHJvcGVyIGNoYW5uZWwgY2xlYW51cCBpbiBlcnJvciBw
YXRoIikNCj4gU2lnbmVkLW9mZi1ieTogVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGku
Y29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IFNpZGRoYXJ0aCBWYWRhcGFsbGkgPHMtdmFkYXBhbGxp
QHRpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU2lkZGhhcnRoIFZhZGFwYWxsaSA8cy12YWRhcGFs
bGlAdGkuY29tPg0KDQouLi4NCg0KPiB2MSBvZiB0aGlzIHBhdGNoIGlzIGF0Og0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTAzMTEwNjEyMTQuNDExMTYzNC0xLXMtdmFkYXBhbGxp
QHRpLmNvbS8NCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gLSBCYXNlZCBvbiB0aGUgZmVlZGJhY2sg
cHJvdmlkZWQgYnkgQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVu
cy5jb20+DQo+IMKgIHRoZSBwYXRjaCBoYXMgYmVlbiB1cGRhdGVkIHRvIGFjY291bnQgZm9yIHRo
ZSBjbGVhbnVwIHBhdGggaW4gdGVybXMgb2YgYW4gaW1iYWxhbmNlDQo+IMKgIGJldHdlZW4gdGhl
IG51bWJlciBvZiBzdWNjZXNzZnVsIG5ldGlmX25hcGlfYWRkX3R4L25ldGlmX25hcGlfYWRkIGNh
bGxzIGFuZCB0aGUNCj4gwqAgbnVtYmVyIG9mIHN1Y2Nlc3NmdWwgZGV2bV9yZXF1ZXN0X2lycSgp
IGNhbGxzLiBJbiB0aGUgZXZlbnQgb2YgYW4gZXJyb3IsIHdlIHdpbGwNCj4gwqAgYWx3YXlzIGhh
dmUgb25lIGV4dHJhIHN1Y2Nlc3NmdWwgbmV0aWZfbmFwaV9hZGRfdHgvbmV0aWZfbmFwaV9hZGQg
dGhhdCBuZWVkcyB0byBiZQ0KPiDCoCBjbGVhbmVkIHVwIGJlZm9yZSB3ZSBjbGVhbiBhbiBlcXVh
bCBudW1iZXIgb2YgbmV0aWZfbmFwaV9hZGRfdHgvbmV0aWZfbmFwaV9hZGQgYW5kDQo+IMKgIGRl
dm1fcmVxdWVzdF9pcnEuDQoNCi4uLg0KDQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3Rp
L2FtNjUtY3Bzdy1udXNzLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvdGkvYW02NS1j
cHN3LW51c3MuYw0KPiBAQCAtMjU2OSw2ICsyNTcwLDkgQEAgc3RhdGljIGludCBhbTY1X2Nwc3df
bnVzc19pbml0X3J4X2NobnMoc3RydWN0IGFtNjVfY3Bzd19jb21tb24gKmNvbW1vbikNCj4gwqAJ
CQnCoMKgwqDCoCBIUlRJTUVSX01PREVfUkVMX1BJTk5FRCk7DQo+IMKgCQlmbG93LT5yeF9ocnRp
bWVyLmZ1bmN0aW9uID0gJmFtNjVfY3Bzd19udXNzX3J4X3RpbWVyX2NhbGxiYWNrOw0KPiDCoA0K
PiArCQluZXRpZl9uYXBpX2FkZChjb21tb24tPmRtYV9uZGV2LCAmZmxvdy0+bmFwaV9yeCwNCj4g
KwkJCcKgwqDCoMKgwqDCoCBhbTY1X2Nwc3dfbnVzc19yeF9wb2xsKTsNCj4gKw0KPiDCoAkJcmV0
ID0gZGV2bV9yZXF1ZXN0X2lycShkZXYsIGZsb3ctPmlycSwNCj4gwqAJCQkJwqDCoMKgwqDCoMKg
IGFtNjVfY3Bzd19udXNzX3J4X2lycSwNCj4gwqAJCQkJwqDCoMKgwqDCoMKgIElSUUZfVFJJR0dF
Ul9ISUdILA0KPiBAQCAtMjU3OSw5ICsyNTgzLDYgQEAgc3RhdGljIGludCBhbTY1X2Nwc3dfbnVz
c19pbml0X3J4X2NobnMoc3RydWN0IGFtNjVfY3Bzd19jb21tb24gKmNvbW1vbikNCj4gwqAJCQlm
bG93LT5pcnEgPSAtRUlOVkFMOw0KPiDCoAkJCWdvdG8gZXJyX2Zsb3c7DQo+IMKgCQl9DQo+IC0N
Cj4gLQkJbmV0aWZfbmFwaV9hZGQoY29tbW9uLT5kbWFfbmRldiwgJmZsb3ctPm5hcGlfcngsDQo+
IC0JCQnCoMKgwqDCoMKgwqAgYW02NV9jcHN3X251c3NfcnhfcG9sbCk7DQo+IMKgCX0NCj4gwqAN
Cj4gwqAJLyogc2V0dXAgY2xhc3NpZmllciB0byByb3V0ZSBwcmlvcml0aWVzIHRvIGZsb3dzICov
DQo+IEBAIC0yNTkwLDEwICsyNTkxLDExIEBAIHN0YXRpYyBpbnQgYW02NV9jcHN3X251c3NfaW5p
dF9yeF9jaG5zKHN0cnVjdCBhbTY1X2Nwc3dfY29tbW9uICpjb21tb24pDQo+IMKgCXJldHVybiAw
Ow0KPiDCoA0KPiDCoGVycl9mbG93Og0KPiAtCWZvciAoLS1pOyBpID49IDAgOyBpLS0pIHsNCj4g
KwluZXRpZl9uYXBpX2RlbCgmZmxvdy0+bmFwaV9yeCk7DQoNClRoZXJlIGFyZSB0b3RhbGx5IDMg
ImdvdG8gZXJyX2Zsb3c7IiBpbnN0YW5jZXMsIHNvIGlmIGszX3VkbWFfZ2x1ZV9yeF9mbG93X2lu
aXQoKSBvcg0KazNfdWRtYV9nbHVlX3J4X2dldF9pcnEoKSB3b3VsZCBmYWlsIG9uIHRoZSBmaXJz
dCBpdGVyYXRpb24sIHdlIHdvdWxkIGNvbWUgaGVyZSB3aXRob3V0DQphIHNpbmdsZSBjYWxsIHRv
IG5ldGlmX25hcGlfYWRkKCkuDQoNCj4gKwlmb3IgKC0taTsgaSA+PSAwOyBpLS0pIHsNCj4gwqAJ
CWZsb3cgPSAmcnhfY2huLT5mbG93c1tpXTsNCj4gLQkJbmV0aWZfbmFwaV9kZWwoJmZsb3ctPm5h
cGlfcngpOw0KPiDCoAkJZGV2bV9mcmVlX2lycShkZXYsIGZsb3ctPmlycSwgZmxvdyk7DQo+ICsJ
CW5ldGlmX25hcGlfZGVsKCZmbG93LT5uYXBpX3J4KTsNCj4gwqAJfQ0KPiDCoA0KPiDCoGVycjoN
Cg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

