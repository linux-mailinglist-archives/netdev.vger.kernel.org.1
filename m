Return-Path: <netdev+bounces-111979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 705C99345CF
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 03:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9316C1C20D13
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8290C10F2;
	Thu, 18 Jul 2024 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b="KjyLeCXc"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2138.outbound.protection.outlook.com [40.107.21.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0219F;
	Thu, 18 Jul 2024 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266251; cv=fail; b=RyZbdQ9o1f9s7ybTw8y0RGI0cWcHs2iK6zDEy6vWlQfbx1SYxD05wPB319C3/5ffre+9vl2xY4B/SCmzjFJkmsm7TZfMpXYc9zbBkrTtJkZy3V+hQjMJnuTvciYCrB98dVhS2QV08Zyoi+Lv4KDdJJcjwlWb/DbvLQPRutyxmkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266251; c=relaxed/simple;
	bh=pVaSmFqdNsEjDxPRDtVZiBX6tgQjdmVh8pzL78B4Hes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BuFtr6uwVMhHs+/JcyAqHV9On6ohmCnOb7URDzYRBv1tAlhW4ZIx8FwKEiQK5btkjTFCXwD1jS3ydxfypWdmsPaPTknyGfUqU7GtrUnHGFeSYuhdyTdnjARkRokh06PbsHVJ9sr0NTAEQExp+aMQol4M2uCQ6BPs3C83Ji7Im6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com; spf=pass smtp.mailfrom=endava.com; dkim=pass (2048-bit key) header.d=endava.com header.i=@endava.com header.b=KjyLeCXc; arc=fail smtp.client-ip=40.107.21.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=endava.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endava.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtMZp+8NkSCb39cH+5F5bjwRCSoMbrId9JYj65JmQsNbNZPSJNgHJ1/lkVXi/QZMLih9KM4vBDDj75hu88MpaKEgItSJR6J5KDXO3pY7TEoqJsxUnK57osuLbzA65PNLU9GRv8FPVH0Qi+MhCoxjvEmJsrLgixhg6Yk3Hqi2dK6WLIBFfgqvg17PX2ncDvyAP+sCAPFB+2gS09f1Axkf1qqqBk/umO5T5G8j5cgGDUupaj9y0boc6Cny8wZJ1P9ykpSCQMoFtNEXTVQZwy8nDgZ3and6G+KccpNv3CeNVwkMroIr+Tg6RHap1ArU9feKbY9eiOlFF9KEhr178x1nLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVaSmFqdNsEjDxPRDtVZiBX6tgQjdmVh8pzL78B4Hes=;
 b=Lq/hlhknpI///AulnSR5pxZONERQYj8aTowdfC8ElcHtj1YIhsLJ2e6ELrbmW3m6OTcboV8wOxDZRIh2HMYkEycOJyUQrftj2SaChZaqIYw3Nbh3sK/MBQxF/5Hy9R8EVX0UwIY9MruvtL4pGMkXpnkqDGHhEu8MepZoXvHvsXBfDtD8hruwvCWTN/sxCKdDz7XbyOG1lIZMBE6jkiTpnpOeu6cLpUuvt44QwJntYttp/MulpfSUfnR6iVw5et3fYRz8kokWF+UfmpFey6/9upwrlz3GKNMUhVxPa9QK3hju0TeVN7NSpleSSvBAIGT4nhZ1ieUk2pJyp/O6SGhUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=endava.com; dmarc=pass action=none header.from=endava.com;
 dkim=pass header.d=endava.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=endava.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVaSmFqdNsEjDxPRDtVZiBX6tgQjdmVh8pzL78B4Hes=;
 b=KjyLeCXcNFyMOwB/QOqnzWhwzNe3AcQBLPRcNE+hLmks326BhgozC/Jypqof0i2+YQfOwR2VB2YumagRVQJ3hM2GTzHzpqbGKcqqA3znGDis4ph6BAKKGduNl5drBJrlgJwg7jB/6tBcHFBqZu2dQ2LZ+eiZSNLRJU2y2HlknGz76etUOX0WYMfSqt4jY8vxnLooBNOu9OmIiDV928WcadqxDtYqXbT0Yue9JVge1t3ah3xSzgnAPjzOSlzcF7/BgeRVtFLFGilToCF1VAAE0+hhRlQ5pixQc8NNE7nFUYiTFW+jD/IuaHZW3GnSOC8v1EQ0feKV2N8UJHziOCrmow==
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com (2603:10a6:20b:67d::20)
 by AM9PR06MB7331.eurprd06.prod.outlook.com (2603:10a6:20b:2ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 01:30:45 +0000
Received: from AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41]) by AS5PR06MB8752.eurprd06.prod.outlook.com
 ([fe80::72f2:c654:1827:9c41%3]) with mapi id 15.20.7784.013; Thu, 18 Jul 2024
 01:30:45 +0000
