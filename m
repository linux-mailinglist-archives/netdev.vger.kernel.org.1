Return-Path: <netdev+bounces-225787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C56B9846D
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDCE1896F6E
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 05:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582321FF29;
	Wed, 24 Sep 2025 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="oQyQbpeK"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D229C1946DF
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691217; cv=fail; b=QaAgBp2AF6sMNGuniyIqpiE3vo9lAmON0rmHcwz/SZPhKAcYN9TDdDlMouP3L+QdDrFYHjIow9p8a+n8fePWDF+Y6rgL9NcAHhdaRyPRm3l5725rh1+UgY/TIiVaaCGhlY4ja7LWAtiuro/Vrn3ekburmi2tstMzxP/L8gOHrlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691217; c=relaxed/simple;
	bh=kzWnKqpQII43lzUvNWwpmB36CiSJ0MHKyBsqL8f2Hb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h7qotfL1LDy5Tjs9NTM4C5DdwMG2jwBQSjqLjSkBIu+gxHdkxcEEYGKNxvemcRQVUnSVMfcpm0HrJ3+pT68rwgWoGI8dybP8UE2VNxm9COzXHgrxkrr5+zxF00mPTP2lvlvuXN/HNrndRV7QQT97Zcj76qT1xh9kOMVFKW5JcZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=oQyQbpeK; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7IbM7rz50Lj37LqlfPv3BVRjNtQiuPDatHhZHswR+JQ9w5mrYTpBHn5hmWHJkU3t7Rpvu/zZvj1eow0ewtKPqd+ATQsPXTQtbUAFIKQBrmLZm0CBdB2nqzSX5my3+/oZOs2cZpwnjB2HFZsuiOvN368uSOKYiIKmUDo4WSXZFQxl2MvvppflYNo1lwXZOrMb6cD4Lo0l1KOJR8YrA3elkfFznkB/+DbvCVYPLgjV7hmRDZpzsAArG7lTb5v/m1we/u4iGzW7EAKCFc/S2bPHKqwY6teLodsEu3I0K2YHIJQ0hAeIORz+rD1bgk/jaP90bdT03o4f5T7S/eMJ+TJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mD9iZm8y14b18wBrrxpjmeWVkQ5UYh8IteqI3F0T9g=;
 b=ZcJKBswJwNSVBwmPq7VW/Ud33IfF48Npm0jTIPL33NyYHrIzRTwUtHKFIXiDL9WUvr9CLfkpNYrAs0Afsu5X1V+mIypJyose/Z/Yk0bqZ3FEV6pSPfhBgbBypt5Xe87d592fJFc/LYwpZbKlE2c4f4IkfJeWNZbEqOtEjyABQhkJFM0/wJMnCloDPb2bZziwuf7OWRReY9MqkRZDij5+1mEEwxcNWz7T9XmgJf8LQGEGTQj/XtvTrPYW2f39iWBmzS1MnlnkP3gqPpAUIJHYmxiJpJQsTfFKbuMu4Fi84UEdpg1/eB5jdP9NY55xRPpgaYvbaNjsTlGtI1zdGihFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mD9iZm8y14b18wBrrxpjmeWVkQ5UYh8IteqI3F0T9g=;
 b=oQyQbpeKDg6rnRvW0s34caGQ63mBzsz215a8lKxyImRa9WNIIXcMF5qRWkYTJsbsz9szJp9TpQ4L/xRwAagT1aO9yaS9spXm2a4cgaFHknO51t76dTh9g4ta5i6kyIz/S5AhverZvloLOC3FHrPH0SX4vQBNR4FHSIigB25NxbcdKx7XkhOptAQEADTScSiyww74dHvT4pjSd9mkGSwwI5bxifpjUMWDibIAoMTPm8PbAXA5FNz+bvnJUeDPwKHOJXCvczLKDK3M/ygG3wa9Hmq5eirkvqFi4hpnkZ3fke5XXv+5i5Y0gazSo6v54oVNF/mnFDX2GY/Xu6OSfFGmlQ==
Received: from DU0P189MB1994.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3a6::11)
 by AS8P189MB2152.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:53b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 05:20:10 +0000
