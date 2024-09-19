Return-Path: <netdev+bounces-128951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238BC97C8DB
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 14:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4880A1C20947
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 12:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A598C1993AD;
	Thu, 19 Sep 2024 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DK6Wnnlo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A311990CF;
	Thu, 19 Sep 2024 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747487; cv=fail; b=rLcE6qs84v+Hz0p46PrPENMmmcghI5BlwW535o6lfApQIyFxxNGBtd5cnZLkEXr7Udh/mS90A65eC3gDWN0UyAOKIBS2kDlqaW7mAQu/hxIYMLozeCPR+3vBTMEjR1Ho9KTsjvjEumNBAwnVTUu1BhcASNjIBeTNVGNafZ3vF3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747487; c=relaxed/simple;
	bh=kzO2LScQwigT7a7nqNxTaR779vYeHC1Tx/nC41bvMM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lLSjfK0NEUzmM3XEcUqTpD95pvwT2GWowhyNA3PV5hqjCRnn8a++bNqrNi7M0u/Wc6eHxQXf1xkT7I6eR+PYImx/5wXGjauGbXLdBFjAxRIuQySIlSu7jhmBpoQqv8dKvlFyjMEk1CVXWo1AVt8FSSrgImkqlrospoA6TtUNSZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DK6Wnnlo; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uqi8pRL0K5T4jlAdPnv8Qpqu8D76sN/6bC8KgV2G/gbhr9m2bVS8kxQ7H4qLi7pbTH6rrBJg8LUv+UbZx/Kbf/Htpo0kyRXtQS6uzjwkDzfDH56EfuNSMROdnu4p/w8I7StvG24jicZunQ6Xl/AQIjdoEAGYVeuvFnRjiXJqfIm5yLN78URfVpkeScWSGKo17PBzIxhmDVOLypJ1AxZoMV/I95TEbdn6blpiLOxLZd6hMKYMN21XEIrYpOHkUxRS7mrofF8vN65FcXV5Gdb4krHjRCOQ8XXr8NZvfYUfTY6dor5t4pe5CnEAQpl1jGIwnwwzMeU67vmfET/6EAXm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgrtSqSl4hIHEV309MXMDaZHAgAfEtnyJH6qoOqpcao=;
 b=QvHQda15HRgP9vzBIZkCLbYhvzJ27jUz7LPYTrMWZPP2NDoZhJ+RYRbH9kMFP6BWK8LJKQIUF7ts0CvI9doxbMiIz047Ipfa6/xRl+3gJ2q2vthwvtrcqxyGNetY3MHyIMKls7/CBo9qDp8Yx1FIhcoF9LwOA6Pkvw5Qa7JNTMpLLbf6r9HWlvBR4rVox2SFuQMioD5V218L5lU8R/0g4qb0ehksOTS/kW41PFz8VLjvk+H4bxNN+j9stKBfNZzTEzNpsB79xpi+NMiBcOJUrhMttNVghtYJ6S43rbmNrz9GiIlaAKE4abKMJRyvplFp+Qkyv+VxqZrAKuqivBMldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgrtSqSl4hIHEV309MXMDaZHAgAfEtnyJH6qoOqpcao=;
 b=DK6WnnloMkbaxmCRv51u9Ty0fnPq8jcfovY8pRX4NDNpxUVlbWclCtJNvzsMVww1x1MBIzsnflNlR2p2hu1PIi6dXSg9/EOUv3r3FFzQ6up72S3hRHFstwZfk+6AKe2N834fVEdb31blgSq5zKjFJQpcllwa26RW0jFTNLedURiUSq7SB6oBGVbAxVf5HeRiifqK9m2Q8OhBNWvbOuabAstLkZoG6QW783yFSTzk+HaHgzZGJ2BPAgqgF2pf8RiL1dpwZ1Udsq0Ho050SKnE1bB+csW2r8wF6PB5t1zntnoHvTx5JmFD/KAMPa9twwndYI0kiny6t1V6Wioi413qDA==
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 BY1PR11MB8006.namprd11.prod.outlook.com (2603:10b6:a03:52d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 12:04:38 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 12:04:38 +0000
From: <Tarun.Alle@microchip.com>
To: <linux@armlinux.org.uk>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next V4] net: phy: microchip_t1: SQI support for
 LAN887x
