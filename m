Return-Path: <netdev+bounces-194854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D658ACD023
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 01:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93C7175F22
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 23:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64861DE4CA;
	Tue,  3 Jun 2025 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="k+WmjMum"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2068.outbound.protection.outlook.com [40.107.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C123506E;
	Tue,  3 Jun 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748991887; cv=fail; b=pMRD6kEbaDonq6zDTRLtfrAkJYkwXtPVDP80m80uNcT+Z0eFlRfBt8c7uKq2Z8EoF2HltHaZUUjt8JFyAOTSQcqk488uFdtgib7KJycIR7V/Lw9QZ+mkQfLhYycnzA9K/CnHJVPYLgAqjh8FvIR2/Za8aZ0zuaXUuU22rEnv1sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748991887; c=relaxed/simple;
	bh=4TZDRmFZTYsMz+RqHTBaCaBfcMLC6KEmYgA3Kd0nFe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H2r0lI8XCd4zxZl+0dDD1QAFldAIenpdzJbqeJNrOyu3dSaVLwL00KKZ2V32BxInuLBYTSHFLCggxBFeWLV9qnzQdVIMf7IwD0o/QqwznCUVSdxdT7z9S1rNfUhGdSVw5qMofxDOoM0tDfv5NbCxt/VuN2L1KW4tCIvMy7oiB8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=k+WmjMum; arc=fail smtp.client-ip=40.107.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdUnfXl+29q2qbdJW8oXaP3OADxSA8MFGSkLKuApY8S2kzMk2Qog5ce7ipllDsLa+XagRGYT5vbKzQGRtObhTuIw88woCi0cOkz19PreZHckOwk6xJ4WYGwpFZkKwfPpQmDlJAYcxKEZVHSfftxV7NsbhIf2j9rJp7E4RnzMGClfA+t0vMFtS9auGFc8Thod5ssJOKRpIXx26ZsQ6/3htr2il1qKAn3vnqs3gTLOJxylAVv5PLFig9gcmDYdV+meEZsa5VKjR4b56LtHFhPrHcMA3g1EbzQkDsnGDoo6Uuc4EIIoU8sI5f+R0wnHXbw8qzozTRPe3pHkLC2R1Z+8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRU04H+g4bZOAtB6/h3mU7ezmgBflNrRtygIcVV9Bq8=;
 b=V1mjVh3afFTLATQfzQ9DiMLOYVwgHa0WdsasjYGEUTmPRuxzsV4pBqZ80owb09IwEPFNRsZNjlcivZxn7gUqCuDR28kayE+v7OeUXXqLnnS2OBVPYlzVh6J1dX466rci2kO0LB45d4BF/2lnVvjbIrroWGZ0M0umo+IYxUNQZ8zgeOmvB5T+zrg8QqnkTL3z3JxpT+zJVtL5xGEf8EwnOgBCOCI73Pwdm59tbUwFQkC4d0weUi8pTeH0iHhq34KZ4SiosmcbsxuyO2r0IpfYB+Q5tJGEVzC9iEdi0Kixb314mL13NLZcLcZZgq3KE5cNxHEbmEHr5Xdho9x8MDLcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRU04H+g4bZOAtB6/h3mU7ezmgBflNrRtygIcVV9Bq8=;
 b=k+WmjMumwqT9SYxLbYQi9dQV/L7n3JY4NHZsvGIF4YPsWpzv8PVPDtWW/daVSKtGhh6IitESsTyEzvgoRgRTp6UyIxHzST03yqZCqJzg1MSuuSSwIP1RU7ov91N6g0laKQe4yaf+vAHLL+fpKsbXUW1MICIoPKB+C/AHxxPdnMmEmtjgfVWPkz/6TsfXWqraaARU5v+nhcQw7+gVY1WnX3uAZ8FgRyKDhRFmU4AxfPs0vem+Cf5wKoRjBv8e5mbJJGmohe20lFzhofH+aNdDVfzBLEbejtZQkPvI0uDRiVqQONTiHNTlSAp71r5fLj+kPn4JRqWmUQyM64lNKen6Uw==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by GVXP189MB2104.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.36; Tue, 3 Jun 2025 23:04:39 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 23:04:39 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Kyle Swenson <kyle.swenson@est.tech>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: [RFC PATCH net-next 2/2] net: pse-pd: Add LTC4266 PSE controller
 driver
Thread-Topic: [RFC PATCH net-next 2/2] net: pse-pd: Add LTC4266 PSE controller
 driver
Thread-Index: AQHb1NviPHYrTpIVGUy5BtiETVG4ng==
Date: Tue, 3 Jun 2025 23:04:39 +0000
Message-ID: <20250603230422.2553046-3-kyle.swenson@est.tech>
References: <20250603230422.2553046-1-kyle.swenson@est.tech>
In-Reply-To: <20250603230422.2553046-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|GVXP189MB2104:EE_
x-ms-office365-filtering-correlation-id: 95cd9cab-d252-480e-8b42-08dda2f304a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?TuFKgy9fWUxB7++WR50cleLVHrS02R5wxiQoJ4IVfSuT0Z6hUiL1Gkg8vQ?=
 =?iso-8859-1?Q?SeUJqZN0heaa+mdp2AYBGd7eTJstsUFijVQr5TgQ6WvezbHntRfamtp3fJ?=
 =?iso-8859-1?Q?j2UPaGC9R8vS44v+yZ4NcsMnYNajIeF9+K8POyNo1HiKguqkKUBM7eL1Sx?=
 =?iso-8859-1?Q?LxbYpX9RokZtiVOmFZD7A/D6oin0lIuqBvgvDmBoBcCv5jbiHH56UjfTWu?=
 =?iso-8859-1?Q?elThm0zUPERC7gMIIYjZuXD8SMtLIhWSqqlMFnEOAww9j/Jfl5ANHI7EqM?=
 =?iso-8859-1?Q?p13eST2A0CiJUIlHQxjUDYV3wMfOKDKzA8MIiY3fLMyA8w0lG0qqIogyLj?=
 =?iso-8859-1?Q?4tYi7nSY7JunfwKmZgB7Uj74ze9BgPa26YWYj5N+/ADp2+iWHWQ3xmrxzA?=
 =?iso-8859-1?Q?Jz7ZRukeJ1q5KjafQc+0PN6Ot2KxX1k60l+YZ6ADwMNdAIk4dEs/m7tKsY?=
 =?iso-8859-1?Q?Buh29vN6j3XrZ2Gm33sFLwIsYEoOcC9pLZersDO+Jw7olHF9vhJUJrWFWT?=
 =?iso-8859-1?Q?UF3vMTCKAYqONDMZQa7S9PucLNJz8CzEMKxKgONru92KdcuHUXK+JcqzKP?=
 =?iso-8859-1?Q?EvMmeD1UTAUWRizaTBVfdIS8qYH8/N5tV+c52zlJPcBjm79fuLxUAhb6rA?=
 =?iso-8859-1?Q?irFb1uiRFt1VklCC2ev9Hw0kEc3xOOaicKxCjDlaucQ80jj9EH/aGrcsbw?=
 =?iso-8859-1?Q?gN56dv6qNMpYA8WEL62cHb1D9XO+898sazI+zKb0ULMDr+YLtqWB5lnLgd?=
 =?iso-8859-1?Q?Vc6hz9M6YoNCP3jwU3F75iM6DtWpLXzlCimxMthg3t3MHz3tJDMLLFN7oN?=
 =?iso-8859-1?Q?yxiEW66byFnxzsZlk7BBMf5JzWOjC7dWwCcjNHlttUdM0qVVLHkBIq3hpK?=
 =?iso-8859-1?Q?NxWgLhB9YeXoqNS7FtcHQeXzZeYmPjzwmdl8F2/ts2zO1czdtitFbN/utf?=
 =?iso-8859-1?Q?XqnSUBqbTkmpQKjqEf6z7U02qBsR/5DqncoJhak2SQqRTfwnxJcIa4fZ07?=
 =?iso-8859-1?Q?Vr3fP0zTl56N5JW74ZWzu2wz5Aw1lGuxHr5fLAo3e94RBZb+KBMoC22xD9?=
 =?iso-8859-1?Q?KuA3VLGHFivUhg5QOl3YCvb7I+PT7IAChQL7OZPA0VHInmyz8rQOhjS7GI?=
 =?iso-8859-1?Q?c4CkpsGPDkITipC4XLbxIp/iTgqdgI2w3bW4yW2vajRjkJa+UGwewHlChA?=
 =?iso-8859-1?Q?WjJkdkTa0DWteTJjQoI0wcVY9HZ5jjjh+M8adRz1sTpkT6KBAywnIj3frW?=
 =?iso-8859-1?Q?J2iecptxcobIGQqkm5UB/myU95XXd/7+0phAdpyp0nlQ1QvA44lwsfxbdh?=
 =?iso-8859-1?Q?x+Gmx3RGyZVCV7NOkc5urEE1hs/AvGEoUngdsaOPC03VqFuVF3TppgNJvW?=
 =?iso-8859-1?Q?7Ht9GnTgMpZsfYIOQNSH0hgyfCj2M8V66f88ZB8mCJ+uZ5/KmGFLL4tJpq?=
 =?iso-8859-1?Q?V1+jjKksD/tW23cK+uNV2NqwWGFeK8sRQIuFAtPINgm+CtC+/RmtwXIHgB?=
 =?iso-8859-1?Q?iGZB8nT7gMrr79N4nn5tY3AFsoGTJzN+5HY3jgKqkDXX5yyiahngxNfjjd?=
 =?iso-8859-1?Q?tZVwjLg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?428ogwVH02Ukalo1e1IBQNnECUBKKG5XH5COFsk16b2c3IxDi5Lj/JpGOj?=
 =?iso-8859-1?Q?C8lawAEfMhBO1gXgFCuTSCFy60aNM85qzm1Wz3yF6eog36cfxwtZYgjJOW?=
 =?iso-8859-1?Q?DuLyv+UGqGQ3gIaIoX0YqwOc//BhIVj585eCqXBwdZCJfbcWpWYdho7NlG?=
 =?iso-8859-1?Q?f4ZAunYHufHb0lvI68SrLF4eeN4DUvhHP9bMdFDMPaXkqYwvXIExGS5GEY?=
 =?iso-8859-1?Q?CJ9arYPfUX4rg+csbyetieJg+FlKlNBaJNbDg3aYrTbCt632PXGNUBAnxF?=
 =?iso-8859-1?Q?Da9XfubCT40P9b/shqziofgmghzULGMMzDUej3sW6YvUtrrR/R+ijX7+H4?=
 =?iso-8859-1?Q?Py8FBz0D5Lk1tEot6EQMrlsnP3HaJIj/hpvsIyqKylclDmJ29gYcq67DUo?=
 =?iso-8859-1?Q?jiOpvG9QnCRJK0EHm21h03A/Z2waLeMJtScdLoecNYU1pzv9UrtgCf96mB?=
 =?iso-8859-1?Q?lWO/uN3SlBrW7XXDvZCxHsC3FfFwO3sPt+5z6lvF+ykWPxXrrMYGx6S/Jh?=
 =?iso-8859-1?Q?tfN3x1ooilsVRFJlF0/TH2p5xomXK5jAJgX/TalD+xzqDl6OKfYZlyfanO?=
 =?iso-8859-1?Q?dsSxQX+C3drR1wmnJrlpjrXv5B0JYmoftT7d/3vw0u9Macuzvi2usj6Hms?=
 =?iso-8859-1?Q?YISKhCqpF76TRYzsXb8Z9bD5rO2lzWR+oRbWxE3a0wxNN/7RxokAp+xWuU?=
 =?iso-8859-1?Q?W+Ur9xtkn9uWQ4ZJQHOytXk3Cr7yB80p2ojv0k6zGW+PjXZLnmImAHaqzE?=
 =?iso-8859-1?Q?RCRG6O30jOqAvKb8yfhfM6QoRRLcfrulRzizoUCDcUt+Cdmmzp9mVeRPtQ?=
 =?iso-8859-1?Q?w2AdstZArSzPFocLmMUOXtvfT8cVwr/eU1oeyKrsQsJYDbTWBBjj5KvHeo?=
 =?iso-8859-1?Q?0BcatXJey6THeZ/XY0mcySwwlid97TPOn03VWZarzIzb8uEVzOHErHz4MP?=
 =?iso-8859-1?Q?eAopf3ftN3kTbQqbDEa+rDw14pVZ6bdQc3np2azhMnVshOHIOuHbnVcIsx?=
 =?iso-8859-1?Q?XUiJtWniaLWGzakz9S/3REfgLlDqxhnTzhzU6RNBe46c3TPNeDIfryr/oT?=
 =?iso-8859-1?Q?Ud+51RKoVq3HMLg6X2RxTUSUx1e+zIPz1ktnlWs6mFrIc2rnXhmgRvuk8u?=
 =?iso-8859-1?Q?wSVBslIgG0QxSGKkMG5HpRX2eOiGmeQuvCTPgIhrfbD7m7BWDUhNXBVw0P?=
 =?iso-8859-1?Q?z1l1/TiWsIbByELNtVP+yiEGP6RzSNNASrqF0uIQka597d3YFs5IUveO5i?=
 =?iso-8859-1?Q?3J6wMMbRVEcZpp8VWLDssYSx3q3MhaW7WZ7Rpy/4q47dLsiUcMU3tHrWfN?=
 =?iso-8859-1?Q?+zHI0zO60LOn8bE2LPqQXu8IQi8Cbgkyf0X9UkXwOOJDkcur2W2h/YJAsm?=
 =?iso-8859-1?Q?95rWIoaR5faML8mPinjSdY3uOnQJ64gG50U6tuXLSkMoSoBUx47he9Q+zT?=
 =?iso-8859-1?Q?9Pe17+8Xag6f3cyOPPfpbk+af8MNkUHDZoEALS6/dOD7vFfk+RNgX4I0Pe?=
 =?iso-8859-1?Q?gO486XooexV2j+uUk5T8dKDeJ6UDHH6zQRVUQERUr9GrfN7U4erTnJ8mod?=
 =?iso-8859-1?Q?q7znYJN7TenNdjWBrcNkLobPqbvdVWBgWsKuH2GnTSlViGtRLFLoyUvLu5?=
 =?iso-8859-1?Q?3StU1p1jC9t4xhn9Q4vFEaR6ZJfQyU+yZW58FvM0bLDwzdFgymrHnGBQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cd9cab-d252-480e-8b42-08dda2f304a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 23:04:39.4736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TW1US4JyihOa/TIYwq3SJduCR7ZfIZiqFuoD2UR/5CKHzEbD859R7LWCEy8gjhRkIXaG3FsgQEmjmNnLtfcYDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2104

Add a new driver for the Linear Technology LTC4266 I2C Power Sourcing
Equipment controller.  This driver integrates with the current PSE
controller core, implementing IEEE802.3af and IEEE802.3at PSE standards.
---
 drivers/net/pse-pd/Kconfig   |  10 +
 drivers/net/pse-pd/Makefile  |   1 +
 drivers/net/pse-pd/ltc4266.c | 919 +++++++++++++++++++++++++++++++++++
 3 files changed, 930 insertions(+)
 create mode 100644 drivers/net/pse-pd/ltc4266.c

diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
index 7fab916a7f46..a0f2eaadb4fb 100644
--- a/drivers/net/pse-pd/Kconfig
+++ b/drivers/net/pse-pd/Kconfig
@@ -18,10 +18,20 @@ config PSE_REGULATOR
 	help
 	  This module provides support for simple regulator based Ethernet Power
 	  Sourcing Equipment without automatic classification support. For
 	  example for basic implementation of PoDL (802.3bu) specification.
=20
+config PSE_LTC4266
+	tristate "LTC4266 PSE controller"
+	depends on I2C
+	help
+	  This module provides support the LTC4266 regulator based Ethernet
+	  Power Sourcing Equipment.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ltc4266.
+
 config PSE_PD692X0
 	tristate "PD692X0 PSE controller"
 	depends on I2C
 	select FW_LOADER
 	select FW_UPLOAD
diff --git a/drivers/net/pse-pd/Makefile b/drivers/net/pse-pd/Makefile
index 9d2898b36737..a17e16467ae2 100644
--- a/drivers/net/pse-pd/Makefile
+++ b/drivers/net/pse-pd/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Makefile for Linux PSE drivers
=20
 obj-$(CONFIG_PSE_CONTROLLER) +=3D pse_core.o
=20
+obj-$(CONFIG_PSE_LTC4266) +=3D ltc4266.o
 obj-$(CONFIG_PSE_REGULATOR) +=3D pse_regulator.o
 obj-$(CONFIG_PSE_PD692X0) +=3D pd692x0.o
 obj-$(CONFIG_PSE_TPS23881) +=3D tps23881.o
diff --git a/drivers/net/pse-pd/ltc4266.c b/drivers/net/pse-pd/ltc4266.c
new file mode 100644
index 000000000000..858889c9ab75
--- /dev/null
+++ b/drivers/net/pse-pd/ltc4266.c
@@ -0,0 +1,919 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Linear LTC4266 PoE PSE Controller
+ *
+ * Original work:
+ *    Copyright 2019 Cradlepoint Technology, Inc.
+ *    Cradlepoint Technology, Inc.  <source@cradlepoint.com>
+ *
+ * Re-written in 2025:
+ *    Copyright 2025 Ericsson Software Technology
+ *    Kyle Swenson <kyle.swenson@est.tech>
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/ethtool.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pse-pd/pse.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#define LTC4266_REG_ID				0x1B
+#define LTC4266_ID				0x64
+
+#define TWO_BIT_WORD_OFFSET(_v, _pid)		((_v) << ((_pid) * 2))
+#define TWO_BIT_WORD_MASK(_pid)			TWO_BIT_WORD_OFFSET(0x03, (_pid))
+
+#define LTC4266_IPLSB_REG(_p)			(0x30 | ((_p) << 2))
+#define LTC4266_VPLSB_REG(_p)			(LTC4266_IPLSB_REG(_p) + 2)
+
+#define LTC4266_RSTPB_INTCLR			BIT(7)
+#define LTC4266_RSTPB_PINCLR			BIT(6)
+#define LTC4266_RSTPB_RSTALL			BIT(5)
+
+/* Register definitions */
+#define LTC4266_REG_INTSTAT			0x00
+#define LTC4266_REG_INTMASK			0x01
+#define LTC4266_REG_PWREVN_COR			0x03
+#define LTC4266_REG_DETEVN_COR			0x05
+#define LTC4266_REG_FLTEVN_COR			0x07
+#define LTC4266_REG_TSEVN_COR			0x09
+#define LTC4266_REG_SUPEVN_COR			0x0B
+#define LTC4266_REG_STAT(n)			(0x0C + (n))
+#define LTC4266_REG_STATPWR			0x10
+#define LTC4266_REG_OPMD			0x12
+#define LTC4266_REG_DISENA			0x13 /* Disconnect detect enable */
+#define LTC4266_REG_MCONF			0x17
+#define LTC4266_REG_DETPB			0x18
+#define LTC4266_REG_PWRPB			0x19
+#define LTC4266_REG_RSTPB			0x1A
+#define LTC4266_REG_HPEN			0x44
+#define LTC4266_REG_HPMD(_p)			(0x46 + (5 * (_p)))
+#define LTC4266_REG_ILIM(_p)			(LTC4266_REG_HPMD(_p) + 2)
+#define LTC4266_REG_TLIM12			0x1E
+#define LTC4266_REG_TLIM34			0x1F
+
+/* Register field definitions */
+#define LTC4266_HPMD_PONGEN			0x01
+
+/* For LTC4266_REG_TLIM* */
+#define LTC4266_TLIM_VALUE			0x01
+
+/* LTC4266_REG_HPEN, enable "High Power" mode (i.e. Type 2, 25.4W PDs) */
+#define LTC4266_HPEN(_p)			BIT(_p)
+
+/* LTC4266_REG_MCONF */
+#define LTC4266_MCONF_INTERRUPT_ENABLE		BIT(7)
+
+/* LTC4266_REG_STATPWR */
+#define LTC4266_STATPWR_PG(_p)			BIT((_p) + 4)
+#define LTC4266_STATPWR_PE(_p)			BIT(_p)
+#define LTC4266_PORT_CLASS(_stat)		FIELD_GET(GENMASK(6, 4), (_stat))
+
+#define LTC4266_REG_ICUT_HP(_p)			(LTC4266_REG_HPMD(_p) + 1)
+
+/* if R_sense =3D 0.25 Ohm, this should be set otherwise 0 */
+#define LTC4266_ICUT_RSENSE			BIT(7)
+/* if set, halve the range and double the precision */
+#define LTC4266_ICUT_RANGE			BIT(6)
+
+#define LTC4266_ILIM_AF_RSENSE_025		0x80
+#define LTC4266_ILIM_AF_RSENSE_050		0x00
+#define LTC4266_ILIM_AT_RSENSE_025		0xC0
+#define LTC4266_ILIM_AT_RSENSE_050		0x40
+
+/* LTC4266_REG_INTSTAT and LTC4266_REG_INTMASK */
+#define LTC4266_INT_SUPPLY			BIT(7)
+#define LTC4266_INT_TSTART			BIT(6)
+#define LTC4266_INT_TCUT			BIT(5)
+#define LTC4266_INT_CLASS			BIT(4)
+#define LTC4266_INT_DET				BIT(3)
+#define LTC4266_INT_DIS				BIT(2)
+#define LTC4266_INT_PWRGD			BIT(1)
+#define LTC4266_INT_PWRENA			BIT(0)
+
+#define LTC4266_MAX_PORTS 4
+
+/* Maximum and minimum power limits for a single port */
+#define LTC4266_PW_LIMIT_MAX 25400
+#define LTC4266_PW_LIMIT_MIN 1
+
+enum {
+	READ_CURRENT =3D 0,
+	READ_VOLTAGE =3D 2
+};
+
+enum {
+	LTC4266_OPMD_SHUTDOWN =3D 0,
+	LTC4266_OPMD_MANUAL,
+	LTC4266_OPMD_SEMI,
+	LTC4266_OPMD_AUTO
+};
+
+/* Map LTC4266 Classification result to PD class */
+static int ltc4266_class_map[] =3D {
+	0, /* Treat as class 3 */
+	1,
+	2,
+	3,
+	4,
+	-EINVAL,
+	3, /* Treat as class 3 */
+	-ERANGE
+};
+
+/* Convert a class 0-4 to icut register value */
+static int ltc4266_class_to_icut[] =3D {
+	375,
+	112,
+	206,
+	375,
+	638
+};
+
+enum sense_resistor {
+	LTC4266_RSENSE_500, /* Rsense 0.5 Ohm */
+	LTC4266_RSENSE_250 /* Rsense 0.25 Ohm */
+};
+
+struct ltc4266_port {
+	enum sense_resistor rsense;
+	struct device_node *node;
+	int current_limit;
+};
+
+struct ltc4266 {
+	struct i2c_client *client;
+	struct mutex lock; /* Protect Read-Modify-Write Sequences */
+	struct ltc4266_port *ports[LTC4266_MAX_PORTS];
+	struct device *dev;
+	struct device_node *np;
+	struct pse_controller_dev pcdev;
+};
+
+/* Read-modify-write sequence with value and mask.  Mask is expected to be
+ * shifted to the correct spot.
+ */
+static int ltc4266_write_reg(struct ltc4266 *ltc4266, u8 reg, u8 value, u8=
 mask)
+{
+	int ret;
+	u8 new;
+
+	mutex_lock(&ltc4266->lock);
+	ret =3D i2c_smbus_read_byte_data(ltc4266->client, reg);
+	if (ret < 0) {
+		dev_warn(ltc4266->dev, "Failed to read register 0x%02x, err=3D%d\n", reg=
, ret);
+		mutex_unlock(&ltc4266->lock);
+		return ret;
+	}
+	new =3D (u8)ret;
+	new &=3D ~mask;
+	new |=3D value & mask;
+	ret =3D i2c_smbus_write_byte_data(ltc4266->client, reg, new);
+	mutex_unlock(&ltc4266->lock);
+
+	return ret;
+}
+
+static int ltc4266_read_iv(struct ltc4266 *ltc4266, int port, u8 iv)
+{
+	int lsb;
+	int msb;
+	int result;
+	int lsb_reg;
+	u64 ivbits =3D 0;
+
+	if (iv =3D=3D READ_CURRENT)
+		lsb_reg =3D LTC4266_IPLSB_REG(port);
+	else if (iv =3D=3D READ_VOLTAGE)
+		lsb_reg =3D LTC4266_VPLSB_REG(port);
+	else
+		return -EINVAL;
+
+	result =3D i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_STATPWR)=
;
+	if (result < 0)
+		return result;
+
+	/*  LTC4266 IV readings are only valid if the port is powered. */
+	if (!(result & LTC4266_STATPWR_PG(port)))
+		return -EINVAL;
+
+	/* LTC4266 expects the MSB register to be read immediately following the =
LSB
+	 * register, so we need to ensure other parts aren't reading other regist=
ers in
+	 * this chip while we read the current/voltage regulators.
+	 */
+	mutex_lock(&ltc4266->lock);
+
+	lsb =3D i2c_smbus_read_byte_data(ltc4266->client, lsb_reg);
+	msb =3D i2c_smbus_read_byte_data(ltc4266->client, lsb_reg + 1);
+
+	mutex_unlock(&ltc4266->lock);
+
+	if (lsb < 0)
+		return lsb;
+
+	if (msb < 0)
+		return msb;
+
+	ivbits =3D 0;
+	ivbits |=3D ((u8)msb) << 8 | ((u8)lsb);
+
+	if (iv =3D=3D READ_CURRENT)
+		if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250) /* 122.07 uA=
/LSB */
+			result =3D DIV_ROUND_CLOSEST_ULL((ivbits * 122070), 1000);
+		else /* 61.035 uA/LSB */
+			result =3D DIV_ROUND_CLOSEST_ULL((ivbits * 61035), 1000);
+	else /* 5.835 mV/LSB =3D=3D 5835 uV/LSB */
+		result =3D ivbits * 5835;
+
+	return result;
+}
+
+static int ltc4266_port_set_ilim(struct ltc4266 *ltc4266, int port, int cl=
ass)
+{
+	if (class > 4 || class < 0)
+		return -EINVAL;
+
+	/* We want to set 425 mA for class 3 and lower; 850 mA otherwise for IEEE=
 compliance */
+	if (class < 4) {
+		/* Write 0x80 for 0.25 Ohm sense otherwise 0 */
+		if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250)
+			return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(port=
), LTC4266_ILIM_AF_RSENSE_025);
+		return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(port)=
, LTC4266_ILIM_AF_RSENSE_050);
+	}
+
+	/* Class =3D=3D 4 */
+	if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250)
+		return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(port)=
, LTC4266_ILIM_AT_RSENSE_025);
+	/* Class =3D=3D 4 and the sense resistor is 0.5 */
+	return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(port),=
 LTC4266_ILIM_AT_RSENSE_050);