Received: from DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
 ([fe80::6302:fcb8:52b0:7dde]) by DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
 ([fe80::6302:fcb8:52b0:7dde%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 05:20:10 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH] net: tipc: adjust tipc_nodeid2string() to return string
 length
Thread-Topic: [PATCH] net: tipc: adjust tipc_nodeid2string() to return string
 length
Thread-Index: AQHcLIcKAK9u3t9EWUmnLTFxk/pSH7ShyyKQ
Date: Wed, 24 Sep 2025 05:20:10 +0000
Message-ID:
 <DU0P189MB19948C9F84C27D90EB1E2971C61CA@DU0P189MB1994.EURP189.PROD.OUTLOOK.COM>
References: <20250923123148.849753-1-dmantipov@yandex.ru>
In-Reply-To: <20250923123148.849753-1-dmantipov@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P189MB1994:EE_|AS8P189MB2152:EE_
x-ms-office365-filtering-correlation-id: 1a24978f-d506-4b1e-48e2-08ddfb2a088d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Igdi5GOEhTUYzendSugQXxjDwBuEUs99NUU/k5KiqzP0NG301TxIwYPnprke?=
 =?us-ascii?Q?vCe7vTzFfqezv+RpbcLmGmy0mdIr0yLxl7rv5U45zFOAIzpOq6My/msT/Ez3?=
 =?us-ascii?Q?2yp4znmX6IU2XdCj2Px4sVDDUFlI4ikO/UwnMVfhNmsMI1hagiMpRmvi/8oZ?=
 =?us-ascii?Q?nhDijRc7mrTK7oWWnxEEdpQBtFFYMwBH19xKtK6olLQK0HU5YzBnWVkNtH3g?=
 =?us-ascii?Q?yZHxxNrjuoNiyo+/IC9hJGgC+jWXw8/Q3Y040YbRRz4iqY1huU3amFL9+rz/?=
 =?us-ascii?Q?1xJZBfoiVoJsMfVy5yF08QhAW6Sp1aXCEp4m9zXIFngpAT5yC+auIilK08IH?=
 =?us-ascii?Q?C7AlgXr7vY3md5in9RGejshg/D8L1cmBmqU3xdDHCg94lp4g0nCcFceDsmG2?=
 =?us-ascii?Q?Q70D268irJP84f+ISMnvppn48tSZtvgrIXnJwGHOZG/Tm2j4zYybIuou5SiI?=
 =?us-ascii?Q?COv2KkyKduy5zUGLUXq7BAD+JgbkCBiPXJJGkSBZU4nCYXWtg5Uu8aqbqE9p?=
 =?us-ascii?Q?vb687n17/Fslx9vKIvpKxt8aEBfvp8/prt2I2V7RhSk7mbI9jmNlFy+VnnoO?=
 =?us-ascii?Q?6T9vTj14LMa1RIlqVAeMlac0f/njJEaFT0DAz3ASDscMS03kPzbu4UlByWIq?=
 =?us-ascii?Q?ySMsYlofDLrK18FXIt2u/rs5BjnWq38tWyGymg4JVip6x1frdPyJDzfvJYmO?=
 =?us-ascii?Q?v7atf/XN2nWQhlEunKkyB7oDyrUA+MuciNZLwfv4sWue0Nw2c1o8gbpCiDUO?=
 =?us-ascii?Q?++Rd6b39s4Tv/dIZfmFOxpIH8/gfxUU5OL5qVkfOPs6QITbNsIELK483oEQ4?=
 =?us-ascii?Q?8JA4S4CY828dtjVk/UX7KXpXyN0k49Kmih7nR3mDS70aTbnPUkdCwbfQsCfZ?=
 =?us-ascii?Q?NFzfj9PK8JCG4Qgk9WGoBTJHBxEJ7517ayZdpCSLiuc0QxNWWPgmmp5mIjid?=
 =?us-ascii?Q?gHs3IO4MKO9i+xz3I+inW4p6Nmo/3HGdPnzk9nl6jsyRli75vFlS50gvdS5q?=
 =?us-ascii?Q?nk9t1d/c6W/8p+FZtS7JLFMCw4fPmdyEFwQyWQayjQDWna0xp5tioEbhzKs8?=
 =?us-ascii?Q?e/NicuNOHT1t9eicF4IabfadX99bd4AafXk/CJJCQtVscbYod97AYYkqgz5n?=
 =?us-ascii?Q?GU2CfAivfoBldKCE9SU8PdmnL9lhBs3sbL9wMSvSYG41GtW3s1VRnjlCy+TE?=
 =?us-ascii?Q?Qfk2QyOQA/Q51WXhhN0kW4x32sph1UKzDB71/MuHj/E2rAezidvXj+w5Pwg6?=
 =?us-ascii?Q?Zxj2XeSpUzjaAvzhqYsB4AI2BTXX6QlrfKiYzqv43Fi4ujJbbBsii6b0EQZy?=
 =?us-ascii?Q?GCMdv4z1jAtBphddt091QUxStUdMUeF8ovOBSyhgypVrPUMq3Yv0kHp+JFab?=
 =?us-ascii?Q?cpIQPs5XOOPTVIMbKGpM916s02mUyv5CMBriJfPyBIga1qyjCOwKW0z7aRik?=
 =?us-ascii?Q?OtsmiptZ062lUMx1cY2bv6n1ulQ5BfuULAvJxLN5H+dyVDisOnRCjg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P189MB1994.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J70Rn/b2sVHf8zXxJqOKHrxkxbgrRmL08Fk58d7rUy6MljdU5yYh1/dbXXPX?=
 =?us-ascii?Q?cCpvZIePRPqMQ6vuC2laVWPDNMuFX/AtB4dQRrJw+1USyrnV9DCig66nT0Dg?=
 =?us-ascii?Q?NOBVt4eeFlGjbAKKEXPSH53OA+ZcUQaI+mqxygcuaTnFaXmJvfaz2MoXEW8O?=
 =?us-ascii?Q?WP6ugKzCtn81mV+qUaz0ucJtlXck47ewax+xvCssUZz5R0qAoaYCHjfyiykc?=
 =?us-ascii?Q?1+jPaUduJwWEPHu1grZaGiRbvp1uxRu7qRiPxHoIIulPOMtFtmFwb2k0zZZs?=
 =?us-ascii?Q?CnKdUXc1HYvvClocmDP3uHWh/Azb4epMviee3sp+AO9DeU5kNti7BHsPmnqy?=
 =?us-ascii?Q?riyoOuf3AfDOBOMyFbLzOeYKOXriTj5RjjiuKn3eg7wdI8YEy1qv1Q+VK9xy?=
 =?us-ascii?Q?tf4U0SWwIPfUusGydMlSNQyc23766/J9vxx4acXS0N8sgbYX2k50i70f/rdy?=
 =?us-ascii?Q?Nfj0JUmDzCh2CUujtJSw8seq/XCpkPWUnV/VI8ErrKVz3hhqpU0gSoY3sYvv?=
 =?us-ascii?Q?NY9aE6OKVpg5Z9W4YAErmsVWII1csnZb+wGOWs/HuYHbH9RQhVoxlHggZcXz?=
 =?us-ascii?Q?mCmnK+f+UzWNL7J5ZakrrdYVhRRRbMqEzsu6DcBeynV/PxGn0X4zq+/KQkFt?=
 =?us-ascii?Q?G7KUMpnmR3w8IOIlwwLKkBjCQqOluFnQODSxEXNPA5B6tfgKg+dbnMyn4z5L?=
 =?us-ascii?Q?xZbaHmcSIjysLSAoZk+mzI3mliGYrEj9mxu4jciItRwi807EzQ8tnxJ172nq?=
 =?us-ascii?Q?JIZIMcjpndbjF07Ec09pScsv7I+iDY7ODGGyWCN7WHYTfSXTCdjV5Z6kseGE?=
 =?us-ascii?Q?DhquuTiHvqkGMwsHhE4CuBOdHecoTejIL30XKn6B/q9UOnEIeCxCbuuykK6y?=
 =?us-ascii?Q?JIJaIe6/lIBxZSg3zAF3UH3oSQaXDey5QYsmFqYwVnrhT9F3dh8oOvCelmxH?=
 =?us-ascii?Q?DsAcs8GRHdVH/W/Zcm98D99OOXA5LRvecgR63neoLAgkrVzi1YSVOw8t9I0X?=
 =?us-ascii?Q?q4khq120EbCt6IOX7mcZefoy5C9WAGx7RdRFwzafDl9vGC1Gvv17rwkJc9FK?=
 =?us-ascii?Q?/Z6cM2UBu0e8/VYjuIFK1/Kir6C8nNefnAQ9FZXH9+x4T6tuXB90tWmaitlm?=
 =?us-ascii?Q?TJzdX2cVbgcHb+MqLf8YpN1u9T9yUlVpYPm7YuZFw4jyQGpKuGFXBSkdI3cr?=
 =?us-ascii?Q?iTP/ApLsSnWjav1AapxcQJXdakonfZ5W5+6RsgeDHW/j6eSTmQ+SrmyP92QO?=
 =?us-ascii?Q?zoUzJdzN28k2vN16BaP1PMm2QpuPi1cdr8Xua6sCGfzGm1h4C25AjSYTd1rF?=
 =?us-ascii?Q?+HhN4Psge6RbpClXgiR976ONs/kHzEithPgv/yE0ZnEEYmkxdPqntCS7qgjH?=
 =?us-ascii?Q?ZJnugtKNa1rXwkQA8fux92ST2G0dWVDmwUjaew3OzqNEB0M9wH1cQ0v5Ce8E?=
 =?us-ascii?Q?DZaDBjjm8tbe2hWuKMNI6TLDn0L4b3XUACOe5sVAV3s6IOA8zDcvUMuc7WHu?=
 =?us-ascii?Q?gpnGD/kj3xqws0R9cgKV28wn2mxDvmY2pLoFxyc6CFGGTEtFlInIxO6OJq72?=
 =?us-ascii?Q?VlMFFWpFASFOgOZm3S9oQvBBTBK8yrgmx2nyYi46?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0P189MB1994.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a24978f-d506-4b1e-48e2-08ddfb2a088d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 05:20:10.6676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pudB73CA7mPkT8VVONUY2Ly1yALpAq1HYoLdy4+n93HJTisYas1lCfohEjw4+JXPS36hJf+yBQd5y6djMrcg0Wk5c/2Ylp5oBsFXzotTXZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2152

>Subject: [PATCH] net: tipc: adjust tipc_nodeid2string() to return string l=
ength
>
net is not for code refactoring/improvement. Please correct your patch titl=
e like this:
[PATCH net-next] tipc: adjust tipc_nodeid2string() to return string length=
=20
>Since the value returned by 'tipc_nodeid2string()' is not used, the functi=
on may
>be adjusted to return the length of the result, which is helpful to drop a=
 few
>calls to 'strlen()' in 'tipc_link_create()'
>and 'tipc_link_bc_create()'. Compile tested only.
>
>Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>---
> net/tipc/addr.c | 6 +++---
> net/tipc/addr.h | 2 +-
> net/tipc/link.c | 9 +++------
> 3 files changed, 7 insertions(+), 10 deletions(-)
>
>diff --git a/net/tipc/addr.c b/net/tipc/addr.c index
>fd0796269eed..a8fd119047e4 100644
>--- a/net/tipc/addr.c
>+++ b/net/tipc/addr.c
>@@ -79,7 +79,7 @@ void tipc_set_node_addr(struct net *net, u32 addr)
> 	pr_info("Node number set to %u\n", addr);  }
>
>-char *tipc_nodeid2string(char *str, u8 *id)
>+int tipc_nodeid2string(char *str, u8 *id)
> {
> 	int i;
> 	u8 c;
>@@ -109,7 +109,7 @@ char *tipc_nodeid2string(char *str, u8 *id)
> 	if (i =3D=3D NODE_ID_LEN) {
> 		memcpy(str, id, NODE_ID_LEN);
> 		str[NODE_ID_LEN] =3D 0;
>-		return str;
>+		return NODE_ID_LEN;
Using "return i;" is simpler.
> 	}
>
> 	/* Translate to hex string */
>@@ -120,5 +120,5 @@ char *tipc_nodeid2string(char *str, u8 *id)
> 	for (i =3D NODE_ID_STR_LEN - 2; str[i] =3D=3D '0'; i--)
> 		str[i] =3D 0;
>
>-	return str;
>+	return i + 1;
> }
>diff --git a/net/tipc/addr.h b/net/tipc/addr.h index
>93f82398283d..a113cf7e1f89 100644
>--- a/net/tipc/addr.h
>+++ b/net/tipc/addr.h
>@@ -130,6 +130,6 @@ static inline int in_own_node(struct net *net, u32 add=
r)
>bool tipc_in_scope(bool legacy_format, u32 domain, u32 addr);  void
>tipc_set_node_id(struct net *net, u8 *id);  void tipc_set_node_addr(struct=
 net
>*net, u32 addr); -char *tipc_nodeid2string(char *str, u8 *id);
>+int tipc_nodeid2string(char *str, u8 *id);
>
> #endif
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 3ee44d731700..e61872b=
5b2b3
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -495,11 +495,9 @@ bool tipc_link_create(struct net *net, char *if_name,
>int bearer_id,
>
> 	/* Set link name for unicast links only */
> 	if (peer_id) {
>-		tipc_nodeid2string(self_str, tipc_own_id(net));
>-		if (strlen(self_str) > 16)
>+		if (tipc_nodeid2string(self_str, tipc_own_id(net)) > 16)
> 			sprintf(self_str, "%x", self);
>-		tipc_nodeid2string(peer_str, peer_id);
>-		if (strlen(peer_str) > 16)
>+		if (tipc_nodeid2string(peer_str, peer_id) > 16)
> 			sprintf(peer_str, "%x", peer);
> 	}
> 	/* Peer i/f name will be completed by reset/activate message */ @@ -
>570,8 +568,7 @@ bool tipc_link_bc_create(struct net *net, u32 ownnode, u32
>peer, u8 *peer_id,
> 	if (peer_id) {
> 		char peer_str[NODE_ID_STR_LEN] =3D {0,};
>
>-		tipc_nodeid2string(peer_str, peer_id);
>-		if (strlen(peer_str) > 16)
>+		if (tipc_nodeid2string(peer_str, peer_id) > 16)
> 			sprintf(peer_str, "%x", peer);
> 		/* Broadcast receiver link name: "broadcast-link:<peer>" */
> 		snprintf(l->name, sizeof(l->name), "%s:%s", tipc_bclink_name,
>--
>2.51.0
>


