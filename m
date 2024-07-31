Return-Path: <netdev+bounces-114621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC9943387
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB471C21C70
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91F31B581F;
	Wed, 31 Jul 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="gjOXMfYU"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8395A10B
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440539; cv=fail; b=NzGskyhqL+ojVBXPPcdubFNg3MoItIxMlxy3j40RWjX0VmC1J8FDA3mXXpRIzy6LI6YqVIvC+rRE+6ay8J0XHVUJr/Nu1MMHXjvfu6YQxKh3YbYrPiGqA0acCV12tTQGlQIkGWP5nBi5AlfY+bxTId+MoOfpYyPNVuhFHhfJWxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440539; c=relaxed/simple;
	bh=g/SVlgtoIuaXN2MpC+bagRCGxTs4hJ4BQG2Sf7B8yIE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NxjZHgsp4slkMX+YTpduaAesVJPr4RiV5DDGXaELO11XPerw/3tpEOgcFWf6ClsuXUkstcvcBxywMVusjSCmRQjW92em4h+1uPfvy8XoCucMbyfmzHZu4dTSmwPTtbDmb0NdEcnBb8Q/Rf64JS8GZlD31MQkqd91XtomYRiRCFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=gjOXMfYU; arc=fail smtp.client-ip=40.107.249.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpHO5kXPdcDbmF1ZWSzjV0s8dwZcDykjOnnBQlrhI8+s8xxBo+FMEx+Z5vQ3WgP0RYXPujm5CLzDScCk+YxwpiYG0FjRlvlnuDuey59TsWsuT2Ev3Iv+6aVo88sl/uzWM8/p7GrPF7uIO5sZwFYqv4KgAlhckezUrCmTgwmygsNYiLRl8gzCLfjQ6qI52hjeAyixPkvpTCWhzkK5zYaXmH7U+BQqBZBF3G+DzA7MLFJJ5drWLZGh6z9QoJ3EiUSPyujvVb+UXJNq3Uq5a/k1nDtErmnACFDPmwEBFV0P7IcaF8WPCbN27B8H/cZpCjg/GzzNXp8HMBo0s3H7N/Usng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvb2UmC2pZEnHxgwRvf20uQ5lSj5/+q6IhiqTSSqB1E=;
 b=f1gbQqnhO+KiH5nKhxC6UkVP/AegL1BHgOjrnxtItX9diB4Y6sr/rQO9WnH2zIm5Rxq4pgy/UCMdLoqRfN17bpw7Y14N5tvQImEUeqGKhHXoz58MZ1qrh3Itsk5xE7gGczqr9afAZi8kDAAHUT86JYoQmcqPrPhgFlKcBxySU2TjEGA2RmzR6yd2pE7sl8+IiqTLm23YolEgCNnP7bh0+IouRzs/7rig4zZjrdE1YTUNgpeA8HxmSAE8JBlcF9nX56vFCHvOIgKvzm/moBtxYnOTsUHe8yMVvBHg7DVyCM9TuHarSoI7lj+d5CdcIjcBGntzdSTtamxLvcftjp1Vtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvb2UmC2pZEnHxgwRvf20uQ5lSj5/+q6IhiqTSSqB1E=;
 b=gjOXMfYUbUT99J0f578W8kvcJevS4i64L8bbt7A91k52WXLPMzkvgseqCSoh3F1j7h7Oc6johGujKfJgydcLEsNT8lVijrh2JPCwhKjArnZXso4sfhn73B6k531++u3JX9DQjGdP0suxPEn/cMXEALrydL1duFaz+sG7N+Y6eZE=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by PA1P189MB2693.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:452::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 15:42:14 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7849.002; Wed, 31 Jul 2024
 15:42:14 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kyle Swenson <kyle.swenson@est.tech>, "o.rempel@pengutronix.de"
	<o.rempel@pengutronix.de>, "kory.maincent@bootlin.com"
	<kory.maincent@bootlin.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH net-next v2] net: pse-pd: tps23881: Fix the device ID check
