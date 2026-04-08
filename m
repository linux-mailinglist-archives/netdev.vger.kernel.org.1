Return-Path: <netdev+bounces-276280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JsmCHTi1Wm2+wcAu9opvQ
	(envelope-from <netdev+bounces-276280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:07:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6B3B70D2
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 360723011A6A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 05:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F913537D3;
	Wed,  8 Apr 2026 05:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lo9yccSR"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF02AD2C;
	Wed,  8 Apr 2026 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624797; cv=fail; b=iSuuetwG1l0Nn6tRdyzdFLU42KCYZ6ATTn3bCsYtD/dSSNUTq3JKdN1pI+sjADArZo7+2hRFYjyCdv5QgEMQ/2rw59ZM5A6thj8a4ToTRmnUNz8yFUS5gb0G4GVpR7wAD2MCo6AlBHUYImWLWr91tRCj0yVMST/ymc1KhA3pqWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624797; c=relaxed/simple;
	bh=8OOmTpzYfLoaaeXOtE951Q3W5Ak4M1uHP3mhbabXwAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PuwX2Oj+RNlNd0P3G9ftQpYber6j74FTuB2Rwx600rGWYLf8AZK68wA13qoOUygcLSK7fQC+zXa556nX+AMIR7pcmBqew/EaMAb7SPAF0CeMfi2uoIoHgCU6zqhw/2Y9xjTJcp0/0CZwbo8pmyTh9jOEIWVoStie+ljuI+8xb4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lo9yccSR; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8k1JSXFnqljCDNoRCccuvQp/ov+JR5y5sNN1kzecpZ7Z42gG37odhHoTgD+2u9lKo+zPs68BavBvmn9fZv8EyR0gUX+EFi+k1CNltYip/CDAG4550Jj0ovl00exqQKy9GziFzkWIy91bGed5GTmbo+jjbRnxIltJOBAO7UE44vpUtJVgMpffszWYMeim7aDURSwvVO9+4pD8mtQRFzBroaA9nNMF6GQyf87WSK0ym2ZwQS4vOapi99Fk9SeoPNBuX9aapP+S5QmSERTt3KKqq10VL0X1McP1oJcXLOftMej/rwGoTVQ7pliXXij2T5ClXV2M2vZJLWJYuXXGX5DmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OOmTpzYfLoaaeXOtE951Q3W5Ak4M1uHP3mhbabXwAs=;
 b=gS9jURGTrIL/x5ILrBxSso5n1zNNjYEmrLVAnPMYGJRB9V3Q33JmjtizHgZecAFc6y4NF5alQJpO/SWrj1QEG5KbZiCW1lNuQGUN8LaBurcr6t8pBafkmK2cuzNgkUIPYONB3lyZUR8LDrodIPVForur1kpLp+X/eJJEHsYzk1TsNNTpYCaQGQUJOiDvURA04KqhvXHgz/BqA9Q5c7TnTPxLO5E49Yhy6Jw6Xc91jU0InEYfpJP0BtYrFMAfP/vykXPZWIM1af5J3LrP0O+GcSxfcM4QywAXqWTaBPb4h5KXMDD1IbYa7DWGvj3pvaMOjwJ2SOjyZ3jv4aEFgeFO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OOmTpzYfLoaaeXOtE951Q3W5Ak4M1uHP3mhbabXwAs=;
 b=lo9yccSRj7KCUG24Oc3R6ibfI2MbU5fvADcYPuJXvvv4w7JhYz5jvIg0U9Se3V76a1rweatg7bQw1uAZw0gmwG8xMltJzb6+2zQmh0r6wC3ylalXw6zhL3rBkIJCXYqSyKuiA01o5c4MwlyXMVQvu7KQqnem20icbehKUkf9qBIudw3MJUrJeT4minW3BKyiO0cQt0tg4rMX24kKD7IbOeqk1Tj0xU14Mp+/hPEpulHFiSkwIEB5km5BXcbDENLaEceO1zsn5+Qhyz/werQbhVU8MsGi7Na78rNuN7nPKUkA4hOdKzFMqf3pSK+Wyt8fWJpR4o1rJHRQei0+UZR4Ng==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PR3PR04MB7465.eurprd04.prod.outlook.com (2603:10a6:102:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 05:06:31 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 05:06:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Zefir Kurtisi <zefir.kurtisi@westermo.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net 3/6] net: enetc: ensure enetc_xdp_xmit() calls
 enetc_update_tx_ring_tail()
Thread-Topic: [PATCH v2 net 3/6] net: enetc: ensure enetc_xdp_xmit() calls
 enetc_update_tx_ring_tail()
Thread-Index: AQHcxgXEGU9n4WQzHUGeVmlcUsGGk7XUna5g
Date: Wed, 8 Apr 2026 05:06:31 +0000
Message-ID:
 <AM8PR04MB7284634E770EE25C0AE02E6B885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260406204122.167237-1-vladimir.oltean@nxp.com>
 <20260406204122.167237-4-vladimir.oltean@nxp.com>
In-Reply-To: <20260406204122.167237-4-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|PR3PR04MB7465:EE_
x-ms-office365-filtering-correlation-id: ed40cbef-fcc4-40e9-006f-08de952c9967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 IqPtDlY0DT04rn1gGqDK9xNsIU/HEm/SlVnolYwpDohYY83dJHaVFZUWrTiZxu//3quUjLA5lpea2EV4idW/IPO4+fktWNJFVz4C+n6kTszicpa1tKFoWcEw91eie8uZVljrIGEFRgkUTcPbGDKeiMmE3oYVCxhZzCeur9QfBFxT9VJ6zWuPIHPqkFTvXYmQVOjQoPwylUYRA+kMyT1w1CXo6zifFCUr5YXgxp1rlhylZCQNLCK8O2+Yklj3Sm3zYL0F5u2HI6jNvlvgAp5MhhLXIzFAaOv8R/+AToyHMfQJaFkNvfb4Bwulvr41y5EDTbS5ZSvcmW+Gd59yJwXcI62fzmecCb/FgfLb592+3Z7k8DPNrU88p50jdMi3sxfVohdhrwOfSSqQOdp3RCOdyGf+w8JtNCVEYsQV1ChUuWGWcWqYWEPExltWAWkY9dZaaWIHpA8HCjwIgFSdJIxKKvHebe4FxrqmaLkqg/zCaO79FJGQuqHe6eDh7UrK/NPAdkiivgw7Xpe63trb5StbA6Mpsno8ZEcYhHvJ25zRhFeY+Ah+GFPEc/mN/bm6Yl7eNmul7PxjWVH661/gkLwuzHdGrW+xa+BChxk+dQSJi2rsWDGIqqCR0wGfyWjq1uoeg3XqsnXS4S3ukvmJ3zupjoJWldLe52tIX9HtcsNWf9gUYrQejEReF93XlX3X14DN69iJFVeG7a5YpzeK0hRY99L7tF6r0hsEI3AgDrWDiUUy2jZ7QwRlN4HwuACiwMfZKbN/Q7RfD1qF4WCk2UOuoZDo5NzWeWoQATluhH4NDQk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0hzvJMV+b7eHswE3SGxPmfoVBzvZxsayAIBwAUY5W82X4XhJ8CWB4iZKYGA1?=
 =?us-ascii?Q?nZ1t409Cek86n4hRRgUxQ3xIknFdYLU9NGg6SpgrJdO8EcpxwKBue1fQSq0W?=
 =?us-ascii?Q?QSBgyJR0eMXt6FUe0ueYaLPwndMGfGXBwRtSJjV3OCMmT6/vAjrxcWjlrx04?=
 =?us-ascii?Q?QylNX5XsUG9+nqcf7gdGbvIjurVtC8pVrRfmeUSv3k8oCW0uV5M7Nuzi9pL/?=
 =?us-ascii?Q?LIycOVePq/ku8wtCKjsR1CsDjrMnkDexgXBa5P53FN3Pda3x0ynZL9OqFH1N?=
 =?us-ascii?Q?NC5lidgI9cfTbefieddeUpE+nprlG7LZ97L+eaZWlArGifUTJ5btln1vhfCT?=
 =?us-ascii?Q?VkLLkRVDdH+y+lFYom4Jmjro9rvlVkihbPVoC7HGthcaARYbmW39tg7HDxE0?=
 =?us-ascii?Q?UZCagcVehX18uQAcVJvzdede4sQ+06MA/sLJXvxmXLcMmn1lXJFkNW23VwhK?=
 =?us-ascii?Q?G93XsKGirTquvCBdrL4eawXLZruCcHmFzK+m5YKgFQs5+AHWgLZBgtIjaGsU?=
 =?us-ascii?Q?/B/A5qB12cvdYTRqJGaox4TO7h4wdmDEq9ZW2WVWFxNfO9J7o4gAs617/rwe?=
 =?us-ascii?Q?t/BMmTAtZ157ZvZTTBNElPhQx5ItlqU1p1wcYB4Sfc/v4pxn5RQty3PIzhv1?=
 =?us-ascii?Q?GzM7rrjVuvRa4EwC9k7KId7oQ/zFB1ru4lvlu0FiUgnQCiUJ5oVyHtH4uCB3?=
 =?us-ascii?Q?snc5lEBoJO7ouZoRS1DKmG+oja/GqHeiC+35t0dqTf1BZYPkM1pS2UtH7f1e?=
 =?us-ascii?Q?s++lCfCUq6AnBFGbudgKxSd/1Aq6hyI3f+9eUXgS9OjP9Dab81PLZdIZSKxi?=
 =?us-ascii?Q?csGBOWd18jcd30b6sSbQKxUaW2p5gPgxGdtat6xKL7Ql7KBiOdION0n+Csh5?=
 =?us-ascii?Q?iQcAPFjt4Az8wsFxcoJ8S1FrwxNmJRmMi1Ybyupure3V7pOMXMAMqthbH4Xi?=
 =?us-ascii?Q?drO6v4MaB8us/GcBdYCwxG3UXGtl6ix4rICsoulVK06POQ//euh1JUA1CLfa?=
 =?us-ascii?Q?CI7FHcWArVpUsEHR0naqpPifLx63eOL3PGJZcFhYBwxeiQaQlxK81vVsncGD?=
 =?us-ascii?Q?CZRMXYW9jLLBkyKwmC4ta7+aRVicv2TfwFGQ3Yl3tr186dov5PnsvaJXDguW?=
 =?us-ascii?Q?uUe9clzpaX0RikIH+G2bVA03DKbWN31NPFnqzWWOGylu4Pwd2mQwFW/XFw+F?=
 =?us-ascii?Q?E1KnRmRlq5Qg+9eJwp12rEokwQKxgySz9BVhmosvlXdrTLKHOe+euftClxUd?=
 =?us-ascii?Q?SSgI/PhngBYgfLOOb1dv/m40gpOIFBnPKvsYSbMjSivSYrDv/HsFSR1BLfvn?=
 =?us-ascii?Q?y1qg6774mY4QYsypzJVM6IdWfhk6SlbIFrm381dDymgUW43lRcPyX8CgzqTS?=
 =?us-ascii?Q?d7BCcNnNArsU+PfbLu8azokBurpIvEshETus2NPzyuzoyoNktp2FdodvP9zn?=
 =?us-ascii?Q?f/euIq3BF+LxlARwppmHGa5GNBG913RP1kgDVyMFT+pbuvsbGyJDeO9YkX1O?=
 =?us-ascii?Q?Qd/fhDXkUeM3UW9PEignbQFvELgbyjaCglouMlmJC+vukzEgRD1DtpFWDX1k?=
 =?us-ascii?Q?+d77fR9ObL2VHtAPMXfEvudcHOzaBzvXf3lVDjkd2DYWJ/UWgZtTGXFBQ7Vz?=
 =?us-ascii?Q?r3gtdZ2VzEWhg/Znn/KmUzwfVS5mP0MRgnw9O/ycWm7zwb3FmUTMjfzsr72K?=
 =?us-ascii?Q?xVKzcDshnIyi6ULznzYhHpymUvctwrTQt+IOBgsih715gnN6?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed40cbef-fcc4-40e9-006f-08de952c9967
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 05:06:31.7595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dco56WUEnaHUy28vrtCMVyjoAfGXqrJrRv29ZYRrt+T/dr1yez1mOlhCmaDPRTI2UHyTSnZ6vSSgRzN0tzxmmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7465
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276280-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: BBF6B3B70D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> enetc_xdp_xmit() keeps track of 3 numbers:
> - num_frames: total length of passed struct xdp_frame **frames array
> - xdp_tx_frm_cnt: number of frames successfully sent
> - k: index of currently sent frame from array
>=20
> With "k !=3D xdp_tx_frm_cnt", the intention was to detect an early break
> due to an inability to send a frame, and to trigger a TX doorbell
> anyway.
>=20
> However, that doesn't work because every time when the loop breaks,
> k and xdp_tx_frm_cnt are mathematically equal.

Since k is always equal to xdp_tx_frm_cnt, so we only need one of them,
there is no need to use two variables.


