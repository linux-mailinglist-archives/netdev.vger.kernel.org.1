Return-Path: <netdev+bounces-119859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C86957414
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877581C2158F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF971D54F6;
	Mon, 19 Aug 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="iPinE0s0"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11011D54E9;
	Mon, 19 Aug 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094141; cv=fail; b=ShfwzO8BtUUB6jjpfoTrx5s03b+7FVRwNRjStFoaeQFNhLx4DLiih7VnPwWTOieq7wZBi2bqW+Q8or3fexg4YxIOBE0DaMdEIV8MH0r8IZu/dQj+jnHnXpqvokhj36DXi9CwrvLru0NDQct31EFx6UAfYuLut3j2cV3iMjlsJaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094141; c=relaxed/simple;
	bh=Lh99dE4MK8U55sy1Iust28fVOYrjw54Ue/MjH+6sC+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hzo4RibdScwMx4OY6xskmoguM6ULKymZoC72SkkOQICxgt1LUH5i2iBBuF6MaXoIEml/nzLZ/WlhX1nMe9nQUpUaqFfpj/9ZrMoguyRIKPNxHSoMRGz07JlHaofn4YbxgzuVl425k39fMqnmhkpZ/6El6VSxMuAhSen3XYIHOp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=iPinE0s0; arc=fail smtp.client-ip=40.107.241.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wf+SDKvE/0Y0V/hOxB/LNkv+6rbBPlWfiy1ZT8dq083rmyMkd90Vyq2HxTr96O0afNLqlAJLMhOmMsfc4lCCTBvU+Elx+QTe7tqU8iyqEyxbmT8aYNrBSqPByzVIhVKcu0i8JVtgexUVUWxIXOkkKwICtCqnNe26FgSKfliVvXRQwK2rIYKTKNmexiB+FpK4wRJ7sbcPb25fbCTvyaG2SSlJegCrslupRoyJljvh0EY83iDV19w4zcvFziquy9tDXDOWOn2us8EhDrq65MmcAk3YuFNSftipwzJAfbyzthMABWaHQMedXfTyESAXSEqxxbqHgyIBU4VwA1oXSAsWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8t2sOhK/EgDhEkXkg2zr5OGqh/T7EjbB1FiXqhlo5g=;
 b=Xt7lYL7De/lnwrHiAo/UsAR7GHIQXN59Ccj20/VeavaRSBCBvrfkNAw6dD9UCDNYrtd67DSViwX+W+XvSxkybWY/+VvEA3T0Z7r5P+T7CVoGSNWt5vEKfW4U99XK7QlpdKchNKfdcFotecUvLv9pwhxVFgzNa6lBH1/IRurU7vZMyJKCk30/v7vogCmMW9GkTChYp1a4HxqXt4CrQthpus3TbuCS58RQayalLwg+42g8FKR6hW4rIInNfucJDsEDruk9wsM3946kasCigbGbYvKALJ4oe3kWD6IeJoy4WG8Ja5bS+AeCfxeONYiwYVhTK2rI9mw1SGz8J51RXlrbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8t2sOhK/EgDhEkXkg2zr5OGqh/T7EjbB1FiXqhlo5g=;
 b=iPinE0s0EWzvpJNPYldPGZTPo6O49UDydiUmny/eRH71FkduwAECiBW/ewMBfhlZJAKzKRq46VDFXMT450vNcGJCvVJp8Mn/Pz4ZtEdHuxkFl5CvUTVpCFts4zdKYzsR9Lu4FV5cMAG4tOModG/rGSB3Jv/b1X6A85xg2eEy1+E=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by DB8P189MB1109.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:02:14 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 19:02:14 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>, Kyle
 Swenson <kyle.swenson@est.tech>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: [PATCH net-next 2/2] net: pse-pd: tps23881: support reset-gpios
