Return-Path: <netdev+bounces-226640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BA9BA357F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715F61B279C2
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0142EF673;
	Fri, 26 Sep 2025 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="lzs1GnWe"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA5772633
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882576; cv=fail; b=Tsah8ApBuUcK5nu0/iySzNoub9xjPsVue8HstiG5mMrm/RO3wIqNhnALqtkj1Vt9pFvPjDpRYLRxvDb685DTIqLb2z20Mg3L77zF4pcRSZeQFiE3/SZaYt8fmnlHnJF8mMfmVc1/VCh85g1sghR1a4CyJCb3M3cN9w10s4qpf98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882576; c=relaxed/simple;
	bh=xY34DL2N+hVy4W7XvXhir7Hp6WGgIMp0Z9vj+rqriss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uyO6THG+0kwT3EkNsZ+s2y9KD06aknE1lYNKfTpcRzvzDg6euIwxFt8t7YdxgJmWtPDAB2Gw20SYHK45Q4+C08HQ5gxWoYmCkbebBBKw2+vZIF2BqtGyGfFl1ZGM05/Fvtqw02eRxjihf4DVHRBdzo97RBAfvhGEzvMSmbcx3Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=lzs1GnWe; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heQG+IT8vCOc4eDyskYuvjyyDIHc0rYHOyqWF0MfnYj0zR0BZqTk7Z638ZUo+uUeCOpt/tRqS+aGoN3vumA2z3l5tKWARlHLdVkVShREzPnCOnB004j41wPB+HJEt6TvCFdxLqrWmtkw31IKGjbH3ivMDktZ3UMKOBsYcFF18kICFHoOTWNbmBqvrlj01UnvqorWnYNnd3UibcEb4EiSAC2xQDH3w9JtGVmt3KN2w0hqx0ao8AKw3VBf9eHaaSePCC2O4RN+QubzdbGzfzrKSsg9ouHpf6pD9abhRqelkdh5n+E+2/AKrzb+px7EC9OrLRdnLA+e52pCKXYIQsC0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NOqqU4ZBws1yi5ayNMbZ0HfOlPEooiH138Yo0TTY1g=;
 b=d+juF7w+AGQJULsa0KllOHywEy0s145fwtGgsOPq6yOBoum+EYFwZckVRtmy8xA3McJ92znMlh0fGSowngK4mW4pBNX3GGh8XorTXzan59z4WR+995apHwvx5LTHrlD1E5uJtrZTDA5wrtncOZYuKi0BYDX+QCLjHcVF1LNfsl+Yw4YfXz2pHpFsHrG2du525zrhi6+kjeIuHSgew0kQcruffe4aXoewHlq6bkkNoDRxkZmXRnbRTrisgSN3U6reo6bT8hucrsG8mFc4DlvNnLH8HdfzspdjdEBK3fwCPJ0lij+urO3DmfOrfdcYU+/S9L40bJ84woYfYScarMClYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NOqqU4ZBws1yi5ayNMbZ0HfOlPEooiH138Yo0TTY1g=;
 b=lzs1GnWeEbwdv10EN4AJ5LwP2en7xEOAWwplUm5rFacOOwtIlHg1kNPduOFIznx6BizJ12YFkywy/oI24kBvQM52xxhdBNL0m53TRK/iQbDkoIPSSDe28nG7lQHeLu47uUjAr5AdQN7qsD6Juuryi8F0VxUal4eaQ4toKJaRr2F7iudic+r3CHCIHFNdx8VVKdfLqMO/Cyg9TYanl3E/y7qEcH56AyUynMZ7ZRH1Mey3EqdZqOiAqeffZRNJfvQVzmUStI4PyPRtShrsivDFAFmiQoX091Yy7EKbZT37hVMWKtM/ynyYEBLLeEH8BPUmRsiCNrflicaDZHR91G7nsg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DB8P189MB0620.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:128::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.11; Fri, 26 Sep 2025 10:29:31 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 10:29:31 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Simon Horman <horms@kernel.org>, Jon Maloy <jmaloy@redhat.com>, "David S .
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v4 net-next] tipc: adjust tipc_nodeid2string() to return
 string length
