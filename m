Return-Path: <netdev+bounces-125406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF4D96D022
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CADB20E01
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DEA192D67;
	Thu,  5 Sep 2024 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ENtX5l47"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB6188A37
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520315; cv=fail; b=fcnj1zktTgiCPWMXs7XluJbAdYZFhrui1xbuaLWEpAV5OR7FowHhx2k2u09eVznjNUFHxWlZXKwUA9uTFts4P7FquMXPHnNsg65dDl6hN5rd5ZqrB582sxPPtRLzOOVyEstCGAbEW9hJH7ho6lzlpuDnZ92ry1OY8nMSMeLZAZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520315; c=relaxed/simple;
	bh=Gl9ItqCcb0NF8ANYInUr1cgAlBRfhaQ/uusQSDTi3eY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XSA8/QemhBESec/1qT5z+jkCbKH8RkeVYnP+W3GQR2gy0ZMiDzS+gupMkehqjXRRTTiSimNj0g7eJlTMNk++nbk2l39+nuML0+aBEObcy04zCORAzkx+b1xHqVVjBXQAdTPxWAhhfegsNVf9mplty+G+PdiECmHygWETcCUjAmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ENtX5l47; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnq2cSGyT1eJeKwOrxm9adiEQMSmaAO2PMjpXcIyT+CPboKsMmdvNrPpf61yqp2CxqcnACXRAikMLg59r2xMVuo5kES7uB0AVnGhJoTFo8YG054Gb0Nd6XpqGA4ZP5v7PqjGeJ/8IjXOSkpOYnFls8EOIKlBwFFFU2QLZlEGZPJ0oShBW0RlCd0KN6GTpjXyFYDEF0Eh8/Uvgo/LmF2hIb93ixDie9/N2F2KCW+wf6Kac7VrV9DVLJLsh1wZ7pXtXNxalV+M9KilZLK4rQoHowgxTC9AEnvFWZGY6MivasbWSMNGZsgetTiNSK/ETbnZtWjFMsLPawnrysy95Wu2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl9ItqCcb0NF8ANYInUr1cgAlBRfhaQ/uusQSDTi3eY=;
 b=Shul45zXFXK7qpB1pneTjNdjFU7bUGBog74esIvUB2P/UkENNgkvHMe5rFKKIPdCeCC4OAWQpilDM3pdhKrJYGoAXo+kBhojRqzS4CyzpXccjtnR4XPNicVe86RKCSe+1fOu6OPqJdpi18V0FyPsVmtjVRlCDxEhO3PEYr1kxN2KShh0rPONGUNDGZJtmvO3C/R54gWHByhJNuG7n5Y929sacrL3JpAU3BOWmspdSwTB50JWWHH8Zy+Y2/vhxdv8wIde9wq63tnOQmli3cGinihhT0+9h2nZ1+6GbB8SCVhkCb80qVYGGgtvc6Nj3tYrn6xi3F9bO4DGVAM+R9cXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl9ItqCcb0NF8ANYInUr1cgAlBRfhaQ/uusQSDTi3eY=;
 b=ENtX5l47nIFgu97fJLfgFsLZyulvJcEc1d+8L/psm26FaX4QNaOssW97G3Ss8FG08kP0KkLX9/KYJZUsqmTdtLblYhgJJYHrZe19wSVmdwjkNJIgWhkI5y+szm4ufF8UN+mJVw6LciiHM5uwb4h0HyetrbsqChmdiAPUZ0Q0Tsxsh+ZSQZwaJs/1awemsJz/WPqVI3vxCm58F3f081KGLxXcgMj1tVNB7McbtQVz8lvaNqCudliBLxFlziSAYXhMP5xRBe4ZrKt6XPdTp/j/Y7PSHfFxs30roXpY46wcQXX68ILzNYpWKD97xh4nkQTXVFRi4Bxq0w89uUX3OytB4w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAWPR10MB7101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 07:11:45 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:11:45 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "daniel.klauer@gin.de" <daniel.klauer@gin.de>,
	"davem@davemloft.net" <davem@davemloft.net>, "vivien.didelot@gmail.com"
	<vivien.didelot@gmail.com>, "LinoSanfilippo@gmx.de" <LinoSanfilippo@gmx.de>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "rafael.richter@gin.de" <rafael.richter@gin.de>
