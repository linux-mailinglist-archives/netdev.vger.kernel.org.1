Return-Path: <netdev+bounces-127265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4FD974CB0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3769DB2145D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF192154C07;
	Wed, 11 Sep 2024 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AKXbwSEj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2366314F100
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043549; cv=fail; b=fVT1wwsjAZGkxopo27/lvKvYuaoDFWUbYCDe/vydn500TUsPYNodb5f/f6/Q7PrmQ4JVuCyLq4rSFxiwjNaeWHWW5t7M5ELikGrD2sMZf4WZHFlezpqTY4d4hUUIsrwYzThB5cyN5NFove3B5s/59Vxt2WrcuIz8JI4VOk3RRs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043549; c=relaxed/simple;
	bh=FBUFHVl4W1VFMYSt5dP6a/sHOLoYKB6GF5YTfRe70tA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MKnBbvkrcOtp0IBpmXHnmACcbPHlSW/jh0I3rnSF5J3zht1XlHrjW38wpJOsx2yaAaj9f9kfO+lrf0BpaAkOwJt/EkQJJ8vJWThUux8JB8/BSdCWBjWIS0XX4sgP9oIRsdf94g0D2DjGM/u5nc5CGTJOv31bjYVyUXOBoj2hm1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AKXbwSEj; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzK0yHbJqm2rKxzVcnKq4eCmgrxsVlMDFkKv1DrOK1YLvAXl0OVH+k9v1vAIfbiWbhNwFAQqWe5zL6rEvIc82oPTqprlK1kZ2pMph7Fo/8LioqeN/watdq+jV57sQK6Y/OqljD3JMIxPg2KehtPXFOmesBPYNFRqVrhIli+VYW7+chnQYMj3NqVG3BKudtTtonyEpQzps7sApTq1jNKOkk883+pCtQH22xkAFOPbc3kxSesDQRCAsMnbYPg06T/UHsGT1V9W+wV2EixwUQnhDDECv+i1fRdlK7eBtC9Ux5XH3o5uJQAM4TU/weDBL9xZpDI4HaLgXE6OVRNvgjtZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ0cmNldQaSiuD87kKwT5IUKo99wNm9ZIyHbAeMghfk=;
 b=r91Y5kDOw5dK7qia6o2OMF4dmVShO3SIw7m20CKJkkvGc8cYG6AAQ8+9xGOrThyN23L8XUa7gdZJR/dHxHc547uF6pVjBKSjdVzsKAjdbr8sN33tm5QlL63xWzHp8OZeCHpBWYPAjj6+ZEn5rAbZxlyn14eY5mT6vNrjcavARiKN3MnGHyIlF6X354UvmSelDGiqFqqMEA88DGu+qPiJWoNwNqeAUYE2qj6/KDdX5f/d9teK9zm3SP9ba+o0ldd4oTsEPfgEQ65VAT690dAavnay8IOia4Bci7ri5xEYwOqHoT1KES+kjPBfxw9Q82nsONDyfd1UkKpUK5eeANxR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ0cmNldQaSiuD87kKwT5IUKo99wNm9ZIyHbAeMghfk=;
 b=AKXbwSEjzU6CY0C8VkAbTc5yBUuomGwGI49Zn2kBN0agnQJgigVKrNc7mafKot6m5+nx/t3TihSMETtF1V8qXx+WCmRyQrgSarsGZ9A2M1eEmXdKs30VWHBXJOuNsvQIfc0SlKhw07CG/V9PpF6rPaIZp0DQJTTXSxqsc4UVQay5Obi++7eGG3itGYlXIw5ckXB0zW6Y1yRDs306XYq+hqXL31KHeHypOeMHTDmtGAi3/UTNMQ/Ox3qTwnnvZr+PO65iME/QkvdmdaachIBRZSkkyzN8g33Vk/489agTXfyI20yi7Hve9ABMxTQbAs1OdTsoJZf11smbOSOKp9Oe6A==
Received: from PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 08:32:25 +0000
Received: from PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe]) by PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe%4]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 08:32:24 +0000
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>
Subject: RE: [net-next V4 15/15] net/mlx5: HWS, added API and enabled HWS
 support
Thread-Topic: [net-next V4 15/15] net/mlx5: HWS, added API and enabled HWS
 support
Thread-Index: AQHbAuP08dxHTvP0skK+TgQrufHvR7JR59AAgABcSqA=
Date: Wed, 11 Sep 2024 08:32:24 +0000
Message-ID:
 <PH7PR12MB5903F9889F326199B233AA14C09B2@PH7PR12MB5903.namprd12.prod.outlook.com>
References: <20240909181250.41596-1-saeed@kernel.org>
	<20240909181250.41596-16-saeed@kernel.org>
 <20240910200046.30df2803@kernel.org>
