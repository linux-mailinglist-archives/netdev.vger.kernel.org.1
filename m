Return-Path: <netdev+bounces-191038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7445AB9CE8
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C234E188F3F5
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB68B242909;
	Fri, 16 May 2025 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="kwE5F62t"
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022081.outbound.protection.outlook.com [40.107.149.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00C24166A;
	Fri, 16 May 2025 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400830; cv=fail; b=hVfF6A2CM8dQD0WsHBXTiiED88Qq6TaDbGDtXLODnKw0CA33lbRWZjng4inQ83GSrZyghPXKNXvRvRtH/LnETm2JfnNLomkCwTM220aN8FH0HbYaP+OhoGXq1m50EtmtOaLMjYZsSBR7QukCB783L9EIeAcSoGyVZna84Kzy4X4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400830; c=relaxed/simple;
	bh=G96AaRLti8hTFqISskf/VyO2Wz54JOJ4NRnbhN5Y26o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FBmksYWosZkYzrB55Xa56/+9c2KFzNY6Y+lT6RLZZ881JzX1txXpPFkWQmrmf2SOWWlJg2ufJ/4Chj3YkyY0GDxQcMPknVBaKVEjBJqUFnfDhmayot7MbNp49sA1z56c3AjAN/ZxIeNys1Ch1aUFVaK1W7pgXo0wwaGbJrhPhGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=kwE5F62t; arc=fail smtp.client-ip=40.107.149.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgziBrMw2V6L3pd3GgzwcnFk4iGO+jMypAjxfwWmCRNynfWRpFVrpxDcOQWdrqIs+UAKywB1wQz2JlATgzMbRrGlxoCTHLF7e+/ICu19imF8PiXrAJ/Wf0vPYpMDT3oCvl+uzLp/s+m1eWa91KHCwivlQzBH2iC20/HOjTf8XIziOSi62oa8iK5259Zd56H7akL0Pv5pHJtIKAhSbudy+G6qMgjT/3J7I1ymE9nJfWjX24rfS4wlhzhAFEIz9zYyM0hfW4zElp7pN646CZJK6xkadJoPBLOcOOzJBXJNWZE++YRgsnjUbp6f+xM2rBOq0i6/tdDX76/0RA40u6gafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G96AaRLti8hTFqISskf/VyO2Wz54JOJ4NRnbhN5Y26o=;
 b=tqL2xV/HKcI/few91fQe8zvMrAtnP1NLmI1faawQjwNcZdkVaVXfNposIVel0GS7HBztLTg3DfFHziK1oRgar9xF2ULq7+fQNKjmsuuDOyygjoXYYQTAQvkM3rZOlvg8C+xcpBwMJ7y+jO4uXM29ySdeWLuPRex22ea+g3S0ZJRuB19vhAIRC9jcyfWRNXcw657xMEFH93F2tcwwmg3W6RLnnGUk/o2hXyBHf7cBlR/luSebfeVmPv8tgAZpZsZ4+EACglqyJOzDrl+jDSeqeNA3XCzsCNOiKKjbMH+zXJt7pvoyOgPo4vUte5kMLAPpw3NddgXeT+0FOOM81vcALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G96AaRLti8hTFqISskf/VyO2Wz54JOJ4NRnbhN5Y26o=;
 b=kwE5F62tKcJfBjUajGOBjAmsQR5MzajyJvjkdQaMyim7EG/jt4Zy6uFQ3LNtTahzeyb2+68+2qf3ezQasJG3ztNiq5YVF5lsQIGoDMtiP/N07VlAgFGX2pCG/82xo1PIKGq5WUndyLqxxHxN0v+8NG/4DuzojATxBGzZNFIIcwg=
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:43::5) by
 FR3P281MB1742.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.32; Fri, 16 May 2025 13:07:05 +0000
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192]) by FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:07:05 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Piotr Kubik
	<piotr.kubik@adtran.com>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd: Add bindings for
 Si3474 PSE controller
Thread-Topic: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd: Add bindings
 for Si3474 PSE controller
