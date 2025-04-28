Return-Path: <netdev+bounces-186329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC89A9E643
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 04:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1084E3B7A28
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 02:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BADC3595D;
	Mon, 28 Apr 2025 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Ew9jSAn2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F0E173;
	Mon, 28 Apr 2025 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745807500; cv=fail; b=VBT0qKmSEFxrHiexAs3UwufZef1HSRlFEAxBwLXsMgfX01w0fT6+pqisbLC89pFyjDL+yrMnaYugDq132S63/I5gRCnDU7pMmc4iygjII0Y2zRz6VTvGLuduSnkUAPt4bys0YV5pbov2ofE4oTB25rOeS3BXhSOmOgLTc4Mdeh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745807500; c=relaxed/simple;
	bh=5YonlUUWbqkI8pA3bnvCFXhFIGNfqpq2uR79s9AXWtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M3nR7l5wtZcOyvmY5TRx0RAu2SwpB2oXy/4l3XAIkwsaz6UJUyf7VxA1AI1vx4z2M+h9a+SxdehFjjQVyAf2iuIFPrtDQ4bWJQqbs2M1NCAK7aIF3790OUyluuMkGRuEvc0oMytgk8sNzhjB4K+Nm2U23aWnMcqCMzJAswQFODc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Ew9jSAn2; arc=fail smtp.client-ip=40.107.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNfD9dSwaQVkQi17YIQ9zpbu99ttzVpjv9vimr/rbZd6/2Wh4uQrO6X9fBVtQUOizS2X9NcnEvS2NxV+VJh2DVcFro8YHSFLpKl4PK+JDmE3Yh9v/kaKzwaqwEiq7rnP566WcQz6gs/xs7kM4010L+Txwv+bZ98iq1nv1ub+u1UhjfmHiY9h+RtYP8Ckj50jAvBTrQZ2yCMiE4sckXpEWzd1G8hstO55jre3P4auqDwB7tG3vNcRq17EXPbUr5+edtCm8v88LcnLcNzus/J+iWyKpayW1HFXnZPxOtvqaoC4Xzplq53iT6ZEVScDF4B/KsnVBAdRvMOlCTWhOT7FEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Iyg6ymQ778wvwDHTig/DvqmpGBmU1XPDPXtl3zchSg=;
 b=q+T2VKhF7zRR5QGAE++MVOOvpei0zhanhPdpWEgHxMH8hDU4On4UsXbAkU8LFCBa4obTPvNJoXQThYrpLdjJwdfKqu6Hzu+PT1RVJuP04oPiz+08E7dYJ9KJSBBq9ZWxQ/nXRpBB2JGKXpQuBAGqeqLkOUdiedUVr6RsGJpX3Ef4oQM/eFon6eOFPPu+QsCOdsSX8JRiINGVnqndmj4A9nNQoYADzymfeBnZmIswEVnt3I4noHpVrWKLyvUyt7xvpXomiboYji3fFKrQdIuU6aHqx9Td+i2nyF6jAnN5LoCz8ln6ite+yMtH9dTkRypfRwX/oYKZ9rbXO5co7H3CBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Iyg6ymQ778wvwDHTig/DvqmpGBmU1XPDPXtl3zchSg=;
 b=Ew9jSAn2iZAFlKqw0ZRBM2IHl1Dj2lvJgQ9yS9Gf+US4z5bErM13DasmgMoHENdShoDHLICkmcRVZls9har5h+6RszHoYVib1STJaOtDoAlrWM6TU2H39rnU7HdKtuyDC7oD/jl0tUEQpAIIDCPhd2yxXerZsXojpmtZh3DrAmEYCuo8EtJFBGZgrHum/nzzM1JDLA3OO2QAzg+lnigbEx4fOicN2mXcIcm2sNoX4xkUkHLks23zY+X40d0S1X/o8mhxkmKK4Xm9rFbJtapr49dRvMR2UwfORxIV38KW/Yb+Hmj2soJw18lbebc5V3JKv1MNnPCGX565vbgvDrtKcg==
Received: from GVXP189MB2079.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:7::14) by
 PAVP189MB2383.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:2fe::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.30; Mon, 28 Apr 2025 02:31:34 +0000
Received: from GVXP189MB2079.EURP189.PROD.OUTLOOK.COM
 ([fe80::e733:a9e4:d1f5:1db5]) by GVXP189MB2079.EURP189.PROD.OUTLOOK.COM
 ([fe80::e733:a9e4:d1f5:1db5%4]) with mapi id 15.20.8678.027; Mon, 28 Apr 2025
 02:31:33 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: RE: [PATCH net-next] tipc: Replace msecs_to_jiffies() with
 secs_to_jiffies()
