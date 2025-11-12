Return-Path: <netdev+bounces-237970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A94C5243D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57D694E49F3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68710E56A;
	Wed, 12 Nov 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mtm7JZjp"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D231BCAB
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950536; cv=fail; b=jEQ2+IFucjdqshFqnQBlsmRyWZMdlVMtFwepxXi7rmyCYh+9ZY2ENXFHkPr3/zfF8ogqHpGUDtln3RdtNO9K/GQ/54XmC2dB1wdlYqdVk8bD7ZSpGN0G3/Wn+jIndyArVtxxDcN1azj8EhKdQcaagJXbE1LRKV4QXBiF4OUTyD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950536; c=relaxed/simple;
	bh=abzCVUI1dEjP+UVPzT4yTwWg4S0najlsY6B6BxvOKfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LSX1weQmW6aL5XPsx5P4ESGyMAQMjpBftDGcqN6Inb0zpUOU9rKpHFudOwsT+uGcMsJ8xkVl9HmzeTsvtU5su1LjY5xcKLOUx11gbfAmbaw5CNYbBKfDNAecR7q7MURDeiRbOm1Srh4KoQhyUQDm9SuiaoMbIb2eaEjHjG3BNBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mtm7JZjp; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuEDKKbqG1Au3cE5pKmLlepqyFHVdJPJ5MgAKlMzB4BTcjtm9ggSS2gR2lADOhZBqODlbNuwSrXiNNIWh2HquU3Pac+F5uJ9Le+FVpDq0gllzgiEh9Eh2US6gwyAE3FtyhsF9GGY6hLZLpT44dLrf+k2/oIKDXiQmffDGgvrCNEWudU7U5i97jgST52L0uYH6Q0mLEwbD8tF0eezCE1u31tefcSnk68FD6jbtuLsAjP7X8mUDaVBaEVVYz+3hTYhZYi7AZp3GlxeVFu9FmVSAkLrqPD1po/fluPg+yufv3wbmAqTb/PWVLHL9ZEU2BXMEknyp/2iNRRFbFJMf4PEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abzCVUI1dEjP+UVPzT4yTwWg4S0najlsY6B6BxvOKfk=;
 b=JfVxWNFXQp/BNHexmI4zvvP6mBc3nNYG6/4cxX4dPAiwccjIn/d7I013wYcHo6Z5WfH8Ti/seVl0YQ9IBKjVnduc3yxUkl6/jEm5hNR7LaUKboJHV46ECjnJJ6cLeuA3HKv5ZGZFTBuO6dZAUOprV926ENBQjNmc4LgvQh690LJeoYKGJVHgDFYqljZ7eyvJcstPtITo52Re3eWDffBuS/GnF6Dbfr9xaEnDQpxTJ8YHa/46bhMGcWRCBYdXl2u7tpobp/DaiaxrEPFldjtrGLgzaI1ZPwHKzkOSM1UckU2qup4INy0eYbOEcg20rk0BcikZ1sA+IsVuRTG/buSXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abzCVUI1dEjP+UVPzT4yTwWg4S0najlsY6B6BxvOKfk=;
 b=Mtm7JZjpJtlOq8UWFHD6KOclF+dnH5LZk4qAYjD0q4dNRw8KlJHWGZtKno8m5IMYBtO0aiubjdBS7XEicG4QHjCTHmCenqCJ1pW5KC2OGGX15qNnpXpNMJhgAsR50IulahFtHhVB0aI2t2nmIZpKEXon8kjN4V+oUsJ0/ae4o3buuisgntVurWx3fmiXgoRdMJYTtNbJgEkm1F/uC8s5SJdA8jmFnMFKahH1oeuKzJMvvy08LWbQ1pPhPNEv8SLBy/EW7v18is4KqljMcGXnCddKHpnZMXsNPWywR/bvP9aI205PtC514YQ70M9zKtQUDIXEtjl85PX8ggmnQd/x+Q==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by MW4PR12MB6922.namprd12.prod.outlook.com
 (2603:10b6:303:207::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 12:28:51 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::7b2b:6066:67f8:7db2]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::7b2b:6066:67f8:7db2%7]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 12:28:50 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "ap420073@gmail.com"
	<ap420073@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, Jianbo Liu <jianbol@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>
