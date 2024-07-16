Return-Path: <netdev+bounces-111734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2B99325DE
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34541B20AF4
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB2E1991A0;
	Tue, 16 Jul 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b="qF58atBW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2130.outbound.protection.outlook.com [40.107.104.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6194022309;
	Tue, 16 Jul 2024 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130225; cv=fail; b=HHWuP8NyVi9Enpimr8Wz6S9qpBBxU7SZVbiSJV4lBRB7p+pRFNLy9rubJJ5mq4Kk6U3r/edIPUp9wWFsyOeyGDCLUeibnxKC44RzYfn0i7CEvcS9F/lSfMAy+2+146NI9+z/tUO8Wlp7ojLyGxG9U6y/yTAo0OP/tBG1r7xG5oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130225; c=relaxed/simple;
	bh=iQ1+tEvmkcqeM8aXc8zpllxgCSkd8dT3Ej7Qq1eBgmo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ASt5JPHpTOqw5wXzDRGx3xob0mWXJ2u31gOY/Udw00Gqg1dGoduscgvt/j3WGtTvLHSf55IlN3RXrJ0ytzoWXdVVGuSih5mUhDThZPW2QF7rIXCkUwHq0sFTVrs9/S6ukXOS3VWlqZP0UYlVpH/f3zFt0WDbV7M0jBXfuiFYFoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com; spf=pass smtp.mailfrom=endava.com; dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b=qF58atBW; arc=fail smtp.client-ip=40.107.104.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endava.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3vw5pr+H3UoBEL03IFslu+J9NTBQ0jb5R7lxtsMEnP1lmiEtVUSy/bft5eFQEPQPXyCXzh+mZ/zXdCx+maNh09bxJtMBgA0UzZDx4nrDuuePHC+AzUt60yXlFwhxVlE4Jjyc6vbcfE0FkniEBQMjK0BQa/TT7Md2sfmTTcogbpapyBdO4zVDH1waw02praKEKRWuW6ELLzSz4clHK9CfgWB1nVLHsEHTH1BdUmiYmhJaf+jIS+RJWiKp6gXuAvYLk/3l/9Sa99RR9jUmp+inHVMeM6lEvR94BDAImRCBQEodpcnAcQLYFfKgwgopig7LmBnuPl5LmojvrljErKSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ1+tEvmkcqeM8aXc8zpllxgCSkd8dT3Ej7Qq1eBgmo=;
 b=AJhWpdcSHyWpDh5KazB1QDY9NWDd6LsDxOJePfCnyIcG4GAEkvWAzpQ7u34FTxmgvDgf6uasRUq6b5Z8DkcRsnTGojb08sZaVf8XoY5ae9AkHZ0RMWA0q6jDm7aiOKPEq1mFx0Tkti8cZgRTGuqq+Ef/mgzi/g257usT51aBpV1HnTNVHIpYxdtQXAqy2S76U7/VOFOUFrUnwYv3pARqttLI4r/N12ZZGCCHNswtoIjYlEx0cPBubg378zeNDm/hkMe2wMrWgXHDbcsuJ/1wPaK/DIhhZNS3U//NeHCuvLk1QTg0t1kybK3ifja/g6045X5ik+7zNTiU2/68h/jILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=endava.com; dmarc=pass action=none header.from=endava.com;
 dkim=pass header.d=endava.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=endava.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ1+tEvmkcqeM8aXc8zpllxgCSkd8dT3Ej7Qq1eBgmo=;
 b=qF58atBWD1d4btvHBb+AG2LWcYiNG3d07XupyvTQQ8sxilpZ1HIvZDlo9ZGSKep7FcZQMjjege62X3/Q5mmPd10G9CU06DQyWPyf8CWSo4+bfq7X69jtnJnageEBgrvwjn/KdoeOJ2eGlJKfhjQeeoHmsvDIQEnL8g8OsoTmOO1eo19oZ5CmxPGh14SchPc87QBdTT21NVtAcNVXjeDVBfgPda/dxF7GHgX82B1WTo9Fp/62v9rcWiIH9Wd59lg9GEMneX5CTDT9e2WK0uUY1dMTq7OKBBwy7mEM5+M/RwIkZkhMO6pe0xqgrMFkSNa9+iQV/yI0FWRJdbZ+CBtHRw==
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com (2603:10a6:20b:67d::20)
 by VI1PR06MB6544.eurprd06.prod.outlook.com (2603:10a6:800:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 11:43:40 +0000
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41]) by AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41%3]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 11:43:40 +0000
From: Tung Nguyen <tung.q.nguyen@endava.com>
To: Paolo Abeni <pabeni@redhat.com>, Shigeru Yoshida <syoshida@redhat.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "ying.xue@windriver.com"
	<ying.xue@windriver.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
