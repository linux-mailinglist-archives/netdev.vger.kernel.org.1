Return-Path: <netdev+bounces-121232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA8395C3D5
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 05:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13231284C34
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A122BAE1;
	Fri, 23 Aug 2024 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="NpPM6ryu"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98620DF4;
	Fri, 23 Aug 2024 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724384816; cv=fail; b=iyBuZVofdHYa0zpGNK9786QeISxFKiWgcaUywi2oynHi/P0NVCMm/NrsY0DNFQDgPVW/XmnqlANUro4KdStHSTRjqgTGcmWynxvGheRA2Uwm51EUDmMhlIV+HdcOl6YLV6fYCl2xKax+Hix6gJI+YeODqBX8yb3+/YuvG5C8Z7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724384816; c=relaxed/simple;
	bh=gFzF1FYgP5nxQij9xRlPg8wkD1p0wYTdseacKX6OTY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SGtHkAuRGLYStKSP9d4s86Jcf7MfldIw517vIgpWECjoyueBrRRhuSX/pAdkG0XxbeOAXlgXfX8e+PmxIeMhan7tT8wtlxei5pTZJx+CkmHc1Kp7rNMRtvlrX2uJPmlCB2akkYY5eR9IqvDtXeBP2o9M7yNKmMcEuTqdAGjV/eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=NpPM6ryu; arc=fail smtp.client-ip=40.107.117.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFXfNGAbHeGiU82Oo7cRiwP+TERUmveWnEWurOqDUGLMlZ9R0+s/6JUOXjqA1oIQ2iYxh6BkCj0M+aSqjdl3prDiX5tAFB+8QYG8pYeFjP/326klxeM5zREXgh0Q3jgIF75jmcfn6fmwJEjzDyZf7s+qUxAjd2iEvi8dY7P5t1ONJ8Tb1lnYkur2QrYr0yW00ZDSwBe8NDpsZXgBth7ID3q16IREYFQoYF5MjqMHnahmsItLPOqgoTmhsKGjxoHmmtFTg+vFBZlqj/AZyR3d1NKfs/IlxHD34IBUFBCscprvT6UxqtF4d3EF0kaF50HsPdm5ZNy2q0k5yYtcyLnb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCOr+XMgtZ0zJcfoWo5RRmaTyhktuVgi3RNQ0HBGMSs=;
 b=Fp9cpITJZLBiK1FrIiVwQ4AKo98rIxfVzaRLGPuSSqz7EESJyA/PhsA8Ez7du5ci2bD2UqWF8/lqvZd8VFDOrMPQWwBDNeHtC/hDO/9RO8M8uGMW1+EHDAYV/68Bpe0dxjihNtykUJy6EeZXZkWkLvdO46+FM9QEHsiJKk7qPzZRcq0zEpTO/+AgvtBjt9Hfa4pqxsEFoe5RY9s8lotVSW7PGzNdSVCEKV4oqSC9sQWVCxh7wKzVlll7bsvj54+WGXPqOlM3gO0v5Tc5pXMZOtG8cWW6ck2bEWTDWy6y+GrGb4nTSCEgk+SLo5lYECVzd9SEjq5Xhq3vfbTsHkkwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCOr+XMgtZ0zJcfoWo5RRmaTyhktuVgi3RNQ0HBGMSs=;
 b=NpPM6ryuW/YLSS+4NsBhnSlyzcAgtbgFQm+MZiiny9WnhNPTbqIV2GdVo0FbvKtIHVudYlXt8N+jKN4z4VSFS5eEinPIDKVsXvdsOmNfKcCxXZH9QbmkZlxvzI0VSHMBm7FCowNTJPSMSilrYpOab7YS2JIOfFlV1byjvQfrlcy6T7rrnMX0juXaOzj6XNNPVhdYu5hxqY9NiGOZubFEsdoKkJJ9csg1J54dX/2Y5E8FjS+xvhu4ylMayro2RKJaFBPH2yTTd4bsGb604yaLWoxN4qg360Jib/wuWKhRrun1wgzBSoC7ZShvHLJZbiG9abBAdvlFxoELr/QDFMrNUw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6637.apcprd06.prod.outlook.com (2603:1096:400:451::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 03:46:42 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%3]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 03:46:42 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: ftgmac100: Get link speed and duplex for NC-SI
