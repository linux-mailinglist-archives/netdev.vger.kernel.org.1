Return-Path: <netdev+bounces-145115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5E09CD4D9
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF475B2351F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB78D2629D;
	Fri, 15 Nov 2024 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="gOzan2bZ";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="cMXOLSBf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000e8d01.pphosted.com (mx0a-000e8d01.pphosted.com [148.163.147.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8121370;
	Fri, 15 Nov 2024 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.191
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731632499; cv=fail; b=lZq1dlBqmK2UaEthxfmHd65OBc43PhfOmb+74j9Z6QqAn5pVP+fAB0/2Ds/g9g1SEU2LjmjWjLnmfuKtlQooqHsVDRmbii0mWGb5qMD7OM1ge13sjZgb7K63OPhaehSkgizEmYY9p2/zBCUyiFayNI4S/9hlfmiNfhz25Wh1kR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731632499; c=relaxed/simple;
	bh=axsxY8hSfRcuCT6r9OVDSp3QgIvuthI866Dchk3XLJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oDyEoY00iT0pWirz8JWrZYXG9/6DQtgylP762DbT3uJIKB6Mroctipq26Dfhzqi6DfMdtX1TKsTzanHNI6wn8161QVAcae9LCcmmbKUoAJ/GgFXBQvOH+ACB4BAzyvJ7qATURY4VmCAKLe1hh66ufMyOIBM9YveloMEQdW4yyTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=gOzan2bZ; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=cMXOLSBf; arc=fail smtp.client-ip=148.163.147.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Received: from pps.filterd (m0136172.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AENoabO023203;
	Thu, 14 Nov 2024 16:48:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=sel1; bh=axsxY
	8hSfRcuCT6r9OVDSp3QgIvuthI866Dchk3XLJk=; b=gOzan2bZk1iUbA85Ilb/1
	qI8re+tI5arpeGI9w1n70/vmOmK91j9iDxmaochTeDMHUJIFkFsBOTOgvJAdkT48
	DgU6PxILCu0OtIdbw+rNaiwee9Usb3WoZQKEZENZ6gt6EteQ/qmYUnRx95TLN/2e
	JB+YooWrpH22HuZzGJh65TWvHxmQFN/ep5Z4u82w9Ct28mySfUhC2Tt7QUSLmk+F
	HKyn+ArTfJ+QCjHpibcIcIdo5/vo8Hk2CFinZqiMLoNlknZh/o2lxdIjvAW/Jc74
	/WYg9dkNhF6l3iAevlMjBu5gz3BSPj/bQz4kelhaaiDVYqovalVr+5A0fSGbyuBB
	w==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 42w3d3s2py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 16:48:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK47Wz3XKt2p33GVM6+bJ3RSLWiBthcB4LF92Ig2VxmGEVevTRLU1j1uRIopKIhKVEwboS8ReTwZZpw8LpUoPOv8Gils6QfPh+KRwhtF+RXbicFWtoZcuNMXggziBuiio03Anq/5HbkYTMN1TS/WSleXXhKnDyrcRxu6zVR/u4922C1TcmRaNoD5hNUgiXHn3M4/H4gjWQWTzqOxRD7MBqMu7kSBxKUn2YrAJnJ6C3OwUriiRbKkwUw8VWJuiAY1fih3KwWOYkBHW4NqlaKNl+Z/lx/mIx4cB/1hGKaAXq//h6pU4cgBFwiScWWuGSvJctHpPXSHrLrDvFfu4eNppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axsxY8hSfRcuCT6r9OVDSp3QgIvuthI866Dchk3XLJk=;
 b=l7JwMQ/phD6be0+5BE0386buXfo+tBGL3hEQAp7bTz4S8fm2bKBUivNvBTHucU8/SLOByOegdfW/mREIVG3sYn3EsiZT2TRAYo27jRv2LgdV4j4qx8fggvOCMoWaLrlX6ZYICfjNqsOf38gQjexUPCy/qtlEwwY+edDyGdZCzr+QRvJTl6Yopnw2l6RsU6ioHhSee2DibVRyQUCMatNdujrsEjG9faqGC0Rav8nK1zWMvjwT8LxcnXBce6GJz9vZ2hh3tV6Uh1Uf/Duz7xMjRRTlyzEq7vzYKAmKspamJUyhJ6bFiDj5ybTqkR40l9/hKrDFd53MOldbWqA+PISs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axsxY8hSfRcuCT6r9OVDSp3QgIvuthI866Dchk3XLJk=;
 b=cMXOLSBfpdgz4MzN92t81BgZrF6rN4sBhAwQp26o6VEalygTmkclJb07l+mr8sQDJyqn9quNXewkJ1YK5Rmp0WJwbz4nxnF8y857UdFq+n5xFySmSSSHBsOQ6924+HpyLS/VUK7AzIzRruZK6EzZje31bz8KsP4U+GCDJrDgTeKBDr9cNEVFrUVAkjGt+egz+B+1kuemg3x8eN4zFrLe9RcpGavHgS/7IjuHgWdrDN5a54f8tpID+WAvdHx/BSHBnFmEEcgFjHOgVMDDB0CqGCrJWv5jSIYZJqbSMwZaYATMciexgIQ1GJQ01uDncHtrgCLdJ5050H7UTM9LcCfWCA==
Received: from PH0PR22MB3809.namprd22.prod.outlook.com (2603:10b6:510:297::9)
 by DS7PR22MB6036.namprd22.prod.outlook.com (2603:10b6:8:253::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 00:48:51 +0000
Received: from PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731]) by PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731%5]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 00:48:51 +0000
From: Robert Joslyn <robert_joslyn@selinc.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "lee@kernel.org"
	<lee@kernel.org>