Subject: Re: [PATCH net] net: dsa: fix panic when DSA master device unbinds on
 shutdown
Thread-Topic: [PATCH net] net: dsa: fix panic when DSA master device unbinds
 on shutdown
Thread-Index: AQHa/qDhxv3gRVoD0kGEjqt23TbnvrJIyHgA
Date: Thu, 5 Sep 2024 07:11:44 +0000
Message-ID: <7db5996ef488f8ca1b9fdc0d39b9e4dd1189b34b.camel@siemens.com>
References: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
	 <c1bf4de54e829111e0e4a70e7bd1cf523c9550ff.camel@siemens.com>
In-Reply-To: <c1bf4de54e829111e0e4a70e7bd1cf523c9550ff.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAWPR10MB7101:EE_
x-ms-office365-filtering-correlation-id: dc29b134-cef7-4d81-0e8e-08dccd7a0006
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkQyWWlFNTJ4N2VaSWpCTGFES1FwbXdMdTJOVUxVWlN5VVBSWVo4S3RCVVNj?=
 =?utf-8?B?K0xkYTN3V044b1hwSHA1MzFZOEw3eFg2ZVd4YXVOOEhSeHZvdUpKT2NCY29k?=
 =?utf-8?B?dFRmQjVUZzd0UTExbHhrSUFCMUJqTk90c1NjU3IwK1RNa09ZWlZjS3M5VVBT?=
 =?utf-8?B?WkZJeG5teTZQRmE1ZDdNN0lWcUd6czFHTm5nOWRNMTAwU2RQTGhPNzA5Vk5o?=
 =?utf-8?B?U3hZZ3dBcm1Va3A2cFNGT0hCbUJuY2Nuc2hyeE50UUVRQUQ5Z3ZIbGJLaXM2?=
 =?utf-8?B?OVltcVA3VTB4bG9rMThCV29rSU4zcG5nT2ZPRG9ZME1GNG1BWEF3Mmo3eExh?=
 =?utf-8?B?Wk1EYkQrNTN1cno5SG5pUXVsZGEvKzdIM3F4TFN6OVhIdkJLM0RudE5sRWpO?=
 =?utf-8?B?VEZiOFY1RnpYOW1vYVg0dTkyWGNUa0ovVWxIbHJCWlZ0ZDdjUGJJdnJyWXBq?=
 =?utf-8?B?Z21xekVLQUJsM1g3SEIyM1A1UmJnV1c1L1h3R1JSN0lEK2hleEMvZ1NNeFFw?=
 =?utf-8?B?ZDd4VjRqVjdWdU9jTUNBR0RRWHgzNXlkU3hQK0h3OEdNc2ZvNVcrQWlkVXlq?=
 =?utf-8?B?SzI1RGtPb0V4THJMUnJ6TUJMeGlhQlUzejFZR2FOWTV6eWhvM1FyaFJRaElm?=
 =?utf-8?B?eWVPRHBQcUwrcG9WY3pod0dtQUh2b0hrazRPRkllakZnY0d5bTcwamQ5d0FU?=
 =?utf-8?B?TElmRE93QllDNWlEd0F6UmYxQXRFSEQvT01oQVBvekFsVkQ5M3JMSE5zekZU?=
 =?utf-8?B?WkZLT3MrM2NJYmFNdG5pTytLdm1QQ0hreUhpWlR1Snc4M2Z1aCtFbE45NXNl?=
 =?utf-8?B?RnlBNldSWE1XdzU1QVVzOGpGcHVYVVh4QkxTQXBvMlBqNHIrL0M1cFliYWZS?=
 =?utf-8?B?VWlneVVXdlRHQm56cUlvaUl2RHVMTVFWZWFtZjYzNlhyQWJMM2F2UWkyQSt3?=
 =?utf-8?B?Rjc1dEd6Tzd6NFhoeXk0aklOSWpCcmxQa21lenJnRUVENmJsbzYzNUh6YUV3?=
 =?utf-8?B?aHk4UUIwNy9OZG5JS3c5L1dMalJiZWlqVlVOcTNQS3h3YUo5bDJacWZTSzlM?=
 =?utf-8?B?ZGpKSnVReFBhUFFqNzVmYkxNTlE4M2lsZW5aSDdqN0dJak9OMDQzemxJMEln?=
 =?utf-8?B?V1NYaEwxeG5kY0V2TXVPM3NtbXNieEFKa0RMVzN4ZFR6azVFdFZzWTJnYzFP?=
 =?utf-8?B?UmltdVBBT0ZaYVF0L1FRMkZSWHlFYlpDc2lmaS9CcTVYYTJtclQvaDNYcEY5?=
 =?utf-8?B?V2k5VURwZ2hpZWg3Vnd3bXdmSkRWYTRFVk9ITHBSajlJY2VqUlZNaDZadCsx?=
 =?utf-8?B?MjMyWmZiL3NjUGhjWHBBZkI4ZzN5c09UbVNQZVorU0VZMFJTUzJ0dXBMUU9x?=
 =?utf-8?B?MlN0ZDZTRVUxMEhhL2xjQm5HZUFPUlpUaTRyYmpNelk5eUlrbEhhN01BMEto?=
 =?utf-8?B?cW1ubjVHN1lzbnVPZ3lSMG1uT21QN0Rpdm5QZlBzMnNFbHIxNkdWb01EN28v?=
 =?utf-8?B?bTNPcDRTUHlBa1FmSStRZHVqZmZ3eHdHNElSQmkrbGtSNzRpSjdBWVhNWnkw?=
 =?utf-8?B?dEEyeTRZc1Via1dqZlFrTHdpVzNrUTJaQStxcnhkRFMxaDVxUDFSM09wNXlU?=
 =?utf-8?B?UWp0TGdQU0ROMC9mcGgwR01LUHBFTVVlTXdWUnlQSFBEb0hwVUg3VU1XV3Vt?=
 =?utf-8?B?ZFZITWtwOEEydlpNUWFGOG5QVUc0ZXcxbXdJWE1MSUJwUm4yblRxemJDa3dt?=
 =?utf-8?B?MkVyVkNzR1VHSS9hMUFHVTFGb1pObTBJNURoeXdCOGR2MmxDM09yVm9NWnd1?=
 =?utf-8?Q?NUldoeO+DER/R62euTASlJci71/RQUO46+K6c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnYzSVdzY3FUZXlQS0lXcEwzQmhkS1l6V3cvVklUMmUxTkdUSXlJdU5mdzRJ?=
 =?utf-8?B?aTBmSnowVEFHUUUyOEdsSmFtSmxDSFFBdWZrbnBzSjNNaGJ6K1RtekxPMkxJ?=
 =?utf-8?B?MjZsdktudHhmREpNS2NFWnZ5NHZlNExhVWNyN2RuWVkzY1dwOTh6aTcyOVZR?=
 =?utf-8?B?SjRiWXhPSkUzUFhaVXFnZXRIVmtuV1J5NWh2MXZHSXFtVkJoM1pObHJFUGtT?=
 =?utf-8?B?SkovNjJkWmhSRFdVbm13dkJINEkvOVd4Y1pzcjhDQkhCNG1SS0xMRHNwWkh3?=
 =?utf-8?B?QkgxRTl3UjVrWkYrQllnV3lyazBXZE1jek5oRW00VUQ0OVNNU0RFYVp2VFJG?=
 =?utf-8?B?Y3c1Z0pjZXVwalRtSzRJVGlaOGJSZVpwbXdvWnpRZyt1OUlMV1I4L3UxMDFo?=
 =?utf-8?B?S3dxam5LVEFXNjF5QXZhbldrRnpjcmg3WG1NREd1eGNudDBIZ0x2TG1Hb2xQ?=
 =?utf-8?B?K3p0QmRhdFBJdFJQQWRMN0tReVI4RUphWWFoYUx6TWREYWwzOXc1RzNZL0N2?=
 =?utf-8?B?aUFyT2QxZmpVaUpzREFMU3QzcUpweDB5QTVMdlozaVE5TUZZM3hzRksvUEMy?=
 =?utf-8?B?K3g4R3hrQjRhSTVWa1pFVGYxZ1hOSXFJeTdTVWZXMnZFa2pyTllWd2VLOFRK?=
 =?utf-8?B?TXNwdFV2dTBwT0FVcldoWTdqWVRZbDFLOGRodERxUktja3BQZTZKV25mNkJ6?=
 =?utf-8?B?TnJhYVg0dGtZK3BKa2hLVmNOanRiSlhFM3h2ZHlEYVFKL3dnczNOZmJVQkF2?=
 =?utf-8?B?ZWJCYzF1SDk4RWZQVWw1RktHaTIzUnRvNVVqMTlZOVh5TTJyTnlGVGo5ZU1Z?=
 =?utf-8?B?ZTNYdmhEb2lVbzNmRTNyZkxJT0F6MDRlaUlmT2NWdHAxTVhLWTAvNTREUEdQ?=
 =?utf-8?B?UHpKcmx2VUJFYldJQnNLeHRzWVpUODUyaEFaR2Raby95cmVwRXpDbFg4eU8z?=
 =?utf-8?B?cXE4cC9hbWI0WXlTa3VRZXBVcjJySGtJL3B6RTZWQ2pRRGw0OVNVeURocTZW?=
 =?utf-8?B?QUVkK0xhWE9oTGgrVFpWUXR6MVRGd2Z0Qnkrc1RGVS9PODRmZ2NqR0owTzFv?=
 =?utf-8?B?NWpGbVJGQWFrK2h4aHFUUjJuUk1vVWNWdnExeXZtcktranVPMjFUaUNqOTJm?=
 =?utf-8?B?amZYWlc5Z1N3MmhjNXUyTXIxMG5DTzd0SU9PUnVkbkFLWUZWcUNPNFJMTUFt?=
 =?utf-8?B?Nno2T1JxRWIxR0wxOUFXbmM0dnRxTDUwd3BMZ1ovR1Jvelc2ZFExdXdtY3NZ?=
 =?utf-8?B?MWdnK2lKOUVQditrdnovUWhEMlhCYW1CVXhSRWMwRzNMMGxJZ2Y4dlppNzhV?=
 =?utf-8?B?ZmhMOFd1eEFnQU8vZVhwTnZIN1FYbXpUTnpLcldJeld6RnJ2aFFWbmJZVmdn?=
 =?utf-8?B?d3pJSUFsbjZ4ZFhwUWl0WFpWWGFubEduTnpOUkVleHhYckVDZm44eGNlT1BZ?=
 =?utf-8?B?UlpZMS9KRm5OUzhkdDhma3RFVEdIbUJOamFHQ1FJUTBkYTNHSi9qcUdOQSto?=
 =?utf-8?B?M2ViUngxZWxXckp3MXpmanNJeHY0UTRldEFBNHFib0pwQU5td3oyWnNzN3ls?=
 =?utf-8?B?SmhIa0s2aGRidmV3VGJjWWM0dVoxbmRhZjBldjcrbmVOZXdpMTdUQlpESmJY?=
 =?utf-8?B?c3QzbHZ5aXlqTjFEQVFCdkpIb3U4emYwUVFVR3JaUVJRcFpXK0xuQ0pTc253?=
 =?utf-8?B?dlJJTHVSSmlzVFpnYmt5cUhDU2drdmlIbkxTNWZOTG43Rzk3Vkg5SFUvUkVP?=
 =?utf-8?B?Nnk5L3gxbTZDejcwbFEybGRNY2pUU0k2SmlJS0tYVVRBTy9Jc1FQOE9ocTNH?=
 =?utf-8?B?ZUJ4NC96dzQ3eW5MLzFraTZRajhiOENLY09LN0UvQW5iRVBiaHkzS2dyQ3RI?=
 =?utf-8?B?d1lkSzRNU3JTYkYyVTNTbVk5aDNKNFF3Q3Y2L2dMbDM3MEpSREJ0V05uQ01X?=
 =?utf-8?B?RzMyZC9XZFd4bTJ5bkpTckxiblBxK2s1Tmk0Y01wWElxNm1FSUdvdFoyUE91?=
 =?utf-8?B?OU90M0YrNHRXakIvU0lGbVRPdjlGdVBLcXNNcE1XQ3NUdWRzTWppb2tCdFNT?=
 =?utf-8?B?ZDJ4TnNTSG9wNHluMkhaa2FRMDRBY1pacWhNL2l5Ym1SajdGL1BTL2JqY0t1?=
 =?utf-8?B?bFN2ZzVURmtSVFRoZVJVVXF2dVpCejZSaVI1NUYza0QrZWxCS2JXWFptbUtx?=
 =?utf-8?Q?TRyndkim32Y3dAXQ1bUFz7w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92ADC85C8896FC45AEFBBC0CE7EF1DF5@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc29b134-cef7-4d81-0e8e-08dccd7a0006
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 07:11:44.9566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vefJ8tOeal+ZPDvNwuZq9KMPYMD7FWyTReYdBn8u9VHhg06r51Eazjdd18J7IV+H2BdmgRSHQesApoJ0WI2YlOcKmyjYeEcaWp6ebEu2UpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7101

