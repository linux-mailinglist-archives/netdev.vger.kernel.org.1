Return-Path: <netdev+bounces-276825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJzeLtwW12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:02:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4148A3C5DC8
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 688ED300F19D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 03:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FAE313E00;
	Thu,  9 Apr 2026 03:01:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2136.outbound.protection.partner.outlook.cn [139.219.17.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5D71DD525;
	Thu,  9 Apr 2026 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703662; cv=fail; b=XX2d/iGZQ6euYALI6lxCLxjOjineCq9mk9qJMWXxFvhg6V4jcS/ecPOkEGNF+uOOHgOyqNJf+vvg95JgtlHtxQRqPvSmZtrywyQBSklc+571uwy71tdndxGQRUOsFAV/DRYsLdOvEw1OzXRLiiGd5ESvTxvwbGMooqCGsB8+BNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703662; c=relaxed/simple;
	bh=a8CfgxYXFxb96y4Ja9jLW+WhTgYhsXgrcPCeNspksx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oF/LG2TlfMzWL0YdlepRAw1+Jo3fyrcsqMJWbS1pr8lus9/PCm6QEgIoTzMcgJd+U1QBEYNI5Nn0LUdpiBvAA2uN3Akg9ZvGnrneezgVv7a0FascsvTVf/LFfkg/VWldJHudhnp0z/TuTHmVzlc2Cwj4CFeFnHX5rnMcs+LY+QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVpaNoWYCAXZS9+oPjIa3+houfHc+C3M0vT5xqzfsXazZotzHSXW5u4jC7PJ3w7+qaFeiZbkqoo7+LyMxHy1YXVP3DqzmgtHTCzCH5YsV/kJisy4prYzfHhdgbgA34PfYrA+JQk/0ht7kf6FNLrfERBgsQLoS1qqw77M0TS/jurBMVj85OX/ZeSoECx2akjjFO5n2z8f6+E5b875y/XS7+xfY57d0ML5CbpBfK5a2rplBgo/ifHC8BP0EwzxTjqnzjfRwgoYwEderejBjdczrEoioyzH6Fzsmp/0ie5LzjkW39fWJuUtzEODM83UVziIWZboUsXjKA/0AUZND/+zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvvOCjNra76HwJkjKUJtOT2vW6llbn+hOHZphbudmqE=;
 b=dUnEN87swffJMRO03o5sjMZaGLQd7w12N9RQuUzJ/629dzn0lw8aZJqAY/LL9oZWRig860xz5tdkLjKrfjnCth28wfgZCgw7WbWq5vzj7uJ6nWy2bIZ1hdFyA4F5oxPeRQvHFd8lID+15QvKT06Z8MwnG6k550tcJx0uSbN37IvuKvhpCLjBo8rl/v0l/DmRLBHCz1Q+gRUAyXeAufAWriSy5u3M25SY9XwmZ+UUtXSkU0apzxaz+/YED66XuMpKWTszXcf1ppDJJS4U1UDsz5TZ0VHMQVaQrAIHn+VZtsgW4r3JVXQN+3zLLt006T88IYO+Sz2upAYxK0ZkXsOIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0701.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 9 Apr
 2026 02:44:53 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%6])
 with mapi id 15.20.9723.018; Thu, 9 Apr 2026 02:44:53 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [net-next v1 v1 1/5] dt-bindings: net: starfive,jh7110-dwmac:
 Remove JH8100
Thread-Topic: [net-next v1 v1 1/5] dt-bindings: net: starfive,jh7110-dwmac:
 Remove JH8100
Thread-Index: AQHcxzPnhJ0ZnP1MSE6q+NOcDWTMF7XVSfIAgAC9VPA=
Date: Thu, 9 Apr 2026 02:44:53 +0000
Message-ID:
 <SHXPR01MB086305E0C766E8BB17AF18DCE6582@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20260408084416.29753-1-minda.chen@starfivetech.com>
 <20260408084416.29753-2-minda.chen@starfivetech.com>
 <ad9ee916-6f8a-4cb9-8016-54a02b00c7ab@lunn.ch>