Subject: RE: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network
 adapter
Thread-Topic: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network
 adapter
Thread-Index: AQHbKYm0/z4P1lQS/k6ewHCARnYgRLKd8gKAgBmHGcA=
Date: Fri, 15 Nov 2024 00:48:51 +0000
Message-ID:
 <PH0PR22MB3809C7D39B332F0A9FECB11AE5242@PH0PR22MB3809.namprd22.prod.outlook.com>
References: <20241028223509.935-1-robert_joslyn@selinc.com>
	<20241028223509.935-3-robert_joslyn@selinc.com>
 <20241029174939.1f7306df@fedora.home>
In-Reply-To: <20241029174939.1f7306df@fedora.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3809:EE_|DS7PR22MB6036:EE_
x-ms-office365-filtering-correlation-id: b1c3b3fc-8a04-4a0a-1dbb-08dd050f4603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/KQUcJM2LNtsz2uHnoZar0/8DapYa72+ULDzsroqnfX9xzhckoZmig/3B72+?=
 =?us-ascii?Q?qo8+PdJy3n79Iw/AIy3Cx90EoStcCfobQ/d5MO7SZ9A1Tf86n+S/ayVlHoWd?=
 =?us-ascii?Q?SrKpFsJR9yxQmZa2BlRpN+ilaLqyCgNsAKdW+TwnEmTNZCXGYXPT8kMa0GVF?=
 =?us-ascii?Q?tlOhaP3OfPEQPI/GAC+Pg4bSPUC+c/2BKm8MpK7NWGBkW6lIR254ivcfS31I?=
 =?us-ascii?Q?kNk3xEq7Kd6KdUA3EWmS4nXdE/TUy5lPDWvyp+l0mD26+QggA4840CH2NAPn?=
 =?us-ascii?Q?919Gy8NIRIIKj6hg+9JbEkEngZaoPILWNOj9Tj59YgtpuJ7ZwR+4qX1VLLod?=
 =?us-ascii?Q?BMixZZrSQNQAlAEAnGaFSrgYZB07VpfiVknmYsb7aT/NqmofJQGE6gMLWzj9?=
 =?us-ascii?Q?eV3yMNDFlcG/GWspQFwLaudo05WLe+Fh+yKnaJyjv0ZEJx3/cUayXnVxjDk5?=
 =?us-ascii?Q?cWrKMyT0JoUS8ROjGCFbBEVckBodDB13lrrF4zfkrtsDZBTsakJmZ4dbJfoD?=
 =?us-ascii?Q?kLYn6mwTtRqiPh3sOe4PRFGASxKp6dUIuyL8sxb3qX241W6AH82jJoiHpvz5?=
 =?us-ascii?Q?GZwI5M/kVCHsLRMiVyHkZEpPoBw78He/s4pHARiCdFTqDEngN6TZrp5GsZJ0?=
 =?us-ascii?Q?thfuppt2I34WvNd3U1YJBeKdI3nApJUeSCEnZZ6WceboYSc5fqoa1yxdRXV/?=
 =?us-ascii?Q?eQnRtezrNGKKTabsLQiNYZIJUMrnUyAHgxoaSli5UIsFNnJfcBozbnLiTHpL?=
 =?us-ascii?Q?xHofr0OCLx3u8IHOuIRX2XYun7oN3/xysqDkXTFun/hkwbbjJEVmbrzM9nI9?=
 =?us-ascii?Q?2tG9azIHF1uXF0uUa4vbOCSy12091FhJtNi4SFeGWOw1sVHB0B6R8/U1jLIU?=
 =?us-ascii?Q?jAVtIhaofqYwyMKFCmCd+TipNbmL8QToWQiZRnKCB9ZDgLHOXgSKzj2UTGie?=
 =?us-ascii?Q?ahYURZnoSa3sDhFABAAJleCFOpd/+8WFRs0b3jFPvMJKSY5pTt4zrvfYx1i8?=
 =?us-ascii?Q?gOjjk8Gjn7xJaa4PBSBHcrHMotZT+ueaIgTv6yb+UNyGlX08uwHlxC9O5bNY?=
 =?us-ascii?Q?BbA4k299CFq45T1G6Oyhhs0IgDtuDfRrGz6svJWK2L7g+bLXNJe0TU/uI058?=
 =?us-ascii?Q?IfA7YVtw3IL5mDyuayf87JvdmF5GqZ9VOR756h8vhZGLMC9zvIq/83VxlNCx?=
 =?us-ascii?Q?0/VfWImsZ8Yvq/9wZSdspswELYXShIBHaJSW6BRy3di0ReLG37HpozQP2aY2?=
 =?us-ascii?Q?VmOU/UqZ3djuXwX8RumdIXisfW5rtxUXF3SpysZI9LB42mIJyygEvgdD8wdI?=
 =?us-ascii?Q?hy4CW9y/FlA4OBznw+MpN5qU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3809.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FXrTNZhr60Bo+s5jfU7RXWpo7/WFh4Nfp2N9XZzT11qfStBzRpvnCH4QkC/9?=
 =?us-ascii?Q?cFGHdxtc4YT1qHTrVqTiNapjbx9cdCuNM3Rw9BKwf/8V5Xbn9RbiOJgxzjBH?=
 =?us-ascii?Q?Z1moC5KfaZb7ljtHDhZ4q7/exHspDmHdsXZ72ifCpSMeZqnRPfwv62DVboAf?=
 =?us-ascii?Q?9q4/WLQcnG2+wBRhaYh/m1iEbUfwvC0FENixj0Qm+k/0uDKsWqHMpw8z8eWk?=
 =?us-ascii?Q?oq8TXzxit1btn3ASlfvNsBP3jaBHFTuDiLk8XqSwhWmXFgXDRRrG0hkMaSjF?=
 =?us-ascii?Q?UWP0i21+3IrJVKuvMQ6nJ0wJFk0YDvpE7PUyfU4F4ANkjndX/3w9ngRSR/Gs?=
 =?us-ascii?Q?LNLjYEPNwmMBQI62PgRowCSUrtdxaEKRvJQGhKwrPE0/wVj7aUd3v351UsJ1?=
 =?us-ascii?Q?JXPOevu04n/0B5gXngAVL7pTiaivbI4jXsTmEGB4VQmbMRldHmemwNCTbtDE?=
 =?us-ascii?Q?6zqaXgYOQ5aZ6VAjXq9lVfs0ao+/lnc7zE8pY3fLC53MpX8baJb31ay5Cv6d?=
 =?us-ascii?Q?XTeZcR4/YKW+Y3wePCq4orgPW8f3be/lW9QJZstG6eUZKQc4FVCmBfFG4Sa+?=
 =?us-ascii?Q?dpKJPgq5pl9NS2q0mboiKnpeif9NAQr/KVbbkI3oZ/evXRgyYmhgw5iCiasD?=
 =?us-ascii?Q?sDa19qIenTqMFTr8ugVkuzPCS9Pv5PTtgA8tbcbIaJ8rtpQJAmYdelMfvHrq?=
 =?us-ascii?Q?JRl5iLlnZnIlgvP+Sx0kZ/oRYdJuaP/KF9Mdbr3ZyeTbQ/mhnB1B2SXlMbdD?=
 =?us-ascii?Q?r277OaNUrk3Ie5onm1KwY5Ve3yjJp3matJg/XhlL2ph1+6adq18IqFwqIMpA?=
 =?us-ascii?Q?sdXZ1aLeQz0qSXlx+62XL80FDTelghKveVt4ww0o8JUf+UeloGP93MYFuwMe?=
 =?us-ascii?Q?pYq6eglimoTDoSwQTQffBkP+tI2c7XrEY7cD2rB3lmA74KifjBcSZVdp61yg?=
 =?us-ascii?Q?HwpVoGG1w97RQE1Wz0Ijd7NOrP6z4C0VEaVqT/02WGTZAI5sfiEsjihoDCR9?=
 =?us-ascii?Q?jeajiEA6PK0jVNa+5FrPqPJ2pp3dAL6Q5yii+BVQHM6vkF9ItPovOIonHUqd?=
 =?us-ascii?Q?+37ABkstX5xUb5rns9vkiiknRp7NlaTJOuuB7uNI3UNmGBiPvmhUZfp0hOj2?=
 =?us-ascii?Q?Q5sKYULw2xJYAyDKSlnpoanjPQR62y/ZUJtFweJumvvyNRFOT6pZ/C5Eynaa?=
 =?us-ascii?Q?G7LH+o3sCR9QAILEMNygI3h0LrV5dYqhMB9xWSidFjNDAacs0c7ldjbMNbmM?=
 =?us-ascii?Q?jOP9fon6a8nA5tIBhh3HZBPsiXscbe3eCVL0HcupsbSQL38lnlJ3skIsIqAL?=
 =?us-ascii?Q?bQQitGllLTtGljqy+V7maz3gKE2izWWCZ8r/0ZPAUACI8SF4sbdDSdASeGyt?=
 =?us-ascii?Q?ADtmbQ82rhca7GwEwHRntR5Rsszgo5IAMvAouiSiL9yWYga+qqiqOEwYD9z8?=
 =?us-ascii?Q?ELHUeGyPDlOMIoMZedHWFQy2Nlh8vzHs9yOhdp+Vss12Pfbh5MW6Oin5COOC?=
 =?us-ascii?Q?WspRXWES8hyhyO0BBq+UzV05wIB5V9ZEEL1GJ+snKRPIpkURQ5zHCYWuVD87?=
 =?us-ascii?Q?f+xdyp2iuNHpPbKbhup+Tau+zXUXTkOB1Ct23wfh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3809.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c3b3fc-8a04-4a0a-1dbb-08dd050f4603
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 00:48:51.3116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbawfQVXgfsEzn9m6F23KfE9weGz84JZnMQ5qUUva8Z9wUBx9sOig4vm8ks7sDBDvhyh1Qf8r1JtRWIG5XNrG6SFun3B4Ryb9mTyfWr3eoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR22MB6036
X-Proofpoint-ORIG-GUID: 9--jamztBLKlYT1MMH4-a2SWjVZIpYyQ
X-Proofpoint-GUID: 9--jamztBLKlYT1MMH4-a2SWjVZIpYyQ
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150005

