Return-Path: <netdev+bounces-271442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDrnHS6Sw2ncrgQAu9opvQ
	(envelope-from <netdev+bounces-271442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:43:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A3320DE6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 236C13043412
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD71372EC5;
	Wed, 25 Mar 2026 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b+EkbOw4"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18338228A;
	Wed, 25 Mar 2026 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424513; cv=fail; b=sc+WeI29Uto5j6gJWxsSKuih2e/tmlCmSC+UPyZBlbPXMNLjBSrY4pjZ9isCMdwb0nOiZjiFeOIlaNLAkVShWr8C61k0HurIfY5NLp8ss1WT+i/zOvSVdicsBiNbIiegUcLBijoyCb00zA1UwxYFI1bsk0UIspEm5nsZ7T27hh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424513; c=relaxed/simple;
	bh=Sn+T40TsnrMEAJbwXf5EjAlc69kojhFGsHYzZavX/4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T0doFW5SNjbDEHFn2K5gLltZzLQwKS7rrHelrcMQm18EQUbFNVa0IDQQgsYcLYkE1aHjjE5iH7lhHRlnQb83UbTJucQiJ7tCvkUy45hMe7aJFsai22Rm5qJSmoeIL9zORCQDG4kwCslIxZjnw/AoMb6E6QOQGn0Z9eywc1MeG+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b+EkbOw4; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJP1s6b7YSmSoEqesIvjY4xKM3JEHWwEPLN5mi+dssi5/xlbOfCElbW/Y0AM66rLEAZxREjyN+o9zl0UXPtJ4CnmPhEQ4oB40/fofxJD4sT/mAOdyaMYymMvNwoZnrnj0nj99xlYRMxTodNWptMKM/w97EZCqdUpRzMPIvzo3wGHYK35Lddect75Dtl6zlrxnWZnVblOjt8/XStZCfYAAOOKCJ6e9whFZuSjCDP98ab2k9PaevHMkJI4Qy1qAyYWNjQy9gI6FEjRs/xsxj/ZU6LGLr+ERCT1xo0Lt+ZFdKSKauLdNAlqQEg4LDvDtDH9UQDOumUPrTEDI0/hkpofFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sn+T40TsnrMEAJbwXf5EjAlc69kojhFGsHYzZavX/4s=;
 b=oANAaPvAo6507V/qg3Bg+SW52x2OOPRfp2W4lzdVtGs1yXiHiJ/DjkyBr442z7gu0NlrWO8UfwQ6acG+UZ+F6vwcj84Limbw12MHVGJ/29Fw7BFY7HxDAjE9g+Sq2Cz5SmG+iyOVosTlCfnGSg59p2GzikEOfNApeFXBjXxkniTW17vo9y5JFF/lX7ZXe9SeoSRIG6KVnlS3wOP7SwPrQ3plaJ/LzOSKMB2PqPGr+/OAM++4iW0JaAMFEzFJ8pPcx2gr4SZeruzAvqtz7cFclz/qf3OQJCtyhKVRl0P4xUAnpZLVFt9tzaA8e+Zkwv+r17KnlTrlrjKG76c+iXrkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn+T40TsnrMEAJbwXf5EjAlc69kojhFGsHYzZavX/4s=;
 b=b+EkbOw4rOWFGDB0yK4OVySSiIuhTdd2AoiisBbXS8d897qPlUCV0V2cAicRWaXEeVYGZSHF9sIzOnuikPm4X4mP1b+HcNIigMZJfcFiWIeAsitxqSklU3uAAH81pPUbs3n67/A+m0HFKPP6e63Bn1OAuj39uF6tJhcufJEz/IE5a1bxs+QdEWkNoPgAww5j2tnfDN1LDyWu9uaY9NOMqspjxAI2x+YQb6zf77aid91kSW1Py7+32W2+cKjRoU/bOgSiolfUplEAZoxsxG8qjW6N8CC7LleEzxAHiCnHJSFcuJLDBFwjnPVI7UelhcP3GEF41JB4hoyRM5GyZQs9yA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10835.eurprd04.prod.outlook.com (2603:10a6:800:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:41:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 07:41:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Clark Wang <xiaoning.wang@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Alexandru Marginean <alexandru.marginean@nxp.com>
Subject: RE: [PATCH net 2/2] net: enetc: do not allow VF to configure the RSS
 key
Thread-Topic: [PATCH net 2/2] net: enetc: do not allow VF to configure the RSS
 key
Thread-Index: AQHcvCRPJFGBEXS510KFGQJo+l83ErW+1qwAgAAGhcA=
Date: Wed, 25 Mar 2026 07:41:44 +0000
Message-ID:
 <PAXPR04MB851034D601A30E3CD303CD9A8849A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260325065647.2882997-1-wei.fang@nxp.com>
 <20260325065647.2882997-3-wei.fang@nxp.com>
 <AM9PR04MB8382771E1FF250E566382691F349A@AM9PR04MB8382.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB8382771E1FF250E566382691F349A@AM9PR04MB8382.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10835:EE_
x-ms-office365-filtering-correlation-id: 4a3bea9b-9922-45dd-f73e-08de8a41f690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 GWO85Z5zOZo2+kcO+ySN4PXohn2aRrFM3FN9UqRFyfX19knk0vecfyjawDXFx4oZJ9XaQkEsVH5z/UI7SpiGsCkP7dbmTiymEclTYFmoiaVjaFdsfKiaf+lzM2t5VLGE+euFhC8MH9avBimo4fyNPwmNp6OLQnnDdX3FlsYxMSyG211h4se9dsT9QqzQxrMzlGSqt7IFXxRyeLeUf3T4w94QnHLzdatV6zlyYTpDUZ+AmoSOPg2IF/nOwO7/ajo6J7rUCay6yW7EgA0v9rSi1UnT6VLOw+RqBQE4DlwK+4B093i31qzr9q2mh5EmyLcp2hNb2WPL4WKAK6s2JuP+m3tR4oWO7TTLp7554ICaRsGN8D9QUCR91aI6k/wHDwQ9J/8+9oEBjuAraTDQv3c0W/UopM1nv3Jb1DfdS3vvkehmVLi0Ck+5DsIrT3TUgYXg576kNR35l07coZXVNjqMXd7UN+GYZYzv+zg4X3HJFuqWPLU3NkKzZKFufRH3vSc3iY3uWCOH4PY6xIvGZURVppwj24Utn0zoOOBu7x9KM+1bQ816z+npnEWxcR0gZvM/+sKSwkU+JPdzNilYOgPTKE/tv2z31jtTJU3E8bsFGXD6M9rQgJNp3BiZsqaN96sVshEY4QjcRcIKg6K/+H6zTJAnbsBUYASfHnGi6t8bLv1FleoRW9HjkDfrPsh6gEgUCX3tl35M6M509oaUJn/MZPNLGYzl/DZNq776rYS2W/O4JAyBazCBdRQgREFx8lpL11AqkzqfyUAwiNghXFrCqdrJF3IfChpbElnl9MpL7j8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6jYCyHxlp1YFho/ardisCJs+V5pRT+4KT96zS6IXmMk2mKAc1dyAk7vASCsQ?=
 =?us-ascii?Q?uqIV6o7gQH6Gse/FwzZUX03j3bagWCgsihI3tKxWaRZDAKIDKmc3NU1NwnE+?=
 =?us-ascii?Q?3iXkljZy8TpPQZaEhxrn9kHokxIYVsqtOIrurrhi1nsIY6C9S07EJ1XtQ1zM?=
 =?us-ascii?Q?ZxaUH7rFQxbbBQb6zdpUx3+/JmL01/foTQ3JduXNKGNWws9SPBukEgrOuiLt?=
 =?us-ascii?Q?++Q2HM2GIIjLRBP86MIfJTLq+9dVz0sQbJFKQaBqLK7MMZClf00NDOeCW1H9?=
 =?us-ascii?Q?HBmYOjx+AXvAq88lfrpPXVdCEW553helPnO/dJ79htHTzRs58Hw6t1THqWfN?=
 =?us-ascii?Q?uxbRr6Doy9ugzsOKze9D4cPKwOuigZJMeb0mqTGW2zIiZK/Ro6zzow37oCHs?=
 =?us-ascii?Q?dUiXdlfMcGs+luzkoiJwzJlFk7PPbctce9RKy3VrfZJWDvfZORhiwMMRWaNC?=
 =?us-ascii?Q?kSlHF6OxDPpuaOWYB5125zwtpCBIZCz3+aJggD2cXwT29cbPaWFD5vzJH1fh?=
 =?us-ascii?Q?INFFT84q9mrn/ydcO4nnl+y2eoSylRyBSbSK7cqeLTCrBvHsbTcc+L7KtQIB?=
 =?us-ascii?Q?6x0/jiRuDLU0LEChEetI7J3/EKVewjQoBYH8oG2Qb/x+aI599BwB9Toajxth?=
 =?us-ascii?Q?wT31JvlruZwTQCLhezs84Wqm/c2tl3tmAht0lo1ofoZUgH1ljY/xNswECcEs?=
 =?us-ascii?Q?wiBhRMHfBsaXyn+7T1RlGrxtNmT++OCNI3KuQipATee5n5Z6QgDocdvO5Sdg?=
 =?us-ascii?Q?sNW6oLe1V4c5JKBjQrlH7qAuB9NNvXyZr0hZsx59PmccxvgEACxzgbtOD3Gq?=
 =?us-ascii?Q?HYowJgu5J3ZEqpWc4UNCH+AOY8AXAf2cUTnNcjdNOnA27L+zFRVpIngKlmgt?=
 =?us-ascii?Q?rgNiYDvTsTiHcfbKTJVsCaLQR9SSAUi/H/tsY426yHo7UfChuvIchazfyu+z?=
 =?us-ascii?Q?EBPHVmK/Fzq0Rucm9ykPNwEgZOELwPrmGanLH+zroUVjxyNHdLlJOsPhURyJ?=
 =?us-ascii?Q?98WLsknm3YWRLPjSKEWmuadN9OwUyZLswrF9yjyhmEk5slBnf29tt3ifJ07l?=
 =?us-ascii?Q?ijKyjNyWhZTSUk06m08NAaAvVpmIyDtnD1C+PUSKDsdKZDBG+E9og+C9rb2+?=
 =?us-ascii?Q?x3g0ls5XLXnXvLPk4y57K5iZ1K/I0PzA/hqXKMIBZi0ee8TkurXn85E4SmFU?=
 =?us-ascii?Q?YPMI10kBhnB87TQnZf4NPFRiupG0IiuMtzO0CmsnY2vd627TXDR2mqJT7xhr?=
 =?us-ascii?Q?awsEuTb2L5ZjUa+azB9WN8IeJG9W5loDCuemdlHmrJnAdHrmvbQv/kQIDIDw?=
 =?us-ascii?Q?XOFQbQDPWyiBoQvFZYFDPzE6n5rIIznU27ysCtwNCC/IjMoQlgkPZv4oLBU5?=
 =?us-ascii?Q?+RTScDcxyh0fiXyzYfthADHQHqGluYlKM9gvOelQShlD+isR6XsxSKCwMImp?=
 =?us-ascii?Q?FMPEA0EOHOERj5FSsQvCSNewkcZ3njspfu/4Y0S7XQjLOdYFS95jR5FdeZoM?=
 =?us-ascii?Q?Y64+RVOpzTZGA+IBtPVefmRPaExHq50lUkio0ZxJP85E+hXZ5f4OVme8Q0TP?=
 =?us-ascii?Q?TzgcidhPcYXQUSw4JjB4gYwHxX67vGp+YAqS459yq7DzxlbYHvSSm8Pi4QyL?=
 =?us-ascii?Q?8Y98ZA45U/BaetmdKJKmXwcpMtzf81ppv3GXi5yExrsZRMpTdDWRzU4bzjXZ?=
 =?us-ascii?Q?bex7duB/O9b1EQ7tx7680N/FfcWSx4U7HmsNkikPLITEGUs7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3bea9b-9922-45dd-f73e-08de8a41f690
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 07:41:44.7176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ylbWJOBPBRTHCcAeCSutGhRS4fy3qExgIxsrO2MMs92rokNOHy1A8U0xGoavJi+3t57J4/EtmTw4JR17NkxPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10835
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271442-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 8B3A3320DE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > VFs do not have privilege to configure the RSS key because the
> > registers are owned by the PF. Currently, if a VF attempts to onfigure
> > the RSS key,
> Typo here: onfigure -> configure
>=20
> > enetc_set_rxfh() simply skips the configuration and does not generate
> > a warning, which may mislead users into thinking the feature is support=
ed.
> > To improve this situation, add a check to reject RSS key configuration
> > on VFs.
> >
> > Fixes: d382563f541b ("enetc: Add RFS and RSS support")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
>=20
> With the typo fixed, Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>

Thanks for catching this.