Thread-Topic: [PATCH net-next v2] net: pse-pd: tps23881: Fix the device ID
 check
Thread-Index: AQHa42A3SArVdM7xfUK5bqVOsDUdiA==
Date: Wed, 31 Jul 2024 15:42:14 +0000
Message-ID: <20240731154152.4020668-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|PA1P189MB2693:EE_
x-ms-office365-filtering-correlation-id: 2bc50540-5abf-43d1-5c0d-08dcb1775a01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XbRf86OgEtlE8L3Q9Vs8Y/3jfWFFZjDtf1A4XQNJyX7zmprVMoQF4aRYzd?=
 =?iso-8859-1?Q?WXxPK/Rm/J8jehWOKF1aIpXj7Gi5E4+CVpsDA+b5j0/HmlwBByRhf55ZPj?=
 =?iso-8859-1?Q?fpbqVMM4uu8uVoKNuTka1KdbyCYr9eDbx/fvV4wKJWEoUSo3rNrWG3Rcf3?=
 =?iso-8859-1?Q?wlNPspsZJHTpcXEcHM4PLtkHuO439YlcbaL2zH3BkN9kdJysippVRnn501?=
 =?iso-8859-1?Q?XZp5+UhAuox60zJWxNaiYlHnzTai2bQUNAwQ/SNNd90mF9tGDOyPvQZQ2Z?=
 =?iso-8859-1?Q?mAeKBbinGAleidNGvoCBu5aG2zhH8azmfTy1IfrbMjAzq02ADe819dcH9p?=
 =?iso-8859-1?Q?N1jjPOdnU4VNZ3zC7+LNiwdeSu+Q6BYWhzqV7FF4y5J+k83u+bcDk/Ti/f?=
 =?iso-8859-1?Q?Acq2sq2DRvoJ+WSIn8QLi6Oy1arw2t+0SVUR1pTRORO7DBSZm3+Ja7BAJs?=
 =?iso-8859-1?Q?7/2hMRmsOgJ+jqOuT4NGlawmLGEX5SWTRdEvIhhvjv1AlEZALp0QV1O6ub?=
 =?iso-8859-1?Q?aWvr1NrL/zYZeQCZFfOoUq0fZf/uYCHC0G1CSURWG+XrTH5iP+n2OmD9NX?=
 =?iso-8859-1?Q?N6Imrf46zxgO8/9+4mQLB6+zPRdlfv/CpsjnvGeQwH2pvPLNuwTRrdEbLO?=
 =?iso-8859-1?Q?pH2HiXHmT0dp2olhbqmtc3KsqkHuWUztgQn6WuTGBP/j3VvjnUOpQbG6+/?=
 =?iso-8859-1?Q?1Cy1c6t/MGE7MrHj2an1xn5cL4SzGc09/Vk7XMHYHcd/vZOC4i16TxxLTw?=
 =?iso-8859-1?Q?Zoh54K9a3CM3KXxw3OTYaGnFzp5eUQLbT1xTIiivU4QjznUKan362iP4X5?=
 =?iso-8859-1?Q?GJJt2Pi3aljSCY9dJnMBe5H+iQi8e32JJWt5wY98g62frFLxLt37hv6zSA?=
 =?iso-8859-1?Q?7JHBEDWeXMDqTPBYdj3DSGiSFYHp9r1Fi/0ZpXaz6rVhaSHnKfhIaSNZdk?=
 =?iso-8859-1?Q?boDwrdeE09f0p5j5JhctbJU6x3J03EOq6K8LhbLssvroO7y2MdgzufhmEK?=
 =?iso-8859-1?Q?rF1NSykuc4w1I21LUAlvZ4SeTVGVk1gOHgHVoBm3lxuqv8pNv87bQaNLh1?=
 =?iso-8859-1?Q?4onLNj4PpX1iFB204SJStTlSwd3t25YhgrCu4GSeuSgmigS4lz/TgBNz9I?=
 =?iso-8859-1?Q?nZCNrA7yHRPB0nSxdEGlQ1zMbcm9jAPQrGbEb6X0ADIUWuBN744c+iS56m?=
 =?iso-8859-1?Q?xfakbHibXcgVqRVxiDE/OlWiln+fXNV9x3gWmmyH+T2yHxUZhJPGOeqvZS?=
 =?iso-8859-1?Q?HULX34Zux9fOvgTiNjOk8yNNYH6aGTaOF99XkuBWhibE2B4LTOr+PHleV1?=
 =?iso-8859-1?Q?qvqrL3Du+jAFPkDIYZDhOeMH6uDareBxEB9qnmvhXUQwBtNtl74byLvfs2?=
 =?iso-8859-1?Q?/wFM5kIlYHIJJ5Hg8UBIdhD8Rj4lLTRjKFcibajaQqzHcMWB3nEWU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TKSG19vHa0l4DTE3AVXXZ+h0Ujkk3sZ9s7/mLkl91A8LvYHqi8kh9kp0BP?=
 =?iso-8859-1?Q?2ofAdhdijWdWqHJw985NNJCaQWNlNXrULXT9BU6mSiK5iGrcA62go0N9m0?=
 =?iso-8859-1?Q?jz6Mxe83oCB/XWqeO0uJj3kzyoNHKTUEDBDhWqIi8vxWWtpFRHfhDvoOqa?=
 =?iso-8859-1?Q?PaMuj/I+UA9bf+lVXNkTq52JQjH3Ok5YgQEqMVZTw3/jM/gxsEaW8zxg5v?=
 =?iso-8859-1?Q?ZN7ymtR1ukWnvzgXYJmdFE2xyaNNP1SITjLbR4cf+1+VUC9lNbZmlEtWfC?=
 =?iso-8859-1?Q?7rI0HWNfNZYLMMPJ1l/cetfn3FqIUrXpERD/2ofR7HMqxAJNcNSPAAyb3d?=
 =?iso-8859-1?Q?pTJuD7HHKt7TL5Pjbotc9FhclI62lAhXfl4iuuf7LwqUQrMidiHKqrGfBh?=
 =?iso-8859-1?Q?K3jiGMvpfraYxhCzJic1roYtTd1r12LYGvthIp+NROZrpUPiCEWIPl4RKS?=
 =?iso-8859-1?Q?yoSyWXiupfYnLAfDjPzP3dl8bHhecq38Dh3R8+m2MKgDdwAduKsDjl2aZX?=
 =?iso-8859-1?Q?I7rIRHpV/IJZXIAxth/bEPqZ040b9kk3H2hiuDWz2gSWWu2nI+DwgW1x3d?=
 =?iso-8859-1?Q?fJrBf1nliur7OUbODNF5kuzPVGOmLWzpBcPZ2hjQDAG1khDYQ1asdBEhU0?=
 =?iso-8859-1?Q?WJzpgvtRRoDfJUClDAefG/od6BYQZsGFr4cHW/2u3/py9p+4ynV54KiVpn?=
 =?iso-8859-1?Q?Gg+LslvGXt7iXEgX3NT47sgEsPCkbPety3mjn19rVI+GsYpj5mbM1Xer3w?=
 =?iso-8859-1?Q?ozwAe+7Qjhy9a2ZfCUzMH2AWQ+EFy4Wr4fpzPeGVBEyw/CdsW3iPn6M15L?=
 =?iso-8859-1?Q?7ZXoF1HDBvUyvOkwH1ZLog7OLbnDJYqbUCOoxfGQQ0doJ3V50nfDe3+AG2?=
 =?iso-8859-1?Q?ku/KaJ8COjOw4gC7y538klGth5i46lNQKpM3PiuNUO3332ntr6urUjX1oI?=
 =?iso-8859-1?Q?uPBE/Wt8Di5qs8j98t2Udo0b23kZxXPHKoJ/8eSw8DO3Z68UR5IbRhXwqI?=
 =?iso-8859-1?Q?co3/tpfpHyP6hq4KH3C4urIGIXxM/l6kVm3v8eYfHwyjhi4H1BMEHUiy/A?=
 =?iso-8859-1?Q?mcXgh+3t0eIdN8CvGuL+Rb2IGXQVLoKAelG7KQath0jNRJHHH5ibIPJRm+?=
 =?iso-8859-1?Q?aSZt4340yfG6ySgir0RKiEFvIaClqxypJlRkg1/XUPFUQWc8lXbz4tGbOc?=
 =?iso-8859-1?Q?P08PxooqXGSbYtXm+FxjiYuX+Zq6khvq00rPQYmT/368rHZSRAtjyANxHk?=
 =?iso-8859-1?Q?jL0oE0RWl6xDy5RbxQaUuFD5b6Rfn7K4BONpE37/fX7rAoxow3auAmVfVZ?=
 =?iso-8859-1?Q?/FMyhbVebEXjtYCClsKewbMa6y/l4e+CyRze5xY9C0C/VLhD0QNfYUnL+D?=
 =?iso-8859-1?Q?6uC7odzgnVDzDqhC25mRMoRizEUISwLa5l+ad/I8HK09o0Kj8jt6kvK/DY?=
 =?iso-8859-1?Q?Ipnb4SIp69UYNqrWkg3/6kQipLk4nZlimo55tPLR0QUyUOSG/5+gAZ7Fyl?=
 =?iso-8859-1?Q?keEkVKInHwpC4LVVrPAaX7Gz9hOLnlrjNgu6d6wUquhD7NmiOXamSpMuaL?=
 =?iso-8859-1?Q?78imfSW/n3plcX08WMGc7rIqpys2OX2yK2MdxOkGltRVK9wbATrQmuhLpz?=
 =?iso-8859-1?Q?CN1XX/0WCaAZkaJ/pyPe/+hGD4JMy3a1wZBGod3TRIJGxADjK3uFS+hA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc50540-5abf-43d1-5c0d-08dcb1775a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 15:42:14.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QaJE0JA0JjxwwkdFFXs9agwT1uidR9UKrEZAzIJKDmxQunz7tKXbou8CLQ0KsLnugAXwNsxeo01tu2LePX9hCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB2693

