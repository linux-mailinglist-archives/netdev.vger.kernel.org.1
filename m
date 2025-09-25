Return-Path: <netdev+bounces-226155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A78CB9D0BB
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5B51BC475E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E85A2D7D2E;
	Thu, 25 Sep 2025 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="rAbHuQoa"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583CE55A
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764482; cv=fail; b=kbk1pDkpH680uQWGixP9SjDZP38ZkLe/j4DDaudIY181B/D+L7GT7ITh8Ksoq7j4AwJCPYiwx+aZOIYRgL7Qgl0pkf3ifCkf2AmgAZJug03lF9dx5IEKaQARTEslZnCnwWjVrylojqrVHIV/EwcvOV/bdhhXW5xaPpz7xsz4Y0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764482; c=relaxed/simple;
	bh=71u97OIarskXyjPo/4LFFsPcd9xhq4wnyEH9hZOgQyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKsHfOBLDEPBhU8m2X6dK8lXVran1eBeC0NPlFlHeylVgJVltW41JFuC00ljoXKy40gGg03WT/PnKlSsJgdLoAxzkjqt9PVMIEEQXX/cM+d1UClDvoCR+yC8QN3Wq3HWaT4dZ4OLnhDg+AEfMgDgjUQc3ocASHa8I8/Xl9jT3aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=rAbHuQoa; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhY4kY6GnPUpI53lV4HZAFVqMTG+HnpPA7w4UeFXmSEaPjKszs3yRiIfaWIKtzCPZNVqnRaogZ0u74uaTXMoo+wXEipHxQ6yLgmGv/m1mfwxXgcHO9/YX2F92ZYwRXIzMY9V3jfmVTe/7W6x/oGim790p07kYS26ZQH8Kw1Y/EM0ybqL4yWtO9V2xN4ar+mv2LKTcLD8Urqf4Pv5IMwtY9ffWJXSHPznWQjjrxZibk3+ZkTGXEBYKmyGtbzfWVzn6x9dYTrNc/YhcbQzL097jdkmVp0oUprp2GU3qvyrX1j7XB3q1rtzlO+9LHxGk9hq++D59lw9lKaEY3Z5x2H3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZj67IPQFCK2+tvdAVJEOMfrW47087aQ33Al9ow9Qoc=;
 b=Sv+cZ5I0DjoEBwiPg7qRdrvvhC+wLgx1UunUp2pOusZFU/NqVkir6IwYVwBdePsE1SvqDeLfP3yNXtmPM1Dg35bar5mp/FGgqglmiTPdsc4S9TBw5BQ0Wv/u39SfKTS4KabF43lbI3OwpGEVX/KDXBLdagSW6GLGCDFPqDmeaChKEj5s38zPulDqUb50KFV0fi0XE3h6fXyCgiCIK4ppmZYpJXdDH2CIbeGIt4xYHEoYhNpFz2pHOZ0YsDe4I3BKO1ikY0eUq0rfasry4CjAbZrc9b2BJ3YilfmJbsDIrVWe3v2QPn3o4E5pVack9BNXkwyh2iP531s1LJW0qp9WWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZj67IPQFCK2+tvdAVJEOMfrW47087aQ33Al9ow9Qoc=;
 b=rAbHuQoaqIlfiNYhZ5edzD+hAN6YbfURtpxXk2kdINdCYqQbllgWzSaUwy2+Csoq+kfs0pgjH5flB8DTc01l/jPoldKXaQoV+iWCVBGjTD4LLQMVhWFfYa1EGagva/4eec36Hhzoj2J8hWZgCr0//qUSjyZLXb0+ZbXFMMiiEsdjNdAlt3qmURb0aG5wPjQqcr9BGEoZ+uCHYOniQdXwCxGx4GC8JaEhOQ8DW0hFbfIxNVxgknuSC6OB0jJPMFteXkfFbKI9BPWn27sYGjEIotlXs1vTSjSZx+PahZTPiPhV1iHru7PM7dvhb/AWPUUDR5YQFGxYp36GHEBsgDapfg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DB9P189MB3549.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5f9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.16; Thu, 25 Sep 2025 01:41:17 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 01:41:17 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH v2 net-next] tipc: adjust tipc_nodeid2string() to return
 string length
Thread-Topic: [PATCH v2 net-next] tipc: adjust tipc_nodeid2string() to return
 string length
Thread-Index: AQHcLUYjCinAMp/uXEe5jwtvlA7Si7SjIAsw
Date: Thu, 25 Sep 2025 01:41:17 +0000
Message-ID:
 <GV1P189MB198812D80384E82017A2284EC61FA@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20250924112649.1371695-1-dmantipov@yandex.ru>
