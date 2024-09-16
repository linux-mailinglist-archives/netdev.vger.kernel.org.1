Return-Path: <netdev+bounces-128475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE0D979B95
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 08:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40171C22B19
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 06:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65BA136345;
	Mon, 16 Sep 2024 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="0D6FW4/d"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4B412CDBF
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469648; cv=fail; b=Zyo1lBkhatXmZzavxn3RO1vNpjx4tSPfxhZUTIvXwsfELUQuQqTY1vEUUyyI9pPBCHLzfvgqF/jLRvE/IJFXVsv++KZ/zSgSr+BIW4Uf+mpVbuYy1r3IH0on7XVlFnaXPHqIRtvN6nioOqI+6+eSfX4ge5bAfEuDbRctNv2NgZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469648; c=relaxed/simple;
	bh=4KQH3cq4WTwoHcdAIRPo+XGl8dPZxsTjlrWjwgE1Bxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n6ePVoYY5u/BXaOx4HT27J3jZyb79tDNkCJ+UsRWmUfigP7Qu1V1Bv+0IgBF7/fzJKbH1AWnxwm9rBijIMTLyCsKb+uSoCF+p16AUrsY2zTfJJmaOTi1pu2P5ppm5D2wGLW6Ff8s9TPMakwTsJw92Q1e5XlwYpIexymSVGVglcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=0D6FW4/d; arc=fail smtp.client-ip=40.107.241.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoWXsBylxK2jNdFZHdUSlZb1YKw5ceh1rO/LOvEmFizGeaiDF+W1Gf/uYqOPpnJXAf7I4MLmjedDkFreXI5iQMo0ZfjE4GWNQv4pbZEZZMoGCdQ4h66YzXHuJ8yDKdk3J4bvfPwpLq3VB4YY2wLTE3sbTBwRq6IlaMI2SFS2BtpVCOQrJWRRS7S0nD2BSD2Tb/MM4P5MTeCjZt9xNi4DlwoL25lkTYjrZltvwciKQf8LvTuAfVndwIZB25sEPeJRqR4NAHIxD8rS89wMVXvhkgp3YsMgnQvC2g+DNxYSFUHn8PmAISmWywpvlES7M7ZUhtv3QlZb5j0sC64Mzc89Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KQH3cq4WTwoHcdAIRPo+XGl8dPZxsTjlrWjwgE1Bxs=;
 b=Eux9sX93Nn90vf19I/1wkKitWGpC/8hP33PT18WNMXTCbMke25hUAJbrsNFyGw9/fk+ey+xnI4364AcH7+lGvmmtY1cV+fFABHyMlQAgTGSRRH033bNG/QSAWOKDkNA+roFbCWT/Z5omGfmYQx4RkvDDlcgD3tI2omwi3T7RkiFEpwPwTEk30CUsLpboyyspFH+T28DNmXLqy0t8tX1/tzpJmTiErgKV7ia6QBlRIwC2nr2T228dwZm/Ah6/YgTmY/4SLL84UGQz3mKzKKZfycWJp6339xKS5Y/ajwFaQdSlr8FLMyKYv1P60dRky9oZs3i+rApXqddu/sRJoBZ8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KQH3cq4WTwoHcdAIRPo+XGl8dPZxsTjlrWjwgE1Bxs=;
 b=0D6FW4/d/42twU7B5R9hM5fkvpFRL3p7/hJDwSASdni6gi0BHw1e8a2lMNsIV9JXtjU/E4oFiPEv9a/JhI1XohVwUh7Vmx13UQ6I4mgdrY4Ptpkd5G/5TZH14GvFHkP5gAbFgmWNqxqI/0EbTw5DnUTE8eVwmzRIzmIgabDvtuZABQGU8q/xAi/G9jYSQNJ8t3jg/3y3kh3hervGjUqo0I0f6ZXtNtjVpCD9wNi8HDaqYzSfs1b4w1pxh5Q4jSUbLv6UndSnOVIHDB4N0IOflyASGm7cfe1CZFS2jVdYgkmVvJv4REJgItYe0wtgp2UYnlRo71Wjh/Z0z+3x1PJjPw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB7955.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 06:54:02 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 06:54:01 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>
Subject: Re: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Thread-Topic: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Thread-Index: AQHbA4Hagboir6ZjOEqxQ/L/+DWWZ7JWGDUAgAAGsYCAA+SAAA==
Date: Mon, 16 Sep 2024 06:54:01 +0000
Message-ID: <524fb6eddd85e1db38934f49635c0a7263ae0994.camel@siemens.com>
References: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
	 <20240910130321.337154-2-alexander.sverdlin@siemens.com>
	 <20240913190326.xv5qkxt7b3sjuroz@skbuf>
	 <28d0a7a5-ead6-4ce0-801c-096038823259@lunn.ch>
