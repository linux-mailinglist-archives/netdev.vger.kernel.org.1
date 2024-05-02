Return-Path: <netdev+bounces-92865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AD78B92E5
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 02:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D7E1F21A29
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 00:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5021109;
	Thu,  2 May 2024 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b="gA5Wx29G"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2097.outbound.protection.outlook.com [40.107.6.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676E14A8E
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714610605; cv=fail; b=d+mcSX3XsWNNS7nOfvIz1eZfKslXG86YhKX9ZZBxHYAvczdPcovFENwVn+E3wV7eShaDRHWJnISd7qJDeP59qw/iLvuw6aYzVFtDRO5/afAXI/L7WCjU1N8BKFAXz9p3sxmRnh0z6rKleyY0si48kvLlKAbCFAGLoYiDZG6FLAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714610605; c=relaxed/simple;
	bh=8F8B00w67R+vTM5MCZwxlEZhvi58FlihJtS4LFkkZvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZseKCJbhmeNMPGyTykA2Pl9Z1MNXqgjtLNtdryLz82dETf7Mpjt3CtK/xhLHWwJ+m6oI1hajAyhgOvfOVovQbrBjFOftAy9EpCiQttyx2CBpNtML5gy0JZhzNt5scSf4lW/wRgTHSiBsYXx6Kwg1nh+pJArboSO18OtMaS69tkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au; spf=pass smtp.mailfrom=dektech.com.au; dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b=gA5Wx29G; arc=fail smtp.client-ip=40.107.6.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dektech.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxReVs7MXscifsYRuxVYDg2B1safM3n5Eiwf7Cg8P7oChzbRtzd6xy9p/r2bukEp5Ysz2jCKNo9Tx4C8RlVoBI7rl3+7GWy/h7WTFVtHN0T7Ox+Jtoww7baYyv98YRrcRaMIYVje1OdxJVZ6tw2Ei5bMRFh4a1vJlpiazt7i5mYDClYPt8fwPlIZcFUHXBb8WG8qnnDoCn0hUWAy+Eyl8YUAvafdb3btUCUKd2EWNKx25G7ldY3F9LGz4RCQr/473lpZ9U/orY5UWyjzWh55FaF9EE2LqOWrbyiTUQkaOfBqZTNSko5qcUIe64LpqiknYRyG0GreYEWv+vwDQi2FeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbJuRUzg4hIFf6PWXCqAAJbiLx2IyvGDSKi5r1Kkb14=;
 b=ZsZjADcMrEvF4T/+4vgOJef1El5S+QLjxVHkIzbbGGSu0ae/MVmorML4MsnQrOuAkwh8SJAPJBQDz+v96L5HE+IXYrc1B/h/nIPfa/H5xUnnteCSku+Htng+8L9Oht9PYvRsfO3ab/exTU+22Q+XnuOXutxpEkisV3XWRdGtCAJS+j0uJgKrSw9pkaHD0AcEPA0WE70Yljv2+vMoNkkrm/YrPjwnwUUrNWKywhEQixvkoMexSGjGyUt+2XrJ3IwXBF5b1MprsWS/Rt9sn9RKO0aB/Fie5hFwQU3EdlufRHt24qtr3q3DjItxuMluS68LORCoCW3pqCKgIZhz2+yJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbJuRUzg4hIFf6PWXCqAAJbiLx2IyvGDSKi5r1Kkb14=;
 b=gA5Wx29GpSsrNukP+revzjCiYr8nEnOPuGtR9XHQQ5zeGRXO7tlM3tUlhUWkvGGW66ZW1n4AAmRliEcyLTCfyV+8t75FahnBpw1TSeQAQuR33Vkua97HqLCl2B1P72/hR4n/s0jEAlnRH+Bsme7SorO+w9r2p8a0FZpHunqKIBfDmQDyNzAWPZeUzcFMs2k1Smekin0eE8tyCXeD/LdATVFgv8FojnCkEfWdaQkYxUgvWIkoLpS1C0BtMaziJxK98mz1MMTiuT+/Kes1d0K9Fim4zY1uKsyXse0gP5kdjWsrTg5jR7nObZ37xH7ko8M5RPsP+54TK4+qo/upm3I4zA==
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com (2603:10a6:20b:4ce::15)
 by VI0PR05MB11460.eurprd05.prod.outlook.com (2603:10a6:800:245::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 00:43:18 +0000
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::8e06:8f6c:4364:7266]) by AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::8e06:8f6c:4364:7266%6]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 00:43:18 +0000
From: Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue
	<ying.xue@windriver.com>
