Return-Path: <netdev+bounces-239998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 865A1C6F155
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80149357131
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E304635FF55;
	Wed, 19 Nov 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nxbmeJSB"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD435FF4D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560160; cv=fail; b=DQqgfDQ7AXXpIgPCNFq3t/GVJ3rg8ONWbQFhLP0uqaPPB6GnIx4iqRral4RAgrkgU7ryVKBo6S22NYqUINmUVZVko/H62YswyjxOVAm5eOQaoJUKiXAIG6d6ocTtdKVDrmzB+v2yC49eADypr+X363f92Ck8OR4RkWf9y5EYDPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560160; c=relaxed/simple;
	bh=9FdiS0l75ECIJVhdO3CA7OIGqaBJORkeQBTqcAzW880=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dCxNUP/ifnzx7G3TWqwdqrVvHWO8aWdKf55f+ik6H2TZtwQ2eIIbUS/7xAqUeAVcfUB3ChMi4ab1j9mFavpTy/l2rszIjeo9bTR0sxF4Czh7FpJ1wqSwNs3wS9eSRfy6WVf/pgCKHxTyzjNbFBxZgtyYxTZiyUE3Vfu8ONoSVNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nxbmeJSB; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/OLEl8zPgyt7W91c92X1hqQQq57YcHIgug0ZmgTY36Uw2O0GITfQNtyni+WBwnUZww0yQPtcCwHy+JmYYn2fyugcgUCUHsVJARbxp97J0ylIsMAFyN4JTo3Q+j257onx5DQNj5Xp6GaDHxJKeKPlrV/YJgEBjO2N42zyLUsrUJkNzvSpAHuvmzuB7Oy8b6mkybgY6V3S/ze6j5SXOYp97UdCbGi40ZWl171ZnvDuBXT9WV3twIVnLsBZ4kGJLRPgF/eVdKhFvdTA1RqZPqA+7QsO6WSWEgJkH2EY9DgAsqq7l7DgGi1EX56EmLekLoQnbsUHGdfc4vwbHPW4MQqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUdsogEnlH4Wpu9aAvUmi1iiDzgAXJgCVTzoo7Dpk3s=;
 b=H2BZW0cTh9M7jRL2y+Hc30cJ/KeSbWiFbBJtf+0qnP3469lk/p+L/59lEaYVDeUpTVaAvix6UkCgc+Ik8H81RlgtHr0c+xb321uZD7kRERgk9NSXpFc7OarN0DAe+ZofL+enV1/hHcb888LrhQG/jUzkVPWbpTmWdicXsDjSuywwqlAASjeT9E7QEyUYvnuHpDTO7gZ3x3xCzcnmaHQXxfAdjXC13sJuSDdA7OZdHlz8SiodDWDICJ3QL9HGtWXzVmZ/E/y8gMSgAjLkaKLMC72ZcUJ9/7UQKklNlS7xTZhV0ik6XbQJb0SG/8i9WMg0ts80LL9hqm6ABjW8XzMtjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUdsogEnlH4Wpu9aAvUmi1iiDzgAXJgCVTzoo7Dpk3s=;
 b=nxbmeJSBy7eqUeVqK/2kZqfFMa2j/++5OP5koi5bX4OQ8lbuked4NfiyLV9ErG1lcJeX54WTzVksodmVJ6LjZLHiuKFCEguBig1uxzvdQNXy0jxwAKAqf2vqVj97WIPJxxae4L5hsi7ApllyX2KVXodSopYoCgCEP8XtV2rOGbbzLh4AqUF2bG+gjab9qz6jCV7dZ5ZVZTHC73dvmA882HAogj7jQN+F5pTsH9tYFqdolC7XELzvYW8CkS3WvvUDrsoaCi/pnqpVWefoN6eR33f2CvvYFZDn4tBYZEtg6adlm6f0s7GPnu5OGCl90uqLBdZHKNKIhknJ+BlsOBDR3Q==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:49:13 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 13:49:13 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH net-next] devlink: Notify eswitch mode changes to devlink
 monitor
Thread-Topic: [PATCH net-next] devlink: Notify eswitch mode changes to devlink
 monitor
