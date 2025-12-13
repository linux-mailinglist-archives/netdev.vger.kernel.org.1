Return-Path: <netdev+bounces-244593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2240CBB061
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 15:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 704CE30069AF
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD8512F5A5;
	Sat, 13 Dec 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intrigued.uk header.i=@intrigued.uk header.b="FSv4DI47"
X-Original-To: netdev@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022138.outbound.protection.outlook.com [52.101.96.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64562E55A;
	Sat, 13 Dec 2025 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765635355; cv=fail; b=ikQWi2c084hE0/J9/nm31ob0eetj/CUni723Q5n4gZiW2rXO94BWW45o2UN2Hdj1m7ojdjDkqccAdJD2EzDrEm7VFLFYX+MKo3OPswZaYhbVrYug75RqpAR16QVrt7lhgFAd+iWpcGpRJOLGBCDmnxDaWYYZIwH7IQA44/FgOs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765635355; c=relaxed/simple;
	bh=6fdi0GU5mbiRh2E0+MD7WMgWTHertUo4RmRxhBvMOwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JXBT5YigfYzD0phcUX6i1X3j1qtwo9MbfewUFnF3uF2qH2v/ESuQs+DbGke5DIdFrsLD3tE/FNUKG+wyVYOki5poD1bL8Oehv9jc0G9InfBI/RRB5PzdxvAftQFlqYAB7px/zSllVxxiSkPhRcSX2XToiJ3cq7Hf2FflWb11UxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=intrigued.uk; spf=pass smtp.mailfrom=intrigued.uk; dkim=pass (2048-bit key) header.d=intrigued.uk header.i=@intrigued.uk header.b=FSv4DI47; arc=fail smtp.client-ip=52.101.96.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=intrigued.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intrigued.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zV6Zu1ZGpYi5Z17T23VahodX1KlN6owkxtfmQ4kgGCk1+si+M95X93lrnYTjjLRvDI1yQUead3j56SYGXVBqqgsSblVLfl2xSkYc0onoEg7AioqiP4svZEAo5A65i/Xsm9NeQW3VFoeRCXTlYvTkKTzIpiFVezfzXl6MmRJyRqQCd2h9i7IR6pwIIjLTr1RuZQT33vPYxC3BXVS8xe+uZ+kpRt5LLjaccYMMwydIyL33E0tucbju8mcDBIvnzL0hbdYN2Xg9swh5mnZTP8hhQzYF4K+TM0kiQIVoXSC2y6Ab27qoy51m0YP6O1x8nsPurloNsBU74k7EbdE144wEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fdi0GU5mbiRh2E0+MD7WMgWTHertUo4RmRxhBvMOwg=;
 b=QHeVsxacZj7X78YBdJpm7jsh9M/Q/xpyiDdonA0Cgl9YqENtwcz0gQmVwzLIfRzvqV8OXtEtnGlrkYsN128Ut95ZkbNIS87BXeDVGwwL76Pr8Axxu7fXYdofwWfudMXUZtxtLvlHuOdPyReLenN1l3LvQDBJqSGvgKNBp2IMkr+6r1OoAOzykj501fwM9QQiI7c3wLsQjNkkrp69kDpZeg5q7f+OP/8gk7c6rO/hr6cNs4QaTzP++SjqQKLyDmbUq7iBhJdXe7rHSJeuv4gDjMN7SizT6iWUQh5f5AV3o1Jz6r4alsJzaTzavgjtNNhb7nKBUNOlFhggi8ehtPmfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intrigued.uk; dmarc=pass action=none header.from=intrigued.uk;
 dkim=pass header.d=intrigued.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intrigued.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fdi0GU5mbiRh2E0+MD7WMgWTHertUo4RmRxhBvMOwg=;
 b=FSv4DI47+h9HG1M+D2M/zAweQeCULJSVFVgbi7sjsmCyElo/vEJ1UtFKuRzBAnt6lje0AEEnHH7irRRoVUlMxDrOMB1ng0mKbVnmXT2u1ZflwUSUG0BSOAxIdKh3bLToif+FlkWH9L8J8LXT/y+cULHvhlGLzApWYoQImULu7wBN93t6WJKnoT/ZugD1iWO9DED7mmyvL0upUb2WtL9xale1o3bMyPUrIrW2sqDM4VC1HM/g872sQs3aauSnT2kqyIcUPd2AMqVYcxiL1YLH1U0rv8FbY/tXiqSUcJsh+MXhHaAFLHmGBCsn27TNte1uF3O94Sny4JAfAFVghE0Y4A==
Received: from LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1f2::7)
 by CWXP123MB3303.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:75::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sat, 13 Dec
 2025 14:15:49 +0000