SGVsbG8gVmxhZGltaXIsDQoNCk9uIFdlZCwgMjAyNC0wOS0wNCBhdCAxMDowMyArMDIwMCwgQWxl
eGFuZGVyIFN2ZXJkbGluIHdyb3RlOg0KPiA+ICsJLyogRGlzY29ubmVjdCBmcm9tIGZ1cnRoZXIg
bmV0ZGV2aWNlIG5vdGlmaWVycyBvbiB0aGUgbWFzdGVyLA0KPiA+ICsJICogc2luY2UgbmV0ZGV2
X3VzZXNfZHNhKCkgd2lsbCBub3cgcmV0dXJuIGZhbHNlLg0KPiA+ICsJICovDQo+ID4gKwlkc2Ff
c3dpdGNoX2Zvcl9lYWNoX2NwdV9wb3J0KGRwLCBkcykNCj4gPiArCQlkcC0+bWFzdGVyLT5kc2Ff
cHRyID0gTlVMTDsNCj4gDQo+IFRoaXMgaXMgdW5mb3J0dW5hdGVseSByYWN5IGFuZCBsZWFkcyB0
byBvdGhlciBwYW5pY3M6DQo+IA0KPiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAwMTANCj4gQ1BV
OiAwIFBJRDogMTIgQ29tbToga3NvZnRpcnFkLzAgVGFpbnRlZDogR8KgwqDCoMKgwqDCoMKgwqDC
oMKgIE/CoMKgwqDCoMKgwqAgNi4xLjk5K2dpdGI3NzkzYjdkOWIzNSAjMQ0KPiBwYyA6IGxhbjkz
MDNfcmN2KzB4NjQvMHgyMTANCj4gbHIgOiBsYW45MzAzX3JjdisweDE0OC8weDIxMA0KPiBDYWxs
IHRyYWNlOg0KPiDCoGxhbjkzMDNfcmN2KzB4NjQvMHgyMTANCj4gwqBkc2Ffc3dpdGNoX3Jjdisw
eDFkOC8weDM1MA0KPiDCoF9fbmV0aWZfcmVjZWl2ZV9za2JfbGlzdF9jb3JlKzB4MWY4LzB4MjIw
DQo+IMKgbmV0aWZfcmVjZWl2ZV9za2JfbGlzdF9pbnRlcm5hbCsweDE4Yy8weDJhNA0KPiDCoG5h
cGlfZ3JvX3JlY2VpdmUrMHgyMzgvMHgyNTQNCj4gwqBmZWNfZW5ldF9yeF9uYXBpKzB4ODMwLzB4
ZTYwDQo+IMKgX19uYXBpX3BvbGwrMHg0MC8weDIxMA0KPiDCoG5ldF9yeF9hY3Rpb24rMHgxMzgv
MHgyZDANCj4gDQo+IEV2ZW4gdGhvdWdoIGRzYV9zd2l0Y2hfcmN2KCkgY2hlY2tzIA0KPiANCj4g
wqDCoMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KCFjcHVfZHApKSB7DQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBrZnJlZV9za2Ioc2tiKTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiAwOw0KPiDCoMKgwqDCoMKgwqDCoCB9DQo+IA0KPiBpZiBkc2Ffc3dp
dGNoX3NodXRkb3duKCkgaGFwcGVucyB0byB6ZXJvIGRzYV9wdHIgYmVmb3JlDQo+IGRzYV9jb25k
dWl0X2ZpbmRfdXNlcihkZXYsIDAsIHBvcnQpIGNhbGwsIHRoZSBsYXR0ZXIgd2lsbCBkZXJlZmVy
ZW5jZSBkc2FfcHRyPT1OVUxMOg0KPiANCj4gc3RhdGljIGlubGluZSBzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZHNhX2NvbmR1aXRfZmluZF91c2VyKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgZGV2aWNl
LCBpbnQgcG9ydCkNCj4gew0KPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZHNhX3BvcnQgKmNwdV9k
cCA9IGRldi0+ZHNhX3B0cjsNCj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRzYV9zd2l0Y2hfdHJl
ZSAqZHN0ID0gY3B1X2RwLT5kc3Q7DQo+IA0KPiBJIGJlbGlldmUgdGhlcmUgYXJlIG90aGVyIHJh
Y2UgcGF0dGVybnMgYXMgd2VsbCBpZiB3ZSBjb25zaWRlciBhbGwgcG9zc2libGUNCj4gDQo+IHN0
YXRpYyBpbnQgZHNhX3N3aXRjaF9yY3Yoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3RydWN0IHBhY2tldF90eXBlICpwdCwgc3RydWN0IG5ldF9kZXZpY2UgKnVudXNl
ZCkNCj4gew0KPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWV0YWRhdGFfZHN0ICptZF9kc3QgPSBz
a2JfbWV0YWRhdGFfZHN0KHNrYik7DQo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkc2FfcG9ydCAq
Y3B1X2RwID0gZGV2LT5kc2FfcHRyOw0KPiANCj4gLi4uDQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbnNrYiA9IGNwdV9kcC0+cmN2KHNrYiwgZGV2KTsNCj4gDQo+ID4gwqAN
Cj4gPiDCoAlydG5sX3VubG9jaygpOw0KPiA+IMKgCW11dGV4X3VubG9jaygmZHNhMl9tdXRleCk7
DQo+IA0KPiBJJ20gbm90IHN1cmUgdGhlcmUgaXMgYSBzYWZlIHdheSB0byB6ZXJvIGRzYV9wdHIg
d2l0aG91dCBlbnN1cmluZyB0aGUgcG9ydA0KPiBpcyBkb3duIGFuZCB0aGVyZSBpcyBubyBvbmdv
aW5nIHJlY2VpdmUgaW4gcGFyYWxsZWwuDQoNCmFmdGVyIG15IGZpcnN0IGF0dGVtcHRzIHRvIHB1
dCBhIGJhbmQgYWlkIG9uIHRoaXMgZmFpbGVkLCBJIGNvbmNsdWRlZA0KdGhhdCBib3RoIGFzc2ln
bm1lbnRzICJkc2FfcHRyID0gTlVMTDsiIGluIGtlcm5lbCBhcmUgYnJva2VuLiBPciwgYmVpbmcg
bW9yZQ0KcHJlY2lzZSwgdGhleSBicmVhayB3aWRlbHkgc3ByZWFkIHBhdHRlcm4NCg0KQ1BVMAkJ
CQkJQ1BVMQ0KaWYgKG5ldGRldl91c2VzX2RzYSgpKQ0KCQkJCQlkZXYtPmRzYV9wdHIgPSBOVUxM
Ow0KICAgICAgICBkZXYtPmRzYV9wdHItPi4uLg0KDQpiZWNhdXNlIHRoZXJlIGlzIG5vIHN5bmNo
cm9uaXphdGlvbiB3aGF0c29ldmVyLCBzbyB0ZWFyaW5nIGRvd24gRFNBIGlzIGFjdHVhbGx5DQpi
cm9rZW4gaW4gbWFueSBwbGFjZXMuLi4NCg0KU2VlbXMgdGhhdCBzb21ldGhpbmcgbG9jay1mcmVl
IGlzIHJlcXVpcmVkIGZvciBkc2FfcHRyLCBtYXliZSBSQ1Ugb3IgcmVmY291bnRpbmcsDQpJJ2xs
IHRyeSB0byBjb21lIHVwIHdpdGggc29tZSByZXdvcmssIGJ1dCBhbnkgaGludHMgYXJlIHdlbGNv
bWUhDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5j
b20NCg==

