Return-Path: <netdev+bounces-202703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D11AEEB5B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 02:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D511B3B64F0
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 00:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7943813D8B1;
	Tue,  1 Jul 2025 00:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="usxlwlk0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95CA2770B;
	Tue,  1 Jul 2025 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751330662; cv=fail; b=Sjmy8mIRFMZpm4D1b6/KKzCEUNJZy/UQ29geoPs2NNJGPimXyiO9TruhOr0DKbT+NbwdV9dD5P2Mb3ykNYcbPjfJ/NpjFlSP4PZu0QXZqst8PxJfb5rptD17SnmtcP4nBDHOGNWnBYqlZjZUFVRJfuhpZD+Rc2GttauUZmyOBrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751330662; c=relaxed/simple;
	bh=JUxY7FbzUo5igv5Bb+fSB0QPHBu2Nnxfdoh+IWgZoEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tK47OAcJS6zb8QzQ3i0Gqbk12fZYUWH5GEHkUongbveUO5fkZX62E7+3Ql7HWga5dPTel+ulRmNH3o075bVoU7jt8F5XJZVGW2ggAqAp3JVnfpOG59Tb7nHShHPtXuhfKGkvftaWVK5pAR1r50kbOe07bgMa3uJAjmXMC2b1fJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=usxlwlk0; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frNt2lAt2XBG+FVI0QGGBkCAKmiegZvCAeu1OWccTCe2+YU8MqjoAb/6jo+7JqGeSxye+caPc4rcZ8WWmnqFsc1vIOh86OSDPA+CoZZ0bFgNZwFH53zDEELoGm3taSGwOjENTLEjDvsKnomCkHxISNgfEJFHxXXFt4gzgvyA/WKso/U9JX2rU0USz7PjhbcY7sp+5Esa7F5rHUaHmS3w+64AJBJxiXapu+jkTYnG9dMWWXq5ShcVuot5AmUXWQ3DrR3oozsMCVC4y6ruhZzq+P2z2ETKllW8xu6P7Q0rtjxQOG4dY2Z7p/UuAepvoQGGp1aw+oBsZls52vFScIde3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUxY7FbzUo5igv5Bb+fSB0QPHBu2Nnxfdoh+IWgZoEQ=;
 b=uqDZ0aclo0RDJ9uP5dlpMSjyeATO/Gl4TS+/JidPzW9QhLGdzAQ4bN2BzgoTUiS1ADigoPv1nEwjezmJBT5JA89tKPShGT0966hBTvwOAXsxN3CpnnJmieb/ri+K1Q+0U5nYqw1gkJ8C+CDFWq9VHxUakR4xpkMcOA88SHJfl5zz7SupMor8mfaRklUMkY6i38HftJ/+9IGvmq8zL63lVGI4QqgUuBuQzBEzQMIlJj/fcukDmddWNH+IYqYFL0PgzyGgmnRLKoq3+FYxkNlUehIPTiEmLpZUZCARi/5MDERr5tVdfhiRY5ebibNZ/McdFhfsjpmjM+aS4ChwU4Iyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUxY7FbzUo5igv5Bb+fSB0QPHBu2Nnxfdoh+IWgZoEQ=;
 b=usxlwlk0Kt3jtlqEMOAStjoaqdLzLb0zl3bTxKRY58Pfn0s/kbK6nCr72atGbCslmDLdaWpEy1q+mpS9iVNe8Tc4p2KgocaPvql8FnY6Po/m8eEKDe/yddTsXg7pFi8nQoyZIJ13JXshj92BmGnKn8iuQ2mWXI529jLJbUM/ECc7kYpBQUURk9IkamZLb4QBCLSYYrIu2lTLS6sOPOMU/etqwbSkPdp5kH+shALg85G1gkWRG7cbnu6+6yiMudW+tIwV2Z+x2+mLoxD29yr6k3itLAkJEaLEyRlecwR6l2OUCJIOrEwYeFio2VECHued7gJpeWXURQslxUXHnfR5Lg==
Received: from PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 1 Jul
 2025 00:44:15 +0000
