Return-Path: <netdev+bounces-183721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2427DA91AF0
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846A03BCDEC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A40F22DFBC;
	Thu, 17 Apr 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="cpzhWP38"
X-Original-To: netdev@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020134.outbound.protection.outlook.com [52.101.171.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424122ACCE;
	Thu, 17 Apr 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889446; cv=fail; b=EPCwfcrc4z8KzA+I9A2jHuogOWRjcGVFS3ZeArFIc2FT1VkgBRz5LJM94E0cruZO3ZuZpQfLNk7vRn8S4HcE9wyhQ5ekfZjB+CUR0y7G/5EgCbiehuXbRdKKLeufJRiCYr4NmO5ITA2dRdGAe7cii05mIrJkMgV+Mfnv5KKaXUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889446; c=relaxed/simple;
	bh=8JsTtSyICa9tH6dKlwskQEfQ0TeiFBDeGGUw8tsXOL4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BAJ/tCPH0/d/erIVbbhHjxudIf2oOrdY1CRRuqL8bJxbYp61+tclj5f3/prK+Xp0oZ4DaZFgTCYZaf8Yz7N33EH/k9/DIVdeQQL1eJVN7EAsyNNIE7/ev2M1JIfGBMmequ/gXP4YybPV2PaEQPUv+gS456LHE0zbCds38j/ID/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=cpzhWP38; arc=fail smtp.client-ip=52.101.171.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJvmFsmjb//FATDUEKsYF00BLDJTNLwdtFQdFBtCU5tiK53SLxiJ6U3yTu1ZySoBA1GIGh6upHplO/1h1YrNeNRo+fJ5z/Xjh+V8sRWeYzU7lLhsT/Vyg3K7+PUaYWWmAGE4PCWjLOIBpy6R9WBzCd9abSTS1/j9vSAmJyEw1EXd0V3UnFXAVVpEQreaWdXu0l9ub13JY5dXJ5d/MRFUlBrDU6m2spM6gEgcAaq2PrYaDGD5CLbuN2vdLb13wVnS3Yt6nfXwckY6OfYvi9q9WZpyWcJUMWd2TK47+jI39fWgmDr0VGc8t5axkp9qZitSP8WXDWQ1Nn4QaQzBq1a6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JsTtSyICa9tH6dKlwskQEfQ0TeiFBDeGGUw8tsXOL4=;
 b=SApHh4B6C88RTgYXFH5ZuunuD5HjSQrDykYp5FCGQyO3qPKAOzaJsnF3PjSiUDWVnmiGqYfSaD6fLUulKhmdE1dbwoCWpMYMZpeGoZyVHC4UcdLzbaEvVprv25cjq/z8u1ROfn850xdBpqVT5RHwtKA9a7qplTF70DXMo74FAydqdxcNB2uoNeK/GCaRqY+faJmFPFwWehjrUlMg5C+aqfpwVxgaKFlmI5jplKOB8J09eVUYj/SfEIiatdq1fCQaCiN1PpFx/sNfEXtcyntNVVirw6eGvfLOWv3m5yA62U6CJLTyVtneSy5EgXhj5IB3WYYVXHX6IhIy+JH7auuFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JsTtSyICa9tH6dKlwskQEfQ0TeiFBDeGGUw8tsXOL4=;
 b=cpzhWP38FSQAM3V7+7tyYiPsusywU8ULVI5V6kZt0wLzR9cAiRyFAOrRUY2hEWhdh8+lre5DNzfL3VIABXnZqpibcysJTFHf83x6x41VJ1MwhgipSYJ1zhejUQqfHELSaNOp1YBXkUGQUjtBmmlEIrshaGpVpkdkTdUw+ZDJrSQ=
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:43::5) by
 BE1P281MB1825.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:40::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.38; Thu, 17 Apr 2025 11:30:37 +0000
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192]) by FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 11:30:37 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH 1/2] net: pse-pd: Add Si3474 PSE controller
 driver
Thread-Topic: [EXTERNAL]Re: [PATCH 1/2] net: pse-pd: Add Si3474 PSE controller
 driver
Thread-Index: AQHbrrzpVc7077STXki1+R4vF88EU7OmHnqAgAGcUgA=
Date: Thu, 17 Apr 2025 11:30:36 +0000
Message-ID: <38b02e2d-7935-4a23-b351-d23941e781b0@adtran.com>
References: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
 <93d3bbf0-742c-41d4-83c6-6d94a0dd779c@adtran.com>
 <6ee047d4-f3de-4c25-aaae-721221dc3003@kernel.org>