Thread-Topic: [PATCH v2] net: ftgmac100: Get link speed and duplex for NC-SI
Thread-Index: AQHa9EIn1/7xh9LyY0ufG0shBDmnNbIz/PyAgAA0P8A=
Date: Fri, 23 Aug 2024 03:46:41 +0000
Message-ID:
 <SEYPR06MB5134C3B5487B03BB25D807B89D882@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20240822031945.3102130-1-jacky_chou@aspeedtech.com>
 <20240822172401.43fe8dd2@kernel.org>
In-Reply-To: <20240822172401.43fe8dd2@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6637:EE_
x-ms-office365-filtering-correlation-id: c2738354-37ca-42a5-2b1a-08dcc3263366
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?D9YeUSyUafwIGT0GcKDdpT7OJzSWLsylBeAd04MCLvl/jaHhXNE6G80iQPcg?=
 =?us-ascii?Q?KxD+2kcp9wIssnIcfY3IpsRAAzQIasOqfvvuVeyXXjTe3HXQuoryI5OKFdL9?=
 =?us-ascii?Q?9HDZDQpzBZ9qLEsnHUFHI1R323jKr14T1DOvMrosUpuoysxnsIi5GBwuHhpo?=
 =?us-ascii?Q?4gSsNsARPWsp02NHC8VocxgRz10Og294f/lOqWVTJeAz8Tz754ZWyVosAdDw?=
 =?us-ascii?Q?BZ/Pa/Ent0zb4/L6dlEvf4sXCfaRMKYQX0AU6PSX4FYfvMP0QE4ktrAxpGlh?=
 =?us-ascii?Q?69rs/Bssp94Pp8Aonzt7WGokxeZtuztrFbUXouFUYoe5OKjjcFsC3FcGzVVk?=
 =?us-ascii?Q?rxOFLN/93LQqiQHsNfq0jREU8wtQsBoCt24Mnnha6UuF1COImO/Ko/AEzqsy?=
 =?us-ascii?Q?UFlpAuMiTVj29Jv2mny8M/ukcwqG1t7OKW6s2+4SZsEOheDXUYYC3lxvZYmW?=
 =?us-ascii?Q?n/KgyAPumvmu5etKZQMtJq705kzz6MpQbSHToakt8AZHg9cUAPYZngeuq9e5?=
 =?us-ascii?Q?H2fps8G+JP4APOezqV6DitCt+ir4OGot4ftd/r9xITFd//vidXCOS4fibpCU?=
 =?us-ascii?Q?NzssBwZQB/7lWw5CozqGgkqq1xItrW5opMG4fNnQRqZrYL7+lFybky415Ymi?=
 =?us-ascii?Q?DIwT+BeQISMEk5y0+AchTRPmXiC5pOga8dtfCGRCuBoseanHwH/wEp/sx7wu?=
 =?us-ascii?Q?gT3gq1y7w2nxLCh95aynQ9yk9gRI+c0wdxznx/xV71Ws9YBGm4olOU0Ha6EK?=
 =?us-ascii?Q?FgY6sg4t4/aPAhGp6Tzk5wVllfZnGeXYhvLVybZBUvpTN03PYAvAaqPvwb2K?=
 =?us-ascii?Q?m2yr5V+sHHNiuCW+GGQizD/VFzDMPOsRrN3uZdD07I7hlFJkLaoi5x2cG1ZC?=
 =?us-ascii?Q?+qdA6ZFPoEdS5ksclLYLXGCqBmMM1szGplOctv5t15TqweENy5RdKc8zIGtz?=
 =?us-ascii?Q?B1mcHe7pWz+muPJX0VtoRN49rT+w7g/Fbq3nK86QGac7NR6FgMNhRkkrTlxc?=
 =?us-ascii?Q?2yx4p414jT3w6DcOWBTNWX8vMcxsawDln0+wX3K2Il2IwFvFir/6IXHa1Btf?=
 =?us-ascii?Q?2VArjla4sqxl/C1kb7wnQVQPFR+DW4AiyUedDfT0LMAq/D79LPNKfYbjlrCw?=
 =?us-ascii?Q?GAViZCH8SSj3YyhVMXGU2wQ5Asi3142y9laM3CUN1bWgl7kPAZ40Qt96swgq?=
 =?us-ascii?Q?FWhMJ6nC/9Ck2aftmtbG8yXGWOsN5xVsYi6E9CPQLMMEBPAo8Of7SNDoYqRe?=
 =?us-ascii?Q?XsZUzYh2t06bCI+9IhmFGJloLdsWcqTl1Ar03xScXdvyD7f2hSvnxP3drujq?=
 =?us-ascii?Q?k7YnWKzq7DZjORcEhI5TvpKt0vKT8rLXJDGoz3ACLR3mIYRRqONGek9gjGvi?=
 =?us-ascii?Q?SYsm1AtNZNrXalpalN7u5k45Gml1f/16uSqeZfJqAUvjHruEOw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VfDlgpD4fQCs7WAlPCpS5B6c9HjU3lvETfkZ1iilNucj/62p5RodEPFirLvt?=
 =?us-ascii?Q?4PDp4Zsqd3c8/ZxIFqL91hWsnhvJjvCZfy+N1JtmFXt4gPK3/MwTD//yVH1K?=
 =?us-ascii?Q?+bM6lBYt9NvL0AQ2dV+O5LDm3NkIiaIA75K/s9yTbtPsnnRaiOGzwt3Ff/jN?=
 =?us-ascii?Q?zsbSKtChc7rYh4l9DHGY7K3T0kHZPMxKpv146j1caBd2gtCO8bcJvJTswItr?=
 =?us-ascii?Q?cu4mdIz72nboZs/IKfhcYqA1ZM7YduKMRmRMrcv3LtsDCPQJ+Y+Zxk+oZ5rB?=
 =?us-ascii?Q?vrFmV2+7u81A3GRsbwAPz84oz+MCzt4aoLtpHHQak6UBP7+XdgfvHu/ygxHk?=
 =?us-ascii?Q?a//5FCU1T3Bzp20iEPEaZnch5wccSZDvq0GhQlvE11/xyqkIO+Ds/uybNcCf?=
 =?us-ascii?Q?f4NqRSABlq03O4+86rvW762uw+SHi1MuRhNNVmQKX7Yq7X+lYb/h6vfYjOzM?=
 =?us-ascii?Q?Efjk3co4m/lmPaah8KTI7AVRC6I9xN2ng31w6XO0ky38SNx1Gb/dHKxpcZar?=
 =?us-ascii?Q?tEZE2gg2P2tuFrRhcQ6FMr28nfyaUEhADjGTrm5OPgQy97DI1alpsT2kGjW/?=
 =?us-ascii?Q?RTAju/hz6cqNa++pWGndyr03mzII56SXqv+8Tpzrnx6+j30S3GSzC2CfLKJw?=
 =?us-ascii?Q?igD6kx9UGdG5RezumKlC1fJdw7/RyposkjZSrauWJZm1D1uot5Qykpp1gwtF?=
 =?us-ascii?Q?A+FgGwR2BghqmtSEWFfFH+nJpwnbvBVMVdY/QRNgfqHL8Fd5GBW9or3gAsi+?=
 =?us-ascii?Q?SCXYPDf5nqCgHwmrjYZbywB3sj3ezPsCXmp/BDnlzRzzTjDytB9EJjEV1lRm?=
 =?us-ascii?Q?9TdUV6vn+kggCYlX/7EiIM8AK999efydroS2iNkDxQQ1gIqHnPU3VhbaRec0?=
 =?us-ascii?Q?snR7rj82ol1wbueFrSOfMRS/UpQss7HTjVM3HqRkmOqpEnKhhIbSCI2n3JsY?=
 =?us-ascii?Q?PDfl7kmvRWib21pY/YNK6Sw83ALXe4PqWgdaQ0g+9AoXXrZuPKa/m8BpYYgB?=
 =?us-ascii?Q?lmUQ6PEMlN0z7ChuU0bTU8fb3JT+JxLTbHC2LMqoB9dn9eF1kmeg6mXImzwV?=
 =?us-ascii?Q?sTl92txv+dCc70kV6HfviCI3+GsZWCwCP6EQiafpyGzI2hGSuRXngQauj380?=
 =?us-ascii?Q?beO41dbIQySkc4mugGzytzuwOKYbpXkUcYLtelNpdowj0jx37nSsLap+FxNj?=
 =?us-ascii?Q?vBxvwRjGwIfA+2oW9t9YhDzRkExVAdE3Y4knsL2UK3aIPxDGme4Ik96mFr1U?=
 =?us-ascii?Q?AXBhAFPJY8VoKZhrbot1BPtxo3oo62gB/EubJnuiKxDO76o+nhmPr1nm2b9G?=
 =?us-ascii?Q?6zDNA7n56yWflR13Mc/NhrJ/ef5A4wHYuVs1yGBRkKHMIjA0x/I+y5A6ijpu?=
 =?us-ascii?Q?t/yp7sppjqTGLvwyw/9kPcJ2rmDUF/jiftJvKZCD5S+zwE75xsEtSggNIqky?=
 =?us-ascii?Q?bQ+0swj2+CTBtQE0E0U4Xh0H6HY63matoII0kQ6mcdWNz6V1QQocd5Is3vNY?=
 =?us-ascii?Q?smE8qmlaNROpUpdAcv8t2uQ2blXjHGOws+emsCASmc3C4m63Hjx0lqjqEmsO?=
 =?us-ascii?Q?uaPn/oGpAhHrZ7OETeaV0d6gHmtZEJqAgBBvr+Gt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2738354-37ca-42a5-2b1a-08dcc3263366
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 03:46:41.7882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbLXiev8+TD8FtBh2YzVk+Ir1lS5KR/g13KBfVttwJsxAo6DZT2lYyK1xIgY0MbvvcE4vxFW5gj5OomUH+NeP38ztGdPHt7zUkBFNNJHDdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6637