From: Tung Nguyen <tung.q.nguyen@endava.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Shigeru Yoshida <syoshida@redhat.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"ying.xue@windriver.com" <ying.xue@windriver.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
Thread-Topic: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
Thread-Index:
 AQHa1yUvQPqLAGQ2A0GB9aoYG5W6f7H49WZwgAAEmICAAD0xAIAAA3+wgAAaDgCAAAO9YIAA1GKAgAABTLCAAOB6AIAApuAw
Date: Thu, 18 Jul 2024 01:30:45 +0000
Message-ID:
 <AS5PR06MB8752E506B21D2922F7D08BE4DBAC2@AS5PR06MB8752.eurprd06.prod.outlook.com>
References:
 <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
	<c87f411c-ad0e-4c14-b437-8191db438531@redhat.com>
	<AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
	<20240717.110353.1959442391771656779.syoshida@redhat.com>
	<AS5PR06MB8752F1B379BB6B90262C741CDBA32@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <20240717083158.79ee4727@kernel.org>
In-Reply-To: <20240717083158.79ee4727@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=endava.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR06MB8752:EE_|AM9PR06MB7331:EE_
x-ms-office365-filtering-correlation-id: 0776c78b-dccd-467a-c023-08dca6c93ebf
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Bv73aR/j20UE/S7jdeyx05FpWHXT31uimZ+ME834KxHKvtL/6i9Tx3bnh/Oi?=
 =?us-ascii?Q?huDu8tCCdBD4P+MWDm2C+rCwZwl4ZYkQRqonmEjHhBEg7z5j0GTZ/+z8DIxr?=
 =?us-ascii?Q?YY9i3+D1s8PPMXUsEt+DviDPcsTcJfVVNuJix8Zo/87AyQvKXtTlANMIyOSq?=
 =?us-ascii?Q?gG4jJmuPMiLmikIBr9AmGvxZjY7ty7Yh2rrUI8bRHcanZZRAcDKHP2HhJGW9?=
 =?us-ascii?Q?FBp0kc3VJiy/sRlJjdSmvX7JIl0IH6ZCblsdePLFRSgMDR5e3HBPF5Woil7O?=
 =?us-ascii?Q?xzq7YzXQ3EX3xdT2ZN71z6y7aCc6yEslJiflA6BsAa/FaInlt8rH/V7Atk86?=
 =?us-ascii?Q?FW2zOENWpwr3KIvdS8A4LXwdxpNKJyUZDzmKWJB8Hviv/tJtltoEj6lz8R+K?=
 =?us-ascii?Q?s7pBb5bbJV5jHVuWxK9ATm28tRYE9llQQKZspBBhWfe1bB5EtqdL89yrBUW3?=
 =?us-ascii?Q?3p+QAdTnQt8PKZlgym118bH1MzqsyIM1VQSUO68Jds8VCaLII9KXjAkAJujI?=
 =?us-ascii?Q?1Xfzk3zg6BP6ljIuUQUWIwMYOwaF9dXi+Sp43N2O28korJz/PuHgyQhHm1Dp?=
 =?us-ascii?Q?PrnncA7mBsTnkDK8Qs5uI08TvsCVBgTQYwZZetgh1FXhp1ulDxv3Q+IHetYp?=
 =?us-ascii?Q?dKFcFLL8fEM9oO0TZUbg6TZ0rPZw/oQwUEId5NBLUGQRjH4Kr/xtMf4fwIcj?=
 =?us-ascii?Q?xBCOd8w4ltxRsPztfDUrbhySco0t8i2ZrD8vdO9rqKDlz4uwkwvm0LWTAjk+?=
 =?us-ascii?Q?fvLgNRIUUsJZW5zGjfjqm3k971mmkr2MBS4YrqiI1+xN3tTrE+WnAxgzY2t/?=
 =?us-ascii?Q?+oEtG1bxlB5BHvtz7Etq3LAC5fU4oRWOZou+v4ixXXd/fgYYREcYDcM3RD70?=
 =?us-ascii?Q?ZQYtVNfyxNJdfgJCM4diTFyO/zA+PmY9CBm6nyc/jcsxwPdkvegE8XpIiYTA?=
 =?us-ascii?Q?i6u4kD8reV2hy+eq/OFrsBjlYPGJNdfF4uG71OMzXZStrGFq7ZjND5JkbE53?=
 =?us-ascii?Q?agg0f5saN+C6h6dX2xIaLpPeXYHqmsvYTFOb9UcEaMfnvOwh8AZ6e3KZCSIv?=
 =?us-ascii?Q?0vczJtW1ZofyWRxHtcK3pJNYpyPQ8m+/lQluX5sU2p9tQS2JURmGvLAxNuOE?=
 =?us-ascii?Q?qyWhgFNE1DnL3uanPQBcgpFmiE6Nu9WrRPeGpHnNOkZDWWVUBS79qcuVdL8G?=
 =?us-ascii?Q?kwXvOEpNbIgNhkgSF/xRZHqgimTqvolInpAO9QsKg+Lf6qXpAC+m1rvialFw?=
 =?us-ascii?Q?BQonuhvCk6pO92MH7iqhR322xX3ZvUhancuNv8l+rmr3GwIdIkP6TUeVwQh3?=
 =?us-ascii?Q?vmup8fUymqfc/REAx2CfwAJTNjKx/E0GN0KcgBIRl/pB9YPtwtnS4RSNT0ka?=
 =?us-ascii?Q?AiJFrK929TGHL7TMik89GuBHhzocSLrEdj3mX6lqEEtF0ZGJKw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB8752.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8+YIAzG7Yf/XH83gkVsNH/J6fdXaG+vyv1Fv14iWuxIOEOeXc29o8KTFCljU?=
 =?us-ascii?Q?ctTTTf3lfUriBfYORfXk1OJhaBemYIIwYYMrqEW+Wod+qc04sxIZrnVyb1Zs?=
 =?us-ascii?Q?M9UP4iaWPJLtq9zk1gwEDPhbwYfbFoEl7Dn4ypxrynLmgkeO8GB9/of4gFZK?=
 =?us-ascii?Q?bFYUKGDq9NzIg69R4FNOUJJJd1wMd885wKaokmcnB2V/WzjyRCHkp7U6QMdu?=
 =?us-ascii?Q?HqgbJEmde5vroyY3gjjCoI5x5+wPTG/P1d40XDvkKLcpIT4K6g/tLGik55uf?=
 =?us-ascii?Q?aFN5DolpSwCePlmg3ji1HeTtb0OlNR1zJ+9zNLzrK7Nn7hZyG/n6T3QK9wVY?=
 =?us-ascii?Q?+oiJ7Nvhsr4dnUWdZhESMA01opt86o+aSzc2gAZdv9080h9/RaVfCdoxbTeE?=
 =?us-ascii?Q?6nIftBpZ8ks2nx3lSNoA2O8vV1VPOVJdheA0VIf+2ZCrOn7bZeEMI8PveOEG?=
 =?us-ascii?Q?9NYc3dXuv8WzZ6IGU0ctSy63ktLg42TbCQzJSMqVkvP/k+9unCSqfejUqyiB?=
 =?us-ascii?Q?CMw7V7/RfECYIrzwFgxAGQZrmdm9j2TxHqZgYArgcJACjobZ4XX64HktPZ/W?=
 =?us-ascii?Q?LTOssAKrZ+fVBst7KFPBWJgmC327GihvfP9vssY667Do/IhCU6qjDhSr8jPx?=
 =?us-ascii?Q?cuLv5vojsPzk8gbTDdjpxuwyNTIYQNdLEAk+rHrFi0OYqmctfBgz1muZifz4?=
 =?us-ascii?Q?LE35ua0A9xPr59B99ELtq8AexbBWPBs0MIkbPy8JWkuRMQ/bcOWwrXbm26My?=
 =?us-ascii?Q?HZRPJviWAhrG4Qk7YRa0bYjx6C/Bqt13b/B5rmf0l3Vs61GoxTh6FZmGdJQV?=
 =?us-ascii?Q?uSue6M1n88joMqelaJTeemnE3h+eYUUEOucTxuLvMqaNPVvnOSUajSqSQlWl?=
 =?us-ascii?Q?VJ4wu9eTX8FL+tCf+sEmZv9nqL662EJxGivxGc0ribhoD/SC9+c8mZt6/19d?=
 =?us-ascii?Q?pAsIxPZKeJJRkYe1vb0km4v/LkUUIRDbOweXJznT8Fze1NXW7XVE97x8NqcW?=
 =?us-ascii?Q?We4I8/KL+ywvF2dB5KxZ0OU9llGGPQYL6zKsrCVaAaty5B2knqBbWpzb4RZo?=
 =?us-ascii?Q?Xxn9Dd40CiCMooVvPZfSbTSuFV5DATPJ91Qe7ukfsqtYyu5EbXQDo0HnGdxS?=
 =?us-ascii?Q?lTmpinH4tpCmPpah+JFybi2IcHoAI2A6A4ImgCEAcCHfx1yTKAteNK28Ubum?=
 =?us-ascii?Q?i/8AF7jX2wQ1Ie/oGNNCjJlqmiEFQuCGO678FjcHaJztPcWPPlH/U+gQWHu4?=
 =?us-ascii?Q?0v5JowyeteETY2DogehORmepXz6VxpXMkwwF+T5MGncH8Odk+BBqHjMSpTF6?=
 =?us-ascii?Q?EARZBe82kwLIsfSV+sJv2y7CLhc1MPvLR4XIk3063ib6AshdesvPNjKSAqWk?=
 =?us-ascii?Q?+2VOAlim1pwnUHfSLdhg9TtDWO+JYI8QvGC6X8HOzbctbjEDzrgUkObgGzmx?=
 =?us-ascii?Q?oPXEj1vS0iQNHB+5AiF7Qz88lVVz6uqQYMTPAMDuGD2vc9+37JGW2TYKdWwV?=
 =?us-ascii?Q?wWFRafoznZyrS9VnZwUe2enVYissvJGLacK6WoRNmFGyzdKr3sFB1paVJHuX?=
 =?us-ascii?Q?uKy+UrWgQh3JSVqk8Y69er6QszUOyYvJGT9bU4bH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: endava.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB8752.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0776c78b-dccd-467a-c023-08dca6c93ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 01:30:45.1043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b3fc178-b730-4e8b-9843-e81259237b77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 733Abhh2AbDy9q4Xy1UKThYM+2iYqyfCsXvRDVIY1xMusRo/yRfVl3Kkb2VH1FG5nXk3Twtwq9+/a/eySv1ECQF2ZTd2bDdM7L0PP+RuWCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7331