Thread-Index: AQHbxmNsH46rcwgzkUSJtawtzZaElw==
Date: Fri, 16 May 2025 13:07:05 +0000
Message-ID: <ebe9a9f5-db9c-4b82-a5e9-3b108a0c6338@adtran.com>
References: <f975f23e-84a7-48e6-a2b2-18ceb9148675@adtran.com>
In-Reply-To: <f975f23e-84a7-48e6-a2b2-18ceb9148675@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2224:EE_|FR3P281MB1742:EE_
x-ms-office365-filtering-correlation-id: 5b5419cb-c255-468f-823d-08dd947a8eb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFVJNkNKUUVtU2djRll6MDBJY2NVZnFyWTVnN3JGaTNoNU00S0M2ekxiL1Rh?=
 =?utf-8?B?azc3YVpkeEliNmRQNjBmRFFDQWk0RVBHVnUwRkFTR01URWVYemMzbGtOYzlv?=
 =?utf-8?B?M2RwdXgyVXJRR2M5RSt2cW1WR043ay84eGhVeUdYKzdEQ2VzWGh5bGlUSTRp?=
 =?utf-8?B?NUt4YkdZM3diZ2JnajVzSisrQThsV2t1ck5paTFtUlljZHhMaG1oWENkdEls?=
 =?utf-8?B?SFREK1g4SWQ5YXJQYk41RW9wMDJ2R25CU2o4bkNISXRVMnRuK2gzdGhGY1hU?=
 =?utf-8?B?QUZseDlTcXRrVGVMczZ5aTc5ZlpvVFZEMk14OVMyelJUVmpWdnN3RUM4Y1lC?=
 =?utf-8?B?NWF4amNBMXNSQk1FazluaHBNcVJENDR1Y0JlV1A0bkIwY3daR2N3SW5NcGto?=
 =?utf-8?B?MXkrMHVVUnVGUXBjYzhIRjhFaU5JaVVnU0ZLWk43S3BoYmtxaExpTUIwOXNE?=
 =?utf-8?B?cDg5bThCU3QrazZyWWR3eWpoc3NFb2pQdVAvdHZZNXFobjZDVEJ1dlJmdWtC?=
 =?utf-8?B?THdIek05WUh3ay9XcDFxMThLVnN2SDJyWG1rWGxsTHRVZEhEOXdTTmpiZGpY?=
 =?utf-8?B?b3ptWThKMWJkTXRqcHVqMXA1N1BMMlhsalFvZ21yMDYxOE1mb09oc3Y1MGo3?=
 =?utf-8?B?UEsvWUREOG1tNzQ5Ty9VRGw4VnF3cVR4dVo0dmJ6VU5rV3NKd2xtT3FJTGE3?=
 =?utf-8?B?eUl6bytEUkhRMERnNEM5Z3hEQ1VIOTdIMFczc2theURHblFPdHRUMXhFY0M2?=
 =?utf-8?B?SzdhMFV0TVBWblJDZU9MVlplYkJqamVIdkQ5eUNjeSszdGFDM2IxZDJaS0ZU?=
 =?utf-8?B?a3Fvb0RhSTRERmxpaXYwdUdLUVBZdk5JdFJMU3BQNGxoV3h5bEo0Wmpkc0xF?=
 =?utf-8?B?V3VUMXVsUHU4VUt6bHZ5a25qTjd5YW5WMWJLeFlGMVBhdnI3ejVlVnR4S2xw?=
 =?utf-8?B?R2l1emxlQk9pM1dUZG5FRTN3STROY1lCVUl6a3FGN3lXQllIRFkvNmhkbFRV?=
 =?utf-8?B?RnExNWhVcjBtUnk1K0RPdWs0WUxVWmdUalhoYkpEWnpxZkJEVnBSekJJek5i?=
 =?utf-8?B?TzZiVCtGd2c3MmNFZ1FMWVV0dXhmbUdhREtyVTN0Q3UzRzJ4YnQ0TjhZTUZP?=
 =?utf-8?B?MEZxUzR5OGpTeXd4d1AvZDUwY3ZieG1DK3pyQW45enNrQ2orRG9RQ2tuYmty?=
 =?utf-8?B?Ykd5SnZoT2h4bnJqMVhqN0dqaG9GaVRBeGNXYU5LWXZlajFUZDNMR2hDOVhF?=
 =?utf-8?B?U1RpUDYwNDN5a0NHT1U4NmVZajZ1SEJKRXNjUGpMcTdDODdzMTN4ZVVXTVIz?=
 =?utf-8?B?ZjZyam5yZFlXT3dTdk53UTNnalZrYXVydGNKUUk3THJhbjNIUytFY0E0ejlQ?=
 =?utf-8?B?SkxKOTR6ZTUwRDJzRUxCY3ROc2QrQmRROGNHS0l5Tmh6OFBvUzNtWTc1cTgw?=
 =?utf-8?B?M21LeWF1YWlKQm81Nkljbm53SzJubXBxYjNyenNpNjBYTjI0aVpoby9CckVE?=
 =?utf-8?B?VUNnT0Ztb09zdEc0dExDUHY0UkVqTDBuRDY2K3hBbmxiNTFISjNFeGJwOGdU?=
 =?utf-8?B?YlBTVTZxZ0VUd0pDR0FtWlQxUzNHd1JwaGQvQmJuRFl2OXFDMitQN2ZhZXdh?=
 =?utf-8?B?WUpTSmVMNHBFbTZXY1JHbjZHRlFWQVVOSVZ3WE42UGdiYWJjZkFUM1gydE0v?=
 =?utf-8?B?M1kvbWF3ckQyVFl5UHB1MFlsL1F3NURkTVRqTTh0UlRJMWZRWmpzZDVNdTRP?=
 =?utf-8?B?OGVHUCt4OG1PcmlUNWRzQlF3TGFjbC9mYWNZVkkvZ1MrQmIxUHZtSVF3SnNh?=
 =?utf-8?B?cVg1MUJiemdmT3Y3eGFmVDJsL0REeS91U3dOY2hRd205Y242YU1GaFdNaHMr?=
 =?utf-8?B?ZU1BN3FwVVZzUEpzWVRVaGVLL0FobzFrcENXRkpTYTJlVGhNOVZkdFpPM1gx?=
 =?utf-8?Q?ephb23lNb1PAef9SkcD8NKL720y+n+0+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVIxWkgwdndEWUwzR2lwUTdkZzVoZUc1RHcxY3kyNytKVTJjVXM0akdXa1or?=
 =?utf-8?B?c0ZmSnlCZHlrUEI5eVRFaXFZb1Vxdnc5cVlXVFBjNExQTzhyd2NrS0w2cHBa?=
 =?utf-8?B?YjNINDV3SE9pZHFNZitHL0o2QThwUjJybjNzRUhiZmg5NWJvL3hMSUgzVVMy?=
 =?utf-8?B?anh1ZHBlb1ZaaDBMK2VYbDdDUWxucDc0Q2xHamZRNUM5K2pCbVhmWjR1MUZ1?=
 =?utf-8?B?dkRUWkhxNnRvQ3A5TTBqSGdQV3hTVzlEbmdLQzE5OHkzdkpKaVdmNTVnS1pQ?=
 =?utf-8?B?ZkxDN1lwV3BWMWlYUnNJL0YwbURkVjFHMTcxTk5jSzlvaSs1c2ROL0JRK0NZ?=
 =?utf-8?B?ZVdaV0VvN3o4Umd4dHBTYURld003MlBOUHRQMWpMQ3NnelhkUnhqeXd4WDMv?=
 =?utf-8?B?MXVKL3BYeHBzNi9meFZZSkJHVmdoK0xtTXp3b2FkMjRET3c5WEduZ01GTVpm?=
 =?utf-8?B?UmhVYjEzd00yQzVmUWdzZWxMQjh3b0VndGs2enRhUUlOa3FNSExmTkVFU3dC?=
 =?utf-8?B?dkk1QXc4d1lwVTRMQU1ZdEJnWUJ2aEN5SEt3Z0RJWUZ0WEpjTzh1SVVFK3Yw?=
 =?utf-8?B?UmNNd3R5L1FNamgwUWpNeTRlb1UrTWVIM2QzdW8zNFczb2JGYTYyck91N2FW?=
 =?utf-8?B?VTZoZUk1MWNDZ1lDTFRUdDFxTllLQjk1YVNoc3ZzUnVzZFlvam5yNHZpcmZ3?=
 =?utf-8?B?YUZ1R1pXTEJCdXJrMFREVXBXbEpDUmFwaitmcUtTdWl2Z0psRXdkVFk0OWNy?=
 =?utf-8?B?dGU2blRBWk8vQTVNVlNYK1R1cUwwNzhYU21IYy83U3JlWThyQ1dCNlNHa2hR?=
 =?utf-8?B?dHJPMCt2R0FEb2FJUVYzMVVBaEp4SnVMMzlncnFEZ0Vid3pBOFRLalhZR1Zm?=
 =?utf-8?B?MVAzaERyZUhhMnFRWmVXTEx6SldYenlkaGF5T2wwQTBVak1sK0ZJMXBMbk5l?=
 =?utf-8?B?bTVrK0ZOdjByY2ZhYjZXWkIwSkl2WlNzRVhlcWwya2VtTUFnVHFOWGVncVhX?=
 =?utf-8?B?RnR3Y1oyL0wwbXFLazRZYUpVRlJTZnBQVFR0TENrcTJERjJMOWdjWlRHRXZF?=
 =?utf-8?B?RFNGOFQ3QzVyUTlObWtzSGs0Q0VhZ0czTW9yQnF3MStDbksyZi9pcW5JbC9u?=
 =?utf-8?B?RG9ZV3pKQ1o0K1lubGtRa1Z4c0FnY205SmdSaCs3RjM1eTlWbDZuNGN3WDNx?=
 =?utf-8?B?S2x4ZDZma0JxSDd1ek9tUm9RdXorRzJhcnBtNk5WOFZQMTFNZ045eTlBTTRt?=
 =?utf-8?B?VkVrK0VsbWJLUXB1TVF2ek40REV2WjlwUnFvY0w5L2ZNNUJjRVFVMlpYQm9E?=
 =?utf-8?B?eS9PL1FBY2E2MFNkdXlnQUtuUzNGd3hpTHIzOVFxTDhkN0p1WHFmZVBZVENE?=
 =?utf-8?B?VUdTbnhxbE1TWWRSNmxOR1FoOHFZZW1GRGxVZDZVd3kwTUNWdlpOMUVuUGhq?=
 =?utf-8?B?WllwdGVHanpScHhpUWdLVHd5Zi95YVBRMTFqVUwydUIralo4ZU84MC9lSEJU?=
 =?utf-8?B?bkJGZ3BONzRWU1hERlFjS3RSS2hUQ2RXOW5PbWFucUJhenNaT1V0Q0txWXYz?=
 =?utf-8?B?aVNWL1FPK3hGVllpanZreU1yb1VyMHZnSGwzWU9kaTg5Y3lSTkRkNHZEREVE?=
 =?utf-8?B?bDFCU0dueDFGcnJwK1VYOGFJcEJJdWxBUmdMVmJZamxtU0xiS1BENHZjSXpk?=
 =?utf-8?B?dXdtZGV2Smd1YlFpVTduVUtQVFRHT0NWRHNNSzNHYzB1RU0vdW5PTGpPMzZ5?=
 =?utf-8?B?STY0Z0dWeUhweTlCTFFSNFJidlFwYWpNRnZIdkIwaWlCMDVpUTA5K3l2YXV1?=
 =?utf-8?B?Q2xUUE5WbkxWSkJmWlVhTnFRVTNPOThyai96WDhCTjRCMlNiVy9WYWF2bWMr?=
 =?utf-8?B?ZyszTXRvbSsyNFpoZHYwRmNwOE9VbGxyV0ZibnJIT01hcVRVZ2cwRE53R2wr?=
 =?utf-8?B?V0w1UjMwSjJvR0owb0ZaSGVpMjlCbTV3KzNXS1JrSExuOTVFcWs3cjNtQnRl?=
 =?utf-8?B?cEpXWnJVUW1sVmJjeERpVHNRUWtNMTZnaDdvd01FWld0T3ZEQnlRN0Zmb2ZK?=
 =?utf-8?B?U29pL29TQlloOWJNdHFmNFduMW56VlNLQnM4aEtIc1ZCem8yVDdUcmw5M3hp?=
 =?utf-8?Q?Nzd8pcCcu61qbDWOXX7GhHlEb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84EA241425A497489CB3C3759DD680E0@DEUP281.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5419cb-c255-468f-823d-08dd947a8eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 13:07:05.7015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bk/SDDD9srU7hvzHbqWG8nrw6YZc0yDVomx9VIAQ9JqLBNxGjbiE0ewGHUIZdR028/6oI8aIwr04j0LLcA8dVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1742