Thread-Topic: [PATCH net-next V4] net: phy: microchip_t1: SQI support for
 LAN887x
Thread-Index: AQHbCPloJPya9IPhQki3fxOwbliPerJcCemAgAL7zUA=
Date: Thu, 19 Sep 2024 12:04:38 +0000
Message-ID:
 <DM4PR11MB623907EC9F1C76CC7F14D3588B632@DM4PR11MB6239.namprd11.prod.outlook.com>
References: <20240917115657.51041-1-tarun.alle@microchip.com>
 <ZumSKSI6vMfR61wP@shell.armlinux.org.uk>
In-Reply-To: <ZumSKSI6vMfR61wP@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6239:EE_|BY1PR11MB8006:EE_
x-ms-office365-filtering-correlation-id: fc2dfb44-a161-4917-2ad9-08dcd8a33c48
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cvoGEZOU++a7l0pqCCy7tdFxuQfmDx/yDOYlfsvdCiOQfDrhxystjfNbSLbH?=
 =?us-ascii?Q?NV+Sv6gCfsTvSrDw4vWciByczxX9sa7lLNUIafXuodpLNOfLXXgJz+O01jO4?=
 =?us-ascii?Q?KOShFLDbv+JSvqxHz9WyjifPgB63vW9g0rSnhWvYWjhRTYqviXOoV3w+Zc9S?=
 =?us-ascii?Q?Q8RCRcfJlaYFApk/q0DM9NJUPCJ/4Ikr66VZ60MbUJfj3W7/6/PfG1RhcawP?=
 =?us-ascii?Q?mz/4yhsY7SxNCm8qPyvJnnHDVuRi+D2eZsEASQYrJ7V+Oro6i2IyUx75cbFu?=
 =?us-ascii?Q?yfX7IUIhsFi91nnB0z41AU5Zi0+4gG9malvaqgOh63cKengIyPwgW12BqDOW?=
 =?us-ascii?Q?ipzDQyXf4+SYfBxSbYk7mF1fLiK+VCYZ3frQqXkLZ7gNuxavE4N6lkwPzu4a?=
 =?us-ascii?Q?Qxg7wAPsT+BR7HSWcuqrl755Jb6KF6mzS033fQmh9PZ/+/oJgAzgEfZBAvSc?=
 =?us-ascii?Q?Z1GNLG1xxYjU92wEC3cRIea52naJw+QuyXmYFU56JVw1EG7JSviDGq8OPFFK?=
 =?us-ascii?Q?SBGSeEAkNYO9A/+hHKo2iJhkXCh73ZbTWFvOiwdaXZHJ/a7l5QRLVlx/epPB?=
 =?us-ascii?Q?WSifqOOGsjnZ25LbKOqp0BApZTQhtxt8tgNBNzOox5EwpaaBbQnDEJ1IvqIv?=
 =?us-ascii?Q?g32G9YGOb9QyCy7np21K6YuUefLtrDSoI0TfCR/soATR9bEqIOx4pJb7y1C4?=
 =?us-ascii?Q?MXIX60KNTvtwQyYxGwsT3KZb+C/SRaCXVyNqd4DelIf4+xaS01tcgW8crni4?=
 =?us-ascii?Q?Nu43RvSoP/sSUxieGGu6/ifAxiALZrUr7ElOYeWqhCJBxf8ZWgjRw8T06VLj?=
 =?us-ascii?Q?UxJ+6z49xX7G8c4OEplvBgB8wxpzSMtShSDVSpVzVR9Pj1jwBxgU2OM19l+f?=
 =?us-ascii?Q?vGAUYzSHbHpOxIHT1tHMTtrL//1LFniFy081ilWGHSn2ilo9dKBPcVVvecdF?=
 =?us-ascii?Q?rGFXZBJiI2le9CvRbG6mzzNdLjXVk8mHTUTGp1KpdKXO8TK3sI3q6Ld2kTVi?=
 =?us-ascii?Q?pC5ZsGzrnKkD17HF+o12gVGQxqSyMaUe+UoOFE0y7HV/Vh0eU8pTJCwi6vbk?=
 =?us-ascii?Q?p7X7RW4eM2ZoVy5FrEzRXoSF1+TJEZVKSicEsS50hGdkOw3UmNcjp2oLoEn1?=
 =?us-ascii?Q?mPw86nGGn5ZTNkG0zTAbUvQvbrQb/d7SOehuqZmbRHgRs3GelKZZbrumwIcB?=
 =?us-ascii?Q?bRj4U5uFc2qtW2/aSudRlcwWNu5x1453ckg/w7e5RZ/wJGRXrSCzRT/4xF8k?=
 =?us-ascii?Q?n7rcjJQWLwOfBD1mEvoll3ATLUaA1DP21F7BUjVLVxuK1t/lt0kEnqUMZ8sD?=
 =?us-ascii?Q?JBr+8nX/v0Bqf1Xt4adwE4pWZnVNuCK2KZZXSf6pxQDS6FQzdGg4st2VgRWD?=
 =?us-ascii?Q?JxvRcWo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?awOsy0uNwaevo5E209HxJvLw3eKvhJPKTjUtHDP71zN8o/bOsj7bYH5GHYb8?=
 =?us-ascii?Q?wLter8YYElv+mvQmC4f2HowLOkwZY7OAkZTGE0JfA0XQCSd+cSfjU1r5EW+K?=
 =?us-ascii?Q?4wy5MSKCUHm6ps4oJm1IOvvGVwWf146MQwG9ZU52ISfPtl7DjQPfy7hrejWL?=
 =?us-ascii?Q?nh47ztdKGkkiSEytWlecZjyN8oqiDDQV5y5uAu1w1gZYXDKACWNqFgRseG59?=
 =?us-ascii?Q?P0AoR1CpT/olEavFJrJAMEtbHpx+Y5j/N7XV5lvdOTl8Z8R390WoXlpcDtPB?=
 =?us-ascii?Q?/XAUD3x+vaNzmXcKMHL6+VYTxjchFPH1hmNWFKhDma3TIRgd8+/gk8rQtvr4?=
 =?us-ascii?Q?VLVE3Ex/cUaV/6oSxjdEZB86kJu4DZapUqBnj943NZbafVs64PMpAfAugvIB?=
 =?us-ascii?Q?GvEl8HCt2ncVnN1WgH3WtgDyGoo0gkJR6rHkzc293aHmw1ZScKtyzUXnAqtr?=
 =?us-ascii?Q?VChpogYqPGLUTVM/4Im3AvbZneW/o5tzslUzM6Re7Tpx0+KeKisnF+My7cxV?=
 =?us-ascii?Q?km/PAaN9kdChmGI0lV3a7WHA+SMaN0OwaASVuXbl4GdTxFI7cV7KJtJkv0AT?=
 =?us-ascii?Q?6CSiaQG1xC4RbtOCzVXAG0w7lKle66QAw5GN+762x/9A0tMeE6fLOD1zDoxi?=
 =?us-ascii?Q?S7lie2Xot5GOjsmtCIMzcKIUDJySw59R6/bCx1QPu57yxqYMH3jQHtrVK8cM?=
 =?us-ascii?Q?jPrqn88ZNLsBKy/B5h9gs8y8S8GMgBq87cPPYT4MEWwUDUnGS7DmUMfGl3jQ?=
 =?us-ascii?Q?h1PEasumZA44bwqStnllfwj6hzpUAx16s1IQFbgfcxhbqMANh870uw8XAujJ?=
 =?us-ascii?Q?Qrrd1XJ701g+9qyAOqy5LVoGdQgzG7ZXc3lpbvYdbdr1nNhIZSt/t/7ZoXnf?=
 =?us-ascii?Q?QMt32vdkJPv9EncdQqKQfXnb4LUjN/pFeYBfgVxWRY+0PG2kYyYgWqbPn3Pj?=
 =?us-ascii?Q?MiyIM6nawcmGiWdS44wR+79IyOTEHjoJ/PYHtpyVf/XsGiXDaV2J2W9XppIK?=
 =?us-ascii?Q?qh0d57qg6r8KI6dJbthUWKDg1iPEIp9fPvVp90/KK+sQwzoxqVKQio0VwWu5?=
 =?us-ascii?Q?TAqzeFfRlVKhM4UsiUf6wAZRM+gDVn70CPPNWj/48oulIRvW1TGwI1qu2cWi?=
 =?us-ascii?Q?bq/odbIfr9vHyvW+H5EqLv54+lfVMFKIC9eJYFWA3/iHDMz/dtZl2EfS0RR5?=
 =?us-ascii?Q?BmXnjGX+acdCeOotWvjXn0nrkOXcmOG3+JOUlVMGbO9+7jll6aaKxoErHlpm?=
 =?us-ascii?Q?RKYSXhpGXQ6LDBDjWyHUMqT7MS2sXi0b9DNRApc1NLnlBjz18MC6UOrDiius?=
 =?us-ascii?Q?xS/K6NqtEuJcqVRZEb6OhsnmJ3pRSpFVMfU3UAUWpvy5KMNk2OeQPy7qexaO?=
 =?us-ascii?Q?PPO0ieA0cnU4Pnx0biDtCaOi1KMq+4oNzaBZ6S5xn4dLdbfpGBaU3RCjAybU?=
 =?us-ascii?Q?RJNAgqpRzaeaaGGy8HhEvdV96PuzZ0+IXIwWr1pdWt+Xo/rbdDoFoIlf6+aY?=
 =?us-ascii?Q?ZekqNrpJlICZj0fk9ANCNafycvVyYF7WA9ZEhZUPpC178ibnMINn2WvCyd3V?=
 =?us-ascii?Q?bxiMTiSkK786LpX+59kVIGBGgfGj/fbnlNR76kDY?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2dfb44-a161-4917-2ad9-08dcd8a33c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 12:04:38.2063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G1f03q5Ku8UYleRCkP8P/a1LJgNIxeYAm8K6jhVtfqv+1B9u891fgK1RZTdKz2wd+RJ9SwqdX26F1TU8M+vivMOT7nDcP3/CCIVNKSbC3E8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8006

