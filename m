Return-Path: <netdev+bounces-218590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00170B3D65E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 03:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FBB3B9468
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 01:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F081EF0B0;
	Mon,  1 Sep 2025 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eGk+ad6b"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013012.outbound.protection.outlook.com [52.101.72.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFD186331;
	Mon,  1 Sep 2025 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756691578; cv=fail; b=hqzwseMNuDClZHZZ7saHyFXlShVUd+3amALs2CC5Z+0KOqYaGOxXwIH+upP1E01Ti8cG7d3OT5Wlx3Duz1bnkrj8VIuugSfXDjkLaiqh3BibkdtwXcTvIFGGZdULOxbvTt1HTd8HWfEJmPqJj4/GjJWaYZx4FWRsdnqjs+1ChKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756691578; c=relaxed/simple;
	bh=UudE/nWctlMJwRYE2osYAw91VlLqw5n1sNARpuW7k60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PmE1U+pRrKAQzHmW/1f/O94A3qE6K3qP4/x7XlWgtb/n9x/UtOsD0kP+rbmrNmtWFma/l7GISj93NVvNirz5HpIFtjQfcWxfMMCxS6oC8EBeR0gud43B48Kit9GKXOIDV8LD6Il8X2iAe6A012g3IT4iisPoQlcJlF6IWYE/wlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eGk+ad6b; arc=fail smtp.client-ip=52.101.72.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzqG+s+/CQqVjLSVWsxpgtrRtbmO2ZjLpcgL+7zabqDjSbjtXP2kE1u+L3ev5JQdq/sj1qPabtxg7RovnFWHKQWOmr8rcjBMrQN7bH0lJmzi6pLxwwU1BWR6Ie2j/nPGDb08oSy5d7ClrZsGffUAHhSUA275ShwDCHczaqoId+eKOERmiB97SRr7t/5Nvvsg4Yu0BWX5t+ISpQwLkOfATDDlQW3IbfYwIks8tfto00d/9EEex67omDqSv/iwUZ5LA0SfIpxz0B9qGVmG5S7aIpD0MXqJZKxo4XhW6L4umG7tQt64pWyI9ElVwxZA3x6KnIKvrmMrFpEaOyK+vRYmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UudE/nWctlMJwRYE2osYAw91VlLqw5n1sNARpuW7k60=;
 b=yVEJ6OqE0L1FhL9+fw0DMWBSAnsunKD/VznguQIi3WIlcni8qjLC6xDFkcor840CseHW0Vfy/jWJv4Oev/3K63FC2oWWD4u1TJ4wEtztvJnIVto8NrPRbA/jKuwdpEXramCLnFH150FYEgkNJV8rYVVlyRO36QCjHIMbPBJECpmS0JOD0ILIDD6as7FYZrXPZ/mWnI2Tce90c2AP6VOQdig8cwbQPmM0WmxfuWWc+hbaVxK8YHMD83Xsat60CMM0UAcHLJa1xo6zc2F6MXvcmY9iLinl4L9vl6aXnyuUXFy7+Gz5KAZxnKbY8uYPZNi32zzPGf5t8/ZJXxIotBEHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UudE/nWctlMJwRYE2osYAw91VlLqw5n1sNARpuW7k60=;
 b=eGk+ad6bkT7CiU+VZLEtYZqa3oNt5btz5zvC/7oFTPv3bQWD9pwnW5+OtgNhZTZY5VKRS1Y/xfM/r5uufwKjntk1XnG1OqqrjsdDj/oU380WPArjIfYx6xi5NKQpDXhy0J6vsc4Qz0QWQbDp21KVhFiZpkJVbp9DzVht6zdpCk6wfhtKi9MdZ7xRZE9CvOdV3TPkk15j1YlDmUTLcQ/xli7C8Vgq4ybZsKzrEtIwbYoNrUPKN1mWh/v/EG+lY9fPHjHjqLAz9B/Fv3k6G7LPVprfJSkaoQ+bY/SgWFwATG8tWvg9EKPSAqQUi8kBMz8BpidYPoSlLkYxQlpnunoAlw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8396.eurprd04.prod.outlook.com (2603:10a6:10:24a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Mon, 1 Sep
 2025 01:52:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 01:52:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v4 net-next 2/5] net: fec: add pagepool_order to support
 variable page size
Thread-Topic: [PATCH v4 net-next 2/5] net: fec: add pagepool_order to support
 variable page size
Thread-Index: AQHcGryILYgMKnc8CEeb3BVGtBz8GrR9kJ2Q
Date: Mon, 1 Sep 2025 01:52:52 +0000
Message-ID:
 <PAXPR04MB851015FF23A81118D4444ADB8807A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250831211557.190141-1-shenwei.wang@nxp.com>
 <20250831211557.190141-3-shenwei.wang@nxp.com>