Subject: Re: [PATCH ipsec 1/2] bond: Use xfrm_state_migrate to migrate SAs
Thread-Topic: [PATCH ipsec 1/2] bond: Use xfrm_state_migrate to migrate SAs
Thread-Index: AQHcU75k830UXq3TW0yVHpSVWt/7KLTu+E6A
Date: Wed, 12 Nov 2025 12:28:50 +0000
Message-ID: <556a7345718faf6f02d23d278c5bdfce5d1d962e.camel@nvidia.com>
References: <20251112102245.1237408-1-cratiu@nvidia.com>
In-Reply-To: <20251112102245.1237408-1-cratiu@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|MW4PR12MB6922:EE_
x-ms-office365-filtering-correlation-id: 92a9141d-7818-4411-3533-08de21e70919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0c1N2IweW0xTnFGc203UDFaQlRiMVZqZW9MTmp4MjEySjNad3hkMVBrUnNi?=
 =?utf-8?B?d3EyZ1kybUtPU2hzRUFMTXJvMDE5VktiY0ttRzI4RFhVa3o1R0UzTy9ZMDFB?=
 =?utf-8?B?WHNrcHM1bXBleGZESlpVRVo3SUpyc2VjSnZJNXNtR1ZtUkN2SGdMMGYvcFB4?=
 =?utf-8?B?bnlMQm1iTDhlV1VzSmpKNkliTzk5M2ZicHIxR0tYZWN5Q0t2MXdTWmwxVmFi?=
 =?utf-8?B?eG52dUtWa0t6M0NVVXBLNUkrN0tXL2cvMDNkVVNubjhqTUc2eXpSbldLZGxX?=
 =?utf-8?B?QUZIa2NXa3V3bUIrTkZUUlZ6RFZiaXJvOVdhRWVuLzR1Y3IrV3hOb3hqNHdm?=
 =?utf-8?B?RXdHVjh6ZTBvZnQwRFAxU0k3b3kxQkFuTHhHR3JBN1p6bmhXQ0dvdTV5RFEr?=
 =?utf-8?B?VnJFQzAwdXJzSmZmcDc0UmNSRm5IRFdEMEJYSmdvR0FtaXVDWmVvZmtVSnBD?=
 =?utf-8?B?eGNLUFlYTm9sN2hHWDJRMTUwb1IzMFhsdGNJb0MvbmxyS1VVU0RISmJUaE9G?=
 =?utf-8?B?S25saTQvZHBWMUh0Wnl4RFMvSGN6MWx3eUlocmszT0dMNUFCWFArazdsQm95?=
 =?utf-8?B?blAyc05pZlBFeVVBVVdmSGpsdnlMSDlDd3hQUVpKWUg1VWo4VWlOempuV1Ex?=
 =?utf-8?B?Vm5YY3ByQXlnMzhmR0ozemMwL1N2cDQ4YW5JcEJSR1lkZTVGSVZHaHdJelAv?=
 =?utf-8?B?MlVSU1B2Z3duYnlqYnNZbUxnNXNMckhZbXVOL215TTlCQmlyRTF6TklYQnBo?=
 =?utf-8?B?SWtxZ1hVMFdKTDMvOVhIZTNWVThWM3FCZlVoSWZHSFJpQzNjaU11Z3JUak1L?=
 =?utf-8?B?MERyWU41cVp6eWVxTCsvY0ZnaVJnUWlqcGo2cXUwYTEzQnM2VGJGWGpJdDd0?=
 =?utf-8?B?RlVIaUF2cmxmZ040WnNWT2d3Mnp2UnJLSVlBWk5PcTlEb3M2Y25ETjNrRndD?=
 =?utf-8?B?UWN2U3J5UkRqVUdaSVFETmVSdmxOMitCeVBVa3U0RmlxUU5XcUdtRUpRVk9R?=
 =?utf-8?B?U2NXcWZhcEdQWjFJWHlLQ00zVnF6L1FNb2RQc01FNFBIMVhNb0YxejdRSFVF?=
 =?utf-8?B?NWdVRndWRFQrbjIzY0NqUlFHWU81QTY1YzR0Q3d2bWMzanZ1cVp2eGVHb21D?=
 =?utf-8?B?Y0daUDhRRDRVVmU2cUpMSk45Qnd1K0EzQzhKK2g4NlF1cHMycjIxNnlUQUVC?=
 =?utf-8?B?c2hEQkJrTytwRUVIZXNld3JwVzdSR1hneURXMUoxdmFzZ0x1L0J0dHYvYWtR?=
 =?utf-8?B?b2w2NG8rcUs2dkJRTm84ZDRteWZHZ21udHFzcFFwMDAvaExUL0pzUmNFeTRn?=
 =?utf-8?B?cFg3UWZQL3RiajRvVTcwWThnY0lSYkhtYk9kY3pwSlBnUHc2K2NsSVNBdG12?=
 =?utf-8?B?Q08zcHk2L1VER001Q2drMW1TNVlNTFIrQmhBZWFuWjFxb0gxa3VIMmJCbFFV?=
 =?utf-8?B?S3pVdjZDajk4dFlIREg2b005MW9Xc2F5K2JSR1pXcmd2azRhdmlDYU5FZEt0?=
 =?utf-8?B?RnpacFhVWlQ4QUVWQjBTeTFBc3Q3OUZKQXB1aWV5SmJvUWc5ejI2aVNmb0xD?=
 =?utf-8?B?Yi9xdld3bmpYbWVycXJHeDEyOVlMNjJHdm43cU5nMkxiWVhtTkxZbUNTbEFP?=
 =?utf-8?B?aWtCZFdKa3RlN2ZlQ1R0TEcvTUEwUVlDMXBiT1JENFRxeHVsaVR3UUVOVGhK?=
 =?utf-8?B?eUltc3ZTYmdIMHRvS0VER1JNNmQvNVhGajV5WDFCc01BL1Rub3orNk1xTWNB?=
 =?utf-8?B?bERHekFzQ2dhYmd3MXVNeGdmT1dTdTR5aHg4QzUzYWFlaUxaOUdvNzc2ZlM1?=
 =?utf-8?B?R3o5dHF3eFlra3BEeStYUHlnMzZHeVAyU0RDeHhhUHBQNktWMzJiYlJKWkZO?=
 =?utf-8?B?eFppakttR2JNM3o0dndNOW9nU1RJZWNudG1UYnhVVk5YZUlrVkJJaTM3L3Nk?=
 =?utf-8?B?OHpLdlErSWp0M0xkS1VLWmhpMkwxRGRnaGdvVHd5YVNlQlRJYnJ0RmFXYzAz?=
 =?utf-8?B?cXlWeGRGUzVZVit0NFZUMG1iUjVoUWFjR1pCa2NXbVl6dkRSakJoZU9KOG9Y?=
 =?utf-8?Q?STcp3i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlhvUFNPaDN2NThnaE9IT2JqQkIzcU9pdTRWM3VQUkQydDBscGh5aHZKK25P?=
 =?utf-8?B?S2dQdzg5UjdkVk0ySC9XbThaejNyeXM1UVMrY05kbGhHdG9MaVlqbGhVQW5J?=
 =?utf-8?B?L0M4NTRUOTlydVF5aldLc3BJYlhqKzZFN3ZSbTlBazdEMWozanhkVHdHQk5Z?=
 =?utf-8?B?M01SRTJyRXdUOHBSaEluUUhDdlFQNmh6Zlg3MDZiVnFSUUtDMUlORFozVGQ0?=
 =?utf-8?B?bExzR25oZnhlTjFETHNNbEZKdGhJaTIrRTRIdWFNUkNGc1VNaU1NZk1lc0pZ?=
 =?utf-8?B?RUp2VjRTNzhTVUdTSDA1MVNXSUVyWGNOejdiN2ZVNHF6Yi9LUmFjR1hNSEZX?=
 =?utf-8?B?c3p1R3p2UnhjNDhXaFR2dTBTdXhCNWt3L1ZZVnpFbDZYQVFYTXRGaVptZkZu?=
 =?utf-8?B?b2IwMVlMQ3oyekVwb3JxWU9WZHpVcEdZOWNmM1ZiVmVieXRsSWlkam95VHZn?=
 =?utf-8?B?N1FyN2h4U283UjMzdTJCVVBqWlR5akFlT3dPWi9yL0FXcTFLZGRWZ2ZpNk1F?=
 =?utf-8?B?SCtLNzI5L0JPeW4zekVMMnZhdVJFY2dSSk5JNkhMSGFaQUhQcXhwZlNxNEZX?=
 =?utf-8?B?cEhkRk9XRHQxMzBFWXJGNVRLR3Y3UDRIQTdLM2hDSE84QVNTR2pRK2dhQnpV?=
 =?utf-8?B?aG42cEE0WHo4TFcvbUk3eGJPTXhucFI0MzB4ZFlWa1BOK2lxcGZxUEZrRU9z?=
 =?utf-8?B?MGdZcDF2dzFRMVRiSmJzSlVEbGJUTklOZ0FHNGY0UFduOGlmTmxTOE1tRUdB?=
 =?utf-8?B?TngvamZGSng1cXRZam4rck95ZWxsOXJsM25haW5tVW9ua2xzSldwbW0yZnNI?=
 =?utf-8?B?Y0xxYm1QL1MvcjBlbnVoZXlBY003QnhpdzI2VkZWTm05NWQ2VWNXWExSV2J4?=
 =?utf-8?B?eFkxVEZlRWk1eVpJdHQrS2xjTHlDQVFGN2NLcHdhNHdaSGR2UkZiWUkxclVE?=
 =?utf-8?B?V1dCYnZjRENSTyt6bllPNHF4RHJ6c05FcXNIT2NmZWdDOWpCRGNaZFhya29t?=
 =?utf-8?B?UU9WY1I3amVuS1NXTk8wblZIWnhDMGNvSC8wWkJRT0ZsSGl2NEdZVjJlN3B6?=
 =?utf-8?B?UWZjNXk0SFZKNmVKbGVDa2hLai8rSTR1WldHajZBNmZmcTJZRitMMGhzSjNU?=
 =?utf-8?B?aWJRcW4rWldndXNtZi9neUN6OGtvN3BFT0hVUERjdGp1bmxiSi9VQmtpeUt5?=
 =?utf-8?B?dzkwSW1RenBkQmpDSmNPQWIvVm9oUkZXcUhQOVZJWndZTTZoMTR0TzVNRHor?=
 =?utf-8?B?M2NFM3lJZmJOOGxvVHRpU2o5SDFLbjVseWRuZjl5S2pmclpZY01aTDEvVmtn?=
 =?utf-8?B?UlZlZFZtL1d1YVp6cDZsL2pTL2RUeTE2Z05DUHY1QlhGTFVtWWs0ZS96UDdH?=
 =?utf-8?B?NG12ZzhKNzY4eFZPSXdyUFpsK3k2NzdlUHg5enRBVkZKMnpIZXkxWVJCcTM4?=
 =?utf-8?B?d09HK1RwL0xCYXMxbHlTU1V6cndKQXN4cmR2aUdPc1NXbDU5M3dTK1BGYXhZ?=
 =?utf-8?B?b280b1h5VjE0OUoxcDA2cXR6ZzNYL0RmbWxFYm5MMEh0TVhkcU5rOXlLTC9O?=
 =?utf-8?B?VDhXSDhpKzNUZDRsbkFvSzdJcENyN3pscUJMdWh2d0dTam5Ibkk1Tmh6elNV?=
 =?utf-8?B?MDJST2wxMHhDYlp0SXp0YmhkTnVOT3NFVUdkUG9UR1V2S3UvaTNZdU4ra3A1?=
 =?utf-8?B?QkxFbGdpS3g2cHFjcW1JeVZnRng5eDcvTCtZRFVzakhoMlVsVW1CekN1Ynlk?=
 =?utf-8?B?MW5CaWRJdGhRRnJZUTN1a1k2OEtiTXZvQXlRK1VWVFNzMGVSbndTVVFCWDFY?=
 =?utf-8?B?dUIvcTUwR0NwK0tpNUZVMFhHRTNHQ3ZJdEJhWmtYRlllOUoza0ozcElBL3RY?=
 =?utf-8?B?dmlsemxJZlhRU1ZjcTdpY25Fdmh4VktxZ2VuLytEZDJiVGw4SW5qYTR0Y242?=
 =?utf-8?B?dUcvNVcrcDY0S1ZRTVJrZTRYMnNUbmhSZFBkMUlhYzQwRUJGZVhxeU4yYUNp?=
 =?utf-8?B?UnVTempjaGcrWHErcEV1eGFEL3luM2oyT0crWVFvald4b3JnYnB2Nk1xSFZu?=
 =?utf-8?B?eENiajkwL3d0TE0zb3pUQTdNZG8vWnE1c1V2UDNtczQvRyttdm9qdnc3VnlR?=
 =?utf-8?Q?0ghtup3zBpFix25FBNjIt2ABJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE1011BEC3ED734AB91BDBA5D3A1F1C1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a9141d-7818-4411-3533-08de21e70919
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 12:28:50.6396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHg/dsz0SVrLQP2Z9R26Zzdw4yLlcOctTUN96CKxy4yS5r9grVN7y4sxsHUYAMsSAiBM1RKMdD68dp6jIGIHSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922

