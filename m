Return-Path: <netdev+bounces-131003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5051498C5C8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4431F236D5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D21CC88E;
	Tue,  1 Oct 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dpLZr0AF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC62F50;
	Tue,  1 Oct 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727809578; cv=fail; b=pveCEH7S07PEKttiVQutm7Z2NHXdNTFF+Nyyr2PNogGEI54F734JPIB2aMzGz6KnYO5WNGfpS3zFyeT1+sZGtwXHbZFQD99fEVIQUUc1q4KvU7HkdyzHPS9Y6JUUBzurDxI9beR8OaV9oMH6gNTBpks5BVflKSlGtGiqJi4byHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727809578; c=relaxed/simple;
	bh=dVq6pZtGmv2+xjY8R1xEsNjHRGNXXujRzj4P9oMNqVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U45gp3S5672eRJx/oJBxYdFURABqYMtAHu3wMYpRixP/pNVRYhg+80rAc342rsA1+OmFa79AAfPmVKKqhK9R9+JTJya2+lMcCz61/VbTbKll5GBrfsc6y8Uxf22qBGU2Yhka1LJxqLM7T2z2T/wMJz68+SxukFuRWJqsMyoUtqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dpLZr0AF; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzQVPJ9wTm+YJZjYjGQsxsQxmGvK0tmJsrf8SchRGi+Y7EcwwfAJs38O2c8o9wXhtvEr6pxA46M007fPswJSCRvXjY5zHlePKfulApsMpAv3Bpboa/wyzL1faFTN8hNYbKOL3xhBEG8u/RVo6+llW7nurVnt4T8AS+tXKZacIKMZlle08JCVOIr8KTc4M1va/OJzg+R4f6/pq3UCUowCZTINeoYgPO3oq8UVwDGue5LohlgbDFt30djHBgFyzyy/cqHz8BoxFV3be6kYIMu8v+2vNE+K2RVKgp3uSKeIofdkuQ7H7zKJYH/RkFdAmiMNVeQta9fCeTyLjwOsMLCMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/3gb3uxmlngL4/+7cOh92uiz4ObKIJRyIhmCdutXYk=;
 b=bk7njFY7zEq17kT82MFIYar/2woCBRAOSVqbdGmWX/966mbktjUVhvHGFf1nxcWK8iluyxWTfv/rYPTCMxW79ANpJ+eBQHXepUAmOfmqSfHpQ6KLM4rH1G0LJ4wA4nD/2cHZXeztiv6K7QJUcQ85MkxNM1yFP8/mCL01Ae6oXpQOSNivsRXUk1JuQt+LXn5oMy3pk+2rB1paERcSTEtNxve5XwpLAYKOjBnyVIbWFNwJYf0SS8V0WIvCtATMd47nsyJ4YLzXxPG6aAIH3r7Q2rfyIE97sfzL1GM0gylUbqp+pJFODWJAlSfUg90lpDh4ORnMQPgPMDROGdLjMR1ClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/3gb3uxmlngL4/+7cOh92uiz4ObKIJRyIhmCdutXYk=;
 b=dpLZr0AFig6aLl9giLdJ22cI38mgLGfptdaZrWYC+yQxLqwja9gADkdKF2Zpd21ZJ9UWuOQ55uvEWzIqnnyH+QUinww2iCS5zgV9oepLSH8ao7pllZ8IufIk492B8K0y05S+stm5osSU+MEEOnZHGTLu17u522K2UJFswgTgHqY=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Tue, 1 Oct
 2024 19:06:12 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 19:06:12 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Conor Dooley <conor@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, "Joseph, Abin"
	<Abin.Joseph@amd.com>, "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>, "elfring@users.sourceforge.net"
	<elfring@users.sourceforge.net>, "Katakam, Harini" <harini.katakam@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH net-next 1/3] dt-bindings: net: emaclite: Add clock
 support
Thread-Topic: [PATCH net-next 1/3] dt-bindings: net: emaclite: Add clock
 support