Thread-Index: AQHcVdrQdNgAaqHH4UyJKs95sBKeebT3zpuAgAAacKCAAPuFAIABJRpg
Date: Wed, 19 Nov 2025 13:49:13 +0000
Message-ID:
 <CY8PR12MB71955C13A7D4659B7A55EBDCDCD7A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20251115025125.13485-1-parav@nvidia.com>
	<20251117194101.3b86a936@kernel.org>
	<CY8PR12MB719576A592BCF41591F83C23DCD6A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20251118121552.7e1bae0c@kernel.org>
In-Reply-To: <20251118121552.7e1bae0c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS7PR12MB8290:EE_
x-ms-office365-filtering-correlation-id: e038d205-f2b9-4668-eb1b-08de27726c69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3M+egbm6xOidzteXTQdYi+yeO9Zs6eqyeDactXqTZdHT59ABcssIq3qTI4BA?=
 =?us-ascii?Q?LoAk8gUi0RgBkzj47fGbfbtxXe+xGWoRTR1AAGQlDwQPJDKPqDEJAZIlhAod?=
 =?us-ascii?Q?1vFe7TzM2J5DWBnq6Xq1oZ+3djeb7+aK0gbMz/CVKW4s8xNtP6YH+T2Vwbup?=
 =?us-ascii?Q?IUXAjsUbA6HHhlZ2J1rGd9V702eL/CI1S7yNO4cTaw39BF3Bl3QMJfdquB42?=
 =?us-ascii?Q?VFyHO6rMLdXYDIUaJKzdt0Bhf+mRxBSy0occKV+FrZM2TO7cQAOTVBN+1n4F?=
 =?us-ascii?Q?czWfFQXn0QN0U5W+fhlIxBaFdoQXDlOa65iIebLN8eFqO7YXD0Lodz8wSBCB?=
 =?us-ascii?Q?4cQcy5LCpggFF3man11njJc5za/qH1XBVJCfbXxiDFvuh3hJLzVfc7osiQWP?=
 =?us-ascii?Q?+e4Kc4TLw49MehspOFq7w1Zl0ZTOmb1oN9YUk8HFKDuQh53/sJplPHZmkP4N?=
 =?us-ascii?Q?6d/aUDf3BJq025c7GJgG+KWBzBs0nYHGm/mG6dIk+BMCamF5HCgnMsKK3bmT?=
 =?us-ascii?Q?bhoZTPi6WH38QYkTm3r9E1mFU7TyAoL1DQl0/GhInm3ora6WdAdrhcHCcvmd?=
 =?us-ascii?Q?JrXW/c9ACgKoPLgbhlDw/M66G7cZ4B9hodnEt3PP1TV2cyvbchC3ashVzMEv?=
 =?us-ascii?Q?re/hCi5F2xoMvF+VN5edY2CjAFeDegB1LLNkLr6yQyKW+oPp2NkQXViclMAW?=
 =?us-ascii?Q?+J+gb7C2G6rjYy5FBnAZfOA7JuyaSG0sHgWa3xL59tFGCt8+xFj2YL3SQ60D?=
 =?us-ascii?Q?rnjBHy6ONczVKgCvCCQGmjAcKIZgrfXiAIwtRXF8jnhdm0P5+iIN/LNrMsWm?=
 =?us-ascii?Q?1BPPH0HZmRF562KBMOBdoViwKDt9b+T5b98zmroH+Jvmb6tts5XJLU8hcDSn?=
 =?us-ascii?Q?zSXm0A58DSQhoBZB04exS5zpBLa5raS39J3+z1yYYKXVuddFGyyH6lH6eHpq?=
 =?us-ascii?Q?AzobWgYYHKhctgtnJQ/HtFgmXSFZ/8WtEXaJ6HwP5iSi8p2q++v+hpuWDJ1f?=
 =?us-ascii?Q?fdAj5LpBj5E+NUThqn88oJO/nm8pYy5ZRf0aPvudecgkJ4RPFzII0f8EKXxA?=
 =?us-ascii?Q?qGalyMh3pIGDXzXMaUjXZwmH7Gk5LG/Jmkah9dQwhtCopAErrzjWHy9Brzny?=
 =?us-ascii?Q?fd7tjDtrebnhwVu6qMOjv4KqsPJMyodhUTUcvAaGVSJpBwbrUhjG3OLVJ0Ds?=
 =?us-ascii?Q?xm3WF8i5GPA6MATj0DeJjhRE5byvQ1csCxp/O7BHvEmDUfzLRxq7K/S5IXGV?=
 =?us-ascii?Q?nQwv9qLwQ2Y1fphTwWsvxOnMXWO1qdoaO+9PIWWbCfRplJiYdM/pbEEEXfAr?=
 =?us-ascii?Q?ZMWtfkcw6DuK/+RNVC0CyAyasnAkZPqnbj1KTPnVJc0yRRLNhFH4YmrxLeB2?=
 =?us-ascii?Q?tBiyTflo2CPKKSOPfsKswjZTbdxrt6cVrl4u8YhsPgaDEcs69Sy0HKdc02GU?=
 =?us-ascii?Q?q4P3BUaM4wk6jpKLbafseaaEB5qGAa+TYlWXd7w2EfE/meWUZN8ZSut8/3Rl?=
 =?us-ascii?Q?ds+xpLjeTEhYL1vDTa4UL9yPpYTzu5ZIkaDC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Dcsm28VE7jSJT8UNUyuY1wbkKYQdCVKY5Tl5kv0X1R8Lc/1fIVBjvxr7h+xo?=
 =?us-ascii?Q?5JJZ8h3Xntv97QW76VWjFAbaKsLQ+0R4XVgKmtg9dDLak3vuPgzeorYa5MY8?=
 =?us-ascii?Q?EA1dXGm/j1k+u/ZP6pzhavX3SnAJZSsLrOsIV79NfQTUmeZL/8HYmG5xP5dZ?=
 =?us-ascii?Q?fEoJr3R7Salm6cZxdvyoZV8AGWvZCEDJMqwFx/6mNUEDIabmfh6F4yGW2j/J?=
 =?us-ascii?Q?12zUQwP6R67gtoZBkGwpiFyuyKMWnnQ7UfUR2DtWBv1uaFgrrbb3wIZrVy91?=
 =?us-ascii?Q?yIY/kEopCNU7PQvGv6VeBwCehJX2gHkZ1T9bRCygGya6bSV7a9oLBKODzGXm?=
 =?us-ascii?Q?zFpaieyxKd8u3gT07VKaOgESZZR3LUOdYbX3PawqUlJQEXABybsp+z8YyYnV?=
 =?us-ascii?Q?XoRlpPVtPBfnLZznJOTAx5Bl/6SnYPkCuROe2F2ikhljzAK4CftM5PGF/tIO?=
 =?us-ascii?Q?AOl+8Izl4/sDxS8hykxVlvqqHanxMTUsUKnTEY5Qf48azUFeJWoCLT9Lx/hh?=
 =?us-ascii?Q?lNjRQbl26fq1oaeQhyBvfO+62Z+EhHNls1MzoYsCHbjh1O8yXm9bKI1nAEhp?=
 =?us-ascii?Q?RbNT7fn3OgEznTYSnGiMRqOV4j5U1q6pKzf7e6iOCTHIxJqcwTrnEtbdERlP?=
 =?us-ascii?Q?KdVTPIuOgutSR3DHft9Hx7tQu8wObAetez2VkZU+ZS+IvZt9948SLlCjFz4T?=
 =?us-ascii?Q?kIEH1FsWjysIG2HAt+ABMdqyqZWIau20at6Gkh/M4JRtEVksSe3X3nIT20ZL?=
 =?us-ascii?Q?GWgJfwKzqN5EX5v7mQMwLV5SpCc4tHAJxW4FCzhfEufS7ox0ficHvmqjXhKo?=
 =?us-ascii?Q?q4TY+a//5Psaoa0HVCWjUng9Dmhr1T4HZ1CwE3R8NwzQTa2q+pKE1ZypoCFT?=
 =?us-ascii?Q?Qs2rri4xlYtkI+dlhmih7FcGU54AyV8JT/bc6dOc77Vd1zf+6kuNaArHs+6p?=
 =?us-ascii?Q?WWIckcSh2AWJ1XceoNqUiJqvPf+UwOzwxUxHSFyAIcvYZ5RM/SALG17Gp5ob?=
 =?us-ascii?Q?tN4CnGaBnQ7Vx0ueW6toDPaVcKRBgxbbj/42KoXSUuaFOLotHdqlMbT/HI0d?=
 =?us-ascii?Q?nHoY7u1X1w53ywaJr6vmkbQzeP0OkfRs1aYiSnIvVphKeS1beNuGuiNys39X?=
 =?us-ascii?Q?9nFQ0hHXRszb00hmvX8ZgQYVVUfilfpd4UWxwACoNy0SPr6CobBuyerZbc3M?=
 =?us-ascii?Q?/WD0dw2oLfKAPLNkjO3phXxJF0NLuBmT95nRNyWZyq8cbsXMSxLpOCzfibmj?=
 =?us-ascii?Q?0+TKV58+/sW+nZVT2OERtyDv2BU8owkEb7HhED/N5vlBaG723W9KayqgPVU7?=
 =?us-ascii?Q?pWwmOjRgsApacAEs6z8/AUxD9GeiW+xbGYmK45PfPbtOJUolYk6dG3sYwIzM?=
 =?us-ascii?Q?mq3BeocsiESGsauMnhv3NwuGDKO0cZQSU0OPqeDp1HRWZtgQncJZC2BRxMwL?=
 =?us-ascii?Q?8+Z0+Z6VP534QwmgBfW48s8ylK13zXtRg+1TfzH6he+3OpfoQGc3livmDMB2?=
 =?us-ascii?Q?BpUXKyEpevIDvjredWH00d71yXgSfaHZ2nTZQoxYUAUnhMOi4xmCzK989RF0?=
 =?us-ascii?Q?ZbQXPBx2QPC++w80CQw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e038d205-f2b9-4668-eb1b-08de27726c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 13:49:13.1154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juVbsvG6Oi/P5CfLbTrscxAkyJesX3bjGOh54q65gQSy6BmUimBHOzjaplz/G8DfUB00tsTHMRHqJoWuD3qnmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290


