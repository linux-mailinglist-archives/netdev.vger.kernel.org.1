Return-Path: <netdev+bounces-97379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D77E68CB273
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 18:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4044FB21BF6
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054928DA0;
	Tue, 21 May 2024 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="hd53DNpb"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2101.outbound.protection.outlook.com [40.107.22.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D41FBB
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310171; cv=fail; b=fq9SQIGKsMZaQBVb78+PQPSfK5xx+EoqadQGTMV6pb43t5w5/Gaa9Y9nYPzTGA89uUz+vlR3KZZujgBG69oq43IN/wY/UqPBxQMRD9IFEVgPYvB6wLAL/k2zYu5/bO9WO7nas4G+tddtxsGsbOIbAdzXhl8VLETvBuz11b148DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310171; c=relaxed/simple;
	bh=n+nxynhwgs9/9V6mORkQ5xN9F0nIXHpBM5+RlNSy54A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P9dZ5CjmgVEsUCCS6U/8Y8/jtPljBJG+b/J/xLHqCOE4qY80nSe7YM+Rn4y+UXjWmy58xGqTcRppMF2+LH8RRpopwOX2Vzs5TCf7LCxXb4/unjUXaA7m/MeDdqPdOA3ag6xcnbnZmf0T6stGGSAcNtVPLIs8o/QeRBtq3Zm7WTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silicom-usa.com; spf=pass smtp.mailfrom=silicom-usa.com; dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b=hd53DNpb; arc=fail smtp.client-ip=40.107.22.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silicom-usa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silicom-usa.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmXmb752Qdc4QV1SCzaGK6++zcLYj+sooDSFw5LMSUFD2G8VdgxoyDFWNWXPsjqdMXiAYq5sXcGdwiOikEYtT5eu1mJCkYIs5h03ti5A4CPrzupjmusiHM1QU2s9uk5xDT7uud1aBetpWmG8EyWjm2L7D8FSsl7j0DfejdH6ZbMHalpzulqICey4mpuojA0697KN9OK+E9MlI2BEvYRfvbgGh35Ckfb6hoPBSnkJJi/O/CqLsFgH+u4zieMSzjJsxn3ncLB0k4+eeZVlyPRq199kkwjoH/T8hWLYh1Yqk/U6k2IKkGiltcwEnPQ7KaKcejEb0Tw06EtsW2SiUsCHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TmvGhxLDbhE9gHkofzghHA86xNZoLQJa0Hx0kwk9ZQ=;
 b=UvG96LPgmr82LpJZ0huDq3xB8FFBg1BMeBl6C/x5SXWTnAz1eMiDwfKYdOijZs5EXGKTFa4ZBrWm+zkBET6ZIJ3N9Cc+Wg3Gd9Y/UO8KWzXgG20T4IZnRiI7YZ7yaxFXS7MfleqWrIXE2Z2Rm3QFIGsAGdBWd5+fbstqGRUvwEnCDljH4S2t8JZTqOZN+7i69ftrTacEEO9EN9gx6um2jGkPmbFhpjwWO0RG1zR1MSFuurRH+ayBOklKh6hP3jsejw2dzr58RtJjIs28jAlzksElhRxacrcg93O6o6DUni5zKWZXAxSl3tNNnLxUqdNFbQnnaGbYpkUqu2gs3vTF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TmvGhxLDbhE9gHkofzghHA86xNZoLQJa0Hx0kwk9ZQ=;
 b=hd53DNpbVMW10fqLAWH2UtUWrbI8u0AwmFjFJJds+C+Rh9/WBWEBoG7IykbKwVghH1rYbHAO4djDnmnzzurepWa0KHTqH0kvsuwvfBbK4w1NTNTlJEjoD8JSqY3NPaOYcVIraa0sIb0uPDuOWMOdmM0dJci6B5DuZlCCL154xR0=
Received: from AM0PR04MB5490.eurprd04.prod.outlook.com (2603:10a6:208:11b::24)
 by PAWPR04MB9717.eurprd04.prod.outlook.com (2603:10a6:102:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 16:49:25 +0000
Received: from AM0PR04MB5490.eurprd04.prod.outlook.com
 ([fe80::2aee:1b56:3c5e:61ce]) by AM0PR04MB5490.eurprd04.prod.outlook.com
 ([fe80::2aee:1b56:3c5e:61ce%7]) with mapi id 15.20.7587.026; Tue, 21 May 2024
 16:49:24 +0000
From: Jeff Daly <jeffd@silicom-usa.com>
To: Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel.org-fo5k2w@ycharbi.fr" <kernel.org-fo5k2w@ycharbi.fr>
Subject: RE: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
Thread-Topic: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
Thread-Index: AQHaqxTYUzZ49rg8C060RnZ0M3bByrGh5VyAgAABhHA=
Date: Tue, 21 May 2024 16:49:24 +0000
Message-ID:
 <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
References:
 <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
 <20240521164143.GC839490@kernel.org>
In-Reply-To: <20240521164143.GC839490@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB5490:EE_|PAWPR04MB9717:EE_
x-ms-office365-filtering-correlation-id: 66b2b3d3-5668-4606-dbe2-08dc79b5f8b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sE9nhk6kdbTq9keFyQvr7SA9LxpZvEmoB3Qui2I26HQdZRB0PVmnlE89VHiU?=
 =?us-ascii?Q?LpN1AqfbFMb6q7gMhJhCMa39snvGnszYutYkaFqDcLaOj0wt+fCWnqJBG0K7?=
 =?us-ascii?Q?NbZpsM7rw4LCEBJQe0aA7Rcy7Tm4J6SYAgZPOKF53yKpysj00YnNVg9e9zYl?=
 =?us-ascii?Q?HTTU0OiNJ5Q01VeROQfzx/JydinHQztFOJxHQL2XeD2TgQKfx7sKBxwTG9Sj?=
 =?us-ascii?Q?a/l2UJQdKkX47BbvP6J2HXR0qBbL9MHuiRn/Poy+wR6bG0FCaxG0qru/FTfu?=
 =?us-ascii?Q?X1XGhshrAcdz84E5BHLdkGJR6ADWgiO+xR5Psxt9riJP9VunHq7qyqt5uxhU?=
 =?us-ascii?Q?NJjFMVdkJCOgYQjEgKW6wdcMuVn0+bs/0eqp3Mseh5B52z0R99noebydAkRQ?=
 =?us-ascii?Q?tSoSaf2dua8EjE+nOYdNelBz6pVhboedRr3cC/gdbcx8hHdUyGw4N5A/3vrs?=
 =?us-ascii?Q?MF0drzG90ro1//0OGhrC41oosxDLj5Tkb526dMJq3/cjS855szTsw/xdNars?=
 =?us-ascii?Q?Mjvzub5Fj+tS9GvrAwmCEUTvzYRnqjhbzd1A74b4APVW0uIHYLphTm7OZvxg?=
 =?us-ascii?Q?92epzAUWtl/hWKCAcVbpXQjnAfRJexQ/FepVynQtUrr07Ue8DvuTUy8J2oTz?=
 =?us-ascii?Q?LvAWSI/aioZSTvETwKwHOzJ0iXAGQrDBgBraxNcpH/rbkmDZUxL/giHeZTSG?=
 =?us-ascii?Q?aLWwq0ZMFjczBhbKf9TdkCxKdPv25lobk0kZ2Z6715QCGfvBg2JTGnmVn4ZZ?=
 =?us-ascii?Q?LyjKPbgIm6ooscH/fda8ngQs/AY7oG9QgN2uftEcwBBhO9RqrUFxX7QEG2w/?=
 =?us-ascii?Q?1wRcABLc824J700yr68fOBnsBmWVsN6n1YDFuvy1oftKMdboEO3NkfSlf/+d?=
 =?us-ascii?Q?DlucC3ag0wq9LtSn4p75W0GDgEzlOXz50qb/O29WSgknWYLG+t3ikJ7kNger?=
 =?us-ascii?Q?M0IvOR+31A2DTQ6L3Gw3aEmwnvo0v1mgouk5g/l24qF+AhhexlFPe9hTKJOr?=
 =?us-ascii?Q?XtcfXfohSfhYVrR1JsezaBXVH9Ktd3MEA679++HTnlEdSIwGQTwgWukypbOl?=
 =?us-ascii?Q?pglhIDWgNFwfsvCZB7a7oqSsex7SATGLyvRKI/QJ0+WQfg70E03N+IyuteDS?=
 =?us-ascii?Q?GuHKNMg4OHzy6OGF/tDRVYbBYJU9+24SJKpOocc24z+dFZk4rchwN8KiVxBf?=
 =?us-ascii?Q?b8FdYfmSrU7Ojs6uKvYLiz2KHJShM1Ivd6Jlk2xZTu0ZfpZ7Y6b7E4rnG2hy?=
 =?us-ascii?Q?T89AqOOfahzID6wC92ID/+jzxSnz0/Lw2gG+5FmUVA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5490.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D2DqrX/hjuTcRp/pZAHihLolN5T648Wk/gsgwQekj0Obq5OPiymCFeKrqixM?=
 =?us-ascii?Q?yyUMBBhiHK+DQKn+knPIaGG7t3rdVs992gY821VHRd36OHLXegCd80hpyEL1?=
 =?us-ascii?Q?FpCpyyTyKmMi7tzCOckJp5gZiLAD6ltBBhxoQ+uN3rHhkBqryPYS6lJSnfu3?=
 =?us-ascii?Q?px2uu5WTLM5yWQME0riD1enQKaNXYkQbbbtQZtWySZOwvM0XJFrG4kIu6wDh?=
 =?us-ascii?Q?TH8cbhQf9yJkuhTD7twnGGiiD+gi4zi1bTrr7G49ZkDIOGRqr5tvLRjjXOXN?=
 =?us-ascii?Q?hT6AbtFx56w2XpvI2/9o9NGJJ0Rmv9cvcaJwtr9wQtmhS67IwpXYcBcgRd3l?=
 =?us-ascii?Q?N+Uqe7gGYylFIbOAGaMfmOuylldnyXxyZyXa7Yy/Gbu81XZHL17sGWaCXKLo?=
 =?us-ascii?Q?ZFCBE7VdJd3Y67+eULo0Kazn4iF4O6hfgO0T9xm7+ELg4J1boFJ1x3v9VPph?=
 =?us-ascii?Q?+bIiMp7MZ+/tgcfc7RthGyABSkCP0Xesjiq66pI7r7JlvqELhP0C8cMCRCY0?=
 =?us-ascii?Q?cJF0AslbjucAQ1jIiVEH6HwSWWshgAYhi7wcydMOgQjuDg7XwZKLM+yBkTgD?=
 =?us-ascii?Q?C4wjEI2W0zAvi0rg+26t39J8r04LWvw5HnBaPvtPvtUQQck9/59uggQTMFLQ?=
 =?us-ascii?Q?xMT9cav2OycMuW/iOHinvJcrugEn2qDOKCx4QtA0yazQfNRWx1Ksi34Dec3d?=
 =?us-ascii?Q?TxvdAN632NOwdut1XowhpxEbESBRiYYQY1HZTxejP74cBLBgLjn6Ovff2ibP?=
 =?us-ascii?Q?yMcuj/zNqgcAHtPwhnEWfaK6/6c2Agg2w9nUtMnWwm7/2mVe7CnHSTahimw1?=
 =?us-ascii?Q?mnkJnTVXRDvu3uSxFbBS4t5PJbsFlNKPxqYhlG1B3PWsamltQvSkeUCjN2Hn?=
 =?us-ascii?Q?WS/3KOmd6J2LL01DMbqEDMjRUpeP1A6CmBzxL0k798XzfKmVfNJsWVUCYe07?=
 =?us-ascii?Q?eTV1ICy+/3WsJ1IUYiM/jrvwDHf+y/Mo+Ne1tQeMLit6pM4vL26F/xw8Y39k?=
 =?us-ascii?Q?jFcHNPf1rv2RKXGptqx01S4LsF5HP8XdCwEu2V/y146lWFs5wArFznap0qvI?=
 =?us-ascii?Q?K0G2oSdIT8AQ09d9GlOxvrqoZv5q7KqDw6F7xUqPtSoX79p965+OqpHXz3IQ?=
 =?us-ascii?Q?JpHtLfB4zzuGlNjADSuau4cwnp4PgD4I/wKyNAskB1eqBOLD/txPuZwFtWiV?=
 =?us-ascii?Q?eyj5vzY36wW5pqZriOu9TSWj7Q3RWe53xTB3CErkcFO8lR91rWTLTjCFq6eW?=
 =?us-ascii?Q?902vAcMmO9VcSHM+3o61J3Za0zoytakQMnAVpx/WDnwmG4HIIEjykGpuNkEC?=
 =?us-ascii?Q?ONzW0Gjjvjc7XBxVgQq7ZZy9QVsC/TQgepfe3uiG6DcdlfP0uIpVqKQaOitL?=
 =?us-ascii?Q?PsBWPb5B//bXeTDCB36F2ERIZ+JQ/4UMrblbNy9THCAon9/PK0tUqtquK5Ph?=
 =?us-ascii?Q?sHxuK9IvsVf+XOrPKh9FBklmaenQaHVoH7tYGmN4G7kpbT4hAoj5cx1gLEGa?=
 =?us-ascii?Q?Q0Z3JK9DoOmUnnQK//KqUWBF8z5IBnLYqE7Qj3PJdNw0viksYsUzxnw/oWcG?=
 =?us-ascii?Q?BleSB4ZHOGcxpawwSsxruEx5iR8TFw6eljrNMDuG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5490.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b2b3d3-5668-4606-dbe2-08dc79b5f8b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 16:49:24.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLLTCbwApdF6HrScAwMN/exUSyuAvTEPH49W+axmsuq+7lvZwrQMY0cBzkc09T/TCcsaU5lWIe+qu0m3PvXy1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9717



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Tuesday, May 21, 2024 12:42 PM
> To: Jacob Keller <jacob.e.keller@intel.com>
> Cc: netdev@vger.kernel.org; Jeff Daly <jeffd@silicom-usa.com>; kernel.org=
-
> fo5k2w@ycharbi.fr
> Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
> partners for X550 SFI"
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments.
>=20
>=20
> On Mon, May 20, 2024 at 05:21:27PM -0700, Jacob Keller wrote:
> > This reverts commit 565736048bd5f9888990569993c6b6bfdf6dcb6d.
> >
> > According to the commit, it implements a manual AN-37 for some
> > "troublesome" Juniper MX5 switches. This appears to be a workaround
> > for a particular switch.
> >
> > It has been reported that this causes a severe breakage for other
> > switches, including a Cisco 3560CX-12PD-S.
> >
> > The code appears to be a workaround for a specific switch which fails
> > to link in SFI mode. It expects to see AN-37 auto negotiation in order
> > to link. The Cisco switch is not expecting AN-37 auto negotiation.
> > When the device starts the manual AN-37, the Cisco switch decides that
> > the port is confused and stops attempting to link with it. This
> > persists until a power cycle. A simple driver unload and reload does
> > not resolve the issue, even if loading with a version of the driver whi=
ch lacks
> this workaround.
> >
> > The authors of the workaround commit have not responded with
> > clarifications, and the result of the workaround is complete failure
> > to connect with other switches.
> >
> > This appears to be a case where the driver can either "correctly" link
> > with the Juniper MX5 switch, at the cost of bricking the link with the
> > Cisco switch, or it can behave properly for the Cisco switch, but fail
> > to link with the Junipir MX5 switch. I do not know enough about the
> > standards involved to clearly determine whether either switch is at
> > fault or behaving incorrectly. Nor do I know whether there exists some
> > alternative fix which corrects behavior with both switches.
> >
> > Revert the workaround for the Juniper switch.
> >
> > Fixes: 565736048bd5 ("ixgbe: Manual AN-37 for troublesome link
> > partners for X550 SFI")
> > Link:
> > https://lore.kernel.org/netdev/cbe874db-9ac9-42b8-afa0-88ea910e1e99@in
> > tel.com/T/
> > Link:
> > https://forum.proxmox.com/threads/intel-x553-sfp-ixgbe-no-go-on-pve8.1
> > 35129/#post-612291
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > Cc: Jeff Daly <jeffd@silicom-usa.com>
> > Cc: kernel.org-fo5k2w@ycharbi.fr
>=20
> One of those awkward situations where the only known (in this case to Jac=
ob
> and me) resolution to a regression is itself a regression (for a differen=
t setup).
>=20
> I think that in these kind of situations it's best to go back to how thin=
gs were.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

In principle, I don't disagree.....  However, our customer was very sensiti=
ve to having any patches/workarounds needed for their configuration be part=
 of the upstream.  Aside from maintaining our own patchset (or figuring out=
 whether there's a patch that works for everyone) is there a better solutio=
n?



