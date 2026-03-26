Return-Path: <netdev+bounces-271976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOheHFwOxWkI6AQAu9opvQ
	(envelope-from <netdev+bounces-271976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:45:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C17333B0E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC263012261
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B55F3CCFA4;
	Thu, 26 Mar 2026 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RR10BMLL"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6013CB2EA;
	Thu, 26 Mar 2026 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521162; cv=fail; b=fOis1MnmpQ4soqBBjitDG1fbCmzDSofBDSth2zjixX8N4IPTeEq5WCa+Q9B+D/QPxuiVf3ql/BqW92nZEhKd8QNH8fWsLvLIO74GoYcb4i1I7nUmz5OxXsBXjFJUkUSEZUzxdD3CkUUuMcXzIWQIoQnQVWKkdGceIWcFCAenqvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521162; c=relaxed/simple;
	bh=mZqvmHYeZDe1agFBr73V/hF4Xxs6AEf+L7g+RyZvQAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cRQ/04Qk07szjMNSD/vTFSwXD0rh3QbPQBX8ji2WzHAtEL6kP3+PDb7vfcGXlVeAJCqXWTNczhBzQWMsqPp6jzxiWfst5U7DILUuIyTbfbahZmNr9RehZg9dJPekbIKinEYkeOLMO5nqb+20QVLEpB2c9bV1XBLXopBm7zj33oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RR10BMLL; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXDlMSVJ/5FFAN05W09AlsTBYUrCCAdrOS+BfG8kse6vpMy6153luexpoNWJpqfjHJG/PQbHlB+EKVTWVfdXJMmEP62vRiG8h4R2rRAIp71b3Up8BksF185CzRimJshoJ5jeNCJOKQYZ5deCW7Gx7e0krzoXB/ASkwD6Drw5j8SNpjPsFcN5S+VxxSXgLhx42QKrnO35BfUroZ6mRIsJQt0w7KvRkPlrLXBp8BZFLoy/sJ5o2vbiaSOWRGk/jheEfkUC0SeXqzRNMQPSsW5vWjWC0Dg/mALISrc1VG6a+QiGP3VWxADqHkVftjvUPETT1Ai1W825IOf3fIaBSSciZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZqvmHYeZDe1agFBr73V/hF4Xxs6AEf+L7g+RyZvQAU=;
 b=XwFotIjyJ5GYSnr01ZYXnqQMZV8Rko1COjKYTjNDO8g91BgUl0SiCkn6UTuk0HZUhxE3BvhXKU6NOfEl/qzQ7gV28HRHo0Ir/Wp6pCgdf+eevUPWievM374o10YelG3309JWdMIVeWAEXEckwYfk/rv/R9XP2t8lPXezq6oCnJCf4wRqBvdolHxfdK1jpRnCoxnKTCOBvlVKODW2F+fjDQnpCnmF9T3KgrNBFKIpDQtHSN60WE+nAqkvxivKK3PKht93j+VduL324Ursa67JWMa2K3l0QjViETFcY7z92t48XJ9nrqshU7RQaB6yiG8s0VzmIIGv79aYApNOp3ahwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZqvmHYeZDe1agFBr73V/hF4Xxs6AEf+L7g+RyZvQAU=;
 b=RR10BMLLr5uUsJNqw8JUhHwV8Hj3T0NB0fnsEhP3FbvH6jkpMyHxseo3FXZQNbo/Xw2gLCR0orUBtI8vUL1VpNR8mPelgVvqWrA+zRRDug2sUk66SV5mhY79HxV0aCM/UJw4c7XY3SVC/TngZHQjCx6iB10jSvS8UgogzODKat/VvrCtpMcbRPLCOR6mMatIPbPAxiAidNAY0SORq1DBvXuYJdmQ6aVNIuopux5lmvq4G5ERYyicFgghggc9seel11SJ9pe437zOesOwYnVCVlnbJfvhnw96aW4d4SQ+wIg+tHojCuSkFA8xt0wDs1AHxP15p4Cl/cG22+UfMaxkmg==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by PA1PR04MB10225.eurprd04.prod.outlook.com
 (2603:10a6:102:467::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 10:32:34 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%6]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 10:32:34 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Alexandru
 Marginean <alexandru.marginean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net 1/2] net: enetc: check whether the RSS algorithm is
 Toeplitz