Thread-Topic: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
Thread-Index: AQHa1yUvQPqLAGQ2A0GB9aoYG5W6f7H49WZwgAAEmICAAD0xAIAAA3+w
Date: Tue, 16 Jul 2024 11:43:40 +0000
Message-ID:
 <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
References: <20240716020905.291388-1-syoshida@redhat.com>
 <AS5PR06MB8752BF82AFB1C174C074547DDBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <20240716.164535.1952205982608398288.syoshida@redhat.com>
 <596fd758-11ad-46c0-b6f1-2c04aeba5e06@redhat.com>
In-Reply-To: <596fd758-11ad-46c0-b6f1-2c04aeba5e06@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=endava.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR06MB8752:EE_|VI1PR06MB6544:EE_
x-ms-office365-filtering-correlation-id: 7876cae3-c34c-4478-45dc-08dca58c8991
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YS9IbUlDZC9ScHZpWk8vOUJ3QTRuTEJ0eTJkMVkvbElNTTVCV1hCeXNMMHdw?=
 =?utf-8?B?Q3hiTGc5d0ltMjBaUFJGZ25qZmtjcjd0YnNiUDY4RnBYNEszWXdsUGZRY29J?=
 =?utf-8?B?QS9XQmRmd0t0WDRKajZEVkpta0d2M215WWVMc2F4UllSeCtnVzVLbzRDcExO?=
 =?utf-8?B?bWFnRjlFdDdVa0c4UHAwRnBXNFBHZEVod3V3YVY5c3pKMGVZb0I1TUhTT1h5?=
 =?utf-8?B?OExuMVQ2VXJkVW9Ya1hJRWJDODNNWmUzQWlVUzBXdkk5cmxOZ2tpOFBnQ01B?=
 =?utf-8?B?ajRHdUZOTmM1dWRXTk56TnlnVERjUU1UVENWV1ZtTUNEazUwaExhVEthTmFU?=
 =?utf-8?B?TUx1WnhRSnFDd1E4WEFOajRHOFlaRWJ0OXhsbjlMWWdtNVFjUVNqZW1OdEJh?=
 =?utf-8?B?RnJWQmg0UW9aY0JjbVV4a24xK1FOVWFPbmE0MlpVa1VVaVdpSTF4SEh0aEF5?=
 =?utf-8?B?VGlhNnB1TmdXdzFZWFdteUdQb3BtbmNIRkcyb21SaG1yQmNQaDF4RndJeW56?=
 =?utf-8?B?SVh2WDdCMUxtM2wvVmFIbUZHcC9kYzF0ODByNTJxcnBibnptOVgvbzJKZGZK?=
 =?utf-8?B?WlgvcFpWOXdzMGltaVFDZi9BS1dwZVJIeU9DN24zV0pPcUg5Vmd4R0xsdm9P?=
 =?utf-8?B?MHc1NzVpR1ozRm5wMXl1cmgxaVd6dnJKR0VxYTZtTndCUm1YbGUyd3U4R1lI?=
 =?utf-8?B?R0IwY3U2MzZlZVBrNEJjVStiZlZkTFpKaXlYMmFXNVFtc3VFVndHM3hFTzJl?=
 =?utf-8?B?QUh3KzJrM2ZMdHZvQmxaT0xOUGxGaTNUbHVYaE1GVkVDSlM5RFpqcDVTL2tr?=
 =?utf-8?B?eTFDY1RJTGdCQ3hrY0tReHAxZUdIeXBhbkVvNXN5T01CdkVHNmludTh4Ums5?=
 =?utf-8?B?RWt2WWhtZE1lbTZ0T2xjS1FuRkpzNXU1Qm9aU2IrbVQvTFF1c2I3TEdSR1J4?=
 =?utf-8?B?bXpnRGtFNEUvQ29WNG01cUtST25HUGZKQldWVWlNejRIeXVrc1JxNXpNdHJl?=
 =?utf-8?B?OWRYRGRsSHh6TUMwUGxaMk1WVks4VjVFZnExZEJDVnJ4VW5VaDI5bXk1OUdI?=
 =?utf-8?B?R2YwZjRsM3BCSTBYN1MzUk9kbjFmRDc3YWxlZGZPS1JoencwNnBYTG5XS3Uw?=
 =?utf-8?B?OC9tTXVaa0lMZlExOEJKb2VaNVJDcWs4aVdxQjBISHdBNWh1ckRtTVp0T3d1?=
 =?utf-8?B?T0svSkxYLzdzYWVmc0F5WG1XMER1amcxbUJkQUFyUmVTUkF1TjlzVmE3dEMz?=
 =?utf-8?B?cFdJTGx6b0hQWHNsaGE1NXlrcmJHb3dsSzlPV21kdUZnMnlmOFRxMWMwRkJh?=
 =?utf-8?B?VWUxT3IxblZUWElMQkY5VDZHK0RXNjFzemlIVDRQTkpsSWlOeGYzN1d2cFF0?=
 =?utf-8?B?bi9xYUNLSkJzQXdDcmdENU5wMDdkRnVGY3ZORlhQTzdDWUswRjRuWVhDb0FR?=
 =?utf-8?B?WndyaitVNlg0VFdNUVgybUZ2TWNtTzROTTRTK3AzT1ZuY1BxRHJlRVgyYWQz?=
 =?utf-8?B?cjJGN1hua1ExbnF5d1ltRjJrSFlEckNGL2w5VmFCV2s3NkU0LzlIL1JqbDYz?=
 =?utf-8?B?ZFNRTTRDRklqQnhVTHlnWHF4eGduR09peTg3YWJJOHZqdVhadFhldXJqM01M?=
 =?utf-8?B?b3pRR05lb29uU3lsTVJKNDhBQmh5RUtNbjBkKytwWkt5NUhxYnRnd2lmZ2RR?=
 =?utf-8?B?OWRkZW9GZ3pUcHBWMS9POER0dE5BS2hwcHY1L3Nwd0c1QzhjVzZQUEtPVTc3?=
 =?utf-8?B?TmRlSE82b2M1VVNWSUxwSzFHYWJrYWRWczgwNmdEcEpUeU5PTnVhRnM1RFhO?=
 =?utf-8?B?eHVxTkFSK01qSTQrbjEvWXQ2Q1h6eGRTQzhJQ21WMlU4NWhqSiszMDdKdnNa?=
 =?utf-8?B?UUdkbXlOUDVKUWVwbjdySUxtSyttVW5GQnNpbDVHazF6WlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB8752.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2FHY1R3WGYyaE55MDdUS2JjUkRkZ29Da2N3UnRqYkRZUUFsTUNSYmNPc29G?=
 =?utf-8?B?Um9pcUg1VEJkdkV4TTlLMFVEZXhDaXI0Z0x2dFFlaWNPQStIang2b2VCUVBa?=
 =?utf-8?B?cXhlL0dDU0Q2UWlUWEZnbHArbkhEeG5wb2JmOXNnK3doK1E0R3BaV3lnck9x?=
 =?utf-8?B?cEQyblVJd3Y3UXlQK05wWmtjbVVqbzhmVFpCWHp3K0JRT1RxSFNYbWducTNO?=
 =?utf-8?B?SnRTb1BBM0lRTmhLUWY1WEt2OTFwZ0FNdkJ3bjNJdGIyakJpdERBanNCRjJB?=
 =?utf-8?B?REt4bFBTa3lJVk0wVjhQUVVBa0tUL2FtLy9pb0s3RTAxTUNKelhMQi9uU285?=
 =?utf-8?B?Z3l1c2VhaXppOHdUcUxoc1pqUW1XY1hwbUNwOTVxYXlSeFNqbkJJQlZoeElk?=
 =?utf-8?B?aFRzeVZOd1VFTXA4NmtPNkVyQnYrQjhuNDNwcXM3dm5yMTVabGZiY056bGp0?=
 =?utf-8?B?UlFaNzNNUUtSQWdRM1AzNEwwRVBIQUthalJqUzNNM25lSUhWcWZXVFdsQzR0?=
 =?utf-8?B?Qkd0LzY4eGNpNzhXWHlYWTNzNG82c1VBWmpmQTB2TmtYcXFvLzZ3VFB6cmQr?=
 =?utf-8?B?Y1hLS0h5NkpLVnZkdURhWEozaWV5czB5SU1iUUIwWXhmb3U4T3Fsd0RBRy9V?=
 =?utf-8?B?aVFJOWpENlhNS3lDUDJYY0I0R24zTzFGS3FwN3grcUJ6bTMvaHhUZ3VDOFlH?=
 =?utf-8?B?b3h2MzI0LzgxdnpFZTZFa2pvTDUwdGZRaEgydE1aRkJwL0paNjBYcWpSZ0Jh?=
 =?utf-8?B?QnN4SEduQ2JPajgydlo2L1IvY1Y3OWFXbDRuL2RXQ09oc3lrOXFuMjQrT2oy?=
 =?utf-8?B?ZE1CS0VqblFKZzNMbFoyQm9JeUdBSy9IeGdYNU9HYmVQRC9QbmQyZ1RDc1Rq?=
 =?utf-8?B?YUU5c2pwY1hoUTJkbmQwY0hjWXNTVDUzR2d3UXRESE9DMzg3SGlXbGlxbXBD?=
 =?utf-8?B?cm55RWtsSWJNdTRlc3VPZ3g5VVJtK00rSTRVUE83VU5PdlJHN3dXY04zQjBu?=
 =?utf-8?B?QVcva1ZjZVRHT2hpbzdjclVieEhYOXR3MWs0U2l1YWQ4T2tZeEZSUDhCbmU5?=
 =?utf-8?B?R1JhNHFXdmVScjNYNGZMakFtMHJ2TWdVajZYalA5NGZqeHpBTjE3LzlhSUl4?=
 =?utf-8?B?b1g3NnZ4WU9PU1FHTFp6ZjlKR2JvVzVtL3JOMGQ5TE4yd2NoZzlIK0UrM0h3?=
 =?utf-8?B?RjFDa3hqcEtGU0lUalNwM2FmWExQbnF6aDJ6RU5PK05Za3JCbFF6dHhQdXM2?=
 =?utf-8?B?QXR6TkVjR2dWMUdxZlh1cjdxaVlpMHZMclhWSGlpNVBRRUNmSE5CcWlEU2pL?=
 =?utf-8?B?cEF3a2pNcVQ2UDI4eFhTdm0wc3BreldmMEFqek9CZlJHbFN6eDBVeTgwRFIz?=
 =?utf-8?B?YmhSTnlrc3BRNHNrWW0zYmM1eXNPQ3c3cHhFRW12TzlwdWZYYngrNzlGT1g3?=
 =?utf-8?B?bENOM1plTHovLzJZUDQrSmtJQmJSU1ZWTHV1UVVNQmhrYU90MDQ0anNXb1FD?=
 =?utf-8?B?M2o0YW5nZGNXWWJhNXhnZGV0WTl5YmxTcDh1VTNxSGpaMVNMb1JFS1k3OTlG?=
 =?utf-8?B?WGVNbm9SNVZSWlNjOTA2OG94Qi8xSUxXVWdGOS95K1lTNUhlUXZ2bGExMGpU?=
 =?utf-8?B?RlRZZlZBMkJNTFJTSUdaelJxUGdQVVdRdHJaVEZFeFhYcFR3eWR5bEZkM3k0?=
 =?utf-8?B?VU1jRGM0NVB4QlBFUzdsTDN5TkJCRm5rRVAwdWtwVGFnZ0NRTXo5M3J5QTBm?=
 =?utf-8?B?YVN4OVJRUCtNQnRWcy9NVFdTYzFCSkI5RnVHSk5GY21OZEtHU3JmUnZyMktD?=
 =?utf-8?B?TEhpYmI0dFd6TnFPMDhkeEVmeStLV3l3SHU5aXJpWU9HRE50aHZLQ1dDYldi?=
 =?utf-8?B?eXk1M3hTMkVhblRWMkdkcXF3SE4rS1AyaXhuYWx1ckk3QXBISFNVeWgzMkJk?=
 =?utf-8?B?K1pxMUF5WHA2ZHdpMTA3Zk95V2FHbVpiTVlXZmtJbVcrVnJRd1Y1Ynk4am9u?=
 =?utf-8?B?L2krNS9QR0hDV0pOYW13TXhCV0hNNURSQmtncUZWcXpabkFWMlh2NW42OC9Y?=
 =?utf-8?B?VWVYem8zcDJySVNBMUFYK1hjclpnbUFralMrQURtQnprblNJQWlwdlZidmNu?=
 =?utf-8?Q?3zWyECXQkhQOfQl2XYokv634P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: endava.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB8752.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7876cae3-c34c-4478-45dc-08dca58c8991
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 11:43:40.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b3fc178-b730-4e8b-9843-e81259237b77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iIt3erNAV+5aATovilNw6i7jKg8wzEQHzaaeJLZLy4B7MiHGpJSqGoUaJYAoGt7pA4mKokeNJMcfGRJIXvuzAQsNxDs9FpuuCZw8HaBNCrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6544

