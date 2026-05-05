Return-Path: <netdev+bounces-284253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLctIPKn+Wnk+gIAu9opvQ
	(envelope-from <netdev+bounces-284253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:18:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95F74C8907
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3454F304A796
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1881D3E9580;
	Tue,  5 May 2026 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="xagdohmH"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6052EBDFA
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968966; cv=fail; b=gOI/r2IMeFgnWZqp1AUnOiUYpGwMBPD0ZQdlLGlZ9VgN7KNvW3uUY5fGdJrV6NhB8eUnGWOZrLlxM9SvDADhcDE833l4mcMTl32ESfobJ0VVSCD8C8puxggm+tB9f0IWDMNmODcv5HW9utFbQGUWS77LblPF+N/dCC926sGHCpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968966; c=relaxed/simple;
	bh=caILCdjm0Bxll1uS0sKNDfEoacskbp2l+MaKEA8+C7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fz8jMDPtZdy9T8t0qjHCZ9z9+zKpAL8RRyZJAzUCbn3oZRf/kKgzxmsskoHprzLE4bXyn4QjLXxwk4ppd0p8nK3gOL25VldQ3uysO2JvedeaPDoxVyvOD86IbLg89467bPd4W7734Q+5gl4E8IaaTAroPxaC2XHEe9A1WOWif3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (2048-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=xagdohmH; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRF4cN5B2jrfRMuDBSgyjeVM6N9/ADIolB1i21Piy8NaGzM8SEglzqyzy67EuzZxJ7hAmfviyxVY3sm6jNOX9qaw6FZZ9dFpfJxLUnB7TUBy6zii6OqRNKVVJukXBVtcflIu2a/CGKgUnJBgpCEuFiz7mPBsgwLhOWwPEqIYG5InaadT5ewaQSuuT1sVLTBl/NbIK3I+0Dc+woxNWIQtSQtWPqZhUJ3Jk/GHHNa04qP1SCSeFOMsuJk76HEIb6o1Mi5zxgegWxQFhrdaX3DViWaLlCH+UfQUcICCm6hHgXQqncYrixNQHW5l48tvWviX9KJzmfKMhdq26OzgafZ0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caILCdjm0Bxll1uS0sKNDfEoacskbp2l+MaKEA8+C7s=;
 b=Y0M8WMUcsL38iRioTIASTRV8lVK6VEgjCG+ffMvj/8aEo3J1rn6jgaGBzexK8u9CYMH01hnKTqnIcYBWqjGWBZuWLEkmR8wg2qYCf02W/fB4lgBhLEsENpQU14blYfsTuylbXyD4KrhWkLydXyPElDyCfjE38C2jLFF1w9+B4pIkfF+qjGzlnK+Dkl6UcD1Q5HsLtS3DvpU4IKI5+g/8BW4xK4jJTkvjZTBZqEbtfNKRT5kbKcU0+cFGwCiCYHRYDZKfnqwLmdF/EyysWwkY4Uw/dHZ2CemjGnYCYUsnvJXKazz4SLftRk+KW1cOp6O7wBawxuduXKYJbn1oyJdYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caILCdjm0Bxll1uS0sKNDfEoacskbp2l+MaKEA8+C7s=;
 b=xagdohmH5YfMADfsG1/1hZXDih7oRE+UqEbjM8bHpstblrhhW/uuxpJCbRvoWjDzEymuOtcKQW9gh/3fH/OZFxPQit8GLSRUS4uJLK5qIyPWOaKXOIyN1MW8pSN+bkmWYaIveBnigCo/ap5BkOvvGJqpxYTnZinwsHsi7A+phEhUGbR9DZ6zzHvyur2XoSnAUWab1w4kwVlo7EekQqEbeIBg735KQNHC0TgCBGgm9zv5f7rKekcqpMfmI8XyyT8XYKaVGstgD4/HfKunQE1XDCjBDo0h/5oZVgv5E2d0Bjgy8yKz3uKCK3rhv4l0lXRgC3yh+bNM/AqcdAkEyJUGFg==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by AM8PR06MB7361.eurprd06.prod.outlook.com (2603:10a6:20b:367::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:16:01 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:16:01 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "qiang.zhao@nxp.com"
	<qiang.zhao@nxp.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net] net: wan: fsl_ucc_hdlc: fix indentation error
Thread-Topic: [PATCH net] net: wan: fsl_ucc_hdlc: fix indentation error
Thread-Index: AQHc2+AnnnHDjTzD90SlpmLNv8O+drX+6QyAgAAtqdA=
Date: Tue, 5 May 2026 08:16:01 +0000
Message-ID:
 <AM0PR06MB103966A8283FD757F6C9459A0F73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504160734.2217382-1-holger.brunck@hitachienergy.com>
 <e3abfd12-6537-42b1-b35e-c79a06f87172@kernel.org>
In-Reply-To: <e3abfd12-6537-42b1-b35e-c79a06f87172@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|AM8PR06MB7361:EE_
x-ms-office365-filtering-correlation-id: 1eb7bfb6-0578-49a0-06db-08deaa7e8b96
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 vosymZIP2IT2ccuwONWLVtpjkXfydO1ZTNK3MWw4dIsOnnmnl3eVudubjDuFK8+8MUCNwZhMD3xD6Bd5nTBm2J/7Da/jPg3SZ6FV7euXqvStl6uLGITazKcdGVrTSVIFKZuA+lIneK+DN46BmQKDZsGbkiZcvxv2Y/wzV/49WCoHgw8KC53ijLUApuKs0IkNpmLvwhIRx9m7ledA9bbfToT/fXwqQoxjdhkfTBqUfuAp1FzcY0A5T32nqs3RmTgeSFTA6jMtPb6ZDoXFYHWGK0wnRmgUmgysOUz+VW6QGa9TG7Rqnno4jrmmpABr498NI57csStMKWRg/o9FyrqiCt3AoOkZNh3yMp8toY+a9aFVc2Lb4OjRQovdbew6A8NK8qdEOT8+U4On2XOW1nxVBxDCO+jiWJGv0trRIA3RiDgUhbhTkx52+7GARi0yEETSLz8uud4KI/wdfmnbwN+XqKodDgngbKOPNfbh07h2MyRSxQ462I4opRlN1axay1fY+WU+1qia9HOxokCx/4FFAp7MKPo+ZrGkL54cBRBSZyrVqTeC1AD7dX6esf2WmKdhiv/Wup9vqmGPr/NYmXI9YyriH48V05VPruv+Pne9tuPlQXcqwlxfQCs9AOCQYzzVlwUiTAu/Fg9xacjoCrnhA0ez3/NFZITm+xkD4ZaRMch2g1il2vH95d2Cu41ta5fTHkg9ZRUwZp66EPKRSqUhECUqCNftEODT5HXIGLrS6JRtrzJTzfFS677eDXfjW6io
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yh/YYY+iZj9QgWCF30ovs79n0ii4lgpxA+NsMjIQmf144RpYAJCXly01xn?=
 =?iso-8859-1?Q?TvTEXvSQ5yZa0KV4LfLPpbCVODZvJyspVjyVyUFp78gsd1uj2+BR6MTeoE?=
 =?iso-8859-1?Q?dEpOpVesCs+R5Gk15k3Oo/LhzsDHpHUKIjGhC1THlwUUVu1tJYVApWL0j8?=
 =?iso-8859-1?Q?TcQLXJaohGonaBInlL4WvCmEVvhqVPWPm1u4oMUE+kEb8hqka9r1f42YWS?=
 =?iso-8859-1?Q?QF9B2D3CJVL6TfVJYtE5NE9P593fcBzH++U1DExQQCvAO8u+Jpsk8wWzji?=
 =?iso-8859-1?Q?qjHGjXltd/3wccdxHxQXueQITDVN23oQsuhygKmHpAXpYiW3W2Aw9NgHDm?=
 =?iso-8859-1?Q?42bG4weZJgseh8AGyx4xO9NSzET7ZH7RYWNSE4h3afNi4vKp0425Jr9Hy1?=
 =?iso-8859-1?Q?kT67tjMa0iP9OD68v7KFd6zphxtbIB8F2IuW3I+G83fnJQx0cDdo6mUxpg?=
 =?iso-8859-1?Q?bdv3oYJR6d3298D+ROE7AT4YcNpmj3z/YzmMBz0HoapkREjdHUeZID5sL8?=
 =?iso-8859-1?Q?jv9Dh7ZUyrO3IQ0GhwqyqB8e20WDrqJlN4iVzPY/WdI1AAszQ82TIIhPmT?=
 =?iso-8859-1?Q?A9/TWJ5qg3inqb059Yiqobl42HAv1PHonWzf40BPKNfaNck22/Te4G4sZQ?=
 =?iso-8859-1?Q?wTr6J+1/vYsiVD1+eysO8B3GJP2YKzw9zrF0JfQD8K7/gHptXTIMa24Rwn?=
 =?iso-8859-1?Q?wQLFNoWupxLtQuqMVHsrglsBN1bYiLRZms8koeJ9uRdKRGLN3uIRmIc1xB?=
 =?iso-8859-1?Q?iKTjYxLBvs1TpLEIy/cvW0SFdlVORVYqhtXf1KQWHOjtEo6uUqyh/q/H18?=
 =?iso-8859-1?Q?0HxnrPGUqlMK4ScByyMHbU5YLRanhpGEDUqpmnfPRHaJUtm/jF/d5JxWuV?=
 =?iso-8859-1?Q?SU28hJfDnJU72hDiQEqcEhOAjo7m2Yl8PBevLG5LQ8oSH3mFdv1hWQMm5f?=
 =?iso-8859-1?Q?rqBxXy1RN4M6Ed6bc17FfyOp9Dxyf5/rBsW0FzRGQl9c5TjUrDEOJekn+L?=
 =?iso-8859-1?Q?xeM1nrelk3UBP2TIV0lBK3t1g3pA0YwjsX0G0cc8kwHSq74ybC3WCobMUq?=
 =?iso-8859-1?Q?35jzy0sFoc6BTZdFUZVaV7relh6i8bETQfqUsCY6vd0FWiG5cqagSJLyT/?=
 =?iso-8859-1?Q?+nsJX5gAsRy43WkSxSG7LB0om+3bzpyB8mE9OY0pt3od6VCIAfgcbrJLae?=
 =?iso-8859-1?Q?pt0z5ZghHMCqwz+tEgiV1whpl+CuQ1hTyEuY4iM5cnwqiwbtEGM0CpA+H6?=
 =?iso-8859-1?Q?Df2zr10VuKhnyl0xMw9d57TkTQiNyd0p2ZfagBQ00d1d4XSS+NqZHYJZuW?=
 =?iso-8859-1?Q?XuiBg7usW1vpoCL/KaienAo8jAEcr8EWm1vgC1Uf2PkTe5SDCZX/TC0Mhi?=
 =?iso-8859-1?Q?P4HYa/W3Ip1DEuTgiSDrBOFylqjx/H99PnNs8cmcLZcq1X0HTS9LRdaprU?=
 =?iso-8859-1?Q?uICZck4lNAjc3hZ6ppTLG8EdvBqlFgNXu+m1TDIHttOtk7nk0xE4J8c8Ez?=
 =?iso-8859-1?Q?OMGSgvBwSVUVdJAzjNshNlzUJ9UUNOyIcbsA77hE47eKyYXsmxEqHfG6Z+?=
 =?iso-8859-1?Q?0I33+5S35hjohPlHExIXqeLr+bqBqOIWPVt7iJuvkYvsnEAC4cRK02ltyO?=
 =?iso-8859-1?Q?KVNb4metjfm7+myb6iWJGgYACXTQqJVsPIWRrtOMaIP5l/fhM9OaY3CL8i?=
 =?iso-8859-1?Q?MbAf8NzJFBkXxwByuY6DZ5WJAtRIJzU5mMencGyiIu7WeHU5oKn3r/u/us?=
 =?iso-8859-1?Q?da34vVsB+ET3NY/Wb2vNK+JUkrPFwvFhrx963KbKPKkyzB4NIFZrnCxzFu?=
 =?iso-8859-1?Q?FsuATQnBrszhcSo2noAyCJPcVi3sfDM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB10396.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb7bfb6-0578-49a0-06db-08deaa7e8b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 08:16:01.7402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aocOZ60ZXci9XEciius7BV8XSK6WnTqfOvhVOcUIu7XYjHX3Z5gTvFrRMBh44JI1dELa8/lARFob8xkRZv6wOdCnMmw0YObZhMlRKqJLQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7361
X-Rspamd-Queue-Id: E95F74C8907
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hitachienergy.com,quarantine];
	R_DKIM_ALLOW(-0.20)[hitachienergy.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284253-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[holger.brunck@hitachienergy.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[hitachienergy.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]

>=20
> Le 04/05/2026 =E0 18:07, Holger Brunck a =E9crit :
> > Remove the whitespace to fix the indentation.
>=20
> Do we really need a patch for that ? What's the added value of doing this=
 change
> compared to the cost of doing it ?
>=20

no not mandatory needed. I just saw that and thought that also such minor i=
ssues
should be fixed. Can be abandoned.

Best regards
Holger


