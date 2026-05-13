Return-Path: <netdev+bounces-287445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB6VNaEbBGrTEAIAu9opvQ
	(envelope-from <netdev+bounces-287445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:35:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E80752E207
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22406307EDB8
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98483D3D15;
	Wed, 13 May 2026 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="DiJRrzAs"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF43D413B;
	Wed, 13 May 2026 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654064; cv=fail; b=p4O4bOdhExso3fkPGhWynmBkodR1WTAZ+xuOKNf4+boBNrgRADbQqaD+1jDALkpWwPj4mtwU/joopwltx/zuQYRi23FT5LnlMpez1RpSB0I/d4FMX+CMeQHOc3FMwqNp/VvS9rthw1cVS65unykAT0m8uP+LCgeF7KO1tHuOhu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654064; c=relaxed/simple;
	bh=SDVCwxh26XrC+mLueSC35MAKtDZRr9o2obKp/QvZGnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QmOshlPX/ffxVzfGMPOWf7qISizRcHieRhh4K4GJNILMnwqYCDm+VIEPXxLC/dvClWpVuqMZVbgT1+gKu1vX3jag7SgZ4a4VGAg9Ea94fFfDRhbcMio4oPygHLWvem5ZugKz9xWycYd0rKYLIDXqclnRIEsTV9wLi5XEqobLS+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DiJRrzAs; arc=fail smtp.client-ip=52.101.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hzhfbx00iKW+eHJ9foVKjeGX04GHqcZGSP0kHVPguW5/tcoxkc1/gPUWt14SLbMDDVS7XqsyOTE5gNW3eKkjCC5vt8I9VlVjB9gca21sBtn8+59ay1fNMQ3h6O7GmqzlOwX5uY3B7zLD2nkkVgKcer8ZA9o1Z9a/mVsCRPgy0gNsGIk74TgjFG+uP+TqytmSXy6WSnP4Pl5iS4TjKa059MGP7LFzLMelyd31Nv/zmQgVoxpNJkrPuAuI60il3Ijdn6KmVSYDscv3nNZtZQnq2lBsb+WV0fyevugnsITiaYKTRQqaOpvdrCyxuRHyv/j5somop9vd0sYWWV2OfLtBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDVCwxh26XrC+mLueSC35MAKtDZRr9o2obKp/QvZGnA=;
 b=uhkv3ObSdSOY66ceDB3JwbDO0wUJ15au5Pbmeiz++tN5e4ZN+ndqlHc/4JIvJP3lfNMKXxZnRsx0doUD334riID0Mv7kQL+nARSCC4zuUMT/vVJmqR/00NTKZvXhwIVoW3DhJUj8UzQdlBMRGoVGRwjYTN2mo1/oDmgpr2Vkr6+rHny8pfr0zWuZMh8MlxfykT1kAzXxgaH85rzq3P8iZ18Nr9Y5CXTMbrhGrk1zudGhgyzqexHMLSVFquhGds+TQtL5m1rjxXPXekm/InLMWqG7jBkpX6hfpGH/oTMXqgE+jW0bj71FiglF3h/SNxpTCYsP8yosD53QXzgHqL7EhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDVCwxh26XrC+mLueSC35MAKtDZRr9o2obKp/QvZGnA=;
 b=DiJRrzAsr0ObOIRLQJp2TUAhOmsjqhUc44G1hmnWWKyf3DasBjRVMlcSovSWZF6TU0Ho9WNbl6iHNs+oq+QOX0LEbsuQMkQIncc9nL+VUHwloAmxpdgOL4z+tT3Hx/jTyPtKGBJuYf+RGl8TqD6vgLiTj01ucEwCkKpZBXAE0z5BWw4Ni+Vq+yeknLE/Ikohkf5PbN80Zb2CT1DBgzmyf01eXa+wRVNasdC6J9kqHdAHFrClqJ+5bbR1wA0XP6IiKDpNTsTCTixA5ZF9ljonb17Fy1535kV3V+bdq4EvORuekymaoA0lZTw/EUF/jGvxNtO+KYmSaOxPR6IB9+yF+Q==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS0PR03MB7678.namprd03.prod.outlook.com (2603:10b6:8:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 06:34:21 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:34:20 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Jakub Raczynski <j.raczynski@samsung.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: stmmac: Use interrupt mode INTM=1 for
 per channel irq
Thread-Topic: [PATCH net-next v3] net: stmmac: Use interrupt mode INTM=1 for
 per channel irq
Thread-Index: AQHc3e9SRSxotHV4XEKxpWUV7oQpfbYJm+AAgAD4KICAAPUngA==
Date: Wed, 13 May 2026 06:34:20 +0000
Message-ID: <907aa406-9285-4155-9f10-8d66dd6fc45b@altera.com>
References:
 <20260507070125.11886-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260511180842.0a547a25@kernel.org>
 <CGME20260512155658eucas1p24d903367780fdaa3f31e81ebe5257cfe@eucas1p2.samsung.com>
 <agNNxTXeHq+4V/kB@AMDC4622.eu.corp.samsungelectronics.net>
In-Reply-To: <agNNxTXeHq+4V/kB@AMDC4622.eu.corp.samsungelectronics.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DS0PR03MB7678:EE_
x-ms-office365-filtering-correlation-id: 481f97a6-6b57-446f-ec9b-08deb0b9aa38
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|38070700021|18002099003|56012099003|22082099003|11063799003;
x-microsoft-antispam-message-info:
 NMITNxS9JoZCtebNUH2KjW4bXF5TbKA0YbYAarD/6UHNnEVOfz5N8KHNuH5+cVrUoMDHpJg2HFWxyrchlYUd/FMQBQNuHf4fZkKt2cntFKy1Qh2gR7/jaeewbYOywtcSKY9CQM1ImQ4naEk7VfQCmFW8dUksBdSjXaS1BCH4allK7TO7uehooyiSDQS7kwKkOK+l5pDRPgwViPK4CEw9ZkSLmdtYrSWIiCsgV69mNSOCiptmT4apF02MAxxMUkX49AOgxKkWqjFdUw1KxOGbbJjGW+HnhrQ0AhCvhZfNvNujP/v0/leJRWR2hCADKuGHhzV9TTYDNaQI15RTcJvtLAVXgvShdGFCi5/ozw/TPK6OpCrqBwWPQ36Y9HFBb283RJMou52zuFjBWljy4M3Y6TEEr1YlnvN6fP/IIu5VO9eUVIRVcs5UVyvx3DsWj8KUE3B9bi9K4OV8t75pItyUVMDlx+WY1CRxzC7DM828HNhaPD7o3DLcEqSbNdfcbLsQXN6ad7Y6Rs0CyqvFkiUmR/2rLaZyXMM/fO0w6H3xWgDgvgVp5DqyR0Ctd417v2lUw2Fah0Mopl/DiX8xBLwn854FEZ8eHc2cQC8gsDZbWhZsGhDLrww/OZfRAQvK48FteAkSLz3IjZYi8vMkaXTzhvV30twTW6zChz2jTONlkl2WCuDxehTKoDLaB4TQMuphyRwZ7nUwrq/qcUEK8viEWgl0twf6A3kedC9rvTsEbPDPi9lpQXyno17LUQjR1Uxj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(38070700021)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmUwVzVoT29vQVJpUDhBc3ZwQ2YzMnJ5QTFhaDBMdTcvUy9LM3RWZ2VreUVL?=
 =?utf-8?B?WnVabFJpbTdWdnUyUkwxYU1ZSVVTWVhTTE9NUzVqZ0dLMWNYamRXK1dEZ0o5?=
 =?utf-8?B?dDRYYndRdjZLeTZqZU1ySmVKcWNMZmp3Z0hqY08rckFxM3VuRnZmSUVNNG5m?=
 =?utf-8?B?TmVQUG9pVmtZYy9hTWpQaWZEb2hhUkZFRUtEYzVucThUR01iNFZ0VENic1p3?=
 =?utf-8?B?MTZNcGdNUW5ZYUEyOVhIY1gvby8xN3NHTW1McHdxQ1NlZGpETG1XWUtvNjJN?=
 =?utf-8?B?RC9NR2IwUGduRzV0SlZnQVZQS29vckZ2TCtGV2I1UW1XZUpFTG1Vdk1yYTMw?=
 =?utf-8?B?SUlzZWFFVVFFNUZ5ZGRTck1FditvVGZjazRmSFRjdFZabUxpTmxkR2FwVFhX?=
 =?utf-8?B?V05MMFBodlVucVdxSWI5S1l0UVpCV3o1cXFjRXJoU3RhQzliOGcyRHZZQm5O?=
 =?utf-8?B?YUVCWFRSYzVCb0N1YWY1TmtqbkJkRVROVHFkTkRJeHdiVU5lcVB6SGNNNXJI?=
 =?utf-8?B?OFErR2xhVk1odVlwNHBDTHh5TzZoeWFjY1ozN1B3d0tJbk5PLytVMEVmWXI0?=
 =?utf-8?B?QjhPcFNzR3hjVGtoK2tmdWdWejNRM2JCZzJyWkNlQnBNcWt2VHdlNE96QlQy?=
 =?utf-8?B?Yk1wR3A1eGxYSlNtV1dEbTkwcE11ZDN5MVRlZlJoMnUvam5VbExLTlVzS1RN?=
 =?utf-8?B?UnhtMXZMVnZNQytKdEhqeUZKcjEzWS9RTWdxRHk2Rkg0MnY1S1o3VXNxRTVw?=
 =?utf-8?B?aEhsdHA5Q0NYL1Z2MHNWaXlramVYK3lwaG42ZWRReU52UUdyYkxDa3ArUlBk?=
 =?utf-8?B?ZzBQR0R2aTE5WkxkUExMRC9wVEE4QVpKV0FpQWdpbFdXL1JzOGdvWmZoUmZO?=
 =?utf-8?B?a2lkMTUrQnpVWXZPQURiZHhGbzhwS1BZUUU2ekJsT1MyR25mbU1DdFFpSUxD?=
 =?utf-8?B?WDIwTG5vQXpJd1lxQlJBcFdFSlkyU3hSTnREaGtjQ0dBN2NLUnJ2Z09OSFJW?=
 =?utf-8?B?emRDbG9CcVMvMDNiMTNtVFFYVmNXakQ4NGFhRkk0OEFrNkR0aWxFcVY3RGtu?=
 =?utf-8?B?UGUzdE1RZXhlT01qVUxMeC92Mk5jRVRIQVp1aEQyQmFUVXVlNXZUblFoanZN?=
 =?utf-8?B?b0d2WTJoNmlCWWNzOUl5M1k5S29LNDR3ZzdoTzRVaHJ5a3p5U0xPU1NtV3ZP?=
 =?utf-8?B?bWxrbVZyMTU1L1JRQXYxTU9QOW4ydkRPZnhraEkxVHBScWh2RTdhczEza3Uw?=
 =?utf-8?B?VFJ0V3VWeUNRb3BlNjRZZjlKcTNrTE9VUVhhYitPSjZXaWUyRFFVUEV5UDBV?=
 =?utf-8?B?ZEZEK2VrdkhsclYxTVZsTUtqUFFEVTRHbEhmeHZlVHI2N1JQclBSTll5cFZv?=
 =?utf-8?B?cUpzTnNsanE4dTZ1a3MreVFBelp4WDc1VDFsQytKMDhqbURldjR3L1ZIOFpO?=
 =?utf-8?B?bFdHek9TUXRsZXoxTG0wSktEeXBmTndCK1I3Y1Y4bTJUTWRaTkUrMEtNdHNJ?=
 =?utf-8?B?cWM5VDJMNVcwNUV4aTZ0R2txQ2drSFNWdmZJeFNXSXRQc0llVXFwMzdlWGx4?=
 =?utf-8?B?VklhNUFKOEtuaG1pNlJqRmQ0TStnR3phUnkzYk5id2FkYWFBRTZLNU1zNXp6?=
 =?utf-8?B?N1RJQzZEU3ovMUdJTW0vWGVSK2lJZnB2UlZxZjVudjg2azRSTkM1M1hMbEt5?=
 =?utf-8?B?MUJvazZveGZaOC9kaW1reHdONzFOdGl6d0YydXdkUENCNTI2YUI4dFFpbU1U?=
 =?utf-8?B?dEZOa1JVQlFkUFJINElrcTB2VjVFQXdFMWp5RjUzYU51UmRKd3FxN1FENEVB?=
 =?utf-8?B?QVFuMzU5bk81M2JQZTREczZKQlJYNFRoajJhNWdydEdnQ3orbTVwTXlDbXF3?=
 =?utf-8?B?NkhYZkJwWHVQRkxDSzJYT1hzNkNtL1kvVktsSWZDM3hEWEcxU3M4OXhkSTl0?=
 =?utf-8?B?Yi9uVGxyMUJ1ZVBBaHFaMk4xUDZkUUF6cy8vN3RCbis0RGJ4M2NOTG9GSktn?=
 =?utf-8?B?eXJWVS9JeWJOLzhtSHlIajJmMUlad3owQXBqVjZJSkNPdndoM1JJOWNTbWdR?=
 =?utf-8?B?dEVtUWJFTGVKYnhpQ3BWVzNFSzFGcnIvYkNRNmhta1NhaGIwR1IzOUx1ZUNu?=
 =?utf-8?B?YURheW9ZSWdhODF3d3lGV2l4Z2tFVHBWNEthRy9FbExPbmRQdXRKdXJud29G?=
 =?utf-8?B?NnBhaUFDNmtHNHlvMkw5N3dUclI1MFlyWWY3TzRaMVliR01YR1NEOUpJVWNW?=
 =?utf-8?B?T0h2QjBFZzZvZWZOa1F3Y2tkbjFnNHR5OXZTeHlpeWFJSTBDUEo3K1ZzUGxm?=
 =?utf-8?B?enpwWnVzeUZaWUZSQ2gwMWZkNTUxUkJDTVdoT1VudThvcS96RVpXOEViQ1Nr?=
 =?utf-8?Q?5ZpKT7dDxeeBuTTFim0f15/LI668TNpR83f8K4UXWSo+U?=
x-ms-exchange-antispam-messagedata-1: 14+3WtD7A28hvzJxC1XRlcTHzuuHpxMqLNU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18CEE8CAB2059D48BF3E27EEC3B6819F@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481f97a6-6b57-446f-ec9b-08deb0b9aa38
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 06:34:20.4119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgBEIaZpBRk8MQr2Aq0g6w6RChvRDNwvSPDZuLMi8/MjeM0/UZnCqGqtyKGoCwNHSVh9xDjdkJcTE6cMByAg9smQF9K+oWgRTxKIgZqy2cU4DW16JbWBQgjNdUkUnWB3Ln6YrCrU53Ergtr1M1MNPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7678
X-Rspamd-Queue-Id: 2E80752E207
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287445-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[altera.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:email,altera.com:mid,altera.com:dkim,aka.ms:url,samsung.com:email]
X-Rspamd-Action: no action

T24gMTIvNS8yMDI2IDExOjU2IHBtLCBKYWt1YiBSYWN6eW5za2kgd3JvdGU6DQo+IFtZb3UgZG9u
J3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gai5yYWN6eW5za2lAc2Ftc3VuZy5jb20uIExlYXJuIHdo
eSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRl
bnRpZmljYXRpb24gXQ0KPiANCj4gT24gTW9uLCBNYXkgMTEsIDIwMjYgYXQgMDY6MDg6NDJQTSAt
MDcwMCwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+PiBPbiBUaHUsICA3IE1heSAyMDI2IDAwOjAx
OjI1IC0wNzAwDQo+PiBtdWhhbW1hZC5uYXppbS5hbWlydWwubmF6bGUuYXNtYWRlQGFsdGVyYS5j
b20gd3JvdGU6DQo+Pj4gLSBXaXJlIHVwIG11bHRpX2lycV9lbiB2aWEgU1RNTUFDX0ZMQUdfTVVM
VElfSVJRX0VOIGluIHN0bW1hY19tYWluLmMNCj4+PiAgICBzbyB0aGUgZmVhdHVyZSBpcyByZWFj
aGFibGUgYnkgcGxhdGZvcm0gZHJpdmVycy4NCj4+DQo+PiBPa2F5LCBidXQgd2hlcmUgaXMgYSBw
bGF0Zm9ybSBkcml2ZXIgd2hpY2ggdXNlcyBpdCBfdG9kYXlfID8NCj4+IFdlIG5lZWQgYW4gdXBz
dHJlYW0gcGxhdGZvcm0gdGhhdCB1c2VzIHRoaXMgbmV3IGJpdCBzdWJtaXR0ZWQNCj4+IGFzIHBh
cnQgb2YgdGhlIHNhbWUgc2VyaWVzLg0KPj4NCj4+IElmIEknbSBjb21wbGV0ZWx5IG9mZiwgYW5k
IHRoaXMgbmV3IGNvZGUgc29tZWhvdyBnZXRzIHRyaWdnZXJlZA0KPj4gd2l0aCB1cHN0cmVhbSBw
bGF0Zm9ybXMgLSBwbGVhc2UgaW1wcm92ZSB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+PiAtLQ0KPj4g
cHctYm90OiBjcg0KPj4NCj4gUGxlYXNlIGFsbG93IG1lIHRvIGF0dGFjaCBxdWVzdGlvbiB0byB0
aGlzIHJlc3BvbnNlLCBidXQgaXMgdGhpcyBwYXRjaCBlbm91Z2g/DQo+IA0KPiBJbiBzdG1tYWMg
Y29kZSB0aGVyZSBpcyBoYW5kbGVyIHN0bW1hY19yZXF1ZXN0X2lycSgpIHdoaWNoIGRlYWxzIHdp
dGgNCj4gc3RtbWFjX3JlcXVlc3RfaXJxX211bHRpX21zaSgpIGFuZCBzaW5nbGUoKSBha2Egc2hh
cmVkIElSUS4NCj4gSWYgSU5UTSBpcyBlbmFibGVkLCBkb2VzIGl0IHJlYWxseSBkbyBhbnl0aGlu
ZyBpZiB0aGVyZSBpcyBubyBoYW5kbGVyIHdpdGhpbg0KPiBzdG1tYWNfcmVxdWVzdF9pcnEoKSB0
aGF0IHdvdWxkIHByb2Nlc3MgYWxsIGRpZmZlcmVudCBJUlFzLCBkZXBlbmRpbmcgaG93DQo+IGlz
IGl0IHdpcmVkIG9uIHNwZWNpZmljIGhhcmR3YXJlPyBPciByYXRoZXIsIHNob3VsZG4ndCB0aGVy
ZSBiZSBuZXcgZnVuY3Rpb24NCj4gdG8gY2FsbCByZXF1ZXN0X2lycSgpIHBlciBETUEgY2hhbm5l
bCBmb3IgdGhhdD8NCj4gDQo+IFRoZXJlIGlzIGU5ZWU5MTAyMThmZmQgdGhhdCByZXZlcnRlZCBi
YXNpY2FsbHkgd2hvbGUgc3VwcG9ydCBmb3IgYWJvdmUsDQo+IHNvIEkgdGhpbmsgdGhpcyBjaGFu
Z2UgaXMgbm90IHN1ZmZpY2llbnQuDQo+IA0KPiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJIGFtIHdy
b25nLiBUaGFuayB5b3UuDQo+IA0KPiBCUg0KPiBKYWt1YiBSYWN6eW5za2kNCj4gDQo+IA0KSGkg
SmFrdWINCg0KDQpBZnRlciBsb29raW5nIGJhY2sgeW91ciBjb21taXQgbWVzc2FnZSBhYm92ZSwg
aXQgc2VlbXMgbGlrZSB0aGlzIHBhdGNoIA0KaGFkIGJlZW4gdXBzdHJlYW1lZCBiZWZvcmUgYW5k
IHdhcyByZXZlcnRlZCB0b2dldGhlciB3aXRoIGFub3RoZXIgMyBkdWUgDQp0byBvbmUgaXNzdWUg
b24gRFQgc2lkZS4gSSB3aWxsIHJlLXNlbmQgdGhlIG5ldyBvbmUgd2l0aCBjb21wbGV0ZSANCnZl
cnNpb24gaW4gc2VyaWVzLiBUaGFua3MgSmFrdWIhDQo=

