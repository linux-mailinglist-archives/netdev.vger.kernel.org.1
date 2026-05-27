Return-Path: <netdev+bounces-292414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIBAJLAqF2oJ7wcAu9opvQ
	(envelope-from <netdev+bounces-292414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:32:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D899C5E8561
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0613C3011F1E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62C44B692;
	Wed, 27 May 2026 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sgaiz+CO"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E5436353;
	Wed, 27 May 2026 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902844; cv=fail; b=gC3Wgb8X/VFxAuRiuFM1WTnU9+hDKYNA+WkG8MDysWQ+0CyHHuQb/Piu0fHZa7ylS3aMBDq0Rh3zwh5hP/SXkOiscgtMwoQPIbSUgc1Tv5W3yUrTjXwbw05Gx49JR2HZupPxpOhD4pW2LMGb23BsK8SYyG0hxS066+4BFjK0y2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902844; c=relaxed/simple;
	bh=YEVzDUebrRBCAVJR+zFcIxxRjfoXRMw1p7d6fDH5X3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qe57cgXptnqEwBU/f3AZmStmLpwvdcG0UV3Ve0A9FYC/tBjNzyGvmoPBiFCll1FhH/MyhLCHVJr4pjOjZYGPSLeEp6GYaC5Elu6gLQttIXCh7SJins4M4E3dwbGCQAVFhiwoQ1z5W5PXR/r2JHkBRw/SBSj3nE8MqNrWnQs0nrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sgaiz+CO; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdcLDgSbEOt6IMISCYQ3Ozzi1GE6fm08FPusnXDcfzPsdwJK6bwnBZWXmJgtH6yg6Ozf+RLTlyDncuqlWrK5CRi3RjrPIqT+sPyujMNWl/5Rs/Z3hzF6ybi4z/4PeGIkULrXP/eeTXxDb1+yTwxsDIQQOkUF0XKzgUyWixFhZVUuVMNFrycQARAKGOhVMODoRLC9cdznBcfz08zq9++xPwhldWCn/o59M1S5H6Acja60nX0Bwebm639AJdl8ZGKJraw9QHXqZrt06/ZFsCWD1oHCV4P9NqKR1Te+NieYRIB+BJoJbN/5PKUom5pguQGL8ApSV1rtsr3WOwj38bAl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gea2JBAKDMbTlaRxCe+WZP+eFV5wKF5V3tI93OnrvoI=;
 b=pDqJiZxi3O9aj5rjXtgKoEdrHglhzUbE9djpFK8/dwq4trls9rftHjfNQcfPwxz2RJt7sQIoTGU0lWkRJZaeruCqS9ZPbX5Nnmd5vBt13O0DX+Q72GdzzmUEHZVjk3f7t+imPmGgx7o0Dg+tE28NZq2UXuBYsfM30LwrI6mxIGcAPklThgN/bAHz8DZilTySMwj4URO1kKkdSRGieihjWK7AvmdmQjgSs/vHKYj0EGFmWk6PiVL12eiB4oHpP2q1cfQKanz5Em8WWxpROHDnElzGzNc0mr52f0Sfb3is6effrKtY+djnilXAnjHZKQvXU1GqZes9nwEZOLl0ifMXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gea2JBAKDMbTlaRxCe+WZP+eFV5wKF5V3tI93OnrvoI=;
 b=Sgaiz+CORI/4R24wi6MVrz4Olr2GoeZVF0GnjXfWMu/FtSvJ6Pl+d6hQSk4az5l1sr8dXyErptIyTW3N5dskqllPVhGzKJ1WtlWHWizJ0kuXq6rk+j0y0jRTUKJb42Tjqr/tBr5DT8QlxL9BCgRt1/9zhFr+zWOecSWuq6qmGBkiDHStIxL8cCML2ZcjeL2ZuAbqWaxM4KIoJnPZsyd8a9PH4oQxUR+3H3go6rAZp3+TpjYVa7HdmyAnIF45Uuyu6TAhCsXHargLGwlErtrfX7NQvf7SJrmcOxDoN1CqRANXd7xCdkoSlQq20eHchMc6KRUQKPCW6yS3H/DgtIEF5w==
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:27:14 +0000
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb]) by SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 17:27:14 +0000
From: David Thompson <davthompson@nvidia.com>
To: David Thompson <davthompson@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
CC: "bryan.whitehead@microchip.com" <bryan.whitehead@microchip.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: lan743x: avoid netdev-based logging before
 netdev registration
