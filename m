Return-Path: <netdev+bounces-277735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPsPDIwL22l48ggAu9opvQ
	(envelope-from <netdev+bounces-277735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 05:03:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE23E2922
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 05:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D67003012D78
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D32EC081;
	Sun, 12 Apr 2026 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="aZs30Lka"
X-Original-To: netdev@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11020139.outbound.protection.outlook.com [52.101.150.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303842DA76C;
	Sun, 12 Apr 2026 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775962998; cv=fail; b=eAveWp7LTVBJ35fflozxC8EO6e6BLMCu/TQh87QCteMdYoVDTRLAfdICMs8YWb1Bkvwe+6mGvBHRDN38ezVEmp3DSJZc8b+HZ7neGTS0dqjAn39otHm/jRJsJ8ez2A3ZzAVvBpAQ0QzsCJJuXWH73VZSayma+5Qy1WSsgf5yZlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775962998; c=relaxed/simple;
	bh=95C6nPI9bVx07FFgaxrlksclf9rfDie1CvRpUoFBpjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=loCIAruN+NMKrc4fenwxR87LjSFIFa1OqLaEuT+xxGmfKbMuSqfSr5kmguloRWlTWNVJb2TjmmzrhePY7nnT7QOyaumoTXP/wZczulZYdRpx2Zs8Vkjx/KwU/ugXdmO0vLa3izi0GtpU/eujdFVyVbmBcKJYtdew1R/zKfaLiss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=aZs30Lka reason="signature verification failed"; arc=fail smtp.client-ip=52.101.150.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMz0ezZxJX7zbHJxOb9hMcdiVOMuIAfWBN8YQu7Ze/5NsmK8gonFcmiYGhrYV4frpApVKVcvMs0KGUXCkOt/USj7OBbVazYjdiHg0xLs0bOH4lqC980226/Pq2kXVHwIZZ3Mx3REotBP5UQq0QI0MkpgbQgwz5mZnWgFJTPdjoC+2SHiZeHJM9WdswgeQV+1o3n97EGYSrTX2CoF8Qz90JLU3uVEEachaxcGdeJcQ4vcayUmhhEghfIIvMWaNVmg1ubp4gHEvYvzlZwvBxmmVKrMBQFOQAX+bkd0hSwrvxsF6rHtcisk6e0skBOIisbxyg0/SxrsW0VwFnS/+X5O1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZLV8k1OLoZBCYEaoEE/z3Kt0tmINMbkBl28PBiaICQ=;
 b=Mx2S+BlKDLc3Zb3Ag4YxwfKm+weRoEuNT12MHrp693LFVivKOzuRF0F41kNuSsXvrjHGU/S2aqOYH0BiZSdQ5m83HovnB8ePWjpMa4GA7x9sqfOagBa73ptwI4lIA9XjFSRbief/GZIxc/6K4efKIEJfFJ/QaQjJOIOdSuGzoHNuFM4WC1yKzZdVSf8eI6uvxTj2VNscKEksDcK55Wmz6/lco8p0/RmqhETR09x9XARTwey351iX1NDKSsjIzxwTfnwd9lvQVX3ZnQAlk5U+TbhzZv8WhsmbNQ1h/tyUQLcP3ZGbAGrmfP4MCXjAD5MrpaBJ9726JxmJhOT9V3/39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZLV8k1OLoZBCYEaoEE/z3Kt0tmINMbkBl28PBiaICQ=;
 b=aZs30Lka+vV9lF3TuQfiRLVi0mICz12ZI9a7LfVSMQLqCAcBZtYMzAZLObrzebfkkW4ArbBrsDvMVPT6OJ++oeoqJakTActJ2JDBOmep9Wcwcgu6+Dp5gb1ODXT63ASI9CGc3avELhSfl/j4LsUGsqlYUbvO5XGS9MHqEWNyOxO+lgNr2L2Hn5H/GQzhP7uXGf13c73hv8fM1IaRZCC/Bua8wrOGcVv8qJJ83c3XffmXLA0f/O4pBSJCogJgiUts6v05smvZOJyRYcAf9/V80j2ffuJVEXIbmPJf9TLucUbXAYi3JaMFF3BT+0Fj+L/XA0RSKA9X5uRyabEysJ2S5A==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by ME0P300MB0668.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Sun, 12 Apr
 2026 03:03:12 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.017; Sun, 12 Apr 2026
 03:03:12 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>, Lawrence Brakmo
	<brakmo@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Werner
 Kasselman <werner@verivus.ai>
Subject: [PATCH v2 2/3] bpf: extract SOCK_OPS_LOAD_TCP_SOCK_FIELD from
 SOCK_OPS_GET_FIELD
Thread-Topic: [PATCH v2 2/3] bpf: extract SOCK_OPS_LOAD_TCP_SOCK_FIELD from
 SOCK_OPS_GET_FIELD
Thread-Index: AQHcyijmxk9liJNJB0WRD69snjJAbw==
Date: Sun, 12 Apr 2026 03:03:12 +0000
Message-ID: <20260412030306.3469543-3-werner@verivus.com>
References: <20260412030306.3469543-1-werner@verivus.com>
In-Reply-To: <20260412030306.3469543-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|ME0P300MB0668:EE_
x-ms-office365-filtering-correlation-id: fb080b18-1d9b-4b0a-923a-08de984008ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 iGoaLNeD4qpmlpUfS+OKxHL2TTOe+nBVUckQ2pXio4w7xFQSnvHO8QVwtMo6y3U57x/vGl1jvJulLMoWLno7vn4lHlCkB6lMJxaXKXjvMTpVa2Bh87U1wfKZeD/8OICl//FB/Y84COHWndXZCOMI1wfUXtcl8OW+mPOcHHXdJsEpTHQsNlQ0N+71T8RcedscCWwgVgBkYrbGeI3+Z38ytTyBx2H9y5raKWJSrqYGYpH1C14zqyFmkXgMHiUOr8+qVO05+kA1NaCwYnKiZ5byzMhKmK8aCpn2sP/gz+UtiEf/WxMv+2XeSvPx8dCLEbpjWf+YaAhndqMz9F0wZ9tL48J0VQBWXlSmB9b0z2WfwbxJnD9WQZjwxlmaVjHT2UizVCvChIrlbm1PVkt0KqvKPZexgcUCajs7tiTCJ+3/5GEfOX2nrchUxmmxMKTgO7Y8SRKzJUd15XwV+kyps0mQNNZ42qn+vaBJwmVOPTRxKKiUF3bRo3Xez06taSxt9F/ezgCwp+WEFynYxouA3uhc0gcuUN0gSg3BXZeXJ0B949CXjW4CAoC3d66E9rOwPtLGjCjHGdrszLZl5hzgp9WkVyKI4by9GQvq2zFj3dELeg3xeDesQOzJfdRV2BzATBZmvgbYWInuzM3qoAxloyeyZJm1hmvb0r1Vei4r7uOKdljmA5vNEeVMIRggP8ocfdn/qQwdIXreWY7UzR+SNnbyFFGCEDHPRPZWKn92yZh/4w2JQ08R6shvHsMGhymnJyJO5jDy51cgYG6TFawCeTV/96BynumlFlSe6IbnibeO2bM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gPq7sKAqpcfkUNaY3tZkTgd2uu+qKt0pmCbyUWKjTaaYZLnYxHrOo/jRxq?=
 =?iso-8859-1?Q?eyYdNyGTgqs6XjYqZitsn0PyhgYFI4IgfgAKu/Focb7bvF+7o8uyej9lvZ?=
 =?iso-8859-1?Q?/QiwLQXJaiTRYtozTbXKMbnFAZ88fzyN8Jxz3bWtOMskwVR6MBiZZOY4/G?=
 =?iso-8859-1?Q?KdUG2SP7c1msgTRoxYLDgekjnA1IkFntPanKNDfGwKdPGjrQwoJgjRHHZR?=
 =?iso-8859-1?Q?z65HpwG3xX2IcBjdh8uTAontdYnTer1JbRWnXgvmceVTk3SnatIuFNh52/?=
 =?iso-8859-1?Q?nEKpNK+5lixRFriR/CfQATxqG2jBRKBU9Drj2z3bF9QUanSz49UROEoCdv?=
 =?iso-8859-1?Q?j46fdSlwMJeSIvnG6vx5G3JlaqK5GxdPRE/Oxec5Hjv0KSJkOMcS/CFVhg?=
 =?iso-8859-1?Q?2FHtCvgw7HNlipdo7I8ZkmVs6Oz4EK8uogYB9e+XhDHR3eJjj1HuLEWPMQ?=
 =?iso-8859-1?Q?pveWLkRNzzR2tl1JuNIaF+Q+l128QKWdB0jaKRAIYC5j1j4m10yxeAowfP?=
 =?iso-8859-1?Q?MbdxPdRDcGUTxW5oLNY/QgEEpyqOEQuq1lQpS8eLEW/lCx7aeqZQQbyPdM?=
 =?iso-8859-1?Q?FDu1cuzVWeTI7tjJJXUNoIHZ4xxuh83lWQUP01MUPK42hftgs/kyp4nzui?=
 =?iso-8859-1?Q?+7dJDsZxFCIoOq3ou/t5ViqDJJaIjN308f2B11/18CVV5lh3yNrVb9TF6Q?=
 =?iso-8859-1?Q?xwVM++FDHPE0wLMJ2/wmzyMRYBg9c2OtvCux10bnyTJWsqSSSlxjAwvdoU?=
 =?iso-8859-1?Q?gmZEkPl2UlhwmS8xn/qVStC0QXZB40ZOcDBRPFVxsoMMSjKUhgJpQX4oyq?=
 =?iso-8859-1?Q?QL8QyR4i10auCt2kpEoaXVTldku0pMUjN/1JrD4qWOyHuH41pZ37KHDwGY?=
 =?iso-8859-1?Q?/H5qpLajscw4vUBP1V/oe3y6ch0G6tTvehHPh6I8Rg67wepvkhsv+aLxwi?=
 =?iso-8859-1?Q?mYYKGITMuFKW2w8ptpO3NDiQRbkQbpexKe65NvM+DcXDl7HbGRrfOl/qtt?=
 =?iso-8859-1?Q?e1QBBpVJ9ij4zFnDqIh2MjLrhj2/JB7txYE8iIfZmHjKesXDjSuuFUtW3j?=
 =?iso-8859-1?Q?ttfBcHxLtMJ1mlCUipZnn18E8c1yjbr2iczbCPWL3PXs+h5ZAl1DQ3Hp0L?=
 =?iso-8859-1?Q?liogMdDkXVKp6K8q9Vh336VckhNaRdbCoxPFIdkuQZSDSgWUoLjVpgGuqK?=
 =?iso-8859-1?Q?0Aw7DxOZYsS9Th0eUc+7zriiq9jtvvcx4vungBpPnCy6Uj1zfBPKYzxo2a?=
 =?iso-8859-1?Q?8naslphYIMJ3WreGI+kcFOUGkRuwwOM0LRMFRxnlwGcGD0K2ZqaKbQumlC?=
 =?iso-8859-1?Q?3Y8PXzN8Q+r5Hhpgurq6XWCaOzZ769wzLaepsoLwhg8yvWqHVHNwoVO5X7?=
 =?iso-8859-1?Q?XVTlrLyZepRlhDj3Yt/NbGeTK4i83EhC2E0JTieOHNnSqpwVs+ot0oXt9p?=
 =?iso-8859-1?Q?2n9Y4F0yuKMNyZmjYYnDT+8xLSALN11Xme6RpIQIzYS62G9BDW5EUmMlUq?=
 =?iso-8859-1?Q?js+NGrNSPmrGHSaIhf6RGElt8d2pAYflcYHzhVp7I9OUKUXm39EeJS1BQ6?=
 =?iso-8859-1?Q?qwR0yWzJ4j4TRPdh9c97hD5d7Aos0rdPj1Zu5f7HZmt/hHb9HdMKRkHScN?=
 =?iso-8859-1?Q?nRcVgF56pErHMSdwnx1XEcU0V800j6EjizER6WFxLQ9LrmQI6+XZagVQ8Z?=
 =?iso-8859-1?Q?5rL2d5v9C9VSQeIkI4S4kVoTXuakUVqefoRP+ICXCPY0jj65DXx8zbMrtZ?=
 =?iso-8859-1?Q?+yaJ00B34QDCM/abybtF8ZGAFeplLWvWyxr9a6wECarc8lux0PGq2Rlsgt?=
 =?iso-8859-1?Q?hlMweQiQug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fb080b18-1d9b-4b0a-923a-08de984008ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2026 03:03:12.7612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9GZHugJHVOXbbNFHhRNrX3/fusQtrhp3vsFY7ZE4gurynBARc80e/qp0YEmlEDysFxYjoUiaptDHVp5LiojeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0668
X-Spamd-Result: default: False [3.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277735-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,kernel.org,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,verivus.ai];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.948];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:email,verivus.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25CE23E2922
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Split the tcp_sock field load sequence out of SOCK_OPS_GET_FIELD()=0A=
into SOCK_OPS_LOAD_TCP_SOCK_FIELD(FIELD_SIZE, FIELD_OFFSET) so it can=0A=
be reused for fields that are not direct struct members.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 net/core/filter.c | 19 ++++++++++++-------=0A=
 1 file changed, 12 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/net/core/filter.c b/net/core/filter.c=0A=
index 53ce06ed4a88..385fc3e9eb4a 100644=0A=
--- a/net/core/filter.c=0A=
+++ b/net/core/filter.c=0A=
@@ -10544,12 +10544,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_a=
ccess_type type,=0A=
 	struct bpf_insn *insn =3D insn_buf;=0A=
 	int off;=0A=
 =0A=
-/* Helper macro for adding read access to tcp_sock or sock fields. */=0A=
-#define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)			      \=0A=
+/* Helper macro for adding guarded read access to tcp_sock fields. */=0A=
+#define SOCK_OPS_LOAD_TCP_SOCK_FIELD(FIELD_SIZE, FIELD_OFFSET)		      \=0A=
 	do {								      \=0A=
 		int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG_9, jmp =3D 2;     \=0A=
-		BUILD_BUG_ON(sizeof_field(OBJ, OBJ_FIELD) >		      \=0A=
-			     sizeof_field(struct bpf_sock_ops, BPF_FIELD));   \=0A=
 		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)		      \=0A=
 			reg--;						      \=0A=
 		if (si->dst_reg =3D=3D reg || si->src_reg =3D=3D reg)		      \=0A=
@@ -10576,10 +10574,9 @@ static u32 sock_ops_convert_ctx_access(enum bpf_ac=
cess_type type,=0A=
 						struct bpf_sock_ops_kern, sk),\=0A=
 				      si->dst_reg, si->src_reg,		      \=0A=
 				      offsetof(struct bpf_sock_ops_kern, sk));\=0A=