+}
+
+static int ltc4266_port_set_icut(struct ltc4266 *ltc4266, int port, int ic=
ut)
+{
+	u8 val;
+
+	if (icut > 850)
+		return -ERANGE;
+
+	val =3D (u8)(DIV_ROUND_CLOSEST((icut * 1000), 18750) & 0x3F);
+
+	if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250)
+		val |=3D LTC4266_ICUT_RSENSE | LTC4266_ICUT_RANGE;
+
+	return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ICUT_HP(por=
t), val);
+}
+
+static int ltc4266_port_mode(struct ltc4266 *ltc4266, int port, u8 opmd)
+{
+	if (opmd >=3D LTC4266_OPMD_AUTO)
+		return -EINVAL;
+
+	return ltc4266_write_reg(ltc4266, LTC4266_REG_OPMD, TWO_BIT_WORD_OFFSET(o=
pmd, port),
+				TWO_BIT_WORD_MASK(port));
+}
+
+static int ltc4266_port_powered(struct ltc4266 *ltc4266, int port)
+{
+	int result =3D i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_STAT=
PWR);
+
+	if (result < 0)
+		return result;
+
+	return !!((result & LTC4266_STATPWR_PG(port)) && (result & LTC4266_STATPW=
R_PE(port)));
+}
+
+static int ltc4266_port_init(struct ltc4266 *ltc4266, int port)
+{
+	int ret;
+	u8 tlim_reg;
+	u8 tlim_mask;
+
+	/* Reset the port */
+	ret =3D i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_RSTPB, BIT=
(port));
+	if (ret < 0)
+		return ret;
+
+	ret =3D ltc4266_port_mode(ltc4266, port, LTC4266_OPMD_SEMI);
+	if (ret < 0)
+		return ret;
+
+	/* Enable high power mode on the port (802.3at+) */
+	ret =3D ltc4266_write_reg(ltc4266, LTC4266_REG_HPEN,
+				LTC4266_HPEN(port), LTC4266_HPEN(port));
+	if (ret < 0)
+		return ret;
+
+	/* Enable Ping-Pong Classification */
+	ret =3D ltc4266_write_reg(ltc4266, LTC4266_REG_HPMD(port),
+				LTC4266_HPMD_PONGEN, LTC4266_HPMD_PONGEN);
+	if (ret < 0)
+		return ret;
+
+	if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250)
+		ret =3D ltc4266_write_reg(ltc4266, LTC4266_REG_ICUT_HP(port),
+					LTC4266_ICUT_RSENSE, LTC4266_ICUT_RSENSE);
+	else
+		ret =3D ltc4266_write_reg(ltc4266, LTC4266_REG_ICUT_HP(port),
+					0, LTC4266_ICUT_RSENSE);
+
+	if (ret < 0)
+		return ret;
+
+	if (port <=3D 1)
+		tlim_reg =3D LTC4266_REG_TLIM12;
+	else
+		tlim_reg =3D LTC4266_REG_TLIM34;
+
+	if (port & BIT(0))
+		tlim_mask =3D GENMASK(7, 4);
+	else
+		tlim_mask =3D GENMASK(3, 0);
+
+	ret =3D ltc4266_write_reg(ltc4266, tlim_reg, LTC4266_TLIM_VALUE, tlim_mas=
k);
+	if (ret < 0)
+		return ret;
+
+	/* Enable disconnect detect. */
+	ret =3D ltc4266_write_reg(ltc4266, LTC4266_REG_DISENA, BIT(port), BIT(por=
t));
+	if (ret < 0)
+		return ret;
+
+	/* Enable detection (low nibble), classification (high nibble) on the por=
t */
+	ret =3D i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_DETPB,
+					BIT(port + 4) | BIT(port));
+
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(ltc4266->dev, "Port %d has been initialized\n", port);
+	return 0;
+}
+
+static int ltc4266_get_opmode(struct ltc4266 *ltc4266, int port)
+{
+	int ret;
+
+	ret =3D i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_OPMD);
+	if (ret < 0)
+		return ret;
+
+	switch (port) {
+	case 0:
+		return FIELD_GET(GENMASK(1, 0), ret);
+	case 1:
+		return FIELD_GET(GENMASK(3, 2), ret);
+	case 2:
+		return FIELD_GET(GENMASK(5, 4), ret);
+	case 3:
+		return FIELD_GET(GENMASK(7, 6), ret);
+	}
+	return -EINVAL;
+}
+
+static int ltc4266_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
+{
+	int ret;
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+
+	ret =3D ltc4266_get_opmode(ltc4266, id);
+	if (ret < 0)
+		return ret;
+
+	if (ret =3D=3D LTC4266_OPMD_SEMI)
+		return 1; /*  If a port is in OPMODE SEMI, we'll just assume admin has i=
t enabled */
+
+	return 0;
+}
+
+static int ltc4266_pi_get_pw_status(struct pse_controller_dev *pcdev, int =
id,
+				    struct pse_pw_status *pw_status)
+{
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+	int ret =3D 0;
+
+	if (!ltc4266_pi_is_enabled(pcdev, id)) {
+		/* The port is disabled by configuration*/
+		pw_status->c33_pw_status =3D ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED;
+		return 0;
+	}
+
+	if (ltc4266_port_powered(ltc4266, id)) {
+		pw_status->c33_pw_status =3D ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING;
+		return 0;
+	}
+
+	ret =3D i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_STAT(id));
+	if (ret < 0) {
+		dev_warn(pcdev->dev, "Failed to read status register, err=3D%d\n", ret);
+		return ret;
+	}
+
+	pw_status->c33_pw_status =3D ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING;
+	return 0;
+}
+
+/* Allow a port to be powered */
+static int ltc4266_pi_enable(struct pse_controller_dev *pcdev, int port)
+{
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+
+	ltc4266_port_init(ltc4266, port);
+	return 0;
+}
+
+static int ltc4266_pi_disable(struct pse_controller_dev *pcdev, int id)
+{
+	int ret =3D 0;
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+
+	ret =3D i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_RSTPB, BIT=
(id));
+	if (ret)
+		return ret;
+
+	ltc4266->ports[id]->current_limit =3D 0;
+	return ltc4266_port_mode(ltc4266, id, LTC4266_OPMD_SHUTDOWN);
+}
+
+static int ltc4266_pi_get_voltage(struct pse_controller_dev *pcdev, int id=
)
+{
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+
+	return ltc4266_read_iv(ltc4266, id, READ_VOLTAGE);
+}
+
+static int ltc4266_pi_get_admin_state(struct pse_controller_dev *pcdev, in=
t id,
+				      struct pse_admin_state *admin_state)
+{
+	if (ltc4266_pi_is_enabled(pcdev, id))
+		admin_state->c33_admin_state =3D
+			ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED;
+	else
+		admin_state->c33_admin_state =3D
+			ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED;
+
+	return 0;
+}
+
+/* Get the PD Classification Result */
+static int ltc4266_pi_get_pw_class(struct pse_controller_dev *pcdev,
+				   int id)
+{
+	int ret;
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+
+	ret =3D i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_STAT(id));
+	if (ret < 0) {
+		dev_warn(ltc4266->dev, "Failed to read status register, err=3D%d\n", ret=
);
+		return ret;
+	}
+
+	return ltc4266_class_map[LTC4266_PORT_CLASS(ret)];
+}
+
+static int ltc4266_pi_get_actual_pw(struct pse_controller_dev *pcdev, int =
id)
+{
+	int uA, uV;
+	u64 uW;
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+
+	uA =3D ltc4266_read_iv(ltc4266, id, READ_CURRENT);
+	uV =3D ltc4266_read_iv(ltc4266, id, READ_VOLTAGE);
+
+	if (uA < 0)
+		return uA;
+	if (uV < 0)
+		return uV;
+
+	/* Convert uA to mA and uV to mV; mA * mV =3D uW */
+	uW =3D DIV_ROUND_CLOSEST_ULL(uA, 1000) * DIV_ROUND_CLOSEST_ULL(uV, 1000);
+
+	return (int)DIV_ROUND_CLOSEST_ULL(uW, 1000);
+}
+
+static int
+ltc4266_pi_get_pw_limit_ranges(struct pse_controller_dev *pcdev, int id,
+			       struct pse_pw_limit_ranges *pw_limit_ranges)
+{
+	struct ethtool_c33_pse_pw_limit_range *c33_pw_limit_ranges;
+
+	c33_pw_limit_ranges =3D kzalloc(sizeof(*c33_pw_limit_ranges),
+				      GFP_KERNEL);
+	if (!c33_pw_limit_ranges)
+		return -ENOMEM;
+
+	c33_pw_limit_ranges[0].min =3D LTC4266_PW_LIMIT_MIN;
+	c33_pw_limit_ranges[0].max =3D LTC4266_PW_LIMIT_MAX;
+
+	pw_limit_ranges->c33_pw_limit_ranges =3D c33_pw_limit_ranges;
+	/* Return the number of ranges */
+	return 1;
+}
+
+static int ltc4266_pi_set_pw_limit(struct pse_controller_dev *pcdev,
+				   int id, int max_mW)
+{
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+	u64 temp;
+
+	if (max_mW < 1 || max_mW > 25500) {
+		dev_err(ltc4266->dev, "power limit %d is out of range [%d, %d]\n",
+			max_mW, 1, 25500);
+		return -ERANGE;
+	}
+
+	/* Given the range, set a class-specific current limit:
+	 *
+	 * Class	Range (W)	Current Limit
+	 * 0		0			0mA
+	 * 1		4000			112mA
+	 * 2		7000			206mA
+	 * 3		15400			375mA
+	 * 4		25500			638mA
+	 *
+	 * Simple linear regression is probably good enough:
+	 * y =3D 0.0238856*x + 22.83371414
+	 * scale by 10^7 to get y =3D 238856 * x + 228337141
+	 */
+
+	temp =3D DIV_ROUND_CLOSEST_ULL((238856ULL * (uint64_t)max_mW + 22833714UL=
L), 10000000ULL);
+
+	dev_dbg(ltc4266->dev, "%s passed max_mW=3D%d, linear regression results i=
n %d\n", __func__, max_mW, (int)temp);
+
+	ltc4266->ports[id]->current_limit =3D (int)temp;
+	return ltc4266_port_set_icut(ltc4266, id, (int)temp);
+}
+
+static int ltc4266_pi_get_pw_limit(struct pse_controller_dev *pcdev, int i=
d)
+{
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+	int ret =3D 0;
+	int icut =3D 0;
+	int uA =3D 0;
+	int mA;
+	int mV;
+	u64 mW =3D 0;
+
+	/* The LTC4266 offers a "current limit", not a power-limit */
+	ret =3D i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_ICUT_HP(id)=
);
+	if (ret < 0)
+		return ret;
+
+	icut =3D FIELD_GET(GENMASK(5, 0), ret);
+
+	if (ltc4266->ports[id]->rsense =3D=3D LTC4266_RSENSE_250) {
+		if (ret & LTC4266_ICUT_RANGE)
+			uA =3D icut * 18750; /* 18.75 mA/LSB  =3D 18750 uA/LSB */
+		else
+			uA =3D icut * 37500;
+	} else {
+		if (ret & LTC4266_ICUT_RANGE)
+			uA =3D icut * 9380; /* 9.38 mA/LSB */
+		else
+			uA =3D icut * 18750;
+	}
+
+	mA =3D DIV_ROUND_CLOSEST(uA, 1000);
+	mV =3D ltc4266_read_iv(ltc4266, id, READ_VOLTAGE);
+	if (mV < 0)
+		return mV;
+
+	mW =3D DIV_ROUND_CLOSEST_ULL(((uint64_t)mV * mA), 1000000);
+	dev_dbg(ltc4266->dev, "%s(id=3D%d) current limit is 0x%02X, power limit i=
s %llu\n", __func__, id, icut, mW);
+	return (int)mW;
+}
+
+static int ltc4266_setup_pi_matrix(struct pse_controller_dev *pcdev)
+{
+	u32 channel_id;
+	struct ltc4266_port *port;
+	u32 sense;
+	struct device_node *channels_node;
+
+	int i =3D 0;
+	int ret =3D 0;
+	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev);
+
+	channels_node =3D of_find_node_by_name(ltc4266->np, "channels");
+	if (!channels_node)
+		return -EINVAL;
+
+	for_each_child_of_node_scoped(channels_node, port_node) {
+		if (!of_node_name_eq(port_node, "channel"))
+			continue;
+
+		ret =3D of_property_read_u32(port_node, "reg", &channel_id);
+		if (ret)
+			goto out;
+
+		if (channel_id >=3D LTC4266_MAX_PORTS) {
+			ret =3D -EINVAL;
+			goto out;
+		}
+
+		if (ltc4266->ports[channel_id]) {
+			dev_err(ltc4266->dev,
+				"channel_id %d is already used, please check the reg property in node =
%pOF\n",
+				channel_id, port_node);
+			ret =3D -EINVAL;
+			goto out;
+		}
+
+		port =3D devm_kzalloc(ltc4266->dev, sizeof(struct ltc4266_port), GFP_KER=
NEL);
+		if (!port) {
+			ret =3D -ENOMEM;
+			goto out;
+		}
+
+		ltc4266->ports[channel_id] =3D port;
+
+		ret =3D of_property_read_u32(port_node, "sense-resistor-micro-ohms", &se=
nse);
+		if (ret)
+			goto out;
+
+		if (sense =3D=3D 250000) {
+			port->rsense =3D LTC4266_RSENSE_250;
+		} else if (sense =3D=3D 500000) {
+			port->rsense =3D LTC4266_RSENSE_500;
+		} else {
+			dev_err(ltc4266->dev, "sense resistor value of %d is invalid in node %p=
OF\n", sense, port_node);
+			ret =3D -EINVAL;
+			goto out;
+		}
+
+		port->node =3D of_node_get(port_node);
+	}
+	for (i =3D 0; i < LTC4266_MAX_PORTS; i++) {
+		ret =3D ltc4266_port_init(ltc4266, i);
+		if (ret < 0) {
+			dev_err(ltc4266->dev, "Failed to initialize port %d\n", i);
+			goto out;
+		}
+	}
+
+	return 0;
+out:
+	for (i =3D 0; i < LTC4266_MAX_PORTS; i++) {
+		if (!ltc4266->ports[i])
+			continue;
+
+		if (ltc4266->ports[i]->node)
+			of_node_put(ltc4266->ports[i]->node);
+	}
+	return ret;
+}
+
+static const struct pse_controller_ops ltc4266_ops =3D {
+	.setup_pi_matrix =3D ltc4266_setup_pi_matrix,
+	.pi_get_admin_state =3D ltc4266_pi_get_admin_state,
+	.pi_get_pw_status =3D ltc4266_pi_get_pw_status,
+	.pi_get_pw_class =3D ltc4266_pi_get_pw_class,
+	.pi_get_actual_pw =3D ltc4266_pi_get_actual_pw,
+	.pi_enable =3D ltc4266_pi_enable,
+	.pi_disable =3D ltc4266_pi_disable,
+	.pi_get_voltage =3D ltc4266_pi_get_voltage,
+	.pi_get_pw_limit =3D ltc4266_pi_get_pw_limit,
+	.pi_set_pw_limit =3D ltc4266_pi_set_pw_limit,
+	.pi_get_pw_limit_ranges =3D ltc4266_pi_get_pw_limit_ranges,
+};
+
+#define LTC4266_INTERRUPT_SOURCES	(LTC4266_INT_SUPPLY | LTC4266_INT_TSTART=
 | LTC4266_INT_TCUT | LTC4266_INT_CLASS | LTC4266_INT_DIS | LTC4266_INT_PWR=
ENA | LTC4266_INT_PWRGD)
+
+static void ltc4266_enable_interrupts(struct i2c_client *client)
+{
+	i2c_smbus_write_byte_data(client, LTC4266_REG_INTMASK, LTC4266_INTERRUPT_=
SOURCES); /* Unmask interrupts */
+}
+
+static int ltc4266_disable_interrupts(struct i2c_client *client)
+{
+	int r;
+	/* Mask out the chip's interrupt */
+	r =3D i2c_smbus_write_byte_data(client, LTC4266_REG_INTMASK, 0x00);
+	if (r < 0) {
+		dev_err(&client->dev, "Failed to disable interrupts, err %d\n", r);
+		return r;
+	}
+	/* Reset the (SMBus Alert) interrupt pin */
+	i2c_smbus_write_byte_data(client, LTC4266_REG_RSTPB, LTC4266_RSTPB_PINCLR=
);
+	return 0;
+}
+
+static void handle_classification_event(struct ltc4266 *ltc4266, int detec=
t_event)
+{
+	u8 classified_ports;
+	int ret =3D 0;
+	int i =3D 0;
+
+	if (detect_event < 0)
+		return;
+
+	for (i =3D 0, classified_ports =3D FIELD_GET(GENMASK(7, 4), detect_event)=
;
+			classified_ports && i < LTC4266_MAX_PORTS; classified_ports >>=3D 1, i+=
+) {
+		if (!(classified_ports & BIT(0)))
+			continue;
+		if (!ltc4266_pi_is_enabled(&ltc4266->pcdev, i))
+			continue;
+
+		ret =3D ltc4266_pi_get_pw_class(&ltc4266->pcdev, i);
+		if (ret < 0) {
+			dev_warn(&ltc4266->client->dev, "Invalid class %d\n", ret);
+			continue;
+		}
+		dev_dbg(ltc4266->dev, "port %d has a classification result of %d\n", i, =
ret);
+		ltc4266_port_set_ilim(ltc4266, i, ret);
+
+		/* It is possible we're in this handler before the ports are non-null */
+		if (!ltc4266->ports[i])
+			continue;
+
+		dev_dbg(&ltc4266->client->dev, "%s is powering port %d because it's enab=
led\n", __func__, i);
+		if (ltc4266->ports[i]->current_limit > 0) {
+			dev_dbg(ltc4266->dev, "Port %d is using a previously set current limit =
of %d\n", i, ltc4266->ports[i]->current_limit);
+			ltc4266_port_set_icut(ltc4266, i, ltc4266->ports[i]->current_limit);
+		} else {
+			ltc4266_port_set_icut(ltc4266, i, ltc4266_class_to_icut[ret]);
+		}
+		i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_PWRPB, BIT(i));
+	}
+}
+
+static irqreturn_t ltc4266_irq_handler_thread(int irq, void *private)
+{
+	struct ltc4266 *ltc4266 =3D private;
+	int event, intstat;
+
+	ltc4266_disable_interrupts(ltc4266->client);
+
+	intstat =3D i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_INTSTAT=
);
+	if (intstat < 0) {
+		dev_err(&ltc4266->client->dev, "Error %d reading register 0x%02X", intst=
at, LTC4266_REG_INTSTAT);
+		goto done;
+	}
+
+	if (!intstat) {
+		dev_dbg(ltc4266->dev, "Intstat is zero yet we're in the interrupt routin=
e...\n");
+		goto done;
+	}
+
+	if (intstat & (LTC4266_INT_SUPPLY)) {
+		event =3D i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_SUPEVN_C=
OR);
+		if (event) {
+			dev_info(ltc4266->dev, "Supply event=3D0x%02X\n", event);
+			goto done;
+		}
+	}
+
+	/* There isn't anything we need to actually do for the
+	 * Tstart/Tcut/Disconnect events here, except for reading the clear-on-re=
ad
+	 * register
+	 */
+	if (intstat & (LTC4266_INT_TCUT | LTC4266_INT_TSTART | LTC4266_INT_DIS)) =
{
+		i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_TSEVN_COR);
+		i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_FLTEVN_COR);
+	}
+
+	if (intstat & (LTC4266_INT_DET | LTC4266_INT_CLASS))
+		handle_classification_event(ltc4266, i2c_smbus_read_byte_data(ltc4266->c=
lient, LTC4266_REG_DETEVN_COR));
+
+	if (intstat & (LTC4266_INT_PWRGD | LTC4266_INT_PWRENA))
+		i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_PWREVN_COR);
+
+done:
+	ltc4266_enable_interrupts(ltc4266->client);
+	return IRQ_HANDLED;
+}
+
+static int ltc4266_probe(struct i2c_client *client)
+{
+	int ret;
+	u8 id_reg;
+	struct ltc4266 *ltc4266;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return dev_err_probe(&client->dev, -ENODEV, "I2C Bus Adapter needs I2C f=
unctionality\n");
+
+	/* The id_reg value here is not what was specified in the datasheet, nor
+	 * the include file. Lets make sure we've got something at address 0x2F t=
hat
+	 * happens to have a register at 0x1B that returns 0x64
+	 */
+	id_reg =3D i2c_smbus_read_byte_data(client, LTC4266_REG_ID);
+	if (id_reg !=3D LTC4266_ID)
+		return dev_err_probe(&client->dev, -ENODEV, "Expected an ID of 0x64, saw=
 0x%02X\n", id_reg);
+
+	/* Reset the chip */
+	i2c_smbus_write_byte_data(client, LTC4266_REG_RSTPB,  LTC4266_RSTPB_INTCL=
R | LTC4266_RSTPB_RSTALL);
+
+	/* LTC4266 requires approximately 10 ms after reset to be stable; if it
+	 * isn't, then there is typically an undervoltage lockout/something prett=
y bad
+	 * going on. We give it 50 ms here so we don't need to poll the chip and =
use I2C bandwidth
+	 */
+	msleep(50);
+
+	/* Let's make sure the chip came out of reset (if not, the chip is probab=
ly
+	 * either (no longer?) present, in thermal shutdown, or watchdogged....ei=
ther
+	 * way, there's nothing we can do in software to fix it)
+	 */
+	id_reg =3D i2c_smbus_read_byte_data(client, LTC4266_REG_ID);
+	if (id_reg !=3D 0x64)
+		return dev_err_probe(&client->dev, -ENODEV, "Failed to re-read LTC4266 d=
evice ID after reset 0x%02X\n", id_reg);
+
+	ltc4266 =3D devm_kzalloc(&client->dev, sizeof(struct ltc4266), GFP_KERNEL=
);
+	if (!ltc4266)
+		return -ENOMEM;
+
+	mutex_init(&ltc4266->lock);
+
+	i2c_set_clientdata(client, ltc4266);
+	ltc4266->client =3D client;
+	ltc4266->np =3D client->dev.of_node;
+
+	/* After reset, the LTC4266 will interrupt with a (single) supply fault.
+	 * Clear it here and discard the result
+	 */
+	i2c_smbus_read_byte_data(client, LTC4266_REG_SUPEVN_COR);
+
+	ltc4266_disable_interrupts(client);
+
+	ltc4266->pcdev.owner =3D THIS_MODULE;
+	ltc4266->pcdev.ops =3D &ltc4266_ops;
+	ltc4266->dev =3D &client->dev;
+	ltc4266->pcdev.dev =3D &client->dev;
+	ltc4266->pcdev.types =3D ETHTOOL_PSE_C33;
+	ltc4266->pcdev.nr_lines =3D LTC4266_MAX_PORTS;
+
+	ret =3D devm_pse_controller_register(ltc4266->dev, &ltc4266->pcdev);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+						"Failed to register PSE controller\n");
+
+	if (client->irq) {
+		dev_dbg(ltc4266->dev, "Client IRQ is set!\n");
+
+		/* Enable the interrupt pin */
+		ltc4266_write_reg(ltc4266, LTC4266_REG_MCONF,
+				  LTC4266_MCONF_INTERRUPT_ENABLE, LTC4266_MCONF_INTERRUPT_ENABLE);
+
+		ret =3D devm_request_threaded_irq(ltc4266->dev, client->irq, NULL,
+						ltc4266_irq_handler_thread,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,  "ltc4266-irq", ltc4266);
+		if (ret)
+			dev_err_probe(&client->dev, ret, "Failed to request threaded IRQ\n");
+
+		ltc4266_enable_interrupts(client);
+	}
+
+	return 0;
+}
+
+static void ltc4266_remove(struct i2c_client *client)
+{
+	struct ltc4266 *ltc4266 =3D i2c_get_clientdata(client);
+	int i;
+	/*Put the LTC4266 into reset */
+	i2c_smbus_write_byte_data(client, LTC4266_REG_RSTPB, LTC4266_RSTPB_RSTALL=
);
+
+	for (i =3D 0; i < LTC4266_MAX_PORTS; i++) {
+		if (!ltc4266->ports[i])
+			continue;
+		if (ltc4266->ports[i]->node)
+			of_node_put(ltc4266->ports[i]->node);
+	}
+}
+
+static const struct i2c_device_id ltc4266_id[] =3D {
+	{.name =3D "ltc4266"},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ltc4266_id);
+
+static const struct of_device_id ltc4266_of_match[] =3D {
+	{ .compatible =3D "lltc,ltc4266" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc4266_of_match);
+
+static struct i2c_driver ltc4266_driver =3D {
+	.driver		=3D {
+		.name	=3D "ltc4266",
+		.of_match_table =3D ltc4266_of_match,
+	},
+	.probe		=3D ltc4266_probe,
+	.remove		=3D ltc4266_remove,
+	.id_table	=3D ltc4266_id,
+};
+module_i2c_driver(ltc4266_driver);
+
+MODULE_AUTHOR("Kyle Swenson <kyle.swenson@est.tech>");
+MODULE_DESCRIPTION("LTC4266 PoE PSE Controller Driver");
+MODULE_LICENSE("GPL");
--=20
2.47.0