> From: Jakub Kicinski <kuba@kernel.org>
> Sent: 19 November 2025 01:46 AM
>=20
> On Tue, 18 Nov 2025 05:25:23 +0000 Parav Pandit wrote:
> > > From: Jakub Kicinski <kuba@kernel.org>
> > > Sent: 18 November 2025 09:11 AM
> > >
> > > On Sat, 15 Nov 2025 04:51:25 +0200 Parav Pandit wrote:
> > > > +	err =3D devlink_nl_eswitch_fill(msg, devlink,
> > > DEVLINK_CMD_ESWITCH_SET,
> > >
> > > I've never seen action command ID being used for a notification.
> > > Either use an existing type which has the same message format, or if
> > > no message which naturally fits exists allocate a new ID.
> >
> > I am not sure fully.
> > 1. devlink_notify() uses DEVLINK_CMD_NEW.
> >
> > 2. devlink_port_notify() uses DEVLINK_CMD_PORT_NEW which is the input
> > cmd on port creation supplied by the user space.
> >
> > 3. devlink_params_notify_register() uses DEVLINK_CMD_PARAM_NEW.
> >
> > Do you mean #1 and #3 are not user-initiated commands, hence such an
> > action command ID is ok vs #2 is not ok? I probably misunderstanding
> > your comment.
>=20
> Let me put it more simply at some cost to accuracy..
> The notification types and command ids usually match the response to a GE=
T
> command. Please TAL at the messages which are generated in response to a
> GET for the objects you listed...
>=20
Got it.
Will change to reuse the id same as GET method.
In the eswitch case it is DEVLINK_CMD_ESWITCH_GET.
It fits the existing get command.
Ideally a change opcode like DPLL_CMD_DEVICE_CHANGE_X would be good too.
But ESWITCH_GET seems good enough as we don't have ESWITCH_NEW/ESWITCH_DEL.

> Netlink command IDs are not required to match in a request-response pair.=
 In
> "modern" families we recommend that they do match, not because the old
> model was wrong, but because a casual contributors usually got it wrong.

Sending v1.

Thank you for the good explanation.