>=20
> I haven't reviewed the code itself as this is a biiiiig patch, I suggest =
you try to
> split it into more digestable patches, focusing on individual aspects of =
the
> driver.
>=20
> One thing is the PHY support as you mention in the cover-letter, in the c=
urrent
> state this driver re-implements PHY drivers from what I understand. You
> definitely need to use the kernel infra for PHY handling.
>=20
> As it seems this driver also re-implements SFP entirely, I suggest you lo=
ok into
> phylink [1]. This will help you supporting the PHYs and SFPs.
> You can take a look at the mvneta.c and mvpp2 drivers for examples.

I've been working through migrating to phylib and phylink, and I have the s=
imple case of copper ports working. Where I've gotten stuck is in trying to=
 handle SFPs due to how the hardware is implemented.

This hardware is a PCIe card, either as a typical add-on card or embedded o=
n the mainboard of an x86 computer. The card is setup as follows:

PCIe Bus <--> FPGA MAC <--> PHY <--> Copper or SFP cage

The phy can be one of three different phys, a BCM5482, Marvell M88E1510, or=
 a TI DP83869. The interface between MAC and PHY is always RGMII. The MAC d=
oesn't know if the port is copper or SFP until an SFP is plugged in. The RF=
C patch, which has fully internal PHY/SFP handling, assumes the port is cop=
per until an SFP is detected via an interrupt. When that interrupt is recei=
ved, it probes the SFP over the I2C bus through the FPGA to determine the S=
FP type, then reconfigures the PHY as needed for that type of SFP.

After porting to phylink, in the copper case, the PHY gets configured corre=
ctly and it works. In the SFP case, I don't know how to reconfigure the PHY=
 to act as a media converter with the correct interface for whatever kind o=
f SFP is attached. The M88E1510 driver, for example, seems to have support =
for this in the form of struct sfp_upstream_ops callbacks (https://elixir.b=
ootlin.com/linux/v6.12-rc7/source/drivers/net/phy/marvell.c#L3611). It look=
s like phylink_create will make use of that by looking at the fwnode passed=
 in, but I don't know how to use that to define the layout of my hardware. =
I assume this is mainly used with device tree and that would define the top=
ology, but I'm using a PCI device on x86. The Broadcom and TI phys don't ha=
ve the sfp_upstream_ops support as far as I can see, so I've focused on the=
 Marvell phy for the time being.

How do I describe my hardware layout such that phylink can see that there i=
s an SFP attached and communicate with it? Is there a way to manually creat=
e the fwnodes that phylink_create and other functions use? I think this wou=
ld need to show the topology of the MAC -> PHY -> SFP interface, as well as=
 the I2C bus to use to talk to the SFP (I would have to expose the I2C bus,=
 it's presently internal to this driver).

 Or is there something else entirely?

Thanks,
Robert