In-Reply-To: <28d0a7a5-ead6-4ce0-801c-096038823259@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB7955:EE_
x-ms-office365-filtering-correlation-id: f8f17b4c-a9b1-4e7f-862b-08dcd61c58f6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b25XM2o2MDBwNUlJTmFGL1N5Y1F5TXNQR2JYUzRsS2JGZ3ZkTzdUMXBFR2k3?=
 =?utf-8?B?OHNHVGdZSUNDakFqR05kcFFsTCs4bTlXUWs1cHVkQlJFYTVTM1R0cWNyV3gx?=
 =?utf-8?B?Mm9SNGE0NnhRTi9FVFpJdkt3ejVyVG5GV0QzL3dTVy8zQjlnMUdadmQvcy9t?=
 =?utf-8?B?UXh2N0dXblBCd2pjTmJvRWRLZ2ErYnBTMUZTams5WlVnT3o1ZmNselg4eDlT?=
 =?utf-8?B?RjFmVkYvb3VjNzY2K0dmQ2ptbUxrUm5PL1FSYVJsZ2toREZ5ZEQwUjZsamM1?=
 =?utf-8?B?SzNFWS9Pb2lIM1NkTDJkc2FKUXI4WnpXbDd1M3lCOU0vUnJJU0hLcUY5ZEJJ?=
 =?utf-8?B?NmpjU3hWMTJua280WXlBeXFJc2RuZXhzblZicmdZaXdVQ2VOZmZSZWdEbG1I?=
 =?utf-8?B?Wkw1dy90ODFpRWFMVnBEYXhSOHRCZWVtWWpWZDNTS1pHNUpZZytOS2dvWnc3?=
 =?utf-8?B?QngwNHVaazBURFIzSWE3eXBhck9HY09ibXBPRE5kN1BKODlwSFlwQUsyZHZD?=
 =?utf-8?B?a0ZoaVJXRlNtTEVlWVJPRTUxcEZ6c0pQSXlHb1ExNVlubHNsQUVPS21INEhS?=
 =?utf-8?B?ZFlZZ1dnYnhNVFVGUXZUTVJuVXpaOHNKRHlZY3oxWTdRMitiNzVLMk5VWkdR?=
 =?utf-8?B?NmhTZXp1eENhbXJvVEVJaHhOaXhBNXlsUmpWV25EZnRhS0NpdHA5ZzlZdmdX?=
 =?utf-8?B?T09pU2tPcmplS2J6WU9tU1g2MmF4WGFodG9uZ2Q2SlptbW9yNXY3Zmx3MThj?=
 =?utf-8?B?L0JZNG1YWkRIRUtJWWpCYzEwcWFCZkxPVFphUm4rak9WbE1iVnJqbEpwWmt5?=
 =?utf-8?B?VVc1dVlVVm5kQ2psTi95VzZObCtaZS8wVGZVN3V0S2xkWm1OTXdONGN6T2Rt?=
 =?utf-8?B?MFkrRFhLVnpvc0hBZEpDbkZYSFVpaEw1dTdqZ1o1R2tCdG02K2trbm9LVHd6?=
 =?utf-8?B?d1BpWEd3QWw0dTdXblkvWGRFcDd0ZUxZQWJMaEk4QWUzQTEvRTh0NlRITkJP?=
 =?utf-8?B?cERqZmhVL2Q0YWRtcng3QVpYOWowcGo2K1owdW9qaTFvRG0wcFQ4T3dxS2o2?=
 =?utf-8?B?bEkzc3NPWFVMKzd0c2JVNXNUOFJUYUllaHltbkdocnlpVVo3MlVUNEozZVhN?=
 =?utf-8?B?dWMzY3Nld1J5OXdLZit0TDQxeGk0UzUrYjBYS1Iyd3hZbzBKWlUvRlc2aHZL?=
 =?utf-8?B?NnB6NTVmNEpENFZkNjNUMEhjaHdtVk8zY3NXQ1pSekNOZGEySmNjcDBzalgx?=
 =?utf-8?B?RGU0UTQ3Ym9KQkdWODRFbERxZkt6bjg2K0FXb2F3azJna3hkb2hyZElyOEFO?=
 =?utf-8?B?SEwwTjBydlAydU5qUTBaa1Vma3c1aEtJUUdKY3hkVWRKRmNBVlFSTit3djgv?=
 =?utf-8?B?ZkVqbGY4NzR6YmxqMXdYUlQ0TVk0YlZUOE9RUlYxTXh0SndMalJlVXlGRk5J?=
 =?utf-8?B?U1ZFRFhqME9DTWIrRnY1WDQ5d2hsb3R1WVpQTUlIbG9YNytRVFVvY3pRWWV6?=
 =?utf-8?B?Qk5KOTJmdWN6Uk1yYlVHZktkaktOZll6aGtJdldMTXN6Y2hDSWpkU0RSd3pD?=
 =?utf-8?B?ZERpQnpmdjdESzlFYWhNYnFnWVpIS0k3ZlZNZ1VxQzRRYzBhYUJ1WWw3dXlz?=
 =?utf-8?B?QktpeXBSbUtBZFltcjlVZ3MwdjI1c1JQVXE0UVBmU25KRW96Yy8xaEEvRGdW?=
 =?utf-8?B?aVJDRGM0UXFIeklvNFJxREZkNXNvMUplK3JtZ2QxR25IdjZWWENIeW5ZeGxi?=
 =?utf-8?B?ZkY2YzZEYlhlcDYwcmxINy95QkNVK1hZQm1JUE52Ry9CMElyaThLMFhCSGla?=
 =?utf-8?Q?aBhsXEi26w51KSJNs/iiYi6jnk/ECIT7Qfk8c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aklzVmVLZ25kUWsxd2lQUXA3K3h0Y09MTk41dDFpOU1hUkFJTzg2NERiLzIz?=
 =?utf-8?B?SEp5VHZWMEVnaVdYNFY1ZEx6VHNDVkFYQnFGdUlPb3lTZnA1aTFsaWIrVWJ4?=
 =?utf-8?B?OWFqR0g4STVwUXYwVThISCtOaHAxRDZXQ1dDS0ErQmU2cEgwOGo1T2gxbzdu?=
 =?utf-8?B?Y3BsdDdQUW5UYWF3S3lld3FRQVdscEZRK1NCdVZ5V3FwQ1RTQmpXQjVoM24x?=
 =?utf-8?B?c0NPdmpkeHpjcXQ0aWtJUkkyYmE1U01walE4STZVOGVrNk5xYm95WEVqaU9X?=
 =?utf-8?B?U29YaTJ3L3Nkd05JMHp4a3ZwWkROL0huWEVEMHg5VDRiVnRIOFp1SkdQYnE0?=
 =?utf-8?B?YXBpNFRoSGo2NWhPMVhWaWhGdzNTQldnb2lBTjg1cUV1dm1IZFc3STkwSGtl?=
 =?utf-8?B?c3pzNUNSQkZoNHU4TmgvWmF2UVJGTWl3QUtSZ1g4YUFMY1NlNy80ZWs1RkJF?=
 =?utf-8?B?aktBbjZzNll3dkRFNjB5MjdFTitGZWxtV1NIR081Qmdrd2I1NHhmSUtLd1JI?=
 =?utf-8?B?S0dSQW0wUzdiamdXRTYzUlFVcjFHeHMxVFIxanVYVFd0SW51aXVQcXRJUnFH?=
 =?utf-8?B?RDMxUEhyTnduRDlKQ1RTWURvS3p2c1pxOXpBay9qSmFQbGxjOGRvN2pZUXdk?=
 =?utf-8?B?NzNON3ErRmUrWHF0dkxlQnV1YjZVenRicFp3QkpMOWQzaU5RTk1IWDRTWk5s?=
 =?utf-8?B?czU2OTA2Z3dSQ0VyWjNFOVJ5VlZPNzR1d0J3SmxOOFY1aG1FUWgveVIva0Mx?=
 =?utf-8?B?Ny82ZXlkSmJFTTBEMVNhaHhtUldXeVpjSWNKTllnTlZ4UERMMVZoczR0TVRJ?=
 =?utf-8?B?STdFT25hZU5nQVJWaldxbTMzRHZvRnAvVlBSQThlNzJrdXhYZDl5S1BVWjNO?=
 =?utf-8?B?YURyNmx2UjkvVUtOeFlXdElYa2pWNll4Qkw5VDZXNlZ4ZS9idU5xNUhEeVNw?=
 =?utf-8?B?TGlySkdQOUZ3VFgyWVVpMDFQbVVGbllyelY1SUhwRmRkNVpTTHVzUXFmU282?=
 =?utf-8?B?Vkx2NHgxUXV1TlZNamQ5WTRqcit1MnQwWXIyQUlZR3p1UWs3ZTBwekxDeFJ0?=
 =?utf-8?B?VENONCsxQWxzY3dxTDVadWZBRGRrZm5nYmlQRE9KUGFmVTRKWXFrdWJvMisz?=
 =?utf-8?B?c3ZYVlRCdEdaQkV6N3VDTCtlNkRXSzBURHF5VCt3eCtUL0pUVWVhbXNySVd0?=
 =?utf-8?B?NXJnOXZzYUZ4V2pzeU1Gbm1KMmR1UGpyempkN1FJbklKVW93eU5STVdpZzZD?=
 =?utf-8?B?NjM5UmxGWm05cnRzYUJKRENzMGJRZlJqWHMyQkRsOUpqVHJWNUdONTVhZmxU?=
 =?utf-8?B?S1NNTng4c3ZDYmx0T3JQWjc2VTdwTU1CODRHdmtSSVk1am0wb3FMLzJ4MkJo?=
 =?utf-8?B?YXpZeUV4NW5wVkFaYktHRWtZZlQ0cXFlSGYxMkMyTVRSdzlLU1FNUVBlc2VP?=
 =?utf-8?B?VUNvcFUrTnVoUXFhTW5ZWjF4VUFxQmpXVVByQ0kvUlhsSkNsbE14eTFmUHNj?=
 =?utf-8?B?Y1JMbUF6WDhIcVVnTytDM2dUdHZMSmx3d0hmUGdIR3ZvbnFHWlk3TXZqN2l1?=
 =?utf-8?B?bWtXTENuZWZoSGZSMkhQbDV4WE8yUkcvQXlGSTltS0hMSGdCTDBxdXBVcWdQ?=
 =?utf-8?B?c09rall6TUZIZ1pieHZzYkNQWVorN2ZWWE0wNm0zUlBKZmRwSmdYSG1YdDYr?=
 =?utf-8?B?My93VGZJWHYyOG9JL1UvRFlZeit6bVhLZFR0OTVjZzdXVW1XbCtVSDBRMFE3?=
 =?utf-8?B?dDR6Nkh6SEVnT0xBK3htT1lTY2Z4dHkrS3MzMXVRMWpiaXJVVGd0dVQ2MVRm?=
 =?utf-8?B?UjVLNXJoeXRQeS9LenB2b1N2b0ZuaERLaTlBNjhVb001MmNZMTdQbFEzRFJH?=
 =?utf-8?B?bjk3dmJQemw1Y1U5czE2UTdXL3M5QUNObE1YdktGcGhwT0xiY1g2UytyR2Ux?=
 =?utf-8?B?ZCtrdThlMjEwSXpYYWpSZDBNbzhUZ3ArZTR1dk5jeFk5RXgvc1l2RllPOUpW?=
 =?utf-8?B?U0thTUNuQ2RKdkpERi83L1VIaW4zZ1F1WlNXZHZ1cW13UmhaQzRxZ3dacUFh?=
 =?utf-8?B?bWVXUXRLN1VGbzFlZCswS3JNaEFpd1NuRUpVRlZqVEhmTWdPemlYbkI0TUt1?=
 =?utf-8?B?L0ZxL1VibUhsYTArMWtwZENZOTQ1N2YvR3FZM0xzci9RV3JxWCs0cFp3dk9Y?=
 =?utf-8?Q?gFAJmhmxQixFbPNEDUzdveo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8F467998AA64E4D9066CC0348647070@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f17b4c-a9b1-4e7f-862b-08dcd61c58f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 06:54:01.9190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ixyNwtK7cLAldXQve3lDzAEgXXvq2vIkzbBHE+44Yygmrlc1LPcNVk3lIBFNqY2omJ8cQGLJL0TcSZv9I+bpRzoBRIlmI5IvfmvWDMpMzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7955