Subject: RE: [PATCH net] tipc: fix a possible memleak in tipc_buf_append
Thread-Topic: [PATCH net] tipc: fix a possible memleak in tipc_buf_append
Thread-Index: AQHamwc6Wd1ryTuOfUO48+Iyz7NuxrGDHS6A
Date: Thu, 2 May 2024 00:43:18 +0000
Message-ID:
 <AS4PR05MB9647B06CA91FC75EDE6A2BA288182@AS4PR05MB9647.eurprd05.prod.outlook.com>
References:
 <90710748c29a1521efac4f75ea01b3b7e61414cf.1714485818.git.lucien.xin@gmail.com>
In-Reply-To:
 <90710748c29a1521efac4f75ea01b3b7e61414cf.1714485818.git.lucien.xin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR05MB9647:EE_|VI0PR05MB11460:EE_
x-ms-office365-filtering-correlation-id: 357a4b9a-9d42-40bb-60de-08dc6a40dc03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JhNJJl+WcisUZfTcWfKP6ES+TZhd4HBbiJ6X7S/cdepJehJdDD4NpVtbqFmr?=
 =?us-ascii?Q?HpLEP9JD/mmcBN1ilG0KI9HS8SL7SPKCbRG+JOQzbKcv6qn9Pl9Q3l3wZO7R?=
 =?us-ascii?Q?o7qqtAqdZTXbAkIm0I5AJdmy89POvCbjXNm2cVi1gq3Vl68yl/fTltCOzdDX?=
 =?us-ascii?Q?74uVKVdxYjLH02agQXC3TEDJ8VPv2QFwXDYmnajIaufGmLVUIxnivjnTdVAw?=
 =?us-ascii?Q?F0YXHzw6sCzof72bzHZx18mRt0niKnLWlYv6Tgoui/E8B2P8DVJ+p8jdZ15A?=
 =?us-ascii?Q?1xCFq6nPvMFvfHOs/ZnovnMzfMJxGEO3LtVrAEq2CjcWnylrscx2BvXeyrMp?=
 =?us-ascii?Q?UCyYgRnRq3utFPWK0MSdlN1k+Il1LcYQfGF9osWZ5kqDl+FzouilKmGx0YtU?=
 =?us-ascii?Q?HiiT0YQfhVhXuKTve+UBKyrCqSlVBgXAT2qDKj9K0khZOyRz+W+VwFnmoxrd?=
 =?us-ascii?Q?1hE3i+IoydWm14QnxgxIj/DlrkPV+oUfOXYygJu0HVfp4vxjBssNqdyYBFb7?=
 =?us-ascii?Q?VmiruytbJo6cEqUr3NRCrDGAeIl4qL+2tWvzTZIzKvJjmW1mAyatCNUinDUf?=
 =?us-ascii?Q?KJrrmxLmnEIXkpUrU0ufvCthMRBt0ffjtncBzqwIyzSOIAOBEF+EKlePE3e4?=
 =?us-ascii?Q?cUWiiCXuOEEybAh0TZ6b924dbNKg9MCbqwqvp4rTho3mzQes/5831+lMb/BC?=
 =?us-ascii?Q?u52gjSmlLsK3U3HWchuUjrDz8mr+w4PuQzLBWalSUUmz5VKjOFqVdXY8Ip33?=
 =?us-ascii?Q?uaz5K4tFZGmbx0+wQEmvFhiyrmRAd5L7+eINpNPtGAM98RaHt7hOdmSWOxM0?=
 =?us-ascii?Q?lCtPmj/JCRX0ft/GtyNbcJPfxbs/pHzzDzxcawMhH/IR3WUABMQ0DrAzfoPS?=
 =?us-ascii?Q?Qm88sigRhyr1ECzEleewW/76dLxzQl/lMv2iZ9mZJKzAmwGrPGdz9iqcOLbY?=
 =?us-ascii?Q?eTgGxLFZ10VrBwOTu5NkaW5kF34L2zcN9VnKkb+5iDKvD/vAyn7fQ7KWQ5PC?=
 =?us-ascii?Q?r6JV5XD1UZv5+sR/Ybwet+hNP5vz5qaWNJSDLtNheeiReSM3bI4sNcrPgBjr?=
 =?us-ascii?Q?EymDVxKkF6zMHfXw+VYRC1wDG3MQlixw0MHQMgtjNDi6CDfwDKbZrGIBamPY?=
 =?us-ascii?Q?2o75yfLOs8PwdfbM3yHYzU8Q8a0Ysq+9nYV75r/yq5nyEOk4/3vZCoWctZAi?=
 =?us-ascii?Q?I/Bqyh+AjRUkg3rzWVD3GmeL3PO+JbELXxJiBuCichLtBxQg6EFofphu5Urm?=
 =?us-ascii?Q?yItupodwChQU4lsbZ5zcLuthZGXapiH4uGGWvk7tkDyo9cvuvPlLT1NBKk3D?=
 =?us-ascii?Q?WcxaoP/Bw7TKqS6UjqO5ABw4qBrSa/sD7Btzz3NzR9rnqQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR05MB9647.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Mzzwb6f0PQZrPHlFpXWjPQIDwSqT0w6GlL9uEVu5L1xdAhsQ/L9VPp8UA2FV?=
 =?us-ascii?Q?cG8+KPNxaew0ZPhRHkXZBIJdPZMd07A3+3wA17UBcfWkBY4kU9qSADUzxfMZ?=
 =?us-ascii?Q?sgCpbZ6ZYVrKCVagmv14AQjenju/obhXdxvWetUJIjOdZX7qzFP88IGQ9g/1?=
 =?us-ascii?Q?NJ09Sttlh6zWa7kQgdS3BBEv3pV3j5z+HB9RIC4OnnQylA2JOEXQFM55nyQU?=
 =?us-ascii?Q?95HSn0EEa+TKmKaQlMX7QRHWtn6+quz8dE5rh1A8ju3n4akz1bvRjhyhdTgy?=
 =?us-ascii?Q?8XkhJ8O4hhq8OYLSpAJUspWS+k+93c24nadT1Rr/lgjrPP8L/vuIZSPALtEn?=
 =?us-ascii?Q?aaRGKUHM2miEgfq+BMO95UaqmOnha1RioAwXiyxM1fc9nNCqromjaHOaAzQ8?=
 =?us-ascii?Q?+dKi8l8nVOwnvUyWSMYxwKeAVdRH+saZ+n6+M49k23nLNMFzGCYO9/1wemGe?=
 =?us-ascii?Q?lXg543DoTc5wVpeceSKE9qgIxlUE2pHuqgLgYZ13KstHeJ9zkwn8Yf8t+SIz?=
 =?us-ascii?Q?HrdWS4XjvJe78EmIcETfRD3Q0U6ONrp4ft0qUeS0EdlvieoGcS5Wyv/rKSRP?=
 =?us-ascii?Q?tWyYZ7Bw+kTV2k5ukQuIkh2pk5FAVoUJR/uAseuyFe8o41oYRmyzlz657Ag8?=
 =?us-ascii?Q?lIeOfOI0miB26ndeXoZbW1aRgQmeN+Ht5fszVXlm9/27VEtz2d9b9TcWnZhs?=
 =?us-ascii?Q?SfK7AygqWiGZwdR5zVumusrnwGP410JXdmsIuxGgRNraXLZLY7Qs3k9+AAo0?=
 =?us-ascii?Q?iXR7QgdZZM8vOjFbV11R+EjyTEbAbOcRxNJ+2WJ+Yw3uh/9NSazdjqr29H4v?=
 =?us-ascii?Q?LzBPQsXCujambAN8pHA4DxoSHbDOSjKAuMU3ce7L4OBIYuzQHU5Xa4zq4r62?=
 =?us-ascii?Q?OCk+va91jhlV/e8NBktBjegW1cMjqPZFe8aI/2KoWsTiDbJReA1DR4fEYcBV?=
 =?us-ascii?Q?f+mUZT8BwyZOvXEWQLLcys4qe1bugHrYKr0FPuLAEG3zFh4ZyuEClbkUaVEa?=
 =?us-ascii?Q?NEPpwR+Easr4Ct2FH1Owvrp0hjmm8hmkvZjhCF1S5lVys/44+ayodSb1tf1V?=
 =?us-ascii?Q?cEW0aeYeMGsg5eXjI8qApc8odNZb8ycjE3txWUishtFplCqg5/UDU7451WHf?=
 =?us-ascii?Q?m62iFK5Rng+Xmc2ttZ2l1mCh4oXVqJHmBisHNGiWrTidGnpeeYHJSLiAAVDv?=
 =?us-ascii?Q?za7Fn1UlE1ssScbdx28FJIEuaA0y4JUCm/g4/Dx8F1tJVKWdGARGnaaN1TyH?=
 =?us-ascii?Q?0sJdzocJdhwucXeYFvUEtcwmVpRB3r8cofV1bp6oiDN5PgvatNHM66EeMgO/?=
 =?us-ascii?Q?FXcaj0OrB45GVQn7RLLpDxqcFyskCNa2ZG1QN7x+HNSsAXFLqgIOsj1pnQl3?=
 =?us-ascii?Q?u50i3NZZQZ4iWNJkVVVl1/FReaCYHmnbOuf0jA/dFlpgtxti0kIp5061+w6z?=
 =?us-ascii?Q?qgUjFRhmNcq7AtZxUsooC9mD0TrOrwhmCSQlF1zo5w6bzNoxXxGnwfgPXoZp?=
 =?us-ascii?Q?VR4cZOWUWNWv5iJmEjfiNMIThyJOrQtTzrVV5LyRm8g/JdAZKihRFz5glGJp?=
 =?us-ascii?Q?PsAk1zDvqMpqU6N8gm0gTiuyngpP+wHKa8vGbx7SYJzys/wapd6SWFYTHnNq?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR05MB9647.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357a4b9a-9d42-40bb-60de-08dc6a40dc03
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 00:43:18.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsnSEl2tJnH+41tBBT+DGnO7A7OyDlO1ofRvhq4Meczyc7NFffSaAG1jJGKFddoeDUBbWUpFIeCVwD2HwIBrAyhguYfx265UQ0QaXvOZAxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR05MB11460