In-Reply-To: <6ee047d4-f3de-4c25-aaae-721221dc3003@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2224:EE_|BE1P281MB1825:EE_
x-ms-office365-filtering-correlation-id: 87895edf-c7e8-495a-73be-08dd7da3464c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3U1WXVuMkNTNjJqT1dlUGplckhtS2tMZjZUUzNGeHZEWE0wY2x6T1oyT09L?=
 =?utf-8?B?YmN6QVNndFlrN1N0dG1uWFJKeTlVamlCV1hVUjNVTkNWY3dmYnE0d0xwRkx2?=
 =?utf-8?B?RFdGWEM1Sit6VzdMRzlSb0hQTVpTTDllOVJFM0Z6bHRWWFZDK3lpNVNOY0wx?=
 =?utf-8?B?aGRiYXRVOUxMK0pidVhpZTdsZHM1K0NtSVdqcTdTbUN3NDFYVlFWOW10OW1F?=
 =?utf-8?B?K211T3FuRXdoU05FbHlJYmZ0QWdVSXpXZldscTF0YWk2UjE1dEdaNmsvS3BF?=
 =?utf-8?B?UTRYc1VZR1p2NjROdlNabzdSdzlGWW1qWVk1cjRmVld5ZW05L29BZjI1bjJW?=
 =?utf-8?B?VFZNT1B1clVxVDYwbVNUU2FXQXlnVDM5SmRhMzIwZFNJU0NKZU5CL2prVjhr?=
 =?utf-8?B?MjJhd2ZSendDSXBMUTc1K0lkekI5TzJTd2VWVFB4U3lkVnpwczZSRDNHSDhl?=
 =?utf-8?B?a3NQOFZWM3hZWE15My8wamx4Zk92dEpyOUFNZHFSUUFBNWt5Z2NPa1FacnlV?=
 =?utf-8?B?YXVnRzFnbEQyYXVwcmxnNVdKNmpMRVAraXAvSFVpV3Vjd2VEN1RxSVJoY05r?=
 =?utf-8?B?K2ZkTDVNS2RwWFlwRzNFeVloQlFHUTU4OThaR0RrOHRQYkUxeS9zaXlzcjRx?=
 =?utf-8?B?ZmtEbU9nbVhNTWQ4MDdvNFRRQldKMUk2TFk0S284SWx2RHFMTWtHSVl0NndU?=
 =?utf-8?B?Q05qYmVEYkxSWHJNNGtBUVZqb1AxS29VWlM4blVmL0k4aTNITjRKcEV2b05L?=
 =?utf-8?B?S2xQTyt6UU9EQ0hzbU9TeXJYaFhXZ3A3a0Z1SHY2YUkyODI2VW5NcE9PdDlI?=
 =?utf-8?B?Mm9jMHNhSVlFdDNrOEdxbTFBUmtWZ2NZVW40aE9oc2xoVWdQenZUaUJ3Y0lj?=
 =?utf-8?B?UFZ6cytHSmlFRHhubWx3dUNwU25nZ1VtYWg5WGVZZTVrMkphbngzZm5DZXo0?=
 =?utf-8?B?ZzE3Q1phM21KRy9pMlZQU2VreHY5OE5aQUF4Mk1FYmIydlBEaEp3Tk5aeU5m?=
 =?utf-8?B?R3QxL2M4d3VGdTc2bVVzTVpkcWdZdFNIaU5jSmVzOUxLRm5GNXZ2VktLV04v?=
 =?utf-8?B?S2pQaWZjcXIrNFB3c0h6SDUrMjNkZXVzVExSMS9nQVprQ0t0VXBaaEYwNVRW?=
 =?utf-8?B?L1VHM3g0ckVIdnVBcUIvNk9wRDFiVmNMTUJlOVo5bmxIbFJwMXQ5endPMElY?=
 =?utf-8?B?RjJRaVkzM3lyRzVaeXduREwzMlI5dWVTQ0hIa1dVSlNyM2svUktKRTZJNEIx?=
 =?utf-8?B?TjFMaFdIbTh1SGhrMUk0a2NtMnhLbVhxZk5QZnRpVGxPSU4yRmpGQXNRYncz?=
 =?utf-8?B?MDBURjdjR2RxbHhiOTQvR2RrT1BDcENxeFk3N0pqU016NkthZHVqQTFLbzly?=
 =?utf-8?B?Tllja0RwMSt4eVdXYVluMi9vNXFRblpHMk8xUHFMaFpuOWpUREhIQVBXOUdP?=
 =?utf-8?B?V25Fc1NYdTJRUmIwcHZIeXNVc3oyTzRxYitXT2xlWUVldFNMOGdraVg1SDRo?=
 =?utf-8?B?a0g4dWx3TGl3dEMxcEZ4T3Vja3RKdkpSS2lnSnh1c284ZWd6NjJuWjZ4Z29v?=
 =?utf-8?B?dDZlQzhJMWdTOXJwRWFPWlpFMG5waGNDYWVycXlYUlFDMGRPbEtmalRKdjBG?=
 =?utf-8?B?UVJnWDdWSjNpVnFVYW9HeXN5ZHF2aTdDaUhTa2YyaUM4UmVEbUlkQ3VmRXBh?=
 =?utf-8?B?czEvTnY4NXNHd1FXRXpXbDlTYzE4WGx3OHo5dmdZRUplTWRCNXJ3SGtPVjRV?=
 =?utf-8?B?cFUvK1luWlBBdk0xWTNHOXdDUDZFdTRscHprOU5TbUNydUtUUDVidm5DTXdK?=
 =?utf-8?B?ZnRrcDl2MWZiRGNXa2wrTm1HZUJrSG1ibERlRGNGblF1ekhOaFk5akZMUDI1?=
 =?utf-8?B?KzArTThZVU96RWFZTENmQ0thU2FDeURKUkV4K3JwMnY0OVNLZk1JYUlpaHB2?=
 =?utf-8?B?bmdPS3JoRlFTTTJlcHNGN0M4eUNodHorVWdNaUFxOVhWNUdweEEyTVpPK0lE?=
 =?utf-8?Q?va1+myB6iWPYo197yU0ibGAnhK2jWw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2JDazhrNkNBY29jZHJmWXRhUUYrOUNSY2tpL1J5TlNzTmlBV1B2b0NpRWhZ?=
 =?utf-8?B?ZWFCZnp2dUtXeUJUbW5MclgwekNsa1B6VnhUNjVtSEJQMURZZGV3eEFOYU85?=
 =?utf-8?B?VW5xS1B2NWdrN1Ywa2tteVNXcm5ObEljZU9IQU9kbG9CK3UzazdCRVJmUlVE?=
 =?utf-8?B?QXBIN3QxTE9BSEpMWHFWbmNxVnNmaHJhZzltVElkckk3WFlZTHpCWjhVTGdQ?=
 =?utf-8?B?eWRueXZKTjcwZHBnUmtNbyt5RkROYUtab0lWMmVEVGdwNWZiRUo1a2lRcHR1?=
 =?utf-8?B?OEp6SXI0QXoySWFab0xCTWJ4YXZwV25LODJucjI5dW9wZmd6R0RqaDd3V3Fl?=
 =?utf-8?B?bWR4WFhqV2FaV3pIbE5KVXlEVzY0a3loOXlmNXNkNXorVUVBUXA0a0l0dnZy?=
 =?utf-8?B?RDlxNGsxUm5xOHVIZFpqTnU2NXZrdWttWGt2TXZpZHRMMlBtUVFTYmRyTjlR?=
 =?utf-8?B?YnBnMXJXdFBpbm5YMDltcFVyZzUwWEFGODhuYWxpUTlBNzIyUVZ4VDUyOFZW?=
 =?utf-8?B?Mml1NXl4bG0vekZLdG40QXdETTNONGI4Y3Rad1NwMm9tQW5IZEFiVndBMFFU?=
 =?utf-8?B?Nm8vQy9LZW8wZzVrL1lUZDdoVncwNlZkWVY4OGVaR3Z4eVQyVzFpMUd0ZEtD?=
 =?utf-8?B?SmI4clRIRkY5dmFSd0ZJbGFtOXczVGdWL25oVnVmR3ROWk5WaEVrNzBrbFZM?=
 =?utf-8?B?ZXFmMy9DTUUwOGRody9XeWEzM05iZkdGeDE1dXNZV2FybE1zMWxtQ1NERnI0?=
 =?utf-8?B?OERVVTVJRjdZRkI0UDI0R016SXB3RXh4bVRiRXZIV1BYVUVBbmZpM0pHS1pr?=
 =?utf-8?B?THA3cXRhbnVST3J3WnE2ZWlkQU9yU2ZjTkp5V21CT0Q3NVpQbHBYSmk5eGJw?=
 =?utf-8?B?eHZQaGtwODNyMjFiclA1cDUrdEsyY1FDRitoZGdQY3lmTDE3YnNUMHYycUpU?=
 =?utf-8?B?RDlVMFhkQmI2YnZ5cit6N3BOdjIrMXc1N1pMUWRnSkJHRjhuaFMyL2o5NjQ2?=
 =?utf-8?B?UzE2c1NuZ3RCR1BxSVhkSGVZV2VLbUN3ZEtBelBhMWtsVnJtRVNWUkJyaWll?=
 =?utf-8?B?STVTMjBQdVpuMVNQVlR4RFEyOUVXQURzOW1WNVM4YmNwY0IyVmkzdVBMNzhR?=
 =?utf-8?B?RWdsUWhadjl3VUg2ZmNSQUkwTWxPZWxrSlY0RWovckt4dTdYL0ltVE1lWU9J?=
 =?utf-8?B?Y3JwT21ZRUlxQ0ZxQjdyd1B4enBadU9FUmp6SUV2Rkx3MlNnb0UyWHF4VUtX?=
 =?utf-8?B?cVZtY2x0bGJlaTgrWlpMYWxCNTJoM25qUkpJRlZpbTJnZXZNQm5IdFFVZUFE?=
 =?utf-8?B?UWZMUzBBODNqL3ZsYWI1Z0o5ek5ySHI4QzBqUWgzQkJJRWRJS1loYmhJYUpK?=
 =?utf-8?B?S2NsMm5mMFBwYmdHRW4ybGtKdGZGcW0zempoWVZpNzlrS0tRbXh6TDJwaTda?=
 =?utf-8?B?a0xkb08yTDhGRTVkUlgxNFdnS2F6NWE0MlJsMWl6ZXNBaUd1SHVCVVNqQjJV?=
 =?utf-8?B?SEoxRU5KV3RVY00yNmZuUWJMSFdjNC81MHBtMnc4aDRlQjhpNjVsTDYrTXBR?=
 =?utf-8?B?VEJoTEtnOFVpTzUxU0tPSy9iaGJzaFEvcHNCV2s3cXNXemRLOHVwVjZaMVlE?=
 =?utf-8?B?N2QwdHJ0K2VsNVJubjF5QkNOYlUrMUZoUjVlWDZNa1dmVVUzeU0yS3R3eWIy?=
 =?utf-8?B?RTIvOWhRUnBCVW9na0hmV1VaMUowNHZHZWI1WXNTcG81NEhPR2RsQjhackdP?=
 =?utf-8?B?TXJwZWwrV2ZXZUJTVHhQdWxaU05qcFYvU1hFbUN4QXJPMVNDY0dwQkV6aHMy?=
 =?utf-8?B?ZjVkMUUzM0tNU0FFbjQ4T2M2dVNmU2hKZGl3d3dSWGtxZWhSeDRVYUwyYkx0?=
 =?utf-8?B?S1VsekRDVzd0R29UeEdTblRwMDZDZVcrdFlZNCtuZGtuVWN1VHFlQlhiN2Jj?=
 =?utf-8?B?TzIrRklpQlJpQlhJc1dEWVRadnh1VnI4MXpiRjF2Z2E2bHZmZGdpYjFXZ0t1?=
 =?utf-8?B?MENEbStZdWp0M3FCUnNLYVF6aHg2TWw5T1Z0akFsQlZWc2U4VnpXK0FOSDlH?=
 =?utf-8?B?WWdaQkl0eGFid3pacWRJVDMxNXg0VWl1a3pGTThoTVFXOHZONlhiTy9YdUpE?=
 =?utf-8?Q?3O/SjxkNhoRX+NInHRAgvzRhO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0771204A6BC245499D2B930D15B2EE4D@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 87895edf-c7e8-495a-73be-08dd7da3464c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 11:30:36.8964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ecl8M7rV3ZvEfjA6e15kvnU1tjgdW3AFlljhwmEyQqhNhDvh+sXkShgR5AJvYy5yuWoBeCKrvwQvElT6/pjqRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1825

