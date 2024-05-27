Return-Path: <netdev+bounces-98266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5FD8D0768
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394702949D2
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048B416C873;
	Mon, 27 May 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="H6N5rf9n"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9A16C85D;
	Mon, 27 May 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825393; cv=fail; b=u5Kr4QCekaiA1RXbnFQvIh2tWYXkZ6Pf0XdjdvaIYhhuEqkieP5AWUAbveqGoGzoLZn+DZXd5Cf/u3jWLct4OfXD3JCCnFfrE2GAMomEt8mjhhMtQsN72q9fXsdpncbmpYPaWP7yIFMUEI/s9Uxw+Xx40eyPRMc3rsTQCe6jpm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825393; c=relaxed/simple;
	bh=fn+qSg3jU+FM2DiapPIZEIIZ7GU+wLlyKMU9z7W30Ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pYKuYcIVnT0G34+S7qp6bNzTzMioAnSAK51M4SunBO3DwzVwourf/XT4MMgX2+C0ZfNp28M68BFjvP9Khflr6OBtCQZEjYjSga+CznErBAUgTMsaV5dIHWjpQn5tICam3SJFLuOZg9R/EkLB1a2+feOm2k53vNeV7cZlcNrQcxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=H6N5rf9n; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R5fcru027334;
	Mon, 27 May 2024 08:55:59 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ycm8gt1wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 08:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf2optQUdPafM71qG2FDzEsGyFCpS6O9p/J8iRoy2/bhOaNQ01JrPhiCf6khNjTeU7Fu2cLZLn3mFo8iiU/nUbavfgwP21waqp7uYc1D6uaIUHOFKHgUpyPDHMCvBLxEC4CJ09xobzpOSYER439XaKw6X2Fg53g0bf540uZlfnj2OmRbTBpvcQndUohNHInmI4AoHKpR3rvvJ7gupmUrG5r6iROIR487fy2MLOm+q3DZ6Vuh0QKUaGYL+6MsCRsb7ga7UE4QbizS4IaUATRrzKdXrIhL0ar7tGT/dFzcWgcU4I0t00bKrXuokgjmLKw1GFahAG0cWjxamgOelyacGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJVOq6TEE0mxbNRBPudgHY2iZRUQvdHdO1Tcplnor+M=;
 b=kgXIfQjbsPQTRtncoE5nMDjlnsQcEWsg1JfOyenY0MGjXTOBAhqKxYG4MJOxvG2ZNeUfx0rFd0iiCq4vAxyunJh+pokLY3l2rchVEKwo695dX5spF7N4KbQcyeWpJrJpsn8s9pPMDK7H87Mwqn3mt+opKkXeVzO8Dq3EkkakIchwSa07y8NjfdS4zuiJ4riTbIGeL1VfsF+cixfJDMjfbVkxjFMqkmfikZ7UTgAHcUhzqKEePtGOw9oer0vZhKPVIKtTIpJJSy/y3hdmLZyhaipmYYe094qiNhRF4kXfoDzj4haVn0JKoeARsATtShY3v9jZO8tDNn6tYf778xf9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJVOq6TEE0mxbNRBPudgHY2iZRUQvdHdO1Tcplnor+M=;
 b=H6N5rf9nkc96jsoV5L2Aoq/JLrr5MMu/dTJobmSMKWUznYHljcktVFmwNyPhwIs6McytSpz5ip0QYG4YgzLtT+NfUdnWaWKRCSjo9UFRsmoj1kZBkV6ISZCCgaDFAxNwCjcI26f4jbIkrsV2wG3czQlOXtWN5y5styBs4Qlevps=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by SJ0PR18MB4961.namprd18.prod.outlook.com (2603:10b6:a03:3e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 15:55:55 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 15:55:55 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Frank Wunderlich <linux@fw-web.de>, Felix Fietkau <nbd@nbd.name>,
        Sean
 Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo
 Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Frank Wunderlich <frank-w@public-files.de>,
        John Crispin
	<john@phrozen.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: RE: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Topic: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Index: AQHasE5bT9grtdxWqkylIIRYxgKV6Q==
Date: Mon, 27 May 2024 15:55:55 +0000
Message-ID: 
 <BY3PR18MB4737D0ED774B14833353D202C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240527142142.126796-1-linux@fw-web.de>
In-Reply-To: <20240527142142.126796-1-linux@fw-web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|SJ0PR18MB4961:EE_
x-ms-office365-filtering-correlation-id: 854ccd55-66d6-4522-d420-08dc7e657e33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|921011|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?x4wTRQFX0v2Ln4GuQr/4Di6SRRLblBw4vx4fbBYBRVw/Q71SvU8U2++HUMf7?=
 =?us-ascii?Q?5ljaeM20XtLK/d66vvYmrCK6tRC4Y/GokkNaY9nWG37LR/X59KvHgInLjMg4?=
 =?us-ascii?Q?FPmf4dS84X2JZvz2P+pPoptrdyhY6hmHOWP4f1Xl05Tfy7GBP8ArhNB8enWv?=
 =?us-ascii?Q?glmJJ+do3QMYImGhZ93EppT1anB8wgUahXDWQsI4/+egPamfEs7g2Dq9TT8+?=
 =?us-ascii?Q?yNcIX7O9xdRaX9Xl9irVEEH8tlOeKZHctNn+S8aYeR85m9LzKE4+IazglpLQ?=
 =?us-ascii?Q?tUE3pbjVJiSvGZcHlnkdFyymKik5rzyXKXfdzhw7bp7gW6F6ThdHQ5nAYtdF?=
 =?us-ascii?Q?D8QQitd5i50vlhtrf7T/9Vmu6DIZjGmrt03pbkCAt3PPNnBOnkkTOuBVpcSx?=
 =?us-ascii?Q?Xw80mOCHehGDWUp4kfgENpGUCtdww+Dn5I3oemIytCcq0fGCLt7n9DSipsju?=
 =?us-ascii?Q?/GP2jkBpTCmVDIJOl+abrL2HD96AGJNdMMxkTnmzDp9+VocOvrL9NRyKrnxb?=
 =?us-ascii?Q?qUXhlNIo61/ZGpk3DU38hDlnQ4KlPveQBqun0orZwu1FYo18bxyW7ee8N/5v?=
 =?us-ascii?Q?6V/827IhlhoX+4FFCztU4ezKkoGuH5KqCzIYOoIsQta5+SZWfiVQ3bhFsPTk?=
 =?us-ascii?Q?lZI/lV96ppFEAXb8WCyGElhXS6atbW2/yAcxpzN3XonTGW/Kw8A/YbHIzcew?=
 =?us-ascii?Q?9DfuSORCEceUU8URLDCTgBv9FYEPMZ/tlDM4wEbRePMTSl8EgrRCNJOOXab1?=
 =?us-ascii?Q?mp37RUfoomxPwVg9GaZ/or7pCXPEdVKC2gzy08vMrbC9qZ86qtKDoXwvFkJ5?=
 =?us-ascii?Q?p8QFH+2K9pp9FKT83v/NldQrPEpgvQYKAnbDd7Z1Rp6Hn3NB4/E9Xdf0uhfC?=
 =?us-ascii?Q?4EIu2hGcKgjU44tddeUkzTVi0PfiVc0sNZCcTv7SoCiMRJTkwPa2Qt0xkoft?=
 =?us-ascii?Q?mY5bsQm5qssTO/UeHaB+mJxip/J6CRMR+oLq+zAlrFbZM18Z1BqLXvtY3YHR?=
 =?us-ascii?Q?qx6n4taOPpXHxn9ABBXXBP7DBCYzEI6IORiHHfcQYt2B1EZDUKJ//yomT7/p?=
 =?us-ascii?Q?ReVZ1sH0mHNkkvnjW1fsHRkw4HC+c+qLPG76LyOS2TQNMG8Swh4E5+3zZrJu?=
 =?us-ascii?Q?8lF6HfmpiRu19aXOd6QgaYM50OvkeweQkkDzgw9dYf4HRjVj5kJbSXTJPFRe?=
 =?us-ascii?Q?ys+YPkdMtGSZ097YWo8aqI5FVLWHp37ft01XBMtRp/EJllaWHe5vN7sVT/ro?=
 =?us-ascii?Q?8o8PJ9ruscDOsAEHjPJ/96Px9n8Anj5yvJ0PrLfuoB4J7ha2NJ8Qi6dCz3V9?=
 =?us-ascii?Q?aknT2sfkRYEc3WZoFcCEG5NWQB1i10VDwMC1iJXTE4CadA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?tCbFQr1UarXCsGli9TqgOApEP2KxXfvvtKsxmCNUuHzxocmJjGHsAfsjY5+U?=
 =?us-ascii?Q?ozBobDqCXyzr8JChxYXjqVRgg+QB4KBFXyjcWiQBHxB9/tSepOhJMHE6Cc6d?=
 =?us-ascii?Q?zBeGCckVf6h1a6Zxv5q5FuFDOpP/wU2ntfVWBKQpeAQ+b+JKf+v0rZO3jONs?=
 =?us-ascii?Q?neWuUYTWVcqyKVLB6OSFLYYWOs1MTUyuqLvpZHObQubWy5FlUkK8CLhAF8qN?=
 =?us-ascii?Q?sQY7j0CtUSh2ogYxtVmuCDUadpprnE2tXJrNBoVuxxh6VyRZcWcAJRP6LI0Z?=
 =?us-ascii?Q?AK8BsY6X7H+rikq71KAXLczglXFjZRyx8kJrCTD0T+uX9R7aCZdHbrlGZsmG?=
 =?us-ascii?Q?i3up9ikUg1lbpqZLMOijs2A6EuiyDPfcU0bvn4AGXbcOCB49o6J84ytxZ2sL?=
 =?us-ascii?Q?/fcoIPX0alzgORmWjnxhfdfLm8M4Y8IAiJGM3rZ52nw6DqvTKOaXvweEKwKS?=
 =?us-ascii?Q?1gbKscWERQZa826L9smcm4zpnPxT4q5aAppqlMoEo7ZLz+wIkAOJl0ToMMbn?=
 =?us-ascii?Q?DzzaMMcnX48m8n+sLysYshQ3eaImckqQpSXPAf6vdlDYtYEYGXjBDdM+l06v?=
 =?us-ascii?Q?WqQedNEtQdrRQaouhiXkH8kFy55G7Gb0pxjPJ9bzuOpWFIHnIBKyJkGrTH7z?=
 =?us-ascii?Q?jpdIHR9sJXjITyGHYNhnL8oEiSyTxxcuMXfcm6MkNbBCgXr7n+o9FxJ7Fa6G?=
 =?us-ascii?Q?RJxcmL5U+DvSOrU7xkK9Oi+D/4KSZuo2DlDq7MnIeVJBICwvX7EFeJG9OOz+?=
 =?us-ascii?Q?MLeQ95Nv1AHkaCSwenV3ykdFC6GAOAivFDN6cn4S2q9CI6gQC6z94TPXS9h+?=
 =?us-ascii?Q?esy+0wZh8TEpMGUNKO/b7adpRGOU2K/8ptE1dofLLV6KxFmoHYPMUSmGBDzv?=
 =?us-ascii?Q?BChvI3S8EBpRRyslX9OMNTimABFJdqgUv2ge7asDjyGeIpcWzNuUZ8tH8bJ9?=
 =?us-ascii?Q?7+W/u7gX6DL2pyjJj+rZPesQ9m09vrRnaXAN36nVDz1mSwGIACO/1jJsq0oU?=
 =?us-ascii?Q?bd7CLz8K7wc30ZHdcEiqHHEfocEGnfMN3u6pNnH+j4iNe1xG033GPCly5G53?=
 =?us-ascii?Q?zVu/hFresCB5xt1DuJg26UkpCZBJj0CTkqZMg1WOyCLg8Q1PJxaGRXvZaBbX?=
 =?us-ascii?Q?1WDt4NSDVgF9L6F6F5RWTS93kK+fYww5fK45QIVE5/+X1rv3vOCOpnQlwSYh?=
 =?us-ascii?Q?yTNIzkACo8aJ7qFss9COnWbtCYX8cVjL+hvXePqPNEo95US86zT5xGIkyGdc?=
 =?us-ascii?Q?C07NQRXObtcKO6xgaSe4ObRpPc4ajw/Hi/JR1Zi1v0pSVxx6ktMUgIABysjY?=
 =?us-ascii?Q?eG8+R8S35hK97iVkhaIGXqH9O97wR5iDMTEKD6LXH6mA6sSE5YWEUOVK0KMq?=
 =?us-ascii?Q?fmZa3vE0LMMOoXCj2Wf4Osuh8J+17t6rmlTUULMwFjIvA8oytnGNbeMXVkSR?=
 =?us-ascii?Q?5EjOTvvEZa7MCFNoXMABmADkJOcpqfTd6TKoAyg1xm/jsllTU7WrwNYfRo8u?=
 =?us-ascii?Q?paCOBFpPl7v1/old53yWzq8YbgYMXOb3Eimwtp2NnGChMqffesZq0oVtOERK?=
 =?us-ascii?Q?N4ULg4/C3FQdkbk/BCQMOGA9qzhR6po5j74EtbzV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854ccd55-66d6-4522-d420-08dc7e657e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 15:55:55.3622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnKoOodxMIe0a/bdIDhbneLSaZUOYCDy2eXl7Xf3p+oAsS2rnJqNZwkZx9J3KJFpstOHiyYHA0tjD8pba5IOtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4961
X-Proofpoint-GUID: hy3t5txix1qyKluvirs4JMDyOvyEWQjD
X-Proofpoint-ORIG-GUID: hy3t5txix1qyKluvirs4JMDyOvyEWQjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01



> -----Original Message-----
> From: Frank Wunderlich <linux@fw-web.de>
> Sent: Monday, May 27, 2024 7:52 PM
> To: Felix Fietkau <nbd@nbd.name>; Sean Wang <sean.wang@mediatek.com>;
> Mark Lee <Mark-MC.Lee@mediatek.com>; Lorenzo Bianconi
> <lorenzo@kernel.org>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Matthias Brugger <matthias.bgg@gmail.com>;
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Frank Wunderlich <frank-w@public-files.de>; John Crispin
> <john@phrozen.org>; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-mediatek@lists.infradead.org;
> Daniel Golle <daniel@makrotopia.org>
> Subject: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc =
specific
>=20
> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> The mainline MTK ethernet driver suffers long time from rarly but annoyin=
g tx
> queue timeouts. We think that this is caused by fixed dma sizes hardcoded=
 for
> all SoCs.
>=20
> Use the dma-size implementation from SDK in a per SoC manner.
>=20
> Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623
> ethernet")
> Suggested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

..............
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index cae46290a7ae..f1ff1be73926 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c

.............
> @@ -1142,40 +1142,46 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
>  						       cnt * soc->tx.desc_size,
>  						       &eth->phy_scratch_ring,
>  						       GFP_KERNEL);

..............
> -	for (i =3D 0; i < cnt; i++) {
> -		dma_addr_t addr =3D dma_addr + i * MTK_QDMA_PAGE_SIZE;
> -		struct mtk_tx_dma_v2 *txd;
> +		dma_addr =3D dma_map_single(eth->dma_dev,
> +					  eth->scratch_head[j], len *
> MTK_QDMA_PAGE_SIZE,
> +					  DMA_FROM_DEVICE);
>=20

As per commit msg, the fix is for transmit queue timeouts.
But the DMA buffer changes seems for receive pkts.
Can you please elaborate the connection here.

Thanks,
Sunil.