SGVsbG8gQW5kcmV3LCBWbGFkaW1pciwNCg0KT24gRnJpLCAyMDI0LTA5LTEzIGF0IDIxOjI3ICsw
MjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gwqBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCwgYW5k
IEkgd291bGQgbGlrZSB5b3UgdG8gbm90IGdpdmUgdXAgb24gaXQsIGV2ZW4NCj4gPiBpZiB3ZSB3
aWxsIGdvIGZvciBhIGRpZmZlcmVudCBidWcgZml4IGZvciAnc3RhYmxlJy4NCj4gPiANCj4gPiBJ
dCdzIGp1c3QgdGhhdCBpdCBtYWtlcyBtZSBhIGJpdCB1bmVhc3kgdG8gaGF2ZSB0aGlzIGFzIHRo
ZSBidWcgZml4Lg0KPiANCj4gKzENCj4gDQo+IFdlIHNob3VsZCB0cnkgZm9yIGEgbWluaW1hbCBm
aXggZm9yIHN0YWJsZSwgYW5kIGtlZXAgdGhpcyBmb3INCj4gbmV0LW5leHQsIGdpdmVuIGl0cyBz
aXplLg0KDQpzaGFsbCBJIHNlbmQgYSB2MiB3aXRob3V0ICJfY3VycmVudGx5IiBzdWZmaXggYW5k
IE1lZGlhdGVrIGRyaXZlcnMgcmVmYWN0b3JlZCBhcw0KRmxvcmlhbiBwcm9wb3NlZD8NCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