> > The ethtool of this driver uses the phy API of ethtool to get the link
> > information from PHY driver.
> > Because the NC-SI is forced on 100Mbps and full duplex, the driver
> > connects a fixed-link phy driver for NC-SI.
>=20
> replace: the driver connects -> connect
I will refine the commit message.

>=20
> > The ethtool will get the link information from the fixed-link phy
> > driver.
>=20
> Hm. I defer to the PHY experts on the merits.
>=20
> > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> > ---
> > v2:
> >   - use static for struct fixed_phy_status ncsi_phy_status
> >   - Stop phy device at net_device stop when using NC-SI.
> >   - Start phy device at net_device start when using NC-SI.
> > ---
> >  drivers/net/ethernet/faraday/ftgmac100.c | 24
> > ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > b/drivers/net/ethernet/faraday/ftgmac100.c
> > index fddfd1dd5070..93862b027be0 100644
> > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/of_net.h>
> >  #include <net/ip.h>
> >  #include <net/ncsi.h>
> > +#include <linux/phy_fixed.h>
>=20
> Keep the headers sorted, put the new one after of_net.h
Agree. I will adjust the <linux/phy_fixed.h> header.

>=20
> >  #include "ftgmac100.h"
> >
>=20
> > @@ -1794,6 +1805,7 @@ static int ftgmac100_probe(struct platform_device
> *pdev)
> >  	struct net_device *netdev;
> >  	struct ftgmac100 *priv;
> >  	struct device_node *np;
> > +	struct phy_device *phydev;
>=20
> keep the variable declarations sorted longest to shortest if possible
Agree. I will change the variable next version.

>=20
> >  	int err =3D 0;
> >
> >  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0); @@ -1879,6
> > +1891,14 @@ static int ftgmac100_probe(struct platform_device *pdev)
> >  			err =3D -EINVAL;
> >  			goto err_phy_connect;
> >  		}
> > +
> > +		phydev =3D fixed_phy_register(PHY_POLL, &ncsi_phy_status, NULL);
> > +		err =3D phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
> > +					 PHY_INTERFACE_MODE_MII);
> > +		if (err) {
> > +			dev_err(&pdev->dev, "Connecting PHY failed\n");
> > +			goto err_phy_connect;
> > +		}
>=20
> Very suspicious that you register it but you never unregister it.
> Are you sure the error path and .remove don't need to be changed?
Agree. It needs the unregister for the PHY device.
When using NC-SI to register fixed-link PHY device, I wiil add the=20
unregister function in ftgmac100_phy_disconnect().
Thanks.

