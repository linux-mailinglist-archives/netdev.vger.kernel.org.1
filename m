Return-Path: <netdev+bounces-127380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22839753DE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 286C3B22CC9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32E1A3A8B;
	Wed, 11 Sep 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KCFl3nVF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88408190667
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061152; cv=fail; b=d34vLK0s1qg+Nr5jCIQzokwwcpi+UT36vnsUyhcL8kDt9sb08WKrmADCwXvi95sMk3N1CL7ZhlS39mZxxY/ZlB6XMA2wnJdlzml3xATo93PanXnV5bHTKNSw/KDMBVY3btoHc4VscsnY6F7TONr1KJaz0pKpk1DvyR+Fjgku2GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061152; c=relaxed/simple;
	bh=zSECs6q7dMqYzFgftSWtgPWjIQfS2rlx1HgdgGcAC/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FBsWq/3aOPJadlbsCQaHcspoNoRswoT7aA0EcrIX1sV4Fi0+s2UEgPXysIZk1PfvOVE1u2n9iskZKodeniqQ4XtppcKv6/40aN5qZBBw9pUHWnQPk8ulZbfFqWrX7BK8gQU5paWA8CgE81ZdIET5wO7mkcUUg46WpRN6UgsPlb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KCFl3nVF; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uszxul0IVVoWd23Z8U/2HA2lc7tHFe/hmOdfuUjWjhbMfUHETADtbf0jkxYoWaNLA+yT97d8pX1gEFMIn3/uDBRN3dzFNqTOek7txILXmZQU0gi70XXAKIRAXin4XTGFEQOd1iKhsXZFUv4MHGwXuOIXY+qvwRfG80BIJy1nOTOBk7Mla8rSUsMRl/jQDEuT20rt3k9k2ZcQYxM8gNkNeg7xzWeBZpzHtnVuTqqc/rVx8wTTXisJoV5OOwk4yvq2DWiliaepqgVxYPnV8I2GVgeyzg/jiqYZt0qutHTMADgaucaNRiYaWULm+cOJkFUpGaJv/A/8ifXaGYh53ymOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW9SR+peIEUL/mK5NWcuq1gFqpQuVNQIah1dY64+0BM=;
 b=qNOw7A5z9eNPuSQwx20wJR48Ao0GPtOrGGrr8Mc3V0a3xFsiRlTlwjB24jegAOjXGtSR0nvi76yBUMK5MHZmu9YdXlE5lWquzuEyhCr9wUBGqEuLD6dqZuHwlqTev/kBRzEdRSICN0wUjFpzItKvXGBXhyFEZ9kYVKerID+z9JvMYY3tB8+Ycjc1wuwcp2BcNzp0LmyX1fMOBHyg7wABo8rnk7HYuj0Batm3n7pVPUFvGzu3VYk1JTlMOZSUkTq0iEDhJsw17flU3iwAzVZYwxvxlXk/U4JJSjbmEkq/CuWjSEPsC4espthQKR++e1QYqIzOikCjz7dyADZQWr26xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW9SR+peIEUL/mK5NWcuq1gFqpQuVNQIah1dY64+0BM=;
 b=KCFl3nVFjss0eB2egs/RxMJXgNwo5tzBRwLJyBQaJ6mZCjQXIlCkS96P0r2f1V9G5/o9ED973gCkNNhhVxr5246fcAOGSqAE3/x97Whnwq3qfCXlP+ktZk0uc6eaUObntPesyINRfNPQ3Ecl4pq7xYjJySr8lrlUN1/X5abFZrso80wUvEudKB96G26rxvFd2hu9Sxc3dzQM0r450VhW1wIyS5cV/j7WNMsN4EMM5toy44RFxH/FWSvsHDHTZ0PaQNjGmVbnTP3jEH1a/hquzhRu0hi+7SjsDgvlvomenNG9k0KoDgnJK8b/3Q/dRGs8wC2ksD8JmfoyR4oGf9P6yQ==
Received: from PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 11 Sep
 2024 13:25:46 +0000
Received: from PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe]) by PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe%4]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 13:25:45 +0000
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>
Subject: RE: [net-next V4 04/15] net/mlx5: HWS, added tables handling
Thread-Topic: [net-next V4 04/15] net/mlx5: HWS, added tables handling
Thread-Index: AQHbAuPs4pdaOELryUGYv9Q+ko6ig7JR5AMAgACx+8A=
Date: Wed, 11 Sep 2024 13:25:45 +0000
Message-ID:
 <PH7PR12MB5903E31CE45DB93B2F63FA20C09B2@PH7PR12MB5903.namprd12.prod.outlook.com>
References: <20240909181250.41596-1-saeed@kernel.org>
	<20240909181250.41596-5-saeed@kernel.org>
 <20240910194710.668b1ff0@kernel.org>