Thread-Index: AQHbE3LJHzvIo5II8UO3vE1YJmyVILJyHaiAgAAdQWA=
Date: Tue, 1 Oct 2024 19:06:12 +0000
Message-ID:
 <MN0PR12MB59539E54E8BD46575FEC01B2B7772@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1727726138-2203615-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1727726138-2203615-2-git-send-email-radhey.shyam.pandey@amd.com>
 <20241001-battered-stardom-28d5f28798c2@spud>
In-Reply-To: <20241001-battered-stardom-28d5f28798c2@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|IA1PR12MB6164:EE_
x-ms-office365-filtering-correlation-id: 8378c83c-21c5-4b73-e91a-08dce24c1d90
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qAdUOpBUt71TV/x+uM8G6a4mDU+E3CbARinxFAu52lLmus4C95/nNMiUFVNM?=
 =?us-ascii?Q?YsQGSFZEogyiSBskIaGP1VUtSuiOZJ1fj19wxg2V91+UbOwzy2Hkt75wOqR2?=
 =?us-ascii?Q?WhxxiGB0TdynY8KIGXjwsh42BAr/T4t6tSWcIoLL24s9UXSOAGsku5zkzUmr?=
 =?us-ascii?Q?SLNT9PXTK/ui+61MlQ7nOfRoTWN2fb5wlJko6tWLo9AaljpQh3/CMNhTlAcU?=
 =?us-ascii?Q?1afPKw/dsH3PpASBl1LiY1NUr4/Q0AajDYDqWigTDaovbInCOK0ca0lZmM30?=
 =?us-ascii?Q?EGyw1hW2mrBsTbfBgQkxTP8r/V7Kz1recnngl8YHP1+95rvWut5G9sfCbCei?=
 =?us-ascii?Q?lnsBzwG+SNoWY0nGxZgdt/iWSl7+YWid5zVg66qWee8ELgvM5bAL6LQDFxni?=
 =?us-ascii?Q?7z6V09u21XfWeBWTh/s4v/jke0HfWSbeEnGZ2NMTeRlOXmnUupbiC06GCsjj?=
 =?us-ascii?Q?TvzXX4GGnaAxu+sGm93QVSEQ1leu7Jowmk5aaRecKwh398Vk8X4bG94y0ECU?=
 =?us-ascii?Q?8p/1NTk0x5r6fIOCOmK3xe9VLZNqhOZlxC+Bgp+/4igp4PPtkodXdPh3+UVy?=
 =?us-ascii?Q?Vrb6nK7IOac2dXLNJwAKovLOdRM418NXR0TDrhTlKaAhI0Sg14Q4MghWI4CX?=
 =?us-ascii?Q?DKhmi3tysTVNJ+DfQ3EjnFuHxMKnK46Vr0QS/Dq1FTI1Ip9HJtF7a/vGGIeV?=
 =?us-ascii?Q?Lh2TI5iBMgF1QleurkKMFd5KquOYnaAnT2px1Dee/MNGu3nBWqtiArX0zvTp?=
 =?us-ascii?Q?e0M4Q4jpbzvuGbQKY7/SX5LMj3ydO91RsowraIqY7x4XV/FCgVlvnRtp6MgD?=
 =?us-ascii?Q?HqUd+i9MA3OSHskmEzgnqMCdjqgq7IKsKwqJ6y52RY8CDdtZC1uGUwO2sM9p?=
 =?us-ascii?Q?uYWr3kBZWmEF214lZc0J9kVu+CQkQFmbDf6V763MM38ZnSq1i09UUofQj3FM?=
 =?us-ascii?Q?FKIg+AcvDgMTAwG/1MwYK9cRZPm6suL1eddv1eEYgP9wid4owUSwUrdNpo0N?=
 =?us-ascii?Q?AvXAOeqoUxUR4g6aclfTsBRqfR0x2TUnTabr1OnXqCuiymTr0+Wi0XPIt7Xp?=
 =?us-ascii?Q?52wGOkaWkB5zkmeg0XApbcfddo30tQD2kHh7ciA2/rHiv5/ASOwk07BiSdl9?=
 =?us-ascii?Q?2D1y4UrHLiKDwCYYATCvZxqu7O0dCJCUekA5sDyMzV77xqjnBOucR2bTY+hP?=
 =?us-ascii?Q?6F7OyXCGkaG6J6r5+xHo1tUnRrkk6hbimr2i/R/Y7O9Aj0qRM+FxxjqVnd82?=
 =?us-ascii?Q?vUE80gzRdkIi7VKcwKONlxy5ff4jYZfGAO//aAiNnAceCEhrJXjs2UUNHNxT?=
 =?us-ascii?Q?eAInJNSsvSqJdyFcngH66O2RkyYk6PcBiiKhhIZT5oz1LR4eW3fQCl3j8il4?=
 =?us-ascii?Q?X2VnwSVO2+JeIdWtkvQIgOG5mJX/QBh+iP+DgfxJ4c/1rA18Yg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5sxi1lQ2wP2LVchwjCWlVcNY68/cu+qYiyP4knNdhJa3HTS5dsMvdiJOnRE4?=
 =?us-ascii?Q?kewyClYZdpimdgbcke9oJculgLXqbbxE4a5MDrZCj9OFFJ9TNyv6ETwO2euD?=
 =?us-ascii?Q?XUbXPSL2W7Qg+nsGlRl9WVLxwEQf0fs9SG8qAv3zdyGAgSeHlpu991K7jUKk?=
 =?us-ascii?Q?CSWeimNs2lQWsPKWr2dteqmvquoqUvflm8XTGUUR6556eAIhTxQjomProiq3?=
 =?us-ascii?Q?gn4qKCw60UUGnRkoqUMCJo0aEvyFE8GqsWEQsFSw8mshT2xSyuKnJM5BliNi?=
 =?us-ascii?Q?3u5sgotw2WA0ZNk+LYPpSj2zIXopjAtqldi2LGYaexIc7cXsKTLF3SH80k+P?=
 =?us-ascii?Q?DXbHfGDOSsOqCOWvyjHqdiUrk+efgpdOJIhlmOYbeHQQHCuO4mjJb7pF7gaH?=
 =?us-ascii?Q?XaLZd8tkxX54D4wjDj/J7YtdA/SSfJfvsk6F1hr9sFpE1GEAhPzbJJotkKiW?=
 =?us-ascii?Q?z65M0g/im/YXNyFAEIuXqrF9QC1Bz1jCu34Uz7b4+RG85yksQomkqBO556p7?=
 =?us-ascii?Q?l77lLh3yrTmJowALQrx6P0mRIl+G26yJ10WfKU0ZkRvrXL0C5jwBgsk4nXjE?=
 =?us-ascii?Q?W37sH8d0Dwwvbyn8V8qU9vhVXrccUWb5zhvi2OOzXYh6+Wx1ppOJ4TRw9x69?=
 =?us-ascii?Q?CneBja6ttkoDacat3uismstLBuEAd/7bnLauOAI+AFV0o93Y2QcAejZkNsPx?=
 =?us-ascii?Q?EzMf7nZY688OSheJUBZD5oukkfPrEs47VwqHj+HVcdbhi+oIhpwnVViyZ95E?=
 =?us-ascii?Q?6GIClg+EB/3nNAMG5OCg1dsXdw1zXsNF7/hj0/I4m8rF7Prkg59LzGZn5ReH?=
 =?us-ascii?Q?6PSuqxQMh59Bprgk2Z8o8pOAxcpw8YUR+EVjxgtMfuffgsyBmYRaznbfPz/m?=
 =?us-ascii?Q?Wu/4cBKITOtHAjYUgqIhGI/RI8QkVggzNgs5Izh6m296uvADuQ0duOXWFjtf?=
 =?us-ascii?Q?aAfnTwk3pSFoCzyUoY/ag7x6rabvpJD0LriXY5W9hn6HwMLM+Wv0FPlqbePy?=
 =?us-ascii?Q?xTkniYJekexQWH4StQE6S3XBcxQ1A6K4MZTjg8HK8rz1vIiviSrOs2DFHoVW?=
 =?us-ascii?Q?QyUO9xyawIAEwSQv61FDMfJI8O3Kp4XyI9yLwcKuipVw600fCDMn50G+JSJc?=
 =?us-ascii?Q?3FQuyqki8GsRir51oYIWrHGDtl1xxm7EF2EmmJmWUYE+04CQkFSU9oZuhD4L?=
 =?us-ascii?Q?49hD1fru/VP1ba3VcaUdODi+QPHctR3/9fD896kN3PWXIwxVM9Vex4cZCsi7?=
 =?us-ascii?Q?a803LD6IgI4lTC+a8iAoEAwltFu3RnGjI29UL2d8hqOgAG4eQIDV4y0jJzJY?=
 =?us-ascii?Q?b327wiOuSd/hcHqSFM1dRwtuRJJUUSVWSC6gV0WFL2YybDAoD8zMcRDkfueR?=
 =?us-ascii?Q?7HDH+nwkN+gFiMW1vYNNSWvupuz/1SxDDp8zyfssoDStNH/I6RVjQw1gzT02?=
 =?us-ascii?Q?S+ZseaYzhhJjOzqlEesHK8KYpoVvPMc10cdy0YnuEWElfzGYAiEnXhS8qWT/?=
 =?us-ascii?Q?kMvUVXBudzya9auIhkDcZjIViDBuwZsDvz/8CcMNK8Gl/fr2smcXGsrz/ICg?=
 =?us-ascii?Q?NhEGXxoBwGgZUXzk3kE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8378c83c-21c5-4b73-e91a-08dce24c1d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 19:06:12.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WU2sszLfa8c1YmYbGfwEC/kq3zVNXk3fGlmuy57TSlYP27P0YHPViZ/I6/OprFsb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, October 1, 2024 10:22 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.o=