T24gV2VkLCAyMDI1LTExLTEyIGF0IDEyOjIyICswMjAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IElzc3VlOiA0Mzc4OTk5DQo+IEZpeGVzOiAoImVjMTMwMDk0NzJmNCBib25kaW5nOiBpbXBsZW1l
bnQgeGRvX2Rldl9zdGF0ZV9mcmVlIGFuZCBjYWxsDQo+IGl0IGFmdGVyIGRlbGV0aW9uIikNCj4g
U2lnbmVkLW9mZi1ieTogQ29zbWluIFJhdGl1IDxjcmF0aXVAbnZpZGlhLmNvbT4NCj4gQ2hhbmdl
LUlkOiBJMzk1M2NhMGU2MDAyMjAxODA3MjExNzRmM2VlYjdkMmRmNDY2ZjhjMw0KDQpBcG9sb2dp
ZXMsIGl0IHNlZW1zIEkgZm9yZ290IHRvIHJlbW92ZSBzb21lIGludGVybmFsIHRhZ3MuIFdpbGwg
cmVwb3N0DQp0aGVzZSB0b21vcnJvdy4NCg0KQnV0IGlmIHlvdSBoYXZlIGFueSBjb21tZW50cyBv
biB0aGUgY29udGVudHMgb2YgdGhlc2UgcGF0Y2hlcywgcGxlYXNlDQpsZXQgbWUga25vdyBzbyB3
ZSBjYW4gbWFrZSBmYXN0ZXIgcHJvZ3Jlc3MuDQoNCkNvc21pbi4NCg==

