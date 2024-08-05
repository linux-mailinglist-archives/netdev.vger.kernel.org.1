Return-Path: <netdev+bounces-115650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 895A99475C6
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA2C281427
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 07:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34097148FE3;
	Mon,  5 Aug 2024 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wTmm8dkh"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBFA146A8A;
	Mon,  5 Aug 2024 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841816; cv=fail; b=fGYqhgbwBNE0hA1izA+NS/4GXj3nBNjL5pbXaPnwYv/u0uj6PaMWUcU/E7zHS5Q1p6oAmyEF3Zh+O0wjJ2eZL5F+ab4o8hyTXQRXaKhuN87YVInoEYWbZmmePMl0lTp7hfCOSST5H4+CWQbO6DgTwhI56CKgdP9c22TbPs4eLc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841816; c=relaxed/simple;
	bh=hxh5A1CXVRvpueDHBZx/o1tQ6ckxZ47+xHIy4jDKJC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CxbhMUiU8e0V9IEU0SOZ2Td1LZXpfhrYgu6451L8fZu6Tue2ovcMouJxpUmBkUwZ+aYTrgBrALQIy6DcY4CjxXkDlWfDE8wF4uEyT+Yl6hiiNNyyFjGoPLwbKZKzQ1RDsYwmRvYDd0xbYJREHcb6p0tAaJ11iKxt0IuKwpSePIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wTmm8dkh; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4er3Eyncxbi6r40aJbyB+L/ckQ6sqmD+ny7Y2AP4Z38E4LqJKH92GDqEMggx5N4/n4piN+3QuLDbZSrukQYa4qhpcqQseFkkAhnbi8kSO5H34loC527yYTq2V8hxTzSPz5DcOHwoXEdCgSkrIQ7AOVtqNLDEUpSFWr5qWdBQkXZnXBaF5xBPj1kwB14jxZIWXFxXtkDOjxMcUDeupRlwyrH9sTdLWjQ3RW4NHl5k0PeP4MO7YKI/r3KYHLcH0N6NN/YXhrXIprcVOX3SnA9Sv+Yyr5QGR0QrHLQlgKiG1Kjfpa5knPiZAaIgXbJasCXgTbdZeBBts3k9ae1tNGqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxh5A1CXVRvpueDHBZx/o1tQ6ckxZ47+xHIy4jDKJC0=;
 b=yBFZGGCKjs18rFgDZNUoOU2E87N6OqqY8GYqXbKkeNDAOZqVRJMK/rQer1D5FmcthqDh5PDA0IbW2gliajdBO1q/vgDuG4PO0/KfEMp86z+1zGUb9dyx0peSSTV1hAbI/JdrBk7fegn9it9lWwRr2plz8dMjpPZMD+Jz9AahBvKgz8QTdaFBf5HQx1Vuc1QvK/2CsUJ8UE/0ErGjkOWFwHm2Oqa5zjpdSkTx6TWCgHZs/bYyjemoAlslnglO3v1u0YZ3Pow8Y1kVeMXadyj8z2MqLwZxcaBgInM0v5xxMucDbJYwuhrwfAlHpcfT3KNqLlEFHY1EMPmOi36Kyy/3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxh5A1CXVRvpueDHBZx/o1tQ6ckxZ47+xHIy4jDKJC0=;
 b=wTmm8dkh3qNmSXfCXEkV5DsE43lyiSKcI5H7VR2DBwNgQ7D+6gLU3A5VebKhq80Ip9Jd0cpnYtblyzjiBFTCDc/qMEAj5h95H4DRRW13Y916gm/KbL6rwc9gZILfMACyYudNxhs7YdKvjFJhjABrAkJw/nnpml4JbLFG75vjMAmwXz4iaKh4wQyFdffmhjv+jFVnUYdn+lAHKxSTTSFiVuIs82EU4hgN18Q7DpFXvU6JQbZN+nqhjRVZDO4HxS311QHeOVJsmtZJlAyEEL1oCWgyT6Wq+VNdvzfup8mIbjQ7zhGrNmJDZ/g08JCSs6q18OtIJ2BI7iLIM9MMi5jMUQ==
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by AS8PR04MB9111.eurprd04.prod.outlook.com (2603:10a6:20b:44a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 07:10:09 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27%4]) with mapi id 15.20.7828.024; Mon, 5 Aug 2024
 07:10:09 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Jan Petrous (OSS)"
	<jan.petrous@oss.nxp.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: dl-S32 <S32@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 3/6] dt-bindings: net: Add DT bindings for DWMAC
 on NXP S32G/R