Received: from LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e23f:f6b0:a91b:4ec2]) by LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e23f:f6b0:a91b:4ec2%4]) with mapi id 15.20.9412.011; Sat, 13 Dec 2025
 14:15:49 +0000
From: Joseph Bywater <joseph@intrigued.uk>
To: Joseph Bywater <joseph@intrigued.uk>, Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: net: qede: QL41262 unable to TX packets with multiple
 VLAN tags
Thread-Topic: PROBLEM: net: qede: QL41262 unable to TX packets with multiple
 VLAN tags
Thread-Index: AQHcJn2cFn2rGKXZMEChDGMnh2C9U7UgKF+r
Date: Sat, 13 Dec 2025 14:15:49 +0000
Message-ID:
 <LO4P123MB4995BFCDA6A7CFCA8850BC52CAAFA@LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM>
References: <aMh0GP2KFOi5FJrd@intrigued.uk>
In-Reply-To: <aMh0GP2KFOi5FJrd@intrigued.uk>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intrigued.uk;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO4P123MB4995:EE_|CWXP123MB3303:EE_
x-ms-office365-filtering-correlation-id: 8aa54a91-3ace-4b33-2bc0-08de3a521e0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|7055299006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?eUpt3scTpK5VnqWTHL1lU5gXtpbqM1CquMfjVOVNfkT74zg3op5vyM2JfJ?=
 =?iso-8859-1?Q?RrVQbnKRKv8nBR0tWF1Yi56Y40W3H1rUoQD4VDOhtwyuMVsRDDr/kF7fLf?=
 =?iso-8859-1?Q?Br48rRE8ECbIl8SB7uI6jgmxStf1WGtGD3Fz1RAHRjP/nst+uaNtMeeJnL?=
 =?iso-8859-1?Q?RZIMu0f8byodTMgvCbPlaSkxIBa7x3I09I32clVLDmIeLFvSQ+PUBcZ7Au?=
 =?iso-8859-1?Q?G7QfF8Xv59tI63vhGsySsXXIivVoIdwB5dzi59DOxjKrQVZPNnRWmHf/98?=
 =?iso-8859-1?Q?qAVwPzOAD8rqBzchqeONPeelre0YRhVz7uWvfAONooeeDvNhIi/lJ2i4PN?=
 =?iso-8859-1?Q?AWUs6LOA/DbmcLwMIqog72QE3NJH/NlsufbDYBRbzoN3mRHd65y9s2uTRD?=
 =?iso-8859-1?Q?TTZk9KnmlATiz2FQjnh5prh7n/9wYzbr+5HDQ8OohsqOQONsxcrHg/fZBB?=
 =?iso-8859-1?Q?zLdzHlCjYI9aSBHZgz9HwtZvicDf9rpZkHfv4hgpCwAdXtT35u3Cs8xS+G?=
 =?iso-8859-1?Q?oXywYklzMKTU3jxqkdLpodzMgXMhbkPhEgrYKH7RV5UuDqkOiUJ+qLS1au?=
 =?iso-8859-1?Q?AAt0+qMI+3Q1xtQ15D64yNSGwGTSBPBqT9+wlijA1y129FCvuUwlPMzOr2?=
 =?iso-8859-1?Q?7w5XwtNIf2GgmVnNauoqZjWd0ndSKarMnOGt6SSLGr1T+bjt1BzP07Rkbr?=
 =?iso-8859-1?Q?+TEfSGzqwFqu0W6d2lP7SDfxe2228vp0Gkr1BcKEzTNaQmEFopqr4RSyEJ?=
 =?iso-8859-1?Q?3wT0+QaUFtyF44qElDUYECCRy7OucJLjJJXqRiIPJ3itAzsOXkvUpseiP/?=
 =?iso-8859-1?Q?Jx+1tF1yuHWwWkNHFlLmqSjRrKBpxPQTgHF6mJcPPut/KjRbd8piZX//2S?=
 =?iso-8859-1?Q?MB1Hy/jIsJwXQwz4w/arPPfgYG5bb5q67+ZRCSHgfDC2KmnI7LxG6VvgL9?=
 =?iso-8859-1?Q?CTjoN7qcFMHPiY1vbcSPexcuFu61J9M38CP5kwLNDFhSBoIfbzqJKZDDd9?=
 =?iso-8859-1?Q?krtQws4YGm797DAOpao082oRj8xaW7wunOQIJnOxSrOQ4l4H34kiz3iuIO?=
 =?iso-8859-1?Q?/+k5qlYALvXcyT0HnrxrkphQgcWzZV+EbxGSYtcUtXFEMdLI0YQFAQDj2G?=
 =?iso-8859-1?Q?GwtkqodaHVMH78OjRYXhq3nkajjsWtEAyiS6aV98XKWabSfm3ZmV/ou8tn?=
 =?iso-8859-1?Q?eaZ2/GsJ4XgQ86eVLky/f+xfFwvbcNBoMEoLCN4atABpAutVSi+hiiK3be?=
 =?iso-8859-1?Q?zvW8E91m9ZYC1aM17FNxg7bvcf6kmqwKBxd7g/ni+XLlrYTCMAGMi9nIBM?=
 =?iso-8859-1?Q?XO4V44Fi+yVc+NLUXYRpcwOHFiJS8nun+CBOC4+ml80LXecNfGRktYolRg?=
 =?iso-8859-1?Q?ck7MdRmmmB7hVxXmYCQ3XUEU6QoZUpZZHcPFIfoFazOY5tbyX3vEHEKZxo?=
 =?iso-8859-1?Q?HA4mPELJ2+GGTXJlIw1ZiMbZiDqYJq42NveB/KfRtzAVxOjrTW2l4O9moX?=
 =?iso-8859-1?Q?IdXpp9bg/kEiCwk4xZVmSDQWQQ8FObGmnFDW+xhj1gEbe0A+I7yjGLwemi?=
 =?iso-8859-1?Q?v7sVKKhxI5XOnv6lv+X3YcLHP56l2PcKE2H99Jmu68MjdFk8ag=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(7055299006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CqQqBLhqJeUUDx2cM2KEidXUFD+CpmAcj0HFMWGKZwrUK7ImBbxAxAZydQ?=
 =?iso-8859-1?Q?FdD2uuFBcTYDSHl9LayVw2Z4tz2Waivuhln7eBgNYi4A1C0cZ23so/VMm7?=
 =?iso-8859-1?Q?Jf/XVSBMeoLKP8U07/V+d1juflGFw9YSxO8L518kQgO30ncFZz1mSm6zJU?=
 =?iso-8859-1?Q?Qih6HM1aw9AodwmHv5ORNjS7jRnIzsVpPG1HFjzujBR/xYWis5Mt5PtYhk?=
 =?iso-8859-1?Q?0Io7l17CHyrdnnmn7LWFByQJ2Gk8BwOE0DBLz4LiO1as2yeRtllnb+YLvY?=
 =?iso-8859-1?Q?AaejViRUD2oHK56PBepQyLD1ivHZWtnojXrQxEMl3gquXZMdvXOnx8S4CM?=
 =?iso-8859-1?Q?oktFhUBhYotd+/7dB+mPmy3qaGEXsEKhcNC1e0qGQ3EQC9Z3FyvLMJkaxF?=
 =?iso-8859-1?Q?TU5oJKt2mawobjvbhOnUi/YfY52RfgzhjQygQ9QB0CifSmp6kiluoPP/4R?=
 =?iso-8859-1?Q?VxH6PudPyVXLcwODNAdrY3xPwGnehYR4o8rfySJgMo/5VnrPxn1WOjKn8R?=
 =?iso-8859-1?Q?D6l8poYBmkZnssRPvk9wsPSsTR5HY70QXYGrVsoggEoqSytTQp0CKGmrIe?=
 =?iso-8859-1?Q?IHDcC772/UHBp4iYST5rL7Gn8VXzCK9xeZIiK2zpoDrNREk5fnMI9u24xw?=
 =?iso-8859-1?Q?3ECyK1j2xKdk5X6DZDoIGH57/eALm/2Gu8xs+9IwxV0o1vbDmv1hPIhhKb?=
 =?iso-8859-1?Q?xCbcBaTJlOnX67nsh369JGnYD+ZrKfT188EMXdk8DRjVRrZ6dSmBncfPzA?=
 =?iso-8859-1?Q?vs2MJ9zyLo8IlT3+53TZS0F5FPEzHQTfaPSHo5W8A+Zs9PUUDVml7zN3fQ?=
 =?iso-8859-1?Q?rb6zLaeTDeOeaZZph99abT1dqT7DCcwLGcD8ApXaSQxPo0UsE76RM0QYFO?=
 =?iso-8859-1?Q?4XxvMqbAoRI116qO9MdP28uUx4Xu742NYG5wiCAkl7wFVYyDKdAioz9ZR5?=
 =?iso-8859-1?Q?3qq7liCrv7LPdOavrmPAVqpeo0Q5Iwk/uX3ZK6U6RNPLCNPDxSgphE5re1?=
 =?iso-8859-1?Q?25LZY377pVICAyqGPQ+kybJ15nGWUVP09kL4jR3kIn5ifCvp0vrTmyrmmt?=
 =?iso-8859-1?Q?/ni1/rXRCMtNZpEFMSnwxVvK5s6xi1ccoEAFKicATn7Ud89VssAssP+bcw?=
 =?iso-8859-1?Q?SW+3Mnfg6VDogXIz0D7cQZMlQzSO4O07pFAPmpdTw939I8bTZLs/TtOZf6?=
 =?iso-8859-1?Q?7Nd2HpR4BT+9vKKuE/2sgm5WJoUY3cAOG5n6iZjMV90spT4oyg32oIeDvr?=
 =?iso-8859-1?Q?qA5HiViTT5XF97k91Pf1v0LSQUIUkhxhItY3HVpqeZIYqEYj/AN9Pafwqr?=
 =?iso-8859-1?Q?7XWfGemFq0IlHPcrjfeiGGgQt9fehI0WY+LzcKklCEYSkzwblUNdtuGmkR?=
 =?iso-8859-1?Q?29Yeo2fYlxaGDEJ5YeRJgrrl3zPbDo4i+F89SLV2aq9SzKqH3zPkbBkHc6?=
 =?iso-8859-1?Q?dMupBRUjUPmzCeL5Xa5G9mnoqT+9iMyfDw984rXGq1HhNeY5LSGCNMqRnL?=
 =?iso-8859-1?Q?RG6/xyecPob6GFpLQxiWbNzgRFO6l2KB8hR3w3VOnUEOiL+c4CYm+Kd3ZY?=
 =?iso-8859-1?Q?QBdrAa7FKPCTFOv9xSyYBqlcAXbpZeE6GeDPpbkxqJVEPnjAtJtj+YU6J6?=
 =?iso-8859-1?Q?02r5F4Q4qqyjb3+jv6iGNttJh/JEtbQGOpMt9MrM0rk5+GVFkYDBFAZQlX?=
 =?iso-8859-1?Q?UjQ1EmSk/Y1qo2IYAbBW5vSoIXoFvG2QZjO3gWUw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: intrigued.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO4P123MB4995.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa54a91-3ace-4b33-2bc0-08de3a521e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2025 14:15:49.9006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42dcc6dd-439a-483c-99c4-86bd4e2f0f10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbcJ1kmBKwDYROXG0YO4EmrweFI0DUga4f55Zdwani/Lpu5g0lf1nqKsERJ1dkr2M5xnFWdCmUk1el9WjsoYjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3303

Hi,=0A=
=0A=
I'm still seeing this issue, would someone be able to look at this, and let=
 me know if it's intentional behaviour?=0A=
=0A=
Thanks,=0A=
Joe=0A=
=0A=
________________________________________=0A=
From:=A0Joseph Bywater <joseph@intrigued.uk>=0A=
Sent:=A015 September 2025 21:16=0A=
To:=A0Manish Chopra <manishc@marvell.com>; Andrew Lunn <andrew+netdev@lunn.=
ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.c=
om>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>=0A=
Cc:=A0netdev@vger.kernel.org <netdev@vger.kernel.org>; linux-kernel@vger.ke=
rnel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0PROBLEM: net: qede: QL41262 unable to TX packets with multiple V=
LAN tags=0A=
=A0=0A=
Hi,=0A=
=0A=
I have been having a problem with a QLogic QL41262 NIC (using the qede driv=
er)=0A=
that is unable to TX packets with more than one VLAN tag. RX works fine,=0A=
even with more than 2 VLAN tags applied.=0A=
=0A=
I set up a test with two servers, one with an Intel NIC (ixgbe, .101),=0A=
and the other with the QL41262 (qede, .102). I created interfaces on each s=
erver as follows:=0A=
=0A=
ip link add link eth0 eth0.10 type vlan id 10=0A=
ip link add link eth0.10 eth0.10.20 type vlan id 20=0A=
ip addr add 10.50.10.<101-102>/24 dev eth0.10=0A=
ip addr add 10.50.20.<101-102>/24 dev eth0.10.20=0A=
ip link set up eth0=0A=
ip link set up eth0.10=0A=
ip link set up eth0.10.20=0A=
=0A=
I then attempted to ping from the Intel server to the QLogic:=0A=
=0A=
ping 10.50.10.102 (single VLAN tag) -> works=0A=
ping 10.50.20.102 (double VLAN tag) -> does not work=0A=
=0A=
In the failing case, with two VLANs, I can see the generated ARP response=
=0A=
using tcpdump from eth0.10.20 down to the eth0 interface.=0A=
However, I do not receive this ARP packet on the server with the Intel NIC,=
=0A=
and the packet counters on the switch do not increase.=0A=
=0A=
Here is a truncated output from ethtool:=0A=
rx-vlan-offload: on [fixed]=0A=
tx-vlan-offload: on [fixed]=0A=
rx-vlan-filter: on [fixed]=0A=
vlan-challenged: off [fixed]=0A=
tx-vlan-stag-hw-insert: off [fixed]=0A=
rx-vlan-stag-hw-parse: off [fixed]=0A=
rx-vlan-stag-filter: off [fixed]=0A=
=0A=
I have tested this on 6.8.0-79-generic, Ubuntu 24.04.=0A=
Additionally, I tested a similar setup with other NICs, which worked withou=
t issue (drivers listed):=0A=
- mlx5_core=0A=
- ixgbe=0A=
- ice=0A=
=0A=
Is this a known limitation of QLogic NICs? If not, are you able to=0A=
advise on further tests I may be able to perform?=0A=
=0A=
Thanks,=0A=
Joe=0A=
=0A=