DQo+SSB0aGluayB0aGF0IGNvbnNpc3RlbmN5IHdpdGggb3RoZXIgdGlwYyBoZWxwZXJzIGhlcmUg
d291bGQgYmUgbW9yZQ0KPmFwcHJvcHJpYXRlOiBJTUhPIG5vIG5lZWQgdG8gc2VuZCBhIHYyLg0K
Pg0KSSBkbyBub3QgdGhpbmsgc28uIElmIHlvdSBsb29rIGF0IG90aGVyIGhlbHBlciBmdW5jdGlv
bnMgZm9yIHVkcCBtZWRpYSwgdGhleSB1c2UgcHJlZGVmaW5lZCBlcnJvciBjb2RlcywgZm9yIGV4
YW1wbGU6DQp0aXBjX3VkcF9tc2cyYWRkcigpDQp7DQogLi4uDQpyZXR1cm4gLUVJTlZBTDsNCiAu
Li4NCn0NCg0KSGVscGVyIGZ1bmN0aW9ucyBmb3IgZXRoZXJuZXQgbWVkaWEgc2hvdWxkIHVzZSBw
cmVkZWZpbmVkIG1hY3JvcyBhcyB3ZWxsLiBTbywgdGhleSByZWFsbHkgbmVlZCBhICJjbGVhbi11
cCIgcGF0Y2ggbGF0ZXIgZm9yIG5ldC1uZXh0Lg0KDQo+QFR1bmc6IHBsZWFzZSB0cmltIHlvdXIg
cmVwbGllcyB0byBvbmx5IGluY2x1ZGUgdGhlIHJlbGV2YW50IHF1b3RlZCB0ZXh0IGFuZCBmaXgg
eW91ciBjb25maWd1cmF0aW9uIHRvIGF2b2lkIGluc2VydGluZyB0aGUgbG9uZyB0cmFpbGVyLA0K
PnF1aXRlIHVuc3VpdGFibGUgZm9yIG1lc3NhZ2VzIHNlbnQgdG8gYSBwdWJsaWMgTUwuDQo+DQpJ
IGFtIGF3YXJlIG9mIHRoYXQgYW5kIHRyaWVkIHRvIGZpeCBidXQgaXQgc2VlbXMgb3V0IG9mIG15
IGNvbnRyb2wgZm9yIG5vdy4gUGxlYXNlIGdpdmUgbWUgc29tZSBtb3JlIHRpbWUgdG8gdW5kZXJz
dGFuZCB3aGF0J3Mgd3Jvbmcgd2l0aCB0aGUgbmV3IG1haWwgc2VydmVyLiAoSXQgd2FzIG5vIGlz
c3VlIHdpdGggbXkgb2xkIGVtYWlsIGRla3RlY2guY29tLmF1KQ0KDQpUaGUgaW5mb3JtYXRpb24g
aW4gdGhpcyBlbWFpbCBpcyBjb25maWRlbnRpYWwgYW5kIG1heSBiZSBsZWdhbGx5IHByaXZpbGVn
ZWQuIEl0IGlzIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIGFkZHJlc3NlZS4gQW55IG9waW5pb25z
IGV4cHJlc3NlZCBhcmUgbWluZSBhbmQgZG8gbm90IG5lY2Vzc2FyaWx5IHJlcHJlc2VudCB0aGUg
b3BpbmlvbnMgb2YgdGhlIENvbXBhbnkuIEVtYWlscyBhcmUgc3VzY2VwdGlibGUgdG8gaW50ZXJm
ZXJlbmNlLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBhbnkgZGlzY2xv
c3VyZSwgY29weWluZywgZGlzdHJpYnV0aW9uIG9yIGFueSBhY3Rpb24gdGFrZW4gb3Igb21pdHRl
ZCB0byBiZSB0YWtlbiBpbiByZWxpYW5jZSBvbiBpdCwgaXMgc3RyaWN0bHkgcHJvaGliaXRlZCBh
bmQgbWF5IGJlIHVubGF3ZnVsLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgaW4g
ZXJyb3IsIGRvIG5vdCBvcGVuIGFueSBhdHRhY2htZW50cyBidXQgcGxlYXNlIG5vdGlmeSB0aGUg
RW5kYXZhIFNlcnZpY2UgRGVzayBvbiAoKzQ0ICgwKTg3MCA0MjMgMDE4NyksIGFuZCBkZWxldGUg
dGhpcyBtZXNzYWdlIGZyb20geW91ciBzeXN0ZW0uIFRoZSBzZW5kZXIgYWNjZXB0cyBubyByZXNw
b25zaWJpbGl0eSBmb3IgaW5mb3JtYXRpb24sIGVycm9ycyBvciBvbWlzc2lvbnMgaW4gdGhpcyBl
bWFpbCwgb3IgZm9yIGl0cyB1c2Ugb3IgbWlzdXNlLCBvciBmb3IgYW55IGFjdCBjb21taXR0ZWQg
b3Igb21pdHRlZCBpbiBjb25uZWN0aW9uIHdpdGggdGhpcyBjb21tdW5pY2F0aW9uLiBJZiBpbiBk
b3VidCwgcGxlYXNlIHZlcmlmeSB0aGUgYXV0aGVudGljaXR5IG9mIHRoZSBjb250ZW50cyB3aXRo
IHRoZSBzZW5kZXIuIFBsZWFzZSByZWx5IG9uIHlvdXIgb3duIHZpcnVzIGNoZWNrZXJzIGFzIG5v
IHJlc3BvbnNpYmlsaXR5IGlzIHRha2VuIGJ5IHRoZSBzZW5kZXIgZm9yIGFueSBkYW1hZ2Ugcmlz
aW5nIG91dCBvZiBhbnkgYnVnIG9yIHZpcnVzIGluZmVjdGlvbi4NCg0KRW5kYXZhIHBsYyBpcyBh
IGNvbXBhbnkgcmVnaXN0ZXJlZCBpbiBFbmdsYW5kIHVuZGVyIGNvbXBhbnkgbnVtYmVyIDU3MjI2
Njkgd2hvc2UgcmVnaXN0ZXJlZCBvZmZpY2UgaXMgYXQgMTI1IE9sZCBCcm9hZCBTdHJlZXQsIExv
bmRvbiwgRUMyTiAxQVIsIFVuaXRlZCBLaW5nZG9tLiBFbmRhdmEgcGxjIGlzIHRoZSBFbmRhdmEg
Z3JvdXAgaG9sZGluZyBjb21wYW55IGFuZCBkb2VzIG5vdCBwcm92aWRlIGFueSBzZXJ2aWNlcyB0
byBjbGllbnRzLiBFYWNoIG9mIEVuZGF2YSBwbGMgYW5kIGl0cyBzdWJzaWRpYXJpZXMgaXMgYSBz
ZXBhcmF0ZSBsZWdhbCBlbnRpdHkgYW5kIGhhcyBubyBsaWFiaWxpdHkgZm9yIGFub3RoZXIgc3Vj
aCBlbnRpdHkncyBhY3RzIG9yIG9taXNzaW9ucy4NCg==

