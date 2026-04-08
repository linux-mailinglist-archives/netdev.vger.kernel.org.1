Return-Path: <netdev+bounces-276330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB9JErYG1mnbAQgAu9opvQ
	(envelope-from <netdev+bounces-276330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:41:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B35123B874B
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0841B300FFA4
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9396A38553F;
	Wed,  8 Apr 2026 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eE2pNGg9"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16138736C;
	Wed,  8 Apr 2026 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633887; cv=fail; b=ml7HmKMHkKaylgEgRv6461S2UY/Ef1cmWpW+DtUdtXT6I0YB36OseWu6M6k0C8cfuRp/2+ifYgscpC2KK3R/d6mHW13jRm3urQVZUvNZdbvMmDebMEV8niHvcRAwiWyDf2yUkl+tCXCdBdrno+1xDoEpPeS87Qs5YEAZ/Gu7kv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633887; c=relaxed/simple;
	bh=+UEvJoH6wa2/nXt0d20tzJ17lr+cWUq5GEcHWHYNGpg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pUCpwyvTj9O2SbmgHEYIqzrMOfOw35d0bTF/M9eRZoF2AHeijlk9A9QiNH2EG4T3qFFDytih839krmpmksSx7yh7GR/cdVzaLm9bPvBA5Mj7QlKVSRnB9zsDXufI95MYosyx4QizUc8ILdbBQmGufF6LoeNVqBeVSwi7tWdonZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eE2pNGg9; arc=fail smtp.client-ip=52.101.84.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILkEPXNxJ+HeJXzhpbcriBQ1hss/CpaEihtALZRjwvgc0/SGqC6h2LWwAoShOaKJ1Bs7cc4wgdiIvnKID1+ZQbWN7k42Z9jL9CzCZ2RjB27U5D6LwIDpBNPRi1GrvnFcdp+73Z1b+5xi435FrtS9VbRb96MKkX2fIxPhRqXr6c7i50F8KKwLmucsmKNtpUEvTkje++o+5E7GngiwEFWRNDcLLWiUYNMVfjCo4nes4g74qrs8/p7niew0QUkDW47EW0Dp+wU6w30dmf3h6tnIEu3f+iWd9svN2L7GyKmtXSetdpgchHMnXHaFDHwqh2MKMBbB6Mn16Dj36Pr6ItITzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgjc+iDhtRtK3JACWAL8i9BfyIOhdj4DskF7Y0r/1rs=;
 b=yZ/8Cmo663PHgMPONVcOj5ny5XoJ2WlvquBDs3aoZoC9InoykL28SGotrJ+QYvwory2MK8xU+vERnPSEEoX+D9Hn9XBq7IMkE/k5oSrIu4s8ERqnU5lTYoPoE07aLZc4RfIwmJwxo5kERAXSpOou8sIHAuYic8VLgs8tOJCGzMXt4sKReM3oVNgDaKjZthUuRDAWW3l5A/yPHCYFDvsXSYhfGFfjZ+VYGS0cjS4ZIL8Spz9LrY37OtQQRHGs1M5ahqReLuweMHPB+6LR0cgOcKhaCKv8nNyMXLWCMyBcVhmMn860yOZHoz+WEvly0BNuLeFnFrmoVtvrlWuZRavSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgjc+iDhtRtK3JACWAL8i9BfyIOhdj4DskF7Y0r/1rs=;
 b=eE2pNGg9Ux/GRHgepd3B+ayw6qdfJxbeQyWqysZAZmk1/OZfJyvw5FVWxGoeYBPZBUAmWueEwAsSwMxflBMtjSMlRAo33rc8H4ia6lh4BtonBIz7yeOYo3NI5AvWqIuJCtD8wwZunGNhR42Oizq94mb+qrIuRNbS8OOzXp1E97wn7npaEToYOyoFXm3y8nAYqW4dU2OOlfzgfBJMQwyK32j+Lz7mwn1mMj4a0MIIM3D7dVddsr/OwzDdulX7OAUCi7ItqWXy13LmP/o/dwrq2qAV5otckEduOqv4bCbiFju3371TfdG/fmlvigbSiJmRm7pQSIK/U4tEuV+aAnIolg==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DU4PR04MB10599.eurprd04.prod.outlook.com (2603:10a6:10:593::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 07:37:58 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 07:37:58 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank
 Li <frank.li@nxp.com>, "chleroy@kernel.org" <chleroy@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v4 net-next 07/14] net: enetc: add support for "Add" and
 "Delete" operations to IPFT
Thread-Topic: [PATCH v4 net-next 07/14] net: enetc: add support for "Add" and
 "Delete" operations to IPFT
Thread-Index: AQHcwQGeP/HV20mPxkKmaPorSbeZFrXMjUkAgAhC7jA=
Date: Wed, 8 Apr 2026 07:37:58 +0000
Message-ID:
 <AM8PR04MB72844F38B677543BE84ED605885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260331113025.1566878-8-wei.fang@nxp.com>
 <20260403011734.1795551-1-kuba@kernel.org>
In-Reply-To: <20260403011734.1795551-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|DU4PR04MB10599:EE_
x-ms-office365-filtering-correlation-id: da041aa6-4c0e-4d80-7aae-08de9541c1a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 gfuyhuNKRI6hs0PFdIdaNoro2Y5cA17B5tcllWF28I+kYMu8Zwt8JSP666+wWneGh8Ra37/j0SfjUT6CSvBWdcNkFI18ZGmN36ZovlZHFTf7iol5vmZ6rnZknGBmB9DOeDau+AMUXGxm9Lk0sXzjuQryFsatq9WARdGgoEQT+xHuGs1l2TXq8aw2M5QEJLA2RlzkU+LNrV7cC448Pbqpdm6LorptGoxbRQI3dPWC99eLiw0yZGqkH5i8W1rbfPtJej/EBArcRQwHzlkdvM4Ho8f3QLr/JFsWYdJ7B+WB4t7Fir2geBDy/W9DAFKkNmBXWcYu98vT4iQN6HJjNSL6kyFxg5MjK5Gm/WkA8mZT/8Pnk/h5/N8StlxD4EvG5anJ3DhO8K2Jdv1CUNb9uD7AtLGOSyvqPxw8kfi4ZJyxY3/DvG3HDomfUKtqVCoRchGHnIi0SgzPDaLlpJn/c7ezUmnHQcf2tdnjqA0WSEOBiBKoGM05sw5XPVOjLnCBrhc6ghXFxCPVrf59ImkFlWq2XDlA4qrnYne9zyzHd3S7Iw2TM1rtoR0h0VDFettJ5sgR9wumkbUQ6eNTMQO5ZTIMKyAGlDyl6aEvhnF87+9nWNpXgHsBxpbsUvjS1lpoAggKtEcsXEQwMV+ej3y3GEd/9aG2t4Ja2TeVVu5RRRRBTiPFXy5cP7TjOMJm9lYJgDuiMnXxCoQdogOVFYRPP0FC+jhiZp/UxN8RfQ9RRlGxNc0WtE2XFVmDY+FUt0KxOiqasuoFWCq7JIQKuvGR2eVoSw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gVyzECq8b80JMrQaEnPMavQxaOSia4E3FVyZyJSGqV1jOEwe2LZcFC7c+xcx?=
 =?us-ascii?Q?GkUaGoyhbJWRSUen5GOX3COR79oOnJNiTJdloaHhhQx7kOdbOLfZj1Rv6aUC?=
 =?us-ascii?Q?LastaNKiTfbiBU+dXW93nt9OlzPV/unD5bpHIkcDraAl7ZFzCBF2/jLAKlBC?=
 =?us-ascii?Q?cjxcZWmpnhffUZNFmTds/ypIjwn07WkgWhAtDE4UqO2oSwv2HR5NFWhg7tEX?=
 =?us-ascii?Q?suZ4O37hbdorvuxmXMEv8zS7PV6fl++yNKzii/I03b3lceY+UJ/MruXkYv19?=
 =?us-ascii?Q?zu8RwUDLj/yM39C4O0dPX3VT0RBgKYgE5R2m7PLmiJOeAc3uTn7EcwPNEfkZ?=
 =?us-ascii?Q?x/s9P60dl7NAaIBoAIGtqD6VlQMmedkwLD8SVQIt2aYurTXKEsveHT3edfHz?=
 =?us-ascii?Q?ybz0t181QpPdmJMLnboEoJCHVeeVmZKfA41kOscoT2/r856DR/dOzeAfgsjU?=
 =?us-ascii?Q?FuMpXgKteLv/8vJgLaR7SlBZwxIXAxFgbpQQAWvbwSyppHlOhe3MFJeRZBVn?=
 =?us-ascii?Q?OGYUOi38GAs9wRbLb6Id3sQI9F9IKdE18M4O0LlfafFLFKTkeG3c5u0UXpvi?=
 =?us-ascii?Q?/uqOVvZwrXPUaA/Y49x4kCw+sVrRHHRJ6oIxuIXQGw22czxzI2d1GTOBSmmj?=
 =?us-ascii?Q?tNtx+G/1Mub+h/N55BQr/4+EVJlKrxbw2hHkeRlNqfH8NjMgATv2iA3/9jZs?=
 =?us-ascii?Q?3t6hcYtebsD1GzHzlbFPjs31mF9tzZbAxXaAxc0pxgSgmGvlCHq17UYWNedG?=
 =?us-ascii?Q?ldiSqeyMPJQb9RwoH+Z4ASRm9v1E3e/sNMLWBeBJwfbmMHPXvvrYgjTrSmZa?=
 =?us-ascii?Q?HI6vU2sbi0FDjch0wqjzLzS7b9tOyKqa1/em4cPzBiROo+j7ixgrUCrVVyd5?=
 =?us-ascii?Q?QMdoMKIohgT4V8Q7s6iQ/Cc4Uw5b+KXu3AOKKYEDDTKDT3lMXuW0O7GjYn7G?=
 =?us-ascii?Q?rW1JRaADWKxv76jGYIu6LyxVOK1dLVvu7B4KH4dVvoCoRJS1Hq6edHtbg2jj?=
 =?us-ascii?Q?9hL0sGVRlt8klIPkUnGtmd7orMvfprkglf/8DUbzq51gjDVPWk7JpCd2hZbK?=
 =?us-ascii?Q?IHhH5zbYvNg0F9QMs4cke/AG0ValqiqrhY5BHHK9eVLADHlrvxsu2Q++YsU5?=
 =?us-ascii?Q?zcepYS+k1J1h4Eqw6unwCB6aXlRFTLiUiIF8u85M0IgtzdPZ8/5h0Xa4Br5L?=
 =?us-ascii?Q?3SDcdnAw7s0I+KECWS03fjGDd5+RLMy436TYFmCjtU6LfsC7wEQh0TWlQkGs?=
 =?us-ascii?Q?PUMHFEAPeQieM0Hc6AAzfGoElK1Cbxuxr8pLNfK69c6/yYzVOBwCOQMSsif3?=
 =?us-ascii?Q?k5A6+LfjWsAVTVJtrThJlOWFpa4o7g3i/80zkvd/rjw/NFGLqkDGgTc/ig2W?=
 =?us-ascii?Q?zbwQI1MG8dCdZJGHGXIxSaa0KihaHbT86IepMO0OXSSoxOgULiHUpATPruoz?=
 =?us-ascii?Q?W39M8aaZfGsjTrukmnSJ1zcOrDj+QFdv6BzlN3qnLsmjUmn0LcmaSoE5iYJH?=
 =?us-ascii?Q?oJXutoUTm+i4M2FoqxHKbi1IUXI3snIqN8PfV+ZgKZcyuRLsRXvwrOeHT8h0?=
 =?us-ascii?Q?3szC2X36sVwkusKY3zgyZZjdZIu5Z7ZxodV+2vjqE3ciRooZ80EyK7P8XRo9?=
 =?us-ascii?Q?bO8uIPrdtit0nOWtNZ+eEPfyIxcA6Iu6RidIb86KXGIYNXI0NlhO6vTXPMAv?=
 =?us-ascii?Q?Rt3a/htq44m5/UobTlVj67V7qmOPr+v7VGPw7C2QkANO1iI/?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da041aa6-4c0e-4d80-7aae-08de9541c1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 07:37:58.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lU8Jzw3qcjTBjYf6eiEhYVvAMfpQuo0y+/erRTiIyfs3OrIaz+eY+S3Dz/tzuugvWqTGT8OCb1VytAwjK7FzRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10599
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276330-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,armlinux.org.uk,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[AM8PR04MB7284.eurprd04.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: B35123B874B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +int ntmp_ipft_add_entry(struct ntmp_user *user,
> > +			struct ipft_entry_data *entry)
> > +{
> [ ... ]
> > +	err =3D ntmp_alloc_data_mem(&data, (void **)&req);
> > +	if (err)
> > +		return err;
> > +
> > +	ntmp_fill_crd(&req->crd, user->tbl.ipft_ver, NTMP_QA_ENTRY_ID,
> > +		      NTMP_GEN_UA_CFGEU | NTMP_GEN_UA_STSEU);
> > +	req->ak.keye =3D entry->keye;
> > +	req->cfge =3D entry->cfge;
>=20
> The request sets NTMP_GEN_UA_STSEU to indicate statistics data is present=
,
> but struct ipft_req_ua does not appear to contain a match_count or STSE d=
ata
> field before cfge.
>=20
> Since the hardware expects STSE data before CFGE data (as seen in
> struct ipft_resp_query), will this cause the hardware to misinterpret the
> first 8 bytes of cfge as the match_count, and then read the actual filter
> configuration from out-of-bounds or uninitialized memory?

Based on NETC manual, the STSE_DATA is present only for the commands
which perform a query. So for the 'add' command, we do not need to
provide the STSE_DATA buffer. And STSE_DATA is the statistics of the
entry, which is stored in the internal buffer of IPF table. Performing
NTMP_GEN_UA_STSEU is to reset the statistic counter when adding
an entry.

[...]

> > +struct ipft_pld_byte {
> > +	u8 data;
> > +	u8 mask;
> > +};
> > +
> > +struct ipft_keye_data {
> > +	__le16 precedence;
> > +	__le16 resv0[3];
> > +	__le16 frm_attr_flags;
> > +#define IPFT_FAF_OVLAN		BIT(2)
> > +#define IPFT_FAF_IVLAN		BIT(3)
> > +#define IPFT_FAF_IP_HDR		BIT(7)
> > +#define IPFT_FAF_IP_VER6	BIT(8)
> > +#define IPFT_FAF_L4_CODE	GENMASK(11, 10)
> > +#define  IPFT_FAF_TCP_HDR	1
> > +#define  IPFT_FAF_UDP_HDR	2
> > +#define  IPFT_FAF_SCTP_HDR	3
> > +#define IPFT_FAF_WOL_MAGIC	BIT(12)
> > +	__le16 frm_attr_flags_mask;
> > +	__le16 dscp;
> > +#define IPFT_DSCP		GENMASK(5, 0)
> > +#define IPFT_DSCP_MASK		GENMASK(11, 0)
>=20
> Does IPFT_DSCP_MASK completely overlap with IPFT_DSCP?
>=20
> If it is defined as GENMASK(11, 0) instead of GENMASK(11, 6), using
> FIELD_PREP with this mask will not shift the value into the upper bits,
> which might overwrite the actual DSCP value in bits 0-5.

Thanks, this is a bug, I will fix it.