In-Reply-To: <20240910200046.30df2803@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5903:EE_|MN0PR12MB5739:EE_
x-ms-office365-filtering-correlation-id: b53dea1b-05a8-4677-2afa-08dcd23c4302
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Zpaid0CpgCFzFCpIg2LF8VgyYenxfEglXkU+i+Wwq4kJoZK7o6IKnuXTa8ei?=
 =?us-ascii?Q?LCauWTym2CBpNiMIeoLjgKhkx4aUKFS5SF/LF8WmU17OpjespH0BU/Rz6rLX?=
 =?us-ascii?Q?xbMneXW8vdQMqkHyW+JZtVAVVncxHWNfVlWteYaQPGJ5lHkcgFckVDjtW8sP?=
 =?us-ascii?Q?RYIJvaA2fj1cXBzs1t3bsSdcKaI0fJyy700uP2jHmkvw8HCQypZV4UYoVrnm?=
 =?us-ascii?Q?jyKzQRC4I4/5gREmlxW3UYSn3Wgrcf6SQ72u8Un4L+2KONU+kCTHeZV8omt8?=
 =?us-ascii?Q?LKPeuwVhg8QR+NoBFBXdv4JzPXhrkJSor4NSpsa+6GmFHucftA10HUqtfxzR?=
 =?us-ascii?Q?BCwJbSwRaFrN/TFCoPKa/MvSR9scV0WGAW9lpZ8Ra66Ckcdr4bREfnVyawRX?=
 =?us-ascii?Q?sCu2NwDj4F58nNUJqLBAiIcSjJvCwM0y6oy6fsAJx3kfBPbxVp7EyatPCi5G?=
 =?us-ascii?Q?hCICjzGFlDwJtBNaMWQIVWKM71j/injghvHMNobmSZiQdk5Z/XoUHeacM+6m?=
 =?us-ascii?Q?oXtFzviFZcUpx56T7iwDJ6aVjeXSQh0JCa66krTs+2OV+dqT3/qMS2IGWK0Y?=
 =?us-ascii?Q?FKQf3dzRK2i1mrtuS8tsfNfcXSsN1Qp9nuJm/vHNIAmGtKHFnQot0dPKLGCb?=
 =?us-ascii?Q?ulLpWYQOgLLZkBCuwWsNE1X10uL0FADTaOKEKB+jxacVXedvsSW9SqxEVNOX?=
 =?us-ascii?Q?UcFJ/TmdXABV9WQuDdGoDkfJbOu7/+7SgelhCSomd5fKzEQFYHCwY5ORDhIS?=
 =?us-ascii?Q?Q8KqqCHDpygRUSo4bu+EKlQN20pkvs6bX2V3szxQ20JQz5s0blIvt4G/U3rp?=
 =?us-ascii?Q?wQKd9BlBwoJqs3pzravA6ByNPk4ZU7pOB+KA+4co0Jf3d4G5woXCdnmFrsc9?=
 =?us-ascii?Q?Qiprs4oYSJGOkNLCgY/NsJPBY7h1zvotiPELe5LSSH06vcJT0vsmdWjQm9Gq?=
 =?us-ascii?Q?N3ssZMepowhWnKvi3fwlB6LUZ3p2QkKFg0Qe/I3ey8RpWJ2YlKgd86/riIE9?=
 =?us-ascii?Q?1tOOMlxEgxUvy6S9B5A1aJF/P1nw0TqdGm+X/Nl4XxcwhkX2uPaaoYqoM5os?=
 =?us-ascii?Q?/Ob4N2JIn66HlkQrdSD6wQb9eKFBfZUq1OCN52g+T/LxJVkh6chsuzlAHDR3?=
 =?us-ascii?Q?4y09My5c+2+QRIuVnH5Y/cXHxCRHh9WH+CocJArAhLxsi7AynC4dGJmRZWYE?=
 =?us-ascii?Q?Qb4s0b+pYlJl71iHmMY1CjaAXjw7a7eC+ahGVUBa2qtL69O4kRjelZSGyjAa?=
 =?us-ascii?Q?XbVG82T/zW2guwNouvLoki/5XbJUNwKt3LcgHeOBlvPuuN36sdgghpxPyVtv?=
 =?us-ascii?Q?02zDbyOVkHrNB0uQwOSB/FA1PIs9PIsmVFbBxaTkYhb7yI9dnSOGlwr2x1fK?=
 =?us-ascii?Q?ALuJnWJ0F7OK1t59e48jIZlHvGZh9ZJY5oVYrSLbcL/EcwRzGg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5903.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fnfb54lLOBgoMRipwLNZrENBrPLeNr4E2rJ5JHHp3S2PactVYgRjbGguzA6w?=
 =?us-ascii?Q?tFLujcVAA/bTp2aOjoVDZquCC8wT4uHtO2nr/C+GiVMGMFZyyAU6ZknnddMF?=
 =?us-ascii?Q?JgKjJspwxEQvmg8sLU4tCU6Ma5KHXDX3Vs1rn2D1kxuUx6y5E6YoYNZah9jY?=
 =?us-ascii?Q?wGYljGZ/CGQ1HyUGmFv4rJn+fmwxUytdvoOskM1MzmWzOFRvgt1z4kboVafl?=
 =?us-ascii?Q?XomxNAvHiOStqh9yD4h83qvdQyKK30ggkl/iWLh3IdBnOR+kWT4cmmfrtI2o?=
 =?us-ascii?Q?uqubg9ySdYP4Gdmn333etK3TM3w0I/AzssbzsioVJ7qQ9+S9yHEzSmkzJ4g4?=
 =?us-ascii?Q?cE3WM4IHXNbkWwl3eGoH1047rMlw5i1TgWUEwiDHPd2USyvZHqt6X2Ijek6q?=
 =?us-ascii?Q?V0p/jvzSPycxH6ka59FDxec4MocY1VbVF67e2qTiDB5H/gf9gOfZeSwmd5hj?=
 =?us-ascii?Q?Y7AKj4ZVdm7xEblE0iBU5XE4A2uScIDpoZ57Q++8MmbQAlB7/KblQRlaRJ9o?=
 =?us-ascii?Q?g7ZYKcBatqktspRE+yRel3emuSXO+PRpM3DR4RkWsg0jqehRzC/7ijGb163c?=
 =?us-ascii?Q?CK4ADUGc2Wq0g+ZkjgAGHlY1SprzofOwSY/2XJ2ZIFp6eqQAkAXR9DNtKBfI?=
 =?us-ascii?Q?yma3qQZiie+DI+e8qczljLz67Wz1piBV36jGX2pWtBaQp891ZU0ybYIRL1Na?=
 =?us-ascii?Q?otktJ2mmYvoeum8Echs5++Dqae2h+prchQi7r61eIzONiWy368Y0yBjJsw+v?=
 =?us-ascii?Q?8K3njLikNO90NMFc4AwXgCDYywbj9Rs4urWVlpqA5R9Af+79VSY2X8B4doIf?=
 =?us-ascii?Q?+9tz3IevUflBFVnoRt/tEIWli2ufVLGMVk9fN1Pt1dxj8QF+To+Qj726o9hq?=
 =?us-ascii?Q?U2bqz0FttzvQHBb2dZA6fzejmg3EeqsCfb+4UeQuTTLwqQzeoFfPkxCElme2?=
 =?us-ascii?Q?lVeJn/z5d8Tllu6jHnMLO87rP9CA3GuDrvGefwoSBTbPLkSo0dm/xeWLxkv+?=
 =?us-ascii?Q?LvbinCmA3YQjHgHWO+mirXIYXMmDtVsLALIjeHMrIPFHXgOtYoxwjGDw3jM8?=
 =?us-ascii?Q?FvkJ9aKdVUBXlTp/k4/ZFjWnffdcv/6KMf5BIapEVwXcBQeXLebHOBmyTaOd?=
 =?us-ascii?Q?NLItQT/t6tDCAX0z3QLbwlrFb7Q5ZUtF3FVv6rklawtxq1qlUEvy/krPc2eT?=
 =?us-ascii?Q?ixPyBEDseUzIyWnVP9GHA6hi9kTuK+j+4voKx1+KPaudoSB73GzDwjWfA0wo?=
 =?us-ascii?Q?pC7d9llxnxfG7BY3g7B5CgpVl5lfwmTUhGQhs7w2yf8K5zu9Wen+4qnzLqGv?=
 =?us-ascii?Q?MLXUiPQMeEVhM4J7MqfOQy9i4kcrdoAk0Gnl1NrvDjEGJinkalIv6yp4AOJ1?=
 =?us-ascii?Q?GC0X2Fb4VPnOIS5zUqv7+ebnbGWFaOMTuEwzp/FxQv6QWNfKV5XH9B7upnHu?=
 =?us-ascii?Q?72cwZOq0HQDMMUEPTpap8ApN/SRAEGAf/k0xlD1qSOYZhpd4P2ZPn45ejfBa?=
 =?us-ascii?Q?6sd+JZ4+xXNVoRF3xdPL+RvC+u2gserhQktOSWmLmF5CPRdP4TOQMaEY6iJA?=
 =?us-ascii?Q?NDLHmqaKqiA2sLfc/KzZn7Wb1Wvgqdk1icB0H29E?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5903.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53dea1b-05a8-4677-2afa-08dcd23c4302
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 08:32:24.3497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjjGQNvooQRhXvBhBdXyWbEzvXbeFVFx41Tr1hSWDOsIJCgvAzJERalZ2WwSFlPTXB838RN451L3HdiCfweesQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739

> On Mon,  9 Sep 2024 11:12:48 -0700 Saeed Mahameed wrote:
> > +/* Set a peer context, each context can have multiple contexts as peer=
s.
> > + *
> > + * @param[in] ctx
> > + *   The context in which the peer_ctx will be peered to it.
> > + * @param[in] peer_ctx
> > + *   The peer context.
> > + * @param[in] peer_vhca_id
> > + *   The peer context vhca id.
> > + */
>=20
> I'm going to pull, but why are you not using kdoc comment format?
> Would be great if you could follow up and convert these.

Will do. Thanks Jakub!

-- YK