Thread-Topic: [PATCH v2 net 1/2] net: enetc: check whether the RSS algorithm
 is Toeplitz
Thread-Index: AQHcvPU7BI89EWoxe02/UI2EE0LXcrXAnT0g
Date: Thu, 26 Mar 2026 10:32:33 +0000
Message-ID:
 <GV2PR04MB1174093B7F9CC71660BA9D7549656A@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20260326075233.3628047-1-wei.fang@nxp.com>
 <20260326075233.3628047-2-wei.fang@nxp.com>
In-Reply-To: <20260326075233.3628047-2-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|PA1PR04MB10225:EE_
x-ms-office365-filtering-correlation-id: bfc2f0e2-9d9a-4fd7-cedd-08de8b22fe01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 m8ASr/FR0AGkr6Uq11zUJ0YXpHE8W4RxlyR8miPARK6AERfO1XfSLOSwx/Ul/Is3defJoXHXge+TmFM39VobcbjaHC0lIpLnhqn8enLkoTG3LIisy1VSisuvlae46forbcXEKJv/A3UjYVSOLSGn++ngA1FGIYUjNOVYzT8rNpuuLg8/+LsN5uLcEQYD+JjkhOoOVTMNI5nlFQnGGy5i2EzSGZtvcg1R3DbEC1027gOSDSY8w+7I/w1IMOn6m0w1BhgJX+uIuBjfY5GdV+bhzPeVvv5BJt+vO2bI4pgvo6jK/rS4P2jD4upsd4KNrmjYKIZqS/99wrLvD5411Fz2wnkjleh4xpEhI0ciQONXqydvAF9xuGMqFp3F5UAMBQPxEy67lHG0/tSMzL+hgCiQctqAzPFBcxREvygszmyKG3DOemBGDQnqDo5EaETjDYin/oslb8b3a/4ufsd+SZsGLDinPEei/SbSV+X+EUERmrOhcbQ4l+2+lALe1QTulkuclVOKL+KMuJZ7EX41NuJt16kVYUwrchgxy8/IeYMBci8btyhXTJUvXWIhJzvhyMKLJKUopMQrA8vAMcessqgvtLHHDImcCYSWvHiIpgTBeVwGnQ8TfROVhbaiVzdgno4cl6a/i4wi1CkdCnQiqTX7kFRMvaGsZZO4vZgAQjqXPxp7ZvFdcBeZEn8Tw0jj31rcjN9FPd3WTLhGOZlAqe7wfxlsBilczb2xShZ+luZHj7p8mdoEn4ueJ41g5VS02TbKY4g+QDGQOkEGap0+TTUT0ZyV95EPTf5er0YS0zCNut0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4ElSxJfH+ak4lN2Pvi4KrAcsIqohxLKR8/vNONHn/uiunS6xaPD8pUgubxD9?=
 =?us-ascii?Q?d+66TAgioC/WKBUahWYdL4CzDxt+nr0yJLLei33ec9TmKJB93N18GasXyACI?=
 =?us-ascii?Q?llK2Ne5fp07AeP8VPrCjKWyEmjqrpok5Bh17HVx/LHWGqMe48nyWXMNWtKCD?=
 =?us-ascii?Q?AmGKxFRqjkv7bHt5l1ECuYqHdF96vGCkUa3ntkYai9Y+wqoJ8vK0ekhaoSuf?=
 =?us-ascii?Q?SNqE62my1Lu/nUlp4lck/UrpEHuXenieUbrjN/mabX7GYK6xZFW/SuneggjP?=
 =?us-ascii?Q?V8nmFbRoedvCYTQCDhpsyPGGT3XyQoqns+2oMTAW8v+k69I3dbhO5FoQvPnN?=
 =?us-ascii?Q?Hn6d0LyXswFbVbdEtwnGnRKXAAGS5HRF2C6Ql66vA/Ph/mDHAKzbo+RgFdlt?=
 =?us-ascii?Q?IaLOt3GPihZh01/7+QKlR6/IIpVeJUYkBpQ9eg/WpPJmNH/HBnso8r7NGu1w?=
 =?us-ascii?Q?M7pgLUFomC3vyjTTJVQrggepaBVHn/A5yXsoyTRbrr61HVsybALHIteZrmnm?=
 =?us-ascii?Q?fi9IIGE3f1ay45ooIWMe7kfQL/exr6bVDH9mWirX67v6w5SxtFwH7srQ8E9i?=
 =?us-ascii?Q?EdjFDexfmFFTBS9969S2NgiXbM3LM+xVVgtG/ZtBu1/tC83UyzSwfEQL9+q1?=
 =?us-ascii?Q?v5Uf4v0TSczhqQlxvAr53kz8l9ykQeeeyXup/DhhbSp76SHAAjFi2wZKBOPT?=
 =?us-ascii?Q?AdiB2kF0M9JrsObBCeqPfrxBsQ+/vaRV82VQfu0L2BF2dtD4WwwVdexRj9ZG?=
 =?us-ascii?Q?CQQuqzezQX9mZsxBjzAQSlkEdHyqpERbV3zQQ20h9gaJgAAv10ZLVRZNBTiX?=
 =?us-ascii?Q?mbNEOUuixHI7RHNst2gYeYYVzn30dUMKNuaFtkape1rYVFr62bGPfkBnLar4?=
 =?us-ascii?Q?PAAYyYMDAWjXC3BAFQxiK0RjMCXbYmSeYMj9iibcg+6Q5xmnFUq7itnFJzuB?=
 =?us-ascii?Q?hzRWeirUMauLN9EX16DsiClAUWFqNipMGZoyzpS6RU0K2BPTEMoY14hdrKCM?=
 =?us-ascii?Q?rrp6slNM5nu/MNyIdBcNOByoXKBwTyBqMWCq6wLeb3OZL8swyWrwwfoFUy/n?=
 =?us-ascii?Q?E/pF4chljohISfeTO63hOmBc4p4WvF4WCHmV1Xy+aAcZXHoh/Uaxt8Kv85hE?=
 =?us-ascii?Q?5eQYt41ntpGgQx+NDUB27IankwjaXtr4Yaasu7o5/dqeWo7Gn8Tu1io5hQ8O?=
 =?us-ascii?Q?K9hJbqh7sbcd7y4dme/+KWb5aaq5OTHTI4YIzLcQK7vmIqkZ0ICjfB1QQy3J?=
 =?us-ascii?Q?yBRPD6exC5tDbI7UVUuEU/KHlyX81Gy8sBgzgZr48IaGjvg6KxsMs823fUsY?=
 =?us-ascii?Q?DP8BBnxGT1CUm2v7T7EBYes26I9v4m20wl3LhUctVJqnsz/cTFAZUwQH5HYK?=
 =?us-ascii?Q?1mJ1C1PxuwjXRFHI4Z/UuMcFmyeem++ICqFGN248t8C32GE8yiGaEpFQaH3o?=
 =?us-ascii?Q?SoePELWfuilDuPDbGJ0cmlFzx/ssX2yT0fr/TgQ1YMsKz9aHfgmLiwlSJcnI?=
 =?us-ascii?Q?DGQ9GOCilUFwjKJpuEXXX5kymwZWj+8DTmt07EmSpRdfpaKDrIJdU7uaCpLl?=
 =?us-ascii?Q?Zo5koAFXYUXPssgWeY7bIhcutNErylhC//Z+/fGpDjyd0a42xA1e29pkjmJe?=
 =?us-ascii?Q?LVLKSJz18Q5qR+umF/lBtItxPCvrMdl48bRYMvF1ZL7de0oCO4Rfvw4nVaYe?=
 =?us-ascii?Q?djqbOzFTZ66a5AU6zRafG/SOng620Q/e9+arzoOOw0Qy2SPUYIrzpP6KHtwg?=
 =?us-ascii?Q?3XTkv/Ul9g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc2f0e2-9d9a-4fd7-cedd-08de8b22fe01
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 10:32:33.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fIRSiDch1ERePBdVsEq4MakFaCkonr1YQfxIqi8835hpCyrxk7wb89J0obIxrxaE9DeMg4Dk7w73E34BApREA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10225
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271976-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,GV2PR04MB11740.eurprd04.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0C17333B0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Thursday, March 26, 2026 9:53 AM
[...]
> Subject: [PATCH v2 net 1/2] net: enetc: check whether the RSS algorithm i=
s
> Toeplitz
>=20
> Both ENETC v1 and v4 only provide Toeplitz RSS support. This patch adds
> a validation check to reject attempts to configure other RSS algorithms,
> avoiding misleading configuration options for users.
>=20
> Fixes: d382563f541b ("enetc: Add RFS and RSS support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