Received: from PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0]) by PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0%7]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 00:44:14 +0000
From: David Thompson <davthompson@nvidia.com>
To: Simon Horman <horms@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Asmaa Mnebhi <asmaa@nvidia.com>, "u.kleine-koenig@baylibre.com"
	<u.kleine-koenig@baylibre.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v1] mlxbf_gige: emit messages during open and
 probe failures
Thread-Topic: [PATCH net-next v1] mlxbf_gige: emit messages during open and
 probe failures
Thread-Index: AQHb3IqcCkGbdgcwWEiYqq8tLXsStrQF1AYAgAACsoCAAFbmAIAWW5hQ
Date: Tue, 1 Jul 2025 00:44:14 +0000
Message-ID:
 <PH7PR12MB5902AE4A0311CA4B47F02F8FC741A@PH7PR12MB5902.namprd12.prod.outlook.com>
References: <20250613174228.1542237-1-davthompson@nvidia.com>
 <20250616135710.GA6918@horms.kernel.org>
 <ecadea91-7406-49ff-a931-00c425a9790a@intel.com>
 <20250616191750.GB5000@horms.kernel.org>
In-Reply-To: <20250616191750.GB5000@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5902:EE_|CH3PR12MB7666:EE_
x-ms-office365-filtering-correlation-id: 998133d9-0aa0-40e9-58a4-08ddb8386764
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jb9gdpV2rU95Pr3amKl1JNITPtWZdWBJgXkC++UsPNL3qU0k/gkdz6uZrwk4?=
 =?us-ascii?Q?NOd1scxQqsvXqVOV9Vy4CSRW0rsNAu4n173NV5VONDjhiR5LjhkiQlym9vW1?=
 =?us-ascii?Q?0j9PkbyngV4Ia5CVkXnquVMx0rxSl/V8WdRDw3qxZA5rukhopMKHsqj/Ex4h?=
 =?us-ascii?Q?F60F5VNXkt6bjxyRIuJRFtYJ09pFjJDEzJczc0gS5yotxHmQeO+GvRLyoIyP?=
 =?us-ascii?Q?dAiCUUrWr45Mdg6gHxH9L8CrL2SFviW4tx1qgKBuOUaw0RTpYGq65vMxH+B1?=
 =?us-ascii?Q?7MQctfnXIzCg3SAaBiAI9Y70Y5UtIoBTyn4ulaCOacceAlmR12MF7369yIUi?=
 =?us-ascii?Q?HiR3+v4jihyHy+wZtxQp3giq4hIIU5SwRcbcgQUnIC/jGMpL6zbWUIK64t1a?=
 =?us-ascii?Q?WLPKUjMtQXfp/7hfFq7GZrvsTXcBUWCwoXhgeT1Rp1mGFLbaUxyQckh8krB1?=
 =?us-ascii?Q?o+AdxhYrBtZlFqV6IHf29ifqOWtAMBqr0cPJArpdjvDhZ3ui48eWyftLMYKk?=
 =?us-ascii?Q?iL01GsnIlXAJtsFeVCf1ZClYLL7mPBcvy72gHxcT6ULdIsmBKkQKJCuI9Iu4?=
 =?us-ascii?Q?zik0Pji16xsfic0cI2TIzq746jv+qho1VcwWlVEOpw9J9SxkEEFy03jJPoS6?=
 =?us-ascii?Q?p4FOmWdpPG/sCkIzdFDyme9H216yAyT0uiTPlEjRwtZ0uADp3XmMwkI+dAqp?=
 =?us-ascii?Q?oPuELPCes5pBZciyuR3t2zGaSGMP8Jb2F39A0vikJZRUTXmIKtHZKZozaqVr?=
 =?us-ascii?Q?Ci9NBWBGDvuMj78dqNwavpDukiVxm8U/brvurBkW5vypVmRo5/RhHbEfl7DN?=
 =?us-ascii?Q?ptaI+Qf6EfAmWV18dwTcGY6pr5A4gjrbr5d5N+hqrwPX3/mfPqdzzqSGhqPF?=
 =?us-ascii?Q?ncnRJRSO8kQBYaWgBQ3CpvxAPrOARmPFn2Ndjh31jmQlqnesAavAZqYa5yZj?=
 =?us-ascii?Q?/FPErpR+XXy3qgnAma92SXfpDsS+XgJxz0t0U3gsyrsHBbLSTVVXuR66qzDW?=
 =?us-ascii?Q?+15vh/48zXoVo51wBtRz9IVpwLKNAgVKEOdVvHyUO3i2seGkPRntLGIqkBL5?=
 =?us-ascii?Q?OEohs611++Vy8GqqNjMsTZbhZ06KlA8PKbg8aKUSb5IlRAcOUfxjePYiBFD/?=
 =?us-ascii?Q?ux+jiGZYvgXfP6ogG/GwncF9ygPvcPpnX5T+mYdE+br+jx7jnuwy791TKNLD?=
 =?us-ascii?Q?hK2h6WkehHHuzufNm7Rx5ELob1swXLHbeOHPo8jYwbd1vTyOdioKFwFH+MNZ?=
 =?us-ascii?Q?Uh3HQcBI3UkYtAyZkA4xdVRsRak8GRjJGF6m+/REqGEN3Y3Z8CKtIDq1J/CB?=
 =?us-ascii?Q?vGue9nRukWN2uHSOt6ehmWGW7u4pGfnw0Bt2k9v/MgqqTXhZmRYPbkzhvpmE?=
 =?us-ascii?Q?Mh4hT923t0cviwDQ2e1LblM83qsfTefkNKOsi+XiUTvttasYQpaUHZHM2ZVG?=
 =?us-ascii?Q?UY57s2FTnwNQ6g6FfUlR/Gdfk4CNUvGLoh5Gt9Hq0CWfpF1kURuuoQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JUdByLlzxBYhV7RUKmR4Wq3v2seSgsy51t005nE0Ii/iapHGRPc35qQIEamS?=
 =?us-ascii?Q?qI8XOqjgOUUH7gwUSx1hecLrgzrGZMFHlNno36pFBd47G4EEcGGWc2IKB7xp?=
 =?us-ascii?Q?owfE4y8+KKQU3sWHctPeE2AAqF57ULL73VmvT9pjtIn4V6368KjtsTHcPgpV?=
 =?us-ascii?Q?imBszCdlYCDKOWjc+Fp4O5GUys2eQAU2turSf5biGk51XkwhNJXijie359Nq?=
 =?us-ascii?Q?EslNHN9RJf4D6K0KsHVvJPGNgXndTi/KIun35PAslfsAGsauHXBuJYdlpZD4?=
 =?us-ascii?Q?1DlFXZqt0L8EIJCV1QR24gd3Tm/kZIa7NEBUrJRwjsbsV93MA2ZOppL+5nNS?=
 =?us-ascii?Q?3e2uYIzQl/VjbPus/rEy+uGAjjv7U50Q+vENf5PVIEQWeMcbDRH0FpF0Nmqn?=
 =?us-ascii?Q?Z+fHSxlJRQ8LUPyl5PHT/Ul9st0zKp2NkuBvsWpSP8plJwHXyRfk2ByIKusP?=
 =?us-ascii?Q?gv75frgCJn3LCOn3Rt+7EyafXDqpsg7q+4CUND/I/p55vIi6ZVZCpIwPjgdF?=
 =?us-ascii?Q?jVX4f2AFcIbuZHyyxRX5oFmSAOM5Y8/Z/Ds0wtFocZVEU60a5MNZIcs93ghN?=
 =?us-ascii?Q?rzfC3EVJQ2ykZ9O33FK1HIV8nCDMWAdZ1Diik3DdXz8ZXMA6DqlCOUc8B3By?=
 =?us-ascii?Q?F0rMaz/3HclBt7+/H8ZQZqDiZ9MvcR6TXuJWjWcs3c5bljQsommz7dmiJn9c?=
 =?us-ascii?Q?YnpFD30ssUc7i6knzO3FGvsW0G8UDUzcG82E5WKQLkTxPd1/oBCGnd2PVTKD?=
 =?us-ascii?Q?x6fxngROQpO4lNNgu7nvVcRPBpKKS0800eb+Qv9OSNRUJ63JSH4lXBOmxyjh?=
 =?us-ascii?Q?w47fg0tfm0qAs+BRI3BrEx+ZGLtWx4TfQYvJ0XS8snuXuSdupYbrR/r8yUav?=
 =?us-ascii?Q?KjeprBsCmgA4Jdw0rjso+rRZmaS7ht1xt1hFXXbkGzKpqL+7EtVAee7KmL5Z?=
 =?us-ascii?Q?+MmXp6RSgvylT7t2jYLfZgt8PCsn4zFO5TiZi7/W5S/3lfK/rK5dABzmtYZi?=
 =?us-ascii?Q?FYdx687YZygav8hywq87Vir5NWMQmjdQLuL8gms99YZK627lARf9y/tLayJe?=
 =?us-ascii?Q?5gh8p++l4S8KxdrzbE4At0P7abVk53w6D7YNJnMWA899DOcdhSIPO0Vt4QdU?=
 =?us-ascii?Q?74ADOrL2OOyTE/jCsHmfgvnnbEAdpTfRKkwBIS2T2KyuFO/UA9+lirKxZcIz?=
 =?us-ascii?Q?I+LjvVNWru4MADt4eewgYAMOJGfNzT6uEekStePnt14xpfhoRV9dR6C1Td35?=
 =?us-ascii?Q?d1a92JXfUrJIF57QpuKeUfdzdug16MUPVDr017kB46xCBKeUgGyOcghiegZd?=
 =?us-ascii?Q?mD0oIszDlmB2hygMf5CONregg2QKsdtRVKAgUZWw7M0rnmgb+j5xi9CXqXGZ?=
 =?us-ascii?Q?6EmIQSJDO30J4M6srHOYE/5IRgNAGW2fQE4VI1GltplsD6Iqx1OhTruDqgdb?=
 =?us-ascii?Q?t470uWpK2Ct9C6zCV7ZJ9WCmfiZqm4FJMLpzqgdPB5hVqEyp8WOZZY/+Unnn?=
 =?us-ascii?Q?c2ERbhkpwWFkVvBcG2m+w/z9kxQ1xbN1asjb4Wumd4I42l2/LqjLZLqiQiUk?=
 =?us-ascii?Q?HzxMcvYAKaY3750OwoxIaFTRNonKkZaamcb/uOET?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998133d9-0aa0-40e9-58a4-08ddb8386764
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 00:44:14.8590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3EgkhTMlL8C8i3OizphEuh9T5axev6GYZTEM+QmMyBMQQFk2Iev6S0ohyGzkWTH9tawMa4mcEx2Cct/PC4HKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, June 16, 2025 3:18 PM
> To: Alexander Lobakin <aleksander.lobakin@intel.com>
> Cc: David Thompson <davthompson@nvidia.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Asmaa Mnebhi <asmaa@nvidia.com>; u.kleine-
> koenig@baylibre.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next v1] mlxbf_gige: emit messages during open an=
d
> probe failures
>=20
> On Mon, Jun 16, 2025 at 04:06:49PM +0200, Alexander Lobakin wrote:
> > From: Simon Horman <horms@kernel.org>
> > Date: Mon, 16 Jun 2025 14:57:10 +0100
> >
> > > On Fri, Jun 13, 2025 at 05:42:28PM +0000, David Thompson wrote:
> > >> The open() and probe() functions of the mlxbf_gige driver check for
> > >> errors during initialization, but do not provide details regarding
> > >> the errors. The mlxbf_gige driver should provide error details in
> > >> the kernel log, noting what step of initialization failed.
> > >>
> > >> Signed-off-by: David Thompson <davthompson@nvidia.com>
> > >
> > > Hi David,
> > >
> > > I do have some reservations about the value of printing out raw err
> > > values. But I also see that the logging added by this patch is
> > > consistent with existing code in this driver.
> > > So in that context I agree this is appropriate.
> > >
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> >
> > I still think it's better to encourage people to use %pe for printing
> > error codes. The already existing messages could be improved later,
> > but then at least no new places would sneak in.
>=20
> Thanks, I agree that is reasonable.
> And as a bonus the patch-set could update existing messages.
>=20
> David, could you consider making this so?

Sorry for late response.

Yes, will look into updating this patch to use %pe

Thanks for the feedback.

Dave

