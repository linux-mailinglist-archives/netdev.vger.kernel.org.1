Return-Path: <netdev+bounces-280953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFbpAIAX62niIQAAu9opvQ
	(envelope-from <netdev+bounces-280953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 09:10:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CADF45A901
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 09:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F58F3010ED4
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B823603EB;
	Fri, 24 Apr 2026 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zPqSBZ+x"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013051.outbound.protection.outlook.com [40.107.162.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A027329D26C;
	Fri, 24 Apr 2026 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013803; cv=fail; b=qORpyGbaNX1ObJwyyCBSau3Qsfr+GV6Ec1/dHCU/CEkq8lmD6Vf1HMd6ZkPlHUcPf6cuQxor1E4jkH6rJRMapFF4JsbRGr6TDY6htGNghypVIb5f89hg9Bh+lQTXdjc+pkKCJZcQAh5n1w1hGToBOvUUqAPma0I/2IUgydQ1i8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013803; c=relaxed/simple;
	bh=Ko+OSNrmx1qjOl8H/53KygMvkuAfJcxhkkiIOglcVc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RBdBShXvML1jhP+4pCr3g7bX61g4I8gywcOEmeWd6esLi6eqYgjLtepJUuCRUIwSydcxoHUmhRLBXW0gupUCcNVLdmomUw/YsYr7Vzr0Z8AgDy6TprCpLgePyYMHT6qwxPJ71XjLprlp9xCoSQc3Dac+2HXGCg9XeKZFS0WUvLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zPqSBZ+x; arc=fail smtp.client-ip=40.107.162.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPVlEYh2GtYkxeve1+Rg5ZkbuLr+yE2D7syok0OseGeKAv6kQW7qBZccakFvOVqrXQmwlLAc4NodYDTdNyXkhcE1DG7i1CS1Xwqzwc9QkEeOymBLCkQ2mDF4W47MJerlWUoGiI1d3ZMFGF2lrwZqlLR/QZhxfmEPiQ+c8JBcjyCkMXbUARIh8743XYaYP66RsthqJ37RSgGdAly5R33Zk2RuUz2n1lxoPumaYZ8/R1/577qdmh3uvXXMS8Ju3rTRDgfpWVNUTTemfIQqH9t4scZ2HFJrlFtYSLrsRrSRTzs0Z50NtYfa3CxsyR4sVaBbMW4qTfzE/LIruju8R+hvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ko+OSNrmx1qjOl8H/53KygMvkuAfJcxhkkiIOglcVc4=;
 b=mbv62bgt9alc2sHYeQASpTor4sRYe8/qKH/uWRt/8S9pwwYmB9RY4FWWGR6zpXNFlapavE1hGei/pmDmE5gzxaVblw3NKhQeIwdZ6UezoZK1m6ubIX1K45DSxU/w2UPQobTXKdwhMlWEHasJj0ZP44wfPLBVLO8JIOK44wJDCZOF9tfUw37yy56KyAT8/LNDOm71zNDYUB3M5WNW7KM6PMTr+iPG1ecFooCe7M0BLFXJnCaA8zDUCEO/zUkKQ/kpIkg0hl2X0LVVDxTR6chtuZ4FmJDKh3WPNuK0Ee/VUCzxwoRnnBxmtN0FKNFaxolEhlBbsPq/xRqVW8cCbld/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko+OSNrmx1qjOl8H/53KygMvkuAfJcxhkkiIOglcVc4=;
 b=zPqSBZ+xfMS9uYkVoyZ4onzEd6bBGEpoGsT7SHXcn7NhEr6ji8vWTmQuvZ9r2P44Ze2NJkXNpb976m9dnpo7ZXFLugAyLxVeczoP1SX9oKeLFxdMRWph24dbC6i/l4Wk5H1BOkVdO94RqIUZOyi5xoqbOdN1h/cc5SqYBwJajbIyVGW96NUDbSTt0xtu+XepGl+uGwOjW6ja3/hyfCSkjPuhmE6f//T6fgGzIDiiVsFrbvplF9TC8RX1YYX89cxhYg3dFKrbjTsPLll/fcVXmwyajAPNq042kQAHb7aZ76lJYTfP+8RnU9KuGGCiztdnVfcxL29qoeCpx0wIL6nkaA==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3644.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 06:56:36 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7%6]) with mapi id 15.20.9818.023; Fri, 24 Apr 2026
 06:56:35 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"25181214217@stu.xidian.edu.cn" <25181214217@stu.xidian.edu.cn>
CC: "syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com"
	<syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: Re: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make_skb() when
 queue is empty
Thread-Topic: Re: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make_skb()
 when queue is empty
Thread-Index: AQHc0vpVeoTcRIl92EeHGwTTBtlFk7XsvbCAgADN2ACAAALigIAAOpoA
Date: Fri, 24 Apr 2026 06:56:35 +0000
Message-ID: <68628d54304821fe8410e756ce3f92c60da10e1d.camel@siemens.com>
References: <20260423082233.514056-1-25181214217@stu.xidian.edu.cn>
	 <willemdebruijn.kernel.28284ffff84dc@gmail.com>
	 <2ebe2714.7628.19dbd7d2b62.Coremail.25181214217@stu.xidian.edu.cn>
	 <5eabb1a1.7642.19dbd869da3.Coremail.25181214217@stu.xidian.edu.cn>
In-Reply-To:
 <5eabb1a1.7642.19dbd869da3.Coremail.25181214217@stu.xidian.edu.cn>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DB8PR10MB3644:EE_
x-ms-office365-filtering-correlation-id: 5ac8a430-6869-4081-d5c9-08dea1cea05c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|38070700021|55112099003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 gwbw/Ax+is7EFxfFYCJiZwI2P00OKSITKM87nELlPU1Y1GZq6ijWeKehUQil36x1RrUtOwV9JHL5JeVFoclirk0JfIzMSRm7D8pVUkxnvVgbOWkE/k5NW85hsRDh+clAKW0YcbmwTfR/vS3vLCOxyiehMjX2MUZ8sYMpjtBRP0XnXWihDUa2+OD0N4aEpwdjNR7aXEuRLcZHXqP6PMFcd8TFuGpvGsm7cRytA5o4jYP20bWzjwrNf7EnAzRGU4VcXknaQyTd4oP5wwdNeAdXjGABYQr6hD7tPfflzWhFN2Kj4P5U/nuUr5/PHBaSSvw48LgGsBEoSWtl2D9N3aj+jS0jXGvtevqUxL23RhjlXpitegZUSKYwpIa+RzmtVrPsb/69v8TZZb9heaM5gfYLyHGBRsGXr4Q+ZK47ZtmH1kb+1SouAqgu3V0XD9c+4t1LoCduxAcbub/sq5r+GXORuxNBEQLjU11tTtktzLT+rC8jwan/6ASN3H5bMdFZJfNy7KldjCpvdelK/b33WlQyrlbZZSx2PT8pxkPvLUR6lBk3KiouutdImV7vZhWfZT4TwMRxu4rEoKkO1IwMwcIvfTmB5UjTipD7MLvrQEG5wuTMIKh68rhuMJqaTW70h2MD1NcHNRKMdYhORfxDQ6RTsOyd9KW+yXtI+STeKwULvjwil/QOTW5p5Q+KVUz6ALYpRnNHRlRTEhvtqqMnwmapSMav4RvAC1VmJfmRdGAGDojrxM4Uw94+7x5FNLXiPeZHXCtaUa0mt26FoIwjkubP76qjZoq/n/QSDOBK3CNum24=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(38070700021)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmlpdHpvK095Z1ptWEFoTzhQNFY5U1VKNDRobXcwMkpnbzJTYWVRM0Y5YTRp?=
 =?utf-8?B?Qjc0MW1oYy9saVZPdElQbkRiY3B4cS9TSWdjeG9ZTGFMRzlHZk1GcVFMT1U5?=
 =?utf-8?B?aTlzaC9rT1NaQnFIYWc1RVY2Wk9yQkpjZmk4N3dtbUN3QXNDK0c3Z1FuVlI0?=
 =?utf-8?B?bmRibUZpMTVta0UyekpUenUwVGN2L3h2R3VJVzRnSjJzTk1YT2ZvNStiaUJr?=
 =?utf-8?B?ODBNVk1BcVJTdTJ3bCtlczB1OEhZTDZqbUFlRWVyaEdqbFBVZTJHNk9jNC91?=
 =?utf-8?B?ZGVzanExNUIxUzM1RThJcGJmbjFUMWtrdnBTY0FjdkRqWWpoVWZrV2ZZbWZx?=
 =?utf-8?B?ZEx4blRhVEJJNkJSVUttZThsREhmb1pDYXJQVTRXeEswWVR5R1ZnVlUxOVN2?=
 =?utf-8?B?NG42M0huV2pVNUlLMEF5WUVoSFUrMVVsR3pOYlE3eGxqem9EbE9vL083Ynli?=
 =?utf-8?B?RGZmKzIxVUJla05oay93YnZMc3p1bjEzcWJyNyszVnpIY1lmYTc0aW0xLzVV?=
 =?utf-8?B?blA0T00rak83TjdnTDFFbE1tRmtHQlVjYndXL1ZZRDFYb3JIM2dYTk1rSmk4?=
 =?utf-8?B?S3o0UHpCOTdCRlI2b2hLckNpL0RwYkdnd3NIZWIwZmdxbkJPdk1yU0dMWXJZ?=
 =?utf-8?B?T21vMlFBNHlMdWR0ZFFkRzh0SlFSVHZsTGw2TEYrM05MTUZ1Smx6SzFRQ3pR?=
 =?utf-8?B?dEEzZkFGVmxlMGJZanRJSGtJdGQ0ZCtobFJjNGV2d2svdmo5NFQ2V2I5ajR4?=
 =?utf-8?B?TERSZjFhSmlmay9hclEvaVAyblRVd0F5c1JlUFZIdnpqRmdoRXcrY2pLcUNO?=
 =?utf-8?B?OXlCaW80VkMvQ3FxYTE5QkZuZHFxdEJIRTd2d0l3dU5UaDdwL3ViVk03cUJT?=
 =?utf-8?B?eEhRRW9VQVJXbzJuTS8weFYrcFFTY3ppVk9TNnltLzkrWXNxUmNpeXlCa0dk?=
 =?utf-8?B?NEo1SThlRU1HT0I3TzUxcG9FT2RIR21rRTBEeFRBbUtSbkxyMElBNVprSExJ?=
 =?utf-8?B?aEtzS3VEWFNrZUpaeDBlUURGQ3lzNU9PMi96V1k3QkpmalR1RVozcGJtUVZ5?=
 =?utf-8?B?aTVPWXBheTRBS3lqTFdUci92VWFyV2FVMXhwK0RRVUkvQ0tidnkrU05QVXdV?=
 =?utf-8?B?and3UW0wdUEyeGVrYXQ3VERZdkNrUDg1OHZoNkpTYVgwUFR4NjZlSERRUHhD?=
 =?utf-8?B?UUR4L0tTZklUc1V4b1Frbk9QMWZ3N1pmMHErSkcxUVVFVUJ5M21PNnlKU0hJ?=
 =?utf-8?B?aVl3T2F3YjlLMGhKVTF0WUl0SC9GTUEzVHdYcEp1b1BWbHY5d2NIUXVHR01Q?=
 =?utf-8?B?S1NpZ0dkdnpsQzdPV1A5QUFiaHJaSHZzbTNSeWpxMTc3UVE2VWgrR2VWSGZa?=
 =?utf-8?B?bEZDcGU3Z0lBZ3RxbHVuQk5raHl1SHliWXlYSE5kcXZTOFJuZngvWlFsVWtp?=
 =?utf-8?B?NTNkSjBxR2FuTmhqaTI0cHV5L2kydDd0L3pIdVY1STNpeUpzcGg0WUhEOU0z?=
 =?utf-8?B?TEpKam5JYUZsQWVQQmlQVEVLc3U3THRycVRsS0NOTi9La2dtOHh3blk2eTJv?=
 =?utf-8?B?SkVWelpEMEM2cThxWWlYSDNzcjlBT1pGamRqNkJnRzltSFFjSUwxcGNKdmJB?=
 =?utf-8?B?MCtvdUpWWHVQVUpzYkRrdTZ2NEdseGZMVmx6eForb3d6dVVCdjE5VmFNdmt2?=
 =?utf-8?B?R0tBRU1pN2VjTkp6UC84QVdRRXRFMVhhODd0VEZBWUVuang2cGU0QUE5TXVx?=
 =?utf-8?B?ek1Xazh4dlNZQ1h3VzRDZHFic0M4NUxsY0wvMWhMQXB1TFRuZFpCeS92T01P?=
 =?utf-8?B?Ujd2d3g3V3FaTWdSd1BOenJoT2xRbGZxQlBYdWd3SFk3WFozRThRRFREaUJD?=
 =?utf-8?B?MG5KNUlQbHc2YkEvRnRvRlNpdnBsbUV2V3RtU0dYemxmZHREVG1BallON1ov?=
 =?utf-8?B?eWdtdWdkOFFQQ2RYTjZKcWQ0U3lyOHBMclVoN1cxcDVhOEJxa2M3SEhtTDhr?=
 =?utf-8?B?YWFIaFg2N2tqcTg1OURoalQxYlBCNGNkcWozQW9KNDlhbnRJZ3F2Y2RDeHR5?=
 =?utf-8?B?dlhQbHUzUW9PS3ZYbldKR1prclRLa3dmYTJ1dVk3WkQxbEoydWFnd3RNd0JM?=
 =?utf-8?B?emd3MGtISER4ZnVlMTRWdURxS1owNWc4bytrQXlVa1NKcHhKN0FsNmFybFdT?=
 =?utf-8?B?MlNvZUMwWFhtdlZTKzJvQ3hRTFl3aXlKdnRrRHdsT1J1Nk0zdGNjSktCL05J?=
 =?utf-8?B?SjVBczB2WkF1cS9ocFBDT01uai8zMkNHNjZYYkJkLytPTHd4MFB5cDBFUzdp?=
 =?utf-8?B?M28yMXk5Y0tNeVRGZFVYUzh0c1JwZHdMNjlOZDR0S2VFVzJxVXpJdHBLVUdB?=
 =?utf-8?Q?QhVdATArcBBsIGcUDlaonTt+frIFzR0Yj6pWGgYeUH9XV?=
x-ms-exchange-antispam-messagedata-1: ZHtc7o9pAcuHuPMMquSo82KeO2D4fqoLi5Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42017FF63FE01143AF2CA9AC523E4C6B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac8a430-6869-4081-d5c9-08dea1cea05c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 06:56:35.8541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnCPKmy8liLSPpGYMe43Lck12ufvBvZ8qAuwVv1jFc2JqlhrY3VUvtSRBQ7UEh+B5ko6PQpnZNIm2qgOgM4wpUglmiD+X5yh33QtCAL3db8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3644
X-Rspamd-Queue-Id: 4CADF45A901
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.94 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280953-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[siemens.com:s=selector2];
	FREEMAIL_TO(0.00)[gmail.com,stu.xidian.edu.cn];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[florian.bezdeka@siemens.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[siemens.com,reject];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e5d6936b9f4545fd88ab];
	NEURAL_SPAM(0.00)[0.959];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

T24gRnJpLCAyMDI2LTA0LTI0IGF0IDExOjI2ICswODAwLCDnjovmmI7nhZwgd3JvdGU6DQo+IEhp
IFNhYnJpbmEgYW5kIEpha3ViLA0KPiANCj4gQmVmb3JlIHNlbmRpbmcgb3V0IHRoZSB2MyBwYXRj
aCwgSSBzeW5jZWQgbXkgdHJlZSB0byB0aGUgbGF0ZXN0IG1haW5saW5lIGFuZCBjaGVja2VkIHRo
ZSBjdXJyZW50IHN0YXRlIG9mIGBpcDZfbWFrZV9za2IoKWAuIA0KPiANCj4gSXQgdHVybnMgb3V0
IHRoYXQgdGhlIG1pc3NpbmcgYGlwNl9jb3JrX3JlbGVhc2UoY29yaylgIGluIHRoZSBlcnJvciBw
YXRoIHdhcyBhbHJlYWR5IG5hdHVyYWxseSByZXNvbHZlZCBieSBFcmljIER1bWF6ZXQncyByZWNl
bnQgcmVmYWN0b3JpbmcgY29tbWl0Og0KPiBiNDA5YTdmNzE3NmIgKCJpcHY2OiBjb2xvY2F0ZSBp
bmV0Nl9jb3JrIGluIGluZXRfY29ya19mdWxsIikNCj4gDQo+IFdpdGggRXJpYydzIGNoYW5nZXMs
IHRoZSBlcnJvciBoYW5kbGluZyBub3cgY29ycmVjdGx5IGNhbGxzIGBpcDZfY29ya19yZWxlYXNl
KGNvcmspYCBpZiBgaXA2X3NldHVwX2NvcmsoKWAgZmFpbHMsIG1lYW5pbmcgdGhlIG1lbW9yeSBs
ZWFrIGlzIG5vIGxvbmdlciBwcmVzZW50IGluIHRoZSBsYXRlc3QgdHJlZS4NCg0KRmluZSwgc28g
bWFpbmxpbmUgaXMgY29ycmVjdCBub3cuIFdoYXQgYWJvdXQgdGhlIHN0YWJsZSB0cmVlcz8gRGlk
IHlvdQ0KY2hlY2sgdGhlbSBhbHJlYWR5Pw0KDQpGbG9yaWFuDQoNCj4gDQo+IFBsZWFzZSBkaXNy
ZWdhcmQgbXkgdjEgYW5kIHYyIHBhdGNoZXMuIEkgYW0gYWxzbyB0ZWxsaW5nIHN5emJvdCB0byBj
bG9zZSB0aGlzIHJlcG9ydCBiYXNlZCBvbiBFcmljJ3MgY29tbWl0Lg0KPiANCj4gVGhhbmsgeW91
IGFsbCBhZ2FpbiBmb3IgeW91ciB0aW1lLCB0aGUgZGVlcCBjb2RlIHJldmlldywgYW5kIGZvciBn
dWlkaW5nIG1lIHRvIGZpbmQgdGhlIHRydWUgcm9vdCBjYXVzZS4gSSBsZWFybmVkIGEgaHVnZSBh
bW91bnQgZnJvbSB0aGlzIGRpc2N1c3Npb24hDQo+IA0KPiAjc3l6IGZpeDogaXB2NjogY29sb2Nh
dGUgaW5ldDZfY29yayBpbiBpbmV0X2NvcmtfZnVsbA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBN
aW5neXUgV2FuZw0KPiANCj4gMjAyNi0wNC0yNCAxMToxNjozMCAi546L5piO54WcIiA8MjUxODEy
MTQyMTdAc3R1LnhpZGlhbi5lZHUuY24+IOWGmemBk++8mg0KPiA+IEhpLA0KPiA+IA0KPiA+IFRo
YW5rIHlvdSBzbyBtdWNoIGZvciB0aGUgcmV2aWV3IGFuZCBmb3IgcG9pbnRpbmcgbWUgdG8gdGhl
IGNvcnJlY3QgRml4ZXMgdGFnIQ0KPiA+IA0KPiA+IFlvdSBoaXQgdGhlIG5haWwgb24gdGhlIGhl
YWQgcmVnYXJkaW5nIGBfX2lwNl9hcHBlbmRfZGF0YSgpYC4gQWZ0ZXIgcmUtZXZhbHVhdGluZyB0
aGUgY29kZSBwYXRoIGJhc2VkIG9uIHlvdXIgcXVlc3Rpb24sIEkgcmVhbGl6ZSBteSBhc3N1bXB0
aW9uIGluIHYyIHdhcyBpbmNvcnJlY3QuIGBfX2lwNl9hcHBlbmRfZGF0YSgpYCBkb2VzIGluZGVl
ZCBndWFyYW50ZWUgdGhhdCBhbiBza2IgaXMgcXVldWVkIHVwb24gc3VjY2VzcywgbWFraW5nIHRo
ZSBgc2tiID09IE5VTExgIHBhdGggZGVhZCBjb2RlIGluIHRoaXMgY29udGV4dC4NCj4gPiANCj4g
PiBJIHRyYWNlZCB0aGUgYGZhaWxzbGFiYCBtZW1vcnkgbGVhayBiYWNrIHRvIGl0cyB0cnVlIG9y
aWdpbjogdGhlIGxvY2tsZXNzIGZhc3QgcGF0aCB3cmFwcGVyIGBpcDZfbWFrZV9za2IoKWAuDQo+
ID4gDQo+ID4gU2FicmluYSBwcmV2aW91c2x5IG5vdGVkIHRoYXQgYGlwNl9zZXR1cF9jb3JrKClg
IGZhaWx1cmVzIGNvcnJlY3RseSByZWxlYXNlIHRoZSBkc3QuIFRoYXQgaXMgYWJzb2x1dGVseSB0
cnVlIGZvciB0aGUgc2xvdyBwYXRoLCB3aGVyZSBgdWRwX3Y2X2ZsdXNoX3BlbmRpbmdfZnJhbWVz
KClgIGV2ZW50dWFsbHkgaGFuZGxlcyB0aGUgY2xlYW51cC4gDQo+ID4gDQo+ID4gSG93ZXZlciwg
aW4gdGhlIGZhc3QgcGF0aCwgYGlwNl9tYWtlX3NrYigpYCBjYWxscyBgaXA2X3NldHVwX2Nvcmso
KWAuIEluc2lkZSBgaXA2X3NldHVwX2NvcmsoKWAsIGBjb3JrLT5iYXNlLmRzdGAgaXMgYXNzaWdu
ZWQgZWFybHkuIElmIGEgc3Vic2VxdWVudCBtZW1vcnkgYWxsb2NhdGlvbiBmYWlscyAoZS5nLiwg
YHY2X2NvcmstPm9wdCA9IGt6YWxsb2MoLi4uKWAgZmFpbGluZyBkdWUgdG8gZmFpbHNsYWIpLCBp
dCByZXR1cm5zIGFuIGVycm9yLiBgaXA2X21ha2Vfc2tiKClgIHRoZW4gZGlyZWN0bHkgcmV0dXJu
cyBgRVJSX1BUUihlcnIpYCBXSVRIT1VUIGNhbGxpbmcgYGlwNl9jb3JrX3JlbGVhc2UoY29yaylg
Lg0KPiA+IA0KPiA+IFNpbmNlIGB1ZHB2Nl9zZW5kbXNnKClgIGFzc3VtZXMgdGhlIGBkc3RgIHJl
ZmVyZW5jZSBpcyBzdG9sZW4gYnkgYGlwNl9tYWtlX3NrYigpYCBhbmQgdW5jb25kaXRpb25hbGx5
IGp1bXBzIHRvIGBvdXRfbm9fZHN0YCwgdGhlIGBkc3RgIGlzIGNvbXBsZXRlbHkgbGVha2VkLg0K
PiA+IA0KPiA+IFRoZSBmaXggaXMgc2ltcGx5IHRvIGFkZCBgaXA2X2NvcmtfcmVsZWFzZShjb3Jr
KWAgaW4gdGhlIGBpcDZfc2V0dXBfY29yaygpYCBlcnJvciBwYXRoIGluc2lkZSBgaXA2X21ha2Vf
c2tiKClgLg0KPiA+IA0KPiA+IEkgd2lsbCBzdWJtaXQgYSB2MyBwYXRjaCBzaG9ydGx5IGFkZHJl
c3NpbmcgdGhpcyB0cnVlIHJvb3QgY2F1c2UgYW5kIHVzaW5nIHlvdXIgc3VnZ2VzdGVkIEZpeGVz
IHRhZy4gVGhhbmsgeW91IGFnYWluIGZvciBzdGVlcmluZyBtZSBpbiB0aGUgZXhhY3QgcmlnaHQg
ZGlyZWN0aW9uIQ0KPiA+IA0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBNaW5neXUgV2FuZw0KPiA+
IA0KPiA+IA0KPiA+ID4gLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQ0KPiA+ID4g5Y+R5Lu25Lq6OiAi
V2lsbGVtIGRlIEJydWlqbiIgPHdpbGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20+DQo+ID4g
PiDlj5HpgIHml7bpl7Q6MjAyNi0wNC0yMyAyMjo1OTo0NSAo5pif5pyf5ZubKQ0KPiA+ID4g5pS2
5Lu25Lq6OiAiTWluZ3l1IFdhbmciIDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4sIHdp
bGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20sIGRhdmVtQGRhdmVtbG9mdC5uZXQsIGRzYWhl
cm5Aa2VybmVsLm9yZywgZWR1bWF6ZXRAZ29vZ2xlLmNvbSwga3ViYUBrZXJuZWwub3JnLCBwYWJl
bmlAcmVkaGF0LmNvbQ0KPiA+ID4g5oqE6YCBOiBzZEBxdWVhc3lzbmFpbC5uZXQsIGhvcm1zQGtl
cm5lbC5vcmcsIG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcsICJNaW5neXUgV2FuZyIgPDI1MTgxMjE0MjE3QHN0dS54aWRpYW4uZWR1LmNuPiwgc3l6
Ym90K2U1ZDY5MzZiOWY0NTQ1ZmQ4OGFiQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gPiA+
IOS4u+mimDogUmU6IFtQQVRDSCB2Ml0gaXB2NjogZml4IG1lbW9yeSBsZWFrIGluIF9faXA2X21h
a2Vfc2tiKCkgd2hlbiBxdWV1ZSBpcyBlbXB0eQ0KPiA+ID4gDQo+ID4gPiBNaW5neXUgV2FuZyB3
cm90ZToNCj4gPiA+ID4gRHVyaW5nIGZ1enppbmcgd2l0aCBmYWlsc2xhYiBlbmFibGVkLCBhIG1l
bW9yeSBsZWFrIHdhcyBvYnNlcnZlZCBpbiB0aGUNCj4gPiA+ID4gSVB2NiBVRFAgc2VuZCBwYXRo
Lg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIHJvb3QgY2F1c2UgcmVzaWRlcyBpbiBfX2lwNl9tYWtl
X3NrYigpLiBJbiBleHRyZW1lbHkgcmFyZSBjYXNlcw0KPiA+ID4gPiAoc3VjaCBhcyBmYXVsdCBp
bmplY3Rpb24gb3Igc3BlY2lmaWMgZW1wdHkgcGF5bG9hZCBjb25kaXRpb25zKSwNCj4gPiA+IA0K
PiA+ID4gQ2FuIHlvdSBlbGFib3JhdGUgb24gdGhpcz8gV2hpY2ggZmF1bHQgaW5qZWN0aW9uIGxl
dHMNCj4gPiA+IF9faXA2X2FwcGVuZF9kYXRhIHN1Y2NlZWQgd2l0aG91dCB3cml0aW5nIGRhdGE/
DQo+ID4gPiANCj4gPiA+ID4gX19pcDZfYXBwZW5kX2RhdGEoKSBtYXkgc3VjY2VlZCBidXQgbGVh
dmUgdGhlIHNvY2tldCdzIHdyaXRlIHF1ZXVlDQo+ID4gPiA+IGVtcHR5Lg0KPiA+ID4gPiANCj4g
PiA+ID4gV2hlbiBfX2lwNl9tYWtlX3NrYigpIGlzIHN1YnNlcXVlbnRseSBjYWxsZWQsIF9fc2ti
X2RlcXVldWUocXVldWUpDQo+ID4gPiA+IHJldHVybnMgTlVMTC4gVGhlIHByZXZpb3VzIGxvZ2lj
IGhhbmRsZWQgdGhpcyBieSBleGVjdXRpbmcgYSAnZ290byBvdXQ7JywNCj4gPiA+ID4gd2hpY2gg
Y29tcGxldGVseSBieXBhc3NlZCB0aGUgY2FsbCB0byBpcDZfY29ya19yZWxlYXNlKGNvcmspLg0K
PiA+ID4gPiANCj4gPiA+ID4gU2luY2UgdGhlICdjb3JrJyBzdHJ1Y3R1cmUgYWN0aXZlbHkgaG9s
ZHMgYSByZWZlcmVuY2UgdG8gdGhlIHJvdXRpbmcNCj4gPiA+ID4gZW50cnkgKGRzdF9lbnRyeSkg
YW5kIHBvdGVudGlhbGx5IG90aGVyIGFsbG9jYXRlZCBvcHRpb25zLCBza2lwcGluZw0KPiA+ID4g
PiB0aGUgcmVsZWFzZSBjbGVhbmx5IGxlYWtzIHRoZXNlIHJlc291cmNlcy4NCj4gPiA+ID4gDQo+
ID4gPiA+IEZpeCB0aGlzIGJ5IGludHJvZHVjaW5nIGFuICdvdXRfY29ya19yZWxlYXNlJyBsYWJl
bCBhbmQganVtcGluZyB0byBpdA0KPiA+ID4gPiB3aGVuIHNrYiBpcyBOVUxMLCBlbnN1cmluZyB0
aGUgY29yayBzdGF0ZSBpcyBhbHdheXMgcHJvcGVybHkgY2xlYW5lZCB1cC4NCj4gPiA+ID4gVGhl
IG5vdy11bnVzZWQgJ291dCcgbGFiZWwgaXMgYWxzbyByZW1vdmVkIHRvIHByZXZlbnQgY29tcGls
ZXIgd2FybmluZ3MuDQo+ID4gPiA+IA0KPiA+ID4gPiBGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGlu
dXgtMi42LjEyLXJjMiIpDQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgdGhpcyBpcyANCj4gPiA+IA0K
PiA+ID4gRml4ZXM6IDY0MjIzOThjMmFiMCAoImlwdjY6IGludHJvZHVjZSBpcHY2X21ha2Vfc2ti
IikNCj4gPiA+IA0KPiA+ID4gPiBSZXBvcnRlZC1ieTogc3l6Ym90K2U1ZDY5MzZiOWY0NTQ1ZmQ4
OGFiQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWlu
Z3l1IFdhbmcgPDI1MTgxMjE0MjE3QHN0dS54aWRpYW4uZWR1LmNuPg0K