In-Reply-To: <20250924112649.1371695-1-dmantipov@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DB9P189MB3549:EE_
x-ms-office365-filtering-correlation-id: 6316a522-4794-42a1-5f45-08ddfbd49ec4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MnRSV10Rn52U0YrOEb60XRjFue4MnQcawoZSDYbyyTIT7+ELjvOeX149lxyW?=
 =?us-ascii?Q?ybZNxq/6qMGppJk8CPzRUHGEtdkVdQdL7QsGWbp/CEm/6tsGacgl6qS603kE?=
 =?us-ascii?Q?G13MbK/NP1ke85Ca6Dcx+RupHuHZLOxyj6cDt8BH7jKq15G/X0++2Afl/4WW?=
 =?us-ascii?Q?ugl4a/7P5Xjk590yj0EQ0LUfjobYeBUP1ZQ+0Sx4CJBXj0+xrL8NcRssfNOg?=
 =?us-ascii?Q?EwagcjpGho3sSTq0jB5DQjOqiscFSlIetyavg6QEGGkdqmUGJ7vjJieDSo1Z?=
 =?us-ascii?Q?SahJCkxM+j2UJWZO6WyrZKUXgdBYpPD3n7FceJMduPF3y+yITDuXgq9iUNz9?=
 =?us-ascii?Q?2ypFZ3G0L79ZXzBX1EYTYamg7RuY+W7dVMPAi/GmIc1vWqntT49YfNHE5IT/?=
 =?us-ascii?Q?ArLqI3Dp/O3DuPZloSLk5W89KBWFuHquqHU/CRAJwANqMHUkiTxCiz+biT/9?=
 =?us-ascii?Q?L6rrGqRe6e1xbJTBaFYDn2CWhI2ZS7OPr/NfXi0Qa88dTSDIPfrTi01RXBr7?=
 =?us-ascii?Q?T83jfy02KIQej2vE9PGjoDqmo4/ujKCXf2/CRXvR8W34UglCPIKu8o0/0C3j?=
 =?us-ascii?Q?es4eJ94mFC3HQXxdLK0TLhga8kXLi259B6JyMTpNKlv5bkTNeRVbVZp1kWYk?=
 =?us-ascii?Q?Rhs1CC4EuTu36BzwaD8vri8utDAxqvnZTnjlXvX7qNaKGgvclj2LX0foG17Y?=
 =?us-ascii?Q?htNJ8T3qITAtvn4ieBWfHcaqustg8QSOiyySYOWL9AmWPO5+Mx3PTC52sdjv?=
 =?us-ascii?Q?S5/z/rDoXYXpu2m9rz/F+HyWL62gDIl81eyOE0DkBoUa90KODxbNYrrvbRCp?=
 =?us-ascii?Q?kxJcgSHuwocsjG63Q8DIm70BNhGdxLY7oGqvBwWFmEH/Od7YJaPN/+U1y+WU?=
 =?us-ascii?Q?JBAKDR2zD1bEqlj1Z6aMbblf9B2InFRXfW/NAkyLAdSB31QCvmZuM5O9+3eV?=
 =?us-ascii?Q?yGVpccEH2IIqpgSotXWgWn3GcLHtcjqpOs+wHbdSLkWqegFClGP5zZIrbe5e?=
 =?us-ascii?Q?0ffPGvNt5JLcDnVfVTR5qbM0wj/o1/k4It6mz+iln58TU/vN59b+N7s1LUg2?=
 =?us-ascii?Q?lu6WyQKrKEQt1+gZX+Qs+ezt1QJRWM8UsS+LtSpd7cOVCNXoMsRhx133EdAg?=
 =?us-ascii?Q?AdxhK54NEjfmXKbnh5ZI45KZGaiVl4CxRNolSijY6wKwI+BgEzIltmDQQzUQ?=
 =?us-ascii?Q?fgJsrh5HSGPDHaa6rhcFEgMI2vkBpdygI1XmI8ozMkkrqXAMDyg2E8eIcMv9?=
 =?us-ascii?Q?a5qeIGQtIBN5j54au93gzzSUL+y+H5ZxGAV8zJIbdJNaRHWJ8tEZ6MjdPo0C?=
 =?us-ascii?Q?E5xllnD4keyqd8YbbH326hv59oWC8lpF+nyE1f4R+/9LcDyHPqL/0mKCuTE+?=
 =?us-ascii?Q?aH2VhNmSnI0cGRXrdmBVRtes8xXUrKzPMo3r7r7QCE+rxiGz2cKdq/QJ0Y7Y?=
 =?us-ascii?Q?ShLzADusEudpXtvf+I09UxW+Fcag/u0ksF6zHM+AsP5zOPLnjBrrgE0kt6l2?=
 =?us-ascii?Q?8yPWZafmZLgB/Hl2N0Fq4LenRCRy1IuhI2Yz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QbRFa3OK81gHyd/s7Kl8Z89bluguiPgHFqBaK3Zq6jcOUnQx5aqWbF6Tz2nr?=
 =?us-ascii?Q?f4bFssGW06e/N1Es150ynFOfJ+URHQfQCnHpoGvxOnrTmnElYZUH7CLgPX+0?=
 =?us-ascii?Q?u3800CO2ON+AnFVd1FjGQ6dnUvZe7JlDFwppNWDnpaAzQiqKwXACi9orecxZ?=
 =?us-ascii?Q?wQeyk9luCmdb4Qq+UvKsgb7QfFgHQab/X3PdH/RQF7Q1TV1bq89n+M2qrsaR?=
 =?us-ascii?Q?jbUN/+gRRiIobYDqy2FuodPCuCbRwIsoUdhGgrx2vwgGQ/UGHbmu5YwAVdCI?=
 =?us-ascii?Q?xkd4JeaggSGh9x9Xxyb0layGZHZk1JpWs8aWIQ28JmX6nn8LruzVRxMHOAyC?=
 =?us-ascii?Q?UghQBrFR4ZsbXRZMwvvL6NZt3E/NJyhnvy9+0yiL/vAZYYZAikHB8hsEGgZ8?=
 =?us-ascii?Q?lQVxB8CXWsRX2VNdVKEqsQDibziwfoHjjZLhrGy8xN1NMdoyJqoSnjVTAxhf?=
 =?us-ascii?Q?FUEUfBLE7mFmf+XZlFt5a6UMBonrhsqaT9+L8NguUwnrTgrlY/+Yjg7Di7Sv?=
 =?us-ascii?Q?FxOg6pvRcMlDfaRbCaDWfDd1SC4jTXfZYDfHRPpMNEYXq3D+iyQZeJ9cUOPd?=
 =?us-ascii?Q?ESLsu0HtHEry4Na9JDWkTxTMJWug1KlrwyH9DPVO0zShLGUp0XpUc5+Vcz0y?=
 =?us-ascii?Q?PGsCqji2CgM4EV59yhPUxdkGnZ4dHkl+oqDnxAQMYR4LDU81PLPHRuGFAY+K?=
 =?us-ascii?Q?3zOjF43WK2Dv8z6vL2QhUi9mv+oipcii9vtVctiFqpwa7Rpf7AC8hUz4L/TC?=
 =?us-ascii?Q?H1UGgWn0a73sSqfJ7PyERTxV4FFzRNvK1nDS50wdo9sKh6ZIbxQs3lcl/ZhX?=
 =?us-ascii?Q?ebdF0azJYh0ngm3GC4eUhrvsHoUi8zUAurOdF3qPXq+7Y0WLycWLzhSZE0xW?=
 =?us-ascii?Q?MJA2A34EORvPmyq8RT9k5CCDXDqXZri+qPueIrrUVk8q1amJhKpoJ8AOVMse?=
 =?us-ascii?Q?gYMisMw4bu8WKvJ09axi8DVJKOfIz2yp+H5DtYcjXFcfAeVgnZCHunSjbaIZ?=
 =?us-ascii?Q?NvYAj26PSuuyycEvK3t7N0u7vH5skSKMiZnskisf/cLIlzSLLUt/1nJevw3P?=
 =?us-ascii?Q?FUTqFPBkR4Tta2iqSeDvAbvsHrMng4WGzx2lPUD8jopZdmrzEnkmTDQluA9T?=
 =?us-ascii?Q?WQ19QThEe8osYCuxONhWbhi3TV0czyhq1/XztMhdpJflieoA6dMCOAvZ73rR?=
 =?us-ascii?Q?MxwsvI03xZogEVe80T2yKlcpR626WKU5mU4y3OI4TSomkmNPgegCQ0bqk6fn?=
 =?us-ascii?Q?V+EoTenKMlhCsEsPzKe+K03Iv849g32ry8HU3yvolmwvs/Mb+Np3Dy260Js/?=
 =?us-ascii?Q?WawQOOTXGjQBaNhPJD9e9rbUZUfpdIgbraoxstQX8N9r5UuXUdL8uI/AhW6X?=
 =?us-ascii?Q?3XvLK7ndk81+9RK3YeOuLalF/yuibDzH9EQ3Au75DGzhkwtog5JuilfGAbnT?=
 =?us-ascii?Q?JBtMBIbPmc2jd1W9ru4H15Ri3yxRUGkJ8k17Y29wr0JSn2GcGJYqc7nZv5WP?=
 =?us-ascii?Q?z5omiMy3YM4lkxUUyuSafhguwesDDiudwUd1mDPCv1CtflVx88r00cyVvvow?=
 =?us-ascii?Q?UGJjJuG5QIfAlMfNJ+oeH8bYpppp0ke30/xA2Nbu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6316a522-4794-42a1-5f45-08ddfbd49ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 01:41:17.1266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NbNDJta+ICmyO1SPL3oLiGlhWqfreAeGDWo0H84Kuc+5ca1PwnMc1KUm+1Mj93X5qlUlqCMIsTJyBgrUWaYvcGtRFFQF8aX5PVNSfnSJ14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB3549

>Subject: [PATCH v2 net-next] tipc: adjust tipc_nodeid2string() to return s=
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
Reviewed-and-tested-by: Tung Nguyen <tung.quang.nguyen@est.tech>

