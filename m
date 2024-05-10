Return-Path: <netdev+bounces-95543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D764D8C28FA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961AF282410
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B68B168BD;
	Fri, 10 May 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qKjwNOsE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E171429A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715360170; cv=fail; b=Ichjo7d4bxsI5XjoRW9910RJiDFYh5Mcymc4TM1rC2BmKTBAOzKAfOeX7SLj4ydKb0gcpNe/XLBCjy/26zdXeUCNhtuhB0/NumrLSUT4QmyzHuVvPYXKrpaMgj0daFv64xpajK2yZDpKyqqruerX05wOG+tg/bCEb716k/Zlo6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715360170; c=relaxed/simple;
	bh=wmKOpdSBkDeNHYlv2P5kDnDpacD/A4ptvKNvRmbwswM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hx3kAfdF1W7ZTTWlD6bW/iONXJjHRqCbMsvEy8TVLOgYvPijkNqzJDQu5xvW+Fny91yWUt4tyT+fc5z+P4apwrD9G5ijRTzTvZ/1AxJ5f8vkucnuJUk08K3V6+b0LvjvnA3BWYq6hQYxk+q01U33150pNV3gGF4HVAo7qVeaQh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qKjwNOsE; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IW7w83+Ezrrvh33vppjkYn+PQIaNlQNCm3ygAa7cqLNUhdBHUt0JKFr1eVTlXAhOAOhlylTL7/1SkjiF3F3nvLrSMcW+BOMZd3ux6wOYcauanbEFTt1UNNx2jH5uae6rd5194pNIJ+W8L9bE/RTuZcPKLRM4TlmJUvRpNVu/wmcruBylqaPiPpshGMEEZFlqxXJlLCwHysfzK9AJF9BW3PsSh4+uFhXse0gj7FPzN/ZzSXv48bfZO8pc/h0dhkDqMXnY/Em7XuEKBnUV2i8dRgnS3yHE/RzCr2AZfGWWg3YK54aWtY36BKTZHmGtFa4YTWDqWFIQGON7khTrJP5rDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2vUEZMhjAj+tBO/YpGZfqYQM/n6yJ2OzLqJ0ZvHwjk=;
 b=ne4b6Z70z2eHysDvzmjj4u0I+YeQ8w1jlnQo+lm7Uo3lolcDP7ReC9Hp4Sv/k4CH8L0n/n/X8rxEaHXUDc6X1nzfgspOHbvOTZqysxWn/YHmCxpgJ3/fzvl6njnhjv325hOH2d95MB9m0yhgU/yjlTuw1z9x0U50Aq1Ro/TZ5a6ZbBQ7ltYYsZjrYRVHG2nwUqvHuzLhs2tXvQQNbz9KqcCyXuu5OpbMejwoT+okEZKjVM5+z47UoxAeNj3BfUBHxl1frtKsAdHVFaDe+kqlnRHiUN7mcLXczUEi5E9gA/8v3brBrci6CT/wW11h47IQf61Es+G4MbiCrCV2QisCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2vUEZMhjAj+tBO/YpGZfqYQM/n6yJ2OzLqJ0ZvHwjk=;
 b=qKjwNOsE5t+TgXlFgyVctw3sK9eWfjajuQdU4nhZBWVKdSyUV3H282TOcIncD+W+nyIoh74DBE+dnayYiaXuOsdXRS98Cc+WeyDix5i1gzdPKP1g12FntIjQeutkie62DKF93DajZursBZ5a4s0JTVbXhodsc3ypWT14RzUWBZLY8gPPnXkrJR/ObywTfHO8f7Ha/UsglBwCvhL9k1mPekk6HnRPKkLaPyud5SGxphQ7C995Zy0VLBgKBI52kdRMZ3q2J9FzVJ5FFVNPMEpHkOJvhsBMMsufuLQlDW7VM6rkG0kYZptR+9lwjtsULEckA/4tvY4Xnxsw+2IG8QdJqA==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 16:56:04 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 16:56:04 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: RE: [PATCH net-next 2/2] virtio_net: Add TX stopped and wake
 counters
Thread-Topic: RE: [PATCH net-next 2/2] virtio_net: Add TX stopped and wake
 counters
