Return-Path: <netdev+bounces-182558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B29A8916F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11322178ECB
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC119924E;
	Tue, 15 Apr 2025 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="bpQ0pGUK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE518DF8D;
	Tue, 15 Apr 2025 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680977; cv=fail; b=MyCpFJQZ7qEyWQybfd3hcil0OPb7mdB/E9+Q1TJNS7hFintUP52b5rI8lfX17DmdyacaVJ0GvX9wSGyFBgYxzVrZ0sSeZHL8y5ojU9ig6Vw/+h3hNOyzSCrxOHCejpsvlPJS+xPh1IUCtt8VBdQySwhz92Qm13eu53s1y4gkgXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680977; c=relaxed/simple;
	bh=GJNlvKUbMR/UC/HKKnqPEF/f6nC37Z+MI3IQwlrvjZs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M8vMXyZ1xKql6VLRuUwl+VRdPiEIfxbn8Rhxd8z6e2qMbc0qygpiIarzgrTkaA+yBLDej7HsieRDsGygC4LoIQZlsFCNinLlG8PnWHglguEBy5o3ui7rLsKncYxxHdfQ+62pzAbjpw9H5MYhlX/4fkYis4hQhvi7rhU0C5trNBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=bpQ0pGUK; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ez79MpuDY/LZt7gBdPMlgNJI4uucPUB6CWNlU7Nx0DQodNG9ekX43mly+tmTHZiWYQ4RbAYeb6gMX4R/aL4jH7s1sWuKH81oY9Evl2gDDmz6xAx0kgfEdouxjUlcmY6JCr27J/j0OZNLe6EzrzqwWigbJU+Vh2MlqqNRwYNHdYr6nf+GqS6G2R/FcpYtdhRIpQ9e92Iuk7gxIdAYGezk+Ei6kNvw6SfjpSZwGo4xMrjbydV3zQnJRqzaMRgKqPEvUskYbb1WL+OPUYsLo9PppAZdGgu8cilThuIfHQdMKRou0jZ19W3jwc0M3TZN7/Jvkyj7Yyir4GgJYiKJ+uJaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSOnY4ISfzQf0wV7d4vBNhC437xsHkQDJwKfAVz5Xe4=;
 b=q4jiJziTs4YGOWxiunRn6kXdPtoiDc46dcvbUDufgfdl5q1VMQwrFVtwXWK3tFWaHqxTZtYpyxv0wEprMXjYmq75/KCTVxPpHe450z6ngQUEmr4+/jar/Prhaf2WR+0iCciJFcUGJOk19Vo86rpz4UEECs7A1dd3JSNXlqo3pXS/E3ukSEmvY7T7UyawOP6mDQa2HSPf+Yiaq0p4cei607ymdjIJxPfMEOcWJ4Qc2EgaS/rsoe0yQpGjCCEZkYUw7j4dTWQgrj3UL5fnm7o3RsBeVKWS6sTPGyClD9ccenY0iKvy0tl8v5Npjo09MVotGkkjsUUCecS5bUWtAt8YjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSOnY4ISfzQf0wV7d4vBNhC437xsHkQDJwKfAVz5Xe4=;
 b=bpQ0pGUKXoo8TE9HGk9xWcHNX6zHNVdA5v2vLfPr7JxDVe92qtaI4INcSYeZn9YcOjns0fOyLjzsBM933d9P8g5DGCEbJGmZaFpdP5nYzYpbjXcoX28XVzrHk3StA4TwFpIh6gt1AblpAN8LgwoCjx1IpRxfU3zvhpwyzWVovnn6+4TFkBeaEAwuaA7ziyaKOjoC+86L4rNqt5JWY5H2VfMvr4K3tmKpNe1adiT2UaoFrxM+aNXLU5OGA0Az7xY9G0d80VsCnkugTOHUgpGQ+b1ZXaZdQm37rObov9zBwXjnEXvLZyjgu43yfY+nw4OpZezTy7MlGn67LiZ37ZEilw==
Received: from GVXP189MB2079.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:7::14) by
 DB8P189MB0853.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:162::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.34; Tue, 15 Apr 2025 01:36:11 +0000
