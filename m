Return-Path: <netdev+bounces-199749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24270AE1B3F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D553BFD6F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC2828BA91;
	Fri, 20 Jun 2025 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RKS403Hv"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D427FD72;
	Fri, 20 Jun 2025 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423888; cv=fail; b=Txfrhw4JfVIVjZpV7JVbwzA6JDpl5KFFXGsa+0EH89wG8A+sHNA7wjoFqCY4hHqRjvgBqhQGU1Sh1wJHbLSkdMOaYJGVBe6HsrncR6oTRAxf2zTN623Tdicr07MhdqP5jYqcLmD7ExYkC/gS1a5WMItyYt8Oggrr0Q522laSPSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423888; c=relaxed/simple;
	bh=E/Z74EHZrTIrpjGjXMWVEgM5jNiANKYY4vgOtcWILlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L5Z1FXR3OW9s/zedEP7hd+I37VS4hnBYZsTSRycQ1JGR4rim1MxBWBihnPR42goVUI8maIngkne22N3LchFkYi8gsPjFjRmcjdOfpHSlvV3GuNr1CDmhKNE7xI9nlZs8Ywrwfc8R3Fmg5g0dzMw7x2QDeexFCeLjOD2odtUwUO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RKS403Hv; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMFSpOaP7BOZxByMvWho5hJcxbEF5AVOGuG23ZVj7hYX+SZi1Pep1nV7clAs3GzKtc2ssUojhptqnhor7Uw444UJLoq75dMAyfYIHWzkwoC8SmYgLChiiqQQqPL5o4i+F8GEUr13CB3ZtFa+rzZkT/owJe2rqUAFh03DSY03PusY9h7xBqTJCrr+citGK9uoz1e2fDZZtNSUb8pWGllPktWXubj9d6+5ybn9PpbZ5Spxd2i+inOVhsd20z9cYQAYDFUJphBZiJRZpFuZEQV7IEBD35l0ZiGWcIYGIYFUktiLLcEYCUydVnT32I58Cr82bCWS674Y9HTipxAQuslxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/Z74EHZrTIrpjGjXMWVEgM5jNiANKYY4vgOtcWILlY=;
 b=F6r+0H6JoW81bhfQ3iZhaKvjWanp/uIb+iKvPmmrywzZZen1V2s4xnRBAoxj5Qw9GI1U7paTWqFhbUyVEyzGRDSIa7cjU9T2Lw8lF1PUIlLEeche+YJYuVbBL/H6jphvhd2H5+vuSFa2ycugsO3uy7pqBiaPO51kea/vWEjV/DoQ6r/Z/T/f3oDdTYO7jqPTLk2I9yl+ZtqJEbrIK/GGBHUDYkuS7letoeN8KhpPWoN5xYxk7BBDS3dprcoPy4Ak43500C1MjQdjdAEWU2oKkwSIjrxvnI6NLWC5McPUnXNUBQeEsCsOI9SS0md0cqHVYSC6R+m9k6awK699cdM7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/Z74EHZrTIrpjGjXMWVEgM5jNiANKYY4vgOtcWILlY=;
 b=RKS403Hv/Ym48+I+6ceMpvkC/h9ixcajLGjy0P4mSloHa01BUCVzjtIISzW1nl1YF+d0DPFVaIcZGCTCBsK9UCtxrQm/RDwWw0fUpD7F2v/2EG5X56ApSH5ykGKdVERYIGFbnzuofumoB6ndv8hXDjv4aiq+gvCJIkCuO5jieT1czUT/jmW64MxHUtxf8p8Ld1AM/4Ew7Q1n6Z+MBp2t/F7pTgBKO9H8KsMX688Y08HfaizIcZhPnLiicjzH+2ZIjU2vHezZuH/k6KOQj1Eh9g83qk17OdZLfgWeQZmEbpIlwMj/i3b33HfpGxz6sCQ3/qsQ04uyMEFB+CUgv/AoRw==
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9)
 by PAXPR04MB8783.eurprd04.prod.outlook.com (2603:10a6:102:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 12:51:24 +0000
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::c2e:7101:e719:b778]) by AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::c2e:7101:e719:b778%3]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 12:51:24 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 3/3] net: enetc: read 64-bit statistics from port
 MAC counters
Thread-Topic: [PATCH net-next 3/3] net: enetc: read 64-bit statistics from
 port MAC counters
Thread-Index: AQHb4czP6iTotTFqf0COh35M/OnzlLQL/QWg
Date: Fri, 20 Jun 2025 12:51:24 +0000
Message-ID:
 <AM7PR04MB7142B4FA49C9E96A73619EF9967CA@AM7PR04MB7142.eurprd04.prod.outlook.com>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
 <20250620102140.2020008-4-wei.fang@nxp.com>
