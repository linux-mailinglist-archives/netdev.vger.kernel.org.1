Return-Path: <netdev+bounces-299346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RTgLNympL2oAEQUAu9opvQ
	(envelope-from <netdev+bounces-299346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:26:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 613516842FD
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:26:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=sratmR+D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299346-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299346-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2298A300D91F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9033B9D9B;
	Mon, 15 Jun 2026 07:26:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D23B52F4;
	Mon, 15 Jun 2026 07:26:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508376; cv=fail; b=UJphvQVIme+I3M4lmfP+OZ5ezbbmyD4csf8LWErzb4LQJQ61kWqGGOrt/9xDGG9ANUpdJPJTeRLfC7pBoowmcBCEWg6eg47C6RPvO6So6RELe1xfRRhJ0jOSJZCP9sIaEf2yjQ8KkbTbHhaM3iM4fGtrQmRkC/f2MICP6ylaFNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508376; c=relaxed/simple;
	bh=xXzV7w85bD1Ev5YbVXlfjQqmMwdAV1nIusUxB53P0z4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zdw7uyfEfUZ6WNfoZAXhlkcKtlliy/R8tQb+U/2SO6UAUt0fkJSoldMnS/ZDp+IaTN2K3EVpwZUqugviprz06BsVwMY/gfojptRZqqjsL4TZs25QrPHgu27Y88I0klg1GBvAwMOWGc23Qo2ByxpTwqROyZuikKvitZ+jICVSJCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=sratmR+D; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTD627tVz/YHNn1R52E+TmSkV3fQZ/O6W6Cql9OItPHRuywnJE1MB/PBaXsmVhkJM5z8f68aoqSxPduvS+xprmHME+nhrpeVVZELZ+b5nf+ITdc60e9VzUimpht06w89GXfvZe6w2Xa2y0FsRfjRM87tqqXHYdEnraT231UH5ie8WWGntdpoFUZWiPgADcvxr/x8xKki5rTukLVrpk1F1Lj1V29K8ePD78V5l8CUnVZWqJXqVrplCS+B58ZWWZ+UzGaVIzlzx6QRczT/1X7LwEJ/CyUx0k1OZWkbf3wZDds69Pw3BXv3jhYL+e/x+Dz+HQwufA4r2+GkGpZoRaatRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXzV7w85bD1Ev5YbVXlfjQqmMwdAV1nIusUxB53P0z4=;
 b=ibgZzv02ycMDVH8qmqavABGfmFB+NU9qYs4nif08wDVYPnanLItV8n8hXUTYtSmUf2iThZDTWrCTILs4dRDXELYZOV7Rqqjxu1T2jUTFied9B6sedO/SisnR6mtabKw3eotwepgHfSVnQyhwYfi5i43UzLm+/lhajI4DHVYnE/QVNpGpY7RidP+jQDIDKRgFhnu1ZBhi5s5PM7dRoF0ROd7SIij0RH0MDs8Ao1BfbhpZANcQp+bFOk5KLDo7dvVQDbfBleXMmdSE8Bf9/NLUWWQw6EPT88oJc1TjPioRn2ut/dJEFx2/XJgg8o1/bVktbfz5nUWLUxTi+1nENQr46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXzV7w85bD1Ev5YbVXlfjQqmMwdAV1nIusUxB53P0z4=;
 b=sratmR+DrJvjoJhUZZfXfzW9IKc6Ad8IWf9swc4+9cO9FqvDw/D+cQnLfiNPbMkB1t8nJE/r+SnUv6k7atxiqwztdLKeHyaM+NIlq0OVzHdt/T6F/cktcFYUNnhyGc/Vffl6xwt21phkG5GJZS3yBvx5vwRCNh9uIiLDtTFyIw55rtTii6beQVmzMkllj66WUbMMmG6rLAoK/X1WF3FZ/2g8wNE1JPoY18kn5tmG0grQ+oA3CZoCh4/AG4M+F3F5Njsj7qVJzl6/ZFIkChbtE7SW/0VF+MV04uCbmsnsySWipTpugOrL81V7rFKb+mYb2gt7HkSrp+JIEqpRPnV7YA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SA6PR03MB7878.namprd03.prod.outlook.com (2603:10b6:806:42e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:26:13 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:26:13 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ethtool: mm: Increase FPE verification retry count
Thread-Topic: [PATCH] net: ethtool: mm: Increase FPE verification retry count
Thread-Index: AQHc9Jbq62Y8TJUe2E+DsI48lz9PkbY28/YAgAhTW4A=
Date: Mon, 15 Jun 2026 07:26:13 +0000
Message-ID: <5b43bd71-98d5-46cd-abe9-3333ce048ea7@altera.com>
References:
 <20260605025631.2872-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260609171750.7c5709ac@kernel.org>
In-Reply-To: <20260609171750.7c5709ac@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|SA6PR03MB7878:EE_
x-ms-office365-filtering-correlation-id: c8c060b6-2f19-4477-cdb4-08decaaf6138
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|55112099003|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 s+xhbqAQ+z5p3hchAFrqSevwUetC3RoXaJOMf0NdJsNqfB5CNVMdO5wQax4kbB5zQWSqlyizVXtR+53Q8BqwYLsmurexjcNPDO6gO2NY/9w8kSMy1JekbD1YF/UGmvwceoPVnWON4qXA7s/Y65wkM0cuETBZYbmsvSpZsbFBAHqF5sezFEGgFD+U2czQGipd8MDBdf4MmNNST297i2DHCtzE8lxbWavhze6+Ch2JZvuSRHQMQjKYOcgwxIjj4zGtkMd/qW2SKflX7GGJ79g0GjyjcbzlqMH5tMmCh/iD2mwF+9u+Nl0bjeVIPYfUIFfChUH7hnoOmtnA3VYZQYT/1mswGjwiawLwYsa5UUaB1PNbkra5Zs7zcf+5RPiMkAtgRvB88rWOXcBQUPM++vk7dBU/w1zYc2n2SB1wqX6+GbCfYLWvzjfKOD4Z32l0GjtrXZls1RLcIcL/t6xXmsUHcsl9zD+Fi4KiGv/pkfdi67HLp4seh8EvKXYWp0/6s/1r/Oc/qG1OHCh6ybMRWOLRY6CW/IZc/3tK5Sj+7AOOJUqKgAkTCwgM32hP8gUSsjKwtRsrkC7BQdI+VsGAIA0+F+YeG8/8iOlaBNp70s94iC8y8DWG5wULsXg1+KBpvEpBMW+9k+4wPPzy7IhL4RubFQP0wfg9noeKULxh/gpHeiGCo9AniLdGw0BEOrJAI5la/XUPKlsVg5Y5UNuk1i3PWR4xl99k2jEwOATgkxZRUu6t63nYPlNo74WrtrQylKPC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(55112099003)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2NxUXlTeHlxS0hKaDRkK2JRYTRNajI1NFhrL2ZTeTMzV2t3V3ozaXF6SVN4?=
 =?utf-8?B?ZW5qUEJxbUdOclBTVC9wTUFaRmNrQVA4WnBaMEx5b1dRekpFdTJBSXg4Y2ZE?=
 =?utf-8?B?RHIrbmZidEtlWkNUR3FUa0pLZnB5cjkvMmNBbDkycWg5ZHZNRU15YjJ1UVNo?=
 =?utf-8?B?UWwrTWlLN2lnbmY2Mm5FakEzNm45U3N1by9KeUxBVUpZRCttdDhENmdiZFVn?=
 =?utf-8?B?YmxidThpNUoyK0g1d0w4Wmxnd1pzN0tWeHVuMU1FK2ZmYXBlNlpnaGtPV296?=
 =?utf-8?B?VDdLaGZqb2FvbkJOd2RkUU13ZmM4REJnemM4c3BoUXZkcCtEMTU3MWVYSUVv?=
 =?utf-8?B?MFN4cUM0VWIySld3K3UreTVESlBucDNuRjQ0T0gyM29yam5aNHNINjJ0NHVt?=
 =?utf-8?B?VXV3OTRyb3JYdEFTcW9WaDUxbGl3SnUzZGpLenhOeVNiUlpZN2hLSGxaYWkv?=
 =?utf-8?B?K2llYWVoVW1sZG4yMWpBd3NSTlhhSHQ0RnFydHhNYk5GRVRJWlZpWFpqQnBu?=
 =?utf-8?B?YnFCS3RBb2RDTWtSVEpveVBCUHoxQ1lZcDB6bk1SMXoxYVJMNmkwcGlXbGNM?=
 =?utf-8?B?akFLVjB6V2ZPMHpjYTNwWUpHb0pWcEZnRGRzTHZXVzdhTzlFTmFDYXZRRUgy?=
 =?utf-8?B?YkFTZFBqeU5qbVhNQkVWZEVYSGk5MldyQndzYlBRQnRtdU9BcG1zeW5MTmhj?=
 =?utf-8?B?bGsvVFFxRFhEb0lmMVpQSjROUWlVYldKVksxcXdsRTlORW1wMTY0RjJ0RlU2?=
 =?utf-8?B?RWNjWGYvREJuNXJhTTIvdUNXOEVFNnNuSVR3REszVndxd0pVZjZNU1Jnek95?=
 =?utf-8?B?S3hUQnIvaFhrb2E1WjNGdmM0bmd4V1dzWDJxREd5UTJaV1JUY3ppQlNRNmh5?=
 =?utf-8?B?elp3Mk02OGU3Q2RLbzRaMzJXeUhzNFNmWGJTdS9QOHlRVXB3YjVsWTltSERp?=
 =?utf-8?B?aXZCV3RUYVZvWlBpREcxT0lCSjRrc1Y2bWQ4dHZhNmhtR3ZaSlZyUGV1L2pp?=
 =?utf-8?B?U0lkeFBwQUI1b2VRQzJFWFZJa2dpbytxa0dBVkF0VjBGaWVkY0pDZmpKT3Zr?=
 =?utf-8?B?YnB2Q2sycE8yc2NxNU85THljelFZMlh0NmpOcjdhUW5HcTF5UkUzOTNYYk1K?=
 =?utf-8?B?VzVSeS9TdjhZVmNVU1BkZlREcnFZOWNycDhTRVNpZksxMVpPYTJxSldNejg5?=
 =?utf-8?B?dnB3VXNGTmNmMGo4SThJME1nQkEwWkN1VkluQmpNVWJpeG4zQ2l3MnJXcFlD?=
 =?utf-8?B?L3ovTmNPd1NBVFNOZ09kWFArTVEvZElRZ2RIaUFGNDFxS2Z2MW5kZThyZVpL?=
 =?utf-8?B?alpvQSs4UG4xQ1Y4d0Z5dkl2ay8zT041S3M3NzJsUjM3WnJ2Y3NvbTRDRGI4?=
 =?utf-8?B?V241UTdDQ1dacXVJWHRuVXQvc1FYTzR0bkliWmlEY2ZNUTA0U2g0Rzh1dGtj?=
 =?utf-8?B?VC9lMU56OFk3bHdFRXVKK05lblZvTlJ3U0UyTGJtNi9LbUo0RzhlUEJRaFVt?=
 =?utf-8?B?S0Y2cjVzaXh2Yk96cTNkRHRSMmY3dUxpUXdSM0pqSkxyUUF4RmEzcGU0UEdL?=
 =?utf-8?B?d0cwbFhudzlFQjNmUVRxbHZvWUxTUldDclZCYmdJeHpSYmtqSlNTZE5FanBG?=
 =?utf-8?B?UGpjZTJObnJXZStndXgwVUtLRXZ1MWxXRDYyNE11emYrUW9ubEpNZnFtdnlB?=
 =?utf-8?B?MGNKQ01XMERlcnFWbkYvQVVwZUxFcExQNEpzMndHUm9YOXZ1V3pNSmhVd2Rj?=
 =?utf-8?B?NlNMVnI4REtNWXhKZTRFclBnTzg0WlVTaC9GckVLRWt4QVIvMm9ZdFlMMVR2?=
 =?utf-8?B?QnVMS005V2dFZXZaYjdaMkpaWFBpanZTUmtaNHZORVdFYlBiZ1FpVXNZa3Zu?=
 =?utf-8?B?SEswOUpWaGtTa05hcE1wNmVwdjByNXNiQ29PUmZKM0NpeFh2WjNwVkxvU0Rj?=
 =?utf-8?B?NDUvRENuMFZqaTdUZWZjeHpsZnZKS2oxZjJlVXg0U3BMV090cWRWRVp0Undt?=
 =?utf-8?B?TEFscmRQVndRWVowS2RNeHE2ZW5lbllYOTBvUWIyR1h3WnY5U0JKRi92NVV6?=
 =?utf-8?B?em55dnpSaHEzQ1l0dHNJdldkVmYzYzVXZi9McmdKbm43THVUVWhtZ0o0a3BG?=
 =?utf-8?B?eSt0VUVBUFFVSHJHYzNoYlBJMElIenRVY05DNldqY1NaMUY0eE55NGNyeFln?=
 =?utf-8?B?aVhOd082VERHTXZGQlM0cjYvZFZLbWJXbDBrN0dQRmMxdDdOVVM5aTVFSjV2?=
 =?utf-8?B?REl6bUxiNTF0bVdReW1xdWNYczRON2tnTDExTTIwMklKNE5OVDFHeU9ieWdN?=
 =?utf-8?B?Q2twdlgxSTlseGN5OWVoRjVCOFladWY1N1llZWM1WVFmeHJhMTUvRXNVZFZG?=
 =?utf-8?Q?hY6I3YjakCh5k2qiEsAl7hM4Ycy/e1HXteVcM9jeMG+g5?=
x-ms-exchange-antispam-messagedata-1: pool2fDklnMzzQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8253A522175D3B4FBC66528334B02428@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c060b6-2f19-4477-cdb4-08decaaf6138
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 07:26:13.1866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAgXUr2d8avPZgh++Zsqu7srCtzgedxVh4ckC4P0pUPFDE24LDDcJHc83vffOKzZxME8PeEWY3PBKDQwtKlkNrfqmNxOOmz+pMEEEKXmFttPmPhcZv7Igf4gjL9sG7BOL2CYgN0oC6WUPJQKfhD8mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7878
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299346-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org];
	DKIM_TRACE(0.00)[altera.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 613516842FD

T24gMTAvNi8yMDI2IDg6MTcgYW0sIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiBPbiBUaHUsICA0
IEp1biAyMDI2IDE5OjU2OjMxIC0wNzAwDQo+IG11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5h
c21hZGVAYWx0ZXJhLmNvbSB3cm90ZToNCj4+IFRoZSBjdXJyZW50IEZQRSB2ZXJpZmljYXRpb24g
cmV0cnkgY291bnQgaXMgc2V0IHRvIDMuIEhvd2V2ZXIsDQo+PiB0aGUgSUVFRSA4MDIuM2JyIHN0
YW5kYXJkIGRvZXMgbm90IHNwZWNpZnkgYSBmaXhlZCB2YWx1ZSBmb3IgdGhpcy4NCj4+IEEgcmV0
cnkgY291bnQgb2YgMyBtYXkgYmUgaW5zdWZmaWNpZW50IHdoZW4gdGhlIHJlbW90ZSBkZXZpY2Ug
aXMNCj4+IHNsb3cgdG8gcmVzcG9uZCBkdXJpbmcgbGluay11cC4gSW5jcmVhc2UgdGhlIHJldHJ5
IGNvdW50IHRvIDIwIHRvDQo+PiBpbXByb3ZlIHJvYnVzdG5lc3MuDQo+IA0KPiBZb3UgbmVlZCB0
byBDQyB0aGUgYXV0aG9yIC8gZXhwZXJ0IG9uIHRoaXMgY29kZSwgcGxlYXNlIHJlcG9zdA0KPiB3
aXRoIHRoZSBDQyBmaXhlZC4NClJlcG9zdGVkLCBUaGFua3MgSmFja3ViIQ0KDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNjA2MTUwNzI0MzYuMjYxMjgtMS1tdWhhbW1hZC5uYXppbS5h
bWlydWwubmF6bGUuYXNtYWRlQGFsdGVyYS5jb20vDQo=

