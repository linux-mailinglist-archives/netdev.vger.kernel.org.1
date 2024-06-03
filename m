Return-Path: <netdev+bounces-100050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E41A98D7AF6
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 538C3B218DC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 05:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C41D1DDF6;
	Mon,  3 Jun 2024 05:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="e/0P+Qs0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15F29408;
	Mon,  3 Jun 2024 05:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717392000; cv=fail; b=sAIlPz1N48W3RtcX7yjrsTBO73Zk+qNqb5+4+/JiRy2qO4bfAeRk6Th/QwWs1z6W9Db0AnS1hh6VZe1BcPM0UFjGdzJ/XE7fuJPR79Ds9qAm45ynQ0JVrgR05dlHJ2mzZfVxEax2NjMIyW2qDbLol2K8f/6IrOwRytVl0ohKf94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717392000; c=relaxed/simple;
	bh=IfOvI1HCPNfPovFyMvY+0j1z7J6fKQIZHO7zx7MTeZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=byws/XdS1q32EbqeDEYaMG7DusbV3NgU3AanumOGxqm30ZhD78/jJcEMQkJHhL2re57npUa+sjtdyybhoQLtbrEWllgyOqwUpa9siEX0YOhegZqObA0pzxMF9p7XNv+tSM8AS1em18222jCUnEy+I0iYBAnsYj6oA6gLjjIX/oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=e/0P+Qs0; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452LkETr015798;
	Sun, 2 Jun 2024 22:19:32 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ygufmsbuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 22:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGFnrgKp3oZF28oXLRA5ien09U9TErDiZakCRkmZM1nQebHIML1f6pYNxjqubFOclr+z+WvhzyYr5xDHUY5sZz5PGaSwlLVEeMMyOOASn18YB0ipPPyuW7QVCajGJbK2pNyWJqHecY9f84dlNp86q7Hx/a55Pclis8N+peJ+vtGcSPKlUysTt4JYbM/LZdlDF+L6wXjfbJUHNohlV7a/R+9My8GWgWv2iD+6ro9cJyxiaHnMmmXzZYP9y8W5v3yuyCSigX8ql0oNbZy/ZGTVyJADzWcvTEoEd9jxxn1bpTb1935OgUVGwNWAUeuBECtTDOOE4v3NVflakZvz6cgoog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+XjSHHo9EtE0k0YDpviBTJj0s8+HXzWiDrUfwfBImw=;
 b=MYpPyu8Ra4tWYxqDnvcN8b4koUqqFR5wN98VxZ3KvT9i+Py0jaUg5TufUs+XdIarfbPfGsFvb9DWRSDPDoLHuUIw2+D1hRsu3FyVK2KX/jUDlIykVieMJ+UlFlNK9Hg1SZPrQ6mYAYy7KxOOxAJV1jMfCSrzyUq2fqULGrBot4sBF/IonOE44Vgs3X4fQcrbEu0cUs1zBwjceVwnVQ5sYIqSYMidOQ+yIPN3+eqT6cJ3uVsMHNz7vthQ7uMUzd7gRql8x+vWDCt6MnNM+bRwXoOz3OXonhUGsTJnoAXoOVI6ctGWS6pGdVMrrPwjnjDrbYdnMTtjmTZVqBBmslQlrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+XjSHHo9EtE0k0YDpviBTJj0s8+HXzWiDrUfwfBImw=;
 b=e/0P+Qs0eP5r/ph+B0DrFAg/7nU7GLQ7ErrpCFw/ET3ZBZ+8K7ogNCwOxbyYpufZRPkMbTHy25j4DE+1xqDaITOu+eb/hjooOn05hHm03B4NxbVaf54ZH8KHr4unW2UNPziOatHGIhqCBM6npxotWqm/aSImBbf41ici2P9ul50=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by CH3PR18MB5769.namprd18.prod.outlook.com (2603:10b6:610:1b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 05:19:30 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:19:30 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo.bianconi83@gmail.com"
	<lorenzo.bianconi83@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "conor@kernel.org" <conor@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "upstream@airoha.com" <upstream@airoha.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "benjamin.larsson@genexis.eu"
	<benjamin.larsson@genexis.eu>
Subject: RE: [EXTERNAL] [PATCH net-next 3/3] net: airoha: Introduce ethernet
 support for EN7581 SoC
Thread-Topic: [EXTERNAL] [PATCH net-next 3/3] net: airoha: Introduce ethernet
 support for EN7581 SoC
Thread-Index: AQHas0SFzR0u8T1/ckSPnvZ4rpPnVrG1fiGQ
Date: Mon, 3 Jun 2024 05:19:29 +0000
Message-ID: 
 <BY3PR18MB4737F74D6674C04CAFDCD9C9C6FF2@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <4d63e7706ef7ae12aade49e41bb6d0bb6b429706.1717150593.git.lorenzo@kernel.org>
In-Reply-To: 
 <4d63e7706ef7ae12aade49e41bb6d0bb6b429706.1717150593.git.lorenzo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|CH3PR18MB5769:EE_
x-ms-office365-filtering-correlation-id: 8c76849f-0b42-438e-7dd5-08dc838cbed7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?RJFQrXSYIyxyidIu+KCk7xlc/OlA/N6jJmQc1m+ieYHpOJcaBFWTUBqetO0y?=
 =?us-ascii?Q?SCbykiKdjdw4ZkRHdaQTn2Al0fDFsY5ag3MmzVxz8TzxIFhZVRBzCBP+tdlt?=
 =?us-ascii?Q?ttbGdDPMpJL7PqromNcIBc1uwwGMJ3L8feV6OvX9j9omA1oLHv35EpRB4evh?=
 =?us-ascii?Q?mNQcloEWIeN6Q4jvxGRDcVxDmxkajWbh/5syfgi0ITtTxdut4i1qjppbkla0?=
 =?us-ascii?Q?U/89V5NfFdP7FLSWrXfGIfh1jQOP55htrjc4IiAyNa78MtcfnFbMzZplz7mZ?=
 =?us-ascii?Q?o9ziancPSEBRDdY2eHkmsX3cNBTVCBoNGS3F/fJpIZEysK2/Lssp4UPcL1X6?=
 =?us-ascii?Q?VhKoLzcQkdrjEv4s18AysKMVMtj6V5GRB2w3w7NdJ5yKyxl6iSoj0BcgF43D?=
 =?us-ascii?Q?OOaOZeIuhCruf2uqKEjR3Y9m9fa6bWbWd5ad/A1mYcAsa8y8Dt2+eIPkR91h?=
 =?us-ascii?Q?8QyyHz4A64+9eNhFXA4OSpn2q+FxgVg69z3gWghCBMWkKwFg0aegDdxnqozS?=
 =?us-ascii?Q?ecfE5mEkNA8Afx64HxudxQDs1bieM07gIiW7ZGI7QNGU9I86ABj8B4Sm5jfl?=
 =?us-ascii?Q?ibDta6i4z0562samtHz//AfXsgGyMqXJLv7uGJ0ott2ldsWGMMDUOPmBB9ql?=
 =?us-ascii?Q?OTLALb6Sa4SQlDBczM1PP/4ErdUMRbxO+IT9Dw3AV3nvKGR1FQbNWv5nfs3w?=
 =?us-ascii?Q?SduInIcrZu7LvoNZEJY2hd9GAjJRoSO/uFjnwMISj1xxeJiTjmY9GaatBNd9?=
 =?us-ascii?Q?XaYJzTejqg2ybuwtjgMlJY3+rrRY3BekP2V7J2Q8Y17jbKtRvEDLKg3/ahog?=
 =?us-ascii?Q?nCsw7aWXJUJ0UVpS9IZfyB6VefD0mxyiIzLopsLJ47LalbbSfbf3xEE+Q4be?=
 =?us-ascii?Q?TjHNPo3r1BZMl0KJ5IaYchQdXX3jFSJChmtpaoWBQyE1Ktkb7kmEUdpMupeV?=
 =?us-ascii?Q?OfdtDk18fDEmlNcg5n7SF12BhjtP/PebUAts75C1JGPlgLoYrzIr2Ub4RZCe?=
 =?us-ascii?Q?UGlOnV9XEpBFez/IvJeZIYeHmN1UPauhrnNrxgvBvbeRf4v7ZDoG0+qdWw88?=
 =?us-ascii?Q?v5hDxLZAv4alhCKBg1i8gwiTgsMlAIjraUMDraH6mhpG5DExfF4s0zD6QMmg?=
 =?us-ascii?Q?6EZdaNNclWG0HmNOxGlEfy0ZeKTFAhNGISZJs5LyP4qs2HyB486UoQyxKFUG?=
 =?us-ascii?Q?XLyayPhRgwJ9kXqUyadno7YZAXie+mBcqGBgAdqTxqukJ6HhH32aV6kop3d3?=
 =?us-ascii?Q?mNZuyUdGlWSfjblWnxoIdpcexTTC6MTe/Y78jmfwK7TXB37rJvvfbw52n/bB?=
 =?us-ascii?Q?Nm5iV6qL+Zd/hsDHkX5+YmflAtwlXU8lXufikoW63fg1nw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mMzCCR9iNSiVg8TZkKuJvjdjvSvFpLyHDN6rIBVHkyAmuAojxDlj7SKKK4I9?=
 =?us-ascii?Q?OIA32yCbbkOGiKPzIPbOSqOJeNMzqgKKCS50s2l+Tl6AIk+kU29KIk41Fh+l?=
 =?us-ascii?Q?ip1hgny2gxd4/2kTdBPvXSZnlCPIZA9aaIbwmKn5XljTfrJmF98eVsOGPl7K?=
 =?us-ascii?Q?uB2BSEZ6MPW5Gi3KczA/fDSuithr/SfNODSe25MvKUvf9xQ/rofzC8RK6NML?=
 =?us-ascii?Q?NWxZ2GCWiUSTLjmZzjLQYE66CmPMOJ6D969AK0IQTT4PT4fJezS/6dZGrlC0?=
 =?us-ascii?Q?bSMwnGwGh9Gam/EYKA3yt6ovD/hBW4QxyRKMsKFYPvi4Y716rzXmUWFbR1We?=
 =?us-ascii?Q?yuigdl9bGI0uwx3FqDHNfQgwkWVS7nEtmhwEKU2DRThDc3qvoOiBD0qsZ5j3?=
 =?us-ascii?Q?1JZ6eQaTEEa0c7BhuJ6iKrzIIdVUF4K3HN2acpcP5CVsT6g+LiqUsMNa/bBN?=
 =?us-ascii?Q?rsmWoGw3YDsKyiY6046Zgqbnwd3yfNLwOqPNCa676Yv4i0dbykZh6XhFp03g?=
 =?us-ascii?Q?8C42dRqaqx/gqiWgvJGGHSicHEOYPt6trV+EInET0hsYrHMMd3tJ9rnQlWi3?=
 =?us-ascii?Q?mPtnYnB9ofyTg0JXW5viImFYA0RxKLyrAzj5UjAziuq4SgvECuWIQCEHV1+j?=
 =?us-ascii?Q?dFwLhWH95i2gDAZbV8iUwjUQEfY4PWxV7pspoOaMIXw7wG0BRanS513alb3X?=
 =?us-ascii?Q?N11Ndgp4d2h55dC72L5CQffylepEX/7nIM1IZYOxQ3YdBJHdC5gk2tAba+aM?=
 =?us-ascii?Q?jIRiNcBY9zY/e17/1Sb9JXCSleGv0l8zUSGDOHCm0ElnAwcJnzm6nXXSSAOT?=
 =?us-ascii?Q?WBt7BABEDZlIZi1Ugw1gjzeF7cmYzcM0vbvAhHUzdzlduxYV8iO0bahokmm6?=
 =?us-ascii?Q?WDkcYGtSziyNylww2RB0LSaJTUNVWDkBrY7a7ifVGxuKSOMGLHzn2ETpkUCN?=
 =?us-ascii?Q?Jvqc8aYv1hXQ2LtZCAo6t6KMcCVe4MHGHwvpkcCHJudXNQJHatEBB2p4J8Gt?=
 =?us-ascii?Q?E/KRJa0lOX1SxRRCy4nCukpo7sn5IyTN7IzsYvWhcLZgMb6PZE0QSoOhROBQ?=
 =?us-ascii?Q?mMSUmjVjsYbtkoqqI9SngmBUE9VfprkinB9gAAqyhLryO0nymZVXLcO/q6JY?=
 =?us-ascii?Q?ouMbLz+Dix5DL2EI4z9RGROi/XIec4oSEWQnk5SupBQrmtvEvtDoJH4cUm0c?=
 =?us-ascii?Q?LpSAnkz+1rgcK2x+e+BCP1U2KcK9B68sQL50EvwdE7mjvUqti3erm+iBHbW/?=
 =?us-ascii?Q?XcQRIPbsm4AaG8ZBst+OET0UDORQqNlrvHyyFhxWS2c7oLBtH+0gLUQ+khB2?=
 =?us-ascii?Q?puko6RWTc/9HxmSHWUb/4IuXkl5W2KZbmRRGSXQys7dfzpehHf6shYOLPLPg?=
 =?us-ascii?Q?A5PooxrKKzc/d7mCs1AHzX6oXP0Z9L54bL88zy6lUlEu2cIhweK1oZiivLnU?=
 =?us-ascii?Q?A19BhqMjDmFlnJaLRkY5QgvzoR6Aj3lxGGW/dUeAyuwnutGr+E+y8NUtp65M?=
 =?us-ascii?Q?FnCmvmpatnOcDfSclkFH3abQuoUk1hquLKh5DGnP9QrJMi2l/dxZUC3oOMow?=
 =?us-ascii?Q?VT9HQwv7BC2m6rMv1op1tqzAeTWZw0Ucu5IY8DO3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c76849f-0b42-438e-7dd5-08dc838cbed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:19:29.9936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +R5/WeNEwMm0msDRHR6HgwYsOReaDijBe0Qwi3y2NVAl0Hc8veD4NEE7NoVjg/vvTh6HIYSwQoorEP6JdSuxOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5769
X-Proofpoint-ORIG-GUID: w1fb1SO_C3nJrUwCPa2JLWaJJ5FL1X27
X-Proofpoint-GUID: w1fb1SO_C3nJrUwCPa2JLWaJJ5FL1X27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01



>-----Original Message-----
>From: Lorenzo Bianconi <lorenzo@kernel.org>
>Sent: Friday, May 31, 2024 3:52 PM
>To: netdev@vger.kernel.org
>Cc: nbd@nbd.name; lorenzo.bianconi83@gmail.com; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>conor@kernel.org; linux-arm-kernel@lists.infradead.org; robh+dt@kernel.org=
;
>krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>devicetree@vger.kernel.org; catalin.marinas@arm.com; will@kernel.org;
>upstream@airoha.com; angelogioacchino.delregno@collabora.com;
>benjamin.larsson@genexis.eu
>Subject: [EXTERNAL] [PATCH net-next 3/3] net: airoha: Introduce ethernet
>support for EN7581 SoC
>
>Prioritize security for external emails: Confirm sender and content safety=
 before
>clicking links or opening attachments
>
>----------------------------------------------------------------------
>Add airoha_eth driver in order to introduce ethernet support for
>Airoha EN7581 SoC available on EN7581 development board (en7581-evb).
>en7581-evb networking architecture is composed by airoha_eth as mac
>controller (cpu port) and a mt7530 dsa based switch.
>EN7581 mac controller is mainly composed by Frame Engine (FE) and
>QoS-DMA (QDMA) modules. FE is used for traffic offloading (just basic
>functionalities are supported now) while QDMA is used for DMA operation
>and QOS functionalities between mac layer and the dsa switch (hw QoS is
>not available yet and it will be added in the future).
>Currently only hw lan features are available, hw wan will be added with
>subsequent patches.
>
>Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
>Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>---
......
>+
>+static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
>+{
>+	struct airoha_eth *eth =3D q->eth;
>+	struct device *dev =3D eth->net_dev->dev.parent;
>+	int done =3D 0, qid =3D q - &eth->q_rx[0];
>+
>+	spin_lock_bh(&q->lock);

There is one napi per queue, why lock ?

...........................
>+
>+	q =3D &eth->q_tx[qid];
>+	spin_lock_bh(&q->lock);

Same here, is this lock needed ?
If yes, can you please elaborate why.

>+
>+	if (q->queued + nr_frags > q->ndesc) {
>+		/* not enough space in the queue */
>+		spin_unlock_bh(&q->lock);
>+		return NETDEV_TX_BUSY;
>+	}
>+

I do not see netif_set_tso_max_segs() being set, so HW doesn't have any lim=
it wrt
number of TSO segs and number of fragments in skb, is it ??

...........
>+static int airoha_probe(struct platform_device *pdev)
>+{
>+	struct device_node *np =3D pdev->dev.of_node;
>+	struct net_device *dev;
>+	struct airoha_eth *eth;
>+	int err;
>+
>+	dev =3D devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*eth),
>+				      AIROHA_NUM_TX_RING,
>AIROHA_NUM_RX_RING);

Always 32 queues, even if kernel is booted with less number cores ?


Overall this is a big patch deserving to be split, probably separate patche=
s for init and datapath logic.
Also I do not see basic functionality like BQL not being supported, is that=
 intentional ?

Thanks,
Sunil.