Thread-Topic: [PATCH net] net: lan743x: avoid netdev-based logging before
 netdev registration
Thread-Index: AQHc5LUscPiHBMwY0kOblphmtVQSXLYWKhOAgAEuk7CACtlMoA==
Date: Wed, 27 May 2026 17:27:13 +0000
Message-ID:
 <SJ0PR12MB8113B58970F2E9B7A6EA5B75C7082@SJ0PR12MB8113.namprd12.prod.outlook.com>
References: <20260515215229.3881949-1-davthompson@nvidia.com>
 <20260519184115.3c70f2ac@kernel.org>
 <SJ0PR12MB8113A2493154C98E13D246F8C7012@SJ0PR12MB8113.namprd12.prod.outlook.com>
In-Reply-To:
 <SJ0PR12MB8113A2493154C98E13D246F8C7012@SJ0PR12MB8113.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8113:EE_|PH7PR12MB8154:EE_
x-ms-office365-filtering-correlation-id: 3d8f3de4-be03-4b31-4d99-08debc153130
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|4143699003|56012099006|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 eeM4js8FQiWoMVc4dmmw39BDcX5EhgnqQ1qSjglwA5oGEENxODrwabNJlSGrc+xH4lboH0U+4cAERz+iDJmwv9ksWSYzlxG7Y0wUekDbsFrqpswxVBiI6RUpT82VaXiqYuevY42C/Ebd5uup1j0k3IY1KwDrZYr7O08gYOWbQXH5ebQtQRcDXzbJrkJ1lIiCtUPG1dprIBk2aQx0v8pRqrU3d5pREosWOEOv97Vh2WKNO4An5UuZzpFUACoyr+G+InhjtuwqYElOZW+CPB7wGp2kSMQpvuUBThznyjOB+WKbSRoZ+bRZFIVQj/yuua6tEmfEMQMX9iyxaahYyTutt17LWdWdUEhwc93eRezlsaPfwdT6ArZGYHQxWzHIfonyMT7vJvUmnlcaFKtnUV6+oS3Jv7qUqqbkyUn8irvEGK6zhjHHAmWRbKA5hzyvPNrtwl0c4Mowl7LrnsIjGRS5jOhgozhUlgcOFEuiOVOpxliMuOl3Tx9oii809CnOPig9s5vFhkzWja9pkDT1nC9cm7uMbFrnPhlBoNvIhoOpqY1x3RTTkgyPAQ9CykOoJkMnFvGQcLGADfG2dLzc2n3e6RsJg3YAs7JKdmIyYBwifzI6NlDT38dqH0AFfwQQwIcaNRRSgjyxg9NbeVUf2pyLYE54xpTpZRwaSBZ5LeTwPVhnGCM8aHjM9rsgyxci3MbTyfnXOev1VoS11IVkXHsfFCgUPV2xne9EMjiPk90pD7LlxMVPumJu5WSGCmRaAbGn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8113.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6WLndiSVWFL95nOuSTwrK0DP6wLUc2+U7iNCinqfS+PZPCWPG9cPoSF4h6l+?=
 =?us-ascii?Q?HavoOxObgotR8MXWqT7Lo+TP4bCEOmqM+Pn7y3ww0ygBTe3B4zkMu7Sjvrg+?=
 =?us-ascii?Q?CnNW8A5MxQVV5YWvHJ/tQO8Rp7H9rnG1nWQQOEhXO8mTbliOdqq8RsUmHeKA?=
 =?us-ascii?Q?eKrrJhassKjOX1MnzNIYqvgAMEGdtp6K7lhHtsNaUIsRzCKVd6RRhXBN7Ntz?=
 =?us-ascii?Q?Y0tNDu3mC60lM8lNnoSFpiLzKttq69H+uWJ2Fpwp5Wg2MDFDdz2Ra4Wro0ek?=
 =?us-ascii?Q?da+8rL5OpRV9FQXjBMzVb4i+Bh8E7oxonSMJS0++q1Y4kQBepOZXiLcQd76w?=
 =?us-ascii?Q?3s8N3DnVD3ygAr3eB9vc597IkAXaWqWuV1TVuJpSbayWlx42nl5QDd+TdUO2?=
 =?us-ascii?Q?n5LbzmMnH/NSXbmQHifp8q3i4CZhiohasYYz4l/N1nQs9iq7FHYXwzmadv4I?=
 =?us-ascii?Q?uhz/m3h4skMgbGWHHISJWelXzbFQSJsB2YZk0KC/UUdeOwqA6bSP1fhwquEZ?=
 =?us-ascii?Q?6OIVO2emH7KG60NJctpHpSdMkoTkNsp6rGH+Z+NFataBeh1Q8Fb7mrn+r62d?=
 =?us-ascii?Q?HKp18T0Jot3vTi6l4ZgcTKXxlFr3wI1i3cPMLcVlk9+WA3qugU8pK8dMmshZ?=
 =?us-ascii?Q?EQU9RFEaqY1EdhEPqQdxr3PYTgxpGa3zwnbbZWLH8GSZd0qD2Tp3Z0fPn6FE?=
 =?us-ascii?Q?S9J1Ci9eHI7Vkk0KPvVwj7w35NmCrtLvC2oWto3oi2eoB65uV30xJksjLcUw?=
 =?us-ascii?Q?F0lOi9Z7fcNgMrxlvXVi/KPj5iKsgorp7VfxQ7/0iw3kPjEFjt7cN2TzVBHr?=
 =?us-ascii?Q?GHsZDSXRnSW0ZsPD0bEIPDO8qPD1QMLiA0tY2OVh3pOXBBx/mUyOYtGw9YQv?=
 =?us-ascii?Q?euBRFiAg08xNnx+JYK1IdD5AqpineTH0SyT1fKSBbTaXOh5nTBmWqA0rPV0A?=
 =?us-ascii?Q?DteX9cXaJpVaDhuu3oGI25owvIyrbxPmyen/WCKnB05/fxpnGCed+Xx2+rNd?=
 =?us-ascii?Q?HV9PuRawbZ5VBLFuPHnkbHaX9v0qurmHiSnYvfvO7k1asTSY24UjWDwmQnsA?=
 =?us-ascii?Q?Z7CIR2Dx6urkQkn2ZwEBMJNjBecZMq7xzfxyYTWtWQOD/8wJkI+rnJgpTQLR?=
 =?us-ascii?Q?EcDt6hCl/Bkt5pvE1djE1R9PELRupF0eUa+9WuDLb9nFO83kx9JBz4e7ewVX?=
 =?us-ascii?Q?XolMcFCPN9nBmhTU/C/gcDuuqUdLt6YXsGwrsazSFuzNN673+kVfaBZGZU3P?=
 =?us-ascii?Q?9mSAJvQow34Lr+LfvpD4V/1kx6i88ycWCCIZNvoCmYeKKrZ1WkjxQAjMNfk3?=
 =?us-ascii?Q?B+49mZI0EQS6fmWGu4b/3xL94HTJJv2Qy+pi7QANFt/7yDoji8glvBjcOPjQ?=
 =?us-ascii?Q?EJPRU9CCpMFpRz4PcpeP6H+TV6wb40QqnkMMCrG3zKYSHGZd300BqeNeZP8Z?=
 =?us-ascii?Q?jbmi7XFfyHSnn23yqpxv6WQ+5dq5NcdzWTGjWu6z7NfF24gahug0wDwAbMjJ?=
 =?us-ascii?Q?C1fHMT7gsnvbssKB0RfkslA6drWTcvhlMKKdMzQQdhl/wyqi+dKuxI/oz6xC?=
 =?us-ascii?Q?kPqM6S20gvNkYsMaXGUPC8OqK314xVc/4toNwA2oMPWGCmT9NEo/nvwsgeub?=
 =?us-ascii?Q?L58YgW5W8aw9kPPnHYdZ2qAyPlD8VeEks0cSPv2I5QGpG9saEftTLVoEbIDa?=
 =?us-ascii?Q?1tnwTwQc08gGNKGn/VvQ/8pAXRXMiM3VZqoWfk1IoDFHOi16OOysckj7o+QR?=
 =?us-ascii?Q?DgLjHGbLiw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8113.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8f3de4-be03-4b31-4d99-08debc153130
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 17:27:13.5051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkilhPaCrYNoNTqaBxfoTiXWf1oH4J9uD2Sl/YMstYRlQq2nsWofmIHxpJuIj/GWbgbWzqz2x2qBL7bpgydTyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292414-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davemloft.net:email,lunn.ch:email,microchip.com:email]
X-Rspamd-Queue-Id: D899C5E8561
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: David Thompson <davthompson@nvidia.com>
> Sent: Wednesday, May 20, 2026 3:59 PM
> To: Jakub Kicinski <kuba@kernel.org>
> Cc: bryan.whitehead@microchip.com; UNGLinuxDriver@microchip.com;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH net] net: lan743x: avoid netdev-based logging before
> netdev registration
>=20
>=20
>=20
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Tuesday, May 19, 2026 9:41 PM
> > To: David Thompson <davthompson@nvidia.com>
> > Cc: bryan.whitehead@microchip.com; UNGLinuxDriver@microchip.com;
> > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > pabeni@redhat.com; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH net] net: lan743x: avoid netdev-based logging
> > before netdev registration
> >
> > On Fri, 15 May 2026 21:52:29 +0000 David Thompson wrote:
> > > This patch updates the lan743x driver to prevent the use of
> > > netdev-based logging APIs (such as netdev_dbg) before the network
> > > device has been successfully registered. Using netdev-based logging
> > > prior to registration results in log messages referencing "(unnamed
> > > net_device) (uninitialized)", which can be confusing and less informa=
tive.
> > >
> > > The driver must use netif_msg_x APIs and device-based logging (e.g.
> > > dev_dbg) until netdev registration is complete. This ensures log
> > > entries are associated with the correct device context and improves
> > > log clarity. After registration, netdev-based logging APIs can be use=
d safely.
> > >
> > > Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x
> > > driver")
> >
> > Not a fix
> >
>=20
> Fair enough.  I'll create a v2 and post it to net-next.
>=20
> > > Signed-off-by: David Thompson <davthompson@nvidia.com>
> > > ---
> > >  drivers/net/ethernet/microchip/lan743x_main.c | 72
> > > ++++++++++++-------
> > >  1 file changed, 45 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> > > b/drivers/net/ethernet/microchip/lan743x_main.c
> > > index f3332417162e..53492573f08d 100644
> > > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> > > @@ -108,9 +108,10 @@ static int lan743x_pci_init(struct
> > > lan743x_adapter
> > *adapter,
> > >  	if (ret)
> > >  		goto return_error;
> > >
> > > -	netif_info(adapter, probe, adapter->netdev,
> > > -		   "PCI: Vendor ID =3D 0x%04X, Device ID =3D 0x%04X\n",
> > > -		   pdev->vendor, pdev->device);
> > > +	if (netif_msg_probe(adapter))
> >
> > please drop these checks. They are always true.
>=20
> Good point, I will drop these checks in v2.
>=20

While preparing v2, I realized it makes more sense to add a module paramete=
r to control the initial value of msg_enable, instead of hardcoding it duri=
ng probe. I'll update v2 to include this change, which means I'll also need=
 to keep the checks that were previously always true.

> > And the message categorization is not encouraged.
>=20
> Are you requesting that I change pci_info/dev_info portions of the patch =
into
> pci_dbg/dev_dbg?
>=20
> > --
> > pw-bot: cr