>Subject: [PATCH net] tipc: fix a possible memleak in tipc_buf_append
>
>__skb_linearize() doesn't free the skb when it fails, so move '*buf =3D NU=
LL' after __skb_linearize(), so that the skb can be freed on the
>err path.
>
>Fixes: b7df21cf1b79 ("tipc: skb_linearize the head skb when reassembling m=
sgs")
>Reported-by: Paolo Abeni <pabeni@redhat.com>
>Signed-off-by: Xin Long <lucien.xin@gmail.com>
>---
> net/tipc/msg.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/tipc/msg.c b/net/tipc/msg.c index 5c9fd4791c4b..c52ab4230=
82c 100644
>--- a/net/tipc/msg.c
>+++ b/net/tipc/msg.c
>@@ -142,9 +142,9 @@ int tipc_buf_append(struct sk_buff **headbuf, struct s=
k_buff **buf)
> 	if (fragid =3D=3D FIRST_FRAGMENT) {
> 		if (unlikely(head))
> 			goto err;
>-		*buf =3D NULL;
> 		if (skb_has_frag_list(frag) && __skb_linearize(frag))
> 			goto err;
>+		*buf =3D NULL;
> 		frag =3D skb_unshare(frag, GFP_ATOMIC);
> 		if (unlikely(!frag))
> 			goto err;
>--
>2.43.0
Reviewed-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>

