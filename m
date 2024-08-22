Return-Path: <netdev+bounces-121168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3A995C08E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E94A1C22687
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 22:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D8E1D1F4B;
	Thu, 22 Aug 2024 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="Vx63iSmB"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AAB56446;
	Thu, 22 Aug 2024 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724364085; cv=fail; b=Lnz3YDMDytMZNdcbDIGiQW6VpgQ1XJEfxP9GLsm/ZYb/yaEFRVuEUpkGHuDEQqwOZaqbLFOk6TI7QAmTEyYa8snnhNM/r4CEiRiA7A8/pvQ61zWbjZPQcPHNWqQvwGRjCUhBRMULwcoCMJbl0TCd948oAyAQ/taJlgqXioGYdAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724364085; c=relaxed/simple;
	bh=CvHDmBqhdc1YayKXQ77rcunnaVti7/DLXUEvnt9kr4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7FIgOuXIhjlJLHcMN4ZcHdHi/39o7BRgfPM+4pNi33vnkmwfDZoZZkakwBsW9NCqxqxW1Pc2ZbDPmNER5udkRwAKouJAxOOEmBmW43R6kCXx5C9unFpZCufjN+uu2Mx9B/BYPC0402rV+SCZOi+Z/CUU4+fmb+7N6DsxTuojY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=Vx63iSmB; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuGafOlWNm6aWUk1cgrOrgbReXvvKd5fZRyfJrpazgX1KIwG97OuVxZgKqKfJ+mVDryBLfUMuIsrOtn0M6snzKYA5laY1+JawvGhlag79HhR6drP3qTMLmzVDBav4B0ALzdgZmXzrVpMUABffY+JG3Z8GzRk2ld+nQOvseXkXiy0jGCR7NTUXA5phc4HtdU7fM3ZVMziqoA5qCzzJ3h8uSNmjogW5lsVFFBB+NKTfsYz17XY32rvoTML9coyaz5OGpeOJ66abyqKPrBbLsrVHJxaqhf0byawP07LSpCEZhudyUxo3yedxUzHve428uA2Hd+/9cqhdfuTaa5AtyZT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTtsVMTgqMrO5BdnBFhmpidOl8stuihw7kfC93r3ytQ=;
 b=kDPv4OCZSkEHYNUtRDT7CS7mfvc4ooLonmnWvyJm6xANZ/nSjmqOuoreba2fBXGUe8sPeBigNFxDQJno+FhJwaDllXLSbQdQKTMY/DJVPlVy3wmlwHyrKlK+cOlOUjBwr3XklVWUADG8V6tmFQl2iLmOTkBgh8bj2qJ5z5GsV/z9aqJWaJVLy4qN9kqjmT0DQqKNguRre2z17S19IgHfZTS2/p0GxAm825LfWbCJWy5i5qqZ9ZAo7pxliiWpXr8BDZX65+WrQOCKpl/91+hbyCvku20c89uV98UNHnWt65RV3fwRJCq1QeFTdG8NDSJelUuVaA+5nHp7Wleuj2QBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTtsVMTgqMrO5BdnBFhmpidOl8stuihw7kfC93r3ytQ=;
 b=Vx63iSmBnLIT5NgHRdEPIe3vNv5x3pWjVRmmQBPDrS/8RIs6t9tAW1slC/WxKiwHiNUi1H9cZ/wFWnAUhDjPidK6+HbjiINqELxna/EuQyIEdYnbInZRT8q6heL/JXASFQah+vKifVORXQdNorGkjmbEVUU2np/j7V/gEtrRcwA=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by PRAP189MB1828.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 22:01:21 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 22:01:21 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>, Kyle Swenson
	<kyle.swenson@est.tech>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v2 1/2] dt-bindings: pse: tps23881: add reset-gpios
Thread-Topic: [PATCH net-next v2 1/2] dt-bindings: pse: tps23881: add
 reset-gpios