In-Reply-To: <20250620102140.2020008-4-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB7142:EE_|PAXPR04MB8783:EE_
x-ms-office365-filtering-correlation-id: 2775bf5a-e73b-463d-7163-08ddaff929f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OZhIyU4UFVo+Q+LmwUhxpl/OTI3z2CKumENhBnqEsJmQVC34SyohQn4ZzowJ?=
 =?us-ascii?Q?9CwwyM7u21OvuL2Quipx9YvXClsfvgGjmTodJgqkDJD3YT6y5Sn+BMHyM4TD?=
 =?us-ascii?Q?+MbbSJxUZpsulCcYNnvXu/lmRADHxZBIJ1wuhQ4Is+bgGcKL7VKd2vc7Dut1?=
 =?us-ascii?Q?mO15LPk+d5K06YOVUpJZvOAXnJHne+KNWWY6+oR9mr/7PsV9AdoBXs+w17Hu?=
 =?us-ascii?Q?SELuslksUT85s/K77/CSevXJ7zcjXxVbvQmHGmgAVwk3f63sMQH9Rylc+41o?=
 =?us-ascii?Q?Lcdwr4hqmvj3hoxpOV1Yf9HyGUdCoVD9dId3/qdUIHOeA+Rj3SAK2ULgTJ12?=
 =?us-ascii?Q?+rCS8FDQsyTq5F6eR5OkFLZZWC3+OOWTkL+bNvXISBNYRCJtewYJNjQV5uA2?=
 =?us-ascii?Q?65kzfLdSzMA/6zz2ZIZrX+8UK6UbHrUaI9SrHIaDa36VGhvQE6eEJJIx/2uk?=
 =?us-ascii?Q?yFGoJdWdBrilRKmqv/1CQ1VfdAJU5+5K9YbRFr/M9TLZbqR9wIhUvtlflgIn?=
 =?us-ascii?Q?7XP31y4H2Ysa5y3ZflkycJ6QOoxWerBkBX/cRMCNlikx08FxC/H9Ezxva0Su?=
 =?us-ascii?Q?c8dyuxkddl7BG2VxMYPR2BXGIoXmNQmuZasZ9B7rOB2TW4Rt1qHjuMV+LR0A?=
 =?us-ascii?Q?Z1m3hc/WkI2ziBuv01sc138kSk+I93b6zgf1lHEQIZ5NnMv7G/jax31VXPCu?=
 =?us-ascii?Q?plZRtOXgkt4LpJ5c7odl8chQeUCS2vYrecVejgZ3EePgALGpG1o/nt7k0TA2?=
 =?us-ascii?Q?mjkfb5eC1KQVQWHEqjDnwg4daPM/aObp5VY1q2ZjtKmraYT0rG/NV8Nx+u67?=
 =?us-ascii?Q?UpIPzl/V9fFhIed6pCW+8IfatfG+t8RRF5ig7H8Bi4XyEeQjaF5bRKSwVsGe?=
 =?us-ascii?Q?WM+ke+HmIqWxwLJXAVjbcWjNGpnUUWajjFtntmWqs1ryIlwk5+p0X7Pm0jZT?=
 =?us-ascii?Q?kEuDfbIghb6EqOV/J0v3+nPRO6qd3G4ttEBPVORnqyjm5YokM3cOQ2z46vaZ?=
 =?us-ascii?Q?OXVOa8/ZaPW4h59dIfmy849EYpp4lu3zu7ugFFZwhmhY1elHsrVYFt3RQL70?=
 =?us-ascii?Q?ZBG6MKVYVkxfaDl4VN+thCQKIcpO/8c4d3V3CYhcIY0/pj3ABuLVG4lUDndd?=
 =?us-ascii?Q?U6DeD17bB8oOkkqHat4je+Qz/8hrAYGuMpSA5O9249wKmz3uGIvNi46MNavR?=
 =?us-ascii?Q?knWW6YZ5s/iNNoUewLs/kZWnSQUXL7fgdjxQ1SjJykFyY6de3Nvafhp18DSc?=
 =?us-ascii?Q?yGMES9TNaWWWXHFI/Lj5AaycuSYwY1bkwIu5GTTrw6EKfHKSZU8y1+wGtvHM?=
 =?us-ascii?Q?HzzvJIs3WxswHQF9HBcfGYiz6kAh6pUlIfAU1s9KQIPd/nvVbSnvxrALDxom?=
 =?us-ascii?Q?3ZUmlyRYfeH4q5wlFlimeA94VqT/Jo0ZDgKJP6DxtITcQdPs9uCATBv2jqSs?=
 =?us-ascii?Q?7VPXQKuhgBE05+Cna9Xgd23aWq6TQnmpMT9G1WtnK6yavSvUf6uMPoKpYrBl?=
 =?us-ascii?Q?NMywG/HhSjIRq/M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7142.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bebaruEm+h/bLM02euVbd4UuckbHdhftuOhTsNVKklOBpz8SDX35QtzbrhP2?=
 =?us-ascii?Q?USxVxtYXBzVNVLllR1u140ZqoRSj6us17p6sylX5vGp06qOGvMS7aEM+r101?=
 =?us-ascii?Q?C3tF7x6dO5tuftH40oEu/3iPcWiFEGfjBOzv8lkvFwdH6LmtI090hzU3y2Bl?=
 =?us-ascii?Q?YN1FH4+mcXlVmX8uCOKrWDa6XLZI45MeHX6ZMoL68yZG+I48pGvjoQ/FNT6a?=
 =?us-ascii?Q?Nh1YQFfTnBf5eV4ldRRkmG54+ipjSn03MIrMayXvChiFr0yhzaLKtX5NVv3n?=
 =?us-ascii?Q?7V3NLBoStO9HKl8Z87SFKV7elUVaj949hMg7jclPko1XQluY5CUUyFfxSs9l?=
 =?us-ascii?Q?YUkRJZu8WutUPQ7UR2uabnvlv8a818CJ3JV4Ydtp++mRz8dO/Pw+BT4QzBtS?=
 =?us-ascii?Q?DhE8nd85T9Ij9477X7Hqhm0pfdLgwC8V78ZLSWwjEnb9RkJwJ9RAxei1xEdS?=
 =?us-ascii?Q?lJDS84DWO9DKCDWB6whLRYuot1r16pT4xaqhcKEs7tv1JLZZRaN5hFnzagbs?=
 =?us-ascii?Q?rfJGn3nUBcpKhxOTXQWsmjK/IqsGCzjFh+ZvwDGIgfVEEpEiugUh0KCbkSsh?=
 =?us-ascii?Q?lqGbwgMq1HKgnTT8q8VqstvS3WlvIbLI+eJSpFl3pzfXxBrpbGTYEyXEpelM?=
 =?us-ascii?Q?gXY102S9DY/ASMCv3yy6fi4JW67HngrM6aqg4uA1xJSmiBHc/GUAA6AagZAs?=
 =?us-ascii?Q?KPWnf+IPhQt4Mh6dm8txDQF5fuloFj47m8rHrJhR1qMsjzbjJhlY7vzJQRLR?=
 =?us-ascii?Q?A/wX2eb5yQzWuJNqiHk0ijJSex0yAVUl5dvweubCQfcCHt3ec4Isd2LfQteF?=
 =?us-ascii?Q?Nrl+RLUNMuBPAkPFTQgTshF8M/4S+BAMoqvHu3UV4RC2nl0udfR65ZQihm5C?=
 =?us-ascii?Q?eZ0YJK9Un7+DzqshcNo9TQye6zUQ8QgvSQ+q27l02GZ6yTgc0f0IjvEnU87F?=
 =?us-ascii?Q?mJOdgqC3O8EIpzWlA7w/K9p+Sp6lCF5uD5R3IyWkNsn0ZiuxW4KSgalV5gnM?=
 =?us-ascii?Q?GqHiggw1a4iGsJ3MgUxZcvlnumwvLGLP9ZMoxrUbc9Yyd73kq56cIAKYIjRs?=
 =?us-ascii?Q?/70WnITSHbNKVpXxd/6opb8RXkO9+fKfGJffV5VM6m8OL6wepOIbC9kCX905?=
 =?us-ascii?Q?aEFWvu94HFtbh5tWQjwD8/ppA5vwF9KuBM1QLdTRrQdKg3HDwO6AwC/hfjiz?=
 =?us-ascii?Q?TVpAYwNsys1dsRRUD18R/1xoV3vKQiQG5YPID8Zhuog02Cz3Ykub+VwVXyLb?=
 =?us-ascii?Q?hW7ghrtnMEe8xbDG5GrmoVRZjq/RLgSU4W2kcWDL+UDN9PeEswM4jg0e+Q8k?=
 =?us-ascii?Q?B6AWm8L0u1gJlNc7vVGS+RD+XQR2P6QrQYZg0CHnV4yVlX3VUFJjSLnkl6Zz?=
 =?us-ascii?Q?yVxc2+LO9qRAJwNLd8LQYZd9WOLnOurcZXn7/43Bui7OxNjUOK/c6sGASjt1?=
 =?us-ascii?Q?ThdI7IL8z0C/0GhHLkzks/+Y7yatmkExZnoPlQk6qW6h7ig4TtzoQ10lNxCz?=
 =?us-ascii?Q?3Xm0nDr2qjxkgzaLRH6YjJqI0zwe4sW/xfJU4ZDhVpSiB5wzducCeVZOwAfc?=
 =?us-ascii?Q?3mzxwJKe2StLO9m1gjhBLZ11I9FucDPiuNUPuDtG?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7142.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2775bf5a-e73b-463d-7163-08ddaff929f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 12:51:24.1371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8rVozBTT5Tbkihld4vcUz+qPcT4eYu5p68yZ4fxeSZ+3UDU6AgmiPmetgRpScM26+6FEjelCREpEFe7TDyePQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8783

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Friday, June 20, 2025 1:22 PM
[...]
> Subject: [PATCH net-next 3/3] net: enetc: read 64-bit statistics from por=
t MAC
> counters
>=20
> The counters of port MAC are all 64-bit registers, and the statistics of =
ethtool
> are u64 type, so replace enetc_port_rd() with enetc_port_rd64() to read 6=
4-
> bit statistics.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

