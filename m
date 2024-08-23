Return-Path: <netdev+bounces-121547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E28E95D97F
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 01:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2040B20D73
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 23:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468B1CCB2C;
	Fri, 23 Aug 2024 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vVCuo6Ou"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098001CC17D;
	Fri, 23 Aug 2024 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724454432; cv=fail; b=LhnNm0T4wlb1+ZC7lIiYQd3LOYK2jH5UiQuGnSKAdy35XvxZYGYvZieRwTvbkmIWJyjpzJNSK8oZvtshprm40jqtb0tVe8mAYFGNGWr+QHhZq0FzEe6qBS3gRJ8xbXF89FaI+5mL1QQ3Jxw/eFKJ/Zi5E94RWiXhQHG2ZLqkL+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724454432; c=relaxed/simple;
	bh=lYlNPa1B3uNd1XJP5ZwAM5cNc1OEF0S+S7WkfsEIrGs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RqRSZ9vycCFsMsIXxK/pcQnXlhI0kKDh/QCUmGeYmqg/ibWxVGzKMRu0zd1YrYnBCZqeQdh+AI7hqXLojjPaUfxf0WU9q27TzziZlj0UPOGKbWpwrwlwgkGSktDIc0hCcH0WdW35sF080GtP21qrqoaDAHumz30hoypFIpmoifc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vVCuo6Ou; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SagCXpG2QPCj/ambkpWS9FLQyDEWZtmdrW2UvGAimMJc9kH5wWXKT67FoinC8ov7+webb3zhRc+I1LgyGHw4/bVtCwZaKE16mPmhwsyCbZUw9xAPBHxkAmr3kw97bemsT0PaUaGS2ltVNtJlPPcCa8E6HNLLzzvPB7QfmphqBQfeGicbWcRkdI3ZPyLefHio/IifJyZnW93DYZiJMt3pzMlWamtlu66KGOJsvkvFyaaKl9fg4wMUaULgM2vkgjfewmpOKutPWcLhqX0cs92nw4hnIc7QnqXRl5vWfVi9FvOdcfGFOaIz85/KiqQrBT4HlN07C4hamGU6yyOqL3Cy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1uP638Kg4c5B4WNEPbYsaK0zyLnZ2H5pbUGm+7W7eA=;
 b=bVhfB2ZmL0n2/BxXXH0N4Okpzzf8hx7huld23xzQGdxbyMUyc9TCaNpd9Io+lh19gaJTqK71Rz8Sc+rp/5aHpBumCVwy9HQHgsVyKVVOWPc0jXMYG01dU8F5mUIye/FwX2MVXc7NTZPH5Q3NeC1yKGB5mKGbO64aMErSgSvgFa8D3PCWWRM/qf8O1HplQntNRrnFPrQAC02vU53W1Q1/yJvrhno2I1zs+K9Xl4CO/XE5+KGYuYClbYeZug2U82aQr2kYRhvNH5v18LMXG5oqxvBXc8DtZuQoj3kyrqxdDbzvb9Tns902O/rJNjVzmHfL2nXrTiUGTHP+4Vg+yn8aaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1uP638Kg4c5B4WNEPbYsaK0zyLnZ2H5pbUGm+7W7eA=;
 b=vVCuo6OuKi4HobW5NPodHVgbV5+AyIW6KYbUO9P9JpEUzK0qqdCA96oEzXaRyTJK+JBI/65FYGLBElOvCzEAbrY3JDcOYe13cL7AMDFrHSweYGGjq1slMFfNEZtPSoXWdmsWQbe4HN0S0hCOjch+EL2LzjvFdCYSl1XI7rK+6nsli1ZRIJ17VEJOJ7UfCLUbt/Pvowy7/M8wiBuPqhkq+eVJpYMqELPPvDx+tCv57o4krb+aBdNBDrQh9H+z6IE2fXjfTZ1KuboTmN/cwdtnW2IE/B+xHW/8O9DhPTkztyiKG5cWD19gtHE6vl2ZHf1IAfgj/12HfdC8Tbd5Ss6IEA==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by DM4PR11MB6526.namprd11.prod.outlook.com (2603:10b6:8:8d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 23 Aug
 2024 23:07:06 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 23:07:06 +0000
From: <Tristram.Ha@microchip.com>
To: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>
CC: <pieter.van.trappen@cern.ch>, <o.rempel@pengutronix.de>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Topic: [PATCH net-next v5 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Index: Adr1sMKdiDKBDBuCT3+iykAhr0+Bjw==
Date: Fri, 23 Aug 2024 23:07:06 +0000
Message-ID:
 <BYAPR11MB3558F407712B5C5DFB6F409DEC882@BYAPR11MB3558.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|DM4PR11MB6526:EE_
x-ms-office365-filtering-correlation-id: 390f2bc7-a142-449d-290f-08dcc3c84f09
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?phh1TWT5g5Zs9Tx1lZcaq7Ep0dkgXNwUngrAkE6sIb9yBDnmyte3xxCShzec?=
 =?us-ascii?Q?B0L+pD7zBxjs7XE94hKY1naCboFtcZsuS2cGiLgylyC4BVyvciJug9bckFi0?=
 =?us-ascii?Q?LcHDA8il7ecCqtGfSbCe9MEaX3vAmDs3dZB8g1xRkPd+WItGPjyPZzGvy6uW?=
 =?us-ascii?Q?82HxYC6Gq4UT2Upygva1pROaF5GbbQAeiVtexTd25BknNce/vvPwbBnMR1qG?=
 =?us-ascii?Q?gkWhEBuI8G11gFxkjlFKFZ8AGW4PodRrq7IzSyV2ey9tU5+1Al7zAMBU33oA?=
 =?us-ascii?Q?AwqOvZBxCJfJoCWPmL4ZITvHuGMyddlpnEBoqZ62u0vaOW4ol2qCKNgaklAf?=
 =?us-ascii?Q?GLGuHPl9ZgCoF1WzLFqwyq2OVpRkEsY4htJxcprcq0+iXHgM3wOjoM3l/koe?=
 =?us-ascii?Q?j7zgi/Wi42m8XWR3Bp0dAYyqekR0WRX3g2GrEnFijr/QqOUCZkFE+oZbON6W?=
 =?us-ascii?Q?8o5iKJQATOGzIMewsE/s6Cfa8TOyc1ZOqN94m2TfFatWF9axdFpw8Bttsj/U?=
 =?us-ascii?Q?xnmkx1INwbyHl9jaX2bq8IHMUFq/u+ohD7PAOqL0c+iSkrVvdietD6Gxi8CH?=
 =?us-ascii?Q?nC0AG9JpWleQZA9jTUqdTRiNVpJPW6NOEQVR6yudDLaud6RbDttxL6SPkt4p?=
 =?us-ascii?Q?73IbI95bATIaV4F/gjHWwT95EzjuFirOtrTy0MB5OLhuT8LUvkaaWGL1ksfH?=
 =?us-ascii?Q?FbAglfRvLm1fFZUASrgEKo8DJveDJ9gxVjIJJgy4Jwiaxov9GI86bjjdSICQ?=
 =?us-ascii?Q?MuUW/AvhSjGjd2mEeCaRtSdAHp++XikLBE2YtWKQmKouYgkZ4WVkK+MK4Jbf?=
 =?us-ascii?Q?W/+mjlPxk21vUWxKa69aSaevmSccVYu7Ffzjf3yhNkgPX/p5DPmeVRdrv+Vp?=
 =?us-ascii?Q?5aMgwiXKN3RxxI2WvmUk0f3xFAN797u5WDrbpvEYXQtOCRGO6/NxSPNkbFbr?=
 =?us-ascii?Q?hsTHaAmjqXVyhZis3TkkpI5Ws6lBFocupJytYEz8mRdDUHk3wRtYjS3eWgHN?=
 =?us-ascii?Q?by9FNJ9/2uCgl03LJKgxZP/RJsk4DIIovGfMe892aR2+yUlc+PZeR3iUKh+W?=
 =?us-ascii?Q?Oexl+6N8Avm4s0EuILsODrguMbT1Ve+AtNSI0J5WljIeSWR23Rq4/97s9UU3?=
 =?us-ascii?Q?bk6BCV2cQ5e3QheLi0i9pLXX1+sekgCYbFg9rS7htj/voQTbRVgUSeBNPoWI?=
 =?us-ascii?Q?857zPAsJRKZeG7J9xf3MHgEINobho0Yn5L9zqe+4FgjEOEAIsjNvsVq9S6tv?=
 =?us-ascii?Q?0w2sg/WbtO373UWG9cd/9/BkX/+GwyUGyFonymdwAYrAfeyik1Pj8eZyOxzA?=
 =?us-ascii?Q?Q8c9XJEg9Lj85GVP9pCFyl/G1IZoKcN4y+IuFTD6F5SALaCOXzmTJermOgIW?=
 =?us-ascii?Q?v4vz35Jxlaz8u3CCjrsrH+2fn7aKEiXdSYt/dInwT3hsaqxRJw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?djCc9uc8cH4AFqKg/hPKtxokXM3JjRon/pRV8IEE3Tcb2WL++697XuQu7Zz2?=
 =?us-ascii?Q?YD9DdEkkVyJBgybR2SmQk4ielGCQeFmQmUf/yoRVw9Mgz2SQDNoIwhCFcOzE?=
 =?us-ascii?Q?baHrDEuLsKMAspK0gt1OegFRHJlG3tVuOTMIsSfqPQ2eK7zFmrgrWDgW3mfu?=
 =?us-ascii?Q?ueMfMXe9BlRB+do9hix4D2m2tjecWIotpSpsahY5/MWfI17zst9IlzBL9+VW?=
 =?us-ascii?Q?NOdo8tPXWQzl6NfEDuQTtJWqpAxLbfRTT7/b7GDtu1i/6vWXMbx4tFpSMc5F?=
 =?us-ascii?Q?gpyYa7jetIu3Uv7tWT2OuZyU27bSJJRPHMWiCtPwlIML26HicJZ6doHTj8X+?=
 =?us-ascii?Q?srsblgaXruSFNvMK0Ky+5Lyqf2q9QwYCJJ6fDgMOjuXrVT86NxNo8M/rrTCl?=
 =?us-ascii?Q?eHESVHL+ruf82L0FJoUGnu4iGswbA/XwC+uuDJi2CtFKoCj24O7pWqpA39A6?=
 =?us-ascii?Q?OiIK00jPyYJG2VnME4bG6vhDQQdJarUjX1+S0OhLPLH7+Ppel8GaL9md81Du?=
 =?us-ascii?Q?4Y1OK9uDyzKwKrzTcHXL4mKoQ8uNLR5GE7xtH6uQlVqkaLpwOASjgGTPGLOq?=
 =?us-ascii?Q?j4cOKCLFvx+ZBXwGbBnXcUqsYbJZMP4A6DIH2tLlylxlVrW75cICnlpweSKa?=
 =?us-ascii?Q?pZvfmGgYcii/yU3wcr7yLU/p6NCNJywIzO7EP3+jUV/09D+ZXDSF/azIiXW3?=
 =?us-ascii?Q?UAA55bPGbUwkczFnCL262DEGwbYFZ9kgrRd5s/jUyg3ak7dOBab9OOWfHlwC?=
 =?us-ascii?Q?TVQb+ctsHX+0inShJ2qkaYnKOrYLxuZ5lYVN0B7cugoRUvZ72rDIIJ77QPws?=
 =?us-ascii?Q?2TVLoyqZ/LzXggaECqnJ1BW7Qoh6Q761VpnQaSZc/fvVW6GtAYY01Lvy/r/s?=
 =?us-ascii?Q?t2nxPnvuv3LgZu80BavITx1W4dJzhTLTuD6JaM56dyn4vxJlRSqRztl+qfWh?=
 =?us-ascii?Q?79owzqL1Adv5Xof7dnYRzbxu8AXE/zH/Wf/YQ0quWB3v9XRszfvvv9py6R0Q?=
 =?us-ascii?Q?SYnMNITHhDUUNOfJnGcAlSqj4Qfyr0BQ/V0IvgpcGYiIgIbj59D60nUmROLx?=
 =?us-ascii?Q?NtPL6M0H5dnLyCMPS3CTr1TMHvNn7nUYdmrRqjJBDU2iKGFiM7qEDwN3H8gB?=
 =?us-ascii?Q?5rTm4Kc0HvFd6zVN3nxvZGw97DMO9xCLJdh28yFwqoZPDHm9D3drtJMnkQQr?=
 =?us-ascii?Q?8YTf4iTdBGqiQvazhu/z54OfYUD52mNtjDZ5TpkBKgFOcWpbBDCGCZ7Z3wMV?=
 =?us-ascii?Q?DhZ/3lD2KzTRpS/1TS1+JSLbdvA1/f59HJgf+MpJ8889zgYnBlIKZNHp/yKF?=
 =?us-ascii?Q?zTxLHuGW6OoRZmA38UBM3lamo3KkKhoPDwsbpDtZ96Ot7nFrrTEd3Jz5o5Kq?=
 =?us-ascii?Q?CTEyMQmpi/MS5VBzul5CZwjxkdnUnPq+5UI3ohhAm6TE+/XCI0oxcFLjF+a6?=
 =?us-ascii?Q?sE5VKhwfEXn380ADdXxduajHk2Hpt4mfs92yOq171egvrh2KSERyN5je5mNN?=
 =?us-ascii?Q?iB1GsrR9AmshzJAqj90s4Jj9YCM17qgOedhUWhdRN/Hyk4YAIq/UO1y40Utm?=
 =?us-ascii?Q?j1ERiroMPs/BrrMsOakfMFtqxWvJLqDcMi09uJ9X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390f2bc7-a142-449d-290f-08dcc3c84f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 23:07:06.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PJZcPeCjPUpi8ySZPD8gvVtS8gtX0WAwNKJH5zn3U7cj91heniNrULm1aNPrbsCAgIfL5P+9eNZPKQZHil7olsZ/cP4EbCxoGkOyNnf6r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6526

KSZ8895/KSZ8864 is a switch family between KSZ8863/73 and KSZ8795, so it
shares some registers and functions in those switches already
implemented in the KSZ DSA driver.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8795.c         |  16 ++-
 drivers/net/dsa/microchip/ksz_common.c      | 134 +++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h      |  25 +++-
 drivers/net/dsa/microchip/ksz_dcb.c         |   2 +-
 drivers/net/dsa/microchip/ksz_spi.c         |  15 ++-
 include/linux/platform_data/microchip-ksz.h |   2 +
 6 files changed, 178 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchi=
p/ksz8795.c
index a01079297a8c..aa09d89debf0 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -188,6 +188,8 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, i=
nt mtu)
 	case KSZ8765_CHIP_ID:
 		return ksz8795_change_mtu(dev, frame_size);
 	case KSZ8830_CHIP_ID:
+	case KSZ8864_CHIP_ID:
+	case KSZ8895_CHIP_ID:
 		return ksz8863_change_mtu(dev, frame_size);
 	}