Thread-Topic: [PATCH net-next] tipc: Replace msecs_to_jiffies() with
 secs_to_jiffies()
Thread-Index: AQHbtpLJHkOz0hgtOUCgqJKVpBPwbrO4V/Vg
Date: Mon, 28 Apr 2025 02:31:33 +0000
Message-ID:
 <GVXP189MB2079DD4E21D809DD70082B15C6812@GVXP189MB2079.EURP189.PROD.OUTLOOK.COM>
References: <20250426100445.57221-1-thorsten.blum@linux.dev>
In-Reply-To: <20250426100445.57221-1-thorsten.blum@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXP189MB2079:EE_|PAVP189MB2383:EE_
x-ms-office365-filtering-correlation-id: b90cf57a-b7f0-4e82-2afb-08dd85fccaaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oIIK9pPta5GGVRbJKkjuaX4+Z0bIBc3Nyb8AiW5fgzV+qU5MvgvwVt9Q61ag?=
 =?us-ascii?Q?r2B0XAyfMBzxw/yCX0+4AcOlOUnowWgy5t/A6dFxoDZbAPRasTsNlJ6liOW9?=
 =?us-ascii?Q?bqsM/JoShFEguW8j6Vo8E0f+bybNZZSIqCNV3WNji3Bo/oz3+xpN/LiALylw?=
 =?us-ascii?Q?7/KNEnCLngSfn+y1Jjee1qHcWfOiW+3upVF9jG7OvL6WtLPn45PDXwbFYgwS?=
 =?us-ascii?Q?8dEYOI60rH+KHkOVAopj7I0yL0hlexXV8yJibfnX8YvK4VlNkEKmasGk7ngy?=
 =?us-ascii?Q?Vy+WSvZrM+W4xkdzp2IAZQ9mm2ahFp8BstdVbkpf1nE+co25oTQAf6iY73ds?=
 =?us-ascii?Q?CYkKVSub8SWKbDu6jUmAvoRW0DuJfcqBwNNfmtauNIGjOMGpu3JWVBt2erqm?=
 =?us-ascii?Q?np5z/fxFkCwIQgVa4M1zoJH0/IDLxPgG94UTyWRwYXwWtd0Rq3brCJJ0bMVN?=
 =?us-ascii?Q?MkZ6jMTwNE+rf9H7Jlpja+hIp4e3n//fINt/k0eBEmyP8AgHxjGIB2THokF6?=
 =?us-ascii?Q?qCj3IBTc4l+l2+zW8E9RGS9zd+fZ6R7Qtcn2f8jXLvP+Tq49EBkQR6b9gJ+3?=
 =?us-ascii?Q?u/urbKiOyxkEFDAV9/8NiCCj4vpUyC6iGXfpJRtTLZltM1taHdqeVQxyX0Mm?=
 =?us-ascii?Q?gBNoniios5TyeHm/m4wnF54uy06WfDyM1l413gzy6tM7Q5eXOtLi7lDijVbX?=
 =?us-ascii?Q?Dnp6d0mqOdrdFKKPycp3QpEv53NPo6pb+yTnGDT8kxmrswNepliGEAoWw4AB?=
 =?us-ascii?Q?NqYSJN6DQgHLvvnbf5QcVQSJ15pgLQaUb5Unf3BmWKK/WbRadadLuxfzIDEq?=
 =?us-ascii?Q?u3EbCi+ph69Cw1mmruCfELvhveWGodckJShOlxAGDsJ1ywrYAzIYh+fhyMoq?=
 =?us-ascii?Q?oPEUX6I9A2kKAwYuKqPfu4RyQKFOns66mKb1XSlBLhwy2CsYdtYFCa4hRZFF?=
 =?us-ascii?Q?hvo9Jrj89cx7NLnujmq5J6oHk0AMqAIHVQ0zpu7CYxnHGpUaa94wv9DsOI2k?=
 =?us-ascii?Q?kny6PfQb8E5TUyIBteWZtR8xMF7moz1+3lJKeFRRfvs4RhEA37Ovgs4gZGUW?=
 =?us-ascii?Q?5VC/a9i6uCzGXOBdwg68layCqez49d/wB+OWcjitem4S4KVhKaxGdEiuXvXI?=
 =?us-ascii?Q?79fMmq1iTvRg8Af2smzIx6VfMaJQDFbli+o/MiB1CcSXqolTQg6HfaWlaZ1e?=
 =?us-ascii?Q?TTn4Ix8nQW+vivGllQ1Uzu/3Y0AgZlrfgsF0BfumQTweUf33cBZe//Cu3lmv?=
 =?us-ascii?Q?5Weyh7R392v/RJFbYiSGZFr06X4p5pdqg0AtBJdfKEyWPx49rq87EAGlM98e?=
 =?us-ascii?Q?BdthdqDZoVaI2orptWmAeAw/qqCBtLJADP6dMH8e1AsEis3FQvBsSmzPPPgT?=
 =?us-ascii?Q?9xCSnEf6OOawc+PmaO6VtNR7KZp1j4ekWS2ymHMZyh9+txkf7FKNL6xPHWss?=
 =?us-ascii?Q?NHi/A1iRCvS+OtqQWkcBi6r2uwlYWB7S0OyYY/g40OYAxgy8BncyuQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXP189MB2079.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iwwOnwLDWqSmThNvCZasP2bnSY9fvHV9S+1FQyNI14mqCTUGVKU+SV56qi8x?=
 =?us-ascii?Q?fDE6uliAKgXAgSWJW1cu94f7tbZ68G1r4apdTf23oihfwcAFHLh+m9nJFdt0?=
 =?us-ascii?Q?mYQzw8etfwjG9S3HE1xQ76tbUqrr7y+fcFokJrA/auNIxKcSaalnWvvuUkfJ?=
 =?us-ascii?Q?pmTB8LlFZ6jIURBVzCRQ7lAjKJjqtxCWTJBVznpFtDLYacb0fUfEJxCxqCIj?=
 =?us-ascii?Q?VGY/vWCwkky+rkLs8uRgo2x2fN1bW9cUORurQSRsrCms9a+1Aklmvhz9y/+0?=
 =?us-ascii?Q?rMrP4XWyaoGthwgZhUFeJkzBOBtuNb/w6/S0F9Daha2PPaT/dAwFPhuNo0ae?=
 =?us-ascii?Q?hWh2VUQSC/r8HoIYJ1uinFtGfKC34BFDyrLmxuLmwvrCWtFrqBrM/Q/TK9Sf?=
 =?us-ascii?Q?VGGtZdSXCI3ad7mIMtfxMYL7AonI4tc8zZ1iQQvP+KOZ6sMLuVEeoG+NDXLr?=
 =?us-ascii?Q?wOL+LQZpit3oNDDye6byTBj7SRtNq0tke2m0goNzARcOvhe5vvcKH6dCTeqn?=
 =?us-ascii?Q?ET8KoZwKen0bPhWshaOz1CoMqfEHvZBdMLnZ8ts2Ouy/it6NicTk8rqRfVew?=
 =?us-ascii?Q?KWbKxXLngjZexXP66l7fyKQ/UB3cjjpQVIK1/xnoXSd2TMsM5TumYCiJMHVo?=
 =?us-ascii?Q?eV1nBSm+sbgrsGe4kjA2Hvp4wMM1eR0WiQD2N9wYnMyBKKEWhAlNjkigItKv?=
 =?us-ascii?Q?V6HmVfDhNQcEHvebQi9d9KMluuLSEzRkSJ18CsMtEdubLrv2t3MnhZfphLMx?=
 =?us-ascii?Q?5yPp3ks56q/rYcKXRjJ6xymyV9km8/xGS/aLSWY0Bc4JRnjsZmJCZH88WPrY?=
 =?us-ascii?Q?8KSitwUb3nDHpKWyLFZxz33uKzTx5Y0TbGphRR4icH+qoq441Br6eVTuOJc8?=
 =?us-ascii?Q?vuD6U2691kIdZWeb3NhMbRkTu93aZj+/kmthXS6A5ekiPfjTlhF86DWVEniI?=
 =?us-ascii?Q?QRAXBf+ez7/rC66AGzAVaGfwZuYBIJp4jOkntdpRYJ3XR6BFnQdsgI+sQuBO?=
 =?us-ascii?Q?wgKQi2TBJAXELvCQgkwpwi1IN3rA73TCb1HYvz4RAn4zdB0vJRWoZlcJtfks?=
 =?us-ascii?Q?UIv5pd2hiZOT/X8Yn38ZTLIzfdDFXvbzZfNjl6yOTL3oNlWg+wq/nzBZSghw?=
 =?us-ascii?Q?SCx/MNfvpDj7VvIVnTc8HHfehCTXf83EvN02MIfXHKn+kbQ0/p1ZAUr7It2v?=
 =?us-ascii?Q?v9dQS6cNurbJiwuLk4P/WQ1/95Tk3WKpW4Ao68IFqP5ousOQEdGy77ekBsUJ?=
 =?us-ascii?Q?Mbzx4f2FjzhQZ2r69QQYyHs2AM9r50FUCHrzP31oIiRXiaJ5umCwy86zZZpR?=
 =?us-ascii?Q?5kwakm2QYElYS2IKBDWCN7oy4MJGL1eXnAuYtxvZyB27SHOsA4SCUd75AWH0?=
 =?us-ascii?Q?eEm+kyfBFi5oQrAts1JUQ+HwIF0OUaRFgkwEUGsk8W4+D0V3hFNRA1NLiQ5Q?=
 =?us-ascii?Q?F0pzO0UrCvOQN/73k5i0S9YiRKjlm9aU1Qm0Ji9ND773X5aJq0bmtHqbndkh?=
 =?us-ascii?Q?HLZHuZrdkERExDN4nwEb/6DuMPZZB6kSXTnbzlHze2G9Nsw78jrUwWJHh+Fm?=
 =?us-ascii?Q?ou493lCHaLYwl7Ld9xdYVhMMSKs2y9254P3BmBT+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXP189MB2079.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b90cf57a-b7f0-4e82-2afb-08dd85fccaaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 02:31:33.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7apE79jFQKE+3vMehTPgGkK4HMJUPGw7gLHRDiyZZzoDsyqEHYSX69tLI7vGyzYzHOumtJ1D2Y/W9seRowtF821vKsLNKfvtah7G/XCsc54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP189MB2383

