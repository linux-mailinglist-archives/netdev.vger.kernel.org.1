Return-Path: <netdev+bounces-291667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFPCNuuEFWoSWQcAu9opvQ
	(envelope-from <netdev+bounces-291667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:32:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC95D4E75
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF25830488DC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633C3E0249;
	Tue, 26 May 2026 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b="oKoxvq2D"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020093.outbound.protection.outlook.com [52.101.84.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E703DD87E;
	Tue, 26 May 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794916; cv=fail; b=uzvfrno+J7hu5DWp3G6PuqgWr8w1tjVNNEIWZ/qk5hMFR392CMh90+AT23KJMT4jHv4OywERTnLtCx2fR+lX2W/lDfnmiX6/wwrbQKQI+MNPSzaprdnSmANdy8Gb+dN9n27DF+BvQLDnoNlf3A01p57LiIUlewXrDoUFi5+29C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794916; c=relaxed/simple;
	bh=mCJu0xAqDw1rXx04zpv9mH2LYRi6HROv2g5U/qNiea4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o1+3HgsjesN1J2i+MqKD9I89UMWtpEsHLJI+0IgjfnkmyU0he8bw0OHZQ1TEvVGzdtsXVhJBvDute4fk3RL1ql+YBz0qEB5pQUD47ybVNajOUQSmLtNg/kXOfOPBRkWAVH/mx6Zlckr3F0p3zfR+Za6RiGTs5UbfImXB/6eft60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be; spf=pass smtp.mailfrom=luminex.be; dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b=oKoxvq2D; arc=fail smtp.client-ip=52.101.84.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luminex.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHTHBA0kfg3BoviDOyREQcCmKanZPWsAD0ngtsg05OmvKxfIZoEBYplf4eRXPzcpa14JstAsAdhxhemfZW5P8uw/eNQmsYCNjsIfKcyDG+KYmqTK9QIZGHTlQdgRepzYTN+qCodTok54WXyUdNSU+azZOv37ekn93iHLCseNDCy7QWetoHyi1rnfC6cji/jisukOpcfKDBMQqRQ+wgf/znn/Un1AHVIHfwqLBs4yr4vqbGIefuCqjO22GzHcxrcjl3n7QVMDp8NUVQzj6NB4k5UWQJ1t/gyJAjn1+7qcJqIX+8C/omHtMc6YWWy03AL9nIVSV6jfdxtc9v+pFojqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCJu0xAqDw1rXx04zpv9mH2LYRi6HROv2g5U/qNiea4=;
 b=CBNfzDyUaS92LCuuZL2IU2BBKqEDJJqUNToCySHLpab8Bcsyz/D1VwbeCeQbz93nmZHAmZSgxu5h3um5eY2vQxlm/+adKSVB+/RfCMMMuVggLsD8iAQdAneW0osD6TMk/ts+dUlTXweyh1yhnhGhmPH/seBGFKc0EQnhAHuIXi35+ZtsbFDHGBodYb26YRlQnuSGaT/A0fEo6E9A9xruPVrJO9L59pruMwTUGUEyXHJ6Jwc/d43Dcmunnm0Z8Nvv1rhgIrYXvAJWRKHsw28KqR5VMGMfVgfqjFxZFtJSbqs9ujhbO6+8SQRAJS9Qo5tM4NpN1/wpl3u9RIcVMcKGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=luminex.be; dmarc=pass action=none header.from=luminex.be;
 dkim=pass header.d=luminex.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luminex.be;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCJu0xAqDw1rXx04zpv9mH2LYRi6HROv2g5U/qNiea4=;
 b=oKoxvq2DqjQuJVmjoPSyAx2NQh6D93eKPIzdSPqg1KPruPkYPQLByrLMDr9wxLwfiS1kJs+ZfbettLxi7dz5EAVqPHiOsedQA2RSze1ZH92jOY8wOPvS6f1kjIQSXN0goibmIahBwRlPqEdSTSyzbwuaPumJ9RmLDj6Pz3oS04w=
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:14c::14)
 by PAXP194MB1503.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:1ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 11:28:27 +0000
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5]) by PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 11:28:27 +0000
From: Cedric Jehasse <cedric.jehasse@luminex.be>
To: Luke Howard <lukeh@padl.com>
CC: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kieran Tyrrell
	<kieran@sienda.com>, Max Hunter <max@huntershome.org>
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
Thread-Topic: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
Thread-Index: AQHc6dmtG6iOqk/ZmUazD7exB7A7crYfepQAgACN/Zg=
Date: Tue, 26 May 2026 11:28:27 +0000
Message-ID:
 <PR3P194MB1505960E42BBFB9AD9E8B18DEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
