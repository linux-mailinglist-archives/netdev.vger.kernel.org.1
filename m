Return-Path: <netdev+bounces-268537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDyaBfsvuWkYuAEAu9opvQ
	(envelope-from <netdev+bounces-268537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:42:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 358622A8237
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7743F300105E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F893A6B80;
	Tue, 17 Mar 2026 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gdIDjlK2"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336FD369220;
	Tue, 17 Mar 2026 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743569; cv=fail; b=gfTMub0rVvXyZYxKV4L4FssCgQM+AmcUHkbWYr9MKSzPOH8lcQSr97w30OhrJ4oBMEtXVfaWeadFVhUw4Vs3ocS9axH7Gtz0nz4Q43Fjc6Go4jyfp8ayLJcHodwQwJsrNEBtystRlGeTAbSXEa1GgtE9dyGo6iZJTWu8WmLkUQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743569; c=relaxed/simple;
	bh=P9h1X1XV1Nwubes57ztH05QMExYEetMc9e17NirFrWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lT4hxmS2ABiJmvDqawdeQANmP+9+dbTQ+4a7yZqACpWmyHbI2a6FvkHxjGgS94C+RZc5zTOA9vNjdLDbLG6/VNne4LyMw9rG42lkSAHMYStKFDl6WUjwb5a8KVAORVEPO2hEIME5u+ga6/jM4QalzeU0oKhuoDJx31g+gXEoV7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gdIDjlK2; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxVHwGhiKtDbb98QypgxcNwiHe/Uc3X5uP98TXJNnhZarah2Vi2CQ8fd9GzV378nPpH1DbXhpNntBFDFeY6CYZ1672GvnivDqAzL9Wx8hQ8Y1aNR1f7oZz9vr9hfWo21TszXyBO6Yh3QFPXzVmAYxhcNJIv0kZYAiZFg5lZObci5XciemE0V+PfvDgHD6/Nr2St2mDf5a5lCMFnokiSO4e1QpM8JrO9FSMtcgIjtd8iQhkkLJBjqWWZsRE6taZRN1aEhVIzbmj9WCypc/axDNOeRw+M0zciPFnaukohuc3tAx0w4JPj9nof0LSdtW9MNrju8NFIZMbZHsbOFSVv6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2guNc0O3wJ2+rLf2InC2NM8YqrRiWVxtA2xjswWPrws=;
 b=F3FwufRdizLTV6vAqdRmUeqfbNapdRC8SVy1b9tTMwCOCQVFmWWcdpNfCHjB96MS/0KglNQODK5LxQYF8qmSaKzuWe5jD3KtsqS5jqHrAoEgVsobbV4RURWEI8ftZ1ULTG77cTiYvEtfJhAqsat8r2IuX4O1X9s6CvuBLQE+VNc3/OlNHd3089LEiVIACHhpDrUZ91f32VIyghnXgXuz3Y3LAPf6m4kNfNiX+VgYgVsDAESjQUzw//NzTQ0o07rD3xmWSx2uz0KhAIRho50HM6SlW7ni3eh3ySQ7TGy5J7h/2boxEZL/sIJhIbE4sX8xXA6CnMcZlJYU8UjNgwNalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2guNc0O3wJ2+rLf2InC2NM8YqrRiWVxtA2xjswWPrws=;
 b=gdIDjlK29WvHQ3uvGvY0V0ze7+aytZ1w3HZSZZ0YCzEWwVTWxzIr79+R2yUQfVGhuqPAEwlkoCwVlmTBQBOcYhukPM0KHvVvk/9AgAflpIKPCpD59EAkP7pXcwgl/N2qRIy4OTvl4bKEEb7lWvbzzEvTaOlbV+24WhsJ4Wz6CMxSINCIzQ9YQP/KXuDQ25VHsxUHCRtS/Hi0lDUpltvJV246aaX41/ItAkJFtbASBWv7wWssik2ZgayJBhlAN9QUK2ZXac1h6RG525osDztFlsZ9CHPlRDUKnM2x4uLOyC+p25GvIDqElBATdcNBGOULwS/+paDSgUYAwhJdURkhKQ==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by AS8PR04MB8721.eurprd04.prod.outlook.com
 (2603:10a6:20b:428::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 10:32:39 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 10:32:14 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, Frank Li <frank.li@nxp.com>,
	"horms@kernel.org" <horms@kernel.org>, "saikrishnag@marvell.com"
	<saikrishnag@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 net 3/3] net: enetc: do not access non-existent
 registers on pseudo MAC
Thread-Topic: [PATCH v5 net 3/3] net: enetc: do not access non-existent
 registers on pseudo MAC
Thread-Index: AQHcss4OdjkBizJEX0ia8TBogJfoTLWxNqYwgADLdwCAAIdNcA==
Date: Tue, 17 Mar 2026 10:32:14 +0000
Message-ID:
 <GV2PR04MB11740D099702101F6C23028849641A@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20260313094644.1132411-1-wei.fang@nxp.com>
 <20260313094644.1132411-4-wei.fang@nxp.com>
 <GV2PR04MB11740DD2AEB7641D7617E452F9640A@GV2PR04MB11740.eurprd04.prod.outlook.com>
 <PAXPR04MB85104DB72F31FB794B4A456F8841A@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85104DB72F31FB794B4A456F8841A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|AS8PR04MB8721:EE_
x-ms-office365-filtering-correlation-id: a46bb0f5-b835-4555-7f88-08de841074ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|921020|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 yUyilX8DN/7nDO7HoOmFuiaop65CYkN/AUzSGe2hiWgw9udtE+KU9EeZq6wA8psMf2HZRGLf1All1z7DIBQtXkDfqfXm6n/lmT8JwNtbzNzxnM+6A4fY1aqDq/j+RDSddsKnqhsfzmjb+rj010yW6BSPkEkE8QQZj5SCOlAr4raDqxafaHwKU+rUDZl9P+5agkPEsvhp8Pf+sK2AvDXpJl9a0ItyjV2/BiswTNSX4fXSmZd2/KPMUQ1+A1ITK1EYa5dGxHB4FqmBunSkYG2mHfsAaL1blDH7LeeQtgrAyk8tedlW1WJ4vPNj3rWBx3ckWbS6q3T3DQ1G7hWNhOpQQQdgInx+QEEiypsGkMkxBey4llUHs89Zvlz6VwoIDVr/dxi0uj9dB+7AKHZzLMXV1ompXAmr7E46lJbRgWG/gmstImpLdzW4asa5lZ7wz9IAOCEYCH05nu9yplIc3Njxnb/XexG8TMs3x2/biZcsrxGSZkcFaNLnSBzOFwSIfrWwX9IMVHXlG1bkb9sKtv8ycjZ4VqIBs7GUuXYBaR4HenQJoCuhEnBMpLpprSfJFZi11CZOZrNTyRi0Lo0C4gacEpK58hjaCvLlnEWxaEEhUSlq/tkZss79TxXfgANzyrAIFmr2L9hiwCXjLvANqhdzTu9AjI6Owq3mZmZp/R/jDmAL1nIX+qZB9ZZtlQUwl6Q8hO8Rl/PFAlZGAXtnzsFzHGe7OJUEk8V1FTfzEOAmqmy3W7lJDEoERbs4Z4XaCgSucZSXk/0qmv4mATkyrVrTWKsMhQTbyOK20ig6YsSzCwN3HbpX9uEE97sykiFx+BWW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(921020)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nOecSt47s1T4OY04CCvy5BjGzyrBHsOY60b66+MdSaJjOkj/hKUWBiZ61KoD?=
 =?us-ascii?Q?7lbxYesy5akuib/L/VYBp+geMk4Iof1fiSt7Kq2ZSrubwiUKpQY16VN9EYWd?=
 =?us-ascii?Q?TAJTPWhjlZdPvE45NJ0wW76FAdkSpHpYkMpBZtdeJrEJjb5nwLw6nVtkm5oz?=
 =?us-ascii?Q?V6DSSzvGHa71olUjc40r2moXwBORnbKUoORGMjzdwhqi0zo1sfhYOD8DHCCF?=
 =?us-ascii?Q?BlGwlSrcY9vQ6l8DXlWu2/TOT8Vj1nCaIUR/xd1mRjSTKA5zysevnFD3jvE8?=
 =?us-ascii?Q?RCf8e4oEbNXUQ1audPH4jEYcrRXDDW+4VcPaAQ0l18v8cZEG4qf+adFSSnN2?=
 =?us-ascii?Q?ecvyS2ecLueRm1PFewXbrI3GWDzHn7hyKcQf20Vfofg4J1YcIO4ZO3SOebQ1?=
 =?us-ascii?Q?IEqtaP5VEvZw9CTcJ7Kg1WPQpIQayTjR5Y+4s53eJcp4vpfzcJcceAkkVefO?=
 =?us-ascii?Q?TetmyCC3qkW+nkWPQwLDzMpVOQEGzuk0jvPKTRmG6l3BfdNRQv14Ca8lc7FQ?=
 =?us-ascii?Q?u33+GblTLcqq3K0Sd14LgpJBLu7klXpa6twquZ5u5B5sYOgbICFWZKrTxXGi?=
 =?us-ascii?Q?PYux6yXw6rMSbPtqAghdXMXJYENNhto3k/tgAjNKSt0sF3c28QLjZ6N2OqFQ?=
 =?us-ascii?Q?S2vOAx3qflQRzI3cewium3/FRdmm3HzYPS22n3+moyM2xobbh8neZRj7YvgK?=
 =?us-ascii?Q?BN9ktbpQWnPU6ksIR9vGcLBRIrBuLJTokQdhiK5H36f7oFGrwtyuHmDieOjb?=
 =?us-ascii?Q?+sacdtquMY/ASFn9UZErxDcokGmcaSDHyauRIrZjjE/Q+ONBtDTd/+otLY7H?=
 =?us-ascii?Q?lnLYIYXgatp5zBM7QoMnUx3socOkOzUewbZ77LS4lPicIv7FJ/1VSZpffMRF?=
 =?us-ascii?Q?Vni6qVc7p3pcnbnlnNYG9Y5H2hNJ9s5phau6Lp7FyEciplfFLJKqhYGWbTG3?=
 =?us-ascii?Q?2FQ19OD4gouwn5YjMcNoabbLznH8Uo+4tMAodBHhMS5MdIzczQkCJYTWz5Ip?=
 =?us-ascii?Q?jbEfLoASa/V0RINwqJH8JW1om+H30dBocprHuNYqJWZLLTJQJ9A1YOD5/1l6?=
 =?us-ascii?Q?2VRkBPa2M3TWuq55XvpOgT5QdfjhQNYugBZK9qmXAKAETa7d6dI7jUp84J1w?=
 =?us-ascii?Q?xkvQJuCfo+KR+0QlybtudCcJR4W4RiVGDVcIJyVaY2MJtpRPe+i6crTaWzpo?=
 =?us-ascii?Q?/FedlIuYs+dGrvCU8+SCep+K+Xvf5J0zMPbE3xPOOiheF/k0ts14e11GGPWa?=
 =?us-ascii?Q?UXdnlDAIgf5R4ViUFa/I7oOwg/WF6s1VscP3AmIdSL6PhtMdwmO4U/ociPg9?=
 =?us-ascii?Q?dL6hDZx/p7lHfhckoxXxwiNedsqWg8zIxpeDcTnNhCGMFiMLzQCzEn9KK8Wu?=
 =?us-ascii?Q?+zUM5N6eTmB7/abjfAFwZfKEp7glJR1KCxWkMzxCxPqwPQuRckaEFf6ZKGcC?=
 =?us-ascii?Q?qBxjLeEiSDWliV43juDjvty+5swamii0Jvubzv6EHBAYiwGZJ6+XEHhl+ZI1?=
 =?us-ascii?Q?LbP7fXJCIDTLlACXTDOLlc5nHLCaODgj01FXBNBZ8wzSBOXxB4d0K2ilZRvN?=
 =?us-ascii?Q?jFR/ZLrN9jzhNDpFBIL0ejDoq6GvDIwZi8FTp0efvjpIuvJ58vkwn9G5sxhC?=
 =?us-ascii?Q?4iVMO6gx3UbV561Xhtk1L3npNr63XP6X2Yr3x2JLvqn+KXWLpFqLf8eZHo8M?=
 =?us-ascii?Q?LTqiIOMyr5IpQdi8m2X7xxbLTuGhXcyEvbjGtTeXvEdvYvgigfjPSfmiw15f?=
 =?us-ascii?Q?oBonSZ7j0A=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46bb0f5-b835-4555-7f88-08de841074ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 10:32:14.6398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvTU2ZDTQJoRcg9ZEtitZrpULTy2Vg701firVgQrTSD2QI18VSjCCEzBKawn0BNpQK674j/e1RIYM9SDHdfN5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8721
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268537-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.manoil@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,GV2PR04MB11740.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 358622A8237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, March 17, 2026 4:15 AM
[...]
> Subject: RE: [PATCH v5 net 3/3] net: enetc: do not access non-existent
> registers on pseudo MAC
>=20
> > > -----Original Message-----
> > > From: Wei Fang <wei.fang@nxp.com>
> > > Sent: Friday, March 13, 2026 11:47 AM
> > [...]
> > > Subject: [PATCH v5 net 3/3] net: enetc: do not access non-existent
> > > registers on pseudo MAC
> > >
> > > The ENETC4_PM_IEVENT and ENETC4_PM_CMD_CFG registers do not exist
> > on
> > > the ENETC pseudo MAC, so the driver should prevent from accessing
> > > them.
> > >
> > > Fixes: 5175c1e4adca ("net: enetc: add basic support for the ENETC wit=
h
> > > pseudo MAC for i.MX94")
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > ---
> > > Note that the commit 5175c1e4adca ("net: enetc: add basic support for
> > > the ENETC with pseudo MAC for i.MX94") does not have such issue, this
> > > patch depends on the patch 2 in this patch set.
> > > ---
> > >  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > index 53cecbb23a97..56899f2254aa 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > @@ -814,6 +814,9 @@ static void enetc4_mac_tx_graceful_stop(struct
> > > enetc_pf
> > > *pf)
> > >  	val |=3D POR_TXDIS;
> > >  	enetc_port_wr(hw, ENETC4_POR, val);
> > >
> > > +	if (enetc_is_pseudo_mac(si))
> > > +		return;
> > > +
> >
> > Shouldn't the ~PM_CMD_CFG_TX_EN step apply to pseudo-MACs too?
>=20
> Based on the NETC block guide, the pseudo MAC does not have
> PMa_COMMAND_CONFIG register. So no need to set PM_CMD_CFG_TX_EN
> and PM_CMD_CFG_RX_EN bits for pseudo MAC.
>=20

Right, sorry, I misread the manual. After all, excluding these registers is=
 partly
the point of this last patch, as discussed.
Meanwhile, I was also able to test your patches on my setup with pseudo-MAC=
s
only and it passed.

"
[  159.469353] nxp_enetc4 0000:00:00.0 enp0s0f0: configuring for fixed/inte=
rnal link mode
[  159.469605] nxp_enetc4 0000:00:00.0 enp0s0f0: Link is Up - 2.5Gbps/Full =
- flow control off
"

so,

Tested-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