>Subject: [PATCH net-next] tipc: Replace msecs_to_jiffies() with secs_to_ji=
ffies()
This subject is confusing because we still use msecs_to_jiffies() for secon=
ds-to-jiffies conversion in many other places, not just in crypto.c

>Use secs_to_jiffies() instead of msecs_to_jiffies() and avoid scaling 'del=
ay' to
>milliseconds in tipc_crypto_rekeying_sched(). Compared to msecs_to_jiffies=
(),
>secs_to_jiffies() expands to simpler code and reduces the size of 'tipc.ko=
'.
I observed an opposite result after applying your patch, an increasement of=
 320 bytes.
Before patch:
969392 Apr 28 08:53 tipc.ko

After patch:
969712 Apr 28 09:11 tipc.ko

So, your patch is not necessary.

>Remove unnecessary parentheses around the local variable 'now'.
>
>No functional changes intended.
>
>Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>---
> net/tipc/crypto.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c index
>c524421ec652..45edb29b6bd7 100644
>--- a/net/tipc/crypto.c
>+++ b/net/tipc/crypto.c
>@@ -41,10 +41,10 @@
> #include "msg.h"
> #include "bcast.h"
>
>-#define TIPC_TX_GRACE_PERIOD	msecs_to_jiffies(5000) /* 5s */
>-#define TIPC_TX_LASTING_TIME	msecs_to_jiffies(10000) /* 10s */
>-#define TIPC_RX_ACTIVE_LIM	msecs_to_jiffies(3000) /* 3s */
>-#define TIPC_RX_PASSIVE_LIM	msecs_to_jiffies(15000) /* 15s */
>+#define TIPC_TX_GRACE_PERIOD	secs_to_jiffies(5)
>+#define TIPC_TX_LASTING_TIME	secs_to_jiffies(10)
>+#define TIPC_RX_ACTIVE_LIM	secs_to_jiffies(3)
>+#define TIPC_RX_PASSIVE_LIM	secs_to_jiffies(15)
>
> #define TIPC_MAX_TFMS_DEF	10
> #define TIPC_MAX_TFMS_LIM	1000
>@@ -2348,7 +2348,7 @@ static void tipc_crypto_work_rx(struct work_struct
>*work)
> 	struct delayed_work *dwork =3D to_delayed_work(work);
> 	struct tipc_crypto *rx =3D container_of(dwork, struct tipc_crypto, work)=
;
> 	struct tipc_crypto *tx =3D tipc_net(rx->net)->crypto_tx;
>-	unsigned long delay =3D msecs_to_jiffies(5000);
>+	unsigned long delay =3D secs_to_jiffies(5);
> 	bool resched =3D false;
> 	u8 key;
> 	int rc;
>@@ -2418,8 +2418,8 @@ void tipc_crypto_rekeying_sched(struct tipc_crypto
>*tx, bool changed,
> 	}
>
> 	if (tx->rekeying_intv || now) {
>-		delay =3D (now) ? 0 : tx->rekeying_intv * 60 * 1000;
>-		queue_delayed_work(tx->wq, &tx->work,
>msecs_to_jiffies(delay));
>+		delay =3D now ? 0 : tx->rekeying_intv * 60;
>+		queue_delayed_work(tx->wq, &tx->work,
>secs_to_jiffies(delay));
> 	}
> }
>
>--
>2.49.0
>


