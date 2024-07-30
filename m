Return-Path: <netdev+bounces-114212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A26C9417AF
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39BC285567
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2411917CE;
	Tue, 30 Jul 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="BfROseZG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E4218E02C
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355874; cv=fail; b=ZsRhEwHhSvgWpZhuZw/+b/mjKYmDRO3w0hxeIXvVarZ8Pji3qCp/BReroVhOCom+lioX2VQkoQnJw+VKofpAb7nkKpmLjkI+VZ9P8PZN7bIJJmmPMB/RF8Dwe8mSlS5gpHTI4yhQhOCWNjwadKtHcaKiCdgXgLaXIRhwaZSprhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355874; c=relaxed/simple;
	bh=uRauevvw28x06KZ5kQgsnEjO13GO6xfQeMFuh+YwA9M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vD5g1dcpSt5toPaOcLMPGEiocz0utwx4oRc74LqdTu7GLC7fmZPyptwflysJERfLW8je9yhFsxZkp1qY+jVIQVjFbOArElniCpYA2Ap9TX7EF4rgZjE91l7uy5LvKeFQKDKvLVtsIv4Wwx+ZYc12N1Q7J6F1v0SzDvEORp8B/p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=BfROseZG; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHUOAa/vuHTwKYu4At45LfmyA2muk7Rgy50P5N2Bw+Fx/ARy3/+erojcft7P8rvb95TxfupoxPe0fbE8R1Te3/K3zE9a9JHhldPdauYKP6IupzuiSLIvQzal/FHH5egXigSCzSke5QFtUyr6gU/fISgSCv7YTq7YjoznXj/Pj2GSxfgCmQy4uGlrOOBlA5gvJ3NJgvLET4OJlFCA3hP1CqhXrOU38zebiOFx1azDS/rtB+uszbMszRE03sbgnxlaONjrAp0V7vEEvRHIlVB2qOgKH5G+Tb/PufEx/X3H5pqZMrUcHevR/P+9MojMZ9ql91buQwsI9EgRA3plGDMncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70qoYuf0iV0VuAHBpmnYWsBuQDEsvsuNvJOaJuWxitI=;
 b=f+LTSi/w8E/8BYgQ9j1k/+H44aTX5nlZwhdy2UiiJcZ9Q34o3SToY/w/b3hDzqmydLENFi60AJ8UJGwT9grdoO8Q+Ib/lN5ONW2Pn2qUa14KeBl+P496JJLN8XUW4kuN7sXcO18r4TuTAIMmwEwLsWv7Pkzj/suw55CEMbPjXFL+VMeaCM43IYuKdC3t5S5EdefD1WfONPLaGDV+JFHhO287ytJp/meFyOuVgUb4h1b9Dy/YN0KcCMLnQc47GUfTS80fNUZViFTW5nPjT3/FC0Nu7FNxIECcZ4kKzOM0jaZc/js/yJzKA/8azGg0RPkFCtbvWvNiwkHPZLRjAOk0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70qoYuf0iV0VuAHBpmnYWsBuQDEsvsuNvJOaJuWxitI=;
 b=BfROseZGo/MQYbXQ98PJIOzjGHkEf++6Rviy5t0bFRpfdIb6OLrft8LhZsfizlmLEbhlwKdTcQEw9sz4zsVV7mHMa+XaOr6N/EOoN0y+81KP3++bomee5Wc8/vfM7AV0hosJ5zs90dbUp28pCKtMXQIaaVDKmVYoWIzrhnXFyzE=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by AS8P189MB2223.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:570::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 16:11:08 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 16:11:08 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kyle Swenson <kyle.swenson@est.tech>, "o.rempel@pengutronix.de"
	<o.rempel@pengutronix.de>, "kory.maincent@bootlin.com"
	<kory.maincent@bootlin.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: pse-pd: tps23881: Fix the device ID check