In-Reply-To: <ad9ee916-6f8a-4cb9-8016-54a02b00c7ab@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0701:EE_
x-ms-office365-filtering-correlation-id: 57dbd915-6a69-4f25-001b-08de95e1fa5f
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 vcxIKflegYIss7+Myn1yZuAVvEPUN4rQ1Zq02pwEBrOIq/7eEI5LKWhq6b/Zscrc4TOV3bciieR1UsXyOwPMRlaaYJqZTfPJ3ReM6ZBlceuRRqaTTqA8PFbLSH+96HhaDaZ3fZJ1Up+BvsLe21vt1CgQIwbV3r6zOgty/WQYnyIc0oJM4EjGPhQ7XA24BQbpnNcM6ihpyQ6zgEtgYQKnfAhIvklSbu+FydWAQWm0POIY3WSRCVEGHipcLtXNHHGZhN96YJXCkOUWOnZdFa3CVwotddPHJ5R7+Knb8z1/fLu3zWjUv6IrFk3RiG2QFyFSrlNe9BTuSnLm3FD0Qq+uhOJOig22glspQJgwgEjCTPwedi0eGyEpKwZ3vH+1pJ24HLW4OuXZ8c11HxZURcmPhDiBHW+MqWBdEbKtGaag2bk5nSE5jTqZp5HCPZn3TFjW0dj43rGEHp/6gKjJsiZmjIxTGobFMsT1UgoiA+vZpZ0/cgrkDiqwHp7k2V7QQXAEB9lE5uc0dkON9DI1bMntE7+g5zQYM8Ydsv8X2A6/789yY3dBtNCNAxvKp1HylAVnU+U4zkTm/emLOrwFebQCbJxMZ8kf8bfUfzbeWO4cbZU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tywBFK0sT/KI9IcCy1ZbOYxYOWrtW+meFNdngwFY3S2/tkoSAKl1qF+WkSlF?=
 =?us-ascii?Q?nCfkmPOWhBZxhmZoEeu5A+WUC/QJYj7+3weGZFz5e0jtkglE4YuBqmjTqtzm?=
 =?us-ascii?Q?ct7h4DLydc2NLP9a7fq2KllcHghZAbCGiPFTmZHx4jacwb8tpTYUnLaKoYzt?=
 =?us-ascii?Q?agAkX3p1tJVZs/XSKY/EVgQu/7nsT/tjbxy7aO3dzbXZNL8lguiXrH/UUsyO?=
 =?us-ascii?Q?6CVjmGhtuJs0uIIsTpZryeg8ZbM40vsObIYtwEw6vFgtQ6SFT6tamesOeCrN?=
 =?us-ascii?Q?UDzBAVmoJU+rsb/oGIDe7QDYKpByrrgT6PItwz8pzfJuDzD1uSmLQBaMFfdB?=
 =?us-ascii?Q?57cXVUWix2BP+euMU0QSSzfFMZWj3XB2pTCw0i5DJrO8aNV4NOn4g52GyFll?=
 =?us-ascii?Q?7Oe+ozbP0kIdIsK2U2Iyvh+wyRaJbGgm7q2XZ1RA6lI0H3fIGwOOp7sF9MSA?=
 =?us-ascii?Q?83zgHE1HacJ5AtV8BkYWGVSCbGcjZy+NHDH3kr+V2oFEVtU7BmYfp7lPg42z?=
 =?us-ascii?Q?ZXvpNWcixA0oIcWkD6irWVoa3Zx1Tbknr5hDm3rWHnfmmYxPM4tfJvfB3nEI?=
 =?us-ascii?Q?QdKGAGrBf5ZTrPk8BH6bGUkes6hOLqWsH4sNbrBdAIMWH0EDljvb/5qmGdsO?=
 =?us-ascii?Q?TvddlgxJT40Yj7nMqDHLGNRxx+eyeS6MIaKHNhXGa1TCNSelgXCPC6eLMBN+?=
 =?us-ascii?Q?JCrbpP/aHhUx38mgdcU8B5nKiNXRjc3xmMQd5r+vRCNtvJMu2zEFb8Q2b+Za?=
 =?us-ascii?Q?P0iDijpvivUZV5PtBflrZhl8MSV03dsETWX1EkgdSF7+MhaBLQgTJmv631/8?=
 =?us-ascii?Q?um3cZSaUgW514Cjfq4ueeAJMWpnW/AG7exai4bMf/17AyYr6FGNmPUU/wlak?=
 =?us-ascii?Q?OHC7ziX38nj4bNKPEeuJJJ5VfjK869eopIr1TheQTXAaFX/+3QNSLQ0MSgje?=
 =?us-ascii?Q?/iaHJCH1avxsQ+aNVP6dYFbxsvBw53NjbUIGSWfZ8JKTYlx5bG/8TxhiMTnm?=
 =?us-ascii?Q?V+/XbcCSSXpTgZkRWq6SxO4dCgl8QSjN6wf7a1sVo8W4sE7B54hQzphRSEHa?=
 =?us-ascii?Q?++JiYnmVtjGb5LKMdVNtl4tYoCAjM2cdi1e+4VwAxFJLxW0JLQEmSK0ze47S?=
 =?us-ascii?Q?p+B5tpfDlIWLQz4PwmZR7WsdZZhNNA/JduZR19yq+iRgqDwUPUz5R53wpZ6I?=
 =?us-ascii?Q?1+DxLbb7WapMDQdQv/zXihpcQo7bKNxt48y81F4IR+SW3vEnk8GSSFbsGPEe?=
 =?us-ascii?Q?fI6NXix+8PHmwq/25tU59FV/hrIVL+jZE2Cs5trhhm8nT+jW6tSfA3PCkFmG?=
 =?us-ascii?Q?9rv2/HDGOeQ3t6kNPggcLUHGyGRhvSMJxO8sXYvpLTAqWmwomkQDNtPihDlS?=
 =?us-ascii?Q?LMXgpgs0GypMRlcbBNA/eapCLMNvI+CQDSFSkDs77iwOT7kR16wEGbhwikhY?=
 =?us-ascii?Q?pIvussjavXdwvW8CeS/AX49lcAZOf06DR79LZX12/6IxKGwQLTHAQ47Wod9g?=
 =?us-ascii?Q?Q7vGVHstrPV7wAGEWQzvwWqUzsmpQ7X1bPOytZlkhUtWX+G90pXU1bKcx0rO?=
 =?us-ascii?Q?ZM6KkbxHnEa09hIMuOA1xRXRv0FR873TE19XhUOyLAi3Mk27OwocdT9L/wri?=
 =?us-ascii?Q?srj54JMb+Oa0cu+veUwfC+ceESMGfkEi+6/2rrz0ltdWvK9heVTXgEVjG+xp?=
 =?us-ascii?Q?pwdrcSDoF7QLuuYSJz06Bbl++I3pe5oefEL99Gf1s1Qamk3lNH0KUCsNo+Y2?=
 =?us-ascii?Q?kGpqebYTTROKtWdXbQ3VPpyA7ajLDCQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dbd915-6a69-4f25-001b-08de95e1fa5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 02:44:53.3800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTbNO4gYCuqvLF/1xS1pU1QyTEBNQ8S/62nF/IV+Bstj5di94BSUipt5qkFbhzMp7oA+BuVZmin0474hAG8Lr7VNwCiNyT+n2Ao0KmHRZu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0701
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-276825-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.016];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4148A3C5DC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



>=20
> On Wed, Apr 08, 2026 at 04:44:12PM +0800, Minda Chen wrote:
> > Remove JH8100 dt-bindings because do not support it now.
>=20
> Could you expand on that. If there are devices out in the field, we don't=
 just drop
> support for it because the vendor has something newer.
>=20
> If the device never made it outside of the vendors lab, then we might con=
sider
> dropping it.
>=20
> Please explain in detail why this is being dropped.
>=20
> 	Andrew
Yes.=20
We (StarFive) stop developing on JH8100 now, And do NOT release the SoC out=
side.

Hi Krzysztof
 Could you review this series patch 1 -3 which is dt -binding doc  changes?=
 I sorry
I have sent you to old e-mail address.