The DEVID register contains two pieces of information: the device ID in
the upper nibble, and the silicon revision number in the lower nibble.
The driver should work fine with any silicon revision, so let's mask
that out in the device ID check.

Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
---
v2:
 - Use FIELD_GET and defines instead of raw numbers

v1: https://lore.kernel.org/netdev/20240730161032.3616000-1-kyle.swenson@es=
t.tech/

 drivers/net/pse-pd/tps23881.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 61f6ad9c1934..f90db758554b 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -27,10 +27,12 @@
 #define TPS23881_REG_PORT_POWER	0x29
 #define TPS23881_REG_POEPLUS	0x40
 #define TPS23881_REG_TPON	BIT(0)
 #define TPS23881_REG_FWREV	0x41
 #define TPS23881_REG_DEVID	0x43
+#define TPS23881_REG_DEVID_MASK	0xF0
+#define TPS23881_DEVICE_ID	0x02
 #define TPS23881_REG_SRAM_CTRL	0x60
 #define TPS23881_REG_SRAM_DATA	0x61
=20
 struct tps23881_port_desc {
 	u8 chan[2];
@@ -748,11 +750,11 @@ static int tps23881_i2c_probe(struct i2c_client *clie=
nt)
=20
 	ret =3D i2c_smbus_read_byte_data(client, TPS23881_REG_DEVID);
 	if (ret < 0)
 		return ret;
=20
-	if (ret !=3D 0x22) {
+	if (FIELD_GET(TPS23881_REG_DEVID_MASK, ret) !=3D TPS23881_DEVICE_ID) {
 		dev_err(dev, "Wrong device ID\n");
 		return -ENXIO;
 	}
=20
 	ret =3D tps23881_flash_sram_fw(client);
--=20
2.43.0

