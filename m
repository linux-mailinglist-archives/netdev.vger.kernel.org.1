Return-Path: <netdev+bounces-253308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICQMFAvQdmlWXAEAu9opvQ
	(envelope-from <netdev+bounces-253308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:23:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 557F5837EB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDE8E30011A0
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 02:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632BA28504D;
	Mon, 26 Jan 2026 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iigidQ5X"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62538D;
	Mon, 26 Jan 2026 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394182; cv=fail; b=i7W0x+zFo+N5DQKF5iUrUtmbR62We6YZIHxS8lzxzwezK131CfX9HLChKbE0JAaDvmRhUOGcdh55YjtOnZNpIg0Md+ZOjO2yHdQzB2vQthyEapPpO+Ef45OK2I03IhQAt/BMgy7rE8fhtqXQGXqhk6+1m4ImJH1gzkSZ6DjeKIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394182; c=relaxed/simple;
	bh=rLEfQ4SSirNj6fWhyuQ+lzAFj46JSq45bpYDBJb5CAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bFlxgDiI/DLweKraGis7gh4pG6Wq2Glc7vDahSzxnQfU2OwXL8+/GY8cdR+3+Ft/nHPNlSnAhTuQKklESpKTeaw2UWgsim/bQlLNr4xOgbMWkGzdDkEEwE6p85XgP/HMiHN3qNZtvTysmfG8EYlZ0C8RioArwU2shdpeNXXgG6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iigidQ5X; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhSoW8FosjW+f+4hQMU+WNuSa9hWnyC14py9DBi8PWv4BYmlDEbf6pUsNx3hymP+mQvxu5F1eyBCcZTTzz29F4fyqJ+x8c2AMbe5R4gatz5FfjmAxI4JVpn1BQRsp0afBBdnEZhcEj6whibRkheABLg+YLIAO3ApXUL2K3nEd9oBLKhQUXTaySx+F/MTwNUVqmyPaIsaGN4LX3RCZH2SA2c9WFEl0QAPMl3rXe8rt59NzXIhMLKLsJuyD0jhh3TFcE2kxib1F2sTzspvg7rO/tjlgpbF/mm38WHd6oky/i8RjhU6ELqCQp3JiQcmpmXW9655ep4kXABeqv9dqr8tyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG+qmQgfi92wzmFHeGePaZHYEPOY4wHxNzjG24C+VLk=;
 b=tPHsx106/pWx09SvtUf6SEcdLcJQ2GDI0khUcTk86hqzQZ99eI2VkAVRhPG5irSZvyLbJnBbfNh6UHNGjgmwhlOLAU51Z+SI7G5O34SgZJouEKP+y7Vf+gL/NzpB4hxWU5KHyWijEFsbPRBcKC+eX19nCsA6ebbCpMOiefE7jjlkximIBdb1y6Zm7eO7RWeuafs3nhf0N9i0PZyIiZld4jBlrt3T8xgi2cLe9EWC6HQNRY55tNJ+mCe8y8n0Tb0sASQ7w5W7RGrf/0/9pI4ZGmEAZTcHzKtZd7srvZpDyBAxIY8T995QZU9sqpplKrwv/Ryk8OGWTDBfcAhzojV1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG+qmQgfi92wzmFHeGePaZHYEPOY4wHxNzjG24C+VLk=;
 b=iigidQ5Xiw55AXwNtvoq3EgHvkqYymyio9Ccd8yxy5IQi9bZR/Qck8DhSTOGdd72JKO1S3ZfljL6/IKqiCtdjFx1hHyqTnVLmvsF4ejwUEuzfQHVE2quwwYmCGBoo/0Grs06FW/cf2jpszOR6rGCMSS4DtD1tSbdlAYwLTZ0NUloMmlGB1fFePOPFAVVz1uebsVniN3TvI0ZUer/CUPl4JpP+Ez9MbSngu5zssJRWlZrF9I6GDme+ih/7LxqSZMtiWfCJAImJ4z0TOXMier2ml7lkJbkSgMxdJv35lOV0/C4XiuDFN028/0Rg9iYOqdctLoRquPYYubLbDIYdAJCxQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10262.eurprd04.prod.outlook.com (2603:10a6:102:464::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 02:22:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Mon, 26 Jan 2026
 02:22:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shenwei Wang
	<shenwei.wang@nxp.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Frank
 Li <frank.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "hawk@kernel.org"
	<hawk@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>
Subject: RE: [v4,net-next,12/15] net: fec: move xdp_rxq_info* APIs out of
 fec_enet_create_page_pool()
Thread-Topic: [v4,net-next,12/15] net: fec: move xdp_rxq_info* APIs out of
 fec_enet_create_page_pool()
Thread-Index: AQHcjkPqUAtYp6R8JEC8sathBobZhbVjt6zg
Date: Mon, 26 Jan 2026 02:22:57 +0000
Message-ID:
 <PAXPR04MB8510A5B9BF41C51BE8945D158893A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260123022143.4121797-13-wei.fang@nxp.com>
 <20260125214516.3384252-1-kuba@kernel.org>
In-Reply-To: <20260125214516.3384252-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10262:EE_
x-ms-office365-filtering-correlation-id: dc9f94d5-f6b1-48e8-96f7-08de5c81d1fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?g3k5YtwY3Q5Dov9vlnTIPm5YRVrY6NKjnYVnE7QSwU/wU5aROp0Nlic5JyvP?=
 =?us-ascii?Q?gp5AKZoAxfyJifq3ucm25TmjdKHEY/C+J+JvJf4vXbd1HFWhSVPG6evi5ooq?=
 =?us-ascii?Q?E2hpi/4s9m1DcRTxq5233qeJa0v74JT5rdROyJgQqpP+s7GDYHgCIgUyPvQt?=
 =?us-ascii?Q?Sl7oFd1uQyRnFd26P7x3QDVXaFa8d+g2HATDA5tkJYqg1IL4K1Qks9p4JgsC?=
 =?us-ascii?Q?nr3SgJJHWVB5YsTpU7KuUlZjNsmWCAFDEh8rMmvDyj7d4y0JnTNpIWWtq3be?=
 =?us-ascii?Q?bq2KSChzZRZauKkliFpgtga5AJXa4Jtvo8Bam1hUgUJIMxSFgXcw1SpqENMB?=
 =?us-ascii?Q?r8RZm4DPqJAKK32D8OU2HHj+E8+htdxWl+raiZtTKxYlrP8ESfuI2nxLQ4r2?=
 =?us-ascii?Q?i3lOZyBdt/h/yG4wz4amqlcv1vzYn7heFVVBT0nuseJ9Sq1l3xF7E+L39e4N?=
 =?us-ascii?Q?fEriAG3XW3TCCw9kcda47mJMCmpgB818UVrfNfXkSPzLWLuE0lQkV8kqg53Z?=
 =?us-ascii?Q?arB/xiSjqDBD0cmRFVIS/2At8N/Y/nHNS7oglouoqlvwID8yWFpQR8d55oSh?=
 =?us-ascii?Q?4z35Dxks2iKBi8vVJ4HU9QeWij9Xp/c1mfcbOV/vd9dBWTd2YbHf1xFT7RBx?=
 =?us-ascii?Q?JJH+oADvt/aUGmd6KdDD3G9ls3OIFNcB2Km73G/qCz6lPF98O0NncUwKG0iV?=
 =?us-ascii?Q?+0nqLcAqGzU77JlUBx3xnEhUpWm9laH0D7pK75TOPF/eO8alAqqxh/uej7ab?=
 =?us-ascii?Q?TnFEiSRrNX05ltcYIAL/jNhyGkMjNv2Asya8QAn0cueBqrgaS3tx8tioEzl0?=
 =?us-ascii?Q?ryjJRZgPFWFu9XP+SlrxSk3ILbm0/TsekMMV9OWLYbFN/tS6PTNzEMd7F3aQ?=
 =?us-ascii?Q?E8j0xprg0tnPgV8je426FeA0t+P/PIlnmIDxGCNx1QQKpykda6Fm2l4Yo6uX?=
 =?us-ascii?Q?esmx5ApY6kstj1QN/rLL30VsBX+hUfhVcqH/4KO1TPSKnwl6sqCPrx3aZhvH?=
 =?us-ascii?Q?sicNReD85lJ1oAm18Rt3Rt47k+mi33484tbJh6dT/C52R8GCnMLEvGOR/Z3Y?=
 =?us-ascii?Q?zNjmi5Vo1O2hViIXHSwxxKfL6xxGNbHkHDL8kC+G6co/IiZtRpwdYY6bAxa8?=
 =?us-ascii?Q?rxqLWB8Vm9dfPDskQEv8UKPdO38m3cp1FSRXTIPy05bIpM04nnxhRjwbMjdY?=
 =?us-ascii?Q?owL++bNybgoK7aSf8r6jcA6OPswGXocAi68SfuTX4NNJdNwHL786PofNUC1R?=
 =?us-ascii?Q?ZBqQ0N6Gmp3xwfF3qdXsFsUkSjSYZrRSOf5MvVFev3Y4lpVGxfQO3L29wn2n?=
 =?us-ascii?Q?TsQCrdnOe/6/LVQvcdoekcrmhrfnAxqhUELyI+vKcHR3I25PstOzikpWAe3i?=
 =?us-ascii?Q?eSxBS0XHy5KK59TGLRpdDEfftdnUfHkZIM5wv2Ri8cpVJPPs4MxsTVQPlLgX?=
 =?us-ascii?Q?Y4cSotmqRc7bhbQdiEx83GGsTpLNAGIbEQKBUAj1KKhM0XDpO3pA6PuHcDkp?=
 =?us-ascii?Q?VNNfSFgkKceZTe3i4xwKt21QOWLUuHAntIiWHVb3nZiIi3zE/aYysN7GqzLs?=
 =?us-ascii?Q?Q3vNhpxgJw0UvKFN5kwCKLuAWv/FW00q+CjUP4XpjADFZQzNhSuxR2M3jVIi?=
 =?us-ascii?Q?uGSmd7ElggKvyXukLq1DFwk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ovR6JJYPLIFhSzLKcT3q/nxdIVGZeDqH/pzV4yFraCh3zkH+z+u5tgF9AV3d?=
 =?us-ascii?Q?9kyEB2HhWlJ+j/mhc5r8LqQP2D79EwZ+A1jhiVcmwb5yL61SANK5czUgP32Q?=
 =?us-ascii?Q?vp/7MmZ3U6cJSL+sQowri0J1v9WdSyjsH71QeDzg935Jp+4258Nq50C88LkV?=
 =?us-ascii?Q?7r1CIwJ4LcH1uVGwca8W28MysTtk6wCafwASlrSNy/Uu1yK9f0WBg81wEGmj?=
 =?us-ascii?Q?1v2x65HqJwp41tsC518OS12zGgOX8UJLBG5z1CO1b5LhDFYcAgay+EtHecZV?=
 =?us-ascii?Q?kvWBFr++KrFCLidh0rdyzHz6o7HKSVMgjMvyZl1E/28AegGOpgrUrxmrPEuW?=
 =?us-ascii?Q?x45MSIpJ+lkkGxczUb//lMaexjEMIZeLXWxYNLju+FcenM1hO8xYepDQR1h2?=
 =?us-ascii?Q?qeROAqxNpFC2b1DmmKbm9fCcbrlcQHxpXpwv5BcnZfB0KvCsmJoX4VyHceAT?=
 =?us-ascii?Q?R8l6FyTWcXG4kRfflAC9LxBa+EMmWnlNc+ZhvrQIV+7s2x4PyRujqmTjK1vb?=
 =?us-ascii?Q?tLxSVssVRz5lu1Np8Szx3BOh62QahVchdEpAK8lMbLW4EI3ozUR4GFHy5bBK?=
 =?us-ascii?Q?BNxBniy/Kg0t9zIVX3NsEjHTMKDtSN2WiUKZsgu790mNlEu8yxOwYy5g/5EP?=
 =?us-ascii?Q?YneHETzOTfHVDoQVKRwCTSg+B28h8IJFg+3ZqgGdKVYMVHxhzoHW3J1+3yxM?=
 =?us-ascii?Q?CpUQnS+ZGBhe+E4wBvm+8xp4/TE+VGhTYljiIc0HeR+2xA9AHw181tXS9D4p?=
 =?us-ascii?Q?M8MXgC7pUk3ZBHe46d4WOfRP9LCq21wVdRejrahcoTZPnbJK6KynAq26dPpK?=
 =?us-ascii?Q?kQAxDDqXVyrgqtHOqCISLdpjq948pWhVAXAB3B9+DxJBv2DL5/rfwAcNlCwH?=
 =?us-ascii?Q?IjICgRtPDUAwhj094n2nSw+sNXHaltM5jrgi436AKjqg1Nf/mv35fiSysuBN?=
 =?us-ascii?Q?5xMjbtTpqLreSeBZxZLf9YnnU9+VCo84GvFi4ioytuiT4zAVpoQYJSaD0egL?=
 =?us-ascii?Q?yzpVobQdZcaqSS8HbFDgP+rgHAeIq+zoh94un5fd8rht2FvDtjA4RybmsOzK?=
 =?us-ascii?Q?NsIwq+eYgFfgYh1maz73VAhaIX16l+Po/+vrT/xcCzpYDBUMDW4/gRWauqFH?=
 =?us-ascii?Q?IT3n+/dQYyauRZUtdySXq6OQ28/O99VixMUv+6jAnj006Bs1obwds2OgJVQ+?=
 =?us-ascii?Q?2ABZnWHyLMoHgKQkHaqxK4Ye+scTgZjHfNPp6Ni9MW/nV5vs0r1XiI8Zq+VQ?=
 =?us-ascii?Q?G817uIXxa/4T/emMmSXLG2qvo8eDftIQDYrSD2pmp5C3sOgmUJ2mg1Jyry7Z?=
 =?us-ascii?Q?lONafT5JQaOvBErKeMKhOgXAmCwIZS6XWUS6O02fcnGelzyvwIKupvJ+J0zC?=
 =?us-ascii?Q?hMwKwyxEfXBUjlvyR1j/63qIcRV7qJ2on9PjOr+9CbPEtUxBbJr4CDE4Ck6a?=
 =?us-ascii?Q?qOb+p7Ts5h/sHMh59bMiOKnnrREwdPnAuzJKV6KxpXifVg2Mij6NRH+JIUV5?=
 =?us-ascii?Q?NvAg5ikb5ws9pUm1leitwtM/dPwDg4lWJsHXTucXoDuYDZrNjX36amlxtb5+?=
 =?us-ascii?Q?/K0iTz1kBOjDL13RXEFhJbGXWbIXdjZPLVGeuwq6cIXWnDc+tIJYnlIKSfeM?=
 =?us-ascii?Q?taBfRBauXF6+yCxqvs1BBtDZm3JaxXV6p/7k6US3xhCeZY7Y9+kfD/53yUUz?=
 =?us-ascii?Q?pEhQOo7kZvCKnuXN3ZQ8evVRsNeDbAcimq7ZZ/ysWt9Fgi0t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9f94d5-f6b1-48e8-96f7-08de5c81d1fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 02:22:57.6431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XGiM95O0yi77MgVDEq8tPowgw0cpT8uzQDUXD7jnTGdXefIQP90dtPBdKL90aokrdhlYq0US0RxIcJDzF71hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10262
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253308-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,nxp.com,iogearbox.net,kernel.org,fomichev.me,lists.linux.dev,davemloft.net,google.com,redhat.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 557F5837EB
X-Rspamd-Action: no action

> > +static int
> > +fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue=
)
> > +{
> > +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > +	struct fec_enet_priv_rx_q *rxq;
> > +	int err;
> > +
> > +	rxq =3D fep->rx_queue[queue];
> > +	err =3D fec_alloc_rxq_buffers_pp(fep, rxq);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D fec_xdp_rxq_info_reg(fep, rxq);
> > +	if (err) {
> > +		fec_free_rxq_buffers(rxq);
> > +
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> Could there be a memory leak here on systems with multiple RX queues? The
> old code had:
>=20
>      err_alloc:
>          fec_enet_free_buffers(ndev);
>          return -ENOMEM;
>=20
> which freed all queues (both RX and TX). The new code calls
> fec_free_rxq_buffers(rxq), which only frees the current queue.
>=20
> If fec_enet_alloc_buffers() calls this function in a loop for multiple
> queues and queue N fails after queues 0 through N-1 succeeded, only queue
> N gets cleaned up. The caller fec_enet_alloc_buffers() just returns
> -ENOMEM without freeing the previously allocated queues:
>=20
>     for (i =3D 0; i < fep->num_rx_queues; i++)
>         if (fec_enet_alloc_rxq_buffers(ndev, i))
>             return -ENOMEM;
>=20
> And fec_enet_open() jumps to err_enet_alloc which does not call
> fec_enet_free_buffers(), leaving the page pools and pages from the
> successfully allocated queues leaked.

Yes, this is real a potential bug, I will fix it.