Thread-Index: AQHa9N7Sr9C21L+L6UCVPD2OAYDzUg==
Date: Thu, 22 Aug 2024 22:01:21 +0000
Message-ID: <20240822220100.3030184-2-kyle.swenson@est.tech>
References: <20240822220100.3030184-1-kyle.swenson@est.tech>
In-Reply-To: <20240822220100.3030184-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|PRAP189MB1828:EE_
x-ms-office365-filtering-correlation-id: b2d4584b-93b9-4b63-1ce2-08dcc2f5f4e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Sg/nZeUamXenYt4r7KL/pT6//qO/yq1DL9O6D9QytQXhvXJGxN/MLSxdvL?=
 =?iso-8859-1?Q?IAaet+07qYSPQr8JNee2ooXsMEBCaEp1/7AhtXMhJP8WitVZ0GWk052Y4C?=
 =?iso-8859-1?Q?bzHUv/Tm5aCF072ok27JHc+HGOiO9LEu+ncMVm+40S40FNy9oSjcfyf2I0?=
 =?iso-8859-1?Q?zfPsGmc2+s7+foyryziURkt8btZfeEWVwVl4wP/MxK0Wz5eip78EhVxUUO?=
 =?iso-8859-1?Q?eVSp1BX/utyxVhpkFgVnqbOloF4c7tW/q1qakh95Wf5LEPA3HE/+22nmvO?=
 =?iso-8859-1?Q?8S0RqeBbMgHOAcgIcDs6/GxYzBb/ngN0lQ4+SySzvyhxP2swg8fDrfLZ1X?=
 =?iso-8859-1?Q?j5UDz/Oq1339zYYETBgXr3u1qKim+2a95zQbUafkONxxNvrWrcDfAdAnw6?=
 =?iso-8859-1?Q?fDx37STfJC3/obVqtsRf3wyWeRkxC7DWubhrD+sTbIYdVvRm4BRzC7p4tP?=
 =?iso-8859-1?Q?IB1bsX/QgVIapvvtKpRZC0JXluAHdXn7yqnWQ4D9UJ6pZpTs/d1MXPQrCe?=
 =?iso-8859-1?Q?nkKcDpLdi16V1xhADXwhpBVyeTpq6pcWSloledA3qiTUmIld3MXlk90ShI?=
 =?iso-8859-1?Q?K9tF1Tbserewlg5t7PwjHk8ACPzIIjtkKR9mUlskrcPq+Yz/bH97YNut/z?=
 =?iso-8859-1?Q?XpE2CZvzRug2hpjShr3+q4yWO2U2SckPxnL+NeQMWPJSdlxZCsl7lsKv0R?=
 =?iso-8859-1?Q?O6jf21myEReY9N4TmR6lbNJYYtbsGG/mSF1U68CrXNXbQGOrogzHmgK3JR?=
 =?iso-8859-1?Q?dEDj+AKln7/axCf8xA2bQjnUgadxSl0KDlsb6MGzhu0nrCIEpaUMi9jUnV?=
 =?iso-8859-1?Q?fuMMjkWSJTYiIWgGsFvH2QszEngTlvLBepZKQxRlY6avuhnVu+eo944Bvy?=
 =?iso-8859-1?Q?VX+ANs34PwY1r8A0Qg9w46PDhyIjVbEoXkrgXjg/hSAClYHayG+0Hqquly?=
 =?iso-8859-1?Q?RCrFq5kfRdeskRJ4rpnH6iJcfluiFbMZ6LeSU/i9HBN8k094wDPeks/zhD?=
 =?iso-8859-1?Q?8k8YBKe7CuVXMt6GtjULWYq7/NX2/Hs++w2zcOxpvoyaD3Id15XBAObQjE?=
 =?iso-8859-1?Q?BW21hGX78c6ZgnSYEAKwQ9fcyz7JUqYBEXftsQRyPVnqwAdIbOMMf5Roxl?=
 =?iso-8859-1?Q?2HTc8fhRBiehS7AzBl4luJip089opapp6I+KrUJIvanTSSYFW5b7fDKqsL?=
 =?iso-8859-1?Q?hymgXZ9htmtvJG3rro8BoqPHTxmD3GRBL7Rx/a8zDU9MZjRqVOu6q7u4TN?=
 =?iso-8859-1?Q?8rH2UALQtXvC81QdvvBfMPdWVoEipsP0WqbYnHUC95+/1/gD8qqRsnxIhM?=
 =?iso-8859-1?Q?iph+/bPrW2lIWwv3GXjT4sHLuDCZ1t+QJx+crQiD/RegteqWXTqybRxb6t?=
 =?iso-8859-1?Q?Bss08qT7au5akmSvfhskazTTRF/s+I/NANy9TuKHiqYIV+WVNmPVE0D1wl?=
 =?iso-8859-1?Q?6GKUsefnDJcxN0/rnURrnGle60/p7aoxko1aFw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?H718l12NFRk7xBHjzVAYUtwXEJhFysKhn5fFuRhrQ1rjZBRebf7fKPrmeB?=
 =?iso-8859-1?Q?s8/YewKCkDNkPDiTQKF+NGkK8NkUouDJiDgUWeKbbgsJDL4cYpGdeB2MGy?=
 =?iso-8859-1?Q?/PAV9Q9wIYYrwy9MhZkeqEsauNPfQEQst+vaY6qpHlNV65QbnzVtIZ+25f?=
 =?iso-8859-1?Q?DBCj3pUtMR3zUcYDgZSG6efWNLf+ffxc8Jc5R8m6caOJtcaxTuekyl03uv?=
 =?iso-8859-1?Q?aUvXTCoPUsD4DLRZ5W5h2Qfz4+YrizjtY3BowzSSdcaEmew1Ce336p0KPf?=
 =?iso-8859-1?Q?WfmgN8w/cx2VUe2Mctdo15l9zUUHLw+LPubmpfi/pnTkUqmC8yAYaXwbyU?=
 =?iso-8859-1?Q?k+yRnb1VALs0evxzlnCdIdpCt9KKVq7KrwYAK4r/Lxp6wybtGhGovHbLBV?=
 =?iso-8859-1?Q?M+CBQYTNrDxgDij3e+nGhKctgTu9JsYHYiDE/6IMm3cOZ13ARhsME2mKRO?=
 =?iso-8859-1?Q?7P/efUEJW5SXctGjhr9e3P8F2KFSYGSUiZjaRbB05tq3Ax8wF1yq7eg52E?=
 =?iso-8859-1?Q?2kBz+f0L/EEGDkX0iwpmB71fZMaBOlggg/Vawo4lBQxpbukLBfnlnzqKrP?=
 =?iso-8859-1?Q?jJx6qhGWYf/eLlzCEwRdmVARq1rvPJZItBu4z+8Delcj3Fy7Mh7N60Iylt?=
 =?iso-8859-1?Q?kvCa30h5UvCD5qIQqtXqB1+ez64G6deP583/mMQ6mNXD33XT7v/o/8poxn?=
 =?iso-8859-1?Q?lDq/UfwuijA16trfSGiSCuT8QhGMTg5aB2F7+Jz61d5g/VWu4w31GnNBGI?=
 =?iso-8859-1?Q?De/VlkTwCQLRQphQ/d3Ztfys1kCAAjvY1WZX4FuNCqbOU+G1glPjNjbd4p?=
 =?iso-8859-1?Q?c5UAoCjpFVbTzgaK85xTjhxhdB2+7PSUp9Ps0ffJi2cWVXm0FJiq7O5C2V?=
 =?iso-8859-1?Q?Hs0USuwQ/Vk3ralButqjISvPiv7VjYTdwYa1cndZh5UMXOSpj8cLOG5QCn?=
 =?iso-8859-1?Q?olRNHCbZSh1n3it5ZLusDLw9gVhCDaDcyD1UtGqZpOTqza3qdmjPy5c2LY?=
 =?iso-8859-1?Q?rHuGM2lsNhDL3GxVP7GWKopG6tMF72lX7M3bFbl8g6+m14/CHSE5395Oc7?=
 =?iso-8859-1?Q?bqzKTFT5usTYOWltXkEj09MbtF5rG1gQY2Bg7ZzF/MsnvDNzZzYQmb97bk?=
 =?iso-8859-1?Q?hspaBNVhFuhvIwzFTusOBzRayAGYA7v6qU7uDQS8BoQDvZ735pcmGOATVh?=
 =?iso-8859-1?Q?x9vvsGORwPUvGoDPy9lD0WBbYH3o9BV8p4mOh9Isnh6lBz2ma1Z7qRYYCM?=
 =?iso-8859-1?Q?+udYYi97Tv0Aj32SEQvUzR6KNPuiCFi50nRdkTMeM6ubyJ9Vd71mPKOSij?=
 =?iso-8859-1?Q?SGqoAsRnkYo365hIW18eFbrSnGvCMFsBZh/QiHbBn9tD5wY/92ykXk+acW?=
 =?iso-8859-1?Q?1KB8eHUFKjRv3uq6koM0hOQT5mPjsxruQltA2xn40z5ASUOwlTXSpf23F4?=
 =?iso-8859-1?Q?NB+MBcJmhs5wx8gbF5uyvh6j+6eLSa1265UWzUDN9WC8+YufmaztU4+z6i?=
 =?iso-8859-1?Q?YWqGhrc3u6Tcw7Li3QvusDclvmdrW5Hu/mswTq/B4+tq9YTq1J6MtYKaqG?=
 =?iso-8859-1?Q?BRJAbPFCFO5P+W5+oRZnFZw0ui7ZYclEfB/yNJTnmXtmshCdltoT9Oz/CV?=
 =?iso-8859-1?Q?InRd9GGHWph+dYffqGh5333EARg4Jue6hDn+J7HrElhe9GH7YvjLmAjQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d4584b-93b9-4b63-1ce2-08dcc2f5f4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 22:01:21.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUkNWtQf3zSZWG79Og/+JybNLM5s28mgkO73g+qcpJ4nbiL6TIIJdyFBOd+VOtBK3cKT8WTCqhmR3M6qghQ6iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP189MB1828

The TPS23881 has an active-low reset pin that can be connected to an
SoC.  Document this with the device-tree binding.

Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml =
b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
index 6992d56832bf..d08abcb01211 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
@@ -21,10 +21,13 @@ properties:
     maxItems: 1
=20
   '#pse-cells':
     const: 1
=20
+  reset-gpios:
+    maxItems: 1
+
   channels:
     description: each set of 8 ports can be assigned to one physical
       channels or two for PoE4. This parameter describes the configuration
       of the ports conversion matrix that establishes relationship between
       the logical ports and the physical channels.
--=20
2.43.0