In-Reply-To: <20240910194710.668b1ff0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5903:EE_|MW4PR12MB7165:EE_
x-ms-office365-filtering-correlation-id: db85a7f5-9404-49d8-6613-08dcd2653de0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/kqPlaeq6alG/fvLC5p3CzBsTrvTy3ubI2CdTABBJrd922gIS2SzL2ZXiojJ?=
 =?us-ascii?Q?i7O1UYc72Bas2c0JQIiX5bVBeBkrt32EpbpEVb35gP8DmY5Cix7Ch+8CkC+i?=
 =?us-ascii?Q?A4wRShJKggZvkZuHGvPuZ9RuxOBwAmCyC000EiX6VugqImZUxD3WkSh89p6D?=
 =?us-ascii?Q?BTLb2D1dC7QfbFnuMGeXZtS2wTrI0EhREy+VSrrEgxYMDSMYH/4tt7zB5bMr?=
 =?us-ascii?Q?nepZOtZCdNBJtL7guAFoA/1JDKLADTQSiAXpD9xzHNkhB/T/gUljoh2XqSBZ?=
 =?us-ascii?Q?XWZxLkW7ZVr1ccO5AqLm9NPvy7MMKJNcdZ5f998pidnOO1SnkKowf9YVvc//?=
 =?us-ascii?Q?fKqWgFBI9Udcz6LP+v88OUPcEepKQ3bt8IVM3oGV1cQCie79ZZcqJ80Yb2be?=
 =?us-ascii?Q?m9VPeEHqWuVSdeaKvEbCjyZy/iBpA9RWsWR3EZGZmzhLyE2yJVH/mNjQxP5t?=
 =?us-ascii?Q?pn2qr1XUs32XKJ5rS4gpe8YWXvBJvjJNZ2MiXUvrMW6KfQERvoP3juXSRHak?=
 =?us-ascii?Q?ao7S/U9JWkVZm2UjuYaU30Ve0zHeYRmhMXiOYMFEisKYLWwRBQwZiWRCJAzy?=
 =?us-ascii?Q?0fFamKXzQtt68NoRQjHvtCQrOr7A0nVyQfddbPG0SRVbzYVzNNwbWxrmambb?=
 =?us-ascii?Q?GzP959xy5CdYh3zrc9VvM5124WFSm1u1vt7lmarFCe5Y29CPs6dGZfv6ibPP?=
 =?us-ascii?Q?kKJfJIDBKPfz5dwNIAMcoPbfA6aZRZ4LK5AD+EEH2FnyIjHuNdJIrfjrOczO?=
 =?us-ascii?Q?WTkDCzIUIegBu7Lpv0pjqQ0fK5aRylcN2116Yv4VzMC6WJrCQtboWTeVJRbM?=
 =?us-ascii?Q?TMuI1WQodu47IFyOh7+S6Wi01Vda75E7ZTZPoi2feFkT4C6cnHFcc6Lbpw+T?=
 =?us-ascii?Q?sShgLbNXRR3Kjlodb30Z2EYPXQzUfJkOcrAFtAxmI1akqHHymLEnkSqHHYnx?=
 =?us-ascii?Q?xg/eijyJoQ7f3MjBScoHgz8ABYNe0FQOLNabTrzb7BrjgL1VTZOMD/8nWAJ2?=
 =?us-ascii?Q?qbpm0+H4i7P4zo90T37ZvvogX8SJhEOXldPQiFzc4gR9sAVrTUapXQyK9ZyI?=
 =?us-ascii?Q?F/YaerfcPPgVSlbQumU8ue0HXIVl8qCfC9s3u9wiTJA4cByMkgOzRHE+MNJW?=
 =?us-ascii?Q?u7hb87UGaJqJSL0fVUtWZzKH3nAf9dl3e1blwePIhG90eIo9DAe9Hm6oWeoa?=
 =?us-ascii?Q?rEsDajxhC4F68aNLgR3uqkq+VAyB6/o/vyuJeWQPTLmvWfLGgsbLXM8d1TIQ?=
 =?us-ascii?Q?Jq/9Ac2tvRALcp8DJMBxmfLyA98pFG7nqe6jgmeii6I3oEhmd/JvdhsfjHWr?=
 =?us-ascii?Q?hDkheMh0bkikUretGhxqMQThNtbgWkaBUvg6Lbu5Tw3gc6WfHwT9P07hmUMk?=
 =?us-ascii?Q?PYdO7TEdn/xZZCTNnKoQG9t9Cq1CDR6h2YHSUUMmDtcCRy7EdA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5903.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wxgg0ChApzA5OwYWAwXV71+siNZY/pzR1kblho7g1BSgaRQxGlwYuNOVNor/?=
 =?us-ascii?Q?gyVo1oQI+6NUuA1rXd7VUR5Z7/I0UBS+uHYhy9M4b9m1cTYD8mVIJazO015E?=
 =?us-ascii?Q?RgWCnCartJCcRkowSuPsD009nusjC4VNil12a5TGXbdyAAVvElGknQQ6ZzW4?=
 =?us-ascii?Q?rXIrXuShLe6jdX0cHDorUeVcmRl4kEL3rSeo8tAZtbEPP2ZjLNWTDM9JMpym?=
 =?us-ascii?Q?Adn7uHiFzZLP9Su/9ti/1zAITvwxsggda/UL9bTBLzjIGiDwcLzXF2YBEkXZ?=
 =?us-ascii?Q?n6VSYMFk0qRKenCLQYx+vQHHLigzX7Nlbs0mPwcAfye0LGPOKS3a2XkJpTdG?=
 =?us-ascii?Q?ZA1/Ji866guBwwVI9HNwq542w8y3VbF/qz5bxqeUrO2IF23WgqGo+bf63zHp?=
 =?us-ascii?Q?38liXYPtacH1n0pY+HmjvF9TcAFcthAKuv8kQDh61JnAxmKn6rAFCzuRSq1w?=
 =?us-ascii?Q?SYI+23xWER+R92PGxttEufQVCD3Z8VjllIc37erE5d7Y+oBpZTXRZblrnznd?=
 =?us-ascii?Q?lQHBjbyVAzJE5e6hiCDV2ovz5dQcYicgD1GhfLuxucNxzx7Yg0RXcyl/kV6d?=
 =?us-ascii?Q?HCF4j9kYxIBEcj9al8ioGUQRBSPIAWBu07A2123Zid/U3PDEjTR5TIzbm8zc?=
 =?us-ascii?Q?1Oj3P+siGCo6R0XE2xx5YP0aSggkXAb0+Ix2uR9B2bHOUkEFHx5+NmXI2/cs?=
 =?us-ascii?Q?ooN3RqUsaaGhlXmp/SjCotwiUtOIjSgtEUaPTFo7F7opVnmFm/txPvxOed7Q?=
 =?us-ascii?Q?9i5JJYCu4gPBcWO8ZLTo2c78e55FOvukea0r7TUd8OJYLKgqV9RHUxQL7uuu?=
 =?us-ascii?Q?Kw0MsUUmIuzTmfHsLl76tsZlmaS9N06SzZ3vwRqotjag9GeOHijd4lj3kS+0?=
 =?us-ascii?Q?aMA8MHuTXUPZcuyfZ0MNFgy1wK2jKyLNw76RXKNrr3i7s2PTBwEB0BvufXj9?=
 =?us-ascii?Q?DHQDw+bjMkbXGTGp5UVw3A/Lr4Z55LxneV60a3XFzRYNEmL15UYftGEHjtZH?=
 =?us-ascii?Q?xXTuFW5/BHA9MCYCDW4zFXS3yO36LJB2aC81uVFFXDIKGL5PpXrQ9OO8hLkS?=
 =?us-ascii?Q?ndbigTjI6iSnNNRFvt7BIvdvsytoJPux+WwpZtMn8AJaMw9ctcUolCWw1vxs?=
 =?us-ascii?Q?nb70EuQiKvQ2hJUQAeGy+1Tzq8WDG6McmRN7Y98F7aD2+xTvWGKfbqensPeq?=
 =?us-ascii?Q?1tmVnH+wbK3414FApdlDqdp/6YW1x+VJRH+M5MO2W/aWzPvyd4IF5Br3zWs9?=
 =?us-ascii?Q?4JGEE3PZKXNGWHs1x93nVQiAsUJSbYmTCmTKUEJIuj7B0/t9vKV4Zg20izgH?=
 =?us-ascii?Q?X+OBKjsb3I7J0aZ1E85OzVNyFpk/srpAHuqF0Ch22rdX4qBt0nhZuGqT+rKB?=
 =?us-ascii?Q?utqN1hskoEz5mWDsvwHPYvUs9/uy9sM8aCagIDUXMjjixvWVppYIlCJ+4nJ2?=
 =?us-ascii?Q?OJIPCZIEEoOHPeOiEYMrtDD9JGPAQSWxdWMDq3qeUVwR90dW3T3JqXMUCzZi?=
 =?us-ascii?Q?T1FECkUolnU5Vq7w+KvAF6RkunECo0lsTsMYSNEoGHW72ICx7gb844B496zD?=
 =?us-ascii?Q?nnRewkt0Wl+bqJSXIu5TUYH/ejVQ83Twh+bXSHLO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db85a7f5-9404-49d8-6613-08dcd2653de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 13:25:45.1004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXXUzERM7PFwLOFDnIRkd13fgNRS0frpvWxf0Zk1wWDYOc2BTLeDV1czmw1Fl1j46ISjsKBccQh66LcaQqsy4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

> From: Jakub Kicinski <kuba@kernel.org>
>=20
> On Mon,  9 Sep 2024 11:12:37 -0700 Saeed Mahameed wrote:
> > +out:
> > +     mutex_unlock(&ctx->ctrl_lock);
> > +     return -ret;
>=20
> the -ret is on purpose?

Nope. Fixed here and in couple of other places.
Will send patch soon.
Thanks!

-- YK