Hi Russell,
Thanks for your review comments. Will fix in the next version.

> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Tuesday, September 17, 2024 7:59 PM
> To: Tarun Alle - I68638 <Tarun.Alle@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; andrew@lunn.ch;
> hkallweit1@gmail.com; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next V4] net: phy: microchip_t1: SQI support for
> LAN887x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Tue, Sep 17, 2024 at 05:26:57PM +0530, Tarun Alle wrote:
> > From: Tarun Alle <Tarun.Alle@microchip.com>
> >
> > Add support for measuring Signal Quality Index for LAN887x T1 PHY.
> > Signal Quality Index (SQI) is measure of Link Channel Quality from
> > 0 to 7, with 7 as the best. By default, a link loss event shall
> > indicate an SQI of 0.
> >
> > Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>
>=20
> Please note that the merge window is open, which means that net-next is
> currently closed. Thus, patches should be submitted as RFC.
>=20
> > ---
> > v3 -> v4
> > - Added check to handle invalid samples.
> > - Added macro for ARRAY_SIZE(rawtable).
> >
> > v2 -> v3
> > - Replaced hard-coded values with ARRAY_SIZE(rawtable).
> >
> > v1 -> v2
> > - Replaced hard-coded 200 with ARRAY_SIZE(rawtable).
>=20
> Hmm. We've been through several iterations trying to clean this up into
> something more easily readable, but I fear there'll be another iteration.
>=20
> Maybe the following would be nicer:
>=20
> enum {
>         SQI_SAMPLES =3D 200,
>         /* Look at samples of the middle 60% */
>         SQI_INLIERS_NUM =3D SQI_SAMPLES * 60 / 100,
>         SQI_INLIERS_START =3D (SQI_SAMPLES - SQI_INLIERS_NUM) / 2,
>         SQI_INLIERS_END =3D SQI_INLIERS_START + SQI_INLIERS_NUM, };
>=20
> > +static int lan887x_get_sqi_100M(struct phy_device *phydev) {
> > +     u16 rawtable[200];
>=20
>         u16 rawtable[SQI_SAMPLES];
>=20
> > +     u32 sqiavg =3D 0;
> > +     u8 sqinum =3D 0;
> > +     int rc;
>=20
> Since you use "i" multiple times, declare it at the beginning of the func=
tion
> rather than in each for loop.
>=20
>         int i;
>=20
> > +
> > +     /* Configuration of SQI 100M */
> > +     rc =3D phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +                        LAN887X_COEFF_PWR_DN_CONFIG_100,
> > +                        LAN887X_COEFF_PWR_DN_CONFIG_100_V);
> > +     if (rc < 0)
> > +             return rc;
> > +
> > +     rc =3D phy_write_mmd(phydev, MDIO_MMD_VEND1,
> LAN887X_SQI_CONFIG_100,
> > +                        LAN887X_SQI_CONFIG_100_V);
> > +     if (rc < 0)
> > +             return rc;
> > +
> > +     rc =3D phy_read_mmd(phydev, MDIO_MMD_VEND1,
> LAN887X_SQI_CONFIG_100);
> > +     if (rc !=3D LAN887X_SQI_CONFIG_100_V)
> > +             return -EINVAL;
> > +
> > +     rc =3D phy_modify_mmd(phydev, MDIO_MMD_VEND1,
> LAN887X_POKE_PEEK_100,
> > +                         LAN887X_POKE_PEEK_100_EN,
> > +                         LAN887X_POKE_PEEK_100_EN);
> > +     if (rc < 0)
> > +             return rc;
> > +
> > +     /* Required before reading register
> > +      * otherwise it will return high value
> > +      */
> > +     msleep(50);
> > +
> > +     /* Link check before raw readings */
> > +     rc =3D genphy_c45_read_link(phydev);
> > +     if (rc < 0)
> > +             return rc;
> > +
> > +     if (!phydev->link)
> > +             return -ENETDOWN;
> > +
> > +     /* Get 200 SQI raw readings */
> > +     for (int i =3D 0; i < ARRAY_SIZE(rawtable); i++) {
>=20
>         for (i =3D 0; i < SQI_SAMPLES; i++) {
>=20
> > +             rc =3D phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +                                LAN887X_POKE_PEEK_100,
> > +                                LAN887X_POKE_PEEK_100_EN);
> > +             if (rc < 0)
> > +                     return rc;
> > +
> > +             rc =3D phy_read_mmd(phydev, MDIO_MMD_VEND1,
> > +                               LAN887X_SQI_MSE_100);
> > +             if (rc < 0)
> > +                     return rc;
> > +
> > +             rawtable[i] =3D (u16)rc;
> > +     }
> > +
> > +     /* Link check after raw readings */
> > +     rc =3D genphy_c45_read_link(phydev);
> > +     if (rc < 0)
> > +             return rc;
> > +
> > +     if (!phydev->link)
> > +             return -ENETDOWN;
> > +
> > +     /* Sort SQI raw readings in ascending order */
> > +     sort(rawtable, ARRAY_SIZE(rawtable), sizeof(u16), data_compare,
> > + NULL);
>=20
>         sort(rawtable, SQI_SAMPLES, sizeof(u16), data_compare, NULL);
>=20
> Although renaming data_compare to sqi_compare would be even more
> descriptive of what it's doing.
>=20
> > +
> > +     /* Keep inliers and discard outliers */
> > +     for (int i =3D SQI100M_SAMPLE_INIT(5, rawtable);
> > +          i < SQI100M_SAMPLE_INIT(5, rawtable) * 4; i++)
>=20
>         for (i =3D SQI_INLIERS_START; i < SQI_INLIERS_END; i++)
>=20
> > +             sqiavg +=3D rawtable[i];
> > +
> > +     /* Handle invalid samples */
> > +     if (sqiavg !=3D 0) {
> > +             /* Get SQI average */
> > +             sqiavg /=3D SQI100M_SAMPLE_INIT(5, rawtable) * 4 -
> > +                             SQI100M_SAMPLE_INIT(5, rawtable);
>=20
>                 sqiavg /=3D SQI_INLIERS_NUM;
>=20
> Overall, I think this is better rather than the SQI100M_SAMPLE_INIT() mac=
ro...
> for which I'm not sure what the _INIT() bit actually means.
>=20
> I think my suggestion has the advantage that it makes it clear what these
> various calculations are doing, because the result of the calculations is
> described in the enum name.
>=20
> Thanks.
>=20
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thanks,
Tarun Alle.