Thread-Topic: [EXT] Re: [PATCH 3/6] dt-bindings: net: Add DT bindings for
 DWMAC on NXP S32G/R
Thread-Index: AdrmrOTtkwWMBqX8SE2obTTIuZV8xgASOM0AAANymxA=
Date: Mon, 5 Aug 2024 07:10:09 +0000
Message-ID:
 <AM9PR04MB8506FC5070BEEE98400247B0E2BE2@AM9PR04MB8506.eurprd04.prod.outlook.com>
References:
 <AM9PR04MB85066A2A4D7A2419C1CFC24CE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <059e0b5e-7893-4c67-89d6-77c7cc87eccc@kernel.org>
In-Reply-To: <059e0b5e-7893-4c67-89d6-77c7cc87eccc@kernel.org>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|AS8PR04MB9111:EE_
x-ms-office365-filtering-correlation-id: 8fce0c1f-a1f6-47c0-f831-08dcb51da441
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFMrdmhTNEtiTTU3TW5hWDZ3cVA1Q1hmeFoyRDRvRzRTWXNnTjNnY1Z2eGpx?=
 =?utf-8?B?U2tEWmRyRzFCOXRYNWl2ZEkzNHY0NTY1ZHZjWnU4V3k1bjJzdlRVdWR4bm84?=
 =?utf-8?B?SzhndFFGQkhBb3VVdkhic3pYZGx2a1hXeDFmRk13dUpmTnZnRCtuM0tnM3or?=
 =?utf-8?B?WGkzUGJCL3ovbHpwMXRvemtLaDhjOExrK29HYlErRjk0cjNxZzFycWxsVmZy?=
 =?utf-8?B?N25mK0NXZWtFc2ZTaExuYzkvc3dEbTZ0Ny9MbDA1MHErY0s1VWhZSFdwV05m?=
 =?utf-8?B?SmtEazF3RmJabXgveDQyUGhZTVlYYXgrMTNJdmhRMG1pOVVTVit0MDJ3L0Nu?=
 =?utf-8?B?UjA2RzIwM3F5L0tmYmNBcEQ5cW9yREtLL0tIcmMwdVo2aDVjem1GRDVOUDlU?=
 =?utf-8?B?eStZUHJlVDkzT3pTUzNUK2FDZ3p5Q2lPOVFna0xGZHpWOWo3TlhIVUFLTzU1?=
 =?utf-8?B?N29UUlhVNHY3aGd0Q0NWK2tjZjY4STZ5K00zVnpLWDRRd2R3L2hyeEJIcEtW?=
 =?utf-8?B?THVLSXpTZmp0eTNuY20xMmR3L0tvUXJ2RUNVdVhtUFRNRVM5eFQ5UFhEZWkz?=
 =?utf-8?B?ZnJ1TEI0QmMzZDVBUFlNQnBFWXBRdDdMeklpZ0lBY2NrbnBPR3Q5SkU1b1JI?=
 =?utf-8?B?dXZHem9jTE4vTEt1RTRJdTQvdlBHd1RjK3ZpbzgrNnMvUG5JM3UyQUFJOTRC?=
 =?utf-8?B?R25PZUdzb214Vm9ab0NLWHRXclg5ZU1wYjRxWkEzcmhmTG5NekV6VmttZVo3?=
 =?utf-8?B?bDhlU08xQ1IycWhHakF2NW1tSUZlbmkvSzllS1JaTk1XdXJtR25tSTVCOUh0?=
 =?utf-8?B?SVNCaWVlWjg0N1ZNdnNacXgrd3E0djRMRXBTc21Qa3dhVzNxRU5heTc3MzBz?=
 =?utf-8?B?V3g2R2NObXhlWWhicnQ1VkRLVVJUUkg1RjQ1bE8yNEJrdnFLUU1XY3h0VTR3?=
 =?utf-8?B?Vkw2SDNBajZid0k3eU9LRGx5aEhsNFdzMHJFbW5scTBsKzdCdnFvS0ZXY2E5?=
 =?utf-8?B?Vy9pZEc4VVIwMVRWYkdGRVZCK083RDBjaHVzZkpKSWdMZ0tHUE5zUkxwUXdu?=
 =?utf-8?B?aG5LZ1hIVmZXZHhTRkNEKzlnRkMyTWttKzBWRTlwdEhJQ1QwYUQzbjVMQ2dF?=
 =?utf-8?B?dmZQN1kvSjVOV3IzYXdYUXRva0p0eU81aGkvbkVOYURZNU5uYjZDaWxCRlcx?=
 =?utf-8?B?OTF2dFo2aDlBR3ZOOHVqaEFFU2ZYdjRpdGlvQlA4STlMM3Erb3pPcGc0aks0?=
 =?utf-8?B?UGpYL3FsQUJZSlkxaE4zM1JQSTFUYTJIcVNZc0NxVjd4N0tVNVZJQVZFWWl0?=
 =?utf-8?B?NFJCYXBDa1N0Wjh4VUE3VGc5bGdteEhyUEt5TTV6Y0FYcjkrdEsxc0lCUmNa?=
 =?utf-8?B?ZWJ3cWhTS2JFZ3gyTU9ndCt0SHlZazAwRElOakFkbWRFb1krR1hlbFg2OW5u?=
 =?utf-8?B?YnV6RXBkMEwvLzV4cXROd2JuNzhLT3poeGRNSXRnMDIxSFhtRmVnWW5zL3Vl?=
 =?utf-8?B?alJKS01RM1BBbFEyWExWWHpLYVhNaU1IZysrbG1kcHhUZkVYUy9vMm8zeXJu?=
 =?utf-8?B?eFdkMFRPMGY1cUVDbDhTQ0VTMmtESmdHWU8vNmJGZDJTK3dvVG4zN0prUWFQ?=
 =?utf-8?B?dkVVQUF4VHBLNUF6ZTdnSkpZc1RXZkcweG5OVWN0ZTBJTEdTcFRzSm1tSkhK?=
 =?utf-8?B?ZGlNSkZaSmdXTmJzS3lUdnhwN2R2aWt5bnBrN09ZQ2VHTzRGRVFFQncxRDVQ?=
 =?utf-8?B?c0oveUlZRkpoYmp2WFpQc2hzdktZQVZudXRybGtQVlY3VDlvVlk1eEdOQXdY?=
 =?utf-8?B?U3B3a3VkSXNlR3lpSXZxWGRVVzJPVWxJb2I1engzbVRneEFlSW5wNkNFdXlh?=
 =?utf-8?B?Ukt0bHVzdzVSR3BPbEpSYjNvKy93T3M2QTVIRE1mOFFPRnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym9UZU1uMnA1Tm9nU3A2YjhmVDFjQnh3bFUzb2M5OEF5L3hnQ29HU3pRRnkr?=
 =?utf-8?B?SzFjRloyWDVzUEZmYjRoa3JCOENzT1YweklCaFRQS3ZuNE9RNWtXUVhYUHg1?=
 =?utf-8?B?V0VTVVVwL3FBcnBKQlZ0V2IyamlDL2Y5ckRVeVdvNllHbnptUDkxT0ttVk9m?=
 =?utf-8?B?LzRmSklBYVYrL2ZaamNFNEwyN0lUdUdidjJ2VFM1UDg2eWxZMDR2YnNNQnE2?=
 =?utf-8?B?TE9MQ1BqOUluL0EwN2FiY0ZaZFhWY09OL21ibWZDek1DME5teHVwOTFBYXlN?=
 =?utf-8?B?UDdCOXkxTUxsVkw5eURYVTdyTHFNUGErVktRbDlTVUFCYXplM2x1UFlZaUs0?=
 =?utf-8?B?WmFURlJYeUVBVjRvVENOc0FScFRJUUFDdnZ4UXFrTmRJZW1ZVk9HTzU4UU9G?=
 =?utf-8?B?dVc4VVlHbzNiRmJld2lmazAvL2QxajF3cGRwME1tRFNVS3hRVmw4aDU5UXdi?=
 =?utf-8?B?eWl5bUNCazBNdXRjV3h4ZzlJQU1iamc3SkdaUU9rQSs1V09PajdvVjRSdE1T?=
 =?utf-8?B?RVJTd0xGZEtCTU1EaGZIbTVjU1FVS3NXbnhXcWZUWE1WME00alYySXpuWFpV?=
 =?utf-8?B?aGt0THhYNWU5cnVhZEo2YysySUIzRkEzZVlXUkJQVWJJZmZaellvNEROMzlt?=
 =?utf-8?B?OUxKZkhxZko5MFZqdDlIRHpMUWJMeVd0Q3lNekVjRVVhTklPaHhxK0htencz?=
 =?utf-8?B?cVltNDNaSDlhbW5lV0FUd0NnY2V4aDdLZXQzTmhxRlo0ZnhmazFqWC96Yyt6?=
 =?utf-8?B?MzdldGNKRkZhUStZcnNLeURDOE1GdXA3cFpxTEl2VWdhQ3dIVVJ2K3h3b3Qv?=
 =?utf-8?B?UW02MXlDa09QZzYvbU90TDNDajIvTndibVYwRXFiNGtZS2J0eS9ob1BwemZI?=
 =?utf-8?B?ZGtHMUhPeU5nUmxwTGFnNGY1R2VKMzNoSkVwSHpYRVZwVnVXOG81TW1qbUpl?=
 =?utf-8?B?VUZDUHUxSkc5aDdNaHBNc2ptb3F2eEtiaDdZTS9ReGFzWThVRXhqOGNJQkJZ?=
 =?utf-8?B?Kzc5c29TeXM1T3dObjVIczFFVEVBY1hKQmZMdGFockEvRUhOcEdxblFiakoy?=
 =?utf-8?B?a29VRWYzbFlPNXRDSGhQZ2R4MHBNMWN4QjJ1NjBaemwzNUV3ZU9JNXJteUx3?=
 =?utf-8?B?SHQzZXEvVDZzeXpNQnhsUjNNK2VTaWR0aE5kRHdmNnJCT3MzaDVvV0ZTS09h?=
 =?utf-8?B?WDZpeVpJRmtvT2ZkbEJnQW03YXEyNUlvelBsT293aHBEL2hJZHYxc3hhRC8w?=
 =?utf-8?B?a0NtWmdUUVErbjhnUEJUNXB3Y0NTM1Y5TmEveTJ5OVd3TFYxOUVrOWladFFB?=
 =?utf-8?B?ZXloaC9lczlXMk5NOHpaaFFkYmRuTGVzK3hqTklWYzBsSDBMSUI2Sm84di9R?=
 =?utf-8?B?ZjM1Q09iK2VmaWVsVDVHd1E4bHBmeW53WmY5VkVDc0JJSXRhakNlMmdpRWhF?=
 =?utf-8?B?N0JzcVFBSjZDT1lEQXR1bU5xbGx4dDU0ZDg4VitSMnJjNGZ3YzVGOUVwUzNq?=
 =?utf-8?B?NW9EZmkyNE52YmxTa1d0dDdhRlhRcHdWelF5eHEzNUJDS2RkV2VLRThlOFN3?=
 =?utf-8?B?V25OZ29rV09peXZST1NKbGdrQVVZYi82Ri9Ia3lZREZ6NTlldHg4WlpkSC8r?=
 =?utf-8?B?elZIT1BaZERDaXJIMjBhZjNNYS9lOVJoa0lYS25mZ1UxSUVqWG1YZ2MwM2Vt?=
 =?utf-8?B?eG95elZKY0hEcXJyNElNVkd2L2VlM1BFZzZkWVlGWVF5b1NKak15WUt1WjJ2?=
 =?utf-8?B?N1V4MjY5aHlkdFJldU40SHB5VEcvalJDYUpjeGsvZld5SkU3bnRFWEJLbGp0?=
 =?utf-8?B?SzhyMFhzdS9NL1NlQ2t4MlpkeVRxODlxK0VIbmdEWStsdlZTU1RCVjduV01z?=
 =?utf-8?B?ektGbE4xOTRaMnV5aGJyWkNWQ2xDN2tKSHhneG5ad0NYdm9sUEwwR1FRODI5?=
 =?utf-8?B?c1JYbGF3aUVYblp2MjMrUjVxUFBNM1FmY1hWL0xHMG5adnpPa056SlhNREow?=
 =?utf-8?B?M1liZ1MrS1dFdGc0YWh6b2JVOW9HYXBvaDhIZWliNURnYnNpMmtMQUdXMlJB?=
 =?utf-8?B?MzErTHkwM0ZFckYrWmY5bTczczgwK3RkUUVqdnRkNmdiWmlETXZmbElqV2Mr?=
 =?utf-8?Q?W+fjVUr8YWF3kR90Ei9qtIRSz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8506.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fce0c1f-a1f6-47c0-f831-08dcb51da441
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 07:10:09.3649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXr7Mon8YvpSiY5tWSyEoeVGR15OVhT6j88NrpdcvbmRgjL9BEl9TvA34DYF22H+vxsWaz/h5/tj4n6gr/zb9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9111

PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1v
bmRheSwgNSBBdWd1c3QsIDIwMjQgNzoxMA0KPiBUbzogSmFuIFBldHJvdXMgKE9TUykgPGphbi5w
ZXRyb3VzQG9zcy5ueHAuY29tPjsgTWF4aW1lIENvcXVlbGluDQo+IDxtY29xdWVsaW4uc3RtMzJA
Z21haWwuY29tPjsgQWxleGFuZHJlIFRvcmd1ZQ0KPiA8YWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0
LmNvbT4NCj4gQ2M6IGRsLVMzMiA8UzMyQG54cC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1zdG0zMkBzdC0NCj4gbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbTsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBDbGF1ZGl1DQo+IE1hbm9pbCA8Y2xh
dWRpdS5tYW5vaWxAbnhwLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
W0VYVF0gUmU6IFtQQVRDSCAzLzZdIGR0LWJpbmRpbmdzOiBuZXQ6IEFkZCBEVCBiaW5kaW5ncyBm
b3IgRFdNQUMNCj4gb24gTlhQIFMzMkcvUg0KPiANCj4gT24gMDQvMDgvMjAyNCAyMjo0OSwgSmFu
IFBldHJvdXMgKE9TUykgd3JvdGU6DQo+ID4gQWRkIGJhc2ljIGRlc2NyaXB0aW9uIGZvciBEV01B
QyBldGhlcm5ldCBJUCBvbiBOWFAgUzMyRzJ4eCwgUzMyRzN4eA0KPiA+IGFuZCBTMzJSNDUgYXV0
b21vdGl2ZSBzZXJpZXMgU29Dcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbiBQZXRyb3Vz
IChPU1MpIDxqYW4ucGV0cm91c0Bvc3MubnhwLmNvbT4NCj4gDQo+IDxmb3JtIGxldHRlcj4NCj4g
UGxlYXNlIHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0IG9mIG5l
Y2Vzc2FyeSBwZW9wbGUNCj4gYW5kIGxpc3RzIHRvIENDLiBJdCBtaWdodCBoYXBwZW4sIHRoYXQg
Y29tbWFuZCB3aGVuIHJ1biBvbiBhbiBvbGRlcg0KPiBrZXJuZWwsIGdpdmVzIHlvdSBvdXRkYXRl
ZCBlbnRyaWVzLiBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1cmUgeW91IGJhc2UNCj4geW91ciBwYXRj
aGVzIG9uIHJlY2VudCBMaW51eCBrZXJuZWwuDQo+IA0KPiBUb29scyBsaWtlIGI0IG9yIHNjcmlw
dHMvZ2V0X21haW50YWluZXIucGwgcHJvdmlkZSB5b3UgcHJvcGVyIGxpc3Qgb2YNCj4gcGVvcGxl
LCBzbyBmaXggeW91ciB3b3JrZmxvdy4gVG9vbHMgbWlnaHQgYWxzbyBmYWlsIGlmIHlvdSB3b3Jr
IG9uIHNvbWUNCj4gYW5jaWVudCB0cmVlIChkb24ndCwgaW5zdGVhZCB1c2UgbWFpbmxpbmUpIG9y
IHdvcmsgb24gZm9yayBvZiBrZXJuZWwNCj4gKGRvbid0LCBpbnN0ZWFkIHVzZSBtYWlubGluZSku
IEp1c3QgdXNlIGI0IGFuZCBldmVyeXRoaW5nIHNob3VsZCBiZQ0KPiBmaW5lLCBhbHRob3VnaCBy
ZW1lbWJlciBhYm91dCBgYjQgcHJlcCAtLWF1dG8tdG8tY2NgIGlmIHlvdSBhZGRlZCBuZXcNCj4g
cGF0Y2hlcyB0byB0aGUgcGF0Y2hzZXQuDQo+IA0KPiBZb3UgbWlzc2VkIGF0IGxlYXN0IGRldmlj
ZXRyZWUgbGlzdCAobWF5YmUgbW9yZSksIHNvIHRoaXMgd29uJ3QgYmUNCj4gdGVzdGVkIGJ5IGF1
dG9tYXRlZCB0b29saW5nLiBQZXJmb3JtaW5nIHJldmlldyBvbiB1bnRlc3RlZCBjb2RlIG1pZ2h0
IGJlDQo+IGEgd2FzdGUgb2YgdGltZS4NCj4gDQo+IFBsZWFzZSBraW5kbHkgcmVzZW5kIGFuZCBp
bmNsdWRlIGFsbCBuZWNlc3NhcnkgVG8vQ2MgZW50cmllcy4NCj4gPC9mb3JtIGxldHRlcj4NCg0K
RG9lcyBpdCBtZWFuIHRoYXQgc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCBkb2Vzbid0IGNhcmUg
YWJvdXQgZGV2aWNldHJlZSBNTD8NCkkganVzdCB0cmllZCB0byByZWNoZWNrLCBidXQgaXQgc3Rp
bGwgc2hvd3MgbWUgdGhlIGxpc3QgSSB1c2VkIG9yaWdpbmFsbHk6DQoNCiQgbGwgb3V0Z29pbmcv
Ki5wYXRjaA0KLXJ3LXJ3LXItLSAxIGhvcCBob3AgMTk5OCBzcnAgIDQgMTE6MzMgb3V0Z29pbmcv
MDAwMC1jb3Zlci1sZXR0ZXIucGF0Y2gNCi1ydy1ydy1yLS0gMSBob3AgaG9wIDI1MTggc3JwICA0
IDExOjMzIG91dGdvaW5nLzAwMDEtbmV0LWRyaXZlci1zdG1tYWMtZXh0ZW5kLUNTUi1jYWxjLXN1
cHBvcnQucGF0Y2gNCi1ydy1ydy1yLS0gMSBob3AgaG9wIDI3OTQgc3JwICA0IDExOjMzIG91dGdv
aW5nLzAwMDItbmV0LXN0bW1hYy1FeHBhbmQtY2xvY2stcmF0ZS12YXJpYWJsZXMucGF0Y2gNCi1y
dy1ydy1yLS0gMSBob3AgaG9wIDQ0Mjcgc3JwICA0IDExOjMzIG91dGdvaW5nLzAwMDMtZHQtYmlu
ZGluZ3MtbmV0LUFkZC1EVC1iaW5kaW5ncy1mb3ItRFdNQUMtb24tTlhQLVMzMi5wYXRjaA0KLXJ3
LXJ3LXItLSAxIGhvcCBob3AgODYxMCBzcnAgIDQgMTE6MzMgb3V0Z29pbmcvMDAwNC1uZXQtc3Rt
bWFjLWR3bWFjLXMzMmNjLWFkZC1iYXNpYy1OWFAtUzMyRy1TMzJSLWdsdWUtLnBhdGNoDQotcnct
cnctci0tIDEgaG9wIGhvcCAxMTQzIHNycCAgNCAxMTozMyBvdXRnb2luZy8wMDA1LU1BSU5UQUlO
RVJTLUFkZC1KYW4tUGV0cm91cy1hcy10aGUtTlhQLVMzMkctUi1EV01BQy0ucGF0Y2gNCi1ydy1y
dy1yLS0gMSBob3AgaG9wIDE4MDUgc3JwICA0IDExOjMzIG91dGdvaW5nLzAwMDYtbmV0LXN0bW1h
Yy1kd21hYy1zMzJjYy1SZWFkLVBUUC1jbG9jay1yYXRlLXdoZW4tcmVhZC5wYXRjaA0KJCAuL3Nj
cmlwdHMvZ2V0X21haW50YWluZXIucGwgb3V0Z29pbmcvKi5wYXRjaA0KTWF4aW1lIENvcXVlbGlu
IDxtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tPiAobWFpbnRhaW5lcjpBUk0vU1RNMzIgQVJDSElU
RUNUVVJFKQ0KQWxleGFuZHJlIFRvcmd1ZSA8YWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbT4g
KG1haW50YWluZXI6QVJNL1NUTTMyIEFSQ0hJVEVDVFVSRSkNCiJKYW4gUGV0cm91cyAoT1NTKSIg
PGphbi5wZXRyb3VzQG9zcy5ueHAuY29tPiAoY29tbWl0X3NpZ25lcjoxLzE9MTAwJSxhdXRob3Jl
ZDoxLzE9MTAwJSxhZGRlZF9saW5lczo0Ni80Nj0xMDAlLGFkZGVkX2xpbmVzOjYxLzYxPTEwMCUs
YWRkZWRfbGluZXM6NjkvNjk9MTAwJSxhZGRlZF9saW5lczoxNjUvMTY1PTEwMCUsYWRkZWRfbGlu
ZXM6Mjk4LzI5OD0xMDAlLGFkZGVkX2xpbmVzOjM1LzM1PTEwMCUsYWRkZWRfbGluZXM6NTEvNTE9
MTAwJSkNCmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgKG9wZW4gbGlzdCkNCmxpbnV4LXN0
bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb20gKG1vZGVyYXRlZCBsaXN0OkFSTS9TVE0z
MiBBUkNISVRFQ1RVUkUpDQpsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcgKG1v
ZGVyYXRlZCBsaXN0OkFSTS9TVE0zMiBBUkNISVRFQ1RVUkUpDQoNClRoYW5rcy4NCi9KYW4NCg==