In-Reply-To: <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_Enabled=True;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_SiteId=8ca3018c-58f1-4333-afa9-a8744cbe7fc2;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_SetDate=2026-05-26T11:28:27.055Z;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_Name=All
 Employees
 (unrestricted);MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_ContentBits=1;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_Method=Standard;
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=luminex.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3P194MB1505:EE_|PAXP194MB1503:EE_
x-ms-office365-filtering-correlation-id: 6a210a31-85bf-4855-2eb2-08debb19e837
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|38070700021|4143699003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 tc+fc/IV5NgVMR1B64rPgh/R1O8LEu8smTTwpMfC+0gN2aOsJlw55yA20GqYQ3Cd3V3t/xaMOxxNUMSGUh3dB0kPz1AyOfTVZGnrzZDxuoLKx+Yy99XVzSF1ttHp3nYVzVEofneJ0tU5qhRO0PFQE5TNT5CyWkrXLOxEGUHVGLknBSL5q+vyfjSQT7nbP4zoEcBJPiWu4+ne4XQMveM3Q+Lf19ZnzKXpHWS0E5iqk/I9q2JdTv2MpbqR/g/nyo3N2nGoGRBVeQyDE7Ns4fMpk2yXAXOY3twq2mSTPfVsVcePzqpR8vlEUbRcpccZ8wV6bZA05n2ir48zgHBsu/APwkr6Aiy0eYOaItfJGsjbfGbZt3xfbFpvVE+40HRRrcKcSuE4bxzlkwb1ew8BSHq7ui1JGxAEdzVTH/Eh3ln4Z3gMa9hYk9sPuxAmEQINBfk7J4MJbSTwen6WG+YIwom/JlDca8CygOFeWU7qug8V/MGqlxrLbtMu3kRen2s8vLT9od4DvorPmTjX/llQfbvMEZhYz2i9j6DZplsMsP5HoJ5rc4wvZ/Y3SEPjNgeNsJbfZ2DHpUmuDUi3vp87Bo1Rlc6rt8029RFlQ/6KI3TZvFNs/1hgaQCcFdQxKiiQ+A3vFtEOfwYrsSIwB8Zyb0tFWK4Mt72UeG9+KgVDS0Ca979bD4RR3ecnmqLJ+riIM0hA/RHkDh7aVm6sjHWmuAbjI52BbtFs281fajjwOy4z97PhyxQtkW3/CmZOPV9bVBhS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P194MB1505.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(38070700021)(4143699003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?QL6dpnDt8Yh3jyWhjZvyVasebutlfc/54ZVlkpY4w+ydn0Y43Rt5WGb1F9?=
 =?iso-8859-1?Q?H14TeKlpQ/9rW5Ps1gtH4K8udBevJlvwxpjzzOEkSFwuhmdBVF3iWwaXf/?=
 =?iso-8859-1?Q?hdC+RPPJJPeUb0t3wASLe/zB1rDoHMYmlTxDalmoj5WuvstNvb+HqkDsOQ?=
 =?iso-8859-1?Q?fxtJUs4D3T1N689MRnV8QFG9Rk0SkHm+DobG+s/TuCxtC0QV++++KxzCRF?=
 =?iso-8859-1?Q?gb4Ljsyni2yQVTBjH+EjJ2e//+oqKXIQvKfgyD8Ggbyf8Z0mCJ98FRaV6V?=
 =?iso-8859-1?Q?hfmXgV+ofB6Re3RceV4uIwZkNrfkGJvNoeKAQVE8ARAsk2U1UEog8Y5AYq?=
 =?iso-8859-1?Q?pXwkxqvwX+Xwr3eQpDm1y0lcMexsOvoZWlggqxv+SCfUP4GH5BjrcRlBbb?=
 =?iso-8859-1?Q?LCHOIf69wIAti0qPlULi49g9Kcqke8DNW7ef1DePDFU0RoLIQwS18yTcrD?=
 =?iso-8859-1?Q?fInhGo+P70yK11wmSAaon85vNkSjGiCsar2MpsyxxEpe5N2Hi5j1+chJW6?=
 =?iso-8859-1?Q?n1L4t4++4LOJHuQfVGTpjNnAgVyHyVdFgwoFEeDKB2WNBIdRRnUpJLbmC8?=
 =?iso-8859-1?Q?3dgxTtkGW+2ciu/1QpU2KBR2Ti05S13pNILqiFgzwqLbKArsWkzmfU0yVi?=
 =?iso-8859-1?Q?U0K7eZVkhOUq9RbYPUHQByDFLqpqrazKuId4rjZUSu7F9dnTGuZHA8v9J0?=
 =?iso-8859-1?Q?+PcO2VW5N6RU6hkz28Be7JOKHDI2kSUAiMcu1ykzXRMPE0HNi2QT1NNWyl?=
 =?iso-8859-1?Q?bemtiC9ybNajK+Get4p307nrF161ODoqY0iHVvK09bc6atm8VUQpislzW6?=
 =?iso-8859-1?Q?DDJo/4t8VtEiUtBBjgN5LUTVA+pEDXKJu78+JmfdRTSBzVpG2pgbsR2OL5?=
 =?iso-8859-1?Q?ZcR8fpQ4GBNJfP1qRIDsDVen09k8bAhB6DBUYBl2ErrNE24pqqe24bAXJv?=
 =?iso-8859-1?Q?Upy8doOgJVYS4s0pv/U6oEhC5C+bm2Q0CRYQFWbnKcz+WSwChZHZqXUuqN?=
 =?iso-8859-1?Q?DfH11+OM8yED/T+cJ1oOC08C6FyUV5VCxyWt0s57JGPQZOpf4XvPFXRCGr?=
 =?iso-8859-1?Q?iUvYrG1cULnLn8U9UUHc8g9JIkblaKe4bFzrytN24Nw/pf6tWLDRjiU1A2?=
 =?iso-8859-1?Q?c+yzGAJdcUoTteje2W+sjS2xAUmEysAr4vFeIdhUexAThCv5wQF+ZjXT8K?=
 =?iso-8859-1?Q?EDV5utQh1R5Oo21MWmcfjrY7H9y+eGrRX2oh6/WEFlmOqEVVNI+W1BVqcH?=
 =?iso-8859-1?Q?08Zz/m4FUf6GXNOWsqz8NPEtSnbabW8nTvECCBCMbwkyFcKNFwWAy77Knu?=
 =?iso-8859-1?Q?ZWiQPbvu9Fz/pQA7In7b7zWrMKTHAr1dhq8EEez8hhxYH3fWpyHe9tVt3r?=
 =?iso-8859-1?Q?wqwFaK3NkhrD3FfNN3M2s96RlV2DcBHnh24IM5ofa9Kqp0r3BENeRb2j6j?=
 =?iso-8859-1?Q?WKSM/A4rrYB82v5KGogBDt8yp5Or5xMwffDV9nkHu9vYJW27wYi6+E3wEh?=
 =?iso-8859-1?Q?rrQjo+kgzkbfD4wU+xGlqJv6+jMuZCbR5Ubg6C3vhE3dFdzQ0ULDQ98yoF?=
 =?iso-8859-1?Q?PwOchQRRmCzQqgVWKMrHbmzl2pxdD9RD2ryHFqLcPiNGO9oNolfwn3LmVl?=
 =?iso-8859-1?Q?F90X5Mh9cHCBpgTNp9MmHh0Dy03lF4FfWCJNMHmhM1FPNVx1HGtx0hrgLV?=
 =?iso-8859-1?Q?tKc2bRWpZ5B9QWluUrA1t9izX7E0jg791qhbDXOkl8fWYUqHCHF0nzxHn6?=
 =?iso-8859-1?Q?qxeyibngPqCrPAEpdjUNnnmFg5JzDHTk/gv/kwYDSF7i3adZMecT3rvti2?=
 =?iso-8859-1?Q?c++NV3h1NTD9gt7VVjAFg4Oljr3i23MUhOD3tpLWS2Hq+Ukalp9xZmy2cL?=
 =?iso-8859-1?Q?++?=
x-ms-exchange-antispam-messagedata-1: jFtj2+hFll86CQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: luminex.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a210a31-85bf-4855-2eb2-08debb19e837
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 11:28:27.6948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ca3018c-58f1-4333-afa9-a8744cbe7fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBieOU3YS1UPTGWlcdDXge61ayzMwMBNWwT0XhKKJN0xsYEttgAx6pU9ihxnbCoyiT057S5IniM9gsRkH6VsPiH5bi4Le07mkfkyfA3j11c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP194MB1503
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[luminex.be,reject];
	R_DKIM_ALLOW(-0.20)[luminex.be:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,sienda.com,huntershome.org];
	TAGGED_FROM(0.00)[bounces-291667-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[luminex.be:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedric.jehasse@luminex.be,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 49CC95D4E75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Luke Howard <lukeh@padl.com>=0A=
> Sent: Tuesday, May 26, 2026 2:32 AM=0A=
> To: Cedric Jehasse=0A=
> Cc: Andrew Lunn; Vladimir Oltean; David S. Miller; Eric Dumazet; Jakub Ki=
cinski; Paolo Abeni; Simon Horman; Russell King; netdev@vger.kernel.org; li=
nux-kernel@vger.kernel.org; Kieran Tyrrell; Max Hunter=0A=
> Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for cr=
edit based shaper=0A=
> =0A=
> Hi Cedric,=0A=
> =0A=
> We sent RFC patches for mv88e6xxx support for both MQPRIO [1] and CBS [2]=
 last year. (We have since made a few small changes which can be found in o=
ur working tree at [3].)=0A=
> =0A=
> We have been using these patches successfully for the past year with our =
SRP stack [4] on a custom board with a 88E6352. The CBS and MQPRIO patches =
remain unsubmitted because we also needed extend the Netlink API and softwa=
re bridge with a flag indicating a FDB/MDB entry is managed by SRP.=0A=
> =0A=
> I would be happy to work together to harmonise our patches to avoid dupli=
cated effort.=0A=
> =0A=
> Cheers,=0A=
> Luke=0A=
> =0A=
> [1] https://lists.openwall.net/netdev/2025/09/27/34=0A=
> [2] https://lists.openwall.net/netdev/2025/09/27/26=0A=
> [3] https://github.com/PADL/linux/tree/rpi-6.18.y-xebros-rmu=0A=
> [4] https://github.com/PADL/OpenSRP=0A=
=0A=
I've looked at these patches before starting. I quickly ran into the limita=
tion the driver only supports 3 traffic classes. I want to be able to send =
traffic from the cpu to other queues too.=0A=
I don't use MQPRIO hw offload, which i think is a big part of your changes.=
 So it didn't make sense to continue on those patches. This also answers yo=
ur other question: i haven't submitted another patch set for hardware offlo=
aded MQPRIO. =0A=
I'm trying to upstream changes one topic at a time. Eg. this CBS patch is o=
nly for configuring the shaper. How traffic ends up in a certain queue is n=
ot relevant for this patch.=0A=
=0A=
Cedric=