>> Reviewed-by: Tung Nguyen <tung.q.nguyen@endava.com>
>>
>> The information in this email is confidential and may be legally privile=
ged. ...
>
>What do you expect us to do with a review tag that has a two-paragraph leg=
al license attached to it?
Please ignore that disclaimer message. I am still asking help from my organ=
ization to remove that annoying message.

The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee. Any opinions expressed are mine =
and do not necessarily represent the opinions of the Company. Emails are su=
sceptible to interference. If you are not the intended recipient, any discl=
osure, copying, distribution or any action taken or omitted to be taken in =
reliance on it, is strictly prohibited and may be unlawful. If you have rec=
eived this message in error, do not open any attachments but please notify =
the Endava Service Desk on (+44 (0)870 423 0187), and delete this message f=
rom your system. The sender accepts no responsibility for information, erro=
rs or omissions in this email, or for its use or misuse, or for any act com=
mitted or omitted in connection with this communication. If in doubt, pleas=
e verify the authenticity of the contents with the sender. Please rely on y=
our own virus checkers as no responsibility is taken by the sender for any =
damage rising out of any bug or virus infection.

Endava plc is a company registered in England under company number 5722669 =
whose registered office is at 125 Old Broad Street, London, EC2N 1AR, Unite=
d Kingdom. Endava plc is the Endava group holding company and does not prov=
ide any services to clients. Each of Endava plc and its subsidiaries is a s=
eparate legal entity and has no liability for another such entity's acts or=
 omissions.

