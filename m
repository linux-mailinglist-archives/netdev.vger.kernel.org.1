Return-Path: <netdev+bounces-286430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFs9EqlJAWqKTwEAu9opvQ
	(envelope-from <netdev+bounces-286430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 05:14:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E52F4507876
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 05:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 766FB3008740
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 03:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED14376464;
	Mon, 11 May 2026 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P94sOQnr"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562701684BE;
	Mon, 11 May 2026 03:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778469285; cv=fail; b=pBJht1WlF0qQGp9nnC4B61se1VJYtNact/ebX37WkASy6OTJWbhei/Adycaud5WC3TtWwVS4St3sEsxDffksDtbQrj5JjXAFlJ++dmA2ZRxag+9+kxGAMss7TM1ieonSaXO5r+Lad9QbaPSDDl9yjhacUhv2nEIV4O1Ub4ccqwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778469285; c=relaxed/simple;
	bh=iqTAuW2Se1nBDqvl9tAKb82A/sK1jGE6R67OhI+GNmo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tAOSeQ8zcnR4XBPG9bgsDVjze1jk/KdPPkjxXpvJapsnzN6EyhFuBNCE8kF3rjjC6Y1IaFLhNQJC4b625qyAHHFhXoArYn8T5XxBGyEx17TCflPygvqg2zwD+qVZn4v7iIpZT8EoXXe9Xffm/R04Lcm6PAGnt1ofmKPJgD5pLOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P94sOQnr; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOv8GSBEAqVRHMFtU9fodHd1Ay8iE0jxcEu+TYK9YtcZwu2Afe3z8V17xopOSeO67TzOGsjH/qWEj09xVabg2TpvfsaXoSH2w1ZSLRsedBFedJj7lplelEHbwK+IAJt1uclDYrQUhDJECBpPRx5UCiceX4Dwee6cp+l97UEndGvJUXt3JSQ18hL2X3wXtsDZaPk+VhLlsvWiFhE9jVG6pF7+ovFHfaRyTsJP0q47KcJBFEFQnRSNFPlq1jPStrAt3FeD2Sg6o19TCJEex0prK5o/XrrZPqfbNKJVizF5iYyoky/IxMb7JwzbSio1orf/npDo0q8uXEETwSBlex2t5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+T+NALi8eKjps8Rx7LU1yMxmFMmrqoHmeGjfboVY8k=;
 b=dzOXttmt5jJqBU/5FlAiD1nufAgGu1VnEok+gPaNrxAPxEF/HS3vDsiUJZz181SUB/AkQHNq+EgRc1xXo5/48JcWhP11lHjyQIABvQPidi9/FwBxiHPdzroPRRv9tNGKT15zRMftdLFBc+69CWoeE2egpzHwKRODN7W+c6RVUJj+u2dlUpaUAi3+vWlXoEOGUmzPo0RdqLZEuqba2OBdQ0jGW3ZWD2703xQcw7CSY30U5wxkPX4WJpDNcwD0OUGVi1luXGyg8zv1d/7fy3L52pn65L2JwhLeCY9l/9Wsr/l83xnrLuPi2Raf2yhkzTxwQPt51cw5d/wphhqdi3rFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+T+NALi8eKjps8Rx7LU1yMxmFMmrqoHmeGjfboVY8k=;
 b=P94sOQnrOfmriyzbZhcl6UhdTSJ43RkNQvEKAQTJ0EVKf87YNaHs4BTWBHxPm/H06o9k9yY8v+3o80FPweeosg0H2WueT8E6SJuOirE36I2V6DphaKzFaftoOZK+uvo+pIAilSiCCHnXV6vb3C7VAjskvN8uWzwvP0Wb62lglzT/AYzMiLVLCwYzApYzgoK3dYeIJzZTOKHPmW0TYxd5c5rw9kqkUcYZOZQmjnNzSTFWkRuE8qdsEhdjJeaNclps5SntPL2/DLEzrOdfNx2eI82JPwIm1IRjaZFNuIozJG/Av6DSz34k+xC12+QV48qx2X7v9MEDROn7e4B6HqyC2g==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DB5PR04MB12203.eurprd04.prod.outlook.com (2603:10a6:10:64b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 03:14:40 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 03:14:40 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v6 net-next 12/15] net: dsa: netc: add FDB, STP, MTU, port
 setup and host flooding support
Thread-Topic: [PATCH v6 net-next 12/15] net: dsa: netc: add FDB, STP, MTU,
 port setup and host flooding support
Thread-Index: AQHc356oJ+jsDHmt5Eqn9ujFEA7UKbYHFeAAgAEMFuA=
Date: Mon, 11 May 2026 03:14:40 +0000
Message-ID:
 <DBBPR04MB75004982323B70E4E942331688382@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260509102954.4116624-13-wei.fang@nxp.com>
 <20260510104838.8514DC2BCB8@smtp.kernel.org>
In-Reply-To: <20260510104838.8514DC2BCB8@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|DB5PR04MB12203:EE_
x-ms-office365-filtering-correlation-id: 75a0fb54-f26f-44af-090d-08deaf0b70a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700021|3023799003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 SH4Yb/5M+finmqj7OfQvBn9n/KcHVcjvMJa27ltQMeNyuZIQd3YopIpwpjzzkpY83kD4M95YhKcKSmfgAwt5j223DPZSlGSp1c+OThH3v6RxPfUCaguZjyhMi6SDlsvZFv6evGjIQXw5fOTypbuzYock32PAkUSTTbY3CqfgTK55tHRDai3eLVyAeioOjonwRtPpRchx68Hv3+UgEmpC7qZVuVykvoSSWMdlzJSWQhkXUzTCWX40jv376vdV5RWZ9JcNRqkAaI1iHTLNMB9SQZbnyRyo02Ew8m6LKgQC1sxYaFLnM1nE8Oe/9SdLVQ+UFrafVbPDLwjfuE/JOM1y7xEF6Xf31cTx5vyY2mViO9mjd2gIWVglfuVZeLg797RmFmCUQuLL8xZmOgFXVWsJTOq9b9nYtamgpVUMmSFzJW8R3E12LrpZL6rGphIh54fepbWR8on65ILOJ+gZRVZ9xczmY4msesOl9/UNLtcFKJEfXihkV9AVuzh56v+u3JsnAySP/URARAQiPQJGQBZNAj/pftFUTFnkR0zgoGn3ZUzbm5V+HYgQoe176f9/Kg4LAM29wLl+QJ+LmndD+kjkNQQQD86ASX5naxZM4wNeLLysdWY1CbYjmtFMdY4dwruWO8fC2gkOCkXw8iZtodZ1LHMan6cDGnTOVMPUmVajUDmc7ywMsnZ8RIEE9Lh23FHLMGC/h4tFgaphQsa2nKE9QEowEKddb1Z2SRj4yjThllFSU8UUc5RnALanMzxFXVal
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o98GmBOCT0+0UBINaMpewNSGq6dXfvrGe0gTEoaJsZ1rorz3Fe2Et9ANt01Z?=
 =?us-ascii?Q?3l8/GuvckNwZwyvokTjD8gRduuyeKY+qMdsGVkwQeJkJhqjK6qbaLHnKfkgL?=
 =?us-ascii?Q?QcQr4uKKFsHT5VtXT7qMk1rWryri+6l67Q9f4904yiKZO9x0dCJQKf615JkQ?=
 =?us-ascii?Q?IZRRQO/6enXswwMGWOlYaEICKAQU4J358f0xFzrx9hBJtTTNgb4Q3lLc8CX6?=
 =?us-ascii?Q?OuaLhaimAP2LkKEg5ZePsCBdKcw1fZBhiSP5iEe7fbWrfbn9P3++w6sOKWfw?=
 =?us-ascii?Q?cMUscpfyqxvCAYmdduN/mYWmB2GfwhvbmZhbKQXSnrs5YpXvbEHTCf0ZNjcb?=
 =?us-ascii?Q?DBaE7UZ7gQiApeXj5fPQPy9/c4IjfJVR/90Uuw6FZExKGBlKWtOvWsFzcusa?=
 =?us-ascii?Q?JC+tmd7B59nXQ/wPES2i1nfhpg9Mi3rRXIRC0DCPY7CQk3L1gT/xOcW+JNFJ?=
 =?us-ascii?Q?IbS4WIer+seeTQrwlY/aGUEnsj4o5EIRZJgmqHgPrHvnW9HoqSVHfTIITLty?=
 =?us-ascii?Q?2NaOITmrrMpOWglgSoe9eQ3x4n1Dga6K3gZeP8xVd/bWAUz7lKS/zCCMMf/+?=
 =?us-ascii?Q?IBko+POIZUShjccbTuFtfH0xqk4uWmlyWjjyIaxi9ImYGSor5DAOeSKZkfNr?=
 =?us-ascii?Q?LAqgyNXNl53GYBzV7BrhmOA+zQYH16J/sU9tzYna65Vh3JK+gyTuiW+UjCRU?=
 =?us-ascii?Q?4GPttJxjHypbe40KahtFiFvhaatqhleBPC9cousO/qXBcpyCF2KoZDzaUta/?=
 =?us-ascii?Q?bUxBI+qqTmUkJgWkMAUXletvi5+VBkdmT7kUiccqoFLy4AshSzy5ZyLcankK?=
 =?us-ascii?Q?gZ0wJKLNEwpgRBgySSwuSoiy+DgdCv9ugSWErLUCMw9L1vqx9K8sfBzXeHY0?=
 =?us-ascii?Q?kXnSVvJQ0cs3EyYrJl8f09yogbWuC4DmJRAzP52iXWakfQlcS6IQQ3k2C9N4?=
 =?us-ascii?Q?zOIrOY3Lt0bBRA2bdCSJJXCF9C4142L4prbryTw8jVO5CBYZMb8w5G4CJUnH?=
 =?us-ascii?Q?OwZJcJFe0w4+qG72RRLdqF8aS8JerE0B4oxhNbImVMokL6/9ubmyudKBKW8Z?=
 =?us-ascii?Q?H6+uGJkWSXDTAvBHXXRjwZnnC83ElvhEkp84l6sFOcvjtqzv14QbSZbcY9vh?=
 =?us-ascii?Q?+BzZ8VWa533Q1PujtUT/jImihA/9YIJ9G1kPTlq4+e/2Sc/G7ohVzxNF833a?=
 =?us-ascii?Q?aMoZucVYEvE9lLW7b1N33A9l7cqCeNUafex2w9fMP0skolErGmzjhvOr4+pw?=
 =?us-ascii?Q?2s2sP5CVZReCiX3dpnRHmD56X04ivNDqNOgBy5z1BOSF+83B7KjYtVKcBiZS?=
 =?us-ascii?Q?uDSlr5BRELmrDs7tvBDSznmh3ag9RxNF7yaj+A83igmBTzXY8JsK6PKU0/9s?=
 =?us-ascii?Q?4OMewbnlURCdCURz4iGUnroehBiiTw3xG/hK9rJ+DcXowkCncv0jxO239Mki?=
 =?us-ascii?Q?it96Laai3BErQ+7A5PzdfWa9xAQGNmILrH3zByrbMGCerL5ZzYBerfV3toOx?=
 =?us-ascii?Q?0sPVHABtltWnq9Dea8sJ028fh1wJMaF+xkSi+Ez5dC1AERlsRPUkNaaEYvee?=
 =?us-ascii?Q?9qb5druUQqE4oYiVCBArx0bR5ZD0cSwP22YdksLcKyfemRdbCbXBvrQ8P441?=
 =?us-ascii?Q?NkEqStwhj+eN156d7pWPnKUJE7jNUJ13ujS7jPOkwWDrWjU5lakkpUb1j54E?=
 =?us-ascii?Q?QtIRYqqMGSF5hh/2xi2yFSiYkGMGV7M/z0cyTUNfE7X+2RVR?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a0fb54-f26f-44af-090d-08deaf0b70a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 03:14:40.2206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pp5SHJxnPKBLLV8Zv2cR3ONquehysWiPIcUaUGDYVlprw0vbkc23XsUUtct1wUdYaSW2d5OEeG1ZiFkg5BWdKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB12203
X-Rspamd-Queue-Id: E52F4507876
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286430-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to
> consider:
> - [High] Incorrect FDB port bitmap update causes roaming unicast entries =
to be
> flooded to multiple ports.
> - [High] Local `u8` arrays `bcast` and `dmac_mask` are passed to
> `ether_addr_copy` without ensuring 16-bit alignment.
> - [Medium] The driver silently fails to delete dynamically learned FDB en=
tries.
> --
>=20
> commit 5ef406cd4ab0e5005f26e470e33265be68b4fe54
> Author: Wei Fang <wei.fang@nxp.com>
>=20
> net: dsa: netc: add FDB, STP, MTU, port setup and host flooding support
>=20
> Expand the NETC switch driver with foundational features including FDB
> management, STP, MTU configuration, and host flooding support. The driver
> operates in standalone port mode.
>=20
> diff --git a/drivers/net/dsa/netc/netc_main.c
> b/drivers/net/dsa/netc/netc_main.c
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c
> [ ... ]
> > @@ -363,6 +418,206 @@ static void netc_port_default_config(struct
> netc_port *np)
> [ ... ]
> > +static int netc_port_set_fdb_entry(struct netc_port *np,
> > +				   const unsigned char *addr, u16 vid)
> > +{
> [ ... ]
> > +	cfge =3D &entry->cfge;
> > +	/* If the entry already exists on the port, return 0 directly */
> > +	if (unlikely(cfge->port_bitmap & cpu_to_le32(BIT(port))))
> > +		goto unlock_fdbt;
> > +
> > +	/* If the entry already exists, but not on this port, we need to
> > +	 * update the port bitmap. In general, it should only be valid
> > +	 * for multicast or broadcast address.
> > +	 */
> > +	cfge->port_bitmap |=3D cpu_to_le32(BIT(port));
>=20
> Does this correctly handle roaming unicast MAC addresses?
>=20
> When a unicast MAC address roams from one port to another, or when a user
> replaces a static unicast FDB entry using bridge fdb replace, the bridge =
core
> requests adding the entry on the new port.
>=20
> Because this unconditionally ORs the port into the bitmap, the unicast ad=
dress
> becomes associated with both the old and new ports simultaneously. This w=
ill
> cause the switch hardware to duplicate and flood unicast frames to multip=
le
> ports.
>=20
> Should this check is_multicast_ether_addr() and replace the port_bitmap
> instead of ORing it for unicast addresses?

netc_port_set_fdb_entry() is an interface shared by single port mode and br=
idge
mode. Currently, since only single port mode is supported, it doesn't have =
any
impact, as this mode only allows setting FDB entries on CPU ports. However,=
 for
future support of bridge mode, this is indeed a potential issue, and I will=
 improve
this shared interface in the next version.

>=20
> > +	err =3D ntmp_fdbt_update_entry(&priv->ntmp, entry->entry_id, cfge);
> [ ... ]
> > +static int netc_port_del_fdb_entry(struct netc_port *np,
> > +				   const unsigned char *addr, u16 vid)
> > +{
> > +	struct netc_switch *priv =3D np->switch_priv;
> > +	struct ntmp_user *ntmp =3D &priv->ntmp;
> > +	struct netc_fdb_entry *entry;
> > +	struct fdbt_cfge_data *cfge;
> > +	int port =3D np->dp->index;
> > +	int err =3D 0;
> > +
> > +	mutex_lock(&priv->fdbt_lock);
> > +
> > +	entry =3D netc_lookup_fdb_entry(priv, addr, vid);
> > +	if (unlikely(!entry))
> > +		goto unlock_fdbt;
>=20
> Can this silently fail to delete dynamically learned FDB entries?
>=20
> The netc_lookup_fdb_entry() function searches priv->fdb_list, which only
> tracks static entries explicitly added by software.
>=20
> If the bridge core or user attempts to delete a hardware-learned dynamic =
MAC
> address, the lookup will return NULL. The function will then jump to
> unlock_fdbt and silently return 0 (success) without actually issuing a de=
lete
> command to the hardware FDB.

Currently, this patch set only supports single port mode, the MAC learning =
is
disabled, so there is no dynamically learned FDB entry. This interface will
be improved when the bridge mode support is added. So please ignore this
warning as we do not support bridge mode yet.

>=20
> > +
> > +	cfge =3D &entry->cfge;
> [ ... ]
> > +static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *pri=
v)
> > +{
> > +	const u8 bcast[ETH_ALEN] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>=20
> Are local byte arrays guaranteed to be 16-bit aligned?
>=20
> The ether_addr_equal() macro (used inside netc_lookup_fdb_entry which is
> subsequently called by netc_port_set_fdb_entry) expects its pointer argum=
ents
> to be 16-bit aligned.
>=20
> Because bcast is declared as a simple u8 array on the stack, the compiler
> only guarantees a 1-byte alignment by default. On architectures with stri=
ct
> alignment requirements, this could trigger an unaligned access exception.
>=20

The switch runs on ARM64 SoCs, CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
is always selected, so there is no need to align bcast to 16-bit. This is a=
 false
positive, please ignore it

> > +	struct dsa_port *dp, *cpu_dp =3D NULL;
> > +
> > +	dsa_switch_for_each_cpu_port(dp, priv->ds) {
> > +		cpu_dp =3D dp;
> > +		break;
> > +	}
> > +
> > +	if (!cpu_dp)
> > +		return -ENODEV;
> > +
> > +	/* If the user port acts as a standalone port, then its PVID is 0,
> > +	 * MLO is set to "disable MAC learning" and MFO is set to "discard
> > +	 * frames if no matching entry found in FDB table". Therefore, we
> > +	 * need to add a broadcast FDB entry on the CPU port so that the
> > +	 * broadcast frames received on the user port can be forwarded to
> > +	 * the CPU port.
> > +	 */
> > +	return netc_port_set_fdb_entry(NETC_PORT(priv->ds, cpu_dp->index),
> > +				       bcast, NETC_STANDALONE_PVID);
> > +}
> [ ... ]
> > +static int netc_port_add_host_flood_rule(struct netc_port *np,
> > +					 bool uc, bool mc)
> > +{
> > +	const u8 dmac_mask[ETH_ALEN] =3D {0x1, 0, 0, 0, 0, 0};
>=20
> This has the same alignment concern as the bcast array above.
>=20
> The ether_addr_copy() macro expects its pointer arguments to be 16-bit
> aligned. Passing a stack-allocated u8 array without explicit alignment co=
uld
> cause unaligned access faults on certain architectures.

Likewise.

--
pw-bot: cr

