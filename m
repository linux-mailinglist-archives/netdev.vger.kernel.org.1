Return-Path: <netdev+bounces-220203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CCCB44B99
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CE5A07E78
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B4217F56;
	Fri,  5 Sep 2025 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lQ2Uc9NR"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D014E2F2;
	Fri,  5 Sep 2025 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757039156; cv=fail; b=EGk2gm3qv/KME2DTw7EjEr22k8b54UHSCFQJg7iUiOh2PKa5aL/ARoK5LNlhtPpkRi9gGKaY2491w6bJyNVpw2ZPJjnVqD+yyXjxEuZUvmy08itk+pIEF73+tfBNNVapLw4KipZWB3d0MpNdg1BjV5t4/5qU253LTvAlppivs2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757039156; c=relaxed/simple;
	bh=SsgH8Uq+mp7YSyZ10w3Uf5/1vURNo3J03OekjSFaPlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kKusqWd5y67Qsh7o2VZaoUc5d0Ywcqd6NTFyxnZj2GV3JYkaGWH2FncqLNatsibVAMXAC0evT+d7i1fbn/TZFog0KvR6vezkynEU+rCq2g7iJmXQx5g8wjOE47rmydtPAeYbTN2Z9kUTDZSRsv2W1pCPQ9KY7ZABbGxD9r6IvtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lQ2Uc9NR; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diCTfzCUYPOPDGTeDy/0UUpcEngoXjnySJfTBdCIchUC6AVdZD5jJ/TQH/aCK5fSnNkvqNytWYd4NiTyWfav7Bt2mGIyXTMYwmdbzrE+HgYOI5uUh90N35UrY+qdLSAXPCG7uE52zOTjLX7VvX7v79aB2p5bdZbFvqSXOr2A/QX71UXBmvplcisQ418n33aNEwDaxgjIWN8jbfRN5n8ire6u/aeNYtJ5J98bPjIQhVo8EOzt3rMkNQ9cj9kajqIKeECvPW0zgaBl8tIHRf25+CUof7X/o8n6tdNiY4obEzxaxYMVAs2PLO+sFj1RWJrOx8jYEzghk1oWNYiSUCiQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZfNIOHdU1maA9yt0Oh1UlSOE4FsDJhs94bEPM0WFzM=;
 b=t80tAEN7V9WAnjUSfNVeY1sNkwcLfCDUOVg02fS8wjNHmDuryZR8Zp6PavfqeUU53TfheUgtpvbJtjNKZItnBcRngS1PKue1vcqxJlBLMHX+oby4jx5HaPg6VpClz504cm4N2qbn4trvlivXKZ+fJuBWGel8ZnASTxWFHogCleEQ/aAUZjUpmvp2ogS6fiY16xNp+24rq4s1d7aQL5BfJmvN9+ISlNNmFw/eb2W7EmuWi8g6buDmR0N1/bp+2L82PlyS2dv2EqPUqULZeBX1enCYBc/vSB6va7+jWVZY+uUmw1doaM3c0B9hrXvj1HUnGBjT11d+Fvs7PEc1EFG3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZfNIOHdU1maA9yt0Oh1UlSOE4FsDJhs94bEPM0WFzM=;
 b=lQ2Uc9NR5EiypJUs5CEJMTSI6P5xvTPiUYU7aXe/xWHDZPvuKFw5tq9Dr79tRUKKPvZaflFqSmgVf/AgCHRhrQ79I8dBVzGqxgbEJN25AxHkPjmi/u3n9lcssRi3yY+dsW7cA620OJaiGzV6RS92Wle9iUO+uulwONjeIXzHBsMSI4EYC2t/3SlBIj3qlHEbiSI+CWloveVzsYDqhBL31W5oGQRSPdh1/CaEdRUZAoyNMNCW2DY5mo3XN11HUNZJFdDb8f4LNFg53b8QmACvOxXiJR6p2yX83TPvxQpN1EmZWGcT5f7J+DAVGe0VZWrXIATEL5ciHvKSuDzRrlyICQ==
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by GV1PR04MB10584.eurprd04.prod.outlook.com (2603:10a6:150:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 02:25:51 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%7]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 02:25:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>, "Y.B. Lu"
	<yangbo.lu@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH net-next 1/3] ptp: add debugfs interfaces to loop back the
 periodic output signal