Received: from GVXP189MB2079.EURP189.PROD.OUTLOOK.COM
 ([fe80::e733:a9e4:d1f5:1db5]) by GVXP189MB2079.EURP189.PROD.OUTLOOK.COM
 ([fe80::e733:a9e4:d1f5:1db5%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 01:36:10 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net-next] tipc: Removing deprecated strncpy()
Thread-Topic: [PATCH net-next] tipc: Removing deprecated strncpy()
Thread-Index: AQHbqr7NeiJH9CFBbUW+jREhfYw45bOj93LQ
Date: Tue, 15 Apr 2025 01:36:10 +0000
Message-ID:
 <GVXP189MB2079EB01FA7B3726FE362C24C6B22@GVXP189MB2079.EURP189.PROD.OUTLOOK.COM>
References: <20250411085010.6249-1-kevinpaul468@gmail.com>
In-Reply-To: <20250411085010.6249-1-kevinpaul468@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXP189MB2079:EE_|DB8P189MB0853:EE_
x-ms-office365-filtering-correlation-id: 1e2c49c7-ce5b-4630-b550-08dd7bbde6ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RzbkaPraK5S0dOWfHJoRY1a89foEbpmI8ZmoEOphJhyNREUmWlgt6aRdbDQG?=
 =?us-ascii?Q?wnJxZ3W+0s5+e6KzxQ5bbSie8zKPyH3Jxdo9UyPyKcPRKDXbzIFk4NNlIJEn?=
 =?us-ascii?Q?eRvGwV8+gq5a+My/3rYl1fJ1hhd7vSzFjSF/eSOwPrcHd1MkX5cxaSgcZ4XM?=
 =?us-ascii?Q?tHt7PYmBR/XGt7Bn5EyYXoN/7380LoiWALEKS7DPZ+Jbr3SL0vSb9EEhzGh6?=
 =?us-ascii?Q?+6Pzj3EVni4vybfKb22HbzAGOVZ1wFnhBTA7UkoKjtCjmWn+m0ruVJZMR7oK?=
 =?us-ascii?Q?zX6x6LnQ4VieqZF805aq9XnVTHmOIIQFqVt/obSl4R435TxPVuFSlHMWyg8n?=
 =?us-ascii?Q?/7zab0mLcUfDyeQ3cDTEAAjKRZ09gn71xCEjC19/EcQpH9XMwdbj1Rh8KbEJ?=
 =?us-ascii?Q?9GYOpJ+6BcdHQ/fI7KspIO/RyP6Khp6qtlw19C8vLXIIYktqOYOCO/h3TIJg?=
 =?us-ascii?Q?6FSPXsrR+aQZxWhPalJ7oGF+6dirWeNI5cfBatwvuw0kno6Rxy9feIZHVnMt?=
 =?us-ascii?Q?wTNKso5b00RB+J3RDrdpjv8dlGWmWN4g7DCpY3FeyqL2RwU2I8g1Dx41NkvT?=
 =?us-ascii?Q?86r7WY8bmnbyouzrv4jaQJ1g/N4nODShnig9D9JudNWzkDaoLQQN+3Y5ecJz?=
 =?us-ascii?Q?WPshoksqw5Gq8uR7YE2dmw2Zcd4vXZFMKT8qe4vwM/V+i4o7/kBevgEBFvm2?=
 =?us-ascii?Q?8BdTa6GmI6Zvu6U0AVdyJhQMxwvDMcT8Yavc2buOPzFEeTxG7E+txkGPc/Q+?=
 =?us-ascii?Q?w0pXG3/HE4pU9hZqR0C868cv1aCU9PAXKjsxZsoONv1HTQzuHnDmdsR06zHV?=
 =?us-ascii?Q?uSSGGLJW5PuuWqFPx7QpKjXkBJnWmdzFe2tAnj+tb96L5Gz2FP6ZswpKmFgE?=
 =?us-ascii?Q?hp/6OvrJtlF6sa0mfUGr+c7iuR5+GqSYIjInt4QixmCvnlaKePIPz+KtqAec?=
 =?us-ascii?Q?H5Tc/uhc+2gyMgaqRtFCrE1Bl6C6QMKyHWVLh7FQkzJANbpwLe1QIGTgOwSK?=
 =?us-ascii?Q?Ru+nqSNYjXdFQcDI9U/bZHQqktaUDy3+Tzwak2WrA13o8lTHyOtTjEy4OUm+?=
 =?us-ascii?Q?5oUHQ5L/y+EQ/6XTYEY318tmGHmK6pRoturnUXC/xbCUtT+BlvNFKdhMFvh+?=
 =?us-ascii?Q?rAanQjV05wf0CDWYzngpTn2ptv95jE16FBpSGmGptGIlDgP0kFgGHjN4w5rI?=
 =?us-ascii?Q?eejom1Ud+TuYwA9klm/JJOCi1VgX4mpGjoIob+C4lpLE3BqWRWM0r7a8GUQz?=
 =?us-ascii?Q?BzbaFsJyoJ+zwYeJQ+H1SJMsy3EwJ5aT79zepXmqTAGVTQFrEjc1FzNEkxGX?=
 =?us-ascii?Q?IAmkTzMIQQPotwoq0KokFcvbjmknhc1mxH3i+V7kHca6t0z9w/SSG8amxZJ4?=
 =?us-ascii?Q?ewqmMUwUHYFQM/RsTuW05Rg5I7S7e1CKgnou7CWncf90mMzT3kbULBx1jwZc?=
 =?us-ascii?Q?NEiTjDqJdnLzgXH+sXKrcvYxP3kFVldhgSH8D/nczG5fAtd44EcZULdOF8nN?=
 =?us-ascii?Q?3A+/AocGAjliKEw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXP189MB2079.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T3vg383/YKeRLGXtBTDlUv5QzIMu2kCIT9rkJthIjUAFNBmcEkUxCPswdToO?=
 =?us-ascii?Q?CjaYneVpypPKLLP3imBK2JMnOjTwOyIDQBtN/TJbquO9ngOpE0CJHY3KDl36?=
 =?us-ascii?Q?Jj0F6hQtR7lAc9xiyFlTYMTBN1xtVydSBAcR68Q/92EJRCdyxtmLEuqnq5Ti?=
 =?us-ascii?Q?EaP/dNz0Nx5jYgIL/1msYE3wKIkf+qXofDcDour1QRFWLpFnsqAEKRbV2OaE?=
 =?us-ascii?Q?wDYAwIcvoPRq+3pNh4IIcWkeRodiKY9XN6iG224dbsVuCjIohzcVj6ht9QLD?=
 =?us-ascii?Q?yNmf1a0RAQHp2DLy9G5Zh28N8kFZlOYLE05aNo6WzzdDgNVjYt/NmBdAEcsg?=
 =?us-ascii?Q?7SPYU7yAcIlM7tqj3Gr/jfEgJwkNUkFIwBZzimn5sH5dxfW+vmIxxFLGDalY?=
 =?us-ascii?Q?WxpVnEr51ywNOtBTeTXGOrp0t+CTIP4a5euVdIogmRWtj1FWdsTT37hWv51b?=
 =?us-ascii?Q?f16EVn3zOTyBl2ASdJtoe6ddvaQWJsV+Ws+15nTOF3bOzVfbwgrH4FafbFuy?=
 =?us-ascii?Q?oNFKSLc/tFrIbe6LQqMAByepaRlpJnRh7XXRFp+GDHreMm56c5yoQrBO2wYi?=
 =?us-ascii?Q?+Ww5CIjOaVWNR/lc9fSdFvoNiPEBLL+h5oP3NPnYQrUMMrpupgBKyYB7HegN?=
 =?us-ascii?Q?3ugBtbogt3Qlj5koyyIApf+WyWzHcvT0WpjaL5w8kLYqa+Jlq3zRJqoh858r?=
 =?us-ascii?Q?GcxekHXUjJs0qi2F5bDhclMbk7Mi7M7QthKRT8rBnl87XrA7IQLqmwLgZzRn?=
 =?us-ascii?Q?qVJYTgvVVccbWSKx8f8gKqkf6wkpPdaFLaIIwcg8/2h8xFXfuHXTx7IPbQep?=
 =?us-ascii?Q?gBTEv7+hxKaeW4jiltJ73Kf2LlrVJR5g3idGD//Q8BMju9sLzbtK+ngIO2Xc?=
 =?us-ascii?Q?h/bQ68Ft2dcyJ76eTW8luzFLesYdM5rKBkyuw4KPYdjS3xwTT8aJIj8YRug1?=
 =?us-ascii?Q?J7lfyrrHAK20NwakqDw3ers8xyJS92IAEiHZPWz8sTN5LDbr3azaIuYGXZgg?=
 =?us-ascii?Q?oHpJ1MaGVt3n1mYClP1rqD5nCprfS3udmoFLl9zSl/2O7nF92vTd1TzRdTMx?=
 =?us-ascii?Q?aqZyEKZ4qM/yoe2G31Z6c5hjE0HwoHk7appEf4zEo84rPXCs3mBNRwf3XkvJ?=
 =?us-ascii?Q?2yCe7V9S6mkpPrbks85FNGhmB4ezgA3dgZBjgu1dp2LiiXpfd3joow+oBLaE?=
 =?us-ascii?Q?cLhNai7qgiXDsBWxWwQzlGMYqZaA7KfUduWLLo3jNH7ETeyHLSEiOiEIaAas?=
 =?us-ascii?Q?PZ/Y60BkHEqx50JkeSdLRdVMCly7lziLIrzmOa7YhqTPCtgtvJOv59hKOIu0?=
 =?us-ascii?Q?aytf27I+t04PR42sbw21Iw5gBsN4PGuq1/VBVPPBMMGF021DAAzf86VaR8d6?=
 =?us-ascii?Q?M5bxhe1dJZJFGq1+UwtJBFaavXPwgAERcsqGpvarZPLfGhJ261q0nHAhTZ4g?=
 =?us-ascii?Q?WzLO74isQoZ6n5PAoAzy+iJK5HLIkCHjsGDOYupHTRBJSB2sV30e0Xc1IFkm?=
 =?us-ascii?Q?ACFpsDykwvhDhsFzDxoJJmGnBm3pdLcjKsTsPtb7D5Y0Qkv0+Q+KCijKfT0q?=
 =?us-ascii?Q?9Mgl9YDndHx+mdrgMy64jKI2jUOffyIUROKKM2wm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2c49c7-ce5b-4630-b550-08dd7bbde6ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 01:36:10.6486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cgbg8XM3p+HghSPPf8Ps5wbCXSA2dE4wPgyk9hKO94Oi2g9ncOfrR4O9IQOKiA/lo4rWD1qWYukt/1vxbHSLxLgOAhCk1c6FtKAVfQhuObY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0853

>This patch suggests the replacement of strncpy with strscpy as per
>Documentation/process/deprecated.
>The strncpy() fails to guarantee NULL termination, The function adds zero =
pads
>which isn't really convenient for short strings as it may cause performanc=
e
>issues.
>
>strscpy() is a preferred replacement because it overcomes the limitations =
of
>strncpy mentioned above.
>
>Compile Tested
>
>Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
>---
> net/tipc/link.c | 2 +-
> net/tipc/node.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 18be6ff4c3db..3ee44d7=
31700
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -2228,7 +2228,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, =
struct
>sk_buff *skb,
> 			break;
> 		if (msg_data_sz(hdr) < TIPC_MAX_IF_NAME)
> 			break;
>-		strncpy(if_name, data, TIPC_MAX_IF_NAME);
>+		strscpy(if_name, data, TIPC_MAX_IF_NAME);
>
> 		/* Update own tolerance if peer indicates a non-zero value */
> 		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL,
>TIPC_MAX_LINK_TOL)) { diff --git a/net/tipc/node.c b/net/tipc/node.c index
>ccf5e427f43e..cb43f2016a70 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -1581,7 +1581,7 @@ int tipc_node_get_linkname(struct net *net, u32
>bearer_id, u32 addr,
> 	tipc_node_read_lock(node);
> 	link =3D node->links[bearer_id].link;
> 	if (link) {
>-		strncpy(linkname, tipc_link_name(link), len);
>+		strscpy(linkname, tipc_link_name(link), len);
> 		err =3D 0;
> 	}
> 	tipc_node_read_unlock(node);
>--
>2.39.5
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Tested-by: Tung Nguyen <tung.quang.nguyen@est.tech>