Thread-Topic: [PATCH net-next] net: pse-pd: tps23881: Fix the device ID check
Thread-Index: AQHa4psWZOlh+SNemkOo5ar/c6pbhg==
Date: Tue, 30 Jul 2024 16:11:08 +0000
Message-ID: <20240730161032.3616000-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|AS8P189MB2223:EE_
x-ms-office365-filtering-correlation-id: 93346159-4fc6-49de-0a02-08dcb0b23911
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?gjZ09bJw+ycbVJch4Jxv0i1XvEZMVCBcBKqjIMq/VhDz4DWZif/GED8u8S?=
 =?iso-8859-1?Q?cuOXWm1abU0NTAoIqI4CeFSfze0H3zRjVZEfVMNBoxKN7uj2SWfwKRlIHG?=
 =?iso-8859-1?Q?aZDVnP972J2xU/q3+Ut/wXUNbUzWtbep8MuXsFgKdIlJ4wCSyflC7GAFVk?=
 =?iso-8859-1?Q?t2n2xnRjdn3LCAtB23JVpL4KWdmNbLuYDIH73iaFTy2OIoCFhNDkoSW2wv?=
 =?iso-8859-1?Q?Y3M2RNFVVMPeycaGea2QsIkkfBqapomDNUpfJx8T/VoJYgX5KXJQpnsQeH?=
 =?iso-8859-1?Q?nyQVT5rw64xz2wzLZO3NufhA7wHiLNrqTJCrbUz6Ou+8Rq3lxcSX76T+rg?=
 =?iso-8859-1?Q?OpEsKSHsvQIBkHnNOQtnu6XETikh+BVbPlV+Xkom9wwQGEGx+29l1PCjOo?=
 =?iso-8859-1?Q?mEay+9YlFIbmol5S24Zq5Jr0qDyrkXdjs+20BIcE+VY79UNX6N3F9sz+i/?=
 =?iso-8859-1?Q?ls9Bc92AzDH831Zm0MP0Y/UbCkuV+vHm095pJQccMkv1YqjmT5s53T23Hm?=
 =?iso-8859-1?Q?TXgezmWtKGAOhhRRyuVLbf8UVhVGRq7g86507QW5Fc1KAxse2wZyJC2cSE?=
 =?iso-8859-1?Q?DGSK8OP3cFwozLI7dN2FqybTmJghxXTjvUgm28Z9ByFq+Sy7WmMJFo3UFD?=
 =?iso-8859-1?Q?Lj6+F3iMGX9NMGOVcUVv865UnrEoBzBVmT5mZOOkmqYO+e4xEhkwmHSi2z?=
 =?iso-8859-1?Q?yMNBPdLMpS5N2P78jkdNit9bCT/qnQmgIxgO0kpGbrLLW9pj2780KofxMi?=
 =?iso-8859-1?Q?eeThnHSlC+i3mKG4P8Yt3++r9DTtfHCE/5+ZItGoNPUZXsOItIxuuHX/J7?=
 =?iso-8859-1?Q?Bo/eho9lIetuiJAgOcHEEXqLIsTH57SZtjwD5YgixOZhw0I/Hhf4HlH89F?=
 =?iso-8859-1?Q?HFKRF5mnRmYO6pAZmOaVH8jefhi2ERMIgf4fLWLknOZI4vUfr4QbGvqw7A?=
 =?iso-8859-1?Q?JkrJfRuPDLXpT5w/gXOZgcexMpJYYUocKXiGFYwAN4+qdiWbMt+T8CYB36?=
 =?iso-8859-1?Q?/szKcFd5fZW6fz1AdKU9Llw+zAXE9CRsOiPCC4YqSure25NHd4zD7SZA4a?=
 =?iso-8859-1?Q?XiQeNhjT6E+CANPhlF+90fNsPwBjKuD2cGMBdiIN5o7iNCNq+bQ4nDVc01?=
 =?iso-8859-1?Q?R/WBBUqmaMuxBqBrLCvGgpCYEjoUho/hAEBv6Tp65XHLj1Hu7ktWdc+eRE?=
 =?iso-8859-1?Q?KxFl9kVJYysdM9rCc/3nEf5fUfhDq/TIH2a4LNkCvaOrVMlX1DwJTMmj4d?=
 =?iso-8859-1?Q?malVTLz3ZIOLRPcDjT8UWrHwxe5ZrOj7Cv1JWNtVv6rVijNJ7NEl5PAXTw?=
 =?iso-8859-1?Q?F8odXxWFe6inQxrPAqy/RtKCvGKZwdiHTCk2QthNQgwaLi35kK2EBEMTq9?=
 =?iso-8859-1?Q?X8iBe5RjlYQtQVx/fzqbhsUUNROl+zhSbYrM25BA8z9rLmwef38VurVUrd?=
 =?iso-8859-1?Q?owSkAg4NAzRTuqVHW0wJoOorNP5/9cS+mKn64w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+CpKVINOcNgvHJ2oQ7qXbQjFarMdb7pIMGkGPBJRBXxv3C1E2PFDalKL4C?=
 =?iso-8859-1?Q?VbckyXsme+B/XHCQXy1AwOnW38tkkRdAPqwyOJSbGtE5G4aPO2afG6MQ+q?=
 =?iso-8859-1?Q?xAA2aMIpXG1IIM+kF667iroiDBTa8pA+qtxBjHt/Ee0bw6Rq8ZPYL/csei?=
 =?iso-8859-1?Q?81eRMgQ1WjyBsVDXvbtA3uMRA8Uxj3kPJyvTYSSC3s0ZiGcY4jexjiLQ9j?=
 =?iso-8859-1?Q?ekhFT4ASgBQWPe6yoIs1SvEJJCCe6eLUeJ5uvRlgJIVGyxnKOgIzQVwFlD?=
 =?iso-8859-1?Q?nkDPwrmSAdvTz/9bc5MjfiKzMgVl/aNG4VfnuVcqV1YERuyE0PPJXMPxio?=
 =?iso-8859-1?Q?ctLnoWaXyOBxvuDQi4yQRfKkI+0aLd/oFt+VrB69X8TlAyUpRO+8/FM06G?=
 =?iso-8859-1?Q?SBeCGbJzqj3An81qsG7UaXl8/KrlxkTWlTrzvSPOFNtQfXI8Mi+pULPrcm?=
 =?iso-8859-1?Q?LcxKvZaBzkNobhE+mWo5G5+6TVn0gnsJPNM09tPCDSfKCocSYf1D9r4Nmx?=
 =?iso-8859-1?Q?SmcU3wfdJnz3NkbnaVQurdXKUYRoxm8u9zda/+kyPiXHQAbtrvWiWF2HGw?=
 =?iso-8859-1?Q?bJwClWclRwsV4N6LuN+XWN2UO2zWDouHKkVSR3UfHZGBxE6KJP8SaFUl7E?=
 =?iso-8859-1?Q?oww5JF+iIWKA67w+jn0hqFfKzice4VUcVvkFIc5iDNr16VVuFEvjVqlqUX?=
 =?iso-8859-1?Q?EFCmtxjiHBglvb4mLk/8f8gUHBY2kGyt4xx9GBxggQy87C7bWYDUUAa6IV?=
 =?iso-8859-1?Q?8iT2fSuCm/SgpPD0Z54jFS5SoCtfvu3VSFSt31LiM9NoTwM25xM1BP9RAj?=
 =?iso-8859-1?Q?dVuBSwNqgzNj/evL1TjxRMkHkFQPSzkx2qhCG/0M+9gHFYUeUN2vAY22rv?=
 =?iso-8859-1?Q?LvbN+NzdmKivCy6MDrRMvUWsZh3Fd6oP7RCkKsATSeRQxaYQiSmKanD9GD?=
 =?iso-8859-1?Q?gxEYWnaNEAcgCKQTEQJhhuMbyr0z2rYgM+BjvO6bfFMfpremjMjAgfDvuf?=
 =?iso-8859-1?Q?9jeJ+h985GLnM1eYvTp3BQGPDACxtBTxp+NMX4pxqbo52OFsh+VbT8YdYw?=
 =?iso-8859-1?Q?GGHgTRgwBu9bXsFc9bQLeFCgfyV2kRDGbuL37gTWiJaMIa/JgnyvC4uYMJ?=
 =?iso-8859-1?Q?tyQcyXIkBF6KZkK7XiVixFAeUNearab83lppjvqO6hGg+IvXm5yINoQA6+?=
 =?iso-8859-1?Q?/q8bYkUcZuxvS8DHe3pgQojrEEdf/Sna+5TY6Tg8N8yO+JsqvWR2X7EGue?=
 =?iso-8859-1?Q?d+extnjTUB+jcRNiIpfLbh5L9ANHGA0nxuJOE9pj5a/MD35iwgdp1KTk8q?=
 =?iso-8859-1?Q?ofFGTcOSxhwPDljjSepRIaDgEcqBCxG+MmGkmaSH77WdeBKczDuFGuHjN3?=
 =?iso-8859-1?Q?pgQreQcQY2aGO83la7owTeH9OZkNFkLRkFX0qKW0jRFEIhSatQHJOoAx5R?=
 =?iso-8859-1?Q?Y6hNFmjowynMCUNolyxvjS8Ng8UNOtSOKgheQgZRXaGkMpvqmv6k6sXfUm?=
 =?iso-8859-1?Q?z6v1GzlHoebeegputeHJV8N0s+G+kIWEyJGBaAPcWGmDrUvWAKyj26hyQV?=
 =?iso-8859-1?Q?bUkLnl21WnxclEAXTtFBkbQiP8FwUP8YVIVu7+KUN3R9Yd1eZTI5ks2MXK?=
 =?iso-8859-1?Q?LWvkM52JHVgj83AA966fh5pVoJHhIAsRCu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93346159-4fc6-49de-0a02-08dcb0b23911
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 16:11:08.7333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zScKow6pqlrPdShJe2ztcoPXuw7clxFuCosAsv5gjnj49CoWc2S2g2eLznovA8tN858ThO4uVQHkyz2Rh1u4Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2223

The DEVID register contains two pieces of information: the device ID in
the upper nibble, and the silicon revision number in the lower nibble.
The driver should work fine with any silicon revision, so let's mask
that out in the device ID check.

Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
---
 drivers/net/pse-pd/tps23881.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 61f6ad9c1934..bff8402fb382 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -748,11 +748,11 @@ static int tps23881_i2c_probe(struct i2c_client *clie=
nt)
=20
 	ret =3D i2c_smbus_read_byte_data(client, TPS23881_REG_DEVID);
 	if (ret < 0)
 		return ret;
=20
-	if (ret !=3D 0x22) {
+	if ((ret & 0xF0) !=3D 0x20) {
 		dev_err(dev, "Wrong device ID\n");
 		return -ENXIO;
 	}
=20
 	ret =3D tps23881_flash_sram_fw(client);
--=20
2.43.0