rg;
> Simek, Michal <michal.simek@amd.com>; Joseph, Abin <Abin.Joseph@amd.com>;
> u.kleine-koenig@pengutronix.de; elfring@users.sourceforge.net; Katakam, H=
arini
> <harini.katakam@amd.com>; netdev@vger.kernel.org; devicetree@vger.kernel.=
org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git (=
AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [PATCH net-next 1/3] dt-bindings: net: emaclite: Add clock s=
upport
>=20
> On Tue, Oct 01, 2024 at 01:25:36AM +0530, Radhey Shyam Pandey wrote:
> > From: Abin Joseph <abin.joseph@amd.com>
> >
> > Add s_axi_aclk AXI4 clock support and make clk optional to keep DTB
> > backward compatibility. Define max supported clock constraints.
>=20
> Why was the clock not provided before, but is now?
> Was it automatically enabled by firmware and that is no longer done?
> I'm suspicious of the clock being made optional, but the driver doing not=
hing other
> than enable it. That reeks of actually being required to me.

Traditionally these IP were used on microblaze platforms which had fixed
clocks enabled all the time. Since AXI Ethernet Lite is a PL IP, it can als=
o
be used on SoC platforms like Zynq UltraScale+ MPSoC which combines=20
processing system (PS) and user-programmable logic (PL) into the same=20
device. On these platforms instead of fixed enabled clocks it is mandatory
to explicitly enable IP clocks for proper functionality.=20

It gets more interesting when the PL clock is shared between two IPs=20
and one of the drivers is clock adopted and disable the clocks after use=20
and clock framework does not know about other clock users (emaclite=20
IP using clock) and it will turn off the clocks which would lead to=20
hang on emaclite reg access. So, it is needed to correctly model the
clock consumers.

While browsing i found a similar usecase for GMII to RGMII PL IP.
Similar to dt-bindings: net: xilinx_gmii2rgmii: Add clock support[1]
[1]: https://lore.kernel.org/all/4ae4d926-73f0-4f30-9d83-908a92046829@kerne=
l.org/

In this series - I noticed that Krzysztof suggested to:
Nope, just write the description as items in clocks, instead of
maxItems. And drop clock names, are not needed and are kind of obvious.

So something like the below would be fine?

+  clocks:
+    items:
+      - description: AXI4 clock.

>=20
> >
> > Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > ---
> >  Documentation/devicetree/bindings/net/xlnx,emaclite.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
> > b/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
> > index 92d8ade988f6..8fcf0732d713 100644
> > --- a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
> > +++ b/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
> > @@ -29,6 +29,9 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >
> > +  clocks:
> > +    maxItems: 1
> > +
> >    phy-handle: true
> >
> >    local-mac-address: true
> > --
> > 2.34.1
> >