Thread-Topic: [PATCH net-next 1/3] ptp: add debugfs interfaces to loop back
 the periodic output signal
Thread-Index: AQHcHLD8ewvtanB8Y0eGvBgSbKKSlrSDBrdKgADW9QA=
Date: Fri, 5 Sep 2025 02:25:50 +0000
Message-ID:
 <AM9PR04MB850521C7E01BF30E5BDEB2E88803A@AM9PR04MB8505.eurprd04.prod.outlook.com>
References: <20250903083749.1388583-1-wei.fang@nxp.com>
 <20250903083749.1388583-1-wei.fang@nxp.com>
 <20250903083749.1388583-2-wei.fang@nxp.com>
 <20250903083749.1388583-2-wei.fang@nxp.com>
 <20250904133011.asqvsucdmuktazc4@skbuf>
In-Reply-To: <20250904133011.asqvsucdmuktazc4@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8505:EE_|GV1PR04MB10584:EE_
x-ms-office365-filtering-correlation-id: f60be124-64eb-4a43-2396-08ddec238838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P+SfE6QJLySBighYKF4y9wtkCQT6rHAtCNKJXWSGAqB5h2CnhpvrB63aaJ7+?=
 =?us-ascii?Q?H+SGNv5NVCazmDA6tbp+NHzrJcpxBg4VZ62JK8vxXrVM1Fg8QFvh6P97AIDu?=
 =?us-ascii?Q?9+foNdWUZPfsfPJtRrbMa/2YR34llu8G8kbfJRqqEEAPCisHbZI1EmWJ5jbM?=
 =?us-ascii?Q?bKtxu7pT6fimEyVDg+nZzh7lU2kiWOaPHcpl9SlIWORYE8MsNnDiLAwEOUf1?=
 =?us-ascii?Q?RFh1HOpHoaFLZj9BwTl2HlKkk+JO07X8FICFiu6EUWMN1+dPLcT4Oc+9sclN?=
 =?us-ascii?Q?QmzqXrNYTDI/LHoj+1Pgbhj7WG1iFy/ROCoS68N0z+45ezku3BkBgrLVh3nT?=
 =?us-ascii?Q?TNtj/qw+0WEH31iybc92ghjyt8JSb8AvlJ8bjtOSDEESoSax+qNlfDhJDpS1?=
 =?us-ascii?Q?T9i+icZmekP9gsYsoWHxXwrAKrke+6190vwMAkNkA92sPllADp5BMG+lEBAm?=
 =?us-ascii?Q?ig7glxF4fNxNIAVbMzoIa6UXv3Yh+2eMBkkCMh83zCGmDd33yiCfXPByjYNi?=
 =?us-ascii?Q?gzbH3q2Vo7v5ngCDbGSFnMB0lsJag6R7jOpgStAg+uiCDmRrIZM536fO5UXW?=
 =?us-ascii?Q?HnnCaSwjpaf23ktJOyHLzBXCTeTu57cGQncyJz3WYwSDLfgjo49f6qhL49l7?=
 =?us-ascii?Q?JWe/d88ykrRrwrdAi3ijSv4xcjZgL1M3VERk9hw1fCR62UWHh/60cVdjQuyZ?=
 =?us-ascii?Q?G0e8hElQUTLJDnL1wXJiy4P8v4vuRCcdfis8WnH2ugzMkgmGNiEhp4WlXMsV?=
 =?us-ascii?Q?G1c7c67J7HmJZz0NSzqZEzpPycL5UvYIOMZPQc1WYE3BnDgFlztaqfwAixby?=
 =?us-ascii?Q?yRBTfiuvIWdSHUqHDLtsvcQR3t5M1WcYYrIivPt8SMdn8HA+TcIdKuf9sFf7?=
 =?us-ascii?Q?4nYhXNRqYT8pJ8KufyyGc/KVAxX7Rt4Te92l55eqyvVpMA1lS8ZGdzLWOSWp?=
 =?us-ascii?Q?zsG2zHISc1gvBjltV+0EIR2YM9MZN2h1hSxlYbK5v1oUgGZS2Rq3D9d2KoEb?=
 =?us-ascii?Q?DaefFhcDrCz3ISgk+tPSdtXtcMyuAQiv1Nl8hdH19SFYSDfCF2OYrQsO/0v3?=
 =?us-ascii?Q?22cLuTHpnf8bYb3M4KxMTtWkM0+UM4BVAbnwxPEXhPSMqLsC2Oy69Jz/9TqU?=
 =?us-ascii?Q?35yexuvaG8o+AV7YqKcMZQQAmHENR0EsAGRturfrN+ON2l4dwGlS1m149W1c?=
 =?us-ascii?Q?9uUjrWp/xhKaveZ9NQsbXmVRnV8XZzYhnZwmxtAJGnmzDofv2D3fWbi2DbOw?=
 =?us-ascii?Q?tK1lyjBVCC6w524M6+miFIKXC4LW4GazK/QI5F5jCOM8CY2HfkQuDLVM3rS7?=
 =?us-ascii?Q?F2J3upnRKF5dNzARoFaPy/VVEx5eFoFnVPp6TVDRPfhCiMB4f8t3HNeIUxie?=
 =?us-ascii?Q?UDfYz3wT58LYYOkQ1sLe/EDWVzXNPummsGzyeFh1zRP2qsjKb3ZxYki/YwWT?=
 =?us-ascii?Q?kE8Lfbr6SqwPkQCuFbeRedSaMWukTHDRppkB+Hxjv1F06LqyEC751w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qmaCrB+f8VkbDOtTxW0W9E/SeWwfobsEkHyhAcShXtGXnAa71ihc0Tl1DeS7?=
 =?us-ascii?Q?E45Tu4LhydcffYDMEn49qOaoy1beJCh66Spz0cl5DQHGXpdHdJJyRNBgQn3E?=
 =?us-ascii?Q?p7qsswMntk6tSJU2EgAzkKJzXPT8yAvP7seiXPp4QXAFCkXpHRcN3ofAMK4H?=
 =?us-ascii?Q?cL7O41NYY6XiDvXbc/7N4g4SWCbRIJdYwrXJFDy02AVxKipJqS5jFSq1tvME?=
 =?us-ascii?Q?BLDN9g/LgJe3MgAnBFmH79PxWXLmn1cTfObpQy44av22ZaDFIEduABS/oX2D?=
 =?us-ascii?Q?+uWf+OBrprKIXRjG7JdcHfvCBGjdVb8mOnmee+97ZbTcOrVgB5ZtT41WQhIq?=
 =?us-ascii?Q?Ch0ll1Gz03U7MxdizzwbRSsFj9uJlhFdRUZDvtOabpel+IxlWMK0Km2hAHku?=
 =?us-ascii?Q?kg4xbjBC4hgHxIx+8ctc0tNKhtO3PEMepDK9mTfF9hPoo7bshkUIvcaw/Mvw?=
 =?us-ascii?Q?CByeBU4Emare20wJk5C7P+BecC/0G1RN3y3B25u4RvN1eC7DfqGH2wtevv8s?=
 =?us-ascii?Q?jaJP6PWZMTb4pr0bApohHi4i1Hg6+2UXk630Tu0iU+xYSn9OQFdt9J3Tg9E0?=
 =?us-ascii?Q?SAHcvPSPusnMISIBRRf/Lprkhr2ONvSRWAimQG8WzXBIejLozGhrD6C+yqj4?=
 =?us-ascii?Q?rDvxRudyJOc7657HRydaRKpKOYvvcgPLPUTrFqpw+EUtMrTZkkuPOPJh/v1d?=
 =?us-ascii?Q?MCJW3s5YpNil38wnvZHzbMZjrU7f03WUF2cxkab6YpzIlQ3oqTbuwMm+LEGn?=
 =?us-ascii?Q?Sw3bmBdWRQnHye7ZFCxeGeZToFejBm6rT0DL7oASsgWp6hMSLY1VzAjJA5Mb?=
 =?us-ascii?Q?v1EIfgA3flFGSXi2yGUuTlMdeoTlN5rQkuCTjbI8X8JI0n/X3UrpHHVwqPWF?=
 =?us-ascii?Q?i+vVbMwg87hPziulWsFNeCG2s4Lzbos9a7NdzMBoiBtRV1XRf0FDuRtglEaa?=
 =?us-ascii?Q?mpRCSW/4wmH9XSUmx3poyK7KefjnsQwwi00cKAeZdbjWy1BMGddJHyNAxQBM?=
 =?us-ascii?Q?jjYtTCbmI+Dxne4xEZRPPaN4DHl6oaw3nwn03YwBMJ2zN7T3XXygwEpuEyL5?=
 =?us-ascii?Q?QrIOIzLLVbPTmr1JkfcRco0I+NVVwFAS21WsKuNNUPhLvdZhwQr23knc2tuv?=
 =?us-ascii?Q?iz6aqHdMHX4nvugb9LlgWkrzimJSaZnhABkhffgv7dYvwvLAwCPtPTK50/gH?=
 =?us-ascii?Q?bJYx9TkXCu4Ct4Wi1PlbLz8V9g82TV5+YbJpisYnuceRVTjkFEurUiA5Bjg3?=
 =?us-ascii?Q?2Fu7e9EDkAhVS9bXNV1+nWSUxbJe2lFGCCs2F0iojQqhqvNOcZ+89j1VylRD?=
 =?us-ascii?Q?ZHc2S9KU3MZIItLJp3rrSMZ+Y9bxjSMldIDXL8R+OkQyqwY225wIeOv6O/ZI?=
 =?us-ascii?Q?74RVJ4VMBYatDBkkxcgRMTpSI7iR9xV0npmx9M8kB0luN8VFdTMoQh/WzFeg?=
 =?us-ascii?Q?27t/epA4AaDKVSTDsbLlGklxJhFUmR14DLBoYb3/1BOxg9M/wSyZKFRx+7BB?=
 =?us-ascii?Q?rXcjQ1IetPvVIk3lGIbXRROv1S2PB2kddWSRSCrIV/l8pQe4cZuV+qCSvURV?=
 =?us-ascii?Q?rTYR0ZIU5lfbPgsQOT0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60be124-64eb-4a43-2396-08ddec238838
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 02:25:50.9537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cv8ywDPUpWPTzSeuot0QbdkvY3m8n1dXliM5KgIYdNntpnGDttl4P75lvok1SlkPafImUjPssHUjRkqpTkI0Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10584

> On Wed, Sep 03, 2025 at 04:37:47PM +0800, Wei Fang wrote:
> > +	buf[len] =3D '\0';
> > +	cnt =3D sscanf(buf, "%u %d", &index, &enable);
> > +	if (cnt !=3D 2)
> > +		return -EINVAL;
> > +
> > +	if (index >=3D ops->n_per_lp)
> > +		return -EINVAL;
> > +
> > +	err =3D ops->perout_loopback(ops, index, enable ? 1 : 0);
>=20
> Why not just reject other 'enable' values than 1 or 0? You make it
> impossible for other values like '2' to be used in the future, if they
> are currently treated the same as '1'.
>=20
> Also, signed 'enable' doesn't make much sense.

Okay, I will add strict check to the enable values.