Thread-Topic: [PATCH v4 net-next] tipc: adjust tipc_nodeid2string() to return
 string length
Thread-Index: AQHcLrj0mkvJbfHJHkqfA7IaEYorkLSlQ0SQ
Date: Fri, 26 Sep 2025 10:29:31 +0000
Message-ID:
 <GV1P189MB19887FECAF892F25ED014D95C61EA@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <GV1P189MB1988AF3D7C3BC2F0F8DE2491C61EA@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20250926074113.914399-1-dmantipov@yandex.ru>
In-Reply-To: <20250926074113.914399-1-dmantipov@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DB8P189MB0620:EE_
x-ms-office365-filtering-correlation-id: 7d0b2926-048d-488b-87dd-08ddfce79465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Hvp5D9Sy1Rcn/G2y9Q3zAZKocx0mI4FthmRJDU74hnR72EAI9bL0+zYrJ5dg?=
 =?us-ascii?Q?XnFKgsCDrJ/MAF+Nq2NvkF+/jf4LkyESmhrWa1zWW8BAQl0bjtZiH7+muJDV?=
 =?us-ascii?Q?XCXkx3BGsRvRsMlzyD41evwbjLVfVBNL2Gai0/ncRxs1Y33Ti77E7vPl2Dxv?=
 =?us-ascii?Q?aUsKRyf2oY/DSQACe4o/B2LFnLlWSFV0G3mZVQn5tmXh96BzAj41pAuUNihV?=
 =?us-ascii?Q?AuJ1apXDHLMrfAtmY4PyDSZ3TUkb8Zt44p7PVHbYdp12zwDEmq8hPfvcbuxg?=
 =?us-ascii?Q?RZizYhKp+KRZ2Z3/m0NUw6cB6v9zU/2MqqOeNI91uNCle+HDRmtgKPFPwxjA?=
 =?us-ascii?Q?tyfmrVTyfD30Zbpu/5ltTD66KXjvQiSwHF1XISEaHSmuSt1RSbFnCV5wPJVP?=
 =?us-ascii?Q?a/AO4FnrIsjmZMti2QafEAdLbBt7hweD3W8VL5+CQl8S07PFOD+JrilyYZya?=
 =?us-ascii?Q?DIpnF7KBBdEa24qlk1lHzcH5ryrbMeSDNqR+eZnWc+bFUgEx7lvnhfz/niKt?=
 =?us-ascii?Q?jh4838wuoMGkUmkfuqmMs8KGWnug2+rn4WN2ic54z39GjHGPWEO2zAGCFY1G?=
 =?us-ascii?Q?d6nNy5YqJS3S4z5QNkKeLYPZj1sn22Pl1Z9LG3bbjdlc8QYZNjGOnGtLHwzb?=
 =?us-ascii?Q?R6dc0nRD/8cpfyPZBV71RAKA/JQsZqalhJ3Sy8N0RSYuIgDA5eApD6FDeq+S?=
 =?us-ascii?Q?frseAwmhOM9A9ZUB53Pzhz6cvsBVZ6qPh9CawT+IoyWKe5RJ4b2S2HB9Jj46?=
 =?us-ascii?Q?hMdYewZz/JI9um28GZpKJrXkhxS3qj8YH1jHs5diLWuaqatsCpVz29YtZJb2?=
 =?us-ascii?Q?JXIFGgrse3grjpG4o6Lw01gztNpz7wjU1P74YfshV9fu0/r6MiMZoVJP9sEk?=
 =?us-ascii?Q?HvGof08W+eznsE6j8C7u5TV7kG4lfK0PJwthgRoRmA2w2zME0B9rnYsbsPYx?=
 =?us-ascii?Q?2jgVPJO61bE/0nniyEc2/J8qGtFfnwODGpbIP8u0OLxEIKTOJXQ9sbY4y4Bo?=
 =?us-ascii?Q?NhjyYJ9S70LzIbu3sK1NmtAb5OD39KZT9ib5QhrcWvU9KSm3NM1qXILdBO9f?=
 =?us-ascii?Q?mTfv70pXURjz8K7VyYCqCJgFH9avEURejOcvF8XtBBOIYys29lF6nOoVfYe4?=
 =?us-ascii?Q?USz4mAOcTgxZXAy8n+JhYFy03F+2+HuKrS2nCfmu/+MS3QoktvPBCKFjBwMf?=
 =?us-ascii?Q?qxjB32kyo7EzS9jYiS5bjBQyf0GFHiUEkHRcxc7BcDeosLWkaUJHoRmzWOtQ?=
 =?us-ascii?Q?AzSPJ8rxkIVKGMAGwkLJL//v4ZdKcGj7kP5hftsG66RTTsAy9aaDeTasC15E?=
 =?us-ascii?Q?3GM5zE7IUE8M49L1YRrSzLWQx5r0jMRu3wNuWLOlAweeXpDSevwjEe6tw2Df?=
 =?us-ascii?Q?s+/KTGza5XnGipF4A2QRBjDcD94olurcCgP+tRFiJ7WTtSDb2lnbVQB5MbKZ?=
 =?us-ascii?Q?GZTCm8RIe4dl56iEtKawiQyCcmrPQ4bPBa+0vULB9dKLaa+i0RcI0A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O+Ayu5VLDcHLbIq+z138S1GF1Pt2d8CtB7JVXaymZeyj47+Lkrq7gBIaxHAF?=
 =?us-ascii?Q?AeH1gcZDbZglgaQdiDR+W8QYCwX1ieUSUa1y50Wku15Io6r5xTntszYG6XY0?=
 =?us-ascii?Q?u8axenov4VTYB0uZEV4V/jkTAZkWXxiPOoFT5nPvmzs98iz/50GBkNbubpiG?=
 =?us-ascii?Q?t2rztSM/10SzT/uwkf85rko4wqZPemISP8qu9YeBNaJHtT57WGoPsNsYa3Ya?=
 =?us-ascii?Q?UW1X7JcS81kGg3cQxS+zdaNOljYnnzYj2wISeq8HdzspDNU8Odo75nArFeam?=
 =?us-ascii?Q?iMtNysKIVTt7+B+c/Vl5wDjm6sVRnfjMfUsk3J30WenQbRQEVUGn0r50FZ3p?=
 =?us-ascii?Q?uk4K+pJcPixPz0mJiJ/FuljRk7D08NsVl/oC/94ltzy309yCDkJU5tPcUPI1?=
 =?us-ascii?Q?r7DHJMV7OpWV3LZ1P+yg2NxyhvNpZ1ecIMIJlxxPe7fMJ1AVdDe3eh7vcSyZ?=
 =?us-ascii?Q?NifSqwsbW1QWYkssiX0H72q304oE5Cn4cV/aiW8QCeEdpFQu6tf8MdjN6Gbx?=
 =?us-ascii?Q?Y9fDWP6xhoTLxZ8KKe9iju5gGiQyI3U1eJYdvEw46pXw4issE4uy7GVJxvDm?=
 =?us-ascii?Q?26iGLmXE0NSyoMMNwVP1dlcew0NmfSJstaUlURh584+IQP5Mg9IFVORKmrM6?=
 =?us-ascii?Q?o0tD/5cNmjbh9J+HQ04Fr9ymfSRHK1ZaG1uDHj1fZ/6ys61GuUto/bEI7wDi?=
 =?us-ascii?Q?/3wFXJ2nlJZAngtC6NDiDY+9fFW9mMemVO9aw+5zxA9H0fA/V5FzASRwLm5q?=
 =?us-ascii?Q?bwirkPfjN7lvGN4mvgCCI7vnizbkuy0ABowFe2GgN6lJXZtvXOLjs8yG5iMp?=
 =?us-ascii?Q?X3qbqyzH7bapqP5mupDSEMpNOWjbORI3nepyAOUz+rMlvY15ijZ44HpoLlX9?=
 =?us-ascii?Q?CKASdTusL8lGEDURA+bNAK8osAXPoSPlM8HCcVyOdsFSd5qDSff+VVkgJwY2?=
 =?us-ascii?Q?r06Bhiq34A5o96dCalrgWf/kZy6POIsX6tjVtaVnMGkU1zVzosJCfk26VpVI?=
 =?us-ascii?Q?6A2WOrM61JQHkM1z+K0PAyoxD74/LqrFMwPSmKbTTmSK6Ee7haY1RM1trnfL?=
 =?us-ascii?Q?e+207HFK+DEXMTNiYxQPcf2gjMKG6E/UgurChl8NHaVubRTSC25W+dulxWZN?=
 =?us-ascii?Q?ozEf14M9h8JJrKx5SK+6jhOYKbIKCIPKUY3W/XqiC1RrWP7RCd/0DyZEbqYU?=
 =?us-ascii?Q?BSnPM+WgCwJYSV3d5GSVTIvRXb4YYIjBLLekPlluJ/unOjfqhgwp5BB5RUfr?=
 =?us-ascii?Q?9tsrik9ej5NDFlZM6IxKRaqS7+92UVK5YwYhbbcXN6jm1fQEaFoNOlzyVYVA?=
 =?us-ascii?Q?mOoVco6Nln69njCFIa+i0NXpuZ7wkoiUa2/G0YD+yNqQlzQQ4YB728JBnpKc?=
 =?us-ascii?Q?QvrVNJN2zM1fuxKn8i5hket7dQauAuzst0wkZLIMjaySXNBltBSn/iAE9JNg?=
 =?us-ascii?Q?AGbz/h8xS4poDSSsXYXBGoq1tK0NlZXXCI5/RL6D6Ts46BMXSHpDdD0+ewEG?=
 =?us-ascii?Q?GAoTjofIrG8rkjk+v/iMeroRZt5+RVNP+afJL7jf3dcQLPoKpByLmIPT1ATj?=
 =?us-ascii?Q?RUTHmzu2K6Xwts7m+k5ASsjg9P1sxggHvEqmkOa6?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0b2926-048d-488b-87dd-08ddfce79465
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 10:29:31.3342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnjlAMxhIT8BAp8s0lmyx76HPOgVv4MxqoSTHq7R2G740RuDBzW8Q52Ut5eGTpn5jDGSeV3qy9nP2yeiOupFgUl8QkLGC1FY4Tez9gU+UrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0620