VGhhbmtzIEtyenlzenRvZiBmb3IgdGhlIHJldmlldywgSSBhZ3JlZSB3aXRoIG1vc3Qgb2YgdGhl
IGlzc3VlcyBzdGF0ZWQsIHdpbGwgZml4LiANCg0KDQpPbiA0LzE2LzI1IDEyOjU0LCBLcnp5c3p0
b2YgS296bG93c2tpIHdyb3RlOg0KPiBbTmllIG90cnp5bXVqZXN6IGN6xJlzdG8gd2lhZG9tb8Wb
Y2kgZS1tYWlsIHoga3J6a0BrZXJuZWwub3JnLiBEb3dpZWR6IHNpxJksIGRsYWN6ZWdvIGplc3Qg
dG8gd2HFvG5lLCBuYSBzdHJvbmllIGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVu
dGlmaWNhdGlvbiBdDQo+IA0KPiBPbiAxNi8wNC8yMDI1IDEyOjQ3LCBQaW90ciBLdWJpayB3cm90
ZToNCj4+IEZyb206IFBpb3RyIEt1YmlrIDxwaW90ci5rdWJpa0BhZHRyYW4uY29tPg0KPj4NCj4+
IEFkZCBhIGRyaXZlciBmb3IgdGhlIFNreXdvcmtzIFNpMzQ3NCBJMkMgUG93ZXIgU291cmNpbmcg
RXF1aXBtZW50DQo+PiBjb250cm9sbGVyLg0KPj4NCj4+IEJhc2VkIG9uIHRoZSBUUFMyMzg4MSBk
cml2ZXIgY29kZS4NCj4+DQo+PiBEcml2ZXIgc3VwcG9ydHMgYmFzaWMgZmVhdHVyZXMgb2YgU2kz
NDc0IElDOg0KPj4gLSBnZXQgcG9ydCBzdGF0dXMsDQo+PiAtIGdldCBwb3J0IHBvd2VyLA0KPj4g
LSBnZXQgcG9ydCB2b2x0YWdlLA0KPj4gLSBlbmFibGUvZGlzYWJsZSBwb3J0IHBvd2VyLg0KPj4N
Cj4+IE9ubHkgNHAgY29uZmlndXJhdGlvbnMgYXJlIHN1cHBvcnRlZCBhdCB0aGlzIG1vbWVudC4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQaW90ciBLdWJpayA8cGlvdHIua3ViaWtAYWR0cmFuLmNv
bT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbmV0L3BzZS1wZC9LY29uZmlnICB8ICAxMCArDQo+PiAg
ZHJpdmVycy9uZXQvcHNlLXBkL01ha2VmaWxlIHwgICAxICsNCj4+ICBkcml2ZXJzL25ldC9wc2Ut
cGQvc2kzNDc0LmMgfCA0NzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
PiAgMyBmaWxlcyBjaGFuZ2VkLCA0ODggaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL25ldC9wc2UtcGQvc2kzNDc0LmMNCj4gDQo+IFBsZWFzZSBwdXQgYmluZGlu
Z3MgYmVmb3JlIHRoZWlyIHVzZXIgKHNlZSBEVCBzdWJtaXR0aW5nIHBhdGNoZXMpDQo+IA0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9wc2UtcGQvS2NvbmZpZyBiL2RyaXZlcnMvbmV0
L3BzZS1wZC9LY29uZmlnDQo+PiBpbmRleCA3ZmFiOTE2YTdmNDYuLjZkMmZlZjZjMjYwMiAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3BzZS1wZC9LY29uZmlnDQo+PiArKysgYi9kcml2ZXJz
L25ldC9wc2UtcGQvS2NvbmZpZw0KPj4gQEAgLTQxLDQgKzQxLDE0IEBAIGNvbmZpZyBQU0VfVFBT
MjM4ODENCj4+DQo+PiAgICAgICAgICAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVs
ZSwgY2hvb3NlIE0gaGVyZTogdGhlDQo+PiAgICAgICAgICAgbW9kdWxlIHdpbGwgYmUgY2FsbGVk
IHRwczIzODgxLg0KPj4gKw0KPj4gK2NvbmZpZyBQU0VfU0kzNDc0DQo+PiArICAgICAgIHRyaXN0
YXRlICJTaTM0NzQgUFNFIGNvbnRyb2xsZXIiDQo+PiArICAgICAgIGRlcGVuZHMgb24gSTJDDQo+
PiArICAgICAgIGhlbHANCj4+ICsgICAgICAgICBUaGlzIG1vZHVsZSBwcm92aWRlcyBzdXBwb3J0
IGZvciBTaTM0NzQgcmVndWxhdG9yIGJhc2VkIEV0aGVybmV0DQo+PiArICAgICAgICAgUG93ZXIg
U291cmNpbmcgRXF1aXBtZW50Lg0KPj4gKw0KPj4gKyAgICAgICAgIFRvIGNvbXBpbGUgdGhpcyBk
cml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQ0KPj4gKyAgICAgICAgIG1vZHVs
ZSB3aWxsIGJlIGNhbGxlZCBzaTM0NzQuDQo+PiAgZW5kaWYNCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9wc2UtcGQvTWFrZWZpbGUgYi9kcml2ZXJzL25ldC9wc2UtcGQvTWFrZWZpbGUNCj4+
IGluZGV4IDlkMjg5OGIzNjczNy4uYjMzYjRkOTA1Y2Q1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9uZXQvcHNlLXBkL01ha2VmaWxlDQo+PiArKysgYi9kcml2ZXJzL25ldC9wc2UtcGQvTWFrZWZp
bGUNCj4+IEBAIC02LDMgKzYsNCBAQCBvYmotJChDT05GSUdfUFNFX0NPTlRST0xMRVIpICs9IHBz
ZV9jb3JlLm8NCj4+ICBvYmotJChDT05GSUdfUFNFX1JFR1VMQVRPUikgKz0gcHNlX3JlZ3VsYXRv
ci5vDQo+PiAgb2JqLSQoQ09ORklHX1BTRV9QRDY5MlgwKSArPSBwZDY5MngwLm8NCj4+ICBvYmot
JChDT05GSUdfUFNFX1RQUzIzODgxKSArPSB0cHMyMzg4MS5vDQo+PiArb2JqLSQoQ09ORklHX1BT
RV9TSTM0NzQpICs9IHNpMzQ3NC5vDQo+PiBcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUNCj4g
DQo+IDEuIFdhcm5pbiBnaGVyZQ0KPiAyLiBEb24ndCBhZGQgeW91ciBlbnRyaWVzIHRvIHRoZSBl
bmQgYnV0IGluIG1vcmUtb3ItbGVzcyBhbHBoYWJldGljYWxseQ0KPiBzb3J0ZWQgcGxhY2UuDQo+
IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BzZS1wZC9zaTM0NzQuYyBiL2RyaXZlcnMv
bmV0L3BzZS1wZC9zaTM0NzQuYw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAw
MDAwMDAwMDAwMC4uYTJiNGI4YmZmMzkzDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9kcml2
ZXJzL25ldC9wc2UtcGQvc2kzNDc0LmMNCj4+IEBAIC0wLDAgKzEsNDc3IEBADQo+PiArLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPj4gKy8qDQo+PiArICogRHJpdmVy
IGZvciB0aGUgU2t5d29ya3MgU2kzNDc0IFBvRSBQU0UgQ29udHJvbGxlcg0KPj4gKyAqDQo+PiAr
ICovDQo+PiArDQo+PiArI2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+DQo+PiArI2luY2x1ZGUg
PGxpbnV4L2RlbGF5Lmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2kyYy5oPg0KPj4gKyNpbmNsdWRl
IDxsaW51eC9tb2R1bGUuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4+ICsjaW5jbHVk
ZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L3BzZS1wZC9w
c2UuaD4NCj4+ICsNCj4+ICsjZGVmaW5lIFNJMzQ3NF9NQVhfQ0hBTlMgOA0KPj4gKw0KPj4gKyNk
ZWZpbmUgTUFOVUZBQ1RVUkVSX0lEIDB4MDgNCj4+ICsjZGVmaW5lIElDX0lEIDB4MDUNCj4+ICsj
ZGVmaW5lIFNJMzQ3NF9ERVZJQ0VfSUQgKE1BTlVGQUNUVVJFUl9JRCA8PCAzIHwgSUNfSUQpDQo+
PiArDQo+PiArLyogTWlzYyByZWdpc3RlcnMgKi8NCj4+ICsjZGVmaW5lIFZFTkRPUl9JQ19JRF9S
RUcgMHgxQg0KPj4gKyNkZWZpbmUgVEVNUEVSQVRVUkVfUkVHIDB4MkMNCj4+ICsjZGVmaW5lIEZJ
Uk1XQVJFX1JFVklTSU9OX1JFRyAweDQxDQo+PiArI2RlZmluZSBDSElQX1JFVklTSU9OX1JFRyAw
eDQzDQo+PiArDQo+PiArLyogTWFpbiBzdGF0dXMgcmVnaXN0ZXJzICovDQo+PiArI2RlZmluZSBQ
T1dFUl9TVEFUVVNfUkVHIDB4MTANCj4+ICsjZGVmaW5lIFBCX1BPV0VSX0VOQUJMRV9SRUcgMHgx
OQ0KPj4gKw0KPj4gKy8qIFBPUlRuIEN1cnJlbnQgKi8NCj4+ICsjZGVmaW5lIFBPUlQxX0NVUlJF
TlRfTFNCX1JFRyAweDMwDQo+PiArDQo+PiArLyogUE9SVG4gQ3VycmVudCBbbUFdLCByZXR1cm4g
aW4gW25BXSAqLw0KPj4gKy8qIDEwMDAgKiAoKFBPUlRuX0NVUlJFTlRfTVNCIDw8IDgpICsgUE9S
VG5fQ1VSUkVOVF9MU0IpIC8gMTYzODQgKi8NCj4+ICsjZGVmaW5lIFNJMzQ3NF9OQV9TVEVQICgx
MDAwICogMTAwMCAqIDEwMDAgLyAxNjM4NCkNCj4+ICsNCj4+ICsvKiBWUFdSIFZvbHRhZ2UgKi8N
Cj4+ICsjZGVmaW5lIFZQV1JfTFNCX1JFRyAweDJFDQo+PiArI2RlZmluZSBWUFdSX01TQl9SRUcg
MHgyRg0KPj4gKw0KPj4gKy8qIFBPUlRuIFZvbHRhZ2UgKi8NCj4+ICsjZGVmaW5lIFBPUlQxX1ZP
TFRBR0VfTFNCX1JFRyAweDMyDQo+PiArDQo+PiArLyogVlBXUiBWb2x0YWdlIFtWXSwgcmV0dXJu
IGluIFt1Vl0gKi8NCj4+ICsvKiA2MCAqICgoIFZQV1JfTVNCIDw8IDgpICsgVlBXUl9MU0IpIC8g
MTYzODQgKi8NCj4+ICsjZGVmaW5lIFNJMzQ3NF9VVl9TVEVQICgxMDAwICogMTAwMCAqIDYwIC8g
MTYzODQpDQo+PiArDQo+PiArc3RydWN0IHNpMzQ3NF9wb3J0X2Rlc2Mgew0KPj4gKyAgICAgICB1
OCBjaGFuWzJdOw0KPj4gKyAgICAgICBib29sIGlzXzRwOw0KPj4gK307DQo+PiArDQo+PiArc3Ry
dWN0IHNpMzQ3NF9wcml2IHsNCj4+ICsgICAgICAgc3RydWN0IGkyY19jbGllbnQgKmNsaWVudDsN
Cj4+ICsgICAgICAgc3RydWN0IHBzZV9jb250cm9sbGVyX2RldiBwY2RldjsNCj4+ICsgICAgICAg
c3RydWN0IGRldmljZV9ub2RlICpucDsNCj4+ICsgICAgICAgc3RydWN0IHNpMzQ3NF9wb3J0X2Rl
c2MgcG9ydFtTSTM0NzRfTUFYX0NIQU5TXTsNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0YXRpYyBzdHJ1
Y3Qgc2kzNDc0X3ByaXYgKnRvX3NpMzQ3NF9wcml2KHN0cnVjdCBwc2VfY29udHJvbGxlcl9kZXYg
KnBjZGV2KQ0KPj4gK3sNCj4+ICsgICAgICAgcmV0dXJuIGNvbnRhaW5lcl9vZihwY2Rldiwgc3Ry
dWN0IHNpMzQ3NF9wcml2LCBwY2Rldik7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgc2kz
NDc0X3BpX2dldF9hZG1pbl9zdGF0ZShzdHJ1Y3QgcHNlX2NvbnRyb2xsZXJfZGV2ICpwY2RldiwN
Cj4+IGludCBpZCwNCj4gDQo+IFlvdXIgcGF0Y2hzZXQgaXMgY29ycnVwdGVkDQoNCnllYWgsIG15
IG1haWwgY2xpZW50IHNpbGVudGx5IGZvbGRlZCBsb25nIGxpbmVzLiANCg0KPiANCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcHNlX2FkbWluX3N0YXRlICph
ZG1pbl9zdGF0ZSkNCj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBzaTM0NzRfcHJpdiAqcHJpdiA9
IHRvX3NpMzQ3NF9wcml2KHBjZGV2KTsNCj4+ICsgICAgICAgc3RydWN0IGkyY19jbGllbnQgKmNs
aWVudCA9IHByaXYtPmNsaWVudDsNCj4+ICsgICAgICAgYm9vbCBlbmFibGVkID0gRkFMU0U7DQo+
IA0KPiBJIGJlbGlldmUgaXQgaXMgImZhbHNlIiwgbm90IEZBTFNFLg0KPiANCj4gDQo+IC4uLg0K
PiANCj4+ICsNCj4+ICsgICAgICAgaWYgKCFpMmNfY2hlY2tfZnVuY3Rpb25hbGl0eShjbGllbnQt
PmFkYXB0ZXIsIEkyQ19GVU5DX0kyQykpIHsNCj4+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRl
diwgImkyYyBjaGVjayBmdW5jdGlvbmFsaXR5IGZhaWxlZFxuIik7DQo+PiArICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTlhJTzsNCj4+ICsgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICBwcml2ID0g
ZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwcml2KSwgR0ZQX0tFUk5FTCk7DQo+PiArICAgICAg
IGlmICghcHJpdikNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+ICsNCj4+
ICsgICAgICAgcmV0ID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGNsaWVudCwgVkVORE9SX0lD
X0lEX1JFRyk7DQo+PiArICAgICAgIGlmIChyZXQgPCAwKQ0KPj4gKyAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQo+PiArDQo+PiArICAgICAgIGlmIChyZXQgIT0gU0kzNDc0X0RFVklDRV9JRCkg
ew0KPj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiV3JvbmcgZGV2aWNlIElEOiAweCV4
XG4iLCByZXQpOw0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5YSU87DQo+PiArICAgICAg
IH0NCj4+ICsNCj4+ICsgICAgICAgcmV0ID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGNsaWVu
dCwgRklSTVdBUkVfUkVWSVNJT05fUkVHKTsNCj4+ICsgICAgICAgaWYgKHJldCA8IDApDQo+PiAr
ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsgICAgICAgZndfdmVyc2lvbiA9IHJldDsN
Cj4+ICsNCj4+ICsgICAgICAgcmV0ID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGNsaWVudCwg
Q0hJUF9SRVZJU0lPTl9SRUcpOw0KPj4gKyAgICAgICBpZiAocmV0IDwgMCkNCj4+ICsgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKyAgICAgICBkZXZfaW5mbygmY2xpZW50LT5k
ZXYsICJDaGlwIHJldmlzaW9uOiAweCV4LCBmaXJtd2FyZSB2ZXJzaW9uOiAweCV4XG4iLA0KPj4g
KyAgICAgICAgICAgICAgICByZXQsIGZ3X3ZlcnNpb24pOw0KPiANCj4gZGV2X2RiZywgZG9uJ3Qg
cG9sbHV0ZSBkbWVzZyBvbiBzdWNjZXNzLg0KDQpJIGRpc2FncmVlIGhlcmUsIGFzIEknZCBsaWtl
IHRvIGtub3cgdGhhdCBkZXZpY2UgaXMgcHJlc2VudCBhbmQgd2hhdCB2ZXJzaW9ucyBpdCBydW5z
IGp1c3QgYnkgbG9va2luZyBpbnRvIGRtZXNnLg0KVGhpcyBhcHByb2FjaCBpcyBzaW1pbGFyIHRv
IG90aGVyIGRyaXZlcnMsIGFsbCBjdXJyZW50IFBTRSBkcml2ZXJzIGxvZyBpdCB0aGlzIHdheS4N
Cg0KPiANCj4+ICsNCj4+ICsgICAgICAgcHJpdi0+Y2xpZW50ID0gY2xpZW50Ow0KPj4gKyAgICAg
ICBpMmNfc2V0X2NsaWVudGRhdGEoY2xpZW50LCBwcml2KTsNCj4+ICsgICAgICAgcHJpdi0+bnAg
PSBkZXYtPm9mX25vZGU7DQo+PiArDQo+PiArICAgICAgIHByaXYtPnBjZGV2Lm93bmVyID0gVEhJ
U19NT0RVTEU7DQo+PiArICAgICAgIHByaXYtPnBjZGV2Lm9wcyA9ICZzaTM0NzRfb3BzOw0KPj4g
KyAgICAgICBwcml2LT5wY2Rldi5kZXYgPSBkZXY7DQo+PiArICAgICAgIHByaXYtPnBjZGV2LnR5
cGVzID0gRVRIVE9PTF9QU0VfQzMzOw0KPj4gKyAgICAgICBwcml2LT5wY2Rldi5ucl9saW5lcyA9
IFNJMzQ3NF9NQVhfQ0hBTlM7DQo+PiArICAgICAgIHJldCA9IGRldm1fcHNlX2NvbnRyb2xsZXJf
cmVnaXN0ZXIoZGV2LCAmcHJpdi0+cGNkZXYpOw0KPj4gKyAgICAgICBpZiAocmV0KSB7DQo+PiAr
ICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkZhaWxlZCB0byByZWdpc3RlciBQU0UgY29u
dHJvbGxlclxuIik7DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgcmV0dXJuIHJldDsN
Cj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkIHNpMzQ3
NF9pZFtdID0ge3sic2kzNDc0In0sIHt9fTsNCj4gDQo+IFVzZSBleGlzdGluZyBrZXJuZWwgc3R5
bGUgZm9yIHN1Y2ggYXJyYXlzLg0KPiANCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KDQpSZWdhcmRzLA0KUGlvdHINCg==