Thread-Index: AQHaoi6J6tLvGll9VU+Q5A4TKtcS4bGPrG8AgAAlEKCAADYxAIAAhXgg
Date: Fri, 10 May 2024 16:56:04 +0000
Message-ID:
 <CH0PR12MB8580B042F111420724BD1625C9E72@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240509163216.108665-1-danielj@nvidia.com>
 <20240509163216.108665-3-danielj@nvidia.com>
 <1715304096.399735-3-xuanzhuo@linux.alibaba.com>
 <CH0PR12MB858086B1DEB3F5D4015D937EC9E72@CH0PR12MB8580.namprd12.prod.outlook.com>
 <1715323692.749715-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1715323692.749715-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|LV2PR12MB5797:EE_
x-ms-office365-filtering-correlation-id: b0428198-7cea-465a-4cbc-08dc71121479
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XKnr7byIs4bdxOcTepCbYS6cDB6/Stqr+BlFBkYFHsMStimvnDMU2dpMPFcu?=
 =?us-ascii?Q?JuvKBewmcdGpxK7Yk2cae4+XROq1r6aWBAFHbAX+WfcWadWcIpCeko7Qs8il?=
 =?us-ascii?Q?lGtFEdcA2udJh6aha4H+/6XYaTjOi4MpzsAx+2syW5azT3g3l5y5Pvtrytpk?=
 =?us-ascii?Q?pHZDb8lezuEDIqEYj0kKcx8twM1bNALh21w4PKIzjulhMuo2b5rIAxDBf5XA?=
 =?us-ascii?Q?w5rb4B1w/S5SZcfYBQAvgsnmwgQEyS05YGryIXTm2Rq6YXg+tS6mlsF9Pex1?=
 =?us-ascii?Q?A2dq4SPF1VIlIFVpEALLTOfRtTzaj21j5waPu8XP6W5B79N/Tck635cCbvTH?=
 =?us-ascii?Q?uSR2TdG0x9UC1IWjaHo7s0tf5GHTzycvKJaF3X8/fRct0iHinfjgLLBxKSHG?=
 =?us-ascii?Q?JvW92OULwsETWzyWAvw31HNcpuooWd3VOohbFi7V3a1QJnLvDwgnErBGpLAF?=
 =?us-ascii?Q?LflAfqtHcGDwsTg5sEf3rfkXQj6+gSmD/WrlcC6eBenY6alV184LMxxrShZP?=
 =?us-ascii?Q?lBOUgnUtANASmI9UAdY+VJ5SvkQXx9TlejU0/fii/DbgTH4gxN/kto9657gG?=
 =?us-ascii?Q?LfqEAeHFOk4ltIaR8nItZPYceMlQ4HEV4iFDRU557PjMhMGy0usOhzP4Kvl8?=
 =?us-ascii?Q?w4H/XXqA1SwtTjIGCDnn39rCgnEGIkD/9wKosUBihB/NxS9pw2pz+7BV6jlt?=
 =?us-ascii?Q?Ha9HWnEJ5CiOmQi5kpKVQNGNzVdnJtFtcdd61g7qWNXhsapN9rttqzvioC9C?=
 =?us-ascii?Q?D8nI6jM5k6aLZ/SNELjat9KCaJ1/ko1WusQvuT1PxVvJtlOYVEs9D5VhZxgJ?=
 =?us-ascii?Q?jeln0iv5Ab1SA5tAdYn+xjsXNuRpm7dbwagCHslcsEb0RR4FSGKnwzSUq1s1?=
 =?us-ascii?Q?JdLtDtObKEZGc5qUhKKgJ/v56RWwXFBOm5aW5on6sAZM9iuyJVK3RQj7QSzP?=
 =?us-ascii?Q?fxzzraNgLJMoj5K7m9xQParJ02Mjwl40MzQJWC8sZGXVivxeFyJGdmOKLa3d?=
 =?us-ascii?Q?NgiObg+NgI9jCh6PLor4+5O/0yvFvW0fkcRdlEPUvzio5EDQBl933vh4hiAT?=
 =?us-ascii?Q?ne6C2jmlxNZM/H7fymk4iStdFFfLli6PuDRxVAKG5h+PQUhr5yNxJMxOkH7s?=
 =?us-ascii?Q?6TJWWrWrUYNnRCZMleowli0KjpZkK0eBxi16MEbKLdrTHRUFejUub+gjxNGi?=
 =?us-ascii?Q?i6aS8u6UVewlwgVwNCpb5pH7GUiKnrf0fb6in18mN/FW0knPlSJP1dMIGL+P?=
 =?us-ascii?Q?PIWTkbQUdVDAbmt7PgvvJ2b5pGR6ah9PEzvv8swKB42he13kHOG3gg5+Xdgs?=
 =?us-ascii?Q?YGysQCLbzCf4s91JNZRtf0iQjAt8NT8UYpBqush/Z/XCmQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kkBSXJlcYwVlxCxXjtTbBXngJbzVDwGY+6r29m1/UPYHfGPuug1OAVDLwOak?=
 =?us-ascii?Q?mdxgu8zrx/BZFLaAF2P9ZmSjD5ezmTujXw2AyBFzPDQvfhcpZzQnGe/oTR9r?=
 =?us-ascii?Q?e8Ge7Kq/64TZdrO//m7s+F8ncnSwaycscYm07ZfmyG0zhIIivM35j8MU3lcN?=
 =?us-ascii?Q?nob4oUiLaJ7Tjlq6YGnCYXtSEh1SARcA7gu5qOiJHHeB0COpkqJIB7GI+KZI?=
 =?us-ascii?Q?gGvu161pSCt9r+bykcgeAJVBOd/XlZzdSoUY9HAV/PMS/+QrsenI0+tqNuZ/?=
 =?us-ascii?Q?ME/5GW921FO0o15gQUOKt2VRcSrdJKXtHkw3cTABs5qcTikndPpivC3ZVWYL?=
 =?us-ascii?Q?hjxOhRnEKdbIstnXMnYqpRxwQStOti0T57K973/XsJNZxETAEnOQEqfO8+62?=
 =?us-ascii?Q?iHgdgqTrFdYZZyS20seNoJSnxyH42+6vEaL5ufQBZOcKsYZYZLNgsrthMaf8?=
 =?us-ascii?Q?Xl+ffEks3wsewoE5U3XIDCwjNcFFgeXdh6B+kpbLUdz3PE7suiN3HUziYOcn?=
 =?us-ascii?Q?Xsa6FOikNnd81YQl5l7SfErxxP8QrGgnNGEzJHL2UvTO15a+KV1QAsuTiLKm?=
 =?us-ascii?Q?Ou9aHp6o73lhR7Xqy4+pwdQ+aqDB7KeyJIKftRQc+s2sQ9KWcTqzAXxQ5adC?=
 =?us-ascii?Q?M6a3SZF6iv6L2larhhu/3g5X7qbJmTI+K8PkWSGIHJDsj98QnM7xqxmwS+Zp?=
 =?us-ascii?Q?3fMi8x+/Vv3SZ2G/v89qSU5HYjek50b2tjuSrZWdvjlJpv83Dd/1wPVnB80b?=
 =?us-ascii?Q?mgi6kkYG4qErDfLX5D0b4sXO7JGQPm93LO9RGUBY4rqJbFj5hNnRt+rhTozr?=
 =?us-ascii?Q?WP4pTzAn6P37Tdh+EYVhM7JnEs4IQgVJW240GNY/cilraWRkGfDhstohED/B?=
 =?us-ascii?Q?hIWaR/FJGHyFq5TphipQ8wBw79IiLn4XrIc4DmDVQKMlmblUkxKenkWV3Wdw?=
 =?us-ascii?Q?a1z0NGLByjif6BNj8n2xA5B35iCB3JX92IBr0AheiAiLAhfQQSZPoDR2uCJZ?=
 =?us-ascii?Q?yc8O6GNN5PTffocYfKqOVLUfG3fO//kWhwaJcKLQJHxjis8cu/KNFDgBTKBL?=
 =?us-ascii?Q?uYN2K+qrcShltjuboJYpFh06AVy8JA8vNFFsZfoZHj8E/6V0TJco5IdJQd3w?=
 =?us-ascii?Q?F4hM25v31M66VsC1l/o0Qd32a1Ultdgq4R8f4IAqz1bFEVuq/q4uiRKSaeHn?=
 =?us-ascii?Q?2alsSnkp1jzMgT2Fni9P3BQ3Fz+9lspZtEyAqnYgMs1DLE+4WCmgriLlH+MX?=
 =?us-ascii?Q?7jrLbIydP2P2DfGlMsQlOnaMytmSNjp/yZbYQHyT8Lt0myvvVjSoA1N/3vyl?=
 =?us-ascii?Q?O88Enmtl8NMJT/rF8uE5Do+4YhzNJn4XkBkc5+PlaOBzWtloobtz11lrrLH7?=
 =?us-ascii?Q?/gJK29tiFoqk9SUhfkCZo32GCUFgvngqUqxm0xLi9pLiYCvcYx2Qy+xI82/B?=
 =?us-ascii?Q?mOfR1D/KpJwkw7o7EwV+L7JDb1YdXOqCxCjFIksWdopwaIeeZMMwrqZ3OIx9?=
 =?us-ascii?Q?iCInja76uYSrYazhzJngaKDfGtaAiLzAbza4ckscsx10knDX3tBwWMCipEK4?=
 =?us-ascii?Q?mNQ3BVg/54cAieFI81Y=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0428198-7cea-465a-4cbc-08dc71121479
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 16:56:04.6013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F69UGIMBI9A7ehjEVvaF28Avzcw/a0COl3REFM1iRLju6t43q+STTYUZnDKkLPVgjcdaLC7PW4Sq2HcpDhtn3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797

> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Friday, May 10, 2024 1:48 AM
> To: Dan Jurgens <danielj@nvidia.com>
> Cc: mst@redhat.com; jasowang@redhat.com; virtualization@lists.linux.dev;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Jiri Pirko <jiri@nvidia.com>; netdev@vger.kernel.org
> Subject: Re: RE: [PATCH net-next 2/2] virtio_net: Add TX stopped and wake
> counters
>=20
> On Fri, 10 May 2024 03:35:51 +0000, Dan Jurgens <danielj@nvidia.com>
> wrote:
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Sent: Thursday, May 9, 2024 8:22 PM
> > > To: Dan Jurgens <danielj@nvidia.com>
> > > Cc: mst@redhat.com; jasowang@redhat.com;
> xuanzhuo@linux.alibaba.com;
> > > virtualization@lists.linux.dev; davem@davemloft.net;
> > > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jiri
> Pirko
> > > <jiri@nvidia.com>; Dan Jurgens <danielj@nvidia.com>;
> > > netdev@vger.kernel.org
> > > Subject: Re: [PATCH net-next 2/2] virtio_net: Add TX stopped and
> > > wake counters
> > >
> > > On Thu, 9 May 2024 11:32:16 -0500, Daniel Jurgens
> > > <danielj@nvidia.com>
> > > wrote:
> > > > Add a tx queue stop and wake counters, they are useful for debuggin=
g.
> > > >
> > > > $ ./tools/net/ynl/cli.py --spec netlink/specs/netdev.yaml \ --dump
> > > > qstats-get --json '{"scope": "queue"}'
> > > > ...
> > > >  {'ifindex': 13,
> > > >   'queue-id': 0,
> > > >   'queue-type': 'tx',
> > > >   'tx-bytes': 14756682850,
> > > >   'tx-packets': 226465,
> > > >   'tx-stop': 113208,
> > > >   'tx-wake': 113208},
> > > >  {'ifindex': 13,
> > > >   'queue-id': 1,
> > > >   'queue-type': 'tx',
> > > >   'tx-bytes': 18167675008,
> > > >   'tx-packets': 278660,
> > > >   'tx-stop': 8632,
> > > >   'tx-wake': 8632}]
> > > >
> > > > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 28 ++++++++++++++++++++++++++--
> > > >  1 file changed, 26 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 218a446c4c27..df6121c38a1b 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -95,6 +95,8 @@ struct virtnet_sq_stats {
> > > >  	u64_stats_t xdp_tx_drops;
> > > >  	u64_stats_t kicks;
> > > >  	u64_stats_t tx_timeouts;
> > > > +	u64_stats_t stop;
> > > > +	u64_stats_t wake;
> > > >  };
> > > >
> > > >  struct virtnet_rq_stats {
> > > > @@ -145,6 +147,8 @@ static const struct virtnet_stat_desc
> > > > virtnet_rq_stats_desc[] =3D {  static const struct virtnet_stat_des=
c
> > > virtnet_sq_stats_desc_qstat[] =3D {
> > > >  	VIRTNET_SQ_STAT_QSTAT("packets", packets),
> > > >  	VIRTNET_SQ_STAT_QSTAT("bytes",   bytes),
> > > > +	VIRTNET_SQ_STAT_QSTAT("stop",	 stop),
> > > > +	VIRTNET_SQ_STAT_QSTAT("wake",	 wake),
> > > >  };
> > > >
> > > >  static const struct virtnet_stat_desc
> > > > virtnet_rq_stats_desc_qstat[] =3D { @@ -1014,6 +1018,9 @@ static
> > > > void check_sq_full_and_disable(struct
> > > virtnet_info *vi,
> > > >  	 */
> > > >  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > >  		netif_stop_subqueue(dev, qnum);
> > > > +		u64_stats_update_begin(&sq->stats.syncp);
> > > > +		u64_stats_inc(&sq->stats.stop);
> > > > +		u64_stats_update_end(&sq->stats.syncp);
> > >
> > > How about introduce two helpers to wrap netif_tx_queue_stopped and
> > > netif_start_subqueue?
> > >
> > > >  		if (use_napi) {
> > > >  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > > >  				virtqueue_napi_schedule(&sq->napi, sq- vq);
> @@ -1022,6
> > > >+1029,9 @@  static void check_sq_full_and_disable(struct
> > > >virtnet_info *vi,
> > > >  			free_old_xmit(sq, false);
> > > >  			if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
> > > >  				netif_start_subqueue(dev, qnum);
> > > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > > +				u64_stats_inc(&sq->stats.wake);
> > > > +				u64_stats_update_end(&sq->stats.syncp);
> > >
> > > If we start the queue immediately, should we update the counter?
> >
> > I intentionally only counted the wakes on restarts after stopping the
> queue.
> > I don't think counting the initial wake adds any value since it always
> happens.
>=20
> Here, we start the queue immediately after the queue is stopped.
> So for the upper layer, the queue "has not" changed the status, I think w=
e do
> not need to update the wake counter.

I think we should. We incremented the stop counter. If they get out sync wa=
ke loses any functionality.

>=20
> Thanks.
>=20
>=20
> >
> > >
> > > Thanks.
> > >
> > > >  				virtqueue_disable_cb(sq->vq);
> > > >  			}
> > > >  		}
> > > > @@ -2322,8 +2332,14 @@ static void virtnet_poll_cleantx(struct
> > > receive_queue *rq)
> > > >  			free_old_xmit(sq, true);
> > > >  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > >
> > > > -		if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > > > +		if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > > > +			if (netif_tx_queue_stopped(txq)) {
> > > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > > +				u64_stats_inc(&sq->stats.wake);
> > > > +				u64_stats_update_end(&sq->stats.syncp);
> > > > +			}
> > > >  			netif_tx_wake_queue(txq);
> > > > +		}
> > > >
> > > >  		__netif_tx_unlock(txq);
> > > >  	}
> > > > @@ -2473,8 +2489,14 @@ static int virtnet_poll_tx(struct
> > > > napi_struct
> > > *napi, int budget)
> > > >  	virtqueue_disable_cb(sq->vq);
> > > >  	free_old_xmit(sq, true);
> > > >
> > > > -	if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > > > +	if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > > > +		if (netif_tx_queue_stopped(txq)) {
> > > > +			u64_stats_update_begin(&sq->stats.syncp);
> > > > +			u64_stats_inc(&sq->stats.wake);
> > > > +			u64_stats_update_end(&sq->stats.syncp);
> > > > +		}
> > > >  		netif_tx_wake_queue(txq);
> > > > +	}
> > > >
> > > >  	opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> > > >
> > > > @@ -4790,6 +4812,8 @@ static void virtnet_get_base_stats(struct
> > > > net_device *dev,
> > > >
> > > >  	tx->bytes =3D 0;
> > > >  	tx->packets =3D 0;
> > > > +	tx->stop =3D 0;
> > > > +	tx->wake =3D 0;
> > > >
> > > >  	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_BASIC) {
> > > >  		tx->hw_drops =3D 0;
> > > > --
> > > > 2.44.0
> > > >
> >

