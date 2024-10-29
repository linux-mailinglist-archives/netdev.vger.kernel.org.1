Return-Path: <netdev+bounces-139975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5419B4DE5
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D2028205C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B7A192B90;
	Tue, 29 Oct 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="U5h1AoNM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA201946B9
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215630; cv=fail; b=V2AkMprcuZjk1v5bDMMYbaCAJfaNFsIz96PlFq5PeJTykWDVR3jYTAVfLBgkwdCrHEWApIaiVuhhZ9l00UrtLlbN62bB02EXmwJTq3Y07zX05zODy3eyKxaRDpzlAdyVJ78rUHAqeuhzuRw21BwmZW1UcA+wvHUs6t+VKyL0Ls8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215630; c=relaxed/simple;
	bh=kuVz4vyWDLWwbTb3NSwkRQ3oqfplyIISOzT0emTCp2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=otxthjskZtbPaE4Iu1JOUQZGoJRSOxsvjJDpT+4icN1MEdZSjaYrq4HygSui9UCVzj0Itaouc7rZ/7/K/Gi+eaHuJw0t8jGXxLxFvpqbkxA5nux1Yx15fihayUKPdxDaad08JMjyFGRAKb8/4R8z5TEDKxk7pWKjOHo+wfmLfyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=U5h1AoNM; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUQJjNLfuY6ZYZfiqGAKCjLJKmkieFeo2jYrmudvWwuwDCJf8RwjMaNnR0kW1jyzXwFLmBWMYu06Rfd8ASj5co3qmMuPgNqKZkF7UC7UFB8WFs6EP0UdEFt8yi5nvEHI37WFeXCpFrPx+kwNkiKqO9c4Vx1R/yF9S1y+BPuHCa/QW5SyWlzFMCXBC7yOA4bMNot7LfBgllLfiKDupAyndsnuQuAbKwEJTGd/hbrvE9H2ADAMvToYYdc9c0TbJtif/PVXowOAr/tBP2Sq+PPgsrHyycRhojAYSidohE1AMdjhoPVa4kx3GzcQR0+vWkgWWIENYoyScFuamIFhRxHLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuVz4vyWDLWwbTb3NSwkRQ3oqfplyIISOzT0emTCp2M=;
 b=Ui8TOWqRPH6x2TWU1UIegqnE+m2j+hrUU7tkXKDiYjND0Ubs0AW4inBeGYwuiyk5DKvpsaxFKc2r5YCcPSrXgK67ZptIonjrBDQQKwL88rV1CpFsFBOYUnsozFIcfMnFCDEM+yYppzIfdTRsdWYSIrG+MWjPsuAr25fp++En9RUOag8Xln45vmUD6+apnEgwcdykKmun91j7FoX+6oQSTgGiPIsC/M4+JCmNbbDcJC9RBfBunWDH6zsN/2ve6V2EhZ+hZXKRAznmjT4iNT3bCeIC3Ah4A5vOalhJFId7Egi2BTZIObHKE3I6lrt7r1PiG4FbbhNOi3iHQkj+8V/Mrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuVz4vyWDLWwbTb3NSwkRQ3oqfplyIISOzT0emTCp2M=;
 b=U5h1AoNMjmvoMKr8iUuRWghpCI0x5XKxm1eNPx0tTxP0Q9uDURf0r4I9dRhb6+oTqGBMc+tMqxWje9RQPiUjlwQ8KLtuIQSFUkDFQz596/XmIoU5peYvKTisj9fPe5tHfgwsTS+G+UOqGcSspF8q3W0yOg1gOSCVlvbenSRbMHVWp4cdisIDtuZmlajP7/LgcoeFYT3U7cTgVL9AODmF1LnpZ7WJzUt8Val9KpAHKZI/g198npnmpXvtEkCAXNQTswi1AuyYDuLBtlH3nEoZ7D2++aB8WccoKRzpENYrR8eMahsXtEqa3xO2bjuvW+QCgcyuHG8iuYZsqW2d8aIIJQ==