RnJvbTogUGlvdHIgS3ViaWsgPHBpb3RyLmt1YmlrQGFkdHJhbi5jb20+DQoNCkFkZCB0aGUgU2kz
NDc0IEkyQyBQb3dlciBTb3VyY2luZyBFcXVpcG1lbnQgY29udHJvbGxlciBkZXZpY2UgdHJlZQ0K
YmluZGluZ3MgZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogUGlvdHIgS3ViaWsgPHBp
b3RyLmt1YmlrQGFkdHJhbi5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvbmV0L3BzZS1wZC9za3l3
b3JrcyxzaTM0NzQueWFtbCAgfCAxNDQgKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5n
ZWQsIDE0NCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sDQoNCmRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3BzZS1wZC9z
a3l3b3JrcyxzaTM0NzQueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
ZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5k
ZXggMDAwMDAwMDAwMDAwLi5lZGQzNmE0M2EzODcNCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvcHNlLXBkL3NreXdvcmtzLHNpMzQ3NC55
YW1sDQpAQCAtMCwwICsxLDE0NCBAQA0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwt
Mi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0L3BzZS1wZC9za3l3b3JrcyxzaTM0NzQueWFtbCMN
Ciskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMN
CisNCit0aXRsZTogU2t5d29ya3MgU2kzNDc0IFBvd2VyIFNvdXJjaW5nIEVxdWlwbWVudCBjb250
cm9sbGVyDQorDQorbWFpbnRhaW5lcnM6DQorICAtIFBpb3RyIEt1YmlrIDxwaW90ci5rdWJpa0Bh
ZHRyYW4uY29tPg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiBwc2UtY29udHJvbGxlci55YW1sIw0K
Kw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBlbnVtOg0KKyAgICAgIC0gc2t5
d29ya3Msc2kzNDc0DQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAyDQorDQorICByZWctbmFt
ZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6IG1haW4NCisgICAgICAtIGNvbnN0OiBz
ZWNvbmRhcnkNCisNCisgIGNoYW5uZWxzOg0KKyAgICBkZXNjcmlwdGlvbjogVGhlIFNpMzQ3NCBp
cyBhIHNpbmdsZS1jaGlwIFBvRSBQU0UgY29udHJvbGxlciBtYW5hZ2luZw0KKyAgICAgIDggcGh5
c2ljYWwgcG93ZXIgZGVsaXZlcnkgY2hhbm5lbHMuIEludGVybmFsbHksIGl0J3Mgc3RydWN0dXJl
ZA0KKyAgICAgIGludG8gdHdvIGxvZ2ljYWwgIlF1YWRzIi4NCisgICAgICBRdWFkIDAgTWFuYWdl
cyBwaHlzaWNhbCBjaGFubmVscyAoJ3BvcnRzJyBpbiBkYXRhc2hlZXQpIDAsIDEsIDIsIDMNCisg
ICAgICBRdWFkIDEgTWFuYWdlcyBwaHlzaWNhbCBjaGFubmVscyAoJ3BvcnRzJyBpbiBkYXRhc2hl
ZXQpIDQsIDUsIDYsIDcuDQorDQorICAgIHR5cGU6IG9iamVjdA0KKyAgICBhZGRpdGlvbmFsUHJv
cGVydGllczogZmFsc2UNCisNCisgICAgcHJvcGVydGllczoNCisgICAgICAiI2FkZHJlc3MtY2Vs
bHMiOg0KKyAgICAgICAgY29uc3Q6IDENCisNCisgICAgICAiI3NpemUtY2VsbHMiOg0KKyAgICAg
ICAgY29uc3Q6IDANCisNCisgICAgcGF0dGVyblByb3BlcnRpZXM6DQorICAgICAgJ15jaGFubmVs
QFswLTddJCc6DQorICAgICAgICB0eXBlOiBvYmplY3QNCisgICAgICAgIGFkZGl0aW9uYWxQcm9w
ZXJ0aWVzOiBmYWxzZQ0KKw0KKyAgICAgICAgcHJvcGVydGllczoNCisgICAgICAgICAgcmVnOg0K
KyAgICAgICAgICAgIG1heEl0ZW1zOiAxDQorDQorICAgICAgICByZXF1aXJlZDoNCisgICAgICAg
ICAgLSByZWcNCisNCisgICAgcmVxdWlyZWQ6DQorICAgICAgLSAiI2FkZHJlc3MtY2VsbHMiDQor
ICAgICAgLSAiI3NpemUtY2VsbHMiDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisg
IC0gcmVnDQorICAtIHBzZS1waXMNCisNCit1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQor
DQorZXhhbXBsZXM6DQorICAtIHwNCisgICAgaTJjIHsNCisgICAgICAjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCisgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCisNCisgICAgICBldGhlcm5ldC1wc2VA
MjYgew0KKyAgICAgICAgY29tcGF0aWJsZSA9ICJza3l3b3JrcyxzaTM0NzQiOw0KKyAgICAgICAg
cmVnLW5hbWVzID0gIm1haW4iLCAic2Vjb25kYXJ5IjsNCisgICAgICAgIHJlZyA9IDwweDI2Piwg
PDB4Mjc+Ow0KKw0KKyAgICAgICAgY2hhbm5lbHMgew0KKyAgICAgICAgICAjYWRkcmVzcy1jZWxs
cyA9IDwxPjsNCisgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQorICAgICAgICAgIHBoeXMw
XzA6IGNoYW5uZWxAMCB7DQorICAgICAgICAgICAgcmVnID0gPDA+Ow0KKyAgICAgICAgICB9Ow0K
KyAgICAgICAgICBwaHlzMF8xOiBjaGFubmVsQDEgew0KKyAgICAgICAgICAgIHJlZyA9IDwxPjsN
CisgICAgICAgICAgfTsNCisgICAgICAgICAgcGh5czBfMjogY2hhbm5lbEAyIHsNCisgICAgICAg
ICAgICByZWcgPSA8Mj47DQorICAgICAgICAgIH07DQorICAgICAgICAgIHBoeXMwXzM6IGNoYW5u
ZWxAMyB7DQorICAgICAgICAgICAgcmVnID0gPDM+Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAg
ICBwaHlzMF80OiBjaGFubmVsQDQgew0KKyAgICAgICAgICAgIHJlZyA9IDw0PjsNCisgICAgICAg
ICAgfTsNCisgICAgICAgICAgcGh5czBfNTogY2hhbm5lbEA1IHsNCisgICAgICAgICAgICByZWcg
PSA8NT47DQorICAgICAgICAgIH07DQorICAgICAgICAgIHBoeXMwXzY6IGNoYW5uZWxANiB7DQor
ICAgICAgICAgICAgcmVnID0gPDY+Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwaHlzMF83
OiBjaGFubmVsQDcgew0KKyAgICAgICAgICAgIHJlZyA9IDw3PjsNCisgICAgICAgICAgfTsNCisg
ICAgICAgIH07DQorICAgICAgICBwc2UtcGlzIHsNCisgICAgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQorICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KKyAgICAgICAgICBwc2VfcGkw
OiBwc2UtcGlAMCB7DQorICAgICAgICAgICAgcmVnID0gPDA+Ow0KKyAgICAgICAgICAgICNwc2Ut
Y2VsbHMgPSA8MD47DQorICAgICAgICAgICAgcGFpcnNldC1uYW1lcyA9ICJhbHRlcm5hdGl2ZS1h
IiwgImFsdGVybmF0aXZlLWIiOw0KKyAgICAgICAgICAgIHBhaXJzZXRzID0gPCZwaHlzMF8wPiwg
PCZwaHlzMF8xPjsNCisgICAgICAgICAgICBwb2xhcml0eS1zdXBwb3J0ZWQgPSAiTURJLVgiLCAi
UyI7DQorICAgICAgICAgICAgdnB3ci1zdXBwbHkgPSA8JnJlZ19wc2U+Ow0KKyAgICAgICAgICB9
Ow0KKyAgICAgICAgICBwc2VfcGkxOiBwc2UtcGlAMSB7DQorICAgICAgICAgICAgcmVnID0gPDE+
Ow0KKyAgICAgICAgICAgICNwc2UtY2VsbHMgPSA8MD47DQorICAgICAgICAgICAgcGFpcnNldC1u
YW1lcyA9ICJhbHRlcm5hdGl2ZS1hIiwgImFsdGVybmF0aXZlLWIiOw0KKyAgICAgICAgICAgIHBh
aXJzZXRzID0gPCZwaHlzMF8yPiwgPCZwaHlzMF8zPjsNCisgICAgICAgICAgICBwb2xhcml0eS1z
dXBwb3J0ZWQgPSAiTURJLVgiLCAiUyI7DQorICAgICAgICAgICAgdnB3ci1zdXBwbHkgPSA8JnJl
Z19wc2U+Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBwc2VfcGkyOiBwc2UtcGlAMiB7DQor
ICAgICAgICAgICAgcmVnID0gPDI+Ow0KKyAgICAgICAgICAgICNwc2UtY2VsbHMgPSA8MD47DQor
ICAgICAgICAgICAgcGFpcnNldC1uYW1lcyA9ICJhbHRlcm5hdGl2ZS1hIiwgImFsdGVybmF0aXZl
LWIiOw0KKyAgICAgICAgICAgIHBhaXJzZXRzID0gPCZwaHlzMF80PiwgPCZwaHlzMF81PjsNCisg
ICAgICAgICAgICBwb2xhcml0eS1zdXBwb3J0ZWQgPSAiTURJLVgiLCAiUyI7DQorICAgICAgICAg
ICAgdnB3ci1zdXBwbHkgPSA8JnJlZ19wc2U+Ow0KKyAgICAgICAgICB9Ow0KKyAgICAgICAgICBw
c2VfcGkzOiBwc2UtcGlAMyB7DQorICAgICAgICAgICAgcmVnID0gPDM+Ow0KKyAgICAgICAgICAg
ICNwc2UtY2VsbHMgPSA8MD47DQorICAgICAgICAgICAgcGFpcnNldC1uYW1lcyA9ICJhbHRlcm5h
dGl2ZS1hIiwgImFsdGVybmF0aXZlLWIiOw0KKyAgICAgICAgICAgIHBhaXJzZXRzID0gPCZwaHlz
MF82PiwgPCZwaHlzMF83PjsNCisgICAgICAgICAgICBwb2xhcml0eS1zdXBwb3J0ZWQgPSAiTURJ
LVgiLCAiUyI7DQorICAgICAgICAgICAgdnB3ci1zdXBwbHkgPSA8JnJlZ19wc2U+Ow0KKyAgICAg
ICAgICB9Ow0KKyAgICAgICAgfTsNCisgICAgICB9Ow0KKyAgICB9Ow0KLS0gDQoyLjQzLjANCg0K