Thread-Topic: [PATCH net-next 2/2] net: pse-pd: tps23881: support reset-gpios
Thread-Index: AQHa8mpN+TA+JG1k4E2yihVubvKI7Q==
Date: Mon, 19 Aug 2024 19:02:14 +0000
Message-ID: <20240819190151.93253-3-kyle.swenson@est.tech>
References: <20240819190151.93253-1-kyle.swenson@est.tech>
In-Reply-To: <20240819190151.93253-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|DB8P189MB1109:EE_
x-ms-office365-filtering-correlation-id: 29be2183-15ac-4292-1c9a-08dcc0817053
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?utXGLsqaXHlXA8EzAkzz9O79XYjXPaTnu7C7ZZ5NlvFbKtkRRl8xirRb2p?=
 =?iso-8859-1?Q?NpEEzfke+d/0AafpaoKnj8dvNHIvn0b6CMsDgZyvN2f7+N041PFN2bk2He?=
 =?iso-8859-1?Q?2g5G6mEF+DIvJI5eZdbRoXOZ+A/Upd29IP8qzi0snijh9UzhMDXF7IXBn+?=
 =?iso-8859-1?Q?OCP4EgUbRy/0MwktIab3omTBWv1EMr5ptEzgF0lav4Eg/kowvYixw7kYjF?=
 =?iso-8859-1?Q?fF7ZUO0HiBajtqcuAehOk1sEfgQzLp/1jroVsmddKUHaSxCxAmLPq/WuGg?=
 =?iso-8859-1?Q?Ysa2POG+AOfdBoLu8zZ7HWPzonYGcyq0TtNK/Rc2ZR7Nrsu6/70bZlOzvB?=
 =?iso-8859-1?Q?rzflZ6gPoRMF4duwqs5lNS29KTpwugPtjf5mqv24jDsnYHeHukyrgIjRRU?=
 =?iso-8859-1?Q?ccRdM00q7Bn4DZgEmzC+gw2uAlgqa4LnPe5aVbSB7mKfc7k8xFZo22x176?=
 =?iso-8859-1?Q?MjGTxo999OXK1ffDtoX1FZ0rFa4X8JHo79kryd7aSH6fJfjBI7MDhobYrO?=
 =?iso-8859-1?Q?IInzEvPpsHZEQhqPE364Tzzf8dfDcRCWBfCEPAqFiqvlT0iMXkAeZiMYOS?=
 =?iso-8859-1?Q?0lflaMMTuYRB4buKk3i6RS+Lm+QIucJvG+RvQG0re1GpZy5XPaNMEd/YYY?=
 =?iso-8859-1?Q?eUX/ezfD6cw4dM1ZA+PmqPCMnGtBWQnEWj4vCgdNHs38W+neHteOQAPBOi?=
 =?iso-8859-1?Q?+adfa6M3mWiNUuojCNgZsxEc8IwE38V8bpYEcwcFv9CbLF3dh/s8H68d3s?=
 =?iso-8859-1?Q?SF6uj0uEZsnN3M/S//y82atQfNmTnROUyvH5rXCrtBce450kzaUF2EU779?=
 =?iso-8859-1?Q?yQkjzhWhLxfaANj+RULhmP48O5krf0J7DCdgkzB9TGgkvsT//OTKWr4AwY?=
 =?iso-8859-1?Q?RBvjzIadSa0DXdAAbLoLthY4g7obpiD9FNeiYYa5wVSlvmoipPSrtD3wPw?=
 =?iso-8859-1?Q?45HgwxOSyOk59rTY2CP5RbjuoGLj/epi+jWcPzQx3ryuGB9a8ahu+8NkXb?=
 =?iso-8859-1?Q?+k4puyFUas5j8SM43clKz3leJXym4zpGBxSWoRFnxRTmtHeBAUwKqARkZh?=
 =?iso-8859-1?Q?CgiYH4Ax7BLdiu+RFZMb0XQfP/I1nWkeGNWVy9uk08+rc3Q9xZm27mXPVc?=
 =?iso-8859-1?Q?9hpXIoPkvwIMlNN84W2dSne3/r/ZAlb/7lMwOcMnu2l+Yvo4Z554NciPY1?=
 =?iso-8859-1?Q?vw0qLGAd5ZgeZF/MQtOJYNJLtz49br1k1hBxcu/Uj7cy9yRJQANLdOE9Po?=
 =?iso-8859-1?Q?Xdx+3Xishv2RTqYA3nmNi/E9KzXbjVcewTZ1/QaMRlIsUP8+BzUjrS2wuU?=
 =?iso-8859-1?Q?Df+qdygFyz0+YHTDGOCH43/4WPAvhBXS+8WgJlnqmXFT9i6IfEx6d7FANN?=
 =?iso-8859-1?Q?BOtso0uiAYvB15LzTkV0FXDq64/eMhBRJmP/xU0bj/JvGypHqzFZgM/rxP?=
 =?iso-8859-1?Q?Yv8WaD9WdwnaANQV/12snJOqFy7+a57ryD2jYA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+yE7kEiCWubG/HuibjQuE7CQXOXGYT7vcq5QnYy5zPfKjo2K5eEKvnxvmS?=
 =?iso-8859-1?Q?Vo1lYRIfMGYFBunxuWBnHz083ouaQJ56RnIUW2GohDu8RrSVmcuqHVWT+N?=
 =?iso-8859-1?Q?nZiAwMYm9Xj2jhGXURMkqXKb8INpSyp6gUHvCRX5BKjy3Oz4WQlLXFJrXC?=
 =?iso-8859-1?Q?LsvQSS3Go42oObOlacYssfsHRdzqTgn2W0YL/ov/DagdeLlE7NMEKNfDSq?=
 =?iso-8859-1?Q?jWmMnH3RQGjUK1oEJ3fH61px+LqWk6aCdCppjjtl4r82ts6OrIUV4xzRfD?=
 =?iso-8859-1?Q?3d8obqS7efMtOMM3b0n/ek2w2zbeh4+jke979aWuIAa7GMAEDaCZBNtD9q?=
 =?iso-8859-1?Q?0dT6mhkpv1hopH6aV+Q01cSMiBVActEViy+O+s7gqqpx/pZeEp9QntJexj?=
 =?iso-8859-1?Q?bxdt17Y+WP66IGBFC7AxuJaQuWUU6nhfjmdKt9ITvuvsu6UqS1I5VM05FC?=
 =?iso-8859-1?Q?SxAulwlJxSTxm3lt0NIzQPE8jyOl4TBF4sx4xI82ZfZN3OxxuRm4AerBEB?=
 =?iso-8859-1?Q?E2sK+Dh2gniaHxWZHXY7xNCaraWmgGejW0Jux/rKiKR/XRj1l23ajHtYh6?=
 =?iso-8859-1?Q?DljEiwIdAQxAXe+4i6F0YpsVvqzoEkzHuN6TW3e60IvNxgO362qP5sNhJR?=
 =?iso-8859-1?Q?6KIdXRsAm3At5qumWTsCiZDF/N9kXEQDYB7G6FpW7txNT7CCoDSBhs9VId?=
 =?iso-8859-1?Q?OqzEXGkYKBaaLhzfuZvevLqaViBGB2G6fY024lJrBJxwgmhiWQqNGFaJqH?=
 =?iso-8859-1?Q?dFEALziAv04VwGUN91LnY/XnZwv8nKw0M5eFNkgl+3DpybNud5a6F5mahp?=
 =?iso-8859-1?Q?VOGuWwoS22C6DAAR5Yb0fs8D3rqVPKp07gunRut/0TIHbY8IbE5ZAWvEgP?=
 =?iso-8859-1?Q?st9UHwLxolobGSFN/yB+QFo6M7YNkTnOcgGelE9III39ajuHxrNfbJclvJ?=
 =?iso-8859-1?Q?klZasanyTZaUR92iVePGHVcwmzM4o5B17sbuycsmi2RQHeb6MV7v7aNhi9?=
 =?iso-8859-1?Q?Lsg9pMm5pVjten3kasQDEn7QaCKsoEeo00LEm78sdVQQV7fm427ay9RwhM?=
 =?iso-8859-1?Q?OFtjoZMEUoiIJDa9+Vx1PsqlvLTnDoR9Rjht8KBwE7ASg9uOuOFn/kQub1?=
 =?iso-8859-1?Q?kQa+buUBLSon/mfJrCwsw7pVMPvgkapZu2k9pnPtwBkfeCdJxbTfLk4/3A?=
 =?iso-8859-1?Q?cSD7W/VnuXDcpFcXzRhll5yc3XJ9zE4DOL0puG99waVVB0UOrbgTw8TP6r?=
 =?iso-8859-1?Q?6CYOc7dybW0eHzoWuZ9svU8uRZByT7JlqVX44WfH0EQgkLE/E7TWLCiAX4?=
 =?iso-8859-1?Q?pmtH0Y0P3JFdNjMK2S23SYFiEXvXxHvK7m82fXFDKkMfzXzvzmCTnjjj40?=
 =?iso-8859-1?Q?Oqv72ENIzsTRh4AkD7llgKKXs0il8p7CdY6KBAxN/KQo7VJzdSotHn88pG?=
 =?iso-8859-1?Q?42MHngRYt+pQnO3/ZYIIzd9ylFKQzOssB5Gs1/+7lcgK2SH5lrN5gxl8Zg?=
 =?iso-8859-1?Q?V2WDh/UPjnDmZCprLJGJ9Zi6ieAYFhQ4511mdE54z6HYI+5ZuYVwnalRn3?=
 =?iso-8859-1?Q?z2YvwXoeDbgOUFXAqaiO3eFYC2nBoqJ6a6RrNpKBBUsBvCDzY1hOYNlKO0?=
 =?iso-8859-1?Q?0mHq7hPA4mRG5rKvLhjPWKNIKOVaw6nSstYcdGbem0AChTjFGqmH5VJQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29be2183-15ac-4292-1c9a-08dcc0817053
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 19:02:14.7426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZY+wTDM4zDXg+jhTttNq9dEtP5b5wNLR0h3Wf/y2Th0TqhCxKUwr7f40lEtO284VgvArxCzC4xsnoPpNYLDDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB1109

