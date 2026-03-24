Return-Path: <netdev+bounces-270853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBbdLdD4wWlSYgQAu9opvQ
	(envelope-from <netdev+bounces-270853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:37:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 336373013C4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0787D300DD5A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F2386C14;
	Tue, 24 Mar 2026 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AFKU1EYR"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A3946A;
	Tue, 24 Mar 2026 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774319821; cv=fail; b=jwCrkvrPY+yawVoIEp7wWXGacTUW9s0ke6Dk4on7Mrwklye4UijQ03dUc3N+m9M/xozbeZkjv7DwxrRq249XZUd0snlf6T5/+coT37BzlIusWCH+yEiUCdt+UKOpDMYzYXmtI+smZK7Tr0MVBnxwNQdWBV5OiDaF1fs+uD3ksSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774319821; c=relaxed/simple;
	bh=Hqjj+yQsrFiPGIQFNgQP3Wu4hBKRmj1v7AGTMMg7v3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4fM/etsGUdjIkCyw15VVtU7fdfyzDtyxmaO6wI58BkY1oqEY/h0ck0HmUgMUzIUynEx0PnDLhpmfO2YpyIUx3O4dVh4bi2lvIFNKnjpEMlyv3/xdNmqAz1fMn8HxN468fE/IRtTjZ5Ex6K908jvHfqjmRWH0vkifexeZejwFhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AFKU1EYR; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2z6dAqhrsAXKca1sYruYIFyjx5CZSXUdcXEZOFCJqYY9hQs52meoI3TV971fJjCUtVwAbkBaDe/i2ob03e51LQVLzpBNN6Fg9BeAfp95o8TiTQx1xPVStx3xPPo/q7k6Vexq7uVfH8ZaRufEf0SOqSs9b9V4v5w0B3PwTbPDF9jOy7t3gXSs5bMRcbMcZ1NAwupKGJvYpSrcjOh0e1AmXjnSwC64pW0pedv8QNlx9DapKfVHtFRAqo/gE+AtJfOzmJn1gseAXqFamsmBimcpG4Fj2rZHygY1hsDPvoJTkpenThzBQKUmQxJn78lt9FDLlBBvWeMAWwTynf7Q3s7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGUMF5bFIjGpGtuNPT1ctAifA5HJMrPGEYLflEYc0yE=;
 b=tBeyN/OCUjN9PlrqjIUvYZaE7RGMxkN3SYmTUhjR7Fg6+b2AOJiLX6QWscQIGaJ2aftVTPOtsHbMfSj+hZ1KLbUNE7r1v9MzXy03p6mvCJpvWZxZ4KBpGylf1tTd2viIfseY9k+33vq5ELTf62ojE/7ZBSlmYtaDA2aQAYuBhD60UDyZXGDw3X3wU5h18UbHQT8ZsJ4xvuXdpqYbH3Y7YMdi6QN+iZRaUMqkkYFDr50kZfS7mJDVtvNFO+bQ5Or0C3cTu1wANxbpbYM85mVaor2hJ2AFt3/dpr1wLQk2H0ultrmA61whaUhHgzbHHGloaze5r1iyQfcqbKh1D8Z6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGUMF5bFIjGpGtuNPT1ctAifA5HJMrPGEYLflEYc0yE=;
 b=AFKU1EYRVCiS5fwjdXEWqdX4I/sULfcmrupI5ybm8i+OeIdJxKEA1vrlICLADm1nTdB6/y05Nnx5vi+hQFSn606yFo714QCjYJbAZ0r6EMACWO5kVElBb9OZ7oKvBgMBpUiHzom4l0gcwEeikSX9oC4khHPzIXmOGSX1XH3BUEtTYGMLU9hP5L++w5TUT5UsxuzZ4TGaI/9xcSzmcBUVu1uz4kLj15QNz/cK5OlOWTWrfx+YaHxu3zpKe++6k7zloZoGWXUDf0GlrET016E3AXDkJxbXXQ3viNs9M2tLpwcJ2VB7QRTga7YKc4Pz1gkBqvC/XsOJrJ0xIDCplpr/3g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB11002.eurprd04.prod.outlook.com (2603:10a6:800:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 02:36:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 02:36:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>
CC: Buday Csaba <buday.csaba@prolan.hu>, Frank Li <frank.li@nxp.com>, Shenwei
 Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?Bence_Cs=F3k=E1s?=
	<bence98@sch.bme.hu>, Francesco Dolcini <francesco.dolcini@toradex.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Topic: [PATCH net v2 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Thread-Index: AQHct7lhfXWJmdf5eEKPBwB60hlOFrW8GKlQgADCOQCAABuQgA==
Date: Tue, 24 Mar 2026 02:36:55 +0000
Message-ID:
 <PAXPR04MB85106975EB34F6B1652953FC8848A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References:
 <7012fbf90b844083d5fa7d764ed6372fe0288157.1773928309.git.buday.csaba@prolan.hu>
	<PAXPR04MB8510889775D757361CEAFA39884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20260323172842.7a62979d@kernel.org>
In-Reply-To: <20260323172842.7a62979d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB11002:EE_
x-ms-office365-filtering-correlation-id: 49e285b5-fbcb-4ccf-1613-08de894e36e0
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|7416014|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 CebrJkalPmCzRqZ0s25RyK9C+W0MHQT6wYEYAi4AA3qdRxUNPqaB/OEHevEPC5pl79JWntju6Ej9hg3icvX5erpkLOSoS59MdQmw+ET8WMf8gsil1CV4n9JHi7gjvc2ks2r6pMM7A8yT6DWVxTVYAdFrlCUM/IJmm/peTebgjlXUmSRePss1GKMtw7lO+om2hCXlH6oar+D9QbgBzZ3PINvCqBNnCFrQbIenqvYO/IrxrPrM8OBnxnF7RlyDOqjSX3R9pNNACMIsjNMKGpkOxL6yPRkBquwUZ0ilUBgrv5C9YdnMOC1raa440kV0a8r+sfroL3vd5Syf6pNtzo94BCa4Dncns+lwOoMfYmvuBUqdkF1H2juGfycf5UstJNNd2jX/SZEaDm4jHnGZX4pWOt1C7yIpTSlFBugz0eDJ5Zs+bi21IfdZBdhFioBUkmkjDbN1m3kW5cNjQ6BT+okQXNoah2Ol1RpqId5WL1Zn3DrtF08E/rvyzc0svDrG1Mp6vVCdCe3KRWfI6GUxdOMBUrVM0yPVkdm45JxWKxmvJej4NXWKIAeqs8kw9OseqccRBVgYmE4WMMrsVFjaQFge428F10oky8N6rsyCj3L1A691O6S/Z4FDL/8Rn9L4NDNyr010bQKOovlQYw1en7YQg1M08hWxAY9BTrEd2m6iCoNT/GSzLOhUMMbR83WSKYExK8MOG0ulP87Agx+4+HYyKBAJYx88RN124xXdEhTBLmX3CK5d0pzN8gV/7PE3DHbGT1nwoVp/0Ms4xozPw+1VdMf0fzLHhQXWIucE5r9nrmw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?c1jC7huNRJc3cECmk6Tc36abNBtE4wCL/aVPUYJqLj77tpkVRvO+3PtIQW?=
 =?iso-8859-1?Q?nui9Z7WxXT8yF+CSsTt0rMg0agqy8wTvFAd8cCYZItEuv051MS7tHVLdDR?=
 =?iso-8859-1?Q?2CGKZgipbAyhxPrz/QVWlT/DZnODkggcq0bDvtkwkbQfJii3Bb0SyHnfFr?=
 =?iso-8859-1?Q?lykItRoSjslAh15FRTXvDJuE6TDDu759jfEmfvRsVPJBfs3dfasj+D9ukd?=
 =?iso-8859-1?Q?m9x1VI9eA/L3ASTlIZb6bF7IX0O4TtsSyRuuBfKe6OFLz/dlRxEF8IgoZD?=
 =?iso-8859-1?Q?nstvhXK7rlzKC99L6Y7qAaLxQHkYO/KIPbE1q3AVHySTZPTR5z1TsyrOge?=
 =?iso-8859-1?Q?0ddNWZUdKNW5ykNHLxIqEx2AyzO1H4v6VAEPngvKGk2OIIODZ6WDhEtaCO?=
 =?iso-8859-1?Q?sySSYp9SbxtXVct8HYTF6OqKd+K2JUvMtIauj9VNZ3DiCbFac2vp2FaE99?=
 =?iso-8859-1?Q?lXV5Ey9zIpu5wSdq4QE5m1XG5592a+J+6/8t69CuJce8KOhWgelBeik2Wf?=
 =?iso-8859-1?Q?h9Rbppkowc7+kILS7ASDqOjaHX/qT4KlB9uKyQ610FgSPLbwh/S3s4Qu93?=
 =?iso-8859-1?Q?bRVEuNFzfFuNzUDbyNv2Ku0BOGvrVeMAJE9KQk4CnsOgnFTes+ttIiRNth?=
 =?iso-8859-1?Q?0rM5mwecnN7zN19pQfa172oYpjfGLCi6CsIiNTHPXl6i6rCor//8Cs/Lks?=
 =?iso-8859-1?Q?CMMDAfO9a2sJwcVmCBvDLf5kSM/NhGXllt/MCp73Qcq8H6dTOXqr45JKHr?=
 =?iso-8859-1?Q?EzcznbbIvPWxfpFD1AB7NQ0F+BL3uhWsGBNdEtp3TmprWfQEzc1ZLSH1vG?=
 =?iso-8859-1?Q?7jYxRoQWOEe+HeMSjCiPlEX8dWlfzX57xwdUIMhLOCs6FXd4rgXgiYDk1I?=
 =?iso-8859-1?Q?OFbTOd5QtvXlYH37tiP5SFMCxeW02rcBylj0qmCf+GgmiNMjVjHRa7xwXs?=
 =?iso-8859-1?Q?FbRwO4ZeFscvM1LnheMIGfdvNz/x4GeCoSe1A6y2hebDfDzw6I0Do3ucaM?=
 =?iso-8859-1?Q?It0gqnUNxD7ArYZBVByTVbvxMbqhGZyil/RLz6c3PE11vCsrhxRa46arNU?=
 =?iso-8859-1?Q?t9a5JKejebz19fYi5y7aZXObLPo1A+8OpAKnWXuVl2Dh8MdUaCO2qACi2T?=
 =?iso-8859-1?Q?bsnSVRkCsIvDjK1mr2WCBDBrd0yhr2pet38NqbpCiwjoIBjnC2PsUOW7iw?=
 =?iso-8859-1?Q?qrKAOMsdg2VhU2BoYdp3Aa2IZdKz7EaMBnEO0wMWtH999jCqFK/u46e3Bb?=
 =?iso-8859-1?Q?n/wt7H/8O8X/FoTfmZT3nnhuQmkqnl2UQBt42BUcM8cnZfcwKY2AFFvAE0?=
 =?iso-8859-1?Q?HTn4ihkFwsWF1QoL6f9lKN4q5abkoYTQzs6s8sW/7awSMbX0uExCPCK08b?=
 =?iso-8859-1?Q?ySpJvxdHZb/1rzuCKWVm396X3Sz9RWbVMK3ptN9rcQj6XbeQrviRqfod7E?=
 =?iso-8859-1?Q?ds3kbWMUAGIuAeWjBylxyCfDO8CiTjmx6AS/h/8NMaD8seRivhFRYoex7U?=
 =?iso-8859-1?Q?t38sP+YL8LP5k9Pgx+NTv/FH1+7Ts5IDu+lJRJ+2WSMOAWVAjnvoogSTQi?=
 =?iso-8859-1?Q?+7Hai14jJVPZujYonjZ6XplzyadNFxeKVECligCLivgrgqCMIecbGa+6Em?=
 =?iso-8859-1?Q?L7ETRw9kGNLowb/u6YNMiUN6O3vhBW6OKP6176q6clE3ZB4kdtmNzj5+O4?=
 =?iso-8859-1?Q?P5YYEOxKLVCe2Z3pE7ptTvnWWhS3GMDcCVD6cqsTtTnMUuw+GmI1J055Jq?=
 =?iso-8859-1?Q?fXEEhC+oJERxYlZAsDEKLLkmymb/shXNB9OZ9zhA1w8aNR?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e285b5-fbcb-4ccf-1613-08de894e36e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 02:36:55.4078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tqu3+lxMDjwAhPfpvS9mo+3H+hY8XbnSVX6iTgmAZILQvZ3Pg83+9371N7Kc7iaQJdSGsz1KoMHb1lUtyzOk6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11002
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270853-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 336373013C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > > When the PPS channel configuration was implemented, the number of
> > > supported periodic outputs (`n_per_out`) was left at 1.
> > >
> > > This prohibits using channels 1..3 from the sysfs interface, since
> > > period_store() rejects channel numbers greater than `n_per_out`.
> > >
> > > Fix by increasing `n_per_out` to the number of channels supported
> > > by the hardware.
> > >
> > > Fixes: 566c2d83887f ("net: fec: make PPS channel configurable")
> > > Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> > > ---
> > >  drivers/net/ethernet/freescale/fec_ptp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
> > > b/drivers/net/ethernet/freescale/fec_ptp.c
> > > index 4b7bad9a485d..1a7aa280e7f6 100644
> > > --- a/drivers/net/ethernet/freescale/fec_ptp.c
> > > +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> > > @@ -756,7 +756,7 @@ void fec_ptp_init(struct platform_device *pdev, i=
nt
> > > irq_idx)
> > >  	fep->ptp_caps.max_adj =3D 250000000;
> > >  	fep->ptp_caps.n_alarm =3D 0;
> > >  	fep->ptp_caps.n_ext_ts =3D 0;
> > > -	fep->ptp_caps.n_per_out =3D 1;
> > > +	fep->ptp_caps.n_per_out =3D 4;
> > >  	fep->ptp_caps.n_pins =3D 0;
> > >  	fep->ptp_caps.pps =3D 1;
> > >  	fep->ptp_caps.adjfine =3D fec_ptp_adjfine;
> > >
> > Reviewed-by: Wei Fang <wei.fang@nxp.com>
>=20
> I don't understand why you think that we should be exposing 4 channels
> to the user when they can only use one. And have the user guess which
> one should be programmed. Please explain (and Buday will have to update
> the commit message), to me v1 looked like a much better fix.

As I explained in v1, I think the "channel index" parameter of
"/sys/class/ptp/ptp<N>/period" refers to the hardware channel number,
rather than the software mapping to the hardware channel. Although the
current driver only supports one channel for output, the channel index
should specify the correct hardware channel instead of a fixed 0. Perhaps
Richard could share his thoughts on the channel index parameter.

> --
> pw-bot: cr