>Subject: [PATCH v4 net-next] tipc: adjust tipc_nodeid2string() to return s=
tring
>length
>
>Since the value returned by 'tipc_nodeid2string()' is not used, the functi=
on may
>be adjusted to return the length of the result, which is helpful to drop a=
 few
>calls to 'strlen()' in 'tipc_link_create()'
>and 'tipc_link_bc_create()'. Compile tested only.
>
>Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>---
>v4: revert to v2's behavior and prefer NODE_ID_LEN over
>    explicit constant (Tung Quang Nguyen)
>v3: convert to check against NODE_ID_LEN (Simon Horman)
>v2: adjusted to target net-next (Tung Quang Nguyen)
>---
> net/tipc/addr.c | 6 +++---
> net/tipc/addr.h | 2 +-
> net/tipc/link.c | 9 +++------
> 3 files changed, 7 insertions(+), 10 deletions(-)
>
>diff --git a/net/tipc/addr.c b/net/tipc/addr.c index fd0796269eed..6f5c54c=
bf8d9
>100644
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
>+		return i;
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
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 3ee44d731700..931f55f=
781a1
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
>+		if (tipc_nodeid2string(self_str, tipc_own_id(net)) >
>NODE_ID_LEN)
> 			sprintf(self_str, "%x", self);
>-		tipc_nodeid2string(peer_str, peer_id);
>-		if (strlen(peer_str) > 16)
>+		if (tipc_nodeid2string(peer_str, peer_id) > NODE_ID_LEN)
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
>+		if (tipc_nodeid2string(peer_str, peer_id) > NODE_ID_LEN)
> 			sprintf(peer_str, "%x", peer);
> 		/* Broadcast receiver link name: "broadcast-link:<peer>" */
> 		snprintf(l->name, sizeof(l->name), "%s:%s", tipc_bclink_name,
>--
>2.51.0
Reviewed-and-tested-by: Tung Nguyen <tung.quang.nguyen@est.tech>