The TPS23880/1 has an active-low reset pin that some boards connect to
the SoC to control when the TPS23880 is pulled out of reset.

Add support for this via a reset-gpios property in the DTS.

Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
---
 drivers/net/pse-pd/tps23881.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 2ea75686a319..837e1a2119ee 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -6,16 +6,16 @@
  */
=20
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pse-pd/pse.h>
-
 #define TPS23881_MAX_CHANS 8
=20
 #define TPS23881_REG_PW_STATUS	0x10
 #define TPS23881_REG_OP_MODE	0x12
 #define TPS23881_OP_MODE_SEMIAUTO	0xaaaa
@@ -735,10 +735,11 @@ static int tps23881_flash_sram_fw(struct i2c_client *=
client)
=20
 static int tps23881_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev =3D &client->dev;
 	struct tps23881_priv *priv;
+	struct gpio_desc *reset;
 	int ret;
 	u8 val;
=20
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_err(dev, "i2c check functionality failed\n");
@@ -747,10 +748,20 @@ static int tps23881_i2c_probe(struct i2c_client *clie=
nt)
=20
 	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
=20
+	reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset))
+		return dev_err_probe(&client->dev, PTR_ERR(reset), "Failed to get reset =
GPIO\n");
+
+	if (reset) {
+		usleep_range(1000, 10000);
+		gpiod_set_value_cansleep(reset, 0); /* De-assert reset */
+		usleep_range(1000, 10000);
+	}
+
 	ret =3D i2c_smbus_read_byte_data(client, TPS23881_REG_DEVID);
 	if (ret < 0)
 		return ret;
=20
 	if (FIELD_GET(TPS23881_REG_DEVID_MASK, ret) !=3D TPS23881_DEVICE_ID) {
--=20
2.43.0