-		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(OBJ,		      \=0A=
-						       OBJ_FIELD),	      \=0A=
+		*insn++ =3D BPF_LDX_MEM(FIELD_SIZE,			      \=0A=
 				      si->dst_reg, si->dst_reg,		      \=0A=
-				      offsetof(OBJ, OBJ_FIELD));	      \=0A=
+				      FIELD_OFFSET);			      \=0A=
 		if (si->dst_reg =3D=3D si->src_reg)	{			      \=0A=
 			*insn++ =3D BPF_JMP_A(2);				      \=0A=
 			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \=0A=
@@ -10589,6 +10586,14 @@ static u32 sock_ops_convert_ctx_access(enum bpf_ac=
cess_type type,=0A=
 		}							      \=0A=
 	} while (0)=0A=
 =0A=
+#define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)			      \=0A=
+	do {								      \=0A=
+		BUILD_BUG_ON(sizeof_field(OBJ, OBJ_FIELD) >		      \=0A=
+			     sizeof_field(struct bpf_sock_ops, BPF_FIELD));   \=0A=
+		SOCK_OPS_LOAD_TCP_SOCK_FIELD(BPF_FIELD_SIZEOF(OBJ, OBJ_FIELD),\=0A=
+					     offsetof(OBJ, OBJ_FIELD));       \=0A=
+	} while (0)=0A=
+=0A=
 #define SOCK_OPS_GET_SK()							      \=0A=
 	do {								      \=0A=
 		int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG_9, jmp =3D 1;     \=0A=
-- =0A=
2.43.0=0A=
=0A=