Received: from AM9PR07MB7969.eurprd07.prod.outlook.com (2603:10a6:20b:302::15)
 by DU4PR07MB10206.eurprd07.prod.outlook.com (2603:10a6:10:585::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 15:27:03 +0000
Received: from AM9PR07MB7969.eurprd07.prod.outlook.com
 ([fe80::b836:eece:fcb5:86c9]) by AM9PR07MB7969.eurprd07.prod.outlook.com
 ([fe80::b836:eece:fcb5:86c9%3]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 15:27:03 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@CableLabs.com"
	<g.white@CableLabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
CC: Olga Albisser <olga@albisser.org>, "Olivier Tilmans (Nokia)"
	<olivier.tilmans@nokia.com>, Henrik Steen <henrist@henrist.net>, Bob Briscoe
	<research@bobbriscoe.net>
Subject: RE: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Topic: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Index: AQHbJAZusEU89nsboEacZ/yF6ipBFLKdu9sAgAAmMrA=
Date: Tue, 29 Oct 2024 15:27:03 +0000
Message-ID:
 <AM9PR07MB7969E939CA6C563F9A4061B4A34B2@AM9PR07MB7969.eurprd07.prod.outlook.com>
References: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021221248.60378-2-chia-yu.chang@nokia-bell-labs.com>
 <ea2ccad9-6a4a-48e1-8e99-0289e13d501c@redhat.com>
In-Reply-To: <ea2ccad9-6a4a-48e1-8e99-0289e13d501c@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR07MB7969:EE_|DU4PR07MB10206:EE_
x-ms-office365-filtering-correlation-id: 51e1e068-5c18-4df6-7a35-08dcf82e23e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHdjLy9vU1MxdTRPSVNucm4zZ2hreEdETThxdmF3N3ovcEFiTldaNVNyMmJa?=
 =?utf-8?B?NWplakZqVlBqRWg5NDY0V1JSaDRTTEprUk9hbis1eGtsV0czOWpFN1BTNUtN?=
 =?utf-8?B?azU4SHFpNWUzQVpiSW1udWRqQ3d2Ynh2S2pBWkZwZEIwRE43N1JSTlM3eTJh?=
 =?utf-8?B?TkcvWDdkckY3eFI1eW1KcitZVE5OYUhaeXlBdDdVcDd0R2k5S2VRT09RZzRl?=
 =?utf-8?B?Y3grd0M3bXN6WW42SktHVHhOcGdkSW9TQ202aklLb3Q5MEw5THEwaGVTcjRr?=
 =?utf-8?B?emZRQ21oTmZhdWxlUjlaNkw2UlpJNW8vWGRuVVZDMnkza0lXTWtiY2tLRys5?=
 =?utf-8?B?OFcxVS93STcza0tuTFZPQ2p4SDh3RGRtSWRuTmlNbnNxNzRJOURENSsrSHY0?=
 =?utf-8?B?UWk0Z0hueGRBejVldWI4b2RoejZHR1ZGNHdSdDJQMHRhNlR4REEzbHYzY0Z2?=
 =?utf-8?B?Z0VwUVpydFMzTWNON252QWdhb1h2NWIwWHVxK1NIK2d5MzhheGI0TXVGTzFV?=
 =?utf-8?B?bkphRHc2UFBkUFNFR2N0WHUvTjJDV0M1dFhLMUExOWxhT2REL0tCSUZVZEJN?=
 =?utf-8?B?RzVGUlpTMXZCRkdZN05LUncvVmZzV1o0VlFkeUhCWGFvRHRjcUlhMU5wM0lm?=
 =?utf-8?B?VVI5OUpzc3ZQTDNmdlo5QmVQSFhsc0NOeThQUncwSEdGRGZrR2ZTaHhEWWgw?=
 =?utf-8?B?RXIrUmVrRExCeUFBN1VEVDFUSEdWYW8wdWlYd3pIZ3RYVlMxQzdTU1BUK2Zy?=
 =?utf-8?B?QUY3NklzdTZ0SHhBTWlUK1pzazBLbkUrczFyVzBDaGhVQnNxbmE5eGx2UCtU?=
 =?utf-8?B?amttbTB0Vis5OW1ZN2g1Um9vUVpPSWpzNDl3VVN1RWxtSjNRaFVrV0poL0NH?=
 =?utf-8?B?NUdQVHUwR3diZE4yWDFTYnRXemxoNnJ6OTNhdkJKUEQxL0Uza055ek5YdUdI?=
 =?utf-8?B?TzNXU3RjMVJSaW5MYUIrQVZoaS9iZXlyQ2NBeDdTREVHdWFJejlFS2Z5TXMy?=
 =?utf-8?B?Z29aTmdGVExBZXA4UWIrRG1IYnlNcGtOa3BXckxyVWtGK05iV1FnaDA1N0FB?=
 =?utf-8?B?VGZPaXltNVoxeG5WZTFKc1grV29oMGxuVmpDcmZMak1pN3VpUlhsODJ5dVlW?=
 =?utf-8?B?bmVsSXBsWm9OTjU5Y1hYVTZqam81UVFpZmVJbFpQMkQzNU5jYnZ0VUcvalp2?=
 =?utf-8?B?RkVwVVh3VXNxcFY1b2swMW9pMjRCa2xUaFh0MHczZ2I1T0tNWHhTQWtEb1lp?=
 =?utf-8?B?WXdyVG1hSityU1BrbEc4b1VET1F6eC9EOGExVER3QXVuSiswbDQ0SzJLOFl2?=
 =?utf-8?B?elN5TEZmeWtZVGFWS3pSSkwvUVhHdlhaaUZoZzhGSGlHa2wxU1g5Ym9LQzBM?=
 =?utf-8?B?SDJoQXkvcmxSUFZpd0h4aFVTd2J2T1daZUFoRDVoZVNkbGJxNEh4UHBOb2ho?=
 =?utf-8?B?akFNVk5EckFPbk5zOU9Qa1lFZG9nenBRQXQvd2drVUc3dko4NUd1VHNrTFgv?=
 =?utf-8?B?TVBLN1pSVHlzdzEwdVdPS1Fia09HR3k5TFRCVnVJV0x4L1psNEpIK2lFZ0xG?=
 =?utf-8?B?aVBaNS8zanhoTi9iVmxaVndyTXpwZnIvajZycWVSZ3djbnNmYUhMQzk2R1Ez?=
 =?utf-8?B?dzNPQTYwaHRsSWRha1ZFMUR4K2tINXkwZ3BEcnZtZVBoQ2p3T011UXg5amxi?=
 =?utf-8?B?NjQ5d2NOdUYwNm5weTk3akU0UnFnQ2JHcUhwaXNyaVUzajNCajJYK1JjNmlR?=
 =?utf-8?B?dHB0N3BsUDVxb0R2ZkhzNlk3VGQzeGg3eVJXa000UUtIeHRyN2JYRnh4N05Y?=
 =?utf-8?B?eW5DK3BIaGU2NjZHKzl0U2R1ckRISWJvQVErSEhGMFBKRlpTcytRaGxNUHd0?=
 =?utf-8?Q?DP2iLm06ebs0E?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR07MB7969.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2xlbGwzaGs4NUF0aWZtYnQrT1ZLV3ZZMlBUMUIveHRwdTJKRFhvaC84dzY5?=
 =?utf-8?B?R2hjVS9QdW43R0VwZk9rQ3VNWG1zQjd1WDQxTjd1aFNkb2oySW1tN2Eza2RT?=
 =?utf-8?B?RzYrZ1V1bjJ2aTcwSkV2SHhxeVlVdkZUZ1pmSkRibjVhNlVKZkJTV3NmNFBG?=
 =?utf-8?B?SzRBdUttOXV4NHhrZTRqK2poS0JOUUZKY2lBWElMM09mNFVOV2hCVlo3Q0cz?=
 =?utf-8?B?QWhWU0t0VVBQbVJRaytLa1FEdlp4WnYyZ0cxOVNUWEVOcFlDZGRWRmRtOW1w?=
 =?utf-8?B?MmhNVzhqU2xSSEVkY1IrQTRVUlVaS2VBeE1zRm9Sa0ZSVjZtM1VmalFtN2Nu?=
 =?utf-8?B?emdiNnljNXJyZ0dEUTRkK1U5aGo4SnNmd01ldUtZMDU1RS9GOFV1Mi9KTGdI?=
 =?utf-8?B?MzJYQ2ZTOGQrSWQ3cmVzdWhobUd4R1RaSkw0UjQ3bi9SRUZDY2JXSldYUTBL?=
 =?utf-8?B?ZXY2N1YxNDFOU1lEdEdKYzdKbnJvYWpqMS9Sa0g0WitKQ1NCaFVad04yL3c4?=
 =?utf-8?B?aGlXT0lxMHM5K1NNQjRUZDV6ZDl5TlVsdno1VjRPdEF2b3UveGhFM25qQ2Zt?=
 =?utf-8?B?RkRhN0l5cWRNKzdqajYvY2lUNXdXN0E5RDdPbWtDdjJmTkwwRkF1dUt4V3JE?=
 =?utf-8?B?bW1CTTR3YmFJSWxnU0greHlZbDdDaExVTzgwVjBLaHp5RkdvZXl4WlZZMTZ4?=
 =?utf-8?B?SURkTEJsWmthWnF5TzJhU3dYUHNTUzJFbGk5YlVienRxa0liU2IxS0hYTG1V?=
 =?utf-8?B?bHdJZTZ0ZGRjMEJsUTNMcUNRa0xmanJpVDBKRGhQdUhlSmJnZEYyc3k2aGhz?=
 =?utf-8?B?aHZGaFpQTVV0MnFxRkRzOXVwWmZpMHpkaExHbXpSN3I5WVM0alBQanhUUFdl?=
 =?utf-8?B?YlRqL3NvUjNHdUhTVDRmS1dORVhtS2grT3JPenVCenAzM3VaUUpNQXF5WllU?=
 =?utf-8?B?YWdmR2dIWlhMZnVlcFlYdk5iTGZoNEQwQ3YycU1qb2QwVjVDNnlLYkFsaVFO?=
 =?utf-8?B?M25jU1VCZlE4WTQra1lUQmlrTFA0VGxWazhLNXlubmZFYlhjWXNFNG9Gai96?=
 =?utf-8?B?ZGQrOHdzRU83RDdjdVh2TG04czFzZGZKZFBSSTZLd2hWS214bUIydTVrNVJM?=
 =?utf-8?B?UHNOaUFISWkyVHZNNjZCemwrbzNLcVp2Nk11OUlYZ3RkTWhOeHBYMWdYNzI5?=
 =?utf-8?B?bk9hbHVaOU9sREUvUEJRQWVBVzBhWG5RY1l1bEppdXBZdUpPTUJhVm1Vai9l?=
 =?utf-8?B?eXNMbVNMRHFqM0JsNUhZVjdPWU9sV0x5NzRPeWVPdG0yR1FUSUdYaGxxTnlR?=
 =?utf-8?B?ZjF2aTlXcEpuOVNXM25mMC9lQmlqemtiUlgrSTVmem0vRW5hbzRwT0ZrUnRx?=
 =?utf-8?B?YzkrcGxpdGhvSUovRzIrQ0YveWpuK0htZlpQTDBFTnMrYlg5TENnRzVCQndl?=
 =?utf-8?B?ZHZTSlRlRkpJZm9ML0tGdy9aRTByTE9aZ3NMLzVMeUhza25tUGpNb2MvTTV0?=
 =?utf-8?B?WEpHYnNQZVdLL1VOdi95cFgyM0dWRlZMSVF3blVoSElIeGdqdTA4NnBnbEk5?=
 =?utf-8?B?WUI4UlJJVisvY1FSdEtPMnJhYWdMQ3p6MEptcnBNK3owU3VjZ1l0TE1TTkZS?=
 =?utf-8?B?ajU5cGlYZy9SeW1tT3ZRUDNmY2JCaDMvQUpYM0J2T0E0eVg3eUFMaElac0hs?=
 =?utf-8?B?Q0FRU3FieGdNYnBSN0djb2c5TnpSNm54TkNsclJzdit2dzZxcjdaZTlSczZQ?=
 =?utf-8?B?bkp0VkdBbDdGVFRMZWdEYm1qekE0bGxENTVIcnJaZHQyOWhMU2xYUXhLYWVR?=
 =?utf-8?B?WkFodnU1ZjJRYW8rcTltaVluN0s5UWVpVmo3Z29PTk9BOWZQcEM3VEVoTW5L?=
 =?utf-8?B?REg2a0x2bVcrVFhpQllLWVJLSFhNblRIUUdBTGtrR2JwZXpTd0hCZmlQbmN6?=
 =?utf-8?B?SmFYN2dETDM0UkNJVVV6UXdyc0N1REhUU3FCNUNnQ2hHYUppcG5yaFl4c2x6?=
 =?utf-8?B?Znl6aWd5WkVlenZ1d2FmdnU2NklQVEJpcms2Qksxc3pydlRhc0ZqbzdCdVBt?=
 =?utf-8?B?QUF6T25Zc1k5Yzlwcy9tL3hKVmM5TjVGQ1J3Qy9ZUjFNdUJ2dllzVmF4WXhU?=
 =?utf-8?B?bm9HeGJQcGd1c1h3ZU5zb0l1ZWJhRlRzVWZDa24vRVBuc2lnSWl6VjB5QUhN?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR07MB7969.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e1e068-5c18-4df6-7a35-08dcf82e23e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 15:27:03.3526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XUJQ6M2b+cURtallrz9jKnP4DYbe+oZde2Fj3kf3+XX+UFvT7iKYAS7npTQEososcMc0oRS+EcEt+3J4BpoEW//h9wZi96kXrnq6cweYLJAO5rWr3yh6x2Rv2jTg53u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10206

UGxzIHNlZSBiZWxvdw0KDQpCZXN0IHJlZ2FyZHMsDQpDaGlhLVl1DQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPiAN
Cj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAyOSwgMjAyNCAxOjU2IFBNDQo+IFRvOiBDaGlhLVl1
IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT47IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IHN0ZXBoZW5AbmV0d29ya3Bs
dW1iZXIub3JnOyBqaHNAbW9qYXRhdHUuY29tOyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtl
cm5lbC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsgaWpAa2VybmVsLm9yZzsgbmNhcmR3ZWxsQGdv
b2dsZS5jb207IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29lbi5kZV9zY2hlcHBlckBub2tp
YS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBDYWJsZUxhYnMuY29tOyBpbmdlbWFyLnMuam9oYW5z
c29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmljc3Nvbi5jb207IGNoZXNoaXJl
QGFwcGxlLmNvbTsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21jYXN0LmNvbTsg
dmlkaGlfZ29lbEBhcHBsZS5jb20NCj4gQ2M6IE9sZ2EgQWxiaXNzZXIgPG9sZ2FAYWxiaXNzZXIu
b3JnPjsgT2xpdmllciBUaWxtYW5zIChOb2tpYSkgPG9saXZpZXIudGlsbWFuc0Bub2tpYS5jb20+
OyBIZW5yaWsgU3RlZW4gPGhlbnJpc3RAaGVucmlzdC5uZXQ+OyBCb2IgQnJpc2NvZSA8cmVzZWFy
Y2hAYm9iYnJpc2NvZS5uZXQ+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgbmV0LW5leHQgMS8x
XSBzY2hlZDogQWRkIGR1YWxwaTIgcWRpc2MNCg0KDQpPbiAxMC8yMi8yNCAwMDoxMiwgY2hpYS15
dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tIHdyb3RlOg0KPj4gKy8qIERlZmF1bHQgYWxwaGEv
YmV0YSB2YWx1ZXMgZ2l2ZSBhIDEwZEIgc3RhYmlsaXR5IG1hcmdpbiB3aXRoIA0KPj4gK21heF9y
dHQ9MTAwbXMuICovIHN0YXRpYyB2b2lkIGR1YWxwaTJfcmVzZXRfZGVmYXVsdChzdHJ1Y3QgDQo+
PiArZHVhbHBpMl9zY2hlZF9kYXRhICpxKSB7DQo+PiArICAgICBxLT5zY2gtPmxpbWl0ID0gMTAw
MDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBNYXggMTI1bXMgYXQgMUdicHMgKi8NCj4+
ICsNCj4+ICsgICAgIHEtPnBpMi50YXJnZXQgPSAxNSAqIE5TRUNfUEVSX01TRUM7DQo+PiArICAg
ICBxLT5waTIudHVwZGF0ZSA9IDE2ICogTlNFQ19QRVJfTVNFQzsNCj4+ICsgICAgIHEtPnBpMi5h
bHBoYSA9IGR1YWxwaTJfc2NhbGVfYWxwaGFfYmV0YSg0MSk7ICAgIC8qIH4wLjE2IEh6ICogMjU2
ICovDQo+PiArICAgICBxLT5waTIuYmV0YSA9IGR1YWxwaTJfc2NhbGVfYWxwaGFfYmV0YSg4MTkp
OyAgICAvKiB+My4yMCBIeiAqIDI1NiAqLw0KPj4gKw0KPj4gKyAgICAgcS0+c3RlcC50aHJlc2gg
PSAxICogTlNFQ19QRVJfTVNFQzsNCj4+ICsgICAgIHEtPnN0ZXAuaW5fcGFja2V0cyA9IGZhbHNl
Ow0KPj4gKw0KPj4gKyAgICAgZHVhbHBpMl9jYWxjdWxhdGVfY19wcm90ZWN0aW9uKHEtPnNjaCwg
cSwgMTApOyAgLyogd2M9MTAlLCANCj4+ICsgd2w9OTAlICovDQo+PiArDQo+PiArICAgICBxLT5l
Y25fbWFzayA9IElORVRfRUNOX0VDVF8xOw0KPj4gKyAgICAgcS0+Y291cGxpbmdfZmFjdG9yID0g
MjsgICAgICAgICAvKiB3aW5kb3cgZmFpcm5lc3MgZm9yIGVxdWFsIFJUVHMgKi8NCj4+ICsgICAg
IHEtPmRyb3Bfb3ZlcmxvYWQgPSB0cnVlOyAgICAgICAgLyogUHJlc2VydmUgbGF0ZW5jeSBieSBk
cm9wcGluZyAqLw0KPj4gKyAgICAgcS0+ZHJvcF9lYXJseSA9IGZhbHNlOyAgICAgICAgICAvKiBQ
STIgZHJvcHMgb24gZGVxdWV1ZSAqLw0KPj4gKyAgICAgcS0+c3BsaXRfZ3NvID0gdHJ1ZTsNCg0K
PiBUaGlzIGlzIGEgdmVyeSB1bmV4cGVjdGVkIGRlZmF1bHQuIFNwbGl0dGluZyBHU08gcGFja2V0
cyBlYXJsaWVyIFdSVCB0aGUgSC9XIGNvbnN0YWludHMgZGVmaW5pdGVseSBpbXBhY3QgcGVyZm9y
bWFuY2VzIGluIGEgYmFkIHdheS4NCg0KPiBVbmRlciB3aGljaCBjb25kaXRpb24gdGhpcyBpcyBl
eHBlY3RlZCB0byBnaXZlIGJldHRlciByZXN1bHRzPw0KPiBJdCBzaG91bGQgYmUgYXQgbGVhc3Qg
ZG9jdW1lbnRlZCBjbGVhcmx5Lg0KDQo+IFRoYW5rcywNCg0KPiBQYW9sbw0KDQpJIHNlZSBhIHNp
bWlsYXIgb3BlcmF0aW9uIGV4aXN0cyBpbiBvdGhlciBxZGlzYyAoZS5nLiwgc2NoX3RiZi5jIGFu
ZCBzY2hfY2FrZSkuIFRoZXkgYm90aCB3YWxrIHRocm91Z2ggc2VncyBvZiBza2JfbGlzdC4NCklu
c3RlYWQsIEkgc2VlIG90aGVyIHFkaXNjIHVzZSAic2tiX2xpc3Rfd2Fsa19zYWZlIiBtYWNybywg
c28gSSB3YXMgdGhpbmtpbmcgdG8gZm9sbG93IGEgc2ltaWxhciBhcHByb2FjaCBpbiBkdWFscGky
IChvciBvdGhlciBjb21tZW50cyBwbGVhc2UgbGV0IG1lIGtub3cpLg0KT3IgZG8geW91IHN1Z2dl
c3Qgd2Ugc2hvdWxkIGZvcmNlIGdzby1zcGxpdHRpbmcgbGlrZSBpbiBvdGhlciBxZGlzYz8NCg0K
Q2hpYS1ZdQ0KDQo=