=20
@@ -384,7 +386,7 @@ static void ksz8863_r_mib_pkt(struct ksz_device *dev, i=
nt port, u16 addr,
 void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 		    u64 *dropped, u64 *cnt)
 {
-	if (ksz_is_ksz88x3(dev))
+	if (is_ksz88xx(dev))
 		ksz8863_r_mib_pkt(dev, port, addr, dropped, cnt);
 	else
 		ksz8795_r_mib_pkt(dev, port, addr, dropped, cnt);
@@ -392,7 +394,7 @@ void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u=
16 addr,
=20
 void ksz8_freeze_mib(struct ksz_device *dev, int port, bool freeze)
 {
-	if (ksz_is_ksz88x3(dev))
+	if (is_ksz88xx(dev))
 		return;
=20
 	/* enable the port for flush/freeze function */
@@ -410,7 +412,8 @@ void ksz8_port_init_cnt(struct ksz_device *dev, int por=
t)
 	struct ksz_port_mib *mib =3D &dev->ports[port].mib;
 	u64 *dropped;
=20
-	if (!ksz_is_ksz88x3(dev)) {
+	/* For KSZ8795 family. */
+	if (ksz_is_ksz87xx(dev)) {
 		/* flush all enabled port MIB counters */
 		ksz_cfg(dev, REG_SW_CTRL_6, BIT(port), true);
 		ksz_cfg(dev, REG_SW_CTRL_6, SW_MIB_COUNTER_FLUSH, true);
@@ -609,11 +612,11 @@ static int ksz8_r_sta_mac_table(struct ksz_device *de=
v, u16 addr,
 			shifts[STATIC_MAC_FWD_PORTS];
 	alu->is_override =3D (data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0=
;
=20
-	/* KSZ8795 family switches have STATIC_MAC_TABLE_USE_FID and
+	/* KSZ8795/KSZ8895 family switches have STATIC_MAC_TABLE_USE_FID and
 	 * STATIC_MAC_TABLE_FID definitions off by 1 when doing read on the
 	 * static MAC table compared to doing write.
 	 */
-	if (ksz_is_ksz87xx(dev))
+	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))
 		data_hi >>=3D 1;
 	alu->is_static =3D true;
 	alu->is_use_fid =3D (data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
@@ -1692,7 +1695,8 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 	for (i =3D 0; i < dev->phy_port_cnt; i++) {
 		p =3D &dev->ports[i];
=20
-		if (!ksz_is_ksz88x3(dev)) {
+		/* For KSZ8795 family. */
+		if (ksz_is_ksz87xx(dev)) {
 			ksz_pread8(dev, i, regs[P_REMOTE_STATUS], &remote);
 			if (remote & KSZ8_PORT_FIBER_MODE)
 				p->fiber =3D 1;
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/micro=
chip/ksz_common.c
index cd3991792b69..6609bf271ad0 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2,7 +2,7 @@
 /*
  * Microchip switch driver main logic
  *
- * Copyright (C) 2017-2019 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
=20
 #include <linux/delay.h>
@@ -277,7 +277,7 @@ static const struct phylink_mac_ops ksz8_phylink_mac_op=
s =3D {
 	.mac_link_up	=3D ksz8_phylink_mac_link_up,
 };
=20
-static const struct ksz_dev_ops ksz88x3_dev_ops =3D {
+static const struct ksz_dev_ops ksz88xx_dev_ops =3D {
 	.setup =3D ksz8_setup,
 	.get_port_addr =3D ksz8_get_port_addr,
 	.cfg_port_member =3D ksz8_cfg_port_member,
@@ -572,6 +572,61 @@ static u8 ksz8863_shifts[] =3D {
 	[DYNAMIC_MAC_SRC_PORT]		=3D 20,
 };
=20
+static const u16 ksz8895_regs[] =3D {
+	[REG_SW_MAC_ADDR]		=3D 0x68,
+	[REG_IND_CTRL_0]		=3D 0x6E,
+	[REG_IND_DATA_8]		=3D 0x70,
+	[REG_IND_DATA_CHECK]		=3D 0x72,
+	[REG_IND_DATA_HI]		=3D 0x71,
+	[REG_IND_DATA_LO]		=3D 0x75,
+	[REG_IND_MIB_CHECK]		=3D 0x75,
+	[P_FORCE_CTRL]			=3D 0x0C,
+	[P_LINK_STATUS]			=3D 0x0E,
+	[P_LOCAL_CTRL]			=3D 0x0C,
+	[P_NEG_RESTART_CTRL]		=3D 0x0D,
+	[P_REMOTE_STATUS]		=3D 0x0E,
+	[P_SPEED_STATUS]		=3D 0x09,
+	[S_TAIL_TAG_CTRL]		=3D 0x0C,
+	[P_STP_CTRL]			=3D 0x02,
+	[S_START_CTRL]			=3D 0x01,
+	[S_BROADCAST_CTRL]		=3D 0x06,
+	[S_MULTICAST_CTRL]		=3D 0x04,
+};
+
+static const u32 ksz8895_masks[] =3D {
+	[PORT_802_1P_REMAPPING]		=3D BIT(7),
+	[SW_TAIL_TAG_ENABLE]		=3D BIT(1),
+	[MIB_COUNTER_OVERFLOW]		=3D BIT(7),
+	[MIB_COUNTER_VALID]		=3D BIT(6),
+	[VLAN_TABLE_FID]		=3D GENMASK(6, 0),
+	[VLAN_TABLE_MEMBERSHIP]		=3D GENMASK(11, 7),
+	[VLAN_TABLE_VALID]		=3D BIT(12),
+	[STATIC_MAC_TABLE_VALID]	=3D BIT(21),
+	[STATIC_MAC_TABLE_USE_FID]	=3D BIT(23),
+	[STATIC_MAC_TABLE_FID]		=3D GENMASK(30, 24),
+	[STATIC_MAC_TABLE_OVERRIDE]	=3D BIT(22),
+	[STATIC_MAC_TABLE_FWD_PORTS]	=3D GENMASK(20, 16),
+	[DYNAMIC_MAC_TABLE_ENTRIES_H]	=3D GENMASK(6, 0),
+	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	=3D BIT(7),
+	[DYNAMIC_MAC_TABLE_NOT_READY]	=3D BIT(7),
+	[DYNAMIC_MAC_TABLE_ENTRIES]	=3D GENMASK(31, 29),
+	[DYNAMIC_MAC_TABLE_FID]		=3D GENMASK(22, 16),
+	[DYNAMIC_MAC_TABLE_SRC_PORT]	=3D GENMASK(26, 24),
+	[DYNAMIC_MAC_TABLE_TIMESTAMP]	=3D GENMASK(28, 27),
+};
+
+static const u8 ksz8895_shifts[] =3D {
+	[VLAN_TABLE_MEMBERSHIP_S]	=3D 7,
+	[VLAN_TABLE]			=3D 13,
+	[STATIC_MAC_FWD_PORTS]		=3D 16,
+	[STATIC_MAC_FID]		=3D 24,
+	[DYNAMIC_MAC_ENTRIES_H]		=3D 3,
+	[DYNAMIC_MAC_ENTRIES]		=3D 29,
+	[DYNAMIC_MAC_FID]		=3D 16,
+	[DYNAMIC_MAC_TIMESTAMP]		=3D 27,
+	[DYNAMIC_MAC_SRC_PORT]		=3D 24,
+};
+
 static const u16 ksz9477_regs[] =3D {
 	[REG_SW_MAC_ADDR]		=3D 0x0302,
 	[P_STP_CTRL]			=3D 0x0B04,
@@ -1397,7 +1452,7 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
 		.port_cnt =3D 3,
 		.num_tx_queues =3D 4,
 		.num_ipms =3D 4,
-		.ops =3D &ksz88x3_dev_ops,
+		.ops =3D &ksz88xx_dev_ops,
 		.phylink_mac_ops =3D &ksz8830_phylink_mac_ops,
 		.mib_names =3D ksz88xx_mib_names,
 		.mib_cnt =3D ARRAY_SIZE(ksz88xx_mib_names),
@@ -1412,6 +1467,61 @@ const struct ksz_chip_data ksz_switch_chips[] =3D {
 		.rd_table =3D &ksz8873_register_set,
 	},
=20
+	[KSZ8864] =3D {
+		/* WARNING
+		 * =3D=3D=3D=3D=3D=3D=3D
+		 * KSZ8864 is similar to KSZ8895, except the first port
+		 * does not exist.
+		 *           external  cpu
+		 * KSZ8864   1,2,3      4
+		 * KSZ8895   0,1,2,3    4
+		 * port_cnt is configured as 5, even though it is 4
+		 */
+		.chip_id =3D KSZ8864_CHIP_ID,
+		.dev_name =3D "KSZ8864",
+		.num_vlans =3D 4096,
+		.num_alus =3D 0,
+		.num_statics =3D 32,
+		.cpu_ports =3D 0x10,	/* can be configured as cpu port */
+		.port_cnt =3D 5,		/* total cpu and user ports */
+		.num_tx_queues =3D 4,
+		.num_ipms =3D 4,
+		.ops =3D &ksz88xx_dev_ops,
+		.phylink_mac_ops =3D &ksz8830_phylink_mac_ops,
+		.mib_names =3D ksz88xx_mib_names,
+		.mib_cnt =3D ARRAY_SIZE(ksz88xx_mib_names),
+		.reg_mib_cnt =3D MIB_COUNTER_NUM,
+		.regs =3D ksz8895_regs,
+		.masks =3D ksz8895_masks,
+		.shifts =3D ksz8895_shifts,
+		.supports_mii =3D {false, false, false, false, true},
+		.supports_rmii =3D {false, false, false, false, true},
+		.internal_phy =3D {false, true, true, true, false},
+	},
+
+	[KSZ8895] =3D {
+		.chip_id =3D KSZ8895_CHIP_ID,
+		.dev_name =3D "KSZ8895",
+		.num_vlans =3D 4096,
+		.num_alus =3D 0,
+		.num_statics =3D 32,
+		.cpu_ports =3D 0x10,	/* can be configured as cpu port */
+		.port_cnt =3D 5,		/* total cpu and user ports */
+		.num_tx_queues =3D 4,
+		.num_ipms =3D 4,
+		.ops =3D &ksz88xx_dev_ops,
+		.phylink_mac_ops =3D &ksz8830_phylink_mac_ops,
+		.mib_names =3D ksz88xx_mib_names,
+		.mib_cnt =3D ARRAY_SIZE(ksz88xx_mib_names),
+		.reg_mib_cnt =3D MIB_COUNTER_NUM,
+		.regs =3D ksz8895_regs,
+		.masks =3D ksz8895_masks,
+		.shifts =3D ksz8895_shifts,
+		.supports_mii =3D {false, false, false, false, true},
+		.supports_rmii =3D {false, false, false, false, true},
+		.internal_phy =3D {true, true, true, true, false},
+	},
+
 	[KSZ9477] =3D {
 		.chip_id =3D KSZ9477_CHIP_ID,
 		.dev_name =3D "KSZ9477",
@@ -2937,9 +3047,7 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(str=
uct dsa_switch *ds,
 	struct ksz_device *dev =3D ds->priv;
 	enum dsa_tag_protocol proto =3D DSA_TAG_PROTO_NONE;
=20
-	if (dev->chip_id =3D=3D KSZ8795_CHIP_ID ||
-	    dev->chip_id =3D=3D KSZ8794_CHIP_ID ||
-	    dev->chip_id =3D=3D KSZ8765_CHIP_ID)
+	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))
 		proto =3D DSA_TAG_PROTO_KSZ8795;
=20
 	if (dev->chip_id =3D=3D KSZ8830_CHIP_ID ||
@@ -3055,6 +3163,8 @@ static int ksz_max_mtu(struct dsa_switch *ds, int por=
t)
 	case KSZ8765_CHIP_ID:
 		return KSZ8795_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
 	case KSZ8830_CHIP_ID:
+	case KSZ8864_CHIP_ID:
+	case KSZ8895_CHIP_ID:
 		return KSZ8863_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
 	case KSZ8563_CHIP_ID:
 	case KSZ8567_CHIP_ID:
@@ -3412,6 +3522,18 @@ static int ksz_switch_detect(struct ksz_device *dev)
 		else
 			return -ENODEV;
 		break;
+	case KSZ8895_FAMILY_ID:
+		if (id2 =3D=3D KSZ8895_CHIP_ID_95 ||
+		    id2 =3D=3D KSZ8895_CHIP_ID_95R)
+			dev->chip_id =3D KSZ8895_CHIP_ID;
+		else
+			return -ENODEV;
+		ret =3D ksz_read8(dev, REG_KSZ8864_CHIP_ID, &id4);
+		if (ret)
+			return ret;
+		if (id4 & SW_KSZ8864)
+			dev->chip_id =3D KSZ8864_CHIP_ID;
+		break;
 	default:
 		ret =3D ksz_read32(dev, REG_CHIP_ID0, &id32);
 		if (ret)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/micro=
chip/ksz_common.h
index 8094d90d6ca4..e08d5a1339f4 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Microchip switch driver common header
  *
- * Copyright (C) 2017-2019 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
=20
 #ifndef __KSZ_COMMON_H
@@ -201,6 +201,8 @@ enum ksz_model {
 	KSZ8794,
 	KSZ8765,
 	KSZ8830,
+	KSZ8864,
+	KSZ8895,
 	KSZ9477,
 	KSZ9896,
 	KSZ9897,
@@ -629,9 +631,21 @@ static inline bool ksz_is_ksz88x3(struct ksz_device *d=
ev)
 	return dev->chip_id =3D=3D KSZ8830_CHIP_ID;
 }
=20
+static inline bool ksz_is_8895_family(struct ksz_device *dev)
+{
+	return dev->chip_id =3D=3D KSZ8895_CHIP_ID ||
+	       dev->chip_id =3D=3D KSZ8864_CHIP_ID;
+}
+
 static inline bool is_ksz8(struct ksz_device *dev)
 {
-	return ksz_is_ksz87xx(dev) || ksz_is_ksz88x3(dev);
+	return ksz_is_ksz87xx(dev) || ksz_is_ksz88x3(dev) ||
+	       ksz_is_8895_family(dev);
+}
+
+static inline bool is_ksz88xx(struct ksz_device *dev)
+{
+	return ksz_is_ksz88x3(dev) || ksz_is_8895_family(dev);
 }
=20
 static inline bool is_ksz9477(struct ksz_device *dev)
@@ -665,6 +679,7 @@ static inline bool is_lan937x_tx_phy(struct ksz_device =
*dev, int port)
 #define SW_FAMILY_ID_M			GENMASK(15, 8)
 #define KSZ87_FAMILY_ID			0x87
 #define KSZ88_FAMILY_ID			0x88
+#define KSZ8895_FAMILY_ID		0x95
=20
 #define KSZ8_PORT_STATUS_0		0x08
 #define KSZ8_PORT_FIBER_MODE		BIT(7)
@@ -673,6 +688,12 @@ static inline bool is_lan937x_tx_phy(struct ksz_device=
 *dev, int port)
 #define KSZ87_CHIP_ID_94		0x6
 #define KSZ87_CHIP_ID_95		0x9
 #define KSZ88_CHIP_ID_63		0x3
+#define KSZ8895_CHIP_ID_95		0x4
+#define KSZ8895_CHIP_ID_95R		0x6
+
+/* KSZ8895 specific register */
+#define REG_KSZ8864_CHIP_ID		0xFE
+#define SW_KSZ8864			BIT(7)
=20
 #define SW_REV_ID_M			GENMASK(7, 4)
=20
diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchi=
p/ksz_dcb.c
index 086bc9b3cf53..30b4a6186e38 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -113,7 +113,7 @@ static void ksz_get_default_port_prio_reg(struct ksz_de=
vice *dev, int *reg,
 static void ksz_get_dscp_prio_reg(struct ksz_device *dev, int *reg,
 				  int *per_reg, u8 *mask)
 {
-	if (ksz_is_ksz87xx(dev)) {
+	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev)) {
 		*reg =3D KSZ8765_REG_TOS_DSCP_CTRL;
 		*per_reg =3D 4;
 		*mask =3D GENMASK(1, 0);
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchi=
p/ksz_spi.c
index 8e8d83213b04..f4287310e89f 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -2,7 +2,7 @@
 /*
  * Microchip ksz series register access through SPI
  *
- * Copyright (C) 2017 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  *	Tristram Ha <Tristram.Ha@microchip.com>
  */
=20
@@ -60,6 +60,9 @@ static int ksz_spi_probe(struct spi_device *spi)
 		 chip->chip_id =3D=3D KSZ8794_CHIP_ID ||
 		 chip->chip_id =3D=3D KSZ8765_CHIP_ID)
 		regmap_config =3D ksz8795_regmap_config;
+	else if (chip->chip_id =3D=3D KSZ8895_CHIP_ID ||
+		 chip->chip_id =3D=3D KSZ8864_CHIP_ID)
+		regmap_config =3D ksz8863_regmap_config;
 	else
 		regmap_config =3D ksz9477_regmap_config;
=20
@@ -136,10 +139,18 @@ static const struct of_device_id ksz_dt_ids[] =3D {
 		.compatible =3D "microchip,ksz8863",
 		.data =3D &ksz_switch_chips[KSZ8830]
 	},
+	{
+		.compatible =3D "microchip,ksz8864",
+		.data =3D &ksz_switch_chips[KSZ8864]
+	},
 	{
 		.compatible =3D "microchip,ksz8873",
 		.data =3D &ksz_switch_chips[KSZ8830]
 	},
+	{
+		.compatible =3D "microchip,ksz8895",
+		.data =3D &ksz_switch_chips[KSZ8895]
+	},
 	{
 		.compatible =3D "microchip,ksz9477",
 		.data =3D &ksz_switch_chips[KSZ9477]
@@ -201,7 +212,9 @@ static const struct spi_device_id ksz_spi_ids[] =3D {
 	{ "ksz8794" },
 	{ "ksz8795" },
 	{ "ksz8863" },
+	{ "ksz8864" },
 	{ "ksz8873" },
+	{ "ksz8895" },
 	{ "ksz9477" },
 	{ "ksz9896" },
 	{ "ksz9897" },
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/pl=
atform_data/microchip-ksz.h
index 8c659db4da6b..d074019474f5 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -28,6 +28,8 @@ enum ksz_chip_id {
 	KSZ8794_CHIP_ID =3D 0x8794,
 	KSZ8765_CHIP_ID =3D 0x8765,
 	KSZ8830_CHIP_ID =3D 0x8830,
+	KSZ8864_CHIP_ID =3D 0x8864,
+	KSZ8895_CHIP_ID =3D 0x8895,
 	KSZ9477_CHIP_ID =3D 0x00947700,
 	KSZ9896_CHIP_ID =3D 0x00989600,
 	KSZ9897_CHIP_ID =3D 0x00989700,
--=20
2.34.1