In-Reply-To: <20250831211557.190141-3-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB8396:EE_
x-ms-office365-filtering-correlation-id: b7d6f6b3-ed4c-431c-a9ac-08dde8fa4348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pRtOY2d4XbBcDWbZPIdxnAfz9iVKWIO8+IoGDFT5RrY/DgvpRIhjfqLAY9Dp?=
 =?us-ascii?Q?NUbHpZMoMUEvQ3mpudHkxVOmLqW54g+4VWcAnmJl9yHrc5Mw1SdMgANVUcPC?=
 =?us-ascii?Q?38HGyQ+BMgkFiIkwMSNRb96AjOupwA7d6t+z8+6XWnY2abxD1PWCFJF/+40J?=
 =?us-ascii?Q?8+drDWtFlPji/rf/PiUHufsrI4DflEJbsp5ucT311M+u+omr0mB0+HNMZHF7?=
 =?us-ascii?Q?6L+Oipo5M8YQZlKtNgOTpDrJ4pWSo9q7EM9sMG7S3eSCsPBj5UfVQ5A/Aaug?=
 =?us-ascii?Q?l0dU1mN5dMcHt2Bs6uoIDLecKJo/36sTC5L/yMj3poAjSS2N1jbaxUuZLeGx?=
 =?us-ascii?Q?XSNvguCQokfuBkS6dh/SkO0XyYiffgHVzUZgrNDnPWNhLpY15rsKUvu5NyId?=
 =?us-ascii?Q?O1FVh0WO2qIfFDJ4oEQJBiQW9WDE7OMAjcG5jx12+XDq0ooWcg+NbJJOJ3Lh?=
 =?us-ascii?Q?V5UkQ82fIUGLap7YfGq6Ek1H6w/SyPyaKbseP2VNVYG545ZZhNFM2LgePlog?=
 =?us-ascii?Q?7FLmyNuL+rF0+0jCymYDUb8j9NM02O7D6POx1bScikr04I72fGkAOPm3tbB1?=
 =?us-ascii?Q?PI6snXogniHSM8h2fru+ptVq6VqNwQ9wt9rV/+yRfFUQZ2fIZg1m/wZk1n0P?=
 =?us-ascii?Q?lDONM2HRFPOo/NCChI/gKe0JQS60i/I7SoF9teUeEDm964zElZjX5rArd0bm?=
 =?us-ascii?Q?QDXmB5dOnxDt7///ObehY3KujH2QkGtnr+VK6C01VvdbO4j04Zw/xDaQtpB7?=
 =?us-ascii?Q?HmbgHLgVytZ4qDVj2LFRKTBX7rS1aoIHgT2O+IshCyomDK8lyoiI2ACEywwi?=
 =?us-ascii?Q?0tjPoESZ7mi7plJmFC6JU1jR2wmaLbjpUwxlKhbW0kgeiVlIzy9ITUGU/Ery?=
 =?us-ascii?Q?nozxk8KXyQjYAzhFzXarkkk9vchRojKELbCHqHi9xxt4nb6py5EdI1u70IOW?=
 =?us-ascii?Q?LVUVR+OZa0gzawiUBT34t7NOsylzexR0wK1lQl0CORL/aQaWm1tvbxV5Xv3V?=
 =?us-ascii?Q?2tsaVi9kTw5T42RhC7wZt2keTWN68emlNXf/sp6BOEvC+EbTMTkVAFCcZgzY?=
 =?us-ascii?Q?YeEV8yrjzK12doWVN6XG1v/0g7beZiFWNzuBY7A8BLeTpyov5xSB7JLVBF3O?=
 =?us-ascii?Q?ZdfEtHF9Ep/RCSLL/+7Kr2/tSfgK8YxoyiLP6sCPpUVIsLUdwPz2KZKIsPA5?=
 =?us-ascii?Q?dtQsirml3FdhPaBIXo8IMLRpVgANSBA/BGbHzkCaZcZB3F5AFnNKBI/KLdQv?=
 =?us-ascii?Q?T7L6nh0WgnTfmTfyHZb/j+wirpgEaYaqgDtSLYAm9u3poLKor5OBsbckdi5w?=
 =?us-ascii?Q?lZHOz4UhTuTwWjFtu3Fbg7J9idCkgV2uUW25LqmtM3vwdpdyr8pYoU97F9yT?=
 =?us-ascii?Q?Q4ckzeZDYaczEjD8j6/Eg84Lr684CNzbupvxhgACnLavomzJx3HwyAXYaQq5?=
 =?us-ascii?Q?SWTxMg2HYJm/Bx56QdKE7HxQW7uA9OhmrBrHbmK5y7N6CoV2iJJNqw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wZvVhiMWeD9+lLFZeczQb+w38/v2k6Dv6NEpfjUfbzP+0KJHdcQWxbdBvXTN?=
 =?us-ascii?Q?ohmc9lKiHtnMDe1cFzWEm41Zkg21fEQLpBQqhHI+PnbypRIRhNxrR3AgEKZP?=
 =?us-ascii?Q?BeR+12vB57SGsiXX1Xr1jekhO3+3+gxwlIOpdRIYj0vnjs3tG42WgNAJREA8?=
 =?us-ascii?Q?k/kHyx6hICqbzsHFFsADmbh8s65Z6WtQC4PtNSIgH5zPrLGw1t/PLdD/GRtE?=
 =?us-ascii?Q?BjF906Fo8YnytUoWzAaDW3x+ldrvFM+Z7B08fodOpxjPXF9wZZUgUaPwT9th?=
 =?us-ascii?Q?9IueduT6Kdj6btyjJlvMjFAJ+yGCQBLdk6JDUd+Hyg0d8/R7G0oYn8dsCRUN?=
 =?us-ascii?Q?YdKpAQuF04sZETHs6FOtu9r75f4U3QpZp/LzvBulzZXvCFpqgX5NvY75N1LZ?=
 =?us-ascii?Q?3LsdvHGEHQIwghJ5/EhSmIzcE/HkTObkBu9jh6tuabDoo+Ni2CfS4RJMigbM?=
 =?us-ascii?Q?OB0tp2Ru4soU90xNExazScCcxCRmTb4q3ZY0k9cOgwcGVEvzLU8X94iidSEf?=
 =?us-ascii?Q?6gvUIauEEwZrp+7BvjuO9weW3HS8s8WQTr0fjxBMDKkik5RFChBwScCkjq7x?=
 =?us-ascii?Q?jSPFlqD7NUX2QzkvoXgxbMxSBDUi9GohU1+aZBrOHU0LJ5wjEkCUOm26ceLG?=
 =?us-ascii?Q?Q3NIHg6P5241CYITqGx5yXmzPPmZCAySap5OCPmag5+9u3VZg80UMC5Nuz6S?=
 =?us-ascii?Q?fACz4/uNXegmIBnKGwkz/zRHM0waZiJIQXvM4/C3e2KYO0pcFxoatlZA54bp?=
 =?us-ascii?Q?rKfLQ088JINxCrC5ZkSTmY/yBX/Z1NH3bZQGKnZcBMtK5dZJEdwJgMz8c/OK?=
 =?us-ascii?Q?U/oVYZ8/hN+IRO0/VuvLrCRqzhLLyu1Jq1925A/Zz5BStdSXqpscl4PgnZQe?=
 =?us-ascii?Q?e1SMAM3VwynZtrOY6Xwx/fx/Sk7kD2CpiOPi00sWbvQO4pkTPjQGGmBvf1Cv?=
 =?us-ascii?Q?BKj4XZhJOmtPW7aO7DhVxxdaBvbLM4EU6GKafIXMOgUKXT4dTIqlYMZe7w79?=
 =?us-ascii?Q?86/i83kBvBLnlpt8GcdL2JMSTuIjXMo4yuUEbrvbr2wx0GNr5ILiTfnvFYt0?=
 =?us-ascii?Q?98vXScLUCTNPhqPGvFbIdY5f/edeRbWflxEaHvZ6qtkfg1+he0sZVvDMcJrI?=
 =?us-ascii?Q?padprzy2R37rGNPmcUATEQMtb9Kk/84ypTZLGhXoA4QZJiCEPczkWI95qMEI?=
 =?us-ascii?Q?KsAB9KfTNOLdUwgbnugzee9+Kk5h3hgWVZXfdLMjDo1Q4f7npFailPlau0Tj?=
 =?us-ascii?Q?MZjgUzJZ5qLaXwkIbsHo10x1bxm0bh0aX52K7JkS/HjcVH45rItKUlSIhLdd?=
 =?us-ascii?Q?QndbwSGuQaiVVRXX2x6bO/vcfGF1hhVOYGSSLJti1aaDJghMymnOxyOzYo13?=
 =?us-ascii?Q?JjAKW8GVuD4cC6NtKbd9NV6EROr8Oh47k0xA4i9dO2QH+Ganyjktp9rsYpLV?=
 =?us-ascii?Q?g/mysZp2JrxQQdP5JPVTlRQBk6qNOlYDIepdbfyBQ6S1rMHnh94Lrb8Xr4l1?=
 =?us-ascii?Q?TzJHXcQQVwTFGfA6V5sSiMStKAdvZHX5PE29LE1ei/E6X/ETd0Yfx9CziqVa?=
 =?us-ascii?Q?Jd23Js7SLcszX/tr2dU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d6f6b3-ed4c-431c-a9ac-08dde8fa4348
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 01:52:52.4706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wL3S/XWw9RRzeLOVFEF1dnb7JRSWAaw32i4tuYtcbJo/zmy8eKu8PYeJ/juMhWYJQyzPKL9bCv1NWkj/4/jLiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8396

> Add a new pagepool_order member in the fec_enet_private struct
> to allow dynamic configuration of page size for an instance. This
> change clears the hardcoded page size assumptions.
>=20

Reviewed-by: Wei Fang <wei.fang@nxp.com>


